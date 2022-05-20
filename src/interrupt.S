.extern interruptHandler
.align 4
.global interrupt
interrupt:
    // cuvanje registara x1..x31 na steku
    addi sp, sp, -256
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr

    call interruptHandler

    // upisujemo povratnu vrednost iz interruptHandlera u a0(x10) na steku da bi ostala nakon restauiranja
    sd a0, 10 * 8(sp)

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    addi sp, sp, 256

    sret