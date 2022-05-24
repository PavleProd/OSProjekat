#ifndef PROJECT_BASE_SCB_H
#define PROJECT_BASE_SCB_H

#include "PCB.h"
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    }

    // smanjuje vrednost semValue i ako ona padne manje od 0, vraca true(tekuci proces treba da se blokira)
    bool wait();

    // povecava vrednost semValue i ako je ona posle povecanja <= 0, vraca se proces koji treba da se odblokira
    PCB* signal();

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
        semValue = semValue_;
    }
    // dodaje tekuci proces u red blokiranih procesa
    void block();
    // deblokira jedan proces i vraca ga(ne stavlja ga u Scheduler)
    PCB* unblock();
    PCB *head = nullptr, *tail = nullptr; // pocetak i kraj liste blokiranih procesa na semaforu
    int semValue;
};


#endif //PROJECT_BASE_SCB_H
