
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	54813103          	ld	sp,1352(sp) # 80004548 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1d1010ef          	jal	ra,800019ec <start>

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
    80001080:	1c4000ef          	jal	ra,80001244 <interruptHandler>
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
    80001214:	00008067          	ret

0000000080001218 <_Z13callInterruptv>:
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001218:	ff010113          	addi	sp,sp,-16
    8000121c:	00813423          	sd	s0,8(sp)
    80001220:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("csrw stvec, %0" : : "r" (&interrupt)); // ovo treba uraditi na pocetku programa
    80001224:	00003797          	auipc	a5,0x3
    80001228:	3347b783          	ld	a5,820(a5) # 80004558 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000122c:	10579073          	csrw	stvec,a5
    asm volatile("ecall");
    80001230:	00000073          	ecall

    asm volatile("mv %0, a0" : "=r" (res));
    80001234:	00050513          	mv	a0,a0
    return res;
}
    80001238:	00813403          	ld	s0,8(sp)
    8000123c:	01010113          	addi	sp,sp,16
    80001240:	00008067          	ret

0000000080001244 <interruptHandler>:

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    80001244:	142027f3          	csrr	a5,scause
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001248:	ff878793          	addi	a5,a5,-8
    8000124c:	00100713          	li	a4,1
    80001250:	04f76e63          	bltu	a4,a5,800012ac <interruptHandler+0x68>
extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001254:	ff010113          	addi	sp,sp,-16
    80001258:	00113423          	sd	ra,8(sp)
    8000125c:	00813023          	sd	s0,0(sp)
    80001260:	01010413          	addi	s0,sp,16
        uint64 code;
        asm volatile("mv %0, a0" : "=r" (code));
    80001264:	00050793          	mv	a5,a0
        switch(code) {
    80001268:	02e78063          	beq	a5,a4,80001288 <interruptHandler+0x44>
    8000126c:	00200713          	li	a4,2
    80001270:	02e78663          	beq	a5,a4,8000129c <interruptHandler+0x58>
    80001274:	00000513          	li	a0,0
                return nullptr;
        }
    }

    return nullptr;
}
    80001278:	00813083          	ld	ra,8(sp)
    8000127c:	00013403          	ld	s0,0(sp)
    80001280:	01010113          	addi	sp,sp,16
    80001284:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (size));
    80001288:	00058513          	mv	a0,a1
                return MemoryAllocator::mem_alloc(size);
    8000128c:	00651513          	slli	a0,a0,0x6
    80001290:	00000097          	auipc	ra,0x0
    80001294:	378080e7          	jalr	888(ra) # 80001608 <_ZN15MemoryAllocator9mem_allocEm>
    80001298:	fe1ff06f          	j	80001278 <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    8000129c:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	4cc080e7          	jalr	1228(ra) # 8000176c <_ZN15MemoryAllocator8mem_freeEPv>
    800012a8:	fd1ff06f          	j	80001278 <interruptHandler+0x34>
    return nullptr;
    800012ac:	00000513          	li	a0,0
}
    800012b0:	00008067          	ret

00000000800012b4 <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    800012b4:	ff010113          	addi	sp,sp,-16
    800012b8:	00113423          	sd	ra,8(sp)
    800012bc:	00813023          	sd	s0,0(sp)
    800012c0:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800012c4:	00655793          	srli	a5,a0,0x6
    800012c8:	03f57513          	andi	a0,a0,63
    800012cc:	00a03533          	snez	a0,a0
    800012d0:	00a78533          	add	a0,a5,a0
    uint64 code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800012d4:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    800012d8:	00100793          	li	a5,1
    800012dc:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    800012e0:	00000097          	auipc	ra,0x0
    800012e4:	f38080e7          	jalr	-200(ra) # 80001218 <_Z13callInterruptv>
}
    800012e8:	00813083          	ld	ra,8(sp)
    800012ec:	00013403          	ld	s0,0(sp)
    800012f0:	01010113          	addi	sp,sp,16
    800012f4:	00008067          	ret

00000000800012f8 <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    800012f8:	ff010113          	addi	sp,sp,-16
    800012fc:	00113423          	sd	ra,8(sp)
    80001300:	00813023          	sd	s0,0(sp)
    80001304:	01010413          	addi	s0,sp,16
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    80001308:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    8000130c:	00200793          	li	a5,2
    80001310:	00078513          	mv	a0,a5

    return (uint64)(callInterrupt());
    80001314:	00000097          	auipc	ra,0x0
    80001318:	f04080e7          	jalr	-252(ra) # 80001218 <_Z13callInterruptv>
}
    8000131c:	0005051b          	sext.w	a0,a0
    80001320:	00813083          	ld	ra,8(sp)
    80001324:	00013403          	ld	s0,0(sp)
    80001328:	01010113          	addi	sp,sp,16
    8000132c:	00008067          	ret

0000000080001330 <_ZN3PCB14createProccessEPFvvE>:
#include "../h/PCB.h"

PCB *PCB::createProccess(PCB::proccessMain main) {
    80001330:	ff010113          	addi	sp,sp,-16
    80001334:	00813423          	sd	s0,8(sp)
    80001338:	01010413          	addi	s0,sp,16
    return nullptr;
}
    8000133c:	00000513          	li	a0,0
    80001340:	00813403          	ld	s0,8(sp)
    80001344:	01010113          	addi	sp,sp,16
    80001348:	00008067          	ret

000000008000134c <_ZN3PCB5yieldEv>:

void PCB::yield() {
    8000134c:	ff010113          	addi	sp,sp,-16
    80001350:	00813423          	sd	s0,8(sp)
    80001354:	01010413          	addi	s0,sp,16

}
    80001358:	00813403          	ld	s0,8(sp)
    8000135c:	01010113          	addi	sp,sp,16
    80001360:	00008067          	ret

0000000080001364 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001364:	ff010113          	addi	sp,sp,-16
    80001368:	00813423          	sd	s0,8(sp)
    8000136c:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    80001370:	00053023          	sd	zero,0(a0) # 1000 <_entry-0x7ffff000>
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001374:	00003797          	auipc	a5,0x3
    80001378:	22c7b783          	ld	a5,556(a5) # 800045a0 <_ZN9Scheduler4tailE>
    8000137c:	00078a63          	beqz	a5,80001390 <_ZN9Scheduler3putEP3PCB+0x2c>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    80001380:	00a7b023          	sd	a0,0(a5)
    }
}
    80001384:	00813403          	ld	s0,8(sp)
    80001388:	01010113          	addi	sp,sp,16
    8000138c:	00008067          	ret
        head = tail = process;
    80001390:	00003797          	auipc	a5,0x3
    80001394:	21078793          	addi	a5,a5,528 # 800045a0 <_ZN9Scheduler4tailE>
    80001398:	00a7b023          	sd	a0,0(a5)
    8000139c:	00a7b423          	sd	a0,8(a5)
    800013a0:	fe5ff06f          	j	80001384 <_ZN9Scheduler3putEP3PCB+0x20>

00000000800013a4 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800013a4:	ff010113          	addi	sp,sp,-16
    800013a8:	00813423          	sd	s0,8(sp)
    800013ac:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800013b0:	00003517          	auipc	a0,0x3
    800013b4:	1f853503          	ld	a0,504(a0) # 800045a8 <_ZN9Scheduler4headE>
    800013b8:	02050463          	beqz	a0,800013e0 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    800013bc:	00053703          	ld	a4,0(a0)
    800013c0:	00003797          	auipc	a5,0x3
    800013c4:	1e078793          	addi	a5,a5,480 # 800045a0 <_ZN9Scheduler4tailE>
    800013c8:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800013cc:	0007b783          	ld	a5,0(a5)
    800013d0:	00f50e63          	beq	a0,a5,800013ec <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    800013d4:	00813403          	ld	s0,8(sp)
    800013d8:	01010113          	addi	sp,sp,16
    800013dc:	00008067          	ret
        return idleProcess;
    800013e0:	00003517          	auipc	a0,0x3
    800013e4:	1d053503          	ld	a0,464(a0) # 800045b0 <_ZN9Scheduler11idleProcessE>
    800013e8:	fedff06f          	j	800013d4 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    800013ec:	00003797          	auipc	a5,0x3
    800013f0:	1ae7ba23          	sd	a4,436(a5) # 800045a0 <_ZN9Scheduler4tailE>
    800013f4:	fe1ff06f          	j	800013d4 <_ZN9Scheduler3getEv+0x30>

00000000800013f8 <_Z12checkNullptrPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    800013f8:	00050e63          	beqz	a0,80001414 <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    800013fc:	00003717          	auipc	a4,0x3
    80001400:	1bc70713          	addi	a4,a4,444 # 800045b8 <_ZZ12checkNullptrPvE1x>
    80001404:	00072783          	lw	a5,0(a4)
    80001408:	0017879b          	addiw	a5,a5,1
    8000140c:	00f72023          	sw	a5,0(a4)
    80001410:	00008067          	ret
void checkNullptr(void* p) {
    80001414:	ff010113          	addi	sp,sp,-16
    80001418:	00113423          	sd	ra,8(sp)
    8000141c:	00813023          	sd	s0,0(sp)
    80001420:	01010413          	addi	s0,sp,16
        __putc('?');
    80001424:	03f00513          	li	a0,63
    80001428:	00002097          	auipc	ra,0x2
    8000142c:	684080e7          	jalr	1668(ra) # 80003aac <__putc>
        __putc('0' + x);
    80001430:	00003517          	auipc	a0,0x3
    80001434:	18852503          	lw	a0,392(a0) # 800045b8 <_ZZ12checkNullptrPvE1x>
    80001438:	0305051b          	addiw	a0,a0,48
    8000143c:	0ff57513          	andi	a0,a0,255
    80001440:	00002097          	auipc	ra,0x2
    80001444:	66c080e7          	jalr	1644(ra) # 80003aac <__putc>
    x++;
    80001448:	00003717          	auipc	a4,0x3
    8000144c:	17070713          	addi	a4,a4,368 # 800045b8 <_ZZ12checkNullptrPvE1x>
    80001450:	00072783          	lw	a5,0(a4)
    80001454:	0017879b          	addiw	a5,a5,1
    80001458:	00f72023          	sw	a5,0(a4)
}
    8000145c:	00813083          	ld	ra,8(sp)
    80001460:	00013403          	ld	s0,0(sp)
    80001464:	01010113          	addi	sp,sp,16
    80001468:	00008067          	ret

000000008000146c <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    8000146c:	00051e63          	bnez	a0,80001488 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    80001470:	00003717          	auipc	a4,0x3
    80001474:	14870713          	addi	a4,a4,328 # 800045b8 <_ZZ12checkNullptrPvE1x>
    80001478:	00472783          	lw	a5,4(a4)
    8000147c:	0017879b          	addiw	a5,a5,1
    80001480:	00f72223          	sw	a5,4(a4)
    80001484:	00008067          	ret
void checkStatus(int status) {
    80001488:	ff010113          	addi	sp,sp,-16
    8000148c:	00113423          	sd	ra,8(sp)
    80001490:	00813023          	sd	s0,0(sp)
    80001494:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    80001498:	00003517          	auipc	a0,0x3
    8000149c:	12452503          	lw	a0,292(a0) # 800045bc <_ZZ11checkStatusiE1y>
    800014a0:	0305051b          	addiw	a0,a0,48
    800014a4:	0ff57513          	andi	a0,a0,255
    800014a8:	00002097          	auipc	ra,0x2
    800014ac:	604080e7          	jalr	1540(ra) # 80003aac <__putc>
        __putc('?');
    800014b0:	03f00513          	li	a0,63
    800014b4:	00002097          	auipc	ra,0x2
    800014b8:	5f8080e7          	jalr	1528(ra) # 80003aac <__putc>
    y++;
    800014bc:	00003717          	auipc	a4,0x3
    800014c0:	0fc70713          	addi	a4,a4,252 # 800045b8 <_ZZ12checkNullptrPvE1x>
    800014c4:	00472783          	lw	a5,4(a4)
    800014c8:	0017879b          	addiw	a5,a5,1
    800014cc:	00f72223          	sw	a5,4(a4)
}
    800014d0:	00813083          	ld	ra,8(sp)
    800014d4:	00013403          	ld	s0,0(sp)
    800014d8:	01010113          	addi	sp,sp,16
    800014dc:	00008067          	ret

00000000800014e0 <main>:

int main() {
    800014e0:	fe010113          	addi	sp,sp,-32
    800014e4:	00113c23          	sd	ra,24(sp)
    800014e8:	00813823          	sd	s0,16(sp)
    800014ec:	00913423          	sd	s1,8(sp)
    800014f0:	02010413          	addi	s0,sp,32
    int velicinaZaglavlja = sizeof(size_t); // meni je ovoliko

    const size_t celaMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
    800014f4:	00003797          	auipc	a5,0x3
    800014f8:	05c7b783          	ld	a5,92(a5) # 80004550 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014fc:	0007b503          	ld	a0,0(a5)
    80001500:	00003797          	auipc	a5,0x3
    80001504:	0407b783          	ld	a5,64(a5) # 80004540 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001508:	0007b783          	ld	a5,0(a5)
    8000150c:	40f50533          	sub	a0,a0,a5
    80001510:	ff850513          	addi	a0,a0,-8
    80001514:	00655513          	srli	a0,a0,0x6
    80001518:	fff50513          	addi	a0,a0,-1
    char* niz = (char*)mem_alloc(celaMemorija); // celokupan prostor
    8000151c:	00651513          	slli	a0,a0,0x6
    80001520:	00000097          	auipc	ra,0x0
    80001524:	d94080e7          	jalr	-620(ra) # 800012b4 <_Z9mem_allocm>
    80001528:	00050493          	mv	s1,a0
    if(niz == nullptr) {
    8000152c:	04050663          	beqz	a0,80001578 <main+0x98>
        __putc('?');
    }

    int n = 10;
    char* niz2 = (char*)mem_alloc(n*sizeof(char));
    80001530:	00a00513          	li	a0,10
    80001534:	00000097          	auipc	ra,0x0
    80001538:	d80080e7          	jalr	-640(ra) # 800012b4 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    8000153c:	04050663          	beqz	a0,80001588 <main+0xa8>
        __putc('k');
    }

    int status = mem_free(niz);
    80001540:	00048513          	mv	a0,s1
    80001544:	00000097          	auipc	ra,0x0
    80001548:	db4080e7          	jalr	-588(ra) # 800012f8 <_Z8mem_freePv>
    if(status) {
    8000154c:	04051663          	bnez	a0,80001598 <main+0xb8>
        __putc('?');
    }
    niz2 = (char*)mem_alloc(n*sizeof(char));
    80001550:	00a00513          	li	a0,10
    80001554:	00000097          	auipc	ra,0x0
    80001558:	d60080e7          	jalr	-672(ra) # 800012b4 <_Z9mem_allocm>
    if(niz2 == nullptr) {
    8000155c:	04050663          	beqz	a0,800015a8 <main+0xc8>
        __putc('?');
    }

    return 0;
}
    80001560:	00000513          	li	a0,0
    80001564:	01813083          	ld	ra,24(sp)
    80001568:	01013403          	ld	s0,16(sp)
    8000156c:	00813483          	ld	s1,8(sp)
    80001570:	02010113          	addi	sp,sp,32
    80001574:	00008067          	ret
        __putc('?');
    80001578:	03f00513          	li	a0,63
    8000157c:	00002097          	auipc	ra,0x2
    80001580:	530080e7          	jalr	1328(ra) # 80003aac <__putc>
    80001584:	fadff06f          	j	80001530 <main+0x50>
        __putc('k');
    80001588:	06b00513          	li	a0,107
    8000158c:	00002097          	auipc	ra,0x2
    80001590:	520080e7          	jalr	1312(ra) # 80003aac <__putc>
    80001594:	fadff06f          	j	80001540 <main+0x60>
        __putc('?');
    80001598:	03f00513          	li	a0,63
    8000159c:	00002097          	auipc	ra,0x2
    800015a0:	510080e7          	jalr	1296(ra) # 80003aac <__putc>
    800015a4:	fadff06f          	j	80001550 <main+0x70>
        __putc('?');
    800015a8:	03f00513          	li	a0,63
    800015ac:	00002097          	auipc	ra,0x2
    800015b0:	500080e7          	jalr	1280(ra) # 80003aac <__putc>
    800015b4:	fadff06f          	j	80001560 <main+0x80>

00000000800015b8 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    800015b8:	ff010113          	addi	sp,sp,-16
    800015bc:	00113423          	sd	ra,8(sp)
    800015c0:	00813023          	sd	s0,0(sp)
    800015c4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800015c8:	00000097          	auipc	ra,0x0
    800015cc:	cec080e7          	jalr	-788(ra) # 800012b4 <_Z9mem_allocm>
}
    800015d0:	00813083          	ld	ra,8(sp)
    800015d4:	00013403          	ld	s0,0(sp)
    800015d8:	01010113          	addi	sp,sp,16
    800015dc:	00008067          	ret

00000000800015e0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800015e0:	ff010113          	addi	sp,sp,-16
    800015e4:	00113423          	sd	ra,8(sp)
    800015e8:	00813023          	sd	s0,0(sp)
    800015ec:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800015f0:	00000097          	auipc	ra,0x0
    800015f4:	d08080e7          	jalr	-760(ra) # 800012f8 <_Z8mem_freePv>
    800015f8:	00813083          	ld	ra,8(sp)
    800015fc:	00013403          	ld	s0,0(sp)
    80001600:	01010113          	addi	sp,sp,16
    80001604:	00008067          	ret

