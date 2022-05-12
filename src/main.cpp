#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {

    int* par = (int*)MemoryAllocator::mem_alloc(3*sizeof(int));
    *par = 5;
    *(par + 1) = 3;

    int x = sizeof(par);
    __putc('0' + x);

    return 0;
}