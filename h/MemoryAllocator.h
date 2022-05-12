#ifndef PROJECT_BASE_MEMORYALLOCATOR_H
#define PROJECT_BASE_MEMORYALLOCATOR_H

#include "../lib/hw.h"

class MemoryAllocator {
public:
    /*
    Alocira (najmanje) size bajtova memorije, zaokruženo i poravnato na blokove veličine MEM_BLOCK_SIZE.

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

    struct FreeSegment { // Jednostruko ulancana lista slobodnih segmenata
        void* baseAddr; // pocetna adresa u segmentu
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        static void remove(FreeSegment* prev) { // brise element iz ulancane liste koji se nalazi posle elementa prev
            if(!prev->next) return;

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
        }

        static void add(FreeSegment* prev, FreeSegment* curr) { // dodaje element curr u ulancanu listu nakon elementa prev(samo ulancava)
            curr->next = prev->next;
            prev->next = curr;
        }
    };

    enum memFreeFlags {
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

private:
    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata
    static MemoryAllocator* memAllocator;
    MemoryAllocator() {}

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    }

    // Vraca velicinu numOfBlocks blokova u bajtovima
    static inline size_t blocksInSize(size_t numOfBlocks) {
        return numOfBlocks * MEM_BLOCK_SIZE;
    }
};


#endif //PROJECT_BASE_MEMORYALLOCATOR_H
