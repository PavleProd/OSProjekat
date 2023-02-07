#ifndef OSPROJEKAT_CACHE_H
#define OSPROJEKAT_CACHE_H

#include "hw.h"

class Cache {
    friend class SlabAllocator;
public:
    enum ERRORTYPE {
        NOERROR, FREESLOTERROR
    };
private:
    ERRORTYPE errortype = NOERROR;

    enum SlabState {
        EMPTY = 0, PARTIAL = 1, FULL = 2, CREATED = 3
    };

    struct Slab;
    struct Slot {
    public:
        bool allocated = false;
        Slot* next = nullptr;
        Slab* parentSlab = nullptr;
    };

    struct Slab {
        size_t allocatedSlots = 0;
        Slab *next = nullptr;
        SlabState state = EMPTY;
        Cache* parentCache = nullptr;
        Slot* getFreeSlot();
        Slot* slotHead = nullptr;

        SlabState calculateNewState();
    };

    Slab* slabList[3] = {}; // za svako stanje
    // stavlja slab u odgovarajucu listu listNum i menja mu stanje na listNum
    void slabListPut(Slab* slab, int listNum);
    // brise slab iz liste listNum
    void slabListRemove(Slab* slab, int listNum);

    typedef void(*Constructor) (void *);
    typedef void(*Destructor) (void *);
    char cacheName[15];
    size_t objectSize, optimalSlots, slotSize;
    Constructor constructor;
    Destructor destructor;

    void getNumSlabsAndSlots(int* numSlabs, int* numSlots);

    static int getNumSlots(size_t objSize);
    static const int MINSIZEBUFFER = 5, MAXSIZEBUFFER = 17;
    static const int BLKSIZE = 4096;
public:
    // štampanje greške prilikom rada sa kešom; povratna vrednost funkcije je 0 ukoliko
    //greške nije bilo, u suprotnom vrednost različita od 0.
    int printErrorMessage();
    // Ispis poruke: ime kesa, velicina objekta, broj slabova, broj slotova po slabu, broj alociranih slotova
    void printCacheInfo();
    void initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *));
    void* allocateSlot();
    void freeSlot(Slot* slot);
    // oslobadja sve slabove koji su slobodni skroz, vraca broj oslobodjenih blokova
    int deallocFreeSlabs();
    void deallocCache();
    void deallocSlab(Slab* slab);
    Slab* allocateSlab();
};


#endif //OSPROJEKAT_CACHE_H
