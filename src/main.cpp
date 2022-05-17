#include "../h/hw.h"
#include "../h/console.h"
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
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    char* niz = (char*)mem_alloc(celaMemorija); // celokupan prostor
    if(niz == nullptr) {
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('k');
    }

    int status = mem_free(niz);
    if(status) {
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    if(niz2 == nullptr) {
        __putc('?');
    }

    return 0;
}
