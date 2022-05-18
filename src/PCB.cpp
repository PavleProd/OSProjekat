#include "../h/PCB.h"
#include "../h/changeContext.h"
#include "../h/Scheduler.h"
#include "../h/MemoryAllocator.h"


PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

PCB *PCB::createProccess(PCB::processMain main) {
    return new PCB(main, DEFAULT_TIME_SLICE);
}

void PCB::yield() {
    pushRegisters();
    dispatch();
    popRegisters();
}

void PCB::dispatch() {
    PCB* old = running;
    if(!old->isFinished()) {
        Scheduler::put(old);
    }
    running = Scheduler::get();

    switchContext(&old->context, &running->context);
}

// main == nullptr ako smo u glavnom procesu
PCB::PCB(PCB::processMain main_, size_t timeSlice_)
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
context({(size_t)(&proccessWrapper), stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    finished = false;
    main = main_;
    timeSlice = timeSlice_;
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
}

PCB::~PCB() {
    delete[] stack;
}

void *PCB::operator new(size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde
    running->main();
    running->setFinished(true);
}

