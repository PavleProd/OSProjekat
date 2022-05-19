#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"
#include "../h/kernel.h"
#include "../h/PCB.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    void* res;
    asm volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (res));
    return res;
}

void* mem_alloc(size_t size) {
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0

    return (void*)callInterrupt();
}

int mem_free (void* memSegment) {
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code

    return (size_t)(callInterrupt());
}

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    size_t scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    size_t volatile sepc = Kernel::r_sepc(); // TODO: pogledaj sta se desava ako se ne sacuva sepc
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



