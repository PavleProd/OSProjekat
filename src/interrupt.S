.extern interruptHandler
.extern _ZN3PCB10getContextEv // vraca running->registers offset 0: ssp offset 2*8 : sp
.align 4
.global interrupt
interrupt:
    addi sp, sp, -16
    sd x1, 0 * 8(sp) // cuvamo ra
    sd x10, 1 * 8(sp) // cuvamo a0
    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    ld x1, 0 * 8(sp) // vracamo ra
    sd x1, 1 * 8(a0) // cuvamo ra na PCB
    ld x1, 1 * 8(sp) // vracamo a0
    addi sp, sp, 16
    sd x1, 10 * 8(a0) // cuvamo a0 na PCB

    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 // ra(x1) i a0(x10) smo vec sacuvali
    sd x\index, \index * 8(a0)
    .endr

    ld sp, 0 * 8(a0) // sp = ssp

    call interruptHandler

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre

    sd sp, 0 * 8(a0) // cuvamo ssp

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 // a0 ne cuvamo jer cemo ga rucno skinuti
    ld x\index, \index * 8(a0)
    .endr

    ld a0, 10 * 8(a0) // skidamo a0

    sret