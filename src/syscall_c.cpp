#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void* interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callIntertupt() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    asm volatile("ecall");

    void* res;
    asm volatile("ld %0, a0" : "=r" (res));
    return res;
}

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    if(scause == 8) { // sistemski poziv iz korisnickog rezima
        uint64 code;
        asm volatile("ld %0, a0" : "=r" (code));
        switch(code) {
            case 0x1: // mem_alloc(size_t size)
            {
                size_t size = 0;
                asm volatile("ld %0, a1" : "=r" (size));
                size = MemoryAllocator::blocksInSize(size);
                return MemoryAllocator::mem_alloc(size);
            }
            case 0x2: // mem_free(void* memSegment)
            {
                void* memSegment = nullptr;
                asm volatile("ld %0, a1" : "=r" (memSegment));
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
            }
            default:
                return nullptr;
        }
    }

    return nullptr;
}

void* mem_alloc(size_t size) {
    uint64 code = 0x01; // kod sistemskog poziva
    asm volatile("sd a0, %0" : : "r" (code));
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size);
    asm volatile("sd a1, %0" : : "r" (size));

    return callIntertupt();
}

int mem_free (void* memSegment) {
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("sd a0, $0" : : "r" (code));

    return (uint64)(interrupt());
}



