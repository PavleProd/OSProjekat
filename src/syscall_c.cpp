#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"
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

int thread_create (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    *handle = PCB::createProccess((PCB::processMain)startRoutine, arg);
    if(*handle == nullptr) {
        return -1;
    }
    return 0;
}




