#ifndef USERMAIN_H
#define USERMAIN_H

PCB* userProcess = nullptr;

extern "C" void interrupt();
void userMode() {
    size_t code = Kernel::sysCallCodes::userMode;
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    userMode(); // prelazak u user mod
    userMain();
}

#endif //USERMAIN_H
