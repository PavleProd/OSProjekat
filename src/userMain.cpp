#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
#include "../h/slab.h"
#include "../h/Cache.h"
void userMain() {
    printString("\nHello world!\n");
    kmalloc(1<<16);
    Cache::allBufferInfo();
}