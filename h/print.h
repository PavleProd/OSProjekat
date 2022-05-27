#ifndef PRINT_H
#define PRINT_H

#include "hw.h"

extern "C" uint64 copy_and_swap(uint64 &lock, uint64 expected, uint64 desired);

void printString(char const *string);

char* getString(char *buf, int max);

int stringToInt(const char *s);

void printInt(int xx, int base=10, int sgn=0);

// ispisuje poruku o gresci, odnosno vrednosti scause, sepc, stval u trenutku kad je nastala greska
extern void printError();

#endif //PRINT_H
