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
    size_t scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    size_t volatile sepc = Kernel::r_sepc();
    size_t volatile sstatus = Kernel::r_sstatus();
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
        sepc += 4; // da bi se sret vratio na pravo mesto
        size_t code;
        asm volatile("mv %0, a0" : "=r" (code));
        switch(code) {
            case Kernel::sysCallCodes::mem_alloc: // mem_alloc(size_t size)
            {
                size_t size = 0;
                asm volatile("mv %0, a1" : "=r" (size));
                size = MemoryAllocator::blocksInSize(size);

                MemoryAllocator::mem_alloc(size);
                break;
            }
            case Kernel::sysCallCodes::mem_free: // mem_free(void* memSegment)
            {
                void* memSegment = nullptr;
                asm volatile("mv %0, a1" : "=r" (memSegment));
                MemoryAllocator::mem_free(memSegment);
                break;
            }
            case Kernel::sysCallCodes::thread_dispatch:
                PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
                PCB::timeSliceCounter = 0;
                break;
            default:
                printError();
                break;
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
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

