#ifndef CHANGECONTEXT_H
#define CHANGECONTEXT_H
// Cuva sve programski dostupne registre x1..31 na stek, x0 je ozicen na 0
extern "C" inline void pushRegisters();

// Skida sa steka sve programski dostupne registre x1..x31, x0 je ozicen na 0
extern "C" inline void popRegisters();

#endif //CHANGECONTEXT_H
