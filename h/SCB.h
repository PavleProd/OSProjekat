#ifndef PROJECT_BASE_SCB_H
#define PROJECT_BASE_SCB_H

#include "PCB.h"
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    }

    // smanjuje vrednost semValue i ako ona padne manje od 0, blokira tekuci proces ako on treba da se blokira
    // vraca 0 ako se nit uspesno probudila, -2 ako se probudila kad je semafor obrisan
    int wait();

    // povecava vrednost semValue i ako je ona posle povecanja <= 0, odblokira proces ako treba da se odblokira
    void signal();

    void prioritySignal();

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1);

    static SCB* createSysSemaphore(int semValue = 1);

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();

    static void createObject(void* addr) {}
    static void freeObject(void* addr) {}
    static kmem_cache_t* scbCache;//TODO private
    static void initSCBCache();
private:

    void scbInit(int semValue);
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
