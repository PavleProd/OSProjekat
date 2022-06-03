#include "../h/kernel.h"
#include "../h/PCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"
#include "../h/CCB.h"
#include "../h/syscall_c.h"
void Kernel::popSppSpie() {
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    asm volatile("sret");
}

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    size_t volatile scause = Kernel::r_scause();
    size_t volatile sepc = Kernel::r_sepc();
    size_t volatile sstatus = Kernel::r_sstatus();
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
        sepc += 4; // da bi se sret vratio na pravo mesto
        size_t volatile code = PCB::running->registers[10]; // a0
        switch(code) {
            case Kernel::sysCallCodes::mem_alloc: // mem_alloc(size_t size) a1 - size
            {
                size_t size = PCB::running->registers[11];
                size = MemoryAllocator::blocksInSize(size);

                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
                break;
            }
            case Kernel::sysCallCodes::mem_free: // mem_free(void* memSegment) a1 - memSegment
            {
                void* memSegment = (void*)PCB::running->registers[11];
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
                break;
            }
            case Kernel::sysCallCodes::thread_dispatch:
            {
                PCB::timeSliceCounter = 0;
                PCB::dispatch();
                break;
            }
            case Kernel::sysCallCodes::thread_exit:
            {
                PCB::running->finished = true;
                PCB::timeSliceCounter = 0;
                PCB::dispatch();
                PCB::running->registers[10] = (size_t)0;
                break;
            }
            case Kernel::sysCallCodes::thread_start: // a1 - handle
            {
                PCB **handle = (PCB **) PCB::running->registers[11];
                Scheduler::put(*handle);
                break;
            }
            case Kernel::sysCallCodes::thread_create: // a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
            {
                // argumenti
                PCB::processMain main = (PCB::processMain)PCB::running->registers[12];
                void *arg = (void*)PCB::running->registers[13];

                PCB **handle = (PCB**)PCB::running->registers[11];
                *handle = PCB::createProccess(main, arg);

                // stavljamo handle u a0 (verovatno vec jeste ali za svaki slucaj)
                PCB::running->registers[10] = (size_t)handle;

                if(*handle == nullptr) break;
                // dodeljujemo alociran stek procesu
                size_t* stack = (size_t*)PCB::running->registers[14];
                (*handle)->stack = stack;
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)

                break;
            }
            case Kernel::sysCallCodes::sem_open: // a1 = handle a2 = init
            {
                SCB **handle = (SCB**) PCB::running->registers[11];
                size_t init = (int) PCB::running->registers[12];

                (*handle) = SCB::createSemaphore(init);

                PCB::running->registers[10] = (size_t)handle;
                break;
            }
            case Kernel::sysCallCodes::sem_wait: // a1 = sem
            {
                SCB* sem = (SCB*) PCB::running->registers[11];

                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
                break;
            }
            case Kernel::sysCallCodes::sem_signal: // a1 = sem
            {
                SCB* sem = (SCB*) PCB::running->registers[11];

                sem->signal();
                break;
            }
            case Kernel::sysCallCodes::sem_close: // a1 = sem
            {
                SCB* sem = (SCB*) PCB::running->registers[11];

                sem->signalClosing();
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan

                break;
            }
            case Kernel::sysCallCodes::time_sleep: // a1 = time
            {
                size_t time = (size_t)PCB::running->registers[11];
                PCB::running->timeSleeping = time;
                SleepingProcesses::putToSleep(PCB::running);
                break;
            }
            case Kernel::sysCallCodes::putc: // a1 = character
            {
                char character = PCB::running->registers[11];
                CCB::outputBuffer.pushBack(character);
                CCB::semOutput->signal();
                break;
            }
            case Kernel::sysCallCodes::getc:
            {
                CCB::semInput->signal();
                while(CCB::inputBuffer.peekFront() == 0) {
                    CCB::inputBufferEmpty->wait();
                }

                PCB::running->registers[10] = CCB::inputBuffer.popFront();
                break;
            }
            case Kernel::sysCallCodes::userMode:
            {
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
                break;
            }
            default:
                break;
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
        PCB::timeSliceCounter++;
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
            PCB::timeSliceCounter = 0;
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
        size_t code = plic_claim();
        if(code == CONSOLE_IRQ) {
            if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) { // putc
                //if(CCB::semOutput->getSemValue() == 0) plic_complete(code);
            }
            if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) { // getc
                //if(CCB::semInput->getSemValue() == 0) plic_complete(code);
            }
        }
        else {

        }
        plic_complete(code);


    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
    }

}

