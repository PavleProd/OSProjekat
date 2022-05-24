
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	f7813103          	ld	sp,-136(sp) # 80005f78 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	225020ef          	jal	ra,80002a40 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt>:
.extern interruptHandler
.extern _ZN3PCB10getContextEv // vraca running->registers offset 0: ssp offset 2*8 : sp
.align 4
.global interrupt
interrupt:
    addi sp, sp, -16
    80001000:	ff010113          	addi	sp,sp,-16
    sd x1, 0 * 8(sp) // cuvamo ra
    80001004:	00113023          	sd	ra,0(sp)
    sd x10, 1 * 8(sp) // cuvamo a0
    80001008:	00a13423          	sd	a0,8(sp)
    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    8000100c:	051000ef          	jal	ra,8000185c <_ZN3PCB10getContextEv>
    ld x1, 0 * 8(sp) // vracamo ra
    80001010:	00013083          	ld	ra,0(sp)
    sd x1, 1 * 8(a0) // cuvamo ra na PCB
    80001014:	00153423          	sd	ra,8(a0) # 1008 <_entry-0x7fffeff8>
    ld x1, 1 * 8(sp) // vracamo a0
    80001018:	00813083          	ld	ra,8(sp)
    addi sp, sp, 16
    8000101c:	01010113          	addi	sp,sp,16
    sd x1, 10 * 8(a0) // cuvamo a0 na PCB
    80001020:	04153823          	sd	ra,80(a0)

    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 // ra(x1) i a0(x10) smo vec sacuvali
    sd x\index, \index * 8(a0)
    .endr
    80001024:	00253823          	sd	sp,16(a0)
    80001028:	00353c23          	sd	gp,24(a0)
    8000102c:	02453023          	sd	tp,32(a0)
    80001030:	02553423          	sd	t0,40(a0)
    80001034:	02653823          	sd	t1,48(a0)
    80001038:	02753c23          	sd	t2,56(a0)
    8000103c:	04853023          	sd	s0,64(a0)
    80001040:	04953423          	sd	s1,72(a0)
    80001044:	04b53c23          	sd	a1,88(a0)
    80001048:	06c53023          	sd	a2,96(a0)
    8000104c:	06d53423          	sd	a3,104(a0)
    80001050:	06e53823          	sd	a4,112(a0)
    80001054:	06f53c23          	sd	a5,120(a0)
    80001058:	09053023          	sd	a6,128(a0)
    8000105c:	09153423          	sd	a7,136(a0)
    80001060:	09253823          	sd	s2,144(a0)
    80001064:	09353c23          	sd	s3,152(a0)
    80001068:	0b453023          	sd	s4,160(a0)
    8000106c:	0b553423          	sd	s5,168(a0)
    80001070:	0b653823          	sd	s6,176(a0)
    80001074:	0b753c23          	sd	s7,184(a0)
    80001078:	0d853023          	sd	s8,192(a0)
    8000107c:	0d953423          	sd	s9,200(a0)
    80001080:	0da53823          	sd	s10,208(a0)
    80001084:	0db53c23          	sd	s11,216(a0)
    80001088:	0fc53023          	sd	t3,224(a0)
    8000108c:	0fd53423          	sd	t4,232(a0)
    80001090:	0fe53823          	sd	t5,240(a0)
    80001094:	0ff53c23          	sd	t6,248(a0)

    ld sp, 0 * 8(a0) // sp = ssp
    80001098:	00053103          	ld	sp,0(a0)

    call interruptHandler
    8000109c:	2b4000ef          	jal	ra,80001350 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	7bc000ef          	jal	ra,8000185c <_ZN3PCB10getContextEv>

    sd sp, 0 * 8(a0) // cuvamo ssp
    800010a4:	00253023          	sd	sp,0(a0)

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 // a0 ne cuvamo jer cemo ga rucno skinuti
    ld x\index, \index * 8(a0)
    .endr
    800010a8:	00853083          	ld	ra,8(a0)
    800010ac:	01053103          	ld	sp,16(a0)
    800010b0:	01853183          	ld	gp,24(a0)
    800010b4:	02053203          	ld	tp,32(a0)
    800010b8:	02853283          	ld	t0,40(a0)
    800010bc:	03053303          	ld	t1,48(a0)
    800010c0:	03853383          	ld	t2,56(a0)
    800010c4:	04053403          	ld	s0,64(a0)
    800010c8:	04853483          	ld	s1,72(a0)
    800010cc:	05853583          	ld	a1,88(a0)
    800010d0:	06053603          	ld	a2,96(a0)
    800010d4:	06853683          	ld	a3,104(a0)
    800010d8:	07053703          	ld	a4,112(a0)
    800010dc:	07853783          	ld	a5,120(a0)
    800010e0:	08053803          	ld	a6,128(a0)
    800010e4:	08853883          	ld	a7,136(a0)
    800010e8:	09053903          	ld	s2,144(a0)
    800010ec:	09853983          	ld	s3,152(a0)
    800010f0:	0a053a03          	ld	s4,160(a0)
    800010f4:	0a853a83          	ld	s5,168(a0)
    800010f8:	0b053b03          	ld	s6,176(a0)
    800010fc:	0b853b83          	ld	s7,184(a0)
    80001100:	0c053c03          	ld	s8,192(a0)
    80001104:	0c853c83          	ld	s9,200(a0)
    80001108:	0d053d03          	ld	s10,208(a0)
    8000110c:	0d853d83          	ld	s11,216(a0)
    80001110:	0e053e03          	ld	t3,224(a0)
    80001114:	0e853e83          	ld	t4,232(a0)
    80001118:	0f053f03          	ld	t5,240(a0)
    8000111c:	0f853f83          	ld	t6,248(a0)

    ld a0, 10 * 8(a0) // skidamo a0
    80001120:	05053503          	ld	a0,80(a0)

    80001124:	10200073          	sret

0000000080001128 <_ZN3PCB14switchContext1EPmS0_>:
.global _ZN3PCB14switchContext1EPmS0_ // switchContext kada se prvi put poziva, skidamo korisnicki stek
_ZN3PCB14switchContext1EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    80001128:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    8000112c:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    80001130:	1005b083          	ld	ra,256(a1)
    ld sp, 2 * 8(a1)
    80001134:	0105b103          	ld	sp,16(a1)

    ret
    80001138:	00008067          	ret

000000008000113c <_ZN3PCB14switchContext2EPmS0_>:

.global _ZN3PCB14switchContext2EPmS0_ // switchContext kada se ne poziva prvi put, skidamo sistemski stek
_ZN3PCB14switchContext2EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    8000113c:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    80001140:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    80001144:	1005b083          	ld	ra,256(a1)
    ld sp, 0 * 8(a1)
    80001148:	0005b103          	ld	sp,0(a1)

    8000114c:	00008067          	ret

0000000080001150 <_Z13callInterruptm>:
#include "../h/PCB.h"
#include "../h/console.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt(size_t volatile code) {
    80001150:	fe010113          	addi	sp,sp,-32
    80001154:	00813c23          	sd	s0,24(sp)
    80001158:	02010413          	addi	s0,sp,32
    8000115c:	fea43423          	sd	a0,-24(s0)
    void* res;
    asm volatile("ecall");
    80001160:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001164:	00050513          	mv	a0,a0
    return res;
}
    80001168:	01813403          	ld	s0,24(sp)
    8000116c:	02010113          	addi	sp,sp,32
    80001170:	00008067          	ret

0000000080001174 <_Z9mem_allocm>:

// a0 code a1 size
void* mem_alloc(size_t size) {
    80001174:	ff010113          	addi	sp,sp,-16
    80001178:	00113423          	sd	ra,8(sp)
    8000117c:	00813023          	sd	s0,0(sp)
    80001180:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001184:	00655793          	srli	a5,a0,0x6
    80001188:	03f57513          	andi	a0,a0,63
    8000118c:	00a03533          	snez	a0,a0
    80001190:	00a78533          	add	a0,a5,a0
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    80001194:	00050593          	mv	a1,a0

    return (void*)callInterrupt(code);
    80001198:	00100513          	li	a0,1
    8000119c:	00000097          	auipc	ra,0x0
    800011a0:	fb4080e7          	jalr	-76(ra) # 80001150 <_Z13callInterruptm>
}
    800011a4:	00813083          	ld	ra,8(sp)
    800011a8:	00013403          	ld	s0,0(sp)
    800011ac:	01010113          	addi	sp,sp,16
    800011b0:	00008067          	ret

00000000800011b4 <_Z8mem_freePv>:

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    800011b4:	ff010113          	addi	sp,sp,-16
    800011b8:	00113423          	sd	ra,8(sp)
    800011bc:	00813023          	sd	s0,0(sp)
    800011c0:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    800011c4:	00050593          	mv	a1,a0

    return (size_t)(callInterrupt(code));
    800011c8:	00200513          	li	a0,2
    800011cc:	00000097          	auipc	ra,0x0
    800011d0:	f84080e7          	jalr	-124(ra) # 80001150 <_Z13callInterruptm>
}
    800011d4:	0005051b          	sext.w	a0,a0
    800011d8:	00813083          	ld	ra,8(sp)
    800011dc:	00013403          	ld	s0,0(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret

00000000800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800011e8:	ff010113          	addi	sp,sp,-16
    800011ec:	00113423          	sd	ra,8(sp)
    800011f0:	00813023          	sd	s0,0(sp)
    800011f4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    800011f8:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    800011fc:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
    80001200:	00050713          	mv	a4,a0

    size_t* stack = (size_t*)mem_alloc(sizeof(size_t)*DEFAULT_STACK_SIZE); // pravimo stack procesa
    80001204:	00008537          	lui	a0,0x8
    80001208:	00000097          	auipc	ra,0x0
    8000120c:	f6c080e7          	jalr	-148(ra) # 80001174 <_Z9mem_allocm>
    if(stack == nullptr) return -1;
    80001210:	02050a63          	beqz	a0,80001244 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x5c>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    80001214:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001218:	00050713          	mv	a4,a0

    handle = (thread_t*)(callInterrupt(code)); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    8000121c:	01100513          	li	a0,17
    80001220:	00000097          	auipc	ra,0x0
    80001224:	f30080e7          	jalr	-208(ra) # 80001150 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001228:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    8000122c:	02078063          	beqz	a5,8000124c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x64>
        return -1;
    }
    return 0;
    80001230:	00000513          	li	a0,0
}
    80001234:	00813083          	ld	ra,8(sp)
    80001238:	00013403          	ld	s0,0(sp)
    8000123c:	01010113          	addi	sp,sp,16
    80001240:	00008067          	ret
    if(stack == nullptr) return -1;
    80001244:	fff00513          	li	a0,-1
    80001248:	fedff06f          	j	80001234 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>
        return -1;
    8000124c:	fff00513          	li	a0,-1
    80001250:	fe5ff06f          	j	80001234 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>

0000000080001254 <_Z15thread_dispatchv>:
    int res = thread_create_only(handle, startRoutine, arg);
    thread_start(handle);
    return res;
}

void thread_dispatch () {
    80001254:	ff010113          	addi	sp,sp,-16
    80001258:	00113423          	sd	ra,8(sp)
    8000125c:	00813023          	sd	s0,0(sp)
    80001260:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    callInterrupt(code);
    80001264:	01300513          	li	a0,19
    80001268:	00000097          	auipc	ra,0x0
    8000126c:	ee8080e7          	jalr	-280(ra) # 80001150 <_Z13callInterruptm>
}
    80001270:	00813083          	ld	ra,8(sp)
    80001274:	00013403          	ld	s0,0(sp)
    80001278:	01010113          	addi	sp,sp,16
    8000127c:	00008067          	ret

0000000080001280 <_Z11thread_exitv>:

int thread_exit () {
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00113423          	sd	ra,8(sp)
    80001288:	00813023          	sd	s0,0(sp)
    8000128c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_exit;
    return (size_t)(callInterrupt(code));
    80001290:	01200513          	li	a0,18
    80001294:	00000097          	auipc	ra,0x0
    80001298:	ebc080e7          	jalr	-324(ra) # 80001150 <_Z13callInterruptm>
}
    8000129c:	0005051b          	sext.w	a0,a0
    800012a0:	00813083          	ld	ra,8(sp)
    800012a4:	00013403          	ld	s0,0(sp)
    800012a8:	01010113          	addi	sp,sp,16
    800012ac:	00008067          	ret

00000000800012b0 <_Z12thread_startPP3PCB>:

void thread_start(thread_t* handle) {
    800012b0:	ff010113          	addi	sp,sp,-16
    800012b4:	00113423          	sd	ra,8(sp)
    800012b8:	00813023          	sd	s0,0(sp)
    800012bc:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a1, a0"); // a1 = handle
    800012c0:	00050593          	mv	a1,a0
    callInterrupt(code);
    800012c4:	01400513          	li	a0,20
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	e88080e7          	jalr	-376(ra) # 80001150 <_Z13callInterruptm>
}
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_Z13thread_createPP3PCBPFvPvES2_>:
int thread_create(thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800012e0:	fe010113          	addi	sp,sp,-32
    800012e4:	00113c23          	sd	ra,24(sp)
    800012e8:	00813823          	sd	s0,16(sp)
    800012ec:	00913423          	sd	s1,8(sp)
    800012f0:	01213023          	sd	s2,0(sp)
    800012f4:	02010413          	addi	s0,sp,32
    800012f8:	00050913          	mv	s2,a0
    int res = thread_create_only(handle, startRoutine, arg);
    800012fc:	00000097          	auipc	ra,0x0
    80001300:	eec080e7          	jalr	-276(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    80001304:	00050493          	mv	s1,a0
    thread_start(handle);
    80001308:	00090513          	mv	a0,s2
    8000130c:	00000097          	auipc	ra,0x0
    80001310:	fa4080e7          	jalr	-92(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    80001314:	00048513          	mv	a0,s1
    80001318:	01813083          	ld	ra,24(sp)
    8000131c:	01013403          	ld	s0,16(sp)
    80001320:	00813483          	ld	s1,8(sp)
    80001324:	00013903          	ld	s2,0(sp)
    80001328:	02010113          	addi	sp,sp,32
    8000132c:	00008067          	ret

0000000080001330 <_ZN6Kernel10popSppSpieEv>:
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"
#include "../h/Scheduler.h"

void Kernel::popSppSpie() {
    80001330:	ff010113          	addi	sp,sp,-16
    80001334:	00813423          	sd	s0,8(sp)
    80001338:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    8000133c:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001340:	10200073          	sret
}
    80001344:	00813403          	ld	s0,8(sp)
    80001348:	01010113          	addi	sp,sp,16
    8000134c:	00008067          	ret

0000000080001350 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001350:	fa010113          	addi	sp,sp,-96
    80001354:	04113c23          	sd	ra,88(sp)
    80001358:	04813823          	sd	s0,80(sp)
    8000135c:	04913423          	sd	s1,72(sp)
    80001360:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001364:	142027f3          	csrr	a5,scause
    80001368:	fcf43023          	sd	a5,-64(s0)
        return scause;
    8000136c:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001370:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001374:	141027f3          	csrr	a5,sepc
    80001378:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    8000137c:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80001380:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001384:	100027f3          	csrr	a5,sstatus
    80001388:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    8000138c:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001390:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001394:	fd843703          	ld	a4,-40(s0)
    80001398:	00900793          	li	a5,9
    8000139c:	04f70263          	beq	a4,a5,800013e0 <interruptHandler+0x90>
    800013a0:	fd843703          	ld	a4,-40(s0)
    800013a4:	00800793          	li	a5,8
    800013a8:	02f70c63          	beq	a4,a5,800013e0 <interruptHandler+0x90>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800013ac:	fd843703          	ld	a4,-40(s0)
    800013b0:	fff00793          	li	a5,-1
    800013b4:	03f79793          	slli	a5,a5,0x3f
    800013b8:	00178793          	addi	a5,a5,1
    800013bc:	18f70c63          	beq	a4,a5,80001554 <interruptHandler+0x204>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800013c0:	fd843703          	ld	a4,-40(s0)
    800013c4:	fff00793          	li	a5,-1
    800013c8:	03f79793          	slli	a5,a5,0x3f
    800013cc:	00978793          	addi	a5,a5,9
    800013d0:	1ef70063          	beq	a4,a5,800015b0 <interruptHandler+0x260>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800013d4:	00001097          	auipc	ra,0x1
    800013d8:	5b4080e7          	jalr	1460(ra) # 80002988 <_Z10printErrorv>
    800013dc:	0840006f          	j	80001460 <interruptHandler+0x110>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800013e0:	fd043783          	ld	a5,-48(s0)
    800013e4:	00478793          	addi	a5,a5,4
    800013e8:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800013ec:	00005797          	auipc	a5,0x5
    800013f0:	b947b783          	ld	a5,-1132(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013f4:	0007b683          	ld	a3,0(a5)
    800013f8:	0186b703          	ld	a4,24(a3)
    800013fc:	05073783          	ld	a5,80(a4)
    80001400:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    80001404:	fa843783          	ld	a5,-88(s0)
    80001408:	01400613          	li	a2,20
    8000140c:	12f66e63          	bltu	a2,a5,80001548 <interruptHandler+0x1f8>
    80001410:	00279793          	slli	a5,a5,0x2
    80001414:	00004617          	auipc	a2,0x4
    80001418:	c0c60613          	addi	a2,a2,-1012 # 80005020 <CONSOLE_STATUS+0x10>
    8000141c:	00c787b3          	add	a5,a5,a2
    80001420:	0007a783          	lw	a5,0(a5)
    80001424:	00c787b3          	add	a5,a5,a2
    80001428:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    8000142c:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001430:	00651513          	slli	a0,a0,0x6
    80001434:	00001097          	auipc	ra,0x1
    80001438:	118080e7          	jalr	280(ra) # 8000254c <_ZN15MemoryAllocator9mem_allocEm>
    8000143c:	00005797          	auipc	a5,0x5
    80001440:	b447b783          	ld	a5,-1212(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001444:	0007b783          	ld	a5,0(a5)
    80001448:	0187b783          	ld	a5,24(a5)
    8000144c:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001450:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001454:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001458:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000145c:	10079073          	csrw	sstatus,a5
    }

}
    80001460:	05813083          	ld	ra,88(sp)
    80001464:	05013403          	ld	s0,80(sp)
    80001468:	04813483          	ld	s1,72(sp)
    8000146c:	06010113          	addi	sp,sp,96
    80001470:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001474:	05873503          	ld	a0,88(a4)
    80001478:	00001097          	auipc	ra,0x1
    8000147c:	238080e7          	jalr	568(ra) # 800026b0 <_ZN15MemoryAllocator8mem_freeEPv>
    80001480:	00005797          	auipc	a5,0x5
    80001484:	b007b783          	ld	a5,-1280(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001488:	0007b783          	ld	a5,0(a5)
    8000148c:	0187b783          	ld	a5,24(a5)
    80001490:	04a7b823          	sd	a0,80(a5)
                break;
    80001494:	fbdff06f          	j	80001450 <interruptHandler+0x100>
                PCB::timeSliceCounter = 0;
    80001498:	00005797          	auipc	a5,0x5
    8000149c:	ad87b783          	ld	a5,-1320(a5) # 80005f70 <_GLOBAL_OFFSET_TABLE_+0x10>
    800014a0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800014a4:	00000097          	auipc	ra,0x0
    800014a8:	184080e7          	jalr	388(ra) # 80001628 <_ZN3PCB8dispatchEv>
                break;
    800014ac:	fa5ff06f          	j	80001450 <interruptHandler+0x100>
                PCB::running->finished = true;
    800014b0:	00100793          	li	a5,1
    800014b4:	02f68423          	sb	a5,40(a3)
                PCB::timeSliceCounter = 0;
    800014b8:	00005797          	auipc	a5,0x5
    800014bc:	ab87b783          	ld	a5,-1352(a5) # 80005f70 <_GLOBAL_OFFSET_TABLE_+0x10>
    800014c0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800014c4:	00000097          	auipc	ra,0x0
    800014c8:	164080e7          	jalr	356(ra) # 80001628 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800014cc:	00005797          	auipc	a5,0x5
    800014d0:	ab47b783          	ld	a5,-1356(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    800014d4:	0007b783          	ld	a5,0(a5)
    800014d8:	0187b783          	ld	a5,24(a5)
    800014dc:	0407b823          	sd	zero,80(a5)
                break;
    800014e0:	f71ff06f          	j	80001450 <interruptHandler+0x100>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800014e4:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800014e8:	0007b503          	ld	a0,0(a5)
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	394080e7          	jalr	916(ra) # 80001880 <_ZN9Scheduler3putEP3PCB>
                break;
    800014f4:	f5dff06f          	j	80001450 <interruptHandler+0x100>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800014f8:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800014fc:	06873583          	ld	a1,104(a4)
    80001500:	06073503          	ld	a0,96(a4)
    80001504:	00000097          	auipc	ra,0x0
    80001508:	2d0080e7          	jalr	720(ra) # 800017d4 <_ZN3PCB14createProccessEPFvvEPv>
    8000150c:	00a4b023          	sd	a0,0(s1)
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001510:	00005797          	auipc	a5,0x5
    80001514:	a707b783          	ld	a5,-1424(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001518:	0007b703          	ld	a4,0(a5)
    8000151c:	01873783          	ld	a5,24(a4)
    80001520:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001524:	00f53423          	sd	a5,8(a0)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001528:	000086b7          	lui	a3,0x8
    8000152c:	00d787b3          	add	a5,a5,a3
    80001530:	0004b683          	ld	a3,0(s1)
    80001534:	0186b683          	ld	a3,24(a3) # 8018 <_entry-0x7fff7fe8>
    80001538:	00f6b823          	sd	a5,16(a3)
                PCB::running->registers[10] = (size_t)handle;
    8000153c:	01873783          	ld	a5,24(a4)
    80001540:	0497b823          	sd	s1,80(a5)
                break;
    80001544:	f0dff06f          	j	80001450 <interruptHandler+0x100>
                printError();
    80001548:	00001097          	auipc	ra,0x1
    8000154c:	440080e7          	jalr	1088(ra) # 80002988 <_Z10printErrorv>
                break;
    80001550:	f01ff06f          	j	80001450 <interruptHandler+0x100>
        PCB::timeSliceCounter++;
    80001554:	00005717          	auipc	a4,0x5
    80001558:	a1c73703          	ld	a4,-1508(a4) # 80005f70 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000155c:	00073783          	ld	a5,0(a4)
    80001560:	00178793          	addi	a5,a5,1
    80001564:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001568:	00005717          	auipc	a4,0x5
    8000156c:	a1873703          	ld	a4,-1512(a4) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001570:	00073703          	ld	a4,0(a4)
    80001574:	03873703          	ld	a4,56(a4)
    80001578:	00e7f863          	bgeu	a5,a4,80001588 <interruptHandler+0x238>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000157c:	00200793          	li	a5,2
    80001580:	1447b073          	csrc	sip,a5
    }
    80001584:	eddff06f          	j	80001460 <interruptHandler+0x110>
            PCB::timeSliceCounter = 0;
    80001588:	00005797          	auipc	a5,0x5
    8000158c:	9e87b783          	ld	a5,-1560(a5) # 80005f70 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001590:	0007b023          	sd	zero,0(a5)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001594:	00000097          	auipc	ra,0x0
    80001598:	094080e7          	jalr	148(ra) # 80001628 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    8000159c:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015a0:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800015a4:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015a8:	10079073          	csrw	sstatus,a5
    }
    800015ac:	fd1ff06f          	j	8000157c <interruptHandler+0x22c>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    800015b0:	00003097          	auipc	ra,0x3
    800015b4:	5c0080e7          	jalr	1472(ra) # 80004b70 <console_handler>
    800015b8:	ea9ff06f          	j	80001460 <interruptHandler+0x110>

00000000800015bc <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    800015bc:	ff010113          	addi	sp,sp,-16
    800015c0:	00113423          	sd	ra,8(sp)
    800015c4:	00813023          	sd	s0,0(sp)
    800015c8:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	d64080e7          	jalr	-668(ra) # 80001330 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    800015d4:	00005797          	auipc	a5,0x5
    800015d8:	a0c7b783          	ld	a5,-1524(a5) # 80005fe0 <_ZN3PCB7runningE>
    800015dc:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    800015e0:	00070513          	mv	a0,a4
    running->main();
    800015e4:	0207b783          	ld	a5,32(a5)
    800015e8:	000780e7          	jalr	a5
    thread_exit();
    800015ec:	00000097          	auipc	ra,0x0
    800015f0:	c94080e7          	jalr	-876(ra) # 80001280 <_Z11thread_exitv>
}
    800015f4:	00813083          	ld	ra,8(sp)
    800015f8:	00013403          	ld	s0,0(sp)
    800015fc:	01010113          	addi	sp,sp,16
    80001600:	00008067          	ret

0000000080001604 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001604:	ff010113          	addi	sp,sp,-16
    80001608:	00813423          	sd	s0,8(sp)
    8000160c:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001610:	01300793          	li	a5,19
    80001614:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001618:	00000073          	ecall
}
    8000161c:	00813403          	ld	s0,8(sp)
    80001620:	01010113          	addi	sp,sp,16
    80001624:	00008067          	ret

0000000080001628 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001628:	fe010113          	addi	sp,sp,-32
    8000162c:	00113c23          	sd	ra,24(sp)
    80001630:	00813823          	sd	s0,16(sp)
    80001634:	00913423          	sd	s1,8(sp)
    80001638:	02010413          	addi	s0,sp,32
    PCB* old = running;
    8000163c:	00005497          	auipc	s1,0x5
    80001640:	9a44b483          	ld	s1,-1628(s1) # 80005fe0 <_ZN3PCB7runningE>
friend void interruptHandler();
friend class Kernel;
public:
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    80001644:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()) {
    80001648:	04078263          	beqz	a5,8000168c <_ZN3PCB8dispatchEv+0x64>
    running = Scheduler::get();
    8000164c:	00000097          	auipc	ra,0x0
    80001650:	288080e7          	jalr	648(ra) # 800018d4 <_ZN9Scheduler3getEv>
    80001654:	00005797          	auipc	a5,0x5
    80001658:	98a7b623          	sd	a0,-1652(a5) # 80005fe0 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    8000165c:	04054783          	lbu	a5,64(a0)
    80001660:	02078e63          	beqz	a5,8000169c <_ZN3PCB8dispatchEv+0x74>
        PCB::running->firstCall = false;
    80001664:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    80001668:	01853583          	ld	a1,24(a0)
    8000166c:	0184b503          	ld	a0,24(s1)
    80001670:	00000097          	auipc	ra,0x0
    80001674:	ab8080e7          	jalr	-1352(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001678:	01813083          	ld	ra,24(sp)
    8000167c:	01013403          	ld	s0,16(sp)
    80001680:	00813483          	ld	s1,8(sp)
    80001684:	02010113          	addi	sp,sp,32
    80001688:	00008067          	ret
        Scheduler::put(old);
    8000168c:	00048513          	mv	a0,s1
    80001690:	00000097          	auipc	ra,0x0
    80001694:	1f0080e7          	jalr	496(ra) # 80001880 <_ZN9Scheduler3putEP3PCB>
    80001698:	fb5ff06f          	j	8000164c <_ZN3PCB8dispatchEv+0x24>
        switchContext2(old->registers, running->registers);
    8000169c:	01853583          	ld	a1,24(a0)
    800016a0:	0184b503          	ld	a0,24(s1)
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	a98080e7          	jalr	-1384(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    800016ac:	fcdff06f          	j	80001678 <_ZN3PCB8dispatchEv+0x50>

00000000800016b0 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    800016b0:	fe010113          	addi	sp,sp,-32
    800016b4:	00113c23          	sd	ra,24(sp)
    800016b8:	00813823          	sd	s0,16(sp)
    800016bc:	00913423          	sd	s1,8(sp)
    800016c0:	02010413          	addi	s0,sp,32
    800016c4:	00050493          	mv	s1,a0
    800016c8:	00053023          	sd	zero,0(a0)
    800016cc:	00053c23          	sd	zero,24(a0)
    800016d0:	00100793          	li	a5,1
    800016d4:	04f50023          	sb	a5,64(a0)
    finished = false;
    800016d8:	02050423          	sb	zero,40(a0)
    main = main_;
    800016dc:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    800016e0:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    800016e4:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    800016e8:	10800513          	li	a0,264
    800016ec:	00001097          	auipc	ra,0x1
    800016f0:	e60080e7          	jalr	-416(ra) # 8000254c <_ZN15MemoryAllocator9mem_allocEm>
    800016f4:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    800016f8:	00008537          	lui	a0,0x8
    800016fc:	00001097          	auipc	ra,0x1
    80001700:	e50080e7          	jalr	-432(ra) # 8000254c <_ZN15MemoryAllocator9mem_allocEm>
    80001704:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001708:	000087b7          	lui	a5,0x8
    8000170c:	00f50533          	add	a0,a0,a5
    80001710:	0184b783          	ld	a5,24(s1)
    80001714:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001718:	0184b783          	ld	a5,24(s1)
    8000171c:	00000717          	auipc	a4,0x0
    80001720:	ea070713          	addi	a4,a4,-352 # 800015bc <_ZN3PCB15proccessWrapperEv>
    80001724:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001728:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    8000172c:	0204b783          	ld	a5,32(s1)
    80001730:	00078c63          	beqz	a5,80001748 <_ZN3PCBC1EPFvvEmPv+0x98>
}
    80001734:	01813083          	ld	ra,24(sp)
    80001738:	01013403          	ld	s0,16(sp)
    8000173c:	00813483          	ld	s1,8(sp)
    80001740:	02010113          	addi	sp,sp,32
    80001744:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001748:	04048023          	sb	zero,64(s1)
}
    8000174c:	fe9ff06f          	j	80001734 <_ZN3PCBC1EPFvvEmPv+0x84>

0000000080001750 <_ZN3PCBD1Ev>:
    delete[] stack;
    80001750:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001754:	02050663          	beqz	a0,80001780 <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00113423          	sd	ra,8(sp)
    80001760:	00813023          	sd	s0,0(sp)
    80001764:	01010413          	addi	s0,sp,16
    delete[] stack;
    80001768:	00001097          	auipc	ra,0x1
    8000176c:	c40080e7          	jalr	-960(ra) # 800023a8 <_ZdaPv>
}
    80001770:	00813083          	ld	ra,8(sp)
    80001774:	00013403          	ld	s0,0(sp)
    80001778:	01010113          	addi	sp,sp,16
    8000177c:	00008067          	ret
    80001780:	00008067          	ret

0000000080001784 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001784:	ff010113          	addi	sp,sp,-16
    80001788:	00113423          	sd	ra,8(sp)
    8000178c:	00813023          	sd	s0,0(sp)
    80001790:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001794:	00001097          	auipc	ra,0x1
    80001798:	db8080e7          	jalr	-584(ra) # 8000254c <_ZN15MemoryAllocator9mem_allocEm>
}
    8000179c:	00813083          	ld	ra,8(sp)
    800017a0:	00013403          	ld	s0,0(sp)
    800017a4:	01010113          	addi	sp,sp,16
    800017a8:	00008067          	ret

