#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    PCB::running->nextInList = nullptr;
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
        head = tail = PCB::running;
    }
    else {
        tail->nextInList = PCB::running;
        tail = tail->nextInList;
    }
    PCB::running->blocked = true;
    //PCB::yield(); // ovo treba da radi sistemski poziv
}

PCB* SCB::unblock() {
    if(head == nullptr) return nullptr;
    PCB* curr = head;
    head = head->nextInList;
    if(tail == curr) {
        tail = head;
    }
    curr->blocked = false;
    curr->nextInList = nullptr;
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
        curr->semDeleted = true;
        curr->blocked = false;
        curr = curr->nextInList;
        Scheduler::put(last);
    }
    head = tail = nullptr;
}

