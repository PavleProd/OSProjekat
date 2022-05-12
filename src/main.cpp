#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

int main() {

    int* par = (int*)MemoryAllocator::mem_alloc(2*sizeof(int));
    *par = 5;
    *(par + 1) = 3;

    char c = '0' + *par;
    char c2 = '0' + par[1];
    __putc(c);
    __putc('\n');
    __putc(c2);

    return 0;
}