00000000800017ac <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    800017ac:	ff010113          	addi	sp,sp,-16
    800017b0:	00113423          	sd	ra,8(sp)
    800017b4:	00813023          	sd	s0,0(sp)
    800017b8:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800017bc:	00001097          	auipc	ra,0x1
    800017c0:	ef4080e7          	jalr	-268(ra) # 800026b0 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800017c4:	00813083          	ld	ra,8(sp)
    800017c8:	00013403          	ld	s0,0(sp)
    800017cc:	01010113          	addi	sp,sp,16
    800017d0:	00008067          	ret

00000000800017d4 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    800017d4:	fd010113          	addi	sp,sp,-48
    800017d8:	02113423          	sd	ra,40(sp)
    800017dc:	02813023          	sd	s0,32(sp)
    800017e0:	00913c23          	sd	s1,24(sp)
    800017e4:	01213823          	sd	s2,16(sp)
    800017e8:	01313423          	sd	s3,8(sp)
    800017ec:	03010413          	addi	s0,sp,48
    800017f0:	00050913          	mv	s2,a0
    800017f4:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    800017f8:	04800513          	li	a0,72
    800017fc:	00000097          	auipc	ra,0x0
    80001800:	f88080e7          	jalr	-120(ra) # 80001784 <_ZN3PCBnwEm>
    80001804:	00050493          	mv	s1,a0
    80001808:	00098693          	mv	a3,s3
    8000180c:	00200613          	li	a2,2
    80001810:	00090593          	mv	a1,s2
    80001814:	00000097          	auipc	ra,0x0
    80001818:	e9c080e7          	jalr	-356(ra) # 800016b0 <_ZN3PCBC1EPFvvEmPv>
    8000181c:	0200006f          	j	8000183c <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001820:	00050913          	mv	s2,a0
    80001824:	00048513          	mv	a0,s1
    80001828:	00000097          	auipc	ra,0x0
    8000182c:	f84080e7          	jalr	-124(ra) # 800017ac <_ZN3PCBdlEPv>
    80001830:	00090513          	mv	a0,s2
    80001834:	00006097          	auipc	ra,0x6
    80001838:	8b4080e7          	jalr	-1868(ra) # 800070e8 <_Unwind_Resume>
}
    8000183c:	00048513          	mv	a0,s1
    80001840:	02813083          	ld	ra,40(sp)
    80001844:	02013403          	ld	s0,32(sp)
    80001848:	01813483          	ld	s1,24(sp)
    8000184c:	01013903          	ld	s2,16(sp)
    80001850:	00813983          	ld	s3,8(sp)
    80001854:	03010113          	addi	sp,sp,48
    80001858:	00008067          	ret

000000008000185c <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    8000185c:	ff010113          	addi	sp,sp,-16
    80001860:	00813423          	sd	s0,8(sp)
    80001864:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001868:	00004797          	auipc	a5,0x4
    8000186c:	7787b783          	ld	a5,1912(a5) # 80005fe0 <_ZN3PCB7runningE>
    80001870:	0187b503          	ld	a0,24(a5)
    80001874:	00813403          	ld	s0,8(sp)
    80001878:	01010113          	addi	sp,sp,16
    8000187c:	00008067          	ret

0000000080001880 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00813423          	sd	s0,8(sp)
    80001888:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    8000188c:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001890:	00004797          	auipc	a5,0x4
    80001894:	7607b783          	ld	a5,1888(a5) # 80005ff0 <_ZN9Scheduler4tailE>
    80001898:	02078463          	beqz	a5,800018c0 <_ZN9Scheduler3putEP3PCB+0x40>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    8000189c:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextReady;
    800018a0:	00004797          	auipc	a5,0x4
    800018a4:	75078793          	addi	a5,a5,1872 # 80005ff0 <_ZN9Scheduler4tailE>
    800018a8:	0007b703          	ld	a4,0(a5)
    800018ac:	00073703          	ld	a4,0(a4)
    800018b0:	00e7b023          	sd	a4,0(a5)
    }
}
    800018b4:	00813403          	ld	s0,8(sp)
    800018b8:	01010113          	addi	sp,sp,16
    800018bc:	00008067          	ret
        head = tail = process;
    800018c0:	00004797          	auipc	a5,0x4
    800018c4:	73078793          	addi	a5,a5,1840 # 80005ff0 <_ZN9Scheduler4tailE>
    800018c8:	00a7b023          	sd	a0,0(a5)
    800018cc:	00a7b423          	sd	a0,8(a5)
    800018d0:	fe5ff06f          	j	800018b4 <_ZN9Scheduler3putEP3PCB+0x34>

00000000800018d4 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800018d4:	ff010113          	addi	sp,sp,-16
    800018d8:	00813423          	sd	s0,8(sp)
    800018dc:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800018e0:	00004517          	auipc	a0,0x4
    800018e4:	71853503          	ld	a0,1816(a0) # 80005ff8 <_ZN9Scheduler4headE>
    800018e8:	02050463          	beqz	a0,80001910 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    800018ec:	00053703          	ld	a4,0(a0)
    800018f0:	00004797          	auipc	a5,0x4
    800018f4:	70078793          	addi	a5,a5,1792 # 80005ff0 <_ZN9Scheduler4tailE>
    800018f8:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800018fc:	0007b783          	ld	a5,0(a5)
    80001900:	00f50e63          	beq	a0,a5,8000191c <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001904:	00813403          	ld	s0,8(sp)
    80001908:	01010113          	addi	sp,sp,16
    8000190c:	00008067          	ret
        return idleProcess;
    80001910:	00004517          	auipc	a0,0x4
    80001914:	6f053503          	ld	a0,1776(a0) # 80006000 <_ZN9Scheduler11idleProcessE>
    80001918:	fedff06f          	j	80001904 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    8000191c:	00004797          	auipc	a5,0x4
    80001920:	6ce7ba23          	sd	a4,1748(a5) # 80005ff0 <_ZN9Scheduler4tailE>
    80001924:	fe1ff06f          	j	80001904 <_ZN9Scheduler3getEv+0x30>

0000000080001928 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    80001928:	fe010113          	addi	sp,sp,-32
    8000192c:	00113c23          	sd	ra,24(sp)
    80001930:	00813823          	sd	s0,16(sp)
    80001934:	00913423          	sd	s1,8(sp)
    80001938:	01213023          	sd	s2,0(sp)
    8000193c:	02010413          	addi	s0,sp,32
    80001940:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001944:	00100793          	li	a5,1
    80001948:	02a7f863          	bgeu	a5,a0,80001978 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000194c:	00a00793          	li	a5,10
    80001950:	02f577b3          	remu	a5,a0,a5
    80001954:	02078e63          	beqz	a5,80001990 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001958:	fff48513          	addi	a0,s1,-1
    8000195c:	00000097          	auipc	ra,0x0
    80001960:	fcc080e7          	jalr	-52(ra) # 80001928 <_Z9fibonaccim>
    80001964:	00050913          	mv	s2,a0
    80001968:	ffe48513          	addi	a0,s1,-2
    8000196c:	00000097          	auipc	ra,0x0
    80001970:	fbc080e7          	jalr	-68(ra) # 80001928 <_Z9fibonaccim>
    80001974:	00a90533          	add	a0,s2,a0
}
    80001978:	01813083          	ld	ra,24(sp)
    8000197c:	01013403          	ld	s0,16(sp)
    80001980:	00813483          	ld	s1,8(sp)
    80001984:	00013903          	ld	s2,0(sp)
    80001988:	02010113          	addi	sp,sp,32
    8000198c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001990:	00000097          	auipc	ra,0x0
    80001994:	8c4080e7          	jalr	-1852(ra) # 80001254 <_Z15thread_dispatchv>
    80001998:	fc1ff06f          	j	80001958 <_Z9fibonaccim+0x30>

000000008000199c <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    8000199c:	fe010113          	addi	sp,sp,-32
    800019a0:	00113c23          	sd	ra,24(sp)
    800019a4:	00813823          	sd	s0,16(sp)
    800019a8:	00913423          	sd	s1,8(sp)
    800019ac:	01213023          	sd	s2,0(sp)
    800019b0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800019b4:	00000913          	li	s2,0
    800019b8:	0380006f          	j	800019f0 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800019bc:	00000097          	auipc	ra,0x0
    800019c0:	898080e7          	jalr	-1896(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800019c4:	00148493          	addi	s1,s1,1
    800019c8:	000027b7          	lui	a5,0x2
    800019cc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800019d0:	0097ee63          	bltu	a5,s1,800019ec <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800019d4:	00000713          	li	a4,0
    800019d8:	000077b7          	lui	a5,0x7
    800019dc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800019e0:	fce7eee3          	bltu	a5,a4,800019bc <_ZN7WorkerA11workerBodyAEPv+0x20>
    800019e4:	00170713          	addi	a4,a4,1
    800019e8:	ff1ff06f          	j	800019d8 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800019ec:	00190913          	addi	s2,s2,1
    800019f0:	00900793          	li	a5,9
    800019f4:	0327ec63          	bltu	a5,s2,80001a2c <_ZN7WorkerA11workerBodyAEPv+0x90>
        printString("A: i="); printInteger(i); printString("\n");
    800019f8:	00003517          	auipc	a0,0x3
    800019fc:	68050513          	addi	a0,a0,1664 # 80005078 <CONSOLE_STATUS+0x68>
    80001a00:	00001097          	auipc	ra,0x1
    80001a04:	e5c080e7          	jalr	-420(ra) # 8000285c <_Z11printStringPKc>
    80001a08:	00090513          	mv	a0,s2
    80001a0c:	00001097          	auipc	ra,0x1
    80001a10:	ec0080e7          	jalr	-320(ra) # 800028cc <_Z12printIntegerm>
    80001a14:	00004517          	auipc	a0,0x4
    80001a18:	8a450513          	addi	a0,a0,-1884 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001a1c:	00001097          	auipc	ra,0x1
    80001a20:	e40080e7          	jalr	-448(ra) # 8000285c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001a24:	00000493          	li	s1,0
    80001a28:	fa1ff06f          	j	800019c8 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001a2c:	00003517          	auipc	a0,0x3
    80001a30:	65450513          	addi	a0,a0,1620 # 80005080 <CONSOLE_STATUS+0x70>
    80001a34:	00001097          	auipc	ra,0x1
    80001a38:	e28080e7          	jalr	-472(ra) # 8000285c <_Z11printStringPKc>
    finishedA = true;
    80001a3c:	00100793          	li	a5,1
    80001a40:	00004717          	auipc	a4,0x4
    80001a44:	5cf70423          	sb	a5,1480(a4) # 80006008 <finishedA>
}
    80001a48:	01813083          	ld	ra,24(sp)
    80001a4c:	01013403          	ld	s0,16(sp)
    80001a50:	00813483          	ld	s1,8(sp)
    80001a54:	00013903          	ld	s2,0(sp)
    80001a58:	02010113          	addi	sp,sp,32
    80001a5c:	00008067          	ret

0000000080001a60 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001a60:	fe010113          	addi	sp,sp,-32
    80001a64:	00113c23          	sd	ra,24(sp)
    80001a68:	00813823          	sd	s0,16(sp)
    80001a6c:	00913423          	sd	s1,8(sp)
    80001a70:	01213023          	sd	s2,0(sp)
    80001a74:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001a78:	00000913          	li	s2,0
    80001a7c:	0380006f          	j	80001ab4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001a80:	fffff097          	auipc	ra,0xfffff
    80001a84:	7d4080e7          	jalr	2004(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001a88:	00148493          	addi	s1,s1,1
    80001a8c:	000027b7          	lui	a5,0x2
    80001a90:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001a94:	0097ee63          	bltu	a5,s1,80001ab0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001a98:	00000713          	li	a4,0
    80001a9c:	000077b7          	lui	a5,0x7
    80001aa0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001aa4:	fce7eee3          	bltu	a5,a4,80001a80 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80001aa8:	00170713          	addi	a4,a4,1
    80001aac:	ff1ff06f          	j	80001a9c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001ab0:	00190913          	addi	s2,s2,1
    80001ab4:	00f00793          	li	a5,15
    80001ab8:	0327ec63          	bltu	a5,s2,80001af0 <_ZN7WorkerB11workerBodyBEPv+0x90>
        printString("B: i="); printInteger(i); printString("\n");
    80001abc:	00003517          	auipc	a0,0x3
    80001ac0:	5d450513          	addi	a0,a0,1492 # 80005090 <CONSOLE_STATUS+0x80>
    80001ac4:	00001097          	auipc	ra,0x1
    80001ac8:	d98080e7          	jalr	-616(ra) # 8000285c <_Z11printStringPKc>
    80001acc:	00090513          	mv	a0,s2
    80001ad0:	00001097          	auipc	ra,0x1
    80001ad4:	dfc080e7          	jalr	-516(ra) # 800028cc <_Z12printIntegerm>
    80001ad8:	00003517          	auipc	a0,0x3
    80001adc:	7e050513          	addi	a0,a0,2016 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001ae0:	00001097          	auipc	ra,0x1
    80001ae4:	d7c080e7          	jalr	-644(ra) # 8000285c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001ae8:	00000493          	li	s1,0
    80001aec:	fa1ff06f          	j	80001a8c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001af0:	00003517          	auipc	a0,0x3
    80001af4:	5a850513          	addi	a0,a0,1448 # 80005098 <CONSOLE_STATUS+0x88>
    80001af8:	00001097          	auipc	ra,0x1
    80001afc:	d64080e7          	jalr	-668(ra) # 8000285c <_Z11printStringPKc>
    finishedB = true;
    80001b00:	00100793          	li	a5,1
    80001b04:	00004717          	auipc	a4,0x4
    80001b08:	50f702a3          	sb	a5,1285(a4) # 80006009 <finishedB>
    thread_dispatch();
    80001b0c:	fffff097          	auipc	ra,0xfffff
    80001b10:	748080e7          	jalr	1864(ra) # 80001254 <_Z15thread_dispatchv>
}
    80001b14:	01813083          	ld	ra,24(sp)
    80001b18:	01013403          	ld	s0,16(sp)
    80001b1c:	00813483          	ld	s1,8(sp)
    80001b20:	00013903          	ld	s2,0(sp)
    80001b24:	02010113          	addi	sp,sp,32
    80001b28:	00008067          	ret

