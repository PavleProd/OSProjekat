#include "../h/PCB.h"
#include "../h/changeContext.h"
#include "../h/Scheduler.h"

PCB* PCB::running = nullptr;

PCB *PCB::createProccess(PCB::processMain main) {
    return nullptr;
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
PCB::PCB(PCB::processMain main_)
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
context({(size_t)main_, stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    finished = false;
    main = main_;
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
}

PCB::~PCB() {
    delete[] stack;
}

