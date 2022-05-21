.global _ZN3PCB14switchContext1EPmS0_ // switchContext kada se prvi put poziva, skidamo korisnicki stek
_ZN3PCB14switchContext1EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    sd sp, 0 * 8(a0)

    ld ra, 32 * 8(a1)
    ld sp, 2 * 8(a1)

    ret

.global _ZN3PCB14switchContext2EPmS0_ // switchContext kada se ne poziva prvi put, skidamo sistemski stek
_ZN3PCB14switchContext2EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    sd sp, 0 * 8(a0)

    ld ra, 32 * 8(a1)
    ld sp, 0 * 8(a1)

    ret