0000000080001b2c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80001b2c:	fe010113          	addi	sp,sp,-32
    80001b30:	00113c23          	sd	ra,24(sp)
    80001b34:	00813823          	sd	s0,16(sp)
    80001b38:	00913423          	sd	s1,8(sp)
    80001b3c:	01213023          	sd	s2,0(sp)
    80001b40:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001b44:	00000493          	li	s1,0
    80001b48:	0380006f          	j	80001b80 <_ZN7WorkerC11workerBodyCEPv+0x54>
    for (; i < 3; i++) {
        printString("C: i="); printInteger(i); printString("\n");
    80001b4c:	00003517          	auipc	a0,0x3
    80001b50:	55c50513          	addi	a0,a0,1372 # 800050a8 <CONSOLE_STATUS+0x98>
    80001b54:	00001097          	auipc	ra,0x1
    80001b58:	d08080e7          	jalr	-760(ra) # 8000285c <_Z11printStringPKc>
    80001b5c:	00048513          	mv	a0,s1
    80001b60:	00001097          	auipc	ra,0x1
    80001b64:	d6c080e7          	jalr	-660(ra) # 800028cc <_Z12printIntegerm>
    80001b68:	00003517          	auipc	a0,0x3
    80001b6c:	75050513          	addi	a0,a0,1872 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001b70:	00001097          	auipc	ra,0x1
    80001b74:	cec080e7          	jalr	-788(ra) # 8000285c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001b78:	0014849b          	addiw	s1,s1,1
    80001b7c:	0ff4f493          	andi	s1,s1,255
    80001b80:	00200793          	li	a5,2
    80001b84:	fc97f4e3          	bgeu	a5,s1,80001b4c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001b88:	00003517          	auipc	a0,0x3
    80001b8c:	52850513          	addi	a0,a0,1320 # 800050b0 <CONSOLE_STATUS+0xa0>
    80001b90:	00001097          	auipc	ra,0x1
    80001b94:	ccc080e7          	jalr	-820(ra) # 8000285c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001b98:	00700313          	li	t1,7
    thread_dispatch();
    80001b9c:	fffff097          	auipc	ra,0xfffff
    80001ba0:	6b8080e7          	jalr	1720(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001ba4:	00030913          	mv	s2,t1

    printString("C: t1="); printInteger(t1); printString("\n");
    80001ba8:	00003517          	auipc	a0,0x3
    80001bac:	51850513          	addi	a0,a0,1304 # 800050c0 <CONSOLE_STATUS+0xb0>
    80001bb0:	00001097          	auipc	ra,0x1
    80001bb4:	cac080e7          	jalr	-852(ra) # 8000285c <_Z11printStringPKc>
    80001bb8:	00090513          	mv	a0,s2
    80001bbc:	00001097          	auipc	ra,0x1
    80001bc0:	d10080e7          	jalr	-752(ra) # 800028cc <_Z12printIntegerm>
    80001bc4:	00003517          	auipc	a0,0x3
    80001bc8:	6f450513          	addi	a0,a0,1780 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001bcc:	00001097          	auipc	ra,0x1
    80001bd0:	c90080e7          	jalr	-880(ra) # 8000285c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001bd4:	00c00513          	li	a0,12
    80001bd8:	00000097          	auipc	ra,0x0
    80001bdc:	d50080e7          	jalr	-688(ra) # 80001928 <_Z9fibonaccim>
    80001be0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInteger(result); printString("\n");
    80001be4:	00003517          	auipc	a0,0x3
    80001be8:	4e450513          	addi	a0,a0,1252 # 800050c8 <CONSOLE_STATUS+0xb8>
    80001bec:	00001097          	auipc	ra,0x1
    80001bf0:	c70080e7          	jalr	-912(ra) # 8000285c <_Z11printStringPKc>
    80001bf4:	00090513          	mv	a0,s2
    80001bf8:	00001097          	auipc	ra,0x1
    80001bfc:	cd4080e7          	jalr	-812(ra) # 800028cc <_Z12printIntegerm>
    80001c00:	00003517          	auipc	a0,0x3
    80001c04:	6b850513          	addi	a0,a0,1720 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001c08:	00001097          	auipc	ra,0x1
    80001c0c:	c54080e7          	jalr	-940(ra) # 8000285c <_Z11printStringPKc>
    80001c10:	0380006f          	j	80001c48 <_ZN7WorkerC11workerBodyCEPv+0x11c>

    for (; i < 6; i++) {
        printString("C: i="); printInteger(i); printString("\n");
    80001c14:	00003517          	auipc	a0,0x3
    80001c18:	49450513          	addi	a0,a0,1172 # 800050a8 <CONSOLE_STATUS+0x98>
    80001c1c:	00001097          	auipc	ra,0x1
    80001c20:	c40080e7          	jalr	-960(ra) # 8000285c <_Z11printStringPKc>
    80001c24:	00048513          	mv	a0,s1
    80001c28:	00001097          	auipc	ra,0x1
    80001c2c:	ca4080e7          	jalr	-860(ra) # 800028cc <_Z12printIntegerm>
    80001c30:	00003517          	auipc	a0,0x3
    80001c34:	68850513          	addi	a0,a0,1672 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001c38:	00001097          	auipc	ra,0x1
    80001c3c:	c24080e7          	jalr	-988(ra) # 8000285c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001c40:	0014849b          	addiw	s1,s1,1
    80001c44:	0ff4f493          	andi	s1,s1,255
    80001c48:	00500793          	li	a5,5
    80001c4c:	fc97f4e3          	bgeu	a5,s1,80001c14 <_ZN7WorkerC11workerBodyCEPv+0xe8>
    }

    printString("A finished!\n");
    80001c50:	00003517          	auipc	a0,0x3
    80001c54:	43050513          	addi	a0,a0,1072 # 80005080 <CONSOLE_STATUS+0x70>
    80001c58:	00001097          	auipc	ra,0x1
    80001c5c:	c04080e7          	jalr	-1020(ra) # 8000285c <_Z11printStringPKc>
    finishedC = true;
    80001c60:	00100793          	li	a5,1
    80001c64:	00004717          	auipc	a4,0x4
    80001c68:	3af70323          	sb	a5,934(a4) # 8000600a <finishedC>
    thread_dispatch();
    80001c6c:	fffff097          	auipc	ra,0xfffff
    80001c70:	5e8080e7          	jalr	1512(ra) # 80001254 <_Z15thread_dispatchv>
}
    80001c74:	01813083          	ld	ra,24(sp)
    80001c78:	01013403          	ld	s0,16(sp)
    80001c7c:	00813483          	ld	s1,8(sp)
    80001c80:	00013903          	ld	s2,0(sp)
    80001c84:	02010113          	addi	sp,sp,32
    80001c88:	00008067          	ret

0000000080001c8c <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80001c8c:	fe010113          	addi	sp,sp,-32
    80001c90:	00113c23          	sd	ra,24(sp)
    80001c94:	00813823          	sd	s0,16(sp)
    80001c98:	00913423          	sd	s1,8(sp)
    80001c9c:	01213023          	sd	s2,0(sp)
    80001ca0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001ca4:	00a00493          	li	s1,10
    80001ca8:	0380006f          	j	80001ce0 <_ZN7WorkerD11workerBodyDEPv+0x54>
    for (; i < 13; i++) {
        printString("D: i="); printInteger(i); printString("\n");
    80001cac:	00003517          	auipc	a0,0x3
    80001cb0:	42c50513          	addi	a0,a0,1068 # 800050d8 <CONSOLE_STATUS+0xc8>
    80001cb4:	00001097          	auipc	ra,0x1
    80001cb8:	ba8080e7          	jalr	-1112(ra) # 8000285c <_Z11printStringPKc>
    80001cbc:	00048513          	mv	a0,s1
    80001cc0:	00001097          	auipc	ra,0x1
    80001cc4:	c0c080e7          	jalr	-1012(ra) # 800028cc <_Z12printIntegerm>
    80001cc8:	00003517          	auipc	a0,0x3
    80001ccc:	5f050513          	addi	a0,a0,1520 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001cd0:	00001097          	auipc	ra,0x1
    80001cd4:	b8c080e7          	jalr	-1140(ra) # 8000285c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001cd8:	0014849b          	addiw	s1,s1,1
    80001cdc:	0ff4f493          	andi	s1,s1,255
    80001ce0:	00c00793          	li	a5,12
    80001ce4:	fc97f4e3          	bgeu	a5,s1,80001cac <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80001ce8:	00003517          	auipc	a0,0x3
    80001cec:	3f850513          	addi	a0,a0,1016 # 800050e0 <CONSOLE_STATUS+0xd0>
    80001cf0:	00001097          	auipc	ra,0x1
    80001cf4:	b6c080e7          	jalr	-1172(ra) # 8000285c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001cf8:	00500313          	li	t1,5
    thread_dispatch();
    80001cfc:	fffff097          	auipc	ra,0xfffff
    80001d00:	558080e7          	jalr	1368(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001d04:	01000513          	li	a0,16
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	c20080e7          	jalr	-992(ra) # 80001928 <_Z9fibonaccim>
    80001d10:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInteger(result); printString("\n");
    80001d14:	00003517          	auipc	a0,0x3
    80001d18:	3dc50513          	addi	a0,a0,988 # 800050f0 <CONSOLE_STATUS+0xe0>
    80001d1c:	00001097          	auipc	ra,0x1
    80001d20:	b40080e7          	jalr	-1216(ra) # 8000285c <_Z11printStringPKc>
    80001d24:	00090513          	mv	a0,s2
    80001d28:	00001097          	auipc	ra,0x1
    80001d2c:	ba4080e7          	jalr	-1116(ra) # 800028cc <_Z12printIntegerm>
    80001d30:	00003517          	auipc	a0,0x3
    80001d34:	58850513          	addi	a0,a0,1416 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001d38:	00001097          	auipc	ra,0x1
    80001d3c:	b24080e7          	jalr	-1244(ra) # 8000285c <_Z11printStringPKc>
    80001d40:	0380006f          	j	80001d78 <_ZN7WorkerD11workerBodyDEPv+0xec>

    for (; i < 16; i++) {
        printString("D: i="); printInteger(i); printString("\n");
    80001d44:	00003517          	auipc	a0,0x3
    80001d48:	39450513          	addi	a0,a0,916 # 800050d8 <CONSOLE_STATUS+0xc8>
    80001d4c:	00001097          	auipc	ra,0x1
    80001d50:	b10080e7          	jalr	-1264(ra) # 8000285c <_Z11printStringPKc>
    80001d54:	00048513          	mv	a0,s1
    80001d58:	00001097          	auipc	ra,0x1
    80001d5c:	b74080e7          	jalr	-1164(ra) # 800028cc <_Z12printIntegerm>
    80001d60:	00003517          	auipc	a0,0x3
    80001d64:	55850513          	addi	a0,a0,1368 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80001d68:	00001097          	auipc	ra,0x1
    80001d6c:	af4080e7          	jalr	-1292(ra) # 8000285c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001d70:	0014849b          	addiw	s1,s1,1
    80001d74:	0ff4f493          	andi	s1,s1,255
    80001d78:	00f00793          	li	a5,15
    80001d7c:	fc97f4e3          	bgeu	a5,s1,80001d44 <_ZN7WorkerD11workerBodyDEPv+0xb8>
    }

    printString("D finished!\n");
    80001d80:	00003517          	auipc	a0,0x3
    80001d84:	38050513          	addi	a0,a0,896 # 80005100 <CONSOLE_STATUS+0xf0>
    80001d88:	00001097          	auipc	ra,0x1
    80001d8c:	ad4080e7          	jalr	-1324(ra) # 8000285c <_Z11printStringPKc>
    finishedD = true;
    80001d90:	00100793          	li	a5,1
    80001d94:	00004717          	auipc	a4,0x4
    80001d98:	26f70ba3          	sb	a5,631(a4) # 8000600b <finishedD>
    thread_dispatch();
    80001d9c:	fffff097          	auipc	ra,0xfffff
    80001da0:	4b8080e7          	jalr	1208(ra) # 80001254 <_Z15thread_dispatchv>
}
    80001da4:	01813083          	ld	ra,24(sp)
    80001da8:	01013403          	ld	s0,16(sp)
    80001dac:	00813483          	ld	s1,8(sp)
    80001db0:	00013903          	ld	s2,0(sp)
    80001db4:	02010113          	addi	sp,sp,32
    80001db8:	00008067          	ret

0000000080001dbc <main>:

extern "C" void interrupt();
int main() {
    80001dbc:	fc010113          	addi	sp,sp,-64
    80001dc0:	02113c23          	sd	ra,56(sp)
    80001dc4:	02813823          	sd	s0,48(sp)
    80001dc8:	02913423          	sd	s1,40(sp)
    80001dcc:	03213023          	sd	s2,32(sp)
    80001dd0:	04010413          	addi	s0,sp,64
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001dd4:	00004797          	auipc	a5,0x4
    80001dd8:	1bc7b783          	ld	a5,444(a5) # 80005f90 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001ddc:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001de0:	00000593          	li	a1,0
    80001de4:	00000513          	li	a0,0
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	9ec080e7          	jalr	-1556(ra) # 800017d4 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001df0:	00004797          	auipc	a5,0x4
    80001df4:	1907b783          	ld	a5,400(a5) # 80005f80 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001df8:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001dfc:	00200793          	li	a5,2
    80001e00:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    Thread* threads[4];

    threads[0] = new WorkerA();
    80001e04:	01000513          	li	a0,16
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	600080e7          	jalr	1536(ra) # 80002408 <_ZN6ThreadnwEm>
    80001e10:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80001e14:	00000097          	auipc	ra,0x0
    80001e18:	6dc080e7          	jalr	1756(ra) # 800024f0 <_ZN6ThreadC1Ev>
    80001e1c:	00004797          	auipc	a5,0x4
    80001e20:	08c78793          	addi	a5,a5,140 # 80005ea8 <_ZTV7WorkerA+0x10>
    80001e24:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80001e28:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80001e2c:	00003517          	auipc	a0,0x3
    80001e30:	2e450513          	addi	a0,a0,740 # 80005110 <CONSOLE_STATUS+0x100>
    80001e34:	00001097          	auipc	ra,0x1
    80001e38:	a28080e7          	jalr	-1496(ra) # 8000285c <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80001e3c:	01000513          	li	a0,16
    80001e40:	00000097          	auipc	ra,0x0
    80001e44:	5c8080e7          	jalr	1480(ra) # 80002408 <_ZN6ThreadnwEm>
    80001e48:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80001e4c:	00000097          	auipc	ra,0x0
    80001e50:	6a4080e7          	jalr	1700(ra) # 800024f0 <_ZN6ThreadC1Ev>
    80001e54:	00004797          	auipc	a5,0x4
    80001e58:	07c78793          	addi	a5,a5,124 # 80005ed0 <_ZTV7WorkerB+0x10>
    80001e5c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80001e60:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80001e64:	00003517          	auipc	a0,0x3
    80001e68:	2c450513          	addi	a0,a0,708 # 80005128 <CONSOLE_STATUS+0x118>
    80001e6c:	00001097          	auipc	ra,0x1
    80001e70:	9f0080e7          	jalr	-1552(ra) # 8000285c <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80001e74:	01000513          	li	a0,16
    80001e78:	00000097          	auipc	ra,0x0
    80001e7c:	590080e7          	jalr	1424(ra) # 80002408 <_ZN6ThreadnwEm>
    80001e80:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	66c080e7          	jalr	1644(ra) # 800024f0 <_ZN6ThreadC1Ev>
    80001e8c:	00004797          	auipc	a5,0x4
    80001e90:	06c78793          	addi	a5,a5,108 # 80005ef8 <_ZTV7WorkerC+0x10>
    80001e94:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80001e98:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80001e9c:	00003517          	auipc	a0,0x3
    80001ea0:	2a450513          	addi	a0,a0,676 # 80005140 <CONSOLE_STATUS+0x130>
    80001ea4:	00001097          	auipc	ra,0x1
    80001ea8:	9b8080e7          	jalr	-1608(ra) # 8000285c <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80001eac:	01000513          	li	a0,16
    80001eb0:	00000097          	auipc	ra,0x0
    80001eb4:	558080e7          	jalr	1368(ra) # 80002408 <_ZN6ThreadnwEm>
    80001eb8:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80001ebc:	00000097          	auipc	ra,0x0
    80001ec0:	634080e7          	jalr	1588(ra) # 800024f0 <_ZN6ThreadC1Ev>
    80001ec4:	00004797          	auipc	a5,0x4
    80001ec8:	05c78793          	addi	a5,a5,92 # 80005f20 <_ZTV7WorkerD+0x10>
    80001ecc:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80001ed0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80001ed4:	00003517          	auipc	a0,0x3
    80001ed8:	28450513          	addi	a0,a0,644 # 80005158 <CONSOLE_STATUS+0x148>
    80001edc:	00001097          	auipc	ra,0x1
    80001ee0:	980080e7          	jalr	-1664(ra) # 8000285c <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80001ee4:	00000493          	li	s1,0
    80001ee8:	00300793          	li	a5,3
    80001eec:	0297c663          	blt	a5,s1,80001f18 <main+0x15c>
        threads[i]->start();
    80001ef0:	00349793          	slli	a5,s1,0x3
    80001ef4:	fe040713          	addi	a4,s0,-32
    80001ef8:	00f707b3          	add	a5,a4,a5
    80001efc:	fe07b503          	ld	a0,-32(a5)
    80001f00:	00000097          	auipc	ra,0x0
    80001f04:	5c0080e7          	jalr	1472(ra) # 800024c0 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80001f08:	0014849b          	addiw	s1,s1,1
    80001f0c:	fddff06f          	j	80001ee8 <main+0x12c>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	588080e7          	jalr	1416(ra) # 80002498 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80001f18:	00004797          	auipc	a5,0x4
    80001f1c:	0f07c783          	lbu	a5,240(a5) # 80006008 <finishedA>
    80001f20:	fe0788e3          	beqz	a5,80001f10 <main+0x154>
    80001f24:	00004797          	auipc	a5,0x4
    80001f28:	0e57c783          	lbu	a5,229(a5) # 80006009 <finishedB>
    80001f2c:	fe0782e3          	beqz	a5,80001f10 <main+0x154>
    80001f30:	00004797          	auipc	a5,0x4
    80001f34:	0da7c783          	lbu	a5,218(a5) # 8000600a <finishedC>
    80001f38:	fc078ce3          	beqz	a5,80001f10 <main+0x154>
    80001f3c:	00004797          	auipc	a5,0x4
    80001f40:	0cf7c783          	lbu	a5,207(a5) # 8000600b <finishedD>
    80001f44:	fc0786e3          	beqz	a5,80001f10 <main+0x154>
    }

    for (auto thread: threads) { delete thread; }
    80001f48:	fc040493          	addi	s1,s0,-64
    80001f4c:	0080006f          	j	80001f54 <main+0x198>
    80001f50:	00848493          	addi	s1,s1,8
    80001f54:	fe040793          	addi	a5,s0,-32
    80001f58:	08f48663          	beq	s1,a5,80001fe4 <main+0x228>
    80001f5c:	0004b503          	ld	a0,0(s1)
    80001f60:	fe0508e3          	beqz	a0,80001f50 <main+0x194>
    80001f64:	00053783          	ld	a5,0(a0)
    80001f68:	0087b783          	ld	a5,8(a5)
    80001f6c:	000780e7          	jalr	a5
    80001f70:	fe1ff06f          	j	80001f50 <main+0x194>
    80001f74:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80001f78:	00048513          	mv	a0,s1
    80001f7c:	00000097          	auipc	ra,0x0
    80001f80:	4b4080e7          	jalr	1204(ra) # 80002430 <_ZN6ThreaddlEPv>
    80001f84:	00090513          	mv	a0,s2
    80001f88:	00005097          	auipc	ra,0x5
    80001f8c:	160080e7          	jalr	352(ra) # 800070e8 <_Unwind_Resume>
    80001f90:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80001f94:	00048513          	mv	a0,s1
    80001f98:	00000097          	auipc	ra,0x0
    80001f9c:	498080e7          	jalr	1176(ra) # 80002430 <_ZN6ThreaddlEPv>
    80001fa0:	00090513          	mv	a0,s2
    80001fa4:	00005097          	auipc	ra,0x5
    80001fa8:	144080e7          	jalr	324(ra) # 800070e8 <_Unwind_Resume>
    80001fac:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80001fb0:	00048513          	mv	a0,s1
    80001fb4:	00000097          	auipc	ra,0x0
    80001fb8:	47c080e7          	jalr	1148(ra) # 80002430 <_ZN6ThreaddlEPv>
    80001fbc:	00090513          	mv	a0,s2
    80001fc0:	00005097          	auipc	ra,0x5
    80001fc4:	128080e7          	jalr	296(ra) # 800070e8 <_Unwind_Resume>
    80001fc8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80001fcc:	00048513          	mv	a0,s1
    80001fd0:	00000097          	auipc	ra,0x0
    80001fd4:	460080e7          	jalr	1120(ra) # 80002430 <_ZN6ThreaddlEPv>
    80001fd8:	00090513          	mv	a0,s2
    80001fdc:	00005097          	auipc	ra,0x5
    80001fe0:	10c080e7          	jalr	268(ra) # 800070e8 <_Unwind_Resume>

    return 0;
}
    80001fe4:	00000513          	li	a0,0
    80001fe8:	03813083          	ld	ra,56(sp)
    80001fec:	03013403          	ld	s0,48(sp)
    80001ff0:	02813483          	ld	s1,40(sp)
    80001ff4:	02013903          	ld	s2,32(sp)
    80001ff8:	04010113          	addi	sp,sp,64
    80001ffc:	00008067          	ret

0000000080002000 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	01010413          	addi	s0,sp,16
    80002010:	00004797          	auipc	a5,0x4
    80002014:	e9878793          	addi	a5,a5,-360 # 80005ea8 <_ZTV7WorkerA+0x10>
    80002018:	00f53023          	sd	a5,0(a0)
    8000201c:	00000097          	auipc	ra,0x0
    80002020:	2c0080e7          	jalr	704(ra) # 800022dc <_ZN6ThreadD1Ev>
    80002024:	00813083          	ld	ra,8(sp)
    80002028:	00013403          	ld	s0,0(sp)
    8000202c:	01010113          	addi	sp,sp,16
    80002030:	00008067          	ret

0000000080002034 <_ZN7WorkerAD0Ev>:
    80002034:	fe010113          	addi	sp,sp,-32
    80002038:	00113c23          	sd	ra,24(sp)
    8000203c:	00813823          	sd	s0,16(sp)
    80002040:	00913423          	sd	s1,8(sp)
    80002044:	02010413          	addi	s0,sp,32
    80002048:	00050493          	mv	s1,a0
    8000204c:	00004797          	auipc	a5,0x4
    80002050:	e5c78793          	addi	a5,a5,-420 # 80005ea8 <_ZTV7WorkerA+0x10>
    80002054:	00f53023          	sd	a5,0(a0)
    80002058:	00000097          	auipc	ra,0x0
    8000205c:	284080e7          	jalr	644(ra) # 800022dc <_ZN6ThreadD1Ev>
    80002060:	00048513          	mv	a0,s1
    80002064:	00000097          	auipc	ra,0x0
    80002068:	3cc080e7          	jalr	972(ra) # 80002430 <_ZN6ThreaddlEPv>
    8000206c:	01813083          	ld	ra,24(sp)
    80002070:	01013403          	ld	s0,16(sp)
    80002074:	00813483          	ld	s1,8(sp)
    80002078:	02010113          	addi	sp,sp,32
    8000207c:	00008067          	ret

0000000080002080 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002080:	ff010113          	addi	sp,sp,-16
    80002084:	00113423          	sd	ra,8(sp)
    80002088:	00813023          	sd	s0,0(sp)
    8000208c:	01010413          	addi	s0,sp,16
    80002090:	00004797          	auipc	a5,0x4
    80002094:	e4078793          	addi	a5,a5,-448 # 80005ed0 <_ZTV7WorkerB+0x10>
    80002098:	00f53023          	sd	a5,0(a0)
    8000209c:	00000097          	auipc	ra,0x0
    800020a0:	240080e7          	jalr	576(ra) # 800022dc <_ZN6ThreadD1Ev>
    800020a4:	00813083          	ld	ra,8(sp)
    800020a8:	00013403          	ld	s0,0(sp)
    800020ac:	01010113          	addi	sp,sp,16
    800020b0:	00008067          	ret

00000000800020b4 <_ZN7WorkerBD0Ev>:
    800020b4:	fe010113          	addi	sp,sp,-32
    800020b8:	00113c23          	sd	ra,24(sp)
    800020bc:	00813823          	sd	s0,16(sp)
    800020c0:	00913423          	sd	s1,8(sp)
    800020c4:	02010413          	addi	s0,sp,32
    800020c8:	00050493          	mv	s1,a0
    800020cc:	00004797          	auipc	a5,0x4
    800020d0:	e0478793          	addi	a5,a5,-508 # 80005ed0 <_ZTV7WorkerB+0x10>
    800020d4:	00f53023          	sd	a5,0(a0)
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	204080e7          	jalr	516(ra) # 800022dc <_ZN6ThreadD1Ev>
    800020e0:	00048513          	mv	a0,s1
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	34c080e7          	jalr	844(ra) # 80002430 <_ZN6ThreaddlEPv>
    800020ec:	01813083          	ld	ra,24(sp)
    800020f0:	01013403          	ld	s0,16(sp)
    800020f4:	00813483          	ld	s1,8(sp)
    800020f8:	02010113          	addi	sp,sp,32
    800020fc:	00008067          	ret

0000000080002100 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002100:	ff010113          	addi	sp,sp,-16
    80002104:	00113423          	sd	ra,8(sp)
    80002108:	00813023          	sd	s0,0(sp)
    8000210c:	01010413          	addi	s0,sp,16
    80002110:	00004797          	auipc	a5,0x4
    80002114:	de878793          	addi	a5,a5,-536 # 80005ef8 <_ZTV7WorkerC+0x10>
    80002118:	00f53023          	sd	a5,0(a0)
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	1c0080e7          	jalr	448(ra) # 800022dc <_ZN6ThreadD1Ev>
    80002124:	00813083          	ld	ra,8(sp)
    80002128:	00013403          	ld	s0,0(sp)
    8000212c:	01010113          	addi	sp,sp,16
    80002130:	00008067          	ret

0000000080002134 <_ZN7WorkerCD0Ev>:
    80002134:	fe010113          	addi	sp,sp,-32
    80002138:	00113c23          	sd	ra,24(sp)
    8000213c:	00813823          	sd	s0,16(sp)
    80002140:	00913423          	sd	s1,8(sp)
    80002144:	02010413          	addi	s0,sp,32
    80002148:	00050493          	mv	s1,a0
    8000214c:	00004797          	auipc	a5,0x4
    80002150:	dac78793          	addi	a5,a5,-596 # 80005ef8 <_ZTV7WorkerC+0x10>
    80002154:	00f53023          	sd	a5,0(a0)
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	184080e7          	jalr	388(ra) # 800022dc <_ZN6ThreadD1Ev>
    80002160:	00048513          	mv	a0,s1
    80002164:	00000097          	auipc	ra,0x0
    80002168:	2cc080e7          	jalr	716(ra) # 80002430 <_ZN6ThreaddlEPv>
    8000216c:	01813083          	ld	ra,24(sp)
    80002170:	01013403          	ld	s0,16(sp)
    80002174:	00813483          	ld	s1,8(sp)
    80002178:	02010113          	addi	sp,sp,32
    8000217c:	00008067          	ret

0000000080002180 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002180:	ff010113          	addi	sp,sp,-16
    80002184:	00113423          	sd	ra,8(sp)
    80002188:	00813023          	sd	s0,0(sp)
    8000218c:	01010413          	addi	s0,sp,16
    80002190:	00004797          	auipc	a5,0x4
    80002194:	d9078793          	addi	a5,a5,-624 # 80005f20 <_ZTV7WorkerD+0x10>
    80002198:	00f53023          	sd	a5,0(a0)
    8000219c:	00000097          	auipc	ra,0x0
    800021a0:	140080e7          	jalr	320(ra) # 800022dc <_ZN6ThreadD1Ev>
    800021a4:	00813083          	ld	ra,8(sp)
    800021a8:	00013403          	ld	s0,0(sp)
    800021ac:	01010113          	addi	sp,sp,16
    800021b0:	00008067          	ret

00000000800021b4 <_ZN7WorkerDD0Ev>:
    800021b4:	fe010113          	addi	sp,sp,-32
    800021b8:	00113c23          	sd	ra,24(sp)
    800021bc:	00813823          	sd	s0,16(sp)
    800021c0:	00913423          	sd	s1,8(sp)
    800021c4:	02010413          	addi	s0,sp,32
    800021c8:	00050493          	mv	s1,a0
    800021cc:	00004797          	auipc	a5,0x4
    800021d0:	d5478793          	addi	a5,a5,-684 # 80005f20 <_ZTV7WorkerD+0x10>
    800021d4:	00f53023          	sd	a5,0(a0)
    800021d8:	00000097          	auipc	ra,0x0
    800021dc:	104080e7          	jalr	260(ra) # 800022dc <_ZN6ThreadD1Ev>
    800021e0:	00048513          	mv	a0,s1
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	24c080e7          	jalr	588(ra) # 80002430 <_ZN6ThreaddlEPv>
    800021ec:	01813083          	ld	ra,24(sp)
    800021f0:	01013403          	ld	s0,16(sp)
    800021f4:	00813483          	ld	s1,8(sp)
    800021f8:	02010113          	addi	sp,sp,32
    800021fc:	00008067          	ret

0000000080002200 <_ZN7WorkerA3runEv>:
    void run() override {
    80002200:	ff010113          	addi	sp,sp,-16
    80002204:	00113423          	sd	ra,8(sp)
    80002208:	00813023          	sd	s0,0(sp)
    8000220c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002210:	00000593          	li	a1,0
    80002214:	fffff097          	auipc	ra,0xfffff
    80002218:	788080e7          	jalr	1928(ra) # 8000199c <_ZN7WorkerA11workerBodyAEPv>
    }
    8000221c:	00813083          	ld	ra,8(sp)
    80002220:	00013403          	ld	s0,0(sp)
    80002224:	01010113          	addi	sp,sp,16
    80002228:	00008067          	ret

000000008000222c <_ZN7WorkerB3runEv>:
    void run() override {
    8000222c:	ff010113          	addi	sp,sp,-16
    80002230:	00113423          	sd	ra,8(sp)
    80002234:	00813023          	sd	s0,0(sp)
    80002238:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    8000223c:	00000593          	li	a1,0
    80002240:	00000097          	auipc	ra,0x0
    80002244:	820080e7          	jalr	-2016(ra) # 80001a60 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002248:	00813083          	ld	ra,8(sp)
    8000224c:	00013403          	ld	s0,0(sp)
    80002250:	01010113          	addi	sp,sp,16
    80002254:	00008067          	ret

0000000080002258 <_ZN7WorkerC3runEv>:
    void run() override {
    80002258:	ff010113          	addi	sp,sp,-16
    8000225c:	00113423          	sd	ra,8(sp)
    80002260:	00813023          	sd	s0,0(sp)
    80002264:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002268:	00000593          	li	a1,0
    8000226c:	00000097          	auipc	ra,0x0
    80002270:	8c0080e7          	jalr	-1856(ra) # 80001b2c <_ZN7WorkerC11workerBodyCEPv>
    }
    80002274:	00813083          	ld	ra,8(sp)
    80002278:	00013403          	ld	s0,0(sp)
    8000227c:	01010113          	addi	sp,sp,16
    80002280:	00008067          	ret

0000000080002284 <_ZN7WorkerD3runEv>:
    void run() override {
    80002284:	ff010113          	addi	sp,sp,-16
    80002288:	00113423          	sd	ra,8(sp)
    8000228c:	00813023          	sd	s0,0(sp)
    80002290:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002294:	00000593          	li	a1,0
    80002298:	00000097          	auipc	ra,0x0
    8000229c:	9f4080e7          	jalr	-1548(ra) # 80001c8c <_ZN7WorkerD11workerBodyDEPv>
    }
    800022a0:	00813083          	ld	ra,8(sp)
    800022a4:	00013403          	ld	s0,0(sp)
    800022a8:	01010113          	addi	sp,sp,16
    800022ac:	00008067          	ret

00000000800022b0 <_Z13threadWrapperPv>:
void threadWrapper(void* thread);
Thread::Thread() {
    thread_create_only(&myHandle, threadWrapper, this);
}

void threadWrapper(void* thread) {
    800022b0:	ff010113          	addi	sp,sp,-16
    800022b4:	00113423          	sd	ra,8(sp)
    800022b8:	00813023          	sd	s0,0(sp)
    800022bc:	01010413          	addi	s0,sp,16
    ((Thread*)thread)->run();
    800022c0:	00053783          	ld	a5,0(a0)
    800022c4:	0107b783          	ld	a5,16(a5)
    800022c8:	000780e7          	jalr	a5
}
    800022cc:	00813083          	ld	ra,8(sp)
    800022d0:	00013403          	ld	s0,0(sp)
    800022d4:	01010113          	addi	sp,sp,16
    800022d8:	00008067          	ret

00000000800022dc <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    800022dc:	fe010113          	addi	sp,sp,-32
    800022e0:	00113c23          	sd	ra,24(sp)
    800022e4:	00813823          	sd	s0,16(sp)
    800022e8:	00913423          	sd	s1,8(sp)
    800022ec:	02010413          	addi	s0,sp,32
    800022f0:	00004797          	auipc	a5,0x4
    800022f4:	c5878793          	addi	a5,a5,-936 # 80005f48 <_ZTV6Thread+0x10>
    800022f8:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800022fc:	00853483          	ld	s1,8(a0)
    80002300:	00048e63          	beqz	s1,8000231c <_ZN6ThreadD1Ev+0x40>
    80002304:	00048513          	mv	a0,s1
    80002308:	fffff097          	auipc	ra,0xfffff
    8000230c:	448080e7          	jalr	1096(ra) # 80001750 <_ZN3PCBD1Ev>
    80002310:	00048513          	mv	a0,s1
    80002314:	fffff097          	auipc	ra,0xfffff
    80002318:	498080e7          	jalr	1176(ra) # 800017ac <_ZN3PCBdlEPv>
}
    8000231c:	01813083          	ld	ra,24(sp)
    80002320:	01013403          	ld	s0,16(sp)
    80002324:	00813483          	ld	s1,8(sp)
    80002328:	02010113          	addi	sp,sp,32
    8000232c:	00008067          	ret

0000000080002330 <_Znwm>:
void* operator new (size_t size) {
    80002330:	ff010113          	addi	sp,sp,-16
    80002334:	00113423          	sd	ra,8(sp)
    80002338:	00813023          	sd	s0,0(sp)
    8000233c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002340:	fffff097          	auipc	ra,0xfffff
    80002344:	e34080e7          	jalr	-460(ra) # 80001174 <_Z9mem_allocm>
}
    80002348:	00813083          	ld	ra,8(sp)
    8000234c:	00013403          	ld	s0,0(sp)
    80002350:	01010113          	addi	sp,sp,16
    80002354:	00008067          	ret

0000000080002358 <_Znam>:
void* operator new [](size_t size) {
    80002358:	ff010113          	addi	sp,sp,-16
    8000235c:	00113423          	sd	ra,8(sp)
    80002360:	00813023          	sd	s0,0(sp)
    80002364:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002368:	fffff097          	auipc	ra,0xfffff
    8000236c:	e0c080e7          	jalr	-500(ra) # 80001174 <_Z9mem_allocm>
}
    80002370:	00813083          	ld	ra,8(sp)
    80002374:	00013403          	ld	s0,0(sp)
    80002378:	01010113          	addi	sp,sp,16
    8000237c:	00008067          	ret

0000000080002380 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002380:	ff010113          	addi	sp,sp,-16
    80002384:	00113423          	sd	ra,8(sp)
    80002388:	00813023          	sd	s0,0(sp)
    8000238c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002390:	fffff097          	auipc	ra,0xfffff
    80002394:	e24080e7          	jalr	-476(ra) # 800011b4 <_Z8mem_freePv>
}
    80002398:	00813083          	ld	ra,8(sp)
    8000239c:	00013403          	ld	s0,0(sp)
    800023a0:	01010113          	addi	sp,sp,16
    800023a4:	00008067          	ret

00000000800023a8 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    800023a8:	ff010113          	addi	sp,sp,-16
    800023ac:	00113423          	sd	ra,8(sp)
    800023b0:	00813023          	sd	s0,0(sp)
    800023b4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800023b8:	fffff097          	auipc	ra,0xfffff
    800023bc:	dfc080e7          	jalr	-516(ra) # 800011b4 <_Z8mem_freePv>
}
    800023c0:	00813083          	ld	ra,8(sp)
    800023c4:	00013403          	ld	s0,0(sp)
    800023c8:	01010113          	addi	sp,sp,16
    800023cc:	00008067          	ret

00000000800023d0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800023d0:	ff010113          	addi	sp,sp,-16
    800023d4:	00113423          	sd	ra,8(sp)
    800023d8:	00813023          	sd	s0,0(sp)
    800023dc:	01010413          	addi	s0,sp,16
    800023e0:	00004797          	auipc	a5,0x4
    800023e4:	b6878793          	addi	a5,a5,-1176 # 80005f48 <_ZTV6Thread+0x10>
    800023e8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    800023ec:	00850513          	addi	a0,a0,8
    800023f0:	fffff097          	auipc	ra,0xfffff
    800023f4:	df8080e7          	jalr	-520(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800023f8:	00813083          	ld	ra,8(sp)
    800023fc:	00013403          	ld	s0,0(sp)
    80002400:	01010113          	addi	sp,sp,16
    80002404:	00008067          	ret

0000000080002408 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002408:	ff010113          	addi	sp,sp,-16
    8000240c:	00113423          	sd	ra,8(sp)
    80002410:	00813023          	sd	s0,0(sp)
    80002414:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002418:	00000097          	auipc	ra,0x0
    8000241c:	134080e7          	jalr	308(ra) # 8000254c <_ZN15MemoryAllocator9mem_allocEm>
}
    80002420:	00813083          	ld	ra,8(sp)
    80002424:	00013403          	ld	s0,0(sp)
    80002428:	01010113          	addi	sp,sp,16
    8000242c:	00008067          	ret

0000000080002430 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002430:	ff010113          	addi	sp,sp,-16
    80002434:	00113423          	sd	ra,8(sp)
    80002438:	00813023          	sd	s0,0(sp)
    8000243c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002440:	00000097          	auipc	ra,0x0
    80002444:	270080e7          	jalr	624(ra) # 800026b0 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002448:	00813083          	ld	ra,8(sp)
    8000244c:	00013403          	ld	s0,0(sp)
    80002450:	01010113          	addi	sp,sp,16
    80002454:	00008067          	ret

0000000080002458 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002458:	fe010113          	addi	sp,sp,-32
    8000245c:	00113c23          	sd	ra,24(sp)
    80002460:	00813823          	sd	s0,16(sp)
    80002464:	00913423          	sd	s1,8(sp)
    80002468:	02010413          	addi	s0,sp,32
    8000246c:	00050493          	mv	s1,a0
}
    80002470:	00000097          	auipc	ra,0x0
    80002474:	e6c080e7          	jalr	-404(ra) # 800022dc <_ZN6ThreadD1Ev>
    80002478:	00048513          	mv	a0,s1
    8000247c:	00000097          	auipc	ra,0x0
    80002480:	fb4080e7          	jalr	-76(ra) # 80002430 <_ZN6ThreaddlEPv>
    80002484:	01813083          	ld	ra,24(sp)
    80002488:	01013403          	ld	s0,16(sp)
    8000248c:	00813483          	ld	s1,8(sp)
    80002490:	02010113          	addi	sp,sp,32
    80002494:	00008067          	ret

0000000080002498 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002498:	ff010113          	addi	sp,sp,-16
    8000249c:	00113423          	sd	ra,8(sp)
    800024a0:	00813023          	sd	s0,0(sp)
    800024a4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800024a8:	fffff097          	auipc	ra,0xfffff
    800024ac:	dac080e7          	jalr	-596(ra) # 80001254 <_Z15thread_dispatchv>
}
    800024b0:	00813083          	ld	ra,8(sp)
    800024b4:	00013403          	ld	s0,0(sp)
    800024b8:	01010113          	addi	sp,sp,16
    800024bc:	00008067          	ret

