#include "../h/SlabAllocator.h"
#include "../h/BuddyAllocator.h"

void SlabAllocator::initAllocator(void *space, int blockNum) {
    BuddyAllocator::initBuddy();
}

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    Cache* cache = Cache::createCache();
    cache->initCache(name, size, ctor, dtor);
    return cache;
}

void *SlabAllocator::allocSlot(Cache *cache) {
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
}

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
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

void *SlabAllocator::allocBuff(size_t size) {
    return (void*)((char*)Cache::allocateBuffer(size) + sizeof(Cache::Slot)); // za pocetnu adresu bafera
}

void SlabAllocator::freeBuff(const void *buff) {
    Cache::freeBuffer((Cache::Slot*)((char*)buff - sizeof(Cache::Slot))); // za pocetnu adresu slota
}
