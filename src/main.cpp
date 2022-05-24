#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/syscall_cpp.h"


bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

class WorkerA: public Thread {
    void workerBodyA(void* arg);
public:
    WorkerA():Thread() {}

    void run() override {
        workerBodyA(nullptr);
    }
};

class WorkerB: public Thread {
    void workerBodyB(void* arg);
public:
    WorkerB():Thread() {}

    void run() override {
        workerBodyB(nullptr);
    }
};

class WorkerC: public Thread {
    void workerBodyC(void* arg);
public:
    WorkerC():Thread() {}

    void run() override {
        workerBodyC(nullptr);
    }
};

class WorkerD: public Thread {
    void workerBodyD(void* arg);
public:
    WorkerD():Thread() {}

    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("A: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("A finished!\n");
    finishedA = true;
}

void WorkerB::workerBodyB(void *arg) {
    for (uint64 i = 0; i < 16; i++) {
        printString("B: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("B finished!\n");
    finishedB = true;
    thread_dispatch();
}

void WorkerC::workerBodyC(void *arg) {
    uint8 i = 0;
    for (; i < 3; i++) {
        printString("C: i="); printInteger(i); printString("\n");
    }

    printString("C: dispatch\n");
    __asm__ ("li t1, 7");
    thread_dispatch();

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("C: t1="); printInteger(t1); printString("\n");

    uint64 result = fibonacci(12);
    printString("C: fibonaci="); printInteger(result); printString("\n");

    for (; i < 6; i++) {
        printString("C: i="); printInteger(i); printString("\n");
    }

    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

void WorkerD::workerBodyD(void* arg) {
    uint8 i = 10;
    for (; i < 13; i++) {
        printString("D: i="); printInteger(i); printString("\n");
    }

    printString("D: dispatch\n");
    __asm__ ("li t1, 5");
    thread_dispatch();

    uint64 result = fibonacci(16);
    printString("D: fibonaci="); printInteger(result); printString("\n");

    for (; i < 16; i++) {
        printString("D: i="); printInteger(i); printString("\n");
    }

    printString("D finished!\n");
    finishedD = true;
    thread_dispatch();
}

extern "C" void interrupt();
int main() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = main;
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    Thread* threads[4];

    threads[0] = new WorkerA();
    printString("ThreadA created\n");

    threads[1] = new WorkerB();
    printString("ThreadB created\n");

    threads[2] = new WorkerC();
    printString("ThreadC created\n");

    threads[3] = new WorkerD();
    printString("ThreadD created\n");

    for(int i=0; i<4; i++) {
        threads[i]->start();
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }

    return 0;
}
