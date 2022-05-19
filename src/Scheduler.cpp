#include "../h/Scheduler.h"

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    process->nextReady = nullptr;
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
        head = tail = process;
    }
    else {
        tail->nextReady = process;
        tail = tail->nextReady;
    }
}

PCB *Scheduler::get() {
    if(head == nullptr) {
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    if(tail == curr) {
        tail = head;
    }
    return curr;
}


