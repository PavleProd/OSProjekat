
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00005117          	auipc	sp,0x5
    80000004:	7c013103          	ld	sp,1984(sp) # 800057c0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	755010ef          	jal	ra,80001f70 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt>:
.extern interruptHandler
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
    80001080:	2cc000ef          	jal	ra,8000134c <interruptHandler>

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

// a0 code a1 size
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

// a0 code a1 memSegment
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

00000000800012bc <_Z13thread_createPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800012bc:	ff010113          	addi	sp,sp,-16
    800012c0:	00113423          	sd	ra,8(sp)
    800012c4:	00813023          	sd	s0,0(sp)
    800012c8:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    800012cc:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    800012d0:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
    800012d4:	00050713          	mv	a4,a0

    size_t* stack = new size_t[DEFAULT_STACK_SIZE]; // pravimo stack procesa
    800012d8:	00008537          	lui	a0,0x8
    800012dc:	00000097          	auipc	ra,0x0
    800012e0:	754080e7          	jalr	1876(ra) # 80001a30 <_Znam>
    if(stack == nullptr) return -1;
    800012e4:	02050c63          	beqz	a0,8000131c <_Z13thread_createPP3PCBPFvPvES2_+0x60>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    800012e8:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    800012ec:	00050713          	mv	a4,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800012f0:	01100793          	li	a5,17
    800012f4:	00078513          	mv	a0,a5

    // *handle = PCB::createProccess((PCB::processMain)startRoutine, arg);
    handle = (thread_t*)(callInterrupt()); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    800012f8:	00000097          	auipc	ra,0x0
    800012fc:	f28080e7          	jalr	-216(ra) # 80001220 <_Z13callInterruptv>
    if(*handle == nullptr) {
    80001300:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    80001304:	02078063          	beqz	a5,80001324 <_Z13thread_createPP3PCBPFvPvES2_+0x68>
        return -1;
    }
    return 0;
    80001308:	00000513          	li	a0,0
}
    8000130c:	00813083          	ld	ra,8(sp)
    80001310:	00013403          	ld	s0,0(sp)
    80001314:	01010113          	addi	sp,sp,16
    80001318:	00008067          	ret
    if(stack == nullptr) return -1;
    8000131c:	fff00513          	li	a0,-1
    80001320:	fedff06f          	j	8000130c <_Z13thread_createPP3PCBPFvPvES2_+0x50>
        return -1;
    80001324:	fff00513          	li	a0,-1
    80001328:	fe5ff06f          	j	8000130c <_Z13thread_createPP3PCBPFvPvES2_+0x50>

000000008000132c <_ZN6Kernel10popSppSpieEv>:
#include "../h/PCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"

void Kernel::popSppSpie() {
    8000132c:	ff010113          	addi	sp,sp,-16
    80001330:	00813423          	sd	s0,8(sp)
    80001334:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001338:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    8000133c:	10200073          	sret
}
    80001340:	00813403          	ld	s0,8(sp)
    80001344:	01010113          	addi	sp,sp,16
    80001348:	00008067          	ret

000000008000134c <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    8000134c:	fb010113          	addi	sp,sp,-80
    80001350:	04113423          	sd	ra,72(sp)
    80001354:	04813023          	sd	s0,64(sp)
    80001358:	02913c23          	sd	s1,56(sp)
    8000135c:	05010413          	addi	s0,sp,80
    size_t volatile scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    80001360:	142027f3          	csrr	a5,scause
    80001364:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001368:	141027f3          	csrr	a5,sepc
    8000136c:	fcf43023          	sd	a5,-64(s0)
        return sepc;
    80001370:	fc043783          	ld	a5,-64(s0)

    size_t volatile sepc = Kernel::r_sepc();
    80001374:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001378:	100027f3          	csrr	a5,sstatus
    8000137c:	faf43c23          	sd	a5,-72(s0)
        return sstatus;
    80001380:	fb843783          	ld	a5,-72(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001384:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001388:	fd843703          	ld	a4,-40(s0)
    8000138c:	00900793          	li	a5,9
    80001390:	04f70263          	beq	a4,a5,800013d4 <interruptHandler+0x88>
    80001394:	fd843703          	ld	a4,-40(s0)
    80001398:	00800793          	li	a5,8
    8000139c:	02f70c63          	beq	a4,a5,800013d4 <interruptHandler+0x88>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800013a0:	fd843703          	ld	a4,-40(s0)
    800013a4:	fff00793          	li	a5,-1
    800013a8:	03f79793          	slli	a5,a5,0x3f
    800013ac:	00178793          	addi	a5,a5,1
    800013b0:	0ef70e63          	beq	a4,a5,800014ac <interruptHandler+0x160>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800013b4:	fd843703          	ld	a4,-40(s0)
    800013b8:	fff00793          	li	a5,-1
    800013bc:	03f79793          	slli	a5,a5,0x3f
    800013c0:	00978793          	addi	a5,a5,9
    800013c4:	14f70263          	beq	a4,a5,80001508 <interruptHandler+0x1bc>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800013c8:	00001097          	auipc	ra,0x1
    800013cc:	b1c080e7          	jalr	-1252(ra) # 80001ee4 <_Z10printErrorv>
    800013d0:	0800006f          	j	80001450 <interruptHandler+0x104>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800013d4:	fd043783          	ld	a5,-48(s0)
    800013d8:	00478793          	addi	a5,a5,4
    800013dc:	fcf43823          	sd	a5,-48(s0)
        asm volatile("ld %0, 10*8 + 80(sp)" : "=r" (code)); // a0(x10)
    800013e0:	0a013783          	ld	a5,160(sp)
        switch(code) {
    800013e4:	01100713          	li	a4,17
    800013e8:	06e78e63          	beq	a5,a4,80001464 <interruptHandler+0x118>
    800013ec:	02f76263          	bltu	a4,a5,80001410 <interruptHandler+0xc4>
    800013f0:	00100713          	li	a4,1
    800013f4:	02e78e63          	beq	a5,a4,80001430 <interruptHandler+0xe4>
    800013f8:	00200713          	li	a4,2
    800013fc:	0ae79263          	bne	a5,a4,800014a0 <interruptHandler+0x154>
                asm volatile("ld %0, 11*8 + 80(sp)" : "=r" (memSegment)); // a1(x11)
    80001400:	0a813503          	ld	a0,168(sp)
                MemoryAllocator::mem_free(memSegment);
    80001404:	00001097          	auipc	ra,0x1
    80001408:	808080e7          	jalr	-2040(ra) # 80001c0c <_ZN15MemoryAllocator8mem_freeEPv>
                break;
    8000140c:	0340006f          	j	80001440 <interruptHandler+0xf4>
        switch(code) {
    80001410:	01300713          	li	a4,19
    80001414:	08e79663          	bne	a5,a4,800014a0 <interruptHandler+0x154>
                PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001418:	00000097          	auipc	ra,0x0
    8000141c:	180080e7          	jalr	384(ra) # 80001598 <_ZN3PCB8dispatchEv>
                PCB::timeSliceCounter = 0;
    80001420:	00004797          	auipc	a5,0x4
    80001424:	3987b783          	ld	a5,920(a5) # 800057b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001428:	0007b023          	sd	zero,0(a5)
                break;
    8000142c:	0140006f          	j	80001440 <interruptHandler+0xf4>
                asm volatile("ld %0, 11*8 + 80(sp)" : "=r" (size)); // a1(x11)
    80001430:	0a813503          	ld	a0,168(sp)
                MemoryAllocator::mem_alloc(size);
    80001434:	00651513          	slli	a0,a0,0x6
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	670080e7          	jalr	1648(ra) # 80001aa8 <_ZN15MemoryAllocator9mem_allocEm>
        Kernel::w_sepc(sepc);
    80001440:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001444:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001448:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000144c:	10079073          	csrw	sstatus,a5
    }

}
    80001450:	04813083          	ld	ra,72(sp)
    80001454:	04013403          	ld	s0,64(sp)
    80001458:	03813483          	ld	s1,56(sp)
    8000145c:	05010113          	addi	sp,sp,80
    80001460:	00008067          	ret
                asm volatile("ld %0, 12*8 + 80(sp)" : "=r" (main)); // a2(x12)
    80001464:	0b013503          	ld	a0,176(sp)
                asm volatile("ld %0, 13*8 + 80(sp)" : "=r" (arg)); // a3(x13)
    80001468:	0b813583          	ld	a1,184(sp)
                asm volatile("ld %0, 11*8 + 80(sp)" : "=r" (handle)); // a1(x11)
    8000146c:	0a813483          	ld	s1,168(sp)
                *handle = PCB::createProccess(main, arg);
    80001470:	00000097          	auipc	ra,0x0
    80001474:	274080e7          	jalr	628(ra) # 800016e4 <_ZN3PCB14createProccessEPFvvEPv>
    80001478:	00a4b023          	sd	a0,0(s1)
                asm volatile("ld %0, 14*8 + 80(sp)" : "=r" (stack)); // a4(x14)
    8000147c:	0c013783          	ld	a5,192(sp)
                (*handle)->stack = stack;
    80001480:	00f53423          	sd	a5,8(a0)
                (*handle)->context.sp = stack[DEFAULT_STACK_SIZE];
    80001484:	0004b703          	ld	a4,0(s1)
    80001488:	000086b7          	lui	a3,0x8
    8000148c:	00d787b3          	add	a5,a5,a3
    80001490:	0007b783          	ld	a5,0(a5)
    80001494:	02f73023          	sd	a5,32(a4)
                asm volatile("mv a0, %0" : : "r" (handle));
    80001498:	00048513          	mv	a0,s1
                break;
    8000149c:	fa5ff06f          	j	80001440 <interruptHandler+0xf4>
                printError();
    800014a0:	00001097          	auipc	ra,0x1
    800014a4:	a44080e7          	jalr	-1468(ra) # 80001ee4 <_Z10printErrorv>
                break;
    800014a8:	f99ff06f          	j	80001440 <interruptHandler+0xf4>
        PCB::timeSliceCounter++;
    800014ac:	00004717          	auipc	a4,0x4
    800014b0:	30c73703          	ld	a4,780(a4) # 800057b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800014b4:	00073783          	ld	a5,0(a4)
    800014b8:	00178793          	addi	a5,a5,1
    800014bc:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800014c0:	00004717          	auipc	a4,0x4
    800014c4:	30873703          	ld	a4,776(a4) # 800057c8 <_GLOBAL_OFFSET_TABLE_+0x20>
    800014c8:	00073703          	ld	a4,0(a4)
    800014cc:	04873703          	ld	a4,72(a4)
    800014d0:	00e7f863          	bgeu	a5,a4,800014e0 <interruptHandler+0x194>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800014d4:	00200793          	li	a5,2
    800014d8:	1447b073          	csrc	sip,a5
    }
    800014dc:	f75ff06f          	j	80001450 <interruptHandler+0x104>
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800014e0:	00000097          	auipc	ra,0x0
    800014e4:	0b8080e7          	jalr	184(ra) # 80001598 <_ZN3PCB8dispatchEv>
            PCB::timeSliceCounter = 0;
    800014e8:	00004797          	auipc	a5,0x4
    800014ec:	2d07b783          	ld	a5,720(a5) # 800057b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800014f0:	0007b023          	sd	zero,0(a5)
            Kernel::w_sepc(sepc);
    800014f4:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800014f8:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800014fc:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001500:	10079073          	csrw	sstatus,a5
    }
    80001504:	fd1ff06f          	j	800014d4 <interruptHandler+0x188>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    80001508:	00003097          	auipc	ra,0x3
    8000150c:	b98080e7          	jalr	-1128(ra) # 800040a0 <console_handler>
    80001510:	f41ff06f          	j	80001450 <interruptHandler+0x104>

0000000080001514 <_ZN3PCB5yieldEv>:

PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
}

void PCB::yield() {
    80001514:	ff010113          	addi	sp,sp,-16
    80001518:	00813423          	sd	s0,8(sp)
    8000151c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code));
    80001520:	01300793          	li	a5,19
    80001524:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001528:	00000073          	ecall
}
    8000152c:	00813403          	ld	s0,8(sp)
    80001530:	01010113          	addi	sp,sp,16
    80001534:	00008067          	ret

0000000080001538 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001538:	fe010113          	addi	sp,sp,-32
    8000153c:	00113c23          	sd	ra,24(sp)
    80001540:	00813823          	sd	s0,16(sp)
    80001544:	00913423          	sd	s1,8(sp)
    80001548:	02010413          	addi	s0,sp,32
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	de0080e7          	jalr	-544(ra) # 8000132c <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001554:	00004497          	auipc	s1,0x4
    80001558:	2cc48493          	addi	s1,s1,716 # 80005820 <_ZN3PCB7runningE>
    8000155c:	0004b783          	ld	a5,0(s1)
    80001560:	0407b703          	ld	a4,64(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001564:	00070513          	mv	a0,a4
    running->main();
    80001568:	0307b783          	ld	a5,48(a5)
    8000156c:	000780e7          	jalr	a5
    running->setFinished(true);
    80001570:	0004b783          	ld	a5,0(s1)
    }

    using processMain = void(*)(); // pokazivac na void funkciju bez argumenata

    // Pravi novi proces koji izvrasva funkciju main
    static PCB* createProccess(processMain main, void* arguments);
    80001574:	00100713          	li	a4,1
    80001578:	02e78c23          	sb	a4,56(a5)
    PCB::yield(); // nit je gotova pa predajemo procesor drugom precesu
    8000157c:	00000097          	auipc	ra,0x0
    80001580:	f98080e7          	jalr	-104(ra) # 80001514 <_ZN3PCB5yieldEv>
}
    80001584:	01813083          	ld	ra,24(sp)
    80001588:	01013403          	ld	s0,16(sp)
    8000158c:	00813483          	ld	s1,8(sp)
    80001590:	02010113          	addi	sp,sp,32
    80001594:	00008067          	ret

0000000080001598 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001598:	fe010113          	addi	sp,sp,-32
    8000159c:	00113c23          	sd	ra,24(sp)
    800015a0:	00813823          	sd	s0,16(sp)
    800015a4:	00913423          	sd	s1,8(sp)
    800015a8:	02010413          	addi	s0,sp,32
    PCB* old = running;
    800015ac:	00004497          	auipc	s1,0x4
    800015b0:	2744b483          	ld	s1,628(s1) # 80005820 <_ZN3PCB7runningE>
    using processMain = void(*)(); // pokazivac na void funkciju bez argumenata
    800015b4:	0384c783          	lbu	a5,56(s1)
    if(!old->isFinished()) {
    800015b8:	02078c63          	beqz	a5,800015f0 <_ZN3PCB8dispatchEv+0x58>
    running = Scheduler::get();
    800015bc:	00000097          	auipc	ra,0x0
    800015c0:	1f8080e7          	jalr	504(ra) # 800017b4 <_ZN9Scheduler3getEv>
    800015c4:	00050593          	mv	a1,a0
    800015c8:	00004797          	auipc	a5,0x4
    800015cc:	24a7bc23          	sd	a0,600(a5) # 80005820 <_ZN3PCB7runningE>
    switchContext(&old->context, &running->context);
    800015d0:	00048513          	mv	a0,s1
    800015d4:	00000097          	auipc	ra,0x0
    800015d8:	c38080e7          	jalr	-968(ra) # 8000120c <_ZN3PCB13switchContextEPNS_7ContextES1_>
}
    800015dc:	01813083          	ld	ra,24(sp)
    800015e0:	01013403          	ld	s0,16(sp)
    800015e4:	00813483          	ld	s1,8(sp)
    800015e8:	02010113          	addi	sp,sp,32
    800015ec:	00008067          	ret
        Scheduler::put(old);
    800015f0:	00048513          	mv	a0,s1
    800015f4:	00000097          	auipc	ra,0x0
    800015f8:	178080e7          	jalr	376(ra) # 8000176c <_ZN9Scheduler3putEP3PCB>
    800015fc:	fc1ff06f          	j	800015bc <_ZN3PCB8dispatchEv+0x24>

0000000080001600 <_ZN3PCBC1EPFvvEmPv>:
: context({(size_t)(&proccessWrapper), 0, 0}) { // sp cemo dodeliti u sistemskom pozivu thread_create
    80001600:	00000797          	auipc	a5,0x0
    80001604:	f3878793          	addi	a5,a5,-200 # 80001538 <_ZN3PCB15proccessWrapperEv>
    80001608:	00f53023          	sd	a5,0(a0)
    8000160c:	00053423          	sd	zero,8(a0)
    80001610:	00053823          	sd	zero,16(a0)
    80001614:	00053c23          	sd	zero,24(a0)
    finished = false;
    80001618:	02050c23          	sb	zero,56(a0)
    main = main_;
    8000161c:	02b53823          	sd	a1,48(a0)
    timeSlice = timeSlice_;
    80001620:	04c53423          	sd	a2,72(a0)
    mainArguments = mainArguments_;
    80001624:	04d53023          	sd	a3,64(a0)
    stack = sysStack = nullptr; // stek pravimo u sistemskom pozivu thread_create (koja takodje poziva sistemski poziv)
    80001628:	02053423          	sd	zero,40(a0)
    8000162c:	02053023          	sd	zero,32(a0)
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    80001630:	02058663          	beqz	a1,8000165c <_ZN3PCBC1EPFvvEmPv+0x5c>
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_)
    80001634:	ff010113          	addi	sp,sp,-16
    80001638:	00113423          	sd	ra,8(sp)
    8000163c:	00813023          	sd	s0,0(sp)
    80001640:	01010413          	addi	s0,sp,16
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    80001644:	00000097          	auipc	ra,0x0
    80001648:	128080e7          	jalr	296(ra) # 8000176c <_ZN9Scheduler3putEP3PCB>
}
    8000164c:	00813083          	ld	ra,8(sp)
    80001650:	00013403          	ld	s0,0(sp)
    80001654:	01010113          	addi	sp,sp,16
    80001658:	00008067          	ret
    8000165c:	00008067          	ret

0000000080001660 <_ZN3PCBD1Ev>:
    delete[] stack;
    80001660:	02053503          	ld	a0,32(a0)
    80001664:	02050663          	beqz	a0,80001690 <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    80001668:	ff010113          	addi	sp,sp,-16
    8000166c:	00113423          	sd	ra,8(sp)
    80001670:	00813023          	sd	s0,0(sp)
    80001674:	01010413          	addi	s0,sp,16
    delete[] stack;
    80001678:	00000097          	auipc	ra,0x0
    8000167c:	408080e7          	jalr	1032(ra) # 80001a80 <_ZdaPv>
}
    80001680:	00813083          	ld	ra,8(sp)
    80001684:	00013403          	ld	s0,0(sp)
    80001688:	01010113          	addi	sp,sp,16
    8000168c:	00008067          	ret
    80001690:	00008067          	ret

0000000080001694 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001694:	ff010113          	addi	sp,sp,-16
    80001698:	00113423          	sd	ra,8(sp)
    8000169c:	00813023          	sd	s0,0(sp)
    800016a0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	404080e7          	jalr	1028(ra) # 80001aa8 <_ZN15MemoryAllocator9mem_allocEm>
}
    800016ac:	00813083          	ld	ra,8(sp)
    800016b0:	00013403          	ld	s0,0(sp)
    800016b4:	01010113          	addi	sp,sp,16
    800016b8:	00008067          	ret

00000000800016bc <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    800016bc:	ff010113          	addi	sp,sp,-16
    800016c0:	00113423          	sd	ra,8(sp)
    800016c4:	00813023          	sd	s0,0(sp)
    800016c8:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800016cc:	00000097          	auipc	ra,0x0
    800016d0:	540080e7          	jalr	1344(ra) # 80001c0c <_ZN15MemoryAllocator8mem_freeEPv>
}
    800016d4:	00813083          	ld	ra,8(sp)
    800016d8:	00013403          	ld	s0,0(sp)
    800016dc:	01010113          	addi	sp,sp,16
    800016e0:	00008067          	ret

00000000800016e4 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    800016e4:	fd010113          	addi	sp,sp,-48
    800016e8:	02113423          	sd	ra,40(sp)
    800016ec:	02813023          	sd	s0,32(sp)
    800016f0:	00913c23          	sd	s1,24(sp)
    800016f4:	01213823          	sd	s2,16(sp)
    800016f8:	01313423          	sd	s3,8(sp)
    800016fc:	03010413          	addi	s0,sp,48
    80001700:	00050913          	mv	s2,a0
    80001704:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001708:	05000513          	li	a0,80
    8000170c:	00000097          	auipc	ra,0x0
    80001710:	f88080e7          	jalr	-120(ra) # 80001694 <_ZN3PCBnwEm>
    80001714:	00050493          	mv	s1,a0
    80001718:	00098693          	mv	a3,s3
    8000171c:	00200613          	li	a2,2
    80001720:	00090593          	mv	a1,s2
    80001724:	00000097          	auipc	ra,0x0
    80001728:	edc080e7          	jalr	-292(ra) # 80001600 <_ZN3PCBC1EPFvvEmPv>
    8000172c:	0200006f          	j	8000174c <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001730:	00050913          	mv	s2,a0
    80001734:	00048513          	mv	a0,s1
    80001738:	00000097          	auipc	ra,0x0
    8000173c:	f84080e7          	jalr	-124(ra) # 800016bc <_ZN3PCBdlEPv>
    80001740:	00090513          	mv	a0,s2
    80001744:	00005097          	auipc	ra,0x5
    80001748:	1d4080e7          	jalr	468(ra) # 80006918 <_Unwind_Resume>
}
    8000174c:	00048513          	mv	a0,s1
    80001750:	02813083          	ld	ra,40(sp)
    80001754:	02013403          	ld	s0,32(sp)
    80001758:	01813483          	ld	s1,24(sp)
    8000175c:	01013903          	ld	s2,16(sp)
    80001760:	00813983          	ld	s3,8(sp)
    80001764:	03010113          	addi	sp,sp,48
    80001768:	00008067          	ret

