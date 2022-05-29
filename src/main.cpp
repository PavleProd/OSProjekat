#include "../h/hw.h"
#include "../h/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"
#include "../h/syscall_cpp.h"
#include "../h/SCB.h"
#include "../h/buffer.hpp"
#include "../h/CCB.h"


// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void userMode() {
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    Kernel::mc_sstatus(Kernel::BitMaskSstatus::SSTATUS_SPP); // vraticemo se u korisnicki rezim
    size_t volatile sepc = Kernel::r_sepc();
    sepc += 4;
    Kernel::w_sepc(sepc);
    asm volatile("sret");
}

extern "C" void idleProcess(void* arg) {
    while(true) {}
}
// ------------

int main() {
    // Kernel inicijalizacija
    //asm volatile("csrw stvec, %0" : : "r" (&userMode));
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    PCB::running = main;

    sem_open(&CCB::semInput, 0);
    sem_open(&CCB::semOutput, 0);
    sem_open(&CCB::inputBufferEmpty, 0);

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit

    //asm volatile("ecall"); // da bismo presli u korisnicki rezim
    // ----
    putc('g');
    putc('d');
    //char c = getc();
    //putc(c);
    putc('e');
    putc(' ');
    putc('l');
    putc('a');
    putc('k');
    putc('o');
    //time_sleep(10);
    //userMain();
    //__putc('l');
    //while(true) {}
    //time_sleep(100);
    return 0;
}