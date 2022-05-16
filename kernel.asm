
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	43013103          	ld	sp,1072(sp) # 80004430 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	07d010ef          	jal	ra,80001898 <start>

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
    void* res = nullptr;
    asm volatile("csrw stvec, %0" : : "r" (&interrupt)); // ovo treba uraditi na pocetku programa
    80001234:	00003797          	auipc	a5,0x3
    80001238:	20c7b783          	ld	a5,524(a5) # 80004440 <_GLOBAL_OFFSET_TABLE_+0x20>
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
    800012a4:	208080e7          	jalr	520(ra) # 800014a8 <_ZN15MemoryAllocator9mem_allocEm>
    800012a8:	fe1ff06f          	j	80001288 <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    800012ac:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    800012b0:	00000097          	auipc	ra,0x0
    800012b4:	368080e7          	jalr	872(ra) # 80001618 <_ZN15MemoryAllocator8mem_freeEPv>
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
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800012e4:	00100793          	li	a5,1
    800012e8:	00078513          	mv	a0,a5
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800012ec:	00050593          	mv	a1,a0

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
    80001348:	14c70713          	addi	a4,a4,332 # 80004490 <_ZZ12checkNullptrPvE1x>
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
    80001374:	5ec080e7          	jalr	1516(ra) # 8000395c <__putc>
        __putc('0' + x);
    80001378:	00003517          	auipc	a0,0x3
    8000137c:	11852503          	lw	a0,280(a0) # 80004490 <_ZZ12checkNullptrPvE1x>
    80001380:	0305051b          	addiw	a0,a0,48
    80001384:	0ff57513          	andi	a0,a0,255
    80001388:	00002097          	auipc	ra,0x2
    8000138c:	5d4080e7          	jalr	1492(ra) # 8000395c <__putc>
    x++;
    80001390:	00003717          	auipc	a4,0x3
    80001394:	10070713          	addi	a4,a4,256 # 80004490 <_ZZ12checkNullptrPvE1x>
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
    800013bc:	0d870713          	addi	a4,a4,216 # 80004490 <_ZZ12checkNullptrPvE1x>
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
    800013e4:	0b452503          	lw	a0,180(a0) # 80004494 <_ZZ11checkStatusiE1y>
    800013e8:	0305051b          	addiw	a0,a0,48
    800013ec:	0ff57513          	andi	a0,a0,255
    800013f0:	00002097          	auipc	ra,0x2
    800013f4:	56c080e7          	jalr	1388(ra) # 8000395c <__putc>
        __putc('?');
    800013f8:	03f00513          	li	a0,63
    800013fc:	00002097          	auipc	ra,0x2
    80001400:	560080e7          	jalr	1376(ra) # 8000395c <__putc>
    y++;
    80001404:	00003717          	auipc	a4,0x3
    80001408:	08c70713          	addi	a4,a4,140 # 80004490 <_ZZ12checkNullptrPvE1x>
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
    int* par = (int*)mem_alloc(2*sizeof(int));
    8000143c:	00800513          	li	a0,8
    80001440:	00000097          	auipc	ra,0x0
    80001444:	e84080e7          	jalr	-380(ra) # 800012c4 <_Z9mem_allocm>
    80001448:	00050493          	mv	s1,a0
    checkNullptr(par);
    8000144c:	00000097          	auipc	ra,0x0
    80001450:	ef4080e7          	jalr	-268(ra) # 80001340 <_Z12checkNullptrPv>
    par[0] = 1;
    80001454:	00100793          	li	a5,1
    80001458:	00f4a023          	sw	a5,0(s1)
    par[1] = 2;
    8000145c:	00200793          	li	a5,2
    80001460:	00f4a223          	sw	a5,4(s1)

    printInteger(par[0]);
    80001464:	00100513          	li	a0,1
    80001468:	00000097          	auipc	ra,0x0
    8000146c:	3a0080e7          	jalr	928(ra) # 80001808 <_Z12printIntegerm>
    printInteger(par[1]);
    80001470:	0044a503          	lw	a0,4(s1)
    80001474:	00000097          	auipc	ra,0x0
    80001478:	394080e7          	jalr	916(ra) # 80001808 <_Z12printIntegerm>

    int status = mem_free(par);
    8000147c:	00048513          	mv	a0,s1
    80001480:	00000097          	auipc	ra,0x0
    80001484:	e88080e7          	jalr	-376(ra) # 80001308 <_Z8mem_freePv>
    checkStatus(status);
    80001488:	00000097          	auipc	ra,0x0
    8000148c:	f2c080e7          	jalr	-212(ra) # 800013b4 <_Z11checkStatusi>
    return 0;
    80001490:	00000513          	li	a0,0
    80001494:	01813083          	ld	ra,24(sp)
    80001498:	01013403          	ld	s0,16(sp)
    8000149c:	00813483          	ld	s1,8(sp)
    800014a0:	02010113          	addi	sp,sp,32
    800014a4:	00008067          	ret

