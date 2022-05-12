#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    char* niz = (char*)MemoryAllocator::mem_alloc((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR + 1 - velicinaZaglavlja); // celokupan prostor
    if(niz == nullptr) {
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('k');
    }

    int status = MemoryAllocator::mem_free(niz);
    if(status) {
        __putc('?');
    }
    niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('?');
    }

    return 0;
}