#ifndef KERNEL_H
#define KERNEL_H

#include "hw.h"

class Kernel {
public:

    // pop sstatus.spp and sstatus.spie bits (has to be a non inline function)
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause();

    // upisuje u registar scause (uzrok nastanka prekida)
    static void w_scause(size_t scause);

    // cita registar sepc
    static size_t r_sepc();

    // upisuje u registar sepc
    static void w_sepc(size_t sepc);

    // read register stvec
    static size_t r_stvec();

    // write register stvec
    static void w_stvec(size_t stvec);

    // read register stval
    static size_t r_stval();

    // write register stval
    static void w_stval(size_t stval);

    enum BitMaskSip
    {
        SIP_SSIE = (1 << 1), // da li su dozvoljeni softverski prekidi
        SIP_SEIE = (1 << 9), // da li su dozvoljeni spoljasnji hardverski prekidi
    };

    // postavljanje odredjenih bitova (BitMaskSip) u registar sip
    static void ms_sip(size_t mask);

    // brisanje odredjenih bitova (BitMaskSip) iz registra sip
    static void mc_sip(size_t mask);

    // citanje iz registra sip
    static size_t r_sip();

    // upis u registar sip
    static void w_sip(size_t sip);

    enum BitMaskSstatus
    {
        SSTATUS_SIE = (1 << 1),
        SSTATUS_SPIE = (1 << 5),
        SSTATUS_SPP = (1 << 8),
    };

    // mask set register sstatus
    static void ms_sstatus(size_t mask);

    // mask clear register sstatus
    static void mc_sstatus(size_t mask);

    // read register sstatus
    static size_t r_sstatus();

    // write register sstatus
    static void w_sstatus(size_t sstatus);

    // supervisor trap
    static void supervisorTrap();

private:

    // supervisor trap handler
    static void handleSupervisorTrap();

};



#endif //KERNEL_H
