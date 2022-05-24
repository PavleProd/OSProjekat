#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"
#include "../h/kernel.h"
#include "../h/PCB.h"
#include "../h/console.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt(size_t volatile code) {
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

    return (void*)callInterrupt(code);
}

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment

    return (size_t)(callInterrupt(code));
}

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    asm volatile("mv a2, a1"); // a2 = startRoutine
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1

    size_t* stack = (size_t*)mem_alloc(sizeof(size_t)*DEFAULT_STACK_SIZE); // pravimo stack procesa
    if(stack == nullptr) return -1;

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    asm volatile("mv a4, %0" : : "r" (stack));

    handle = (thread_t*)(callInterrupt(code)); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
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
    callInterrupt(code);
}

int thread_exit () {
    size_t code = Kernel::sysCallCodes::thread_exit;
    return (size_t)(callInterrupt(code));
}

void thread_start(thread_t* handle) {
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a1, a0"); // a1 = handle
    callInterrupt(code);
}

int sem_open (sem_t* handle, unsigned init) {
    size_t code = Kernel::sysCallCodes::sem_open;

    asm volatile("mv a2, a1"); // a2 = init
    asm volatile("mv a1, a0"); // a1 = handle

    handle = (sem_t*)callInterrupt(code);
    if(*handle == nullptr) {
        return -1;
    }

    return 0;
}

int sem_wait (sem_t volatile id) {
    size_t code = Kernel::sysCallCodes::sem_wait;
    if(id == nullptr) return -1;
    asm volatile("mv a1, a0");

    if(callInterrupt(code)) {
        thread_dispatch();
    }

    if(id == nullptr) return -2; // ?

    return 0;
}

int sem_signal (sem_t id) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(id == nullptr) return -1;
    asm volatile("mv a1, a0");

    PCB* process = (PCB*)callInterrupt(code);
    if(process) {
        thread_start(&process);
    }

    return 0;
}


