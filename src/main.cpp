#include "../h/hw.h"
#include "../h/syscall_c.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/SCB.h"
#include "../h/CCB.h"
#include "../h/userMain.h"
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    while(true) {}
}
// ------------

int main() {
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    PCB::running = main;
/*
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    Scheduler::idleProcess->setFinished(true);
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&userProcess, userMainWrapper, nullptr);
    // ----
    kmem_cache_info(PCB::pcbCache);
    kmem_cache_info(SCB::scbCache);
    while(!userProcess->isFinished()) {
        thread_dispatch();
    }

    while(CCB::semOutput->getSemValue() != 0) {
        thread_dispatch();
    }
    return 0;
}