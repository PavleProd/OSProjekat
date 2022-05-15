#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void* interrupt();
void* callIntertupt() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    asm volatile("ecall");

    void* res;
    asm volatile("ld %0, a0" : "=r" (res));
    return res;
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