00000000800024c0 <_ZN6Thread5startEv>:
int Thread::start() {
    800024c0:	ff010113          	addi	sp,sp,-16
    800024c4:	00113423          	sd	ra,8(sp)
    800024c8:	00813023          	sd	s0,0(sp)
    800024cc:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    800024d0:	00850513          	addi	a0,a0,8
    800024d4:	fffff097          	auipc	ra,0xfffff
    800024d8:	ddc080e7          	jalr	-548(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    800024dc:	00000513          	li	a0,0
    800024e0:	00813083          	ld	ra,8(sp)
    800024e4:	00013403          	ld	s0,0(sp)
    800024e8:	01010113          	addi	sp,sp,16
    800024ec:	00008067          	ret

00000000800024f0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800024f0:	ff010113          	addi	sp,sp,-16
    800024f4:	00113423          	sd	ra,8(sp)
    800024f8:	00813023          	sd	s0,0(sp)
    800024fc:	01010413          	addi	s0,sp,16
    80002500:	00004797          	auipc	a5,0x4
    80002504:	a4878793          	addi	a5,a5,-1464 # 80005f48 <_ZTV6Thread+0x10>
    80002508:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, threadWrapper, this);
    8000250c:	00050613          	mv	a2,a0
    80002510:	00000597          	auipc	a1,0x0
    80002514:	da058593          	addi	a1,a1,-608 # 800022b0 <_Z13threadWrapperPv>
    80002518:	00850513          	addi	a0,a0,8
    8000251c:	fffff097          	auipc	ra,0xfffff
    80002520:	ccc080e7          	jalr	-820(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002524:	00813083          	ld	ra,8(sp)
    80002528:	00013403          	ld	s0,0(sp)
    8000252c:	01010113          	addi	sp,sp,16
    80002530:	00008067          	ret

0000000080002534 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813423          	sd	s0,8(sp)
    8000253c:	01010413          	addi	s0,sp,16
    80002540:	00813403          	ld	s0,8(sp)
    80002544:	01010113          	addi	sp,sp,16
    80002548:	00008067          	ret

000000008000254c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    8000254c:	ff010113          	addi	sp,sp,-16
    80002550:	00813423          	sd	s0,8(sp)
    80002554:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002558:	00004797          	auipc	a5,0x4
    8000255c:	ab87b783          	ld	a5,-1352(a5) # 80006010 <_ZN15MemoryAllocator4headE>
    80002560:	02078c63          	beqz	a5,80002598 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002564:	00004717          	auipc	a4,0x4
    80002568:	a2473703          	ld	a4,-1500(a4) # 80005f88 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000256c:	00073703          	ld	a4,0(a4)
    80002570:	12e78c63          	beq	a5,a4,800026a8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002574:	00850713          	addi	a4,a0,8
    80002578:	00675813          	srli	a6,a4,0x6
    8000257c:	03f77793          	andi	a5,a4,63
    80002580:	00f037b3          	snez	a5,a5
    80002584:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80002588:	00004517          	auipc	a0,0x4
    8000258c:	a8853503          	ld	a0,-1400(a0) # 80006010 <_ZN15MemoryAllocator4headE>
    80002590:	00000613          	li	a2,0
    80002594:	0a80006f          	j	8000263c <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80002598:	00004697          	auipc	a3,0x4
    8000259c:	9d06b683          	ld	a3,-1584(a3) # 80005f68 <_GLOBAL_OFFSET_TABLE_+0x8>
    800025a0:	0006b783          	ld	a5,0(a3)
    800025a4:	00004717          	auipc	a4,0x4
    800025a8:	a6f73623          	sd	a5,-1428(a4) # 80006010 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800025ac:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800025b0:	00004717          	auipc	a4,0x4
    800025b4:	9d873703          	ld	a4,-1576(a4) # 80005f88 <_GLOBAL_OFFSET_TABLE_+0x28>
    800025b8:	00073703          	ld	a4,0(a4)
    800025bc:	0006b683          	ld	a3,0(a3)
    800025c0:	40d70733          	sub	a4,a4,a3
    800025c4:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800025c8:	0007b823          	sd	zero,16(a5)
    800025cc:	fa9ff06f          	j	80002574 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800025d0:	00060e63          	beqz	a2,800025ec <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800025d4:	01063703          	ld	a4,16(a2)
    800025d8:	04070a63          	beqz	a4,8000262c <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800025dc:	01073703          	ld	a4,16(a4)
    800025e0:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800025e4:	00078813          	mv	a6,a5
    800025e8:	0ac0006f          	j	80002694 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800025ec:	01053703          	ld	a4,16(a0)
    800025f0:	00070a63          	beqz	a4,80002604 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    800025f4:	00004697          	auipc	a3,0x4
    800025f8:	a0e6be23          	sd	a4,-1508(a3) # 80006010 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800025fc:	00078813          	mv	a6,a5
    80002600:	0940006f          	j	80002694 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002604:	00004717          	auipc	a4,0x4
    80002608:	98473703          	ld	a4,-1660(a4) # 80005f88 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000260c:	00073703          	ld	a4,0(a4)
    80002610:	00004697          	auipc	a3,0x4
    80002614:	a0e6b023          	sd	a4,-1536(a3) # 80006010 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002618:	00078813          	mv	a6,a5
    8000261c:	0780006f          	j	80002694 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002620:	00004797          	auipc	a5,0x4
    80002624:	9ee7b823          	sd	a4,-1552(a5) # 80006010 <_ZN15MemoryAllocator4headE>
    80002628:	06c0006f          	j	80002694 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    8000262c:	00078813          	mv	a6,a5
    80002630:	0640006f          	j	80002694 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002634:	00050613          	mv	a2,a0
        curr = curr->next;
    80002638:	01053503          	ld	a0,16(a0)
    while(curr) {
    8000263c:	06050063          	beqz	a0,8000269c <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002640:	00853783          	ld	a5,8(a0)
    80002644:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002648:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000264c:	fee7e4e3          	bltu	a5,a4,80002634 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002650:	ff06e2e3          	bltu	a3,a6,80002634 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002654:	f7068ee3          	beq	a3,a6,800025d0 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002658:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000265c:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002660:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002664:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002668:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    8000266c:	01053783          	ld	a5,16(a0)
    80002670:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002674:	fa0606e3          	beqz	a2,80002620 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002678:	01063783          	ld	a5,16(a2)
    8000267c:	00078663          	beqz	a5,80002688 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002680:	0107b783          	ld	a5,16(a5)
    80002684:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80002688:	01063783          	ld	a5,16(a2)
    8000268c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002690:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002694:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80002698:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    8000269c:	00813403          	ld	s0,8(sp)
    800026a0:	01010113          	addi	sp,sp,16
    800026a4:	00008067          	ret
        return nullptr;
    800026a8:	00000513          	li	a0,0
    800026ac:	ff1ff06f          	j	8000269c <_ZN15MemoryAllocator9mem_allocEm+0x150>

00000000800026b0 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800026b0:	ff010113          	addi	sp,sp,-16
    800026b4:	00813423          	sd	s0,8(sp)
    800026b8:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800026bc:	16050063          	beqz	a0,8000281c <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800026c0:	ff850713          	addi	a4,a0,-8
    800026c4:	00004797          	auipc	a5,0x4
    800026c8:	8a47b783          	ld	a5,-1884(a5) # 80005f68 <_GLOBAL_OFFSET_TABLE_+0x8>
    800026cc:	0007b783          	ld	a5,0(a5)
    800026d0:	14f76a63          	bltu	a4,a5,80002824 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800026d4:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800026d8:	fff58693          	addi	a3,a1,-1
    800026dc:	00d706b3          	add	a3,a4,a3
    800026e0:	00004617          	auipc	a2,0x4
    800026e4:	8a863603          	ld	a2,-1880(a2) # 80005f88 <_GLOBAL_OFFSET_TABLE_+0x28>
    800026e8:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800026ec:	14c6f063          	bgeu	a3,a2,8000282c <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800026f0:	14070263          	beqz	a4,80002834 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    800026f4:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800026f8:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800026fc:	14079063          	bnez	a5,8000283c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002700:	03f00793          	li	a5,63
    80002704:	14b7f063          	bgeu	a5,a1,80002844 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002708:	00004797          	auipc	a5,0x4
    8000270c:	9087b783          	ld	a5,-1784(a5) # 80006010 <_ZN15MemoryAllocator4headE>
    80002710:	02f60063          	beq	a2,a5,80002730 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002714:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002718:	02078a63          	beqz	a5,8000274c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    8000271c:	0007b683          	ld	a3,0(a5)
    80002720:	02e6f663          	bgeu	a3,a4,8000274c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002724:	00078613          	mv	a2,a5
        curr = curr->next;
    80002728:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000272c:	fedff06f          	j	80002718 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002730:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002734:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002738:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000273c:	00004797          	auipc	a5,0x4
    80002740:	8ce7ba23          	sd	a4,-1836(a5) # 80006010 <_ZN15MemoryAllocator4headE>
        return 0;
    80002744:	00000513          	li	a0,0
    80002748:	0480006f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    8000274c:	04060863          	beqz	a2,8000279c <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002750:	00063683          	ld	a3,0(a2)
    80002754:	00863803          	ld	a6,8(a2)
    80002758:	010686b3          	add	a3,a3,a6
    8000275c:	08e68a63          	beq	a3,a4,800027f0 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002760:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002764:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80002768:	01063683          	ld	a3,16(a2)
    8000276c:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002770:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002774:	0e078063          	beqz	a5,80002854 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80002778:	0007b583          	ld	a1,0(a5)
    8000277c:	00073683          	ld	a3,0(a4)
    80002780:	00873603          	ld	a2,8(a4)
    80002784:	00c686b3          	add	a3,a3,a2
    80002788:	06d58c63          	beq	a1,a3,80002800 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    8000278c:	00000513          	li	a0,0
}
    80002790:	00813403          	ld	s0,8(sp)
    80002794:	01010113          	addi	sp,sp,16
    80002798:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    8000279c:	0a078863          	beqz	a5,8000284c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800027a0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800027a4:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800027a8:	00004797          	auipc	a5,0x4
    800027ac:	8687b783          	ld	a5,-1944(a5) # 80006010 <_ZN15MemoryAllocator4headE>
    800027b0:	0007b603          	ld	a2,0(a5)
    800027b4:	00b706b3          	add	a3,a4,a1
    800027b8:	00d60c63          	beq	a2,a3,800027d0 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800027bc:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800027c0:	00004797          	auipc	a5,0x4
    800027c4:	84e7b823          	sd	a4,-1968(a5) # 80006010 <_ZN15MemoryAllocator4headE>
            return 0;
    800027c8:	00000513          	li	a0,0
    800027cc:	fc5ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800027d0:	0087b783          	ld	a5,8(a5)
    800027d4:	00b785b3          	add	a1,a5,a1
    800027d8:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800027dc:	00004797          	auipc	a5,0x4
    800027e0:	8347b783          	ld	a5,-1996(a5) # 80006010 <_ZN15MemoryAllocator4headE>
    800027e4:	0107b783          	ld	a5,16(a5)
    800027e8:	00f53423          	sd	a5,8(a0)
    800027ec:	fd5ff06f          	j	800027c0 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800027f0:	00b805b3          	add	a1,a6,a1
    800027f4:	00b63423          	sd	a1,8(a2)
    800027f8:	00060713          	mv	a4,a2
    800027fc:	f79ff06f          	j	80002774 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002800:	0087b683          	ld	a3,8(a5)
    80002804:	00d60633          	add	a2,a2,a3
    80002808:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000280c:	0107b783          	ld	a5,16(a5)
    80002810:	00f73823          	sd	a5,16(a4)
    return 0;
    80002814:	00000513          	li	a0,0
    80002818:	f79ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    8000281c:	fff00513          	li	a0,-1
    80002820:	f71ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002824:	fff00513          	li	a0,-1
    80002828:	f69ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    8000282c:	fff00513          	li	a0,-1
    80002830:	f61ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002834:	fff00513          	li	a0,-1
    80002838:	f59ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000283c:	fff00513          	li	a0,-1
    80002840:	f51ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002844:	fff00513          	li	a0,-1
    80002848:	f49ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    8000284c:	fff00513          	li	a0,-1
    80002850:	f41ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002854:	00000513          	li	a0,0
    80002858:	f39ff06f          	j	80002790 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000285c <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    8000285c:	fd010113          	addi	sp,sp,-48
    80002860:	02113423          	sd	ra,40(sp)
    80002864:	02813023          	sd	s0,32(sp)
    80002868:	00913c23          	sd	s1,24(sp)
    8000286c:	01213823          	sd	s2,16(sp)
    80002870:	03010413          	addi	s0,sp,48
    80002874:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002878:	100027f3          	csrr	a5,sstatus
    8000287c:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    80002880:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002884:	00200793          	li	a5,2
    80002888:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    8000288c:	0004c503          	lbu	a0,0(s1)
    80002890:	00050a63          	beqz	a0,800028a4 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    80002894:	00002097          	auipc	ra,0x2
    80002898:	268080e7          	jalr	616(ra) # 80004afc <__putc>
        string++;
    8000289c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800028a0:	fedff06f          	j	8000288c <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800028a4:	0009091b          	sext.w	s2,s2
    800028a8:	00297913          	andi	s2,s2,2
    800028ac:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800028b0:	10092073          	csrs	sstatus,s2
}
    800028b4:	02813083          	ld	ra,40(sp)
    800028b8:	02013403          	ld	s0,32(sp)
    800028bc:	01813483          	ld	s1,24(sp)
    800028c0:	01013903          	ld	s2,16(sp)
    800028c4:	03010113          	addi	sp,sp,48
    800028c8:	00008067          	ret

00000000800028cc <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    800028cc:	fc010113          	addi	sp,sp,-64
    800028d0:	02113c23          	sd	ra,56(sp)
    800028d4:	02813823          	sd	s0,48(sp)
    800028d8:	02913423          	sd	s1,40(sp)
    800028dc:	03213023          	sd	s2,32(sp)
    800028e0:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800028e4:	100027f3          	csrr	a5,sstatus
    800028e8:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    800028ec:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800028f0:	00200793          	li	a5,2
    800028f4:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    800028f8:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    800028fc:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002900:	00a00613          	li	a2,10
    80002904:	02c5773b          	remuw	a4,a0,a2
    80002908:	02071693          	slli	a3,a4,0x20
    8000290c:	0206d693          	srli	a3,a3,0x20
    80002910:	00003717          	auipc	a4,0x3
    80002914:	88870713          	addi	a4,a4,-1912 # 80005198 <_ZZ12printIntegermE6digits>
    80002918:	00d70733          	add	a4,a4,a3
    8000291c:	00074703          	lbu	a4,0(a4)
    80002920:	fe040693          	addi	a3,s0,-32
    80002924:	009687b3          	add	a5,a3,s1
    80002928:	0014849b          	addiw	s1,s1,1
    8000292c:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002930:	0005071b          	sext.w	a4,a0
    80002934:	02c5553b          	divuw	a0,a0,a2
    80002938:	00900793          	li	a5,9
    8000293c:	fce7e2e3          	bltu	a5,a4,80002900 <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80002940:	fff4849b          	addiw	s1,s1,-1
    80002944:	0004ce63          	bltz	s1,80002960 <_Z12printIntegerm+0x94>
    80002948:	fe040793          	addi	a5,s0,-32
    8000294c:	009787b3          	add	a5,a5,s1
    80002950:	ff07c503          	lbu	a0,-16(a5)
    80002954:	00002097          	auipc	ra,0x2
    80002958:	1a8080e7          	jalr	424(ra) # 80004afc <__putc>
    8000295c:	fe5ff06f          	j	80002940 <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002960:	0009091b          	sext.w	s2,s2
    80002964:	00297913          	andi	s2,s2,2
    80002968:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000296c:	10092073          	csrs	sstatus,s2
}
    80002970:	03813083          	ld	ra,56(sp)
    80002974:	03013403          	ld	s0,48(sp)
    80002978:	02813483          	ld	s1,40(sp)
    8000297c:	02013903          	ld	s2,32(sp)
    80002980:	04010113          	addi	sp,sp,64
    80002984:	00008067          	ret

