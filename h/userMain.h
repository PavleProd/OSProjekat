#ifndef USERMAIN_H
#define USERMAIN_H

PCB* userProcess;

void userMain();
extern "C" void interrupt();
void userMode() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    Kernel::mc_sstatus(Kernel::BitMaskSstatus::SSTATUS_SPP); // vraticemo se u korisnicki rezim
    size_t volatile sepc = Kernel::r_sepc();
    sepc += 4;
    Kernel::w_sepc(sepc);
    asm volatile("sret");
}

void userMainWrapper(void*) {
    asm volatile("csrw stvec, %0" : : "r" (&userMode));
    asm volatile("ecall"); // da bismo presli u korisnicki rezim
    userMain();
}

#endif //USERMAIN_H
