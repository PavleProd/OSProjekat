
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	90813103          	ld	sp,-1784(sp) # 80008908 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	735030ef          	jal	ra,80003f50 <start>

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
    8000100c:	4c5000ef          	jal	ra,80001cd0 <_ZN3PCB10getContextEv>
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
    8000109c:	48c000ef          	jal	ra,80001528 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	431000ef          	jal	ra,80001cd0 <_ZN3PCB10getContextEv>

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

0000000080001150 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001150:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001154:	00b29a63          	bne	t0,a1,80001168 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001158:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000115c:	fe029ae3          	bnez	t0,80001150 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001160:	00000513          	li	a0,0
    jr ra                  # Return.
    80001164:	00008067          	ret

0000000080001168 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001168:	00100513          	li	a0,1
    8000116c:	00008067          	ret

0000000080001170 <_Z13callInterruptm>:
#include "../h/kernel.h"
#include "../h/PCB.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt(size_t volatile code) {
    80001170:	fe010113          	addi	sp,sp,-32
    80001174:	00813c23          	sd	s0,24(sp)
    80001178:	02010413          	addi	s0,sp,32
    8000117c:	fea43423          	sd	a0,-24(s0)
    void* res;
    asm volatile("ecall");
    80001180:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001184:	00050513          	mv	a0,a0
    return res;
}
    80001188:	01813403          	ld	s0,24(sp)
    8000118c:	02010113          	addi	sp,sp,32
    80001190:	00008067          	ret

0000000080001194 <_Z9mem_allocm>:

// a0 code a1 size
void* mem_alloc(size_t size) {
    80001194:	ff010113          	addi	sp,sp,-16
    80001198:	00113423          	sd	ra,8(sp)
    8000119c:	00813023          	sd	s0,0(sp)
    800011a0:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800011a4:	00655793          	srli	a5,a0,0x6
    800011a8:	03f57513          	andi	a0,a0,63
    800011ac:	00a03533          	snez	a0,a0
    800011b0:	00a78533          	add	a0,a5,a0
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800011b4:	00050593          	mv	a1,a0

    return (void*)callInterrupt(code);
    800011b8:	00100513          	li	a0,1
    800011bc:	00000097          	auipc	ra,0x0
    800011c0:	fb4080e7          	jalr	-76(ra) # 80001170 <_Z13callInterruptm>
}
    800011c4:	00813083          	ld	ra,8(sp)
    800011c8:	00013403          	ld	s0,0(sp)
    800011cc:	01010113          	addi	sp,sp,16
    800011d0:	00008067          	ret

00000000800011d4 <_Z8mem_freePv>:

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    800011d4:	ff010113          	addi	sp,sp,-16
    800011d8:	00113423          	sd	ra,8(sp)
    800011dc:	00813023          	sd	s0,0(sp)
    800011e0:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    800011e4:	00050593          	mv	a1,a0

    return (size_t)(callInterrupt(code));
    800011e8:	00200513          	li	a0,2
    800011ec:	00000097          	auipc	ra,0x0
    800011f0:	f84080e7          	jalr	-124(ra) # 80001170 <_Z13callInterruptm>
}
    800011f4:	0005051b          	sext.w	a0,a0
    800011f8:	00813083          	ld	ra,8(sp)
    800011fc:	00013403          	ld	s0,0(sp)
    80001200:	01010113          	addi	sp,sp,16
    80001204:	00008067          	ret

0000000080001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace, a5 - deleteArgFlag
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    80001208:	ff010113          	addi	sp,sp,-16
    8000120c:	00113423          	sd	ra,8(sp)
    80001210:	00813023          	sd	s0,0(sp)
    80001214:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    80001218:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    8000121c:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a4 = handle privremeno cuvamo da bismo posle vratili u a1
    80001220:	00050713          	mv	a4,a0


    size_t* stack = (size_t*)mem_alloc(sizeof(size_t)*DEFAULT_STACK_SIZE); // pravimo stack procesa
    80001224:	00008537          	lui	a0,0x8
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	f6c080e7          	jalr	-148(ra) # 80001194 <_Z9mem_allocm>
    if(stack == nullptr) return -1;
    80001230:	02050a63          	beqz	a0,80001264 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x5c>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    80001234:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001238:	00050713          	mv	a4,a0

    handle = (thread_t*)(callInterrupt(code)); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    8000123c:	01100513          	li	a0,17
    80001240:	00000097          	auipc	ra,0x0
    80001244:	f30080e7          	jalr	-208(ra) # 80001170 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001248:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    8000124c:	02078063          	beqz	a5,8000126c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x64>
        return -1;
    }
    return 0;
    80001250:	00000513          	li	a0,0
}
    80001254:	00813083          	ld	ra,8(sp)
    80001258:	00013403          	ld	s0,0(sp)
    8000125c:	01010113          	addi	sp,sp,16
    80001260:	00008067          	ret
    if(stack == nullptr) return -1;
    80001264:	fff00513          	li	a0,-1
    80001268:	fedff06f          	j	80001254 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>
        return -1;
    8000126c:	fff00513          	li	a0,-1
    80001270:	fe5ff06f          	j	80001254 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>

0000000080001274 <_Z15thread_dispatchv>:
    int res = thread_create_only(handle, startRoutine, arg);
    thread_start(handle);
    return res;
}

void thread_dispatch () {
    80001274:	ff010113          	addi	sp,sp,-16
    80001278:	00113423          	sd	ra,8(sp)
    8000127c:	00813023          	sd	s0,0(sp)
    80001280:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    callInterrupt(code);
    80001284:	01300513          	li	a0,19
    80001288:	00000097          	auipc	ra,0x0
    8000128c:	ee8080e7          	jalr	-280(ra) # 80001170 <_Z13callInterruptm>
}
    80001290:	00813083          	ld	ra,8(sp)
    80001294:	00013403          	ld	s0,0(sp)
    80001298:	01010113          	addi	sp,sp,16
    8000129c:	00008067          	ret

00000000800012a0 <_Z11thread_exitv>:

int thread_exit () {
    800012a0:	ff010113          	addi	sp,sp,-16
    800012a4:	00113423          	sd	ra,8(sp)
    800012a8:	00813023          	sd	s0,0(sp)
    800012ac:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_exit;
    return (size_t)(callInterrupt(code));
    800012b0:	01200513          	li	a0,18
    800012b4:	00000097          	auipc	ra,0x0
    800012b8:	ebc080e7          	jalr	-324(ra) # 80001170 <_Z13callInterruptm>
}
    800012bc:	0005051b          	sext.w	a0,a0
    800012c0:	00813083          	ld	ra,8(sp)
    800012c4:	00013403          	ld	s0,0(sp)
    800012c8:	01010113          	addi	sp,sp,16
    800012cc:	00008067          	ret

00000000800012d0 <_Z12thread_startPP3PCB>:

void thread_start(thread_t* handle) {
    800012d0:	ff010113          	addi	sp,sp,-16
    800012d4:	00113423          	sd	ra,8(sp)
    800012d8:	00813023          	sd	s0,0(sp)
    800012dc:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a1, a0"); // a1 = handle
    800012e0:	00050593          	mv	a1,a0
    callInterrupt(code);
    800012e4:	01400513          	li	a0,20
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	e88080e7          	jalr	-376(ra) # 80001170 <_Z13callInterruptm>
}
    800012f0:	00813083          	ld	ra,8(sp)
    800012f4:	00013403          	ld	s0,0(sp)
    800012f8:	01010113          	addi	sp,sp,16
    800012fc:	00008067          	ret

