#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {

    int* par = (int*)MemoryAllocator::mem_alloc(2*sizeof(int));
    *par = 5;
    *(par + 1) = 3;

    int x = (size_t)par - (size_t)HEAP_START_ADDR;
    __putc('0' + x);

    return 0;
}