.extern handleInterrupt
.align 4
.global interrupt
interrupt:
    call handleInterrupt
    sret