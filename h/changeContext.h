#ifndef CHANGECONTEXT_H
#define CHANGECONTEXT_H
// Cuva sve programski dostupne registre x3..31 na stek, x0 je ozicen na 0, x1 je ra, x2 je sp (cuvaju se u posebnoj strukturi)
extern "C" void pushRegisters();

// Skida sa steka sve programski dostupne registre x3..x31, x0 je ozicen na 0, x1 je ra, x2 je sp (cuvaju se u posebnoj strukturi)
extern "C" void popRegisters();

#endif //CHANGECONTEXT_H
