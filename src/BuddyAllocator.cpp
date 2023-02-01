#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"

void* BuddyAllocator::startAddr = nullptr;
BuddyAllocator::BuddyEntry* BuddyAllocator::buddy[maxPowerSize] = {};

int BuddyAllocator::initBuddy() {
    if(startAddr != nullptr) return 1;
    startAddr = (void*)HEAP_START_ADDR;

    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);

    return ret;
}

void *BuddyAllocator::buddyAlloc(size_t size) {
    size--;
    if(size >= maxPowerSize) return nullptr;

    // proveri  da li ima za tu velicinu
    for(size_t curr = size; curr < maxPowerSize; curr++) {
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
        if(block != nullptr) { // postoji slobodan blok ove velicine
            while(curr > size) {
                size_t offset = sizeInBytes(curr);
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment

                curr--;
            }
            void* res = block->addr;
            //BuddyEntry::freeEntry(block); // oslobadjamo entry
            return res;
        }
    }
    return nullptr;
}

int BuddyAllocator::buddyFree(void *addr, size_t size) {
    size--;
    if(size >= maxPowerSize || addr == nullptr) return -1;

    void* next = addr;
    while(size < maxPowerSize) {
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
        void* other = next;
        size_t offset = sizeInBytes(size+1);
        other = (void*)((char*)other + (module == 0 ? offset : -offset));

        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
        /*if(otherEntry) { // postoji buddy blok
            BuddyEntry::freeEntry(otherEntry); // oslobadjamo ga jer se stapa u veci entry
        }*/
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
            BuddyEntry* entry = BuddyEntry::createEntry(next);
            BuddyEntry::addEntry(size+1, entry);
            break;
        }
        if(module != 0) {
            next = other;
        }
        size++;
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    size--;
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;

    BuddyEntry* block = buddy[size];
    return block;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    size--;
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    return block;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    size--;
    if(size >= maxPowerSize) return nullptr;

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
        if(curr->addr == addr) {
            if(prev) {
                prev->next = curr->next;
            }
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    }

    return nullptr;
}

void BuddyAllocator::printBuddy() {
    for(size_t i = 0; i < maxPowerSize; i++) {
        printInt(i+1);
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    }
}

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
        entry->addr = addr;
        return entry;
}

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    size--;
    if(size >= maxPowerSize) return -1;

    if(buddy[size] == nullptr) {
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
        if(curr->addr > entry->addr) {
            entry->next = curr;
            if(prev) {
                prev->next = curr;
            }
            else {
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
            curr->next = entry;
            break;
        }
        prev = curr;
    }

    return 0;
}

/*void BuddyAllocator::BuddyEntry::freeEntry(BuddyAllocator::BuddyEntry *entry) {
    if(entry == nullptr) return;
    MemoryAllocator::mem_free(entry);
}TODO: OBRISI*/
