#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"

void nitA(void* x) {
    printString("nit A\n");
    PCB::yield();
    for(int i = 0; i < 30000; i++) {
        for(int j = 0; j < 10000; j++) {
            // uposleno cekanje
        }
    }

    printInteger(*(int*)x);
    printString("\nKraj niti A\n");
}

void nitB(void* c) {
    printString("nit B\n");
    __putc(*(char*)c);
    __putc('\n');
}
extern "C" void interrupt();
int main() {

    asm volatile("csrw stvec, %0" : : "r" (&interrupt));

    thread_t procesi[5];
    procesi[0] = PCB::createProccess(nullptr, nullptr); // main
    PCB::running = procesi[0];
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    using pFunc = void(*)(void*);
    int x = 11;
    char c = 'k';
    thread_create(&procesi[1], (pFunc)nitA, &x);
    thread_create(&procesi[2], (pFunc)nitB, &c);

    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
        PCB::yield();
    }

    for(auto &proces : procesi) {
        delete proces;
    }

    return 0;
}
