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

bool SCB::wait() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(--semValue)<0) {
        block();
        return true;
    }
    return false;
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}

PCB* SCB::signal() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(++semValue)<=0) {
        return unblock();
    }
    return nullptr;
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
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

