
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00005117          	auipc	sp,0x5
    80000004:	7f013103          	ld	sp,2032(sp) # 800057f0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	044020ef          	jal	ra,80002060 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt>:
.extern pushRegisters
.align 4
.global interrupt
interrupt:
    // cuvanje registara x1..x31 na steku
    addi sp, sp, -256
    80001000:	f0010113          	addi	sp,sp,-256
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00213823          	sd	sp,16(sp)
    8000100c:	00313c23          	sd	gp,24(sp)
    80001010:	02413023          	sd	tp,32(sp)
    80001014:	02513423          	sd	t0,40(sp)
    80001018:	02613823          	sd	t1,48(sp)
    8000101c:	02713c23          	sd	t2,56(sp)
    80001020:	04813023          	sd	s0,64(sp)
    80001024:	04913423          	sd	s1,72(sp)
    80001028:	04a13823          	sd	a0,80(sp)
    8000102c:	04b13c23          	sd	a1,88(sp)
    80001030:	06c13023          	sd	a2,96(sp)
    80001034:	06d13423          	sd	a3,104(sp)
    80001038:	06e13823          	sd	a4,112(sp)
    8000103c:	06f13c23          	sd	a5,120(sp)
    80001040:	09013023          	sd	a6,128(sp)
    80001044:	09113423          	sd	a7,136(sp)
    80001048:	09213823          	sd	s2,144(sp)
    8000104c:	09313c23          	sd	s3,152(sp)
    80001050:	0b413023          	sd	s4,160(sp)
    80001054:	0b513423          	sd	s5,168(sp)
    80001058:	0b613823          	sd	s6,176(sp)
    8000105c:	0b713c23          	sd	s7,184(sp)
    80001060:	0d813023          	sd	s8,192(sp)
    80001064:	0d913423          	sd	s9,200(sp)
    80001068:	0da13823          	sd	s10,208(sp)
    8000106c:	0db13c23          	sd	s11,216(sp)
    80001070:	0fc13023          	sd	t3,224(sp)
    80001074:	0fd13423          	sd	t4,232(sp)
    80001078:	0fe13823          	sd	t5,240(sp)
    8000107c:	0ff13c23          	sd	t6,248(sp)

    call interruptHandler
    80001080:	23c000ef          	jal	ra,800012bc <interruptHandler>

    // upisujemo povratnu vrednost iz interruptHandlera u a0(x10) na steku da bi ostala nakon restauiranja
    sd a0, 10 * 8(sp)
    80001084:	04a13823          	sd	a0,80(sp)

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    80001088:	00813083          	ld	ra,8(sp)
    8000108c:	01013103          	ld	sp,16(sp)
    80001090:	01813183          	ld	gp,24(sp)
    80001094:	02013203          	ld	tp,32(sp)
    80001098:	02813283          	ld	t0,40(sp)
    8000109c:	03013303          	ld	t1,48(sp)
    800010a0:	03813383          	ld	t2,56(sp)
    800010a4:	04013403          	ld	s0,64(sp)
    800010a8:	04813483          	ld	s1,72(sp)
    800010ac:	05013503          	ld	a0,80(sp)
    800010b0:	05813583          	ld	a1,88(sp)
    800010b4:	06013603          	ld	a2,96(sp)
    800010b8:	06813683          	ld	a3,104(sp)
    800010bc:	07013703          	ld	a4,112(sp)
    800010c0:	07813783          	ld	a5,120(sp)
    800010c4:	08013803          	ld	a6,128(sp)
    800010c8:	08813883          	ld	a7,136(sp)
    800010cc:	09013903          	ld	s2,144(sp)
    800010d0:	09813983          	ld	s3,152(sp)
    800010d4:	0a013a03          	ld	s4,160(sp)
    800010d8:	0a813a83          	ld	s5,168(sp)
    800010dc:	0b013b03          	ld	s6,176(sp)
    800010e0:	0b813b83          	ld	s7,184(sp)
    800010e4:	0c013c03          	ld	s8,192(sp)
    800010e8:	0c813c83          	ld	s9,200(sp)
    800010ec:	0d013d03          	ld	s10,208(sp)
    800010f0:	0d813d83          	ld	s11,216(sp)
    800010f4:	0e013e03          	ld	t3,224(sp)
    800010f8:	0e813e83          	ld	t4,232(sp)
    800010fc:	0f013f03          	ld	t5,240(sp)
    80001100:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001104:	10010113          	addi	sp,sp,256

    80001108:	10200073          	sret
    8000110c:	0000                	unimp
	...

0000000080001110 <initKernel>:
initKernel:
    //zabrana prekida SIE
    //csrw stvec, interrupt // ecall ce skociti na interrupt
    // prebacivanje u korisnicki rezim SIP
    //dozvola prekid SIE
    80001110:	00008067          	ret

0000000080001114 <pushRegisters>:
.global pushRegisters
pushRegisters:
    addi sp, sp, -256
    80001114:	f0010113          	addi	sp,sp,-256
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001118:	00313c23          	sd	gp,24(sp)
    8000111c:	02413023          	sd	tp,32(sp)
    80001120:	02513423          	sd	t0,40(sp)
    80001124:	02613823          	sd	t1,48(sp)
    80001128:	02713c23          	sd	t2,56(sp)
    8000112c:	04813023          	sd	s0,64(sp)
    80001130:	04913423          	sd	s1,72(sp)
    80001134:	04a13823          	sd	a0,80(sp)
    80001138:	04b13c23          	sd	a1,88(sp)
    8000113c:	06c13023          	sd	a2,96(sp)
    80001140:	06d13423          	sd	a3,104(sp)
    80001144:	06e13823          	sd	a4,112(sp)
    80001148:	06f13c23          	sd	a5,120(sp)
    8000114c:	09013023          	sd	a6,128(sp)
    80001150:	09113423          	sd	a7,136(sp)
    80001154:	09213823          	sd	s2,144(sp)
    80001158:	09313c23          	sd	s3,152(sp)
    8000115c:	0b413023          	sd	s4,160(sp)
    80001160:	0b513423          	sd	s5,168(sp)
    80001164:	0b613823          	sd	s6,176(sp)
    80001168:	0b713c23          	sd	s7,184(sp)
    8000116c:	0d813023          	sd	s8,192(sp)
    80001170:	0d913423          	sd	s9,200(sp)
    80001174:	0da13823          	sd	s10,208(sp)
    80001178:	0db13c23          	sd	s11,216(sp)
    8000117c:	0fc13023          	sd	t3,224(sp)
    80001180:	0fd13423          	sd	t4,232(sp)
    80001184:	0fe13823          	sd	t5,240(sp)
    80001188:	0ff13c23          	sd	t6,248(sp)
    ret
    8000118c:	00008067          	ret

0000000080001190 <popRegisters>:
.global popRegisters
popRegisters:
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    80001190:	01813183          	ld	gp,24(sp)
    80001194:	02013203          	ld	tp,32(sp)
    80001198:	02813283          	ld	t0,40(sp)
    8000119c:	03013303          	ld	t1,48(sp)
    800011a0:	03813383          	ld	t2,56(sp)
    800011a4:	04013403          	ld	s0,64(sp)
    800011a8:	04813483          	ld	s1,72(sp)
    800011ac:	05013503          	ld	a0,80(sp)
    800011b0:	05813583          	ld	a1,88(sp)
    800011b4:	06013603          	ld	a2,96(sp)
    800011b8:	06813683          	ld	a3,104(sp)
    800011bc:	07013703          	ld	a4,112(sp)
    800011c0:	07813783          	ld	a5,120(sp)
    800011c4:	08013803          	ld	a6,128(sp)
    800011c8:	08813883          	ld	a7,136(sp)
    800011cc:	09013903          	ld	s2,144(sp)
    800011d0:	09813983          	ld	s3,152(sp)
    800011d4:	0a013a03          	ld	s4,160(sp)
    800011d8:	0a813a83          	ld	s5,168(sp)
    800011dc:	0b013b03          	ld	s6,176(sp)
    800011e0:	0b813b83          	ld	s7,184(sp)
    800011e4:	0c013c03          	ld	s8,192(sp)
    800011e8:	0c813c83          	ld	s9,200(sp)
    800011ec:	0d013d03          	ld	s10,208(sp)
    800011f0:	0d813d83          	ld	s11,216(sp)
    800011f4:	0e013e03          	ld	t3,224(sp)
    800011f8:	0e813e83          	ld	t4,232(sp)
    800011fc:	0f013f03          	ld	t5,240(sp)
    80001200:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001204:	10010113          	addi	sp,sp,256
    ret
    80001208:	00008067          	ret

000000008000120c <_ZN3PCB13switchContextEPNS_7ContextES1_>:

.global _ZN3PCB13switchContextEPNS_7ContextES1_ // switchContext
_ZN3PCB13switchContextEPNS_7ContextES1_:
    // a0 - &old->context
    // a1 - &running->context
    sd ra, 0 * 8(a0)
    8000120c:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001210:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001214:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001218:	0085b103          	ld	sp,8(a1)

    ret
    8000121c:	00008067          	ret

0000000080001220 <_Z13callInterruptv>:
#include "../h/kernel.h"
#include "../h/PCB.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001220:	ff010113          	addi	sp,sp,-16
    80001224:	00813423          	sd	s0,8(sp)
    80001228:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("ecall");
    8000122c:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001230:	00050513          	mv	a0,a0
    return res;
}
    80001234:	00813403          	ld	s0,8(sp)
    80001238:	01010113          	addi	sp,sp,16
    8000123c:	00008067          	ret

0000000080001240 <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00113423          	sd	ra,8(sp)
    80001248:	00813023          	sd	s0,0(sp)
    8000124c:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001250:	00655793          	srli	a5,a0,0x6
    80001254:	03f57513          	andi	a0,a0,63
    80001258:	00a03533          	snez	a0,a0
    8000125c:	00a78533          	add	a0,a5,a0
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    80001260:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    80001264:	00100793          	li	a5,1
    80001268:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    8000126c:	00000097          	auipc	ra,0x0
    80001270:	fb4080e7          	jalr	-76(ra) # 80001220 <_Z13callInterruptv>
}
    80001274:	00813083          	ld	ra,8(sp)
    80001278:	00013403          	ld	s0,0(sp)
    8000127c:	01010113          	addi	sp,sp,16
    80001280:	00008067          	ret

0000000080001284 <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    80001284:	ff010113          	addi	sp,sp,-16
    80001288:	00113423          	sd	ra,8(sp)
    8000128c:	00813023          	sd	s0,0(sp)
    80001290:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    80001294:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001298:	00200793          	li	a5,2
    8000129c:	00078513          	mv	a0,a5

    return (size_t)(callInterrupt());
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	f80080e7          	jalr	-128(ra) # 80001220 <_Z13callInterruptv>
}
    800012a8:	0005051b          	sext.w	a0,a0
    800012ac:	00813083          	ld	ra,8(sp)
    800012b0:	00013403          	ld	s0,0(sp)
    800012b4:	01010113          	addi	sp,sp,16
    800012b8:	00008067          	ret

00000000800012bc <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    800012bc:	fd010113          	addi	sp,sp,-48
    800012c0:	02113423          	sd	ra,40(sp)
    800012c4:	02813023          	sd	s0,32(sp)
    800012c8:	03010413          	addi	s0,sp,48
    size_t scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    800012cc:	14202773          	csrr	a4,scause
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800012d0:	141027f3          	csrr	a5,sepc
    800012d4:	fcf43c23          	sd	a5,-40(s0)
        return sepc;
    800012d8:	fd843783          	ld	a5,-40(s0)
    size_t volatile sepc = Kernel::r_sepc(); // TODO: pogledaj sta se desava ako se ne sacuva sepc
    800012dc:	fef43423          	sd	a5,-24(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800012e0:	100027f3          	csrr	a5,sstatus
    800012e4:	fcf43823          	sd	a5,-48(s0)
        return sstatus;
    800012e8:	fd043783          	ld	a5,-48(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    800012ec:	fef43023          	sd	a5,-32(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800012f0:	ff870693          	addi	a3,a4,-8
    800012f4:	00100793          	li	a5,1
    800012f8:	02d7f863          	bgeu	a5,a3,80001328 <interruptHandler+0x6c>
                break;
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800012fc:	fff00793          	li	a5,-1
    80001300:	03f79793          	slli	a5,a5,0x3f
    80001304:	00178793          	addi	a5,a5,1
    80001308:	0af70663          	beq	a4,a5,800013b4 <interruptHandler+0xf8>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    8000130c:	fff00793          	li	a5,-1
    80001310:	03f79793          	slli	a5,a5,0x3f
    80001314:	00978793          	addi	a5,a5,9
    80001318:	0ef70c63          	beq	a4,a5,80001410 <interruptHandler+0x154>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    8000131c:	00001097          	auipc	ra,0x1
    80001320:	cb8080e7          	jalr	-840(ra) # 80001fd4 <_Z10printErrorv>
    }

}
    80001324:	0580006f          	j	8000137c <interruptHandler+0xc0>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001328:	fe843783          	ld	a5,-24(s0)
    8000132c:	00478793          	addi	a5,a5,4
    80001330:	fef43423          	sd	a5,-24(s0)
        asm volatile("mv %0, a0" : "=r" (code));
    80001334:	00050793          	mv	a5,a0
        switch(code) {
    80001338:	00200713          	li	a4,2
    8000133c:	04e78863          	beq	a5,a4,8000138c <interruptHandler+0xd0>
    80001340:	01300713          	li	a4,19
    80001344:	04e78c63          	beq	a5,a4,8000139c <interruptHandler+0xe0>
    80001348:	00100713          	li	a4,1
    8000134c:	00e78863          	beq	a5,a4,8000135c <interruptHandler+0xa0>
                printError();
    80001350:	00001097          	auipc	ra,0x1
    80001354:	c84080e7          	jalr	-892(ra) # 80001fd4 <_Z10printErrorv>
                break;
    80001358:	0140006f          	j	8000136c <interruptHandler+0xb0>
                asm volatile("mv %0, a1" : "=r" (size));
    8000135c:	00058513          	mv	a0,a1
                MemoryAllocator::mem_alloc(size);
    80001360:	00651513          	slli	a0,a0,0x6
    80001364:	00001097          	auipc	ra,0x1
    80001368:	88c080e7          	jalr	-1908(ra) # 80001bf0 <_ZN15MemoryAllocator9mem_allocEm>
        Kernel::w_sepc(sepc);
    8000136c:	fe843783          	ld	a5,-24(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001370:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001374:	fe043783          	ld	a5,-32(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001378:	10079073          	csrw	sstatus,a5
}
    8000137c:	02813083          	ld	ra,40(sp)
    80001380:	02013403          	ld	s0,32(sp)
    80001384:	03010113          	addi	sp,sp,48
    80001388:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (memSegment));
    8000138c:	00058513          	mv	a0,a1
                MemoryAllocator::mem_free(memSegment);
    80001390:	00001097          	auipc	ra,0x1
    80001394:	9c4080e7          	jalr	-1596(ra) # 80001d54 <_ZN15MemoryAllocator8mem_freeEPv>
                break;
    80001398:	fd5ff06f          	j	8000136c <interruptHandler+0xb0>
                PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	11c080e7          	jalr	284(ra) # 800014b8 <_ZN3PCB8dispatchEv>
                PCB::timeSliceCounter = 0;
    800013a4:	00004797          	auipc	a5,0x4
    800013a8:	4447b783          	ld	a5,1092(a5) # 800057e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800013ac:	0007b023          	sd	zero,0(a5)
                break;
    800013b0:	fbdff06f          	j	8000136c <interruptHandler+0xb0>
        PCB::timeSliceCounter++;
    800013b4:	00004717          	auipc	a4,0x4
    800013b8:	43473703          	ld	a4,1076(a4) # 800057e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800013bc:	00073783          	ld	a5,0(a4)
    800013c0:	00178793          	addi	a5,a5,1
    800013c4:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800013c8:	00004717          	auipc	a4,0x4
    800013cc:	43073703          	ld	a4,1072(a4) # 800057f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	00073703          	ld	a4,0(a4)
    800013d4:	03073703          	ld	a4,48(a4)
    800013d8:	00e7f863          	bgeu	a5,a4,800013e8 <interruptHandler+0x12c>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800013dc:	00200793          	li	a5,2
    800013e0:	1447b073          	csrc	sip,a5
    }
    800013e4:	f99ff06f          	j	8000137c <interruptHandler+0xc0>
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	0d0080e7          	jalr	208(ra) # 800014b8 <_ZN3PCB8dispatchEv>
            PCB::timeSliceCounter = 0;
    800013f0:	00004797          	auipc	a5,0x4
    800013f4:	3f87b783          	ld	a5,1016(a5) # 800057e8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800013f8:	0007b023          	sd	zero,0(a5)
            Kernel::w_sepc(sepc);
    800013fc:	fe843783          	ld	a5,-24(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001400:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    80001404:	fe043783          	ld	a5,-32(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001408:	10079073          	csrw	sstatus,a5
    }
    8000140c:	fd1ff06f          	j	800013dc <interruptHandler+0x120>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    80001410:	00003097          	auipc	ra,0x3
    80001414:	d80080e7          	jalr	-640(ra) # 80004190 <console_handler>
    80001418:	f65ff06f          	j	8000137c <interruptHandler+0xc0>

000000008000141c <_ZN6Kernel10popSppSpieEv>:
#include "../h/kernel.h"

void Kernel::popSppSpie() {
    8000141c:	ff010113          	addi	sp,sp,-16
    80001420:	00813423          	sd	s0,8(sp)
    80001424:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001428:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    8000142c:	10200073          	sret
}
    80001430:	00813403          	ld	s0,8(sp)
    80001434:	01010113          	addi	sp,sp,16
    80001438:	00008067          	ret

000000008000143c <_ZN3PCB5yieldEv>:

PCB *PCB::createProccess(PCB::processMain main) {
    return new PCB(main, DEFAULT_TIME_SLICE);
}

void PCB::yield() {
    8000143c:	ff010113          	addi	sp,sp,-16
    80001440:	00813423          	sd	s0,8(sp)
    80001444:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code));
    80001448:	01300793          	li	a5,19
    8000144c:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001450:	00000073          	ecall
}
    80001454:	00813403          	ld	s0,8(sp)
    80001458:	01010113          	addi	sp,sp,16
    8000145c:	00008067          	ret

0000000080001460 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde
    80001460:	fe010113          	addi	sp,sp,-32
    80001464:	00113c23          	sd	ra,24(sp)
    80001468:	00813823          	sd	s0,16(sp)
    8000146c:	00913423          	sd	s1,8(sp)
    80001470:	02010413          	addi	s0,sp,32
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001474:	00000097          	auipc	ra,0x0
    80001478:	fa8080e7          	jalr	-88(ra) # 8000141c <_ZN6Kernel10popSppSpieEv>
    running->main();
    8000147c:	00004497          	auipc	s1,0x4
    80001480:	3d448493          	addi	s1,s1,980 # 80005850 <_ZN3PCB7runningE>
    80001484:	0004b783          	ld	a5,0(s1)
    80001488:	0207b783          	ld	a5,32(a5)
    8000148c:	000780e7          	jalr	a5
    running->setFinished(true);
    80001490:	0004b783          	ld	a5,0(s1)
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    }
    void setFinished(bool finished_) {
        finished = finished_;
    80001494:	00100713          	li	a4,1
    80001498:	02e78423          	sb	a4,40(a5)
    PCB::yield(); // nit je gotova pa predajemo procesor drugom precesu
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	fa0080e7          	jalr	-96(ra) # 8000143c <_ZN3PCB5yieldEv>
}
    800014a4:	01813083          	ld	ra,24(sp)
    800014a8:	01013403          	ld	s0,16(sp)
    800014ac:	00813483          	ld	s1,8(sp)
    800014b0:	02010113          	addi	sp,sp,32
    800014b4:	00008067          	ret

00000000800014b8 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    800014b8:	fe010113          	addi	sp,sp,-32
    800014bc:	00113c23          	sd	ra,24(sp)
    800014c0:	00813823          	sd	s0,16(sp)
    800014c4:	00913423          	sd	s1,8(sp)
    800014c8:	02010413          	addi	s0,sp,32
    PCB* old = running;
    800014cc:	00004497          	auipc	s1,0x4
    800014d0:	3844b483          	ld	s1,900(s1) # 80005850 <_ZN3PCB7runningE>
        return finished;
    800014d4:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()) {
    800014d8:	02078c63          	beqz	a5,80001510 <_ZN3PCB8dispatchEv+0x58>
    running = Scheduler::get();
    800014dc:	00000097          	auipc	ra,0x0
    800014e0:	238080e7          	jalr	568(ra) # 80001714 <_ZN9Scheduler3getEv>
    800014e4:	00004797          	auipc	a5,0x4
    800014e8:	36a7b623          	sd	a0,876(a5) # 80005850 <_ZN3PCB7runningE>
    switchContext(&old->context, &running->context);
    800014ec:	01050593          	addi	a1,a0,16
    800014f0:	01048513          	addi	a0,s1,16
    800014f4:	00000097          	auipc	ra,0x0
    800014f8:	d18080e7          	jalr	-744(ra) # 8000120c <_ZN3PCB13switchContextEPNS_7ContextES1_>
}
    800014fc:	01813083          	ld	ra,24(sp)
    80001500:	01013403          	ld	s0,16(sp)
    80001504:	00813483          	ld	s1,8(sp)
    80001508:	02010113          	addi	sp,sp,32
    8000150c:	00008067          	ret
        Scheduler::put(old);
    80001510:	00048513          	mv	a0,s1
    80001514:	00000097          	auipc	ra,0x0
    80001518:	1ac080e7          	jalr	428(ra) # 800016c0 <_ZN9Scheduler3putEP3PCB>
    8000151c:	fc1ff06f          	j	800014dc <_ZN3PCB8dispatchEv+0x24>

0000000080001520 <_ZN3PCBC1EPFvvEm>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_)
    80001520:	fd010113          	addi	sp,sp,-48
    80001524:	02113423          	sd	ra,40(sp)
    80001528:	02813023          	sd	s0,32(sp)
    8000152c:	00913c23          	sd	s1,24(sp)
    80001530:	01213823          	sd	s2,16(sp)
    80001534:	01313423          	sd	s3,8(sp)
    80001538:	03010413          	addi	s0,sp,48
    8000153c:	00050493          	mv	s1,a0
    80001540:	00058913          	mv	s2,a1
    80001544:	00060993          	mv	s3,a2