000000008000176c <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    8000176c:	ff010113          	addi	sp,sp,-16
    80001770:	00813423          	sd	s0,8(sp)
    80001774:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    80001778:	00053c23          	sd	zero,24(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    8000177c:	00004797          	auipc	a5,0x4
    80001780:	0b47b783          	ld	a5,180(a5) # 80005830 <_ZN9Scheduler4tailE>
    80001784:	00078e63          	beqz	a5,800017a0 <_ZN9Scheduler3putEP3PCB+0x34>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    80001788:	00a7bc23          	sd	a0,24(a5)
        tail = tail->nextReady;
    8000178c:	00004797          	auipc	a5,0x4
    80001790:	0aa7b223          	sd	a0,164(a5) # 80005830 <_ZN9Scheduler4tailE>
    }
}
    80001794:	00813403          	ld	s0,8(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret
        head = tail = process;
    800017a0:	00004797          	auipc	a5,0x4
    800017a4:	09078793          	addi	a5,a5,144 # 80005830 <_ZN9Scheduler4tailE>
    800017a8:	00a7b023          	sd	a0,0(a5)
    800017ac:	00a7b423          	sd	a0,8(a5)
    800017b0:	fe5ff06f          	j	80001794 <_ZN9Scheduler3putEP3PCB+0x28>

00000000800017b4 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800017b4:	ff010113          	addi	sp,sp,-16
    800017b8:	00813423          	sd	s0,8(sp)
    800017bc:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800017c0:	00004517          	auipc	a0,0x4
    800017c4:	07853503          	ld	a0,120(a0) # 80005838 <_ZN9Scheduler4headE>
    800017c8:	02050463          	beqz	a0,800017f0 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    800017cc:	01853703          	ld	a4,24(a0)
    800017d0:	00004797          	auipc	a5,0x4
    800017d4:	06078793          	addi	a5,a5,96 # 80005830 <_ZN9Scheduler4tailE>
    800017d8:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800017dc:	0007b783          	ld	a5,0(a5)
    800017e0:	00f50e63          	beq	a0,a5,800017fc <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    800017e4:	00813403          	ld	s0,8(sp)
    800017e8:	01010113          	addi	sp,sp,16
    800017ec:	00008067          	ret
        return idleProcess;
    800017f0:	00004517          	auipc	a0,0x4
    800017f4:	05053503          	ld	a0,80(a0) # 80005840 <_ZN9Scheduler11idleProcessE>
    800017f8:	fedff06f          	j	800017e4 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    800017fc:	00004797          	auipc	a5,0x4
    80001800:	02e7ba23          	sd	a4,52(a5) # 80005830 <_ZN9Scheduler4tailE>
    80001804:	fe1ff06f          	j	800017e4 <_ZN9Scheduler3getEv+0x30>

0000000080001808 <_Z4nitAPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"
#include "../h/PCB.h"
#include "../h/kernel.h"

void nitA(void* x) {
    80001808:	fe010113          	addi	sp,sp,-32
    8000180c:	00113c23          	sd	ra,24(sp)
    80001810:	00813823          	sd	s0,16(sp)
    80001814:	00913423          	sd	s1,8(sp)
    80001818:	02010413          	addi	s0,sp,32
    8000181c:	00050493          	mv	s1,a0
    printString("nit A\n");
    80001820:	00004517          	auipc	a0,0x4
    80001824:	80050513          	addi	a0,a0,-2048 # 80005020 <CONSOLE_STATUS+0x10>
    80001828:	00000097          	auipc	ra,0x0
    8000182c:	590080e7          	jalr	1424(ra) # 80001db8 <_Z11printStringPKc>
    PCB::yield();
    80001830:	00000097          	auipc	ra,0x0
    80001834:	ce4080e7          	jalr	-796(ra) # 80001514 <_ZN3PCB5yieldEv>
    for(int i = 0; i < 30000; i++) {
    80001838:	00000693          	li	a3,0
    8000183c:	0080006f          	j	80001844 <_Z4nitAPv+0x3c>
    80001840:	0016869b          	addiw	a3,a3,1
    80001844:	000077b7          	lui	a5,0x7
    80001848:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000184c:	00d7ce63          	blt	a5,a3,80001868 <_Z4nitAPv+0x60>
        for(int j = 0; j < 10000; j++) {
    80001850:	00000713          	li	a4,0
    80001854:	000027b7          	lui	a5,0x2
    80001858:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000185c:	fee7c2e3          	blt	a5,a4,80001840 <_Z4nitAPv+0x38>
    80001860:	0017071b          	addiw	a4,a4,1
    80001864:	ff1ff06f          	j	80001854 <_Z4nitAPv+0x4c>
            // uposleno cekanje
        }
    }

    printInteger(*(int*)x);
    80001868:	0004a503          	lw	a0,0(s1)
    8000186c:	00000097          	auipc	ra,0x0
    80001870:	5bc080e7          	jalr	1468(ra) # 80001e28 <_Z12printIntegerm>
    printString("\nKraj niti A\n");
    80001874:	00003517          	auipc	a0,0x3
    80001878:	7b450513          	addi	a0,a0,1972 # 80005028 <CONSOLE_STATUS+0x18>
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	53c080e7          	jalr	1340(ra) # 80001db8 <_Z11printStringPKc>
}
    80001884:	01813083          	ld	ra,24(sp)
    80001888:	01013403          	ld	s0,16(sp)
    8000188c:	00813483          	ld	s1,8(sp)
    80001890:	02010113          	addi	sp,sp,32
    80001894:	00008067          	ret

0000000080001898 <_Z4nitBPv>:

void nitB(void* c) {
    80001898:	fe010113          	addi	sp,sp,-32
    8000189c:	00113c23          	sd	ra,24(sp)
    800018a0:	00813823          	sd	s0,16(sp)
    800018a4:	00913423          	sd	s1,8(sp)
    800018a8:	02010413          	addi	s0,sp,32
    800018ac:	00050493          	mv	s1,a0
    printString("nit B\n");
    800018b0:	00003517          	auipc	a0,0x3
    800018b4:	78850513          	addi	a0,a0,1928 # 80005038 <CONSOLE_STATUS+0x28>
    800018b8:	00000097          	auipc	ra,0x0
    800018bc:	500080e7          	jalr	1280(ra) # 80001db8 <_Z11printStringPKc>
    __putc(*(char*)c);
    800018c0:	0004c503          	lbu	a0,0(s1)
    800018c4:	00002097          	auipc	ra,0x2
    800018c8:	768080e7          	jalr	1896(ra) # 8000402c <__putc>
    __putc('\n');
    800018cc:	00a00513          	li	a0,10
    800018d0:	00002097          	auipc	ra,0x2
    800018d4:	75c080e7          	jalr	1884(ra) # 8000402c <__putc>
}
    800018d8:	01813083          	ld	ra,24(sp)
    800018dc:	01013403          	ld	s0,16(sp)
    800018e0:	00813483          	ld	s1,8(sp)
    800018e4:	02010113          	addi	sp,sp,32
    800018e8:	00008067          	ret

00000000800018ec <main>:
extern "C" void interrupt();
int main() {
    800018ec:	fb010113          	addi	sp,sp,-80
    800018f0:	04113423          	sd	ra,72(sp)
    800018f4:	04813023          	sd	s0,64(sp)
    800018f8:	02913c23          	sd	s1,56(sp)
    800018fc:	03213823          	sd	s2,48(sp)
    80001900:	05010413          	addi	s0,sp,80
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001904:	00004797          	auipc	a5,0x4
    80001908:	ed47b783          	ld	a5,-300(a5) # 800057d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000190c:	10579073          	csrw	stvec,a5

    thread_t procesi[5];
    procesi[0] = PCB::createProccess(nullptr, nullptr); // main
    80001910:	00000593          	li	a1,0
    80001914:	00000513          	li	a0,0
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	dcc080e7          	jalr	-564(ra) # 800016e4 <_ZN3PCB14createProccessEPFvvEPv>
    80001920:	faa43c23          	sd	a0,-72(s0)
    PCB::running = procesi[0];
    80001924:	00004797          	auipc	a5,0x4
    80001928:	ea47b783          	ld	a5,-348(a5) # 800057c8 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000192c:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001930:	00200793          	li	a5,2
    80001934:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    using pFunc = void(*)(void*);
    int x = 11;
    80001938:	00b00793          	li	a5,11
    8000193c:	faf42a23          	sw	a5,-76(s0)
    char c = 'k';
    80001940:	06b00793          	li	a5,107
    80001944:	faf409a3          	sb	a5,-77(s0)
    thread_create(&procesi[1], (pFunc)nitA, &x);
    80001948:	fb440613          	addi	a2,s0,-76
    8000194c:	00000597          	auipc	a1,0x0
    80001950:	ebc58593          	addi	a1,a1,-324 # 80001808 <_Z4nitAPv>
    80001954:	fc040513          	addi	a0,s0,-64
    80001958:	00000097          	auipc	ra,0x0
    8000195c:	964080e7          	jalr	-1692(ra) # 800012bc <_Z13thread_createPP3PCBPFvPvES2_>
    __putc('A');
    80001960:	04100513          	li	a0,65
    80001964:	00002097          	auipc	ra,0x2
    80001968:	6c8080e7          	jalr	1736(ra) # 8000402c <__putc>
    thread_create(&procesi[2], (pFunc)nitB, &c);
    8000196c:	fb340613          	addi	a2,s0,-77
    80001970:	00000597          	auipc	a1,0x0
    80001974:	f2858593          	addi	a1,a1,-216 # 80001898 <_Z4nitBPv>
    80001978:	fc840513          	addi	a0,s0,-56
    8000197c:	00000097          	auipc	ra,0x0
    80001980:	940080e7          	jalr	-1728(ra) # 800012bc <_Z13thread_createPP3PCBPFvPvES2_>
    __putc('B');
    80001984:	04200513          	li	a0,66
    80001988:	00002097          	auipc	ra,0x2
    8000198c:	6a4080e7          	jalr	1700(ra) # 8000402c <__putc>
    80001990:	00c0006f          	j	8000199c <main+0xb0>

    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
        PCB::yield();
    80001994:	00000097          	auipc	ra,0x0
    80001998:	b80080e7          	jalr	-1152(ra) # 80001514 <_ZN3PCB5yieldEv>
    while(!procesi[1]->isFinished() || !procesi[2]->isFinished()) {
    8000199c:	fc043783          	ld	a5,-64(s0)
        return finished;
    800019a0:	0387c783          	lbu	a5,56(a5)
    800019a4:	fe0788e3          	beqz	a5,80001994 <main+0xa8>
    800019a8:	fc843783          	ld	a5,-56(s0)
    800019ac:	0387c783          	lbu	a5,56(a5)
    800019b0:	fe0782e3          	beqz	a5,80001994 <main+0xa8>
    800019b4:	fb840493          	addi	s1,s0,-72
    800019b8:	0080006f          	j	800019c0 <main+0xd4>
    }

    for(auto &proces : procesi) {
    800019bc:	00848493          	addi	s1,s1,8
    800019c0:	fe040793          	addi	a5,s0,-32
    800019c4:	02f48463          	beq	s1,a5,800019ec <main+0x100>
        delete proces;
    800019c8:	0004b903          	ld	s2,0(s1)
    800019cc:	fe0908e3          	beqz	s2,800019bc <main+0xd0>
    800019d0:	00090513          	mv	a0,s2
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	c8c080e7          	jalr	-884(ra) # 80001660 <_ZN3PCBD1Ev>
    800019dc:	00090513          	mv	a0,s2
    800019e0:	00000097          	auipc	ra,0x0
    800019e4:	cdc080e7          	jalr	-804(ra) # 800016bc <_ZN3PCBdlEPv>
    800019e8:	fd5ff06f          	j	800019bc <main+0xd0>
    }

    return 0;
}
    800019ec:	00000513          	li	a0,0
    800019f0:	04813083          	ld	ra,72(sp)
    800019f4:	04013403          	ld	s0,64(sp)
    800019f8:	03813483          	ld	s1,56(sp)
    800019fc:	03013903          	ld	s2,48(sp)
    80001a00:	05010113          	addi	sp,sp,80
    80001a04:	00008067          	ret

0000000080001a08 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001a08:	ff010113          	addi	sp,sp,-16
    80001a0c:	00113423          	sd	ra,8(sp)
    80001a10:	00813023          	sd	s0,0(sp)
    80001a14:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001a18:	00000097          	auipc	ra,0x0
    80001a1c:	828080e7          	jalr	-2008(ra) # 80001240 <_Z9mem_allocm>
}
    80001a20:	00813083          	ld	ra,8(sp)
    80001a24:	00013403          	ld	s0,0(sp)
    80001a28:	01010113          	addi	sp,sp,16
    80001a2c:	00008067          	ret

0000000080001a30 <_Znam>:
void* operator new [](size_t size) {
    80001a30:	ff010113          	addi	sp,sp,-16
    80001a34:	00113423          	sd	ra,8(sp)
    80001a38:	00813023          	sd	s0,0(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	800080e7          	jalr	-2048(ra) # 80001240 <_Z9mem_allocm>
}
    80001a48:	00813083          	ld	ra,8(sp)
    80001a4c:	00013403          	ld	s0,0(sp)
    80001a50:	01010113          	addi	sp,sp,16
    80001a54:	00008067          	ret

0000000080001a58 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001a58:	ff010113          	addi	sp,sp,-16
    80001a5c:	00113423          	sd	ra,8(sp)
    80001a60:	00813023          	sd	s0,0(sp)
    80001a64:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	81c080e7          	jalr	-2020(ra) # 80001284 <_Z8mem_freePv>
}
    80001a70:	00813083          	ld	ra,8(sp)
    80001a74:	00013403          	ld	s0,0(sp)
    80001a78:	01010113          	addi	sp,sp,16
    80001a7c:	00008067          	ret

0000000080001a80 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001a80:	ff010113          	addi	sp,sp,-16
    80001a84:	00113423          	sd	ra,8(sp)
    80001a88:	00813023          	sd	s0,0(sp)
    80001a8c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001a90:	fffff097          	auipc	ra,0xfffff
    80001a94:	7f4080e7          	jalr	2036(ra) # 80001284 <_Z8mem_freePv>
    80001a98:	00813083          	ld	ra,8(sp)
    80001a9c:	00013403          	ld	s0,0(sp)
    80001aa0:	01010113          	addi	sp,sp,16
    80001aa4:	00008067          	ret

0000000080001aa8 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001aa8:	ff010113          	addi	sp,sp,-16
    80001aac:	00813423          	sd	s0,8(sp)
    80001ab0:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001ab4:	00004797          	auipc	a5,0x4
    80001ab8:	d947b783          	ld	a5,-620(a5) # 80005848 <_ZN15MemoryAllocator4headE>
    80001abc:	02078c63          	beqz	a5,80001af4 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001ac0:	00004717          	auipc	a4,0x4
    80001ac4:	d1073703          	ld	a4,-752(a4) # 800057d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001ac8:	00073703          	ld	a4,0(a4)
    80001acc:	12e78c63          	beq	a5,a4,80001c04 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001ad0:	00850713          	addi	a4,a0,8
    80001ad4:	00675813          	srli	a6,a4,0x6
    80001ad8:	03f77793          	andi	a5,a4,63
    80001adc:	00f037b3          	snez	a5,a5
    80001ae0:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001ae4:	00004517          	auipc	a0,0x4
    80001ae8:	d6453503          	ld	a0,-668(a0) # 80005848 <_ZN15MemoryAllocator4headE>
    80001aec:	00000613          	li	a2,0
    80001af0:	0a80006f          	j	80001b98 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001af4:	00004697          	auipc	a3,0x4
    80001af8:	cbc6b683          	ld	a3,-836(a3) # 800057b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001afc:	0006b783          	ld	a5,0(a3)
    80001b00:	00004717          	auipc	a4,0x4
    80001b04:	d4f73423          	sd	a5,-696(a4) # 80005848 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001b08:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80001b0c:	00004717          	auipc	a4,0x4
    80001b10:	cc473703          	ld	a4,-828(a4) # 800057d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001b14:	00073703          	ld	a4,0(a4)
    80001b18:	0006b683          	ld	a3,0(a3)
    80001b1c:	40d70733          	sub	a4,a4,a3
    80001b20:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001b24:	0007b823          	sd	zero,16(a5)
    80001b28:	fa9ff06f          	j	80001ad0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001b2c:	00060e63          	beqz	a2,80001b48 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001b30:	01063703          	ld	a4,16(a2)
    80001b34:	04070a63          	beqz	a4,80001b88 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001b38:	01073703          	ld	a4,16(a4)
    80001b3c:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80001b40:	00078813          	mv	a6,a5
    80001b44:	0ac0006f          	j	80001bf0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001b48:	01053703          	ld	a4,16(a0)
    80001b4c:	00070a63          	beqz	a4,80001b60 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001b50:	00004697          	auipc	a3,0x4
    80001b54:	cee6bc23          	sd	a4,-776(a3) # 80005848 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001b58:	00078813          	mv	a6,a5
    80001b5c:	0940006f          	j	80001bf0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001b60:	00004717          	auipc	a4,0x4
    80001b64:	c7073703          	ld	a4,-912(a4) # 800057d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001b68:	00073703          	ld	a4,0(a4)
    80001b6c:	00004697          	auipc	a3,0x4
    80001b70:	cce6be23          	sd	a4,-804(a3) # 80005848 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001b74:	00078813          	mv	a6,a5
    80001b78:	0780006f          	j	80001bf0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001b7c:	00004797          	auipc	a5,0x4
    80001b80:	cce7b623          	sd	a4,-820(a5) # 80005848 <_ZN15MemoryAllocator4headE>
    80001b84:	06c0006f          	j	80001bf0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001b88:	00078813          	mv	a6,a5
    80001b8c:	0640006f          	j	80001bf0 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001b90:	00050613          	mv	a2,a0
        curr = curr->next;
    80001b94:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001b98:	06050063          	beqz	a0,80001bf8 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80001b9c:	00853783          	ld	a5,8(a0)
    80001ba0:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80001ba4:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001ba8:	fee7e4e3          	bltu	a5,a4,80001b90 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001bac:	ff06e2e3          	bltu	a3,a6,80001b90 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001bb0:	f7068ee3          	beq	a3,a6,80001b2c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001bb4:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001bb8:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80001bbc:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001bc0:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001bc4:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001bc8:	01053783          	ld	a5,16(a0)
    80001bcc:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001bd0:	fa0606e3          	beqz	a2,80001b7c <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001bd4:	01063783          	ld	a5,16(a2)
    80001bd8:	00078663          	beqz	a5,80001be4 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80001bdc:	0107b783          	ld	a5,16(a5)
    80001be0:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80001be4:	01063783          	ld	a5,16(a2)
    80001be8:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001bec:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001bf0:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001bf4:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001bf8:	00813403          	ld	s0,8(sp)
    80001bfc:	01010113          	addi	sp,sp,16
    80001c00:	00008067          	ret
        return nullptr;
    80001c04:	00000513          	li	a0,0
    80001c08:	ff1ff06f          	j	80001bf8 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080001c0c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001c0c:	ff010113          	addi	sp,sp,-16
    80001c10:	00813423          	sd	s0,8(sp)
    80001c14:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001c18:	16050063          	beqz	a0,80001d78 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001c1c:	ff850713          	addi	a4,a0,-8
    80001c20:	00004797          	auipc	a5,0x4
    80001c24:	b907b783          	ld	a5,-1136(a5) # 800057b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001c28:	0007b783          	ld	a5,0(a5)
    80001c2c:	14f76a63          	bltu	a4,a5,80001d80 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001c30:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001c34:	fff58693          	addi	a3,a1,-1
    80001c38:	00d706b3          	add	a3,a4,a3
    80001c3c:	00004617          	auipc	a2,0x4
    80001c40:	b9463603          	ld	a2,-1132(a2) # 800057d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001c44:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001c48:	14c6f063          	bgeu	a3,a2,80001d88 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001c4c:	14070263          	beqz	a4,80001d90 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001c50:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001c54:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001c58:	14079063          	bnez	a5,80001d98 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001c5c:	03f00793          	li	a5,63
    80001c60:	14b7f063          	bgeu	a5,a1,80001da0 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001c64:	00004797          	auipc	a5,0x4
    80001c68:	be47b783          	ld	a5,-1052(a5) # 80005848 <_ZN15MemoryAllocator4headE>
    80001c6c:	02f60063          	beq	a2,a5,80001c8c <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001c70:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001c74:	02078a63          	beqz	a5,80001ca8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001c78:	0007b683          	ld	a3,0(a5)
    80001c7c:	02e6f663          	bgeu	a3,a4,80001ca8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001c80:	00078613          	mv	a2,a5
        curr = curr->next;
    80001c84:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001c88:	fedff06f          	j	80001c74 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001c8c:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001c90:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001c94:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80001c98:	00004797          	auipc	a5,0x4
    80001c9c:	bae7b823          	sd	a4,-1104(a5) # 80005848 <_ZN15MemoryAllocator4headE>
        return 0;
    80001ca0:	00000513          	li	a0,0
    80001ca4:	0480006f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001ca8:	04060863          	beqz	a2,80001cf8 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001cac:	00063683          	ld	a3,0(a2)
    80001cb0:	00863803          	ld	a6,8(a2)
    80001cb4:	010686b3          	add	a3,a3,a6
    80001cb8:	08e68a63          	beq	a3,a4,80001d4c <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80001cbc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001cc0:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001cc4:	01063683          	ld	a3,16(a2)
    80001cc8:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80001ccc:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001cd0:	0e078063          	beqz	a5,80001db0 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001cd4:	0007b583          	ld	a1,0(a5)
    80001cd8:	00073683          	ld	a3,0(a4)
    80001cdc:	00873603          	ld	a2,8(a4)
    80001ce0:	00c686b3          	add	a3,a3,a2
    80001ce4:	06d58c63          	beq	a1,a3,80001d5c <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80001ce8:	00000513          	li	a0,0
}
    80001cec:	00813403          	ld	s0,8(sp)
    80001cf0:	01010113          	addi	sp,sp,16
    80001cf4:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80001cf8:	0a078863          	beqz	a5,80001da8 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80001cfc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001d00:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80001d04:	00004797          	auipc	a5,0x4
    80001d08:	b447b783          	ld	a5,-1212(a5) # 80005848 <_ZN15MemoryAllocator4headE>
    80001d0c:	0007b603          	ld	a2,0(a5)
    80001d10:	00b706b3          	add	a3,a4,a1
    80001d14:	00d60c63          	beq	a2,a3,80001d2c <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80001d18:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001d1c:	00004797          	auipc	a5,0x4
    80001d20:	b2e7b623          	sd	a4,-1236(a5) # 80005848 <_ZN15MemoryAllocator4headE>
            return 0;
    80001d24:	00000513          	li	a0,0
    80001d28:	fc5ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001d2c:	0087b783          	ld	a5,8(a5)
    80001d30:	00b785b3          	add	a1,a5,a1
    80001d34:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80001d38:	00004797          	auipc	a5,0x4
    80001d3c:	b107b783          	ld	a5,-1264(a5) # 80005848 <_ZN15MemoryAllocator4headE>
    80001d40:	0107b783          	ld	a5,16(a5)
    80001d44:	00f53423          	sd	a5,8(a0)
    80001d48:	fd5ff06f          	j	80001d1c <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001d4c:	00b805b3          	add	a1,a6,a1
    80001d50:	00b63423          	sd	a1,8(a2)
    80001d54:	00060713          	mv	a4,a2
    80001d58:	f79ff06f          	j	80001cd0 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001d5c:	0087b683          	ld	a3,8(a5)
    80001d60:	00d60633          	add	a2,a2,a3
    80001d64:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80001d68:	0107b783          	ld	a5,16(a5)
    80001d6c:	00f73823          	sd	a5,16(a4)
    return 0;
    80001d70:	00000513          	li	a0,0
    80001d74:	f79ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001d78:	fff00513          	li	a0,-1
    80001d7c:	f71ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001d80:	fff00513          	li	a0,-1
    80001d84:	f69ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80001d88:	fff00513          	li	a0,-1
    80001d8c:	f61ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001d90:	fff00513          	li	a0,-1
    80001d94:	f59ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001d98:	fff00513          	li	a0,-1
    80001d9c:	f51ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001da0:	fff00513          	li	a0,-1
    80001da4:	f49ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80001da8:	fff00513          	li	a0,-1
    80001dac:	f41ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001db0:	00000513          	li	a0,0
    80001db4:	f39ff06f          	j	80001cec <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080001db8 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    80001db8:	fd010113          	addi	sp,sp,-48
    80001dbc:	02113423          	sd	ra,40(sp)
    80001dc0:	02813023          	sd	s0,32(sp)
    80001dc4:	00913c23          	sd	s1,24(sp)
    80001dc8:	01213823          	sd	s2,16(sp)
    80001dcc:	03010413          	addi	s0,sp,48
    80001dd0:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001dd4:	100027f3          	csrr	a5,sstatus
    80001dd8:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    80001ddc:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001de0:	00200793          	li	a5,2
    80001de4:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    80001de8:	0004c503          	lbu	a0,0(s1)
    80001dec:	00050a63          	beqz	a0,80001e00 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    80001df0:	00002097          	auipc	ra,0x2
    80001df4:	23c080e7          	jalr	572(ra) # 8000402c <__putc>
        string++;
    80001df8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001dfc:	fedff06f          	j	80001de8 <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80001e00:	0009091b          	sext.w	s2,s2
    80001e04:	00297913          	andi	s2,s2,2
    80001e08:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001e0c:	10092073          	csrs	sstatus,s2
}
    80001e10:	02813083          	ld	ra,40(sp)
    80001e14:	02013403          	ld	s0,32(sp)
    80001e18:	01813483          	ld	s1,24(sp)
    80001e1c:	01013903          	ld	s2,16(sp)
    80001e20:	03010113          	addi	sp,sp,48
    80001e24:	00008067          	ret

