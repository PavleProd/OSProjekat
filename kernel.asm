
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	62813103          	ld	sp,1576(sp) # 80004628 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	37d010ef          	jal	ra,80001b98 <start>

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
    80001080:	1d8000ef          	jal	ra,80001258 <interruptHandler>
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
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001124:	00313c23          	sd	gp,24(sp)
    80001128:	02413023          	sd	tp,32(sp)
    8000112c:	02513423          	sd	t0,40(sp)
    80001130:	02613823          	sd	t1,48(sp)
    80001134:	02713c23          	sd	t2,56(sp)
    80001138:	04813023          	sd	s0,64(sp)
    8000113c:	04913423          	sd	s1,72(sp)
    80001140:	04a13823          	sd	a0,80(sp)
    80001144:	04b13c23          	sd	a1,88(sp)
    80001148:	06c13023          	sd	a2,96(sp)
    8000114c:	06d13423          	sd	a3,104(sp)
    80001150:	06e13823          	sd	a4,112(sp)
    80001154:	06f13c23          	sd	a5,120(sp)
    80001158:	09013023          	sd	a6,128(sp)
    8000115c:	09113423          	sd	a7,136(sp)
    80001160:	09213823          	sd	s2,144(sp)
    80001164:	09313c23          	sd	s3,152(sp)
    80001168:	0b413023          	sd	s4,160(sp)
    8000116c:	0b513423          	sd	s5,168(sp)
    80001170:	0b613823          	sd	s6,176(sp)
    80001174:	0b713c23          	sd	s7,184(sp)
    80001178:	0d813023          	sd	s8,192(sp)
    8000117c:	0d913423          	sd	s9,200(sp)
    80001180:	0da13823          	sd	s10,208(sp)
    80001184:	0db13c23          	sd	s11,216(sp)
    80001188:	0fc13023          	sd	t3,224(sp)
    8000118c:	0fd13423          	sd	t4,232(sp)
    80001190:	0fe13823          	sd	t5,240(sp)
    80001194:	0ff13c23          	sd	t6,248(sp)
    ret
    80001198:	00008067          	ret

000000008000119c <popRegisters>:
.global popRegisters
popRegisters:
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    8000119c:	01813183          	ld	gp,24(sp)
    800011a0:	02013203          	ld	tp,32(sp)
    800011a4:	02813283          	ld	t0,40(sp)
    800011a8:	03013303          	ld	t1,48(sp)
    800011ac:	03813383          	ld	t2,56(sp)
    800011b0:	04013403          	ld	s0,64(sp)
    800011b4:	04813483          	ld	s1,72(sp)
    800011b8:	05013503          	ld	a0,80(sp)
    800011bc:	05813583          	ld	a1,88(sp)
    800011c0:	06013603          	ld	a2,96(sp)
    800011c4:	06813683          	ld	a3,104(sp)
    800011c8:	07013703          	ld	a4,112(sp)
    800011cc:	07813783          	ld	a5,120(sp)
    800011d0:	08013803          	ld	a6,128(sp)
    800011d4:	08813883          	ld	a7,136(sp)
    800011d8:	09013903          	ld	s2,144(sp)
    800011dc:	09813983          	ld	s3,152(sp)
    800011e0:	0a013a03          	ld	s4,160(sp)
    800011e4:	0a813a83          	ld	s5,168(sp)
    800011e8:	0b013b03          	ld	s6,176(sp)
    800011ec:	0b813b83          	ld	s7,184(sp)
    800011f0:	0c013c03          	ld	s8,192(sp)
    800011f4:	0c813c83          	ld	s9,200(sp)
    800011f8:	0d013d03          	ld	s10,208(sp)
    800011fc:	0d813d83          	ld	s11,216(sp)
    80001200:	0e013e03          	ld	t3,224(sp)
    80001204:	0e813e83          	ld	t4,232(sp)
    80001208:	0f013f03          	ld	t5,240(sp)
    8000120c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001210:	10010113          	addi	sp,sp,256
    ret
    80001214:	00008067          	ret

0000000080001218 <_ZN3PCB13switchContextEPNS_7ContextES1_>:

.global _ZN3PCB13switchContextEPNS_7ContextES1_
_ZN3PCB13switchContextEPNS_7ContextES1_:
    // a0 - &old->context
    // a1 - &running->context
    sd ra, 0 * 8(a0)
    80001218:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    8000121c:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001220:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001224:	0085b103          	ld	sp,8(a1)

    ret
    80001228:	00008067          	ret

000000008000122c <_Z13callInterruptv>:
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    8000122c:	ff010113          	addi	sp,sp,-16
    80001230:	00813423          	sd	s0,8(sp)
    80001234:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("csrw stvec, %0" : : "r" (&interrupt)); // ovo treba uraditi na pocetku programa
    80001238:	00003797          	auipc	a5,0x3
    8000123c:	4007b783          	ld	a5,1024(a5) # 80004638 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001240:	10579073          	csrw	stvec,a5
    asm volatile("ecall");
    80001244:	00000073          	ecall

    asm volatile("mv %0, a0" : "=r" (res));
    80001248:	00050513          	mv	a0,a0
    return res;
}
    8000124c:	00813403          	ld	s0,8(sp)
    80001250:	01010113          	addi	sp,sp,16
    80001254:	00008067          	ret

0000000080001258 <interruptHandler>:

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    80001258:	142027f3          	csrr	a5,scause
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    8000125c:	ff878793          	addi	a5,a5,-8
    80001260:	00100713          	li	a4,1
    80001264:	04f76e63          	bltu	a4,a5,800012c0 <interruptHandler+0x68>
extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001268:	ff010113          	addi	sp,sp,-16
    8000126c:	00113423          	sd	ra,8(sp)
    80001270:	00813023          	sd	s0,0(sp)
    80001274:	01010413          	addi	s0,sp,16
        uint64 code;
        asm volatile("mv %0, a0" : "=r" (code));
    80001278:	00050793          	mv	a5,a0
        switch(code) {
    8000127c:	02e78063          	beq	a5,a4,8000129c <interruptHandler+0x44>
    80001280:	00200713          	li	a4,2
    80001284:	02e78663          	beq	a5,a4,800012b0 <interruptHandler+0x58>
    80001288:	00000513          	li	a0,0
                return nullptr;
        }
    }

    return nullptr;
}
    8000128c:	00813083          	ld	ra,8(sp)
    80001290:	00013403          	ld	s0,0(sp)
    80001294:	01010113          	addi	sp,sp,16
    80001298:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (size));
    8000129c:	00058513          	mv	a0,a1
                return MemoryAllocator::mem_alloc(size);
    800012a0:	00651513          	slli	a0,a0,0x6
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	510080e7          	jalr	1296(ra) # 800017b4 <_ZN15MemoryAllocator9mem_allocEm>
    800012ac:	fe1ff06f          	j	8000128c <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    800012b0:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    800012b4:	00000097          	auipc	ra,0x0
    800012b8:	664080e7          	jalr	1636(ra) # 80001918 <_ZN15MemoryAllocator8mem_freeEPv>
    800012bc:	fd1ff06f          	j	8000128c <interruptHandler+0x34>
    return nullptr;
    800012c0:	00000513          	li	a0,0
}
    800012c4:	00008067          	ret

00000000800012c8 <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    800012c8:	ff010113          	addi	sp,sp,-16
    800012cc:	00113423          	sd	ra,8(sp)
    800012d0:	00813023          	sd	s0,0(sp)
    800012d4:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800012d8:	00655793          	srli	a5,a0,0x6
    800012dc:	03f57513          	andi	a0,a0,63
    800012e0:	00a03533          	snez	a0,a0
    800012e4:	00a78533          	add	a0,a5,a0
    uint64 code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800012e8:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    800012ec:	00100793          	li	a5,1
    800012f0:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    800012f4:	00000097          	auipc	ra,0x0
    800012f8:	f38080e7          	jalr	-200(ra) # 8000122c <_Z13callInterruptv>
}
    800012fc:	00813083          	ld	ra,8(sp)
    80001300:	00013403          	ld	s0,0(sp)
    80001304:	01010113          	addi	sp,sp,16
    80001308:	00008067          	ret

000000008000130c <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    8000130c:	ff010113          	addi	sp,sp,-16
    80001310:	00113423          	sd	ra,8(sp)
    80001314:	00813023          	sd	s0,0(sp)
    80001318:	01010413          	addi	s0,sp,16
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    8000131c:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001320:	00200793          	li	a5,2
    80001324:	00078513          	mv	a0,a5

    return (uint64)(callInterrupt());
    80001328:	00000097          	auipc	ra,0x0
    8000132c:	f04080e7          	jalr	-252(ra) # 8000122c <_Z13callInterruptv>
}
    80001330:	0005051b          	sext.w	a0,a0
    80001334:	00813083          	ld	ra,8(sp)
    80001338:	00013403          	ld	s0,0(sp)
    8000133c:	01010113          	addi	sp,sp,16
    80001340:	00008067          	ret

0000000080001344 <_ZN3PCB14createProccessEPFvvE>:
#include "../h/changeContext.h"
#include "../h/Scheduler.h"

PCB* PCB::running = nullptr;

PCB *PCB::createProccess(PCB::processMain main) {
    80001344:	ff010113          	addi	sp,sp,-16
    80001348:	00813423          	sd	s0,8(sp)
    8000134c:	01010413          	addi	s0,sp,16
    return nullptr;
}
    80001350:	00000513          	li	a0,0
    80001354:	00813403          	ld	s0,8(sp)
    80001358:	01010113          	addi	sp,sp,16
    8000135c:	00008067          	ret

0000000080001360 <_ZN3PCB8dispatchEv>:
    pushRegisters();
    dispatch();
    popRegisters();
}

void PCB::dispatch() {
    80001360:	fe010113          	addi	sp,sp,-32
    80001364:	00113c23          	sd	ra,24(sp)
    80001368:	00813823          	sd	s0,16(sp)
    8000136c:	00913423          	sd	s1,8(sp)
    80001370:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001374:	00003497          	auipc	s1,0x3
    80001378:	30c4b483          	ld	s1,780(s1) # 80004680 <_ZN3PCB7runningE>
class PCB {
friend class Scheduler;
public:
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    8000137c:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()) {
    80001380:	02078c63          	beqz	a5,800013b8 <_ZN3PCB8dispatchEv+0x58>
        Scheduler::put(old);
    }
    running = Scheduler::get();
    80001384:	00000097          	auipc	ra,0x0
    80001388:	17c080e7          	jalr	380(ra) # 80001500 <_ZN9Scheduler3getEv>
    8000138c:	00003797          	auipc	a5,0x3
    80001390:	2ea7ba23          	sd	a0,756(a5) # 80004680 <_ZN3PCB7runningE>

    switchContext(&old->context, &running->context);
    80001394:	01050593          	addi	a1,a0,16
    80001398:	01048513          	addi	a0,s1,16
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	e7c080e7          	jalr	-388(ra) # 80001218 <_ZN3PCB13switchContextEPNS_7ContextES1_>
}
    800013a4:	01813083          	ld	ra,24(sp)
    800013a8:	01013403          	ld	s0,16(sp)
    800013ac:	00813483          	ld	s1,8(sp)
    800013b0:	02010113          	addi	sp,sp,32
    800013b4:	00008067          	ret
        Scheduler::put(old);
    800013b8:	00048513          	mv	a0,s1
    800013bc:	00000097          	auipc	ra,0x0
    800013c0:	104080e7          	jalr	260(ra) # 800014c0 <_ZN9Scheduler3putEP3PCB>
    800013c4:	fc1ff06f          	j	80001384 <_ZN3PCB8dispatchEv+0x24>

00000000800013c8 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    800013c8:	ff010113          	addi	sp,sp,-16
    800013cc:	00113423          	sd	ra,8(sp)
    800013d0:	00813023          	sd	s0,0(sp)
    800013d4:	01010413          	addi	s0,sp,16
    pushRegisters();
    800013d8:	00000097          	auipc	ra,0x0
    800013dc:	d48080e7          	jalr	-696(ra) # 80001120 <pushRegisters>
    dispatch();
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	f80080e7          	jalr	-128(ra) # 80001360 <_ZN3PCB8dispatchEv>
    popRegisters();
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	db4080e7          	jalr	-588(ra) # 8000119c <popRegisters>
}
    800013f0:	00813083          	ld	ra,8(sp)
    800013f4:	00013403          	ld	s0,0(sp)
    800013f8:	01010113          	addi	sp,sp,16
    800013fc:	00008067          	ret

0000000080001400 <_ZN3PCBC1EPFvvE>:

// main == nullptr ako smo u glavnom procesu
PCB::PCB(PCB::processMain main_)
    80001400:	fe010113          	addi	sp,sp,-32
    80001404:	00113c23          	sd	ra,24(sp)
    80001408:	00813823          	sd	s0,16(sp)
    8000140c:	00913423          	sd	s1,8(sp)
    80001410:	01213023          	sd	s2,0(sp)
    80001414:	02010413          	addi	s0,sp,32
    80001418:	00050493          	mv	s1,a0
    8000141c:	00058913          	mv	s2,a1
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
context({(size_t)main_, stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    80001420:	00053023          	sd	zero,0(a0)
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
    80001424:	04058c63          	beqz	a1,8000147c <_ZN3PCBC1EPFvvE+0x7c>
    80001428:	00008537          	lui	a0,0x8
    8000142c:	00000097          	auipc	ra,0x0
    80001430:	310080e7          	jalr	784(ra) # 8000173c <_Znam>
context({(size_t)main_, stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    80001434:	00a4b423          	sd	a0,8(s1)
    80001438:	0124b823          	sd	s2,16(s1)
    8000143c:	04050463          	beqz	a0,80001484 <_ZN3PCBC1EPFvvE+0x84>
    80001440:	000087b7          	lui	a5,0x8
    80001444:	00f50533          	add	a0,a0,a5
    80001448:	00a4bc23          	sd	a0,24(s1)
    finished = false;
    8000144c:	02048423          	sb	zero,40(s1)
    main = main_;
    80001450:	0324b023          	sd	s2,32(s1)
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    80001454:	00090863          	beqz	s2,80001464 <_ZN3PCBC1EPFvvE+0x64>
    80001458:	00048513          	mv	a0,s1
    8000145c:	00000097          	auipc	ra,0x0
    80001460:	064080e7          	jalr	100(ra) # 800014c0 <_ZN9Scheduler3putEP3PCB>
}
    80001464:	01813083          	ld	ra,24(sp)
    80001468:	01013403          	ld	s0,16(sp)
    8000146c:	00813483          	ld	s1,8(sp)
    80001470:	00013903          	ld	s2,0(sp)
    80001474:	02010113          	addi	sp,sp,32
    80001478:	00008067          	ret
: stack(main_ != nullptr ? new size_t[DEFAULT_STACK_SIZE] : nullptr),
    8000147c:	00000513          	li	a0,0
    80001480:	fb5ff06f          	j	80001434 <_ZN3PCBC1EPFvvE+0x34>
context({(size_t)main_, stack != nullptr ? (size_t)&stack[DEFAULT_STACK_SIZE] : 0}) {
    80001484:	00000513          	li	a0,0
    80001488:	fc1ff06f          	j	80001448 <_ZN3PCBC1EPFvvE+0x48>

000000008000148c <_ZN3PCBD1Ev>:

PCB::~PCB() {
    delete[] stack;
    8000148c:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001490:	02050663          	beqz	a0,800014bc <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    80001494:	ff010113          	addi	sp,sp,-16
    80001498:	00113423          	sd	ra,8(sp)
    8000149c:	00813023          	sd	s0,0(sp)
    800014a0:	01010413          	addi	s0,sp,16
    delete[] stack;
    800014a4:	00000097          	auipc	ra,0x0
    800014a8:	2e8080e7          	jalr	744(ra) # 8000178c <_ZdaPv>
}
    800014ac:	00813083          	ld	ra,8(sp)
    800014b0:	00013403          	ld	s0,0(sp)
    800014b4:	01010113          	addi	sp,sp,16
    800014b8:	00008067          	ret
    800014bc:	00008067          	ret

00000000800014c0 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800014c0:	ff010113          	addi	sp,sp,-16
    800014c4:	00813423          	sd	s0,8(sp)
    800014c8:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    800014cc:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800014d0:	00003797          	auipc	a5,0x3
    800014d4:	1b87b783          	ld	a5,440(a5) # 80004688 <_ZN9Scheduler4tailE>
    800014d8:	00078a63          	beqz	a5,800014ec <_ZN9Scheduler3putEP3PCB+0x2c>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    800014dc:	00a7b023          	sd	a0,0(a5)
    }
}
    800014e0:	00813403          	ld	s0,8(sp)
    800014e4:	01010113          	addi	sp,sp,16
    800014e8:	00008067          	ret
        head = tail = process;
    800014ec:	00003797          	auipc	a5,0x3
    800014f0:	19c78793          	addi	a5,a5,412 # 80004688 <_ZN9Scheduler4tailE>
    800014f4:	00a7b023          	sd	a0,0(a5)
    800014f8:	00a7b423          	sd	a0,8(a5)
    800014fc:	fe5ff06f          	j	800014e0 <_ZN9Scheduler3putEP3PCB+0x20>

0000000080001500 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001500:	ff010113          	addi	sp,sp,-16
    80001504:	00813423          	sd	s0,8(sp)
    80001508:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    8000150c:	00003517          	auipc	a0,0x3
    80001510:	18453503          	ld	a0,388(a0) # 80004690 <_ZN9Scheduler4headE>
    80001514:	02050463          	beqz	a0,8000153c <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    80001518:	00053703          	ld	a4,0(a0)
    8000151c:	00003797          	auipc	a5,0x3
    80001520:	16c78793          	addi	a5,a5,364 # 80004688 <_ZN9Scheduler4tailE>
    80001524:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001528:	0007b783          	ld	a5,0(a5)
    8000152c:	00f50e63          	beq	a0,a5,80001548 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001530:	00813403          	ld	s0,8(sp)
    80001534:	01010113          	addi	sp,sp,16
    80001538:	00008067          	ret
        return idleProcess;
    8000153c:	00003517          	auipc	a0,0x3
    80001540:	15c53503          	ld	a0,348(a0) # 80004698 <_ZN9Scheduler11idleProcessE>
    80001544:	fedff06f          	j	80001530 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001548:	00003797          	auipc	a5,0x3
    8000154c:	14e7b023          	sd	a4,320(a5) # 80004688 <_ZN9Scheduler4tailE>
    80001550:	fe1ff06f          	j	80001530 <_ZN9Scheduler3getEv+0x30>

0000000080001554 <_Z12checkNullptrPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    80001554:	00050e63          	beqz	a0,80001570 <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80001558:	00003717          	auipc	a4,0x3
    8000155c:	14870713          	addi	a4,a4,328 # 800046a0 <_ZZ12checkNullptrPvE1x>
    80001560:	00072783          	lw	a5,0(a4)
    80001564:	0017879b          	addiw	a5,a5,1
    80001568:	00f72023          	sw	a5,0(a4)
    8000156c:	00008067          	ret
void checkNullptr(void* p) {
    80001570:	ff010113          	addi	sp,sp,-16
    80001574:	00113423          	sd	ra,8(sp)
    80001578:	00813023          	sd	s0,0(sp)
    8000157c:	01010413          	addi	s0,sp,16
        __putc('?');
    80001580:	03f00513          	li	a0,63
    80001584:	00002097          	auipc	ra,0x2
    80001588:	6d8080e7          	jalr	1752(ra) # 80003c5c <__putc>
        __putc('0' + x);
    8000158c:	00003517          	auipc	a0,0x3
    80001590:	11452503          	lw	a0,276(a0) # 800046a0 <_ZZ12checkNullptrPvE1x>
    80001594:	0305051b          	addiw	a0,a0,48
    80001598:	0ff57513          	andi	a0,a0,255
    8000159c:	00002097          	auipc	ra,0x2
    800015a0:	6c0080e7          	jalr	1728(ra) # 80003c5c <__putc>
    x++;
    800015a4:	00003717          	auipc	a4,0x3
    800015a8:	0fc70713          	addi	a4,a4,252 # 800046a0 <_ZZ12checkNullptrPvE1x>
    800015ac:	00072783          	lw	a5,0(a4)
    800015b0:	0017879b          	addiw	a5,a5,1
    800015b4:	00f72023          	sw	a5,0(a4)
}
    800015b8:	00813083          	ld	ra,8(sp)
    800015bc:	00013403          	ld	s0,0(sp)
    800015c0:	01010113          	addi	sp,sp,16
    800015c4:	00008067          	ret

00000000800015c8 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    800015c8:	00051e63          	bnez	a0,800015e4 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    800015cc:	00003717          	auipc	a4,0x3
    800015d0:	0d470713          	addi	a4,a4,212 # 800046a0 <_ZZ12checkNullptrPvE1x>
    800015d4:	00472783          	lw	a5,4(a4)
    800015d8:	0017879b          	addiw	a5,a5,1
    800015dc:	00f72223          	sw	a5,4(a4)
    800015e0:	00008067          	ret
void checkStatus(int status) {
    800015e4:	ff010113          	addi	sp,sp,-16
    800015e8:	00113423          	sd	ra,8(sp)
    800015ec:	00813023          	sd	s0,0(sp)
    800015f0:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    800015f4:	00003517          	auipc	a0,0x3
    800015f8:	0b052503          	lw	a0,176(a0) # 800046a4 <_ZZ11checkStatusiE1y>
    800015fc:	0305051b          	addiw	a0,a0,48
    80001600:	0ff57513          	andi	a0,a0,255
    80001604:	00002097          	auipc	ra,0x2
    80001608:	658080e7          	jalr	1624(ra) # 80003c5c <__putc>
        __putc('?');
    8000160c:	03f00513          	li	a0,63
    80001610:	00002097          	auipc	ra,0x2
    80001614:	64c080e7          	jalr	1612(ra) # 80003c5c <__putc>
    y++;
    80001618:	00003717          	auipc	a4,0x3
    8000161c:	08870713          	addi	a4,a4,136 # 800046a0 <_ZZ12checkNullptrPvE1x>
    80001620:	00472783          	lw	a5,4(a4)
    80001624:	0017879b          	addiw	a5,a5,1
    80001628:	00f72223          	sw	a5,4(a4)
}
    8000162c:	00813083          	ld	ra,8(sp)
    80001630:	00013403          	ld	s0,0(sp)
    80001634:	01010113          	addi	sp,sp,16
    80001638:	00008067          	ret

000000008000163c <main>:

int main() {
    8000163c:	fe010113          	addi	sp,sp,-32
    80001640:	00113c23          	sd	ra,24(sp)
    80001644:	00813823          	sd	s0,16(sp)
    80001648:	00913423          	sd	s1,8(sp)
    8000164c:	02010413          	addi	s0,sp,32
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    80001650:	00003797          	auipc	a5,0x3
    80001654:	fe07b783          	ld	a5,-32(a5) # 80004630 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001658:	0007b503          	ld	a0,0(a5)
    8000165c:	00003797          	auipc	a5,0x3
    80001660:	fc47b783          	ld	a5,-60(a5) # 80004620 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001664:	0007b783          	ld	a5,0(a5)
    80001668:	40f50533          	sub	a0,a0,a5
    8000166c:	ff850513          	addi	a0,a0,-8
    80001670:	00655513          	srli	a0,a0,0x6
    80001674:	fff50513          	addi	a0,a0,-1
    char* niz = (char*)mem_alloc(celaMemorija); // celokupan prostor
    80001678:	00651513          	slli	a0,a0,0x6
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	c4c080e7          	jalr	-948(ra) # 800012c8 <_Z9mem_allocm>
    80001684:	00050493          	mv	s1,a0
    if(niz == nullptr) {
    80001688:	04050663          	beqz	a0,800016d4 <main+0x98>
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    8000168c:	00a00513          	li	a0,10
    80001690:	00000097          	auipc	ra,0x0
    80001694:	c38080e7          	jalr	-968(ra) # 800012c8 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    80001698:	04050663          	beqz	a0,800016e4 <main+0xa8>
        __putc('k');
    }

    int status = mem_free(niz);
    8000169c:	00048513          	mv	a0,s1
    800016a0:	00000097          	auipc	ra,0x0
    800016a4:	c6c080e7          	jalr	-916(ra) # 8000130c <_Z8mem_freePv>
    if(status) {
    800016a8:	04051663          	bnez	a0,800016f4 <main+0xb8>
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    800016ac:	00a00513          	li	a0,10
    800016b0:	00000097          	auipc	ra,0x0
    800016b4:	c18080e7          	jalr	-1000(ra) # 800012c8 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    800016b8:	04050663          	beqz	a0,80001704 <main+0xc8>
        __putc('?');
    }

    return 0;
}
    800016bc:	00000513          	li	a0,0
    800016c0:	01813083          	ld	ra,24(sp)
    800016c4:	01013403          	ld	s0,16(sp)
    800016c8:	00813483          	ld	s1,8(sp)
    800016cc:	02010113          	addi	sp,sp,32
    800016d0:	00008067          	ret
        __putc('?');
    800016d4:	03f00513          	li	a0,63
    800016d8:	00002097          	auipc	ra,0x2
    800016dc:	584080e7          	jalr	1412(ra) # 80003c5c <__putc>
    800016e0:	fadff06f          	j	8000168c <main+0x50>
        __putc('k');
    800016e4:	06b00513          	li	a0,107
    800016e8:	00002097          	auipc	ra,0x2
    800016ec:	574080e7          	jalr	1396(ra) # 80003c5c <__putc>
    800016f0:	fadff06f          	j	8000169c <main+0x60>
        __putc('?');
    800016f4:	03f00513          	li	a0,63
    800016f8:	00002097          	auipc	ra,0x2
    800016fc:	564080e7          	jalr	1380(ra) # 80003c5c <__putc>
    80001700:	fadff06f          	j	800016ac <main+0x70>
        __putc('?');
    80001704:	03f00513          	li	a0,63
    80001708:	00002097          	auipc	ra,0x2
    8000170c:	554080e7          	jalr	1364(ra) # 80003c5c <__putc>
    80001710:	fadff06f          	j	800016bc <main+0x80>

0000000080001714 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001714:	ff010113          	addi	sp,sp,-16
    80001718:	00113423          	sd	ra,8(sp)
    8000171c:	00813023          	sd	s0,0(sp)
    80001720:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001724:	00000097          	auipc	ra,0x0
    80001728:	ba4080e7          	jalr	-1116(ra) # 800012c8 <_Z9mem_allocm>
}
    8000172c:	00813083          	ld	ra,8(sp)
    80001730:	00013403          	ld	s0,0(sp)
    80001734:	01010113          	addi	sp,sp,16
    80001738:	00008067          	ret

000000008000173c <_Znam>:
void* operator new [](size_t size) {
    8000173c:	ff010113          	addi	sp,sp,-16
    80001740:	00113423          	sd	ra,8(sp)
    80001744:	00813023          	sd	s0,0(sp)
    80001748:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	b7c080e7          	jalr	-1156(ra) # 800012c8 <_Z9mem_allocm>
}
    80001754:	00813083          	ld	ra,8(sp)
    80001758:	00013403          	ld	s0,0(sp)
    8000175c:	01010113          	addi	sp,sp,16
    80001760:	00008067          	ret

0000000080001764 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001764:	ff010113          	addi	sp,sp,-16
    80001768:	00113423          	sd	ra,8(sp)
    8000176c:	00813023          	sd	s0,0(sp)
    80001770:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001774:	00000097          	auipc	ra,0x0
    80001778:	b98080e7          	jalr	-1128(ra) # 8000130c <_Z8mem_freePv>
}
    8000177c:	00813083          	ld	ra,8(sp)
    80001780:	00013403          	ld	s0,0(sp)
    80001784:	01010113          	addi	sp,sp,16
    80001788:	00008067          	ret

