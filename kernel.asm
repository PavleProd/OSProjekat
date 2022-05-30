
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	70013103          	ld	sp,1792(sp) # 80007700 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	579030ef          	jal	ra,80003d94 <start>

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
    8000100c:	511000ef          	jal	ra,80001d1c <_ZN3PCB10getContextEv>
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
    800010a0:	47d000ef          	jal	ra,80001d1c <_ZN3PCB10getContextEv>

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
    80001578:	04f70263          	beq	a4,a5,800015bc <interruptHandler+0x94>
    8000157c:	fd843703          	ld	a4,-40(s0)
    80001580:	00800793          	li	a5,8
    80001584:	02f70c63          	beq	a4,a5,800015bc <interruptHandler+0x94>
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
    80001598:	2cf70463          	beq	a4,a5,80001860 <interruptHandler+0x338>
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
    800015ac:	30f70a63          	beq	a4,a5,800018c0 <interruptHandler+0x398>
        else {
            plic_complete(CONSOLE_IRQ);
        }
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800015b0:	00002097          	auipc	ra,0x2
    800015b4:	12c080e7          	jalr	300(ra) # 800036dc <_Z10printErrorv>
    800015b8:	0840006f          	j	8000163c <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015bc:	fd043783          	ld	a5,-48(s0)
    800015c0:	00478793          	addi	a5,a5,4
    800015c4:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015c8:	00006797          	auipc	a5,0x6
    800015cc:	1507b783          	ld	a5,336(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015d0:	0007b503          	ld	a0,0(a5)
    800015d4:	01853703          	ld	a4,24(a0)
    800015d8:	05073783          	ld	a5,80(a4)
    800015dc:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015e0:	fa843783          	ld	a5,-88(s0)
    800015e4:	04300693          	li	a3,67
    800015e8:	26f6e663          	bltu	a3,a5,80001854 <interruptHandler+0x32c>
    800015ec:	00279793          	slli	a5,a5,0x2
    800015f0:	00005697          	auipc	a3,0x5
    800015f4:	a3068693          	addi	a3,a3,-1488 # 80006020 <CONSOLE_STATUS+0x10>
    800015f8:	00d787b3          	add	a5,a5,a3
    800015fc:	0007a783          	lw	a5,0(a5)
    80001600:	00d787b3          	add	a5,a5,a3
    80001604:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001608:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    8000160c:	00651513          	slli	a0,a0,0x6
    80001610:	00002097          	auipc	ra,0x2
    80001614:	b10080e7          	jalr	-1264(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
    80001618:	00006797          	auipc	a5,0x6
    8000161c:	1007b783          	ld	a5,256(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001620:	0007b783          	ld	a5,0(a5)
    80001624:	0187b783          	ld	a5,24(a5)
    80001628:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    8000162c:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001630:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001634:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001638:	10079073          	csrw	sstatus,a5
    }

}
    8000163c:	05813083          	ld	ra,88(sp)
    80001640:	05013403          	ld	s0,80(sp)
    80001644:	04813483          	ld	s1,72(sp)
    80001648:	04013903          	ld	s2,64(sp)
    8000164c:	06010113          	addi	sp,sp,96
    80001650:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001654:	05873503          	ld	a0,88(a4)
    80001658:	00002097          	auipc	ra,0x2
    8000165c:	c2c080e7          	jalr	-980(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
    80001660:	00006797          	auipc	a5,0x6
    80001664:	0b87b783          	ld	a5,184(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001668:	0007b783          	ld	a5,0(a5)
    8000166c:	0187b783          	ld	a5,24(a5)
    80001670:	04a7b823          	sd	a0,80(a5)
                break;
    80001674:	fb9ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    80001678:	00006797          	auipc	a5,0x6
    8000167c:	0807b783          	ld	a5,128(a5) # 800076f8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001680:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001684:	00000097          	auipc	ra,0x0
    80001688:	438080e7          	jalr	1080(ra) # 80001abc <_ZN3PCB8dispatchEv>
                break;
    8000168c:	fa1ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->finished = true;
    80001690:	00100793          	li	a5,1
    80001694:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001698:	00006797          	auipc	a5,0x6
    8000169c:	0607b783          	ld	a5,96(a5) # 800076f8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016a0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	418080e7          	jalr	1048(ra) # 80001abc <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016ac:	00006797          	auipc	a5,0x6
    800016b0:	06c7b783          	ld	a5,108(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016b4:	0007b783          	ld	a5,0(a5)
    800016b8:	0187b783          	ld	a5,24(a5)
    800016bc:	0407b823          	sd	zero,80(a5)
                break;
    800016c0:	f6dff06f          	j	8000162c <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800016c4:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800016c8:	0007b503          	ld	a0,0(a5)
    800016cc:	00001097          	auipc	ra,0x1
    800016d0:	ef0080e7          	jalr	-272(ra) # 800025bc <_ZN9Scheduler3putEP3PCB>
                break;
    800016d4:	f59ff06f          	j	8000162c <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d8:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016dc:	06873583          	ld	a1,104(a4)
    800016e0:	06073503          	ld	a0,96(a4)
    800016e4:	00000097          	auipc	ra,0x0
    800016e8:	5b0080e7          	jalr	1456(ra) # 80001c94 <_ZN3PCB14createProccessEPFvvEPv>
    800016ec:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016f0:	00006797          	auipc	a5,0x6
    800016f4:	0287b783          	ld	a5,40(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016f8:	0007b783          	ld	a5,0(a5)
    800016fc:	0187b703          	ld	a4,24(a5)
    80001700:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001704:	0004b703          	ld	a4,0(s1)
    80001708:	f20702e3          	beqz	a4,8000162c <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    8000170c:	0187b783          	ld	a5,24(a5)
    80001710:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001714:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001718:	00008737          	lui	a4,0x8
    8000171c:	00e787b3          	add	a5,a5,a4
    80001720:	0004b703          	ld	a4,0(s1)
    80001724:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001728:	00f73823          	sd	a5,16(a4)
                break;
    8000172c:	f01ff06f          	j	8000162c <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001730:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001734:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    80001738:	01800513          	li	a0,24
    8000173c:	00002097          	auipc	ra,0x2
    80001740:	930080e7          	jalr	-1744(ra) # 8000306c <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    80001744:	00053023          	sd	zero,0(a0)
    80001748:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000174c:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001750:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001754:	00006797          	auipc	a5,0x6
    80001758:	fc47b783          	ld	a5,-60(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000175c:	0007b783          	ld	a5,0(a5)
    80001760:	0187b783          	ld	a5,24(a5)
    80001764:	0497b823          	sd	s1,80(a5)
                break;
    80001768:	ec5ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    8000176c:	05873503          	ld	a0,88(a4)
    80001770:	00001097          	auipc	ra,0x1
    80001774:	7d8080e7          	jalr	2008(ra) # 80002f48 <_ZN3SCB4waitEv>
    80001778:	00006797          	auipc	a5,0x6
    8000177c:	fa07b783          	ld	a5,-96(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001780:	0007b783          	ld	a5,0(a5)
    80001784:	0187b783          	ld	a5,24(a5)
    80001788:	04a7b823          	sd	a0,80(a5)
                break;
    8000178c:	ea1ff06f          	j	8000162c <interruptHandler+0x104>
                sem->signal();
    80001790:	05873503          	ld	a0,88(a4)
    80001794:	00002097          	auipc	ra,0x2
    80001798:	848080e7          	jalr	-1976(ra) # 80002fdc <_ZN3SCB6signalEv>
                break;
    8000179c:	e91ff06f          	j	8000162c <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017a0:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017a4:	00048513          	mv	a0,s1
    800017a8:	00002097          	auipc	ra,0x2
    800017ac:	914080e7          	jalr	-1772(ra) # 800030bc <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017b0:	e6048ee3          	beqz	s1,8000162c <interruptHandler+0x104>
    800017b4:	00048513          	mv	a0,s1
    800017b8:	00002097          	auipc	ra,0x2
    800017bc:	8dc080e7          	jalr	-1828(ra) # 80003094 <_ZN3SCBdlEPv>
    800017c0:	e6dff06f          	j	8000162c <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    800017c4:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017c8:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	168080e7          	jalr	360(ra) # 80001934 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017d4:	e59ff06f          	j	8000162c <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    800017d8:	05874583          	lbu	a1,88(a4)
    800017dc:	00006517          	auipc	a0,0x6
    800017e0:	f0453503          	ld	a0,-252(a0) # 800076e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017e4:	00000097          	auipc	ra,0x0
    800017e8:	55c080e7          	jalr	1372(ra) # 80001d40 <_ZN8IOBuffer8pushBackEc>
                break;
    800017ec:	e41ff06f          	j	8000162c <interruptHandler+0x104>
                while(CCB::inputBuffer.peekFront() == 0) {
    800017f0:	00006517          	auipc	a0,0x6
    800017f4:	ef853503          	ld	a0,-264(a0) # 800076e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	6cc080e7          	jalr	1740(ra) # 80001ec4 <_ZN8IOBuffer9peekFrontEv>
    80001800:	00051e63          	bnez	a0,8000181c <interruptHandler+0x2f4>
                    CCB::inputBufferEmpty->wait();
    80001804:	00006797          	auipc	a5,0x6
    80001808:	f2c7b783          	ld	a5,-212(a5) # 80007730 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00001097          	auipc	ra,0x1
    80001814:	738080e7          	jalr	1848(ra) # 80002f48 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001818:	fd9ff06f          	j	800017f0 <interruptHandler+0x2c8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000181c:	00006517          	auipc	a0,0x6
    80001820:	ecc53503          	ld	a0,-308(a0) # 800076e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001824:	00000097          	auipc	ra,0x0
    80001828:	610080e7          	jalr	1552(ra) # 80001e34 <_ZN8IOBuffer8popFrontEv>
    8000182c:	00006797          	auipc	a5,0x6
    80001830:	eec7b783          	ld	a5,-276(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001834:	0007b783          	ld	a5,0(a5)
    80001838:	0187b783          	ld	a5,24(a5)
    8000183c:	04a7b823          	sd	a0,80(a5)
                break;
    80001840:	dedff06f          	j	8000162c <interruptHandler+0x104>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    80001844:	fc843783          	ld	a5,-56(s0)
    80001848:	eff7f793          	andi	a5,a5,-257
    8000184c:	fcf43423          	sd	a5,-56(s0)
                break;
    80001850:	dddff06f          	j	8000162c <interruptHandler+0x104>
                printError();
    80001854:	00002097          	auipc	ra,0x2
    80001858:	e88080e7          	jalr	-376(ra) # 800036dc <_Z10printErrorv>
                break;
    8000185c:	dd1ff06f          	j	8000162c <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    80001860:	00006497          	auipc	s1,0x6
    80001864:	e984b483          	ld	s1,-360(s1) # 800076f8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001868:	0004b783          	ld	a5,0(s1)
    8000186c:	00178793          	addi	a5,a5,1
    80001870:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001874:	00000097          	auipc	ra,0x0
    80001878:	150080e7          	jalr	336(ra) # 800019c4 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    8000187c:	00006797          	auipc	a5,0x6
    80001880:	e9c7b783          	ld	a5,-356(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001884:	0007b783          	ld	a5,0(a5)
    80001888:	0407b703          	ld	a4,64(a5)
    8000188c:	0004b783          	ld	a5,0(s1)
    80001890:	00e7f863          	bgeu	a5,a4,800018a0 <interruptHandler+0x378>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001894:	00200793          	li	a5,2
    80001898:	1447b073          	csrc	sip,a5
    }
    8000189c:	da1ff06f          	j	8000163c <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    800018a0:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	218080e7          	jalr	536(ra) # 80001abc <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018ac:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018b0:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018b4:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018b8:	10079073          	csrw	sstatus,a5
    }
    800018bc:	fd9ff06f          	j	80001894 <interruptHandler+0x36c>
        if(plic_claim() == CONSOLE_IRQ) {
    800018c0:	00003097          	auipc	ra,0x3
    800018c4:	d34080e7          	jalr	-716(ra) # 800045f4 <plic_claim>
    800018c8:	00a00793          	li	a5,10
    800018cc:	04f51c63          	bne	a0,a5,80001924 <interruptHandler+0x3fc>
            if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) { // putc
    800018d0:	00006797          	auipc	a5,0x6
    800018d4:	e007b783          	ld	a5,-512(a5) # 800076d0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800018d8:	0007b483          	ld	s1,0(a5)
    800018dc:	0004c783          	lbu	a5,0(s1)
    800018e0:	0207f793          	andi	a5,a5,32
    800018e4:	02079463          	bnez	a5,8000190c <interruptHandler+0x3e4>
            if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) { // getc
    800018e8:	0004c783          	lbu	a5,0(s1)
    800018ec:	0017f793          	andi	a5,a5,1
    800018f0:	d40786e3          	beqz	a5,8000163c <interruptHandler+0x114>
                CCB::semInput->prioritySignal();
    800018f4:	00006797          	auipc	a5,0x6
    800018f8:	e4c7b783          	ld	a5,-436(a5) # 80007740 <_GLOBAL_OFFSET_TABLE_+0x88>
    800018fc:	0007b503          	ld	a0,0(a5)
    80001900:	00001097          	auipc	ra,0x1
    80001904:	724080e7          	jalr	1828(ra) # 80003024 <_ZN3SCB14prioritySignalEv>
    80001908:	d35ff06f          	j	8000163c <interruptHandler+0x114>
                CCB::semOutput->prioritySignal();
    8000190c:	00006797          	auipc	a5,0x6
    80001910:	e1c7b783          	ld	a5,-484(a5) # 80007728 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001914:	0007b503          	ld	a0,0(a5)
    80001918:	00001097          	auipc	ra,0x1
    8000191c:	70c080e7          	jalr	1804(ra) # 80003024 <_ZN3SCB14prioritySignalEv>
    80001920:	fc9ff06f          	j	800018e8 <interruptHandler+0x3c0>
            plic_complete(CONSOLE_IRQ);
    80001924:	00a00513          	li	a0,10
    80001928:	00003097          	auipc	ra,0x3
    8000192c:	d04080e7          	jalr	-764(ra) # 8000462c <plic_complete>
    80001930:	d0dff06f          	j	8000163c <interruptHandler+0x114>

0000000080001934 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00813423          	sd	s0,8(sp)
    8000193c:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001940:	00006797          	auipc	a5,0x6
    80001944:	e607b783          	ld	a5,-416(a5) # 800077a0 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001948:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    8000194c:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001950:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001954:	00078e63          	beqz	a5,80001970 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    80001958:	0307b683          	ld	a3,48(a5)
    8000195c:	00e6fa63          	bgeu	a3,a4,80001970 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001960:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001964:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001968:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000196c:	fe9ff06f          	j	80001954 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001970:	00100693          	li	a3,1
    80001974:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    80001978:	02060663          	beqz	a2,800019a4 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    8000197c:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001980:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001984:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    80001988:	00078863          	beqz	a5,80001998 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    8000198c:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001990:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001994:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    80001998:	00813403          	ld	s0,8(sp)
    8000199c:	01010113          	addi	sp,sp,16
    800019a0:	00008067          	ret
        head = process;
    800019a4:	00006717          	auipc	a4,0x6
    800019a8:	dea73e23          	sd	a0,-516(a4) # 800077a0 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    800019ac:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800019b0:	fe0784e3          	beqz	a5,80001998 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019b4:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019b8:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    800019bc:	02b7b823          	sd	a1,48(a5)
    }
    800019c0:	fd9ff06f          	j	80001998 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

00000000800019c4 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    800019c4:	00006517          	auipc	a0,0x6
    800019c8:	ddc53503          	ld	a0,-548(a0) # 800077a0 <_ZN17SleepingProcesses4headE>
    800019cc:	08050063          	beqz	a0,80001a4c <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800019d0:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800019d4:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800019d8:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800019dc:	06050263          	beqz	a0,80001a40 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800019e0:	03053783          	ld	a5,48(a0)
    800019e4:	04079e63          	bnez	a5,80001a40 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800019e8:	fe010113          	addi	sp,sp,-32
    800019ec:	00113c23          	sd	ra,24(sp)
    800019f0:	00813823          	sd	s0,16(sp)
    800019f4:	00913423          	sd	s1,8(sp)
    800019f8:	02010413          	addi	s0,sp,32
    800019fc:	00c0006f          	j	80001a08 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    80001a00:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    80001a04:	02079063          	bnez	a5,80001a24 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    80001a08:	00053483          	ld	s1,0(a0)
        nextInList = next;
    80001a0c:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001a10:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001a14:	00001097          	auipc	ra,0x1
    80001a18:	ba8080e7          	jalr	-1112(ra) # 800025bc <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001a1c:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001a20:	fe0490e3          	bnez	s1,80001a00 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001a24:	00006797          	auipc	a5,0x6
    80001a28:	d6a7be23          	sd	a0,-644(a5) # 800077a0 <_ZN17SleepingProcesses4headE>
}
    80001a2c:	01813083          	ld	ra,24(sp)
    80001a30:	01013403          	ld	s0,16(sp)
    80001a34:	00813483          	ld	s1,8(sp)
    80001a38:	02010113          	addi	sp,sp,32
    80001a3c:	00008067          	ret
    head = curr;
    80001a40:	00006797          	auipc	a5,0x6
    80001a44:	d6a7b023          	sd	a0,-672(a5) # 800077a0 <_ZN17SleepingProcesses4headE>
    80001a48:	00008067          	ret
    80001a4c:	00008067          	ret

0000000080001a50 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a50:	ff010113          	addi	sp,sp,-16
    80001a54:	00113423          	sd	ra,8(sp)
    80001a58:	00813023          	sd	s0,0(sp)
    80001a5c:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a60:	00000097          	auipc	ra,0x0
    80001a64:	aa8080e7          	jalr	-1368(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a68:	00006797          	auipc	a5,0x6
    80001a6c:	d407b783          	ld	a5,-704(a5) # 800077a8 <_ZN3PCB7runningE>
    80001a70:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a74:	00070513          	mv	a0,a4
    running->main();
    80001a78:	0207b783          	ld	a5,32(a5)
    80001a7c:	000780e7          	jalr	a5
    thread_exit();
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	820080e7          	jalr	-2016(ra) # 800012a0 <_Z11thread_exitv>
}
    80001a88:	00813083          	ld	ra,8(sp)
    80001a8c:	00013403          	ld	s0,0(sp)
    80001a90:	01010113          	addi	sp,sp,16
    80001a94:	00008067          	ret

0000000080001a98 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001a98:	ff010113          	addi	sp,sp,-16
    80001a9c:	00813423          	sd	s0,8(sp)
    80001aa0:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001aa4:	01300793          	li	a5,19
    80001aa8:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001aac:	00000073          	ecall
}
    80001ab0:	00813403          	ld	s0,8(sp)
    80001ab4:	01010113          	addi	sp,sp,16
    80001ab8:	00008067          	ret

0000000080001abc <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001abc:	fe010113          	addi	sp,sp,-32
    80001ac0:	00113c23          	sd	ra,24(sp)
    80001ac4:	00813823          	sd	s0,16(sp)
    80001ac8:	00913423          	sd	s1,8(sp)
    80001acc:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001ad0:	00006497          	auipc	s1,0x6
    80001ad4:	cd84b483          	ld	s1,-808(s1) # 800077a8 <_ZN3PCB7runningE>
        return finished;
    80001ad8:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001adc:	00079663          	bnez	a5,80001ae8 <_ZN3PCB8dispatchEv+0x2c>
    80001ae0:	0294c783          	lbu	a5,41(s1)
    80001ae4:	04078263          	beqz	a5,80001b28 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001ae8:	00001097          	auipc	ra,0x1
    80001aec:	b2c080e7          	jalr	-1236(ra) # 80002614 <_ZN9Scheduler3getEv>
    80001af0:	00006797          	auipc	a5,0x6
    80001af4:	caa7bc23          	sd	a0,-840(a5) # 800077a8 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001af8:	04854783          	lbu	a5,72(a0)
    80001afc:	02078e63          	beqz	a5,80001b38 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b00:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001b04:	01853583          	ld	a1,24(a0)
    80001b08:	0184b503          	ld	a0,24(s1)
    80001b0c:	fffff097          	auipc	ra,0xfffff
    80001b10:	61c080e7          	jalr	1564(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001b14:	01813083          	ld	ra,24(sp)
    80001b18:	01013403          	ld	s0,16(sp)
    80001b1c:	00813483          	ld	s1,8(sp)
    80001b20:	02010113          	addi	sp,sp,32
    80001b24:	00008067          	ret
        Scheduler::put(old);
    80001b28:	00048513          	mv	a0,s1
    80001b2c:	00001097          	auipc	ra,0x1
    80001b30:	a90080e7          	jalr	-1392(ra) # 800025bc <_ZN9Scheduler3putEP3PCB>
    80001b34:	fb5ff06f          	j	80001ae8 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b38:	01853583          	ld	a1,24(a0)
    80001b3c:	0184b503          	ld	a0,24(s1)
    80001b40:	fffff097          	auipc	ra,0xfffff
    80001b44:	5fc080e7          	jalr	1532(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b48:	fcdff06f          	j	80001b14 <_ZN3PCB8dispatchEv+0x58>

0000000080001b4c <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001b4c:	fe010113          	addi	sp,sp,-32
    80001b50:	00113c23          	sd	ra,24(sp)
    80001b54:	00813823          	sd	s0,16(sp)
    80001b58:	00913423          	sd	s1,8(sp)
    80001b5c:	02010413          	addi	s0,sp,32
    80001b60:	00050493          	mv	s1,a0
    80001b64:	00053023          	sd	zero,0(a0)
    80001b68:	00053c23          	sd	zero,24(a0)
    80001b6c:	02053823          	sd	zero,48(a0)
    80001b70:	00100793          	li	a5,1
    80001b74:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001b78:	02050523          	sb	zero,42(a0)
    80001b7c:	020504a3          	sb	zero,41(a0)
    80001b80:	02050423          	sb	zero,40(a0)
    main = main_;
    80001b84:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001b88:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001b8c:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001b90:	10800513          	li	a0,264
    80001b94:	00001097          	auipc	ra,0x1
    80001b98:	58c080e7          	jalr	1420(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
    80001b9c:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001ba0:	00008537          	lui	a0,0x8
    80001ba4:	00001097          	auipc	ra,0x1
    80001ba8:	57c080e7          	jalr	1404(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
    80001bac:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001bb0:	000087b7          	lui	a5,0x8
    80001bb4:	00f50533          	add	a0,a0,a5
    80001bb8:	0184b783          	ld	a5,24(s1)
    80001bbc:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001bc0:	0184b783          	ld	a5,24(s1)
    80001bc4:	00000717          	auipc	a4,0x0
    80001bc8:	e8c70713          	addi	a4,a4,-372 # 80001a50 <_ZN3PCB15proccessWrapperEv>
    80001bcc:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001bd0:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001bd4:	0204b783          	ld	a5,32(s1)
    80001bd8:	00078c63          	beqz	a5,80001bf0 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001bdc:	01813083          	ld	ra,24(sp)
    80001be0:	01013403          	ld	s0,16(sp)
    80001be4:	00813483          	ld	s1,8(sp)
    80001be8:	02010113          	addi	sp,sp,32
    80001bec:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001bf0:	04048423          	sb	zero,72(s1)
}
    80001bf4:	fe9ff06f          	j	80001bdc <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001bf8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001bf8:	fe010113          	addi	sp,sp,-32
    80001bfc:	00113c23          	sd	ra,24(sp)
    80001c00:	00813823          	sd	s0,16(sp)
    80001c04:	00913423          	sd	s1,8(sp)
    80001c08:	02010413          	addi	s0,sp,32
    80001c0c:	00050493          	mv	s1,a0
    delete[] stack;
    80001c10:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001c14:	00050663          	beqz	a0,80001c20 <_ZN3PCBD1Ev+0x28>
    80001c18:	00001097          	auipc	ra,0x1
    80001c1c:	d80080e7          	jalr	-640(ra) # 80002998 <_ZdaPv>
    delete[] sysStack;
    80001c20:	0104b503          	ld	a0,16(s1)
    80001c24:	00050663          	beqz	a0,80001c30 <_ZN3PCBD1Ev+0x38>
    80001c28:	00001097          	auipc	ra,0x1
    80001c2c:	d70080e7          	jalr	-656(ra) # 80002998 <_ZdaPv>
}
    80001c30:	01813083          	ld	ra,24(sp)
    80001c34:	01013403          	ld	s0,16(sp)
    80001c38:	00813483          	ld	s1,8(sp)
    80001c3c:	02010113          	addi	sp,sp,32
    80001c40:	00008067          	ret

0000000080001c44 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001c44:	ff010113          	addi	sp,sp,-16
    80001c48:	00113423          	sd	ra,8(sp)
    80001c4c:	00813023          	sd	s0,0(sp)
    80001c50:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c54:	00001097          	auipc	ra,0x1
    80001c58:	4cc080e7          	jalr	1228(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001c5c:	00813083          	ld	ra,8(sp)
    80001c60:	00013403          	ld	s0,0(sp)
    80001c64:	01010113          	addi	sp,sp,16
    80001c68:	00008067          	ret

0000000080001c6c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c6c:	ff010113          	addi	sp,sp,-16
    80001c70:	00113423          	sd	ra,8(sp)
    80001c74:	00813023          	sd	s0,0(sp)
    80001c78:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c7c:	00001097          	auipc	ra,0x1
    80001c80:	608080e7          	jalr	1544(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c84:	00813083          	ld	ra,8(sp)
    80001c88:	00013403          	ld	s0,0(sp)
    80001c8c:	01010113          	addi	sp,sp,16
    80001c90:	00008067          	ret

0000000080001c94 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001c94:	fd010113          	addi	sp,sp,-48
    80001c98:	02113423          	sd	ra,40(sp)
    80001c9c:	02813023          	sd	s0,32(sp)
    80001ca0:	00913c23          	sd	s1,24(sp)
    80001ca4:	01213823          	sd	s2,16(sp)
    80001ca8:	01313423          	sd	s3,8(sp)
    80001cac:	03010413          	addi	s0,sp,48
    80001cb0:	00050913          	mv	s2,a0
    80001cb4:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001cb8:	05000513          	li	a0,80
    80001cbc:	00000097          	auipc	ra,0x0
    80001cc0:	f88080e7          	jalr	-120(ra) # 80001c44 <_ZN3PCBnwEm>
    80001cc4:	00050493          	mv	s1,a0
    80001cc8:	00098693          	mv	a3,s3
    80001ccc:	00200613          	li	a2,2
    80001cd0:	00090593          	mv	a1,s2
    80001cd4:	00000097          	auipc	ra,0x0
    80001cd8:	e78080e7          	jalr	-392(ra) # 80001b4c <_ZN3PCBC1EPFvvEmPv>
    80001cdc:	0200006f          	j	80001cfc <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001ce0:	00050913          	mv	s2,a0
    80001ce4:	00048513          	mv	a0,s1
    80001ce8:	00000097          	auipc	ra,0x0
    80001cec:	f84080e7          	jalr	-124(ra) # 80001c6c <_ZN3PCBdlEPv>
    80001cf0:	00090513          	mv	a0,s2
    80001cf4:	00007097          	auipc	ra,0x7
    80001cf8:	c14080e7          	jalr	-1004(ra) # 80008908 <_Unwind_Resume>
}
    80001cfc:	00048513          	mv	a0,s1
    80001d00:	02813083          	ld	ra,40(sp)
    80001d04:	02013403          	ld	s0,32(sp)
    80001d08:	01813483          	ld	s1,24(sp)
    80001d0c:	01013903          	ld	s2,16(sp)
    80001d10:	00813983          	ld	s3,8(sp)
    80001d14:	03010113          	addi	sp,sp,48
    80001d18:	00008067          	ret

0000000080001d1c <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001d1c:	ff010113          	addi	sp,sp,-16
    80001d20:	00813423          	sd	s0,8(sp)
    80001d24:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001d28:	00006797          	auipc	a5,0x6
    80001d2c:	a807b783          	ld	a5,-1408(a5) # 800077a8 <_ZN3PCB7runningE>
    80001d30:	0187b503          	ld	a0,24(a5)
    80001d34:	00813403          	ld	s0,8(sp)
    80001d38:	01010113          	addi	sp,sp,16
    80001d3c:	00008067          	ret

0000000080001d40 <_ZN8IOBuffer8pushBackEc>:
        sem_wait(semOutput);
    }
}


void IOBuffer::pushBack(char c) {
    80001d40:	fe010113          	addi	sp,sp,-32
    80001d44:	00113c23          	sd	ra,24(sp)
    80001d48:	00813823          	sd	s0,16(sp)
    80001d4c:	00913423          	sd	s1,8(sp)
    80001d50:	01213023          	sd	s2,0(sp)
    80001d54:	02010413          	addi	s0,sp,32
    80001d58:	00050493          	mv	s1,a0
    80001d5c:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001d60:	01000513          	li	a0,16
    80001d64:	00001097          	auipc	ra,0x1
    80001d68:	3bc080e7          	jalr	956(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001d6c:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001d70:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001d74:	0004b783          	ld	a5,0(s1)
    80001d78:	02078863          	beqz	a5,80001da8 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001d7c:	0084b783          	ld	a5,8(s1)
    80001d80:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001d84:	0084b783          	ld	a5,8(s1)
    80001d88:	0007b783          	ld	a5,0(a5)
    80001d8c:	00f4b423          	sd	a5,8(s1)
    }
}
    80001d90:	01813083          	ld	ra,24(sp)
    80001d94:	01013403          	ld	s0,16(sp)
    80001d98:	00813483          	ld	s1,8(sp)
    80001d9c:	00013903          	ld	s2,0(sp)
    80001da0:	02010113          	addi	sp,sp,32
    80001da4:	00008067          	ret
        head = tail = newElem;
    80001da8:	00a4b423          	sd	a0,8(s1)
    80001dac:	00a4b023          	sd	a0,0(s1)
    80001db0:	fe1ff06f          	j	80001d90 <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001db4 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001db4:	fe010113          	addi	sp,sp,-32
    80001db8:	00113c23          	sd	ra,24(sp)
    80001dbc:	00813823          	sd	s0,16(sp)
    80001dc0:	00913423          	sd	s1,8(sp)
    80001dc4:	02010413          	addi	s0,sp,32
    80001dc8:	0340006f          	j	80001dfc <_ZN3CCB9inputBodyEPv+0x48>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001dcc:	00006797          	auipc	a5,0x6
    80001dd0:	8f47b783          	ld	a5,-1804(a5) # 800076c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001dd4:	0007b783          	ld	a5,0(a5)
    80001dd8:	00006497          	auipc	s1,0x6
    80001ddc:	9e048493          	addi	s1,s1,-1568 # 800077b8 <_ZN3CCB11inputBufferE>
    80001de0:	0007c583          	lbu	a1,0(a5)
    80001de4:	00048513          	mv	a0,s1
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	f58080e7          	jalr	-168(ra) # 80001d40 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001df0:	0104b503          	ld	a0,16(s1)
    80001df4:	fffff097          	auipc	ra,0xfffff
    80001df8:	5ec080e7          	jalr	1516(ra) # 800013e0 <_Z10sem_signalP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001dfc:	00006797          	auipc	a5,0x6
    80001e00:	8d47b783          	ld	a5,-1836(a5) # 800076d0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001e04:	0007b783          	ld	a5,0(a5)
    80001e08:	0007c783          	lbu	a5,0(a5)
    80001e0c:	0017f793          	andi	a5,a5,1
    80001e10:	fa079ee3          	bnez	a5,80001dcc <_ZN3CCB9inputBodyEPv+0x18>
        plic_complete(CONSOLE_IRQ);
    80001e14:	00a00513          	li	a0,10
    80001e18:	00003097          	auipc	ra,0x3
    80001e1c:	814080e7          	jalr	-2028(ra) # 8000462c <plic_complete>
        sem_wait(semInput);
    80001e20:	00006517          	auipc	a0,0x6
    80001e24:	9b053503          	ld	a0,-1616(a0) # 800077d0 <_ZN3CCB8semInputE>
    80001e28:	fffff097          	auipc	ra,0xfffff
    80001e2c:	570080e7          	jalr	1392(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001e30:	fcdff06f          	j	80001dfc <_ZN3CCB9inputBodyEPv+0x48>

0000000080001e34 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001e34:	fe010113          	addi	sp,sp,-32
    80001e38:	00113c23          	sd	ra,24(sp)
    80001e3c:	00813823          	sd	s0,16(sp)
    80001e40:	00913423          	sd	s1,8(sp)
    80001e44:	02010413          	addi	s0,sp,32
    80001e48:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001e4c:	00053503          	ld	a0,0(a0)
    80001e50:	04050063          	beqz	a0,80001e90 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001e54:	00053703          	ld	a4,0(a0)
    80001e58:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001e5c:	0087b703          	ld	a4,8(a5)
    80001e60:	02e50463          	beq	a0,a4,80001e88 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001e64:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001e68:	00001097          	auipc	ra,0x1
    80001e6c:	41c080e7          	jalr	1052(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001e70:	00048513          	mv	a0,s1
    80001e74:	01813083          	ld	ra,24(sp)
    80001e78:	01013403          	ld	s0,16(sp)
    80001e7c:	00813483          	ld	s1,8(sp)
    80001e80:	02010113          	addi	sp,sp,32
    80001e84:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001e88:	0007b423          	sd	zero,8(a5)
    80001e8c:	fd9ff06f          	j	80001e64 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001e90:	00000493          	li	s1,0
    80001e94:	fddff06f          	j	80001e70 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001e98 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00813423          	sd	s0,8(sp)
    80001ea0:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001ea4:	00853783          	ld	a5,8(a0)
    80001ea8:	00078a63          	beqz	a5,80001ebc <_ZN8IOBuffer8peekBackEv+0x24>
    80001eac:	0087c503          	lbu	a0,8(a5)
}
    80001eb0:	00813403          	ld	s0,8(sp)
    80001eb4:	01010113          	addi	sp,sp,16
    80001eb8:	00008067          	ret
    return tail ? tail->data : 0;
    80001ebc:	00000513          	li	a0,0
    80001ec0:	ff1ff06f          	j	80001eb0 <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001ec4 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001ec4:	ff010113          	addi	sp,sp,-16
    80001ec8:	00813423          	sd	s0,8(sp)
    80001ecc:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001ed0:	00053783          	ld	a5,0(a0)
    80001ed4:	00078a63          	beqz	a5,80001ee8 <_ZN8IOBuffer9peekFrontEv+0x24>
    80001ed8:	0087c503          	lbu	a0,8(a5)
}
    80001edc:	00813403          	ld	s0,8(sp)
    80001ee0:	01010113          	addi	sp,sp,16
    80001ee4:	00008067          	ret
    return head ? head->data : 0;
    80001ee8:	00000513          	li	a0,0
    80001eec:	ff1ff06f          	j	80001edc <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001ef0 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001ef0:	fe010113          	addi	sp,sp,-32
    80001ef4:	00113c23          	sd	ra,24(sp)
    80001ef8:	00813823          	sd	s0,16(sp)
    80001efc:	00913423          	sd	s1,8(sp)
    80001f00:	02010413          	addi	s0,sp,32
    80001f04:	0200006f          	j	80001f24 <_ZN3CCB10outputBodyEPv+0x34>
        plic_complete(CONSOLE_IRQ);
    80001f08:	00a00513          	li	a0,10
    80001f0c:	00002097          	auipc	ra,0x2
    80001f10:	720080e7          	jalr	1824(ra) # 8000462c <plic_complete>
        sem_wait(semOutput);
    80001f14:	00006517          	auipc	a0,0x6
    80001f18:	8d453503          	ld	a0,-1836(a0) # 800077e8 <_ZN3CCB9semOutputE>
    80001f1c:	fffff097          	auipc	ra,0xfffff
    80001f20:	47c080e7          	jalr	1148(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f24:	00005797          	auipc	a5,0x5
    80001f28:	7ac7b783          	ld	a5,1964(a5) # 800076d0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001f2c:	0007b783          	ld	a5,0(a5)
    80001f30:	0007c783          	lbu	a5,0(a5)
    80001f34:	0207f793          	andi	a5,a5,32
    80001f38:	fc0788e3          	beqz	a5,80001f08 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() == 0) break;
    80001f3c:	00006517          	auipc	a0,0x6
    80001f40:	89c50513          	addi	a0,a0,-1892 # 800077d8 <_ZN3CCB12outputBufferE>
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	f80080e7          	jalr	-128(ra) # 80001ec4 <_ZN8IOBuffer9peekFrontEv>
    80001f4c:	fa050ee3          	beqz	a0,80001f08 <_ZN3CCB10outputBodyEPv+0x18>
            *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001f50:	00005797          	auipc	a5,0x5
    80001f54:	7a07b783          	ld	a5,1952(a5) # 800076f0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001f58:	0007b483          	ld	s1,0(a5)
    80001f5c:	00006517          	auipc	a0,0x6
    80001f60:	87c50513          	addi	a0,a0,-1924 # 800077d8 <_ZN3CCB12outputBufferE>
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	ed0080e7          	jalr	-304(ra) # 80001e34 <_ZN8IOBuffer8popFrontEv>
    80001f6c:	00a48023          	sb	a0,0(s1)
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f70:	fb5ff06f          	j	80001f24 <_ZN3CCB10outputBodyEPv+0x34>

0000000080001f74 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80001f74:	fe010113          	addi	sp,sp,-32
    80001f78:	00113c23          	sd	ra,24(sp)
    80001f7c:	00813823          	sd	s0,16(sp)
    80001f80:	00913423          	sd	s1,8(sp)
    80001f84:	01213023          	sd	s2,0(sp)
    80001f88:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001f8c:	00000913          	li	s2,0
    80001f90:	0380006f          	j	80001fc8 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001f94:	fffff097          	auipc	ra,0xfffff
    80001f98:	2e0080e7          	jalr	736(ra) # 80001274 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001f9c:	00148493          	addi	s1,s1,1
    80001fa0:	000027b7          	lui	a5,0x2
    80001fa4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001fa8:	0097ee63          	bltu	a5,s1,80001fc4 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001fac:	00000713          	li	a4,0
    80001fb0:	000077b7          	lui	a5,0x7
    80001fb4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001fb8:	fce7eee3          	bltu	a5,a4,80001f94 <_Z11workerBodyAPv+0x20>
    80001fbc:	00170713          	addi	a4,a4,1
    80001fc0:	ff1ff06f          	j	80001fb0 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001fc4:	00190913          	addi	s2,s2,1
    80001fc8:	00900793          	li	a5,9
    80001fcc:	0527e063          	bltu	a5,s2,8000200c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001fd0:	00004517          	auipc	a0,0x4
    80001fd4:	16050513          	addi	a0,a0,352 # 80006130 <CONSOLE_STATUS+0x120>
    80001fd8:	00001097          	auipc	ra,0x1
    80001fdc:	458080e7          	jalr	1112(ra) # 80003430 <_Z11printStringPKc>
    80001fe0:	00000613          	li	a2,0
    80001fe4:	00a00593          	li	a1,10
    80001fe8:	0009051b          	sext.w	a0,s2
    80001fec:	00001097          	auipc	ra,0x1
    80001ff0:	5dc080e7          	jalr	1500(ra) # 800035c8 <_Z8printIntiii>
    80001ff4:	00004517          	auipc	a0,0x4
    80001ff8:	38450513          	addi	a0,a0,900 # 80006378 <CONSOLE_STATUS+0x368>
    80001ffc:	00001097          	auipc	ra,0x1
    80002000:	434080e7          	jalr	1076(ra) # 80003430 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002004:	00000493          	li	s1,0
    80002008:	f99ff06f          	j	80001fa0 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000200c:	00004517          	auipc	a0,0x4
    80002010:	12c50513          	addi	a0,a0,300 # 80006138 <CONSOLE_STATUS+0x128>
    80002014:	00001097          	auipc	ra,0x1
    80002018:	41c080e7          	jalr	1052(ra) # 80003430 <_Z11printStringPKc>
    finishedA = true;
    8000201c:	00100793          	li	a5,1
    80002020:	00005717          	auipc	a4,0x5
    80002024:	7ef70023          	sb	a5,2016(a4) # 80007800 <finishedA>
}
    80002028:	01813083          	ld	ra,24(sp)
    8000202c:	01013403          	ld	s0,16(sp)
    80002030:	00813483          	ld	s1,8(sp)
    80002034:	00013903          	ld	s2,0(sp)
    80002038:	02010113          	addi	sp,sp,32
    8000203c:	00008067          	ret

0000000080002040 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80002040:	fe010113          	addi	sp,sp,-32
    80002044:	00113c23          	sd	ra,24(sp)
    80002048:	00813823          	sd	s0,16(sp)
    8000204c:	00913423          	sd	s1,8(sp)
    80002050:	01213023          	sd	s2,0(sp)
    80002054:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002058:	00000913          	li	s2,0
    8000205c:	0380006f          	j	80002094 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002060:	fffff097          	auipc	ra,0xfffff
    80002064:	214080e7          	jalr	532(ra) # 80001274 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002068:	00148493          	addi	s1,s1,1
    8000206c:	000027b7          	lui	a5,0x2
    80002070:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002074:	0097ee63          	bltu	a5,s1,80002090 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002078:	00000713          	li	a4,0
    8000207c:	000077b7          	lui	a5,0x7
    80002080:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002084:	fce7eee3          	bltu	a5,a4,80002060 <_Z11workerBodyBPv+0x20>
    80002088:	00170713          	addi	a4,a4,1
    8000208c:	ff1ff06f          	j	8000207c <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002090:	00190913          	addi	s2,s2,1
    80002094:	00f00793          	li	a5,15
    80002098:	0527e063          	bltu	a5,s2,800020d8 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000209c:	00004517          	auipc	a0,0x4
    800020a0:	0ac50513          	addi	a0,a0,172 # 80006148 <CONSOLE_STATUS+0x138>
    800020a4:	00001097          	auipc	ra,0x1
    800020a8:	38c080e7          	jalr	908(ra) # 80003430 <_Z11printStringPKc>
    800020ac:	00000613          	li	a2,0
    800020b0:	00a00593          	li	a1,10
    800020b4:	0009051b          	sext.w	a0,s2
    800020b8:	00001097          	auipc	ra,0x1
    800020bc:	510080e7          	jalr	1296(ra) # 800035c8 <_Z8printIntiii>
    800020c0:	00004517          	auipc	a0,0x4
    800020c4:	2b850513          	addi	a0,a0,696 # 80006378 <CONSOLE_STATUS+0x368>
    800020c8:	00001097          	auipc	ra,0x1
    800020cc:	368080e7          	jalr	872(ra) # 80003430 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800020d0:	00000493          	li	s1,0
    800020d4:	f99ff06f          	j	8000206c <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    800020d8:	00004517          	auipc	a0,0x4
    800020dc:	07850513          	addi	a0,a0,120 # 80006150 <CONSOLE_STATUS+0x140>
    800020e0:	00001097          	auipc	ra,0x1
    800020e4:	350080e7          	jalr	848(ra) # 80003430 <_Z11printStringPKc>
    finishedB = true;
    800020e8:	00100793          	li	a5,1
    800020ec:	00005717          	auipc	a4,0x5
    800020f0:	70f70aa3          	sb	a5,1813(a4) # 80007801 <finishedB>
    thread_dispatch();
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	180080e7          	jalr	384(ra) # 80001274 <_Z15thread_dispatchv>
}
    800020fc:	01813083          	ld	ra,24(sp)
    80002100:	01013403          	ld	s0,16(sp)
    80002104:	00813483          	ld	s1,8(sp)
    80002108:	00013903          	ld	s2,0(sp)
    8000210c:	02010113          	addi	sp,sp,32
    80002110:	00008067          	ret

0000000080002114 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80002114:	fe010113          	addi	sp,sp,-32
    80002118:	00113c23          	sd	ra,24(sp)
    8000211c:	00813823          	sd	s0,16(sp)
    80002120:	00913423          	sd	s1,8(sp)
    80002124:	01213023          	sd	s2,0(sp)
    80002128:	02010413          	addi	s0,sp,32
    8000212c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002130:	00100793          	li	a5,1
    80002134:	02a7f863          	bgeu	a5,a0,80002164 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002138:	00a00793          	li	a5,10
    8000213c:	02f577b3          	remu	a5,a0,a5
    80002140:	02078e63          	beqz	a5,8000217c <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002144:	fff48513          	addi	a0,s1,-1
    80002148:	00000097          	auipc	ra,0x0
    8000214c:	fcc080e7          	jalr	-52(ra) # 80002114 <_Z9fibonaccim>
    80002150:	00050913          	mv	s2,a0
    80002154:	ffe48513          	addi	a0,s1,-2
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	fbc080e7          	jalr	-68(ra) # 80002114 <_Z9fibonaccim>
    80002160:	00a90533          	add	a0,s2,a0
}
    80002164:	01813083          	ld	ra,24(sp)
    80002168:	01013403          	ld	s0,16(sp)
    8000216c:	00813483          	ld	s1,8(sp)
    80002170:	00013903          	ld	s2,0(sp)
    80002174:	02010113          	addi	sp,sp,32
    80002178:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000217c:	fffff097          	auipc	ra,0xfffff
    80002180:	0f8080e7          	jalr	248(ra) # 80001274 <_Z15thread_dispatchv>
    80002184:	fc1ff06f          	j	80002144 <_Z9fibonaccim+0x30>

0000000080002188 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80002188:	fe010113          	addi	sp,sp,-32
    8000218c:	00113c23          	sd	ra,24(sp)
    80002190:	00813823          	sd	s0,16(sp)
    80002194:	00913423          	sd	s1,8(sp)
    80002198:	01213023          	sd	s2,0(sp)
    8000219c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800021a0:	00000493          	li	s1,0
    800021a4:	0400006f          	j	800021e4 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800021a8:	00004517          	auipc	a0,0x4
    800021ac:	fb850513          	addi	a0,a0,-72 # 80006160 <CONSOLE_STATUS+0x150>
    800021b0:	00001097          	auipc	ra,0x1
    800021b4:	280080e7          	jalr	640(ra) # 80003430 <_Z11printStringPKc>
    800021b8:	00000613          	li	a2,0
    800021bc:	00a00593          	li	a1,10
    800021c0:	00048513          	mv	a0,s1
    800021c4:	00001097          	auipc	ra,0x1
    800021c8:	404080e7          	jalr	1028(ra) # 800035c8 <_Z8printIntiii>
    800021cc:	00004517          	auipc	a0,0x4
    800021d0:	1ac50513          	addi	a0,a0,428 # 80006378 <CONSOLE_STATUS+0x368>
    800021d4:	00001097          	auipc	ra,0x1
    800021d8:	25c080e7          	jalr	604(ra) # 80003430 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800021dc:	0014849b          	addiw	s1,s1,1
    800021e0:	0ff4f493          	andi	s1,s1,255
    800021e4:	00200793          	li	a5,2
    800021e8:	fc97f0e3          	bgeu	a5,s1,800021a8 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    800021ec:	00004517          	auipc	a0,0x4
    800021f0:	f7c50513          	addi	a0,a0,-132 # 80006168 <CONSOLE_STATUS+0x158>
    800021f4:	00001097          	auipc	ra,0x1
    800021f8:	23c080e7          	jalr	572(ra) # 80003430 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800021fc:	00700313          	li	t1,7
    thread_dispatch();
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	074080e7          	jalr	116(ra) # 80001274 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002208:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000220c:	00004517          	auipc	a0,0x4
    80002210:	f6c50513          	addi	a0,a0,-148 # 80006178 <CONSOLE_STATUS+0x168>
    80002214:	00001097          	auipc	ra,0x1
    80002218:	21c080e7          	jalr	540(ra) # 80003430 <_Z11printStringPKc>
    8000221c:	00000613          	li	a2,0
    80002220:	00a00593          	li	a1,10
    80002224:	0009051b          	sext.w	a0,s2
    80002228:	00001097          	auipc	ra,0x1
    8000222c:	3a0080e7          	jalr	928(ra) # 800035c8 <_Z8printIntiii>
    80002230:	00004517          	auipc	a0,0x4
    80002234:	14850513          	addi	a0,a0,328 # 80006378 <CONSOLE_STATUS+0x368>
    80002238:	00001097          	auipc	ra,0x1
    8000223c:	1f8080e7          	jalr	504(ra) # 80003430 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002240:	00c00513          	li	a0,12
    80002244:	00000097          	auipc	ra,0x0
    80002248:	ed0080e7          	jalr	-304(ra) # 80002114 <_Z9fibonaccim>
    8000224c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002250:	00004517          	auipc	a0,0x4
    80002254:	f3050513          	addi	a0,a0,-208 # 80006180 <CONSOLE_STATUS+0x170>
    80002258:	00001097          	auipc	ra,0x1
    8000225c:	1d8080e7          	jalr	472(ra) # 80003430 <_Z11printStringPKc>
    80002260:	00000613          	li	a2,0
    80002264:	00a00593          	li	a1,10
    80002268:	0009051b          	sext.w	a0,s2
    8000226c:	00001097          	auipc	ra,0x1
    80002270:	35c080e7          	jalr	860(ra) # 800035c8 <_Z8printIntiii>
    80002274:	00004517          	auipc	a0,0x4
    80002278:	10450513          	addi	a0,a0,260 # 80006378 <CONSOLE_STATUS+0x368>
    8000227c:	00001097          	auipc	ra,0x1
    80002280:	1b4080e7          	jalr	436(ra) # 80003430 <_Z11printStringPKc>
    80002284:	0400006f          	j	800022c4 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002288:	00004517          	auipc	a0,0x4
    8000228c:	ed850513          	addi	a0,a0,-296 # 80006160 <CONSOLE_STATUS+0x150>
    80002290:	00001097          	auipc	ra,0x1
    80002294:	1a0080e7          	jalr	416(ra) # 80003430 <_Z11printStringPKc>
    80002298:	00000613          	li	a2,0
    8000229c:	00a00593          	li	a1,10
    800022a0:	00048513          	mv	a0,s1
    800022a4:	00001097          	auipc	ra,0x1
    800022a8:	324080e7          	jalr	804(ra) # 800035c8 <_Z8printIntiii>
    800022ac:	00004517          	auipc	a0,0x4
    800022b0:	0cc50513          	addi	a0,a0,204 # 80006378 <CONSOLE_STATUS+0x368>
    800022b4:	00001097          	auipc	ra,0x1
    800022b8:	17c080e7          	jalr	380(ra) # 80003430 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800022bc:	0014849b          	addiw	s1,s1,1
    800022c0:	0ff4f493          	andi	s1,s1,255
    800022c4:	00500793          	li	a5,5
    800022c8:	fc97f0e3          	bgeu	a5,s1,80002288 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    800022cc:	00004517          	auipc	a0,0x4
    800022d0:	e6c50513          	addi	a0,a0,-404 # 80006138 <CONSOLE_STATUS+0x128>
    800022d4:	00001097          	auipc	ra,0x1
    800022d8:	15c080e7          	jalr	348(ra) # 80003430 <_Z11printStringPKc>
    finishedC = true;
    800022dc:	00100793          	li	a5,1
    800022e0:	00005717          	auipc	a4,0x5
    800022e4:	52f70123          	sb	a5,1314(a4) # 80007802 <finishedC>
    thread_dispatch();
    800022e8:	fffff097          	auipc	ra,0xfffff
    800022ec:	f8c080e7          	jalr	-116(ra) # 80001274 <_Z15thread_dispatchv>
}
    800022f0:	01813083          	ld	ra,24(sp)
    800022f4:	01013403          	ld	s0,16(sp)
    800022f8:	00813483          	ld	s1,8(sp)
    800022fc:	00013903          	ld	s2,0(sp)
    80002300:	02010113          	addi	sp,sp,32
    80002304:	00008067          	ret

0000000080002308 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80002308:	fe010113          	addi	sp,sp,-32
    8000230c:	00113c23          	sd	ra,24(sp)
    80002310:	00813823          	sd	s0,16(sp)
    80002314:	00913423          	sd	s1,8(sp)
    80002318:	01213023          	sd	s2,0(sp)
    8000231c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002320:	00a00493          	li	s1,10
    80002324:	0400006f          	j	80002364 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002328:	00004517          	auipc	a0,0x4
    8000232c:	e6850513          	addi	a0,a0,-408 # 80006190 <CONSOLE_STATUS+0x180>
    80002330:	00001097          	auipc	ra,0x1
    80002334:	100080e7          	jalr	256(ra) # 80003430 <_Z11printStringPKc>
    80002338:	00000613          	li	a2,0
    8000233c:	00a00593          	li	a1,10
    80002340:	00048513          	mv	a0,s1
    80002344:	00001097          	auipc	ra,0x1
    80002348:	284080e7          	jalr	644(ra) # 800035c8 <_Z8printIntiii>
    8000234c:	00004517          	auipc	a0,0x4
    80002350:	02c50513          	addi	a0,a0,44 # 80006378 <CONSOLE_STATUS+0x368>
    80002354:	00001097          	auipc	ra,0x1
    80002358:	0dc080e7          	jalr	220(ra) # 80003430 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000235c:	0014849b          	addiw	s1,s1,1
    80002360:	0ff4f493          	andi	s1,s1,255
    80002364:	00c00793          	li	a5,12
    80002368:	fc97f0e3          	bgeu	a5,s1,80002328 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000236c:	00004517          	auipc	a0,0x4
    80002370:	e2c50513          	addi	a0,a0,-468 # 80006198 <CONSOLE_STATUS+0x188>
    80002374:	00001097          	auipc	ra,0x1
    80002378:	0bc080e7          	jalr	188(ra) # 80003430 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000237c:	00500313          	li	t1,5
    thread_dispatch();
    80002380:	fffff097          	auipc	ra,0xfffff
    80002384:	ef4080e7          	jalr	-268(ra) # 80001274 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002388:	01000513          	li	a0,16
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	d88080e7          	jalr	-632(ra) # 80002114 <_Z9fibonaccim>
    80002394:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002398:	00004517          	auipc	a0,0x4
    8000239c:	e1050513          	addi	a0,a0,-496 # 800061a8 <CONSOLE_STATUS+0x198>
    800023a0:	00001097          	auipc	ra,0x1
    800023a4:	090080e7          	jalr	144(ra) # 80003430 <_Z11printStringPKc>
    800023a8:	00000613          	li	a2,0
    800023ac:	00a00593          	li	a1,10
    800023b0:	0009051b          	sext.w	a0,s2
    800023b4:	00001097          	auipc	ra,0x1
    800023b8:	214080e7          	jalr	532(ra) # 800035c8 <_Z8printIntiii>
    800023bc:	00004517          	auipc	a0,0x4
    800023c0:	fbc50513          	addi	a0,a0,-68 # 80006378 <CONSOLE_STATUS+0x368>
    800023c4:	00001097          	auipc	ra,0x1
    800023c8:	06c080e7          	jalr	108(ra) # 80003430 <_Z11printStringPKc>
    800023cc:	0400006f          	j	8000240c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800023d0:	00004517          	auipc	a0,0x4
    800023d4:	dc050513          	addi	a0,a0,-576 # 80006190 <CONSOLE_STATUS+0x180>
    800023d8:	00001097          	auipc	ra,0x1
    800023dc:	058080e7          	jalr	88(ra) # 80003430 <_Z11printStringPKc>
    800023e0:	00000613          	li	a2,0
    800023e4:	00a00593          	li	a1,10
    800023e8:	00048513          	mv	a0,s1
    800023ec:	00001097          	auipc	ra,0x1
    800023f0:	1dc080e7          	jalr	476(ra) # 800035c8 <_Z8printIntiii>
    800023f4:	00004517          	auipc	a0,0x4
    800023f8:	f8450513          	addi	a0,a0,-124 # 80006378 <CONSOLE_STATUS+0x368>
    800023fc:	00001097          	auipc	ra,0x1
    80002400:	034080e7          	jalr	52(ra) # 80003430 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002404:	0014849b          	addiw	s1,s1,1
    80002408:	0ff4f493          	andi	s1,s1,255
    8000240c:	00f00793          	li	a5,15
    80002410:	fc97f0e3          	bgeu	a5,s1,800023d0 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002414:	00004517          	auipc	a0,0x4
    80002418:	da450513          	addi	a0,a0,-604 # 800061b8 <CONSOLE_STATUS+0x1a8>
    8000241c:	00001097          	auipc	ra,0x1
    80002420:	014080e7          	jalr	20(ra) # 80003430 <_Z11printStringPKc>
    finishedD = true;
    80002424:	00100793          	li	a5,1
    80002428:	00005717          	auipc	a4,0x5
    8000242c:	3cf70da3          	sb	a5,987(a4) # 80007803 <finishedD>
    thread_dispatch();
    80002430:	fffff097          	auipc	ra,0xfffff
    80002434:	e44080e7          	jalr	-444(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002438:	01813083          	ld	ra,24(sp)
    8000243c:	01013403          	ld	s0,16(sp)
    80002440:	00813483          	ld	s1,8(sp)
    80002444:	00013903          	ld	s2,0(sp)
    80002448:	02010113          	addi	sp,sp,32
    8000244c:	00008067          	ret

0000000080002450 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80002450:	fc010113          	addi	sp,sp,-64
    80002454:	02113c23          	sd	ra,56(sp)
    80002458:	02813823          	sd	s0,48(sp)
    8000245c:	02913423          	sd	s1,40(sp)
    80002460:	03213023          	sd	s2,32(sp)
    80002464:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002468:	00000613          	li	a2,0
    8000246c:	00000597          	auipc	a1,0x0
    80002470:	b0858593          	addi	a1,a1,-1272 # 80001f74 <_Z11workerBodyAPv>
    80002474:	fc040513          	addi	a0,s0,-64
    80002478:	fffff097          	auipc	ra,0xfffff
    8000247c:	e88080e7          	jalr	-376(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadA created\n");
    80002480:	00004517          	auipc	a0,0x4
    80002484:	d4850513          	addi	a0,a0,-696 # 800061c8 <CONSOLE_STATUS+0x1b8>
    80002488:	00001097          	auipc	ra,0x1
    8000248c:	fa8080e7          	jalr	-88(ra) # 80003430 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002490:	00000613          	li	a2,0
    80002494:	00000597          	auipc	a1,0x0
    80002498:	bac58593          	addi	a1,a1,-1108 # 80002040 <_Z11workerBodyBPv>
    8000249c:	fc840513          	addi	a0,s0,-56
    800024a0:	fffff097          	auipc	ra,0xfffff
    800024a4:	e60080e7          	jalr	-416(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadB created\n");
    800024a8:	00004517          	auipc	a0,0x4
    800024ac:	d3850513          	addi	a0,a0,-712 # 800061e0 <CONSOLE_STATUS+0x1d0>
    800024b0:	00001097          	auipc	ra,0x1
    800024b4:	f80080e7          	jalr	-128(ra) # 80003430 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800024b8:	00000613          	li	a2,0
    800024bc:	00000597          	auipc	a1,0x0
    800024c0:	ccc58593          	addi	a1,a1,-820 # 80002188 <_Z11workerBodyCPv>
    800024c4:	fd040513          	addi	a0,s0,-48
    800024c8:	fffff097          	auipc	ra,0xfffff
    800024cc:	e38080e7          	jalr	-456(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadC created\n");
    800024d0:	00004517          	auipc	a0,0x4
    800024d4:	d2850513          	addi	a0,a0,-728 # 800061f8 <CONSOLE_STATUS+0x1e8>
    800024d8:	00001097          	auipc	ra,0x1
    800024dc:	f58080e7          	jalr	-168(ra) # 80003430 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800024e0:	00000613          	li	a2,0
    800024e4:	00000597          	auipc	a1,0x0
    800024e8:	e2458593          	addi	a1,a1,-476 # 80002308 <_Z11workerBodyDPv>
    800024ec:	fd840513          	addi	a0,s0,-40
    800024f0:	fffff097          	auipc	ra,0xfffff
    800024f4:	e10080e7          	jalr	-496(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    printString("ThreadD created\n");
    800024f8:	00004517          	auipc	a0,0x4
    800024fc:	d1850513          	addi	a0,a0,-744 # 80006210 <CONSOLE_STATUS+0x200>
    80002500:	00001097          	auipc	ra,0x1
    80002504:	f30080e7          	jalr	-208(ra) # 80003430 <_Z11printStringPKc>
    80002508:	00c0006f          	j	80002514 <_Z18Threads_C_API_testv+0xc4>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000250c:	fffff097          	auipc	ra,0xfffff
    80002510:	d68080e7          	jalr	-664(ra) # 80001274 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002514:	00005797          	auipc	a5,0x5
    80002518:	2ec7c783          	lbu	a5,748(a5) # 80007800 <finishedA>
    8000251c:	fe0788e3          	beqz	a5,8000250c <_Z18Threads_C_API_testv+0xbc>
    80002520:	00005797          	auipc	a5,0x5
    80002524:	2e17c783          	lbu	a5,737(a5) # 80007801 <finishedB>
    80002528:	fe0782e3          	beqz	a5,8000250c <_Z18Threads_C_API_testv+0xbc>
    8000252c:	00005797          	auipc	a5,0x5
    80002530:	2d67c783          	lbu	a5,726(a5) # 80007802 <finishedC>
    80002534:	fc078ce3          	beqz	a5,8000250c <_Z18Threads_C_API_testv+0xbc>
    80002538:	00005797          	auipc	a5,0x5
    8000253c:	2cb7c783          	lbu	a5,715(a5) # 80007803 <finishedD>
    80002540:	fc0786e3          	beqz	a5,8000250c <_Z18Threads_C_API_testv+0xbc>
    }

    for (auto &thread: threads) { delete thread; }
    80002544:	fc040493          	addi	s1,s0,-64
    80002548:	0080006f          	j	80002550 <_Z18Threads_C_API_testv+0x100>
    8000254c:	00848493          	addi	s1,s1,8
    80002550:	fe040793          	addi	a5,s0,-32
    80002554:	02f48463          	beq	s1,a5,8000257c <_Z18Threads_C_API_testv+0x12c>
    80002558:	0004b903          	ld	s2,0(s1)
    8000255c:	fe0908e3          	beqz	s2,8000254c <_Z18Threads_C_API_testv+0xfc>
    80002560:	00090513          	mv	a0,s2
    80002564:	fffff097          	auipc	ra,0xfffff
    80002568:	694080e7          	jalr	1684(ra) # 80001bf8 <_ZN3PCBD1Ev>
    8000256c:	00090513          	mv	a0,s2
    80002570:	fffff097          	auipc	ra,0xfffff
    80002574:	6fc080e7          	jalr	1788(ra) # 80001c6c <_ZN3PCBdlEPv>
    80002578:	fd5ff06f          	j	8000254c <_Z18Threads_C_API_testv+0xfc>
}
    8000257c:	03813083          	ld	ra,56(sp)
    80002580:	03013403          	ld	s0,48(sp)
    80002584:	02813483          	ld	s1,40(sp)
    80002588:	02013903          	ld	s2,32(sp)
    8000258c:	04010113          	addi	sp,sp,64
    80002590:	00008067          	ret

0000000080002594 <_Z8userMainv>:
//#include "../test/ConsumerProducer_CPP_Sync_API_test.hpp" // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//#include "../test/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta

void userMain() {
    80002594:	ff010113          	addi	sp,sp,-16
    80002598:	00113423          	sd	ra,8(sp)
    8000259c:	00813023          	sd	s0,0(sp)
    800025a0:	01010413          	addi	s0,sp,16
    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    800025a4:	00000097          	auipc	ra,0x0
    800025a8:	eac080e7          	jalr	-340(ra) # 80002450 <_Z18Threads_C_API_testv>
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    800025ac:	00813083          	ld	ra,8(sp)
    800025b0:	00013403          	ld	s0,0(sp)
    800025b4:	01010113          	addi	sp,sp,16
    800025b8:	00008067          	ret

00000000800025bc <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800025bc:	ff010113          	addi	sp,sp,-16
    800025c0:	00813423          	sd	s0,8(sp)
    800025c4:	01010413          	addi	s0,sp,16
    if(!process) return;
    800025c8:	02050663          	beqz	a0,800025f4 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    800025cc:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800025d0:	00005797          	auipc	a5,0x5
    800025d4:	2387b783          	ld	a5,568(a5) # 80007808 <_ZN9Scheduler4tailE>
    800025d8:	02078463          	beqz	a5,80002600 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    800025dc:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    800025e0:	00005797          	auipc	a5,0x5
    800025e4:	22878793          	addi	a5,a5,552 # 80007808 <_ZN9Scheduler4tailE>
    800025e8:	0007b703          	ld	a4,0(a5)
    800025ec:	00073703          	ld	a4,0(a4)
    800025f0:	00e7b023          	sd	a4,0(a5)
    }
}
    800025f4:	00813403          	ld	s0,8(sp)
    800025f8:	01010113          	addi	sp,sp,16
    800025fc:	00008067          	ret
        head = tail = process;
    80002600:	00005797          	auipc	a5,0x5
    80002604:	20878793          	addi	a5,a5,520 # 80007808 <_ZN9Scheduler4tailE>
    80002608:	00a7b023          	sd	a0,0(a5)
    8000260c:	00a7b423          	sd	a0,8(a5)
    80002610:	fe5ff06f          	j	800025f4 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002614 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002614:	ff010113          	addi	sp,sp,-16
    80002618:	00813423          	sd	s0,8(sp)
    8000261c:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002620:	00005517          	auipc	a0,0x5
    80002624:	1f053503          	ld	a0,496(a0) # 80007810 <_ZN9Scheduler4headE>
    80002628:	02050463          	beqz	a0,80002650 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    8000262c:	00053703          	ld	a4,0(a0)
    80002630:	00005797          	auipc	a5,0x5
    80002634:	1d878793          	addi	a5,a5,472 # 80007808 <_ZN9Scheduler4tailE>
    80002638:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    8000263c:	0007b783          	ld	a5,0(a5)
    80002640:	00f50e63          	beq	a0,a5,8000265c <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002644:	00813403          	ld	s0,8(sp)
    80002648:	01010113          	addi	sp,sp,16
    8000264c:	00008067          	ret
        return idleProcess;
    80002650:	00005517          	auipc	a0,0x5
    80002654:	1c853503          	ld	a0,456(a0) # 80007818 <_ZN9Scheduler11idleProcessE>
    80002658:	fedff06f          	j	80002644 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    8000265c:	00005797          	auipc	a5,0x5
    80002660:	1ae7b623          	sd	a4,428(a5) # 80007808 <_ZN9Scheduler4tailE>
    80002664:	fe1ff06f          	j	80002644 <_ZN9Scheduler3getEv+0x30>

0000000080002668 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002668:	ff010113          	addi	sp,sp,-16
    8000266c:	00813423          	sd	s0,8(sp)
    80002670:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002674:	00050e63          	beqz	a0,80002690 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002678:	00005797          	auipc	a5,0x5
    8000267c:	1987b783          	ld	a5,408(a5) # 80007810 <_ZN9Scheduler4headE>
    80002680:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002684:	00078c63          	beqz	a5,8000269c <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002688:	00005797          	auipc	a5,0x5
    8000268c:	18a7b423          	sd	a0,392(a5) # 80007810 <_ZN9Scheduler4headE>
    }
}
    80002690:	00813403          	ld	s0,8(sp)
    80002694:	01010113          	addi	sp,sp,16
    80002698:	00008067          	ret
        head = tail = process;
    8000269c:	00005797          	auipc	a5,0x5
    800026a0:	16c78793          	addi	a5,a5,364 # 80007808 <_ZN9Scheduler4tailE>
    800026a4:	00a7b023          	sd	a0,0(a5)
    800026a8:	00a7b423          	sd	a0,8(a5)
    800026ac:	fe5ff06f          	j	80002690 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

00000000800026b0 <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    800026b0:	ff010113          	addi	sp,sp,-16
    800026b4:	00813423          	sd	s0,8(sp)
    800026b8:	01010413          	addi	s0,sp,16
    while(true) {}
    800026bc:	0000006f          	j	800026bc <idleProcess+0xc>

00000000800026c0 <_Z8userModev>:
#define USERMAIN_H

PCB* userProcess = nullptr;

extern "C" void interrupt();
void userMode() {
    800026c0:	ff010113          	addi	sp,sp,-16
    800026c4:	00813423          	sd	s0,8(sp)
    800026c8:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::userMode;
    asm volatile("mv a0, %0" : : "r" (code));
    800026cc:	04300793          	li	a5,67
    800026d0:	00078513          	mv	a0,a5
    asm volatile("ecall");
    800026d4:	00000073          	ecall

}
    800026d8:	00813403          	ld	s0,8(sp)
    800026dc:	01010113          	addi	sp,sp,16
    800026e0:	00008067          	ret

00000000800026e4 <_Z15userMainWrapperPv>:
void userMain();
void userMainWrapper(void*) {
    800026e4:	ff010113          	addi	sp,sp,-16
    800026e8:	00113423          	sd	ra,8(sp)
    800026ec:	00813023          	sd	s0,0(sp)
    800026f0:	01010413          	addi	s0,sp,16
    userMode();
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	fcc080e7          	jalr	-52(ra) # 800026c0 <_Z8userModev>
    userMain();
    800026fc:	00000097          	auipc	ra,0x0
    80002700:	e98080e7          	jalr	-360(ra) # 80002594 <_Z8userMainv>
}
    80002704:	00813083          	ld	ra,8(sp)
    80002708:	00013403          	ld	s0,0(sp)
    8000270c:	01010113          	addi	sp,sp,16
    80002710:	00008067          	ret

0000000080002714 <main>:
}
// ------------

int main() {
    80002714:	ff010113          	addi	sp,sp,-16
    80002718:	00113423          	sd	ra,8(sp)
    8000271c:	00813023          	sd	s0,0(sp)
    80002720:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002724:	00005797          	auipc	a5,0x5
    80002728:	0147b783          	ld	a5,20(a5) # 80007738 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000272c:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002730:	00000593          	li	a1,0
    80002734:	00000513          	li	a0,0
    80002738:	fffff097          	auipc	ra,0xfffff
    8000273c:	55c080e7          	jalr	1372(ra) # 80001c94 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80002740:	00005797          	auipc	a5,0x5
    80002744:	fd87b783          	ld	a5,-40(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002748:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    8000274c:	00000593          	li	a1,0
    80002750:	00005517          	auipc	a0,0x5
    80002754:	ff053503          	ld	a0,-16(a0) # 80007740 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	bf8080e7          	jalr	-1032(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    80002760:	00000593          	li	a1,0
    80002764:	00005517          	auipc	a0,0x5
    80002768:	fc453503          	ld	a0,-60(a0) # 80007728 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	be4080e7          	jalr	-1052(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    80002774:	00000593          	li	a1,0
    80002778:	00005517          	auipc	a0,0x5
    8000277c:	fb853503          	ld	a0,-72(a0) # 80007730 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	bd0080e7          	jalr	-1072(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002788:	00200793          	li	a5,2
    8000278c:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    thread_create(&userProcess, userMainWrapper, nullptr);
    80002790:	00000613          	li	a2,0
    80002794:	00000597          	auipc	a1,0x0
    80002798:	f5058593          	addi	a1,a1,-176 # 800026e4 <_Z15userMainWrapperPv>
    8000279c:	00005517          	auipc	a0,0x5
    800027a0:	08450513          	addi	a0,a0,132 # 80007820 <userProcess>
    800027a4:	fffff097          	auipc	ra,0xfffff
    800027a8:	b5c080e7          	jalr	-1188(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800027ac:	00000613          	li	a2,0
    800027b0:	00005597          	auipc	a1,0x5
    800027b4:	f585b583          	ld	a1,-168(a1) # 80007708 <_GLOBAL_OFFSET_TABLE_+0x50>
    800027b8:	00005517          	auipc	a0,0x5
    800027bc:	f9853503          	ld	a0,-104(a0) # 80007750 <_GLOBAL_OFFSET_TABLE_+0x98>
    800027c0:	fffff097          	auipc	ra,0xfffff
    800027c4:	b40080e7          	jalr	-1216(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800027c8:	00000613          	li	a2,0
    800027cc:	00005597          	auipc	a1,0x5
    800027d0:	f7c5b583          	ld	a1,-132(a1) # 80007748 <_GLOBAL_OFFSET_TABLE_+0x90>
    800027d4:	00005517          	auipc	a0,0x5
    800027d8:	ef453503          	ld	a0,-268(a0) # 800076c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800027dc:	fffff097          	auipc	ra,0xfffff
    800027e0:	b24080e7          	jalr	-1244(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    800027e4:	00000613          	li	a2,0
    800027e8:	00000597          	auipc	a1,0x0
    800027ec:	ec858593          	addi	a1,a1,-312 # 800026b0 <idleProcess>
    800027f0:	00005517          	auipc	a0,0x5
    800027f4:	f2053503          	ld	a0,-224(a0) # 80007710 <_GLOBAL_OFFSET_TABLE_+0x58>
    800027f8:	fffff097          	auipc	ra,0xfffff
    800027fc:	a10080e7          	jalr	-1520(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    80002800:	00005797          	auipc	a5,0x5
    80002804:	0207b783          	ld	a5,32(a5) # 80007820 <userProcess>
    80002808:	0287c783          	lbu	a5,40(a5)
    8000280c:	00079863          	bnez	a5,8000281c <main+0x108>
        thread_dispatch();
    80002810:	fffff097          	auipc	ra,0xfffff
    80002814:	a64080e7          	jalr	-1436(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    80002818:	fe9ff06f          	j	80002800 <main+0xec>
    }

    return 0;
    8000281c:	00000513          	li	a0,0
    80002820:	00813083          	ld	ra,8(sp)
    80002824:	00013403          	ld	s0,0(sp)
    80002828:	01010113          	addi	sp,sp,16
    8000282c:	00008067          	ret

0000000080002830 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002830:	fe010113          	addi	sp,sp,-32
    80002834:	00113c23          	sd	ra,24(sp)
    80002838:	00813823          	sd	s0,16(sp)
    8000283c:	00913423          	sd	s1,8(sp)
    80002840:	02010413          	addi	s0,sp,32
    80002844:	00005797          	auipc	a5,0x5
    80002848:	e2478793          	addi	a5,a5,-476 # 80007668 <_ZTV6Thread+0x10>
    8000284c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002850:	00853483          	ld	s1,8(a0)
    80002854:	00048e63          	beqz	s1,80002870 <_ZN6ThreadD1Ev+0x40>
    80002858:	00048513          	mv	a0,s1
    8000285c:	fffff097          	auipc	ra,0xfffff
    80002860:	39c080e7          	jalr	924(ra) # 80001bf8 <_ZN3PCBD1Ev>
    80002864:	00048513          	mv	a0,s1
    80002868:	fffff097          	auipc	ra,0xfffff
    8000286c:	404080e7          	jalr	1028(ra) # 80001c6c <_ZN3PCBdlEPv>
}
    80002870:	01813083          	ld	ra,24(sp)
    80002874:	01013403          	ld	s0,16(sp)
    80002878:	00813483          	ld	s1,8(sp)
    8000287c:	02010113          	addi	sp,sp,32
    80002880:	00008067          	ret

0000000080002884 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002884:	ff010113          	addi	sp,sp,-16
    80002888:	00113423          	sd	ra,8(sp)
    8000288c:	00813023          	sd	s0,0(sp)
    80002890:	01010413          	addi	s0,sp,16
    80002894:	00005797          	auipc	a5,0x5
    80002898:	dfc78793          	addi	a5,a5,-516 # 80007690 <_ZTV9Semaphore+0x10>
    8000289c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800028a0:	00853503          	ld	a0,8(a0)
    800028a4:	fffff097          	auipc	ra,0xfffff
    800028a8:	b7c080e7          	jalr	-1156(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    800028ac:	00813083          	ld	ra,8(sp)
    800028b0:	00013403          	ld	s0,0(sp)
    800028b4:	01010113          	addi	sp,sp,16
    800028b8:	00008067          	ret

00000000800028bc <_Znwm>:
void* operator new (size_t size) {
    800028bc:	ff010113          	addi	sp,sp,-16
    800028c0:	00113423          	sd	ra,8(sp)
    800028c4:	00813023          	sd	s0,0(sp)
    800028c8:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800028cc:	fffff097          	auipc	ra,0xfffff
    800028d0:	8c8080e7          	jalr	-1848(ra) # 80001194 <_Z9mem_allocm>
}
    800028d4:	00813083          	ld	ra,8(sp)
    800028d8:	00013403          	ld	s0,0(sp)
    800028dc:	01010113          	addi	sp,sp,16
    800028e0:	00008067          	ret

00000000800028e4 <_Znam>:
void* operator new [](size_t size) {
    800028e4:	ff010113          	addi	sp,sp,-16
    800028e8:	00113423          	sd	ra,8(sp)
    800028ec:	00813023          	sd	s0,0(sp)
    800028f0:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800028f4:	fffff097          	auipc	ra,0xfffff
    800028f8:	8a0080e7          	jalr	-1888(ra) # 80001194 <_Z9mem_allocm>
}
    800028fc:	00813083          	ld	ra,8(sp)
    80002900:	00013403          	ld	s0,0(sp)
    80002904:	01010113          	addi	sp,sp,16
    80002908:	00008067          	ret

000000008000290c <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    8000290c:	ff010113          	addi	sp,sp,-16
    80002910:	00113423          	sd	ra,8(sp)
    80002914:	00813023          	sd	s0,0(sp)
    80002918:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    8000291c:	fffff097          	auipc	ra,0xfffff
    80002920:	8b8080e7          	jalr	-1864(ra) # 800011d4 <_Z8mem_freePv>
}
    80002924:	00813083          	ld	ra,8(sp)
    80002928:	00013403          	ld	s0,0(sp)
    8000292c:	01010113          	addi	sp,sp,16
    80002930:	00008067          	ret

0000000080002934 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002934:	fe010113          	addi	sp,sp,-32
    80002938:	00113c23          	sd	ra,24(sp)
    8000293c:	00813823          	sd	s0,16(sp)
    80002940:	00913423          	sd	s1,8(sp)
    80002944:	02010413          	addi	s0,sp,32
    80002948:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    8000294c:	00053503          	ld	a0,0(a0)
    80002950:	0104b783          	ld	a5,16(s1)
    80002954:	00f50533          	add	a0,a0,a5
    80002958:	0084b783          	ld	a5,8(s1)
    8000295c:	0017f713          	andi	a4,a5,1
    80002960:	00070863          	beqz	a4,80002970 <_Z13threadWrapperPv+0x3c>
    80002964:	00053703          	ld	a4,0(a0)
    80002968:	00f707b3          	add	a5,a4,a5
    8000296c:	fff7b783          	ld	a5,-1(a5)
    80002970:	000780e7          	jalr	a5
    delete tArg;
    80002974:	00048863          	beqz	s1,80002984 <_Z13threadWrapperPv+0x50>
    80002978:	00048513          	mv	a0,s1
    8000297c:	00000097          	auipc	ra,0x0
    80002980:	f90080e7          	jalr	-112(ra) # 8000290c <_ZdlPv>
}
    80002984:	01813083          	ld	ra,24(sp)
    80002988:	01013403          	ld	s0,16(sp)
    8000298c:	00813483          	ld	s1,8(sp)
    80002990:	02010113          	addi	sp,sp,32
    80002994:	00008067          	ret

0000000080002998 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00113423          	sd	ra,8(sp)
    800029a0:	00813023          	sd	s0,0(sp)
    800029a4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800029a8:	fffff097          	auipc	ra,0xfffff
    800029ac:	82c080e7          	jalr	-2004(ra) # 800011d4 <_Z8mem_freePv>
}
    800029b0:	00813083          	ld	ra,8(sp)
    800029b4:	00013403          	ld	s0,0(sp)
    800029b8:	01010113          	addi	sp,sp,16
    800029bc:	00008067          	ret

00000000800029c0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800029c0:	ff010113          	addi	sp,sp,-16
    800029c4:	00113423          	sd	ra,8(sp)
    800029c8:	00813023          	sd	s0,0(sp)
    800029cc:	01010413          	addi	s0,sp,16
    800029d0:	00005797          	auipc	a5,0x5
    800029d4:	c9878793          	addi	a5,a5,-872 # 80007668 <_ZTV6Thread+0x10>
    800029d8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    800029dc:	00850513          	addi	a0,a0,8
    800029e0:	fffff097          	auipc	ra,0xfffff
    800029e4:	828080e7          	jalr	-2008(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800029e8:	00813083          	ld	ra,8(sp)
    800029ec:	00013403          	ld	s0,0(sp)
    800029f0:	01010113          	addi	sp,sp,16
    800029f4:	00008067          	ret

00000000800029f8 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    800029f8:	ff010113          	addi	sp,sp,-16
    800029fc:	00113423          	sd	ra,8(sp)
    80002a00:	00813023          	sd	s0,0(sp)
    80002a04:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002a08:	00000097          	auipc	ra,0x0
    80002a0c:	718080e7          	jalr	1816(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002a10:	00813083          	ld	ra,8(sp)
    80002a14:	00013403          	ld	s0,0(sp)
    80002a18:	01010113          	addi	sp,sp,16
    80002a1c:	00008067          	ret

0000000080002a20 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002a20:	ff010113          	addi	sp,sp,-16
    80002a24:	00113423          	sd	ra,8(sp)
    80002a28:	00813023          	sd	s0,0(sp)
    80002a2c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002a30:	00001097          	auipc	ra,0x1
    80002a34:	854080e7          	jalr	-1964(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002a38:	00813083          	ld	ra,8(sp)
    80002a3c:	00013403          	ld	s0,0(sp)
    80002a40:	01010113          	addi	sp,sp,16
    80002a44:	00008067          	ret

0000000080002a48 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002a48:	fe010113          	addi	sp,sp,-32
    80002a4c:	00113c23          	sd	ra,24(sp)
    80002a50:	00813823          	sd	s0,16(sp)
    80002a54:	00913423          	sd	s1,8(sp)
    80002a58:	02010413          	addi	s0,sp,32
    80002a5c:	00050493          	mv	s1,a0
}
    80002a60:	00000097          	auipc	ra,0x0
    80002a64:	dd0080e7          	jalr	-560(ra) # 80002830 <_ZN6ThreadD1Ev>
    80002a68:	00048513          	mv	a0,s1
    80002a6c:	00000097          	auipc	ra,0x0
    80002a70:	fb4080e7          	jalr	-76(ra) # 80002a20 <_ZN6ThreaddlEPv>
    80002a74:	01813083          	ld	ra,24(sp)
    80002a78:	01013403          	ld	s0,16(sp)
    80002a7c:	00813483          	ld	s1,8(sp)
    80002a80:	02010113          	addi	sp,sp,32
    80002a84:	00008067          	ret

0000000080002a88 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002a88:	ff010113          	addi	sp,sp,-16
    80002a8c:	00113423          	sd	ra,8(sp)
    80002a90:	00813023          	sd	s0,0(sp)
    80002a94:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002a98:	ffffe097          	auipc	ra,0xffffe
    80002a9c:	7dc080e7          	jalr	2012(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002aa0:	00813083          	ld	ra,8(sp)
    80002aa4:	00013403          	ld	s0,0(sp)
    80002aa8:	01010113          	addi	sp,sp,16
    80002aac:	00008067          	ret

0000000080002ab0 <_ZN6Thread5startEv>:
int Thread::start() {
    80002ab0:	ff010113          	addi	sp,sp,-16
    80002ab4:	00113423          	sd	ra,8(sp)
    80002ab8:	00813023          	sd	s0,0(sp)
    80002abc:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002ac0:	00850513          	addi	a0,a0,8
    80002ac4:	fffff097          	auipc	ra,0xfffff
    80002ac8:	80c080e7          	jalr	-2036(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002acc:	00000513          	li	a0,0
    80002ad0:	00813083          	ld	ra,8(sp)
    80002ad4:	00013403          	ld	s0,0(sp)
    80002ad8:	01010113          	addi	sp,sp,16
    80002adc:	00008067          	ret

0000000080002ae0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002ae0:	fe010113          	addi	sp,sp,-32
    80002ae4:	00113c23          	sd	ra,24(sp)
    80002ae8:	00813823          	sd	s0,16(sp)
    80002aec:	00913423          	sd	s1,8(sp)
    80002af0:	02010413          	addi	s0,sp,32
    80002af4:	00050493          	mv	s1,a0
    80002af8:	00005797          	auipc	a5,0x5
    80002afc:	b7078793          	addi	a5,a5,-1168 # 80007668 <_ZTV6Thread+0x10>
    80002b00:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002b04:	01800513          	li	a0,24
    80002b08:	00000097          	auipc	ra,0x0
    80002b0c:	db4080e7          	jalr	-588(ra) # 800028bc <_Znwm>
    80002b10:	00050613          	mv	a2,a0
    80002b14:	00953023          	sd	s1,0(a0)
    80002b18:	01100793          	li	a5,17
    80002b1c:	00f53423          	sd	a5,8(a0)
    80002b20:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002b24:	00000597          	auipc	a1,0x0
    80002b28:	e1058593          	addi	a1,a1,-496 # 80002934 <_Z13threadWrapperPv>
    80002b2c:	00848513          	addi	a0,s1,8
    80002b30:	ffffe097          	auipc	ra,0xffffe
    80002b34:	6d8080e7          	jalr	1752(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002b38:	01813083          	ld	ra,24(sp)
    80002b3c:	01013403          	ld	s0,16(sp)
    80002b40:	00813483          	ld	s1,8(sp)
    80002b44:	02010113          	addi	sp,sp,32
    80002b48:	00008067          	ret

0000000080002b4c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002b4c:	ff010113          	addi	sp,sp,-16
    80002b50:	00113423          	sd	ra,8(sp)
    80002b54:	00813023          	sd	s0,0(sp)
    80002b58:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002b5c:	fffff097          	auipc	ra,0xfffff
    80002b60:	904080e7          	jalr	-1788(ra) # 80001460 <_Z10time_sleepm>
}
    80002b64:	00813083          	ld	ra,8(sp)
    80002b68:	00013403          	ld	s0,0(sp)
    80002b6c:	01010113          	addi	sp,sp,16
    80002b70:	00008067          	ret

0000000080002b74 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002b74:	fe010113          	addi	sp,sp,-32
    80002b78:	00113c23          	sd	ra,24(sp)
    80002b7c:	00813823          	sd	s0,16(sp)
    80002b80:	00913423          	sd	s1,8(sp)
    80002b84:	02010413          	addi	s0,sp,32
    80002b88:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002b8c:	0200006f          	j	80002bac <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002b90:	00053703          	ld	a4,0(a0)
    80002b94:	00f707b3          	add	a5,a4,a5
    80002b98:	fff7b783          	ld	a5,-1(a5)
    80002b9c:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002ba0:	0184b503          	ld	a0,24(s1)
    80002ba4:	00000097          	auipc	ra,0x0
    80002ba8:	fa8080e7          	jalr	-88(ra) # 80002b4c <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002bac:	0004b503          	ld	a0,0(s1)
    80002bb0:	0104b783          	ld	a5,16(s1)
    80002bb4:	00f50533          	add	a0,a0,a5
    80002bb8:	0084b783          	ld	a5,8(s1)
    80002bbc:	0017f713          	andi	a4,a5,1
    80002bc0:	fc070ee3          	beqz	a4,80002b9c <_Z21periodicThreadWrapperPv+0x28>
    80002bc4:	fcdff06f          	j	80002b90 <_Z21periodicThreadWrapperPv+0x1c>

0000000080002bc8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002bc8:	fe010113          	addi	sp,sp,-32
    80002bcc:	00113c23          	sd	ra,24(sp)
    80002bd0:	00813823          	sd	s0,16(sp)
    80002bd4:	00913423          	sd	s1,8(sp)
    80002bd8:	01213023          	sd	s2,0(sp)
    80002bdc:	02010413          	addi	s0,sp,32
    80002be0:	00050493          	mv	s1,a0
    80002be4:	00005797          	auipc	a5,0x5
    80002be8:	aac78793          	addi	a5,a5,-1364 # 80007690 <_ZTV9Semaphore+0x10>
    80002bec:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002bf0:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002bf4:	01800513          	li	a0,24
    80002bf8:	00000097          	auipc	ra,0x0
    80002bfc:	474080e7          	jalr	1140(ra) # 8000306c <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002c00:	00053023          	sd	zero,0(a0)
    80002c04:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80002c08:	01252823          	sw	s2,16(a0)
    80002c0c:	00a4b423          	sd	a0,8(s1)
}
    80002c10:	01813083          	ld	ra,24(sp)
    80002c14:	01013403          	ld	s0,16(sp)
    80002c18:	00813483          	ld	s1,8(sp)
    80002c1c:	00013903          	ld	s2,0(sp)
    80002c20:	02010113          	addi	sp,sp,32
    80002c24:	00008067          	ret

0000000080002c28 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002c28:	ff010113          	addi	sp,sp,-16
    80002c2c:	00113423          	sd	ra,8(sp)
    80002c30:	00813023          	sd	s0,0(sp)
    80002c34:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002c38:	00853503          	ld	a0,8(a0)
    80002c3c:	ffffe097          	auipc	ra,0xffffe
    80002c40:	75c080e7          	jalr	1884(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80002c44:	00813083          	ld	ra,8(sp)
    80002c48:	00013403          	ld	s0,0(sp)
    80002c4c:	01010113          	addi	sp,sp,16
    80002c50:	00008067          	ret

0000000080002c54 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002c54:	ff010113          	addi	sp,sp,-16
    80002c58:	00113423          	sd	ra,8(sp)
    80002c5c:	00813023          	sd	s0,0(sp)
    80002c60:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002c64:	00853503          	ld	a0,8(a0)
    80002c68:	ffffe097          	auipc	ra,0xffffe
    80002c6c:	778080e7          	jalr	1912(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80002c70:	00813083          	ld	ra,8(sp)
    80002c74:	00013403          	ld	s0,0(sp)
    80002c78:	01010113          	addi	sp,sp,16
    80002c7c:	00008067          	ret

0000000080002c80 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002c80:	ff010113          	addi	sp,sp,-16
    80002c84:	00113423          	sd	ra,8(sp)
    80002c88:	00813023          	sd	s0,0(sp)
    80002c8c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	5f4080e7          	jalr	1524(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002c98:	00813083          	ld	ra,8(sp)
    80002c9c:	00013403          	ld	s0,0(sp)
    80002ca0:	01010113          	addi	sp,sp,16
    80002ca4:	00008067          	ret

0000000080002ca8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002ca8:	fe010113          	addi	sp,sp,-32
    80002cac:	00113c23          	sd	ra,24(sp)
    80002cb0:	00813823          	sd	s0,16(sp)
    80002cb4:	00913423          	sd	s1,8(sp)
    80002cb8:	02010413          	addi	s0,sp,32
    80002cbc:	00050493          	mv	s1,a0
}
    80002cc0:	00000097          	auipc	ra,0x0
    80002cc4:	bc4080e7          	jalr	-1084(ra) # 80002884 <_ZN9SemaphoreD1Ev>
    80002cc8:	00048513          	mv	a0,s1
    80002ccc:	00000097          	auipc	ra,0x0
    80002cd0:	fb4080e7          	jalr	-76(ra) # 80002c80 <_ZN9SemaphoredlEPv>
    80002cd4:	01813083          	ld	ra,24(sp)
    80002cd8:	01013403          	ld	s0,16(sp)
    80002cdc:	00813483          	ld	s1,8(sp)
    80002ce0:	02010113          	addi	sp,sp,32
    80002ce4:	00008067          	ret

0000000080002ce8 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002ce8:	ff010113          	addi	sp,sp,-16
    80002cec:	00113423          	sd	ra,8(sp)
    80002cf0:	00813023          	sd	s0,0(sp)
    80002cf4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002cf8:	00000097          	auipc	ra,0x0
    80002cfc:	428080e7          	jalr	1064(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002d00:	00813083          	ld	ra,8(sp)
    80002d04:	00013403          	ld	s0,0(sp)
    80002d08:	01010113          	addi	sp,sp,16
    80002d0c:	00008067          	ret

0000000080002d10 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80002d10:	fe010113          	addi	sp,sp,-32
    80002d14:	00113c23          	sd	ra,24(sp)
    80002d18:	00813823          	sd	s0,16(sp)
    80002d1c:	00913423          	sd	s1,8(sp)
    80002d20:	01213023          	sd	s2,0(sp)
    80002d24:	02010413          	addi	s0,sp,32
    80002d28:	00050493          	mv	s1,a0
    80002d2c:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002d30:	02000513          	li	a0,32
    80002d34:	00000097          	auipc	ra,0x0
    80002d38:	b88080e7          	jalr	-1144(ra) # 800028bc <_Znwm>
    80002d3c:	00050613          	mv	a2,a0
    80002d40:	00953023          	sd	s1,0(a0)
    80002d44:	01900793          	li	a5,25
    80002d48:	00f53423          	sd	a5,8(a0)
    80002d4c:	00053823          	sd	zero,16(a0)
    80002d50:	01253c23          	sd	s2,24(a0)
    80002d54:	00000597          	auipc	a1,0x0
    80002d58:	e2058593          	addi	a1,a1,-480 # 80002b74 <_Z21periodicThreadWrapperPv>
    80002d5c:	00048513          	mv	a0,s1
    80002d60:	00000097          	auipc	ra,0x0
    80002d64:	c60080e7          	jalr	-928(ra) # 800029c0 <_ZN6ThreadC1EPFvPvES0_>
    80002d68:	00005797          	auipc	a5,0x5
    80002d6c:	8d078793          	addi	a5,a5,-1840 # 80007638 <_ZTV14PeriodicThread+0x10>
    80002d70:	00f4b023          	sd	a5,0(s1)
{}
    80002d74:	01813083          	ld	ra,24(sp)
    80002d78:	01013403          	ld	s0,16(sp)
    80002d7c:	00813483          	ld	s1,8(sp)
    80002d80:	00013903          	ld	s2,0(sp)
    80002d84:	02010113          	addi	sp,sp,32
    80002d88:	00008067          	ret

0000000080002d8c <_ZN7Console4getcEv>:


char Console::getc() {
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
    return ::getc();
    80002d9c:	ffffe097          	auipc	ra,0xffffe
    80002da0:	70c080e7          	jalr	1804(ra) # 800014a8 <_Z4getcv>
}
    80002da4:	00813083          	ld	ra,8(sp)
    80002da8:	00013403          	ld	s0,0(sp)
    80002dac:	01010113          	addi	sp,sp,16
    80002db0:	00008067          	ret

0000000080002db4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002db4:	ff010113          	addi	sp,sp,-16
    80002db8:	00113423          	sd	ra,8(sp)
    80002dbc:	00813023          	sd	s0,0(sp)
    80002dc0:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002dc4:	ffffe097          	auipc	ra,0xffffe
    80002dc8:	714080e7          	jalr	1812(ra) # 800014d8 <_Z4putcc>
}
    80002dcc:	00813083          	ld	ra,8(sp)
    80002dd0:	00013403          	ld	s0,0(sp)
    80002dd4:	01010113          	addi	sp,sp,16
    80002dd8:	00008067          	ret

0000000080002ddc <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002ddc:	ff010113          	addi	sp,sp,-16
    80002de0:	00813423          	sd	s0,8(sp)
    80002de4:	01010413          	addi	s0,sp,16
    80002de8:	00813403          	ld	s0,8(sp)
    80002dec:	01010113          	addi	sp,sp,16
    80002df0:	00008067          	ret

0000000080002df4 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002df4:	ff010113          	addi	sp,sp,-16
    80002df8:	00813423          	sd	s0,8(sp)
    80002dfc:	01010413          	addi	s0,sp,16
    80002e00:	00813403          	ld	s0,8(sp)
    80002e04:	01010113          	addi	sp,sp,16
    80002e08:	00008067          	ret

0000000080002e0c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00113423          	sd	ra,8(sp)
    80002e14:	00813023          	sd	s0,0(sp)
    80002e18:	01010413          	addi	s0,sp,16
    80002e1c:	00005797          	auipc	a5,0x5
    80002e20:	81c78793          	addi	a5,a5,-2020 # 80007638 <_ZTV14PeriodicThread+0x10>
    80002e24:	00f53023          	sd	a5,0(a0)
    80002e28:	00000097          	auipc	ra,0x0
    80002e2c:	a08080e7          	jalr	-1528(ra) # 80002830 <_ZN6ThreadD1Ev>
    80002e30:	00813083          	ld	ra,8(sp)
    80002e34:	00013403          	ld	s0,0(sp)
    80002e38:	01010113          	addi	sp,sp,16
    80002e3c:	00008067          	ret

0000000080002e40 <_ZN14PeriodicThreadD0Ev>:
    80002e40:	fe010113          	addi	sp,sp,-32
    80002e44:	00113c23          	sd	ra,24(sp)
    80002e48:	00813823          	sd	s0,16(sp)
    80002e4c:	00913423          	sd	s1,8(sp)
    80002e50:	02010413          	addi	s0,sp,32
    80002e54:	00050493          	mv	s1,a0
    80002e58:	00004797          	auipc	a5,0x4
    80002e5c:	7e078793          	addi	a5,a5,2016 # 80007638 <_ZTV14PeriodicThread+0x10>
    80002e60:	00f53023          	sd	a5,0(a0)
    80002e64:	00000097          	auipc	ra,0x0
    80002e68:	9cc080e7          	jalr	-1588(ra) # 80002830 <_ZN6ThreadD1Ev>
    80002e6c:	00048513          	mv	a0,s1
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	bb0080e7          	jalr	-1104(ra) # 80002a20 <_ZN6ThreaddlEPv>
    80002e78:	01813083          	ld	ra,24(sp)
    80002e7c:	01013403          	ld	s0,16(sp)
    80002e80:	00813483          	ld	s1,8(sp)
    80002e84:	02010113          	addi	sp,sp,32
    80002e88:	00008067          	ret

0000000080002e8c <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00813423          	sd	s0,8(sp)
    80002e94:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002e98:	00005797          	auipc	a5,0x5
    80002e9c:	8807b783          	ld	a5,-1920(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002ea0:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80002ea4:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002ea8:	00853783          	ld	a5,8(a0)
    80002eac:	04078063          	beqz	a5,80002eec <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002eb0:	00005717          	auipc	a4,0x5
    80002eb4:	86873703          	ld	a4,-1944(a4) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002eb8:	00073703          	ld	a4,0(a4)
    80002ebc:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002ec0:	00853783          	ld	a5,8(a0)
        return nextInList;
    80002ec4:	0007b783          	ld	a5,0(a5)
    80002ec8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002ecc:	00005797          	auipc	a5,0x5
    80002ed0:	84c7b783          	ld	a5,-1972(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002ed4:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002ed8:	00100713          	li	a4,1
    80002edc:	02e784a3          	sb	a4,41(a5)
}
    80002ee0:	00813403          	ld	s0,8(sp)
    80002ee4:	01010113          	addi	sp,sp,16
    80002ee8:	00008067          	ret
        head = tail = PCB::running;
    80002eec:	00005797          	auipc	a5,0x5
    80002ef0:	82c7b783          	ld	a5,-2004(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002ef4:	0007b783          	ld	a5,0(a5)
    80002ef8:	00f53423          	sd	a5,8(a0)
    80002efc:	00f53023          	sd	a5,0(a0)
    80002f00:	fcdff06f          	j	80002ecc <_ZN3SCB5blockEv+0x40>

0000000080002f04 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00813423          	sd	s0,8(sp)
    80002f0c:	01010413          	addi	s0,sp,16
    80002f10:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80002f14:	00053503          	ld	a0,0(a0)
    80002f18:	00050e63          	beqz	a0,80002f34 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    80002f1c:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80002f20:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80002f24:	0087b683          	ld	a3,8(a5)
    80002f28:	00d50c63          	beq	a0,a3,80002f40 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80002f2c:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80002f30:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80002f34:	00813403          	ld	s0,8(sp)
    80002f38:	01010113          	addi	sp,sp,16
    80002f3c:	00008067          	ret
        tail = head;
    80002f40:	00e7b423          	sd	a4,8(a5)
    80002f44:	fe9ff06f          	j	80002f2c <_ZN3SCB7unblockEv+0x28>

0000000080002f48 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80002f48:	01052783          	lw	a5,16(a0)
    80002f4c:	fff7879b          	addiw	a5,a5,-1
    80002f50:	00f52823          	sw	a5,16(a0)
    80002f54:	02079713          	slli	a4,a5,0x20
    80002f58:	02074063          	bltz	a4,80002f78 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002f5c:	00004797          	auipc	a5,0x4
    80002f60:	7bc7b783          	ld	a5,1980(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002f64:	0007b783          	ld	a5,0(a5)
    80002f68:	02a7c783          	lbu	a5,42(a5)
    80002f6c:	06079463          	bnez	a5,80002fd4 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80002f70:	00000513          	li	a0,0
    80002f74:	00008067          	ret
int SCB::wait() {
    80002f78:	ff010113          	addi	sp,sp,-16
    80002f7c:	00113423          	sd	ra,8(sp)
    80002f80:	00813023          	sd	s0,0(sp)
    80002f84:	01010413          	addi	s0,sp,16
        block();
    80002f88:	00000097          	auipc	ra,0x0
    80002f8c:	f04080e7          	jalr	-252(ra) # 80002e8c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80002f90:	00004797          	auipc	a5,0x4
    80002f94:	7687b783          	ld	a5,1896(a5) # 800076f8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002f98:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80002f9c:	fffff097          	auipc	ra,0xfffff
    80002fa0:	b20080e7          	jalr	-1248(ra) # 80001abc <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002fa4:	00004797          	auipc	a5,0x4
    80002fa8:	7747b783          	ld	a5,1908(a5) # 80007718 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002fac:	0007b783          	ld	a5,0(a5)
    80002fb0:	02a7c783          	lbu	a5,42(a5)
    80002fb4:	00079c63          	bnez	a5,80002fcc <_ZN3SCB4waitEv+0x84>
    return 0;
    80002fb8:	00000513          	li	a0,0

}
    80002fbc:	00813083          	ld	ra,8(sp)
    80002fc0:	00013403          	ld	s0,0(sp)
    80002fc4:	01010113          	addi	sp,sp,16
    80002fc8:	00008067          	ret
        return -2;
    80002fcc:	ffe00513          	li	a0,-2
    80002fd0:	fedff06f          	j	80002fbc <_ZN3SCB4waitEv+0x74>
    80002fd4:	ffe00513          	li	a0,-2
}
    80002fd8:	00008067          	ret

0000000080002fdc <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    80002fdc:	01052783          	lw	a5,16(a0)
    80002fe0:	0017879b          	addiw	a5,a5,1
    80002fe4:	0007871b          	sext.w	a4,a5
    80002fe8:	00f52823          	sw	a5,16(a0)
    80002fec:	00e05463          	blez	a4,80002ff4 <_ZN3SCB6signalEv+0x18>
    80002ff0:	00008067          	ret
void SCB::signal() {
    80002ff4:	ff010113          	addi	sp,sp,-16
    80002ff8:	00113423          	sd	ra,8(sp)
    80002ffc:	00813023          	sd	s0,0(sp)
    80003000:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    80003004:	00000097          	auipc	ra,0x0
    80003008:	f00080e7          	jalr	-256(ra) # 80002f04 <_ZN3SCB7unblockEv>
    8000300c:	fffff097          	auipc	ra,0xfffff
    80003010:	5b0080e7          	jalr	1456(ra) # 800025bc <_ZN9Scheduler3putEP3PCB>
    }
}
    80003014:	00813083          	ld	ra,8(sp)
    80003018:	00013403          	ld	s0,0(sp)
    8000301c:	01010113          	addi	sp,sp,16
    80003020:	00008067          	ret

0000000080003024 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    80003024:	01052783          	lw	a5,16(a0)
    80003028:	0017879b          	addiw	a5,a5,1
    8000302c:	0007871b          	sext.w	a4,a5
    80003030:	00f52823          	sw	a5,16(a0)
    80003034:	00e05463          	blez	a4,8000303c <_ZN3SCB14prioritySignalEv+0x18>
    80003038:	00008067          	ret
void SCB::prioritySignal() {
    8000303c:	ff010113          	addi	sp,sp,-16
    80003040:	00113423          	sd	ra,8(sp)
    80003044:	00813023          	sd	s0,0(sp)
    80003048:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000304c:	00000097          	auipc	ra,0x0
    80003050:	eb8080e7          	jalr	-328(ra) # 80002f04 <_ZN3SCB7unblockEv>
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	614080e7          	jalr	1556(ra) # 80002668 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000305c:	00813083          	ld	ra,8(sp)
    80003060:	00013403          	ld	s0,0(sp)
    80003064:	01010113          	addi	sp,sp,16
    80003068:	00008067          	ret

000000008000306c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000306c:	ff010113          	addi	sp,sp,-16
    80003070:	00113423          	sd	ra,8(sp)
    80003074:	00813023          	sd	s0,0(sp)
    80003078:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000307c:	00000097          	auipc	ra,0x0
    80003080:	0a4080e7          	jalr	164(ra) # 80003120 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003084:	00813083          	ld	ra,8(sp)
    80003088:	00013403          	ld	s0,0(sp)
    8000308c:	01010113          	addi	sp,sp,16
    80003090:	00008067          	ret

0000000080003094 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80003094:	ff010113          	addi	sp,sp,-16
    80003098:	00113423          	sd	ra,8(sp)
    8000309c:	00813023          	sd	s0,0(sp)
    800030a0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800030a4:	00000097          	auipc	ra,0x0
    800030a8:	1e0080e7          	jalr	480(ra) # 80003284 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800030ac:	00813083          	ld	ra,8(sp)
    800030b0:	00013403          	ld	s0,0(sp)
    800030b4:	01010113          	addi	sp,sp,16
    800030b8:	00008067          	ret

00000000800030bc <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800030bc:	fe010113          	addi	sp,sp,-32
    800030c0:	00113c23          	sd	ra,24(sp)
    800030c4:	00813823          	sd	s0,16(sp)
    800030c8:	00913423          	sd	s1,8(sp)
    800030cc:	01213023          	sd	s2,0(sp)
    800030d0:	02010413          	addi	s0,sp,32
    800030d4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800030d8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800030dc:	02050263          	beqz	a0,80003100 <_ZN3SCB13signalClosingEv+0x44>
    }

    void setSemDeleted(bool newState) {
        semDeleted = newState;
    800030e0:	00100793          	li	a5,1
    800030e4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800030e8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800030ec:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800030f0:	fffff097          	auipc	ra,0xfffff
    800030f4:	4cc080e7          	jalr	1228(ra) # 800025bc <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800030f8:	00048513          	mv	a0,s1
    while(curr) {
    800030fc:	fe1ff06f          	j	800030dc <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80003100:	00093423          	sd	zero,8(s2)
    80003104:	00093023          	sd	zero,0(s2)
}
    80003108:	01813083          	ld	ra,24(sp)
    8000310c:	01013403          	ld	s0,16(sp)
    80003110:	00813483          	ld	s1,8(sp)
    80003114:	00013903          	ld	s2,0(sp)
    80003118:	02010113          	addi	sp,sp,32
    8000311c:	00008067          	ret

0000000080003120 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80003120:	ff010113          	addi	sp,sp,-16
    80003124:	00813423          	sd	s0,8(sp)
    80003128:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000312c:	00004797          	auipc	a5,0x4
    80003130:	6fc7b783          	ld	a5,1788(a5) # 80007828 <_ZN15MemoryAllocator4headE>
    80003134:	02078c63          	beqz	a5,8000316c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80003138:	00004717          	auipc	a4,0x4
    8000313c:	5e873703          	ld	a4,1512(a4) # 80007720 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003140:	00073703          	ld	a4,0(a4)
    80003144:	12e78c63          	beq	a5,a4,8000327c <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80003148:	00850713          	addi	a4,a0,8
    8000314c:	00675813          	srli	a6,a4,0x6
    80003150:	03f77793          	andi	a5,a4,63
    80003154:	00f037b3          	snez	a5,a5
    80003158:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000315c:	00004517          	auipc	a0,0x4
    80003160:	6cc53503          	ld	a0,1740(a0) # 80007828 <_ZN15MemoryAllocator4headE>
    80003164:	00000613          	li	a2,0
    80003168:	0a80006f          	j	80003210 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    8000316c:	00004697          	auipc	a3,0x4
    80003170:	56c6b683          	ld	a3,1388(a3) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003174:	0006b783          	ld	a5,0(a3)
    80003178:	00004717          	auipc	a4,0x4
    8000317c:	6af73823          	sd	a5,1712(a4) # 80007828 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80003180:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80003184:	00004717          	auipc	a4,0x4
    80003188:	59c73703          	ld	a4,1436(a4) # 80007720 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000318c:	00073703          	ld	a4,0(a4)
    80003190:	0006b683          	ld	a3,0(a3)
    80003194:	40d70733          	sub	a4,a4,a3
    80003198:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    8000319c:	0007b823          	sd	zero,16(a5)
    800031a0:	fa9ff06f          	j	80003148 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800031a4:	00060e63          	beqz	a2,800031c0 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800031a8:	01063703          	ld	a4,16(a2)
    800031ac:	04070a63          	beqz	a4,80003200 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800031b0:	01073703          	ld	a4,16(a4)
    800031b4:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800031b8:	00078813          	mv	a6,a5
    800031bc:	0ac0006f          	j	80003268 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800031c0:	01053703          	ld	a4,16(a0)
    800031c4:	00070a63          	beqz	a4,800031d8 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    800031c8:	00004697          	auipc	a3,0x4
    800031cc:	66e6b023          	sd	a4,1632(a3) # 80007828 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800031d0:	00078813          	mv	a6,a5
    800031d4:	0940006f          	j	80003268 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    800031d8:	00004717          	auipc	a4,0x4
    800031dc:	54873703          	ld	a4,1352(a4) # 80007720 <_GLOBAL_OFFSET_TABLE_+0x68>
    800031e0:	00073703          	ld	a4,0(a4)
    800031e4:	00004697          	auipc	a3,0x4
    800031e8:	64e6b223          	sd	a4,1604(a3) # 80007828 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800031ec:	00078813          	mv	a6,a5
    800031f0:	0780006f          	j	80003268 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    800031f4:	00004797          	auipc	a5,0x4
    800031f8:	62e7ba23          	sd	a4,1588(a5) # 80007828 <_ZN15MemoryAllocator4headE>
    800031fc:	06c0006f          	j	80003268 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80003200:	00078813          	mv	a6,a5
    80003204:	0640006f          	j	80003268 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80003208:	00050613          	mv	a2,a0
        curr = curr->next;
    8000320c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80003210:	06050063          	beqz	a0,80003270 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80003214:	00853783          	ld	a5,8(a0)
    80003218:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    8000321c:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80003220:	fee7e4e3          	bltu	a5,a4,80003208 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80003224:	ff06e2e3          	bltu	a3,a6,80003208 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80003228:	f7068ee3          	beq	a3,a6,800031a4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    8000322c:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80003230:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80003234:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80003238:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    8000323c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80003240:	01053783          	ld	a5,16(a0)
    80003244:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80003248:	fa0606e3          	beqz	a2,800031f4 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    8000324c:	01063783          	ld	a5,16(a2)
    80003250:	00078663          	beqz	a5,8000325c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80003254:	0107b783          	ld	a5,16(a5)
    80003258:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    8000325c:	01063783          	ld	a5,16(a2)
    80003260:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80003264:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80003268:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    8000326c:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80003270:	00813403          	ld	s0,8(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret
        return nullptr;
    8000327c:	00000513          	li	a0,0
    80003280:	ff1ff06f          	j	80003270 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080003284 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80003284:	ff010113          	addi	sp,sp,-16
    80003288:	00813423          	sd	s0,8(sp)
    8000328c:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80003290:	16050063          	beqz	a0,800033f0 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80003294:	ff850713          	addi	a4,a0,-8
    80003298:	00004797          	auipc	a5,0x4
    8000329c:	4407b783          	ld	a5,1088(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    800032a0:	0007b783          	ld	a5,0(a5)
    800032a4:	14f76a63          	bltu	a4,a5,800033f8 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800032a8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800032ac:	fff58693          	addi	a3,a1,-1
    800032b0:	00d706b3          	add	a3,a4,a3
    800032b4:	00004617          	auipc	a2,0x4
    800032b8:	46c63603          	ld	a2,1132(a2) # 80007720 <_GLOBAL_OFFSET_TABLE_+0x68>
    800032bc:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800032c0:	14c6f063          	bgeu	a3,a2,80003400 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800032c4:	14070263          	beqz	a4,80003408 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    800032c8:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800032cc:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800032d0:	14079063          	bnez	a5,80003410 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    800032d4:	03f00793          	li	a5,63
    800032d8:	14b7f063          	bgeu	a5,a1,80003418 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    800032dc:	00004797          	auipc	a5,0x4
    800032e0:	54c7b783          	ld	a5,1356(a5) # 80007828 <_ZN15MemoryAllocator4headE>
    800032e4:	02f60063          	beq	a2,a5,80003304 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800032e8:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800032ec:	02078a63          	beqz	a5,80003320 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    800032f0:	0007b683          	ld	a3,0(a5)
    800032f4:	02e6f663          	bgeu	a3,a4,80003320 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    800032f8:	00078613          	mv	a2,a5
        curr = curr->next;
    800032fc:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80003300:	fedff06f          	j	800032ec <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80003304:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80003308:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    8000330c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80003310:	00004797          	auipc	a5,0x4
    80003314:	50e7bc23          	sd	a4,1304(a5) # 80007828 <_ZN15MemoryAllocator4headE>
        return 0;
    80003318:	00000513          	li	a0,0
    8000331c:	0480006f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80003320:	04060863          	beqz	a2,80003370 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003324:	00063683          	ld	a3,0(a2)
    80003328:	00863803          	ld	a6,8(a2)
    8000332c:	010686b3          	add	a3,a3,a6
    80003330:	08e68a63          	beq	a3,a4,800033c4 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003334:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003338:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000333c:	01063683          	ld	a3,16(a2)
    80003340:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003344:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80003348:	0e078063          	beqz	a5,80003428 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000334c:	0007b583          	ld	a1,0(a5)
    80003350:	00073683          	ld	a3,0(a4)
    80003354:	00873603          	ld	a2,8(a4)
    80003358:	00c686b3          	add	a3,a3,a2
    8000335c:	06d58c63          	beq	a1,a3,800033d4 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80003360:	00000513          	li	a0,0
}
    80003364:	00813403          	ld	s0,8(sp)
    80003368:	01010113          	addi	sp,sp,16
    8000336c:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80003370:	0a078863          	beqz	a5,80003420 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80003374:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003378:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    8000337c:	00004797          	auipc	a5,0x4
    80003380:	4ac7b783          	ld	a5,1196(a5) # 80007828 <_ZN15MemoryAllocator4headE>
    80003384:	0007b603          	ld	a2,0(a5)
    80003388:	00b706b3          	add	a3,a4,a1
    8000338c:	00d60c63          	beq	a2,a3,800033a4 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80003390:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80003394:	00004797          	auipc	a5,0x4
    80003398:	48e7ba23          	sd	a4,1172(a5) # 80007828 <_ZN15MemoryAllocator4headE>
            return 0;
    8000339c:	00000513          	li	a0,0
    800033a0:	fc5ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800033a4:	0087b783          	ld	a5,8(a5)
    800033a8:	00b785b3          	add	a1,a5,a1
    800033ac:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800033b0:	00004797          	auipc	a5,0x4
    800033b4:	4787b783          	ld	a5,1144(a5) # 80007828 <_ZN15MemoryAllocator4headE>
    800033b8:	0107b783          	ld	a5,16(a5)
    800033bc:	00f53423          	sd	a5,8(a0)
    800033c0:	fd5ff06f          	j	80003394 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800033c4:	00b805b3          	add	a1,a6,a1
    800033c8:	00b63423          	sd	a1,8(a2)
    800033cc:	00060713          	mv	a4,a2
    800033d0:	f79ff06f          	j	80003348 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800033d4:	0087b683          	ld	a3,8(a5)
    800033d8:	00d60633          	add	a2,a2,a3
    800033dc:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800033e0:	0107b783          	ld	a5,16(a5)
    800033e4:	00f73823          	sd	a5,16(a4)
    return 0;
    800033e8:	00000513          	li	a0,0
    800033ec:	f79ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800033f0:	fff00513          	li	a0,-1
    800033f4:	f71ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800033f8:	fff00513          	li	a0,-1
    800033fc:	f69ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80003400:	fff00513          	li	a0,-1
    80003404:	f61ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003408:	fff00513          	li	a0,-1
    8000340c:	f59ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003410:	fff00513          	li	a0,-1
    80003414:	f51ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003418:	fff00513          	li	a0,-1
    8000341c:	f49ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80003420:	fff00513          	li	a0,-1
    80003424:	f41ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80003428:	00000513          	li	a0,0
    8000342c:	f39ff06f          	j	80003364 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080003430 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003430:	fe010113          	addi	sp,sp,-32
    80003434:	00113c23          	sd	ra,24(sp)
    80003438:	00813823          	sd	s0,16(sp)
    8000343c:	00913423          	sd	s1,8(sp)
    80003440:	02010413          	addi	s0,sp,32
    80003444:	00050493          	mv	s1,a0
    LOCK();
    80003448:	00100613          	li	a2,1
    8000344c:	00000593          	li	a1,0
    80003450:	00004517          	auipc	a0,0x4
    80003454:	3e050513          	addi	a0,a0,992 # 80007830 <lockPrint>
    80003458:	ffffe097          	auipc	ra,0xffffe
    8000345c:	cf8080e7          	jalr	-776(ra) # 80001150 <copy_and_swap>
    80003460:	fe0514e3          	bnez	a0,80003448 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003464:	0004c503          	lbu	a0,0(s1)
    80003468:	00050a63          	beqz	a0,8000347c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000346c:	ffffe097          	auipc	ra,0xffffe
    80003470:	06c080e7          	jalr	108(ra) # 800014d8 <_Z4putcc>
        string++;
    80003474:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003478:	fedff06f          	j	80003464 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000347c:	00000613          	li	a2,0
    80003480:	00100593          	li	a1,1
    80003484:	00004517          	auipc	a0,0x4
    80003488:	3ac50513          	addi	a0,a0,940 # 80007830 <lockPrint>
    8000348c:	ffffe097          	auipc	ra,0xffffe
    80003490:	cc4080e7          	jalr	-828(ra) # 80001150 <copy_and_swap>
    80003494:	fe0514e3          	bnez	a0,8000347c <_Z11printStringPKc+0x4c>
}
    80003498:	01813083          	ld	ra,24(sp)
    8000349c:	01013403          	ld	s0,16(sp)
    800034a0:	00813483          	ld	s1,8(sp)
    800034a4:	02010113          	addi	sp,sp,32
    800034a8:	00008067          	ret

00000000800034ac <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800034ac:	fd010113          	addi	sp,sp,-48
    800034b0:	02113423          	sd	ra,40(sp)
    800034b4:	02813023          	sd	s0,32(sp)
    800034b8:	00913c23          	sd	s1,24(sp)
    800034bc:	01213823          	sd	s2,16(sp)
    800034c0:	01313423          	sd	s3,8(sp)
    800034c4:	01413023          	sd	s4,0(sp)
    800034c8:	03010413          	addi	s0,sp,48
    800034cc:	00050993          	mv	s3,a0
    800034d0:	00058a13          	mv	s4,a1
    LOCK();
    800034d4:	00100613          	li	a2,1
    800034d8:	00000593          	li	a1,0
    800034dc:	00004517          	auipc	a0,0x4
    800034e0:	35450513          	addi	a0,a0,852 # 80007830 <lockPrint>
    800034e4:	ffffe097          	auipc	ra,0xffffe
    800034e8:	c6c080e7          	jalr	-916(ra) # 80001150 <copy_and_swap>
    800034ec:	fe0514e3          	bnez	a0,800034d4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800034f0:	00000913          	li	s2,0
    800034f4:	00090493          	mv	s1,s2
    800034f8:	0019091b          	addiw	s2,s2,1
    800034fc:	03495a63          	bge	s2,s4,80003530 <_Z9getStringPci+0x84>
        cc = getc();
    80003500:	ffffe097          	auipc	ra,0xffffe
    80003504:	fa8080e7          	jalr	-88(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80003508:	02050463          	beqz	a0,80003530 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000350c:	009984b3          	add	s1,s3,s1
    80003510:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003514:	00a00793          	li	a5,10
    80003518:	00f50a63          	beq	a0,a5,8000352c <_Z9getStringPci+0x80>
    8000351c:	00d00793          	li	a5,13
    80003520:	fcf51ae3          	bne	a0,a5,800034f4 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80003524:	00090493          	mv	s1,s2
    80003528:	0080006f          	j	80003530 <_Z9getStringPci+0x84>
    8000352c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003530:	009984b3          	add	s1,s3,s1
    80003534:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003538:	00000613          	li	a2,0
    8000353c:	00100593          	li	a1,1
    80003540:	00004517          	auipc	a0,0x4
    80003544:	2f050513          	addi	a0,a0,752 # 80007830 <lockPrint>
    80003548:	ffffe097          	auipc	ra,0xffffe
    8000354c:	c08080e7          	jalr	-1016(ra) # 80001150 <copy_and_swap>
    80003550:	fe0514e3          	bnez	a0,80003538 <_Z9getStringPci+0x8c>
    return buf;
}
    80003554:	00098513          	mv	a0,s3
    80003558:	02813083          	ld	ra,40(sp)
    8000355c:	02013403          	ld	s0,32(sp)
    80003560:	01813483          	ld	s1,24(sp)
    80003564:	01013903          	ld	s2,16(sp)
    80003568:	00813983          	ld	s3,8(sp)
    8000356c:	00013a03          	ld	s4,0(sp)
    80003570:	03010113          	addi	sp,sp,48
    80003574:	00008067          	ret

0000000080003578 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003578:	ff010113          	addi	sp,sp,-16
    8000357c:	00813423          	sd	s0,8(sp)
    80003580:	01010413          	addi	s0,sp,16
    80003584:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003588:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000358c:	0006c603          	lbu	a2,0(a3)
    80003590:	fd06071b          	addiw	a4,a2,-48
    80003594:	0ff77713          	andi	a4,a4,255
    80003598:	00900793          	li	a5,9
    8000359c:	02e7e063          	bltu	a5,a4,800035bc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800035a0:	0025179b          	slliw	a5,a0,0x2
    800035a4:	00a787bb          	addw	a5,a5,a0
    800035a8:	0017979b          	slliw	a5,a5,0x1
    800035ac:	00168693          	addi	a3,a3,1
    800035b0:	00c787bb          	addw	a5,a5,a2
    800035b4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800035b8:	fd5ff06f          	j	8000358c <_Z11stringToIntPKc+0x14>
    return n;
}
    800035bc:	00813403          	ld	s0,8(sp)
    800035c0:	01010113          	addi	sp,sp,16
    800035c4:	00008067          	ret

00000000800035c8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800035c8:	fc010113          	addi	sp,sp,-64
    800035cc:	02113c23          	sd	ra,56(sp)
    800035d0:	02813823          	sd	s0,48(sp)
    800035d4:	02913423          	sd	s1,40(sp)
    800035d8:	03213023          	sd	s2,32(sp)
    800035dc:	01313c23          	sd	s3,24(sp)
    800035e0:	04010413          	addi	s0,sp,64
    800035e4:	00050493          	mv	s1,a0
    800035e8:	00058913          	mv	s2,a1
    800035ec:	00060993          	mv	s3,a2
    LOCK();
    800035f0:	00100613          	li	a2,1
    800035f4:	00000593          	li	a1,0
    800035f8:	00004517          	auipc	a0,0x4
    800035fc:	23850513          	addi	a0,a0,568 # 80007830 <lockPrint>
    80003600:	ffffe097          	auipc	ra,0xffffe
    80003604:	b50080e7          	jalr	-1200(ra) # 80001150 <copy_and_swap>
    80003608:	fe0514e3          	bnez	a0,800035f0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000360c:	00098463          	beqz	s3,80003614 <_Z8printIntiii+0x4c>
    80003610:	0804c463          	bltz	s1,80003698 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003614:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003618:	00000593          	li	a1,0
    }

    i = 0;
    8000361c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003620:	0009079b          	sext.w	a5,s2
    80003624:	0325773b          	remuw	a4,a0,s2
    80003628:	00048613          	mv	a2,s1
    8000362c:	0014849b          	addiw	s1,s1,1
    80003630:	02071693          	slli	a3,a4,0x20
    80003634:	0206d693          	srli	a3,a3,0x20
    80003638:	00004717          	auipc	a4,0x4
    8000363c:	06870713          	addi	a4,a4,104 # 800076a0 <digits>
    80003640:	00d70733          	add	a4,a4,a3
    80003644:	00074683          	lbu	a3,0(a4)
    80003648:	fd040713          	addi	a4,s0,-48
    8000364c:	00c70733          	add	a4,a4,a2
    80003650:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003654:	0005071b          	sext.w	a4,a0
    80003658:	0325553b          	divuw	a0,a0,s2
    8000365c:	fcf772e3          	bgeu	a4,a5,80003620 <_Z8printIntiii+0x58>
    if(neg)
    80003660:	00058c63          	beqz	a1,80003678 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80003664:	fd040793          	addi	a5,s0,-48
    80003668:	009784b3          	add	s1,a5,s1
    8000366c:	02d00793          	li	a5,45
    80003670:	fef48823          	sb	a5,-16(s1)
    80003674:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003678:	fff4849b          	addiw	s1,s1,-1
    8000367c:	0204c463          	bltz	s1,800036a4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80003680:	fd040793          	addi	a5,s0,-48
    80003684:	009787b3          	add	a5,a5,s1
    80003688:	ff07c503          	lbu	a0,-16(a5)
    8000368c:	ffffe097          	auipc	ra,0xffffe
    80003690:	e4c080e7          	jalr	-436(ra) # 800014d8 <_Z4putcc>
    80003694:	fe5ff06f          	j	80003678 <_Z8printIntiii+0xb0>
        x = -xx;
    80003698:	4090053b          	negw	a0,s1
        neg = 1;
    8000369c:	00100593          	li	a1,1
        x = -xx;
    800036a0:	f7dff06f          	j	8000361c <_Z8printIntiii+0x54>

    UNLOCK();
    800036a4:	00000613          	li	a2,0
    800036a8:	00100593          	li	a1,1
    800036ac:	00004517          	auipc	a0,0x4
    800036b0:	18450513          	addi	a0,a0,388 # 80007830 <lockPrint>
    800036b4:	ffffe097          	auipc	ra,0xffffe
    800036b8:	a9c080e7          	jalr	-1380(ra) # 80001150 <copy_and_swap>
    800036bc:	fe0514e3          	bnez	a0,800036a4 <_Z8printIntiii+0xdc>
}
    800036c0:	03813083          	ld	ra,56(sp)
    800036c4:	03013403          	ld	s0,48(sp)
    800036c8:	02813483          	ld	s1,40(sp)
    800036cc:	02013903          	ld	s2,32(sp)
    800036d0:	01813983          	ld	s3,24(sp)
    800036d4:	04010113          	addi	sp,sp,64
    800036d8:	00008067          	ret

00000000800036dc <_Z10printErrorv>:
void printError() {
    800036dc:	fd010113          	addi	sp,sp,-48
    800036e0:	02113423          	sd	ra,40(sp)
    800036e4:	02813023          	sd	s0,32(sp)
    800036e8:	03010413          	addi	s0,sp,48
    LOCK();
    800036ec:	00100613          	li	a2,1
    800036f0:	00000593          	li	a1,0
    800036f4:	00004517          	auipc	a0,0x4
    800036f8:	13c50513          	addi	a0,a0,316 # 80007830 <lockPrint>
    800036fc:	ffffe097          	auipc	ra,0xffffe
    80003700:	a54080e7          	jalr	-1452(ra) # 80001150 <copy_and_swap>
    80003704:	fe0514e3          	bnez	a0,800036ec <_Z10printErrorv+0x10>
    printString("scause: ");
    80003708:	00003517          	auipc	a0,0x3
    8000370c:	b2050513          	addi	a0,a0,-1248 # 80006228 <CONSOLE_STATUS+0x218>
    80003710:	00000097          	auipc	ra,0x0
    80003714:	d20080e7          	jalr	-736(ra) # 80003430 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003718:	142027f3          	csrr	a5,scause
    8000371c:	fef43423          	sd	a5,-24(s0)
        return scause;
    80003720:	fe843503          	ld	a0,-24(s0)
    printInt(Kernel::r_scause());
    80003724:	00000613          	li	a2,0
    80003728:	00a00593          	li	a1,10
    8000372c:	0005051b          	sext.w	a0,a0
    80003730:	00000097          	auipc	ra,0x0
    80003734:	e98080e7          	jalr	-360(ra) # 800035c8 <_Z8printIntiii>
    printString("\nsepc: ");
    80003738:	00003517          	auipc	a0,0x3
    8000373c:	b0050513          	addi	a0,a0,-1280 # 80006238 <CONSOLE_STATUS+0x228>
    80003740:	00000097          	auipc	ra,0x0
    80003744:	cf0080e7          	jalr	-784(ra) # 80003430 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003748:	141027f3          	csrr	a5,sepc
    8000374c:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80003750:	fe043503          	ld	a0,-32(s0)
    printInt(Kernel::r_sepc());
    80003754:	00000613          	li	a2,0
    80003758:	00a00593          	li	a1,10
    8000375c:	0005051b          	sext.w	a0,a0
    80003760:	00000097          	auipc	ra,0x0
    80003764:	e68080e7          	jalr	-408(ra) # 800035c8 <_Z8printIntiii>
    printString("\nstval: ");
    80003768:	00003517          	auipc	a0,0x3
    8000376c:	ad850513          	addi	a0,a0,-1320 # 80006240 <CONSOLE_STATUS+0x230>
    80003770:	00000097          	auipc	ra,0x0
    80003774:	cc0080e7          	jalr	-832(ra) # 80003430 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80003778:	143027f3          	csrr	a5,stval
    8000377c:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    80003780:	fd843503          	ld	a0,-40(s0)
    printInt(Kernel::r_stval());
    80003784:	00000613          	li	a2,0
    80003788:	00a00593          	li	a1,10
    8000378c:	0005051b          	sext.w	a0,a0
    80003790:	00000097          	auipc	ra,0x0
    80003794:	e38080e7          	jalr	-456(ra) # 800035c8 <_Z8printIntiii>
    UNLOCK();
    80003798:	00000613          	li	a2,0
    8000379c:	00100593          	li	a1,1
    800037a0:	00004517          	auipc	a0,0x4
    800037a4:	09050513          	addi	a0,a0,144 # 80007830 <lockPrint>
    800037a8:	ffffe097          	auipc	ra,0xffffe
    800037ac:	9a8080e7          	jalr	-1624(ra) # 80001150 <copy_and_swap>
    800037b0:	fe0514e3          	bnez	a0,80003798 <_Z10printErrorv+0xbc>
    800037b4:	02813083          	ld	ra,40(sp)
    800037b8:	02013403          	ld	s0,32(sp)
    800037bc:	03010113          	addi	sp,sp,48
    800037c0:	00008067          	ret

00000000800037c4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap), head(0), tail(0) {
    800037c4:	fe010113          	addi	sp,sp,-32
    800037c8:	00113c23          	sd	ra,24(sp)
    800037cc:	00813823          	sd	s0,16(sp)
    800037d0:	00913423          	sd	s1,8(sp)
    800037d4:	01213023          	sd	s2,0(sp)
    800037d8:	02010413          	addi	s0,sp,32
    800037dc:	00050493          	mv	s1,a0
    800037e0:	00b52023          	sw	a1,0(a0)
    800037e4:	00052823          	sw	zero,16(a0)
    800037e8:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800037ec:	00259513          	slli	a0,a1,0x2
    800037f0:	ffffe097          	auipc	ra,0xffffe
    800037f4:	9a4080e7          	jalr	-1628(ra) # 80001194 <_Z9mem_allocm>
    800037f8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800037fc:	01000513          	li	a0,16
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	4e8080e7          	jalr	1256(ra) # 80002ce8 <_ZN9SemaphorenwEm>
    80003808:	00050913          	mv	s2,a0
    8000380c:	00000593          	li	a1,0
    80003810:	fffff097          	auipc	ra,0xfffff
    80003814:	3b8080e7          	jalr	952(ra) # 80002bc8 <_ZN9SemaphoreC1Ej>
    80003818:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(cap);
    8000381c:	01000513          	li	a0,16
    80003820:	fffff097          	auipc	ra,0xfffff
    80003824:	4c8080e7          	jalr	1224(ra) # 80002ce8 <_ZN9SemaphorenwEm>
    80003828:	00050913          	mv	s2,a0
    8000382c:	0004a583          	lw	a1,0(s1)
    80003830:	fffff097          	auipc	ra,0xfffff
    80003834:	398080e7          	jalr	920(ra) # 80002bc8 <_ZN9SemaphoreC1Ej>
    80003838:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000383c:	01000513          	li	a0,16
    80003840:	fffff097          	auipc	ra,0xfffff
    80003844:	4a8080e7          	jalr	1192(ra) # 80002ce8 <_ZN9SemaphorenwEm>
    80003848:	00050913          	mv	s2,a0
    8000384c:	00100593          	li	a1,1
    80003850:	fffff097          	auipc	ra,0xfffff
    80003854:	378080e7          	jalr	888(ra) # 80002bc8 <_ZN9SemaphoreC1Ej>
    80003858:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000385c:	01000513          	li	a0,16
    80003860:	fffff097          	auipc	ra,0xfffff
    80003864:	488080e7          	jalr	1160(ra) # 80002ce8 <_ZN9SemaphorenwEm>
    80003868:	00050913          	mv	s2,a0
    8000386c:	00100593          	li	a1,1
    80003870:	fffff097          	auipc	ra,0xfffff
    80003874:	358080e7          	jalr	856(ra) # 80002bc8 <_ZN9SemaphoreC1Ej>
    80003878:	0324b823          	sd	s2,48(s1)
}
    8000387c:	01813083          	ld	ra,24(sp)
    80003880:	01013403          	ld	s0,16(sp)
    80003884:	00813483          	ld	s1,8(sp)
    80003888:	00013903          	ld	s2,0(sp)
    8000388c:	02010113          	addi	sp,sp,32
    80003890:	00008067          	ret
    80003894:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80003898:	00090513          	mv	a0,s2
    8000389c:	fffff097          	auipc	ra,0xfffff
    800038a0:	3e4080e7          	jalr	996(ra) # 80002c80 <_ZN9SemaphoredlEPv>
    800038a4:	00048513          	mv	a0,s1
    800038a8:	00005097          	auipc	ra,0x5
    800038ac:	060080e7          	jalr	96(ra) # 80008908 <_Unwind_Resume>
    800038b0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(cap);
    800038b4:	00090513          	mv	a0,s2
    800038b8:	fffff097          	auipc	ra,0xfffff
    800038bc:	3c8080e7          	jalr	968(ra) # 80002c80 <_ZN9SemaphoredlEPv>
    800038c0:	00048513          	mv	a0,s1
    800038c4:	00005097          	auipc	ra,0x5
    800038c8:	044080e7          	jalr	68(ra) # 80008908 <_Unwind_Resume>
    800038cc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800038d0:	00090513          	mv	a0,s2
    800038d4:	fffff097          	auipc	ra,0xfffff
    800038d8:	3ac080e7          	jalr	940(ra) # 80002c80 <_ZN9SemaphoredlEPv>
    800038dc:	00048513          	mv	a0,s1
    800038e0:	00005097          	auipc	ra,0x5
    800038e4:	028080e7          	jalr	40(ra) # 80008908 <_Unwind_Resume>
    800038e8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800038ec:	00090513          	mv	a0,s2
    800038f0:	fffff097          	auipc	ra,0xfffff
    800038f4:	390080e7          	jalr	912(ra) # 80002c80 <_ZN9SemaphoredlEPv>
    800038f8:	00048513          	mv	a0,s1
    800038fc:	00005097          	auipc	ra,0x5
    80003900:	00c080e7          	jalr	12(ra) # 80008908 <_Unwind_Resume>

0000000080003904 <_ZN9BufferCPPD1Ev>:

BufferCPP::~BufferCPP() {
    80003904:	fe010113          	addi	sp,sp,-32
    80003908:	00113c23          	sd	ra,24(sp)
    8000390c:	00813823          	sd	s0,16(sp)
    80003910:	00913423          	sd	s1,8(sp)
    80003914:	02010413          	addi	s0,sp,32
    80003918:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000391c:	00a00513          	li	a0,10
    80003920:	fffff097          	auipc	ra,0xfffff
    80003924:	494080e7          	jalr	1172(ra) # 80002db4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003928:	00003517          	auipc	a0,0x3
    8000392c:	92850513          	addi	a0,a0,-1752 # 80006250 <CONSOLE_STATUS+0x240>
    80003930:	00000097          	auipc	ra,0x0
    80003934:	b00080e7          	jalr	-1280(ra) # 80003430 <_Z11printStringPKc>
    while (head != tail) {
    80003938:	0104a783          	lw	a5,16(s1)
    8000393c:	0144a703          	lw	a4,20(s1)
    80003940:	02e78a63          	beq	a5,a4,80003974 <_ZN9BufferCPPD1Ev+0x70>
        char ch = buffer[head];
    80003944:	0084b703          	ld	a4,8(s1)
    80003948:	00279793          	slli	a5,a5,0x2
    8000394c:	00f707b3          	add	a5,a4,a5
        Console::putc(ch);
    80003950:	0007c503          	lbu	a0,0(a5)
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	460080e7          	jalr	1120(ra) # 80002db4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000395c:	0104a783          	lw	a5,16(s1)
    80003960:	0017879b          	addiw	a5,a5,1
    80003964:	0004a703          	lw	a4,0(s1)
    80003968:	02e7e7bb          	remw	a5,a5,a4
    8000396c:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003970:	fc9ff06f          	j	80003938 <_ZN9BufferCPPD1Ev+0x34>
    }
    Console::putc('!');
    80003974:	02100513          	li	a0,33
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	43c080e7          	jalr	1084(ra) # 80002db4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80003980:	00a00513          	li	a0,10
    80003984:	fffff097          	auipc	ra,0xfffff
    80003988:	430080e7          	jalr	1072(ra) # 80002db4 <_ZN7Console4putcEc>

    mem_free(buffer);
    8000398c:	0084b503          	ld	a0,8(s1)
    80003990:	ffffe097          	auipc	ra,0xffffe
    80003994:	844080e7          	jalr	-1980(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80003998:	0204b503          	ld	a0,32(s1)
    8000399c:	00050863          	beqz	a0,800039ac <_ZN9BufferCPPD1Ev+0xa8>
    800039a0:	00053783          	ld	a5,0(a0)
    800039a4:	0087b783          	ld	a5,8(a5)
    800039a8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800039ac:	0184b503          	ld	a0,24(s1)
    800039b0:	00050863          	beqz	a0,800039c0 <_ZN9BufferCPPD1Ev+0xbc>
    800039b4:	00053783          	ld	a5,0(a0)
    800039b8:	0087b783          	ld	a5,8(a5)
    800039bc:	000780e7          	jalr	a5
    delete mutexTail;
    800039c0:	0304b503          	ld	a0,48(s1)
    800039c4:	00050863          	beqz	a0,800039d4 <_ZN9BufferCPPD1Ev+0xd0>
    800039c8:	00053783          	ld	a5,0(a0)
    800039cc:	0087b783          	ld	a5,8(a5)
    800039d0:	000780e7          	jalr	a5
    delete mutexHead;
    800039d4:	0284b503          	ld	a0,40(s1)
    800039d8:	00050863          	beqz	a0,800039e8 <_ZN9BufferCPPD1Ev+0xe4>
    800039dc:	00053783          	ld	a5,0(a0)
    800039e0:	0087b783          	ld	a5,8(a5)
    800039e4:	000780e7          	jalr	a5

}
    800039e8:	01813083          	ld	ra,24(sp)
    800039ec:	01013403          	ld	s0,16(sp)
    800039f0:	00813483          	ld	s1,8(sp)
    800039f4:	02010113          	addi	sp,sp,32
    800039f8:	00008067          	ret

00000000800039fc <_ZN9BufferCPP3putEi>:

void BufferCPP::put(int val) {
    800039fc:	fe010113          	addi	sp,sp,-32
    80003a00:	00113c23          	sd	ra,24(sp)
    80003a04:	00813823          	sd	s0,16(sp)
    80003a08:	00913423          	sd	s1,8(sp)
    80003a0c:	01213023          	sd	s2,0(sp)
    80003a10:	02010413          	addi	s0,sp,32
    80003a14:	00050493          	mv	s1,a0
    80003a18:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003a1c:	01853503          	ld	a0,24(a0)
    80003a20:	fffff097          	auipc	ra,0xfffff
    80003a24:	208080e7          	jalr	520(ra) # 80002c28 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003a28:	0304b503          	ld	a0,48(s1)
    80003a2c:	fffff097          	auipc	ra,0xfffff
    80003a30:	1fc080e7          	jalr	508(ra) # 80002c28 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003a34:	0084b783          	ld	a5,8(s1)
    80003a38:	0144a703          	lw	a4,20(s1)
    80003a3c:	00271713          	slli	a4,a4,0x2
    80003a40:	00e787b3          	add	a5,a5,a4
    80003a44:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003a48:	0144a783          	lw	a5,20(s1)
    80003a4c:	0017879b          	addiw	a5,a5,1
    80003a50:	0004a703          	lw	a4,0(s1)
    80003a54:	02e7e7bb          	remw	a5,a5,a4
    80003a58:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80003a5c:	0304b503          	ld	a0,48(s1)
    80003a60:	fffff097          	auipc	ra,0xfffff
    80003a64:	1f4080e7          	jalr	500(ra) # 80002c54 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80003a68:	0204b503          	ld	a0,32(s1)
    80003a6c:	fffff097          	auipc	ra,0xfffff
    80003a70:	1e8080e7          	jalr	488(ra) # 80002c54 <_ZN9Semaphore6signalEv>

}
    80003a74:	01813083          	ld	ra,24(sp)
    80003a78:	01013403          	ld	s0,16(sp)
    80003a7c:	00813483          	ld	s1,8(sp)
    80003a80:	00013903          	ld	s2,0(sp)
    80003a84:	02010113          	addi	sp,sp,32
    80003a88:	00008067          	ret

0000000080003a8c <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003a8c:	fe010113          	addi	sp,sp,-32
    80003a90:	00113c23          	sd	ra,24(sp)
    80003a94:	00813823          	sd	s0,16(sp)
    80003a98:	00913423          	sd	s1,8(sp)
    80003a9c:	01213023          	sd	s2,0(sp)
    80003aa0:	02010413          	addi	s0,sp,32
    80003aa4:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003aa8:	02053503          	ld	a0,32(a0)
    80003aac:	fffff097          	auipc	ra,0xfffff
    80003ab0:	17c080e7          	jalr	380(ra) # 80002c28 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003ab4:	0284b503          	ld	a0,40(s1)
    80003ab8:	fffff097          	auipc	ra,0xfffff
    80003abc:	170080e7          	jalr	368(ra) # 80002c28 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80003ac0:	0084b703          	ld	a4,8(s1)
    80003ac4:	0104a783          	lw	a5,16(s1)
    80003ac8:	00279693          	slli	a3,a5,0x2
    80003acc:	00d70733          	add	a4,a4,a3
    80003ad0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003ad4:	0017879b          	addiw	a5,a5,1
    80003ad8:	0004a703          	lw	a4,0(s1)
    80003adc:	02e7e7bb          	remw	a5,a5,a4
    80003ae0:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003ae4:	0284b503          	ld	a0,40(s1)
    80003ae8:	fffff097          	auipc	ra,0xfffff
    80003aec:	16c080e7          	jalr	364(ra) # 80002c54 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80003af0:	0184b503          	ld	a0,24(s1)
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	160080e7          	jalr	352(ra) # 80002c54 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003afc:	00090513          	mv	a0,s2
    80003b00:	01813083          	ld	ra,24(sp)
    80003b04:	01013403          	ld	s0,16(sp)
    80003b08:	00813483          	ld	s1,8(sp)
    80003b0c:	00013903          	ld	s2,0(sp)
    80003b10:	02010113          	addi	sp,sp,32
    80003b14:	00008067          	ret

0000000080003b18 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap), head(0), tail(0) {
    80003b18:	fe010113          	addi	sp,sp,-32
    80003b1c:	00113c23          	sd	ra,24(sp)
    80003b20:	00813823          	sd	s0,16(sp)
    80003b24:	00913423          	sd	s1,8(sp)
    80003b28:	02010413          	addi	s0,sp,32
    80003b2c:	00050493          	mv	s1,a0
    80003b30:	00b52023          	sw	a1,0(a0)
    80003b34:	00052823          	sw	zero,16(a0)
    80003b38:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003b3c:	00259513          	slli	a0,a1,0x2
    80003b40:	ffffd097          	auipc	ra,0xffffd
    80003b44:	654080e7          	jalr	1620(ra) # 80001194 <_Z9mem_allocm>
    80003b48:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003b4c:	00000593          	li	a1,0
    80003b50:	02048513          	addi	a0,s1,32
    80003b54:	ffffd097          	auipc	ra,0xffffd
    80003b58:	7fc080e7          	jalr	2044(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, cap);
    80003b5c:	0004a583          	lw	a1,0(s1)
    80003b60:	01848513          	addi	a0,s1,24
    80003b64:	ffffd097          	auipc	ra,0xffffd
    80003b68:	7ec080e7          	jalr	2028(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003b6c:	00100593          	li	a1,1
    80003b70:	02848513          	addi	a0,s1,40
    80003b74:	ffffd097          	auipc	ra,0xffffd
    80003b78:	7dc080e7          	jalr	2012(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003b7c:	00100593          	li	a1,1
    80003b80:	03048513          	addi	a0,s1,48
    80003b84:	ffffd097          	auipc	ra,0xffffd
    80003b88:	7cc080e7          	jalr	1996(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003b8c:	01813083          	ld	ra,24(sp)
    80003b90:	01013403          	ld	s0,16(sp)
    80003b94:	00813483          	ld	s1,8(sp)
    80003b98:	02010113          	addi	sp,sp,32
    80003b9c:	00008067          	ret

0000000080003ba0 <_ZN6BufferD1Ev>:

Buffer::~Buffer() {
    80003ba0:	fe010113          	addi	sp,sp,-32
    80003ba4:	00113c23          	sd	ra,24(sp)
    80003ba8:	00813823          	sd	s0,16(sp)
    80003bac:	00913423          	sd	s1,8(sp)
    80003bb0:	02010413          	addi	s0,sp,32
    80003bb4:	00050493          	mv	s1,a0
    putc('\n');
    80003bb8:	00a00513          	li	a0,10
    80003bbc:	ffffe097          	auipc	ra,0xffffe
    80003bc0:	91c080e7          	jalr	-1764(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003bc4:	00002517          	auipc	a0,0x2
    80003bc8:	68c50513          	addi	a0,a0,1676 # 80006250 <CONSOLE_STATUS+0x240>
    80003bcc:	00000097          	auipc	ra,0x0
    80003bd0:	864080e7          	jalr	-1948(ra) # 80003430 <_Z11printStringPKc>
    while (head != tail) {
    80003bd4:	0104a783          	lw	a5,16(s1)
    80003bd8:	0144a703          	lw	a4,20(s1)
    80003bdc:	02e78a63          	beq	a5,a4,80003c10 <_ZN6BufferD1Ev+0x70>
        char ch = buffer[head];
    80003be0:	0084b703          	ld	a4,8(s1)
    80003be4:	00279793          	slli	a5,a5,0x2
    80003be8:	00f707b3          	add	a5,a4,a5
        putc(ch);
    80003bec:	0007c503          	lbu	a0,0(a5)
    80003bf0:	ffffe097          	auipc	ra,0xffffe
    80003bf4:	8e8080e7          	jalr	-1816(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80003bf8:	0104a783          	lw	a5,16(s1)
    80003bfc:	0017879b          	addiw	a5,a5,1
    80003c00:	0004a703          	lw	a4,0(s1)
    80003c04:	02e7e7bb          	remw	a5,a5,a4
    80003c08:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003c0c:	fc9ff06f          	j	80003bd4 <_ZN6BufferD1Ev+0x34>
    }
    putc('!');
    80003c10:	02100513          	li	a0,33
    80003c14:	ffffe097          	auipc	ra,0xffffe
    80003c18:	8c4080e7          	jalr	-1852(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    80003c1c:	00a00513          	li	a0,10
    80003c20:	ffffe097          	auipc	ra,0xffffe
    80003c24:	8b8080e7          	jalr	-1864(ra) # 800014d8 <_Z4putcc>

    mem_free(buffer);
    80003c28:	0084b503          	ld	a0,8(s1)
    80003c2c:	ffffd097          	auipc	ra,0xffffd
    80003c30:	5a8080e7          	jalr	1448(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003c34:	0204b503          	ld	a0,32(s1)
    80003c38:	ffffd097          	auipc	ra,0xffffd
    80003c3c:	7e8080e7          	jalr	2024(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003c40:	0184b503          	ld	a0,24(s1)
    80003c44:	ffffd097          	auipc	ra,0xffffd
    80003c48:	7dc080e7          	jalr	2012(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003c4c:	0304b503          	ld	a0,48(s1)
    80003c50:	ffffd097          	auipc	ra,0xffffd
    80003c54:	7d0080e7          	jalr	2000(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80003c58:	0284b503          	ld	a0,40(s1)
    80003c5c:	ffffd097          	auipc	ra,0xffffd
    80003c60:	7c4080e7          	jalr	1988(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003c64:	01813083          	ld	ra,24(sp)
    80003c68:	01013403          	ld	s0,16(sp)
    80003c6c:	00813483          	ld	s1,8(sp)
    80003c70:	02010113          	addi	sp,sp,32
    80003c74:	00008067          	ret

0000000080003c78 <_ZN6Buffer3putEi>:

void Buffer::put(int val) {
    80003c78:	fe010113          	addi	sp,sp,-32
    80003c7c:	00113c23          	sd	ra,24(sp)
    80003c80:	00813823          	sd	s0,16(sp)
    80003c84:	00913423          	sd	s1,8(sp)
    80003c88:	01213023          	sd	s2,0(sp)
    80003c8c:	02010413          	addi	s0,sp,32
    80003c90:	00050493          	mv	s1,a0
    80003c94:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003c98:	01853503          	ld	a0,24(a0)
    80003c9c:	ffffd097          	auipc	ra,0xffffd
    80003ca0:	6fc080e7          	jalr	1788(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80003ca4:	0304b503          	ld	a0,48(s1)
    80003ca8:	ffffd097          	auipc	ra,0xffffd
    80003cac:	6f0080e7          	jalr	1776(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80003cb0:	0084b783          	ld	a5,8(s1)
    80003cb4:	0144a703          	lw	a4,20(s1)
    80003cb8:	00271713          	slli	a4,a4,0x2
    80003cbc:	00e787b3          	add	a5,a5,a4
    80003cc0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003cc4:	0144a783          	lw	a5,20(s1)
    80003cc8:	0017879b          	addiw	a5,a5,1
    80003ccc:	0004a703          	lw	a4,0(s1)
    80003cd0:	02e7e7bb          	remw	a5,a5,a4
    80003cd4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003cd8:	0304b503          	ld	a0,48(s1)
    80003cdc:	ffffd097          	auipc	ra,0xffffd
    80003ce0:	704080e7          	jalr	1796(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80003ce4:	0204b503          	ld	a0,32(s1)
    80003ce8:	ffffd097          	auipc	ra,0xffffd
    80003cec:	6f8080e7          	jalr	1784(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80003cf0:	01813083          	ld	ra,24(sp)
    80003cf4:	01013403          	ld	s0,16(sp)
    80003cf8:	00813483          	ld	s1,8(sp)
    80003cfc:	00013903          	ld	s2,0(sp)
    80003d00:	02010113          	addi	sp,sp,32
    80003d04:	00008067          	ret

0000000080003d08 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003d08:	fe010113          	addi	sp,sp,-32
    80003d0c:	00113c23          	sd	ra,24(sp)
    80003d10:	00813823          	sd	s0,16(sp)
    80003d14:	00913423          	sd	s1,8(sp)
    80003d18:	01213023          	sd	s2,0(sp)
    80003d1c:	02010413          	addi	s0,sp,32
    80003d20:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003d24:	02053503          	ld	a0,32(a0)
    80003d28:	ffffd097          	auipc	ra,0xffffd
    80003d2c:	670080e7          	jalr	1648(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003d30:	0284b503          	ld	a0,40(s1)
    80003d34:	ffffd097          	auipc	ra,0xffffd
    80003d38:	664080e7          	jalr	1636(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003d3c:	0084b703          	ld	a4,8(s1)
    80003d40:	0104a783          	lw	a5,16(s1)
    80003d44:	00279693          	slli	a3,a5,0x2
    80003d48:	00d70733          	add	a4,a4,a3
    80003d4c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003d50:	0017879b          	addiw	a5,a5,1
    80003d54:	0004a703          	lw	a4,0(s1)
    80003d58:	02e7e7bb          	remw	a5,a5,a4
    80003d5c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003d60:	0284b503          	ld	a0,40(s1)
    80003d64:	ffffd097          	auipc	ra,0xffffd
    80003d68:	67c080e7          	jalr	1660(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003d6c:	0184b503          	ld	a0,24(s1)
    80003d70:	ffffd097          	auipc	ra,0xffffd
    80003d74:	670080e7          	jalr	1648(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003d78:	00090513          	mv	a0,s2
    80003d7c:	01813083          	ld	ra,24(sp)
    80003d80:	01013403          	ld	s0,16(sp)
    80003d84:	00813483          	ld	s1,8(sp)
    80003d88:	00013903          	ld	s2,0(sp)
    80003d8c:	02010113          	addi	sp,sp,32
    80003d90:	00008067          	ret

0000000080003d94 <start>:
    80003d94:	ff010113          	addi	sp,sp,-16
    80003d98:	00813423          	sd	s0,8(sp)
    80003d9c:	01010413          	addi	s0,sp,16
    80003da0:	300027f3          	csrr	a5,mstatus
    80003da4:	ffffe737          	lui	a4,0xffffe
    80003da8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5d5f>
    80003dac:	00e7f7b3          	and	a5,a5,a4
    80003db0:	00001737          	lui	a4,0x1
    80003db4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003db8:	00e7e7b3          	or	a5,a5,a4
    80003dbc:	30079073          	csrw	mstatus,a5
    80003dc0:	00000797          	auipc	a5,0x0
    80003dc4:	16078793          	addi	a5,a5,352 # 80003f20 <system_main>
    80003dc8:	34179073          	csrw	mepc,a5
    80003dcc:	00000793          	li	a5,0
    80003dd0:	18079073          	csrw	satp,a5
    80003dd4:	000107b7          	lui	a5,0x10
    80003dd8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003ddc:	30279073          	csrw	medeleg,a5
    80003de0:	30379073          	csrw	mideleg,a5
    80003de4:	104027f3          	csrr	a5,sie
    80003de8:	2227e793          	ori	a5,a5,546
    80003dec:	10479073          	csrw	sie,a5
    80003df0:	fff00793          	li	a5,-1
    80003df4:	00a7d793          	srli	a5,a5,0xa
    80003df8:	3b079073          	csrw	pmpaddr0,a5
    80003dfc:	00f00793          	li	a5,15
    80003e00:	3a079073          	csrw	pmpcfg0,a5
    80003e04:	f14027f3          	csrr	a5,mhartid
    80003e08:	0200c737          	lui	a4,0x200c
    80003e0c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003e10:	0007869b          	sext.w	a3,a5
    80003e14:	00269713          	slli	a4,a3,0x2
    80003e18:	000f4637          	lui	a2,0xf4
    80003e1c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003e20:	00d70733          	add	a4,a4,a3
    80003e24:	0037979b          	slliw	a5,a5,0x3
    80003e28:	020046b7          	lui	a3,0x2004
    80003e2c:	00d787b3          	add	a5,a5,a3
    80003e30:	00c585b3          	add	a1,a1,a2
    80003e34:	00371693          	slli	a3,a4,0x3
    80003e38:	00004717          	auipc	a4,0x4
    80003e3c:	a0870713          	addi	a4,a4,-1528 # 80007840 <timer_scratch>
    80003e40:	00b7b023          	sd	a1,0(a5)
    80003e44:	00d70733          	add	a4,a4,a3
    80003e48:	00f73c23          	sd	a5,24(a4)
    80003e4c:	02c73023          	sd	a2,32(a4)
    80003e50:	34071073          	csrw	mscratch,a4
    80003e54:	00000797          	auipc	a5,0x0
    80003e58:	6ec78793          	addi	a5,a5,1772 # 80004540 <timervec>
    80003e5c:	30579073          	csrw	mtvec,a5
    80003e60:	300027f3          	csrr	a5,mstatus
    80003e64:	0087e793          	ori	a5,a5,8
    80003e68:	30079073          	csrw	mstatus,a5
    80003e6c:	304027f3          	csrr	a5,mie
    80003e70:	0807e793          	ori	a5,a5,128
    80003e74:	30479073          	csrw	mie,a5
    80003e78:	f14027f3          	csrr	a5,mhartid
    80003e7c:	0007879b          	sext.w	a5,a5
    80003e80:	00078213          	mv	tp,a5
    80003e84:	30200073          	mret
    80003e88:	00813403          	ld	s0,8(sp)
    80003e8c:	01010113          	addi	sp,sp,16
    80003e90:	00008067          	ret

0000000080003e94 <timerinit>:
    80003e94:	ff010113          	addi	sp,sp,-16
    80003e98:	00813423          	sd	s0,8(sp)
    80003e9c:	01010413          	addi	s0,sp,16
    80003ea0:	f14027f3          	csrr	a5,mhartid
    80003ea4:	0200c737          	lui	a4,0x200c
    80003ea8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003eac:	0007869b          	sext.w	a3,a5
    80003eb0:	00269713          	slli	a4,a3,0x2
    80003eb4:	000f4637          	lui	a2,0xf4
    80003eb8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003ebc:	00d70733          	add	a4,a4,a3
    80003ec0:	0037979b          	slliw	a5,a5,0x3
    80003ec4:	020046b7          	lui	a3,0x2004
    80003ec8:	00d787b3          	add	a5,a5,a3
    80003ecc:	00c585b3          	add	a1,a1,a2
    80003ed0:	00371693          	slli	a3,a4,0x3
    80003ed4:	00004717          	auipc	a4,0x4
    80003ed8:	96c70713          	addi	a4,a4,-1684 # 80007840 <timer_scratch>
    80003edc:	00b7b023          	sd	a1,0(a5)
    80003ee0:	00d70733          	add	a4,a4,a3
    80003ee4:	00f73c23          	sd	a5,24(a4)
    80003ee8:	02c73023          	sd	a2,32(a4)
    80003eec:	34071073          	csrw	mscratch,a4
    80003ef0:	00000797          	auipc	a5,0x0
    80003ef4:	65078793          	addi	a5,a5,1616 # 80004540 <timervec>
    80003ef8:	30579073          	csrw	mtvec,a5
    80003efc:	300027f3          	csrr	a5,mstatus
    80003f00:	0087e793          	ori	a5,a5,8
    80003f04:	30079073          	csrw	mstatus,a5
    80003f08:	304027f3          	csrr	a5,mie
    80003f0c:	0807e793          	ori	a5,a5,128
    80003f10:	30479073          	csrw	mie,a5
    80003f14:	00813403          	ld	s0,8(sp)
    80003f18:	01010113          	addi	sp,sp,16
    80003f1c:	00008067          	ret

0000000080003f20 <system_main>:
    80003f20:	fe010113          	addi	sp,sp,-32
    80003f24:	00813823          	sd	s0,16(sp)
    80003f28:	00913423          	sd	s1,8(sp)
    80003f2c:	00113c23          	sd	ra,24(sp)
    80003f30:	02010413          	addi	s0,sp,32
    80003f34:	00000097          	auipc	ra,0x0
    80003f38:	0c4080e7          	jalr	196(ra) # 80003ff8 <cpuid>
    80003f3c:	00004497          	auipc	s1,0x4
    80003f40:	83448493          	addi	s1,s1,-1996 # 80007770 <started>
    80003f44:	02050263          	beqz	a0,80003f68 <system_main+0x48>
    80003f48:	0004a783          	lw	a5,0(s1)
    80003f4c:	0007879b          	sext.w	a5,a5
    80003f50:	fe078ce3          	beqz	a5,80003f48 <system_main+0x28>
    80003f54:	0ff0000f          	fence
    80003f58:	00002517          	auipc	a0,0x2
    80003f5c:	34050513          	addi	a0,a0,832 # 80006298 <CONSOLE_STATUS+0x288>
    80003f60:	00001097          	auipc	ra,0x1
    80003f64:	a7c080e7          	jalr	-1412(ra) # 800049dc <panic>
    80003f68:	00001097          	auipc	ra,0x1
    80003f6c:	9d0080e7          	jalr	-1584(ra) # 80004938 <consoleinit>
    80003f70:	00001097          	auipc	ra,0x1
    80003f74:	15c080e7          	jalr	348(ra) # 800050cc <printfinit>
    80003f78:	00002517          	auipc	a0,0x2
    80003f7c:	40050513          	addi	a0,a0,1024 # 80006378 <CONSOLE_STATUS+0x368>
    80003f80:	00001097          	auipc	ra,0x1
    80003f84:	ab8080e7          	jalr	-1352(ra) # 80004a38 <__printf>
    80003f88:	00002517          	auipc	a0,0x2
    80003f8c:	2e050513          	addi	a0,a0,736 # 80006268 <CONSOLE_STATUS+0x258>
    80003f90:	00001097          	auipc	ra,0x1
    80003f94:	aa8080e7          	jalr	-1368(ra) # 80004a38 <__printf>
    80003f98:	00002517          	auipc	a0,0x2
    80003f9c:	3e050513          	addi	a0,a0,992 # 80006378 <CONSOLE_STATUS+0x368>
    80003fa0:	00001097          	auipc	ra,0x1
    80003fa4:	a98080e7          	jalr	-1384(ra) # 80004a38 <__printf>
    80003fa8:	00001097          	auipc	ra,0x1
    80003fac:	4b0080e7          	jalr	1200(ra) # 80005458 <kinit>
    80003fb0:	00000097          	auipc	ra,0x0
    80003fb4:	148080e7          	jalr	328(ra) # 800040f8 <trapinit>
    80003fb8:	00000097          	auipc	ra,0x0
    80003fbc:	16c080e7          	jalr	364(ra) # 80004124 <trapinithart>
    80003fc0:	00000097          	auipc	ra,0x0
    80003fc4:	5c0080e7          	jalr	1472(ra) # 80004580 <plicinit>
    80003fc8:	00000097          	auipc	ra,0x0
    80003fcc:	5e0080e7          	jalr	1504(ra) # 800045a8 <plicinithart>
    80003fd0:	00000097          	auipc	ra,0x0
    80003fd4:	078080e7          	jalr	120(ra) # 80004048 <userinit>
    80003fd8:	0ff0000f          	fence
    80003fdc:	00100793          	li	a5,1
    80003fe0:	00002517          	auipc	a0,0x2
    80003fe4:	2a050513          	addi	a0,a0,672 # 80006280 <CONSOLE_STATUS+0x270>
    80003fe8:	00f4a023          	sw	a5,0(s1)
    80003fec:	00001097          	auipc	ra,0x1
    80003ff0:	a4c080e7          	jalr	-1460(ra) # 80004a38 <__printf>
    80003ff4:	0000006f          	j	80003ff4 <system_main+0xd4>

0000000080003ff8 <cpuid>:
    80003ff8:	ff010113          	addi	sp,sp,-16
    80003ffc:	00813423          	sd	s0,8(sp)
    80004000:	01010413          	addi	s0,sp,16
    80004004:	00020513          	mv	a0,tp
    80004008:	00813403          	ld	s0,8(sp)
    8000400c:	0005051b          	sext.w	a0,a0
    80004010:	01010113          	addi	sp,sp,16
    80004014:	00008067          	ret

0000000080004018 <mycpu>:
    80004018:	ff010113          	addi	sp,sp,-16
    8000401c:	00813423          	sd	s0,8(sp)
    80004020:	01010413          	addi	s0,sp,16
    80004024:	00020793          	mv	a5,tp
    80004028:	00813403          	ld	s0,8(sp)
    8000402c:	0007879b          	sext.w	a5,a5
    80004030:	00779793          	slli	a5,a5,0x7
    80004034:	00005517          	auipc	a0,0x5
    80004038:	83c50513          	addi	a0,a0,-1988 # 80008870 <cpus>
    8000403c:	00f50533          	add	a0,a0,a5
    80004040:	01010113          	addi	sp,sp,16
    80004044:	00008067          	ret

0000000080004048 <userinit>:
    80004048:	ff010113          	addi	sp,sp,-16
    8000404c:	00813423          	sd	s0,8(sp)
    80004050:	01010413          	addi	s0,sp,16
    80004054:	00813403          	ld	s0,8(sp)
    80004058:	01010113          	addi	sp,sp,16
    8000405c:	ffffe317          	auipc	t1,0xffffe
    80004060:	6b830067          	jr	1720(t1) # 80002714 <main>

0000000080004064 <either_copyout>:
    80004064:	ff010113          	addi	sp,sp,-16
    80004068:	00813023          	sd	s0,0(sp)
    8000406c:	00113423          	sd	ra,8(sp)
    80004070:	01010413          	addi	s0,sp,16
    80004074:	02051663          	bnez	a0,800040a0 <either_copyout+0x3c>
    80004078:	00058513          	mv	a0,a1
    8000407c:	00060593          	mv	a1,a2
    80004080:	0006861b          	sext.w	a2,a3
    80004084:	00002097          	auipc	ra,0x2
    80004088:	c60080e7          	jalr	-928(ra) # 80005ce4 <__memmove>
    8000408c:	00813083          	ld	ra,8(sp)
    80004090:	00013403          	ld	s0,0(sp)
    80004094:	00000513          	li	a0,0
    80004098:	01010113          	addi	sp,sp,16
    8000409c:	00008067          	ret
    800040a0:	00002517          	auipc	a0,0x2
    800040a4:	22050513          	addi	a0,a0,544 # 800062c0 <CONSOLE_STATUS+0x2b0>
    800040a8:	00001097          	auipc	ra,0x1
    800040ac:	934080e7          	jalr	-1740(ra) # 800049dc <panic>

00000000800040b0 <either_copyin>:
    800040b0:	ff010113          	addi	sp,sp,-16
    800040b4:	00813023          	sd	s0,0(sp)
    800040b8:	00113423          	sd	ra,8(sp)
    800040bc:	01010413          	addi	s0,sp,16
    800040c0:	02059463          	bnez	a1,800040e8 <either_copyin+0x38>
    800040c4:	00060593          	mv	a1,a2
    800040c8:	0006861b          	sext.w	a2,a3
    800040cc:	00002097          	auipc	ra,0x2
    800040d0:	c18080e7          	jalr	-1000(ra) # 80005ce4 <__memmove>
    800040d4:	00813083          	ld	ra,8(sp)
    800040d8:	00013403          	ld	s0,0(sp)
    800040dc:	00000513          	li	a0,0
    800040e0:	01010113          	addi	sp,sp,16
    800040e4:	00008067          	ret
    800040e8:	00002517          	auipc	a0,0x2
    800040ec:	20050513          	addi	a0,a0,512 # 800062e8 <CONSOLE_STATUS+0x2d8>
    800040f0:	00001097          	auipc	ra,0x1
    800040f4:	8ec080e7          	jalr	-1812(ra) # 800049dc <panic>

00000000800040f8 <trapinit>:
    800040f8:	ff010113          	addi	sp,sp,-16
    800040fc:	00813423          	sd	s0,8(sp)
    80004100:	01010413          	addi	s0,sp,16
    80004104:	00813403          	ld	s0,8(sp)
    80004108:	00002597          	auipc	a1,0x2
    8000410c:	20858593          	addi	a1,a1,520 # 80006310 <CONSOLE_STATUS+0x300>
    80004110:	00004517          	auipc	a0,0x4
    80004114:	7e050513          	addi	a0,a0,2016 # 800088f0 <tickslock>
    80004118:	01010113          	addi	sp,sp,16
    8000411c:	00001317          	auipc	t1,0x1
    80004120:	5cc30067          	jr	1484(t1) # 800056e8 <initlock>

0000000080004124 <trapinithart>:
    80004124:	ff010113          	addi	sp,sp,-16
    80004128:	00813423          	sd	s0,8(sp)
    8000412c:	01010413          	addi	s0,sp,16
    80004130:	00000797          	auipc	a5,0x0
    80004134:	30078793          	addi	a5,a5,768 # 80004430 <kernelvec>
    80004138:	10579073          	csrw	stvec,a5
    8000413c:	00813403          	ld	s0,8(sp)
    80004140:	01010113          	addi	sp,sp,16
    80004144:	00008067          	ret

0000000080004148 <usertrap>:
    80004148:	ff010113          	addi	sp,sp,-16
    8000414c:	00813423          	sd	s0,8(sp)
    80004150:	01010413          	addi	s0,sp,16
    80004154:	00813403          	ld	s0,8(sp)
    80004158:	01010113          	addi	sp,sp,16
    8000415c:	00008067          	ret

0000000080004160 <usertrapret>:
    80004160:	ff010113          	addi	sp,sp,-16
    80004164:	00813423          	sd	s0,8(sp)
    80004168:	01010413          	addi	s0,sp,16
    8000416c:	00813403          	ld	s0,8(sp)
    80004170:	01010113          	addi	sp,sp,16
    80004174:	00008067          	ret

0000000080004178 <kerneltrap>:
    80004178:	fe010113          	addi	sp,sp,-32
    8000417c:	00813823          	sd	s0,16(sp)
    80004180:	00113c23          	sd	ra,24(sp)
    80004184:	00913423          	sd	s1,8(sp)
    80004188:	02010413          	addi	s0,sp,32
    8000418c:	142025f3          	csrr	a1,scause
    80004190:	100027f3          	csrr	a5,sstatus
    80004194:	0027f793          	andi	a5,a5,2
    80004198:	10079c63          	bnez	a5,800042b0 <kerneltrap+0x138>
    8000419c:	142027f3          	csrr	a5,scause
    800041a0:	0207ce63          	bltz	a5,800041dc <kerneltrap+0x64>
    800041a4:	00002517          	auipc	a0,0x2
    800041a8:	1b450513          	addi	a0,a0,436 # 80006358 <CONSOLE_STATUS+0x348>
    800041ac:	00001097          	auipc	ra,0x1
    800041b0:	88c080e7          	jalr	-1908(ra) # 80004a38 <__printf>
    800041b4:	141025f3          	csrr	a1,sepc
    800041b8:	14302673          	csrr	a2,stval
    800041bc:	00002517          	auipc	a0,0x2
    800041c0:	1ac50513          	addi	a0,a0,428 # 80006368 <CONSOLE_STATUS+0x358>
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	874080e7          	jalr	-1932(ra) # 80004a38 <__printf>
    800041cc:	00002517          	auipc	a0,0x2
    800041d0:	1b450513          	addi	a0,a0,436 # 80006380 <CONSOLE_STATUS+0x370>
    800041d4:	00001097          	auipc	ra,0x1
    800041d8:	808080e7          	jalr	-2040(ra) # 800049dc <panic>
    800041dc:	0ff7f713          	andi	a4,a5,255
    800041e0:	00900693          	li	a3,9
    800041e4:	04d70063          	beq	a4,a3,80004224 <kerneltrap+0xac>
    800041e8:	fff00713          	li	a4,-1
    800041ec:	03f71713          	slli	a4,a4,0x3f
    800041f0:	00170713          	addi	a4,a4,1
    800041f4:	fae798e3          	bne	a5,a4,800041a4 <kerneltrap+0x2c>
    800041f8:	00000097          	auipc	ra,0x0
    800041fc:	e00080e7          	jalr	-512(ra) # 80003ff8 <cpuid>
    80004200:	06050663          	beqz	a0,8000426c <kerneltrap+0xf4>
    80004204:	144027f3          	csrr	a5,sip
    80004208:	ffd7f793          	andi	a5,a5,-3
    8000420c:	14479073          	csrw	sip,a5
    80004210:	01813083          	ld	ra,24(sp)
    80004214:	01013403          	ld	s0,16(sp)
    80004218:	00813483          	ld	s1,8(sp)
    8000421c:	02010113          	addi	sp,sp,32
    80004220:	00008067          	ret
    80004224:	00000097          	auipc	ra,0x0
    80004228:	3d0080e7          	jalr	976(ra) # 800045f4 <plic_claim>
    8000422c:	00a00793          	li	a5,10
    80004230:	00050493          	mv	s1,a0
    80004234:	06f50863          	beq	a0,a5,800042a4 <kerneltrap+0x12c>
    80004238:	fc050ce3          	beqz	a0,80004210 <kerneltrap+0x98>
    8000423c:	00050593          	mv	a1,a0
    80004240:	00002517          	auipc	a0,0x2
    80004244:	0f850513          	addi	a0,a0,248 # 80006338 <CONSOLE_STATUS+0x328>
    80004248:	00000097          	auipc	ra,0x0
    8000424c:	7f0080e7          	jalr	2032(ra) # 80004a38 <__printf>
    80004250:	01013403          	ld	s0,16(sp)
    80004254:	01813083          	ld	ra,24(sp)
    80004258:	00048513          	mv	a0,s1
    8000425c:	00813483          	ld	s1,8(sp)
    80004260:	02010113          	addi	sp,sp,32
    80004264:	00000317          	auipc	t1,0x0
    80004268:	3c830067          	jr	968(t1) # 8000462c <plic_complete>
    8000426c:	00004517          	auipc	a0,0x4
    80004270:	68450513          	addi	a0,a0,1668 # 800088f0 <tickslock>
    80004274:	00001097          	auipc	ra,0x1
    80004278:	498080e7          	jalr	1176(ra) # 8000570c <acquire>
    8000427c:	00003717          	auipc	a4,0x3
    80004280:	4f870713          	addi	a4,a4,1272 # 80007774 <ticks>
    80004284:	00072783          	lw	a5,0(a4)
    80004288:	00004517          	auipc	a0,0x4
    8000428c:	66850513          	addi	a0,a0,1640 # 800088f0 <tickslock>
    80004290:	0017879b          	addiw	a5,a5,1
    80004294:	00f72023          	sw	a5,0(a4)
    80004298:	00001097          	auipc	ra,0x1
    8000429c:	540080e7          	jalr	1344(ra) # 800057d8 <release>
    800042a0:	f65ff06f          	j	80004204 <kerneltrap+0x8c>
    800042a4:	00001097          	auipc	ra,0x1
    800042a8:	09c080e7          	jalr	156(ra) # 80005340 <uartintr>
    800042ac:	fa5ff06f          	j	80004250 <kerneltrap+0xd8>
    800042b0:	00002517          	auipc	a0,0x2
    800042b4:	06850513          	addi	a0,a0,104 # 80006318 <CONSOLE_STATUS+0x308>
    800042b8:	00000097          	auipc	ra,0x0
    800042bc:	724080e7          	jalr	1828(ra) # 800049dc <panic>

00000000800042c0 <clockintr>:
    800042c0:	fe010113          	addi	sp,sp,-32
    800042c4:	00813823          	sd	s0,16(sp)
    800042c8:	00913423          	sd	s1,8(sp)
    800042cc:	00113c23          	sd	ra,24(sp)
    800042d0:	02010413          	addi	s0,sp,32
    800042d4:	00004497          	auipc	s1,0x4
    800042d8:	61c48493          	addi	s1,s1,1564 # 800088f0 <tickslock>
    800042dc:	00048513          	mv	a0,s1
    800042e0:	00001097          	auipc	ra,0x1
    800042e4:	42c080e7          	jalr	1068(ra) # 8000570c <acquire>
    800042e8:	00003717          	auipc	a4,0x3
    800042ec:	48c70713          	addi	a4,a4,1164 # 80007774 <ticks>
    800042f0:	00072783          	lw	a5,0(a4)
    800042f4:	01013403          	ld	s0,16(sp)
    800042f8:	01813083          	ld	ra,24(sp)
    800042fc:	00048513          	mv	a0,s1
    80004300:	0017879b          	addiw	a5,a5,1
    80004304:	00813483          	ld	s1,8(sp)
    80004308:	00f72023          	sw	a5,0(a4)
    8000430c:	02010113          	addi	sp,sp,32
    80004310:	00001317          	auipc	t1,0x1
    80004314:	4c830067          	jr	1224(t1) # 800057d8 <release>

0000000080004318 <devintr>:
    80004318:	142027f3          	csrr	a5,scause
    8000431c:	00000513          	li	a0,0
    80004320:	0007c463          	bltz	a5,80004328 <devintr+0x10>
    80004324:	00008067          	ret
    80004328:	fe010113          	addi	sp,sp,-32
    8000432c:	00813823          	sd	s0,16(sp)
    80004330:	00113c23          	sd	ra,24(sp)
    80004334:	00913423          	sd	s1,8(sp)
    80004338:	02010413          	addi	s0,sp,32
    8000433c:	0ff7f713          	andi	a4,a5,255
    80004340:	00900693          	li	a3,9
    80004344:	04d70c63          	beq	a4,a3,8000439c <devintr+0x84>
    80004348:	fff00713          	li	a4,-1
    8000434c:	03f71713          	slli	a4,a4,0x3f
    80004350:	00170713          	addi	a4,a4,1
    80004354:	00e78c63          	beq	a5,a4,8000436c <devintr+0x54>
    80004358:	01813083          	ld	ra,24(sp)
    8000435c:	01013403          	ld	s0,16(sp)
    80004360:	00813483          	ld	s1,8(sp)
    80004364:	02010113          	addi	sp,sp,32
    80004368:	00008067          	ret
    8000436c:	00000097          	auipc	ra,0x0
    80004370:	c8c080e7          	jalr	-884(ra) # 80003ff8 <cpuid>
    80004374:	06050663          	beqz	a0,800043e0 <devintr+0xc8>
    80004378:	144027f3          	csrr	a5,sip
    8000437c:	ffd7f793          	andi	a5,a5,-3
    80004380:	14479073          	csrw	sip,a5
    80004384:	01813083          	ld	ra,24(sp)
    80004388:	01013403          	ld	s0,16(sp)
    8000438c:	00813483          	ld	s1,8(sp)
    80004390:	00200513          	li	a0,2
    80004394:	02010113          	addi	sp,sp,32
    80004398:	00008067          	ret
    8000439c:	00000097          	auipc	ra,0x0
    800043a0:	258080e7          	jalr	600(ra) # 800045f4 <plic_claim>
    800043a4:	00a00793          	li	a5,10
    800043a8:	00050493          	mv	s1,a0
    800043ac:	06f50663          	beq	a0,a5,80004418 <devintr+0x100>
    800043b0:	00100513          	li	a0,1
    800043b4:	fa0482e3          	beqz	s1,80004358 <devintr+0x40>
    800043b8:	00048593          	mv	a1,s1
    800043bc:	00002517          	auipc	a0,0x2
    800043c0:	f7c50513          	addi	a0,a0,-132 # 80006338 <CONSOLE_STATUS+0x328>
    800043c4:	00000097          	auipc	ra,0x0
    800043c8:	674080e7          	jalr	1652(ra) # 80004a38 <__printf>
    800043cc:	00048513          	mv	a0,s1
    800043d0:	00000097          	auipc	ra,0x0
    800043d4:	25c080e7          	jalr	604(ra) # 8000462c <plic_complete>
    800043d8:	00100513          	li	a0,1
    800043dc:	f7dff06f          	j	80004358 <devintr+0x40>
    800043e0:	00004517          	auipc	a0,0x4
    800043e4:	51050513          	addi	a0,a0,1296 # 800088f0 <tickslock>
    800043e8:	00001097          	auipc	ra,0x1
    800043ec:	324080e7          	jalr	804(ra) # 8000570c <acquire>
    800043f0:	00003717          	auipc	a4,0x3
    800043f4:	38470713          	addi	a4,a4,900 # 80007774 <ticks>
    800043f8:	00072783          	lw	a5,0(a4)
    800043fc:	00004517          	auipc	a0,0x4
    80004400:	4f450513          	addi	a0,a0,1268 # 800088f0 <tickslock>
    80004404:	0017879b          	addiw	a5,a5,1
    80004408:	00f72023          	sw	a5,0(a4)
    8000440c:	00001097          	auipc	ra,0x1
    80004410:	3cc080e7          	jalr	972(ra) # 800057d8 <release>
    80004414:	f65ff06f          	j	80004378 <devintr+0x60>
    80004418:	00001097          	auipc	ra,0x1
    8000441c:	f28080e7          	jalr	-216(ra) # 80005340 <uartintr>
    80004420:	fadff06f          	j	800043cc <devintr+0xb4>
	...

0000000080004430 <kernelvec>:
    80004430:	f0010113          	addi	sp,sp,-256
    80004434:	00113023          	sd	ra,0(sp)
    80004438:	00213423          	sd	sp,8(sp)
    8000443c:	00313823          	sd	gp,16(sp)
    80004440:	00413c23          	sd	tp,24(sp)
    80004444:	02513023          	sd	t0,32(sp)
    80004448:	02613423          	sd	t1,40(sp)
    8000444c:	02713823          	sd	t2,48(sp)
    80004450:	02813c23          	sd	s0,56(sp)
    80004454:	04913023          	sd	s1,64(sp)
    80004458:	04a13423          	sd	a0,72(sp)
    8000445c:	04b13823          	sd	a1,80(sp)
    80004460:	04c13c23          	sd	a2,88(sp)
    80004464:	06d13023          	sd	a3,96(sp)
    80004468:	06e13423          	sd	a4,104(sp)
    8000446c:	06f13823          	sd	a5,112(sp)
    80004470:	07013c23          	sd	a6,120(sp)
    80004474:	09113023          	sd	a7,128(sp)
    80004478:	09213423          	sd	s2,136(sp)
    8000447c:	09313823          	sd	s3,144(sp)
    80004480:	09413c23          	sd	s4,152(sp)
    80004484:	0b513023          	sd	s5,160(sp)
    80004488:	0b613423          	sd	s6,168(sp)
    8000448c:	0b713823          	sd	s7,176(sp)
    80004490:	0b813c23          	sd	s8,184(sp)
    80004494:	0d913023          	sd	s9,192(sp)
    80004498:	0da13423          	sd	s10,200(sp)
    8000449c:	0db13823          	sd	s11,208(sp)
    800044a0:	0dc13c23          	sd	t3,216(sp)
    800044a4:	0fd13023          	sd	t4,224(sp)
    800044a8:	0fe13423          	sd	t5,232(sp)
    800044ac:	0ff13823          	sd	t6,240(sp)
    800044b0:	cc9ff0ef          	jal	ra,80004178 <kerneltrap>
    800044b4:	00013083          	ld	ra,0(sp)
    800044b8:	00813103          	ld	sp,8(sp)
    800044bc:	01013183          	ld	gp,16(sp)
    800044c0:	02013283          	ld	t0,32(sp)
    800044c4:	02813303          	ld	t1,40(sp)
    800044c8:	03013383          	ld	t2,48(sp)
    800044cc:	03813403          	ld	s0,56(sp)
    800044d0:	04013483          	ld	s1,64(sp)
    800044d4:	04813503          	ld	a0,72(sp)
    800044d8:	05013583          	ld	a1,80(sp)
    800044dc:	05813603          	ld	a2,88(sp)
    800044e0:	06013683          	ld	a3,96(sp)
    800044e4:	06813703          	ld	a4,104(sp)
    800044e8:	07013783          	ld	a5,112(sp)
    800044ec:	07813803          	ld	a6,120(sp)
    800044f0:	08013883          	ld	a7,128(sp)
    800044f4:	08813903          	ld	s2,136(sp)
    800044f8:	09013983          	ld	s3,144(sp)
    800044fc:	09813a03          	ld	s4,152(sp)
    80004500:	0a013a83          	ld	s5,160(sp)
    80004504:	0a813b03          	ld	s6,168(sp)
    80004508:	0b013b83          	ld	s7,176(sp)
    8000450c:	0b813c03          	ld	s8,184(sp)
    80004510:	0c013c83          	ld	s9,192(sp)
    80004514:	0c813d03          	ld	s10,200(sp)
    80004518:	0d013d83          	ld	s11,208(sp)
    8000451c:	0d813e03          	ld	t3,216(sp)
    80004520:	0e013e83          	ld	t4,224(sp)
    80004524:	0e813f03          	ld	t5,232(sp)
    80004528:	0f013f83          	ld	t6,240(sp)
    8000452c:	10010113          	addi	sp,sp,256
    80004530:	10200073          	sret
    80004534:	00000013          	nop
    80004538:	00000013          	nop
    8000453c:	00000013          	nop

0000000080004540 <timervec>:
    80004540:	34051573          	csrrw	a0,mscratch,a0
    80004544:	00b53023          	sd	a1,0(a0)
    80004548:	00c53423          	sd	a2,8(a0)
    8000454c:	00d53823          	sd	a3,16(a0)
    80004550:	01853583          	ld	a1,24(a0)
    80004554:	02053603          	ld	a2,32(a0)
    80004558:	0005b683          	ld	a3,0(a1)
    8000455c:	00c686b3          	add	a3,a3,a2
    80004560:	00d5b023          	sd	a3,0(a1)
    80004564:	00200593          	li	a1,2
    80004568:	14459073          	csrw	sip,a1
    8000456c:	01053683          	ld	a3,16(a0)
    80004570:	00853603          	ld	a2,8(a0)
    80004574:	00053583          	ld	a1,0(a0)
    80004578:	34051573          	csrrw	a0,mscratch,a0
    8000457c:	30200073          	mret

0000000080004580 <plicinit>:
    80004580:	ff010113          	addi	sp,sp,-16
    80004584:	00813423          	sd	s0,8(sp)
    80004588:	01010413          	addi	s0,sp,16
    8000458c:	00813403          	ld	s0,8(sp)
    80004590:	0c0007b7          	lui	a5,0xc000
    80004594:	00100713          	li	a4,1
    80004598:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000459c:	00e7a223          	sw	a4,4(a5)
    800045a0:	01010113          	addi	sp,sp,16
    800045a4:	00008067          	ret

00000000800045a8 <plicinithart>:
    800045a8:	ff010113          	addi	sp,sp,-16
    800045ac:	00813023          	sd	s0,0(sp)
    800045b0:	00113423          	sd	ra,8(sp)
    800045b4:	01010413          	addi	s0,sp,16
    800045b8:	00000097          	auipc	ra,0x0
    800045bc:	a40080e7          	jalr	-1472(ra) # 80003ff8 <cpuid>
    800045c0:	0085171b          	slliw	a4,a0,0x8
    800045c4:	0c0027b7          	lui	a5,0xc002
    800045c8:	00e787b3          	add	a5,a5,a4
    800045cc:	40200713          	li	a4,1026
    800045d0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800045d4:	00813083          	ld	ra,8(sp)
    800045d8:	00013403          	ld	s0,0(sp)
    800045dc:	00d5151b          	slliw	a0,a0,0xd
    800045e0:	0c2017b7          	lui	a5,0xc201
    800045e4:	00a78533          	add	a0,a5,a0
    800045e8:	00052023          	sw	zero,0(a0)
    800045ec:	01010113          	addi	sp,sp,16
    800045f0:	00008067          	ret

00000000800045f4 <plic_claim>:
    800045f4:	ff010113          	addi	sp,sp,-16
    800045f8:	00813023          	sd	s0,0(sp)
    800045fc:	00113423          	sd	ra,8(sp)
    80004600:	01010413          	addi	s0,sp,16
    80004604:	00000097          	auipc	ra,0x0
    80004608:	9f4080e7          	jalr	-1548(ra) # 80003ff8 <cpuid>
    8000460c:	00813083          	ld	ra,8(sp)
    80004610:	00013403          	ld	s0,0(sp)
    80004614:	00d5151b          	slliw	a0,a0,0xd
    80004618:	0c2017b7          	lui	a5,0xc201
    8000461c:	00a78533          	add	a0,a5,a0
    80004620:	00452503          	lw	a0,4(a0)
    80004624:	01010113          	addi	sp,sp,16
    80004628:	00008067          	ret

000000008000462c <plic_complete>:
    8000462c:	fe010113          	addi	sp,sp,-32
    80004630:	00813823          	sd	s0,16(sp)
    80004634:	00913423          	sd	s1,8(sp)
    80004638:	00113c23          	sd	ra,24(sp)
    8000463c:	02010413          	addi	s0,sp,32
    80004640:	00050493          	mv	s1,a0
    80004644:	00000097          	auipc	ra,0x0
    80004648:	9b4080e7          	jalr	-1612(ra) # 80003ff8 <cpuid>
    8000464c:	01813083          	ld	ra,24(sp)
    80004650:	01013403          	ld	s0,16(sp)
    80004654:	00d5179b          	slliw	a5,a0,0xd
    80004658:	0c201737          	lui	a4,0xc201
    8000465c:	00f707b3          	add	a5,a4,a5
    80004660:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004664:	00813483          	ld	s1,8(sp)
    80004668:	02010113          	addi	sp,sp,32
    8000466c:	00008067          	ret

0000000080004670 <consolewrite>:
    80004670:	fb010113          	addi	sp,sp,-80
    80004674:	04813023          	sd	s0,64(sp)
    80004678:	04113423          	sd	ra,72(sp)
    8000467c:	02913c23          	sd	s1,56(sp)
    80004680:	03213823          	sd	s2,48(sp)
    80004684:	03313423          	sd	s3,40(sp)
    80004688:	03413023          	sd	s4,32(sp)
    8000468c:	01513c23          	sd	s5,24(sp)
    80004690:	05010413          	addi	s0,sp,80
    80004694:	06c05c63          	blez	a2,8000470c <consolewrite+0x9c>
    80004698:	00060993          	mv	s3,a2
    8000469c:	00050a13          	mv	s4,a0
    800046a0:	00058493          	mv	s1,a1
    800046a4:	00000913          	li	s2,0
    800046a8:	fff00a93          	li	s5,-1
    800046ac:	01c0006f          	j	800046c8 <consolewrite+0x58>
    800046b0:	fbf44503          	lbu	a0,-65(s0)
    800046b4:	0019091b          	addiw	s2,s2,1
    800046b8:	00148493          	addi	s1,s1,1
    800046bc:	00001097          	auipc	ra,0x1
    800046c0:	a9c080e7          	jalr	-1380(ra) # 80005158 <uartputc>
    800046c4:	03298063          	beq	s3,s2,800046e4 <consolewrite+0x74>
    800046c8:	00048613          	mv	a2,s1
    800046cc:	00100693          	li	a3,1
    800046d0:	000a0593          	mv	a1,s4
    800046d4:	fbf40513          	addi	a0,s0,-65
    800046d8:	00000097          	auipc	ra,0x0
    800046dc:	9d8080e7          	jalr	-1576(ra) # 800040b0 <either_copyin>
    800046e0:	fd5518e3          	bne	a0,s5,800046b0 <consolewrite+0x40>
    800046e4:	04813083          	ld	ra,72(sp)
    800046e8:	04013403          	ld	s0,64(sp)
    800046ec:	03813483          	ld	s1,56(sp)
    800046f0:	02813983          	ld	s3,40(sp)
    800046f4:	02013a03          	ld	s4,32(sp)
    800046f8:	01813a83          	ld	s5,24(sp)
    800046fc:	00090513          	mv	a0,s2
    80004700:	03013903          	ld	s2,48(sp)
    80004704:	05010113          	addi	sp,sp,80
    80004708:	00008067          	ret
    8000470c:	00000913          	li	s2,0
    80004710:	fd5ff06f          	j	800046e4 <consolewrite+0x74>

0000000080004714 <consoleread>:
    80004714:	f9010113          	addi	sp,sp,-112
    80004718:	06813023          	sd	s0,96(sp)
    8000471c:	04913c23          	sd	s1,88(sp)
    80004720:	05213823          	sd	s2,80(sp)
    80004724:	05313423          	sd	s3,72(sp)
    80004728:	05413023          	sd	s4,64(sp)
    8000472c:	03513c23          	sd	s5,56(sp)
    80004730:	03613823          	sd	s6,48(sp)
    80004734:	03713423          	sd	s7,40(sp)
    80004738:	03813023          	sd	s8,32(sp)
    8000473c:	06113423          	sd	ra,104(sp)
    80004740:	01913c23          	sd	s9,24(sp)
    80004744:	07010413          	addi	s0,sp,112
    80004748:	00060b93          	mv	s7,a2
    8000474c:	00050913          	mv	s2,a0
    80004750:	00058c13          	mv	s8,a1
    80004754:	00060b1b          	sext.w	s6,a2
    80004758:	00004497          	auipc	s1,0x4
    8000475c:	1c048493          	addi	s1,s1,448 # 80008918 <cons>
    80004760:	00400993          	li	s3,4
    80004764:	fff00a13          	li	s4,-1
    80004768:	00a00a93          	li	s5,10
    8000476c:	05705e63          	blez	s7,800047c8 <consoleread+0xb4>
    80004770:	09c4a703          	lw	a4,156(s1)
    80004774:	0984a783          	lw	a5,152(s1)
    80004778:	0007071b          	sext.w	a4,a4
    8000477c:	08e78463          	beq	a5,a4,80004804 <consoleread+0xf0>
    80004780:	07f7f713          	andi	a4,a5,127
    80004784:	00e48733          	add	a4,s1,a4
    80004788:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000478c:	0017869b          	addiw	a3,a5,1
    80004790:	08d4ac23          	sw	a3,152(s1)
    80004794:	00070c9b          	sext.w	s9,a4
    80004798:	0b370663          	beq	a4,s3,80004844 <consoleread+0x130>
    8000479c:	00100693          	li	a3,1
    800047a0:	f9f40613          	addi	a2,s0,-97
    800047a4:	000c0593          	mv	a1,s8
    800047a8:	00090513          	mv	a0,s2
    800047ac:	f8e40fa3          	sb	a4,-97(s0)
    800047b0:	00000097          	auipc	ra,0x0
    800047b4:	8b4080e7          	jalr	-1868(ra) # 80004064 <either_copyout>
    800047b8:	01450863          	beq	a0,s4,800047c8 <consoleread+0xb4>
    800047bc:	001c0c13          	addi	s8,s8,1
    800047c0:	fffb8b9b          	addiw	s7,s7,-1
    800047c4:	fb5c94e3          	bne	s9,s5,8000476c <consoleread+0x58>
    800047c8:	000b851b          	sext.w	a0,s7
    800047cc:	06813083          	ld	ra,104(sp)
    800047d0:	06013403          	ld	s0,96(sp)
    800047d4:	05813483          	ld	s1,88(sp)
    800047d8:	05013903          	ld	s2,80(sp)
    800047dc:	04813983          	ld	s3,72(sp)
    800047e0:	04013a03          	ld	s4,64(sp)
    800047e4:	03813a83          	ld	s5,56(sp)
    800047e8:	02813b83          	ld	s7,40(sp)
    800047ec:	02013c03          	ld	s8,32(sp)
    800047f0:	01813c83          	ld	s9,24(sp)
    800047f4:	40ab053b          	subw	a0,s6,a0
    800047f8:	03013b03          	ld	s6,48(sp)
    800047fc:	07010113          	addi	sp,sp,112
    80004800:	00008067          	ret
    80004804:	00001097          	auipc	ra,0x1
    80004808:	1d8080e7          	jalr	472(ra) # 800059dc <push_on>
    8000480c:	0984a703          	lw	a4,152(s1)
    80004810:	09c4a783          	lw	a5,156(s1)
    80004814:	0007879b          	sext.w	a5,a5
    80004818:	fef70ce3          	beq	a4,a5,80004810 <consoleread+0xfc>
    8000481c:	00001097          	auipc	ra,0x1
    80004820:	234080e7          	jalr	564(ra) # 80005a50 <pop_on>
    80004824:	0984a783          	lw	a5,152(s1)
    80004828:	07f7f713          	andi	a4,a5,127
    8000482c:	00e48733          	add	a4,s1,a4
    80004830:	01874703          	lbu	a4,24(a4)
    80004834:	0017869b          	addiw	a3,a5,1
    80004838:	08d4ac23          	sw	a3,152(s1)
    8000483c:	00070c9b          	sext.w	s9,a4
    80004840:	f5371ee3          	bne	a4,s3,8000479c <consoleread+0x88>
    80004844:	000b851b          	sext.w	a0,s7
    80004848:	f96bf2e3          	bgeu	s7,s6,800047cc <consoleread+0xb8>
    8000484c:	08f4ac23          	sw	a5,152(s1)
    80004850:	f7dff06f          	j	800047cc <consoleread+0xb8>

0000000080004854 <consputc>:
    80004854:	10000793          	li	a5,256
    80004858:	00f50663          	beq	a0,a5,80004864 <consputc+0x10>
    8000485c:	00001317          	auipc	t1,0x1
    80004860:	9f430067          	jr	-1548(t1) # 80005250 <uartputc_sync>
    80004864:	ff010113          	addi	sp,sp,-16
    80004868:	00113423          	sd	ra,8(sp)
    8000486c:	00813023          	sd	s0,0(sp)
    80004870:	01010413          	addi	s0,sp,16
    80004874:	00800513          	li	a0,8
    80004878:	00001097          	auipc	ra,0x1
    8000487c:	9d8080e7          	jalr	-1576(ra) # 80005250 <uartputc_sync>
    80004880:	02000513          	li	a0,32
    80004884:	00001097          	auipc	ra,0x1
    80004888:	9cc080e7          	jalr	-1588(ra) # 80005250 <uartputc_sync>
    8000488c:	00013403          	ld	s0,0(sp)
    80004890:	00813083          	ld	ra,8(sp)
    80004894:	00800513          	li	a0,8
    80004898:	01010113          	addi	sp,sp,16
    8000489c:	00001317          	auipc	t1,0x1
    800048a0:	9b430067          	jr	-1612(t1) # 80005250 <uartputc_sync>

00000000800048a4 <consoleintr>:
    800048a4:	fe010113          	addi	sp,sp,-32
    800048a8:	00813823          	sd	s0,16(sp)
    800048ac:	00913423          	sd	s1,8(sp)
    800048b0:	01213023          	sd	s2,0(sp)
    800048b4:	00113c23          	sd	ra,24(sp)
    800048b8:	02010413          	addi	s0,sp,32
    800048bc:	00004917          	auipc	s2,0x4
    800048c0:	05c90913          	addi	s2,s2,92 # 80008918 <cons>
    800048c4:	00050493          	mv	s1,a0
    800048c8:	00090513          	mv	a0,s2
    800048cc:	00001097          	auipc	ra,0x1
    800048d0:	e40080e7          	jalr	-448(ra) # 8000570c <acquire>
    800048d4:	02048c63          	beqz	s1,8000490c <consoleintr+0x68>
    800048d8:	0a092783          	lw	a5,160(s2)
    800048dc:	09892703          	lw	a4,152(s2)
    800048e0:	07f00693          	li	a3,127
    800048e4:	40e7873b          	subw	a4,a5,a4
    800048e8:	02e6e263          	bltu	a3,a4,8000490c <consoleintr+0x68>
    800048ec:	00d00713          	li	a4,13
    800048f0:	04e48063          	beq	s1,a4,80004930 <consoleintr+0x8c>
    800048f4:	07f7f713          	andi	a4,a5,127
    800048f8:	00e90733          	add	a4,s2,a4
    800048fc:	0017879b          	addiw	a5,a5,1
    80004900:	0af92023          	sw	a5,160(s2)
    80004904:	00970c23          	sb	s1,24(a4)
    80004908:	08f92e23          	sw	a5,156(s2)
    8000490c:	01013403          	ld	s0,16(sp)
    80004910:	01813083          	ld	ra,24(sp)
    80004914:	00813483          	ld	s1,8(sp)
    80004918:	00013903          	ld	s2,0(sp)
    8000491c:	00004517          	auipc	a0,0x4
    80004920:	ffc50513          	addi	a0,a0,-4 # 80008918 <cons>
    80004924:	02010113          	addi	sp,sp,32
    80004928:	00001317          	auipc	t1,0x1
    8000492c:	eb030067          	jr	-336(t1) # 800057d8 <release>
    80004930:	00a00493          	li	s1,10
    80004934:	fc1ff06f          	j	800048f4 <consoleintr+0x50>

0000000080004938 <consoleinit>:
    80004938:	fe010113          	addi	sp,sp,-32
    8000493c:	00113c23          	sd	ra,24(sp)
    80004940:	00813823          	sd	s0,16(sp)
    80004944:	00913423          	sd	s1,8(sp)
    80004948:	02010413          	addi	s0,sp,32
    8000494c:	00004497          	auipc	s1,0x4
    80004950:	fcc48493          	addi	s1,s1,-52 # 80008918 <cons>
    80004954:	00048513          	mv	a0,s1
    80004958:	00002597          	auipc	a1,0x2
    8000495c:	a3858593          	addi	a1,a1,-1480 # 80006390 <CONSOLE_STATUS+0x380>
    80004960:	00001097          	auipc	ra,0x1
    80004964:	d88080e7          	jalr	-632(ra) # 800056e8 <initlock>
    80004968:	00000097          	auipc	ra,0x0
    8000496c:	7ac080e7          	jalr	1964(ra) # 80005114 <uartinit>
    80004970:	01813083          	ld	ra,24(sp)
    80004974:	01013403          	ld	s0,16(sp)
    80004978:	00000797          	auipc	a5,0x0
    8000497c:	d9c78793          	addi	a5,a5,-612 # 80004714 <consoleread>
    80004980:	0af4bc23          	sd	a5,184(s1)
    80004984:	00000797          	auipc	a5,0x0
    80004988:	cec78793          	addi	a5,a5,-788 # 80004670 <consolewrite>
    8000498c:	0cf4b023          	sd	a5,192(s1)
    80004990:	00813483          	ld	s1,8(sp)
    80004994:	02010113          	addi	sp,sp,32
    80004998:	00008067          	ret

000000008000499c <console_read>:
    8000499c:	ff010113          	addi	sp,sp,-16
    800049a0:	00813423          	sd	s0,8(sp)
    800049a4:	01010413          	addi	s0,sp,16
    800049a8:	00813403          	ld	s0,8(sp)
    800049ac:	00004317          	auipc	t1,0x4
    800049b0:	02433303          	ld	t1,36(t1) # 800089d0 <devsw+0x10>
    800049b4:	01010113          	addi	sp,sp,16
    800049b8:	00030067          	jr	t1

00000000800049bc <console_write>:
    800049bc:	ff010113          	addi	sp,sp,-16
    800049c0:	00813423          	sd	s0,8(sp)
    800049c4:	01010413          	addi	s0,sp,16
    800049c8:	00813403          	ld	s0,8(sp)
    800049cc:	00004317          	auipc	t1,0x4
    800049d0:	00c33303          	ld	t1,12(t1) # 800089d8 <devsw+0x18>
    800049d4:	01010113          	addi	sp,sp,16
    800049d8:	00030067          	jr	t1

00000000800049dc <panic>:
    800049dc:	fe010113          	addi	sp,sp,-32
    800049e0:	00113c23          	sd	ra,24(sp)
    800049e4:	00813823          	sd	s0,16(sp)
    800049e8:	00913423          	sd	s1,8(sp)
    800049ec:	02010413          	addi	s0,sp,32
    800049f0:	00050493          	mv	s1,a0
    800049f4:	00002517          	auipc	a0,0x2
    800049f8:	9a450513          	addi	a0,a0,-1628 # 80006398 <CONSOLE_STATUS+0x388>
    800049fc:	00004797          	auipc	a5,0x4
    80004a00:	0607ae23          	sw	zero,124(a5) # 80008a78 <pr+0x18>
    80004a04:	00000097          	auipc	ra,0x0
    80004a08:	034080e7          	jalr	52(ra) # 80004a38 <__printf>
    80004a0c:	00048513          	mv	a0,s1
    80004a10:	00000097          	auipc	ra,0x0
    80004a14:	028080e7          	jalr	40(ra) # 80004a38 <__printf>
    80004a18:	00002517          	auipc	a0,0x2
    80004a1c:	96050513          	addi	a0,a0,-1696 # 80006378 <CONSOLE_STATUS+0x368>
    80004a20:	00000097          	auipc	ra,0x0
    80004a24:	018080e7          	jalr	24(ra) # 80004a38 <__printf>
    80004a28:	00100793          	li	a5,1
    80004a2c:	00003717          	auipc	a4,0x3
    80004a30:	d4f72623          	sw	a5,-692(a4) # 80007778 <panicked>
    80004a34:	0000006f          	j	80004a34 <panic+0x58>

0000000080004a38 <__printf>:
    80004a38:	f3010113          	addi	sp,sp,-208
    80004a3c:	08813023          	sd	s0,128(sp)
    80004a40:	07313423          	sd	s3,104(sp)
    80004a44:	09010413          	addi	s0,sp,144
    80004a48:	05813023          	sd	s8,64(sp)
    80004a4c:	08113423          	sd	ra,136(sp)
    80004a50:	06913c23          	sd	s1,120(sp)
    80004a54:	07213823          	sd	s2,112(sp)
    80004a58:	07413023          	sd	s4,96(sp)
    80004a5c:	05513c23          	sd	s5,88(sp)
    80004a60:	05613823          	sd	s6,80(sp)
    80004a64:	05713423          	sd	s7,72(sp)
    80004a68:	03913c23          	sd	s9,56(sp)
    80004a6c:	03a13823          	sd	s10,48(sp)
    80004a70:	03b13423          	sd	s11,40(sp)
    80004a74:	00004317          	auipc	t1,0x4
    80004a78:	fec30313          	addi	t1,t1,-20 # 80008a60 <pr>
    80004a7c:	01832c03          	lw	s8,24(t1)
    80004a80:	00b43423          	sd	a1,8(s0)
    80004a84:	00c43823          	sd	a2,16(s0)
    80004a88:	00d43c23          	sd	a3,24(s0)
    80004a8c:	02e43023          	sd	a4,32(s0)
    80004a90:	02f43423          	sd	a5,40(s0)
    80004a94:	03043823          	sd	a6,48(s0)
    80004a98:	03143c23          	sd	a7,56(s0)
    80004a9c:	00050993          	mv	s3,a0
    80004aa0:	4a0c1663          	bnez	s8,80004f4c <__printf+0x514>
    80004aa4:	60098c63          	beqz	s3,800050bc <__printf+0x684>
    80004aa8:	0009c503          	lbu	a0,0(s3)
    80004aac:	00840793          	addi	a5,s0,8
    80004ab0:	f6f43c23          	sd	a5,-136(s0)
    80004ab4:	00000493          	li	s1,0
    80004ab8:	22050063          	beqz	a0,80004cd8 <__printf+0x2a0>
    80004abc:	00002a37          	lui	s4,0x2
    80004ac0:	00018ab7          	lui	s5,0x18
    80004ac4:	000f4b37          	lui	s6,0xf4
    80004ac8:	00989bb7          	lui	s7,0x989
    80004acc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004ad0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004ad4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004ad8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80004adc:	00148c9b          	addiw	s9,s1,1
    80004ae0:	02500793          	li	a5,37
    80004ae4:	01998933          	add	s2,s3,s9
    80004ae8:	38f51263          	bne	a0,a5,80004e6c <__printf+0x434>
    80004aec:	00094783          	lbu	a5,0(s2)
    80004af0:	00078c9b          	sext.w	s9,a5
    80004af4:	1e078263          	beqz	a5,80004cd8 <__printf+0x2a0>
    80004af8:	0024849b          	addiw	s1,s1,2
    80004afc:	07000713          	li	a4,112
    80004b00:	00998933          	add	s2,s3,s1
    80004b04:	38e78a63          	beq	a5,a4,80004e98 <__printf+0x460>
    80004b08:	20f76863          	bltu	a4,a5,80004d18 <__printf+0x2e0>
    80004b0c:	42a78863          	beq	a5,a0,80004f3c <__printf+0x504>
    80004b10:	06400713          	li	a4,100
    80004b14:	40e79663          	bne	a5,a4,80004f20 <__printf+0x4e8>
    80004b18:	f7843783          	ld	a5,-136(s0)
    80004b1c:	0007a603          	lw	a2,0(a5)
    80004b20:	00878793          	addi	a5,a5,8
    80004b24:	f6f43c23          	sd	a5,-136(s0)
    80004b28:	42064a63          	bltz	a2,80004f5c <__printf+0x524>
    80004b2c:	00a00713          	li	a4,10
    80004b30:	02e677bb          	remuw	a5,a2,a4
    80004b34:	00002d97          	auipc	s11,0x2
    80004b38:	88cd8d93          	addi	s11,s11,-1908 # 800063c0 <digits>
    80004b3c:	00900593          	li	a1,9
    80004b40:	0006051b          	sext.w	a0,a2
    80004b44:	00000c93          	li	s9,0
    80004b48:	02079793          	slli	a5,a5,0x20
    80004b4c:	0207d793          	srli	a5,a5,0x20
    80004b50:	00fd87b3          	add	a5,s11,a5
    80004b54:	0007c783          	lbu	a5,0(a5)
    80004b58:	02e656bb          	divuw	a3,a2,a4
    80004b5c:	f8f40023          	sb	a5,-128(s0)
    80004b60:	14c5d863          	bge	a1,a2,80004cb0 <__printf+0x278>
    80004b64:	06300593          	li	a1,99
    80004b68:	00100c93          	li	s9,1
    80004b6c:	02e6f7bb          	remuw	a5,a3,a4
    80004b70:	02079793          	slli	a5,a5,0x20
    80004b74:	0207d793          	srli	a5,a5,0x20
    80004b78:	00fd87b3          	add	a5,s11,a5
    80004b7c:	0007c783          	lbu	a5,0(a5)
    80004b80:	02e6d73b          	divuw	a4,a3,a4
    80004b84:	f8f400a3          	sb	a5,-127(s0)
    80004b88:	12a5f463          	bgeu	a1,a0,80004cb0 <__printf+0x278>
    80004b8c:	00a00693          	li	a3,10
    80004b90:	00900593          	li	a1,9
    80004b94:	02d777bb          	remuw	a5,a4,a3
    80004b98:	02079793          	slli	a5,a5,0x20
    80004b9c:	0207d793          	srli	a5,a5,0x20
    80004ba0:	00fd87b3          	add	a5,s11,a5
    80004ba4:	0007c503          	lbu	a0,0(a5)
    80004ba8:	02d757bb          	divuw	a5,a4,a3
    80004bac:	f8a40123          	sb	a0,-126(s0)
    80004bb0:	48e5f263          	bgeu	a1,a4,80005034 <__printf+0x5fc>
    80004bb4:	06300513          	li	a0,99
    80004bb8:	02d7f5bb          	remuw	a1,a5,a3
    80004bbc:	02059593          	slli	a1,a1,0x20
    80004bc0:	0205d593          	srli	a1,a1,0x20
    80004bc4:	00bd85b3          	add	a1,s11,a1
    80004bc8:	0005c583          	lbu	a1,0(a1)
    80004bcc:	02d7d7bb          	divuw	a5,a5,a3
    80004bd0:	f8b401a3          	sb	a1,-125(s0)
    80004bd4:	48e57263          	bgeu	a0,a4,80005058 <__printf+0x620>
    80004bd8:	3e700513          	li	a0,999
    80004bdc:	02d7f5bb          	remuw	a1,a5,a3
    80004be0:	02059593          	slli	a1,a1,0x20
    80004be4:	0205d593          	srli	a1,a1,0x20
    80004be8:	00bd85b3          	add	a1,s11,a1
    80004bec:	0005c583          	lbu	a1,0(a1)
    80004bf0:	02d7d7bb          	divuw	a5,a5,a3
    80004bf4:	f8b40223          	sb	a1,-124(s0)
    80004bf8:	46e57663          	bgeu	a0,a4,80005064 <__printf+0x62c>
    80004bfc:	02d7f5bb          	remuw	a1,a5,a3
    80004c00:	02059593          	slli	a1,a1,0x20
    80004c04:	0205d593          	srli	a1,a1,0x20
    80004c08:	00bd85b3          	add	a1,s11,a1
    80004c0c:	0005c583          	lbu	a1,0(a1)
    80004c10:	02d7d7bb          	divuw	a5,a5,a3
    80004c14:	f8b402a3          	sb	a1,-123(s0)
    80004c18:	46ea7863          	bgeu	s4,a4,80005088 <__printf+0x650>
    80004c1c:	02d7f5bb          	remuw	a1,a5,a3
    80004c20:	02059593          	slli	a1,a1,0x20
    80004c24:	0205d593          	srli	a1,a1,0x20
    80004c28:	00bd85b3          	add	a1,s11,a1
    80004c2c:	0005c583          	lbu	a1,0(a1)
    80004c30:	02d7d7bb          	divuw	a5,a5,a3
    80004c34:	f8b40323          	sb	a1,-122(s0)
    80004c38:	3eeaf863          	bgeu	s5,a4,80005028 <__printf+0x5f0>
    80004c3c:	02d7f5bb          	remuw	a1,a5,a3
    80004c40:	02059593          	slli	a1,a1,0x20
    80004c44:	0205d593          	srli	a1,a1,0x20
    80004c48:	00bd85b3          	add	a1,s11,a1
    80004c4c:	0005c583          	lbu	a1,0(a1)
    80004c50:	02d7d7bb          	divuw	a5,a5,a3
    80004c54:	f8b403a3          	sb	a1,-121(s0)
    80004c58:	42eb7e63          	bgeu	s6,a4,80005094 <__printf+0x65c>
    80004c5c:	02d7f5bb          	remuw	a1,a5,a3
    80004c60:	02059593          	slli	a1,a1,0x20
    80004c64:	0205d593          	srli	a1,a1,0x20
    80004c68:	00bd85b3          	add	a1,s11,a1
    80004c6c:	0005c583          	lbu	a1,0(a1)
    80004c70:	02d7d7bb          	divuw	a5,a5,a3
    80004c74:	f8b40423          	sb	a1,-120(s0)
    80004c78:	42ebfc63          	bgeu	s7,a4,800050b0 <__printf+0x678>
    80004c7c:	02079793          	slli	a5,a5,0x20
    80004c80:	0207d793          	srli	a5,a5,0x20
    80004c84:	00fd8db3          	add	s11,s11,a5
    80004c88:	000dc703          	lbu	a4,0(s11)
    80004c8c:	00a00793          	li	a5,10
    80004c90:	00900c93          	li	s9,9
    80004c94:	f8e404a3          	sb	a4,-119(s0)
    80004c98:	00065c63          	bgez	a2,80004cb0 <__printf+0x278>
    80004c9c:	f9040713          	addi	a4,s0,-112
    80004ca0:	00f70733          	add	a4,a4,a5
    80004ca4:	02d00693          	li	a3,45
    80004ca8:	fed70823          	sb	a3,-16(a4)
    80004cac:	00078c93          	mv	s9,a5
    80004cb0:	f8040793          	addi	a5,s0,-128
    80004cb4:	01978cb3          	add	s9,a5,s9
    80004cb8:	f7f40d13          	addi	s10,s0,-129
    80004cbc:	000cc503          	lbu	a0,0(s9)
    80004cc0:	fffc8c93          	addi	s9,s9,-1
    80004cc4:	00000097          	auipc	ra,0x0
    80004cc8:	b90080e7          	jalr	-1136(ra) # 80004854 <consputc>
    80004ccc:	ffac98e3          	bne	s9,s10,80004cbc <__printf+0x284>
    80004cd0:	00094503          	lbu	a0,0(s2)
    80004cd4:	e00514e3          	bnez	a0,80004adc <__printf+0xa4>
    80004cd8:	1a0c1663          	bnez	s8,80004e84 <__printf+0x44c>
    80004cdc:	08813083          	ld	ra,136(sp)
    80004ce0:	08013403          	ld	s0,128(sp)
    80004ce4:	07813483          	ld	s1,120(sp)
    80004ce8:	07013903          	ld	s2,112(sp)
    80004cec:	06813983          	ld	s3,104(sp)
    80004cf0:	06013a03          	ld	s4,96(sp)
    80004cf4:	05813a83          	ld	s5,88(sp)
    80004cf8:	05013b03          	ld	s6,80(sp)
    80004cfc:	04813b83          	ld	s7,72(sp)
    80004d00:	04013c03          	ld	s8,64(sp)
    80004d04:	03813c83          	ld	s9,56(sp)
    80004d08:	03013d03          	ld	s10,48(sp)
    80004d0c:	02813d83          	ld	s11,40(sp)
    80004d10:	0d010113          	addi	sp,sp,208
    80004d14:	00008067          	ret
    80004d18:	07300713          	li	a4,115
    80004d1c:	1ce78a63          	beq	a5,a4,80004ef0 <__printf+0x4b8>
    80004d20:	07800713          	li	a4,120
    80004d24:	1ee79e63          	bne	a5,a4,80004f20 <__printf+0x4e8>
    80004d28:	f7843783          	ld	a5,-136(s0)
    80004d2c:	0007a703          	lw	a4,0(a5)
    80004d30:	00878793          	addi	a5,a5,8
    80004d34:	f6f43c23          	sd	a5,-136(s0)
    80004d38:	28074263          	bltz	a4,80004fbc <__printf+0x584>
    80004d3c:	00001d97          	auipc	s11,0x1
    80004d40:	684d8d93          	addi	s11,s11,1668 # 800063c0 <digits>
    80004d44:	00f77793          	andi	a5,a4,15
    80004d48:	00fd87b3          	add	a5,s11,a5
    80004d4c:	0007c683          	lbu	a3,0(a5)
    80004d50:	00f00613          	li	a2,15
    80004d54:	0007079b          	sext.w	a5,a4
    80004d58:	f8d40023          	sb	a3,-128(s0)
    80004d5c:	0047559b          	srliw	a1,a4,0x4
    80004d60:	0047569b          	srliw	a3,a4,0x4
    80004d64:	00000c93          	li	s9,0
    80004d68:	0ee65063          	bge	a2,a4,80004e48 <__printf+0x410>
    80004d6c:	00f6f693          	andi	a3,a3,15
    80004d70:	00dd86b3          	add	a3,s11,a3
    80004d74:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004d78:	0087d79b          	srliw	a5,a5,0x8
    80004d7c:	00100c93          	li	s9,1
    80004d80:	f8d400a3          	sb	a3,-127(s0)
    80004d84:	0cb67263          	bgeu	a2,a1,80004e48 <__printf+0x410>
    80004d88:	00f7f693          	andi	a3,a5,15
    80004d8c:	00dd86b3          	add	a3,s11,a3
    80004d90:	0006c583          	lbu	a1,0(a3)
    80004d94:	00f00613          	li	a2,15
    80004d98:	0047d69b          	srliw	a3,a5,0x4
    80004d9c:	f8b40123          	sb	a1,-126(s0)
    80004da0:	0047d593          	srli	a1,a5,0x4
    80004da4:	28f67e63          	bgeu	a2,a5,80005040 <__printf+0x608>
    80004da8:	00f6f693          	andi	a3,a3,15
    80004dac:	00dd86b3          	add	a3,s11,a3
    80004db0:	0006c503          	lbu	a0,0(a3)
    80004db4:	0087d813          	srli	a6,a5,0x8
    80004db8:	0087d69b          	srliw	a3,a5,0x8
    80004dbc:	f8a401a3          	sb	a0,-125(s0)
    80004dc0:	28b67663          	bgeu	a2,a1,8000504c <__printf+0x614>
    80004dc4:	00f6f693          	andi	a3,a3,15
    80004dc8:	00dd86b3          	add	a3,s11,a3
    80004dcc:	0006c583          	lbu	a1,0(a3)
    80004dd0:	00c7d513          	srli	a0,a5,0xc
    80004dd4:	00c7d69b          	srliw	a3,a5,0xc
    80004dd8:	f8b40223          	sb	a1,-124(s0)
    80004ddc:	29067a63          	bgeu	a2,a6,80005070 <__printf+0x638>
    80004de0:	00f6f693          	andi	a3,a3,15
    80004de4:	00dd86b3          	add	a3,s11,a3
    80004de8:	0006c583          	lbu	a1,0(a3)
    80004dec:	0107d813          	srli	a6,a5,0x10
    80004df0:	0107d69b          	srliw	a3,a5,0x10
    80004df4:	f8b402a3          	sb	a1,-123(s0)
    80004df8:	28a67263          	bgeu	a2,a0,8000507c <__printf+0x644>
    80004dfc:	00f6f693          	andi	a3,a3,15
    80004e00:	00dd86b3          	add	a3,s11,a3
    80004e04:	0006c683          	lbu	a3,0(a3)
    80004e08:	0147d79b          	srliw	a5,a5,0x14
    80004e0c:	f8d40323          	sb	a3,-122(s0)
    80004e10:	21067663          	bgeu	a2,a6,8000501c <__printf+0x5e4>
    80004e14:	02079793          	slli	a5,a5,0x20
    80004e18:	0207d793          	srli	a5,a5,0x20
    80004e1c:	00fd8db3          	add	s11,s11,a5
    80004e20:	000dc683          	lbu	a3,0(s11)
    80004e24:	00800793          	li	a5,8
    80004e28:	00700c93          	li	s9,7
    80004e2c:	f8d403a3          	sb	a3,-121(s0)
    80004e30:	00075c63          	bgez	a4,80004e48 <__printf+0x410>
    80004e34:	f9040713          	addi	a4,s0,-112
    80004e38:	00f70733          	add	a4,a4,a5
    80004e3c:	02d00693          	li	a3,45
    80004e40:	fed70823          	sb	a3,-16(a4)
    80004e44:	00078c93          	mv	s9,a5
    80004e48:	f8040793          	addi	a5,s0,-128
    80004e4c:	01978cb3          	add	s9,a5,s9
    80004e50:	f7f40d13          	addi	s10,s0,-129
    80004e54:	000cc503          	lbu	a0,0(s9)
    80004e58:	fffc8c93          	addi	s9,s9,-1
    80004e5c:	00000097          	auipc	ra,0x0
    80004e60:	9f8080e7          	jalr	-1544(ra) # 80004854 <consputc>
    80004e64:	ff9d18e3          	bne	s10,s9,80004e54 <__printf+0x41c>
    80004e68:	0100006f          	j	80004e78 <__printf+0x440>
    80004e6c:	00000097          	auipc	ra,0x0
    80004e70:	9e8080e7          	jalr	-1560(ra) # 80004854 <consputc>
    80004e74:	000c8493          	mv	s1,s9
    80004e78:	00094503          	lbu	a0,0(s2)
    80004e7c:	c60510e3          	bnez	a0,80004adc <__printf+0xa4>
    80004e80:	e40c0ee3          	beqz	s8,80004cdc <__printf+0x2a4>
    80004e84:	00004517          	auipc	a0,0x4
    80004e88:	bdc50513          	addi	a0,a0,-1060 # 80008a60 <pr>
    80004e8c:	00001097          	auipc	ra,0x1
    80004e90:	94c080e7          	jalr	-1716(ra) # 800057d8 <release>
    80004e94:	e49ff06f          	j	80004cdc <__printf+0x2a4>
    80004e98:	f7843783          	ld	a5,-136(s0)
    80004e9c:	03000513          	li	a0,48
    80004ea0:	01000d13          	li	s10,16
    80004ea4:	00878713          	addi	a4,a5,8
    80004ea8:	0007bc83          	ld	s9,0(a5)
    80004eac:	f6e43c23          	sd	a4,-136(s0)
    80004eb0:	00000097          	auipc	ra,0x0
    80004eb4:	9a4080e7          	jalr	-1628(ra) # 80004854 <consputc>
    80004eb8:	07800513          	li	a0,120
    80004ebc:	00000097          	auipc	ra,0x0
    80004ec0:	998080e7          	jalr	-1640(ra) # 80004854 <consputc>
    80004ec4:	00001d97          	auipc	s11,0x1
    80004ec8:	4fcd8d93          	addi	s11,s11,1276 # 800063c0 <digits>
    80004ecc:	03ccd793          	srli	a5,s9,0x3c
    80004ed0:	00fd87b3          	add	a5,s11,a5
    80004ed4:	0007c503          	lbu	a0,0(a5)
    80004ed8:	fffd0d1b          	addiw	s10,s10,-1
    80004edc:	004c9c93          	slli	s9,s9,0x4
    80004ee0:	00000097          	auipc	ra,0x0
    80004ee4:	974080e7          	jalr	-1676(ra) # 80004854 <consputc>
    80004ee8:	fe0d12e3          	bnez	s10,80004ecc <__printf+0x494>
    80004eec:	f8dff06f          	j	80004e78 <__printf+0x440>
    80004ef0:	f7843783          	ld	a5,-136(s0)
    80004ef4:	0007bc83          	ld	s9,0(a5)
    80004ef8:	00878793          	addi	a5,a5,8
    80004efc:	f6f43c23          	sd	a5,-136(s0)
    80004f00:	000c9a63          	bnez	s9,80004f14 <__printf+0x4dc>
    80004f04:	1080006f          	j	8000500c <__printf+0x5d4>
    80004f08:	001c8c93          	addi	s9,s9,1
    80004f0c:	00000097          	auipc	ra,0x0
    80004f10:	948080e7          	jalr	-1720(ra) # 80004854 <consputc>
    80004f14:	000cc503          	lbu	a0,0(s9)
    80004f18:	fe0518e3          	bnez	a0,80004f08 <__printf+0x4d0>
    80004f1c:	f5dff06f          	j	80004e78 <__printf+0x440>
    80004f20:	02500513          	li	a0,37
    80004f24:	00000097          	auipc	ra,0x0
    80004f28:	930080e7          	jalr	-1744(ra) # 80004854 <consputc>
    80004f2c:	000c8513          	mv	a0,s9
    80004f30:	00000097          	auipc	ra,0x0
    80004f34:	924080e7          	jalr	-1756(ra) # 80004854 <consputc>
    80004f38:	f41ff06f          	j	80004e78 <__printf+0x440>
    80004f3c:	02500513          	li	a0,37
    80004f40:	00000097          	auipc	ra,0x0
    80004f44:	914080e7          	jalr	-1772(ra) # 80004854 <consputc>
    80004f48:	f31ff06f          	j	80004e78 <__printf+0x440>
    80004f4c:	00030513          	mv	a0,t1
    80004f50:	00000097          	auipc	ra,0x0
    80004f54:	7bc080e7          	jalr	1980(ra) # 8000570c <acquire>
    80004f58:	b4dff06f          	j	80004aa4 <__printf+0x6c>
    80004f5c:	40c0053b          	negw	a0,a2
    80004f60:	00a00713          	li	a4,10
    80004f64:	02e576bb          	remuw	a3,a0,a4
    80004f68:	00001d97          	auipc	s11,0x1
    80004f6c:	458d8d93          	addi	s11,s11,1112 # 800063c0 <digits>
    80004f70:	ff700593          	li	a1,-9
    80004f74:	02069693          	slli	a3,a3,0x20
    80004f78:	0206d693          	srli	a3,a3,0x20
    80004f7c:	00dd86b3          	add	a3,s11,a3
    80004f80:	0006c683          	lbu	a3,0(a3)
    80004f84:	02e557bb          	divuw	a5,a0,a4
    80004f88:	f8d40023          	sb	a3,-128(s0)
    80004f8c:	10b65e63          	bge	a2,a1,800050a8 <__printf+0x670>
    80004f90:	06300593          	li	a1,99
    80004f94:	02e7f6bb          	remuw	a3,a5,a4
    80004f98:	02069693          	slli	a3,a3,0x20
    80004f9c:	0206d693          	srli	a3,a3,0x20
    80004fa0:	00dd86b3          	add	a3,s11,a3
    80004fa4:	0006c683          	lbu	a3,0(a3)
    80004fa8:	02e7d73b          	divuw	a4,a5,a4
    80004fac:	00200793          	li	a5,2
    80004fb0:	f8d400a3          	sb	a3,-127(s0)
    80004fb4:	bca5ece3          	bltu	a1,a0,80004b8c <__printf+0x154>
    80004fb8:	ce5ff06f          	j	80004c9c <__printf+0x264>
    80004fbc:	40e007bb          	negw	a5,a4
    80004fc0:	00001d97          	auipc	s11,0x1
    80004fc4:	400d8d93          	addi	s11,s11,1024 # 800063c0 <digits>
    80004fc8:	00f7f693          	andi	a3,a5,15
    80004fcc:	00dd86b3          	add	a3,s11,a3
    80004fd0:	0006c583          	lbu	a1,0(a3)
    80004fd4:	ff100613          	li	a2,-15
    80004fd8:	0047d69b          	srliw	a3,a5,0x4
    80004fdc:	f8b40023          	sb	a1,-128(s0)
    80004fe0:	0047d59b          	srliw	a1,a5,0x4
    80004fe4:	0ac75e63          	bge	a4,a2,800050a0 <__printf+0x668>
    80004fe8:	00f6f693          	andi	a3,a3,15
    80004fec:	00dd86b3          	add	a3,s11,a3
    80004ff0:	0006c603          	lbu	a2,0(a3)
    80004ff4:	00f00693          	li	a3,15
    80004ff8:	0087d79b          	srliw	a5,a5,0x8
    80004ffc:	f8c400a3          	sb	a2,-127(s0)
    80005000:	d8b6e4e3          	bltu	a3,a1,80004d88 <__printf+0x350>
    80005004:	00200793          	li	a5,2
    80005008:	e2dff06f          	j	80004e34 <__printf+0x3fc>
    8000500c:	00001c97          	auipc	s9,0x1
    80005010:	394c8c93          	addi	s9,s9,916 # 800063a0 <CONSOLE_STATUS+0x390>
    80005014:	02800513          	li	a0,40
    80005018:	ef1ff06f          	j	80004f08 <__printf+0x4d0>
    8000501c:	00700793          	li	a5,7
    80005020:	00600c93          	li	s9,6
    80005024:	e0dff06f          	j	80004e30 <__printf+0x3f8>
    80005028:	00700793          	li	a5,7
    8000502c:	00600c93          	li	s9,6
    80005030:	c69ff06f          	j	80004c98 <__printf+0x260>
    80005034:	00300793          	li	a5,3
    80005038:	00200c93          	li	s9,2
    8000503c:	c5dff06f          	j	80004c98 <__printf+0x260>
    80005040:	00300793          	li	a5,3
    80005044:	00200c93          	li	s9,2
    80005048:	de9ff06f          	j	80004e30 <__printf+0x3f8>
    8000504c:	00400793          	li	a5,4
    80005050:	00300c93          	li	s9,3
    80005054:	dddff06f          	j	80004e30 <__printf+0x3f8>
    80005058:	00400793          	li	a5,4
    8000505c:	00300c93          	li	s9,3
    80005060:	c39ff06f          	j	80004c98 <__printf+0x260>
    80005064:	00500793          	li	a5,5
    80005068:	00400c93          	li	s9,4
    8000506c:	c2dff06f          	j	80004c98 <__printf+0x260>
    80005070:	00500793          	li	a5,5
    80005074:	00400c93          	li	s9,4
    80005078:	db9ff06f          	j	80004e30 <__printf+0x3f8>
    8000507c:	00600793          	li	a5,6
    80005080:	00500c93          	li	s9,5
    80005084:	dadff06f          	j	80004e30 <__printf+0x3f8>
    80005088:	00600793          	li	a5,6
    8000508c:	00500c93          	li	s9,5
    80005090:	c09ff06f          	j	80004c98 <__printf+0x260>
    80005094:	00800793          	li	a5,8
    80005098:	00700c93          	li	s9,7
    8000509c:	bfdff06f          	j	80004c98 <__printf+0x260>
    800050a0:	00100793          	li	a5,1
    800050a4:	d91ff06f          	j	80004e34 <__printf+0x3fc>
    800050a8:	00100793          	li	a5,1
    800050ac:	bf1ff06f          	j	80004c9c <__printf+0x264>
    800050b0:	00900793          	li	a5,9
    800050b4:	00800c93          	li	s9,8
    800050b8:	be1ff06f          	j	80004c98 <__printf+0x260>
    800050bc:	00001517          	auipc	a0,0x1
    800050c0:	2ec50513          	addi	a0,a0,748 # 800063a8 <CONSOLE_STATUS+0x398>
    800050c4:	00000097          	auipc	ra,0x0
    800050c8:	918080e7          	jalr	-1768(ra) # 800049dc <panic>

00000000800050cc <printfinit>:
    800050cc:	fe010113          	addi	sp,sp,-32
    800050d0:	00813823          	sd	s0,16(sp)
    800050d4:	00913423          	sd	s1,8(sp)
    800050d8:	00113c23          	sd	ra,24(sp)
    800050dc:	02010413          	addi	s0,sp,32
    800050e0:	00004497          	auipc	s1,0x4
    800050e4:	98048493          	addi	s1,s1,-1664 # 80008a60 <pr>
    800050e8:	00048513          	mv	a0,s1
    800050ec:	00001597          	auipc	a1,0x1
    800050f0:	2cc58593          	addi	a1,a1,716 # 800063b8 <CONSOLE_STATUS+0x3a8>
    800050f4:	00000097          	auipc	ra,0x0
    800050f8:	5f4080e7          	jalr	1524(ra) # 800056e8 <initlock>
    800050fc:	01813083          	ld	ra,24(sp)
    80005100:	01013403          	ld	s0,16(sp)
    80005104:	0004ac23          	sw	zero,24(s1)
    80005108:	00813483          	ld	s1,8(sp)
    8000510c:	02010113          	addi	sp,sp,32
    80005110:	00008067          	ret

0000000080005114 <uartinit>:
    80005114:	ff010113          	addi	sp,sp,-16
    80005118:	00813423          	sd	s0,8(sp)
    8000511c:	01010413          	addi	s0,sp,16
    80005120:	100007b7          	lui	a5,0x10000
    80005124:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005128:	f8000713          	li	a4,-128
    8000512c:	00e781a3          	sb	a4,3(a5)
    80005130:	00300713          	li	a4,3
    80005134:	00e78023          	sb	a4,0(a5)
    80005138:	000780a3          	sb	zero,1(a5)
    8000513c:	00e781a3          	sb	a4,3(a5)
    80005140:	00700693          	li	a3,7
    80005144:	00d78123          	sb	a3,2(a5)
    80005148:	00e780a3          	sb	a4,1(a5)
    8000514c:	00813403          	ld	s0,8(sp)
    80005150:	01010113          	addi	sp,sp,16
    80005154:	00008067          	ret

0000000080005158 <uartputc>:
    80005158:	00002797          	auipc	a5,0x2
    8000515c:	6207a783          	lw	a5,1568(a5) # 80007778 <panicked>
    80005160:	00078463          	beqz	a5,80005168 <uartputc+0x10>
    80005164:	0000006f          	j	80005164 <uartputc+0xc>
    80005168:	fd010113          	addi	sp,sp,-48
    8000516c:	02813023          	sd	s0,32(sp)
    80005170:	00913c23          	sd	s1,24(sp)
    80005174:	01213823          	sd	s2,16(sp)
    80005178:	01313423          	sd	s3,8(sp)
    8000517c:	02113423          	sd	ra,40(sp)
    80005180:	03010413          	addi	s0,sp,48
    80005184:	00002917          	auipc	s2,0x2
    80005188:	5fc90913          	addi	s2,s2,1532 # 80007780 <uart_tx_r>
    8000518c:	00093783          	ld	a5,0(s2)
    80005190:	00002497          	auipc	s1,0x2
    80005194:	5f848493          	addi	s1,s1,1528 # 80007788 <uart_tx_w>
    80005198:	0004b703          	ld	a4,0(s1)
    8000519c:	02078693          	addi	a3,a5,32
    800051a0:	00050993          	mv	s3,a0
    800051a4:	02e69c63          	bne	a3,a4,800051dc <uartputc+0x84>
    800051a8:	00001097          	auipc	ra,0x1
    800051ac:	834080e7          	jalr	-1996(ra) # 800059dc <push_on>
    800051b0:	00093783          	ld	a5,0(s2)
    800051b4:	0004b703          	ld	a4,0(s1)
    800051b8:	02078793          	addi	a5,a5,32
    800051bc:	00e79463          	bne	a5,a4,800051c4 <uartputc+0x6c>
    800051c0:	0000006f          	j	800051c0 <uartputc+0x68>
    800051c4:	00001097          	auipc	ra,0x1
    800051c8:	88c080e7          	jalr	-1908(ra) # 80005a50 <pop_on>
    800051cc:	00093783          	ld	a5,0(s2)
    800051d0:	0004b703          	ld	a4,0(s1)
    800051d4:	02078693          	addi	a3,a5,32
    800051d8:	fce688e3          	beq	a3,a4,800051a8 <uartputc+0x50>
    800051dc:	01f77693          	andi	a3,a4,31
    800051e0:	00004597          	auipc	a1,0x4
    800051e4:	8a058593          	addi	a1,a1,-1888 # 80008a80 <uart_tx_buf>
    800051e8:	00d586b3          	add	a3,a1,a3
    800051ec:	00170713          	addi	a4,a4,1
    800051f0:	01368023          	sb	s3,0(a3)
    800051f4:	00e4b023          	sd	a4,0(s1)
    800051f8:	10000637          	lui	a2,0x10000
    800051fc:	02f71063          	bne	a4,a5,8000521c <uartputc+0xc4>
    80005200:	0340006f          	j	80005234 <uartputc+0xdc>
    80005204:	00074703          	lbu	a4,0(a4)
    80005208:	00f93023          	sd	a5,0(s2)
    8000520c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005210:	00093783          	ld	a5,0(s2)
    80005214:	0004b703          	ld	a4,0(s1)
    80005218:	00f70e63          	beq	a4,a5,80005234 <uartputc+0xdc>
    8000521c:	00564683          	lbu	a3,5(a2)
    80005220:	01f7f713          	andi	a4,a5,31
    80005224:	00e58733          	add	a4,a1,a4
    80005228:	0206f693          	andi	a3,a3,32
    8000522c:	00178793          	addi	a5,a5,1
    80005230:	fc069ae3          	bnez	a3,80005204 <uartputc+0xac>
    80005234:	02813083          	ld	ra,40(sp)
    80005238:	02013403          	ld	s0,32(sp)
    8000523c:	01813483          	ld	s1,24(sp)
    80005240:	01013903          	ld	s2,16(sp)
    80005244:	00813983          	ld	s3,8(sp)
    80005248:	03010113          	addi	sp,sp,48
    8000524c:	00008067          	ret

0000000080005250 <uartputc_sync>:
    80005250:	ff010113          	addi	sp,sp,-16
    80005254:	00813423          	sd	s0,8(sp)
    80005258:	01010413          	addi	s0,sp,16
    8000525c:	00002717          	auipc	a4,0x2
    80005260:	51c72703          	lw	a4,1308(a4) # 80007778 <panicked>
    80005264:	02071663          	bnez	a4,80005290 <uartputc_sync+0x40>
    80005268:	00050793          	mv	a5,a0
    8000526c:	100006b7          	lui	a3,0x10000
    80005270:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005274:	02077713          	andi	a4,a4,32
    80005278:	fe070ce3          	beqz	a4,80005270 <uartputc_sync+0x20>
    8000527c:	0ff7f793          	andi	a5,a5,255
    80005280:	00f68023          	sb	a5,0(a3)
    80005284:	00813403          	ld	s0,8(sp)
    80005288:	01010113          	addi	sp,sp,16
    8000528c:	00008067          	ret
    80005290:	0000006f          	j	80005290 <uartputc_sync+0x40>

0000000080005294 <uartstart>:
    80005294:	ff010113          	addi	sp,sp,-16
    80005298:	00813423          	sd	s0,8(sp)
    8000529c:	01010413          	addi	s0,sp,16
    800052a0:	00002617          	auipc	a2,0x2
    800052a4:	4e060613          	addi	a2,a2,1248 # 80007780 <uart_tx_r>
    800052a8:	00002517          	auipc	a0,0x2
    800052ac:	4e050513          	addi	a0,a0,1248 # 80007788 <uart_tx_w>
    800052b0:	00063783          	ld	a5,0(a2)
    800052b4:	00053703          	ld	a4,0(a0)
    800052b8:	04f70263          	beq	a4,a5,800052fc <uartstart+0x68>
    800052bc:	100005b7          	lui	a1,0x10000
    800052c0:	00003817          	auipc	a6,0x3
    800052c4:	7c080813          	addi	a6,a6,1984 # 80008a80 <uart_tx_buf>
    800052c8:	01c0006f          	j	800052e4 <uartstart+0x50>
    800052cc:	0006c703          	lbu	a4,0(a3)
    800052d0:	00f63023          	sd	a5,0(a2)
    800052d4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800052d8:	00063783          	ld	a5,0(a2)
    800052dc:	00053703          	ld	a4,0(a0)
    800052e0:	00f70e63          	beq	a4,a5,800052fc <uartstart+0x68>
    800052e4:	01f7f713          	andi	a4,a5,31
    800052e8:	00e806b3          	add	a3,a6,a4
    800052ec:	0055c703          	lbu	a4,5(a1)
    800052f0:	00178793          	addi	a5,a5,1
    800052f4:	02077713          	andi	a4,a4,32
    800052f8:	fc071ae3          	bnez	a4,800052cc <uartstart+0x38>
    800052fc:	00813403          	ld	s0,8(sp)
    80005300:	01010113          	addi	sp,sp,16
    80005304:	00008067          	ret

0000000080005308 <uartgetc>:
    80005308:	ff010113          	addi	sp,sp,-16
    8000530c:	00813423          	sd	s0,8(sp)
    80005310:	01010413          	addi	s0,sp,16
    80005314:	10000737          	lui	a4,0x10000
    80005318:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000531c:	0017f793          	andi	a5,a5,1
    80005320:	00078c63          	beqz	a5,80005338 <uartgetc+0x30>
    80005324:	00074503          	lbu	a0,0(a4)
    80005328:	0ff57513          	andi	a0,a0,255
    8000532c:	00813403          	ld	s0,8(sp)
    80005330:	01010113          	addi	sp,sp,16
    80005334:	00008067          	ret
    80005338:	fff00513          	li	a0,-1
    8000533c:	ff1ff06f          	j	8000532c <uartgetc+0x24>

0000000080005340 <uartintr>:
    80005340:	100007b7          	lui	a5,0x10000
    80005344:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005348:	0017f793          	andi	a5,a5,1
    8000534c:	0a078463          	beqz	a5,800053f4 <uartintr+0xb4>
    80005350:	fe010113          	addi	sp,sp,-32
    80005354:	00813823          	sd	s0,16(sp)
    80005358:	00913423          	sd	s1,8(sp)
    8000535c:	00113c23          	sd	ra,24(sp)
    80005360:	02010413          	addi	s0,sp,32
    80005364:	100004b7          	lui	s1,0x10000
    80005368:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000536c:	0ff57513          	andi	a0,a0,255
    80005370:	fffff097          	auipc	ra,0xfffff
    80005374:	534080e7          	jalr	1332(ra) # 800048a4 <consoleintr>
    80005378:	0054c783          	lbu	a5,5(s1)
    8000537c:	0017f793          	andi	a5,a5,1
    80005380:	fe0794e3          	bnez	a5,80005368 <uartintr+0x28>
    80005384:	00002617          	auipc	a2,0x2
    80005388:	3fc60613          	addi	a2,a2,1020 # 80007780 <uart_tx_r>
    8000538c:	00002517          	auipc	a0,0x2
    80005390:	3fc50513          	addi	a0,a0,1020 # 80007788 <uart_tx_w>
    80005394:	00063783          	ld	a5,0(a2)
    80005398:	00053703          	ld	a4,0(a0)
    8000539c:	04f70263          	beq	a4,a5,800053e0 <uartintr+0xa0>
    800053a0:	100005b7          	lui	a1,0x10000
    800053a4:	00003817          	auipc	a6,0x3
    800053a8:	6dc80813          	addi	a6,a6,1756 # 80008a80 <uart_tx_buf>
    800053ac:	01c0006f          	j	800053c8 <uartintr+0x88>
    800053b0:	0006c703          	lbu	a4,0(a3)
    800053b4:	00f63023          	sd	a5,0(a2)
    800053b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800053bc:	00063783          	ld	a5,0(a2)
    800053c0:	00053703          	ld	a4,0(a0)
    800053c4:	00f70e63          	beq	a4,a5,800053e0 <uartintr+0xa0>
    800053c8:	01f7f713          	andi	a4,a5,31
    800053cc:	00e806b3          	add	a3,a6,a4
    800053d0:	0055c703          	lbu	a4,5(a1)
    800053d4:	00178793          	addi	a5,a5,1
    800053d8:	02077713          	andi	a4,a4,32
    800053dc:	fc071ae3          	bnez	a4,800053b0 <uartintr+0x70>
    800053e0:	01813083          	ld	ra,24(sp)
    800053e4:	01013403          	ld	s0,16(sp)
    800053e8:	00813483          	ld	s1,8(sp)
    800053ec:	02010113          	addi	sp,sp,32
    800053f0:	00008067          	ret
    800053f4:	00002617          	auipc	a2,0x2
    800053f8:	38c60613          	addi	a2,a2,908 # 80007780 <uart_tx_r>
    800053fc:	00002517          	auipc	a0,0x2
    80005400:	38c50513          	addi	a0,a0,908 # 80007788 <uart_tx_w>
    80005404:	00063783          	ld	a5,0(a2)
    80005408:	00053703          	ld	a4,0(a0)
    8000540c:	04f70263          	beq	a4,a5,80005450 <uartintr+0x110>
    80005410:	100005b7          	lui	a1,0x10000
    80005414:	00003817          	auipc	a6,0x3
    80005418:	66c80813          	addi	a6,a6,1644 # 80008a80 <uart_tx_buf>
    8000541c:	01c0006f          	j	80005438 <uartintr+0xf8>
    80005420:	0006c703          	lbu	a4,0(a3)
    80005424:	00f63023          	sd	a5,0(a2)
    80005428:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000542c:	00063783          	ld	a5,0(a2)
    80005430:	00053703          	ld	a4,0(a0)
    80005434:	02f70063          	beq	a4,a5,80005454 <uartintr+0x114>
    80005438:	01f7f713          	andi	a4,a5,31
    8000543c:	00e806b3          	add	a3,a6,a4
    80005440:	0055c703          	lbu	a4,5(a1)
    80005444:	00178793          	addi	a5,a5,1
    80005448:	02077713          	andi	a4,a4,32
    8000544c:	fc071ae3          	bnez	a4,80005420 <uartintr+0xe0>
    80005450:	00008067          	ret
    80005454:	00008067          	ret

0000000080005458 <kinit>:
    80005458:	fc010113          	addi	sp,sp,-64
    8000545c:	02913423          	sd	s1,40(sp)
    80005460:	fffff7b7          	lui	a5,0xfffff
    80005464:	00004497          	auipc	s1,0x4
    80005468:	63b48493          	addi	s1,s1,1595 # 80009a9f <end+0xfff>
    8000546c:	02813823          	sd	s0,48(sp)
    80005470:	01313c23          	sd	s3,24(sp)
    80005474:	00f4f4b3          	and	s1,s1,a5
    80005478:	02113c23          	sd	ra,56(sp)
    8000547c:	03213023          	sd	s2,32(sp)
    80005480:	01413823          	sd	s4,16(sp)
    80005484:	01513423          	sd	s5,8(sp)
    80005488:	04010413          	addi	s0,sp,64
    8000548c:	000017b7          	lui	a5,0x1
    80005490:	01100993          	li	s3,17
    80005494:	00f487b3          	add	a5,s1,a5
    80005498:	01b99993          	slli	s3,s3,0x1b
    8000549c:	06f9e063          	bltu	s3,a5,800054fc <kinit+0xa4>
    800054a0:	00003a97          	auipc	s5,0x3
    800054a4:	600a8a93          	addi	s5,s5,1536 # 80008aa0 <end>
    800054a8:	0754ec63          	bltu	s1,s5,80005520 <kinit+0xc8>
    800054ac:	0734fa63          	bgeu	s1,s3,80005520 <kinit+0xc8>
    800054b0:	00088a37          	lui	s4,0x88
    800054b4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800054b8:	00002917          	auipc	s2,0x2
    800054bc:	2d890913          	addi	s2,s2,728 # 80007790 <kmem>
    800054c0:	00ca1a13          	slli	s4,s4,0xc
    800054c4:	0140006f          	j	800054d8 <kinit+0x80>
    800054c8:	000017b7          	lui	a5,0x1
    800054cc:	00f484b3          	add	s1,s1,a5
    800054d0:	0554e863          	bltu	s1,s5,80005520 <kinit+0xc8>
    800054d4:	0534f663          	bgeu	s1,s3,80005520 <kinit+0xc8>
    800054d8:	00001637          	lui	a2,0x1
    800054dc:	00100593          	li	a1,1
    800054e0:	00048513          	mv	a0,s1
    800054e4:	00000097          	auipc	ra,0x0
    800054e8:	5e4080e7          	jalr	1508(ra) # 80005ac8 <__memset>
    800054ec:	00093783          	ld	a5,0(s2)
    800054f0:	00f4b023          	sd	a5,0(s1)
    800054f4:	00993023          	sd	s1,0(s2)
    800054f8:	fd4498e3          	bne	s1,s4,800054c8 <kinit+0x70>
    800054fc:	03813083          	ld	ra,56(sp)
    80005500:	03013403          	ld	s0,48(sp)
    80005504:	02813483          	ld	s1,40(sp)
    80005508:	02013903          	ld	s2,32(sp)
    8000550c:	01813983          	ld	s3,24(sp)
    80005510:	01013a03          	ld	s4,16(sp)
    80005514:	00813a83          	ld	s5,8(sp)
    80005518:	04010113          	addi	sp,sp,64
    8000551c:	00008067          	ret
    80005520:	00001517          	auipc	a0,0x1
    80005524:	eb850513          	addi	a0,a0,-328 # 800063d8 <digits+0x18>
    80005528:	fffff097          	auipc	ra,0xfffff
    8000552c:	4b4080e7          	jalr	1204(ra) # 800049dc <panic>

0000000080005530 <freerange>:
    80005530:	fc010113          	addi	sp,sp,-64
    80005534:	000017b7          	lui	a5,0x1
    80005538:	02913423          	sd	s1,40(sp)
    8000553c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005540:	009504b3          	add	s1,a0,s1
    80005544:	fffff537          	lui	a0,0xfffff
    80005548:	02813823          	sd	s0,48(sp)
    8000554c:	02113c23          	sd	ra,56(sp)
    80005550:	03213023          	sd	s2,32(sp)
    80005554:	01313c23          	sd	s3,24(sp)
    80005558:	01413823          	sd	s4,16(sp)
    8000555c:	01513423          	sd	s5,8(sp)
    80005560:	01613023          	sd	s6,0(sp)
    80005564:	04010413          	addi	s0,sp,64
    80005568:	00a4f4b3          	and	s1,s1,a0
    8000556c:	00f487b3          	add	a5,s1,a5
    80005570:	06f5e463          	bltu	a1,a5,800055d8 <freerange+0xa8>
    80005574:	00003a97          	auipc	s5,0x3
    80005578:	52ca8a93          	addi	s5,s5,1324 # 80008aa0 <end>
    8000557c:	0954e263          	bltu	s1,s5,80005600 <freerange+0xd0>
    80005580:	01100993          	li	s3,17
    80005584:	01b99993          	slli	s3,s3,0x1b
    80005588:	0734fc63          	bgeu	s1,s3,80005600 <freerange+0xd0>
    8000558c:	00058a13          	mv	s4,a1
    80005590:	00002917          	auipc	s2,0x2
    80005594:	20090913          	addi	s2,s2,512 # 80007790 <kmem>
    80005598:	00002b37          	lui	s6,0x2
    8000559c:	0140006f          	j	800055b0 <freerange+0x80>
    800055a0:	000017b7          	lui	a5,0x1
    800055a4:	00f484b3          	add	s1,s1,a5
    800055a8:	0554ec63          	bltu	s1,s5,80005600 <freerange+0xd0>
    800055ac:	0534fa63          	bgeu	s1,s3,80005600 <freerange+0xd0>
    800055b0:	00001637          	lui	a2,0x1
    800055b4:	00100593          	li	a1,1
    800055b8:	00048513          	mv	a0,s1
    800055bc:	00000097          	auipc	ra,0x0
    800055c0:	50c080e7          	jalr	1292(ra) # 80005ac8 <__memset>
    800055c4:	00093703          	ld	a4,0(s2)
    800055c8:	016487b3          	add	a5,s1,s6
    800055cc:	00e4b023          	sd	a4,0(s1)
    800055d0:	00993023          	sd	s1,0(s2)
    800055d4:	fcfa76e3          	bgeu	s4,a5,800055a0 <freerange+0x70>
    800055d8:	03813083          	ld	ra,56(sp)
    800055dc:	03013403          	ld	s0,48(sp)
    800055e0:	02813483          	ld	s1,40(sp)
    800055e4:	02013903          	ld	s2,32(sp)
    800055e8:	01813983          	ld	s3,24(sp)
    800055ec:	01013a03          	ld	s4,16(sp)
    800055f0:	00813a83          	ld	s5,8(sp)
    800055f4:	00013b03          	ld	s6,0(sp)
    800055f8:	04010113          	addi	sp,sp,64
    800055fc:	00008067          	ret
    80005600:	00001517          	auipc	a0,0x1
    80005604:	dd850513          	addi	a0,a0,-552 # 800063d8 <digits+0x18>
    80005608:	fffff097          	auipc	ra,0xfffff
    8000560c:	3d4080e7          	jalr	980(ra) # 800049dc <panic>

0000000080005610 <kfree>:
    80005610:	fe010113          	addi	sp,sp,-32
    80005614:	00813823          	sd	s0,16(sp)
    80005618:	00113c23          	sd	ra,24(sp)
    8000561c:	00913423          	sd	s1,8(sp)
    80005620:	02010413          	addi	s0,sp,32
    80005624:	03451793          	slli	a5,a0,0x34
    80005628:	04079c63          	bnez	a5,80005680 <kfree+0x70>
    8000562c:	00003797          	auipc	a5,0x3
    80005630:	47478793          	addi	a5,a5,1140 # 80008aa0 <end>
    80005634:	00050493          	mv	s1,a0
    80005638:	04f56463          	bltu	a0,a5,80005680 <kfree+0x70>
    8000563c:	01100793          	li	a5,17
    80005640:	01b79793          	slli	a5,a5,0x1b
    80005644:	02f57e63          	bgeu	a0,a5,80005680 <kfree+0x70>
    80005648:	00001637          	lui	a2,0x1
    8000564c:	00100593          	li	a1,1
    80005650:	00000097          	auipc	ra,0x0
    80005654:	478080e7          	jalr	1144(ra) # 80005ac8 <__memset>
    80005658:	00002797          	auipc	a5,0x2
    8000565c:	13878793          	addi	a5,a5,312 # 80007790 <kmem>
    80005660:	0007b703          	ld	a4,0(a5)
    80005664:	01813083          	ld	ra,24(sp)
    80005668:	01013403          	ld	s0,16(sp)
    8000566c:	00e4b023          	sd	a4,0(s1)
    80005670:	0097b023          	sd	s1,0(a5)
    80005674:	00813483          	ld	s1,8(sp)
    80005678:	02010113          	addi	sp,sp,32
    8000567c:	00008067          	ret
    80005680:	00001517          	auipc	a0,0x1
    80005684:	d5850513          	addi	a0,a0,-680 # 800063d8 <digits+0x18>
    80005688:	fffff097          	auipc	ra,0xfffff
    8000568c:	354080e7          	jalr	852(ra) # 800049dc <panic>

0000000080005690 <kalloc>:
    80005690:	fe010113          	addi	sp,sp,-32
    80005694:	00813823          	sd	s0,16(sp)
    80005698:	00913423          	sd	s1,8(sp)
    8000569c:	00113c23          	sd	ra,24(sp)
    800056a0:	02010413          	addi	s0,sp,32
    800056a4:	00002797          	auipc	a5,0x2
    800056a8:	0ec78793          	addi	a5,a5,236 # 80007790 <kmem>
    800056ac:	0007b483          	ld	s1,0(a5)
    800056b0:	02048063          	beqz	s1,800056d0 <kalloc+0x40>
    800056b4:	0004b703          	ld	a4,0(s1)
    800056b8:	00001637          	lui	a2,0x1
    800056bc:	00500593          	li	a1,5
    800056c0:	00048513          	mv	a0,s1
    800056c4:	00e7b023          	sd	a4,0(a5)
    800056c8:	00000097          	auipc	ra,0x0
    800056cc:	400080e7          	jalr	1024(ra) # 80005ac8 <__memset>
    800056d0:	01813083          	ld	ra,24(sp)
    800056d4:	01013403          	ld	s0,16(sp)
    800056d8:	00048513          	mv	a0,s1
    800056dc:	00813483          	ld	s1,8(sp)
    800056e0:	02010113          	addi	sp,sp,32
    800056e4:	00008067          	ret

00000000800056e8 <initlock>:
    800056e8:	ff010113          	addi	sp,sp,-16
    800056ec:	00813423          	sd	s0,8(sp)
    800056f0:	01010413          	addi	s0,sp,16
    800056f4:	00813403          	ld	s0,8(sp)
    800056f8:	00b53423          	sd	a1,8(a0)
    800056fc:	00052023          	sw	zero,0(a0)
    80005700:	00053823          	sd	zero,16(a0)
    80005704:	01010113          	addi	sp,sp,16
    80005708:	00008067          	ret

000000008000570c <acquire>:
    8000570c:	fe010113          	addi	sp,sp,-32
    80005710:	00813823          	sd	s0,16(sp)
    80005714:	00913423          	sd	s1,8(sp)
    80005718:	00113c23          	sd	ra,24(sp)
    8000571c:	01213023          	sd	s2,0(sp)
    80005720:	02010413          	addi	s0,sp,32
    80005724:	00050493          	mv	s1,a0
    80005728:	10002973          	csrr	s2,sstatus
    8000572c:	100027f3          	csrr	a5,sstatus
    80005730:	ffd7f793          	andi	a5,a5,-3
    80005734:	10079073          	csrw	sstatus,a5
    80005738:	fffff097          	auipc	ra,0xfffff
    8000573c:	8e0080e7          	jalr	-1824(ra) # 80004018 <mycpu>
    80005740:	07852783          	lw	a5,120(a0)
    80005744:	06078e63          	beqz	a5,800057c0 <acquire+0xb4>
    80005748:	fffff097          	auipc	ra,0xfffff
    8000574c:	8d0080e7          	jalr	-1840(ra) # 80004018 <mycpu>
    80005750:	07852783          	lw	a5,120(a0)
    80005754:	0004a703          	lw	a4,0(s1)
    80005758:	0017879b          	addiw	a5,a5,1
    8000575c:	06f52c23          	sw	a5,120(a0)
    80005760:	04071063          	bnez	a4,800057a0 <acquire+0x94>
    80005764:	00100713          	li	a4,1
    80005768:	00070793          	mv	a5,a4
    8000576c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005770:	0007879b          	sext.w	a5,a5
    80005774:	fe079ae3          	bnez	a5,80005768 <acquire+0x5c>
    80005778:	0ff0000f          	fence
    8000577c:	fffff097          	auipc	ra,0xfffff
    80005780:	89c080e7          	jalr	-1892(ra) # 80004018 <mycpu>
    80005784:	01813083          	ld	ra,24(sp)
    80005788:	01013403          	ld	s0,16(sp)
    8000578c:	00a4b823          	sd	a0,16(s1)
    80005790:	00013903          	ld	s2,0(sp)
    80005794:	00813483          	ld	s1,8(sp)
    80005798:	02010113          	addi	sp,sp,32
    8000579c:	00008067          	ret
    800057a0:	0104b903          	ld	s2,16(s1)
    800057a4:	fffff097          	auipc	ra,0xfffff
    800057a8:	874080e7          	jalr	-1932(ra) # 80004018 <mycpu>
    800057ac:	faa91ce3          	bne	s2,a0,80005764 <acquire+0x58>
    800057b0:	00001517          	auipc	a0,0x1
    800057b4:	c3050513          	addi	a0,a0,-976 # 800063e0 <digits+0x20>
    800057b8:	fffff097          	auipc	ra,0xfffff
    800057bc:	224080e7          	jalr	548(ra) # 800049dc <panic>
    800057c0:	00195913          	srli	s2,s2,0x1
    800057c4:	fffff097          	auipc	ra,0xfffff
    800057c8:	854080e7          	jalr	-1964(ra) # 80004018 <mycpu>
    800057cc:	00197913          	andi	s2,s2,1
    800057d0:	07252e23          	sw	s2,124(a0)
    800057d4:	f75ff06f          	j	80005748 <acquire+0x3c>

00000000800057d8 <release>:
    800057d8:	fe010113          	addi	sp,sp,-32
    800057dc:	00813823          	sd	s0,16(sp)
    800057e0:	00113c23          	sd	ra,24(sp)
    800057e4:	00913423          	sd	s1,8(sp)
    800057e8:	01213023          	sd	s2,0(sp)
    800057ec:	02010413          	addi	s0,sp,32
    800057f0:	00052783          	lw	a5,0(a0)
    800057f4:	00079a63          	bnez	a5,80005808 <release+0x30>
    800057f8:	00001517          	auipc	a0,0x1
    800057fc:	bf050513          	addi	a0,a0,-1040 # 800063e8 <digits+0x28>
    80005800:	fffff097          	auipc	ra,0xfffff
    80005804:	1dc080e7          	jalr	476(ra) # 800049dc <panic>
    80005808:	01053903          	ld	s2,16(a0)
    8000580c:	00050493          	mv	s1,a0
    80005810:	fffff097          	auipc	ra,0xfffff
    80005814:	808080e7          	jalr	-2040(ra) # 80004018 <mycpu>
    80005818:	fea910e3          	bne	s2,a0,800057f8 <release+0x20>
    8000581c:	0004b823          	sd	zero,16(s1)
    80005820:	0ff0000f          	fence
    80005824:	0f50000f          	fence	iorw,ow
    80005828:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000582c:	ffffe097          	auipc	ra,0xffffe
    80005830:	7ec080e7          	jalr	2028(ra) # 80004018 <mycpu>
    80005834:	100027f3          	csrr	a5,sstatus
    80005838:	0027f793          	andi	a5,a5,2
    8000583c:	04079a63          	bnez	a5,80005890 <release+0xb8>
    80005840:	07852783          	lw	a5,120(a0)
    80005844:	02f05e63          	blez	a5,80005880 <release+0xa8>
    80005848:	fff7871b          	addiw	a4,a5,-1
    8000584c:	06e52c23          	sw	a4,120(a0)
    80005850:	00071c63          	bnez	a4,80005868 <release+0x90>
    80005854:	07c52783          	lw	a5,124(a0)
    80005858:	00078863          	beqz	a5,80005868 <release+0x90>
    8000585c:	100027f3          	csrr	a5,sstatus
    80005860:	0027e793          	ori	a5,a5,2
    80005864:	10079073          	csrw	sstatus,a5
    80005868:	01813083          	ld	ra,24(sp)
    8000586c:	01013403          	ld	s0,16(sp)
    80005870:	00813483          	ld	s1,8(sp)
    80005874:	00013903          	ld	s2,0(sp)
    80005878:	02010113          	addi	sp,sp,32
    8000587c:	00008067          	ret
    80005880:	00001517          	auipc	a0,0x1
    80005884:	b8850513          	addi	a0,a0,-1144 # 80006408 <digits+0x48>
    80005888:	fffff097          	auipc	ra,0xfffff
    8000588c:	154080e7          	jalr	340(ra) # 800049dc <panic>
    80005890:	00001517          	auipc	a0,0x1
    80005894:	b6050513          	addi	a0,a0,-1184 # 800063f0 <digits+0x30>
    80005898:	fffff097          	auipc	ra,0xfffff
    8000589c:	144080e7          	jalr	324(ra) # 800049dc <panic>

00000000800058a0 <holding>:
    800058a0:	00052783          	lw	a5,0(a0)
    800058a4:	00079663          	bnez	a5,800058b0 <holding+0x10>
    800058a8:	00000513          	li	a0,0
    800058ac:	00008067          	ret
    800058b0:	fe010113          	addi	sp,sp,-32
    800058b4:	00813823          	sd	s0,16(sp)
    800058b8:	00913423          	sd	s1,8(sp)
    800058bc:	00113c23          	sd	ra,24(sp)
    800058c0:	02010413          	addi	s0,sp,32
    800058c4:	01053483          	ld	s1,16(a0)
    800058c8:	ffffe097          	auipc	ra,0xffffe
    800058cc:	750080e7          	jalr	1872(ra) # 80004018 <mycpu>
    800058d0:	01813083          	ld	ra,24(sp)
    800058d4:	01013403          	ld	s0,16(sp)
    800058d8:	40a48533          	sub	a0,s1,a0
    800058dc:	00153513          	seqz	a0,a0
    800058e0:	00813483          	ld	s1,8(sp)
    800058e4:	02010113          	addi	sp,sp,32
    800058e8:	00008067          	ret

00000000800058ec <push_off>:
    800058ec:	fe010113          	addi	sp,sp,-32
    800058f0:	00813823          	sd	s0,16(sp)
    800058f4:	00113c23          	sd	ra,24(sp)
    800058f8:	00913423          	sd	s1,8(sp)
    800058fc:	02010413          	addi	s0,sp,32
    80005900:	100024f3          	csrr	s1,sstatus
    80005904:	100027f3          	csrr	a5,sstatus
    80005908:	ffd7f793          	andi	a5,a5,-3
    8000590c:	10079073          	csrw	sstatus,a5
    80005910:	ffffe097          	auipc	ra,0xffffe
    80005914:	708080e7          	jalr	1800(ra) # 80004018 <mycpu>
    80005918:	07852783          	lw	a5,120(a0)
    8000591c:	02078663          	beqz	a5,80005948 <push_off+0x5c>
    80005920:	ffffe097          	auipc	ra,0xffffe
    80005924:	6f8080e7          	jalr	1784(ra) # 80004018 <mycpu>
    80005928:	07852783          	lw	a5,120(a0)
    8000592c:	01813083          	ld	ra,24(sp)
    80005930:	01013403          	ld	s0,16(sp)
    80005934:	0017879b          	addiw	a5,a5,1
    80005938:	06f52c23          	sw	a5,120(a0)
    8000593c:	00813483          	ld	s1,8(sp)
    80005940:	02010113          	addi	sp,sp,32
    80005944:	00008067          	ret
    80005948:	0014d493          	srli	s1,s1,0x1
    8000594c:	ffffe097          	auipc	ra,0xffffe
    80005950:	6cc080e7          	jalr	1740(ra) # 80004018 <mycpu>
    80005954:	0014f493          	andi	s1,s1,1
    80005958:	06952e23          	sw	s1,124(a0)
    8000595c:	fc5ff06f          	j	80005920 <push_off+0x34>

0000000080005960 <pop_off>:
    80005960:	ff010113          	addi	sp,sp,-16
    80005964:	00813023          	sd	s0,0(sp)
    80005968:	00113423          	sd	ra,8(sp)
    8000596c:	01010413          	addi	s0,sp,16
    80005970:	ffffe097          	auipc	ra,0xffffe
    80005974:	6a8080e7          	jalr	1704(ra) # 80004018 <mycpu>
    80005978:	100027f3          	csrr	a5,sstatus
    8000597c:	0027f793          	andi	a5,a5,2
    80005980:	04079663          	bnez	a5,800059cc <pop_off+0x6c>
    80005984:	07852783          	lw	a5,120(a0)
    80005988:	02f05a63          	blez	a5,800059bc <pop_off+0x5c>
    8000598c:	fff7871b          	addiw	a4,a5,-1
    80005990:	06e52c23          	sw	a4,120(a0)
    80005994:	00071c63          	bnez	a4,800059ac <pop_off+0x4c>
    80005998:	07c52783          	lw	a5,124(a0)
    8000599c:	00078863          	beqz	a5,800059ac <pop_off+0x4c>
    800059a0:	100027f3          	csrr	a5,sstatus
    800059a4:	0027e793          	ori	a5,a5,2
    800059a8:	10079073          	csrw	sstatus,a5
    800059ac:	00813083          	ld	ra,8(sp)
    800059b0:	00013403          	ld	s0,0(sp)
    800059b4:	01010113          	addi	sp,sp,16
    800059b8:	00008067          	ret
    800059bc:	00001517          	auipc	a0,0x1
    800059c0:	a4c50513          	addi	a0,a0,-1460 # 80006408 <digits+0x48>
    800059c4:	fffff097          	auipc	ra,0xfffff
    800059c8:	018080e7          	jalr	24(ra) # 800049dc <panic>
    800059cc:	00001517          	auipc	a0,0x1
    800059d0:	a2450513          	addi	a0,a0,-1500 # 800063f0 <digits+0x30>
    800059d4:	fffff097          	auipc	ra,0xfffff
    800059d8:	008080e7          	jalr	8(ra) # 800049dc <panic>

00000000800059dc <push_on>:
    800059dc:	fe010113          	addi	sp,sp,-32
    800059e0:	00813823          	sd	s0,16(sp)
    800059e4:	00113c23          	sd	ra,24(sp)
    800059e8:	00913423          	sd	s1,8(sp)
    800059ec:	02010413          	addi	s0,sp,32
    800059f0:	100024f3          	csrr	s1,sstatus
    800059f4:	100027f3          	csrr	a5,sstatus
    800059f8:	0027e793          	ori	a5,a5,2
    800059fc:	10079073          	csrw	sstatus,a5
    80005a00:	ffffe097          	auipc	ra,0xffffe
    80005a04:	618080e7          	jalr	1560(ra) # 80004018 <mycpu>
    80005a08:	07852783          	lw	a5,120(a0)
    80005a0c:	02078663          	beqz	a5,80005a38 <push_on+0x5c>
    80005a10:	ffffe097          	auipc	ra,0xffffe
    80005a14:	608080e7          	jalr	1544(ra) # 80004018 <mycpu>
    80005a18:	07852783          	lw	a5,120(a0)
    80005a1c:	01813083          	ld	ra,24(sp)
    80005a20:	01013403          	ld	s0,16(sp)
    80005a24:	0017879b          	addiw	a5,a5,1
    80005a28:	06f52c23          	sw	a5,120(a0)
    80005a2c:	00813483          	ld	s1,8(sp)
    80005a30:	02010113          	addi	sp,sp,32
    80005a34:	00008067          	ret
    80005a38:	0014d493          	srli	s1,s1,0x1
    80005a3c:	ffffe097          	auipc	ra,0xffffe
    80005a40:	5dc080e7          	jalr	1500(ra) # 80004018 <mycpu>
    80005a44:	0014f493          	andi	s1,s1,1
    80005a48:	06952e23          	sw	s1,124(a0)
    80005a4c:	fc5ff06f          	j	80005a10 <push_on+0x34>

0000000080005a50 <pop_on>:
    80005a50:	ff010113          	addi	sp,sp,-16
    80005a54:	00813023          	sd	s0,0(sp)
    80005a58:	00113423          	sd	ra,8(sp)
    80005a5c:	01010413          	addi	s0,sp,16
    80005a60:	ffffe097          	auipc	ra,0xffffe
    80005a64:	5b8080e7          	jalr	1464(ra) # 80004018 <mycpu>
    80005a68:	100027f3          	csrr	a5,sstatus
    80005a6c:	0027f793          	andi	a5,a5,2
    80005a70:	04078463          	beqz	a5,80005ab8 <pop_on+0x68>
    80005a74:	07852783          	lw	a5,120(a0)
    80005a78:	02f05863          	blez	a5,80005aa8 <pop_on+0x58>
    80005a7c:	fff7879b          	addiw	a5,a5,-1
    80005a80:	06f52c23          	sw	a5,120(a0)
    80005a84:	07853783          	ld	a5,120(a0)
    80005a88:	00079863          	bnez	a5,80005a98 <pop_on+0x48>
    80005a8c:	100027f3          	csrr	a5,sstatus
    80005a90:	ffd7f793          	andi	a5,a5,-3
    80005a94:	10079073          	csrw	sstatus,a5
    80005a98:	00813083          	ld	ra,8(sp)
    80005a9c:	00013403          	ld	s0,0(sp)
    80005aa0:	01010113          	addi	sp,sp,16
    80005aa4:	00008067          	ret
    80005aa8:	00001517          	auipc	a0,0x1
    80005aac:	98850513          	addi	a0,a0,-1656 # 80006430 <digits+0x70>
    80005ab0:	fffff097          	auipc	ra,0xfffff
    80005ab4:	f2c080e7          	jalr	-212(ra) # 800049dc <panic>
    80005ab8:	00001517          	auipc	a0,0x1
    80005abc:	95850513          	addi	a0,a0,-1704 # 80006410 <digits+0x50>
    80005ac0:	fffff097          	auipc	ra,0xfffff
    80005ac4:	f1c080e7          	jalr	-228(ra) # 800049dc <panic>

0000000080005ac8 <__memset>:
    80005ac8:	ff010113          	addi	sp,sp,-16
    80005acc:	00813423          	sd	s0,8(sp)
    80005ad0:	01010413          	addi	s0,sp,16
    80005ad4:	1a060e63          	beqz	a2,80005c90 <__memset+0x1c8>
    80005ad8:	40a007b3          	neg	a5,a0
    80005adc:	0077f793          	andi	a5,a5,7
    80005ae0:	00778693          	addi	a3,a5,7
    80005ae4:	00b00813          	li	a6,11
    80005ae8:	0ff5f593          	andi	a1,a1,255
    80005aec:	fff6071b          	addiw	a4,a2,-1
    80005af0:	1b06e663          	bltu	a3,a6,80005c9c <__memset+0x1d4>
    80005af4:	1cd76463          	bltu	a4,a3,80005cbc <__memset+0x1f4>
    80005af8:	1a078e63          	beqz	a5,80005cb4 <__memset+0x1ec>
    80005afc:	00b50023          	sb	a1,0(a0)
    80005b00:	00100713          	li	a4,1
    80005b04:	1ae78463          	beq	a5,a4,80005cac <__memset+0x1e4>
    80005b08:	00b500a3          	sb	a1,1(a0)
    80005b0c:	00200713          	li	a4,2
    80005b10:	1ae78a63          	beq	a5,a4,80005cc4 <__memset+0x1fc>
    80005b14:	00b50123          	sb	a1,2(a0)
    80005b18:	00300713          	li	a4,3
    80005b1c:	18e78463          	beq	a5,a4,80005ca4 <__memset+0x1dc>
    80005b20:	00b501a3          	sb	a1,3(a0)
    80005b24:	00400713          	li	a4,4
    80005b28:	1ae78263          	beq	a5,a4,80005ccc <__memset+0x204>
    80005b2c:	00b50223          	sb	a1,4(a0)
    80005b30:	00500713          	li	a4,5
    80005b34:	1ae78063          	beq	a5,a4,80005cd4 <__memset+0x20c>
    80005b38:	00b502a3          	sb	a1,5(a0)
    80005b3c:	00700713          	li	a4,7
    80005b40:	18e79e63          	bne	a5,a4,80005cdc <__memset+0x214>
    80005b44:	00b50323          	sb	a1,6(a0)
    80005b48:	00700e93          	li	t4,7
    80005b4c:	00859713          	slli	a4,a1,0x8
    80005b50:	00e5e733          	or	a4,a1,a4
    80005b54:	01059e13          	slli	t3,a1,0x10
    80005b58:	01c76e33          	or	t3,a4,t3
    80005b5c:	01859313          	slli	t1,a1,0x18
    80005b60:	006e6333          	or	t1,t3,t1
    80005b64:	02059893          	slli	a7,a1,0x20
    80005b68:	40f60e3b          	subw	t3,a2,a5
    80005b6c:	011368b3          	or	a7,t1,a7
    80005b70:	02859813          	slli	a6,a1,0x28
    80005b74:	0108e833          	or	a6,a7,a6
    80005b78:	03059693          	slli	a3,a1,0x30
    80005b7c:	003e589b          	srliw	a7,t3,0x3
    80005b80:	00d866b3          	or	a3,a6,a3
    80005b84:	03859713          	slli	a4,a1,0x38
    80005b88:	00389813          	slli	a6,a7,0x3
    80005b8c:	00f507b3          	add	a5,a0,a5
    80005b90:	00e6e733          	or	a4,a3,a4
    80005b94:	000e089b          	sext.w	a7,t3
    80005b98:	00f806b3          	add	a3,a6,a5
    80005b9c:	00e7b023          	sd	a4,0(a5)
    80005ba0:	00878793          	addi	a5,a5,8
    80005ba4:	fed79ce3          	bne	a5,a3,80005b9c <__memset+0xd4>
    80005ba8:	ff8e7793          	andi	a5,t3,-8
    80005bac:	0007871b          	sext.w	a4,a5
    80005bb0:	01d787bb          	addw	a5,a5,t4
    80005bb4:	0ce88e63          	beq	a7,a4,80005c90 <__memset+0x1c8>
    80005bb8:	00f50733          	add	a4,a0,a5
    80005bbc:	00b70023          	sb	a1,0(a4)
    80005bc0:	0017871b          	addiw	a4,a5,1
    80005bc4:	0cc77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005bc8:	00e50733          	add	a4,a0,a4
    80005bcc:	00b70023          	sb	a1,0(a4)
    80005bd0:	0027871b          	addiw	a4,a5,2
    80005bd4:	0ac77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005bd8:	00e50733          	add	a4,a0,a4
    80005bdc:	00b70023          	sb	a1,0(a4)
    80005be0:	0037871b          	addiw	a4,a5,3
    80005be4:	0ac77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005be8:	00e50733          	add	a4,a0,a4
    80005bec:	00b70023          	sb	a1,0(a4)
    80005bf0:	0047871b          	addiw	a4,a5,4
    80005bf4:	08c77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005bf8:	00e50733          	add	a4,a0,a4
    80005bfc:	00b70023          	sb	a1,0(a4)
    80005c00:	0057871b          	addiw	a4,a5,5
    80005c04:	08c77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c08:	00e50733          	add	a4,a0,a4
    80005c0c:	00b70023          	sb	a1,0(a4)
    80005c10:	0067871b          	addiw	a4,a5,6
    80005c14:	06c77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c18:	00e50733          	add	a4,a0,a4
    80005c1c:	00b70023          	sb	a1,0(a4)
    80005c20:	0077871b          	addiw	a4,a5,7
    80005c24:	06c77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c28:	00e50733          	add	a4,a0,a4
    80005c2c:	00b70023          	sb	a1,0(a4)
    80005c30:	0087871b          	addiw	a4,a5,8
    80005c34:	04c77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c38:	00e50733          	add	a4,a0,a4
    80005c3c:	00b70023          	sb	a1,0(a4)
    80005c40:	0097871b          	addiw	a4,a5,9
    80005c44:	04c77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c48:	00e50733          	add	a4,a0,a4
    80005c4c:	00b70023          	sb	a1,0(a4)
    80005c50:	00a7871b          	addiw	a4,a5,10
    80005c54:	02c77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c58:	00e50733          	add	a4,a0,a4
    80005c5c:	00b70023          	sb	a1,0(a4)
    80005c60:	00b7871b          	addiw	a4,a5,11
    80005c64:	02c77663          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c68:	00e50733          	add	a4,a0,a4
    80005c6c:	00b70023          	sb	a1,0(a4)
    80005c70:	00c7871b          	addiw	a4,a5,12
    80005c74:	00c77e63          	bgeu	a4,a2,80005c90 <__memset+0x1c8>
    80005c78:	00e50733          	add	a4,a0,a4
    80005c7c:	00b70023          	sb	a1,0(a4)
    80005c80:	00d7879b          	addiw	a5,a5,13
    80005c84:	00c7f663          	bgeu	a5,a2,80005c90 <__memset+0x1c8>
    80005c88:	00f507b3          	add	a5,a0,a5
    80005c8c:	00b78023          	sb	a1,0(a5)
    80005c90:	00813403          	ld	s0,8(sp)
    80005c94:	01010113          	addi	sp,sp,16
    80005c98:	00008067          	ret
    80005c9c:	00b00693          	li	a3,11
    80005ca0:	e55ff06f          	j	80005af4 <__memset+0x2c>
    80005ca4:	00300e93          	li	t4,3
    80005ca8:	ea5ff06f          	j	80005b4c <__memset+0x84>
    80005cac:	00100e93          	li	t4,1
    80005cb0:	e9dff06f          	j	80005b4c <__memset+0x84>
    80005cb4:	00000e93          	li	t4,0
    80005cb8:	e95ff06f          	j	80005b4c <__memset+0x84>
    80005cbc:	00000793          	li	a5,0
    80005cc0:	ef9ff06f          	j	80005bb8 <__memset+0xf0>
    80005cc4:	00200e93          	li	t4,2
    80005cc8:	e85ff06f          	j	80005b4c <__memset+0x84>
    80005ccc:	00400e93          	li	t4,4
    80005cd0:	e7dff06f          	j	80005b4c <__memset+0x84>
    80005cd4:	00500e93          	li	t4,5
    80005cd8:	e75ff06f          	j	80005b4c <__memset+0x84>
    80005cdc:	00600e93          	li	t4,6
    80005ce0:	e6dff06f          	j	80005b4c <__memset+0x84>

0000000080005ce4 <__memmove>:
    80005ce4:	ff010113          	addi	sp,sp,-16
    80005ce8:	00813423          	sd	s0,8(sp)
    80005cec:	01010413          	addi	s0,sp,16
    80005cf0:	0e060863          	beqz	a2,80005de0 <__memmove+0xfc>
    80005cf4:	fff6069b          	addiw	a3,a2,-1
    80005cf8:	0006881b          	sext.w	a6,a3
    80005cfc:	0ea5e863          	bltu	a1,a0,80005dec <__memmove+0x108>
    80005d00:	00758713          	addi	a4,a1,7
    80005d04:	00a5e7b3          	or	a5,a1,a0
    80005d08:	40a70733          	sub	a4,a4,a0
    80005d0c:	0077f793          	andi	a5,a5,7
    80005d10:	00f73713          	sltiu	a4,a4,15
    80005d14:	00174713          	xori	a4,a4,1
    80005d18:	0017b793          	seqz	a5,a5
    80005d1c:	00e7f7b3          	and	a5,a5,a4
    80005d20:	10078863          	beqz	a5,80005e30 <__memmove+0x14c>
    80005d24:	00900793          	li	a5,9
    80005d28:	1107f463          	bgeu	a5,a6,80005e30 <__memmove+0x14c>
    80005d2c:	0036581b          	srliw	a6,a2,0x3
    80005d30:	fff8081b          	addiw	a6,a6,-1
    80005d34:	02081813          	slli	a6,a6,0x20
    80005d38:	01d85893          	srli	a7,a6,0x1d
    80005d3c:	00858813          	addi	a6,a1,8
    80005d40:	00058793          	mv	a5,a1
    80005d44:	00050713          	mv	a4,a0
    80005d48:	01088833          	add	a6,a7,a6
    80005d4c:	0007b883          	ld	a7,0(a5)
    80005d50:	00878793          	addi	a5,a5,8
    80005d54:	00870713          	addi	a4,a4,8
    80005d58:	ff173c23          	sd	a7,-8(a4)
    80005d5c:	ff0798e3          	bne	a5,a6,80005d4c <__memmove+0x68>
    80005d60:	ff867713          	andi	a4,a2,-8
    80005d64:	02071793          	slli	a5,a4,0x20
    80005d68:	0207d793          	srli	a5,a5,0x20
    80005d6c:	00f585b3          	add	a1,a1,a5
    80005d70:	40e686bb          	subw	a3,a3,a4
    80005d74:	00f507b3          	add	a5,a0,a5
    80005d78:	06e60463          	beq	a2,a4,80005de0 <__memmove+0xfc>
    80005d7c:	0005c703          	lbu	a4,0(a1)
    80005d80:	00e78023          	sb	a4,0(a5)
    80005d84:	04068e63          	beqz	a3,80005de0 <__memmove+0xfc>
    80005d88:	0015c603          	lbu	a2,1(a1)
    80005d8c:	00100713          	li	a4,1
    80005d90:	00c780a3          	sb	a2,1(a5)
    80005d94:	04e68663          	beq	a3,a4,80005de0 <__memmove+0xfc>
    80005d98:	0025c603          	lbu	a2,2(a1)
    80005d9c:	00200713          	li	a4,2
    80005da0:	00c78123          	sb	a2,2(a5)
    80005da4:	02e68e63          	beq	a3,a4,80005de0 <__memmove+0xfc>
    80005da8:	0035c603          	lbu	a2,3(a1)
    80005dac:	00300713          	li	a4,3
    80005db0:	00c781a3          	sb	a2,3(a5)
    80005db4:	02e68663          	beq	a3,a4,80005de0 <__memmove+0xfc>
    80005db8:	0045c603          	lbu	a2,4(a1)
    80005dbc:	00400713          	li	a4,4
    80005dc0:	00c78223          	sb	a2,4(a5)
    80005dc4:	00e68e63          	beq	a3,a4,80005de0 <__memmove+0xfc>
    80005dc8:	0055c603          	lbu	a2,5(a1)
    80005dcc:	00500713          	li	a4,5
    80005dd0:	00c782a3          	sb	a2,5(a5)
    80005dd4:	00e68663          	beq	a3,a4,80005de0 <__memmove+0xfc>
    80005dd8:	0065c703          	lbu	a4,6(a1)
    80005ddc:	00e78323          	sb	a4,6(a5)
    80005de0:	00813403          	ld	s0,8(sp)
    80005de4:	01010113          	addi	sp,sp,16
    80005de8:	00008067          	ret
    80005dec:	02061713          	slli	a4,a2,0x20
    80005df0:	02075713          	srli	a4,a4,0x20
    80005df4:	00e587b3          	add	a5,a1,a4
    80005df8:	f0f574e3          	bgeu	a0,a5,80005d00 <__memmove+0x1c>
    80005dfc:	02069613          	slli	a2,a3,0x20
    80005e00:	02065613          	srli	a2,a2,0x20
    80005e04:	fff64613          	not	a2,a2
    80005e08:	00e50733          	add	a4,a0,a4
    80005e0c:	00c78633          	add	a2,a5,a2
    80005e10:	fff7c683          	lbu	a3,-1(a5)
    80005e14:	fff78793          	addi	a5,a5,-1
    80005e18:	fff70713          	addi	a4,a4,-1
    80005e1c:	00d70023          	sb	a3,0(a4)
    80005e20:	fec798e3          	bne	a5,a2,80005e10 <__memmove+0x12c>
    80005e24:	00813403          	ld	s0,8(sp)
    80005e28:	01010113          	addi	sp,sp,16
    80005e2c:	00008067          	ret
    80005e30:	02069713          	slli	a4,a3,0x20
    80005e34:	02075713          	srli	a4,a4,0x20
    80005e38:	00170713          	addi	a4,a4,1
    80005e3c:	00e50733          	add	a4,a0,a4
    80005e40:	00050793          	mv	a5,a0
    80005e44:	0005c683          	lbu	a3,0(a1)
    80005e48:	00178793          	addi	a5,a5,1
    80005e4c:	00158593          	addi	a1,a1,1
    80005e50:	fed78fa3          	sb	a3,-1(a5)
    80005e54:	fee798e3          	bne	a5,a4,80005e44 <__memmove+0x160>
    80005e58:	f89ff06f          	j	80005de0 <__memmove+0xfc>
	...
