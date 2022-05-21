#include "../h/kernel.h"
#include "../h/PCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"

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
        size_t code = PCB::running->registers[10]; // a0
        switch(code) {
            case Kernel::sysCallCodes::mem_alloc: // mem_alloc(size_t size) a1 - size
            {
                size_t size = PCB::running->registers[11];
                size = MemoryAllocator::blocksInSize(size);

                MemoryAllocator::mem_alloc(size);
                break;
            }
            case Kernel::sysCallCodes::mem_free: // mem_free(void* memSegment) a1 - memSegment
            {
                void* memSegment = (void*)PCB::running->registers[11];
                MemoryAllocator::mem_free(memSegment);
                break;
            }
            case Kernel::sysCallCodes::thread_dispatch:
                PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
                PCB::timeSliceCounter = 0;
                break;
            case Kernel::sysCallCodes::thread_create: // a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
            {
                // argumenti
                PCB::processMain main = (PCB::processMain)PCB::running->registers[12];
                void *arg = (void*)PCB::running->registers[13];

                PCB **handle = (PCB**)PCB::running->registers[11];
                *handle = PCB::createProccess(main, arg);

                // dodeljujemo alociran stek procesu
                size_t* stack = (size_t*)PCB::running->registers[14];
                (*handle)->stack = stack;
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)

                // stavljamo handle u a0 (verovatno vec jeste ali za svaki slucaj)
                asm volatile("mv a0, %0" : : "r" (handle));

                break;
            }
            default:
                printError();
                break;
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
        PCB::timeSliceCounter++;
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {

            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
            PCB::timeSliceCounter = 0;
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    }

}

