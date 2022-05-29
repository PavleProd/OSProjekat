#include "../h/buffer.hpp"
#include "../h/console.h"

Buffer::Buffer(int _cap) : cap(_cap), head(0), tail(0) {
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    sem_open(&itemAvailable, 0);
    sem_open(&spaceAvailable, cap);
    sem_open(&mutexHead, 1);
    sem_open(&mutexTail, 1);
}

Buffer::~Buffer() {
    __putc('\n');
    printString("Buffer deleted!\n");
    while (head != tail) {
        char ch = buffer[head];
        __putc(ch);
        head = (head + 1) % cap;
    }
    __putc('!');
    __putc('\n');

    mem_free(buffer);
    sem_close(itemAvailable);
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    sem_wait(spaceAvailable);

    sem_wait(mutexTail);
    buffer[tail] = val;
    tail = (tail + 1) % cap;
    sem_signal(mutexTail);

    sem_signal(itemAvailable);

}

int Buffer::get() {
    sem_wait(itemAvailable);

    sem_wait(mutexHead);

    int ret = buffer[head];
    head = (head + 1) % cap;
    sem_signal(mutexHead);

    sem_signal(spaceAvailable);

    return ret;
}