00000000800014a8 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    800014a8:	ff010113          	addi	sp,sp,-16
    800014ac:	00813423          	sd	s0,8(sp)
    800014b0:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800014b4:	00003797          	auipc	a5,0x3
    800014b8:	fe47b783          	ld	a5,-28(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    800014bc:	02078c63          	beqz	a5,800014f4 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    800014c0:	00003717          	auipc	a4,0x3
    800014c4:	f7873703          	ld	a4,-136(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014c8:	00073703          	ld	a4,0(a4)
    800014cc:	14e78263          	beq	a5,a4,80001610 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800014d0:	00850613          	addi	a2,a0,8
    800014d4:	00665813          	srli	a6,a2,0x6
    800014d8:	03f67793          	andi	a5,a2,63
    800014dc:	00f037b3          	snez	a5,a5
    800014e0:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800014e4:	00003517          	auipc	a0,0x3
    800014e8:	fb453503          	ld	a0,-76(a0) # 80004498 <_ZN15MemoryAllocator4headE>
    800014ec:	00000593          	li	a1,0
    800014f0:	0a80006f          	j	80001598 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800014f4:	00003697          	auipc	a3,0x3
    800014f8:	f346b683          	ld	a3,-204(a3) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    800014fc:	0006b783          	ld	a5,0(a3)
    80001500:	00003717          	auipc	a4,0x3
    80001504:	f8f73c23          	sd	a5,-104(a4) # 80004498 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001508:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    8000150c:	00003717          	auipc	a4,0x3
    80001510:	f2c73703          	ld	a4,-212(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001514:	00073703          	ld	a4,0(a4)
    80001518:	0006b683          	ld	a3,0(a3)
    8000151c:	40d70733          	sub	a4,a4,a3
    80001520:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001524:	0007b823          	sd	zero,16(a5)
    80001528:	fa9ff06f          	j	800014d0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    8000152c:	00058e63          	beqz	a1,80001548 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001530:	0105b703          	ld	a4,16(a1)
    80001534:	04070a63          	beqz	a4,80001588 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001538:	01073703          	ld	a4,16(a4)
    8000153c:	00e5b823          	sd	a4,16(a1)
                allocatedSize = curr->size;
    80001540:	00078813          	mv	a6,a5
    80001544:	0b80006f          	j	800015fc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001548:	01053703          	ld	a4,16(a0)
    8000154c:	00070a63          	beqz	a4,80001560 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001550:	00003617          	auipc	a2,0x3
    80001554:	f4e63423          	sd	a4,-184(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001558:	00078813          	mv	a6,a5
    8000155c:	0a00006f          	j	800015fc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001560:	00003717          	auipc	a4,0x3
    80001564:	ed873703          	ld	a4,-296(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001568:	00073703          	ld	a4,0(a4)
    8000156c:	00003617          	auipc	a2,0x3
    80001570:	f2e63623          	sd	a4,-212(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001574:	00078813          	mv	a6,a5
    80001578:	0840006f          	j	800015fc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    8000157c:	00003797          	auipc	a5,0x3
    80001580:	f0e7be23          	sd	a4,-228(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001584:	0780006f          	j	800015fc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80001588:	00078813          	mv	a6,a5
    8000158c:	0700006f          	j	800015fc <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001590:	00050593          	mv	a1,a0
        curr = curr->next;
    80001594:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001598:	06050663          	beqz	a0,80001604 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    8000159c:	00853783          	ld	a5,8(a0)
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800015a0:	0067d693          	srli	a3,a5,0x6
    800015a4:	03f7f713          	andi	a4,a5,63
    800015a8:	00e03733          	snez	a4,a4
    800015ac:	00e68733          	add	a4,a3,a4
        void* startOfAllocatedSpace = curr->baseAddr;
    800015b0:	00053683          	ld	a3,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800015b4:	fcc7eee3          	bltu	a5,a2,80001590 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    800015b8:	fd076ce3          	bltu	a4,a6,80001590 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800015bc:	f6e808e3          	beq	a6,a4,8000152c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    800015c0:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    800015c4:	01068733          	add	a4,a3,a6
                size_t newSize = curr->size - allocatedSize;
    800015c8:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800015cc:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800015d0:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800015d4:	01053783          	ld	a5,16(a0)
    800015d8:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800015dc:	fa0580e3          	beqz	a1,8000157c <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    800015e0:	0105b783          	ld	a5,16(a1)
    800015e4:	00078663          	beqz	a5,800015f0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    800015e8:	0107b783          	ld	a5,16(a5)
    800015ec:	00f5b823          	sd	a5,16(a1)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800015f0:	0105b783          	ld	a5,16(a1)
    800015f4:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800015f8:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800015fc:	0106b023          	sd	a6,0(a3)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001600:	00868513          	addi	a0,a3,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001604:	00813403          	ld	s0,8(sp)
    80001608:	01010113          	addi	sp,sp,16
    8000160c:	00008067          	ret
        return nullptr;
    80001610:	00000513          	li	a0,0
    80001614:	ff1ff06f          	j	80001604 <_ZN15MemoryAllocator9mem_allocEm+0x15c>

0000000080001618 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001618:	ff010113          	addi	sp,sp,-16
    8000161c:	00813423          	sd	s0,8(sp)
    80001620:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001624:	16050063          	beqz	a0,80001784 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001628:	ff850713          	addi	a4,a0,-8
    8000162c:	00003797          	auipc	a5,0x3
    80001630:	dfc7b783          	ld	a5,-516(a5) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001634:	0007b783          	ld	a5,0(a5)
    80001638:	14f76a63          	bltu	a4,a5,8000178c <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    8000163c:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001640:	fff58693          	addi	a3,a1,-1
    80001644:	00d706b3          	add	a3,a4,a3
    80001648:	00003617          	auipc	a2,0x3
    8000164c:	df063603          	ld	a2,-528(a2) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001650:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001654:	14c6f063          	bgeu	a3,a2,80001794 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001658:	14070263          	beqz	a4,8000179c <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    8000165c:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001660:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001664:	14079063          	bnez	a5,800017a4 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001668:	03f00793          	li	a5,63
    8000166c:	14b7f063          	bgeu	a5,a1,800017ac <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001670:	00003797          	auipc	a5,0x3
    80001674:	e287b783          	ld	a5,-472(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001678:	02f60063          	beq	a2,a5,80001698 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    8000167c:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001680:	02078a63          	beqz	a5,800016b4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001684:	0007b683          	ld	a3,0(a5)
    80001688:	02e6f663          	bgeu	a3,a4,800016b4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    8000168c:	00078613          	mv	a2,a5
        curr = curr->next;
    80001690:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001694:	fedff06f          	j	80001680 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001698:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    8000169c:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800016a0:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800016a4:	00003797          	auipc	a5,0x3
    800016a8:	dee7ba23          	sd	a4,-524(a5) # 80004498 <_ZN15MemoryAllocator4headE>
        return 0;
    800016ac:	00000513          	li	a0,0
    800016b0:	0480006f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    800016b4:	04060863          	beqz	a2,80001704 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800016b8:	00063683          	ld	a3,0(a2)
    800016bc:	00863803          	ld	a6,8(a2)
    800016c0:	010686b3          	add	a3,a3,a6
    800016c4:	08e68a63          	beq	a3,a4,80001758 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800016c8:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800016cc:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800016d0:	01063683          	ld	a3,16(a2)
    800016d4:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800016d8:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800016dc:	0e078063          	beqz	a5,800017bc <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    800016e0:	0007b583          	ld	a1,0(a5)
    800016e4:	00073683          	ld	a3,0(a4)
    800016e8:	00873603          	ld	a2,8(a4)
    800016ec:	00c686b3          	add	a3,a3,a2
    800016f0:	06d58c63          	beq	a1,a3,80001768 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800016f4:	00000513          	li	a0,0
}
    800016f8:	00813403          	ld	s0,8(sp)
    800016fc:	01010113          	addi	sp,sp,16
    80001700:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80001704:	0a078863          	beqz	a5,800017b4 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80001708:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    8000170c:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001710:	00003797          	auipc	a5,0x3
    80001714:	d887b783          	ld	a5,-632(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001718:	0007b603          	ld	a2,0(a5)
    8000171c:	00b706b3          	add	a3,a4,a1
    80001720:	00d60c63          	beq	a2,a3,80001738 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80001724:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001728:	00003797          	auipc	a5,0x3
    8000172c:	d6e7b823          	sd	a4,-656(a5) # 80004498 <_ZN15MemoryAllocator4headE>
            return 0;
    80001730:	00000513          	li	a0,0
    80001734:	fc5ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001738:	0087b783          	ld	a5,8(a5)
    8000173c:	00b785b3          	add	a1,a5,a1
    80001740:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80001744:	00003797          	auipc	a5,0x3
    80001748:	d547b783          	ld	a5,-684(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    8000174c:	0107b783          	ld	a5,16(a5)
    80001750:	00f53423          	sd	a5,8(a0)
    80001754:	fd5ff06f          	j	80001728 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001758:	00b805b3          	add	a1,a6,a1
    8000175c:	00b63423          	sd	a1,8(a2)
    80001760:	00060713          	mv	a4,a2
    80001764:	f79ff06f          	j	800016dc <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001768:	0087b683          	ld	a3,8(a5)
    8000176c:	00d60633          	add	a2,a2,a3
    80001770:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001774:	0107b783          	ld	a5,16(a5)
    80001778:	00f73823          	sd	a5,16(a4)
    return 0;
    8000177c:	00000513          	li	a0,0
    80001780:	f79ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001784:	fff00513          	li	a0,-1
    80001788:	f71ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000178c:	fff00513          	li	a0,-1
    80001790:	f69ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001794:	fff00513          	li	a0,-1
    80001798:	f61ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000179c:	fff00513          	li	a0,-1
    800017a0:	f59ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800017a4:	fff00513          	li	a0,-1
    800017a8:	f51ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800017ac:	fff00513          	li	a0,-1
    800017b0:	f49ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    800017b4:	fff00513          	li	a0,-1
    800017b8:	f41ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    800017bc:	00000513          	li	a0,0
    800017c0:	f39ff06f          	j	800016f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

00000000800017c4 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../lib/console.h"

void printString(char const *string)
{
    800017c4:	fe010113          	addi	sp,sp,-32
    800017c8:	00113c23          	sd	ra,24(sp)
    800017cc:	00813823          	sd	s0,16(sp)
    800017d0:	00913423          	sd	s1,8(sp)
    800017d4:	02010413          	addi	s0,sp,32
    800017d8:	00050493          	mv	s1,a0
    while (*string != '\0')
    800017dc:	0004c503          	lbu	a0,0(s1)
    800017e0:	00050a63          	beqz	a0,800017f4 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    800017e4:	00002097          	auipc	ra,0x2
    800017e8:	178080e7          	jalr	376(ra) # 8000395c <__putc>
        string++;
    800017ec:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800017f0:	fedff06f          	j	800017dc <_Z11printStringPKc+0x18>
    }
}
    800017f4:	01813083          	ld	ra,24(sp)
    800017f8:	01013403          	ld	s0,16(sp)
    800017fc:	00813483          	ld	s1,8(sp)
    80001800:	02010113          	addi	sp,sp,32
    80001804:	00008067          	ret

0000000080001808 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    80001808:	fd010113          	addi	sp,sp,-48
    8000180c:	02113423          	sd	ra,40(sp)
    80001810:	02813023          	sd	s0,32(sp)
    80001814:	00913c23          	sd	s1,24(sp)
    80001818:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    8000181c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001820:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001824:	00a00613          	li	a2,10
    80001828:	02c5773b          	remuw	a4,a0,a2
    8000182c:	02071693          	slli	a3,a4,0x20
    80001830:	0206d693          	srli	a3,a3,0x20
    80001834:	00002717          	auipc	a4,0x2
    80001838:	7ec70713          	addi	a4,a4,2028 # 80004020 <_ZZ12printIntegermE6digits>
    8000183c:	00d70733          	add	a4,a4,a3
    80001840:	00074703          	lbu	a4,0(a4)
    80001844:	fe040693          	addi	a3,s0,-32
    80001848:	009687b3          	add	a5,a3,s1
    8000184c:	0014849b          	addiw	s1,s1,1
    80001850:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001854:	0005071b          	sext.w	a4,a0
    80001858:	02c5553b          	divuw	a0,a0,a2
    8000185c:	00900793          	li	a5,9
    80001860:	fce7e2e3          	bltu	a5,a4,80001824 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    80001864:	fff4849b          	addiw	s1,s1,-1
    80001868:	0004ce63          	bltz	s1,80001884 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    8000186c:	fe040793          	addi	a5,s0,-32
    80001870:	009787b3          	add	a5,a5,s1
    80001874:	ff07c503          	lbu	a0,-16(a5)
    80001878:	00002097          	auipc	ra,0x2
    8000187c:	0e4080e7          	jalr	228(ra) # 8000395c <__putc>
    80001880:	fe5ff06f          	j	80001864 <_Z12printIntegerm+0x5c>
    80001884:	02813083          	ld	ra,40(sp)
    80001888:	02013403          	ld	s0,32(sp)
    8000188c:	01813483          	ld	s1,24(sp)
    80001890:	03010113          	addi	sp,sp,48
    80001894:	00008067          	ret

0000000080001898 <start>:
    80001898:	ff010113          	addi	sp,sp,-16
    8000189c:	00813423          	sd	s0,8(sp)
    800018a0:	01010413          	addi	s0,sp,16
    800018a4:	300027f3          	csrr	a5,mstatus
    800018a8:	ffffe737          	lui	a4,0xffffe
    800018ac:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff910f>
    800018b0:	00e7f7b3          	and	a5,a5,a4
    800018b4:	00001737          	lui	a4,0x1
    800018b8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800018bc:	00e7e7b3          	or	a5,a5,a4
    800018c0:	30079073          	csrw	mstatus,a5
    800018c4:	00000797          	auipc	a5,0x0
    800018c8:	16078793          	addi	a5,a5,352 # 80001a24 <system_main>
    800018cc:	34179073          	csrw	mepc,a5
    800018d0:	00000793          	li	a5,0
    800018d4:	18079073          	csrw	satp,a5
    800018d8:	000107b7          	lui	a5,0x10
    800018dc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800018e0:	30279073          	csrw	medeleg,a5
    800018e4:	30379073          	csrw	mideleg,a5
    800018e8:	104027f3          	csrr	a5,sie
    800018ec:	2227e793          	ori	a5,a5,546
    800018f0:	10479073          	csrw	sie,a5
    800018f4:	fff00793          	li	a5,-1
    800018f8:	00a7d793          	srli	a5,a5,0xa
    800018fc:	3b079073          	csrw	pmpaddr0,a5
    80001900:	00f00793          	li	a5,15
    80001904:	3a079073          	csrw	pmpcfg0,a5
    80001908:	f14027f3          	csrr	a5,mhartid
    8000190c:	0200c737          	lui	a4,0x200c
    80001910:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001914:	0007869b          	sext.w	a3,a5
    80001918:	00269713          	slli	a4,a3,0x2
    8000191c:	000f4637          	lui	a2,0xf4
    80001920:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001924:	00d70733          	add	a4,a4,a3
    80001928:	0037979b          	slliw	a5,a5,0x3
    8000192c:	020046b7          	lui	a3,0x2004
    80001930:	00d787b3          	add	a5,a5,a3
    80001934:	00c585b3          	add	a1,a1,a2
    80001938:	00371693          	slli	a3,a4,0x3
    8000193c:	00003717          	auipc	a4,0x3
    80001940:	b6470713          	addi	a4,a4,-1180 # 800044a0 <timer_scratch>
    80001944:	00b7b023          	sd	a1,0(a5)
    80001948:	00d70733          	add	a4,a4,a3
    8000194c:	00f73c23          	sd	a5,24(a4)
    80001950:	02c73023          	sd	a2,32(a4)
    80001954:	34071073          	csrw	mscratch,a4
    80001958:	00000797          	auipc	a5,0x0
    8000195c:	6e878793          	addi	a5,a5,1768 # 80002040 <timervec>
    80001960:	30579073          	csrw	mtvec,a5
    80001964:	300027f3          	csrr	a5,mstatus
    80001968:	0087e793          	ori	a5,a5,8
    8000196c:	30079073          	csrw	mstatus,a5
    80001970:	304027f3          	csrr	a5,mie
    80001974:	0807e793          	ori	a5,a5,128
    80001978:	30479073          	csrw	mie,a5
    8000197c:	f14027f3          	csrr	a5,mhartid
    80001980:	0007879b          	sext.w	a5,a5
    80001984:	00078213          	mv	tp,a5
    80001988:	30200073          	mret
    8000198c:	00813403          	ld	s0,8(sp)
    80001990:	01010113          	addi	sp,sp,16
    80001994:	00008067          	ret

0000000080001998 <timerinit>:
    80001998:	ff010113          	addi	sp,sp,-16
    8000199c:	00813423          	sd	s0,8(sp)
    800019a0:	01010413          	addi	s0,sp,16
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
    800019dc:	ac870713          	addi	a4,a4,-1336 # 800044a0 <timer_scratch>
    800019e0:	00b7b023          	sd	a1,0(a5)
    800019e4:	00d70733          	add	a4,a4,a3
    800019e8:	00f73c23          	sd	a5,24(a4)
    800019ec:	02c73023          	sd	a2,32(a4)
    800019f0:	34071073          	csrw	mscratch,a4
    800019f4:	00000797          	auipc	a5,0x0
    800019f8:	64c78793          	addi	a5,a5,1612 # 80002040 <timervec>
    800019fc:	30579073          	csrw	mtvec,a5
    80001a00:	300027f3          	csrr	a5,mstatus
    80001a04:	0087e793          	ori	a5,a5,8
    80001a08:	30079073          	csrw	mstatus,a5
    80001a0c:	304027f3          	csrr	a5,mie
    80001a10:	0807e793          	ori	a5,a5,128
    80001a14:	30479073          	csrw	mie,a5
    80001a18:	00813403          	ld	s0,8(sp)
    80001a1c:	01010113          	addi	sp,sp,16
    80001a20:	00008067          	ret

0000000080001a24 <system_main>:
    80001a24:	fe010113          	addi	sp,sp,-32
    80001a28:	00813823          	sd	s0,16(sp)
    80001a2c:	00913423          	sd	s1,8(sp)
    80001a30:	00113c23          	sd	ra,24(sp)
    80001a34:	02010413          	addi	s0,sp,32
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	0c4080e7          	jalr	196(ra) # 80001afc <cpuid>
    80001a40:	00003497          	auipc	s1,0x3
    80001a44:	a2048493          	addi	s1,s1,-1504 # 80004460 <started>
    80001a48:	02050263          	beqz	a0,80001a6c <system_main+0x48>
    80001a4c:	0004a783          	lw	a5,0(s1)
    80001a50:	0007879b          	sext.w	a5,a5
    80001a54:	fe078ce3          	beqz	a5,80001a4c <system_main+0x28>
    80001a58:	0ff0000f          	fence
    80001a5c:	00002517          	auipc	a0,0x2
    80001a60:	60450513          	addi	a0,a0,1540 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    80001a64:	00001097          	auipc	ra,0x1
    80001a68:	a78080e7          	jalr	-1416(ra) # 800024dc <panic>
    80001a6c:	00001097          	auipc	ra,0x1
    80001a70:	9cc080e7          	jalr	-1588(ra) # 80002438 <consoleinit>
    80001a74:	00001097          	auipc	ra,0x1
    80001a78:	158080e7          	jalr	344(ra) # 80002bcc <printfinit>
    80001a7c:	00002517          	auipc	a0,0x2
    80001a80:	6c450513          	addi	a0,a0,1732 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001a84:	00001097          	auipc	ra,0x1
    80001a88:	ab4080e7          	jalr	-1356(ra) # 80002538 <__printf>
    80001a8c:	00002517          	auipc	a0,0x2
    80001a90:	5a450513          	addi	a0,a0,1444 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    80001a94:	00001097          	auipc	ra,0x1
    80001a98:	aa4080e7          	jalr	-1372(ra) # 80002538 <__printf>
    80001a9c:	00002517          	auipc	a0,0x2
    80001aa0:	6a450513          	addi	a0,a0,1700 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001aa4:	00001097          	auipc	ra,0x1
    80001aa8:	a94080e7          	jalr	-1388(ra) # 80002538 <__printf>
    80001aac:	00001097          	auipc	ra,0x1
    80001ab0:	4ac080e7          	jalr	1196(ra) # 80002f58 <kinit>
    80001ab4:	00000097          	auipc	ra,0x0
    80001ab8:	148080e7          	jalr	328(ra) # 80001bfc <trapinit>
    80001abc:	00000097          	auipc	ra,0x0
    80001ac0:	16c080e7          	jalr	364(ra) # 80001c28 <trapinithart>
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	5bc080e7          	jalr	1468(ra) # 80002080 <plicinit>
    80001acc:	00000097          	auipc	ra,0x0
    80001ad0:	5dc080e7          	jalr	1500(ra) # 800020a8 <plicinithart>
    80001ad4:	00000097          	auipc	ra,0x0
    80001ad8:	078080e7          	jalr	120(ra) # 80001b4c <userinit>
    80001adc:	0ff0000f          	fence
    80001ae0:	00100793          	li	a5,1
    80001ae4:	00002517          	auipc	a0,0x2
    80001ae8:	56450513          	addi	a0,a0,1380 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    80001aec:	00f4a023          	sw	a5,0(s1)
    80001af0:	00001097          	auipc	ra,0x1
    80001af4:	a48080e7          	jalr	-1464(ra) # 80002538 <__printf>
    80001af8:	0000006f          	j	80001af8 <system_main+0xd4>

0000000080001afc <cpuid>:
    80001afc:	ff010113          	addi	sp,sp,-16
    80001b00:	00813423          	sd	s0,8(sp)
    80001b04:	01010413          	addi	s0,sp,16
    80001b08:	00020513          	mv	a0,tp
    80001b0c:	00813403          	ld	s0,8(sp)
    80001b10:	0005051b          	sext.w	a0,a0
    80001b14:	01010113          	addi	sp,sp,16
    80001b18:	00008067          	ret

0000000080001b1c <mycpu>:
    80001b1c:	ff010113          	addi	sp,sp,-16
    80001b20:	00813423          	sd	s0,8(sp)
    80001b24:	01010413          	addi	s0,sp,16
    80001b28:	00020793          	mv	a5,tp
    80001b2c:	00813403          	ld	s0,8(sp)
    80001b30:	0007879b          	sext.w	a5,a5
    80001b34:	00779793          	slli	a5,a5,0x7
    80001b38:	00004517          	auipc	a0,0x4
    80001b3c:	99850513          	addi	a0,a0,-1640 # 800054d0 <cpus>
    80001b40:	00f50533          	add	a0,a0,a5
    80001b44:	01010113          	addi	sp,sp,16
    80001b48:	00008067          	ret

0000000080001b4c <userinit>:
    80001b4c:	ff010113          	addi	sp,sp,-16
    80001b50:	00813423          	sd	s0,8(sp)
    80001b54:	01010413          	addi	s0,sp,16
    80001b58:	00813403          	ld	s0,8(sp)
    80001b5c:	01010113          	addi	sp,sp,16
    80001b60:	00000317          	auipc	t1,0x0
    80001b64:	8c830067          	jr	-1848(t1) # 80001428 <main>

0000000080001b68 <either_copyout>:
    80001b68:	ff010113          	addi	sp,sp,-16
    80001b6c:	00813023          	sd	s0,0(sp)
    80001b70:	00113423          	sd	ra,8(sp)
    80001b74:	01010413          	addi	s0,sp,16
    80001b78:	02051663          	bnez	a0,80001ba4 <either_copyout+0x3c>
    80001b7c:	00058513          	mv	a0,a1
    80001b80:	00060593          	mv	a1,a2
    80001b84:	0006861b          	sext.w	a2,a3
    80001b88:	00002097          	auipc	ra,0x2
    80001b8c:	c5c080e7          	jalr	-932(ra) # 800037e4 <__memmove>
    80001b90:	00813083          	ld	ra,8(sp)
    80001b94:	00013403          	ld	s0,0(sp)
    80001b98:	00000513          	li	a0,0
    80001b9c:	01010113          	addi	sp,sp,16
    80001ba0:	00008067          	ret
    80001ba4:	00002517          	auipc	a0,0x2
    80001ba8:	4e450513          	addi	a0,a0,1252 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001bac:	00001097          	auipc	ra,0x1
    80001bb0:	930080e7          	jalr	-1744(ra) # 800024dc <panic>

0000000080001bb4 <either_copyin>:
    80001bb4:	ff010113          	addi	sp,sp,-16
    80001bb8:	00813023          	sd	s0,0(sp)
    80001bbc:	00113423          	sd	ra,8(sp)
    80001bc0:	01010413          	addi	s0,sp,16
    80001bc4:	02059463          	bnez	a1,80001bec <either_copyin+0x38>
    80001bc8:	00060593          	mv	a1,a2
    80001bcc:	0006861b          	sext.w	a2,a3
    80001bd0:	00002097          	auipc	ra,0x2
    80001bd4:	c14080e7          	jalr	-1004(ra) # 800037e4 <__memmove>
    80001bd8:	00813083          	ld	ra,8(sp)
    80001bdc:	00013403          	ld	s0,0(sp)
    80001be0:	00000513          	li	a0,0
    80001be4:	01010113          	addi	sp,sp,16
    80001be8:	00008067          	ret
    80001bec:	00002517          	auipc	a0,0x2
    80001bf0:	4c450513          	addi	a0,a0,1220 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    80001bf4:	00001097          	auipc	ra,0x1
    80001bf8:	8e8080e7          	jalr	-1816(ra) # 800024dc <panic>

0000000080001bfc <trapinit>:
    80001bfc:	ff010113          	addi	sp,sp,-16
    80001c00:	00813423          	sd	s0,8(sp)
    80001c04:	01010413          	addi	s0,sp,16
    80001c08:	00813403          	ld	s0,8(sp)
    80001c0c:	00002597          	auipc	a1,0x2
    80001c10:	4cc58593          	addi	a1,a1,1228 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    80001c14:	00004517          	auipc	a0,0x4
    80001c18:	93c50513          	addi	a0,a0,-1732 # 80005550 <tickslock>
    80001c1c:	01010113          	addi	sp,sp,16
    80001c20:	00001317          	auipc	t1,0x1
    80001c24:	5c830067          	jr	1480(t1) # 800031e8 <initlock>

0000000080001c28 <trapinithart>:
    80001c28:	ff010113          	addi	sp,sp,-16
    80001c2c:	00813423          	sd	s0,8(sp)
    80001c30:	01010413          	addi	s0,sp,16
    80001c34:	00000797          	auipc	a5,0x0
    80001c38:	2fc78793          	addi	a5,a5,764 # 80001f30 <kernelvec>
    80001c3c:	10579073          	csrw	stvec,a5
    80001c40:	00813403          	ld	s0,8(sp)
    80001c44:	01010113          	addi	sp,sp,16
    80001c48:	00008067          	ret

0000000080001c4c <usertrap>:
    80001c4c:	ff010113          	addi	sp,sp,-16
    80001c50:	00813423          	sd	s0,8(sp)
    80001c54:	01010413          	addi	s0,sp,16
    80001c58:	00813403          	ld	s0,8(sp)
    80001c5c:	01010113          	addi	sp,sp,16
    80001c60:	00008067          	ret

0000000080001c64 <usertrapret>:
    80001c64:	ff010113          	addi	sp,sp,-16
    80001c68:	00813423          	sd	s0,8(sp)
    80001c6c:	01010413          	addi	s0,sp,16
    80001c70:	00813403          	ld	s0,8(sp)
    80001c74:	01010113          	addi	sp,sp,16
    80001c78:	00008067          	ret

0000000080001c7c <kerneltrap>:
    80001c7c:	fe010113          	addi	sp,sp,-32
    80001c80:	00813823          	sd	s0,16(sp)
    80001c84:	00113c23          	sd	ra,24(sp)
    80001c88:	00913423          	sd	s1,8(sp)
    80001c8c:	02010413          	addi	s0,sp,32
    80001c90:	142025f3          	csrr	a1,scause
    80001c94:	100027f3          	csrr	a5,sstatus
    80001c98:	0027f793          	andi	a5,a5,2
    80001c9c:	10079c63          	bnez	a5,80001db4 <kerneltrap+0x138>
    80001ca0:	142027f3          	csrr	a5,scause
    80001ca4:	0207ce63          	bltz	a5,80001ce0 <kerneltrap+0x64>
    80001ca8:	00002517          	auipc	a0,0x2
    80001cac:	47850513          	addi	a0,a0,1144 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001cb0:	00001097          	auipc	ra,0x1
    80001cb4:	888080e7          	jalr	-1912(ra) # 80002538 <__printf>
    80001cb8:	141025f3          	csrr	a1,sepc
    80001cbc:	14302673          	csrr	a2,stval
    80001cc0:	00002517          	auipc	a0,0x2
    80001cc4:	47050513          	addi	a0,a0,1136 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001cc8:	00001097          	auipc	ra,0x1
    80001ccc:	870080e7          	jalr	-1936(ra) # 80002538 <__printf>
    80001cd0:	00002517          	auipc	a0,0x2
    80001cd4:	47850513          	addi	a0,a0,1144 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001cd8:	00001097          	auipc	ra,0x1
    80001cdc:	804080e7          	jalr	-2044(ra) # 800024dc <panic>
    80001ce0:	0ff7f713          	andi	a4,a5,255
    80001ce4:	00900693          	li	a3,9
    80001ce8:	04d70063          	beq	a4,a3,80001d28 <kerneltrap+0xac>
    80001cec:	fff00713          	li	a4,-1
    80001cf0:	03f71713          	slli	a4,a4,0x3f
    80001cf4:	00170713          	addi	a4,a4,1
    80001cf8:	fae798e3          	bne	a5,a4,80001ca8 <kerneltrap+0x2c>
    80001cfc:	00000097          	auipc	ra,0x0
    80001d00:	e00080e7          	jalr	-512(ra) # 80001afc <cpuid>
    80001d04:	06050663          	beqz	a0,80001d70 <kerneltrap+0xf4>
    80001d08:	144027f3          	csrr	a5,sip
    80001d0c:	ffd7f793          	andi	a5,a5,-3
    80001d10:	14479073          	csrw	sip,a5
    80001d14:	01813083          	ld	ra,24(sp)
    80001d18:	01013403          	ld	s0,16(sp)
    80001d1c:	00813483          	ld	s1,8(sp)
    80001d20:	02010113          	addi	sp,sp,32
    80001d24:	00008067          	ret
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	3cc080e7          	jalr	972(ra) # 800020f4 <plic_claim>
    80001d30:	00a00793          	li	a5,10
    80001d34:	00050493          	mv	s1,a0
    80001d38:	06f50863          	beq	a0,a5,80001da8 <kerneltrap+0x12c>
    80001d3c:	fc050ce3          	beqz	a0,80001d14 <kerneltrap+0x98>
    80001d40:	00050593          	mv	a1,a0
    80001d44:	00002517          	auipc	a0,0x2
    80001d48:	3bc50513          	addi	a0,a0,956 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	7ec080e7          	jalr	2028(ra) # 80002538 <__printf>
    80001d54:	01013403          	ld	s0,16(sp)
    80001d58:	01813083          	ld	ra,24(sp)
    80001d5c:	00048513          	mv	a0,s1
    80001d60:	00813483          	ld	s1,8(sp)
    80001d64:	02010113          	addi	sp,sp,32
    80001d68:	00000317          	auipc	t1,0x0
    80001d6c:	3c430067          	jr	964(t1) # 8000212c <plic_complete>
    80001d70:	00003517          	auipc	a0,0x3
    80001d74:	7e050513          	addi	a0,a0,2016 # 80005550 <tickslock>
    80001d78:	00001097          	auipc	ra,0x1
    80001d7c:	494080e7          	jalr	1172(ra) # 8000320c <acquire>
    80001d80:	00002717          	auipc	a4,0x2
    80001d84:	6e470713          	addi	a4,a4,1764 # 80004464 <ticks>
    80001d88:	00072783          	lw	a5,0(a4)
    80001d8c:	00003517          	auipc	a0,0x3
    80001d90:	7c450513          	addi	a0,a0,1988 # 80005550 <tickslock>
    80001d94:	0017879b          	addiw	a5,a5,1
    80001d98:	00f72023          	sw	a5,0(a4)
    80001d9c:	00001097          	auipc	ra,0x1
    80001da0:	53c080e7          	jalr	1340(ra) # 800032d8 <release>
    80001da4:	f65ff06f          	j	80001d08 <kerneltrap+0x8c>
    80001da8:	00001097          	auipc	ra,0x1
    80001dac:	098080e7          	jalr	152(ra) # 80002e40 <uartintr>
    80001db0:	fa5ff06f          	j	80001d54 <kerneltrap+0xd8>
    80001db4:	00002517          	auipc	a0,0x2
    80001db8:	32c50513          	addi	a0,a0,812 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	720080e7          	jalr	1824(ra) # 800024dc <panic>

0000000080001dc4 <clockintr>:
    80001dc4:	fe010113          	addi	sp,sp,-32
    80001dc8:	00813823          	sd	s0,16(sp)
    80001dcc:	00913423          	sd	s1,8(sp)
    80001dd0:	00113c23          	sd	ra,24(sp)
    80001dd4:	02010413          	addi	s0,sp,32
    80001dd8:	00003497          	auipc	s1,0x3
    80001ddc:	77848493          	addi	s1,s1,1912 # 80005550 <tickslock>
    80001de0:	00048513          	mv	a0,s1
    80001de4:	00001097          	auipc	ra,0x1
    80001de8:	428080e7          	jalr	1064(ra) # 8000320c <acquire>
    80001dec:	00002717          	auipc	a4,0x2
    80001df0:	67870713          	addi	a4,a4,1656 # 80004464 <ticks>
    80001df4:	00072783          	lw	a5,0(a4)
    80001df8:	01013403          	ld	s0,16(sp)
    80001dfc:	01813083          	ld	ra,24(sp)
    80001e00:	00048513          	mv	a0,s1
    80001e04:	0017879b          	addiw	a5,a5,1
    80001e08:	00813483          	ld	s1,8(sp)
    80001e0c:	00f72023          	sw	a5,0(a4)
    80001e10:	02010113          	addi	sp,sp,32
    80001e14:	00001317          	auipc	t1,0x1
    80001e18:	4c430067          	jr	1220(t1) # 800032d8 <release>

0000000080001e1c <devintr>:
    80001e1c:	142027f3          	csrr	a5,scause
    80001e20:	00000513          	li	a0,0
    80001e24:	0007c463          	bltz	a5,80001e2c <devintr+0x10>
    80001e28:	00008067          	ret
    80001e2c:	fe010113          	addi	sp,sp,-32
    80001e30:	00813823          	sd	s0,16(sp)
    80001e34:	00113c23          	sd	ra,24(sp)
    80001e38:	00913423          	sd	s1,8(sp)
    80001e3c:	02010413          	addi	s0,sp,32
    80001e40:	0ff7f713          	andi	a4,a5,255
    80001e44:	00900693          	li	a3,9
    80001e48:	04d70c63          	beq	a4,a3,80001ea0 <devintr+0x84>
    80001e4c:	fff00713          	li	a4,-1
    80001e50:	03f71713          	slli	a4,a4,0x3f
    80001e54:	00170713          	addi	a4,a4,1
    80001e58:	00e78c63          	beq	a5,a4,80001e70 <devintr+0x54>
    80001e5c:	01813083          	ld	ra,24(sp)
    80001e60:	01013403          	ld	s0,16(sp)
    80001e64:	00813483          	ld	s1,8(sp)
    80001e68:	02010113          	addi	sp,sp,32
    80001e6c:	00008067          	ret
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	c8c080e7          	jalr	-884(ra) # 80001afc <cpuid>
    80001e78:	06050663          	beqz	a0,80001ee4 <devintr+0xc8>
    80001e7c:	144027f3          	csrr	a5,sip
    80001e80:	ffd7f793          	andi	a5,a5,-3
    80001e84:	14479073          	csrw	sip,a5
    80001e88:	01813083          	ld	ra,24(sp)
    80001e8c:	01013403          	ld	s0,16(sp)
    80001e90:	00813483          	ld	s1,8(sp)
    80001e94:	00200513          	li	a0,2
    80001e98:	02010113          	addi	sp,sp,32
    80001e9c:	00008067          	ret
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	254080e7          	jalr	596(ra) # 800020f4 <plic_claim>
    80001ea8:	00a00793          	li	a5,10
    80001eac:	00050493          	mv	s1,a0
    80001eb0:	06f50663          	beq	a0,a5,80001f1c <devintr+0x100>
    80001eb4:	00100513          	li	a0,1
    80001eb8:	fa0482e3          	beqz	s1,80001e5c <devintr+0x40>
    80001ebc:	00048593          	mv	a1,s1
    80001ec0:	00002517          	auipc	a0,0x2
    80001ec4:	24050513          	addi	a0,a0,576 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001ec8:	00000097          	auipc	ra,0x0
    80001ecc:	670080e7          	jalr	1648(ra) # 80002538 <__printf>
    80001ed0:	00048513          	mv	a0,s1
    80001ed4:	00000097          	auipc	ra,0x0
    80001ed8:	258080e7          	jalr	600(ra) # 8000212c <plic_complete>
    80001edc:	00100513          	li	a0,1
    80001ee0:	f7dff06f          	j	80001e5c <devintr+0x40>
    80001ee4:	00003517          	auipc	a0,0x3
    80001ee8:	66c50513          	addi	a0,a0,1644 # 80005550 <tickslock>
    80001eec:	00001097          	auipc	ra,0x1
    80001ef0:	320080e7          	jalr	800(ra) # 8000320c <acquire>
    80001ef4:	00002717          	auipc	a4,0x2
    80001ef8:	57070713          	addi	a4,a4,1392 # 80004464 <ticks>
    80001efc:	00072783          	lw	a5,0(a4)
    80001f00:	00003517          	auipc	a0,0x3
    80001f04:	65050513          	addi	a0,a0,1616 # 80005550 <tickslock>
    80001f08:	0017879b          	addiw	a5,a5,1
    80001f0c:	00f72023          	sw	a5,0(a4)
    80001f10:	00001097          	auipc	ra,0x1
    80001f14:	3c8080e7          	jalr	968(ra) # 800032d8 <release>
    80001f18:	f65ff06f          	j	80001e7c <devintr+0x60>
    80001f1c:	00001097          	auipc	ra,0x1
    80001f20:	f24080e7          	jalr	-220(ra) # 80002e40 <uartintr>
    80001f24:	fadff06f          	j	80001ed0 <devintr+0xb4>
	...

0000000080001f30 <kernelvec>:
    80001f30:	f0010113          	addi	sp,sp,-256
    80001f34:	00113023          	sd	ra,0(sp)
    80001f38:	00213423          	sd	sp,8(sp)
    80001f3c:	00313823          	sd	gp,16(sp)
    80001f40:	00413c23          	sd	tp,24(sp)
    80001f44:	02513023          	sd	t0,32(sp)
    80001f48:	02613423          	sd	t1,40(sp)
    80001f4c:	02713823          	sd	t2,48(sp)
    80001f50:	02813c23          	sd	s0,56(sp)
    80001f54:	04913023          	sd	s1,64(sp)
    80001f58:	04a13423          	sd	a0,72(sp)
    80001f5c:	04b13823          	sd	a1,80(sp)
    80001f60:	04c13c23          	sd	a2,88(sp)
    80001f64:	06d13023          	sd	a3,96(sp)
    80001f68:	06e13423          	sd	a4,104(sp)
    80001f6c:	06f13823          	sd	a5,112(sp)
    80001f70:	07013c23          	sd	a6,120(sp)
    80001f74:	09113023          	sd	a7,128(sp)
    80001f78:	09213423          	sd	s2,136(sp)
    80001f7c:	09313823          	sd	s3,144(sp)
    80001f80:	09413c23          	sd	s4,152(sp)
    80001f84:	0b513023          	sd	s5,160(sp)
    80001f88:	0b613423          	sd	s6,168(sp)
    80001f8c:	0b713823          	sd	s7,176(sp)
    80001f90:	0b813c23          	sd	s8,184(sp)
    80001f94:	0d913023          	sd	s9,192(sp)
    80001f98:	0da13423          	sd	s10,200(sp)
    80001f9c:	0db13823          	sd	s11,208(sp)
    80001fa0:	0dc13c23          	sd	t3,216(sp)
    80001fa4:	0fd13023          	sd	t4,224(sp)
    80001fa8:	0fe13423          	sd	t5,232(sp)
    80001fac:	0ff13823          	sd	t6,240(sp)
    80001fb0:	ccdff0ef          	jal	ra,80001c7c <kerneltrap>
    80001fb4:	00013083          	ld	ra,0(sp)
    80001fb8:	00813103          	ld	sp,8(sp)
    80001fbc:	01013183          	ld	gp,16(sp)
    80001fc0:	02013283          	ld	t0,32(sp)
    80001fc4:	02813303          	ld	t1,40(sp)
    80001fc8:	03013383          	ld	t2,48(sp)
    80001fcc:	03813403          	ld	s0,56(sp)
    80001fd0:	04013483          	ld	s1,64(sp)
    80001fd4:	04813503          	ld	a0,72(sp)
    80001fd8:	05013583          	ld	a1,80(sp)
    80001fdc:	05813603          	ld	a2,88(sp)
    80001fe0:	06013683          	ld	a3,96(sp)
    80001fe4:	06813703          	ld	a4,104(sp)
    80001fe8:	07013783          	ld	a5,112(sp)
    80001fec:	07813803          	ld	a6,120(sp)
    80001ff0:	08013883          	ld	a7,128(sp)
    80001ff4:	08813903          	ld	s2,136(sp)
    80001ff8:	09013983          	ld	s3,144(sp)
    80001ffc:	09813a03          	ld	s4,152(sp)
    80002000:	0a013a83          	ld	s5,160(sp)
    80002004:	0a813b03          	ld	s6,168(sp)
    80002008:	0b013b83          	ld	s7,176(sp)
    8000200c:	0b813c03          	ld	s8,184(sp)
    80002010:	0c013c83          	ld	s9,192(sp)
    80002014:	0c813d03          	ld	s10,200(sp)
    80002018:	0d013d83          	ld	s11,208(sp)
    8000201c:	0d813e03          	ld	t3,216(sp)
    80002020:	0e013e83          	ld	t4,224(sp)
    80002024:	0e813f03          	ld	t5,232(sp)
    80002028:	0f013f83          	ld	t6,240(sp)
    8000202c:	10010113          	addi	sp,sp,256
    80002030:	10200073          	sret
    80002034:	00000013          	nop
    80002038:	00000013          	nop
    8000203c:	00000013          	nop

0000000080002040 <timervec>:
    80002040:	34051573          	csrrw	a0,mscratch,a0
    80002044:	00b53023          	sd	a1,0(a0)
    80002048:	00c53423          	sd	a2,8(a0)
    8000204c:	00d53823          	sd	a3,16(a0)
    80002050:	01853583          	ld	a1,24(a0)
    80002054:	02053603          	ld	a2,32(a0)
    80002058:	0005b683          	ld	a3,0(a1)
    8000205c:	00c686b3          	add	a3,a3,a2
    80002060:	00d5b023          	sd	a3,0(a1)
    80002064:	00200593          	li	a1,2
    80002068:	14459073          	csrw	sip,a1
    8000206c:	01053683          	ld	a3,16(a0)
    80002070:	00853603          	ld	a2,8(a0)
    80002074:	00053583          	ld	a1,0(a0)
    80002078:	34051573          	csrrw	a0,mscratch,a0
    8000207c:	30200073          	mret

0000000080002080 <plicinit>:
    80002080:	ff010113          	addi	sp,sp,-16
    80002084:	00813423          	sd	s0,8(sp)
    80002088:	01010413          	addi	s0,sp,16
    8000208c:	00813403          	ld	s0,8(sp)
    80002090:	0c0007b7          	lui	a5,0xc000
    80002094:	00100713          	li	a4,1
    80002098:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000209c:	00e7a223          	sw	a4,4(a5)
    800020a0:	01010113          	addi	sp,sp,16
    800020a4:	00008067          	ret

00000000800020a8 <plicinithart>:
    800020a8:	ff010113          	addi	sp,sp,-16
    800020ac:	00813023          	sd	s0,0(sp)
    800020b0:	00113423          	sd	ra,8(sp)
    800020b4:	01010413          	addi	s0,sp,16
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	a44080e7          	jalr	-1468(ra) # 80001afc <cpuid>
    800020c0:	0085171b          	slliw	a4,a0,0x8
    800020c4:	0c0027b7          	lui	a5,0xc002
    800020c8:	00e787b3          	add	a5,a5,a4
    800020cc:	40200713          	li	a4,1026
    800020d0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800020d4:	00813083          	ld	ra,8(sp)
    800020d8:	00013403          	ld	s0,0(sp)
    800020dc:	00d5151b          	slliw	a0,a0,0xd
    800020e0:	0c2017b7          	lui	a5,0xc201
    800020e4:	00a78533          	add	a0,a5,a0
    800020e8:	00052023          	sw	zero,0(a0)
    800020ec:	01010113          	addi	sp,sp,16
    800020f0:	00008067          	ret

00000000800020f4 <plic_claim>:
    800020f4:	ff010113          	addi	sp,sp,-16
    800020f8:	00813023          	sd	s0,0(sp)
    800020fc:	00113423          	sd	ra,8(sp)
    80002100:	01010413          	addi	s0,sp,16
    80002104:	00000097          	auipc	ra,0x0
    80002108:	9f8080e7          	jalr	-1544(ra) # 80001afc <cpuid>
    8000210c:	00813083          	ld	ra,8(sp)
    80002110:	00013403          	ld	s0,0(sp)
    80002114:	00d5151b          	slliw	a0,a0,0xd
    80002118:	0c2017b7          	lui	a5,0xc201
    8000211c:	00a78533          	add	a0,a5,a0
    80002120:	00452503          	lw	a0,4(a0)
    80002124:	01010113          	addi	sp,sp,16
    80002128:	00008067          	ret

000000008000212c <plic_complete>:
    8000212c:	fe010113          	addi	sp,sp,-32
    80002130:	00813823          	sd	s0,16(sp)
    80002134:	00913423          	sd	s1,8(sp)
    80002138:	00113c23          	sd	ra,24(sp)
    8000213c:	02010413          	addi	s0,sp,32
    80002140:	00050493          	mv	s1,a0
    80002144:	00000097          	auipc	ra,0x0
    80002148:	9b8080e7          	jalr	-1608(ra) # 80001afc <cpuid>
    8000214c:	01813083          	ld	ra,24(sp)
    80002150:	01013403          	ld	s0,16(sp)
    80002154:	00d5179b          	slliw	a5,a0,0xd
    80002158:	0c201737          	lui	a4,0xc201
    8000215c:	00f707b3          	add	a5,a4,a5
    80002160:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002164:	00813483          	ld	s1,8(sp)
    80002168:	02010113          	addi	sp,sp,32
    8000216c:	00008067          	ret

0000000080002170 <consolewrite>:
    80002170:	fb010113          	addi	sp,sp,-80
    80002174:	04813023          	sd	s0,64(sp)
    80002178:	04113423          	sd	ra,72(sp)
    8000217c:	02913c23          	sd	s1,56(sp)
    80002180:	03213823          	sd	s2,48(sp)
    80002184:	03313423          	sd	s3,40(sp)
    80002188:	03413023          	sd	s4,32(sp)
    8000218c:	01513c23          	sd	s5,24(sp)
    80002190:	05010413          	addi	s0,sp,80
    80002194:	06c05c63          	blez	a2,8000220c <consolewrite+0x9c>
    80002198:	00060993          	mv	s3,a2
    8000219c:	00050a13          	mv	s4,a0
    800021a0:	00058493          	mv	s1,a1
    800021a4:	00000913          	li	s2,0
    800021a8:	fff00a93          	li	s5,-1
    800021ac:	01c0006f          	j	800021c8 <consolewrite+0x58>
    800021b0:	fbf44503          	lbu	a0,-65(s0)
    800021b4:	0019091b          	addiw	s2,s2,1
    800021b8:	00148493          	addi	s1,s1,1
    800021bc:	00001097          	auipc	ra,0x1
    800021c0:	a9c080e7          	jalr	-1380(ra) # 80002c58 <uartputc>
    800021c4:	03298063          	beq	s3,s2,800021e4 <consolewrite+0x74>
    800021c8:	00048613          	mv	a2,s1
    800021cc:	00100693          	li	a3,1
    800021d0:	000a0593          	mv	a1,s4
    800021d4:	fbf40513          	addi	a0,s0,-65
    800021d8:	00000097          	auipc	ra,0x0
    800021dc:	9dc080e7          	jalr	-1572(ra) # 80001bb4 <either_copyin>
    800021e0:	fd5518e3          	bne	a0,s5,800021b0 <consolewrite+0x40>
    800021e4:	04813083          	ld	ra,72(sp)
    800021e8:	04013403          	ld	s0,64(sp)
    800021ec:	03813483          	ld	s1,56(sp)
    800021f0:	02813983          	ld	s3,40(sp)
    800021f4:	02013a03          	ld	s4,32(sp)
    800021f8:	01813a83          	ld	s5,24(sp)
    800021fc:	00090513          	mv	a0,s2
    80002200:	03013903          	ld	s2,48(sp)
    80002204:	05010113          	addi	sp,sp,80
    80002208:	00008067          	ret
    8000220c:	00000913          	li	s2,0
    80002210:	fd5ff06f          	j	800021e4 <consolewrite+0x74>

0000000080002214 <consoleread>:
    80002214:	f9010113          	addi	sp,sp,-112
    80002218:	06813023          	sd	s0,96(sp)
    8000221c:	04913c23          	sd	s1,88(sp)
    80002220:	05213823          	sd	s2,80(sp)
    80002224:	05313423          	sd	s3,72(sp)
    80002228:	05413023          	sd	s4,64(sp)
    8000222c:	03513c23          	sd	s5,56(sp)
    80002230:	03613823          	sd	s6,48(sp)
    80002234:	03713423          	sd	s7,40(sp)
    80002238:	03813023          	sd	s8,32(sp)
    8000223c:	06113423          	sd	ra,104(sp)
    80002240:	01913c23          	sd	s9,24(sp)
    80002244:	07010413          	addi	s0,sp,112
    80002248:	00060b93          	mv	s7,a2
    8000224c:	00050913          	mv	s2,a0
    80002250:	00058c13          	mv	s8,a1
    80002254:	00060b1b          	sext.w	s6,a2
    80002258:	00003497          	auipc	s1,0x3
    8000225c:	31048493          	addi	s1,s1,784 # 80005568 <cons>
    80002260:	00400993          	li	s3,4
    80002264:	fff00a13          	li	s4,-1
    80002268:	00a00a93          	li	s5,10
    8000226c:	05705e63          	blez	s7,800022c8 <consoleread+0xb4>
    80002270:	09c4a703          	lw	a4,156(s1)
    80002274:	0984a783          	lw	a5,152(s1)
    80002278:	0007071b          	sext.w	a4,a4
    8000227c:	08e78463          	beq	a5,a4,80002304 <consoleread+0xf0>
    80002280:	07f7f713          	andi	a4,a5,127
    80002284:	00e48733          	add	a4,s1,a4
    80002288:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000228c:	0017869b          	addiw	a3,a5,1
    80002290:	08d4ac23          	sw	a3,152(s1)
    80002294:	00070c9b          	sext.w	s9,a4
    80002298:	0b370663          	beq	a4,s3,80002344 <consoleread+0x130>
    8000229c:	00100693          	li	a3,1
    800022a0:	f9f40613          	addi	a2,s0,-97
    800022a4:	000c0593          	mv	a1,s8
    800022a8:	00090513          	mv	a0,s2
    800022ac:	f8e40fa3          	sb	a4,-97(s0)
    800022b0:	00000097          	auipc	ra,0x0
    800022b4:	8b8080e7          	jalr	-1864(ra) # 80001b68 <either_copyout>
    800022b8:	01450863          	beq	a0,s4,800022c8 <consoleread+0xb4>
    800022bc:	001c0c13          	addi	s8,s8,1
    800022c0:	fffb8b9b          	addiw	s7,s7,-1
    800022c4:	fb5c94e3          	bne	s9,s5,8000226c <consoleread+0x58>
    800022c8:	000b851b          	sext.w	a0,s7
    800022cc:	06813083          	ld	ra,104(sp)
    800022d0:	06013403          	ld	s0,96(sp)
    800022d4:	05813483          	ld	s1,88(sp)
    800022d8:	05013903          	ld	s2,80(sp)
    800022dc:	04813983          	ld	s3,72(sp)
    800022e0:	04013a03          	ld	s4,64(sp)
    800022e4:	03813a83          	ld	s5,56(sp)
    800022e8:	02813b83          	ld	s7,40(sp)
    800022ec:	02013c03          	ld	s8,32(sp)
    800022f0:	01813c83          	ld	s9,24(sp)
    800022f4:	40ab053b          	subw	a0,s6,a0
    800022f8:	03013b03          	ld	s6,48(sp)
    800022fc:	07010113          	addi	sp,sp,112
    80002300:	00008067          	ret
    80002304:	00001097          	auipc	ra,0x1
    80002308:	1d8080e7          	jalr	472(ra) # 800034dc <push_on>
    8000230c:	0984a703          	lw	a4,152(s1)
    80002310:	09c4a783          	lw	a5,156(s1)
    80002314:	0007879b          	sext.w	a5,a5
    80002318:	fef70ce3          	beq	a4,a5,80002310 <consoleread+0xfc>
    8000231c:	00001097          	auipc	ra,0x1
    80002320:	234080e7          	jalr	564(ra) # 80003550 <pop_on>
    80002324:	0984a783          	lw	a5,152(s1)
    80002328:	07f7f713          	andi	a4,a5,127
    8000232c:	00e48733          	add	a4,s1,a4
    80002330:	01874703          	lbu	a4,24(a4)
    80002334:	0017869b          	addiw	a3,a5,1
    80002338:	08d4ac23          	sw	a3,152(s1)
    8000233c:	00070c9b          	sext.w	s9,a4
    80002340:	f5371ee3          	bne	a4,s3,8000229c <consoleread+0x88>
    80002344:	000b851b          	sext.w	a0,s7
    80002348:	f96bf2e3          	bgeu	s7,s6,800022cc <consoleread+0xb8>
    8000234c:	08f4ac23          	sw	a5,152(s1)
    80002350:	f7dff06f          	j	800022cc <consoleread+0xb8>

0000000080002354 <consputc>:
    80002354:	10000793          	li	a5,256
    80002358:	00f50663          	beq	a0,a5,80002364 <consputc+0x10>
    8000235c:	00001317          	auipc	t1,0x1
    80002360:	9f430067          	jr	-1548(t1) # 80002d50 <uartputc_sync>
    80002364:	ff010113          	addi	sp,sp,-16
    80002368:	00113423          	sd	ra,8(sp)
    8000236c:	00813023          	sd	s0,0(sp)
    80002370:	01010413          	addi	s0,sp,16
    80002374:	00800513          	li	a0,8
    80002378:	00001097          	auipc	ra,0x1
    8000237c:	9d8080e7          	jalr	-1576(ra) # 80002d50 <uartputc_sync>
    80002380:	02000513          	li	a0,32
    80002384:	00001097          	auipc	ra,0x1
    80002388:	9cc080e7          	jalr	-1588(ra) # 80002d50 <uartputc_sync>
    8000238c:	00013403          	ld	s0,0(sp)
    80002390:	00813083          	ld	ra,8(sp)
    80002394:	00800513          	li	a0,8
    80002398:	01010113          	addi	sp,sp,16
    8000239c:	00001317          	auipc	t1,0x1
    800023a0:	9b430067          	jr	-1612(t1) # 80002d50 <uartputc_sync>

00000000800023a4 <consoleintr>:
    800023a4:	fe010113          	addi	sp,sp,-32
    800023a8:	00813823          	sd	s0,16(sp)
    800023ac:	00913423          	sd	s1,8(sp)
    800023b0:	01213023          	sd	s2,0(sp)
    800023b4:	00113c23          	sd	ra,24(sp)
    800023b8:	02010413          	addi	s0,sp,32
    800023bc:	00003917          	auipc	s2,0x3
    800023c0:	1ac90913          	addi	s2,s2,428 # 80005568 <cons>
    800023c4:	00050493          	mv	s1,a0
    800023c8:	00090513          	mv	a0,s2
    800023cc:	00001097          	auipc	ra,0x1
    800023d0:	e40080e7          	jalr	-448(ra) # 8000320c <acquire>
    800023d4:	02048c63          	beqz	s1,8000240c <consoleintr+0x68>
    800023d8:	0a092783          	lw	a5,160(s2)
    800023dc:	09892703          	lw	a4,152(s2)
    800023e0:	07f00693          	li	a3,127
    800023e4:	40e7873b          	subw	a4,a5,a4
    800023e8:	02e6e263          	bltu	a3,a4,8000240c <consoleintr+0x68>
    800023ec:	00d00713          	li	a4,13
    800023f0:	04e48063          	beq	s1,a4,80002430 <consoleintr+0x8c>
    800023f4:	07f7f713          	andi	a4,a5,127
    800023f8:	00e90733          	add	a4,s2,a4
    800023fc:	0017879b          	addiw	a5,a5,1
    80002400:	0af92023          	sw	a5,160(s2)
    80002404:	00970c23          	sb	s1,24(a4)
    80002408:	08f92e23          	sw	a5,156(s2)
    8000240c:	01013403          	ld	s0,16(sp)
    80002410:	01813083          	ld	ra,24(sp)
    80002414:	00813483          	ld	s1,8(sp)
    80002418:	00013903          	ld	s2,0(sp)
    8000241c:	00003517          	auipc	a0,0x3
    80002420:	14c50513          	addi	a0,a0,332 # 80005568 <cons>
    80002424:	02010113          	addi	sp,sp,32
    80002428:	00001317          	auipc	t1,0x1
    8000242c:	eb030067          	jr	-336(t1) # 800032d8 <release>
    80002430:	00a00493          	li	s1,10
    80002434:	fc1ff06f          	j	800023f4 <consoleintr+0x50>

0000000080002438 <consoleinit>:
    80002438:	fe010113          	addi	sp,sp,-32
    8000243c:	00113c23          	sd	ra,24(sp)
    80002440:	00813823          	sd	s0,16(sp)
    80002444:	00913423          	sd	s1,8(sp)
    80002448:	02010413          	addi	s0,sp,32
    8000244c:	00003497          	auipc	s1,0x3
    80002450:	11c48493          	addi	s1,s1,284 # 80005568 <cons>
    80002454:	00048513          	mv	a0,s1
    80002458:	00002597          	auipc	a1,0x2
    8000245c:	d0058593          	addi	a1,a1,-768 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    80002460:	00001097          	auipc	ra,0x1
    80002464:	d88080e7          	jalr	-632(ra) # 800031e8 <initlock>
    80002468:	00000097          	auipc	ra,0x0
    8000246c:	7ac080e7          	jalr	1964(ra) # 80002c14 <uartinit>
    80002470:	01813083          	ld	ra,24(sp)
    80002474:	01013403          	ld	s0,16(sp)
    80002478:	00000797          	auipc	a5,0x0
    8000247c:	d9c78793          	addi	a5,a5,-612 # 80002214 <consoleread>
    80002480:	0af4bc23          	sd	a5,184(s1)
    80002484:	00000797          	auipc	a5,0x0
    80002488:	cec78793          	addi	a5,a5,-788 # 80002170 <consolewrite>
    8000248c:	0cf4b023          	sd	a5,192(s1)
    80002490:	00813483          	ld	s1,8(sp)
    80002494:	02010113          	addi	sp,sp,32
    80002498:	00008067          	ret

000000008000249c <console_read>:
    8000249c:	ff010113          	addi	sp,sp,-16
    800024a0:	00813423          	sd	s0,8(sp)
    800024a4:	01010413          	addi	s0,sp,16
    800024a8:	00813403          	ld	s0,8(sp)
    800024ac:	00003317          	auipc	t1,0x3
    800024b0:	17433303          	ld	t1,372(t1) # 80005620 <devsw+0x10>
    800024b4:	01010113          	addi	sp,sp,16
    800024b8:	00030067          	jr	t1

00000000800024bc <console_write>:
    800024bc:	ff010113          	addi	sp,sp,-16
    800024c0:	00813423          	sd	s0,8(sp)
    800024c4:	01010413          	addi	s0,sp,16
    800024c8:	00813403          	ld	s0,8(sp)
    800024cc:	00003317          	auipc	t1,0x3
    800024d0:	15c33303          	ld	t1,348(t1) # 80005628 <devsw+0x18>
    800024d4:	01010113          	addi	sp,sp,16
    800024d8:	00030067          	jr	t1

00000000800024dc <panic>:
    800024dc:	fe010113          	addi	sp,sp,-32
    800024e0:	00113c23          	sd	ra,24(sp)
    800024e4:	00813823          	sd	s0,16(sp)
    800024e8:	00913423          	sd	s1,8(sp)
    800024ec:	02010413          	addi	s0,sp,32
    800024f0:	00050493          	mv	s1,a0
    800024f4:	00002517          	auipc	a0,0x2
    800024f8:	c6c50513          	addi	a0,a0,-916 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    800024fc:	00003797          	auipc	a5,0x3
    80002500:	1c07a623          	sw	zero,460(a5) # 800056c8 <pr+0x18>
    80002504:	00000097          	auipc	ra,0x0
    80002508:	034080e7          	jalr	52(ra) # 80002538 <__printf>
    8000250c:	00048513          	mv	a0,s1
    80002510:	00000097          	auipc	ra,0x0
    80002514:	028080e7          	jalr	40(ra) # 80002538 <__printf>
    80002518:	00002517          	auipc	a0,0x2
    8000251c:	c2850513          	addi	a0,a0,-984 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80002520:	00000097          	auipc	ra,0x0
    80002524:	018080e7          	jalr	24(ra) # 80002538 <__printf>
    80002528:	00100793          	li	a5,1
    8000252c:	00002717          	auipc	a4,0x2
    80002530:	f2f72e23          	sw	a5,-196(a4) # 80004468 <panicked>
    80002534:	0000006f          	j	80002534 <panic+0x58>

0000000080002538 <__printf>:
    80002538:	f3010113          	addi	sp,sp,-208
    8000253c:	08813023          	sd	s0,128(sp)
    80002540:	07313423          	sd	s3,104(sp)
    80002544:	09010413          	addi	s0,sp,144
    80002548:	05813023          	sd	s8,64(sp)
    8000254c:	08113423          	sd	ra,136(sp)
    80002550:	06913c23          	sd	s1,120(sp)
    80002554:	07213823          	sd	s2,112(sp)
    80002558:	07413023          	sd	s4,96(sp)
    8000255c:	05513c23          	sd	s5,88(sp)
    80002560:	05613823          	sd	s6,80(sp)
    80002564:	05713423          	sd	s7,72(sp)
    80002568:	03913c23          	sd	s9,56(sp)
    8000256c:	03a13823          	sd	s10,48(sp)
    80002570:	03b13423          	sd	s11,40(sp)
    80002574:	00003317          	auipc	t1,0x3
    80002578:	13c30313          	addi	t1,t1,316 # 800056b0 <pr>
    8000257c:	01832c03          	lw	s8,24(t1)
    80002580:	00b43423          	sd	a1,8(s0)
    80002584:	00c43823          	sd	a2,16(s0)
    80002588:	00d43c23          	sd	a3,24(s0)
    8000258c:	02e43023          	sd	a4,32(s0)
    80002590:	02f43423          	sd	a5,40(s0)
    80002594:	03043823          	sd	a6,48(s0)
    80002598:	03143c23          	sd	a7,56(s0)
    8000259c:	00050993          	mv	s3,a0
    800025a0:	4a0c1663          	bnez	s8,80002a4c <__printf+0x514>
    800025a4:	60098c63          	beqz	s3,80002bbc <__printf+0x684>
    800025a8:	0009c503          	lbu	a0,0(s3)
    800025ac:	00840793          	addi	a5,s0,8
    800025b0:	f6f43c23          	sd	a5,-136(s0)
    800025b4:	00000493          	li	s1,0
    800025b8:	22050063          	beqz	a0,800027d8 <__printf+0x2a0>
    800025bc:	00002a37          	lui	s4,0x2
    800025c0:	00018ab7          	lui	s5,0x18
    800025c4:	000f4b37          	lui	s6,0xf4
    800025c8:	00989bb7          	lui	s7,0x989
    800025cc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800025d0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800025d4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800025d8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800025dc:	00148c9b          	addiw	s9,s1,1
    800025e0:	02500793          	li	a5,37
    800025e4:	01998933          	add	s2,s3,s9
    800025e8:	38f51263          	bne	a0,a5,8000296c <__printf+0x434>
    800025ec:	00094783          	lbu	a5,0(s2)
    800025f0:	00078c9b          	sext.w	s9,a5
    800025f4:	1e078263          	beqz	a5,800027d8 <__printf+0x2a0>
    800025f8:	0024849b          	addiw	s1,s1,2
    800025fc:	07000713          	li	a4,112
    80002600:	00998933          	add	s2,s3,s1
    80002604:	38e78a63          	beq	a5,a4,80002998 <__printf+0x460>
    80002608:	20f76863          	bltu	a4,a5,80002818 <__printf+0x2e0>
    8000260c:	42a78863          	beq	a5,a0,80002a3c <__printf+0x504>
    80002610:	06400713          	li	a4,100
    80002614:	40e79663          	bne	a5,a4,80002a20 <__printf+0x4e8>
    80002618:	f7843783          	ld	a5,-136(s0)
    8000261c:	0007a603          	lw	a2,0(a5)
    80002620:	00878793          	addi	a5,a5,8
    80002624:	f6f43c23          	sd	a5,-136(s0)
    80002628:	42064a63          	bltz	a2,80002a5c <__printf+0x524>
    8000262c:	00a00713          	li	a4,10
    80002630:	02e677bb          	remuw	a5,a2,a4
    80002634:	00002d97          	auipc	s11,0x2
    80002638:	b54d8d93          	addi	s11,s11,-1196 # 80004188 <digits>
    8000263c:	00900593          	li	a1,9
    80002640:	0006051b          	sext.w	a0,a2
    80002644:	00000c93          	li	s9,0
    80002648:	02079793          	slli	a5,a5,0x20
    8000264c:	0207d793          	srli	a5,a5,0x20
    80002650:	00fd87b3          	add	a5,s11,a5
    80002654:	0007c783          	lbu	a5,0(a5)
    80002658:	02e656bb          	divuw	a3,a2,a4
    8000265c:	f8f40023          	sb	a5,-128(s0)
    80002660:	14c5d863          	bge	a1,a2,800027b0 <__printf+0x278>
    80002664:	06300593          	li	a1,99
    80002668:	00100c93          	li	s9,1
    8000266c:	02e6f7bb          	remuw	a5,a3,a4
    80002670:	02079793          	slli	a5,a5,0x20
    80002674:	0207d793          	srli	a5,a5,0x20
    80002678:	00fd87b3          	add	a5,s11,a5
    8000267c:	0007c783          	lbu	a5,0(a5)
    80002680:	02e6d73b          	divuw	a4,a3,a4
    80002684:	f8f400a3          	sb	a5,-127(s0)
    80002688:	12a5f463          	bgeu	a1,a0,800027b0 <__printf+0x278>
    8000268c:	00a00693          	li	a3,10
    80002690:	00900593          	li	a1,9
    80002694:	02d777bb          	remuw	a5,a4,a3
    80002698:	02079793          	slli	a5,a5,0x20
    8000269c:	0207d793          	srli	a5,a5,0x20
    800026a0:	00fd87b3          	add	a5,s11,a5
    800026a4:	0007c503          	lbu	a0,0(a5)
    800026a8:	02d757bb          	divuw	a5,a4,a3
    800026ac:	f8a40123          	sb	a0,-126(s0)
    800026b0:	48e5f263          	bgeu	a1,a4,80002b34 <__printf+0x5fc>
    800026b4:	06300513          	li	a0,99
    800026b8:	02d7f5bb          	remuw	a1,a5,a3
    800026bc:	02059593          	slli	a1,a1,0x20
    800026c0:	0205d593          	srli	a1,a1,0x20
    800026c4:	00bd85b3          	add	a1,s11,a1
    800026c8:	0005c583          	lbu	a1,0(a1)
    800026cc:	02d7d7bb          	divuw	a5,a5,a3
    800026d0:	f8b401a3          	sb	a1,-125(s0)
    800026d4:	48e57263          	bgeu	a0,a4,80002b58 <__printf+0x620>
    800026d8:	3e700513          	li	a0,999
    800026dc:	02d7f5bb          	remuw	a1,a5,a3
    800026e0:	02059593          	slli	a1,a1,0x20
    800026e4:	0205d593          	srli	a1,a1,0x20
    800026e8:	00bd85b3          	add	a1,s11,a1
    800026ec:	0005c583          	lbu	a1,0(a1)
    800026f0:	02d7d7bb          	divuw	a5,a5,a3
    800026f4:	f8b40223          	sb	a1,-124(s0)
    800026f8:	46e57663          	bgeu	a0,a4,80002b64 <__printf+0x62c>
    800026fc:	02d7f5bb          	remuw	a1,a5,a3
    80002700:	02059593          	slli	a1,a1,0x20
    80002704:	0205d593          	srli	a1,a1,0x20
    80002708:	00bd85b3          	add	a1,s11,a1
    8000270c:	0005c583          	lbu	a1,0(a1)
    80002710:	02d7d7bb          	divuw	a5,a5,a3
    80002714:	f8b402a3          	sb	a1,-123(s0)
    80002718:	46ea7863          	bgeu	s4,a4,80002b88 <__printf+0x650>
    8000271c:	02d7f5bb          	remuw	a1,a5,a3
    80002720:	02059593          	slli	a1,a1,0x20
    80002724:	0205d593          	srli	a1,a1,0x20
    80002728:	00bd85b3          	add	a1,s11,a1
    8000272c:	0005c583          	lbu	a1,0(a1)
    80002730:	02d7d7bb          	divuw	a5,a5,a3
    80002734:	f8b40323          	sb	a1,-122(s0)
    80002738:	3eeaf863          	bgeu	s5,a4,80002b28 <__printf+0x5f0>
    8000273c:	02d7f5bb          	remuw	a1,a5,a3
    80002740:	02059593          	slli	a1,a1,0x20
    80002744:	0205d593          	srli	a1,a1,0x20
    80002748:	00bd85b3          	add	a1,s11,a1
    8000274c:	0005c583          	lbu	a1,0(a1)
    80002750:	02d7d7bb          	divuw	a5,a5,a3
    80002754:	f8b403a3          	sb	a1,-121(s0)
    80002758:	42eb7e63          	bgeu	s6,a4,80002b94 <__printf+0x65c>
    8000275c:	02d7f5bb          	remuw	a1,a5,a3
    80002760:	02059593          	slli	a1,a1,0x20
    80002764:	0205d593          	srli	a1,a1,0x20
    80002768:	00bd85b3          	add	a1,s11,a1
    8000276c:	0005c583          	lbu	a1,0(a1)
    80002770:	02d7d7bb          	divuw	a5,a5,a3
    80002774:	f8b40423          	sb	a1,-120(s0)
    80002778:	42ebfc63          	bgeu	s7,a4,80002bb0 <__printf+0x678>
    8000277c:	02079793          	slli	a5,a5,0x20
    80002780:	0207d793          	srli	a5,a5,0x20
    80002784:	00fd8db3          	add	s11,s11,a5
    80002788:	000dc703          	lbu	a4,0(s11)
    8000278c:	00a00793          	li	a5,10
    80002790:	00900c93          	li	s9,9
    80002794:	f8e404a3          	sb	a4,-119(s0)
    80002798:	00065c63          	bgez	a2,800027b0 <__printf+0x278>
    8000279c:	f9040713          	addi	a4,s0,-112
    800027a0:	00f70733          	add	a4,a4,a5
    800027a4:	02d00693          	li	a3,45
    800027a8:	fed70823          	sb	a3,-16(a4)
    800027ac:	00078c93          	mv	s9,a5
    800027b0:	f8040793          	addi	a5,s0,-128
    800027b4:	01978cb3          	add	s9,a5,s9
    800027b8:	f7f40d13          	addi	s10,s0,-129
    800027bc:	000cc503          	lbu	a0,0(s9)
    800027c0:	fffc8c93          	addi	s9,s9,-1
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	b90080e7          	jalr	-1136(ra) # 80002354 <consputc>
    800027cc:	ffac98e3          	bne	s9,s10,800027bc <__printf+0x284>
    800027d0:	00094503          	lbu	a0,0(s2)
    800027d4:	e00514e3          	bnez	a0,800025dc <__printf+0xa4>
    800027d8:	1a0c1663          	bnez	s8,80002984 <__printf+0x44c>
    800027dc:	08813083          	ld	ra,136(sp)
    800027e0:	08013403          	ld	s0,128(sp)
    800027e4:	07813483          	ld	s1,120(sp)
    800027e8:	07013903          	ld	s2,112(sp)
    800027ec:	06813983          	ld	s3,104(sp)
    800027f0:	06013a03          	ld	s4,96(sp)
    800027f4:	05813a83          	ld	s5,88(sp)
    800027f8:	05013b03          	ld	s6,80(sp)
    800027fc:	04813b83          	ld	s7,72(sp)
    80002800:	04013c03          	ld	s8,64(sp)
    80002804:	03813c83          	ld	s9,56(sp)
    80002808:	03013d03          	ld	s10,48(sp)
    8000280c:	02813d83          	ld	s11,40(sp)
    80002810:	0d010113          	addi	sp,sp,208
    80002814:	00008067          	ret
    80002818:	07300713          	li	a4,115
    8000281c:	1ce78a63          	beq	a5,a4,800029f0 <__printf+0x4b8>
    80002820:	07800713          	li	a4,120
    80002824:	1ee79e63          	bne	a5,a4,80002a20 <__printf+0x4e8>
    80002828:	f7843783          	ld	a5,-136(s0)
    8000282c:	0007a703          	lw	a4,0(a5)
    80002830:	00878793          	addi	a5,a5,8
    80002834:	f6f43c23          	sd	a5,-136(s0)
    80002838:	28074263          	bltz	a4,80002abc <__printf+0x584>
    8000283c:	00002d97          	auipc	s11,0x2
    80002840:	94cd8d93          	addi	s11,s11,-1716 # 80004188 <digits>
    80002844:	00f77793          	andi	a5,a4,15
    80002848:	00fd87b3          	add	a5,s11,a5
    8000284c:	0007c683          	lbu	a3,0(a5)
    80002850:	00f00613          	li	a2,15
    80002854:	0007079b          	sext.w	a5,a4
    80002858:	f8d40023          	sb	a3,-128(s0)
    8000285c:	0047559b          	srliw	a1,a4,0x4
    80002860:	0047569b          	srliw	a3,a4,0x4
    80002864:	00000c93          	li	s9,0
    80002868:	0ee65063          	bge	a2,a4,80002948 <__printf+0x410>
    8000286c:	00f6f693          	andi	a3,a3,15
    80002870:	00dd86b3          	add	a3,s11,a3
    80002874:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002878:	0087d79b          	srliw	a5,a5,0x8
    8000287c:	00100c93          	li	s9,1
    80002880:	f8d400a3          	sb	a3,-127(s0)
    80002884:	0cb67263          	bgeu	a2,a1,80002948 <__printf+0x410>
    80002888:	00f7f693          	andi	a3,a5,15
    8000288c:	00dd86b3          	add	a3,s11,a3
    80002890:	0006c583          	lbu	a1,0(a3)
    80002894:	00f00613          	li	a2,15
    80002898:	0047d69b          	srliw	a3,a5,0x4
    8000289c:	f8b40123          	sb	a1,-126(s0)
    800028a0:	0047d593          	srli	a1,a5,0x4
    800028a4:	28f67e63          	bgeu	a2,a5,80002b40 <__printf+0x608>
    800028a8:	00f6f693          	andi	a3,a3,15
    800028ac:	00dd86b3          	add	a3,s11,a3
    800028b0:	0006c503          	lbu	a0,0(a3)
    800028b4:	0087d813          	srli	a6,a5,0x8
    800028b8:	0087d69b          	srliw	a3,a5,0x8
    800028bc:	f8a401a3          	sb	a0,-125(s0)
    800028c0:	28b67663          	bgeu	a2,a1,80002b4c <__printf+0x614>
    800028c4:	00f6f693          	andi	a3,a3,15
    800028c8:	00dd86b3          	add	a3,s11,a3
    800028cc:	0006c583          	lbu	a1,0(a3)
    800028d0:	00c7d513          	srli	a0,a5,0xc
    800028d4:	00c7d69b          	srliw	a3,a5,0xc
    800028d8:	f8b40223          	sb	a1,-124(s0)
    800028dc:	29067a63          	bgeu	a2,a6,80002b70 <__printf+0x638>
    800028e0:	00f6f693          	andi	a3,a3,15
    800028e4:	00dd86b3          	add	a3,s11,a3
    800028e8:	0006c583          	lbu	a1,0(a3)
    800028ec:	0107d813          	srli	a6,a5,0x10
    800028f0:	0107d69b          	srliw	a3,a5,0x10
    800028f4:	f8b402a3          	sb	a1,-123(s0)
    800028f8:	28a67263          	bgeu	a2,a0,80002b7c <__printf+0x644>
    800028fc:	00f6f693          	andi	a3,a3,15
    80002900:	00dd86b3          	add	a3,s11,a3
    80002904:	0006c683          	lbu	a3,0(a3)
    80002908:	0147d79b          	srliw	a5,a5,0x14
    8000290c:	f8d40323          	sb	a3,-122(s0)
    80002910:	21067663          	bgeu	a2,a6,80002b1c <__printf+0x5e4>
    80002914:	02079793          	slli	a5,a5,0x20
    80002918:	0207d793          	srli	a5,a5,0x20
    8000291c:	00fd8db3          	add	s11,s11,a5
    80002920:	000dc683          	lbu	a3,0(s11)
    80002924:	00800793          	li	a5,8
    80002928:	00700c93          	li	s9,7
    8000292c:	f8d403a3          	sb	a3,-121(s0)
    80002930:	00075c63          	bgez	a4,80002948 <__printf+0x410>
    80002934:	f9040713          	addi	a4,s0,-112
    80002938:	00f70733          	add	a4,a4,a5
    8000293c:	02d00693          	li	a3,45
    80002940:	fed70823          	sb	a3,-16(a4)
    80002944:	00078c93          	mv	s9,a5
    80002948:	f8040793          	addi	a5,s0,-128
    8000294c:	01978cb3          	add	s9,a5,s9
    80002950:	f7f40d13          	addi	s10,s0,-129
    80002954:	000cc503          	lbu	a0,0(s9)
    80002958:	fffc8c93          	addi	s9,s9,-1
    8000295c:	00000097          	auipc	ra,0x0
    80002960:	9f8080e7          	jalr	-1544(ra) # 80002354 <consputc>
    80002964:	ff9d18e3          	bne	s10,s9,80002954 <__printf+0x41c>
    80002968:	0100006f          	j	80002978 <__printf+0x440>
    8000296c:	00000097          	auipc	ra,0x0
    80002970:	9e8080e7          	jalr	-1560(ra) # 80002354 <consputc>
    80002974:	000c8493          	mv	s1,s9
    80002978:	00094503          	lbu	a0,0(s2)
    8000297c:	c60510e3          	bnez	a0,800025dc <__printf+0xa4>
    80002980:	e40c0ee3          	beqz	s8,800027dc <__printf+0x2a4>
    80002984:	00003517          	auipc	a0,0x3
    80002988:	d2c50513          	addi	a0,a0,-724 # 800056b0 <pr>
    8000298c:	00001097          	auipc	ra,0x1
    80002990:	94c080e7          	jalr	-1716(ra) # 800032d8 <release>
    80002994:	e49ff06f          	j	800027dc <__printf+0x2a4>
    80002998:	f7843783          	ld	a5,-136(s0)
    8000299c:	03000513          	li	a0,48
    800029a0:	01000d13          	li	s10,16
    800029a4:	00878713          	addi	a4,a5,8
    800029a8:	0007bc83          	ld	s9,0(a5)
    800029ac:	f6e43c23          	sd	a4,-136(s0)
    800029b0:	00000097          	auipc	ra,0x0
    800029b4:	9a4080e7          	jalr	-1628(ra) # 80002354 <consputc>
    800029b8:	07800513          	li	a0,120
    800029bc:	00000097          	auipc	ra,0x0
    800029c0:	998080e7          	jalr	-1640(ra) # 80002354 <consputc>
    800029c4:	00001d97          	auipc	s11,0x1
    800029c8:	7c4d8d93          	addi	s11,s11,1988 # 80004188 <digits>
    800029cc:	03ccd793          	srli	a5,s9,0x3c
    800029d0:	00fd87b3          	add	a5,s11,a5
    800029d4:	0007c503          	lbu	a0,0(a5)
    800029d8:	fffd0d1b          	addiw	s10,s10,-1
    800029dc:	004c9c93          	slli	s9,s9,0x4
    800029e0:	00000097          	auipc	ra,0x0
    800029e4:	974080e7          	jalr	-1676(ra) # 80002354 <consputc>
    800029e8:	fe0d12e3          	bnez	s10,800029cc <__printf+0x494>
    800029ec:	f8dff06f          	j	80002978 <__printf+0x440>
    800029f0:	f7843783          	ld	a5,-136(s0)
    800029f4:	0007bc83          	ld	s9,0(a5)
    800029f8:	00878793          	addi	a5,a5,8
    800029fc:	f6f43c23          	sd	a5,-136(s0)
    80002a00:	000c9a63          	bnez	s9,80002a14 <__printf+0x4dc>
    80002a04:	1080006f          	j	80002b0c <__printf+0x5d4>
    80002a08:	001c8c93          	addi	s9,s9,1
    80002a0c:	00000097          	auipc	ra,0x0
    80002a10:	948080e7          	jalr	-1720(ra) # 80002354 <consputc>
    80002a14:	000cc503          	lbu	a0,0(s9)
    80002a18:	fe0518e3          	bnez	a0,80002a08 <__printf+0x4d0>
    80002a1c:	f5dff06f          	j	80002978 <__printf+0x440>
    80002a20:	02500513          	li	a0,37
    80002a24:	00000097          	auipc	ra,0x0
    80002a28:	930080e7          	jalr	-1744(ra) # 80002354 <consputc>
    80002a2c:	000c8513          	mv	a0,s9
    80002a30:	00000097          	auipc	ra,0x0
    80002a34:	924080e7          	jalr	-1756(ra) # 80002354 <consputc>
    80002a38:	f41ff06f          	j	80002978 <__printf+0x440>
    80002a3c:	02500513          	li	a0,37
    80002a40:	00000097          	auipc	ra,0x0
    80002a44:	914080e7          	jalr	-1772(ra) # 80002354 <consputc>
    80002a48:	f31ff06f          	j	80002978 <__printf+0x440>
    80002a4c:	00030513          	mv	a0,t1
    80002a50:	00000097          	auipc	ra,0x0
    80002a54:	7bc080e7          	jalr	1980(ra) # 8000320c <acquire>
    80002a58:	b4dff06f          	j	800025a4 <__printf+0x6c>
    80002a5c:	40c0053b          	negw	a0,a2
    80002a60:	00a00713          	li	a4,10
    80002a64:	02e576bb          	remuw	a3,a0,a4
    80002a68:	00001d97          	auipc	s11,0x1
    80002a6c:	720d8d93          	addi	s11,s11,1824 # 80004188 <digits>
    80002a70:	ff700593          	li	a1,-9
    80002a74:	02069693          	slli	a3,a3,0x20
    80002a78:	0206d693          	srli	a3,a3,0x20
    80002a7c:	00dd86b3          	add	a3,s11,a3
    80002a80:	0006c683          	lbu	a3,0(a3)
    80002a84:	02e557bb          	divuw	a5,a0,a4
    80002a88:	f8d40023          	sb	a3,-128(s0)
    80002a8c:	10b65e63          	bge	a2,a1,80002ba8 <__printf+0x670>
    80002a90:	06300593          	li	a1,99
    80002a94:	02e7f6bb          	remuw	a3,a5,a4
    80002a98:	02069693          	slli	a3,a3,0x20
    80002a9c:	0206d693          	srli	a3,a3,0x20
    80002aa0:	00dd86b3          	add	a3,s11,a3
    80002aa4:	0006c683          	lbu	a3,0(a3)
    80002aa8:	02e7d73b          	divuw	a4,a5,a4
    80002aac:	00200793          	li	a5,2
    80002ab0:	f8d400a3          	sb	a3,-127(s0)
    80002ab4:	bca5ece3          	bltu	a1,a0,8000268c <__printf+0x154>
    80002ab8:	ce5ff06f          	j	8000279c <__printf+0x264>
    80002abc:	40e007bb          	negw	a5,a4
    80002ac0:	00001d97          	auipc	s11,0x1
    80002ac4:	6c8d8d93          	addi	s11,s11,1736 # 80004188 <digits>
    80002ac8:	00f7f693          	andi	a3,a5,15
    80002acc:	00dd86b3          	add	a3,s11,a3
    80002ad0:	0006c583          	lbu	a1,0(a3)
    80002ad4:	ff100613          	li	a2,-15
    80002ad8:	0047d69b          	srliw	a3,a5,0x4
    80002adc:	f8b40023          	sb	a1,-128(s0)
    80002ae0:	0047d59b          	srliw	a1,a5,0x4
    80002ae4:	0ac75e63          	bge	a4,a2,80002ba0 <__printf+0x668>
    80002ae8:	00f6f693          	andi	a3,a3,15
    80002aec:	00dd86b3          	add	a3,s11,a3
    80002af0:	0006c603          	lbu	a2,0(a3)
    80002af4:	00f00693          	li	a3,15
    80002af8:	0087d79b          	srliw	a5,a5,0x8
    80002afc:	f8c400a3          	sb	a2,-127(s0)
    80002b00:	d8b6e4e3          	bltu	a3,a1,80002888 <__printf+0x350>
    80002b04:	00200793          	li	a5,2
    80002b08:	e2dff06f          	j	80002934 <__printf+0x3fc>
    80002b0c:	00001c97          	auipc	s9,0x1
    80002b10:	65cc8c93          	addi	s9,s9,1628 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    80002b14:	02800513          	li	a0,40
    80002b18:	ef1ff06f          	j	80002a08 <__printf+0x4d0>
    80002b1c:	00700793          	li	a5,7
    80002b20:	00600c93          	li	s9,6
    80002b24:	e0dff06f          	j	80002930 <__printf+0x3f8>
    80002b28:	00700793          	li	a5,7
    80002b2c:	00600c93          	li	s9,6
    80002b30:	c69ff06f          	j	80002798 <__printf+0x260>
    80002b34:	00300793          	li	a5,3
    80002b38:	00200c93          	li	s9,2
    80002b3c:	c5dff06f          	j	80002798 <__printf+0x260>
    80002b40:	00300793          	li	a5,3
    80002b44:	00200c93          	li	s9,2
    80002b48:	de9ff06f          	j	80002930 <__printf+0x3f8>
    80002b4c:	00400793          	li	a5,4
    80002b50:	00300c93          	li	s9,3
    80002b54:	dddff06f          	j	80002930 <__printf+0x3f8>
    80002b58:	00400793          	li	a5,4
    80002b5c:	00300c93          	li	s9,3
    80002b60:	c39ff06f          	j	80002798 <__printf+0x260>
    80002b64:	00500793          	li	a5,5
    80002b68:	00400c93          	li	s9,4
    80002b6c:	c2dff06f          	j	80002798 <__printf+0x260>
    80002b70:	00500793          	li	a5,5
    80002b74:	00400c93          	li	s9,4
    80002b78:	db9ff06f          	j	80002930 <__printf+0x3f8>
    80002b7c:	00600793          	li	a5,6
    80002b80:	00500c93          	li	s9,5
    80002b84:	dadff06f          	j	80002930 <__printf+0x3f8>
    80002b88:	00600793          	li	a5,6
    80002b8c:	00500c93          	li	s9,5
    80002b90:	c09ff06f          	j	80002798 <__printf+0x260>
    80002b94:	00800793          	li	a5,8
    80002b98:	00700c93          	li	s9,7
    80002b9c:	bfdff06f          	j	80002798 <__printf+0x260>
    80002ba0:	00100793          	li	a5,1
    80002ba4:	d91ff06f          	j	80002934 <__printf+0x3fc>
    80002ba8:	00100793          	li	a5,1
    80002bac:	bf1ff06f          	j	8000279c <__printf+0x264>
    80002bb0:	00900793          	li	a5,9
    80002bb4:	00800c93          	li	s9,8
    80002bb8:	be1ff06f          	j	80002798 <__printf+0x260>
    80002bbc:	00001517          	auipc	a0,0x1
    80002bc0:	5b450513          	addi	a0,a0,1460 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002bc4:	00000097          	auipc	ra,0x0
    80002bc8:	918080e7          	jalr	-1768(ra) # 800024dc <panic>

0000000080002bcc <printfinit>:
    80002bcc:	fe010113          	addi	sp,sp,-32
    80002bd0:	00813823          	sd	s0,16(sp)
    80002bd4:	00913423          	sd	s1,8(sp)
    80002bd8:	00113c23          	sd	ra,24(sp)
    80002bdc:	02010413          	addi	s0,sp,32
    80002be0:	00003497          	auipc	s1,0x3
    80002be4:	ad048493          	addi	s1,s1,-1328 # 800056b0 <pr>
    80002be8:	00048513          	mv	a0,s1
    80002bec:	00001597          	auipc	a1,0x1
    80002bf0:	59458593          	addi	a1,a1,1428 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    80002bf4:	00000097          	auipc	ra,0x0
    80002bf8:	5f4080e7          	jalr	1524(ra) # 800031e8 <initlock>
    80002bfc:	01813083          	ld	ra,24(sp)
    80002c00:	01013403          	ld	s0,16(sp)
    80002c04:	0004ac23          	sw	zero,24(s1)
    80002c08:	00813483          	ld	s1,8(sp)
    80002c0c:	02010113          	addi	sp,sp,32
    80002c10:	00008067          	ret

0000000080002c14 <uartinit>:
    80002c14:	ff010113          	addi	sp,sp,-16
    80002c18:	00813423          	sd	s0,8(sp)
    80002c1c:	01010413          	addi	s0,sp,16
    80002c20:	100007b7          	lui	a5,0x10000
    80002c24:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002c28:	f8000713          	li	a4,-128
    80002c2c:	00e781a3          	sb	a4,3(a5)
    80002c30:	00300713          	li	a4,3
    80002c34:	00e78023          	sb	a4,0(a5)
    80002c38:	000780a3          	sb	zero,1(a5)
    80002c3c:	00e781a3          	sb	a4,3(a5)
    80002c40:	00700693          	li	a3,7
    80002c44:	00d78123          	sb	a3,2(a5)
    80002c48:	00e780a3          	sb	a4,1(a5)
    80002c4c:	00813403          	ld	s0,8(sp)
    80002c50:	01010113          	addi	sp,sp,16
    80002c54:	00008067          	ret

0000000080002c58 <uartputc>:
    80002c58:	00002797          	auipc	a5,0x2
    80002c5c:	8107a783          	lw	a5,-2032(a5) # 80004468 <panicked>
    80002c60:	00078463          	beqz	a5,80002c68 <uartputc+0x10>
    80002c64:	0000006f          	j	80002c64 <uartputc+0xc>
    80002c68:	fd010113          	addi	sp,sp,-48
    80002c6c:	02813023          	sd	s0,32(sp)
    80002c70:	00913c23          	sd	s1,24(sp)
    80002c74:	01213823          	sd	s2,16(sp)
    80002c78:	01313423          	sd	s3,8(sp)
    80002c7c:	02113423          	sd	ra,40(sp)
    80002c80:	03010413          	addi	s0,sp,48
    80002c84:	00001917          	auipc	s2,0x1
    80002c88:	7ec90913          	addi	s2,s2,2028 # 80004470 <uart_tx_r>
    80002c8c:	00093783          	ld	a5,0(s2)
    80002c90:	00001497          	auipc	s1,0x1
    80002c94:	7e848493          	addi	s1,s1,2024 # 80004478 <uart_tx_w>
    80002c98:	0004b703          	ld	a4,0(s1)
    80002c9c:	02078693          	addi	a3,a5,32
    80002ca0:	00050993          	mv	s3,a0
    80002ca4:	02e69c63          	bne	a3,a4,80002cdc <uartputc+0x84>
    80002ca8:	00001097          	auipc	ra,0x1
    80002cac:	834080e7          	jalr	-1996(ra) # 800034dc <push_on>
    80002cb0:	00093783          	ld	a5,0(s2)
    80002cb4:	0004b703          	ld	a4,0(s1)
    80002cb8:	02078793          	addi	a5,a5,32
    80002cbc:	00e79463          	bne	a5,a4,80002cc4 <uartputc+0x6c>
    80002cc0:	0000006f          	j	80002cc0 <uartputc+0x68>
    80002cc4:	00001097          	auipc	ra,0x1
    80002cc8:	88c080e7          	jalr	-1908(ra) # 80003550 <pop_on>
    80002ccc:	00093783          	ld	a5,0(s2)
    80002cd0:	0004b703          	ld	a4,0(s1)
    80002cd4:	02078693          	addi	a3,a5,32
    80002cd8:	fce688e3          	beq	a3,a4,80002ca8 <uartputc+0x50>
    80002cdc:	01f77693          	andi	a3,a4,31
    80002ce0:	00003597          	auipc	a1,0x3
    80002ce4:	9f058593          	addi	a1,a1,-1552 # 800056d0 <uart_tx_buf>
    80002ce8:	00d586b3          	add	a3,a1,a3
    80002cec:	00170713          	addi	a4,a4,1
    80002cf0:	01368023          	sb	s3,0(a3)
    80002cf4:	00e4b023          	sd	a4,0(s1)
    80002cf8:	10000637          	lui	a2,0x10000
    80002cfc:	02f71063          	bne	a4,a5,80002d1c <uartputc+0xc4>
    80002d00:	0340006f          	j	80002d34 <uartputc+0xdc>
    80002d04:	00074703          	lbu	a4,0(a4)
    80002d08:	00f93023          	sd	a5,0(s2)
    80002d0c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002d10:	00093783          	ld	a5,0(s2)
    80002d14:	0004b703          	ld	a4,0(s1)
    80002d18:	00f70e63          	beq	a4,a5,80002d34 <uartputc+0xdc>
    80002d1c:	00564683          	lbu	a3,5(a2)
    80002d20:	01f7f713          	andi	a4,a5,31
    80002d24:	00e58733          	add	a4,a1,a4
    80002d28:	0206f693          	andi	a3,a3,32
    80002d2c:	00178793          	addi	a5,a5,1
    80002d30:	fc069ae3          	bnez	a3,80002d04 <uartputc+0xac>
    80002d34:	02813083          	ld	ra,40(sp)
    80002d38:	02013403          	ld	s0,32(sp)
    80002d3c:	01813483          	ld	s1,24(sp)
    80002d40:	01013903          	ld	s2,16(sp)
    80002d44:	00813983          	ld	s3,8(sp)
    80002d48:	03010113          	addi	sp,sp,48
    80002d4c:	00008067          	ret

0000000080002d50 <uartputc_sync>:
    80002d50:	ff010113          	addi	sp,sp,-16
    80002d54:	00813423          	sd	s0,8(sp)
    80002d58:	01010413          	addi	s0,sp,16
    80002d5c:	00001717          	auipc	a4,0x1
    80002d60:	70c72703          	lw	a4,1804(a4) # 80004468 <panicked>
    80002d64:	02071663          	bnez	a4,80002d90 <uartputc_sync+0x40>
    80002d68:	00050793          	mv	a5,a0
    80002d6c:	100006b7          	lui	a3,0x10000
    80002d70:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002d74:	02077713          	andi	a4,a4,32
    80002d78:	fe070ce3          	beqz	a4,80002d70 <uartputc_sync+0x20>
    80002d7c:	0ff7f793          	andi	a5,a5,255
    80002d80:	00f68023          	sb	a5,0(a3)
    80002d84:	00813403          	ld	s0,8(sp)
    80002d88:	01010113          	addi	sp,sp,16
    80002d8c:	00008067          	ret
    80002d90:	0000006f          	j	80002d90 <uartputc_sync+0x40>

0000000080002d94 <uartstart>:
    80002d94:	ff010113          	addi	sp,sp,-16
    80002d98:	00813423          	sd	s0,8(sp)
    80002d9c:	01010413          	addi	s0,sp,16
    80002da0:	00001617          	auipc	a2,0x1
    80002da4:	6d060613          	addi	a2,a2,1744 # 80004470 <uart_tx_r>
    80002da8:	00001517          	auipc	a0,0x1
    80002dac:	6d050513          	addi	a0,a0,1744 # 80004478 <uart_tx_w>
    80002db0:	00063783          	ld	a5,0(a2)
    80002db4:	00053703          	ld	a4,0(a0)
    80002db8:	04f70263          	beq	a4,a5,80002dfc <uartstart+0x68>
    80002dbc:	100005b7          	lui	a1,0x10000
    80002dc0:	00003817          	auipc	a6,0x3
    80002dc4:	91080813          	addi	a6,a6,-1776 # 800056d0 <uart_tx_buf>
    80002dc8:	01c0006f          	j	80002de4 <uartstart+0x50>
    80002dcc:	0006c703          	lbu	a4,0(a3)
    80002dd0:	00f63023          	sd	a5,0(a2)
    80002dd4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002dd8:	00063783          	ld	a5,0(a2)
    80002ddc:	00053703          	ld	a4,0(a0)
    80002de0:	00f70e63          	beq	a4,a5,80002dfc <uartstart+0x68>
    80002de4:	01f7f713          	andi	a4,a5,31
    80002de8:	00e806b3          	add	a3,a6,a4
    80002dec:	0055c703          	lbu	a4,5(a1)
    80002df0:	00178793          	addi	a5,a5,1
    80002df4:	02077713          	andi	a4,a4,32
    80002df8:	fc071ae3          	bnez	a4,80002dcc <uartstart+0x38>
    80002dfc:	00813403          	ld	s0,8(sp)
    80002e00:	01010113          	addi	sp,sp,16
    80002e04:	00008067          	ret

0000000080002e08 <uartgetc>:
    80002e08:	ff010113          	addi	sp,sp,-16
    80002e0c:	00813423          	sd	s0,8(sp)
    80002e10:	01010413          	addi	s0,sp,16
    80002e14:	10000737          	lui	a4,0x10000
    80002e18:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002e1c:	0017f793          	andi	a5,a5,1
    80002e20:	00078c63          	beqz	a5,80002e38 <uartgetc+0x30>
    80002e24:	00074503          	lbu	a0,0(a4)
    80002e28:	0ff57513          	andi	a0,a0,255
    80002e2c:	00813403          	ld	s0,8(sp)
    80002e30:	01010113          	addi	sp,sp,16
    80002e34:	00008067          	ret
    80002e38:	fff00513          	li	a0,-1
    80002e3c:	ff1ff06f          	j	80002e2c <uartgetc+0x24>

0000000080002e40 <uartintr>:
    80002e40:	100007b7          	lui	a5,0x10000
    80002e44:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002e48:	0017f793          	andi	a5,a5,1
    80002e4c:	0a078463          	beqz	a5,80002ef4 <uartintr+0xb4>
    80002e50:	fe010113          	addi	sp,sp,-32
    80002e54:	00813823          	sd	s0,16(sp)
    80002e58:	00913423          	sd	s1,8(sp)
    80002e5c:	00113c23          	sd	ra,24(sp)
    80002e60:	02010413          	addi	s0,sp,32
    80002e64:	100004b7          	lui	s1,0x10000
    80002e68:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002e6c:	0ff57513          	andi	a0,a0,255
    80002e70:	fffff097          	auipc	ra,0xfffff
    80002e74:	534080e7          	jalr	1332(ra) # 800023a4 <consoleintr>
    80002e78:	0054c783          	lbu	a5,5(s1)
    80002e7c:	0017f793          	andi	a5,a5,1
    80002e80:	fe0794e3          	bnez	a5,80002e68 <uartintr+0x28>
    80002e84:	00001617          	auipc	a2,0x1
    80002e88:	5ec60613          	addi	a2,a2,1516 # 80004470 <uart_tx_r>
    80002e8c:	00001517          	auipc	a0,0x1
    80002e90:	5ec50513          	addi	a0,a0,1516 # 80004478 <uart_tx_w>
    80002e94:	00063783          	ld	a5,0(a2)
    80002e98:	00053703          	ld	a4,0(a0)
    80002e9c:	04f70263          	beq	a4,a5,80002ee0 <uartintr+0xa0>
    80002ea0:	100005b7          	lui	a1,0x10000
    80002ea4:	00003817          	auipc	a6,0x3
    80002ea8:	82c80813          	addi	a6,a6,-2004 # 800056d0 <uart_tx_buf>
    80002eac:	01c0006f          	j	80002ec8 <uartintr+0x88>
    80002eb0:	0006c703          	lbu	a4,0(a3)
    80002eb4:	00f63023          	sd	a5,0(a2)
    80002eb8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002ebc:	00063783          	ld	a5,0(a2)
    80002ec0:	00053703          	ld	a4,0(a0)
    80002ec4:	00f70e63          	beq	a4,a5,80002ee0 <uartintr+0xa0>
    80002ec8:	01f7f713          	andi	a4,a5,31
    80002ecc:	00e806b3          	add	a3,a6,a4
    80002ed0:	0055c703          	lbu	a4,5(a1)
    80002ed4:	00178793          	addi	a5,a5,1
    80002ed8:	02077713          	andi	a4,a4,32
    80002edc:	fc071ae3          	bnez	a4,80002eb0 <uartintr+0x70>
    80002ee0:	01813083          	ld	ra,24(sp)
    80002ee4:	01013403          	ld	s0,16(sp)
    80002ee8:	00813483          	ld	s1,8(sp)
    80002eec:	02010113          	addi	sp,sp,32
    80002ef0:	00008067          	ret
    80002ef4:	00001617          	auipc	a2,0x1
    80002ef8:	57c60613          	addi	a2,a2,1404 # 80004470 <uart_tx_r>
    80002efc:	00001517          	auipc	a0,0x1
    80002f00:	57c50513          	addi	a0,a0,1404 # 80004478 <uart_tx_w>
    80002f04:	00063783          	ld	a5,0(a2)
    80002f08:	00053703          	ld	a4,0(a0)
    80002f0c:	04f70263          	beq	a4,a5,80002f50 <uartintr+0x110>
    80002f10:	100005b7          	lui	a1,0x10000
    80002f14:	00002817          	auipc	a6,0x2
    80002f18:	7bc80813          	addi	a6,a6,1980 # 800056d0 <uart_tx_buf>
    80002f1c:	01c0006f          	j	80002f38 <uartintr+0xf8>
    80002f20:	0006c703          	lbu	a4,0(a3)
    80002f24:	00f63023          	sd	a5,0(a2)
    80002f28:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002f2c:	00063783          	ld	a5,0(a2)
    80002f30:	00053703          	ld	a4,0(a0)
    80002f34:	02f70063          	beq	a4,a5,80002f54 <uartintr+0x114>
    80002f38:	01f7f713          	andi	a4,a5,31
    80002f3c:	00e806b3          	add	a3,a6,a4
    80002f40:	0055c703          	lbu	a4,5(a1)
    80002f44:	00178793          	addi	a5,a5,1
    80002f48:	02077713          	andi	a4,a4,32
    80002f4c:	fc071ae3          	bnez	a4,80002f20 <uartintr+0xe0>
    80002f50:	00008067          	ret
    80002f54:	00008067          	ret

0000000080002f58 <kinit>:
    80002f58:	fc010113          	addi	sp,sp,-64
    80002f5c:	02913423          	sd	s1,40(sp)
    80002f60:	fffff7b7          	lui	a5,0xfffff
    80002f64:	00003497          	auipc	s1,0x3
    80002f68:	78b48493          	addi	s1,s1,1931 # 800066ef <end+0xfff>
    80002f6c:	02813823          	sd	s0,48(sp)
    80002f70:	01313c23          	sd	s3,24(sp)
    80002f74:	00f4f4b3          	and	s1,s1,a5
    80002f78:	02113c23          	sd	ra,56(sp)
    80002f7c:	03213023          	sd	s2,32(sp)
    80002f80:	01413823          	sd	s4,16(sp)
    80002f84:	01513423          	sd	s5,8(sp)
    80002f88:	04010413          	addi	s0,sp,64
    80002f8c:	000017b7          	lui	a5,0x1
    80002f90:	01100993          	li	s3,17
    80002f94:	00f487b3          	add	a5,s1,a5
    80002f98:	01b99993          	slli	s3,s3,0x1b
    80002f9c:	06f9e063          	bltu	s3,a5,80002ffc <kinit+0xa4>
    80002fa0:	00002a97          	auipc	s5,0x2
    80002fa4:	750a8a93          	addi	s5,s5,1872 # 800056f0 <end>
    80002fa8:	0754ec63          	bltu	s1,s5,80003020 <kinit+0xc8>
    80002fac:	0734fa63          	bgeu	s1,s3,80003020 <kinit+0xc8>
    80002fb0:	00088a37          	lui	s4,0x88
    80002fb4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002fb8:	00001917          	auipc	s2,0x1
    80002fbc:	4c890913          	addi	s2,s2,1224 # 80004480 <kmem>
    80002fc0:	00ca1a13          	slli	s4,s4,0xc
    80002fc4:	0140006f          	j	80002fd8 <kinit+0x80>
    80002fc8:	000017b7          	lui	a5,0x1
    80002fcc:	00f484b3          	add	s1,s1,a5
    80002fd0:	0554e863          	bltu	s1,s5,80003020 <kinit+0xc8>
    80002fd4:	0534f663          	bgeu	s1,s3,80003020 <kinit+0xc8>
    80002fd8:	00001637          	lui	a2,0x1
    80002fdc:	00100593          	li	a1,1
    80002fe0:	00048513          	mv	a0,s1
    80002fe4:	00000097          	auipc	ra,0x0
    80002fe8:	5e4080e7          	jalr	1508(ra) # 800035c8 <__memset>
    80002fec:	00093783          	ld	a5,0(s2)
    80002ff0:	00f4b023          	sd	a5,0(s1)
    80002ff4:	00993023          	sd	s1,0(s2)
    80002ff8:	fd4498e3          	bne	s1,s4,80002fc8 <kinit+0x70>
    80002ffc:	03813083          	ld	ra,56(sp)
    80003000:	03013403          	ld	s0,48(sp)
    80003004:	02813483          	ld	s1,40(sp)
    80003008:	02013903          	ld	s2,32(sp)
    8000300c:	01813983          	ld	s3,24(sp)
    80003010:	01013a03          	ld	s4,16(sp)
    80003014:	00813a83          	ld	s5,8(sp)
    80003018:	04010113          	addi	sp,sp,64
    8000301c:	00008067          	ret
    80003020:	00001517          	auipc	a0,0x1
    80003024:	18050513          	addi	a0,a0,384 # 800041a0 <digits+0x18>
    80003028:	fffff097          	auipc	ra,0xfffff
    8000302c:	4b4080e7          	jalr	1204(ra) # 800024dc <panic>

0000000080003030 <freerange>:
    80003030:	fc010113          	addi	sp,sp,-64
    80003034:	000017b7          	lui	a5,0x1
    80003038:	02913423          	sd	s1,40(sp)
    8000303c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003040:	009504b3          	add	s1,a0,s1
    80003044:	fffff537          	lui	a0,0xfffff
    80003048:	02813823          	sd	s0,48(sp)
    8000304c:	02113c23          	sd	ra,56(sp)
    80003050:	03213023          	sd	s2,32(sp)
    80003054:	01313c23          	sd	s3,24(sp)
    80003058:	01413823          	sd	s4,16(sp)
    8000305c:	01513423          	sd	s5,8(sp)
    80003060:	01613023          	sd	s6,0(sp)
    80003064:	04010413          	addi	s0,sp,64
    80003068:	00a4f4b3          	and	s1,s1,a0
    8000306c:	00f487b3          	add	a5,s1,a5
    80003070:	06f5e463          	bltu	a1,a5,800030d8 <freerange+0xa8>
    80003074:	00002a97          	auipc	s5,0x2
    80003078:	67ca8a93          	addi	s5,s5,1660 # 800056f0 <end>
    8000307c:	0954e263          	bltu	s1,s5,80003100 <freerange+0xd0>
    80003080:	01100993          	li	s3,17
    80003084:	01b99993          	slli	s3,s3,0x1b
    80003088:	0734fc63          	bgeu	s1,s3,80003100 <freerange+0xd0>
    8000308c:	00058a13          	mv	s4,a1
    80003090:	00001917          	auipc	s2,0x1
    80003094:	3f090913          	addi	s2,s2,1008 # 80004480 <kmem>
    80003098:	00002b37          	lui	s6,0x2
    8000309c:	0140006f          	j	800030b0 <freerange+0x80>
    800030a0:	000017b7          	lui	a5,0x1
    800030a4:	00f484b3          	add	s1,s1,a5
    800030a8:	0554ec63          	bltu	s1,s5,80003100 <freerange+0xd0>
    800030ac:	0534fa63          	bgeu	s1,s3,80003100 <freerange+0xd0>
    800030b0:	00001637          	lui	a2,0x1
    800030b4:	00100593          	li	a1,1
    800030b8:	00048513          	mv	a0,s1
    800030bc:	00000097          	auipc	ra,0x0
    800030c0:	50c080e7          	jalr	1292(ra) # 800035c8 <__memset>
    800030c4:	00093703          	ld	a4,0(s2)
    800030c8:	016487b3          	add	a5,s1,s6
    800030cc:	00e4b023          	sd	a4,0(s1)
    800030d0:	00993023          	sd	s1,0(s2)
    800030d4:	fcfa76e3          	bgeu	s4,a5,800030a0 <freerange+0x70>
    800030d8:	03813083          	ld	ra,56(sp)
    800030dc:	03013403          	ld	s0,48(sp)
    800030e0:	02813483          	ld	s1,40(sp)
    800030e4:	02013903          	ld	s2,32(sp)
    800030e8:	01813983          	ld	s3,24(sp)
    800030ec:	01013a03          	ld	s4,16(sp)
    800030f0:	00813a83          	ld	s5,8(sp)
    800030f4:	00013b03          	ld	s6,0(sp)
    800030f8:	04010113          	addi	sp,sp,64
    800030fc:	00008067          	ret
    80003100:	00001517          	auipc	a0,0x1
    80003104:	0a050513          	addi	a0,a0,160 # 800041a0 <digits+0x18>
    80003108:	fffff097          	auipc	ra,0xfffff
    8000310c:	3d4080e7          	jalr	980(ra) # 800024dc <panic>

0000000080003110 <kfree>:
    80003110:	fe010113          	addi	sp,sp,-32
    80003114:	00813823          	sd	s0,16(sp)
    80003118:	00113c23          	sd	ra,24(sp)
    8000311c:	00913423          	sd	s1,8(sp)
    80003120:	02010413          	addi	s0,sp,32
    80003124:	03451793          	slli	a5,a0,0x34
    80003128:	04079c63          	bnez	a5,80003180 <kfree+0x70>
    8000312c:	00002797          	auipc	a5,0x2
    80003130:	5c478793          	addi	a5,a5,1476 # 800056f0 <end>
    80003134:	00050493          	mv	s1,a0
    80003138:	04f56463          	bltu	a0,a5,80003180 <kfree+0x70>
    8000313c:	01100793          	li	a5,17
    80003140:	01b79793          	slli	a5,a5,0x1b
    80003144:	02f57e63          	bgeu	a0,a5,80003180 <kfree+0x70>
    80003148:	00001637          	lui	a2,0x1
    8000314c:	00100593          	li	a1,1
    80003150:	00000097          	auipc	ra,0x0
    80003154:	478080e7          	jalr	1144(ra) # 800035c8 <__memset>
    80003158:	00001797          	auipc	a5,0x1
    8000315c:	32878793          	addi	a5,a5,808 # 80004480 <kmem>
    80003160:	0007b703          	ld	a4,0(a5)
    80003164:	01813083          	ld	ra,24(sp)
    80003168:	01013403          	ld	s0,16(sp)
    8000316c:	00e4b023          	sd	a4,0(s1)
    80003170:	0097b023          	sd	s1,0(a5)
    80003174:	00813483          	ld	s1,8(sp)
    80003178:	02010113          	addi	sp,sp,32
    8000317c:	00008067          	ret
    80003180:	00001517          	auipc	a0,0x1
    80003184:	02050513          	addi	a0,a0,32 # 800041a0 <digits+0x18>
    80003188:	fffff097          	auipc	ra,0xfffff
    8000318c:	354080e7          	jalr	852(ra) # 800024dc <panic>

0000000080003190 <kalloc>:
    80003190:	fe010113          	addi	sp,sp,-32
    80003194:	00813823          	sd	s0,16(sp)
    80003198:	00913423          	sd	s1,8(sp)
    8000319c:	00113c23          	sd	ra,24(sp)
    800031a0:	02010413          	addi	s0,sp,32
    800031a4:	00001797          	auipc	a5,0x1
    800031a8:	2dc78793          	addi	a5,a5,732 # 80004480 <kmem>
    800031ac:	0007b483          	ld	s1,0(a5)
    800031b0:	02048063          	beqz	s1,800031d0 <kalloc+0x40>
    800031b4:	0004b703          	ld	a4,0(s1)
    800031b8:	00001637          	lui	a2,0x1
    800031bc:	00500593          	li	a1,5
    800031c0:	00048513          	mv	a0,s1
    800031c4:	00e7b023          	sd	a4,0(a5)
    800031c8:	00000097          	auipc	ra,0x0
    800031cc:	400080e7          	jalr	1024(ra) # 800035c8 <__memset>
    800031d0:	01813083          	ld	ra,24(sp)
    800031d4:	01013403          	ld	s0,16(sp)
    800031d8:	00048513          	mv	a0,s1
    800031dc:	00813483          	ld	s1,8(sp)
    800031e0:	02010113          	addi	sp,sp,32
    800031e4:	00008067          	ret

00000000800031e8 <initlock>:
    800031e8:	ff010113          	addi	sp,sp,-16
    800031ec:	00813423          	sd	s0,8(sp)
    800031f0:	01010413          	addi	s0,sp,16
    800031f4:	00813403          	ld	s0,8(sp)
    800031f8:	00b53423          	sd	a1,8(a0)
    800031fc:	00052023          	sw	zero,0(a0)
    80003200:	00053823          	sd	zero,16(a0)
    80003204:	01010113          	addi	sp,sp,16
    80003208:	00008067          	ret

000000008000320c <acquire>:
    8000320c:	fe010113          	addi	sp,sp,-32
    80003210:	00813823          	sd	s0,16(sp)
    80003214:	00913423          	sd	s1,8(sp)
    80003218:	00113c23          	sd	ra,24(sp)
    8000321c:	01213023          	sd	s2,0(sp)
    80003220:	02010413          	addi	s0,sp,32
    80003224:	00050493          	mv	s1,a0
    80003228:	10002973          	csrr	s2,sstatus
    8000322c:	100027f3          	csrr	a5,sstatus
    80003230:	ffd7f793          	andi	a5,a5,-3
    80003234:	10079073          	csrw	sstatus,a5
    80003238:	fffff097          	auipc	ra,0xfffff
    8000323c:	8e4080e7          	jalr	-1820(ra) # 80001b1c <mycpu>
    80003240:	07852783          	lw	a5,120(a0)
    80003244:	06078e63          	beqz	a5,800032c0 <acquire+0xb4>
    80003248:	fffff097          	auipc	ra,0xfffff
    8000324c:	8d4080e7          	jalr	-1836(ra) # 80001b1c <mycpu>
    80003250:	07852783          	lw	a5,120(a0)
    80003254:	0004a703          	lw	a4,0(s1)
    80003258:	0017879b          	addiw	a5,a5,1
    8000325c:	06f52c23          	sw	a5,120(a0)
    80003260:	04071063          	bnez	a4,800032a0 <acquire+0x94>
    80003264:	00100713          	li	a4,1
    80003268:	00070793          	mv	a5,a4
    8000326c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003270:	0007879b          	sext.w	a5,a5
    80003274:	fe079ae3          	bnez	a5,80003268 <acquire+0x5c>
    80003278:	0ff0000f          	fence
    8000327c:	fffff097          	auipc	ra,0xfffff
    80003280:	8a0080e7          	jalr	-1888(ra) # 80001b1c <mycpu>
    80003284:	01813083          	ld	ra,24(sp)
    80003288:	01013403          	ld	s0,16(sp)
    8000328c:	00a4b823          	sd	a0,16(s1)
    80003290:	00013903          	ld	s2,0(sp)
    80003294:	00813483          	ld	s1,8(sp)
    80003298:	02010113          	addi	sp,sp,32
    8000329c:	00008067          	ret
    800032a0:	0104b903          	ld	s2,16(s1)
    800032a4:	fffff097          	auipc	ra,0xfffff
    800032a8:	878080e7          	jalr	-1928(ra) # 80001b1c <mycpu>
    800032ac:	faa91ce3          	bne	s2,a0,80003264 <acquire+0x58>
    800032b0:	00001517          	auipc	a0,0x1
    800032b4:	ef850513          	addi	a0,a0,-264 # 800041a8 <digits+0x20>
    800032b8:	fffff097          	auipc	ra,0xfffff
    800032bc:	224080e7          	jalr	548(ra) # 800024dc <panic>
    800032c0:	00195913          	srli	s2,s2,0x1
    800032c4:	fffff097          	auipc	ra,0xfffff
    800032c8:	858080e7          	jalr	-1960(ra) # 80001b1c <mycpu>
    800032cc:	00197913          	andi	s2,s2,1
    800032d0:	07252e23          	sw	s2,124(a0)
    800032d4:	f75ff06f          	j	80003248 <acquire+0x3c>

00000000800032d8 <release>:
    800032d8:	fe010113          	addi	sp,sp,-32
    800032dc:	00813823          	sd	s0,16(sp)
    800032e0:	00113c23          	sd	ra,24(sp)
    800032e4:	00913423          	sd	s1,8(sp)
    800032e8:	01213023          	sd	s2,0(sp)
    800032ec:	02010413          	addi	s0,sp,32
    800032f0:	00052783          	lw	a5,0(a0)
    800032f4:	00079a63          	bnez	a5,80003308 <release+0x30>
    800032f8:	00001517          	auipc	a0,0x1
    800032fc:	eb850513          	addi	a0,a0,-328 # 800041b0 <digits+0x28>
    80003300:	fffff097          	auipc	ra,0xfffff
    80003304:	1dc080e7          	jalr	476(ra) # 800024dc <panic>
    80003308:	01053903          	ld	s2,16(a0)
    8000330c:	00050493          	mv	s1,a0
    80003310:	fffff097          	auipc	ra,0xfffff
    80003314:	80c080e7          	jalr	-2036(ra) # 80001b1c <mycpu>
    80003318:	fea910e3          	bne	s2,a0,800032f8 <release+0x20>
    8000331c:	0004b823          	sd	zero,16(s1)
    80003320:	0ff0000f          	fence
    80003324:	0f50000f          	fence	iorw,ow
    80003328:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000332c:	ffffe097          	auipc	ra,0xffffe
    80003330:	7f0080e7          	jalr	2032(ra) # 80001b1c <mycpu>
    80003334:	100027f3          	csrr	a5,sstatus
    80003338:	0027f793          	andi	a5,a5,2
    8000333c:	04079a63          	bnez	a5,80003390 <release+0xb8>
    80003340:	07852783          	lw	a5,120(a0)
    80003344:	02f05e63          	blez	a5,80003380 <release+0xa8>
    80003348:	fff7871b          	addiw	a4,a5,-1
    8000334c:	06e52c23          	sw	a4,120(a0)
    80003350:	00071c63          	bnez	a4,80003368 <release+0x90>
    80003354:	07c52783          	lw	a5,124(a0)
    80003358:	00078863          	beqz	a5,80003368 <release+0x90>
    8000335c:	100027f3          	csrr	a5,sstatus
    80003360:	0027e793          	ori	a5,a5,2
    80003364:	10079073          	csrw	sstatus,a5
    80003368:	01813083          	ld	ra,24(sp)
    8000336c:	01013403          	ld	s0,16(sp)
    80003370:	00813483          	ld	s1,8(sp)
    80003374:	00013903          	ld	s2,0(sp)
    80003378:	02010113          	addi	sp,sp,32
    8000337c:	00008067          	ret
    80003380:	00001517          	auipc	a0,0x1
    80003384:	e5050513          	addi	a0,a0,-432 # 800041d0 <digits+0x48>
    80003388:	fffff097          	auipc	ra,0xfffff
    8000338c:	154080e7          	jalr	340(ra) # 800024dc <panic>
    80003390:	00001517          	auipc	a0,0x1
    80003394:	e2850513          	addi	a0,a0,-472 # 800041b8 <digits+0x30>
    80003398:	fffff097          	auipc	ra,0xfffff
    8000339c:	144080e7          	jalr	324(ra) # 800024dc <panic>

00000000800033a0 <holding>:
    800033a0:	00052783          	lw	a5,0(a0)
    800033a4:	00079663          	bnez	a5,800033b0 <holding+0x10>
    800033a8:	00000513          	li	a0,0
    800033ac:	00008067          	ret
    800033b0:	fe010113          	addi	sp,sp,-32
    800033b4:	00813823          	sd	s0,16(sp)
    800033b8:	00913423          	sd	s1,8(sp)
    800033bc:	00113c23          	sd	ra,24(sp)
    800033c0:	02010413          	addi	s0,sp,32
    800033c4:	01053483          	ld	s1,16(a0)
    800033c8:	ffffe097          	auipc	ra,0xffffe
    800033cc:	754080e7          	jalr	1876(ra) # 80001b1c <mycpu>
    800033d0:	01813083          	ld	ra,24(sp)
    800033d4:	01013403          	ld	s0,16(sp)
    800033d8:	40a48533          	sub	a0,s1,a0
    800033dc:	00153513          	seqz	a0,a0
    800033e0:	00813483          	ld	s1,8(sp)
    800033e4:	02010113          	addi	sp,sp,32
    800033e8:	00008067          	ret

00000000800033ec <push_off>:
    800033ec:	fe010113          	addi	sp,sp,-32
    800033f0:	00813823          	sd	s0,16(sp)
    800033f4:	00113c23          	sd	ra,24(sp)
    800033f8:	00913423          	sd	s1,8(sp)
    800033fc:	02010413          	addi	s0,sp,32
    80003400:	100024f3          	csrr	s1,sstatus
    80003404:	100027f3          	csrr	a5,sstatus
    80003408:	ffd7f793          	andi	a5,a5,-3
    8000340c:	10079073          	csrw	sstatus,a5
    80003410:	ffffe097          	auipc	ra,0xffffe
    80003414:	70c080e7          	jalr	1804(ra) # 80001b1c <mycpu>
    80003418:	07852783          	lw	a5,120(a0)
    8000341c:	02078663          	beqz	a5,80003448 <push_off+0x5c>
    80003420:	ffffe097          	auipc	ra,0xffffe
    80003424:	6fc080e7          	jalr	1788(ra) # 80001b1c <mycpu>
    80003428:	07852783          	lw	a5,120(a0)
    8000342c:	01813083          	ld	ra,24(sp)
    80003430:	01013403          	ld	s0,16(sp)
    80003434:	0017879b          	addiw	a5,a5,1
    80003438:	06f52c23          	sw	a5,120(a0)
    8000343c:	00813483          	ld	s1,8(sp)
    80003440:	02010113          	addi	sp,sp,32
    80003444:	00008067          	ret
    80003448:	0014d493          	srli	s1,s1,0x1
    8000344c:	ffffe097          	auipc	ra,0xffffe
    80003450:	6d0080e7          	jalr	1744(ra) # 80001b1c <mycpu>
    80003454:	0014f493          	andi	s1,s1,1
    80003458:	06952e23          	sw	s1,124(a0)
    8000345c:	fc5ff06f          	j	80003420 <push_off+0x34>

0000000080003460 <pop_off>:
    80003460:	ff010113          	addi	sp,sp,-16
    80003464:	00813023          	sd	s0,0(sp)
    80003468:	00113423          	sd	ra,8(sp)
    8000346c:	01010413          	addi	s0,sp,16
    80003470:	ffffe097          	auipc	ra,0xffffe
    80003474:	6ac080e7          	jalr	1708(ra) # 80001b1c <mycpu>
    80003478:	100027f3          	csrr	a5,sstatus
    8000347c:	0027f793          	andi	a5,a5,2
    80003480:	04079663          	bnez	a5,800034cc <pop_off+0x6c>
    80003484:	07852783          	lw	a5,120(a0)
    80003488:	02f05a63          	blez	a5,800034bc <pop_off+0x5c>
    8000348c:	fff7871b          	addiw	a4,a5,-1
    80003490:	06e52c23          	sw	a4,120(a0)
    80003494:	00071c63          	bnez	a4,800034ac <pop_off+0x4c>
    80003498:	07c52783          	lw	a5,124(a0)
    8000349c:	00078863          	beqz	a5,800034ac <pop_off+0x4c>
    800034a0:	100027f3          	csrr	a5,sstatus
    800034a4:	0027e793          	ori	a5,a5,2
    800034a8:	10079073          	csrw	sstatus,a5
    800034ac:	00813083          	ld	ra,8(sp)
    800034b0:	00013403          	ld	s0,0(sp)
    800034b4:	01010113          	addi	sp,sp,16
    800034b8:	00008067          	ret
    800034bc:	00001517          	auipc	a0,0x1
    800034c0:	d1450513          	addi	a0,a0,-748 # 800041d0 <digits+0x48>
    800034c4:	fffff097          	auipc	ra,0xfffff
    800034c8:	018080e7          	jalr	24(ra) # 800024dc <panic>
    800034cc:	00001517          	auipc	a0,0x1
    800034d0:	cec50513          	addi	a0,a0,-788 # 800041b8 <digits+0x30>
    800034d4:	fffff097          	auipc	ra,0xfffff
    800034d8:	008080e7          	jalr	8(ra) # 800024dc <panic>

00000000800034dc <push_on>:
    800034dc:	fe010113          	addi	sp,sp,-32
    800034e0:	00813823          	sd	s0,16(sp)
    800034e4:	00113c23          	sd	ra,24(sp)
    800034e8:	00913423          	sd	s1,8(sp)
    800034ec:	02010413          	addi	s0,sp,32
    800034f0:	100024f3          	csrr	s1,sstatus
    800034f4:	100027f3          	csrr	a5,sstatus
    800034f8:	0027e793          	ori	a5,a5,2
    800034fc:	10079073          	csrw	sstatus,a5
    80003500:	ffffe097          	auipc	ra,0xffffe
    80003504:	61c080e7          	jalr	1564(ra) # 80001b1c <mycpu>
    80003508:	07852783          	lw	a5,120(a0)
    8000350c:	02078663          	beqz	a5,80003538 <push_on+0x5c>
    80003510:	ffffe097          	auipc	ra,0xffffe
    80003514:	60c080e7          	jalr	1548(ra) # 80001b1c <mycpu>
    80003518:	07852783          	lw	a5,120(a0)
    8000351c:	01813083          	ld	ra,24(sp)
    80003520:	01013403          	ld	s0,16(sp)
    80003524:	0017879b          	addiw	a5,a5,1
    80003528:	06f52c23          	sw	a5,120(a0)
    8000352c:	00813483          	ld	s1,8(sp)
    80003530:	02010113          	addi	sp,sp,32
    80003534:	00008067          	ret
    80003538:	0014d493          	srli	s1,s1,0x1
    8000353c:	ffffe097          	auipc	ra,0xffffe
    80003540:	5e0080e7          	jalr	1504(ra) # 80001b1c <mycpu>
    80003544:	0014f493          	andi	s1,s1,1
    80003548:	06952e23          	sw	s1,124(a0)
    8000354c:	fc5ff06f          	j	80003510 <push_on+0x34>

0000000080003550 <pop_on>:
    80003550:	ff010113          	addi	sp,sp,-16
    80003554:	00813023          	sd	s0,0(sp)
    80003558:	00113423          	sd	ra,8(sp)
    8000355c:	01010413          	addi	s0,sp,16
    80003560:	ffffe097          	auipc	ra,0xffffe
    80003564:	5bc080e7          	jalr	1468(ra) # 80001b1c <mycpu>
    80003568:	100027f3          	csrr	a5,sstatus
    8000356c:	0027f793          	andi	a5,a5,2
    80003570:	04078463          	beqz	a5,800035b8 <pop_on+0x68>
    80003574:	07852783          	lw	a5,120(a0)
    80003578:	02f05863          	blez	a5,800035a8 <pop_on+0x58>
    8000357c:	fff7879b          	addiw	a5,a5,-1
    80003580:	06f52c23          	sw	a5,120(a0)
    80003584:	07853783          	ld	a5,120(a0)
    80003588:	00079863          	bnez	a5,80003598 <pop_on+0x48>
    8000358c:	100027f3          	csrr	a5,sstatus
    80003590:	ffd7f793          	andi	a5,a5,-3
    80003594:	10079073          	csrw	sstatus,a5
    80003598:	00813083          	ld	ra,8(sp)
    8000359c:	00013403          	ld	s0,0(sp)
    800035a0:	01010113          	addi	sp,sp,16
    800035a4:	00008067          	ret
    800035a8:	00001517          	auipc	a0,0x1
    800035ac:	c5050513          	addi	a0,a0,-944 # 800041f8 <digits+0x70>
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	f2c080e7          	jalr	-212(ra) # 800024dc <panic>
    800035b8:	00001517          	auipc	a0,0x1
    800035bc:	c2050513          	addi	a0,a0,-992 # 800041d8 <digits+0x50>
    800035c0:	fffff097          	auipc	ra,0xfffff
    800035c4:	f1c080e7          	jalr	-228(ra) # 800024dc <panic>

00000000800035c8 <__memset>:
    800035c8:	ff010113          	addi	sp,sp,-16
    800035cc:	00813423          	sd	s0,8(sp)
    800035d0:	01010413          	addi	s0,sp,16
    800035d4:	1a060e63          	beqz	a2,80003790 <__memset+0x1c8>
    800035d8:	40a007b3          	neg	a5,a0
    800035dc:	0077f793          	andi	a5,a5,7
    800035e0:	00778693          	addi	a3,a5,7
    800035e4:	00b00813          	li	a6,11
    800035e8:	0ff5f593          	andi	a1,a1,255
    800035ec:	fff6071b          	addiw	a4,a2,-1
    800035f0:	1b06e663          	bltu	a3,a6,8000379c <__memset+0x1d4>
    800035f4:	1cd76463          	bltu	a4,a3,800037bc <__memset+0x1f4>
    800035f8:	1a078e63          	beqz	a5,800037b4 <__memset+0x1ec>
    800035fc:	00b50023          	sb	a1,0(a0)
    80003600:	00100713          	li	a4,1
    80003604:	1ae78463          	beq	a5,a4,800037ac <__memset+0x1e4>
    80003608:	00b500a3          	sb	a1,1(a0)
    8000360c:	00200713          	li	a4,2
    80003610:	1ae78a63          	beq	a5,a4,800037c4 <__memset+0x1fc>
    80003614:	00b50123          	sb	a1,2(a0)
    80003618:	00300713          	li	a4,3
    8000361c:	18e78463          	beq	a5,a4,800037a4 <__memset+0x1dc>
    80003620:	00b501a3          	sb	a1,3(a0)
    80003624:	00400713          	li	a4,4
    80003628:	1ae78263          	beq	a5,a4,800037cc <__memset+0x204>
    8000362c:	00b50223          	sb	a1,4(a0)
    80003630:	00500713          	li	a4,5
    80003634:	1ae78063          	beq	a5,a4,800037d4 <__memset+0x20c>
    80003638:	00b502a3          	sb	a1,5(a0)
    8000363c:	00700713          	li	a4,7
    80003640:	18e79e63          	bne	a5,a4,800037dc <__memset+0x214>
    80003644:	00b50323          	sb	a1,6(a0)
    80003648:	00700e93          	li	t4,7
    8000364c:	00859713          	slli	a4,a1,0x8
    80003650:	00e5e733          	or	a4,a1,a4
    80003654:	01059e13          	slli	t3,a1,0x10
    80003658:	01c76e33          	or	t3,a4,t3
    8000365c:	01859313          	slli	t1,a1,0x18
    80003660:	006e6333          	or	t1,t3,t1
    80003664:	02059893          	slli	a7,a1,0x20
    80003668:	40f60e3b          	subw	t3,a2,a5
    8000366c:	011368b3          	or	a7,t1,a7
    80003670:	02859813          	slli	a6,a1,0x28
    80003674:	0108e833          	or	a6,a7,a6
    80003678:	03059693          	slli	a3,a1,0x30
    8000367c:	003e589b          	srliw	a7,t3,0x3
    80003680:	00d866b3          	or	a3,a6,a3
    80003684:	03859713          	slli	a4,a1,0x38
    80003688:	00389813          	slli	a6,a7,0x3
    8000368c:	00f507b3          	add	a5,a0,a5
    80003690:	00e6e733          	or	a4,a3,a4
    80003694:	000e089b          	sext.w	a7,t3
    80003698:	00f806b3          	add	a3,a6,a5
    8000369c:	00e7b023          	sd	a4,0(a5)
    800036a0:	00878793          	addi	a5,a5,8
    800036a4:	fed79ce3          	bne	a5,a3,8000369c <__memset+0xd4>
    800036a8:	ff8e7793          	andi	a5,t3,-8
    800036ac:	0007871b          	sext.w	a4,a5
    800036b0:	01d787bb          	addw	a5,a5,t4
    800036b4:	0ce88e63          	beq	a7,a4,80003790 <__memset+0x1c8>
    800036b8:	00f50733          	add	a4,a0,a5
    800036bc:	00b70023          	sb	a1,0(a4)
    800036c0:	0017871b          	addiw	a4,a5,1
    800036c4:	0cc77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    800036c8:	00e50733          	add	a4,a0,a4
    800036cc:	00b70023          	sb	a1,0(a4)
    800036d0:	0027871b          	addiw	a4,a5,2
    800036d4:	0ac77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    800036d8:	00e50733          	add	a4,a0,a4
    800036dc:	00b70023          	sb	a1,0(a4)
    800036e0:	0037871b          	addiw	a4,a5,3
    800036e4:	0ac77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    800036e8:	00e50733          	add	a4,a0,a4
    800036ec:	00b70023          	sb	a1,0(a4)
    800036f0:	0047871b          	addiw	a4,a5,4
    800036f4:	08c77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    800036f8:	00e50733          	add	a4,a0,a4
    800036fc:	00b70023          	sb	a1,0(a4)
    80003700:	0057871b          	addiw	a4,a5,5
    80003704:	08c77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003708:	00e50733          	add	a4,a0,a4
    8000370c:	00b70023          	sb	a1,0(a4)
    80003710:	0067871b          	addiw	a4,a5,6
    80003714:	06c77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003718:	00e50733          	add	a4,a0,a4
    8000371c:	00b70023          	sb	a1,0(a4)
    80003720:	0077871b          	addiw	a4,a5,7
    80003724:	06c77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003728:	00e50733          	add	a4,a0,a4
    8000372c:	00b70023          	sb	a1,0(a4)
    80003730:	0087871b          	addiw	a4,a5,8
    80003734:	04c77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003738:	00e50733          	add	a4,a0,a4
    8000373c:	00b70023          	sb	a1,0(a4)
    80003740:	0097871b          	addiw	a4,a5,9
    80003744:	04c77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003748:	00e50733          	add	a4,a0,a4
    8000374c:	00b70023          	sb	a1,0(a4)
    80003750:	00a7871b          	addiw	a4,a5,10
    80003754:	02c77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003758:	00e50733          	add	a4,a0,a4
    8000375c:	00b70023          	sb	a1,0(a4)
    80003760:	00b7871b          	addiw	a4,a5,11
    80003764:	02c77663          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003768:	00e50733          	add	a4,a0,a4
    8000376c:	00b70023          	sb	a1,0(a4)
    80003770:	00c7871b          	addiw	a4,a5,12
    80003774:	00c77e63          	bgeu	a4,a2,80003790 <__memset+0x1c8>
    80003778:	00e50733          	add	a4,a0,a4
    8000377c:	00b70023          	sb	a1,0(a4)
    80003780:	00d7879b          	addiw	a5,a5,13
    80003784:	00c7f663          	bgeu	a5,a2,80003790 <__memset+0x1c8>
    80003788:	00f507b3          	add	a5,a0,a5
    8000378c:	00b78023          	sb	a1,0(a5)
    80003790:	00813403          	ld	s0,8(sp)
    80003794:	01010113          	addi	sp,sp,16
    80003798:	00008067          	ret
    8000379c:	00b00693          	li	a3,11
    800037a0:	e55ff06f          	j	800035f4 <__memset+0x2c>
    800037a4:	00300e93          	li	t4,3
    800037a8:	ea5ff06f          	j	8000364c <__memset+0x84>
    800037ac:	00100e93          	li	t4,1
    800037b0:	e9dff06f          	j	8000364c <__memset+0x84>
    800037b4:	00000e93          	li	t4,0
    800037b8:	e95ff06f          	j	8000364c <__memset+0x84>
    800037bc:	00000793          	li	a5,0
    800037c0:	ef9ff06f          	j	800036b8 <__memset+0xf0>
    800037c4:	00200e93          	li	t4,2
    800037c8:	e85ff06f          	j	8000364c <__memset+0x84>
    800037cc:	00400e93          	li	t4,4
    800037d0:	e7dff06f          	j	8000364c <__memset+0x84>
    800037d4:	00500e93          	li	t4,5
    800037d8:	e75ff06f          	j	8000364c <__memset+0x84>
    800037dc:	00600e93          	li	t4,6
    800037e0:	e6dff06f          	j	8000364c <__memset+0x84>

00000000800037e4 <__memmove>:
    800037e4:	ff010113          	addi	sp,sp,-16
    800037e8:	00813423          	sd	s0,8(sp)
    800037ec:	01010413          	addi	s0,sp,16
    800037f0:	0e060863          	beqz	a2,800038e0 <__memmove+0xfc>
    800037f4:	fff6069b          	addiw	a3,a2,-1
    800037f8:	0006881b          	sext.w	a6,a3
    800037fc:	0ea5e863          	bltu	a1,a0,800038ec <__memmove+0x108>
    80003800:	00758713          	addi	a4,a1,7
    80003804:	00a5e7b3          	or	a5,a1,a0
    80003808:	40a70733          	sub	a4,a4,a0
    8000380c:	0077f793          	andi	a5,a5,7
    80003810:	00f73713          	sltiu	a4,a4,15
    80003814:	00174713          	xori	a4,a4,1
    80003818:	0017b793          	seqz	a5,a5
    8000381c:	00e7f7b3          	and	a5,a5,a4
    80003820:	10078863          	beqz	a5,80003930 <__memmove+0x14c>
    80003824:	00900793          	li	a5,9
    80003828:	1107f463          	bgeu	a5,a6,80003930 <__memmove+0x14c>
    8000382c:	0036581b          	srliw	a6,a2,0x3
    80003830:	fff8081b          	addiw	a6,a6,-1
    80003834:	02081813          	slli	a6,a6,0x20
    80003838:	01d85893          	srli	a7,a6,0x1d
    8000383c:	00858813          	addi	a6,a1,8
    80003840:	00058793          	mv	a5,a1
    80003844:	00050713          	mv	a4,a0
    80003848:	01088833          	add	a6,a7,a6
    8000384c:	0007b883          	ld	a7,0(a5)
    80003850:	00878793          	addi	a5,a5,8
    80003854:	00870713          	addi	a4,a4,8
    80003858:	ff173c23          	sd	a7,-8(a4)
    8000385c:	ff0798e3          	bne	a5,a6,8000384c <__memmove+0x68>
    80003860:	ff867713          	andi	a4,a2,-8
    80003864:	02071793          	slli	a5,a4,0x20
    80003868:	0207d793          	srli	a5,a5,0x20
    8000386c:	00f585b3          	add	a1,a1,a5
    80003870:	40e686bb          	subw	a3,a3,a4
    80003874:	00f507b3          	add	a5,a0,a5
    80003878:	06e60463          	beq	a2,a4,800038e0 <__memmove+0xfc>
    8000387c:	0005c703          	lbu	a4,0(a1)
    80003880:	00e78023          	sb	a4,0(a5)
    80003884:	04068e63          	beqz	a3,800038e0 <__memmove+0xfc>
    80003888:	0015c603          	lbu	a2,1(a1)
    8000388c:	00100713          	li	a4,1
    80003890:	00c780a3          	sb	a2,1(a5)
    80003894:	04e68663          	beq	a3,a4,800038e0 <__memmove+0xfc>
    80003898:	0025c603          	lbu	a2,2(a1)
    8000389c:	00200713          	li	a4,2
    800038a0:	00c78123          	sb	a2,2(a5)
    800038a4:	02e68e63          	beq	a3,a4,800038e0 <__memmove+0xfc>
    800038a8:	0035c603          	lbu	a2,3(a1)
    800038ac:	00300713          	li	a4,3
    800038b0:	00c781a3          	sb	a2,3(a5)
    800038b4:	02e68663          	beq	a3,a4,800038e0 <__memmove+0xfc>
    800038b8:	0045c603          	lbu	a2,4(a1)
    800038bc:	00400713          	li	a4,4
    800038c0:	00c78223          	sb	a2,4(a5)
    800038c4:	00e68e63          	beq	a3,a4,800038e0 <__memmove+0xfc>
    800038c8:	0055c603          	lbu	a2,5(a1)
    800038cc:	00500713          	li	a4,5
    800038d0:	00c782a3          	sb	a2,5(a5)
    800038d4:	00e68663          	beq	a3,a4,800038e0 <__memmove+0xfc>
    800038d8:	0065c703          	lbu	a4,6(a1)
    800038dc:	00e78323          	sb	a4,6(a5)
    800038e0:	00813403          	ld	s0,8(sp)
    800038e4:	01010113          	addi	sp,sp,16
    800038e8:	00008067          	ret
    800038ec:	02061713          	slli	a4,a2,0x20
    800038f0:	02075713          	srli	a4,a4,0x20
    800038f4:	00e587b3          	add	a5,a1,a4
    800038f8:	f0f574e3          	bgeu	a0,a5,80003800 <__memmove+0x1c>
    800038fc:	02069613          	slli	a2,a3,0x20
    80003900:	02065613          	srli	a2,a2,0x20
    80003904:	fff64613          	not	a2,a2
    80003908:	00e50733          	add	a4,a0,a4
    8000390c:	00c78633          	add	a2,a5,a2
    80003910:	fff7c683          	lbu	a3,-1(a5)
    80003914:	fff78793          	addi	a5,a5,-1
    80003918:	fff70713          	addi	a4,a4,-1
    8000391c:	00d70023          	sb	a3,0(a4)
    80003920:	fec798e3          	bne	a5,a2,80003910 <__memmove+0x12c>
    80003924:	00813403          	ld	s0,8(sp)
    80003928:	01010113          	addi	sp,sp,16
    8000392c:	00008067          	ret
    80003930:	02069713          	slli	a4,a3,0x20
    80003934:	02075713          	srli	a4,a4,0x20
    80003938:	00170713          	addi	a4,a4,1
    8000393c:	00e50733          	add	a4,a0,a4
    80003940:	00050793          	mv	a5,a0
    80003944:	0005c683          	lbu	a3,0(a1)
    80003948:	00178793          	addi	a5,a5,1
    8000394c:	00158593          	addi	a1,a1,1
    80003950:	fed78fa3          	sb	a3,-1(a5)
    80003954:	fee798e3          	bne	a5,a4,80003944 <__memmove+0x160>
    80003958:	f89ff06f          	j	800038e0 <__memmove+0xfc>

000000008000395c <__putc>:
    8000395c:	fe010113          	addi	sp,sp,-32
    80003960:	00813823          	sd	s0,16(sp)
    80003964:	00113c23          	sd	ra,24(sp)
    80003968:	02010413          	addi	s0,sp,32
    8000396c:	00050793          	mv	a5,a0
    80003970:	fef40593          	addi	a1,s0,-17
    80003974:	00100613          	li	a2,1
    80003978:	00000513          	li	a0,0
    8000397c:	fef407a3          	sb	a5,-17(s0)
    80003980:	fffff097          	auipc	ra,0xfffff
    80003984:	b3c080e7          	jalr	-1220(ra) # 800024bc <console_write>
    80003988:	01813083          	ld	ra,24(sp)
    8000398c:	01013403          	ld	s0,16(sp)
    80003990:	02010113          	addi	sp,sp,32
    80003994:	00008067          	ret

0000000080003998 <__getc>:
    80003998:	fe010113          	addi	sp,sp,-32
    8000399c:	00813823          	sd	s0,16(sp)
    800039a0:	00113c23          	sd	ra,24(sp)
    800039a4:	02010413          	addi	s0,sp,32
    800039a8:	fe840593          	addi	a1,s0,-24
    800039ac:	00100613          	li	a2,1
    800039b0:	00000513          	li	a0,0
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	ae8080e7          	jalr	-1304(ra) # 8000249c <console_read>
    800039bc:	fe844503          	lbu	a0,-24(s0)
    800039c0:	01813083          	ld	ra,24(sp)
    800039c4:	01013403          	ld	s0,16(sp)
    800039c8:	02010113          	addi	sp,sp,32
    800039cc:	00008067          	ret

00000000800039d0 <console_handler>:
    800039d0:	fe010113          	addi	sp,sp,-32
    800039d4:	00813823          	sd	s0,16(sp)
    800039d8:	00113c23          	sd	ra,24(sp)
    800039dc:	00913423          	sd	s1,8(sp)
    800039e0:	02010413          	addi	s0,sp,32
    800039e4:	14202773          	csrr	a4,scause
    800039e8:	100027f3          	csrr	a5,sstatus
    800039ec:	0027f793          	andi	a5,a5,2
    800039f0:	06079e63          	bnez	a5,80003a6c <console_handler+0x9c>
    800039f4:	00074c63          	bltz	a4,80003a0c <console_handler+0x3c>
    800039f8:	01813083          	ld	ra,24(sp)
    800039fc:	01013403          	ld	s0,16(sp)
    80003a00:	00813483          	ld	s1,8(sp)
    80003a04:	02010113          	addi	sp,sp,32
    80003a08:	00008067          	ret
    80003a0c:	0ff77713          	andi	a4,a4,255
    80003a10:	00900793          	li	a5,9
    80003a14:	fef712e3          	bne	a4,a5,800039f8 <console_handler+0x28>
    80003a18:	ffffe097          	auipc	ra,0xffffe
    80003a1c:	6dc080e7          	jalr	1756(ra) # 800020f4 <plic_claim>
    80003a20:	00a00793          	li	a5,10
    80003a24:	00050493          	mv	s1,a0
    80003a28:	02f50c63          	beq	a0,a5,80003a60 <console_handler+0x90>
    80003a2c:	fc0506e3          	beqz	a0,800039f8 <console_handler+0x28>
    80003a30:	00050593          	mv	a1,a0
    80003a34:	00000517          	auipc	a0,0x0
    80003a38:	6cc50513          	addi	a0,a0,1740 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80003a3c:	fffff097          	auipc	ra,0xfffff
    80003a40:	afc080e7          	jalr	-1284(ra) # 80002538 <__printf>
    80003a44:	01013403          	ld	s0,16(sp)
    80003a48:	01813083          	ld	ra,24(sp)
    80003a4c:	00048513          	mv	a0,s1
    80003a50:	00813483          	ld	s1,8(sp)
    80003a54:	02010113          	addi	sp,sp,32
    80003a58:	ffffe317          	auipc	t1,0xffffe
    80003a5c:	6d430067          	jr	1748(t1) # 8000212c <plic_complete>
    80003a60:	fffff097          	auipc	ra,0xfffff
    80003a64:	3e0080e7          	jalr	992(ra) # 80002e40 <uartintr>
    80003a68:	fddff06f          	j	80003a44 <console_handler+0x74>
    80003a6c:	00000517          	auipc	a0,0x0
    80003a70:	79450513          	addi	a0,a0,1940 # 80004200 <digits+0x78>
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	a68080e7          	jalr	-1432(ra) # 800024dc <panic>
	...
