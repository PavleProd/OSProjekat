#ifndef SLEEPINGPROCESSES_H
#define SLEEPINGPROCESSES_H

#include "PCB.h"

class SleepingProcesses {
private:
    SleepingProcesses() = default;

    static PCB *head; // nije na potreban tail
public:
    // uspavljuje proces tako sto ga dodaje u sortiranu listu uspavanih procesa
    // postavlja ga u blocked stanje
    // Potrebno je da je prethodno u PCB procesa upisano na koje vreme ce biti uspavan
    static void putToSleep(PCB* process);

    // procesu smanjuje periodu cekanja za 1
    // budi sve procese koje treba da se probude i stavlja ih u Scheduler
    static void wakeUp();
};


#endif // SLEEPINGPROCESSES_H
