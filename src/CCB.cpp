#include "../h/CCB.h"
#include "../h/PCB.h"
#include "../h/SCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/kernel.h"
#include "../h/slab.h"
PCB* CCB::inputProcces = nullptr;
PCB* CCB::outputProcess = nullptr;
SCB* CCB::semInput = nullptr;
SCB* CCB::semOutput = nullptr;
SCB* CCB::inputBufferEmpty = nullptr;
IOBuffer CCB::inputBuffer;
IOBuffer CCB::outputBuffer;

void CCB::inputBody(void*) {
    while(true) {
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
            sem_signal(CCB::inputBufferEmpty);
            plic_complete(CONSOLE_IRQ);
            sem_wait(semInput);
        }
        thread_dispatch();
    }
}

void CCB::outputBody(void*) {
    while(true) {
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
            if(outputBuffer.peekFront() != 0) {
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
                sem_wait(semOutput);
            }
            else {
                break;
            }
        }
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    if(!array) {
        array = (char*)kmalloc(capacity);
    }
    array[tail] = c;
    size++;
    tail = tail == capacity - 1 ? 0 : tail + 1;
}

char IOBuffer::popFront() {
    if(!size) return 0;

    char c = array[head];
    size--;
    head = head == capacity - 1 ? 0 : head + 1;
    return c;
}

char IOBuffer::peekBack() {
    return size > 0 ? array[tail] : 0;
}

char IOBuffer::peekFront() {
    return size > 0 ? array[head] : 0;
}