0000000080001608 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001608:	ff010113          	addi	sp,sp,-16
    8000160c:	00813423          	sd	s0,8(sp)
    80001610:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001614:	00003797          	auipc	a5,0x3
    80001618:	fac7b783          	ld	a5,-84(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
    8000161c:	02078c63          	beqz	a5,80001654 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001620:	00003717          	auipc	a4,0x3
    80001624:	f3073703          	ld	a4,-208(a4) # 80004550 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001628:	00073703          	ld	a4,0(a4)
    8000162c:	12e78c63          	beq	a5,a4,80001764 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001630:	00850713          	addi	a4,a0,8
    80001634:	00675813          	srli	a6,a4,0x6
    80001638:	03f77793          	andi	a5,a4,63
    8000163c:	00f037b3          	snez	a5,a5
    80001640:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001644:	00003517          	auipc	a0,0x3
    80001648:	f7c53503          	ld	a0,-132(a0) # 800045c0 <_ZN15MemoryAllocator4headE>
    8000164c:	00000613          	li	a2,0
    80001650:	0a80006f          	j	800016f8 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001654:	00003697          	auipc	a3,0x3
    80001658:	eec6b683          	ld	a3,-276(a3) # 80004540 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000165c:	0006b783          	ld	a5,0(a3)
    80001660:	00003717          	auipc	a4,0x3
    80001664:	f6f73023          	sd	a5,-160(a4) # 800045c0 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001668:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    8000166c:	00003717          	auipc	a4,0x3
    80001670:	ee473703          	ld	a4,-284(a4) # 80004550 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001674:	00073703          	ld	a4,0(a4)
    80001678:	0006b683          	ld	a3,0(a3)
    8000167c:	40d70733          	sub	a4,a4,a3
    80001680:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001684:	0007b823          	sd	zero,16(a5)
    80001688:	fa9ff06f          	j	80001630 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    8000168c:	00060e63          	beqz	a2,800016a8 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001690:	01063703          	ld	a4,16(a2)
    80001694:	04070a63          	beqz	a4,800016e8 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001698:	01073703          	ld	a4,16(a4)
    8000169c:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800016a0:	00078813          	mv	a6,a5
    800016a4:	0ac0006f          	j	80001750 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800016a8:	01053703          	ld	a4,16(a0)
    800016ac:	00070a63          	beqz	a4,800016c0 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    800016b0:	00003697          	auipc	a3,0x3
    800016b4:	f0e6b823          	sd	a4,-240(a3) # 800045c0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800016b8:	00078813          	mv	a6,a5
    800016bc:	0940006f          	j	80001750 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    800016c0:	00003717          	auipc	a4,0x3
    800016c4:	e9073703          	ld	a4,-368(a4) # 80004550 <_GLOBAL_OFFSET_TABLE_+0x18>
    800016c8:	00073703          	ld	a4,0(a4)
    800016cc:	00003697          	auipc	a3,0x3
    800016d0:	eee6ba23          	sd	a4,-268(a3) # 800045c0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800016d4:	00078813          	mv	a6,a5
    800016d8:	0780006f          	j	80001750 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    800016dc:	00003797          	auipc	a5,0x3
    800016e0:	eee7b223          	sd	a4,-284(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
    800016e4:	06c0006f          	j	80001750 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    800016e8:	00078813          	mv	a6,a5
    800016ec:	0640006f          	j	80001750 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    800016f0:	00050613          	mv	a2,a0
        curr = curr->next;
    800016f4:	01053503          	ld	a0,16(a0)
    while(curr) {
    800016f8:	06050063          	beqz	a0,80001758 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    800016fc:	00853783          	ld	a5,8(a0)
    80001700:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80001704:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001708:	fee7e4e3          	bltu	a5,a4,800016f0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    8000170c:	ff06e2e3          	bltu	a3,a6,800016f0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001710:	f7068ee3          	beq	a3,a6,8000168c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001714:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001718:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    8000171c:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001720:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001724:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001728:	01053783          	ld	a5,16(a0)
    8000172c:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001730:	fa0606e3          	beqz	a2,800016dc <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001734:	01063783          	ld	a5,16(a2)
    80001738:	00078663          	beqz	a5,80001744 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    8000173c:	0107b783          	ld	a5,16(a5)
    80001740:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80001744:	01063783          	ld	a5,16(a2)
    80001748:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    8000174c:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001750:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001754:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001758:	00813403          	ld	s0,8(sp)
    8000175c:	01010113          	addi	sp,sp,16
    80001760:	00008067          	ret
        return nullptr;
    80001764:	00000513          	li	a0,0
    80001768:	ff1ff06f          	j	80001758 <_ZN15MemoryAllocator9mem_allocEm+0x150>

000000008000176c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    8000176c:	ff010113          	addi	sp,sp,-16
    80001770:	00813423          	sd	s0,8(sp)
    80001774:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001778:	16050063          	beqz	a0,800018d8 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    8000177c:	ff850713          	addi	a4,a0,-8
    80001780:	00003797          	auipc	a5,0x3
    80001784:	dc07b783          	ld	a5,-576(a5) # 80004540 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001788:	0007b783          	ld	a5,0(a5)
    8000178c:	14f76a63          	bltu	a4,a5,800018e0 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001790:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001794:	fff58693          	addi	a3,a1,-1
    80001798:	00d706b3          	add	a3,a4,a3
    8000179c:	00003617          	auipc	a2,0x3
    800017a0:	db463603          	ld	a2,-588(a2) # 80004550 <_GLOBAL_OFFSET_TABLE_+0x18>
    800017a4:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800017a8:	14c6f063          	bgeu	a3,a2,800018e8 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800017ac:	14070263          	beqz	a4,800018f0 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    800017b0:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800017b4:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800017b8:	14079063          	bnez	a5,800018f8 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    800017bc:	03f00793          	li	a5,63
    800017c0:	14b7f063          	bgeu	a5,a1,80001900 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    800017c4:	00003797          	auipc	a5,0x3
    800017c8:	dfc7b783          	ld	a5,-516(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
    800017cc:	02f60063          	beq	a2,a5,800017ec <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800017d0:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800017d4:	02078a63          	beqz	a5,80001808 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    800017d8:	0007b683          	ld	a3,0(a5)
    800017dc:	02e6f663          	bgeu	a3,a4,80001808 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    800017e0:	00078613          	mv	a2,a5
        curr = curr->next;
    800017e4:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800017e8:	fedff06f          	j	800017d4 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    800017ec:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    800017f0:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800017f4:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800017f8:	00003797          	auipc	a5,0x3
    800017fc:	dce7b423          	sd	a4,-568(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
        return 0;
    80001800:	00000513          	li	a0,0
    80001804:	0480006f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001808:	04060863          	beqz	a2,80001858 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    8000180c:	00063683          	ld	a3,0(a2)
    80001810:	00863803          	ld	a6,8(a2)
    80001814:	010686b3          	add	a3,a3,a6
    80001818:	08e68a63          	beq	a3,a4,800018ac <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    8000181c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001820:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001824:	01063683          	ld	a3,16(a2)
    80001828:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    8000182c:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001830:	0e078063          	beqz	a5,80001910 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001834:	0007b583          	ld	a1,0(a5)
    80001838:	00073683          	ld	a3,0(a4)
    8000183c:	00873603          	ld	a2,8(a4)
    80001840:	00c686b3          	add	a3,a3,a2
    80001844:	06d58c63          	beq	a1,a3,800018bc <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80001848:	00000513          	li	a0,0
}
    8000184c:	00813403          	ld	s0,8(sp)
    80001850:	01010113          	addi	sp,sp,16
    80001854:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80001858:	0a078863          	beqz	a5,80001908 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    8000185c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001860:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001864:	00003797          	auipc	a5,0x3
    80001868:	d5c7b783          	ld	a5,-676(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
    8000186c:	0007b603          	ld	a2,0(a5)
    80001870:	00b706b3          	add	a3,a4,a1
    80001874:	00d60c63          	beq	a2,a3,8000188c <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80001878:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    8000187c:	00003797          	auipc	a5,0x3
    80001880:	d4e7b223          	sd	a4,-700(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
            return 0;
    80001884:	00000513          	li	a0,0
    80001888:	fc5ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    8000188c:	0087b783          	ld	a5,8(a5)
    80001890:	00b785b3          	add	a1,a5,a1
    80001894:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80001898:	00003797          	auipc	a5,0x3
    8000189c:	d287b783          	ld	a5,-728(a5) # 800045c0 <_ZN15MemoryAllocator4headE>
    800018a0:	0107b783          	ld	a5,16(a5)
    800018a4:	00f53423          	sd	a5,8(a0)
    800018a8:	fd5ff06f          	j	8000187c <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800018ac:	00b805b3          	add	a1,a6,a1
    800018b0:	00b63423          	sd	a1,8(a2)
    800018b4:	00060713          	mv	a4,a2
    800018b8:	f79ff06f          	j	80001830 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800018bc:	0087b683          	ld	a3,8(a5)
    800018c0:	00d60633          	add	a2,a2,a3
    800018c4:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800018c8:	0107b783          	ld	a5,16(a5)
    800018cc:	00f73823          	sd	a5,16(a4)
    return 0;
    800018d0:	00000513          	li	a0,0
    800018d4:	f79ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800018d8:	fff00513          	li	a0,-1
    800018dc:	f71ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800018e0:	fff00513          	li	a0,-1
    800018e4:	f69ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800018e8:	fff00513          	li	a0,-1
    800018ec:	f61ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800018f0:	fff00513          	li	a0,-1
    800018f4:	f59ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800018f8:	fff00513          	li	a0,-1
    800018fc:	f51ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001900:	fff00513          	li	a0,-1
    80001904:	f49ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001908:	fff00513          	li	a0,-1
    8000190c:	f41ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001910:	00000513          	li	a0,0
    80001914:	f39ff06f          	j	8000184c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001918 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../lib/console.h"

void printString(char const *string)
{
    80001918:	fe010113          	addi	sp,sp,-32
    8000191c:	00113c23          	sd	ra,24(sp)
    80001920:	00813823          	sd	s0,16(sp)
    80001924:	00913423          	sd	s1,8(sp)
    80001928:	02010413          	addi	s0,sp,32
    8000192c:	00050493          	mv	s1,a0
    while (*string != '\0')
    80001930:	0004c503          	lbu	a0,0(s1)
    80001934:	00050a63          	beqz	a0,80001948 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    80001938:	00002097          	auipc	ra,0x2
    8000193c:	174080e7          	jalr	372(ra) # 80003aac <__putc>
        string++;
    80001940:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001944:	fedff06f          	j	80001930 <_Z11printStringPKc+0x18>
    }
}
    80001948:	01813083          	ld	ra,24(sp)
    8000194c:	01013403          	ld	s0,16(sp)
    80001950:	00813483          	ld	s1,8(sp)
    80001954:	02010113          	addi	sp,sp,32
    80001958:	00008067          	ret

000000008000195c <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    8000195c:	fd010113          	addi	sp,sp,-48
    80001960:	02113423          	sd	ra,40(sp)
    80001964:	02813023          	sd	s0,32(sp)
    80001968:	00913c23          	sd	s1,24(sp)
    8000196c:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80001970:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001974:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001978:	00a00613          	li	a2,10
    8000197c:	02c5773b          	remuw	a4,a0,a2
    80001980:	02071693          	slli	a3,a4,0x20
    80001984:	0206d693          	srli	a3,a3,0x20
    80001988:	00002717          	auipc	a4,0x2
    8000198c:	69870713          	addi	a4,a4,1688 # 80004020 <_ZZ12printIntegermE6digits>
    80001990:	00d70733          	add	a4,a4,a3
    80001994:	00074703          	lbu	a4,0(a4)
    80001998:	fe040693          	addi	a3,s0,-32
    8000199c:	009687b3          	add	a5,a3,s1
    800019a0:	0014849b          	addiw	s1,s1,1
    800019a4:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    800019a8:	0005071b          	sext.w	a4,a0
    800019ac:	02c5553b          	divuw	a0,a0,a2
    800019b0:	00900793          	li	a5,9
    800019b4:	fce7e2e3          	bltu	a5,a4,80001978 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    800019b8:	fff4849b          	addiw	s1,s1,-1
    800019bc:	0004ce63          	bltz	s1,800019d8 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    800019c0:	fe040793          	addi	a5,s0,-32
    800019c4:	009787b3          	add	a5,a5,s1
    800019c8:	ff07c503          	lbu	a0,-16(a5)
    800019cc:	00002097          	auipc	ra,0x2
    800019d0:	0e0080e7          	jalr	224(ra) # 80003aac <__putc>
    800019d4:	fe5ff06f          	j	800019b8 <_Z12printIntegerm+0x5c>
    800019d8:	02813083          	ld	ra,40(sp)
    800019dc:	02013403          	ld	s0,32(sp)
    800019e0:	01813483          	ld	s1,24(sp)
    800019e4:	03010113          	addi	sp,sp,48
    800019e8:	00008067          	ret

00000000800019ec <start>:
    800019ec:	ff010113          	addi	sp,sp,-16
    800019f0:	00813423          	sd	s0,8(sp)
    800019f4:	01010413          	addi	s0,sp,16
    800019f8:	300027f3          	csrr	a5,mstatus
    800019fc:	ffffe737          	lui	a4,0xffffe
    80001a00:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff8fcf>
    80001a04:	00e7f7b3          	and	a5,a5,a4
    80001a08:	00001737          	lui	a4,0x1
    80001a0c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001a10:	00e7e7b3          	or	a5,a5,a4
    80001a14:	30079073          	csrw	mstatus,a5
    80001a18:	00000797          	auipc	a5,0x0
    80001a1c:	16078793          	addi	a5,a5,352 # 80001b78 <system_main>
    80001a20:	34179073          	csrw	mepc,a5
    80001a24:	00000793          	li	a5,0
    80001a28:	18079073          	csrw	satp,a5
    80001a2c:	000107b7          	lui	a5,0x10
    80001a30:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001a34:	30279073          	csrw	medeleg,a5
    80001a38:	30379073          	csrw	mideleg,a5
    80001a3c:	104027f3          	csrr	a5,sie
    80001a40:	2227e793          	ori	a5,a5,546
    80001a44:	10479073          	csrw	sie,a5
    80001a48:	fff00793          	li	a5,-1
    80001a4c:	00a7d793          	srli	a5,a5,0xa
    80001a50:	3b079073          	csrw	pmpaddr0,a5
    80001a54:	00f00793          	li	a5,15
    80001a58:	3a079073          	csrw	pmpcfg0,a5
    80001a5c:	f14027f3          	csrr	a5,mhartid
    80001a60:	0200c737          	lui	a4,0x200c
    80001a64:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001a68:	0007869b          	sext.w	a3,a5
    80001a6c:	00269713          	slli	a4,a3,0x2
    80001a70:	000f4637          	lui	a2,0xf4
    80001a74:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001a78:	00d70733          	add	a4,a4,a3
    80001a7c:	0037979b          	slliw	a5,a5,0x3
    80001a80:	020046b7          	lui	a3,0x2004
    80001a84:	00d787b3          	add	a5,a5,a3
    80001a88:	00c585b3          	add	a1,a1,a2
    80001a8c:	00371693          	slli	a3,a4,0x3
    80001a90:	00003717          	auipc	a4,0x3
    80001a94:	b4070713          	addi	a4,a4,-1216 # 800045d0 <timer_scratch>
    80001a98:	00b7b023          	sd	a1,0(a5)
    80001a9c:	00d70733          	add	a4,a4,a3
    80001aa0:	00f73c23          	sd	a5,24(a4)
    80001aa4:	02c73023          	sd	a2,32(a4)
    80001aa8:	34071073          	csrw	mscratch,a4
    80001aac:	00000797          	auipc	a5,0x0
    80001ab0:	6e478793          	addi	a5,a5,1764 # 80002190 <timervec>
    80001ab4:	30579073          	csrw	mtvec,a5
    80001ab8:	300027f3          	csrr	a5,mstatus
    80001abc:	0087e793          	ori	a5,a5,8
    80001ac0:	30079073          	csrw	mstatus,a5
    80001ac4:	304027f3          	csrr	a5,mie
    80001ac8:	0807e793          	ori	a5,a5,128
    80001acc:	30479073          	csrw	mie,a5
    80001ad0:	f14027f3          	csrr	a5,mhartid
    80001ad4:	0007879b          	sext.w	a5,a5
    80001ad8:	00078213          	mv	tp,a5
    80001adc:	30200073          	mret
    80001ae0:	00813403          	ld	s0,8(sp)
    80001ae4:	01010113          	addi	sp,sp,16
    80001ae8:	00008067          	ret

0000000080001aec <timerinit>:
    80001aec:	ff010113          	addi	sp,sp,-16
    80001af0:	00813423          	sd	s0,8(sp)
    80001af4:	01010413          	addi	s0,sp,16
    80001af8:	f14027f3          	csrr	a5,mhartid
    80001afc:	0200c737          	lui	a4,0x200c
    80001b00:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001b04:	0007869b          	sext.w	a3,a5
    80001b08:	00269713          	slli	a4,a3,0x2
    80001b0c:	000f4637          	lui	a2,0xf4
    80001b10:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001b14:	00d70733          	add	a4,a4,a3
    80001b18:	0037979b          	slliw	a5,a5,0x3
    80001b1c:	020046b7          	lui	a3,0x2004
    80001b20:	00d787b3          	add	a5,a5,a3
    80001b24:	00c585b3          	add	a1,a1,a2
    80001b28:	00371693          	slli	a3,a4,0x3
    80001b2c:	00003717          	auipc	a4,0x3
    80001b30:	aa470713          	addi	a4,a4,-1372 # 800045d0 <timer_scratch>
    80001b34:	00b7b023          	sd	a1,0(a5)
    80001b38:	00d70733          	add	a4,a4,a3
    80001b3c:	00f73c23          	sd	a5,24(a4)
    80001b40:	02c73023          	sd	a2,32(a4)
    80001b44:	34071073          	csrw	mscratch,a4
    80001b48:	00000797          	auipc	a5,0x0
    80001b4c:	64878793          	addi	a5,a5,1608 # 80002190 <timervec>
    80001b50:	30579073          	csrw	mtvec,a5
    80001b54:	300027f3          	csrr	a5,mstatus
    80001b58:	0087e793          	ori	a5,a5,8
    80001b5c:	30079073          	csrw	mstatus,a5
    80001b60:	304027f3          	csrr	a5,mie
    80001b64:	0807e793          	ori	a5,a5,128
    80001b68:	30479073          	csrw	mie,a5
    80001b6c:	00813403          	ld	s0,8(sp)
    80001b70:	01010113          	addi	sp,sp,16
    80001b74:	00008067          	ret

0000000080001b78 <system_main>:
    80001b78:	fe010113          	addi	sp,sp,-32
    80001b7c:	00813823          	sd	s0,16(sp)
    80001b80:	00913423          	sd	s1,8(sp)
    80001b84:	00113c23          	sd	ra,24(sp)
    80001b88:	02010413          	addi	s0,sp,32
    80001b8c:	00000097          	auipc	ra,0x0
    80001b90:	0c4080e7          	jalr	196(ra) # 80001c50 <cpuid>
    80001b94:	00003497          	auipc	s1,0x3
    80001b98:	9dc48493          	addi	s1,s1,-1572 # 80004570 <started>
    80001b9c:	02050263          	beqz	a0,80001bc0 <system_main+0x48>
    80001ba0:	0004a783          	lw	a5,0(s1)
    80001ba4:	0007879b          	sext.w	a5,a5
    80001ba8:	fe078ce3          	beqz	a5,80001ba0 <system_main+0x28>
    80001bac:	0ff0000f          	fence
    80001bb0:	00002517          	auipc	a0,0x2
    80001bb4:	4b050513          	addi	a0,a0,1200 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    80001bb8:	00001097          	auipc	ra,0x1
    80001bbc:	a74080e7          	jalr	-1420(ra) # 8000262c <panic>
    80001bc0:	00001097          	auipc	ra,0x1
    80001bc4:	9c8080e7          	jalr	-1592(ra) # 80002588 <consoleinit>
    80001bc8:	00001097          	auipc	ra,0x1
    80001bcc:	154080e7          	jalr	340(ra) # 80002d1c <printfinit>
    80001bd0:	00002517          	auipc	a0,0x2
    80001bd4:	57050513          	addi	a0,a0,1392 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001bd8:	00001097          	auipc	ra,0x1
    80001bdc:	ab0080e7          	jalr	-1360(ra) # 80002688 <__printf>
    80001be0:	00002517          	auipc	a0,0x2
    80001be4:	45050513          	addi	a0,a0,1104 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    80001be8:	00001097          	auipc	ra,0x1
    80001bec:	aa0080e7          	jalr	-1376(ra) # 80002688 <__printf>
    80001bf0:	00002517          	auipc	a0,0x2
    80001bf4:	55050513          	addi	a0,a0,1360 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001bf8:	00001097          	auipc	ra,0x1
    80001bfc:	a90080e7          	jalr	-1392(ra) # 80002688 <__printf>
    80001c00:	00001097          	auipc	ra,0x1
    80001c04:	4a8080e7          	jalr	1192(ra) # 800030a8 <kinit>
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	148080e7          	jalr	328(ra) # 80001d50 <trapinit>
    80001c10:	00000097          	auipc	ra,0x0
    80001c14:	16c080e7          	jalr	364(ra) # 80001d7c <trapinithart>
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	5b8080e7          	jalr	1464(ra) # 800021d0 <plicinit>
    80001c20:	00000097          	auipc	ra,0x0
    80001c24:	5d8080e7          	jalr	1496(ra) # 800021f8 <plicinithart>
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	078080e7          	jalr	120(ra) # 80001ca0 <userinit>
    80001c30:	0ff0000f          	fence
    80001c34:	00100793          	li	a5,1
    80001c38:	00002517          	auipc	a0,0x2
    80001c3c:	41050513          	addi	a0,a0,1040 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    80001c40:	00f4a023          	sw	a5,0(s1)
    80001c44:	00001097          	auipc	ra,0x1
    80001c48:	a44080e7          	jalr	-1468(ra) # 80002688 <__printf>
    80001c4c:	0000006f          	j	80001c4c <system_main+0xd4>

0000000080001c50 <cpuid>:
    80001c50:	ff010113          	addi	sp,sp,-16
    80001c54:	00813423          	sd	s0,8(sp)
    80001c58:	01010413          	addi	s0,sp,16
    80001c5c:	00020513          	mv	a0,tp
    80001c60:	00813403          	ld	s0,8(sp)
    80001c64:	0005051b          	sext.w	a0,a0
    80001c68:	01010113          	addi	sp,sp,16
    80001c6c:	00008067          	ret

0000000080001c70 <mycpu>:
    80001c70:	ff010113          	addi	sp,sp,-16
    80001c74:	00813423          	sd	s0,8(sp)
    80001c78:	01010413          	addi	s0,sp,16
    80001c7c:	00020793          	mv	a5,tp
    80001c80:	00813403          	ld	s0,8(sp)
    80001c84:	0007879b          	sext.w	a5,a5
    80001c88:	00779793          	slli	a5,a5,0x7
    80001c8c:	00004517          	auipc	a0,0x4
    80001c90:	97450513          	addi	a0,a0,-1676 # 80005600 <cpus>
    80001c94:	00f50533          	add	a0,a0,a5
    80001c98:	01010113          	addi	sp,sp,16
    80001c9c:	00008067          	ret

0000000080001ca0 <userinit>:
    80001ca0:	ff010113          	addi	sp,sp,-16
    80001ca4:	00813423          	sd	s0,8(sp)
    80001ca8:	01010413          	addi	s0,sp,16
    80001cac:	00813403          	ld	s0,8(sp)
    80001cb0:	01010113          	addi	sp,sp,16
    80001cb4:	00000317          	auipc	t1,0x0
    80001cb8:	82c30067          	jr	-2004(t1) # 800014e0 <main>

0000000080001cbc <either_copyout>:
    80001cbc:	ff010113          	addi	sp,sp,-16
    80001cc0:	00813023          	sd	s0,0(sp)
    80001cc4:	00113423          	sd	ra,8(sp)
    80001cc8:	01010413          	addi	s0,sp,16
    80001ccc:	02051663          	bnez	a0,80001cf8 <either_copyout+0x3c>
    80001cd0:	00058513          	mv	a0,a1
    80001cd4:	00060593          	mv	a1,a2
    80001cd8:	0006861b          	sext.w	a2,a3
    80001cdc:	00002097          	auipc	ra,0x2
    80001ce0:	c58080e7          	jalr	-936(ra) # 80003934 <__memmove>
    80001ce4:	00813083          	ld	ra,8(sp)
    80001ce8:	00013403          	ld	s0,0(sp)
    80001cec:	00000513          	li	a0,0
    80001cf0:	01010113          	addi	sp,sp,16
    80001cf4:	00008067          	ret
    80001cf8:	00002517          	auipc	a0,0x2
    80001cfc:	39050513          	addi	a0,a0,912 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001d00:	00001097          	auipc	ra,0x1
    80001d04:	92c080e7          	jalr	-1748(ra) # 8000262c <panic>

0000000080001d08 <either_copyin>:
    80001d08:	ff010113          	addi	sp,sp,-16
    80001d0c:	00813023          	sd	s0,0(sp)
    80001d10:	00113423          	sd	ra,8(sp)
    80001d14:	01010413          	addi	s0,sp,16
    80001d18:	02059463          	bnez	a1,80001d40 <either_copyin+0x38>
    80001d1c:	00060593          	mv	a1,a2
    80001d20:	0006861b          	sext.w	a2,a3
    80001d24:	00002097          	auipc	ra,0x2
    80001d28:	c10080e7          	jalr	-1008(ra) # 80003934 <__memmove>
    80001d2c:	00813083          	ld	ra,8(sp)
    80001d30:	00013403          	ld	s0,0(sp)
    80001d34:	00000513          	li	a0,0
    80001d38:	01010113          	addi	sp,sp,16
    80001d3c:	00008067          	ret
    80001d40:	00002517          	auipc	a0,0x2
    80001d44:	37050513          	addi	a0,a0,880 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    80001d48:	00001097          	auipc	ra,0x1
    80001d4c:	8e4080e7          	jalr	-1820(ra) # 8000262c <panic>

0000000080001d50 <trapinit>:
    80001d50:	ff010113          	addi	sp,sp,-16
    80001d54:	00813423          	sd	s0,8(sp)
    80001d58:	01010413          	addi	s0,sp,16
    80001d5c:	00813403          	ld	s0,8(sp)
    80001d60:	00002597          	auipc	a1,0x2
    80001d64:	37858593          	addi	a1,a1,888 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    80001d68:	00004517          	auipc	a0,0x4
    80001d6c:	91850513          	addi	a0,a0,-1768 # 80005680 <tickslock>
    80001d70:	01010113          	addi	sp,sp,16
    80001d74:	00001317          	auipc	t1,0x1
    80001d78:	5c430067          	jr	1476(t1) # 80003338 <initlock>

0000000080001d7c <trapinithart>:
    80001d7c:	ff010113          	addi	sp,sp,-16
    80001d80:	00813423          	sd	s0,8(sp)
    80001d84:	01010413          	addi	s0,sp,16
    80001d88:	00000797          	auipc	a5,0x0
    80001d8c:	2f878793          	addi	a5,a5,760 # 80002080 <kernelvec>
    80001d90:	10579073          	csrw	stvec,a5
    80001d94:	00813403          	ld	s0,8(sp)
    80001d98:	01010113          	addi	sp,sp,16
    80001d9c:	00008067          	ret

0000000080001da0 <usertrap>:
    80001da0:	ff010113          	addi	sp,sp,-16
    80001da4:	00813423          	sd	s0,8(sp)
    80001da8:	01010413          	addi	s0,sp,16
    80001dac:	00813403          	ld	s0,8(sp)
    80001db0:	01010113          	addi	sp,sp,16
    80001db4:	00008067          	ret

0000000080001db8 <usertrapret>:
    80001db8:	ff010113          	addi	sp,sp,-16
    80001dbc:	00813423          	sd	s0,8(sp)
    80001dc0:	01010413          	addi	s0,sp,16
    80001dc4:	00813403          	ld	s0,8(sp)
    80001dc8:	01010113          	addi	sp,sp,16
    80001dcc:	00008067          	ret

0000000080001dd0 <kerneltrap>:
    80001dd0:	fe010113          	addi	sp,sp,-32
    80001dd4:	00813823          	sd	s0,16(sp)
    80001dd8:	00113c23          	sd	ra,24(sp)
    80001ddc:	00913423          	sd	s1,8(sp)
    80001de0:	02010413          	addi	s0,sp,32
    80001de4:	142025f3          	csrr	a1,scause
    80001de8:	100027f3          	csrr	a5,sstatus
    80001dec:	0027f793          	andi	a5,a5,2
    80001df0:	10079c63          	bnez	a5,80001f08 <kerneltrap+0x138>
    80001df4:	142027f3          	csrr	a5,scause
    80001df8:	0207ce63          	bltz	a5,80001e34 <kerneltrap+0x64>
    80001dfc:	00002517          	auipc	a0,0x2
    80001e00:	32450513          	addi	a0,a0,804 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001e04:	00001097          	auipc	ra,0x1
    80001e08:	884080e7          	jalr	-1916(ra) # 80002688 <__printf>
    80001e0c:	141025f3          	csrr	a1,sepc
    80001e10:	14302673          	csrr	a2,stval
    80001e14:	00002517          	auipc	a0,0x2
    80001e18:	31c50513          	addi	a0,a0,796 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001e1c:	00001097          	auipc	ra,0x1
    80001e20:	86c080e7          	jalr	-1940(ra) # 80002688 <__printf>
    80001e24:	00002517          	auipc	a0,0x2
    80001e28:	32450513          	addi	a0,a0,804 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001e2c:	00001097          	auipc	ra,0x1
    80001e30:	800080e7          	jalr	-2048(ra) # 8000262c <panic>
    80001e34:	0ff7f713          	andi	a4,a5,255
    80001e38:	00900693          	li	a3,9
    80001e3c:	04d70063          	beq	a4,a3,80001e7c <kerneltrap+0xac>
    80001e40:	fff00713          	li	a4,-1
    80001e44:	03f71713          	slli	a4,a4,0x3f
    80001e48:	00170713          	addi	a4,a4,1
    80001e4c:	fae798e3          	bne	a5,a4,80001dfc <kerneltrap+0x2c>
    80001e50:	00000097          	auipc	ra,0x0
    80001e54:	e00080e7          	jalr	-512(ra) # 80001c50 <cpuid>
    80001e58:	06050663          	beqz	a0,80001ec4 <kerneltrap+0xf4>
    80001e5c:	144027f3          	csrr	a5,sip
    80001e60:	ffd7f793          	andi	a5,a5,-3
    80001e64:	14479073          	csrw	sip,a5
    80001e68:	01813083          	ld	ra,24(sp)
    80001e6c:	01013403          	ld	s0,16(sp)
    80001e70:	00813483          	ld	s1,8(sp)
    80001e74:	02010113          	addi	sp,sp,32
    80001e78:	00008067          	ret
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	3c8080e7          	jalr	968(ra) # 80002244 <plic_claim>
    80001e84:	00a00793          	li	a5,10
    80001e88:	00050493          	mv	s1,a0
    80001e8c:	06f50863          	beq	a0,a5,80001efc <kerneltrap+0x12c>
    80001e90:	fc050ce3          	beqz	a0,80001e68 <kerneltrap+0x98>
    80001e94:	00050593          	mv	a1,a0
    80001e98:	00002517          	auipc	a0,0x2
    80001e9c:	26850513          	addi	a0,a0,616 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	7e8080e7          	jalr	2024(ra) # 80002688 <__printf>
    80001ea8:	01013403          	ld	s0,16(sp)
    80001eac:	01813083          	ld	ra,24(sp)
    80001eb0:	00048513          	mv	a0,s1
    80001eb4:	00813483          	ld	s1,8(sp)
    80001eb8:	02010113          	addi	sp,sp,32
    80001ebc:	00000317          	auipc	t1,0x0
    80001ec0:	3c030067          	jr	960(t1) # 8000227c <plic_complete>
    80001ec4:	00003517          	auipc	a0,0x3
    80001ec8:	7bc50513          	addi	a0,a0,1980 # 80005680 <tickslock>
    80001ecc:	00001097          	auipc	ra,0x1
    80001ed0:	490080e7          	jalr	1168(ra) # 8000335c <acquire>
    80001ed4:	00002717          	auipc	a4,0x2
    80001ed8:	6a070713          	addi	a4,a4,1696 # 80004574 <ticks>
    80001edc:	00072783          	lw	a5,0(a4)
    80001ee0:	00003517          	auipc	a0,0x3
    80001ee4:	7a050513          	addi	a0,a0,1952 # 80005680 <tickslock>
    80001ee8:	0017879b          	addiw	a5,a5,1
    80001eec:	00f72023          	sw	a5,0(a4)
    80001ef0:	00001097          	auipc	ra,0x1
    80001ef4:	538080e7          	jalr	1336(ra) # 80003428 <release>
    80001ef8:	f65ff06f          	j	80001e5c <kerneltrap+0x8c>
    80001efc:	00001097          	auipc	ra,0x1
    80001f00:	094080e7          	jalr	148(ra) # 80002f90 <uartintr>
    80001f04:	fa5ff06f          	j	80001ea8 <kerneltrap+0xd8>
    80001f08:	00002517          	auipc	a0,0x2
    80001f0c:	1d850513          	addi	a0,a0,472 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	71c080e7          	jalr	1820(ra) # 8000262c <panic>

0000000080001f18 <clockintr>:
    80001f18:	fe010113          	addi	sp,sp,-32
    80001f1c:	00813823          	sd	s0,16(sp)
    80001f20:	00913423          	sd	s1,8(sp)
    80001f24:	00113c23          	sd	ra,24(sp)
    80001f28:	02010413          	addi	s0,sp,32
    80001f2c:	00003497          	auipc	s1,0x3
    80001f30:	75448493          	addi	s1,s1,1876 # 80005680 <tickslock>
    80001f34:	00048513          	mv	a0,s1
    80001f38:	00001097          	auipc	ra,0x1
    80001f3c:	424080e7          	jalr	1060(ra) # 8000335c <acquire>
    80001f40:	00002717          	auipc	a4,0x2
    80001f44:	63470713          	addi	a4,a4,1588 # 80004574 <ticks>
    80001f48:	00072783          	lw	a5,0(a4)
    80001f4c:	01013403          	ld	s0,16(sp)
    80001f50:	01813083          	ld	ra,24(sp)
    80001f54:	00048513          	mv	a0,s1
    80001f58:	0017879b          	addiw	a5,a5,1
    80001f5c:	00813483          	ld	s1,8(sp)
    80001f60:	00f72023          	sw	a5,0(a4)
    80001f64:	02010113          	addi	sp,sp,32
    80001f68:	00001317          	auipc	t1,0x1
    80001f6c:	4c030067          	jr	1216(t1) # 80003428 <release>

0000000080001f70 <devintr>:
    80001f70:	142027f3          	csrr	a5,scause
    80001f74:	00000513          	li	a0,0
    80001f78:	0007c463          	bltz	a5,80001f80 <devintr+0x10>
    80001f7c:	00008067          	ret
    80001f80:	fe010113          	addi	sp,sp,-32
    80001f84:	00813823          	sd	s0,16(sp)
    80001f88:	00113c23          	sd	ra,24(sp)
    80001f8c:	00913423          	sd	s1,8(sp)
    80001f90:	02010413          	addi	s0,sp,32
    80001f94:	0ff7f713          	andi	a4,a5,255
    80001f98:	00900693          	li	a3,9
    80001f9c:	04d70c63          	beq	a4,a3,80001ff4 <devintr+0x84>
    80001fa0:	fff00713          	li	a4,-1
    80001fa4:	03f71713          	slli	a4,a4,0x3f
    80001fa8:	00170713          	addi	a4,a4,1
    80001fac:	00e78c63          	beq	a5,a4,80001fc4 <devintr+0x54>
    80001fb0:	01813083          	ld	ra,24(sp)
    80001fb4:	01013403          	ld	s0,16(sp)
    80001fb8:	00813483          	ld	s1,8(sp)
    80001fbc:	02010113          	addi	sp,sp,32
    80001fc0:	00008067          	ret
    80001fc4:	00000097          	auipc	ra,0x0
    80001fc8:	c8c080e7          	jalr	-884(ra) # 80001c50 <cpuid>
    80001fcc:	06050663          	beqz	a0,80002038 <devintr+0xc8>
    80001fd0:	144027f3          	csrr	a5,sip
    80001fd4:	ffd7f793          	andi	a5,a5,-3
    80001fd8:	14479073          	csrw	sip,a5
    80001fdc:	01813083          	ld	ra,24(sp)
    80001fe0:	01013403          	ld	s0,16(sp)
    80001fe4:	00813483          	ld	s1,8(sp)
    80001fe8:	00200513          	li	a0,2
    80001fec:	02010113          	addi	sp,sp,32
    80001ff0:	00008067          	ret
    80001ff4:	00000097          	auipc	ra,0x0
    80001ff8:	250080e7          	jalr	592(ra) # 80002244 <plic_claim>
    80001ffc:	00a00793          	li	a5,10
    80002000:	00050493          	mv	s1,a0
    80002004:	06f50663          	beq	a0,a5,80002070 <devintr+0x100>
    80002008:	00100513          	li	a0,1
    8000200c:	fa0482e3          	beqz	s1,80001fb0 <devintr+0x40>
    80002010:	00048593          	mv	a1,s1
    80002014:	00002517          	auipc	a0,0x2
    80002018:	0ec50513          	addi	a0,a0,236 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    8000201c:	00000097          	auipc	ra,0x0
    80002020:	66c080e7          	jalr	1644(ra) # 80002688 <__printf>
    80002024:	00048513          	mv	a0,s1
    80002028:	00000097          	auipc	ra,0x0
    8000202c:	254080e7          	jalr	596(ra) # 8000227c <plic_complete>
    80002030:	00100513          	li	a0,1
    80002034:	f7dff06f          	j	80001fb0 <devintr+0x40>
    80002038:	00003517          	auipc	a0,0x3
    8000203c:	64850513          	addi	a0,a0,1608 # 80005680 <tickslock>
    80002040:	00001097          	auipc	ra,0x1
    80002044:	31c080e7          	jalr	796(ra) # 8000335c <acquire>
    80002048:	00002717          	auipc	a4,0x2
    8000204c:	52c70713          	addi	a4,a4,1324 # 80004574 <ticks>
    80002050:	00072783          	lw	a5,0(a4)
    80002054:	00003517          	auipc	a0,0x3
    80002058:	62c50513          	addi	a0,a0,1580 # 80005680 <tickslock>
    8000205c:	0017879b          	addiw	a5,a5,1
    80002060:	00f72023          	sw	a5,0(a4)
    80002064:	00001097          	auipc	ra,0x1
    80002068:	3c4080e7          	jalr	964(ra) # 80003428 <release>
    8000206c:	f65ff06f          	j	80001fd0 <devintr+0x60>
    80002070:	00001097          	auipc	ra,0x1
    80002074:	f20080e7          	jalr	-224(ra) # 80002f90 <uartintr>
    80002078:	fadff06f          	j	80002024 <devintr+0xb4>
    8000207c:	0000                	unimp
	...

0000000080002080 <kernelvec>:
    80002080:	f0010113          	addi	sp,sp,-256
    80002084:	00113023          	sd	ra,0(sp)
    80002088:	00213423          	sd	sp,8(sp)
    8000208c:	00313823          	sd	gp,16(sp)
    80002090:	00413c23          	sd	tp,24(sp)
    80002094:	02513023          	sd	t0,32(sp)
    80002098:	02613423          	sd	t1,40(sp)
    8000209c:	02713823          	sd	t2,48(sp)
    800020a0:	02813c23          	sd	s0,56(sp)
    800020a4:	04913023          	sd	s1,64(sp)
    800020a8:	04a13423          	sd	a0,72(sp)
    800020ac:	04b13823          	sd	a1,80(sp)
    800020b0:	04c13c23          	sd	a2,88(sp)
    800020b4:	06d13023          	sd	a3,96(sp)
    800020b8:	06e13423          	sd	a4,104(sp)
    800020bc:	06f13823          	sd	a5,112(sp)
    800020c0:	07013c23          	sd	a6,120(sp)
    800020c4:	09113023          	sd	a7,128(sp)
    800020c8:	09213423          	sd	s2,136(sp)
    800020cc:	09313823          	sd	s3,144(sp)
    800020d0:	09413c23          	sd	s4,152(sp)
    800020d4:	0b513023          	sd	s5,160(sp)
    800020d8:	0b613423          	sd	s6,168(sp)
    800020dc:	0b713823          	sd	s7,176(sp)
    800020e0:	0b813c23          	sd	s8,184(sp)
    800020e4:	0d913023          	sd	s9,192(sp)
    800020e8:	0da13423          	sd	s10,200(sp)
    800020ec:	0db13823          	sd	s11,208(sp)
    800020f0:	0dc13c23          	sd	t3,216(sp)
    800020f4:	0fd13023          	sd	t4,224(sp)
    800020f8:	0fe13423          	sd	t5,232(sp)
    800020fc:	0ff13823          	sd	t6,240(sp)
    80002100:	cd1ff0ef          	jal	ra,80001dd0 <kerneltrap>
    80002104:	00013083          	ld	ra,0(sp)
    80002108:	00813103          	ld	sp,8(sp)
    8000210c:	01013183          	ld	gp,16(sp)
    80002110:	02013283          	ld	t0,32(sp)
    80002114:	02813303          	ld	t1,40(sp)
    80002118:	03013383          	ld	t2,48(sp)
    8000211c:	03813403          	ld	s0,56(sp)
    80002120:	04013483          	ld	s1,64(sp)
    80002124:	04813503          	ld	a0,72(sp)
    80002128:	05013583          	ld	a1,80(sp)
    8000212c:	05813603          	ld	a2,88(sp)
    80002130:	06013683          	ld	a3,96(sp)
    80002134:	06813703          	ld	a4,104(sp)
    80002138:	07013783          	ld	a5,112(sp)
    8000213c:	07813803          	ld	a6,120(sp)
    80002140:	08013883          	ld	a7,128(sp)
    80002144:	08813903          	ld	s2,136(sp)
    80002148:	09013983          	ld	s3,144(sp)
    8000214c:	09813a03          	ld	s4,152(sp)
    80002150:	0a013a83          	ld	s5,160(sp)
    80002154:	0a813b03          	ld	s6,168(sp)
    80002158:	0b013b83          	ld	s7,176(sp)
    8000215c:	0b813c03          	ld	s8,184(sp)
    80002160:	0c013c83          	ld	s9,192(sp)
    80002164:	0c813d03          	ld	s10,200(sp)
    80002168:	0d013d83          	ld	s11,208(sp)
    8000216c:	0d813e03          	ld	t3,216(sp)
    80002170:	0e013e83          	ld	t4,224(sp)
    80002174:	0e813f03          	ld	t5,232(sp)
    80002178:	0f013f83          	ld	t6,240(sp)
    8000217c:	10010113          	addi	sp,sp,256
    80002180:	10200073          	sret
    80002184:	00000013          	nop
    80002188:	00000013          	nop
    8000218c:	00000013          	nop

0000000080002190 <timervec>:
    80002190:	34051573          	csrrw	a0,mscratch,a0
    80002194:	00b53023          	sd	a1,0(a0)
    80002198:	00c53423          	sd	a2,8(a0)
    8000219c:	00d53823          	sd	a3,16(a0)
    800021a0:	01853583          	ld	a1,24(a0)
    800021a4:	02053603          	ld	a2,32(a0)
    800021a8:	0005b683          	ld	a3,0(a1)
    800021ac:	00c686b3          	add	a3,a3,a2
    800021b0:	00d5b023          	sd	a3,0(a1)
    800021b4:	00200593          	li	a1,2
    800021b8:	14459073          	csrw	sip,a1
    800021bc:	01053683          	ld	a3,16(a0)
    800021c0:	00853603          	ld	a2,8(a0)
    800021c4:	00053583          	ld	a1,0(a0)
    800021c8:	34051573          	csrrw	a0,mscratch,a0
    800021cc:	30200073          	mret

00000000800021d0 <plicinit>:
    800021d0:	ff010113          	addi	sp,sp,-16
    800021d4:	00813423          	sd	s0,8(sp)
    800021d8:	01010413          	addi	s0,sp,16
    800021dc:	00813403          	ld	s0,8(sp)
    800021e0:	0c0007b7          	lui	a5,0xc000
    800021e4:	00100713          	li	a4,1
    800021e8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800021ec:	00e7a223          	sw	a4,4(a5)
    800021f0:	01010113          	addi	sp,sp,16
    800021f4:	00008067          	ret

00000000800021f8 <plicinithart>:
    800021f8:	ff010113          	addi	sp,sp,-16
    800021fc:	00813023          	sd	s0,0(sp)
    80002200:	00113423          	sd	ra,8(sp)
    80002204:	01010413          	addi	s0,sp,16
    80002208:	00000097          	auipc	ra,0x0
    8000220c:	a48080e7          	jalr	-1464(ra) # 80001c50 <cpuid>
    80002210:	0085171b          	slliw	a4,a0,0x8
    80002214:	0c0027b7          	lui	a5,0xc002
    80002218:	00e787b3          	add	a5,a5,a4
    8000221c:	40200713          	li	a4,1026
    80002220:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002224:	00813083          	ld	ra,8(sp)
    80002228:	00013403          	ld	s0,0(sp)
    8000222c:	00d5151b          	slliw	a0,a0,0xd
    80002230:	0c2017b7          	lui	a5,0xc201
    80002234:	00a78533          	add	a0,a5,a0
    80002238:	00052023          	sw	zero,0(a0)
    8000223c:	01010113          	addi	sp,sp,16
    80002240:	00008067          	ret

0000000080002244 <plic_claim>:
    80002244:	ff010113          	addi	sp,sp,-16
    80002248:	00813023          	sd	s0,0(sp)
    8000224c:	00113423          	sd	ra,8(sp)
    80002250:	01010413          	addi	s0,sp,16
    80002254:	00000097          	auipc	ra,0x0
    80002258:	9fc080e7          	jalr	-1540(ra) # 80001c50 <cpuid>
    8000225c:	00813083          	ld	ra,8(sp)
    80002260:	00013403          	ld	s0,0(sp)
    80002264:	00d5151b          	slliw	a0,a0,0xd
    80002268:	0c2017b7          	lui	a5,0xc201
    8000226c:	00a78533          	add	a0,a5,a0
    80002270:	00452503          	lw	a0,4(a0)
    80002274:	01010113          	addi	sp,sp,16
    80002278:	00008067          	ret

000000008000227c <plic_complete>:
    8000227c:	fe010113          	addi	sp,sp,-32
    80002280:	00813823          	sd	s0,16(sp)
    80002284:	00913423          	sd	s1,8(sp)
    80002288:	00113c23          	sd	ra,24(sp)
    8000228c:	02010413          	addi	s0,sp,32
    80002290:	00050493          	mv	s1,a0
    80002294:	00000097          	auipc	ra,0x0
    80002298:	9bc080e7          	jalr	-1604(ra) # 80001c50 <cpuid>
    8000229c:	01813083          	ld	ra,24(sp)
    800022a0:	01013403          	ld	s0,16(sp)
    800022a4:	00d5179b          	slliw	a5,a0,0xd
    800022a8:	0c201737          	lui	a4,0xc201
    800022ac:	00f707b3          	add	a5,a4,a5
    800022b0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800022b4:	00813483          	ld	s1,8(sp)
    800022b8:	02010113          	addi	sp,sp,32
    800022bc:	00008067          	ret

00000000800022c0 <consolewrite>:
    800022c0:	fb010113          	addi	sp,sp,-80
    800022c4:	04813023          	sd	s0,64(sp)
    800022c8:	04113423          	sd	ra,72(sp)
    800022cc:	02913c23          	sd	s1,56(sp)
    800022d0:	03213823          	sd	s2,48(sp)
    800022d4:	03313423          	sd	s3,40(sp)
    800022d8:	03413023          	sd	s4,32(sp)
    800022dc:	01513c23          	sd	s5,24(sp)
    800022e0:	05010413          	addi	s0,sp,80
    800022e4:	06c05c63          	blez	a2,8000235c <consolewrite+0x9c>
    800022e8:	00060993          	mv	s3,a2
    800022ec:	00050a13          	mv	s4,a0
    800022f0:	00058493          	mv	s1,a1
    800022f4:	00000913          	li	s2,0
    800022f8:	fff00a93          	li	s5,-1
    800022fc:	01c0006f          	j	80002318 <consolewrite+0x58>
    80002300:	fbf44503          	lbu	a0,-65(s0)
    80002304:	0019091b          	addiw	s2,s2,1
    80002308:	00148493          	addi	s1,s1,1
    8000230c:	00001097          	auipc	ra,0x1
    80002310:	a9c080e7          	jalr	-1380(ra) # 80002da8 <uartputc>
    80002314:	03298063          	beq	s3,s2,80002334 <consolewrite+0x74>
    80002318:	00048613          	mv	a2,s1
    8000231c:	00100693          	li	a3,1
    80002320:	000a0593          	mv	a1,s4
    80002324:	fbf40513          	addi	a0,s0,-65
    80002328:	00000097          	auipc	ra,0x0
    8000232c:	9e0080e7          	jalr	-1568(ra) # 80001d08 <either_copyin>
    80002330:	fd5518e3          	bne	a0,s5,80002300 <consolewrite+0x40>
    80002334:	04813083          	ld	ra,72(sp)
    80002338:	04013403          	ld	s0,64(sp)
    8000233c:	03813483          	ld	s1,56(sp)
    80002340:	02813983          	ld	s3,40(sp)
    80002344:	02013a03          	ld	s4,32(sp)
    80002348:	01813a83          	ld	s5,24(sp)
    8000234c:	00090513          	mv	a0,s2
    80002350:	03013903          	ld	s2,48(sp)
    80002354:	05010113          	addi	sp,sp,80
    80002358:	00008067          	ret
    8000235c:	00000913          	li	s2,0
    80002360:	fd5ff06f          	j	80002334 <consolewrite+0x74>

0000000080002364 <consoleread>:
    80002364:	f9010113          	addi	sp,sp,-112
    80002368:	06813023          	sd	s0,96(sp)
    8000236c:	04913c23          	sd	s1,88(sp)
    80002370:	05213823          	sd	s2,80(sp)
    80002374:	05313423          	sd	s3,72(sp)
    80002378:	05413023          	sd	s4,64(sp)
    8000237c:	03513c23          	sd	s5,56(sp)
    80002380:	03613823          	sd	s6,48(sp)
    80002384:	03713423          	sd	s7,40(sp)
    80002388:	03813023          	sd	s8,32(sp)
    8000238c:	06113423          	sd	ra,104(sp)
    80002390:	01913c23          	sd	s9,24(sp)
    80002394:	07010413          	addi	s0,sp,112
    80002398:	00060b93          	mv	s7,a2
    8000239c:	00050913          	mv	s2,a0
    800023a0:	00058c13          	mv	s8,a1
    800023a4:	00060b1b          	sext.w	s6,a2
    800023a8:	00003497          	auipc	s1,0x3
    800023ac:	30048493          	addi	s1,s1,768 # 800056a8 <cons>
    800023b0:	00400993          	li	s3,4
    800023b4:	fff00a13          	li	s4,-1
    800023b8:	00a00a93          	li	s5,10
    800023bc:	05705e63          	blez	s7,80002418 <consoleread+0xb4>
    800023c0:	09c4a703          	lw	a4,156(s1)
    800023c4:	0984a783          	lw	a5,152(s1)
    800023c8:	0007071b          	sext.w	a4,a4
    800023cc:	08e78463          	beq	a5,a4,80002454 <consoleread+0xf0>
    800023d0:	07f7f713          	andi	a4,a5,127
    800023d4:	00e48733          	add	a4,s1,a4
    800023d8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800023dc:	0017869b          	addiw	a3,a5,1
    800023e0:	08d4ac23          	sw	a3,152(s1)
    800023e4:	00070c9b          	sext.w	s9,a4
    800023e8:	0b370663          	beq	a4,s3,80002494 <consoleread+0x130>
    800023ec:	00100693          	li	a3,1
    800023f0:	f9f40613          	addi	a2,s0,-97
    800023f4:	000c0593          	mv	a1,s8
    800023f8:	00090513          	mv	a0,s2
    800023fc:	f8e40fa3          	sb	a4,-97(s0)
    80002400:	00000097          	auipc	ra,0x0
    80002404:	8bc080e7          	jalr	-1860(ra) # 80001cbc <either_copyout>
    80002408:	01450863          	beq	a0,s4,80002418 <consoleread+0xb4>
    8000240c:	001c0c13          	addi	s8,s8,1
    80002410:	fffb8b9b          	addiw	s7,s7,-1
    80002414:	fb5c94e3          	bne	s9,s5,800023bc <consoleread+0x58>
    80002418:	000b851b          	sext.w	a0,s7
    8000241c:	06813083          	ld	ra,104(sp)
    80002420:	06013403          	ld	s0,96(sp)
    80002424:	05813483          	ld	s1,88(sp)
    80002428:	05013903          	ld	s2,80(sp)
    8000242c:	04813983          	ld	s3,72(sp)
    80002430:	04013a03          	ld	s4,64(sp)
    80002434:	03813a83          	ld	s5,56(sp)
    80002438:	02813b83          	ld	s7,40(sp)
    8000243c:	02013c03          	ld	s8,32(sp)
    80002440:	01813c83          	ld	s9,24(sp)
    80002444:	40ab053b          	subw	a0,s6,a0
    80002448:	03013b03          	ld	s6,48(sp)
    8000244c:	07010113          	addi	sp,sp,112
    80002450:	00008067          	ret
    80002454:	00001097          	auipc	ra,0x1
    80002458:	1d8080e7          	jalr	472(ra) # 8000362c <push_on>
    8000245c:	0984a703          	lw	a4,152(s1)
    80002460:	09c4a783          	lw	a5,156(s1)
    80002464:	0007879b          	sext.w	a5,a5
    80002468:	fef70ce3          	beq	a4,a5,80002460 <consoleread+0xfc>
    8000246c:	00001097          	auipc	ra,0x1
    80002470:	234080e7          	jalr	564(ra) # 800036a0 <pop_on>
    80002474:	0984a783          	lw	a5,152(s1)
    80002478:	07f7f713          	andi	a4,a5,127
    8000247c:	00e48733          	add	a4,s1,a4
    80002480:	01874703          	lbu	a4,24(a4)
    80002484:	0017869b          	addiw	a3,a5,1
    80002488:	08d4ac23          	sw	a3,152(s1)
    8000248c:	00070c9b          	sext.w	s9,a4
    80002490:	f5371ee3          	bne	a4,s3,800023ec <consoleread+0x88>
    80002494:	000b851b          	sext.w	a0,s7
    80002498:	f96bf2e3          	bgeu	s7,s6,8000241c <consoleread+0xb8>
    8000249c:	08f4ac23          	sw	a5,152(s1)
    800024a0:	f7dff06f          	j	8000241c <consoleread+0xb8>

00000000800024a4 <consputc>:
    800024a4:	10000793          	li	a5,256
    800024a8:	00f50663          	beq	a0,a5,800024b4 <consputc+0x10>
    800024ac:	00001317          	auipc	t1,0x1
    800024b0:	9f430067          	jr	-1548(t1) # 80002ea0 <uartputc_sync>
    800024b4:	ff010113          	addi	sp,sp,-16
    800024b8:	00113423          	sd	ra,8(sp)
    800024bc:	00813023          	sd	s0,0(sp)
    800024c0:	01010413          	addi	s0,sp,16
    800024c4:	00800513          	li	a0,8
    800024c8:	00001097          	auipc	ra,0x1
    800024cc:	9d8080e7          	jalr	-1576(ra) # 80002ea0 <uartputc_sync>
    800024d0:	02000513          	li	a0,32
    800024d4:	00001097          	auipc	ra,0x1
    800024d8:	9cc080e7          	jalr	-1588(ra) # 80002ea0 <uartputc_sync>
    800024dc:	00013403          	ld	s0,0(sp)
    800024e0:	00813083          	ld	ra,8(sp)
    800024e4:	00800513          	li	a0,8
    800024e8:	01010113          	addi	sp,sp,16
    800024ec:	00001317          	auipc	t1,0x1
    800024f0:	9b430067          	jr	-1612(t1) # 80002ea0 <uartputc_sync>

00000000800024f4 <consoleintr>:
    800024f4:	fe010113          	addi	sp,sp,-32
    800024f8:	00813823          	sd	s0,16(sp)
    800024fc:	00913423          	sd	s1,8(sp)
    80002500:	01213023          	sd	s2,0(sp)
    80002504:	00113c23          	sd	ra,24(sp)
    80002508:	02010413          	addi	s0,sp,32
    8000250c:	00003917          	auipc	s2,0x3
    80002510:	19c90913          	addi	s2,s2,412 # 800056a8 <cons>
    80002514:	00050493          	mv	s1,a0
    80002518:	00090513          	mv	a0,s2
    8000251c:	00001097          	auipc	ra,0x1
    80002520:	e40080e7          	jalr	-448(ra) # 8000335c <acquire>
    80002524:	02048c63          	beqz	s1,8000255c <consoleintr+0x68>
    80002528:	0a092783          	lw	a5,160(s2)
    8000252c:	09892703          	lw	a4,152(s2)
    80002530:	07f00693          	li	a3,127
    80002534:	40e7873b          	subw	a4,a5,a4
    80002538:	02e6e263          	bltu	a3,a4,8000255c <consoleintr+0x68>
    8000253c:	00d00713          	li	a4,13
    80002540:	04e48063          	beq	s1,a4,80002580 <consoleintr+0x8c>
    80002544:	07f7f713          	andi	a4,a5,127
    80002548:	00e90733          	add	a4,s2,a4
    8000254c:	0017879b          	addiw	a5,a5,1
    80002550:	0af92023          	sw	a5,160(s2)
    80002554:	00970c23          	sb	s1,24(a4)
    80002558:	08f92e23          	sw	a5,156(s2)
    8000255c:	01013403          	ld	s0,16(sp)
    80002560:	01813083          	ld	ra,24(sp)
    80002564:	00813483          	ld	s1,8(sp)
    80002568:	00013903          	ld	s2,0(sp)
    8000256c:	00003517          	auipc	a0,0x3
    80002570:	13c50513          	addi	a0,a0,316 # 800056a8 <cons>
    80002574:	02010113          	addi	sp,sp,32
    80002578:	00001317          	auipc	t1,0x1
    8000257c:	eb030067          	jr	-336(t1) # 80003428 <release>
    80002580:	00a00493          	li	s1,10
    80002584:	fc1ff06f          	j	80002544 <consoleintr+0x50>

0000000080002588 <consoleinit>:
    80002588:	fe010113          	addi	sp,sp,-32
    8000258c:	00113c23          	sd	ra,24(sp)
    80002590:	00813823          	sd	s0,16(sp)
    80002594:	00913423          	sd	s1,8(sp)
    80002598:	02010413          	addi	s0,sp,32
    8000259c:	00003497          	auipc	s1,0x3
    800025a0:	10c48493          	addi	s1,s1,268 # 800056a8 <cons>
    800025a4:	00048513          	mv	a0,s1
    800025a8:	00002597          	auipc	a1,0x2
    800025ac:	bb058593          	addi	a1,a1,-1104 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    800025b0:	00001097          	auipc	ra,0x1
    800025b4:	d88080e7          	jalr	-632(ra) # 80003338 <initlock>
    800025b8:	00000097          	auipc	ra,0x0
    800025bc:	7ac080e7          	jalr	1964(ra) # 80002d64 <uartinit>
    800025c0:	01813083          	ld	ra,24(sp)
    800025c4:	01013403          	ld	s0,16(sp)
    800025c8:	00000797          	auipc	a5,0x0
    800025cc:	d9c78793          	addi	a5,a5,-612 # 80002364 <consoleread>
    800025d0:	0af4bc23          	sd	a5,184(s1)
    800025d4:	00000797          	auipc	a5,0x0
    800025d8:	cec78793          	addi	a5,a5,-788 # 800022c0 <consolewrite>
    800025dc:	0cf4b023          	sd	a5,192(s1)
    800025e0:	00813483          	ld	s1,8(sp)
    800025e4:	02010113          	addi	sp,sp,32
    800025e8:	00008067          	ret

00000000800025ec <console_read>:
    800025ec:	ff010113          	addi	sp,sp,-16
    800025f0:	00813423          	sd	s0,8(sp)
    800025f4:	01010413          	addi	s0,sp,16
    800025f8:	00813403          	ld	s0,8(sp)
    800025fc:	00003317          	auipc	t1,0x3
    80002600:	16433303          	ld	t1,356(t1) # 80005760 <devsw+0x10>
    80002604:	01010113          	addi	sp,sp,16
    80002608:	00030067          	jr	t1

000000008000260c <console_write>:
    8000260c:	ff010113          	addi	sp,sp,-16
    80002610:	00813423          	sd	s0,8(sp)
    80002614:	01010413          	addi	s0,sp,16
    80002618:	00813403          	ld	s0,8(sp)
    8000261c:	00003317          	auipc	t1,0x3
    80002620:	14c33303          	ld	t1,332(t1) # 80005768 <devsw+0x18>
    80002624:	01010113          	addi	sp,sp,16
    80002628:	00030067          	jr	t1

000000008000262c <panic>:
    8000262c:	fe010113          	addi	sp,sp,-32
    80002630:	00113c23          	sd	ra,24(sp)
    80002634:	00813823          	sd	s0,16(sp)
    80002638:	00913423          	sd	s1,8(sp)
    8000263c:	02010413          	addi	s0,sp,32
    80002640:	00050493          	mv	s1,a0
    80002644:	00002517          	auipc	a0,0x2
    80002648:	b1c50513          	addi	a0,a0,-1252 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    8000264c:	00003797          	auipc	a5,0x3
    80002650:	1a07ae23          	sw	zero,444(a5) # 80005808 <pr+0x18>
    80002654:	00000097          	auipc	ra,0x0
    80002658:	034080e7          	jalr	52(ra) # 80002688 <__printf>
    8000265c:	00048513          	mv	a0,s1
    80002660:	00000097          	auipc	ra,0x0
    80002664:	028080e7          	jalr	40(ra) # 80002688 <__printf>
    80002668:	00002517          	auipc	a0,0x2
    8000266c:	ad850513          	addi	a0,a0,-1320 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80002670:	00000097          	auipc	ra,0x0
    80002674:	018080e7          	jalr	24(ra) # 80002688 <__printf>
    80002678:	00100793          	li	a5,1
    8000267c:	00002717          	auipc	a4,0x2
    80002680:	eef72e23          	sw	a5,-260(a4) # 80004578 <panicked>
    80002684:	0000006f          	j	80002684 <panic+0x58>

0000000080002688 <__printf>:
    80002688:	f3010113          	addi	sp,sp,-208
    8000268c:	08813023          	sd	s0,128(sp)
    80002690:	07313423          	sd	s3,104(sp)
    80002694:	09010413          	addi	s0,sp,144
    80002698:	05813023          	sd	s8,64(sp)
    8000269c:	08113423          	sd	ra,136(sp)
    800026a0:	06913c23          	sd	s1,120(sp)
    800026a4:	07213823          	sd	s2,112(sp)
    800026a8:	07413023          	sd	s4,96(sp)
    800026ac:	05513c23          	sd	s5,88(sp)
    800026b0:	05613823          	sd	s6,80(sp)
    800026b4:	05713423          	sd	s7,72(sp)
    800026b8:	03913c23          	sd	s9,56(sp)
    800026bc:	03a13823          	sd	s10,48(sp)
    800026c0:	03b13423          	sd	s11,40(sp)
    800026c4:	00003317          	auipc	t1,0x3
    800026c8:	12c30313          	addi	t1,t1,300 # 800057f0 <pr>
    800026cc:	01832c03          	lw	s8,24(t1)
    800026d0:	00b43423          	sd	a1,8(s0)
    800026d4:	00c43823          	sd	a2,16(s0)
    800026d8:	00d43c23          	sd	a3,24(s0)
    800026dc:	02e43023          	sd	a4,32(s0)
    800026e0:	02f43423          	sd	a5,40(s0)
    800026e4:	03043823          	sd	a6,48(s0)
    800026e8:	03143c23          	sd	a7,56(s0)
    800026ec:	00050993          	mv	s3,a0
    800026f0:	4a0c1663          	bnez	s8,80002b9c <__printf+0x514>
    800026f4:	60098c63          	beqz	s3,80002d0c <__printf+0x684>
    800026f8:	0009c503          	lbu	a0,0(s3)
    800026fc:	00840793          	addi	a5,s0,8
    80002700:	f6f43c23          	sd	a5,-136(s0)
    80002704:	00000493          	li	s1,0
    80002708:	22050063          	beqz	a0,80002928 <__printf+0x2a0>
    8000270c:	00002a37          	lui	s4,0x2
    80002710:	00018ab7          	lui	s5,0x18
    80002714:	000f4b37          	lui	s6,0xf4
    80002718:	00989bb7          	lui	s7,0x989
    8000271c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002720:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002724:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002728:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000272c:	00148c9b          	addiw	s9,s1,1
    80002730:	02500793          	li	a5,37
    80002734:	01998933          	add	s2,s3,s9
    80002738:	38f51263          	bne	a0,a5,80002abc <__printf+0x434>
    8000273c:	00094783          	lbu	a5,0(s2)
    80002740:	00078c9b          	sext.w	s9,a5
    80002744:	1e078263          	beqz	a5,80002928 <__printf+0x2a0>
    80002748:	0024849b          	addiw	s1,s1,2
    8000274c:	07000713          	li	a4,112
    80002750:	00998933          	add	s2,s3,s1
    80002754:	38e78a63          	beq	a5,a4,80002ae8 <__printf+0x460>
    80002758:	20f76863          	bltu	a4,a5,80002968 <__printf+0x2e0>
    8000275c:	42a78863          	beq	a5,a0,80002b8c <__printf+0x504>
    80002760:	06400713          	li	a4,100
    80002764:	40e79663          	bne	a5,a4,80002b70 <__printf+0x4e8>
    80002768:	f7843783          	ld	a5,-136(s0)
    8000276c:	0007a603          	lw	a2,0(a5)
    80002770:	00878793          	addi	a5,a5,8
    80002774:	f6f43c23          	sd	a5,-136(s0)
    80002778:	42064a63          	bltz	a2,80002bac <__printf+0x524>
    8000277c:	00a00713          	li	a4,10
    80002780:	02e677bb          	remuw	a5,a2,a4
    80002784:	00002d97          	auipc	s11,0x2
    80002788:	a04d8d93          	addi	s11,s11,-1532 # 80004188 <digits>
    8000278c:	00900593          	li	a1,9
    80002790:	0006051b          	sext.w	a0,a2
    80002794:	00000c93          	li	s9,0
    80002798:	02079793          	slli	a5,a5,0x20
    8000279c:	0207d793          	srli	a5,a5,0x20
    800027a0:	00fd87b3          	add	a5,s11,a5
    800027a4:	0007c783          	lbu	a5,0(a5)
    800027a8:	02e656bb          	divuw	a3,a2,a4
    800027ac:	f8f40023          	sb	a5,-128(s0)
    800027b0:	14c5d863          	bge	a1,a2,80002900 <__printf+0x278>
    800027b4:	06300593          	li	a1,99
    800027b8:	00100c93          	li	s9,1
    800027bc:	02e6f7bb          	remuw	a5,a3,a4
    800027c0:	02079793          	slli	a5,a5,0x20
    800027c4:	0207d793          	srli	a5,a5,0x20
    800027c8:	00fd87b3          	add	a5,s11,a5
    800027cc:	0007c783          	lbu	a5,0(a5)
    800027d0:	02e6d73b          	divuw	a4,a3,a4
    800027d4:	f8f400a3          	sb	a5,-127(s0)
    800027d8:	12a5f463          	bgeu	a1,a0,80002900 <__printf+0x278>
    800027dc:	00a00693          	li	a3,10
    800027e0:	00900593          	li	a1,9
    800027e4:	02d777bb          	remuw	a5,a4,a3
    800027e8:	02079793          	slli	a5,a5,0x20
    800027ec:	0207d793          	srli	a5,a5,0x20
    800027f0:	00fd87b3          	add	a5,s11,a5
    800027f4:	0007c503          	lbu	a0,0(a5)
    800027f8:	02d757bb          	divuw	a5,a4,a3
    800027fc:	f8a40123          	sb	a0,-126(s0)
    80002800:	48e5f263          	bgeu	a1,a4,80002c84 <__printf+0x5fc>
    80002804:	06300513          	li	a0,99
    80002808:	02d7f5bb          	remuw	a1,a5,a3
    8000280c:	02059593          	slli	a1,a1,0x20
    80002810:	0205d593          	srli	a1,a1,0x20
    80002814:	00bd85b3          	add	a1,s11,a1
    80002818:	0005c583          	lbu	a1,0(a1)
    8000281c:	02d7d7bb          	divuw	a5,a5,a3
    80002820:	f8b401a3          	sb	a1,-125(s0)
    80002824:	48e57263          	bgeu	a0,a4,80002ca8 <__printf+0x620>
    80002828:	3e700513          	li	a0,999
    8000282c:	02d7f5bb          	remuw	a1,a5,a3
    80002830:	02059593          	slli	a1,a1,0x20
    80002834:	0205d593          	srli	a1,a1,0x20
    80002838:	00bd85b3          	add	a1,s11,a1
    8000283c:	0005c583          	lbu	a1,0(a1)
    80002840:	02d7d7bb          	divuw	a5,a5,a3
    80002844:	f8b40223          	sb	a1,-124(s0)
    80002848:	46e57663          	bgeu	a0,a4,80002cb4 <__printf+0x62c>
    8000284c:	02d7f5bb          	remuw	a1,a5,a3
    80002850:	02059593          	slli	a1,a1,0x20
    80002854:	0205d593          	srli	a1,a1,0x20
    80002858:	00bd85b3          	add	a1,s11,a1
    8000285c:	0005c583          	lbu	a1,0(a1)
    80002860:	02d7d7bb          	divuw	a5,a5,a3
    80002864:	f8b402a3          	sb	a1,-123(s0)
    80002868:	46ea7863          	bgeu	s4,a4,80002cd8 <__printf+0x650>
    8000286c:	02d7f5bb          	remuw	a1,a5,a3
    80002870:	02059593          	slli	a1,a1,0x20
    80002874:	0205d593          	srli	a1,a1,0x20
    80002878:	00bd85b3          	add	a1,s11,a1
    8000287c:	0005c583          	lbu	a1,0(a1)
    80002880:	02d7d7bb          	divuw	a5,a5,a3
    80002884:	f8b40323          	sb	a1,-122(s0)
    80002888:	3eeaf863          	bgeu	s5,a4,80002c78 <__printf+0x5f0>
    8000288c:	02d7f5bb          	remuw	a1,a5,a3
    80002890:	02059593          	slli	a1,a1,0x20
    80002894:	0205d593          	srli	a1,a1,0x20
    80002898:	00bd85b3          	add	a1,s11,a1
    8000289c:	0005c583          	lbu	a1,0(a1)
    800028a0:	02d7d7bb          	divuw	a5,a5,a3
    800028a4:	f8b403a3          	sb	a1,-121(s0)
    800028a8:	42eb7e63          	bgeu	s6,a4,80002ce4 <__printf+0x65c>
    800028ac:	02d7f5bb          	remuw	a1,a5,a3
    800028b0:	02059593          	slli	a1,a1,0x20
    800028b4:	0205d593          	srli	a1,a1,0x20
    800028b8:	00bd85b3          	add	a1,s11,a1
    800028bc:	0005c583          	lbu	a1,0(a1)
    800028c0:	02d7d7bb          	divuw	a5,a5,a3
    800028c4:	f8b40423          	sb	a1,-120(s0)
    800028c8:	42ebfc63          	bgeu	s7,a4,80002d00 <__printf+0x678>
    800028cc:	02079793          	slli	a5,a5,0x20
    800028d0:	0207d793          	srli	a5,a5,0x20
    800028d4:	00fd8db3          	add	s11,s11,a5
    800028d8:	000dc703          	lbu	a4,0(s11)
    800028dc:	00a00793          	li	a5,10
    800028e0:	00900c93          	li	s9,9
    800028e4:	f8e404a3          	sb	a4,-119(s0)
    800028e8:	00065c63          	bgez	a2,80002900 <__printf+0x278>
    800028ec:	f9040713          	addi	a4,s0,-112
    800028f0:	00f70733          	add	a4,a4,a5
    800028f4:	02d00693          	li	a3,45
    800028f8:	fed70823          	sb	a3,-16(a4)
    800028fc:	00078c93          	mv	s9,a5
    80002900:	f8040793          	addi	a5,s0,-128
    80002904:	01978cb3          	add	s9,a5,s9
    80002908:	f7f40d13          	addi	s10,s0,-129
    8000290c:	000cc503          	lbu	a0,0(s9)
    80002910:	fffc8c93          	addi	s9,s9,-1
    80002914:	00000097          	auipc	ra,0x0
    80002918:	b90080e7          	jalr	-1136(ra) # 800024a4 <consputc>
    8000291c:	ffac98e3          	bne	s9,s10,8000290c <__printf+0x284>
    80002920:	00094503          	lbu	a0,0(s2)
    80002924:	e00514e3          	bnez	a0,8000272c <__printf+0xa4>
    80002928:	1a0c1663          	bnez	s8,80002ad4 <__printf+0x44c>
    8000292c:	08813083          	ld	ra,136(sp)
    80002930:	08013403          	ld	s0,128(sp)
    80002934:	07813483          	ld	s1,120(sp)
    80002938:	07013903          	ld	s2,112(sp)
    8000293c:	06813983          	ld	s3,104(sp)
    80002940:	06013a03          	ld	s4,96(sp)
    80002944:	05813a83          	ld	s5,88(sp)
    80002948:	05013b03          	ld	s6,80(sp)
    8000294c:	04813b83          	ld	s7,72(sp)
    80002950:	04013c03          	ld	s8,64(sp)
    80002954:	03813c83          	ld	s9,56(sp)
    80002958:	03013d03          	ld	s10,48(sp)
    8000295c:	02813d83          	ld	s11,40(sp)
    80002960:	0d010113          	addi	sp,sp,208
    80002964:	00008067          	ret
    80002968:	07300713          	li	a4,115
    8000296c:	1ce78a63          	beq	a5,a4,80002b40 <__printf+0x4b8>
    80002970:	07800713          	li	a4,120
    80002974:	1ee79e63          	bne	a5,a4,80002b70 <__printf+0x4e8>
    80002978:	f7843783          	ld	a5,-136(s0)
    8000297c:	0007a703          	lw	a4,0(a5)
    80002980:	00878793          	addi	a5,a5,8
    80002984:	f6f43c23          	sd	a5,-136(s0)
    80002988:	28074263          	bltz	a4,80002c0c <__printf+0x584>
    8000298c:	00001d97          	auipc	s11,0x1
    80002990:	7fcd8d93          	addi	s11,s11,2044 # 80004188 <digits>
    80002994:	00f77793          	andi	a5,a4,15
    80002998:	00fd87b3          	add	a5,s11,a5
    8000299c:	0007c683          	lbu	a3,0(a5)
    800029a0:	00f00613          	li	a2,15
    800029a4:	0007079b          	sext.w	a5,a4
    800029a8:	f8d40023          	sb	a3,-128(s0)
    800029ac:	0047559b          	srliw	a1,a4,0x4
    800029b0:	0047569b          	srliw	a3,a4,0x4
    800029b4:	00000c93          	li	s9,0
    800029b8:	0ee65063          	bge	a2,a4,80002a98 <__printf+0x410>
    800029bc:	00f6f693          	andi	a3,a3,15
    800029c0:	00dd86b3          	add	a3,s11,a3
    800029c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800029c8:	0087d79b          	srliw	a5,a5,0x8
    800029cc:	00100c93          	li	s9,1
    800029d0:	f8d400a3          	sb	a3,-127(s0)
    800029d4:	0cb67263          	bgeu	a2,a1,80002a98 <__printf+0x410>
    800029d8:	00f7f693          	andi	a3,a5,15
    800029dc:	00dd86b3          	add	a3,s11,a3
    800029e0:	0006c583          	lbu	a1,0(a3)
    800029e4:	00f00613          	li	a2,15
    800029e8:	0047d69b          	srliw	a3,a5,0x4
    800029ec:	f8b40123          	sb	a1,-126(s0)
    800029f0:	0047d593          	srli	a1,a5,0x4
    800029f4:	28f67e63          	bgeu	a2,a5,80002c90 <__printf+0x608>
    800029f8:	00f6f693          	andi	a3,a3,15
    800029fc:	00dd86b3          	add	a3,s11,a3
    80002a00:	0006c503          	lbu	a0,0(a3)
    80002a04:	0087d813          	srli	a6,a5,0x8
    80002a08:	0087d69b          	srliw	a3,a5,0x8
    80002a0c:	f8a401a3          	sb	a0,-125(s0)
    80002a10:	28b67663          	bgeu	a2,a1,80002c9c <__printf+0x614>
    80002a14:	00f6f693          	andi	a3,a3,15
    80002a18:	00dd86b3          	add	a3,s11,a3
    80002a1c:	0006c583          	lbu	a1,0(a3)
    80002a20:	00c7d513          	srli	a0,a5,0xc
    80002a24:	00c7d69b          	srliw	a3,a5,0xc
    80002a28:	f8b40223          	sb	a1,-124(s0)
    80002a2c:	29067a63          	bgeu	a2,a6,80002cc0 <__printf+0x638>
    80002a30:	00f6f693          	andi	a3,a3,15
    80002a34:	00dd86b3          	add	a3,s11,a3
    80002a38:	0006c583          	lbu	a1,0(a3)
    80002a3c:	0107d813          	srli	a6,a5,0x10
    80002a40:	0107d69b          	srliw	a3,a5,0x10
    80002a44:	f8b402a3          	sb	a1,-123(s0)
    80002a48:	28a67263          	bgeu	a2,a0,80002ccc <__printf+0x644>
    80002a4c:	00f6f693          	andi	a3,a3,15
    80002a50:	00dd86b3          	add	a3,s11,a3
    80002a54:	0006c683          	lbu	a3,0(a3)
    80002a58:	0147d79b          	srliw	a5,a5,0x14
    80002a5c:	f8d40323          	sb	a3,-122(s0)
    80002a60:	21067663          	bgeu	a2,a6,80002c6c <__printf+0x5e4>
    80002a64:	02079793          	slli	a5,a5,0x20
    80002a68:	0207d793          	srli	a5,a5,0x20
    80002a6c:	00fd8db3          	add	s11,s11,a5
    80002a70:	000dc683          	lbu	a3,0(s11)
    80002a74:	00800793          	li	a5,8
    80002a78:	00700c93          	li	s9,7
    80002a7c:	f8d403a3          	sb	a3,-121(s0)
    80002a80:	00075c63          	bgez	a4,80002a98 <__printf+0x410>
    80002a84:	f9040713          	addi	a4,s0,-112
    80002a88:	00f70733          	add	a4,a4,a5
    80002a8c:	02d00693          	li	a3,45
    80002a90:	fed70823          	sb	a3,-16(a4)
    80002a94:	00078c93          	mv	s9,a5
    80002a98:	f8040793          	addi	a5,s0,-128
    80002a9c:	01978cb3          	add	s9,a5,s9
    80002aa0:	f7f40d13          	addi	s10,s0,-129
    80002aa4:	000cc503          	lbu	a0,0(s9)
    80002aa8:	fffc8c93          	addi	s9,s9,-1
    80002aac:	00000097          	auipc	ra,0x0
    80002ab0:	9f8080e7          	jalr	-1544(ra) # 800024a4 <consputc>
    80002ab4:	ff9d18e3          	bne	s10,s9,80002aa4 <__printf+0x41c>
    80002ab8:	0100006f          	j	80002ac8 <__printf+0x440>
    80002abc:	00000097          	auipc	ra,0x0
    80002ac0:	9e8080e7          	jalr	-1560(ra) # 800024a4 <consputc>
    80002ac4:	000c8493          	mv	s1,s9
    80002ac8:	00094503          	lbu	a0,0(s2)
    80002acc:	c60510e3          	bnez	a0,8000272c <__printf+0xa4>
    80002ad0:	e40c0ee3          	beqz	s8,8000292c <__printf+0x2a4>
    80002ad4:	00003517          	auipc	a0,0x3
    80002ad8:	d1c50513          	addi	a0,a0,-740 # 800057f0 <pr>
    80002adc:	00001097          	auipc	ra,0x1
    80002ae0:	94c080e7          	jalr	-1716(ra) # 80003428 <release>
    80002ae4:	e49ff06f          	j	8000292c <__printf+0x2a4>
    80002ae8:	f7843783          	ld	a5,-136(s0)
    80002aec:	03000513          	li	a0,48
    80002af0:	01000d13          	li	s10,16
    80002af4:	00878713          	addi	a4,a5,8
    80002af8:	0007bc83          	ld	s9,0(a5)
    80002afc:	f6e43c23          	sd	a4,-136(s0)
    80002b00:	00000097          	auipc	ra,0x0
    80002b04:	9a4080e7          	jalr	-1628(ra) # 800024a4 <consputc>
    80002b08:	07800513          	li	a0,120
    80002b0c:	00000097          	auipc	ra,0x0
    80002b10:	998080e7          	jalr	-1640(ra) # 800024a4 <consputc>
    80002b14:	00001d97          	auipc	s11,0x1
    80002b18:	674d8d93          	addi	s11,s11,1652 # 80004188 <digits>
    80002b1c:	03ccd793          	srli	a5,s9,0x3c
    80002b20:	00fd87b3          	add	a5,s11,a5
    80002b24:	0007c503          	lbu	a0,0(a5)
    80002b28:	fffd0d1b          	addiw	s10,s10,-1
    80002b2c:	004c9c93          	slli	s9,s9,0x4
    80002b30:	00000097          	auipc	ra,0x0
    80002b34:	974080e7          	jalr	-1676(ra) # 800024a4 <consputc>
    80002b38:	fe0d12e3          	bnez	s10,80002b1c <__printf+0x494>
    80002b3c:	f8dff06f          	j	80002ac8 <__printf+0x440>
    80002b40:	f7843783          	ld	a5,-136(s0)
    80002b44:	0007bc83          	ld	s9,0(a5)
    80002b48:	00878793          	addi	a5,a5,8
    80002b4c:	f6f43c23          	sd	a5,-136(s0)
    80002b50:	000c9a63          	bnez	s9,80002b64 <__printf+0x4dc>
    80002b54:	1080006f          	j	80002c5c <__printf+0x5d4>
    80002b58:	001c8c93          	addi	s9,s9,1
    80002b5c:	00000097          	auipc	ra,0x0
    80002b60:	948080e7          	jalr	-1720(ra) # 800024a4 <consputc>
    80002b64:	000cc503          	lbu	a0,0(s9)
    80002b68:	fe0518e3          	bnez	a0,80002b58 <__printf+0x4d0>
    80002b6c:	f5dff06f          	j	80002ac8 <__printf+0x440>
    80002b70:	02500513          	li	a0,37
    80002b74:	00000097          	auipc	ra,0x0
    80002b78:	930080e7          	jalr	-1744(ra) # 800024a4 <consputc>
    80002b7c:	000c8513          	mv	a0,s9
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	924080e7          	jalr	-1756(ra) # 800024a4 <consputc>
    80002b88:	f41ff06f          	j	80002ac8 <__printf+0x440>
    80002b8c:	02500513          	li	a0,37
    80002b90:	00000097          	auipc	ra,0x0
    80002b94:	914080e7          	jalr	-1772(ra) # 800024a4 <consputc>
    80002b98:	f31ff06f          	j	80002ac8 <__printf+0x440>
    80002b9c:	00030513          	mv	a0,t1
    80002ba0:	00000097          	auipc	ra,0x0
    80002ba4:	7bc080e7          	jalr	1980(ra) # 8000335c <acquire>
    80002ba8:	b4dff06f          	j	800026f4 <__printf+0x6c>
    80002bac:	40c0053b          	negw	a0,a2
    80002bb0:	00a00713          	li	a4,10
    80002bb4:	02e576bb          	remuw	a3,a0,a4
    80002bb8:	00001d97          	auipc	s11,0x1
    80002bbc:	5d0d8d93          	addi	s11,s11,1488 # 80004188 <digits>
    80002bc0:	ff700593          	li	a1,-9
    80002bc4:	02069693          	slli	a3,a3,0x20
    80002bc8:	0206d693          	srli	a3,a3,0x20
    80002bcc:	00dd86b3          	add	a3,s11,a3
    80002bd0:	0006c683          	lbu	a3,0(a3)
    80002bd4:	02e557bb          	divuw	a5,a0,a4
    80002bd8:	f8d40023          	sb	a3,-128(s0)
    80002bdc:	10b65e63          	bge	a2,a1,80002cf8 <__printf+0x670>
    80002be0:	06300593          	li	a1,99
    80002be4:	02e7f6bb          	remuw	a3,a5,a4
    80002be8:	02069693          	slli	a3,a3,0x20
    80002bec:	0206d693          	srli	a3,a3,0x20
    80002bf0:	00dd86b3          	add	a3,s11,a3
    80002bf4:	0006c683          	lbu	a3,0(a3)
    80002bf8:	02e7d73b          	divuw	a4,a5,a4
    80002bfc:	00200793          	li	a5,2
    80002c00:	f8d400a3          	sb	a3,-127(s0)
    80002c04:	bca5ece3          	bltu	a1,a0,800027dc <__printf+0x154>
    80002c08:	ce5ff06f          	j	800028ec <__printf+0x264>
    80002c0c:	40e007bb          	negw	a5,a4
    80002c10:	00001d97          	auipc	s11,0x1
    80002c14:	578d8d93          	addi	s11,s11,1400 # 80004188 <digits>
    80002c18:	00f7f693          	andi	a3,a5,15
    80002c1c:	00dd86b3          	add	a3,s11,a3
    80002c20:	0006c583          	lbu	a1,0(a3)
    80002c24:	ff100613          	li	a2,-15
    80002c28:	0047d69b          	srliw	a3,a5,0x4
    80002c2c:	f8b40023          	sb	a1,-128(s0)
    80002c30:	0047d59b          	srliw	a1,a5,0x4
    80002c34:	0ac75e63          	bge	a4,a2,80002cf0 <__printf+0x668>
    80002c38:	00f6f693          	andi	a3,a3,15
    80002c3c:	00dd86b3          	add	a3,s11,a3
    80002c40:	0006c603          	lbu	a2,0(a3)
    80002c44:	00f00693          	li	a3,15
    80002c48:	0087d79b          	srliw	a5,a5,0x8
    80002c4c:	f8c400a3          	sb	a2,-127(s0)
    80002c50:	d8b6e4e3          	bltu	a3,a1,800029d8 <__printf+0x350>
    80002c54:	00200793          	li	a5,2
    80002c58:	e2dff06f          	j	80002a84 <__printf+0x3fc>
    80002c5c:	00001c97          	auipc	s9,0x1
    80002c60:	50cc8c93          	addi	s9,s9,1292 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    80002c64:	02800513          	li	a0,40
    80002c68:	ef1ff06f          	j	80002b58 <__printf+0x4d0>
    80002c6c:	00700793          	li	a5,7
    80002c70:	00600c93          	li	s9,6
    80002c74:	e0dff06f          	j	80002a80 <__printf+0x3f8>
    80002c78:	00700793          	li	a5,7
    80002c7c:	00600c93          	li	s9,6
    80002c80:	c69ff06f          	j	800028e8 <__printf+0x260>
    80002c84:	00300793          	li	a5,3
    80002c88:	00200c93          	li	s9,2
    80002c8c:	c5dff06f          	j	800028e8 <__printf+0x260>
    80002c90:	00300793          	li	a5,3
    80002c94:	00200c93          	li	s9,2
    80002c98:	de9ff06f          	j	80002a80 <__printf+0x3f8>
    80002c9c:	00400793          	li	a5,4
    80002ca0:	00300c93          	li	s9,3
    80002ca4:	dddff06f          	j	80002a80 <__printf+0x3f8>
    80002ca8:	00400793          	li	a5,4
    80002cac:	00300c93          	li	s9,3
    80002cb0:	c39ff06f          	j	800028e8 <__printf+0x260>
    80002cb4:	00500793          	li	a5,5
    80002cb8:	00400c93          	li	s9,4
    80002cbc:	c2dff06f          	j	800028e8 <__printf+0x260>
    80002cc0:	00500793          	li	a5,5
    80002cc4:	00400c93          	li	s9,4
    80002cc8:	db9ff06f          	j	80002a80 <__printf+0x3f8>
    80002ccc:	00600793          	li	a5,6
    80002cd0:	00500c93          	li	s9,5
    80002cd4:	dadff06f          	j	80002a80 <__printf+0x3f8>
    80002cd8:	00600793          	li	a5,6
    80002cdc:	00500c93          	li	s9,5
    80002ce0:	c09ff06f          	j	800028e8 <__printf+0x260>
    80002ce4:	00800793          	li	a5,8
    80002ce8:	00700c93          	li	s9,7
    80002cec:	bfdff06f          	j	800028e8 <__printf+0x260>
    80002cf0:	00100793          	li	a5,1
    80002cf4:	d91ff06f          	j	80002a84 <__printf+0x3fc>
    80002cf8:	00100793          	li	a5,1
    80002cfc:	bf1ff06f          	j	800028ec <__printf+0x264>
    80002d00:	00900793          	li	a5,9
    80002d04:	00800c93          	li	s9,8
    80002d08:	be1ff06f          	j	800028e8 <__printf+0x260>
    80002d0c:	00001517          	auipc	a0,0x1
    80002d10:	46450513          	addi	a0,a0,1124 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002d14:	00000097          	auipc	ra,0x0
    80002d18:	918080e7          	jalr	-1768(ra) # 8000262c <panic>

0000000080002d1c <printfinit>:
    80002d1c:	fe010113          	addi	sp,sp,-32
    80002d20:	00813823          	sd	s0,16(sp)
    80002d24:	00913423          	sd	s1,8(sp)
    80002d28:	00113c23          	sd	ra,24(sp)
    80002d2c:	02010413          	addi	s0,sp,32
    80002d30:	00003497          	auipc	s1,0x3
    80002d34:	ac048493          	addi	s1,s1,-1344 # 800057f0 <pr>
    80002d38:	00048513          	mv	a0,s1
    80002d3c:	00001597          	auipc	a1,0x1
    80002d40:	44458593          	addi	a1,a1,1092 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	5f4080e7          	jalr	1524(ra) # 80003338 <initlock>
    80002d4c:	01813083          	ld	ra,24(sp)
    80002d50:	01013403          	ld	s0,16(sp)
    80002d54:	0004ac23          	sw	zero,24(s1)
    80002d58:	00813483          	ld	s1,8(sp)
    80002d5c:	02010113          	addi	sp,sp,32
    80002d60:	00008067          	ret

0000000080002d64 <uartinit>:
    80002d64:	ff010113          	addi	sp,sp,-16
    80002d68:	00813423          	sd	s0,8(sp)
    80002d6c:	01010413          	addi	s0,sp,16
    80002d70:	100007b7          	lui	a5,0x10000
    80002d74:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002d78:	f8000713          	li	a4,-128
    80002d7c:	00e781a3          	sb	a4,3(a5)
    80002d80:	00300713          	li	a4,3
    80002d84:	00e78023          	sb	a4,0(a5)
    80002d88:	000780a3          	sb	zero,1(a5)
    80002d8c:	00e781a3          	sb	a4,3(a5)
    80002d90:	00700693          	li	a3,7
    80002d94:	00d78123          	sb	a3,2(a5)
    80002d98:	00e780a3          	sb	a4,1(a5)
    80002d9c:	00813403          	ld	s0,8(sp)
    80002da0:	01010113          	addi	sp,sp,16
    80002da4:	00008067          	ret

0000000080002da8 <uartputc>:
    80002da8:	00001797          	auipc	a5,0x1
    80002dac:	7d07a783          	lw	a5,2000(a5) # 80004578 <panicked>
    80002db0:	00078463          	beqz	a5,80002db8 <uartputc+0x10>
    80002db4:	0000006f          	j	80002db4 <uartputc+0xc>
    80002db8:	fd010113          	addi	sp,sp,-48
    80002dbc:	02813023          	sd	s0,32(sp)
    80002dc0:	00913c23          	sd	s1,24(sp)
    80002dc4:	01213823          	sd	s2,16(sp)
    80002dc8:	01313423          	sd	s3,8(sp)
    80002dcc:	02113423          	sd	ra,40(sp)
    80002dd0:	03010413          	addi	s0,sp,48
    80002dd4:	00001917          	auipc	s2,0x1
    80002dd8:	7ac90913          	addi	s2,s2,1964 # 80004580 <uart_tx_r>
    80002ddc:	00093783          	ld	a5,0(s2)
    80002de0:	00001497          	auipc	s1,0x1
    80002de4:	7a848493          	addi	s1,s1,1960 # 80004588 <uart_tx_w>
    80002de8:	0004b703          	ld	a4,0(s1)
    80002dec:	02078693          	addi	a3,a5,32
    80002df0:	00050993          	mv	s3,a0
    80002df4:	02e69c63          	bne	a3,a4,80002e2c <uartputc+0x84>
    80002df8:	00001097          	auipc	ra,0x1
    80002dfc:	834080e7          	jalr	-1996(ra) # 8000362c <push_on>
    80002e00:	00093783          	ld	a5,0(s2)
    80002e04:	0004b703          	ld	a4,0(s1)
    80002e08:	02078793          	addi	a5,a5,32
    80002e0c:	00e79463          	bne	a5,a4,80002e14 <uartputc+0x6c>
    80002e10:	0000006f          	j	80002e10 <uartputc+0x68>
    80002e14:	00001097          	auipc	ra,0x1
    80002e18:	88c080e7          	jalr	-1908(ra) # 800036a0 <pop_on>
    80002e1c:	00093783          	ld	a5,0(s2)
    80002e20:	0004b703          	ld	a4,0(s1)
    80002e24:	02078693          	addi	a3,a5,32
    80002e28:	fce688e3          	beq	a3,a4,80002df8 <uartputc+0x50>
    80002e2c:	01f77693          	andi	a3,a4,31
    80002e30:	00003597          	auipc	a1,0x3
    80002e34:	9e058593          	addi	a1,a1,-1568 # 80005810 <uart_tx_buf>
    80002e38:	00d586b3          	add	a3,a1,a3
    80002e3c:	00170713          	addi	a4,a4,1
    80002e40:	01368023          	sb	s3,0(a3)
    80002e44:	00e4b023          	sd	a4,0(s1)
    80002e48:	10000637          	lui	a2,0x10000
    80002e4c:	02f71063          	bne	a4,a5,80002e6c <uartputc+0xc4>
    80002e50:	0340006f          	j	80002e84 <uartputc+0xdc>
    80002e54:	00074703          	lbu	a4,0(a4)
    80002e58:	00f93023          	sd	a5,0(s2)
    80002e5c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002e60:	00093783          	ld	a5,0(s2)
    80002e64:	0004b703          	ld	a4,0(s1)
    80002e68:	00f70e63          	beq	a4,a5,80002e84 <uartputc+0xdc>
    80002e6c:	00564683          	lbu	a3,5(a2)
    80002e70:	01f7f713          	andi	a4,a5,31
    80002e74:	00e58733          	add	a4,a1,a4
    80002e78:	0206f693          	andi	a3,a3,32
    80002e7c:	00178793          	addi	a5,a5,1
    80002e80:	fc069ae3          	bnez	a3,80002e54 <uartputc+0xac>
    80002e84:	02813083          	ld	ra,40(sp)
    80002e88:	02013403          	ld	s0,32(sp)
    80002e8c:	01813483          	ld	s1,24(sp)
    80002e90:	01013903          	ld	s2,16(sp)
    80002e94:	00813983          	ld	s3,8(sp)
    80002e98:	03010113          	addi	sp,sp,48
    80002e9c:	00008067          	ret

0000000080002ea0 <uartputc_sync>:
    80002ea0:	ff010113          	addi	sp,sp,-16
    80002ea4:	00813423          	sd	s0,8(sp)
    80002ea8:	01010413          	addi	s0,sp,16
    80002eac:	00001717          	auipc	a4,0x1
    80002eb0:	6cc72703          	lw	a4,1740(a4) # 80004578 <panicked>
    80002eb4:	02071663          	bnez	a4,80002ee0 <uartputc_sync+0x40>
    80002eb8:	00050793          	mv	a5,a0
    80002ebc:	100006b7          	lui	a3,0x10000
    80002ec0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002ec4:	02077713          	andi	a4,a4,32
    80002ec8:	fe070ce3          	beqz	a4,80002ec0 <uartputc_sync+0x20>
    80002ecc:	0ff7f793          	andi	a5,a5,255
    80002ed0:	00f68023          	sb	a5,0(a3)
    80002ed4:	00813403          	ld	s0,8(sp)
    80002ed8:	01010113          	addi	sp,sp,16
    80002edc:	00008067          	ret
    80002ee0:	0000006f          	j	80002ee0 <uartputc_sync+0x40>

0000000080002ee4 <uartstart>:
    80002ee4:	ff010113          	addi	sp,sp,-16
    80002ee8:	00813423          	sd	s0,8(sp)
    80002eec:	01010413          	addi	s0,sp,16
    80002ef0:	00001617          	auipc	a2,0x1
    80002ef4:	69060613          	addi	a2,a2,1680 # 80004580 <uart_tx_r>
    80002ef8:	00001517          	auipc	a0,0x1
    80002efc:	69050513          	addi	a0,a0,1680 # 80004588 <uart_tx_w>
    80002f00:	00063783          	ld	a5,0(a2)
    80002f04:	00053703          	ld	a4,0(a0)
    80002f08:	04f70263          	beq	a4,a5,80002f4c <uartstart+0x68>
    80002f0c:	100005b7          	lui	a1,0x10000
    80002f10:	00003817          	auipc	a6,0x3
    80002f14:	90080813          	addi	a6,a6,-1792 # 80005810 <uart_tx_buf>
    80002f18:	01c0006f          	j	80002f34 <uartstart+0x50>
    80002f1c:	0006c703          	lbu	a4,0(a3)
    80002f20:	00f63023          	sd	a5,0(a2)
    80002f24:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002f28:	00063783          	ld	a5,0(a2)
    80002f2c:	00053703          	ld	a4,0(a0)
    80002f30:	00f70e63          	beq	a4,a5,80002f4c <uartstart+0x68>
    80002f34:	01f7f713          	andi	a4,a5,31
    80002f38:	00e806b3          	add	a3,a6,a4
    80002f3c:	0055c703          	lbu	a4,5(a1)
    80002f40:	00178793          	addi	a5,a5,1
    80002f44:	02077713          	andi	a4,a4,32
    80002f48:	fc071ae3          	bnez	a4,80002f1c <uartstart+0x38>
    80002f4c:	00813403          	ld	s0,8(sp)
    80002f50:	01010113          	addi	sp,sp,16
    80002f54:	00008067          	ret

0000000080002f58 <uartgetc>:
    80002f58:	ff010113          	addi	sp,sp,-16
    80002f5c:	00813423          	sd	s0,8(sp)
    80002f60:	01010413          	addi	s0,sp,16
    80002f64:	10000737          	lui	a4,0x10000
    80002f68:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002f6c:	0017f793          	andi	a5,a5,1
    80002f70:	00078c63          	beqz	a5,80002f88 <uartgetc+0x30>
    80002f74:	00074503          	lbu	a0,0(a4)
    80002f78:	0ff57513          	andi	a0,a0,255
    80002f7c:	00813403          	ld	s0,8(sp)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret
    80002f88:	fff00513          	li	a0,-1
    80002f8c:	ff1ff06f          	j	80002f7c <uartgetc+0x24>

0000000080002f90 <uartintr>:
    80002f90:	100007b7          	lui	a5,0x10000
    80002f94:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002f98:	0017f793          	andi	a5,a5,1
    80002f9c:	0a078463          	beqz	a5,80003044 <uartintr+0xb4>
    80002fa0:	fe010113          	addi	sp,sp,-32
    80002fa4:	00813823          	sd	s0,16(sp)
    80002fa8:	00913423          	sd	s1,8(sp)
    80002fac:	00113c23          	sd	ra,24(sp)
    80002fb0:	02010413          	addi	s0,sp,32
    80002fb4:	100004b7          	lui	s1,0x10000
    80002fb8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002fbc:	0ff57513          	andi	a0,a0,255
    80002fc0:	fffff097          	auipc	ra,0xfffff
    80002fc4:	534080e7          	jalr	1332(ra) # 800024f4 <consoleintr>
    80002fc8:	0054c783          	lbu	a5,5(s1)
    80002fcc:	0017f793          	andi	a5,a5,1
    80002fd0:	fe0794e3          	bnez	a5,80002fb8 <uartintr+0x28>
    80002fd4:	00001617          	auipc	a2,0x1
    80002fd8:	5ac60613          	addi	a2,a2,1452 # 80004580 <uart_tx_r>
    80002fdc:	00001517          	auipc	a0,0x1
    80002fe0:	5ac50513          	addi	a0,a0,1452 # 80004588 <uart_tx_w>
    80002fe4:	00063783          	ld	a5,0(a2)
    80002fe8:	00053703          	ld	a4,0(a0)
    80002fec:	04f70263          	beq	a4,a5,80003030 <uartintr+0xa0>
    80002ff0:	100005b7          	lui	a1,0x10000
    80002ff4:	00003817          	auipc	a6,0x3
    80002ff8:	81c80813          	addi	a6,a6,-2020 # 80005810 <uart_tx_buf>
    80002ffc:	01c0006f          	j	80003018 <uartintr+0x88>
    80003000:	0006c703          	lbu	a4,0(a3)
    80003004:	00f63023          	sd	a5,0(a2)
    80003008:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000300c:	00063783          	ld	a5,0(a2)
    80003010:	00053703          	ld	a4,0(a0)
    80003014:	00f70e63          	beq	a4,a5,80003030 <uartintr+0xa0>
    80003018:	01f7f713          	andi	a4,a5,31
    8000301c:	00e806b3          	add	a3,a6,a4
    80003020:	0055c703          	lbu	a4,5(a1)
    80003024:	00178793          	addi	a5,a5,1
    80003028:	02077713          	andi	a4,a4,32
    8000302c:	fc071ae3          	bnez	a4,80003000 <uartintr+0x70>
    80003030:	01813083          	ld	ra,24(sp)
    80003034:	01013403          	ld	s0,16(sp)
    80003038:	00813483          	ld	s1,8(sp)
    8000303c:	02010113          	addi	sp,sp,32
    80003040:	00008067          	ret
    80003044:	00001617          	auipc	a2,0x1
    80003048:	53c60613          	addi	a2,a2,1340 # 80004580 <uart_tx_r>
    8000304c:	00001517          	auipc	a0,0x1
    80003050:	53c50513          	addi	a0,a0,1340 # 80004588 <uart_tx_w>
    80003054:	00063783          	ld	a5,0(a2)
    80003058:	00053703          	ld	a4,0(a0)
    8000305c:	04f70263          	beq	a4,a5,800030a0 <uartintr+0x110>
    80003060:	100005b7          	lui	a1,0x10000
    80003064:	00002817          	auipc	a6,0x2
    80003068:	7ac80813          	addi	a6,a6,1964 # 80005810 <uart_tx_buf>
    8000306c:	01c0006f          	j	80003088 <uartintr+0xf8>
    80003070:	0006c703          	lbu	a4,0(a3)
    80003074:	00f63023          	sd	a5,0(a2)
    80003078:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000307c:	00063783          	ld	a5,0(a2)
    80003080:	00053703          	ld	a4,0(a0)
    80003084:	02f70063          	beq	a4,a5,800030a4 <uartintr+0x114>
    80003088:	01f7f713          	andi	a4,a5,31
    8000308c:	00e806b3          	add	a3,a6,a4
    80003090:	0055c703          	lbu	a4,5(a1)
    80003094:	00178793          	addi	a5,a5,1
    80003098:	02077713          	andi	a4,a4,32
    8000309c:	fc071ae3          	bnez	a4,80003070 <uartintr+0xe0>
    800030a0:	00008067          	ret
    800030a4:	00008067          	ret

00000000800030a8 <kinit>:
    800030a8:	fc010113          	addi	sp,sp,-64
    800030ac:	02913423          	sd	s1,40(sp)
    800030b0:	fffff7b7          	lui	a5,0xfffff
    800030b4:	00003497          	auipc	s1,0x3
    800030b8:	77b48493          	addi	s1,s1,1915 # 8000682f <end+0xfff>
    800030bc:	02813823          	sd	s0,48(sp)
    800030c0:	01313c23          	sd	s3,24(sp)
    800030c4:	00f4f4b3          	and	s1,s1,a5
    800030c8:	02113c23          	sd	ra,56(sp)
    800030cc:	03213023          	sd	s2,32(sp)
    800030d0:	01413823          	sd	s4,16(sp)
    800030d4:	01513423          	sd	s5,8(sp)
    800030d8:	04010413          	addi	s0,sp,64
    800030dc:	000017b7          	lui	a5,0x1
    800030e0:	01100993          	li	s3,17
    800030e4:	00f487b3          	add	a5,s1,a5
    800030e8:	01b99993          	slli	s3,s3,0x1b
    800030ec:	06f9e063          	bltu	s3,a5,8000314c <kinit+0xa4>
    800030f0:	00002a97          	auipc	s5,0x2
    800030f4:	740a8a93          	addi	s5,s5,1856 # 80005830 <end>
    800030f8:	0754ec63          	bltu	s1,s5,80003170 <kinit+0xc8>
    800030fc:	0734fa63          	bgeu	s1,s3,80003170 <kinit+0xc8>
    80003100:	00088a37          	lui	s4,0x88
    80003104:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003108:	00001917          	auipc	s2,0x1
    8000310c:	48890913          	addi	s2,s2,1160 # 80004590 <kmem>
    80003110:	00ca1a13          	slli	s4,s4,0xc
    80003114:	0140006f          	j	80003128 <kinit+0x80>
    80003118:	000017b7          	lui	a5,0x1
    8000311c:	00f484b3          	add	s1,s1,a5
    80003120:	0554e863          	bltu	s1,s5,80003170 <kinit+0xc8>
    80003124:	0534f663          	bgeu	s1,s3,80003170 <kinit+0xc8>
    80003128:	00001637          	lui	a2,0x1
    8000312c:	00100593          	li	a1,1
    80003130:	00048513          	mv	a0,s1
    80003134:	00000097          	auipc	ra,0x0
    80003138:	5e4080e7          	jalr	1508(ra) # 80003718 <__memset>
    8000313c:	00093783          	ld	a5,0(s2)
    80003140:	00f4b023          	sd	a5,0(s1)
    80003144:	00993023          	sd	s1,0(s2)
    80003148:	fd4498e3          	bne	s1,s4,80003118 <kinit+0x70>
    8000314c:	03813083          	ld	ra,56(sp)
    80003150:	03013403          	ld	s0,48(sp)
    80003154:	02813483          	ld	s1,40(sp)
    80003158:	02013903          	ld	s2,32(sp)
    8000315c:	01813983          	ld	s3,24(sp)
    80003160:	01013a03          	ld	s4,16(sp)
    80003164:	00813a83          	ld	s5,8(sp)
    80003168:	04010113          	addi	sp,sp,64
    8000316c:	00008067          	ret
    80003170:	00001517          	auipc	a0,0x1
    80003174:	03050513          	addi	a0,a0,48 # 800041a0 <digits+0x18>
    80003178:	fffff097          	auipc	ra,0xfffff
    8000317c:	4b4080e7          	jalr	1204(ra) # 8000262c <panic>

0000000080003180 <freerange>:
    80003180:	fc010113          	addi	sp,sp,-64
    80003184:	000017b7          	lui	a5,0x1
    80003188:	02913423          	sd	s1,40(sp)
    8000318c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003190:	009504b3          	add	s1,a0,s1
    80003194:	fffff537          	lui	a0,0xfffff
    80003198:	02813823          	sd	s0,48(sp)
    8000319c:	02113c23          	sd	ra,56(sp)
    800031a0:	03213023          	sd	s2,32(sp)
    800031a4:	01313c23          	sd	s3,24(sp)
    800031a8:	01413823          	sd	s4,16(sp)
    800031ac:	01513423          	sd	s5,8(sp)
    800031b0:	01613023          	sd	s6,0(sp)
    800031b4:	04010413          	addi	s0,sp,64
    800031b8:	00a4f4b3          	and	s1,s1,a0
    800031bc:	00f487b3          	add	a5,s1,a5
    800031c0:	06f5e463          	bltu	a1,a5,80003228 <freerange+0xa8>
    800031c4:	00002a97          	auipc	s5,0x2
    800031c8:	66ca8a93          	addi	s5,s5,1644 # 80005830 <end>
    800031cc:	0954e263          	bltu	s1,s5,80003250 <freerange+0xd0>
    800031d0:	01100993          	li	s3,17
    800031d4:	01b99993          	slli	s3,s3,0x1b
    800031d8:	0734fc63          	bgeu	s1,s3,80003250 <freerange+0xd0>
    800031dc:	00058a13          	mv	s4,a1
    800031e0:	00001917          	auipc	s2,0x1
    800031e4:	3b090913          	addi	s2,s2,944 # 80004590 <kmem>
    800031e8:	00002b37          	lui	s6,0x2
    800031ec:	0140006f          	j	80003200 <freerange+0x80>
    800031f0:	000017b7          	lui	a5,0x1
    800031f4:	00f484b3          	add	s1,s1,a5
    800031f8:	0554ec63          	bltu	s1,s5,80003250 <freerange+0xd0>
    800031fc:	0534fa63          	bgeu	s1,s3,80003250 <freerange+0xd0>
    80003200:	00001637          	lui	a2,0x1
    80003204:	00100593          	li	a1,1
    80003208:	00048513          	mv	a0,s1
    8000320c:	00000097          	auipc	ra,0x0
    80003210:	50c080e7          	jalr	1292(ra) # 80003718 <__memset>
    80003214:	00093703          	ld	a4,0(s2)
    80003218:	016487b3          	add	a5,s1,s6
    8000321c:	00e4b023          	sd	a4,0(s1)
    80003220:	00993023          	sd	s1,0(s2)
    80003224:	fcfa76e3          	bgeu	s4,a5,800031f0 <freerange+0x70>
    80003228:	03813083          	ld	ra,56(sp)
    8000322c:	03013403          	ld	s0,48(sp)
    80003230:	02813483          	ld	s1,40(sp)
    80003234:	02013903          	ld	s2,32(sp)
    80003238:	01813983          	ld	s3,24(sp)
    8000323c:	01013a03          	ld	s4,16(sp)
    80003240:	00813a83          	ld	s5,8(sp)
    80003244:	00013b03          	ld	s6,0(sp)
    80003248:	04010113          	addi	sp,sp,64
    8000324c:	00008067          	ret
    80003250:	00001517          	auipc	a0,0x1
    80003254:	f5050513          	addi	a0,a0,-176 # 800041a0 <digits+0x18>
    80003258:	fffff097          	auipc	ra,0xfffff
    8000325c:	3d4080e7          	jalr	980(ra) # 8000262c <panic>

0000000080003260 <kfree>:
    80003260:	fe010113          	addi	sp,sp,-32
    80003264:	00813823          	sd	s0,16(sp)
    80003268:	00113c23          	sd	ra,24(sp)
    8000326c:	00913423          	sd	s1,8(sp)
    80003270:	02010413          	addi	s0,sp,32
    80003274:	03451793          	slli	a5,a0,0x34
    80003278:	04079c63          	bnez	a5,800032d0 <kfree+0x70>
    8000327c:	00002797          	auipc	a5,0x2
    80003280:	5b478793          	addi	a5,a5,1460 # 80005830 <end>
    80003284:	00050493          	mv	s1,a0
    80003288:	04f56463          	bltu	a0,a5,800032d0 <kfree+0x70>
    8000328c:	01100793          	li	a5,17
    80003290:	01b79793          	slli	a5,a5,0x1b
    80003294:	02f57e63          	bgeu	a0,a5,800032d0 <kfree+0x70>
    80003298:	00001637          	lui	a2,0x1
    8000329c:	00100593          	li	a1,1
    800032a0:	00000097          	auipc	ra,0x0
    800032a4:	478080e7          	jalr	1144(ra) # 80003718 <__memset>
    800032a8:	00001797          	auipc	a5,0x1
    800032ac:	2e878793          	addi	a5,a5,744 # 80004590 <kmem>
    800032b0:	0007b703          	ld	a4,0(a5)
    800032b4:	01813083          	ld	ra,24(sp)
    800032b8:	01013403          	ld	s0,16(sp)
    800032bc:	00e4b023          	sd	a4,0(s1)
    800032c0:	0097b023          	sd	s1,0(a5)
    800032c4:	00813483          	ld	s1,8(sp)
    800032c8:	02010113          	addi	sp,sp,32
    800032cc:	00008067          	ret
    800032d0:	00001517          	auipc	a0,0x1
    800032d4:	ed050513          	addi	a0,a0,-304 # 800041a0 <digits+0x18>
    800032d8:	fffff097          	auipc	ra,0xfffff
    800032dc:	354080e7          	jalr	852(ra) # 8000262c <panic>

00000000800032e0 <kalloc>:
    800032e0:	fe010113          	addi	sp,sp,-32
    800032e4:	00813823          	sd	s0,16(sp)
    800032e8:	00913423          	sd	s1,8(sp)
    800032ec:	00113c23          	sd	ra,24(sp)
    800032f0:	02010413          	addi	s0,sp,32
    800032f4:	00001797          	auipc	a5,0x1
    800032f8:	29c78793          	addi	a5,a5,668 # 80004590 <kmem>
    800032fc:	0007b483          	ld	s1,0(a5)
    80003300:	02048063          	beqz	s1,80003320 <kalloc+0x40>
    80003304:	0004b703          	ld	a4,0(s1)
    80003308:	00001637          	lui	a2,0x1
    8000330c:	00500593          	li	a1,5
    80003310:	00048513          	mv	a0,s1
    80003314:	00e7b023          	sd	a4,0(a5)
    80003318:	00000097          	auipc	ra,0x0
    8000331c:	400080e7          	jalr	1024(ra) # 80003718 <__memset>
    80003320:	01813083          	ld	ra,24(sp)
    80003324:	01013403          	ld	s0,16(sp)
    80003328:	00048513          	mv	a0,s1
    8000332c:	00813483          	ld	s1,8(sp)
    80003330:	02010113          	addi	sp,sp,32
    80003334:	00008067          	ret

0000000080003338 <initlock>:
    80003338:	ff010113          	addi	sp,sp,-16
    8000333c:	00813423          	sd	s0,8(sp)
    80003340:	01010413          	addi	s0,sp,16
    80003344:	00813403          	ld	s0,8(sp)
    80003348:	00b53423          	sd	a1,8(a0)
    8000334c:	00052023          	sw	zero,0(a0)
    80003350:	00053823          	sd	zero,16(a0)
    80003354:	01010113          	addi	sp,sp,16
    80003358:	00008067          	ret

000000008000335c <acquire>:
    8000335c:	fe010113          	addi	sp,sp,-32
    80003360:	00813823          	sd	s0,16(sp)
    80003364:	00913423          	sd	s1,8(sp)
    80003368:	00113c23          	sd	ra,24(sp)
    8000336c:	01213023          	sd	s2,0(sp)
    80003370:	02010413          	addi	s0,sp,32
    80003374:	00050493          	mv	s1,a0
    80003378:	10002973          	csrr	s2,sstatus
    8000337c:	100027f3          	csrr	a5,sstatus
    80003380:	ffd7f793          	andi	a5,a5,-3
    80003384:	10079073          	csrw	sstatus,a5
    80003388:	fffff097          	auipc	ra,0xfffff
    8000338c:	8e8080e7          	jalr	-1816(ra) # 80001c70 <mycpu>
    80003390:	07852783          	lw	a5,120(a0)
    80003394:	06078e63          	beqz	a5,80003410 <acquire+0xb4>
    80003398:	fffff097          	auipc	ra,0xfffff
    8000339c:	8d8080e7          	jalr	-1832(ra) # 80001c70 <mycpu>
    800033a0:	07852783          	lw	a5,120(a0)
    800033a4:	0004a703          	lw	a4,0(s1)
    800033a8:	0017879b          	addiw	a5,a5,1
    800033ac:	06f52c23          	sw	a5,120(a0)
    800033b0:	04071063          	bnez	a4,800033f0 <acquire+0x94>
    800033b4:	00100713          	li	a4,1
    800033b8:	00070793          	mv	a5,a4
    800033bc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800033c0:	0007879b          	sext.w	a5,a5
    800033c4:	fe079ae3          	bnez	a5,800033b8 <acquire+0x5c>
    800033c8:	0ff0000f          	fence
    800033cc:	fffff097          	auipc	ra,0xfffff
    800033d0:	8a4080e7          	jalr	-1884(ra) # 80001c70 <mycpu>
    800033d4:	01813083          	ld	ra,24(sp)
    800033d8:	01013403          	ld	s0,16(sp)
    800033dc:	00a4b823          	sd	a0,16(s1)
    800033e0:	00013903          	ld	s2,0(sp)
    800033e4:	00813483          	ld	s1,8(sp)
    800033e8:	02010113          	addi	sp,sp,32
    800033ec:	00008067          	ret
    800033f0:	0104b903          	ld	s2,16(s1)
    800033f4:	fffff097          	auipc	ra,0xfffff
    800033f8:	87c080e7          	jalr	-1924(ra) # 80001c70 <mycpu>
    800033fc:	faa91ce3          	bne	s2,a0,800033b4 <acquire+0x58>
    80003400:	00001517          	auipc	a0,0x1
    80003404:	da850513          	addi	a0,a0,-600 # 800041a8 <digits+0x20>
    80003408:	fffff097          	auipc	ra,0xfffff
    8000340c:	224080e7          	jalr	548(ra) # 8000262c <panic>
    80003410:	00195913          	srli	s2,s2,0x1
    80003414:	fffff097          	auipc	ra,0xfffff
    80003418:	85c080e7          	jalr	-1956(ra) # 80001c70 <mycpu>
    8000341c:	00197913          	andi	s2,s2,1
    80003420:	07252e23          	sw	s2,124(a0)
    80003424:	f75ff06f          	j	80003398 <acquire+0x3c>

0000000080003428 <release>:
    80003428:	fe010113          	addi	sp,sp,-32
    8000342c:	00813823          	sd	s0,16(sp)
    80003430:	00113c23          	sd	ra,24(sp)
    80003434:	00913423          	sd	s1,8(sp)
    80003438:	01213023          	sd	s2,0(sp)
    8000343c:	02010413          	addi	s0,sp,32
    80003440:	00052783          	lw	a5,0(a0)
    80003444:	00079a63          	bnez	a5,80003458 <release+0x30>
    80003448:	00001517          	auipc	a0,0x1
    8000344c:	d6850513          	addi	a0,a0,-664 # 800041b0 <digits+0x28>
    80003450:	fffff097          	auipc	ra,0xfffff
    80003454:	1dc080e7          	jalr	476(ra) # 8000262c <panic>
    80003458:	01053903          	ld	s2,16(a0)
    8000345c:	00050493          	mv	s1,a0
    80003460:	fffff097          	auipc	ra,0xfffff
    80003464:	810080e7          	jalr	-2032(ra) # 80001c70 <mycpu>
    80003468:	fea910e3          	bne	s2,a0,80003448 <release+0x20>
    8000346c:	0004b823          	sd	zero,16(s1)
    80003470:	0ff0000f          	fence
    80003474:	0f50000f          	fence	iorw,ow
    80003478:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000347c:	ffffe097          	auipc	ra,0xffffe
    80003480:	7f4080e7          	jalr	2036(ra) # 80001c70 <mycpu>
    80003484:	100027f3          	csrr	a5,sstatus
    80003488:	0027f793          	andi	a5,a5,2
    8000348c:	04079a63          	bnez	a5,800034e0 <release+0xb8>
    80003490:	07852783          	lw	a5,120(a0)
    80003494:	02f05e63          	blez	a5,800034d0 <release+0xa8>
    80003498:	fff7871b          	addiw	a4,a5,-1
    8000349c:	06e52c23          	sw	a4,120(a0)
    800034a0:	00071c63          	bnez	a4,800034b8 <release+0x90>
    800034a4:	07c52783          	lw	a5,124(a0)
    800034a8:	00078863          	beqz	a5,800034b8 <release+0x90>
    800034ac:	100027f3          	csrr	a5,sstatus
    800034b0:	0027e793          	ori	a5,a5,2
    800034b4:	10079073          	csrw	sstatus,a5
    800034b8:	01813083          	ld	ra,24(sp)
    800034bc:	01013403          	ld	s0,16(sp)
    800034c0:	00813483          	ld	s1,8(sp)
    800034c4:	00013903          	ld	s2,0(sp)
    800034c8:	02010113          	addi	sp,sp,32
    800034cc:	00008067          	ret
    800034d0:	00001517          	auipc	a0,0x1
    800034d4:	d0050513          	addi	a0,a0,-768 # 800041d0 <digits+0x48>
    800034d8:	fffff097          	auipc	ra,0xfffff
    800034dc:	154080e7          	jalr	340(ra) # 8000262c <panic>
    800034e0:	00001517          	auipc	a0,0x1
    800034e4:	cd850513          	addi	a0,a0,-808 # 800041b8 <digits+0x30>
    800034e8:	fffff097          	auipc	ra,0xfffff
    800034ec:	144080e7          	jalr	324(ra) # 8000262c <panic>

00000000800034f0 <holding>:
    800034f0:	00052783          	lw	a5,0(a0)
    800034f4:	00079663          	bnez	a5,80003500 <holding+0x10>
    800034f8:	00000513          	li	a0,0
    800034fc:	00008067          	ret
    80003500:	fe010113          	addi	sp,sp,-32
    80003504:	00813823          	sd	s0,16(sp)
    80003508:	00913423          	sd	s1,8(sp)
    8000350c:	00113c23          	sd	ra,24(sp)
    80003510:	02010413          	addi	s0,sp,32
    80003514:	01053483          	ld	s1,16(a0)
    80003518:	ffffe097          	auipc	ra,0xffffe
    8000351c:	758080e7          	jalr	1880(ra) # 80001c70 <mycpu>
    80003520:	01813083          	ld	ra,24(sp)
    80003524:	01013403          	ld	s0,16(sp)
    80003528:	40a48533          	sub	a0,s1,a0
    8000352c:	00153513          	seqz	a0,a0
    80003530:	00813483          	ld	s1,8(sp)
    80003534:	02010113          	addi	sp,sp,32
    80003538:	00008067          	ret

000000008000353c <push_off>:
    8000353c:	fe010113          	addi	sp,sp,-32
    80003540:	00813823          	sd	s0,16(sp)
    80003544:	00113c23          	sd	ra,24(sp)
    80003548:	00913423          	sd	s1,8(sp)
    8000354c:	02010413          	addi	s0,sp,32
    80003550:	100024f3          	csrr	s1,sstatus
    80003554:	100027f3          	csrr	a5,sstatus
    80003558:	ffd7f793          	andi	a5,a5,-3
    8000355c:	10079073          	csrw	sstatus,a5
    80003560:	ffffe097          	auipc	ra,0xffffe
    80003564:	710080e7          	jalr	1808(ra) # 80001c70 <mycpu>
    80003568:	07852783          	lw	a5,120(a0)
    8000356c:	02078663          	beqz	a5,80003598 <push_off+0x5c>
    80003570:	ffffe097          	auipc	ra,0xffffe
    80003574:	700080e7          	jalr	1792(ra) # 80001c70 <mycpu>
    80003578:	07852783          	lw	a5,120(a0)
    8000357c:	01813083          	ld	ra,24(sp)
    80003580:	01013403          	ld	s0,16(sp)
    80003584:	0017879b          	addiw	a5,a5,1
    80003588:	06f52c23          	sw	a5,120(a0)
    8000358c:	00813483          	ld	s1,8(sp)
    80003590:	02010113          	addi	sp,sp,32
    80003594:	00008067          	ret
    80003598:	0014d493          	srli	s1,s1,0x1
    8000359c:	ffffe097          	auipc	ra,0xffffe
    800035a0:	6d4080e7          	jalr	1748(ra) # 80001c70 <mycpu>
    800035a4:	0014f493          	andi	s1,s1,1
    800035a8:	06952e23          	sw	s1,124(a0)
    800035ac:	fc5ff06f          	j	80003570 <push_off+0x34>

00000000800035b0 <pop_off>:
    800035b0:	ff010113          	addi	sp,sp,-16
    800035b4:	00813023          	sd	s0,0(sp)
    800035b8:	00113423          	sd	ra,8(sp)
    800035bc:	01010413          	addi	s0,sp,16
    800035c0:	ffffe097          	auipc	ra,0xffffe
    800035c4:	6b0080e7          	jalr	1712(ra) # 80001c70 <mycpu>
    800035c8:	100027f3          	csrr	a5,sstatus
    800035cc:	0027f793          	andi	a5,a5,2
    800035d0:	04079663          	bnez	a5,8000361c <pop_off+0x6c>
    800035d4:	07852783          	lw	a5,120(a0)
    800035d8:	02f05a63          	blez	a5,8000360c <pop_off+0x5c>
    800035dc:	fff7871b          	addiw	a4,a5,-1
    800035e0:	06e52c23          	sw	a4,120(a0)
    800035e4:	00071c63          	bnez	a4,800035fc <pop_off+0x4c>
    800035e8:	07c52783          	lw	a5,124(a0)
    800035ec:	00078863          	beqz	a5,800035fc <pop_off+0x4c>
    800035f0:	100027f3          	csrr	a5,sstatus
    800035f4:	0027e793          	ori	a5,a5,2
    800035f8:	10079073          	csrw	sstatus,a5
    800035fc:	00813083          	ld	ra,8(sp)
    80003600:	00013403          	ld	s0,0(sp)
    80003604:	01010113          	addi	sp,sp,16
    80003608:	00008067          	ret
    8000360c:	00001517          	auipc	a0,0x1
    80003610:	bc450513          	addi	a0,a0,-1084 # 800041d0 <digits+0x48>
    80003614:	fffff097          	auipc	ra,0xfffff
    80003618:	018080e7          	jalr	24(ra) # 8000262c <panic>
    8000361c:	00001517          	auipc	a0,0x1
    80003620:	b9c50513          	addi	a0,a0,-1124 # 800041b8 <digits+0x30>
    80003624:	fffff097          	auipc	ra,0xfffff
    80003628:	008080e7          	jalr	8(ra) # 8000262c <panic>

000000008000362c <push_on>:
    8000362c:	fe010113          	addi	sp,sp,-32
    80003630:	00813823          	sd	s0,16(sp)
    80003634:	00113c23          	sd	ra,24(sp)
    80003638:	00913423          	sd	s1,8(sp)
    8000363c:	02010413          	addi	s0,sp,32
    80003640:	100024f3          	csrr	s1,sstatus
    80003644:	100027f3          	csrr	a5,sstatus
    80003648:	0027e793          	ori	a5,a5,2
    8000364c:	10079073          	csrw	sstatus,a5
    80003650:	ffffe097          	auipc	ra,0xffffe
    80003654:	620080e7          	jalr	1568(ra) # 80001c70 <mycpu>
    80003658:	07852783          	lw	a5,120(a0)
    8000365c:	02078663          	beqz	a5,80003688 <push_on+0x5c>
    80003660:	ffffe097          	auipc	ra,0xffffe
    80003664:	610080e7          	jalr	1552(ra) # 80001c70 <mycpu>
    80003668:	07852783          	lw	a5,120(a0)
    8000366c:	01813083          	ld	ra,24(sp)
    80003670:	01013403          	ld	s0,16(sp)
    80003674:	0017879b          	addiw	a5,a5,1
    80003678:	06f52c23          	sw	a5,120(a0)
    8000367c:	00813483          	ld	s1,8(sp)
    80003680:	02010113          	addi	sp,sp,32
    80003684:	00008067          	ret
    80003688:	0014d493          	srli	s1,s1,0x1
    8000368c:	ffffe097          	auipc	ra,0xffffe
    80003690:	5e4080e7          	jalr	1508(ra) # 80001c70 <mycpu>
    80003694:	0014f493          	andi	s1,s1,1
    80003698:	06952e23          	sw	s1,124(a0)
    8000369c:	fc5ff06f          	j	80003660 <push_on+0x34>

00000000800036a0 <pop_on>:
    800036a0:	ff010113          	addi	sp,sp,-16
    800036a4:	00813023          	sd	s0,0(sp)
    800036a8:	00113423          	sd	ra,8(sp)
    800036ac:	01010413          	addi	s0,sp,16
    800036b0:	ffffe097          	auipc	ra,0xffffe
    800036b4:	5c0080e7          	jalr	1472(ra) # 80001c70 <mycpu>
    800036b8:	100027f3          	csrr	a5,sstatus
    800036bc:	0027f793          	andi	a5,a5,2
    800036c0:	04078463          	beqz	a5,80003708 <pop_on+0x68>
    800036c4:	07852783          	lw	a5,120(a0)
    800036c8:	02f05863          	blez	a5,800036f8 <pop_on+0x58>
    800036cc:	fff7879b          	addiw	a5,a5,-1
    800036d0:	06f52c23          	sw	a5,120(a0)
    800036d4:	07853783          	ld	a5,120(a0)
    800036d8:	00079863          	bnez	a5,800036e8 <pop_on+0x48>
    800036dc:	100027f3          	csrr	a5,sstatus
    800036e0:	ffd7f793          	andi	a5,a5,-3
    800036e4:	10079073          	csrw	sstatus,a5
    800036e8:	00813083          	ld	ra,8(sp)
    800036ec:	00013403          	ld	s0,0(sp)
    800036f0:	01010113          	addi	sp,sp,16
    800036f4:	00008067          	ret
    800036f8:	00001517          	auipc	a0,0x1
    800036fc:	b0050513          	addi	a0,a0,-1280 # 800041f8 <digits+0x70>
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	f2c080e7          	jalr	-212(ra) # 8000262c <panic>
    80003708:	00001517          	auipc	a0,0x1
    8000370c:	ad050513          	addi	a0,a0,-1328 # 800041d8 <digits+0x50>
    80003710:	fffff097          	auipc	ra,0xfffff
    80003714:	f1c080e7          	jalr	-228(ra) # 8000262c <panic>

0000000080003718 <__memset>:
    80003718:	ff010113          	addi	sp,sp,-16
    8000371c:	00813423          	sd	s0,8(sp)
    80003720:	01010413          	addi	s0,sp,16
    80003724:	1a060e63          	beqz	a2,800038e0 <__memset+0x1c8>
    80003728:	40a007b3          	neg	a5,a0
    8000372c:	0077f793          	andi	a5,a5,7
    80003730:	00778693          	addi	a3,a5,7
    80003734:	00b00813          	li	a6,11
    80003738:	0ff5f593          	andi	a1,a1,255
    8000373c:	fff6071b          	addiw	a4,a2,-1
    80003740:	1b06e663          	bltu	a3,a6,800038ec <__memset+0x1d4>
    80003744:	1cd76463          	bltu	a4,a3,8000390c <__memset+0x1f4>
    80003748:	1a078e63          	beqz	a5,80003904 <__memset+0x1ec>
    8000374c:	00b50023          	sb	a1,0(a0)
    80003750:	00100713          	li	a4,1
    80003754:	1ae78463          	beq	a5,a4,800038fc <__memset+0x1e4>
    80003758:	00b500a3          	sb	a1,1(a0)
    8000375c:	00200713          	li	a4,2
    80003760:	1ae78a63          	beq	a5,a4,80003914 <__memset+0x1fc>
    80003764:	00b50123          	sb	a1,2(a0)
    80003768:	00300713          	li	a4,3
    8000376c:	18e78463          	beq	a5,a4,800038f4 <__memset+0x1dc>
    80003770:	00b501a3          	sb	a1,3(a0)
    80003774:	00400713          	li	a4,4
    80003778:	1ae78263          	beq	a5,a4,8000391c <__memset+0x204>
    8000377c:	00b50223          	sb	a1,4(a0)
    80003780:	00500713          	li	a4,5
    80003784:	1ae78063          	beq	a5,a4,80003924 <__memset+0x20c>
    80003788:	00b502a3          	sb	a1,5(a0)
    8000378c:	00700713          	li	a4,7
    80003790:	18e79e63          	bne	a5,a4,8000392c <__memset+0x214>
    80003794:	00b50323          	sb	a1,6(a0)
    80003798:	00700e93          	li	t4,7
    8000379c:	00859713          	slli	a4,a1,0x8
    800037a0:	00e5e733          	or	a4,a1,a4
    800037a4:	01059e13          	slli	t3,a1,0x10
    800037a8:	01c76e33          	or	t3,a4,t3
    800037ac:	01859313          	slli	t1,a1,0x18
    800037b0:	006e6333          	or	t1,t3,t1
    800037b4:	02059893          	slli	a7,a1,0x20
    800037b8:	40f60e3b          	subw	t3,a2,a5
    800037bc:	011368b3          	or	a7,t1,a7
    800037c0:	02859813          	slli	a6,a1,0x28
    800037c4:	0108e833          	or	a6,a7,a6
    800037c8:	03059693          	slli	a3,a1,0x30
    800037cc:	003e589b          	srliw	a7,t3,0x3
    800037d0:	00d866b3          	or	a3,a6,a3
    800037d4:	03859713          	slli	a4,a1,0x38
    800037d8:	00389813          	slli	a6,a7,0x3
    800037dc:	00f507b3          	add	a5,a0,a5
    800037e0:	00e6e733          	or	a4,a3,a4
    800037e4:	000e089b          	sext.w	a7,t3
    800037e8:	00f806b3          	add	a3,a6,a5
    800037ec:	00e7b023          	sd	a4,0(a5)
    800037f0:	00878793          	addi	a5,a5,8
    800037f4:	fed79ce3          	bne	a5,a3,800037ec <__memset+0xd4>
    800037f8:	ff8e7793          	andi	a5,t3,-8
    800037fc:	0007871b          	sext.w	a4,a5
    80003800:	01d787bb          	addw	a5,a5,t4
    80003804:	0ce88e63          	beq	a7,a4,800038e0 <__memset+0x1c8>
    80003808:	00f50733          	add	a4,a0,a5
    8000380c:	00b70023          	sb	a1,0(a4)
    80003810:	0017871b          	addiw	a4,a5,1
    80003814:	0cc77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003818:	00e50733          	add	a4,a0,a4
    8000381c:	00b70023          	sb	a1,0(a4)
    80003820:	0027871b          	addiw	a4,a5,2
    80003824:	0ac77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003828:	00e50733          	add	a4,a0,a4
    8000382c:	00b70023          	sb	a1,0(a4)
    80003830:	0037871b          	addiw	a4,a5,3
    80003834:	0ac77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003838:	00e50733          	add	a4,a0,a4
    8000383c:	00b70023          	sb	a1,0(a4)
    80003840:	0047871b          	addiw	a4,a5,4
    80003844:	08c77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003848:	00e50733          	add	a4,a0,a4
    8000384c:	00b70023          	sb	a1,0(a4)
    80003850:	0057871b          	addiw	a4,a5,5
    80003854:	08c77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003858:	00e50733          	add	a4,a0,a4
    8000385c:	00b70023          	sb	a1,0(a4)
    80003860:	0067871b          	addiw	a4,a5,6
    80003864:	06c77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003868:	00e50733          	add	a4,a0,a4
    8000386c:	00b70023          	sb	a1,0(a4)
    80003870:	0077871b          	addiw	a4,a5,7
    80003874:	06c77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003878:	00e50733          	add	a4,a0,a4
    8000387c:	00b70023          	sb	a1,0(a4)
    80003880:	0087871b          	addiw	a4,a5,8
    80003884:	04c77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003888:	00e50733          	add	a4,a0,a4
    8000388c:	00b70023          	sb	a1,0(a4)
    80003890:	0097871b          	addiw	a4,a5,9
    80003894:	04c77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    80003898:	00e50733          	add	a4,a0,a4
    8000389c:	00b70023          	sb	a1,0(a4)
    800038a0:	00a7871b          	addiw	a4,a5,10
    800038a4:	02c77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    800038a8:	00e50733          	add	a4,a0,a4
    800038ac:	00b70023          	sb	a1,0(a4)
    800038b0:	00b7871b          	addiw	a4,a5,11
    800038b4:	02c77663          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    800038b8:	00e50733          	add	a4,a0,a4
    800038bc:	00b70023          	sb	a1,0(a4)
    800038c0:	00c7871b          	addiw	a4,a5,12
    800038c4:	00c77e63          	bgeu	a4,a2,800038e0 <__memset+0x1c8>
    800038c8:	00e50733          	add	a4,a0,a4
    800038cc:	00b70023          	sb	a1,0(a4)
    800038d0:	00d7879b          	addiw	a5,a5,13
    800038d4:	00c7f663          	bgeu	a5,a2,800038e0 <__memset+0x1c8>
    800038d8:	00f507b3          	add	a5,a0,a5
    800038dc:	00b78023          	sb	a1,0(a5)
    800038e0:	00813403          	ld	s0,8(sp)
    800038e4:	01010113          	addi	sp,sp,16
    800038e8:	00008067          	ret
    800038ec:	00b00693          	li	a3,11
    800038f0:	e55ff06f          	j	80003744 <__memset+0x2c>
    800038f4:	00300e93          	li	t4,3
    800038f8:	ea5ff06f          	j	8000379c <__memset+0x84>
    800038fc:	00100e93          	li	t4,1
    80003900:	e9dff06f          	j	8000379c <__memset+0x84>
    80003904:	00000e93          	li	t4,0
    80003908:	e95ff06f          	j	8000379c <__memset+0x84>
    8000390c:	00000793          	li	a5,0
    80003910:	ef9ff06f          	j	80003808 <__memset+0xf0>
    80003914:	00200e93          	li	t4,2
    80003918:	e85ff06f          	j	8000379c <__memset+0x84>
    8000391c:	00400e93          	li	t4,4
    80003920:	e7dff06f          	j	8000379c <__memset+0x84>
    80003924:	00500e93          	li	t4,5
    80003928:	e75ff06f          	j	8000379c <__memset+0x84>
    8000392c:	00600e93          	li	t4,6
    80003930:	e6dff06f          	j	8000379c <__memset+0x84>

0000000080003934 <__memmove>:
    80003934:	ff010113          	addi	sp,sp,-16
    80003938:	00813423          	sd	s0,8(sp)
    8000393c:	01010413          	addi	s0,sp,16
    80003940:	0e060863          	beqz	a2,80003a30 <__memmove+0xfc>
    80003944:	fff6069b          	addiw	a3,a2,-1
    80003948:	0006881b          	sext.w	a6,a3
    8000394c:	0ea5e863          	bltu	a1,a0,80003a3c <__memmove+0x108>
    80003950:	00758713          	addi	a4,a1,7
    80003954:	00a5e7b3          	or	a5,a1,a0
    80003958:	40a70733          	sub	a4,a4,a0
    8000395c:	0077f793          	andi	a5,a5,7
    80003960:	00f73713          	sltiu	a4,a4,15
    80003964:	00174713          	xori	a4,a4,1
    80003968:	0017b793          	seqz	a5,a5
    8000396c:	00e7f7b3          	and	a5,a5,a4
    80003970:	10078863          	beqz	a5,80003a80 <__memmove+0x14c>
    80003974:	00900793          	li	a5,9
    80003978:	1107f463          	bgeu	a5,a6,80003a80 <__memmove+0x14c>
    8000397c:	0036581b          	srliw	a6,a2,0x3
    80003980:	fff8081b          	addiw	a6,a6,-1
    80003984:	02081813          	slli	a6,a6,0x20
    80003988:	01d85893          	srli	a7,a6,0x1d
    8000398c:	00858813          	addi	a6,a1,8
    80003990:	00058793          	mv	a5,a1
    80003994:	00050713          	mv	a4,a0
    80003998:	01088833          	add	a6,a7,a6
    8000399c:	0007b883          	ld	a7,0(a5)
    800039a0:	00878793          	addi	a5,a5,8
    800039a4:	00870713          	addi	a4,a4,8
    800039a8:	ff173c23          	sd	a7,-8(a4)
    800039ac:	ff0798e3          	bne	a5,a6,8000399c <__memmove+0x68>
    800039b0:	ff867713          	andi	a4,a2,-8
    800039b4:	02071793          	slli	a5,a4,0x20
    800039b8:	0207d793          	srli	a5,a5,0x20
    800039bc:	00f585b3          	add	a1,a1,a5
    800039c0:	40e686bb          	subw	a3,a3,a4
    800039c4:	00f507b3          	add	a5,a0,a5
    800039c8:	06e60463          	beq	a2,a4,80003a30 <__memmove+0xfc>
    800039cc:	0005c703          	lbu	a4,0(a1)
    800039d0:	00e78023          	sb	a4,0(a5)
    800039d4:	04068e63          	beqz	a3,80003a30 <__memmove+0xfc>
    800039d8:	0015c603          	lbu	a2,1(a1)
    800039dc:	00100713          	li	a4,1
    800039e0:	00c780a3          	sb	a2,1(a5)
    800039e4:	04e68663          	beq	a3,a4,80003a30 <__memmove+0xfc>
    800039e8:	0025c603          	lbu	a2,2(a1)
    800039ec:	00200713          	li	a4,2
    800039f0:	00c78123          	sb	a2,2(a5)
    800039f4:	02e68e63          	beq	a3,a4,80003a30 <__memmove+0xfc>
    800039f8:	0035c603          	lbu	a2,3(a1)
    800039fc:	00300713          	li	a4,3
    80003a00:	00c781a3          	sb	a2,3(a5)
    80003a04:	02e68663          	beq	a3,a4,80003a30 <__memmove+0xfc>
    80003a08:	0045c603          	lbu	a2,4(a1)
    80003a0c:	00400713          	li	a4,4
    80003a10:	00c78223          	sb	a2,4(a5)
    80003a14:	00e68e63          	beq	a3,a4,80003a30 <__memmove+0xfc>
    80003a18:	0055c603          	lbu	a2,5(a1)
    80003a1c:	00500713          	li	a4,5
    80003a20:	00c782a3          	sb	a2,5(a5)
    80003a24:	00e68663          	beq	a3,a4,80003a30 <__memmove+0xfc>
    80003a28:	0065c703          	lbu	a4,6(a1)
    80003a2c:	00e78323          	sb	a4,6(a5)
    80003a30:	00813403          	ld	s0,8(sp)
    80003a34:	01010113          	addi	sp,sp,16
    80003a38:	00008067          	ret
    80003a3c:	02061713          	slli	a4,a2,0x20
    80003a40:	02075713          	srli	a4,a4,0x20
    80003a44:	00e587b3          	add	a5,a1,a4
    80003a48:	f0f574e3          	bgeu	a0,a5,80003950 <__memmove+0x1c>
    80003a4c:	02069613          	slli	a2,a3,0x20
    80003a50:	02065613          	srli	a2,a2,0x20
    80003a54:	fff64613          	not	a2,a2
    80003a58:	00e50733          	add	a4,a0,a4
    80003a5c:	00c78633          	add	a2,a5,a2
    80003a60:	fff7c683          	lbu	a3,-1(a5)
    80003a64:	fff78793          	addi	a5,a5,-1
    80003a68:	fff70713          	addi	a4,a4,-1
    80003a6c:	00d70023          	sb	a3,0(a4)
    80003a70:	fec798e3          	bne	a5,a2,80003a60 <__memmove+0x12c>
    80003a74:	00813403          	ld	s0,8(sp)
    80003a78:	01010113          	addi	sp,sp,16
    80003a7c:	00008067          	ret
    80003a80:	02069713          	slli	a4,a3,0x20
    80003a84:	02075713          	srli	a4,a4,0x20
    80003a88:	00170713          	addi	a4,a4,1
    80003a8c:	00e50733          	add	a4,a0,a4
    80003a90:	00050793          	mv	a5,a0
    80003a94:	0005c683          	lbu	a3,0(a1)
    80003a98:	00178793          	addi	a5,a5,1
    80003a9c:	00158593          	addi	a1,a1,1
    80003aa0:	fed78fa3          	sb	a3,-1(a5)
    80003aa4:	fee798e3          	bne	a5,a4,80003a94 <__memmove+0x160>
    80003aa8:	f89ff06f          	j	80003a30 <__memmove+0xfc>

0000000080003aac <__putc>:
    80003aac:	fe010113          	addi	sp,sp,-32
    80003ab0:	00813823          	sd	s0,16(sp)
    80003ab4:	00113c23          	sd	ra,24(sp)
    80003ab8:	02010413          	addi	s0,sp,32
    80003abc:	00050793          	mv	a5,a0
    80003ac0:	fef40593          	addi	a1,s0,-17
    80003ac4:	00100613          	li	a2,1
    80003ac8:	00000513          	li	a0,0
    80003acc:	fef407a3          	sb	a5,-17(s0)
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	b3c080e7          	jalr	-1220(ra) # 8000260c <console_write>
    80003ad8:	01813083          	ld	ra,24(sp)
    80003adc:	01013403          	ld	s0,16(sp)
    80003ae0:	02010113          	addi	sp,sp,32
    80003ae4:	00008067          	ret

0000000080003ae8 <__getc>:
    80003ae8:	fe010113          	addi	sp,sp,-32
    80003aec:	00813823          	sd	s0,16(sp)
    80003af0:	00113c23          	sd	ra,24(sp)
    80003af4:	02010413          	addi	s0,sp,32
    80003af8:	fe840593          	addi	a1,s0,-24
    80003afc:	00100613          	li	a2,1
    80003b00:	00000513          	li	a0,0
    80003b04:	fffff097          	auipc	ra,0xfffff
    80003b08:	ae8080e7          	jalr	-1304(ra) # 800025ec <console_read>
    80003b0c:	fe844503          	lbu	a0,-24(s0)
    80003b10:	01813083          	ld	ra,24(sp)
    80003b14:	01013403          	ld	s0,16(sp)
    80003b18:	02010113          	addi	sp,sp,32
    80003b1c:	00008067          	ret

0000000080003b20 <console_handler>:
    80003b20:	fe010113          	addi	sp,sp,-32
    80003b24:	00813823          	sd	s0,16(sp)
    80003b28:	00113c23          	sd	ra,24(sp)
    80003b2c:	00913423          	sd	s1,8(sp)
    80003b30:	02010413          	addi	s0,sp,32
    80003b34:	14202773          	csrr	a4,scause
    80003b38:	100027f3          	csrr	a5,sstatus
    80003b3c:	0027f793          	andi	a5,a5,2
    80003b40:	06079e63          	bnez	a5,80003bbc <console_handler+0x9c>
    80003b44:	00074c63          	bltz	a4,80003b5c <console_handler+0x3c>
    80003b48:	01813083          	ld	ra,24(sp)
    80003b4c:	01013403          	ld	s0,16(sp)
    80003b50:	00813483          	ld	s1,8(sp)
    80003b54:	02010113          	addi	sp,sp,32
    80003b58:	00008067          	ret
    80003b5c:	0ff77713          	andi	a4,a4,255
    80003b60:	00900793          	li	a5,9
    80003b64:	fef712e3          	bne	a4,a5,80003b48 <console_handler+0x28>
    80003b68:	ffffe097          	auipc	ra,0xffffe
    80003b6c:	6dc080e7          	jalr	1756(ra) # 80002244 <plic_claim>
    80003b70:	00a00793          	li	a5,10
    80003b74:	00050493          	mv	s1,a0
    80003b78:	02f50c63          	beq	a0,a5,80003bb0 <console_handler+0x90>
    80003b7c:	fc0506e3          	beqz	a0,80003b48 <console_handler+0x28>
    80003b80:	00050593          	mv	a1,a0
    80003b84:	00000517          	auipc	a0,0x0
    80003b88:	57c50513          	addi	a0,a0,1404 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80003b8c:	fffff097          	auipc	ra,0xfffff
    80003b90:	afc080e7          	jalr	-1284(ra) # 80002688 <__printf>
    80003b94:	01013403          	ld	s0,16(sp)
    80003b98:	01813083          	ld	ra,24(sp)
    80003b9c:	00048513          	mv	a0,s1
    80003ba0:	00813483          	ld	s1,8(sp)
    80003ba4:	02010113          	addi	sp,sp,32
    80003ba8:	ffffe317          	auipc	t1,0xffffe
    80003bac:	6d430067          	jr	1748(t1) # 8000227c <plic_complete>
    80003bb0:	fffff097          	auipc	ra,0xfffff
    80003bb4:	3e0080e7          	jalr	992(ra) # 80002f90 <uartintr>
    80003bb8:	fddff06f          	j	80003b94 <console_handler+0x74>
    80003bbc:	00000517          	auipc	a0,0x0
    80003bc0:	64450513          	addi	a0,a0,1604 # 80004200 <digits+0x78>
    80003bc4:	fffff097          	auipc	ra,0xfffff
    80003bc8:	a68080e7          	jalr	-1432(ra) # 8000262c <panic>
	...