context({(size_t)(&proccessWrapper), stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    80001548:	00053023          	sd	zero,0(a0)
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
    8000154c:	06058463          	beqz	a1,800015b4 <_ZN3PCBC1EPFvvEm+0x94>
    80001550:	00008537          	lui	a0,0x8
    80001554:	00000097          	auipc	ra,0x0
    80001558:	624080e7          	jalr	1572(ra) # 80001b78 <_Znam>
context({(size_t)(&proccessWrapper), stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    8000155c:	00a4b423          	sd	a0,8(s1)
    80001560:	00000797          	auipc	a5,0x0
    80001564:	f0078793          	addi	a5,a5,-256 # 80001460 <_ZN3PCB15proccessWrapperEv>
    80001568:	00f4b823          	sd	a5,16(s1)
    8000156c:	04050863          	beqz	a0,800015bc <_ZN3PCBC1EPFvvEm+0x9c>
    80001570:	000087b7          	lui	a5,0x8
    80001574:	00f50533          	add	a0,a0,a5
    80001578:	00a4bc23          	sd	a0,24(s1)
    finished = false;
    8000157c:	02048423          	sb	zero,40(s1)
    main = main_;
    80001580:	0324b023          	sd	s2,32(s1)
    timeSlice = timeSlice_;
    80001584:	0334b823          	sd	s3,48(s1)
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    80001588:	00090863          	beqz	s2,80001598 <_ZN3PCBC1EPFvvEm+0x78>
    8000158c:	00048513          	mv	a0,s1
    80001590:	00000097          	auipc	ra,0x0
    80001594:	130080e7          	jalr	304(ra) # 800016c0 <_ZN9Scheduler3putEP3PCB>
}
    80001598:	02813083          	ld	ra,40(sp)
    8000159c:	02013403          	ld	s0,32(sp)
    800015a0:	01813483          	ld	s1,24(sp)
    800015a4:	01013903          	ld	s2,16(sp)
    800015a8:	00813983          	ld	s3,8(sp)
    800015ac:	03010113          	addi	sp,sp,48
    800015b0:	00008067          	ret
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
    800015b4:	00000513          	li	a0,0
    800015b8:	fa5ff06f          	j	8000155c <_ZN3PCBC1EPFvvEm+0x3c>
context({(size_t)(&proccessWrapper), stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    800015bc:	00000513          	li	a0,0
    800015c0:	fb9ff06f          	j	80001578 <_ZN3PCBC1EPFvvEm+0x58>

00000000800015c4 <_ZN3PCBD1Ev>:
    delete[] stack;
    800015c4:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    800015c8:	02050663          	beqz	a0,800015f4 <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    800015cc:	ff010113          	addi	sp,sp,-16
    800015d0:	00113423          	sd	ra,8(sp)
    800015d4:	00813023          	sd	s0,0(sp)
    800015d8:	01010413          	addi	s0,sp,16
    delete[] stack;
    800015dc:	00000097          	auipc	ra,0x0
    800015e0:	5ec080e7          	jalr	1516(ra) # 80001bc8 <_ZdaPv>
}
    800015e4:	00813083          	ld	ra,8(sp)
    800015e8:	00013403          	ld	s0,0(sp)
    800015ec:	01010113          	addi	sp,sp,16
    800015f0:	00008067          	ret
    800015f4:	00008067          	ret

00000000800015f8 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    800015f8:	ff010113          	addi	sp,sp,-16
    800015fc:	00113423          	sd	ra,8(sp)
    80001600:	00813023          	sd	s0,0(sp)
    80001604:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	5e8080e7          	jalr	1512(ra) # 80001bf0 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001610:	00813083          	ld	ra,8(sp)
    80001614:	00013403          	ld	s0,0(sp)
    80001618:	01010113          	addi	sp,sp,16
    8000161c:	00008067          	ret

0000000080001620 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001620:	ff010113          	addi	sp,sp,-16
    80001624:	00113423          	sd	ra,8(sp)
    80001628:	00813023          	sd	s0,0(sp)
    8000162c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001630:	00000097          	auipc	ra,0x0
    80001634:	724080e7          	jalr	1828(ra) # 80001d54 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001638:	00813083          	ld	ra,8(sp)
    8000163c:	00013403          	ld	s0,0(sp)
    80001640:	01010113          	addi	sp,sp,16
    80001644:	00008067          	ret

0000000080001648 <_ZN3PCB14createProccessEPFvvE>:
PCB *PCB::createProccess(PCB::processMain main) {
    80001648:	fe010113          	addi	sp,sp,-32
    8000164c:	00113c23          	sd	ra,24(sp)
    80001650:	00813823          	sd	s0,16(sp)
    80001654:	00913423          	sd	s1,8(sp)
    80001658:	01213023          	sd	s2,0(sp)
    8000165c:	02010413          	addi	s0,sp,32
    80001660:	00050913          	mv	s2,a0
    return new PCB(main, DEFAULT_TIME_SLICE);
    80001664:	03800513          	li	a0,56
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	f90080e7          	jalr	-112(ra) # 800015f8 <_ZN3PCBnwEm>
    80001670:	00050493          	mv	s1,a0
    80001674:	00200613          	li	a2,2
    80001678:	00090593          	mv	a1,s2
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	ea4080e7          	jalr	-348(ra) # 80001520 <_ZN3PCBC1EPFvvEm>
    80001684:	0200006f          	j	800016a4 <_ZN3PCB14createProccessEPFvvE+0x5c>
    80001688:	00050913          	mv	s2,a0
    8000168c:	00048513          	mv	a0,s1
    80001690:	00000097          	auipc	ra,0x0
    80001694:	f90080e7          	jalr	-112(ra) # 80001620 <_ZN3PCBdlEPv>
    80001698:	00090513          	mv	a0,s2
    8000169c:	00005097          	auipc	ra,0x5
    800016a0:	2ac080e7          	jalr	684(ra) # 80006948 <_Unwind_Resume>
}
    800016a4:	00048513          	mv	a0,s1
    800016a8:	01813083          	ld	ra,24(sp)
    800016ac:	01013403          	ld	s0,16(sp)
    800016b0:	00813483          	ld	s1,8(sp)
    800016b4:	00013903          	ld	s2,0(sp)
    800016b8:	02010113          	addi	sp,sp,32
    800016bc:	00008067          	ret

00000000800016c0 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800016c0:	ff010113          	addi	sp,sp,-16
    800016c4:	00813423          	sd	s0,8(sp)
    800016c8:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    800016cc:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800016d0:	00004797          	auipc	a5,0x4
    800016d4:	1907b783          	ld	a5,400(a5) # 80005860 <_ZN9Scheduler4tailE>
    800016d8:	02078463          	beqz	a5,80001700 <_ZN9Scheduler3putEP3PCB+0x40>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    800016dc:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextReady;
    800016e0:	00004797          	auipc	a5,0x4
    800016e4:	18078793          	addi	a5,a5,384 # 80005860 <_ZN9Scheduler4tailE>
    800016e8:	0007b703          	ld	a4,0(a5)
    800016ec:	00073703          	ld	a4,0(a4)
    800016f0:	00e7b023          	sd	a4,0(a5)
    }
}
    800016f4:	00813403          	ld	s0,8(sp)
    800016f8:	01010113          	addi	sp,sp,16
    800016fc:	00008067          	ret
        head = tail = process;
    80001700:	00004797          	auipc	a5,0x4
    80001704:	16078793          	addi	a5,a5,352 # 80005860 <_ZN9Scheduler4tailE>
    80001708:	00a7b023          	sd	a0,0(a5)
    8000170c:	00a7b423          	sd	a0,8(a5)
    80001710:	fe5ff06f          	j	800016f4 <_ZN9Scheduler3putEP3PCB+0x34>

0000000080001714 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001714:	ff010113          	addi	sp,sp,-16
    80001718:	00813423          	sd	s0,8(sp)
    8000171c:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001720:	00004517          	auipc	a0,0x4
    80001724:	14853503          	ld	a0,328(a0) # 80005868 <_ZN9Scheduler4headE>
    80001728:	02050463          	beqz	a0,80001750 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    8000172c:	00053703          	ld	a4,0(a0)
    80001730:	00004797          	auipc	a5,0x4
    80001734:	13078793          	addi	a5,a5,304 # 80005860 <_ZN9Scheduler4tailE>
    80001738:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    8000173c:	0007b783          	ld	a5,0(a5)
    80001740:	00f50e63          	beq	a0,a5,8000175c <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001744:	00813403          	ld	s0,8(sp)
    80001748:	01010113          	addi	sp,sp,16
    8000174c:	00008067          	ret
        return idleProcess;
    80001750:	00004517          	auipc	a0,0x4
    80001754:	12053503          	ld	a0,288(a0) # 80005870 <_ZN9Scheduler11idleProcessE>
    80001758:	fedff06f          	j	80001744 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    8000175c:	00004797          	auipc	a5,0x4
    80001760:	10e7b223          	sd	a4,260(a5) # 80005860 <_ZN9Scheduler4tailE>
    80001764:	fe1ff06f          	j	80001744 <_ZN9Scheduler3getEv+0x30>

0000000080001768 <_ZL9fibonaccim>:
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"

static size_t fibonacci(size_t n)
{
    80001768:	fe010113          	addi	sp,sp,-32
    8000176c:	00113c23          	sd	ra,24(sp)
    80001770:	00813823          	sd	s0,16(sp)
    80001774:	00913423          	sd	s1,8(sp)
    80001778:	01213023          	sd	s2,0(sp)
    8000177c:	02010413          	addi	s0,sp,32
    80001780:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001784:	00100793          	li	a5,1
    80001788:	02a7f663          	bgeu	a5,a0,800017b4 <_ZL9fibonaccim+0x4c>
    if (n % 4 == 0) PCB::yield();
    8000178c:	00357793          	andi	a5,a0,3
    80001790:	02078e63          	beqz	a5,800017cc <_ZL9fibonaccim+0x64>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001794:	fff48513          	addi	a0,s1,-1
    80001798:	00000097          	auipc	ra,0x0
    8000179c:	fd0080e7          	jalr	-48(ra) # 80001768 <_ZL9fibonaccim>
    800017a0:	00050913          	mv	s2,a0
    800017a4:	ffe48513          	addi	a0,s1,-2
    800017a8:	00000097          	auipc	ra,0x0
    800017ac:	fc0080e7          	jalr	-64(ra) # 80001768 <_ZL9fibonaccim>
    800017b0:	00a90533          	add	a0,s2,a0
}
    800017b4:	01813083          	ld	ra,24(sp)
    800017b8:	01013403          	ld	s0,16(sp)
    800017bc:	00813483          	ld	s1,8(sp)
    800017c0:	00013903          	ld	s2,0(sp)
    800017c4:	02010113          	addi	sp,sp,32
    800017c8:	00008067          	ret
    if (n % 4 == 0) PCB::yield();
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	c70080e7          	jalr	-912(ra) # 8000143c <_ZN3PCB5yieldEv>
    800017d4:	fc1ff06f          	j	80001794 <_ZL9fibonaccim+0x2c>

00000000800017d8 <_Z11workerBodyAv>:

void workerBodyA()
{
    800017d8:	fe010113          	addi	sp,sp,-32
    800017dc:	00113c23          	sd	ra,24(sp)
    800017e0:	00813823          	sd	s0,16(sp)
    800017e4:	00913423          	sd	s1,8(sp)
    800017e8:	01213023          	sd	s2,0(sp)
    800017ec:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800017f0:	00000493          	li	s1,0
    800017f4:	0380006f          	j	8000182c <_Z11workerBodyAv+0x54>
    for (; i < 3; i++)
    {
        printString("A: i=");
    800017f8:	00004517          	auipc	a0,0x4
    800017fc:	82850513          	addi	a0,a0,-2008 # 80005020 <CONSOLE_STATUS+0x10>
    80001800:	00000097          	auipc	ra,0x0
    80001804:	700080e7          	jalr	1792(ra) # 80001f00 <_Z11printStringPKc>
        printInteger(i);
    80001808:	00048513          	mv	a0,s1
    8000180c:	00000097          	auipc	ra,0x0
    80001810:	738080e7          	jalr	1848(ra) # 80001f44 <_Z12printIntegerm>
        printString("\n");
    80001814:	00004517          	auipc	a0,0x4
    80001818:	81c50513          	addi	a0,a0,-2020 # 80005030 <CONSOLE_STATUS+0x20>
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	6e4080e7          	jalr	1764(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++)
    80001824:	0014849b          	addiw	s1,s1,1
    80001828:	0ff4f493          	andi	s1,s1,255
    8000182c:	00200793          	li	a5,2
    80001830:	fc97f4e3          	bgeu	a5,s1,800017f8 <_Z11workerBodyAv+0x20>
    }

    printString("A: yield\n");
    80001834:	00003517          	auipc	a0,0x3
    80001838:	7f450513          	addi	a0,a0,2036 # 80005028 <CONSOLE_STATUS+0x18>
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	6c4080e7          	jalr	1732(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001844:	00700313          	li	t1,7
    PCB::yield();
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	bf4080e7          	jalr	-1036(ra) # 8000143c <_ZN3PCB5yieldEv>

    size_t t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001850:	00030913          	mv	s2,t1

    printString("A: t1=");
    80001854:	00003517          	auipc	a0,0x3
    80001858:	7e450513          	addi	a0,a0,2020 # 80005038 <CONSOLE_STATUS+0x28>
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	6a4080e7          	jalr	1700(ra) # 80001f00 <_Z11printStringPKc>
    printInteger(t1);
    80001864:	00090513          	mv	a0,s2
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	6dc080e7          	jalr	1756(ra) # 80001f44 <_Z12printIntegerm>
    printString("\n");
    80001870:	00003517          	auipc	a0,0x3
    80001874:	7c050513          	addi	a0,a0,1984 # 80005030 <CONSOLE_STATUS+0x20>
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	688080e7          	jalr	1672(ra) # 80001f00 <_Z11printStringPKc>

    size_t result = fibonacci(20);
    80001880:	01400513          	li	a0,20
    80001884:	00000097          	auipc	ra,0x0
    80001888:	ee4080e7          	jalr	-284(ra) # 80001768 <_ZL9fibonaccim>
    8000188c:	00050913          	mv	s2,a0
    printString("A: fibonaci=");
    80001890:	00003517          	auipc	a0,0x3
    80001894:	7b050513          	addi	a0,a0,1968 # 80005040 <CONSOLE_STATUS+0x30>
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	668080e7          	jalr	1640(ra) # 80001f00 <_Z11printStringPKc>
    printInteger(result);
    800018a0:	00090513          	mv	a0,s2
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	6a0080e7          	jalr	1696(ra) # 80001f44 <_Z12printIntegerm>
    printString("\n");
    800018ac:	00003517          	auipc	a0,0x3
    800018b0:	78450513          	addi	a0,a0,1924 # 80005030 <CONSOLE_STATUS+0x20>
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	64c080e7          	jalr	1612(ra) # 80001f00 <_Z11printStringPKc>
    800018bc:	0380006f          	j	800018f4 <_Z11workerBodyAv+0x11c>

    for (; i < 6; i++)
    {
        printString("A: i=");
    800018c0:	00003517          	auipc	a0,0x3
    800018c4:	76050513          	addi	a0,a0,1888 # 80005020 <CONSOLE_STATUS+0x10>
    800018c8:	00000097          	auipc	ra,0x0
    800018cc:	638080e7          	jalr	1592(ra) # 80001f00 <_Z11printStringPKc>
        printInteger(i);
    800018d0:	00048513          	mv	a0,s1
    800018d4:	00000097          	auipc	ra,0x0
    800018d8:	670080e7          	jalr	1648(ra) # 80001f44 <_Z12printIntegerm>
        printString("\n");
    800018dc:	00003517          	auipc	a0,0x3
    800018e0:	75450513          	addi	a0,a0,1876 # 80005030 <CONSOLE_STATUS+0x20>
    800018e4:	00000097          	auipc	ra,0x0
    800018e8:	61c080e7          	jalr	1564(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++)
    800018ec:	0014849b          	addiw	s1,s1,1
    800018f0:	0ff4f493          	andi	s1,s1,255
    800018f4:	00500793          	li	a5,5
    800018f8:	fc97f4e3          	bgeu	a5,s1,800018c0 <_Z11workerBodyAv+0xe8>
    }

    PCB::running->setFinished(true);
    800018fc:	00004797          	auipc	a5,0x4
    80001900:	efc7b783          	ld	a5,-260(a5) # 800057f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001904:	0007b783          	ld	a5,0(a5)
        finished = finished_;
    80001908:	00100713          	li	a4,1
    8000190c:	02e78423          	sb	a4,40(a5)
    PCB::yield();
    80001910:	00000097          	auipc	ra,0x0
    80001914:	b2c080e7          	jalr	-1236(ra) # 8000143c <_ZN3PCB5yieldEv>
}
    80001918:	01813083          	ld	ra,24(sp)
    8000191c:	01013403          	ld	s0,16(sp)
    80001920:	00813483          	ld	s1,8(sp)
    80001924:	00013903          	ld	s2,0(sp)
    80001928:	02010113          	addi	sp,sp,32
    8000192c:	00008067          	ret

0000000080001930 <_Z11workerBodyBv>:

void workerBodyB()
{
    80001930:	fe010113          	addi	sp,sp,-32
    80001934:	00113c23          	sd	ra,24(sp)
    80001938:	00813823          	sd	s0,16(sp)
    8000193c:	00913423          	sd	s1,8(sp)
    80001940:	01213023          	sd	s2,0(sp)
    80001944:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001948:	00a00493          	li	s1,10
    8000194c:	0380006f          	j	80001984 <_Z11workerBodyBv+0x54>
    for (; i < 13; i++)
    {
        printString("B: i=");
    80001950:	00003517          	auipc	a0,0x3
    80001954:	70050513          	addi	a0,a0,1792 # 80005050 <CONSOLE_STATUS+0x40>
    80001958:	00000097          	auipc	ra,0x0
    8000195c:	5a8080e7          	jalr	1448(ra) # 80001f00 <_Z11printStringPKc>
        printInteger(i);
    80001960:	00048513          	mv	a0,s1
    80001964:	00000097          	auipc	ra,0x0
    80001968:	5e0080e7          	jalr	1504(ra) # 80001f44 <_Z12printIntegerm>
        printString("\n");
    8000196c:	00003517          	auipc	a0,0x3
    80001970:	6c450513          	addi	a0,a0,1732 # 80005030 <CONSOLE_STATUS+0x20>
    80001974:	00000097          	auipc	ra,0x0
    80001978:	58c080e7          	jalr	1420(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++)
    8000197c:	0014849b          	addiw	s1,s1,1
    80001980:	0ff4f493          	andi	s1,s1,255
    80001984:	00c00793          	li	a5,12
    80001988:	fc97f4e3          	bgeu	a5,s1,80001950 <_Z11workerBodyBv+0x20>
    }

    printString("B: yield\n");
    8000198c:	00003517          	auipc	a0,0x3
    80001990:	6cc50513          	addi	a0,a0,1740 # 80005058 <CONSOLE_STATUS+0x48>
    80001994:	00000097          	auipc	ra,0x0
    80001998:	56c080e7          	jalr	1388(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000199c:	00500313          	li	t1,5
    PCB::yield();
    800019a0:	00000097          	auipc	ra,0x0
    800019a4:	a9c080e7          	jalr	-1380(ra) # 8000143c <_ZN3PCB5yieldEv>

    size_t result = fibonacci(23);
    800019a8:	01700513          	li	a0,23
    800019ac:	00000097          	auipc	ra,0x0
    800019b0:	dbc080e7          	jalr	-580(ra) # 80001768 <_ZL9fibonaccim>
    800019b4:	00050913          	mv	s2,a0
    printString("A: fibonaci=");
    800019b8:	00003517          	auipc	a0,0x3
    800019bc:	68850513          	addi	a0,a0,1672 # 80005040 <CONSOLE_STATUS+0x30>
    800019c0:	00000097          	auipc	ra,0x0
    800019c4:	540080e7          	jalr	1344(ra) # 80001f00 <_Z11printStringPKc>
    printInteger(result);
    800019c8:	00090513          	mv	a0,s2
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	578080e7          	jalr	1400(ra) # 80001f44 <_Z12printIntegerm>
    printString("\n");
    800019d4:	00003517          	auipc	a0,0x3
    800019d8:	65c50513          	addi	a0,a0,1628 # 80005030 <CONSOLE_STATUS+0x20>
    800019dc:	00000097          	auipc	ra,0x0
    800019e0:	524080e7          	jalr	1316(ra) # 80001f00 <_Z11printStringPKc>
    800019e4:	0380006f          	j	80001a1c <_Z11workerBodyBv+0xec>

    for (; i < 16; i++)
    {
        printString("B: i=");
    800019e8:	00003517          	auipc	a0,0x3
    800019ec:	66850513          	addi	a0,a0,1640 # 80005050 <CONSOLE_STATUS+0x40>
    800019f0:	00000097          	auipc	ra,0x0
    800019f4:	510080e7          	jalr	1296(ra) # 80001f00 <_Z11printStringPKc>
        printInteger(i);
    800019f8:	00048513          	mv	a0,s1
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	548080e7          	jalr	1352(ra) # 80001f44 <_Z12printIntegerm>
        printString("\n");
    80001a04:	00003517          	auipc	a0,0x3
    80001a08:	62c50513          	addi	a0,a0,1580 # 80005030 <CONSOLE_STATUS+0x20>
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	4f4080e7          	jalr	1268(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++)
    80001a14:	0014849b          	addiw	s1,s1,1
    80001a18:	0ff4f493          	andi	s1,s1,255
    80001a1c:	00f00793          	li	a5,15
    80001a20:	fc97f4e3          	bgeu	a5,s1,800019e8 <_Z11workerBodyBv+0xb8>
    }

    PCB::running->setFinished(true);
    80001a24:	00004797          	auipc	a5,0x4
    80001a28:	dd47b783          	ld	a5,-556(a5) # 800057f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001a2c:	0007b783          	ld	a5,0(a5)
    80001a30:	00100713          	li	a4,1
    80001a34:	02e78423          	sb	a4,40(a5)
    PCB::yield();
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	a04080e7          	jalr	-1532(ra) # 8000143c <_ZN3PCB5yieldEv>
}
    80001a40:	01813083          	ld	ra,24(sp)
    80001a44:	01013403          	ld	s0,16(sp)
    80001a48:	00813483          	ld	s1,8(sp)
    80001a4c:	00013903          	ld	s2,0(sp)
    80001a50:	02010113          	addi	sp,sp,32
    80001a54:	00008067          	ret

0000000080001a58 <main>:

extern "C" void interrupt();
int main() {
    80001a58:	fc010113          	addi	sp,sp,-64
    80001a5c:	02113c23          	sd	ra,56(sp)
    80001a60:	02813823          	sd	s0,48(sp)
    80001a64:	02913423          	sd	s1,40(sp)
    80001a68:	03213023          	sd	s2,32(sp)
    80001a6c:	04010413          	addi	s0,sp,64

    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001a70:	00004797          	auipc	a5,0x4
    80001a74:	d987b783          	ld	a5,-616(a5) # 80005808 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001a78:	10579073          	csrw	stvec,a5
    PCB* procesi[3];
    procesi[0] = PCB::createProccess(nullptr); // main
    80001a7c:	00000513          	li	a0,0
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	bc8080e7          	jalr	-1080(ra) # 80001648 <_ZN3PCB14createProccessEPFvvE>
    80001a88:	fca43423          	sd	a0,-56(s0)
    PCB::running = procesi[0];
    80001a8c:	00004797          	auipc	a5,0x4
    80001a90:	d6c7b783          	ld	a5,-660(a5) # 800057f8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001a94:	00a7b023          	sd	a0,0(a5)

    procesi[1] = PCB::createProccess(workerBodyA);
    80001a98:	00000517          	auipc	a0,0x0
    80001a9c:	d4050513          	addi	a0,a0,-704 # 800017d8 <_Z11workerBodyAv>
    80001aa0:	00000097          	auipc	ra,0x0
    80001aa4:	ba8080e7          	jalr	-1112(ra) # 80001648 <_ZN3PCB14createProccessEPFvvE>
    80001aa8:	fca43823          	sd	a0,-48(s0)
    __putc('a');
    80001aac:	06100513          	li	a0,97
    80001ab0:	00002097          	auipc	ra,0x2
    80001ab4:	66c080e7          	jalr	1644(ra) # 8000411c <__putc>
    procesi[2] = PCB::createProccess(workerBodyB);
    80001ab8:	00000517          	auipc	a0,0x0
    80001abc:	e7850513          	addi	a0,a0,-392 # 80001930 <_Z11workerBodyBv>
    80001ac0:	00000097          	auipc	ra,0x0
    80001ac4:	b88080e7          	jalr	-1144(ra) # 80001648 <_ZN3PCB14createProccessEPFvvE>
    80001ac8:	fca43c23          	sd	a0,-40(s0)
    __putc('b');
    80001acc:	06200513          	li	a0,98
    80001ad0:	00002097          	auipc	ra,0x2
    80001ad4:	64c080e7          	jalr	1612(ra) # 8000411c <__putc>
    80001ad8:	00c0006f          	j	80001ae4 <main+0x8c>

    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
        PCB::yield();
    80001adc:	00000097          	auipc	ra,0x0
    80001ae0:	960080e7          	jalr	-1696(ra) # 8000143c <_ZN3PCB5yieldEv>
    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
    80001ae4:	fd043783          	ld	a5,-48(s0)
        return finished;
    80001ae8:	0287c783          	lbu	a5,40(a5)
    80001aec:	fe0788e3          	beqz	a5,80001adc <main+0x84>
    80001af0:	fd843783          	ld	a5,-40(s0)
    80001af4:	0287c783          	lbu	a5,40(a5)
    80001af8:	fe0782e3          	beqz	a5,80001adc <main+0x84>
    80001afc:	fc840493          	addi	s1,s0,-56
    80001b00:	0080006f          	j	80001b08 <main+0xb0>
    }

    for(auto& pcb : procesi) {
    80001b04:	00848493          	addi	s1,s1,8
    80001b08:	fe040793          	addi	a5,s0,-32
    80001b0c:	02f48463          	beq	s1,a5,80001b34 <main+0xdc>
        delete pcb;
    80001b10:	0004b903          	ld	s2,0(s1)
    80001b14:	fe0908e3          	beqz	s2,80001b04 <main+0xac>
    80001b18:	00090513          	mv	a0,s2
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	aa8080e7          	jalr	-1368(ra) # 800015c4 <_ZN3PCBD1Ev>
    80001b24:	00090513          	mv	a0,s2
    80001b28:	00000097          	auipc	ra,0x0
    80001b2c:	af8080e7          	jalr	-1288(ra) # 80001620 <_ZN3PCBdlEPv>
    80001b30:	fd5ff06f          	j	80001b04 <main+0xac>
    }

    return 0;
}
    80001b34:	00000513          	li	a0,0
    80001b38:	03813083          	ld	ra,56(sp)
    80001b3c:	03013403          	ld	s0,48(sp)
    80001b40:	02813483          	ld	s1,40(sp)
    80001b44:	02013903          	ld	s2,32(sp)
    80001b48:	04010113          	addi	sp,sp,64
    80001b4c:	00008067          	ret

0000000080001b50 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001b50:	ff010113          	addi	sp,sp,-16
    80001b54:	00113423          	sd	ra,8(sp)
    80001b58:	00813023          	sd	s0,0(sp)
    80001b5c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001b60:	fffff097          	auipc	ra,0xfffff
    80001b64:	6e0080e7          	jalr	1760(ra) # 80001240 <_Z9mem_allocm>
}
    80001b68:	00813083          	ld	ra,8(sp)
    80001b6c:	00013403          	ld	s0,0(sp)
    80001b70:	01010113          	addi	sp,sp,16
    80001b74:	00008067          	ret

0000000080001b78 <_Znam>:
void* operator new [](size_t size) {
    80001b78:	ff010113          	addi	sp,sp,-16
    80001b7c:	00113423          	sd	ra,8(sp)
    80001b80:	00813023          	sd	s0,0(sp)
    80001b84:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001b88:	fffff097          	auipc	ra,0xfffff
    80001b8c:	6b8080e7          	jalr	1720(ra) # 80001240 <_Z9mem_allocm>
}
    80001b90:	00813083          	ld	ra,8(sp)
    80001b94:	00013403          	ld	s0,0(sp)
    80001b98:	01010113          	addi	sp,sp,16
    80001b9c:	00008067          	ret

0000000080001ba0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001ba0:	ff010113          	addi	sp,sp,-16
    80001ba4:	00113423          	sd	ra,8(sp)
    80001ba8:	00813023          	sd	s0,0(sp)
    80001bac:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001bb0:	fffff097          	auipc	ra,0xfffff
    80001bb4:	6d4080e7          	jalr	1748(ra) # 80001284 <_Z8mem_freePv>
}
    80001bb8:	00813083          	ld	ra,8(sp)
    80001bbc:	00013403          	ld	s0,0(sp)
    80001bc0:	01010113          	addi	sp,sp,16
    80001bc4:	00008067          	ret

0000000080001bc8 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001bc8:	ff010113          	addi	sp,sp,-16
    80001bcc:	00113423          	sd	ra,8(sp)
    80001bd0:	00813023          	sd	s0,0(sp)
    80001bd4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001bd8:	fffff097          	auipc	ra,0xfffff
    80001bdc:	6ac080e7          	jalr	1708(ra) # 80001284 <_Z8mem_freePv>
    80001be0:	00813083          	ld	ra,8(sp)
    80001be4:	00013403          	ld	s0,0(sp)
    80001be8:	01010113          	addi	sp,sp,16
    80001bec:	00008067          	ret

0000000080001bf0 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001bf0:	ff010113          	addi	sp,sp,-16
    80001bf4:	00813423          	sd	s0,8(sp)
    80001bf8:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001bfc:	00004797          	auipc	a5,0x4
    80001c00:	c7c7b783          	ld	a5,-900(a5) # 80005878 <_ZN15MemoryAllocator4headE>
    80001c04:	02078c63          	beqz	a5,80001c3c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001c08:	00004717          	auipc	a4,0x4
    80001c0c:	bf873703          	ld	a4,-1032(a4) # 80005800 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001c10:	00073703          	ld	a4,0(a4)
    80001c14:	12e78c63          	beq	a5,a4,80001d4c <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001c18:	00850713          	addi	a4,a0,8
    80001c1c:	00675813          	srli	a6,a4,0x6
    80001c20:	03f77793          	andi	a5,a4,63
    80001c24:	00f037b3          	snez	a5,a5
    80001c28:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001c2c:	00004517          	auipc	a0,0x4
    80001c30:	c4c53503          	ld	a0,-948(a0) # 80005878 <_ZN15MemoryAllocator4headE>
    80001c34:	00000613          	li	a2,0
    80001c38:	0a80006f          	j	80001ce0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001c3c:	00004697          	auipc	a3,0x4
    80001c40:	ba46b683          	ld	a3,-1116(a3) # 800057e0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001c44:	0006b783          	ld	a5,0(a3)
    80001c48:	00004717          	auipc	a4,0x4
    80001c4c:	c2f73823          	sd	a5,-976(a4) # 80005878 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001c50:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80001c54:	00004717          	auipc	a4,0x4
    80001c58:	bac73703          	ld	a4,-1108(a4) # 80005800 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001c5c:	00073703          	ld	a4,0(a4)
    80001c60:	0006b683          	ld	a3,0(a3)
    80001c64:	40d70733          	sub	a4,a4,a3
    80001c68:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001c6c:	0007b823          	sd	zero,16(a5)
    80001c70:	fa9ff06f          	j	80001c18 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001c74:	00060e63          	beqz	a2,80001c90 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001c78:	01063703          	ld	a4,16(a2)
    80001c7c:	04070a63          	beqz	a4,80001cd0 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001c80:	01073703          	ld	a4,16(a4)
    80001c84:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80001c88:	00078813          	mv	a6,a5
    80001c8c:	0ac0006f          	j	80001d38 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001c90:	01053703          	ld	a4,16(a0)
    80001c94:	00070a63          	beqz	a4,80001ca8 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001c98:	00004697          	auipc	a3,0x4
    80001c9c:	bee6b023          	sd	a4,-1056(a3) # 80005878 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001ca0:	00078813          	mv	a6,a5
    80001ca4:	0940006f          	j	80001d38 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001ca8:	00004717          	auipc	a4,0x4
    80001cac:	b5873703          	ld	a4,-1192(a4) # 80005800 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001cb0:	00073703          	ld	a4,0(a4)
    80001cb4:	00004697          	auipc	a3,0x4
    80001cb8:	bce6b223          	sd	a4,-1084(a3) # 80005878 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001cbc:	00078813          	mv	a6,a5
    80001cc0:	0780006f          	j	80001d38 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001cc4:	00004797          	auipc	a5,0x4
    80001cc8:	bae7ba23          	sd	a4,-1100(a5) # 80005878 <_ZN15MemoryAllocator4headE>
    80001ccc:	06c0006f          	j	80001d38 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001cd0:	00078813          	mv	a6,a5
    80001cd4:	0640006f          	j	80001d38 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001cd8:	00050613          	mv	a2,a0
        curr = curr->next;
    80001cdc:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001ce0:	06050063          	beqz	a0,80001d40 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80001ce4:	00853783          	ld	a5,8(a0)
    80001ce8:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80001cec:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001cf0:	fee7e4e3          	bltu	a5,a4,80001cd8 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001cf4:	ff06e2e3          	bltu	a3,a6,80001cd8 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001cf8:	f7068ee3          	beq	a3,a6,80001c74 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001cfc:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001d00:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80001d04:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001d08:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001d0c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001d10:	01053783          	ld	a5,16(a0)
    80001d14:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001d18:	fa0606e3          	beqz	a2,80001cc4 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001d1c:	01063783          	ld	a5,16(a2)
    80001d20:	00078663          	beqz	a5,80001d2c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80001d24:	0107b783          	ld	a5,16(a5)
    80001d28:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80001d2c:	01063783          	ld	a5,16(a2)
    80001d30:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001d34:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001d38:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001d3c:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001d40:	00813403          	ld	s0,8(sp)
    80001d44:	01010113          	addi	sp,sp,16
    80001d48:	00008067          	ret
        return nullptr;
    80001d4c:	00000513          	li	a0,0
    80001d50:	ff1ff06f          	j	80001d40 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080001d54 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001d54:	ff010113          	addi	sp,sp,-16
    80001d58:	00813423          	sd	s0,8(sp)
    80001d5c:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001d60:	16050063          	beqz	a0,80001ec0 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001d64:	ff850713          	addi	a4,a0,-8
    80001d68:	00004797          	auipc	a5,0x4
    80001d6c:	a787b783          	ld	a5,-1416(a5) # 800057e0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001d70:	0007b783          	ld	a5,0(a5)
    80001d74:	14f76a63          	bltu	a4,a5,80001ec8 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001d78:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001d7c:	fff58693          	addi	a3,a1,-1
    80001d80:	00d706b3          	add	a3,a4,a3
    80001d84:	00004617          	auipc	a2,0x4
    80001d88:	a7c63603          	ld	a2,-1412(a2) # 80005800 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001d8c:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001d90:	14c6f063          	bgeu	a3,a2,80001ed0 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001d94:	14070263          	beqz	a4,80001ed8 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001d98:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001d9c:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001da0:	14079063          	bnez	a5,80001ee0 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001da4:	03f00793          	li	a5,63
    80001da8:	14b7f063          	bgeu	a5,a1,80001ee8 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001dac:	00004797          	auipc	a5,0x4
    80001db0:	acc7b783          	ld	a5,-1332(a5) # 80005878 <_ZN15MemoryAllocator4headE>
    80001db4:	02f60063          	beq	a2,a5,80001dd4 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001db8:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001dbc:	02078a63          	beqz	a5,80001df0 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001dc0:	0007b683          	ld	a3,0(a5)
    80001dc4:	02e6f663          	bgeu	a3,a4,80001df0 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001dc8:	00078613          	mv	a2,a5
        curr = curr->next;
    80001dcc:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001dd0:	fedff06f          	j	80001dbc <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001dd4:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001dd8:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001ddc:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80001de0:	00004797          	auipc	a5,0x4
    80001de4:	a8e7bc23          	sd	a4,-1384(a5) # 80005878 <_ZN15MemoryAllocator4headE>
        return 0;
    80001de8:	00000513          	li	a0,0
    80001dec:	0480006f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001df0:	04060863          	beqz	a2,80001e40 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001df4:	00063683          	ld	a3,0(a2)
    80001df8:	00863803          	ld	a6,8(a2)
    80001dfc:	010686b3          	add	a3,a3,a6
    80001e00:	08e68a63          	beq	a3,a4,80001e94 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80001e04:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001e08:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001e0c:	01063683          	ld	a3,16(a2)
    80001e10:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80001e14:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001e18:	0e078063          	beqz	a5,80001ef8 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001e1c:	0007b583          	ld	a1,0(a5)
    80001e20:	00073683          	ld	a3,0(a4)
    80001e24:	00873603          	ld	a2,8(a4)
    80001e28:	00c686b3          	add	a3,a3,a2
    80001e2c:	06d58c63          	beq	a1,a3,80001ea4 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80001e30:	00000513          	li	a0,0
}
    80001e34:	00813403          	ld	s0,8(sp)
    80001e38:	01010113          	addi	sp,sp,16
    80001e3c:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80001e40:	0a078863          	beqz	a5,80001ef0 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80001e44:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001e48:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001e4c:	00004797          	auipc	a5,0x4
    80001e50:	a2c7b783          	ld	a5,-1492(a5) # 80005878 <_ZN15MemoryAllocator4headE>
    80001e54:	0007b603          	ld	a2,0(a5)
    80001e58:	00b706b3          	add	a3,a4,a1
    80001e5c:	00d60c63          	beq	a2,a3,80001e74 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80001e60:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001e64:	00004797          	auipc	a5,0x4
    80001e68:	a0e7ba23          	sd	a4,-1516(a5) # 80005878 <_ZN15MemoryAllocator4headE>
            return 0;
    80001e6c:	00000513          	li	a0,0
    80001e70:	fc5ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001e74:	0087b783          	ld	a5,8(a5)
    80001e78:	00b785b3          	add	a1,a5,a1
    80001e7c:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80001e80:	00004797          	auipc	a5,0x4
    80001e84:	9f87b783          	ld	a5,-1544(a5) # 80005878 <_ZN15MemoryAllocator4headE>
    80001e88:	0107b783          	ld	a5,16(a5)
    80001e8c:	00f53423          	sd	a5,8(a0)
    80001e90:	fd5ff06f          	j	80001e64 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001e94:	00b805b3          	add	a1,a6,a1
    80001e98:	00b63423          	sd	a1,8(a2)
    80001e9c:	00060713          	mv	a4,a2
    80001ea0:	f79ff06f          	j	80001e18 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001ea4:	0087b683          	ld	a3,8(a5)
    80001ea8:	00d60633          	add	a2,a2,a3
    80001eac:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001eb0:	0107b783          	ld	a5,16(a5)
    80001eb4:	00f73823          	sd	a5,16(a4)
    return 0;
    80001eb8:	00000513          	li	a0,0
    80001ebc:	f79ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001ec0:	fff00513          	li	a0,-1
    80001ec4:	f71ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001ec8:	fff00513          	li	a0,-1
    80001ecc:	f69ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001ed0:	fff00513          	li	a0,-1
    80001ed4:	f61ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001ed8:	fff00513          	li	a0,-1
    80001edc:	f59ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001ee0:	fff00513          	li	a0,-1
    80001ee4:	f51ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001ee8:	fff00513          	li	a0,-1
    80001eec:	f49ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001ef0:	fff00513          	li	a0,-1
    80001ef4:	f41ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001ef8:	00000513          	li	a0,0
    80001efc:	f39ff06f          	j	80001e34 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001f00 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    80001f00:	fe010113          	addi	sp,sp,-32
    80001f04:	00113c23          	sd	ra,24(sp)
    80001f08:	00813823          	sd	s0,16(sp)
    80001f0c:	00913423          	sd	s1,8(sp)
    80001f10:	02010413          	addi	s0,sp,32
    80001f14:	00050493          	mv	s1,a0
    while (*string != '\0')
    80001f18:	0004c503          	lbu	a0,0(s1)
    80001f1c:	00050a63          	beqz	a0,80001f30 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    80001f20:	00002097          	auipc	ra,0x2
    80001f24:	1fc080e7          	jalr	508(ra) # 8000411c <__putc>
        string++;
    80001f28:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001f2c:	fedff06f          	j	80001f18 <_Z11printStringPKc+0x18>
    }
}
    80001f30:	01813083          	ld	ra,24(sp)
    80001f34:	01013403          	ld	s0,16(sp)
    80001f38:	00813483          	ld	s1,8(sp)
    80001f3c:	02010113          	addi	sp,sp,32
    80001f40:	00008067          	ret