0000000080001e28 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    80001e28:	fc010113          	addi	sp,sp,-64
    80001e2c:	02113c23          	sd	ra,56(sp)
    80001e30:	02813823          	sd	s0,48(sp)
    80001e34:	02913423          	sd	s1,40(sp)
    80001e38:	03213023          	sd	s2,32(sp)
    80001e3c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001e40:	100027f3          	csrr	a5,sstatus
    80001e44:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    80001e48:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001e4c:	00200793          	li	a5,2
    80001e50:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80001e54:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001e58:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001e5c:	00a00613          	li	a2,10
    80001e60:	02c5773b          	remuw	a4,a0,a2
    80001e64:	02071693          	slli	a3,a4,0x20
    80001e68:	0206d693          	srli	a3,a3,0x20
    80001e6c:	00003717          	auipc	a4,0x3
    80001e70:	1fc70713          	addi	a4,a4,508 # 80005068 <_ZZ12printIntegermE6digits>
    80001e74:	00d70733          	add	a4,a4,a3
    80001e78:	00074703          	lbu	a4,0(a4)
    80001e7c:	fe040693          	addi	a3,s0,-32
    80001e80:	009687b3          	add	a5,a3,s1
    80001e84:	0014849b          	addiw	s1,s1,1
    80001e88:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001e8c:	0005071b          	sext.w	a4,a0
    80001e90:	02c5553b          	divuw	a0,a0,a2
    80001e94:	00900793          	li	a5,9
    80001e98:	fce7e2e3          	bltu	a5,a4,80001e5c <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80001e9c:	fff4849b          	addiw	s1,s1,-1
    80001ea0:	0004ce63          	bltz	s1,80001ebc <_Z12printIntegerm+0x94>
    80001ea4:	fe040793          	addi	a5,s0,-32
    80001ea8:	009787b3          	add	a5,a5,s1
    80001eac:	ff07c503          	lbu	a0,-16(a5)
    80001eb0:	00002097          	auipc	ra,0x2
    80001eb4:	17c080e7          	jalr	380(ra) # 8000402c <__putc>
    80001eb8:	fe5ff06f          	j	80001e9c <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80001ebc:	0009091b          	sext.w	s2,s2
    80001ec0:	00297913          	andi	s2,s2,2
    80001ec4:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001ec8:	10092073          	csrs	sstatus,s2
}
    80001ecc:	03813083          	ld	ra,56(sp)
    80001ed0:	03013403          	ld	s0,48(sp)
    80001ed4:	02813483          	ld	s1,40(sp)
    80001ed8:	02013903          	ld	s2,32(sp)
    80001edc:	04010113          	addi	sp,sp,64
    80001ee0:	00008067          	ret

