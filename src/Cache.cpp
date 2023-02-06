#include "../h/Cache.h"
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    for(int i = 0;; i++) {
        cacheName[i] = name[i];
        if(name[i] == '\0') break;
    }
    objectSize = size;
    constructor = ctor;
    destructor = dtor;

    optimalSlots = getNumSlots(objectSize);
}

int Cache::getNumSlots(size_t objSize) {
    return (BLKSIZE - sizeof(Cache)) / objSize;
}

void *Cache::allocateSlot() {
    if(slabList[PARTIAL]) {
        Slab* slab = slabList[PARTIAL];
        slabList[PARTIAL] = slabList[PARTIAL]->next;
        return slab->getFreeSlot();
    }
    else if(slabList[EMPTY]) {
        Slab* slab = slabList[EMPTY];
        slabList[EMPTY] = slabList[EMPTY]->next;
        Slot* slot = slab->getFreeSlot();

        return slot;
    }
    else {
        Slab* slab = allocateSlab();
        return slab->getFreeSlot();
    }

    return nullptr;
}

Cache::Slab *Cache::allocateSlab() {
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(1);
    slab->parentCache = this;
    return slab;
}


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    if (!slab || listNum < 0 || listNum > 2) return;
    slab->state = (SlabState)listNum;
    if(slabList[listNum]) {
        slab->next = slabList[listNum];
    }
    slabList[listNum] = slab;
}

void Cache::freeSlot(Slot* slot) {
    if(slot->parentSlab->parentCache != this) {
        errortype = FREESLOTERROR;
        return;
    }

    Slab* parentSlab = slot->parentSlab;
    Cache* parentCache = parentSlab->parentCache;
    slot->allocated = false;
    parentSlab->allocatedSlots--;

    SlabState newState = parentSlab->calculateNewState();
    if(parentSlab->state != newState) {
        parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    if(!slab || listNum < 0 || listNum > 2) return;

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
        if(curr == slab) {
            prev->next = curr->next;
            curr->next = nullptr;
            break;
        }
        prev = curr;
    }
}

int Cache::printErrorMessage() {
    switch(errortype) {
        case FREESLOTERROR:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    }
    return errortype;
}
// Ispis poruke: ime kesa, velicina objekta, broj slabova, broj slotova po slabu, broj alociranih slotova
void Cache::printCacheInfo() {
    int numSlabs = 0, numSlots = 0;
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    printString("ime kesa, velicina objekta, broj slabova, broj slotova po slabu, broj alociranih slotova\n");
    printString(cacheName);
    printString(", ");
    printInt(objectSize);
    printString(", ");
    printInt(numSlabs);
    printString(", ");
    printInt(optimalSlots);
    printString(", ");
    printInt(numSlots);

}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
             slabs++;
             slots += curr->allocatedSlots;
        }
    }
    (*numSlabs) = slabs;
    (*numSlots) = slots;
}


Cache::Slot *Cache::Slab::getFreeSlot() {
    if(!slotHead || state == FULL) return nullptr;

    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
        if(curr->allocated == false) {
            this->allocatedSlots++;
            curr->allocated = true;
            curr->parentSlab = this;

            SlabState newState = calculateNewState();
            if(this->state != newState) {
                parentCache->slabListRemove(this, this->state);
                parentCache->slabListPut(this, newState);
            }

            return curr;
        }
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    if(allocatedSlots == 0) {
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
        return FULL;
    }
    return PARTIAL;
}
