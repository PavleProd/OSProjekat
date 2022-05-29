#include "../h/syscall_cpp.h"
#include "../h/MemoryAllocator.h"
#include "../h/PCB.h"
#include "../h/SCB.h"
#include "../h/kernel.h"
void* operator new (size_t size) {
    return mem_alloc(size);
}
void* operator new [](size_t size) {
    return mem_alloc(size);
}
void operator delete (void* memSegment) noexcept {
    mem_free(memSegment);
}
void operator delete [](void* memSegment) noexcept {
    mem_free(memSegment);
}

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    delete myHandle;
}

void *Thread::operator new(size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

void Thread::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::start() {
    thread_start(&myHandle);
    return 0;
}

struct threadArg {
    void* thread;
    void (Thread::* run)();
};

void threadWrapper(void* thread);
Thread::Thread() {
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    thread_create_only(&myHandle, threadWrapper, tArg);
}

void threadWrapper(void* thread) {
    threadArg *tArg = (threadArg*)thread;
    (((Thread*)tArg->thread)->*(tArg->run))();
    delete tArg;
}

int Thread::sleep(time_t time) {
    return time_sleep(time);
}

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

void Semaphore::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void *Semaphore::operator new(size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

struct periodicThreadArg {
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
        Thread::sleep(pArg->period);
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
{}


char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    return ::putc(c);
}