0000000080001ee4 <_Z10printErrorv>:
void printError() {
    80001ee4:	fd010113          	addi	sp,sp,-48
    80001ee8:	02113423          	sd	ra,40(sp)
    80001eec:	02813023          	sd	s0,32(sp)
    80001ef0:	03010413          	addi	s0,sp,48
    printString("scause: ");
    80001ef4:	00003517          	auipc	a0,0x3
    80001ef8:	14c50513          	addi	a0,a0,332 # 80005040 <CONSOLE_STATUS+0x30>
    80001efc:	00000097          	auipc	ra,0x0
    80001f00:	ebc080e7          	jalr	-324(ra) # 80001db8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001f04:	142027f3          	csrr	a5,scause
    80001f08:	fef43423          	sd	a5,-24(s0)
        return scause;
    80001f0c:	fe843503          	ld	a0,-24(s0)
    printInteger(Kernel::r_scause());
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	f18080e7          	jalr	-232(ra) # 80001e28 <_Z12printIntegerm>
    printString("\nsepc: ");
    80001f18:	00003517          	auipc	a0,0x3
    80001f1c:	13850513          	addi	a0,a0,312 # 80005050 <CONSOLE_STATUS+0x40>
    80001f20:	00000097          	auipc	ra,0x0
    80001f24:	e98080e7          	jalr	-360(ra) # 80001db8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001f28:	141027f3          	csrr	a5,sepc
    80001f2c:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80001f30:	fe043503          	ld	a0,-32(s0)
    printInteger(Kernel::r_sepc());
    80001f34:	00000097          	auipc	ra,0x0
    80001f38:	ef4080e7          	jalr	-268(ra) # 80001e28 <_Z12printIntegerm>
    printString("\nstval: ");
    80001f3c:	00003517          	auipc	a0,0x3
    80001f40:	11c50513          	addi	a0,a0,284 # 80005058 <CONSOLE_STATUS+0x48>
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	e74080e7          	jalr	-396(ra) # 80001db8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80001f4c:	143027f3          	csrr	a5,stval
    80001f50:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    80001f54:	fd843503          	ld	a0,-40(s0)
    printInteger(Kernel::r_stval());
    80001f58:	00000097          	auipc	ra,0x0
    80001f5c:	ed0080e7          	jalr	-304(ra) # 80001e28 <_Z12printIntegerm>
    80001f60:	02813083          	ld	ra,40(sp)
    80001f64:	02013403          	ld	s0,32(sp)
    80001f68:	03010113          	addi	sp,sp,48
    80001f6c:	00008067          	ret

0000000080001f70 <start>:
    80001f70:	ff010113          	addi	sp,sp,-16
    80001f74:	00813423          	sd	s0,8(sp)
    80001f78:	01010413          	addi	s0,sp,16
    80001f7c:	300027f3          	csrr	a5,mstatus
    80001f80:	ffffe737          	lui	a4,0xffffe
    80001f84:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7d4f>
    80001f88:	00e7f7b3          	and	a5,a5,a4
    80001f8c:	00001737          	lui	a4,0x1
    80001f90:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001f94:	00e7e7b3          	or	a5,a5,a4
    80001f98:	30079073          	csrw	mstatus,a5
    80001f9c:	00000797          	auipc	a5,0x0
    80001fa0:	16078793          	addi	a5,a5,352 # 800020fc <system_main>
    80001fa4:	34179073          	csrw	mepc,a5
    80001fa8:	00000793          	li	a5,0
    80001fac:	18079073          	csrw	satp,a5
    80001fb0:	000107b7          	lui	a5,0x10
    80001fb4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001fb8:	30279073          	csrw	medeleg,a5
    80001fbc:	30379073          	csrw	mideleg,a5
    80001fc0:	104027f3          	csrr	a5,sie
    80001fc4:	2227e793          	ori	a5,a5,546
    80001fc8:	10479073          	csrw	sie,a5
    80001fcc:	fff00793          	li	a5,-1
    80001fd0:	00a7d793          	srli	a5,a5,0xa
    80001fd4:	3b079073          	csrw	pmpaddr0,a5
    80001fd8:	00f00793          	li	a5,15
    80001fdc:	3a079073          	csrw	pmpcfg0,a5
    80001fe0:	f14027f3          	csrr	a5,mhartid
    80001fe4:	0200c737          	lui	a4,0x200c
    80001fe8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001fec:	0007869b          	sext.w	a3,a5
    80001ff0:	00269713          	slli	a4,a3,0x2
    80001ff4:	000f4637          	lui	a2,0xf4
    80001ff8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001ffc:	00d70733          	add	a4,a4,a3
    80002000:	0037979b          	slliw	a5,a5,0x3
    80002004:	020046b7          	lui	a3,0x2004
    80002008:	00d787b3          	add	a5,a5,a3
    8000200c:	00c585b3          	add	a1,a1,a2
    80002010:	00371693          	slli	a3,a4,0x3
    80002014:	00004717          	auipc	a4,0x4
    80002018:	83c70713          	addi	a4,a4,-1988 # 80005850 <timer_scratch>
    8000201c:	00b7b023          	sd	a1,0(a5)
    80002020:	00d70733          	add	a4,a4,a3
    80002024:	00f73c23          	sd	a5,24(a4)
    80002028:	02c73023          	sd	a2,32(a4)
    8000202c:	34071073          	csrw	mscratch,a4
    80002030:	00000797          	auipc	a5,0x0
    80002034:	6e078793          	addi	a5,a5,1760 # 80002710 <timervec>
    80002038:	30579073          	csrw	mtvec,a5
    8000203c:	300027f3          	csrr	a5,mstatus
    80002040:	0087e793          	ori	a5,a5,8
    80002044:	30079073          	csrw	mstatus,a5
    80002048:	304027f3          	csrr	a5,mie
    8000204c:	0807e793          	ori	a5,a5,128
    80002050:	30479073          	csrw	mie,a5
    80002054:	f14027f3          	csrr	a5,mhartid
    80002058:	0007879b          	sext.w	a5,a5
    8000205c:	00078213          	mv	tp,a5
    80002060:	30200073          	mret
    80002064:	00813403          	ld	s0,8(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <timerinit>:
    80002070:	ff010113          	addi	sp,sp,-16
    80002074:	00813423          	sd	s0,8(sp)
    80002078:	01010413          	addi	s0,sp,16
    8000207c:	f14027f3          	csrr	a5,mhartid
    80002080:	0200c737          	lui	a4,0x200c
    80002084:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002088:	0007869b          	sext.w	a3,a5
    8000208c:	00269713          	slli	a4,a3,0x2
    80002090:	000f4637          	lui	a2,0xf4
    80002094:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002098:	00d70733          	add	a4,a4,a3
    8000209c:	0037979b          	slliw	a5,a5,0x3
    800020a0:	020046b7          	lui	a3,0x2004
    800020a4:	00d787b3          	add	a5,a5,a3
    800020a8:	00c585b3          	add	a1,a1,a2
    800020ac:	00371693          	slli	a3,a4,0x3
    800020b0:	00003717          	auipc	a4,0x3
    800020b4:	7a070713          	addi	a4,a4,1952 # 80005850 <timer_scratch>
    800020b8:	00b7b023          	sd	a1,0(a5)
    800020bc:	00d70733          	add	a4,a4,a3
    800020c0:	00f73c23          	sd	a5,24(a4)
    800020c4:	02c73023          	sd	a2,32(a4)
    800020c8:	34071073          	csrw	mscratch,a4
    800020cc:	00000797          	auipc	a5,0x0
    800020d0:	64478793          	addi	a5,a5,1604 # 80002710 <timervec>
    800020d4:	30579073          	csrw	mtvec,a5
    800020d8:	300027f3          	csrr	a5,mstatus
    800020dc:	0087e793          	ori	a5,a5,8
    800020e0:	30079073          	csrw	mstatus,a5
    800020e4:	304027f3          	csrr	a5,mie
    800020e8:	0807e793          	ori	a5,a5,128
    800020ec:	30479073          	csrw	mie,a5
    800020f0:	00813403          	ld	s0,8(sp)
    800020f4:	01010113          	addi	sp,sp,16
    800020f8:	00008067          	ret

00000000800020fc <system_main>:
    800020fc:	fe010113          	addi	sp,sp,-32
    80002100:	00813823          	sd	s0,16(sp)
    80002104:	00913423          	sd	s1,8(sp)
    80002108:	00113c23          	sd	ra,24(sp)
    8000210c:	02010413          	addi	s0,sp,32
    80002110:	00000097          	auipc	ra,0x0
    80002114:	0c4080e7          	jalr	196(ra) # 800021d4 <cpuid>
    80002118:	00003497          	auipc	s1,0x3
    8000211c:	6d848493          	addi	s1,s1,1752 # 800057f0 <started>
    80002120:	02050263          	beqz	a0,80002144 <system_main+0x48>
    80002124:	0004a783          	lw	a5,0(s1)
    80002128:	0007879b          	sext.w	a5,a5
    8000212c:	fe078ce3          	beqz	a5,80002124 <system_main+0x28>
    80002130:	0ff0000f          	fence
    80002134:	00003517          	auipc	a0,0x3
    80002138:	f7450513          	addi	a0,a0,-140 # 800050a8 <_ZZ12printIntegermE6digits+0x40>
    8000213c:	00001097          	auipc	ra,0x1
    80002140:	a70080e7          	jalr	-1424(ra) # 80002bac <panic>
    80002144:	00001097          	auipc	ra,0x1
    80002148:	9c4080e7          	jalr	-1596(ra) # 80002b08 <consoleinit>
    8000214c:	00001097          	auipc	ra,0x1
    80002150:	150080e7          	jalr	336(ra) # 8000329c <printfinit>
    80002154:	00003517          	auipc	a0,0x3
    80002158:	03450513          	addi	a0,a0,52 # 80005188 <_ZZ12printIntegermE6digits+0x120>
    8000215c:	00001097          	auipc	ra,0x1
    80002160:	aac080e7          	jalr	-1364(ra) # 80002c08 <__printf>
    80002164:	00003517          	auipc	a0,0x3
    80002168:	f1450513          	addi	a0,a0,-236 # 80005078 <_ZZ12printIntegermE6digits+0x10>
    8000216c:	00001097          	auipc	ra,0x1
    80002170:	a9c080e7          	jalr	-1380(ra) # 80002c08 <__printf>
    80002174:	00003517          	auipc	a0,0x3
    80002178:	01450513          	addi	a0,a0,20 # 80005188 <_ZZ12printIntegermE6digits+0x120>
    8000217c:	00001097          	auipc	ra,0x1
    80002180:	a8c080e7          	jalr	-1396(ra) # 80002c08 <__printf>
    80002184:	00001097          	auipc	ra,0x1
    80002188:	4a4080e7          	jalr	1188(ra) # 80003628 <kinit>
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	148080e7          	jalr	328(ra) # 800022d4 <trapinit>
    80002194:	00000097          	auipc	ra,0x0
    80002198:	16c080e7          	jalr	364(ra) # 80002300 <trapinithart>
    8000219c:	00000097          	auipc	ra,0x0
    800021a0:	5b4080e7          	jalr	1460(ra) # 80002750 <plicinit>
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	5d4080e7          	jalr	1492(ra) # 80002778 <plicinithart>
    800021ac:	00000097          	auipc	ra,0x0
    800021b0:	078080e7          	jalr	120(ra) # 80002224 <userinit>
    800021b4:	0ff0000f          	fence
    800021b8:	00100793          	li	a5,1
    800021bc:	00003517          	auipc	a0,0x3
    800021c0:	ed450513          	addi	a0,a0,-300 # 80005090 <_ZZ12printIntegermE6digits+0x28>
    800021c4:	00f4a023          	sw	a5,0(s1)
    800021c8:	00001097          	auipc	ra,0x1
    800021cc:	a40080e7          	jalr	-1472(ra) # 80002c08 <__printf>
    800021d0:	0000006f          	j	800021d0 <system_main+0xd4>

00000000800021d4 <cpuid>:
    800021d4:	ff010113          	addi	sp,sp,-16
    800021d8:	00813423          	sd	s0,8(sp)
    800021dc:	01010413          	addi	s0,sp,16
    800021e0:	00020513          	mv	a0,tp
    800021e4:	00813403          	ld	s0,8(sp)
    800021e8:	0005051b          	sext.w	a0,a0
    800021ec:	01010113          	addi	sp,sp,16
    800021f0:	00008067          	ret

00000000800021f4 <mycpu>:
    800021f4:	ff010113          	addi	sp,sp,-16
    800021f8:	00813423          	sd	s0,8(sp)
    800021fc:	01010413          	addi	s0,sp,16
    80002200:	00020793          	mv	a5,tp
    80002204:	00813403          	ld	s0,8(sp)
    80002208:	0007879b          	sext.w	a5,a5
    8000220c:	00779793          	slli	a5,a5,0x7
    80002210:	00004517          	auipc	a0,0x4
    80002214:	67050513          	addi	a0,a0,1648 # 80006880 <cpus>
    80002218:	00f50533          	add	a0,a0,a5
    8000221c:	01010113          	addi	sp,sp,16
    80002220:	00008067          	ret

0000000080002224 <userinit>:
    80002224:	ff010113          	addi	sp,sp,-16
    80002228:	00813423          	sd	s0,8(sp)
    8000222c:	01010413          	addi	s0,sp,16
    80002230:	00813403          	ld	s0,8(sp)
    80002234:	01010113          	addi	sp,sp,16
    80002238:	fffff317          	auipc	t1,0xfffff
    8000223c:	6b430067          	jr	1716(t1) # 800018ec <main>

0000000080002240 <either_copyout>:
    80002240:	ff010113          	addi	sp,sp,-16
    80002244:	00813023          	sd	s0,0(sp)
    80002248:	00113423          	sd	ra,8(sp)
    8000224c:	01010413          	addi	s0,sp,16
    80002250:	02051663          	bnez	a0,8000227c <either_copyout+0x3c>
    80002254:	00058513          	mv	a0,a1
    80002258:	00060593          	mv	a1,a2
    8000225c:	0006861b          	sext.w	a2,a3
    80002260:	00002097          	auipc	ra,0x2
    80002264:	c54080e7          	jalr	-940(ra) # 80003eb4 <__memmove>
    80002268:	00813083          	ld	ra,8(sp)
    8000226c:	00013403          	ld	s0,0(sp)
    80002270:	00000513          	li	a0,0
    80002274:	01010113          	addi	sp,sp,16
    80002278:	00008067          	ret
    8000227c:	00003517          	auipc	a0,0x3
    80002280:	e5450513          	addi	a0,a0,-428 # 800050d0 <_ZZ12printIntegermE6digits+0x68>
    80002284:	00001097          	auipc	ra,0x1
    80002288:	928080e7          	jalr	-1752(ra) # 80002bac <panic>

000000008000228c <either_copyin>:
    8000228c:	ff010113          	addi	sp,sp,-16
    80002290:	00813023          	sd	s0,0(sp)
    80002294:	00113423          	sd	ra,8(sp)
    80002298:	01010413          	addi	s0,sp,16
    8000229c:	02059463          	bnez	a1,800022c4 <either_copyin+0x38>
    800022a0:	00060593          	mv	a1,a2
    800022a4:	0006861b          	sext.w	a2,a3
    800022a8:	00002097          	auipc	ra,0x2
    800022ac:	c0c080e7          	jalr	-1012(ra) # 80003eb4 <__memmove>
    800022b0:	00813083          	ld	ra,8(sp)
    800022b4:	00013403          	ld	s0,0(sp)
    800022b8:	00000513          	li	a0,0
    800022bc:	01010113          	addi	sp,sp,16
    800022c0:	00008067          	ret
    800022c4:	00003517          	auipc	a0,0x3
    800022c8:	e3450513          	addi	a0,a0,-460 # 800050f8 <_ZZ12printIntegermE6digits+0x90>
    800022cc:	00001097          	auipc	ra,0x1
    800022d0:	8e0080e7          	jalr	-1824(ra) # 80002bac <panic>

00000000800022d4 <trapinit>:
    800022d4:	ff010113          	addi	sp,sp,-16
    800022d8:	00813423          	sd	s0,8(sp)
    800022dc:	01010413          	addi	s0,sp,16
    800022e0:	00813403          	ld	s0,8(sp)
    800022e4:	00003597          	auipc	a1,0x3
    800022e8:	e3c58593          	addi	a1,a1,-452 # 80005120 <_ZZ12printIntegermE6digits+0xb8>
    800022ec:	00004517          	auipc	a0,0x4
    800022f0:	61450513          	addi	a0,a0,1556 # 80006900 <tickslock>
    800022f4:	01010113          	addi	sp,sp,16
    800022f8:	00001317          	auipc	t1,0x1
    800022fc:	5c030067          	jr	1472(t1) # 800038b8 <initlock>

0000000080002300 <trapinithart>:
    80002300:	ff010113          	addi	sp,sp,-16
    80002304:	00813423          	sd	s0,8(sp)
    80002308:	01010413          	addi	s0,sp,16
    8000230c:	00000797          	auipc	a5,0x0
    80002310:	2f478793          	addi	a5,a5,756 # 80002600 <kernelvec>
    80002314:	10579073          	csrw	stvec,a5
    80002318:	00813403          	ld	s0,8(sp)
    8000231c:	01010113          	addi	sp,sp,16
    80002320:	00008067          	ret

0000000080002324 <usertrap>:
    80002324:	ff010113          	addi	sp,sp,-16
    80002328:	00813423          	sd	s0,8(sp)
    8000232c:	01010413          	addi	s0,sp,16
    80002330:	00813403          	ld	s0,8(sp)
    80002334:	01010113          	addi	sp,sp,16
    80002338:	00008067          	ret

000000008000233c <usertrapret>:
    8000233c:	ff010113          	addi	sp,sp,-16
    80002340:	00813423          	sd	s0,8(sp)
    80002344:	01010413          	addi	s0,sp,16
    80002348:	00813403          	ld	s0,8(sp)
    8000234c:	01010113          	addi	sp,sp,16
    80002350:	00008067          	ret

0000000080002354 <kerneltrap>:
    80002354:	fe010113          	addi	sp,sp,-32
    80002358:	00813823          	sd	s0,16(sp)
    8000235c:	00113c23          	sd	ra,24(sp)
    80002360:	00913423          	sd	s1,8(sp)
    80002364:	02010413          	addi	s0,sp,32
    80002368:	142025f3          	csrr	a1,scause
    8000236c:	100027f3          	csrr	a5,sstatus
    80002370:	0027f793          	andi	a5,a5,2
    80002374:	10079c63          	bnez	a5,8000248c <kerneltrap+0x138>
    80002378:	142027f3          	csrr	a5,scause
    8000237c:	0207ce63          	bltz	a5,800023b8 <kerneltrap+0x64>
    80002380:	00003517          	auipc	a0,0x3
    80002384:	de850513          	addi	a0,a0,-536 # 80005168 <_ZZ12printIntegermE6digits+0x100>
    80002388:	00001097          	auipc	ra,0x1
    8000238c:	880080e7          	jalr	-1920(ra) # 80002c08 <__printf>
    80002390:	141025f3          	csrr	a1,sepc
    80002394:	14302673          	csrr	a2,stval
    80002398:	00003517          	auipc	a0,0x3
    8000239c:	de050513          	addi	a0,a0,-544 # 80005178 <_ZZ12printIntegermE6digits+0x110>
    800023a0:	00001097          	auipc	ra,0x1
    800023a4:	868080e7          	jalr	-1944(ra) # 80002c08 <__printf>
    800023a8:	00003517          	auipc	a0,0x3
    800023ac:	de850513          	addi	a0,a0,-536 # 80005190 <_ZZ12printIntegermE6digits+0x128>
    800023b0:	00000097          	auipc	ra,0x0
    800023b4:	7fc080e7          	jalr	2044(ra) # 80002bac <panic>
    800023b8:	0ff7f713          	andi	a4,a5,255
    800023bc:	00900693          	li	a3,9
    800023c0:	04d70063          	beq	a4,a3,80002400 <kerneltrap+0xac>
    800023c4:	fff00713          	li	a4,-1
    800023c8:	03f71713          	slli	a4,a4,0x3f
    800023cc:	00170713          	addi	a4,a4,1
    800023d0:	fae798e3          	bne	a5,a4,80002380 <kerneltrap+0x2c>
    800023d4:	00000097          	auipc	ra,0x0
    800023d8:	e00080e7          	jalr	-512(ra) # 800021d4 <cpuid>
    800023dc:	06050663          	beqz	a0,80002448 <kerneltrap+0xf4>
    800023e0:	144027f3          	csrr	a5,sip
    800023e4:	ffd7f793          	andi	a5,a5,-3
    800023e8:	14479073          	csrw	sip,a5
    800023ec:	01813083          	ld	ra,24(sp)
    800023f0:	01013403          	ld	s0,16(sp)
    800023f4:	00813483          	ld	s1,8(sp)
    800023f8:	02010113          	addi	sp,sp,32
    800023fc:	00008067          	ret
    80002400:	00000097          	auipc	ra,0x0
    80002404:	3c4080e7          	jalr	964(ra) # 800027c4 <plic_claim>
    80002408:	00a00793          	li	a5,10
    8000240c:	00050493          	mv	s1,a0
    80002410:	06f50863          	beq	a0,a5,80002480 <kerneltrap+0x12c>
    80002414:	fc050ce3          	beqz	a0,800023ec <kerneltrap+0x98>
    80002418:	00050593          	mv	a1,a0
    8000241c:	00003517          	auipc	a0,0x3
    80002420:	d2c50513          	addi	a0,a0,-724 # 80005148 <_ZZ12printIntegermE6digits+0xe0>
    80002424:	00000097          	auipc	ra,0x0
    80002428:	7e4080e7          	jalr	2020(ra) # 80002c08 <__printf>
    8000242c:	01013403          	ld	s0,16(sp)
    80002430:	01813083          	ld	ra,24(sp)
    80002434:	00048513          	mv	a0,s1
    80002438:	00813483          	ld	s1,8(sp)
    8000243c:	02010113          	addi	sp,sp,32
    80002440:	00000317          	auipc	t1,0x0
    80002444:	3bc30067          	jr	956(t1) # 800027fc <plic_complete>
    80002448:	00004517          	auipc	a0,0x4
    8000244c:	4b850513          	addi	a0,a0,1208 # 80006900 <tickslock>
    80002450:	00001097          	auipc	ra,0x1
    80002454:	48c080e7          	jalr	1164(ra) # 800038dc <acquire>
    80002458:	00003717          	auipc	a4,0x3
    8000245c:	39c70713          	addi	a4,a4,924 # 800057f4 <ticks>
    80002460:	00072783          	lw	a5,0(a4)
    80002464:	00004517          	auipc	a0,0x4
    80002468:	49c50513          	addi	a0,a0,1180 # 80006900 <tickslock>
    8000246c:	0017879b          	addiw	a5,a5,1
    80002470:	00f72023          	sw	a5,0(a4)
    80002474:	00001097          	auipc	ra,0x1
    80002478:	534080e7          	jalr	1332(ra) # 800039a8 <release>
    8000247c:	f65ff06f          	j	800023e0 <kerneltrap+0x8c>
    80002480:	00001097          	auipc	ra,0x1
    80002484:	090080e7          	jalr	144(ra) # 80003510 <uartintr>
    80002488:	fa5ff06f          	j	8000242c <kerneltrap+0xd8>
    8000248c:	00003517          	auipc	a0,0x3
    80002490:	c9c50513          	addi	a0,a0,-868 # 80005128 <_ZZ12printIntegermE6digits+0xc0>
    80002494:	00000097          	auipc	ra,0x0
    80002498:	718080e7          	jalr	1816(ra) # 80002bac <panic>

000000008000249c <clockintr>:
    8000249c:	fe010113          	addi	sp,sp,-32
    800024a0:	00813823          	sd	s0,16(sp)
    800024a4:	00913423          	sd	s1,8(sp)
    800024a8:	00113c23          	sd	ra,24(sp)
    800024ac:	02010413          	addi	s0,sp,32
    800024b0:	00004497          	auipc	s1,0x4
    800024b4:	45048493          	addi	s1,s1,1104 # 80006900 <tickslock>
    800024b8:	00048513          	mv	a0,s1
    800024bc:	00001097          	auipc	ra,0x1
    800024c0:	420080e7          	jalr	1056(ra) # 800038dc <acquire>
    800024c4:	00003717          	auipc	a4,0x3
    800024c8:	33070713          	addi	a4,a4,816 # 800057f4 <ticks>
    800024cc:	00072783          	lw	a5,0(a4)
    800024d0:	01013403          	ld	s0,16(sp)
    800024d4:	01813083          	ld	ra,24(sp)
    800024d8:	00048513          	mv	a0,s1
    800024dc:	0017879b          	addiw	a5,a5,1
    800024e0:	00813483          	ld	s1,8(sp)
    800024e4:	00f72023          	sw	a5,0(a4)
    800024e8:	02010113          	addi	sp,sp,32
    800024ec:	00001317          	auipc	t1,0x1
    800024f0:	4bc30067          	jr	1212(t1) # 800039a8 <release>

00000000800024f4 <devintr>:
    800024f4:	142027f3          	csrr	a5,scause
    800024f8:	00000513          	li	a0,0
    800024fc:	0007c463          	bltz	a5,80002504 <devintr+0x10>
    80002500:	00008067          	ret
    80002504:	fe010113          	addi	sp,sp,-32
    80002508:	00813823          	sd	s0,16(sp)
    8000250c:	00113c23          	sd	ra,24(sp)
    80002510:	00913423          	sd	s1,8(sp)
    80002514:	02010413          	addi	s0,sp,32
    80002518:	0ff7f713          	andi	a4,a5,255
    8000251c:	00900693          	li	a3,9
    80002520:	04d70c63          	beq	a4,a3,80002578 <devintr+0x84>
    80002524:	fff00713          	li	a4,-1
    80002528:	03f71713          	slli	a4,a4,0x3f
    8000252c:	00170713          	addi	a4,a4,1
    80002530:	00e78c63          	beq	a5,a4,80002548 <devintr+0x54>
    80002534:	01813083          	ld	ra,24(sp)
    80002538:	01013403          	ld	s0,16(sp)
    8000253c:	00813483          	ld	s1,8(sp)
    80002540:	02010113          	addi	sp,sp,32
    80002544:	00008067          	ret
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	c8c080e7          	jalr	-884(ra) # 800021d4 <cpuid>
    80002550:	06050663          	beqz	a0,800025bc <devintr+0xc8>
    80002554:	144027f3          	csrr	a5,sip
    80002558:	ffd7f793          	andi	a5,a5,-3
    8000255c:	14479073          	csrw	sip,a5
    80002560:	01813083          	ld	ra,24(sp)
    80002564:	01013403          	ld	s0,16(sp)
    80002568:	00813483          	ld	s1,8(sp)
    8000256c:	00200513          	li	a0,2
    80002570:	02010113          	addi	sp,sp,32
    80002574:	00008067          	ret
    80002578:	00000097          	auipc	ra,0x0
    8000257c:	24c080e7          	jalr	588(ra) # 800027c4 <plic_claim>
    80002580:	00a00793          	li	a5,10
    80002584:	00050493          	mv	s1,a0
    80002588:	06f50663          	beq	a0,a5,800025f4 <devintr+0x100>
    8000258c:	00100513          	li	a0,1
    80002590:	fa0482e3          	beqz	s1,80002534 <devintr+0x40>
    80002594:	00048593          	mv	a1,s1
    80002598:	00003517          	auipc	a0,0x3
    8000259c:	bb050513          	addi	a0,a0,-1104 # 80005148 <_ZZ12printIntegermE6digits+0xe0>
    800025a0:	00000097          	auipc	ra,0x0
    800025a4:	668080e7          	jalr	1640(ra) # 80002c08 <__printf>
    800025a8:	00048513          	mv	a0,s1
    800025ac:	00000097          	auipc	ra,0x0
    800025b0:	250080e7          	jalr	592(ra) # 800027fc <plic_complete>
    800025b4:	00100513          	li	a0,1
    800025b8:	f7dff06f          	j	80002534 <devintr+0x40>
    800025bc:	00004517          	auipc	a0,0x4
    800025c0:	34450513          	addi	a0,a0,836 # 80006900 <tickslock>
    800025c4:	00001097          	auipc	ra,0x1
    800025c8:	318080e7          	jalr	792(ra) # 800038dc <acquire>
    800025cc:	00003717          	auipc	a4,0x3
    800025d0:	22870713          	addi	a4,a4,552 # 800057f4 <ticks>
    800025d4:	00072783          	lw	a5,0(a4)
    800025d8:	00004517          	auipc	a0,0x4
    800025dc:	32850513          	addi	a0,a0,808 # 80006900 <tickslock>
    800025e0:	0017879b          	addiw	a5,a5,1
    800025e4:	00f72023          	sw	a5,0(a4)
    800025e8:	00001097          	auipc	ra,0x1
    800025ec:	3c0080e7          	jalr	960(ra) # 800039a8 <release>
    800025f0:	f65ff06f          	j	80002554 <devintr+0x60>
    800025f4:	00001097          	auipc	ra,0x1
    800025f8:	f1c080e7          	jalr	-228(ra) # 80003510 <uartintr>
    800025fc:	fadff06f          	j	800025a8 <devintr+0xb4>

0000000080002600 <kernelvec>:
    80002600:	f0010113          	addi	sp,sp,-256
    80002604:	00113023          	sd	ra,0(sp)
    80002608:	00213423          	sd	sp,8(sp)
    8000260c:	00313823          	sd	gp,16(sp)
    80002610:	00413c23          	sd	tp,24(sp)
    80002614:	02513023          	sd	t0,32(sp)
    80002618:	02613423          	sd	t1,40(sp)
    8000261c:	02713823          	sd	t2,48(sp)
    80002620:	02813c23          	sd	s0,56(sp)
    80002624:	04913023          	sd	s1,64(sp)
    80002628:	04a13423          	sd	a0,72(sp)
    8000262c:	04b13823          	sd	a1,80(sp)
    80002630:	04c13c23          	sd	a2,88(sp)
    80002634:	06d13023          	sd	a3,96(sp)
    80002638:	06e13423          	sd	a4,104(sp)
    8000263c:	06f13823          	sd	a5,112(sp)
    80002640:	07013c23          	sd	a6,120(sp)
    80002644:	09113023          	sd	a7,128(sp)
    80002648:	09213423          	sd	s2,136(sp)
    8000264c:	09313823          	sd	s3,144(sp)
    80002650:	09413c23          	sd	s4,152(sp)
    80002654:	0b513023          	sd	s5,160(sp)
    80002658:	0b613423          	sd	s6,168(sp)
    8000265c:	0b713823          	sd	s7,176(sp)
    80002660:	0b813c23          	sd	s8,184(sp)
    80002664:	0d913023          	sd	s9,192(sp)
    80002668:	0da13423          	sd	s10,200(sp)
    8000266c:	0db13823          	sd	s11,208(sp)
    80002670:	0dc13c23          	sd	t3,216(sp)
    80002674:	0fd13023          	sd	t4,224(sp)
    80002678:	0fe13423          	sd	t5,232(sp)
    8000267c:	0ff13823          	sd	t6,240(sp)
    80002680:	cd5ff0ef          	jal	ra,80002354 <kerneltrap>
    80002684:	00013083          	ld	ra,0(sp)
    80002688:	00813103          	ld	sp,8(sp)
    8000268c:	01013183          	ld	gp,16(sp)
    80002690:	02013283          	ld	t0,32(sp)
    80002694:	02813303          	ld	t1,40(sp)
    80002698:	03013383          	ld	t2,48(sp)
    8000269c:	03813403          	ld	s0,56(sp)
    800026a0:	04013483          	ld	s1,64(sp)
    800026a4:	04813503          	ld	a0,72(sp)
    800026a8:	05013583          	ld	a1,80(sp)
    800026ac:	05813603          	ld	a2,88(sp)
    800026b0:	06013683          	ld	a3,96(sp)
    800026b4:	06813703          	ld	a4,104(sp)
    800026b8:	07013783          	ld	a5,112(sp)
    800026bc:	07813803          	ld	a6,120(sp)
    800026c0:	08013883          	ld	a7,128(sp)
    800026c4:	08813903          	ld	s2,136(sp)
    800026c8:	09013983          	ld	s3,144(sp)
    800026cc:	09813a03          	ld	s4,152(sp)
    800026d0:	0a013a83          	ld	s5,160(sp)
    800026d4:	0a813b03          	ld	s6,168(sp)
    800026d8:	0b013b83          	ld	s7,176(sp)
    800026dc:	0b813c03          	ld	s8,184(sp)
    800026e0:	0c013c83          	ld	s9,192(sp)
    800026e4:	0c813d03          	ld	s10,200(sp)
    800026e8:	0d013d83          	ld	s11,208(sp)
    800026ec:	0d813e03          	ld	t3,216(sp)
    800026f0:	0e013e83          	ld	t4,224(sp)
    800026f4:	0e813f03          	ld	t5,232(sp)
    800026f8:	0f013f83          	ld	t6,240(sp)
    800026fc:	10010113          	addi	sp,sp,256
    80002700:	10200073          	sret
    80002704:	00000013          	nop
    80002708:	00000013          	nop
    8000270c:	00000013          	nop

0000000080002710 <timervec>:
    80002710:	34051573          	csrrw	a0,mscratch,a0
    80002714:	00b53023          	sd	a1,0(a0)
    80002718:	00c53423          	sd	a2,8(a0)
    8000271c:	00d53823          	sd	a3,16(a0)
    80002720:	01853583          	ld	a1,24(a0)
    80002724:	02053603          	ld	a2,32(a0)
    80002728:	0005b683          	ld	a3,0(a1)
    8000272c:	00c686b3          	add	a3,a3,a2
    80002730:	00d5b023          	sd	a3,0(a1)
    80002734:	00200593          	li	a1,2
    80002738:	14459073          	csrw	sip,a1
    8000273c:	01053683          	ld	a3,16(a0)
    80002740:	00853603          	ld	a2,8(a0)
    80002744:	00053583          	ld	a1,0(a0)
    80002748:	34051573          	csrrw	a0,mscratch,a0
    8000274c:	30200073          	mret

0000000080002750 <plicinit>:
    80002750:	ff010113          	addi	sp,sp,-16
    80002754:	00813423          	sd	s0,8(sp)
    80002758:	01010413          	addi	s0,sp,16
    8000275c:	00813403          	ld	s0,8(sp)
    80002760:	0c0007b7          	lui	a5,0xc000
    80002764:	00100713          	li	a4,1
    80002768:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000276c:	00e7a223          	sw	a4,4(a5)
    80002770:	01010113          	addi	sp,sp,16
    80002774:	00008067          	ret

0000000080002778 <plicinithart>:
    80002778:	ff010113          	addi	sp,sp,-16
    8000277c:	00813023          	sd	s0,0(sp)
    80002780:	00113423          	sd	ra,8(sp)
    80002784:	01010413          	addi	s0,sp,16
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	a4c080e7          	jalr	-1460(ra) # 800021d4 <cpuid>
    80002790:	0085171b          	slliw	a4,a0,0x8
    80002794:	0c0027b7          	lui	a5,0xc002
    80002798:	00e787b3          	add	a5,a5,a4
    8000279c:	40200713          	li	a4,1026
    800027a0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800027a4:	00813083          	ld	ra,8(sp)
    800027a8:	00013403          	ld	s0,0(sp)
    800027ac:	00d5151b          	slliw	a0,a0,0xd
    800027b0:	0c2017b7          	lui	a5,0xc201
    800027b4:	00a78533          	add	a0,a5,a0
    800027b8:	00052023          	sw	zero,0(a0)
    800027bc:	01010113          	addi	sp,sp,16
    800027c0:	00008067          	ret

00000000800027c4 <plic_claim>:
    800027c4:	ff010113          	addi	sp,sp,-16
    800027c8:	00813023          	sd	s0,0(sp)
    800027cc:	00113423          	sd	ra,8(sp)
    800027d0:	01010413          	addi	s0,sp,16
    800027d4:	00000097          	auipc	ra,0x0
    800027d8:	a00080e7          	jalr	-1536(ra) # 800021d4 <cpuid>
    800027dc:	00813083          	ld	ra,8(sp)
    800027e0:	00013403          	ld	s0,0(sp)
    800027e4:	00d5151b          	slliw	a0,a0,0xd
    800027e8:	0c2017b7          	lui	a5,0xc201
    800027ec:	00a78533          	add	a0,a5,a0
    800027f0:	00452503          	lw	a0,4(a0)
    800027f4:	01010113          	addi	sp,sp,16
    800027f8:	00008067          	ret

00000000800027fc <plic_complete>:
    800027fc:	fe010113          	addi	sp,sp,-32
    80002800:	00813823          	sd	s0,16(sp)
    80002804:	00913423          	sd	s1,8(sp)
    80002808:	00113c23          	sd	ra,24(sp)
    8000280c:	02010413          	addi	s0,sp,32
    80002810:	00050493          	mv	s1,a0
    80002814:	00000097          	auipc	ra,0x0
    80002818:	9c0080e7          	jalr	-1600(ra) # 800021d4 <cpuid>
    8000281c:	01813083          	ld	ra,24(sp)
    80002820:	01013403          	ld	s0,16(sp)
    80002824:	00d5179b          	slliw	a5,a0,0xd
    80002828:	0c201737          	lui	a4,0xc201
    8000282c:	00f707b3          	add	a5,a4,a5
    80002830:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002834:	00813483          	ld	s1,8(sp)
    80002838:	02010113          	addi	sp,sp,32
    8000283c:	00008067          	ret

0000000080002840 <consolewrite>:
    80002840:	fb010113          	addi	sp,sp,-80
    80002844:	04813023          	sd	s0,64(sp)
    80002848:	04113423          	sd	ra,72(sp)
    8000284c:	02913c23          	sd	s1,56(sp)
    80002850:	03213823          	sd	s2,48(sp)
    80002854:	03313423          	sd	s3,40(sp)
    80002858:	03413023          	sd	s4,32(sp)
    8000285c:	01513c23          	sd	s5,24(sp)
    80002860:	05010413          	addi	s0,sp,80
    80002864:	06c05c63          	blez	a2,800028dc <consolewrite+0x9c>
    80002868:	00060993          	mv	s3,a2
    8000286c:	00050a13          	mv	s4,a0
    80002870:	00058493          	mv	s1,a1
    80002874:	00000913          	li	s2,0
    80002878:	fff00a93          	li	s5,-1
    8000287c:	01c0006f          	j	80002898 <consolewrite+0x58>
    80002880:	fbf44503          	lbu	a0,-65(s0)
    80002884:	0019091b          	addiw	s2,s2,1
    80002888:	00148493          	addi	s1,s1,1
    8000288c:	00001097          	auipc	ra,0x1
    80002890:	a9c080e7          	jalr	-1380(ra) # 80003328 <uartputc>
    80002894:	03298063          	beq	s3,s2,800028b4 <consolewrite+0x74>
    80002898:	00048613          	mv	a2,s1
    8000289c:	00100693          	li	a3,1
    800028a0:	000a0593          	mv	a1,s4
    800028a4:	fbf40513          	addi	a0,s0,-65
    800028a8:	00000097          	auipc	ra,0x0
    800028ac:	9e4080e7          	jalr	-1564(ra) # 8000228c <either_copyin>
    800028b0:	fd5518e3          	bne	a0,s5,80002880 <consolewrite+0x40>
    800028b4:	04813083          	ld	ra,72(sp)
    800028b8:	04013403          	ld	s0,64(sp)
    800028bc:	03813483          	ld	s1,56(sp)
    800028c0:	02813983          	ld	s3,40(sp)
    800028c4:	02013a03          	ld	s4,32(sp)
    800028c8:	01813a83          	ld	s5,24(sp)
    800028cc:	00090513          	mv	a0,s2
    800028d0:	03013903          	ld	s2,48(sp)
    800028d4:	05010113          	addi	sp,sp,80
    800028d8:	00008067          	ret
    800028dc:	00000913          	li	s2,0
    800028e0:	fd5ff06f          	j	800028b4 <consolewrite+0x74>

00000000800028e4 <consoleread>:
    800028e4:	f9010113          	addi	sp,sp,-112
    800028e8:	06813023          	sd	s0,96(sp)
    800028ec:	04913c23          	sd	s1,88(sp)
    800028f0:	05213823          	sd	s2,80(sp)
    800028f4:	05313423          	sd	s3,72(sp)
    800028f8:	05413023          	sd	s4,64(sp)
    800028fc:	03513c23          	sd	s5,56(sp)
    80002900:	03613823          	sd	s6,48(sp)
    80002904:	03713423          	sd	s7,40(sp)
    80002908:	03813023          	sd	s8,32(sp)
    8000290c:	06113423          	sd	ra,104(sp)
    80002910:	01913c23          	sd	s9,24(sp)
    80002914:	07010413          	addi	s0,sp,112
    80002918:	00060b93          	mv	s7,a2
    8000291c:	00050913          	mv	s2,a0
    80002920:	00058c13          	mv	s8,a1
    80002924:	00060b1b          	sext.w	s6,a2
    80002928:	00004497          	auipc	s1,0x4
    8000292c:	00048493          	mv	s1,s1
    80002930:	00400993          	li	s3,4
    80002934:	fff00a13          	li	s4,-1
    80002938:	00a00a93          	li	s5,10
    8000293c:	05705e63          	blez	s7,80002998 <consoleread+0xb4>
    80002940:	09c4a703          	lw	a4,156(s1) # 800069c4 <cons+0x9c>
    80002944:	0984a783          	lw	a5,152(s1)
    80002948:	0007071b          	sext.w	a4,a4
    8000294c:	08e78463          	beq	a5,a4,800029d4 <consoleread+0xf0>
    80002950:	07f7f713          	andi	a4,a5,127
    80002954:	00e48733          	add	a4,s1,a4
    80002958:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000295c:	0017869b          	addiw	a3,a5,1
    80002960:	08d4ac23          	sw	a3,152(s1)
    80002964:	00070c9b          	sext.w	s9,a4
    80002968:	0b370663          	beq	a4,s3,80002a14 <consoleread+0x130>
    8000296c:	00100693          	li	a3,1
    80002970:	f9f40613          	addi	a2,s0,-97
    80002974:	000c0593          	mv	a1,s8
    80002978:	00090513          	mv	a0,s2
    8000297c:	f8e40fa3          	sb	a4,-97(s0)
    80002980:	00000097          	auipc	ra,0x0
    80002984:	8c0080e7          	jalr	-1856(ra) # 80002240 <either_copyout>
    80002988:	01450863          	beq	a0,s4,80002998 <consoleread+0xb4>
    8000298c:	001c0c13          	addi	s8,s8,1
    80002990:	fffb8b9b          	addiw	s7,s7,-1
    80002994:	fb5c94e3          	bne	s9,s5,8000293c <consoleread+0x58>
    80002998:	000b851b          	sext.w	a0,s7
    8000299c:	06813083          	ld	ra,104(sp)
    800029a0:	06013403          	ld	s0,96(sp)
    800029a4:	05813483          	ld	s1,88(sp)
    800029a8:	05013903          	ld	s2,80(sp)
    800029ac:	04813983          	ld	s3,72(sp)
    800029b0:	04013a03          	ld	s4,64(sp)
    800029b4:	03813a83          	ld	s5,56(sp)
    800029b8:	02813b83          	ld	s7,40(sp)
    800029bc:	02013c03          	ld	s8,32(sp)
    800029c0:	01813c83          	ld	s9,24(sp)
    800029c4:	40ab053b          	subw	a0,s6,a0
    800029c8:	03013b03          	ld	s6,48(sp)
    800029cc:	07010113          	addi	sp,sp,112
    800029d0:	00008067          	ret
    800029d4:	00001097          	auipc	ra,0x1
    800029d8:	1d8080e7          	jalr	472(ra) # 80003bac <push_on>
    800029dc:	0984a703          	lw	a4,152(s1)
    800029e0:	09c4a783          	lw	a5,156(s1)
    800029e4:	0007879b          	sext.w	a5,a5
    800029e8:	fef70ce3          	beq	a4,a5,800029e0 <consoleread+0xfc>
    800029ec:	00001097          	auipc	ra,0x1
    800029f0:	234080e7          	jalr	564(ra) # 80003c20 <pop_on>
    800029f4:	0984a783          	lw	a5,152(s1)
    800029f8:	07f7f713          	andi	a4,a5,127
    800029fc:	00e48733          	add	a4,s1,a4
    80002a00:	01874703          	lbu	a4,24(a4)
    80002a04:	0017869b          	addiw	a3,a5,1
    80002a08:	08d4ac23          	sw	a3,152(s1)
    80002a0c:	00070c9b          	sext.w	s9,a4
    80002a10:	f5371ee3          	bne	a4,s3,8000296c <consoleread+0x88>
    80002a14:	000b851b          	sext.w	a0,s7
    80002a18:	f96bf2e3          	bgeu	s7,s6,8000299c <consoleread+0xb8>
    80002a1c:	08f4ac23          	sw	a5,152(s1)
    80002a20:	f7dff06f          	j	8000299c <consoleread+0xb8>

0000000080002a24 <consputc>:
    80002a24:	10000793          	li	a5,256
    80002a28:	00f50663          	beq	a0,a5,80002a34 <consputc+0x10>
    80002a2c:	00001317          	auipc	t1,0x1
    80002a30:	9f430067          	jr	-1548(t1) # 80003420 <uartputc_sync>
    80002a34:	ff010113          	addi	sp,sp,-16
    80002a38:	00113423          	sd	ra,8(sp)
    80002a3c:	00813023          	sd	s0,0(sp)
    80002a40:	01010413          	addi	s0,sp,16
    80002a44:	00800513          	li	a0,8
    80002a48:	00001097          	auipc	ra,0x1
    80002a4c:	9d8080e7          	jalr	-1576(ra) # 80003420 <uartputc_sync>
    80002a50:	02000513          	li	a0,32
    80002a54:	00001097          	auipc	ra,0x1
    80002a58:	9cc080e7          	jalr	-1588(ra) # 80003420 <uartputc_sync>
    80002a5c:	00013403          	ld	s0,0(sp)
    80002a60:	00813083          	ld	ra,8(sp)
    80002a64:	00800513          	li	a0,8
    80002a68:	01010113          	addi	sp,sp,16
    80002a6c:	00001317          	auipc	t1,0x1
    80002a70:	9b430067          	jr	-1612(t1) # 80003420 <uartputc_sync>

0000000080002a74 <consoleintr>:
    80002a74:	fe010113          	addi	sp,sp,-32
    80002a78:	00813823          	sd	s0,16(sp)
    80002a7c:	00913423          	sd	s1,8(sp)
    80002a80:	01213023          	sd	s2,0(sp)
    80002a84:	00113c23          	sd	ra,24(sp)
    80002a88:	02010413          	addi	s0,sp,32
    80002a8c:	00004917          	auipc	s2,0x4
    80002a90:	e9c90913          	addi	s2,s2,-356 # 80006928 <cons>
    80002a94:	00050493          	mv	s1,a0
    80002a98:	00090513          	mv	a0,s2
    80002a9c:	00001097          	auipc	ra,0x1
    80002aa0:	e40080e7          	jalr	-448(ra) # 800038dc <acquire>
    80002aa4:	02048c63          	beqz	s1,80002adc <consoleintr+0x68>
    80002aa8:	0a092783          	lw	a5,160(s2)
    80002aac:	09892703          	lw	a4,152(s2)
    80002ab0:	07f00693          	li	a3,127
    80002ab4:	40e7873b          	subw	a4,a5,a4
    80002ab8:	02e6e263          	bltu	a3,a4,80002adc <consoleintr+0x68>
    80002abc:	00d00713          	li	a4,13
    80002ac0:	04e48063          	beq	s1,a4,80002b00 <consoleintr+0x8c>
    80002ac4:	07f7f713          	andi	a4,a5,127
    80002ac8:	00e90733          	add	a4,s2,a4
    80002acc:	0017879b          	addiw	a5,a5,1
    80002ad0:	0af92023          	sw	a5,160(s2)
    80002ad4:	00970c23          	sb	s1,24(a4)
    80002ad8:	08f92e23          	sw	a5,156(s2)
    80002adc:	01013403          	ld	s0,16(sp)
    80002ae0:	01813083          	ld	ra,24(sp)
    80002ae4:	00813483          	ld	s1,8(sp)
    80002ae8:	00013903          	ld	s2,0(sp)
    80002aec:	00004517          	auipc	a0,0x4
    80002af0:	e3c50513          	addi	a0,a0,-452 # 80006928 <cons>
    80002af4:	02010113          	addi	sp,sp,32
    80002af8:	00001317          	auipc	t1,0x1
    80002afc:	eb030067          	jr	-336(t1) # 800039a8 <release>
    80002b00:	00a00493          	li	s1,10
    80002b04:	fc1ff06f          	j	80002ac4 <consoleintr+0x50>

0000000080002b08 <consoleinit>:
    80002b08:	fe010113          	addi	sp,sp,-32
    80002b0c:	00113c23          	sd	ra,24(sp)
    80002b10:	00813823          	sd	s0,16(sp)
    80002b14:	00913423          	sd	s1,8(sp)
    80002b18:	02010413          	addi	s0,sp,32
    80002b1c:	00004497          	auipc	s1,0x4
    80002b20:	e0c48493          	addi	s1,s1,-500 # 80006928 <cons>
    80002b24:	00048513          	mv	a0,s1
    80002b28:	00002597          	auipc	a1,0x2
    80002b2c:	67858593          	addi	a1,a1,1656 # 800051a0 <_ZZ12printIntegermE6digits+0x138>
    80002b30:	00001097          	auipc	ra,0x1
    80002b34:	d88080e7          	jalr	-632(ra) # 800038b8 <initlock>
    80002b38:	00000097          	auipc	ra,0x0
    80002b3c:	7ac080e7          	jalr	1964(ra) # 800032e4 <uartinit>
    80002b40:	01813083          	ld	ra,24(sp)
    80002b44:	01013403          	ld	s0,16(sp)
    80002b48:	00000797          	auipc	a5,0x0
    80002b4c:	d9c78793          	addi	a5,a5,-612 # 800028e4 <consoleread>
    80002b50:	0af4bc23          	sd	a5,184(s1)
    80002b54:	00000797          	auipc	a5,0x0
    80002b58:	cec78793          	addi	a5,a5,-788 # 80002840 <consolewrite>
    80002b5c:	0cf4b023          	sd	a5,192(s1)
    80002b60:	00813483          	ld	s1,8(sp)
    80002b64:	02010113          	addi	sp,sp,32
    80002b68:	00008067          	ret

0000000080002b6c <console_read>:
    80002b6c:	ff010113          	addi	sp,sp,-16
    80002b70:	00813423          	sd	s0,8(sp)
    80002b74:	01010413          	addi	s0,sp,16
    80002b78:	00813403          	ld	s0,8(sp)
    80002b7c:	00004317          	auipc	t1,0x4
    80002b80:	e6433303          	ld	t1,-412(t1) # 800069e0 <devsw+0x10>
    80002b84:	01010113          	addi	sp,sp,16
    80002b88:	00030067          	jr	t1

0000000080002b8c <console_write>:
    80002b8c:	ff010113          	addi	sp,sp,-16
    80002b90:	00813423          	sd	s0,8(sp)
    80002b94:	01010413          	addi	s0,sp,16
    80002b98:	00813403          	ld	s0,8(sp)
    80002b9c:	00004317          	auipc	t1,0x4
    80002ba0:	e4c33303          	ld	t1,-436(t1) # 800069e8 <devsw+0x18>
    80002ba4:	01010113          	addi	sp,sp,16
    80002ba8:	00030067          	jr	t1

0000000080002bac <panic>:
    80002bac:	fe010113          	addi	sp,sp,-32
    80002bb0:	00113c23          	sd	ra,24(sp)
    80002bb4:	00813823          	sd	s0,16(sp)
    80002bb8:	00913423          	sd	s1,8(sp)
    80002bbc:	02010413          	addi	s0,sp,32
    80002bc0:	00050493          	mv	s1,a0
    80002bc4:	00002517          	auipc	a0,0x2
    80002bc8:	5e450513          	addi	a0,a0,1508 # 800051a8 <_ZZ12printIntegermE6digits+0x140>
    80002bcc:	00004797          	auipc	a5,0x4
    80002bd0:	ea07ae23          	sw	zero,-324(a5) # 80006a88 <pr+0x18>
    80002bd4:	00000097          	auipc	ra,0x0
    80002bd8:	034080e7          	jalr	52(ra) # 80002c08 <__printf>
    80002bdc:	00048513          	mv	a0,s1
    80002be0:	00000097          	auipc	ra,0x0
    80002be4:	028080e7          	jalr	40(ra) # 80002c08 <__printf>
    80002be8:	00002517          	auipc	a0,0x2
    80002bec:	5a050513          	addi	a0,a0,1440 # 80005188 <_ZZ12printIntegermE6digits+0x120>
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	018080e7          	jalr	24(ra) # 80002c08 <__printf>
    80002bf8:	00100793          	li	a5,1
    80002bfc:	00003717          	auipc	a4,0x3
    80002c00:	bef72e23          	sw	a5,-1028(a4) # 800057f8 <panicked>
    80002c04:	0000006f          	j	80002c04 <panic+0x58>

0000000080002c08 <__printf>:
    80002c08:	f3010113          	addi	sp,sp,-208
    80002c0c:	08813023          	sd	s0,128(sp)
    80002c10:	07313423          	sd	s3,104(sp)
    80002c14:	09010413          	addi	s0,sp,144
    80002c18:	05813023          	sd	s8,64(sp)
    80002c1c:	08113423          	sd	ra,136(sp)
    80002c20:	06913c23          	sd	s1,120(sp)
    80002c24:	07213823          	sd	s2,112(sp)
    80002c28:	07413023          	sd	s4,96(sp)
    80002c2c:	05513c23          	sd	s5,88(sp)
    80002c30:	05613823          	sd	s6,80(sp)
    80002c34:	05713423          	sd	s7,72(sp)
    80002c38:	03913c23          	sd	s9,56(sp)
    80002c3c:	03a13823          	sd	s10,48(sp)
    80002c40:	03b13423          	sd	s11,40(sp)
    80002c44:	00004317          	auipc	t1,0x4
    80002c48:	e2c30313          	addi	t1,t1,-468 # 80006a70 <pr>
    80002c4c:	01832c03          	lw	s8,24(t1)
    80002c50:	00b43423          	sd	a1,8(s0)
    80002c54:	00c43823          	sd	a2,16(s0)
    80002c58:	00d43c23          	sd	a3,24(s0)
    80002c5c:	02e43023          	sd	a4,32(s0)
    80002c60:	02f43423          	sd	a5,40(s0)
    80002c64:	03043823          	sd	a6,48(s0)
    80002c68:	03143c23          	sd	a7,56(s0)
    80002c6c:	00050993          	mv	s3,a0
    80002c70:	4a0c1663          	bnez	s8,8000311c <__printf+0x514>
    80002c74:	60098c63          	beqz	s3,8000328c <__printf+0x684>
    80002c78:	0009c503          	lbu	a0,0(s3)
    80002c7c:	00840793          	addi	a5,s0,8
    80002c80:	f6f43c23          	sd	a5,-136(s0)
    80002c84:	00000493          	li	s1,0
    80002c88:	22050063          	beqz	a0,80002ea8 <__printf+0x2a0>
    80002c8c:	00002a37          	lui	s4,0x2
    80002c90:	00018ab7          	lui	s5,0x18
    80002c94:	000f4b37          	lui	s6,0xf4
    80002c98:	00989bb7          	lui	s7,0x989
    80002c9c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002ca0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002ca4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002ca8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002cac:	00148c9b          	addiw	s9,s1,1
    80002cb0:	02500793          	li	a5,37
    80002cb4:	01998933          	add	s2,s3,s9
    80002cb8:	38f51263          	bne	a0,a5,8000303c <__printf+0x434>
    80002cbc:	00094783          	lbu	a5,0(s2)
    80002cc0:	00078c9b          	sext.w	s9,a5
    80002cc4:	1e078263          	beqz	a5,80002ea8 <__printf+0x2a0>
    80002cc8:	0024849b          	addiw	s1,s1,2
    80002ccc:	07000713          	li	a4,112
    80002cd0:	00998933          	add	s2,s3,s1
    80002cd4:	38e78a63          	beq	a5,a4,80003068 <__printf+0x460>
    80002cd8:	20f76863          	bltu	a4,a5,80002ee8 <__printf+0x2e0>
    80002cdc:	42a78863          	beq	a5,a0,8000310c <__printf+0x504>
    80002ce0:	06400713          	li	a4,100
    80002ce4:	40e79663          	bne	a5,a4,800030f0 <__printf+0x4e8>
    80002ce8:	f7843783          	ld	a5,-136(s0)
    80002cec:	0007a603          	lw	a2,0(a5)
    80002cf0:	00878793          	addi	a5,a5,8
    80002cf4:	f6f43c23          	sd	a5,-136(s0)
    80002cf8:	42064a63          	bltz	a2,8000312c <__printf+0x524>
    80002cfc:	00a00713          	li	a4,10
    80002d00:	02e677bb          	remuw	a5,a2,a4
    80002d04:	00002d97          	auipc	s11,0x2
    80002d08:	4ccd8d93          	addi	s11,s11,1228 # 800051d0 <digits>
    80002d0c:	00900593          	li	a1,9
    80002d10:	0006051b          	sext.w	a0,a2
    80002d14:	00000c93          	li	s9,0
    80002d18:	02079793          	slli	a5,a5,0x20
    80002d1c:	0207d793          	srli	a5,a5,0x20
    80002d20:	00fd87b3          	add	a5,s11,a5
    80002d24:	0007c783          	lbu	a5,0(a5)
    80002d28:	02e656bb          	divuw	a3,a2,a4
    80002d2c:	f8f40023          	sb	a5,-128(s0)
    80002d30:	14c5d863          	bge	a1,a2,80002e80 <__printf+0x278>
    80002d34:	06300593          	li	a1,99
    80002d38:	00100c93          	li	s9,1
    80002d3c:	02e6f7bb          	remuw	a5,a3,a4
    80002d40:	02079793          	slli	a5,a5,0x20
    80002d44:	0207d793          	srli	a5,a5,0x20
    80002d48:	00fd87b3          	add	a5,s11,a5
    80002d4c:	0007c783          	lbu	a5,0(a5)
    80002d50:	02e6d73b          	divuw	a4,a3,a4
    80002d54:	f8f400a3          	sb	a5,-127(s0)
    80002d58:	12a5f463          	bgeu	a1,a0,80002e80 <__printf+0x278>
    80002d5c:	00a00693          	li	a3,10
    80002d60:	00900593          	li	a1,9
    80002d64:	02d777bb          	remuw	a5,a4,a3
    80002d68:	02079793          	slli	a5,a5,0x20
    80002d6c:	0207d793          	srli	a5,a5,0x20
    80002d70:	00fd87b3          	add	a5,s11,a5
    80002d74:	0007c503          	lbu	a0,0(a5)
    80002d78:	02d757bb          	divuw	a5,a4,a3
    80002d7c:	f8a40123          	sb	a0,-126(s0)
    80002d80:	48e5f263          	bgeu	a1,a4,80003204 <__printf+0x5fc>
    80002d84:	06300513          	li	a0,99
    80002d88:	02d7f5bb          	remuw	a1,a5,a3
    80002d8c:	02059593          	slli	a1,a1,0x20
    80002d90:	0205d593          	srli	a1,a1,0x20
    80002d94:	00bd85b3          	add	a1,s11,a1
    80002d98:	0005c583          	lbu	a1,0(a1)
    80002d9c:	02d7d7bb          	divuw	a5,a5,a3
    80002da0:	f8b401a3          	sb	a1,-125(s0)
    80002da4:	48e57263          	bgeu	a0,a4,80003228 <__printf+0x620>
    80002da8:	3e700513          	li	a0,999
    80002dac:	02d7f5bb          	remuw	a1,a5,a3
    80002db0:	02059593          	slli	a1,a1,0x20
    80002db4:	0205d593          	srli	a1,a1,0x20
    80002db8:	00bd85b3          	add	a1,s11,a1
    80002dbc:	0005c583          	lbu	a1,0(a1)
    80002dc0:	02d7d7bb          	divuw	a5,a5,a3
    80002dc4:	f8b40223          	sb	a1,-124(s0)
    80002dc8:	46e57663          	bgeu	a0,a4,80003234 <__printf+0x62c>
    80002dcc:	02d7f5bb          	remuw	a1,a5,a3
    80002dd0:	02059593          	slli	a1,a1,0x20
    80002dd4:	0205d593          	srli	a1,a1,0x20
    80002dd8:	00bd85b3          	add	a1,s11,a1
    80002ddc:	0005c583          	lbu	a1,0(a1)
    80002de0:	02d7d7bb          	divuw	a5,a5,a3
    80002de4:	f8b402a3          	sb	a1,-123(s0)
    80002de8:	46ea7863          	bgeu	s4,a4,80003258 <__printf+0x650>
    80002dec:	02d7f5bb          	remuw	a1,a5,a3
    80002df0:	02059593          	slli	a1,a1,0x20
    80002df4:	0205d593          	srli	a1,a1,0x20
    80002df8:	00bd85b3          	add	a1,s11,a1
    80002dfc:	0005c583          	lbu	a1,0(a1)
    80002e00:	02d7d7bb          	divuw	a5,a5,a3
    80002e04:	f8b40323          	sb	a1,-122(s0)
    80002e08:	3eeaf863          	bgeu	s5,a4,800031f8 <__printf+0x5f0>
    80002e0c:	02d7f5bb          	remuw	a1,a5,a3
    80002e10:	02059593          	slli	a1,a1,0x20
    80002e14:	0205d593          	srli	a1,a1,0x20
    80002e18:	00bd85b3          	add	a1,s11,a1
    80002e1c:	0005c583          	lbu	a1,0(a1)
    80002e20:	02d7d7bb          	divuw	a5,a5,a3
    80002e24:	f8b403a3          	sb	a1,-121(s0)
    80002e28:	42eb7e63          	bgeu	s6,a4,80003264 <__printf+0x65c>
    80002e2c:	02d7f5bb          	remuw	a1,a5,a3
    80002e30:	02059593          	slli	a1,a1,0x20
    80002e34:	0205d593          	srli	a1,a1,0x20
    80002e38:	00bd85b3          	add	a1,s11,a1
    80002e3c:	0005c583          	lbu	a1,0(a1)
    80002e40:	02d7d7bb          	divuw	a5,a5,a3
    80002e44:	f8b40423          	sb	a1,-120(s0)
    80002e48:	42ebfc63          	bgeu	s7,a4,80003280 <__printf+0x678>
    80002e4c:	02079793          	slli	a5,a5,0x20
    80002e50:	0207d793          	srli	a5,a5,0x20
    80002e54:	00fd8db3          	add	s11,s11,a5
    80002e58:	000dc703          	lbu	a4,0(s11)
    80002e5c:	00a00793          	li	a5,10
    80002e60:	00900c93          	li	s9,9
    80002e64:	f8e404a3          	sb	a4,-119(s0)
    80002e68:	00065c63          	bgez	a2,80002e80 <__printf+0x278>
    80002e6c:	f9040713          	addi	a4,s0,-112
    80002e70:	00f70733          	add	a4,a4,a5
    80002e74:	02d00693          	li	a3,45
    80002e78:	fed70823          	sb	a3,-16(a4)
    80002e7c:	00078c93          	mv	s9,a5
    80002e80:	f8040793          	addi	a5,s0,-128
    80002e84:	01978cb3          	add	s9,a5,s9
    80002e88:	f7f40d13          	addi	s10,s0,-129
    80002e8c:	000cc503          	lbu	a0,0(s9)
    80002e90:	fffc8c93          	addi	s9,s9,-1
    80002e94:	00000097          	auipc	ra,0x0
    80002e98:	b90080e7          	jalr	-1136(ra) # 80002a24 <consputc>
    80002e9c:	ffac98e3          	bne	s9,s10,80002e8c <__printf+0x284>
    80002ea0:	00094503          	lbu	a0,0(s2)
    80002ea4:	e00514e3          	bnez	a0,80002cac <__printf+0xa4>
    80002ea8:	1a0c1663          	bnez	s8,80003054 <__printf+0x44c>
    80002eac:	08813083          	ld	ra,136(sp)
    80002eb0:	08013403          	ld	s0,128(sp)
    80002eb4:	07813483          	ld	s1,120(sp)
    80002eb8:	07013903          	ld	s2,112(sp)
    80002ebc:	06813983          	ld	s3,104(sp)
    80002ec0:	06013a03          	ld	s4,96(sp)
    80002ec4:	05813a83          	ld	s5,88(sp)
    80002ec8:	05013b03          	ld	s6,80(sp)
    80002ecc:	04813b83          	ld	s7,72(sp)
    80002ed0:	04013c03          	ld	s8,64(sp)
    80002ed4:	03813c83          	ld	s9,56(sp)
    80002ed8:	03013d03          	ld	s10,48(sp)
    80002edc:	02813d83          	ld	s11,40(sp)
    80002ee0:	0d010113          	addi	sp,sp,208
    80002ee4:	00008067          	ret
    80002ee8:	07300713          	li	a4,115
    80002eec:	1ce78a63          	beq	a5,a4,800030c0 <__printf+0x4b8>
    80002ef0:	07800713          	li	a4,120
    80002ef4:	1ee79e63          	bne	a5,a4,800030f0 <__printf+0x4e8>
    80002ef8:	f7843783          	ld	a5,-136(s0)
    80002efc:	0007a703          	lw	a4,0(a5)
    80002f00:	00878793          	addi	a5,a5,8
    80002f04:	f6f43c23          	sd	a5,-136(s0)
    80002f08:	28074263          	bltz	a4,8000318c <__printf+0x584>
    80002f0c:	00002d97          	auipc	s11,0x2
    80002f10:	2c4d8d93          	addi	s11,s11,708 # 800051d0 <digits>
    80002f14:	00f77793          	andi	a5,a4,15
    80002f18:	00fd87b3          	add	a5,s11,a5
    80002f1c:	0007c683          	lbu	a3,0(a5)
    80002f20:	00f00613          	li	a2,15
    80002f24:	0007079b          	sext.w	a5,a4
    80002f28:	f8d40023          	sb	a3,-128(s0)
    80002f2c:	0047559b          	srliw	a1,a4,0x4
    80002f30:	0047569b          	srliw	a3,a4,0x4
    80002f34:	00000c93          	li	s9,0
    80002f38:	0ee65063          	bge	a2,a4,80003018 <__printf+0x410>
    80002f3c:	00f6f693          	andi	a3,a3,15
    80002f40:	00dd86b3          	add	a3,s11,a3
    80002f44:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002f48:	0087d79b          	srliw	a5,a5,0x8
    80002f4c:	00100c93          	li	s9,1
    80002f50:	f8d400a3          	sb	a3,-127(s0)
    80002f54:	0cb67263          	bgeu	a2,a1,80003018 <__printf+0x410>
    80002f58:	00f7f693          	andi	a3,a5,15
    80002f5c:	00dd86b3          	add	a3,s11,a3
    80002f60:	0006c583          	lbu	a1,0(a3)
    80002f64:	00f00613          	li	a2,15
    80002f68:	0047d69b          	srliw	a3,a5,0x4
    80002f6c:	f8b40123          	sb	a1,-126(s0)
    80002f70:	0047d593          	srli	a1,a5,0x4
    80002f74:	28f67e63          	bgeu	a2,a5,80003210 <__printf+0x608>
    80002f78:	00f6f693          	andi	a3,a3,15
    80002f7c:	00dd86b3          	add	a3,s11,a3
    80002f80:	0006c503          	lbu	a0,0(a3)
    80002f84:	0087d813          	srli	a6,a5,0x8
    80002f88:	0087d69b          	srliw	a3,a5,0x8
    80002f8c:	f8a401a3          	sb	a0,-125(s0)
    80002f90:	28b67663          	bgeu	a2,a1,8000321c <__printf+0x614>
    80002f94:	00f6f693          	andi	a3,a3,15
    80002f98:	00dd86b3          	add	a3,s11,a3
    80002f9c:	0006c583          	lbu	a1,0(a3)
    80002fa0:	00c7d513          	srli	a0,a5,0xc
    80002fa4:	00c7d69b          	srliw	a3,a5,0xc
    80002fa8:	f8b40223          	sb	a1,-124(s0)
    80002fac:	29067a63          	bgeu	a2,a6,80003240 <__printf+0x638>
    80002fb0:	00f6f693          	andi	a3,a3,15
    80002fb4:	00dd86b3          	add	a3,s11,a3
    80002fb8:	0006c583          	lbu	a1,0(a3)
    80002fbc:	0107d813          	srli	a6,a5,0x10
    80002fc0:	0107d69b          	srliw	a3,a5,0x10
    80002fc4:	f8b402a3          	sb	a1,-123(s0)
    80002fc8:	28a67263          	bgeu	a2,a0,8000324c <__printf+0x644>
    80002fcc:	00f6f693          	andi	a3,a3,15
    80002fd0:	00dd86b3          	add	a3,s11,a3
    80002fd4:	0006c683          	lbu	a3,0(a3)
    80002fd8:	0147d79b          	srliw	a5,a5,0x14
    80002fdc:	f8d40323          	sb	a3,-122(s0)
    80002fe0:	21067663          	bgeu	a2,a6,800031ec <__printf+0x5e4>
    80002fe4:	02079793          	slli	a5,a5,0x20
    80002fe8:	0207d793          	srli	a5,a5,0x20
    80002fec:	00fd8db3          	add	s11,s11,a5
    80002ff0:	000dc683          	lbu	a3,0(s11)
    80002ff4:	00800793          	li	a5,8
    80002ff8:	00700c93          	li	s9,7
    80002ffc:	f8d403a3          	sb	a3,-121(s0)
    80003000:	00075c63          	bgez	a4,80003018 <__printf+0x410>
    80003004:	f9040713          	addi	a4,s0,-112
    80003008:	00f70733          	add	a4,a4,a5
    8000300c:	02d00693          	li	a3,45
    80003010:	fed70823          	sb	a3,-16(a4)
    80003014:	00078c93          	mv	s9,a5
    80003018:	f8040793          	addi	a5,s0,-128
    8000301c:	01978cb3          	add	s9,a5,s9
    80003020:	f7f40d13          	addi	s10,s0,-129
    80003024:	000cc503          	lbu	a0,0(s9)
    80003028:	fffc8c93          	addi	s9,s9,-1
    8000302c:	00000097          	auipc	ra,0x0
    80003030:	9f8080e7          	jalr	-1544(ra) # 80002a24 <consputc>
    80003034:	ff9d18e3          	bne	s10,s9,80003024 <__printf+0x41c>
    80003038:	0100006f          	j	80003048 <__printf+0x440>
    8000303c:	00000097          	auipc	ra,0x0
    80003040:	9e8080e7          	jalr	-1560(ra) # 80002a24 <consputc>
    80003044:	000c8493          	mv	s1,s9
    80003048:	00094503          	lbu	a0,0(s2)
    8000304c:	c60510e3          	bnez	a0,80002cac <__printf+0xa4>
    80003050:	e40c0ee3          	beqz	s8,80002eac <__printf+0x2a4>
    80003054:	00004517          	auipc	a0,0x4
    80003058:	a1c50513          	addi	a0,a0,-1508 # 80006a70 <pr>
    8000305c:	00001097          	auipc	ra,0x1
    80003060:	94c080e7          	jalr	-1716(ra) # 800039a8 <release>
    80003064:	e49ff06f          	j	80002eac <__printf+0x2a4>
    80003068:	f7843783          	ld	a5,-136(s0)
    8000306c:	03000513          	li	a0,48
    80003070:	01000d13          	li	s10,16
    80003074:	00878713          	addi	a4,a5,8
    80003078:	0007bc83          	ld	s9,0(a5)
    8000307c:	f6e43c23          	sd	a4,-136(s0)
    80003080:	00000097          	auipc	ra,0x0
    80003084:	9a4080e7          	jalr	-1628(ra) # 80002a24 <consputc>
    80003088:	07800513          	li	a0,120
    8000308c:	00000097          	auipc	ra,0x0
    80003090:	998080e7          	jalr	-1640(ra) # 80002a24 <consputc>
    80003094:	00002d97          	auipc	s11,0x2
    80003098:	13cd8d93          	addi	s11,s11,316 # 800051d0 <digits>
    8000309c:	03ccd793          	srli	a5,s9,0x3c
    800030a0:	00fd87b3          	add	a5,s11,a5
    800030a4:	0007c503          	lbu	a0,0(a5)
    800030a8:	fffd0d1b          	addiw	s10,s10,-1
    800030ac:	004c9c93          	slli	s9,s9,0x4
    800030b0:	00000097          	auipc	ra,0x0
    800030b4:	974080e7          	jalr	-1676(ra) # 80002a24 <consputc>
    800030b8:	fe0d12e3          	bnez	s10,8000309c <__printf+0x494>
    800030bc:	f8dff06f          	j	80003048 <__printf+0x440>
    800030c0:	f7843783          	ld	a5,-136(s0)
    800030c4:	0007bc83          	ld	s9,0(a5)
    800030c8:	00878793          	addi	a5,a5,8
    800030cc:	f6f43c23          	sd	a5,-136(s0)
    800030d0:	000c9a63          	bnez	s9,800030e4 <__printf+0x4dc>
    800030d4:	1080006f          	j	800031dc <__printf+0x5d4>
    800030d8:	001c8c93          	addi	s9,s9,1
    800030dc:	00000097          	auipc	ra,0x0
    800030e0:	948080e7          	jalr	-1720(ra) # 80002a24 <consputc>
    800030e4:	000cc503          	lbu	a0,0(s9)
    800030e8:	fe0518e3          	bnez	a0,800030d8 <__printf+0x4d0>
    800030ec:	f5dff06f          	j	80003048 <__printf+0x440>
    800030f0:	02500513          	li	a0,37
    800030f4:	00000097          	auipc	ra,0x0
    800030f8:	930080e7          	jalr	-1744(ra) # 80002a24 <consputc>
    800030fc:	000c8513          	mv	a0,s9
    80003100:	00000097          	auipc	ra,0x0
    80003104:	924080e7          	jalr	-1756(ra) # 80002a24 <consputc>
    80003108:	f41ff06f          	j	80003048 <__printf+0x440>
    8000310c:	02500513          	li	a0,37
    80003110:	00000097          	auipc	ra,0x0
    80003114:	914080e7          	jalr	-1772(ra) # 80002a24 <consputc>
    80003118:	f31ff06f          	j	80003048 <__printf+0x440>
    8000311c:	00030513          	mv	a0,t1
    80003120:	00000097          	auipc	ra,0x0
    80003124:	7bc080e7          	jalr	1980(ra) # 800038dc <acquire>
    80003128:	b4dff06f          	j	80002c74 <__printf+0x6c>
    8000312c:	40c0053b          	negw	a0,a2
    80003130:	00a00713          	li	a4,10
    80003134:	02e576bb          	remuw	a3,a0,a4
    80003138:	00002d97          	auipc	s11,0x2
    8000313c:	098d8d93          	addi	s11,s11,152 # 800051d0 <digits>
    80003140:	ff700593          	li	a1,-9
    80003144:	02069693          	slli	a3,a3,0x20
    80003148:	0206d693          	srli	a3,a3,0x20
    8000314c:	00dd86b3          	add	a3,s11,a3
    80003150:	0006c683          	lbu	a3,0(a3)
    80003154:	02e557bb          	divuw	a5,a0,a4
    80003158:	f8d40023          	sb	a3,-128(s0)
    8000315c:	10b65e63          	bge	a2,a1,80003278 <__printf+0x670>
    80003160:	06300593          	li	a1,99
    80003164:	02e7f6bb          	remuw	a3,a5,a4
    80003168:	02069693          	slli	a3,a3,0x20
    8000316c:	0206d693          	srli	a3,a3,0x20
    80003170:	00dd86b3          	add	a3,s11,a3
    80003174:	0006c683          	lbu	a3,0(a3)
    80003178:	02e7d73b          	divuw	a4,a5,a4
    8000317c:	00200793          	li	a5,2
    80003180:	f8d400a3          	sb	a3,-127(s0)
    80003184:	bca5ece3          	bltu	a1,a0,80002d5c <__printf+0x154>
    80003188:	ce5ff06f          	j	80002e6c <__printf+0x264>
    8000318c:	40e007bb          	negw	a5,a4
    80003190:	00002d97          	auipc	s11,0x2
    80003194:	040d8d93          	addi	s11,s11,64 # 800051d0 <digits>
    80003198:	00f7f693          	andi	a3,a5,15
    8000319c:	00dd86b3          	add	a3,s11,a3
    800031a0:	0006c583          	lbu	a1,0(a3)
    800031a4:	ff100613          	li	a2,-15
    800031a8:	0047d69b          	srliw	a3,a5,0x4
    800031ac:	f8b40023          	sb	a1,-128(s0)
    800031b0:	0047d59b          	srliw	a1,a5,0x4
    800031b4:	0ac75e63          	bge	a4,a2,80003270 <__printf+0x668>
    800031b8:	00f6f693          	andi	a3,a3,15
    800031bc:	00dd86b3          	add	a3,s11,a3
    800031c0:	0006c603          	lbu	a2,0(a3)
    800031c4:	00f00693          	li	a3,15
    800031c8:	0087d79b          	srliw	a5,a5,0x8
    800031cc:	f8c400a3          	sb	a2,-127(s0)
    800031d0:	d8b6e4e3          	bltu	a3,a1,80002f58 <__printf+0x350>
    800031d4:	00200793          	li	a5,2
    800031d8:	e2dff06f          	j	80003004 <__printf+0x3fc>
    800031dc:	00002c97          	auipc	s9,0x2
    800031e0:	fd4c8c93          	addi	s9,s9,-44 # 800051b0 <_ZZ12printIntegermE6digits+0x148>
    800031e4:	02800513          	li	a0,40
    800031e8:	ef1ff06f          	j	800030d8 <__printf+0x4d0>
    800031ec:	00700793          	li	a5,7
    800031f0:	00600c93          	li	s9,6
    800031f4:	e0dff06f          	j	80003000 <__printf+0x3f8>
    800031f8:	00700793          	li	a5,7
    800031fc:	00600c93          	li	s9,6
    80003200:	c69ff06f          	j	80002e68 <__printf+0x260>
    80003204:	00300793          	li	a5,3
    80003208:	00200c93          	li	s9,2
    8000320c:	c5dff06f          	j	80002e68 <__printf+0x260>
    80003210:	00300793          	li	a5,3
    80003214:	00200c93          	li	s9,2
    80003218:	de9ff06f          	j	80003000 <__printf+0x3f8>
    8000321c:	00400793          	li	a5,4
    80003220:	00300c93          	li	s9,3
    80003224:	dddff06f          	j	80003000 <__printf+0x3f8>
    80003228:	00400793          	li	a5,4
    8000322c:	00300c93          	li	s9,3
    80003230:	c39ff06f          	j	80002e68 <__printf+0x260>
    80003234:	00500793          	li	a5,5
    80003238:	00400c93          	li	s9,4
    8000323c:	c2dff06f          	j	80002e68 <__printf+0x260>
    80003240:	00500793          	li	a5,5
    80003244:	00400c93          	li	s9,4
    80003248:	db9ff06f          	j	80003000 <__printf+0x3f8>
    8000324c:	00600793          	li	a5,6
    80003250:	00500c93          	li	s9,5
    80003254:	dadff06f          	j	80003000 <__printf+0x3f8>
    80003258:	00600793          	li	a5,6
    8000325c:	00500c93          	li	s9,5
    80003260:	c09ff06f          	j	80002e68 <__printf+0x260>
    80003264:	00800793          	li	a5,8
    80003268:	00700c93          	li	s9,7
    8000326c:	bfdff06f          	j	80002e68 <__printf+0x260>
    80003270:	00100793          	li	a5,1
    80003274:	d91ff06f          	j	80003004 <__printf+0x3fc>
    80003278:	00100793          	li	a5,1
    8000327c:	bf1ff06f          	j	80002e6c <__printf+0x264>
    80003280:	00900793          	li	a5,9
    80003284:	00800c93          	li	s9,8
    80003288:	be1ff06f          	j	80002e68 <__printf+0x260>
    8000328c:	00002517          	auipc	a0,0x2
    80003290:	f2c50513          	addi	a0,a0,-212 # 800051b8 <_ZZ12printIntegermE6digits+0x150>
    80003294:	00000097          	auipc	ra,0x0
    80003298:	918080e7          	jalr	-1768(ra) # 80002bac <panic>

000000008000329c <printfinit>:
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00813823          	sd	s0,16(sp)
    800032a4:	00913423          	sd	s1,8(sp)
    800032a8:	00113c23          	sd	ra,24(sp)
    800032ac:	02010413          	addi	s0,sp,32
    800032b0:	00003497          	auipc	s1,0x3
    800032b4:	7c048493          	addi	s1,s1,1984 # 80006a70 <pr>
    800032b8:	00048513          	mv	a0,s1
    800032bc:	00002597          	auipc	a1,0x2
    800032c0:	f0c58593          	addi	a1,a1,-244 # 800051c8 <_ZZ12printIntegermE6digits+0x160>
    800032c4:	00000097          	auipc	ra,0x0
    800032c8:	5f4080e7          	jalr	1524(ra) # 800038b8 <initlock>
    800032cc:	01813083          	ld	ra,24(sp)
    800032d0:	01013403          	ld	s0,16(sp)
    800032d4:	0004ac23          	sw	zero,24(s1)
    800032d8:	00813483          	ld	s1,8(sp)
    800032dc:	02010113          	addi	sp,sp,32
    800032e0:	00008067          	ret

00000000800032e4 <uartinit>:
    800032e4:	ff010113          	addi	sp,sp,-16
    800032e8:	00813423          	sd	s0,8(sp)
    800032ec:	01010413          	addi	s0,sp,16
    800032f0:	100007b7          	lui	a5,0x10000
    800032f4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800032f8:	f8000713          	li	a4,-128
    800032fc:	00e781a3          	sb	a4,3(a5)
    80003300:	00300713          	li	a4,3
    80003304:	00e78023          	sb	a4,0(a5)
    80003308:	000780a3          	sb	zero,1(a5)
    8000330c:	00e781a3          	sb	a4,3(a5)
    80003310:	00700693          	li	a3,7
    80003314:	00d78123          	sb	a3,2(a5)
    80003318:	00e780a3          	sb	a4,1(a5)
    8000331c:	00813403          	ld	s0,8(sp)
    80003320:	01010113          	addi	sp,sp,16
    80003324:	00008067          	ret

0000000080003328 <uartputc>:
    80003328:	00002797          	auipc	a5,0x2
    8000332c:	4d07a783          	lw	a5,1232(a5) # 800057f8 <panicked>
    80003330:	00078463          	beqz	a5,80003338 <uartputc+0x10>
    80003334:	0000006f          	j	80003334 <uartputc+0xc>
    80003338:	fd010113          	addi	sp,sp,-48
    8000333c:	02813023          	sd	s0,32(sp)
    80003340:	00913c23          	sd	s1,24(sp)
    80003344:	01213823          	sd	s2,16(sp)
    80003348:	01313423          	sd	s3,8(sp)
    8000334c:	02113423          	sd	ra,40(sp)
    80003350:	03010413          	addi	s0,sp,48
    80003354:	00002917          	auipc	s2,0x2
    80003358:	4ac90913          	addi	s2,s2,1196 # 80005800 <uart_tx_r>
    8000335c:	00093783          	ld	a5,0(s2)
    80003360:	00002497          	auipc	s1,0x2
    80003364:	4a848493          	addi	s1,s1,1192 # 80005808 <uart_tx_w>
    80003368:	0004b703          	ld	a4,0(s1)
    8000336c:	02078693          	addi	a3,a5,32
    80003370:	00050993          	mv	s3,a0
    80003374:	02e69c63          	bne	a3,a4,800033ac <uartputc+0x84>
    80003378:	00001097          	auipc	ra,0x1
    8000337c:	834080e7          	jalr	-1996(ra) # 80003bac <push_on>
    80003380:	00093783          	ld	a5,0(s2)
    80003384:	0004b703          	ld	a4,0(s1)
    80003388:	02078793          	addi	a5,a5,32
    8000338c:	00e79463          	bne	a5,a4,80003394 <uartputc+0x6c>
    80003390:	0000006f          	j	80003390 <uartputc+0x68>
    80003394:	00001097          	auipc	ra,0x1
    80003398:	88c080e7          	jalr	-1908(ra) # 80003c20 <pop_on>
    8000339c:	00093783          	ld	a5,0(s2)
    800033a0:	0004b703          	ld	a4,0(s1)
    800033a4:	02078693          	addi	a3,a5,32
    800033a8:	fce688e3          	beq	a3,a4,80003378 <uartputc+0x50>
    800033ac:	01f77693          	andi	a3,a4,31
    800033b0:	00003597          	auipc	a1,0x3
    800033b4:	6e058593          	addi	a1,a1,1760 # 80006a90 <uart_tx_buf>
    800033b8:	00d586b3          	add	a3,a1,a3
    800033bc:	00170713          	addi	a4,a4,1
    800033c0:	01368023          	sb	s3,0(a3)
    800033c4:	00e4b023          	sd	a4,0(s1)
    800033c8:	10000637          	lui	a2,0x10000
    800033cc:	02f71063          	bne	a4,a5,800033ec <uartputc+0xc4>
    800033d0:	0340006f          	j	80003404 <uartputc+0xdc>
    800033d4:	00074703          	lbu	a4,0(a4)
    800033d8:	00f93023          	sd	a5,0(s2)
    800033dc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800033e0:	00093783          	ld	a5,0(s2)
    800033e4:	0004b703          	ld	a4,0(s1)
    800033e8:	00f70e63          	beq	a4,a5,80003404 <uartputc+0xdc>
    800033ec:	00564683          	lbu	a3,5(a2)
    800033f0:	01f7f713          	andi	a4,a5,31
    800033f4:	00e58733          	add	a4,a1,a4
    800033f8:	0206f693          	andi	a3,a3,32
    800033fc:	00178793          	addi	a5,a5,1
    80003400:	fc069ae3          	bnez	a3,800033d4 <uartputc+0xac>
    80003404:	02813083          	ld	ra,40(sp)
    80003408:	02013403          	ld	s0,32(sp)
    8000340c:	01813483          	ld	s1,24(sp)
    80003410:	01013903          	ld	s2,16(sp)
    80003414:	00813983          	ld	s3,8(sp)
    80003418:	03010113          	addi	sp,sp,48
    8000341c:	00008067          	ret

0000000080003420 <uartputc_sync>:
    80003420:	ff010113          	addi	sp,sp,-16
    80003424:	00813423          	sd	s0,8(sp)
    80003428:	01010413          	addi	s0,sp,16
    8000342c:	00002717          	auipc	a4,0x2
    80003430:	3cc72703          	lw	a4,972(a4) # 800057f8 <panicked>
    80003434:	02071663          	bnez	a4,80003460 <uartputc_sync+0x40>
    80003438:	00050793          	mv	a5,a0
    8000343c:	100006b7          	lui	a3,0x10000
    80003440:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003444:	02077713          	andi	a4,a4,32
    80003448:	fe070ce3          	beqz	a4,80003440 <uartputc_sync+0x20>
    8000344c:	0ff7f793          	andi	a5,a5,255
    80003450:	00f68023          	sb	a5,0(a3)
    80003454:	00813403          	ld	s0,8(sp)
    80003458:	01010113          	addi	sp,sp,16
    8000345c:	00008067          	ret
    80003460:	0000006f          	j	80003460 <uartputc_sync+0x40>

0000000080003464 <uartstart>:
    80003464:	ff010113          	addi	sp,sp,-16
    80003468:	00813423          	sd	s0,8(sp)
    8000346c:	01010413          	addi	s0,sp,16
    80003470:	00002617          	auipc	a2,0x2
    80003474:	39060613          	addi	a2,a2,912 # 80005800 <uart_tx_r>
    80003478:	00002517          	auipc	a0,0x2
    8000347c:	39050513          	addi	a0,a0,912 # 80005808 <uart_tx_w>
    80003480:	00063783          	ld	a5,0(a2)
    80003484:	00053703          	ld	a4,0(a0)
    80003488:	04f70263          	beq	a4,a5,800034cc <uartstart+0x68>
    8000348c:	100005b7          	lui	a1,0x10000
    80003490:	00003817          	auipc	a6,0x3
    80003494:	60080813          	addi	a6,a6,1536 # 80006a90 <uart_tx_buf>
    80003498:	01c0006f          	j	800034b4 <uartstart+0x50>
    8000349c:	0006c703          	lbu	a4,0(a3)
    800034a0:	00f63023          	sd	a5,0(a2)
    800034a4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800034a8:	00063783          	ld	a5,0(a2)
    800034ac:	00053703          	ld	a4,0(a0)
    800034b0:	00f70e63          	beq	a4,a5,800034cc <uartstart+0x68>
    800034b4:	01f7f713          	andi	a4,a5,31
    800034b8:	00e806b3          	add	a3,a6,a4
    800034bc:	0055c703          	lbu	a4,5(a1)
    800034c0:	00178793          	addi	a5,a5,1
    800034c4:	02077713          	andi	a4,a4,32
    800034c8:	fc071ae3          	bnez	a4,8000349c <uartstart+0x38>
    800034cc:	00813403          	ld	s0,8(sp)
    800034d0:	01010113          	addi	sp,sp,16
    800034d4:	00008067          	ret

00000000800034d8 <uartgetc>:
    800034d8:	ff010113          	addi	sp,sp,-16
    800034dc:	00813423          	sd	s0,8(sp)
    800034e0:	01010413          	addi	s0,sp,16
    800034e4:	10000737          	lui	a4,0x10000
    800034e8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800034ec:	0017f793          	andi	a5,a5,1
    800034f0:	00078c63          	beqz	a5,80003508 <uartgetc+0x30>
    800034f4:	00074503          	lbu	a0,0(a4)
    800034f8:	0ff57513          	andi	a0,a0,255
    800034fc:	00813403          	ld	s0,8(sp)
    80003500:	01010113          	addi	sp,sp,16
    80003504:	00008067          	ret
    80003508:	fff00513          	li	a0,-1
    8000350c:	ff1ff06f          	j	800034fc <uartgetc+0x24>

0000000080003510 <uartintr>:
    80003510:	100007b7          	lui	a5,0x10000
    80003514:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003518:	0017f793          	andi	a5,a5,1
    8000351c:	0a078463          	beqz	a5,800035c4 <uartintr+0xb4>
    80003520:	fe010113          	addi	sp,sp,-32
    80003524:	00813823          	sd	s0,16(sp)
    80003528:	00913423          	sd	s1,8(sp)
    8000352c:	00113c23          	sd	ra,24(sp)
    80003530:	02010413          	addi	s0,sp,32
    80003534:	100004b7          	lui	s1,0x10000
    80003538:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000353c:	0ff57513          	andi	a0,a0,255
    80003540:	fffff097          	auipc	ra,0xfffff
    80003544:	534080e7          	jalr	1332(ra) # 80002a74 <consoleintr>
    80003548:	0054c783          	lbu	a5,5(s1)
    8000354c:	0017f793          	andi	a5,a5,1
    80003550:	fe0794e3          	bnez	a5,80003538 <uartintr+0x28>
    80003554:	00002617          	auipc	a2,0x2
    80003558:	2ac60613          	addi	a2,a2,684 # 80005800 <uart_tx_r>
    8000355c:	00002517          	auipc	a0,0x2
    80003560:	2ac50513          	addi	a0,a0,684 # 80005808 <uart_tx_w>
    80003564:	00063783          	ld	a5,0(a2)
    80003568:	00053703          	ld	a4,0(a0)
    8000356c:	04f70263          	beq	a4,a5,800035b0 <uartintr+0xa0>
    80003570:	100005b7          	lui	a1,0x10000
    80003574:	00003817          	auipc	a6,0x3
    80003578:	51c80813          	addi	a6,a6,1308 # 80006a90 <uart_tx_buf>
    8000357c:	01c0006f          	j	80003598 <uartintr+0x88>
    80003580:	0006c703          	lbu	a4,0(a3)
    80003584:	00f63023          	sd	a5,0(a2)
    80003588:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000358c:	00063783          	ld	a5,0(a2)
    80003590:	00053703          	ld	a4,0(a0)
    80003594:	00f70e63          	beq	a4,a5,800035b0 <uartintr+0xa0>
    80003598:	01f7f713          	andi	a4,a5,31
    8000359c:	00e806b3          	add	a3,a6,a4
    800035a0:	0055c703          	lbu	a4,5(a1)
    800035a4:	00178793          	addi	a5,a5,1
    800035a8:	02077713          	andi	a4,a4,32
    800035ac:	fc071ae3          	bnez	a4,80003580 <uartintr+0x70>
    800035b0:	01813083          	ld	ra,24(sp)
    800035b4:	01013403          	ld	s0,16(sp)
    800035b8:	00813483          	ld	s1,8(sp)
    800035bc:	02010113          	addi	sp,sp,32
    800035c0:	00008067          	ret
    800035c4:	00002617          	auipc	a2,0x2
    800035c8:	23c60613          	addi	a2,a2,572 # 80005800 <uart_tx_r>
    800035cc:	00002517          	auipc	a0,0x2
    800035d0:	23c50513          	addi	a0,a0,572 # 80005808 <uart_tx_w>
    800035d4:	00063783          	ld	a5,0(a2)
    800035d8:	00053703          	ld	a4,0(a0)
    800035dc:	04f70263          	beq	a4,a5,80003620 <uartintr+0x110>
    800035e0:	100005b7          	lui	a1,0x10000
    800035e4:	00003817          	auipc	a6,0x3
    800035e8:	4ac80813          	addi	a6,a6,1196 # 80006a90 <uart_tx_buf>
    800035ec:	01c0006f          	j	80003608 <uartintr+0xf8>
    800035f0:	0006c703          	lbu	a4,0(a3)
    800035f4:	00f63023          	sd	a5,0(a2)
    800035f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800035fc:	00063783          	ld	a5,0(a2)
    80003600:	00053703          	ld	a4,0(a0)
    80003604:	02f70063          	beq	a4,a5,80003624 <uartintr+0x114>
    80003608:	01f7f713          	andi	a4,a5,31
    8000360c:	00e806b3          	add	a3,a6,a4
    80003610:	0055c703          	lbu	a4,5(a1)
    80003614:	00178793          	addi	a5,a5,1
    80003618:	02077713          	andi	a4,a4,32
    8000361c:	fc071ae3          	bnez	a4,800035f0 <uartintr+0xe0>
    80003620:	00008067          	ret
    80003624:	00008067          	ret

0000000080003628 <kinit>:
    80003628:	fc010113          	addi	sp,sp,-64
    8000362c:	02913423          	sd	s1,40(sp)
    80003630:	fffff7b7          	lui	a5,0xfffff
    80003634:	00004497          	auipc	s1,0x4
    80003638:	47b48493          	addi	s1,s1,1147 # 80007aaf <end+0xfff>
    8000363c:	02813823          	sd	s0,48(sp)
    80003640:	01313c23          	sd	s3,24(sp)
    80003644:	00f4f4b3          	and	s1,s1,a5
    80003648:	02113c23          	sd	ra,56(sp)
    8000364c:	03213023          	sd	s2,32(sp)
    80003650:	01413823          	sd	s4,16(sp)
    80003654:	01513423          	sd	s5,8(sp)
    80003658:	04010413          	addi	s0,sp,64
    8000365c:	000017b7          	lui	a5,0x1
    80003660:	01100993          	li	s3,17
    80003664:	00f487b3          	add	a5,s1,a5
    80003668:	01b99993          	slli	s3,s3,0x1b
    8000366c:	06f9e063          	bltu	s3,a5,800036cc <kinit+0xa4>
    80003670:	00003a97          	auipc	s5,0x3
    80003674:	440a8a93          	addi	s5,s5,1088 # 80006ab0 <end>
    80003678:	0754ec63          	bltu	s1,s5,800036f0 <kinit+0xc8>
    8000367c:	0734fa63          	bgeu	s1,s3,800036f0 <kinit+0xc8>
    80003680:	00088a37          	lui	s4,0x88
    80003684:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003688:	00002917          	auipc	s2,0x2
    8000368c:	18890913          	addi	s2,s2,392 # 80005810 <kmem>
    80003690:	00ca1a13          	slli	s4,s4,0xc
    80003694:	0140006f          	j	800036a8 <kinit+0x80>
    80003698:	000017b7          	lui	a5,0x1
    8000369c:	00f484b3          	add	s1,s1,a5
    800036a0:	0554e863          	bltu	s1,s5,800036f0 <kinit+0xc8>
    800036a4:	0534f663          	bgeu	s1,s3,800036f0 <kinit+0xc8>
    800036a8:	00001637          	lui	a2,0x1
    800036ac:	00100593          	li	a1,1
    800036b0:	00048513          	mv	a0,s1
    800036b4:	00000097          	auipc	ra,0x0
    800036b8:	5e4080e7          	jalr	1508(ra) # 80003c98 <__memset>
    800036bc:	00093783          	ld	a5,0(s2)
    800036c0:	00f4b023          	sd	a5,0(s1)
    800036c4:	00993023          	sd	s1,0(s2)
    800036c8:	fd4498e3          	bne	s1,s4,80003698 <kinit+0x70>
    800036cc:	03813083          	ld	ra,56(sp)
    800036d0:	03013403          	ld	s0,48(sp)
    800036d4:	02813483          	ld	s1,40(sp)
    800036d8:	02013903          	ld	s2,32(sp)
    800036dc:	01813983          	ld	s3,24(sp)
    800036e0:	01013a03          	ld	s4,16(sp)
    800036e4:	00813a83          	ld	s5,8(sp)
    800036e8:	04010113          	addi	sp,sp,64
    800036ec:	00008067          	ret
    800036f0:	00002517          	auipc	a0,0x2
    800036f4:	af850513          	addi	a0,a0,-1288 # 800051e8 <digits+0x18>
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	4b4080e7          	jalr	1204(ra) # 80002bac <panic>

0000000080003700 <freerange>:
    80003700:	fc010113          	addi	sp,sp,-64
    80003704:	000017b7          	lui	a5,0x1
    80003708:	02913423          	sd	s1,40(sp)
    8000370c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003710:	009504b3          	add	s1,a0,s1
    80003714:	fffff537          	lui	a0,0xfffff
    80003718:	02813823          	sd	s0,48(sp)
    8000371c:	02113c23          	sd	ra,56(sp)
    80003720:	03213023          	sd	s2,32(sp)
    80003724:	01313c23          	sd	s3,24(sp)
    80003728:	01413823          	sd	s4,16(sp)
    8000372c:	01513423          	sd	s5,8(sp)
    80003730:	01613023          	sd	s6,0(sp)
    80003734:	04010413          	addi	s0,sp,64
    80003738:	00a4f4b3          	and	s1,s1,a0
    8000373c:	00f487b3          	add	a5,s1,a5
    80003740:	06f5e463          	bltu	a1,a5,800037a8 <freerange+0xa8>
    80003744:	00003a97          	auipc	s5,0x3
    80003748:	36ca8a93          	addi	s5,s5,876 # 80006ab0 <end>
    8000374c:	0954e263          	bltu	s1,s5,800037d0 <freerange+0xd0>
    80003750:	01100993          	li	s3,17
    80003754:	01b99993          	slli	s3,s3,0x1b
    80003758:	0734fc63          	bgeu	s1,s3,800037d0 <freerange+0xd0>
    8000375c:	00058a13          	mv	s4,a1
    80003760:	00002917          	auipc	s2,0x2
    80003764:	0b090913          	addi	s2,s2,176 # 80005810 <kmem>
    80003768:	00002b37          	lui	s6,0x2
    8000376c:	0140006f          	j	80003780 <freerange+0x80>
    80003770:	000017b7          	lui	a5,0x1
    80003774:	00f484b3          	add	s1,s1,a5
    80003778:	0554ec63          	bltu	s1,s5,800037d0 <freerange+0xd0>
    8000377c:	0534fa63          	bgeu	s1,s3,800037d0 <freerange+0xd0>
    80003780:	00001637          	lui	a2,0x1
    80003784:	00100593          	li	a1,1
    80003788:	00048513          	mv	a0,s1
    8000378c:	00000097          	auipc	ra,0x0
    80003790:	50c080e7          	jalr	1292(ra) # 80003c98 <__memset>
    80003794:	00093703          	ld	a4,0(s2)
    80003798:	016487b3          	add	a5,s1,s6
    8000379c:	00e4b023          	sd	a4,0(s1)
    800037a0:	00993023          	sd	s1,0(s2)
    800037a4:	fcfa76e3          	bgeu	s4,a5,80003770 <freerange+0x70>
    800037a8:	03813083          	ld	ra,56(sp)
    800037ac:	03013403          	ld	s0,48(sp)
    800037b0:	02813483          	ld	s1,40(sp)
    800037b4:	02013903          	ld	s2,32(sp)
    800037b8:	01813983          	ld	s3,24(sp)
    800037bc:	01013a03          	ld	s4,16(sp)
    800037c0:	00813a83          	ld	s5,8(sp)
    800037c4:	00013b03          	ld	s6,0(sp)
    800037c8:	04010113          	addi	sp,sp,64
    800037cc:	00008067          	ret
    800037d0:	00002517          	auipc	a0,0x2
    800037d4:	a1850513          	addi	a0,a0,-1512 # 800051e8 <digits+0x18>
    800037d8:	fffff097          	auipc	ra,0xfffff
    800037dc:	3d4080e7          	jalr	980(ra) # 80002bac <panic>

00000000800037e0 <kfree>:
    800037e0:	fe010113          	addi	sp,sp,-32
    800037e4:	00813823          	sd	s0,16(sp)
    800037e8:	00113c23          	sd	ra,24(sp)
    800037ec:	00913423          	sd	s1,8(sp)
    800037f0:	02010413          	addi	s0,sp,32
    800037f4:	03451793          	slli	a5,a0,0x34
    800037f8:	04079c63          	bnez	a5,80003850 <kfree+0x70>
    800037fc:	00003797          	auipc	a5,0x3
    80003800:	2b478793          	addi	a5,a5,692 # 80006ab0 <end>
    80003804:	00050493          	mv	s1,a0
    80003808:	04f56463          	bltu	a0,a5,80003850 <kfree+0x70>
    8000380c:	01100793          	li	a5,17
    80003810:	01b79793          	slli	a5,a5,0x1b
    80003814:	02f57e63          	bgeu	a0,a5,80003850 <kfree+0x70>
    80003818:	00001637          	lui	a2,0x1
    8000381c:	00100593          	li	a1,1
    80003820:	00000097          	auipc	ra,0x0
    80003824:	478080e7          	jalr	1144(ra) # 80003c98 <__memset>
    80003828:	00002797          	auipc	a5,0x2
    8000382c:	fe878793          	addi	a5,a5,-24 # 80005810 <kmem>
    80003830:	0007b703          	ld	a4,0(a5)
    80003834:	01813083          	ld	ra,24(sp)
    80003838:	01013403          	ld	s0,16(sp)
    8000383c:	00e4b023          	sd	a4,0(s1)
    80003840:	0097b023          	sd	s1,0(a5)
    80003844:	00813483          	ld	s1,8(sp)
    80003848:	02010113          	addi	sp,sp,32
    8000384c:	00008067          	ret
    80003850:	00002517          	auipc	a0,0x2
    80003854:	99850513          	addi	a0,a0,-1640 # 800051e8 <digits+0x18>
    80003858:	fffff097          	auipc	ra,0xfffff
    8000385c:	354080e7          	jalr	852(ra) # 80002bac <panic>

0000000080003860 <kalloc>:
    80003860:	fe010113          	addi	sp,sp,-32
    80003864:	00813823          	sd	s0,16(sp)
    80003868:	00913423          	sd	s1,8(sp)
    8000386c:	00113c23          	sd	ra,24(sp)
    80003870:	02010413          	addi	s0,sp,32
    80003874:	00002797          	auipc	a5,0x2
    80003878:	f9c78793          	addi	a5,a5,-100 # 80005810 <kmem>
    8000387c:	0007b483          	ld	s1,0(a5)
    80003880:	02048063          	beqz	s1,800038a0 <kalloc+0x40>
    80003884:	0004b703          	ld	a4,0(s1)
    80003888:	00001637          	lui	a2,0x1
    8000388c:	00500593          	li	a1,5
    80003890:	00048513          	mv	a0,s1
    80003894:	00e7b023          	sd	a4,0(a5)
    80003898:	00000097          	auipc	ra,0x0
    8000389c:	400080e7          	jalr	1024(ra) # 80003c98 <__memset>
    800038a0:	01813083          	ld	ra,24(sp)
    800038a4:	01013403          	ld	s0,16(sp)
    800038a8:	00048513          	mv	a0,s1
    800038ac:	00813483          	ld	s1,8(sp)
    800038b0:	02010113          	addi	sp,sp,32
    800038b4:	00008067          	ret

00000000800038b8 <initlock>:
    800038b8:	ff010113          	addi	sp,sp,-16
    800038bc:	00813423          	sd	s0,8(sp)
    800038c0:	01010413          	addi	s0,sp,16
    800038c4:	00813403          	ld	s0,8(sp)
    800038c8:	00b53423          	sd	a1,8(a0)
    800038cc:	00052023          	sw	zero,0(a0)
    800038d0:	00053823          	sd	zero,16(a0)
    800038d4:	01010113          	addi	sp,sp,16
    800038d8:	00008067          	ret

00000000800038dc <acquire>:
    800038dc:	fe010113          	addi	sp,sp,-32
    800038e0:	00813823          	sd	s0,16(sp)
    800038e4:	00913423          	sd	s1,8(sp)
    800038e8:	00113c23          	sd	ra,24(sp)
    800038ec:	01213023          	sd	s2,0(sp)
    800038f0:	02010413          	addi	s0,sp,32
    800038f4:	00050493          	mv	s1,a0
    800038f8:	10002973          	csrr	s2,sstatus
    800038fc:	100027f3          	csrr	a5,sstatus
    80003900:	ffd7f793          	andi	a5,a5,-3
    80003904:	10079073          	csrw	sstatus,a5
    80003908:	fffff097          	auipc	ra,0xfffff
    8000390c:	8ec080e7          	jalr	-1812(ra) # 800021f4 <mycpu>
    80003910:	07852783          	lw	a5,120(a0)
    80003914:	06078e63          	beqz	a5,80003990 <acquire+0xb4>
    80003918:	fffff097          	auipc	ra,0xfffff
    8000391c:	8dc080e7          	jalr	-1828(ra) # 800021f4 <mycpu>
    80003920:	07852783          	lw	a5,120(a0)
    80003924:	0004a703          	lw	a4,0(s1)
    80003928:	0017879b          	addiw	a5,a5,1
    8000392c:	06f52c23          	sw	a5,120(a0)
    80003930:	04071063          	bnez	a4,80003970 <acquire+0x94>
    80003934:	00100713          	li	a4,1
    80003938:	00070793          	mv	a5,a4
    8000393c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003940:	0007879b          	sext.w	a5,a5
    80003944:	fe079ae3          	bnez	a5,80003938 <acquire+0x5c>
    80003948:	0ff0000f          	fence
    8000394c:	fffff097          	auipc	ra,0xfffff
    80003950:	8a8080e7          	jalr	-1880(ra) # 800021f4 <mycpu>
    80003954:	01813083          	ld	ra,24(sp)
    80003958:	01013403          	ld	s0,16(sp)
    8000395c:	00a4b823          	sd	a0,16(s1)
    80003960:	00013903          	ld	s2,0(sp)
    80003964:	00813483          	ld	s1,8(sp)
    80003968:	02010113          	addi	sp,sp,32
    8000396c:	00008067          	ret
    80003970:	0104b903          	ld	s2,16(s1)
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	880080e7          	jalr	-1920(ra) # 800021f4 <mycpu>
    8000397c:	faa91ce3          	bne	s2,a0,80003934 <acquire+0x58>
    80003980:	00002517          	auipc	a0,0x2
    80003984:	87050513          	addi	a0,a0,-1936 # 800051f0 <digits+0x20>
    80003988:	fffff097          	auipc	ra,0xfffff
    8000398c:	224080e7          	jalr	548(ra) # 80002bac <panic>
    80003990:	00195913          	srli	s2,s2,0x1
    80003994:	fffff097          	auipc	ra,0xfffff
    80003998:	860080e7          	jalr	-1952(ra) # 800021f4 <mycpu>
    8000399c:	00197913          	andi	s2,s2,1
    800039a0:	07252e23          	sw	s2,124(a0)
    800039a4:	f75ff06f          	j	80003918 <acquire+0x3c>

00000000800039a8 <release>:
    800039a8:	fe010113          	addi	sp,sp,-32
    800039ac:	00813823          	sd	s0,16(sp)
    800039b0:	00113c23          	sd	ra,24(sp)
    800039b4:	00913423          	sd	s1,8(sp)
    800039b8:	01213023          	sd	s2,0(sp)
    800039bc:	02010413          	addi	s0,sp,32
    800039c0:	00052783          	lw	a5,0(a0)
    800039c4:	00079a63          	bnez	a5,800039d8 <release+0x30>
    800039c8:	00002517          	auipc	a0,0x2
    800039cc:	83050513          	addi	a0,a0,-2000 # 800051f8 <digits+0x28>
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	1dc080e7          	jalr	476(ra) # 80002bac <panic>
    800039d8:	01053903          	ld	s2,16(a0)
    800039dc:	00050493          	mv	s1,a0
    800039e0:	fffff097          	auipc	ra,0xfffff
    800039e4:	814080e7          	jalr	-2028(ra) # 800021f4 <mycpu>
    800039e8:	fea910e3          	bne	s2,a0,800039c8 <release+0x20>
    800039ec:	0004b823          	sd	zero,16(s1)
    800039f0:	0ff0000f          	fence
    800039f4:	0f50000f          	fence	iorw,ow
    800039f8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800039fc:	ffffe097          	auipc	ra,0xffffe
    80003a00:	7f8080e7          	jalr	2040(ra) # 800021f4 <mycpu>
    80003a04:	100027f3          	csrr	a5,sstatus
    80003a08:	0027f793          	andi	a5,a5,2
    80003a0c:	04079a63          	bnez	a5,80003a60 <release+0xb8>
    80003a10:	07852783          	lw	a5,120(a0)
    80003a14:	02f05e63          	blez	a5,80003a50 <release+0xa8>
    80003a18:	fff7871b          	addiw	a4,a5,-1
    80003a1c:	06e52c23          	sw	a4,120(a0)
    80003a20:	00071c63          	bnez	a4,80003a38 <release+0x90>
    80003a24:	07c52783          	lw	a5,124(a0)
    80003a28:	00078863          	beqz	a5,80003a38 <release+0x90>
    80003a2c:	100027f3          	csrr	a5,sstatus
    80003a30:	0027e793          	ori	a5,a5,2
    80003a34:	10079073          	csrw	sstatus,a5
    80003a38:	01813083          	ld	ra,24(sp)
    80003a3c:	01013403          	ld	s0,16(sp)
    80003a40:	00813483          	ld	s1,8(sp)
    80003a44:	00013903          	ld	s2,0(sp)
    80003a48:	02010113          	addi	sp,sp,32
    80003a4c:	00008067          	ret
    80003a50:	00001517          	auipc	a0,0x1
    80003a54:	7c850513          	addi	a0,a0,1992 # 80005218 <digits+0x48>
    80003a58:	fffff097          	auipc	ra,0xfffff
    80003a5c:	154080e7          	jalr	340(ra) # 80002bac <panic>
    80003a60:	00001517          	auipc	a0,0x1
    80003a64:	7a050513          	addi	a0,a0,1952 # 80005200 <digits+0x30>
    80003a68:	fffff097          	auipc	ra,0xfffff
    80003a6c:	144080e7          	jalr	324(ra) # 80002bac <panic>

0000000080003a70 <holding>:
    80003a70:	00052783          	lw	a5,0(a0)
    80003a74:	00079663          	bnez	a5,80003a80 <holding+0x10>
    80003a78:	00000513          	li	a0,0
    80003a7c:	00008067          	ret
    80003a80:	fe010113          	addi	sp,sp,-32
    80003a84:	00813823          	sd	s0,16(sp)
    80003a88:	00913423          	sd	s1,8(sp)
    80003a8c:	00113c23          	sd	ra,24(sp)
    80003a90:	02010413          	addi	s0,sp,32
    80003a94:	01053483          	ld	s1,16(a0)
    80003a98:	ffffe097          	auipc	ra,0xffffe
    80003a9c:	75c080e7          	jalr	1884(ra) # 800021f4 <mycpu>
    80003aa0:	01813083          	ld	ra,24(sp)
    80003aa4:	01013403          	ld	s0,16(sp)
    80003aa8:	40a48533          	sub	a0,s1,a0
    80003aac:	00153513          	seqz	a0,a0
    80003ab0:	00813483          	ld	s1,8(sp)
    80003ab4:	02010113          	addi	sp,sp,32
    80003ab8:	00008067          	ret

0000000080003abc <push_off>:
    80003abc:	fe010113          	addi	sp,sp,-32
    80003ac0:	00813823          	sd	s0,16(sp)
    80003ac4:	00113c23          	sd	ra,24(sp)
    80003ac8:	00913423          	sd	s1,8(sp)
    80003acc:	02010413          	addi	s0,sp,32
    80003ad0:	100024f3          	csrr	s1,sstatus
    80003ad4:	100027f3          	csrr	a5,sstatus
    80003ad8:	ffd7f793          	andi	a5,a5,-3
    80003adc:	10079073          	csrw	sstatus,a5
    80003ae0:	ffffe097          	auipc	ra,0xffffe
    80003ae4:	714080e7          	jalr	1812(ra) # 800021f4 <mycpu>
    80003ae8:	07852783          	lw	a5,120(a0)
    80003aec:	02078663          	beqz	a5,80003b18 <push_off+0x5c>
    80003af0:	ffffe097          	auipc	ra,0xffffe
    80003af4:	704080e7          	jalr	1796(ra) # 800021f4 <mycpu>
    80003af8:	07852783          	lw	a5,120(a0)
    80003afc:	01813083          	ld	ra,24(sp)
    80003b00:	01013403          	ld	s0,16(sp)
    80003b04:	0017879b          	addiw	a5,a5,1
    80003b08:	06f52c23          	sw	a5,120(a0)
    80003b0c:	00813483          	ld	s1,8(sp)
    80003b10:	02010113          	addi	sp,sp,32
    80003b14:	00008067          	ret
    80003b18:	0014d493          	srli	s1,s1,0x1
    80003b1c:	ffffe097          	auipc	ra,0xffffe
    80003b20:	6d8080e7          	jalr	1752(ra) # 800021f4 <mycpu>
    80003b24:	0014f493          	andi	s1,s1,1
    80003b28:	06952e23          	sw	s1,124(a0)
    80003b2c:	fc5ff06f          	j	80003af0 <push_off+0x34>

0000000080003b30 <pop_off>:
    80003b30:	ff010113          	addi	sp,sp,-16
    80003b34:	00813023          	sd	s0,0(sp)
    80003b38:	00113423          	sd	ra,8(sp)
    80003b3c:	01010413          	addi	s0,sp,16
    80003b40:	ffffe097          	auipc	ra,0xffffe
    80003b44:	6b4080e7          	jalr	1716(ra) # 800021f4 <mycpu>
    80003b48:	100027f3          	csrr	a5,sstatus
    80003b4c:	0027f793          	andi	a5,a5,2
    80003b50:	04079663          	bnez	a5,80003b9c <pop_off+0x6c>
    80003b54:	07852783          	lw	a5,120(a0)
    80003b58:	02f05a63          	blez	a5,80003b8c <pop_off+0x5c>
    80003b5c:	fff7871b          	addiw	a4,a5,-1
    80003b60:	06e52c23          	sw	a4,120(a0)
    80003b64:	00071c63          	bnez	a4,80003b7c <pop_off+0x4c>
    80003b68:	07c52783          	lw	a5,124(a0)
    80003b6c:	00078863          	beqz	a5,80003b7c <pop_off+0x4c>
    80003b70:	100027f3          	csrr	a5,sstatus
    80003b74:	0027e793          	ori	a5,a5,2
    80003b78:	10079073          	csrw	sstatus,a5
    80003b7c:	00813083          	ld	ra,8(sp)
    80003b80:	00013403          	ld	s0,0(sp)
    80003b84:	01010113          	addi	sp,sp,16
    80003b88:	00008067          	ret
    80003b8c:	00001517          	auipc	a0,0x1
    80003b90:	68c50513          	addi	a0,a0,1676 # 80005218 <digits+0x48>
    80003b94:	fffff097          	auipc	ra,0xfffff
    80003b98:	018080e7          	jalr	24(ra) # 80002bac <panic>
    80003b9c:	00001517          	auipc	a0,0x1
    80003ba0:	66450513          	addi	a0,a0,1636 # 80005200 <digits+0x30>
    80003ba4:	fffff097          	auipc	ra,0xfffff
    80003ba8:	008080e7          	jalr	8(ra) # 80002bac <panic>

0000000080003bac <push_on>:
    80003bac:	fe010113          	addi	sp,sp,-32
    80003bb0:	00813823          	sd	s0,16(sp)
    80003bb4:	00113c23          	sd	ra,24(sp)
    80003bb8:	00913423          	sd	s1,8(sp)
    80003bbc:	02010413          	addi	s0,sp,32
    80003bc0:	100024f3          	csrr	s1,sstatus
    80003bc4:	100027f3          	csrr	a5,sstatus
    80003bc8:	0027e793          	ori	a5,a5,2
    80003bcc:	10079073          	csrw	sstatus,a5
    80003bd0:	ffffe097          	auipc	ra,0xffffe
    80003bd4:	624080e7          	jalr	1572(ra) # 800021f4 <mycpu>
    80003bd8:	07852783          	lw	a5,120(a0)
    80003bdc:	02078663          	beqz	a5,80003c08 <push_on+0x5c>
    80003be0:	ffffe097          	auipc	ra,0xffffe
    80003be4:	614080e7          	jalr	1556(ra) # 800021f4 <mycpu>
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
    80003c10:	5e8080e7          	jalr	1512(ra) # 800021f4 <mycpu>
    80003c14:	0014f493          	andi	s1,s1,1
    80003c18:	06952e23          	sw	s1,124(a0)
    80003c1c:	fc5ff06f          	j	80003be0 <push_on+0x34>

0000000080003c20 <pop_on>:
    80003c20:	ff010113          	addi	sp,sp,-16
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	00113423          	sd	ra,8(sp)
    80003c2c:	01010413          	addi	s0,sp,16
    80003c30:	ffffe097          	auipc	ra,0xffffe
    80003c34:	5c4080e7          	jalr	1476(ra) # 800021f4 <mycpu>
    80003c38:	100027f3          	csrr	a5,sstatus
    80003c3c:	0027f793          	andi	a5,a5,2
    80003c40:	04078463          	beqz	a5,80003c88 <pop_on+0x68>
    80003c44:	07852783          	lw	a5,120(a0)
    80003c48:	02f05863          	blez	a5,80003c78 <pop_on+0x58>
    80003c4c:	fff7879b          	addiw	a5,a5,-1
    80003c50:	06f52c23          	sw	a5,120(a0)
    80003c54:	07853783          	ld	a5,120(a0)
    80003c58:	00079863          	bnez	a5,80003c68 <pop_on+0x48>
    80003c5c:	100027f3          	csrr	a5,sstatus
    80003c60:	ffd7f793          	andi	a5,a5,-3
    80003c64:	10079073          	csrw	sstatus,a5
    80003c68:	00813083          	ld	ra,8(sp)
    80003c6c:	00013403          	ld	s0,0(sp)
    80003c70:	01010113          	addi	sp,sp,16
    80003c74:	00008067          	ret
    80003c78:	00001517          	auipc	a0,0x1
    80003c7c:	5c850513          	addi	a0,a0,1480 # 80005240 <digits+0x70>
    80003c80:	fffff097          	auipc	ra,0xfffff
    80003c84:	f2c080e7          	jalr	-212(ra) # 80002bac <panic>
    80003c88:	00001517          	auipc	a0,0x1
    80003c8c:	59850513          	addi	a0,a0,1432 # 80005220 <digits+0x50>
    80003c90:	fffff097          	auipc	ra,0xfffff
    80003c94:	f1c080e7          	jalr	-228(ra) # 80002bac <panic>

0000000080003c98 <__memset>:
    80003c98:	ff010113          	addi	sp,sp,-16
    80003c9c:	00813423          	sd	s0,8(sp)
    80003ca0:	01010413          	addi	s0,sp,16
    80003ca4:	1a060e63          	beqz	a2,80003e60 <__memset+0x1c8>
    80003ca8:	40a007b3          	neg	a5,a0
    80003cac:	0077f793          	andi	a5,a5,7
    80003cb0:	00778693          	addi	a3,a5,7
    80003cb4:	00b00813          	li	a6,11
    80003cb8:	0ff5f593          	andi	a1,a1,255
    80003cbc:	fff6071b          	addiw	a4,a2,-1
    80003cc0:	1b06e663          	bltu	a3,a6,80003e6c <__memset+0x1d4>
    80003cc4:	1cd76463          	bltu	a4,a3,80003e8c <__memset+0x1f4>
    80003cc8:	1a078e63          	beqz	a5,80003e84 <__memset+0x1ec>
    80003ccc:	00b50023          	sb	a1,0(a0)
    80003cd0:	00100713          	li	a4,1
    80003cd4:	1ae78463          	beq	a5,a4,80003e7c <__memset+0x1e4>
    80003cd8:	00b500a3          	sb	a1,1(a0)
    80003cdc:	00200713          	li	a4,2
    80003ce0:	1ae78a63          	beq	a5,a4,80003e94 <__memset+0x1fc>
    80003ce4:	00b50123          	sb	a1,2(a0)
    80003ce8:	00300713          	li	a4,3
    80003cec:	18e78463          	beq	a5,a4,80003e74 <__memset+0x1dc>
    80003cf0:	00b501a3          	sb	a1,3(a0)
    80003cf4:	00400713          	li	a4,4
    80003cf8:	1ae78263          	beq	a5,a4,80003e9c <__memset+0x204>
    80003cfc:	00b50223          	sb	a1,4(a0)
    80003d00:	00500713          	li	a4,5
    80003d04:	1ae78063          	beq	a5,a4,80003ea4 <__memset+0x20c>
    80003d08:	00b502a3          	sb	a1,5(a0)
    80003d0c:	00700713          	li	a4,7
    80003d10:	18e79e63          	bne	a5,a4,80003eac <__memset+0x214>
    80003d14:	00b50323          	sb	a1,6(a0)
    80003d18:	00700e93          	li	t4,7
    80003d1c:	00859713          	slli	a4,a1,0x8
    80003d20:	00e5e733          	or	a4,a1,a4
    80003d24:	01059e13          	slli	t3,a1,0x10
    80003d28:	01c76e33          	or	t3,a4,t3
    80003d2c:	01859313          	slli	t1,a1,0x18
    80003d30:	006e6333          	or	t1,t3,t1
    80003d34:	02059893          	slli	a7,a1,0x20
    80003d38:	40f60e3b          	subw	t3,a2,a5
    80003d3c:	011368b3          	or	a7,t1,a7
    80003d40:	02859813          	slli	a6,a1,0x28
    80003d44:	0108e833          	or	a6,a7,a6
    80003d48:	03059693          	slli	a3,a1,0x30
    80003d4c:	003e589b          	srliw	a7,t3,0x3
    80003d50:	00d866b3          	or	a3,a6,a3
    80003d54:	03859713          	slli	a4,a1,0x38
    80003d58:	00389813          	slli	a6,a7,0x3
    80003d5c:	00f507b3          	add	a5,a0,a5
    80003d60:	00e6e733          	or	a4,a3,a4
    80003d64:	000e089b          	sext.w	a7,t3
    80003d68:	00f806b3          	add	a3,a6,a5
    80003d6c:	00e7b023          	sd	a4,0(a5)
    80003d70:	00878793          	addi	a5,a5,8
    80003d74:	fed79ce3          	bne	a5,a3,80003d6c <__memset+0xd4>
    80003d78:	ff8e7793          	andi	a5,t3,-8
    80003d7c:	0007871b          	sext.w	a4,a5
    80003d80:	01d787bb          	addw	a5,a5,t4
    80003d84:	0ce88e63          	beq	a7,a4,80003e60 <__memset+0x1c8>
    80003d88:	00f50733          	add	a4,a0,a5
    80003d8c:	00b70023          	sb	a1,0(a4)
    80003d90:	0017871b          	addiw	a4,a5,1
    80003d94:	0cc77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003d98:	00e50733          	add	a4,a0,a4
    80003d9c:	00b70023          	sb	a1,0(a4)
    80003da0:	0027871b          	addiw	a4,a5,2
    80003da4:	0ac77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003da8:	00e50733          	add	a4,a0,a4
    80003dac:	00b70023          	sb	a1,0(a4)
    80003db0:	0037871b          	addiw	a4,a5,3
    80003db4:	0ac77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003db8:	00e50733          	add	a4,a0,a4
    80003dbc:	00b70023          	sb	a1,0(a4)
    80003dc0:	0047871b          	addiw	a4,a5,4
    80003dc4:	08c77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003dc8:	00e50733          	add	a4,a0,a4
    80003dcc:	00b70023          	sb	a1,0(a4)
    80003dd0:	0057871b          	addiw	a4,a5,5
    80003dd4:	08c77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003dd8:	00e50733          	add	a4,a0,a4
    80003ddc:	00b70023          	sb	a1,0(a4)
    80003de0:	0067871b          	addiw	a4,a5,6
    80003de4:	06c77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003de8:	00e50733          	add	a4,a0,a4
    80003dec:	00b70023          	sb	a1,0(a4)
    80003df0:	0077871b          	addiw	a4,a5,7
    80003df4:	06c77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003df8:	00e50733          	add	a4,a0,a4
    80003dfc:	00b70023          	sb	a1,0(a4)
    80003e00:	0087871b          	addiw	a4,a5,8
    80003e04:	04c77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003e08:	00e50733          	add	a4,a0,a4
    80003e0c:	00b70023          	sb	a1,0(a4)
    80003e10:	0097871b          	addiw	a4,a5,9
    80003e14:	04c77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003e18:	00e50733          	add	a4,a0,a4
    80003e1c:	00b70023          	sb	a1,0(a4)
    80003e20:	00a7871b          	addiw	a4,a5,10
    80003e24:	02c77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003e28:	00e50733          	add	a4,a0,a4
    80003e2c:	00b70023          	sb	a1,0(a4)
    80003e30:	00b7871b          	addiw	a4,a5,11
    80003e34:	02c77663          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003e38:	00e50733          	add	a4,a0,a4
    80003e3c:	00b70023          	sb	a1,0(a4)
    80003e40:	00c7871b          	addiw	a4,a5,12
    80003e44:	00c77e63          	bgeu	a4,a2,80003e60 <__memset+0x1c8>
    80003e48:	00e50733          	add	a4,a0,a4
    80003e4c:	00b70023          	sb	a1,0(a4)
    80003e50:	00d7879b          	addiw	a5,a5,13
    80003e54:	00c7f663          	bgeu	a5,a2,80003e60 <__memset+0x1c8>
    80003e58:	00f507b3          	add	a5,a0,a5
    80003e5c:	00b78023          	sb	a1,0(a5)
    80003e60:	00813403          	ld	s0,8(sp)
    80003e64:	01010113          	addi	sp,sp,16
    80003e68:	00008067          	ret
    80003e6c:	00b00693          	li	a3,11
    80003e70:	e55ff06f          	j	80003cc4 <__memset+0x2c>
    80003e74:	00300e93          	li	t4,3
    80003e78:	ea5ff06f          	j	80003d1c <__memset+0x84>
    80003e7c:	00100e93          	li	t4,1
    80003e80:	e9dff06f          	j	80003d1c <__memset+0x84>
    80003e84:	00000e93          	li	t4,0
    80003e88:	e95ff06f          	j	80003d1c <__memset+0x84>
    80003e8c:	00000793          	li	a5,0
    80003e90:	ef9ff06f          	j	80003d88 <__memset+0xf0>
    80003e94:	00200e93          	li	t4,2
    80003e98:	e85ff06f          	j	80003d1c <__memset+0x84>
    80003e9c:	00400e93          	li	t4,4
    80003ea0:	e7dff06f          	j	80003d1c <__memset+0x84>
    80003ea4:	00500e93          	li	t4,5
    80003ea8:	e75ff06f          	j	80003d1c <__memset+0x84>
    80003eac:	00600e93          	li	t4,6
    80003eb0:	e6dff06f          	j	80003d1c <__memset+0x84>

0000000080003eb4 <__memmove>:
    80003eb4:	ff010113          	addi	sp,sp,-16
    80003eb8:	00813423          	sd	s0,8(sp)
    80003ebc:	01010413          	addi	s0,sp,16
    80003ec0:	0e060863          	beqz	a2,80003fb0 <__memmove+0xfc>
    80003ec4:	fff6069b          	addiw	a3,a2,-1
    80003ec8:	0006881b          	sext.w	a6,a3
    80003ecc:	0ea5e863          	bltu	a1,a0,80003fbc <__memmove+0x108>
    80003ed0:	00758713          	addi	a4,a1,7
    80003ed4:	00a5e7b3          	or	a5,a1,a0
    80003ed8:	40a70733          	sub	a4,a4,a0
    80003edc:	0077f793          	andi	a5,a5,7
    80003ee0:	00f73713          	sltiu	a4,a4,15
    80003ee4:	00174713          	xori	a4,a4,1
    80003ee8:	0017b793          	seqz	a5,a5
    80003eec:	00e7f7b3          	and	a5,a5,a4
    80003ef0:	10078863          	beqz	a5,80004000 <__memmove+0x14c>
    80003ef4:	00900793          	li	a5,9
    80003ef8:	1107f463          	bgeu	a5,a6,80004000 <__memmove+0x14c>
    80003efc:	0036581b          	srliw	a6,a2,0x3
    80003f00:	fff8081b          	addiw	a6,a6,-1
    80003f04:	02081813          	slli	a6,a6,0x20
    80003f08:	01d85893          	srli	a7,a6,0x1d
    80003f0c:	00858813          	addi	a6,a1,8
    80003f10:	00058793          	mv	a5,a1
    80003f14:	00050713          	mv	a4,a0
    80003f18:	01088833          	add	a6,a7,a6
    80003f1c:	0007b883          	ld	a7,0(a5)
    80003f20:	00878793          	addi	a5,a5,8
    80003f24:	00870713          	addi	a4,a4,8
    80003f28:	ff173c23          	sd	a7,-8(a4)
    80003f2c:	ff0798e3          	bne	a5,a6,80003f1c <__memmove+0x68>
    80003f30:	ff867713          	andi	a4,a2,-8
    80003f34:	02071793          	slli	a5,a4,0x20
    80003f38:	0207d793          	srli	a5,a5,0x20
    80003f3c:	00f585b3          	add	a1,a1,a5
    80003f40:	40e686bb          	subw	a3,a3,a4
    80003f44:	00f507b3          	add	a5,a0,a5
    80003f48:	06e60463          	beq	a2,a4,80003fb0 <__memmove+0xfc>
    80003f4c:	0005c703          	lbu	a4,0(a1)
    80003f50:	00e78023          	sb	a4,0(a5)
    80003f54:	04068e63          	beqz	a3,80003fb0 <__memmove+0xfc>
    80003f58:	0015c603          	lbu	a2,1(a1)
    80003f5c:	00100713          	li	a4,1
    80003f60:	00c780a3          	sb	a2,1(a5)
    80003f64:	04e68663          	beq	a3,a4,80003fb0 <__memmove+0xfc>
    80003f68:	0025c603          	lbu	a2,2(a1)
    80003f6c:	00200713          	li	a4,2
    80003f70:	00c78123          	sb	a2,2(a5)
    80003f74:	02e68e63          	beq	a3,a4,80003fb0 <__memmove+0xfc>
    80003f78:	0035c603          	lbu	a2,3(a1)
    80003f7c:	00300713          	li	a4,3
    80003f80:	00c781a3          	sb	a2,3(a5)
    80003f84:	02e68663          	beq	a3,a4,80003fb0 <__memmove+0xfc>
    80003f88:	0045c603          	lbu	a2,4(a1)
    80003f8c:	00400713          	li	a4,4
    80003f90:	00c78223          	sb	a2,4(a5)
    80003f94:	00e68e63          	beq	a3,a4,80003fb0 <__memmove+0xfc>
    80003f98:	0055c603          	lbu	a2,5(a1)
    80003f9c:	00500713          	li	a4,5
    80003fa0:	00c782a3          	sb	a2,5(a5)
    80003fa4:	00e68663          	beq	a3,a4,80003fb0 <__memmove+0xfc>
    80003fa8:	0065c703          	lbu	a4,6(a1)
    80003fac:	00e78323          	sb	a4,6(a5)
    80003fb0:	00813403          	ld	s0,8(sp)
    80003fb4:	01010113          	addi	sp,sp,16
    80003fb8:	00008067          	ret
    80003fbc:	02061713          	slli	a4,a2,0x20
    80003fc0:	02075713          	srli	a4,a4,0x20
    80003fc4:	00e587b3          	add	a5,a1,a4
    80003fc8:	f0f574e3          	bgeu	a0,a5,80003ed0 <__memmove+0x1c>
    80003fcc:	02069613          	slli	a2,a3,0x20
    80003fd0:	02065613          	srli	a2,a2,0x20
    80003fd4:	fff64613          	not	a2,a2
    80003fd8:	00e50733          	add	a4,a0,a4
    80003fdc:	00c78633          	add	a2,a5,a2
    80003fe0:	fff7c683          	lbu	a3,-1(a5)
    80003fe4:	fff78793          	addi	a5,a5,-1
    80003fe8:	fff70713          	addi	a4,a4,-1
    80003fec:	00d70023          	sb	a3,0(a4)
    80003ff0:	fec798e3          	bne	a5,a2,80003fe0 <__memmove+0x12c>
    80003ff4:	00813403          	ld	s0,8(sp)
    80003ff8:	01010113          	addi	sp,sp,16
    80003ffc:	00008067          	ret
    80004000:	02069713          	slli	a4,a3,0x20
    80004004:	02075713          	srli	a4,a4,0x20
    80004008:	00170713          	addi	a4,a4,1
    8000400c:	00e50733          	add	a4,a0,a4
    80004010:	00050793          	mv	a5,a0
    80004014:	0005c683          	lbu	a3,0(a1)
    80004018:	00178793          	addi	a5,a5,1
    8000401c:	00158593          	addi	a1,a1,1
    80004020:	fed78fa3          	sb	a3,-1(a5)
    80004024:	fee798e3          	bne	a5,a4,80004014 <__memmove+0x160>
    80004028:	f89ff06f          	j	80003fb0 <__memmove+0xfc>

000000008000402c <__putc>:
    8000402c:	fe010113          	addi	sp,sp,-32
    80004030:	00813823          	sd	s0,16(sp)
    80004034:	00113c23          	sd	ra,24(sp)
    80004038:	02010413          	addi	s0,sp,32
    8000403c:	00050793          	mv	a5,a0
    80004040:	fef40593          	addi	a1,s0,-17
    80004044:	00100613          	li	a2,1
    80004048:	00000513          	li	a0,0
    8000404c:	fef407a3          	sb	a5,-17(s0)
    80004050:	fffff097          	auipc	ra,0xfffff
    80004054:	b3c080e7          	jalr	-1220(ra) # 80002b8c <console_write>
    80004058:	01813083          	ld	ra,24(sp)
    8000405c:	01013403          	ld	s0,16(sp)
    80004060:	02010113          	addi	sp,sp,32
    80004064:	00008067          	ret

0000000080004068 <__getc>:
    80004068:	fe010113          	addi	sp,sp,-32
    8000406c:	00813823          	sd	s0,16(sp)
    80004070:	00113c23          	sd	ra,24(sp)
    80004074:	02010413          	addi	s0,sp,32
    80004078:	fe840593          	addi	a1,s0,-24
    8000407c:	00100613          	li	a2,1
    80004080:	00000513          	li	a0,0
    80004084:	fffff097          	auipc	ra,0xfffff
    80004088:	ae8080e7          	jalr	-1304(ra) # 80002b6c <console_read>
    8000408c:	fe844503          	lbu	a0,-24(s0)
    80004090:	01813083          	ld	ra,24(sp)
    80004094:	01013403          	ld	s0,16(sp)
    80004098:	02010113          	addi	sp,sp,32
    8000409c:	00008067          	ret

00000000800040a0 <console_handler>:
    800040a0:	fe010113          	addi	sp,sp,-32
    800040a4:	00813823          	sd	s0,16(sp)
    800040a8:	00113c23          	sd	ra,24(sp)
    800040ac:	00913423          	sd	s1,8(sp)
    800040b0:	02010413          	addi	s0,sp,32
    800040b4:	14202773          	csrr	a4,scause
    800040b8:	100027f3          	csrr	a5,sstatus
    800040bc:	0027f793          	andi	a5,a5,2
    800040c0:	06079e63          	bnez	a5,8000413c <console_handler+0x9c>
    800040c4:	00074c63          	bltz	a4,800040dc <console_handler+0x3c>
    800040c8:	01813083          	ld	ra,24(sp)
    800040cc:	01013403          	ld	s0,16(sp)
    800040d0:	00813483          	ld	s1,8(sp)
    800040d4:	02010113          	addi	sp,sp,32
    800040d8:	00008067          	ret
    800040dc:	0ff77713          	andi	a4,a4,255
    800040e0:	00900793          	li	a5,9
    800040e4:	fef712e3          	bne	a4,a5,800040c8 <console_handler+0x28>
    800040e8:	ffffe097          	auipc	ra,0xffffe
    800040ec:	6dc080e7          	jalr	1756(ra) # 800027c4 <plic_claim>
    800040f0:	00a00793          	li	a5,10
    800040f4:	00050493          	mv	s1,a0
    800040f8:	02f50c63          	beq	a0,a5,80004130 <console_handler+0x90>
    800040fc:	fc0506e3          	beqz	a0,800040c8 <console_handler+0x28>
    80004100:	00050593          	mv	a1,a0
    80004104:	00001517          	auipc	a0,0x1
    80004108:	04450513          	addi	a0,a0,68 # 80005148 <_ZZ12printIntegermE6digits+0xe0>
    8000410c:	fffff097          	auipc	ra,0xfffff
    80004110:	afc080e7          	jalr	-1284(ra) # 80002c08 <__printf>
    80004114:	01013403          	ld	s0,16(sp)
    80004118:	01813083          	ld	ra,24(sp)
    8000411c:	00048513          	mv	a0,s1
    80004120:	00813483          	ld	s1,8(sp)
    80004124:	02010113          	addi	sp,sp,32
    80004128:	ffffe317          	auipc	t1,0xffffe
    8000412c:	6d430067          	jr	1748(t1) # 800027fc <plic_complete>
    80004130:	fffff097          	auipc	ra,0xfffff
    80004134:	3e0080e7          	jalr	992(ra) # 80003510 <uartintr>
    80004138:	fddff06f          	j	80004114 <console_handler+0x74>
    8000413c:	00001517          	auipc	a0,0x1
    80004140:	10c50513          	addi	a0,a0,268 # 80005248 <digits+0x78>
    80004144:	fffff097          	auipc	ra,0xfffff
    80004148:	a68080e7          	jalr	-1432(ra) # 80002bac <panic>
	...
