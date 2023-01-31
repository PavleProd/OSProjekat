#include "../h/BuddyAllocator.h"
#include "../h/MemoryAllocator.h"
#include "../h/printing.hpp"

void* BuddyAllocator::startAddr = nullptr;


int BuddyAllocator::initBuddy() {
    if(startAddr != nullptr) return 1;
    startAddr = MemoryAllocator::mem_alloc(allocSize);

    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);

    return ret;
}

void *BuddyAllocator::buddyAlloc(size_t size) {
    size--;
    if(size >= maxPowerSize) return nullptr;

    // proveri  da li ima za tu velicinu
    for(size_t curr = size; size < maxPowerSize; size++) {
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
        if(block != nullptr) { // postoji slobodan blok ove velicine
            while(curr > size) {
                size_t offset = 1<<curr;
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment

                curr--;
            }
            void* res = block->addr;
            BuddyEntry::freeEntry(block); // oslobadjamo entry
            return res;
        }
    }
    return nullptr;
}

int BuddyAllocator::buddyFree(void *addr, size_t size) {
    size--;
    if(size >= maxPowerSize || addr == nullptr) return -1;

    while(size < maxPowerSize) {
        size_t module = (size_t)addr % 1<<(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
        void* other = addr;
        size_t offset = 1<<(size+1);
        other = (void*)((char*)other + (module == 0 ? offset : -offset));

        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
        if(otherEntry) { // postoji buddy blok
            BuddyEntry::freeEntry(otherEntry); // oslobadjamo ga jer se stapa u veci entry
        }
        else { // nema buddy bloka sa kojim moze da se spoji
            BuddyEntry* entry = BuddyEntry::createEntry(addr);
            BuddyEntry::addEntry(size+1, entry);
            break;
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
    for(int i = 0; i < maxPowerSize; i++) {
        printInt(i);
    }
}

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
        BuddyEntry* entry = (BuddyEntry*)MemoryAllocator::mem_alloc(sizeof(BuddyEntry));
        entry->next = nullptr;
        entry->addr = addr;
        return entry;
}

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    size--;
    if(size >= maxPowerSize) return -1;

    if(buddy[size] == nullptr) buddy[size] = entry;
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

void BuddyAllocator::BuddyEntry::freeEntry(BuddyAllocator::BuddyEntry *entry) {
    if(entry == nullptr) return;
    MemoryAllocator::mem_free(entry);
}
