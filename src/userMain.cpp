#include "../h/hw.h"
#include "../h/print.h"
#include "../h/console.h"
#include "../h/syscall_c.h"
#include "../h/PCB.h"

/*void nitA(void* x) {
    printString("nit A\n");
    thread_dispatch();
    for(int i = 0; i < 30000; i++) {
        for(int j = 0; j < 10000; j++) {
            // uposleno cekanje
        }
    }

    printInt(*(int*)x);
    printString("\nKraj niti A\n");
}

void nitB(void* c) {
    printString("nit B\n");
    __putc(*(char*)c);
    __putc('\n');
}*/



void userMain() {
    /*PCB* procesi[2];
    int x = 5;
    thread_create(&procesi[0], nitA, &x);
    char c = 'k';
    thread_create(&procesi[1], nitB, &c);

    while(!procesi[0]->isFinished() || !procesi[1]->isFinished()) {
        thread_dispatch();
    }

    for(auto& proces : procesi) {
        delete proces;
    }*/
    time_sleep(10);
    char c = __getc();
    __putc(c);
}
