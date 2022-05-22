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

// a0 code a1 size
void* mem_alloc(size_t size) {
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0

    return (void*)callInterrupt();
}

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code

    return (size_t)(callInterrupt());
}

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    asm volatile("mv a2, a1"); // a2 = startRoutine
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1

    size_t* stack = new size_t[DEFAULT_STACK_SIZE]; // pravimo stack procesa
    if(stack == nullptr) return -1;

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    asm volatile("mv a4, %0" : : "r" (stack));
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code

    handle = (thread_t*)(callInterrupt()); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    if(*handle == nullptr) {
        return -1;
    }
    return 0;
}

int thread_create(thread_t* handle, void(*startRoutine)(void*), void* arg) {
    int res = thread_create_only(handle, startRoutine, arg);
    thread_start(handle);
    return res;
}

void thread_dispatch () {
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    callInterrupt();
}

int thread_exit () {
    size_t code = Kernel::sysCallCodes::thread_exit;
    asm volatile("mv a0, %0" : : "r" (code));
    return (size_t)(callInterrupt());
}

void thread_start(thread_t* handle) {
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    callInterrupt();
}