0000000080001f44 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    80001f44:	fd010113          	addi	sp,sp,-48
    80001f48:	02113423          	sd	ra,40(sp)
    80001f4c:	02813023          	sd	s0,32(sp)
    80001f50:	00913c23          	sd	s1,24(sp)
    80001f54:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80001f58:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001f5c:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001f60:	00a00613          	li	a2,10
    80001f64:	02c5773b          	remuw	a4,a0,a2
    80001f68:	02071693          	slli	a3,a4,0x20
    80001f6c:	0206d693          	srli	a3,a3,0x20
    80001f70:	00003717          	auipc	a4,0x3
    80001f74:	12070713          	addi	a4,a4,288 # 80005090 <_ZZ12printIntegermE6digits>
    80001f78:	00d70733          	add	a4,a4,a3
    80001f7c:	00074703          	lbu	a4,0(a4)
    80001f80:	fe040693          	addi	a3,s0,-32
    80001f84:	009687b3          	add	a5,a3,s1
    80001f88:	0014849b          	addiw	s1,s1,1
    80001f8c:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001f90:	0005071b          	sext.w	a4,a0
    80001f94:	02c5553b          	divuw	a0,a0,a2
    80001f98:	00900793          	li	a5,9
    80001f9c:	fce7e2e3          	bltu	a5,a4,80001f60 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    80001fa0:	fff4849b          	addiw	s1,s1,-1
    80001fa4:	0004ce63          	bltz	s1,80001fc0 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    80001fa8:	fe040793          	addi	a5,s0,-32
    80001fac:	009787b3          	add	a5,a5,s1
    80001fb0:	ff07c503          	lbu	a0,-16(a5)
    80001fb4:	00002097          	auipc	ra,0x2
    80001fb8:	168080e7          	jalr	360(ra) # 8000411c <__putc>
    80001fbc:	fe5ff06f          	j	80001fa0 <_Z12printIntegerm+0x5c>
}
    80001fc0:	02813083          	ld	ra,40(sp)
    80001fc4:	02013403          	ld	s0,32(sp)
    80001fc8:	01813483          	ld	s1,24(sp)
    80001fcc:	03010113          	addi	sp,sp,48
    80001fd0:	00008067          	ret

0000000080001fd4 <_Z10printErrorv>:

