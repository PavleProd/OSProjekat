
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00008117          	auipc	sp,0x8
    80000004:	87813103          	ld	sp,-1928(sp) # 80007878 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	689030ef          	jal	ra,80003ea4 <start>

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
    8000100c:	4e1000ef          	jal	ra,80001cec <_ZN3PCB10getContextEv>
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
    800010a0:	44d000ef          	jal	ra,80001cec <_ZN3PCB10getContextEv>

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
    80001598:	2ef70863          	beq	a4,a5,80001888 <interruptHandler+0x360>
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
    800015ac:	32f70e63          	beq	a4,a5,800018e8 <interruptHandler+0x3c0>
            plic_complete(code);
        }

    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800015b0:	00002097          	auipc	ra,0x2
    800015b4:	23c080e7          	jalr	572(ra) # 800037ec <_Z10printErrorv>
    800015b8:	0840006f          	j	8000163c <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015bc:	fd043783          	ld	a5,-48(s0)
    800015c0:	00478793          	addi	a5,a5,4
    800015c4:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015c8:	00006797          	auipc	a5,0x6
    800015cc:	2c87b783          	ld	a5,712(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015d0:	0007b503          	ld	a0,0(a5)
    800015d4:	01853703          	ld	a4,24(a0)
    800015d8:	05073783          	ld	a5,80(a4)
    800015dc:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015e0:	fa843783          	ld	a5,-88(s0)
    800015e4:	04300693          	li	a3,67
    800015e8:	28f6ea63          	bltu	a3,a5,8000187c <interruptHandler+0x354>
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
    80001614:	c20080e7          	jalr	-992(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
    80001618:	00006797          	auipc	a5,0x6
    8000161c:	2787b783          	ld	a5,632(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    8000165c:	d3c080e7          	jalr	-708(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
    80001660:	00006797          	auipc	a5,0x6
    80001664:	2307b783          	ld	a5,560(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001668:	0007b783          	ld	a5,0(a5)
    8000166c:	0187b783          	ld	a5,24(a5)
    80001670:	04a7b823          	sd	a0,80(a5)
                break;
    80001674:	fb9ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    80001678:	00006797          	auipc	a5,0x6
    8000167c:	1f87b783          	ld	a5,504(a5) # 80007870 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001680:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001684:	00000097          	auipc	ra,0x0
    80001688:	408080e7          	jalr	1032(ra) # 80001a8c <_ZN3PCB8dispatchEv>
                break;
    8000168c:	fa1ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->finished = true;
    80001690:	00100793          	li	a5,1
    80001694:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001698:	00006797          	auipc	a5,0x6
    8000169c:	1d87b783          	ld	a5,472(a5) # 80007870 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016a0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	3e8080e7          	jalr	1000(ra) # 80001a8c <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016ac:	00006797          	auipc	a5,0x6
    800016b0:	1e47b783          	ld	a5,484(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800016d0:	fd4080e7          	jalr	-44(ra) # 800026a0 <_ZN9Scheduler3putEP3PCB>
                break;
    800016d4:	f59ff06f          	j	8000162c <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d8:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016dc:	06873583          	ld	a1,104(a4)
    800016e0:	06073503          	ld	a0,96(a4)
    800016e4:	00000097          	auipc	ra,0x0
    800016e8:	580080e7          	jalr	1408(ra) # 80001c64 <_ZN3PCB14createProccessEPFvvEPv>
    800016ec:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016f0:	00006797          	auipc	a5,0x6
    800016f4:	1a07b783          	ld	a5,416(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001740:	a40080e7          	jalr	-1472(ra) # 8000317c <_ZN3SCBnwEm>
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
    80001758:	13c7b783          	ld	a5,316(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000175c:	0007b783          	ld	a5,0(a5)
    80001760:	0187b783          	ld	a5,24(a5)
    80001764:	0497b823          	sd	s1,80(a5)
                break;
    80001768:	ec5ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    8000176c:	05873503          	ld	a0,88(a4)
    80001770:	00002097          	auipc	ra,0x2
    80001774:	8e8080e7          	jalr	-1816(ra) # 80003058 <_ZN3SCB4waitEv>
    80001778:	00006797          	auipc	a5,0x6
    8000177c:	1187b783          	ld	a5,280(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001780:	0007b783          	ld	a5,0(a5)
    80001784:	0187b783          	ld	a5,24(a5)
    80001788:	04a7b823          	sd	a0,80(a5)
                break;
    8000178c:	ea1ff06f          	j	8000162c <interruptHandler+0x104>
                sem->signal();
    80001790:	05873503          	ld	a0,88(a4)
    80001794:	00002097          	auipc	ra,0x2
    80001798:	958080e7          	jalr	-1704(ra) # 800030ec <_ZN3SCB6signalEv>
                break;
    8000179c:	e91ff06f          	j	8000162c <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017a0:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017a4:	00048513          	mv	a0,s1
    800017a8:	00002097          	auipc	ra,0x2
    800017ac:	a24080e7          	jalr	-1500(ra) # 800031cc <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017b0:	e6048ee3          	beqz	s1,8000162c <interruptHandler+0x104>
    800017b4:	00048513          	mv	a0,s1
    800017b8:	00002097          	auipc	ra,0x2
    800017bc:	9ec080e7          	jalr	-1556(ra) # 800031a4 <_ZN3SCBdlEPv>
    800017c0:	e6dff06f          	j	8000162c <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    800017c4:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017c8:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	138080e7          	jalr	312(ra) # 80001904 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017d4:	e59ff06f          	j	8000162c <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    800017d8:	05874583          	lbu	a1,88(a4)
    800017dc:	00006517          	auipc	a0,0x6
    800017e0:	07c53503          	ld	a0,124(a0) # 80007858 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017e4:	00000097          	auipc	ra,0x0
    800017e8:	52c080e7          	jalr	1324(ra) # 80001d10 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    800017ec:	00006797          	auipc	a5,0x6
    800017f0:	0b47b783          	ld	a5,180(a5) # 800078a0 <_GLOBAL_OFFSET_TABLE_+0x70>
    800017f4:	0007b503          	ld	a0,0(a5)
    800017f8:	00002097          	auipc	ra,0x2
    800017fc:	8f4080e7          	jalr	-1804(ra) # 800030ec <_ZN3SCB6signalEv>
                break;
    80001800:	e2dff06f          	j	8000162c <interruptHandler+0x104>
                CCB::semInput->signal();
    80001804:	00006797          	auipc	a5,0x6
    80001808:	0b47b783          	ld	a5,180(a5) # 800078b8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00002097          	auipc	ra,0x2
    80001814:	8dc080e7          	jalr	-1828(ra) # 800030ec <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001818:	00006517          	auipc	a0,0x6
    8000181c:	04853503          	ld	a0,72(a0) # 80007860 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001820:	00000097          	auipc	ra,0x0
    80001824:	678080e7          	jalr	1656(ra) # 80001e98 <_ZN8IOBuffer9peekFrontEv>
    80001828:	00051e63          	bnez	a0,80001844 <interruptHandler+0x31c>
                    CCB::inputBufferEmpty->wait();
    8000182c:	00006797          	auipc	a5,0x6
    80001830:	07c7b783          	ld	a5,124(a5) # 800078a8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80001834:	0007b503          	ld	a0,0(a5)
    80001838:	00002097          	auipc	ra,0x2
    8000183c:	820080e7          	jalr	-2016(ra) # 80003058 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001840:	fd9ff06f          	j	80001818 <interruptHandler+0x2f0>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    80001844:	00006517          	auipc	a0,0x6
    80001848:	01c53503          	ld	a0,28(a0) # 80007860 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000184c:	00000097          	auipc	ra,0x0
    80001850:	5bc080e7          	jalr	1468(ra) # 80001e08 <_ZN8IOBuffer8popFrontEv>
    80001854:	00006797          	auipc	a5,0x6
    80001858:	03c7b783          	ld	a5,60(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000185c:	0007b783          	ld	a5,0(a5)
    80001860:	0187b783          	ld	a5,24(a5)
    80001864:	04a7b823          	sd	a0,80(a5)
                break;
    80001868:	dc5ff06f          	j	8000162c <interruptHandler+0x104>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    8000186c:	fc843783          	ld	a5,-56(s0)
    80001870:	eff7f793          	andi	a5,a5,-257
    80001874:	fcf43423          	sd	a5,-56(s0)
                break;
    80001878:	db5ff06f          	j	8000162c <interruptHandler+0x104>
                printError();
    8000187c:	00002097          	auipc	ra,0x2
    80001880:	f70080e7          	jalr	-144(ra) # 800037ec <_Z10printErrorv>
                break;
    80001884:	da9ff06f          	j	8000162c <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    80001888:	00006497          	auipc	s1,0x6
    8000188c:	fe84b483          	ld	s1,-24(s1) # 80007870 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001890:	0004b783          	ld	a5,0(s1)
    80001894:	00178793          	addi	a5,a5,1
    80001898:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    8000189c:	00000097          	auipc	ra,0x0
    800018a0:	0f8080e7          	jalr	248(ra) # 80001994 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800018a4:	00006797          	auipc	a5,0x6
    800018a8:	fec7b783          	ld	a5,-20(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018ac:	0007b783          	ld	a5,0(a5)
    800018b0:	0407b703          	ld	a4,64(a5)
    800018b4:	0004b783          	ld	a5,0(s1)
    800018b8:	00e7f863          	bgeu	a5,a4,800018c8 <interruptHandler+0x3a0>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018bc:	00200793          	li	a5,2
    800018c0:	1447b073          	csrc	sip,a5
    }
    800018c4:	d79ff06f          	j	8000163c <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    800018c8:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800018cc:	00000097          	auipc	ra,0x0
    800018d0:	1c0080e7          	jalr	448(ra) # 80001a8c <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018d4:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018d8:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018dc:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018e0:	10079073          	csrw	sstatus,a5
    }
    800018e4:	fd9ff06f          	j	800018bc <interruptHandler+0x394>
        size_t code = plic_claim();
    800018e8:	00003097          	auipc	ra,0x3
    800018ec:	e1c080e7          	jalr	-484(ra) # 80004704 <plic_claim>
        if(code == CONSOLE_IRQ) {
    800018f0:	00a00793          	li	a5,10
    800018f4:	d4f504e3          	beq	a0,a5,8000163c <interruptHandler+0x114>
            plic_complete(code);
    800018f8:	00003097          	auipc	ra,0x3
    800018fc:	e44080e7          	jalr	-444(ra) # 8000473c <plic_complete>
    80001900:	d3dff06f          	j	8000163c <interruptHandler+0x114>

0000000080001904 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001904:	ff010113          	addi	sp,sp,-16
    80001908:	00813423          	sd	s0,8(sp)
    8000190c:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001910:	00006797          	auipc	a5,0x6
    80001914:	0007b783          	ld	a5,0(a5) # 80007910 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001918:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    8000191c:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001920:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001924:	00078e63          	beqz	a5,80001940 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    80001928:	0307b683          	ld	a3,48(a5)
    8000192c:	00e6fa63          	bgeu	a3,a4,80001940 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001930:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001934:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001938:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000193c:	fe9ff06f          	j	80001924 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001940:	00100693          	li	a3,1
    80001944:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    80001948:	02060663          	beqz	a2,80001974 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    8000194c:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001950:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001954:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    80001958:	00078863          	beqz	a5,80001968 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    8000195c:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001960:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001964:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    80001968:	00813403          	ld	s0,8(sp)
    8000196c:	01010113          	addi	sp,sp,16
    80001970:	00008067          	ret
        head = process;
    80001974:	00006717          	auipc	a4,0x6
    80001978:	f8a73e23          	sd	a0,-100(a4) # 80007910 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    8000197c:	00f53023          	sd	a5,0(a0)
        if(curr) {
    80001980:	fe0784e3          	beqz	a5,80001968 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001984:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001988:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    8000198c:	02b7b823          	sd	a1,48(a5)
    }
    80001990:	fd9ff06f          	j	80001968 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

0000000080001994 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    80001994:	00006517          	auipc	a0,0x6
    80001998:	f7c53503          	ld	a0,-132(a0) # 80007910 <_ZN17SleepingProcesses4headE>
    8000199c:	08050063          	beqz	a0,80001a1c <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800019a0:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800019a4:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800019a8:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800019ac:	06050263          	beqz	a0,80001a10 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800019b0:	03053783          	ld	a5,48(a0)
    800019b4:	04079e63          	bnez	a5,80001a10 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800019b8:	fe010113          	addi	sp,sp,-32
    800019bc:	00113c23          	sd	ra,24(sp)
    800019c0:	00813823          	sd	s0,16(sp)
    800019c4:	00913423          	sd	s1,8(sp)
    800019c8:	02010413          	addi	s0,sp,32
    800019cc:	00c0006f          	j	800019d8 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    800019d0:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800019d4:	02079063          	bnez	a5,800019f4 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800019d8:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800019dc:	00053023          	sd	zero,0(a0)
        blocked = newState;
    800019e0:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    800019e4:	00001097          	auipc	ra,0x1
    800019e8:	cbc080e7          	jalr	-836(ra) # 800026a0 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019ec:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019f0:	fe0490e3          	bnez	s1,800019d0 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019f4:	00006797          	auipc	a5,0x6
    800019f8:	f0a7be23          	sd	a0,-228(a5) # 80007910 <_ZN17SleepingProcesses4headE>
}
    800019fc:	01813083          	ld	ra,24(sp)
    80001a00:	01013403          	ld	s0,16(sp)
    80001a04:	00813483          	ld	s1,8(sp)
    80001a08:	02010113          	addi	sp,sp,32
    80001a0c:	00008067          	ret
    head = curr;
    80001a10:	00006797          	auipc	a5,0x6
    80001a14:	f0a7b023          	sd	a0,-256(a5) # 80007910 <_ZN17SleepingProcesses4headE>
    80001a18:	00008067          	ret
    80001a1c:	00008067          	ret

0000000080001a20 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a20:	ff010113          	addi	sp,sp,-16
    80001a24:	00113423          	sd	ra,8(sp)
    80001a28:	00813023          	sd	s0,0(sp)
    80001a2c:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	ad8080e7          	jalr	-1320(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a38:	00006797          	auipc	a5,0x6
    80001a3c:	ee07b783          	ld	a5,-288(a5) # 80007918 <_ZN3PCB7runningE>
    80001a40:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a44:	00070513          	mv	a0,a4
    running->main();
    80001a48:	0207b783          	ld	a5,32(a5)
    80001a4c:	000780e7          	jalr	a5
    thread_exit();
    80001a50:	00000097          	auipc	ra,0x0
    80001a54:	850080e7          	jalr	-1968(ra) # 800012a0 <_Z11thread_exitv>
}
    80001a58:	00813083          	ld	ra,8(sp)
    80001a5c:	00013403          	ld	s0,0(sp)
    80001a60:	01010113          	addi	sp,sp,16
    80001a64:	00008067          	ret

0000000080001a68 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001a68:	ff010113          	addi	sp,sp,-16
    80001a6c:	00813423          	sd	s0,8(sp)
    80001a70:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001a74:	01300793          	li	a5,19
    80001a78:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001a7c:	00000073          	ecall
}
    80001a80:	00813403          	ld	s0,8(sp)
    80001a84:	01010113          	addi	sp,sp,16
    80001a88:	00008067          	ret

0000000080001a8c <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001a8c:	fe010113          	addi	sp,sp,-32
    80001a90:	00113c23          	sd	ra,24(sp)
    80001a94:	00813823          	sd	s0,16(sp)
    80001a98:	00913423          	sd	s1,8(sp)
    80001a9c:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001aa0:	00006497          	auipc	s1,0x6
    80001aa4:	e784b483          	ld	s1,-392(s1) # 80007918 <_ZN3PCB7runningE>
        return finished;
    80001aa8:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001aac:	00079663          	bnez	a5,80001ab8 <_ZN3PCB8dispatchEv+0x2c>
    80001ab0:	0294c783          	lbu	a5,41(s1)
    80001ab4:	04078263          	beqz	a5,80001af8 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001ab8:	00001097          	auipc	ra,0x1
    80001abc:	c40080e7          	jalr	-960(ra) # 800026f8 <_ZN9Scheduler3getEv>
    80001ac0:	00006797          	auipc	a5,0x6
    80001ac4:	e4a7bc23          	sd	a0,-424(a5) # 80007918 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001ac8:	04854783          	lbu	a5,72(a0)
    80001acc:	02078e63          	beqz	a5,80001b08 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001ad0:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001ad4:	01853583          	ld	a1,24(a0)
    80001ad8:	0184b503          	ld	a0,24(s1)
    80001adc:	fffff097          	auipc	ra,0xfffff
    80001ae0:	64c080e7          	jalr	1612(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001ae4:	01813083          	ld	ra,24(sp)
    80001ae8:	01013403          	ld	s0,16(sp)
    80001aec:	00813483          	ld	s1,8(sp)
    80001af0:	02010113          	addi	sp,sp,32
    80001af4:	00008067          	ret
        Scheduler::put(old);
    80001af8:	00048513          	mv	a0,s1
    80001afc:	00001097          	auipc	ra,0x1
    80001b00:	ba4080e7          	jalr	-1116(ra) # 800026a0 <_ZN9Scheduler3putEP3PCB>
    80001b04:	fb5ff06f          	j	80001ab8 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b08:	01853583          	ld	a1,24(a0)
    80001b0c:	0184b503          	ld	a0,24(s1)
    80001b10:	fffff097          	auipc	ra,0xfffff
    80001b14:	62c080e7          	jalr	1580(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b18:	fcdff06f          	j	80001ae4 <_ZN3PCB8dispatchEv+0x58>

0000000080001b1c <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001b1c:	fe010113          	addi	sp,sp,-32
    80001b20:	00113c23          	sd	ra,24(sp)
    80001b24:	00813823          	sd	s0,16(sp)
    80001b28:	00913423          	sd	s1,8(sp)
    80001b2c:	02010413          	addi	s0,sp,32
    80001b30:	00050493          	mv	s1,a0
    80001b34:	00053023          	sd	zero,0(a0)
    80001b38:	00053c23          	sd	zero,24(a0)
    80001b3c:	02053823          	sd	zero,48(a0)
    80001b40:	00100793          	li	a5,1
    80001b44:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001b48:	02050523          	sb	zero,42(a0)
    80001b4c:	020504a3          	sb	zero,41(a0)
    80001b50:	02050423          	sb	zero,40(a0)
    main = main_;
    80001b54:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001b58:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001b5c:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001b60:	10800513          	li	a0,264
    80001b64:	00001097          	auipc	ra,0x1
    80001b68:	6cc080e7          	jalr	1740(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
    80001b6c:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001b70:	00008537          	lui	a0,0x8
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	6bc080e7          	jalr	1724(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
    80001b7c:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001b80:	000087b7          	lui	a5,0x8
    80001b84:	00f50533          	add	a0,a0,a5
    80001b88:	0184b783          	ld	a5,24(s1)
    80001b8c:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001b90:	0184b783          	ld	a5,24(s1)
    80001b94:	00000717          	auipc	a4,0x0
    80001b98:	e8c70713          	addi	a4,a4,-372 # 80001a20 <_ZN3PCB15proccessWrapperEv>
    80001b9c:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001ba0:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ba4:	0204b783          	ld	a5,32(s1)
    80001ba8:	00078c63          	beqz	a5,80001bc0 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001bac:	01813083          	ld	ra,24(sp)
    80001bb0:	01013403          	ld	s0,16(sp)
    80001bb4:	00813483          	ld	s1,8(sp)
    80001bb8:	02010113          	addi	sp,sp,32
    80001bbc:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001bc0:	04048423          	sb	zero,72(s1)
}
    80001bc4:	fe9ff06f          	j	80001bac <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001bc8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001bc8:	fe010113          	addi	sp,sp,-32
    80001bcc:	00113c23          	sd	ra,24(sp)
    80001bd0:	00813823          	sd	s0,16(sp)
    80001bd4:	00913423          	sd	s1,8(sp)
    80001bd8:	02010413          	addi	s0,sp,32
    80001bdc:	00050493          	mv	s1,a0
    delete[] stack;
    80001be0:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001be4:	00050663          	beqz	a0,80001bf0 <_ZN3PCBD1Ev+0x28>
    80001be8:	00001097          	auipc	ra,0x1
    80001bec:	ec0080e7          	jalr	-320(ra) # 80002aa8 <_ZdaPv>
    delete[] sysStack;
    80001bf0:	0104b503          	ld	a0,16(s1)
    80001bf4:	00050663          	beqz	a0,80001c00 <_ZN3PCBD1Ev+0x38>
    80001bf8:	00001097          	auipc	ra,0x1
    80001bfc:	eb0080e7          	jalr	-336(ra) # 80002aa8 <_ZdaPv>
}
    80001c00:	01813083          	ld	ra,24(sp)
    80001c04:	01013403          	ld	s0,16(sp)
    80001c08:	00813483          	ld	s1,8(sp)
    80001c0c:	02010113          	addi	sp,sp,32
    80001c10:	00008067          	ret

0000000080001c14 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001c14:	ff010113          	addi	sp,sp,-16
    80001c18:	00113423          	sd	ra,8(sp)
    80001c1c:	00813023          	sd	s0,0(sp)
    80001c20:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c24:	00001097          	auipc	ra,0x1
    80001c28:	60c080e7          	jalr	1548(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001c2c:	00813083          	ld	ra,8(sp)
    80001c30:	00013403          	ld	s0,0(sp)
    80001c34:	01010113          	addi	sp,sp,16
    80001c38:	00008067          	ret

0000000080001c3c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c3c:	ff010113          	addi	sp,sp,-16
    80001c40:	00113423          	sd	ra,8(sp)
    80001c44:	00813023          	sd	s0,0(sp)
    80001c48:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c4c:	00001097          	auipc	ra,0x1
    80001c50:	748080e7          	jalr	1864(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c54:	00813083          	ld	ra,8(sp)
    80001c58:	00013403          	ld	s0,0(sp)
    80001c5c:	01010113          	addi	sp,sp,16
    80001c60:	00008067          	ret

0000000080001c64 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001c64:	fd010113          	addi	sp,sp,-48
    80001c68:	02113423          	sd	ra,40(sp)
    80001c6c:	02813023          	sd	s0,32(sp)
    80001c70:	00913c23          	sd	s1,24(sp)
    80001c74:	01213823          	sd	s2,16(sp)
    80001c78:	01313423          	sd	s3,8(sp)
    80001c7c:	03010413          	addi	s0,sp,48
    80001c80:	00050913          	mv	s2,a0
    80001c84:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001c88:	05000513          	li	a0,80
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	f88080e7          	jalr	-120(ra) # 80001c14 <_ZN3PCBnwEm>
    80001c94:	00050493          	mv	s1,a0
    80001c98:	00098693          	mv	a3,s3
    80001c9c:	00200613          	li	a2,2
    80001ca0:	00090593          	mv	a1,s2
    80001ca4:	00000097          	auipc	ra,0x0
    80001ca8:	e78080e7          	jalr	-392(ra) # 80001b1c <_ZN3PCBC1EPFvvEmPv>
    80001cac:	0200006f          	j	80001ccc <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001cb0:	00050913          	mv	s2,a0
    80001cb4:	00048513          	mv	a0,s1
    80001cb8:	00000097          	auipc	ra,0x0
    80001cbc:	f84080e7          	jalr	-124(ra) # 80001c3c <_ZN3PCBdlEPv>
    80001cc0:	00090513          	mv	a0,s2
    80001cc4:	00007097          	auipc	ra,0x7
    80001cc8:	db4080e7          	jalr	-588(ra) # 80008a78 <_Unwind_Resume>
}
    80001ccc:	00048513          	mv	a0,s1
    80001cd0:	02813083          	ld	ra,40(sp)
    80001cd4:	02013403          	ld	s0,32(sp)
    80001cd8:	01813483          	ld	s1,24(sp)
    80001cdc:	01013903          	ld	s2,16(sp)
    80001ce0:	00813983          	ld	s3,8(sp)
    80001ce4:	03010113          	addi	sp,sp,48
    80001ce8:	00008067          	ret

0000000080001cec <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001cec:	ff010113          	addi	sp,sp,-16
    80001cf0:	00813423          	sd	s0,8(sp)
    80001cf4:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001cf8:	00006797          	auipc	a5,0x6
    80001cfc:	c207b783          	ld	a5,-992(a5) # 80007918 <_ZN3PCB7runningE>
    80001d00:	0187b503          	ld	a0,24(a5)
    80001d04:	00813403          	ld	s0,8(sp)
    80001d08:	01010113          	addi	sp,sp,16
    80001d0c:	00008067          	ret

0000000080001d10 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    80001d10:	fe010113          	addi	sp,sp,-32
    80001d14:	00113c23          	sd	ra,24(sp)
    80001d18:	00813823          	sd	s0,16(sp)
    80001d1c:	00913423          	sd	s1,8(sp)
    80001d20:	01213023          	sd	s2,0(sp)
    80001d24:	02010413          	addi	s0,sp,32
    80001d28:	00050493          	mv	s1,a0
    80001d2c:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001d30:	01000513          	li	a0,16
    80001d34:	00001097          	auipc	ra,0x1
    80001d38:	4fc080e7          	jalr	1276(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001d3c:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001d40:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001d44:	0004b783          	ld	a5,0(s1)
    80001d48:	02078863          	beqz	a5,80001d78 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001d4c:	0084b783          	ld	a5,8(s1)
    80001d50:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001d54:	0084b783          	ld	a5,8(s1)
    80001d58:	0007b783          	ld	a5,0(a5)
    80001d5c:	00f4b423          	sd	a5,8(s1)
    }
}
    80001d60:	01813083          	ld	ra,24(sp)
    80001d64:	01013403          	ld	s0,16(sp)
    80001d68:	00813483          	ld	s1,8(sp)
    80001d6c:	00013903          	ld	s2,0(sp)
    80001d70:	02010113          	addi	sp,sp,32
    80001d74:	00008067          	ret
        head = tail = newElem;
    80001d78:	00a4b423          	sd	a0,8(s1)
    80001d7c:	00a4b023          	sd	a0,0(s1)
    80001d80:	fe1ff06f          	j	80001d60 <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001d84 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001d84:	fe010113          	addi	sp,sp,-32
    80001d88:	00113c23          	sd	ra,24(sp)
    80001d8c:	00813823          	sd	s0,16(sp)
    80001d90:	00913423          	sd	s1,8(sp)
    80001d94:	02010413          	addi	s0,sp,32
    80001d98:	00c0006f          	j	80001da4 <_ZN3CCB9inputBodyEPv+0x20>
        thread_dispatch();
    80001d9c:	fffff097          	auipc	ra,0xfffff
    80001da0:	4d8080e7          	jalr	1240(ra) # 80001274 <_Z15thread_dispatchv>
        if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001da4:	00006797          	auipc	a5,0x6
    80001da8:	aa47b783          	ld	a5,-1372(a5) # 80007848 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001dac:	0007b783          	ld	a5,0(a5)
    80001db0:	0007c783          	lbu	a5,0(a5)
    80001db4:	0017f793          	andi	a5,a5,1
    80001db8:	fe0782e3          	beqz	a5,80001d9c <_ZN3CCB9inputBodyEPv+0x18>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001dbc:	00006797          	auipc	a5,0x6
    80001dc0:	a7c7b783          	ld	a5,-1412(a5) # 80007838 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001dc4:	0007b783          	ld	a5,0(a5)
    80001dc8:	00006497          	auipc	s1,0x6
    80001dcc:	b6048493          	addi	s1,s1,-1184 # 80007928 <_ZN3CCB11inputBufferE>
    80001dd0:	0007c583          	lbu	a1,0(a5)
    80001dd4:	00048513          	mv	a0,s1
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	f38080e7          	jalr	-200(ra) # 80001d10 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001de0:	0104b503          	ld	a0,16(s1)
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	5fc080e7          	jalr	1532(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    80001dec:	00a00513          	li	a0,10
    80001df0:	00003097          	auipc	ra,0x3
    80001df4:	94c080e7          	jalr	-1716(ra) # 8000473c <plic_complete>
            sem_wait(semInput);
    80001df8:	0184b503          	ld	a0,24(s1)
    80001dfc:	fffff097          	auipc	ra,0xfffff
    80001e00:	59c080e7          	jalr	1436(ra) # 80001398 <_Z8sem_waitP3SCB>
    80001e04:	f99ff06f          	j	80001d9c <_ZN3CCB9inputBodyEPv+0x18>

0000000080001e08 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001e08:	fe010113          	addi	sp,sp,-32
    80001e0c:	00113c23          	sd	ra,24(sp)
    80001e10:	00813823          	sd	s0,16(sp)
    80001e14:	00913423          	sd	s1,8(sp)
    80001e18:	02010413          	addi	s0,sp,32
    80001e1c:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001e20:	00053503          	ld	a0,0(a0)
    80001e24:	04050063          	beqz	a0,80001e64 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001e28:	00053703          	ld	a4,0(a0)
    80001e2c:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001e30:	0087b703          	ld	a4,8(a5)
    80001e34:	02e50463          	beq	a0,a4,80001e5c <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001e38:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001e3c:	00001097          	auipc	ra,0x1
    80001e40:	558080e7          	jalr	1368(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001e44:	00048513          	mv	a0,s1
    80001e48:	01813083          	ld	ra,24(sp)
    80001e4c:	01013403          	ld	s0,16(sp)
    80001e50:	00813483          	ld	s1,8(sp)
    80001e54:	02010113          	addi	sp,sp,32
    80001e58:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001e5c:	0007b423          	sd	zero,8(a5)
    80001e60:	fd9ff06f          	j	80001e38 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001e64:	00000493          	li	s1,0
    80001e68:	fddff06f          	j	80001e44 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001e6c <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001e6c:	ff010113          	addi	sp,sp,-16
    80001e70:	00813423          	sd	s0,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001e78:	00853783          	ld	a5,8(a0)
    80001e7c:	00078a63          	beqz	a5,80001e90 <_ZN8IOBuffer8peekBackEv+0x24>
    80001e80:	0087c503          	lbu	a0,8(a5)
}
    80001e84:	00813403          	ld	s0,8(sp)
    80001e88:	01010113          	addi	sp,sp,16
    80001e8c:	00008067          	ret
    return tail ? tail->data : 0;
    80001e90:	00000513          	li	a0,0
    80001e94:	ff1ff06f          	j	80001e84 <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001e98 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00813423          	sd	s0,8(sp)
    80001ea0:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001ea4:	00053783          	ld	a5,0(a0)
    80001ea8:	00078a63          	beqz	a5,80001ebc <_ZN8IOBuffer9peekFrontEv+0x24>
    80001eac:	0087c503          	lbu	a0,8(a5)
}
    80001eb0:	00813403          	ld	s0,8(sp)
    80001eb4:	01010113          	addi	sp,sp,16
    80001eb8:	00008067          	ret
    return head ? head->data : 0;
    80001ebc:	00000513          	li	a0,0
    80001ec0:	ff1ff06f          	j	80001eb0 <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001ec4 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001ec4:	fe010113          	addi	sp,sp,-32
    80001ec8:	00113c23          	sd	ra,24(sp)
    80001ecc:	00813823          	sd	s0,16(sp)
    80001ed0:	00913423          	sd	s1,8(sp)
    80001ed4:	02010413          	addi	s0,sp,32
    80001ed8:	00c0006f          	j	80001ee4 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    80001edc:	fffff097          	auipc	ra,0xfffff
    80001ee0:	398080e7          	jalr	920(ra) # 80001274 <_Z15thread_dispatchv>
        if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001ee4:	00006797          	auipc	a5,0x6
    80001ee8:	9647b783          	ld	a5,-1692(a5) # 80007848 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001eec:	0007b783          	ld	a5,0(a5)
    80001ef0:	0007c783          	lbu	a5,0(a5)
    80001ef4:	0207f793          	andi	a5,a5,32
    80001ef8:	fe0782e3          	beqz	a5,80001edc <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80001efc:	00006517          	auipc	a0,0x6
    80001f00:	a4c50513          	addi	a0,a0,-1460 # 80007948 <_ZN3CCB12outputBufferE>
    80001f04:	00000097          	auipc	ra,0x0
    80001f08:	f94080e7          	jalr	-108(ra) # 80001e98 <_ZN8IOBuffer9peekFrontEv>
    80001f0c:	fc0508e3          	beqz	a0,80001edc <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001f10:	00006797          	auipc	a5,0x6
    80001f14:	9587b783          	ld	a5,-1704(a5) # 80007868 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001f18:	0007b483          	ld	s1,0(a5)
    80001f1c:	00006517          	auipc	a0,0x6
    80001f20:	a2c50513          	addi	a0,a0,-1492 # 80007948 <_ZN3CCB12outputBufferE>
    80001f24:	00000097          	auipc	ra,0x0
    80001f28:	ee4080e7          	jalr	-284(ra) # 80001e08 <_ZN8IOBuffer8popFrontEv>
    80001f2c:	00a48023          	sb	a0,0(s1)
                plic_complete(CONSOLE_IRQ);
    80001f30:	00a00513          	li	a0,10
    80001f34:	00003097          	auipc	ra,0x3
    80001f38:	808080e7          	jalr	-2040(ra) # 8000473c <plic_complete>
                sem_wait(semOutput);
    80001f3c:	00006517          	auipc	a0,0x6
    80001f40:	a1c53503          	ld	a0,-1508(a0) # 80007958 <_ZN3CCB9semOutputE>
    80001f44:	fffff097          	auipc	ra,0xfffff
    80001f48:	454080e7          	jalr	1108(ra) # 80001398 <_Z8sem_waitP3SCB>
    80001f4c:	f91ff06f          	j	80001edc <_ZN3CCB10outputBodyEPv+0x18>

0000000080001f50 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80001f50:	f8010113          	addi	sp,sp,-128
    80001f54:	06113c23          	sd	ra,120(sp)
    80001f58:	06813823          	sd	s0,112(sp)
    80001f5c:	06913423          	sd	s1,104(sp)
    80001f60:	07213023          	sd	s2,96(sp)
    80001f64:	05313c23          	sd	s3,88(sp)
    80001f68:	05413823          	sd	s4,80(sp)
    80001f6c:	05513423          	sd	s5,72(sp)
    80001f70:	05613023          	sd	s6,64(sp)
    80001f74:	03713c23          	sd	s7,56(sp)
    80001f78:	03813823          	sd	s8,48(sp)
    80001f7c:	03913423          	sd	s9,40(sp)
    80001f80:	08010413          	addi	s0,sp,128
        char input[30];
        int n, threadNum;

        printString("Unesite broj proizvodjaca?\n");
    80001f84:	00004517          	auipc	a0,0x4
    80001f88:	1ac50513          	addi	a0,a0,428 # 80006130 <CONSOLE_STATUS+0x120>
    80001f8c:	00001097          	auipc	ra,0x1
    80001f90:	5b4080e7          	jalr	1460(ra) # 80003540 <_Z11printStringPKc>
        getString(input, 30);
    80001f94:	01e00593          	li	a1,30
    80001f98:	f8040493          	addi	s1,s0,-128
    80001f9c:	00048513          	mv	a0,s1
    80001fa0:	00001097          	auipc	ra,0x1
    80001fa4:	61c080e7          	jalr	1564(ra) # 800035bc <_Z9getStringPci>
        threadNum = stringToInt(input);
    80001fa8:	00048513          	mv	a0,s1
    80001fac:	00001097          	auipc	ra,0x1
    80001fb0:	6dc080e7          	jalr	1756(ra) # 80003688 <_Z11stringToIntPKc>
    80001fb4:	00050993          	mv	s3,a0

        printString("Unesite velicinu bafera?\n");
    80001fb8:	00004517          	auipc	a0,0x4
    80001fbc:	19850513          	addi	a0,a0,408 # 80006150 <CONSOLE_STATUS+0x140>
    80001fc0:	00001097          	auipc	ra,0x1
    80001fc4:	580080e7          	jalr	1408(ra) # 80003540 <_Z11printStringPKc>
        getString(input, 30);
    80001fc8:	01e00593          	li	a1,30
    80001fcc:	00048513          	mv	a0,s1
    80001fd0:	00001097          	auipc	ra,0x1
    80001fd4:	5ec080e7          	jalr	1516(ra) # 800035bc <_Z9getStringPci>
        n = stringToInt(input);
    80001fd8:	00048513          	mv	a0,s1
    80001fdc:	00001097          	auipc	ra,0x1
    80001fe0:	6ac080e7          	jalr	1708(ra) # 80003688 <_Z11stringToIntPKc>
    80001fe4:	00050493          	mv	s1,a0

        printString("Broj proizvodjaca "); printInt(threadNum);
    80001fe8:	00004517          	auipc	a0,0x4
    80001fec:	18850513          	addi	a0,a0,392 # 80006170 <CONSOLE_STATUS+0x160>
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	550080e7          	jalr	1360(ra) # 80003540 <_Z11printStringPKc>
    80001ff8:	00000613          	li	a2,0
    80001ffc:	00a00593          	li	a1,10
    80002000:	00098513          	mv	a0,s3
    80002004:	00001097          	auipc	ra,0x1
    80002008:	6d4080e7          	jalr	1748(ra) # 800036d8 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000200c:	00004517          	auipc	a0,0x4
    80002010:	17c50513          	addi	a0,a0,380 # 80006188 <CONSOLE_STATUS+0x178>
    80002014:	00001097          	auipc	ra,0x1
    80002018:	52c080e7          	jalr	1324(ra) # 80003540 <_Z11printStringPKc>
    8000201c:	00000613          	li	a2,0
    80002020:	00a00593          	li	a1,10
    80002024:	00048513          	mv	a0,s1
    80002028:	00001097          	auipc	ra,0x1
    8000202c:	6b0080e7          	jalr	1712(ra) # 800036d8 <_Z8printIntiii>
        printString(".\n");
    80002030:	00004517          	auipc	a0,0x4
    80002034:	17050513          	addi	a0,a0,368 # 800061a0 <CONSOLE_STATUS+0x190>
    80002038:	00001097          	auipc	ra,0x1
    8000203c:	508080e7          	jalr	1288(ra) # 80003540 <_Z11printStringPKc>

        BufferCPP *buffer = new BufferCPP(n);
    80002040:	03800513          	li	a0,56
    80002044:	00001097          	auipc	ra,0x1
    80002048:	988080e7          	jalr	-1656(ra) # 800029cc <_Znwm>
    8000204c:	00050b13          	mv	s6,a0
    80002050:	00048593          	mv	a1,s1
    80002054:	00002097          	auipc	ra,0x2
    80002058:	880080e7          	jalr	-1920(ra) # 800038d4 <_ZN9BufferCPPC1Ei>

        waitForAll = new Semaphore(0);
    8000205c:	01000513          	li	a0,16
    80002060:	00001097          	auipc	ra,0x1
    80002064:	d98080e7          	jalr	-616(ra) # 80002df8 <_ZN9SemaphorenwEm>
    80002068:	00050493          	mv	s1,a0
    8000206c:	00000593          	li	a1,0
    80002070:	00001097          	auipc	ra,0x1
    80002074:	c68080e7          	jalr	-920(ra) # 80002cd8 <_ZN9SemaphoreC1Ej>
    80002078:	00006717          	auipc	a4,0x6
    8000207c:	8f870713          	addi	a4,a4,-1800 # 80007970 <_ZN19ConsumerProducerCPP9threadEndE>
    80002080:	00973423          	sd	s1,8(a4)
        Thread *producers[threadNum];
    80002084:	00399793          	slli	a5,s3,0x3
    80002088:	00f78793          	addi	a5,a5,15
    8000208c:	ff07f793          	andi	a5,a5,-16
    80002090:	40f10133          	sub	sp,sp,a5
    80002094:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80002098:	0019869b          	addiw	a3,s3,1
    8000209c:	00169793          	slli	a5,a3,0x1
    800020a0:	00d787b3          	add	a5,a5,a3
    800020a4:	00379793          	slli	a5,a5,0x3
    800020a8:	00f78793          	addi	a5,a5,15
    800020ac:	ff07f793          	andi	a5,a5,-16
    800020b0:	40f10133          	sub	sp,sp,a5
    800020b4:	00010a93          	mv	s5,sp

        threadData[threadNum].id = threadNum;
    800020b8:	00199493          	slli	s1,s3,0x1
    800020bc:	013484b3          	add	s1,s1,s3
    800020c0:	00349493          	slli	s1,s1,0x3
    800020c4:	009a84b3          	add	s1,s5,s1
    800020c8:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    800020cc:	0164b423          	sd	s6,8(s1)
        threadData[threadNum].sem = waitForAll;
    800020d0:	00873783          	ld	a5,8(a4)
    800020d4:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800020d8:	01800513          	li	a0,24
    800020dc:	00001097          	auipc	ra,0x1
    800020e0:	a2c080e7          	jalr	-1492(ra) # 80002b08 <_ZN6ThreadnwEm>
    800020e4:	00050c13          	mv	s8,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800020e8:	00001097          	auipc	ra,0x1
    800020ec:	b08080e7          	jalr	-1272(ra) # 80002bf0 <_ZN6ThreadC1Ev>
    800020f0:	00005797          	auipc	a5,0x5
    800020f4:	69878793          	addi	a5,a5,1688 # 80007788 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800020f8:	00fc3023          	sd	a5,0(s8)
    800020fc:	009c3823          	sd	s1,16(s8)
        consumer->start();
    80002100:	000c0513          	mv	a0,s8
    80002104:	00001097          	auipc	ra,0x1
    80002108:	abc080e7          	jalr	-1348(ra) # 80002bc0 <_ZN6Thread5startEv>

        threadData[0].id = 0;
    8000210c:	000aa023          	sw	zero,0(s5)
        threadData[0].buffer = buffer;
    80002110:	016ab423          	sd	s6,8(s5)
        threadData[0].sem = waitForAll;
    80002114:	00006797          	auipc	a5,0x6
    80002118:	8647b783          	ld	a5,-1948(a5) # 80007978 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000211c:	00fab823          	sd	a5,16(s5)
        Thread *producerKeyboard = new ProducerKeyborad(&threadData[0]);
    80002120:	01800513          	li	a0,24
    80002124:	00001097          	auipc	ra,0x1
    80002128:	9e4080e7          	jalr	-1564(ra) # 80002b08 <_ZN6ThreadnwEm>
    8000212c:	00050b93          	mv	s7,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80002130:	00001097          	auipc	ra,0x1
    80002134:	ac0080e7          	jalr	-1344(ra) # 80002bf0 <_ZN6ThreadC1Ev>
    80002138:	00005797          	auipc	a5,0x5
    8000213c:	60078793          	addi	a5,a5,1536 # 80007738 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80002140:	00fbb023          	sd	a5,0(s7)
    80002144:	015bb823          	sd	s5,16(s7)
        producerKeyboard->start();
    80002148:	000b8513          	mv	a0,s7
    8000214c:	00001097          	auipc	ra,0x1
    80002150:	a74080e7          	jalr	-1420(ra) # 80002bc0 <_ZN6Thread5startEv>

        for (int i = 0; i < threadNum; i++) {
    80002154:	00000913          	li	s2,0
    80002158:	0300006f          	j	80002188 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x238>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    8000215c:	00005797          	auipc	a5,0x5
    80002160:	60478793          	addi	a5,a5,1540 # 80007760 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002164:	00fcb023          	sd	a5,0(s9)
    80002168:	009cb823          	sd	s1,16(s9)
            threadData[i].id = i;
            threadData[i].buffer = buffer;
            threadData[i].sem = waitForAll;

            producers[i] = new Producer(&threadData[i]);
    8000216c:	00391793          	slli	a5,s2,0x3
    80002170:	00fa07b3          	add	a5,s4,a5
    80002174:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80002178:	000c8513          	mv	a0,s9
    8000217c:	00001097          	auipc	ra,0x1
    80002180:	a44080e7          	jalr	-1468(ra) # 80002bc0 <_ZN6Thread5startEv>
        for (int i = 0; i < threadNum; i++) {
    80002184:	0019091b          	addiw	s2,s2,1
    80002188:	05395263          	bge	s2,s3,800021cc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
            threadData[i].id = i;
    8000218c:	00191493          	slli	s1,s2,0x1
    80002190:	012484b3          	add	s1,s1,s2
    80002194:	00349493          	slli	s1,s1,0x3
    80002198:	009a84b3          	add	s1,s5,s1
    8000219c:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    800021a0:	0164b423          	sd	s6,8(s1)
            threadData[i].sem = waitForAll;
    800021a4:	00005797          	auipc	a5,0x5
    800021a8:	7d47b783          	ld	a5,2004(a5) # 80007978 <_ZN19ConsumerProducerCPP10waitForAllE>
    800021ac:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    800021b0:	01800513          	li	a0,24
    800021b4:	00001097          	auipc	ra,0x1
    800021b8:	954080e7          	jalr	-1708(ra) # 80002b08 <_ZN6ThreadnwEm>
    800021bc:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800021c0:	00001097          	auipc	ra,0x1
    800021c4:	a30080e7          	jalr	-1488(ra) # 80002bf0 <_ZN6ThreadC1Ev>
    800021c8:	f95ff06f          	j	8000215c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x20c>

        }

        Thread::dispatch();
    800021cc:	00001097          	auipc	ra,0x1
    800021d0:	9cc080e7          	jalr	-1588(ra) # 80002b98 <_ZN6Thread8dispatchEv>

        for (int i = 0; i <= threadNum; i++) {
    800021d4:	00000493          	li	s1,0
    800021d8:	0099ce63          	blt	s3,s1,800021f4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2a4>
            waitForAll->wait();
    800021dc:	00005517          	auipc	a0,0x5
    800021e0:	79c53503          	ld	a0,1948(a0) # 80007978 <_ZN19ConsumerProducerCPP10waitForAllE>
    800021e4:	00001097          	auipc	ra,0x1
    800021e8:	b54080e7          	jalr	-1196(ra) # 80002d38 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    800021ec:	0014849b          	addiw	s1,s1,1
    800021f0:	fe9ff06f          	j	800021d8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x288>
        }

        delete waitForAll;
    800021f4:	00005517          	auipc	a0,0x5
    800021f8:	78453503          	ld	a0,1924(a0) # 80007978 <_ZN19ConsumerProducerCPP10waitForAllE>
    800021fc:	00050863          	beqz	a0,8000220c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
    80002200:	00053783          	ld	a5,0(a0)
    80002204:	0087b783          	ld	a5,8(a5)
    80002208:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000220c:	00000493          	li	s1,0
    80002210:	0080006f          	j	80002218 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        for (int i = 0; i < threadNum; i++) {
    80002214:	0014849b          	addiw	s1,s1,1
    80002218:	0334d263          	bge	s1,s3,8000223c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2ec>
            delete producers[i];
    8000221c:	00349793          	slli	a5,s1,0x3
    80002220:	00fa07b3          	add	a5,s4,a5
    80002224:	0007b503          	ld	a0,0(a5)
    80002228:	fe0506e3          	beqz	a0,80002214 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c4>
    8000222c:	00053783          	ld	a5,0(a0)
    80002230:	0087b783          	ld	a5,8(a5)
    80002234:	000780e7          	jalr	a5
    80002238:	fddff06f          	j	80002214 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c4>
        }
        delete producerKeyboard;
    8000223c:	000b8a63          	beqz	s7,80002250 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x300>
    80002240:	000bb783          	ld	a5,0(s7)
    80002244:	0087b783          	ld	a5,8(a5)
    80002248:	000b8513          	mv	a0,s7
    8000224c:	000780e7          	jalr	a5
        delete consumer;
    80002250:	000c0a63          	beqz	s8,80002264 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x314>
    80002254:	000c3783          	ld	a5,0(s8)
    80002258:	0087b783          	ld	a5,8(a5)
    8000225c:	000c0513          	mv	a0,s8
    80002260:	000780e7          	jalr	a5

    }
    80002264:	f8040113          	addi	sp,s0,-128
    80002268:	07813083          	ld	ra,120(sp)
    8000226c:	07013403          	ld	s0,112(sp)
    80002270:	06813483          	ld	s1,104(sp)
    80002274:	06013903          	ld	s2,96(sp)
    80002278:	05813983          	ld	s3,88(sp)
    8000227c:	05013a03          	ld	s4,80(sp)
    80002280:	04813a83          	ld	s5,72(sp)
    80002284:	04013b03          	ld	s6,64(sp)
    80002288:	03813b83          	ld	s7,56(sp)
    8000228c:	03013c03          	ld	s8,48(sp)
    80002290:	02813c83          	ld	s9,40(sp)
    80002294:	08010113          	addi	sp,sp,128
    80002298:	00008067          	ret
    8000229c:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800022a0:	000b0513          	mv	a0,s6
    800022a4:	00000097          	auipc	ra,0x0
    800022a8:	778080e7          	jalr	1912(ra) # 80002a1c <_ZdlPv>
    800022ac:	00048513          	mv	a0,s1
    800022b0:	00006097          	auipc	ra,0x6
    800022b4:	7c8080e7          	jalr	1992(ra) # 80008a78 <_Unwind_Resume>
    800022b8:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800022bc:	00048513          	mv	a0,s1
    800022c0:	00001097          	auipc	ra,0x1
    800022c4:	ad0080e7          	jalr	-1328(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    800022c8:	00090513          	mv	a0,s2
    800022cc:	00006097          	auipc	ra,0x6
    800022d0:	7ac080e7          	jalr	1964(ra) # 80008a78 <_Unwind_Resume>
    800022d4:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800022d8:	000c0513          	mv	a0,s8
    800022dc:	00001097          	auipc	ra,0x1
    800022e0:	854080e7          	jalr	-1964(ra) # 80002b30 <_ZN6ThreaddlEPv>
    800022e4:	00048513          	mv	a0,s1
    800022e8:	00006097          	auipc	ra,0x6
    800022ec:	790080e7          	jalr	1936(ra) # 80008a78 <_Unwind_Resume>
    800022f0:	00050493          	mv	s1,a0
        Thread *producerKeyboard = new ProducerKeyborad(&threadData[0]);
    800022f4:	000b8513          	mv	a0,s7
    800022f8:	00001097          	auipc	ra,0x1
    800022fc:	838080e7          	jalr	-1992(ra) # 80002b30 <_ZN6ThreaddlEPv>
    80002300:	00048513          	mv	a0,s1
    80002304:	00006097          	auipc	ra,0x6
    80002308:	774080e7          	jalr	1908(ra) # 80008a78 <_Unwind_Resume>
    8000230c:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80002310:	000c8513          	mv	a0,s9
    80002314:	00001097          	auipc	ra,0x1
    80002318:	81c080e7          	jalr	-2020(ra) # 80002b30 <_ZN6ThreaddlEPv>
    8000231c:	00048513          	mv	a0,s1
    80002320:	00006097          	auipc	ra,0x6
    80002324:	758080e7          	jalr	1880(ra) # 80008a78 <_Unwind_Resume>

0000000080002328 <_Z8userMainv>:
//#include "../test/ConsumerProducer_C_API_test.h" // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//#include "../test/ConsumerProducer_CPP_Sync_API_test.hpp" // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//#include "../test/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
void userMain() {
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00113423          	sd	ra,8(sp)
    80002330:	00813023          	sd	s0,0(sp)
    80002334:	01010413          	addi	s0,sp,16

    //producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    80002338:	00000097          	auipc	ra,0x0
    8000233c:	c18080e7          	jalr	-1000(ra) # 80001f50 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    80002340:	00813083          	ld	ra,8(sp)
    80002344:	00013403          	ld	s0,0(sp)
    80002348:	01010113          	addi	sp,sp,16
    8000234c:	00008067          	ret

0000000080002350 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80002350:	fd010113          	addi	sp,sp,-48
    80002354:	02113423          	sd	ra,40(sp)
    80002358:	02813023          	sd	s0,32(sp)
    8000235c:	00913c23          	sd	s1,24(sp)
    80002360:	01213823          	sd	s2,16(sp)
    80002364:	01313423          	sd	s3,8(sp)
    80002368:	03010413          	addi	s0,sp,48
    8000236c:	00050993          	mv	s3,a0
            int i = 0;
    80002370:	00000913          	li	s2,0
    80002374:	0100006f          	j	80002384 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80002378:	00a00513          	li	a0,10
    8000237c:	00001097          	auipc	ra,0x1
    80002380:	b48080e7          	jalr	-1208(ra) # 80002ec4 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80002384:	00005797          	auipc	a5,0x5
    80002388:	5ec7a783          	lw	a5,1516(a5) # 80007970 <_ZN19ConsumerProducerCPP9threadEndE>
    8000238c:	02079c63          	bnez	a5,800023c4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
                int key = td->buffer->get();
    80002390:	0109b783          	ld	a5,16(s3)
    80002394:	0087b503          	ld	a0,8(a5)
    80002398:	00002097          	auipc	ra,0x2
    8000239c:	804080e7          	jalr	-2044(ra) # 80003b9c <_ZN9BufferCPP3getEv>
                i++;
    800023a0:	0019049b          	addiw	s1,s2,1
    800023a4:	0004891b          	sext.w	s2,s1
                Console::putc(key);
    800023a8:	0ff57513          	andi	a0,a0,255
    800023ac:	00001097          	auipc	ra,0x1
    800023b0:	b18080e7          	jalr	-1256(ra) # 80002ec4 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    800023b4:	05000793          	li	a5,80
    800023b8:	02f4e4bb          	remw	s1,s1,a5
    800023bc:	fc0494e3          	bnez	s1,80002384 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800023c0:	fb9ff06f          	j	80002378 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
            td->sem->signal();
    800023c4:	0109b783          	ld	a5,16(s3)
    800023c8:	0107b503          	ld	a0,16(a5)
    800023cc:	00001097          	auipc	ra,0x1
    800023d0:	998080e7          	jalr	-1640(ra) # 80002d64 <_ZN9Semaphore6signalEv>
        }
    800023d4:	02813083          	ld	ra,40(sp)
    800023d8:	02013403          	ld	s0,32(sp)
    800023dc:	01813483          	ld	s1,24(sp)
    800023e0:	01013903          	ld	s2,16(sp)
    800023e4:	00813983          	ld	s3,8(sp)
    800023e8:	03010113          	addi	sp,sp,48
    800023ec:	00008067          	ret

00000000800023f0 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    800023f0:	ff010113          	addi	sp,sp,-16
    800023f4:	00113423          	sd	ra,8(sp)
    800023f8:	00813023          	sd	s0,0(sp)
    800023fc:	01010413          	addi	s0,sp,16
    80002400:	00005797          	auipc	a5,0x5
    80002404:	38878793          	addi	a5,a5,904 # 80007788 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80002408:	00f53023          	sd	a5,0(a0)
    8000240c:	00000097          	auipc	ra,0x0
    80002410:	534080e7          	jalr	1332(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002414:	00813083          	ld	ra,8(sp)
    80002418:	00013403          	ld	s0,0(sp)
    8000241c:	01010113          	addi	sp,sp,16
    80002420:	00008067          	ret

0000000080002424 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80002424:	fe010113          	addi	sp,sp,-32
    80002428:	00113c23          	sd	ra,24(sp)
    8000242c:	00813823          	sd	s0,16(sp)
    80002430:	00913423          	sd	s1,8(sp)
    80002434:	02010413          	addi	s0,sp,32
    80002438:	00050493          	mv	s1,a0
    8000243c:	00005797          	auipc	a5,0x5
    80002440:	34c78793          	addi	a5,a5,844 # 80007788 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80002444:	00f53023          	sd	a5,0(a0)
    80002448:	00000097          	auipc	ra,0x0
    8000244c:	4f8080e7          	jalr	1272(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002450:	00048513          	mv	a0,s1
    80002454:	00000097          	auipc	ra,0x0
    80002458:	6dc080e7          	jalr	1756(ra) # 80002b30 <_ZN6ThreaddlEPv>
    8000245c:	01813083          	ld	ra,24(sp)
    80002460:	01013403          	ld	s0,16(sp)
    80002464:	00813483          	ld	s1,8(sp)
    80002468:	02010113          	addi	sp,sp,32
    8000246c:	00008067          	ret

0000000080002470 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80002470:	ff010113          	addi	sp,sp,-16
    80002474:	00113423          	sd	ra,8(sp)
    80002478:	00813023          	sd	s0,0(sp)
    8000247c:	01010413          	addi	s0,sp,16
    80002480:	00005797          	auipc	a5,0x5
    80002484:	2b878793          	addi	a5,a5,696 # 80007738 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80002488:	00f53023          	sd	a5,0(a0)
    8000248c:	00000097          	auipc	ra,0x0
    80002490:	4b4080e7          	jalr	1204(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002494:	00813083          	ld	ra,8(sp)
    80002498:	00013403          	ld	s0,0(sp)
    8000249c:	01010113          	addi	sp,sp,16
    800024a0:	00008067          	ret

00000000800024a4 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    800024a4:	fe010113          	addi	sp,sp,-32
    800024a8:	00113c23          	sd	ra,24(sp)
    800024ac:	00813823          	sd	s0,16(sp)
    800024b0:	00913423          	sd	s1,8(sp)
    800024b4:	02010413          	addi	s0,sp,32
    800024b8:	00050493          	mv	s1,a0
    800024bc:	00005797          	auipc	a5,0x5
    800024c0:	27c78793          	addi	a5,a5,636 # 80007738 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800024c4:	00f53023          	sd	a5,0(a0)
    800024c8:	00000097          	auipc	ra,0x0
    800024cc:	478080e7          	jalr	1144(ra) # 80002940 <_ZN6ThreadD1Ev>
    800024d0:	00048513          	mv	a0,s1
    800024d4:	00000097          	auipc	ra,0x0
    800024d8:	65c080e7          	jalr	1628(ra) # 80002b30 <_ZN6ThreaddlEPv>
    800024dc:	01813083          	ld	ra,24(sp)
    800024e0:	01013403          	ld	s0,16(sp)
    800024e4:	00813483          	ld	s1,8(sp)
    800024e8:	02010113          	addi	sp,sp,32
    800024ec:	00008067          	ret

00000000800024f0 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    800024f0:	ff010113          	addi	sp,sp,-16
    800024f4:	00113423          	sd	ra,8(sp)
    800024f8:	00813023          	sd	s0,0(sp)
    800024fc:	01010413          	addi	s0,sp,16
    80002500:	00005797          	auipc	a5,0x5
    80002504:	26078793          	addi	a5,a5,608 # 80007760 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002508:	00f53023          	sd	a5,0(a0)
    8000250c:	00000097          	auipc	ra,0x0
    80002510:	434080e7          	jalr	1076(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002514:	00813083          	ld	ra,8(sp)
    80002518:	00013403          	ld	s0,0(sp)
    8000251c:	01010113          	addi	sp,sp,16
    80002520:	00008067          	ret

0000000080002524 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80002524:	fe010113          	addi	sp,sp,-32
    80002528:	00113c23          	sd	ra,24(sp)
    8000252c:	00813823          	sd	s0,16(sp)
    80002530:	00913423          	sd	s1,8(sp)
    80002534:	02010413          	addi	s0,sp,32
    80002538:	00050493          	mv	s1,a0
    8000253c:	00005797          	auipc	a5,0x5
    80002540:	22478793          	addi	a5,a5,548 # 80007760 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002544:	00f53023          	sd	a5,0(a0)
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	3f8080e7          	jalr	1016(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002550:	00048513          	mv	a0,s1
    80002554:	00000097          	auipc	ra,0x0
    80002558:	5dc080e7          	jalr	1500(ra) # 80002b30 <_ZN6ThreaddlEPv>
    8000255c:	01813083          	ld	ra,24(sp)
    80002560:	01013403          	ld	s0,16(sp)
    80002564:	00813483          	ld	s1,8(sp)
    80002568:	02010113          	addi	sp,sp,32
    8000256c:	00008067          	ret

0000000080002570 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80002570:	fe010113          	addi	sp,sp,-32
    80002574:	00113c23          	sd	ra,24(sp)
    80002578:	00813823          	sd	s0,16(sp)
    8000257c:	00913423          	sd	s1,8(sp)
    80002580:	01213023          	sd	s2,0(sp)
    80002584:	02010413          	addi	s0,sp,32
    80002588:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000258c:	fffff097          	auipc	ra,0xfffff
    80002590:	f1c080e7          	jalr	-228(ra) # 800014a8 <_Z4getcv>
    80002594:	0005059b          	sext.w	a1,a0
    80002598:	01b00793          	li	a5,27
    8000259c:	00f58c63          	beq	a1,a5,800025b4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x44>
                td->buffer->put(key);
    800025a0:	0104b783          	ld	a5,16(s1)
    800025a4:	0087b503          	ld	a0,8(a5)
    800025a8:	00001097          	auipc	ra,0x1
    800025ac:	564080e7          	jalr	1380(ra) # 80003b0c <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    800025b0:	fddff06f          	j	8000258c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x1c>
            threadEnd = 1;
    800025b4:	00100793          	li	a5,1
    800025b8:	00005717          	auipc	a4,0x5
    800025bc:	3af72c23          	sw	a5,952(a4) # 80007970 <_ZN19ConsumerProducerCPP9threadEndE>
            delete td->buffer;
    800025c0:	0104b783          	ld	a5,16(s1)
    800025c4:	0087b903          	ld	s2,8(a5)
    800025c8:	00090e63          	beqz	s2,800025e4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x74>
    800025cc:	00090513          	mv	a0,s2
    800025d0:	00001097          	auipc	ra,0x1
    800025d4:	444080e7          	jalr	1092(ra) # 80003a14 <_ZN9BufferCPPD1Ev>
    800025d8:	00090513          	mv	a0,s2
    800025dc:	00000097          	auipc	ra,0x0
    800025e0:	440080e7          	jalr	1088(ra) # 80002a1c <_ZdlPv>
            td->sem->signal();
    800025e4:	0104b783          	ld	a5,16(s1)
    800025e8:	0107b503          	ld	a0,16(a5)
    800025ec:	00000097          	auipc	ra,0x0
    800025f0:	778080e7          	jalr	1912(ra) # 80002d64 <_ZN9Semaphore6signalEv>
        }
    800025f4:	01813083          	ld	ra,24(sp)
    800025f8:	01013403          	ld	s0,16(sp)
    800025fc:	00813483          	ld	s1,8(sp)
    80002600:	00013903          	ld	s2,0(sp)
    80002604:	02010113          	addi	sp,sp,32
    80002608:	00008067          	ret

000000008000260c <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    8000260c:	fe010113          	addi	sp,sp,-32
    80002610:	00113c23          	sd	ra,24(sp)
    80002614:	00813823          	sd	s0,16(sp)
    80002618:	00913423          	sd	s1,8(sp)
    8000261c:	01213023          	sd	s2,0(sp)
    80002620:	02010413          	addi	s0,sp,32
    80002624:	00050493          	mv	s1,a0
            int i = 0;
    80002628:	00000913          	li	s2,0
            while (!threadEnd) {
    8000262c:	00005797          	auipc	a5,0x5
    80002630:	3447a783          	lw	a5,836(a5) # 80007970 <_ZN19ConsumerProducerCPP9threadEndE>
    80002634:	04079263          	bnez	a5,80002678 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80002638:	0104b783          	ld	a5,16(s1)
    8000263c:	0007a583          	lw	a1,0(a5)
    80002640:	0305859b          	addiw	a1,a1,48
    80002644:	0087b503          	ld	a0,8(a5)
    80002648:	00001097          	auipc	ra,0x1
    8000264c:	4c4080e7          	jalr	1220(ra) # 80003b0c <_ZN9BufferCPP3putEi>
                i++;
    80002650:	0019071b          	addiw	a4,s2,1
    80002654:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80002658:	0104b783          	ld	a5,16(s1)
    8000265c:	0007a783          	lw	a5,0(a5)
    80002660:	00e787bb          	addw	a5,a5,a4
    80002664:	00500513          	li	a0,5
    80002668:	02a7e53b          	remw	a0,a5,a0
    8000266c:	00000097          	auipc	ra,0x0
    80002670:	5f0080e7          	jalr	1520(ra) # 80002c5c <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80002674:	fb9ff06f          	j	8000262c <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80002678:	0104b783          	ld	a5,16(s1)
    8000267c:	0107b503          	ld	a0,16(a5)
    80002680:	00000097          	auipc	ra,0x0
    80002684:	6e4080e7          	jalr	1764(ra) # 80002d64 <_ZN9Semaphore6signalEv>
        }
    80002688:	01813083          	ld	ra,24(sp)
    8000268c:	01013403          	ld	s0,16(sp)
    80002690:	00813483          	ld	s1,8(sp)
    80002694:	00013903          	ld	s2,0(sp)
    80002698:	02010113          	addi	sp,sp,32
    8000269c:	00008067          	ret

00000000800026a0 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800026a0:	ff010113          	addi	sp,sp,-16
    800026a4:	00813423          	sd	s0,8(sp)
    800026a8:	01010413          	addi	s0,sp,16
    if(!process) return;
    800026ac:	02050663          	beqz	a0,800026d8 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    800026b0:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800026b4:	00005797          	auipc	a5,0x5
    800026b8:	2cc7b783          	ld	a5,716(a5) # 80007980 <_ZN9Scheduler4tailE>
    800026bc:	02078463          	beqz	a5,800026e4 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    800026c0:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    800026c4:	00005797          	auipc	a5,0x5
    800026c8:	2bc78793          	addi	a5,a5,700 # 80007980 <_ZN9Scheduler4tailE>
    800026cc:	0007b703          	ld	a4,0(a5)
    800026d0:	00073703          	ld	a4,0(a4)
    800026d4:	00e7b023          	sd	a4,0(a5)
    }
}
    800026d8:	00813403          	ld	s0,8(sp)
    800026dc:	01010113          	addi	sp,sp,16
    800026e0:	00008067          	ret
        head = tail = process;
    800026e4:	00005797          	auipc	a5,0x5
    800026e8:	29c78793          	addi	a5,a5,668 # 80007980 <_ZN9Scheduler4tailE>
    800026ec:	00a7b023          	sd	a0,0(a5)
    800026f0:	00a7b423          	sd	a0,8(a5)
    800026f4:	fe5ff06f          	j	800026d8 <_ZN9Scheduler3putEP3PCB+0x38>

00000000800026f8 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800026f8:	ff010113          	addi	sp,sp,-16
    800026fc:	00813423          	sd	s0,8(sp)
    80002700:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002704:	00005517          	auipc	a0,0x5
    80002708:	28453503          	ld	a0,644(a0) # 80007988 <_ZN9Scheduler4headE>
    8000270c:	02050463          	beqz	a0,80002734 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002710:	00053703          	ld	a4,0(a0)
    80002714:	00005797          	auipc	a5,0x5
    80002718:	26c78793          	addi	a5,a5,620 # 80007980 <_ZN9Scheduler4tailE>
    8000271c:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002720:	0007b783          	ld	a5,0(a5)
    80002724:	00f50e63          	beq	a0,a5,80002740 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002728:	00813403          	ld	s0,8(sp)
    8000272c:	01010113          	addi	sp,sp,16
    80002730:	00008067          	ret
        return idleProcess;
    80002734:	00005517          	auipc	a0,0x5
    80002738:	25c53503          	ld	a0,604(a0) # 80007990 <_ZN9Scheduler11idleProcessE>
    8000273c:	fedff06f          	j	80002728 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002740:	00005797          	auipc	a5,0x5
    80002744:	24e7b023          	sd	a4,576(a5) # 80007980 <_ZN9Scheduler4tailE>
    80002748:	fe1ff06f          	j	80002728 <_ZN9Scheduler3getEv+0x30>

000000008000274c <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    8000274c:	ff010113          	addi	sp,sp,-16
    80002750:	00813423          	sd	s0,8(sp)
    80002754:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002758:	00050e63          	beqz	a0,80002774 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    8000275c:	00005797          	auipc	a5,0x5
    80002760:	22c7b783          	ld	a5,556(a5) # 80007988 <_ZN9Scheduler4headE>
    80002764:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002768:	00078c63          	beqz	a5,80002780 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    8000276c:	00005797          	auipc	a5,0x5
    80002770:	20a7be23          	sd	a0,540(a5) # 80007988 <_ZN9Scheduler4headE>
    }
}
    80002774:	00813403          	ld	s0,8(sp)
    80002778:	01010113          	addi	sp,sp,16
    8000277c:	00008067          	ret
        head = tail = process;
    80002780:	00005797          	auipc	a5,0x5
    80002784:	20078793          	addi	a5,a5,512 # 80007980 <_ZN9Scheduler4tailE>
    80002788:	00a7b023          	sd	a0,0(a5)
    8000278c:	00a7b423          	sd	a0,8(a5)
    80002790:	fe5ff06f          	j	80002774 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002794 <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002794:	ff010113          	addi	sp,sp,-16
    80002798:	00813423          	sd	s0,8(sp)
    8000279c:	01010413          	addi	s0,sp,16
    while(true) {}
    800027a0:	0000006f          	j	800027a0 <idleProcess+0xc>

00000000800027a4 <_Z8userModev>:
#define USERMAIN_H

PCB* userProcess = nullptr;

extern "C" void interrupt();
void userMode() {
    800027a4:	ff010113          	addi	sp,sp,-16
    800027a8:	00813423          	sd	s0,8(sp)
    800027ac:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::userMode;
    asm volatile("mv a0, %0" : : "r" (code));
    800027b0:	04300793          	li	a5,67
    800027b4:	00078513          	mv	a0,a5
    asm volatile("ecall");
    800027b8:	00000073          	ecall

}
    800027bc:	00813403          	ld	s0,8(sp)
    800027c0:	01010113          	addi	sp,sp,16
    800027c4:	00008067          	ret

00000000800027c8 <_Z15userMainWrapperPv>:
void userMain();
void userMainWrapper(void*) {
    800027c8:	ff010113          	addi	sp,sp,-16
    800027cc:	00113423          	sd	ra,8(sp)
    800027d0:	00813023          	sd	s0,0(sp)
    800027d4:	01010413          	addi	s0,sp,16
    userMode();
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	fcc080e7          	jalr	-52(ra) # 800027a4 <_Z8userModev>
    userMain();
    800027e0:	00000097          	auipc	ra,0x0
    800027e4:	b48080e7          	jalr	-1208(ra) # 80002328 <_Z8userMainv>
}
    800027e8:	00813083          	ld	ra,8(sp)
    800027ec:	00013403          	ld	s0,0(sp)
    800027f0:	01010113          	addi	sp,sp,16
    800027f4:	00008067          	ret

00000000800027f8 <main>:
}
// ------------

int main() {
    800027f8:	fe010113          	addi	sp,sp,-32
    800027fc:	00113c23          	sd	ra,24(sp)
    80002800:	00813823          	sd	s0,16(sp)
    80002804:	00913423          	sd	s1,8(sp)
    80002808:	02010413          	addi	s0,sp,32
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    8000280c:	00005797          	auipc	a5,0x5
    80002810:	0a47b783          	ld	a5,164(a5) # 800078b0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002814:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002818:	00000593          	li	a1,0
    8000281c:	00000513          	li	a0,0
    80002820:	fffff097          	auipc	ra,0xfffff
    80002824:	444080e7          	jalr	1092(ra) # 80001c64 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80002828:	00005797          	auipc	a5,0x5
    8000282c:	0687b783          	ld	a5,104(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002830:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    80002834:	00000593          	li	a1,0
    80002838:	00005517          	auipc	a0,0x5
    8000283c:	08053503          	ld	a0,128(a0) # 800078b8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002840:	fffff097          	auipc	ra,0xfffff
    80002844:	b10080e7          	jalr	-1264(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    80002848:	00000593          	li	a1,0
    8000284c:	00005517          	auipc	a0,0x5
    80002850:	05453503          	ld	a0,84(a0) # 800078a0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002854:	fffff097          	auipc	ra,0xfffff
    80002858:	afc080e7          	jalr	-1284(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    8000285c:	00000593          	li	a1,0
    80002860:	00005517          	auipc	a0,0x5
    80002864:	04853503          	ld	a0,72(a0) # 800078a8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002868:	fffff097          	auipc	ra,0xfffff
    8000286c:	ae8080e7          	jalr	-1304(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002870:	00200793          	li	a5,2
    80002874:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002878:	00000613          	li	a2,0
    8000287c:	00005597          	auipc	a1,0x5
    80002880:	0045b583          	ld	a1,4(a1) # 80007880 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002884:	00005517          	auipc	a0,0x5
    80002888:	04453503          	ld	a0,68(a0) # 800078c8 <_GLOBAL_OFFSET_TABLE_+0x98>
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	a74080e7          	jalr	-1420(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    CCB::inputProcces->setTimeSlice(1);
    80002894:	00005797          	auipc	a5,0x5
    80002898:	0347b783          	ld	a5,52(a5) # 800078c8 <_GLOBAL_OFFSET_TABLE_+0x98>
    8000289c:	0007b783          	ld	a5,0(a5)
    void setSemDeleted(bool newState) {
        semDeleted = newState;
    }

    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    800028a0:	00100493          	li	s1,1
    800028a4:	0497b023          	sd	s1,64(a5)
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800028a8:	00000613          	li	a2,0
    800028ac:	00005597          	auipc	a1,0x5
    800028b0:	0145b583          	ld	a1,20(a1) # 800078c0 <_GLOBAL_OFFSET_TABLE_+0x90>
    800028b4:	00005517          	auipc	a0,0x5
    800028b8:	f8c53503          	ld	a0,-116(a0) # 80007840 <_GLOBAL_OFFSET_TABLE_+0x10>
    800028bc:	fffff097          	auipc	ra,0xfffff
    800028c0:	a44080e7          	jalr	-1468(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    CCB::outputProcess->setTimeSlice(1);
    800028c4:	00005797          	auipc	a5,0x5
    800028c8:	f7c7b783          	ld	a5,-132(a5) # 80007840 <_GLOBAL_OFFSET_TABLE_+0x10>
    800028cc:	0007b783          	ld	a5,0(a5)
    800028d0:	0497b023          	sd	s1,64(a5)
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    800028d4:	00000613          	li	a2,0
    800028d8:	00000597          	auipc	a1,0x0
    800028dc:	ebc58593          	addi	a1,a1,-324 # 80002794 <idleProcess>
    800028e0:	00005517          	auipc	a0,0x5
    800028e4:	fa853503          	ld	a0,-88(a0) # 80007888 <_GLOBAL_OFFSET_TABLE_+0x58>
    800028e8:	fffff097          	auipc	ra,0xfffff
    800028ec:	920080e7          	jalr	-1760(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    thread_create(&userProcess, userMainWrapper, nullptr);
    800028f0:	00000613          	li	a2,0
    800028f4:	00000597          	auipc	a1,0x0
    800028f8:	ed458593          	addi	a1,a1,-300 # 800027c8 <_Z15userMainWrapperPv>
    800028fc:	00005517          	auipc	a0,0x5
    80002900:	09c50513          	addi	a0,a0,156 # 80007998 <userProcess>
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	9fc080e7          	jalr	-1540(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    8000290c:	00005797          	auipc	a5,0x5
    80002910:	08c7b783          	ld	a5,140(a5) # 80007998 <userProcess>
        return finished;
    80002914:	0287c783          	lbu	a5,40(a5)
    80002918:	00079863          	bnez	a5,80002928 <main+0x130>
        thread_dispatch();
    8000291c:	fffff097          	auipc	ra,0xfffff
    80002920:	958080e7          	jalr	-1704(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    80002924:	fe9ff06f          	j	8000290c <main+0x114>
    }

   // while(CCB::semOutput->getSemValue() != 0) {}
    return 0;
    80002928:	00000513          	li	a0,0
    8000292c:	01813083          	ld	ra,24(sp)
    80002930:	01013403          	ld	s0,16(sp)
    80002934:	00813483          	ld	s1,8(sp)
    80002938:	02010113          	addi	sp,sp,32
    8000293c:	00008067          	ret

0000000080002940 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002940:	fe010113          	addi	sp,sp,-32
    80002944:	00113c23          	sd	ra,24(sp)
    80002948:	00813823          	sd	s0,16(sp)
    8000294c:	00913423          	sd	s1,8(sp)
    80002950:	02010413          	addi	s0,sp,32
    80002954:	00005797          	auipc	a5,0x5
    80002958:	e8c78793          	addi	a5,a5,-372 # 800077e0 <_ZTV6Thread+0x10>
    8000295c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002960:	00853483          	ld	s1,8(a0)
    80002964:	00048e63          	beqz	s1,80002980 <_ZN6ThreadD1Ev+0x40>
    80002968:	00048513          	mv	a0,s1
    8000296c:	fffff097          	auipc	ra,0xfffff
    80002970:	25c080e7          	jalr	604(ra) # 80001bc8 <_ZN3PCBD1Ev>
    80002974:	00048513          	mv	a0,s1
    80002978:	fffff097          	auipc	ra,0xfffff
    8000297c:	2c4080e7          	jalr	708(ra) # 80001c3c <_ZN3PCBdlEPv>
}
    80002980:	01813083          	ld	ra,24(sp)
    80002984:	01013403          	ld	s0,16(sp)
    80002988:	00813483          	ld	s1,8(sp)
    8000298c:	02010113          	addi	sp,sp,32
    80002990:	00008067          	ret

0000000080002994 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002994:	ff010113          	addi	sp,sp,-16
    80002998:	00113423          	sd	ra,8(sp)
    8000299c:	00813023          	sd	s0,0(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	00005797          	auipc	a5,0x5
    800029a8:	e6478793          	addi	a5,a5,-412 # 80007808 <_ZTV9Semaphore+0x10>
    800029ac:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800029b0:	00853503          	ld	a0,8(a0)
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	a6c080e7          	jalr	-1428(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    800029bc:	00813083          	ld	ra,8(sp)
    800029c0:	00013403          	ld	s0,0(sp)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <_Znwm>:
void* operator new (size_t size) {
    800029cc:	ff010113          	addi	sp,sp,-16
    800029d0:	00113423          	sd	ra,8(sp)
    800029d4:	00813023          	sd	s0,0(sp)
    800029d8:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800029dc:	ffffe097          	auipc	ra,0xffffe
    800029e0:	7b8080e7          	jalr	1976(ra) # 80001194 <_Z9mem_allocm>
}
    800029e4:	00813083          	ld	ra,8(sp)
    800029e8:	00013403          	ld	s0,0(sp)
    800029ec:	01010113          	addi	sp,sp,16
    800029f0:	00008067          	ret

00000000800029f4 <_Znam>:
void* operator new [](size_t size) {
    800029f4:	ff010113          	addi	sp,sp,-16
    800029f8:	00113423          	sd	ra,8(sp)
    800029fc:	00813023          	sd	s0,0(sp)
    80002a00:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002a04:	ffffe097          	auipc	ra,0xffffe
    80002a08:	790080e7          	jalr	1936(ra) # 80001194 <_Z9mem_allocm>
}
    80002a0c:	00813083          	ld	ra,8(sp)
    80002a10:	00013403          	ld	s0,0(sp)
    80002a14:	01010113          	addi	sp,sp,16
    80002a18:	00008067          	ret

0000000080002a1c <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002a1c:	ff010113          	addi	sp,sp,-16
    80002a20:	00113423          	sd	ra,8(sp)
    80002a24:	00813023          	sd	s0,0(sp)
    80002a28:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002a2c:	ffffe097          	auipc	ra,0xffffe
    80002a30:	7a8080e7          	jalr	1960(ra) # 800011d4 <_Z8mem_freePv>
}
    80002a34:	00813083          	ld	ra,8(sp)
    80002a38:	00013403          	ld	s0,0(sp)
    80002a3c:	01010113          	addi	sp,sp,16
    80002a40:	00008067          	ret

0000000080002a44 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002a44:	fe010113          	addi	sp,sp,-32
    80002a48:	00113c23          	sd	ra,24(sp)
    80002a4c:	00813823          	sd	s0,16(sp)
    80002a50:	00913423          	sd	s1,8(sp)
    80002a54:	02010413          	addi	s0,sp,32
    80002a58:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002a5c:	00053503          	ld	a0,0(a0)
    80002a60:	0104b783          	ld	a5,16(s1)
    80002a64:	00f50533          	add	a0,a0,a5
    80002a68:	0084b783          	ld	a5,8(s1)
    80002a6c:	0017f713          	andi	a4,a5,1
    80002a70:	00070863          	beqz	a4,80002a80 <_Z13threadWrapperPv+0x3c>
    80002a74:	00053703          	ld	a4,0(a0)
    80002a78:	00f707b3          	add	a5,a4,a5
    80002a7c:	fff7b783          	ld	a5,-1(a5)
    80002a80:	000780e7          	jalr	a5
    delete tArg;
    80002a84:	00048863          	beqz	s1,80002a94 <_Z13threadWrapperPv+0x50>
    80002a88:	00048513          	mv	a0,s1
    80002a8c:	00000097          	auipc	ra,0x0
    80002a90:	f90080e7          	jalr	-112(ra) # 80002a1c <_ZdlPv>
}
    80002a94:	01813083          	ld	ra,24(sp)
    80002a98:	01013403          	ld	s0,16(sp)
    80002a9c:	00813483          	ld	s1,8(sp)
    80002aa0:	02010113          	addi	sp,sp,32
    80002aa4:	00008067          	ret

0000000080002aa8 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002aa8:	ff010113          	addi	sp,sp,-16
    80002aac:	00113423          	sd	ra,8(sp)
    80002ab0:	00813023          	sd	s0,0(sp)
    80002ab4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002ab8:	ffffe097          	auipc	ra,0xffffe
    80002abc:	71c080e7          	jalr	1820(ra) # 800011d4 <_Z8mem_freePv>
}
    80002ac0:	00813083          	ld	ra,8(sp)
    80002ac4:	00013403          	ld	s0,0(sp)
    80002ac8:	01010113          	addi	sp,sp,16
    80002acc:	00008067          	ret

0000000080002ad0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002ad0:	ff010113          	addi	sp,sp,-16
    80002ad4:	00113423          	sd	ra,8(sp)
    80002ad8:	00813023          	sd	s0,0(sp)
    80002adc:	01010413          	addi	s0,sp,16
    80002ae0:	00005797          	auipc	a5,0x5
    80002ae4:	d0078793          	addi	a5,a5,-768 # 800077e0 <_ZTV6Thread+0x10>
    80002ae8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002aec:	00850513          	addi	a0,a0,8
    80002af0:	ffffe097          	auipc	ra,0xffffe
    80002af4:	718080e7          	jalr	1816(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002af8:	00813083          	ld	ra,8(sp)
    80002afc:	00013403          	ld	s0,0(sp)
    80002b00:	01010113          	addi	sp,sp,16
    80002b04:	00008067          	ret

0000000080002b08 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002b08:	ff010113          	addi	sp,sp,-16
    80002b0c:	00113423          	sd	ra,8(sp)
    80002b10:	00813023          	sd	s0,0(sp)
    80002b14:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002b18:	00000097          	auipc	ra,0x0
    80002b1c:	718080e7          	jalr	1816(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002b20:	00813083          	ld	ra,8(sp)
    80002b24:	00013403          	ld	s0,0(sp)
    80002b28:	01010113          	addi	sp,sp,16
    80002b2c:	00008067          	ret

0000000080002b30 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002b30:	ff010113          	addi	sp,sp,-16
    80002b34:	00113423          	sd	ra,8(sp)
    80002b38:	00813023          	sd	s0,0(sp)
    80002b3c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002b40:	00001097          	auipc	ra,0x1
    80002b44:	854080e7          	jalr	-1964(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002b48:	00813083          	ld	ra,8(sp)
    80002b4c:	00013403          	ld	s0,0(sp)
    80002b50:	01010113          	addi	sp,sp,16
    80002b54:	00008067          	ret

0000000080002b58 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002b58:	fe010113          	addi	sp,sp,-32
    80002b5c:	00113c23          	sd	ra,24(sp)
    80002b60:	00813823          	sd	s0,16(sp)
    80002b64:	00913423          	sd	s1,8(sp)
    80002b68:	02010413          	addi	s0,sp,32
    80002b6c:	00050493          	mv	s1,a0
}
    80002b70:	00000097          	auipc	ra,0x0
    80002b74:	dd0080e7          	jalr	-560(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002b78:	00048513          	mv	a0,s1
    80002b7c:	00000097          	auipc	ra,0x0
    80002b80:	fb4080e7          	jalr	-76(ra) # 80002b30 <_ZN6ThreaddlEPv>
    80002b84:	01813083          	ld	ra,24(sp)
    80002b88:	01013403          	ld	s0,16(sp)
    80002b8c:	00813483          	ld	s1,8(sp)
    80002b90:	02010113          	addi	sp,sp,32
    80002b94:	00008067          	ret

0000000080002b98 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002b98:	ff010113          	addi	sp,sp,-16
    80002b9c:	00113423          	sd	ra,8(sp)
    80002ba0:	00813023          	sd	s0,0(sp)
    80002ba4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002ba8:	ffffe097          	auipc	ra,0xffffe
    80002bac:	6cc080e7          	jalr	1740(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002bb0:	00813083          	ld	ra,8(sp)
    80002bb4:	00013403          	ld	s0,0(sp)
    80002bb8:	01010113          	addi	sp,sp,16
    80002bbc:	00008067          	ret

0000000080002bc0 <_ZN6Thread5startEv>:
int Thread::start() {
    80002bc0:	ff010113          	addi	sp,sp,-16
    80002bc4:	00113423          	sd	ra,8(sp)
    80002bc8:	00813023          	sd	s0,0(sp)
    80002bcc:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002bd0:	00850513          	addi	a0,a0,8
    80002bd4:	ffffe097          	auipc	ra,0xffffe
    80002bd8:	6fc080e7          	jalr	1788(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002bdc:	00000513          	li	a0,0
    80002be0:	00813083          	ld	ra,8(sp)
    80002be4:	00013403          	ld	s0,0(sp)
    80002be8:	01010113          	addi	sp,sp,16
    80002bec:	00008067          	ret

0000000080002bf0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002bf0:	fe010113          	addi	sp,sp,-32
    80002bf4:	00113c23          	sd	ra,24(sp)
    80002bf8:	00813823          	sd	s0,16(sp)
    80002bfc:	00913423          	sd	s1,8(sp)
    80002c00:	02010413          	addi	s0,sp,32
    80002c04:	00050493          	mv	s1,a0
    80002c08:	00005797          	auipc	a5,0x5
    80002c0c:	bd878793          	addi	a5,a5,-1064 # 800077e0 <_ZTV6Thread+0x10>
    80002c10:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002c14:	01800513          	li	a0,24
    80002c18:	00000097          	auipc	ra,0x0
    80002c1c:	db4080e7          	jalr	-588(ra) # 800029cc <_Znwm>
    80002c20:	00050613          	mv	a2,a0
    80002c24:	00953023          	sd	s1,0(a0)
    80002c28:	01100793          	li	a5,17
    80002c2c:	00f53423          	sd	a5,8(a0)
    80002c30:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002c34:	00000597          	auipc	a1,0x0
    80002c38:	e1058593          	addi	a1,a1,-496 # 80002a44 <_Z13threadWrapperPv>
    80002c3c:	00848513          	addi	a0,s1,8
    80002c40:	ffffe097          	auipc	ra,0xffffe
    80002c44:	5c8080e7          	jalr	1480(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002c48:	01813083          	ld	ra,24(sp)
    80002c4c:	01013403          	ld	s0,16(sp)
    80002c50:	00813483          	ld	s1,8(sp)
    80002c54:	02010113          	addi	sp,sp,32
    80002c58:	00008067          	ret

0000000080002c5c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002c5c:	ff010113          	addi	sp,sp,-16
    80002c60:	00113423          	sd	ra,8(sp)
    80002c64:	00813023          	sd	s0,0(sp)
    80002c68:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002c6c:	ffffe097          	auipc	ra,0xffffe
    80002c70:	7f4080e7          	jalr	2036(ra) # 80001460 <_Z10time_sleepm>
}
    80002c74:	00813083          	ld	ra,8(sp)
    80002c78:	00013403          	ld	s0,0(sp)
    80002c7c:	01010113          	addi	sp,sp,16
    80002c80:	00008067          	ret

0000000080002c84 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002c84:	fe010113          	addi	sp,sp,-32
    80002c88:	00113c23          	sd	ra,24(sp)
    80002c8c:	00813823          	sd	s0,16(sp)
    80002c90:	00913423          	sd	s1,8(sp)
    80002c94:	02010413          	addi	s0,sp,32
    80002c98:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002c9c:	0200006f          	j	80002cbc <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002ca0:	00053703          	ld	a4,0(a0)
    80002ca4:	00f707b3          	add	a5,a4,a5
    80002ca8:	fff7b783          	ld	a5,-1(a5)
    80002cac:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002cb0:	0184b503          	ld	a0,24(s1)
    80002cb4:	00000097          	auipc	ra,0x0
    80002cb8:	fa8080e7          	jalr	-88(ra) # 80002c5c <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002cbc:	0004b503          	ld	a0,0(s1)
    80002cc0:	0104b783          	ld	a5,16(s1)
    80002cc4:	00f50533          	add	a0,a0,a5
    80002cc8:	0084b783          	ld	a5,8(s1)
    80002ccc:	0017f713          	andi	a4,a5,1
    80002cd0:	fc070ee3          	beqz	a4,80002cac <_Z21periodicThreadWrapperPv+0x28>
    80002cd4:	fcdff06f          	j	80002ca0 <_Z21periodicThreadWrapperPv+0x1c>

0000000080002cd8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002cd8:	fe010113          	addi	sp,sp,-32
    80002cdc:	00113c23          	sd	ra,24(sp)
    80002ce0:	00813823          	sd	s0,16(sp)
    80002ce4:	00913423          	sd	s1,8(sp)
    80002ce8:	01213023          	sd	s2,0(sp)
    80002cec:	02010413          	addi	s0,sp,32
    80002cf0:	00050493          	mv	s1,a0
    80002cf4:	00005797          	auipc	a5,0x5
    80002cf8:	b1478793          	addi	a5,a5,-1260 # 80007808 <_ZTV9Semaphore+0x10>
    80002cfc:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002d00:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002d04:	01800513          	li	a0,24
    80002d08:	00000097          	auipc	ra,0x0
    80002d0c:	474080e7          	jalr	1140(ra) # 8000317c <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002d10:	00053023          	sd	zero,0(a0)
    80002d14:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80002d18:	01252823          	sw	s2,16(a0)
    80002d1c:	00a4b423          	sd	a0,8(s1)
}
    80002d20:	01813083          	ld	ra,24(sp)
    80002d24:	01013403          	ld	s0,16(sp)
    80002d28:	00813483          	ld	s1,8(sp)
    80002d2c:	00013903          	ld	s2,0(sp)
    80002d30:	02010113          	addi	sp,sp,32
    80002d34:	00008067          	ret

0000000080002d38 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002d38:	ff010113          	addi	sp,sp,-16
    80002d3c:	00113423          	sd	ra,8(sp)
    80002d40:	00813023          	sd	s0,0(sp)
    80002d44:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002d48:	00853503          	ld	a0,8(a0)
    80002d4c:	ffffe097          	auipc	ra,0xffffe
    80002d50:	64c080e7          	jalr	1612(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80002d54:	00813083          	ld	ra,8(sp)
    80002d58:	00013403          	ld	s0,0(sp)
    80002d5c:	01010113          	addi	sp,sp,16
    80002d60:	00008067          	ret

0000000080002d64 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002d64:	ff010113          	addi	sp,sp,-16
    80002d68:	00113423          	sd	ra,8(sp)
    80002d6c:	00813023          	sd	s0,0(sp)
    80002d70:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002d74:	00853503          	ld	a0,8(a0)
    80002d78:	ffffe097          	auipc	ra,0xffffe
    80002d7c:	668080e7          	jalr	1640(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80002d80:	00813083          	ld	ra,8(sp)
    80002d84:	00013403          	ld	s0,0(sp)
    80002d88:	01010113          	addi	sp,sp,16
    80002d8c:	00008067          	ret

0000000080002d90 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002d90:	ff010113          	addi	sp,sp,-16
    80002d94:	00113423          	sd	ra,8(sp)
    80002d98:	00813023          	sd	s0,0(sp)
    80002d9c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	5f4080e7          	jalr	1524(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002da8:	00813083          	ld	ra,8(sp)
    80002dac:	00013403          	ld	s0,0(sp)
    80002db0:	01010113          	addi	sp,sp,16
    80002db4:	00008067          	ret

0000000080002db8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002db8:	fe010113          	addi	sp,sp,-32
    80002dbc:	00113c23          	sd	ra,24(sp)
    80002dc0:	00813823          	sd	s0,16(sp)
    80002dc4:	00913423          	sd	s1,8(sp)
    80002dc8:	02010413          	addi	s0,sp,32
    80002dcc:	00050493          	mv	s1,a0
}
    80002dd0:	00000097          	auipc	ra,0x0
    80002dd4:	bc4080e7          	jalr	-1084(ra) # 80002994 <_ZN9SemaphoreD1Ev>
    80002dd8:	00048513          	mv	a0,s1
    80002ddc:	00000097          	auipc	ra,0x0
    80002de0:	fb4080e7          	jalr	-76(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    80002de4:	01813083          	ld	ra,24(sp)
    80002de8:	01013403          	ld	s0,16(sp)
    80002dec:	00813483          	ld	s1,8(sp)
    80002df0:	02010113          	addi	sp,sp,32
    80002df4:	00008067          	ret

0000000080002df8 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002df8:	ff010113          	addi	sp,sp,-16
    80002dfc:	00113423          	sd	ra,8(sp)
    80002e00:	00813023          	sd	s0,0(sp)
    80002e04:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	428080e7          	jalr	1064(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002e10:	00813083          	ld	ra,8(sp)
    80002e14:	00013403          	ld	s0,0(sp)
    80002e18:	01010113          	addi	sp,sp,16
    80002e1c:	00008067          	ret

0000000080002e20 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80002e20:	fe010113          	addi	sp,sp,-32
    80002e24:	00113c23          	sd	ra,24(sp)
    80002e28:	00813823          	sd	s0,16(sp)
    80002e2c:	00913423          	sd	s1,8(sp)
    80002e30:	01213023          	sd	s2,0(sp)
    80002e34:	02010413          	addi	s0,sp,32
    80002e38:	00050493          	mv	s1,a0
    80002e3c:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002e40:	02000513          	li	a0,32
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	b88080e7          	jalr	-1144(ra) # 800029cc <_Znwm>
    80002e4c:	00050613          	mv	a2,a0
    80002e50:	00953023          	sd	s1,0(a0)
    80002e54:	01900793          	li	a5,25
    80002e58:	00f53423          	sd	a5,8(a0)
    80002e5c:	00053823          	sd	zero,16(a0)
    80002e60:	01253c23          	sd	s2,24(a0)
    80002e64:	00000597          	auipc	a1,0x0
    80002e68:	e2058593          	addi	a1,a1,-480 # 80002c84 <_Z21periodicThreadWrapperPv>
    80002e6c:	00048513          	mv	a0,s1
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	c60080e7          	jalr	-928(ra) # 80002ad0 <_ZN6ThreadC1EPFvPvES0_>
    80002e78:	00005797          	auipc	a5,0x5
    80002e7c:	93878793          	addi	a5,a5,-1736 # 800077b0 <_ZTV14PeriodicThread+0x10>
    80002e80:	00f4b023          	sd	a5,0(s1)
{}
    80002e84:	01813083          	ld	ra,24(sp)
    80002e88:	01013403          	ld	s0,16(sp)
    80002e8c:	00813483          	ld	s1,8(sp)
    80002e90:	00013903          	ld	s2,0(sp)
    80002e94:	02010113          	addi	sp,sp,32
    80002e98:	00008067          	ret

0000000080002e9c <_ZN7Console4getcEv>:


char Console::getc() {
    80002e9c:	ff010113          	addi	sp,sp,-16
    80002ea0:	00113423          	sd	ra,8(sp)
    80002ea4:	00813023          	sd	s0,0(sp)
    80002ea8:	01010413          	addi	s0,sp,16
    return ::getc();
    80002eac:	ffffe097          	auipc	ra,0xffffe
    80002eb0:	5fc080e7          	jalr	1532(ra) # 800014a8 <_Z4getcv>
}
    80002eb4:	00813083          	ld	ra,8(sp)
    80002eb8:	00013403          	ld	s0,0(sp)
    80002ebc:	01010113          	addi	sp,sp,16
    80002ec0:	00008067          	ret

0000000080002ec4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002ec4:	ff010113          	addi	sp,sp,-16
    80002ec8:	00113423          	sd	ra,8(sp)
    80002ecc:	00813023          	sd	s0,0(sp)
    80002ed0:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002ed4:	ffffe097          	auipc	ra,0xffffe
    80002ed8:	604080e7          	jalr	1540(ra) # 800014d8 <_Z4putcc>
}
    80002edc:	00813083          	ld	ra,8(sp)
    80002ee0:	00013403          	ld	s0,0(sp)
    80002ee4:	01010113          	addi	sp,sp,16
    80002ee8:	00008067          	ret

0000000080002eec <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002eec:	ff010113          	addi	sp,sp,-16
    80002ef0:	00813423          	sd	s0,8(sp)
    80002ef4:	01010413          	addi	s0,sp,16
    80002ef8:	00813403          	ld	s0,8(sp)
    80002efc:	01010113          	addi	sp,sp,16
    80002f00:	00008067          	ret

0000000080002f04 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00813423          	sd	s0,8(sp)
    80002f0c:	01010413          	addi	s0,sp,16
    80002f10:	00813403          	ld	s0,8(sp)
    80002f14:	01010113          	addi	sp,sp,16
    80002f18:	00008067          	ret

0000000080002f1c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80002f1c:	ff010113          	addi	sp,sp,-16
    80002f20:	00113423          	sd	ra,8(sp)
    80002f24:	00813023          	sd	s0,0(sp)
    80002f28:	01010413          	addi	s0,sp,16
    80002f2c:	00005797          	auipc	a5,0x5
    80002f30:	88478793          	addi	a5,a5,-1916 # 800077b0 <_ZTV14PeriodicThread+0x10>
    80002f34:	00f53023          	sd	a5,0(a0)
    80002f38:	00000097          	auipc	ra,0x0
    80002f3c:	a08080e7          	jalr	-1528(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002f40:	00813083          	ld	ra,8(sp)
    80002f44:	00013403          	ld	s0,0(sp)
    80002f48:	01010113          	addi	sp,sp,16
    80002f4c:	00008067          	ret

0000000080002f50 <_ZN14PeriodicThreadD0Ev>:
    80002f50:	fe010113          	addi	sp,sp,-32
    80002f54:	00113c23          	sd	ra,24(sp)
    80002f58:	00813823          	sd	s0,16(sp)
    80002f5c:	00913423          	sd	s1,8(sp)
    80002f60:	02010413          	addi	s0,sp,32
    80002f64:	00050493          	mv	s1,a0
    80002f68:	00005797          	auipc	a5,0x5
    80002f6c:	84878793          	addi	a5,a5,-1976 # 800077b0 <_ZTV14PeriodicThread+0x10>
    80002f70:	00f53023          	sd	a5,0(a0)
    80002f74:	00000097          	auipc	ra,0x0
    80002f78:	9cc080e7          	jalr	-1588(ra) # 80002940 <_ZN6ThreadD1Ev>
    80002f7c:	00048513          	mv	a0,s1
    80002f80:	00000097          	auipc	ra,0x0
    80002f84:	bb0080e7          	jalr	-1104(ra) # 80002b30 <_ZN6ThreaddlEPv>
    80002f88:	01813083          	ld	ra,24(sp)
    80002f8c:	01013403          	ld	s0,16(sp)
    80002f90:	00813483          	ld	s1,8(sp)
    80002f94:	02010113          	addi	sp,sp,32
    80002f98:	00008067          	ret

0000000080002f9c <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002f9c:	ff010113          	addi	sp,sp,-16
    80002fa0:	00813423          	sd	s0,8(sp)
    80002fa4:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002fa8:	00005797          	auipc	a5,0x5
    80002fac:	8e87b783          	ld	a5,-1816(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002fb0:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80002fb4:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002fb8:	00853783          	ld	a5,8(a0)
    80002fbc:	04078063          	beqz	a5,80002ffc <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002fc0:	00005717          	auipc	a4,0x5
    80002fc4:	8d073703          	ld	a4,-1840(a4) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002fc8:	00073703          	ld	a4,0(a4)
    80002fcc:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002fd0:	00853783          	ld	a5,8(a0)
        return nextInList;
    80002fd4:	0007b783          	ld	a5,0(a5)
    80002fd8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002fdc:	00005797          	auipc	a5,0x5
    80002fe0:	8b47b783          	ld	a5,-1868(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002fe4:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002fe8:	00100713          	li	a4,1
    80002fec:	02e784a3          	sb	a4,41(a5)
}
    80002ff0:	00813403          	ld	s0,8(sp)
    80002ff4:	01010113          	addi	sp,sp,16
    80002ff8:	00008067          	ret
        head = tail = PCB::running;
    80002ffc:	00005797          	auipc	a5,0x5
    80003000:	8947b783          	ld	a5,-1900(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003004:	0007b783          	ld	a5,0(a5)
    80003008:	00f53423          	sd	a5,8(a0)
    8000300c:	00f53023          	sd	a5,0(a0)
    80003010:	fcdff06f          	j	80002fdc <_ZN3SCB5blockEv+0x40>

0000000080003014 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80003014:	ff010113          	addi	sp,sp,-16
    80003018:	00813423          	sd	s0,8(sp)
    8000301c:	01010413          	addi	s0,sp,16
    80003020:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80003024:	00053503          	ld	a0,0(a0)
    80003028:	00050e63          	beqz	a0,80003044 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    8000302c:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80003030:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80003034:	0087b683          	ld	a3,8(a5)
    80003038:	00d50c63          	beq	a0,a3,80003050 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    8000303c:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80003040:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80003044:	00813403          	ld	s0,8(sp)
    80003048:	01010113          	addi	sp,sp,16
    8000304c:	00008067          	ret
        tail = head;
    80003050:	00e7b423          	sd	a4,8(a5)
    80003054:	fe9ff06f          	j	8000303c <_ZN3SCB7unblockEv+0x28>

0000000080003058 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003058:	01052783          	lw	a5,16(a0)
    8000305c:	fff7879b          	addiw	a5,a5,-1
    80003060:	00f52823          	sw	a5,16(a0)
    80003064:	02079713          	slli	a4,a5,0x20
    80003068:	02074063          	bltz	a4,80003088 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000306c:	00005797          	auipc	a5,0x5
    80003070:	8247b783          	ld	a5,-2012(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003074:	0007b783          	ld	a5,0(a5)
    80003078:	02a7c783          	lbu	a5,42(a5)
    8000307c:	06079463          	bnez	a5,800030e4 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003080:	00000513          	li	a0,0
    80003084:	00008067          	ret
int SCB::wait() {
    80003088:	ff010113          	addi	sp,sp,-16
    8000308c:	00113423          	sd	ra,8(sp)
    80003090:	00813023          	sd	s0,0(sp)
    80003094:	01010413          	addi	s0,sp,16
        block();
    80003098:	00000097          	auipc	ra,0x0
    8000309c:	f04080e7          	jalr	-252(ra) # 80002f9c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    800030a0:	00004797          	auipc	a5,0x4
    800030a4:	7d07b783          	ld	a5,2000(a5) # 80007870 <_GLOBAL_OFFSET_TABLE_+0x40>
    800030a8:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    800030ac:	fffff097          	auipc	ra,0xfffff
    800030b0:	9e0080e7          	jalr	-1568(ra) # 80001a8c <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    800030b4:	00004797          	auipc	a5,0x4
    800030b8:	7dc7b783          	ld	a5,2012(a5) # 80007890 <_GLOBAL_OFFSET_TABLE_+0x60>
    800030bc:	0007b783          	ld	a5,0(a5)
    800030c0:	02a7c783          	lbu	a5,42(a5)
    800030c4:	00079c63          	bnez	a5,800030dc <_ZN3SCB4waitEv+0x84>
    return 0;
    800030c8:	00000513          	li	a0,0

}
    800030cc:	00813083          	ld	ra,8(sp)
    800030d0:	00013403          	ld	s0,0(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret
        return -2;
    800030dc:	ffe00513          	li	a0,-2
    800030e0:	fedff06f          	j	800030cc <_ZN3SCB4waitEv+0x74>
    800030e4:	ffe00513          	li	a0,-2
}
    800030e8:	00008067          	ret

00000000800030ec <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    800030ec:	01052783          	lw	a5,16(a0)
    800030f0:	0017879b          	addiw	a5,a5,1
    800030f4:	0007871b          	sext.w	a4,a5
    800030f8:	00f52823          	sw	a5,16(a0)
    800030fc:	00e05463          	blez	a4,80003104 <_ZN3SCB6signalEv+0x18>
    80003100:	00008067          	ret
void SCB::signal() {
    80003104:	ff010113          	addi	sp,sp,-16
    80003108:	00113423          	sd	ra,8(sp)
    8000310c:	00813023          	sd	s0,0(sp)
    80003110:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    80003114:	00000097          	auipc	ra,0x0
    80003118:	f00080e7          	jalr	-256(ra) # 80003014 <_ZN3SCB7unblockEv>
    8000311c:	fffff097          	auipc	ra,0xfffff
    80003120:	584080e7          	jalr	1412(ra) # 800026a0 <_ZN9Scheduler3putEP3PCB>
    }

}
    80003124:	00813083          	ld	ra,8(sp)
    80003128:	00013403          	ld	s0,0(sp)
    8000312c:	01010113          	addi	sp,sp,16
    80003130:	00008067          	ret

0000000080003134 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    80003134:	01052783          	lw	a5,16(a0)
    80003138:	0017879b          	addiw	a5,a5,1
    8000313c:	0007871b          	sext.w	a4,a5
    80003140:	00f52823          	sw	a5,16(a0)
    80003144:	00e05463          	blez	a4,8000314c <_ZN3SCB14prioritySignalEv+0x18>
    80003148:	00008067          	ret
void SCB::prioritySignal() {
    8000314c:	ff010113          	addi	sp,sp,-16
    80003150:	00113423          	sd	ra,8(sp)
    80003154:	00813023          	sd	s0,0(sp)
    80003158:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000315c:	00000097          	auipc	ra,0x0
    80003160:	eb8080e7          	jalr	-328(ra) # 80003014 <_ZN3SCB7unblockEv>
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	5e8080e7          	jalr	1512(ra) # 8000274c <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000316c:	00813083          	ld	ra,8(sp)
    80003170:	00013403          	ld	s0,0(sp)
    80003174:	01010113          	addi	sp,sp,16
    80003178:	00008067          	ret

000000008000317c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000317c:	ff010113          	addi	sp,sp,-16
    80003180:	00113423          	sd	ra,8(sp)
    80003184:	00813023          	sd	s0,0(sp)
    80003188:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000318c:	00000097          	auipc	ra,0x0
    80003190:	0a4080e7          	jalr	164(ra) # 80003230 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003194:	00813083          	ld	ra,8(sp)
    80003198:	00013403          	ld	s0,0(sp)
    8000319c:	01010113          	addi	sp,sp,16
    800031a0:	00008067          	ret

00000000800031a4 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    800031a4:	ff010113          	addi	sp,sp,-16
    800031a8:	00113423          	sd	ra,8(sp)
    800031ac:	00813023          	sd	s0,0(sp)
    800031b0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	1e0080e7          	jalr	480(ra) # 80003394 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800031bc:	00813083          	ld	ra,8(sp)
    800031c0:	00013403          	ld	s0,0(sp)
    800031c4:	01010113          	addi	sp,sp,16
    800031c8:	00008067          	ret

00000000800031cc <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800031cc:	fe010113          	addi	sp,sp,-32
    800031d0:	00113c23          	sd	ra,24(sp)
    800031d4:	00813823          	sd	s0,16(sp)
    800031d8:	00913423          	sd	s1,8(sp)
    800031dc:	01213023          	sd	s2,0(sp)
    800031e0:	02010413          	addi	s0,sp,32
    800031e4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800031e8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800031ec:	02050263          	beqz	a0,80003210 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800031f0:	00100793          	li	a5,1
    800031f4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800031f8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800031fc:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80003200:	fffff097          	auipc	ra,0xfffff
    80003204:	4a0080e7          	jalr	1184(ra) # 800026a0 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80003208:	00048513          	mv	a0,s1
    while(curr) {
    8000320c:	fe1ff06f          	j	800031ec <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80003210:	00093423          	sd	zero,8(s2)
    80003214:	00093023          	sd	zero,0(s2)
}
    80003218:	01813083          	ld	ra,24(sp)
    8000321c:	01013403          	ld	s0,16(sp)
    80003220:	00813483          	ld	s1,8(sp)
    80003224:	00013903          	ld	s2,0(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00813423          	sd	s0,8(sp)
    80003238:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000323c:	00004797          	auipc	a5,0x4
    80003240:	7647b783          	ld	a5,1892(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
    80003244:	02078c63          	beqz	a5,8000327c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80003248:	00004717          	auipc	a4,0x4
    8000324c:	65073703          	ld	a4,1616(a4) # 80007898 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003250:	00073703          	ld	a4,0(a4)
    80003254:	12e78c63          	beq	a5,a4,8000338c <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80003258:	00850713          	addi	a4,a0,8
    8000325c:	00675813          	srli	a6,a4,0x6
    80003260:	03f77793          	andi	a5,a4,63
    80003264:	00f037b3          	snez	a5,a5
    80003268:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000326c:	00004517          	auipc	a0,0x4
    80003270:	73453503          	ld	a0,1844(a0) # 800079a0 <_ZN15MemoryAllocator4headE>
    80003274:	00000613          	li	a2,0
    80003278:	0a80006f          	j	80003320 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    8000327c:	00004697          	auipc	a3,0x4
    80003280:	5d46b683          	ld	a3,1492(a3) # 80007850 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003284:	0006b783          	ld	a5,0(a3)
    80003288:	00004717          	auipc	a4,0x4
    8000328c:	70f73c23          	sd	a5,1816(a4) # 800079a0 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80003290:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80003294:	00004717          	auipc	a4,0x4
    80003298:	60473703          	ld	a4,1540(a4) # 80007898 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000329c:	00073703          	ld	a4,0(a4)
    800032a0:	0006b683          	ld	a3,0(a3)
    800032a4:	40d70733          	sub	a4,a4,a3
    800032a8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800032ac:	0007b823          	sd	zero,16(a5)
    800032b0:	fa9ff06f          	j	80003258 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800032b4:	00060e63          	beqz	a2,800032d0 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800032b8:	01063703          	ld	a4,16(a2)
    800032bc:	04070a63          	beqz	a4,80003310 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800032c0:	01073703          	ld	a4,16(a4)
    800032c4:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800032c8:	00078813          	mv	a6,a5
    800032cc:	0ac0006f          	j	80003378 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800032d0:	01053703          	ld	a4,16(a0)
    800032d4:	00070a63          	beqz	a4,800032e8 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    800032d8:	00004697          	auipc	a3,0x4
    800032dc:	6ce6b423          	sd	a4,1736(a3) # 800079a0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800032e0:	00078813          	mv	a6,a5
    800032e4:	0940006f          	j	80003378 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    800032e8:	00004717          	auipc	a4,0x4
    800032ec:	5b073703          	ld	a4,1456(a4) # 80007898 <_GLOBAL_OFFSET_TABLE_+0x68>
    800032f0:	00073703          	ld	a4,0(a4)
    800032f4:	00004697          	auipc	a3,0x4
    800032f8:	6ae6b623          	sd	a4,1708(a3) # 800079a0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800032fc:	00078813          	mv	a6,a5
    80003300:	0780006f          	j	80003378 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80003304:	00004797          	auipc	a5,0x4
    80003308:	68e7be23          	sd	a4,1692(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
    8000330c:	06c0006f          	j	80003378 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80003310:	00078813          	mv	a6,a5
    80003314:	0640006f          	j	80003378 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80003318:	00050613          	mv	a2,a0
        curr = curr->next;
    8000331c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80003320:	06050063          	beqz	a0,80003380 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80003324:	00853783          	ld	a5,8(a0)
    80003328:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    8000332c:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80003330:	fee7e4e3          	bltu	a5,a4,80003318 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80003334:	ff06e2e3          	bltu	a3,a6,80003318 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80003338:	f7068ee3          	beq	a3,a6,800032b4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    8000333c:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80003340:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80003344:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80003348:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    8000334c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80003350:	01053783          	ld	a5,16(a0)
    80003354:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80003358:	fa0606e3          	beqz	a2,80003304 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    8000335c:	01063783          	ld	a5,16(a2)
    80003360:	00078663          	beqz	a5,8000336c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80003364:	0107b783          	ld	a5,16(a5)
    80003368:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    8000336c:	01063783          	ld	a5,16(a2)
    80003370:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80003374:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80003378:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    8000337c:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80003380:	00813403          	ld	s0,8(sp)
    80003384:	01010113          	addi	sp,sp,16
    80003388:	00008067          	ret
        return nullptr;
    8000338c:	00000513          	li	a0,0
    80003390:	ff1ff06f          	j	80003380 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080003394 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80003394:	ff010113          	addi	sp,sp,-16
    80003398:	00813423          	sd	s0,8(sp)
    8000339c:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800033a0:	16050063          	beqz	a0,80003500 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800033a4:	ff850713          	addi	a4,a0,-8
    800033a8:	00004797          	auipc	a5,0x4
    800033ac:	4a87b783          	ld	a5,1192(a5) # 80007850 <_GLOBAL_OFFSET_TABLE_+0x20>
    800033b0:	0007b783          	ld	a5,0(a5)
    800033b4:	14f76a63          	bltu	a4,a5,80003508 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800033b8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800033bc:	fff58693          	addi	a3,a1,-1
    800033c0:	00d706b3          	add	a3,a4,a3
    800033c4:	00004617          	auipc	a2,0x4
    800033c8:	4d463603          	ld	a2,1236(a2) # 80007898 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033cc:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800033d0:	14c6f063          	bgeu	a3,a2,80003510 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800033d4:	14070263          	beqz	a4,80003518 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    800033d8:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800033dc:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800033e0:	14079063          	bnez	a5,80003520 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    800033e4:	03f00793          	li	a5,63
    800033e8:	14b7f063          	bgeu	a5,a1,80003528 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    800033ec:	00004797          	auipc	a5,0x4
    800033f0:	5b47b783          	ld	a5,1460(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
    800033f4:	02f60063          	beq	a2,a5,80003414 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800033f8:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800033fc:	02078a63          	beqz	a5,80003430 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80003400:	0007b683          	ld	a3,0(a5)
    80003404:	02e6f663          	bgeu	a3,a4,80003430 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80003408:	00078613          	mv	a2,a5
        curr = curr->next;
    8000340c:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80003410:	fedff06f          	j	800033fc <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80003414:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80003418:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    8000341c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80003420:	00004797          	auipc	a5,0x4
    80003424:	58e7b023          	sd	a4,1408(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
        return 0;
    80003428:	00000513          	li	a0,0
    8000342c:	0480006f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80003430:	04060863          	beqz	a2,80003480 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003434:	00063683          	ld	a3,0(a2)
    80003438:	00863803          	ld	a6,8(a2)
    8000343c:	010686b3          	add	a3,a3,a6
    80003440:	08e68a63          	beq	a3,a4,800034d4 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003444:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003448:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000344c:	01063683          	ld	a3,16(a2)
    80003450:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003454:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80003458:	0e078063          	beqz	a5,80003538 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000345c:	0007b583          	ld	a1,0(a5)
    80003460:	00073683          	ld	a3,0(a4)
    80003464:	00873603          	ld	a2,8(a4)
    80003468:	00c686b3          	add	a3,a3,a2
    8000346c:	06d58c63          	beq	a1,a3,800034e4 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80003470:	00000513          	li	a0,0
}
    80003474:	00813403          	ld	s0,8(sp)
    80003478:	01010113          	addi	sp,sp,16
    8000347c:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80003480:	0a078863          	beqz	a5,80003530 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80003484:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003488:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    8000348c:	00004797          	auipc	a5,0x4
    80003490:	5147b783          	ld	a5,1300(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
    80003494:	0007b603          	ld	a2,0(a5)
    80003498:	00b706b3          	add	a3,a4,a1
    8000349c:	00d60c63          	beq	a2,a3,800034b4 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800034a0:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800034a4:	00004797          	auipc	a5,0x4
    800034a8:	4ee7be23          	sd	a4,1276(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
            return 0;
    800034ac:	00000513          	li	a0,0
    800034b0:	fc5ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800034b4:	0087b783          	ld	a5,8(a5)
    800034b8:	00b785b3          	add	a1,a5,a1
    800034bc:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800034c0:	00004797          	auipc	a5,0x4
    800034c4:	4e07b783          	ld	a5,1248(a5) # 800079a0 <_ZN15MemoryAllocator4headE>
    800034c8:	0107b783          	ld	a5,16(a5)
    800034cc:	00f53423          	sd	a5,8(a0)
    800034d0:	fd5ff06f          	j	800034a4 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800034d4:	00b805b3          	add	a1,a6,a1
    800034d8:	00b63423          	sd	a1,8(a2)
    800034dc:	00060713          	mv	a4,a2
    800034e0:	f79ff06f          	j	80003458 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800034e4:	0087b683          	ld	a3,8(a5)
    800034e8:	00d60633          	add	a2,a2,a3
    800034ec:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800034f0:	0107b783          	ld	a5,16(a5)
    800034f4:	00f73823          	sd	a5,16(a4)
    return 0;
    800034f8:	00000513          	li	a0,0
    800034fc:	f79ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80003500:	fff00513          	li	a0,-1
    80003504:	f71ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003508:	fff00513          	li	a0,-1
    8000350c:	f69ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80003510:	fff00513          	li	a0,-1
    80003514:	f61ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003518:	fff00513          	li	a0,-1
    8000351c:	f59ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003520:	fff00513          	li	a0,-1
    80003524:	f51ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003528:	fff00513          	li	a0,-1
    8000352c:	f49ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80003530:	fff00513          	li	a0,-1
    80003534:	f41ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80003538:	00000513          	li	a0,0
    8000353c:	f39ff06f          	j	80003474 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080003540 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003540:	fe010113          	addi	sp,sp,-32
    80003544:	00113c23          	sd	ra,24(sp)
    80003548:	00813823          	sd	s0,16(sp)
    8000354c:	00913423          	sd	s1,8(sp)
    80003550:	02010413          	addi	s0,sp,32
    80003554:	00050493          	mv	s1,a0
    LOCK();
    80003558:	00100613          	li	a2,1
    8000355c:	00000593          	li	a1,0
    80003560:	00004517          	auipc	a0,0x4
    80003564:	44850513          	addi	a0,a0,1096 # 800079a8 <lockPrint>
    80003568:	ffffe097          	auipc	ra,0xffffe
    8000356c:	be8080e7          	jalr	-1048(ra) # 80001150 <copy_and_swap>
    80003570:	fe0514e3          	bnez	a0,80003558 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003574:	0004c503          	lbu	a0,0(s1)
    80003578:	00050a63          	beqz	a0,8000358c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000357c:	ffffe097          	auipc	ra,0xffffe
    80003580:	f5c080e7          	jalr	-164(ra) # 800014d8 <_Z4putcc>
        string++;
    80003584:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003588:	fedff06f          	j	80003574 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000358c:	00000613          	li	a2,0
    80003590:	00100593          	li	a1,1
    80003594:	00004517          	auipc	a0,0x4
    80003598:	41450513          	addi	a0,a0,1044 # 800079a8 <lockPrint>
    8000359c:	ffffe097          	auipc	ra,0xffffe
    800035a0:	bb4080e7          	jalr	-1100(ra) # 80001150 <copy_and_swap>
    800035a4:	fe0514e3          	bnez	a0,8000358c <_Z11printStringPKc+0x4c>
}
    800035a8:	01813083          	ld	ra,24(sp)
    800035ac:	01013403          	ld	s0,16(sp)
    800035b0:	00813483          	ld	s1,8(sp)
    800035b4:	02010113          	addi	sp,sp,32
    800035b8:	00008067          	ret

00000000800035bc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800035bc:	fd010113          	addi	sp,sp,-48
    800035c0:	02113423          	sd	ra,40(sp)
    800035c4:	02813023          	sd	s0,32(sp)
    800035c8:	00913c23          	sd	s1,24(sp)
    800035cc:	01213823          	sd	s2,16(sp)
    800035d0:	01313423          	sd	s3,8(sp)
    800035d4:	01413023          	sd	s4,0(sp)
    800035d8:	03010413          	addi	s0,sp,48
    800035dc:	00050993          	mv	s3,a0
    800035e0:	00058a13          	mv	s4,a1
    LOCK();
    800035e4:	00100613          	li	a2,1
    800035e8:	00000593          	li	a1,0
    800035ec:	00004517          	auipc	a0,0x4
    800035f0:	3bc50513          	addi	a0,a0,956 # 800079a8 <lockPrint>
    800035f4:	ffffe097          	auipc	ra,0xffffe
    800035f8:	b5c080e7          	jalr	-1188(ra) # 80001150 <copy_and_swap>
    800035fc:	fe0514e3          	bnez	a0,800035e4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003600:	00000913          	li	s2,0
    80003604:	00090493          	mv	s1,s2
    80003608:	0019091b          	addiw	s2,s2,1
    8000360c:	03495a63          	bge	s2,s4,80003640 <_Z9getStringPci+0x84>
        cc = getc();
    80003610:	ffffe097          	auipc	ra,0xffffe
    80003614:	e98080e7          	jalr	-360(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80003618:	02050463          	beqz	a0,80003640 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000361c:	009984b3          	add	s1,s3,s1
    80003620:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003624:	00a00793          	li	a5,10
    80003628:	00f50a63          	beq	a0,a5,8000363c <_Z9getStringPci+0x80>
    8000362c:	00d00793          	li	a5,13
    80003630:	fcf51ae3          	bne	a0,a5,80003604 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80003634:	00090493          	mv	s1,s2
    80003638:	0080006f          	j	80003640 <_Z9getStringPci+0x84>
    8000363c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003640:	009984b3          	add	s1,s3,s1
    80003644:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003648:	00000613          	li	a2,0
    8000364c:	00100593          	li	a1,1
    80003650:	00004517          	auipc	a0,0x4
    80003654:	35850513          	addi	a0,a0,856 # 800079a8 <lockPrint>
    80003658:	ffffe097          	auipc	ra,0xffffe
    8000365c:	af8080e7          	jalr	-1288(ra) # 80001150 <copy_and_swap>
    80003660:	fe0514e3          	bnez	a0,80003648 <_Z9getStringPci+0x8c>
    return buf;
}
    80003664:	00098513          	mv	a0,s3
    80003668:	02813083          	ld	ra,40(sp)
    8000366c:	02013403          	ld	s0,32(sp)
    80003670:	01813483          	ld	s1,24(sp)
    80003674:	01013903          	ld	s2,16(sp)
    80003678:	00813983          	ld	s3,8(sp)
    8000367c:	00013a03          	ld	s4,0(sp)
    80003680:	03010113          	addi	sp,sp,48
    80003684:	00008067          	ret

0000000080003688 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003688:	ff010113          	addi	sp,sp,-16
    8000368c:	00813423          	sd	s0,8(sp)
    80003690:	01010413          	addi	s0,sp,16
    80003694:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003698:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000369c:	0006c603          	lbu	a2,0(a3)
    800036a0:	fd06071b          	addiw	a4,a2,-48
    800036a4:	0ff77713          	andi	a4,a4,255
    800036a8:	00900793          	li	a5,9
    800036ac:	02e7e063          	bltu	a5,a4,800036cc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800036b0:	0025179b          	slliw	a5,a0,0x2
    800036b4:	00a787bb          	addw	a5,a5,a0
    800036b8:	0017979b          	slliw	a5,a5,0x1
    800036bc:	00168693          	addi	a3,a3,1
    800036c0:	00c787bb          	addw	a5,a5,a2
    800036c4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800036c8:	fd5ff06f          	j	8000369c <_Z11stringToIntPKc+0x14>
    return n;
}
    800036cc:	00813403          	ld	s0,8(sp)
    800036d0:	01010113          	addi	sp,sp,16
    800036d4:	00008067          	ret

00000000800036d8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800036d8:	fc010113          	addi	sp,sp,-64
    800036dc:	02113c23          	sd	ra,56(sp)
    800036e0:	02813823          	sd	s0,48(sp)
    800036e4:	02913423          	sd	s1,40(sp)
    800036e8:	03213023          	sd	s2,32(sp)
    800036ec:	01313c23          	sd	s3,24(sp)
    800036f0:	04010413          	addi	s0,sp,64
    800036f4:	00050493          	mv	s1,a0
    800036f8:	00058913          	mv	s2,a1
    800036fc:	00060993          	mv	s3,a2
    LOCK();
    80003700:	00100613          	li	a2,1
    80003704:	00000593          	li	a1,0
    80003708:	00004517          	auipc	a0,0x4
    8000370c:	2a050513          	addi	a0,a0,672 # 800079a8 <lockPrint>
    80003710:	ffffe097          	auipc	ra,0xffffe
    80003714:	a40080e7          	jalr	-1472(ra) # 80001150 <copy_and_swap>
    80003718:	fe0514e3          	bnez	a0,80003700 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000371c:	00098463          	beqz	s3,80003724 <_Z8printIntiii+0x4c>
    80003720:	0804c463          	bltz	s1,800037a8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003724:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003728:	00000593          	li	a1,0
    }

    i = 0;
    8000372c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003730:	0009079b          	sext.w	a5,s2
    80003734:	0325773b          	remuw	a4,a0,s2
    80003738:	00048613          	mv	a2,s1
    8000373c:	0014849b          	addiw	s1,s1,1
    80003740:	02071693          	slli	a3,a4,0x20
    80003744:	0206d693          	srli	a3,a3,0x20
    80003748:	00004717          	auipc	a4,0x4
    8000374c:	0d070713          	addi	a4,a4,208 # 80007818 <digits>
    80003750:	00d70733          	add	a4,a4,a3
    80003754:	00074683          	lbu	a3,0(a4)
    80003758:	fd040713          	addi	a4,s0,-48
    8000375c:	00c70733          	add	a4,a4,a2
    80003760:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003764:	0005071b          	sext.w	a4,a0
    80003768:	0325553b          	divuw	a0,a0,s2
    8000376c:	fcf772e3          	bgeu	a4,a5,80003730 <_Z8printIntiii+0x58>
    if(neg)
    80003770:	00058c63          	beqz	a1,80003788 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80003774:	fd040793          	addi	a5,s0,-48
    80003778:	009784b3          	add	s1,a5,s1
    8000377c:	02d00793          	li	a5,45
    80003780:	fef48823          	sb	a5,-16(s1)
    80003784:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003788:	fff4849b          	addiw	s1,s1,-1
    8000378c:	0204c463          	bltz	s1,800037b4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80003790:	fd040793          	addi	a5,s0,-48
    80003794:	009787b3          	add	a5,a5,s1
    80003798:	ff07c503          	lbu	a0,-16(a5)
    8000379c:	ffffe097          	auipc	ra,0xffffe
    800037a0:	d3c080e7          	jalr	-708(ra) # 800014d8 <_Z4putcc>
    800037a4:	fe5ff06f          	j	80003788 <_Z8printIntiii+0xb0>
        x = -xx;
    800037a8:	4090053b          	negw	a0,s1
        neg = 1;
    800037ac:	00100593          	li	a1,1
        x = -xx;
    800037b0:	f7dff06f          	j	8000372c <_Z8printIntiii+0x54>

    UNLOCK();
    800037b4:	00000613          	li	a2,0
    800037b8:	00100593          	li	a1,1
    800037bc:	00004517          	auipc	a0,0x4
    800037c0:	1ec50513          	addi	a0,a0,492 # 800079a8 <lockPrint>
    800037c4:	ffffe097          	auipc	ra,0xffffe
    800037c8:	98c080e7          	jalr	-1652(ra) # 80001150 <copy_and_swap>
    800037cc:	fe0514e3          	bnez	a0,800037b4 <_Z8printIntiii+0xdc>
}
    800037d0:	03813083          	ld	ra,56(sp)
    800037d4:	03013403          	ld	s0,48(sp)
    800037d8:	02813483          	ld	s1,40(sp)
    800037dc:	02013903          	ld	s2,32(sp)
    800037e0:	01813983          	ld	s3,24(sp)
    800037e4:	04010113          	addi	sp,sp,64
    800037e8:	00008067          	ret

00000000800037ec <_Z10printErrorv>:
void printError() {
    800037ec:	fd010113          	addi	sp,sp,-48
    800037f0:	02113423          	sd	ra,40(sp)
    800037f4:	02813023          	sd	s0,32(sp)
    800037f8:	03010413          	addi	s0,sp,48
    LOCK();
    800037fc:	00100613          	li	a2,1
    80003800:	00000593          	li	a1,0
    80003804:	00004517          	auipc	a0,0x4
    80003808:	1a450513          	addi	a0,a0,420 # 800079a8 <lockPrint>
    8000380c:	ffffe097          	auipc	ra,0xffffe
    80003810:	944080e7          	jalr	-1724(ra) # 80001150 <copy_and_swap>
    80003814:	fe0514e3          	bnez	a0,800037fc <_Z10printErrorv+0x10>
    printString("scause: ");
    80003818:	00003517          	auipc	a0,0x3
    8000381c:	99050513          	addi	a0,a0,-1648 # 800061a8 <CONSOLE_STATUS+0x198>
    80003820:	00000097          	auipc	ra,0x0
    80003824:	d20080e7          	jalr	-736(ra) # 80003540 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003828:	142027f3          	csrr	a5,scause
    8000382c:	fef43423          	sd	a5,-24(s0)
        return scause;
    80003830:	fe843503          	ld	a0,-24(s0)
    printInt(Kernel::r_scause());
    80003834:	00000613          	li	a2,0
    80003838:	00a00593          	li	a1,10
    8000383c:	0005051b          	sext.w	a0,a0
    80003840:	00000097          	auipc	ra,0x0
    80003844:	e98080e7          	jalr	-360(ra) # 800036d8 <_Z8printIntiii>
    printString("\nsepc: ");
    80003848:	00003517          	auipc	a0,0x3
    8000384c:	97050513          	addi	a0,a0,-1680 # 800061b8 <CONSOLE_STATUS+0x1a8>
    80003850:	00000097          	auipc	ra,0x0
    80003854:	cf0080e7          	jalr	-784(ra) # 80003540 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003858:	141027f3          	csrr	a5,sepc
    8000385c:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80003860:	fe043503          	ld	a0,-32(s0)
    printInt(Kernel::r_sepc());
    80003864:	00000613          	li	a2,0
    80003868:	00a00593          	li	a1,10
    8000386c:	0005051b          	sext.w	a0,a0
    80003870:	00000097          	auipc	ra,0x0
    80003874:	e68080e7          	jalr	-408(ra) # 800036d8 <_Z8printIntiii>
    printString("\nstval: ");
    80003878:	00003517          	auipc	a0,0x3
    8000387c:	94850513          	addi	a0,a0,-1720 # 800061c0 <CONSOLE_STATUS+0x1b0>
    80003880:	00000097          	auipc	ra,0x0
    80003884:	cc0080e7          	jalr	-832(ra) # 80003540 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80003888:	143027f3          	csrr	a5,stval
    8000388c:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    80003890:	fd843503          	ld	a0,-40(s0)
    printInt(Kernel::r_stval());
    80003894:	00000613          	li	a2,0
    80003898:	00a00593          	li	a1,10
    8000389c:	0005051b          	sext.w	a0,a0
    800038a0:	00000097          	auipc	ra,0x0
    800038a4:	e38080e7          	jalr	-456(ra) # 800036d8 <_Z8printIntiii>
    UNLOCK();
    800038a8:	00000613          	li	a2,0
    800038ac:	00100593          	li	a1,1
    800038b0:	00004517          	auipc	a0,0x4
    800038b4:	0f850513          	addi	a0,a0,248 # 800079a8 <lockPrint>
    800038b8:	ffffe097          	auipc	ra,0xffffe
    800038bc:	898080e7          	jalr	-1896(ra) # 80001150 <copy_and_swap>
    800038c0:	fe0514e3          	bnez	a0,800038a8 <_Z10printErrorv+0xbc>
    800038c4:	02813083          	ld	ra,40(sp)
    800038c8:	02013403          	ld	s0,32(sp)
    800038cc:	03010113          	addi	sp,sp,48
    800038d0:	00008067          	ret

00000000800038d4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap), head(0), tail(0) {
    800038d4:	fe010113          	addi	sp,sp,-32
    800038d8:	00113c23          	sd	ra,24(sp)
    800038dc:	00813823          	sd	s0,16(sp)
    800038e0:	00913423          	sd	s1,8(sp)
    800038e4:	01213023          	sd	s2,0(sp)
    800038e8:	02010413          	addi	s0,sp,32
    800038ec:	00050493          	mv	s1,a0
    800038f0:	00b52023          	sw	a1,0(a0)
    800038f4:	00052823          	sw	zero,16(a0)
    800038f8:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800038fc:	00259513          	slli	a0,a1,0x2
    80003900:	ffffe097          	auipc	ra,0xffffe
    80003904:	894080e7          	jalr	-1900(ra) # 80001194 <_Z9mem_allocm>
    80003908:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000390c:	01000513          	li	a0,16
    80003910:	fffff097          	auipc	ra,0xfffff
    80003914:	4e8080e7          	jalr	1256(ra) # 80002df8 <_ZN9SemaphorenwEm>
    80003918:	00050913          	mv	s2,a0
    8000391c:	00000593          	li	a1,0
    80003920:	fffff097          	auipc	ra,0xfffff
    80003924:	3b8080e7          	jalr	952(ra) # 80002cd8 <_ZN9SemaphoreC1Ej>
    80003928:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(cap);
    8000392c:	01000513          	li	a0,16
    80003930:	fffff097          	auipc	ra,0xfffff
    80003934:	4c8080e7          	jalr	1224(ra) # 80002df8 <_ZN9SemaphorenwEm>
    80003938:	00050913          	mv	s2,a0
    8000393c:	0004a583          	lw	a1,0(s1)
    80003940:	fffff097          	auipc	ra,0xfffff
    80003944:	398080e7          	jalr	920(ra) # 80002cd8 <_ZN9SemaphoreC1Ej>
    80003948:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000394c:	01000513          	li	a0,16
    80003950:	fffff097          	auipc	ra,0xfffff
    80003954:	4a8080e7          	jalr	1192(ra) # 80002df8 <_ZN9SemaphorenwEm>
    80003958:	00050913          	mv	s2,a0
    8000395c:	00100593          	li	a1,1
    80003960:	fffff097          	auipc	ra,0xfffff
    80003964:	378080e7          	jalr	888(ra) # 80002cd8 <_ZN9SemaphoreC1Ej>
    80003968:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000396c:	01000513          	li	a0,16
    80003970:	fffff097          	auipc	ra,0xfffff
    80003974:	488080e7          	jalr	1160(ra) # 80002df8 <_ZN9SemaphorenwEm>
    80003978:	00050913          	mv	s2,a0
    8000397c:	00100593          	li	a1,1
    80003980:	fffff097          	auipc	ra,0xfffff
    80003984:	358080e7          	jalr	856(ra) # 80002cd8 <_ZN9SemaphoreC1Ej>
    80003988:	0324b823          	sd	s2,48(s1)
}
    8000398c:	01813083          	ld	ra,24(sp)
    80003990:	01013403          	ld	s0,16(sp)
    80003994:	00813483          	ld	s1,8(sp)
    80003998:	00013903          	ld	s2,0(sp)
    8000399c:	02010113          	addi	sp,sp,32
    800039a0:	00008067          	ret
    800039a4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800039a8:	00090513          	mv	a0,s2
    800039ac:	fffff097          	auipc	ra,0xfffff
    800039b0:	3e4080e7          	jalr	996(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    800039b4:	00048513          	mv	a0,s1
    800039b8:	00005097          	auipc	ra,0x5
    800039bc:	0c0080e7          	jalr	192(ra) # 80008a78 <_Unwind_Resume>
    800039c0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(cap);
    800039c4:	00090513          	mv	a0,s2
    800039c8:	fffff097          	auipc	ra,0xfffff
    800039cc:	3c8080e7          	jalr	968(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    800039d0:	00048513          	mv	a0,s1
    800039d4:	00005097          	auipc	ra,0x5
    800039d8:	0a4080e7          	jalr	164(ra) # 80008a78 <_Unwind_Resume>
    800039dc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800039e0:	00090513          	mv	a0,s2
    800039e4:	fffff097          	auipc	ra,0xfffff
    800039e8:	3ac080e7          	jalr	940(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    800039ec:	00048513          	mv	a0,s1
    800039f0:	00005097          	auipc	ra,0x5
    800039f4:	088080e7          	jalr	136(ra) # 80008a78 <_Unwind_Resume>
    800039f8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800039fc:	00090513          	mv	a0,s2
    80003a00:	fffff097          	auipc	ra,0xfffff
    80003a04:	390080e7          	jalr	912(ra) # 80002d90 <_ZN9SemaphoredlEPv>
    80003a08:	00048513          	mv	a0,s1
    80003a0c:	00005097          	auipc	ra,0x5
    80003a10:	06c080e7          	jalr	108(ra) # 80008a78 <_Unwind_Resume>

0000000080003a14 <_ZN9BufferCPPD1Ev>:

BufferCPP::~BufferCPP() {
    80003a14:	fe010113          	addi	sp,sp,-32
    80003a18:	00113c23          	sd	ra,24(sp)
    80003a1c:	00813823          	sd	s0,16(sp)
    80003a20:	00913423          	sd	s1,8(sp)
    80003a24:	02010413          	addi	s0,sp,32
    80003a28:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003a2c:	00a00513          	li	a0,10
    80003a30:	fffff097          	auipc	ra,0xfffff
    80003a34:	494080e7          	jalr	1172(ra) # 80002ec4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003a38:	00002517          	auipc	a0,0x2
    80003a3c:	79850513          	addi	a0,a0,1944 # 800061d0 <CONSOLE_STATUS+0x1c0>
    80003a40:	00000097          	auipc	ra,0x0
    80003a44:	b00080e7          	jalr	-1280(ra) # 80003540 <_Z11printStringPKc>
    while (head != tail) {
    80003a48:	0104a783          	lw	a5,16(s1)
    80003a4c:	0144a703          	lw	a4,20(s1)
    80003a50:	02e78a63          	beq	a5,a4,80003a84 <_ZN9BufferCPPD1Ev+0x70>
        char ch = buffer[head];
    80003a54:	0084b703          	ld	a4,8(s1)
    80003a58:	00279793          	slli	a5,a5,0x2
    80003a5c:	00f707b3          	add	a5,a4,a5
        Console::putc(ch);
    80003a60:	0007c503          	lbu	a0,0(a5)
    80003a64:	fffff097          	auipc	ra,0xfffff
    80003a68:	460080e7          	jalr	1120(ra) # 80002ec4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80003a6c:	0104a783          	lw	a5,16(s1)
    80003a70:	0017879b          	addiw	a5,a5,1
    80003a74:	0004a703          	lw	a4,0(s1)
    80003a78:	02e7e7bb          	remw	a5,a5,a4
    80003a7c:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003a80:	fc9ff06f          	j	80003a48 <_ZN9BufferCPPD1Ev+0x34>
    }
    Console::putc('!');
    80003a84:	02100513          	li	a0,33
    80003a88:	fffff097          	auipc	ra,0xfffff
    80003a8c:	43c080e7          	jalr	1084(ra) # 80002ec4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80003a90:	00a00513          	li	a0,10
    80003a94:	fffff097          	auipc	ra,0xfffff
    80003a98:	430080e7          	jalr	1072(ra) # 80002ec4 <_ZN7Console4putcEc>

    mem_free(buffer);
    80003a9c:	0084b503          	ld	a0,8(s1)
    80003aa0:	ffffd097          	auipc	ra,0xffffd
    80003aa4:	734080e7          	jalr	1844(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80003aa8:	0204b503          	ld	a0,32(s1)
    80003aac:	00050863          	beqz	a0,80003abc <_ZN9BufferCPPD1Ev+0xa8>
    80003ab0:	00053783          	ld	a5,0(a0)
    80003ab4:	0087b783          	ld	a5,8(a5)
    80003ab8:	000780e7          	jalr	a5
    delete spaceAvailable;
    80003abc:	0184b503          	ld	a0,24(s1)
    80003ac0:	00050863          	beqz	a0,80003ad0 <_ZN9BufferCPPD1Ev+0xbc>
    80003ac4:	00053783          	ld	a5,0(a0)
    80003ac8:	0087b783          	ld	a5,8(a5)
    80003acc:	000780e7          	jalr	a5
    delete mutexTail;
    80003ad0:	0304b503          	ld	a0,48(s1)
    80003ad4:	00050863          	beqz	a0,80003ae4 <_ZN9BufferCPPD1Ev+0xd0>
    80003ad8:	00053783          	ld	a5,0(a0)
    80003adc:	0087b783          	ld	a5,8(a5)
    80003ae0:	000780e7          	jalr	a5
    delete mutexHead;
    80003ae4:	0284b503          	ld	a0,40(s1)
    80003ae8:	00050863          	beqz	a0,80003af8 <_ZN9BufferCPPD1Ev+0xe4>
    80003aec:	00053783          	ld	a5,0(a0)
    80003af0:	0087b783          	ld	a5,8(a5)
    80003af4:	000780e7          	jalr	a5

}
    80003af8:	01813083          	ld	ra,24(sp)
    80003afc:	01013403          	ld	s0,16(sp)
    80003b00:	00813483          	ld	s1,8(sp)
    80003b04:	02010113          	addi	sp,sp,32
    80003b08:	00008067          	ret

0000000080003b0c <_ZN9BufferCPP3putEi>:

void BufferCPP::put(int val) {
    80003b0c:	fe010113          	addi	sp,sp,-32
    80003b10:	00113c23          	sd	ra,24(sp)
    80003b14:	00813823          	sd	s0,16(sp)
    80003b18:	00913423          	sd	s1,8(sp)
    80003b1c:	01213023          	sd	s2,0(sp)
    80003b20:	02010413          	addi	s0,sp,32
    80003b24:	00050493          	mv	s1,a0
    80003b28:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003b2c:	01853503          	ld	a0,24(a0)
    80003b30:	fffff097          	auipc	ra,0xfffff
    80003b34:	208080e7          	jalr	520(ra) # 80002d38 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003b38:	0304b503          	ld	a0,48(s1)
    80003b3c:	fffff097          	auipc	ra,0xfffff
    80003b40:	1fc080e7          	jalr	508(ra) # 80002d38 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003b44:	0084b783          	ld	a5,8(s1)
    80003b48:	0144a703          	lw	a4,20(s1)
    80003b4c:	00271713          	slli	a4,a4,0x2
    80003b50:	00e787b3          	add	a5,a5,a4
    80003b54:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003b58:	0144a783          	lw	a5,20(s1)
    80003b5c:	0017879b          	addiw	a5,a5,1
    80003b60:	0004a703          	lw	a4,0(s1)
    80003b64:	02e7e7bb          	remw	a5,a5,a4
    80003b68:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80003b6c:	0304b503          	ld	a0,48(s1)
    80003b70:	fffff097          	auipc	ra,0xfffff
    80003b74:	1f4080e7          	jalr	500(ra) # 80002d64 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80003b78:	0204b503          	ld	a0,32(s1)
    80003b7c:	fffff097          	auipc	ra,0xfffff
    80003b80:	1e8080e7          	jalr	488(ra) # 80002d64 <_ZN9Semaphore6signalEv>

}
    80003b84:	01813083          	ld	ra,24(sp)
    80003b88:	01013403          	ld	s0,16(sp)
    80003b8c:	00813483          	ld	s1,8(sp)
    80003b90:	00013903          	ld	s2,0(sp)
    80003b94:	02010113          	addi	sp,sp,32
    80003b98:	00008067          	ret

0000000080003b9c <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003b9c:	fe010113          	addi	sp,sp,-32
    80003ba0:	00113c23          	sd	ra,24(sp)
    80003ba4:	00813823          	sd	s0,16(sp)
    80003ba8:	00913423          	sd	s1,8(sp)
    80003bac:	01213023          	sd	s2,0(sp)
    80003bb0:	02010413          	addi	s0,sp,32
    80003bb4:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003bb8:	02053503          	ld	a0,32(a0)
    80003bbc:	fffff097          	auipc	ra,0xfffff
    80003bc0:	17c080e7          	jalr	380(ra) # 80002d38 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003bc4:	0284b503          	ld	a0,40(s1)
    80003bc8:	fffff097          	auipc	ra,0xfffff
    80003bcc:	170080e7          	jalr	368(ra) # 80002d38 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80003bd0:	0084b703          	ld	a4,8(s1)
    80003bd4:	0104a783          	lw	a5,16(s1)
    80003bd8:	00279693          	slli	a3,a5,0x2
    80003bdc:	00d70733          	add	a4,a4,a3
    80003be0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003be4:	0017879b          	addiw	a5,a5,1
    80003be8:	0004a703          	lw	a4,0(s1)
    80003bec:	02e7e7bb          	remw	a5,a5,a4
    80003bf0:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003bf4:	0284b503          	ld	a0,40(s1)
    80003bf8:	fffff097          	auipc	ra,0xfffff
    80003bfc:	16c080e7          	jalr	364(ra) # 80002d64 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80003c00:	0184b503          	ld	a0,24(s1)
    80003c04:	fffff097          	auipc	ra,0xfffff
    80003c08:	160080e7          	jalr	352(ra) # 80002d64 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003c0c:	00090513          	mv	a0,s2
    80003c10:	01813083          	ld	ra,24(sp)
    80003c14:	01013403          	ld	s0,16(sp)
    80003c18:	00813483          	ld	s1,8(sp)
    80003c1c:	00013903          	ld	s2,0(sp)
    80003c20:	02010113          	addi	sp,sp,32
    80003c24:	00008067          	ret

0000000080003c28 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap), head(0), tail(0) {
    80003c28:	fe010113          	addi	sp,sp,-32
    80003c2c:	00113c23          	sd	ra,24(sp)
    80003c30:	00813823          	sd	s0,16(sp)
    80003c34:	00913423          	sd	s1,8(sp)
    80003c38:	02010413          	addi	s0,sp,32
    80003c3c:	00050493          	mv	s1,a0
    80003c40:	00b52023          	sw	a1,0(a0)
    80003c44:	00052823          	sw	zero,16(a0)
    80003c48:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003c4c:	00259513          	slli	a0,a1,0x2
    80003c50:	ffffd097          	auipc	ra,0xffffd
    80003c54:	544080e7          	jalr	1348(ra) # 80001194 <_Z9mem_allocm>
    80003c58:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003c5c:	00000593          	li	a1,0
    80003c60:	02048513          	addi	a0,s1,32
    80003c64:	ffffd097          	auipc	ra,0xffffd
    80003c68:	6ec080e7          	jalr	1772(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, cap);
    80003c6c:	0004a583          	lw	a1,0(s1)
    80003c70:	01848513          	addi	a0,s1,24
    80003c74:	ffffd097          	auipc	ra,0xffffd
    80003c78:	6dc080e7          	jalr	1756(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003c7c:	00100593          	li	a1,1
    80003c80:	02848513          	addi	a0,s1,40
    80003c84:	ffffd097          	auipc	ra,0xffffd
    80003c88:	6cc080e7          	jalr	1740(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003c8c:	00100593          	li	a1,1
    80003c90:	03048513          	addi	a0,s1,48
    80003c94:	ffffd097          	auipc	ra,0xffffd
    80003c98:	6bc080e7          	jalr	1724(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003c9c:	01813083          	ld	ra,24(sp)
    80003ca0:	01013403          	ld	s0,16(sp)
    80003ca4:	00813483          	ld	s1,8(sp)
    80003ca8:	02010113          	addi	sp,sp,32
    80003cac:	00008067          	ret

0000000080003cb0 <_ZN6BufferD1Ev>:

Buffer::~Buffer() {
    80003cb0:	fe010113          	addi	sp,sp,-32
    80003cb4:	00113c23          	sd	ra,24(sp)
    80003cb8:	00813823          	sd	s0,16(sp)
    80003cbc:	00913423          	sd	s1,8(sp)
    80003cc0:	02010413          	addi	s0,sp,32
    80003cc4:	00050493          	mv	s1,a0
    putc('\n');
    80003cc8:	00a00513          	li	a0,10
    80003ccc:	ffffe097          	auipc	ra,0xffffe
    80003cd0:	80c080e7          	jalr	-2036(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003cd4:	00002517          	auipc	a0,0x2
    80003cd8:	4fc50513          	addi	a0,a0,1276 # 800061d0 <CONSOLE_STATUS+0x1c0>
    80003cdc:	00000097          	auipc	ra,0x0
    80003ce0:	864080e7          	jalr	-1948(ra) # 80003540 <_Z11printStringPKc>
    while (head != tail) {
    80003ce4:	0104a783          	lw	a5,16(s1)
    80003ce8:	0144a703          	lw	a4,20(s1)
    80003cec:	02e78a63          	beq	a5,a4,80003d20 <_ZN6BufferD1Ev+0x70>
        char ch = buffer[head];
    80003cf0:	0084b703          	ld	a4,8(s1)
    80003cf4:	00279793          	slli	a5,a5,0x2
    80003cf8:	00f707b3          	add	a5,a4,a5
        putc(ch);
    80003cfc:	0007c503          	lbu	a0,0(a5)
    80003d00:	ffffd097          	auipc	ra,0xffffd
    80003d04:	7d8080e7          	jalr	2008(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80003d08:	0104a783          	lw	a5,16(s1)
    80003d0c:	0017879b          	addiw	a5,a5,1
    80003d10:	0004a703          	lw	a4,0(s1)
    80003d14:	02e7e7bb          	remw	a5,a5,a4
    80003d18:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003d1c:	fc9ff06f          	j	80003ce4 <_ZN6BufferD1Ev+0x34>
    }
    putc('!');
    80003d20:	02100513          	li	a0,33
    80003d24:	ffffd097          	auipc	ra,0xffffd
    80003d28:	7b4080e7          	jalr	1972(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    80003d2c:	00a00513          	li	a0,10
    80003d30:	ffffd097          	auipc	ra,0xffffd
    80003d34:	7a8080e7          	jalr	1960(ra) # 800014d8 <_Z4putcc>

    mem_free(buffer);
    80003d38:	0084b503          	ld	a0,8(s1)
    80003d3c:	ffffd097          	auipc	ra,0xffffd
    80003d40:	498080e7          	jalr	1176(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003d44:	0204b503          	ld	a0,32(s1)
    80003d48:	ffffd097          	auipc	ra,0xffffd
    80003d4c:	6d8080e7          	jalr	1752(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003d50:	0184b503          	ld	a0,24(s1)
    80003d54:	ffffd097          	auipc	ra,0xffffd
    80003d58:	6cc080e7          	jalr	1740(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003d5c:	0304b503          	ld	a0,48(s1)
    80003d60:	ffffd097          	auipc	ra,0xffffd
    80003d64:	6c0080e7          	jalr	1728(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80003d68:	0284b503          	ld	a0,40(s1)
    80003d6c:	ffffd097          	auipc	ra,0xffffd
    80003d70:	6b4080e7          	jalr	1716(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003d74:	01813083          	ld	ra,24(sp)
    80003d78:	01013403          	ld	s0,16(sp)
    80003d7c:	00813483          	ld	s1,8(sp)
    80003d80:	02010113          	addi	sp,sp,32
    80003d84:	00008067          	ret

0000000080003d88 <_ZN6Buffer3putEi>:

void Buffer::put(int val) {
    80003d88:	fe010113          	addi	sp,sp,-32
    80003d8c:	00113c23          	sd	ra,24(sp)
    80003d90:	00813823          	sd	s0,16(sp)
    80003d94:	00913423          	sd	s1,8(sp)
    80003d98:	01213023          	sd	s2,0(sp)
    80003d9c:	02010413          	addi	s0,sp,32
    80003da0:	00050493          	mv	s1,a0
    80003da4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003da8:	01853503          	ld	a0,24(a0)
    80003dac:	ffffd097          	auipc	ra,0xffffd
    80003db0:	5ec080e7          	jalr	1516(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80003db4:	0304b503          	ld	a0,48(s1)
    80003db8:	ffffd097          	auipc	ra,0xffffd
    80003dbc:	5e0080e7          	jalr	1504(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80003dc0:	0084b783          	ld	a5,8(s1)
    80003dc4:	0144a703          	lw	a4,20(s1)
    80003dc8:	00271713          	slli	a4,a4,0x2
    80003dcc:	00e787b3          	add	a5,a5,a4
    80003dd0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003dd4:	0144a783          	lw	a5,20(s1)
    80003dd8:	0017879b          	addiw	a5,a5,1
    80003ddc:	0004a703          	lw	a4,0(s1)
    80003de0:	02e7e7bb          	remw	a5,a5,a4
    80003de4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003de8:	0304b503          	ld	a0,48(s1)
    80003dec:	ffffd097          	auipc	ra,0xffffd
    80003df0:	5f4080e7          	jalr	1524(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80003df4:	0204b503          	ld	a0,32(s1)
    80003df8:	ffffd097          	auipc	ra,0xffffd
    80003dfc:	5e8080e7          	jalr	1512(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80003e00:	01813083          	ld	ra,24(sp)
    80003e04:	01013403          	ld	s0,16(sp)
    80003e08:	00813483          	ld	s1,8(sp)
    80003e0c:	00013903          	ld	s2,0(sp)
    80003e10:	02010113          	addi	sp,sp,32
    80003e14:	00008067          	ret

0000000080003e18 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003e18:	fe010113          	addi	sp,sp,-32
    80003e1c:	00113c23          	sd	ra,24(sp)
    80003e20:	00813823          	sd	s0,16(sp)
    80003e24:	00913423          	sd	s1,8(sp)
    80003e28:	01213023          	sd	s2,0(sp)
    80003e2c:	02010413          	addi	s0,sp,32
    80003e30:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003e34:	02053503          	ld	a0,32(a0)
    80003e38:	ffffd097          	auipc	ra,0xffffd
    80003e3c:	560080e7          	jalr	1376(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003e40:	0284b503          	ld	a0,40(s1)
    80003e44:	ffffd097          	auipc	ra,0xffffd
    80003e48:	554080e7          	jalr	1364(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003e4c:	0084b703          	ld	a4,8(s1)
    80003e50:	0104a783          	lw	a5,16(s1)
    80003e54:	00279693          	slli	a3,a5,0x2
    80003e58:	00d70733          	add	a4,a4,a3
    80003e5c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003e60:	0017879b          	addiw	a5,a5,1
    80003e64:	0004a703          	lw	a4,0(s1)
    80003e68:	02e7e7bb          	remw	a5,a5,a4
    80003e6c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003e70:	0284b503          	ld	a0,40(s1)
    80003e74:	ffffd097          	auipc	ra,0xffffd
    80003e78:	56c080e7          	jalr	1388(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003e7c:	0184b503          	ld	a0,24(s1)
    80003e80:	ffffd097          	auipc	ra,0xffffd
    80003e84:	560080e7          	jalr	1376(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003e88:	00090513          	mv	a0,s2
    80003e8c:	01813083          	ld	ra,24(sp)
    80003e90:	01013403          	ld	s0,16(sp)
    80003e94:	00813483          	ld	s1,8(sp)
    80003e98:	00013903          	ld	s2,0(sp)
    80003e9c:	02010113          	addi	sp,sp,32
    80003ea0:	00008067          	ret

0000000080003ea4 <start>:
    80003ea4:	ff010113          	addi	sp,sp,-16
    80003ea8:	00813423          	sd	s0,8(sp)
    80003eac:	01010413          	addi	s0,sp,16
    80003eb0:	300027f3          	csrr	a5,mstatus
    80003eb4:	ffffe737          	lui	a4,0xffffe
    80003eb8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5bef>
    80003ebc:	00e7f7b3          	and	a5,a5,a4
    80003ec0:	00001737          	lui	a4,0x1
    80003ec4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003ec8:	00e7e7b3          	or	a5,a5,a4
    80003ecc:	30079073          	csrw	mstatus,a5
    80003ed0:	00000797          	auipc	a5,0x0
    80003ed4:	16078793          	addi	a5,a5,352 # 80004030 <system_main>
    80003ed8:	34179073          	csrw	mepc,a5
    80003edc:	00000793          	li	a5,0
    80003ee0:	18079073          	csrw	satp,a5
    80003ee4:	000107b7          	lui	a5,0x10
    80003ee8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003eec:	30279073          	csrw	medeleg,a5
    80003ef0:	30379073          	csrw	mideleg,a5
    80003ef4:	104027f3          	csrr	a5,sie
    80003ef8:	2227e793          	ori	a5,a5,546
    80003efc:	10479073          	csrw	sie,a5
    80003f00:	fff00793          	li	a5,-1
    80003f04:	00a7d793          	srli	a5,a5,0xa
    80003f08:	3b079073          	csrw	pmpaddr0,a5
    80003f0c:	00f00793          	li	a5,15
    80003f10:	3a079073          	csrw	pmpcfg0,a5
    80003f14:	f14027f3          	csrr	a5,mhartid
    80003f18:	0200c737          	lui	a4,0x200c
    80003f1c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003f20:	0007869b          	sext.w	a3,a5
    80003f24:	00269713          	slli	a4,a3,0x2
    80003f28:	000f4637          	lui	a2,0xf4
    80003f2c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003f30:	00d70733          	add	a4,a4,a3
    80003f34:	0037979b          	slliw	a5,a5,0x3
    80003f38:	020046b7          	lui	a3,0x2004
    80003f3c:	00d787b3          	add	a5,a5,a3
    80003f40:	00c585b3          	add	a1,a1,a2
    80003f44:	00371693          	slli	a3,a4,0x3
    80003f48:	00004717          	auipc	a4,0x4
    80003f4c:	a6870713          	addi	a4,a4,-1432 # 800079b0 <timer_scratch>
    80003f50:	00b7b023          	sd	a1,0(a5)
    80003f54:	00d70733          	add	a4,a4,a3
    80003f58:	00f73c23          	sd	a5,24(a4)
    80003f5c:	02c73023          	sd	a2,32(a4)
    80003f60:	34071073          	csrw	mscratch,a4
    80003f64:	00000797          	auipc	a5,0x0
    80003f68:	6ec78793          	addi	a5,a5,1772 # 80004650 <timervec>
    80003f6c:	30579073          	csrw	mtvec,a5
    80003f70:	300027f3          	csrr	a5,mstatus
    80003f74:	0087e793          	ori	a5,a5,8
    80003f78:	30079073          	csrw	mstatus,a5
    80003f7c:	304027f3          	csrr	a5,mie
    80003f80:	0807e793          	ori	a5,a5,128
    80003f84:	30479073          	csrw	mie,a5
    80003f88:	f14027f3          	csrr	a5,mhartid
    80003f8c:	0007879b          	sext.w	a5,a5
    80003f90:	00078213          	mv	tp,a5
    80003f94:	30200073          	mret
    80003f98:	00813403          	ld	s0,8(sp)
    80003f9c:	01010113          	addi	sp,sp,16
    80003fa0:	00008067          	ret

0000000080003fa4 <timerinit>:
    80003fa4:	ff010113          	addi	sp,sp,-16
    80003fa8:	00813423          	sd	s0,8(sp)
    80003fac:	01010413          	addi	s0,sp,16
    80003fb0:	f14027f3          	csrr	a5,mhartid
    80003fb4:	0200c737          	lui	a4,0x200c
    80003fb8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003fbc:	0007869b          	sext.w	a3,a5
    80003fc0:	00269713          	slli	a4,a3,0x2
    80003fc4:	000f4637          	lui	a2,0xf4
    80003fc8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003fcc:	00d70733          	add	a4,a4,a3
    80003fd0:	0037979b          	slliw	a5,a5,0x3
    80003fd4:	020046b7          	lui	a3,0x2004
    80003fd8:	00d787b3          	add	a5,a5,a3
    80003fdc:	00c585b3          	add	a1,a1,a2
    80003fe0:	00371693          	slli	a3,a4,0x3
    80003fe4:	00004717          	auipc	a4,0x4
    80003fe8:	9cc70713          	addi	a4,a4,-1588 # 800079b0 <timer_scratch>
    80003fec:	00b7b023          	sd	a1,0(a5)
    80003ff0:	00d70733          	add	a4,a4,a3
    80003ff4:	00f73c23          	sd	a5,24(a4)
    80003ff8:	02c73023          	sd	a2,32(a4)
    80003ffc:	34071073          	csrw	mscratch,a4
    80004000:	00000797          	auipc	a5,0x0
    80004004:	65078793          	addi	a5,a5,1616 # 80004650 <timervec>
    80004008:	30579073          	csrw	mtvec,a5
    8000400c:	300027f3          	csrr	a5,mstatus
    80004010:	0087e793          	ori	a5,a5,8
    80004014:	30079073          	csrw	mstatus,a5
    80004018:	304027f3          	csrr	a5,mie
    8000401c:	0807e793          	ori	a5,a5,128
    80004020:	30479073          	csrw	mie,a5
    80004024:	00813403          	ld	s0,8(sp)
    80004028:	01010113          	addi	sp,sp,16
    8000402c:	00008067          	ret

0000000080004030 <system_main>:
    80004030:	fe010113          	addi	sp,sp,-32
    80004034:	00813823          	sd	s0,16(sp)
    80004038:	00913423          	sd	s1,8(sp)
    8000403c:	00113c23          	sd	ra,24(sp)
    80004040:	02010413          	addi	s0,sp,32
    80004044:	00000097          	auipc	ra,0x0
    80004048:	0c4080e7          	jalr	196(ra) # 80004108 <cpuid>
    8000404c:	00004497          	auipc	s1,0x4
    80004050:	89448493          	addi	s1,s1,-1900 # 800078e0 <started>
    80004054:	02050263          	beqz	a0,80004078 <system_main+0x48>
    80004058:	0004a783          	lw	a5,0(s1)
    8000405c:	0007879b          	sext.w	a5,a5
    80004060:	fe078ce3          	beqz	a5,80004058 <system_main+0x28>
    80004064:	0ff0000f          	fence
    80004068:	00002517          	auipc	a0,0x2
    8000406c:	1b050513          	addi	a0,a0,432 # 80006218 <CONSOLE_STATUS+0x208>
    80004070:	00001097          	auipc	ra,0x1
    80004074:	a7c080e7          	jalr	-1412(ra) # 80004aec <panic>
    80004078:	00001097          	auipc	ra,0x1
    8000407c:	9d0080e7          	jalr	-1584(ra) # 80004a48 <consoleinit>
    80004080:	00001097          	auipc	ra,0x1
    80004084:	15c080e7          	jalr	348(ra) # 800051dc <printfinit>
    80004088:	00002517          	auipc	a0,0x2
    8000408c:	0e050513          	addi	a0,a0,224 # 80006168 <CONSOLE_STATUS+0x158>
    80004090:	00001097          	auipc	ra,0x1
    80004094:	ab8080e7          	jalr	-1352(ra) # 80004b48 <__printf>
    80004098:	00002517          	auipc	a0,0x2
    8000409c:	15050513          	addi	a0,a0,336 # 800061e8 <CONSOLE_STATUS+0x1d8>
    800040a0:	00001097          	auipc	ra,0x1
    800040a4:	aa8080e7          	jalr	-1368(ra) # 80004b48 <__printf>
    800040a8:	00002517          	auipc	a0,0x2
    800040ac:	0c050513          	addi	a0,a0,192 # 80006168 <CONSOLE_STATUS+0x158>
    800040b0:	00001097          	auipc	ra,0x1
    800040b4:	a98080e7          	jalr	-1384(ra) # 80004b48 <__printf>
    800040b8:	00001097          	auipc	ra,0x1
    800040bc:	4b0080e7          	jalr	1200(ra) # 80005568 <kinit>
    800040c0:	00000097          	auipc	ra,0x0
    800040c4:	148080e7          	jalr	328(ra) # 80004208 <trapinit>
    800040c8:	00000097          	auipc	ra,0x0
    800040cc:	16c080e7          	jalr	364(ra) # 80004234 <trapinithart>
    800040d0:	00000097          	auipc	ra,0x0
    800040d4:	5c0080e7          	jalr	1472(ra) # 80004690 <plicinit>
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	5e0080e7          	jalr	1504(ra) # 800046b8 <plicinithart>
    800040e0:	00000097          	auipc	ra,0x0
    800040e4:	078080e7          	jalr	120(ra) # 80004158 <userinit>
    800040e8:	0ff0000f          	fence
    800040ec:	00100793          	li	a5,1
    800040f0:	00002517          	auipc	a0,0x2
    800040f4:	11050513          	addi	a0,a0,272 # 80006200 <CONSOLE_STATUS+0x1f0>
    800040f8:	00f4a023          	sw	a5,0(s1)
    800040fc:	00001097          	auipc	ra,0x1
    80004100:	a4c080e7          	jalr	-1460(ra) # 80004b48 <__printf>
    80004104:	0000006f          	j	80004104 <system_main+0xd4>

0000000080004108 <cpuid>:
    80004108:	ff010113          	addi	sp,sp,-16
    8000410c:	00813423          	sd	s0,8(sp)
    80004110:	01010413          	addi	s0,sp,16
    80004114:	00020513          	mv	a0,tp
    80004118:	00813403          	ld	s0,8(sp)
    8000411c:	0005051b          	sext.w	a0,a0
    80004120:	01010113          	addi	sp,sp,16
    80004124:	00008067          	ret

0000000080004128 <mycpu>:
    80004128:	ff010113          	addi	sp,sp,-16
    8000412c:	00813423          	sd	s0,8(sp)
    80004130:	01010413          	addi	s0,sp,16
    80004134:	00020793          	mv	a5,tp
    80004138:	00813403          	ld	s0,8(sp)
    8000413c:	0007879b          	sext.w	a5,a5
    80004140:	00779793          	slli	a5,a5,0x7
    80004144:	00005517          	auipc	a0,0x5
    80004148:	89c50513          	addi	a0,a0,-1892 # 800089e0 <cpus>
    8000414c:	00f50533          	add	a0,a0,a5
    80004150:	01010113          	addi	sp,sp,16
    80004154:	00008067          	ret

0000000080004158 <userinit>:
    80004158:	ff010113          	addi	sp,sp,-16
    8000415c:	00813423          	sd	s0,8(sp)
    80004160:	01010413          	addi	s0,sp,16
    80004164:	00813403          	ld	s0,8(sp)
    80004168:	01010113          	addi	sp,sp,16
    8000416c:	ffffe317          	auipc	t1,0xffffe
    80004170:	68c30067          	jr	1676(t1) # 800027f8 <main>

0000000080004174 <either_copyout>:
    80004174:	ff010113          	addi	sp,sp,-16
    80004178:	00813023          	sd	s0,0(sp)
    8000417c:	00113423          	sd	ra,8(sp)
    80004180:	01010413          	addi	s0,sp,16
    80004184:	02051663          	bnez	a0,800041b0 <either_copyout+0x3c>
    80004188:	00058513          	mv	a0,a1
    8000418c:	00060593          	mv	a1,a2
    80004190:	0006861b          	sext.w	a2,a3
    80004194:	00002097          	auipc	ra,0x2
    80004198:	c60080e7          	jalr	-928(ra) # 80005df4 <__memmove>
    8000419c:	00813083          	ld	ra,8(sp)
    800041a0:	00013403          	ld	s0,0(sp)
    800041a4:	00000513          	li	a0,0
    800041a8:	01010113          	addi	sp,sp,16
    800041ac:	00008067          	ret
    800041b0:	00002517          	auipc	a0,0x2
    800041b4:	09050513          	addi	a0,a0,144 # 80006240 <CONSOLE_STATUS+0x230>
    800041b8:	00001097          	auipc	ra,0x1
    800041bc:	934080e7          	jalr	-1740(ra) # 80004aec <panic>

00000000800041c0 <either_copyin>:
    800041c0:	ff010113          	addi	sp,sp,-16
    800041c4:	00813023          	sd	s0,0(sp)
    800041c8:	00113423          	sd	ra,8(sp)
    800041cc:	01010413          	addi	s0,sp,16
    800041d0:	02059463          	bnez	a1,800041f8 <either_copyin+0x38>
    800041d4:	00060593          	mv	a1,a2
    800041d8:	0006861b          	sext.w	a2,a3
    800041dc:	00002097          	auipc	ra,0x2
    800041e0:	c18080e7          	jalr	-1000(ra) # 80005df4 <__memmove>
    800041e4:	00813083          	ld	ra,8(sp)
    800041e8:	00013403          	ld	s0,0(sp)
    800041ec:	00000513          	li	a0,0
    800041f0:	01010113          	addi	sp,sp,16
    800041f4:	00008067          	ret
    800041f8:	00002517          	auipc	a0,0x2
    800041fc:	07050513          	addi	a0,a0,112 # 80006268 <CONSOLE_STATUS+0x258>
    80004200:	00001097          	auipc	ra,0x1
    80004204:	8ec080e7          	jalr	-1812(ra) # 80004aec <panic>

0000000080004208 <trapinit>:
    80004208:	ff010113          	addi	sp,sp,-16
    8000420c:	00813423          	sd	s0,8(sp)
    80004210:	01010413          	addi	s0,sp,16
    80004214:	00813403          	ld	s0,8(sp)
    80004218:	00002597          	auipc	a1,0x2
    8000421c:	07858593          	addi	a1,a1,120 # 80006290 <CONSOLE_STATUS+0x280>
    80004220:	00005517          	auipc	a0,0x5
    80004224:	84050513          	addi	a0,a0,-1984 # 80008a60 <tickslock>
    80004228:	01010113          	addi	sp,sp,16
    8000422c:	00001317          	auipc	t1,0x1
    80004230:	5cc30067          	jr	1484(t1) # 800057f8 <initlock>

0000000080004234 <trapinithart>:
    80004234:	ff010113          	addi	sp,sp,-16
    80004238:	00813423          	sd	s0,8(sp)
    8000423c:	01010413          	addi	s0,sp,16
    80004240:	00000797          	auipc	a5,0x0
    80004244:	30078793          	addi	a5,a5,768 # 80004540 <kernelvec>
    80004248:	10579073          	csrw	stvec,a5
    8000424c:	00813403          	ld	s0,8(sp)
    80004250:	01010113          	addi	sp,sp,16
    80004254:	00008067          	ret

0000000080004258 <usertrap>:
    80004258:	ff010113          	addi	sp,sp,-16
    8000425c:	00813423          	sd	s0,8(sp)
    80004260:	01010413          	addi	s0,sp,16
    80004264:	00813403          	ld	s0,8(sp)
    80004268:	01010113          	addi	sp,sp,16
    8000426c:	00008067          	ret

0000000080004270 <usertrapret>:
    80004270:	ff010113          	addi	sp,sp,-16
    80004274:	00813423          	sd	s0,8(sp)
    80004278:	01010413          	addi	s0,sp,16
    8000427c:	00813403          	ld	s0,8(sp)
    80004280:	01010113          	addi	sp,sp,16
    80004284:	00008067          	ret

0000000080004288 <kerneltrap>:
    80004288:	fe010113          	addi	sp,sp,-32
    8000428c:	00813823          	sd	s0,16(sp)
    80004290:	00113c23          	sd	ra,24(sp)
    80004294:	00913423          	sd	s1,8(sp)
    80004298:	02010413          	addi	s0,sp,32
    8000429c:	142025f3          	csrr	a1,scause
    800042a0:	100027f3          	csrr	a5,sstatus
    800042a4:	0027f793          	andi	a5,a5,2
    800042a8:	10079c63          	bnez	a5,800043c0 <kerneltrap+0x138>
    800042ac:	142027f3          	csrr	a5,scause
    800042b0:	0207ce63          	bltz	a5,800042ec <kerneltrap+0x64>
    800042b4:	00002517          	auipc	a0,0x2
    800042b8:	02450513          	addi	a0,a0,36 # 800062d8 <CONSOLE_STATUS+0x2c8>
    800042bc:	00001097          	auipc	ra,0x1
    800042c0:	88c080e7          	jalr	-1908(ra) # 80004b48 <__printf>
    800042c4:	141025f3          	csrr	a1,sepc
    800042c8:	14302673          	csrr	a2,stval
    800042cc:	00002517          	auipc	a0,0x2
    800042d0:	01c50513          	addi	a0,a0,28 # 800062e8 <CONSOLE_STATUS+0x2d8>
    800042d4:	00001097          	auipc	ra,0x1
    800042d8:	874080e7          	jalr	-1932(ra) # 80004b48 <__printf>
    800042dc:	00002517          	auipc	a0,0x2
    800042e0:	02450513          	addi	a0,a0,36 # 80006300 <CONSOLE_STATUS+0x2f0>
    800042e4:	00001097          	auipc	ra,0x1
    800042e8:	808080e7          	jalr	-2040(ra) # 80004aec <panic>
    800042ec:	0ff7f713          	andi	a4,a5,255
    800042f0:	00900693          	li	a3,9
    800042f4:	04d70063          	beq	a4,a3,80004334 <kerneltrap+0xac>
    800042f8:	fff00713          	li	a4,-1
    800042fc:	03f71713          	slli	a4,a4,0x3f
    80004300:	00170713          	addi	a4,a4,1
    80004304:	fae798e3          	bne	a5,a4,800042b4 <kerneltrap+0x2c>
    80004308:	00000097          	auipc	ra,0x0
    8000430c:	e00080e7          	jalr	-512(ra) # 80004108 <cpuid>
    80004310:	06050663          	beqz	a0,8000437c <kerneltrap+0xf4>
    80004314:	144027f3          	csrr	a5,sip
    80004318:	ffd7f793          	andi	a5,a5,-3
    8000431c:	14479073          	csrw	sip,a5
    80004320:	01813083          	ld	ra,24(sp)
    80004324:	01013403          	ld	s0,16(sp)
    80004328:	00813483          	ld	s1,8(sp)
    8000432c:	02010113          	addi	sp,sp,32
    80004330:	00008067          	ret
    80004334:	00000097          	auipc	ra,0x0
    80004338:	3d0080e7          	jalr	976(ra) # 80004704 <plic_claim>
    8000433c:	00a00793          	li	a5,10
    80004340:	00050493          	mv	s1,a0
    80004344:	06f50863          	beq	a0,a5,800043b4 <kerneltrap+0x12c>
    80004348:	fc050ce3          	beqz	a0,80004320 <kerneltrap+0x98>
    8000434c:	00050593          	mv	a1,a0
    80004350:	00002517          	auipc	a0,0x2
    80004354:	f6850513          	addi	a0,a0,-152 # 800062b8 <CONSOLE_STATUS+0x2a8>
    80004358:	00000097          	auipc	ra,0x0
    8000435c:	7f0080e7          	jalr	2032(ra) # 80004b48 <__printf>
    80004360:	01013403          	ld	s0,16(sp)
    80004364:	01813083          	ld	ra,24(sp)
    80004368:	00048513          	mv	a0,s1
    8000436c:	00813483          	ld	s1,8(sp)
    80004370:	02010113          	addi	sp,sp,32
    80004374:	00000317          	auipc	t1,0x0
    80004378:	3c830067          	jr	968(t1) # 8000473c <plic_complete>
    8000437c:	00004517          	auipc	a0,0x4
    80004380:	6e450513          	addi	a0,a0,1764 # 80008a60 <tickslock>
    80004384:	00001097          	auipc	ra,0x1
    80004388:	498080e7          	jalr	1176(ra) # 8000581c <acquire>
    8000438c:	00003717          	auipc	a4,0x3
    80004390:	55870713          	addi	a4,a4,1368 # 800078e4 <ticks>
    80004394:	00072783          	lw	a5,0(a4)
    80004398:	00004517          	auipc	a0,0x4
    8000439c:	6c850513          	addi	a0,a0,1736 # 80008a60 <tickslock>
    800043a0:	0017879b          	addiw	a5,a5,1
    800043a4:	00f72023          	sw	a5,0(a4)
    800043a8:	00001097          	auipc	ra,0x1
    800043ac:	540080e7          	jalr	1344(ra) # 800058e8 <release>
    800043b0:	f65ff06f          	j	80004314 <kerneltrap+0x8c>
    800043b4:	00001097          	auipc	ra,0x1
    800043b8:	09c080e7          	jalr	156(ra) # 80005450 <uartintr>
    800043bc:	fa5ff06f          	j	80004360 <kerneltrap+0xd8>
    800043c0:	00002517          	auipc	a0,0x2
    800043c4:	ed850513          	addi	a0,a0,-296 # 80006298 <CONSOLE_STATUS+0x288>
    800043c8:	00000097          	auipc	ra,0x0
    800043cc:	724080e7          	jalr	1828(ra) # 80004aec <panic>

00000000800043d0 <clockintr>:
    800043d0:	fe010113          	addi	sp,sp,-32
    800043d4:	00813823          	sd	s0,16(sp)
    800043d8:	00913423          	sd	s1,8(sp)
    800043dc:	00113c23          	sd	ra,24(sp)
    800043e0:	02010413          	addi	s0,sp,32
    800043e4:	00004497          	auipc	s1,0x4
    800043e8:	67c48493          	addi	s1,s1,1660 # 80008a60 <tickslock>
    800043ec:	00048513          	mv	a0,s1
    800043f0:	00001097          	auipc	ra,0x1
    800043f4:	42c080e7          	jalr	1068(ra) # 8000581c <acquire>
    800043f8:	00003717          	auipc	a4,0x3
    800043fc:	4ec70713          	addi	a4,a4,1260 # 800078e4 <ticks>
    80004400:	00072783          	lw	a5,0(a4)
    80004404:	01013403          	ld	s0,16(sp)
    80004408:	01813083          	ld	ra,24(sp)
    8000440c:	00048513          	mv	a0,s1
    80004410:	0017879b          	addiw	a5,a5,1
    80004414:	00813483          	ld	s1,8(sp)
    80004418:	00f72023          	sw	a5,0(a4)
    8000441c:	02010113          	addi	sp,sp,32
    80004420:	00001317          	auipc	t1,0x1
    80004424:	4c830067          	jr	1224(t1) # 800058e8 <release>

0000000080004428 <devintr>:
    80004428:	142027f3          	csrr	a5,scause
    8000442c:	00000513          	li	a0,0
    80004430:	0007c463          	bltz	a5,80004438 <devintr+0x10>
    80004434:	00008067          	ret
    80004438:	fe010113          	addi	sp,sp,-32
    8000443c:	00813823          	sd	s0,16(sp)
    80004440:	00113c23          	sd	ra,24(sp)
    80004444:	00913423          	sd	s1,8(sp)
    80004448:	02010413          	addi	s0,sp,32
    8000444c:	0ff7f713          	andi	a4,a5,255
    80004450:	00900693          	li	a3,9
    80004454:	04d70c63          	beq	a4,a3,800044ac <devintr+0x84>
    80004458:	fff00713          	li	a4,-1
    8000445c:	03f71713          	slli	a4,a4,0x3f
    80004460:	00170713          	addi	a4,a4,1
    80004464:	00e78c63          	beq	a5,a4,8000447c <devintr+0x54>
    80004468:	01813083          	ld	ra,24(sp)
    8000446c:	01013403          	ld	s0,16(sp)
    80004470:	00813483          	ld	s1,8(sp)
    80004474:	02010113          	addi	sp,sp,32
    80004478:	00008067          	ret
    8000447c:	00000097          	auipc	ra,0x0
    80004480:	c8c080e7          	jalr	-884(ra) # 80004108 <cpuid>
    80004484:	06050663          	beqz	a0,800044f0 <devintr+0xc8>
    80004488:	144027f3          	csrr	a5,sip
    8000448c:	ffd7f793          	andi	a5,a5,-3
    80004490:	14479073          	csrw	sip,a5
    80004494:	01813083          	ld	ra,24(sp)
    80004498:	01013403          	ld	s0,16(sp)
    8000449c:	00813483          	ld	s1,8(sp)
    800044a0:	00200513          	li	a0,2
    800044a4:	02010113          	addi	sp,sp,32
    800044a8:	00008067          	ret
    800044ac:	00000097          	auipc	ra,0x0
    800044b0:	258080e7          	jalr	600(ra) # 80004704 <plic_claim>
    800044b4:	00a00793          	li	a5,10
    800044b8:	00050493          	mv	s1,a0
    800044bc:	06f50663          	beq	a0,a5,80004528 <devintr+0x100>
    800044c0:	00100513          	li	a0,1
    800044c4:	fa0482e3          	beqz	s1,80004468 <devintr+0x40>
    800044c8:	00048593          	mv	a1,s1
    800044cc:	00002517          	auipc	a0,0x2
    800044d0:	dec50513          	addi	a0,a0,-532 # 800062b8 <CONSOLE_STATUS+0x2a8>
    800044d4:	00000097          	auipc	ra,0x0
    800044d8:	674080e7          	jalr	1652(ra) # 80004b48 <__printf>
    800044dc:	00048513          	mv	a0,s1
    800044e0:	00000097          	auipc	ra,0x0
    800044e4:	25c080e7          	jalr	604(ra) # 8000473c <plic_complete>
    800044e8:	00100513          	li	a0,1
    800044ec:	f7dff06f          	j	80004468 <devintr+0x40>
    800044f0:	00004517          	auipc	a0,0x4
    800044f4:	57050513          	addi	a0,a0,1392 # 80008a60 <tickslock>
    800044f8:	00001097          	auipc	ra,0x1
    800044fc:	324080e7          	jalr	804(ra) # 8000581c <acquire>
    80004500:	00003717          	auipc	a4,0x3
    80004504:	3e470713          	addi	a4,a4,996 # 800078e4 <ticks>
    80004508:	00072783          	lw	a5,0(a4)
    8000450c:	00004517          	auipc	a0,0x4
    80004510:	55450513          	addi	a0,a0,1364 # 80008a60 <tickslock>
    80004514:	0017879b          	addiw	a5,a5,1
    80004518:	00f72023          	sw	a5,0(a4)
    8000451c:	00001097          	auipc	ra,0x1
    80004520:	3cc080e7          	jalr	972(ra) # 800058e8 <release>
    80004524:	f65ff06f          	j	80004488 <devintr+0x60>
    80004528:	00001097          	auipc	ra,0x1
    8000452c:	f28080e7          	jalr	-216(ra) # 80005450 <uartintr>
    80004530:	fadff06f          	j	800044dc <devintr+0xb4>
	...

0000000080004540 <kernelvec>:
    80004540:	f0010113          	addi	sp,sp,-256
    80004544:	00113023          	sd	ra,0(sp)
    80004548:	00213423          	sd	sp,8(sp)
    8000454c:	00313823          	sd	gp,16(sp)
    80004550:	00413c23          	sd	tp,24(sp)
    80004554:	02513023          	sd	t0,32(sp)
    80004558:	02613423          	sd	t1,40(sp)
    8000455c:	02713823          	sd	t2,48(sp)
    80004560:	02813c23          	sd	s0,56(sp)
    80004564:	04913023          	sd	s1,64(sp)
    80004568:	04a13423          	sd	a0,72(sp)
    8000456c:	04b13823          	sd	a1,80(sp)
    80004570:	04c13c23          	sd	a2,88(sp)
    80004574:	06d13023          	sd	a3,96(sp)
    80004578:	06e13423          	sd	a4,104(sp)
    8000457c:	06f13823          	sd	a5,112(sp)
    80004580:	07013c23          	sd	a6,120(sp)
    80004584:	09113023          	sd	a7,128(sp)
    80004588:	09213423          	sd	s2,136(sp)
    8000458c:	09313823          	sd	s3,144(sp)
    80004590:	09413c23          	sd	s4,152(sp)
    80004594:	0b513023          	sd	s5,160(sp)
    80004598:	0b613423          	sd	s6,168(sp)
    8000459c:	0b713823          	sd	s7,176(sp)
    800045a0:	0b813c23          	sd	s8,184(sp)
    800045a4:	0d913023          	sd	s9,192(sp)
    800045a8:	0da13423          	sd	s10,200(sp)
    800045ac:	0db13823          	sd	s11,208(sp)
    800045b0:	0dc13c23          	sd	t3,216(sp)
    800045b4:	0fd13023          	sd	t4,224(sp)
    800045b8:	0fe13423          	sd	t5,232(sp)
    800045bc:	0ff13823          	sd	t6,240(sp)
    800045c0:	cc9ff0ef          	jal	ra,80004288 <kerneltrap>
    800045c4:	00013083          	ld	ra,0(sp)
    800045c8:	00813103          	ld	sp,8(sp)
    800045cc:	01013183          	ld	gp,16(sp)
    800045d0:	02013283          	ld	t0,32(sp)
    800045d4:	02813303          	ld	t1,40(sp)
    800045d8:	03013383          	ld	t2,48(sp)
    800045dc:	03813403          	ld	s0,56(sp)
    800045e0:	04013483          	ld	s1,64(sp)
    800045e4:	04813503          	ld	a0,72(sp)
    800045e8:	05013583          	ld	a1,80(sp)
    800045ec:	05813603          	ld	a2,88(sp)
    800045f0:	06013683          	ld	a3,96(sp)
    800045f4:	06813703          	ld	a4,104(sp)
    800045f8:	07013783          	ld	a5,112(sp)
    800045fc:	07813803          	ld	a6,120(sp)
    80004600:	08013883          	ld	a7,128(sp)
    80004604:	08813903          	ld	s2,136(sp)
    80004608:	09013983          	ld	s3,144(sp)
    8000460c:	09813a03          	ld	s4,152(sp)
    80004610:	0a013a83          	ld	s5,160(sp)
    80004614:	0a813b03          	ld	s6,168(sp)
    80004618:	0b013b83          	ld	s7,176(sp)
    8000461c:	0b813c03          	ld	s8,184(sp)
    80004620:	0c013c83          	ld	s9,192(sp)
    80004624:	0c813d03          	ld	s10,200(sp)
    80004628:	0d013d83          	ld	s11,208(sp)
    8000462c:	0d813e03          	ld	t3,216(sp)
    80004630:	0e013e83          	ld	t4,224(sp)
    80004634:	0e813f03          	ld	t5,232(sp)
    80004638:	0f013f83          	ld	t6,240(sp)
    8000463c:	10010113          	addi	sp,sp,256
    80004640:	10200073          	sret
    80004644:	00000013          	nop
    80004648:	00000013          	nop
    8000464c:	00000013          	nop

0000000080004650 <timervec>:
    80004650:	34051573          	csrrw	a0,mscratch,a0
    80004654:	00b53023          	sd	a1,0(a0)
    80004658:	00c53423          	sd	a2,8(a0)
    8000465c:	00d53823          	sd	a3,16(a0)
    80004660:	01853583          	ld	a1,24(a0)
    80004664:	02053603          	ld	a2,32(a0)
    80004668:	0005b683          	ld	a3,0(a1)
    8000466c:	00c686b3          	add	a3,a3,a2
    80004670:	00d5b023          	sd	a3,0(a1)
    80004674:	00200593          	li	a1,2
    80004678:	14459073          	csrw	sip,a1
    8000467c:	01053683          	ld	a3,16(a0)
    80004680:	00853603          	ld	a2,8(a0)
    80004684:	00053583          	ld	a1,0(a0)
    80004688:	34051573          	csrrw	a0,mscratch,a0
    8000468c:	30200073          	mret

0000000080004690 <plicinit>:
    80004690:	ff010113          	addi	sp,sp,-16
    80004694:	00813423          	sd	s0,8(sp)
    80004698:	01010413          	addi	s0,sp,16
    8000469c:	00813403          	ld	s0,8(sp)
    800046a0:	0c0007b7          	lui	a5,0xc000
    800046a4:	00100713          	li	a4,1
    800046a8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800046ac:	00e7a223          	sw	a4,4(a5)
    800046b0:	01010113          	addi	sp,sp,16
    800046b4:	00008067          	ret

00000000800046b8 <plicinithart>:
    800046b8:	ff010113          	addi	sp,sp,-16
    800046bc:	00813023          	sd	s0,0(sp)
    800046c0:	00113423          	sd	ra,8(sp)
    800046c4:	01010413          	addi	s0,sp,16
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	a40080e7          	jalr	-1472(ra) # 80004108 <cpuid>
    800046d0:	0085171b          	slliw	a4,a0,0x8
    800046d4:	0c0027b7          	lui	a5,0xc002
    800046d8:	00e787b3          	add	a5,a5,a4
    800046dc:	40200713          	li	a4,1026
    800046e0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800046e4:	00813083          	ld	ra,8(sp)
    800046e8:	00013403          	ld	s0,0(sp)
    800046ec:	00d5151b          	slliw	a0,a0,0xd
    800046f0:	0c2017b7          	lui	a5,0xc201
    800046f4:	00a78533          	add	a0,a5,a0
    800046f8:	00052023          	sw	zero,0(a0)
    800046fc:	01010113          	addi	sp,sp,16
    80004700:	00008067          	ret

0000000080004704 <plic_claim>:
    80004704:	ff010113          	addi	sp,sp,-16
    80004708:	00813023          	sd	s0,0(sp)
    8000470c:	00113423          	sd	ra,8(sp)
    80004710:	01010413          	addi	s0,sp,16
    80004714:	00000097          	auipc	ra,0x0
    80004718:	9f4080e7          	jalr	-1548(ra) # 80004108 <cpuid>
    8000471c:	00813083          	ld	ra,8(sp)
    80004720:	00013403          	ld	s0,0(sp)
    80004724:	00d5151b          	slliw	a0,a0,0xd
    80004728:	0c2017b7          	lui	a5,0xc201
    8000472c:	00a78533          	add	a0,a5,a0
    80004730:	00452503          	lw	a0,4(a0)
    80004734:	01010113          	addi	sp,sp,16
    80004738:	00008067          	ret

000000008000473c <plic_complete>:
    8000473c:	fe010113          	addi	sp,sp,-32
    80004740:	00813823          	sd	s0,16(sp)
    80004744:	00913423          	sd	s1,8(sp)
    80004748:	00113c23          	sd	ra,24(sp)
    8000474c:	02010413          	addi	s0,sp,32
    80004750:	00050493          	mv	s1,a0
    80004754:	00000097          	auipc	ra,0x0
    80004758:	9b4080e7          	jalr	-1612(ra) # 80004108 <cpuid>
    8000475c:	01813083          	ld	ra,24(sp)
    80004760:	01013403          	ld	s0,16(sp)
    80004764:	00d5179b          	slliw	a5,a0,0xd
    80004768:	0c201737          	lui	a4,0xc201
    8000476c:	00f707b3          	add	a5,a4,a5
    80004770:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004774:	00813483          	ld	s1,8(sp)
    80004778:	02010113          	addi	sp,sp,32
    8000477c:	00008067          	ret

0000000080004780 <consolewrite>:
    80004780:	fb010113          	addi	sp,sp,-80
    80004784:	04813023          	sd	s0,64(sp)
    80004788:	04113423          	sd	ra,72(sp)
    8000478c:	02913c23          	sd	s1,56(sp)
    80004790:	03213823          	sd	s2,48(sp)
    80004794:	03313423          	sd	s3,40(sp)
    80004798:	03413023          	sd	s4,32(sp)
    8000479c:	01513c23          	sd	s5,24(sp)
    800047a0:	05010413          	addi	s0,sp,80
    800047a4:	06c05c63          	blez	a2,8000481c <consolewrite+0x9c>
    800047a8:	00060993          	mv	s3,a2
    800047ac:	00050a13          	mv	s4,a0
    800047b0:	00058493          	mv	s1,a1
    800047b4:	00000913          	li	s2,0
    800047b8:	fff00a93          	li	s5,-1
    800047bc:	01c0006f          	j	800047d8 <consolewrite+0x58>
    800047c0:	fbf44503          	lbu	a0,-65(s0)
    800047c4:	0019091b          	addiw	s2,s2,1
    800047c8:	00148493          	addi	s1,s1,1
    800047cc:	00001097          	auipc	ra,0x1
    800047d0:	a9c080e7          	jalr	-1380(ra) # 80005268 <uartputc>
    800047d4:	03298063          	beq	s3,s2,800047f4 <consolewrite+0x74>
    800047d8:	00048613          	mv	a2,s1
    800047dc:	00100693          	li	a3,1
    800047e0:	000a0593          	mv	a1,s4
    800047e4:	fbf40513          	addi	a0,s0,-65
    800047e8:	00000097          	auipc	ra,0x0
    800047ec:	9d8080e7          	jalr	-1576(ra) # 800041c0 <either_copyin>
    800047f0:	fd5518e3          	bne	a0,s5,800047c0 <consolewrite+0x40>
    800047f4:	04813083          	ld	ra,72(sp)
    800047f8:	04013403          	ld	s0,64(sp)
    800047fc:	03813483          	ld	s1,56(sp)
    80004800:	02813983          	ld	s3,40(sp)
    80004804:	02013a03          	ld	s4,32(sp)
    80004808:	01813a83          	ld	s5,24(sp)
    8000480c:	00090513          	mv	a0,s2
    80004810:	03013903          	ld	s2,48(sp)
    80004814:	05010113          	addi	sp,sp,80
    80004818:	00008067          	ret
    8000481c:	00000913          	li	s2,0
    80004820:	fd5ff06f          	j	800047f4 <consolewrite+0x74>

0000000080004824 <consoleread>:
    80004824:	f9010113          	addi	sp,sp,-112
    80004828:	06813023          	sd	s0,96(sp)
    8000482c:	04913c23          	sd	s1,88(sp)
    80004830:	05213823          	sd	s2,80(sp)
    80004834:	05313423          	sd	s3,72(sp)
    80004838:	05413023          	sd	s4,64(sp)
    8000483c:	03513c23          	sd	s5,56(sp)
    80004840:	03613823          	sd	s6,48(sp)
    80004844:	03713423          	sd	s7,40(sp)
    80004848:	03813023          	sd	s8,32(sp)
    8000484c:	06113423          	sd	ra,104(sp)
    80004850:	01913c23          	sd	s9,24(sp)
    80004854:	07010413          	addi	s0,sp,112
    80004858:	00060b93          	mv	s7,a2
    8000485c:	00050913          	mv	s2,a0
    80004860:	00058c13          	mv	s8,a1
    80004864:	00060b1b          	sext.w	s6,a2
    80004868:	00004497          	auipc	s1,0x4
    8000486c:	22048493          	addi	s1,s1,544 # 80008a88 <cons>
    80004870:	00400993          	li	s3,4
    80004874:	fff00a13          	li	s4,-1
    80004878:	00a00a93          	li	s5,10
    8000487c:	05705e63          	blez	s7,800048d8 <consoleread+0xb4>
    80004880:	09c4a703          	lw	a4,156(s1)
    80004884:	0984a783          	lw	a5,152(s1)
    80004888:	0007071b          	sext.w	a4,a4
    8000488c:	08e78463          	beq	a5,a4,80004914 <consoleread+0xf0>
    80004890:	07f7f713          	andi	a4,a5,127
    80004894:	00e48733          	add	a4,s1,a4
    80004898:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000489c:	0017869b          	addiw	a3,a5,1
    800048a0:	08d4ac23          	sw	a3,152(s1)
    800048a4:	00070c9b          	sext.w	s9,a4
    800048a8:	0b370663          	beq	a4,s3,80004954 <consoleread+0x130>
    800048ac:	00100693          	li	a3,1
    800048b0:	f9f40613          	addi	a2,s0,-97
    800048b4:	000c0593          	mv	a1,s8
    800048b8:	00090513          	mv	a0,s2
    800048bc:	f8e40fa3          	sb	a4,-97(s0)
    800048c0:	00000097          	auipc	ra,0x0
    800048c4:	8b4080e7          	jalr	-1868(ra) # 80004174 <either_copyout>
    800048c8:	01450863          	beq	a0,s4,800048d8 <consoleread+0xb4>
    800048cc:	001c0c13          	addi	s8,s8,1
    800048d0:	fffb8b9b          	addiw	s7,s7,-1
    800048d4:	fb5c94e3          	bne	s9,s5,8000487c <consoleread+0x58>
    800048d8:	000b851b          	sext.w	a0,s7
    800048dc:	06813083          	ld	ra,104(sp)
    800048e0:	06013403          	ld	s0,96(sp)
    800048e4:	05813483          	ld	s1,88(sp)
    800048e8:	05013903          	ld	s2,80(sp)
    800048ec:	04813983          	ld	s3,72(sp)
    800048f0:	04013a03          	ld	s4,64(sp)
    800048f4:	03813a83          	ld	s5,56(sp)
    800048f8:	02813b83          	ld	s7,40(sp)
    800048fc:	02013c03          	ld	s8,32(sp)
    80004900:	01813c83          	ld	s9,24(sp)
    80004904:	40ab053b          	subw	a0,s6,a0
    80004908:	03013b03          	ld	s6,48(sp)
    8000490c:	07010113          	addi	sp,sp,112
    80004910:	00008067          	ret
    80004914:	00001097          	auipc	ra,0x1
    80004918:	1d8080e7          	jalr	472(ra) # 80005aec <push_on>
    8000491c:	0984a703          	lw	a4,152(s1)
    80004920:	09c4a783          	lw	a5,156(s1)
    80004924:	0007879b          	sext.w	a5,a5
    80004928:	fef70ce3          	beq	a4,a5,80004920 <consoleread+0xfc>
    8000492c:	00001097          	auipc	ra,0x1
    80004930:	234080e7          	jalr	564(ra) # 80005b60 <pop_on>
    80004934:	0984a783          	lw	a5,152(s1)
    80004938:	07f7f713          	andi	a4,a5,127
    8000493c:	00e48733          	add	a4,s1,a4
    80004940:	01874703          	lbu	a4,24(a4)
    80004944:	0017869b          	addiw	a3,a5,1
    80004948:	08d4ac23          	sw	a3,152(s1)
    8000494c:	00070c9b          	sext.w	s9,a4
    80004950:	f5371ee3          	bne	a4,s3,800048ac <consoleread+0x88>
    80004954:	000b851b          	sext.w	a0,s7
    80004958:	f96bf2e3          	bgeu	s7,s6,800048dc <consoleread+0xb8>
    8000495c:	08f4ac23          	sw	a5,152(s1)
    80004960:	f7dff06f          	j	800048dc <consoleread+0xb8>

0000000080004964 <consputc>:
    80004964:	10000793          	li	a5,256
    80004968:	00f50663          	beq	a0,a5,80004974 <consputc+0x10>
    8000496c:	00001317          	auipc	t1,0x1
    80004970:	9f430067          	jr	-1548(t1) # 80005360 <uartputc_sync>
    80004974:	ff010113          	addi	sp,sp,-16
    80004978:	00113423          	sd	ra,8(sp)
    8000497c:	00813023          	sd	s0,0(sp)
    80004980:	01010413          	addi	s0,sp,16
    80004984:	00800513          	li	a0,8
    80004988:	00001097          	auipc	ra,0x1
    8000498c:	9d8080e7          	jalr	-1576(ra) # 80005360 <uartputc_sync>
    80004990:	02000513          	li	a0,32
    80004994:	00001097          	auipc	ra,0x1
    80004998:	9cc080e7          	jalr	-1588(ra) # 80005360 <uartputc_sync>
    8000499c:	00013403          	ld	s0,0(sp)
    800049a0:	00813083          	ld	ra,8(sp)
    800049a4:	00800513          	li	a0,8
    800049a8:	01010113          	addi	sp,sp,16
    800049ac:	00001317          	auipc	t1,0x1
    800049b0:	9b430067          	jr	-1612(t1) # 80005360 <uartputc_sync>

00000000800049b4 <consoleintr>:
    800049b4:	fe010113          	addi	sp,sp,-32
    800049b8:	00813823          	sd	s0,16(sp)
    800049bc:	00913423          	sd	s1,8(sp)
    800049c0:	01213023          	sd	s2,0(sp)
    800049c4:	00113c23          	sd	ra,24(sp)
    800049c8:	02010413          	addi	s0,sp,32
    800049cc:	00004917          	auipc	s2,0x4
    800049d0:	0bc90913          	addi	s2,s2,188 # 80008a88 <cons>
    800049d4:	00050493          	mv	s1,a0
    800049d8:	00090513          	mv	a0,s2
    800049dc:	00001097          	auipc	ra,0x1
    800049e0:	e40080e7          	jalr	-448(ra) # 8000581c <acquire>
    800049e4:	02048c63          	beqz	s1,80004a1c <consoleintr+0x68>
    800049e8:	0a092783          	lw	a5,160(s2)
    800049ec:	09892703          	lw	a4,152(s2)
    800049f0:	07f00693          	li	a3,127
    800049f4:	40e7873b          	subw	a4,a5,a4
    800049f8:	02e6e263          	bltu	a3,a4,80004a1c <consoleintr+0x68>
    800049fc:	00d00713          	li	a4,13
    80004a00:	04e48063          	beq	s1,a4,80004a40 <consoleintr+0x8c>
    80004a04:	07f7f713          	andi	a4,a5,127
    80004a08:	00e90733          	add	a4,s2,a4
    80004a0c:	0017879b          	addiw	a5,a5,1
    80004a10:	0af92023          	sw	a5,160(s2)
    80004a14:	00970c23          	sb	s1,24(a4)
    80004a18:	08f92e23          	sw	a5,156(s2)
    80004a1c:	01013403          	ld	s0,16(sp)
    80004a20:	01813083          	ld	ra,24(sp)
    80004a24:	00813483          	ld	s1,8(sp)
    80004a28:	00013903          	ld	s2,0(sp)
    80004a2c:	00004517          	auipc	a0,0x4
    80004a30:	05c50513          	addi	a0,a0,92 # 80008a88 <cons>
    80004a34:	02010113          	addi	sp,sp,32
    80004a38:	00001317          	auipc	t1,0x1
    80004a3c:	eb030067          	jr	-336(t1) # 800058e8 <release>
    80004a40:	00a00493          	li	s1,10
    80004a44:	fc1ff06f          	j	80004a04 <consoleintr+0x50>

0000000080004a48 <consoleinit>:
    80004a48:	fe010113          	addi	sp,sp,-32
    80004a4c:	00113c23          	sd	ra,24(sp)
    80004a50:	00813823          	sd	s0,16(sp)
    80004a54:	00913423          	sd	s1,8(sp)
    80004a58:	02010413          	addi	s0,sp,32
    80004a5c:	00004497          	auipc	s1,0x4
    80004a60:	02c48493          	addi	s1,s1,44 # 80008a88 <cons>
    80004a64:	00048513          	mv	a0,s1
    80004a68:	00002597          	auipc	a1,0x2
    80004a6c:	8a858593          	addi	a1,a1,-1880 # 80006310 <CONSOLE_STATUS+0x300>
    80004a70:	00001097          	auipc	ra,0x1
    80004a74:	d88080e7          	jalr	-632(ra) # 800057f8 <initlock>
    80004a78:	00000097          	auipc	ra,0x0
    80004a7c:	7ac080e7          	jalr	1964(ra) # 80005224 <uartinit>
    80004a80:	01813083          	ld	ra,24(sp)
    80004a84:	01013403          	ld	s0,16(sp)
    80004a88:	00000797          	auipc	a5,0x0
    80004a8c:	d9c78793          	addi	a5,a5,-612 # 80004824 <consoleread>
    80004a90:	0af4bc23          	sd	a5,184(s1)
    80004a94:	00000797          	auipc	a5,0x0
    80004a98:	cec78793          	addi	a5,a5,-788 # 80004780 <consolewrite>
    80004a9c:	0cf4b023          	sd	a5,192(s1)
    80004aa0:	00813483          	ld	s1,8(sp)
    80004aa4:	02010113          	addi	sp,sp,32
    80004aa8:	00008067          	ret

0000000080004aac <console_read>:
    80004aac:	ff010113          	addi	sp,sp,-16
    80004ab0:	00813423          	sd	s0,8(sp)
    80004ab4:	01010413          	addi	s0,sp,16
    80004ab8:	00813403          	ld	s0,8(sp)
    80004abc:	00004317          	auipc	t1,0x4
    80004ac0:	08433303          	ld	t1,132(t1) # 80008b40 <devsw+0x10>
    80004ac4:	01010113          	addi	sp,sp,16
    80004ac8:	00030067          	jr	t1

0000000080004acc <console_write>:
    80004acc:	ff010113          	addi	sp,sp,-16
    80004ad0:	00813423          	sd	s0,8(sp)
    80004ad4:	01010413          	addi	s0,sp,16
    80004ad8:	00813403          	ld	s0,8(sp)
    80004adc:	00004317          	auipc	t1,0x4
    80004ae0:	06c33303          	ld	t1,108(t1) # 80008b48 <devsw+0x18>
    80004ae4:	01010113          	addi	sp,sp,16
    80004ae8:	00030067          	jr	t1

0000000080004aec <panic>:
    80004aec:	fe010113          	addi	sp,sp,-32
    80004af0:	00113c23          	sd	ra,24(sp)
    80004af4:	00813823          	sd	s0,16(sp)
    80004af8:	00913423          	sd	s1,8(sp)
    80004afc:	02010413          	addi	s0,sp,32
    80004b00:	00050493          	mv	s1,a0
    80004b04:	00002517          	auipc	a0,0x2
    80004b08:	81450513          	addi	a0,a0,-2028 # 80006318 <CONSOLE_STATUS+0x308>
    80004b0c:	00004797          	auipc	a5,0x4
    80004b10:	0c07ae23          	sw	zero,220(a5) # 80008be8 <pr+0x18>
    80004b14:	00000097          	auipc	ra,0x0
    80004b18:	034080e7          	jalr	52(ra) # 80004b48 <__printf>
    80004b1c:	00048513          	mv	a0,s1
    80004b20:	00000097          	auipc	ra,0x0
    80004b24:	028080e7          	jalr	40(ra) # 80004b48 <__printf>
    80004b28:	00001517          	auipc	a0,0x1
    80004b2c:	64050513          	addi	a0,a0,1600 # 80006168 <CONSOLE_STATUS+0x158>
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	018080e7          	jalr	24(ra) # 80004b48 <__printf>
    80004b38:	00100793          	li	a5,1
    80004b3c:	00003717          	auipc	a4,0x3
    80004b40:	daf72623          	sw	a5,-596(a4) # 800078e8 <panicked>
    80004b44:	0000006f          	j	80004b44 <panic+0x58>

0000000080004b48 <__printf>:
    80004b48:	f3010113          	addi	sp,sp,-208
    80004b4c:	08813023          	sd	s0,128(sp)
    80004b50:	07313423          	sd	s3,104(sp)
    80004b54:	09010413          	addi	s0,sp,144
    80004b58:	05813023          	sd	s8,64(sp)
    80004b5c:	08113423          	sd	ra,136(sp)
    80004b60:	06913c23          	sd	s1,120(sp)
    80004b64:	07213823          	sd	s2,112(sp)
    80004b68:	07413023          	sd	s4,96(sp)
    80004b6c:	05513c23          	sd	s5,88(sp)
    80004b70:	05613823          	sd	s6,80(sp)
    80004b74:	05713423          	sd	s7,72(sp)
    80004b78:	03913c23          	sd	s9,56(sp)
    80004b7c:	03a13823          	sd	s10,48(sp)
    80004b80:	03b13423          	sd	s11,40(sp)
    80004b84:	00004317          	auipc	t1,0x4
    80004b88:	04c30313          	addi	t1,t1,76 # 80008bd0 <pr>
    80004b8c:	01832c03          	lw	s8,24(t1)
    80004b90:	00b43423          	sd	a1,8(s0)
    80004b94:	00c43823          	sd	a2,16(s0)
    80004b98:	00d43c23          	sd	a3,24(s0)
    80004b9c:	02e43023          	sd	a4,32(s0)
    80004ba0:	02f43423          	sd	a5,40(s0)
    80004ba4:	03043823          	sd	a6,48(s0)
    80004ba8:	03143c23          	sd	a7,56(s0)
    80004bac:	00050993          	mv	s3,a0
    80004bb0:	4a0c1663          	bnez	s8,8000505c <__printf+0x514>
    80004bb4:	60098c63          	beqz	s3,800051cc <__printf+0x684>
    80004bb8:	0009c503          	lbu	a0,0(s3)
    80004bbc:	00840793          	addi	a5,s0,8
    80004bc0:	f6f43c23          	sd	a5,-136(s0)
    80004bc4:	00000493          	li	s1,0
    80004bc8:	22050063          	beqz	a0,80004de8 <__printf+0x2a0>
    80004bcc:	00002a37          	lui	s4,0x2
    80004bd0:	00018ab7          	lui	s5,0x18
    80004bd4:	000f4b37          	lui	s6,0xf4
    80004bd8:	00989bb7          	lui	s7,0x989
    80004bdc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004be0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004be4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004be8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80004bec:	00148c9b          	addiw	s9,s1,1
    80004bf0:	02500793          	li	a5,37
    80004bf4:	01998933          	add	s2,s3,s9
    80004bf8:	38f51263          	bne	a0,a5,80004f7c <__printf+0x434>
    80004bfc:	00094783          	lbu	a5,0(s2)
    80004c00:	00078c9b          	sext.w	s9,a5
    80004c04:	1e078263          	beqz	a5,80004de8 <__printf+0x2a0>
    80004c08:	0024849b          	addiw	s1,s1,2
    80004c0c:	07000713          	li	a4,112
    80004c10:	00998933          	add	s2,s3,s1
    80004c14:	38e78a63          	beq	a5,a4,80004fa8 <__printf+0x460>
    80004c18:	20f76863          	bltu	a4,a5,80004e28 <__printf+0x2e0>
    80004c1c:	42a78863          	beq	a5,a0,8000504c <__printf+0x504>
    80004c20:	06400713          	li	a4,100
    80004c24:	40e79663          	bne	a5,a4,80005030 <__printf+0x4e8>
    80004c28:	f7843783          	ld	a5,-136(s0)
    80004c2c:	0007a603          	lw	a2,0(a5)
    80004c30:	00878793          	addi	a5,a5,8
    80004c34:	f6f43c23          	sd	a5,-136(s0)
    80004c38:	42064a63          	bltz	a2,8000506c <__printf+0x524>
    80004c3c:	00a00713          	li	a4,10
    80004c40:	02e677bb          	remuw	a5,a2,a4
    80004c44:	00001d97          	auipc	s11,0x1
    80004c48:	6fcd8d93          	addi	s11,s11,1788 # 80006340 <digits>
    80004c4c:	00900593          	li	a1,9
    80004c50:	0006051b          	sext.w	a0,a2
    80004c54:	00000c93          	li	s9,0
    80004c58:	02079793          	slli	a5,a5,0x20
    80004c5c:	0207d793          	srli	a5,a5,0x20
    80004c60:	00fd87b3          	add	a5,s11,a5
    80004c64:	0007c783          	lbu	a5,0(a5)
    80004c68:	02e656bb          	divuw	a3,a2,a4
    80004c6c:	f8f40023          	sb	a5,-128(s0)
    80004c70:	14c5d863          	bge	a1,a2,80004dc0 <__printf+0x278>
    80004c74:	06300593          	li	a1,99
    80004c78:	00100c93          	li	s9,1
    80004c7c:	02e6f7bb          	remuw	a5,a3,a4
    80004c80:	02079793          	slli	a5,a5,0x20
    80004c84:	0207d793          	srli	a5,a5,0x20
    80004c88:	00fd87b3          	add	a5,s11,a5
    80004c8c:	0007c783          	lbu	a5,0(a5)
    80004c90:	02e6d73b          	divuw	a4,a3,a4
    80004c94:	f8f400a3          	sb	a5,-127(s0)
    80004c98:	12a5f463          	bgeu	a1,a0,80004dc0 <__printf+0x278>
    80004c9c:	00a00693          	li	a3,10
    80004ca0:	00900593          	li	a1,9
    80004ca4:	02d777bb          	remuw	a5,a4,a3
    80004ca8:	02079793          	slli	a5,a5,0x20
    80004cac:	0207d793          	srli	a5,a5,0x20
    80004cb0:	00fd87b3          	add	a5,s11,a5
    80004cb4:	0007c503          	lbu	a0,0(a5)
    80004cb8:	02d757bb          	divuw	a5,a4,a3
    80004cbc:	f8a40123          	sb	a0,-126(s0)
    80004cc0:	48e5f263          	bgeu	a1,a4,80005144 <__printf+0x5fc>
    80004cc4:	06300513          	li	a0,99
    80004cc8:	02d7f5bb          	remuw	a1,a5,a3
    80004ccc:	02059593          	slli	a1,a1,0x20
    80004cd0:	0205d593          	srli	a1,a1,0x20
    80004cd4:	00bd85b3          	add	a1,s11,a1
    80004cd8:	0005c583          	lbu	a1,0(a1)
    80004cdc:	02d7d7bb          	divuw	a5,a5,a3
    80004ce0:	f8b401a3          	sb	a1,-125(s0)
    80004ce4:	48e57263          	bgeu	a0,a4,80005168 <__printf+0x620>
    80004ce8:	3e700513          	li	a0,999
    80004cec:	02d7f5bb          	remuw	a1,a5,a3
    80004cf0:	02059593          	slli	a1,a1,0x20
    80004cf4:	0205d593          	srli	a1,a1,0x20
    80004cf8:	00bd85b3          	add	a1,s11,a1
    80004cfc:	0005c583          	lbu	a1,0(a1)
    80004d00:	02d7d7bb          	divuw	a5,a5,a3
    80004d04:	f8b40223          	sb	a1,-124(s0)
    80004d08:	46e57663          	bgeu	a0,a4,80005174 <__printf+0x62c>
    80004d0c:	02d7f5bb          	remuw	a1,a5,a3
    80004d10:	02059593          	slli	a1,a1,0x20
    80004d14:	0205d593          	srli	a1,a1,0x20
    80004d18:	00bd85b3          	add	a1,s11,a1
    80004d1c:	0005c583          	lbu	a1,0(a1)
    80004d20:	02d7d7bb          	divuw	a5,a5,a3
    80004d24:	f8b402a3          	sb	a1,-123(s0)
    80004d28:	46ea7863          	bgeu	s4,a4,80005198 <__printf+0x650>
    80004d2c:	02d7f5bb          	remuw	a1,a5,a3
    80004d30:	02059593          	slli	a1,a1,0x20
    80004d34:	0205d593          	srli	a1,a1,0x20
    80004d38:	00bd85b3          	add	a1,s11,a1
    80004d3c:	0005c583          	lbu	a1,0(a1)
    80004d40:	02d7d7bb          	divuw	a5,a5,a3
    80004d44:	f8b40323          	sb	a1,-122(s0)
    80004d48:	3eeaf863          	bgeu	s5,a4,80005138 <__printf+0x5f0>
    80004d4c:	02d7f5bb          	remuw	a1,a5,a3
    80004d50:	02059593          	slli	a1,a1,0x20
    80004d54:	0205d593          	srli	a1,a1,0x20
    80004d58:	00bd85b3          	add	a1,s11,a1
    80004d5c:	0005c583          	lbu	a1,0(a1)
    80004d60:	02d7d7bb          	divuw	a5,a5,a3
    80004d64:	f8b403a3          	sb	a1,-121(s0)
    80004d68:	42eb7e63          	bgeu	s6,a4,800051a4 <__printf+0x65c>
    80004d6c:	02d7f5bb          	remuw	a1,a5,a3
    80004d70:	02059593          	slli	a1,a1,0x20
    80004d74:	0205d593          	srli	a1,a1,0x20
    80004d78:	00bd85b3          	add	a1,s11,a1
    80004d7c:	0005c583          	lbu	a1,0(a1)
    80004d80:	02d7d7bb          	divuw	a5,a5,a3
    80004d84:	f8b40423          	sb	a1,-120(s0)
    80004d88:	42ebfc63          	bgeu	s7,a4,800051c0 <__printf+0x678>
    80004d8c:	02079793          	slli	a5,a5,0x20
    80004d90:	0207d793          	srli	a5,a5,0x20
    80004d94:	00fd8db3          	add	s11,s11,a5
    80004d98:	000dc703          	lbu	a4,0(s11)
    80004d9c:	00a00793          	li	a5,10
    80004da0:	00900c93          	li	s9,9
    80004da4:	f8e404a3          	sb	a4,-119(s0)
    80004da8:	00065c63          	bgez	a2,80004dc0 <__printf+0x278>
    80004dac:	f9040713          	addi	a4,s0,-112
    80004db0:	00f70733          	add	a4,a4,a5
    80004db4:	02d00693          	li	a3,45
    80004db8:	fed70823          	sb	a3,-16(a4)
    80004dbc:	00078c93          	mv	s9,a5
    80004dc0:	f8040793          	addi	a5,s0,-128
    80004dc4:	01978cb3          	add	s9,a5,s9
    80004dc8:	f7f40d13          	addi	s10,s0,-129
    80004dcc:	000cc503          	lbu	a0,0(s9)
    80004dd0:	fffc8c93          	addi	s9,s9,-1
    80004dd4:	00000097          	auipc	ra,0x0
    80004dd8:	b90080e7          	jalr	-1136(ra) # 80004964 <consputc>
    80004ddc:	ffac98e3          	bne	s9,s10,80004dcc <__printf+0x284>
    80004de0:	00094503          	lbu	a0,0(s2)
    80004de4:	e00514e3          	bnez	a0,80004bec <__printf+0xa4>
    80004de8:	1a0c1663          	bnez	s8,80004f94 <__printf+0x44c>
    80004dec:	08813083          	ld	ra,136(sp)
    80004df0:	08013403          	ld	s0,128(sp)
    80004df4:	07813483          	ld	s1,120(sp)
    80004df8:	07013903          	ld	s2,112(sp)
    80004dfc:	06813983          	ld	s3,104(sp)
    80004e00:	06013a03          	ld	s4,96(sp)
    80004e04:	05813a83          	ld	s5,88(sp)
    80004e08:	05013b03          	ld	s6,80(sp)
    80004e0c:	04813b83          	ld	s7,72(sp)
    80004e10:	04013c03          	ld	s8,64(sp)
    80004e14:	03813c83          	ld	s9,56(sp)
    80004e18:	03013d03          	ld	s10,48(sp)
    80004e1c:	02813d83          	ld	s11,40(sp)
    80004e20:	0d010113          	addi	sp,sp,208
    80004e24:	00008067          	ret
    80004e28:	07300713          	li	a4,115
    80004e2c:	1ce78a63          	beq	a5,a4,80005000 <__printf+0x4b8>
    80004e30:	07800713          	li	a4,120
    80004e34:	1ee79e63          	bne	a5,a4,80005030 <__printf+0x4e8>
    80004e38:	f7843783          	ld	a5,-136(s0)
    80004e3c:	0007a703          	lw	a4,0(a5)
    80004e40:	00878793          	addi	a5,a5,8
    80004e44:	f6f43c23          	sd	a5,-136(s0)
    80004e48:	28074263          	bltz	a4,800050cc <__printf+0x584>
    80004e4c:	00001d97          	auipc	s11,0x1
    80004e50:	4f4d8d93          	addi	s11,s11,1268 # 80006340 <digits>
    80004e54:	00f77793          	andi	a5,a4,15
    80004e58:	00fd87b3          	add	a5,s11,a5
    80004e5c:	0007c683          	lbu	a3,0(a5)
    80004e60:	00f00613          	li	a2,15
    80004e64:	0007079b          	sext.w	a5,a4
    80004e68:	f8d40023          	sb	a3,-128(s0)
    80004e6c:	0047559b          	srliw	a1,a4,0x4
    80004e70:	0047569b          	srliw	a3,a4,0x4
    80004e74:	00000c93          	li	s9,0
    80004e78:	0ee65063          	bge	a2,a4,80004f58 <__printf+0x410>
    80004e7c:	00f6f693          	andi	a3,a3,15
    80004e80:	00dd86b3          	add	a3,s11,a3
    80004e84:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004e88:	0087d79b          	srliw	a5,a5,0x8
    80004e8c:	00100c93          	li	s9,1
    80004e90:	f8d400a3          	sb	a3,-127(s0)
    80004e94:	0cb67263          	bgeu	a2,a1,80004f58 <__printf+0x410>
    80004e98:	00f7f693          	andi	a3,a5,15
    80004e9c:	00dd86b3          	add	a3,s11,a3
    80004ea0:	0006c583          	lbu	a1,0(a3)
    80004ea4:	00f00613          	li	a2,15
    80004ea8:	0047d69b          	srliw	a3,a5,0x4
    80004eac:	f8b40123          	sb	a1,-126(s0)
    80004eb0:	0047d593          	srli	a1,a5,0x4
    80004eb4:	28f67e63          	bgeu	a2,a5,80005150 <__printf+0x608>
    80004eb8:	00f6f693          	andi	a3,a3,15
    80004ebc:	00dd86b3          	add	a3,s11,a3
    80004ec0:	0006c503          	lbu	a0,0(a3)
    80004ec4:	0087d813          	srli	a6,a5,0x8
    80004ec8:	0087d69b          	srliw	a3,a5,0x8
    80004ecc:	f8a401a3          	sb	a0,-125(s0)
    80004ed0:	28b67663          	bgeu	a2,a1,8000515c <__printf+0x614>
    80004ed4:	00f6f693          	andi	a3,a3,15
    80004ed8:	00dd86b3          	add	a3,s11,a3
    80004edc:	0006c583          	lbu	a1,0(a3)
    80004ee0:	00c7d513          	srli	a0,a5,0xc
    80004ee4:	00c7d69b          	srliw	a3,a5,0xc
    80004ee8:	f8b40223          	sb	a1,-124(s0)
    80004eec:	29067a63          	bgeu	a2,a6,80005180 <__printf+0x638>
    80004ef0:	00f6f693          	andi	a3,a3,15
    80004ef4:	00dd86b3          	add	a3,s11,a3
    80004ef8:	0006c583          	lbu	a1,0(a3)
    80004efc:	0107d813          	srli	a6,a5,0x10
    80004f00:	0107d69b          	srliw	a3,a5,0x10
    80004f04:	f8b402a3          	sb	a1,-123(s0)
    80004f08:	28a67263          	bgeu	a2,a0,8000518c <__printf+0x644>
    80004f0c:	00f6f693          	andi	a3,a3,15
    80004f10:	00dd86b3          	add	a3,s11,a3
    80004f14:	0006c683          	lbu	a3,0(a3)
    80004f18:	0147d79b          	srliw	a5,a5,0x14
    80004f1c:	f8d40323          	sb	a3,-122(s0)
    80004f20:	21067663          	bgeu	a2,a6,8000512c <__printf+0x5e4>
    80004f24:	02079793          	slli	a5,a5,0x20
    80004f28:	0207d793          	srli	a5,a5,0x20
    80004f2c:	00fd8db3          	add	s11,s11,a5
    80004f30:	000dc683          	lbu	a3,0(s11)
    80004f34:	00800793          	li	a5,8
    80004f38:	00700c93          	li	s9,7
    80004f3c:	f8d403a3          	sb	a3,-121(s0)
    80004f40:	00075c63          	bgez	a4,80004f58 <__printf+0x410>
    80004f44:	f9040713          	addi	a4,s0,-112
    80004f48:	00f70733          	add	a4,a4,a5
    80004f4c:	02d00693          	li	a3,45
    80004f50:	fed70823          	sb	a3,-16(a4)
    80004f54:	00078c93          	mv	s9,a5
    80004f58:	f8040793          	addi	a5,s0,-128
    80004f5c:	01978cb3          	add	s9,a5,s9
    80004f60:	f7f40d13          	addi	s10,s0,-129
    80004f64:	000cc503          	lbu	a0,0(s9)
    80004f68:	fffc8c93          	addi	s9,s9,-1
    80004f6c:	00000097          	auipc	ra,0x0
    80004f70:	9f8080e7          	jalr	-1544(ra) # 80004964 <consputc>
    80004f74:	ff9d18e3          	bne	s10,s9,80004f64 <__printf+0x41c>
    80004f78:	0100006f          	j	80004f88 <__printf+0x440>
    80004f7c:	00000097          	auipc	ra,0x0
    80004f80:	9e8080e7          	jalr	-1560(ra) # 80004964 <consputc>
    80004f84:	000c8493          	mv	s1,s9
    80004f88:	00094503          	lbu	a0,0(s2)
    80004f8c:	c60510e3          	bnez	a0,80004bec <__printf+0xa4>
    80004f90:	e40c0ee3          	beqz	s8,80004dec <__printf+0x2a4>
    80004f94:	00004517          	auipc	a0,0x4
    80004f98:	c3c50513          	addi	a0,a0,-964 # 80008bd0 <pr>
    80004f9c:	00001097          	auipc	ra,0x1
    80004fa0:	94c080e7          	jalr	-1716(ra) # 800058e8 <release>
    80004fa4:	e49ff06f          	j	80004dec <__printf+0x2a4>
    80004fa8:	f7843783          	ld	a5,-136(s0)
    80004fac:	03000513          	li	a0,48
    80004fb0:	01000d13          	li	s10,16
    80004fb4:	00878713          	addi	a4,a5,8
    80004fb8:	0007bc83          	ld	s9,0(a5)
    80004fbc:	f6e43c23          	sd	a4,-136(s0)
    80004fc0:	00000097          	auipc	ra,0x0
    80004fc4:	9a4080e7          	jalr	-1628(ra) # 80004964 <consputc>
    80004fc8:	07800513          	li	a0,120
    80004fcc:	00000097          	auipc	ra,0x0
    80004fd0:	998080e7          	jalr	-1640(ra) # 80004964 <consputc>
    80004fd4:	00001d97          	auipc	s11,0x1
    80004fd8:	36cd8d93          	addi	s11,s11,876 # 80006340 <digits>
    80004fdc:	03ccd793          	srli	a5,s9,0x3c
    80004fe0:	00fd87b3          	add	a5,s11,a5
    80004fe4:	0007c503          	lbu	a0,0(a5)
    80004fe8:	fffd0d1b          	addiw	s10,s10,-1
    80004fec:	004c9c93          	slli	s9,s9,0x4
    80004ff0:	00000097          	auipc	ra,0x0
    80004ff4:	974080e7          	jalr	-1676(ra) # 80004964 <consputc>
    80004ff8:	fe0d12e3          	bnez	s10,80004fdc <__printf+0x494>
    80004ffc:	f8dff06f          	j	80004f88 <__printf+0x440>
    80005000:	f7843783          	ld	a5,-136(s0)
    80005004:	0007bc83          	ld	s9,0(a5)
    80005008:	00878793          	addi	a5,a5,8
    8000500c:	f6f43c23          	sd	a5,-136(s0)
    80005010:	000c9a63          	bnez	s9,80005024 <__printf+0x4dc>
    80005014:	1080006f          	j	8000511c <__printf+0x5d4>
    80005018:	001c8c93          	addi	s9,s9,1
    8000501c:	00000097          	auipc	ra,0x0
    80005020:	948080e7          	jalr	-1720(ra) # 80004964 <consputc>
    80005024:	000cc503          	lbu	a0,0(s9)
    80005028:	fe0518e3          	bnez	a0,80005018 <__printf+0x4d0>
    8000502c:	f5dff06f          	j	80004f88 <__printf+0x440>
    80005030:	02500513          	li	a0,37
    80005034:	00000097          	auipc	ra,0x0
    80005038:	930080e7          	jalr	-1744(ra) # 80004964 <consputc>
    8000503c:	000c8513          	mv	a0,s9
    80005040:	00000097          	auipc	ra,0x0
    80005044:	924080e7          	jalr	-1756(ra) # 80004964 <consputc>
    80005048:	f41ff06f          	j	80004f88 <__printf+0x440>
    8000504c:	02500513          	li	a0,37
    80005050:	00000097          	auipc	ra,0x0
    80005054:	914080e7          	jalr	-1772(ra) # 80004964 <consputc>
    80005058:	f31ff06f          	j	80004f88 <__printf+0x440>
    8000505c:	00030513          	mv	a0,t1
    80005060:	00000097          	auipc	ra,0x0
    80005064:	7bc080e7          	jalr	1980(ra) # 8000581c <acquire>
    80005068:	b4dff06f          	j	80004bb4 <__printf+0x6c>
    8000506c:	40c0053b          	negw	a0,a2
    80005070:	00a00713          	li	a4,10
    80005074:	02e576bb          	remuw	a3,a0,a4
    80005078:	00001d97          	auipc	s11,0x1
    8000507c:	2c8d8d93          	addi	s11,s11,712 # 80006340 <digits>
    80005080:	ff700593          	li	a1,-9
    80005084:	02069693          	slli	a3,a3,0x20
    80005088:	0206d693          	srli	a3,a3,0x20
    8000508c:	00dd86b3          	add	a3,s11,a3
    80005090:	0006c683          	lbu	a3,0(a3)
    80005094:	02e557bb          	divuw	a5,a0,a4
    80005098:	f8d40023          	sb	a3,-128(s0)
    8000509c:	10b65e63          	bge	a2,a1,800051b8 <__printf+0x670>
    800050a0:	06300593          	li	a1,99
    800050a4:	02e7f6bb          	remuw	a3,a5,a4
    800050a8:	02069693          	slli	a3,a3,0x20
    800050ac:	0206d693          	srli	a3,a3,0x20
    800050b0:	00dd86b3          	add	a3,s11,a3
    800050b4:	0006c683          	lbu	a3,0(a3)
    800050b8:	02e7d73b          	divuw	a4,a5,a4
    800050bc:	00200793          	li	a5,2
    800050c0:	f8d400a3          	sb	a3,-127(s0)
    800050c4:	bca5ece3          	bltu	a1,a0,80004c9c <__printf+0x154>
    800050c8:	ce5ff06f          	j	80004dac <__printf+0x264>
    800050cc:	40e007bb          	negw	a5,a4
    800050d0:	00001d97          	auipc	s11,0x1
    800050d4:	270d8d93          	addi	s11,s11,624 # 80006340 <digits>
    800050d8:	00f7f693          	andi	a3,a5,15
    800050dc:	00dd86b3          	add	a3,s11,a3
    800050e0:	0006c583          	lbu	a1,0(a3)
    800050e4:	ff100613          	li	a2,-15
    800050e8:	0047d69b          	srliw	a3,a5,0x4
    800050ec:	f8b40023          	sb	a1,-128(s0)
    800050f0:	0047d59b          	srliw	a1,a5,0x4
    800050f4:	0ac75e63          	bge	a4,a2,800051b0 <__printf+0x668>
    800050f8:	00f6f693          	andi	a3,a3,15
    800050fc:	00dd86b3          	add	a3,s11,a3
    80005100:	0006c603          	lbu	a2,0(a3)
    80005104:	00f00693          	li	a3,15
    80005108:	0087d79b          	srliw	a5,a5,0x8
    8000510c:	f8c400a3          	sb	a2,-127(s0)
    80005110:	d8b6e4e3          	bltu	a3,a1,80004e98 <__printf+0x350>
    80005114:	00200793          	li	a5,2
    80005118:	e2dff06f          	j	80004f44 <__printf+0x3fc>
    8000511c:	00001c97          	auipc	s9,0x1
    80005120:	204c8c93          	addi	s9,s9,516 # 80006320 <CONSOLE_STATUS+0x310>
    80005124:	02800513          	li	a0,40
    80005128:	ef1ff06f          	j	80005018 <__printf+0x4d0>
    8000512c:	00700793          	li	a5,7
    80005130:	00600c93          	li	s9,6
    80005134:	e0dff06f          	j	80004f40 <__printf+0x3f8>
    80005138:	00700793          	li	a5,7
    8000513c:	00600c93          	li	s9,6
    80005140:	c69ff06f          	j	80004da8 <__printf+0x260>
    80005144:	00300793          	li	a5,3
    80005148:	00200c93          	li	s9,2
    8000514c:	c5dff06f          	j	80004da8 <__printf+0x260>
    80005150:	00300793          	li	a5,3
    80005154:	00200c93          	li	s9,2
    80005158:	de9ff06f          	j	80004f40 <__printf+0x3f8>
    8000515c:	00400793          	li	a5,4
    80005160:	00300c93          	li	s9,3
    80005164:	dddff06f          	j	80004f40 <__printf+0x3f8>
    80005168:	00400793          	li	a5,4
    8000516c:	00300c93          	li	s9,3
    80005170:	c39ff06f          	j	80004da8 <__printf+0x260>
    80005174:	00500793          	li	a5,5
    80005178:	00400c93          	li	s9,4
    8000517c:	c2dff06f          	j	80004da8 <__printf+0x260>
    80005180:	00500793          	li	a5,5
    80005184:	00400c93          	li	s9,4
    80005188:	db9ff06f          	j	80004f40 <__printf+0x3f8>
    8000518c:	00600793          	li	a5,6
    80005190:	00500c93          	li	s9,5
    80005194:	dadff06f          	j	80004f40 <__printf+0x3f8>
    80005198:	00600793          	li	a5,6
    8000519c:	00500c93          	li	s9,5
    800051a0:	c09ff06f          	j	80004da8 <__printf+0x260>
    800051a4:	00800793          	li	a5,8
    800051a8:	00700c93          	li	s9,7
    800051ac:	bfdff06f          	j	80004da8 <__printf+0x260>
    800051b0:	00100793          	li	a5,1
    800051b4:	d91ff06f          	j	80004f44 <__printf+0x3fc>
    800051b8:	00100793          	li	a5,1
    800051bc:	bf1ff06f          	j	80004dac <__printf+0x264>
    800051c0:	00900793          	li	a5,9
    800051c4:	00800c93          	li	s9,8
    800051c8:	be1ff06f          	j	80004da8 <__printf+0x260>
    800051cc:	00001517          	auipc	a0,0x1
    800051d0:	15c50513          	addi	a0,a0,348 # 80006328 <CONSOLE_STATUS+0x318>
    800051d4:	00000097          	auipc	ra,0x0
    800051d8:	918080e7          	jalr	-1768(ra) # 80004aec <panic>

00000000800051dc <printfinit>:
    800051dc:	fe010113          	addi	sp,sp,-32
    800051e0:	00813823          	sd	s0,16(sp)
    800051e4:	00913423          	sd	s1,8(sp)
    800051e8:	00113c23          	sd	ra,24(sp)
    800051ec:	02010413          	addi	s0,sp,32
    800051f0:	00004497          	auipc	s1,0x4
    800051f4:	9e048493          	addi	s1,s1,-1568 # 80008bd0 <pr>
    800051f8:	00048513          	mv	a0,s1
    800051fc:	00001597          	auipc	a1,0x1
    80005200:	13c58593          	addi	a1,a1,316 # 80006338 <CONSOLE_STATUS+0x328>
    80005204:	00000097          	auipc	ra,0x0
    80005208:	5f4080e7          	jalr	1524(ra) # 800057f8 <initlock>
    8000520c:	01813083          	ld	ra,24(sp)
    80005210:	01013403          	ld	s0,16(sp)
    80005214:	0004ac23          	sw	zero,24(s1)
    80005218:	00813483          	ld	s1,8(sp)
    8000521c:	02010113          	addi	sp,sp,32
    80005220:	00008067          	ret

0000000080005224 <uartinit>:
    80005224:	ff010113          	addi	sp,sp,-16
    80005228:	00813423          	sd	s0,8(sp)
    8000522c:	01010413          	addi	s0,sp,16
    80005230:	100007b7          	lui	a5,0x10000
    80005234:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005238:	f8000713          	li	a4,-128
    8000523c:	00e781a3          	sb	a4,3(a5)
    80005240:	00300713          	li	a4,3
    80005244:	00e78023          	sb	a4,0(a5)
    80005248:	000780a3          	sb	zero,1(a5)
    8000524c:	00e781a3          	sb	a4,3(a5)
    80005250:	00700693          	li	a3,7
    80005254:	00d78123          	sb	a3,2(a5)
    80005258:	00e780a3          	sb	a4,1(a5)
    8000525c:	00813403          	ld	s0,8(sp)
    80005260:	01010113          	addi	sp,sp,16
    80005264:	00008067          	ret

0000000080005268 <uartputc>:
    80005268:	00002797          	auipc	a5,0x2
    8000526c:	6807a783          	lw	a5,1664(a5) # 800078e8 <panicked>
    80005270:	00078463          	beqz	a5,80005278 <uartputc+0x10>
    80005274:	0000006f          	j	80005274 <uartputc+0xc>
    80005278:	fd010113          	addi	sp,sp,-48
    8000527c:	02813023          	sd	s0,32(sp)
    80005280:	00913c23          	sd	s1,24(sp)
    80005284:	01213823          	sd	s2,16(sp)
    80005288:	01313423          	sd	s3,8(sp)
    8000528c:	02113423          	sd	ra,40(sp)
    80005290:	03010413          	addi	s0,sp,48
    80005294:	00002917          	auipc	s2,0x2
    80005298:	65c90913          	addi	s2,s2,1628 # 800078f0 <uart_tx_r>
    8000529c:	00093783          	ld	a5,0(s2)
    800052a0:	00002497          	auipc	s1,0x2
    800052a4:	65848493          	addi	s1,s1,1624 # 800078f8 <uart_tx_w>
    800052a8:	0004b703          	ld	a4,0(s1)
    800052ac:	02078693          	addi	a3,a5,32
    800052b0:	00050993          	mv	s3,a0
    800052b4:	02e69c63          	bne	a3,a4,800052ec <uartputc+0x84>
    800052b8:	00001097          	auipc	ra,0x1
    800052bc:	834080e7          	jalr	-1996(ra) # 80005aec <push_on>
    800052c0:	00093783          	ld	a5,0(s2)
    800052c4:	0004b703          	ld	a4,0(s1)
    800052c8:	02078793          	addi	a5,a5,32
    800052cc:	00e79463          	bne	a5,a4,800052d4 <uartputc+0x6c>
    800052d0:	0000006f          	j	800052d0 <uartputc+0x68>
    800052d4:	00001097          	auipc	ra,0x1
    800052d8:	88c080e7          	jalr	-1908(ra) # 80005b60 <pop_on>
    800052dc:	00093783          	ld	a5,0(s2)
    800052e0:	0004b703          	ld	a4,0(s1)
    800052e4:	02078693          	addi	a3,a5,32
    800052e8:	fce688e3          	beq	a3,a4,800052b8 <uartputc+0x50>
    800052ec:	01f77693          	andi	a3,a4,31
    800052f0:	00004597          	auipc	a1,0x4
    800052f4:	90058593          	addi	a1,a1,-1792 # 80008bf0 <uart_tx_buf>
    800052f8:	00d586b3          	add	a3,a1,a3
    800052fc:	00170713          	addi	a4,a4,1
    80005300:	01368023          	sb	s3,0(a3)
    80005304:	00e4b023          	sd	a4,0(s1)
    80005308:	10000637          	lui	a2,0x10000
    8000530c:	02f71063          	bne	a4,a5,8000532c <uartputc+0xc4>
    80005310:	0340006f          	j	80005344 <uartputc+0xdc>
    80005314:	00074703          	lbu	a4,0(a4)
    80005318:	00f93023          	sd	a5,0(s2)
    8000531c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005320:	00093783          	ld	a5,0(s2)
    80005324:	0004b703          	ld	a4,0(s1)
    80005328:	00f70e63          	beq	a4,a5,80005344 <uartputc+0xdc>
    8000532c:	00564683          	lbu	a3,5(a2)
    80005330:	01f7f713          	andi	a4,a5,31
    80005334:	00e58733          	add	a4,a1,a4
    80005338:	0206f693          	andi	a3,a3,32
    8000533c:	00178793          	addi	a5,a5,1
    80005340:	fc069ae3          	bnez	a3,80005314 <uartputc+0xac>
    80005344:	02813083          	ld	ra,40(sp)
    80005348:	02013403          	ld	s0,32(sp)
    8000534c:	01813483          	ld	s1,24(sp)
    80005350:	01013903          	ld	s2,16(sp)
    80005354:	00813983          	ld	s3,8(sp)
    80005358:	03010113          	addi	sp,sp,48
    8000535c:	00008067          	ret

0000000080005360 <uartputc_sync>:
    80005360:	ff010113          	addi	sp,sp,-16
    80005364:	00813423          	sd	s0,8(sp)
    80005368:	01010413          	addi	s0,sp,16
    8000536c:	00002717          	auipc	a4,0x2
    80005370:	57c72703          	lw	a4,1404(a4) # 800078e8 <panicked>
    80005374:	02071663          	bnez	a4,800053a0 <uartputc_sync+0x40>
    80005378:	00050793          	mv	a5,a0
    8000537c:	100006b7          	lui	a3,0x10000
    80005380:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005384:	02077713          	andi	a4,a4,32
    80005388:	fe070ce3          	beqz	a4,80005380 <uartputc_sync+0x20>
    8000538c:	0ff7f793          	andi	a5,a5,255
    80005390:	00f68023          	sb	a5,0(a3)
    80005394:	00813403          	ld	s0,8(sp)
    80005398:	01010113          	addi	sp,sp,16
    8000539c:	00008067          	ret
    800053a0:	0000006f          	j	800053a0 <uartputc_sync+0x40>

00000000800053a4 <uartstart>:
    800053a4:	ff010113          	addi	sp,sp,-16
    800053a8:	00813423          	sd	s0,8(sp)
    800053ac:	01010413          	addi	s0,sp,16
    800053b0:	00002617          	auipc	a2,0x2
    800053b4:	54060613          	addi	a2,a2,1344 # 800078f0 <uart_tx_r>
    800053b8:	00002517          	auipc	a0,0x2
    800053bc:	54050513          	addi	a0,a0,1344 # 800078f8 <uart_tx_w>
    800053c0:	00063783          	ld	a5,0(a2)
    800053c4:	00053703          	ld	a4,0(a0)
    800053c8:	04f70263          	beq	a4,a5,8000540c <uartstart+0x68>
    800053cc:	100005b7          	lui	a1,0x10000
    800053d0:	00004817          	auipc	a6,0x4
    800053d4:	82080813          	addi	a6,a6,-2016 # 80008bf0 <uart_tx_buf>
    800053d8:	01c0006f          	j	800053f4 <uartstart+0x50>
    800053dc:	0006c703          	lbu	a4,0(a3)
    800053e0:	00f63023          	sd	a5,0(a2)
    800053e4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800053e8:	00063783          	ld	a5,0(a2)
    800053ec:	00053703          	ld	a4,0(a0)
    800053f0:	00f70e63          	beq	a4,a5,8000540c <uartstart+0x68>
    800053f4:	01f7f713          	andi	a4,a5,31
    800053f8:	00e806b3          	add	a3,a6,a4
    800053fc:	0055c703          	lbu	a4,5(a1)
    80005400:	00178793          	addi	a5,a5,1
    80005404:	02077713          	andi	a4,a4,32
    80005408:	fc071ae3          	bnez	a4,800053dc <uartstart+0x38>
    8000540c:	00813403          	ld	s0,8(sp)
    80005410:	01010113          	addi	sp,sp,16
    80005414:	00008067          	ret

0000000080005418 <uartgetc>:
    80005418:	ff010113          	addi	sp,sp,-16
    8000541c:	00813423          	sd	s0,8(sp)
    80005420:	01010413          	addi	s0,sp,16
    80005424:	10000737          	lui	a4,0x10000
    80005428:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000542c:	0017f793          	andi	a5,a5,1
    80005430:	00078c63          	beqz	a5,80005448 <uartgetc+0x30>
    80005434:	00074503          	lbu	a0,0(a4)
    80005438:	0ff57513          	andi	a0,a0,255
    8000543c:	00813403          	ld	s0,8(sp)
    80005440:	01010113          	addi	sp,sp,16
    80005444:	00008067          	ret
    80005448:	fff00513          	li	a0,-1
    8000544c:	ff1ff06f          	j	8000543c <uartgetc+0x24>

0000000080005450 <uartintr>:
    80005450:	100007b7          	lui	a5,0x10000
    80005454:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005458:	0017f793          	andi	a5,a5,1
    8000545c:	0a078463          	beqz	a5,80005504 <uartintr+0xb4>
    80005460:	fe010113          	addi	sp,sp,-32
    80005464:	00813823          	sd	s0,16(sp)
    80005468:	00913423          	sd	s1,8(sp)
    8000546c:	00113c23          	sd	ra,24(sp)
    80005470:	02010413          	addi	s0,sp,32
    80005474:	100004b7          	lui	s1,0x10000
    80005478:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000547c:	0ff57513          	andi	a0,a0,255
    80005480:	fffff097          	auipc	ra,0xfffff
    80005484:	534080e7          	jalr	1332(ra) # 800049b4 <consoleintr>
    80005488:	0054c783          	lbu	a5,5(s1)
    8000548c:	0017f793          	andi	a5,a5,1
    80005490:	fe0794e3          	bnez	a5,80005478 <uartintr+0x28>
    80005494:	00002617          	auipc	a2,0x2
    80005498:	45c60613          	addi	a2,a2,1116 # 800078f0 <uart_tx_r>
    8000549c:	00002517          	auipc	a0,0x2
    800054a0:	45c50513          	addi	a0,a0,1116 # 800078f8 <uart_tx_w>
    800054a4:	00063783          	ld	a5,0(a2)
    800054a8:	00053703          	ld	a4,0(a0)
    800054ac:	04f70263          	beq	a4,a5,800054f0 <uartintr+0xa0>
    800054b0:	100005b7          	lui	a1,0x10000
    800054b4:	00003817          	auipc	a6,0x3
    800054b8:	73c80813          	addi	a6,a6,1852 # 80008bf0 <uart_tx_buf>
    800054bc:	01c0006f          	j	800054d8 <uartintr+0x88>
    800054c0:	0006c703          	lbu	a4,0(a3)
    800054c4:	00f63023          	sd	a5,0(a2)
    800054c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800054cc:	00063783          	ld	a5,0(a2)
    800054d0:	00053703          	ld	a4,0(a0)
    800054d4:	00f70e63          	beq	a4,a5,800054f0 <uartintr+0xa0>
    800054d8:	01f7f713          	andi	a4,a5,31
    800054dc:	00e806b3          	add	a3,a6,a4
    800054e0:	0055c703          	lbu	a4,5(a1)
    800054e4:	00178793          	addi	a5,a5,1
    800054e8:	02077713          	andi	a4,a4,32
    800054ec:	fc071ae3          	bnez	a4,800054c0 <uartintr+0x70>
    800054f0:	01813083          	ld	ra,24(sp)
    800054f4:	01013403          	ld	s0,16(sp)
    800054f8:	00813483          	ld	s1,8(sp)
    800054fc:	02010113          	addi	sp,sp,32
    80005500:	00008067          	ret
    80005504:	00002617          	auipc	a2,0x2
    80005508:	3ec60613          	addi	a2,a2,1004 # 800078f0 <uart_tx_r>
    8000550c:	00002517          	auipc	a0,0x2
    80005510:	3ec50513          	addi	a0,a0,1004 # 800078f8 <uart_tx_w>
    80005514:	00063783          	ld	a5,0(a2)
    80005518:	00053703          	ld	a4,0(a0)
    8000551c:	04f70263          	beq	a4,a5,80005560 <uartintr+0x110>
    80005520:	100005b7          	lui	a1,0x10000
    80005524:	00003817          	auipc	a6,0x3
    80005528:	6cc80813          	addi	a6,a6,1740 # 80008bf0 <uart_tx_buf>
    8000552c:	01c0006f          	j	80005548 <uartintr+0xf8>
    80005530:	0006c703          	lbu	a4,0(a3)
    80005534:	00f63023          	sd	a5,0(a2)
    80005538:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000553c:	00063783          	ld	a5,0(a2)
    80005540:	00053703          	ld	a4,0(a0)
    80005544:	02f70063          	beq	a4,a5,80005564 <uartintr+0x114>
    80005548:	01f7f713          	andi	a4,a5,31
    8000554c:	00e806b3          	add	a3,a6,a4
    80005550:	0055c703          	lbu	a4,5(a1)
    80005554:	00178793          	addi	a5,a5,1
    80005558:	02077713          	andi	a4,a4,32
    8000555c:	fc071ae3          	bnez	a4,80005530 <uartintr+0xe0>
    80005560:	00008067          	ret
    80005564:	00008067          	ret

0000000080005568 <kinit>:
    80005568:	fc010113          	addi	sp,sp,-64
    8000556c:	02913423          	sd	s1,40(sp)
    80005570:	fffff7b7          	lui	a5,0xfffff
    80005574:	00004497          	auipc	s1,0x4
    80005578:	69b48493          	addi	s1,s1,1691 # 80009c0f <end+0xfff>
    8000557c:	02813823          	sd	s0,48(sp)
    80005580:	01313c23          	sd	s3,24(sp)
    80005584:	00f4f4b3          	and	s1,s1,a5
    80005588:	02113c23          	sd	ra,56(sp)
    8000558c:	03213023          	sd	s2,32(sp)
    80005590:	01413823          	sd	s4,16(sp)
    80005594:	01513423          	sd	s5,8(sp)
    80005598:	04010413          	addi	s0,sp,64
    8000559c:	000017b7          	lui	a5,0x1
    800055a0:	01100993          	li	s3,17
    800055a4:	00f487b3          	add	a5,s1,a5
    800055a8:	01b99993          	slli	s3,s3,0x1b
    800055ac:	06f9e063          	bltu	s3,a5,8000560c <kinit+0xa4>
    800055b0:	00003a97          	auipc	s5,0x3
    800055b4:	660a8a93          	addi	s5,s5,1632 # 80008c10 <end>
    800055b8:	0754ec63          	bltu	s1,s5,80005630 <kinit+0xc8>
    800055bc:	0734fa63          	bgeu	s1,s3,80005630 <kinit+0xc8>
    800055c0:	00088a37          	lui	s4,0x88
    800055c4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800055c8:	00002917          	auipc	s2,0x2
    800055cc:	33890913          	addi	s2,s2,824 # 80007900 <kmem>
    800055d0:	00ca1a13          	slli	s4,s4,0xc
    800055d4:	0140006f          	j	800055e8 <kinit+0x80>
    800055d8:	000017b7          	lui	a5,0x1
    800055dc:	00f484b3          	add	s1,s1,a5
    800055e0:	0554e863          	bltu	s1,s5,80005630 <kinit+0xc8>
    800055e4:	0534f663          	bgeu	s1,s3,80005630 <kinit+0xc8>
    800055e8:	00001637          	lui	a2,0x1
    800055ec:	00100593          	li	a1,1
    800055f0:	00048513          	mv	a0,s1
    800055f4:	00000097          	auipc	ra,0x0
    800055f8:	5e4080e7          	jalr	1508(ra) # 80005bd8 <__memset>
    800055fc:	00093783          	ld	a5,0(s2)
    80005600:	00f4b023          	sd	a5,0(s1)
    80005604:	00993023          	sd	s1,0(s2)
    80005608:	fd4498e3          	bne	s1,s4,800055d8 <kinit+0x70>
    8000560c:	03813083          	ld	ra,56(sp)
    80005610:	03013403          	ld	s0,48(sp)
    80005614:	02813483          	ld	s1,40(sp)
    80005618:	02013903          	ld	s2,32(sp)
    8000561c:	01813983          	ld	s3,24(sp)
    80005620:	01013a03          	ld	s4,16(sp)
    80005624:	00813a83          	ld	s5,8(sp)
    80005628:	04010113          	addi	sp,sp,64
    8000562c:	00008067          	ret
    80005630:	00001517          	auipc	a0,0x1
    80005634:	d2850513          	addi	a0,a0,-728 # 80006358 <digits+0x18>
    80005638:	fffff097          	auipc	ra,0xfffff
    8000563c:	4b4080e7          	jalr	1204(ra) # 80004aec <panic>

0000000080005640 <freerange>:
    80005640:	fc010113          	addi	sp,sp,-64
    80005644:	000017b7          	lui	a5,0x1
    80005648:	02913423          	sd	s1,40(sp)
    8000564c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005650:	009504b3          	add	s1,a0,s1
    80005654:	fffff537          	lui	a0,0xfffff
    80005658:	02813823          	sd	s0,48(sp)
    8000565c:	02113c23          	sd	ra,56(sp)
    80005660:	03213023          	sd	s2,32(sp)
    80005664:	01313c23          	sd	s3,24(sp)
    80005668:	01413823          	sd	s4,16(sp)
    8000566c:	01513423          	sd	s5,8(sp)
    80005670:	01613023          	sd	s6,0(sp)
    80005674:	04010413          	addi	s0,sp,64
    80005678:	00a4f4b3          	and	s1,s1,a0
    8000567c:	00f487b3          	add	a5,s1,a5
    80005680:	06f5e463          	bltu	a1,a5,800056e8 <freerange+0xa8>
    80005684:	00003a97          	auipc	s5,0x3
    80005688:	58ca8a93          	addi	s5,s5,1420 # 80008c10 <end>
    8000568c:	0954e263          	bltu	s1,s5,80005710 <freerange+0xd0>
    80005690:	01100993          	li	s3,17
    80005694:	01b99993          	slli	s3,s3,0x1b
    80005698:	0734fc63          	bgeu	s1,s3,80005710 <freerange+0xd0>
    8000569c:	00058a13          	mv	s4,a1
    800056a0:	00002917          	auipc	s2,0x2
    800056a4:	26090913          	addi	s2,s2,608 # 80007900 <kmem>
    800056a8:	00002b37          	lui	s6,0x2
    800056ac:	0140006f          	j	800056c0 <freerange+0x80>
    800056b0:	000017b7          	lui	a5,0x1
    800056b4:	00f484b3          	add	s1,s1,a5
    800056b8:	0554ec63          	bltu	s1,s5,80005710 <freerange+0xd0>
    800056bc:	0534fa63          	bgeu	s1,s3,80005710 <freerange+0xd0>
    800056c0:	00001637          	lui	a2,0x1
    800056c4:	00100593          	li	a1,1
    800056c8:	00048513          	mv	a0,s1
    800056cc:	00000097          	auipc	ra,0x0
    800056d0:	50c080e7          	jalr	1292(ra) # 80005bd8 <__memset>
    800056d4:	00093703          	ld	a4,0(s2)
    800056d8:	016487b3          	add	a5,s1,s6
    800056dc:	00e4b023          	sd	a4,0(s1)
    800056e0:	00993023          	sd	s1,0(s2)
    800056e4:	fcfa76e3          	bgeu	s4,a5,800056b0 <freerange+0x70>
    800056e8:	03813083          	ld	ra,56(sp)
    800056ec:	03013403          	ld	s0,48(sp)
    800056f0:	02813483          	ld	s1,40(sp)
    800056f4:	02013903          	ld	s2,32(sp)
    800056f8:	01813983          	ld	s3,24(sp)
    800056fc:	01013a03          	ld	s4,16(sp)
    80005700:	00813a83          	ld	s5,8(sp)
    80005704:	00013b03          	ld	s6,0(sp)
    80005708:	04010113          	addi	sp,sp,64
    8000570c:	00008067          	ret
    80005710:	00001517          	auipc	a0,0x1
    80005714:	c4850513          	addi	a0,a0,-952 # 80006358 <digits+0x18>
    80005718:	fffff097          	auipc	ra,0xfffff
    8000571c:	3d4080e7          	jalr	980(ra) # 80004aec <panic>

0000000080005720 <kfree>:
    80005720:	fe010113          	addi	sp,sp,-32
    80005724:	00813823          	sd	s0,16(sp)
    80005728:	00113c23          	sd	ra,24(sp)
    8000572c:	00913423          	sd	s1,8(sp)
    80005730:	02010413          	addi	s0,sp,32
    80005734:	03451793          	slli	a5,a0,0x34
    80005738:	04079c63          	bnez	a5,80005790 <kfree+0x70>
    8000573c:	00003797          	auipc	a5,0x3
    80005740:	4d478793          	addi	a5,a5,1236 # 80008c10 <end>
    80005744:	00050493          	mv	s1,a0
    80005748:	04f56463          	bltu	a0,a5,80005790 <kfree+0x70>
    8000574c:	01100793          	li	a5,17
    80005750:	01b79793          	slli	a5,a5,0x1b
    80005754:	02f57e63          	bgeu	a0,a5,80005790 <kfree+0x70>
    80005758:	00001637          	lui	a2,0x1
    8000575c:	00100593          	li	a1,1
    80005760:	00000097          	auipc	ra,0x0
    80005764:	478080e7          	jalr	1144(ra) # 80005bd8 <__memset>
    80005768:	00002797          	auipc	a5,0x2
    8000576c:	19878793          	addi	a5,a5,408 # 80007900 <kmem>
    80005770:	0007b703          	ld	a4,0(a5)
    80005774:	01813083          	ld	ra,24(sp)
    80005778:	01013403          	ld	s0,16(sp)
    8000577c:	00e4b023          	sd	a4,0(s1)
    80005780:	0097b023          	sd	s1,0(a5)
    80005784:	00813483          	ld	s1,8(sp)
    80005788:	02010113          	addi	sp,sp,32
    8000578c:	00008067          	ret
    80005790:	00001517          	auipc	a0,0x1
    80005794:	bc850513          	addi	a0,a0,-1080 # 80006358 <digits+0x18>
    80005798:	fffff097          	auipc	ra,0xfffff
    8000579c:	354080e7          	jalr	852(ra) # 80004aec <panic>

00000000800057a0 <kalloc>:
    800057a0:	fe010113          	addi	sp,sp,-32
    800057a4:	00813823          	sd	s0,16(sp)
    800057a8:	00913423          	sd	s1,8(sp)
    800057ac:	00113c23          	sd	ra,24(sp)
    800057b0:	02010413          	addi	s0,sp,32
    800057b4:	00002797          	auipc	a5,0x2
    800057b8:	14c78793          	addi	a5,a5,332 # 80007900 <kmem>
    800057bc:	0007b483          	ld	s1,0(a5)
    800057c0:	02048063          	beqz	s1,800057e0 <kalloc+0x40>
    800057c4:	0004b703          	ld	a4,0(s1)
    800057c8:	00001637          	lui	a2,0x1
    800057cc:	00500593          	li	a1,5
    800057d0:	00048513          	mv	a0,s1
    800057d4:	00e7b023          	sd	a4,0(a5)
    800057d8:	00000097          	auipc	ra,0x0
    800057dc:	400080e7          	jalr	1024(ra) # 80005bd8 <__memset>
    800057e0:	01813083          	ld	ra,24(sp)
    800057e4:	01013403          	ld	s0,16(sp)
    800057e8:	00048513          	mv	a0,s1
    800057ec:	00813483          	ld	s1,8(sp)
    800057f0:	02010113          	addi	sp,sp,32
    800057f4:	00008067          	ret

00000000800057f8 <initlock>:
    800057f8:	ff010113          	addi	sp,sp,-16
    800057fc:	00813423          	sd	s0,8(sp)
    80005800:	01010413          	addi	s0,sp,16
    80005804:	00813403          	ld	s0,8(sp)
    80005808:	00b53423          	sd	a1,8(a0)
    8000580c:	00052023          	sw	zero,0(a0)
    80005810:	00053823          	sd	zero,16(a0)
    80005814:	01010113          	addi	sp,sp,16
    80005818:	00008067          	ret

000000008000581c <acquire>:
    8000581c:	fe010113          	addi	sp,sp,-32
    80005820:	00813823          	sd	s0,16(sp)
    80005824:	00913423          	sd	s1,8(sp)
    80005828:	00113c23          	sd	ra,24(sp)
    8000582c:	01213023          	sd	s2,0(sp)
    80005830:	02010413          	addi	s0,sp,32
    80005834:	00050493          	mv	s1,a0
    80005838:	10002973          	csrr	s2,sstatus
    8000583c:	100027f3          	csrr	a5,sstatus
    80005840:	ffd7f793          	andi	a5,a5,-3
    80005844:	10079073          	csrw	sstatus,a5
    80005848:	fffff097          	auipc	ra,0xfffff
    8000584c:	8e0080e7          	jalr	-1824(ra) # 80004128 <mycpu>
    80005850:	07852783          	lw	a5,120(a0)
    80005854:	06078e63          	beqz	a5,800058d0 <acquire+0xb4>
    80005858:	fffff097          	auipc	ra,0xfffff
    8000585c:	8d0080e7          	jalr	-1840(ra) # 80004128 <mycpu>
    80005860:	07852783          	lw	a5,120(a0)
    80005864:	0004a703          	lw	a4,0(s1)
    80005868:	0017879b          	addiw	a5,a5,1
    8000586c:	06f52c23          	sw	a5,120(a0)
    80005870:	04071063          	bnez	a4,800058b0 <acquire+0x94>
    80005874:	00100713          	li	a4,1
    80005878:	00070793          	mv	a5,a4
    8000587c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005880:	0007879b          	sext.w	a5,a5
    80005884:	fe079ae3          	bnez	a5,80005878 <acquire+0x5c>
    80005888:	0ff0000f          	fence
    8000588c:	fffff097          	auipc	ra,0xfffff
    80005890:	89c080e7          	jalr	-1892(ra) # 80004128 <mycpu>
    80005894:	01813083          	ld	ra,24(sp)
    80005898:	01013403          	ld	s0,16(sp)
    8000589c:	00a4b823          	sd	a0,16(s1)
    800058a0:	00013903          	ld	s2,0(sp)
    800058a4:	00813483          	ld	s1,8(sp)
    800058a8:	02010113          	addi	sp,sp,32
    800058ac:	00008067          	ret
    800058b0:	0104b903          	ld	s2,16(s1)
    800058b4:	fffff097          	auipc	ra,0xfffff
    800058b8:	874080e7          	jalr	-1932(ra) # 80004128 <mycpu>
    800058bc:	faa91ce3          	bne	s2,a0,80005874 <acquire+0x58>
    800058c0:	00001517          	auipc	a0,0x1
    800058c4:	aa050513          	addi	a0,a0,-1376 # 80006360 <digits+0x20>
    800058c8:	fffff097          	auipc	ra,0xfffff
    800058cc:	224080e7          	jalr	548(ra) # 80004aec <panic>
    800058d0:	00195913          	srli	s2,s2,0x1
    800058d4:	fffff097          	auipc	ra,0xfffff
    800058d8:	854080e7          	jalr	-1964(ra) # 80004128 <mycpu>
    800058dc:	00197913          	andi	s2,s2,1
    800058e0:	07252e23          	sw	s2,124(a0)
    800058e4:	f75ff06f          	j	80005858 <acquire+0x3c>

00000000800058e8 <release>:
    800058e8:	fe010113          	addi	sp,sp,-32
    800058ec:	00813823          	sd	s0,16(sp)
    800058f0:	00113c23          	sd	ra,24(sp)
    800058f4:	00913423          	sd	s1,8(sp)
    800058f8:	01213023          	sd	s2,0(sp)
    800058fc:	02010413          	addi	s0,sp,32
    80005900:	00052783          	lw	a5,0(a0)
    80005904:	00079a63          	bnez	a5,80005918 <release+0x30>
    80005908:	00001517          	auipc	a0,0x1
    8000590c:	a6050513          	addi	a0,a0,-1440 # 80006368 <digits+0x28>
    80005910:	fffff097          	auipc	ra,0xfffff
    80005914:	1dc080e7          	jalr	476(ra) # 80004aec <panic>
    80005918:	01053903          	ld	s2,16(a0)
    8000591c:	00050493          	mv	s1,a0
    80005920:	fffff097          	auipc	ra,0xfffff
    80005924:	808080e7          	jalr	-2040(ra) # 80004128 <mycpu>
    80005928:	fea910e3          	bne	s2,a0,80005908 <release+0x20>
    8000592c:	0004b823          	sd	zero,16(s1)
    80005930:	0ff0000f          	fence
    80005934:	0f50000f          	fence	iorw,ow
    80005938:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000593c:	ffffe097          	auipc	ra,0xffffe
    80005940:	7ec080e7          	jalr	2028(ra) # 80004128 <mycpu>
    80005944:	100027f3          	csrr	a5,sstatus
    80005948:	0027f793          	andi	a5,a5,2
    8000594c:	04079a63          	bnez	a5,800059a0 <release+0xb8>
    80005950:	07852783          	lw	a5,120(a0)
    80005954:	02f05e63          	blez	a5,80005990 <release+0xa8>
    80005958:	fff7871b          	addiw	a4,a5,-1
    8000595c:	06e52c23          	sw	a4,120(a0)
    80005960:	00071c63          	bnez	a4,80005978 <release+0x90>
    80005964:	07c52783          	lw	a5,124(a0)
    80005968:	00078863          	beqz	a5,80005978 <release+0x90>
    8000596c:	100027f3          	csrr	a5,sstatus
    80005970:	0027e793          	ori	a5,a5,2
    80005974:	10079073          	csrw	sstatus,a5
    80005978:	01813083          	ld	ra,24(sp)
    8000597c:	01013403          	ld	s0,16(sp)
    80005980:	00813483          	ld	s1,8(sp)
    80005984:	00013903          	ld	s2,0(sp)
    80005988:	02010113          	addi	sp,sp,32
    8000598c:	00008067          	ret
    80005990:	00001517          	auipc	a0,0x1
    80005994:	9f850513          	addi	a0,a0,-1544 # 80006388 <digits+0x48>
    80005998:	fffff097          	auipc	ra,0xfffff
    8000599c:	154080e7          	jalr	340(ra) # 80004aec <panic>
    800059a0:	00001517          	auipc	a0,0x1
    800059a4:	9d050513          	addi	a0,a0,-1584 # 80006370 <digits+0x30>
    800059a8:	fffff097          	auipc	ra,0xfffff
    800059ac:	144080e7          	jalr	324(ra) # 80004aec <panic>

00000000800059b0 <holding>:
    800059b0:	00052783          	lw	a5,0(a0)
    800059b4:	00079663          	bnez	a5,800059c0 <holding+0x10>
    800059b8:	00000513          	li	a0,0
    800059bc:	00008067          	ret
    800059c0:	fe010113          	addi	sp,sp,-32
    800059c4:	00813823          	sd	s0,16(sp)
    800059c8:	00913423          	sd	s1,8(sp)
    800059cc:	00113c23          	sd	ra,24(sp)
    800059d0:	02010413          	addi	s0,sp,32
    800059d4:	01053483          	ld	s1,16(a0)
    800059d8:	ffffe097          	auipc	ra,0xffffe
    800059dc:	750080e7          	jalr	1872(ra) # 80004128 <mycpu>
    800059e0:	01813083          	ld	ra,24(sp)
    800059e4:	01013403          	ld	s0,16(sp)
    800059e8:	40a48533          	sub	a0,s1,a0
    800059ec:	00153513          	seqz	a0,a0
    800059f0:	00813483          	ld	s1,8(sp)
    800059f4:	02010113          	addi	sp,sp,32
    800059f8:	00008067          	ret

00000000800059fc <push_off>:
    800059fc:	fe010113          	addi	sp,sp,-32
    80005a00:	00813823          	sd	s0,16(sp)
    80005a04:	00113c23          	sd	ra,24(sp)
    80005a08:	00913423          	sd	s1,8(sp)
    80005a0c:	02010413          	addi	s0,sp,32
    80005a10:	100024f3          	csrr	s1,sstatus
    80005a14:	100027f3          	csrr	a5,sstatus
    80005a18:	ffd7f793          	andi	a5,a5,-3
    80005a1c:	10079073          	csrw	sstatus,a5
    80005a20:	ffffe097          	auipc	ra,0xffffe
    80005a24:	708080e7          	jalr	1800(ra) # 80004128 <mycpu>
    80005a28:	07852783          	lw	a5,120(a0)
    80005a2c:	02078663          	beqz	a5,80005a58 <push_off+0x5c>
    80005a30:	ffffe097          	auipc	ra,0xffffe
    80005a34:	6f8080e7          	jalr	1784(ra) # 80004128 <mycpu>
    80005a38:	07852783          	lw	a5,120(a0)
    80005a3c:	01813083          	ld	ra,24(sp)
    80005a40:	01013403          	ld	s0,16(sp)
    80005a44:	0017879b          	addiw	a5,a5,1
    80005a48:	06f52c23          	sw	a5,120(a0)
    80005a4c:	00813483          	ld	s1,8(sp)
    80005a50:	02010113          	addi	sp,sp,32
    80005a54:	00008067          	ret
    80005a58:	0014d493          	srli	s1,s1,0x1
    80005a5c:	ffffe097          	auipc	ra,0xffffe
    80005a60:	6cc080e7          	jalr	1740(ra) # 80004128 <mycpu>
    80005a64:	0014f493          	andi	s1,s1,1
    80005a68:	06952e23          	sw	s1,124(a0)
    80005a6c:	fc5ff06f          	j	80005a30 <push_off+0x34>

0000000080005a70 <pop_off>:
    80005a70:	ff010113          	addi	sp,sp,-16
    80005a74:	00813023          	sd	s0,0(sp)
    80005a78:	00113423          	sd	ra,8(sp)
    80005a7c:	01010413          	addi	s0,sp,16
    80005a80:	ffffe097          	auipc	ra,0xffffe
    80005a84:	6a8080e7          	jalr	1704(ra) # 80004128 <mycpu>
    80005a88:	100027f3          	csrr	a5,sstatus
    80005a8c:	0027f793          	andi	a5,a5,2
    80005a90:	04079663          	bnez	a5,80005adc <pop_off+0x6c>
    80005a94:	07852783          	lw	a5,120(a0)
    80005a98:	02f05a63          	blez	a5,80005acc <pop_off+0x5c>
    80005a9c:	fff7871b          	addiw	a4,a5,-1
    80005aa0:	06e52c23          	sw	a4,120(a0)
    80005aa4:	00071c63          	bnez	a4,80005abc <pop_off+0x4c>
    80005aa8:	07c52783          	lw	a5,124(a0)
    80005aac:	00078863          	beqz	a5,80005abc <pop_off+0x4c>
    80005ab0:	100027f3          	csrr	a5,sstatus
    80005ab4:	0027e793          	ori	a5,a5,2
    80005ab8:	10079073          	csrw	sstatus,a5
    80005abc:	00813083          	ld	ra,8(sp)
    80005ac0:	00013403          	ld	s0,0(sp)
    80005ac4:	01010113          	addi	sp,sp,16
    80005ac8:	00008067          	ret
    80005acc:	00001517          	auipc	a0,0x1
    80005ad0:	8bc50513          	addi	a0,a0,-1860 # 80006388 <digits+0x48>
    80005ad4:	fffff097          	auipc	ra,0xfffff
    80005ad8:	018080e7          	jalr	24(ra) # 80004aec <panic>
    80005adc:	00001517          	auipc	a0,0x1
    80005ae0:	89450513          	addi	a0,a0,-1900 # 80006370 <digits+0x30>
    80005ae4:	fffff097          	auipc	ra,0xfffff
    80005ae8:	008080e7          	jalr	8(ra) # 80004aec <panic>

0000000080005aec <push_on>:
    80005aec:	fe010113          	addi	sp,sp,-32
    80005af0:	00813823          	sd	s0,16(sp)
    80005af4:	00113c23          	sd	ra,24(sp)
    80005af8:	00913423          	sd	s1,8(sp)
    80005afc:	02010413          	addi	s0,sp,32
    80005b00:	100024f3          	csrr	s1,sstatus
    80005b04:	100027f3          	csrr	a5,sstatus
    80005b08:	0027e793          	ori	a5,a5,2
    80005b0c:	10079073          	csrw	sstatus,a5
    80005b10:	ffffe097          	auipc	ra,0xffffe
    80005b14:	618080e7          	jalr	1560(ra) # 80004128 <mycpu>
    80005b18:	07852783          	lw	a5,120(a0)
    80005b1c:	02078663          	beqz	a5,80005b48 <push_on+0x5c>
    80005b20:	ffffe097          	auipc	ra,0xffffe
    80005b24:	608080e7          	jalr	1544(ra) # 80004128 <mycpu>
    80005b28:	07852783          	lw	a5,120(a0)
    80005b2c:	01813083          	ld	ra,24(sp)
    80005b30:	01013403          	ld	s0,16(sp)
    80005b34:	0017879b          	addiw	a5,a5,1
    80005b38:	06f52c23          	sw	a5,120(a0)
    80005b3c:	00813483          	ld	s1,8(sp)
    80005b40:	02010113          	addi	sp,sp,32
    80005b44:	00008067          	ret
    80005b48:	0014d493          	srli	s1,s1,0x1
    80005b4c:	ffffe097          	auipc	ra,0xffffe
    80005b50:	5dc080e7          	jalr	1500(ra) # 80004128 <mycpu>
    80005b54:	0014f493          	andi	s1,s1,1
    80005b58:	06952e23          	sw	s1,124(a0)
    80005b5c:	fc5ff06f          	j	80005b20 <push_on+0x34>

0000000080005b60 <pop_on>:
    80005b60:	ff010113          	addi	sp,sp,-16
    80005b64:	00813023          	sd	s0,0(sp)
    80005b68:	00113423          	sd	ra,8(sp)
    80005b6c:	01010413          	addi	s0,sp,16
    80005b70:	ffffe097          	auipc	ra,0xffffe
    80005b74:	5b8080e7          	jalr	1464(ra) # 80004128 <mycpu>
    80005b78:	100027f3          	csrr	a5,sstatus
    80005b7c:	0027f793          	andi	a5,a5,2
    80005b80:	04078463          	beqz	a5,80005bc8 <pop_on+0x68>
    80005b84:	07852783          	lw	a5,120(a0)
    80005b88:	02f05863          	blez	a5,80005bb8 <pop_on+0x58>
    80005b8c:	fff7879b          	addiw	a5,a5,-1
    80005b90:	06f52c23          	sw	a5,120(a0)
    80005b94:	07853783          	ld	a5,120(a0)
    80005b98:	00079863          	bnez	a5,80005ba8 <pop_on+0x48>
    80005b9c:	100027f3          	csrr	a5,sstatus
    80005ba0:	ffd7f793          	andi	a5,a5,-3
    80005ba4:	10079073          	csrw	sstatus,a5
    80005ba8:	00813083          	ld	ra,8(sp)
    80005bac:	00013403          	ld	s0,0(sp)
    80005bb0:	01010113          	addi	sp,sp,16
    80005bb4:	00008067          	ret
    80005bb8:	00000517          	auipc	a0,0x0
    80005bbc:	7f850513          	addi	a0,a0,2040 # 800063b0 <digits+0x70>
    80005bc0:	fffff097          	auipc	ra,0xfffff
    80005bc4:	f2c080e7          	jalr	-212(ra) # 80004aec <panic>
    80005bc8:	00000517          	auipc	a0,0x0
    80005bcc:	7c850513          	addi	a0,a0,1992 # 80006390 <digits+0x50>
    80005bd0:	fffff097          	auipc	ra,0xfffff
    80005bd4:	f1c080e7          	jalr	-228(ra) # 80004aec <panic>

0000000080005bd8 <__memset>:
    80005bd8:	ff010113          	addi	sp,sp,-16
    80005bdc:	00813423          	sd	s0,8(sp)
    80005be0:	01010413          	addi	s0,sp,16
    80005be4:	1a060e63          	beqz	a2,80005da0 <__memset+0x1c8>
    80005be8:	40a007b3          	neg	a5,a0
    80005bec:	0077f793          	andi	a5,a5,7
    80005bf0:	00778693          	addi	a3,a5,7
    80005bf4:	00b00813          	li	a6,11
    80005bf8:	0ff5f593          	andi	a1,a1,255
    80005bfc:	fff6071b          	addiw	a4,a2,-1
    80005c00:	1b06e663          	bltu	a3,a6,80005dac <__memset+0x1d4>
    80005c04:	1cd76463          	bltu	a4,a3,80005dcc <__memset+0x1f4>
    80005c08:	1a078e63          	beqz	a5,80005dc4 <__memset+0x1ec>
    80005c0c:	00b50023          	sb	a1,0(a0)
    80005c10:	00100713          	li	a4,1
    80005c14:	1ae78463          	beq	a5,a4,80005dbc <__memset+0x1e4>
    80005c18:	00b500a3          	sb	a1,1(a0)
    80005c1c:	00200713          	li	a4,2
    80005c20:	1ae78a63          	beq	a5,a4,80005dd4 <__memset+0x1fc>
    80005c24:	00b50123          	sb	a1,2(a0)
    80005c28:	00300713          	li	a4,3
    80005c2c:	18e78463          	beq	a5,a4,80005db4 <__memset+0x1dc>
    80005c30:	00b501a3          	sb	a1,3(a0)
    80005c34:	00400713          	li	a4,4
    80005c38:	1ae78263          	beq	a5,a4,80005ddc <__memset+0x204>
    80005c3c:	00b50223          	sb	a1,4(a0)
    80005c40:	00500713          	li	a4,5
    80005c44:	1ae78063          	beq	a5,a4,80005de4 <__memset+0x20c>
    80005c48:	00b502a3          	sb	a1,5(a0)
    80005c4c:	00700713          	li	a4,7
    80005c50:	18e79e63          	bne	a5,a4,80005dec <__memset+0x214>
    80005c54:	00b50323          	sb	a1,6(a0)
    80005c58:	00700e93          	li	t4,7
    80005c5c:	00859713          	slli	a4,a1,0x8
    80005c60:	00e5e733          	or	a4,a1,a4
    80005c64:	01059e13          	slli	t3,a1,0x10
    80005c68:	01c76e33          	or	t3,a4,t3
    80005c6c:	01859313          	slli	t1,a1,0x18
    80005c70:	006e6333          	or	t1,t3,t1
    80005c74:	02059893          	slli	a7,a1,0x20
    80005c78:	40f60e3b          	subw	t3,a2,a5
    80005c7c:	011368b3          	or	a7,t1,a7
    80005c80:	02859813          	slli	a6,a1,0x28
    80005c84:	0108e833          	or	a6,a7,a6
    80005c88:	03059693          	slli	a3,a1,0x30
    80005c8c:	003e589b          	srliw	a7,t3,0x3
    80005c90:	00d866b3          	or	a3,a6,a3
    80005c94:	03859713          	slli	a4,a1,0x38
    80005c98:	00389813          	slli	a6,a7,0x3
    80005c9c:	00f507b3          	add	a5,a0,a5
    80005ca0:	00e6e733          	or	a4,a3,a4
    80005ca4:	000e089b          	sext.w	a7,t3
    80005ca8:	00f806b3          	add	a3,a6,a5
    80005cac:	00e7b023          	sd	a4,0(a5)
    80005cb0:	00878793          	addi	a5,a5,8
    80005cb4:	fed79ce3          	bne	a5,a3,80005cac <__memset+0xd4>
    80005cb8:	ff8e7793          	andi	a5,t3,-8
    80005cbc:	0007871b          	sext.w	a4,a5
    80005cc0:	01d787bb          	addw	a5,a5,t4
    80005cc4:	0ce88e63          	beq	a7,a4,80005da0 <__memset+0x1c8>
    80005cc8:	00f50733          	add	a4,a0,a5
    80005ccc:	00b70023          	sb	a1,0(a4)
    80005cd0:	0017871b          	addiw	a4,a5,1
    80005cd4:	0cc77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005cd8:	00e50733          	add	a4,a0,a4
    80005cdc:	00b70023          	sb	a1,0(a4)
    80005ce0:	0027871b          	addiw	a4,a5,2
    80005ce4:	0ac77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005ce8:	00e50733          	add	a4,a0,a4
    80005cec:	00b70023          	sb	a1,0(a4)
    80005cf0:	0037871b          	addiw	a4,a5,3
    80005cf4:	0ac77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005cf8:	00e50733          	add	a4,a0,a4
    80005cfc:	00b70023          	sb	a1,0(a4)
    80005d00:	0047871b          	addiw	a4,a5,4
    80005d04:	08c77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d08:	00e50733          	add	a4,a0,a4
    80005d0c:	00b70023          	sb	a1,0(a4)
    80005d10:	0057871b          	addiw	a4,a5,5
    80005d14:	08c77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d18:	00e50733          	add	a4,a0,a4
    80005d1c:	00b70023          	sb	a1,0(a4)
    80005d20:	0067871b          	addiw	a4,a5,6
    80005d24:	06c77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d28:	00e50733          	add	a4,a0,a4
    80005d2c:	00b70023          	sb	a1,0(a4)
    80005d30:	0077871b          	addiw	a4,a5,7
    80005d34:	06c77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d38:	00e50733          	add	a4,a0,a4
    80005d3c:	00b70023          	sb	a1,0(a4)
    80005d40:	0087871b          	addiw	a4,a5,8
    80005d44:	04c77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d48:	00e50733          	add	a4,a0,a4
    80005d4c:	00b70023          	sb	a1,0(a4)
    80005d50:	0097871b          	addiw	a4,a5,9
    80005d54:	04c77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d58:	00e50733          	add	a4,a0,a4
    80005d5c:	00b70023          	sb	a1,0(a4)
    80005d60:	00a7871b          	addiw	a4,a5,10
    80005d64:	02c77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d68:	00e50733          	add	a4,a0,a4
    80005d6c:	00b70023          	sb	a1,0(a4)
    80005d70:	00b7871b          	addiw	a4,a5,11
    80005d74:	02c77663          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d78:	00e50733          	add	a4,a0,a4
    80005d7c:	00b70023          	sb	a1,0(a4)
    80005d80:	00c7871b          	addiw	a4,a5,12
    80005d84:	00c77e63          	bgeu	a4,a2,80005da0 <__memset+0x1c8>
    80005d88:	00e50733          	add	a4,a0,a4
    80005d8c:	00b70023          	sb	a1,0(a4)
    80005d90:	00d7879b          	addiw	a5,a5,13
    80005d94:	00c7f663          	bgeu	a5,a2,80005da0 <__memset+0x1c8>
    80005d98:	00f507b3          	add	a5,a0,a5
    80005d9c:	00b78023          	sb	a1,0(a5)
    80005da0:	00813403          	ld	s0,8(sp)
    80005da4:	01010113          	addi	sp,sp,16
    80005da8:	00008067          	ret
    80005dac:	00b00693          	li	a3,11
    80005db0:	e55ff06f          	j	80005c04 <__memset+0x2c>
    80005db4:	00300e93          	li	t4,3
    80005db8:	ea5ff06f          	j	80005c5c <__memset+0x84>
    80005dbc:	00100e93          	li	t4,1
    80005dc0:	e9dff06f          	j	80005c5c <__memset+0x84>
    80005dc4:	00000e93          	li	t4,0
    80005dc8:	e95ff06f          	j	80005c5c <__memset+0x84>
    80005dcc:	00000793          	li	a5,0
    80005dd0:	ef9ff06f          	j	80005cc8 <__memset+0xf0>
    80005dd4:	00200e93          	li	t4,2
    80005dd8:	e85ff06f          	j	80005c5c <__memset+0x84>
    80005ddc:	00400e93          	li	t4,4
    80005de0:	e7dff06f          	j	80005c5c <__memset+0x84>
    80005de4:	00500e93          	li	t4,5
    80005de8:	e75ff06f          	j	80005c5c <__memset+0x84>
    80005dec:	00600e93          	li	t4,6
    80005df0:	e6dff06f          	j	80005c5c <__memset+0x84>

0000000080005df4 <__memmove>:
    80005df4:	ff010113          	addi	sp,sp,-16
    80005df8:	00813423          	sd	s0,8(sp)
    80005dfc:	01010413          	addi	s0,sp,16
    80005e00:	0e060863          	beqz	a2,80005ef0 <__memmove+0xfc>
    80005e04:	fff6069b          	addiw	a3,a2,-1
    80005e08:	0006881b          	sext.w	a6,a3
    80005e0c:	0ea5e863          	bltu	a1,a0,80005efc <__memmove+0x108>
    80005e10:	00758713          	addi	a4,a1,7
    80005e14:	00a5e7b3          	or	a5,a1,a0
    80005e18:	40a70733          	sub	a4,a4,a0
    80005e1c:	0077f793          	andi	a5,a5,7
    80005e20:	00f73713          	sltiu	a4,a4,15
    80005e24:	00174713          	xori	a4,a4,1
    80005e28:	0017b793          	seqz	a5,a5
    80005e2c:	00e7f7b3          	and	a5,a5,a4
    80005e30:	10078863          	beqz	a5,80005f40 <__memmove+0x14c>
    80005e34:	00900793          	li	a5,9
    80005e38:	1107f463          	bgeu	a5,a6,80005f40 <__memmove+0x14c>
    80005e3c:	0036581b          	srliw	a6,a2,0x3
    80005e40:	fff8081b          	addiw	a6,a6,-1
    80005e44:	02081813          	slli	a6,a6,0x20
    80005e48:	01d85893          	srli	a7,a6,0x1d
    80005e4c:	00858813          	addi	a6,a1,8
    80005e50:	00058793          	mv	a5,a1
    80005e54:	00050713          	mv	a4,a0
    80005e58:	01088833          	add	a6,a7,a6
    80005e5c:	0007b883          	ld	a7,0(a5)
    80005e60:	00878793          	addi	a5,a5,8
    80005e64:	00870713          	addi	a4,a4,8
    80005e68:	ff173c23          	sd	a7,-8(a4)
    80005e6c:	ff0798e3          	bne	a5,a6,80005e5c <__memmove+0x68>
    80005e70:	ff867713          	andi	a4,a2,-8
    80005e74:	02071793          	slli	a5,a4,0x20
    80005e78:	0207d793          	srli	a5,a5,0x20
    80005e7c:	00f585b3          	add	a1,a1,a5
    80005e80:	40e686bb          	subw	a3,a3,a4
    80005e84:	00f507b3          	add	a5,a0,a5
    80005e88:	06e60463          	beq	a2,a4,80005ef0 <__memmove+0xfc>
    80005e8c:	0005c703          	lbu	a4,0(a1)
    80005e90:	00e78023          	sb	a4,0(a5)
    80005e94:	04068e63          	beqz	a3,80005ef0 <__memmove+0xfc>
    80005e98:	0015c603          	lbu	a2,1(a1)
    80005e9c:	00100713          	li	a4,1
    80005ea0:	00c780a3          	sb	a2,1(a5)
    80005ea4:	04e68663          	beq	a3,a4,80005ef0 <__memmove+0xfc>
    80005ea8:	0025c603          	lbu	a2,2(a1)
    80005eac:	00200713          	li	a4,2
    80005eb0:	00c78123          	sb	a2,2(a5)
    80005eb4:	02e68e63          	beq	a3,a4,80005ef0 <__memmove+0xfc>
    80005eb8:	0035c603          	lbu	a2,3(a1)
    80005ebc:	00300713          	li	a4,3
    80005ec0:	00c781a3          	sb	a2,3(a5)
    80005ec4:	02e68663          	beq	a3,a4,80005ef0 <__memmove+0xfc>
    80005ec8:	0045c603          	lbu	a2,4(a1)
    80005ecc:	00400713          	li	a4,4
    80005ed0:	00c78223          	sb	a2,4(a5)
    80005ed4:	00e68e63          	beq	a3,a4,80005ef0 <__memmove+0xfc>
    80005ed8:	0055c603          	lbu	a2,5(a1)
    80005edc:	00500713          	li	a4,5
    80005ee0:	00c782a3          	sb	a2,5(a5)
    80005ee4:	00e68663          	beq	a3,a4,80005ef0 <__memmove+0xfc>
    80005ee8:	0065c703          	lbu	a4,6(a1)
    80005eec:	00e78323          	sb	a4,6(a5)
    80005ef0:	00813403          	ld	s0,8(sp)
    80005ef4:	01010113          	addi	sp,sp,16
    80005ef8:	00008067          	ret
    80005efc:	02061713          	slli	a4,a2,0x20
    80005f00:	02075713          	srli	a4,a4,0x20
    80005f04:	00e587b3          	add	a5,a1,a4
    80005f08:	f0f574e3          	bgeu	a0,a5,80005e10 <__memmove+0x1c>
    80005f0c:	02069613          	slli	a2,a3,0x20
    80005f10:	02065613          	srli	a2,a2,0x20
    80005f14:	fff64613          	not	a2,a2
    80005f18:	00e50733          	add	a4,a0,a4
    80005f1c:	00c78633          	add	a2,a5,a2
    80005f20:	fff7c683          	lbu	a3,-1(a5)
    80005f24:	fff78793          	addi	a5,a5,-1
    80005f28:	fff70713          	addi	a4,a4,-1
    80005f2c:	00d70023          	sb	a3,0(a4)
    80005f30:	fec798e3          	bne	a5,a2,80005f20 <__memmove+0x12c>
    80005f34:	00813403          	ld	s0,8(sp)
    80005f38:	01010113          	addi	sp,sp,16
    80005f3c:	00008067          	ret
    80005f40:	02069713          	slli	a4,a3,0x20
    80005f44:	02075713          	srli	a4,a4,0x20
    80005f48:	00170713          	addi	a4,a4,1
    80005f4c:	00e50733          	add	a4,a0,a4
    80005f50:	00050793          	mv	a5,a0
    80005f54:	0005c683          	lbu	a3,0(a1)
    80005f58:	00178793          	addi	a5,a5,1
    80005f5c:	00158593          	addi	a1,a1,1
    80005f60:	fed78fa3          	sb	a3,-1(a5)
    80005f64:	fee798e3          	bne	a5,a4,80005f54 <__memmove+0x160>
    80005f68:	f89ff06f          	j	80005ef0 <__memmove+0xfc>
	...
