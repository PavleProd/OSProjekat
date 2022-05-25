#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    PCB* curr = head, *prev = nullptr;
    while(curr && curr->getTimeSleeping() < process->getTimeSleeping()) { // ako su iste vrednosti oba ce biti izvadjena
        prev = curr;
        curr = curr->getNextInList();
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
        head = process;
        process->setNextInList(curr);
    }
    else {
        prev->setNextInList(process);
        process->setNextInList(curr);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(process->getTimeSleeping() - prev->getTimeSleeping());
    }
}

void SleepingProcesses::wakeUp() {
    if(!head) return;

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    }

    head = curr;
}