0000000080001300 <_Z13thread_createPP3PCBPFvPvES2_>:
int thread_create(thread_t* handle, void(*startRoutine)(void*), void* arg) {
    80001300:	fe010113          	addi	sp,sp,-32
    80001304:	00113c23          	sd	ra,24(sp)
    80001308:	00813823          	sd	s0,16(sp)
    8000130c:	00913423          	sd	s1,8(sp)
    80001310:	01213023          	sd	s2,0(sp)
    80001314:	02010413          	addi	s0,sp,32
    80001318:	00050913          	mv	s2,a0
    int res = thread_create_only(handle, startRoutine, arg);
    8000131c:	00000097          	auipc	ra,0x0
    80001320:	eec080e7          	jalr	-276(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    80001324:	00050493          	mv	s1,a0
    thread_start(handle);
    80001328:	00090513          	mv	a0,s2
    8000132c:	00000097          	auipc	ra,0x0
    80001330:	fa4080e7          	jalr	-92(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80001334:	00048513          	mv	a0,s1
    80001338:	01813083          	ld	ra,24(sp)
    8000133c:	01013403          	ld	s0,16(sp)
    80001340:	00813483          	ld	s1,8(sp)
    80001344:	00013903          	ld	s2,0(sp)
    80001348:	02010113          	addi	sp,sp,32
    8000134c:	00008067          	ret

0000000080001350 <_Z8sem_openPP3SCBj>:

int sem_open (sem_t* handle, unsigned init) {
    80001350:	ff010113          	addi	sp,sp,-16
    80001354:	00113423          	sd	ra,8(sp)
    80001358:	00813023          	sd	s0,0(sp)
    8000135c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::sem_open;

    asm volatile("mv a2, a1"); // a2 = init
    80001360:	00058613          	mv	a2,a1
    asm volatile("mv a1, a0"); // a1 = handle
    80001364:	00050593          	mv	a1,a0

    handle = (sem_t*)callInterrupt(code);
    80001368:	02100513          	li	a0,33
    8000136c:	00000097          	auipc	ra,0x0
    80001370:	e04080e7          	jalr	-508(ra) # 80001170 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001374:	00053783          	ld	a5,0(a0)
    80001378:	00078c63          	beqz	a5,80001390 <_Z8sem_openPP3SCBj+0x40>
        return -1;
    }

    return 0;
    8000137c:	00000513          	li	a0,0
}
    80001380:	00813083          	ld	ra,8(sp)
    80001384:	00013403          	ld	s0,0(sp)
    80001388:	01010113          	addi	sp,sp,16
    8000138c:	00008067          	ret
        return -1;
    80001390:	fff00513          	li	a0,-1
    80001394:	fedff06f          	j	80001380 <_Z8sem_openPP3SCBj+0x30>

0000000080001398 <_Z8sem_waitP3SCB>:

int sem_wait (sem_t volatile handle) {
    80001398:	fe010113          	addi	sp,sp,-32
    8000139c:	00113c23          	sd	ra,24(sp)
    800013a0:	00813823          	sd	s0,16(sp)
    800013a4:	02010413          	addi	s0,sp,32
    800013a8:	fea43423          	sd	a0,-24(s0)
    size_t code = Kernel::sysCallCodes::sem_wait;
    if(handle == nullptr) return -1;
    800013ac:	fe843783          	ld	a5,-24(s0)
    800013b0:	02078463          	beqz	a5,800013d8 <_Z8sem_waitP3SCB+0x40>
    asm volatile("mv a1, a0");
    800013b4:	00050593          	mv	a1,a0

    return (int)(size_t)callInterrupt(code);
    800013b8:	02300513          	li	a0,35
    800013bc:	00000097          	auipc	ra,0x0
    800013c0:	db4080e7          	jalr	-588(ra) # 80001170 <_Z13callInterruptm>
    800013c4:	0005051b          	sext.w	a0,a0
}
    800013c8:	01813083          	ld	ra,24(sp)
    800013cc:	01013403          	ld	s0,16(sp)
    800013d0:	02010113          	addi	sp,sp,32
    800013d4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013d8:	fff00513          	li	a0,-1
    800013dc:	fedff06f          	j	800013c8 <_Z8sem_waitP3SCB+0x30>

00000000800013e0 <_Z10sem_signalP3SCB>:

int sem_signal (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(handle == nullptr) return -1;
    800013e0:	02050c63          	beqz	a0,80001418 <_Z10sem_signalP3SCB+0x38>
int sem_signal (sem_t handle) {
    800013e4:	ff010113          	addi	sp,sp,-16
    800013e8:	00113423          	sd	ra,8(sp)
    800013ec:	00813023          	sd	s0,0(sp)
    800013f0:	01010413          	addi	s0,sp,16
    asm volatile("mv a1, a0");
    800013f4:	00050593          	mv	a1,a0

    callInterrupt(code);
    800013f8:	02400513          	li	a0,36
    800013fc:	00000097          	auipc	ra,0x0
    80001400:	d74080e7          	jalr	-652(ra) # 80001170 <_Z13callInterruptm>

    return 0;
    80001404:	00000513          	li	a0,0
}
    80001408:	00813083          	ld	ra,8(sp)
    8000140c:	00013403          	ld	s0,0(sp)
    80001410:	01010113          	addi	sp,sp,16
    80001414:	00008067          	ret
    if(handle == nullptr) return -1;
    80001418:	fff00513          	li	a0,-1
}
    8000141c:	00008067          	ret

0000000080001420 <_Z9sem_closeP3SCB>:

int sem_close (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_close;
    if(handle == nullptr) return -1;
    80001420:	02050c63          	beqz	a0,80001458 <_Z9sem_closeP3SCB+0x38>
int sem_close (sem_t handle) {
    80001424:	ff010113          	addi	sp,sp,-16
    80001428:	00113423          	sd	ra,8(sp)
    8000142c:	00813023          	sd	s0,0(sp)
    80001430:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001434:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001438:	02200513          	li	a0,34
    8000143c:	00000097          	auipc	ra,0x0
    80001440:	d34080e7          	jalr	-716(ra) # 80001170 <_Z13callInterruptm>
    return 0;
    80001444:	00000513          	li	a0,0
}
    80001448:	00813083          	ld	ra,8(sp)
    8000144c:	00013403          	ld	s0,0(sp)
    80001450:	01010113          	addi	sp,sp,16
    80001454:	00008067          	ret
    if(handle == nullptr) return -1;
    80001458:	fff00513          	li	a0,-1
}
    8000145c:	00008067          	ret

0000000080001460 <_Z10time_sleepm>:

int time_sleep (time_t time) {
    size_t code = Kernel::sysCallCodes::time_sleep;
    if(time <= 0) return -1;
    80001460:	04050063          	beqz	a0,800014a0 <_Z10time_sleepm+0x40>
int time_sleep (time_t time) {
    80001464:	ff010113          	addi	sp,sp,-16
    80001468:	00113423          	sd	ra,8(sp)
    8000146c:	00813023          	sd	s0,0(sp)
    80001470:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001474:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001478:	03100513          	li	a0,49
    8000147c:	00000097          	auipc	ra,0x0
    80001480:	cf4080e7          	jalr	-780(ra) # 80001170 <_Z13callInterruptm>

    thread_dispatch(); // radimo odmah dispatch da bi zaustavili tekuci proces
    80001484:	00000097          	auipc	ra,0x0
    80001488:	df0080e7          	jalr	-528(ra) # 80001274 <_Z15thread_dispatchv>

    return 0;
    8000148c:	00000513          	li	a0,0
}
    80001490:	00813083          	ld	ra,8(sp)
    80001494:	00013403          	ld	s0,0(sp)
    80001498:	01010113          	addi	sp,sp,16
    8000149c:	00008067          	ret
    if(time <= 0) return -1;
    800014a0:	fff00513          	li	a0,-1
}
    800014a4:	00008067          	ret

00000000800014a8 <_Z4getcv>:

char getc () {
    800014a8:	ff010113          	addi	sp,sp,-16
    800014ac:	00113423          	sd	ra,8(sp)
    800014b0:	00813023          	sd	s0,0(sp)
    800014b4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::getc;
    return (char)(size_t)callInterrupt(code);
    800014b8:	04100513          	li	a0,65
    800014bc:	00000097          	auipc	ra,0x0
    800014c0:	cb4080e7          	jalr	-844(ra) # 80001170 <_Z13callInterruptm>
}
    800014c4:	0ff57513          	andi	a0,a0,255
    800014c8:	00813083          	ld	ra,8(sp)
    800014cc:	00013403          	ld	s0,0(sp)
    800014d0:	01010113          	addi	sp,sp,16
    800014d4:	00008067          	ret

00000000800014d8 <_Z4putcc>:

void putc(char c) {
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00113423          	sd	ra,8(sp)
    800014e0:	00813023          	sd	s0,0(sp)
    800014e4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::putc;
    asm volatile("mv a1, a0"); // a1 = c
    800014e8:	00050593          	mv	a1,a0
    callInterrupt(code);
    800014ec:	04200513          	li	a0,66
    800014f0:	00000097          	auipc	ra,0x0
    800014f4:	c80080e7          	jalr	-896(ra) # 80001170 <_Z13callInterruptm>
}
    800014f8:	00813083          	ld	ra,8(sp)
    800014fc:	00013403          	ld	s0,0(sp)
    80001500:	01010113          	addi	sp,sp,16
    80001504:	00008067          	ret

0000000080001508 <_ZN6Kernel10popSppSpieEv>:
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"
#include "../h/CCB.h"
#include "../h/syscall_c.h"
void Kernel::popSppSpie() {
    80001508:	ff010113          	addi	sp,sp,-16
    8000150c:	00813423          	sd	s0,8(sp)
    80001510:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001514:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001518:	10200073          	sret
}
    8000151c:	00813403          	ld	s0,8(sp)
    80001520:	01010113          	addi	sp,sp,16
    80001524:	00008067          	ret

0000000080001528 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001528:	fa010113          	addi	sp,sp,-96
    8000152c:	04113c23          	sd	ra,88(sp)
    80001530:	04813823          	sd	s0,80(sp)
    80001534:	04913423          	sd	s1,72(sp)
    80001538:	05213023          	sd	s2,64(sp)
    8000153c:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001540:	142027f3          	csrr	a5,scause
    80001544:	fcf43023          	sd	a5,-64(s0)
        return scause;
    80001548:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    8000154c:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001550:	141027f3          	csrr	a5,sepc
    80001554:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    80001558:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    8000155c:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001560:	100027f3          	csrr	a5,sstatus
    80001564:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    80001568:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    8000156c:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001570:	fd843703          	ld	a4,-40(s0)
    80001574:	00900793          	li	a5,9
    80001578:	04f70863          	beq	a4,a5,800015c8 <interruptHandler+0xa0>
    8000157c:	fd843703          	ld	a4,-40(s0)
    80001580:	00800793          	li	a5,8
    80001584:	04f70263          	beq	a4,a5,800015c8 <interruptHandler+0xa0>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    80001588:	fd843703          	ld	a4,-40(s0)
    8000158c:	fff00793          	li	a5,-1
    80001590:	03f79793          	slli	a5,a5,0x3f
    80001594:	00178793          	addi	a5,a5,1
    80001598:	2cf70e63          	beq	a4,a5,80001874 <interruptHandler+0x34c>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    8000159c:	fd843703          	ld	a4,-40(s0)
    800015a0:	fff00793          	li	a5,-1
    800015a4:	03f79793          	slli	a5,a5,0x3f
    800015a8:	00978793          	addi	a5,a5,9
    800015ac:	32f70463          	beq	a4,a5,800018d4 <interruptHandler+0x3ac>

    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
    }

}
    800015b0:	05813083          	ld	ra,88(sp)
    800015b4:	05013403          	ld	s0,80(sp)
    800015b8:	04813483          	ld	s1,72(sp)
    800015bc:	04013903          	ld	s2,64(sp)
    800015c0:	06010113          	addi	sp,sp,96
    800015c4:	00008067          	ret
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015c8:	fd043783          	ld	a5,-48(s0)
    800015cc:	00478793          	addi	a5,a5,4
    800015d0:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015d4:	00007797          	auipc	a5,0x7
    800015d8:	34c7b783          	ld	a5,844(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015dc:	0007b503          	ld	a0,0(a5)
    800015e0:	01853703          	ld	a4,24(a0)
    800015e4:	05073783          	ld	a5,80(a4)
    800015e8:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015ec:	fa843783          	ld	a5,-88(s0)
    800015f0:	04300693          	li	a3,67
    800015f4:	04f6e263          	bltu	a3,a5,80001638 <interruptHandler+0x110>
    800015f8:	00279793          	slli	a5,a5,0x2
    800015fc:	00006697          	auipc	a3,0x6
    80001600:	a2468693          	addi	a3,a3,-1500 # 80007020 <CONSOLE_STATUS+0x10>
    80001604:	00d787b3          	add	a5,a5,a3
    80001608:	0007a783          	lw	a5,0(a5)
    8000160c:	00d787b3          	add	a5,a5,a3
    80001610:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001614:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001618:	00651513          	slli	a0,a0,0x6
    8000161c:	00001097          	auipc	ra,0x1
    80001620:	4ac080e7          	jalr	1196(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
    80001624:	00007797          	auipc	a5,0x7
    80001628:	2fc7b783          	ld	a5,764(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000162c:	0007b783          	ld	a5,0(a5)
    80001630:	0187b783          	ld	a5,24(a5)
    80001634:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001638:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000163c:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001640:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001644:	10079073          	csrw	sstatus,a5
        return;
    80001648:	f69ff06f          	j	800015b0 <interruptHandler+0x88>
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    8000164c:	05873503          	ld	a0,88(a4)
    80001650:	00001097          	auipc	ra,0x1
    80001654:	5dc080e7          	jalr	1500(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
    80001658:	00007797          	auipc	a5,0x7
    8000165c:	2c87b783          	ld	a5,712(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001660:	0007b783          	ld	a5,0(a5)
    80001664:	0187b783          	ld	a5,24(a5)
    80001668:	04a7b823          	sd	a0,80(a5)
                break;
    8000166c:	fcdff06f          	j	80001638 <interruptHandler+0x110>
                PCB::timeSliceCounter = 0;
    80001670:	00007797          	auipc	a5,0x7
    80001674:	2907b783          	ld	a5,656(a5) # 80008900 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001678:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	3f4080e7          	jalr	1012(ra) # 80001a70 <_ZN3PCB8dispatchEv>
                break;
    80001684:	fb5ff06f          	j	80001638 <interruptHandler+0x110>
                PCB::running->finished = true;
    80001688:	00100793          	li	a5,1
    8000168c:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001690:	00007797          	auipc	a5,0x7
    80001694:	2707b783          	ld	a5,624(a5) # 80008900 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001698:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000169c:	00000097          	auipc	ra,0x0
    800016a0:	3d4080e7          	jalr	980(ra) # 80001a70 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016a4:	00007797          	auipc	a5,0x7
    800016a8:	27c7b783          	ld	a5,636(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016ac:	0007b783          	ld	a5,0(a5)
    800016b0:	0187b783          	ld	a5,24(a5)
    800016b4:	0407b823          	sd	zero,80(a5)
                break;
    800016b8:	f81ff06f          	j	80001638 <interruptHandler+0x110>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800016bc:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800016c0:	0007b503          	ld	a0,0(a5)
    800016c4:	00001097          	auipc	ra,0x1
    800016c8:	864080e7          	jalr	-1948(ra) # 80001f28 <_ZN9Scheduler3putEP3PCB>
                break;
    800016cc:	f6dff06f          	j	80001638 <interruptHandler+0x110>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d0:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016d4:	06873583          	ld	a1,104(a4)
    800016d8:	06073503          	ld	a0,96(a4)
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	56c080e7          	jalr	1388(ra) # 80001c48 <_ZN3PCB14createProccessEPFvvEPv>
    800016e4:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016e8:	00007797          	auipc	a5,0x7
    800016ec:	2387b783          	ld	a5,568(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016f0:	0007b783          	ld	a5,0(a5)
    800016f4:	0187b703          	ld	a4,24(a5)
    800016f8:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    800016fc:	0004b703          	ld	a4,0(s1)
    80001700:	f2070ce3          	beqz	a4,80001638 <interruptHandler+0x110>
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001704:	0187b783          	ld	a5,24(a5)
    80001708:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    8000170c:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001710:	00008737          	lui	a4,0x8
    80001714:	00e787b3          	add	a5,a5,a4
    80001718:	0004b703          	ld	a4,0(s1)
    8000171c:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001720:	00f73823          	sd	a5,16(a4)
                break;
    80001724:	f15ff06f          	j	80001638 <interruptHandler+0x110>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001728:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    8000172c:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    80001730:	01800513          	li	a0,24
    80001734:	00001097          	auipc	ra,0x1
    80001738:	2e0080e7          	jalr	736(ra) # 80002a14 <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    8000173c:	00053023          	sd	zero,0(a0)
    80001740:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80001744:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001748:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    8000174c:	00007797          	auipc	a5,0x7
    80001750:	1d47b783          	ld	a5,468(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001754:	0007b783          	ld	a5,0(a5)
    80001758:	0187b783          	ld	a5,24(a5)
    8000175c:	0497b823          	sd	s1,80(a5)
                break;
    80001760:	ed9ff06f          	j	80001638 <interruptHandler+0x110>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001764:	05873503          	ld	a0,88(a4)
    80001768:	00001097          	auipc	ra,0x1
    8000176c:	188080e7          	jalr	392(ra) # 800028f0 <_ZN3SCB4waitEv>
    80001770:	00007797          	auipc	a5,0x7
    80001774:	1b07b783          	ld	a5,432(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001778:	0007b783          	ld	a5,0(a5)
    8000177c:	0187b783          	ld	a5,24(a5)
    80001780:	04a7b823          	sd	a0,80(a5)
                break;
    80001784:	eb5ff06f          	j	80001638 <interruptHandler+0x110>
                sem->signal();
    80001788:	05873503          	ld	a0,88(a4)
    8000178c:	00001097          	auipc	ra,0x1
    80001790:	1f8080e7          	jalr	504(ra) # 80002984 <_ZN3SCB6signalEv>
                break;
    80001794:	ea5ff06f          	j	80001638 <interruptHandler+0x110>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001798:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000179c:	00048513          	mv	a0,s1
    800017a0:	00001097          	auipc	ra,0x1
    800017a4:	2c4080e7          	jalr	708(ra) # 80002a64 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017a8:	e80488e3          	beqz	s1,80001638 <interruptHandler+0x110>
    800017ac:	00048513          	mv	a0,s1
    800017b0:	00001097          	auipc	ra,0x1
    800017b4:	28c080e7          	jalr	652(ra) # 80002a3c <_ZN3SCBdlEPv>
    800017b8:	e81ff06f          	j	80001638 <interruptHandler+0x110>
                size_t time = (size_t)PCB::running->registers[11];
    800017bc:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017c0:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017c4:	00000097          	auipc	ra,0x0
    800017c8:	124080e7          	jalr	292(ra) # 800018e8 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017cc:	e6dff06f          	j	80001638 <interruptHandler+0x110>
                CCB::outputBuffer.pushBack(character);
    800017d0:	05874583          	lbu	a1,88(a4)
    800017d4:	00007517          	auipc	a0,0x7
    800017d8:	11453503          	ld	a0,276(a0) # 800088e8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	518080e7          	jalr	1304(ra) # 80001cf4 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    800017e4:	00007797          	auipc	a5,0x7
    800017e8:	14c7b783          	ld	a5,332(a5) # 80008930 <_GLOBAL_OFFSET_TABLE_+0x70>
    800017ec:	0007b503          	ld	a0,0(a5)
    800017f0:	00001097          	auipc	ra,0x1
    800017f4:	194080e7          	jalr	404(ra) # 80002984 <_ZN3SCB6signalEv>
                break;
    800017f8:	e41ff06f          	j	80001638 <interruptHandler+0x110>
                CCB::semInput->signal();
    800017fc:	00007797          	auipc	a5,0x7
    80001800:	14c7b783          	ld	a5,332(a5) # 80008948 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001804:	0007b503          	ld	a0,0(a5)
    80001808:	00001097          	auipc	ra,0x1
    8000180c:	17c080e7          	jalr	380(ra) # 80002984 <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001810:	00007517          	auipc	a0,0x7
    80001814:	0e053503          	ld	a0,224(a0) # 800088f0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	664080e7          	jalr	1636(ra) # 80001e7c <_ZN8IOBuffer9peekFrontEv>
    80001820:	00051e63          	bnez	a0,8000183c <interruptHandler+0x314>
                    CCB::inputBufferEmpty->wait();
    80001824:	00007797          	auipc	a5,0x7
    80001828:	1147b783          	ld	a5,276(a5) # 80008938 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000182c:	0007b503          	ld	a0,0(a5)
    80001830:	00001097          	auipc	ra,0x1
    80001834:	0c0080e7          	jalr	192(ra) # 800028f0 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001838:	fd9ff06f          	j	80001810 <interruptHandler+0x2e8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000183c:	00007517          	auipc	a0,0x7
    80001840:	0b453503          	ld	a0,180(a0) # 800088f0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001844:	00000097          	auipc	ra,0x0
    80001848:	5a8080e7          	jalr	1448(ra) # 80001dec <_ZN8IOBuffer8popFrontEv>
    8000184c:	00007797          	auipc	a5,0x7
    80001850:	0d47b783          	ld	a5,212(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001854:	0007b783          	ld	a5,0(a5)
    80001858:	0187b783          	ld	a5,24(a5)
    8000185c:	04a7b823          	sd	a0,80(a5)
                break;
    80001860:	dd9ff06f          	j	80001638 <interruptHandler+0x110>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    80001864:	fc843783          	ld	a5,-56(s0)
    80001868:	eff7f793          	andi	a5,a5,-257
    8000186c:	fcf43423          	sd	a5,-56(s0)
                break;
    80001870:	dc9ff06f          	j	80001638 <interruptHandler+0x110>
        PCB::timeSliceCounter++;
    80001874:	00007497          	auipc	s1,0x7
    80001878:	08c4b483          	ld	s1,140(s1) # 80008900 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000187c:	0004b783          	ld	a5,0(s1)
    80001880:	00178793          	addi	a5,a5,1
    80001884:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	0f0080e7          	jalr	240(ra) # 80001978 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001890:	00007797          	auipc	a5,0x7
    80001894:	0907b783          	ld	a5,144(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001898:	0007b783          	ld	a5,0(a5)
    8000189c:	0407b703          	ld	a4,64(a5)
    800018a0:	0004b783          	ld	a5,0(s1)
    800018a4:	00e7f863          	bgeu	a5,a4,800018b4 <interruptHandler+0x38c>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018a8:	00200793          	li	a5,2
    800018ac:	1447b073          	csrc	sip,a5
    }
    800018b0:	d01ff06f          	j	800015b0 <interruptHandler+0x88>
            PCB::timeSliceCounter = 0;
    800018b4:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800018b8:	00000097          	auipc	ra,0x0
    800018bc:	1b8080e7          	jalr	440(ra) # 80001a70 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018c0:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018c4:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018c8:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018cc:	10079073          	csrw	sstatus,a5
    }
    800018d0:	fd9ff06f          	j	800018a8 <interruptHandler+0x380>
        size_t code = plic_claim();
    800018d4:	00003097          	auipc	ra,0x3
    800018d8:	ed0080e7          	jalr	-304(ra) # 800047a4 <plic_claim>
        plic_complete(code);
    800018dc:	00003097          	auipc	ra,0x3
    800018e0:	f00080e7          	jalr	-256(ra) # 800047dc <plic_complete>
    800018e4:	ccdff06f          	j	800015b0 <interruptHandler+0x88>

00000000800018e8 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    800018e8:	ff010113          	addi	sp,sp,-16
    800018ec:	00813423          	sd	s0,8(sp)
    800018f0:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    800018f4:	00007797          	auipc	a5,0x7
    800018f8:	0ac7b783          	ld	a5,172(a5) # 800089a0 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    800018fc:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001900:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001904:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001908:	00078e63          	beqz	a5,80001924 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    8000190c:	0307b683          	ld	a3,48(a5)
    80001910:	00e6fa63          	bgeu	a3,a4,80001924 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001914:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001918:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    8000191c:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001920:	fe9ff06f          	j	80001908 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001924:	00100693          	li	a3,1
    80001928:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    8000192c:	02060663          	beqz	a2,80001958 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    80001930:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001934:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001938:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    8000193c:	00078863          	beqz	a5,8000194c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001940:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001944:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001948:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    8000194c:	00813403          	ld	s0,8(sp)
    80001950:	01010113          	addi	sp,sp,16
    80001954:	00008067          	ret
        head = process;
    80001958:	00007717          	auipc	a4,0x7
    8000195c:	04a73423          	sd	a0,72(a4) # 800089a0 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    80001960:	00f53023          	sd	a5,0(a0)
        if(curr) {
    80001964:	fe0784e3          	beqz	a5,8000194c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001968:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    8000196c:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    80001970:	02b7b823          	sd	a1,48(a5)
    }
    80001974:	fd9ff06f          	j	8000194c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

0000000080001978 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    80001978:	00007517          	auipc	a0,0x7
    8000197c:	02853503          	ld	a0,40(a0) # 800089a0 <_ZN17SleepingProcesses4headE>
    80001980:	08050063          	beqz	a0,80001a00 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    80001984:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    80001988:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    8000198c:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    80001990:	06050263          	beqz	a0,800019f4 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    80001994:	03053783          	ld	a5,48(a0)
    80001998:	04079e63          	bnez	a5,800019f4 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    8000199c:	fe010113          	addi	sp,sp,-32
    800019a0:	00113c23          	sd	ra,24(sp)
    800019a4:	00813823          	sd	s0,16(sp)
    800019a8:	00913423          	sd	s1,8(sp)
    800019ac:	02010413          	addi	s0,sp,32
    800019b0:	00c0006f          	j	800019bc <_ZN17SleepingProcesses6wakeUpEv+0x44>
    800019b4:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800019b8:	02079063          	bnez	a5,800019d8 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800019bc:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800019c0:	00053023          	sd	zero,0(a0)
        blocked = newState;
    800019c4:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    800019c8:	00000097          	auipc	ra,0x0
    800019cc:	560080e7          	jalr	1376(ra) # 80001f28 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019d0:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019d4:	fe0490e3          	bnez	s1,800019b4 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019d8:	00007797          	auipc	a5,0x7
    800019dc:	fca7b423          	sd	a0,-56(a5) # 800089a0 <_ZN17SleepingProcesses4headE>
}
    800019e0:	01813083          	ld	ra,24(sp)
    800019e4:	01013403          	ld	s0,16(sp)
    800019e8:	00813483          	ld	s1,8(sp)
    800019ec:	02010113          	addi	sp,sp,32
    800019f0:	00008067          	ret
    head = curr;
    800019f4:	00007797          	auipc	a5,0x7
    800019f8:	faa7b623          	sd	a0,-84(a5) # 800089a0 <_ZN17SleepingProcesses4headE>
    800019fc:	00008067          	ret
    80001a00:	00008067          	ret

0000000080001a04 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a04:	ff010113          	addi	sp,sp,-16
    80001a08:	00113423          	sd	ra,8(sp)
    80001a0c:	00813023          	sd	s0,0(sp)
    80001a10:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a14:	00000097          	auipc	ra,0x0
    80001a18:	af4080e7          	jalr	-1292(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a1c:	00007797          	auipc	a5,0x7
    80001a20:	f8c7b783          	ld	a5,-116(a5) # 800089a8 <_ZN3PCB7runningE>
    80001a24:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a28:	00070513          	mv	a0,a4
    running->main();
    80001a2c:	0207b783          	ld	a5,32(a5)
    80001a30:	000780e7          	jalr	a5
    thread_exit();
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	86c080e7          	jalr	-1940(ra) # 800012a0 <_Z11thread_exitv>
}
    80001a3c:	00813083          	ld	ra,8(sp)
    80001a40:	00013403          	ld	s0,0(sp)
    80001a44:	01010113          	addi	sp,sp,16
    80001a48:	00008067          	ret

0000000080001a4c <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001a4c:	ff010113          	addi	sp,sp,-16
    80001a50:	00813423          	sd	s0,8(sp)
    80001a54:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001a58:	01300793          	li	a5,19
    80001a5c:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001a60:	00000073          	ecall
}
    80001a64:	00813403          	ld	s0,8(sp)
    80001a68:	01010113          	addi	sp,sp,16
    80001a6c:	00008067          	ret

0000000080001a70 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001a70:	fe010113          	addi	sp,sp,-32
    80001a74:	00113c23          	sd	ra,24(sp)
    80001a78:	00813823          	sd	s0,16(sp)
    80001a7c:	00913423          	sd	s1,8(sp)
    80001a80:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001a84:	00007497          	auipc	s1,0x7
    80001a88:	f244b483          	ld	s1,-220(s1) # 800089a8 <_ZN3PCB7runningE>
        return finished;
    80001a8c:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001a90:	00079663          	bnez	a5,80001a9c <_ZN3PCB8dispatchEv+0x2c>
    80001a94:	0294c783          	lbu	a5,41(s1)
    80001a98:	04078263          	beqz	a5,80001adc <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001a9c:	00000097          	auipc	ra,0x0
    80001aa0:	4e4080e7          	jalr	1252(ra) # 80001f80 <_ZN9Scheduler3getEv>
    80001aa4:	00007797          	auipc	a5,0x7
    80001aa8:	f0a7b223          	sd	a0,-252(a5) # 800089a8 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001aac:	04854783          	lbu	a5,72(a0)
    80001ab0:	02078e63          	beqz	a5,80001aec <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001ab4:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001ab8:	01853583          	ld	a1,24(a0)
    80001abc:	0184b503          	ld	a0,24(s1)
    80001ac0:	fffff097          	auipc	ra,0xfffff
    80001ac4:	668080e7          	jalr	1640(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001ac8:	01813083          	ld	ra,24(sp)
    80001acc:	01013403          	ld	s0,16(sp)
    80001ad0:	00813483          	ld	s1,8(sp)
    80001ad4:	02010113          	addi	sp,sp,32
    80001ad8:	00008067          	ret
        Scheduler::put(old);
    80001adc:	00048513          	mv	a0,s1
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	448080e7          	jalr	1096(ra) # 80001f28 <_ZN9Scheduler3putEP3PCB>
    80001ae8:	fb5ff06f          	j	80001a9c <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001aec:	01853583          	ld	a1,24(a0)
    80001af0:	0184b503          	ld	a0,24(s1)
    80001af4:	fffff097          	auipc	ra,0xfffff
    80001af8:	648080e7          	jalr	1608(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001afc:	fcdff06f          	j	80001ac8 <_ZN3PCB8dispatchEv+0x58>

0000000080001b00 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001b00:	fe010113          	addi	sp,sp,-32
    80001b04:	00113c23          	sd	ra,24(sp)
    80001b08:	00813823          	sd	s0,16(sp)
    80001b0c:	00913423          	sd	s1,8(sp)
    80001b10:	02010413          	addi	s0,sp,32
    80001b14:	00050493          	mv	s1,a0
    80001b18:	00053023          	sd	zero,0(a0)
    80001b1c:	00053c23          	sd	zero,24(a0)
    80001b20:	02053823          	sd	zero,48(a0)
    80001b24:	00100793          	li	a5,1
    80001b28:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001b2c:	02050523          	sb	zero,42(a0)
    80001b30:	020504a3          	sb	zero,41(a0)
    80001b34:	02050423          	sb	zero,40(a0)
    main = main_;
    80001b38:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001b3c:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001b40:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001b44:	10800513          	li	a0,264
    80001b48:	00001097          	auipc	ra,0x1
    80001b4c:	f80080e7          	jalr	-128(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
    80001b50:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001b54:	00008537          	lui	a0,0x8
    80001b58:	00001097          	auipc	ra,0x1
    80001b5c:	f70080e7          	jalr	-144(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
    80001b60:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001b64:	000087b7          	lui	a5,0x8
    80001b68:	00f50533          	add	a0,a0,a5
    80001b6c:	0184b783          	ld	a5,24(s1)
    80001b70:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001b74:	0184b783          	ld	a5,24(s1)
    80001b78:	00000717          	auipc	a4,0x0
    80001b7c:	e8c70713          	addi	a4,a4,-372 # 80001a04 <_ZN3PCB15proccessWrapperEv>
    80001b80:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001b84:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001b88:	0204b783          	ld	a5,32(s1)
    80001b8c:	00078c63          	beqz	a5,80001ba4 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001b90:	01813083          	ld	ra,24(sp)
    80001b94:	01013403          	ld	s0,16(sp)
    80001b98:	00813483          	ld	s1,8(sp)
    80001b9c:	02010113          	addi	sp,sp,32
    80001ba0:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ba4:	04048423          	sb	zero,72(s1)
}
    80001ba8:	fe9ff06f          	j	80001b90 <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001bac <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001bac:	fe010113          	addi	sp,sp,-32
    80001bb0:	00113c23          	sd	ra,24(sp)
    80001bb4:	00813823          	sd	s0,16(sp)
    80001bb8:	00913423          	sd	s1,8(sp)
    80001bbc:	02010413          	addi	s0,sp,32
    80001bc0:	00050493          	mv	s1,a0
    delete[] stack;
    80001bc4:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001bc8:	00050663          	beqz	a0,80001bd4 <_ZN3PCBD1Ev+0x28>
    80001bcc:	00000097          	auipc	ra,0x0
    80001bd0:	774080e7          	jalr	1908(ra) # 80002340 <_ZdaPv>
    delete[] sysStack;
    80001bd4:	0104b503          	ld	a0,16(s1)
    80001bd8:	00050663          	beqz	a0,80001be4 <_ZN3PCBD1Ev+0x38>
    80001bdc:	00000097          	auipc	ra,0x0
    80001be0:	764080e7          	jalr	1892(ra) # 80002340 <_ZdaPv>
}
    80001be4:	01813083          	ld	ra,24(sp)
    80001be8:	01013403          	ld	s0,16(sp)
    80001bec:	00813483          	ld	s1,8(sp)
    80001bf0:	02010113          	addi	sp,sp,32
    80001bf4:	00008067          	ret

0000000080001bf8 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001bf8:	ff010113          	addi	sp,sp,-16
    80001bfc:	00113423          	sd	ra,8(sp)
    80001c00:	00813023          	sd	s0,0(sp)
    80001c04:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c08:	00001097          	auipc	ra,0x1
    80001c0c:	ec0080e7          	jalr	-320(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001c10:	00813083          	ld	ra,8(sp)
    80001c14:	00013403          	ld	s0,0(sp)
    80001c18:	01010113          	addi	sp,sp,16
    80001c1c:	00008067          	ret

0000000080001c20 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c20:	ff010113          	addi	sp,sp,-16
    80001c24:	00113423          	sd	ra,8(sp)
    80001c28:	00813023          	sd	s0,0(sp)
    80001c2c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c30:	00001097          	auipc	ra,0x1
    80001c34:	ffc080e7          	jalr	-4(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c38:	00813083          	ld	ra,8(sp)
    80001c3c:	00013403          	ld	s0,0(sp)
    80001c40:	01010113          	addi	sp,sp,16
    80001c44:	00008067          	ret

0000000080001c48 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001c48:	fd010113          	addi	sp,sp,-48
    80001c4c:	02113423          	sd	ra,40(sp)
    80001c50:	02813023          	sd	s0,32(sp)
    80001c54:	00913c23          	sd	s1,24(sp)
    80001c58:	01213823          	sd	s2,16(sp)
    80001c5c:	01313423          	sd	s3,8(sp)
    80001c60:	03010413          	addi	s0,sp,48
    80001c64:	00050913          	mv	s2,a0
    80001c68:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001c6c:	05000513          	li	a0,80
    80001c70:	00000097          	auipc	ra,0x0
    80001c74:	f88080e7          	jalr	-120(ra) # 80001bf8 <_ZN3PCBnwEm>
    80001c78:	00050493          	mv	s1,a0
    80001c7c:	00098693          	mv	a3,s3
    80001c80:	00200613          	li	a2,2
    80001c84:	00090593          	mv	a1,s2
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	e78080e7          	jalr	-392(ra) # 80001b00 <_ZN3PCBC1EPFvvEmPv>
    80001c90:	0200006f          	j	80001cb0 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001c94:	00050913          	mv	s2,a0
    80001c98:	00048513          	mv	a0,s1
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	f84080e7          	jalr	-124(ra) # 80001c20 <_ZN3PCBdlEPv>
    80001ca4:	00090513          	mv	a0,s2
    80001ca8:	00008097          	auipc	ra,0x8
    80001cac:	e60080e7          	jalr	-416(ra) # 80009b08 <_Unwind_Resume>
}
    80001cb0:	00048513          	mv	a0,s1
    80001cb4:	02813083          	ld	ra,40(sp)
    80001cb8:	02013403          	ld	s0,32(sp)
    80001cbc:	01813483          	ld	s1,24(sp)
    80001cc0:	01013903          	ld	s2,16(sp)
    80001cc4:	00813983          	ld	s3,8(sp)
    80001cc8:	03010113          	addi	sp,sp,48
    80001ccc:	00008067          	ret

0000000080001cd0 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001cd0:	ff010113          	addi	sp,sp,-16
    80001cd4:	00813423          	sd	s0,8(sp)
    80001cd8:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001cdc:	00007797          	auipc	a5,0x7
    80001ce0:	ccc7b783          	ld	a5,-820(a5) # 800089a8 <_ZN3PCB7runningE>
    80001ce4:	0187b503          	ld	a0,24(a5)
    80001ce8:	00813403          	ld	s0,8(sp)
    80001cec:	01010113          	addi	sp,sp,16
    80001cf0:	00008067          	ret

0000000080001cf4 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    80001cf4:	fe010113          	addi	sp,sp,-32
    80001cf8:	00113c23          	sd	ra,24(sp)
    80001cfc:	00813823          	sd	s0,16(sp)
    80001d00:	00913423          	sd	s1,8(sp)
    80001d04:	01213023          	sd	s2,0(sp)
    80001d08:	02010413          	addi	s0,sp,32
    80001d0c:	00050493          	mv	s1,a0
    80001d10:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001d14:	01000513          	li	a0,16
    80001d18:	00001097          	auipc	ra,0x1
    80001d1c:	db0080e7          	jalr	-592(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001d20:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001d24:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001d28:	0004b783          	ld	a5,0(s1)
    80001d2c:	02078863          	beqz	a5,80001d5c <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001d30:	0084b783          	ld	a5,8(s1)
    80001d34:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001d38:	0084b783          	ld	a5,8(s1)
    80001d3c:	0007b783          	ld	a5,0(a5)
    80001d40:	00f4b423          	sd	a5,8(s1)
    }
}
    80001d44:	01813083          	ld	ra,24(sp)
    80001d48:	01013403          	ld	s0,16(sp)
    80001d4c:	00813483          	ld	s1,8(sp)
    80001d50:	00013903          	ld	s2,0(sp)
    80001d54:	02010113          	addi	sp,sp,32
    80001d58:	00008067          	ret
        head = tail = newElem;
    80001d5c:	00a4b423          	sd	a0,8(s1)
    80001d60:	00a4b023          	sd	a0,0(s1)
    80001d64:	fe1ff06f          	j	80001d44 <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001d68 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001d68:	fe010113          	addi	sp,sp,-32
    80001d6c:	00113c23          	sd	ra,24(sp)
    80001d70:	00813823          	sd	s0,16(sp)
    80001d74:	00913423          	sd	s1,8(sp)
    80001d78:	02010413          	addi	s0,sp,32
    80001d7c:	04c0006f          	j	80001dc8 <_ZN3CCB9inputBodyEPv+0x60>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001d80:	00007797          	auipc	a5,0x7
    80001d84:	b487b783          	ld	a5,-1208(a5) # 800088c8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001d88:	0007b783          	ld	a5,0(a5)
    80001d8c:	00007497          	auipc	s1,0x7
    80001d90:	c2c48493          	addi	s1,s1,-980 # 800089b8 <_ZN3CCB11inputBufferE>
    80001d94:	0007c583          	lbu	a1,0(a5)
    80001d98:	00048513          	mv	a0,s1
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	f58080e7          	jalr	-168(ra) # 80001cf4 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001da4:	0104b503          	ld	a0,16(s1)
    80001da8:	fffff097          	auipc	ra,0xfffff
    80001dac:	638080e7          	jalr	1592(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    80001db0:	00a00513          	li	a0,10
    80001db4:	00003097          	auipc	ra,0x3
    80001db8:	a28080e7          	jalr	-1496(ra) # 800047dc <plic_complete>
            sem_wait(semInput);
    80001dbc:	0184b503          	ld	a0,24(s1)
    80001dc0:	fffff097          	auipc	ra,0xfffff
    80001dc4:	5d8080e7          	jalr	1496(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001dc8:	00007797          	auipc	a5,0x7
    80001dcc:	b107b783          	ld	a5,-1264(a5) # 800088d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001dd0:	0007b783          	ld	a5,0(a5)
    80001dd4:	0007c783          	lbu	a5,0(a5)
    80001dd8:	0017f793          	andi	a5,a5,1
    80001ddc:	fa0792e3          	bnez	a5,80001d80 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    80001de0:	fffff097          	auipc	ra,0xfffff
    80001de4:	494080e7          	jalr	1172(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001de8:	fe1ff06f          	j	80001dc8 <_ZN3CCB9inputBodyEPv+0x60>

0000000080001dec <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001dec:	fe010113          	addi	sp,sp,-32
    80001df0:	00113c23          	sd	ra,24(sp)
    80001df4:	00813823          	sd	s0,16(sp)
    80001df8:	00913423          	sd	s1,8(sp)
    80001dfc:	02010413          	addi	s0,sp,32
    80001e00:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001e04:	00053503          	ld	a0,0(a0)
    80001e08:	04050063          	beqz	a0,80001e48 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001e0c:	00053703          	ld	a4,0(a0)
    80001e10:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001e14:	0087b703          	ld	a4,8(a5)
    80001e18:	02e50463          	beq	a0,a4,80001e40 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001e1c:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001e20:	00001097          	auipc	ra,0x1
    80001e24:	e0c080e7          	jalr	-500(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001e28:	00048513          	mv	a0,s1
    80001e2c:	01813083          	ld	ra,24(sp)
    80001e30:	01013403          	ld	s0,16(sp)
    80001e34:	00813483          	ld	s1,8(sp)
    80001e38:	02010113          	addi	sp,sp,32
    80001e3c:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001e40:	0007b423          	sd	zero,8(a5)
    80001e44:	fd9ff06f          	j	80001e1c <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001e48:	00000493          	li	s1,0
    80001e4c:	fddff06f          	j	80001e28 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001e50 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001e50:	ff010113          	addi	sp,sp,-16
    80001e54:	00813423          	sd	s0,8(sp)
    80001e58:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001e5c:	00853783          	ld	a5,8(a0)
    80001e60:	00078a63          	beqz	a5,80001e74 <_ZN8IOBuffer8peekBackEv+0x24>
    80001e64:	0087c503          	lbu	a0,8(a5)
}
    80001e68:	00813403          	ld	s0,8(sp)
    80001e6c:	01010113          	addi	sp,sp,16
    80001e70:	00008067          	ret
    return tail ? tail->data : 0;
    80001e74:	00000513          	li	a0,0
    80001e78:	ff1ff06f          	j	80001e68 <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001e7c <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001e7c:	ff010113          	addi	sp,sp,-16
    80001e80:	00813423          	sd	s0,8(sp)
    80001e84:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001e88:	00053783          	ld	a5,0(a0)
    80001e8c:	00078a63          	beqz	a5,80001ea0 <_ZN8IOBuffer9peekFrontEv+0x24>
    80001e90:	0087c503          	lbu	a0,8(a5)
}
    80001e94:	00813403          	ld	s0,8(sp)
    80001e98:	01010113          	addi	sp,sp,16
    80001e9c:	00008067          	ret
    return head ? head->data : 0;
    80001ea0:	00000513          	li	a0,0
    80001ea4:	ff1ff06f          	j	80001e94 <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001ea8 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001ea8:	fe010113          	addi	sp,sp,-32
    80001eac:	00113c23          	sd	ra,24(sp)
    80001eb0:	00813823          	sd	s0,16(sp)
    80001eb4:	00913423          	sd	s1,8(sp)
    80001eb8:	02010413          	addi	s0,sp,32
    80001ebc:	00c0006f          	j	80001ec8 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    80001ec0:	fffff097          	auipc	ra,0xfffff
    80001ec4:	3b4080e7          	jalr	948(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001ec8:	00007797          	auipc	a5,0x7
    80001ecc:	a107b783          	ld	a5,-1520(a5) # 800088d8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001ed0:	0007b783          	ld	a5,0(a5)
    80001ed4:	0007c783          	lbu	a5,0(a5)
    80001ed8:	0207f793          	andi	a5,a5,32
    80001edc:	fe0782e3          	beqz	a5,80001ec0 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80001ee0:	00007517          	auipc	a0,0x7
    80001ee4:	af850513          	addi	a0,a0,-1288 # 800089d8 <_ZN3CCB12outputBufferE>
    80001ee8:	00000097          	auipc	ra,0x0
    80001eec:	f94080e7          	jalr	-108(ra) # 80001e7c <_ZN8IOBuffer9peekFrontEv>
    80001ef0:	fc0508e3          	beqz	a0,80001ec0 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001ef4:	00007797          	auipc	a5,0x7
    80001ef8:	a047b783          	ld	a5,-1532(a5) # 800088f8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001efc:	0007b483          	ld	s1,0(a5)
    80001f00:	00007517          	auipc	a0,0x7
    80001f04:	ad850513          	addi	a0,a0,-1320 # 800089d8 <_ZN3CCB12outputBufferE>
    80001f08:	00000097          	auipc	ra,0x0
    80001f0c:	ee4080e7          	jalr	-284(ra) # 80001dec <_ZN8IOBuffer8popFrontEv>
    80001f10:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    80001f14:	00007517          	auipc	a0,0x7
    80001f18:	ad453503          	ld	a0,-1324(a0) # 800089e8 <_ZN3CCB9semOutputE>
    80001f1c:	fffff097          	auipc	ra,0xfffff
    80001f20:	47c080e7          	jalr	1148(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f24:	fa5ff06f          	j	80001ec8 <_ZN3CCB10outputBodyEPv+0x20>

0000000080001f28 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001f28:	ff010113          	addi	sp,sp,-16
    80001f2c:	00813423          	sd	s0,8(sp)
    80001f30:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001f34:	02050663          	beqz	a0,80001f60 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001f38:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001f3c:	00007797          	auipc	a5,0x7
    80001f40:	ac47b783          	ld	a5,-1340(a5) # 80008a00 <_ZN9Scheduler4tailE>
    80001f44:	02078463          	beqz	a5,80001f6c <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001f48:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001f4c:	00007797          	auipc	a5,0x7
    80001f50:	ab478793          	addi	a5,a5,-1356 # 80008a00 <_ZN9Scheduler4tailE>
    80001f54:	0007b703          	ld	a4,0(a5)
    80001f58:	00073703          	ld	a4,0(a4)
    80001f5c:	00e7b023          	sd	a4,0(a5)
    }
}
    80001f60:	00813403          	ld	s0,8(sp)
    80001f64:	01010113          	addi	sp,sp,16
    80001f68:	00008067          	ret
        head = tail = process;
    80001f6c:	00007797          	auipc	a5,0x7
    80001f70:	a9478793          	addi	a5,a5,-1388 # 80008a00 <_ZN9Scheduler4tailE>
    80001f74:	00a7b023          	sd	a0,0(a5)
    80001f78:	00a7b423          	sd	a0,8(a5)
    80001f7c:	fe5ff06f          	j	80001f60 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001f80 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001f80:	ff010113          	addi	sp,sp,-16
    80001f84:	00813423          	sd	s0,8(sp)
    80001f88:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001f8c:	00007517          	auipc	a0,0x7
    80001f90:	a7c53503          	ld	a0,-1412(a0) # 80008a08 <_ZN9Scheduler4headE>
    80001f94:	02050463          	beqz	a0,80001fbc <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001f98:	00053703          	ld	a4,0(a0)
    80001f9c:	00007797          	auipc	a5,0x7
    80001fa0:	a6478793          	addi	a5,a5,-1436 # 80008a00 <_ZN9Scheduler4tailE>
    80001fa4:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001fa8:	0007b783          	ld	a5,0(a5)
    80001fac:	00f50e63          	beq	a0,a5,80001fc8 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001fb0:	00813403          	ld	s0,8(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret
        return idleProcess;
    80001fbc:	00007517          	auipc	a0,0x7
    80001fc0:	a5453503          	ld	a0,-1452(a0) # 80008a10 <_ZN9Scheduler11idleProcessE>
    80001fc4:	fedff06f          	j	80001fb0 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001fc8:	00007797          	auipc	a5,0x7
    80001fcc:	a2e7bc23          	sd	a4,-1480(a5) # 80008a00 <_ZN9Scheduler4tailE>
    80001fd0:	fe1ff06f          	j	80001fb0 <_ZN9Scheduler3getEv+0x30>

0000000080001fd4 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80001fd4:	ff010113          	addi	sp,sp,-16
    80001fd8:	00813423          	sd	s0,8(sp)
    80001fdc:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001fe0:	00050e63          	beqz	a0,80001ffc <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80001fe4:	00007797          	auipc	a5,0x7
    80001fe8:	a247b783          	ld	a5,-1500(a5) # 80008a08 <_ZN9Scheduler4headE>
    80001fec:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80001ff0:	00078c63          	beqz	a5,80002008 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80001ff4:	00007797          	auipc	a5,0x7
    80001ff8:	a0a7ba23          	sd	a0,-1516(a5) # 80008a08 <_ZN9Scheduler4headE>
    }
}
    80001ffc:	00813403          	ld	s0,8(sp)
    80002000:	01010113          	addi	sp,sp,16
    80002004:	00008067          	ret
        head = tail = process;
    80002008:	00007797          	auipc	a5,0x7
    8000200c:	9f878793          	addi	a5,a5,-1544 # 80008a00 <_ZN9Scheduler4tailE>
    80002010:	00a7b023          	sd	a0,0(a5)
    80002014:	00a7b423          	sd	a0,8(a5)
    80002018:	fe5ff06f          	j	80001ffc <_ZN9Scheduler10putInFrontEP3PCB+0x28>

000000008000201c <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    8000201c:	ff010113          	addi	sp,sp,-16
    80002020:	00813423          	sd	s0,8(sp)
    80002024:	01010413          	addi	s0,sp,16
    while(true) {}
    80002028:	0000006f          	j	80002028 <idleProcess+0xc>

000000008000202c <_Z8userModev>:
#define USERMAIN_H

PCB* userProcess = nullptr;

extern "C" void interrupt();
void userMode() {
    8000202c:	ff010113          	addi	sp,sp,-16
    80002030:	00813423          	sd	s0,8(sp)
    80002034:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::userMode;
    asm volatile("mv a0, %0" : : "r" (code));
    80002038:	04300793          	li	a5,67
    8000203c:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002040:	00000073          	ecall

}
    80002044:	00813403          	ld	s0,8(sp)
    80002048:	01010113          	addi	sp,sp,16
    8000204c:	00008067          	ret

0000000080002050 <_Z15userMainWrapperPv>:
void userMain();
void userMainWrapper(void*) {
    80002050:	ff010113          	addi	sp,sp,-16
    80002054:	00113423          	sd	ra,8(sp)
    80002058:	00813023          	sd	s0,0(sp)
    8000205c:	01010413          	addi	s0,sp,16
    userMode();
    80002060:	00000097          	auipc	ra,0x0
    80002064:	fcc080e7          	jalr	-52(ra) # 8000202c <_Z8userModev>
    userMain();
    80002068:	00002097          	auipc	ra,0x2
    8000206c:	838080e7          	jalr	-1992(ra) # 800038a0 <_Z8userMainv>
}
    80002070:	00813083          	ld	ra,8(sp)
    80002074:	00013403          	ld	s0,0(sp)
    80002078:	01010113          	addi	sp,sp,16
    8000207c:	00008067          	ret

0000000080002080 <main>:
}
// ------------

int main() {
    80002080:	ff010113          	addi	sp,sp,-16
    80002084:	00113423          	sd	ra,8(sp)
    80002088:	00813023          	sd	s0,0(sp)
    8000208c:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002090:	00007797          	auipc	a5,0x7
    80002094:	8b07b783          	ld	a5,-1872(a5) # 80008940 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002098:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    8000209c:	00000593          	li	a1,0
    800020a0:	00000513          	li	a0,0
    800020a4:	00000097          	auipc	ra,0x0
    800020a8:	ba4080e7          	jalr	-1116(ra) # 80001c48 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    800020ac:	00007797          	auipc	a5,0x7
    800020b0:	8747b783          	ld	a5,-1932(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    800020b4:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    800020b8:	00000593          	li	a1,0
    800020bc:	00007517          	auipc	a0,0x7
    800020c0:	88c53503          	ld	a0,-1908(a0) # 80008948 <_GLOBAL_OFFSET_TABLE_+0x88>
    800020c4:	fffff097          	auipc	ra,0xfffff
    800020c8:	28c080e7          	jalr	652(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    800020cc:	00000593          	li	a1,0
    800020d0:	00007517          	auipc	a0,0x7
    800020d4:	86053503          	ld	a0,-1952(a0) # 80008930 <_GLOBAL_OFFSET_TABLE_+0x70>
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	278080e7          	jalr	632(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    800020e0:	00000593          	li	a1,0
    800020e4:	00007517          	auipc	a0,0x7
    800020e8:	85453503          	ld	a0,-1964(a0) # 80008938 <_GLOBAL_OFFSET_TABLE_+0x78>
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	264080e7          	jalr	612(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800020f4:	00200793          	li	a5,2
    800020f8:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800020fc:	00000613          	li	a2,0
    80002100:	00007597          	auipc	a1,0x7
    80002104:	8105b583          	ld	a1,-2032(a1) # 80008910 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002108:	00007517          	auipc	a0,0x7
    8000210c:	85053503          	ld	a0,-1968(a0) # 80008958 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002110:	fffff097          	auipc	ra,0xfffff
    80002114:	1f0080e7          	jalr	496(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002118:	00000613          	li	a2,0
    8000211c:	00007597          	auipc	a1,0x7
    80002120:	8345b583          	ld	a1,-1996(a1) # 80008950 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002124:	00006517          	auipc	a0,0x6
    80002128:	7ac53503          	ld	a0,1964(a0) # 800088d0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	1d4080e7          	jalr	468(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002134:	00000613          	li	a2,0
    80002138:	00000597          	auipc	a1,0x0
    8000213c:	ee458593          	addi	a1,a1,-284 # 8000201c <idleProcess>
    80002140:	00006517          	auipc	a0,0x6
    80002144:	7d853503          	ld	a0,2008(a0) # 80008918 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	0c0080e7          	jalr	192(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80002150:	00006797          	auipc	a5,0x6
    80002154:	7c87b783          	ld	a5,1992(a5) # 80008918 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002158:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    8000215c:	00100713          	li	a4,1
    80002160:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    80002164:	00100713          	li	a4,1
    80002168:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);
    thread_create(&userProcess, userMainWrapper, nullptr);
    8000216c:	00000613          	li	a2,0
    80002170:	00000597          	auipc	a1,0x0
    80002174:	ee058593          	addi	a1,a1,-288 # 80002050 <_Z15userMainWrapperPv>
    80002178:	00007517          	auipc	a0,0x7
    8000217c:	8a050513          	addi	a0,a0,-1888 # 80008a18 <userProcess>
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	180080e7          	jalr	384(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    80002188:	00007797          	auipc	a5,0x7
    8000218c:	8907b783          	ld	a5,-1904(a5) # 80008a18 <userProcess>
        return finished;
    80002190:	0287c783          	lbu	a5,40(a5)
    80002194:	00079863          	bnez	a5,800021a4 <main+0x124>
        thread_dispatch();
    80002198:	fffff097          	auipc	ra,0xfffff
    8000219c:	0dc080e7          	jalr	220(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    800021a0:	fe9ff06f          	j	80002188 <main+0x108>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    800021a4:	00006797          	auipc	a5,0x6
    800021a8:	78c7b783          	ld	a5,1932(a5) # 80008930 <_GLOBAL_OFFSET_TABLE_+0x70>
    800021ac:	0007b783          	ld	a5,0(a5)
        return semValue;
    800021b0:	0107a783          	lw	a5,16(a5)
    800021b4:	00078863          	beqz	a5,800021c4 <main+0x144>
        thread_dispatch();
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	0bc080e7          	jalr	188(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    800021c0:	fe5ff06f          	j	800021a4 <main+0x124>
    }
    return 0;
    800021c4:	00000513          	li	a0,0
    800021c8:	00813083          	ld	ra,8(sp)
    800021cc:	00013403          	ld	s0,0(sp)
    800021d0:	01010113          	addi	sp,sp,16
    800021d4:	00008067          	ret

00000000800021d8 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    800021d8:	fe010113          	addi	sp,sp,-32
    800021dc:	00113c23          	sd	ra,24(sp)
    800021e0:	00813823          	sd	s0,16(sp)
    800021e4:	00913423          	sd	s1,8(sp)
    800021e8:	02010413          	addi	s0,sp,32
    800021ec:	00006797          	auipc	a5,0x6
    800021f0:	60c78793          	addi	a5,a5,1548 # 800087f8 <_ZTV6Thread+0x10>
    800021f4:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800021f8:	00853483          	ld	s1,8(a0)
    800021fc:	00048e63          	beqz	s1,80002218 <_ZN6ThreadD1Ev+0x40>
    80002200:	00048513          	mv	a0,s1
    80002204:	00000097          	auipc	ra,0x0
    80002208:	9a8080e7          	jalr	-1624(ra) # 80001bac <_ZN3PCBD1Ev>
    8000220c:	00048513          	mv	a0,s1
    80002210:	00000097          	auipc	ra,0x0
    80002214:	a10080e7          	jalr	-1520(ra) # 80001c20 <_ZN3PCBdlEPv>
}
    80002218:	01813083          	ld	ra,24(sp)
    8000221c:	01013403          	ld	s0,16(sp)
    80002220:	00813483          	ld	s1,8(sp)
    80002224:	02010113          	addi	sp,sp,32
    80002228:	00008067          	ret

000000008000222c <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    8000222c:	ff010113          	addi	sp,sp,-16
    80002230:	00113423          	sd	ra,8(sp)
    80002234:	00813023          	sd	s0,0(sp)
    80002238:	01010413          	addi	s0,sp,16
    8000223c:	00006797          	auipc	a5,0x6
    80002240:	5e478793          	addi	a5,a5,1508 # 80008820 <_ZTV9Semaphore+0x10>
    80002244:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002248:	00853503          	ld	a0,8(a0)
    8000224c:	fffff097          	auipc	ra,0xfffff
    80002250:	1d4080e7          	jalr	468(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80002254:	00813083          	ld	ra,8(sp)
    80002258:	00013403          	ld	s0,0(sp)
    8000225c:	01010113          	addi	sp,sp,16
    80002260:	00008067          	ret

0000000080002264 <_Znwm>:
void* operator new (size_t size) {
    80002264:	ff010113          	addi	sp,sp,-16
    80002268:	00113423          	sd	ra,8(sp)
    8000226c:	00813023          	sd	s0,0(sp)
    80002270:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002274:	fffff097          	auipc	ra,0xfffff
    80002278:	f20080e7          	jalr	-224(ra) # 80001194 <_Z9mem_allocm>
}
    8000227c:	00813083          	ld	ra,8(sp)
    80002280:	00013403          	ld	s0,0(sp)
    80002284:	01010113          	addi	sp,sp,16
    80002288:	00008067          	ret

000000008000228c <_Znam>:
void* operator new [](size_t size) {
    8000228c:	ff010113          	addi	sp,sp,-16
    80002290:	00113423          	sd	ra,8(sp)
    80002294:	00813023          	sd	s0,0(sp)
    80002298:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    8000229c:	fffff097          	auipc	ra,0xfffff
    800022a0:	ef8080e7          	jalr	-264(ra) # 80001194 <_Z9mem_allocm>
}
    800022a4:	00813083          	ld	ra,8(sp)
    800022a8:	00013403          	ld	s0,0(sp)
    800022ac:	01010113          	addi	sp,sp,16
    800022b0:	00008067          	ret

00000000800022b4 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800022b4:	ff010113          	addi	sp,sp,-16
    800022b8:	00113423          	sd	ra,8(sp)
    800022bc:	00813023          	sd	s0,0(sp)
    800022c0:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	f10080e7          	jalr	-240(ra) # 800011d4 <_Z8mem_freePv>
}
    800022cc:	00813083          	ld	ra,8(sp)
    800022d0:	00013403          	ld	s0,0(sp)
    800022d4:	01010113          	addi	sp,sp,16
    800022d8:	00008067          	ret

00000000800022dc <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    800022dc:	fe010113          	addi	sp,sp,-32
    800022e0:	00113c23          	sd	ra,24(sp)
    800022e4:	00813823          	sd	s0,16(sp)
    800022e8:	00913423          	sd	s1,8(sp)
    800022ec:	02010413          	addi	s0,sp,32
    800022f0:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    800022f4:	00053503          	ld	a0,0(a0)
    800022f8:	0104b783          	ld	a5,16(s1)
    800022fc:	00f50533          	add	a0,a0,a5
    80002300:	0084b783          	ld	a5,8(s1)
    80002304:	0017f713          	andi	a4,a5,1
    80002308:	00070863          	beqz	a4,80002318 <_Z13threadWrapperPv+0x3c>
    8000230c:	00053703          	ld	a4,0(a0)
    80002310:	00f707b3          	add	a5,a4,a5
    80002314:	fff7b783          	ld	a5,-1(a5)
    80002318:	000780e7          	jalr	a5
    delete tArg;
    8000231c:	00048863          	beqz	s1,8000232c <_Z13threadWrapperPv+0x50>
    80002320:	00048513          	mv	a0,s1
    80002324:	00000097          	auipc	ra,0x0
    80002328:	f90080e7          	jalr	-112(ra) # 800022b4 <_ZdlPv>
}
    8000232c:	01813083          	ld	ra,24(sp)
    80002330:	01013403          	ld	s0,16(sp)
    80002334:	00813483          	ld	s1,8(sp)
    80002338:	02010113          	addi	sp,sp,32
    8000233c:	00008067          	ret

0000000080002340 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002340:	ff010113          	addi	sp,sp,-16
    80002344:	00113423          	sd	ra,8(sp)
    80002348:	00813023          	sd	s0,0(sp)
    8000234c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002350:	fffff097          	auipc	ra,0xfffff
    80002354:	e84080e7          	jalr	-380(ra) # 800011d4 <_Z8mem_freePv>
}
    80002358:	00813083          	ld	ra,8(sp)
    8000235c:	00013403          	ld	s0,0(sp)
    80002360:	01010113          	addi	sp,sp,16
    80002364:	00008067          	ret

0000000080002368 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002368:	ff010113          	addi	sp,sp,-16
    8000236c:	00113423          	sd	ra,8(sp)
    80002370:	00813023          	sd	s0,0(sp)
    80002374:	01010413          	addi	s0,sp,16
    80002378:	00006797          	auipc	a5,0x6
    8000237c:	48078793          	addi	a5,a5,1152 # 800087f8 <_ZTV6Thread+0x10>
    80002380:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002384:	00850513          	addi	a0,a0,8
    80002388:	fffff097          	auipc	ra,0xfffff
    8000238c:	e80080e7          	jalr	-384(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002390:	00813083          	ld	ra,8(sp)
    80002394:	00013403          	ld	s0,0(sp)
    80002398:	01010113          	addi	sp,sp,16
    8000239c:	00008067          	ret

00000000800023a0 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    800023a0:	ff010113          	addi	sp,sp,-16
    800023a4:	00113423          	sd	ra,8(sp)
    800023a8:	00813023          	sd	s0,0(sp)
    800023ac:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800023b0:	00000097          	auipc	ra,0x0
    800023b4:	718080e7          	jalr	1816(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
}
    800023b8:	00813083          	ld	ra,8(sp)
    800023bc:	00013403          	ld	s0,0(sp)
    800023c0:	01010113          	addi	sp,sp,16
    800023c4:	00008067          	ret

00000000800023c8 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    800023c8:	ff010113          	addi	sp,sp,-16
    800023cc:	00113423          	sd	ra,8(sp)
    800023d0:	00813023          	sd	s0,0(sp)
    800023d4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800023d8:	00001097          	auipc	ra,0x1
    800023dc:	854080e7          	jalr	-1964(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
}
    800023e0:	00813083          	ld	ra,8(sp)
    800023e4:	00013403          	ld	s0,0(sp)
    800023e8:	01010113          	addi	sp,sp,16
    800023ec:	00008067          	ret

00000000800023f0 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800023f0:	fe010113          	addi	sp,sp,-32
    800023f4:	00113c23          	sd	ra,24(sp)
    800023f8:	00813823          	sd	s0,16(sp)
    800023fc:	00913423          	sd	s1,8(sp)
    80002400:	02010413          	addi	s0,sp,32
    80002404:	00050493          	mv	s1,a0
}
    80002408:	00000097          	auipc	ra,0x0
    8000240c:	dd0080e7          	jalr	-560(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80002410:	00048513          	mv	a0,s1
    80002414:	00000097          	auipc	ra,0x0
    80002418:	fb4080e7          	jalr	-76(ra) # 800023c8 <_ZN6ThreaddlEPv>
    8000241c:	01813083          	ld	ra,24(sp)
    80002420:	01013403          	ld	s0,16(sp)
    80002424:	00813483          	ld	s1,8(sp)
    80002428:	02010113          	addi	sp,sp,32
    8000242c:	00008067          	ret

0000000080002430 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002430:	ff010113          	addi	sp,sp,-16
    80002434:	00113423          	sd	ra,8(sp)
    80002438:	00813023          	sd	s0,0(sp)
    8000243c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002440:	fffff097          	auipc	ra,0xfffff
    80002444:	e34080e7          	jalr	-460(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002448:	00813083          	ld	ra,8(sp)
    8000244c:	00013403          	ld	s0,0(sp)
    80002450:	01010113          	addi	sp,sp,16
    80002454:	00008067          	ret

0000000080002458 <_ZN6Thread5startEv>:
int Thread::start() {
    80002458:	ff010113          	addi	sp,sp,-16
    8000245c:	00113423          	sd	ra,8(sp)
    80002460:	00813023          	sd	s0,0(sp)
    80002464:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002468:	00850513          	addi	a0,a0,8
    8000246c:	fffff097          	auipc	ra,0xfffff
    80002470:	e64080e7          	jalr	-412(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002474:	00000513          	li	a0,0
    80002478:	00813083          	ld	ra,8(sp)
    8000247c:	00013403          	ld	s0,0(sp)
    80002480:	01010113          	addi	sp,sp,16
    80002484:	00008067          	ret

0000000080002488 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002488:	fe010113          	addi	sp,sp,-32
    8000248c:	00113c23          	sd	ra,24(sp)
    80002490:	00813823          	sd	s0,16(sp)
    80002494:	00913423          	sd	s1,8(sp)
    80002498:	02010413          	addi	s0,sp,32
    8000249c:	00050493          	mv	s1,a0
    800024a0:	00006797          	auipc	a5,0x6
    800024a4:	35878793          	addi	a5,a5,856 # 800087f8 <_ZTV6Thread+0x10>
    800024a8:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    800024ac:	01800513          	li	a0,24
    800024b0:	00000097          	auipc	ra,0x0
    800024b4:	db4080e7          	jalr	-588(ra) # 80002264 <_Znwm>
    800024b8:	00050613          	mv	a2,a0
    800024bc:	00953023          	sd	s1,0(a0)
    800024c0:	01100793          	li	a5,17
    800024c4:	00f53423          	sd	a5,8(a0)
    800024c8:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    800024cc:	00000597          	auipc	a1,0x0
    800024d0:	e1058593          	addi	a1,a1,-496 # 800022dc <_Z13threadWrapperPv>
    800024d4:	00848513          	addi	a0,s1,8
    800024d8:	fffff097          	auipc	ra,0xfffff
    800024dc:	d30080e7          	jalr	-720(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800024e0:	01813083          	ld	ra,24(sp)
    800024e4:	01013403          	ld	s0,16(sp)
    800024e8:	00813483          	ld	s1,8(sp)
    800024ec:	02010113          	addi	sp,sp,32
    800024f0:	00008067          	ret

00000000800024f4 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800024f4:	ff010113          	addi	sp,sp,-16
    800024f8:	00113423          	sd	ra,8(sp)
    800024fc:	00813023          	sd	s0,0(sp)
    80002500:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002504:	fffff097          	auipc	ra,0xfffff
    80002508:	f5c080e7          	jalr	-164(ra) # 80001460 <_Z10time_sleepm>
}
    8000250c:	00813083          	ld	ra,8(sp)
    80002510:	00013403          	ld	s0,0(sp)
    80002514:	01010113          	addi	sp,sp,16
    80002518:	00008067          	ret

000000008000251c <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    8000251c:	fe010113          	addi	sp,sp,-32
    80002520:	00113c23          	sd	ra,24(sp)
    80002524:	00813823          	sd	s0,16(sp)
    80002528:	00913423          	sd	s1,8(sp)
    8000252c:	02010413          	addi	s0,sp,32
    80002530:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002534:	0200006f          	j	80002554 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002538:	00053703          	ld	a4,0(a0)
    8000253c:	00f707b3          	add	a5,a4,a5
    80002540:	fff7b783          	ld	a5,-1(a5)
    80002544:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002548:	0184b503          	ld	a0,24(s1)
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	fa8080e7          	jalr	-88(ra) # 800024f4 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002554:	0004b503          	ld	a0,0(s1)
    80002558:	0104b783          	ld	a5,16(s1)
    8000255c:	00f50533          	add	a0,a0,a5
    80002560:	0084b783          	ld	a5,8(s1)
    80002564:	0017f713          	andi	a4,a5,1
    80002568:	fc070ee3          	beqz	a4,80002544 <_Z21periodicThreadWrapperPv+0x28>
    8000256c:	fcdff06f          	j	80002538 <_Z21periodicThreadWrapperPv+0x1c>

0000000080002570 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002570:	fe010113          	addi	sp,sp,-32
    80002574:	00113c23          	sd	ra,24(sp)
    80002578:	00813823          	sd	s0,16(sp)
    8000257c:	00913423          	sd	s1,8(sp)
    80002580:	01213023          	sd	s2,0(sp)
    80002584:	02010413          	addi	s0,sp,32
    80002588:	00050493          	mv	s1,a0
    8000258c:	00006797          	auipc	a5,0x6
    80002590:	29478793          	addi	a5,a5,660 # 80008820 <_ZTV9Semaphore+0x10>
    80002594:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002598:	00058913          	mv	s2,a1
        return new SCB(semValue);
    8000259c:	01800513          	li	a0,24
    800025a0:	00000097          	auipc	ra,0x0
    800025a4:	474080e7          	jalr	1140(ra) # 80002a14 <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    800025a8:	00053023          	sd	zero,0(a0)
    800025ac:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    800025b0:	01252823          	sw	s2,16(a0)
    800025b4:	00a4b423          	sd	a0,8(s1)
}
    800025b8:	01813083          	ld	ra,24(sp)
    800025bc:	01013403          	ld	s0,16(sp)
    800025c0:	00813483          	ld	s1,8(sp)
    800025c4:	00013903          	ld	s2,0(sp)
    800025c8:	02010113          	addi	sp,sp,32
    800025cc:	00008067          	ret

00000000800025d0 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800025d0:	ff010113          	addi	sp,sp,-16
    800025d4:	00113423          	sd	ra,8(sp)
    800025d8:	00813023          	sd	s0,0(sp)
    800025dc:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800025e0:	00853503          	ld	a0,8(a0)
    800025e4:	fffff097          	auipc	ra,0xfffff
    800025e8:	db4080e7          	jalr	-588(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    800025ec:	00813083          	ld	ra,8(sp)
    800025f0:	00013403          	ld	s0,0(sp)
    800025f4:	01010113          	addi	sp,sp,16
    800025f8:	00008067          	ret

00000000800025fc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800025fc:	ff010113          	addi	sp,sp,-16
    80002600:	00113423          	sd	ra,8(sp)
    80002604:	00813023          	sd	s0,0(sp)
    80002608:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000260c:	00853503          	ld	a0,8(a0)
    80002610:	fffff097          	auipc	ra,0xfffff
    80002614:	dd0080e7          	jalr	-560(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80002618:	00813083          	ld	ra,8(sp)
    8000261c:	00013403          	ld	s0,0(sp)
    80002620:	01010113          	addi	sp,sp,16
    80002624:	00008067          	ret

0000000080002628 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002628:	ff010113          	addi	sp,sp,-16
    8000262c:	00113423          	sd	ra,8(sp)
    80002630:	00813023          	sd	s0,0(sp)
    80002634:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	5f4080e7          	jalr	1524(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002640:	00813083          	ld	ra,8(sp)
    80002644:	00013403          	ld	s0,0(sp)
    80002648:	01010113          	addi	sp,sp,16
    8000264c:	00008067          	ret

0000000080002650 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002650:	fe010113          	addi	sp,sp,-32
    80002654:	00113c23          	sd	ra,24(sp)
    80002658:	00813823          	sd	s0,16(sp)
    8000265c:	00913423          	sd	s1,8(sp)
    80002660:	02010413          	addi	s0,sp,32
    80002664:	00050493          	mv	s1,a0
}
    80002668:	00000097          	auipc	ra,0x0
    8000266c:	bc4080e7          	jalr	-1084(ra) # 8000222c <_ZN9SemaphoreD1Ev>
    80002670:	00048513          	mv	a0,s1
    80002674:	00000097          	auipc	ra,0x0
    80002678:	fb4080e7          	jalr	-76(ra) # 80002628 <_ZN9SemaphoredlEPv>
    8000267c:	01813083          	ld	ra,24(sp)
    80002680:	01013403          	ld	s0,16(sp)
    80002684:	00813483          	ld	s1,8(sp)
    80002688:	02010113          	addi	sp,sp,32
    8000268c:	00008067          	ret

0000000080002690 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800026a0:	00000097          	auipc	ra,0x0
    800026a4:	428080e7          	jalr	1064(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
}
    800026a8:	00813083          	ld	ra,8(sp)
    800026ac:	00013403          	ld	s0,0(sp)
    800026b0:	01010113          	addi	sp,sp,16
    800026b4:	00008067          	ret

00000000800026b8 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    800026b8:	fe010113          	addi	sp,sp,-32
    800026bc:	00113c23          	sd	ra,24(sp)
    800026c0:	00813823          	sd	s0,16(sp)
    800026c4:	00913423          	sd	s1,8(sp)
    800026c8:	01213023          	sd	s2,0(sp)
    800026cc:	02010413          	addi	s0,sp,32
    800026d0:	00050493          	mv	s1,a0
    800026d4:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    800026d8:	02000513          	li	a0,32
    800026dc:	00000097          	auipc	ra,0x0
    800026e0:	b88080e7          	jalr	-1144(ra) # 80002264 <_Znwm>
    800026e4:	00050613          	mv	a2,a0
    800026e8:	00953023          	sd	s1,0(a0)
    800026ec:	01900793          	li	a5,25
    800026f0:	00f53423          	sd	a5,8(a0)
    800026f4:	00053823          	sd	zero,16(a0)
    800026f8:	01253c23          	sd	s2,24(a0)
    800026fc:	00000597          	auipc	a1,0x0
    80002700:	e2058593          	addi	a1,a1,-480 # 8000251c <_Z21periodicThreadWrapperPv>
    80002704:	00048513          	mv	a0,s1
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	c60080e7          	jalr	-928(ra) # 80002368 <_ZN6ThreadC1EPFvPvES0_>
    80002710:	00006797          	auipc	a5,0x6
    80002714:	0b878793          	addi	a5,a5,184 # 800087c8 <_ZTV14PeriodicThread+0x10>
    80002718:	00f4b023          	sd	a5,0(s1)
{}
    8000271c:	01813083          	ld	ra,24(sp)
    80002720:	01013403          	ld	s0,16(sp)
    80002724:	00813483          	ld	s1,8(sp)
    80002728:	00013903          	ld	s2,0(sp)
    8000272c:	02010113          	addi	sp,sp,32
    80002730:	00008067          	ret

0000000080002734 <_ZN7Console4getcEv>:


char Console::getc() {
    80002734:	ff010113          	addi	sp,sp,-16
    80002738:	00113423          	sd	ra,8(sp)
    8000273c:	00813023          	sd	s0,0(sp)
    80002740:	01010413          	addi	s0,sp,16
    return ::getc();
    80002744:	fffff097          	auipc	ra,0xfffff
    80002748:	d64080e7          	jalr	-668(ra) # 800014a8 <_Z4getcv>
}
    8000274c:	00813083          	ld	ra,8(sp)
    80002750:	00013403          	ld	s0,0(sp)
    80002754:	01010113          	addi	sp,sp,16
    80002758:	00008067          	ret

000000008000275c <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000275c:	ff010113          	addi	sp,sp,-16
    80002760:	00113423          	sd	ra,8(sp)
    80002764:	00813023          	sd	s0,0(sp)
    80002768:	01010413          	addi	s0,sp,16
    return ::putc(c);
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	d6c080e7          	jalr	-660(ra) # 800014d8 <_Z4putcc>
}
    80002774:	00813083          	ld	ra,8(sp)
    80002778:	00013403          	ld	s0,0(sp)
    8000277c:	01010113          	addi	sp,sp,16
    80002780:	00008067          	ret

0000000080002784 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002784:	ff010113          	addi	sp,sp,-16
    80002788:	00813423          	sd	s0,8(sp)
    8000278c:	01010413          	addi	s0,sp,16
    80002790:	00813403          	ld	s0,8(sp)
    80002794:	01010113          	addi	sp,sp,16
    80002798:	00008067          	ret

000000008000279c <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    8000279c:	ff010113          	addi	sp,sp,-16
    800027a0:	00813423          	sd	s0,8(sp)
    800027a4:	01010413          	addi	s0,sp,16
    800027a8:	00813403          	ld	s0,8(sp)
    800027ac:	01010113          	addi	sp,sp,16
    800027b0:	00008067          	ret

00000000800027b4 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800027b4:	ff010113          	addi	sp,sp,-16
    800027b8:	00113423          	sd	ra,8(sp)
    800027bc:	00813023          	sd	s0,0(sp)
    800027c0:	01010413          	addi	s0,sp,16
    800027c4:	00006797          	auipc	a5,0x6
    800027c8:	00478793          	addi	a5,a5,4 # 800087c8 <_ZTV14PeriodicThread+0x10>
    800027cc:	00f53023          	sd	a5,0(a0)
    800027d0:	00000097          	auipc	ra,0x0
    800027d4:	a08080e7          	jalr	-1528(ra) # 800021d8 <_ZN6ThreadD1Ev>
    800027d8:	00813083          	ld	ra,8(sp)
    800027dc:	00013403          	ld	s0,0(sp)
    800027e0:	01010113          	addi	sp,sp,16
    800027e4:	00008067          	ret

00000000800027e8 <_ZN14PeriodicThreadD0Ev>:
    800027e8:	fe010113          	addi	sp,sp,-32
    800027ec:	00113c23          	sd	ra,24(sp)
    800027f0:	00813823          	sd	s0,16(sp)
    800027f4:	00913423          	sd	s1,8(sp)
    800027f8:	02010413          	addi	s0,sp,32
    800027fc:	00050493          	mv	s1,a0
    80002800:	00006797          	auipc	a5,0x6
    80002804:	fc878793          	addi	a5,a5,-56 # 800087c8 <_ZTV14PeriodicThread+0x10>
    80002808:	00f53023          	sd	a5,0(a0)
    8000280c:	00000097          	auipc	ra,0x0
    80002810:	9cc080e7          	jalr	-1588(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80002814:	00048513          	mv	a0,s1
    80002818:	00000097          	auipc	ra,0x0
    8000281c:	bb0080e7          	jalr	-1104(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80002820:	01813083          	ld	ra,24(sp)
    80002824:	01013403          	ld	s0,16(sp)
    80002828:	00813483          	ld	s1,8(sp)
    8000282c:	02010113          	addi	sp,sp,32
    80002830:	00008067          	ret

0000000080002834 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002834:	ff010113          	addi	sp,sp,-16
    80002838:	00813423          	sd	s0,8(sp)
    8000283c:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002840:	00006797          	auipc	a5,0x6
    80002844:	0e07b783          	ld	a5,224(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002848:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    8000284c:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002850:	00853783          	ld	a5,8(a0)
    80002854:	04078063          	beqz	a5,80002894 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002858:	00006717          	auipc	a4,0x6
    8000285c:	0c873703          	ld	a4,200(a4) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002860:	00073703          	ld	a4,0(a4)
    80002864:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002868:	00853783          	ld	a5,8(a0)
        return nextInList;
    8000286c:	0007b783          	ld	a5,0(a5)
    80002870:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002874:	00006797          	auipc	a5,0x6
    80002878:	0ac7b783          	ld	a5,172(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000287c:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002880:	00100713          	li	a4,1
    80002884:	02e784a3          	sb	a4,41(a5)
}
    80002888:	00813403          	ld	s0,8(sp)
    8000288c:	01010113          	addi	sp,sp,16
    80002890:	00008067          	ret
        head = tail = PCB::running;
    80002894:	00006797          	auipc	a5,0x6
    80002898:	08c7b783          	ld	a5,140(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000289c:	0007b783          	ld	a5,0(a5)
    800028a0:	00f53423          	sd	a5,8(a0)
    800028a4:	00f53023          	sd	a5,0(a0)
    800028a8:	fcdff06f          	j	80002874 <_ZN3SCB5blockEv+0x40>

00000000800028ac <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800028ac:	ff010113          	addi	sp,sp,-16
    800028b0:	00813423          	sd	s0,8(sp)
    800028b4:	01010413          	addi	s0,sp,16
    800028b8:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800028bc:	00053503          	ld	a0,0(a0)
    800028c0:	00050e63          	beqz	a0,800028dc <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800028c4:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800028c8:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800028cc:	0087b683          	ld	a3,8(a5)
    800028d0:	00d50c63          	beq	a0,a3,800028e8 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    800028d4:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    800028d8:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    800028dc:	00813403          	ld	s0,8(sp)
    800028e0:	01010113          	addi	sp,sp,16
    800028e4:	00008067          	ret
        tail = head;
    800028e8:	00e7b423          	sd	a4,8(a5)
    800028ec:	fe9ff06f          	j	800028d4 <_ZN3SCB7unblockEv+0x28>

00000000800028f0 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    800028f0:	01052783          	lw	a5,16(a0)
    800028f4:	fff7879b          	addiw	a5,a5,-1
    800028f8:	00f52823          	sw	a5,16(a0)
    800028fc:	02079713          	slli	a4,a5,0x20
    80002900:	02074063          	bltz	a4,80002920 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002904:	00006797          	auipc	a5,0x6
    80002908:	01c7b783          	ld	a5,28(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000290c:	0007b783          	ld	a5,0(a5)
    80002910:	02a7c783          	lbu	a5,42(a5)
    80002914:	06079463          	bnez	a5,8000297c <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80002918:	00000513          	li	a0,0
    8000291c:	00008067          	ret
int SCB::wait() {
    80002920:	ff010113          	addi	sp,sp,-16
    80002924:	00113423          	sd	ra,8(sp)
    80002928:	00813023          	sd	s0,0(sp)
    8000292c:	01010413          	addi	s0,sp,16
        block();
    80002930:	00000097          	auipc	ra,0x0
    80002934:	f04080e7          	jalr	-252(ra) # 80002834 <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80002938:	00006797          	auipc	a5,0x6
    8000293c:	fc87b783          	ld	a5,-56(a5) # 80008900 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002940:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80002944:	fffff097          	auipc	ra,0xfffff
    80002948:	12c080e7          	jalr	300(ra) # 80001a70 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000294c:	00006797          	auipc	a5,0x6
    80002950:	fd47b783          	ld	a5,-44(a5) # 80008920 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002954:	0007b783          	ld	a5,0(a5)
    80002958:	02a7c783          	lbu	a5,42(a5)
    8000295c:	00079c63          	bnez	a5,80002974 <_ZN3SCB4waitEv+0x84>
    return 0;
    80002960:	00000513          	li	a0,0

}
    80002964:	00813083          	ld	ra,8(sp)
    80002968:	00013403          	ld	s0,0(sp)
    8000296c:	01010113          	addi	sp,sp,16
    80002970:	00008067          	ret
        return -2;
    80002974:	ffe00513          	li	a0,-2
    80002978:	fedff06f          	j	80002964 <_ZN3SCB4waitEv+0x74>
    8000297c:	ffe00513          	li	a0,-2
}
    80002980:	00008067          	ret

0000000080002984 <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    80002984:	01052783          	lw	a5,16(a0)
    80002988:	0017879b          	addiw	a5,a5,1
    8000298c:	0007871b          	sext.w	a4,a5
    80002990:	00f52823          	sw	a5,16(a0)
    80002994:	00e05463          	blez	a4,8000299c <_ZN3SCB6signalEv+0x18>
    80002998:	00008067          	ret
void SCB::signal() {
    8000299c:	ff010113          	addi	sp,sp,-16
    800029a0:	00113423          	sd	ra,8(sp)
    800029a4:	00813023          	sd	s0,0(sp)
    800029a8:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800029ac:	00000097          	auipc	ra,0x0
    800029b0:	f00080e7          	jalr	-256(ra) # 800028ac <_ZN3SCB7unblockEv>
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	574080e7          	jalr	1396(ra) # 80001f28 <_ZN9Scheduler3putEP3PCB>
    }

}
    800029bc:	00813083          	ld	ra,8(sp)
    800029c0:	00013403          	ld	s0,0(sp)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    800029cc:	01052783          	lw	a5,16(a0)
    800029d0:	0017879b          	addiw	a5,a5,1
    800029d4:	0007871b          	sext.w	a4,a5
    800029d8:	00f52823          	sw	a5,16(a0)
    800029dc:	00e05463          	blez	a4,800029e4 <_ZN3SCB14prioritySignalEv+0x18>
    800029e0:	00008067          	ret
void SCB::prioritySignal() {
    800029e4:	ff010113          	addi	sp,sp,-16
    800029e8:	00113423          	sd	ra,8(sp)
    800029ec:	00813023          	sd	s0,0(sp)
    800029f0:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    800029f4:	00000097          	auipc	ra,0x0
    800029f8:	eb8080e7          	jalr	-328(ra) # 800028ac <_ZN3SCB7unblockEv>
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	5d8080e7          	jalr	1496(ra) # 80001fd4 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    80002a04:	00813083          	ld	ra,8(sp)
    80002a08:	00013403          	ld	s0,0(sp)
    80002a0c:	01010113          	addi	sp,sp,16
    80002a10:	00008067          	ret

0000000080002a14 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80002a14:	ff010113          	addi	sp,sp,-16
    80002a18:	00113423          	sd	ra,8(sp)
    80002a1c:	00813023          	sd	s0,0(sp)
    80002a20:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002a24:	00000097          	auipc	ra,0x0
    80002a28:	0a4080e7          	jalr	164(ra) # 80002ac8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002a2c:	00813083          	ld	ra,8(sp)
    80002a30:	00013403          	ld	s0,0(sp)
    80002a34:	01010113          	addi	sp,sp,16
    80002a38:	00008067          	ret

0000000080002a3c <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002a3c:	ff010113          	addi	sp,sp,-16
    80002a40:	00113423          	sd	ra,8(sp)
    80002a44:	00813023          	sd	s0,0(sp)
    80002a48:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002a4c:	00000097          	auipc	ra,0x0
    80002a50:	1e0080e7          	jalr	480(ra) # 80002c2c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002a54:	00813083          	ld	ra,8(sp)
    80002a58:	00013403          	ld	s0,0(sp)
    80002a5c:	01010113          	addi	sp,sp,16
    80002a60:	00008067          	ret

0000000080002a64 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80002a64:	fe010113          	addi	sp,sp,-32
    80002a68:	00113c23          	sd	ra,24(sp)
    80002a6c:	00813823          	sd	s0,16(sp)
    80002a70:	00913423          	sd	s1,8(sp)
    80002a74:	01213023          	sd	s2,0(sp)
    80002a78:	02010413          	addi	s0,sp,32
    80002a7c:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002a80:	00053503          	ld	a0,0(a0)
    while(curr) {
    80002a84:	02050263          	beqz	a0,80002aa8 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    80002a88:	00100793          	li	a5,1
    80002a8c:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    80002a90:	020504a3          	sb	zero,41(a0)
        return nextInList;
    80002a94:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80002a98:	fffff097          	auipc	ra,0xfffff
    80002a9c:	490080e7          	jalr	1168(ra) # 80001f28 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80002aa0:	00048513          	mv	a0,s1
    while(curr) {
    80002aa4:	fe1ff06f          	j	80002a84 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002aa8:	00093423          	sd	zero,8(s2)
    80002aac:	00093023          	sd	zero,0(s2)
}
    80002ab0:	01813083          	ld	ra,24(sp)
    80002ab4:	01013403          	ld	s0,16(sp)
    80002ab8:	00813483          	ld	s1,8(sp)
    80002abc:	00013903          	ld	s2,0(sp)
    80002ac0:	02010113          	addi	sp,sp,32
    80002ac4:	00008067          	ret

0000000080002ac8 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002ac8:	ff010113          	addi	sp,sp,-16
    80002acc:	00813423          	sd	s0,8(sp)
    80002ad0:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002ad4:	00006797          	auipc	a5,0x6
    80002ad8:	f4c7b783          	ld	a5,-180(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002adc:	02078c63          	beqz	a5,80002b14 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002ae0:	00006717          	auipc	a4,0x6
    80002ae4:	e4873703          	ld	a4,-440(a4) # 80008928 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002ae8:	00073703          	ld	a4,0(a4)
    80002aec:	12e78c63          	beq	a5,a4,80002c24 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002af0:	00850713          	addi	a4,a0,8
    80002af4:	00675813          	srli	a6,a4,0x6
    80002af8:	03f77793          	andi	a5,a4,63
    80002afc:	00f037b3          	snez	a5,a5
    80002b00:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80002b04:	00006517          	auipc	a0,0x6
    80002b08:	f1c53503          	ld	a0,-228(a0) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002b0c:	00000613          	li	a2,0
    80002b10:	0a80006f          	j	80002bb8 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80002b14:	00006697          	auipc	a3,0x6
    80002b18:	dcc6b683          	ld	a3,-564(a3) # 800088e0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002b1c:	0006b783          	ld	a5,0(a3)
    80002b20:	00006717          	auipc	a4,0x6
    80002b24:	f0f73023          	sd	a5,-256(a4) # 80008a20 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80002b28:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80002b2c:	00006717          	auipc	a4,0x6
    80002b30:	dfc73703          	ld	a4,-516(a4) # 80008928 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002b34:	00073703          	ld	a4,0(a4)
    80002b38:	0006b683          	ld	a3,0(a3)
    80002b3c:	40d70733          	sub	a4,a4,a3
    80002b40:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80002b44:	0007b823          	sd	zero,16(a5)
    80002b48:	fa9ff06f          	j	80002af0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80002b4c:	00060e63          	beqz	a2,80002b68 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002b50:	01063703          	ld	a4,16(a2)
    80002b54:	04070a63          	beqz	a4,80002ba8 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002b58:	01073703          	ld	a4,16(a4)
    80002b5c:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002b60:	00078813          	mv	a6,a5
    80002b64:	0ac0006f          	j	80002c10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002b68:	01053703          	ld	a4,16(a0)
    80002b6c:	00070a63          	beqz	a4,80002b80 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002b70:	00006697          	auipc	a3,0x6
    80002b74:	eae6b823          	sd	a4,-336(a3) # 80008a20 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002b78:	00078813          	mv	a6,a5
    80002b7c:	0940006f          	j	80002c10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002b80:	00006717          	auipc	a4,0x6
    80002b84:	da873703          	ld	a4,-600(a4) # 80008928 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002b88:	00073703          	ld	a4,0(a4)
    80002b8c:	00006697          	auipc	a3,0x6
    80002b90:	e8e6ba23          	sd	a4,-364(a3) # 80008a20 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002b94:	00078813          	mv	a6,a5
    80002b98:	0780006f          	j	80002c10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002b9c:	00006797          	auipc	a5,0x6
    80002ba0:	e8e7b223          	sd	a4,-380(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002ba4:	06c0006f          	j	80002c10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002ba8:	00078813          	mv	a6,a5
    80002bac:	0640006f          	j	80002c10 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002bb0:	00050613          	mv	a2,a0
        curr = curr->next;
    80002bb4:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002bb8:	06050063          	beqz	a0,80002c18 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002bbc:	00853783          	ld	a5,8(a0)
    80002bc0:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002bc4:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002bc8:	fee7e4e3          	bltu	a5,a4,80002bb0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002bcc:	ff06e2e3          	bltu	a3,a6,80002bb0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002bd0:	f7068ee3          	beq	a3,a6,80002b4c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002bd4:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002bd8:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002bdc:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002be0:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002be4:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002be8:	01053783          	ld	a5,16(a0)
    80002bec:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002bf0:	fa0606e3          	beqz	a2,80002b9c <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002bf4:	01063783          	ld	a5,16(a2)
    80002bf8:	00078663          	beqz	a5,80002c04 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002bfc:	0107b783          	ld	a5,16(a5)
    80002c00:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80002c04:	01063783          	ld	a5,16(a2)
    80002c08:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002c0c:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002c10:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80002c14:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80002c18:	00813403          	ld	s0,8(sp)
    80002c1c:	01010113          	addi	sp,sp,16
    80002c20:	00008067          	ret
        return nullptr;
    80002c24:	00000513          	li	a0,0
    80002c28:	ff1ff06f          	j	80002c18 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080002c2c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80002c2c:	ff010113          	addi	sp,sp,-16
    80002c30:	00813423          	sd	s0,8(sp)
    80002c34:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002c38:	16050063          	beqz	a0,80002d98 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80002c3c:	ff850713          	addi	a4,a0,-8
    80002c40:	00006797          	auipc	a5,0x6
    80002c44:	ca07b783          	ld	a5,-864(a5) # 800088e0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002c48:	0007b783          	ld	a5,0(a5)
    80002c4c:	14f76a63          	bltu	a4,a5,80002da0 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002c50:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002c54:	fff58693          	addi	a3,a1,-1
    80002c58:	00d706b3          	add	a3,a4,a3
    80002c5c:	00006617          	auipc	a2,0x6
    80002c60:	ccc63603          	ld	a2,-820(a2) # 80008928 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002c64:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002c68:	14c6f063          	bgeu	a3,a2,80002da8 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002c6c:	14070263          	beqz	a4,80002db0 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002c70:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002c74:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002c78:	14079063          	bnez	a5,80002db8 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002c7c:	03f00793          	li	a5,63
    80002c80:	14b7f063          	bgeu	a5,a1,80002dc0 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002c84:	00006797          	auipc	a5,0x6
    80002c88:	d9c7b783          	ld	a5,-612(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002c8c:	02f60063          	beq	a2,a5,80002cac <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002c90:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002c94:	02078a63          	beqz	a5,80002cc8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002c98:	0007b683          	ld	a3,0(a5)
    80002c9c:	02e6f663          	bgeu	a3,a4,80002cc8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002ca0:	00078613          	mv	a2,a5
        curr = curr->next;
    80002ca4:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002ca8:	fedff06f          	j	80002c94 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002cac:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002cb0:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002cb4:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002cb8:	00006797          	auipc	a5,0x6
    80002cbc:	d6e7b423          	sd	a4,-664(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
        return 0;
    80002cc0:	00000513          	li	a0,0
    80002cc4:	0480006f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002cc8:	04060863          	beqz	a2,80002d18 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002ccc:	00063683          	ld	a3,0(a2)
    80002cd0:	00863803          	ld	a6,8(a2)
    80002cd4:	010686b3          	add	a3,a3,a6
    80002cd8:	08e68a63          	beq	a3,a4,80002d6c <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002cdc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002ce0:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80002ce4:	01063683          	ld	a3,16(a2)
    80002ce8:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002cec:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002cf0:	0e078063          	beqz	a5,80002dd0 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80002cf4:	0007b583          	ld	a1,0(a5)
    80002cf8:	00073683          	ld	a3,0(a4)
    80002cfc:	00873603          	ld	a2,8(a4)
    80002d00:	00c686b3          	add	a3,a3,a2
    80002d04:	06d58c63          	beq	a1,a3,80002d7c <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80002d08:	00000513          	li	a0,0
}
    80002d0c:	00813403          	ld	s0,8(sp)
    80002d10:	01010113          	addi	sp,sp,16
    80002d14:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80002d18:	0a078863          	beqz	a5,80002dc8 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80002d1c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002d20:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80002d24:	00006797          	auipc	a5,0x6
    80002d28:	cfc7b783          	ld	a5,-772(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002d2c:	0007b603          	ld	a2,0(a5)
    80002d30:	00b706b3          	add	a3,a4,a1
    80002d34:	00d60c63          	beq	a2,a3,80002d4c <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80002d38:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80002d3c:	00006797          	auipc	a5,0x6
    80002d40:	cee7b223          	sd	a4,-796(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
            return 0;
    80002d44:	00000513          	li	a0,0
    80002d48:	fc5ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80002d4c:	0087b783          	ld	a5,8(a5)
    80002d50:	00b785b3          	add	a1,a5,a1
    80002d54:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80002d58:	00006797          	auipc	a5,0x6
    80002d5c:	cc87b783          	ld	a5,-824(a5) # 80008a20 <_ZN15MemoryAllocator4headE>
    80002d60:	0107b783          	ld	a5,16(a5)
    80002d64:	00f53423          	sd	a5,8(a0)
    80002d68:	fd5ff06f          	j	80002d3c <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002d6c:	00b805b3          	add	a1,a6,a1
    80002d70:	00b63423          	sd	a1,8(a2)
    80002d74:	00060713          	mv	a4,a2
    80002d78:	f79ff06f          	j	80002cf0 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002d7c:	0087b683          	ld	a3,8(a5)
    80002d80:	00d60633          	add	a2,a2,a3
    80002d84:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002d88:	0107b783          	ld	a5,16(a5)
    80002d8c:	00f73823          	sd	a5,16(a4)
    return 0;
    80002d90:	00000513          	li	a0,0
    80002d94:	f79ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002d98:	fff00513          	li	a0,-1
    80002d9c:	f71ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002da0:	fff00513          	li	a0,-1
    80002da4:	f69ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80002da8:	fff00513          	li	a0,-1
    80002dac:	f61ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002db0:	fff00513          	li	a0,-1
    80002db4:	f59ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002db8:	fff00513          	li	a0,-1
    80002dbc:	f51ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002dc0:	fff00513          	li	a0,-1
    80002dc4:	f49ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80002dc8:	fff00513          	li	a0,-1
    80002dcc:	f41ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002dd0:	00000513          	li	a0,0
    80002dd4:	f39ff06f          	j	80002d0c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002dd8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002dd8:	fe010113          	addi	sp,sp,-32
    80002ddc:	00113c23          	sd	ra,24(sp)
    80002de0:	00813823          	sd	s0,16(sp)
    80002de4:	00913423          	sd	s1,8(sp)
    80002de8:	02010413          	addi	s0,sp,32
    80002dec:	00050493          	mv	s1,a0
    LOCK();
    80002df0:	00100613          	li	a2,1
    80002df4:	00000593          	li	a1,0
    80002df8:	00006517          	auipc	a0,0x6
    80002dfc:	c3050513          	addi	a0,a0,-976 # 80008a28 <lockPrint>
    80002e00:	ffffe097          	auipc	ra,0xffffe
    80002e04:	350080e7          	jalr	848(ra) # 80001150 <copy_and_swap>
    80002e08:	fe0514e3          	bnez	a0,80002df0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002e0c:	0004c503          	lbu	a0,0(s1)
    80002e10:	00050a63          	beqz	a0,80002e24 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002e14:	ffffe097          	auipc	ra,0xffffe
    80002e18:	6c4080e7          	jalr	1732(ra) # 800014d8 <_Z4putcc>
        string++;
    80002e1c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002e20:	fedff06f          	j	80002e0c <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002e24:	00000613          	li	a2,0
    80002e28:	00100593          	li	a1,1
    80002e2c:	00006517          	auipc	a0,0x6
    80002e30:	bfc50513          	addi	a0,a0,-1028 # 80008a28 <lockPrint>
    80002e34:	ffffe097          	auipc	ra,0xffffe
    80002e38:	31c080e7          	jalr	796(ra) # 80001150 <copy_and_swap>
    80002e3c:	fe0514e3          	bnez	a0,80002e24 <_Z11printStringPKc+0x4c>
}
    80002e40:	01813083          	ld	ra,24(sp)
    80002e44:	01013403          	ld	s0,16(sp)
    80002e48:	00813483          	ld	s1,8(sp)
    80002e4c:	02010113          	addi	sp,sp,32
    80002e50:	00008067          	ret

0000000080002e54 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002e54:	fd010113          	addi	sp,sp,-48
    80002e58:	02113423          	sd	ra,40(sp)
    80002e5c:	02813023          	sd	s0,32(sp)
    80002e60:	00913c23          	sd	s1,24(sp)
    80002e64:	01213823          	sd	s2,16(sp)
    80002e68:	01313423          	sd	s3,8(sp)
    80002e6c:	01413023          	sd	s4,0(sp)
    80002e70:	03010413          	addi	s0,sp,48
    80002e74:	00050993          	mv	s3,a0
    80002e78:	00058a13          	mv	s4,a1
    LOCK();
    80002e7c:	00100613          	li	a2,1
    80002e80:	00000593          	li	a1,0
    80002e84:	00006517          	auipc	a0,0x6
    80002e88:	ba450513          	addi	a0,a0,-1116 # 80008a28 <lockPrint>
    80002e8c:	ffffe097          	auipc	ra,0xffffe
    80002e90:	2c4080e7          	jalr	708(ra) # 80001150 <copy_and_swap>
    80002e94:	fe0514e3          	bnez	a0,80002e7c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002e98:	00000913          	li	s2,0
    80002e9c:	00090493          	mv	s1,s2
    80002ea0:	0019091b          	addiw	s2,s2,1
    80002ea4:	03495a63          	bge	s2,s4,80002ed8 <_Z9getStringPci+0x84>
        cc = getc();
    80002ea8:	ffffe097          	auipc	ra,0xffffe
    80002eac:	600080e7          	jalr	1536(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80002eb0:	02050463          	beqz	a0,80002ed8 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002eb4:	009984b3          	add	s1,s3,s1
    80002eb8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002ebc:	00a00793          	li	a5,10
    80002ec0:	00f50a63          	beq	a0,a5,80002ed4 <_Z9getStringPci+0x80>
    80002ec4:	00d00793          	li	a5,13
    80002ec8:	fcf51ae3          	bne	a0,a5,80002e9c <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002ecc:	00090493          	mv	s1,s2
    80002ed0:	0080006f          	j	80002ed8 <_Z9getStringPci+0x84>
    80002ed4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002ed8:	009984b3          	add	s1,s3,s1
    80002edc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002ee0:	00000613          	li	a2,0
    80002ee4:	00100593          	li	a1,1
    80002ee8:	00006517          	auipc	a0,0x6
    80002eec:	b4050513          	addi	a0,a0,-1216 # 80008a28 <lockPrint>
    80002ef0:	ffffe097          	auipc	ra,0xffffe
    80002ef4:	260080e7          	jalr	608(ra) # 80001150 <copy_and_swap>
    80002ef8:	fe0514e3          	bnez	a0,80002ee0 <_Z9getStringPci+0x8c>
    return buf;
}
    80002efc:	00098513          	mv	a0,s3
    80002f00:	02813083          	ld	ra,40(sp)
    80002f04:	02013403          	ld	s0,32(sp)
    80002f08:	01813483          	ld	s1,24(sp)
    80002f0c:	01013903          	ld	s2,16(sp)
    80002f10:	00813983          	ld	s3,8(sp)
    80002f14:	00013a03          	ld	s4,0(sp)
    80002f18:	03010113          	addi	sp,sp,48
    80002f1c:	00008067          	ret

0000000080002f20 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002f20:	ff010113          	addi	sp,sp,-16
    80002f24:	00813423          	sd	s0,8(sp)
    80002f28:	01010413          	addi	s0,sp,16
    80002f2c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002f30:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002f34:	0006c603          	lbu	a2,0(a3)
    80002f38:	fd06071b          	addiw	a4,a2,-48
    80002f3c:	0ff77713          	andi	a4,a4,255
    80002f40:	00900793          	li	a5,9
    80002f44:	02e7e063          	bltu	a5,a4,80002f64 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002f48:	0025179b          	slliw	a5,a0,0x2
    80002f4c:	00a787bb          	addw	a5,a5,a0
    80002f50:	0017979b          	slliw	a5,a5,0x1
    80002f54:	00168693          	addi	a3,a3,1
    80002f58:	00c787bb          	addw	a5,a5,a2
    80002f5c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002f60:	fd5ff06f          	j	80002f34 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002f64:	00813403          	ld	s0,8(sp)
    80002f68:	01010113          	addi	sp,sp,16
    80002f6c:	00008067          	ret

0000000080002f70 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002f70:	fc010113          	addi	sp,sp,-64
    80002f74:	02113c23          	sd	ra,56(sp)
    80002f78:	02813823          	sd	s0,48(sp)
    80002f7c:	02913423          	sd	s1,40(sp)
    80002f80:	03213023          	sd	s2,32(sp)
    80002f84:	01313c23          	sd	s3,24(sp)
    80002f88:	04010413          	addi	s0,sp,64
    80002f8c:	00050493          	mv	s1,a0
    80002f90:	00058913          	mv	s2,a1
    80002f94:	00060993          	mv	s3,a2
    LOCK();
    80002f98:	00100613          	li	a2,1
    80002f9c:	00000593          	li	a1,0
    80002fa0:	00006517          	auipc	a0,0x6
    80002fa4:	a8850513          	addi	a0,a0,-1400 # 80008a28 <lockPrint>
    80002fa8:	ffffe097          	auipc	ra,0xffffe
    80002fac:	1a8080e7          	jalr	424(ra) # 80001150 <copy_and_swap>
    80002fb0:	fe0514e3          	bnez	a0,80002f98 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002fb4:	00098463          	beqz	s3,80002fbc <_Z8printIntiii+0x4c>
    80002fb8:	0804c463          	bltz	s1,80003040 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002fbc:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002fc0:	00000593          	li	a1,0
    }

    i = 0;
    80002fc4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002fc8:	0009079b          	sext.w	a5,s2
    80002fcc:	0325773b          	remuw	a4,a0,s2
    80002fd0:	00048613          	mv	a2,s1
    80002fd4:	0014849b          	addiw	s1,s1,1
    80002fd8:	02071693          	slli	a3,a4,0x20
    80002fdc:	0206d693          	srli	a3,a3,0x20
    80002fe0:	00006717          	auipc	a4,0x6
    80002fe4:	85070713          	addi	a4,a4,-1968 # 80008830 <digits>
    80002fe8:	00d70733          	add	a4,a4,a3
    80002fec:	00074683          	lbu	a3,0(a4)
    80002ff0:	fd040713          	addi	a4,s0,-48
    80002ff4:	00c70733          	add	a4,a4,a2
    80002ff8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002ffc:	0005071b          	sext.w	a4,a0
    80003000:	0325553b          	divuw	a0,a0,s2
    80003004:	fcf772e3          	bgeu	a4,a5,80002fc8 <_Z8printIntiii+0x58>
    if(neg)
    80003008:	00058c63          	beqz	a1,80003020 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000300c:	fd040793          	addi	a5,s0,-48
    80003010:	009784b3          	add	s1,a5,s1
    80003014:	02d00793          	li	a5,45
    80003018:	fef48823          	sb	a5,-16(s1)
    8000301c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003020:	fff4849b          	addiw	s1,s1,-1
    80003024:	0204c463          	bltz	s1,8000304c <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80003028:	fd040793          	addi	a5,s0,-48
    8000302c:	009787b3          	add	a5,a5,s1
    80003030:	ff07c503          	lbu	a0,-16(a5)
    80003034:	ffffe097          	auipc	ra,0xffffe
    80003038:	4a4080e7          	jalr	1188(ra) # 800014d8 <_Z4putcc>
    8000303c:	fe5ff06f          	j	80003020 <_Z8printIntiii+0xb0>
        x = -xx;
    80003040:	4090053b          	negw	a0,s1
        neg = 1;
    80003044:	00100593          	li	a1,1
        x = -xx;
    80003048:	f7dff06f          	j	80002fc4 <_Z8printIntiii+0x54>

    UNLOCK();
    8000304c:	00000613          	li	a2,0
    80003050:	00100593          	li	a1,1
    80003054:	00006517          	auipc	a0,0x6
    80003058:	9d450513          	addi	a0,a0,-1580 # 80008a28 <lockPrint>
    8000305c:	ffffe097          	auipc	ra,0xffffe
    80003060:	0f4080e7          	jalr	244(ra) # 80001150 <copy_and_swap>
    80003064:	fe0514e3          	bnez	a0,8000304c <_Z8printIntiii+0xdc>
    80003068:	03813083          	ld	ra,56(sp)
    8000306c:	03013403          	ld	s0,48(sp)
    80003070:	02813483          	ld	s1,40(sp)
    80003074:	02013903          	ld	s2,32(sp)
    80003078:	01813983          	ld	s3,24(sp)
    8000307c:	04010113          	addi	sp,sp,64
    80003080:	00008067          	ret

0000000080003084 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003084:	fd010113          	addi	sp,sp,-48
    80003088:	02113423          	sd	ra,40(sp)
    8000308c:	02813023          	sd	s0,32(sp)
    80003090:	00913c23          	sd	s1,24(sp)
    80003094:	01213823          	sd	s2,16(sp)
    80003098:	01313423          	sd	s3,8(sp)
    8000309c:	03010413          	addi	s0,sp,48
    800030a0:	00050493          	mv	s1,a0
    800030a4:	00058913          	mv	s2,a1
    800030a8:	0015879b          	addiw	a5,a1,1
    800030ac:	0007851b          	sext.w	a0,a5
    800030b0:	00f4a023          	sw	a5,0(s1)
    800030b4:	0004a823          	sw	zero,16(s1)
    800030b8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800030bc:	00251513          	slli	a0,a0,0x2
    800030c0:	ffffe097          	auipc	ra,0xffffe
    800030c4:	0d4080e7          	jalr	212(ra) # 80001194 <_Z9mem_allocm>
    800030c8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800030cc:	01000513          	li	a0,16
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	5c0080e7          	jalr	1472(ra) # 80002690 <_ZN9SemaphorenwEm>
    800030d8:	00050993          	mv	s3,a0
    800030dc:	00000593          	li	a1,0
    800030e0:	fffff097          	auipc	ra,0xfffff
    800030e4:	490080e7          	jalr	1168(ra) # 80002570 <_ZN9SemaphoreC1Ej>
    800030e8:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800030ec:	01000513          	li	a0,16
    800030f0:	fffff097          	auipc	ra,0xfffff
    800030f4:	5a0080e7          	jalr	1440(ra) # 80002690 <_ZN9SemaphorenwEm>
    800030f8:	00050993          	mv	s3,a0
    800030fc:	00090593          	mv	a1,s2
    80003100:	fffff097          	auipc	ra,0xfffff
    80003104:	470080e7          	jalr	1136(ra) # 80002570 <_ZN9SemaphoreC1Ej>
    80003108:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    8000310c:	01000513          	li	a0,16
    80003110:	fffff097          	auipc	ra,0xfffff
    80003114:	580080e7          	jalr	1408(ra) # 80002690 <_ZN9SemaphorenwEm>
    80003118:	00050913          	mv	s2,a0
    8000311c:	00100593          	li	a1,1
    80003120:	fffff097          	auipc	ra,0xfffff
    80003124:	450080e7          	jalr	1104(ra) # 80002570 <_ZN9SemaphoreC1Ej>
    80003128:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000312c:	01000513          	li	a0,16
    80003130:	fffff097          	auipc	ra,0xfffff
    80003134:	560080e7          	jalr	1376(ra) # 80002690 <_ZN9SemaphorenwEm>
    80003138:	00050913          	mv	s2,a0
    8000313c:	00100593          	li	a1,1
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	430080e7          	jalr	1072(ra) # 80002570 <_ZN9SemaphoreC1Ej>
    80003148:	0324b823          	sd	s2,48(s1)
}
    8000314c:	02813083          	ld	ra,40(sp)
    80003150:	02013403          	ld	s0,32(sp)
    80003154:	01813483          	ld	s1,24(sp)
    80003158:	01013903          	ld	s2,16(sp)
    8000315c:	00813983          	ld	s3,8(sp)
    80003160:	03010113          	addi	sp,sp,48
    80003164:	00008067          	ret
    80003168:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000316c:	00098513          	mv	a0,s3
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	4b8080e7          	jalr	1208(ra) # 80002628 <_ZN9SemaphoredlEPv>
    80003178:	00048513          	mv	a0,s1
    8000317c:	00007097          	auipc	ra,0x7
    80003180:	98c080e7          	jalr	-1652(ra) # 80009b08 <_Unwind_Resume>
    80003184:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80003188:	00098513          	mv	a0,s3
    8000318c:	fffff097          	auipc	ra,0xfffff
    80003190:	49c080e7          	jalr	1180(ra) # 80002628 <_ZN9SemaphoredlEPv>
    80003194:	00048513          	mv	a0,s1
    80003198:	00007097          	auipc	ra,0x7
    8000319c:	970080e7          	jalr	-1680(ra) # 80009b08 <_Unwind_Resume>
    800031a0:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800031a4:	00090513          	mv	a0,s2
    800031a8:	fffff097          	auipc	ra,0xfffff
    800031ac:	480080e7          	jalr	1152(ra) # 80002628 <_ZN9SemaphoredlEPv>
    800031b0:	00048513          	mv	a0,s1
    800031b4:	00007097          	auipc	ra,0x7
    800031b8:	954080e7          	jalr	-1708(ra) # 80009b08 <_Unwind_Resume>
    800031bc:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800031c0:	00090513          	mv	a0,s2
    800031c4:	fffff097          	auipc	ra,0xfffff
    800031c8:	464080e7          	jalr	1124(ra) # 80002628 <_ZN9SemaphoredlEPv>
    800031cc:	00048513          	mv	a0,s1
    800031d0:	00007097          	auipc	ra,0x7
    800031d4:	938080e7          	jalr	-1736(ra) # 80009b08 <_Unwind_Resume>

00000000800031d8 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800031d8:	fe010113          	addi	sp,sp,-32
    800031dc:	00113c23          	sd	ra,24(sp)
    800031e0:	00813823          	sd	s0,16(sp)
    800031e4:	00913423          	sd	s1,8(sp)
    800031e8:	01213023          	sd	s2,0(sp)
    800031ec:	02010413          	addi	s0,sp,32
    800031f0:	00050493          	mv	s1,a0
    800031f4:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800031f8:	01853503          	ld	a0,24(a0)
    800031fc:	fffff097          	auipc	ra,0xfffff
    80003200:	3d4080e7          	jalr	980(ra) # 800025d0 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003204:	0304b503          	ld	a0,48(s1)
    80003208:	fffff097          	auipc	ra,0xfffff
    8000320c:	3c8080e7          	jalr	968(ra) # 800025d0 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003210:	0084b783          	ld	a5,8(s1)
    80003214:	0144a703          	lw	a4,20(s1)
    80003218:	00271713          	slli	a4,a4,0x2
    8000321c:	00e787b3          	add	a5,a5,a4
    80003220:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003224:	0144a783          	lw	a5,20(s1)
    80003228:	0017879b          	addiw	a5,a5,1
    8000322c:	0004a703          	lw	a4,0(s1)
    80003230:	02e7e7bb          	remw	a5,a5,a4
    80003234:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80003238:	0304b503          	ld	a0,48(s1)
    8000323c:	fffff097          	auipc	ra,0xfffff
    80003240:	3c0080e7          	jalr	960(ra) # 800025fc <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80003244:	0204b503          	ld	a0,32(s1)
    80003248:	fffff097          	auipc	ra,0xfffff
    8000324c:	3b4080e7          	jalr	948(ra) # 800025fc <_ZN9Semaphore6signalEv>

}
    80003250:	01813083          	ld	ra,24(sp)
    80003254:	01013403          	ld	s0,16(sp)
    80003258:	00813483          	ld	s1,8(sp)
    8000325c:	00013903          	ld	s2,0(sp)
    80003260:	02010113          	addi	sp,sp,32
    80003264:	00008067          	ret

0000000080003268 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003268:	fe010113          	addi	sp,sp,-32
    8000326c:	00113c23          	sd	ra,24(sp)
    80003270:	00813823          	sd	s0,16(sp)
    80003274:	00913423          	sd	s1,8(sp)
    80003278:	01213023          	sd	s2,0(sp)
    8000327c:	02010413          	addi	s0,sp,32
    80003280:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003284:	02053503          	ld	a0,32(a0)
    80003288:	fffff097          	auipc	ra,0xfffff
    8000328c:	348080e7          	jalr	840(ra) # 800025d0 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003290:	0284b503          	ld	a0,40(s1)
    80003294:	fffff097          	auipc	ra,0xfffff
    80003298:	33c080e7          	jalr	828(ra) # 800025d0 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000329c:	0084b703          	ld	a4,8(s1)
    800032a0:	0104a783          	lw	a5,16(s1)
    800032a4:	00279693          	slli	a3,a5,0x2
    800032a8:	00d70733          	add	a4,a4,a3
    800032ac:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800032b0:	0017879b          	addiw	a5,a5,1
    800032b4:	0004a703          	lw	a4,0(s1)
    800032b8:	02e7e7bb          	remw	a5,a5,a4
    800032bc:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800032c0:	0284b503          	ld	a0,40(s1)
    800032c4:	fffff097          	auipc	ra,0xfffff
    800032c8:	338080e7          	jalr	824(ra) # 800025fc <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800032cc:	0184b503          	ld	a0,24(s1)
    800032d0:	fffff097          	auipc	ra,0xfffff
    800032d4:	32c080e7          	jalr	812(ra) # 800025fc <_ZN9Semaphore6signalEv>

    return ret;
}
    800032d8:	00090513          	mv	a0,s2
    800032dc:	01813083          	ld	ra,24(sp)
    800032e0:	01013403          	ld	s0,16(sp)
    800032e4:	00813483          	ld	s1,8(sp)
    800032e8:	00013903          	ld	s2,0(sp)
    800032ec:	02010113          	addi	sp,sp,32
    800032f0:	00008067          	ret

00000000800032f4 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800032f4:	fe010113          	addi	sp,sp,-32
    800032f8:	00113c23          	sd	ra,24(sp)
    800032fc:	00813823          	sd	s0,16(sp)
    80003300:	00913423          	sd	s1,8(sp)
    80003304:	01213023          	sd	s2,0(sp)
    80003308:	02010413          	addi	s0,sp,32
    8000330c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80003310:	02853503          	ld	a0,40(a0)
    80003314:	fffff097          	auipc	ra,0xfffff
    80003318:	2bc080e7          	jalr	700(ra) # 800025d0 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000331c:	0304b503          	ld	a0,48(s1)
    80003320:	fffff097          	auipc	ra,0xfffff
    80003324:	2b0080e7          	jalr	688(ra) # 800025d0 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80003328:	0144a783          	lw	a5,20(s1)
    8000332c:	0104a903          	lw	s2,16(s1)
    80003330:	0327ce63          	blt	a5,s2,8000336c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80003334:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80003338:	0304b503          	ld	a0,48(s1)
    8000333c:	fffff097          	auipc	ra,0xfffff
    80003340:	2c0080e7          	jalr	704(ra) # 800025fc <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80003344:	0284b503          	ld	a0,40(s1)
    80003348:	fffff097          	auipc	ra,0xfffff
    8000334c:	2b4080e7          	jalr	692(ra) # 800025fc <_ZN9Semaphore6signalEv>

    return ret;
}
    80003350:	00090513          	mv	a0,s2
    80003354:	01813083          	ld	ra,24(sp)
    80003358:	01013403          	ld	s0,16(sp)
    8000335c:	00813483          	ld	s1,8(sp)
    80003360:	00013903          	ld	s2,0(sp)
    80003364:	02010113          	addi	sp,sp,32
    80003368:	00008067          	ret
        ret = cap - head + tail;
    8000336c:	0004a703          	lw	a4,0(s1)
    80003370:	4127093b          	subw	s2,a4,s2
    80003374:	00f9093b          	addw	s2,s2,a5
    80003378:	fc1ff06f          	j	80003338 <_ZN9BufferCPP6getCntEv+0x44>

000000008000337c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000337c:	fe010113          	addi	sp,sp,-32
    80003380:	00113c23          	sd	ra,24(sp)
    80003384:	00813823          	sd	s0,16(sp)
    80003388:	00913423          	sd	s1,8(sp)
    8000338c:	02010413          	addi	s0,sp,32
    80003390:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003394:	00a00513          	li	a0,10
    80003398:	fffff097          	auipc	ra,0xfffff
    8000339c:	3c4080e7          	jalr	964(ra) # 8000275c <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800033a0:	00004517          	auipc	a0,0x4
    800033a4:	d9050513          	addi	a0,a0,-624 # 80007130 <CONSOLE_STATUS+0x120>
    800033a8:	00000097          	auipc	ra,0x0
    800033ac:	a30080e7          	jalr	-1488(ra) # 80002dd8 <_Z11printStringPKc>
    while (getCnt()) {
    800033b0:	00048513          	mv	a0,s1
    800033b4:	00000097          	auipc	ra,0x0
    800033b8:	f40080e7          	jalr	-192(ra) # 800032f4 <_ZN9BufferCPP6getCntEv>
    800033bc:	02050c63          	beqz	a0,800033f4 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800033c0:	0084b783          	ld	a5,8(s1)
    800033c4:	0104a703          	lw	a4,16(s1)
    800033c8:	00271713          	slli	a4,a4,0x2
    800033cc:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800033d0:	0007c503          	lbu	a0,0(a5)
    800033d4:	fffff097          	auipc	ra,0xfffff
    800033d8:	388080e7          	jalr	904(ra) # 8000275c <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800033dc:	0104a783          	lw	a5,16(s1)
    800033e0:	0017879b          	addiw	a5,a5,1
    800033e4:	0004a703          	lw	a4,0(s1)
    800033e8:	02e7e7bb          	remw	a5,a5,a4
    800033ec:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800033f0:	fc1ff06f          	j	800033b0 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800033f4:	02100513          	li	a0,33
    800033f8:	fffff097          	auipc	ra,0xfffff
    800033fc:	364080e7          	jalr	868(ra) # 8000275c <_ZN7Console4putcEc>
    Console::putc('\n');
    80003400:	00a00513          	li	a0,10
    80003404:	fffff097          	auipc	ra,0xfffff
    80003408:	358080e7          	jalr	856(ra) # 8000275c <_ZN7Console4putcEc>
    mem_free(buffer);
    8000340c:	0084b503          	ld	a0,8(s1)
    80003410:	ffffe097          	auipc	ra,0xffffe
    80003414:	dc4080e7          	jalr	-572(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80003418:	0204b503          	ld	a0,32(s1)
    8000341c:	00050863          	beqz	a0,8000342c <_ZN9BufferCPPD1Ev+0xb0>
    80003420:	00053783          	ld	a5,0(a0)
    80003424:	0087b783          	ld	a5,8(a5)
    80003428:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000342c:	0184b503          	ld	a0,24(s1)
    80003430:	00050863          	beqz	a0,80003440 <_ZN9BufferCPPD1Ev+0xc4>
    80003434:	00053783          	ld	a5,0(a0)
    80003438:	0087b783          	ld	a5,8(a5)
    8000343c:	000780e7          	jalr	a5
    delete mutexTail;
    80003440:	0304b503          	ld	a0,48(s1)
    80003444:	00050863          	beqz	a0,80003454 <_ZN9BufferCPPD1Ev+0xd8>
    80003448:	00053783          	ld	a5,0(a0)
    8000344c:	0087b783          	ld	a5,8(a5)
    80003450:	000780e7          	jalr	a5
    delete mutexHead;
    80003454:	0284b503          	ld	a0,40(s1)
    80003458:	00050863          	beqz	a0,80003468 <_ZN9BufferCPPD1Ev+0xec>
    8000345c:	00053783          	ld	a5,0(a0)
    80003460:	0087b783          	ld	a5,8(a5)
    80003464:	000780e7          	jalr	a5
}
    80003468:	01813083          	ld	ra,24(sp)
    8000346c:	01013403          	ld	s0,16(sp)
    80003470:	00813483          	ld	s1,8(sp)
    80003474:	02010113          	addi	sp,sp,32
    80003478:	00008067          	ret

000000008000347c <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    8000347c:	f8010113          	addi	sp,sp,-128
    80003480:	06113c23          	sd	ra,120(sp)
    80003484:	06813823          	sd	s0,112(sp)
    80003488:	06913423          	sd	s1,104(sp)
    8000348c:	07213023          	sd	s2,96(sp)
    80003490:	05313c23          	sd	s3,88(sp)
    80003494:	05413823          	sd	s4,80(sp)
    80003498:	05513423          	sd	s5,72(sp)
    8000349c:	05613023          	sd	s6,64(sp)
    800034a0:	03713c23          	sd	s7,56(sp)
    800034a4:	03813823          	sd	s8,48(sp)
    800034a8:	03913423          	sd	s9,40(sp)
    800034ac:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    800034b0:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    800034b4:	00004517          	auipc	a0,0x4
    800034b8:	c9450513          	addi	a0,a0,-876 # 80007148 <CONSOLE_STATUS+0x138>
    800034bc:	00000097          	auipc	ra,0x0
    800034c0:	91c080e7          	jalr	-1764(ra) # 80002dd8 <_Z11printStringPKc>
        getString(input, 30);
    800034c4:	01e00593          	li	a1,30
    800034c8:	f8040493          	addi	s1,s0,-128
    800034cc:	00048513          	mv	a0,s1
    800034d0:	00000097          	auipc	ra,0x0
    800034d4:	984080e7          	jalr	-1660(ra) # 80002e54 <_Z9getStringPci>
        threadNum = stringToInt(input);
    800034d8:	00048513          	mv	a0,s1
    800034dc:	00000097          	auipc	ra,0x0
    800034e0:	a44080e7          	jalr	-1468(ra) # 80002f20 <_Z11stringToIntPKc>
    800034e4:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    800034e8:	00004517          	auipc	a0,0x4
    800034ec:	c8050513          	addi	a0,a0,-896 # 80007168 <CONSOLE_STATUS+0x158>
    800034f0:	00000097          	auipc	ra,0x0
    800034f4:	8e8080e7          	jalr	-1816(ra) # 80002dd8 <_Z11printStringPKc>
        getString(input, 30);
    800034f8:	01e00593          	li	a1,30
    800034fc:	00048513          	mv	a0,s1
    80003500:	00000097          	auipc	ra,0x0
    80003504:	954080e7          	jalr	-1708(ra) # 80002e54 <_Z9getStringPci>
        n = stringToInt(input);
    80003508:	00048513          	mv	a0,s1
    8000350c:	00000097          	auipc	ra,0x0
    80003510:	a14080e7          	jalr	-1516(ra) # 80002f20 <_Z11stringToIntPKc>
    80003514:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80003518:	00004517          	auipc	a0,0x4
    8000351c:	c7050513          	addi	a0,a0,-912 # 80007188 <CONSOLE_STATUS+0x178>
    80003520:	00000097          	auipc	ra,0x0
    80003524:	8b8080e7          	jalr	-1864(ra) # 80002dd8 <_Z11printStringPKc>
    80003528:	00000613          	li	a2,0
    8000352c:	00a00593          	li	a1,10
    80003530:	00098513          	mv	a0,s3
    80003534:	00000097          	auipc	ra,0x0
    80003538:	a3c080e7          	jalr	-1476(ra) # 80002f70 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000353c:	00004517          	auipc	a0,0x4
    80003540:	c6450513          	addi	a0,a0,-924 # 800071a0 <CONSOLE_STATUS+0x190>
    80003544:	00000097          	auipc	ra,0x0
    80003548:	894080e7          	jalr	-1900(ra) # 80002dd8 <_Z11printStringPKc>
    8000354c:	00000613          	li	a2,0
    80003550:	00a00593          	li	a1,10
    80003554:	00048513          	mv	a0,s1
    80003558:	00000097          	auipc	ra,0x0
    8000355c:	a18080e7          	jalr	-1512(ra) # 80002f70 <_Z8printIntiii>
        printString(".\n");
    80003560:	00004517          	auipc	a0,0x4
    80003564:	c5850513          	addi	a0,a0,-936 # 800071b8 <CONSOLE_STATUS+0x1a8>
    80003568:	00000097          	auipc	ra,0x0
    8000356c:	870080e7          	jalr	-1936(ra) # 80002dd8 <_Z11printStringPKc>
        if(threadNum > n) {
    80003570:	0334c463          	blt	s1,s3,80003598 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80003574:	03305c63          	blez	s3,800035ac <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80003578:	03800513          	li	a0,56
    8000357c:	fffff097          	auipc	ra,0xfffff
    80003580:	ce8080e7          	jalr	-792(ra) # 80002264 <_Znwm>
    80003584:	00050a93          	mv	s5,a0
    80003588:	00048593          	mv	a1,s1
    8000358c:	00000097          	auipc	ra,0x0
    80003590:	af8080e7          	jalr	-1288(ra) # 80003084 <_ZN9BufferCPPC1Ei>
    80003594:	0300006f          	j	800035c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003598:	00004517          	auipc	a0,0x4
    8000359c:	c2850513          	addi	a0,a0,-984 # 800071c0 <CONSOLE_STATUS+0x1b0>
    800035a0:	00000097          	auipc	ra,0x0
    800035a4:	838080e7          	jalr	-1992(ra) # 80002dd8 <_Z11printStringPKc>
            return;
    800035a8:	0140006f          	j	800035bc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    800035ac:	00004517          	auipc	a0,0x4
    800035b0:	c5450513          	addi	a0,a0,-940 # 80007200 <CONSOLE_STATUS+0x1f0>
    800035b4:	00000097          	auipc	ra,0x0
    800035b8:	824080e7          	jalr	-2012(ra) # 80002dd8 <_Z11printStringPKc>
            return;
    800035bc:	000c0113          	mv	sp,s8
    800035c0:	21c0006f          	j	800037dc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    800035c4:	01000513          	li	a0,16
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	0c8080e7          	jalr	200(ra) # 80002690 <_ZN9SemaphorenwEm>
    800035d0:	00050493          	mv	s1,a0
    800035d4:	00000593          	li	a1,0
    800035d8:	fffff097          	auipc	ra,0xfffff
    800035dc:	f98080e7          	jalr	-104(ra) # 80002570 <_ZN9SemaphoreC1Ej>
    800035e0:	00005717          	auipc	a4,0x5
    800035e4:	45070713          	addi	a4,a4,1104 # 80008a30 <_ZN19ConsumerProducerCPP9threadEndE>
    800035e8:	00973423          	sd	s1,8(a4)
        Thread *producers[threadNum];
    800035ec:	00399793          	slli	a5,s3,0x3
    800035f0:	00f78793          	addi	a5,a5,15
    800035f4:	ff07f793          	andi	a5,a5,-16
    800035f8:	40f10133          	sub	sp,sp,a5
    800035fc:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80003600:	0019869b          	addiw	a3,s3,1
    80003604:	00169793          	slli	a5,a3,0x1
    80003608:	00d787b3          	add	a5,a5,a3
    8000360c:	00379793          	slli	a5,a5,0x3
    80003610:	00f78793          	addi	a5,a5,15
    80003614:	ff07f793          	andi	a5,a5,-16
    80003618:	40f10133          	sub	sp,sp,a5
    8000361c:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80003620:	00199493          	slli	s1,s3,0x1
    80003624:	013484b3          	add	s1,s1,s3
    80003628:	00349493          	slli	s1,s1,0x3
    8000362c:	009b04b3          	add	s1,s6,s1
    80003630:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80003634:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80003638:	00873783          	ld	a5,8(a4)
    8000363c:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80003640:	01800513          	li	a0,24
    80003644:	fffff097          	auipc	ra,0xfffff
    80003648:	d5c080e7          	jalr	-676(ra) # 800023a0 <_ZN6ThreadnwEm>
    8000364c:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80003650:	fffff097          	auipc	ra,0xfffff
    80003654:	e38080e7          	jalr	-456(ra) # 80002488 <_ZN6ThreadC1Ev>
    80003658:	00005797          	auipc	a5,0x5
    8000365c:	25078793          	addi	a5,a5,592 # 800088a8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80003660:	00fbb023          	sd	a5,0(s7)
    80003664:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80003668:	000b8513          	mv	a0,s7
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	dec080e7          	jalr	-532(ra) # 80002458 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80003674:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80003678:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    8000367c:	00005797          	auipc	a5,0x5
    80003680:	3bc7b783          	ld	a5,956(a5) # 80008a38 <_ZN19ConsumerProducerCPP10waitForAllE>
    80003684:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80003688:	01800513          	li	a0,24
    8000368c:	fffff097          	auipc	ra,0xfffff
    80003690:	d14080e7          	jalr	-748(ra) # 800023a0 <_ZN6ThreadnwEm>
    80003694:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80003698:	fffff097          	auipc	ra,0xfffff
    8000369c:	df0080e7          	jalr	-528(ra) # 80002488 <_ZN6ThreadC1Ev>
    800036a0:	00005797          	auipc	a5,0x5
    800036a4:	1b878793          	addi	a5,a5,440 # 80008858 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800036a8:	00f4b023          	sd	a5,0(s1)
    800036ac:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    800036b0:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    800036b4:	00048513          	mv	a0,s1
    800036b8:	fffff097          	auipc	ra,0xfffff
    800036bc:	da0080e7          	jalr	-608(ra) # 80002458 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800036c0:	00100913          	li	s2,1
    800036c4:	0300006f          	j	800036f4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800036c8:	00005797          	auipc	a5,0x5
    800036cc:	1b878793          	addi	a5,a5,440 # 80008880 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800036d0:	00fcb023          	sd	a5,0(s9)
    800036d4:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    800036d8:	00391793          	slli	a5,s2,0x3
    800036dc:	00fa07b3          	add	a5,s4,a5
    800036e0:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    800036e4:	000c8513          	mv	a0,s9
    800036e8:	fffff097          	auipc	ra,0xfffff
    800036ec:	d70080e7          	jalr	-656(ra) # 80002458 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800036f0:	0019091b          	addiw	s2,s2,1
    800036f4:	05395263          	bge	s2,s3,80003738 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    800036f8:	00191493          	slli	s1,s2,0x1
    800036fc:	012484b3          	add	s1,s1,s2
    80003700:	00349493          	slli	s1,s1,0x3
    80003704:	009b04b3          	add	s1,s6,s1
    80003708:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    8000370c:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80003710:	00005797          	auipc	a5,0x5
    80003714:	3287b783          	ld	a5,808(a5) # 80008a38 <_ZN19ConsumerProducerCPP10waitForAllE>
    80003718:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    8000371c:	01800513          	li	a0,24
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	c80080e7          	jalr	-896(ra) # 800023a0 <_ZN6ThreadnwEm>
    80003728:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000372c:	fffff097          	auipc	ra,0xfffff
    80003730:	d5c080e7          	jalr	-676(ra) # 80002488 <_ZN6ThreadC1Ev>
    80003734:	f95ff06f          	j	800036c8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80003738:	fffff097          	auipc	ra,0xfffff
    8000373c:	cf8080e7          	jalr	-776(ra) # 80002430 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80003740:	00000493          	li	s1,0
    80003744:	0099ce63          	blt	s3,s1,80003760 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80003748:	00005517          	auipc	a0,0x5
    8000374c:	2f053503          	ld	a0,752(a0) # 80008a38 <_ZN19ConsumerProducerCPP10waitForAllE>
    80003750:	fffff097          	auipc	ra,0xfffff
    80003754:	e80080e7          	jalr	-384(ra) # 800025d0 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80003758:	0014849b          	addiw	s1,s1,1
    8000375c:	fe9ff06f          	j	80003744 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80003760:	00005517          	auipc	a0,0x5
    80003764:	2d853503          	ld	a0,728(a0) # 80008a38 <_ZN19ConsumerProducerCPP10waitForAllE>
    80003768:	00050863          	beqz	a0,80003778 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    8000376c:	00053783          	ld	a5,0(a0)
    80003770:	0087b783          	ld	a5,8(a5)
    80003774:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80003778:	00000493          	li	s1,0
    8000377c:	0080006f          	j	80003784 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80003780:	0014849b          	addiw	s1,s1,1
    80003784:	0334d263          	bge	s1,s3,800037a8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80003788:	00349793          	slli	a5,s1,0x3
    8000378c:	00fa07b3          	add	a5,s4,a5
    80003790:	0007b503          	ld	a0,0(a5)
    80003794:	fe0506e3          	beqz	a0,80003780 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80003798:	00053783          	ld	a5,0(a0)
    8000379c:	0087b783          	ld	a5,8(a5)
    800037a0:	000780e7          	jalr	a5
    800037a4:	fddff06f          	j	80003780 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    800037a8:	000b8a63          	beqz	s7,800037bc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    800037ac:	000bb783          	ld	a5,0(s7)
    800037b0:	0087b783          	ld	a5,8(a5)
    800037b4:	000b8513          	mv	a0,s7
    800037b8:	000780e7          	jalr	a5
        delete buffer;
    800037bc:	000a8e63          	beqz	s5,800037d8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800037c0:	000a8513          	mv	a0,s5
    800037c4:	00000097          	auipc	ra,0x0
    800037c8:	bb8080e7          	jalr	-1096(ra) # 8000337c <_ZN9BufferCPPD1Ev>
    800037cc:	000a8513          	mv	a0,s5
    800037d0:	fffff097          	auipc	ra,0xfffff
    800037d4:	ae4080e7          	jalr	-1308(ra) # 800022b4 <_ZdlPv>
    800037d8:	000c0113          	mv	sp,s8
    }
    800037dc:	f8040113          	addi	sp,s0,-128
    800037e0:	07813083          	ld	ra,120(sp)
    800037e4:	07013403          	ld	s0,112(sp)
    800037e8:	06813483          	ld	s1,104(sp)
    800037ec:	06013903          	ld	s2,96(sp)
    800037f0:	05813983          	ld	s3,88(sp)
    800037f4:	05013a03          	ld	s4,80(sp)
    800037f8:	04813a83          	ld	s5,72(sp)
    800037fc:	04013b03          	ld	s6,64(sp)
    80003800:	03813b83          	ld	s7,56(sp)
    80003804:	03013c03          	ld	s8,48(sp)
    80003808:	02813c83          	ld	s9,40(sp)
    8000380c:	08010113          	addi	sp,sp,128
    80003810:	00008067          	ret
    80003814:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80003818:	000a8513          	mv	a0,s5
    8000381c:	fffff097          	auipc	ra,0xfffff
    80003820:	a98080e7          	jalr	-1384(ra) # 800022b4 <_ZdlPv>
    80003824:	00048513          	mv	a0,s1
    80003828:	00006097          	auipc	ra,0x6
    8000382c:	2e0080e7          	jalr	736(ra) # 80009b08 <_Unwind_Resume>
    80003830:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80003834:	00048513          	mv	a0,s1
    80003838:	fffff097          	auipc	ra,0xfffff
    8000383c:	df0080e7          	jalr	-528(ra) # 80002628 <_ZN9SemaphoredlEPv>
    80003840:	00090513          	mv	a0,s2
    80003844:	00006097          	auipc	ra,0x6
    80003848:	2c4080e7          	jalr	708(ra) # 80009b08 <_Unwind_Resume>
    8000384c:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80003850:	000b8513          	mv	a0,s7
    80003854:	fffff097          	auipc	ra,0xfffff
    80003858:	b74080e7          	jalr	-1164(ra) # 800023c8 <_ZN6ThreaddlEPv>
    8000385c:	00048513          	mv	a0,s1
    80003860:	00006097          	auipc	ra,0x6
    80003864:	2a8080e7          	jalr	680(ra) # 80009b08 <_Unwind_Resume>
    80003868:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000386c:	00048513          	mv	a0,s1
    80003870:	fffff097          	auipc	ra,0xfffff
    80003874:	b58080e7          	jalr	-1192(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80003878:	00090513          	mv	a0,s2
    8000387c:	00006097          	auipc	ra,0x6
    80003880:	28c080e7          	jalr	652(ra) # 80009b08 <_Unwind_Resume>
    80003884:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80003888:	000c8513          	mv	a0,s9
    8000388c:	fffff097          	auipc	ra,0xfffff
    80003890:	b3c080e7          	jalr	-1220(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80003894:	00048513          	mv	a0,s1
    80003898:	00006097          	auipc	ra,0x6
    8000389c:	270080e7          	jalr	624(ra) # 80009b08 <_Unwind_Resume>

00000000800038a0 <_Z8userMainv>:
//#include "../test/ConsumerProducer_CPP_Sync_API_test.hpp" // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//#include "../test/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta

void userMain() {
    800038a0:	ff010113          	addi	sp,sp,-16
    800038a4:	00113423          	sd	ra,8(sp)
    800038a8:	00813023          	sd	s0,0(sp)
    800038ac:	01010413          	addi	s0,sp,16

    //producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    800038b0:	00000097          	auipc	ra,0x0
    800038b4:	bcc080e7          	jalr	-1076(ra) # 8000347c <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    800038b8:	00813083          	ld	ra,8(sp)
    800038bc:	00013403          	ld	s0,0(sp)
    800038c0:	01010113          	addi	sp,sp,16
    800038c4:	00008067          	ret

00000000800038c8 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    800038c8:	fd010113          	addi	sp,sp,-48
    800038cc:	02113423          	sd	ra,40(sp)
    800038d0:	02813023          	sd	s0,32(sp)
    800038d4:	00913c23          	sd	s1,24(sp)
    800038d8:	01213823          	sd	s2,16(sp)
    800038dc:	01313423          	sd	s3,8(sp)
    800038e0:	03010413          	addi	s0,sp,48
    800038e4:	00050913          	mv	s2,a0
            int i = 0;
    800038e8:	00000993          	li	s3,0
    800038ec:	0100006f          	j	800038fc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    800038f0:	00a00513          	li	a0,10
    800038f4:	fffff097          	auipc	ra,0xfffff
    800038f8:	e68080e7          	jalr	-408(ra) # 8000275c <_ZN7Console4putcEc>
            while (!threadEnd) {
    800038fc:	00005797          	auipc	a5,0x5
    80003900:	1347a783          	lw	a5,308(a5) # 80008a30 <_ZN19ConsumerProducerCPP9threadEndE>
    80003904:	04079a63          	bnez	a5,80003958 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80003908:	01093783          	ld	a5,16(s2)
    8000390c:	0087b503          	ld	a0,8(a5)
    80003910:	00000097          	auipc	ra,0x0
    80003914:	958080e7          	jalr	-1704(ra) # 80003268 <_ZN9BufferCPP3getEv>
                i++;
    80003918:	0019849b          	addiw	s1,s3,1
    8000391c:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80003920:	0ff57513          	andi	a0,a0,255
    80003924:	fffff097          	auipc	ra,0xfffff
    80003928:	e38080e7          	jalr	-456(ra) # 8000275c <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000392c:	05000793          	li	a5,80
    80003930:	02f4e4bb          	remw	s1,s1,a5
    80003934:	fc0494e3          	bnez	s1,800038fc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80003938:	fb9ff06f          	j	800038f0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000393c:	01093783          	ld	a5,16(s2)
    80003940:	0087b503          	ld	a0,8(a5)
    80003944:	00000097          	auipc	ra,0x0
    80003948:	924080e7          	jalr	-1756(ra) # 80003268 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000394c:	0ff57513          	andi	a0,a0,255
    80003950:	fffff097          	auipc	ra,0xfffff
    80003954:	e0c080e7          	jalr	-500(ra) # 8000275c <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80003958:	01093783          	ld	a5,16(s2)
    8000395c:	0087b503          	ld	a0,8(a5)
    80003960:	00000097          	auipc	ra,0x0
    80003964:	994080e7          	jalr	-1644(ra) # 800032f4 <_ZN9BufferCPP6getCntEv>
    80003968:	fca04ae3          	bgtz	a0,8000393c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000396c:	01093783          	ld	a5,16(s2)
    80003970:	0107b503          	ld	a0,16(a5)
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	c88080e7          	jalr	-888(ra) # 800025fc <_ZN9Semaphore6signalEv>
        }
    8000397c:	02813083          	ld	ra,40(sp)
    80003980:	02013403          	ld	s0,32(sp)
    80003984:	01813483          	ld	s1,24(sp)
    80003988:	01013903          	ld	s2,16(sp)
    8000398c:	00813983          	ld	s3,8(sp)
    80003990:	03010113          	addi	sp,sp,48
    80003994:	00008067          	ret

0000000080003998 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80003998:	ff010113          	addi	sp,sp,-16
    8000399c:	00113423          	sd	ra,8(sp)
    800039a0:	00813023          	sd	s0,0(sp)
    800039a4:	01010413          	addi	s0,sp,16
    800039a8:	00005797          	auipc	a5,0x5
    800039ac:	f0078793          	addi	a5,a5,-256 # 800088a8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800039b0:	00f53023          	sd	a5,0(a0)
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	824080e7          	jalr	-2012(ra) # 800021d8 <_ZN6ThreadD1Ev>
    800039bc:	00813083          	ld	ra,8(sp)
    800039c0:	00013403          	ld	s0,0(sp)
    800039c4:	01010113          	addi	sp,sp,16
    800039c8:	00008067          	ret

00000000800039cc <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    800039cc:	fe010113          	addi	sp,sp,-32
    800039d0:	00113c23          	sd	ra,24(sp)
    800039d4:	00813823          	sd	s0,16(sp)
    800039d8:	00913423          	sd	s1,8(sp)
    800039dc:	02010413          	addi	s0,sp,32
    800039e0:	00050493          	mv	s1,a0
    800039e4:	00005797          	auipc	a5,0x5
    800039e8:	ec478793          	addi	a5,a5,-316 # 800088a8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800039ec:	00f53023          	sd	a5,0(a0)
    800039f0:	ffffe097          	auipc	ra,0xffffe
    800039f4:	7e8080e7          	jalr	2024(ra) # 800021d8 <_ZN6ThreadD1Ev>
    800039f8:	00048513          	mv	a0,s1
    800039fc:	fffff097          	auipc	ra,0xfffff
    80003a00:	9cc080e7          	jalr	-1588(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80003a04:	01813083          	ld	ra,24(sp)
    80003a08:	01013403          	ld	s0,16(sp)
    80003a0c:	00813483          	ld	s1,8(sp)
    80003a10:	02010113          	addi	sp,sp,32
    80003a14:	00008067          	ret

0000000080003a18 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80003a18:	ff010113          	addi	sp,sp,-16
    80003a1c:	00113423          	sd	ra,8(sp)
    80003a20:	00813023          	sd	s0,0(sp)
    80003a24:	01010413          	addi	s0,sp,16
    80003a28:	00005797          	auipc	a5,0x5
    80003a2c:	e3078793          	addi	a5,a5,-464 # 80008858 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80003a30:	00f53023          	sd	a5,0(a0)
    80003a34:	ffffe097          	auipc	ra,0xffffe
    80003a38:	7a4080e7          	jalr	1956(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80003a3c:	00813083          	ld	ra,8(sp)
    80003a40:	00013403          	ld	s0,0(sp)
    80003a44:	01010113          	addi	sp,sp,16
    80003a48:	00008067          	ret

0000000080003a4c <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80003a4c:	fe010113          	addi	sp,sp,-32
    80003a50:	00113c23          	sd	ra,24(sp)
    80003a54:	00813823          	sd	s0,16(sp)
    80003a58:	00913423          	sd	s1,8(sp)
    80003a5c:	02010413          	addi	s0,sp,32
    80003a60:	00050493          	mv	s1,a0
    80003a64:	00005797          	auipc	a5,0x5
    80003a68:	df478793          	addi	a5,a5,-524 # 80008858 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80003a6c:	00f53023          	sd	a5,0(a0)
    80003a70:	ffffe097          	auipc	ra,0xffffe
    80003a74:	768080e7          	jalr	1896(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80003a78:	00048513          	mv	a0,s1
    80003a7c:	fffff097          	auipc	ra,0xfffff
    80003a80:	94c080e7          	jalr	-1716(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80003a84:	01813083          	ld	ra,24(sp)
    80003a88:	01013403          	ld	s0,16(sp)
    80003a8c:	00813483          	ld	s1,8(sp)
    80003a90:	02010113          	addi	sp,sp,32
    80003a94:	00008067          	ret

0000000080003a98 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80003a98:	ff010113          	addi	sp,sp,-16
    80003a9c:	00113423          	sd	ra,8(sp)
    80003aa0:	00813023          	sd	s0,0(sp)
    80003aa4:	01010413          	addi	s0,sp,16
    80003aa8:	00005797          	auipc	a5,0x5
    80003aac:	dd878793          	addi	a5,a5,-552 # 80008880 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80003ab0:	00f53023          	sd	a5,0(a0)
    80003ab4:	ffffe097          	auipc	ra,0xffffe
    80003ab8:	724080e7          	jalr	1828(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80003abc:	00813083          	ld	ra,8(sp)
    80003ac0:	00013403          	ld	s0,0(sp)
    80003ac4:	01010113          	addi	sp,sp,16
    80003ac8:	00008067          	ret

0000000080003acc <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80003acc:	fe010113          	addi	sp,sp,-32
    80003ad0:	00113c23          	sd	ra,24(sp)
    80003ad4:	00813823          	sd	s0,16(sp)
    80003ad8:	00913423          	sd	s1,8(sp)
    80003adc:	02010413          	addi	s0,sp,32
    80003ae0:	00050493          	mv	s1,a0
    80003ae4:	00005797          	auipc	a5,0x5
    80003ae8:	d9c78793          	addi	a5,a5,-612 # 80008880 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80003aec:	00f53023          	sd	a5,0(a0)
    80003af0:	ffffe097          	auipc	ra,0xffffe
    80003af4:	6e8080e7          	jalr	1768(ra) # 800021d8 <_ZN6ThreadD1Ev>
    80003af8:	00048513          	mv	a0,s1
    80003afc:	fffff097          	auipc	ra,0xfffff
    80003b00:	8cc080e7          	jalr	-1844(ra) # 800023c8 <_ZN6ThreaddlEPv>
    80003b04:	01813083          	ld	ra,24(sp)
    80003b08:	01013403          	ld	s0,16(sp)
    80003b0c:	00813483          	ld	s1,8(sp)
    80003b10:	02010113          	addi	sp,sp,32
    80003b14:	00008067          	ret

0000000080003b18 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80003b18:	fe010113          	addi	sp,sp,-32
    80003b1c:	00113c23          	sd	ra,24(sp)
    80003b20:	00813823          	sd	s0,16(sp)
    80003b24:	00913423          	sd	s1,8(sp)
    80003b28:	02010413          	addi	s0,sp,32
    80003b2c:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80003b30:	ffffe097          	auipc	ra,0xffffe
    80003b34:	978080e7          	jalr	-1672(ra) # 800014a8 <_Z4getcv>
    80003b38:	0005059b          	sext.w	a1,a0
    80003b3c:	01b00793          	li	a5,27
    80003b40:	00f58c63          	beq	a1,a5,80003b58 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80003b44:	0104b783          	ld	a5,16(s1)
    80003b48:	0087b503          	ld	a0,8(a5)
    80003b4c:	fffff097          	auipc	ra,0xfffff
    80003b50:	68c080e7          	jalr	1676(ra) # 800031d8 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80003b54:	fddff06f          	j	80003b30 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80003b58:	00100793          	li	a5,1
    80003b5c:	00005717          	auipc	a4,0x5
    80003b60:	ecf72a23          	sw	a5,-300(a4) # 80008a30 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80003b64:	0104b783          	ld	a5,16(s1)
    80003b68:	02100593          	li	a1,33
    80003b6c:	0087b503          	ld	a0,8(a5)
    80003b70:	fffff097          	auipc	ra,0xfffff
    80003b74:	668080e7          	jalr	1640(ra) # 800031d8 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80003b78:	0104b783          	ld	a5,16(s1)
    80003b7c:	0107b503          	ld	a0,16(a5)
    80003b80:	fffff097          	auipc	ra,0xfffff
    80003b84:	a7c080e7          	jalr	-1412(ra) # 800025fc <_ZN9Semaphore6signalEv>
        }
    80003b88:	01813083          	ld	ra,24(sp)
    80003b8c:	01013403          	ld	s0,16(sp)
    80003b90:	00813483          	ld	s1,8(sp)
    80003b94:	02010113          	addi	sp,sp,32
    80003b98:	00008067          	ret

0000000080003b9c <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80003b9c:	fe010113          	addi	sp,sp,-32
    80003ba0:	00113c23          	sd	ra,24(sp)
    80003ba4:	00813823          	sd	s0,16(sp)
    80003ba8:	00913423          	sd	s1,8(sp)
    80003bac:	01213023          	sd	s2,0(sp)
    80003bb0:	02010413          	addi	s0,sp,32
    80003bb4:	00050493          	mv	s1,a0
            int i = 0;
    80003bb8:	00000913          	li	s2,0
            while (!threadEnd) {
    80003bbc:	00005797          	auipc	a5,0x5
    80003bc0:	e747a783          	lw	a5,-396(a5) # 80008a30 <_ZN19ConsumerProducerCPP9threadEndE>
    80003bc4:	04079263          	bnez	a5,80003c08 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80003bc8:	0104b783          	ld	a5,16(s1)
    80003bcc:	0007a583          	lw	a1,0(a5)
    80003bd0:	0305859b          	addiw	a1,a1,48
    80003bd4:	0087b503          	ld	a0,8(a5)
    80003bd8:	fffff097          	auipc	ra,0xfffff
    80003bdc:	600080e7          	jalr	1536(ra) # 800031d8 <_ZN9BufferCPP3putEi>
                i++;
    80003be0:	0019071b          	addiw	a4,s2,1
    80003be4:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80003be8:	0104b783          	ld	a5,16(s1)
    80003bec:	0007a783          	lw	a5,0(a5)
    80003bf0:	00e787bb          	addw	a5,a5,a4
    80003bf4:	00500513          	li	a0,5
    80003bf8:	02a7e53b          	remw	a0,a5,a0
    80003bfc:	fffff097          	auipc	ra,0xfffff
    80003c00:	8f8080e7          	jalr	-1800(ra) # 800024f4 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80003c04:	fb9ff06f          	j	80003bbc <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80003c08:	0104b783          	ld	a5,16(s1)
    80003c0c:	0107b503          	ld	a0,16(a5)
    80003c10:	fffff097          	auipc	ra,0xfffff
    80003c14:	9ec080e7          	jalr	-1556(ra) # 800025fc <_ZN9Semaphore6signalEv>
        }
    80003c18:	01813083          	ld	ra,24(sp)
    80003c1c:	01013403          	ld	s0,16(sp)
    80003c20:	00813483          	ld	s1,8(sp)
    80003c24:	00013903          	ld	s2,0(sp)
    80003c28:	02010113          	addi	sp,sp,32
    80003c2c:	00008067          	ret

0000000080003c30 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003c30:	fe010113          	addi	sp,sp,-32
    80003c34:	00113c23          	sd	ra,24(sp)
    80003c38:	00813823          	sd	s0,16(sp)
    80003c3c:	00913423          	sd	s1,8(sp)
    80003c40:	01213023          	sd	s2,0(sp)
    80003c44:	02010413          	addi	s0,sp,32
    80003c48:	00050493          	mv	s1,a0
    80003c4c:	00058913          	mv	s2,a1
    80003c50:	0015879b          	addiw	a5,a1,1
    80003c54:	0007851b          	sext.w	a0,a5
    80003c58:	00f4a023          	sw	a5,0(s1)
    80003c5c:	0004a823          	sw	zero,16(s1)
    80003c60:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003c64:	00251513          	slli	a0,a0,0x2
    80003c68:	ffffd097          	auipc	ra,0xffffd
    80003c6c:	52c080e7          	jalr	1324(ra) # 80001194 <_Z9mem_allocm>
    80003c70:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003c74:	00000593          	li	a1,0
    80003c78:	02048513          	addi	a0,s1,32
    80003c7c:	ffffd097          	auipc	ra,0xffffd
    80003c80:	6d4080e7          	jalr	1748(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80003c84:	00090593          	mv	a1,s2
    80003c88:	01848513          	addi	a0,s1,24
    80003c8c:	ffffd097          	auipc	ra,0xffffd
    80003c90:	6c4080e7          	jalr	1732(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003c94:	00100593          	li	a1,1
    80003c98:	02848513          	addi	a0,s1,40
    80003c9c:	ffffd097          	auipc	ra,0xffffd
    80003ca0:	6b4080e7          	jalr	1716(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003ca4:	00100593          	li	a1,1
    80003ca8:	03048513          	addi	a0,s1,48
    80003cac:	ffffd097          	auipc	ra,0xffffd
    80003cb0:	6a4080e7          	jalr	1700(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003cb4:	01813083          	ld	ra,24(sp)
    80003cb8:	01013403          	ld	s0,16(sp)
    80003cbc:	00813483          	ld	s1,8(sp)
    80003cc0:	00013903          	ld	s2,0(sp)
    80003cc4:	02010113          	addi	sp,sp,32
    80003cc8:	00008067          	ret

0000000080003ccc <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80003ccc:	fe010113          	addi	sp,sp,-32
    80003cd0:	00113c23          	sd	ra,24(sp)
    80003cd4:	00813823          	sd	s0,16(sp)
    80003cd8:	00913423          	sd	s1,8(sp)
    80003cdc:	01213023          	sd	s2,0(sp)
    80003ce0:	02010413          	addi	s0,sp,32
    80003ce4:	00050493          	mv	s1,a0
    80003ce8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003cec:	01853503          	ld	a0,24(a0)
    80003cf0:	ffffd097          	auipc	ra,0xffffd
    80003cf4:	6a8080e7          	jalr	1704(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80003cf8:	0304b503          	ld	a0,48(s1)
    80003cfc:	ffffd097          	auipc	ra,0xffffd
    80003d00:	69c080e7          	jalr	1692(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80003d04:	0084b783          	ld	a5,8(s1)
    80003d08:	0144a703          	lw	a4,20(s1)
    80003d0c:	00271713          	slli	a4,a4,0x2
    80003d10:	00e787b3          	add	a5,a5,a4
    80003d14:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003d18:	0144a783          	lw	a5,20(s1)
    80003d1c:	0017879b          	addiw	a5,a5,1
    80003d20:	0004a703          	lw	a4,0(s1)
    80003d24:	02e7e7bb          	remw	a5,a5,a4
    80003d28:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003d2c:	0304b503          	ld	a0,48(s1)
    80003d30:	ffffd097          	auipc	ra,0xffffd
    80003d34:	6b0080e7          	jalr	1712(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80003d38:	0204b503          	ld	a0,32(s1)
    80003d3c:	ffffd097          	auipc	ra,0xffffd
    80003d40:	6a4080e7          	jalr	1700(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80003d44:	01813083          	ld	ra,24(sp)
    80003d48:	01013403          	ld	s0,16(sp)
    80003d4c:	00813483          	ld	s1,8(sp)
    80003d50:	00013903          	ld	s2,0(sp)
    80003d54:	02010113          	addi	sp,sp,32
    80003d58:	00008067          	ret

0000000080003d5c <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003d5c:	fe010113          	addi	sp,sp,-32
    80003d60:	00113c23          	sd	ra,24(sp)
    80003d64:	00813823          	sd	s0,16(sp)
    80003d68:	00913423          	sd	s1,8(sp)
    80003d6c:	01213023          	sd	s2,0(sp)
    80003d70:	02010413          	addi	s0,sp,32
    80003d74:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003d78:	02053503          	ld	a0,32(a0)
    80003d7c:	ffffd097          	auipc	ra,0xffffd
    80003d80:	61c080e7          	jalr	1564(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003d84:	0284b503          	ld	a0,40(s1)
    80003d88:	ffffd097          	auipc	ra,0xffffd
    80003d8c:	610080e7          	jalr	1552(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003d90:	0084b703          	ld	a4,8(s1)
    80003d94:	0104a783          	lw	a5,16(s1)
    80003d98:	00279693          	slli	a3,a5,0x2
    80003d9c:	00d70733          	add	a4,a4,a3
    80003da0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003da4:	0017879b          	addiw	a5,a5,1
    80003da8:	0004a703          	lw	a4,0(s1)
    80003dac:	02e7e7bb          	remw	a5,a5,a4
    80003db0:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003db4:	0284b503          	ld	a0,40(s1)
    80003db8:	ffffd097          	auipc	ra,0xffffd
    80003dbc:	628080e7          	jalr	1576(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003dc0:	0184b503          	ld	a0,24(s1)
    80003dc4:	ffffd097          	auipc	ra,0xffffd
    80003dc8:	61c080e7          	jalr	1564(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003dcc:	00090513          	mv	a0,s2
    80003dd0:	01813083          	ld	ra,24(sp)
    80003dd4:	01013403          	ld	s0,16(sp)
    80003dd8:	00813483          	ld	s1,8(sp)
    80003ddc:	00013903          	ld	s2,0(sp)
    80003de0:	02010113          	addi	sp,sp,32
    80003de4:	00008067          	ret

0000000080003de8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003de8:	fe010113          	addi	sp,sp,-32
    80003dec:	00113c23          	sd	ra,24(sp)
    80003df0:	00813823          	sd	s0,16(sp)
    80003df4:	00913423          	sd	s1,8(sp)
    80003df8:	01213023          	sd	s2,0(sp)
    80003dfc:	02010413          	addi	s0,sp,32
    80003e00:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80003e04:	02853503          	ld	a0,40(a0)
    80003e08:	ffffd097          	auipc	ra,0xffffd
    80003e0c:	590080e7          	jalr	1424(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    80003e10:	0304b503          	ld	a0,48(s1)
    80003e14:	ffffd097          	auipc	ra,0xffffd
    80003e18:	584080e7          	jalr	1412(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80003e1c:	0144a783          	lw	a5,20(s1)
    80003e20:	0104a903          	lw	s2,16(s1)
    80003e24:	0327ce63          	blt	a5,s2,80003e60 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80003e28:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80003e2c:	0304b503          	ld	a0,48(s1)
    80003e30:	ffffd097          	auipc	ra,0xffffd
    80003e34:	5b0080e7          	jalr	1456(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    80003e38:	0284b503          	ld	a0,40(s1)
    80003e3c:	ffffd097          	auipc	ra,0xffffd
    80003e40:	5a4080e7          	jalr	1444(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003e44:	00090513          	mv	a0,s2
    80003e48:	01813083          	ld	ra,24(sp)
    80003e4c:	01013403          	ld	s0,16(sp)
    80003e50:	00813483          	ld	s1,8(sp)
    80003e54:	00013903          	ld	s2,0(sp)
    80003e58:	02010113          	addi	sp,sp,32
    80003e5c:	00008067          	ret
        ret = cap - head + tail;
    80003e60:	0004a703          	lw	a4,0(s1)
    80003e64:	4127093b          	subw	s2,a4,s2
    80003e68:	00f9093b          	addw	s2,s2,a5
    80003e6c:	fc1ff06f          	j	80003e2c <_ZN6Buffer6getCntEv+0x44>

0000000080003e70 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003e70:	fe010113          	addi	sp,sp,-32
    80003e74:	00113c23          	sd	ra,24(sp)
    80003e78:	00813823          	sd	s0,16(sp)
    80003e7c:	00913423          	sd	s1,8(sp)
    80003e80:	02010413          	addi	s0,sp,32
    80003e84:	00050493          	mv	s1,a0
    putc('\n');
    80003e88:	00a00513          	li	a0,10
    80003e8c:	ffffd097          	auipc	ra,0xffffd
    80003e90:	64c080e7          	jalr	1612(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003e94:	00003517          	auipc	a0,0x3
    80003e98:	29c50513          	addi	a0,a0,668 # 80007130 <CONSOLE_STATUS+0x120>
    80003e9c:	fffff097          	auipc	ra,0xfffff
    80003ea0:	f3c080e7          	jalr	-196(ra) # 80002dd8 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003ea4:	00048513          	mv	a0,s1
    80003ea8:	00000097          	auipc	ra,0x0
    80003eac:	f40080e7          	jalr	-192(ra) # 80003de8 <_ZN6Buffer6getCntEv>
    80003eb0:	02a05c63          	blez	a0,80003ee8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003eb4:	0084b783          	ld	a5,8(s1)
    80003eb8:	0104a703          	lw	a4,16(s1)
    80003ebc:	00271713          	slli	a4,a4,0x2
    80003ec0:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003ec4:	0007c503          	lbu	a0,0(a5)
    80003ec8:	ffffd097          	auipc	ra,0xffffd
    80003ecc:	610080e7          	jalr	1552(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80003ed0:	0104a783          	lw	a5,16(s1)
    80003ed4:	0017879b          	addiw	a5,a5,1
    80003ed8:	0004a703          	lw	a4,0(s1)
    80003edc:	02e7e7bb          	remw	a5,a5,a4
    80003ee0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003ee4:	fc1ff06f          	j	80003ea4 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003ee8:	02100513          	li	a0,33
    80003eec:	ffffd097          	auipc	ra,0xffffd
    80003ef0:	5ec080e7          	jalr	1516(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    80003ef4:	00a00513          	li	a0,10
    80003ef8:	ffffd097          	auipc	ra,0xffffd
    80003efc:	5e0080e7          	jalr	1504(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    80003f00:	0084b503          	ld	a0,8(s1)
    80003f04:	ffffd097          	auipc	ra,0xffffd
    80003f08:	2d0080e7          	jalr	720(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003f0c:	0204b503          	ld	a0,32(s1)
    80003f10:	ffffd097          	auipc	ra,0xffffd
    80003f14:	510080e7          	jalr	1296(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003f18:	0184b503          	ld	a0,24(s1)
    80003f1c:	ffffd097          	auipc	ra,0xffffd
    80003f20:	504080e7          	jalr	1284(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003f24:	0304b503          	ld	a0,48(s1)
    80003f28:	ffffd097          	auipc	ra,0xffffd
    80003f2c:	4f8080e7          	jalr	1272(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80003f30:	0284b503          	ld	a0,40(s1)
    80003f34:	ffffd097          	auipc	ra,0xffffd
    80003f38:	4ec080e7          	jalr	1260(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003f3c:	01813083          	ld	ra,24(sp)
    80003f40:	01013403          	ld	s0,16(sp)
    80003f44:	00813483          	ld	s1,8(sp)
    80003f48:	02010113          	addi	sp,sp,32
    80003f4c:	00008067          	ret

0000000080003f50 <start>:
    80003f50:	ff010113          	addi	sp,sp,-16
    80003f54:	00813423          	sd	s0,8(sp)
    80003f58:	01010413          	addi	s0,sp,16
    80003f5c:	300027f3          	csrr	a5,mstatus
    80003f60:	ffffe737          	lui	a4,0xffffe
    80003f64:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4b5f>
    80003f68:	00e7f7b3          	and	a5,a5,a4
    80003f6c:	00001737          	lui	a4,0x1
    80003f70:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003f74:	00e7e7b3          	or	a5,a5,a4
    80003f78:	30079073          	csrw	mstatus,a5
    80003f7c:	00000797          	auipc	a5,0x0
    80003f80:	16078793          	addi	a5,a5,352 # 800040dc <system_main>
    80003f84:	34179073          	csrw	mepc,a5
    80003f88:	00000793          	li	a5,0
    80003f8c:	18079073          	csrw	satp,a5
    80003f90:	000107b7          	lui	a5,0x10
    80003f94:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003f98:	30279073          	csrw	medeleg,a5
    80003f9c:	30379073          	csrw	mideleg,a5
    80003fa0:	104027f3          	csrr	a5,sie
    80003fa4:	2227e793          	ori	a5,a5,546
    80003fa8:	10479073          	csrw	sie,a5
    80003fac:	fff00793          	li	a5,-1
    80003fb0:	00a7d793          	srli	a5,a5,0xa
    80003fb4:	3b079073          	csrw	pmpaddr0,a5
    80003fb8:	00f00793          	li	a5,15
    80003fbc:	3a079073          	csrw	pmpcfg0,a5
    80003fc0:	f14027f3          	csrr	a5,mhartid
    80003fc4:	0200c737          	lui	a4,0x200c
    80003fc8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003fcc:	0007869b          	sext.w	a3,a5
    80003fd0:	00269713          	slli	a4,a3,0x2
    80003fd4:	000f4637          	lui	a2,0xf4
    80003fd8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003fdc:	00d70733          	add	a4,a4,a3
    80003fe0:	0037979b          	slliw	a5,a5,0x3
    80003fe4:	020046b7          	lui	a3,0x2004
    80003fe8:	00d787b3          	add	a5,a5,a3
    80003fec:	00c585b3          	add	a1,a1,a2
    80003ff0:	00371693          	slli	a3,a4,0x3
    80003ff4:	00005717          	auipc	a4,0x5
    80003ff8:	a4c70713          	addi	a4,a4,-1460 # 80008a40 <timer_scratch>
    80003ffc:	00b7b023          	sd	a1,0(a5)
    80004000:	00d70733          	add	a4,a4,a3
    80004004:	00f73c23          	sd	a5,24(a4)
    80004008:	02c73023          	sd	a2,32(a4)
    8000400c:	34071073          	csrw	mscratch,a4
    80004010:	00000797          	auipc	a5,0x0
    80004014:	6e078793          	addi	a5,a5,1760 # 800046f0 <timervec>
    80004018:	30579073          	csrw	mtvec,a5
    8000401c:	300027f3          	csrr	a5,mstatus
    80004020:	0087e793          	ori	a5,a5,8
    80004024:	30079073          	csrw	mstatus,a5
    80004028:	304027f3          	csrr	a5,mie
    8000402c:	0807e793          	ori	a5,a5,128
    80004030:	30479073          	csrw	mie,a5
    80004034:	f14027f3          	csrr	a5,mhartid
    80004038:	0007879b          	sext.w	a5,a5
    8000403c:	00078213          	mv	tp,a5
    80004040:	30200073          	mret
    80004044:	00813403          	ld	s0,8(sp)
    80004048:	01010113          	addi	sp,sp,16
    8000404c:	00008067          	ret

0000000080004050 <timerinit>:
    80004050:	ff010113          	addi	sp,sp,-16
    80004054:	00813423          	sd	s0,8(sp)
    80004058:	01010413          	addi	s0,sp,16
    8000405c:	f14027f3          	csrr	a5,mhartid
    80004060:	0200c737          	lui	a4,0x200c
    80004064:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004068:	0007869b          	sext.w	a3,a5
    8000406c:	00269713          	slli	a4,a3,0x2
    80004070:	000f4637          	lui	a2,0xf4
    80004074:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004078:	00d70733          	add	a4,a4,a3
    8000407c:	0037979b          	slliw	a5,a5,0x3
    80004080:	020046b7          	lui	a3,0x2004
    80004084:	00d787b3          	add	a5,a5,a3
    80004088:	00c585b3          	add	a1,a1,a2
    8000408c:	00371693          	slli	a3,a4,0x3
    80004090:	00005717          	auipc	a4,0x5
    80004094:	9b070713          	addi	a4,a4,-1616 # 80008a40 <timer_scratch>
    80004098:	00b7b023          	sd	a1,0(a5)
    8000409c:	00d70733          	add	a4,a4,a3
    800040a0:	00f73c23          	sd	a5,24(a4)
    800040a4:	02c73023          	sd	a2,32(a4)
    800040a8:	34071073          	csrw	mscratch,a4
    800040ac:	00000797          	auipc	a5,0x0
    800040b0:	64478793          	addi	a5,a5,1604 # 800046f0 <timervec>
    800040b4:	30579073          	csrw	mtvec,a5
    800040b8:	300027f3          	csrr	a5,mstatus
    800040bc:	0087e793          	ori	a5,a5,8
    800040c0:	30079073          	csrw	mstatus,a5
    800040c4:	304027f3          	csrr	a5,mie
    800040c8:	0807e793          	ori	a5,a5,128
    800040cc:	30479073          	csrw	mie,a5
    800040d0:	00813403          	ld	s0,8(sp)
    800040d4:	01010113          	addi	sp,sp,16
    800040d8:	00008067          	ret

00000000800040dc <system_main>:
    800040dc:	fe010113          	addi	sp,sp,-32
    800040e0:	00813823          	sd	s0,16(sp)
    800040e4:	00913423          	sd	s1,8(sp)
    800040e8:	00113c23          	sd	ra,24(sp)
    800040ec:	02010413          	addi	s0,sp,32
    800040f0:	00000097          	auipc	ra,0x0
    800040f4:	0c4080e7          	jalr	196(ra) # 800041b4 <cpuid>
    800040f8:	00005497          	auipc	s1,0x5
    800040fc:	87848493          	addi	s1,s1,-1928 # 80008970 <started>
    80004100:	02050263          	beqz	a0,80004124 <system_main+0x48>
    80004104:	0004a783          	lw	a5,0(s1)
    80004108:	0007879b          	sext.w	a5,a5
    8000410c:	fe078ce3          	beqz	a5,80004104 <system_main+0x28>
    80004110:	0ff0000f          	fence
    80004114:	00003517          	auipc	a0,0x3
    80004118:	14c50513          	addi	a0,a0,332 # 80007260 <CONSOLE_STATUS+0x250>
    8000411c:	00001097          	auipc	ra,0x1
    80004120:	a70080e7          	jalr	-1424(ra) # 80004b8c <panic>
    80004124:	00001097          	auipc	ra,0x1
    80004128:	9c4080e7          	jalr	-1596(ra) # 80004ae8 <consoleinit>
    8000412c:	00001097          	auipc	ra,0x1
    80004130:	150080e7          	jalr	336(ra) # 8000527c <printfinit>
    80004134:	00003517          	auipc	a0,0x3
    80004138:	04c50513          	addi	a0,a0,76 # 80007180 <CONSOLE_STATUS+0x170>
    8000413c:	00001097          	auipc	ra,0x1
    80004140:	aac080e7          	jalr	-1364(ra) # 80004be8 <__printf>
    80004144:	00003517          	auipc	a0,0x3
    80004148:	0ec50513          	addi	a0,a0,236 # 80007230 <CONSOLE_STATUS+0x220>
    8000414c:	00001097          	auipc	ra,0x1
    80004150:	a9c080e7          	jalr	-1380(ra) # 80004be8 <__printf>
    80004154:	00003517          	auipc	a0,0x3
    80004158:	02c50513          	addi	a0,a0,44 # 80007180 <CONSOLE_STATUS+0x170>
    8000415c:	00001097          	auipc	ra,0x1
    80004160:	a8c080e7          	jalr	-1396(ra) # 80004be8 <__printf>
    80004164:	00001097          	auipc	ra,0x1
    80004168:	4a4080e7          	jalr	1188(ra) # 80005608 <kinit>
    8000416c:	00000097          	auipc	ra,0x0
    80004170:	148080e7          	jalr	328(ra) # 800042b4 <trapinit>
    80004174:	00000097          	auipc	ra,0x0
    80004178:	16c080e7          	jalr	364(ra) # 800042e0 <trapinithart>
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	5b4080e7          	jalr	1460(ra) # 80004730 <plicinit>
    80004184:	00000097          	auipc	ra,0x0
    80004188:	5d4080e7          	jalr	1492(ra) # 80004758 <plicinithart>
    8000418c:	00000097          	auipc	ra,0x0
    80004190:	078080e7          	jalr	120(ra) # 80004204 <userinit>
    80004194:	0ff0000f          	fence
    80004198:	00100793          	li	a5,1
    8000419c:	00003517          	auipc	a0,0x3
    800041a0:	0ac50513          	addi	a0,a0,172 # 80007248 <CONSOLE_STATUS+0x238>
    800041a4:	00f4a023          	sw	a5,0(s1)
    800041a8:	00001097          	auipc	ra,0x1
    800041ac:	a40080e7          	jalr	-1472(ra) # 80004be8 <__printf>
    800041b0:	0000006f          	j	800041b0 <system_main+0xd4>

00000000800041b4 <cpuid>:
    800041b4:	ff010113          	addi	sp,sp,-16
    800041b8:	00813423          	sd	s0,8(sp)
    800041bc:	01010413          	addi	s0,sp,16
    800041c0:	00020513          	mv	a0,tp
    800041c4:	00813403          	ld	s0,8(sp)
    800041c8:	0005051b          	sext.w	a0,a0
    800041cc:	01010113          	addi	sp,sp,16
    800041d0:	00008067          	ret

00000000800041d4 <mycpu>:
    800041d4:	ff010113          	addi	sp,sp,-16
    800041d8:	00813423          	sd	s0,8(sp)
    800041dc:	01010413          	addi	s0,sp,16
    800041e0:	00020793          	mv	a5,tp
    800041e4:	00813403          	ld	s0,8(sp)
    800041e8:	0007879b          	sext.w	a5,a5
    800041ec:	00779793          	slli	a5,a5,0x7
    800041f0:	00006517          	auipc	a0,0x6
    800041f4:	88050513          	addi	a0,a0,-1920 # 80009a70 <cpus>
    800041f8:	00f50533          	add	a0,a0,a5
    800041fc:	01010113          	addi	sp,sp,16
    80004200:	00008067          	ret

0000000080004204 <userinit>:
    80004204:	ff010113          	addi	sp,sp,-16
    80004208:	00813423          	sd	s0,8(sp)
    8000420c:	01010413          	addi	s0,sp,16
    80004210:	00813403          	ld	s0,8(sp)
    80004214:	01010113          	addi	sp,sp,16
    80004218:	ffffe317          	auipc	t1,0xffffe
    8000421c:	e6830067          	jr	-408(t1) # 80002080 <main>

0000000080004220 <either_copyout>:
    80004220:	ff010113          	addi	sp,sp,-16
    80004224:	00813023          	sd	s0,0(sp)
    80004228:	00113423          	sd	ra,8(sp)
    8000422c:	01010413          	addi	s0,sp,16
    80004230:	02051663          	bnez	a0,8000425c <either_copyout+0x3c>
    80004234:	00058513          	mv	a0,a1
    80004238:	00060593          	mv	a1,a2
    8000423c:	0006861b          	sext.w	a2,a3
    80004240:	00002097          	auipc	ra,0x2
    80004244:	c54080e7          	jalr	-940(ra) # 80005e94 <__memmove>
    80004248:	00813083          	ld	ra,8(sp)
    8000424c:	00013403          	ld	s0,0(sp)
    80004250:	00000513          	li	a0,0
    80004254:	01010113          	addi	sp,sp,16
    80004258:	00008067          	ret
    8000425c:	00003517          	auipc	a0,0x3
    80004260:	02c50513          	addi	a0,a0,44 # 80007288 <CONSOLE_STATUS+0x278>
    80004264:	00001097          	auipc	ra,0x1
    80004268:	928080e7          	jalr	-1752(ra) # 80004b8c <panic>

000000008000426c <either_copyin>:
    8000426c:	ff010113          	addi	sp,sp,-16
    80004270:	00813023          	sd	s0,0(sp)
    80004274:	00113423          	sd	ra,8(sp)
    80004278:	01010413          	addi	s0,sp,16
    8000427c:	02059463          	bnez	a1,800042a4 <either_copyin+0x38>
    80004280:	00060593          	mv	a1,a2
    80004284:	0006861b          	sext.w	a2,a3
    80004288:	00002097          	auipc	ra,0x2
    8000428c:	c0c080e7          	jalr	-1012(ra) # 80005e94 <__memmove>
    80004290:	00813083          	ld	ra,8(sp)
    80004294:	00013403          	ld	s0,0(sp)
    80004298:	00000513          	li	a0,0
    8000429c:	01010113          	addi	sp,sp,16
    800042a0:	00008067          	ret
    800042a4:	00003517          	auipc	a0,0x3
    800042a8:	00c50513          	addi	a0,a0,12 # 800072b0 <CONSOLE_STATUS+0x2a0>
    800042ac:	00001097          	auipc	ra,0x1
    800042b0:	8e0080e7          	jalr	-1824(ra) # 80004b8c <panic>

00000000800042b4 <trapinit>:
    800042b4:	ff010113          	addi	sp,sp,-16
    800042b8:	00813423          	sd	s0,8(sp)
    800042bc:	01010413          	addi	s0,sp,16
    800042c0:	00813403          	ld	s0,8(sp)
    800042c4:	00003597          	auipc	a1,0x3
    800042c8:	01458593          	addi	a1,a1,20 # 800072d8 <CONSOLE_STATUS+0x2c8>
    800042cc:	00006517          	auipc	a0,0x6
    800042d0:	82450513          	addi	a0,a0,-2012 # 80009af0 <tickslock>
    800042d4:	01010113          	addi	sp,sp,16
    800042d8:	00001317          	auipc	t1,0x1
    800042dc:	5c030067          	jr	1472(t1) # 80005898 <initlock>

00000000800042e0 <trapinithart>:
    800042e0:	ff010113          	addi	sp,sp,-16
    800042e4:	00813423          	sd	s0,8(sp)
    800042e8:	01010413          	addi	s0,sp,16
    800042ec:	00000797          	auipc	a5,0x0
    800042f0:	2f478793          	addi	a5,a5,756 # 800045e0 <kernelvec>
    800042f4:	10579073          	csrw	stvec,a5
    800042f8:	00813403          	ld	s0,8(sp)
    800042fc:	01010113          	addi	sp,sp,16
    80004300:	00008067          	ret

0000000080004304 <usertrap>:
    80004304:	ff010113          	addi	sp,sp,-16
    80004308:	00813423          	sd	s0,8(sp)
    8000430c:	01010413          	addi	s0,sp,16
    80004310:	00813403          	ld	s0,8(sp)
    80004314:	01010113          	addi	sp,sp,16
    80004318:	00008067          	ret

000000008000431c <usertrapret>:
    8000431c:	ff010113          	addi	sp,sp,-16
    80004320:	00813423          	sd	s0,8(sp)
    80004324:	01010413          	addi	s0,sp,16
    80004328:	00813403          	ld	s0,8(sp)
    8000432c:	01010113          	addi	sp,sp,16
    80004330:	00008067          	ret

0000000080004334 <kerneltrap>:
    80004334:	fe010113          	addi	sp,sp,-32
    80004338:	00813823          	sd	s0,16(sp)
    8000433c:	00113c23          	sd	ra,24(sp)
    80004340:	00913423          	sd	s1,8(sp)
    80004344:	02010413          	addi	s0,sp,32
    80004348:	142025f3          	csrr	a1,scause
    8000434c:	100027f3          	csrr	a5,sstatus
    80004350:	0027f793          	andi	a5,a5,2
    80004354:	10079c63          	bnez	a5,8000446c <kerneltrap+0x138>
    80004358:	142027f3          	csrr	a5,scause
    8000435c:	0207ce63          	bltz	a5,80004398 <kerneltrap+0x64>
    80004360:	00003517          	auipc	a0,0x3
    80004364:	fc050513          	addi	a0,a0,-64 # 80007320 <CONSOLE_STATUS+0x310>
    80004368:	00001097          	auipc	ra,0x1
    8000436c:	880080e7          	jalr	-1920(ra) # 80004be8 <__printf>
    80004370:	141025f3          	csrr	a1,sepc
    80004374:	14302673          	csrr	a2,stval
    80004378:	00003517          	auipc	a0,0x3
    8000437c:	fb850513          	addi	a0,a0,-72 # 80007330 <CONSOLE_STATUS+0x320>
    80004380:	00001097          	auipc	ra,0x1
    80004384:	868080e7          	jalr	-1944(ra) # 80004be8 <__printf>
    80004388:	00003517          	auipc	a0,0x3
    8000438c:	fc050513          	addi	a0,a0,-64 # 80007348 <CONSOLE_STATUS+0x338>
    80004390:	00000097          	auipc	ra,0x0
    80004394:	7fc080e7          	jalr	2044(ra) # 80004b8c <panic>
    80004398:	0ff7f713          	andi	a4,a5,255
    8000439c:	00900693          	li	a3,9
    800043a0:	04d70063          	beq	a4,a3,800043e0 <kerneltrap+0xac>
    800043a4:	fff00713          	li	a4,-1
    800043a8:	03f71713          	slli	a4,a4,0x3f
    800043ac:	00170713          	addi	a4,a4,1
    800043b0:	fae798e3          	bne	a5,a4,80004360 <kerneltrap+0x2c>
    800043b4:	00000097          	auipc	ra,0x0
    800043b8:	e00080e7          	jalr	-512(ra) # 800041b4 <cpuid>
    800043bc:	06050663          	beqz	a0,80004428 <kerneltrap+0xf4>
    800043c0:	144027f3          	csrr	a5,sip
    800043c4:	ffd7f793          	andi	a5,a5,-3
    800043c8:	14479073          	csrw	sip,a5
    800043cc:	01813083          	ld	ra,24(sp)
    800043d0:	01013403          	ld	s0,16(sp)
    800043d4:	00813483          	ld	s1,8(sp)
    800043d8:	02010113          	addi	sp,sp,32
    800043dc:	00008067          	ret
    800043e0:	00000097          	auipc	ra,0x0
    800043e4:	3c4080e7          	jalr	964(ra) # 800047a4 <plic_claim>
    800043e8:	00a00793          	li	a5,10
    800043ec:	00050493          	mv	s1,a0
    800043f0:	06f50863          	beq	a0,a5,80004460 <kerneltrap+0x12c>
    800043f4:	fc050ce3          	beqz	a0,800043cc <kerneltrap+0x98>
    800043f8:	00050593          	mv	a1,a0
    800043fc:	00003517          	auipc	a0,0x3
    80004400:	f0450513          	addi	a0,a0,-252 # 80007300 <CONSOLE_STATUS+0x2f0>
    80004404:	00000097          	auipc	ra,0x0
    80004408:	7e4080e7          	jalr	2020(ra) # 80004be8 <__printf>
    8000440c:	01013403          	ld	s0,16(sp)
    80004410:	01813083          	ld	ra,24(sp)
    80004414:	00048513          	mv	a0,s1
    80004418:	00813483          	ld	s1,8(sp)
    8000441c:	02010113          	addi	sp,sp,32
    80004420:	00000317          	auipc	t1,0x0
    80004424:	3bc30067          	jr	956(t1) # 800047dc <plic_complete>
    80004428:	00005517          	auipc	a0,0x5
    8000442c:	6c850513          	addi	a0,a0,1736 # 80009af0 <tickslock>
    80004430:	00001097          	auipc	ra,0x1
    80004434:	48c080e7          	jalr	1164(ra) # 800058bc <acquire>
    80004438:	00004717          	auipc	a4,0x4
    8000443c:	53c70713          	addi	a4,a4,1340 # 80008974 <ticks>
    80004440:	00072783          	lw	a5,0(a4)
    80004444:	00005517          	auipc	a0,0x5
    80004448:	6ac50513          	addi	a0,a0,1708 # 80009af0 <tickslock>
    8000444c:	0017879b          	addiw	a5,a5,1
    80004450:	00f72023          	sw	a5,0(a4)
    80004454:	00001097          	auipc	ra,0x1
    80004458:	534080e7          	jalr	1332(ra) # 80005988 <release>
    8000445c:	f65ff06f          	j	800043c0 <kerneltrap+0x8c>
    80004460:	00001097          	auipc	ra,0x1
    80004464:	090080e7          	jalr	144(ra) # 800054f0 <uartintr>
    80004468:	fa5ff06f          	j	8000440c <kerneltrap+0xd8>
    8000446c:	00003517          	auipc	a0,0x3
    80004470:	e7450513          	addi	a0,a0,-396 # 800072e0 <CONSOLE_STATUS+0x2d0>
    80004474:	00000097          	auipc	ra,0x0
    80004478:	718080e7          	jalr	1816(ra) # 80004b8c <panic>

000000008000447c <clockintr>:
    8000447c:	fe010113          	addi	sp,sp,-32
    80004480:	00813823          	sd	s0,16(sp)
    80004484:	00913423          	sd	s1,8(sp)
    80004488:	00113c23          	sd	ra,24(sp)
    8000448c:	02010413          	addi	s0,sp,32
    80004490:	00005497          	auipc	s1,0x5
    80004494:	66048493          	addi	s1,s1,1632 # 80009af0 <tickslock>
    80004498:	00048513          	mv	a0,s1
    8000449c:	00001097          	auipc	ra,0x1
    800044a0:	420080e7          	jalr	1056(ra) # 800058bc <acquire>
    800044a4:	00004717          	auipc	a4,0x4
    800044a8:	4d070713          	addi	a4,a4,1232 # 80008974 <ticks>
    800044ac:	00072783          	lw	a5,0(a4)
    800044b0:	01013403          	ld	s0,16(sp)
    800044b4:	01813083          	ld	ra,24(sp)
    800044b8:	00048513          	mv	a0,s1
    800044bc:	0017879b          	addiw	a5,a5,1
    800044c0:	00813483          	ld	s1,8(sp)
    800044c4:	00f72023          	sw	a5,0(a4)
    800044c8:	02010113          	addi	sp,sp,32
    800044cc:	00001317          	auipc	t1,0x1
    800044d0:	4bc30067          	jr	1212(t1) # 80005988 <release>

00000000800044d4 <devintr>:
    800044d4:	142027f3          	csrr	a5,scause
    800044d8:	00000513          	li	a0,0
    800044dc:	0007c463          	bltz	a5,800044e4 <devintr+0x10>
    800044e0:	00008067          	ret
    800044e4:	fe010113          	addi	sp,sp,-32
    800044e8:	00813823          	sd	s0,16(sp)
    800044ec:	00113c23          	sd	ra,24(sp)
    800044f0:	00913423          	sd	s1,8(sp)
    800044f4:	02010413          	addi	s0,sp,32
    800044f8:	0ff7f713          	andi	a4,a5,255
    800044fc:	00900693          	li	a3,9
    80004500:	04d70c63          	beq	a4,a3,80004558 <devintr+0x84>
    80004504:	fff00713          	li	a4,-1
    80004508:	03f71713          	slli	a4,a4,0x3f
    8000450c:	00170713          	addi	a4,a4,1
    80004510:	00e78c63          	beq	a5,a4,80004528 <devintr+0x54>
    80004514:	01813083          	ld	ra,24(sp)
    80004518:	01013403          	ld	s0,16(sp)
    8000451c:	00813483          	ld	s1,8(sp)
    80004520:	02010113          	addi	sp,sp,32
    80004524:	00008067          	ret
    80004528:	00000097          	auipc	ra,0x0
    8000452c:	c8c080e7          	jalr	-884(ra) # 800041b4 <cpuid>
    80004530:	06050663          	beqz	a0,8000459c <devintr+0xc8>
    80004534:	144027f3          	csrr	a5,sip
    80004538:	ffd7f793          	andi	a5,a5,-3
    8000453c:	14479073          	csrw	sip,a5
    80004540:	01813083          	ld	ra,24(sp)
    80004544:	01013403          	ld	s0,16(sp)
    80004548:	00813483          	ld	s1,8(sp)
    8000454c:	00200513          	li	a0,2
    80004550:	02010113          	addi	sp,sp,32
    80004554:	00008067          	ret
    80004558:	00000097          	auipc	ra,0x0
    8000455c:	24c080e7          	jalr	588(ra) # 800047a4 <plic_claim>
    80004560:	00a00793          	li	a5,10
    80004564:	00050493          	mv	s1,a0
    80004568:	06f50663          	beq	a0,a5,800045d4 <devintr+0x100>
    8000456c:	00100513          	li	a0,1
    80004570:	fa0482e3          	beqz	s1,80004514 <devintr+0x40>
    80004574:	00048593          	mv	a1,s1
    80004578:	00003517          	auipc	a0,0x3
    8000457c:	d8850513          	addi	a0,a0,-632 # 80007300 <CONSOLE_STATUS+0x2f0>
    80004580:	00000097          	auipc	ra,0x0
    80004584:	668080e7          	jalr	1640(ra) # 80004be8 <__printf>
    80004588:	00048513          	mv	a0,s1
    8000458c:	00000097          	auipc	ra,0x0
    80004590:	250080e7          	jalr	592(ra) # 800047dc <plic_complete>
    80004594:	00100513          	li	a0,1
    80004598:	f7dff06f          	j	80004514 <devintr+0x40>
    8000459c:	00005517          	auipc	a0,0x5
    800045a0:	55450513          	addi	a0,a0,1364 # 80009af0 <tickslock>
    800045a4:	00001097          	auipc	ra,0x1
    800045a8:	318080e7          	jalr	792(ra) # 800058bc <acquire>
    800045ac:	00004717          	auipc	a4,0x4
    800045b0:	3c870713          	addi	a4,a4,968 # 80008974 <ticks>
    800045b4:	00072783          	lw	a5,0(a4)
    800045b8:	00005517          	auipc	a0,0x5
    800045bc:	53850513          	addi	a0,a0,1336 # 80009af0 <tickslock>
    800045c0:	0017879b          	addiw	a5,a5,1
    800045c4:	00f72023          	sw	a5,0(a4)
    800045c8:	00001097          	auipc	ra,0x1
    800045cc:	3c0080e7          	jalr	960(ra) # 80005988 <release>
    800045d0:	f65ff06f          	j	80004534 <devintr+0x60>
    800045d4:	00001097          	auipc	ra,0x1
    800045d8:	f1c080e7          	jalr	-228(ra) # 800054f0 <uartintr>
    800045dc:	fadff06f          	j	80004588 <devintr+0xb4>

00000000800045e0 <kernelvec>:
    800045e0:	f0010113          	addi	sp,sp,-256
    800045e4:	00113023          	sd	ra,0(sp)
    800045e8:	00213423          	sd	sp,8(sp)
    800045ec:	00313823          	sd	gp,16(sp)
    800045f0:	00413c23          	sd	tp,24(sp)
    800045f4:	02513023          	sd	t0,32(sp)
    800045f8:	02613423          	sd	t1,40(sp)
    800045fc:	02713823          	sd	t2,48(sp)
    80004600:	02813c23          	sd	s0,56(sp)
    80004604:	04913023          	sd	s1,64(sp)
    80004608:	04a13423          	sd	a0,72(sp)
    8000460c:	04b13823          	sd	a1,80(sp)
    80004610:	04c13c23          	sd	a2,88(sp)
    80004614:	06d13023          	sd	a3,96(sp)
    80004618:	06e13423          	sd	a4,104(sp)
    8000461c:	06f13823          	sd	a5,112(sp)
    80004620:	07013c23          	sd	a6,120(sp)
    80004624:	09113023          	sd	a7,128(sp)
    80004628:	09213423          	sd	s2,136(sp)
    8000462c:	09313823          	sd	s3,144(sp)
    80004630:	09413c23          	sd	s4,152(sp)
    80004634:	0b513023          	sd	s5,160(sp)
    80004638:	0b613423          	sd	s6,168(sp)
    8000463c:	0b713823          	sd	s7,176(sp)
    80004640:	0b813c23          	sd	s8,184(sp)
    80004644:	0d913023          	sd	s9,192(sp)
    80004648:	0da13423          	sd	s10,200(sp)
    8000464c:	0db13823          	sd	s11,208(sp)
    80004650:	0dc13c23          	sd	t3,216(sp)
    80004654:	0fd13023          	sd	t4,224(sp)
    80004658:	0fe13423          	sd	t5,232(sp)
    8000465c:	0ff13823          	sd	t6,240(sp)
    80004660:	cd5ff0ef          	jal	ra,80004334 <kerneltrap>
    80004664:	00013083          	ld	ra,0(sp)
    80004668:	00813103          	ld	sp,8(sp)
    8000466c:	01013183          	ld	gp,16(sp)
    80004670:	02013283          	ld	t0,32(sp)
    80004674:	02813303          	ld	t1,40(sp)
    80004678:	03013383          	ld	t2,48(sp)
    8000467c:	03813403          	ld	s0,56(sp)
    80004680:	04013483          	ld	s1,64(sp)
    80004684:	04813503          	ld	a0,72(sp)
    80004688:	05013583          	ld	a1,80(sp)
    8000468c:	05813603          	ld	a2,88(sp)
    80004690:	06013683          	ld	a3,96(sp)
    80004694:	06813703          	ld	a4,104(sp)
    80004698:	07013783          	ld	a5,112(sp)
    8000469c:	07813803          	ld	a6,120(sp)
    800046a0:	08013883          	ld	a7,128(sp)
    800046a4:	08813903          	ld	s2,136(sp)
    800046a8:	09013983          	ld	s3,144(sp)
    800046ac:	09813a03          	ld	s4,152(sp)
    800046b0:	0a013a83          	ld	s5,160(sp)
    800046b4:	0a813b03          	ld	s6,168(sp)
    800046b8:	0b013b83          	ld	s7,176(sp)
    800046bc:	0b813c03          	ld	s8,184(sp)
    800046c0:	0c013c83          	ld	s9,192(sp)
    800046c4:	0c813d03          	ld	s10,200(sp)
    800046c8:	0d013d83          	ld	s11,208(sp)
    800046cc:	0d813e03          	ld	t3,216(sp)
    800046d0:	0e013e83          	ld	t4,224(sp)
    800046d4:	0e813f03          	ld	t5,232(sp)
    800046d8:	0f013f83          	ld	t6,240(sp)
    800046dc:	10010113          	addi	sp,sp,256
    800046e0:	10200073          	sret
    800046e4:	00000013          	nop
    800046e8:	00000013          	nop
    800046ec:	00000013          	nop

00000000800046f0 <timervec>:
    800046f0:	34051573          	csrrw	a0,mscratch,a0
    800046f4:	00b53023          	sd	a1,0(a0)
    800046f8:	00c53423          	sd	a2,8(a0)
    800046fc:	00d53823          	sd	a3,16(a0)
    80004700:	01853583          	ld	a1,24(a0)
    80004704:	02053603          	ld	a2,32(a0)
    80004708:	0005b683          	ld	a3,0(a1)
    8000470c:	00c686b3          	add	a3,a3,a2
    80004710:	00d5b023          	sd	a3,0(a1)
    80004714:	00200593          	li	a1,2
    80004718:	14459073          	csrw	sip,a1
    8000471c:	01053683          	ld	a3,16(a0)
    80004720:	00853603          	ld	a2,8(a0)
    80004724:	00053583          	ld	a1,0(a0)
    80004728:	34051573          	csrrw	a0,mscratch,a0
    8000472c:	30200073          	mret

0000000080004730 <plicinit>:
    80004730:	ff010113          	addi	sp,sp,-16
    80004734:	00813423          	sd	s0,8(sp)
    80004738:	01010413          	addi	s0,sp,16
    8000473c:	00813403          	ld	s0,8(sp)
    80004740:	0c0007b7          	lui	a5,0xc000
    80004744:	00100713          	li	a4,1
    80004748:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000474c:	00e7a223          	sw	a4,4(a5)
    80004750:	01010113          	addi	sp,sp,16
    80004754:	00008067          	ret

0000000080004758 <plicinithart>:
    80004758:	ff010113          	addi	sp,sp,-16
    8000475c:	00813023          	sd	s0,0(sp)
    80004760:	00113423          	sd	ra,8(sp)
    80004764:	01010413          	addi	s0,sp,16
    80004768:	00000097          	auipc	ra,0x0
    8000476c:	a4c080e7          	jalr	-1460(ra) # 800041b4 <cpuid>
    80004770:	0085171b          	slliw	a4,a0,0x8
    80004774:	0c0027b7          	lui	a5,0xc002
    80004778:	00e787b3          	add	a5,a5,a4
    8000477c:	40200713          	li	a4,1026
    80004780:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80004784:	00813083          	ld	ra,8(sp)
    80004788:	00013403          	ld	s0,0(sp)
    8000478c:	00d5151b          	slliw	a0,a0,0xd
    80004790:	0c2017b7          	lui	a5,0xc201
    80004794:	00a78533          	add	a0,a5,a0
    80004798:	00052023          	sw	zero,0(a0)
    8000479c:	01010113          	addi	sp,sp,16
    800047a0:	00008067          	ret

00000000800047a4 <plic_claim>:
    800047a4:	ff010113          	addi	sp,sp,-16
    800047a8:	00813023          	sd	s0,0(sp)
    800047ac:	00113423          	sd	ra,8(sp)
    800047b0:	01010413          	addi	s0,sp,16
    800047b4:	00000097          	auipc	ra,0x0
    800047b8:	a00080e7          	jalr	-1536(ra) # 800041b4 <cpuid>
    800047bc:	00813083          	ld	ra,8(sp)
    800047c0:	00013403          	ld	s0,0(sp)
    800047c4:	00d5151b          	slliw	a0,a0,0xd
    800047c8:	0c2017b7          	lui	a5,0xc201
    800047cc:	00a78533          	add	a0,a5,a0
    800047d0:	00452503          	lw	a0,4(a0)
    800047d4:	01010113          	addi	sp,sp,16
    800047d8:	00008067          	ret

00000000800047dc <plic_complete>:
    800047dc:	fe010113          	addi	sp,sp,-32
    800047e0:	00813823          	sd	s0,16(sp)
    800047e4:	00913423          	sd	s1,8(sp)
    800047e8:	00113c23          	sd	ra,24(sp)
    800047ec:	02010413          	addi	s0,sp,32
    800047f0:	00050493          	mv	s1,a0
    800047f4:	00000097          	auipc	ra,0x0
    800047f8:	9c0080e7          	jalr	-1600(ra) # 800041b4 <cpuid>
    800047fc:	01813083          	ld	ra,24(sp)
    80004800:	01013403          	ld	s0,16(sp)
    80004804:	00d5179b          	slliw	a5,a0,0xd
    80004808:	0c201737          	lui	a4,0xc201
    8000480c:	00f707b3          	add	a5,a4,a5
    80004810:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004814:	00813483          	ld	s1,8(sp)
    80004818:	02010113          	addi	sp,sp,32
    8000481c:	00008067          	ret

0000000080004820 <consolewrite>:
    80004820:	fb010113          	addi	sp,sp,-80
    80004824:	04813023          	sd	s0,64(sp)
    80004828:	04113423          	sd	ra,72(sp)
    8000482c:	02913c23          	sd	s1,56(sp)
    80004830:	03213823          	sd	s2,48(sp)
    80004834:	03313423          	sd	s3,40(sp)
    80004838:	03413023          	sd	s4,32(sp)
    8000483c:	01513c23          	sd	s5,24(sp)
    80004840:	05010413          	addi	s0,sp,80
    80004844:	06c05c63          	blez	a2,800048bc <consolewrite+0x9c>
    80004848:	00060993          	mv	s3,a2
    8000484c:	00050a13          	mv	s4,a0
    80004850:	00058493          	mv	s1,a1
    80004854:	00000913          	li	s2,0
    80004858:	fff00a93          	li	s5,-1
    8000485c:	01c0006f          	j	80004878 <consolewrite+0x58>
    80004860:	fbf44503          	lbu	a0,-65(s0)
    80004864:	0019091b          	addiw	s2,s2,1
    80004868:	00148493          	addi	s1,s1,1
    8000486c:	00001097          	auipc	ra,0x1
    80004870:	a9c080e7          	jalr	-1380(ra) # 80005308 <uartputc>
    80004874:	03298063          	beq	s3,s2,80004894 <consolewrite+0x74>
    80004878:	00048613          	mv	a2,s1
    8000487c:	00100693          	li	a3,1
    80004880:	000a0593          	mv	a1,s4
    80004884:	fbf40513          	addi	a0,s0,-65
    80004888:	00000097          	auipc	ra,0x0
    8000488c:	9e4080e7          	jalr	-1564(ra) # 8000426c <either_copyin>
    80004890:	fd5518e3          	bne	a0,s5,80004860 <consolewrite+0x40>
    80004894:	04813083          	ld	ra,72(sp)
    80004898:	04013403          	ld	s0,64(sp)
    8000489c:	03813483          	ld	s1,56(sp)
    800048a0:	02813983          	ld	s3,40(sp)
    800048a4:	02013a03          	ld	s4,32(sp)
    800048a8:	01813a83          	ld	s5,24(sp)
    800048ac:	00090513          	mv	a0,s2
    800048b0:	03013903          	ld	s2,48(sp)
    800048b4:	05010113          	addi	sp,sp,80
    800048b8:	00008067          	ret
    800048bc:	00000913          	li	s2,0
    800048c0:	fd5ff06f          	j	80004894 <consolewrite+0x74>

00000000800048c4 <consoleread>:
    800048c4:	f9010113          	addi	sp,sp,-112
    800048c8:	06813023          	sd	s0,96(sp)
    800048cc:	04913c23          	sd	s1,88(sp)
    800048d0:	05213823          	sd	s2,80(sp)
    800048d4:	05313423          	sd	s3,72(sp)
    800048d8:	05413023          	sd	s4,64(sp)
    800048dc:	03513c23          	sd	s5,56(sp)
    800048e0:	03613823          	sd	s6,48(sp)
    800048e4:	03713423          	sd	s7,40(sp)
    800048e8:	03813023          	sd	s8,32(sp)
    800048ec:	06113423          	sd	ra,104(sp)
    800048f0:	01913c23          	sd	s9,24(sp)
    800048f4:	07010413          	addi	s0,sp,112
    800048f8:	00060b93          	mv	s7,a2
    800048fc:	00050913          	mv	s2,a0
    80004900:	00058c13          	mv	s8,a1
    80004904:	00060b1b          	sext.w	s6,a2
    80004908:	00005497          	auipc	s1,0x5
    8000490c:	21048493          	addi	s1,s1,528 # 80009b18 <cons>
    80004910:	00400993          	li	s3,4
    80004914:	fff00a13          	li	s4,-1
    80004918:	00a00a93          	li	s5,10
    8000491c:	05705e63          	blez	s7,80004978 <consoleread+0xb4>
    80004920:	09c4a703          	lw	a4,156(s1)
    80004924:	0984a783          	lw	a5,152(s1)
    80004928:	0007071b          	sext.w	a4,a4
    8000492c:	08e78463          	beq	a5,a4,800049b4 <consoleread+0xf0>
    80004930:	07f7f713          	andi	a4,a5,127
    80004934:	00e48733          	add	a4,s1,a4
    80004938:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000493c:	0017869b          	addiw	a3,a5,1
    80004940:	08d4ac23          	sw	a3,152(s1)
    80004944:	00070c9b          	sext.w	s9,a4
    80004948:	0b370663          	beq	a4,s3,800049f4 <consoleread+0x130>
    8000494c:	00100693          	li	a3,1
    80004950:	f9f40613          	addi	a2,s0,-97
    80004954:	000c0593          	mv	a1,s8
    80004958:	00090513          	mv	a0,s2
    8000495c:	f8e40fa3          	sb	a4,-97(s0)
    80004960:	00000097          	auipc	ra,0x0
    80004964:	8c0080e7          	jalr	-1856(ra) # 80004220 <either_copyout>
    80004968:	01450863          	beq	a0,s4,80004978 <consoleread+0xb4>
    8000496c:	001c0c13          	addi	s8,s8,1
    80004970:	fffb8b9b          	addiw	s7,s7,-1
    80004974:	fb5c94e3          	bne	s9,s5,8000491c <consoleread+0x58>
    80004978:	000b851b          	sext.w	a0,s7
    8000497c:	06813083          	ld	ra,104(sp)
    80004980:	06013403          	ld	s0,96(sp)
    80004984:	05813483          	ld	s1,88(sp)
    80004988:	05013903          	ld	s2,80(sp)
    8000498c:	04813983          	ld	s3,72(sp)
    80004990:	04013a03          	ld	s4,64(sp)
    80004994:	03813a83          	ld	s5,56(sp)
    80004998:	02813b83          	ld	s7,40(sp)
    8000499c:	02013c03          	ld	s8,32(sp)
    800049a0:	01813c83          	ld	s9,24(sp)
    800049a4:	40ab053b          	subw	a0,s6,a0
    800049a8:	03013b03          	ld	s6,48(sp)
    800049ac:	07010113          	addi	sp,sp,112
    800049b0:	00008067          	ret
    800049b4:	00001097          	auipc	ra,0x1
    800049b8:	1d8080e7          	jalr	472(ra) # 80005b8c <push_on>
    800049bc:	0984a703          	lw	a4,152(s1)
    800049c0:	09c4a783          	lw	a5,156(s1)
    800049c4:	0007879b          	sext.w	a5,a5
    800049c8:	fef70ce3          	beq	a4,a5,800049c0 <consoleread+0xfc>
    800049cc:	00001097          	auipc	ra,0x1
    800049d0:	234080e7          	jalr	564(ra) # 80005c00 <pop_on>
    800049d4:	0984a783          	lw	a5,152(s1)
    800049d8:	07f7f713          	andi	a4,a5,127
    800049dc:	00e48733          	add	a4,s1,a4
    800049e0:	01874703          	lbu	a4,24(a4)
    800049e4:	0017869b          	addiw	a3,a5,1
    800049e8:	08d4ac23          	sw	a3,152(s1)
    800049ec:	00070c9b          	sext.w	s9,a4
    800049f0:	f5371ee3          	bne	a4,s3,8000494c <consoleread+0x88>
    800049f4:	000b851b          	sext.w	a0,s7
    800049f8:	f96bf2e3          	bgeu	s7,s6,8000497c <consoleread+0xb8>
    800049fc:	08f4ac23          	sw	a5,152(s1)
    80004a00:	f7dff06f          	j	8000497c <consoleread+0xb8>

0000000080004a04 <consputc>:
    80004a04:	10000793          	li	a5,256
    80004a08:	00f50663          	beq	a0,a5,80004a14 <consputc+0x10>
    80004a0c:	00001317          	auipc	t1,0x1
    80004a10:	9f430067          	jr	-1548(t1) # 80005400 <uartputc_sync>
    80004a14:	ff010113          	addi	sp,sp,-16
    80004a18:	00113423          	sd	ra,8(sp)
    80004a1c:	00813023          	sd	s0,0(sp)
    80004a20:	01010413          	addi	s0,sp,16
    80004a24:	00800513          	li	a0,8
    80004a28:	00001097          	auipc	ra,0x1
    80004a2c:	9d8080e7          	jalr	-1576(ra) # 80005400 <uartputc_sync>
    80004a30:	02000513          	li	a0,32
    80004a34:	00001097          	auipc	ra,0x1
    80004a38:	9cc080e7          	jalr	-1588(ra) # 80005400 <uartputc_sync>
    80004a3c:	00013403          	ld	s0,0(sp)
    80004a40:	00813083          	ld	ra,8(sp)
    80004a44:	00800513          	li	a0,8
    80004a48:	01010113          	addi	sp,sp,16
    80004a4c:	00001317          	auipc	t1,0x1
    80004a50:	9b430067          	jr	-1612(t1) # 80005400 <uartputc_sync>

0000000080004a54 <consoleintr>:
    80004a54:	fe010113          	addi	sp,sp,-32
    80004a58:	00813823          	sd	s0,16(sp)
    80004a5c:	00913423          	sd	s1,8(sp)
    80004a60:	01213023          	sd	s2,0(sp)
    80004a64:	00113c23          	sd	ra,24(sp)
    80004a68:	02010413          	addi	s0,sp,32
    80004a6c:	00005917          	auipc	s2,0x5
    80004a70:	0ac90913          	addi	s2,s2,172 # 80009b18 <cons>
    80004a74:	00050493          	mv	s1,a0
    80004a78:	00090513          	mv	a0,s2
    80004a7c:	00001097          	auipc	ra,0x1
    80004a80:	e40080e7          	jalr	-448(ra) # 800058bc <acquire>
    80004a84:	02048c63          	beqz	s1,80004abc <consoleintr+0x68>
    80004a88:	0a092783          	lw	a5,160(s2)
    80004a8c:	09892703          	lw	a4,152(s2)
    80004a90:	07f00693          	li	a3,127
    80004a94:	40e7873b          	subw	a4,a5,a4
    80004a98:	02e6e263          	bltu	a3,a4,80004abc <consoleintr+0x68>
    80004a9c:	00d00713          	li	a4,13
    80004aa0:	04e48063          	beq	s1,a4,80004ae0 <consoleintr+0x8c>
    80004aa4:	07f7f713          	andi	a4,a5,127
    80004aa8:	00e90733          	add	a4,s2,a4
    80004aac:	0017879b          	addiw	a5,a5,1
    80004ab0:	0af92023          	sw	a5,160(s2)
    80004ab4:	00970c23          	sb	s1,24(a4)
    80004ab8:	08f92e23          	sw	a5,156(s2)
    80004abc:	01013403          	ld	s0,16(sp)
    80004ac0:	01813083          	ld	ra,24(sp)
    80004ac4:	00813483          	ld	s1,8(sp)
    80004ac8:	00013903          	ld	s2,0(sp)
    80004acc:	00005517          	auipc	a0,0x5
    80004ad0:	04c50513          	addi	a0,a0,76 # 80009b18 <cons>
    80004ad4:	02010113          	addi	sp,sp,32
    80004ad8:	00001317          	auipc	t1,0x1
    80004adc:	eb030067          	jr	-336(t1) # 80005988 <release>
    80004ae0:	00a00493          	li	s1,10
    80004ae4:	fc1ff06f          	j	80004aa4 <consoleintr+0x50>

0000000080004ae8 <consoleinit>:
    80004ae8:	fe010113          	addi	sp,sp,-32
    80004aec:	00113c23          	sd	ra,24(sp)
    80004af0:	00813823          	sd	s0,16(sp)
    80004af4:	00913423          	sd	s1,8(sp)
    80004af8:	02010413          	addi	s0,sp,32
    80004afc:	00005497          	auipc	s1,0x5
    80004b00:	01c48493          	addi	s1,s1,28 # 80009b18 <cons>
    80004b04:	00048513          	mv	a0,s1
    80004b08:	00003597          	auipc	a1,0x3
    80004b0c:	85058593          	addi	a1,a1,-1968 # 80007358 <CONSOLE_STATUS+0x348>
    80004b10:	00001097          	auipc	ra,0x1
    80004b14:	d88080e7          	jalr	-632(ra) # 80005898 <initlock>
    80004b18:	00000097          	auipc	ra,0x0
    80004b1c:	7ac080e7          	jalr	1964(ra) # 800052c4 <uartinit>
    80004b20:	01813083          	ld	ra,24(sp)
    80004b24:	01013403          	ld	s0,16(sp)
    80004b28:	00000797          	auipc	a5,0x0
    80004b2c:	d9c78793          	addi	a5,a5,-612 # 800048c4 <consoleread>
    80004b30:	0af4bc23          	sd	a5,184(s1)
    80004b34:	00000797          	auipc	a5,0x0
    80004b38:	cec78793          	addi	a5,a5,-788 # 80004820 <consolewrite>
    80004b3c:	0cf4b023          	sd	a5,192(s1)
    80004b40:	00813483          	ld	s1,8(sp)
    80004b44:	02010113          	addi	sp,sp,32
    80004b48:	00008067          	ret

0000000080004b4c <console_read>:
    80004b4c:	ff010113          	addi	sp,sp,-16
    80004b50:	00813423          	sd	s0,8(sp)
    80004b54:	01010413          	addi	s0,sp,16
    80004b58:	00813403          	ld	s0,8(sp)
    80004b5c:	00005317          	auipc	t1,0x5
    80004b60:	07433303          	ld	t1,116(t1) # 80009bd0 <devsw+0x10>
    80004b64:	01010113          	addi	sp,sp,16
    80004b68:	00030067          	jr	t1

0000000080004b6c <console_write>:
    80004b6c:	ff010113          	addi	sp,sp,-16
    80004b70:	00813423          	sd	s0,8(sp)
    80004b74:	01010413          	addi	s0,sp,16
    80004b78:	00813403          	ld	s0,8(sp)
    80004b7c:	00005317          	auipc	t1,0x5
    80004b80:	05c33303          	ld	t1,92(t1) # 80009bd8 <devsw+0x18>
    80004b84:	01010113          	addi	sp,sp,16
    80004b88:	00030067          	jr	t1

0000000080004b8c <panic>:
    80004b8c:	fe010113          	addi	sp,sp,-32
    80004b90:	00113c23          	sd	ra,24(sp)
    80004b94:	00813823          	sd	s0,16(sp)
    80004b98:	00913423          	sd	s1,8(sp)
    80004b9c:	02010413          	addi	s0,sp,32
    80004ba0:	00050493          	mv	s1,a0
    80004ba4:	00002517          	auipc	a0,0x2
    80004ba8:	7bc50513          	addi	a0,a0,1980 # 80007360 <CONSOLE_STATUS+0x350>
    80004bac:	00005797          	auipc	a5,0x5
    80004bb0:	0c07a623          	sw	zero,204(a5) # 80009c78 <pr+0x18>
    80004bb4:	00000097          	auipc	ra,0x0
    80004bb8:	034080e7          	jalr	52(ra) # 80004be8 <__printf>
    80004bbc:	00048513          	mv	a0,s1
    80004bc0:	00000097          	auipc	ra,0x0
    80004bc4:	028080e7          	jalr	40(ra) # 80004be8 <__printf>
    80004bc8:	00002517          	auipc	a0,0x2
    80004bcc:	5b850513          	addi	a0,a0,1464 # 80007180 <CONSOLE_STATUS+0x170>
    80004bd0:	00000097          	auipc	ra,0x0
    80004bd4:	018080e7          	jalr	24(ra) # 80004be8 <__printf>
    80004bd8:	00100793          	li	a5,1
    80004bdc:	00004717          	auipc	a4,0x4
    80004be0:	d8f72e23          	sw	a5,-612(a4) # 80008978 <panicked>
    80004be4:	0000006f          	j	80004be4 <panic+0x58>

0000000080004be8 <__printf>:
    80004be8:	f3010113          	addi	sp,sp,-208
    80004bec:	08813023          	sd	s0,128(sp)
    80004bf0:	07313423          	sd	s3,104(sp)
    80004bf4:	09010413          	addi	s0,sp,144
    80004bf8:	05813023          	sd	s8,64(sp)
    80004bfc:	08113423          	sd	ra,136(sp)
    80004c00:	06913c23          	sd	s1,120(sp)
    80004c04:	07213823          	sd	s2,112(sp)
    80004c08:	07413023          	sd	s4,96(sp)
    80004c0c:	05513c23          	sd	s5,88(sp)
    80004c10:	05613823          	sd	s6,80(sp)
    80004c14:	05713423          	sd	s7,72(sp)
    80004c18:	03913c23          	sd	s9,56(sp)
    80004c1c:	03a13823          	sd	s10,48(sp)
    80004c20:	03b13423          	sd	s11,40(sp)
    80004c24:	00005317          	auipc	t1,0x5
    80004c28:	03c30313          	addi	t1,t1,60 # 80009c60 <pr>
    80004c2c:	01832c03          	lw	s8,24(t1)
    80004c30:	00b43423          	sd	a1,8(s0)
    80004c34:	00c43823          	sd	a2,16(s0)
    80004c38:	00d43c23          	sd	a3,24(s0)
    80004c3c:	02e43023          	sd	a4,32(s0)
    80004c40:	02f43423          	sd	a5,40(s0)
    80004c44:	03043823          	sd	a6,48(s0)
    80004c48:	03143c23          	sd	a7,56(s0)
    80004c4c:	00050993          	mv	s3,a0
    80004c50:	4a0c1663          	bnez	s8,800050fc <__printf+0x514>
    80004c54:	60098c63          	beqz	s3,8000526c <__printf+0x684>
    80004c58:	0009c503          	lbu	a0,0(s3)
    80004c5c:	00840793          	addi	a5,s0,8
    80004c60:	f6f43c23          	sd	a5,-136(s0)
    80004c64:	00000493          	li	s1,0
    80004c68:	22050063          	beqz	a0,80004e88 <__printf+0x2a0>
    80004c6c:	00002a37          	lui	s4,0x2
    80004c70:	00018ab7          	lui	s5,0x18
    80004c74:	000f4b37          	lui	s6,0xf4
    80004c78:	00989bb7          	lui	s7,0x989
    80004c7c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004c80:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004c84:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004c88:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80004c8c:	00148c9b          	addiw	s9,s1,1
    80004c90:	02500793          	li	a5,37
    80004c94:	01998933          	add	s2,s3,s9
    80004c98:	38f51263          	bne	a0,a5,8000501c <__printf+0x434>
    80004c9c:	00094783          	lbu	a5,0(s2)
    80004ca0:	00078c9b          	sext.w	s9,a5
    80004ca4:	1e078263          	beqz	a5,80004e88 <__printf+0x2a0>
    80004ca8:	0024849b          	addiw	s1,s1,2
    80004cac:	07000713          	li	a4,112
    80004cb0:	00998933          	add	s2,s3,s1
    80004cb4:	38e78a63          	beq	a5,a4,80005048 <__printf+0x460>
    80004cb8:	20f76863          	bltu	a4,a5,80004ec8 <__printf+0x2e0>
    80004cbc:	42a78863          	beq	a5,a0,800050ec <__printf+0x504>
    80004cc0:	06400713          	li	a4,100
    80004cc4:	40e79663          	bne	a5,a4,800050d0 <__printf+0x4e8>
    80004cc8:	f7843783          	ld	a5,-136(s0)
    80004ccc:	0007a603          	lw	a2,0(a5)
    80004cd0:	00878793          	addi	a5,a5,8
    80004cd4:	f6f43c23          	sd	a5,-136(s0)
    80004cd8:	42064a63          	bltz	a2,8000510c <__printf+0x524>
    80004cdc:	00a00713          	li	a4,10
    80004ce0:	02e677bb          	remuw	a5,a2,a4
    80004ce4:	00002d97          	auipc	s11,0x2
    80004ce8:	6a4d8d93          	addi	s11,s11,1700 # 80007388 <digits>
    80004cec:	00900593          	li	a1,9
    80004cf0:	0006051b          	sext.w	a0,a2
    80004cf4:	00000c93          	li	s9,0
    80004cf8:	02079793          	slli	a5,a5,0x20
    80004cfc:	0207d793          	srli	a5,a5,0x20
    80004d00:	00fd87b3          	add	a5,s11,a5
    80004d04:	0007c783          	lbu	a5,0(a5)
    80004d08:	02e656bb          	divuw	a3,a2,a4
    80004d0c:	f8f40023          	sb	a5,-128(s0)
    80004d10:	14c5d863          	bge	a1,a2,80004e60 <__printf+0x278>
    80004d14:	06300593          	li	a1,99
    80004d18:	00100c93          	li	s9,1
    80004d1c:	02e6f7bb          	remuw	a5,a3,a4
    80004d20:	02079793          	slli	a5,a5,0x20
    80004d24:	0207d793          	srli	a5,a5,0x20
    80004d28:	00fd87b3          	add	a5,s11,a5
    80004d2c:	0007c783          	lbu	a5,0(a5)
    80004d30:	02e6d73b          	divuw	a4,a3,a4
    80004d34:	f8f400a3          	sb	a5,-127(s0)
    80004d38:	12a5f463          	bgeu	a1,a0,80004e60 <__printf+0x278>
    80004d3c:	00a00693          	li	a3,10
    80004d40:	00900593          	li	a1,9
    80004d44:	02d777bb          	remuw	a5,a4,a3
    80004d48:	02079793          	slli	a5,a5,0x20
    80004d4c:	0207d793          	srli	a5,a5,0x20
    80004d50:	00fd87b3          	add	a5,s11,a5
    80004d54:	0007c503          	lbu	a0,0(a5)
    80004d58:	02d757bb          	divuw	a5,a4,a3
    80004d5c:	f8a40123          	sb	a0,-126(s0)
    80004d60:	48e5f263          	bgeu	a1,a4,800051e4 <__printf+0x5fc>
    80004d64:	06300513          	li	a0,99
    80004d68:	02d7f5bb          	remuw	a1,a5,a3
    80004d6c:	02059593          	slli	a1,a1,0x20
    80004d70:	0205d593          	srli	a1,a1,0x20
    80004d74:	00bd85b3          	add	a1,s11,a1
    80004d78:	0005c583          	lbu	a1,0(a1)
    80004d7c:	02d7d7bb          	divuw	a5,a5,a3
    80004d80:	f8b401a3          	sb	a1,-125(s0)
    80004d84:	48e57263          	bgeu	a0,a4,80005208 <__printf+0x620>
    80004d88:	3e700513          	li	a0,999
    80004d8c:	02d7f5bb          	remuw	a1,a5,a3
    80004d90:	02059593          	slli	a1,a1,0x20
    80004d94:	0205d593          	srli	a1,a1,0x20
    80004d98:	00bd85b3          	add	a1,s11,a1
    80004d9c:	0005c583          	lbu	a1,0(a1)
    80004da0:	02d7d7bb          	divuw	a5,a5,a3
    80004da4:	f8b40223          	sb	a1,-124(s0)
    80004da8:	46e57663          	bgeu	a0,a4,80005214 <__printf+0x62c>
    80004dac:	02d7f5bb          	remuw	a1,a5,a3
    80004db0:	02059593          	slli	a1,a1,0x20
    80004db4:	0205d593          	srli	a1,a1,0x20
    80004db8:	00bd85b3          	add	a1,s11,a1
    80004dbc:	0005c583          	lbu	a1,0(a1)
    80004dc0:	02d7d7bb          	divuw	a5,a5,a3
    80004dc4:	f8b402a3          	sb	a1,-123(s0)
    80004dc8:	46ea7863          	bgeu	s4,a4,80005238 <__printf+0x650>
    80004dcc:	02d7f5bb          	remuw	a1,a5,a3
    80004dd0:	02059593          	slli	a1,a1,0x20
    80004dd4:	0205d593          	srli	a1,a1,0x20
    80004dd8:	00bd85b3          	add	a1,s11,a1
    80004ddc:	0005c583          	lbu	a1,0(a1)
    80004de0:	02d7d7bb          	divuw	a5,a5,a3
    80004de4:	f8b40323          	sb	a1,-122(s0)
    80004de8:	3eeaf863          	bgeu	s5,a4,800051d8 <__printf+0x5f0>
    80004dec:	02d7f5bb          	remuw	a1,a5,a3
    80004df0:	02059593          	slli	a1,a1,0x20
    80004df4:	0205d593          	srli	a1,a1,0x20
    80004df8:	00bd85b3          	add	a1,s11,a1
    80004dfc:	0005c583          	lbu	a1,0(a1)
    80004e00:	02d7d7bb          	divuw	a5,a5,a3
    80004e04:	f8b403a3          	sb	a1,-121(s0)
    80004e08:	42eb7e63          	bgeu	s6,a4,80005244 <__printf+0x65c>
    80004e0c:	02d7f5bb          	remuw	a1,a5,a3
    80004e10:	02059593          	slli	a1,a1,0x20
    80004e14:	0205d593          	srli	a1,a1,0x20
    80004e18:	00bd85b3          	add	a1,s11,a1
    80004e1c:	0005c583          	lbu	a1,0(a1)
    80004e20:	02d7d7bb          	divuw	a5,a5,a3
    80004e24:	f8b40423          	sb	a1,-120(s0)
    80004e28:	42ebfc63          	bgeu	s7,a4,80005260 <__printf+0x678>
    80004e2c:	02079793          	slli	a5,a5,0x20
    80004e30:	0207d793          	srli	a5,a5,0x20
    80004e34:	00fd8db3          	add	s11,s11,a5
    80004e38:	000dc703          	lbu	a4,0(s11)
    80004e3c:	00a00793          	li	a5,10
    80004e40:	00900c93          	li	s9,9
    80004e44:	f8e404a3          	sb	a4,-119(s0)
    80004e48:	00065c63          	bgez	a2,80004e60 <__printf+0x278>
    80004e4c:	f9040713          	addi	a4,s0,-112
    80004e50:	00f70733          	add	a4,a4,a5
    80004e54:	02d00693          	li	a3,45
    80004e58:	fed70823          	sb	a3,-16(a4)
    80004e5c:	00078c93          	mv	s9,a5
    80004e60:	f8040793          	addi	a5,s0,-128
    80004e64:	01978cb3          	add	s9,a5,s9
    80004e68:	f7f40d13          	addi	s10,s0,-129
    80004e6c:	000cc503          	lbu	a0,0(s9)
    80004e70:	fffc8c93          	addi	s9,s9,-1
    80004e74:	00000097          	auipc	ra,0x0
    80004e78:	b90080e7          	jalr	-1136(ra) # 80004a04 <consputc>
    80004e7c:	ffac98e3          	bne	s9,s10,80004e6c <__printf+0x284>
    80004e80:	00094503          	lbu	a0,0(s2)
    80004e84:	e00514e3          	bnez	a0,80004c8c <__printf+0xa4>
    80004e88:	1a0c1663          	bnez	s8,80005034 <__printf+0x44c>
    80004e8c:	08813083          	ld	ra,136(sp)
    80004e90:	08013403          	ld	s0,128(sp)
    80004e94:	07813483          	ld	s1,120(sp)
    80004e98:	07013903          	ld	s2,112(sp)
    80004e9c:	06813983          	ld	s3,104(sp)
    80004ea0:	06013a03          	ld	s4,96(sp)
    80004ea4:	05813a83          	ld	s5,88(sp)
    80004ea8:	05013b03          	ld	s6,80(sp)
    80004eac:	04813b83          	ld	s7,72(sp)
    80004eb0:	04013c03          	ld	s8,64(sp)
    80004eb4:	03813c83          	ld	s9,56(sp)
    80004eb8:	03013d03          	ld	s10,48(sp)
    80004ebc:	02813d83          	ld	s11,40(sp)
    80004ec0:	0d010113          	addi	sp,sp,208
    80004ec4:	00008067          	ret
    80004ec8:	07300713          	li	a4,115
    80004ecc:	1ce78a63          	beq	a5,a4,800050a0 <__printf+0x4b8>
    80004ed0:	07800713          	li	a4,120
    80004ed4:	1ee79e63          	bne	a5,a4,800050d0 <__printf+0x4e8>
    80004ed8:	f7843783          	ld	a5,-136(s0)
    80004edc:	0007a703          	lw	a4,0(a5)
    80004ee0:	00878793          	addi	a5,a5,8
    80004ee4:	f6f43c23          	sd	a5,-136(s0)
    80004ee8:	28074263          	bltz	a4,8000516c <__printf+0x584>
    80004eec:	00002d97          	auipc	s11,0x2
    80004ef0:	49cd8d93          	addi	s11,s11,1180 # 80007388 <digits>
    80004ef4:	00f77793          	andi	a5,a4,15
    80004ef8:	00fd87b3          	add	a5,s11,a5
    80004efc:	0007c683          	lbu	a3,0(a5)
    80004f00:	00f00613          	li	a2,15
    80004f04:	0007079b          	sext.w	a5,a4
    80004f08:	f8d40023          	sb	a3,-128(s0)
    80004f0c:	0047559b          	srliw	a1,a4,0x4
    80004f10:	0047569b          	srliw	a3,a4,0x4
    80004f14:	00000c93          	li	s9,0
    80004f18:	0ee65063          	bge	a2,a4,80004ff8 <__printf+0x410>
    80004f1c:	00f6f693          	andi	a3,a3,15
    80004f20:	00dd86b3          	add	a3,s11,a3
    80004f24:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004f28:	0087d79b          	srliw	a5,a5,0x8
    80004f2c:	00100c93          	li	s9,1
    80004f30:	f8d400a3          	sb	a3,-127(s0)
    80004f34:	0cb67263          	bgeu	a2,a1,80004ff8 <__printf+0x410>
    80004f38:	00f7f693          	andi	a3,a5,15
    80004f3c:	00dd86b3          	add	a3,s11,a3
    80004f40:	0006c583          	lbu	a1,0(a3)
    80004f44:	00f00613          	li	a2,15
    80004f48:	0047d69b          	srliw	a3,a5,0x4
    80004f4c:	f8b40123          	sb	a1,-126(s0)
    80004f50:	0047d593          	srli	a1,a5,0x4
    80004f54:	28f67e63          	bgeu	a2,a5,800051f0 <__printf+0x608>
    80004f58:	00f6f693          	andi	a3,a3,15
    80004f5c:	00dd86b3          	add	a3,s11,a3
    80004f60:	0006c503          	lbu	a0,0(a3)
    80004f64:	0087d813          	srli	a6,a5,0x8
    80004f68:	0087d69b          	srliw	a3,a5,0x8
    80004f6c:	f8a401a3          	sb	a0,-125(s0)
    80004f70:	28b67663          	bgeu	a2,a1,800051fc <__printf+0x614>
    80004f74:	00f6f693          	andi	a3,a3,15
    80004f78:	00dd86b3          	add	a3,s11,a3
    80004f7c:	0006c583          	lbu	a1,0(a3)
    80004f80:	00c7d513          	srli	a0,a5,0xc
    80004f84:	00c7d69b          	srliw	a3,a5,0xc
    80004f88:	f8b40223          	sb	a1,-124(s0)
    80004f8c:	29067a63          	bgeu	a2,a6,80005220 <__printf+0x638>
    80004f90:	00f6f693          	andi	a3,a3,15
    80004f94:	00dd86b3          	add	a3,s11,a3
    80004f98:	0006c583          	lbu	a1,0(a3)
    80004f9c:	0107d813          	srli	a6,a5,0x10
    80004fa0:	0107d69b          	srliw	a3,a5,0x10
    80004fa4:	f8b402a3          	sb	a1,-123(s0)
    80004fa8:	28a67263          	bgeu	a2,a0,8000522c <__printf+0x644>
    80004fac:	00f6f693          	andi	a3,a3,15
    80004fb0:	00dd86b3          	add	a3,s11,a3
    80004fb4:	0006c683          	lbu	a3,0(a3)
    80004fb8:	0147d79b          	srliw	a5,a5,0x14
    80004fbc:	f8d40323          	sb	a3,-122(s0)
    80004fc0:	21067663          	bgeu	a2,a6,800051cc <__printf+0x5e4>
    80004fc4:	02079793          	slli	a5,a5,0x20
    80004fc8:	0207d793          	srli	a5,a5,0x20
    80004fcc:	00fd8db3          	add	s11,s11,a5
    80004fd0:	000dc683          	lbu	a3,0(s11)
    80004fd4:	00800793          	li	a5,8
    80004fd8:	00700c93          	li	s9,7
    80004fdc:	f8d403a3          	sb	a3,-121(s0)
    80004fe0:	00075c63          	bgez	a4,80004ff8 <__printf+0x410>
    80004fe4:	f9040713          	addi	a4,s0,-112
    80004fe8:	00f70733          	add	a4,a4,a5
    80004fec:	02d00693          	li	a3,45
    80004ff0:	fed70823          	sb	a3,-16(a4)
    80004ff4:	00078c93          	mv	s9,a5
    80004ff8:	f8040793          	addi	a5,s0,-128
    80004ffc:	01978cb3          	add	s9,a5,s9
    80005000:	f7f40d13          	addi	s10,s0,-129
    80005004:	000cc503          	lbu	a0,0(s9)
    80005008:	fffc8c93          	addi	s9,s9,-1
    8000500c:	00000097          	auipc	ra,0x0
    80005010:	9f8080e7          	jalr	-1544(ra) # 80004a04 <consputc>
    80005014:	ff9d18e3          	bne	s10,s9,80005004 <__printf+0x41c>
    80005018:	0100006f          	j	80005028 <__printf+0x440>
    8000501c:	00000097          	auipc	ra,0x0
    80005020:	9e8080e7          	jalr	-1560(ra) # 80004a04 <consputc>
    80005024:	000c8493          	mv	s1,s9
    80005028:	00094503          	lbu	a0,0(s2)
    8000502c:	c60510e3          	bnez	a0,80004c8c <__printf+0xa4>
    80005030:	e40c0ee3          	beqz	s8,80004e8c <__printf+0x2a4>
    80005034:	00005517          	auipc	a0,0x5
    80005038:	c2c50513          	addi	a0,a0,-980 # 80009c60 <pr>
    8000503c:	00001097          	auipc	ra,0x1
    80005040:	94c080e7          	jalr	-1716(ra) # 80005988 <release>
    80005044:	e49ff06f          	j	80004e8c <__printf+0x2a4>
    80005048:	f7843783          	ld	a5,-136(s0)
    8000504c:	03000513          	li	a0,48
    80005050:	01000d13          	li	s10,16
    80005054:	00878713          	addi	a4,a5,8
    80005058:	0007bc83          	ld	s9,0(a5)
    8000505c:	f6e43c23          	sd	a4,-136(s0)
    80005060:	00000097          	auipc	ra,0x0
    80005064:	9a4080e7          	jalr	-1628(ra) # 80004a04 <consputc>
    80005068:	07800513          	li	a0,120
    8000506c:	00000097          	auipc	ra,0x0
    80005070:	998080e7          	jalr	-1640(ra) # 80004a04 <consputc>
    80005074:	00002d97          	auipc	s11,0x2
    80005078:	314d8d93          	addi	s11,s11,788 # 80007388 <digits>
    8000507c:	03ccd793          	srli	a5,s9,0x3c
    80005080:	00fd87b3          	add	a5,s11,a5
    80005084:	0007c503          	lbu	a0,0(a5)
    80005088:	fffd0d1b          	addiw	s10,s10,-1
    8000508c:	004c9c93          	slli	s9,s9,0x4
    80005090:	00000097          	auipc	ra,0x0
    80005094:	974080e7          	jalr	-1676(ra) # 80004a04 <consputc>
    80005098:	fe0d12e3          	bnez	s10,8000507c <__printf+0x494>
    8000509c:	f8dff06f          	j	80005028 <__printf+0x440>
    800050a0:	f7843783          	ld	a5,-136(s0)
    800050a4:	0007bc83          	ld	s9,0(a5)
    800050a8:	00878793          	addi	a5,a5,8
    800050ac:	f6f43c23          	sd	a5,-136(s0)
    800050b0:	000c9a63          	bnez	s9,800050c4 <__printf+0x4dc>
    800050b4:	1080006f          	j	800051bc <__printf+0x5d4>
    800050b8:	001c8c93          	addi	s9,s9,1
    800050bc:	00000097          	auipc	ra,0x0
    800050c0:	948080e7          	jalr	-1720(ra) # 80004a04 <consputc>
    800050c4:	000cc503          	lbu	a0,0(s9)
    800050c8:	fe0518e3          	bnez	a0,800050b8 <__printf+0x4d0>
    800050cc:	f5dff06f          	j	80005028 <__printf+0x440>
    800050d0:	02500513          	li	a0,37
    800050d4:	00000097          	auipc	ra,0x0
    800050d8:	930080e7          	jalr	-1744(ra) # 80004a04 <consputc>
    800050dc:	000c8513          	mv	a0,s9
    800050e0:	00000097          	auipc	ra,0x0
    800050e4:	924080e7          	jalr	-1756(ra) # 80004a04 <consputc>
    800050e8:	f41ff06f          	j	80005028 <__printf+0x440>
    800050ec:	02500513          	li	a0,37
    800050f0:	00000097          	auipc	ra,0x0
    800050f4:	914080e7          	jalr	-1772(ra) # 80004a04 <consputc>
    800050f8:	f31ff06f          	j	80005028 <__printf+0x440>
    800050fc:	00030513          	mv	a0,t1
    80005100:	00000097          	auipc	ra,0x0
    80005104:	7bc080e7          	jalr	1980(ra) # 800058bc <acquire>
    80005108:	b4dff06f          	j	80004c54 <__printf+0x6c>
    8000510c:	40c0053b          	negw	a0,a2
    80005110:	00a00713          	li	a4,10
    80005114:	02e576bb          	remuw	a3,a0,a4
    80005118:	00002d97          	auipc	s11,0x2
    8000511c:	270d8d93          	addi	s11,s11,624 # 80007388 <digits>
    80005120:	ff700593          	li	a1,-9
    80005124:	02069693          	slli	a3,a3,0x20
    80005128:	0206d693          	srli	a3,a3,0x20
    8000512c:	00dd86b3          	add	a3,s11,a3
    80005130:	0006c683          	lbu	a3,0(a3)
    80005134:	02e557bb          	divuw	a5,a0,a4
    80005138:	f8d40023          	sb	a3,-128(s0)
    8000513c:	10b65e63          	bge	a2,a1,80005258 <__printf+0x670>
    80005140:	06300593          	li	a1,99
    80005144:	02e7f6bb          	remuw	a3,a5,a4
    80005148:	02069693          	slli	a3,a3,0x20
    8000514c:	0206d693          	srli	a3,a3,0x20
    80005150:	00dd86b3          	add	a3,s11,a3
    80005154:	0006c683          	lbu	a3,0(a3)
    80005158:	02e7d73b          	divuw	a4,a5,a4
    8000515c:	00200793          	li	a5,2
    80005160:	f8d400a3          	sb	a3,-127(s0)
    80005164:	bca5ece3          	bltu	a1,a0,80004d3c <__printf+0x154>
    80005168:	ce5ff06f          	j	80004e4c <__printf+0x264>
    8000516c:	40e007bb          	negw	a5,a4
    80005170:	00002d97          	auipc	s11,0x2
    80005174:	218d8d93          	addi	s11,s11,536 # 80007388 <digits>
    80005178:	00f7f693          	andi	a3,a5,15
    8000517c:	00dd86b3          	add	a3,s11,a3
    80005180:	0006c583          	lbu	a1,0(a3)
    80005184:	ff100613          	li	a2,-15
    80005188:	0047d69b          	srliw	a3,a5,0x4
    8000518c:	f8b40023          	sb	a1,-128(s0)
    80005190:	0047d59b          	srliw	a1,a5,0x4
    80005194:	0ac75e63          	bge	a4,a2,80005250 <__printf+0x668>
    80005198:	00f6f693          	andi	a3,a3,15
    8000519c:	00dd86b3          	add	a3,s11,a3
    800051a0:	0006c603          	lbu	a2,0(a3)
    800051a4:	00f00693          	li	a3,15
    800051a8:	0087d79b          	srliw	a5,a5,0x8
    800051ac:	f8c400a3          	sb	a2,-127(s0)
    800051b0:	d8b6e4e3          	bltu	a3,a1,80004f38 <__printf+0x350>
    800051b4:	00200793          	li	a5,2
    800051b8:	e2dff06f          	j	80004fe4 <__printf+0x3fc>
    800051bc:	00002c97          	auipc	s9,0x2
    800051c0:	1acc8c93          	addi	s9,s9,428 # 80007368 <CONSOLE_STATUS+0x358>
    800051c4:	02800513          	li	a0,40
    800051c8:	ef1ff06f          	j	800050b8 <__printf+0x4d0>
    800051cc:	00700793          	li	a5,7
    800051d0:	00600c93          	li	s9,6
    800051d4:	e0dff06f          	j	80004fe0 <__printf+0x3f8>
    800051d8:	00700793          	li	a5,7
    800051dc:	00600c93          	li	s9,6
    800051e0:	c69ff06f          	j	80004e48 <__printf+0x260>
    800051e4:	00300793          	li	a5,3
    800051e8:	00200c93          	li	s9,2
    800051ec:	c5dff06f          	j	80004e48 <__printf+0x260>
    800051f0:	00300793          	li	a5,3
    800051f4:	00200c93          	li	s9,2
    800051f8:	de9ff06f          	j	80004fe0 <__printf+0x3f8>
    800051fc:	00400793          	li	a5,4
    80005200:	00300c93          	li	s9,3
    80005204:	dddff06f          	j	80004fe0 <__printf+0x3f8>
    80005208:	00400793          	li	a5,4
    8000520c:	00300c93          	li	s9,3
    80005210:	c39ff06f          	j	80004e48 <__printf+0x260>
    80005214:	00500793          	li	a5,5
    80005218:	00400c93          	li	s9,4
    8000521c:	c2dff06f          	j	80004e48 <__printf+0x260>
    80005220:	00500793          	li	a5,5
    80005224:	00400c93          	li	s9,4
    80005228:	db9ff06f          	j	80004fe0 <__printf+0x3f8>
    8000522c:	00600793          	li	a5,6
    80005230:	00500c93          	li	s9,5
    80005234:	dadff06f          	j	80004fe0 <__printf+0x3f8>
    80005238:	00600793          	li	a5,6
    8000523c:	00500c93          	li	s9,5
    80005240:	c09ff06f          	j	80004e48 <__printf+0x260>
    80005244:	00800793          	li	a5,8
    80005248:	00700c93          	li	s9,7
    8000524c:	bfdff06f          	j	80004e48 <__printf+0x260>
    80005250:	00100793          	li	a5,1
    80005254:	d91ff06f          	j	80004fe4 <__printf+0x3fc>
    80005258:	00100793          	li	a5,1
    8000525c:	bf1ff06f          	j	80004e4c <__printf+0x264>
    80005260:	00900793          	li	a5,9
    80005264:	00800c93          	li	s9,8
    80005268:	be1ff06f          	j	80004e48 <__printf+0x260>
    8000526c:	00002517          	auipc	a0,0x2
    80005270:	10450513          	addi	a0,a0,260 # 80007370 <CONSOLE_STATUS+0x360>
    80005274:	00000097          	auipc	ra,0x0
    80005278:	918080e7          	jalr	-1768(ra) # 80004b8c <panic>

000000008000527c <printfinit>:
    8000527c:	fe010113          	addi	sp,sp,-32
    80005280:	00813823          	sd	s0,16(sp)
    80005284:	00913423          	sd	s1,8(sp)
    80005288:	00113c23          	sd	ra,24(sp)
    8000528c:	02010413          	addi	s0,sp,32
    80005290:	00005497          	auipc	s1,0x5
    80005294:	9d048493          	addi	s1,s1,-1584 # 80009c60 <pr>
    80005298:	00048513          	mv	a0,s1
    8000529c:	00002597          	auipc	a1,0x2
    800052a0:	0e458593          	addi	a1,a1,228 # 80007380 <CONSOLE_STATUS+0x370>
    800052a4:	00000097          	auipc	ra,0x0
    800052a8:	5f4080e7          	jalr	1524(ra) # 80005898 <initlock>
    800052ac:	01813083          	ld	ra,24(sp)
    800052b0:	01013403          	ld	s0,16(sp)
    800052b4:	0004ac23          	sw	zero,24(s1)
    800052b8:	00813483          	ld	s1,8(sp)
    800052bc:	02010113          	addi	sp,sp,32
    800052c0:	00008067          	ret

00000000800052c4 <uartinit>:
    800052c4:	ff010113          	addi	sp,sp,-16
    800052c8:	00813423          	sd	s0,8(sp)
    800052cc:	01010413          	addi	s0,sp,16
    800052d0:	100007b7          	lui	a5,0x10000
    800052d4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800052d8:	f8000713          	li	a4,-128
    800052dc:	00e781a3          	sb	a4,3(a5)
    800052e0:	00300713          	li	a4,3
    800052e4:	00e78023          	sb	a4,0(a5)
    800052e8:	000780a3          	sb	zero,1(a5)
    800052ec:	00e781a3          	sb	a4,3(a5)
    800052f0:	00700693          	li	a3,7
    800052f4:	00d78123          	sb	a3,2(a5)
    800052f8:	00e780a3          	sb	a4,1(a5)
    800052fc:	00813403          	ld	s0,8(sp)
    80005300:	01010113          	addi	sp,sp,16
    80005304:	00008067          	ret

0000000080005308 <uartputc>:
    80005308:	00003797          	auipc	a5,0x3
    8000530c:	6707a783          	lw	a5,1648(a5) # 80008978 <panicked>
    80005310:	00078463          	beqz	a5,80005318 <uartputc+0x10>
    80005314:	0000006f          	j	80005314 <uartputc+0xc>
    80005318:	fd010113          	addi	sp,sp,-48
    8000531c:	02813023          	sd	s0,32(sp)
    80005320:	00913c23          	sd	s1,24(sp)
    80005324:	01213823          	sd	s2,16(sp)
    80005328:	01313423          	sd	s3,8(sp)
    8000532c:	02113423          	sd	ra,40(sp)
    80005330:	03010413          	addi	s0,sp,48
    80005334:	00003917          	auipc	s2,0x3
    80005338:	64c90913          	addi	s2,s2,1612 # 80008980 <uart_tx_r>
    8000533c:	00093783          	ld	a5,0(s2)
    80005340:	00003497          	auipc	s1,0x3
    80005344:	64848493          	addi	s1,s1,1608 # 80008988 <uart_tx_w>
    80005348:	0004b703          	ld	a4,0(s1)
    8000534c:	02078693          	addi	a3,a5,32
    80005350:	00050993          	mv	s3,a0
    80005354:	02e69c63          	bne	a3,a4,8000538c <uartputc+0x84>
    80005358:	00001097          	auipc	ra,0x1
    8000535c:	834080e7          	jalr	-1996(ra) # 80005b8c <push_on>
    80005360:	00093783          	ld	a5,0(s2)
    80005364:	0004b703          	ld	a4,0(s1)
    80005368:	02078793          	addi	a5,a5,32
    8000536c:	00e79463          	bne	a5,a4,80005374 <uartputc+0x6c>
    80005370:	0000006f          	j	80005370 <uartputc+0x68>
    80005374:	00001097          	auipc	ra,0x1
    80005378:	88c080e7          	jalr	-1908(ra) # 80005c00 <pop_on>
    8000537c:	00093783          	ld	a5,0(s2)
    80005380:	0004b703          	ld	a4,0(s1)
    80005384:	02078693          	addi	a3,a5,32
    80005388:	fce688e3          	beq	a3,a4,80005358 <uartputc+0x50>
    8000538c:	01f77693          	andi	a3,a4,31
    80005390:	00005597          	auipc	a1,0x5
    80005394:	8f058593          	addi	a1,a1,-1808 # 80009c80 <uart_tx_buf>
    80005398:	00d586b3          	add	a3,a1,a3
    8000539c:	00170713          	addi	a4,a4,1
    800053a0:	01368023          	sb	s3,0(a3)
    800053a4:	00e4b023          	sd	a4,0(s1)
    800053a8:	10000637          	lui	a2,0x10000
    800053ac:	02f71063          	bne	a4,a5,800053cc <uartputc+0xc4>
    800053b0:	0340006f          	j	800053e4 <uartputc+0xdc>
    800053b4:	00074703          	lbu	a4,0(a4)
    800053b8:	00f93023          	sd	a5,0(s2)
    800053bc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800053c0:	00093783          	ld	a5,0(s2)
    800053c4:	0004b703          	ld	a4,0(s1)
    800053c8:	00f70e63          	beq	a4,a5,800053e4 <uartputc+0xdc>
    800053cc:	00564683          	lbu	a3,5(a2)
    800053d0:	01f7f713          	andi	a4,a5,31
    800053d4:	00e58733          	add	a4,a1,a4
    800053d8:	0206f693          	andi	a3,a3,32
    800053dc:	00178793          	addi	a5,a5,1
    800053e0:	fc069ae3          	bnez	a3,800053b4 <uartputc+0xac>
    800053e4:	02813083          	ld	ra,40(sp)
    800053e8:	02013403          	ld	s0,32(sp)
    800053ec:	01813483          	ld	s1,24(sp)
    800053f0:	01013903          	ld	s2,16(sp)
    800053f4:	00813983          	ld	s3,8(sp)
    800053f8:	03010113          	addi	sp,sp,48
    800053fc:	00008067          	ret

0000000080005400 <uartputc_sync>:
    80005400:	ff010113          	addi	sp,sp,-16
    80005404:	00813423          	sd	s0,8(sp)
    80005408:	01010413          	addi	s0,sp,16
    8000540c:	00003717          	auipc	a4,0x3
    80005410:	56c72703          	lw	a4,1388(a4) # 80008978 <panicked>
    80005414:	02071663          	bnez	a4,80005440 <uartputc_sync+0x40>
    80005418:	00050793          	mv	a5,a0
    8000541c:	100006b7          	lui	a3,0x10000
    80005420:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005424:	02077713          	andi	a4,a4,32
    80005428:	fe070ce3          	beqz	a4,80005420 <uartputc_sync+0x20>
    8000542c:	0ff7f793          	andi	a5,a5,255
    80005430:	00f68023          	sb	a5,0(a3)
    80005434:	00813403          	ld	s0,8(sp)
    80005438:	01010113          	addi	sp,sp,16
    8000543c:	00008067          	ret
    80005440:	0000006f          	j	80005440 <uartputc_sync+0x40>

0000000080005444 <uartstart>:
    80005444:	ff010113          	addi	sp,sp,-16
    80005448:	00813423          	sd	s0,8(sp)
    8000544c:	01010413          	addi	s0,sp,16
    80005450:	00003617          	auipc	a2,0x3
    80005454:	53060613          	addi	a2,a2,1328 # 80008980 <uart_tx_r>
    80005458:	00003517          	auipc	a0,0x3
    8000545c:	53050513          	addi	a0,a0,1328 # 80008988 <uart_tx_w>
    80005460:	00063783          	ld	a5,0(a2)
    80005464:	00053703          	ld	a4,0(a0)
    80005468:	04f70263          	beq	a4,a5,800054ac <uartstart+0x68>
    8000546c:	100005b7          	lui	a1,0x10000
    80005470:	00005817          	auipc	a6,0x5
    80005474:	81080813          	addi	a6,a6,-2032 # 80009c80 <uart_tx_buf>
    80005478:	01c0006f          	j	80005494 <uartstart+0x50>
    8000547c:	0006c703          	lbu	a4,0(a3)
    80005480:	00f63023          	sd	a5,0(a2)
    80005484:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005488:	00063783          	ld	a5,0(a2)
    8000548c:	00053703          	ld	a4,0(a0)
    80005490:	00f70e63          	beq	a4,a5,800054ac <uartstart+0x68>
    80005494:	01f7f713          	andi	a4,a5,31
    80005498:	00e806b3          	add	a3,a6,a4
    8000549c:	0055c703          	lbu	a4,5(a1)
    800054a0:	00178793          	addi	a5,a5,1
    800054a4:	02077713          	andi	a4,a4,32
    800054a8:	fc071ae3          	bnez	a4,8000547c <uartstart+0x38>
    800054ac:	00813403          	ld	s0,8(sp)
    800054b0:	01010113          	addi	sp,sp,16
    800054b4:	00008067          	ret

00000000800054b8 <uartgetc>:
    800054b8:	ff010113          	addi	sp,sp,-16
    800054bc:	00813423          	sd	s0,8(sp)
    800054c0:	01010413          	addi	s0,sp,16
    800054c4:	10000737          	lui	a4,0x10000
    800054c8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800054cc:	0017f793          	andi	a5,a5,1
    800054d0:	00078c63          	beqz	a5,800054e8 <uartgetc+0x30>
    800054d4:	00074503          	lbu	a0,0(a4)
    800054d8:	0ff57513          	andi	a0,a0,255
    800054dc:	00813403          	ld	s0,8(sp)
    800054e0:	01010113          	addi	sp,sp,16
    800054e4:	00008067          	ret
    800054e8:	fff00513          	li	a0,-1
    800054ec:	ff1ff06f          	j	800054dc <uartgetc+0x24>

00000000800054f0 <uartintr>:
    800054f0:	100007b7          	lui	a5,0x10000
    800054f4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800054f8:	0017f793          	andi	a5,a5,1
    800054fc:	0a078463          	beqz	a5,800055a4 <uartintr+0xb4>
    80005500:	fe010113          	addi	sp,sp,-32
    80005504:	00813823          	sd	s0,16(sp)
    80005508:	00913423          	sd	s1,8(sp)
    8000550c:	00113c23          	sd	ra,24(sp)
    80005510:	02010413          	addi	s0,sp,32
    80005514:	100004b7          	lui	s1,0x10000
    80005518:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000551c:	0ff57513          	andi	a0,a0,255
    80005520:	fffff097          	auipc	ra,0xfffff
    80005524:	534080e7          	jalr	1332(ra) # 80004a54 <consoleintr>
    80005528:	0054c783          	lbu	a5,5(s1)
    8000552c:	0017f793          	andi	a5,a5,1
    80005530:	fe0794e3          	bnez	a5,80005518 <uartintr+0x28>
    80005534:	00003617          	auipc	a2,0x3
    80005538:	44c60613          	addi	a2,a2,1100 # 80008980 <uart_tx_r>
    8000553c:	00003517          	auipc	a0,0x3
    80005540:	44c50513          	addi	a0,a0,1100 # 80008988 <uart_tx_w>
    80005544:	00063783          	ld	a5,0(a2)
    80005548:	00053703          	ld	a4,0(a0)
    8000554c:	04f70263          	beq	a4,a5,80005590 <uartintr+0xa0>
    80005550:	100005b7          	lui	a1,0x10000
    80005554:	00004817          	auipc	a6,0x4
    80005558:	72c80813          	addi	a6,a6,1836 # 80009c80 <uart_tx_buf>
    8000555c:	01c0006f          	j	80005578 <uartintr+0x88>
    80005560:	0006c703          	lbu	a4,0(a3)
    80005564:	00f63023          	sd	a5,0(a2)
    80005568:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000556c:	00063783          	ld	a5,0(a2)
    80005570:	00053703          	ld	a4,0(a0)
    80005574:	00f70e63          	beq	a4,a5,80005590 <uartintr+0xa0>
    80005578:	01f7f713          	andi	a4,a5,31
    8000557c:	00e806b3          	add	a3,a6,a4
    80005580:	0055c703          	lbu	a4,5(a1)
    80005584:	00178793          	addi	a5,a5,1
    80005588:	02077713          	andi	a4,a4,32
    8000558c:	fc071ae3          	bnez	a4,80005560 <uartintr+0x70>
    80005590:	01813083          	ld	ra,24(sp)
    80005594:	01013403          	ld	s0,16(sp)
    80005598:	00813483          	ld	s1,8(sp)
    8000559c:	02010113          	addi	sp,sp,32
    800055a0:	00008067          	ret
    800055a4:	00003617          	auipc	a2,0x3
    800055a8:	3dc60613          	addi	a2,a2,988 # 80008980 <uart_tx_r>
    800055ac:	00003517          	auipc	a0,0x3
    800055b0:	3dc50513          	addi	a0,a0,988 # 80008988 <uart_tx_w>
    800055b4:	00063783          	ld	a5,0(a2)
    800055b8:	00053703          	ld	a4,0(a0)
    800055bc:	04f70263          	beq	a4,a5,80005600 <uartintr+0x110>
    800055c0:	100005b7          	lui	a1,0x10000
    800055c4:	00004817          	auipc	a6,0x4
    800055c8:	6bc80813          	addi	a6,a6,1724 # 80009c80 <uart_tx_buf>
    800055cc:	01c0006f          	j	800055e8 <uartintr+0xf8>
    800055d0:	0006c703          	lbu	a4,0(a3)
    800055d4:	00f63023          	sd	a5,0(a2)
    800055d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800055dc:	00063783          	ld	a5,0(a2)
    800055e0:	00053703          	ld	a4,0(a0)
    800055e4:	02f70063          	beq	a4,a5,80005604 <uartintr+0x114>
    800055e8:	01f7f713          	andi	a4,a5,31
    800055ec:	00e806b3          	add	a3,a6,a4
    800055f0:	0055c703          	lbu	a4,5(a1)
    800055f4:	00178793          	addi	a5,a5,1
    800055f8:	02077713          	andi	a4,a4,32
    800055fc:	fc071ae3          	bnez	a4,800055d0 <uartintr+0xe0>
    80005600:	00008067          	ret
    80005604:	00008067          	ret

0000000080005608 <kinit>:
    80005608:	fc010113          	addi	sp,sp,-64
    8000560c:	02913423          	sd	s1,40(sp)
    80005610:	fffff7b7          	lui	a5,0xfffff
    80005614:	00005497          	auipc	s1,0x5
    80005618:	68b48493          	addi	s1,s1,1675 # 8000ac9f <end+0xfff>
    8000561c:	02813823          	sd	s0,48(sp)
    80005620:	01313c23          	sd	s3,24(sp)
    80005624:	00f4f4b3          	and	s1,s1,a5
    80005628:	02113c23          	sd	ra,56(sp)
    8000562c:	03213023          	sd	s2,32(sp)
    80005630:	01413823          	sd	s4,16(sp)
    80005634:	01513423          	sd	s5,8(sp)
    80005638:	04010413          	addi	s0,sp,64
    8000563c:	000017b7          	lui	a5,0x1
    80005640:	01100993          	li	s3,17
    80005644:	00f487b3          	add	a5,s1,a5
    80005648:	01b99993          	slli	s3,s3,0x1b
    8000564c:	06f9e063          	bltu	s3,a5,800056ac <kinit+0xa4>
    80005650:	00004a97          	auipc	s5,0x4
    80005654:	650a8a93          	addi	s5,s5,1616 # 80009ca0 <end>
    80005658:	0754ec63          	bltu	s1,s5,800056d0 <kinit+0xc8>
    8000565c:	0734fa63          	bgeu	s1,s3,800056d0 <kinit+0xc8>
    80005660:	00088a37          	lui	s4,0x88
    80005664:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005668:	00003917          	auipc	s2,0x3
    8000566c:	32890913          	addi	s2,s2,808 # 80008990 <kmem>
    80005670:	00ca1a13          	slli	s4,s4,0xc
    80005674:	0140006f          	j	80005688 <kinit+0x80>
    80005678:	000017b7          	lui	a5,0x1
    8000567c:	00f484b3          	add	s1,s1,a5
    80005680:	0554e863          	bltu	s1,s5,800056d0 <kinit+0xc8>
    80005684:	0534f663          	bgeu	s1,s3,800056d0 <kinit+0xc8>
    80005688:	00001637          	lui	a2,0x1
    8000568c:	00100593          	li	a1,1
    80005690:	00048513          	mv	a0,s1
    80005694:	00000097          	auipc	ra,0x0
    80005698:	5e4080e7          	jalr	1508(ra) # 80005c78 <__memset>
    8000569c:	00093783          	ld	a5,0(s2)
    800056a0:	00f4b023          	sd	a5,0(s1)
    800056a4:	00993023          	sd	s1,0(s2)
    800056a8:	fd4498e3          	bne	s1,s4,80005678 <kinit+0x70>
    800056ac:	03813083          	ld	ra,56(sp)
    800056b0:	03013403          	ld	s0,48(sp)
    800056b4:	02813483          	ld	s1,40(sp)
    800056b8:	02013903          	ld	s2,32(sp)
    800056bc:	01813983          	ld	s3,24(sp)
    800056c0:	01013a03          	ld	s4,16(sp)
    800056c4:	00813a83          	ld	s5,8(sp)
    800056c8:	04010113          	addi	sp,sp,64
    800056cc:	00008067          	ret
    800056d0:	00002517          	auipc	a0,0x2
    800056d4:	cd050513          	addi	a0,a0,-816 # 800073a0 <digits+0x18>
    800056d8:	fffff097          	auipc	ra,0xfffff
    800056dc:	4b4080e7          	jalr	1204(ra) # 80004b8c <panic>

00000000800056e0 <freerange>:
    800056e0:	fc010113          	addi	sp,sp,-64
    800056e4:	000017b7          	lui	a5,0x1
    800056e8:	02913423          	sd	s1,40(sp)
    800056ec:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800056f0:	009504b3          	add	s1,a0,s1
    800056f4:	fffff537          	lui	a0,0xfffff
    800056f8:	02813823          	sd	s0,48(sp)
    800056fc:	02113c23          	sd	ra,56(sp)
    80005700:	03213023          	sd	s2,32(sp)
    80005704:	01313c23          	sd	s3,24(sp)
    80005708:	01413823          	sd	s4,16(sp)
    8000570c:	01513423          	sd	s5,8(sp)
    80005710:	01613023          	sd	s6,0(sp)
    80005714:	04010413          	addi	s0,sp,64
    80005718:	00a4f4b3          	and	s1,s1,a0
    8000571c:	00f487b3          	add	a5,s1,a5
    80005720:	06f5e463          	bltu	a1,a5,80005788 <freerange+0xa8>
    80005724:	00004a97          	auipc	s5,0x4
    80005728:	57ca8a93          	addi	s5,s5,1404 # 80009ca0 <end>
    8000572c:	0954e263          	bltu	s1,s5,800057b0 <freerange+0xd0>
    80005730:	01100993          	li	s3,17
    80005734:	01b99993          	slli	s3,s3,0x1b
    80005738:	0734fc63          	bgeu	s1,s3,800057b0 <freerange+0xd0>
    8000573c:	00058a13          	mv	s4,a1
    80005740:	00003917          	auipc	s2,0x3
    80005744:	25090913          	addi	s2,s2,592 # 80008990 <kmem>
    80005748:	00002b37          	lui	s6,0x2
    8000574c:	0140006f          	j	80005760 <freerange+0x80>
    80005750:	000017b7          	lui	a5,0x1
    80005754:	00f484b3          	add	s1,s1,a5
    80005758:	0554ec63          	bltu	s1,s5,800057b0 <freerange+0xd0>
    8000575c:	0534fa63          	bgeu	s1,s3,800057b0 <freerange+0xd0>
    80005760:	00001637          	lui	a2,0x1
    80005764:	00100593          	li	a1,1
    80005768:	00048513          	mv	a0,s1
    8000576c:	00000097          	auipc	ra,0x0
    80005770:	50c080e7          	jalr	1292(ra) # 80005c78 <__memset>
    80005774:	00093703          	ld	a4,0(s2)
    80005778:	016487b3          	add	a5,s1,s6
    8000577c:	00e4b023          	sd	a4,0(s1)
    80005780:	00993023          	sd	s1,0(s2)
    80005784:	fcfa76e3          	bgeu	s4,a5,80005750 <freerange+0x70>
    80005788:	03813083          	ld	ra,56(sp)
    8000578c:	03013403          	ld	s0,48(sp)
    80005790:	02813483          	ld	s1,40(sp)
    80005794:	02013903          	ld	s2,32(sp)
    80005798:	01813983          	ld	s3,24(sp)
    8000579c:	01013a03          	ld	s4,16(sp)
    800057a0:	00813a83          	ld	s5,8(sp)
    800057a4:	00013b03          	ld	s6,0(sp)
    800057a8:	04010113          	addi	sp,sp,64
    800057ac:	00008067          	ret
    800057b0:	00002517          	auipc	a0,0x2
    800057b4:	bf050513          	addi	a0,a0,-1040 # 800073a0 <digits+0x18>
    800057b8:	fffff097          	auipc	ra,0xfffff
    800057bc:	3d4080e7          	jalr	980(ra) # 80004b8c <panic>

00000000800057c0 <kfree>:
    800057c0:	fe010113          	addi	sp,sp,-32
    800057c4:	00813823          	sd	s0,16(sp)
    800057c8:	00113c23          	sd	ra,24(sp)
    800057cc:	00913423          	sd	s1,8(sp)
    800057d0:	02010413          	addi	s0,sp,32
    800057d4:	03451793          	slli	a5,a0,0x34
    800057d8:	04079c63          	bnez	a5,80005830 <kfree+0x70>
    800057dc:	00004797          	auipc	a5,0x4
    800057e0:	4c478793          	addi	a5,a5,1220 # 80009ca0 <end>
    800057e4:	00050493          	mv	s1,a0
    800057e8:	04f56463          	bltu	a0,a5,80005830 <kfree+0x70>
    800057ec:	01100793          	li	a5,17
    800057f0:	01b79793          	slli	a5,a5,0x1b
    800057f4:	02f57e63          	bgeu	a0,a5,80005830 <kfree+0x70>
    800057f8:	00001637          	lui	a2,0x1
    800057fc:	00100593          	li	a1,1
    80005800:	00000097          	auipc	ra,0x0
    80005804:	478080e7          	jalr	1144(ra) # 80005c78 <__memset>
    80005808:	00003797          	auipc	a5,0x3
    8000580c:	18878793          	addi	a5,a5,392 # 80008990 <kmem>
    80005810:	0007b703          	ld	a4,0(a5)
    80005814:	01813083          	ld	ra,24(sp)
    80005818:	01013403          	ld	s0,16(sp)
    8000581c:	00e4b023          	sd	a4,0(s1)
    80005820:	0097b023          	sd	s1,0(a5)
    80005824:	00813483          	ld	s1,8(sp)
    80005828:	02010113          	addi	sp,sp,32
    8000582c:	00008067          	ret
    80005830:	00002517          	auipc	a0,0x2
    80005834:	b7050513          	addi	a0,a0,-1168 # 800073a0 <digits+0x18>
    80005838:	fffff097          	auipc	ra,0xfffff
    8000583c:	354080e7          	jalr	852(ra) # 80004b8c <panic>

0000000080005840 <kalloc>:
    80005840:	fe010113          	addi	sp,sp,-32
    80005844:	00813823          	sd	s0,16(sp)
    80005848:	00913423          	sd	s1,8(sp)
    8000584c:	00113c23          	sd	ra,24(sp)
    80005850:	02010413          	addi	s0,sp,32
    80005854:	00003797          	auipc	a5,0x3
    80005858:	13c78793          	addi	a5,a5,316 # 80008990 <kmem>
    8000585c:	0007b483          	ld	s1,0(a5)
    80005860:	02048063          	beqz	s1,80005880 <kalloc+0x40>
    80005864:	0004b703          	ld	a4,0(s1)
    80005868:	00001637          	lui	a2,0x1
    8000586c:	00500593          	li	a1,5
    80005870:	00048513          	mv	a0,s1
    80005874:	00e7b023          	sd	a4,0(a5)
    80005878:	00000097          	auipc	ra,0x0
    8000587c:	400080e7          	jalr	1024(ra) # 80005c78 <__memset>
    80005880:	01813083          	ld	ra,24(sp)
    80005884:	01013403          	ld	s0,16(sp)
    80005888:	00048513          	mv	a0,s1
    8000588c:	00813483          	ld	s1,8(sp)
    80005890:	02010113          	addi	sp,sp,32
    80005894:	00008067          	ret

0000000080005898 <initlock>:
    80005898:	ff010113          	addi	sp,sp,-16
    8000589c:	00813423          	sd	s0,8(sp)
    800058a0:	01010413          	addi	s0,sp,16
    800058a4:	00813403          	ld	s0,8(sp)
    800058a8:	00b53423          	sd	a1,8(a0)
    800058ac:	00052023          	sw	zero,0(a0)
    800058b0:	00053823          	sd	zero,16(a0)
    800058b4:	01010113          	addi	sp,sp,16
    800058b8:	00008067          	ret

00000000800058bc <acquire>:
    800058bc:	fe010113          	addi	sp,sp,-32
    800058c0:	00813823          	sd	s0,16(sp)
    800058c4:	00913423          	sd	s1,8(sp)
    800058c8:	00113c23          	sd	ra,24(sp)
    800058cc:	01213023          	sd	s2,0(sp)
    800058d0:	02010413          	addi	s0,sp,32
    800058d4:	00050493          	mv	s1,a0
    800058d8:	10002973          	csrr	s2,sstatus
    800058dc:	100027f3          	csrr	a5,sstatus
    800058e0:	ffd7f793          	andi	a5,a5,-3
    800058e4:	10079073          	csrw	sstatus,a5
    800058e8:	fffff097          	auipc	ra,0xfffff
    800058ec:	8ec080e7          	jalr	-1812(ra) # 800041d4 <mycpu>
    800058f0:	07852783          	lw	a5,120(a0)
    800058f4:	06078e63          	beqz	a5,80005970 <acquire+0xb4>
    800058f8:	fffff097          	auipc	ra,0xfffff
    800058fc:	8dc080e7          	jalr	-1828(ra) # 800041d4 <mycpu>
    80005900:	07852783          	lw	a5,120(a0)
    80005904:	0004a703          	lw	a4,0(s1)
    80005908:	0017879b          	addiw	a5,a5,1
    8000590c:	06f52c23          	sw	a5,120(a0)
    80005910:	04071063          	bnez	a4,80005950 <acquire+0x94>
    80005914:	00100713          	li	a4,1
    80005918:	00070793          	mv	a5,a4
    8000591c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005920:	0007879b          	sext.w	a5,a5
    80005924:	fe079ae3          	bnez	a5,80005918 <acquire+0x5c>
    80005928:	0ff0000f          	fence
    8000592c:	fffff097          	auipc	ra,0xfffff
    80005930:	8a8080e7          	jalr	-1880(ra) # 800041d4 <mycpu>
    80005934:	01813083          	ld	ra,24(sp)
    80005938:	01013403          	ld	s0,16(sp)
    8000593c:	00a4b823          	sd	a0,16(s1)
    80005940:	00013903          	ld	s2,0(sp)
    80005944:	00813483          	ld	s1,8(sp)
    80005948:	02010113          	addi	sp,sp,32
    8000594c:	00008067          	ret
    80005950:	0104b903          	ld	s2,16(s1)
    80005954:	fffff097          	auipc	ra,0xfffff
    80005958:	880080e7          	jalr	-1920(ra) # 800041d4 <mycpu>
    8000595c:	faa91ce3          	bne	s2,a0,80005914 <acquire+0x58>
    80005960:	00002517          	auipc	a0,0x2
    80005964:	a4850513          	addi	a0,a0,-1464 # 800073a8 <digits+0x20>
    80005968:	fffff097          	auipc	ra,0xfffff
    8000596c:	224080e7          	jalr	548(ra) # 80004b8c <panic>
    80005970:	00195913          	srli	s2,s2,0x1
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	860080e7          	jalr	-1952(ra) # 800041d4 <mycpu>
    8000597c:	00197913          	andi	s2,s2,1
    80005980:	07252e23          	sw	s2,124(a0)
    80005984:	f75ff06f          	j	800058f8 <acquire+0x3c>

0000000080005988 <release>:
    80005988:	fe010113          	addi	sp,sp,-32
    8000598c:	00813823          	sd	s0,16(sp)
    80005990:	00113c23          	sd	ra,24(sp)
    80005994:	00913423          	sd	s1,8(sp)
    80005998:	01213023          	sd	s2,0(sp)
    8000599c:	02010413          	addi	s0,sp,32
    800059a0:	00052783          	lw	a5,0(a0)
    800059a4:	00079a63          	bnez	a5,800059b8 <release+0x30>
    800059a8:	00002517          	auipc	a0,0x2
    800059ac:	a0850513          	addi	a0,a0,-1528 # 800073b0 <digits+0x28>
    800059b0:	fffff097          	auipc	ra,0xfffff
    800059b4:	1dc080e7          	jalr	476(ra) # 80004b8c <panic>
    800059b8:	01053903          	ld	s2,16(a0)
    800059bc:	00050493          	mv	s1,a0
    800059c0:	fffff097          	auipc	ra,0xfffff
    800059c4:	814080e7          	jalr	-2028(ra) # 800041d4 <mycpu>
    800059c8:	fea910e3          	bne	s2,a0,800059a8 <release+0x20>
    800059cc:	0004b823          	sd	zero,16(s1)
    800059d0:	0ff0000f          	fence
    800059d4:	0f50000f          	fence	iorw,ow
    800059d8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800059dc:	ffffe097          	auipc	ra,0xffffe
    800059e0:	7f8080e7          	jalr	2040(ra) # 800041d4 <mycpu>
    800059e4:	100027f3          	csrr	a5,sstatus
    800059e8:	0027f793          	andi	a5,a5,2
    800059ec:	04079a63          	bnez	a5,80005a40 <release+0xb8>
    800059f0:	07852783          	lw	a5,120(a0)
    800059f4:	02f05e63          	blez	a5,80005a30 <release+0xa8>
    800059f8:	fff7871b          	addiw	a4,a5,-1
    800059fc:	06e52c23          	sw	a4,120(a0)
    80005a00:	00071c63          	bnez	a4,80005a18 <release+0x90>
    80005a04:	07c52783          	lw	a5,124(a0)
    80005a08:	00078863          	beqz	a5,80005a18 <release+0x90>
    80005a0c:	100027f3          	csrr	a5,sstatus
    80005a10:	0027e793          	ori	a5,a5,2
    80005a14:	10079073          	csrw	sstatus,a5
    80005a18:	01813083          	ld	ra,24(sp)
    80005a1c:	01013403          	ld	s0,16(sp)
    80005a20:	00813483          	ld	s1,8(sp)
    80005a24:	00013903          	ld	s2,0(sp)
    80005a28:	02010113          	addi	sp,sp,32
    80005a2c:	00008067          	ret
    80005a30:	00002517          	auipc	a0,0x2
    80005a34:	9a050513          	addi	a0,a0,-1632 # 800073d0 <digits+0x48>
    80005a38:	fffff097          	auipc	ra,0xfffff
    80005a3c:	154080e7          	jalr	340(ra) # 80004b8c <panic>
    80005a40:	00002517          	auipc	a0,0x2
    80005a44:	97850513          	addi	a0,a0,-1672 # 800073b8 <digits+0x30>
    80005a48:	fffff097          	auipc	ra,0xfffff
    80005a4c:	144080e7          	jalr	324(ra) # 80004b8c <panic>

0000000080005a50 <holding>:
    80005a50:	00052783          	lw	a5,0(a0)
    80005a54:	00079663          	bnez	a5,80005a60 <holding+0x10>
    80005a58:	00000513          	li	a0,0
    80005a5c:	00008067          	ret
    80005a60:	fe010113          	addi	sp,sp,-32
    80005a64:	00813823          	sd	s0,16(sp)
    80005a68:	00913423          	sd	s1,8(sp)
    80005a6c:	00113c23          	sd	ra,24(sp)
    80005a70:	02010413          	addi	s0,sp,32
    80005a74:	01053483          	ld	s1,16(a0)
    80005a78:	ffffe097          	auipc	ra,0xffffe
    80005a7c:	75c080e7          	jalr	1884(ra) # 800041d4 <mycpu>
    80005a80:	01813083          	ld	ra,24(sp)
    80005a84:	01013403          	ld	s0,16(sp)
    80005a88:	40a48533          	sub	a0,s1,a0
    80005a8c:	00153513          	seqz	a0,a0
    80005a90:	00813483          	ld	s1,8(sp)
    80005a94:	02010113          	addi	sp,sp,32
    80005a98:	00008067          	ret

0000000080005a9c <push_off>:
    80005a9c:	fe010113          	addi	sp,sp,-32
    80005aa0:	00813823          	sd	s0,16(sp)
    80005aa4:	00113c23          	sd	ra,24(sp)
    80005aa8:	00913423          	sd	s1,8(sp)
    80005aac:	02010413          	addi	s0,sp,32
    80005ab0:	100024f3          	csrr	s1,sstatus
    80005ab4:	100027f3          	csrr	a5,sstatus
    80005ab8:	ffd7f793          	andi	a5,a5,-3
    80005abc:	10079073          	csrw	sstatus,a5
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	714080e7          	jalr	1812(ra) # 800041d4 <mycpu>
    80005ac8:	07852783          	lw	a5,120(a0)
    80005acc:	02078663          	beqz	a5,80005af8 <push_off+0x5c>
    80005ad0:	ffffe097          	auipc	ra,0xffffe
    80005ad4:	704080e7          	jalr	1796(ra) # 800041d4 <mycpu>
    80005ad8:	07852783          	lw	a5,120(a0)
    80005adc:	01813083          	ld	ra,24(sp)
    80005ae0:	01013403          	ld	s0,16(sp)
    80005ae4:	0017879b          	addiw	a5,a5,1
    80005ae8:	06f52c23          	sw	a5,120(a0)
    80005aec:	00813483          	ld	s1,8(sp)
    80005af0:	02010113          	addi	sp,sp,32
    80005af4:	00008067          	ret
    80005af8:	0014d493          	srli	s1,s1,0x1
    80005afc:	ffffe097          	auipc	ra,0xffffe
    80005b00:	6d8080e7          	jalr	1752(ra) # 800041d4 <mycpu>
    80005b04:	0014f493          	andi	s1,s1,1
    80005b08:	06952e23          	sw	s1,124(a0)
    80005b0c:	fc5ff06f          	j	80005ad0 <push_off+0x34>

0000000080005b10 <pop_off>:
    80005b10:	ff010113          	addi	sp,sp,-16
    80005b14:	00813023          	sd	s0,0(sp)
    80005b18:	00113423          	sd	ra,8(sp)
    80005b1c:	01010413          	addi	s0,sp,16
    80005b20:	ffffe097          	auipc	ra,0xffffe
    80005b24:	6b4080e7          	jalr	1716(ra) # 800041d4 <mycpu>
    80005b28:	100027f3          	csrr	a5,sstatus
    80005b2c:	0027f793          	andi	a5,a5,2
    80005b30:	04079663          	bnez	a5,80005b7c <pop_off+0x6c>
    80005b34:	07852783          	lw	a5,120(a0)
    80005b38:	02f05a63          	blez	a5,80005b6c <pop_off+0x5c>
    80005b3c:	fff7871b          	addiw	a4,a5,-1
    80005b40:	06e52c23          	sw	a4,120(a0)
    80005b44:	00071c63          	bnez	a4,80005b5c <pop_off+0x4c>
    80005b48:	07c52783          	lw	a5,124(a0)
    80005b4c:	00078863          	beqz	a5,80005b5c <pop_off+0x4c>
    80005b50:	100027f3          	csrr	a5,sstatus
    80005b54:	0027e793          	ori	a5,a5,2
    80005b58:	10079073          	csrw	sstatus,a5
    80005b5c:	00813083          	ld	ra,8(sp)
    80005b60:	00013403          	ld	s0,0(sp)
    80005b64:	01010113          	addi	sp,sp,16
    80005b68:	00008067          	ret
    80005b6c:	00002517          	auipc	a0,0x2
    80005b70:	86450513          	addi	a0,a0,-1948 # 800073d0 <digits+0x48>
    80005b74:	fffff097          	auipc	ra,0xfffff
    80005b78:	018080e7          	jalr	24(ra) # 80004b8c <panic>
    80005b7c:	00002517          	auipc	a0,0x2
    80005b80:	83c50513          	addi	a0,a0,-1988 # 800073b8 <digits+0x30>
    80005b84:	fffff097          	auipc	ra,0xfffff
    80005b88:	008080e7          	jalr	8(ra) # 80004b8c <panic>

0000000080005b8c <push_on>:
    80005b8c:	fe010113          	addi	sp,sp,-32
    80005b90:	00813823          	sd	s0,16(sp)
    80005b94:	00113c23          	sd	ra,24(sp)
    80005b98:	00913423          	sd	s1,8(sp)
    80005b9c:	02010413          	addi	s0,sp,32
    80005ba0:	100024f3          	csrr	s1,sstatus
    80005ba4:	100027f3          	csrr	a5,sstatus
    80005ba8:	0027e793          	ori	a5,a5,2
    80005bac:	10079073          	csrw	sstatus,a5
    80005bb0:	ffffe097          	auipc	ra,0xffffe
    80005bb4:	624080e7          	jalr	1572(ra) # 800041d4 <mycpu>
    80005bb8:	07852783          	lw	a5,120(a0)
    80005bbc:	02078663          	beqz	a5,80005be8 <push_on+0x5c>
    80005bc0:	ffffe097          	auipc	ra,0xffffe
    80005bc4:	614080e7          	jalr	1556(ra) # 800041d4 <mycpu>
    80005bc8:	07852783          	lw	a5,120(a0)
    80005bcc:	01813083          	ld	ra,24(sp)
    80005bd0:	01013403          	ld	s0,16(sp)
    80005bd4:	0017879b          	addiw	a5,a5,1
    80005bd8:	06f52c23          	sw	a5,120(a0)
    80005bdc:	00813483          	ld	s1,8(sp)
    80005be0:	02010113          	addi	sp,sp,32
    80005be4:	00008067          	ret
    80005be8:	0014d493          	srli	s1,s1,0x1
    80005bec:	ffffe097          	auipc	ra,0xffffe
    80005bf0:	5e8080e7          	jalr	1512(ra) # 800041d4 <mycpu>
    80005bf4:	0014f493          	andi	s1,s1,1
    80005bf8:	06952e23          	sw	s1,124(a0)
    80005bfc:	fc5ff06f          	j	80005bc0 <push_on+0x34>

0000000080005c00 <pop_on>:
    80005c00:	ff010113          	addi	sp,sp,-16
    80005c04:	00813023          	sd	s0,0(sp)
    80005c08:	00113423          	sd	ra,8(sp)
    80005c0c:	01010413          	addi	s0,sp,16
    80005c10:	ffffe097          	auipc	ra,0xffffe
    80005c14:	5c4080e7          	jalr	1476(ra) # 800041d4 <mycpu>
    80005c18:	100027f3          	csrr	a5,sstatus
    80005c1c:	0027f793          	andi	a5,a5,2
    80005c20:	04078463          	beqz	a5,80005c68 <pop_on+0x68>
    80005c24:	07852783          	lw	a5,120(a0)
    80005c28:	02f05863          	blez	a5,80005c58 <pop_on+0x58>
    80005c2c:	fff7879b          	addiw	a5,a5,-1
    80005c30:	06f52c23          	sw	a5,120(a0)
    80005c34:	07853783          	ld	a5,120(a0)
    80005c38:	00079863          	bnez	a5,80005c48 <pop_on+0x48>
    80005c3c:	100027f3          	csrr	a5,sstatus
    80005c40:	ffd7f793          	andi	a5,a5,-3
    80005c44:	10079073          	csrw	sstatus,a5
    80005c48:	00813083          	ld	ra,8(sp)
    80005c4c:	00013403          	ld	s0,0(sp)
    80005c50:	01010113          	addi	sp,sp,16
    80005c54:	00008067          	ret
    80005c58:	00001517          	auipc	a0,0x1
    80005c5c:	7a050513          	addi	a0,a0,1952 # 800073f8 <digits+0x70>
    80005c60:	fffff097          	auipc	ra,0xfffff
    80005c64:	f2c080e7          	jalr	-212(ra) # 80004b8c <panic>
    80005c68:	00001517          	auipc	a0,0x1
    80005c6c:	77050513          	addi	a0,a0,1904 # 800073d8 <digits+0x50>
    80005c70:	fffff097          	auipc	ra,0xfffff
    80005c74:	f1c080e7          	jalr	-228(ra) # 80004b8c <panic>

0000000080005c78 <__memset>:
    80005c78:	ff010113          	addi	sp,sp,-16
    80005c7c:	00813423          	sd	s0,8(sp)
    80005c80:	01010413          	addi	s0,sp,16
    80005c84:	1a060e63          	beqz	a2,80005e40 <__memset+0x1c8>
    80005c88:	40a007b3          	neg	a5,a0
    80005c8c:	0077f793          	andi	a5,a5,7
    80005c90:	00778693          	addi	a3,a5,7
    80005c94:	00b00813          	li	a6,11
    80005c98:	0ff5f593          	andi	a1,a1,255
    80005c9c:	fff6071b          	addiw	a4,a2,-1
    80005ca0:	1b06e663          	bltu	a3,a6,80005e4c <__memset+0x1d4>
    80005ca4:	1cd76463          	bltu	a4,a3,80005e6c <__memset+0x1f4>
    80005ca8:	1a078e63          	beqz	a5,80005e64 <__memset+0x1ec>
    80005cac:	00b50023          	sb	a1,0(a0)
    80005cb0:	00100713          	li	a4,1
    80005cb4:	1ae78463          	beq	a5,a4,80005e5c <__memset+0x1e4>
    80005cb8:	00b500a3          	sb	a1,1(a0)
    80005cbc:	00200713          	li	a4,2
    80005cc0:	1ae78a63          	beq	a5,a4,80005e74 <__memset+0x1fc>
    80005cc4:	00b50123          	sb	a1,2(a0)
    80005cc8:	00300713          	li	a4,3
    80005ccc:	18e78463          	beq	a5,a4,80005e54 <__memset+0x1dc>
    80005cd0:	00b501a3          	sb	a1,3(a0)
    80005cd4:	00400713          	li	a4,4
    80005cd8:	1ae78263          	beq	a5,a4,80005e7c <__memset+0x204>
    80005cdc:	00b50223          	sb	a1,4(a0)
    80005ce0:	00500713          	li	a4,5
    80005ce4:	1ae78063          	beq	a5,a4,80005e84 <__memset+0x20c>
    80005ce8:	00b502a3          	sb	a1,5(a0)
    80005cec:	00700713          	li	a4,7
    80005cf0:	18e79e63          	bne	a5,a4,80005e8c <__memset+0x214>
    80005cf4:	00b50323          	sb	a1,6(a0)
    80005cf8:	00700e93          	li	t4,7
    80005cfc:	00859713          	slli	a4,a1,0x8
    80005d00:	00e5e733          	or	a4,a1,a4
    80005d04:	01059e13          	slli	t3,a1,0x10
    80005d08:	01c76e33          	or	t3,a4,t3
    80005d0c:	01859313          	slli	t1,a1,0x18
    80005d10:	006e6333          	or	t1,t3,t1
    80005d14:	02059893          	slli	a7,a1,0x20
    80005d18:	40f60e3b          	subw	t3,a2,a5
    80005d1c:	011368b3          	or	a7,t1,a7
    80005d20:	02859813          	slli	a6,a1,0x28
    80005d24:	0108e833          	or	a6,a7,a6
    80005d28:	03059693          	slli	a3,a1,0x30
    80005d2c:	003e589b          	srliw	a7,t3,0x3
    80005d30:	00d866b3          	or	a3,a6,a3
    80005d34:	03859713          	slli	a4,a1,0x38
    80005d38:	00389813          	slli	a6,a7,0x3
    80005d3c:	00f507b3          	add	a5,a0,a5
    80005d40:	00e6e733          	or	a4,a3,a4
    80005d44:	000e089b          	sext.w	a7,t3
    80005d48:	00f806b3          	add	a3,a6,a5
    80005d4c:	00e7b023          	sd	a4,0(a5)
    80005d50:	00878793          	addi	a5,a5,8
    80005d54:	fed79ce3          	bne	a5,a3,80005d4c <__memset+0xd4>
    80005d58:	ff8e7793          	andi	a5,t3,-8
    80005d5c:	0007871b          	sext.w	a4,a5
    80005d60:	01d787bb          	addw	a5,a5,t4
    80005d64:	0ce88e63          	beq	a7,a4,80005e40 <__memset+0x1c8>
    80005d68:	00f50733          	add	a4,a0,a5
    80005d6c:	00b70023          	sb	a1,0(a4)
    80005d70:	0017871b          	addiw	a4,a5,1
    80005d74:	0cc77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005d78:	00e50733          	add	a4,a0,a4
    80005d7c:	00b70023          	sb	a1,0(a4)
    80005d80:	0027871b          	addiw	a4,a5,2
    80005d84:	0ac77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005d88:	00e50733          	add	a4,a0,a4
    80005d8c:	00b70023          	sb	a1,0(a4)
    80005d90:	0037871b          	addiw	a4,a5,3
    80005d94:	0ac77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005d98:	00e50733          	add	a4,a0,a4
    80005d9c:	00b70023          	sb	a1,0(a4)
    80005da0:	0047871b          	addiw	a4,a5,4
    80005da4:	08c77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005da8:	00e50733          	add	a4,a0,a4
    80005dac:	00b70023          	sb	a1,0(a4)
    80005db0:	0057871b          	addiw	a4,a5,5
    80005db4:	08c77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005db8:	00e50733          	add	a4,a0,a4
    80005dbc:	00b70023          	sb	a1,0(a4)
    80005dc0:	0067871b          	addiw	a4,a5,6
    80005dc4:	06c77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005dc8:	00e50733          	add	a4,a0,a4
    80005dcc:	00b70023          	sb	a1,0(a4)
    80005dd0:	0077871b          	addiw	a4,a5,7
    80005dd4:	06c77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005dd8:	00e50733          	add	a4,a0,a4
    80005ddc:	00b70023          	sb	a1,0(a4)
    80005de0:	0087871b          	addiw	a4,a5,8
    80005de4:	04c77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005de8:	00e50733          	add	a4,a0,a4
    80005dec:	00b70023          	sb	a1,0(a4)
    80005df0:	0097871b          	addiw	a4,a5,9
    80005df4:	04c77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005df8:	00e50733          	add	a4,a0,a4
    80005dfc:	00b70023          	sb	a1,0(a4)
    80005e00:	00a7871b          	addiw	a4,a5,10
    80005e04:	02c77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005e08:	00e50733          	add	a4,a0,a4
    80005e0c:	00b70023          	sb	a1,0(a4)
    80005e10:	00b7871b          	addiw	a4,a5,11
    80005e14:	02c77663          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005e18:	00e50733          	add	a4,a0,a4
    80005e1c:	00b70023          	sb	a1,0(a4)
    80005e20:	00c7871b          	addiw	a4,a5,12
    80005e24:	00c77e63          	bgeu	a4,a2,80005e40 <__memset+0x1c8>
    80005e28:	00e50733          	add	a4,a0,a4
    80005e2c:	00b70023          	sb	a1,0(a4)
    80005e30:	00d7879b          	addiw	a5,a5,13
    80005e34:	00c7f663          	bgeu	a5,a2,80005e40 <__memset+0x1c8>
    80005e38:	00f507b3          	add	a5,a0,a5
    80005e3c:	00b78023          	sb	a1,0(a5)
    80005e40:	00813403          	ld	s0,8(sp)
    80005e44:	01010113          	addi	sp,sp,16
    80005e48:	00008067          	ret
    80005e4c:	00b00693          	li	a3,11
    80005e50:	e55ff06f          	j	80005ca4 <__memset+0x2c>
    80005e54:	00300e93          	li	t4,3
    80005e58:	ea5ff06f          	j	80005cfc <__memset+0x84>
    80005e5c:	00100e93          	li	t4,1
    80005e60:	e9dff06f          	j	80005cfc <__memset+0x84>
    80005e64:	00000e93          	li	t4,0
    80005e68:	e95ff06f          	j	80005cfc <__memset+0x84>
    80005e6c:	00000793          	li	a5,0
    80005e70:	ef9ff06f          	j	80005d68 <__memset+0xf0>
    80005e74:	00200e93          	li	t4,2
    80005e78:	e85ff06f          	j	80005cfc <__memset+0x84>
    80005e7c:	00400e93          	li	t4,4
    80005e80:	e7dff06f          	j	80005cfc <__memset+0x84>
    80005e84:	00500e93          	li	t4,5
    80005e88:	e75ff06f          	j	80005cfc <__memset+0x84>
    80005e8c:	00600e93          	li	t4,6
    80005e90:	e6dff06f          	j	80005cfc <__memset+0x84>

0000000080005e94 <__memmove>:
    80005e94:	ff010113          	addi	sp,sp,-16
    80005e98:	00813423          	sd	s0,8(sp)
    80005e9c:	01010413          	addi	s0,sp,16
    80005ea0:	0e060863          	beqz	a2,80005f90 <__memmove+0xfc>
    80005ea4:	fff6069b          	addiw	a3,a2,-1
    80005ea8:	0006881b          	sext.w	a6,a3
    80005eac:	0ea5e863          	bltu	a1,a0,80005f9c <__memmove+0x108>
    80005eb0:	00758713          	addi	a4,a1,7
    80005eb4:	00a5e7b3          	or	a5,a1,a0
    80005eb8:	40a70733          	sub	a4,a4,a0
    80005ebc:	0077f793          	andi	a5,a5,7
    80005ec0:	00f73713          	sltiu	a4,a4,15
    80005ec4:	00174713          	xori	a4,a4,1
    80005ec8:	0017b793          	seqz	a5,a5
    80005ecc:	00e7f7b3          	and	a5,a5,a4
    80005ed0:	10078863          	beqz	a5,80005fe0 <__memmove+0x14c>
    80005ed4:	00900793          	li	a5,9
    80005ed8:	1107f463          	bgeu	a5,a6,80005fe0 <__memmove+0x14c>
    80005edc:	0036581b          	srliw	a6,a2,0x3
    80005ee0:	fff8081b          	addiw	a6,a6,-1
    80005ee4:	02081813          	slli	a6,a6,0x20
    80005ee8:	01d85893          	srli	a7,a6,0x1d
    80005eec:	00858813          	addi	a6,a1,8
    80005ef0:	00058793          	mv	a5,a1
    80005ef4:	00050713          	mv	a4,a0
    80005ef8:	01088833          	add	a6,a7,a6
    80005efc:	0007b883          	ld	a7,0(a5)
    80005f00:	00878793          	addi	a5,a5,8
    80005f04:	00870713          	addi	a4,a4,8
    80005f08:	ff173c23          	sd	a7,-8(a4)
    80005f0c:	ff0798e3          	bne	a5,a6,80005efc <__memmove+0x68>
    80005f10:	ff867713          	andi	a4,a2,-8
    80005f14:	02071793          	slli	a5,a4,0x20
    80005f18:	0207d793          	srli	a5,a5,0x20
    80005f1c:	00f585b3          	add	a1,a1,a5
    80005f20:	40e686bb          	subw	a3,a3,a4
    80005f24:	00f507b3          	add	a5,a0,a5
    80005f28:	06e60463          	beq	a2,a4,80005f90 <__memmove+0xfc>
    80005f2c:	0005c703          	lbu	a4,0(a1)
    80005f30:	00e78023          	sb	a4,0(a5)
    80005f34:	04068e63          	beqz	a3,80005f90 <__memmove+0xfc>
    80005f38:	0015c603          	lbu	a2,1(a1)
    80005f3c:	00100713          	li	a4,1
    80005f40:	00c780a3          	sb	a2,1(a5)
    80005f44:	04e68663          	beq	a3,a4,80005f90 <__memmove+0xfc>
    80005f48:	0025c603          	lbu	a2,2(a1)
    80005f4c:	00200713          	li	a4,2
    80005f50:	00c78123          	sb	a2,2(a5)
    80005f54:	02e68e63          	beq	a3,a4,80005f90 <__memmove+0xfc>
    80005f58:	0035c603          	lbu	a2,3(a1)
    80005f5c:	00300713          	li	a4,3
    80005f60:	00c781a3          	sb	a2,3(a5)
    80005f64:	02e68663          	beq	a3,a4,80005f90 <__memmove+0xfc>
    80005f68:	0045c603          	lbu	a2,4(a1)
    80005f6c:	00400713          	li	a4,4
    80005f70:	00c78223          	sb	a2,4(a5)
    80005f74:	00e68e63          	beq	a3,a4,80005f90 <__memmove+0xfc>
    80005f78:	0055c603          	lbu	a2,5(a1)
    80005f7c:	00500713          	li	a4,5
    80005f80:	00c782a3          	sb	a2,5(a5)
    80005f84:	00e68663          	beq	a3,a4,80005f90 <__memmove+0xfc>
    80005f88:	0065c703          	lbu	a4,6(a1)
    80005f8c:	00e78323          	sb	a4,6(a5)
    80005f90:	00813403          	ld	s0,8(sp)
    80005f94:	01010113          	addi	sp,sp,16
    80005f98:	00008067          	ret
    80005f9c:	02061713          	slli	a4,a2,0x20
    80005fa0:	02075713          	srli	a4,a4,0x20
    80005fa4:	00e587b3          	add	a5,a1,a4
    80005fa8:	f0f574e3          	bgeu	a0,a5,80005eb0 <__memmove+0x1c>
    80005fac:	02069613          	slli	a2,a3,0x20
    80005fb0:	02065613          	srli	a2,a2,0x20
    80005fb4:	fff64613          	not	a2,a2
    80005fb8:	00e50733          	add	a4,a0,a4
    80005fbc:	00c78633          	add	a2,a5,a2
    80005fc0:	fff7c683          	lbu	a3,-1(a5)
    80005fc4:	fff78793          	addi	a5,a5,-1
    80005fc8:	fff70713          	addi	a4,a4,-1
    80005fcc:	00d70023          	sb	a3,0(a4)
    80005fd0:	fec798e3          	bne	a5,a2,80005fc0 <__memmove+0x12c>
    80005fd4:	00813403          	ld	s0,8(sp)
    80005fd8:	01010113          	addi	sp,sp,16
    80005fdc:	00008067          	ret
    80005fe0:	02069713          	slli	a4,a3,0x20
    80005fe4:	02075713          	srli	a4,a4,0x20
    80005fe8:	00170713          	addi	a4,a4,1
    80005fec:	00e50733          	add	a4,a0,a4
    80005ff0:	00050793          	mv	a5,a0
    80005ff4:	0005c683          	lbu	a3,0(a1)
    80005ff8:	00178793          	addi	a5,a5,1
    80005ffc:	00158593          	addi	a1,a1,1
    80006000:	fed78fa3          	sb	a3,-1(a5)
    80006004:	fee798e3          	bne	a5,a4,80005ff4 <__memmove+0x160>
    80006008:	f89ff06f          	j	80005f90 <__memmove+0xfc>
	...
