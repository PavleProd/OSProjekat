#include "../h/slab.h"
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    SlabAllocator::initAllocator(space, block_num);
}

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
}

int kmem_cache_shrink(kmem_cache_t *cachep) {
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
}
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    return SlabAllocator::allocSlot((Cache*)cachep);
}
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    SlabAllocator::freeSlot((Cache*)cachep, objp);
}

void *kmalloc(size_t size) {
    return SlabAllocator::allocBuff(size);
}

void kfree(const void *objp) {
    SlabAllocator::freeBuff(objp);
}

void kmem_cache_destroy(kmem_cache_t *cachep) {
    SlabAllocator::deallocCache((Cache*)cachep);
}
void kmem_cache_info(kmem_cache_t *cachep) {
    SlabAllocator::printCacheInfo((Cache*)cachep);
}
int kmem_cache_error(kmem_cache_t *cachep) {
    return SlabAllocator::printErrorMessage((Cache*)cachep);
}