0000000080002988 <_Z10printErrorv>:
void printError() {
    80002988:	fc010113          	addi	sp,sp,-64
    8000298c:	02113c23          	sd	ra,56(sp)
    80002990:	02813823          	sd	s0,48(sp)
    80002994:	02913423          	sd	s1,40(sp)
    80002998:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000299c:	100027f3          	csrr	a5,sstatus
    800029a0:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800029a4:	fd843483          	ld	s1,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800029a8:	00200793          	li	a5,2
    800029ac:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    printString("scause: ");
    800029b0:	00002517          	auipc	a0,0x2
    800029b4:	7c050513          	addi	a0,a0,1984 # 80005170 <CONSOLE_STATUS+0x160>
    800029b8:	00000097          	auipc	ra,0x0
    800029bc:	ea4080e7          	jalr	-348(ra) # 8000285c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800029c0:	142027f3          	csrr	a5,scause
    800029c4:	fcf43823          	sd	a5,-48(s0)
        return scause;
    800029c8:	fd043503          	ld	a0,-48(s0)
    printInteger(Kernel::r_scause());
    800029cc:	00000097          	auipc	ra,0x0
    800029d0:	f00080e7          	jalr	-256(ra) # 800028cc <_Z12printIntegerm>
    printString("\nsepc: ");
    800029d4:	00002517          	auipc	a0,0x2
    800029d8:	7ac50513          	addi	a0,a0,1964 # 80005180 <CONSOLE_STATUS+0x170>
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	e80080e7          	jalr	-384(ra) # 8000285c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800029e4:	141027f3          	csrr	a5,sepc
    800029e8:	fcf43423          	sd	a5,-56(s0)
        return sepc;
    800029ec:	fc843503          	ld	a0,-56(s0)
    printInteger(Kernel::r_sepc());
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	edc080e7          	jalr	-292(ra) # 800028cc <_Z12printIntegerm>
    printString("\nstval: ");
    800029f8:	00002517          	auipc	a0,0x2
    800029fc:	79050513          	addi	a0,a0,1936 # 80005188 <CONSOLE_STATUS+0x178>
    80002a00:	00000097          	auipc	ra,0x0
    80002a04:	e5c080e7          	jalr	-420(ra) # 8000285c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002a08:	143027f3          	csrr	a5,stval
    80002a0c:	fcf43023          	sd	a5,-64(s0)
        return stval;
    80002a10:	fc043503          	ld	a0,-64(s0)
    printInteger(Kernel::r_stval());
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	eb8080e7          	jalr	-328(ra) # 800028cc <_Z12printIntegerm>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002a1c:	0004849b          	sext.w	s1,s1
    80002a20:	0024f493          	andi	s1,s1,2
    80002a24:	0004849b          	sext.w	s1,s1
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002a28:	1004a073          	csrs	sstatus,s1
    80002a2c:	03813083          	ld	ra,56(sp)
    80002a30:	03013403          	ld	s0,48(sp)
    80002a34:	02813483          	ld	s1,40(sp)
    80002a38:	04010113          	addi	sp,sp,64
    80002a3c:	00008067          	ret

0000000080002a40 <start>:
    80002a40:	ff010113          	addi	sp,sp,-16
    80002a44:	00813423          	sd	s0,8(sp)
    80002a48:	01010413          	addi	s0,sp,16
    80002a4c:	300027f3          	csrr	a5,mstatus
    80002a50:	ffffe737          	lui	a4,0xffffe
    80002a54:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff757f>
    80002a58:	00e7f7b3          	and	a5,a5,a4
    80002a5c:	00001737          	lui	a4,0x1
    80002a60:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002a64:	00e7e7b3          	or	a5,a5,a4
    80002a68:	30079073          	csrw	mstatus,a5
    80002a6c:	00000797          	auipc	a5,0x0
    80002a70:	16078793          	addi	a5,a5,352 # 80002bcc <system_main>
    80002a74:	34179073          	csrw	mepc,a5
    80002a78:	00000793          	li	a5,0
    80002a7c:	18079073          	csrw	satp,a5
    80002a80:	000107b7          	lui	a5,0x10
    80002a84:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002a88:	30279073          	csrw	medeleg,a5
    80002a8c:	30379073          	csrw	mideleg,a5
    80002a90:	104027f3          	csrr	a5,sie
    80002a94:	2227e793          	ori	a5,a5,546
    80002a98:	10479073          	csrw	sie,a5
    80002a9c:	fff00793          	li	a5,-1
    80002aa0:	00a7d793          	srli	a5,a5,0xa
    80002aa4:	3b079073          	csrw	pmpaddr0,a5
    80002aa8:	00f00793          	li	a5,15
    80002aac:	3a079073          	csrw	pmpcfg0,a5
    80002ab0:	f14027f3          	csrr	a5,mhartid
    80002ab4:	0200c737          	lui	a4,0x200c
    80002ab8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002abc:	0007869b          	sext.w	a3,a5
    80002ac0:	00269713          	slli	a4,a3,0x2
    80002ac4:	000f4637          	lui	a2,0xf4
    80002ac8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002acc:	00d70733          	add	a4,a4,a3
    80002ad0:	0037979b          	slliw	a5,a5,0x3
    80002ad4:	020046b7          	lui	a3,0x2004
    80002ad8:	00d787b3          	add	a5,a5,a3
    80002adc:	00c585b3          	add	a1,a1,a2
    80002ae0:	00371693          	slli	a3,a4,0x3
    80002ae4:	00003717          	auipc	a4,0x3
    80002ae8:	53c70713          	addi	a4,a4,1340 # 80006020 <timer_scratch>
    80002aec:	00b7b023          	sd	a1,0(a5)
    80002af0:	00d70733          	add	a4,a4,a3
    80002af4:	00f73c23          	sd	a5,24(a4)
    80002af8:	02c73023          	sd	a2,32(a4)
    80002afc:	34071073          	csrw	mscratch,a4
    80002b00:	00000797          	auipc	a5,0x0
    80002b04:	6e078793          	addi	a5,a5,1760 # 800031e0 <timervec>
    80002b08:	30579073          	csrw	mtvec,a5
    80002b0c:	300027f3          	csrr	a5,mstatus
    80002b10:	0087e793          	ori	a5,a5,8
    80002b14:	30079073          	csrw	mstatus,a5
    80002b18:	304027f3          	csrr	a5,mie
    80002b1c:	0807e793          	ori	a5,a5,128
    80002b20:	30479073          	csrw	mie,a5
    80002b24:	f14027f3          	csrr	a5,mhartid
    80002b28:	0007879b          	sext.w	a5,a5
    80002b2c:	00078213          	mv	tp,a5
    80002b30:	30200073          	mret
    80002b34:	00813403          	ld	s0,8(sp)
    80002b38:	01010113          	addi	sp,sp,16
    80002b3c:	00008067          	ret

0000000080002b40 <timerinit>:
    80002b40:	ff010113          	addi	sp,sp,-16
    80002b44:	00813423          	sd	s0,8(sp)
    80002b48:	01010413          	addi	s0,sp,16
    80002b4c:	f14027f3          	csrr	a5,mhartid
    80002b50:	0200c737          	lui	a4,0x200c
    80002b54:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002b58:	0007869b          	sext.w	a3,a5
    80002b5c:	00269713          	slli	a4,a3,0x2
    80002b60:	000f4637          	lui	a2,0xf4
    80002b64:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002b68:	00d70733          	add	a4,a4,a3
    80002b6c:	0037979b          	slliw	a5,a5,0x3
    80002b70:	020046b7          	lui	a3,0x2004
    80002b74:	00d787b3          	add	a5,a5,a3
    80002b78:	00c585b3          	add	a1,a1,a2
    80002b7c:	00371693          	slli	a3,a4,0x3
    80002b80:	00003717          	auipc	a4,0x3
    80002b84:	4a070713          	addi	a4,a4,1184 # 80006020 <timer_scratch>
    80002b88:	00b7b023          	sd	a1,0(a5)
    80002b8c:	00d70733          	add	a4,a4,a3
    80002b90:	00f73c23          	sd	a5,24(a4)
    80002b94:	02c73023          	sd	a2,32(a4)
    80002b98:	34071073          	csrw	mscratch,a4
    80002b9c:	00000797          	auipc	a5,0x0
    80002ba0:	64478793          	addi	a5,a5,1604 # 800031e0 <timervec>
    80002ba4:	30579073          	csrw	mtvec,a5
    80002ba8:	300027f3          	csrr	a5,mstatus
    80002bac:	0087e793          	ori	a5,a5,8
    80002bb0:	30079073          	csrw	mstatus,a5
    80002bb4:	304027f3          	csrr	a5,mie
    80002bb8:	0807e793          	ori	a5,a5,128
    80002bbc:	30479073          	csrw	mie,a5
    80002bc0:	00813403          	ld	s0,8(sp)
    80002bc4:	01010113          	addi	sp,sp,16
    80002bc8:	00008067          	ret

0000000080002bcc <system_main>:
    80002bcc:	fe010113          	addi	sp,sp,-32
    80002bd0:	00813823          	sd	s0,16(sp)
    80002bd4:	00913423          	sd	s1,8(sp)
    80002bd8:	00113c23          	sd	ra,24(sp)
    80002bdc:	02010413          	addi	s0,sp,32
    80002be0:	00000097          	auipc	ra,0x0
    80002be4:	0c4080e7          	jalr	196(ra) # 80002ca4 <cpuid>
    80002be8:	00003497          	auipc	s1,0x3
    80002bec:	3c848493          	addi	s1,s1,968 # 80005fb0 <started>
    80002bf0:	02050263          	beqz	a0,80002c14 <system_main+0x48>
    80002bf4:	0004a783          	lw	a5,0(s1)
    80002bf8:	0007879b          	sext.w	a5,a5
    80002bfc:	fe078ce3          	beqz	a5,80002bf4 <system_main+0x28>
    80002c00:	0ff0000f          	fence
    80002c04:	00002517          	auipc	a0,0x2
    80002c08:	5d450513          	addi	a0,a0,1492 # 800051d8 <_ZZ12printIntegermE6digits+0x40>
    80002c0c:	00001097          	auipc	ra,0x1
    80002c10:	a70080e7          	jalr	-1424(ra) # 8000367c <panic>
    80002c14:	00001097          	auipc	ra,0x1
    80002c18:	9c4080e7          	jalr	-1596(ra) # 800035d8 <consoleinit>
    80002c1c:	00001097          	auipc	ra,0x1
    80002c20:	150080e7          	jalr	336(ra) # 80003d6c <printfinit>
    80002c24:	00002517          	auipc	a0,0x2
    80002c28:	69450513          	addi	a0,a0,1684 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80002c2c:	00001097          	auipc	ra,0x1
    80002c30:	aac080e7          	jalr	-1364(ra) # 800036d8 <__printf>
    80002c34:	00002517          	auipc	a0,0x2
    80002c38:	57450513          	addi	a0,a0,1396 # 800051a8 <_ZZ12printIntegermE6digits+0x10>
    80002c3c:	00001097          	auipc	ra,0x1
    80002c40:	a9c080e7          	jalr	-1380(ra) # 800036d8 <__printf>
    80002c44:	00002517          	auipc	a0,0x2
    80002c48:	67450513          	addi	a0,a0,1652 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    80002c4c:	00001097          	auipc	ra,0x1
    80002c50:	a8c080e7          	jalr	-1396(ra) # 800036d8 <__printf>
    80002c54:	00001097          	auipc	ra,0x1
    80002c58:	4a4080e7          	jalr	1188(ra) # 800040f8 <kinit>
    80002c5c:	00000097          	auipc	ra,0x0
    80002c60:	148080e7          	jalr	328(ra) # 80002da4 <trapinit>
    80002c64:	00000097          	auipc	ra,0x0
    80002c68:	16c080e7          	jalr	364(ra) # 80002dd0 <trapinithart>
    80002c6c:	00000097          	auipc	ra,0x0
    80002c70:	5b4080e7          	jalr	1460(ra) # 80003220 <plicinit>
    80002c74:	00000097          	auipc	ra,0x0
    80002c78:	5d4080e7          	jalr	1492(ra) # 80003248 <plicinithart>
    80002c7c:	00000097          	auipc	ra,0x0
    80002c80:	078080e7          	jalr	120(ra) # 80002cf4 <userinit>
    80002c84:	0ff0000f          	fence
    80002c88:	00100793          	li	a5,1
    80002c8c:	00002517          	auipc	a0,0x2
    80002c90:	53450513          	addi	a0,a0,1332 # 800051c0 <_ZZ12printIntegermE6digits+0x28>
    80002c94:	00f4a023          	sw	a5,0(s1)
    80002c98:	00001097          	auipc	ra,0x1
    80002c9c:	a40080e7          	jalr	-1472(ra) # 800036d8 <__printf>
    80002ca0:	0000006f          	j	80002ca0 <system_main+0xd4>

0000000080002ca4 <cpuid>:
    80002ca4:	ff010113          	addi	sp,sp,-16
    80002ca8:	00813423          	sd	s0,8(sp)
    80002cac:	01010413          	addi	s0,sp,16
    80002cb0:	00020513          	mv	a0,tp
    80002cb4:	00813403          	ld	s0,8(sp)
    80002cb8:	0005051b          	sext.w	a0,a0
    80002cbc:	01010113          	addi	sp,sp,16
    80002cc0:	00008067          	ret

0000000080002cc4 <mycpu>:
    80002cc4:	ff010113          	addi	sp,sp,-16
    80002cc8:	00813423          	sd	s0,8(sp)
    80002ccc:	01010413          	addi	s0,sp,16
    80002cd0:	00020793          	mv	a5,tp
    80002cd4:	00813403          	ld	s0,8(sp)
    80002cd8:	0007879b          	sext.w	a5,a5
    80002cdc:	00779793          	slli	a5,a5,0x7
    80002ce0:	00004517          	auipc	a0,0x4
    80002ce4:	37050513          	addi	a0,a0,880 # 80007050 <cpus>
    80002ce8:	00f50533          	add	a0,a0,a5
    80002cec:	01010113          	addi	sp,sp,16
    80002cf0:	00008067          	ret

0000000080002cf4 <userinit>:
    80002cf4:	ff010113          	addi	sp,sp,-16
    80002cf8:	00813423          	sd	s0,8(sp)
    80002cfc:	01010413          	addi	s0,sp,16
    80002d00:	00813403          	ld	s0,8(sp)
    80002d04:	01010113          	addi	sp,sp,16
    80002d08:	fffff317          	auipc	t1,0xfffff
    80002d0c:	0b430067          	jr	180(t1) # 80001dbc <main>

0000000080002d10 <either_copyout>:
    80002d10:	ff010113          	addi	sp,sp,-16
    80002d14:	00813023          	sd	s0,0(sp)
    80002d18:	00113423          	sd	ra,8(sp)
    80002d1c:	01010413          	addi	s0,sp,16
    80002d20:	02051663          	bnez	a0,80002d4c <either_copyout+0x3c>
    80002d24:	00058513          	mv	a0,a1
    80002d28:	00060593          	mv	a1,a2
    80002d2c:	0006861b          	sext.w	a2,a3
    80002d30:	00002097          	auipc	ra,0x2
    80002d34:	c54080e7          	jalr	-940(ra) # 80004984 <__memmove>
    80002d38:	00813083          	ld	ra,8(sp)
    80002d3c:	00013403          	ld	s0,0(sp)
    80002d40:	00000513          	li	a0,0
    80002d44:	01010113          	addi	sp,sp,16
    80002d48:	00008067          	ret
    80002d4c:	00002517          	auipc	a0,0x2
    80002d50:	4b450513          	addi	a0,a0,1204 # 80005200 <_ZZ12printIntegermE6digits+0x68>
    80002d54:	00001097          	auipc	ra,0x1
    80002d58:	928080e7          	jalr	-1752(ra) # 8000367c <panic>

0000000080002d5c <either_copyin>:
    80002d5c:	ff010113          	addi	sp,sp,-16
    80002d60:	00813023          	sd	s0,0(sp)
    80002d64:	00113423          	sd	ra,8(sp)
    80002d68:	01010413          	addi	s0,sp,16
    80002d6c:	02059463          	bnez	a1,80002d94 <either_copyin+0x38>
    80002d70:	00060593          	mv	a1,a2
    80002d74:	0006861b          	sext.w	a2,a3
    80002d78:	00002097          	auipc	ra,0x2
    80002d7c:	c0c080e7          	jalr	-1012(ra) # 80004984 <__memmove>
    80002d80:	00813083          	ld	ra,8(sp)
    80002d84:	00013403          	ld	s0,0(sp)
    80002d88:	00000513          	li	a0,0
    80002d8c:	01010113          	addi	sp,sp,16
    80002d90:	00008067          	ret
    80002d94:	00002517          	auipc	a0,0x2
    80002d98:	49450513          	addi	a0,a0,1172 # 80005228 <_ZZ12printIntegermE6digits+0x90>
    80002d9c:	00001097          	auipc	ra,0x1
    80002da0:	8e0080e7          	jalr	-1824(ra) # 8000367c <panic>

0000000080002da4 <trapinit>:
    80002da4:	ff010113          	addi	sp,sp,-16
    80002da8:	00813423          	sd	s0,8(sp)
    80002dac:	01010413          	addi	s0,sp,16
    80002db0:	00813403          	ld	s0,8(sp)
    80002db4:	00002597          	auipc	a1,0x2
    80002db8:	49c58593          	addi	a1,a1,1180 # 80005250 <_ZZ12printIntegermE6digits+0xb8>
    80002dbc:	00004517          	auipc	a0,0x4
    80002dc0:	31450513          	addi	a0,a0,788 # 800070d0 <tickslock>
    80002dc4:	01010113          	addi	sp,sp,16
    80002dc8:	00001317          	auipc	t1,0x1
    80002dcc:	5c030067          	jr	1472(t1) # 80004388 <initlock>

0000000080002dd0 <trapinithart>:
    80002dd0:	ff010113          	addi	sp,sp,-16
    80002dd4:	00813423          	sd	s0,8(sp)
    80002dd8:	01010413          	addi	s0,sp,16
    80002ddc:	00000797          	auipc	a5,0x0
    80002de0:	2f478793          	addi	a5,a5,756 # 800030d0 <kernelvec>
    80002de4:	10579073          	csrw	stvec,a5
    80002de8:	00813403          	ld	s0,8(sp)
    80002dec:	01010113          	addi	sp,sp,16
    80002df0:	00008067          	ret

0000000080002df4 <usertrap>:
    80002df4:	ff010113          	addi	sp,sp,-16
    80002df8:	00813423          	sd	s0,8(sp)
    80002dfc:	01010413          	addi	s0,sp,16
    80002e00:	00813403          	ld	s0,8(sp)
    80002e04:	01010113          	addi	sp,sp,16
    80002e08:	00008067          	ret

0000000080002e0c <usertrapret>:
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00813423          	sd	s0,8(sp)
    80002e14:	01010413          	addi	s0,sp,16
    80002e18:	00813403          	ld	s0,8(sp)
    80002e1c:	01010113          	addi	sp,sp,16
    80002e20:	00008067          	ret

0000000080002e24 <kerneltrap>:
    80002e24:	fe010113          	addi	sp,sp,-32
    80002e28:	00813823          	sd	s0,16(sp)
    80002e2c:	00113c23          	sd	ra,24(sp)
    80002e30:	00913423          	sd	s1,8(sp)
    80002e34:	02010413          	addi	s0,sp,32
    80002e38:	142025f3          	csrr	a1,scause
    80002e3c:	100027f3          	csrr	a5,sstatus
    80002e40:	0027f793          	andi	a5,a5,2
    80002e44:	10079c63          	bnez	a5,80002f5c <kerneltrap+0x138>
    80002e48:	142027f3          	csrr	a5,scause
    80002e4c:	0207ce63          	bltz	a5,80002e88 <kerneltrap+0x64>
    80002e50:	00002517          	auipc	a0,0x2
    80002e54:	44850513          	addi	a0,a0,1096 # 80005298 <_ZZ12printIntegermE6digits+0x100>
    80002e58:	00001097          	auipc	ra,0x1
    80002e5c:	880080e7          	jalr	-1920(ra) # 800036d8 <__printf>
    80002e60:	141025f3          	csrr	a1,sepc
    80002e64:	14302673          	csrr	a2,stval
    80002e68:	00002517          	auipc	a0,0x2
    80002e6c:	44050513          	addi	a0,a0,1088 # 800052a8 <_ZZ12printIntegermE6digits+0x110>
    80002e70:	00001097          	auipc	ra,0x1
    80002e74:	868080e7          	jalr	-1944(ra) # 800036d8 <__printf>
    80002e78:	00002517          	auipc	a0,0x2
    80002e7c:	44850513          	addi	a0,a0,1096 # 800052c0 <_ZZ12printIntegermE6digits+0x128>
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	7fc080e7          	jalr	2044(ra) # 8000367c <panic>
    80002e88:	0ff7f713          	andi	a4,a5,255
    80002e8c:	00900693          	li	a3,9
    80002e90:	04d70063          	beq	a4,a3,80002ed0 <kerneltrap+0xac>
    80002e94:	fff00713          	li	a4,-1
    80002e98:	03f71713          	slli	a4,a4,0x3f
    80002e9c:	00170713          	addi	a4,a4,1
    80002ea0:	fae798e3          	bne	a5,a4,80002e50 <kerneltrap+0x2c>
    80002ea4:	00000097          	auipc	ra,0x0
    80002ea8:	e00080e7          	jalr	-512(ra) # 80002ca4 <cpuid>
    80002eac:	06050663          	beqz	a0,80002f18 <kerneltrap+0xf4>
    80002eb0:	144027f3          	csrr	a5,sip
    80002eb4:	ffd7f793          	andi	a5,a5,-3
    80002eb8:	14479073          	csrw	sip,a5
    80002ebc:	01813083          	ld	ra,24(sp)
    80002ec0:	01013403          	ld	s0,16(sp)
    80002ec4:	00813483          	ld	s1,8(sp)
    80002ec8:	02010113          	addi	sp,sp,32
    80002ecc:	00008067          	ret
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	3c4080e7          	jalr	964(ra) # 80003294 <plic_claim>
    80002ed8:	00a00793          	li	a5,10
    80002edc:	00050493          	mv	s1,a0
    80002ee0:	06f50863          	beq	a0,a5,80002f50 <kerneltrap+0x12c>
    80002ee4:	fc050ce3          	beqz	a0,80002ebc <kerneltrap+0x98>
    80002ee8:	00050593          	mv	a1,a0
    80002eec:	00002517          	auipc	a0,0x2
    80002ef0:	38c50513          	addi	a0,a0,908 # 80005278 <_ZZ12printIntegermE6digits+0xe0>
    80002ef4:	00000097          	auipc	ra,0x0
    80002ef8:	7e4080e7          	jalr	2020(ra) # 800036d8 <__printf>
    80002efc:	01013403          	ld	s0,16(sp)
    80002f00:	01813083          	ld	ra,24(sp)
    80002f04:	00048513          	mv	a0,s1
    80002f08:	00813483          	ld	s1,8(sp)
    80002f0c:	02010113          	addi	sp,sp,32
    80002f10:	00000317          	auipc	t1,0x0
    80002f14:	3bc30067          	jr	956(t1) # 800032cc <plic_complete>
    80002f18:	00004517          	auipc	a0,0x4
    80002f1c:	1b850513          	addi	a0,a0,440 # 800070d0 <tickslock>
    80002f20:	00001097          	auipc	ra,0x1
    80002f24:	48c080e7          	jalr	1164(ra) # 800043ac <acquire>
    80002f28:	00003717          	auipc	a4,0x3
    80002f2c:	08c70713          	addi	a4,a4,140 # 80005fb4 <ticks>
    80002f30:	00072783          	lw	a5,0(a4)
    80002f34:	00004517          	auipc	a0,0x4
    80002f38:	19c50513          	addi	a0,a0,412 # 800070d0 <tickslock>
    80002f3c:	0017879b          	addiw	a5,a5,1
    80002f40:	00f72023          	sw	a5,0(a4)
    80002f44:	00001097          	auipc	ra,0x1
    80002f48:	534080e7          	jalr	1332(ra) # 80004478 <release>
    80002f4c:	f65ff06f          	j	80002eb0 <kerneltrap+0x8c>
    80002f50:	00001097          	auipc	ra,0x1
    80002f54:	090080e7          	jalr	144(ra) # 80003fe0 <uartintr>
    80002f58:	fa5ff06f          	j	80002efc <kerneltrap+0xd8>
    80002f5c:	00002517          	auipc	a0,0x2
    80002f60:	2fc50513          	addi	a0,a0,764 # 80005258 <_ZZ12printIntegermE6digits+0xc0>
    80002f64:	00000097          	auipc	ra,0x0
    80002f68:	718080e7          	jalr	1816(ra) # 8000367c <panic>

0000000080002f6c <clockintr>:
    80002f6c:	fe010113          	addi	sp,sp,-32
    80002f70:	00813823          	sd	s0,16(sp)
    80002f74:	00913423          	sd	s1,8(sp)
    80002f78:	00113c23          	sd	ra,24(sp)
    80002f7c:	02010413          	addi	s0,sp,32
    80002f80:	00004497          	auipc	s1,0x4
    80002f84:	15048493          	addi	s1,s1,336 # 800070d0 <tickslock>
    80002f88:	00048513          	mv	a0,s1
    80002f8c:	00001097          	auipc	ra,0x1
    80002f90:	420080e7          	jalr	1056(ra) # 800043ac <acquire>
    80002f94:	00003717          	auipc	a4,0x3
    80002f98:	02070713          	addi	a4,a4,32 # 80005fb4 <ticks>
    80002f9c:	00072783          	lw	a5,0(a4)
    80002fa0:	01013403          	ld	s0,16(sp)
    80002fa4:	01813083          	ld	ra,24(sp)
    80002fa8:	00048513          	mv	a0,s1
    80002fac:	0017879b          	addiw	a5,a5,1
    80002fb0:	00813483          	ld	s1,8(sp)
    80002fb4:	00f72023          	sw	a5,0(a4)
    80002fb8:	02010113          	addi	sp,sp,32
    80002fbc:	00001317          	auipc	t1,0x1
    80002fc0:	4bc30067          	jr	1212(t1) # 80004478 <release>

0000000080002fc4 <devintr>:
    80002fc4:	142027f3          	csrr	a5,scause
    80002fc8:	00000513          	li	a0,0
    80002fcc:	0007c463          	bltz	a5,80002fd4 <devintr+0x10>
    80002fd0:	00008067          	ret
    80002fd4:	fe010113          	addi	sp,sp,-32
    80002fd8:	00813823          	sd	s0,16(sp)
    80002fdc:	00113c23          	sd	ra,24(sp)
    80002fe0:	00913423          	sd	s1,8(sp)
    80002fe4:	02010413          	addi	s0,sp,32
    80002fe8:	0ff7f713          	andi	a4,a5,255
    80002fec:	00900693          	li	a3,9
    80002ff0:	04d70c63          	beq	a4,a3,80003048 <devintr+0x84>
    80002ff4:	fff00713          	li	a4,-1
    80002ff8:	03f71713          	slli	a4,a4,0x3f
    80002ffc:	00170713          	addi	a4,a4,1
    80003000:	00e78c63          	beq	a5,a4,80003018 <devintr+0x54>
    80003004:	01813083          	ld	ra,24(sp)
    80003008:	01013403          	ld	s0,16(sp)
    8000300c:	00813483          	ld	s1,8(sp)
    80003010:	02010113          	addi	sp,sp,32
    80003014:	00008067          	ret
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	c8c080e7          	jalr	-884(ra) # 80002ca4 <cpuid>
    80003020:	06050663          	beqz	a0,8000308c <devintr+0xc8>
    80003024:	144027f3          	csrr	a5,sip
    80003028:	ffd7f793          	andi	a5,a5,-3
    8000302c:	14479073          	csrw	sip,a5
    80003030:	01813083          	ld	ra,24(sp)
    80003034:	01013403          	ld	s0,16(sp)
    80003038:	00813483          	ld	s1,8(sp)
    8000303c:	00200513          	li	a0,2
    80003040:	02010113          	addi	sp,sp,32
    80003044:	00008067          	ret
    80003048:	00000097          	auipc	ra,0x0
    8000304c:	24c080e7          	jalr	588(ra) # 80003294 <plic_claim>
    80003050:	00a00793          	li	a5,10
    80003054:	00050493          	mv	s1,a0
    80003058:	06f50663          	beq	a0,a5,800030c4 <devintr+0x100>
    8000305c:	00100513          	li	a0,1
    80003060:	fa0482e3          	beqz	s1,80003004 <devintr+0x40>
    80003064:	00048593          	mv	a1,s1
    80003068:	00002517          	auipc	a0,0x2
    8000306c:	21050513          	addi	a0,a0,528 # 80005278 <_ZZ12printIntegermE6digits+0xe0>
    80003070:	00000097          	auipc	ra,0x0
    80003074:	668080e7          	jalr	1640(ra) # 800036d8 <__printf>
    80003078:	00048513          	mv	a0,s1
    8000307c:	00000097          	auipc	ra,0x0
    80003080:	250080e7          	jalr	592(ra) # 800032cc <plic_complete>
    80003084:	00100513          	li	a0,1
    80003088:	f7dff06f          	j	80003004 <devintr+0x40>
    8000308c:	00004517          	auipc	a0,0x4
    80003090:	04450513          	addi	a0,a0,68 # 800070d0 <tickslock>
    80003094:	00001097          	auipc	ra,0x1
    80003098:	318080e7          	jalr	792(ra) # 800043ac <acquire>
    8000309c:	00003717          	auipc	a4,0x3
    800030a0:	f1870713          	addi	a4,a4,-232 # 80005fb4 <ticks>
    800030a4:	00072783          	lw	a5,0(a4)
    800030a8:	00004517          	auipc	a0,0x4
    800030ac:	02850513          	addi	a0,a0,40 # 800070d0 <tickslock>
    800030b0:	0017879b          	addiw	a5,a5,1
    800030b4:	00f72023          	sw	a5,0(a4)
    800030b8:	00001097          	auipc	ra,0x1
    800030bc:	3c0080e7          	jalr	960(ra) # 80004478 <release>
    800030c0:	f65ff06f          	j	80003024 <devintr+0x60>
    800030c4:	00001097          	auipc	ra,0x1
    800030c8:	f1c080e7          	jalr	-228(ra) # 80003fe0 <uartintr>
    800030cc:	fadff06f          	j	80003078 <devintr+0xb4>

00000000800030d0 <kernelvec>:
    800030d0:	f0010113          	addi	sp,sp,-256
    800030d4:	00113023          	sd	ra,0(sp)
    800030d8:	00213423          	sd	sp,8(sp)
    800030dc:	00313823          	sd	gp,16(sp)
    800030e0:	00413c23          	sd	tp,24(sp)
    800030e4:	02513023          	sd	t0,32(sp)
    800030e8:	02613423          	sd	t1,40(sp)
    800030ec:	02713823          	sd	t2,48(sp)
    800030f0:	02813c23          	sd	s0,56(sp)
    800030f4:	04913023          	sd	s1,64(sp)
    800030f8:	04a13423          	sd	a0,72(sp)
    800030fc:	04b13823          	sd	a1,80(sp)
    80003100:	04c13c23          	sd	a2,88(sp)
    80003104:	06d13023          	sd	a3,96(sp)
    80003108:	06e13423          	sd	a4,104(sp)
    8000310c:	06f13823          	sd	a5,112(sp)
    80003110:	07013c23          	sd	a6,120(sp)
    80003114:	09113023          	sd	a7,128(sp)
    80003118:	09213423          	sd	s2,136(sp)
    8000311c:	09313823          	sd	s3,144(sp)
    80003120:	09413c23          	sd	s4,152(sp)
    80003124:	0b513023          	sd	s5,160(sp)
    80003128:	0b613423          	sd	s6,168(sp)
    8000312c:	0b713823          	sd	s7,176(sp)
    80003130:	0b813c23          	sd	s8,184(sp)
    80003134:	0d913023          	sd	s9,192(sp)
    80003138:	0da13423          	sd	s10,200(sp)
    8000313c:	0db13823          	sd	s11,208(sp)
    80003140:	0dc13c23          	sd	t3,216(sp)
    80003144:	0fd13023          	sd	t4,224(sp)
    80003148:	0fe13423          	sd	t5,232(sp)
    8000314c:	0ff13823          	sd	t6,240(sp)
    80003150:	cd5ff0ef          	jal	ra,80002e24 <kerneltrap>
    80003154:	00013083          	ld	ra,0(sp)
    80003158:	00813103          	ld	sp,8(sp)
    8000315c:	01013183          	ld	gp,16(sp)
    80003160:	02013283          	ld	t0,32(sp)
    80003164:	02813303          	ld	t1,40(sp)
    80003168:	03013383          	ld	t2,48(sp)
    8000316c:	03813403          	ld	s0,56(sp)
    80003170:	04013483          	ld	s1,64(sp)
    80003174:	04813503          	ld	a0,72(sp)
    80003178:	05013583          	ld	a1,80(sp)
    8000317c:	05813603          	ld	a2,88(sp)
    80003180:	06013683          	ld	a3,96(sp)
    80003184:	06813703          	ld	a4,104(sp)
    80003188:	07013783          	ld	a5,112(sp)
    8000318c:	07813803          	ld	a6,120(sp)
    80003190:	08013883          	ld	a7,128(sp)
    80003194:	08813903          	ld	s2,136(sp)
    80003198:	09013983          	ld	s3,144(sp)
    8000319c:	09813a03          	ld	s4,152(sp)
    800031a0:	0a013a83          	ld	s5,160(sp)
    800031a4:	0a813b03          	ld	s6,168(sp)
    800031a8:	0b013b83          	ld	s7,176(sp)
    800031ac:	0b813c03          	ld	s8,184(sp)
    800031b0:	0c013c83          	ld	s9,192(sp)
    800031b4:	0c813d03          	ld	s10,200(sp)
    800031b8:	0d013d83          	ld	s11,208(sp)
    800031bc:	0d813e03          	ld	t3,216(sp)
    800031c0:	0e013e83          	ld	t4,224(sp)
    800031c4:	0e813f03          	ld	t5,232(sp)
    800031c8:	0f013f83          	ld	t6,240(sp)
    800031cc:	10010113          	addi	sp,sp,256
    800031d0:	10200073          	sret
    800031d4:	00000013          	nop
    800031d8:	00000013          	nop
    800031dc:	00000013          	nop

00000000800031e0 <timervec>:
    800031e0:	34051573          	csrrw	a0,mscratch,a0
    800031e4:	00b53023          	sd	a1,0(a0)
    800031e8:	00c53423          	sd	a2,8(a0)
    800031ec:	00d53823          	sd	a3,16(a0)
    800031f0:	01853583          	ld	a1,24(a0)
    800031f4:	02053603          	ld	a2,32(a0)
    800031f8:	0005b683          	ld	a3,0(a1)
    800031fc:	00c686b3          	add	a3,a3,a2
    80003200:	00d5b023          	sd	a3,0(a1)
    80003204:	00200593          	li	a1,2
    80003208:	14459073          	csrw	sip,a1
    8000320c:	01053683          	ld	a3,16(a0)
    80003210:	00853603          	ld	a2,8(a0)
    80003214:	00053583          	ld	a1,0(a0)
    80003218:	34051573          	csrrw	a0,mscratch,a0
    8000321c:	30200073          	mret

0000000080003220 <plicinit>:
    80003220:	ff010113          	addi	sp,sp,-16
    80003224:	00813423          	sd	s0,8(sp)
    80003228:	01010413          	addi	s0,sp,16
    8000322c:	00813403          	ld	s0,8(sp)
    80003230:	0c0007b7          	lui	a5,0xc000
    80003234:	00100713          	li	a4,1
    80003238:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000323c:	00e7a223          	sw	a4,4(a5)
    80003240:	01010113          	addi	sp,sp,16
    80003244:	00008067          	ret

0000000080003248 <plicinithart>:
    80003248:	ff010113          	addi	sp,sp,-16
    8000324c:	00813023          	sd	s0,0(sp)
    80003250:	00113423          	sd	ra,8(sp)
    80003254:	01010413          	addi	s0,sp,16
    80003258:	00000097          	auipc	ra,0x0
    8000325c:	a4c080e7          	jalr	-1460(ra) # 80002ca4 <cpuid>
    80003260:	0085171b          	slliw	a4,a0,0x8
    80003264:	0c0027b7          	lui	a5,0xc002
    80003268:	00e787b3          	add	a5,a5,a4
    8000326c:	40200713          	li	a4,1026
    80003270:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003274:	00813083          	ld	ra,8(sp)
    80003278:	00013403          	ld	s0,0(sp)
    8000327c:	00d5151b          	slliw	a0,a0,0xd
    80003280:	0c2017b7          	lui	a5,0xc201
    80003284:	00a78533          	add	a0,a5,a0
    80003288:	00052023          	sw	zero,0(a0)
    8000328c:	01010113          	addi	sp,sp,16
    80003290:	00008067          	ret

0000000080003294 <plic_claim>:
    80003294:	ff010113          	addi	sp,sp,-16
    80003298:	00813023          	sd	s0,0(sp)
    8000329c:	00113423          	sd	ra,8(sp)
    800032a0:	01010413          	addi	s0,sp,16
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	a00080e7          	jalr	-1536(ra) # 80002ca4 <cpuid>
    800032ac:	00813083          	ld	ra,8(sp)
    800032b0:	00013403          	ld	s0,0(sp)
    800032b4:	00d5151b          	slliw	a0,a0,0xd
    800032b8:	0c2017b7          	lui	a5,0xc201
    800032bc:	00a78533          	add	a0,a5,a0
    800032c0:	00452503          	lw	a0,4(a0)
    800032c4:	01010113          	addi	sp,sp,16
    800032c8:	00008067          	ret

00000000800032cc <plic_complete>:
    800032cc:	fe010113          	addi	sp,sp,-32
    800032d0:	00813823          	sd	s0,16(sp)
    800032d4:	00913423          	sd	s1,8(sp)
    800032d8:	00113c23          	sd	ra,24(sp)
    800032dc:	02010413          	addi	s0,sp,32
    800032e0:	00050493          	mv	s1,a0
    800032e4:	00000097          	auipc	ra,0x0
    800032e8:	9c0080e7          	jalr	-1600(ra) # 80002ca4 <cpuid>
    800032ec:	01813083          	ld	ra,24(sp)
    800032f0:	01013403          	ld	s0,16(sp)
    800032f4:	00d5179b          	slliw	a5,a0,0xd
    800032f8:	0c201737          	lui	a4,0xc201
    800032fc:	00f707b3          	add	a5,a4,a5
    80003300:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003304:	00813483          	ld	s1,8(sp)
    80003308:	02010113          	addi	sp,sp,32
    8000330c:	00008067          	ret

0000000080003310 <consolewrite>:
    80003310:	fb010113          	addi	sp,sp,-80
    80003314:	04813023          	sd	s0,64(sp)
    80003318:	04113423          	sd	ra,72(sp)
    8000331c:	02913c23          	sd	s1,56(sp)
    80003320:	03213823          	sd	s2,48(sp)
    80003324:	03313423          	sd	s3,40(sp)
    80003328:	03413023          	sd	s4,32(sp)
    8000332c:	01513c23          	sd	s5,24(sp)
    80003330:	05010413          	addi	s0,sp,80
    80003334:	06c05c63          	blez	a2,800033ac <consolewrite+0x9c>
    80003338:	00060993          	mv	s3,a2
    8000333c:	00050a13          	mv	s4,a0
    80003340:	00058493          	mv	s1,a1
    80003344:	00000913          	li	s2,0
    80003348:	fff00a93          	li	s5,-1
    8000334c:	01c0006f          	j	80003368 <consolewrite+0x58>
    80003350:	fbf44503          	lbu	a0,-65(s0)
    80003354:	0019091b          	addiw	s2,s2,1
    80003358:	00148493          	addi	s1,s1,1
    8000335c:	00001097          	auipc	ra,0x1
    80003360:	a9c080e7          	jalr	-1380(ra) # 80003df8 <uartputc>
    80003364:	03298063          	beq	s3,s2,80003384 <consolewrite+0x74>
    80003368:	00048613          	mv	a2,s1
    8000336c:	00100693          	li	a3,1
    80003370:	000a0593          	mv	a1,s4
    80003374:	fbf40513          	addi	a0,s0,-65
    80003378:	00000097          	auipc	ra,0x0
    8000337c:	9e4080e7          	jalr	-1564(ra) # 80002d5c <either_copyin>
    80003380:	fd5518e3          	bne	a0,s5,80003350 <consolewrite+0x40>
    80003384:	04813083          	ld	ra,72(sp)
    80003388:	04013403          	ld	s0,64(sp)
    8000338c:	03813483          	ld	s1,56(sp)
    80003390:	02813983          	ld	s3,40(sp)
    80003394:	02013a03          	ld	s4,32(sp)
    80003398:	01813a83          	ld	s5,24(sp)
    8000339c:	00090513          	mv	a0,s2
    800033a0:	03013903          	ld	s2,48(sp)
    800033a4:	05010113          	addi	sp,sp,80
    800033a8:	00008067          	ret
    800033ac:	00000913          	li	s2,0
    800033b0:	fd5ff06f          	j	80003384 <consolewrite+0x74>

00000000800033b4 <consoleread>:
    800033b4:	f9010113          	addi	sp,sp,-112
    800033b8:	06813023          	sd	s0,96(sp)
    800033bc:	04913c23          	sd	s1,88(sp)
    800033c0:	05213823          	sd	s2,80(sp)
    800033c4:	05313423          	sd	s3,72(sp)
    800033c8:	05413023          	sd	s4,64(sp)
    800033cc:	03513c23          	sd	s5,56(sp)
    800033d0:	03613823          	sd	s6,48(sp)
    800033d4:	03713423          	sd	s7,40(sp)
    800033d8:	03813023          	sd	s8,32(sp)
    800033dc:	06113423          	sd	ra,104(sp)
    800033e0:	01913c23          	sd	s9,24(sp)
    800033e4:	07010413          	addi	s0,sp,112
    800033e8:	00060b93          	mv	s7,a2
    800033ec:	00050913          	mv	s2,a0
    800033f0:	00058c13          	mv	s8,a1
    800033f4:	00060b1b          	sext.w	s6,a2
    800033f8:	00004497          	auipc	s1,0x4
    800033fc:	d0048493          	addi	s1,s1,-768 # 800070f8 <cons>
    80003400:	00400993          	li	s3,4
    80003404:	fff00a13          	li	s4,-1
    80003408:	00a00a93          	li	s5,10
    8000340c:	05705e63          	blez	s7,80003468 <consoleread+0xb4>
    80003410:	09c4a703          	lw	a4,156(s1)
    80003414:	0984a783          	lw	a5,152(s1)
    80003418:	0007071b          	sext.w	a4,a4
    8000341c:	08e78463          	beq	a5,a4,800034a4 <consoleread+0xf0>
    80003420:	07f7f713          	andi	a4,a5,127
    80003424:	00e48733          	add	a4,s1,a4
    80003428:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000342c:	0017869b          	addiw	a3,a5,1
    80003430:	08d4ac23          	sw	a3,152(s1)
    80003434:	00070c9b          	sext.w	s9,a4
    80003438:	0b370663          	beq	a4,s3,800034e4 <consoleread+0x130>
    8000343c:	00100693          	li	a3,1
    80003440:	f9f40613          	addi	a2,s0,-97
    80003444:	000c0593          	mv	a1,s8
    80003448:	00090513          	mv	a0,s2
    8000344c:	f8e40fa3          	sb	a4,-97(s0)
    80003450:	00000097          	auipc	ra,0x0
    80003454:	8c0080e7          	jalr	-1856(ra) # 80002d10 <either_copyout>
    80003458:	01450863          	beq	a0,s4,80003468 <consoleread+0xb4>
    8000345c:	001c0c13          	addi	s8,s8,1
    80003460:	fffb8b9b          	addiw	s7,s7,-1
    80003464:	fb5c94e3          	bne	s9,s5,8000340c <consoleread+0x58>
    80003468:	000b851b          	sext.w	a0,s7
    8000346c:	06813083          	ld	ra,104(sp)
    80003470:	06013403          	ld	s0,96(sp)
    80003474:	05813483          	ld	s1,88(sp)
    80003478:	05013903          	ld	s2,80(sp)
    8000347c:	04813983          	ld	s3,72(sp)
    80003480:	04013a03          	ld	s4,64(sp)
    80003484:	03813a83          	ld	s5,56(sp)
    80003488:	02813b83          	ld	s7,40(sp)
    8000348c:	02013c03          	ld	s8,32(sp)
    80003490:	01813c83          	ld	s9,24(sp)
    80003494:	40ab053b          	subw	a0,s6,a0
    80003498:	03013b03          	ld	s6,48(sp)
    8000349c:	07010113          	addi	sp,sp,112
    800034a0:	00008067          	ret
    800034a4:	00001097          	auipc	ra,0x1
    800034a8:	1d8080e7          	jalr	472(ra) # 8000467c <push_on>
    800034ac:	0984a703          	lw	a4,152(s1)
    800034b0:	09c4a783          	lw	a5,156(s1)
    800034b4:	0007879b          	sext.w	a5,a5
    800034b8:	fef70ce3          	beq	a4,a5,800034b0 <consoleread+0xfc>
    800034bc:	00001097          	auipc	ra,0x1
    800034c0:	234080e7          	jalr	564(ra) # 800046f0 <pop_on>
    800034c4:	0984a783          	lw	a5,152(s1)
    800034c8:	07f7f713          	andi	a4,a5,127
    800034cc:	00e48733          	add	a4,s1,a4
    800034d0:	01874703          	lbu	a4,24(a4)
    800034d4:	0017869b          	addiw	a3,a5,1
    800034d8:	08d4ac23          	sw	a3,152(s1)
    800034dc:	00070c9b          	sext.w	s9,a4
    800034e0:	f5371ee3          	bne	a4,s3,8000343c <consoleread+0x88>
    800034e4:	000b851b          	sext.w	a0,s7
    800034e8:	f96bf2e3          	bgeu	s7,s6,8000346c <consoleread+0xb8>
    800034ec:	08f4ac23          	sw	a5,152(s1)
    800034f0:	f7dff06f          	j	8000346c <consoleread+0xb8>

00000000800034f4 <consputc>:
    800034f4:	10000793          	li	a5,256
    800034f8:	00f50663          	beq	a0,a5,80003504 <consputc+0x10>
    800034fc:	00001317          	auipc	t1,0x1
    80003500:	9f430067          	jr	-1548(t1) # 80003ef0 <uartputc_sync>
    80003504:	ff010113          	addi	sp,sp,-16
    80003508:	00113423          	sd	ra,8(sp)
    8000350c:	00813023          	sd	s0,0(sp)
    80003510:	01010413          	addi	s0,sp,16
    80003514:	00800513          	li	a0,8
    80003518:	00001097          	auipc	ra,0x1
    8000351c:	9d8080e7          	jalr	-1576(ra) # 80003ef0 <uartputc_sync>
    80003520:	02000513          	li	a0,32
    80003524:	00001097          	auipc	ra,0x1
    80003528:	9cc080e7          	jalr	-1588(ra) # 80003ef0 <uartputc_sync>
    8000352c:	00013403          	ld	s0,0(sp)
    80003530:	00813083          	ld	ra,8(sp)
    80003534:	00800513          	li	a0,8
    80003538:	01010113          	addi	sp,sp,16
    8000353c:	00001317          	auipc	t1,0x1
    80003540:	9b430067          	jr	-1612(t1) # 80003ef0 <uartputc_sync>

0000000080003544 <consoleintr>:
    80003544:	fe010113          	addi	sp,sp,-32
    80003548:	00813823          	sd	s0,16(sp)
    8000354c:	00913423          	sd	s1,8(sp)
    80003550:	01213023          	sd	s2,0(sp)
    80003554:	00113c23          	sd	ra,24(sp)
    80003558:	02010413          	addi	s0,sp,32
    8000355c:	00004917          	auipc	s2,0x4
    80003560:	b9c90913          	addi	s2,s2,-1124 # 800070f8 <cons>
    80003564:	00050493          	mv	s1,a0
    80003568:	00090513          	mv	a0,s2
    8000356c:	00001097          	auipc	ra,0x1
    80003570:	e40080e7          	jalr	-448(ra) # 800043ac <acquire>
    80003574:	02048c63          	beqz	s1,800035ac <consoleintr+0x68>
    80003578:	0a092783          	lw	a5,160(s2)
    8000357c:	09892703          	lw	a4,152(s2)
    80003580:	07f00693          	li	a3,127
    80003584:	40e7873b          	subw	a4,a5,a4
    80003588:	02e6e263          	bltu	a3,a4,800035ac <consoleintr+0x68>
    8000358c:	00d00713          	li	a4,13
    80003590:	04e48063          	beq	s1,a4,800035d0 <consoleintr+0x8c>
    80003594:	07f7f713          	andi	a4,a5,127
    80003598:	00e90733          	add	a4,s2,a4
    8000359c:	0017879b          	addiw	a5,a5,1
    800035a0:	0af92023          	sw	a5,160(s2)
    800035a4:	00970c23          	sb	s1,24(a4)
    800035a8:	08f92e23          	sw	a5,156(s2)
    800035ac:	01013403          	ld	s0,16(sp)
    800035b0:	01813083          	ld	ra,24(sp)
    800035b4:	00813483          	ld	s1,8(sp)
    800035b8:	00013903          	ld	s2,0(sp)
    800035bc:	00004517          	auipc	a0,0x4
    800035c0:	b3c50513          	addi	a0,a0,-1220 # 800070f8 <cons>
    800035c4:	02010113          	addi	sp,sp,32
    800035c8:	00001317          	auipc	t1,0x1
    800035cc:	eb030067          	jr	-336(t1) # 80004478 <release>
    800035d0:	00a00493          	li	s1,10
    800035d4:	fc1ff06f          	j	80003594 <consoleintr+0x50>

00000000800035d8 <consoleinit>:
    800035d8:	fe010113          	addi	sp,sp,-32
    800035dc:	00113c23          	sd	ra,24(sp)
    800035e0:	00813823          	sd	s0,16(sp)
    800035e4:	00913423          	sd	s1,8(sp)
    800035e8:	02010413          	addi	s0,sp,32
    800035ec:	00004497          	auipc	s1,0x4
    800035f0:	b0c48493          	addi	s1,s1,-1268 # 800070f8 <cons>
    800035f4:	00048513          	mv	a0,s1
    800035f8:	00002597          	auipc	a1,0x2
    800035fc:	cd858593          	addi	a1,a1,-808 # 800052d0 <_ZZ12printIntegermE6digits+0x138>
    80003600:	00001097          	auipc	ra,0x1
    80003604:	d88080e7          	jalr	-632(ra) # 80004388 <initlock>
    80003608:	00000097          	auipc	ra,0x0
    8000360c:	7ac080e7          	jalr	1964(ra) # 80003db4 <uartinit>
    80003610:	01813083          	ld	ra,24(sp)
    80003614:	01013403          	ld	s0,16(sp)
    80003618:	00000797          	auipc	a5,0x0
    8000361c:	d9c78793          	addi	a5,a5,-612 # 800033b4 <consoleread>
    80003620:	0af4bc23          	sd	a5,184(s1)
    80003624:	00000797          	auipc	a5,0x0
    80003628:	cec78793          	addi	a5,a5,-788 # 80003310 <consolewrite>
    8000362c:	0cf4b023          	sd	a5,192(s1)
    80003630:	00813483          	ld	s1,8(sp)
    80003634:	02010113          	addi	sp,sp,32
    80003638:	00008067          	ret

000000008000363c <console_read>:
    8000363c:	ff010113          	addi	sp,sp,-16
    80003640:	00813423          	sd	s0,8(sp)
    80003644:	01010413          	addi	s0,sp,16
    80003648:	00813403          	ld	s0,8(sp)
    8000364c:	00004317          	auipc	t1,0x4
    80003650:	b6433303          	ld	t1,-1180(t1) # 800071b0 <devsw+0x10>
    80003654:	01010113          	addi	sp,sp,16
    80003658:	00030067          	jr	t1

000000008000365c <console_write>:
    8000365c:	ff010113          	addi	sp,sp,-16
    80003660:	00813423          	sd	s0,8(sp)
    80003664:	01010413          	addi	s0,sp,16
    80003668:	00813403          	ld	s0,8(sp)
    8000366c:	00004317          	auipc	t1,0x4
    80003670:	b4c33303          	ld	t1,-1204(t1) # 800071b8 <devsw+0x18>
    80003674:	01010113          	addi	sp,sp,16
    80003678:	00030067          	jr	t1

000000008000367c <panic>:
    8000367c:	fe010113          	addi	sp,sp,-32
    80003680:	00113c23          	sd	ra,24(sp)
    80003684:	00813823          	sd	s0,16(sp)
    80003688:	00913423          	sd	s1,8(sp)
    8000368c:	02010413          	addi	s0,sp,32
    80003690:	00050493          	mv	s1,a0
    80003694:	00002517          	auipc	a0,0x2
    80003698:	c4450513          	addi	a0,a0,-956 # 800052d8 <_ZZ12printIntegermE6digits+0x140>
    8000369c:	00004797          	auipc	a5,0x4
    800036a0:	ba07ae23          	sw	zero,-1092(a5) # 80007258 <pr+0x18>
    800036a4:	00000097          	auipc	ra,0x0
    800036a8:	034080e7          	jalr	52(ra) # 800036d8 <__printf>
    800036ac:	00048513          	mv	a0,s1
    800036b0:	00000097          	auipc	ra,0x0
    800036b4:	028080e7          	jalr	40(ra) # 800036d8 <__printf>
    800036b8:	00002517          	auipc	a0,0x2
    800036bc:	c0050513          	addi	a0,a0,-1024 # 800052b8 <_ZZ12printIntegermE6digits+0x120>
    800036c0:	00000097          	auipc	ra,0x0
    800036c4:	018080e7          	jalr	24(ra) # 800036d8 <__printf>
    800036c8:	00100793          	li	a5,1
    800036cc:	00003717          	auipc	a4,0x3
    800036d0:	8ef72623          	sw	a5,-1812(a4) # 80005fb8 <panicked>
    800036d4:	0000006f          	j	800036d4 <panic+0x58>

00000000800036d8 <__printf>:
    800036d8:	f3010113          	addi	sp,sp,-208
    800036dc:	08813023          	sd	s0,128(sp)
    800036e0:	07313423          	sd	s3,104(sp)
    800036e4:	09010413          	addi	s0,sp,144
    800036e8:	05813023          	sd	s8,64(sp)
    800036ec:	08113423          	sd	ra,136(sp)
    800036f0:	06913c23          	sd	s1,120(sp)
    800036f4:	07213823          	sd	s2,112(sp)
    800036f8:	07413023          	sd	s4,96(sp)
    800036fc:	05513c23          	sd	s5,88(sp)
    80003700:	05613823          	sd	s6,80(sp)
    80003704:	05713423          	sd	s7,72(sp)
    80003708:	03913c23          	sd	s9,56(sp)
    8000370c:	03a13823          	sd	s10,48(sp)
    80003710:	03b13423          	sd	s11,40(sp)
    80003714:	00004317          	auipc	t1,0x4
    80003718:	b2c30313          	addi	t1,t1,-1236 # 80007240 <pr>
    8000371c:	01832c03          	lw	s8,24(t1)
    80003720:	00b43423          	sd	a1,8(s0)
    80003724:	00c43823          	sd	a2,16(s0)
    80003728:	00d43c23          	sd	a3,24(s0)
    8000372c:	02e43023          	sd	a4,32(s0)
    80003730:	02f43423          	sd	a5,40(s0)
    80003734:	03043823          	sd	a6,48(s0)
    80003738:	03143c23          	sd	a7,56(s0)
    8000373c:	00050993          	mv	s3,a0
    80003740:	4a0c1663          	bnez	s8,80003bec <__printf+0x514>
    80003744:	60098c63          	beqz	s3,80003d5c <__printf+0x684>
    80003748:	0009c503          	lbu	a0,0(s3)
    8000374c:	00840793          	addi	a5,s0,8
    80003750:	f6f43c23          	sd	a5,-136(s0)
    80003754:	00000493          	li	s1,0
    80003758:	22050063          	beqz	a0,80003978 <__printf+0x2a0>
    8000375c:	00002a37          	lui	s4,0x2
    80003760:	00018ab7          	lui	s5,0x18
    80003764:	000f4b37          	lui	s6,0xf4
    80003768:	00989bb7          	lui	s7,0x989
    8000376c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003770:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003774:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003778:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000377c:	00148c9b          	addiw	s9,s1,1
    80003780:	02500793          	li	a5,37
    80003784:	01998933          	add	s2,s3,s9
    80003788:	38f51263          	bne	a0,a5,80003b0c <__printf+0x434>
    8000378c:	00094783          	lbu	a5,0(s2)
    80003790:	00078c9b          	sext.w	s9,a5
    80003794:	1e078263          	beqz	a5,80003978 <__printf+0x2a0>
    80003798:	0024849b          	addiw	s1,s1,2
    8000379c:	07000713          	li	a4,112
    800037a0:	00998933          	add	s2,s3,s1
    800037a4:	38e78a63          	beq	a5,a4,80003b38 <__printf+0x460>
    800037a8:	20f76863          	bltu	a4,a5,800039b8 <__printf+0x2e0>
    800037ac:	42a78863          	beq	a5,a0,80003bdc <__printf+0x504>
    800037b0:	06400713          	li	a4,100
    800037b4:	40e79663          	bne	a5,a4,80003bc0 <__printf+0x4e8>
    800037b8:	f7843783          	ld	a5,-136(s0)
    800037bc:	0007a603          	lw	a2,0(a5)
    800037c0:	00878793          	addi	a5,a5,8
    800037c4:	f6f43c23          	sd	a5,-136(s0)
    800037c8:	42064a63          	bltz	a2,80003bfc <__printf+0x524>
    800037cc:	00a00713          	li	a4,10
    800037d0:	02e677bb          	remuw	a5,a2,a4
    800037d4:	00002d97          	auipc	s11,0x2
    800037d8:	b2cd8d93          	addi	s11,s11,-1236 # 80005300 <digits>
    800037dc:	00900593          	li	a1,9
    800037e0:	0006051b          	sext.w	a0,a2
    800037e4:	00000c93          	li	s9,0
    800037e8:	02079793          	slli	a5,a5,0x20
    800037ec:	0207d793          	srli	a5,a5,0x20
    800037f0:	00fd87b3          	add	a5,s11,a5
    800037f4:	0007c783          	lbu	a5,0(a5)
    800037f8:	02e656bb          	divuw	a3,a2,a4
    800037fc:	f8f40023          	sb	a5,-128(s0)
    80003800:	14c5d863          	bge	a1,a2,80003950 <__printf+0x278>
    80003804:	06300593          	li	a1,99
    80003808:	00100c93          	li	s9,1
    8000380c:	02e6f7bb          	remuw	a5,a3,a4
    80003810:	02079793          	slli	a5,a5,0x20
    80003814:	0207d793          	srli	a5,a5,0x20
    80003818:	00fd87b3          	add	a5,s11,a5
    8000381c:	0007c783          	lbu	a5,0(a5)
    80003820:	02e6d73b          	divuw	a4,a3,a4
    80003824:	f8f400a3          	sb	a5,-127(s0)
    80003828:	12a5f463          	bgeu	a1,a0,80003950 <__printf+0x278>
    8000382c:	00a00693          	li	a3,10
    80003830:	00900593          	li	a1,9
    80003834:	02d777bb          	remuw	a5,a4,a3
    80003838:	02079793          	slli	a5,a5,0x20
    8000383c:	0207d793          	srli	a5,a5,0x20
    80003840:	00fd87b3          	add	a5,s11,a5
    80003844:	0007c503          	lbu	a0,0(a5)
    80003848:	02d757bb          	divuw	a5,a4,a3
    8000384c:	f8a40123          	sb	a0,-126(s0)
    80003850:	48e5f263          	bgeu	a1,a4,80003cd4 <__printf+0x5fc>
    80003854:	06300513          	li	a0,99
    80003858:	02d7f5bb          	remuw	a1,a5,a3
    8000385c:	02059593          	slli	a1,a1,0x20
    80003860:	0205d593          	srli	a1,a1,0x20
    80003864:	00bd85b3          	add	a1,s11,a1
    80003868:	0005c583          	lbu	a1,0(a1)
    8000386c:	02d7d7bb          	divuw	a5,a5,a3
    80003870:	f8b401a3          	sb	a1,-125(s0)
    80003874:	48e57263          	bgeu	a0,a4,80003cf8 <__printf+0x620>
    80003878:	3e700513          	li	a0,999
    8000387c:	02d7f5bb          	remuw	a1,a5,a3
    80003880:	02059593          	slli	a1,a1,0x20
    80003884:	0205d593          	srli	a1,a1,0x20
    80003888:	00bd85b3          	add	a1,s11,a1
    8000388c:	0005c583          	lbu	a1,0(a1)
    80003890:	02d7d7bb          	divuw	a5,a5,a3
    80003894:	f8b40223          	sb	a1,-124(s0)
    80003898:	46e57663          	bgeu	a0,a4,80003d04 <__printf+0x62c>
    8000389c:	02d7f5bb          	remuw	a1,a5,a3
    800038a0:	02059593          	slli	a1,a1,0x20
    800038a4:	0205d593          	srli	a1,a1,0x20
    800038a8:	00bd85b3          	add	a1,s11,a1
    800038ac:	0005c583          	lbu	a1,0(a1)
    800038b0:	02d7d7bb          	divuw	a5,a5,a3
    800038b4:	f8b402a3          	sb	a1,-123(s0)
    800038b8:	46ea7863          	bgeu	s4,a4,80003d28 <__printf+0x650>
    800038bc:	02d7f5bb          	remuw	a1,a5,a3
    800038c0:	02059593          	slli	a1,a1,0x20
    800038c4:	0205d593          	srli	a1,a1,0x20
    800038c8:	00bd85b3          	add	a1,s11,a1
    800038cc:	0005c583          	lbu	a1,0(a1)
    800038d0:	02d7d7bb          	divuw	a5,a5,a3
    800038d4:	f8b40323          	sb	a1,-122(s0)
    800038d8:	3eeaf863          	bgeu	s5,a4,80003cc8 <__printf+0x5f0>
    800038dc:	02d7f5bb          	remuw	a1,a5,a3
    800038e0:	02059593          	slli	a1,a1,0x20
    800038e4:	0205d593          	srli	a1,a1,0x20
    800038e8:	00bd85b3          	add	a1,s11,a1
    800038ec:	0005c583          	lbu	a1,0(a1)
    800038f0:	02d7d7bb          	divuw	a5,a5,a3
    800038f4:	f8b403a3          	sb	a1,-121(s0)
    800038f8:	42eb7e63          	bgeu	s6,a4,80003d34 <__printf+0x65c>
    800038fc:	02d7f5bb          	remuw	a1,a5,a3
    80003900:	02059593          	slli	a1,a1,0x20
    80003904:	0205d593          	srli	a1,a1,0x20
    80003908:	00bd85b3          	add	a1,s11,a1
    8000390c:	0005c583          	lbu	a1,0(a1)
    80003910:	02d7d7bb          	divuw	a5,a5,a3
    80003914:	f8b40423          	sb	a1,-120(s0)
    80003918:	42ebfc63          	bgeu	s7,a4,80003d50 <__printf+0x678>
    8000391c:	02079793          	slli	a5,a5,0x20
    80003920:	0207d793          	srli	a5,a5,0x20
    80003924:	00fd8db3          	add	s11,s11,a5
    80003928:	000dc703          	lbu	a4,0(s11)
    8000392c:	00a00793          	li	a5,10
    80003930:	00900c93          	li	s9,9
    80003934:	f8e404a3          	sb	a4,-119(s0)
    80003938:	00065c63          	bgez	a2,80003950 <__printf+0x278>
    8000393c:	f9040713          	addi	a4,s0,-112
    80003940:	00f70733          	add	a4,a4,a5
    80003944:	02d00693          	li	a3,45
    80003948:	fed70823          	sb	a3,-16(a4)
    8000394c:	00078c93          	mv	s9,a5
    80003950:	f8040793          	addi	a5,s0,-128
    80003954:	01978cb3          	add	s9,a5,s9
    80003958:	f7f40d13          	addi	s10,s0,-129
    8000395c:	000cc503          	lbu	a0,0(s9)
    80003960:	fffc8c93          	addi	s9,s9,-1
    80003964:	00000097          	auipc	ra,0x0
    80003968:	b90080e7          	jalr	-1136(ra) # 800034f4 <consputc>
    8000396c:	ffac98e3          	bne	s9,s10,8000395c <__printf+0x284>
    80003970:	00094503          	lbu	a0,0(s2)
    80003974:	e00514e3          	bnez	a0,8000377c <__printf+0xa4>
    80003978:	1a0c1663          	bnez	s8,80003b24 <__printf+0x44c>
    8000397c:	08813083          	ld	ra,136(sp)
    80003980:	08013403          	ld	s0,128(sp)
    80003984:	07813483          	ld	s1,120(sp)
    80003988:	07013903          	ld	s2,112(sp)
    8000398c:	06813983          	ld	s3,104(sp)
    80003990:	06013a03          	ld	s4,96(sp)
    80003994:	05813a83          	ld	s5,88(sp)
    80003998:	05013b03          	ld	s6,80(sp)
    8000399c:	04813b83          	ld	s7,72(sp)
    800039a0:	04013c03          	ld	s8,64(sp)
    800039a4:	03813c83          	ld	s9,56(sp)
    800039a8:	03013d03          	ld	s10,48(sp)
    800039ac:	02813d83          	ld	s11,40(sp)
    800039b0:	0d010113          	addi	sp,sp,208
    800039b4:	00008067          	ret
    800039b8:	07300713          	li	a4,115
    800039bc:	1ce78a63          	beq	a5,a4,80003b90 <__printf+0x4b8>
    800039c0:	07800713          	li	a4,120
    800039c4:	1ee79e63          	bne	a5,a4,80003bc0 <__printf+0x4e8>
    800039c8:	f7843783          	ld	a5,-136(s0)
    800039cc:	0007a703          	lw	a4,0(a5)
    800039d0:	00878793          	addi	a5,a5,8
    800039d4:	f6f43c23          	sd	a5,-136(s0)
    800039d8:	28074263          	bltz	a4,80003c5c <__printf+0x584>
    800039dc:	00002d97          	auipc	s11,0x2
    800039e0:	924d8d93          	addi	s11,s11,-1756 # 80005300 <digits>
    800039e4:	00f77793          	andi	a5,a4,15
    800039e8:	00fd87b3          	add	a5,s11,a5
    800039ec:	0007c683          	lbu	a3,0(a5)
    800039f0:	00f00613          	li	a2,15
    800039f4:	0007079b          	sext.w	a5,a4
    800039f8:	f8d40023          	sb	a3,-128(s0)
    800039fc:	0047559b          	srliw	a1,a4,0x4
    80003a00:	0047569b          	srliw	a3,a4,0x4
    80003a04:	00000c93          	li	s9,0
    80003a08:	0ee65063          	bge	a2,a4,80003ae8 <__printf+0x410>
    80003a0c:	00f6f693          	andi	a3,a3,15
    80003a10:	00dd86b3          	add	a3,s11,a3
    80003a14:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003a18:	0087d79b          	srliw	a5,a5,0x8
    80003a1c:	00100c93          	li	s9,1
    80003a20:	f8d400a3          	sb	a3,-127(s0)
    80003a24:	0cb67263          	bgeu	a2,a1,80003ae8 <__printf+0x410>
    80003a28:	00f7f693          	andi	a3,a5,15
    80003a2c:	00dd86b3          	add	a3,s11,a3
    80003a30:	0006c583          	lbu	a1,0(a3)
    80003a34:	00f00613          	li	a2,15
    80003a38:	0047d69b          	srliw	a3,a5,0x4
    80003a3c:	f8b40123          	sb	a1,-126(s0)
    80003a40:	0047d593          	srli	a1,a5,0x4
    80003a44:	28f67e63          	bgeu	a2,a5,80003ce0 <__printf+0x608>
    80003a48:	00f6f693          	andi	a3,a3,15
    80003a4c:	00dd86b3          	add	a3,s11,a3
    80003a50:	0006c503          	lbu	a0,0(a3)
    80003a54:	0087d813          	srli	a6,a5,0x8
    80003a58:	0087d69b          	srliw	a3,a5,0x8
    80003a5c:	f8a401a3          	sb	a0,-125(s0)
    80003a60:	28b67663          	bgeu	a2,a1,80003cec <__printf+0x614>
    80003a64:	00f6f693          	andi	a3,a3,15
    80003a68:	00dd86b3          	add	a3,s11,a3
    80003a6c:	0006c583          	lbu	a1,0(a3)
    80003a70:	00c7d513          	srli	a0,a5,0xc
    80003a74:	00c7d69b          	srliw	a3,a5,0xc
    80003a78:	f8b40223          	sb	a1,-124(s0)
    80003a7c:	29067a63          	bgeu	a2,a6,80003d10 <__printf+0x638>
    80003a80:	00f6f693          	andi	a3,a3,15
    80003a84:	00dd86b3          	add	a3,s11,a3
    80003a88:	0006c583          	lbu	a1,0(a3)
    80003a8c:	0107d813          	srli	a6,a5,0x10
    80003a90:	0107d69b          	srliw	a3,a5,0x10
    80003a94:	f8b402a3          	sb	a1,-123(s0)
    80003a98:	28a67263          	bgeu	a2,a0,80003d1c <__printf+0x644>
    80003a9c:	00f6f693          	andi	a3,a3,15
    80003aa0:	00dd86b3          	add	a3,s11,a3
    80003aa4:	0006c683          	lbu	a3,0(a3)
    80003aa8:	0147d79b          	srliw	a5,a5,0x14
    80003aac:	f8d40323          	sb	a3,-122(s0)
    80003ab0:	21067663          	bgeu	a2,a6,80003cbc <__printf+0x5e4>
    80003ab4:	02079793          	slli	a5,a5,0x20
    80003ab8:	0207d793          	srli	a5,a5,0x20
    80003abc:	00fd8db3          	add	s11,s11,a5
    80003ac0:	000dc683          	lbu	a3,0(s11)
    80003ac4:	00800793          	li	a5,8
    80003ac8:	00700c93          	li	s9,7
    80003acc:	f8d403a3          	sb	a3,-121(s0)
    80003ad0:	00075c63          	bgez	a4,80003ae8 <__printf+0x410>
    80003ad4:	f9040713          	addi	a4,s0,-112
    80003ad8:	00f70733          	add	a4,a4,a5
    80003adc:	02d00693          	li	a3,45
    80003ae0:	fed70823          	sb	a3,-16(a4)
    80003ae4:	00078c93          	mv	s9,a5
    80003ae8:	f8040793          	addi	a5,s0,-128
    80003aec:	01978cb3          	add	s9,a5,s9
    80003af0:	f7f40d13          	addi	s10,s0,-129
    80003af4:	000cc503          	lbu	a0,0(s9)
    80003af8:	fffc8c93          	addi	s9,s9,-1
    80003afc:	00000097          	auipc	ra,0x0
    80003b00:	9f8080e7          	jalr	-1544(ra) # 800034f4 <consputc>
    80003b04:	ff9d18e3          	bne	s10,s9,80003af4 <__printf+0x41c>
    80003b08:	0100006f          	j	80003b18 <__printf+0x440>
    80003b0c:	00000097          	auipc	ra,0x0
    80003b10:	9e8080e7          	jalr	-1560(ra) # 800034f4 <consputc>
    80003b14:	000c8493          	mv	s1,s9
    80003b18:	00094503          	lbu	a0,0(s2)
    80003b1c:	c60510e3          	bnez	a0,8000377c <__printf+0xa4>
    80003b20:	e40c0ee3          	beqz	s8,8000397c <__printf+0x2a4>
    80003b24:	00003517          	auipc	a0,0x3
    80003b28:	71c50513          	addi	a0,a0,1820 # 80007240 <pr>
    80003b2c:	00001097          	auipc	ra,0x1
    80003b30:	94c080e7          	jalr	-1716(ra) # 80004478 <release>
    80003b34:	e49ff06f          	j	8000397c <__printf+0x2a4>
    80003b38:	f7843783          	ld	a5,-136(s0)
    80003b3c:	03000513          	li	a0,48
    80003b40:	01000d13          	li	s10,16
    80003b44:	00878713          	addi	a4,a5,8
    80003b48:	0007bc83          	ld	s9,0(a5)
    80003b4c:	f6e43c23          	sd	a4,-136(s0)
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	9a4080e7          	jalr	-1628(ra) # 800034f4 <consputc>
    80003b58:	07800513          	li	a0,120
    80003b5c:	00000097          	auipc	ra,0x0
    80003b60:	998080e7          	jalr	-1640(ra) # 800034f4 <consputc>
    80003b64:	00001d97          	auipc	s11,0x1
    80003b68:	79cd8d93          	addi	s11,s11,1948 # 80005300 <digits>
    80003b6c:	03ccd793          	srli	a5,s9,0x3c
    80003b70:	00fd87b3          	add	a5,s11,a5
    80003b74:	0007c503          	lbu	a0,0(a5)
    80003b78:	fffd0d1b          	addiw	s10,s10,-1
    80003b7c:	004c9c93          	slli	s9,s9,0x4
    80003b80:	00000097          	auipc	ra,0x0
    80003b84:	974080e7          	jalr	-1676(ra) # 800034f4 <consputc>
    80003b88:	fe0d12e3          	bnez	s10,80003b6c <__printf+0x494>
    80003b8c:	f8dff06f          	j	80003b18 <__printf+0x440>
    80003b90:	f7843783          	ld	a5,-136(s0)
    80003b94:	0007bc83          	ld	s9,0(a5)
    80003b98:	00878793          	addi	a5,a5,8
    80003b9c:	f6f43c23          	sd	a5,-136(s0)
    80003ba0:	000c9a63          	bnez	s9,80003bb4 <__printf+0x4dc>
    80003ba4:	1080006f          	j	80003cac <__printf+0x5d4>
    80003ba8:	001c8c93          	addi	s9,s9,1
    80003bac:	00000097          	auipc	ra,0x0
    80003bb0:	948080e7          	jalr	-1720(ra) # 800034f4 <consputc>
    80003bb4:	000cc503          	lbu	a0,0(s9)
    80003bb8:	fe0518e3          	bnez	a0,80003ba8 <__printf+0x4d0>
    80003bbc:	f5dff06f          	j	80003b18 <__printf+0x440>
    80003bc0:	02500513          	li	a0,37
    80003bc4:	00000097          	auipc	ra,0x0
    80003bc8:	930080e7          	jalr	-1744(ra) # 800034f4 <consputc>
    80003bcc:	000c8513          	mv	a0,s9
    80003bd0:	00000097          	auipc	ra,0x0
    80003bd4:	924080e7          	jalr	-1756(ra) # 800034f4 <consputc>
    80003bd8:	f41ff06f          	j	80003b18 <__printf+0x440>
    80003bdc:	02500513          	li	a0,37
    80003be0:	00000097          	auipc	ra,0x0
    80003be4:	914080e7          	jalr	-1772(ra) # 800034f4 <consputc>
    80003be8:	f31ff06f          	j	80003b18 <__printf+0x440>
    80003bec:	00030513          	mv	a0,t1
    80003bf0:	00000097          	auipc	ra,0x0
    80003bf4:	7bc080e7          	jalr	1980(ra) # 800043ac <acquire>
    80003bf8:	b4dff06f          	j	80003744 <__printf+0x6c>
    80003bfc:	40c0053b          	negw	a0,a2
    80003c00:	00a00713          	li	a4,10
    80003c04:	02e576bb          	remuw	a3,a0,a4
    80003c08:	00001d97          	auipc	s11,0x1
    80003c0c:	6f8d8d93          	addi	s11,s11,1784 # 80005300 <digits>
    80003c10:	ff700593          	li	a1,-9
    80003c14:	02069693          	slli	a3,a3,0x20
    80003c18:	0206d693          	srli	a3,a3,0x20
    80003c1c:	00dd86b3          	add	a3,s11,a3
    80003c20:	0006c683          	lbu	a3,0(a3)
    80003c24:	02e557bb          	divuw	a5,a0,a4
    80003c28:	f8d40023          	sb	a3,-128(s0)
    80003c2c:	10b65e63          	bge	a2,a1,80003d48 <__printf+0x670>
    80003c30:	06300593          	li	a1,99
    80003c34:	02e7f6bb          	remuw	a3,a5,a4
    80003c38:	02069693          	slli	a3,a3,0x20
    80003c3c:	0206d693          	srli	a3,a3,0x20
    80003c40:	00dd86b3          	add	a3,s11,a3
    80003c44:	0006c683          	lbu	a3,0(a3)
    80003c48:	02e7d73b          	divuw	a4,a5,a4
    80003c4c:	00200793          	li	a5,2
    80003c50:	f8d400a3          	sb	a3,-127(s0)
    80003c54:	bca5ece3          	bltu	a1,a0,8000382c <__printf+0x154>
    80003c58:	ce5ff06f          	j	8000393c <__printf+0x264>
    80003c5c:	40e007bb          	negw	a5,a4
    80003c60:	00001d97          	auipc	s11,0x1
    80003c64:	6a0d8d93          	addi	s11,s11,1696 # 80005300 <digits>
    80003c68:	00f7f693          	andi	a3,a5,15
    80003c6c:	00dd86b3          	add	a3,s11,a3
    80003c70:	0006c583          	lbu	a1,0(a3)
    80003c74:	ff100613          	li	a2,-15
    80003c78:	0047d69b          	srliw	a3,a5,0x4
    80003c7c:	f8b40023          	sb	a1,-128(s0)
    80003c80:	0047d59b          	srliw	a1,a5,0x4
    80003c84:	0ac75e63          	bge	a4,a2,80003d40 <__printf+0x668>
    80003c88:	00f6f693          	andi	a3,a3,15
    80003c8c:	00dd86b3          	add	a3,s11,a3
    80003c90:	0006c603          	lbu	a2,0(a3)
    80003c94:	00f00693          	li	a3,15
    80003c98:	0087d79b          	srliw	a5,a5,0x8
    80003c9c:	f8c400a3          	sb	a2,-127(s0)
    80003ca0:	d8b6e4e3          	bltu	a3,a1,80003a28 <__printf+0x350>
    80003ca4:	00200793          	li	a5,2
    80003ca8:	e2dff06f          	j	80003ad4 <__printf+0x3fc>
    80003cac:	00001c97          	auipc	s9,0x1
    80003cb0:	634c8c93          	addi	s9,s9,1588 # 800052e0 <_ZZ12printIntegermE6digits+0x148>
    80003cb4:	02800513          	li	a0,40
    80003cb8:	ef1ff06f          	j	80003ba8 <__printf+0x4d0>
    80003cbc:	00700793          	li	a5,7
    80003cc0:	00600c93          	li	s9,6
    80003cc4:	e0dff06f          	j	80003ad0 <__printf+0x3f8>
    80003cc8:	00700793          	li	a5,7
    80003ccc:	00600c93          	li	s9,6
    80003cd0:	c69ff06f          	j	80003938 <__printf+0x260>
    80003cd4:	00300793          	li	a5,3
    80003cd8:	00200c93          	li	s9,2
    80003cdc:	c5dff06f          	j	80003938 <__printf+0x260>
    80003ce0:	00300793          	li	a5,3
    80003ce4:	00200c93          	li	s9,2
    80003ce8:	de9ff06f          	j	80003ad0 <__printf+0x3f8>
    80003cec:	00400793          	li	a5,4
    80003cf0:	00300c93          	li	s9,3
    80003cf4:	dddff06f          	j	80003ad0 <__printf+0x3f8>
    80003cf8:	00400793          	li	a5,4
    80003cfc:	00300c93          	li	s9,3
    80003d00:	c39ff06f          	j	80003938 <__printf+0x260>
    80003d04:	00500793          	li	a5,5
    80003d08:	00400c93          	li	s9,4
    80003d0c:	c2dff06f          	j	80003938 <__printf+0x260>
    80003d10:	00500793          	li	a5,5
    80003d14:	00400c93          	li	s9,4
    80003d18:	db9ff06f          	j	80003ad0 <__printf+0x3f8>
    80003d1c:	00600793          	li	a5,6
    80003d20:	00500c93          	li	s9,5
    80003d24:	dadff06f          	j	80003ad0 <__printf+0x3f8>
    80003d28:	00600793          	li	a5,6
    80003d2c:	00500c93          	li	s9,5
    80003d30:	c09ff06f          	j	80003938 <__printf+0x260>
    80003d34:	00800793          	li	a5,8
    80003d38:	00700c93          	li	s9,7
    80003d3c:	bfdff06f          	j	80003938 <__printf+0x260>
    80003d40:	00100793          	li	a5,1
    80003d44:	d91ff06f          	j	80003ad4 <__printf+0x3fc>
    80003d48:	00100793          	li	a5,1
    80003d4c:	bf1ff06f          	j	8000393c <__printf+0x264>
    80003d50:	00900793          	li	a5,9
    80003d54:	00800c93          	li	s9,8
    80003d58:	be1ff06f          	j	80003938 <__printf+0x260>
    80003d5c:	00001517          	auipc	a0,0x1
    80003d60:	58c50513          	addi	a0,a0,1420 # 800052e8 <_ZZ12printIntegermE6digits+0x150>
    80003d64:	00000097          	auipc	ra,0x0
    80003d68:	918080e7          	jalr	-1768(ra) # 8000367c <panic>

0000000080003d6c <printfinit>:
    80003d6c:	fe010113          	addi	sp,sp,-32
    80003d70:	00813823          	sd	s0,16(sp)
    80003d74:	00913423          	sd	s1,8(sp)
    80003d78:	00113c23          	sd	ra,24(sp)
    80003d7c:	02010413          	addi	s0,sp,32
    80003d80:	00003497          	auipc	s1,0x3
    80003d84:	4c048493          	addi	s1,s1,1216 # 80007240 <pr>
    80003d88:	00048513          	mv	a0,s1
    80003d8c:	00001597          	auipc	a1,0x1
    80003d90:	56c58593          	addi	a1,a1,1388 # 800052f8 <_ZZ12printIntegermE6digits+0x160>
    80003d94:	00000097          	auipc	ra,0x0
    80003d98:	5f4080e7          	jalr	1524(ra) # 80004388 <initlock>
    80003d9c:	01813083          	ld	ra,24(sp)
    80003da0:	01013403          	ld	s0,16(sp)
    80003da4:	0004ac23          	sw	zero,24(s1)
    80003da8:	00813483          	ld	s1,8(sp)
    80003dac:	02010113          	addi	sp,sp,32
    80003db0:	00008067          	ret

0000000080003db4 <uartinit>:
    80003db4:	ff010113          	addi	sp,sp,-16
    80003db8:	00813423          	sd	s0,8(sp)
    80003dbc:	01010413          	addi	s0,sp,16
    80003dc0:	100007b7          	lui	a5,0x10000
    80003dc4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003dc8:	f8000713          	li	a4,-128
    80003dcc:	00e781a3          	sb	a4,3(a5)
    80003dd0:	00300713          	li	a4,3
    80003dd4:	00e78023          	sb	a4,0(a5)
    80003dd8:	000780a3          	sb	zero,1(a5)
    80003ddc:	00e781a3          	sb	a4,3(a5)
    80003de0:	00700693          	li	a3,7
    80003de4:	00d78123          	sb	a3,2(a5)
    80003de8:	00e780a3          	sb	a4,1(a5)
    80003dec:	00813403          	ld	s0,8(sp)
    80003df0:	01010113          	addi	sp,sp,16
    80003df4:	00008067          	ret

0000000080003df8 <uartputc>:
    80003df8:	00002797          	auipc	a5,0x2
    80003dfc:	1c07a783          	lw	a5,448(a5) # 80005fb8 <panicked>
    80003e00:	00078463          	beqz	a5,80003e08 <uartputc+0x10>
    80003e04:	0000006f          	j	80003e04 <uartputc+0xc>
    80003e08:	fd010113          	addi	sp,sp,-48
    80003e0c:	02813023          	sd	s0,32(sp)
    80003e10:	00913c23          	sd	s1,24(sp)
    80003e14:	01213823          	sd	s2,16(sp)
    80003e18:	01313423          	sd	s3,8(sp)
    80003e1c:	02113423          	sd	ra,40(sp)
    80003e20:	03010413          	addi	s0,sp,48
    80003e24:	00002917          	auipc	s2,0x2
    80003e28:	19c90913          	addi	s2,s2,412 # 80005fc0 <uart_tx_r>
    80003e2c:	00093783          	ld	a5,0(s2)
    80003e30:	00002497          	auipc	s1,0x2
    80003e34:	19848493          	addi	s1,s1,408 # 80005fc8 <uart_tx_w>
    80003e38:	0004b703          	ld	a4,0(s1)
    80003e3c:	02078693          	addi	a3,a5,32
    80003e40:	00050993          	mv	s3,a0
    80003e44:	02e69c63          	bne	a3,a4,80003e7c <uartputc+0x84>
    80003e48:	00001097          	auipc	ra,0x1
    80003e4c:	834080e7          	jalr	-1996(ra) # 8000467c <push_on>
    80003e50:	00093783          	ld	a5,0(s2)
    80003e54:	0004b703          	ld	a4,0(s1)
    80003e58:	02078793          	addi	a5,a5,32
    80003e5c:	00e79463          	bne	a5,a4,80003e64 <uartputc+0x6c>
    80003e60:	0000006f          	j	80003e60 <uartputc+0x68>
    80003e64:	00001097          	auipc	ra,0x1
    80003e68:	88c080e7          	jalr	-1908(ra) # 800046f0 <pop_on>
    80003e6c:	00093783          	ld	a5,0(s2)
    80003e70:	0004b703          	ld	a4,0(s1)
    80003e74:	02078693          	addi	a3,a5,32
    80003e78:	fce688e3          	beq	a3,a4,80003e48 <uartputc+0x50>
    80003e7c:	01f77693          	andi	a3,a4,31
    80003e80:	00003597          	auipc	a1,0x3
    80003e84:	3e058593          	addi	a1,a1,992 # 80007260 <uart_tx_buf>
    80003e88:	00d586b3          	add	a3,a1,a3
    80003e8c:	00170713          	addi	a4,a4,1
    80003e90:	01368023          	sb	s3,0(a3)
    80003e94:	00e4b023          	sd	a4,0(s1)
    80003e98:	10000637          	lui	a2,0x10000
    80003e9c:	02f71063          	bne	a4,a5,80003ebc <uartputc+0xc4>
    80003ea0:	0340006f          	j	80003ed4 <uartputc+0xdc>
    80003ea4:	00074703          	lbu	a4,0(a4)
    80003ea8:	00f93023          	sd	a5,0(s2)
    80003eac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003eb0:	00093783          	ld	a5,0(s2)
    80003eb4:	0004b703          	ld	a4,0(s1)
    80003eb8:	00f70e63          	beq	a4,a5,80003ed4 <uartputc+0xdc>
    80003ebc:	00564683          	lbu	a3,5(a2)
    80003ec0:	01f7f713          	andi	a4,a5,31
    80003ec4:	00e58733          	add	a4,a1,a4
    80003ec8:	0206f693          	andi	a3,a3,32
    80003ecc:	00178793          	addi	a5,a5,1
    80003ed0:	fc069ae3          	bnez	a3,80003ea4 <uartputc+0xac>
    80003ed4:	02813083          	ld	ra,40(sp)
    80003ed8:	02013403          	ld	s0,32(sp)
    80003edc:	01813483          	ld	s1,24(sp)
    80003ee0:	01013903          	ld	s2,16(sp)
    80003ee4:	00813983          	ld	s3,8(sp)
    80003ee8:	03010113          	addi	sp,sp,48
    80003eec:	00008067          	ret

0000000080003ef0 <uartputc_sync>:
    80003ef0:	ff010113          	addi	sp,sp,-16
    80003ef4:	00813423          	sd	s0,8(sp)
    80003ef8:	01010413          	addi	s0,sp,16
    80003efc:	00002717          	auipc	a4,0x2
    80003f00:	0bc72703          	lw	a4,188(a4) # 80005fb8 <panicked>
    80003f04:	02071663          	bnez	a4,80003f30 <uartputc_sync+0x40>
    80003f08:	00050793          	mv	a5,a0
    80003f0c:	100006b7          	lui	a3,0x10000
    80003f10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003f14:	02077713          	andi	a4,a4,32
    80003f18:	fe070ce3          	beqz	a4,80003f10 <uartputc_sync+0x20>
    80003f1c:	0ff7f793          	andi	a5,a5,255
    80003f20:	00f68023          	sb	a5,0(a3)
    80003f24:	00813403          	ld	s0,8(sp)
    80003f28:	01010113          	addi	sp,sp,16
    80003f2c:	00008067          	ret
    80003f30:	0000006f          	j	80003f30 <uartputc_sync+0x40>

0000000080003f34 <uartstart>:
    80003f34:	ff010113          	addi	sp,sp,-16
    80003f38:	00813423          	sd	s0,8(sp)
    80003f3c:	01010413          	addi	s0,sp,16
    80003f40:	00002617          	auipc	a2,0x2
    80003f44:	08060613          	addi	a2,a2,128 # 80005fc0 <uart_tx_r>
    80003f48:	00002517          	auipc	a0,0x2
    80003f4c:	08050513          	addi	a0,a0,128 # 80005fc8 <uart_tx_w>
    80003f50:	00063783          	ld	a5,0(a2)
    80003f54:	00053703          	ld	a4,0(a0)
    80003f58:	04f70263          	beq	a4,a5,80003f9c <uartstart+0x68>
    80003f5c:	100005b7          	lui	a1,0x10000
    80003f60:	00003817          	auipc	a6,0x3
    80003f64:	30080813          	addi	a6,a6,768 # 80007260 <uart_tx_buf>
    80003f68:	01c0006f          	j	80003f84 <uartstart+0x50>
    80003f6c:	0006c703          	lbu	a4,0(a3)
    80003f70:	00f63023          	sd	a5,0(a2)
    80003f74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f78:	00063783          	ld	a5,0(a2)
    80003f7c:	00053703          	ld	a4,0(a0)
    80003f80:	00f70e63          	beq	a4,a5,80003f9c <uartstart+0x68>
    80003f84:	01f7f713          	andi	a4,a5,31
    80003f88:	00e806b3          	add	a3,a6,a4
    80003f8c:	0055c703          	lbu	a4,5(a1)
    80003f90:	00178793          	addi	a5,a5,1
    80003f94:	02077713          	andi	a4,a4,32
    80003f98:	fc071ae3          	bnez	a4,80003f6c <uartstart+0x38>
    80003f9c:	00813403          	ld	s0,8(sp)
    80003fa0:	01010113          	addi	sp,sp,16
    80003fa4:	00008067          	ret

0000000080003fa8 <uartgetc>:
    80003fa8:	ff010113          	addi	sp,sp,-16
    80003fac:	00813423          	sd	s0,8(sp)
    80003fb0:	01010413          	addi	s0,sp,16
    80003fb4:	10000737          	lui	a4,0x10000
    80003fb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003fbc:	0017f793          	andi	a5,a5,1
    80003fc0:	00078c63          	beqz	a5,80003fd8 <uartgetc+0x30>
    80003fc4:	00074503          	lbu	a0,0(a4)
    80003fc8:	0ff57513          	andi	a0,a0,255
    80003fcc:	00813403          	ld	s0,8(sp)
    80003fd0:	01010113          	addi	sp,sp,16
    80003fd4:	00008067          	ret
    80003fd8:	fff00513          	li	a0,-1
    80003fdc:	ff1ff06f          	j	80003fcc <uartgetc+0x24>

0000000080003fe0 <uartintr>:
    80003fe0:	100007b7          	lui	a5,0x10000
    80003fe4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003fe8:	0017f793          	andi	a5,a5,1
    80003fec:	0a078463          	beqz	a5,80004094 <uartintr+0xb4>
    80003ff0:	fe010113          	addi	sp,sp,-32
    80003ff4:	00813823          	sd	s0,16(sp)
    80003ff8:	00913423          	sd	s1,8(sp)
    80003ffc:	00113c23          	sd	ra,24(sp)
    80004000:	02010413          	addi	s0,sp,32
    80004004:	100004b7          	lui	s1,0x10000
    80004008:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000400c:	0ff57513          	andi	a0,a0,255
    80004010:	fffff097          	auipc	ra,0xfffff
    80004014:	534080e7          	jalr	1332(ra) # 80003544 <consoleintr>
    80004018:	0054c783          	lbu	a5,5(s1)
    8000401c:	0017f793          	andi	a5,a5,1
    80004020:	fe0794e3          	bnez	a5,80004008 <uartintr+0x28>
    80004024:	00002617          	auipc	a2,0x2
    80004028:	f9c60613          	addi	a2,a2,-100 # 80005fc0 <uart_tx_r>
    8000402c:	00002517          	auipc	a0,0x2
    80004030:	f9c50513          	addi	a0,a0,-100 # 80005fc8 <uart_tx_w>
    80004034:	00063783          	ld	a5,0(a2)
    80004038:	00053703          	ld	a4,0(a0)
    8000403c:	04f70263          	beq	a4,a5,80004080 <uartintr+0xa0>
    80004040:	100005b7          	lui	a1,0x10000
    80004044:	00003817          	auipc	a6,0x3
    80004048:	21c80813          	addi	a6,a6,540 # 80007260 <uart_tx_buf>
    8000404c:	01c0006f          	j	80004068 <uartintr+0x88>
    80004050:	0006c703          	lbu	a4,0(a3)
    80004054:	00f63023          	sd	a5,0(a2)
    80004058:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000405c:	00063783          	ld	a5,0(a2)
    80004060:	00053703          	ld	a4,0(a0)
    80004064:	00f70e63          	beq	a4,a5,80004080 <uartintr+0xa0>
    80004068:	01f7f713          	andi	a4,a5,31
    8000406c:	00e806b3          	add	a3,a6,a4
    80004070:	0055c703          	lbu	a4,5(a1)
    80004074:	00178793          	addi	a5,a5,1
    80004078:	02077713          	andi	a4,a4,32
    8000407c:	fc071ae3          	bnez	a4,80004050 <uartintr+0x70>
    80004080:	01813083          	ld	ra,24(sp)
    80004084:	01013403          	ld	s0,16(sp)
    80004088:	00813483          	ld	s1,8(sp)
    8000408c:	02010113          	addi	sp,sp,32
    80004090:	00008067          	ret
    80004094:	00002617          	auipc	a2,0x2
    80004098:	f2c60613          	addi	a2,a2,-212 # 80005fc0 <uart_tx_r>
    8000409c:	00002517          	auipc	a0,0x2
    800040a0:	f2c50513          	addi	a0,a0,-212 # 80005fc8 <uart_tx_w>
    800040a4:	00063783          	ld	a5,0(a2)
    800040a8:	00053703          	ld	a4,0(a0)
    800040ac:	04f70263          	beq	a4,a5,800040f0 <uartintr+0x110>
    800040b0:	100005b7          	lui	a1,0x10000
    800040b4:	00003817          	auipc	a6,0x3
    800040b8:	1ac80813          	addi	a6,a6,428 # 80007260 <uart_tx_buf>
    800040bc:	01c0006f          	j	800040d8 <uartintr+0xf8>
    800040c0:	0006c703          	lbu	a4,0(a3)
    800040c4:	00f63023          	sd	a5,0(a2)
    800040c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800040cc:	00063783          	ld	a5,0(a2)
    800040d0:	00053703          	ld	a4,0(a0)
    800040d4:	02f70063          	beq	a4,a5,800040f4 <uartintr+0x114>
    800040d8:	01f7f713          	andi	a4,a5,31
    800040dc:	00e806b3          	add	a3,a6,a4
    800040e0:	0055c703          	lbu	a4,5(a1)
    800040e4:	00178793          	addi	a5,a5,1
    800040e8:	02077713          	andi	a4,a4,32
    800040ec:	fc071ae3          	bnez	a4,800040c0 <uartintr+0xe0>
    800040f0:	00008067          	ret
    800040f4:	00008067          	ret

00000000800040f8 <kinit>:
    800040f8:	fc010113          	addi	sp,sp,-64
    800040fc:	02913423          	sd	s1,40(sp)
    80004100:	fffff7b7          	lui	a5,0xfffff
    80004104:	00004497          	auipc	s1,0x4
    80004108:	17b48493          	addi	s1,s1,379 # 8000827f <end+0xfff>
    8000410c:	02813823          	sd	s0,48(sp)
    80004110:	01313c23          	sd	s3,24(sp)
    80004114:	00f4f4b3          	and	s1,s1,a5
    80004118:	02113c23          	sd	ra,56(sp)
    8000411c:	03213023          	sd	s2,32(sp)
    80004120:	01413823          	sd	s4,16(sp)
    80004124:	01513423          	sd	s5,8(sp)
    80004128:	04010413          	addi	s0,sp,64
    8000412c:	000017b7          	lui	a5,0x1
    80004130:	01100993          	li	s3,17
    80004134:	00f487b3          	add	a5,s1,a5
    80004138:	01b99993          	slli	s3,s3,0x1b
    8000413c:	06f9e063          	bltu	s3,a5,8000419c <kinit+0xa4>
    80004140:	00003a97          	auipc	s5,0x3
    80004144:	140a8a93          	addi	s5,s5,320 # 80007280 <end>
    80004148:	0754ec63          	bltu	s1,s5,800041c0 <kinit+0xc8>
    8000414c:	0734fa63          	bgeu	s1,s3,800041c0 <kinit+0xc8>
    80004150:	00088a37          	lui	s4,0x88
    80004154:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004158:	00002917          	auipc	s2,0x2
    8000415c:	e7890913          	addi	s2,s2,-392 # 80005fd0 <kmem>
    80004160:	00ca1a13          	slli	s4,s4,0xc
    80004164:	0140006f          	j	80004178 <kinit+0x80>
    80004168:	000017b7          	lui	a5,0x1
    8000416c:	00f484b3          	add	s1,s1,a5
    80004170:	0554e863          	bltu	s1,s5,800041c0 <kinit+0xc8>
    80004174:	0534f663          	bgeu	s1,s3,800041c0 <kinit+0xc8>
    80004178:	00001637          	lui	a2,0x1
    8000417c:	00100593          	li	a1,1
    80004180:	00048513          	mv	a0,s1
    80004184:	00000097          	auipc	ra,0x0
    80004188:	5e4080e7          	jalr	1508(ra) # 80004768 <__memset>
    8000418c:	00093783          	ld	a5,0(s2)
    80004190:	00f4b023          	sd	a5,0(s1)
    80004194:	00993023          	sd	s1,0(s2)
    80004198:	fd4498e3          	bne	s1,s4,80004168 <kinit+0x70>
    8000419c:	03813083          	ld	ra,56(sp)
    800041a0:	03013403          	ld	s0,48(sp)
    800041a4:	02813483          	ld	s1,40(sp)
    800041a8:	02013903          	ld	s2,32(sp)
    800041ac:	01813983          	ld	s3,24(sp)
    800041b0:	01013a03          	ld	s4,16(sp)
    800041b4:	00813a83          	ld	s5,8(sp)
    800041b8:	04010113          	addi	sp,sp,64
    800041bc:	00008067          	ret
    800041c0:	00001517          	auipc	a0,0x1
    800041c4:	15850513          	addi	a0,a0,344 # 80005318 <digits+0x18>
    800041c8:	fffff097          	auipc	ra,0xfffff
    800041cc:	4b4080e7          	jalr	1204(ra) # 8000367c <panic>

00000000800041d0 <freerange>:
    800041d0:	fc010113          	addi	sp,sp,-64
    800041d4:	000017b7          	lui	a5,0x1
    800041d8:	02913423          	sd	s1,40(sp)
    800041dc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800041e0:	009504b3          	add	s1,a0,s1
    800041e4:	fffff537          	lui	a0,0xfffff
    800041e8:	02813823          	sd	s0,48(sp)
    800041ec:	02113c23          	sd	ra,56(sp)
    800041f0:	03213023          	sd	s2,32(sp)
    800041f4:	01313c23          	sd	s3,24(sp)
    800041f8:	01413823          	sd	s4,16(sp)
    800041fc:	01513423          	sd	s5,8(sp)
    80004200:	01613023          	sd	s6,0(sp)
    80004204:	04010413          	addi	s0,sp,64
    80004208:	00a4f4b3          	and	s1,s1,a0
    8000420c:	00f487b3          	add	a5,s1,a5
    80004210:	06f5e463          	bltu	a1,a5,80004278 <freerange+0xa8>
    80004214:	00003a97          	auipc	s5,0x3
    80004218:	06ca8a93          	addi	s5,s5,108 # 80007280 <end>
    8000421c:	0954e263          	bltu	s1,s5,800042a0 <freerange+0xd0>
    80004220:	01100993          	li	s3,17
    80004224:	01b99993          	slli	s3,s3,0x1b
    80004228:	0734fc63          	bgeu	s1,s3,800042a0 <freerange+0xd0>
    8000422c:	00058a13          	mv	s4,a1
    80004230:	00002917          	auipc	s2,0x2
    80004234:	da090913          	addi	s2,s2,-608 # 80005fd0 <kmem>
    80004238:	00002b37          	lui	s6,0x2
    8000423c:	0140006f          	j	80004250 <freerange+0x80>
    80004240:	000017b7          	lui	a5,0x1
    80004244:	00f484b3          	add	s1,s1,a5
    80004248:	0554ec63          	bltu	s1,s5,800042a0 <freerange+0xd0>
    8000424c:	0534fa63          	bgeu	s1,s3,800042a0 <freerange+0xd0>
    80004250:	00001637          	lui	a2,0x1
    80004254:	00100593          	li	a1,1
    80004258:	00048513          	mv	a0,s1
    8000425c:	00000097          	auipc	ra,0x0
    80004260:	50c080e7          	jalr	1292(ra) # 80004768 <__memset>
    80004264:	00093703          	ld	a4,0(s2)
    80004268:	016487b3          	add	a5,s1,s6
    8000426c:	00e4b023          	sd	a4,0(s1)
    80004270:	00993023          	sd	s1,0(s2)
    80004274:	fcfa76e3          	bgeu	s4,a5,80004240 <freerange+0x70>
    80004278:	03813083          	ld	ra,56(sp)
    8000427c:	03013403          	ld	s0,48(sp)
    80004280:	02813483          	ld	s1,40(sp)
    80004284:	02013903          	ld	s2,32(sp)
    80004288:	01813983          	ld	s3,24(sp)
    8000428c:	01013a03          	ld	s4,16(sp)
    80004290:	00813a83          	ld	s5,8(sp)
    80004294:	00013b03          	ld	s6,0(sp)
    80004298:	04010113          	addi	sp,sp,64
    8000429c:	00008067          	ret
    800042a0:	00001517          	auipc	a0,0x1
    800042a4:	07850513          	addi	a0,a0,120 # 80005318 <digits+0x18>
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	3d4080e7          	jalr	980(ra) # 8000367c <panic>

00000000800042b0 <kfree>:
    800042b0:	fe010113          	addi	sp,sp,-32
    800042b4:	00813823          	sd	s0,16(sp)
    800042b8:	00113c23          	sd	ra,24(sp)
    800042bc:	00913423          	sd	s1,8(sp)
    800042c0:	02010413          	addi	s0,sp,32
    800042c4:	03451793          	slli	a5,a0,0x34
    800042c8:	04079c63          	bnez	a5,80004320 <kfree+0x70>
    800042cc:	00003797          	auipc	a5,0x3
    800042d0:	fb478793          	addi	a5,a5,-76 # 80007280 <end>
    800042d4:	00050493          	mv	s1,a0
    800042d8:	04f56463          	bltu	a0,a5,80004320 <kfree+0x70>
    800042dc:	01100793          	li	a5,17
    800042e0:	01b79793          	slli	a5,a5,0x1b
    800042e4:	02f57e63          	bgeu	a0,a5,80004320 <kfree+0x70>
    800042e8:	00001637          	lui	a2,0x1
    800042ec:	00100593          	li	a1,1
    800042f0:	00000097          	auipc	ra,0x0
    800042f4:	478080e7          	jalr	1144(ra) # 80004768 <__memset>
    800042f8:	00002797          	auipc	a5,0x2
    800042fc:	cd878793          	addi	a5,a5,-808 # 80005fd0 <kmem>
    80004300:	0007b703          	ld	a4,0(a5)
    80004304:	01813083          	ld	ra,24(sp)
    80004308:	01013403          	ld	s0,16(sp)
    8000430c:	00e4b023          	sd	a4,0(s1)
    80004310:	0097b023          	sd	s1,0(a5)
    80004314:	00813483          	ld	s1,8(sp)
    80004318:	02010113          	addi	sp,sp,32
    8000431c:	00008067          	ret
    80004320:	00001517          	auipc	a0,0x1
    80004324:	ff850513          	addi	a0,a0,-8 # 80005318 <digits+0x18>
    80004328:	fffff097          	auipc	ra,0xfffff
    8000432c:	354080e7          	jalr	852(ra) # 8000367c <panic>

0000000080004330 <kalloc>:
    80004330:	fe010113          	addi	sp,sp,-32
    80004334:	00813823          	sd	s0,16(sp)
    80004338:	00913423          	sd	s1,8(sp)
    8000433c:	00113c23          	sd	ra,24(sp)
    80004340:	02010413          	addi	s0,sp,32
    80004344:	00002797          	auipc	a5,0x2
    80004348:	c8c78793          	addi	a5,a5,-884 # 80005fd0 <kmem>
    8000434c:	0007b483          	ld	s1,0(a5)
    80004350:	02048063          	beqz	s1,80004370 <kalloc+0x40>
    80004354:	0004b703          	ld	a4,0(s1)
    80004358:	00001637          	lui	a2,0x1
    8000435c:	00500593          	li	a1,5
    80004360:	00048513          	mv	a0,s1
    80004364:	00e7b023          	sd	a4,0(a5)
    80004368:	00000097          	auipc	ra,0x0
    8000436c:	400080e7          	jalr	1024(ra) # 80004768 <__memset>
    80004370:	01813083          	ld	ra,24(sp)
    80004374:	01013403          	ld	s0,16(sp)
    80004378:	00048513          	mv	a0,s1
    8000437c:	00813483          	ld	s1,8(sp)
    80004380:	02010113          	addi	sp,sp,32
    80004384:	00008067          	ret

0000000080004388 <initlock>:
    80004388:	ff010113          	addi	sp,sp,-16
    8000438c:	00813423          	sd	s0,8(sp)
    80004390:	01010413          	addi	s0,sp,16
    80004394:	00813403          	ld	s0,8(sp)
    80004398:	00b53423          	sd	a1,8(a0)
    8000439c:	00052023          	sw	zero,0(a0)
    800043a0:	00053823          	sd	zero,16(a0)
    800043a4:	01010113          	addi	sp,sp,16
    800043a8:	00008067          	ret

00000000800043ac <acquire>:
    800043ac:	fe010113          	addi	sp,sp,-32
    800043b0:	00813823          	sd	s0,16(sp)
    800043b4:	00913423          	sd	s1,8(sp)
    800043b8:	00113c23          	sd	ra,24(sp)
    800043bc:	01213023          	sd	s2,0(sp)
    800043c0:	02010413          	addi	s0,sp,32
    800043c4:	00050493          	mv	s1,a0
    800043c8:	10002973          	csrr	s2,sstatus
    800043cc:	100027f3          	csrr	a5,sstatus
    800043d0:	ffd7f793          	andi	a5,a5,-3
    800043d4:	10079073          	csrw	sstatus,a5
    800043d8:	fffff097          	auipc	ra,0xfffff
    800043dc:	8ec080e7          	jalr	-1812(ra) # 80002cc4 <mycpu>
    800043e0:	07852783          	lw	a5,120(a0)
    800043e4:	06078e63          	beqz	a5,80004460 <acquire+0xb4>
    800043e8:	fffff097          	auipc	ra,0xfffff
    800043ec:	8dc080e7          	jalr	-1828(ra) # 80002cc4 <mycpu>
    800043f0:	07852783          	lw	a5,120(a0)
    800043f4:	0004a703          	lw	a4,0(s1)
    800043f8:	0017879b          	addiw	a5,a5,1
    800043fc:	06f52c23          	sw	a5,120(a0)
    80004400:	04071063          	bnez	a4,80004440 <acquire+0x94>
    80004404:	00100713          	li	a4,1
    80004408:	00070793          	mv	a5,a4
    8000440c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004410:	0007879b          	sext.w	a5,a5
    80004414:	fe079ae3          	bnez	a5,80004408 <acquire+0x5c>
    80004418:	0ff0000f          	fence
    8000441c:	fffff097          	auipc	ra,0xfffff
    80004420:	8a8080e7          	jalr	-1880(ra) # 80002cc4 <mycpu>
    80004424:	01813083          	ld	ra,24(sp)
    80004428:	01013403          	ld	s0,16(sp)
    8000442c:	00a4b823          	sd	a0,16(s1)
    80004430:	00013903          	ld	s2,0(sp)
    80004434:	00813483          	ld	s1,8(sp)
    80004438:	02010113          	addi	sp,sp,32
    8000443c:	00008067          	ret
    80004440:	0104b903          	ld	s2,16(s1)
    80004444:	fffff097          	auipc	ra,0xfffff
    80004448:	880080e7          	jalr	-1920(ra) # 80002cc4 <mycpu>
    8000444c:	faa91ce3          	bne	s2,a0,80004404 <acquire+0x58>
    80004450:	00001517          	auipc	a0,0x1
    80004454:	ed050513          	addi	a0,a0,-304 # 80005320 <digits+0x20>
    80004458:	fffff097          	auipc	ra,0xfffff
    8000445c:	224080e7          	jalr	548(ra) # 8000367c <panic>
    80004460:	00195913          	srli	s2,s2,0x1
    80004464:	fffff097          	auipc	ra,0xfffff
    80004468:	860080e7          	jalr	-1952(ra) # 80002cc4 <mycpu>
    8000446c:	00197913          	andi	s2,s2,1
    80004470:	07252e23          	sw	s2,124(a0)
    80004474:	f75ff06f          	j	800043e8 <acquire+0x3c>

0000000080004478 <release>:
    80004478:	fe010113          	addi	sp,sp,-32
    8000447c:	00813823          	sd	s0,16(sp)
    80004480:	00113c23          	sd	ra,24(sp)
    80004484:	00913423          	sd	s1,8(sp)
    80004488:	01213023          	sd	s2,0(sp)
    8000448c:	02010413          	addi	s0,sp,32
    80004490:	00052783          	lw	a5,0(a0)
    80004494:	00079a63          	bnez	a5,800044a8 <release+0x30>
    80004498:	00001517          	auipc	a0,0x1
    8000449c:	e9050513          	addi	a0,a0,-368 # 80005328 <digits+0x28>
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	1dc080e7          	jalr	476(ra) # 8000367c <panic>
    800044a8:	01053903          	ld	s2,16(a0)
    800044ac:	00050493          	mv	s1,a0
    800044b0:	fffff097          	auipc	ra,0xfffff
    800044b4:	814080e7          	jalr	-2028(ra) # 80002cc4 <mycpu>
    800044b8:	fea910e3          	bne	s2,a0,80004498 <release+0x20>
    800044bc:	0004b823          	sd	zero,16(s1)
    800044c0:	0ff0000f          	fence
    800044c4:	0f50000f          	fence	iorw,ow
    800044c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800044cc:	ffffe097          	auipc	ra,0xffffe
    800044d0:	7f8080e7          	jalr	2040(ra) # 80002cc4 <mycpu>
    800044d4:	100027f3          	csrr	a5,sstatus
    800044d8:	0027f793          	andi	a5,a5,2
    800044dc:	04079a63          	bnez	a5,80004530 <release+0xb8>
    800044e0:	07852783          	lw	a5,120(a0)
    800044e4:	02f05e63          	blez	a5,80004520 <release+0xa8>
    800044e8:	fff7871b          	addiw	a4,a5,-1
    800044ec:	06e52c23          	sw	a4,120(a0)
    800044f0:	00071c63          	bnez	a4,80004508 <release+0x90>
    800044f4:	07c52783          	lw	a5,124(a0)
    800044f8:	00078863          	beqz	a5,80004508 <release+0x90>
    800044fc:	100027f3          	csrr	a5,sstatus
    80004500:	0027e793          	ori	a5,a5,2
    80004504:	10079073          	csrw	sstatus,a5
    80004508:	01813083          	ld	ra,24(sp)
    8000450c:	01013403          	ld	s0,16(sp)
    80004510:	00813483          	ld	s1,8(sp)
    80004514:	00013903          	ld	s2,0(sp)
    80004518:	02010113          	addi	sp,sp,32
    8000451c:	00008067          	ret
    80004520:	00001517          	auipc	a0,0x1
    80004524:	e2850513          	addi	a0,a0,-472 # 80005348 <digits+0x48>
    80004528:	fffff097          	auipc	ra,0xfffff
    8000452c:	154080e7          	jalr	340(ra) # 8000367c <panic>
    80004530:	00001517          	auipc	a0,0x1
    80004534:	e0050513          	addi	a0,a0,-512 # 80005330 <digits+0x30>
    80004538:	fffff097          	auipc	ra,0xfffff
    8000453c:	144080e7          	jalr	324(ra) # 8000367c <panic>

0000000080004540 <holding>:
    80004540:	00052783          	lw	a5,0(a0)
    80004544:	00079663          	bnez	a5,80004550 <holding+0x10>
    80004548:	00000513          	li	a0,0
    8000454c:	00008067          	ret
    80004550:	fe010113          	addi	sp,sp,-32
    80004554:	00813823          	sd	s0,16(sp)
    80004558:	00913423          	sd	s1,8(sp)
    8000455c:	00113c23          	sd	ra,24(sp)
    80004560:	02010413          	addi	s0,sp,32
    80004564:	01053483          	ld	s1,16(a0)
    80004568:	ffffe097          	auipc	ra,0xffffe
    8000456c:	75c080e7          	jalr	1884(ra) # 80002cc4 <mycpu>
    80004570:	01813083          	ld	ra,24(sp)
    80004574:	01013403          	ld	s0,16(sp)
    80004578:	40a48533          	sub	a0,s1,a0
    8000457c:	00153513          	seqz	a0,a0
    80004580:	00813483          	ld	s1,8(sp)
    80004584:	02010113          	addi	sp,sp,32
    80004588:	00008067          	ret

000000008000458c <push_off>:
    8000458c:	fe010113          	addi	sp,sp,-32
    80004590:	00813823          	sd	s0,16(sp)
    80004594:	00113c23          	sd	ra,24(sp)
    80004598:	00913423          	sd	s1,8(sp)
    8000459c:	02010413          	addi	s0,sp,32
    800045a0:	100024f3          	csrr	s1,sstatus
    800045a4:	100027f3          	csrr	a5,sstatus
    800045a8:	ffd7f793          	andi	a5,a5,-3
    800045ac:	10079073          	csrw	sstatus,a5
    800045b0:	ffffe097          	auipc	ra,0xffffe
    800045b4:	714080e7          	jalr	1812(ra) # 80002cc4 <mycpu>
    800045b8:	07852783          	lw	a5,120(a0)
    800045bc:	02078663          	beqz	a5,800045e8 <push_off+0x5c>
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	704080e7          	jalr	1796(ra) # 80002cc4 <mycpu>
    800045c8:	07852783          	lw	a5,120(a0)
    800045cc:	01813083          	ld	ra,24(sp)
    800045d0:	01013403          	ld	s0,16(sp)
    800045d4:	0017879b          	addiw	a5,a5,1
    800045d8:	06f52c23          	sw	a5,120(a0)
    800045dc:	00813483          	ld	s1,8(sp)
    800045e0:	02010113          	addi	sp,sp,32
    800045e4:	00008067          	ret
    800045e8:	0014d493          	srli	s1,s1,0x1
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	6d8080e7          	jalr	1752(ra) # 80002cc4 <mycpu>
    800045f4:	0014f493          	andi	s1,s1,1
    800045f8:	06952e23          	sw	s1,124(a0)
    800045fc:	fc5ff06f          	j	800045c0 <push_off+0x34>

0000000080004600 <pop_off>:
    80004600:	ff010113          	addi	sp,sp,-16
    80004604:	00813023          	sd	s0,0(sp)
    80004608:	00113423          	sd	ra,8(sp)
    8000460c:	01010413          	addi	s0,sp,16
    80004610:	ffffe097          	auipc	ra,0xffffe
    80004614:	6b4080e7          	jalr	1716(ra) # 80002cc4 <mycpu>
    80004618:	100027f3          	csrr	a5,sstatus
    8000461c:	0027f793          	andi	a5,a5,2
    80004620:	04079663          	bnez	a5,8000466c <pop_off+0x6c>
    80004624:	07852783          	lw	a5,120(a0)
    80004628:	02f05a63          	blez	a5,8000465c <pop_off+0x5c>
    8000462c:	fff7871b          	addiw	a4,a5,-1
    80004630:	06e52c23          	sw	a4,120(a0)
    80004634:	00071c63          	bnez	a4,8000464c <pop_off+0x4c>
    80004638:	07c52783          	lw	a5,124(a0)
    8000463c:	00078863          	beqz	a5,8000464c <pop_off+0x4c>
    80004640:	100027f3          	csrr	a5,sstatus
    80004644:	0027e793          	ori	a5,a5,2
    80004648:	10079073          	csrw	sstatus,a5
    8000464c:	00813083          	ld	ra,8(sp)
    80004650:	00013403          	ld	s0,0(sp)
    80004654:	01010113          	addi	sp,sp,16
    80004658:	00008067          	ret
    8000465c:	00001517          	auipc	a0,0x1
    80004660:	cec50513          	addi	a0,a0,-788 # 80005348 <digits+0x48>
    80004664:	fffff097          	auipc	ra,0xfffff
    80004668:	018080e7          	jalr	24(ra) # 8000367c <panic>
    8000466c:	00001517          	auipc	a0,0x1
    80004670:	cc450513          	addi	a0,a0,-828 # 80005330 <digits+0x30>
    80004674:	fffff097          	auipc	ra,0xfffff
    80004678:	008080e7          	jalr	8(ra) # 8000367c <panic>

000000008000467c <push_on>:
    8000467c:	fe010113          	addi	sp,sp,-32
    80004680:	00813823          	sd	s0,16(sp)
    80004684:	00113c23          	sd	ra,24(sp)
    80004688:	00913423          	sd	s1,8(sp)
    8000468c:	02010413          	addi	s0,sp,32
    80004690:	100024f3          	csrr	s1,sstatus
    80004694:	100027f3          	csrr	a5,sstatus
    80004698:	0027e793          	ori	a5,a5,2
    8000469c:	10079073          	csrw	sstatus,a5
    800046a0:	ffffe097          	auipc	ra,0xffffe
    800046a4:	624080e7          	jalr	1572(ra) # 80002cc4 <mycpu>
    800046a8:	07852783          	lw	a5,120(a0)
    800046ac:	02078663          	beqz	a5,800046d8 <push_on+0x5c>
    800046b0:	ffffe097          	auipc	ra,0xffffe
    800046b4:	614080e7          	jalr	1556(ra) # 80002cc4 <mycpu>
    800046b8:	07852783          	lw	a5,120(a0)
    800046bc:	01813083          	ld	ra,24(sp)
    800046c0:	01013403          	ld	s0,16(sp)
    800046c4:	0017879b          	addiw	a5,a5,1
    800046c8:	06f52c23          	sw	a5,120(a0)
    800046cc:	00813483          	ld	s1,8(sp)
    800046d0:	02010113          	addi	sp,sp,32
    800046d4:	00008067          	ret
    800046d8:	0014d493          	srli	s1,s1,0x1
    800046dc:	ffffe097          	auipc	ra,0xffffe
    800046e0:	5e8080e7          	jalr	1512(ra) # 80002cc4 <mycpu>
    800046e4:	0014f493          	andi	s1,s1,1
    800046e8:	06952e23          	sw	s1,124(a0)
    800046ec:	fc5ff06f          	j	800046b0 <push_on+0x34>

00000000800046f0 <pop_on>:
    800046f0:	ff010113          	addi	sp,sp,-16
    800046f4:	00813023          	sd	s0,0(sp)
    800046f8:	00113423          	sd	ra,8(sp)
    800046fc:	01010413          	addi	s0,sp,16
    80004700:	ffffe097          	auipc	ra,0xffffe
    80004704:	5c4080e7          	jalr	1476(ra) # 80002cc4 <mycpu>
    80004708:	100027f3          	csrr	a5,sstatus
    8000470c:	0027f793          	andi	a5,a5,2
    80004710:	04078463          	beqz	a5,80004758 <pop_on+0x68>
    80004714:	07852783          	lw	a5,120(a0)
    80004718:	02f05863          	blez	a5,80004748 <pop_on+0x58>
    8000471c:	fff7879b          	addiw	a5,a5,-1
    80004720:	06f52c23          	sw	a5,120(a0)
    80004724:	07853783          	ld	a5,120(a0)
    80004728:	00079863          	bnez	a5,80004738 <pop_on+0x48>
    8000472c:	100027f3          	csrr	a5,sstatus
    80004730:	ffd7f793          	andi	a5,a5,-3
    80004734:	10079073          	csrw	sstatus,a5
    80004738:	00813083          	ld	ra,8(sp)
    8000473c:	00013403          	ld	s0,0(sp)
    80004740:	01010113          	addi	sp,sp,16
    80004744:	00008067          	ret
    80004748:	00001517          	auipc	a0,0x1
    8000474c:	c2850513          	addi	a0,a0,-984 # 80005370 <digits+0x70>
    80004750:	fffff097          	auipc	ra,0xfffff
    80004754:	f2c080e7          	jalr	-212(ra) # 8000367c <panic>
    80004758:	00001517          	auipc	a0,0x1
    8000475c:	bf850513          	addi	a0,a0,-1032 # 80005350 <digits+0x50>
    80004760:	fffff097          	auipc	ra,0xfffff
    80004764:	f1c080e7          	jalr	-228(ra) # 8000367c <panic>

0000000080004768 <__memset>:
    80004768:	ff010113          	addi	sp,sp,-16
    8000476c:	00813423          	sd	s0,8(sp)
    80004770:	01010413          	addi	s0,sp,16
    80004774:	1a060e63          	beqz	a2,80004930 <__memset+0x1c8>
    80004778:	40a007b3          	neg	a5,a0
    8000477c:	0077f793          	andi	a5,a5,7
    80004780:	00778693          	addi	a3,a5,7
    80004784:	00b00813          	li	a6,11
    80004788:	0ff5f593          	andi	a1,a1,255
    8000478c:	fff6071b          	addiw	a4,a2,-1
    80004790:	1b06e663          	bltu	a3,a6,8000493c <__memset+0x1d4>
    80004794:	1cd76463          	bltu	a4,a3,8000495c <__memset+0x1f4>
    80004798:	1a078e63          	beqz	a5,80004954 <__memset+0x1ec>
    8000479c:	00b50023          	sb	a1,0(a0)
    800047a0:	00100713          	li	a4,1
    800047a4:	1ae78463          	beq	a5,a4,8000494c <__memset+0x1e4>
    800047a8:	00b500a3          	sb	a1,1(a0)
    800047ac:	00200713          	li	a4,2
    800047b0:	1ae78a63          	beq	a5,a4,80004964 <__memset+0x1fc>
    800047b4:	00b50123          	sb	a1,2(a0)
    800047b8:	00300713          	li	a4,3
    800047bc:	18e78463          	beq	a5,a4,80004944 <__memset+0x1dc>
    800047c0:	00b501a3          	sb	a1,3(a0)
    800047c4:	00400713          	li	a4,4
    800047c8:	1ae78263          	beq	a5,a4,8000496c <__memset+0x204>
    800047cc:	00b50223          	sb	a1,4(a0)
    800047d0:	00500713          	li	a4,5
    800047d4:	1ae78063          	beq	a5,a4,80004974 <__memset+0x20c>
    800047d8:	00b502a3          	sb	a1,5(a0)
    800047dc:	00700713          	li	a4,7
    800047e0:	18e79e63          	bne	a5,a4,8000497c <__memset+0x214>
    800047e4:	00b50323          	sb	a1,6(a0)
    800047e8:	00700e93          	li	t4,7
    800047ec:	00859713          	slli	a4,a1,0x8
    800047f0:	00e5e733          	or	a4,a1,a4
    800047f4:	01059e13          	slli	t3,a1,0x10
    800047f8:	01c76e33          	or	t3,a4,t3
    800047fc:	01859313          	slli	t1,a1,0x18
    80004800:	006e6333          	or	t1,t3,t1
    80004804:	02059893          	slli	a7,a1,0x20
    80004808:	40f60e3b          	subw	t3,a2,a5
    8000480c:	011368b3          	or	a7,t1,a7
    80004810:	02859813          	slli	a6,a1,0x28
    80004814:	0108e833          	or	a6,a7,a6
    80004818:	03059693          	slli	a3,a1,0x30
    8000481c:	003e589b          	srliw	a7,t3,0x3
    80004820:	00d866b3          	or	a3,a6,a3
    80004824:	03859713          	slli	a4,a1,0x38
    80004828:	00389813          	slli	a6,a7,0x3
    8000482c:	00f507b3          	add	a5,a0,a5
    80004830:	00e6e733          	or	a4,a3,a4
    80004834:	000e089b          	sext.w	a7,t3
    80004838:	00f806b3          	add	a3,a6,a5
    8000483c:	00e7b023          	sd	a4,0(a5)
    80004840:	00878793          	addi	a5,a5,8
    80004844:	fed79ce3          	bne	a5,a3,8000483c <__memset+0xd4>
    80004848:	ff8e7793          	andi	a5,t3,-8
    8000484c:	0007871b          	sext.w	a4,a5
    80004850:	01d787bb          	addw	a5,a5,t4
    80004854:	0ce88e63          	beq	a7,a4,80004930 <__memset+0x1c8>
    80004858:	00f50733          	add	a4,a0,a5
    8000485c:	00b70023          	sb	a1,0(a4)
    80004860:	0017871b          	addiw	a4,a5,1
    80004864:	0cc77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004868:	00e50733          	add	a4,a0,a4
    8000486c:	00b70023          	sb	a1,0(a4)
    80004870:	0027871b          	addiw	a4,a5,2
    80004874:	0ac77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004878:	00e50733          	add	a4,a0,a4
    8000487c:	00b70023          	sb	a1,0(a4)
    80004880:	0037871b          	addiw	a4,a5,3
    80004884:	0ac77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004888:	00e50733          	add	a4,a0,a4
    8000488c:	00b70023          	sb	a1,0(a4)
    80004890:	0047871b          	addiw	a4,a5,4
    80004894:	08c77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004898:	00e50733          	add	a4,a0,a4
    8000489c:	00b70023          	sb	a1,0(a4)
    800048a0:	0057871b          	addiw	a4,a5,5
    800048a4:	08c77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048a8:	00e50733          	add	a4,a0,a4
    800048ac:	00b70023          	sb	a1,0(a4)
    800048b0:	0067871b          	addiw	a4,a5,6
    800048b4:	06c77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048b8:	00e50733          	add	a4,a0,a4
    800048bc:	00b70023          	sb	a1,0(a4)
    800048c0:	0077871b          	addiw	a4,a5,7
    800048c4:	06c77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048c8:	00e50733          	add	a4,a0,a4
    800048cc:	00b70023          	sb	a1,0(a4)
    800048d0:	0087871b          	addiw	a4,a5,8
    800048d4:	04c77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048d8:	00e50733          	add	a4,a0,a4
    800048dc:	00b70023          	sb	a1,0(a4)
    800048e0:	0097871b          	addiw	a4,a5,9
    800048e4:	04c77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048e8:	00e50733          	add	a4,a0,a4
    800048ec:	00b70023          	sb	a1,0(a4)
    800048f0:	00a7871b          	addiw	a4,a5,10
    800048f4:	02c77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    800048f8:	00e50733          	add	a4,a0,a4
    800048fc:	00b70023          	sb	a1,0(a4)
    80004900:	00b7871b          	addiw	a4,a5,11
    80004904:	02c77663          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004908:	00e50733          	add	a4,a0,a4
    8000490c:	00b70023          	sb	a1,0(a4)
    80004910:	00c7871b          	addiw	a4,a5,12
    80004914:	00c77e63          	bgeu	a4,a2,80004930 <__memset+0x1c8>
    80004918:	00e50733          	add	a4,a0,a4
    8000491c:	00b70023          	sb	a1,0(a4)
    80004920:	00d7879b          	addiw	a5,a5,13
    80004924:	00c7f663          	bgeu	a5,a2,80004930 <__memset+0x1c8>
    80004928:	00f507b3          	add	a5,a0,a5
    8000492c:	00b78023          	sb	a1,0(a5)
    80004930:	00813403          	ld	s0,8(sp)
    80004934:	01010113          	addi	sp,sp,16
    80004938:	00008067          	ret
    8000493c:	00b00693          	li	a3,11
    80004940:	e55ff06f          	j	80004794 <__memset+0x2c>
    80004944:	00300e93          	li	t4,3
    80004948:	ea5ff06f          	j	800047ec <__memset+0x84>
    8000494c:	00100e93          	li	t4,1
    80004950:	e9dff06f          	j	800047ec <__memset+0x84>
    80004954:	00000e93          	li	t4,0
    80004958:	e95ff06f          	j	800047ec <__memset+0x84>
    8000495c:	00000793          	li	a5,0
    80004960:	ef9ff06f          	j	80004858 <__memset+0xf0>
    80004964:	00200e93          	li	t4,2
    80004968:	e85ff06f          	j	800047ec <__memset+0x84>
    8000496c:	00400e93          	li	t4,4
    80004970:	e7dff06f          	j	800047ec <__memset+0x84>
    80004974:	00500e93          	li	t4,5
    80004978:	e75ff06f          	j	800047ec <__memset+0x84>
    8000497c:	00600e93          	li	t4,6
    80004980:	e6dff06f          	j	800047ec <__memset+0x84>

0000000080004984 <__memmove>:
    80004984:	ff010113          	addi	sp,sp,-16
    80004988:	00813423          	sd	s0,8(sp)
    8000498c:	01010413          	addi	s0,sp,16
    80004990:	0e060863          	beqz	a2,80004a80 <__memmove+0xfc>
    80004994:	fff6069b          	addiw	a3,a2,-1
    80004998:	0006881b          	sext.w	a6,a3
    8000499c:	0ea5e863          	bltu	a1,a0,80004a8c <__memmove+0x108>
    800049a0:	00758713          	addi	a4,a1,7
    800049a4:	00a5e7b3          	or	a5,a1,a0
    800049a8:	40a70733          	sub	a4,a4,a0
    800049ac:	0077f793          	andi	a5,a5,7
    800049b0:	00f73713          	sltiu	a4,a4,15
    800049b4:	00174713          	xori	a4,a4,1
    800049b8:	0017b793          	seqz	a5,a5
    800049bc:	00e7f7b3          	and	a5,a5,a4
    800049c0:	10078863          	beqz	a5,80004ad0 <__memmove+0x14c>
    800049c4:	00900793          	li	a5,9
    800049c8:	1107f463          	bgeu	a5,a6,80004ad0 <__memmove+0x14c>
    800049cc:	0036581b          	srliw	a6,a2,0x3
    800049d0:	fff8081b          	addiw	a6,a6,-1
    800049d4:	02081813          	slli	a6,a6,0x20
    800049d8:	01d85893          	srli	a7,a6,0x1d
    800049dc:	00858813          	addi	a6,a1,8
    800049e0:	00058793          	mv	a5,a1
    800049e4:	00050713          	mv	a4,a0
    800049e8:	01088833          	add	a6,a7,a6
    800049ec:	0007b883          	ld	a7,0(a5)
    800049f0:	00878793          	addi	a5,a5,8
    800049f4:	00870713          	addi	a4,a4,8
    800049f8:	ff173c23          	sd	a7,-8(a4)
    800049fc:	ff0798e3          	bne	a5,a6,800049ec <__memmove+0x68>
    80004a00:	ff867713          	andi	a4,a2,-8
    80004a04:	02071793          	slli	a5,a4,0x20
    80004a08:	0207d793          	srli	a5,a5,0x20
    80004a0c:	00f585b3          	add	a1,a1,a5
    80004a10:	40e686bb          	subw	a3,a3,a4
    80004a14:	00f507b3          	add	a5,a0,a5
    80004a18:	06e60463          	beq	a2,a4,80004a80 <__memmove+0xfc>
    80004a1c:	0005c703          	lbu	a4,0(a1)
    80004a20:	00e78023          	sb	a4,0(a5)
    80004a24:	04068e63          	beqz	a3,80004a80 <__memmove+0xfc>
    80004a28:	0015c603          	lbu	a2,1(a1)
    80004a2c:	00100713          	li	a4,1
    80004a30:	00c780a3          	sb	a2,1(a5)
    80004a34:	04e68663          	beq	a3,a4,80004a80 <__memmove+0xfc>
    80004a38:	0025c603          	lbu	a2,2(a1)
    80004a3c:	00200713          	li	a4,2
    80004a40:	00c78123          	sb	a2,2(a5)
    80004a44:	02e68e63          	beq	a3,a4,80004a80 <__memmove+0xfc>
    80004a48:	0035c603          	lbu	a2,3(a1)
    80004a4c:	00300713          	li	a4,3
    80004a50:	00c781a3          	sb	a2,3(a5)
    80004a54:	02e68663          	beq	a3,a4,80004a80 <__memmove+0xfc>
    80004a58:	0045c603          	lbu	a2,4(a1)
    80004a5c:	00400713          	li	a4,4
    80004a60:	00c78223          	sb	a2,4(a5)
    80004a64:	00e68e63          	beq	a3,a4,80004a80 <__memmove+0xfc>
    80004a68:	0055c603          	lbu	a2,5(a1)
    80004a6c:	00500713          	li	a4,5
    80004a70:	00c782a3          	sb	a2,5(a5)
    80004a74:	00e68663          	beq	a3,a4,80004a80 <__memmove+0xfc>
    80004a78:	0065c703          	lbu	a4,6(a1)
    80004a7c:	00e78323          	sb	a4,6(a5)
    80004a80:	00813403          	ld	s0,8(sp)
    80004a84:	01010113          	addi	sp,sp,16
    80004a88:	00008067          	ret
    80004a8c:	02061713          	slli	a4,a2,0x20
    80004a90:	02075713          	srli	a4,a4,0x20
    80004a94:	00e587b3          	add	a5,a1,a4
    80004a98:	f0f574e3          	bgeu	a0,a5,800049a0 <__memmove+0x1c>
    80004a9c:	02069613          	slli	a2,a3,0x20
    80004aa0:	02065613          	srli	a2,a2,0x20
    80004aa4:	fff64613          	not	a2,a2
    80004aa8:	00e50733          	add	a4,a0,a4
    80004aac:	00c78633          	add	a2,a5,a2
    80004ab0:	fff7c683          	lbu	a3,-1(a5)
    80004ab4:	fff78793          	addi	a5,a5,-1
    80004ab8:	fff70713          	addi	a4,a4,-1
    80004abc:	00d70023          	sb	a3,0(a4)
    80004ac0:	fec798e3          	bne	a5,a2,80004ab0 <__memmove+0x12c>
    80004ac4:	00813403          	ld	s0,8(sp)
    80004ac8:	01010113          	addi	sp,sp,16
    80004acc:	00008067          	ret
    80004ad0:	02069713          	slli	a4,a3,0x20
    80004ad4:	02075713          	srli	a4,a4,0x20
    80004ad8:	00170713          	addi	a4,a4,1
    80004adc:	00e50733          	add	a4,a0,a4
    80004ae0:	00050793          	mv	a5,a0
    80004ae4:	0005c683          	lbu	a3,0(a1)
    80004ae8:	00178793          	addi	a5,a5,1
    80004aec:	00158593          	addi	a1,a1,1
    80004af0:	fed78fa3          	sb	a3,-1(a5)
    80004af4:	fee798e3          	bne	a5,a4,80004ae4 <__memmove+0x160>
    80004af8:	f89ff06f          	j	80004a80 <__memmove+0xfc>

0000000080004afc <__putc>:
    80004afc:	fe010113          	addi	sp,sp,-32
    80004b00:	00813823          	sd	s0,16(sp)
    80004b04:	00113c23          	sd	ra,24(sp)
    80004b08:	02010413          	addi	s0,sp,32
    80004b0c:	00050793          	mv	a5,a0
    80004b10:	fef40593          	addi	a1,s0,-17
    80004b14:	00100613          	li	a2,1
    80004b18:	00000513          	li	a0,0
    80004b1c:	fef407a3          	sb	a5,-17(s0)
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	b3c080e7          	jalr	-1220(ra) # 8000365c <console_write>
    80004b28:	01813083          	ld	ra,24(sp)
    80004b2c:	01013403          	ld	s0,16(sp)
    80004b30:	02010113          	addi	sp,sp,32
    80004b34:	00008067          	ret

0000000080004b38 <__getc>:
    80004b38:	fe010113          	addi	sp,sp,-32
    80004b3c:	00813823          	sd	s0,16(sp)
    80004b40:	00113c23          	sd	ra,24(sp)
    80004b44:	02010413          	addi	s0,sp,32
    80004b48:	fe840593          	addi	a1,s0,-24
    80004b4c:	00100613          	li	a2,1
    80004b50:	00000513          	li	a0,0
    80004b54:	fffff097          	auipc	ra,0xfffff
    80004b58:	ae8080e7          	jalr	-1304(ra) # 8000363c <console_read>
    80004b5c:	fe844503          	lbu	a0,-24(s0)
    80004b60:	01813083          	ld	ra,24(sp)
    80004b64:	01013403          	ld	s0,16(sp)
    80004b68:	02010113          	addi	sp,sp,32
    80004b6c:	00008067          	ret

0000000080004b70 <console_handler>:
    80004b70:	fe010113          	addi	sp,sp,-32
    80004b74:	00813823          	sd	s0,16(sp)
    80004b78:	00113c23          	sd	ra,24(sp)
    80004b7c:	00913423          	sd	s1,8(sp)
    80004b80:	02010413          	addi	s0,sp,32
    80004b84:	14202773          	csrr	a4,scause
    80004b88:	100027f3          	csrr	a5,sstatus
    80004b8c:	0027f793          	andi	a5,a5,2
    80004b90:	06079e63          	bnez	a5,80004c0c <console_handler+0x9c>
    80004b94:	00074c63          	bltz	a4,80004bac <console_handler+0x3c>
    80004b98:	01813083          	ld	ra,24(sp)
    80004b9c:	01013403          	ld	s0,16(sp)
    80004ba0:	00813483          	ld	s1,8(sp)
    80004ba4:	02010113          	addi	sp,sp,32
    80004ba8:	00008067          	ret
    80004bac:	0ff77713          	andi	a4,a4,255
    80004bb0:	00900793          	li	a5,9
    80004bb4:	fef712e3          	bne	a4,a5,80004b98 <console_handler+0x28>
    80004bb8:	ffffe097          	auipc	ra,0xffffe
    80004bbc:	6dc080e7          	jalr	1756(ra) # 80003294 <plic_claim>
    80004bc0:	00a00793          	li	a5,10
    80004bc4:	00050493          	mv	s1,a0
    80004bc8:	02f50c63          	beq	a0,a5,80004c00 <console_handler+0x90>
    80004bcc:	fc0506e3          	beqz	a0,80004b98 <console_handler+0x28>
    80004bd0:	00050593          	mv	a1,a0
    80004bd4:	00000517          	auipc	a0,0x0
    80004bd8:	6a450513          	addi	a0,a0,1700 # 80005278 <_ZZ12printIntegermE6digits+0xe0>
    80004bdc:	fffff097          	auipc	ra,0xfffff
    80004be0:	afc080e7          	jalr	-1284(ra) # 800036d8 <__printf>
    80004be4:	01013403          	ld	s0,16(sp)
    80004be8:	01813083          	ld	ra,24(sp)
    80004bec:	00048513          	mv	a0,s1
    80004bf0:	00813483          	ld	s1,8(sp)
    80004bf4:	02010113          	addi	sp,sp,32
    80004bf8:	ffffe317          	auipc	t1,0xffffe
    80004bfc:	6d430067          	jr	1748(t1) # 800032cc <plic_complete>
    80004c00:	fffff097          	auipc	ra,0xfffff
    80004c04:	3e0080e7          	jalr	992(ra) # 80003fe0 <uartintr>
    80004c08:	fddff06f          	j	80004be4 <console_handler+0x74>
    80004c0c:	00000517          	auipc	a0,0x0
    80004c10:	76c50513          	addi	a0,a0,1900 # 80005378 <digits+0x78>
    80004c14:	fffff097          	auipc	ra,0xfffff
    80004c18:	a68080e7          	jalr	-1432(ra) # 8000367c <panic>
	...
