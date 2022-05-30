# 1 "src/changeContext.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/riscv64-linux-gnu/include/stdc-predef.h" 1 3
# 32 "<command-line>" 2
# 1 "src/changeContext.S"
.global _ZN3PCB14switchContext1EPmS0_
_ZN3PCB14switchContext1EPmS0_:


    sd ra, 32 * 8(a0)
    sd sp, 0 * 8(a0)

    ld ra, 32 * 8(a1)
    ld sp, 2 * 8(a1)

    ret

.global _ZN3PCB14switchContext2EPmS0_
_ZN3PCB14switchContext2EPmS0_:


    sd ra, 32 * 8(a0)
    sd sp, 0 * 8(a0)

    ld ra, 32 * 8(a1)
    ld sp, 0 * 8(a1)

    ret
