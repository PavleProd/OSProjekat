
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	4a813103          	ld	sp,1192(sp) # 800044a8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	119010ef          	jal	ra,80001934 <start>

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
    80001080:	1d4000ef          	jal	ra,80001254 <interruptHandler>
    csrc sip, 0x02 // brisemo zahtev za prekidom
    80001084:	14417073          	csrci	sip,2

    // uvecavanje sepc za 4
    csrr t1, sepc
    80001088:	14102373          	csrr	t1,sepc
    addi t1, t1, 4
    8000108c:	00430313          	addi	t1,t1,4
    csrw sepc, t1
    80001090:	14131073          	csrw	sepc,t1

    // upisujemo povratnu vrednost iz interruptHandlera u a0(x10) na steku da bi ostala nakon restauiranja
    sd a0, 10 * 8(sp)
    80001094:	04a13823          	sd	a0,80(sp)

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    80001098:	00813083          	ld	ra,8(sp)
    8000109c:	01013103          	ld	sp,16(sp)
    800010a0:	01813183          	ld	gp,24(sp)
    800010a4:	02013203          	ld	tp,32(sp)
    800010a8:	02813283          	ld	t0,40(sp)
    800010ac:	03013303          	ld	t1,48(sp)
    800010b0:	03813383          	ld	t2,56(sp)
    800010b4:	04013403          	ld	s0,64(sp)
    800010b8:	04813483          	ld	s1,72(sp)
    800010bc:	05013503          	ld	a0,80(sp)
    800010c0:	05813583          	ld	a1,88(sp)
    800010c4:	06013603          	ld	a2,96(sp)
    800010c8:	06813683          	ld	a3,104(sp)
    800010cc:	07013703          	ld	a4,112(sp)
    800010d0:	07813783          	ld	a5,120(sp)
    800010d4:	08013803          	ld	a6,128(sp)
    800010d8:	08813883          	ld	a7,136(sp)
    800010dc:	09013903          	ld	s2,144(sp)
    800010e0:	09813983          	ld	s3,152(sp)
    800010e4:	0a013a03          	ld	s4,160(sp)
    800010e8:	0a813a83          	ld	s5,168(sp)
    800010ec:	0b013b03          	ld	s6,176(sp)
    800010f0:	0b813b83          	ld	s7,184(sp)
    800010f4:	0c013c03          	ld	s8,192(sp)
    800010f8:	0c813c83          	ld	s9,200(sp)
    800010fc:	0d013d03          	ld	s10,208(sp)
    80001100:	0d813d83          	ld	s11,216(sp)
    80001104:	0e013e03          	ld	t3,224(sp)
    80001108:	0e813e83          	ld	t4,232(sp)
    8000110c:	0f013f03          	ld	t5,240(sp)
    80001110:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001114:	10010113          	addi	sp,sp,256

    80001118:	10200073          	sret
    8000111c:	0000                	unimp
	...

0000000080001120 <pushRegisters>:
.global pushRegisters
pushRegisters:
    addi sp, sp, -256
    80001120:	f0010113          	addi	sp,sp,-256
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001124:	00113423          	sd	ra,8(sp)
    80001128:	00213823          	sd	sp,16(sp)
    8000112c:	00313c23          	sd	gp,24(sp)
    80001130:	02413023          	sd	tp,32(sp)
    80001134:	02513423          	sd	t0,40(sp)
    80001138:	02613823          	sd	t1,48(sp)
    8000113c:	02713c23          	sd	t2,56(sp)
    80001140:	04813023          	sd	s0,64(sp)
    80001144:	04913423          	sd	s1,72(sp)
    80001148:	04a13823          	sd	a0,80(sp)
    8000114c:	04b13c23          	sd	a1,88(sp)
    80001150:	06c13023          	sd	a2,96(sp)
    80001154:	06d13423          	sd	a3,104(sp)
    80001158:	06e13823          	sd	a4,112(sp)
    8000115c:	06f13c23          	sd	a5,120(sp)
    80001160:	09013023          	sd	a6,128(sp)
    80001164:	09113423          	sd	a7,136(sp)
    80001168:	09213823          	sd	s2,144(sp)
    8000116c:	09313c23          	sd	s3,152(sp)
    80001170:	0b413023          	sd	s4,160(sp)
    80001174:	0b513423          	sd	s5,168(sp)
    80001178:	0b613823          	sd	s6,176(sp)
    8000117c:	0b713c23          	sd	s7,184(sp)
    80001180:	0d813023          	sd	s8,192(sp)
    80001184:	0d913423          	sd	s9,200(sp)
    80001188:	0da13823          	sd	s10,208(sp)
    8000118c:	0db13c23          	sd	s11,216(sp)
    80001190:	0fc13023          	sd	t3,224(sp)
    80001194:	0fd13423          	sd	t4,232(sp)
    80001198:	0fe13823          	sd	t5,240(sp)
    8000119c:	0ff13c23          	sd	t6,248(sp)
    ret
    800011a0:	00008067          	ret

00000000800011a4 <popRegisters>:
.global popRegisters
popRegisters:
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011a4:	00813083          	ld	ra,8(sp)
    800011a8:	01013103          	ld	sp,16(sp)
    800011ac:	01813183          	ld	gp,24(sp)
    800011b0:	02013203          	ld	tp,32(sp)
    800011b4:	02813283          	ld	t0,40(sp)
    800011b8:	03013303          	ld	t1,48(sp)
    800011bc:	03813383          	ld	t2,56(sp)
    800011c0:	04013403          	ld	s0,64(sp)
    800011c4:	04813483          	ld	s1,72(sp)
    800011c8:	05013503          	ld	a0,80(sp)
    800011cc:	05813583          	ld	a1,88(sp)
    800011d0:	06013603          	ld	a2,96(sp)
    800011d4:	06813683          	ld	a3,104(sp)
    800011d8:	07013703          	ld	a4,112(sp)
    800011dc:	07813783          	ld	a5,120(sp)
    800011e0:	08013803          	ld	a6,128(sp)
    800011e4:	08813883          	ld	a7,136(sp)
    800011e8:	09013903          	ld	s2,144(sp)
    800011ec:	09813983          	ld	s3,152(sp)
    800011f0:	0a013a03          	ld	s4,160(sp)
    800011f4:	0a813a83          	ld	s5,168(sp)
    800011f8:	0b013b03          	ld	s6,176(sp)
    800011fc:	0b813b83          	ld	s7,184(sp)
    80001200:	0c013c03          	ld	s8,192(sp)
    80001204:	0c813c83          	ld	s9,200(sp)
    80001208:	0d013d03          	ld	s10,208(sp)
    8000120c:	0d813d83          	ld	s11,216(sp)
    80001210:	0e013e03          	ld	t3,224(sp)
    80001214:	0e813e83          	ld	t4,232(sp)
    80001218:	0f013f03          	ld	t5,240(sp)
    8000121c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001220:	10010113          	addi	sp,sp,256
    80001224:	00008067          	ret

0000000080001228 <_Z13callInterruptv>:
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001228:	ff010113          	addi	sp,sp,-16
    8000122c:	00813423          	sd	s0,8(sp)
    80001230:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("csrw stvec, %0" : : "r" (&interrupt)); // ovo treba uraditi na pocetku programa
    80001234:	00003797          	auipc	a5,0x3
    80001238:	2847b783          	ld	a5,644(a5) # 800044b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000123c:	10579073          	csrw	stvec,a5
    asm volatile("ecall");
    80001240:	00000073          	ecall

    asm volatile("mv %0, a0" : "=r" (res));
    80001244:	00050513          	mv	a0,a0
    return res;
}
    80001248:	00813403          	ld	s0,8(sp)
    8000124c:	01010113          	addi	sp,sp,16
    80001250:	00008067          	ret

0000000080001254 <interruptHandler>:

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    80001254:	142027f3          	csrr	a5,scause
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001258:	ff878793          	addi	a5,a5,-8
    8000125c:	00100713          	li	a4,1
    80001260:	04f76e63          	bltu	a4,a5,800012bc <interruptHandler+0x68>
extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00113423          	sd	ra,8(sp)
    8000126c:	00813023          	sd	s0,0(sp)
    80001270:	01010413          	addi	s0,sp,16
        uint64 code;
        asm volatile("mv %0, a0" : "=r" (code));
    80001274:	00050793          	mv	a5,a0
        switch(code) {
    80001278:	02e78063          	beq	a5,a4,80001298 <interruptHandler+0x44>
    8000127c:	00200713          	li	a4,2
    80001280:	02e78663          	beq	a5,a4,800012ac <interruptHandler+0x58>
    80001284:	00000513          	li	a0,0
                return nullptr;
        }
    }

    return nullptr;
}
    80001288:	00813083          	ld	ra,8(sp)
    8000128c:	00013403          	ld	s0,0(sp)
    80001290:	01010113          	addi	sp,sp,16
    80001294:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (size));
    80001298:	00058513          	mv	a0,a1
                return MemoryAllocator::mem_alloc(size);
    8000129c:	00651513          	slli	a0,a0,0x6
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	2b0080e7          	jalr	688(ra) # 80001550 <_ZN15MemoryAllocator9mem_allocEm>
    800012a8:	fe1ff06f          	j	80001288 <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    800012ac:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    800012b0:	00000097          	auipc	ra,0x0
    800012b4:	404080e7          	jalr	1028(ra) # 800016b4 <_ZN15MemoryAllocator8mem_freeEPv>
    800012b8:	fd1ff06f          	j	80001288 <interruptHandler+0x34>
    return nullptr;
    800012bc:	00000513          	li	a0,0
}
    800012c0:	00008067          	ret

00000000800012c4 <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    800012c4:	ff010113          	addi	sp,sp,-16
    800012c8:	00113423          	sd	ra,8(sp)
    800012cc:	00813023          	sd	s0,0(sp)
    800012d0:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800012d4:	00655793          	srli	a5,a0,0x6
    800012d8:	03f57513          	andi	a0,a0,63
    800012dc:	00a03533          	snez	a0,a0
    800012e0:	00a78533          	add	a0,a5,a0
    uint64 code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800012e4:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    800012e8:	00100793          	li	a5,1
    800012ec:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    800012f0:	00000097          	auipc	ra,0x0
    800012f4:	f38080e7          	jalr	-200(ra) # 80001228 <_Z13callInterruptv>
}
    800012f8:	00813083          	ld	ra,8(sp)
    800012fc:	00013403          	ld	s0,0(sp)
    80001300:	01010113          	addi	sp,sp,16
    80001304:	00008067          	ret

0000000080001308 <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    80001308:	ff010113          	addi	sp,sp,-16
    8000130c:	00113423          	sd	ra,8(sp)
    80001310:	00813023          	sd	s0,0(sp)
    80001314:	01010413          	addi	s0,sp,16
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    80001318:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    8000131c:	00200793          	li	a5,2
    80001320:	00078513          	mv	a0,a5

    return (uint64)(callInterrupt());
    80001324:	00000097          	auipc	ra,0x0
    80001328:	f04080e7          	jalr	-252(ra) # 80001228 <_Z13callInterruptv>
}
    8000132c:	0005051b          	sext.w	a0,a0
    80001330:	00813083          	ld	ra,8(sp)
    80001334:	00013403          	ld	s0,0(sp)
    80001338:	01010113          	addi	sp,sp,16
    8000133c:	00008067          	ret

0000000080001340 <_Z12checkNullptrPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    80001340:	00050e63          	beqz	a0,8000135c <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80001344:	00003717          	auipc	a4,0x3
    80001348:	1bc70713          	addi	a4,a4,444 # 80004500 <_ZZ12checkNullptrPvE1x>
    8000134c:	00072783          	lw	a5,0(a4)
    80001350:	0017879b          	addiw	a5,a5,1
    80001354:	00f72023          	sw	a5,0(a4)
    80001358:	00008067          	ret
void checkNullptr(void* p) {
    8000135c:	ff010113          	addi	sp,sp,-16
    80001360:	00113423          	sd	ra,8(sp)
    80001364:	00813023          	sd	s0,0(sp)
    80001368:	01010413          	addi	s0,sp,16
        __putc('?');
    8000136c:	03f00513          	li	a0,63
    80001370:	00002097          	auipc	ra,0x2
    80001374:	68c080e7          	jalr	1676(ra) # 800039fc <__putc>
        __putc('0' + x);
    80001378:	00003517          	auipc	a0,0x3
    8000137c:	18852503          	lw	a0,392(a0) # 80004500 <_ZZ12checkNullptrPvE1x>
    80001380:	0305051b          	addiw	a0,a0,48
    80001384:	0ff57513          	andi	a0,a0,255
    80001388:	00002097          	auipc	ra,0x2
    8000138c:	674080e7          	jalr	1652(ra) # 800039fc <__putc>
    x++;
    80001390:	00003717          	auipc	a4,0x3
    80001394:	17070713          	addi	a4,a4,368 # 80004500 <_ZZ12checkNullptrPvE1x>
    80001398:	00072783          	lw	a5,0(a4)
    8000139c:	0017879b          	addiw	a5,a5,1
    800013a0:	00f72023          	sw	a5,0(a4)
}
    800013a4:	00813083          	ld	ra,8(sp)
    800013a8:	00013403          	ld	s0,0(sp)
    800013ac:	01010113          	addi	sp,sp,16
    800013b0:	00008067          	ret

00000000800013b4 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    800013b4:	00051e63          	bnez	a0,800013d0 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    800013b8:	00003717          	auipc	a4,0x3
    800013bc:	14870713          	addi	a4,a4,328 # 80004500 <_ZZ12checkNullptrPvE1x>
    800013c0:	00472783          	lw	a5,4(a4)
    800013c4:	0017879b          	addiw	a5,a5,1
    800013c8:	00f72223          	sw	a5,4(a4)
    800013cc:	00008067          	ret
void checkStatus(int status) {
    800013d0:	ff010113          	addi	sp,sp,-16
    800013d4:	00113423          	sd	ra,8(sp)
    800013d8:	00813023          	sd	s0,0(sp)
    800013dc:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    800013e0:	00003517          	auipc	a0,0x3
    800013e4:	12452503          	lw	a0,292(a0) # 80004504 <_ZZ11checkStatusiE1y>
    800013e8:	0305051b          	addiw	a0,a0,48
    800013ec:	0ff57513          	andi	a0,a0,255
    800013f0:	00002097          	auipc	ra,0x2
    800013f4:	60c080e7          	jalr	1548(ra) # 800039fc <__putc>
        __putc('?');
    800013f8:	03f00513          	li	a0,63
    800013fc:	00002097          	auipc	ra,0x2
    80001400:	600080e7          	jalr	1536(ra) # 800039fc <__putc>
    y++;
    80001404:	00003717          	auipc	a4,0x3
    80001408:	0fc70713          	addi	a4,a4,252 # 80004500 <_ZZ12checkNullptrPvE1x>
    8000140c:	00472783          	lw	a5,4(a4)
    80001410:	0017879b          	addiw	a5,a5,1
    80001414:	00f72223          	sw	a5,4(a4)
}
    80001418:	00813083          	ld	ra,8(sp)
    8000141c:	00013403          	ld	s0,0(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <main>:

int main() {
    80001428:	fe010113          	addi	sp,sp,-32
    8000142c:	00113c23          	sd	ra,24(sp)
    80001430:	00813823          	sd	s0,16(sp)
    80001434:	00913423          	sd	s1,8(sp)
    80001438:	02010413          	addi	s0,sp,32
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    8000143c:	00003797          	auipc	a5,0x3
    80001440:	0747b783          	ld	a5,116(a5) # 800044b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001444:	0007b503          	ld	a0,0(a5)
    80001448:	00003797          	auipc	a5,0x3
    8000144c:	0587b783          	ld	a5,88(a5) # 800044a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001450:	0007b783          	ld	a5,0(a5)
    80001454:	40f50533          	sub	a0,a0,a5
    80001458:	ff850513          	addi	a0,a0,-8
    8000145c:	00655513          	srli	a0,a0,0x6
    80001460:	fff50513          	addi	a0,a0,-1
    char* niz = (char*)mem_alloc(celaMemorija); // celokupan prostor
    80001464:	00651513          	slli	a0,a0,0x6
    80001468:	00000097          	auipc	ra,0x0
    8000146c:	e5c080e7          	jalr	-420(ra) # 800012c4 <_Z9mem_allocm>
    80001470:	00050493          	mv	s1,a0
    if(niz == nullptr) {
    80001474:	04050663          	beqz	a0,800014c0 <main+0x98>
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    80001478:	00a00513          	li	a0,10
    8000147c:	00000097          	auipc	ra,0x0
    80001480:	e48080e7          	jalr	-440(ra) # 800012c4 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    80001484:	04050663          	beqz	a0,800014d0 <main+0xa8>
        __putc('k');
    }

    int status = mem_free(niz);
    80001488:	00048513          	mv	a0,s1
    8000148c:	00000097          	auipc	ra,0x0
    80001490:	e7c080e7          	jalr	-388(ra) # 80001308 <_Z8mem_freePv>
    if(status) {
    80001494:	04051663          	bnez	a0,800014e0 <main+0xb8>
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    80001498:	00a00513          	li	a0,10
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	e28080e7          	jalr	-472(ra) # 800012c4 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    800014a4:	04050663          	beqz	a0,800014f0 <main+0xc8>
        __putc('?');
    }

    return 0;
}
    800014a8:	00000513          	li	a0,0
    800014ac:	01813083          	ld	ra,24(sp)
    800014b0:	01013403          	ld	s0,16(sp)
    800014b4:	00813483          	ld	s1,8(sp)
    800014b8:	02010113          	addi	sp,sp,32
    800014bc:	00008067          	ret
        __putc('?');
    800014c0:	03f00513          	li	a0,63
    800014c4:	00002097          	auipc	ra,0x2
    800014c8:	538080e7          	jalr	1336(ra) # 800039fc <__putc>
    800014cc:	fadff06f          	j	80001478 <main+0x50>
        __putc('k');
    800014d0:	06b00513          	li	a0,107
    800014d4:	00002097          	auipc	ra,0x2
    800014d8:	528080e7          	jalr	1320(ra) # 800039fc <__putc>
    800014dc:	fadff06f          	j	80001488 <main+0x60>
        __putc('?');
    800014e0:	03f00513          	li	a0,63
    800014e4:	00002097          	auipc	ra,0x2
    800014e8:	518080e7          	jalr	1304(ra) # 800039fc <__putc>
    800014ec:	fadff06f          	j	80001498 <main+0x70>
        __putc('?');
    800014f0:	03f00513          	li	a0,63
    800014f4:	00002097          	auipc	ra,0x2
    800014f8:	508080e7          	jalr	1288(ra) # 800039fc <__putc>
    800014fc:	fadff06f          	j	800014a8 <main+0x80>

0000000080001500 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001500:	ff010113          	addi	sp,sp,-16
    80001504:	00113423          	sd	ra,8(sp)
    80001508:	00813023          	sd	s0,0(sp)
    8000150c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001510:	00000097          	auipc	ra,0x0
    80001514:	db4080e7          	jalr	-588(ra) # 800012c4 <_Z9mem_allocm>
}
    80001518:	00813083          	ld	ra,8(sp)
    8000151c:	00013403          	ld	s0,0(sp)
    80001520:	01010113          	addi	sp,sp,16
    80001524:	00008067          	ret

0000000080001528 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001528:	ff010113          	addi	sp,sp,-16
    8000152c:	00113423          	sd	ra,8(sp)
    80001530:	00813023          	sd	s0,0(sp)
    80001534:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001538:	00000097          	auipc	ra,0x0
    8000153c:	dd0080e7          	jalr	-560(ra) # 80001308 <_Z8mem_freePv>
    80001540:	00813083          	ld	ra,8(sp)
    80001544:	00013403          	ld	s0,0(sp)
    80001548:	01010113          	addi	sp,sp,16
    8000154c:	00008067          	ret

