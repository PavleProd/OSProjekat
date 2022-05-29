#include "../h/CCB.h"
#include "../h/PCB.h"
#include "../h/SCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
PCB* CCB::inputProcces = nullptr;
PCB* CCB::outputProcess = nullptr;
SCB* CCB::semInput = nullptr;
SCB* CCB::semOutput = nullptr;
SCB* CCB::inputBufferEmpty = nullptr;
IOBuffer CCB::inputBuffer;
IOBuffer CCB::outputBuffer;

void CCB::inputBody(void *) {
    bool t = false;
    while(true) {
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
            sem_signal(CCB::inputBufferEmpty);
        }
        if(!t){
            plic_complete(CONSOLE_IRQ);
            t = true;
        }
        sem_wait(CCB::semInput);
    }
}

void CCB::outputBody(void *) {
    bool t = false;
    while(true) {
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
            if(outputBuffer.peekFront() == 0) break;

            *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
        }
        if(!t) {
            plic_complete(CONSOLE_IRQ);
            t = true;
        }
        sem_wait(semOutput);
    }
}


void IOBuffer::pushBack(char c) {
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    newElem->next = nullptr;
    newElem->data = c;
    if(!head) {
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
        tail = tail->next;
    }
}

char IOBuffer::popFront() {
    if(!head) return 0;

    Elem* curr = head;
    head = head->next;
    if(tail == curr) tail = nullptr;

    char c = curr->data;
    MemoryAllocator::mem_free(curr);
    return c;
}

char IOBuffer::peekBack() {
    return tail ? tail->data : 0;
}

char IOBuffer::peekFront() {
    return head ? head->data : 0;
}
