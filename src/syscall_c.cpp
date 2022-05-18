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
    size_t code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0

    return (void*)callInterrupt();
}

int mem_free (void* memSegment) {
    size_t code = 0x02; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code

    return (size_t)(callInterrupt());
}

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    size_t scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
        size_t code;
        asm volatile("mv %0, a0" : "=r" (code));
        switch(code) {
            case 0x1: // mem_alloc(size_t size)
            {
                size_t size = 0;
                asm volatile("mv %0, a1" : "=r" (size));
                size = MemoryAllocator::blocksInSize(size);

                MemoryAllocator::mem_alloc(size);
            }
            case 0x2: // mem_free(void* memSegment)
            {
                void* memSegment = nullptr;
                asm volatile("mv %0, a1" : "=r" (memSegment));
                MemoryAllocator::mem_free(memSegment);
            }
            break;
            default:
                printError();
                break;
        }
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
        PCB::timeSliceCounter++;
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
            size_t sepc = Kernel::r_sepc(); // TODO: pogledaj sta se desava ako se ne sacuva sepc
            size_t sstatus = Kernel::r_sstatus();
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



