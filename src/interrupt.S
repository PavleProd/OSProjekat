.extern interruptHandler
.align 4
.global interrupt
interrupt:
    call interruptHandler
    sret