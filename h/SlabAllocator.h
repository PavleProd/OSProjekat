#ifndef OSPROJEKAT_SLABALLOCATOR_H
#define OSPROJEKAT_SLABALLOCATOR_H

#include "hw.h"
#include "Cache.h"

class SlabAllocator {
private:
    static const int cacheNameNum = 15;
    SlabAllocator() {}
    static const char* names[cacheNameNum];

public:

    static void initAllocator(void* space, int blockNum);
    static Cache* createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *));
    static int deallocFreeSlabs(Cache* cache);
    static void deallocCache(Cache* cache);
    static void* allocSlot(Cache* cache);
    static void freeSlot(Cache *cache, void *obj);
    static int printErrorMessage(Cache* cache);
    static void printCacheInfo(Cache* cache);

    SlabAllocator(SlabAllocator const&) = delete;
    void operator=(SlabAllocator const&) = delete;
};


#endif //OSPROJEKAT_SLABALLOCATOR_H
