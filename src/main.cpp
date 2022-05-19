#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"

static size_t fibonacci(size_t n)
{
    if (n == 0 || n == 1) { return n; }
    if (n % 4 == 0) PCB::yield();
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA()
{
    uint8 i = 0;
    for (; i < 3; i++)
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
    }

    printString("A: yield\n");
    __asm__ ("li t1, 7");
    PCB::yield();

    size_t t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("A: t1=");
    printInteger(t1);
    printString("\n");

    size_t result = fibonacci(20);
    printString("A: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 6; i++)
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
    }

    PCB::running->setFinished(true);
    PCB::yield();
}

void workerBodyB()
{
    uint8 i = 10;
    for (; i < 13; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
    }

    printString("B: yield\n");
    __asm__ ("li t1, 5");
    PCB::yield();

    size_t result = fibonacci(23);
    printString("A: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 16; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
    }

    PCB::running->setFinished(true);
    PCB::yield();
}

extern "C" void interrupt();
int main() {

    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* procesi[3];
    procesi[0] = PCB::createProccess(nullptr); // main
    PCB::running = procesi[0];

    procesi[1] = PCB::createProccess(workerBodyA);
    __putc('a');
    procesi[2] = PCB::createProccess(workerBodyB);
    __putc('b');

    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
        PCB::yield();
    }

    for(auto& pcb : procesi) {
        delete pcb;
    }

    return 0;
}
