#ifndef KERNEL_H
#define KERNEL_H

#include "hw.h"

class Kernel {
public:
    // postavlja code u registar a0
    static size_t setCode(size_t code) {
        return code;
    }

    // kodovi po kojima se prepoznaju sistemski pozivi
    enum sysCallCodes {
        mem_alloc = 0x01,
        mem_free = 0x02,
        thread_create = 0x11,
        thread_exit = 0x12,
        thread_dispatch = 0x13,
        thread_start = 0x14,
        sem_open = 0x21,
        sem_close = 0x22,
        sem_wait = 0x23,
        sem_signal = 0x24,
        time_sleep = 0x31,
        getc = 0x41,
        putc = 0x42
    };

    // pop sstatus.spp and sstatus.spie bits (has to be a non inline function)
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
        return scause;
    }

    // upisuje u registar scause (uzrok nastanka prekida)
    static void w_scause(size_t scause) {
        __asm__ volatile ("csrw scause, %[scause]" : : [scause] "r"(scause));
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
        return sepc;
    }

    // upisuje u registar sepc
    static void w_sepc(size_t sepc) {
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    }

    // read register stvec
    static size_t r_stvec() {
        size_t volatile stvec;
        __asm__ volatile ("csrr %[stvec], stvec" : [stvec] "=r"(stvec));
        return stvec;
    }

    // write register stvec
    static void w_stvec(size_t stvec) {
        __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    }

    // read register stval
    static size_t r_stval() {
        size_t volatile stval;
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
        return stval;
    }

    // write register stval
    static void w_stval(size_t stval) {
        __asm__ volatile ("csrw stval, %[stval]" : : [stval] "r"(stval));
    }

    enum BitMaskSip
    {
        SIP_SSIE = (1 << 1), // da li su dozvoljeni softverski prekidi
        SIP_SEIE = (1 << 9), // da li su dozvoljeni spoljasnji hardverski prekidi
    };

    // postavljanje odredjenih bitova (BitMaskSip) u registar sip
    static void ms_sip(size_t mask) {
        __asm__ volatile ("csrs sip, %[mask]" : : [mask] "r"(mask));
    }

    // brisanje odredjenih bitova (BitMaskSip) iz registra sip
    static void mc_sip(size_t mask) {
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    }

    // citanje iz registra sip
    static size_t r_sip() {
        size_t volatile sip;
        __asm__ volatile ("csrr %[sip], sip" : [sip] "=r"(sip));
        return sip;
    }

    // upis u registar sip
    static void w_sip(size_t sip) {
        __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
    }

    enum BitMaskSstatus
    {
        SSTATUS_SIE = (1 << 1), // ako je 0 - maskiranje spoljasnjih prekida u sistemskom rezimu
        SSTATUS_SPIE = (1 << 5), // prethodna vrednost sie
        SSTATUS_SPP = (1 << 8), // u kom rezimu se desio prekid
    };

    // mask set register sstatus
    static void ms_sstatus(size_t mask) {
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    }

    // mask clear register sstatus
    static void mc_sstatus(size_t mask) {
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
        return sstatus;
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    }
};

void userMain();


#endif //KERNEL_H
