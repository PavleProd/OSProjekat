#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
void userMain() {
    BuddyAllocator::initBuddy();

    int N = (1<<11) - 1;
    void* niz[N];
    for(int i  = 0; i < N; i++) {
        niz[i] = BuddyAllocator::buddyAlloc(1);
    }
    /*printString("alocirana adresa: ");
    printInt((size_t)addr);
    printString("\n");*/
    BuddyAllocator::printBuddy();
    printString("posle\n");
    for(int i = 0; i < N; i++) {
        BuddyAllocator::buddyFree(niz[i], 1);
    }
    BuddyAllocator::printBuddy();
}