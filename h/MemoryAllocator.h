#ifndef PROJECT_BASE_MEMORYALLOCATOR_H
#define PROJECT_BASE_MEMORYALLOCATOR_H

#include "../lib/hw.h"

class MemoryAllocator {
public:
    /*
    Alocira (najmanje) size bajtova memorije, zaokruženo i poravnato na blokove veličine MEM_BLOCK_SIZE.
    Svaki alocirani segment ima zaglavlje sa velicinom tog segmenta(vraca se adresa nakon tog zaglavlja)

    Vraća:
    pokazivač na alocirani deo memorije u slučaju uspeha, nullptr u slučaju neuspeha

    Radi se po algoritmu first fit(alociramo prvi segment koji je >= size). Ako je preostao prostor manji od velicine
    jednog bloka, taj preostali prostor se pridruzuje ovom koji smo sad alocirali(jer nema poente da ostane nealociran)
    */
    static void* mem_alloc(size_t size);
    /*
    Oslobađa prostor prethodno zauzet pomoću mem_alloc.
    Vraća 0 u slučaju uspeha, negativnu vrednost u slučaju greške

    */
    static int mem_free(void* memSegment);

    enum memFreeFlags {
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

private:
    MemoryAllocator() {} // da bi se zabranilo pravljenje objekata

    struct FreeSegment { // Jednostruko ulancana lista slobodnih segmenata
        void* baseAddr; // pocetna adresa u segmentu
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
            prev->next = curr;
        }
    };

    struct AllocatedSpaceHeader { // Zaglavlje zauzetog segmenta
        size_t size; // velicina segmenta(ukljucujuci i zaglavlje)
    };



    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    }

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE;
    }
public:
    static const size_t SegmentOffset = sizeof(AllocatedSpaceHeader);
};


#endif //PROJECT_BASE_MEMORYALLOCATOR_H
