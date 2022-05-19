#include "../h/kernel.h"

void Kernel::popSppSpie() {
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    asm volatile("sret");
}
