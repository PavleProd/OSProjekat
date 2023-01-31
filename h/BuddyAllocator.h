#ifndef OSPROJEKAT_BUDDYALLOCATOR_H
#define OSPROJEKAT_BUDDYALLOCATOR_H

#include "hw.h"

class BuddyAllocator {
public:
    static const size_t allocSize = 1<<24;
    static const size_t maxPowerSize = 24;
private:
    BuddyAllocator() {}

    class BuddyEntry {
    private:
        BuddyEntry() {};
    public:
        BuddyEntry* next;
        void* addr;

        // Vraca pokazivac na jedan BuddyEntry sa pocetnom adresom addr
        static BuddyEntry* createEntry(void* addr);
        // oslobadja entry iz memorije, ne radi preulancavanje
        static void freeEntry(BuddyEntry* entry);
        // dodaje BuddyEntry u ulancanu listu za blokove velicine 2^(size-1)
        static int addEntry(size_t size, BuddyEntry* entry);
    };
    // niz sa pokazivacima na pocetak slobodnih blokova, ulaz i se alocira kada se prvi put pristupi bloku velicine 2^(i+1)
    static BuddyEntry* buddy[maxPowerSize];
    // pocetna vrednost alociranog buddy alokatora
    static void* startAddr;

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
public:
    // alocira blok velicine 2^size. U slucaju da se ne moze alocirati blok, vraca nullptr, inace vraca pocetnu adresu bloka
    static void* buddyAlloc(size_t size);
    static int buddyFree(void* addr, size_t size);

    /*
     * Alocira singleton instancu BuddyAllocator-a velicine velicinaAlokatora
     * return:
     * 1 - Buddy je vec napravljen
     * 0 - Uspesno inicijalizovan buddy alokator
     * -1 - greska
     * */
    static int initBuddy();

    BuddyAllocator(BuddyAllocator const&) = delete;
    void operator=(BuddyAllocator const&) = delete;
};


#endif //OSPROJEKAT_BUDDYALLOCATOR_H
