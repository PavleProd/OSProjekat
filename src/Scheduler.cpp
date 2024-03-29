#include "../h/Scheduler.h"

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    if(!process) return;
    process->nextInList = nullptr;
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
        head = tail = process;
    }
    else {
        tail->nextInList = process;
        tail = tail->nextInList;
    }
}

PCB *Scheduler::get() {
    if(head == nullptr) {
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    if(tail == curr) {
        tail = head;
    }
    return curr;
}

void Scheduler::putInFront(PCB *process) {
    if(!process) return;
    process->nextInList = head;
    if(!head) {
        head = tail = process;
    }
    else {
        head = process;
    }
}



