.extern interruptHandler
.align 4
.global interrupt
interrupt:
    call interruptHandler
    csrc sip, 0x02 // brisemo zahtev za prekidom

    // uvecavanje sepc za 4
    csrr s6, sepc
    addi s6, s6, 4
    csrw sepc, s6

    sret