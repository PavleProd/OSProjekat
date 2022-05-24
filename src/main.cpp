#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/syscall_cpp.h"
#include "../h/SCB.h"

SCB* semafor;

void workerBodyA(void* arg)
{
    int status = sem_wait(semafor);
    printString("Nit broj: ");
    printInteger(*(int*)arg);
    printString("\nStatus: ");
    printInteger(status+2);
    printString("\n");
    for (uint64 i = 0; i < 3; i++) {
        printString("A: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("A finished!\n");
    sem_signal(semafor);
    if(*(int*)arg == 0) {
        sem_close(semafor);
        semafor = nullptr;
    }
}

extern "C" void interrupt();
int main() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = main;
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    sem_open(&semafor, 1);
    PCB* procesi[4];
    int niz[4] = {0,1,2,3};
    for(int i = 0; i < 4; i++) {
        thread_create(&procesi[i], workerBodyA, &niz[i]);
    }

    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        Thread::dispatch();
    }

    for(auto& proces : procesi) {
        delete proces;
    }

    return 0;
}