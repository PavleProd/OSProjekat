#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"


void workerBodyA()
{
    for (size_t i = 0; i < 10; i++)
    {
        if(i==5)thread_exit();
        printString("A: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
        {
            for (size_t k = 0; k < 30000; k++)
            {
                // busy wait
            }
//            TCB::yield();
        }
    }
}

void workerBodyB()
{
    for (size_t i = 0; i < 16; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
        {
            for (size_t k = 0; k < 30000; k++)
            {
                // busy wait
            }
        }
    }
}

static size_t fibonacci(size_t n)
{
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { PCB::yield(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyC()
{
    uint8 i = 0;
    for (; i < 3; i++)
    {
        printString("C: i=");
        printInteger(i);
        printString("\n");
    }

    printString("C: yield\n");
    __asm__ ("li t1, 7");
    PCB::yield();

    size_t t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("C: t1=");
    printInteger(t1);
    printString("\n");

    size_t result = fibonacci(12);
    printString("C: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 6; i++)
    {
        printString("C: i=");
        printInteger(i);
        printString("\n");
    }
//    TCB::yield();
}

void workerBodyD()
{
    uint8 i = 10;
    for (; i < 13; i++)
    {
        printString("D: i=");
        printInteger(i);
        printString("\n");
    }

    printString("D: yield\n");
    __asm__ ("li t1, 5");
    thread_dispatch();

    size_t result = fibonacci(16);
    printString("D: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 16; i++)
    {
        printString("D: i=");
        printInteger(i);
        printString("\n");
    }
//    TCB::yield();
}

extern "C" void interrupt();
int main() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = main;
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    PCB* procesi[4];
    using pf = void(*)(void*);
    thread_create(&procesi[0], (pf)workerBodyA, nullptr);
    thread_create(&procesi[1], (pf)workerBodyB, nullptr);
    thread_create(&procesi[2], (pf)workerBodyC, nullptr);
    thread_create(&procesi[3], (pf)workerBodyD, nullptr);


    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        thread_dispatch();
    }

    for(auto& proces : procesi) {
        delete proces;
    }

    return 0;
}
