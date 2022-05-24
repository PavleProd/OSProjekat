#ifndef SYSCALL_CPP_H
#define SYSCALL_CPP_H

#include "syscall_c.h"
// Poziva funkciju mem_alloc koja alocira prostora odgovarajuce velicine size
void* operator new (size_t size);
void* operator new[] (size_t size);
// Poziva funkciju mem_free koja oslobadja zauzeti segment memSegment, prethodno alociran preko mem_alloc
void operator delete (void* memSegment) noexcept;
void operator delete[] (void* memSegment) noexcept;

class Thread {
    friend void threadWrapper(void* thread);
public:
    void* operator new(size_t size);
    void operator delete(void* memSegment);
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
private:
    thread_t myHandle;
};

#endif //SYSCALL_CPP_H
