#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    PCB::running->setNextInList(nullptr);
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
        tail = tail->getNextInList();
    }
    PCB::running->setBlocked(true);
}

PCB* SCB::unblock() {
    if(head == nullptr) return nullptr;
    PCB* curr = head;
    head = head->getNextInList();
    if(tail == curr) {
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}

int SCB::wait() {
    if((int)(--semValue)<0) {
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
        return -2;
    }

    return 0;

}

void SCB::signal() {
    if((int)(++semValue)<=0) {
        Scheduler::put(unblock());
    }
}

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
        Scheduler::putInFront(unblock());
    }
}

void *SCB::operator new(size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

void SCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void SCB::signalClosing() {
    PCB* curr = head;
    while(curr) {
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    }
    head = tail = nullptr;
}

