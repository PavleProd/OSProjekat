#include "../h/hw.h"
#include "../h/syscall_c.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/SCB.h"
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    while(true) {}
}
// ------------

int main() {
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    PCB::running = main;

    sem_open(&CCB::semInput, 0);
    sem_open(&CCB::semOutput, 0);
    sem_open(&CCB::inputBufferEmpty, 0);

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    thread_create(&userProcess, userMainWrapper, nullptr);
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    // ----

    while(!userProcess->isFinished()) {
        thread_dispatch();
    }

    return 0;
}