0000000080001550 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001550:	ff010113          	addi	sp,sp,-16
    80001554:	00813423          	sd	s0,8(sp)
    80001558:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000155c:	00003797          	auipc	a5,0x3
    80001560:	fac7b783          	ld	a5,-84(a5) # 80004508 <_ZN15MemoryAllocator4headE>
    80001564:	02078c63          	beqz	a5,8000159c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001568:	00003717          	auipc	a4,0x3
    8000156c:	f4873703          	ld	a4,-184(a4) # 800044b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001570:	00073703          	ld	a4,0(a4)
    80001574:	12e78c63          	beq	a5,a4,800016ac <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001578:	00850713          	addi	a4,a0,8
    8000157c:	00675813          	srli	a6,a4,0x6
    80001580:	03f77793          	andi	a5,a4,63
    80001584:	00f037b3          	snez	a5,a5
    80001588:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000158c:	00003517          	auipc	a0,0x3
    80001590:	f7c53503          	ld	a0,-132(a0) # 80004508 <_ZN15MemoryAllocator4headE>
    80001594:	00000613          	li	a2,0
    80001598:	0a80006f          	j	80001640 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    8000159c:	00003697          	auipc	a3,0x3
    800015a0:	f046b683          	ld	a3,-252(a3) # 800044a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800015a4:	0006b783          	ld	a5,0(a3)
    800015a8:	00003717          	auipc	a4,0x3
    800015ac:	f6f73023          	sd	a5,-160(a4) # 80004508 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800015b0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800015b4:	00003717          	auipc	a4,0x3
    800015b8:	efc73703          	ld	a4,-260(a4) # 800044b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800015bc:	00073703          	ld	a4,0(a4)
    800015c0:	0006b683          	ld	a3,0(a3)
    800015c4:	40d70733          	sub	a4,a4,a3
    800015c8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800015cc:	0007b823          	sd	zero,16(a5)
    800015d0:	fa9ff06f          	j	80001578 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800015d4:	00060e63          	beqz	a2,800015f0 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800015d8:	01063703          	ld	a4,16(a2)
    800015dc:	04070a63          	beqz	a4,80001630 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800015e0:	01073703          	ld	a4,16(a4)
    800015e4:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800015e8:	00078813          	mv	a6,a5
    800015ec:	0ac0006f          	j	80001698 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800015f0:	01053703          	ld	a4,16(a0)
    800015f4:	00070a63          	beqz	a4,80001608 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    800015f8:	00003697          	auipc	a3,0x3
    800015fc:	f0e6b823          	sd	a4,-240(a3) # 80004508 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001600:	00078813          	mv	a6,a5
    80001604:	0940006f          	j	80001698 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001608:	00003717          	auipc	a4,0x3
    8000160c:	ea873703          	ld	a4,-344(a4) # 800044b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001610:	00073703          	ld	a4,0(a4)
    80001614:	00003697          	auipc	a3,0x3
    80001618:	eee6ba23          	sd	a4,-268(a3) # 80004508 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000161c:	00078813          	mv	a6,a5
    80001620:	0780006f          	j	80001698 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001624:	00003797          	auipc	a5,0x3
    80001628:	eee7b223          	sd	a4,-284(a5) # 80004508 <_ZN15MemoryAllocator4headE>
    8000162c:	06c0006f          	j	80001698 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001630:	00078813          	mv	a6,a5
    80001634:	0640006f          	j	80001698 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001638:	00050613          	mv	a2,a0
        curr = curr->next;
    8000163c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001640:	06050063          	beqz	a0,800016a0 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80001644:	00853783          	ld	a5,8(a0)
    80001648:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    8000164c:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001650:	fee7e4e3          	bltu	a5,a4,80001638 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001654:	ff06e2e3          	bltu	a3,a6,80001638 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001658:	f7068ee3          	beq	a3,a6,800015d4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    8000165c:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001660:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80001664:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001668:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    8000166c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001670:	01053783          	ld	a5,16(a0)
    80001674:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001678:	fa0606e3          	beqz	a2,80001624 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    8000167c:	01063783          	ld	a5,16(a2)
    80001680:	00078663          	beqz	a5,8000168c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80001684:	0107b783          	ld	a5,16(a5)
    80001688:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    8000168c:	01063783          	ld	a5,16(a2)
    80001690:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001694:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001698:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    8000169c:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800016a0:	00813403          	ld	s0,8(sp)
    800016a4:	01010113          	addi	sp,sp,16
    800016a8:	00008067          	ret
        return nullptr;
    800016ac:	00000513          	li	a0,0
    800016b0:	ff1ff06f          	j	800016a0 <_ZN15MemoryAllocator9mem_allocEm+0x150>

00000000800016b4 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800016b4:	ff010113          	addi	sp,sp,-16
    800016b8:	00813423          	sd	s0,8(sp)
    800016bc:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800016c0:	16050063          	beqz	a0,80001820 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800016c4:	ff850713          	addi	a4,a0,-8
    800016c8:	00003797          	auipc	a5,0x3
    800016cc:	dd87b783          	ld	a5,-552(a5) # 800044a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800016d0:	0007b783          	ld	a5,0(a5)
    800016d4:	14f76a63          	bltu	a4,a5,80001828 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800016d8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800016dc:	fff58693          	addi	a3,a1,-1
    800016e0:	00d706b3          	add	a3,a4,a3
    800016e4:	00003617          	auipc	a2,0x3
    800016e8:	dcc63603          	ld	a2,-564(a2) # 800044b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800016ec:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800016f0:	14c6f063          	bgeu	a3,a2,80001830 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800016f4:	14070263          	beqz	a4,80001838 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    800016f8:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800016fc:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001700:	14079063          	bnez	a5,80001840 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001704:	03f00793          	li	a5,63
    80001708:	14b7f063          	bgeu	a5,a1,80001848 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    8000170c:	00003797          	auipc	a5,0x3
    80001710:	dfc7b783          	ld	a5,-516(a5) # 80004508 <_ZN15MemoryAllocator4headE>
    80001714:	02f60063          	beq	a2,a5,80001734 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001718:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000171c:	02078a63          	beqz	a5,80001750 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001720:	0007b683          	ld	a3,0(a5)
    80001724:	02e6f663          	bgeu	a3,a4,80001750 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001728:	00078613          	mv	a2,a5
        curr = curr->next;
    8000172c:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001730:	fedff06f          	j	8000171c <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001734:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001738:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    8000173c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80001740:	00003797          	auipc	a5,0x3
    80001744:	dce7b423          	sd	a4,-568(a5) # 80004508 <_ZN15MemoryAllocator4headE>
        return 0;
    80001748:	00000513          	li	a0,0
    8000174c:	0480006f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001750:	04060863          	beqz	a2,800017a0 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001754:	00063683          	ld	a3,0(a2)
    80001758:	00863803          	ld	a6,8(a2)
    8000175c:	010686b3          	add	a3,a3,a6
    80001760:	08e68a63          	beq	a3,a4,800017f4 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80001764:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001768:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000176c:	01063683          	ld	a3,16(a2)
    80001770:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80001774:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001778:	0e078063          	beqz	a5,80001858 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000177c:	0007b583          	ld	a1,0(a5)
    80001780:	00073683          	ld	a3,0(a4)
    80001784:	00873603          	ld	a2,8(a4)
    80001788:	00c686b3          	add	a3,a3,a2
    8000178c:	06d58c63          	beq	a1,a3,80001804 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80001790:	00000513          	li	a0,0
}
    80001794:	00813403          	ld	s0,8(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800017a0:	0a078863          	beqz	a5,80001850 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800017a4:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800017a8:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800017ac:	00003797          	auipc	a5,0x3
    800017b0:	d5c7b783          	ld	a5,-676(a5) # 80004508 <_ZN15MemoryAllocator4headE>
    800017b4:	0007b603          	ld	a2,0(a5)
    800017b8:	00b706b3          	add	a3,a4,a1
    800017bc:	00d60c63          	beq	a2,a3,800017d4 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800017c0:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800017c4:	00003797          	auipc	a5,0x3
    800017c8:	d4e7b223          	sd	a4,-700(a5) # 80004508 <_ZN15MemoryAllocator4headE>
            return 0;
    800017cc:	00000513          	li	a0,0
    800017d0:	fc5ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800017d4:	0087b783          	ld	a5,8(a5)
    800017d8:	00b785b3          	add	a1,a5,a1
    800017dc:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800017e0:	00003797          	auipc	a5,0x3
    800017e4:	d287b783          	ld	a5,-728(a5) # 80004508 <_ZN15MemoryAllocator4headE>
    800017e8:	0107b783          	ld	a5,16(a5)
    800017ec:	00f53423          	sd	a5,8(a0)
    800017f0:	fd5ff06f          	j	800017c4 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800017f4:	00b805b3          	add	a1,a6,a1
    800017f8:	00b63423          	sd	a1,8(a2)
    800017fc:	00060713          	mv	a4,a2
    80001800:	f79ff06f          	j	80001778 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001804:	0087b683          	ld	a3,8(a5)
    80001808:	00d60633          	add	a2,a2,a3
    8000180c:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001810:	0107b783          	ld	a5,16(a5)
    80001814:	00f73823          	sd	a5,16(a4)
    return 0;
    80001818:	00000513          	li	a0,0
    8000181c:	f79ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001820:	fff00513          	li	a0,-1
    80001824:	f71ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001828:	fff00513          	li	a0,-1
    8000182c:	f69ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001830:	fff00513          	li	a0,-1
    80001834:	f61ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001838:	fff00513          	li	a0,-1
    8000183c:	f59ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001840:	fff00513          	li	a0,-1
    80001844:	f51ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001848:	fff00513          	li	a0,-1
    8000184c:	f49ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001850:	fff00513          	li	a0,-1
    80001854:	f41ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001858:	00000513          	li	a0,0
    8000185c:	f39ff06f          	j	80001794 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001860 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../lib/console.h"

void printString(char const *string)
{
    80001860:	fe010113          	addi	sp,sp,-32
    80001864:	00113c23          	sd	ra,24(sp)
    80001868:	00813823          	sd	s0,16(sp)
    8000186c:	00913423          	sd	s1,8(sp)
    80001870:	02010413          	addi	s0,sp,32
    80001874:	00050493          	mv	s1,a0
    while (*string != '\0')
    80001878:	0004c503          	lbu	a0,0(s1)
    8000187c:	00050a63          	beqz	a0,80001890 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    80001880:	00002097          	auipc	ra,0x2
    80001884:	17c080e7          	jalr	380(ra) # 800039fc <__putc>
        string++;
    80001888:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000188c:	fedff06f          	j	80001878 <_Z11printStringPKc+0x18>
    }
}
    80001890:	01813083          	ld	ra,24(sp)
    80001894:	01013403          	ld	s0,16(sp)
    80001898:	00813483          	ld	s1,8(sp)
    8000189c:	02010113          	addi	sp,sp,32
    800018a0:	00008067          	ret

00000000800018a4 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    800018a4:	fd010113          	addi	sp,sp,-48
    800018a8:	02113423          	sd	ra,40(sp)
    800018ac:	02813023          	sd	s0,32(sp)
    800018b0:	00913c23          	sd	s1,24(sp)
    800018b4:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    800018b8:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    800018bc:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    800018c0:	00a00613          	li	a2,10
    800018c4:	02c5773b          	remuw	a4,a0,a2
    800018c8:	02071693          	slli	a3,a4,0x20
    800018cc:	0206d693          	srli	a3,a3,0x20
    800018d0:	00002717          	auipc	a4,0x2
    800018d4:	75070713          	addi	a4,a4,1872 # 80004020 <_ZZ12printIntegermE6digits>
    800018d8:	00d70733          	add	a4,a4,a3
    800018dc:	00074703          	lbu	a4,0(a4)
    800018e0:	fe040693          	addi	a3,s0,-32
    800018e4:	009687b3          	add	a5,a3,s1
    800018e8:	0014849b          	addiw	s1,s1,1
    800018ec:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    800018f0:	0005071b          	sext.w	a4,a0
    800018f4:	02c5553b          	divuw	a0,a0,a2
    800018f8:	00900793          	li	a5,9
    800018fc:	fce7e2e3          	bltu	a5,a4,800018c0 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    80001900:	fff4849b          	addiw	s1,s1,-1
    80001904:	0004ce63          	bltz	s1,80001920 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    80001908:	fe040793          	addi	a5,s0,-32
    8000190c:	009787b3          	add	a5,a5,s1
    80001910:	ff07c503          	lbu	a0,-16(a5)
    80001914:	00002097          	auipc	ra,0x2
    80001918:	0e8080e7          	jalr	232(ra) # 800039fc <__putc>
    8000191c:	fe5ff06f          	j	80001900 <_Z12printIntegerm+0x5c>
    80001920:	02813083          	ld	ra,40(sp)
    80001924:	02013403          	ld	s0,32(sp)
    80001928:	01813483          	ld	s1,24(sp)
    8000192c:	03010113          	addi	sp,sp,48
    80001930:	00008067          	ret

0000000080001934 <start>:
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00813423          	sd	s0,8(sp)
    8000193c:	01010413          	addi	s0,sp,16
    80001940:	300027f3          	csrr	a5,mstatus
    80001944:	ffffe737          	lui	a4,0xffffe
    80001948:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff908f>
    8000194c:	00e7f7b3          	and	a5,a5,a4
    80001950:	00001737          	lui	a4,0x1
    80001954:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001958:	00e7e7b3          	or	a5,a5,a4
    8000195c:	30079073          	csrw	mstatus,a5
    80001960:	00000797          	auipc	a5,0x0
    80001964:	16078793          	addi	a5,a5,352 # 80001ac0 <system_main>
    80001968:	34179073          	csrw	mepc,a5
    8000196c:	00000793          	li	a5,0
    80001970:	18079073          	csrw	satp,a5
    80001974:	000107b7          	lui	a5,0x10
    80001978:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000197c:	30279073          	csrw	medeleg,a5
    80001980:	30379073          	csrw	mideleg,a5
    80001984:	104027f3          	csrr	a5,sie
    80001988:	2227e793          	ori	a5,a5,546
    8000198c:	10479073          	csrw	sie,a5
    80001990:	fff00793          	li	a5,-1
    80001994:	00a7d793          	srli	a5,a5,0xa
    80001998:	3b079073          	csrw	pmpaddr0,a5
    8000199c:	00f00793          	li	a5,15
    800019a0:	3a079073          	csrw	pmpcfg0,a5
    800019a4:	f14027f3          	csrr	a5,mhartid
    800019a8:	0200c737          	lui	a4,0x200c
    800019ac:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800019b0:	0007869b          	sext.w	a3,a5
    800019b4:	00269713          	slli	a4,a3,0x2
    800019b8:	000f4637          	lui	a2,0xf4
    800019bc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800019c0:	00d70733          	add	a4,a4,a3
    800019c4:	0037979b          	slliw	a5,a5,0x3
    800019c8:	020046b7          	lui	a3,0x2004
    800019cc:	00d787b3          	add	a5,a5,a3
    800019d0:	00c585b3          	add	a1,a1,a2
    800019d4:	00371693          	slli	a3,a4,0x3
    800019d8:	00003717          	auipc	a4,0x3
    800019dc:	b3870713          	addi	a4,a4,-1224 # 80004510 <timer_scratch>
    800019e0:	00b7b023          	sd	a1,0(a5)
    800019e4:	00d70733          	add	a4,a4,a3
    800019e8:	00f73c23          	sd	a5,24(a4)
    800019ec:	02c73023          	sd	a2,32(a4)
    800019f0:	34071073          	csrw	mscratch,a4
    800019f4:	00000797          	auipc	a5,0x0
    800019f8:	6ec78793          	addi	a5,a5,1772 # 800020e0 <timervec>
    800019fc:	30579073          	csrw	mtvec,a5
    80001a00:	300027f3          	csrr	a5,mstatus
    80001a04:	0087e793          	ori	a5,a5,8
    80001a08:	30079073          	csrw	mstatus,a5
    80001a0c:	304027f3          	csrr	a5,mie
    80001a10:	0807e793          	ori	a5,a5,128
    80001a14:	30479073          	csrw	mie,a5
    80001a18:	f14027f3          	csrr	a5,mhartid
    80001a1c:	0007879b          	sext.w	a5,a5
    80001a20:	00078213          	mv	tp,a5
    80001a24:	30200073          	mret
    80001a28:	00813403          	ld	s0,8(sp)
    80001a2c:	01010113          	addi	sp,sp,16
    80001a30:	00008067          	ret

