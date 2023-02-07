#include "../h/Cache.h"
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    for(int i = 0;; i++) {
        cacheName[i] = name[i];
        if(name[i] == '\0') break;
    }
    for(int i = 0; i < 3; i++) {
        slabList[i] = nullptr;
    }
    objectSize = size;
    constructor = ctor;
    destructor = dtor;
    slotSize = objectSize + sizeof(Slot);

    optimalSlots = getNumSlots(slotSize);
}

int Cache::getNumSlots(size_t objSize) {
    return (BLKSIZE - sizeof(Slab)) / objSize;
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
    slab->next = nullptr;
    slab->state = CREATED;
    slab->allocatedSlots = 0;
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    Slot* prev = nullptr;
    for(size_t i = 0; i < this->optimalSlots; i++) {
        constructor((void*)((char*)startAddr + i*slotSize));
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
        curr->parentSlab = slab;
        curr->allocated = false;
        if(prev) {
            prev->next= curr;
        }
        else {
            slab->slotHead = curr;
        }
        curr->next = nullptr;
        prev = curr;
    }

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
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
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
    printString("ime kesa, velicina objekta, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    printString(cacheName);
    printString(", ");
    printInt(objectSize);
    printString(", ");
    printInt(numSlabs);
    printString(", ");
    printInt(slotSize);
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

int Cache::deallocFreeSlabs() {
    int numSlabs = 0;
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
        numSlabs++;
        Slab* old = curr;
        curr = curr->next;
        deallocSlab(old);
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    for(size_t i = 0; i < this->optimalSlots; i++) {
        destructor((void*)((char*)startAddr + i*slotSize));
    }
    BuddyAllocator::buddyFree(slab, 1);
}

void Cache::deallocCache() {
    for(int i = 0; i < 3; i++) {
        Slab* curr = slabList[i];
        while(curr) {
            Slab* old = curr;
            curr = curr->next;
            deallocSlab(old);
        }
    }
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
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
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
