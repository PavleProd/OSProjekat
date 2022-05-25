#include "../h/syscall_cpp.h"
#include "../h/MemoryAllocator.h"
#include "../h/PCB.h"
#include "../h/SCB.h"

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

void threadWrapper(void* thread);
Thread::Thread() {
    thread_create_only(&myHandle, threadWrapper, this);
}

void threadWrapper(void* thread) {
    ((Thread*)thread)->run();
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

PeriodicThread::PeriodicThread(time_t period) {

}