000000008000178c <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    8000178c:	ff010113          	addi	sp,sp,-16
    80001790:	00113423          	sd	ra,8(sp)
    80001794:	00813023          	sd	s0,0(sp)
    80001798:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    8000179c:	00000097          	auipc	ra,0x0
    800017a0:	b70080e7          	jalr	-1168(ra) # 8000130c <_Z8mem_freePv>
    800017a4:	00813083          	ld	ra,8(sp)
    800017a8:	00013403          	ld	s0,0(sp)
    800017ac:	01010113          	addi	sp,sp,16
    800017b0:	00008067          	ret

00000000800017b4 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    800017b4:	ff010113          	addi	sp,sp,-16
    800017b8:	00813423          	sd	s0,8(sp)
    800017bc:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800017c0:	00003797          	auipc	a5,0x3
    800017c4:	ee87b783          	ld	a5,-280(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
    800017c8:	02078c63          	beqz	a5,80001800 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    800017cc:	00003717          	auipc	a4,0x3
    800017d0:	e6473703          	ld	a4,-412(a4) # 80004630 <_GLOBAL_OFFSET_TABLE_+0x18>
    800017d4:	00073703          	ld	a4,0(a4)
    800017d8:	12e78c63          	beq	a5,a4,80001910 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800017dc:	00850713          	addi	a4,a0,8
    800017e0:	00675813          	srli	a6,a4,0x6
    800017e4:	03f77793          	andi	a5,a4,63
    800017e8:	00f037b3          	snez	a5,a5
    800017ec:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800017f0:	00003517          	auipc	a0,0x3
    800017f4:	eb853503          	ld	a0,-328(a0) # 800046a8 <_ZN15MemoryAllocator4headE>
    800017f8:	00000613          	li	a2,0
    800017fc:	0a80006f          	j	800018a4 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001800:	00003697          	auipc	a3,0x3
    80001804:	e206b683          	ld	a3,-480(a3) # 80004620 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001808:	0006b783          	ld	a5,0(a3)
    8000180c:	00003717          	auipc	a4,0x3
    80001810:	e8f73e23          	sd	a5,-356(a4) # 800046a8 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001814:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80001818:	00003717          	auipc	a4,0x3
    8000181c:	e1873703          	ld	a4,-488(a4) # 80004630 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001820:	00073703          	ld	a4,0(a4)
    80001824:	0006b683          	ld	a3,0(a3)
    80001828:	40d70733          	sub	a4,a4,a3
    8000182c:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001830:	0007b823          	sd	zero,16(a5)
    80001834:	fa9ff06f          	j	800017dc <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001838:	00060e63          	beqz	a2,80001854 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    8000183c:	01063703          	ld	a4,16(a2)
    80001840:	04070a63          	beqz	a4,80001894 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001844:	01073703          	ld	a4,16(a4)
    80001848:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    8000184c:	00078813          	mv	a6,a5
    80001850:	0ac0006f          	j	800018fc <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001854:	01053703          	ld	a4,16(a0)
    80001858:	00070a63          	beqz	a4,8000186c <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    8000185c:	00003697          	auipc	a3,0x3
    80001860:	e4e6b623          	sd	a4,-436(a3) # 800046a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001864:	00078813          	mv	a6,a5
    80001868:	0940006f          	j	800018fc <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    8000186c:	00003717          	auipc	a4,0x3
    80001870:	dc473703          	ld	a4,-572(a4) # 80004630 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001874:	00073703          	ld	a4,0(a4)
    80001878:	00003697          	auipc	a3,0x3
    8000187c:	e2e6b823          	sd	a4,-464(a3) # 800046a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001880:	00078813          	mv	a6,a5
    80001884:	0780006f          	j	800018fc <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001888:	00003797          	auipc	a5,0x3
    8000188c:	e2e7b023          	sd	a4,-480(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
    80001890:	06c0006f          	j	800018fc <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001894:	00078813          	mv	a6,a5
    80001898:	0640006f          	j	800018fc <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    8000189c:	00050613          	mv	a2,a0
        curr = curr->next;
    800018a0:	01053503          	ld	a0,16(a0)
    while(curr) {
    800018a4:	06050063          	beqz	a0,80001904 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    800018a8:	00853783          	ld	a5,8(a0)
    800018ac:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    800018b0:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800018b4:	fee7e4e3          	bltu	a5,a4,8000189c <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    800018b8:	ff06e2e3          	bltu	a3,a6,8000189c <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800018bc:	f7068ee3          	beq	a3,a6,80001838 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    800018c0:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    800018c4:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    800018c8:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800018cc:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800018d0:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800018d4:	01053783          	ld	a5,16(a0)
    800018d8:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800018dc:	fa0606e3          	beqz	a2,80001888 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    800018e0:	01063783          	ld	a5,16(a2)
    800018e4:	00078663          	beqz	a5,800018f0 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    800018e8:	0107b783          	ld	a5,16(a5)
    800018ec:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800018f0:	01063783          	ld	a5,16(a2)
    800018f4:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800018f8:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800018fc:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001900:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001904:	00813403          	ld	s0,8(sp)
    80001908:	01010113          	addi	sp,sp,16
    8000190c:	00008067          	ret
        return nullptr;
    80001910:	00000513          	li	a0,0
    80001914:	ff1ff06f          	j	80001904 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080001918 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001918:	ff010113          	addi	sp,sp,-16
    8000191c:	00813423          	sd	s0,8(sp)
    80001920:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001924:	16050063          	beqz	a0,80001a84 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001928:	ff850713          	addi	a4,a0,-8
    8000192c:	00003797          	auipc	a5,0x3
    80001930:	cf47b783          	ld	a5,-780(a5) # 80004620 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001934:	0007b783          	ld	a5,0(a5)
    80001938:	14f76a63          	bltu	a4,a5,80001a8c <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    8000193c:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001940:	fff58693          	addi	a3,a1,-1
    80001944:	00d706b3          	add	a3,a4,a3
    80001948:	00003617          	auipc	a2,0x3
    8000194c:	ce863603          	ld	a2,-792(a2) # 80004630 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001950:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001954:	14c6f063          	bgeu	a3,a2,80001a94 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001958:	14070263          	beqz	a4,80001a9c <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    8000195c:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001960:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001964:	14079063          	bnez	a5,80001aa4 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001968:	03f00793          	li	a5,63
    8000196c:	14b7f063          	bgeu	a5,a1,80001aac <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001970:	00003797          	auipc	a5,0x3
    80001974:	d387b783          	ld	a5,-712(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
    80001978:	02f60063          	beq	a2,a5,80001998 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    8000197c:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001980:	02078a63          	beqz	a5,800019b4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001984:	0007b683          	ld	a3,0(a5)
    80001988:	02e6f663          	bgeu	a3,a4,800019b4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    8000198c:	00078613          	mv	a2,a5
        curr = curr->next;
    80001990:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001994:	fedff06f          	j	80001980 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001998:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    8000199c:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800019a0:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800019a4:	00003797          	auipc	a5,0x3
    800019a8:	d0e7b223          	sd	a4,-764(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
        return 0;
    800019ac:	00000513          	li	a0,0
    800019b0:	0480006f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    800019b4:	04060863          	beqz	a2,80001a04 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800019b8:	00063683          	ld	a3,0(a2)
    800019bc:	00863803          	ld	a6,8(a2)
    800019c0:	010686b3          	add	a3,a3,a6
    800019c4:	08e68a63          	beq	a3,a4,80001a58 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800019c8:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800019cc:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800019d0:	01063683          	ld	a3,16(a2)
    800019d4:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800019d8:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800019dc:	0e078063          	beqz	a5,80001abc <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    800019e0:	0007b583          	ld	a1,0(a5)
    800019e4:	00073683          	ld	a3,0(a4)
    800019e8:	00873603          	ld	a2,8(a4)
    800019ec:	00c686b3          	add	a3,a3,a2
    800019f0:	06d58c63          	beq	a1,a3,80001a68 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800019f4:	00000513          	li	a0,0
}
    800019f8:	00813403          	ld	s0,8(sp)
    800019fc:	01010113          	addi	sp,sp,16
    80001a00:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80001a04:	0a078863          	beqz	a5,80001ab4 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80001a08:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001a0c:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001a10:	00003797          	auipc	a5,0x3
    80001a14:	c987b783          	ld	a5,-872(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
    80001a18:	0007b603          	ld	a2,0(a5)
    80001a1c:	00b706b3          	add	a3,a4,a1
    80001a20:	00d60c63          	beq	a2,a3,80001a38 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80001a24:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001a28:	00003797          	auipc	a5,0x3
    80001a2c:	c8e7b023          	sd	a4,-896(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
            return 0;
    80001a30:	00000513          	li	a0,0
    80001a34:	fc5ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001a38:	0087b783          	ld	a5,8(a5)
    80001a3c:	00b785b3          	add	a1,a5,a1
    80001a40:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80001a44:	00003797          	auipc	a5,0x3
    80001a48:	c647b783          	ld	a5,-924(a5) # 800046a8 <_ZN15MemoryAllocator4headE>
    80001a4c:	0107b783          	ld	a5,16(a5)
    80001a50:	00f53423          	sd	a5,8(a0)
    80001a54:	fd5ff06f          	j	80001a28 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001a58:	00b805b3          	add	a1,a6,a1
    80001a5c:	00b63423          	sd	a1,8(a2)
    80001a60:	00060713          	mv	a4,a2
    80001a64:	f79ff06f          	j	800019dc <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001a68:	0087b683          	ld	a3,8(a5)
    80001a6c:	00d60633          	add	a2,a2,a3
    80001a70:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001a74:	0107b783          	ld	a5,16(a5)
    80001a78:	00f73823          	sd	a5,16(a4)
    return 0;
    80001a7c:	00000513          	li	a0,0
    80001a80:	f79ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001a84:	fff00513          	li	a0,-1
    80001a88:	f71ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001a8c:	fff00513          	li	a0,-1
    80001a90:	f69ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001a94:	fff00513          	li	a0,-1
    80001a98:	f61ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001a9c:	fff00513          	li	a0,-1
    80001aa0:	f59ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001aa4:	fff00513          	li	a0,-1
    80001aa8:	f51ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001aac:	fff00513          	li	a0,-1
    80001ab0:	f49ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001ab4:	fff00513          	li	a0,-1
    80001ab8:	f41ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001abc:	00000513          	li	a0,0
    80001ac0:	f39ff06f          	j	800019f8 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001ac4 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"

void printString(char const *string)
{
    80001ac4:	fe010113          	addi	sp,sp,-32
    80001ac8:	00113c23          	sd	ra,24(sp)
    80001acc:	00813823          	sd	s0,16(sp)
    80001ad0:	00913423          	sd	s1,8(sp)
    80001ad4:	02010413          	addi	s0,sp,32
    80001ad8:	00050493          	mv	s1,a0
    while (*string != '\0')
    80001adc:	0004c503          	lbu	a0,0(s1)
    80001ae0:	00050a63          	beqz	a0,80001af4 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    80001ae4:	00002097          	auipc	ra,0x2
    80001ae8:	178080e7          	jalr	376(ra) # 80003c5c <__putc>
        string++;
    80001aec:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001af0:	fedff06f          	j	80001adc <_Z11printStringPKc+0x18>
    }
}
    80001af4:	01813083          	ld	ra,24(sp)
    80001af8:	01013403          	ld	s0,16(sp)
    80001afc:	00813483          	ld	s1,8(sp)
    80001b00:	02010113          	addi	sp,sp,32
    80001b04:	00008067          	ret

0000000080001b08 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    80001b08:	fd010113          	addi	sp,sp,-48
    80001b0c:	02113423          	sd	ra,40(sp)
    80001b10:	02813023          	sd	s0,32(sp)
    80001b14:	00913c23          	sd	s1,24(sp)
    80001b18:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80001b1c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001b20:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001b24:	00a00613          	li	a2,10
    80001b28:	02c5773b          	remuw	a4,a0,a2
    80001b2c:	02071693          	slli	a3,a4,0x20
    80001b30:	0206d693          	srli	a3,a3,0x20
    80001b34:	00002717          	auipc	a4,0x2
    80001b38:	4ec70713          	addi	a4,a4,1260 # 80004020 <_ZZ12printIntegermE6digits>
    80001b3c:	00d70733          	add	a4,a4,a3
    80001b40:	00074703          	lbu	a4,0(a4)
    80001b44:	fe040693          	addi	a3,s0,-32
    80001b48:	009687b3          	add	a5,a3,s1
    80001b4c:	0014849b          	addiw	s1,s1,1
    80001b50:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001b54:	0005071b          	sext.w	a4,a0
    80001b58:	02c5553b          	divuw	a0,a0,a2
    80001b5c:	00900793          	li	a5,9
    80001b60:	fce7e2e3          	bltu	a5,a4,80001b24 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    80001b64:	fff4849b          	addiw	s1,s1,-1
    80001b68:	0004ce63          	bltz	s1,80001b84 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    80001b6c:	fe040793          	addi	a5,s0,-32
    80001b70:	009787b3          	add	a5,a5,s1
    80001b74:	ff07c503          	lbu	a0,-16(a5)
    80001b78:	00002097          	auipc	ra,0x2
    80001b7c:	0e4080e7          	jalr	228(ra) # 80003c5c <__putc>
    80001b80:	fe5ff06f          	j	80001b64 <_Z12printIntegerm+0x5c>
    80001b84:	02813083          	ld	ra,40(sp)
    80001b88:	02013403          	ld	s0,32(sp)
    80001b8c:	01813483          	ld	s1,24(sp)
    80001b90:	03010113          	addi	sp,sp,48
    80001b94:	00008067          	ret

0000000080001b98 <start>:
    80001b98:	ff010113          	addi	sp,sp,-16
    80001b9c:	00813423          	sd	s0,8(sp)
    80001ba0:	01010413          	addi	s0,sp,16
    80001ba4:	300027f3          	csrr	a5,mstatus
    80001ba8:	ffffe737          	lui	a4,0xffffe
    80001bac:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff8eef>
    80001bb0:	00e7f7b3          	and	a5,a5,a4
    80001bb4:	00001737          	lui	a4,0x1
    80001bb8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001bbc:	00e7e7b3          	or	a5,a5,a4
    80001bc0:	30079073          	csrw	mstatus,a5
    80001bc4:	00000797          	auipc	a5,0x0
    80001bc8:	16078793          	addi	a5,a5,352 # 80001d24 <system_main>
    80001bcc:	34179073          	csrw	mepc,a5
    80001bd0:	00000793          	li	a5,0
    80001bd4:	18079073          	csrw	satp,a5
    80001bd8:	000107b7          	lui	a5,0x10
    80001bdc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001be0:	30279073          	csrw	medeleg,a5
    80001be4:	30379073          	csrw	mideleg,a5
    80001be8:	104027f3          	csrr	a5,sie
    80001bec:	2227e793          	ori	a5,a5,546
    80001bf0:	10479073          	csrw	sie,a5
    80001bf4:	fff00793          	li	a5,-1
    80001bf8:	00a7d793          	srli	a5,a5,0xa
    80001bfc:	3b079073          	csrw	pmpaddr0,a5
    80001c00:	00f00793          	li	a5,15
    80001c04:	3a079073          	csrw	pmpcfg0,a5
    80001c08:	f14027f3          	csrr	a5,mhartid
    80001c0c:	0200c737          	lui	a4,0x200c
    80001c10:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001c14:	0007869b          	sext.w	a3,a5
    80001c18:	00269713          	slli	a4,a3,0x2
    80001c1c:	000f4637          	lui	a2,0xf4
    80001c20:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001c24:	00d70733          	add	a4,a4,a3
    80001c28:	0037979b          	slliw	a5,a5,0x3
    80001c2c:	020046b7          	lui	a3,0x2004
    80001c30:	00d787b3          	add	a5,a5,a3
    80001c34:	00c585b3          	add	a1,a1,a2
    80001c38:	00371693          	slli	a3,a4,0x3
    80001c3c:	00003717          	auipc	a4,0x3
    80001c40:	a7470713          	addi	a4,a4,-1420 # 800046b0 <timer_scratch>
    80001c44:	00b7b023          	sd	a1,0(a5)
    80001c48:	00d70733          	add	a4,a4,a3
    80001c4c:	00f73c23          	sd	a5,24(a4)
    80001c50:	02c73023          	sd	a2,32(a4)
    80001c54:	34071073          	csrw	mscratch,a4
    80001c58:	00000797          	auipc	a5,0x0
    80001c5c:	6e878793          	addi	a5,a5,1768 # 80002340 <timervec>
    80001c60:	30579073          	csrw	mtvec,a5
    80001c64:	300027f3          	csrr	a5,mstatus
    80001c68:	0087e793          	ori	a5,a5,8
    80001c6c:	30079073          	csrw	mstatus,a5
    80001c70:	304027f3          	csrr	a5,mie
    80001c74:	0807e793          	ori	a5,a5,128
    80001c78:	30479073          	csrw	mie,a5
    80001c7c:	f14027f3          	csrr	a5,mhartid
    80001c80:	0007879b          	sext.w	a5,a5
    80001c84:	00078213          	mv	tp,a5
    80001c88:	30200073          	mret
    80001c8c:	00813403          	ld	s0,8(sp)
    80001c90:	01010113          	addi	sp,sp,16
    80001c94:	00008067          	ret

0000000080001c98 <timerinit>:
    80001c98:	ff010113          	addi	sp,sp,-16
    80001c9c:	00813423          	sd	s0,8(sp)
    80001ca0:	01010413          	addi	s0,sp,16
    80001ca4:	f14027f3          	csrr	a5,mhartid
    80001ca8:	0200c737          	lui	a4,0x200c
    80001cac:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001cb0:	0007869b          	sext.w	a3,a5
    80001cb4:	00269713          	slli	a4,a3,0x2
    80001cb8:	000f4637          	lui	a2,0xf4
    80001cbc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001cc0:	00d70733          	add	a4,a4,a3
    80001cc4:	0037979b          	slliw	a5,a5,0x3
    80001cc8:	020046b7          	lui	a3,0x2004
    80001ccc:	00d787b3          	add	a5,a5,a3
    80001cd0:	00c585b3          	add	a1,a1,a2
    80001cd4:	00371693          	slli	a3,a4,0x3
    80001cd8:	00003717          	auipc	a4,0x3
    80001cdc:	9d870713          	addi	a4,a4,-1576 # 800046b0 <timer_scratch>
    80001ce0:	00b7b023          	sd	a1,0(a5)
    80001ce4:	00d70733          	add	a4,a4,a3
    80001ce8:	00f73c23          	sd	a5,24(a4)
    80001cec:	02c73023          	sd	a2,32(a4)
    80001cf0:	34071073          	csrw	mscratch,a4
    80001cf4:	00000797          	auipc	a5,0x0
    80001cf8:	64c78793          	addi	a5,a5,1612 # 80002340 <timervec>
    80001cfc:	30579073          	csrw	mtvec,a5
    80001d00:	300027f3          	csrr	a5,mstatus
    80001d04:	0087e793          	ori	a5,a5,8
    80001d08:	30079073          	csrw	mstatus,a5
    80001d0c:	304027f3          	csrr	a5,mie
    80001d10:	0807e793          	ori	a5,a5,128
    80001d14:	30479073          	csrw	mie,a5
    80001d18:	00813403          	ld	s0,8(sp)
    80001d1c:	01010113          	addi	sp,sp,16
    80001d20:	00008067          	ret

0000000080001d24 <system_main>:
    80001d24:	fe010113          	addi	sp,sp,-32
    80001d28:	00813823          	sd	s0,16(sp)
    80001d2c:	00913423          	sd	s1,8(sp)
    80001d30:	00113c23          	sd	ra,24(sp)
    80001d34:	02010413          	addi	s0,sp,32
    80001d38:	00000097          	auipc	ra,0x0
    80001d3c:	0c4080e7          	jalr	196(ra) # 80001dfc <cpuid>
    80001d40:	00003497          	auipc	s1,0x3
    80001d44:	91048493          	addi	s1,s1,-1776 # 80004650 <started>
    80001d48:	02050263          	beqz	a0,80001d6c <system_main+0x48>
    80001d4c:	0004a783          	lw	a5,0(s1)
    80001d50:	0007879b          	sext.w	a5,a5
    80001d54:	fe078ce3          	beqz	a5,80001d4c <system_main+0x28>
    80001d58:	0ff0000f          	fence
    80001d5c:	00002517          	auipc	a0,0x2
    80001d60:	30450513          	addi	a0,a0,772 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    80001d64:	00001097          	auipc	ra,0x1
    80001d68:	a78080e7          	jalr	-1416(ra) # 800027dc <panic>
    80001d6c:	00001097          	auipc	ra,0x1
    80001d70:	9cc080e7          	jalr	-1588(ra) # 80002738 <consoleinit>
    80001d74:	00001097          	auipc	ra,0x1
    80001d78:	158080e7          	jalr	344(ra) # 80002ecc <printfinit>
    80001d7c:	00002517          	auipc	a0,0x2
    80001d80:	3c450513          	addi	a0,a0,964 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001d84:	00001097          	auipc	ra,0x1
    80001d88:	ab4080e7          	jalr	-1356(ra) # 80002838 <__printf>
    80001d8c:	00002517          	auipc	a0,0x2
    80001d90:	2a450513          	addi	a0,a0,676 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    80001d94:	00001097          	auipc	ra,0x1
    80001d98:	aa4080e7          	jalr	-1372(ra) # 80002838 <__printf>
    80001d9c:	00002517          	auipc	a0,0x2
    80001da0:	3a450513          	addi	a0,a0,932 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001da4:	00001097          	auipc	ra,0x1
    80001da8:	a94080e7          	jalr	-1388(ra) # 80002838 <__printf>
    80001dac:	00001097          	auipc	ra,0x1
    80001db0:	4ac080e7          	jalr	1196(ra) # 80003258 <kinit>
    80001db4:	00000097          	auipc	ra,0x0
    80001db8:	148080e7          	jalr	328(ra) # 80001efc <trapinit>
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	16c080e7          	jalr	364(ra) # 80001f28 <trapinithart>
    80001dc4:	00000097          	auipc	ra,0x0
    80001dc8:	5bc080e7          	jalr	1468(ra) # 80002380 <plicinit>
    80001dcc:	00000097          	auipc	ra,0x0
    80001dd0:	5dc080e7          	jalr	1500(ra) # 800023a8 <plicinithart>
    80001dd4:	00000097          	auipc	ra,0x0
    80001dd8:	078080e7          	jalr	120(ra) # 80001e4c <userinit>
    80001ddc:	0ff0000f          	fence
    80001de0:	00100793          	li	a5,1
    80001de4:	00002517          	auipc	a0,0x2
    80001de8:	26450513          	addi	a0,a0,612 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    80001dec:	00f4a023          	sw	a5,0(s1)
    80001df0:	00001097          	auipc	ra,0x1
    80001df4:	a48080e7          	jalr	-1464(ra) # 80002838 <__printf>
    80001df8:	0000006f          	j	80001df8 <system_main+0xd4>

0000000080001dfc <cpuid>:
    80001dfc:	ff010113          	addi	sp,sp,-16
    80001e00:	00813423          	sd	s0,8(sp)
    80001e04:	01010413          	addi	s0,sp,16
    80001e08:	00020513          	mv	a0,tp
    80001e0c:	00813403          	ld	s0,8(sp)
    80001e10:	0005051b          	sext.w	a0,a0
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00008067          	ret

0000000080001e1c <mycpu>:
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00813423          	sd	s0,8(sp)
    80001e24:	01010413          	addi	s0,sp,16
    80001e28:	00020793          	mv	a5,tp
    80001e2c:	00813403          	ld	s0,8(sp)
    80001e30:	0007879b          	sext.w	a5,a5
    80001e34:	00779793          	slli	a5,a5,0x7
    80001e38:	00004517          	auipc	a0,0x4
    80001e3c:	8a850513          	addi	a0,a0,-1880 # 800056e0 <cpus>
    80001e40:	00f50533          	add	a0,a0,a5
    80001e44:	01010113          	addi	sp,sp,16
    80001e48:	00008067          	ret

0000000080001e4c <userinit>:
    80001e4c:	ff010113          	addi	sp,sp,-16
    80001e50:	00813423          	sd	s0,8(sp)
    80001e54:	01010413          	addi	s0,sp,16
    80001e58:	00813403          	ld	s0,8(sp)
    80001e5c:	01010113          	addi	sp,sp,16
    80001e60:	fffff317          	auipc	t1,0xfffff
    80001e64:	7dc30067          	jr	2012(t1) # 8000163c <main>

0000000080001e68 <either_copyout>:
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00813023          	sd	s0,0(sp)
    80001e70:	00113423          	sd	ra,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    80001e78:	02051663          	bnez	a0,80001ea4 <either_copyout+0x3c>
    80001e7c:	00058513          	mv	a0,a1
    80001e80:	00060593          	mv	a1,a2
    80001e84:	0006861b          	sext.w	a2,a3
    80001e88:	00002097          	auipc	ra,0x2
    80001e8c:	c5c080e7          	jalr	-932(ra) # 80003ae4 <__memmove>
    80001e90:	00813083          	ld	ra,8(sp)
    80001e94:	00013403          	ld	s0,0(sp)
    80001e98:	00000513          	li	a0,0
    80001e9c:	01010113          	addi	sp,sp,16
    80001ea0:	00008067          	ret
    80001ea4:	00002517          	auipc	a0,0x2
    80001ea8:	1e450513          	addi	a0,a0,484 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001eac:	00001097          	auipc	ra,0x1
    80001eb0:	930080e7          	jalr	-1744(ra) # 800027dc <panic>

0000000080001eb4 <either_copyin>:
    80001eb4:	ff010113          	addi	sp,sp,-16
    80001eb8:	00813023          	sd	s0,0(sp)
    80001ebc:	00113423          	sd	ra,8(sp)
    80001ec0:	01010413          	addi	s0,sp,16
    80001ec4:	02059463          	bnez	a1,80001eec <either_copyin+0x38>
    80001ec8:	00060593          	mv	a1,a2
    80001ecc:	0006861b          	sext.w	a2,a3
    80001ed0:	00002097          	auipc	ra,0x2
    80001ed4:	c14080e7          	jalr	-1004(ra) # 80003ae4 <__memmove>
    80001ed8:	00813083          	ld	ra,8(sp)
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	00000513          	li	a0,0
    80001ee4:	01010113          	addi	sp,sp,16
    80001ee8:	00008067          	ret
    80001eec:	00002517          	auipc	a0,0x2
    80001ef0:	1c450513          	addi	a0,a0,452 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    80001ef4:	00001097          	auipc	ra,0x1
    80001ef8:	8e8080e7          	jalr	-1816(ra) # 800027dc <panic>

0000000080001efc <trapinit>:
    80001efc:	ff010113          	addi	sp,sp,-16
    80001f00:	00813423          	sd	s0,8(sp)
    80001f04:	01010413          	addi	s0,sp,16
    80001f08:	00813403          	ld	s0,8(sp)
    80001f0c:	00002597          	auipc	a1,0x2
    80001f10:	1cc58593          	addi	a1,a1,460 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    80001f14:	00004517          	auipc	a0,0x4
    80001f18:	84c50513          	addi	a0,a0,-1972 # 80005760 <tickslock>
    80001f1c:	01010113          	addi	sp,sp,16
    80001f20:	00001317          	auipc	t1,0x1
    80001f24:	5c830067          	jr	1480(t1) # 800034e8 <initlock>

0000000080001f28 <trapinithart>:
    80001f28:	ff010113          	addi	sp,sp,-16
    80001f2c:	00813423          	sd	s0,8(sp)
    80001f30:	01010413          	addi	s0,sp,16
    80001f34:	00000797          	auipc	a5,0x0
    80001f38:	2fc78793          	addi	a5,a5,764 # 80002230 <kernelvec>
    80001f3c:	10579073          	csrw	stvec,a5
    80001f40:	00813403          	ld	s0,8(sp)
    80001f44:	01010113          	addi	sp,sp,16
    80001f48:	00008067          	ret

0000000080001f4c <usertrap>:
    80001f4c:	ff010113          	addi	sp,sp,-16
    80001f50:	00813423          	sd	s0,8(sp)
    80001f54:	01010413          	addi	s0,sp,16
    80001f58:	00813403          	ld	s0,8(sp)
    80001f5c:	01010113          	addi	sp,sp,16
    80001f60:	00008067          	ret

0000000080001f64 <usertrapret>:
    80001f64:	ff010113          	addi	sp,sp,-16
    80001f68:	00813423          	sd	s0,8(sp)
    80001f6c:	01010413          	addi	s0,sp,16
    80001f70:	00813403          	ld	s0,8(sp)
    80001f74:	01010113          	addi	sp,sp,16
    80001f78:	00008067          	ret

0000000080001f7c <kerneltrap>:
    80001f7c:	fe010113          	addi	sp,sp,-32
    80001f80:	00813823          	sd	s0,16(sp)
    80001f84:	00113c23          	sd	ra,24(sp)
    80001f88:	00913423          	sd	s1,8(sp)
    80001f8c:	02010413          	addi	s0,sp,32
    80001f90:	142025f3          	csrr	a1,scause
    80001f94:	100027f3          	csrr	a5,sstatus
    80001f98:	0027f793          	andi	a5,a5,2
    80001f9c:	10079c63          	bnez	a5,800020b4 <kerneltrap+0x138>
    80001fa0:	142027f3          	csrr	a5,scause
    80001fa4:	0207ce63          	bltz	a5,80001fe0 <kerneltrap+0x64>
    80001fa8:	00002517          	auipc	a0,0x2
    80001fac:	17850513          	addi	a0,a0,376 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001fb0:	00001097          	auipc	ra,0x1
    80001fb4:	888080e7          	jalr	-1912(ra) # 80002838 <__printf>
    80001fb8:	141025f3          	csrr	a1,sepc
    80001fbc:	14302673          	csrr	a2,stval
    80001fc0:	00002517          	auipc	a0,0x2
    80001fc4:	17050513          	addi	a0,a0,368 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001fc8:	00001097          	auipc	ra,0x1
    80001fcc:	870080e7          	jalr	-1936(ra) # 80002838 <__printf>
    80001fd0:	00002517          	auipc	a0,0x2
    80001fd4:	17850513          	addi	a0,a0,376 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001fd8:	00001097          	auipc	ra,0x1
    80001fdc:	804080e7          	jalr	-2044(ra) # 800027dc <panic>
    80001fe0:	0ff7f713          	andi	a4,a5,255
    80001fe4:	00900693          	li	a3,9
    80001fe8:	04d70063          	beq	a4,a3,80002028 <kerneltrap+0xac>
    80001fec:	fff00713          	li	a4,-1
    80001ff0:	03f71713          	slli	a4,a4,0x3f
    80001ff4:	00170713          	addi	a4,a4,1
    80001ff8:	fae798e3          	bne	a5,a4,80001fa8 <kerneltrap+0x2c>
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	e00080e7          	jalr	-512(ra) # 80001dfc <cpuid>
    80002004:	06050663          	beqz	a0,80002070 <kerneltrap+0xf4>
    80002008:	144027f3          	csrr	a5,sip
    8000200c:	ffd7f793          	andi	a5,a5,-3
    80002010:	14479073          	csrw	sip,a5
    80002014:	01813083          	ld	ra,24(sp)
    80002018:	01013403          	ld	s0,16(sp)
    8000201c:	00813483          	ld	s1,8(sp)
    80002020:	02010113          	addi	sp,sp,32
    80002024:	00008067          	ret
    80002028:	00000097          	auipc	ra,0x0
    8000202c:	3cc080e7          	jalr	972(ra) # 800023f4 <plic_claim>
    80002030:	00a00793          	li	a5,10
    80002034:	00050493          	mv	s1,a0
    80002038:	06f50863          	beq	a0,a5,800020a8 <kerneltrap+0x12c>
    8000203c:	fc050ce3          	beqz	a0,80002014 <kerneltrap+0x98>
    80002040:	00050593          	mv	a1,a0
    80002044:	00002517          	auipc	a0,0x2
    80002048:	0bc50513          	addi	a0,a0,188 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    8000204c:	00000097          	auipc	ra,0x0
    80002050:	7ec080e7          	jalr	2028(ra) # 80002838 <__printf>
    80002054:	01013403          	ld	s0,16(sp)
    80002058:	01813083          	ld	ra,24(sp)
    8000205c:	00048513          	mv	a0,s1
    80002060:	00813483          	ld	s1,8(sp)
    80002064:	02010113          	addi	sp,sp,32
    80002068:	00000317          	auipc	t1,0x0
    8000206c:	3c430067          	jr	964(t1) # 8000242c <plic_complete>
    80002070:	00003517          	auipc	a0,0x3
    80002074:	6f050513          	addi	a0,a0,1776 # 80005760 <tickslock>
    80002078:	00001097          	auipc	ra,0x1
    8000207c:	494080e7          	jalr	1172(ra) # 8000350c <acquire>
    80002080:	00002717          	auipc	a4,0x2
    80002084:	5d470713          	addi	a4,a4,1492 # 80004654 <ticks>
    80002088:	00072783          	lw	a5,0(a4)
    8000208c:	00003517          	auipc	a0,0x3
    80002090:	6d450513          	addi	a0,a0,1748 # 80005760 <tickslock>
    80002094:	0017879b          	addiw	a5,a5,1
    80002098:	00f72023          	sw	a5,0(a4)
    8000209c:	00001097          	auipc	ra,0x1
    800020a0:	53c080e7          	jalr	1340(ra) # 800035d8 <release>
    800020a4:	f65ff06f          	j	80002008 <kerneltrap+0x8c>
    800020a8:	00001097          	auipc	ra,0x1
    800020ac:	098080e7          	jalr	152(ra) # 80003140 <uartintr>
    800020b0:	fa5ff06f          	j	80002054 <kerneltrap+0xd8>
    800020b4:	00002517          	auipc	a0,0x2
    800020b8:	02c50513          	addi	a0,a0,44 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    800020bc:	00000097          	auipc	ra,0x0
    800020c0:	720080e7          	jalr	1824(ra) # 800027dc <panic>

00000000800020c4 <clockintr>:
    800020c4:	fe010113          	addi	sp,sp,-32
    800020c8:	00813823          	sd	s0,16(sp)
    800020cc:	00913423          	sd	s1,8(sp)
    800020d0:	00113c23          	sd	ra,24(sp)
    800020d4:	02010413          	addi	s0,sp,32
    800020d8:	00003497          	auipc	s1,0x3
    800020dc:	68848493          	addi	s1,s1,1672 # 80005760 <tickslock>
    800020e0:	00048513          	mv	a0,s1
    800020e4:	00001097          	auipc	ra,0x1
    800020e8:	428080e7          	jalr	1064(ra) # 8000350c <acquire>
    800020ec:	00002717          	auipc	a4,0x2
    800020f0:	56870713          	addi	a4,a4,1384 # 80004654 <ticks>
    800020f4:	00072783          	lw	a5,0(a4)
    800020f8:	01013403          	ld	s0,16(sp)
    800020fc:	01813083          	ld	ra,24(sp)
    80002100:	00048513          	mv	a0,s1
    80002104:	0017879b          	addiw	a5,a5,1
    80002108:	00813483          	ld	s1,8(sp)
    8000210c:	00f72023          	sw	a5,0(a4)
    80002110:	02010113          	addi	sp,sp,32
    80002114:	00001317          	auipc	t1,0x1
    80002118:	4c430067          	jr	1220(t1) # 800035d8 <release>

000000008000211c <devintr>:
    8000211c:	142027f3          	csrr	a5,scause
    80002120:	00000513          	li	a0,0
    80002124:	0007c463          	bltz	a5,8000212c <devintr+0x10>
    80002128:	00008067          	ret
    8000212c:	fe010113          	addi	sp,sp,-32
    80002130:	00813823          	sd	s0,16(sp)
    80002134:	00113c23          	sd	ra,24(sp)
    80002138:	00913423          	sd	s1,8(sp)
    8000213c:	02010413          	addi	s0,sp,32
    80002140:	0ff7f713          	andi	a4,a5,255
    80002144:	00900693          	li	a3,9
    80002148:	04d70c63          	beq	a4,a3,800021a0 <devintr+0x84>
    8000214c:	fff00713          	li	a4,-1
    80002150:	03f71713          	slli	a4,a4,0x3f
    80002154:	00170713          	addi	a4,a4,1
    80002158:	00e78c63          	beq	a5,a4,80002170 <devintr+0x54>
    8000215c:	01813083          	ld	ra,24(sp)
    80002160:	01013403          	ld	s0,16(sp)
    80002164:	00813483          	ld	s1,8(sp)
    80002168:	02010113          	addi	sp,sp,32
    8000216c:	00008067          	ret
    80002170:	00000097          	auipc	ra,0x0
    80002174:	c8c080e7          	jalr	-884(ra) # 80001dfc <cpuid>
    80002178:	06050663          	beqz	a0,800021e4 <devintr+0xc8>
    8000217c:	144027f3          	csrr	a5,sip
    80002180:	ffd7f793          	andi	a5,a5,-3
    80002184:	14479073          	csrw	sip,a5
    80002188:	01813083          	ld	ra,24(sp)
    8000218c:	01013403          	ld	s0,16(sp)
    80002190:	00813483          	ld	s1,8(sp)
    80002194:	00200513          	li	a0,2
    80002198:	02010113          	addi	sp,sp,32
    8000219c:	00008067          	ret
    800021a0:	00000097          	auipc	ra,0x0
    800021a4:	254080e7          	jalr	596(ra) # 800023f4 <plic_claim>
    800021a8:	00a00793          	li	a5,10
    800021ac:	00050493          	mv	s1,a0
    800021b0:	06f50663          	beq	a0,a5,8000221c <devintr+0x100>
    800021b4:	00100513          	li	a0,1
    800021b8:	fa0482e3          	beqz	s1,8000215c <devintr+0x40>
    800021bc:	00048593          	mv	a1,s1
    800021c0:	00002517          	auipc	a0,0x2
    800021c4:	f4050513          	addi	a0,a0,-192 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    800021c8:	00000097          	auipc	ra,0x0
    800021cc:	670080e7          	jalr	1648(ra) # 80002838 <__printf>
    800021d0:	00048513          	mv	a0,s1
    800021d4:	00000097          	auipc	ra,0x0
    800021d8:	258080e7          	jalr	600(ra) # 8000242c <plic_complete>
    800021dc:	00100513          	li	a0,1
    800021e0:	f7dff06f          	j	8000215c <devintr+0x40>
    800021e4:	00003517          	auipc	a0,0x3
    800021e8:	57c50513          	addi	a0,a0,1404 # 80005760 <tickslock>
    800021ec:	00001097          	auipc	ra,0x1
    800021f0:	320080e7          	jalr	800(ra) # 8000350c <acquire>
    800021f4:	00002717          	auipc	a4,0x2
    800021f8:	46070713          	addi	a4,a4,1120 # 80004654 <ticks>
    800021fc:	00072783          	lw	a5,0(a4)
    80002200:	00003517          	auipc	a0,0x3
    80002204:	56050513          	addi	a0,a0,1376 # 80005760 <tickslock>
    80002208:	0017879b          	addiw	a5,a5,1
    8000220c:	00f72023          	sw	a5,0(a4)
    80002210:	00001097          	auipc	ra,0x1
    80002214:	3c8080e7          	jalr	968(ra) # 800035d8 <release>
    80002218:	f65ff06f          	j	8000217c <devintr+0x60>
    8000221c:	00001097          	auipc	ra,0x1
    80002220:	f24080e7          	jalr	-220(ra) # 80003140 <uartintr>
    80002224:	fadff06f          	j	800021d0 <devintr+0xb4>
	...

0000000080002230 <kernelvec>:
    80002230:	f0010113          	addi	sp,sp,-256
    80002234:	00113023          	sd	ra,0(sp)
    80002238:	00213423          	sd	sp,8(sp)
    8000223c:	00313823          	sd	gp,16(sp)
    80002240:	00413c23          	sd	tp,24(sp)
    80002244:	02513023          	sd	t0,32(sp)
    80002248:	02613423          	sd	t1,40(sp)
    8000224c:	02713823          	sd	t2,48(sp)
    80002250:	02813c23          	sd	s0,56(sp)
    80002254:	04913023          	sd	s1,64(sp)
    80002258:	04a13423          	sd	a0,72(sp)
    8000225c:	04b13823          	sd	a1,80(sp)
    80002260:	04c13c23          	sd	a2,88(sp)
    80002264:	06d13023          	sd	a3,96(sp)
    80002268:	06e13423          	sd	a4,104(sp)
    8000226c:	06f13823          	sd	a5,112(sp)
    80002270:	07013c23          	sd	a6,120(sp)
    80002274:	09113023          	sd	a7,128(sp)
    80002278:	09213423          	sd	s2,136(sp)
    8000227c:	09313823          	sd	s3,144(sp)
    80002280:	09413c23          	sd	s4,152(sp)
    80002284:	0b513023          	sd	s5,160(sp)
    80002288:	0b613423          	sd	s6,168(sp)
    8000228c:	0b713823          	sd	s7,176(sp)
    80002290:	0b813c23          	sd	s8,184(sp)
    80002294:	0d913023          	sd	s9,192(sp)
    80002298:	0da13423          	sd	s10,200(sp)
    8000229c:	0db13823          	sd	s11,208(sp)
    800022a0:	0dc13c23          	sd	t3,216(sp)
    800022a4:	0fd13023          	sd	t4,224(sp)
    800022a8:	0fe13423          	sd	t5,232(sp)
    800022ac:	0ff13823          	sd	t6,240(sp)
    800022b0:	ccdff0ef          	jal	ra,80001f7c <kerneltrap>
    800022b4:	00013083          	ld	ra,0(sp)
    800022b8:	00813103          	ld	sp,8(sp)
    800022bc:	01013183          	ld	gp,16(sp)
    800022c0:	02013283          	ld	t0,32(sp)
    800022c4:	02813303          	ld	t1,40(sp)
    800022c8:	03013383          	ld	t2,48(sp)
    800022cc:	03813403          	ld	s0,56(sp)
    800022d0:	04013483          	ld	s1,64(sp)
    800022d4:	04813503          	ld	a0,72(sp)
    800022d8:	05013583          	ld	a1,80(sp)
    800022dc:	05813603          	ld	a2,88(sp)
    800022e0:	06013683          	ld	a3,96(sp)
    800022e4:	06813703          	ld	a4,104(sp)
    800022e8:	07013783          	ld	a5,112(sp)
    800022ec:	07813803          	ld	a6,120(sp)
    800022f0:	08013883          	ld	a7,128(sp)
    800022f4:	08813903          	ld	s2,136(sp)
    800022f8:	09013983          	ld	s3,144(sp)
    800022fc:	09813a03          	ld	s4,152(sp)
    80002300:	0a013a83          	ld	s5,160(sp)
    80002304:	0a813b03          	ld	s6,168(sp)
    80002308:	0b013b83          	ld	s7,176(sp)
    8000230c:	0b813c03          	ld	s8,184(sp)
    80002310:	0c013c83          	ld	s9,192(sp)
    80002314:	0c813d03          	ld	s10,200(sp)
    80002318:	0d013d83          	ld	s11,208(sp)
    8000231c:	0d813e03          	ld	t3,216(sp)
    80002320:	0e013e83          	ld	t4,224(sp)
    80002324:	0e813f03          	ld	t5,232(sp)
    80002328:	0f013f83          	ld	t6,240(sp)
    8000232c:	10010113          	addi	sp,sp,256
    80002330:	10200073          	sret
    80002334:	00000013          	nop
    80002338:	00000013          	nop
    8000233c:	00000013          	nop

0000000080002340 <timervec>:
    80002340:	34051573          	csrrw	a0,mscratch,a0
    80002344:	00b53023          	sd	a1,0(a0)
    80002348:	00c53423          	sd	a2,8(a0)
    8000234c:	00d53823          	sd	a3,16(a0)
    80002350:	01853583          	ld	a1,24(a0)
    80002354:	02053603          	ld	a2,32(a0)
    80002358:	0005b683          	ld	a3,0(a1)
    8000235c:	00c686b3          	add	a3,a3,a2
    80002360:	00d5b023          	sd	a3,0(a1)
    80002364:	00200593          	li	a1,2
    80002368:	14459073          	csrw	sip,a1
    8000236c:	01053683          	ld	a3,16(a0)
    80002370:	00853603          	ld	a2,8(a0)
    80002374:	00053583          	ld	a1,0(a0)
    80002378:	34051573          	csrrw	a0,mscratch,a0
    8000237c:	30200073          	mret

0000000080002380 <plicinit>:
    80002380:	ff010113          	addi	sp,sp,-16
    80002384:	00813423          	sd	s0,8(sp)
    80002388:	01010413          	addi	s0,sp,16
    8000238c:	00813403          	ld	s0,8(sp)
    80002390:	0c0007b7          	lui	a5,0xc000
    80002394:	00100713          	li	a4,1
    80002398:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000239c:	00e7a223          	sw	a4,4(a5)
    800023a0:	01010113          	addi	sp,sp,16
    800023a4:	00008067          	ret

00000000800023a8 <plicinithart>:
    800023a8:	ff010113          	addi	sp,sp,-16
    800023ac:	00813023          	sd	s0,0(sp)
    800023b0:	00113423          	sd	ra,8(sp)
    800023b4:	01010413          	addi	s0,sp,16
    800023b8:	00000097          	auipc	ra,0x0
    800023bc:	a44080e7          	jalr	-1468(ra) # 80001dfc <cpuid>
    800023c0:	0085171b          	slliw	a4,a0,0x8
    800023c4:	0c0027b7          	lui	a5,0xc002
    800023c8:	00e787b3          	add	a5,a5,a4
    800023cc:	40200713          	li	a4,1026
    800023d0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800023d4:	00813083          	ld	ra,8(sp)
    800023d8:	00013403          	ld	s0,0(sp)
    800023dc:	00d5151b          	slliw	a0,a0,0xd
    800023e0:	0c2017b7          	lui	a5,0xc201
    800023e4:	00a78533          	add	a0,a5,a0
    800023e8:	00052023          	sw	zero,0(a0)
    800023ec:	01010113          	addi	sp,sp,16
    800023f0:	00008067          	ret

00000000800023f4 <plic_claim>:
    800023f4:	ff010113          	addi	sp,sp,-16
    800023f8:	00813023          	sd	s0,0(sp)
    800023fc:	00113423          	sd	ra,8(sp)
    80002400:	01010413          	addi	s0,sp,16
    80002404:	00000097          	auipc	ra,0x0
    80002408:	9f8080e7          	jalr	-1544(ra) # 80001dfc <cpuid>
    8000240c:	00813083          	ld	ra,8(sp)
    80002410:	00013403          	ld	s0,0(sp)
    80002414:	00d5151b          	slliw	a0,a0,0xd
    80002418:	0c2017b7          	lui	a5,0xc201
    8000241c:	00a78533          	add	a0,a5,a0
    80002420:	00452503          	lw	a0,4(a0)
    80002424:	01010113          	addi	sp,sp,16
    80002428:	00008067          	ret

000000008000242c <plic_complete>:
    8000242c:	fe010113          	addi	sp,sp,-32
    80002430:	00813823          	sd	s0,16(sp)
    80002434:	00913423          	sd	s1,8(sp)
    80002438:	00113c23          	sd	ra,24(sp)
    8000243c:	02010413          	addi	s0,sp,32
    80002440:	00050493          	mv	s1,a0
    80002444:	00000097          	auipc	ra,0x0
    80002448:	9b8080e7          	jalr	-1608(ra) # 80001dfc <cpuid>
    8000244c:	01813083          	ld	ra,24(sp)
    80002450:	01013403          	ld	s0,16(sp)
    80002454:	00d5179b          	slliw	a5,a0,0xd
    80002458:	0c201737          	lui	a4,0xc201
    8000245c:	00f707b3          	add	a5,a4,a5
    80002460:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002464:	00813483          	ld	s1,8(sp)
    80002468:	02010113          	addi	sp,sp,32
    8000246c:	00008067          	ret

0000000080002470 <consolewrite>:
    80002470:	fb010113          	addi	sp,sp,-80
    80002474:	04813023          	sd	s0,64(sp)
    80002478:	04113423          	sd	ra,72(sp)
    8000247c:	02913c23          	sd	s1,56(sp)
    80002480:	03213823          	sd	s2,48(sp)
    80002484:	03313423          	sd	s3,40(sp)
    80002488:	03413023          	sd	s4,32(sp)
    8000248c:	01513c23          	sd	s5,24(sp)
    80002490:	05010413          	addi	s0,sp,80
    80002494:	06c05c63          	blez	a2,8000250c <consolewrite+0x9c>
    80002498:	00060993          	mv	s3,a2
    8000249c:	00050a13          	mv	s4,a0
    800024a0:	00058493          	mv	s1,a1
    800024a4:	00000913          	li	s2,0
    800024a8:	fff00a93          	li	s5,-1
    800024ac:	01c0006f          	j	800024c8 <consolewrite+0x58>
    800024b0:	fbf44503          	lbu	a0,-65(s0)
    800024b4:	0019091b          	addiw	s2,s2,1
    800024b8:	00148493          	addi	s1,s1,1
    800024bc:	00001097          	auipc	ra,0x1
    800024c0:	a9c080e7          	jalr	-1380(ra) # 80002f58 <uartputc>
    800024c4:	03298063          	beq	s3,s2,800024e4 <consolewrite+0x74>
    800024c8:	00048613          	mv	a2,s1
    800024cc:	00100693          	li	a3,1
    800024d0:	000a0593          	mv	a1,s4
    800024d4:	fbf40513          	addi	a0,s0,-65
    800024d8:	00000097          	auipc	ra,0x0
    800024dc:	9dc080e7          	jalr	-1572(ra) # 80001eb4 <either_copyin>
    800024e0:	fd5518e3          	bne	a0,s5,800024b0 <consolewrite+0x40>
    800024e4:	04813083          	ld	ra,72(sp)
    800024e8:	04013403          	ld	s0,64(sp)
    800024ec:	03813483          	ld	s1,56(sp)
    800024f0:	02813983          	ld	s3,40(sp)
    800024f4:	02013a03          	ld	s4,32(sp)
    800024f8:	01813a83          	ld	s5,24(sp)
    800024fc:	00090513          	mv	a0,s2
    80002500:	03013903          	ld	s2,48(sp)
    80002504:	05010113          	addi	sp,sp,80
    80002508:	00008067          	ret
    8000250c:	00000913          	li	s2,0
    80002510:	fd5ff06f          	j	800024e4 <consolewrite+0x74>

0000000080002514 <consoleread>:
    80002514:	f9010113          	addi	sp,sp,-112
    80002518:	06813023          	sd	s0,96(sp)
    8000251c:	04913c23          	sd	s1,88(sp)
    80002520:	05213823          	sd	s2,80(sp)
    80002524:	05313423          	sd	s3,72(sp)
    80002528:	05413023          	sd	s4,64(sp)
    8000252c:	03513c23          	sd	s5,56(sp)
    80002530:	03613823          	sd	s6,48(sp)
    80002534:	03713423          	sd	s7,40(sp)
    80002538:	03813023          	sd	s8,32(sp)
    8000253c:	06113423          	sd	ra,104(sp)
    80002540:	01913c23          	sd	s9,24(sp)
    80002544:	07010413          	addi	s0,sp,112
    80002548:	00060b93          	mv	s7,a2
    8000254c:	00050913          	mv	s2,a0
    80002550:	00058c13          	mv	s8,a1
    80002554:	00060b1b          	sext.w	s6,a2
    80002558:	00003497          	auipc	s1,0x3
    8000255c:	23048493          	addi	s1,s1,560 # 80005788 <cons>
    80002560:	00400993          	li	s3,4
    80002564:	fff00a13          	li	s4,-1
    80002568:	00a00a93          	li	s5,10
    8000256c:	05705e63          	blez	s7,800025c8 <consoleread+0xb4>
    80002570:	09c4a703          	lw	a4,156(s1)
    80002574:	0984a783          	lw	a5,152(s1)
    80002578:	0007071b          	sext.w	a4,a4
    8000257c:	08e78463          	beq	a5,a4,80002604 <consoleread+0xf0>
    80002580:	07f7f713          	andi	a4,a5,127
    80002584:	00e48733          	add	a4,s1,a4
    80002588:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000258c:	0017869b          	addiw	a3,a5,1
    80002590:	08d4ac23          	sw	a3,152(s1)
    80002594:	00070c9b          	sext.w	s9,a4
    80002598:	0b370663          	beq	a4,s3,80002644 <consoleread+0x130>
    8000259c:	00100693          	li	a3,1
    800025a0:	f9f40613          	addi	a2,s0,-97
    800025a4:	000c0593          	mv	a1,s8
    800025a8:	00090513          	mv	a0,s2
    800025ac:	f8e40fa3          	sb	a4,-97(s0)
    800025b0:	00000097          	auipc	ra,0x0
    800025b4:	8b8080e7          	jalr	-1864(ra) # 80001e68 <either_copyout>
    800025b8:	01450863          	beq	a0,s4,800025c8 <consoleread+0xb4>
    800025bc:	001c0c13          	addi	s8,s8,1
    800025c0:	fffb8b9b          	addiw	s7,s7,-1
    800025c4:	fb5c94e3          	bne	s9,s5,8000256c <consoleread+0x58>
    800025c8:	000b851b          	sext.w	a0,s7
    800025cc:	06813083          	ld	ra,104(sp)
    800025d0:	06013403          	ld	s0,96(sp)
    800025d4:	05813483          	ld	s1,88(sp)
    800025d8:	05013903          	ld	s2,80(sp)
    800025dc:	04813983          	ld	s3,72(sp)
    800025e0:	04013a03          	ld	s4,64(sp)
    800025e4:	03813a83          	ld	s5,56(sp)
    800025e8:	02813b83          	ld	s7,40(sp)
    800025ec:	02013c03          	ld	s8,32(sp)
    800025f0:	01813c83          	ld	s9,24(sp)
    800025f4:	40ab053b          	subw	a0,s6,a0
    800025f8:	03013b03          	ld	s6,48(sp)
    800025fc:	07010113          	addi	sp,sp,112
    80002600:	00008067          	ret
    80002604:	00001097          	auipc	ra,0x1
    80002608:	1d8080e7          	jalr	472(ra) # 800037dc <push_on>
    8000260c:	0984a703          	lw	a4,152(s1)
    80002610:	09c4a783          	lw	a5,156(s1)
    80002614:	0007879b          	sext.w	a5,a5
    80002618:	fef70ce3          	beq	a4,a5,80002610 <consoleread+0xfc>
    8000261c:	00001097          	auipc	ra,0x1
    80002620:	234080e7          	jalr	564(ra) # 80003850 <pop_on>
    80002624:	0984a783          	lw	a5,152(s1)
    80002628:	07f7f713          	andi	a4,a5,127
    8000262c:	00e48733          	add	a4,s1,a4
    80002630:	01874703          	lbu	a4,24(a4)
    80002634:	0017869b          	addiw	a3,a5,1
    80002638:	08d4ac23          	sw	a3,152(s1)
    8000263c:	00070c9b          	sext.w	s9,a4
    80002640:	f5371ee3          	bne	a4,s3,8000259c <consoleread+0x88>
    80002644:	000b851b          	sext.w	a0,s7
    80002648:	f96bf2e3          	bgeu	s7,s6,800025cc <consoleread+0xb8>
    8000264c:	08f4ac23          	sw	a5,152(s1)
    80002650:	f7dff06f          	j	800025cc <consoleread+0xb8>

0000000080002654 <consputc>:
    80002654:	10000793          	li	a5,256
    80002658:	00f50663          	beq	a0,a5,80002664 <consputc+0x10>
    8000265c:	00001317          	auipc	t1,0x1
    80002660:	9f430067          	jr	-1548(t1) # 80003050 <uartputc_sync>
    80002664:	ff010113          	addi	sp,sp,-16
    80002668:	00113423          	sd	ra,8(sp)
    8000266c:	00813023          	sd	s0,0(sp)
    80002670:	01010413          	addi	s0,sp,16
    80002674:	00800513          	li	a0,8
    80002678:	00001097          	auipc	ra,0x1
    8000267c:	9d8080e7          	jalr	-1576(ra) # 80003050 <uartputc_sync>
    80002680:	02000513          	li	a0,32
    80002684:	00001097          	auipc	ra,0x1
    80002688:	9cc080e7          	jalr	-1588(ra) # 80003050 <uartputc_sync>
    8000268c:	00013403          	ld	s0,0(sp)
    80002690:	00813083          	ld	ra,8(sp)
    80002694:	00800513          	li	a0,8
    80002698:	01010113          	addi	sp,sp,16
    8000269c:	00001317          	auipc	t1,0x1
    800026a0:	9b430067          	jr	-1612(t1) # 80003050 <uartputc_sync>

00000000800026a4 <consoleintr>:
    800026a4:	fe010113          	addi	sp,sp,-32
    800026a8:	00813823          	sd	s0,16(sp)
    800026ac:	00913423          	sd	s1,8(sp)
    800026b0:	01213023          	sd	s2,0(sp)
    800026b4:	00113c23          	sd	ra,24(sp)
    800026b8:	02010413          	addi	s0,sp,32
    800026bc:	00003917          	auipc	s2,0x3
    800026c0:	0cc90913          	addi	s2,s2,204 # 80005788 <cons>
    800026c4:	00050493          	mv	s1,a0
    800026c8:	00090513          	mv	a0,s2
    800026cc:	00001097          	auipc	ra,0x1
    800026d0:	e40080e7          	jalr	-448(ra) # 8000350c <acquire>
    800026d4:	02048c63          	beqz	s1,8000270c <consoleintr+0x68>
    800026d8:	0a092783          	lw	a5,160(s2)
    800026dc:	09892703          	lw	a4,152(s2)
    800026e0:	07f00693          	li	a3,127
    800026e4:	40e7873b          	subw	a4,a5,a4
    800026e8:	02e6e263          	bltu	a3,a4,8000270c <consoleintr+0x68>
    800026ec:	00d00713          	li	a4,13
    800026f0:	04e48063          	beq	s1,a4,80002730 <consoleintr+0x8c>
    800026f4:	07f7f713          	andi	a4,a5,127
    800026f8:	00e90733          	add	a4,s2,a4
    800026fc:	0017879b          	addiw	a5,a5,1
    80002700:	0af92023          	sw	a5,160(s2)
    80002704:	00970c23          	sb	s1,24(a4)
    80002708:	08f92e23          	sw	a5,156(s2)
    8000270c:	01013403          	ld	s0,16(sp)
    80002710:	01813083          	ld	ra,24(sp)
    80002714:	00813483          	ld	s1,8(sp)
    80002718:	00013903          	ld	s2,0(sp)
    8000271c:	00003517          	auipc	a0,0x3
    80002720:	06c50513          	addi	a0,a0,108 # 80005788 <cons>
    80002724:	02010113          	addi	sp,sp,32
    80002728:	00001317          	auipc	t1,0x1
    8000272c:	eb030067          	jr	-336(t1) # 800035d8 <release>
    80002730:	00a00493          	li	s1,10
    80002734:	fc1ff06f          	j	800026f4 <consoleintr+0x50>

0000000080002738 <consoleinit>:
    80002738:	fe010113          	addi	sp,sp,-32
    8000273c:	00113c23          	sd	ra,24(sp)
    80002740:	00813823          	sd	s0,16(sp)
    80002744:	00913423          	sd	s1,8(sp)
    80002748:	02010413          	addi	s0,sp,32
    8000274c:	00003497          	auipc	s1,0x3
    80002750:	03c48493          	addi	s1,s1,60 # 80005788 <cons>
    80002754:	00048513          	mv	a0,s1
    80002758:	00002597          	auipc	a1,0x2
    8000275c:	a0058593          	addi	a1,a1,-1536 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    80002760:	00001097          	auipc	ra,0x1
    80002764:	d88080e7          	jalr	-632(ra) # 800034e8 <initlock>
    80002768:	00000097          	auipc	ra,0x0
    8000276c:	7ac080e7          	jalr	1964(ra) # 80002f14 <uartinit>
    80002770:	01813083          	ld	ra,24(sp)
    80002774:	01013403          	ld	s0,16(sp)
    80002778:	00000797          	auipc	a5,0x0
    8000277c:	d9c78793          	addi	a5,a5,-612 # 80002514 <consoleread>
    80002780:	0af4bc23          	sd	a5,184(s1)
    80002784:	00000797          	auipc	a5,0x0
    80002788:	cec78793          	addi	a5,a5,-788 # 80002470 <consolewrite>
    8000278c:	0cf4b023          	sd	a5,192(s1)
    80002790:	00813483          	ld	s1,8(sp)
    80002794:	02010113          	addi	sp,sp,32
    80002798:	00008067          	ret

000000008000279c <console_read>:
    8000279c:	ff010113          	addi	sp,sp,-16
    800027a0:	00813423          	sd	s0,8(sp)
    800027a4:	01010413          	addi	s0,sp,16
    800027a8:	00813403          	ld	s0,8(sp)
    800027ac:	00003317          	auipc	t1,0x3
    800027b0:	09433303          	ld	t1,148(t1) # 80005840 <devsw+0x10>
    800027b4:	01010113          	addi	sp,sp,16
    800027b8:	00030067          	jr	t1

00000000800027bc <console_write>:
    800027bc:	ff010113          	addi	sp,sp,-16
    800027c0:	00813423          	sd	s0,8(sp)
    800027c4:	01010413          	addi	s0,sp,16
    800027c8:	00813403          	ld	s0,8(sp)
    800027cc:	00003317          	auipc	t1,0x3
    800027d0:	07c33303          	ld	t1,124(t1) # 80005848 <devsw+0x18>
    800027d4:	01010113          	addi	sp,sp,16
    800027d8:	00030067          	jr	t1

00000000800027dc <panic>:
    800027dc:	fe010113          	addi	sp,sp,-32
    800027e0:	00113c23          	sd	ra,24(sp)
    800027e4:	00813823          	sd	s0,16(sp)
    800027e8:	00913423          	sd	s1,8(sp)
    800027ec:	02010413          	addi	s0,sp,32
    800027f0:	00050493          	mv	s1,a0
    800027f4:	00002517          	auipc	a0,0x2
    800027f8:	96c50513          	addi	a0,a0,-1684 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    800027fc:	00003797          	auipc	a5,0x3
    80002800:	0e07a623          	sw	zero,236(a5) # 800058e8 <pr+0x18>
    80002804:	00000097          	auipc	ra,0x0
    80002808:	034080e7          	jalr	52(ra) # 80002838 <__printf>
    8000280c:	00048513          	mv	a0,s1
    80002810:	00000097          	auipc	ra,0x0
    80002814:	028080e7          	jalr	40(ra) # 80002838 <__printf>
    80002818:	00002517          	auipc	a0,0x2
    8000281c:	92850513          	addi	a0,a0,-1752 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80002820:	00000097          	auipc	ra,0x0
    80002824:	018080e7          	jalr	24(ra) # 80002838 <__printf>
    80002828:	00100793          	li	a5,1
    8000282c:	00002717          	auipc	a4,0x2
    80002830:	e2f72623          	sw	a5,-468(a4) # 80004658 <panicked>
    80002834:	0000006f          	j	80002834 <panic+0x58>

0000000080002838 <__printf>:
    80002838:	f3010113          	addi	sp,sp,-208
    8000283c:	08813023          	sd	s0,128(sp)
    80002840:	07313423          	sd	s3,104(sp)
    80002844:	09010413          	addi	s0,sp,144
    80002848:	05813023          	sd	s8,64(sp)
    8000284c:	08113423          	sd	ra,136(sp)
    80002850:	06913c23          	sd	s1,120(sp)
    80002854:	07213823          	sd	s2,112(sp)
    80002858:	07413023          	sd	s4,96(sp)
    8000285c:	05513c23          	sd	s5,88(sp)
    80002860:	05613823          	sd	s6,80(sp)
    80002864:	05713423          	sd	s7,72(sp)
    80002868:	03913c23          	sd	s9,56(sp)
    8000286c:	03a13823          	sd	s10,48(sp)
    80002870:	03b13423          	sd	s11,40(sp)
    80002874:	00003317          	auipc	t1,0x3
    80002878:	05c30313          	addi	t1,t1,92 # 800058d0 <pr>
    8000287c:	01832c03          	lw	s8,24(t1)
    80002880:	00b43423          	sd	a1,8(s0)
    80002884:	00c43823          	sd	a2,16(s0)
    80002888:	00d43c23          	sd	a3,24(s0)
    8000288c:	02e43023          	sd	a4,32(s0)
    80002890:	02f43423          	sd	a5,40(s0)
    80002894:	03043823          	sd	a6,48(s0)
    80002898:	03143c23          	sd	a7,56(s0)
    8000289c:	00050993          	mv	s3,a0
    800028a0:	4a0c1663          	bnez	s8,80002d4c <__printf+0x514>
    800028a4:	60098c63          	beqz	s3,80002ebc <__printf+0x684>
    800028a8:	0009c503          	lbu	a0,0(s3)
    800028ac:	00840793          	addi	a5,s0,8
    800028b0:	f6f43c23          	sd	a5,-136(s0)
    800028b4:	00000493          	li	s1,0
    800028b8:	22050063          	beqz	a0,80002ad8 <__printf+0x2a0>
    800028bc:	00002a37          	lui	s4,0x2
    800028c0:	00018ab7          	lui	s5,0x18
    800028c4:	000f4b37          	lui	s6,0xf4
    800028c8:	00989bb7          	lui	s7,0x989
    800028cc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800028d0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800028d4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800028d8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800028dc:	00148c9b          	addiw	s9,s1,1
    800028e0:	02500793          	li	a5,37
    800028e4:	01998933          	add	s2,s3,s9
    800028e8:	38f51263          	bne	a0,a5,80002c6c <__printf+0x434>
    800028ec:	00094783          	lbu	a5,0(s2)
    800028f0:	00078c9b          	sext.w	s9,a5
    800028f4:	1e078263          	beqz	a5,80002ad8 <__printf+0x2a0>
    800028f8:	0024849b          	addiw	s1,s1,2
    800028fc:	07000713          	li	a4,112
    80002900:	00998933          	add	s2,s3,s1
    80002904:	38e78a63          	beq	a5,a4,80002c98 <__printf+0x460>
    80002908:	20f76863          	bltu	a4,a5,80002b18 <__printf+0x2e0>
    8000290c:	42a78863          	beq	a5,a0,80002d3c <__printf+0x504>
    80002910:	06400713          	li	a4,100
    80002914:	40e79663          	bne	a5,a4,80002d20 <__printf+0x4e8>
    80002918:	f7843783          	ld	a5,-136(s0)
    8000291c:	0007a603          	lw	a2,0(a5)
    80002920:	00878793          	addi	a5,a5,8
    80002924:	f6f43c23          	sd	a5,-136(s0)
    80002928:	42064a63          	bltz	a2,80002d5c <__printf+0x524>
    8000292c:	00a00713          	li	a4,10
    80002930:	02e677bb          	remuw	a5,a2,a4
    80002934:	00002d97          	auipc	s11,0x2
    80002938:	854d8d93          	addi	s11,s11,-1964 # 80004188 <digits>
    8000293c:	00900593          	li	a1,9
    80002940:	0006051b          	sext.w	a0,a2
    80002944:	00000c93          	li	s9,0
    80002948:	02079793          	slli	a5,a5,0x20
    8000294c:	0207d793          	srli	a5,a5,0x20
    80002950:	00fd87b3          	add	a5,s11,a5
    80002954:	0007c783          	lbu	a5,0(a5)
    80002958:	02e656bb          	divuw	a3,a2,a4
    8000295c:	f8f40023          	sb	a5,-128(s0)
    80002960:	14c5d863          	bge	a1,a2,80002ab0 <__printf+0x278>
    80002964:	06300593          	li	a1,99
    80002968:	00100c93          	li	s9,1
    8000296c:	02e6f7bb          	remuw	a5,a3,a4
    80002970:	02079793          	slli	a5,a5,0x20
    80002974:	0207d793          	srli	a5,a5,0x20
    80002978:	00fd87b3          	add	a5,s11,a5
    8000297c:	0007c783          	lbu	a5,0(a5)
    80002980:	02e6d73b          	divuw	a4,a3,a4
    80002984:	f8f400a3          	sb	a5,-127(s0)
    80002988:	12a5f463          	bgeu	a1,a0,80002ab0 <__printf+0x278>
    8000298c:	00a00693          	li	a3,10
    80002990:	00900593          	li	a1,9
    80002994:	02d777bb          	remuw	a5,a4,a3
    80002998:	02079793          	slli	a5,a5,0x20
    8000299c:	0207d793          	srli	a5,a5,0x20
    800029a0:	00fd87b3          	add	a5,s11,a5
    800029a4:	0007c503          	lbu	a0,0(a5)
    800029a8:	02d757bb          	divuw	a5,a4,a3
    800029ac:	f8a40123          	sb	a0,-126(s0)
    800029b0:	48e5f263          	bgeu	a1,a4,80002e34 <__printf+0x5fc>
    800029b4:	06300513          	li	a0,99
    800029b8:	02d7f5bb          	remuw	a1,a5,a3
    800029bc:	02059593          	slli	a1,a1,0x20
    800029c0:	0205d593          	srli	a1,a1,0x20
    800029c4:	00bd85b3          	add	a1,s11,a1
    800029c8:	0005c583          	lbu	a1,0(a1)
    800029cc:	02d7d7bb          	divuw	a5,a5,a3
    800029d0:	f8b401a3          	sb	a1,-125(s0)
    800029d4:	48e57263          	bgeu	a0,a4,80002e58 <__printf+0x620>
    800029d8:	3e700513          	li	a0,999
    800029dc:	02d7f5bb          	remuw	a1,a5,a3
    800029e0:	02059593          	slli	a1,a1,0x20
    800029e4:	0205d593          	srli	a1,a1,0x20
    800029e8:	00bd85b3          	add	a1,s11,a1
    800029ec:	0005c583          	lbu	a1,0(a1)
    800029f0:	02d7d7bb          	divuw	a5,a5,a3
    800029f4:	f8b40223          	sb	a1,-124(s0)
    800029f8:	46e57663          	bgeu	a0,a4,80002e64 <__printf+0x62c>
    800029fc:	02d7f5bb          	remuw	a1,a5,a3
    80002a00:	02059593          	slli	a1,a1,0x20
    80002a04:	0205d593          	srli	a1,a1,0x20
    80002a08:	00bd85b3          	add	a1,s11,a1
    80002a0c:	0005c583          	lbu	a1,0(a1)
    80002a10:	02d7d7bb          	divuw	a5,a5,a3
    80002a14:	f8b402a3          	sb	a1,-123(s0)
    80002a18:	46ea7863          	bgeu	s4,a4,80002e88 <__printf+0x650>
    80002a1c:	02d7f5bb          	remuw	a1,a5,a3
    80002a20:	02059593          	slli	a1,a1,0x20
    80002a24:	0205d593          	srli	a1,a1,0x20
    80002a28:	00bd85b3          	add	a1,s11,a1
    80002a2c:	0005c583          	lbu	a1,0(a1)
    80002a30:	02d7d7bb          	divuw	a5,a5,a3
    80002a34:	f8b40323          	sb	a1,-122(s0)
    80002a38:	3eeaf863          	bgeu	s5,a4,80002e28 <__printf+0x5f0>
    80002a3c:	02d7f5bb          	remuw	a1,a5,a3
    80002a40:	02059593          	slli	a1,a1,0x20
    80002a44:	0205d593          	srli	a1,a1,0x20
    80002a48:	00bd85b3          	add	a1,s11,a1
    80002a4c:	0005c583          	lbu	a1,0(a1)
    80002a50:	02d7d7bb          	divuw	a5,a5,a3
    80002a54:	f8b403a3          	sb	a1,-121(s0)
    80002a58:	42eb7e63          	bgeu	s6,a4,80002e94 <__printf+0x65c>
    80002a5c:	02d7f5bb          	remuw	a1,a5,a3
    80002a60:	02059593          	slli	a1,a1,0x20
    80002a64:	0205d593          	srli	a1,a1,0x20
    80002a68:	00bd85b3          	add	a1,s11,a1
    80002a6c:	0005c583          	lbu	a1,0(a1)
    80002a70:	02d7d7bb          	divuw	a5,a5,a3
    80002a74:	f8b40423          	sb	a1,-120(s0)
    80002a78:	42ebfc63          	bgeu	s7,a4,80002eb0 <__printf+0x678>
    80002a7c:	02079793          	slli	a5,a5,0x20
    80002a80:	0207d793          	srli	a5,a5,0x20
    80002a84:	00fd8db3          	add	s11,s11,a5
    80002a88:	000dc703          	lbu	a4,0(s11)
    80002a8c:	00a00793          	li	a5,10
    80002a90:	00900c93          	li	s9,9
    80002a94:	f8e404a3          	sb	a4,-119(s0)
    80002a98:	00065c63          	bgez	a2,80002ab0 <__printf+0x278>
    80002a9c:	f9040713          	addi	a4,s0,-112
    80002aa0:	00f70733          	add	a4,a4,a5
    80002aa4:	02d00693          	li	a3,45
    80002aa8:	fed70823          	sb	a3,-16(a4)
    80002aac:	00078c93          	mv	s9,a5
    80002ab0:	f8040793          	addi	a5,s0,-128
    80002ab4:	01978cb3          	add	s9,a5,s9
    80002ab8:	f7f40d13          	addi	s10,s0,-129
    80002abc:	000cc503          	lbu	a0,0(s9)
    80002ac0:	fffc8c93          	addi	s9,s9,-1
    80002ac4:	00000097          	auipc	ra,0x0
    80002ac8:	b90080e7          	jalr	-1136(ra) # 80002654 <consputc>
    80002acc:	ffac98e3          	bne	s9,s10,80002abc <__printf+0x284>
    80002ad0:	00094503          	lbu	a0,0(s2)
    80002ad4:	e00514e3          	bnez	a0,800028dc <__printf+0xa4>
    80002ad8:	1a0c1663          	bnez	s8,80002c84 <__printf+0x44c>
    80002adc:	08813083          	ld	ra,136(sp)
    80002ae0:	08013403          	ld	s0,128(sp)
    80002ae4:	07813483          	ld	s1,120(sp)
    80002ae8:	07013903          	ld	s2,112(sp)
    80002aec:	06813983          	ld	s3,104(sp)
    80002af0:	06013a03          	ld	s4,96(sp)
    80002af4:	05813a83          	ld	s5,88(sp)
    80002af8:	05013b03          	ld	s6,80(sp)
    80002afc:	04813b83          	ld	s7,72(sp)
    80002b00:	04013c03          	ld	s8,64(sp)
    80002b04:	03813c83          	ld	s9,56(sp)
    80002b08:	03013d03          	ld	s10,48(sp)
    80002b0c:	02813d83          	ld	s11,40(sp)
    80002b10:	0d010113          	addi	sp,sp,208
    80002b14:	00008067          	ret
    80002b18:	07300713          	li	a4,115
    80002b1c:	1ce78a63          	beq	a5,a4,80002cf0 <__printf+0x4b8>
    80002b20:	07800713          	li	a4,120
    80002b24:	1ee79e63          	bne	a5,a4,80002d20 <__printf+0x4e8>
    80002b28:	f7843783          	ld	a5,-136(s0)
    80002b2c:	0007a703          	lw	a4,0(a5)
    80002b30:	00878793          	addi	a5,a5,8
    80002b34:	f6f43c23          	sd	a5,-136(s0)
    80002b38:	28074263          	bltz	a4,80002dbc <__printf+0x584>
    80002b3c:	00001d97          	auipc	s11,0x1
    80002b40:	64cd8d93          	addi	s11,s11,1612 # 80004188 <digits>
    80002b44:	00f77793          	andi	a5,a4,15
    80002b48:	00fd87b3          	add	a5,s11,a5
    80002b4c:	0007c683          	lbu	a3,0(a5)
    80002b50:	00f00613          	li	a2,15
    80002b54:	0007079b          	sext.w	a5,a4
    80002b58:	f8d40023          	sb	a3,-128(s0)
    80002b5c:	0047559b          	srliw	a1,a4,0x4
    80002b60:	0047569b          	srliw	a3,a4,0x4
    80002b64:	00000c93          	li	s9,0
    80002b68:	0ee65063          	bge	a2,a4,80002c48 <__printf+0x410>
    80002b6c:	00f6f693          	andi	a3,a3,15
    80002b70:	00dd86b3          	add	a3,s11,a3
    80002b74:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002b78:	0087d79b          	srliw	a5,a5,0x8
    80002b7c:	00100c93          	li	s9,1
    80002b80:	f8d400a3          	sb	a3,-127(s0)
    80002b84:	0cb67263          	bgeu	a2,a1,80002c48 <__printf+0x410>
    80002b88:	00f7f693          	andi	a3,a5,15
    80002b8c:	00dd86b3          	add	a3,s11,a3
    80002b90:	0006c583          	lbu	a1,0(a3)
    80002b94:	00f00613          	li	a2,15
    80002b98:	0047d69b          	srliw	a3,a5,0x4
    80002b9c:	f8b40123          	sb	a1,-126(s0)
    80002ba0:	0047d593          	srli	a1,a5,0x4
    80002ba4:	28f67e63          	bgeu	a2,a5,80002e40 <__printf+0x608>
    80002ba8:	00f6f693          	andi	a3,a3,15
    80002bac:	00dd86b3          	add	a3,s11,a3
    80002bb0:	0006c503          	lbu	a0,0(a3)
    80002bb4:	0087d813          	srli	a6,a5,0x8
    80002bb8:	0087d69b          	srliw	a3,a5,0x8
    80002bbc:	f8a401a3          	sb	a0,-125(s0)
    80002bc0:	28b67663          	bgeu	a2,a1,80002e4c <__printf+0x614>
    80002bc4:	00f6f693          	andi	a3,a3,15
    80002bc8:	00dd86b3          	add	a3,s11,a3
    80002bcc:	0006c583          	lbu	a1,0(a3)
    80002bd0:	00c7d513          	srli	a0,a5,0xc
    80002bd4:	00c7d69b          	srliw	a3,a5,0xc
    80002bd8:	f8b40223          	sb	a1,-124(s0)
    80002bdc:	29067a63          	bgeu	a2,a6,80002e70 <__printf+0x638>
    80002be0:	00f6f693          	andi	a3,a3,15
    80002be4:	00dd86b3          	add	a3,s11,a3
    80002be8:	0006c583          	lbu	a1,0(a3)
    80002bec:	0107d813          	srli	a6,a5,0x10
    80002bf0:	0107d69b          	srliw	a3,a5,0x10
    80002bf4:	f8b402a3          	sb	a1,-123(s0)
    80002bf8:	28a67263          	bgeu	a2,a0,80002e7c <__printf+0x644>
    80002bfc:	00f6f693          	andi	a3,a3,15
    80002c00:	00dd86b3          	add	a3,s11,a3
    80002c04:	0006c683          	lbu	a3,0(a3)
    80002c08:	0147d79b          	srliw	a5,a5,0x14
    80002c0c:	f8d40323          	sb	a3,-122(s0)
    80002c10:	21067663          	bgeu	a2,a6,80002e1c <__printf+0x5e4>
    80002c14:	02079793          	slli	a5,a5,0x20
    80002c18:	0207d793          	srli	a5,a5,0x20
    80002c1c:	00fd8db3          	add	s11,s11,a5
    80002c20:	000dc683          	lbu	a3,0(s11)
    80002c24:	00800793          	li	a5,8
    80002c28:	00700c93          	li	s9,7
    80002c2c:	f8d403a3          	sb	a3,-121(s0)
    80002c30:	00075c63          	bgez	a4,80002c48 <__printf+0x410>
    80002c34:	f9040713          	addi	a4,s0,-112
    80002c38:	00f70733          	add	a4,a4,a5
    80002c3c:	02d00693          	li	a3,45
    80002c40:	fed70823          	sb	a3,-16(a4)
    80002c44:	00078c93          	mv	s9,a5
    80002c48:	f8040793          	addi	a5,s0,-128
    80002c4c:	01978cb3          	add	s9,a5,s9
    80002c50:	f7f40d13          	addi	s10,s0,-129
    80002c54:	000cc503          	lbu	a0,0(s9)
    80002c58:	fffc8c93          	addi	s9,s9,-1
    80002c5c:	00000097          	auipc	ra,0x0
    80002c60:	9f8080e7          	jalr	-1544(ra) # 80002654 <consputc>
    80002c64:	ff9d18e3          	bne	s10,s9,80002c54 <__printf+0x41c>
    80002c68:	0100006f          	j	80002c78 <__printf+0x440>
    80002c6c:	00000097          	auipc	ra,0x0
    80002c70:	9e8080e7          	jalr	-1560(ra) # 80002654 <consputc>
    80002c74:	000c8493          	mv	s1,s9
    80002c78:	00094503          	lbu	a0,0(s2)
    80002c7c:	c60510e3          	bnez	a0,800028dc <__printf+0xa4>
    80002c80:	e40c0ee3          	beqz	s8,80002adc <__printf+0x2a4>
    80002c84:	00003517          	auipc	a0,0x3
    80002c88:	c4c50513          	addi	a0,a0,-948 # 800058d0 <pr>
    80002c8c:	00001097          	auipc	ra,0x1
    80002c90:	94c080e7          	jalr	-1716(ra) # 800035d8 <release>
    80002c94:	e49ff06f          	j	80002adc <__printf+0x2a4>
    80002c98:	f7843783          	ld	a5,-136(s0)
    80002c9c:	03000513          	li	a0,48
    80002ca0:	01000d13          	li	s10,16
    80002ca4:	00878713          	addi	a4,a5,8
    80002ca8:	0007bc83          	ld	s9,0(a5)
    80002cac:	f6e43c23          	sd	a4,-136(s0)
    80002cb0:	00000097          	auipc	ra,0x0
    80002cb4:	9a4080e7          	jalr	-1628(ra) # 80002654 <consputc>
    80002cb8:	07800513          	li	a0,120
    80002cbc:	00000097          	auipc	ra,0x0
    80002cc0:	998080e7          	jalr	-1640(ra) # 80002654 <consputc>
    80002cc4:	00001d97          	auipc	s11,0x1
    80002cc8:	4c4d8d93          	addi	s11,s11,1220 # 80004188 <digits>
    80002ccc:	03ccd793          	srli	a5,s9,0x3c
    80002cd0:	00fd87b3          	add	a5,s11,a5
    80002cd4:	0007c503          	lbu	a0,0(a5)
    80002cd8:	fffd0d1b          	addiw	s10,s10,-1
    80002cdc:	004c9c93          	slli	s9,s9,0x4
    80002ce0:	00000097          	auipc	ra,0x0
    80002ce4:	974080e7          	jalr	-1676(ra) # 80002654 <consputc>
    80002ce8:	fe0d12e3          	bnez	s10,80002ccc <__printf+0x494>
    80002cec:	f8dff06f          	j	80002c78 <__printf+0x440>
    80002cf0:	f7843783          	ld	a5,-136(s0)
    80002cf4:	0007bc83          	ld	s9,0(a5)
    80002cf8:	00878793          	addi	a5,a5,8
    80002cfc:	f6f43c23          	sd	a5,-136(s0)
    80002d00:	000c9a63          	bnez	s9,80002d14 <__printf+0x4dc>
    80002d04:	1080006f          	j	80002e0c <__printf+0x5d4>
    80002d08:	001c8c93          	addi	s9,s9,1
    80002d0c:	00000097          	auipc	ra,0x0
    80002d10:	948080e7          	jalr	-1720(ra) # 80002654 <consputc>
    80002d14:	000cc503          	lbu	a0,0(s9)
    80002d18:	fe0518e3          	bnez	a0,80002d08 <__printf+0x4d0>
    80002d1c:	f5dff06f          	j	80002c78 <__printf+0x440>
    80002d20:	02500513          	li	a0,37
    80002d24:	00000097          	auipc	ra,0x0
    80002d28:	930080e7          	jalr	-1744(ra) # 80002654 <consputc>
    80002d2c:	000c8513          	mv	a0,s9
    80002d30:	00000097          	auipc	ra,0x0
    80002d34:	924080e7          	jalr	-1756(ra) # 80002654 <consputc>
    80002d38:	f41ff06f          	j	80002c78 <__printf+0x440>
    80002d3c:	02500513          	li	a0,37
    80002d40:	00000097          	auipc	ra,0x0
    80002d44:	914080e7          	jalr	-1772(ra) # 80002654 <consputc>
    80002d48:	f31ff06f          	j	80002c78 <__printf+0x440>
    80002d4c:	00030513          	mv	a0,t1
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	7bc080e7          	jalr	1980(ra) # 8000350c <acquire>
    80002d58:	b4dff06f          	j	800028a4 <__printf+0x6c>
    80002d5c:	40c0053b          	negw	a0,a2
    80002d60:	00a00713          	li	a4,10
    80002d64:	02e576bb          	remuw	a3,a0,a4
    80002d68:	00001d97          	auipc	s11,0x1
    80002d6c:	420d8d93          	addi	s11,s11,1056 # 80004188 <digits>
    80002d70:	ff700593          	li	a1,-9
    80002d74:	02069693          	slli	a3,a3,0x20
    80002d78:	0206d693          	srli	a3,a3,0x20
    80002d7c:	00dd86b3          	add	a3,s11,a3
    80002d80:	0006c683          	lbu	a3,0(a3)
    80002d84:	02e557bb          	divuw	a5,a0,a4
    80002d88:	f8d40023          	sb	a3,-128(s0)
    80002d8c:	10b65e63          	bge	a2,a1,80002ea8 <__printf+0x670>
    80002d90:	06300593          	li	a1,99
    80002d94:	02e7f6bb          	remuw	a3,a5,a4
    80002d98:	02069693          	slli	a3,a3,0x20
    80002d9c:	0206d693          	srli	a3,a3,0x20
    80002da0:	00dd86b3          	add	a3,s11,a3
    80002da4:	0006c683          	lbu	a3,0(a3)
    80002da8:	02e7d73b          	divuw	a4,a5,a4
    80002dac:	00200793          	li	a5,2
    80002db0:	f8d400a3          	sb	a3,-127(s0)
    80002db4:	bca5ece3          	bltu	a1,a0,8000298c <__printf+0x154>
    80002db8:	ce5ff06f          	j	80002a9c <__printf+0x264>
    80002dbc:	40e007bb          	negw	a5,a4
    80002dc0:	00001d97          	auipc	s11,0x1
    80002dc4:	3c8d8d93          	addi	s11,s11,968 # 80004188 <digits>
    80002dc8:	00f7f693          	andi	a3,a5,15
    80002dcc:	00dd86b3          	add	a3,s11,a3
    80002dd0:	0006c583          	lbu	a1,0(a3)
    80002dd4:	ff100613          	li	a2,-15
    80002dd8:	0047d69b          	srliw	a3,a5,0x4
    80002ddc:	f8b40023          	sb	a1,-128(s0)
    80002de0:	0047d59b          	srliw	a1,a5,0x4
    80002de4:	0ac75e63          	bge	a4,a2,80002ea0 <__printf+0x668>
    80002de8:	00f6f693          	andi	a3,a3,15
    80002dec:	00dd86b3          	add	a3,s11,a3
    80002df0:	0006c603          	lbu	a2,0(a3)
    80002df4:	00f00693          	li	a3,15
    80002df8:	0087d79b          	srliw	a5,a5,0x8
    80002dfc:	f8c400a3          	sb	a2,-127(s0)
    80002e00:	d8b6e4e3          	bltu	a3,a1,80002b88 <__printf+0x350>
    80002e04:	00200793          	li	a5,2
    80002e08:	e2dff06f          	j	80002c34 <__printf+0x3fc>
    80002e0c:	00001c97          	auipc	s9,0x1
    80002e10:	35cc8c93          	addi	s9,s9,860 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    80002e14:	02800513          	li	a0,40
    80002e18:	ef1ff06f          	j	80002d08 <__printf+0x4d0>
    80002e1c:	00700793          	li	a5,7
    80002e20:	00600c93          	li	s9,6
    80002e24:	e0dff06f          	j	80002c30 <__printf+0x3f8>
    80002e28:	00700793          	li	a5,7
    80002e2c:	00600c93          	li	s9,6
    80002e30:	c69ff06f          	j	80002a98 <__printf+0x260>
    80002e34:	00300793          	li	a5,3
    80002e38:	00200c93          	li	s9,2
    80002e3c:	c5dff06f          	j	80002a98 <__printf+0x260>
    80002e40:	00300793          	li	a5,3
    80002e44:	00200c93          	li	s9,2
    80002e48:	de9ff06f          	j	80002c30 <__printf+0x3f8>
    80002e4c:	00400793          	li	a5,4
    80002e50:	00300c93          	li	s9,3
    80002e54:	dddff06f          	j	80002c30 <__printf+0x3f8>
    80002e58:	00400793          	li	a5,4
    80002e5c:	00300c93          	li	s9,3
    80002e60:	c39ff06f          	j	80002a98 <__printf+0x260>
    80002e64:	00500793          	li	a5,5
    80002e68:	00400c93          	li	s9,4
    80002e6c:	c2dff06f          	j	80002a98 <__printf+0x260>
    80002e70:	00500793          	li	a5,5
    80002e74:	00400c93          	li	s9,4
    80002e78:	db9ff06f          	j	80002c30 <__printf+0x3f8>
    80002e7c:	00600793          	li	a5,6
    80002e80:	00500c93          	li	s9,5
    80002e84:	dadff06f          	j	80002c30 <__printf+0x3f8>
    80002e88:	00600793          	li	a5,6
    80002e8c:	00500c93          	li	s9,5
    80002e90:	c09ff06f          	j	80002a98 <__printf+0x260>
    80002e94:	00800793          	li	a5,8
    80002e98:	00700c93          	li	s9,7
    80002e9c:	bfdff06f          	j	80002a98 <__printf+0x260>
    80002ea0:	00100793          	li	a5,1
    80002ea4:	d91ff06f          	j	80002c34 <__printf+0x3fc>
    80002ea8:	00100793          	li	a5,1
    80002eac:	bf1ff06f          	j	80002a9c <__printf+0x264>
    80002eb0:	00900793          	li	a5,9
    80002eb4:	00800c93          	li	s9,8
    80002eb8:	be1ff06f          	j	80002a98 <__printf+0x260>
    80002ebc:	00001517          	auipc	a0,0x1
    80002ec0:	2b450513          	addi	a0,a0,692 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002ec4:	00000097          	auipc	ra,0x0
    80002ec8:	918080e7          	jalr	-1768(ra) # 800027dc <panic>

0000000080002ecc <printfinit>:
    80002ecc:	fe010113          	addi	sp,sp,-32
    80002ed0:	00813823          	sd	s0,16(sp)
    80002ed4:	00913423          	sd	s1,8(sp)
    80002ed8:	00113c23          	sd	ra,24(sp)
    80002edc:	02010413          	addi	s0,sp,32
    80002ee0:	00003497          	auipc	s1,0x3
    80002ee4:	9f048493          	addi	s1,s1,-1552 # 800058d0 <pr>
    80002ee8:	00048513          	mv	a0,s1
    80002eec:	00001597          	auipc	a1,0x1
    80002ef0:	29458593          	addi	a1,a1,660 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    80002ef4:	00000097          	auipc	ra,0x0
    80002ef8:	5f4080e7          	jalr	1524(ra) # 800034e8 <initlock>
    80002efc:	01813083          	ld	ra,24(sp)
    80002f00:	01013403          	ld	s0,16(sp)
    80002f04:	0004ac23          	sw	zero,24(s1)
    80002f08:	00813483          	ld	s1,8(sp)
    80002f0c:	02010113          	addi	sp,sp,32
    80002f10:	00008067          	ret

0000000080002f14 <uartinit>:
    80002f14:	ff010113          	addi	sp,sp,-16
    80002f18:	00813423          	sd	s0,8(sp)
    80002f1c:	01010413          	addi	s0,sp,16
    80002f20:	100007b7          	lui	a5,0x10000
    80002f24:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002f28:	f8000713          	li	a4,-128
    80002f2c:	00e781a3          	sb	a4,3(a5)
    80002f30:	00300713          	li	a4,3
    80002f34:	00e78023          	sb	a4,0(a5)
    80002f38:	000780a3          	sb	zero,1(a5)
    80002f3c:	00e781a3          	sb	a4,3(a5)
    80002f40:	00700693          	li	a3,7
    80002f44:	00d78123          	sb	a3,2(a5)
    80002f48:	00e780a3          	sb	a4,1(a5)
    80002f4c:	00813403          	ld	s0,8(sp)
    80002f50:	01010113          	addi	sp,sp,16
    80002f54:	00008067          	ret

0000000080002f58 <uartputc>:
    80002f58:	00001797          	auipc	a5,0x1
    80002f5c:	7007a783          	lw	a5,1792(a5) # 80004658 <panicked>
    80002f60:	00078463          	beqz	a5,80002f68 <uartputc+0x10>
    80002f64:	0000006f          	j	80002f64 <uartputc+0xc>
    80002f68:	fd010113          	addi	sp,sp,-48
    80002f6c:	02813023          	sd	s0,32(sp)
    80002f70:	00913c23          	sd	s1,24(sp)
    80002f74:	01213823          	sd	s2,16(sp)
    80002f78:	01313423          	sd	s3,8(sp)
    80002f7c:	02113423          	sd	ra,40(sp)
    80002f80:	03010413          	addi	s0,sp,48
    80002f84:	00001917          	auipc	s2,0x1
    80002f88:	6dc90913          	addi	s2,s2,1756 # 80004660 <uart_tx_r>
    80002f8c:	00093783          	ld	a5,0(s2)
    80002f90:	00001497          	auipc	s1,0x1
    80002f94:	6d848493          	addi	s1,s1,1752 # 80004668 <uart_tx_w>
    80002f98:	0004b703          	ld	a4,0(s1)
    80002f9c:	02078693          	addi	a3,a5,32
    80002fa0:	00050993          	mv	s3,a0
    80002fa4:	02e69c63          	bne	a3,a4,80002fdc <uartputc+0x84>
    80002fa8:	00001097          	auipc	ra,0x1
    80002fac:	834080e7          	jalr	-1996(ra) # 800037dc <push_on>
    80002fb0:	00093783          	ld	a5,0(s2)
    80002fb4:	0004b703          	ld	a4,0(s1)
    80002fb8:	02078793          	addi	a5,a5,32
    80002fbc:	00e79463          	bne	a5,a4,80002fc4 <uartputc+0x6c>
    80002fc0:	0000006f          	j	80002fc0 <uartputc+0x68>
    80002fc4:	00001097          	auipc	ra,0x1
    80002fc8:	88c080e7          	jalr	-1908(ra) # 80003850 <pop_on>
    80002fcc:	00093783          	ld	a5,0(s2)
    80002fd0:	0004b703          	ld	a4,0(s1)
    80002fd4:	02078693          	addi	a3,a5,32
    80002fd8:	fce688e3          	beq	a3,a4,80002fa8 <uartputc+0x50>
    80002fdc:	01f77693          	andi	a3,a4,31
    80002fe0:	00003597          	auipc	a1,0x3
    80002fe4:	91058593          	addi	a1,a1,-1776 # 800058f0 <uart_tx_buf>
    80002fe8:	00d586b3          	add	a3,a1,a3
    80002fec:	00170713          	addi	a4,a4,1
    80002ff0:	01368023          	sb	s3,0(a3)
    80002ff4:	00e4b023          	sd	a4,0(s1)
    80002ff8:	10000637          	lui	a2,0x10000
    80002ffc:	02f71063          	bne	a4,a5,8000301c <uartputc+0xc4>
    80003000:	0340006f          	j	80003034 <uartputc+0xdc>
    80003004:	00074703          	lbu	a4,0(a4)
    80003008:	00f93023          	sd	a5,0(s2)
    8000300c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003010:	00093783          	ld	a5,0(s2)
    80003014:	0004b703          	ld	a4,0(s1)
    80003018:	00f70e63          	beq	a4,a5,80003034 <uartputc+0xdc>
    8000301c:	00564683          	lbu	a3,5(a2)
    80003020:	01f7f713          	andi	a4,a5,31
    80003024:	00e58733          	add	a4,a1,a4
    80003028:	0206f693          	andi	a3,a3,32
    8000302c:	00178793          	addi	a5,a5,1
    80003030:	fc069ae3          	bnez	a3,80003004 <uartputc+0xac>
    80003034:	02813083          	ld	ra,40(sp)
    80003038:	02013403          	ld	s0,32(sp)
    8000303c:	01813483          	ld	s1,24(sp)
    80003040:	01013903          	ld	s2,16(sp)
    80003044:	00813983          	ld	s3,8(sp)
    80003048:	03010113          	addi	sp,sp,48
    8000304c:	00008067          	ret

0000000080003050 <uartputc_sync>:
    80003050:	ff010113          	addi	sp,sp,-16
    80003054:	00813423          	sd	s0,8(sp)
    80003058:	01010413          	addi	s0,sp,16
    8000305c:	00001717          	auipc	a4,0x1
    80003060:	5fc72703          	lw	a4,1532(a4) # 80004658 <panicked>
    80003064:	02071663          	bnez	a4,80003090 <uartputc_sync+0x40>
    80003068:	00050793          	mv	a5,a0
    8000306c:	100006b7          	lui	a3,0x10000
    80003070:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003074:	02077713          	andi	a4,a4,32
    80003078:	fe070ce3          	beqz	a4,80003070 <uartputc_sync+0x20>
    8000307c:	0ff7f793          	andi	a5,a5,255
    80003080:	00f68023          	sb	a5,0(a3)
    80003084:	00813403          	ld	s0,8(sp)
    80003088:	01010113          	addi	sp,sp,16
    8000308c:	00008067          	ret
    80003090:	0000006f          	j	80003090 <uartputc_sync+0x40>

0000000080003094 <uartstart>:
    80003094:	ff010113          	addi	sp,sp,-16
    80003098:	00813423          	sd	s0,8(sp)
    8000309c:	01010413          	addi	s0,sp,16
    800030a0:	00001617          	auipc	a2,0x1
    800030a4:	5c060613          	addi	a2,a2,1472 # 80004660 <uart_tx_r>
    800030a8:	00001517          	auipc	a0,0x1
    800030ac:	5c050513          	addi	a0,a0,1472 # 80004668 <uart_tx_w>
    800030b0:	00063783          	ld	a5,0(a2)
    800030b4:	00053703          	ld	a4,0(a0)
    800030b8:	04f70263          	beq	a4,a5,800030fc <uartstart+0x68>
    800030bc:	100005b7          	lui	a1,0x10000
    800030c0:	00003817          	auipc	a6,0x3
    800030c4:	83080813          	addi	a6,a6,-2000 # 800058f0 <uart_tx_buf>
    800030c8:	01c0006f          	j	800030e4 <uartstart+0x50>
    800030cc:	0006c703          	lbu	a4,0(a3)
    800030d0:	00f63023          	sd	a5,0(a2)
    800030d4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800030d8:	00063783          	ld	a5,0(a2)
    800030dc:	00053703          	ld	a4,0(a0)
    800030e0:	00f70e63          	beq	a4,a5,800030fc <uartstart+0x68>
    800030e4:	01f7f713          	andi	a4,a5,31
    800030e8:	00e806b3          	add	a3,a6,a4
    800030ec:	0055c703          	lbu	a4,5(a1)
    800030f0:	00178793          	addi	a5,a5,1
    800030f4:	02077713          	andi	a4,a4,32
    800030f8:	fc071ae3          	bnez	a4,800030cc <uartstart+0x38>
    800030fc:	00813403          	ld	s0,8(sp)
    80003100:	01010113          	addi	sp,sp,16
    80003104:	00008067          	ret

0000000080003108 <uartgetc>:
    80003108:	ff010113          	addi	sp,sp,-16
    8000310c:	00813423          	sd	s0,8(sp)
    80003110:	01010413          	addi	s0,sp,16
    80003114:	10000737          	lui	a4,0x10000
    80003118:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000311c:	0017f793          	andi	a5,a5,1
    80003120:	00078c63          	beqz	a5,80003138 <uartgetc+0x30>
    80003124:	00074503          	lbu	a0,0(a4)
    80003128:	0ff57513          	andi	a0,a0,255
    8000312c:	00813403          	ld	s0,8(sp)
    80003130:	01010113          	addi	sp,sp,16
    80003134:	00008067          	ret
    80003138:	fff00513          	li	a0,-1
    8000313c:	ff1ff06f          	j	8000312c <uartgetc+0x24>

0000000080003140 <uartintr>:
    80003140:	100007b7          	lui	a5,0x10000
    80003144:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003148:	0017f793          	andi	a5,a5,1
    8000314c:	0a078463          	beqz	a5,800031f4 <uartintr+0xb4>
    80003150:	fe010113          	addi	sp,sp,-32
    80003154:	00813823          	sd	s0,16(sp)
    80003158:	00913423          	sd	s1,8(sp)
    8000315c:	00113c23          	sd	ra,24(sp)
    80003160:	02010413          	addi	s0,sp,32
    80003164:	100004b7          	lui	s1,0x10000
    80003168:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000316c:	0ff57513          	andi	a0,a0,255
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	534080e7          	jalr	1332(ra) # 800026a4 <consoleintr>
    80003178:	0054c783          	lbu	a5,5(s1)
    8000317c:	0017f793          	andi	a5,a5,1
    80003180:	fe0794e3          	bnez	a5,80003168 <uartintr+0x28>
    80003184:	00001617          	auipc	a2,0x1
    80003188:	4dc60613          	addi	a2,a2,1244 # 80004660 <uart_tx_r>
    8000318c:	00001517          	auipc	a0,0x1
    80003190:	4dc50513          	addi	a0,a0,1244 # 80004668 <uart_tx_w>
    80003194:	00063783          	ld	a5,0(a2)
    80003198:	00053703          	ld	a4,0(a0)
    8000319c:	04f70263          	beq	a4,a5,800031e0 <uartintr+0xa0>
    800031a0:	100005b7          	lui	a1,0x10000
    800031a4:	00002817          	auipc	a6,0x2
    800031a8:	74c80813          	addi	a6,a6,1868 # 800058f0 <uart_tx_buf>
    800031ac:	01c0006f          	j	800031c8 <uartintr+0x88>
    800031b0:	0006c703          	lbu	a4,0(a3)
    800031b4:	00f63023          	sd	a5,0(a2)
    800031b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800031bc:	00063783          	ld	a5,0(a2)
    800031c0:	00053703          	ld	a4,0(a0)
    800031c4:	00f70e63          	beq	a4,a5,800031e0 <uartintr+0xa0>
    800031c8:	01f7f713          	andi	a4,a5,31
    800031cc:	00e806b3          	add	a3,a6,a4
    800031d0:	0055c703          	lbu	a4,5(a1)
    800031d4:	00178793          	addi	a5,a5,1
    800031d8:	02077713          	andi	a4,a4,32
    800031dc:	fc071ae3          	bnez	a4,800031b0 <uartintr+0x70>
    800031e0:	01813083          	ld	ra,24(sp)
    800031e4:	01013403          	ld	s0,16(sp)
    800031e8:	00813483          	ld	s1,8(sp)
    800031ec:	02010113          	addi	sp,sp,32
    800031f0:	00008067          	ret
    800031f4:	00001617          	auipc	a2,0x1
    800031f8:	46c60613          	addi	a2,a2,1132 # 80004660 <uart_tx_r>
    800031fc:	00001517          	auipc	a0,0x1
    80003200:	46c50513          	addi	a0,a0,1132 # 80004668 <uart_tx_w>
    80003204:	00063783          	ld	a5,0(a2)
    80003208:	00053703          	ld	a4,0(a0)
    8000320c:	04f70263          	beq	a4,a5,80003250 <uartintr+0x110>
    80003210:	100005b7          	lui	a1,0x10000
    80003214:	00002817          	auipc	a6,0x2
    80003218:	6dc80813          	addi	a6,a6,1756 # 800058f0 <uart_tx_buf>
    8000321c:	01c0006f          	j	80003238 <uartintr+0xf8>
    80003220:	0006c703          	lbu	a4,0(a3)
    80003224:	00f63023          	sd	a5,0(a2)
    80003228:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000322c:	00063783          	ld	a5,0(a2)
    80003230:	00053703          	ld	a4,0(a0)
    80003234:	02f70063          	beq	a4,a5,80003254 <uartintr+0x114>
    80003238:	01f7f713          	andi	a4,a5,31
    8000323c:	00e806b3          	add	a3,a6,a4
    80003240:	0055c703          	lbu	a4,5(a1)
    80003244:	00178793          	addi	a5,a5,1
    80003248:	02077713          	andi	a4,a4,32
    8000324c:	fc071ae3          	bnez	a4,80003220 <uartintr+0xe0>
    80003250:	00008067          	ret
    80003254:	00008067          	ret

0000000080003258 <kinit>:
    80003258:	fc010113          	addi	sp,sp,-64
    8000325c:	02913423          	sd	s1,40(sp)
    80003260:	fffff7b7          	lui	a5,0xfffff
    80003264:	00003497          	auipc	s1,0x3
    80003268:	6ab48493          	addi	s1,s1,1707 # 8000690f <end+0xfff>
    8000326c:	02813823          	sd	s0,48(sp)
    80003270:	01313c23          	sd	s3,24(sp)
    80003274:	00f4f4b3          	and	s1,s1,a5
    80003278:	02113c23          	sd	ra,56(sp)
    8000327c:	03213023          	sd	s2,32(sp)
    80003280:	01413823          	sd	s4,16(sp)
    80003284:	01513423          	sd	s5,8(sp)
    80003288:	04010413          	addi	s0,sp,64
    8000328c:	000017b7          	lui	a5,0x1
    80003290:	01100993          	li	s3,17
    80003294:	00f487b3          	add	a5,s1,a5
    80003298:	01b99993          	slli	s3,s3,0x1b
    8000329c:	06f9e063          	bltu	s3,a5,800032fc <kinit+0xa4>
    800032a0:	00002a97          	auipc	s5,0x2
    800032a4:	670a8a93          	addi	s5,s5,1648 # 80005910 <end>
    800032a8:	0754ec63          	bltu	s1,s5,80003320 <kinit+0xc8>
    800032ac:	0734fa63          	bgeu	s1,s3,80003320 <kinit+0xc8>
    800032b0:	00088a37          	lui	s4,0x88
    800032b4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800032b8:	00001917          	auipc	s2,0x1
    800032bc:	3b890913          	addi	s2,s2,952 # 80004670 <kmem>
    800032c0:	00ca1a13          	slli	s4,s4,0xc
    800032c4:	0140006f          	j	800032d8 <kinit+0x80>
    800032c8:	000017b7          	lui	a5,0x1
    800032cc:	00f484b3          	add	s1,s1,a5
    800032d0:	0554e863          	bltu	s1,s5,80003320 <kinit+0xc8>
    800032d4:	0534f663          	bgeu	s1,s3,80003320 <kinit+0xc8>
    800032d8:	00001637          	lui	a2,0x1
    800032dc:	00100593          	li	a1,1
    800032e0:	00048513          	mv	a0,s1
    800032e4:	00000097          	auipc	ra,0x0
    800032e8:	5e4080e7          	jalr	1508(ra) # 800038c8 <__memset>
    800032ec:	00093783          	ld	a5,0(s2)
    800032f0:	00f4b023          	sd	a5,0(s1)
    800032f4:	00993023          	sd	s1,0(s2)
    800032f8:	fd4498e3          	bne	s1,s4,800032c8 <kinit+0x70>
    800032fc:	03813083          	ld	ra,56(sp)
    80003300:	03013403          	ld	s0,48(sp)
    80003304:	02813483          	ld	s1,40(sp)
    80003308:	02013903          	ld	s2,32(sp)
    8000330c:	01813983          	ld	s3,24(sp)
    80003310:	01013a03          	ld	s4,16(sp)
    80003314:	00813a83          	ld	s5,8(sp)
    80003318:	04010113          	addi	sp,sp,64
    8000331c:	00008067          	ret
    80003320:	00001517          	auipc	a0,0x1
    80003324:	e8050513          	addi	a0,a0,-384 # 800041a0 <digits+0x18>
    80003328:	fffff097          	auipc	ra,0xfffff
    8000332c:	4b4080e7          	jalr	1204(ra) # 800027dc <panic>

0000000080003330 <freerange>:
    80003330:	fc010113          	addi	sp,sp,-64
    80003334:	000017b7          	lui	a5,0x1
    80003338:	02913423          	sd	s1,40(sp)
    8000333c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003340:	009504b3          	add	s1,a0,s1
    80003344:	fffff537          	lui	a0,0xfffff
    80003348:	02813823          	sd	s0,48(sp)
    8000334c:	02113c23          	sd	ra,56(sp)
    80003350:	03213023          	sd	s2,32(sp)
    80003354:	01313c23          	sd	s3,24(sp)
    80003358:	01413823          	sd	s4,16(sp)
    8000335c:	01513423          	sd	s5,8(sp)
    80003360:	01613023          	sd	s6,0(sp)
    80003364:	04010413          	addi	s0,sp,64
    80003368:	00a4f4b3          	and	s1,s1,a0
    8000336c:	00f487b3          	add	a5,s1,a5
    80003370:	06f5e463          	bltu	a1,a5,800033d8 <freerange+0xa8>
    80003374:	00002a97          	auipc	s5,0x2
    80003378:	59ca8a93          	addi	s5,s5,1436 # 80005910 <end>
    8000337c:	0954e263          	bltu	s1,s5,80003400 <freerange+0xd0>
    80003380:	01100993          	li	s3,17
    80003384:	01b99993          	slli	s3,s3,0x1b
    80003388:	0734fc63          	bgeu	s1,s3,80003400 <freerange+0xd0>
    8000338c:	00058a13          	mv	s4,a1
    80003390:	00001917          	auipc	s2,0x1
    80003394:	2e090913          	addi	s2,s2,736 # 80004670 <kmem>
    80003398:	00002b37          	lui	s6,0x2
    8000339c:	0140006f          	j	800033b0 <freerange+0x80>
    800033a0:	000017b7          	lui	a5,0x1
    800033a4:	00f484b3          	add	s1,s1,a5
    800033a8:	0554ec63          	bltu	s1,s5,80003400 <freerange+0xd0>
    800033ac:	0534fa63          	bgeu	s1,s3,80003400 <freerange+0xd0>
    800033b0:	00001637          	lui	a2,0x1
    800033b4:	00100593          	li	a1,1
    800033b8:	00048513          	mv	a0,s1
    800033bc:	00000097          	auipc	ra,0x0
    800033c0:	50c080e7          	jalr	1292(ra) # 800038c8 <__memset>
    800033c4:	00093703          	ld	a4,0(s2)
    800033c8:	016487b3          	add	a5,s1,s6
    800033cc:	00e4b023          	sd	a4,0(s1)
    800033d0:	00993023          	sd	s1,0(s2)
    800033d4:	fcfa76e3          	bgeu	s4,a5,800033a0 <freerange+0x70>
    800033d8:	03813083          	ld	ra,56(sp)
    800033dc:	03013403          	ld	s0,48(sp)
    800033e0:	02813483          	ld	s1,40(sp)
    800033e4:	02013903          	ld	s2,32(sp)
    800033e8:	01813983          	ld	s3,24(sp)
    800033ec:	01013a03          	ld	s4,16(sp)
    800033f0:	00813a83          	ld	s5,8(sp)
    800033f4:	00013b03          	ld	s6,0(sp)
    800033f8:	04010113          	addi	sp,sp,64
    800033fc:	00008067          	ret
    80003400:	00001517          	auipc	a0,0x1
    80003404:	da050513          	addi	a0,a0,-608 # 800041a0 <digits+0x18>
    80003408:	fffff097          	auipc	ra,0xfffff
    8000340c:	3d4080e7          	jalr	980(ra) # 800027dc <panic>

0000000080003410 <kfree>:
    80003410:	fe010113          	addi	sp,sp,-32
    80003414:	00813823          	sd	s0,16(sp)
    80003418:	00113c23          	sd	ra,24(sp)
    8000341c:	00913423          	sd	s1,8(sp)
    80003420:	02010413          	addi	s0,sp,32
    80003424:	03451793          	slli	a5,a0,0x34
    80003428:	04079c63          	bnez	a5,80003480 <kfree+0x70>
    8000342c:	00002797          	auipc	a5,0x2
    80003430:	4e478793          	addi	a5,a5,1252 # 80005910 <end>
    80003434:	00050493          	mv	s1,a0
    80003438:	04f56463          	bltu	a0,a5,80003480 <kfree+0x70>
    8000343c:	01100793          	li	a5,17
    80003440:	01b79793          	slli	a5,a5,0x1b
    80003444:	02f57e63          	bgeu	a0,a5,80003480 <kfree+0x70>
    80003448:	00001637          	lui	a2,0x1
    8000344c:	00100593          	li	a1,1
    80003450:	00000097          	auipc	ra,0x0
    80003454:	478080e7          	jalr	1144(ra) # 800038c8 <__memset>
    80003458:	00001797          	auipc	a5,0x1
    8000345c:	21878793          	addi	a5,a5,536 # 80004670 <kmem>
    80003460:	0007b703          	ld	a4,0(a5)
    80003464:	01813083          	ld	ra,24(sp)
    80003468:	01013403          	ld	s0,16(sp)
    8000346c:	00e4b023          	sd	a4,0(s1)
    80003470:	0097b023          	sd	s1,0(a5)
    80003474:	00813483          	ld	s1,8(sp)
    80003478:	02010113          	addi	sp,sp,32
    8000347c:	00008067          	ret
    80003480:	00001517          	auipc	a0,0x1
    80003484:	d2050513          	addi	a0,a0,-736 # 800041a0 <digits+0x18>
    80003488:	fffff097          	auipc	ra,0xfffff
    8000348c:	354080e7          	jalr	852(ra) # 800027dc <panic>

0000000080003490 <kalloc>:
    80003490:	fe010113          	addi	sp,sp,-32
    80003494:	00813823          	sd	s0,16(sp)
    80003498:	00913423          	sd	s1,8(sp)
    8000349c:	00113c23          	sd	ra,24(sp)
    800034a0:	02010413          	addi	s0,sp,32
    800034a4:	00001797          	auipc	a5,0x1
    800034a8:	1cc78793          	addi	a5,a5,460 # 80004670 <kmem>
    800034ac:	0007b483          	ld	s1,0(a5)
    800034b0:	02048063          	beqz	s1,800034d0 <kalloc+0x40>
    800034b4:	0004b703          	ld	a4,0(s1)
    800034b8:	00001637          	lui	a2,0x1
    800034bc:	00500593          	li	a1,5
    800034c0:	00048513          	mv	a0,s1
    800034c4:	00e7b023          	sd	a4,0(a5)
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	400080e7          	jalr	1024(ra) # 800038c8 <__memset>
    800034d0:	01813083          	ld	ra,24(sp)
    800034d4:	01013403          	ld	s0,16(sp)
    800034d8:	00048513          	mv	a0,s1
    800034dc:	00813483          	ld	s1,8(sp)
    800034e0:	02010113          	addi	sp,sp,32
    800034e4:	00008067          	ret

00000000800034e8 <initlock>:
    800034e8:	ff010113          	addi	sp,sp,-16
    800034ec:	00813423          	sd	s0,8(sp)
    800034f0:	01010413          	addi	s0,sp,16
    800034f4:	00813403          	ld	s0,8(sp)
    800034f8:	00b53423          	sd	a1,8(a0)
    800034fc:	00052023          	sw	zero,0(a0)
    80003500:	00053823          	sd	zero,16(a0)
    80003504:	01010113          	addi	sp,sp,16
    80003508:	00008067          	ret

000000008000350c <acquire>:
    8000350c:	fe010113          	addi	sp,sp,-32
    80003510:	00813823          	sd	s0,16(sp)
    80003514:	00913423          	sd	s1,8(sp)
    80003518:	00113c23          	sd	ra,24(sp)
    8000351c:	01213023          	sd	s2,0(sp)
    80003520:	02010413          	addi	s0,sp,32
    80003524:	00050493          	mv	s1,a0
    80003528:	10002973          	csrr	s2,sstatus
    8000352c:	100027f3          	csrr	a5,sstatus
    80003530:	ffd7f793          	andi	a5,a5,-3
    80003534:	10079073          	csrw	sstatus,a5
    80003538:	fffff097          	auipc	ra,0xfffff
    8000353c:	8e4080e7          	jalr	-1820(ra) # 80001e1c <mycpu>
    80003540:	07852783          	lw	a5,120(a0)
    80003544:	06078e63          	beqz	a5,800035c0 <acquire+0xb4>
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	8d4080e7          	jalr	-1836(ra) # 80001e1c <mycpu>
    80003550:	07852783          	lw	a5,120(a0)
    80003554:	0004a703          	lw	a4,0(s1)
    80003558:	0017879b          	addiw	a5,a5,1
    8000355c:	06f52c23          	sw	a5,120(a0)
    80003560:	04071063          	bnez	a4,800035a0 <acquire+0x94>
    80003564:	00100713          	li	a4,1
    80003568:	00070793          	mv	a5,a4
    8000356c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003570:	0007879b          	sext.w	a5,a5
    80003574:	fe079ae3          	bnez	a5,80003568 <acquire+0x5c>
    80003578:	0ff0000f          	fence
    8000357c:	fffff097          	auipc	ra,0xfffff
    80003580:	8a0080e7          	jalr	-1888(ra) # 80001e1c <mycpu>
    80003584:	01813083          	ld	ra,24(sp)
    80003588:	01013403          	ld	s0,16(sp)
    8000358c:	00a4b823          	sd	a0,16(s1)
    80003590:	00013903          	ld	s2,0(sp)
    80003594:	00813483          	ld	s1,8(sp)
    80003598:	02010113          	addi	sp,sp,32
    8000359c:	00008067          	ret
    800035a0:	0104b903          	ld	s2,16(s1)
    800035a4:	fffff097          	auipc	ra,0xfffff
    800035a8:	878080e7          	jalr	-1928(ra) # 80001e1c <mycpu>
    800035ac:	faa91ce3          	bne	s2,a0,80003564 <acquire+0x58>
    800035b0:	00001517          	auipc	a0,0x1
    800035b4:	bf850513          	addi	a0,a0,-1032 # 800041a8 <digits+0x20>
    800035b8:	fffff097          	auipc	ra,0xfffff
    800035bc:	224080e7          	jalr	548(ra) # 800027dc <panic>
    800035c0:	00195913          	srli	s2,s2,0x1
    800035c4:	fffff097          	auipc	ra,0xfffff
    800035c8:	858080e7          	jalr	-1960(ra) # 80001e1c <mycpu>
    800035cc:	00197913          	andi	s2,s2,1
    800035d0:	07252e23          	sw	s2,124(a0)
    800035d4:	f75ff06f          	j	80003548 <acquire+0x3c>

00000000800035d8 <release>:
    800035d8:	fe010113          	addi	sp,sp,-32
    800035dc:	00813823          	sd	s0,16(sp)
    800035e0:	00113c23          	sd	ra,24(sp)
    800035e4:	00913423          	sd	s1,8(sp)
    800035e8:	01213023          	sd	s2,0(sp)
    800035ec:	02010413          	addi	s0,sp,32
    800035f0:	00052783          	lw	a5,0(a0)
    800035f4:	00079a63          	bnez	a5,80003608 <release+0x30>
    800035f8:	00001517          	auipc	a0,0x1
    800035fc:	bb850513          	addi	a0,a0,-1096 # 800041b0 <digits+0x28>
    80003600:	fffff097          	auipc	ra,0xfffff
    80003604:	1dc080e7          	jalr	476(ra) # 800027dc <panic>
    80003608:	01053903          	ld	s2,16(a0)
    8000360c:	00050493          	mv	s1,a0
    80003610:	fffff097          	auipc	ra,0xfffff
    80003614:	80c080e7          	jalr	-2036(ra) # 80001e1c <mycpu>
    80003618:	fea910e3          	bne	s2,a0,800035f8 <release+0x20>
    8000361c:	0004b823          	sd	zero,16(s1)
    80003620:	0ff0000f          	fence
    80003624:	0f50000f          	fence	iorw,ow
    80003628:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000362c:	ffffe097          	auipc	ra,0xffffe
    80003630:	7f0080e7          	jalr	2032(ra) # 80001e1c <mycpu>
    80003634:	100027f3          	csrr	a5,sstatus
    80003638:	0027f793          	andi	a5,a5,2
    8000363c:	04079a63          	bnez	a5,80003690 <release+0xb8>
    80003640:	07852783          	lw	a5,120(a0)
    80003644:	02f05e63          	blez	a5,80003680 <release+0xa8>
    80003648:	fff7871b          	addiw	a4,a5,-1
    8000364c:	06e52c23          	sw	a4,120(a0)
    80003650:	00071c63          	bnez	a4,80003668 <release+0x90>
    80003654:	07c52783          	lw	a5,124(a0)
    80003658:	00078863          	beqz	a5,80003668 <release+0x90>
    8000365c:	100027f3          	csrr	a5,sstatus
    80003660:	0027e793          	ori	a5,a5,2
    80003664:	10079073          	csrw	sstatus,a5
    80003668:	01813083          	ld	ra,24(sp)
    8000366c:	01013403          	ld	s0,16(sp)
    80003670:	00813483          	ld	s1,8(sp)
    80003674:	00013903          	ld	s2,0(sp)
    80003678:	02010113          	addi	sp,sp,32
    8000367c:	00008067          	ret
    80003680:	00001517          	auipc	a0,0x1
    80003684:	b5050513          	addi	a0,a0,-1200 # 800041d0 <digits+0x48>
    80003688:	fffff097          	auipc	ra,0xfffff
    8000368c:	154080e7          	jalr	340(ra) # 800027dc <panic>
    80003690:	00001517          	auipc	a0,0x1
    80003694:	b2850513          	addi	a0,a0,-1240 # 800041b8 <digits+0x30>
    80003698:	fffff097          	auipc	ra,0xfffff
    8000369c:	144080e7          	jalr	324(ra) # 800027dc <panic>

00000000800036a0 <holding>:
    800036a0:	00052783          	lw	a5,0(a0)
    800036a4:	00079663          	bnez	a5,800036b0 <holding+0x10>
    800036a8:	00000513          	li	a0,0
    800036ac:	00008067          	ret
    800036b0:	fe010113          	addi	sp,sp,-32
    800036b4:	00813823          	sd	s0,16(sp)
    800036b8:	00913423          	sd	s1,8(sp)
    800036bc:	00113c23          	sd	ra,24(sp)
    800036c0:	02010413          	addi	s0,sp,32
    800036c4:	01053483          	ld	s1,16(a0)
    800036c8:	ffffe097          	auipc	ra,0xffffe
    800036cc:	754080e7          	jalr	1876(ra) # 80001e1c <mycpu>
    800036d0:	01813083          	ld	ra,24(sp)
    800036d4:	01013403          	ld	s0,16(sp)
    800036d8:	40a48533          	sub	a0,s1,a0
    800036dc:	00153513          	seqz	a0,a0
    800036e0:	00813483          	ld	s1,8(sp)
    800036e4:	02010113          	addi	sp,sp,32
    800036e8:	00008067          	ret

00000000800036ec <push_off>:
    800036ec:	fe010113          	addi	sp,sp,-32
    800036f0:	00813823          	sd	s0,16(sp)
    800036f4:	00113c23          	sd	ra,24(sp)
    800036f8:	00913423          	sd	s1,8(sp)
    800036fc:	02010413          	addi	s0,sp,32
    80003700:	100024f3          	csrr	s1,sstatus
    80003704:	100027f3          	csrr	a5,sstatus
    80003708:	ffd7f793          	andi	a5,a5,-3
    8000370c:	10079073          	csrw	sstatus,a5
    80003710:	ffffe097          	auipc	ra,0xffffe
    80003714:	70c080e7          	jalr	1804(ra) # 80001e1c <mycpu>
    80003718:	07852783          	lw	a5,120(a0)
    8000371c:	02078663          	beqz	a5,80003748 <push_off+0x5c>
    80003720:	ffffe097          	auipc	ra,0xffffe
    80003724:	6fc080e7          	jalr	1788(ra) # 80001e1c <mycpu>
    80003728:	07852783          	lw	a5,120(a0)
    8000372c:	01813083          	ld	ra,24(sp)
    80003730:	01013403          	ld	s0,16(sp)
    80003734:	0017879b          	addiw	a5,a5,1
    80003738:	06f52c23          	sw	a5,120(a0)
    8000373c:	00813483          	ld	s1,8(sp)
    80003740:	02010113          	addi	sp,sp,32
    80003744:	00008067          	ret
    80003748:	0014d493          	srli	s1,s1,0x1
    8000374c:	ffffe097          	auipc	ra,0xffffe
    80003750:	6d0080e7          	jalr	1744(ra) # 80001e1c <mycpu>
    80003754:	0014f493          	andi	s1,s1,1
    80003758:	06952e23          	sw	s1,124(a0)
    8000375c:	fc5ff06f          	j	80003720 <push_off+0x34>

0000000080003760 <pop_off>:
    80003760:	ff010113          	addi	sp,sp,-16
    80003764:	00813023          	sd	s0,0(sp)
    80003768:	00113423          	sd	ra,8(sp)
    8000376c:	01010413          	addi	s0,sp,16
    80003770:	ffffe097          	auipc	ra,0xffffe
    80003774:	6ac080e7          	jalr	1708(ra) # 80001e1c <mycpu>
    80003778:	100027f3          	csrr	a5,sstatus
    8000377c:	0027f793          	andi	a5,a5,2
    80003780:	04079663          	bnez	a5,800037cc <pop_off+0x6c>
    80003784:	07852783          	lw	a5,120(a0)
    80003788:	02f05a63          	blez	a5,800037bc <pop_off+0x5c>
    8000378c:	fff7871b          	addiw	a4,a5,-1
    80003790:	06e52c23          	sw	a4,120(a0)
    80003794:	00071c63          	bnez	a4,800037ac <pop_off+0x4c>
    80003798:	07c52783          	lw	a5,124(a0)
    8000379c:	00078863          	beqz	a5,800037ac <pop_off+0x4c>
    800037a0:	100027f3          	csrr	a5,sstatus
    800037a4:	0027e793          	ori	a5,a5,2
    800037a8:	10079073          	csrw	sstatus,a5
    800037ac:	00813083          	ld	ra,8(sp)
    800037b0:	00013403          	ld	s0,0(sp)
    800037b4:	01010113          	addi	sp,sp,16
    800037b8:	00008067          	ret
    800037bc:	00001517          	auipc	a0,0x1
    800037c0:	a1450513          	addi	a0,a0,-1516 # 800041d0 <digits+0x48>
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	018080e7          	jalr	24(ra) # 800027dc <panic>
    800037cc:	00001517          	auipc	a0,0x1
    800037d0:	9ec50513          	addi	a0,a0,-1556 # 800041b8 <digits+0x30>
    800037d4:	fffff097          	auipc	ra,0xfffff
    800037d8:	008080e7          	jalr	8(ra) # 800027dc <panic>

00000000800037dc <push_on>:
    800037dc:	fe010113          	addi	sp,sp,-32
    800037e0:	00813823          	sd	s0,16(sp)
    800037e4:	00113c23          	sd	ra,24(sp)
    800037e8:	00913423          	sd	s1,8(sp)
    800037ec:	02010413          	addi	s0,sp,32
    800037f0:	100024f3          	csrr	s1,sstatus
    800037f4:	100027f3          	csrr	a5,sstatus
    800037f8:	0027e793          	ori	a5,a5,2
    800037fc:	10079073          	csrw	sstatus,a5
    80003800:	ffffe097          	auipc	ra,0xffffe
    80003804:	61c080e7          	jalr	1564(ra) # 80001e1c <mycpu>
    80003808:	07852783          	lw	a5,120(a0)
    8000380c:	02078663          	beqz	a5,80003838 <push_on+0x5c>
    80003810:	ffffe097          	auipc	ra,0xffffe
    80003814:	60c080e7          	jalr	1548(ra) # 80001e1c <mycpu>
    80003818:	07852783          	lw	a5,120(a0)
    8000381c:	01813083          	ld	ra,24(sp)
    80003820:	01013403          	ld	s0,16(sp)
    80003824:	0017879b          	addiw	a5,a5,1
    80003828:	06f52c23          	sw	a5,120(a0)
    8000382c:	00813483          	ld	s1,8(sp)
    80003830:	02010113          	addi	sp,sp,32
    80003834:	00008067          	ret
    80003838:	0014d493          	srli	s1,s1,0x1
    8000383c:	ffffe097          	auipc	ra,0xffffe
    80003840:	5e0080e7          	jalr	1504(ra) # 80001e1c <mycpu>
    80003844:	0014f493          	andi	s1,s1,1
    80003848:	06952e23          	sw	s1,124(a0)
    8000384c:	fc5ff06f          	j	80003810 <push_on+0x34>

0000000080003850 <pop_on>:
    80003850:	ff010113          	addi	sp,sp,-16
    80003854:	00813023          	sd	s0,0(sp)
    80003858:	00113423          	sd	ra,8(sp)
    8000385c:	01010413          	addi	s0,sp,16
    80003860:	ffffe097          	auipc	ra,0xffffe
    80003864:	5bc080e7          	jalr	1468(ra) # 80001e1c <mycpu>
    80003868:	100027f3          	csrr	a5,sstatus
    8000386c:	0027f793          	andi	a5,a5,2
    80003870:	04078463          	beqz	a5,800038b8 <pop_on+0x68>
    80003874:	07852783          	lw	a5,120(a0)
    80003878:	02f05863          	blez	a5,800038a8 <pop_on+0x58>
    8000387c:	fff7879b          	addiw	a5,a5,-1
    80003880:	06f52c23          	sw	a5,120(a0)
    80003884:	07853783          	ld	a5,120(a0)
    80003888:	00079863          	bnez	a5,80003898 <pop_on+0x48>
    8000388c:	100027f3          	csrr	a5,sstatus
    80003890:	ffd7f793          	andi	a5,a5,-3
    80003894:	10079073          	csrw	sstatus,a5
    80003898:	00813083          	ld	ra,8(sp)
    8000389c:	00013403          	ld	s0,0(sp)
    800038a0:	01010113          	addi	sp,sp,16
    800038a4:	00008067          	ret
    800038a8:	00001517          	auipc	a0,0x1
    800038ac:	95050513          	addi	a0,a0,-1712 # 800041f8 <digits+0x70>
    800038b0:	fffff097          	auipc	ra,0xfffff
    800038b4:	f2c080e7          	jalr	-212(ra) # 800027dc <panic>
    800038b8:	00001517          	auipc	a0,0x1
    800038bc:	92050513          	addi	a0,a0,-1760 # 800041d8 <digits+0x50>
    800038c0:	fffff097          	auipc	ra,0xfffff
    800038c4:	f1c080e7          	jalr	-228(ra) # 800027dc <panic>

00000000800038c8 <__memset>:
    800038c8:	ff010113          	addi	sp,sp,-16
    800038cc:	00813423          	sd	s0,8(sp)
    800038d0:	01010413          	addi	s0,sp,16
    800038d4:	1a060e63          	beqz	a2,80003a90 <__memset+0x1c8>
    800038d8:	40a007b3          	neg	a5,a0
    800038dc:	0077f793          	andi	a5,a5,7
    800038e0:	00778693          	addi	a3,a5,7
    800038e4:	00b00813          	li	a6,11
    800038e8:	0ff5f593          	andi	a1,a1,255
    800038ec:	fff6071b          	addiw	a4,a2,-1
    800038f0:	1b06e663          	bltu	a3,a6,80003a9c <__memset+0x1d4>
    800038f4:	1cd76463          	bltu	a4,a3,80003abc <__memset+0x1f4>
    800038f8:	1a078e63          	beqz	a5,80003ab4 <__memset+0x1ec>
    800038fc:	00b50023          	sb	a1,0(a0)
    80003900:	00100713          	li	a4,1
    80003904:	1ae78463          	beq	a5,a4,80003aac <__memset+0x1e4>
    80003908:	00b500a3          	sb	a1,1(a0)
    8000390c:	00200713          	li	a4,2
    80003910:	1ae78a63          	beq	a5,a4,80003ac4 <__memset+0x1fc>
    80003914:	00b50123          	sb	a1,2(a0)
    80003918:	00300713          	li	a4,3
    8000391c:	18e78463          	beq	a5,a4,80003aa4 <__memset+0x1dc>
    80003920:	00b501a3          	sb	a1,3(a0)
    80003924:	00400713          	li	a4,4
    80003928:	1ae78263          	beq	a5,a4,80003acc <__memset+0x204>
    8000392c:	00b50223          	sb	a1,4(a0)
    80003930:	00500713          	li	a4,5
    80003934:	1ae78063          	beq	a5,a4,80003ad4 <__memset+0x20c>
    80003938:	00b502a3          	sb	a1,5(a0)
    8000393c:	00700713          	li	a4,7
    80003940:	18e79e63          	bne	a5,a4,80003adc <__memset+0x214>
    80003944:	00b50323          	sb	a1,6(a0)
    80003948:	00700e93          	li	t4,7
    8000394c:	00859713          	slli	a4,a1,0x8
    80003950:	00e5e733          	or	a4,a1,a4
    80003954:	01059e13          	slli	t3,a1,0x10
    80003958:	01c76e33          	or	t3,a4,t3
    8000395c:	01859313          	slli	t1,a1,0x18
    80003960:	006e6333          	or	t1,t3,t1
    80003964:	02059893          	slli	a7,a1,0x20
    80003968:	40f60e3b          	subw	t3,a2,a5
    8000396c:	011368b3          	or	a7,t1,a7
    80003970:	02859813          	slli	a6,a1,0x28
    80003974:	0108e833          	or	a6,a7,a6
    80003978:	03059693          	slli	a3,a1,0x30
    8000397c:	003e589b          	srliw	a7,t3,0x3
    80003980:	00d866b3          	or	a3,a6,a3
    80003984:	03859713          	slli	a4,a1,0x38
    80003988:	00389813          	slli	a6,a7,0x3
    8000398c:	00f507b3          	add	a5,a0,a5
    80003990:	00e6e733          	or	a4,a3,a4
    80003994:	000e089b          	sext.w	a7,t3
    80003998:	00f806b3          	add	a3,a6,a5
    8000399c:	00e7b023          	sd	a4,0(a5)
    800039a0:	00878793          	addi	a5,a5,8
    800039a4:	fed79ce3          	bne	a5,a3,8000399c <__memset+0xd4>
    800039a8:	ff8e7793          	andi	a5,t3,-8
    800039ac:	0007871b          	sext.w	a4,a5
    800039b0:	01d787bb          	addw	a5,a5,t4
    800039b4:	0ce88e63          	beq	a7,a4,80003a90 <__memset+0x1c8>
    800039b8:	00f50733          	add	a4,a0,a5
    800039bc:	00b70023          	sb	a1,0(a4)
    800039c0:	0017871b          	addiw	a4,a5,1
    800039c4:	0cc77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    800039c8:	00e50733          	add	a4,a0,a4
    800039cc:	00b70023          	sb	a1,0(a4)
    800039d0:	0027871b          	addiw	a4,a5,2
    800039d4:	0ac77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    800039d8:	00e50733          	add	a4,a0,a4
    800039dc:	00b70023          	sb	a1,0(a4)
    800039e0:	0037871b          	addiw	a4,a5,3
    800039e4:	0ac77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    800039e8:	00e50733          	add	a4,a0,a4
    800039ec:	00b70023          	sb	a1,0(a4)
    800039f0:	0047871b          	addiw	a4,a5,4
    800039f4:	08c77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    800039f8:	00e50733          	add	a4,a0,a4
    800039fc:	00b70023          	sb	a1,0(a4)
    80003a00:	0057871b          	addiw	a4,a5,5
    80003a04:	08c77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a08:	00e50733          	add	a4,a0,a4
    80003a0c:	00b70023          	sb	a1,0(a4)
    80003a10:	0067871b          	addiw	a4,a5,6
    80003a14:	06c77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a18:	00e50733          	add	a4,a0,a4
    80003a1c:	00b70023          	sb	a1,0(a4)
    80003a20:	0077871b          	addiw	a4,a5,7
    80003a24:	06c77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a28:	00e50733          	add	a4,a0,a4
    80003a2c:	00b70023          	sb	a1,0(a4)
    80003a30:	0087871b          	addiw	a4,a5,8
    80003a34:	04c77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a38:	00e50733          	add	a4,a0,a4
    80003a3c:	00b70023          	sb	a1,0(a4)
    80003a40:	0097871b          	addiw	a4,a5,9
    80003a44:	04c77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a48:	00e50733          	add	a4,a0,a4
    80003a4c:	00b70023          	sb	a1,0(a4)
    80003a50:	00a7871b          	addiw	a4,a5,10
    80003a54:	02c77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a58:	00e50733          	add	a4,a0,a4
    80003a5c:	00b70023          	sb	a1,0(a4)
    80003a60:	00b7871b          	addiw	a4,a5,11
    80003a64:	02c77663          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a68:	00e50733          	add	a4,a0,a4
    80003a6c:	00b70023          	sb	a1,0(a4)
    80003a70:	00c7871b          	addiw	a4,a5,12
    80003a74:	00c77e63          	bgeu	a4,a2,80003a90 <__memset+0x1c8>
    80003a78:	00e50733          	add	a4,a0,a4
    80003a7c:	00b70023          	sb	a1,0(a4)
    80003a80:	00d7879b          	addiw	a5,a5,13
    80003a84:	00c7f663          	bgeu	a5,a2,80003a90 <__memset+0x1c8>
    80003a88:	00f507b3          	add	a5,a0,a5
    80003a8c:	00b78023          	sb	a1,0(a5)
    80003a90:	00813403          	ld	s0,8(sp)
    80003a94:	01010113          	addi	sp,sp,16
    80003a98:	00008067          	ret
    80003a9c:	00b00693          	li	a3,11
    80003aa0:	e55ff06f          	j	800038f4 <__memset+0x2c>
    80003aa4:	00300e93          	li	t4,3
    80003aa8:	ea5ff06f          	j	8000394c <__memset+0x84>
    80003aac:	00100e93          	li	t4,1
    80003ab0:	e9dff06f          	j	8000394c <__memset+0x84>
    80003ab4:	00000e93          	li	t4,0
    80003ab8:	e95ff06f          	j	8000394c <__memset+0x84>
    80003abc:	00000793          	li	a5,0
    80003ac0:	ef9ff06f          	j	800039b8 <__memset+0xf0>
    80003ac4:	00200e93          	li	t4,2
    80003ac8:	e85ff06f          	j	8000394c <__memset+0x84>
    80003acc:	00400e93          	li	t4,4
    80003ad0:	e7dff06f          	j	8000394c <__memset+0x84>
    80003ad4:	00500e93          	li	t4,5
    80003ad8:	e75ff06f          	j	8000394c <__memset+0x84>
    80003adc:	00600e93          	li	t4,6
    80003ae0:	e6dff06f          	j	8000394c <__memset+0x84>

0000000080003ae4 <__memmove>:
    80003ae4:	ff010113          	addi	sp,sp,-16
    80003ae8:	00813423          	sd	s0,8(sp)
    80003aec:	01010413          	addi	s0,sp,16
    80003af0:	0e060863          	beqz	a2,80003be0 <__memmove+0xfc>
    80003af4:	fff6069b          	addiw	a3,a2,-1
    80003af8:	0006881b          	sext.w	a6,a3
    80003afc:	0ea5e863          	bltu	a1,a0,80003bec <__memmove+0x108>
    80003b00:	00758713          	addi	a4,a1,7
    80003b04:	00a5e7b3          	or	a5,a1,a0
    80003b08:	40a70733          	sub	a4,a4,a0
    80003b0c:	0077f793          	andi	a5,a5,7
    80003b10:	00f73713          	sltiu	a4,a4,15
    80003b14:	00174713          	xori	a4,a4,1
    80003b18:	0017b793          	seqz	a5,a5
    80003b1c:	00e7f7b3          	and	a5,a5,a4
    80003b20:	10078863          	beqz	a5,80003c30 <__memmove+0x14c>
    80003b24:	00900793          	li	a5,9
    80003b28:	1107f463          	bgeu	a5,a6,80003c30 <__memmove+0x14c>
    80003b2c:	0036581b          	srliw	a6,a2,0x3
    80003b30:	fff8081b          	addiw	a6,a6,-1
    80003b34:	02081813          	slli	a6,a6,0x20
    80003b38:	01d85893          	srli	a7,a6,0x1d
    80003b3c:	00858813          	addi	a6,a1,8
    80003b40:	00058793          	mv	a5,a1
    80003b44:	00050713          	mv	a4,a0
    80003b48:	01088833          	add	a6,a7,a6
    80003b4c:	0007b883          	ld	a7,0(a5)
    80003b50:	00878793          	addi	a5,a5,8
    80003b54:	00870713          	addi	a4,a4,8
    80003b58:	ff173c23          	sd	a7,-8(a4)
    80003b5c:	ff0798e3          	bne	a5,a6,80003b4c <__memmove+0x68>
    80003b60:	ff867713          	andi	a4,a2,-8
    80003b64:	02071793          	slli	a5,a4,0x20
    80003b68:	0207d793          	srli	a5,a5,0x20
    80003b6c:	00f585b3          	add	a1,a1,a5
    80003b70:	40e686bb          	subw	a3,a3,a4
    80003b74:	00f507b3          	add	a5,a0,a5
    80003b78:	06e60463          	beq	a2,a4,80003be0 <__memmove+0xfc>
    80003b7c:	0005c703          	lbu	a4,0(a1)
    80003b80:	00e78023          	sb	a4,0(a5)
    80003b84:	04068e63          	beqz	a3,80003be0 <__memmove+0xfc>
    80003b88:	0015c603          	lbu	a2,1(a1)
    80003b8c:	00100713          	li	a4,1
    80003b90:	00c780a3          	sb	a2,1(a5)
    80003b94:	04e68663          	beq	a3,a4,80003be0 <__memmove+0xfc>
    80003b98:	0025c603          	lbu	a2,2(a1)
    80003b9c:	00200713          	li	a4,2
    80003ba0:	00c78123          	sb	a2,2(a5)
    80003ba4:	02e68e63          	beq	a3,a4,80003be0 <__memmove+0xfc>
    80003ba8:	0035c603          	lbu	a2,3(a1)
    80003bac:	00300713          	li	a4,3
    80003bb0:	00c781a3          	sb	a2,3(a5)
    80003bb4:	02e68663          	beq	a3,a4,80003be0 <__memmove+0xfc>
    80003bb8:	0045c603          	lbu	a2,4(a1)
    80003bbc:	00400713          	li	a4,4
    80003bc0:	00c78223          	sb	a2,4(a5)
    80003bc4:	00e68e63          	beq	a3,a4,80003be0 <__memmove+0xfc>
    80003bc8:	0055c603          	lbu	a2,5(a1)
    80003bcc:	00500713          	li	a4,5
    80003bd0:	00c782a3          	sb	a2,5(a5)
    80003bd4:	00e68663          	beq	a3,a4,80003be0 <__memmove+0xfc>
    80003bd8:	0065c703          	lbu	a4,6(a1)
    80003bdc:	00e78323          	sb	a4,6(a5)
    80003be0:	00813403          	ld	s0,8(sp)
    80003be4:	01010113          	addi	sp,sp,16
    80003be8:	00008067          	ret
    80003bec:	02061713          	slli	a4,a2,0x20
    80003bf0:	02075713          	srli	a4,a4,0x20
    80003bf4:	00e587b3          	add	a5,a1,a4
    80003bf8:	f0f574e3          	bgeu	a0,a5,80003b00 <__memmove+0x1c>
    80003bfc:	02069613          	slli	a2,a3,0x20
    80003c00:	02065613          	srli	a2,a2,0x20
    80003c04:	fff64613          	not	a2,a2
    80003c08:	00e50733          	add	a4,a0,a4
    80003c0c:	00c78633          	add	a2,a5,a2
    80003c10:	fff7c683          	lbu	a3,-1(a5)
    80003c14:	fff78793          	addi	a5,a5,-1
    80003c18:	fff70713          	addi	a4,a4,-1
    80003c1c:	00d70023          	sb	a3,0(a4)
    80003c20:	fec798e3          	bne	a5,a2,80003c10 <__memmove+0x12c>
    80003c24:	00813403          	ld	s0,8(sp)
    80003c28:	01010113          	addi	sp,sp,16
    80003c2c:	00008067          	ret
    80003c30:	02069713          	slli	a4,a3,0x20
    80003c34:	02075713          	srli	a4,a4,0x20
    80003c38:	00170713          	addi	a4,a4,1
    80003c3c:	00e50733          	add	a4,a0,a4
    80003c40:	00050793          	mv	a5,a0
    80003c44:	0005c683          	lbu	a3,0(a1)
    80003c48:	00178793          	addi	a5,a5,1
    80003c4c:	00158593          	addi	a1,a1,1
    80003c50:	fed78fa3          	sb	a3,-1(a5)
    80003c54:	fee798e3          	bne	a5,a4,80003c44 <__memmove+0x160>
    80003c58:	f89ff06f          	j	80003be0 <__memmove+0xfc>

0000000080003c5c <__putc>:
    80003c5c:	fe010113          	addi	sp,sp,-32
    80003c60:	00813823          	sd	s0,16(sp)
    80003c64:	00113c23          	sd	ra,24(sp)
    80003c68:	02010413          	addi	s0,sp,32
    80003c6c:	00050793          	mv	a5,a0
    80003c70:	fef40593          	addi	a1,s0,-17
    80003c74:	00100613          	li	a2,1
    80003c78:	00000513          	li	a0,0
    80003c7c:	fef407a3          	sb	a5,-17(s0)
    80003c80:	fffff097          	auipc	ra,0xfffff
    80003c84:	b3c080e7          	jalr	-1220(ra) # 800027bc <console_write>
    80003c88:	01813083          	ld	ra,24(sp)
    80003c8c:	01013403          	ld	s0,16(sp)
    80003c90:	02010113          	addi	sp,sp,32
    80003c94:	00008067          	ret

0000000080003c98 <__getc>:
    80003c98:	fe010113          	addi	sp,sp,-32
    80003c9c:	00813823          	sd	s0,16(sp)
    80003ca0:	00113c23          	sd	ra,24(sp)
    80003ca4:	02010413          	addi	s0,sp,32
    80003ca8:	fe840593          	addi	a1,s0,-24
    80003cac:	00100613          	li	a2,1
    80003cb0:	00000513          	li	a0,0
    80003cb4:	fffff097          	auipc	ra,0xfffff
    80003cb8:	ae8080e7          	jalr	-1304(ra) # 8000279c <console_read>
    80003cbc:	fe844503          	lbu	a0,-24(s0)
    80003cc0:	01813083          	ld	ra,24(sp)
    80003cc4:	01013403          	ld	s0,16(sp)
    80003cc8:	02010113          	addi	sp,sp,32
    80003ccc:	00008067          	ret

0000000080003cd0 <console_handler>:
    80003cd0:	fe010113          	addi	sp,sp,-32
    80003cd4:	00813823          	sd	s0,16(sp)
    80003cd8:	00113c23          	sd	ra,24(sp)
    80003cdc:	00913423          	sd	s1,8(sp)
    80003ce0:	02010413          	addi	s0,sp,32
    80003ce4:	14202773          	csrr	a4,scause
    80003ce8:	100027f3          	csrr	a5,sstatus
    80003cec:	0027f793          	andi	a5,a5,2
    80003cf0:	06079e63          	bnez	a5,80003d6c <console_handler+0x9c>
    80003cf4:	00074c63          	bltz	a4,80003d0c <console_handler+0x3c>
    80003cf8:	01813083          	ld	ra,24(sp)
    80003cfc:	01013403          	ld	s0,16(sp)
    80003d00:	00813483          	ld	s1,8(sp)
    80003d04:	02010113          	addi	sp,sp,32
    80003d08:	00008067          	ret
    80003d0c:	0ff77713          	andi	a4,a4,255
    80003d10:	00900793          	li	a5,9
    80003d14:	fef712e3          	bne	a4,a5,80003cf8 <console_handler+0x28>
    80003d18:	ffffe097          	auipc	ra,0xffffe
    80003d1c:	6dc080e7          	jalr	1756(ra) # 800023f4 <plic_claim>
    80003d20:	00a00793          	li	a5,10
    80003d24:	00050493          	mv	s1,a0
    80003d28:	02f50c63          	beq	a0,a5,80003d60 <console_handler+0x90>
    80003d2c:	fc0506e3          	beqz	a0,80003cf8 <console_handler+0x28>
    80003d30:	00050593          	mv	a1,a0
    80003d34:	00000517          	auipc	a0,0x0
    80003d38:	3cc50513          	addi	a0,a0,972 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80003d3c:	fffff097          	auipc	ra,0xfffff
    80003d40:	afc080e7          	jalr	-1284(ra) # 80002838 <__printf>
    80003d44:	01013403          	ld	s0,16(sp)
    80003d48:	01813083          	ld	ra,24(sp)
    80003d4c:	00048513          	mv	a0,s1
    80003d50:	00813483          	ld	s1,8(sp)
    80003d54:	02010113          	addi	sp,sp,32
    80003d58:	ffffe317          	auipc	t1,0xffffe
    80003d5c:	6d430067          	jr	1748(t1) # 8000242c <plic_complete>
    80003d60:	fffff097          	auipc	ra,0xfffff
    80003d64:	3e0080e7          	jalr	992(ra) # 80003140 <uartintr>
    80003d68:	fddff06f          	j	80003d44 <console_handler+0x74>
    80003d6c:	00000517          	auipc	a0,0x0
    80003d70:	49450513          	addi	a0,a0,1172 # 80004200 <digits+0x78>
    80003d74:	fffff097          	auipc	ra,0xfffff
    80003d78:	a68080e7          	jalr	-1432(ra) # 800027dc <panic>
	...
