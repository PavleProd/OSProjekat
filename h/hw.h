#pragma once

typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int  uint32;
typedef unsigned long size_t;

typedef size_t size_t;
typedef size_t time_t;

static const size_t DEFAULT_STACK_SIZE = 4096;
static const size_t DEFAULT_TIME_SLICE = 2;

extern const void* HEAP_START_ADDR;
extern const void* HEAP_END_ADDR;

static const size_t MEM_BLOCK_SIZE = 64;

extern const size_t CONSOLE_STATUS;
extern const size_t CONSOLE_TX_DATA;
extern const size_t CONSOLE_RX_DATA;

static const size_t CONSOLE_IRQ = 10;
static const size_t CONSOLE_TX_STATUS_BIT = 1 << 5;
static const size_t CONSOLE_RX_STATUS_BIT = 1;

#ifdef __cplusplus
extern "C" {
#endif

    int plic_claim(void);

    void plic_complete(int irq);

#ifdef __cplusplus
}
#endif
