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

    int *p1 = (int*)MemoryAllocator::mem_alloc(15*sizeof(int)); // trebalo bi da predje jedan blok od 64
    checkNullptr(p1);
    int *p2 = (int*)MemoryAllocator::mem_alloc(30*sizeof(int));
    checkNullptr(p2);

    int *p3 = (int*)MemoryAllocator::mem_alloc(30*sizeof(int));
    checkNullptr(p3);

    checkStatus(MemoryAllocator::mem_free(p1));
    checkStatus(MemoryAllocator::mem_free(p3));
    checkStatus(MemoryAllocator::mem_free(p2)); // p2 treba da se spoji sa p1 i p3

    const size_t maxMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    int *celaMemorija = (int*)MemoryAllocator::mem_alloc(maxMemorija);
    checkNullptr(celaMemorija);

    checkStatus(MemoryAllocator::mem_free(celaMemorija));


    return 0;
}
