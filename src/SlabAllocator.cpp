#include "../h/SlabAllocator.h"
#include "../h/BuddyAllocator.h"

const char* SlabAllocator::names[] = {"size-32", "size-64", "size-128", "size-256",
                                      "size-512", "size-1024", "size-2048",
                                      "size-4096", "size-8192", "size-16384",
                                      "size-32768", "size-65536", "size-131072", "PCB", "SEM"};

void SlabAllocator::initAllocator(void *space, int blockNum) {
    BuddyAllocator::initBuddy();
}

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    for(int i = 0; i < cacheNameNum; i++) {
        if(names[i] == name) break;
        if(i == cacheNameNum - 1) return nullptr;
    }

    Cache* cache = (Cache*)BuddyAllocator::buddyAlloc(1);
    cache->initCache(name, size, ctor, dtor);

    return cache;
}

void *SlabAllocator::allocSlot(Cache *cache) {
    return cache->allocateSlot();
}

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    cache->freeSlot((Cache::Slot*)obj);
}

int SlabAllocator::printErrorMessage(Cache *cache) {
    return cache->printErrorMessage();
}

void SlabAllocator::printCacheInfo(Cache *cache) {
    cache->printCacheInfo();
}

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    return cache->deallocFreeSlabs();
}

void SlabAllocator::deallocCache(Cache *cache) {
    cache->deallocCache();
}
