#include "../h/PCB.h"
#include "../h/changeContext.h"
#include "../h/Scheduler.h"
#include "../h/MemoryAllocator.h"
#include "../h/kernel.h"

PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
}

void PCB::yield() {
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
}

void PCB::dispatch() {
    PCB* old = running;
    if(!old->isFinished()) {
        Scheduler::put(old);
    }
    running = Scheduler::get();

    switchContext(&old->context, &running->context);
}

// main_ == nullptr ako smo u glavnom procesu
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_)
: context({(size_t)(&proccessWrapper), 0, 0}) { // sp cemo dodeliti u sistemskom pozivu thread_create
    finished = false;
    main = main_;
    timeSlice = timeSlice_;
    mainArguments = mainArguments_;
    stack = sysStack = nullptr; // stek pravimo u sistemskom pozivu thread_create (koja takodje poziva sistemski poziv)
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

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    void* arg = PCB::running->mainArguments;
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    running->main();
    running->setFinished(true);
    PCB::yield(); // nit je gotova pa predajemo procesor drugom precesu
}

