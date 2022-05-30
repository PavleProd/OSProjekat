# 1 "src/interrupt.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/riscv64-linux-gnu/include/stdc-predef.h" 1 3
# 32 "<command-line>" 2
# 1 "src/interrupt.S"
.extern interruptHandler
.extern _ZN3PCB10getContextEv
.align 4
.global interrupt
interrupt:
    addi sp, sp, -16
    sd x1, 0 * 8(sp)
    sd x10, 1 * 8(sp)
    call _ZN3PCB10getContextEv
    ld x1, 0 * 8(sp)
    sd x1, 1 * 8(a0)
    ld x1, 1 * 8(sp)
    addi sp, sp, 16
    sd x1, 10 * 8(a0)


    .irp index, 2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(a0)
    .endr

    ld sp, 0 * 8(a0)

    call interruptHandler

    call _ZN3PCB10getContextEv

    sd sp, 0 * 8(a0)



    .irp index, 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(a0)
    .endr

    ld a0, 10 * 8(a0)

    sret
