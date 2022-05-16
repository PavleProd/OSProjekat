#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
        __putc('?');
        __putc('0' + x);
    }
    x++;
}

void checkStatus(int status) {
    static int y = 0;
    if(status) {
        __putc('0' + y);
        __putc('?');
    }
    y++;
}

int main() {
    int* par = (int*)mem_alloc(2*sizeof(int));
    checkNullptr(par);
    par[0] = 1;
    par[1] = 2;

    printInteger(par[0]);
    printInteger(par[1]);

    int status = mem_free(par);
    checkStatus(status);
    return 0;
}