#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    PCB* curr = head, *prev = nullptr;
    size_t time = process->getTimeSleeping();
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
        prev = curr;
        time -= curr->getTimeSleeping();
        curr = curr->getNextInList();
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
        head = process;
        process->setNextInList(curr);
        if(curr) {
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
        }
    }
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
        }
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
