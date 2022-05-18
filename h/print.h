#ifndef PRINT_H
#define PRINT_H

#include "hw.h"

extern void printString(char const *string);

extern void printInteger(size_t integer);

// ispisuje poruku o gresci, odnosno vrednosti scause, sepc, stval u trenutku kad je nastala greska
extern void printError();

#endif //PRINT_H