0000000080001a34 <timerinit>:
    80001a34:	ff010113          	addi	sp,sp,-16
    80001a38:	00813423          	sd	s0,8(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    80001a40:	f14027f3          	csrr	a5,mhartid
    80001a44:	0200c737          	lui	a4,0x200c
    80001a48:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001a4c:	0007869b          	sext.w	a3,a5
    80001a50:	00269713          	slli	a4,a3,0x2
    80001a54:	000f4637          	lui	a2,0xf4
    80001a58:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001a5c:	00d70733          	add	a4,a4,a3
    80001a60:	0037979b          	slliw	a5,a5,0x3
    80001a64:	020046b7          	lui	a3,0x2004
    80001a68:	00d787b3          	add	a5,a5,a3
    80001a6c:	00c585b3          	add	a1,a1,a2
    80001a70:	00371693          	slli	a3,a4,0x3
    80001a74:	00003717          	auipc	a4,0x3
    80001a78:	a9c70713          	addi	a4,a4,-1380 # 80004510 <timer_scratch>
    80001a7c:	00b7b023          	sd	a1,0(a5)
    80001a80:	00d70733          	add	a4,a4,a3
    80001a84:	00f73c23          	sd	a5,24(a4)
    80001a88:	02c73023          	sd	a2,32(a4)
    80001a8c:	34071073          	csrw	mscratch,a4
    80001a90:	00000797          	auipc	a5,0x0
    80001a94:	65078793          	addi	a5,a5,1616 # 800020e0 <timervec>
    80001a98:	30579073          	csrw	mtvec,a5
    80001a9c:	300027f3          	csrr	a5,mstatus
    80001aa0:	0087e793          	ori	a5,a5,8
    80001aa4:	30079073          	csrw	mstatus,a5
    80001aa8:	304027f3          	csrr	a5,mie
    80001aac:	0807e793          	ori	a5,a5,128
    80001ab0:	30479073          	csrw	mie,a5
    80001ab4:	00813403          	ld	s0,8(sp)
    80001ab8:	01010113          	addi	sp,sp,16
    80001abc:	00008067          	ret

0000000080001ac0 <system_main>:
    80001ac0:	fe010113          	addi	sp,sp,-32
    80001ac4:	00813823          	sd	s0,16(sp)
    80001ac8:	00913423          	sd	s1,8(sp)
    80001acc:	00113c23          	sd	ra,24(sp)
    80001ad0:	02010413          	addi	s0,sp,32
    80001ad4:	00000097          	auipc	ra,0x0
    80001ad8:	0c4080e7          	jalr	196(ra) # 80001b98 <cpuid>
    80001adc:	00003497          	auipc	s1,0x3
    80001ae0:	9f448493          	addi	s1,s1,-1548 # 800044d0 <started>
    80001ae4:	02050263          	beqz	a0,80001b08 <system_main+0x48>
    80001ae8:	0004a783          	lw	a5,0(s1)
    80001aec:	0007879b          	sext.w	a5,a5
    80001af0:	fe078ce3          	beqz	a5,80001ae8 <system_main+0x28>
    80001af4:	0ff0000f          	fence
    80001af8:	00002517          	auipc	a0,0x2
    80001afc:	56850513          	addi	a0,a0,1384 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    80001b00:	00001097          	auipc	ra,0x1
    80001b04:	a7c080e7          	jalr	-1412(ra) # 8000257c <panic>
    80001b08:	00001097          	auipc	ra,0x1
    80001b0c:	9d0080e7          	jalr	-1584(ra) # 800024d8 <consoleinit>
    80001b10:	00001097          	auipc	ra,0x1
    80001b14:	15c080e7          	jalr	348(ra) # 80002c6c <printfinit>
    80001b18:	00002517          	auipc	a0,0x2
    80001b1c:	62850513          	addi	a0,a0,1576 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001b20:	00001097          	auipc	ra,0x1
    80001b24:	ab8080e7          	jalr	-1352(ra) # 800025d8 <__printf>
    80001b28:	00002517          	auipc	a0,0x2
    80001b2c:	50850513          	addi	a0,a0,1288 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    80001b30:	00001097          	auipc	ra,0x1
    80001b34:	aa8080e7          	jalr	-1368(ra) # 800025d8 <__printf>
    80001b38:	00002517          	auipc	a0,0x2
    80001b3c:	60850513          	addi	a0,a0,1544 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001b40:	00001097          	auipc	ra,0x1
    80001b44:	a98080e7          	jalr	-1384(ra) # 800025d8 <__printf>
    80001b48:	00001097          	auipc	ra,0x1
    80001b4c:	4b0080e7          	jalr	1200(ra) # 80002ff8 <kinit>
    80001b50:	00000097          	auipc	ra,0x0
    80001b54:	148080e7          	jalr	328(ra) # 80001c98 <trapinit>
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	16c080e7          	jalr	364(ra) # 80001cc4 <trapinithart>
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	5c0080e7          	jalr	1472(ra) # 80002120 <plicinit>
    80001b68:	00000097          	auipc	ra,0x0
    80001b6c:	5e0080e7          	jalr	1504(ra) # 80002148 <plicinithart>
    80001b70:	00000097          	auipc	ra,0x0
    80001b74:	078080e7          	jalr	120(ra) # 80001be8 <userinit>
    80001b78:	0ff0000f          	fence
    80001b7c:	00100793          	li	a5,1
    80001b80:	00002517          	auipc	a0,0x2
    80001b84:	4c850513          	addi	a0,a0,1224 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    80001b88:	00f4a023          	sw	a5,0(s1)
    80001b8c:	00001097          	auipc	ra,0x1
    80001b90:	a4c080e7          	jalr	-1460(ra) # 800025d8 <__printf>
    80001b94:	0000006f          	j	80001b94 <system_main+0xd4>

0000000080001b98 <cpuid>:
    80001b98:	ff010113          	addi	sp,sp,-16
    80001b9c:	00813423          	sd	s0,8(sp)
    80001ba0:	01010413          	addi	s0,sp,16
    80001ba4:	00020513          	mv	a0,tp
    80001ba8:	00813403          	ld	s0,8(sp)
    80001bac:	0005051b          	sext.w	a0,a0
    80001bb0:	01010113          	addi	sp,sp,16
    80001bb4:	00008067          	ret

0000000080001bb8 <mycpu>:
    80001bb8:	ff010113          	addi	sp,sp,-16
    80001bbc:	00813423          	sd	s0,8(sp)
    80001bc0:	01010413          	addi	s0,sp,16
    80001bc4:	00020793          	mv	a5,tp
    80001bc8:	00813403          	ld	s0,8(sp)
    80001bcc:	0007879b          	sext.w	a5,a5
    80001bd0:	00779793          	slli	a5,a5,0x7
    80001bd4:	00004517          	auipc	a0,0x4
    80001bd8:	96c50513          	addi	a0,a0,-1684 # 80005540 <cpus>
    80001bdc:	00f50533          	add	a0,a0,a5
    80001be0:	01010113          	addi	sp,sp,16
    80001be4:	00008067          	ret

0000000080001be8 <userinit>:
    80001be8:	ff010113          	addi	sp,sp,-16
    80001bec:	00813423          	sd	s0,8(sp)
    80001bf0:	01010413          	addi	s0,sp,16
    80001bf4:	00813403          	ld	s0,8(sp)
    80001bf8:	01010113          	addi	sp,sp,16
    80001bfc:	00000317          	auipc	t1,0x0
    80001c00:	82c30067          	jr	-2004(t1) # 80001428 <main>

0000000080001c04 <either_copyout>:
    80001c04:	ff010113          	addi	sp,sp,-16
    80001c08:	00813023          	sd	s0,0(sp)
    80001c0c:	00113423          	sd	ra,8(sp)
    80001c10:	01010413          	addi	s0,sp,16
    80001c14:	02051663          	bnez	a0,80001c40 <either_copyout+0x3c>
    80001c18:	00058513          	mv	a0,a1
    80001c1c:	00060593          	mv	a1,a2
    80001c20:	0006861b          	sext.w	a2,a3
    80001c24:	00002097          	auipc	ra,0x2
    80001c28:	c60080e7          	jalr	-928(ra) # 80003884 <__memmove>
    80001c2c:	00813083          	ld	ra,8(sp)
    80001c30:	00013403          	ld	s0,0(sp)
    80001c34:	00000513          	li	a0,0
    80001c38:	01010113          	addi	sp,sp,16
    80001c3c:	00008067          	ret
    80001c40:	00002517          	auipc	a0,0x2
    80001c44:	44850513          	addi	a0,a0,1096 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001c48:	00001097          	auipc	ra,0x1
    80001c4c:	934080e7          	jalr	-1740(ra) # 8000257c <panic>

0000000080001c50 <either_copyin>:
    80001c50:	ff010113          	addi	sp,sp,-16
    80001c54:	00813023          	sd	s0,0(sp)
    80001c58:	00113423          	sd	ra,8(sp)
    80001c5c:	01010413          	addi	s0,sp,16
    80001c60:	02059463          	bnez	a1,80001c88 <either_copyin+0x38>
    80001c64:	00060593          	mv	a1,a2
    80001c68:	0006861b          	sext.w	a2,a3
    80001c6c:	00002097          	auipc	ra,0x2
    80001c70:	c18080e7          	jalr	-1000(ra) # 80003884 <__memmove>
    80001c74:	00813083          	ld	ra,8(sp)
    80001c78:	00013403          	ld	s0,0(sp)
    80001c7c:	00000513          	li	a0,0
    80001c80:	01010113          	addi	sp,sp,16
    80001c84:	00008067          	ret
    80001c88:	00002517          	auipc	a0,0x2
    80001c8c:	42850513          	addi	a0,a0,1064 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    80001c90:	00001097          	auipc	ra,0x1
    80001c94:	8ec080e7          	jalr	-1812(ra) # 8000257c <panic>

0000000080001c98 <trapinit>:
    80001c98:	ff010113          	addi	sp,sp,-16
    80001c9c:	00813423          	sd	s0,8(sp)
    80001ca0:	01010413          	addi	s0,sp,16
    80001ca4:	00813403          	ld	s0,8(sp)
    80001ca8:	00002597          	auipc	a1,0x2
    80001cac:	43058593          	addi	a1,a1,1072 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    80001cb0:	00004517          	auipc	a0,0x4
    80001cb4:	91050513          	addi	a0,a0,-1776 # 800055c0 <tickslock>
    80001cb8:	01010113          	addi	sp,sp,16
    80001cbc:	00001317          	auipc	t1,0x1
    80001cc0:	5cc30067          	jr	1484(t1) # 80003288 <initlock>

0000000080001cc4 <trapinithart>:
    80001cc4:	ff010113          	addi	sp,sp,-16
    80001cc8:	00813423          	sd	s0,8(sp)
    80001ccc:	01010413          	addi	s0,sp,16
    80001cd0:	00000797          	auipc	a5,0x0
    80001cd4:	30078793          	addi	a5,a5,768 # 80001fd0 <kernelvec>
    80001cd8:	10579073          	csrw	stvec,a5
    80001cdc:	00813403          	ld	s0,8(sp)
    80001ce0:	01010113          	addi	sp,sp,16
    80001ce4:	00008067          	ret

0000000080001ce8 <usertrap>:
    80001ce8:	ff010113          	addi	sp,sp,-16
    80001cec:	00813423          	sd	s0,8(sp)
    80001cf0:	01010413          	addi	s0,sp,16
    80001cf4:	00813403          	ld	s0,8(sp)
    80001cf8:	01010113          	addi	sp,sp,16
    80001cfc:	00008067          	ret

0000000080001d00 <usertrapret>:
    80001d00:	ff010113          	addi	sp,sp,-16
    80001d04:	00813423          	sd	s0,8(sp)
    80001d08:	01010413          	addi	s0,sp,16
    80001d0c:	00813403          	ld	s0,8(sp)
    80001d10:	01010113          	addi	sp,sp,16
    80001d14:	00008067          	ret

0000000080001d18 <kerneltrap>:
    80001d18:	fe010113          	addi	sp,sp,-32
    80001d1c:	00813823          	sd	s0,16(sp)
    80001d20:	00113c23          	sd	ra,24(sp)
    80001d24:	00913423          	sd	s1,8(sp)
    80001d28:	02010413          	addi	s0,sp,32
    80001d2c:	142025f3          	csrr	a1,scause
    80001d30:	100027f3          	csrr	a5,sstatus
    80001d34:	0027f793          	andi	a5,a5,2
    80001d38:	10079c63          	bnez	a5,80001e50 <kerneltrap+0x138>
    80001d3c:	142027f3          	csrr	a5,scause
    80001d40:	0207ce63          	bltz	a5,80001d7c <kerneltrap+0x64>
    80001d44:	00002517          	auipc	a0,0x2
    80001d48:	3dc50513          	addi	a0,a0,988 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001d4c:	00001097          	auipc	ra,0x1
    80001d50:	88c080e7          	jalr	-1908(ra) # 800025d8 <__printf>
    80001d54:	141025f3          	csrr	a1,sepc
    80001d58:	14302673          	csrr	a2,stval
    80001d5c:	00002517          	auipc	a0,0x2
    80001d60:	3d450513          	addi	a0,a0,980 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001d64:	00001097          	auipc	ra,0x1
    80001d68:	874080e7          	jalr	-1932(ra) # 800025d8 <__printf>
    80001d6c:	00002517          	auipc	a0,0x2
    80001d70:	3dc50513          	addi	a0,a0,988 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001d74:	00001097          	auipc	ra,0x1
    80001d78:	808080e7          	jalr	-2040(ra) # 8000257c <panic>
    80001d7c:	0ff7f713          	andi	a4,a5,255
    80001d80:	00900693          	li	a3,9
    80001d84:	04d70063          	beq	a4,a3,80001dc4 <kerneltrap+0xac>
    80001d88:	fff00713          	li	a4,-1
    80001d8c:	03f71713          	slli	a4,a4,0x3f
    80001d90:	00170713          	addi	a4,a4,1
    80001d94:	fae798e3          	bne	a5,a4,80001d44 <kerneltrap+0x2c>
    80001d98:	00000097          	auipc	ra,0x0
    80001d9c:	e00080e7          	jalr	-512(ra) # 80001b98 <cpuid>
    80001da0:	06050663          	beqz	a0,80001e0c <kerneltrap+0xf4>
    80001da4:	144027f3          	csrr	a5,sip
    80001da8:	ffd7f793          	andi	a5,a5,-3
    80001dac:	14479073          	csrw	sip,a5
    80001db0:	01813083          	ld	ra,24(sp)
    80001db4:	01013403          	ld	s0,16(sp)
    80001db8:	00813483          	ld	s1,8(sp)
    80001dbc:	02010113          	addi	sp,sp,32
    80001dc0:	00008067          	ret
    80001dc4:	00000097          	auipc	ra,0x0
    80001dc8:	3d0080e7          	jalr	976(ra) # 80002194 <plic_claim>
    80001dcc:	00a00793          	li	a5,10
    80001dd0:	00050493          	mv	s1,a0
    80001dd4:	06f50863          	beq	a0,a5,80001e44 <kerneltrap+0x12c>
    80001dd8:	fc050ce3          	beqz	a0,80001db0 <kerneltrap+0x98>
    80001ddc:	00050593          	mv	a1,a0
    80001de0:	00002517          	auipc	a0,0x2
    80001de4:	32050513          	addi	a0,a0,800 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	7f0080e7          	jalr	2032(ra) # 800025d8 <__printf>
    80001df0:	01013403          	ld	s0,16(sp)
    80001df4:	01813083          	ld	ra,24(sp)
    80001df8:	00048513          	mv	a0,s1
    80001dfc:	00813483          	ld	s1,8(sp)
    80001e00:	02010113          	addi	sp,sp,32
    80001e04:	00000317          	auipc	t1,0x0
    80001e08:	3c830067          	jr	968(t1) # 800021cc <plic_complete>
    80001e0c:	00003517          	auipc	a0,0x3
    80001e10:	7b450513          	addi	a0,a0,1972 # 800055c0 <tickslock>
    80001e14:	00001097          	auipc	ra,0x1
    80001e18:	498080e7          	jalr	1176(ra) # 800032ac <acquire>
    80001e1c:	00002717          	auipc	a4,0x2
    80001e20:	6b870713          	addi	a4,a4,1720 # 800044d4 <ticks>
    80001e24:	00072783          	lw	a5,0(a4)
    80001e28:	00003517          	auipc	a0,0x3
    80001e2c:	79850513          	addi	a0,a0,1944 # 800055c0 <tickslock>
    80001e30:	0017879b          	addiw	a5,a5,1
    80001e34:	00f72023          	sw	a5,0(a4)
    80001e38:	00001097          	auipc	ra,0x1
    80001e3c:	540080e7          	jalr	1344(ra) # 80003378 <release>
    80001e40:	f65ff06f          	j	80001da4 <kerneltrap+0x8c>
    80001e44:	00001097          	auipc	ra,0x1
    80001e48:	09c080e7          	jalr	156(ra) # 80002ee0 <uartintr>
    80001e4c:	fa5ff06f          	j	80001df0 <kerneltrap+0xd8>
    80001e50:	00002517          	auipc	a0,0x2
    80001e54:	29050513          	addi	a0,a0,656 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    80001e58:	00000097          	auipc	ra,0x0
    80001e5c:	724080e7          	jalr	1828(ra) # 8000257c <panic>

0000000080001e60 <clockintr>:
    80001e60:	fe010113          	addi	sp,sp,-32
    80001e64:	00813823          	sd	s0,16(sp)
    80001e68:	00913423          	sd	s1,8(sp)
    80001e6c:	00113c23          	sd	ra,24(sp)
    80001e70:	02010413          	addi	s0,sp,32
    80001e74:	00003497          	auipc	s1,0x3
    80001e78:	74c48493          	addi	s1,s1,1868 # 800055c0 <tickslock>
    80001e7c:	00048513          	mv	a0,s1
    80001e80:	00001097          	auipc	ra,0x1
    80001e84:	42c080e7          	jalr	1068(ra) # 800032ac <acquire>
    80001e88:	00002717          	auipc	a4,0x2
    80001e8c:	64c70713          	addi	a4,a4,1612 # 800044d4 <ticks>
    80001e90:	00072783          	lw	a5,0(a4)
    80001e94:	01013403          	ld	s0,16(sp)
    80001e98:	01813083          	ld	ra,24(sp)
    80001e9c:	00048513          	mv	a0,s1
    80001ea0:	0017879b          	addiw	a5,a5,1
    80001ea4:	00813483          	ld	s1,8(sp)
    80001ea8:	00f72023          	sw	a5,0(a4)
    80001eac:	02010113          	addi	sp,sp,32
    80001eb0:	00001317          	auipc	t1,0x1
    80001eb4:	4c830067          	jr	1224(t1) # 80003378 <release>

0000000080001eb8 <devintr>:
    80001eb8:	142027f3          	csrr	a5,scause
    80001ebc:	00000513          	li	a0,0
    80001ec0:	0007c463          	bltz	a5,80001ec8 <devintr+0x10>
    80001ec4:	00008067          	ret
    80001ec8:	fe010113          	addi	sp,sp,-32
    80001ecc:	00813823          	sd	s0,16(sp)
    80001ed0:	00113c23          	sd	ra,24(sp)
    80001ed4:	00913423          	sd	s1,8(sp)
    80001ed8:	02010413          	addi	s0,sp,32
    80001edc:	0ff7f713          	andi	a4,a5,255
    80001ee0:	00900693          	li	a3,9
    80001ee4:	04d70c63          	beq	a4,a3,80001f3c <devintr+0x84>
    80001ee8:	fff00713          	li	a4,-1
    80001eec:	03f71713          	slli	a4,a4,0x3f
    80001ef0:	00170713          	addi	a4,a4,1
    80001ef4:	00e78c63          	beq	a5,a4,80001f0c <devintr+0x54>
    80001ef8:	01813083          	ld	ra,24(sp)
    80001efc:	01013403          	ld	s0,16(sp)
    80001f00:	00813483          	ld	s1,8(sp)
    80001f04:	02010113          	addi	sp,sp,32
    80001f08:	00008067          	ret
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	c8c080e7          	jalr	-884(ra) # 80001b98 <cpuid>
    80001f14:	06050663          	beqz	a0,80001f80 <devintr+0xc8>
    80001f18:	144027f3          	csrr	a5,sip
    80001f1c:	ffd7f793          	andi	a5,a5,-3
    80001f20:	14479073          	csrw	sip,a5
    80001f24:	01813083          	ld	ra,24(sp)
    80001f28:	01013403          	ld	s0,16(sp)
    80001f2c:	00813483          	ld	s1,8(sp)
    80001f30:	00200513          	li	a0,2
    80001f34:	02010113          	addi	sp,sp,32
    80001f38:	00008067          	ret
    80001f3c:	00000097          	auipc	ra,0x0
    80001f40:	258080e7          	jalr	600(ra) # 80002194 <plic_claim>
    80001f44:	00a00793          	li	a5,10
    80001f48:	00050493          	mv	s1,a0
    80001f4c:	06f50663          	beq	a0,a5,80001fb8 <devintr+0x100>
    80001f50:	00100513          	li	a0,1
    80001f54:	fa0482e3          	beqz	s1,80001ef8 <devintr+0x40>
    80001f58:	00048593          	mv	a1,s1
    80001f5c:	00002517          	auipc	a0,0x2
    80001f60:	1a450513          	addi	a0,a0,420 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	674080e7          	jalr	1652(ra) # 800025d8 <__printf>
    80001f6c:	00048513          	mv	a0,s1
    80001f70:	00000097          	auipc	ra,0x0
    80001f74:	25c080e7          	jalr	604(ra) # 800021cc <plic_complete>
    80001f78:	00100513          	li	a0,1
    80001f7c:	f7dff06f          	j	80001ef8 <devintr+0x40>
    80001f80:	00003517          	auipc	a0,0x3
    80001f84:	64050513          	addi	a0,a0,1600 # 800055c0 <tickslock>
    80001f88:	00001097          	auipc	ra,0x1
    80001f8c:	324080e7          	jalr	804(ra) # 800032ac <acquire>
    80001f90:	00002717          	auipc	a4,0x2
    80001f94:	54470713          	addi	a4,a4,1348 # 800044d4 <ticks>
    80001f98:	00072783          	lw	a5,0(a4)
    80001f9c:	00003517          	auipc	a0,0x3
    80001fa0:	62450513          	addi	a0,a0,1572 # 800055c0 <tickslock>
    80001fa4:	0017879b          	addiw	a5,a5,1
    80001fa8:	00f72023          	sw	a5,0(a4)
    80001fac:	00001097          	auipc	ra,0x1
    80001fb0:	3cc080e7          	jalr	972(ra) # 80003378 <release>
    80001fb4:	f65ff06f          	j	80001f18 <devintr+0x60>
    80001fb8:	00001097          	auipc	ra,0x1
    80001fbc:	f28080e7          	jalr	-216(ra) # 80002ee0 <uartintr>
    80001fc0:	fadff06f          	j	80001f6c <devintr+0xb4>
	...

0000000080001fd0 <kernelvec>:
    80001fd0:	f0010113          	addi	sp,sp,-256
    80001fd4:	00113023          	sd	ra,0(sp)
    80001fd8:	00213423          	sd	sp,8(sp)
    80001fdc:	00313823          	sd	gp,16(sp)
    80001fe0:	00413c23          	sd	tp,24(sp)
    80001fe4:	02513023          	sd	t0,32(sp)
    80001fe8:	02613423          	sd	t1,40(sp)
    80001fec:	02713823          	sd	t2,48(sp)
    80001ff0:	02813c23          	sd	s0,56(sp)
    80001ff4:	04913023          	sd	s1,64(sp)
    80001ff8:	04a13423          	sd	a0,72(sp)
    80001ffc:	04b13823          	sd	a1,80(sp)
    80002000:	04c13c23          	sd	a2,88(sp)
    80002004:	06d13023          	sd	a3,96(sp)
    80002008:	06e13423          	sd	a4,104(sp)
    8000200c:	06f13823          	sd	a5,112(sp)
    80002010:	07013c23          	sd	a6,120(sp)
    80002014:	09113023          	sd	a7,128(sp)
    80002018:	09213423          	sd	s2,136(sp)
    8000201c:	09313823          	sd	s3,144(sp)
    80002020:	09413c23          	sd	s4,152(sp)
    80002024:	0b513023          	sd	s5,160(sp)
    80002028:	0b613423          	sd	s6,168(sp)
    8000202c:	0b713823          	sd	s7,176(sp)
    80002030:	0b813c23          	sd	s8,184(sp)
    80002034:	0d913023          	sd	s9,192(sp)
    80002038:	0da13423          	sd	s10,200(sp)
    8000203c:	0db13823          	sd	s11,208(sp)
    80002040:	0dc13c23          	sd	t3,216(sp)
    80002044:	0fd13023          	sd	t4,224(sp)
    80002048:	0fe13423          	sd	t5,232(sp)
    8000204c:	0ff13823          	sd	t6,240(sp)
    80002050:	cc9ff0ef          	jal	ra,80001d18 <kerneltrap>
    80002054:	00013083          	ld	ra,0(sp)
    80002058:	00813103          	ld	sp,8(sp)
    8000205c:	01013183          	ld	gp,16(sp)
    80002060:	02013283          	ld	t0,32(sp)
    80002064:	02813303          	ld	t1,40(sp)
    80002068:	03013383          	ld	t2,48(sp)
    8000206c:	03813403          	ld	s0,56(sp)
    80002070:	04013483          	ld	s1,64(sp)
    80002074:	04813503          	ld	a0,72(sp)
    80002078:	05013583          	ld	a1,80(sp)
    8000207c:	05813603          	ld	a2,88(sp)
    80002080:	06013683          	ld	a3,96(sp)
    80002084:	06813703          	ld	a4,104(sp)
    80002088:	07013783          	ld	a5,112(sp)
    8000208c:	07813803          	ld	a6,120(sp)
    80002090:	08013883          	ld	a7,128(sp)
    80002094:	08813903          	ld	s2,136(sp)
    80002098:	09013983          	ld	s3,144(sp)
    8000209c:	09813a03          	ld	s4,152(sp)
    800020a0:	0a013a83          	ld	s5,160(sp)
    800020a4:	0a813b03          	ld	s6,168(sp)
    800020a8:	0b013b83          	ld	s7,176(sp)
    800020ac:	0b813c03          	ld	s8,184(sp)
    800020b0:	0c013c83          	ld	s9,192(sp)
    800020b4:	0c813d03          	ld	s10,200(sp)
    800020b8:	0d013d83          	ld	s11,208(sp)
    800020bc:	0d813e03          	ld	t3,216(sp)
    800020c0:	0e013e83          	ld	t4,224(sp)
    800020c4:	0e813f03          	ld	t5,232(sp)
    800020c8:	0f013f83          	ld	t6,240(sp)
    800020cc:	10010113          	addi	sp,sp,256
    800020d0:	10200073          	sret
    800020d4:	00000013          	nop
    800020d8:	00000013          	nop
    800020dc:	00000013          	nop

00000000800020e0 <timervec>:
    800020e0:	34051573          	csrrw	a0,mscratch,a0
    800020e4:	00b53023          	sd	a1,0(a0)
    800020e8:	00c53423          	sd	a2,8(a0)
    800020ec:	00d53823          	sd	a3,16(a0)
    800020f0:	01853583          	ld	a1,24(a0)
    800020f4:	02053603          	ld	a2,32(a0)
    800020f8:	0005b683          	ld	a3,0(a1)
    800020fc:	00c686b3          	add	a3,a3,a2
    80002100:	00d5b023          	sd	a3,0(a1)
    80002104:	00200593          	li	a1,2
    80002108:	14459073          	csrw	sip,a1
    8000210c:	01053683          	ld	a3,16(a0)
    80002110:	00853603          	ld	a2,8(a0)
    80002114:	00053583          	ld	a1,0(a0)
    80002118:	34051573          	csrrw	a0,mscratch,a0
    8000211c:	30200073          	mret

0000000080002120 <plicinit>:
    80002120:	ff010113          	addi	sp,sp,-16
    80002124:	00813423          	sd	s0,8(sp)
    80002128:	01010413          	addi	s0,sp,16
    8000212c:	00813403          	ld	s0,8(sp)
    80002130:	0c0007b7          	lui	a5,0xc000
    80002134:	00100713          	li	a4,1
    80002138:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000213c:	00e7a223          	sw	a4,4(a5)
    80002140:	01010113          	addi	sp,sp,16
    80002144:	00008067          	ret

0000000080002148 <plicinithart>:
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00813023          	sd	s0,0(sp)
    80002150:	00113423          	sd	ra,8(sp)
    80002154:	01010413          	addi	s0,sp,16
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	a40080e7          	jalr	-1472(ra) # 80001b98 <cpuid>
    80002160:	0085171b          	slliw	a4,a0,0x8
    80002164:	0c0027b7          	lui	a5,0xc002
    80002168:	00e787b3          	add	a5,a5,a4
    8000216c:	40200713          	li	a4,1026
    80002170:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002174:	00813083          	ld	ra,8(sp)
    80002178:	00013403          	ld	s0,0(sp)
    8000217c:	00d5151b          	slliw	a0,a0,0xd
    80002180:	0c2017b7          	lui	a5,0xc201
    80002184:	00a78533          	add	a0,a5,a0
    80002188:	00052023          	sw	zero,0(a0)
    8000218c:	01010113          	addi	sp,sp,16
    80002190:	00008067          	ret

0000000080002194 <plic_claim>:
    80002194:	ff010113          	addi	sp,sp,-16
    80002198:	00813023          	sd	s0,0(sp)
    8000219c:	00113423          	sd	ra,8(sp)
    800021a0:	01010413          	addi	s0,sp,16
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	9f4080e7          	jalr	-1548(ra) # 80001b98 <cpuid>
    800021ac:	00813083          	ld	ra,8(sp)
    800021b0:	00013403          	ld	s0,0(sp)
    800021b4:	00d5151b          	slliw	a0,a0,0xd
    800021b8:	0c2017b7          	lui	a5,0xc201
    800021bc:	00a78533          	add	a0,a5,a0
    800021c0:	00452503          	lw	a0,4(a0)
    800021c4:	01010113          	addi	sp,sp,16
    800021c8:	00008067          	ret

00000000800021cc <plic_complete>:
    800021cc:	fe010113          	addi	sp,sp,-32
    800021d0:	00813823          	sd	s0,16(sp)
    800021d4:	00913423          	sd	s1,8(sp)
    800021d8:	00113c23          	sd	ra,24(sp)
    800021dc:	02010413          	addi	s0,sp,32
    800021e0:	00050493          	mv	s1,a0
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	9b4080e7          	jalr	-1612(ra) # 80001b98 <cpuid>
    800021ec:	01813083          	ld	ra,24(sp)
    800021f0:	01013403          	ld	s0,16(sp)
    800021f4:	00d5179b          	slliw	a5,a0,0xd
    800021f8:	0c201737          	lui	a4,0xc201
    800021fc:	00f707b3          	add	a5,a4,a5
    80002200:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002204:	00813483          	ld	s1,8(sp)
    80002208:	02010113          	addi	sp,sp,32
    8000220c:	00008067          	ret

0000000080002210 <consolewrite>:
    80002210:	fb010113          	addi	sp,sp,-80
    80002214:	04813023          	sd	s0,64(sp)
    80002218:	04113423          	sd	ra,72(sp)
    8000221c:	02913c23          	sd	s1,56(sp)
    80002220:	03213823          	sd	s2,48(sp)
    80002224:	03313423          	sd	s3,40(sp)
    80002228:	03413023          	sd	s4,32(sp)
    8000222c:	01513c23          	sd	s5,24(sp)
    80002230:	05010413          	addi	s0,sp,80
    80002234:	06c05c63          	blez	a2,800022ac <consolewrite+0x9c>
    80002238:	00060993          	mv	s3,a2
    8000223c:	00050a13          	mv	s4,a0
    80002240:	00058493          	mv	s1,a1
    80002244:	00000913          	li	s2,0
    80002248:	fff00a93          	li	s5,-1
    8000224c:	01c0006f          	j	80002268 <consolewrite+0x58>
    80002250:	fbf44503          	lbu	a0,-65(s0)
    80002254:	0019091b          	addiw	s2,s2,1
    80002258:	00148493          	addi	s1,s1,1
    8000225c:	00001097          	auipc	ra,0x1
    80002260:	a9c080e7          	jalr	-1380(ra) # 80002cf8 <uartputc>
    80002264:	03298063          	beq	s3,s2,80002284 <consolewrite+0x74>
    80002268:	00048613          	mv	a2,s1
    8000226c:	00100693          	li	a3,1
    80002270:	000a0593          	mv	a1,s4
    80002274:	fbf40513          	addi	a0,s0,-65
    80002278:	00000097          	auipc	ra,0x0
    8000227c:	9d8080e7          	jalr	-1576(ra) # 80001c50 <either_copyin>
    80002280:	fd5518e3          	bne	a0,s5,80002250 <consolewrite+0x40>
    80002284:	04813083          	ld	ra,72(sp)
    80002288:	04013403          	ld	s0,64(sp)
    8000228c:	03813483          	ld	s1,56(sp)
    80002290:	02813983          	ld	s3,40(sp)
    80002294:	02013a03          	ld	s4,32(sp)
    80002298:	01813a83          	ld	s5,24(sp)
    8000229c:	00090513          	mv	a0,s2
    800022a0:	03013903          	ld	s2,48(sp)
    800022a4:	05010113          	addi	sp,sp,80
    800022a8:	00008067          	ret
    800022ac:	00000913          	li	s2,0
    800022b0:	fd5ff06f          	j	80002284 <consolewrite+0x74>

00000000800022b4 <consoleread>:
    800022b4:	f9010113          	addi	sp,sp,-112
    800022b8:	06813023          	sd	s0,96(sp)
    800022bc:	04913c23          	sd	s1,88(sp)
    800022c0:	05213823          	sd	s2,80(sp)
    800022c4:	05313423          	sd	s3,72(sp)
    800022c8:	05413023          	sd	s4,64(sp)
    800022cc:	03513c23          	sd	s5,56(sp)
    800022d0:	03613823          	sd	s6,48(sp)
    800022d4:	03713423          	sd	s7,40(sp)
    800022d8:	03813023          	sd	s8,32(sp)
    800022dc:	06113423          	sd	ra,104(sp)
    800022e0:	01913c23          	sd	s9,24(sp)
    800022e4:	07010413          	addi	s0,sp,112
    800022e8:	00060b93          	mv	s7,a2
    800022ec:	00050913          	mv	s2,a0
    800022f0:	00058c13          	mv	s8,a1
    800022f4:	00060b1b          	sext.w	s6,a2
    800022f8:	00003497          	auipc	s1,0x3
    800022fc:	2f048493          	addi	s1,s1,752 # 800055e8 <cons>
    80002300:	00400993          	li	s3,4
    80002304:	fff00a13          	li	s4,-1
    80002308:	00a00a93          	li	s5,10
    8000230c:	05705e63          	blez	s7,80002368 <consoleread+0xb4>
    80002310:	09c4a703          	lw	a4,156(s1)
    80002314:	0984a783          	lw	a5,152(s1)
    80002318:	0007071b          	sext.w	a4,a4
    8000231c:	08e78463          	beq	a5,a4,800023a4 <consoleread+0xf0>
    80002320:	07f7f713          	andi	a4,a5,127
    80002324:	00e48733          	add	a4,s1,a4
    80002328:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000232c:	0017869b          	addiw	a3,a5,1
    80002330:	08d4ac23          	sw	a3,152(s1)
    80002334:	00070c9b          	sext.w	s9,a4
    80002338:	0b370663          	beq	a4,s3,800023e4 <consoleread+0x130>
    8000233c:	00100693          	li	a3,1
    80002340:	f9f40613          	addi	a2,s0,-97
    80002344:	000c0593          	mv	a1,s8
    80002348:	00090513          	mv	a0,s2
    8000234c:	f8e40fa3          	sb	a4,-97(s0)
    80002350:	00000097          	auipc	ra,0x0
    80002354:	8b4080e7          	jalr	-1868(ra) # 80001c04 <either_copyout>
    80002358:	01450863          	beq	a0,s4,80002368 <consoleread+0xb4>
    8000235c:	001c0c13          	addi	s8,s8,1
    80002360:	fffb8b9b          	addiw	s7,s7,-1
    80002364:	fb5c94e3          	bne	s9,s5,8000230c <consoleread+0x58>
    80002368:	000b851b          	sext.w	a0,s7
    8000236c:	06813083          	ld	ra,104(sp)
    80002370:	06013403          	ld	s0,96(sp)
    80002374:	05813483          	ld	s1,88(sp)
    80002378:	05013903          	ld	s2,80(sp)
    8000237c:	04813983          	ld	s3,72(sp)
    80002380:	04013a03          	ld	s4,64(sp)
    80002384:	03813a83          	ld	s5,56(sp)
    80002388:	02813b83          	ld	s7,40(sp)
    8000238c:	02013c03          	ld	s8,32(sp)
    80002390:	01813c83          	ld	s9,24(sp)
    80002394:	40ab053b          	subw	a0,s6,a0
    80002398:	03013b03          	ld	s6,48(sp)
    8000239c:	07010113          	addi	sp,sp,112
    800023a0:	00008067          	ret
    800023a4:	00001097          	auipc	ra,0x1
    800023a8:	1d8080e7          	jalr	472(ra) # 8000357c <push_on>
    800023ac:	0984a703          	lw	a4,152(s1)
    800023b0:	09c4a783          	lw	a5,156(s1)
    800023b4:	0007879b          	sext.w	a5,a5
    800023b8:	fef70ce3          	beq	a4,a5,800023b0 <consoleread+0xfc>
    800023bc:	00001097          	auipc	ra,0x1
    800023c0:	234080e7          	jalr	564(ra) # 800035f0 <pop_on>
    800023c4:	0984a783          	lw	a5,152(s1)
    800023c8:	07f7f713          	andi	a4,a5,127
    800023cc:	00e48733          	add	a4,s1,a4
    800023d0:	01874703          	lbu	a4,24(a4)
    800023d4:	0017869b          	addiw	a3,a5,1
    800023d8:	08d4ac23          	sw	a3,152(s1)
    800023dc:	00070c9b          	sext.w	s9,a4
    800023e0:	f5371ee3          	bne	a4,s3,8000233c <consoleread+0x88>
    800023e4:	000b851b          	sext.w	a0,s7
    800023e8:	f96bf2e3          	bgeu	s7,s6,8000236c <consoleread+0xb8>
    800023ec:	08f4ac23          	sw	a5,152(s1)
    800023f0:	f7dff06f          	j	8000236c <consoleread+0xb8>

00000000800023f4 <consputc>:
    800023f4:	10000793          	li	a5,256
    800023f8:	00f50663          	beq	a0,a5,80002404 <consputc+0x10>
    800023fc:	00001317          	auipc	t1,0x1
    80002400:	9f430067          	jr	-1548(t1) # 80002df0 <uartputc_sync>
    80002404:	ff010113          	addi	sp,sp,-16
    80002408:	00113423          	sd	ra,8(sp)
    8000240c:	00813023          	sd	s0,0(sp)
    80002410:	01010413          	addi	s0,sp,16
    80002414:	00800513          	li	a0,8
    80002418:	00001097          	auipc	ra,0x1
    8000241c:	9d8080e7          	jalr	-1576(ra) # 80002df0 <uartputc_sync>
    80002420:	02000513          	li	a0,32
    80002424:	00001097          	auipc	ra,0x1
    80002428:	9cc080e7          	jalr	-1588(ra) # 80002df0 <uartputc_sync>
    8000242c:	00013403          	ld	s0,0(sp)
    80002430:	00813083          	ld	ra,8(sp)
    80002434:	00800513          	li	a0,8
    80002438:	01010113          	addi	sp,sp,16
    8000243c:	00001317          	auipc	t1,0x1
    80002440:	9b430067          	jr	-1612(t1) # 80002df0 <uartputc_sync>

0000000080002444 <consoleintr>:
    80002444:	fe010113          	addi	sp,sp,-32
    80002448:	00813823          	sd	s0,16(sp)
    8000244c:	00913423          	sd	s1,8(sp)
    80002450:	01213023          	sd	s2,0(sp)
    80002454:	00113c23          	sd	ra,24(sp)
    80002458:	02010413          	addi	s0,sp,32
    8000245c:	00003917          	auipc	s2,0x3
    80002460:	18c90913          	addi	s2,s2,396 # 800055e8 <cons>
    80002464:	00050493          	mv	s1,a0
    80002468:	00090513          	mv	a0,s2
    8000246c:	00001097          	auipc	ra,0x1
    80002470:	e40080e7          	jalr	-448(ra) # 800032ac <acquire>
    80002474:	02048c63          	beqz	s1,800024ac <consoleintr+0x68>
    80002478:	0a092783          	lw	a5,160(s2)
    8000247c:	09892703          	lw	a4,152(s2)
    80002480:	07f00693          	li	a3,127
    80002484:	40e7873b          	subw	a4,a5,a4
    80002488:	02e6e263          	bltu	a3,a4,800024ac <consoleintr+0x68>
    8000248c:	00d00713          	li	a4,13
    80002490:	04e48063          	beq	s1,a4,800024d0 <consoleintr+0x8c>
    80002494:	07f7f713          	andi	a4,a5,127
    80002498:	00e90733          	add	a4,s2,a4
    8000249c:	0017879b          	addiw	a5,a5,1
    800024a0:	0af92023          	sw	a5,160(s2)
    800024a4:	00970c23          	sb	s1,24(a4)
    800024a8:	08f92e23          	sw	a5,156(s2)
    800024ac:	01013403          	ld	s0,16(sp)
    800024b0:	01813083          	ld	ra,24(sp)
    800024b4:	00813483          	ld	s1,8(sp)
    800024b8:	00013903          	ld	s2,0(sp)
    800024bc:	00003517          	auipc	a0,0x3
    800024c0:	12c50513          	addi	a0,a0,300 # 800055e8 <cons>
    800024c4:	02010113          	addi	sp,sp,32
    800024c8:	00001317          	auipc	t1,0x1
    800024cc:	eb030067          	jr	-336(t1) # 80003378 <release>
    800024d0:	00a00493          	li	s1,10
    800024d4:	fc1ff06f          	j	80002494 <consoleintr+0x50>

00000000800024d8 <consoleinit>:
    800024d8:	fe010113          	addi	sp,sp,-32
    800024dc:	00113c23          	sd	ra,24(sp)
    800024e0:	00813823          	sd	s0,16(sp)
    800024e4:	00913423          	sd	s1,8(sp)
    800024e8:	02010413          	addi	s0,sp,32
    800024ec:	00003497          	auipc	s1,0x3
    800024f0:	0fc48493          	addi	s1,s1,252 # 800055e8 <cons>
    800024f4:	00048513          	mv	a0,s1
    800024f8:	00002597          	auipc	a1,0x2
    800024fc:	c6058593          	addi	a1,a1,-928 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    80002500:	00001097          	auipc	ra,0x1
    80002504:	d88080e7          	jalr	-632(ra) # 80003288 <initlock>
    80002508:	00000097          	auipc	ra,0x0
    8000250c:	7ac080e7          	jalr	1964(ra) # 80002cb4 <uartinit>
    80002510:	01813083          	ld	ra,24(sp)
    80002514:	01013403          	ld	s0,16(sp)
    80002518:	00000797          	auipc	a5,0x0
    8000251c:	d9c78793          	addi	a5,a5,-612 # 800022b4 <consoleread>
    80002520:	0af4bc23          	sd	a5,184(s1)
    80002524:	00000797          	auipc	a5,0x0
    80002528:	cec78793          	addi	a5,a5,-788 # 80002210 <consolewrite>
    8000252c:	0cf4b023          	sd	a5,192(s1)
    80002530:	00813483          	ld	s1,8(sp)
    80002534:	02010113          	addi	sp,sp,32
    80002538:	00008067          	ret

000000008000253c <console_read>:
    8000253c:	ff010113          	addi	sp,sp,-16
    80002540:	00813423          	sd	s0,8(sp)
    80002544:	01010413          	addi	s0,sp,16
    80002548:	00813403          	ld	s0,8(sp)
    8000254c:	00003317          	auipc	t1,0x3
    80002550:	15433303          	ld	t1,340(t1) # 800056a0 <devsw+0x10>
    80002554:	01010113          	addi	sp,sp,16
    80002558:	00030067          	jr	t1

000000008000255c <console_write>:
    8000255c:	ff010113          	addi	sp,sp,-16
    80002560:	00813423          	sd	s0,8(sp)
    80002564:	01010413          	addi	s0,sp,16
    80002568:	00813403          	ld	s0,8(sp)
    8000256c:	00003317          	auipc	t1,0x3
    80002570:	13c33303          	ld	t1,316(t1) # 800056a8 <devsw+0x18>
    80002574:	01010113          	addi	sp,sp,16
    80002578:	00030067          	jr	t1

000000008000257c <panic>:
    8000257c:	fe010113          	addi	sp,sp,-32
    80002580:	00113c23          	sd	ra,24(sp)
    80002584:	00813823          	sd	s0,16(sp)
    80002588:	00913423          	sd	s1,8(sp)
    8000258c:	02010413          	addi	s0,sp,32
    80002590:	00050493          	mv	s1,a0
    80002594:	00002517          	auipc	a0,0x2
    80002598:	bcc50513          	addi	a0,a0,-1076 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    8000259c:	00003797          	auipc	a5,0x3
    800025a0:	1a07a623          	sw	zero,428(a5) # 80005748 <pr+0x18>
    800025a4:	00000097          	auipc	ra,0x0
    800025a8:	034080e7          	jalr	52(ra) # 800025d8 <__printf>
    800025ac:	00048513          	mv	a0,s1
    800025b0:	00000097          	auipc	ra,0x0
    800025b4:	028080e7          	jalr	40(ra) # 800025d8 <__printf>
    800025b8:	00002517          	auipc	a0,0x2
    800025bc:	b8850513          	addi	a0,a0,-1144 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    800025c0:	00000097          	auipc	ra,0x0
    800025c4:	018080e7          	jalr	24(ra) # 800025d8 <__printf>
    800025c8:	00100793          	li	a5,1
    800025cc:	00002717          	auipc	a4,0x2
    800025d0:	f0f72623          	sw	a5,-244(a4) # 800044d8 <panicked>
    800025d4:	0000006f          	j	800025d4 <panic+0x58>

00000000800025d8 <__printf>:
    800025d8:	f3010113          	addi	sp,sp,-208
    800025dc:	08813023          	sd	s0,128(sp)
    800025e0:	07313423          	sd	s3,104(sp)
    800025e4:	09010413          	addi	s0,sp,144
    800025e8:	05813023          	sd	s8,64(sp)
    800025ec:	08113423          	sd	ra,136(sp)
    800025f0:	06913c23          	sd	s1,120(sp)
    800025f4:	07213823          	sd	s2,112(sp)
    800025f8:	07413023          	sd	s4,96(sp)
    800025fc:	05513c23          	sd	s5,88(sp)
    80002600:	05613823          	sd	s6,80(sp)
    80002604:	05713423          	sd	s7,72(sp)
    80002608:	03913c23          	sd	s9,56(sp)
    8000260c:	03a13823          	sd	s10,48(sp)
    80002610:	03b13423          	sd	s11,40(sp)
    80002614:	00003317          	auipc	t1,0x3
    80002618:	11c30313          	addi	t1,t1,284 # 80005730 <pr>
    8000261c:	01832c03          	lw	s8,24(t1)
    80002620:	00b43423          	sd	a1,8(s0)
    80002624:	00c43823          	sd	a2,16(s0)
    80002628:	00d43c23          	sd	a3,24(s0)
    8000262c:	02e43023          	sd	a4,32(s0)
    80002630:	02f43423          	sd	a5,40(s0)
    80002634:	03043823          	sd	a6,48(s0)
    80002638:	03143c23          	sd	a7,56(s0)
    8000263c:	00050993          	mv	s3,a0
    80002640:	4a0c1663          	bnez	s8,80002aec <__printf+0x514>
    80002644:	60098c63          	beqz	s3,80002c5c <__printf+0x684>
    80002648:	0009c503          	lbu	a0,0(s3)
    8000264c:	00840793          	addi	a5,s0,8
    80002650:	f6f43c23          	sd	a5,-136(s0)
    80002654:	00000493          	li	s1,0
    80002658:	22050063          	beqz	a0,80002878 <__printf+0x2a0>
    8000265c:	00002a37          	lui	s4,0x2
    80002660:	00018ab7          	lui	s5,0x18
    80002664:	000f4b37          	lui	s6,0xf4
    80002668:	00989bb7          	lui	s7,0x989
    8000266c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002670:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002674:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002678:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000267c:	00148c9b          	addiw	s9,s1,1
    80002680:	02500793          	li	a5,37
    80002684:	01998933          	add	s2,s3,s9
    80002688:	38f51263          	bne	a0,a5,80002a0c <__printf+0x434>
    8000268c:	00094783          	lbu	a5,0(s2)
    80002690:	00078c9b          	sext.w	s9,a5
    80002694:	1e078263          	beqz	a5,80002878 <__printf+0x2a0>
    80002698:	0024849b          	addiw	s1,s1,2
    8000269c:	07000713          	li	a4,112
    800026a0:	00998933          	add	s2,s3,s1
    800026a4:	38e78a63          	beq	a5,a4,80002a38 <__printf+0x460>
    800026a8:	20f76863          	bltu	a4,a5,800028b8 <__printf+0x2e0>
    800026ac:	42a78863          	beq	a5,a0,80002adc <__printf+0x504>
    800026b0:	06400713          	li	a4,100
    800026b4:	40e79663          	bne	a5,a4,80002ac0 <__printf+0x4e8>
    800026b8:	f7843783          	ld	a5,-136(s0)
    800026bc:	0007a603          	lw	a2,0(a5)
    800026c0:	00878793          	addi	a5,a5,8
    800026c4:	f6f43c23          	sd	a5,-136(s0)
    800026c8:	42064a63          	bltz	a2,80002afc <__printf+0x524>
    800026cc:	00a00713          	li	a4,10
    800026d0:	02e677bb          	remuw	a5,a2,a4
    800026d4:	00002d97          	auipc	s11,0x2
    800026d8:	ab4d8d93          	addi	s11,s11,-1356 # 80004188 <digits>
    800026dc:	00900593          	li	a1,9
    800026e0:	0006051b          	sext.w	a0,a2
    800026e4:	00000c93          	li	s9,0
    800026e8:	02079793          	slli	a5,a5,0x20
    800026ec:	0207d793          	srli	a5,a5,0x20
    800026f0:	00fd87b3          	add	a5,s11,a5
    800026f4:	0007c783          	lbu	a5,0(a5)
    800026f8:	02e656bb          	divuw	a3,a2,a4
    800026fc:	f8f40023          	sb	a5,-128(s0)
    80002700:	14c5d863          	bge	a1,a2,80002850 <__printf+0x278>
    80002704:	06300593          	li	a1,99
    80002708:	00100c93          	li	s9,1
    8000270c:	02e6f7bb          	remuw	a5,a3,a4
    80002710:	02079793          	slli	a5,a5,0x20
    80002714:	0207d793          	srli	a5,a5,0x20
    80002718:	00fd87b3          	add	a5,s11,a5
    8000271c:	0007c783          	lbu	a5,0(a5)
    80002720:	02e6d73b          	divuw	a4,a3,a4
    80002724:	f8f400a3          	sb	a5,-127(s0)
    80002728:	12a5f463          	bgeu	a1,a0,80002850 <__printf+0x278>
    8000272c:	00a00693          	li	a3,10
    80002730:	00900593          	li	a1,9
    80002734:	02d777bb          	remuw	a5,a4,a3
    80002738:	02079793          	slli	a5,a5,0x20
    8000273c:	0207d793          	srli	a5,a5,0x20
    80002740:	00fd87b3          	add	a5,s11,a5
    80002744:	0007c503          	lbu	a0,0(a5)
    80002748:	02d757bb          	divuw	a5,a4,a3
    8000274c:	f8a40123          	sb	a0,-126(s0)
    80002750:	48e5f263          	bgeu	a1,a4,80002bd4 <__printf+0x5fc>
    80002754:	06300513          	li	a0,99
    80002758:	02d7f5bb          	remuw	a1,a5,a3
    8000275c:	02059593          	slli	a1,a1,0x20
    80002760:	0205d593          	srli	a1,a1,0x20
    80002764:	00bd85b3          	add	a1,s11,a1
    80002768:	0005c583          	lbu	a1,0(a1)
    8000276c:	02d7d7bb          	divuw	a5,a5,a3
    80002770:	f8b401a3          	sb	a1,-125(s0)
    80002774:	48e57263          	bgeu	a0,a4,80002bf8 <__printf+0x620>
    80002778:	3e700513          	li	a0,999
    8000277c:	02d7f5bb          	remuw	a1,a5,a3
    80002780:	02059593          	slli	a1,a1,0x20
    80002784:	0205d593          	srli	a1,a1,0x20
    80002788:	00bd85b3          	add	a1,s11,a1
    8000278c:	0005c583          	lbu	a1,0(a1)
    80002790:	02d7d7bb          	divuw	a5,a5,a3
    80002794:	f8b40223          	sb	a1,-124(s0)
    80002798:	46e57663          	bgeu	a0,a4,80002c04 <__printf+0x62c>
    8000279c:	02d7f5bb          	remuw	a1,a5,a3
    800027a0:	02059593          	slli	a1,a1,0x20
    800027a4:	0205d593          	srli	a1,a1,0x20
    800027a8:	00bd85b3          	add	a1,s11,a1
    800027ac:	0005c583          	lbu	a1,0(a1)
    800027b0:	02d7d7bb          	divuw	a5,a5,a3
    800027b4:	f8b402a3          	sb	a1,-123(s0)
    800027b8:	46ea7863          	bgeu	s4,a4,80002c28 <__printf+0x650>
    800027bc:	02d7f5bb          	remuw	a1,a5,a3
    800027c0:	02059593          	slli	a1,a1,0x20
    800027c4:	0205d593          	srli	a1,a1,0x20
    800027c8:	00bd85b3          	add	a1,s11,a1
    800027cc:	0005c583          	lbu	a1,0(a1)
    800027d0:	02d7d7bb          	divuw	a5,a5,a3
    800027d4:	f8b40323          	sb	a1,-122(s0)
    800027d8:	3eeaf863          	bgeu	s5,a4,80002bc8 <__printf+0x5f0>
    800027dc:	02d7f5bb          	remuw	a1,a5,a3
    800027e0:	02059593          	slli	a1,a1,0x20
    800027e4:	0205d593          	srli	a1,a1,0x20
    800027e8:	00bd85b3          	add	a1,s11,a1
    800027ec:	0005c583          	lbu	a1,0(a1)
    800027f0:	02d7d7bb          	divuw	a5,a5,a3
    800027f4:	f8b403a3          	sb	a1,-121(s0)
    800027f8:	42eb7e63          	bgeu	s6,a4,80002c34 <__printf+0x65c>
    800027fc:	02d7f5bb          	remuw	a1,a5,a3
    80002800:	02059593          	slli	a1,a1,0x20
    80002804:	0205d593          	srli	a1,a1,0x20
    80002808:	00bd85b3          	add	a1,s11,a1
    8000280c:	0005c583          	lbu	a1,0(a1)
    80002810:	02d7d7bb          	divuw	a5,a5,a3
    80002814:	f8b40423          	sb	a1,-120(s0)
    80002818:	42ebfc63          	bgeu	s7,a4,80002c50 <__printf+0x678>
    8000281c:	02079793          	slli	a5,a5,0x20
    80002820:	0207d793          	srli	a5,a5,0x20
    80002824:	00fd8db3          	add	s11,s11,a5
    80002828:	000dc703          	lbu	a4,0(s11)
    8000282c:	00a00793          	li	a5,10
    80002830:	00900c93          	li	s9,9
    80002834:	f8e404a3          	sb	a4,-119(s0)
    80002838:	00065c63          	bgez	a2,80002850 <__printf+0x278>
    8000283c:	f9040713          	addi	a4,s0,-112
    80002840:	00f70733          	add	a4,a4,a5
    80002844:	02d00693          	li	a3,45
    80002848:	fed70823          	sb	a3,-16(a4)
    8000284c:	00078c93          	mv	s9,a5
    80002850:	f8040793          	addi	a5,s0,-128
    80002854:	01978cb3          	add	s9,a5,s9
    80002858:	f7f40d13          	addi	s10,s0,-129
    8000285c:	000cc503          	lbu	a0,0(s9)
    80002860:	fffc8c93          	addi	s9,s9,-1
    80002864:	00000097          	auipc	ra,0x0
    80002868:	b90080e7          	jalr	-1136(ra) # 800023f4 <consputc>
    8000286c:	ffac98e3          	bne	s9,s10,8000285c <__printf+0x284>
    80002870:	00094503          	lbu	a0,0(s2)
    80002874:	e00514e3          	bnez	a0,8000267c <__printf+0xa4>
    80002878:	1a0c1663          	bnez	s8,80002a24 <__printf+0x44c>
    8000287c:	08813083          	ld	ra,136(sp)
    80002880:	08013403          	ld	s0,128(sp)
    80002884:	07813483          	ld	s1,120(sp)
    80002888:	07013903          	ld	s2,112(sp)
    8000288c:	06813983          	ld	s3,104(sp)
    80002890:	06013a03          	ld	s4,96(sp)
    80002894:	05813a83          	ld	s5,88(sp)
    80002898:	05013b03          	ld	s6,80(sp)
    8000289c:	04813b83          	ld	s7,72(sp)
    800028a0:	04013c03          	ld	s8,64(sp)
    800028a4:	03813c83          	ld	s9,56(sp)
    800028a8:	03013d03          	ld	s10,48(sp)
    800028ac:	02813d83          	ld	s11,40(sp)
    800028b0:	0d010113          	addi	sp,sp,208
    800028b4:	00008067          	ret
    800028b8:	07300713          	li	a4,115
    800028bc:	1ce78a63          	beq	a5,a4,80002a90 <__printf+0x4b8>
    800028c0:	07800713          	li	a4,120
    800028c4:	1ee79e63          	bne	a5,a4,80002ac0 <__printf+0x4e8>
    800028c8:	f7843783          	ld	a5,-136(s0)
    800028cc:	0007a703          	lw	a4,0(a5)
    800028d0:	00878793          	addi	a5,a5,8
    800028d4:	f6f43c23          	sd	a5,-136(s0)
    800028d8:	28074263          	bltz	a4,80002b5c <__printf+0x584>
    800028dc:	00002d97          	auipc	s11,0x2
    800028e0:	8acd8d93          	addi	s11,s11,-1876 # 80004188 <digits>
    800028e4:	00f77793          	andi	a5,a4,15
    800028e8:	00fd87b3          	add	a5,s11,a5
    800028ec:	0007c683          	lbu	a3,0(a5)
    800028f0:	00f00613          	li	a2,15
    800028f4:	0007079b          	sext.w	a5,a4
    800028f8:	f8d40023          	sb	a3,-128(s0)
    800028fc:	0047559b          	srliw	a1,a4,0x4
    80002900:	0047569b          	srliw	a3,a4,0x4
    80002904:	00000c93          	li	s9,0
    80002908:	0ee65063          	bge	a2,a4,800029e8 <__printf+0x410>
    8000290c:	00f6f693          	andi	a3,a3,15
    80002910:	00dd86b3          	add	a3,s11,a3
    80002914:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002918:	0087d79b          	srliw	a5,a5,0x8
    8000291c:	00100c93          	li	s9,1
    80002920:	f8d400a3          	sb	a3,-127(s0)
    80002924:	0cb67263          	bgeu	a2,a1,800029e8 <__printf+0x410>
    80002928:	00f7f693          	andi	a3,a5,15
    8000292c:	00dd86b3          	add	a3,s11,a3
    80002930:	0006c583          	lbu	a1,0(a3)
    80002934:	00f00613          	li	a2,15
    80002938:	0047d69b          	srliw	a3,a5,0x4
    8000293c:	f8b40123          	sb	a1,-126(s0)
    80002940:	0047d593          	srli	a1,a5,0x4
    80002944:	28f67e63          	bgeu	a2,a5,80002be0 <__printf+0x608>
    80002948:	00f6f693          	andi	a3,a3,15
    8000294c:	00dd86b3          	add	a3,s11,a3
    80002950:	0006c503          	lbu	a0,0(a3)
    80002954:	0087d813          	srli	a6,a5,0x8
    80002958:	0087d69b          	srliw	a3,a5,0x8
    8000295c:	f8a401a3          	sb	a0,-125(s0)
    80002960:	28b67663          	bgeu	a2,a1,80002bec <__printf+0x614>
    80002964:	00f6f693          	andi	a3,a3,15
    80002968:	00dd86b3          	add	a3,s11,a3
    8000296c:	0006c583          	lbu	a1,0(a3)
    80002970:	00c7d513          	srli	a0,a5,0xc
    80002974:	00c7d69b          	srliw	a3,a5,0xc
    80002978:	f8b40223          	sb	a1,-124(s0)
    8000297c:	29067a63          	bgeu	a2,a6,80002c10 <__printf+0x638>
    80002980:	00f6f693          	andi	a3,a3,15
    80002984:	00dd86b3          	add	a3,s11,a3
    80002988:	0006c583          	lbu	a1,0(a3)
    8000298c:	0107d813          	srli	a6,a5,0x10
    80002990:	0107d69b          	srliw	a3,a5,0x10
    80002994:	f8b402a3          	sb	a1,-123(s0)
    80002998:	28a67263          	bgeu	a2,a0,80002c1c <__printf+0x644>
    8000299c:	00f6f693          	andi	a3,a3,15
    800029a0:	00dd86b3          	add	a3,s11,a3
    800029a4:	0006c683          	lbu	a3,0(a3)
    800029a8:	0147d79b          	srliw	a5,a5,0x14
    800029ac:	f8d40323          	sb	a3,-122(s0)
    800029b0:	21067663          	bgeu	a2,a6,80002bbc <__printf+0x5e4>
    800029b4:	02079793          	slli	a5,a5,0x20
    800029b8:	0207d793          	srli	a5,a5,0x20
    800029bc:	00fd8db3          	add	s11,s11,a5
    800029c0:	000dc683          	lbu	a3,0(s11)
    800029c4:	00800793          	li	a5,8
    800029c8:	00700c93          	li	s9,7
    800029cc:	f8d403a3          	sb	a3,-121(s0)
    800029d0:	00075c63          	bgez	a4,800029e8 <__printf+0x410>
    800029d4:	f9040713          	addi	a4,s0,-112
    800029d8:	00f70733          	add	a4,a4,a5
    800029dc:	02d00693          	li	a3,45
    800029e0:	fed70823          	sb	a3,-16(a4)
    800029e4:	00078c93          	mv	s9,a5
    800029e8:	f8040793          	addi	a5,s0,-128
    800029ec:	01978cb3          	add	s9,a5,s9
    800029f0:	f7f40d13          	addi	s10,s0,-129
    800029f4:	000cc503          	lbu	a0,0(s9)
    800029f8:	fffc8c93          	addi	s9,s9,-1
    800029fc:	00000097          	auipc	ra,0x0
    80002a00:	9f8080e7          	jalr	-1544(ra) # 800023f4 <consputc>
    80002a04:	ff9d18e3          	bne	s10,s9,800029f4 <__printf+0x41c>
    80002a08:	0100006f          	j	80002a18 <__printf+0x440>
    80002a0c:	00000097          	auipc	ra,0x0
    80002a10:	9e8080e7          	jalr	-1560(ra) # 800023f4 <consputc>
    80002a14:	000c8493          	mv	s1,s9
    80002a18:	00094503          	lbu	a0,0(s2)
    80002a1c:	c60510e3          	bnez	a0,8000267c <__printf+0xa4>
    80002a20:	e40c0ee3          	beqz	s8,8000287c <__printf+0x2a4>
    80002a24:	00003517          	auipc	a0,0x3
    80002a28:	d0c50513          	addi	a0,a0,-756 # 80005730 <pr>
    80002a2c:	00001097          	auipc	ra,0x1
    80002a30:	94c080e7          	jalr	-1716(ra) # 80003378 <release>
    80002a34:	e49ff06f          	j	8000287c <__printf+0x2a4>
    80002a38:	f7843783          	ld	a5,-136(s0)
    80002a3c:	03000513          	li	a0,48
    80002a40:	01000d13          	li	s10,16
    80002a44:	00878713          	addi	a4,a5,8
    80002a48:	0007bc83          	ld	s9,0(a5)
    80002a4c:	f6e43c23          	sd	a4,-136(s0)
    80002a50:	00000097          	auipc	ra,0x0
    80002a54:	9a4080e7          	jalr	-1628(ra) # 800023f4 <consputc>
    80002a58:	07800513          	li	a0,120
    80002a5c:	00000097          	auipc	ra,0x0
    80002a60:	998080e7          	jalr	-1640(ra) # 800023f4 <consputc>
    80002a64:	00001d97          	auipc	s11,0x1
    80002a68:	724d8d93          	addi	s11,s11,1828 # 80004188 <digits>
    80002a6c:	03ccd793          	srli	a5,s9,0x3c
    80002a70:	00fd87b3          	add	a5,s11,a5
    80002a74:	0007c503          	lbu	a0,0(a5)
    80002a78:	fffd0d1b          	addiw	s10,s10,-1
    80002a7c:	004c9c93          	slli	s9,s9,0x4
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	974080e7          	jalr	-1676(ra) # 800023f4 <consputc>
    80002a88:	fe0d12e3          	bnez	s10,80002a6c <__printf+0x494>
    80002a8c:	f8dff06f          	j	80002a18 <__printf+0x440>
    80002a90:	f7843783          	ld	a5,-136(s0)
    80002a94:	0007bc83          	ld	s9,0(a5)
    80002a98:	00878793          	addi	a5,a5,8
    80002a9c:	f6f43c23          	sd	a5,-136(s0)
    80002aa0:	000c9a63          	bnez	s9,80002ab4 <__printf+0x4dc>
    80002aa4:	1080006f          	j	80002bac <__printf+0x5d4>
    80002aa8:	001c8c93          	addi	s9,s9,1
    80002aac:	00000097          	auipc	ra,0x0
    80002ab0:	948080e7          	jalr	-1720(ra) # 800023f4 <consputc>
    80002ab4:	000cc503          	lbu	a0,0(s9)
    80002ab8:	fe0518e3          	bnez	a0,80002aa8 <__printf+0x4d0>
    80002abc:	f5dff06f          	j	80002a18 <__printf+0x440>
    80002ac0:	02500513          	li	a0,37
    80002ac4:	00000097          	auipc	ra,0x0
    80002ac8:	930080e7          	jalr	-1744(ra) # 800023f4 <consputc>
    80002acc:	000c8513          	mv	a0,s9
    80002ad0:	00000097          	auipc	ra,0x0
    80002ad4:	924080e7          	jalr	-1756(ra) # 800023f4 <consputc>
    80002ad8:	f41ff06f          	j	80002a18 <__printf+0x440>
    80002adc:	02500513          	li	a0,37
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	914080e7          	jalr	-1772(ra) # 800023f4 <consputc>
    80002ae8:	f31ff06f          	j	80002a18 <__printf+0x440>
    80002aec:	00030513          	mv	a0,t1
    80002af0:	00000097          	auipc	ra,0x0
    80002af4:	7bc080e7          	jalr	1980(ra) # 800032ac <acquire>
    80002af8:	b4dff06f          	j	80002644 <__printf+0x6c>
    80002afc:	40c0053b          	negw	a0,a2
    80002b00:	00a00713          	li	a4,10
    80002b04:	02e576bb          	remuw	a3,a0,a4
    80002b08:	00001d97          	auipc	s11,0x1
    80002b0c:	680d8d93          	addi	s11,s11,1664 # 80004188 <digits>
    80002b10:	ff700593          	li	a1,-9
    80002b14:	02069693          	slli	a3,a3,0x20
    80002b18:	0206d693          	srli	a3,a3,0x20
    80002b1c:	00dd86b3          	add	a3,s11,a3
    80002b20:	0006c683          	lbu	a3,0(a3)
    80002b24:	02e557bb          	divuw	a5,a0,a4
    80002b28:	f8d40023          	sb	a3,-128(s0)
    80002b2c:	10b65e63          	bge	a2,a1,80002c48 <__printf+0x670>
    80002b30:	06300593          	li	a1,99
    80002b34:	02e7f6bb          	remuw	a3,a5,a4
    80002b38:	02069693          	slli	a3,a3,0x20
    80002b3c:	0206d693          	srli	a3,a3,0x20
    80002b40:	00dd86b3          	add	a3,s11,a3
    80002b44:	0006c683          	lbu	a3,0(a3)
    80002b48:	02e7d73b          	divuw	a4,a5,a4
    80002b4c:	00200793          	li	a5,2
    80002b50:	f8d400a3          	sb	a3,-127(s0)
    80002b54:	bca5ece3          	bltu	a1,a0,8000272c <__printf+0x154>
    80002b58:	ce5ff06f          	j	8000283c <__printf+0x264>
    80002b5c:	40e007bb          	negw	a5,a4
    80002b60:	00001d97          	auipc	s11,0x1
    80002b64:	628d8d93          	addi	s11,s11,1576 # 80004188 <digits>
    80002b68:	00f7f693          	andi	a3,a5,15
    80002b6c:	00dd86b3          	add	a3,s11,a3
    80002b70:	0006c583          	lbu	a1,0(a3)
    80002b74:	ff100613          	li	a2,-15
    80002b78:	0047d69b          	srliw	a3,a5,0x4
    80002b7c:	f8b40023          	sb	a1,-128(s0)
    80002b80:	0047d59b          	srliw	a1,a5,0x4
    80002b84:	0ac75e63          	bge	a4,a2,80002c40 <__printf+0x668>
    80002b88:	00f6f693          	andi	a3,a3,15
    80002b8c:	00dd86b3          	add	a3,s11,a3
    80002b90:	0006c603          	lbu	a2,0(a3)
    80002b94:	00f00693          	li	a3,15
    80002b98:	0087d79b          	srliw	a5,a5,0x8
    80002b9c:	f8c400a3          	sb	a2,-127(s0)
    80002ba0:	d8b6e4e3          	bltu	a3,a1,80002928 <__printf+0x350>
    80002ba4:	00200793          	li	a5,2
    80002ba8:	e2dff06f          	j	800029d4 <__printf+0x3fc>
    80002bac:	00001c97          	auipc	s9,0x1
    80002bb0:	5bcc8c93          	addi	s9,s9,1468 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    80002bb4:	02800513          	li	a0,40
    80002bb8:	ef1ff06f          	j	80002aa8 <__printf+0x4d0>
    80002bbc:	00700793          	li	a5,7
    80002bc0:	00600c93          	li	s9,6
    80002bc4:	e0dff06f          	j	800029d0 <__printf+0x3f8>
    80002bc8:	00700793          	li	a5,7
    80002bcc:	00600c93          	li	s9,6
    80002bd0:	c69ff06f          	j	80002838 <__printf+0x260>
    80002bd4:	00300793          	li	a5,3
    80002bd8:	00200c93          	li	s9,2
    80002bdc:	c5dff06f          	j	80002838 <__printf+0x260>
    80002be0:	00300793          	li	a5,3
    80002be4:	00200c93          	li	s9,2
    80002be8:	de9ff06f          	j	800029d0 <__printf+0x3f8>
    80002bec:	00400793          	li	a5,4
    80002bf0:	00300c93          	li	s9,3
    80002bf4:	dddff06f          	j	800029d0 <__printf+0x3f8>
    80002bf8:	00400793          	li	a5,4
    80002bfc:	00300c93          	li	s9,3
    80002c00:	c39ff06f          	j	80002838 <__printf+0x260>
    80002c04:	00500793          	li	a5,5
    80002c08:	00400c93          	li	s9,4
    80002c0c:	c2dff06f          	j	80002838 <__printf+0x260>
    80002c10:	00500793          	li	a5,5
    80002c14:	00400c93          	li	s9,4
    80002c18:	db9ff06f          	j	800029d0 <__printf+0x3f8>
    80002c1c:	00600793          	li	a5,6
    80002c20:	00500c93          	li	s9,5
    80002c24:	dadff06f          	j	800029d0 <__printf+0x3f8>
    80002c28:	00600793          	li	a5,6
    80002c2c:	00500c93          	li	s9,5
    80002c30:	c09ff06f          	j	80002838 <__printf+0x260>
    80002c34:	00800793          	li	a5,8
    80002c38:	00700c93          	li	s9,7
    80002c3c:	bfdff06f          	j	80002838 <__printf+0x260>
    80002c40:	00100793          	li	a5,1
    80002c44:	d91ff06f          	j	800029d4 <__printf+0x3fc>
    80002c48:	00100793          	li	a5,1
    80002c4c:	bf1ff06f          	j	8000283c <__printf+0x264>
    80002c50:	00900793          	li	a5,9
    80002c54:	00800c93          	li	s9,8
    80002c58:	be1ff06f          	j	80002838 <__printf+0x260>
    80002c5c:	00001517          	auipc	a0,0x1
    80002c60:	51450513          	addi	a0,a0,1300 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002c64:	00000097          	auipc	ra,0x0
    80002c68:	918080e7          	jalr	-1768(ra) # 8000257c <panic>

0000000080002c6c <printfinit>:
    80002c6c:	fe010113          	addi	sp,sp,-32
    80002c70:	00813823          	sd	s0,16(sp)
    80002c74:	00913423          	sd	s1,8(sp)
    80002c78:	00113c23          	sd	ra,24(sp)
    80002c7c:	02010413          	addi	s0,sp,32
    80002c80:	00003497          	auipc	s1,0x3
    80002c84:	ab048493          	addi	s1,s1,-1360 # 80005730 <pr>
    80002c88:	00048513          	mv	a0,s1
    80002c8c:	00001597          	auipc	a1,0x1
    80002c90:	4f458593          	addi	a1,a1,1268 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    80002c94:	00000097          	auipc	ra,0x0
    80002c98:	5f4080e7          	jalr	1524(ra) # 80003288 <initlock>
    80002c9c:	01813083          	ld	ra,24(sp)
    80002ca0:	01013403          	ld	s0,16(sp)
    80002ca4:	0004ac23          	sw	zero,24(s1)
    80002ca8:	00813483          	ld	s1,8(sp)
    80002cac:	02010113          	addi	sp,sp,32
    80002cb0:	00008067          	ret

0000000080002cb4 <uartinit>:
    80002cb4:	ff010113          	addi	sp,sp,-16
    80002cb8:	00813423          	sd	s0,8(sp)
    80002cbc:	01010413          	addi	s0,sp,16
    80002cc0:	100007b7          	lui	a5,0x10000
    80002cc4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002cc8:	f8000713          	li	a4,-128
    80002ccc:	00e781a3          	sb	a4,3(a5)
    80002cd0:	00300713          	li	a4,3
    80002cd4:	00e78023          	sb	a4,0(a5)
    80002cd8:	000780a3          	sb	zero,1(a5)
    80002cdc:	00e781a3          	sb	a4,3(a5)
    80002ce0:	00700693          	li	a3,7
    80002ce4:	00d78123          	sb	a3,2(a5)
    80002ce8:	00e780a3          	sb	a4,1(a5)
    80002cec:	00813403          	ld	s0,8(sp)
    80002cf0:	01010113          	addi	sp,sp,16
    80002cf4:	00008067          	ret

0000000080002cf8 <uartputc>:
    80002cf8:	00001797          	auipc	a5,0x1
    80002cfc:	7e07a783          	lw	a5,2016(a5) # 800044d8 <panicked>
    80002d00:	00078463          	beqz	a5,80002d08 <uartputc+0x10>
    80002d04:	0000006f          	j	80002d04 <uartputc+0xc>
    80002d08:	fd010113          	addi	sp,sp,-48
    80002d0c:	02813023          	sd	s0,32(sp)
    80002d10:	00913c23          	sd	s1,24(sp)
    80002d14:	01213823          	sd	s2,16(sp)
    80002d18:	01313423          	sd	s3,8(sp)
    80002d1c:	02113423          	sd	ra,40(sp)
    80002d20:	03010413          	addi	s0,sp,48
    80002d24:	00001917          	auipc	s2,0x1
    80002d28:	7bc90913          	addi	s2,s2,1980 # 800044e0 <uart_tx_r>
    80002d2c:	00093783          	ld	a5,0(s2)
    80002d30:	00001497          	auipc	s1,0x1
    80002d34:	7b848493          	addi	s1,s1,1976 # 800044e8 <uart_tx_w>
    80002d38:	0004b703          	ld	a4,0(s1)
    80002d3c:	02078693          	addi	a3,a5,32
    80002d40:	00050993          	mv	s3,a0
    80002d44:	02e69c63          	bne	a3,a4,80002d7c <uartputc+0x84>
    80002d48:	00001097          	auipc	ra,0x1
    80002d4c:	834080e7          	jalr	-1996(ra) # 8000357c <push_on>
    80002d50:	00093783          	ld	a5,0(s2)
    80002d54:	0004b703          	ld	a4,0(s1)
    80002d58:	02078793          	addi	a5,a5,32
    80002d5c:	00e79463          	bne	a5,a4,80002d64 <uartputc+0x6c>
    80002d60:	0000006f          	j	80002d60 <uartputc+0x68>
    80002d64:	00001097          	auipc	ra,0x1
    80002d68:	88c080e7          	jalr	-1908(ra) # 800035f0 <pop_on>
    80002d6c:	00093783          	ld	a5,0(s2)
    80002d70:	0004b703          	ld	a4,0(s1)
    80002d74:	02078693          	addi	a3,a5,32
    80002d78:	fce688e3          	beq	a3,a4,80002d48 <uartputc+0x50>
    80002d7c:	01f77693          	andi	a3,a4,31
    80002d80:	00003597          	auipc	a1,0x3
    80002d84:	9d058593          	addi	a1,a1,-1584 # 80005750 <uart_tx_buf>
    80002d88:	00d586b3          	add	a3,a1,a3
    80002d8c:	00170713          	addi	a4,a4,1
    80002d90:	01368023          	sb	s3,0(a3)
    80002d94:	00e4b023          	sd	a4,0(s1)
    80002d98:	10000637          	lui	a2,0x10000
    80002d9c:	02f71063          	bne	a4,a5,80002dbc <uartputc+0xc4>
    80002da0:	0340006f          	j	80002dd4 <uartputc+0xdc>
    80002da4:	00074703          	lbu	a4,0(a4)
    80002da8:	00f93023          	sd	a5,0(s2)
    80002dac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002db0:	00093783          	ld	a5,0(s2)
    80002db4:	0004b703          	ld	a4,0(s1)
    80002db8:	00f70e63          	beq	a4,a5,80002dd4 <uartputc+0xdc>
    80002dbc:	00564683          	lbu	a3,5(a2)
    80002dc0:	01f7f713          	andi	a4,a5,31
    80002dc4:	00e58733          	add	a4,a1,a4
    80002dc8:	0206f693          	andi	a3,a3,32
    80002dcc:	00178793          	addi	a5,a5,1
    80002dd0:	fc069ae3          	bnez	a3,80002da4 <uartputc+0xac>
    80002dd4:	02813083          	ld	ra,40(sp)
    80002dd8:	02013403          	ld	s0,32(sp)
    80002ddc:	01813483          	ld	s1,24(sp)
    80002de0:	01013903          	ld	s2,16(sp)
    80002de4:	00813983          	ld	s3,8(sp)
    80002de8:	03010113          	addi	sp,sp,48
    80002dec:	00008067          	ret

0000000080002df0 <uartputc_sync>:
    80002df0:	ff010113          	addi	sp,sp,-16
    80002df4:	00813423          	sd	s0,8(sp)
    80002df8:	01010413          	addi	s0,sp,16
    80002dfc:	00001717          	auipc	a4,0x1
    80002e00:	6dc72703          	lw	a4,1756(a4) # 800044d8 <panicked>
    80002e04:	02071663          	bnez	a4,80002e30 <uartputc_sync+0x40>
    80002e08:	00050793          	mv	a5,a0
    80002e0c:	100006b7          	lui	a3,0x10000
    80002e10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002e14:	02077713          	andi	a4,a4,32
    80002e18:	fe070ce3          	beqz	a4,80002e10 <uartputc_sync+0x20>
    80002e1c:	0ff7f793          	andi	a5,a5,255
    80002e20:	00f68023          	sb	a5,0(a3)
    80002e24:	00813403          	ld	s0,8(sp)
    80002e28:	01010113          	addi	sp,sp,16
    80002e2c:	00008067          	ret
    80002e30:	0000006f          	j	80002e30 <uartputc_sync+0x40>

0000000080002e34 <uartstart>:
    80002e34:	ff010113          	addi	sp,sp,-16
    80002e38:	00813423          	sd	s0,8(sp)
    80002e3c:	01010413          	addi	s0,sp,16
    80002e40:	00001617          	auipc	a2,0x1
    80002e44:	6a060613          	addi	a2,a2,1696 # 800044e0 <uart_tx_r>
    80002e48:	00001517          	auipc	a0,0x1
    80002e4c:	6a050513          	addi	a0,a0,1696 # 800044e8 <uart_tx_w>
    80002e50:	00063783          	ld	a5,0(a2)
    80002e54:	00053703          	ld	a4,0(a0)
    80002e58:	04f70263          	beq	a4,a5,80002e9c <uartstart+0x68>
    80002e5c:	100005b7          	lui	a1,0x10000
    80002e60:	00003817          	auipc	a6,0x3
    80002e64:	8f080813          	addi	a6,a6,-1808 # 80005750 <uart_tx_buf>
    80002e68:	01c0006f          	j	80002e84 <uartstart+0x50>
    80002e6c:	0006c703          	lbu	a4,0(a3)
    80002e70:	00f63023          	sd	a5,0(a2)
    80002e74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002e78:	00063783          	ld	a5,0(a2)
    80002e7c:	00053703          	ld	a4,0(a0)
    80002e80:	00f70e63          	beq	a4,a5,80002e9c <uartstart+0x68>
    80002e84:	01f7f713          	andi	a4,a5,31
    80002e88:	00e806b3          	add	a3,a6,a4
    80002e8c:	0055c703          	lbu	a4,5(a1)
    80002e90:	00178793          	addi	a5,a5,1
    80002e94:	02077713          	andi	a4,a4,32
    80002e98:	fc071ae3          	bnez	a4,80002e6c <uartstart+0x38>
    80002e9c:	00813403          	ld	s0,8(sp)
    80002ea0:	01010113          	addi	sp,sp,16
    80002ea4:	00008067          	ret

0000000080002ea8 <uartgetc>:
    80002ea8:	ff010113          	addi	sp,sp,-16
    80002eac:	00813423          	sd	s0,8(sp)
    80002eb0:	01010413          	addi	s0,sp,16
    80002eb4:	10000737          	lui	a4,0x10000
    80002eb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002ebc:	0017f793          	andi	a5,a5,1
    80002ec0:	00078c63          	beqz	a5,80002ed8 <uartgetc+0x30>
    80002ec4:	00074503          	lbu	a0,0(a4)
    80002ec8:	0ff57513          	andi	a0,a0,255
    80002ecc:	00813403          	ld	s0,8(sp)
    80002ed0:	01010113          	addi	sp,sp,16
    80002ed4:	00008067          	ret
    80002ed8:	fff00513          	li	a0,-1
    80002edc:	ff1ff06f          	j	80002ecc <uartgetc+0x24>

0000000080002ee0 <uartintr>:
    80002ee0:	100007b7          	lui	a5,0x10000
    80002ee4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002ee8:	0017f793          	andi	a5,a5,1
    80002eec:	0a078463          	beqz	a5,80002f94 <uartintr+0xb4>
    80002ef0:	fe010113          	addi	sp,sp,-32
    80002ef4:	00813823          	sd	s0,16(sp)
    80002ef8:	00913423          	sd	s1,8(sp)
    80002efc:	00113c23          	sd	ra,24(sp)
    80002f00:	02010413          	addi	s0,sp,32
    80002f04:	100004b7          	lui	s1,0x10000
    80002f08:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002f0c:	0ff57513          	andi	a0,a0,255
    80002f10:	fffff097          	auipc	ra,0xfffff
    80002f14:	534080e7          	jalr	1332(ra) # 80002444 <consoleintr>
    80002f18:	0054c783          	lbu	a5,5(s1)
    80002f1c:	0017f793          	andi	a5,a5,1
    80002f20:	fe0794e3          	bnez	a5,80002f08 <uartintr+0x28>
    80002f24:	00001617          	auipc	a2,0x1
    80002f28:	5bc60613          	addi	a2,a2,1468 # 800044e0 <uart_tx_r>
    80002f2c:	00001517          	auipc	a0,0x1
    80002f30:	5bc50513          	addi	a0,a0,1468 # 800044e8 <uart_tx_w>
    80002f34:	00063783          	ld	a5,0(a2)
    80002f38:	00053703          	ld	a4,0(a0)
    80002f3c:	04f70263          	beq	a4,a5,80002f80 <uartintr+0xa0>
    80002f40:	100005b7          	lui	a1,0x10000
    80002f44:	00003817          	auipc	a6,0x3
    80002f48:	80c80813          	addi	a6,a6,-2036 # 80005750 <uart_tx_buf>
    80002f4c:	01c0006f          	j	80002f68 <uartintr+0x88>
    80002f50:	0006c703          	lbu	a4,0(a3)
    80002f54:	00f63023          	sd	a5,0(a2)
    80002f58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002f5c:	00063783          	ld	a5,0(a2)
    80002f60:	00053703          	ld	a4,0(a0)
    80002f64:	00f70e63          	beq	a4,a5,80002f80 <uartintr+0xa0>
    80002f68:	01f7f713          	andi	a4,a5,31
    80002f6c:	00e806b3          	add	a3,a6,a4
    80002f70:	0055c703          	lbu	a4,5(a1)
    80002f74:	00178793          	addi	a5,a5,1
    80002f78:	02077713          	andi	a4,a4,32
    80002f7c:	fc071ae3          	bnez	a4,80002f50 <uartintr+0x70>
    80002f80:	01813083          	ld	ra,24(sp)
    80002f84:	01013403          	ld	s0,16(sp)
    80002f88:	00813483          	ld	s1,8(sp)
    80002f8c:	02010113          	addi	sp,sp,32
    80002f90:	00008067          	ret
    80002f94:	00001617          	auipc	a2,0x1
    80002f98:	54c60613          	addi	a2,a2,1356 # 800044e0 <uart_tx_r>
    80002f9c:	00001517          	auipc	a0,0x1
    80002fa0:	54c50513          	addi	a0,a0,1356 # 800044e8 <uart_tx_w>
    80002fa4:	00063783          	ld	a5,0(a2)
    80002fa8:	00053703          	ld	a4,0(a0)
    80002fac:	04f70263          	beq	a4,a5,80002ff0 <uartintr+0x110>
    80002fb0:	100005b7          	lui	a1,0x10000
    80002fb4:	00002817          	auipc	a6,0x2
    80002fb8:	79c80813          	addi	a6,a6,1948 # 80005750 <uart_tx_buf>
    80002fbc:	01c0006f          	j	80002fd8 <uartintr+0xf8>
    80002fc0:	0006c703          	lbu	a4,0(a3)
    80002fc4:	00f63023          	sd	a5,0(a2)
    80002fc8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002fcc:	00063783          	ld	a5,0(a2)
    80002fd0:	00053703          	ld	a4,0(a0)
    80002fd4:	02f70063          	beq	a4,a5,80002ff4 <uartintr+0x114>
    80002fd8:	01f7f713          	andi	a4,a5,31
    80002fdc:	00e806b3          	add	a3,a6,a4
    80002fe0:	0055c703          	lbu	a4,5(a1)
    80002fe4:	00178793          	addi	a5,a5,1
    80002fe8:	02077713          	andi	a4,a4,32
    80002fec:	fc071ae3          	bnez	a4,80002fc0 <uartintr+0xe0>
    80002ff0:	00008067          	ret
    80002ff4:	00008067          	ret

0000000080002ff8 <kinit>:
    80002ff8:	fc010113          	addi	sp,sp,-64
    80002ffc:	02913423          	sd	s1,40(sp)
    80003000:	fffff7b7          	lui	a5,0xfffff
    80003004:	00003497          	auipc	s1,0x3
    80003008:	76b48493          	addi	s1,s1,1899 # 8000676f <end+0xfff>
    8000300c:	02813823          	sd	s0,48(sp)
    80003010:	01313c23          	sd	s3,24(sp)
    80003014:	00f4f4b3          	and	s1,s1,a5
    80003018:	02113c23          	sd	ra,56(sp)
    8000301c:	03213023          	sd	s2,32(sp)
    80003020:	01413823          	sd	s4,16(sp)
    80003024:	01513423          	sd	s5,8(sp)
    80003028:	04010413          	addi	s0,sp,64
    8000302c:	000017b7          	lui	a5,0x1
    80003030:	01100993          	li	s3,17
    80003034:	00f487b3          	add	a5,s1,a5
    80003038:	01b99993          	slli	s3,s3,0x1b
    8000303c:	06f9e063          	bltu	s3,a5,8000309c <kinit+0xa4>
    80003040:	00002a97          	auipc	s5,0x2
    80003044:	730a8a93          	addi	s5,s5,1840 # 80005770 <end>
    80003048:	0754ec63          	bltu	s1,s5,800030c0 <kinit+0xc8>
    8000304c:	0734fa63          	bgeu	s1,s3,800030c0 <kinit+0xc8>
    80003050:	00088a37          	lui	s4,0x88
    80003054:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003058:	00001917          	auipc	s2,0x1
    8000305c:	49890913          	addi	s2,s2,1176 # 800044f0 <kmem>
    80003060:	00ca1a13          	slli	s4,s4,0xc
    80003064:	0140006f          	j	80003078 <kinit+0x80>
    80003068:	000017b7          	lui	a5,0x1
    8000306c:	00f484b3          	add	s1,s1,a5
    80003070:	0554e863          	bltu	s1,s5,800030c0 <kinit+0xc8>
    80003074:	0534f663          	bgeu	s1,s3,800030c0 <kinit+0xc8>
    80003078:	00001637          	lui	a2,0x1
    8000307c:	00100593          	li	a1,1
    80003080:	00048513          	mv	a0,s1
    80003084:	00000097          	auipc	ra,0x0
    80003088:	5e4080e7          	jalr	1508(ra) # 80003668 <__memset>
    8000308c:	00093783          	ld	a5,0(s2)
    80003090:	00f4b023          	sd	a5,0(s1)
    80003094:	00993023          	sd	s1,0(s2)
    80003098:	fd4498e3          	bne	s1,s4,80003068 <kinit+0x70>
    8000309c:	03813083          	ld	ra,56(sp)
    800030a0:	03013403          	ld	s0,48(sp)
    800030a4:	02813483          	ld	s1,40(sp)
    800030a8:	02013903          	ld	s2,32(sp)
    800030ac:	01813983          	ld	s3,24(sp)
    800030b0:	01013a03          	ld	s4,16(sp)
    800030b4:	00813a83          	ld	s5,8(sp)
    800030b8:	04010113          	addi	sp,sp,64
    800030bc:	00008067          	ret
    800030c0:	00001517          	auipc	a0,0x1
    800030c4:	0e050513          	addi	a0,a0,224 # 800041a0 <digits+0x18>
    800030c8:	fffff097          	auipc	ra,0xfffff
    800030cc:	4b4080e7          	jalr	1204(ra) # 8000257c <panic>

00000000800030d0 <freerange>:
    800030d0:	fc010113          	addi	sp,sp,-64
    800030d4:	000017b7          	lui	a5,0x1
    800030d8:	02913423          	sd	s1,40(sp)
    800030dc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800030e0:	009504b3          	add	s1,a0,s1
    800030e4:	fffff537          	lui	a0,0xfffff
    800030e8:	02813823          	sd	s0,48(sp)
    800030ec:	02113c23          	sd	ra,56(sp)
    800030f0:	03213023          	sd	s2,32(sp)
    800030f4:	01313c23          	sd	s3,24(sp)
    800030f8:	01413823          	sd	s4,16(sp)
    800030fc:	01513423          	sd	s5,8(sp)
    80003100:	01613023          	sd	s6,0(sp)
    80003104:	04010413          	addi	s0,sp,64
    80003108:	00a4f4b3          	and	s1,s1,a0
    8000310c:	00f487b3          	add	a5,s1,a5
    80003110:	06f5e463          	bltu	a1,a5,80003178 <freerange+0xa8>
    80003114:	00002a97          	auipc	s5,0x2
    80003118:	65ca8a93          	addi	s5,s5,1628 # 80005770 <end>
    8000311c:	0954e263          	bltu	s1,s5,800031a0 <freerange+0xd0>
    80003120:	01100993          	li	s3,17
    80003124:	01b99993          	slli	s3,s3,0x1b
    80003128:	0734fc63          	bgeu	s1,s3,800031a0 <freerange+0xd0>
    8000312c:	00058a13          	mv	s4,a1
    80003130:	00001917          	auipc	s2,0x1
    80003134:	3c090913          	addi	s2,s2,960 # 800044f0 <kmem>
    80003138:	00002b37          	lui	s6,0x2
    8000313c:	0140006f          	j	80003150 <freerange+0x80>
    80003140:	000017b7          	lui	a5,0x1
    80003144:	00f484b3          	add	s1,s1,a5
    80003148:	0554ec63          	bltu	s1,s5,800031a0 <freerange+0xd0>
    8000314c:	0534fa63          	bgeu	s1,s3,800031a0 <freerange+0xd0>
    80003150:	00001637          	lui	a2,0x1
    80003154:	00100593          	li	a1,1
    80003158:	00048513          	mv	a0,s1
    8000315c:	00000097          	auipc	ra,0x0
    80003160:	50c080e7          	jalr	1292(ra) # 80003668 <__memset>
    80003164:	00093703          	ld	a4,0(s2)
    80003168:	016487b3          	add	a5,s1,s6
    8000316c:	00e4b023          	sd	a4,0(s1)
    80003170:	00993023          	sd	s1,0(s2)
    80003174:	fcfa76e3          	bgeu	s4,a5,80003140 <freerange+0x70>
    80003178:	03813083          	ld	ra,56(sp)
    8000317c:	03013403          	ld	s0,48(sp)
    80003180:	02813483          	ld	s1,40(sp)
    80003184:	02013903          	ld	s2,32(sp)
    80003188:	01813983          	ld	s3,24(sp)
    8000318c:	01013a03          	ld	s4,16(sp)
    80003190:	00813a83          	ld	s5,8(sp)
    80003194:	00013b03          	ld	s6,0(sp)
    80003198:	04010113          	addi	sp,sp,64
    8000319c:	00008067          	ret
    800031a0:	00001517          	auipc	a0,0x1
    800031a4:	00050513          	mv	a0,a0
    800031a8:	fffff097          	auipc	ra,0xfffff
    800031ac:	3d4080e7          	jalr	980(ra) # 8000257c <panic>

00000000800031b0 <kfree>:
    800031b0:	fe010113          	addi	sp,sp,-32
    800031b4:	00813823          	sd	s0,16(sp)
    800031b8:	00113c23          	sd	ra,24(sp)
    800031bc:	00913423          	sd	s1,8(sp)
    800031c0:	02010413          	addi	s0,sp,32
    800031c4:	03451793          	slli	a5,a0,0x34
    800031c8:	04079c63          	bnez	a5,80003220 <kfree+0x70>
    800031cc:	00002797          	auipc	a5,0x2
    800031d0:	5a478793          	addi	a5,a5,1444 # 80005770 <end>
    800031d4:	00050493          	mv	s1,a0
    800031d8:	04f56463          	bltu	a0,a5,80003220 <kfree+0x70>
    800031dc:	01100793          	li	a5,17
    800031e0:	01b79793          	slli	a5,a5,0x1b
    800031e4:	02f57e63          	bgeu	a0,a5,80003220 <kfree+0x70>
    800031e8:	00001637          	lui	a2,0x1
    800031ec:	00100593          	li	a1,1
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	478080e7          	jalr	1144(ra) # 80003668 <__memset>
    800031f8:	00001797          	auipc	a5,0x1
    800031fc:	2f878793          	addi	a5,a5,760 # 800044f0 <kmem>
    80003200:	0007b703          	ld	a4,0(a5)
    80003204:	01813083          	ld	ra,24(sp)
    80003208:	01013403          	ld	s0,16(sp)
    8000320c:	00e4b023          	sd	a4,0(s1)
    80003210:	0097b023          	sd	s1,0(a5)
    80003214:	00813483          	ld	s1,8(sp)
    80003218:	02010113          	addi	sp,sp,32
    8000321c:	00008067          	ret
    80003220:	00001517          	auipc	a0,0x1
    80003224:	f8050513          	addi	a0,a0,-128 # 800041a0 <digits+0x18>
    80003228:	fffff097          	auipc	ra,0xfffff
    8000322c:	354080e7          	jalr	852(ra) # 8000257c <panic>

0000000080003230 <kalloc>:
    80003230:	fe010113          	addi	sp,sp,-32
    80003234:	00813823          	sd	s0,16(sp)
    80003238:	00913423          	sd	s1,8(sp)
    8000323c:	00113c23          	sd	ra,24(sp)
    80003240:	02010413          	addi	s0,sp,32
    80003244:	00001797          	auipc	a5,0x1
    80003248:	2ac78793          	addi	a5,a5,684 # 800044f0 <kmem>
    8000324c:	0007b483          	ld	s1,0(a5)
    80003250:	02048063          	beqz	s1,80003270 <kalloc+0x40>
    80003254:	0004b703          	ld	a4,0(s1)
    80003258:	00001637          	lui	a2,0x1
    8000325c:	00500593          	li	a1,5
    80003260:	00048513          	mv	a0,s1
    80003264:	00e7b023          	sd	a4,0(a5)
    80003268:	00000097          	auipc	ra,0x0
    8000326c:	400080e7          	jalr	1024(ra) # 80003668 <__memset>
    80003270:	01813083          	ld	ra,24(sp)
    80003274:	01013403          	ld	s0,16(sp)
    80003278:	00048513          	mv	a0,s1
    8000327c:	00813483          	ld	s1,8(sp)
    80003280:	02010113          	addi	sp,sp,32
    80003284:	00008067          	ret

0000000080003288 <initlock>:
    80003288:	ff010113          	addi	sp,sp,-16
    8000328c:	00813423          	sd	s0,8(sp)
    80003290:	01010413          	addi	s0,sp,16
    80003294:	00813403          	ld	s0,8(sp)
    80003298:	00b53423          	sd	a1,8(a0)
    8000329c:	00052023          	sw	zero,0(a0)
    800032a0:	00053823          	sd	zero,16(a0)
    800032a4:	01010113          	addi	sp,sp,16
    800032a8:	00008067          	ret

00000000800032ac <acquire>:
    800032ac:	fe010113          	addi	sp,sp,-32
    800032b0:	00813823          	sd	s0,16(sp)
    800032b4:	00913423          	sd	s1,8(sp)
    800032b8:	00113c23          	sd	ra,24(sp)
    800032bc:	01213023          	sd	s2,0(sp)
    800032c0:	02010413          	addi	s0,sp,32
    800032c4:	00050493          	mv	s1,a0
    800032c8:	10002973          	csrr	s2,sstatus
    800032cc:	100027f3          	csrr	a5,sstatus
    800032d0:	ffd7f793          	andi	a5,a5,-3
    800032d4:	10079073          	csrw	sstatus,a5
    800032d8:	fffff097          	auipc	ra,0xfffff
    800032dc:	8e0080e7          	jalr	-1824(ra) # 80001bb8 <mycpu>
    800032e0:	07852783          	lw	a5,120(a0)
    800032e4:	06078e63          	beqz	a5,80003360 <acquire+0xb4>
    800032e8:	fffff097          	auipc	ra,0xfffff
    800032ec:	8d0080e7          	jalr	-1840(ra) # 80001bb8 <mycpu>
    800032f0:	07852783          	lw	a5,120(a0)
    800032f4:	0004a703          	lw	a4,0(s1)
    800032f8:	0017879b          	addiw	a5,a5,1
    800032fc:	06f52c23          	sw	a5,120(a0)
    80003300:	04071063          	bnez	a4,80003340 <acquire+0x94>
    80003304:	00100713          	li	a4,1
    80003308:	00070793          	mv	a5,a4
    8000330c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003310:	0007879b          	sext.w	a5,a5
    80003314:	fe079ae3          	bnez	a5,80003308 <acquire+0x5c>
    80003318:	0ff0000f          	fence
    8000331c:	fffff097          	auipc	ra,0xfffff
    80003320:	89c080e7          	jalr	-1892(ra) # 80001bb8 <mycpu>
    80003324:	01813083          	ld	ra,24(sp)
    80003328:	01013403          	ld	s0,16(sp)
    8000332c:	00a4b823          	sd	a0,16(s1)
    80003330:	00013903          	ld	s2,0(sp)
    80003334:	00813483          	ld	s1,8(sp)
    80003338:	02010113          	addi	sp,sp,32
    8000333c:	00008067          	ret
    80003340:	0104b903          	ld	s2,16(s1)
    80003344:	fffff097          	auipc	ra,0xfffff
    80003348:	874080e7          	jalr	-1932(ra) # 80001bb8 <mycpu>
    8000334c:	faa91ce3          	bne	s2,a0,80003304 <acquire+0x58>
    80003350:	00001517          	auipc	a0,0x1
    80003354:	e5850513          	addi	a0,a0,-424 # 800041a8 <digits+0x20>
    80003358:	fffff097          	auipc	ra,0xfffff
    8000335c:	224080e7          	jalr	548(ra) # 8000257c <panic>
    80003360:	00195913          	srli	s2,s2,0x1
    80003364:	fffff097          	auipc	ra,0xfffff
    80003368:	854080e7          	jalr	-1964(ra) # 80001bb8 <mycpu>
    8000336c:	00197913          	andi	s2,s2,1
    80003370:	07252e23          	sw	s2,124(a0)
    80003374:	f75ff06f          	j	800032e8 <acquire+0x3c>

0000000080003378 <release>:
    80003378:	fe010113          	addi	sp,sp,-32
    8000337c:	00813823          	sd	s0,16(sp)
    80003380:	00113c23          	sd	ra,24(sp)
    80003384:	00913423          	sd	s1,8(sp)
    80003388:	01213023          	sd	s2,0(sp)
    8000338c:	02010413          	addi	s0,sp,32
    80003390:	00052783          	lw	a5,0(a0)
    80003394:	00079a63          	bnez	a5,800033a8 <release+0x30>
    80003398:	00001517          	auipc	a0,0x1
    8000339c:	e1850513          	addi	a0,a0,-488 # 800041b0 <digits+0x28>
    800033a0:	fffff097          	auipc	ra,0xfffff
    800033a4:	1dc080e7          	jalr	476(ra) # 8000257c <panic>
    800033a8:	01053903          	ld	s2,16(a0)
    800033ac:	00050493          	mv	s1,a0
    800033b0:	fffff097          	auipc	ra,0xfffff
    800033b4:	808080e7          	jalr	-2040(ra) # 80001bb8 <mycpu>
    800033b8:	fea910e3          	bne	s2,a0,80003398 <release+0x20>
    800033bc:	0004b823          	sd	zero,16(s1)
    800033c0:	0ff0000f          	fence
    800033c4:	0f50000f          	fence	iorw,ow
    800033c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800033cc:	ffffe097          	auipc	ra,0xffffe
    800033d0:	7ec080e7          	jalr	2028(ra) # 80001bb8 <mycpu>
    800033d4:	100027f3          	csrr	a5,sstatus
    800033d8:	0027f793          	andi	a5,a5,2
    800033dc:	04079a63          	bnez	a5,80003430 <release+0xb8>
    800033e0:	07852783          	lw	a5,120(a0)
    800033e4:	02f05e63          	blez	a5,80003420 <release+0xa8>
    800033e8:	fff7871b          	addiw	a4,a5,-1
    800033ec:	06e52c23          	sw	a4,120(a0)
    800033f0:	00071c63          	bnez	a4,80003408 <release+0x90>
    800033f4:	07c52783          	lw	a5,124(a0)
    800033f8:	00078863          	beqz	a5,80003408 <release+0x90>
    800033fc:	100027f3          	csrr	a5,sstatus
    80003400:	0027e793          	ori	a5,a5,2
    80003404:	10079073          	csrw	sstatus,a5
    80003408:	01813083          	ld	ra,24(sp)
    8000340c:	01013403          	ld	s0,16(sp)
    80003410:	00813483          	ld	s1,8(sp)
    80003414:	00013903          	ld	s2,0(sp)
    80003418:	02010113          	addi	sp,sp,32
    8000341c:	00008067          	ret
    80003420:	00001517          	auipc	a0,0x1
    80003424:	db050513          	addi	a0,a0,-592 # 800041d0 <digits+0x48>
    80003428:	fffff097          	auipc	ra,0xfffff
    8000342c:	154080e7          	jalr	340(ra) # 8000257c <panic>
    80003430:	00001517          	auipc	a0,0x1
    80003434:	d8850513          	addi	a0,a0,-632 # 800041b8 <digits+0x30>
    80003438:	fffff097          	auipc	ra,0xfffff
    8000343c:	144080e7          	jalr	324(ra) # 8000257c <panic>

0000000080003440 <holding>:
    80003440:	00052783          	lw	a5,0(a0)
    80003444:	00079663          	bnez	a5,80003450 <holding+0x10>
    80003448:	00000513          	li	a0,0
    8000344c:	00008067          	ret
    80003450:	fe010113          	addi	sp,sp,-32
    80003454:	00813823          	sd	s0,16(sp)
    80003458:	00913423          	sd	s1,8(sp)
    8000345c:	00113c23          	sd	ra,24(sp)
    80003460:	02010413          	addi	s0,sp,32
    80003464:	01053483          	ld	s1,16(a0)
    80003468:	ffffe097          	auipc	ra,0xffffe
    8000346c:	750080e7          	jalr	1872(ra) # 80001bb8 <mycpu>
    80003470:	01813083          	ld	ra,24(sp)
    80003474:	01013403          	ld	s0,16(sp)
    80003478:	40a48533          	sub	a0,s1,a0
    8000347c:	00153513          	seqz	a0,a0
    80003480:	00813483          	ld	s1,8(sp)
    80003484:	02010113          	addi	sp,sp,32
    80003488:	00008067          	ret

000000008000348c <push_off>:
    8000348c:	fe010113          	addi	sp,sp,-32
    80003490:	00813823          	sd	s0,16(sp)
    80003494:	00113c23          	sd	ra,24(sp)
    80003498:	00913423          	sd	s1,8(sp)
    8000349c:	02010413          	addi	s0,sp,32
    800034a0:	100024f3          	csrr	s1,sstatus
    800034a4:	100027f3          	csrr	a5,sstatus
    800034a8:	ffd7f793          	andi	a5,a5,-3
    800034ac:	10079073          	csrw	sstatus,a5
    800034b0:	ffffe097          	auipc	ra,0xffffe
    800034b4:	708080e7          	jalr	1800(ra) # 80001bb8 <mycpu>
    800034b8:	07852783          	lw	a5,120(a0)
    800034bc:	02078663          	beqz	a5,800034e8 <push_off+0x5c>
    800034c0:	ffffe097          	auipc	ra,0xffffe
    800034c4:	6f8080e7          	jalr	1784(ra) # 80001bb8 <mycpu>
    800034c8:	07852783          	lw	a5,120(a0)
    800034cc:	01813083          	ld	ra,24(sp)
    800034d0:	01013403          	ld	s0,16(sp)
    800034d4:	0017879b          	addiw	a5,a5,1
    800034d8:	06f52c23          	sw	a5,120(a0)
    800034dc:	00813483          	ld	s1,8(sp)
    800034e0:	02010113          	addi	sp,sp,32
    800034e4:	00008067          	ret
    800034e8:	0014d493          	srli	s1,s1,0x1
    800034ec:	ffffe097          	auipc	ra,0xffffe
    800034f0:	6cc080e7          	jalr	1740(ra) # 80001bb8 <mycpu>
    800034f4:	0014f493          	andi	s1,s1,1
    800034f8:	06952e23          	sw	s1,124(a0)
    800034fc:	fc5ff06f          	j	800034c0 <push_off+0x34>

0000000080003500 <pop_off>:
    80003500:	ff010113          	addi	sp,sp,-16
    80003504:	00813023          	sd	s0,0(sp)
    80003508:	00113423          	sd	ra,8(sp)
    8000350c:	01010413          	addi	s0,sp,16
    80003510:	ffffe097          	auipc	ra,0xffffe
    80003514:	6a8080e7          	jalr	1704(ra) # 80001bb8 <mycpu>
    80003518:	100027f3          	csrr	a5,sstatus
    8000351c:	0027f793          	andi	a5,a5,2
    80003520:	04079663          	bnez	a5,8000356c <pop_off+0x6c>
    80003524:	07852783          	lw	a5,120(a0)
    80003528:	02f05a63          	blez	a5,8000355c <pop_off+0x5c>
    8000352c:	fff7871b          	addiw	a4,a5,-1
    80003530:	06e52c23          	sw	a4,120(a0)
    80003534:	00071c63          	bnez	a4,8000354c <pop_off+0x4c>
    80003538:	07c52783          	lw	a5,124(a0)
    8000353c:	00078863          	beqz	a5,8000354c <pop_off+0x4c>
    80003540:	100027f3          	csrr	a5,sstatus
    80003544:	0027e793          	ori	a5,a5,2
    80003548:	10079073          	csrw	sstatus,a5
    8000354c:	00813083          	ld	ra,8(sp)
    80003550:	00013403          	ld	s0,0(sp)
    80003554:	01010113          	addi	sp,sp,16
    80003558:	00008067          	ret
    8000355c:	00001517          	auipc	a0,0x1
    80003560:	c7450513          	addi	a0,a0,-908 # 800041d0 <digits+0x48>
    80003564:	fffff097          	auipc	ra,0xfffff
    80003568:	018080e7          	jalr	24(ra) # 8000257c <panic>
    8000356c:	00001517          	auipc	a0,0x1
    80003570:	c4c50513          	addi	a0,a0,-948 # 800041b8 <digits+0x30>
    80003574:	fffff097          	auipc	ra,0xfffff
    80003578:	008080e7          	jalr	8(ra) # 8000257c <panic>

000000008000357c <push_on>:
    8000357c:	fe010113          	addi	sp,sp,-32
    80003580:	00813823          	sd	s0,16(sp)
    80003584:	00113c23          	sd	ra,24(sp)
    80003588:	00913423          	sd	s1,8(sp)
    8000358c:	02010413          	addi	s0,sp,32
    80003590:	100024f3          	csrr	s1,sstatus
    80003594:	100027f3          	csrr	a5,sstatus
    80003598:	0027e793          	ori	a5,a5,2
    8000359c:	10079073          	csrw	sstatus,a5
    800035a0:	ffffe097          	auipc	ra,0xffffe
    800035a4:	618080e7          	jalr	1560(ra) # 80001bb8 <mycpu>
    800035a8:	07852783          	lw	a5,120(a0)
    800035ac:	02078663          	beqz	a5,800035d8 <push_on+0x5c>
    800035b0:	ffffe097          	auipc	ra,0xffffe
    800035b4:	608080e7          	jalr	1544(ra) # 80001bb8 <mycpu>
    800035b8:	07852783          	lw	a5,120(a0)
    800035bc:	01813083          	ld	ra,24(sp)
    800035c0:	01013403          	ld	s0,16(sp)
    800035c4:	0017879b          	addiw	a5,a5,1
    800035c8:	06f52c23          	sw	a5,120(a0)
    800035cc:	00813483          	ld	s1,8(sp)
    800035d0:	02010113          	addi	sp,sp,32
    800035d4:	00008067          	ret
    800035d8:	0014d493          	srli	s1,s1,0x1
    800035dc:	ffffe097          	auipc	ra,0xffffe
    800035e0:	5dc080e7          	jalr	1500(ra) # 80001bb8 <mycpu>
    800035e4:	0014f493          	andi	s1,s1,1
    800035e8:	06952e23          	sw	s1,124(a0)
    800035ec:	fc5ff06f          	j	800035b0 <push_on+0x34>

00000000800035f0 <pop_on>:
    800035f0:	ff010113          	addi	sp,sp,-16
    800035f4:	00813023          	sd	s0,0(sp)
    800035f8:	00113423          	sd	ra,8(sp)
    800035fc:	01010413          	addi	s0,sp,16
    80003600:	ffffe097          	auipc	ra,0xffffe
    80003604:	5b8080e7          	jalr	1464(ra) # 80001bb8 <mycpu>
    80003608:	100027f3          	csrr	a5,sstatus
    8000360c:	0027f793          	andi	a5,a5,2
    80003610:	04078463          	beqz	a5,80003658 <pop_on+0x68>
    80003614:	07852783          	lw	a5,120(a0)
    80003618:	02f05863          	blez	a5,80003648 <pop_on+0x58>
    8000361c:	fff7879b          	addiw	a5,a5,-1
    80003620:	06f52c23          	sw	a5,120(a0)
    80003624:	07853783          	ld	a5,120(a0)
    80003628:	00079863          	bnez	a5,80003638 <pop_on+0x48>
    8000362c:	100027f3          	csrr	a5,sstatus
    80003630:	ffd7f793          	andi	a5,a5,-3
    80003634:	10079073          	csrw	sstatus,a5
    80003638:	00813083          	ld	ra,8(sp)
    8000363c:	00013403          	ld	s0,0(sp)
    80003640:	01010113          	addi	sp,sp,16
    80003644:	00008067          	ret
    80003648:	00001517          	auipc	a0,0x1
    8000364c:	bb050513          	addi	a0,a0,-1104 # 800041f8 <digits+0x70>
    80003650:	fffff097          	auipc	ra,0xfffff
    80003654:	f2c080e7          	jalr	-212(ra) # 8000257c <panic>
    80003658:	00001517          	auipc	a0,0x1
    8000365c:	b8050513          	addi	a0,a0,-1152 # 800041d8 <digits+0x50>
    80003660:	fffff097          	auipc	ra,0xfffff
    80003664:	f1c080e7          	jalr	-228(ra) # 8000257c <panic>

0000000080003668 <__memset>:
    80003668:	ff010113          	addi	sp,sp,-16
    8000366c:	00813423          	sd	s0,8(sp)
    80003670:	01010413          	addi	s0,sp,16
    80003674:	1a060e63          	beqz	a2,80003830 <__memset+0x1c8>
    80003678:	40a007b3          	neg	a5,a0
    8000367c:	0077f793          	andi	a5,a5,7
    80003680:	00778693          	addi	a3,a5,7
    80003684:	00b00813          	li	a6,11
    80003688:	0ff5f593          	andi	a1,a1,255
    8000368c:	fff6071b          	addiw	a4,a2,-1
    80003690:	1b06e663          	bltu	a3,a6,8000383c <__memset+0x1d4>
    80003694:	1cd76463          	bltu	a4,a3,8000385c <__memset+0x1f4>
    80003698:	1a078e63          	beqz	a5,80003854 <__memset+0x1ec>
    8000369c:	00b50023          	sb	a1,0(a0)
    800036a0:	00100713          	li	a4,1
    800036a4:	1ae78463          	beq	a5,a4,8000384c <__memset+0x1e4>
    800036a8:	00b500a3          	sb	a1,1(a0)
    800036ac:	00200713          	li	a4,2
    800036b0:	1ae78a63          	beq	a5,a4,80003864 <__memset+0x1fc>
    800036b4:	00b50123          	sb	a1,2(a0)
    800036b8:	00300713          	li	a4,3
    800036bc:	18e78463          	beq	a5,a4,80003844 <__memset+0x1dc>
    800036c0:	00b501a3          	sb	a1,3(a0)
    800036c4:	00400713          	li	a4,4
    800036c8:	1ae78263          	beq	a5,a4,8000386c <__memset+0x204>
    800036cc:	00b50223          	sb	a1,4(a0)
    800036d0:	00500713          	li	a4,5
    800036d4:	1ae78063          	beq	a5,a4,80003874 <__memset+0x20c>
    800036d8:	00b502a3          	sb	a1,5(a0)
    800036dc:	00700713          	li	a4,7
    800036e0:	18e79e63          	bne	a5,a4,8000387c <__memset+0x214>
    800036e4:	00b50323          	sb	a1,6(a0)
    800036e8:	00700e93          	li	t4,7
    800036ec:	00859713          	slli	a4,a1,0x8
    800036f0:	00e5e733          	or	a4,a1,a4
    800036f4:	01059e13          	slli	t3,a1,0x10
    800036f8:	01c76e33          	or	t3,a4,t3
    800036fc:	01859313          	slli	t1,a1,0x18
    80003700:	006e6333          	or	t1,t3,t1
    80003704:	02059893          	slli	a7,a1,0x20
    80003708:	40f60e3b          	subw	t3,a2,a5
    8000370c:	011368b3          	or	a7,t1,a7
    80003710:	02859813          	slli	a6,a1,0x28
    80003714:	0108e833          	or	a6,a7,a6
    80003718:	03059693          	slli	a3,a1,0x30
    8000371c:	003e589b          	srliw	a7,t3,0x3
    80003720:	00d866b3          	or	a3,a6,a3
    80003724:	03859713          	slli	a4,a1,0x38
    80003728:	00389813          	slli	a6,a7,0x3
    8000372c:	00f507b3          	add	a5,a0,a5
    80003730:	00e6e733          	or	a4,a3,a4
    80003734:	000e089b          	sext.w	a7,t3
    80003738:	00f806b3          	add	a3,a6,a5
    8000373c:	00e7b023          	sd	a4,0(a5)
    80003740:	00878793          	addi	a5,a5,8
    80003744:	fed79ce3          	bne	a5,a3,8000373c <__memset+0xd4>
    80003748:	ff8e7793          	andi	a5,t3,-8
    8000374c:	0007871b          	sext.w	a4,a5
    80003750:	01d787bb          	addw	a5,a5,t4
    80003754:	0ce88e63          	beq	a7,a4,80003830 <__memset+0x1c8>
    80003758:	00f50733          	add	a4,a0,a5
    8000375c:	00b70023          	sb	a1,0(a4)
    80003760:	0017871b          	addiw	a4,a5,1
    80003764:	0cc77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003768:	00e50733          	add	a4,a0,a4
    8000376c:	00b70023          	sb	a1,0(a4)
    80003770:	0027871b          	addiw	a4,a5,2
    80003774:	0ac77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003778:	00e50733          	add	a4,a0,a4
    8000377c:	00b70023          	sb	a1,0(a4)
    80003780:	0037871b          	addiw	a4,a5,3
    80003784:	0ac77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003788:	00e50733          	add	a4,a0,a4
    8000378c:	00b70023          	sb	a1,0(a4)
    80003790:	0047871b          	addiw	a4,a5,4
    80003794:	08c77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003798:	00e50733          	add	a4,a0,a4
    8000379c:	00b70023          	sb	a1,0(a4)
    800037a0:	0057871b          	addiw	a4,a5,5
    800037a4:	08c77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037a8:	00e50733          	add	a4,a0,a4
    800037ac:	00b70023          	sb	a1,0(a4)
    800037b0:	0067871b          	addiw	a4,a5,6
    800037b4:	06c77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037b8:	00e50733          	add	a4,a0,a4
    800037bc:	00b70023          	sb	a1,0(a4)
    800037c0:	0077871b          	addiw	a4,a5,7
    800037c4:	06c77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037c8:	00e50733          	add	a4,a0,a4
    800037cc:	00b70023          	sb	a1,0(a4)
    800037d0:	0087871b          	addiw	a4,a5,8
    800037d4:	04c77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037d8:	00e50733          	add	a4,a0,a4
    800037dc:	00b70023          	sb	a1,0(a4)
    800037e0:	0097871b          	addiw	a4,a5,9
    800037e4:	04c77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037e8:	00e50733          	add	a4,a0,a4
    800037ec:	00b70023          	sb	a1,0(a4)
    800037f0:	00a7871b          	addiw	a4,a5,10
    800037f4:	02c77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    800037f8:	00e50733          	add	a4,a0,a4
    800037fc:	00b70023          	sb	a1,0(a4)
    80003800:	00b7871b          	addiw	a4,a5,11
    80003804:	02c77663          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003808:	00e50733          	add	a4,a0,a4
    8000380c:	00b70023          	sb	a1,0(a4)
    80003810:	00c7871b          	addiw	a4,a5,12
    80003814:	00c77e63          	bgeu	a4,a2,80003830 <__memset+0x1c8>
    80003818:	00e50733          	add	a4,a0,a4
    8000381c:	00b70023          	sb	a1,0(a4)
    80003820:	00d7879b          	addiw	a5,a5,13
    80003824:	00c7f663          	bgeu	a5,a2,80003830 <__memset+0x1c8>
    80003828:	00f507b3          	add	a5,a0,a5
    8000382c:	00b78023          	sb	a1,0(a5)
    80003830:	00813403          	ld	s0,8(sp)
    80003834:	01010113          	addi	sp,sp,16
    80003838:	00008067          	ret
    8000383c:	00b00693          	li	a3,11
    80003840:	e55ff06f          	j	80003694 <__memset+0x2c>
    80003844:	00300e93          	li	t4,3
    80003848:	ea5ff06f          	j	800036ec <__memset+0x84>
    8000384c:	00100e93          	li	t4,1
    80003850:	e9dff06f          	j	800036ec <__memset+0x84>
    80003854:	00000e93          	li	t4,0
    80003858:	e95ff06f          	j	800036ec <__memset+0x84>
    8000385c:	00000793          	li	a5,0
    80003860:	ef9ff06f          	j	80003758 <__memset+0xf0>
    80003864:	00200e93          	li	t4,2
    80003868:	e85ff06f          	j	800036ec <__memset+0x84>
    8000386c:	00400e93          	li	t4,4
    80003870:	e7dff06f          	j	800036ec <__memset+0x84>
    80003874:	00500e93          	li	t4,5
    80003878:	e75ff06f          	j	800036ec <__memset+0x84>
    8000387c:	00600e93          	li	t4,6
    80003880:	e6dff06f          	j	800036ec <__memset+0x84>

0000000080003884 <__memmove>:
    80003884:	ff010113          	addi	sp,sp,-16
    80003888:	00813423          	sd	s0,8(sp)
    8000388c:	01010413          	addi	s0,sp,16
    80003890:	0e060863          	beqz	a2,80003980 <__memmove+0xfc>
    80003894:	fff6069b          	addiw	a3,a2,-1
    80003898:	0006881b          	sext.w	a6,a3
    8000389c:	0ea5e863          	bltu	a1,a0,8000398c <__memmove+0x108>
    800038a0:	00758713          	addi	a4,a1,7
    800038a4:	00a5e7b3          	or	a5,a1,a0
    800038a8:	40a70733          	sub	a4,a4,a0
    800038ac:	0077f793          	andi	a5,a5,7
    800038b0:	00f73713          	sltiu	a4,a4,15
    800038b4:	00174713          	xori	a4,a4,1
    800038b8:	0017b793          	seqz	a5,a5
    800038bc:	00e7f7b3          	and	a5,a5,a4
    800038c0:	10078863          	beqz	a5,800039d0 <__memmove+0x14c>
    800038c4:	00900793          	li	a5,9
    800038c8:	1107f463          	bgeu	a5,a6,800039d0 <__memmove+0x14c>
    800038cc:	0036581b          	srliw	a6,a2,0x3
    800038d0:	fff8081b          	addiw	a6,a6,-1
    800038d4:	02081813          	slli	a6,a6,0x20
    800038d8:	01d85893          	srli	a7,a6,0x1d
    800038dc:	00858813          	addi	a6,a1,8
    800038e0:	00058793          	mv	a5,a1
    800038e4:	00050713          	mv	a4,a0
    800038e8:	01088833          	add	a6,a7,a6
    800038ec:	0007b883          	ld	a7,0(a5)
    800038f0:	00878793          	addi	a5,a5,8
    800038f4:	00870713          	addi	a4,a4,8
    800038f8:	ff173c23          	sd	a7,-8(a4)
    800038fc:	ff0798e3          	bne	a5,a6,800038ec <__memmove+0x68>
    80003900:	ff867713          	andi	a4,a2,-8
    80003904:	02071793          	slli	a5,a4,0x20
    80003908:	0207d793          	srli	a5,a5,0x20
    8000390c:	00f585b3          	add	a1,a1,a5
    80003910:	40e686bb          	subw	a3,a3,a4
    80003914:	00f507b3          	add	a5,a0,a5
    80003918:	06e60463          	beq	a2,a4,80003980 <__memmove+0xfc>
    8000391c:	0005c703          	lbu	a4,0(a1)
    80003920:	00e78023          	sb	a4,0(a5)
    80003924:	04068e63          	beqz	a3,80003980 <__memmove+0xfc>
    80003928:	0015c603          	lbu	a2,1(a1)
    8000392c:	00100713          	li	a4,1
    80003930:	00c780a3          	sb	a2,1(a5)
    80003934:	04e68663          	beq	a3,a4,80003980 <__memmove+0xfc>
    80003938:	0025c603          	lbu	a2,2(a1)
    8000393c:	00200713          	li	a4,2
    80003940:	00c78123          	sb	a2,2(a5)
    80003944:	02e68e63          	beq	a3,a4,80003980 <__memmove+0xfc>
    80003948:	0035c603          	lbu	a2,3(a1)
    8000394c:	00300713          	li	a4,3
    80003950:	00c781a3          	sb	a2,3(a5)
    80003954:	02e68663          	beq	a3,a4,80003980 <__memmove+0xfc>
    80003958:	0045c603          	lbu	a2,4(a1)
    8000395c:	00400713          	li	a4,4
    80003960:	00c78223          	sb	a2,4(a5)
    80003964:	00e68e63          	beq	a3,a4,80003980 <__memmove+0xfc>
    80003968:	0055c603          	lbu	a2,5(a1)
    8000396c:	00500713          	li	a4,5
    80003970:	00c782a3          	sb	a2,5(a5)
    80003974:	00e68663          	beq	a3,a4,80003980 <__memmove+0xfc>
    80003978:	0065c703          	lbu	a4,6(a1)
    8000397c:	00e78323          	sb	a4,6(a5)
    80003980:	00813403          	ld	s0,8(sp)
    80003984:	01010113          	addi	sp,sp,16
    80003988:	00008067          	ret
    8000398c:	02061713          	slli	a4,a2,0x20
    80003990:	02075713          	srli	a4,a4,0x20
    80003994:	00e587b3          	add	a5,a1,a4
    80003998:	f0f574e3          	bgeu	a0,a5,800038a0 <__memmove+0x1c>
    8000399c:	02069613          	slli	a2,a3,0x20
    800039a0:	02065613          	srli	a2,a2,0x20
    800039a4:	fff64613          	not	a2,a2
    800039a8:	00e50733          	add	a4,a0,a4
    800039ac:	00c78633          	add	a2,a5,a2
    800039b0:	fff7c683          	lbu	a3,-1(a5)
    800039b4:	fff78793          	addi	a5,a5,-1
    800039b8:	fff70713          	addi	a4,a4,-1
    800039bc:	00d70023          	sb	a3,0(a4)
    800039c0:	fec798e3          	bne	a5,a2,800039b0 <__memmove+0x12c>
    800039c4:	00813403          	ld	s0,8(sp)
    800039c8:	01010113          	addi	sp,sp,16
    800039cc:	00008067          	ret
    800039d0:	02069713          	slli	a4,a3,0x20
    800039d4:	02075713          	srli	a4,a4,0x20
    800039d8:	00170713          	addi	a4,a4,1
    800039dc:	00e50733          	add	a4,a0,a4
    800039e0:	00050793          	mv	a5,a0
    800039e4:	0005c683          	lbu	a3,0(a1)
    800039e8:	00178793          	addi	a5,a5,1
    800039ec:	00158593          	addi	a1,a1,1
    800039f0:	fed78fa3          	sb	a3,-1(a5)
    800039f4:	fee798e3          	bne	a5,a4,800039e4 <__memmove+0x160>
    800039f8:	f89ff06f          	j	80003980 <__memmove+0xfc>

00000000800039fc <__putc>:
    800039fc:	fe010113          	addi	sp,sp,-32
    80003a00:	00813823          	sd	s0,16(sp)
    80003a04:	00113c23          	sd	ra,24(sp)
    80003a08:	02010413          	addi	s0,sp,32
    80003a0c:	00050793          	mv	a5,a0
    80003a10:	fef40593          	addi	a1,s0,-17
    80003a14:	00100613          	li	a2,1
    80003a18:	00000513          	li	a0,0
    80003a1c:	fef407a3          	sb	a5,-17(s0)
    80003a20:	fffff097          	auipc	ra,0xfffff
    80003a24:	b3c080e7          	jalr	-1220(ra) # 8000255c <console_write>
    80003a28:	01813083          	ld	ra,24(sp)
    80003a2c:	01013403          	ld	s0,16(sp)
    80003a30:	02010113          	addi	sp,sp,32
    80003a34:	00008067          	ret

0000000080003a38 <__getc>:
    80003a38:	fe010113          	addi	sp,sp,-32
    80003a3c:	00813823          	sd	s0,16(sp)
    80003a40:	00113c23          	sd	ra,24(sp)
    80003a44:	02010413          	addi	s0,sp,32
    80003a48:	fe840593          	addi	a1,s0,-24
    80003a4c:	00100613          	li	a2,1
    80003a50:	00000513          	li	a0,0
    80003a54:	fffff097          	auipc	ra,0xfffff
    80003a58:	ae8080e7          	jalr	-1304(ra) # 8000253c <console_read>
    80003a5c:	fe844503          	lbu	a0,-24(s0)
    80003a60:	01813083          	ld	ra,24(sp)
    80003a64:	01013403          	ld	s0,16(sp)
    80003a68:	02010113          	addi	sp,sp,32
    80003a6c:	00008067          	ret

0000000080003a70 <console_handler>:
    80003a70:	fe010113          	addi	sp,sp,-32
    80003a74:	00813823          	sd	s0,16(sp)
    80003a78:	00113c23          	sd	ra,24(sp)
    80003a7c:	00913423          	sd	s1,8(sp)
    80003a80:	02010413          	addi	s0,sp,32
    80003a84:	14202773          	csrr	a4,scause
    80003a88:	100027f3          	csrr	a5,sstatus
    80003a8c:	0027f793          	andi	a5,a5,2
    80003a90:	06079e63          	bnez	a5,80003b0c <console_handler+0x9c>
    80003a94:	00074c63          	bltz	a4,80003aac <console_handler+0x3c>
    80003a98:	01813083          	ld	ra,24(sp)
    80003a9c:	01013403          	ld	s0,16(sp)
    80003aa0:	00813483          	ld	s1,8(sp)
    80003aa4:	02010113          	addi	sp,sp,32
    80003aa8:	00008067          	ret
    80003aac:	0ff77713          	andi	a4,a4,255
    80003ab0:	00900793          	li	a5,9
    80003ab4:	fef712e3          	bne	a4,a5,80003a98 <console_handler+0x28>
    80003ab8:	ffffe097          	auipc	ra,0xffffe
    80003abc:	6dc080e7          	jalr	1756(ra) # 80002194 <plic_claim>
    80003ac0:	00a00793          	li	a5,10
    80003ac4:	00050493          	mv	s1,a0
    80003ac8:	02f50c63          	beq	a0,a5,80003b00 <console_handler+0x90>
    80003acc:	fc0506e3          	beqz	a0,80003a98 <console_handler+0x28>
    80003ad0:	00050593          	mv	a1,a0
    80003ad4:	00000517          	auipc	a0,0x0
    80003ad8:	62c50513          	addi	a0,a0,1580 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80003adc:	fffff097          	auipc	ra,0xfffff
    80003ae0:	afc080e7          	jalr	-1284(ra) # 800025d8 <__printf>
    80003ae4:	01013403          	ld	s0,16(sp)
    80003ae8:	01813083          	ld	ra,24(sp)
    80003aec:	00048513          	mv	a0,s1
    80003af0:	00813483          	ld	s1,8(sp)
    80003af4:	02010113          	addi	sp,sp,32
    80003af8:	ffffe317          	auipc	t1,0xffffe
    80003afc:	6d430067          	jr	1748(t1) # 800021cc <plic_complete>
    80003b00:	fffff097          	auipc	ra,0xfffff
    80003b04:	3e0080e7          	jalr	992(ra) # 80002ee0 <uartintr>
    80003b08:	fddff06f          	j	80003ae4 <console_handler+0x74>
    80003b0c:	00000517          	auipc	a0,0x0
    80003b10:	6f450513          	addi	a0,a0,1780 # 80004200 <digits+0x78>
    80003b14:	fffff097          	auipc	ra,0xfffff
    80003b18:	a68080e7          	jalr	-1432(ra) # 8000257c <panic>
	...
