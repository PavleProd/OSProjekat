#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    {
        __putc(*string);
        string++;
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
}

void printInteger(size_t integer)
{
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    static char digits[] = "0123456789";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (integer < 0)
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    }

    i = 0;
    do
    {
        buf[i++] = digits[x % 10];
    } while ((x /= 10) != 0);
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
}
void printError() {
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    printString("scause: ");
    printInteger(Kernel::r_scause());
    printString("\nsepc: ");
    printInteger(Kernel::r_sepc());
    printString("\nstval: ");
    printInteger(Kernel::r_stval());
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
}