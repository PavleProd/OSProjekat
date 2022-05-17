#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    return mem_alloc(size);
}
void* operator new [](size_t size) {
    return mem_alloc(size);
}
void operator delete (void* memSegment) noexcept {
    mem_free(memSegment);
}
void operator delete [](void* memSegment) noexcept {
    mem_free(memSegment);
}