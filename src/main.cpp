#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/syscall_cpp.h"
#include "../h/SCB.h"

bool finished[2];

void sleepyRun(void *arg) {
    time_t sleep_time = *((time_t *) arg);
    int i = 6;
    while (--i > 0) {

        printString("Hello ");
        printInteger(sleep_time);
        printString(" !\n");
        time_sleep(sleep_time);
    }
    finished[sleep_time/10-1] = true;
}


// Kernel inicijalizaccija
void idleProcess() {
    while(true) {}
}
extern "C" void interrupt();
// ------------
int main() {
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = main;
    Scheduler::idleProcess = PCB::createProccess(idleProcess, nullptr);
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    // ----

    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    }

    while (!(finished[0] && finished[1])) {}

    return 0;
}