void printError() {
    80001fd4:	fd010113          	addi	sp,sp,-48
    80001fd8:	02113423          	sd	ra,40(sp)
    80001fdc:	02813023          	sd	s0,32(sp)
    80001fe0:	03010413          	addi	s0,sp,48
    printString("scause: ");
    80001fe4:	00003517          	auipc	a0,0x3
    80001fe8:	08450513          	addi	a0,a0,132 # 80005068 <CONSOLE_STATUS+0x58>
    80001fec:	00000097          	auipc	ra,0x0
    80001ff0:	f14080e7          	jalr	-236(ra) # 80001f00 <_Z11printStringPKc>
    enum sysCallCodes {
    80001ff4:	142027f3          	csrr	a5,scause
    80001ff8:	fef43423          	sd	a5,-24(s0)
        mem_alloc = 0x01,
    80001ffc:	fe843503          	ld	a0,-24(s0)
    printInteger(Kernel::r_scause());
    80002000:	00000097          	auipc	ra,0x0
    80002004:	f44080e7          	jalr	-188(ra) # 80001f44 <_Z12printIntegerm>
    printString("\nsepc: ");
    80002008:	00003517          	auipc	a0,0x3
    8000200c:	07050513          	addi	a0,a0,112 # 80005078 <CONSOLE_STATUS+0x68>
    80002010:	00000097          	auipc	ra,0x0
    80002014:	ef0080e7          	jalr	-272(ra) # 80001f00 <_Z11printStringPKc>
        putc = 0x42
    80002018:	141027f3          	csrr	a5,sepc
    8000201c:	fef43023          	sd	a5,-32(s0)
    };
    80002020:	fe043503          	ld	a0,-32(s0)
    printInteger(Kernel::r_sepc());
    80002024:	00000097          	auipc	ra,0x0
    80002028:	f20080e7          	jalr	-224(ra) # 80001f44 <_Z12printIntegerm>
    printString("\nstval: ");
    8000202c:	00003517          	auipc	a0,0x3
    80002030:	05450513          	addi	a0,a0,84 # 80005080 <CONSOLE_STATUS+0x70>
    80002034:	00000097          	auipc	ra,0x0
    80002038:	ecc080e7          	jalr	-308(ra) # 80001f00 <_Z11printStringPKc>

    8000203c:	143027f3          	csrr	a5,stval
    80002040:	fcf43c23          	sd	a5,-40(s0)
    // upisuje u registar sepc
    80002044:	fd843503          	ld	a0,-40(s0)
    printInteger(Kernel::r_stval());
    80002048:	00000097          	auipc	ra,0x0
    8000204c:	efc080e7          	jalr	-260(ra) # 80001f44 <_Z12printIntegerm>
    80002050:	02813083          	ld	ra,40(sp)
    80002054:	02013403          	ld	s0,32(sp)
    80002058:	03010113          	addi	sp,sp,48
    8000205c:	00008067          	ret

0000000080002060 <start>:
    80002060:	ff010113          	addi	sp,sp,-16
    80002064:	00813423          	sd	s0,8(sp)
    80002068:	01010413          	addi	s0,sp,16
    8000206c:	300027f3          	csrr	a5,mstatus
    80002070:	ffffe737          	lui	a4,0xffffe
    80002074:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7d1f>
    80002078:	00e7f7b3          	and	a5,a5,a4
    8000207c:	00001737          	lui	a4,0x1
    80002080:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002084:	00e7e7b3          	or	a5,a5,a4
    80002088:	30079073          	csrw	mstatus,a5
    8000208c:	00000797          	auipc	a5,0x0
    80002090:	16078793          	addi	a5,a5,352 # 800021ec <system_main>
    80002094:	34179073          	csrw	mepc,a5
    80002098:	00000793          	li	a5,0
    8000209c:	18079073          	csrw	satp,a5
    800020a0:	000107b7          	lui	a5,0x10
    800020a4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800020a8:	30279073          	csrw	medeleg,a5
    800020ac:	30379073          	csrw	mideleg,a5
    800020b0:	104027f3          	csrr	a5,sie
    800020b4:	2227e793          	ori	a5,a5,546
    800020b8:	10479073          	csrw	sie,a5
    800020bc:	fff00793          	li	a5,-1
    800020c0:	00a7d793          	srli	a5,a5,0xa
    800020c4:	3b079073          	csrw	pmpaddr0,a5
    800020c8:	00f00793          	li	a5,15
    800020cc:	3a079073          	csrw	pmpcfg0,a5
    800020d0:	f14027f3          	csrr	a5,mhartid
    800020d4:	0200c737          	lui	a4,0x200c
    800020d8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800020dc:	0007869b          	sext.w	a3,a5
    800020e0:	00269713          	slli	a4,a3,0x2
    800020e4:	000f4637          	lui	a2,0xf4
    800020e8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800020ec:	00d70733          	add	a4,a4,a3
    800020f0:	0037979b          	slliw	a5,a5,0x3
    800020f4:	020046b7          	lui	a3,0x2004
    800020f8:	00d787b3          	add	a5,a5,a3
    800020fc:	00c585b3          	add	a1,a1,a2
    80002100:	00371693          	slli	a3,a4,0x3
    80002104:	00003717          	auipc	a4,0x3
    80002108:	77c70713          	addi	a4,a4,1916 # 80005880 <timer_scratch>
    8000210c:	00b7b023          	sd	a1,0(a5)
    80002110:	00d70733          	add	a4,a4,a3
    80002114:	00f73c23          	sd	a5,24(a4)
    80002118:	02c73023          	sd	a2,32(a4)
    8000211c:	34071073          	csrw	mscratch,a4
    80002120:	00000797          	auipc	a5,0x0
    80002124:	6e078793          	addi	a5,a5,1760 # 80002800 <timervec>
    80002128:	30579073          	csrw	mtvec,a5
    8000212c:	300027f3          	csrr	a5,mstatus
    80002130:	0087e793          	ori	a5,a5,8
    80002134:	30079073          	csrw	mstatus,a5
    80002138:	304027f3          	csrr	a5,mie
    8000213c:	0807e793          	ori	a5,a5,128
    80002140:	30479073          	csrw	mie,a5
    80002144:	f14027f3          	csrr	a5,mhartid
    80002148:	0007879b          	sext.w	a5,a5
    8000214c:	00078213          	mv	tp,a5
    80002150:	30200073          	mret
    80002154:	00813403          	ld	s0,8(sp)
    80002158:	01010113          	addi	sp,sp,16
    8000215c:	00008067          	ret

0000000080002160 <timerinit>:
    80002160:	ff010113          	addi	sp,sp,-16
    80002164:	00813423          	sd	s0,8(sp)
    80002168:	01010413          	addi	s0,sp,16
    8000216c:	f14027f3          	csrr	a5,mhartid
    80002170:	0200c737          	lui	a4,0x200c
    80002174:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002178:	0007869b          	sext.w	a3,a5
    8000217c:	00269713          	slli	a4,a3,0x2
    80002180:	000f4637          	lui	a2,0xf4
    80002184:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002188:	00d70733          	add	a4,a4,a3
    8000218c:	0037979b          	slliw	a5,a5,0x3
    80002190:	020046b7          	lui	a3,0x2004
    80002194:	00d787b3          	add	a5,a5,a3
    80002198:	00c585b3          	add	a1,a1,a2
    8000219c:	00371693          	slli	a3,a4,0x3
    800021a0:	00003717          	auipc	a4,0x3
    800021a4:	6e070713          	addi	a4,a4,1760 # 80005880 <timer_scratch>
    800021a8:	00b7b023          	sd	a1,0(a5)
    800021ac:	00d70733          	add	a4,a4,a3
    800021b0:	00f73c23          	sd	a5,24(a4)
    800021b4:	02c73023          	sd	a2,32(a4)
    800021b8:	34071073          	csrw	mscratch,a4
    800021bc:	00000797          	auipc	a5,0x0
    800021c0:	64478793          	addi	a5,a5,1604 # 80002800 <timervec>
    800021c4:	30579073          	csrw	mtvec,a5
    800021c8:	300027f3          	csrr	a5,mstatus
    800021cc:	0087e793          	ori	a5,a5,8
    800021d0:	30079073          	csrw	mstatus,a5
    800021d4:	304027f3          	csrr	a5,mie
    800021d8:	0807e793          	ori	a5,a5,128
    800021dc:	30479073          	csrw	mie,a5
    800021e0:	00813403          	ld	s0,8(sp)
    800021e4:	01010113          	addi	sp,sp,16
    800021e8:	00008067          	ret

00000000800021ec <system_main>:
    800021ec:	fe010113          	addi	sp,sp,-32
    800021f0:	00813823          	sd	s0,16(sp)
    800021f4:	00913423          	sd	s1,8(sp)
    800021f8:	00113c23          	sd	ra,24(sp)
    800021fc:	02010413          	addi	s0,sp,32
    80002200:	00000097          	auipc	ra,0x0
    80002204:	0c4080e7          	jalr	196(ra) # 800022c4 <cpuid>
    80002208:	00003497          	auipc	s1,0x3
    8000220c:	61848493          	addi	s1,s1,1560 # 80005820 <started>
    80002210:	02050263          	beqz	a0,80002234 <system_main+0x48>
    80002214:	0004a783          	lw	a5,0(s1)
    80002218:	0007879b          	sext.w	a5,a5
    8000221c:	fe078ce3          	beqz	a5,80002214 <system_main+0x28>
    80002220:	0ff0000f          	fence
    80002224:	00003517          	auipc	a0,0x3
    80002228:	eac50513          	addi	a0,a0,-340 # 800050d0 <_ZZ12printIntegermE6digits+0x40>
    8000222c:	00001097          	auipc	ra,0x1
    80002230:	a70080e7          	jalr	-1424(ra) # 80002c9c <panic>
    80002234:	00001097          	auipc	ra,0x1
    80002238:	9c4080e7          	jalr	-1596(ra) # 80002bf8 <consoleinit>
    8000223c:	00001097          	auipc	ra,0x1
    80002240:	150080e7          	jalr	336(ra) # 8000338c <printfinit>
    80002244:	00003517          	auipc	a0,0x3
    80002248:	dec50513          	addi	a0,a0,-532 # 80005030 <CONSOLE_STATUS+0x20>
    8000224c:	00001097          	auipc	ra,0x1
    80002250:	aac080e7          	jalr	-1364(ra) # 80002cf8 <__printf>
    80002254:	00003517          	auipc	a0,0x3
    80002258:	e4c50513          	addi	a0,a0,-436 # 800050a0 <_ZZ12printIntegermE6digits+0x10>
    8000225c:	00001097          	auipc	ra,0x1
    80002260:	a9c080e7          	jalr	-1380(ra) # 80002cf8 <__printf>
    80002264:	00003517          	auipc	a0,0x3
    80002268:	dcc50513          	addi	a0,a0,-564 # 80005030 <CONSOLE_STATUS+0x20>
    8000226c:	00001097          	auipc	ra,0x1
    80002270:	a8c080e7          	jalr	-1396(ra) # 80002cf8 <__printf>
    80002274:	00001097          	auipc	ra,0x1
    80002278:	4a4080e7          	jalr	1188(ra) # 80003718 <kinit>
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	148080e7          	jalr	328(ra) # 800023c4 <trapinit>
    80002284:	00000097          	auipc	ra,0x0
    80002288:	16c080e7          	jalr	364(ra) # 800023f0 <trapinithart>
    8000228c:	00000097          	auipc	ra,0x0
    80002290:	5b4080e7          	jalr	1460(ra) # 80002840 <plicinit>
    80002294:	00000097          	auipc	ra,0x0
    80002298:	5d4080e7          	jalr	1492(ra) # 80002868 <plicinithart>
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	078080e7          	jalr	120(ra) # 80002314 <userinit>
    800022a4:	0ff0000f          	fence
    800022a8:	00100793          	li	a5,1
    800022ac:	00003517          	auipc	a0,0x3
    800022b0:	e0c50513          	addi	a0,a0,-500 # 800050b8 <_ZZ12printIntegermE6digits+0x28>
    800022b4:	00f4a023          	sw	a5,0(s1)
    800022b8:	00001097          	auipc	ra,0x1
    800022bc:	a40080e7          	jalr	-1472(ra) # 80002cf8 <__printf>
    800022c0:	0000006f          	j	800022c0 <system_main+0xd4>

00000000800022c4 <cpuid>:
    800022c4:	ff010113          	addi	sp,sp,-16
    800022c8:	00813423          	sd	s0,8(sp)
    800022cc:	01010413          	addi	s0,sp,16
    800022d0:	00020513          	mv	a0,tp
    800022d4:	00813403          	ld	s0,8(sp)
    800022d8:	0005051b          	sext.w	a0,a0
    800022dc:	01010113          	addi	sp,sp,16
    800022e0:	00008067          	ret

00000000800022e4 <mycpu>:
    800022e4:	ff010113          	addi	sp,sp,-16
    800022e8:	00813423          	sd	s0,8(sp)
    800022ec:	01010413          	addi	s0,sp,16
    800022f0:	00020793          	mv	a5,tp
    800022f4:	00813403          	ld	s0,8(sp)
    800022f8:	0007879b          	sext.w	a5,a5
    800022fc:	00779793          	slli	a5,a5,0x7
    80002300:	00004517          	auipc	a0,0x4
    80002304:	5b050513          	addi	a0,a0,1456 # 800068b0 <cpus>
    80002308:	00f50533          	add	a0,a0,a5
    8000230c:	01010113          	addi	sp,sp,16
    80002310:	00008067          	ret

0000000080002314 <userinit>:
    80002314:	ff010113          	addi	sp,sp,-16
    80002318:	00813423          	sd	s0,8(sp)
    8000231c:	01010413          	addi	s0,sp,16
    80002320:	00813403          	ld	s0,8(sp)
    80002324:	01010113          	addi	sp,sp,16
    80002328:	fffff317          	auipc	t1,0xfffff
    8000232c:	73030067          	jr	1840(t1) # 80001a58 <main>

0000000080002330 <either_copyout>:
    80002330:	ff010113          	addi	sp,sp,-16
    80002334:	00813023          	sd	s0,0(sp)
    80002338:	00113423          	sd	ra,8(sp)
    8000233c:	01010413          	addi	s0,sp,16
    80002340:	02051663          	bnez	a0,8000236c <either_copyout+0x3c>
    80002344:	00058513          	mv	a0,a1
    80002348:	00060593          	mv	a1,a2
    8000234c:	0006861b          	sext.w	a2,a3
    80002350:	00002097          	auipc	ra,0x2
    80002354:	c54080e7          	jalr	-940(ra) # 80003fa4 <__memmove>
    80002358:	00813083          	ld	ra,8(sp)
    8000235c:	00013403          	ld	s0,0(sp)
    80002360:	00000513          	li	a0,0
    80002364:	01010113          	addi	sp,sp,16
    80002368:	00008067          	ret
    8000236c:	00003517          	auipc	a0,0x3
    80002370:	d8c50513          	addi	a0,a0,-628 # 800050f8 <_ZZ12printIntegermE6digits+0x68>
    80002374:	00001097          	auipc	ra,0x1
    80002378:	928080e7          	jalr	-1752(ra) # 80002c9c <panic>

000000008000237c <either_copyin>:
    8000237c:	ff010113          	addi	sp,sp,-16
    80002380:	00813023          	sd	s0,0(sp)
    80002384:	00113423          	sd	ra,8(sp)
    80002388:	01010413          	addi	s0,sp,16
    8000238c:	02059463          	bnez	a1,800023b4 <either_copyin+0x38>
    80002390:	00060593          	mv	a1,a2
    80002394:	0006861b          	sext.w	a2,a3
    80002398:	00002097          	auipc	ra,0x2
    8000239c:	c0c080e7          	jalr	-1012(ra) # 80003fa4 <__memmove>
    800023a0:	00813083          	ld	ra,8(sp)
    800023a4:	00013403          	ld	s0,0(sp)
    800023a8:	00000513          	li	a0,0
    800023ac:	01010113          	addi	sp,sp,16
    800023b0:	00008067          	ret
    800023b4:	00003517          	auipc	a0,0x3
    800023b8:	d6c50513          	addi	a0,a0,-660 # 80005120 <_ZZ12printIntegermE6digits+0x90>
    800023bc:	00001097          	auipc	ra,0x1
    800023c0:	8e0080e7          	jalr	-1824(ra) # 80002c9c <panic>

00000000800023c4 <trapinit>:
    800023c4:	ff010113          	addi	sp,sp,-16
    800023c8:	00813423          	sd	s0,8(sp)
    800023cc:	01010413          	addi	s0,sp,16
    800023d0:	00813403          	ld	s0,8(sp)
    800023d4:	00003597          	auipc	a1,0x3
    800023d8:	d7458593          	addi	a1,a1,-652 # 80005148 <_ZZ12printIntegermE6digits+0xb8>
    800023dc:	00004517          	auipc	a0,0x4
    800023e0:	55450513          	addi	a0,a0,1364 # 80006930 <tickslock>
    800023e4:	01010113          	addi	sp,sp,16
    800023e8:	00001317          	auipc	t1,0x1
    800023ec:	5c030067          	jr	1472(t1) # 800039a8 <initlock>

00000000800023f0 <trapinithart>:
    800023f0:	ff010113          	addi	sp,sp,-16
    800023f4:	00813423          	sd	s0,8(sp)
    800023f8:	01010413          	addi	s0,sp,16
    800023fc:	00000797          	auipc	a5,0x0
    80002400:	2f478793          	addi	a5,a5,756 # 800026f0 <kernelvec>
    80002404:	10579073          	csrw	stvec,a5
    80002408:	00813403          	ld	s0,8(sp)
    8000240c:	01010113          	addi	sp,sp,16
    80002410:	00008067          	ret

0000000080002414 <usertrap>:
    80002414:	ff010113          	addi	sp,sp,-16
    80002418:	00813423          	sd	s0,8(sp)
    8000241c:	01010413          	addi	s0,sp,16
    80002420:	00813403          	ld	s0,8(sp)
    80002424:	01010113          	addi	sp,sp,16
    80002428:	00008067          	ret

000000008000242c <usertrapret>:
    8000242c:	ff010113          	addi	sp,sp,-16
    80002430:	00813423          	sd	s0,8(sp)
    80002434:	01010413          	addi	s0,sp,16
    80002438:	00813403          	ld	s0,8(sp)
    8000243c:	01010113          	addi	sp,sp,16
    80002440:	00008067          	ret

0000000080002444 <kerneltrap>:
    80002444:	fe010113          	addi	sp,sp,-32
    80002448:	00813823          	sd	s0,16(sp)
    8000244c:	00113c23          	sd	ra,24(sp)
    80002450:	00913423          	sd	s1,8(sp)
    80002454:	02010413          	addi	s0,sp,32
    80002458:	142025f3          	csrr	a1,scause
    8000245c:	100027f3          	csrr	a5,sstatus
    80002460:	0027f793          	andi	a5,a5,2
    80002464:	10079c63          	bnez	a5,8000257c <kerneltrap+0x138>
    80002468:	142027f3          	csrr	a5,scause
    8000246c:	0207ce63          	bltz	a5,800024a8 <kerneltrap+0x64>
    80002470:	00003517          	auipc	a0,0x3
    80002474:	d2050513          	addi	a0,a0,-736 # 80005190 <_ZZ12printIntegermE6digits+0x100>
    80002478:	00001097          	auipc	ra,0x1
    8000247c:	880080e7          	jalr	-1920(ra) # 80002cf8 <__printf>
    80002480:	141025f3          	csrr	a1,sepc
    80002484:	14302673          	csrr	a2,stval
    80002488:	00003517          	auipc	a0,0x3
    8000248c:	d1850513          	addi	a0,a0,-744 # 800051a0 <_ZZ12printIntegermE6digits+0x110>
    80002490:	00001097          	auipc	ra,0x1
    80002494:	868080e7          	jalr	-1944(ra) # 80002cf8 <__printf>
    80002498:	00003517          	auipc	a0,0x3
    8000249c:	d2050513          	addi	a0,a0,-736 # 800051b8 <_ZZ12printIntegermE6digits+0x128>
    800024a0:	00000097          	auipc	ra,0x0
    800024a4:	7fc080e7          	jalr	2044(ra) # 80002c9c <panic>
    800024a8:	0ff7f713          	andi	a4,a5,255
    800024ac:	00900693          	li	a3,9
    800024b0:	04d70063          	beq	a4,a3,800024f0 <kerneltrap+0xac>
    800024b4:	fff00713          	li	a4,-1
    800024b8:	03f71713          	slli	a4,a4,0x3f
    800024bc:	00170713          	addi	a4,a4,1
    800024c0:	fae798e3          	bne	a5,a4,80002470 <kerneltrap+0x2c>
    800024c4:	00000097          	auipc	ra,0x0
    800024c8:	e00080e7          	jalr	-512(ra) # 800022c4 <cpuid>
    800024cc:	06050663          	beqz	a0,80002538 <kerneltrap+0xf4>
    800024d0:	144027f3          	csrr	a5,sip
    800024d4:	ffd7f793          	andi	a5,a5,-3
    800024d8:	14479073          	csrw	sip,a5
    800024dc:	01813083          	ld	ra,24(sp)
    800024e0:	01013403          	ld	s0,16(sp)
    800024e4:	00813483          	ld	s1,8(sp)
    800024e8:	02010113          	addi	sp,sp,32
    800024ec:	00008067          	ret
    800024f0:	00000097          	auipc	ra,0x0
    800024f4:	3c4080e7          	jalr	964(ra) # 800028b4 <plic_claim>
    800024f8:	00a00793          	li	a5,10
    800024fc:	00050493          	mv	s1,a0
    80002500:	06f50863          	beq	a0,a5,80002570 <kerneltrap+0x12c>
    80002504:	fc050ce3          	beqz	a0,800024dc <kerneltrap+0x98>
    80002508:	00050593          	mv	a1,a0
    8000250c:	00003517          	auipc	a0,0x3
    80002510:	c6450513          	addi	a0,a0,-924 # 80005170 <_ZZ12printIntegermE6digits+0xe0>
    80002514:	00000097          	auipc	ra,0x0
    80002518:	7e4080e7          	jalr	2020(ra) # 80002cf8 <__printf>
    8000251c:	01013403          	ld	s0,16(sp)
    80002520:	01813083          	ld	ra,24(sp)
    80002524:	00048513          	mv	a0,s1
    80002528:	00813483          	ld	s1,8(sp)
    8000252c:	02010113          	addi	sp,sp,32
    80002530:	00000317          	auipc	t1,0x0
    80002534:	3bc30067          	jr	956(t1) # 800028ec <plic_complete>
    80002538:	00004517          	auipc	a0,0x4
    8000253c:	3f850513          	addi	a0,a0,1016 # 80006930 <tickslock>
    80002540:	00001097          	auipc	ra,0x1
    80002544:	48c080e7          	jalr	1164(ra) # 800039cc <acquire>
    80002548:	00003717          	auipc	a4,0x3
    8000254c:	2dc70713          	addi	a4,a4,732 # 80005824 <ticks>
    80002550:	00072783          	lw	a5,0(a4)
    80002554:	00004517          	auipc	a0,0x4
    80002558:	3dc50513          	addi	a0,a0,988 # 80006930 <tickslock>
    8000255c:	0017879b          	addiw	a5,a5,1
    80002560:	00f72023          	sw	a5,0(a4)
    80002564:	00001097          	auipc	ra,0x1
    80002568:	534080e7          	jalr	1332(ra) # 80003a98 <release>
    8000256c:	f65ff06f          	j	800024d0 <kerneltrap+0x8c>
    80002570:	00001097          	auipc	ra,0x1
    80002574:	090080e7          	jalr	144(ra) # 80003600 <uartintr>
    80002578:	fa5ff06f          	j	8000251c <kerneltrap+0xd8>
    8000257c:	00003517          	auipc	a0,0x3
    80002580:	bd450513          	addi	a0,a0,-1068 # 80005150 <_ZZ12printIntegermE6digits+0xc0>
    80002584:	00000097          	auipc	ra,0x0
    80002588:	718080e7          	jalr	1816(ra) # 80002c9c <panic>

000000008000258c <clockintr>:
    8000258c:	fe010113          	addi	sp,sp,-32
    80002590:	00813823          	sd	s0,16(sp)
    80002594:	00913423          	sd	s1,8(sp)
    80002598:	00113c23          	sd	ra,24(sp)
    8000259c:	02010413          	addi	s0,sp,32
    800025a0:	00004497          	auipc	s1,0x4
    800025a4:	39048493          	addi	s1,s1,912 # 80006930 <tickslock>
    800025a8:	00048513          	mv	a0,s1
    800025ac:	00001097          	auipc	ra,0x1
    800025b0:	420080e7          	jalr	1056(ra) # 800039cc <acquire>
    800025b4:	00003717          	auipc	a4,0x3
    800025b8:	27070713          	addi	a4,a4,624 # 80005824 <ticks>
    800025bc:	00072783          	lw	a5,0(a4)
    800025c0:	01013403          	ld	s0,16(sp)
    800025c4:	01813083          	ld	ra,24(sp)
    800025c8:	00048513          	mv	a0,s1
    800025cc:	0017879b          	addiw	a5,a5,1
    800025d0:	00813483          	ld	s1,8(sp)
    800025d4:	00f72023          	sw	a5,0(a4)
    800025d8:	02010113          	addi	sp,sp,32
    800025dc:	00001317          	auipc	t1,0x1
    800025e0:	4bc30067          	jr	1212(t1) # 80003a98 <release>

00000000800025e4 <devintr>:
    800025e4:	142027f3          	csrr	a5,scause
    800025e8:	00000513          	li	a0,0
    800025ec:	0007c463          	bltz	a5,800025f4 <devintr+0x10>
    800025f0:	00008067          	ret
    800025f4:	fe010113          	addi	sp,sp,-32
    800025f8:	00813823          	sd	s0,16(sp)
    800025fc:	00113c23          	sd	ra,24(sp)
    80002600:	00913423          	sd	s1,8(sp)
    80002604:	02010413          	addi	s0,sp,32
    80002608:	0ff7f713          	andi	a4,a5,255
    8000260c:	00900693          	li	a3,9
    80002610:	04d70c63          	beq	a4,a3,80002668 <devintr+0x84>
    80002614:	fff00713          	li	a4,-1
    80002618:	03f71713          	slli	a4,a4,0x3f
    8000261c:	00170713          	addi	a4,a4,1
    80002620:	00e78c63          	beq	a5,a4,80002638 <devintr+0x54>
    80002624:	01813083          	ld	ra,24(sp)
    80002628:	01013403          	ld	s0,16(sp)
    8000262c:	00813483          	ld	s1,8(sp)
    80002630:	02010113          	addi	sp,sp,32
    80002634:	00008067          	ret
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	c8c080e7          	jalr	-884(ra) # 800022c4 <cpuid>
    80002640:	06050663          	beqz	a0,800026ac <devintr+0xc8>
    80002644:	144027f3          	csrr	a5,sip
    80002648:	ffd7f793          	andi	a5,a5,-3
    8000264c:	14479073          	csrw	sip,a5
    80002650:	01813083          	ld	ra,24(sp)
    80002654:	01013403          	ld	s0,16(sp)
    80002658:	00813483          	ld	s1,8(sp)
    8000265c:	00200513          	li	a0,2
    80002660:	02010113          	addi	sp,sp,32
    80002664:	00008067          	ret
    80002668:	00000097          	auipc	ra,0x0
    8000266c:	24c080e7          	jalr	588(ra) # 800028b4 <plic_claim>
    80002670:	00a00793          	li	a5,10
    80002674:	00050493          	mv	s1,a0
    80002678:	06f50663          	beq	a0,a5,800026e4 <devintr+0x100>
    8000267c:	00100513          	li	a0,1
    80002680:	fa0482e3          	beqz	s1,80002624 <devintr+0x40>
    80002684:	00048593          	mv	a1,s1
    80002688:	00003517          	auipc	a0,0x3
    8000268c:	ae850513          	addi	a0,a0,-1304 # 80005170 <_ZZ12printIntegermE6digits+0xe0>
    80002690:	00000097          	auipc	ra,0x0
    80002694:	668080e7          	jalr	1640(ra) # 80002cf8 <__printf>
    80002698:	00048513          	mv	a0,s1
    8000269c:	00000097          	auipc	ra,0x0
    800026a0:	250080e7          	jalr	592(ra) # 800028ec <plic_complete>
    800026a4:	00100513          	li	a0,1
    800026a8:	f7dff06f          	j	80002624 <devintr+0x40>
    800026ac:	00004517          	auipc	a0,0x4
    800026b0:	28450513          	addi	a0,a0,644 # 80006930 <tickslock>
    800026b4:	00001097          	auipc	ra,0x1
    800026b8:	318080e7          	jalr	792(ra) # 800039cc <acquire>
    800026bc:	00003717          	auipc	a4,0x3
    800026c0:	16870713          	addi	a4,a4,360 # 80005824 <ticks>
    800026c4:	00072783          	lw	a5,0(a4)
    800026c8:	00004517          	auipc	a0,0x4
    800026cc:	26850513          	addi	a0,a0,616 # 80006930 <tickslock>
    800026d0:	0017879b          	addiw	a5,a5,1
    800026d4:	00f72023          	sw	a5,0(a4)
    800026d8:	00001097          	auipc	ra,0x1
    800026dc:	3c0080e7          	jalr	960(ra) # 80003a98 <release>
    800026e0:	f65ff06f          	j	80002644 <devintr+0x60>
    800026e4:	00001097          	auipc	ra,0x1
    800026e8:	f1c080e7          	jalr	-228(ra) # 80003600 <uartintr>
    800026ec:	fadff06f          	j	80002698 <devintr+0xb4>

00000000800026f0 <kernelvec>:
    800026f0:	f0010113          	addi	sp,sp,-256
    800026f4:	00113023          	sd	ra,0(sp)
    800026f8:	00213423          	sd	sp,8(sp)
    800026fc:	00313823          	sd	gp,16(sp)
    80002700:	00413c23          	sd	tp,24(sp)
    80002704:	02513023          	sd	t0,32(sp)
    80002708:	02613423          	sd	t1,40(sp)
    8000270c:	02713823          	sd	t2,48(sp)
    80002710:	02813c23          	sd	s0,56(sp)
    80002714:	04913023          	sd	s1,64(sp)
    80002718:	04a13423          	sd	a0,72(sp)
    8000271c:	04b13823          	sd	a1,80(sp)
    80002720:	04c13c23          	sd	a2,88(sp)
    80002724:	06d13023          	sd	a3,96(sp)
    80002728:	06e13423          	sd	a4,104(sp)
    8000272c:	06f13823          	sd	a5,112(sp)
    80002730:	07013c23          	sd	a6,120(sp)
    80002734:	09113023          	sd	a7,128(sp)
    80002738:	09213423          	sd	s2,136(sp)
    8000273c:	09313823          	sd	s3,144(sp)
    80002740:	09413c23          	sd	s4,152(sp)
    80002744:	0b513023          	sd	s5,160(sp)
    80002748:	0b613423          	sd	s6,168(sp)
    8000274c:	0b713823          	sd	s7,176(sp)
    80002750:	0b813c23          	sd	s8,184(sp)
    80002754:	0d913023          	sd	s9,192(sp)
    80002758:	0da13423          	sd	s10,200(sp)
    8000275c:	0db13823          	sd	s11,208(sp)
    80002760:	0dc13c23          	sd	t3,216(sp)
    80002764:	0fd13023          	sd	t4,224(sp)
    80002768:	0fe13423          	sd	t5,232(sp)
    8000276c:	0ff13823          	sd	t6,240(sp)
    80002770:	cd5ff0ef          	jal	ra,80002444 <kerneltrap>
    80002774:	00013083          	ld	ra,0(sp)
    80002778:	00813103          	ld	sp,8(sp)
    8000277c:	01013183          	ld	gp,16(sp)
    80002780:	02013283          	ld	t0,32(sp)
    80002784:	02813303          	ld	t1,40(sp)
    80002788:	03013383          	ld	t2,48(sp)
    8000278c:	03813403          	ld	s0,56(sp)
    80002790:	04013483          	ld	s1,64(sp)
    80002794:	04813503          	ld	a0,72(sp)
    80002798:	05013583          	ld	a1,80(sp)
    8000279c:	05813603          	ld	a2,88(sp)
    800027a0:	06013683          	ld	a3,96(sp)
    800027a4:	06813703          	ld	a4,104(sp)
    800027a8:	07013783          	ld	a5,112(sp)
    800027ac:	07813803          	ld	a6,120(sp)
    800027b0:	08013883          	ld	a7,128(sp)
    800027b4:	08813903          	ld	s2,136(sp)
    800027b8:	09013983          	ld	s3,144(sp)
    800027bc:	09813a03          	ld	s4,152(sp)
    800027c0:	0a013a83          	ld	s5,160(sp)
    800027c4:	0a813b03          	ld	s6,168(sp)
    800027c8:	0b013b83          	ld	s7,176(sp)
    800027cc:	0b813c03          	ld	s8,184(sp)
    800027d0:	0c013c83          	ld	s9,192(sp)
    800027d4:	0c813d03          	ld	s10,200(sp)
    800027d8:	0d013d83          	ld	s11,208(sp)
    800027dc:	0d813e03          	ld	t3,216(sp)
    800027e0:	0e013e83          	ld	t4,224(sp)
    800027e4:	0e813f03          	ld	t5,232(sp)
    800027e8:	0f013f83          	ld	t6,240(sp)
    800027ec:	10010113          	addi	sp,sp,256
    800027f0:	10200073          	sret
    800027f4:	00000013          	nop
    800027f8:	00000013          	nop
    800027fc:	00000013          	nop

0000000080002800 <timervec>:
    80002800:	34051573          	csrrw	a0,mscratch,a0
    80002804:	00b53023          	sd	a1,0(a0)
    80002808:	00c53423          	sd	a2,8(a0)
    8000280c:	00d53823          	sd	a3,16(a0)
    80002810:	01853583          	ld	a1,24(a0)
    80002814:	02053603          	ld	a2,32(a0)
    80002818:	0005b683          	ld	a3,0(a1)
    8000281c:	00c686b3          	add	a3,a3,a2
    80002820:	00d5b023          	sd	a3,0(a1)
    80002824:	00200593          	li	a1,2
    80002828:	14459073          	csrw	sip,a1
    8000282c:	01053683          	ld	a3,16(a0)
    80002830:	00853603          	ld	a2,8(a0)
    80002834:	00053583          	ld	a1,0(a0)
    80002838:	34051573          	csrrw	a0,mscratch,a0
    8000283c:	30200073          	mret

0000000080002840 <plicinit>:
    80002840:	ff010113          	addi	sp,sp,-16
    80002844:	00813423          	sd	s0,8(sp)
    80002848:	01010413          	addi	s0,sp,16
    8000284c:	00813403          	ld	s0,8(sp)
    80002850:	0c0007b7          	lui	a5,0xc000
    80002854:	00100713          	li	a4,1
    80002858:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000285c:	00e7a223          	sw	a4,4(a5)
    80002860:	01010113          	addi	sp,sp,16
    80002864:	00008067          	ret

0000000080002868 <plicinithart>:
    80002868:	ff010113          	addi	sp,sp,-16
    8000286c:	00813023          	sd	s0,0(sp)
    80002870:	00113423          	sd	ra,8(sp)
    80002874:	01010413          	addi	s0,sp,16
    80002878:	00000097          	auipc	ra,0x0
    8000287c:	a4c080e7          	jalr	-1460(ra) # 800022c4 <cpuid>
    80002880:	0085171b          	slliw	a4,a0,0x8
    80002884:	0c0027b7          	lui	a5,0xc002
    80002888:	00e787b3          	add	a5,a5,a4
    8000288c:	40200713          	li	a4,1026
    80002890:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002894:	00813083          	ld	ra,8(sp)
    80002898:	00013403          	ld	s0,0(sp)
    8000289c:	00d5151b          	slliw	a0,a0,0xd
    800028a0:	0c2017b7          	lui	a5,0xc201
    800028a4:	00a78533          	add	a0,a5,a0
    800028a8:	00052023          	sw	zero,0(a0)
    800028ac:	01010113          	addi	sp,sp,16
    800028b0:	00008067          	ret

00000000800028b4 <plic_claim>:
    800028b4:	ff010113          	addi	sp,sp,-16
    800028b8:	00813023          	sd	s0,0(sp)
    800028bc:	00113423          	sd	ra,8(sp)
    800028c0:	01010413          	addi	s0,sp,16
    800028c4:	00000097          	auipc	ra,0x0
    800028c8:	a00080e7          	jalr	-1536(ra) # 800022c4 <cpuid>
    800028cc:	00813083          	ld	ra,8(sp)
    800028d0:	00013403          	ld	s0,0(sp)
    800028d4:	00d5151b          	slliw	a0,a0,0xd
    800028d8:	0c2017b7          	lui	a5,0xc201
    800028dc:	00a78533          	add	a0,a5,a0
    800028e0:	00452503          	lw	a0,4(a0)
    800028e4:	01010113          	addi	sp,sp,16
    800028e8:	00008067          	ret

00000000800028ec <plic_complete>:
    800028ec:	fe010113          	addi	sp,sp,-32
    800028f0:	00813823          	sd	s0,16(sp)
    800028f4:	00913423          	sd	s1,8(sp)
    800028f8:	00113c23          	sd	ra,24(sp)
    800028fc:	02010413          	addi	s0,sp,32
    80002900:	00050493          	mv	s1,a0
    80002904:	00000097          	auipc	ra,0x0
    80002908:	9c0080e7          	jalr	-1600(ra) # 800022c4 <cpuid>
    8000290c:	01813083          	ld	ra,24(sp)
    80002910:	01013403          	ld	s0,16(sp)
    80002914:	00d5179b          	slliw	a5,a0,0xd
    80002918:	0c201737          	lui	a4,0xc201
    8000291c:	00f707b3          	add	a5,a4,a5
    80002920:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002924:	00813483          	ld	s1,8(sp)
    80002928:	02010113          	addi	sp,sp,32
    8000292c:	00008067          	ret

0000000080002930 <consolewrite>:
    80002930:	fb010113          	addi	sp,sp,-80
    80002934:	04813023          	sd	s0,64(sp)
    80002938:	04113423          	sd	ra,72(sp)
    8000293c:	02913c23          	sd	s1,56(sp)
    80002940:	03213823          	sd	s2,48(sp)
    80002944:	03313423          	sd	s3,40(sp)
    80002948:	03413023          	sd	s4,32(sp)
    8000294c:	01513c23          	sd	s5,24(sp)
    80002950:	05010413          	addi	s0,sp,80
    80002954:	06c05c63          	blez	a2,800029cc <consolewrite+0x9c>
    80002958:	00060993          	mv	s3,a2
    8000295c:	00050a13          	mv	s4,a0
    80002960:	00058493          	mv	s1,a1
    80002964:	00000913          	li	s2,0
    80002968:	fff00a93          	li	s5,-1
    8000296c:	01c0006f          	j	80002988 <consolewrite+0x58>
    80002970:	fbf44503          	lbu	a0,-65(s0)
    80002974:	0019091b          	addiw	s2,s2,1
    80002978:	00148493          	addi	s1,s1,1
    8000297c:	00001097          	auipc	ra,0x1
    80002980:	a9c080e7          	jalr	-1380(ra) # 80003418 <uartputc>
    80002984:	03298063          	beq	s3,s2,800029a4 <consolewrite+0x74>
    80002988:	00048613          	mv	a2,s1
    8000298c:	00100693          	li	a3,1
    80002990:	000a0593          	mv	a1,s4
    80002994:	fbf40513          	addi	a0,s0,-65
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	9e4080e7          	jalr	-1564(ra) # 8000237c <either_copyin>
    800029a0:	fd5518e3          	bne	a0,s5,80002970 <consolewrite+0x40>
    800029a4:	04813083          	ld	ra,72(sp)
    800029a8:	04013403          	ld	s0,64(sp)
    800029ac:	03813483          	ld	s1,56(sp)
    800029b0:	02813983          	ld	s3,40(sp)
    800029b4:	02013a03          	ld	s4,32(sp)
    800029b8:	01813a83          	ld	s5,24(sp)
    800029bc:	00090513          	mv	a0,s2
    800029c0:	03013903          	ld	s2,48(sp)
    800029c4:	05010113          	addi	sp,sp,80
    800029c8:	00008067          	ret
    800029cc:	00000913          	li	s2,0
    800029d0:	fd5ff06f          	j	800029a4 <consolewrite+0x74>

00000000800029d4 <consoleread>:
    800029d4:	f9010113          	addi	sp,sp,-112
    800029d8:	06813023          	sd	s0,96(sp)
    800029dc:	04913c23          	sd	s1,88(sp)
    800029e0:	05213823          	sd	s2,80(sp)
    800029e4:	05313423          	sd	s3,72(sp)
    800029e8:	05413023          	sd	s4,64(sp)
    800029ec:	03513c23          	sd	s5,56(sp)
    800029f0:	03613823          	sd	s6,48(sp)
    800029f4:	03713423          	sd	s7,40(sp)
    800029f8:	03813023          	sd	s8,32(sp)
    800029fc:	06113423          	sd	ra,104(sp)
    80002a00:	01913c23          	sd	s9,24(sp)
    80002a04:	07010413          	addi	s0,sp,112
    80002a08:	00060b93          	mv	s7,a2
    80002a0c:	00050913          	mv	s2,a0
    80002a10:	00058c13          	mv	s8,a1
    80002a14:	00060b1b          	sext.w	s6,a2
    80002a18:	00004497          	auipc	s1,0x4
    80002a1c:	f4048493          	addi	s1,s1,-192 # 80006958 <cons>
    80002a20:	00400993          	li	s3,4
    80002a24:	fff00a13          	li	s4,-1
    80002a28:	00a00a93          	li	s5,10
    80002a2c:	05705e63          	blez	s7,80002a88 <consoleread+0xb4>
    80002a30:	09c4a703          	lw	a4,156(s1)
    80002a34:	0984a783          	lw	a5,152(s1)
    80002a38:	0007071b          	sext.w	a4,a4
    80002a3c:	08e78463          	beq	a5,a4,80002ac4 <consoleread+0xf0>
    80002a40:	07f7f713          	andi	a4,a5,127
    80002a44:	00e48733          	add	a4,s1,a4
    80002a48:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002a4c:	0017869b          	addiw	a3,a5,1
    80002a50:	08d4ac23          	sw	a3,152(s1)
    80002a54:	00070c9b          	sext.w	s9,a4
    80002a58:	0b370663          	beq	a4,s3,80002b04 <consoleread+0x130>
    80002a5c:	00100693          	li	a3,1
    80002a60:	f9f40613          	addi	a2,s0,-97
    80002a64:	000c0593          	mv	a1,s8
    80002a68:	00090513          	mv	a0,s2
    80002a6c:	f8e40fa3          	sb	a4,-97(s0)
    80002a70:	00000097          	auipc	ra,0x0
    80002a74:	8c0080e7          	jalr	-1856(ra) # 80002330 <either_copyout>
    80002a78:	01450863          	beq	a0,s4,80002a88 <consoleread+0xb4>
    80002a7c:	001c0c13          	addi	s8,s8,1
    80002a80:	fffb8b9b          	addiw	s7,s7,-1
    80002a84:	fb5c94e3          	bne	s9,s5,80002a2c <consoleread+0x58>
    80002a88:	000b851b          	sext.w	a0,s7
    80002a8c:	06813083          	ld	ra,104(sp)
    80002a90:	06013403          	ld	s0,96(sp)
    80002a94:	05813483          	ld	s1,88(sp)
    80002a98:	05013903          	ld	s2,80(sp)
    80002a9c:	04813983          	ld	s3,72(sp)
    80002aa0:	04013a03          	ld	s4,64(sp)
    80002aa4:	03813a83          	ld	s5,56(sp)
    80002aa8:	02813b83          	ld	s7,40(sp)
    80002aac:	02013c03          	ld	s8,32(sp)
    80002ab0:	01813c83          	ld	s9,24(sp)
    80002ab4:	40ab053b          	subw	a0,s6,a0
    80002ab8:	03013b03          	ld	s6,48(sp)
    80002abc:	07010113          	addi	sp,sp,112
    80002ac0:	00008067          	ret
    80002ac4:	00001097          	auipc	ra,0x1
    80002ac8:	1d8080e7          	jalr	472(ra) # 80003c9c <push_on>
    80002acc:	0984a703          	lw	a4,152(s1)
    80002ad0:	09c4a783          	lw	a5,156(s1)
    80002ad4:	0007879b          	sext.w	a5,a5
    80002ad8:	fef70ce3          	beq	a4,a5,80002ad0 <consoleread+0xfc>
    80002adc:	00001097          	auipc	ra,0x1
    80002ae0:	234080e7          	jalr	564(ra) # 80003d10 <pop_on>
    80002ae4:	0984a783          	lw	a5,152(s1)
    80002ae8:	07f7f713          	andi	a4,a5,127
    80002aec:	00e48733          	add	a4,s1,a4
    80002af0:	01874703          	lbu	a4,24(a4)
    80002af4:	0017869b          	addiw	a3,a5,1
    80002af8:	08d4ac23          	sw	a3,152(s1)
    80002afc:	00070c9b          	sext.w	s9,a4
    80002b00:	f5371ee3          	bne	a4,s3,80002a5c <consoleread+0x88>
    80002b04:	000b851b          	sext.w	a0,s7
    80002b08:	f96bf2e3          	bgeu	s7,s6,80002a8c <consoleread+0xb8>
    80002b0c:	08f4ac23          	sw	a5,152(s1)
    80002b10:	f7dff06f          	j	80002a8c <consoleread+0xb8>

0000000080002b14 <consputc>:
    80002b14:	10000793          	li	a5,256
    80002b18:	00f50663          	beq	a0,a5,80002b24 <consputc+0x10>
    80002b1c:	00001317          	auipc	t1,0x1
    80002b20:	9f430067          	jr	-1548(t1) # 80003510 <uartputc_sync>
    80002b24:	ff010113          	addi	sp,sp,-16
    80002b28:	00113423          	sd	ra,8(sp)
    80002b2c:	00813023          	sd	s0,0(sp)
    80002b30:	01010413          	addi	s0,sp,16
    80002b34:	00800513          	li	a0,8
    80002b38:	00001097          	auipc	ra,0x1
    80002b3c:	9d8080e7          	jalr	-1576(ra) # 80003510 <uartputc_sync>
    80002b40:	02000513          	li	a0,32
    80002b44:	00001097          	auipc	ra,0x1
    80002b48:	9cc080e7          	jalr	-1588(ra) # 80003510 <uartputc_sync>
    80002b4c:	00013403          	ld	s0,0(sp)
    80002b50:	00813083          	ld	ra,8(sp)
    80002b54:	00800513          	li	a0,8
    80002b58:	01010113          	addi	sp,sp,16
    80002b5c:	00001317          	auipc	t1,0x1
    80002b60:	9b430067          	jr	-1612(t1) # 80003510 <uartputc_sync>

0000000080002b64 <consoleintr>:
    80002b64:	fe010113          	addi	sp,sp,-32
    80002b68:	00813823          	sd	s0,16(sp)
    80002b6c:	00913423          	sd	s1,8(sp)
    80002b70:	01213023          	sd	s2,0(sp)
    80002b74:	00113c23          	sd	ra,24(sp)
    80002b78:	02010413          	addi	s0,sp,32
    80002b7c:	00004917          	auipc	s2,0x4
    80002b80:	ddc90913          	addi	s2,s2,-548 # 80006958 <cons>
    80002b84:	00050493          	mv	s1,a0
    80002b88:	00090513          	mv	a0,s2
    80002b8c:	00001097          	auipc	ra,0x1
    80002b90:	e40080e7          	jalr	-448(ra) # 800039cc <acquire>
    80002b94:	02048c63          	beqz	s1,80002bcc <consoleintr+0x68>
    80002b98:	0a092783          	lw	a5,160(s2)
    80002b9c:	09892703          	lw	a4,152(s2)
    80002ba0:	07f00693          	li	a3,127
    80002ba4:	40e7873b          	subw	a4,a5,a4
    80002ba8:	02e6e263          	bltu	a3,a4,80002bcc <consoleintr+0x68>
    80002bac:	00d00713          	li	a4,13
    80002bb0:	04e48063          	beq	s1,a4,80002bf0 <consoleintr+0x8c>
    80002bb4:	07f7f713          	andi	a4,a5,127
    80002bb8:	00e90733          	add	a4,s2,a4
    80002bbc:	0017879b          	addiw	a5,a5,1
    80002bc0:	0af92023          	sw	a5,160(s2)
    80002bc4:	00970c23          	sb	s1,24(a4)
    80002bc8:	08f92e23          	sw	a5,156(s2)
    80002bcc:	01013403          	ld	s0,16(sp)
    80002bd0:	01813083          	ld	ra,24(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	00013903          	ld	s2,0(sp)
    80002bdc:	00004517          	auipc	a0,0x4
    80002be0:	d7c50513          	addi	a0,a0,-644 # 80006958 <cons>
    80002be4:	02010113          	addi	sp,sp,32
    80002be8:	00001317          	auipc	t1,0x1
    80002bec:	eb030067          	jr	-336(t1) # 80003a98 <release>
    80002bf0:	00a00493          	li	s1,10
    80002bf4:	fc1ff06f          	j	80002bb4 <consoleintr+0x50>

0000000080002bf8 <consoleinit>:
    80002bf8:	fe010113          	addi	sp,sp,-32
    80002bfc:	00113c23          	sd	ra,24(sp)
    80002c00:	00813823          	sd	s0,16(sp)
    80002c04:	00913423          	sd	s1,8(sp)
    80002c08:	02010413          	addi	s0,sp,32
    80002c0c:	00004497          	auipc	s1,0x4
    80002c10:	d4c48493          	addi	s1,s1,-692 # 80006958 <cons>
    80002c14:	00048513          	mv	a0,s1
    80002c18:	00002597          	auipc	a1,0x2
    80002c1c:	5b058593          	addi	a1,a1,1456 # 800051c8 <_ZZ12printIntegermE6digits+0x138>
    80002c20:	00001097          	auipc	ra,0x1
    80002c24:	d88080e7          	jalr	-632(ra) # 800039a8 <initlock>
    80002c28:	00000097          	auipc	ra,0x0
    80002c2c:	7ac080e7          	jalr	1964(ra) # 800033d4 <uartinit>
    80002c30:	01813083          	ld	ra,24(sp)
    80002c34:	01013403          	ld	s0,16(sp)
    80002c38:	00000797          	auipc	a5,0x0
    80002c3c:	d9c78793          	addi	a5,a5,-612 # 800029d4 <consoleread>
    80002c40:	0af4bc23          	sd	a5,184(s1)
    80002c44:	00000797          	auipc	a5,0x0
    80002c48:	cec78793          	addi	a5,a5,-788 # 80002930 <consolewrite>
    80002c4c:	0cf4b023          	sd	a5,192(s1)
    80002c50:	00813483          	ld	s1,8(sp)
    80002c54:	02010113          	addi	sp,sp,32
    80002c58:	00008067          	ret

0000000080002c5c <console_read>:
    80002c5c:	ff010113          	addi	sp,sp,-16
    80002c60:	00813423          	sd	s0,8(sp)
    80002c64:	01010413          	addi	s0,sp,16
    80002c68:	00813403          	ld	s0,8(sp)
    80002c6c:	00004317          	auipc	t1,0x4
    80002c70:	da433303          	ld	t1,-604(t1) # 80006a10 <devsw+0x10>
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00030067          	jr	t1

0000000080002c7c <console_write>:
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00813423          	sd	s0,8(sp)
    80002c84:	01010413          	addi	s0,sp,16
    80002c88:	00813403          	ld	s0,8(sp)
    80002c8c:	00004317          	auipc	t1,0x4
    80002c90:	d8c33303          	ld	t1,-628(t1) # 80006a18 <devsw+0x18>
    80002c94:	01010113          	addi	sp,sp,16
    80002c98:	00030067          	jr	t1

0000000080002c9c <panic>:
    80002c9c:	fe010113          	addi	sp,sp,-32
    80002ca0:	00113c23          	sd	ra,24(sp)
    80002ca4:	00813823          	sd	s0,16(sp)
    80002ca8:	00913423          	sd	s1,8(sp)
    80002cac:	02010413          	addi	s0,sp,32
    80002cb0:	00050493          	mv	s1,a0
    80002cb4:	00002517          	auipc	a0,0x2
    80002cb8:	51c50513          	addi	a0,a0,1308 # 800051d0 <_ZZ12printIntegermE6digits+0x140>
    80002cbc:	00004797          	auipc	a5,0x4
    80002cc0:	de07ae23          	sw	zero,-516(a5) # 80006ab8 <pr+0x18>
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	034080e7          	jalr	52(ra) # 80002cf8 <__printf>
    80002ccc:	00048513          	mv	a0,s1
    80002cd0:	00000097          	auipc	ra,0x0
    80002cd4:	028080e7          	jalr	40(ra) # 80002cf8 <__printf>
    80002cd8:	00002517          	auipc	a0,0x2
    80002cdc:	35850513          	addi	a0,a0,856 # 80005030 <CONSOLE_STATUS+0x20>
    80002ce0:	00000097          	auipc	ra,0x0
    80002ce4:	018080e7          	jalr	24(ra) # 80002cf8 <__printf>
    80002ce8:	00100793          	li	a5,1
    80002cec:	00003717          	auipc	a4,0x3
    80002cf0:	b2f72e23          	sw	a5,-1220(a4) # 80005828 <panicked>
    80002cf4:	0000006f          	j	80002cf4 <panic+0x58>

0000000080002cf8 <__printf>:
    80002cf8:	f3010113          	addi	sp,sp,-208
    80002cfc:	08813023          	sd	s0,128(sp)
    80002d00:	07313423          	sd	s3,104(sp)
    80002d04:	09010413          	addi	s0,sp,144
    80002d08:	05813023          	sd	s8,64(sp)
    80002d0c:	08113423          	sd	ra,136(sp)
    80002d10:	06913c23          	sd	s1,120(sp)
    80002d14:	07213823          	sd	s2,112(sp)
    80002d18:	07413023          	sd	s4,96(sp)
    80002d1c:	05513c23          	sd	s5,88(sp)
    80002d20:	05613823          	sd	s6,80(sp)
    80002d24:	05713423          	sd	s7,72(sp)
    80002d28:	03913c23          	sd	s9,56(sp)
    80002d2c:	03a13823          	sd	s10,48(sp)
    80002d30:	03b13423          	sd	s11,40(sp)
    80002d34:	00004317          	auipc	t1,0x4
    80002d38:	d6c30313          	addi	t1,t1,-660 # 80006aa0 <pr>
    80002d3c:	01832c03          	lw	s8,24(t1)
    80002d40:	00b43423          	sd	a1,8(s0)
    80002d44:	00c43823          	sd	a2,16(s0)
    80002d48:	00d43c23          	sd	a3,24(s0)
    80002d4c:	02e43023          	sd	a4,32(s0)
    80002d50:	02f43423          	sd	a5,40(s0)
    80002d54:	03043823          	sd	a6,48(s0)
    80002d58:	03143c23          	sd	a7,56(s0)
    80002d5c:	00050993          	mv	s3,a0
    80002d60:	4a0c1663          	bnez	s8,8000320c <__printf+0x514>
    80002d64:	60098c63          	beqz	s3,8000337c <__printf+0x684>
    80002d68:	0009c503          	lbu	a0,0(s3)
    80002d6c:	00840793          	addi	a5,s0,8
    80002d70:	f6f43c23          	sd	a5,-136(s0)
    80002d74:	00000493          	li	s1,0
    80002d78:	22050063          	beqz	a0,80002f98 <__printf+0x2a0>
    80002d7c:	00002a37          	lui	s4,0x2
    80002d80:	00018ab7          	lui	s5,0x18
    80002d84:	000f4b37          	lui	s6,0xf4
    80002d88:	00989bb7          	lui	s7,0x989
    80002d8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002d90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002d94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002d98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002d9c:	00148c9b          	addiw	s9,s1,1
    80002da0:	02500793          	li	a5,37
    80002da4:	01998933          	add	s2,s3,s9
    80002da8:	38f51263          	bne	a0,a5,8000312c <__printf+0x434>
    80002dac:	00094783          	lbu	a5,0(s2)
    80002db0:	00078c9b          	sext.w	s9,a5
    80002db4:	1e078263          	beqz	a5,80002f98 <__printf+0x2a0>
    80002db8:	0024849b          	addiw	s1,s1,2
    80002dbc:	07000713          	li	a4,112
    80002dc0:	00998933          	add	s2,s3,s1
    80002dc4:	38e78a63          	beq	a5,a4,80003158 <__printf+0x460>
    80002dc8:	20f76863          	bltu	a4,a5,80002fd8 <__printf+0x2e0>
    80002dcc:	42a78863          	beq	a5,a0,800031fc <__printf+0x504>
    80002dd0:	06400713          	li	a4,100
    80002dd4:	40e79663          	bne	a5,a4,800031e0 <__printf+0x4e8>
    80002dd8:	f7843783          	ld	a5,-136(s0)
    80002ddc:	0007a603          	lw	a2,0(a5)
    80002de0:	00878793          	addi	a5,a5,8
    80002de4:	f6f43c23          	sd	a5,-136(s0)
    80002de8:	42064a63          	bltz	a2,8000321c <__printf+0x524>
    80002dec:	00a00713          	li	a4,10
    80002df0:	02e677bb          	remuw	a5,a2,a4
    80002df4:	00002d97          	auipc	s11,0x2
    80002df8:	404d8d93          	addi	s11,s11,1028 # 800051f8 <digits>
    80002dfc:	00900593          	li	a1,9
    80002e00:	0006051b          	sext.w	a0,a2
    80002e04:	00000c93          	li	s9,0
    80002e08:	02079793          	slli	a5,a5,0x20
    80002e0c:	0207d793          	srli	a5,a5,0x20
    80002e10:	00fd87b3          	add	a5,s11,a5
    80002e14:	0007c783          	lbu	a5,0(a5)
    80002e18:	02e656bb          	divuw	a3,a2,a4
    80002e1c:	f8f40023          	sb	a5,-128(s0)
    80002e20:	14c5d863          	bge	a1,a2,80002f70 <__printf+0x278>
    80002e24:	06300593          	li	a1,99
    80002e28:	00100c93          	li	s9,1
    80002e2c:	02e6f7bb          	remuw	a5,a3,a4
    80002e30:	02079793          	slli	a5,a5,0x20
    80002e34:	0207d793          	srli	a5,a5,0x20
    80002e38:	00fd87b3          	add	a5,s11,a5
    80002e3c:	0007c783          	lbu	a5,0(a5)
    80002e40:	02e6d73b          	divuw	a4,a3,a4
    80002e44:	f8f400a3          	sb	a5,-127(s0)
    80002e48:	12a5f463          	bgeu	a1,a0,80002f70 <__printf+0x278>
    80002e4c:	00a00693          	li	a3,10
    80002e50:	00900593          	li	a1,9
    80002e54:	02d777bb          	remuw	a5,a4,a3
    80002e58:	02079793          	slli	a5,a5,0x20
    80002e5c:	0207d793          	srli	a5,a5,0x20
    80002e60:	00fd87b3          	add	a5,s11,a5
    80002e64:	0007c503          	lbu	a0,0(a5)
    80002e68:	02d757bb          	divuw	a5,a4,a3
    80002e6c:	f8a40123          	sb	a0,-126(s0)
    80002e70:	48e5f263          	bgeu	a1,a4,800032f4 <__printf+0x5fc>
    80002e74:	06300513          	li	a0,99
    80002e78:	02d7f5bb          	remuw	a1,a5,a3
    80002e7c:	02059593          	slli	a1,a1,0x20
    80002e80:	0205d593          	srli	a1,a1,0x20
    80002e84:	00bd85b3          	add	a1,s11,a1
    80002e88:	0005c583          	lbu	a1,0(a1)
    80002e8c:	02d7d7bb          	divuw	a5,a5,a3
    80002e90:	f8b401a3          	sb	a1,-125(s0)
    80002e94:	48e57263          	bgeu	a0,a4,80003318 <__printf+0x620>
    80002e98:	3e700513          	li	a0,999
    80002e9c:	02d7f5bb          	remuw	a1,a5,a3
    80002ea0:	02059593          	slli	a1,a1,0x20
    80002ea4:	0205d593          	srli	a1,a1,0x20
    80002ea8:	00bd85b3          	add	a1,s11,a1
    80002eac:	0005c583          	lbu	a1,0(a1)
    80002eb0:	02d7d7bb          	divuw	a5,a5,a3
    80002eb4:	f8b40223          	sb	a1,-124(s0)
    80002eb8:	46e57663          	bgeu	a0,a4,80003324 <__printf+0x62c>
    80002ebc:	02d7f5bb          	remuw	a1,a5,a3
    80002ec0:	02059593          	slli	a1,a1,0x20
    80002ec4:	0205d593          	srli	a1,a1,0x20
    80002ec8:	00bd85b3          	add	a1,s11,a1
    80002ecc:	0005c583          	lbu	a1,0(a1)
    80002ed0:	02d7d7bb          	divuw	a5,a5,a3
    80002ed4:	f8b402a3          	sb	a1,-123(s0)
    80002ed8:	46ea7863          	bgeu	s4,a4,80003348 <__printf+0x650>
    80002edc:	02d7f5bb          	remuw	a1,a5,a3
    80002ee0:	02059593          	slli	a1,a1,0x20
    80002ee4:	0205d593          	srli	a1,a1,0x20
    80002ee8:	00bd85b3          	add	a1,s11,a1
    80002eec:	0005c583          	lbu	a1,0(a1)
    80002ef0:	02d7d7bb          	divuw	a5,a5,a3
    80002ef4:	f8b40323          	sb	a1,-122(s0)
    80002ef8:	3eeaf863          	bgeu	s5,a4,800032e8 <__printf+0x5f0>
    80002efc:	02d7f5bb          	remuw	a1,a5,a3
    80002f00:	02059593          	slli	a1,a1,0x20
    80002f04:	0205d593          	srli	a1,a1,0x20
    80002f08:	00bd85b3          	add	a1,s11,a1
    80002f0c:	0005c583          	lbu	a1,0(a1)
    80002f10:	02d7d7bb          	divuw	a5,a5,a3
    80002f14:	f8b403a3          	sb	a1,-121(s0)
    80002f18:	42eb7e63          	bgeu	s6,a4,80003354 <__printf+0x65c>
    80002f1c:	02d7f5bb          	remuw	a1,a5,a3
    80002f20:	02059593          	slli	a1,a1,0x20
    80002f24:	0205d593          	srli	a1,a1,0x20
    80002f28:	00bd85b3          	add	a1,s11,a1
    80002f2c:	0005c583          	lbu	a1,0(a1)
    80002f30:	02d7d7bb          	divuw	a5,a5,a3
    80002f34:	f8b40423          	sb	a1,-120(s0)
    80002f38:	42ebfc63          	bgeu	s7,a4,80003370 <__printf+0x678>
    80002f3c:	02079793          	slli	a5,a5,0x20
    80002f40:	0207d793          	srli	a5,a5,0x20
    80002f44:	00fd8db3          	add	s11,s11,a5
    80002f48:	000dc703          	lbu	a4,0(s11)
    80002f4c:	00a00793          	li	a5,10
    80002f50:	00900c93          	li	s9,9
    80002f54:	f8e404a3          	sb	a4,-119(s0)
    80002f58:	00065c63          	bgez	a2,80002f70 <__printf+0x278>
    80002f5c:	f9040713          	addi	a4,s0,-112
    80002f60:	00f70733          	add	a4,a4,a5
    80002f64:	02d00693          	li	a3,45
    80002f68:	fed70823          	sb	a3,-16(a4)
    80002f6c:	00078c93          	mv	s9,a5
    80002f70:	f8040793          	addi	a5,s0,-128
    80002f74:	01978cb3          	add	s9,a5,s9
    80002f78:	f7f40d13          	addi	s10,s0,-129
    80002f7c:	000cc503          	lbu	a0,0(s9)
    80002f80:	fffc8c93          	addi	s9,s9,-1
    80002f84:	00000097          	auipc	ra,0x0
    80002f88:	b90080e7          	jalr	-1136(ra) # 80002b14 <consputc>
    80002f8c:	ffac98e3          	bne	s9,s10,80002f7c <__printf+0x284>
    80002f90:	00094503          	lbu	a0,0(s2)
    80002f94:	e00514e3          	bnez	a0,80002d9c <__printf+0xa4>
    80002f98:	1a0c1663          	bnez	s8,80003144 <__printf+0x44c>
    80002f9c:	08813083          	ld	ra,136(sp)
    80002fa0:	08013403          	ld	s0,128(sp)
    80002fa4:	07813483          	ld	s1,120(sp)
    80002fa8:	07013903          	ld	s2,112(sp)
    80002fac:	06813983          	ld	s3,104(sp)
    80002fb0:	06013a03          	ld	s4,96(sp)
    80002fb4:	05813a83          	ld	s5,88(sp)
    80002fb8:	05013b03          	ld	s6,80(sp)
    80002fbc:	04813b83          	ld	s7,72(sp)
    80002fc0:	04013c03          	ld	s8,64(sp)
    80002fc4:	03813c83          	ld	s9,56(sp)
    80002fc8:	03013d03          	ld	s10,48(sp)
    80002fcc:	02813d83          	ld	s11,40(sp)
    80002fd0:	0d010113          	addi	sp,sp,208
    80002fd4:	00008067          	ret
    80002fd8:	07300713          	li	a4,115
    80002fdc:	1ce78a63          	beq	a5,a4,800031b0 <__printf+0x4b8>
    80002fe0:	07800713          	li	a4,120
    80002fe4:	1ee79e63          	bne	a5,a4,800031e0 <__printf+0x4e8>
    80002fe8:	f7843783          	ld	a5,-136(s0)
    80002fec:	0007a703          	lw	a4,0(a5)
    80002ff0:	00878793          	addi	a5,a5,8
    80002ff4:	f6f43c23          	sd	a5,-136(s0)
    80002ff8:	28074263          	bltz	a4,8000327c <__printf+0x584>
    80002ffc:	00002d97          	auipc	s11,0x2
    80003000:	1fcd8d93          	addi	s11,s11,508 # 800051f8 <digits>
    80003004:	00f77793          	andi	a5,a4,15
    80003008:	00fd87b3          	add	a5,s11,a5
    8000300c:	0007c683          	lbu	a3,0(a5)
    80003010:	00f00613          	li	a2,15
    80003014:	0007079b          	sext.w	a5,a4
    80003018:	f8d40023          	sb	a3,-128(s0)
    8000301c:	0047559b          	srliw	a1,a4,0x4
    80003020:	0047569b          	srliw	a3,a4,0x4
    80003024:	00000c93          	li	s9,0
    80003028:	0ee65063          	bge	a2,a4,80003108 <__printf+0x410>
    8000302c:	00f6f693          	andi	a3,a3,15
    80003030:	00dd86b3          	add	a3,s11,a3
    80003034:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003038:	0087d79b          	srliw	a5,a5,0x8
    8000303c:	00100c93          	li	s9,1
    80003040:	f8d400a3          	sb	a3,-127(s0)
    80003044:	0cb67263          	bgeu	a2,a1,80003108 <__printf+0x410>
    80003048:	00f7f693          	andi	a3,a5,15
    8000304c:	00dd86b3          	add	a3,s11,a3
    80003050:	0006c583          	lbu	a1,0(a3)
    80003054:	00f00613          	li	a2,15
    80003058:	0047d69b          	srliw	a3,a5,0x4
    8000305c:	f8b40123          	sb	a1,-126(s0)
    80003060:	0047d593          	srli	a1,a5,0x4
    80003064:	28f67e63          	bgeu	a2,a5,80003300 <__printf+0x608>
    80003068:	00f6f693          	andi	a3,a3,15
    8000306c:	00dd86b3          	add	a3,s11,a3
    80003070:	0006c503          	lbu	a0,0(a3)
    80003074:	0087d813          	srli	a6,a5,0x8
    80003078:	0087d69b          	srliw	a3,a5,0x8
    8000307c:	f8a401a3          	sb	a0,-125(s0)
    80003080:	28b67663          	bgeu	a2,a1,8000330c <__printf+0x614>
    80003084:	00f6f693          	andi	a3,a3,15
    80003088:	00dd86b3          	add	a3,s11,a3
    8000308c:	0006c583          	lbu	a1,0(a3)
    80003090:	00c7d513          	srli	a0,a5,0xc
    80003094:	00c7d69b          	srliw	a3,a5,0xc
    80003098:	f8b40223          	sb	a1,-124(s0)
    8000309c:	29067a63          	bgeu	a2,a6,80003330 <__printf+0x638>
    800030a0:	00f6f693          	andi	a3,a3,15
    800030a4:	00dd86b3          	add	a3,s11,a3
    800030a8:	0006c583          	lbu	a1,0(a3)
    800030ac:	0107d813          	srli	a6,a5,0x10
    800030b0:	0107d69b          	srliw	a3,a5,0x10
    800030b4:	f8b402a3          	sb	a1,-123(s0)
    800030b8:	28a67263          	bgeu	a2,a0,8000333c <__printf+0x644>
    800030bc:	00f6f693          	andi	a3,a3,15
    800030c0:	00dd86b3          	add	a3,s11,a3
    800030c4:	0006c683          	lbu	a3,0(a3)
    800030c8:	0147d79b          	srliw	a5,a5,0x14
    800030cc:	f8d40323          	sb	a3,-122(s0)
    800030d0:	21067663          	bgeu	a2,a6,800032dc <__printf+0x5e4>
    800030d4:	02079793          	slli	a5,a5,0x20
    800030d8:	0207d793          	srli	a5,a5,0x20
    800030dc:	00fd8db3          	add	s11,s11,a5
    800030e0:	000dc683          	lbu	a3,0(s11)
    800030e4:	00800793          	li	a5,8
    800030e8:	00700c93          	li	s9,7
    800030ec:	f8d403a3          	sb	a3,-121(s0)
    800030f0:	00075c63          	bgez	a4,80003108 <__printf+0x410>
    800030f4:	f9040713          	addi	a4,s0,-112
    800030f8:	00f70733          	add	a4,a4,a5
    800030fc:	02d00693          	li	a3,45
    80003100:	fed70823          	sb	a3,-16(a4)
    80003104:	00078c93          	mv	s9,a5
    80003108:	f8040793          	addi	a5,s0,-128
    8000310c:	01978cb3          	add	s9,a5,s9
    80003110:	f7f40d13          	addi	s10,s0,-129
    80003114:	000cc503          	lbu	a0,0(s9)
    80003118:	fffc8c93          	addi	s9,s9,-1
    8000311c:	00000097          	auipc	ra,0x0
    80003120:	9f8080e7          	jalr	-1544(ra) # 80002b14 <consputc>
    80003124:	ff9d18e3          	bne	s10,s9,80003114 <__printf+0x41c>
    80003128:	0100006f          	j	80003138 <__printf+0x440>
    8000312c:	00000097          	auipc	ra,0x0
    80003130:	9e8080e7          	jalr	-1560(ra) # 80002b14 <consputc>
    80003134:	000c8493          	mv	s1,s9
    80003138:	00094503          	lbu	a0,0(s2)
    8000313c:	c60510e3          	bnez	a0,80002d9c <__printf+0xa4>
    80003140:	e40c0ee3          	beqz	s8,80002f9c <__printf+0x2a4>
    80003144:	00004517          	auipc	a0,0x4
    80003148:	95c50513          	addi	a0,a0,-1700 # 80006aa0 <pr>
    8000314c:	00001097          	auipc	ra,0x1
    80003150:	94c080e7          	jalr	-1716(ra) # 80003a98 <release>
    80003154:	e49ff06f          	j	80002f9c <__printf+0x2a4>
    80003158:	f7843783          	ld	a5,-136(s0)
    8000315c:	03000513          	li	a0,48
    80003160:	01000d13          	li	s10,16
    80003164:	00878713          	addi	a4,a5,8
    80003168:	0007bc83          	ld	s9,0(a5)
    8000316c:	f6e43c23          	sd	a4,-136(s0)
    80003170:	00000097          	auipc	ra,0x0
    80003174:	9a4080e7          	jalr	-1628(ra) # 80002b14 <consputc>
    80003178:	07800513          	li	a0,120
    8000317c:	00000097          	auipc	ra,0x0
    80003180:	998080e7          	jalr	-1640(ra) # 80002b14 <consputc>
    80003184:	00002d97          	auipc	s11,0x2
    80003188:	074d8d93          	addi	s11,s11,116 # 800051f8 <digits>
    8000318c:	03ccd793          	srli	a5,s9,0x3c
    80003190:	00fd87b3          	add	a5,s11,a5
    80003194:	0007c503          	lbu	a0,0(a5)
    80003198:	fffd0d1b          	addiw	s10,s10,-1
    8000319c:	004c9c93          	slli	s9,s9,0x4
    800031a0:	00000097          	auipc	ra,0x0
    800031a4:	974080e7          	jalr	-1676(ra) # 80002b14 <consputc>
    800031a8:	fe0d12e3          	bnez	s10,8000318c <__printf+0x494>
    800031ac:	f8dff06f          	j	80003138 <__printf+0x440>
    800031b0:	f7843783          	ld	a5,-136(s0)
    800031b4:	0007bc83          	ld	s9,0(a5)
    800031b8:	00878793          	addi	a5,a5,8
    800031bc:	f6f43c23          	sd	a5,-136(s0)
    800031c0:	000c9a63          	bnez	s9,800031d4 <__printf+0x4dc>
    800031c4:	1080006f          	j	800032cc <__printf+0x5d4>
    800031c8:	001c8c93          	addi	s9,s9,1
    800031cc:	00000097          	auipc	ra,0x0
    800031d0:	948080e7          	jalr	-1720(ra) # 80002b14 <consputc>
    800031d4:	000cc503          	lbu	a0,0(s9)
    800031d8:	fe0518e3          	bnez	a0,800031c8 <__printf+0x4d0>
    800031dc:	f5dff06f          	j	80003138 <__printf+0x440>
    800031e0:	02500513          	li	a0,37
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	930080e7          	jalr	-1744(ra) # 80002b14 <consputc>
    800031ec:	000c8513          	mv	a0,s9
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	924080e7          	jalr	-1756(ra) # 80002b14 <consputc>
    800031f8:	f41ff06f          	j	80003138 <__printf+0x440>
    800031fc:	02500513          	li	a0,37
    80003200:	00000097          	auipc	ra,0x0
    80003204:	914080e7          	jalr	-1772(ra) # 80002b14 <consputc>
    80003208:	f31ff06f          	j	80003138 <__printf+0x440>
    8000320c:	00030513          	mv	a0,t1
    80003210:	00000097          	auipc	ra,0x0
    80003214:	7bc080e7          	jalr	1980(ra) # 800039cc <acquire>
    80003218:	b4dff06f          	j	80002d64 <__printf+0x6c>
    8000321c:	40c0053b          	negw	a0,a2
    80003220:	00a00713          	li	a4,10
    80003224:	02e576bb          	remuw	a3,a0,a4
    80003228:	00002d97          	auipc	s11,0x2
    8000322c:	fd0d8d93          	addi	s11,s11,-48 # 800051f8 <digits>
    80003230:	ff700593          	li	a1,-9
    80003234:	02069693          	slli	a3,a3,0x20
    80003238:	0206d693          	srli	a3,a3,0x20
    8000323c:	00dd86b3          	add	a3,s11,a3
    80003240:	0006c683          	lbu	a3,0(a3)
    80003244:	02e557bb          	divuw	a5,a0,a4
    80003248:	f8d40023          	sb	a3,-128(s0)
    8000324c:	10b65e63          	bge	a2,a1,80003368 <__printf+0x670>
    80003250:	06300593          	li	a1,99
    80003254:	02e7f6bb          	remuw	a3,a5,a4
    80003258:	02069693          	slli	a3,a3,0x20
    8000325c:	0206d693          	srli	a3,a3,0x20
    80003260:	00dd86b3          	add	a3,s11,a3
    80003264:	0006c683          	lbu	a3,0(a3)
    80003268:	02e7d73b          	divuw	a4,a5,a4
    8000326c:	00200793          	li	a5,2
    80003270:	f8d400a3          	sb	a3,-127(s0)
    80003274:	bca5ece3          	bltu	a1,a0,80002e4c <__printf+0x154>
    80003278:	ce5ff06f          	j	80002f5c <__printf+0x264>
    8000327c:	40e007bb          	negw	a5,a4
    80003280:	00002d97          	auipc	s11,0x2
    80003284:	f78d8d93          	addi	s11,s11,-136 # 800051f8 <digits>
    80003288:	00f7f693          	andi	a3,a5,15
    8000328c:	00dd86b3          	add	a3,s11,a3
    80003290:	0006c583          	lbu	a1,0(a3)
    80003294:	ff100613          	li	a2,-15
    80003298:	0047d69b          	srliw	a3,a5,0x4
    8000329c:	f8b40023          	sb	a1,-128(s0)
    800032a0:	0047d59b          	srliw	a1,a5,0x4
    800032a4:	0ac75e63          	bge	a4,a2,80003360 <__printf+0x668>
    800032a8:	00f6f693          	andi	a3,a3,15
    800032ac:	00dd86b3          	add	a3,s11,a3
    800032b0:	0006c603          	lbu	a2,0(a3)
    800032b4:	00f00693          	li	a3,15
    800032b8:	0087d79b          	srliw	a5,a5,0x8
    800032bc:	f8c400a3          	sb	a2,-127(s0)
    800032c0:	d8b6e4e3          	bltu	a3,a1,80003048 <__printf+0x350>
    800032c4:	00200793          	li	a5,2
    800032c8:	e2dff06f          	j	800030f4 <__printf+0x3fc>
    800032cc:	00002c97          	auipc	s9,0x2
    800032d0:	f0cc8c93          	addi	s9,s9,-244 # 800051d8 <_ZZ12printIntegermE6digits+0x148>
    800032d4:	02800513          	li	a0,40
    800032d8:	ef1ff06f          	j	800031c8 <__printf+0x4d0>
    800032dc:	00700793          	li	a5,7
    800032e0:	00600c93          	li	s9,6
    800032e4:	e0dff06f          	j	800030f0 <__printf+0x3f8>
    800032e8:	00700793          	li	a5,7
    800032ec:	00600c93          	li	s9,6
    800032f0:	c69ff06f          	j	80002f58 <__printf+0x260>
    800032f4:	00300793          	li	a5,3
    800032f8:	00200c93          	li	s9,2
    800032fc:	c5dff06f          	j	80002f58 <__printf+0x260>
    80003300:	00300793          	li	a5,3
    80003304:	00200c93          	li	s9,2
    80003308:	de9ff06f          	j	800030f0 <__printf+0x3f8>
    8000330c:	00400793          	li	a5,4
    80003310:	00300c93          	li	s9,3
    80003314:	dddff06f          	j	800030f0 <__printf+0x3f8>
    80003318:	00400793          	li	a5,4
    8000331c:	00300c93          	li	s9,3
    80003320:	c39ff06f          	j	80002f58 <__printf+0x260>
    80003324:	00500793          	li	a5,5
    80003328:	00400c93          	li	s9,4
    8000332c:	c2dff06f          	j	80002f58 <__printf+0x260>
    80003330:	00500793          	li	a5,5
    80003334:	00400c93          	li	s9,4
    80003338:	db9ff06f          	j	800030f0 <__printf+0x3f8>
    8000333c:	00600793          	li	a5,6
    80003340:	00500c93          	li	s9,5
    80003344:	dadff06f          	j	800030f0 <__printf+0x3f8>
    80003348:	00600793          	li	a5,6
    8000334c:	00500c93          	li	s9,5
    80003350:	c09ff06f          	j	80002f58 <__printf+0x260>
    80003354:	00800793          	li	a5,8
    80003358:	00700c93          	li	s9,7
    8000335c:	bfdff06f          	j	80002f58 <__printf+0x260>
    80003360:	00100793          	li	a5,1
    80003364:	d91ff06f          	j	800030f4 <__printf+0x3fc>
    80003368:	00100793          	li	a5,1
    8000336c:	bf1ff06f          	j	80002f5c <__printf+0x264>
    80003370:	00900793          	li	a5,9
    80003374:	00800c93          	li	s9,8
    80003378:	be1ff06f          	j	80002f58 <__printf+0x260>
    8000337c:	00002517          	auipc	a0,0x2
    80003380:	e6450513          	addi	a0,a0,-412 # 800051e0 <_ZZ12printIntegermE6digits+0x150>
    80003384:	00000097          	auipc	ra,0x0
    80003388:	918080e7          	jalr	-1768(ra) # 80002c9c <panic>

000000008000338c <printfinit>:
    8000338c:	fe010113          	addi	sp,sp,-32
    80003390:	00813823          	sd	s0,16(sp)
    80003394:	00913423          	sd	s1,8(sp)
    80003398:	00113c23          	sd	ra,24(sp)
    8000339c:	02010413          	addi	s0,sp,32
    800033a0:	00003497          	auipc	s1,0x3
    800033a4:	70048493          	addi	s1,s1,1792 # 80006aa0 <pr>
    800033a8:	00048513          	mv	a0,s1
    800033ac:	00002597          	auipc	a1,0x2
    800033b0:	e4458593          	addi	a1,a1,-444 # 800051f0 <_ZZ12printIntegermE6digits+0x160>
    800033b4:	00000097          	auipc	ra,0x0
    800033b8:	5f4080e7          	jalr	1524(ra) # 800039a8 <initlock>
    800033bc:	01813083          	ld	ra,24(sp)
    800033c0:	01013403          	ld	s0,16(sp)
    800033c4:	0004ac23          	sw	zero,24(s1)
    800033c8:	00813483          	ld	s1,8(sp)
    800033cc:	02010113          	addi	sp,sp,32
    800033d0:	00008067          	ret

00000000800033d4 <uartinit>:
    800033d4:	ff010113          	addi	sp,sp,-16
    800033d8:	00813423          	sd	s0,8(sp)
    800033dc:	01010413          	addi	s0,sp,16
    800033e0:	100007b7          	lui	a5,0x10000
    800033e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800033e8:	f8000713          	li	a4,-128
    800033ec:	00e781a3          	sb	a4,3(a5)
    800033f0:	00300713          	li	a4,3
    800033f4:	00e78023          	sb	a4,0(a5)
    800033f8:	000780a3          	sb	zero,1(a5)
    800033fc:	00e781a3          	sb	a4,3(a5)
    80003400:	00700693          	li	a3,7
    80003404:	00d78123          	sb	a3,2(a5)
    80003408:	00e780a3          	sb	a4,1(a5)
    8000340c:	00813403          	ld	s0,8(sp)
    80003410:	01010113          	addi	sp,sp,16
    80003414:	00008067          	ret

0000000080003418 <uartputc>:
    80003418:	00002797          	auipc	a5,0x2
    8000341c:	4107a783          	lw	a5,1040(a5) # 80005828 <panicked>
    80003420:	00078463          	beqz	a5,80003428 <uartputc+0x10>
    80003424:	0000006f          	j	80003424 <uartputc+0xc>
    80003428:	fd010113          	addi	sp,sp,-48
    8000342c:	02813023          	sd	s0,32(sp)
    80003430:	00913c23          	sd	s1,24(sp)
    80003434:	01213823          	sd	s2,16(sp)
    80003438:	01313423          	sd	s3,8(sp)
    8000343c:	02113423          	sd	ra,40(sp)
    80003440:	03010413          	addi	s0,sp,48
    80003444:	00002917          	auipc	s2,0x2
    80003448:	3ec90913          	addi	s2,s2,1004 # 80005830 <uart_tx_r>
    8000344c:	00093783          	ld	a5,0(s2)
    80003450:	00002497          	auipc	s1,0x2
    80003454:	3e848493          	addi	s1,s1,1000 # 80005838 <uart_tx_w>
    80003458:	0004b703          	ld	a4,0(s1)
    8000345c:	02078693          	addi	a3,a5,32
    80003460:	00050993          	mv	s3,a0
    80003464:	02e69c63          	bne	a3,a4,8000349c <uartputc+0x84>
    80003468:	00001097          	auipc	ra,0x1
    8000346c:	834080e7          	jalr	-1996(ra) # 80003c9c <push_on>
    80003470:	00093783          	ld	a5,0(s2)
    80003474:	0004b703          	ld	a4,0(s1)
    80003478:	02078793          	addi	a5,a5,32
    8000347c:	00e79463          	bne	a5,a4,80003484 <uartputc+0x6c>
    80003480:	0000006f          	j	80003480 <uartputc+0x68>
    80003484:	00001097          	auipc	ra,0x1
    80003488:	88c080e7          	jalr	-1908(ra) # 80003d10 <pop_on>
    8000348c:	00093783          	ld	a5,0(s2)
    80003490:	0004b703          	ld	a4,0(s1)
    80003494:	02078693          	addi	a3,a5,32
    80003498:	fce688e3          	beq	a3,a4,80003468 <uartputc+0x50>
    8000349c:	01f77693          	andi	a3,a4,31
    800034a0:	00003597          	auipc	a1,0x3
    800034a4:	62058593          	addi	a1,a1,1568 # 80006ac0 <uart_tx_buf>
    800034a8:	00d586b3          	add	a3,a1,a3
    800034ac:	00170713          	addi	a4,a4,1
    800034b0:	01368023          	sb	s3,0(a3)
    800034b4:	00e4b023          	sd	a4,0(s1)
    800034b8:	10000637          	lui	a2,0x10000
    800034bc:	02f71063          	bne	a4,a5,800034dc <uartputc+0xc4>
    800034c0:	0340006f          	j	800034f4 <uartputc+0xdc>
    800034c4:	00074703          	lbu	a4,0(a4)
    800034c8:	00f93023          	sd	a5,0(s2)
    800034cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800034d0:	00093783          	ld	a5,0(s2)
    800034d4:	0004b703          	ld	a4,0(s1)
    800034d8:	00f70e63          	beq	a4,a5,800034f4 <uartputc+0xdc>
    800034dc:	00564683          	lbu	a3,5(a2)
    800034e0:	01f7f713          	andi	a4,a5,31
    800034e4:	00e58733          	add	a4,a1,a4
    800034e8:	0206f693          	andi	a3,a3,32
    800034ec:	00178793          	addi	a5,a5,1
    800034f0:	fc069ae3          	bnez	a3,800034c4 <uartputc+0xac>
    800034f4:	02813083          	ld	ra,40(sp)
    800034f8:	02013403          	ld	s0,32(sp)
    800034fc:	01813483          	ld	s1,24(sp)
    80003500:	01013903          	ld	s2,16(sp)
    80003504:	00813983          	ld	s3,8(sp)
    80003508:	03010113          	addi	sp,sp,48
    8000350c:	00008067          	ret

0000000080003510 <uartputc_sync>:
    80003510:	ff010113          	addi	sp,sp,-16
    80003514:	00813423          	sd	s0,8(sp)
    80003518:	01010413          	addi	s0,sp,16
    8000351c:	00002717          	auipc	a4,0x2
    80003520:	30c72703          	lw	a4,780(a4) # 80005828 <panicked>
    80003524:	02071663          	bnez	a4,80003550 <uartputc_sync+0x40>
    80003528:	00050793          	mv	a5,a0
    8000352c:	100006b7          	lui	a3,0x10000
    80003530:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003534:	02077713          	andi	a4,a4,32
    80003538:	fe070ce3          	beqz	a4,80003530 <uartputc_sync+0x20>
    8000353c:	0ff7f793          	andi	a5,a5,255
    80003540:	00f68023          	sb	a5,0(a3)
    80003544:	00813403          	ld	s0,8(sp)
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret
    80003550:	0000006f          	j	80003550 <uartputc_sync+0x40>

0000000080003554 <uartstart>:
    80003554:	ff010113          	addi	sp,sp,-16
    80003558:	00813423          	sd	s0,8(sp)
    8000355c:	01010413          	addi	s0,sp,16
    80003560:	00002617          	auipc	a2,0x2
    80003564:	2d060613          	addi	a2,a2,720 # 80005830 <uart_tx_r>
    80003568:	00002517          	auipc	a0,0x2
    8000356c:	2d050513          	addi	a0,a0,720 # 80005838 <uart_tx_w>
    80003570:	00063783          	ld	a5,0(a2)
    80003574:	00053703          	ld	a4,0(a0)
    80003578:	04f70263          	beq	a4,a5,800035bc <uartstart+0x68>
    8000357c:	100005b7          	lui	a1,0x10000
    80003580:	00003817          	auipc	a6,0x3
    80003584:	54080813          	addi	a6,a6,1344 # 80006ac0 <uart_tx_buf>
    80003588:	01c0006f          	j	800035a4 <uartstart+0x50>
    8000358c:	0006c703          	lbu	a4,0(a3)
    80003590:	00f63023          	sd	a5,0(a2)
    80003594:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003598:	00063783          	ld	a5,0(a2)
    8000359c:	00053703          	ld	a4,0(a0)
    800035a0:	00f70e63          	beq	a4,a5,800035bc <uartstart+0x68>
    800035a4:	01f7f713          	andi	a4,a5,31
    800035a8:	00e806b3          	add	a3,a6,a4
    800035ac:	0055c703          	lbu	a4,5(a1)
    800035b0:	00178793          	addi	a5,a5,1
    800035b4:	02077713          	andi	a4,a4,32
    800035b8:	fc071ae3          	bnez	a4,8000358c <uartstart+0x38>
    800035bc:	00813403          	ld	s0,8(sp)
    800035c0:	01010113          	addi	sp,sp,16
    800035c4:	00008067          	ret

00000000800035c8 <uartgetc>:
    800035c8:	ff010113          	addi	sp,sp,-16
    800035cc:	00813423          	sd	s0,8(sp)
    800035d0:	01010413          	addi	s0,sp,16
    800035d4:	10000737          	lui	a4,0x10000
    800035d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800035dc:	0017f793          	andi	a5,a5,1
    800035e0:	00078c63          	beqz	a5,800035f8 <uartgetc+0x30>
    800035e4:	00074503          	lbu	a0,0(a4)
    800035e8:	0ff57513          	andi	a0,a0,255
    800035ec:	00813403          	ld	s0,8(sp)
    800035f0:	01010113          	addi	sp,sp,16
    800035f4:	00008067          	ret
    800035f8:	fff00513          	li	a0,-1
    800035fc:	ff1ff06f          	j	800035ec <uartgetc+0x24>

0000000080003600 <uartintr>:
    80003600:	100007b7          	lui	a5,0x10000
    80003604:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003608:	0017f793          	andi	a5,a5,1
    8000360c:	0a078463          	beqz	a5,800036b4 <uartintr+0xb4>
    80003610:	fe010113          	addi	sp,sp,-32
    80003614:	00813823          	sd	s0,16(sp)
    80003618:	00913423          	sd	s1,8(sp)
    8000361c:	00113c23          	sd	ra,24(sp)
    80003620:	02010413          	addi	s0,sp,32
    80003624:	100004b7          	lui	s1,0x10000
    80003628:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000362c:	0ff57513          	andi	a0,a0,255
    80003630:	fffff097          	auipc	ra,0xfffff
    80003634:	534080e7          	jalr	1332(ra) # 80002b64 <consoleintr>
    80003638:	0054c783          	lbu	a5,5(s1)
    8000363c:	0017f793          	andi	a5,a5,1
    80003640:	fe0794e3          	bnez	a5,80003628 <uartintr+0x28>
    80003644:	00002617          	auipc	a2,0x2
    80003648:	1ec60613          	addi	a2,a2,492 # 80005830 <uart_tx_r>
    8000364c:	00002517          	auipc	a0,0x2
    80003650:	1ec50513          	addi	a0,a0,492 # 80005838 <uart_tx_w>
    80003654:	00063783          	ld	a5,0(a2)
    80003658:	00053703          	ld	a4,0(a0)
    8000365c:	04f70263          	beq	a4,a5,800036a0 <uartintr+0xa0>
    80003660:	100005b7          	lui	a1,0x10000
    80003664:	00003817          	auipc	a6,0x3
    80003668:	45c80813          	addi	a6,a6,1116 # 80006ac0 <uart_tx_buf>
    8000366c:	01c0006f          	j	80003688 <uartintr+0x88>
    80003670:	0006c703          	lbu	a4,0(a3)
    80003674:	00f63023          	sd	a5,0(a2)
    80003678:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000367c:	00063783          	ld	a5,0(a2)
    80003680:	00053703          	ld	a4,0(a0)
    80003684:	00f70e63          	beq	a4,a5,800036a0 <uartintr+0xa0>
    80003688:	01f7f713          	andi	a4,a5,31
    8000368c:	00e806b3          	add	a3,a6,a4
    80003690:	0055c703          	lbu	a4,5(a1)
    80003694:	00178793          	addi	a5,a5,1
    80003698:	02077713          	andi	a4,a4,32
    8000369c:	fc071ae3          	bnez	a4,80003670 <uartintr+0x70>
    800036a0:	01813083          	ld	ra,24(sp)
    800036a4:	01013403          	ld	s0,16(sp)
    800036a8:	00813483          	ld	s1,8(sp)
    800036ac:	02010113          	addi	sp,sp,32
    800036b0:	00008067          	ret
    800036b4:	00002617          	auipc	a2,0x2
    800036b8:	17c60613          	addi	a2,a2,380 # 80005830 <uart_tx_r>
    800036bc:	00002517          	auipc	a0,0x2
    800036c0:	17c50513          	addi	a0,a0,380 # 80005838 <uart_tx_w>
    800036c4:	00063783          	ld	a5,0(a2)
    800036c8:	00053703          	ld	a4,0(a0)
    800036cc:	04f70263          	beq	a4,a5,80003710 <uartintr+0x110>
    800036d0:	100005b7          	lui	a1,0x10000
    800036d4:	00003817          	auipc	a6,0x3
    800036d8:	3ec80813          	addi	a6,a6,1004 # 80006ac0 <uart_tx_buf>
    800036dc:	01c0006f          	j	800036f8 <uartintr+0xf8>
    800036e0:	0006c703          	lbu	a4,0(a3)
    800036e4:	00f63023          	sd	a5,0(a2)
    800036e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800036ec:	00063783          	ld	a5,0(a2)
    800036f0:	00053703          	ld	a4,0(a0)
    800036f4:	02f70063          	beq	a4,a5,80003714 <uartintr+0x114>
    800036f8:	01f7f713          	andi	a4,a5,31
    800036fc:	00e806b3          	add	a3,a6,a4
    80003700:	0055c703          	lbu	a4,5(a1)
    80003704:	00178793          	addi	a5,a5,1
    80003708:	02077713          	andi	a4,a4,32
    8000370c:	fc071ae3          	bnez	a4,800036e0 <uartintr+0xe0>
    80003710:	00008067          	ret
    80003714:	00008067          	ret

0000000080003718 <kinit>:
    80003718:	fc010113          	addi	sp,sp,-64
    8000371c:	02913423          	sd	s1,40(sp)
    80003720:	fffff7b7          	lui	a5,0xfffff
    80003724:	00004497          	auipc	s1,0x4
    80003728:	3bb48493          	addi	s1,s1,955 # 80007adf <end+0xfff>
    8000372c:	02813823          	sd	s0,48(sp)
    80003730:	01313c23          	sd	s3,24(sp)
    80003734:	00f4f4b3          	and	s1,s1,a5
    80003738:	02113c23          	sd	ra,56(sp)
    8000373c:	03213023          	sd	s2,32(sp)
    80003740:	01413823          	sd	s4,16(sp)
    80003744:	01513423          	sd	s5,8(sp)
    80003748:	04010413          	addi	s0,sp,64
    8000374c:	000017b7          	lui	a5,0x1
    80003750:	01100993          	li	s3,17
    80003754:	00f487b3          	add	a5,s1,a5
    80003758:	01b99993          	slli	s3,s3,0x1b
    8000375c:	06f9e063          	bltu	s3,a5,800037bc <kinit+0xa4>
    80003760:	00003a97          	auipc	s5,0x3
    80003764:	380a8a93          	addi	s5,s5,896 # 80006ae0 <end>
    80003768:	0754ec63          	bltu	s1,s5,800037e0 <kinit+0xc8>
    8000376c:	0734fa63          	bgeu	s1,s3,800037e0 <kinit+0xc8>
    80003770:	00088a37          	lui	s4,0x88
    80003774:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003778:	00002917          	auipc	s2,0x2
    8000377c:	0c890913          	addi	s2,s2,200 # 80005840 <kmem>
    80003780:	00ca1a13          	slli	s4,s4,0xc
    80003784:	0140006f          	j	80003798 <kinit+0x80>
    80003788:	000017b7          	lui	a5,0x1
    8000378c:	00f484b3          	add	s1,s1,a5
    80003790:	0554e863          	bltu	s1,s5,800037e0 <kinit+0xc8>
    80003794:	0534f663          	bgeu	s1,s3,800037e0 <kinit+0xc8>
    80003798:	00001637          	lui	a2,0x1
    8000379c:	00100593          	li	a1,1
    800037a0:	00048513          	mv	a0,s1
    800037a4:	00000097          	auipc	ra,0x0
    800037a8:	5e4080e7          	jalr	1508(ra) # 80003d88 <__memset>
    800037ac:	00093783          	ld	a5,0(s2)
    800037b0:	00f4b023          	sd	a5,0(s1)
    800037b4:	00993023          	sd	s1,0(s2)
    800037b8:	fd4498e3          	bne	s1,s4,80003788 <kinit+0x70>
    800037bc:	03813083          	ld	ra,56(sp)
    800037c0:	03013403          	ld	s0,48(sp)
    800037c4:	02813483          	ld	s1,40(sp)
    800037c8:	02013903          	ld	s2,32(sp)
    800037cc:	01813983          	ld	s3,24(sp)
    800037d0:	01013a03          	ld	s4,16(sp)
    800037d4:	00813a83          	ld	s5,8(sp)
    800037d8:	04010113          	addi	sp,sp,64
    800037dc:	00008067          	ret
    800037e0:	00002517          	auipc	a0,0x2
    800037e4:	a3050513          	addi	a0,a0,-1488 # 80005210 <digits+0x18>
    800037e8:	fffff097          	auipc	ra,0xfffff
    800037ec:	4b4080e7          	jalr	1204(ra) # 80002c9c <panic>

00000000800037f0 <freerange>:
    800037f0:	fc010113          	addi	sp,sp,-64
    800037f4:	000017b7          	lui	a5,0x1
    800037f8:	02913423          	sd	s1,40(sp)
    800037fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003800:	009504b3          	add	s1,a0,s1
    80003804:	fffff537          	lui	a0,0xfffff
    80003808:	02813823          	sd	s0,48(sp)
    8000380c:	02113c23          	sd	ra,56(sp)
    80003810:	03213023          	sd	s2,32(sp)
    80003814:	01313c23          	sd	s3,24(sp)
    80003818:	01413823          	sd	s4,16(sp)
    8000381c:	01513423          	sd	s5,8(sp)
    80003820:	01613023          	sd	s6,0(sp)
    80003824:	04010413          	addi	s0,sp,64
    80003828:	00a4f4b3          	and	s1,s1,a0
    8000382c:	00f487b3          	add	a5,s1,a5
    80003830:	06f5e463          	bltu	a1,a5,80003898 <freerange+0xa8>
    80003834:	00003a97          	auipc	s5,0x3
    80003838:	2aca8a93          	addi	s5,s5,684 # 80006ae0 <end>
    8000383c:	0954e263          	bltu	s1,s5,800038c0 <freerange+0xd0>
    80003840:	01100993          	li	s3,17
    80003844:	01b99993          	slli	s3,s3,0x1b
    80003848:	0734fc63          	bgeu	s1,s3,800038c0 <freerange+0xd0>
    8000384c:	00058a13          	mv	s4,a1
    80003850:	00002917          	auipc	s2,0x2
    80003854:	ff090913          	addi	s2,s2,-16 # 80005840 <kmem>
    80003858:	00002b37          	lui	s6,0x2
    8000385c:	0140006f          	j	80003870 <freerange+0x80>
    80003860:	000017b7          	lui	a5,0x1
    80003864:	00f484b3          	add	s1,s1,a5
    80003868:	0554ec63          	bltu	s1,s5,800038c0 <freerange+0xd0>
    8000386c:	0534fa63          	bgeu	s1,s3,800038c0 <freerange+0xd0>
    80003870:	00001637          	lui	a2,0x1
    80003874:	00100593          	li	a1,1
    80003878:	00048513          	mv	a0,s1
    8000387c:	00000097          	auipc	ra,0x0
    80003880:	50c080e7          	jalr	1292(ra) # 80003d88 <__memset>
    80003884:	00093703          	ld	a4,0(s2)
    80003888:	016487b3          	add	a5,s1,s6
    8000388c:	00e4b023          	sd	a4,0(s1)
    80003890:	00993023          	sd	s1,0(s2)
    80003894:	fcfa76e3          	bgeu	s4,a5,80003860 <freerange+0x70>
    80003898:	03813083          	ld	ra,56(sp)
    8000389c:	03013403          	ld	s0,48(sp)
    800038a0:	02813483          	ld	s1,40(sp)
    800038a4:	02013903          	ld	s2,32(sp)
    800038a8:	01813983          	ld	s3,24(sp)
    800038ac:	01013a03          	ld	s4,16(sp)
    800038b0:	00813a83          	ld	s5,8(sp)
    800038b4:	00013b03          	ld	s6,0(sp)
    800038b8:	04010113          	addi	sp,sp,64
    800038bc:	00008067          	ret
    800038c0:	00002517          	auipc	a0,0x2
    800038c4:	95050513          	addi	a0,a0,-1712 # 80005210 <digits+0x18>
    800038c8:	fffff097          	auipc	ra,0xfffff
    800038cc:	3d4080e7          	jalr	980(ra) # 80002c9c <panic>

00000000800038d0 <kfree>:
    800038d0:	fe010113          	addi	sp,sp,-32
    800038d4:	00813823          	sd	s0,16(sp)
    800038d8:	00113c23          	sd	ra,24(sp)
    800038dc:	00913423          	sd	s1,8(sp)
    800038e0:	02010413          	addi	s0,sp,32
    800038e4:	03451793          	slli	a5,a0,0x34
    800038e8:	04079c63          	bnez	a5,80003940 <kfree+0x70>
    800038ec:	00003797          	auipc	a5,0x3
    800038f0:	1f478793          	addi	a5,a5,500 # 80006ae0 <end>
    800038f4:	00050493          	mv	s1,a0
    800038f8:	04f56463          	bltu	a0,a5,80003940 <kfree+0x70>
    800038fc:	01100793          	li	a5,17
    80003900:	01b79793          	slli	a5,a5,0x1b
    80003904:	02f57e63          	bgeu	a0,a5,80003940 <kfree+0x70>
    80003908:	00001637          	lui	a2,0x1
    8000390c:	00100593          	li	a1,1
    80003910:	00000097          	auipc	ra,0x0
    80003914:	478080e7          	jalr	1144(ra) # 80003d88 <__memset>
    80003918:	00002797          	auipc	a5,0x2
    8000391c:	f2878793          	addi	a5,a5,-216 # 80005840 <kmem>
    80003920:	0007b703          	ld	a4,0(a5)
    80003924:	01813083          	ld	ra,24(sp)
    80003928:	01013403          	ld	s0,16(sp)
    8000392c:	00e4b023          	sd	a4,0(s1)
    80003930:	0097b023          	sd	s1,0(a5)
    80003934:	00813483          	ld	s1,8(sp)
    80003938:	02010113          	addi	sp,sp,32
    8000393c:	00008067          	ret
    80003940:	00002517          	auipc	a0,0x2
    80003944:	8d050513          	addi	a0,a0,-1840 # 80005210 <digits+0x18>
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	354080e7          	jalr	852(ra) # 80002c9c <panic>

0000000080003950 <kalloc>:
    80003950:	fe010113          	addi	sp,sp,-32
    80003954:	00813823          	sd	s0,16(sp)
    80003958:	00913423          	sd	s1,8(sp)
    8000395c:	00113c23          	sd	ra,24(sp)
    80003960:	02010413          	addi	s0,sp,32
    80003964:	00002797          	auipc	a5,0x2
    80003968:	edc78793          	addi	a5,a5,-292 # 80005840 <kmem>
    8000396c:	0007b483          	ld	s1,0(a5)
    80003970:	02048063          	beqz	s1,80003990 <kalloc+0x40>
    80003974:	0004b703          	ld	a4,0(s1)
    80003978:	00001637          	lui	a2,0x1
    8000397c:	00500593          	li	a1,5
    80003980:	00048513          	mv	a0,s1
    80003984:	00e7b023          	sd	a4,0(a5)
    80003988:	00000097          	auipc	ra,0x0
    8000398c:	400080e7          	jalr	1024(ra) # 80003d88 <__memset>
    80003990:	01813083          	ld	ra,24(sp)
    80003994:	01013403          	ld	s0,16(sp)
    80003998:	00048513          	mv	a0,s1
    8000399c:	00813483          	ld	s1,8(sp)
    800039a0:	02010113          	addi	sp,sp,32
    800039a4:	00008067          	ret

00000000800039a8 <initlock>:
    800039a8:	ff010113          	addi	sp,sp,-16
    800039ac:	00813423          	sd	s0,8(sp)
    800039b0:	01010413          	addi	s0,sp,16
    800039b4:	00813403          	ld	s0,8(sp)
    800039b8:	00b53423          	sd	a1,8(a0)
    800039bc:	00052023          	sw	zero,0(a0)
    800039c0:	00053823          	sd	zero,16(a0)
    800039c4:	01010113          	addi	sp,sp,16
    800039c8:	00008067          	ret

00000000800039cc <acquire>:
    800039cc:	fe010113          	addi	sp,sp,-32
    800039d0:	00813823          	sd	s0,16(sp)
    800039d4:	00913423          	sd	s1,8(sp)
    800039d8:	00113c23          	sd	ra,24(sp)
    800039dc:	01213023          	sd	s2,0(sp)
    800039e0:	02010413          	addi	s0,sp,32
    800039e4:	00050493          	mv	s1,a0
    800039e8:	10002973          	csrr	s2,sstatus
    800039ec:	100027f3          	csrr	a5,sstatus
    800039f0:	ffd7f793          	andi	a5,a5,-3
    800039f4:	10079073          	csrw	sstatus,a5
    800039f8:	fffff097          	auipc	ra,0xfffff
    800039fc:	8ec080e7          	jalr	-1812(ra) # 800022e4 <mycpu>
    80003a00:	07852783          	lw	a5,120(a0)
    80003a04:	06078e63          	beqz	a5,80003a80 <acquire+0xb4>
    80003a08:	fffff097          	auipc	ra,0xfffff
    80003a0c:	8dc080e7          	jalr	-1828(ra) # 800022e4 <mycpu>
    80003a10:	07852783          	lw	a5,120(a0)
    80003a14:	0004a703          	lw	a4,0(s1)
    80003a18:	0017879b          	addiw	a5,a5,1
    80003a1c:	06f52c23          	sw	a5,120(a0)
    80003a20:	04071063          	bnez	a4,80003a60 <acquire+0x94>
    80003a24:	00100713          	li	a4,1
    80003a28:	00070793          	mv	a5,a4
    80003a2c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003a30:	0007879b          	sext.w	a5,a5
    80003a34:	fe079ae3          	bnez	a5,80003a28 <acquire+0x5c>
    80003a38:	0ff0000f          	fence
    80003a3c:	fffff097          	auipc	ra,0xfffff
    80003a40:	8a8080e7          	jalr	-1880(ra) # 800022e4 <mycpu>
    80003a44:	01813083          	ld	ra,24(sp)
    80003a48:	01013403          	ld	s0,16(sp)
    80003a4c:	00a4b823          	sd	a0,16(s1)
    80003a50:	00013903          	ld	s2,0(sp)
    80003a54:	00813483          	ld	s1,8(sp)
    80003a58:	02010113          	addi	sp,sp,32
    80003a5c:	00008067          	ret
    80003a60:	0104b903          	ld	s2,16(s1)
    80003a64:	fffff097          	auipc	ra,0xfffff
    80003a68:	880080e7          	jalr	-1920(ra) # 800022e4 <mycpu>
    80003a6c:	faa91ce3          	bne	s2,a0,80003a24 <acquire+0x58>
    80003a70:	00001517          	auipc	a0,0x1
    80003a74:	7a850513          	addi	a0,a0,1960 # 80005218 <digits+0x20>
    80003a78:	fffff097          	auipc	ra,0xfffff
    80003a7c:	224080e7          	jalr	548(ra) # 80002c9c <panic>
    80003a80:	00195913          	srli	s2,s2,0x1
    80003a84:	fffff097          	auipc	ra,0xfffff
    80003a88:	860080e7          	jalr	-1952(ra) # 800022e4 <mycpu>
    80003a8c:	00197913          	andi	s2,s2,1
    80003a90:	07252e23          	sw	s2,124(a0)
    80003a94:	f75ff06f          	j	80003a08 <acquire+0x3c>

0000000080003a98 <release>:
    80003a98:	fe010113          	addi	sp,sp,-32
    80003a9c:	00813823          	sd	s0,16(sp)
    80003aa0:	00113c23          	sd	ra,24(sp)
    80003aa4:	00913423          	sd	s1,8(sp)
    80003aa8:	01213023          	sd	s2,0(sp)
    80003aac:	02010413          	addi	s0,sp,32
    80003ab0:	00052783          	lw	a5,0(a0)
    80003ab4:	00079a63          	bnez	a5,80003ac8 <release+0x30>
    80003ab8:	00001517          	auipc	a0,0x1
    80003abc:	76850513          	addi	a0,a0,1896 # 80005220 <digits+0x28>
    80003ac0:	fffff097          	auipc	ra,0xfffff
    80003ac4:	1dc080e7          	jalr	476(ra) # 80002c9c <panic>
    80003ac8:	01053903          	ld	s2,16(a0)
    80003acc:	00050493          	mv	s1,a0
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	814080e7          	jalr	-2028(ra) # 800022e4 <mycpu>
    80003ad8:	fea910e3          	bne	s2,a0,80003ab8 <release+0x20>
    80003adc:	0004b823          	sd	zero,16(s1)
    80003ae0:	0ff0000f          	fence
    80003ae4:	0f50000f          	fence	iorw,ow
    80003ae8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003aec:	ffffe097          	auipc	ra,0xffffe
    80003af0:	7f8080e7          	jalr	2040(ra) # 800022e4 <mycpu>
    80003af4:	100027f3          	csrr	a5,sstatus
    80003af8:	0027f793          	andi	a5,a5,2
    80003afc:	04079a63          	bnez	a5,80003b50 <release+0xb8>
    80003b00:	07852783          	lw	a5,120(a0)
    80003b04:	02f05e63          	blez	a5,80003b40 <release+0xa8>
    80003b08:	fff7871b          	addiw	a4,a5,-1
    80003b0c:	06e52c23          	sw	a4,120(a0)
    80003b10:	00071c63          	bnez	a4,80003b28 <release+0x90>
    80003b14:	07c52783          	lw	a5,124(a0)
    80003b18:	00078863          	beqz	a5,80003b28 <release+0x90>
    80003b1c:	100027f3          	csrr	a5,sstatus
    80003b20:	0027e793          	ori	a5,a5,2
    80003b24:	10079073          	csrw	sstatus,a5
    80003b28:	01813083          	ld	ra,24(sp)
    80003b2c:	01013403          	ld	s0,16(sp)
    80003b30:	00813483          	ld	s1,8(sp)
    80003b34:	00013903          	ld	s2,0(sp)
    80003b38:	02010113          	addi	sp,sp,32
    80003b3c:	00008067          	ret
    80003b40:	00001517          	auipc	a0,0x1
    80003b44:	70050513          	addi	a0,a0,1792 # 80005240 <digits+0x48>
    80003b48:	fffff097          	auipc	ra,0xfffff
    80003b4c:	154080e7          	jalr	340(ra) # 80002c9c <panic>
    80003b50:	00001517          	auipc	a0,0x1
    80003b54:	6d850513          	addi	a0,a0,1752 # 80005228 <digits+0x30>
    80003b58:	fffff097          	auipc	ra,0xfffff
    80003b5c:	144080e7          	jalr	324(ra) # 80002c9c <panic>

0000000080003b60 <holding>:
    80003b60:	00052783          	lw	a5,0(a0)
    80003b64:	00079663          	bnez	a5,80003b70 <holding+0x10>
    80003b68:	00000513          	li	a0,0
    80003b6c:	00008067          	ret
    80003b70:	fe010113          	addi	sp,sp,-32
    80003b74:	00813823          	sd	s0,16(sp)
    80003b78:	00913423          	sd	s1,8(sp)
    80003b7c:	00113c23          	sd	ra,24(sp)
    80003b80:	02010413          	addi	s0,sp,32
    80003b84:	01053483          	ld	s1,16(a0)
    80003b88:	ffffe097          	auipc	ra,0xffffe
    80003b8c:	75c080e7          	jalr	1884(ra) # 800022e4 <mycpu>
    80003b90:	01813083          	ld	ra,24(sp)
    80003b94:	01013403          	ld	s0,16(sp)
    80003b98:	40a48533          	sub	a0,s1,a0
    80003b9c:	00153513          	seqz	a0,a0
    80003ba0:	00813483          	ld	s1,8(sp)
    80003ba4:	02010113          	addi	sp,sp,32
    80003ba8:	00008067          	ret

0000000080003bac <push_off>:
    80003bac:	fe010113          	addi	sp,sp,-32
    80003bb0:	00813823          	sd	s0,16(sp)
    80003bb4:	00113c23          	sd	ra,24(sp)
    80003bb8:	00913423          	sd	s1,8(sp)
    80003bbc:	02010413          	addi	s0,sp,32
    80003bc0:	100024f3          	csrr	s1,sstatus
    80003bc4:	100027f3          	csrr	a5,sstatus
    80003bc8:	ffd7f793          	andi	a5,a5,-3
    80003bcc:	10079073          	csrw	sstatus,a5
    80003bd0:	ffffe097          	auipc	ra,0xffffe
    80003bd4:	714080e7          	jalr	1812(ra) # 800022e4 <mycpu>
    80003bd8:	07852783          	lw	a5,120(a0)
    80003bdc:	02078663          	beqz	a5,80003c08 <push_off+0x5c>
    80003be0:	ffffe097          	auipc	ra,0xffffe
    80003be4:	704080e7          	jalr	1796(ra) # 800022e4 <mycpu>
    80003be8:	07852783          	lw	a5,120(a0)
    80003bec:	01813083          	ld	ra,24(sp)
    80003bf0:	01013403          	ld	s0,16(sp)
    80003bf4:	0017879b          	addiw	a5,a5,1
    80003bf8:	06f52c23          	sw	a5,120(a0)
    80003bfc:	00813483          	ld	s1,8(sp)
    80003c00:	02010113          	addi	sp,sp,32
    80003c04:	00008067          	ret
    80003c08:	0014d493          	srli	s1,s1,0x1
    80003c0c:	ffffe097          	auipc	ra,0xffffe
    80003c10:	6d8080e7          	jalr	1752(ra) # 800022e4 <mycpu>
    80003c14:	0014f493          	andi	s1,s1,1
    80003c18:	06952e23          	sw	s1,124(a0)
    80003c1c:	fc5ff06f          	j	80003be0 <push_off+0x34>

0000000080003c20 <pop_off>:
    80003c20:	ff010113          	addi	sp,sp,-16
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	00113423          	sd	ra,8(sp)
    80003c2c:	01010413          	addi	s0,sp,16
    80003c30:	ffffe097          	auipc	ra,0xffffe
    80003c34:	6b4080e7          	jalr	1716(ra) # 800022e4 <mycpu>
    80003c38:	100027f3          	csrr	a5,sstatus
    80003c3c:	0027f793          	andi	a5,a5,2
    80003c40:	04079663          	bnez	a5,80003c8c <pop_off+0x6c>
    80003c44:	07852783          	lw	a5,120(a0)
    80003c48:	02f05a63          	blez	a5,80003c7c <pop_off+0x5c>
    80003c4c:	fff7871b          	addiw	a4,a5,-1
    80003c50:	06e52c23          	sw	a4,120(a0)
    80003c54:	00071c63          	bnez	a4,80003c6c <pop_off+0x4c>
    80003c58:	07c52783          	lw	a5,124(a0)
    80003c5c:	00078863          	beqz	a5,80003c6c <pop_off+0x4c>
    80003c60:	100027f3          	csrr	a5,sstatus
    80003c64:	0027e793          	ori	a5,a5,2
    80003c68:	10079073          	csrw	sstatus,a5
    80003c6c:	00813083          	ld	ra,8(sp)
    80003c70:	00013403          	ld	s0,0(sp)
    80003c74:	01010113          	addi	sp,sp,16
    80003c78:	00008067          	ret
    80003c7c:	00001517          	auipc	a0,0x1
    80003c80:	5c450513          	addi	a0,a0,1476 # 80005240 <digits+0x48>
    80003c84:	fffff097          	auipc	ra,0xfffff
    80003c88:	018080e7          	jalr	24(ra) # 80002c9c <panic>
    80003c8c:	00001517          	auipc	a0,0x1
    80003c90:	59c50513          	addi	a0,a0,1436 # 80005228 <digits+0x30>
    80003c94:	fffff097          	auipc	ra,0xfffff
    80003c98:	008080e7          	jalr	8(ra) # 80002c9c <panic>

0000000080003c9c <push_on>:
    80003c9c:	fe010113          	addi	sp,sp,-32
    80003ca0:	00813823          	sd	s0,16(sp)
    80003ca4:	00113c23          	sd	ra,24(sp)
    80003ca8:	00913423          	sd	s1,8(sp)
    80003cac:	02010413          	addi	s0,sp,32
    80003cb0:	100024f3          	csrr	s1,sstatus
    80003cb4:	100027f3          	csrr	a5,sstatus
    80003cb8:	0027e793          	ori	a5,a5,2
    80003cbc:	10079073          	csrw	sstatus,a5
    80003cc0:	ffffe097          	auipc	ra,0xffffe
    80003cc4:	624080e7          	jalr	1572(ra) # 800022e4 <mycpu>
    80003cc8:	07852783          	lw	a5,120(a0)
    80003ccc:	02078663          	beqz	a5,80003cf8 <push_on+0x5c>
    80003cd0:	ffffe097          	auipc	ra,0xffffe
    80003cd4:	614080e7          	jalr	1556(ra) # 800022e4 <mycpu>
    80003cd8:	07852783          	lw	a5,120(a0)
    80003cdc:	01813083          	ld	ra,24(sp)
    80003ce0:	01013403          	ld	s0,16(sp)
    80003ce4:	0017879b          	addiw	a5,a5,1
    80003ce8:	06f52c23          	sw	a5,120(a0)
    80003cec:	00813483          	ld	s1,8(sp)
    80003cf0:	02010113          	addi	sp,sp,32
    80003cf4:	00008067          	ret
    80003cf8:	0014d493          	srli	s1,s1,0x1
    80003cfc:	ffffe097          	auipc	ra,0xffffe
    80003d00:	5e8080e7          	jalr	1512(ra) # 800022e4 <mycpu>
    80003d04:	0014f493          	andi	s1,s1,1
    80003d08:	06952e23          	sw	s1,124(a0)
    80003d0c:	fc5ff06f          	j	80003cd0 <push_on+0x34>

0000000080003d10 <pop_on>:
    80003d10:	ff010113          	addi	sp,sp,-16
    80003d14:	00813023          	sd	s0,0(sp)
    80003d18:	00113423          	sd	ra,8(sp)
    80003d1c:	01010413          	addi	s0,sp,16
    80003d20:	ffffe097          	auipc	ra,0xffffe
    80003d24:	5c4080e7          	jalr	1476(ra) # 800022e4 <mycpu>
    80003d28:	100027f3          	csrr	a5,sstatus
    80003d2c:	0027f793          	andi	a5,a5,2
    80003d30:	04078463          	beqz	a5,80003d78 <pop_on+0x68>
    80003d34:	07852783          	lw	a5,120(a0)
    80003d38:	02f05863          	blez	a5,80003d68 <pop_on+0x58>
    80003d3c:	fff7879b          	addiw	a5,a5,-1
    80003d40:	06f52c23          	sw	a5,120(a0)
    80003d44:	07853783          	ld	a5,120(a0)
    80003d48:	00079863          	bnez	a5,80003d58 <pop_on+0x48>
    80003d4c:	100027f3          	csrr	a5,sstatus
    80003d50:	ffd7f793          	andi	a5,a5,-3
    80003d54:	10079073          	csrw	sstatus,a5
    80003d58:	00813083          	ld	ra,8(sp)
    80003d5c:	00013403          	ld	s0,0(sp)
    80003d60:	01010113          	addi	sp,sp,16
    80003d64:	00008067          	ret
    80003d68:	00001517          	auipc	a0,0x1
    80003d6c:	50050513          	addi	a0,a0,1280 # 80005268 <digits+0x70>
    80003d70:	fffff097          	auipc	ra,0xfffff
    80003d74:	f2c080e7          	jalr	-212(ra) # 80002c9c <panic>
    80003d78:	00001517          	auipc	a0,0x1
    80003d7c:	4d050513          	addi	a0,a0,1232 # 80005248 <digits+0x50>
    80003d80:	fffff097          	auipc	ra,0xfffff
    80003d84:	f1c080e7          	jalr	-228(ra) # 80002c9c <panic>

0000000080003d88 <__memset>:
    80003d88:	ff010113          	addi	sp,sp,-16
    80003d8c:	00813423          	sd	s0,8(sp)
    80003d90:	01010413          	addi	s0,sp,16
    80003d94:	1a060e63          	beqz	a2,80003f50 <__memset+0x1c8>
    80003d98:	40a007b3          	neg	a5,a0
    80003d9c:	0077f793          	andi	a5,a5,7
    80003da0:	00778693          	addi	a3,a5,7
    80003da4:	00b00813          	li	a6,11
    80003da8:	0ff5f593          	andi	a1,a1,255
    80003dac:	fff6071b          	addiw	a4,a2,-1
    80003db0:	1b06e663          	bltu	a3,a6,80003f5c <__memset+0x1d4>
    80003db4:	1cd76463          	bltu	a4,a3,80003f7c <__memset+0x1f4>
    80003db8:	1a078e63          	beqz	a5,80003f74 <__memset+0x1ec>
    80003dbc:	00b50023          	sb	a1,0(a0)
    80003dc0:	00100713          	li	a4,1
    80003dc4:	1ae78463          	beq	a5,a4,80003f6c <__memset+0x1e4>
    80003dc8:	00b500a3          	sb	a1,1(a0)
    80003dcc:	00200713          	li	a4,2
    80003dd0:	1ae78a63          	beq	a5,a4,80003f84 <__memset+0x1fc>
    80003dd4:	00b50123          	sb	a1,2(a0)
    80003dd8:	00300713          	li	a4,3
    80003ddc:	18e78463          	beq	a5,a4,80003f64 <__memset+0x1dc>
    80003de0:	00b501a3          	sb	a1,3(a0)
    80003de4:	00400713          	li	a4,4
    80003de8:	1ae78263          	beq	a5,a4,80003f8c <__memset+0x204>
    80003dec:	00b50223          	sb	a1,4(a0)
    80003df0:	00500713          	li	a4,5
    80003df4:	1ae78063          	beq	a5,a4,80003f94 <__memset+0x20c>
    80003df8:	00b502a3          	sb	a1,5(a0)
    80003dfc:	00700713          	li	a4,7
    80003e00:	18e79e63          	bne	a5,a4,80003f9c <__memset+0x214>
    80003e04:	00b50323          	sb	a1,6(a0)
    80003e08:	00700e93          	li	t4,7
    80003e0c:	00859713          	slli	a4,a1,0x8
    80003e10:	00e5e733          	or	a4,a1,a4
    80003e14:	01059e13          	slli	t3,a1,0x10
    80003e18:	01c76e33          	or	t3,a4,t3
    80003e1c:	01859313          	slli	t1,a1,0x18
    80003e20:	006e6333          	or	t1,t3,t1
    80003e24:	02059893          	slli	a7,a1,0x20
    80003e28:	40f60e3b          	subw	t3,a2,a5
    80003e2c:	011368b3          	or	a7,t1,a7
    80003e30:	02859813          	slli	a6,a1,0x28
    80003e34:	0108e833          	or	a6,a7,a6
    80003e38:	03059693          	slli	a3,a1,0x30
    80003e3c:	003e589b          	srliw	a7,t3,0x3
    80003e40:	00d866b3          	or	a3,a6,a3
    80003e44:	03859713          	slli	a4,a1,0x38
    80003e48:	00389813          	slli	a6,a7,0x3
    80003e4c:	00f507b3          	add	a5,a0,a5
    80003e50:	00e6e733          	or	a4,a3,a4
    80003e54:	000e089b          	sext.w	a7,t3
    80003e58:	00f806b3          	add	a3,a6,a5
    80003e5c:	00e7b023          	sd	a4,0(a5)
    80003e60:	00878793          	addi	a5,a5,8
    80003e64:	fed79ce3          	bne	a5,a3,80003e5c <__memset+0xd4>
    80003e68:	ff8e7793          	andi	a5,t3,-8
    80003e6c:	0007871b          	sext.w	a4,a5
    80003e70:	01d787bb          	addw	a5,a5,t4
    80003e74:	0ce88e63          	beq	a7,a4,80003f50 <__memset+0x1c8>
    80003e78:	00f50733          	add	a4,a0,a5
    80003e7c:	00b70023          	sb	a1,0(a4)
    80003e80:	0017871b          	addiw	a4,a5,1
    80003e84:	0cc77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003e88:	00e50733          	add	a4,a0,a4
    80003e8c:	00b70023          	sb	a1,0(a4)
    80003e90:	0027871b          	addiw	a4,a5,2
    80003e94:	0ac77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003e98:	00e50733          	add	a4,a0,a4
    80003e9c:	00b70023          	sb	a1,0(a4)
    80003ea0:	0037871b          	addiw	a4,a5,3
    80003ea4:	0ac77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003ea8:	00e50733          	add	a4,a0,a4
    80003eac:	00b70023          	sb	a1,0(a4)
    80003eb0:	0047871b          	addiw	a4,a5,4
    80003eb4:	08c77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003eb8:	00e50733          	add	a4,a0,a4
    80003ebc:	00b70023          	sb	a1,0(a4)
    80003ec0:	0057871b          	addiw	a4,a5,5
    80003ec4:	08c77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003ec8:	00e50733          	add	a4,a0,a4
    80003ecc:	00b70023          	sb	a1,0(a4)
    80003ed0:	0067871b          	addiw	a4,a5,6
    80003ed4:	06c77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003ed8:	00e50733          	add	a4,a0,a4
    80003edc:	00b70023          	sb	a1,0(a4)
    80003ee0:	0077871b          	addiw	a4,a5,7
    80003ee4:	06c77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003ee8:	00e50733          	add	a4,a0,a4
    80003eec:	00b70023          	sb	a1,0(a4)
    80003ef0:	0087871b          	addiw	a4,a5,8
    80003ef4:	04c77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003ef8:	00e50733          	add	a4,a0,a4
    80003efc:	00b70023          	sb	a1,0(a4)
    80003f00:	0097871b          	addiw	a4,a5,9
    80003f04:	04c77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003f08:	00e50733          	add	a4,a0,a4
    80003f0c:	00b70023          	sb	a1,0(a4)
    80003f10:	00a7871b          	addiw	a4,a5,10
    80003f14:	02c77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003f18:	00e50733          	add	a4,a0,a4
    80003f1c:	00b70023          	sb	a1,0(a4)
    80003f20:	00b7871b          	addiw	a4,a5,11
    80003f24:	02c77663          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003f28:	00e50733          	add	a4,a0,a4
    80003f2c:	00b70023          	sb	a1,0(a4)
    80003f30:	00c7871b          	addiw	a4,a5,12
    80003f34:	00c77e63          	bgeu	a4,a2,80003f50 <__memset+0x1c8>
    80003f38:	00e50733          	add	a4,a0,a4
    80003f3c:	00b70023          	sb	a1,0(a4)
    80003f40:	00d7879b          	addiw	a5,a5,13
    80003f44:	00c7f663          	bgeu	a5,a2,80003f50 <__memset+0x1c8>
    80003f48:	00f507b3          	add	a5,a0,a5
    80003f4c:	00b78023          	sb	a1,0(a5)
    80003f50:	00813403          	ld	s0,8(sp)
    80003f54:	01010113          	addi	sp,sp,16
    80003f58:	00008067          	ret
    80003f5c:	00b00693          	li	a3,11
    80003f60:	e55ff06f          	j	80003db4 <__memset+0x2c>
    80003f64:	00300e93          	li	t4,3
    80003f68:	ea5ff06f          	j	80003e0c <__memset+0x84>
    80003f6c:	00100e93          	li	t4,1
    80003f70:	e9dff06f          	j	80003e0c <__memset+0x84>
    80003f74:	00000e93          	li	t4,0
    80003f78:	e95ff06f          	j	80003e0c <__memset+0x84>
    80003f7c:	00000793          	li	a5,0
    80003f80:	ef9ff06f          	j	80003e78 <__memset+0xf0>
    80003f84:	00200e93          	li	t4,2
    80003f88:	e85ff06f          	j	80003e0c <__memset+0x84>
    80003f8c:	00400e93          	li	t4,4
    80003f90:	e7dff06f          	j	80003e0c <__memset+0x84>
    80003f94:	00500e93          	li	t4,5
    80003f98:	e75ff06f          	j	80003e0c <__memset+0x84>
    80003f9c:	00600e93          	li	t4,6
    80003fa0:	e6dff06f          	j	80003e0c <__memset+0x84>

0000000080003fa4 <__memmove>:
    80003fa4:	ff010113          	addi	sp,sp,-16
    80003fa8:	00813423          	sd	s0,8(sp)
    80003fac:	01010413          	addi	s0,sp,16
    80003fb0:	0e060863          	beqz	a2,800040a0 <__memmove+0xfc>
    80003fb4:	fff6069b          	addiw	a3,a2,-1
    80003fb8:	0006881b          	sext.w	a6,a3
    80003fbc:	0ea5e863          	bltu	a1,a0,800040ac <__memmove+0x108>
    80003fc0:	00758713          	addi	a4,a1,7
    80003fc4:	00a5e7b3          	or	a5,a1,a0
    80003fc8:	40a70733          	sub	a4,a4,a0
    80003fcc:	0077f793          	andi	a5,a5,7
    80003fd0:	00f73713          	sltiu	a4,a4,15
    80003fd4:	00174713          	xori	a4,a4,1
    80003fd8:	0017b793          	seqz	a5,a5
    80003fdc:	00e7f7b3          	and	a5,a5,a4
    80003fe0:	10078863          	beqz	a5,800040f0 <__memmove+0x14c>
    80003fe4:	00900793          	li	a5,9
    80003fe8:	1107f463          	bgeu	a5,a6,800040f0 <__memmove+0x14c>
    80003fec:	0036581b          	srliw	a6,a2,0x3
    80003ff0:	fff8081b          	addiw	a6,a6,-1
    80003ff4:	02081813          	slli	a6,a6,0x20
    80003ff8:	01d85893          	srli	a7,a6,0x1d
    80003ffc:	00858813          	addi	a6,a1,8
    80004000:	00058793          	mv	a5,a1
    80004004:	00050713          	mv	a4,a0
    80004008:	01088833          	add	a6,a7,a6
    8000400c:	0007b883          	ld	a7,0(a5)
    80004010:	00878793          	addi	a5,a5,8
    80004014:	00870713          	addi	a4,a4,8
    80004018:	ff173c23          	sd	a7,-8(a4)
    8000401c:	ff0798e3          	bne	a5,a6,8000400c <__memmove+0x68>
    80004020:	ff867713          	andi	a4,a2,-8
    80004024:	02071793          	slli	a5,a4,0x20
    80004028:	0207d793          	srli	a5,a5,0x20
    8000402c:	00f585b3          	add	a1,a1,a5
    80004030:	40e686bb          	subw	a3,a3,a4
    80004034:	00f507b3          	add	a5,a0,a5
    80004038:	06e60463          	beq	a2,a4,800040a0 <__memmove+0xfc>
    8000403c:	0005c703          	lbu	a4,0(a1)
    80004040:	00e78023          	sb	a4,0(a5)
    80004044:	04068e63          	beqz	a3,800040a0 <__memmove+0xfc>
    80004048:	0015c603          	lbu	a2,1(a1)
    8000404c:	00100713          	li	a4,1
    80004050:	00c780a3          	sb	a2,1(a5)
    80004054:	04e68663          	beq	a3,a4,800040a0 <__memmove+0xfc>
    80004058:	0025c603          	lbu	a2,2(a1)
    8000405c:	00200713          	li	a4,2
    80004060:	00c78123          	sb	a2,2(a5)
    80004064:	02e68e63          	beq	a3,a4,800040a0 <__memmove+0xfc>
    80004068:	0035c603          	lbu	a2,3(a1)
    8000406c:	00300713          	li	a4,3
    80004070:	00c781a3          	sb	a2,3(a5)
    80004074:	02e68663          	beq	a3,a4,800040a0 <__memmove+0xfc>
    80004078:	0045c603          	lbu	a2,4(a1)
    8000407c:	00400713          	li	a4,4
    80004080:	00c78223          	sb	a2,4(a5)
    80004084:	00e68e63          	beq	a3,a4,800040a0 <__memmove+0xfc>
    80004088:	0055c603          	lbu	a2,5(a1)
    8000408c:	00500713          	li	a4,5
    80004090:	00c782a3          	sb	a2,5(a5)
    80004094:	00e68663          	beq	a3,a4,800040a0 <__memmove+0xfc>
    80004098:	0065c703          	lbu	a4,6(a1)
    8000409c:	00e78323          	sb	a4,6(a5)
    800040a0:	00813403          	ld	s0,8(sp)
    800040a4:	01010113          	addi	sp,sp,16
    800040a8:	00008067          	ret
    800040ac:	02061713          	slli	a4,a2,0x20
    800040b0:	02075713          	srli	a4,a4,0x20
    800040b4:	00e587b3          	add	a5,a1,a4
    800040b8:	f0f574e3          	bgeu	a0,a5,80003fc0 <__memmove+0x1c>
    800040bc:	02069613          	slli	a2,a3,0x20
    800040c0:	02065613          	srli	a2,a2,0x20
    800040c4:	fff64613          	not	a2,a2
    800040c8:	00e50733          	add	a4,a0,a4
    800040cc:	00c78633          	add	a2,a5,a2
    800040d0:	fff7c683          	lbu	a3,-1(a5)
    800040d4:	fff78793          	addi	a5,a5,-1
    800040d8:	fff70713          	addi	a4,a4,-1
    800040dc:	00d70023          	sb	a3,0(a4)
    800040e0:	fec798e3          	bne	a5,a2,800040d0 <__memmove+0x12c>
    800040e4:	00813403          	ld	s0,8(sp)
    800040e8:	01010113          	addi	sp,sp,16
    800040ec:	00008067          	ret
    800040f0:	02069713          	slli	a4,a3,0x20
    800040f4:	02075713          	srli	a4,a4,0x20
    800040f8:	00170713          	addi	a4,a4,1
    800040fc:	00e50733          	add	a4,a0,a4
    80004100:	00050793          	mv	a5,a0
    80004104:	0005c683          	lbu	a3,0(a1)
    80004108:	00178793          	addi	a5,a5,1
    8000410c:	00158593          	addi	a1,a1,1
    80004110:	fed78fa3          	sb	a3,-1(a5)
    80004114:	fee798e3          	bne	a5,a4,80004104 <__memmove+0x160>
    80004118:	f89ff06f          	j	800040a0 <__memmove+0xfc>

000000008000411c <__putc>:
    8000411c:	fe010113          	addi	sp,sp,-32
    80004120:	00813823          	sd	s0,16(sp)
    80004124:	00113c23          	sd	ra,24(sp)
    80004128:	02010413          	addi	s0,sp,32
    8000412c:	00050793          	mv	a5,a0
    80004130:	fef40593          	addi	a1,s0,-17
    80004134:	00100613          	li	a2,1
    80004138:	00000513          	li	a0,0
    8000413c:	fef407a3          	sb	a5,-17(s0)
    80004140:	fffff097          	auipc	ra,0xfffff
    80004144:	b3c080e7          	jalr	-1220(ra) # 80002c7c <console_write>
    80004148:	01813083          	ld	ra,24(sp)
    8000414c:	01013403          	ld	s0,16(sp)
    80004150:	02010113          	addi	sp,sp,32
    80004154:	00008067          	ret

0000000080004158 <__getc>:
    80004158:	fe010113          	addi	sp,sp,-32
    8000415c:	00813823          	sd	s0,16(sp)
    80004160:	00113c23          	sd	ra,24(sp)
    80004164:	02010413          	addi	s0,sp,32
    80004168:	fe840593          	addi	a1,s0,-24
    8000416c:	00100613          	li	a2,1
    80004170:	00000513          	li	a0,0
    80004174:	fffff097          	auipc	ra,0xfffff
    80004178:	ae8080e7          	jalr	-1304(ra) # 80002c5c <console_read>
    8000417c:	fe844503          	lbu	a0,-24(s0)
    80004180:	01813083          	ld	ra,24(sp)
    80004184:	01013403          	ld	s0,16(sp)
    80004188:	02010113          	addi	sp,sp,32
    8000418c:	00008067          	ret

0000000080004190 <console_handler>:
    80004190:	fe010113          	addi	sp,sp,-32
    80004194:	00813823          	sd	s0,16(sp)
    80004198:	00113c23          	sd	ra,24(sp)
    8000419c:	00913423          	sd	s1,8(sp)
    800041a0:	02010413          	addi	s0,sp,32
    800041a4:	14202773          	csrr	a4,scause
    800041a8:	100027f3          	csrr	a5,sstatus
    800041ac:	0027f793          	andi	a5,a5,2
    800041b0:	06079e63          	bnez	a5,8000422c <console_handler+0x9c>
    800041b4:	00074c63          	bltz	a4,800041cc <console_handler+0x3c>
    800041b8:	01813083          	ld	ra,24(sp)
    800041bc:	01013403          	ld	s0,16(sp)
    800041c0:	00813483          	ld	s1,8(sp)
    800041c4:	02010113          	addi	sp,sp,32
    800041c8:	00008067          	ret
    800041cc:	0ff77713          	andi	a4,a4,255
    800041d0:	00900793          	li	a5,9
    800041d4:	fef712e3          	bne	a4,a5,800041b8 <console_handler+0x28>
    800041d8:	ffffe097          	auipc	ra,0xffffe
    800041dc:	6dc080e7          	jalr	1756(ra) # 800028b4 <plic_claim>
    800041e0:	00a00793          	li	a5,10
    800041e4:	00050493          	mv	s1,a0
    800041e8:	02f50c63          	beq	a0,a5,80004220 <console_handler+0x90>
    800041ec:	fc0506e3          	beqz	a0,800041b8 <console_handler+0x28>
    800041f0:	00050593          	mv	a1,a0
    800041f4:	00001517          	auipc	a0,0x1
    800041f8:	f7c50513          	addi	a0,a0,-132 # 80005170 <_ZZ12printIntegermE6digits+0xe0>
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	afc080e7          	jalr	-1284(ra) # 80002cf8 <__printf>
    80004204:	01013403          	ld	s0,16(sp)
    80004208:	01813083          	ld	ra,24(sp)
    8000420c:	00048513          	mv	a0,s1
    80004210:	00813483          	ld	s1,8(sp)
    80004214:	02010113          	addi	sp,sp,32
    80004218:	ffffe317          	auipc	t1,0xffffe
    8000421c:	6d430067          	jr	1748(t1) # 800028ec <plic_complete>
    80004220:	fffff097          	auipc	ra,0xfffff
    80004224:	3e0080e7          	jalr	992(ra) # 80003600 <uartintr>
    80004228:	fddff06f          	j	80004204 <console_handler+0x74>
    8000422c:	00001517          	auipc	a0,0x1
    80004230:	04450513          	addi	a0,a0,68 # 80005270 <digits+0x78>
    80004234:	fffff097          	auipc	ra,0xfffff
    80004238:	a68080e7          	jalr	-1432(ra) # 80002c9c <panic>
	...
