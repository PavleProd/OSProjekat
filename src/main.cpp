#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {

    int* par = (int*)MemoryAllocator::mem_alloc(3*sizeof(int));
    for(int i = 1; i < 4; i++) {
        par[i-1] = i;
    }

    size_t t = *(size_t*)((char*)par - MemoryAllocator::SegmentOffset);
    __putc(t);

    for(int i = 0; i < 3; i++) {
        __putc('0' + par[i]);
        __putc('\n');
    }

    return 0;
}