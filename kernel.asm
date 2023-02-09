
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	ea013103          	ld	sp,-352(sp) # 80008ea0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	219040ef          	jal	ra,80004a34 <start>

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
    8000100c:	415000ef          	jal	ra,80001c20 <_ZN3PCB10getContextEv>
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
    800010a0:	381000ef          	jal	ra,80001c20 <_ZN3PCB10getContextEv>

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
    80001538:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000153c:	142027f3          	csrr	a5,scause
    80001540:	fcf43023          	sd	a5,-64(s0)
        return scause;
    80001544:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001548:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000154c:	141027f3          	csrr	a5,sepc
    80001550:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    80001554:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80001558:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000155c:	100027f3          	csrr	a5,sstatus
    80001560:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    80001564:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001568:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    8000156c:	fd843703          	ld	a4,-40(s0)
    80001570:	00900793          	li	a5,9
    80001574:	04f70663          	beq	a4,a5,800015c0 <interruptHandler+0x98>
    80001578:	fd843703          	ld	a4,-40(s0)
    8000157c:	00800793          	li	a5,8
    80001580:	04f70063          	beq	a4,a5,800015c0 <interruptHandler+0x98>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    80001584:	fd843703          	ld	a4,-40(s0)
    80001588:	fff00793          	li	a5,-1
    8000158c:	03f79793          	slli	a5,a5,0x3f
    80001590:	00178793          	addi	a5,a5,1
    80001594:	30f70063          	beq	a4,a5,80001894 <interruptHandler+0x36c>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    80001598:	fd843703          	ld	a4,-40(s0)
    8000159c:	fff00793          	li	a5,-1
    800015a0:	03f79793          	slli	a5,a5,0x3f
    800015a4:	00978793          	addi	a5,a5,9
    800015a8:	34f70663          	beq	a4,a5,800018f4 <interruptHandler+0x3cc>

    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
    }

}
    800015ac:	05813083          	ld	ra,88(sp)
    800015b0:	05013403          	ld	s0,80(sp)
    800015b4:	04813483          	ld	s1,72(sp)
    800015b8:	06010113          	addi	sp,sp,96
    800015bc:	00008067          	ret
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015c0:	fd043783          	ld	a5,-48(s0)
    800015c4:	00478793          	addi	a5,a5,4
    800015c8:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015cc:	00008797          	auipc	a5,0x8
    800015d0:	8f47b783          	ld	a5,-1804(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800015d4:	0007b503          	ld	a0,0(a5)
    800015d8:	01853703          	ld	a4,24(a0)
    800015dc:	05073783          	ld	a5,80(a4)
    800015e0:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015e4:	fa843783          	ld	a5,-88(s0)
    800015e8:	04300693          	li	a3,67
    800015ec:	04f6e263          	bltu	a3,a5,80001630 <interruptHandler+0x108>
    800015f0:	00279793          	slli	a5,a5,0x2
    800015f4:	00006697          	auipc	a3,0x6
    800015f8:	a2c68693          	addi	a3,a3,-1492 # 80007020 <CONSOLE_STATUS+0x10>
    800015fc:	00d787b3          	add	a5,a5,a3
    80001600:	0007a783          	lw	a5,0(a5)
    80001604:	00d787b3          	add	a5,a5,a3
    80001608:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    8000160c:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001610:	00651513          	slli	a0,a0,0x6
    80001614:	00003097          	auipc	ra,0x3
    80001618:	8a4080e7          	jalr	-1884(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
    8000161c:	00008797          	auipc	a5,0x8
    80001620:	8a47b783          	ld	a5,-1884(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001624:	0007b783          	ld	a5,0(a5)
    80001628:	0187b783          	ld	a5,24(a5)
    8000162c:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001630:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001634:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001638:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000163c:	10079073          	csrw	sstatus,a5
        return;
    80001640:	f6dff06f          	j	800015ac <interruptHandler+0x84>
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001644:	05873503          	ld	a0,88(a4)
    80001648:	00003097          	auipc	ra,0x3
    8000164c:	9e0080e7          	jalr	-1568(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
    80001650:	00008797          	auipc	a5,0x8
    80001654:	8707b783          	ld	a5,-1936(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001658:	0007b783          	ld	a5,0(a5)
    8000165c:	0187b783          	ld	a5,24(a5)
    80001660:	04a7b823          	sd	a0,80(a5)
                break;
    80001664:	fcdff06f          	j	80001630 <interruptHandler+0x108>
                PCB::timeSliceCounter = 0;
    80001668:	00008797          	auipc	a5,0x8
    8000166c:	8307b783          	ld	a5,-2000(a5) # 80008e98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001670:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001674:	00000097          	auipc	ra,0x0
    80001678:	480080e7          	jalr	1152(ra) # 80001af4 <_ZN3PCB8dispatchEv>
                break;
    8000167c:	fb5ff06f          	j	80001630 <interruptHandler+0x108>
                PCB::running->finished = true;
    80001680:	00100793          	li	a5,1
    80001684:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001688:	00008797          	auipc	a5,0x8
    8000168c:	8107b783          	ld	a5,-2032(a5) # 80008e98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001690:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001694:	00000097          	auipc	ra,0x0
    80001698:	460080e7          	jalr	1120(ra) # 80001af4 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    8000169c:	00008797          	auipc	a5,0x8
    800016a0:	8247b783          	ld	a5,-2012(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800016a4:	0007b783          	ld	a5,0(a5)
    800016a8:	0187b783          	ld	a5,24(a5)
    800016ac:	0407b823          	sd	zero,80(a5)
                break;
    800016b0:	f81ff06f          	j	80001630 <interruptHandler+0x108>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800016b4:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800016b8:	0007b503          	ld	a0,0(a5)
    800016bc:	00001097          	auipc	ra,0x1
    800016c0:	34c080e7          	jalr	844(ra) # 80002a08 <_ZN9Scheduler3putEP3PCB>
                break;
    800016c4:	f6dff06f          	j	80001630 <interruptHandler+0x108>
                PCB::processMain main = (PCB::processMain)PCB::running->registers[12];
    800016c8:	06073503          	ld	a0,96(a4)
                void *arg = (void*)PCB::running->registers[13];
    800016cc:	06873583          	ld	a1,104(a4)
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d0:	05873483          	ld	s1,88(a4)
                if(scause == 9) { // sistemski rezim
    800016d4:	fd843703          	ld	a4,-40(s0)
    800016d8:	00900793          	li	a5,9
    800016dc:	04f70863          	beq	a4,a5,8000172c <interruptHandler+0x204>
                    *handle = PCB::createProccess(main, arg);
    800016e0:	00000097          	auipc	ra,0x0
    800016e4:	638080e7          	jalr	1592(ra) # 80001d18 <_ZN3PCB14createProccessEPFvvEPv>
    800016e8:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016ec:	00007797          	auipc	a5,0x7
    800016f0:	7d47b783          	ld	a5,2004(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800016f4:	0007b783          	ld	a5,0(a5)
    800016f8:	0187b703          	ld	a4,24(a5)
    800016fc:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001700:	0004b703          	ld	a4,0(s1)
    80001704:	f20706e3          	beqz	a4,80001630 <interruptHandler+0x108>
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001708:	0187b783          	ld	a5,24(a5)
    8000170c:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001710:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001714:	00008737          	lui	a4,0x8
    80001718:	00e787b3          	add	a5,a5,a4
    8000171c:	0004b703          	ld	a4,0(s1)
    80001720:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001724:	00f73823          	sd	a5,16(a4)
                break;
    80001728:	f09ff06f          	j	80001630 <interruptHandler+0x108>
                    *handle = PCB::createSysProcess(main, arg);
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	6c0080e7          	jalr	1728(ra) # 80001dec <_ZN3PCB16createSysProcessEPFvvEPv>
    80001734:	00a4b023          	sd	a0,0(s1)
    80001738:	fb5ff06f          	j	800016ec <interruptHandler+0x1c4>
                SCB **handle = (SCB**) PCB::running->registers[11];
    8000173c:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001740:	06072503          	lw	a0,96(a4)
                if(scause == 9) { // sistemski rezim
    80001744:	fd843703          	ld	a4,-40(s0)
    80001748:	00900793          	li	a5,9
    8000174c:	02f70463          	beq	a4,a5,80001774 <interruptHandler+0x24c>
                    (*handle) = SCB::createSemaphore(init);
    80001750:	00002097          	auipc	ra,0x2
    80001754:	e90080e7          	jalr	-368(ra) # 800035e0 <_ZN3SCB15createSemaphoreEi>
    80001758:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    8000175c:	00007797          	auipc	a5,0x7
    80001760:	7647b783          	ld	a5,1892(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001764:	0007b783          	ld	a5,0(a5)
    80001768:	0187b783          	ld	a5,24(a5)
    8000176c:	0497b823          	sd	s1,80(a5)
                break;
    80001770:	ec1ff06f          	j	80001630 <interruptHandler+0x108>
                    (*handle) = SCB::createSysSemaphore(init);
    80001774:	00002097          	auipc	ra,0x2
    80001778:	f20080e7          	jalr	-224(ra) # 80003694 <_ZN3SCB18createSysSemaphoreEi>
    8000177c:	00a4b023          	sd	a0,0(s1)
    80001780:	fddff06f          	j	8000175c <interruptHandler+0x234>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001784:	05873503          	ld	a0,88(a4)
    80001788:	00002097          	auipc	ra,0x2
    8000178c:	c80080e7          	jalr	-896(ra) # 80003408 <_ZN3SCB4waitEv>
    80001790:	00007797          	auipc	a5,0x7
    80001794:	7307b783          	ld	a5,1840(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001798:	0007b783          	ld	a5,0(a5)
    8000179c:	0187b783          	ld	a5,24(a5)
    800017a0:	04a7b823          	sd	a0,80(a5)
                break;
    800017a4:	e8dff06f          	j	80001630 <interruptHandler+0x108>
                sem->signal();
    800017a8:	05873503          	ld	a0,88(a4)
    800017ac:	00002097          	auipc	ra,0x2
    800017b0:	cf0080e7          	jalr	-784(ra) # 8000349c <_ZN3SCB6signalEv>
                break;
    800017b4:	e7dff06f          	j	80001630 <interruptHandler+0x108>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017b8:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017bc:	00048513          	mv	a0,s1
    800017c0:	00002097          	auipc	ra,0x2
    800017c4:	dbc080e7          	jalr	-580(ra) # 8000357c <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017c8:	e60484e3          	beqz	s1,80001630 <interruptHandler+0x108>
    800017cc:	00048513          	mv	a0,s1
    800017d0:	00002097          	auipc	ra,0x2
    800017d4:	d84080e7          	jalr	-636(ra) # 80003554 <_ZN3SCBdlEPv>
    800017d8:	e59ff06f          	j	80001630 <interruptHandler+0x108>
                size_t time = (size_t)PCB::running->registers[11];
    800017dc:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017e0:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017e4:	00000097          	auipc	ra,0x0
    800017e8:	124080e7          	jalr	292(ra) # 80001908 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017ec:	e45ff06f          	j	80001630 <interruptHandler+0x108>
                CCB::outputBuffer.pushBack(character);
    800017f0:	05874583          	lbu	a1,88(a4)
    800017f4:	00007517          	auipc	a0,0x7
    800017f8:	68c53503          	ld	a0,1676(a0) # 80008e80 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017fc:	00001097          	auipc	ra,0x1
    80001800:	b58080e7          	jalr	-1192(ra) # 80002354 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    80001804:	00007797          	auipc	a5,0x7
    80001808:	6cc7b783          	ld	a5,1740(a5) # 80008ed0 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00002097          	auipc	ra,0x2
    80001814:	c8c080e7          	jalr	-884(ra) # 8000349c <_ZN3SCB6signalEv>
                break;
    80001818:	e19ff06f          	j	80001630 <interruptHandler+0x108>
                CCB::semInput->signal();
    8000181c:	00007797          	auipc	a5,0x7
    80001820:	6d47b783          	ld	a5,1748(a5) # 80008ef0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80001824:	0007b503          	ld	a0,0(a5)
    80001828:	00002097          	auipc	ra,0x2
    8000182c:	c74080e7          	jalr	-908(ra) # 8000349c <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001830:	00007517          	auipc	a0,0x7
    80001834:	65853503          	ld	a0,1624(a0) # 80008e88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001838:	00001097          	auipc	ra,0x1
    8000183c:	ca4080e7          	jalr	-860(ra) # 800024dc <_ZN8IOBuffer9peekFrontEv>
    80001840:	00051e63          	bnez	a0,8000185c <interruptHandler+0x334>
                    CCB::inputBufferEmpty->wait();
    80001844:	00007797          	auipc	a5,0x7
    80001848:	69c7b783          	ld	a5,1692(a5) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000184c:	0007b503          	ld	a0,0(a5)
    80001850:	00002097          	auipc	ra,0x2
    80001854:	bb8080e7          	jalr	-1096(ra) # 80003408 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001858:	fd9ff06f          	j	80001830 <interruptHandler+0x308>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000185c:	00007517          	auipc	a0,0x7
    80001860:	62c53503          	ld	a0,1580(a0) # 80008e88 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001864:	00001097          	auipc	ra,0x1
    80001868:	be8080e7          	jalr	-1048(ra) # 8000244c <_ZN8IOBuffer8popFrontEv>
    8000186c:	00007797          	auipc	a5,0x7
    80001870:	6547b783          	ld	a5,1620(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001874:	0007b783          	ld	a5,0(a5)
    80001878:	0187b783          	ld	a5,24(a5)
    8000187c:	04a7b823          	sd	a0,80(a5)
                break;
    80001880:	db1ff06f          	j	80001630 <interruptHandler+0x108>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    80001884:	fc843783          	ld	a5,-56(s0)
    80001888:	eff7f793          	andi	a5,a5,-257
    8000188c:	fcf43423          	sd	a5,-56(s0)
                break;
    80001890:	da1ff06f          	j	80001630 <interruptHandler+0x108>
        PCB::timeSliceCounter++;
    80001894:	00007497          	auipc	s1,0x7
    80001898:	6044b483          	ld	s1,1540(s1) # 80008e98 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000189c:	0004b783          	ld	a5,0(s1)
    800018a0:	00178793          	addi	a5,a5,1
    800018a4:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800018a8:	00000097          	auipc	ra,0x0
    800018ac:	0f0080e7          	jalr	240(ra) # 80001998 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800018b0:	00007797          	auipc	a5,0x7
    800018b4:	6107b783          	ld	a5,1552(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800018b8:	0007b783          	ld	a5,0(a5)
    800018bc:	0407b703          	ld	a4,64(a5)
    800018c0:	0004b783          	ld	a5,0(s1)
    800018c4:	00e7f863          	bgeu	a5,a4,800018d4 <interruptHandler+0x3ac>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018c8:	00200793          	li	a5,2
    800018cc:	1447b073          	csrc	sip,a5
    }
    800018d0:	cddff06f          	j	800015ac <interruptHandler+0x84>
            PCB::timeSliceCounter = 0;
    800018d4:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800018d8:	00000097          	auipc	ra,0x0
    800018dc:	21c080e7          	jalr	540(ra) # 80001af4 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018e0:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018e4:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018e8:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018ec:	10079073          	csrw	sstatus,a5
    }
    800018f0:	fd9ff06f          	j	800018c8 <interruptHandler+0x3a0>
        size_t code = plic_claim();
    800018f4:	00004097          	auipc	ra,0x4
    800018f8:	9a0080e7          	jalr	-1632(ra) # 80005294 <plic_claim>
        plic_complete(code);
    800018fc:	00004097          	auipc	ra,0x4
    80001900:	9d0080e7          	jalr	-1584(ra) # 800052cc <plic_complete>
    80001904:	ca9ff06f          	j	800015ac <interruptHandler+0x84>

0000000080001908 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001908:	ff010113          	addi	sp,sp,-16
    8000190c:	00813423          	sd	s0,8(sp)
    80001910:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001914:	00007797          	auipc	a5,0x7
    80001918:	63c7b783          	ld	a5,1596(a5) # 80008f50 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    8000191c:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001920:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001924:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001928:	00078e63          	beqz	a5,80001944 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    8000192c:	0307b683          	ld	a3,48(a5)
    80001930:	00e6fa63          	bgeu	a3,a4,80001944 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001934:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001938:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    8000193c:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001940:	fe9ff06f          	j	80001928 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001944:	00100693          	li	a3,1
    80001948:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    8000194c:	02060663          	beqz	a2,80001978 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    80001950:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001954:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001958:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    8000195c:	00078863          	beqz	a5,8000196c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001960:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001964:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001968:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    8000196c:	00813403          	ld	s0,8(sp)
    80001970:	01010113          	addi	sp,sp,16
    80001974:	00008067          	ret
        head = process;
    80001978:	00007717          	auipc	a4,0x7
    8000197c:	5ca73c23          	sd	a0,1496(a4) # 80008f50 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    80001980:	00f53023          	sd	a5,0(a0)
        if(curr) {
    80001984:	fe0784e3          	beqz	a5,8000196c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001988:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    8000198c:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    80001990:	02b7b823          	sd	a1,48(a5)
    }
    80001994:	fd9ff06f          	j	8000196c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

0000000080001998 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    80001998:	00007517          	auipc	a0,0x7
    8000199c:	5b853503          	ld	a0,1464(a0) # 80008f50 <_ZN17SleepingProcesses4headE>
    800019a0:	08050063          	beqz	a0,80001a20 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800019a4:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800019a8:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800019ac:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800019b0:	06050263          	beqz	a0,80001a14 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800019b4:	03053783          	ld	a5,48(a0)
    800019b8:	04079e63          	bnez	a5,80001a14 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800019bc:	fe010113          	addi	sp,sp,-32
    800019c0:	00113c23          	sd	ra,24(sp)
    800019c4:	00813823          	sd	s0,16(sp)
    800019c8:	00913423          	sd	s1,8(sp)
    800019cc:	02010413          	addi	s0,sp,32
    800019d0:	00c0006f          	j	800019dc <_ZN17SleepingProcesses6wakeUpEv+0x44>
    800019d4:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800019d8:	02079063          	bnez	a5,800019f8 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800019dc:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800019e0:	00053023          	sd	zero,0(a0)
        blocked = newState;
    800019e4:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    800019e8:	00001097          	auipc	ra,0x1
    800019ec:	020080e7          	jalr	32(ra) # 80002a08 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019f0:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019f4:	fe0490e3          	bnez	s1,800019d4 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019f8:	00007797          	auipc	a5,0x7
    800019fc:	54a7bc23          	sd	a0,1368(a5) # 80008f50 <_ZN17SleepingProcesses4headE>
}
    80001a00:	01813083          	ld	ra,24(sp)
    80001a04:	01013403          	ld	s0,16(sp)
    80001a08:	00813483          	ld	s1,8(sp)
    80001a0c:	02010113          	addi	sp,sp,32
    80001a10:	00008067          	ret
    head = curr;
    80001a14:	00007797          	auipc	a5,0x7
    80001a18:	52a7be23          	sd	a0,1340(a5) # 80008f50 <_ZN17SleepingProcesses4headE>
    80001a1c:	00008067          	ret
    80001a20:	00008067          	ret

0000000080001a24 <_ZN3PCB12createObjectEPv>:
#include "../h/slab.h"

PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

void PCB::createObject(void* addr) {
    80001a24:	ff010113          	addi	sp,sp,-16
    80001a28:	00813423          	sd	s0,8(sp)
    80001a2c:	01010413          	addi	s0,sp,16
}
    80001a30:	00813403          	ld	s0,8(sp)
    80001a34:	01010113          	addi	sp,sp,16
    80001a38:	00008067          	ret

0000000080001a3c <_ZN3PCB10freeObjectEPv>:

void PCB::freeObject(void* addr) {
    80001a3c:	fe010113          	addi	sp,sp,-32
    80001a40:	00113c23          	sd	ra,24(sp)
    80001a44:	00813823          	sd	s0,16(sp)
    80001a48:	00913423          	sd	s1,8(sp)
    80001a4c:	02010413          	addi	s0,sp,32
    80001a50:	00050493          	mv	s1,a0
    PCB* object = (PCB*)addr;
    delete[] object->stack;
    80001a54:	00853503          	ld	a0,8(a0)
    80001a58:	00050663          	beqz	a0,80001a64 <_ZN3PCB10freeObjectEPv+0x28>
    80001a5c:	00001097          	auipc	ra,0x1
    80001a60:	3fc080e7          	jalr	1020(ra) # 80002e58 <_ZdaPv>
    delete[] object->sysStack;
    80001a64:	0104b503          	ld	a0,16(s1)
    80001a68:	00050663          	beqz	a0,80001a74 <_ZN3PCB10freeObjectEPv+0x38>
    80001a6c:	00001097          	auipc	ra,0x1
    80001a70:	3ec080e7          	jalr	1004(ra) # 80002e58 <_ZdaPv>
}
    80001a74:	01813083          	ld	ra,24(sp)
    80001a78:	01013403          	ld	s0,16(sp)
    80001a7c:	00813483          	ld	s1,8(sp)
    80001a80:	02010113          	addi	sp,sp,32
    80001a84:	00008067          	ret

0000000080001a88 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a88:	ff010113          	addi	sp,sp,-16
    80001a8c:	00113423          	sd	ra,8(sp)
    80001a90:	00813023          	sd	s0,0(sp)
    80001a94:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	a70080e7          	jalr	-1424(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001aa0:	00007797          	auipc	a5,0x7
    80001aa4:	4b87b783          	ld	a5,1208(a5) # 80008f58 <_ZN3PCB7runningE>
    80001aa8:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001aac:	00070513          	mv	a0,a4
    running->main();
    80001ab0:	0207b783          	ld	a5,32(a5)
    80001ab4:	000780e7          	jalr	a5
    thread_exit();
    80001ab8:	fffff097          	auipc	ra,0xfffff
    80001abc:	7e8080e7          	jalr	2024(ra) # 800012a0 <_Z11thread_exitv>
}
    80001ac0:	00813083          	ld	ra,8(sp)
    80001ac4:	00013403          	ld	s0,0(sp)
    80001ac8:	01010113          	addi	sp,sp,16
    80001acc:	00008067          	ret

0000000080001ad0 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001ad0:	ff010113          	addi	sp,sp,-16
    80001ad4:	00813423          	sd	s0,8(sp)
    80001ad8:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001adc:	01300793          	li	a5,19
    80001ae0:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001ae4:	00000073          	ecall
}
    80001ae8:	00813403          	ld	s0,8(sp)
    80001aec:	01010113          	addi	sp,sp,16
    80001af0:	00008067          	ret

0000000080001af4 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001af4:	fe010113          	addi	sp,sp,-32
    80001af8:	00113c23          	sd	ra,24(sp)
    80001afc:	00813823          	sd	s0,16(sp)
    80001b00:	00913423          	sd	s1,8(sp)
    80001b04:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001b08:	00007497          	auipc	s1,0x7
    80001b0c:	4504b483          	ld	s1,1104(s1) # 80008f58 <_ZN3PCB7runningE>
        return finished;
    80001b10:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001b14:	00079663          	bnez	a5,80001b20 <_ZN3PCB8dispatchEv+0x2c>
    80001b18:	0294c783          	lbu	a5,41(s1)
    80001b1c:	04078263          	beqz	a5,80001b60 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b20:	00001097          	auipc	ra,0x1
    80001b24:	f40080e7          	jalr	-192(ra) # 80002a60 <_ZN9Scheduler3getEv>
    80001b28:	00007797          	auipc	a5,0x7
    80001b2c:	42a7b823          	sd	a0,1072(a5) # 80008f58 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001b30:	04854783          	lbu	a5,72(a0)
    80001b34:	02078e63          	beqz	a5,80001b70 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b38:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001b3c:	01853583          	ld	a1,24(a0)
    80001b40:	0184b503          	ld	a0,24(s1)
    80001b44:	fffff097          	auipc	ra,0xfffff
    80001b48:	5e4080e7          	jalr	1508(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001b4c:	01813083          	ld	ra,24(sp)
    80001b50:	01013403          	ld	s0,16(sp)
    80001b54:	00813483          	ld	s1,8(sp)
    80001b58:	02010113          	addi	sp,sp,32
    80001b5c:	00008067          	ret
        Scheduler::put(old);
    80001b60:	00048513          	mv	a0,s1
    80001b64:	00001097          	auipc	ra,0x1
    80001b68:	ea4080e7          	jalr	-348(ra) # 80002a08 <_ZN9Scheduler3putEP3PCB>
    80001b6c:	fb5ff06f          	j	80001b20 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b70:	01853583          	ld	a1,24(a0)
    80001b74:	0184b503          	ld	a0,24(s1)
    80001b78:	fffff097          	auipc	ra,0xfffff
    80001b7c:	5c4080e7          	jalr	1476(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b80:	fcdff06f          	j	80001b4c <_ZN3PCB8dispatchEv+0x58>

0000000080001b84 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001b84:	fe010113          	addi	sp,sp,-32
    80001b88:	00113c23          	sd	ra,24(sp)
    80001b8c:	00813823          	sd	s0,16(sp)
    80001b90:	00913423          	sd	s1,8(sp)
    80001b94:	02010413          	addi	s0,sp,32
    80001b98:	00050493          	mv	s1,a0
    delete[] stack;
    80001b9c:	00853503          	ld	a0,8(a0)
    80001ba0:	00050663          	beqz	a0,80001bac <_ZN3PCBD1Ev+0x28>
    80001ba4:	00001097          	auipc	ra,0x1
    80001ba8:	2b4080e7          	jalr	692(ra) # 80002e58 <_ZdaPv>
    delete[] sysStack;
    80001bac:	0104b503          	ld	a0,16(s1)
    80001bb0:	00050663          	beqz	a0,80001bbc <_ZN3PCBD1Ev+0x38>
    80001bb4:	00001097          	auipc	ra,0x1
    80001bb8:	2a4080e7          	jalr	676(ra) # 80002e58 <_ZdaPv>
}
    80001bbc:	01813083          	ld	ra,24(sp)
    80001bc0:	01013403          	ld	s0,16(sp)
    80001bc4:	00813483          	ld	s1,8(sp)
    80001bc8:	02010113          	addi	sp,sp,32
    80001bcc:	00008067          	ret

0000000080001bd0 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001bd0:	ff010113          	addi	sp,sp,-16
    80001bd4:	00113423          	sd	ra,8(sp)
    80001bd8:	00813023          	sd	s0,0(sp)
    80001bdc:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001be0:	00002097          	auipc	ra,0x2
    80001be4:	2d8080e7          	jalr	728(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001be8:	00813083          	ld	ra,8(sp)
    80001bec:	00013403          	ld	s0,0(sp)
    80001bf0:	01010113          	addi	sp,sp,16
    80001bf4:	00008067          	ret

0000000080001bf8 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001bf8:	ff010113          	addi	sp,sp,-16
    80001bfc:	00113423          	sd	ra,8(sp)
    80001c00:	00813023          	sd	s0,0(sp)
    80001c04:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c08:	00002097          	auipc	ra,0x2
    80001c0c:	420080e7          	jalr	1056(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c10:	00813083          	ld	ra,8(sp)
    80001c14:	00013403          	ld	s0,0(sp)
    80001c18:	01010113          	addi	sp,sp,16
    80001c1c:	00008067          	ret

0000000080001c20 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001c20:	ff010113          	addi	sp,sp,-16
    80001c24:	00813423          	sd	s0,8(sp)
    80001c28:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001c2c:	00007797          	auipc	a5,0x7
    80001c30:	32c7b783          	ld	a5,812(a5) # 80008f58 <_ZN3PCB7runningE>
    80001c34:	0187b503          	ld	a0,24(a5)
    80001c38:	00813403          	ld	s0,8(sp)
    80001c3c:	01010113          	addi	sp,sp,16
    80001c40:	00008067          	ret

0000000080001c44 <_ZN3PCB10initObjectEPFvvEmPv>:

void PCB::initObject(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001c44:	fe010113          	addi	sp,sp,-32
    80001c48:	00113c23          	sd	ra,24(sp)
    80001c4c:	00813823          	sd	s0,16(sp)
    80001c50:	00913423          	sd	s1,8(sp)
    80001c54:	02010413          	addi	s0,sp,32
    80001c58:	00050493          	mv	s1,a0
    firstCall = true;
    80001c5c:	00100793          	li	a5,1
    80001c60:	04f50423          	sb	a5,72(a0)
    registers = nullptr;
    80001c64:	00053c23          	sd	zero,24(a0)
    nextInList = nullptr;
    80001c68:	00053023          	sd	zero,0(a0)
    timeSleeping = 0;
    80001c6c:	02053823          	sd	zero,48(a0)
    finished = blocked = semDeleted = false;
    80001c70:	02050523          	sb	zero,42(a0)
    80001c74:	020504a3          	sb	zero,41(a0)
    80001c78:	02050423          	sb	zero,40(a0)
    main = main_;
    80001c7c:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001c80:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001c84:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001c88:	10800513          	li	a0,264
    80001c8c:	00002097          	auipc	ra,0x2
    80001c90:	22c080e7          	jalr	556(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
    80001c94:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001c98:	00008537          	lui	a0,0x8
    80001c9c:	00002097          	auipc	ra,0x2
    80001ca0:	21c080e7          	jalr	540(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
    80001ca4:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001ca8:	000087b7          	lui	a5,0x8
    80001cac:	00f50533          	add	a0,a0,a5
    80001cb0:	0184b783          	ld	a5,24(s1)
    80001cb4:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001cb8:	0184b783          	ld	a5,24(s1)
    80001cbc:	00000717          	auipc	a4,0x0
    80001cc0:	dcc70713          	addi	a4,a4,-564 # 80001a88 <_ZN3PCB15proccessWrapperEv>
    80001cc4:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001cc8:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ccc:	0204b783          	ld	a5,32(s1)
    80001cd0:	00078c63          	beqz	a5,80001ce8 <_ZN3PCB10initObjectEPFvvEmPv+0xa4>
}
    80001cd4:	01813083          	ld	ra,24(sp)
    80001cd8:	01013403          	ld	s0,16(sp)
    80001cdc:	00813483          	ld	s1,8(sp)
    80001ce0:	02010113          	addi	sp,sp,32
    80001ce4:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ce8:	04048423          	sb	zero,72(s1)
}
    80001cec:	fe9ff06f          	j	80001cd4 <_ZN3PCB10initObjectEPFvvEmPv+0x90>

0000000080001cf0 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001cf0:	ff010113          	addi	sp,sp,-16
    80001cf4:	00113423          	sd	ra,8(sp)
    80001cf8:	00813023          	sd	s0,0(sp)
    80001cfc:	01010413          	addi	s0,sp,16
    initObject(main_, timeSlice_, mainArguments_);
    80001d00:	00000097          	auipc	ra,0x0
    80001d04:	f44080e7          	jalr	-188(ra) # 80001c44 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001d08:	00813083          	ld	ra,8(sp)
    80001d0c:	00013403          	ld	s0,0(sp)
    80001d10:	01010113          	addi	sp,sp,16
    80001d14:	00008067          	ret

0000000080001d18 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001d18:	fd010113          	addi	sp,sp,-48
    80001d1c:	02113423          	sd	ra,40(sp)
    80001d20:	02813023          	sd	s0,32(sp)
    80001d24:	00913c23          	sd	s1,24(sp)
    80001d28:	01213823          	sd	s2,16(sp)
    80001d2c:	01313423          	sd	s3,8(sp)
    80001d30:	03010413          	addi	s0,sp,48
    80001d34:	00050913          	mv	s2,a0
    80001d38:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001d3c:	05000513          	li	a0,80
    80001d40:	00000097          	auipc	ra,0x0
    80001d44:	e90080e7          	jalr	-368(ra) # 80001bd0 <_ZN3PCBnwEm>
    80001d48:	00050493          	mv	s1,a0
    80001d4c:	00098693          	mv	a3,s3
    80001d50:	00200613          	li	a2,2
    80001d54:	00090593          	mv	a1,s2
    80001d58:	00000097          	auipc	ra,0x0
    80001d5c:	f98080e7          	jalr	-104(ra) # 80001cf0 <_ZN3PCBC1EPFvvEmPv>
    80001d60:	0200006f          	j	80001d80 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001d64:	00050913          	mv	s2,a0
    80001d68:	00048513          	mv	a0,s1
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	e8c080e7          	jalr	-372(ra) # 80001bf8 <_ZN3PCBdlEPv>
    80001d74:	00090513          	mv	a0,s2
    80001d78:	00008097          	auipc	ra,0x8
    80001d7c:	3b0080e7          	jalr	944(ra) # 8000a128 <_Unwind_Resume>
}
    80001d80:	00048513          	mv	a0,s1
    80001d84:	02813083          	ld	ra,40(sp)
    80001d88:	02013403          	ld	s0,32(sp)
    80001d8c:	01813483          	ld	s1,24(sp)
    80001d90:	01013903          	ld	s2,16(sp)
    80001d94:	00813983          	ld	s3,8(sp)
    80001d98:	03010113          	addi	sp,sp,48
    80001d9c:	00008067          	ret

0000000080001da0 <_ZN3PCB12initPCBCacheEv>:

void PCB::initPCBCache() {
    80001da0:	ff010113          	addi	sp,sp,-16
    80001da4:	00113423          	sd	ra,8(sp)
    80001da8:	00813023          	sd	s0,0(sp)
    80001dac:	01010413          	addi	s0,sp,16
    pcbCache = (kmem_cache_t*)kmem_cache_create("PCB", sizeof(PCB), &createObject, &freeObject);
    80001db0:	00000697          	auipc	a3,0x0
    80001db4:	c8c68693          	addi	a3,a3,-884 # 80001a3c <_ZN3PCB10freeObjectEPv>
    80001db8:	00000617          	auipc	a2,0x0
    80001dbc:	c6c60613          	addi	a2,a2,-916 # 80001a24 <_ZN3PCB12createObjectEPv>
    80001dc0:	05000593          	li	a1,80
    80001dc4:	00005517          	auipc	a0,0x5
    80001dc8:	36c50513          	addi	a0,a0,876 # 80007130 <CONSOLE_STATUS+0x120>
    80001dcc:	00002097          	auipc	ra,0x2
    80001dd0:	438080e7          	jalr	1080(ra) # 80004204 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001dd4:	00007797          	auipc	a5,0x7
    80001dd8:	18a7b623          	sd	a0,396(a5) # 80008f60 <_ZN3PCB8pcbCacheE>
}
    80001ddc:	00813083          	ld	ra,8(sp)
    80001de0:	00013403          	ld	s0,0(sp)
    80001de4:	01010113          	addi	sp,sp,16
    80001de8:	00008067          	ret

0000000080001dec <_ZN3PCB16createSysProcessEPFvvEPv>:
PCB *PCB::createSysProcess(PCB::processMain main, void* arguments) {
    80001dec:	fd010113          	addi	sp,sp,-48
    80001df0:	02113423          	sd	ra,40(sp)
    80001df4:	02813023          	sd	s0,32(sp)
    80001df8:	00913c23          	sd	s1,24(sp)
    80001dfc:	01213823          	sd	s2,16(sp)
    80001e00:	01313423          	sd	s3,8(sp)
    80001e04:	03010413          	addi	s0,sp,48
    80001e08:	00050913          	mv	s2,a0
    80001e0c:	00058993          	mv	s3,a1
    if(!pcbCache) initPCBCache();
    80001e10:	00007797          	auipc	a5,0x7
    80001e14:	1507b783          	ld	a5,336(a5) # 80008f60 <_ZN3PCB8pcbCacheE>
    80001e18:	04078663          	beqz	a5,80001e64 <_ZN3PCB16createSysProcessEPFvvEPv+0x78>
    PCB* object = (PCB*) kmem_cache_alloc(pcbCache);
    80001e1c:	00007517          	auipc	a0,0x7
    80001e20:	14453503          	ld	a0,324(a0) # 80008f60 <_ZN3PCB8pcbCacheE>
    80001e24:	00002097          	auipc	ra,0x2
    80001e28:	430080e7          	jalr	1072(ra) # 80004254 <_Z16kmem_cache_allocP12kmem_cache_s>
    80001e2c:	00050493          	mv	s1,a0
    object->initObject(main, DEFAULT_TIME_SLICE, arguments);
    80001e30:	00098693          	mv	a3,s3
    80001e34:	00200613          	li	a2,2
    80001e38:	00090593          	mv	a1,s2
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	e08080e7          	jalr	-504(ra) # 80001c44 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001e44:	00048513          	mv	a0,s1
    80001e48:	02813083          	ld	ra,40(sp)
    80001e4c:	02013403          	ld	s0,32(sp)
    80001e50:	01813483          	ld	s1,24(sp)
    80001e54:	01013903          	ld	s2,16(sp)
    80001e58:	00813983          	ld	s3,8(sp)
    80001e5c:	03010113          	addi	sp,sp,48
    80001e60:	00008067          	ret
    if(!pcbCache) initPCBCache();
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	f3c080e7          	jalr	-196(ra) # 80001da0 <_ZN3PCB12initPCBCacheEv>
    80001e6c:	fb1ff06f          	j	80001e1c <_ZN3PCB16createSysProcessEPFvvEPv+0x30>

0000000080001e70 <_ZN14BuddyAllocator12getFreeBlockEm>:
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    80001e70:	ff010113          	addi	sp,sp,-16
    80001e74:	00813423          	sd	s0,8(sp)
    80001e78:	01010413          	addi	s0,sp,16
    size--;
    80001e7c:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001e80:	00b00793          	li	a5,11
    80001e84:	02a7e463          	bltu	a5,a0,80001eac <_ZN14BuddyAllocator12getFreeBlockEm+0x3c>
    80001e88:	00351513          	slli	a0,a0,0x3
    80001e8c:	00007797          	auipc	a5,0x7
    80001e90:	0e478793          	addi	a5,a5,228 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80001e94:	00a78533          	add	a0,a5,a0
    80001e98:	00053503          	ld	a0,0(a0)
    80001e9c:	00050c63          	beqz	a0,80001eb4 <_ZN14BuddyAllocator12getFreeBlockEm+0x44>

    BuddyEntry* block = buddy[size];
    return block;
}
    80001ea0:	00813403          	ld	s0,8(sp)
    80001ea4:	01010113          	addi	sp,sp,16
    80001ea8:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001eac:	00000513          	li	a0,0
    80001eb0:	ff1ff06f          	j	80001ea0 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>
    80001eb4:	00000513          	li	a0,0
    80001eb8:	fe9ff06f          	j	80001ea0 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>

0000000080001ebc <_ZN14BuddyAllocator12popFreeBlockEm>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    80001ebc:	ff010113          	addi	sp,sp,-16
    80001ec0:	00813423          	sd	s0,8(sp)
    80001ec4:	01010413          	addi	s0,sp,16
    size--;
    80001ec8:	fff50793          	addi	a5,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001ecc:	00b00713          	li	a4,11
    80001ed0:	04f76063          	bltu	a4,a5,80001f10 <_ZN14BuddyAllocator12popFreeBlockEm+0x54>
    80001ed4:	00379693          	slli	a3,a5,0x3
    80001ed8:	00007717          	auipc	a4,0x7
    80001edc:	09870713          	addi	a4,a4,152 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80001ee0:	00d70733          	add	a4,a4,a3
    80001ee4:	00073503          	ld	a0,0(a4)
    80001ee8:	00050e63          	beqz	a0,80001f04 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001eec:	00053683          	ld	a3,0(a0)
    80001ef0:	00379793          	slli	a5,a5,0x3
    80001ef4:	00007717          	auipc	a4,0x7
    80001ef8:	07c70713          	addi	a4,a4,124 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80001efc:	00f707b3          	add	a5,a4,a5
    80001f00:	00d7b023          	sd	a3,0(a5)
    return block;
}
    80001f04:	00813403          	ld	s0,8(sp)
    80001f08:	01010113          	addi	sp,sp,16
    80001f0c:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f10:	00000513          	li	a0,0
    80001f14:	ff1ff06f          	j	80001f04 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

0000000080001f18 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    80001f18:	ff010113          	addi	sp,sp,-16
    80001f1c:	00813423          	sd	s0,8(sp)
    80001f20:	01010413          	addi	s0,sp,16
    size--;
    80001f24:	fff50693          	addi	a3,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80001f28:	00b00793          	li	a5,11
    80001f2c:	06d7e663          	bltu	a5,a3,80001f98 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x80>

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f30:	00369713          	slli	a4,a3,0x3
    80001f34:	00007797          	auipc	a5,0x7
    80001f38:	03c78793          	addi	a5,a5,60 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80001f3c:	00e787b3          	add	a5,a5,a4
    80001f40:	0007b603          	ld	a2,0(a5)
    80001f44:	00060513          	mv	a0,a2
    BuddyEntry *prev = nullptr;
    80001f48:	00000713          	li	a4,0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f4c:	02050263          	beqz	a0,80001f70 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
        if(curr->addr == addr) {
    80001f50:	00853783          	ld	a5,8(a0)
    80001f54:	00b78863          	beq	a5,a1,80001f64 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x4c>
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    80001f58:	00050713          	mv	a4,a0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f5c:	00053503          	ld	a0,0(a0)
    80001f60:	fedff06f          	j	80001f4c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x34>
            if(prev) {
    80001f64:	00070c63          	beqz	a4,80001f7c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x64>
                prev->next = curr->next;
    80001f68:	00053783          	ld	a5,0(a0)
    80001f6c:	00f73023          	sd	a5,0(a4)
    }

    return nullptr;
}
    80001f70:	00813403          	ld	s0,8(sp)
    80001f74:	01010113          	addi	sp,sp,16
    80001f78:	00008067          	ret
                buddy[size] = buddy[size]->next;
    80001f7c:	00063703          	ld	a4,0(a2)
    80001f80:	00369693          	slli	a3,a3,0x3
    80001f84:	00007797          	auipc	a5,0x7
    80001f88:	fec78793          	addi	a5,a5,-20 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80001f8c:	00d786b3          	add	a3,a5,a3
    80001f90:	00e6b023          	sd	a4,0(a3)
            return curr;
    80001f94:	fddff06f          	j	80001f70 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
    if(size >= maxPowerSize) return nullptr;
    80001f98:	00000513          	li	a0,0
    80001f9c:	fd5ff06f          	j	80001f70 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>

0000000080001fa0 <_ZN14BuddyAllocator10printBuddyEv>:

void BuddyAllocator::printBuddy() {
    80001fa0:	fe010113          	addi	sp,sp,-32
    80001fa4:	00113c23          	sd	ra,24(sp)
    80001fa8:	00813823          	sd	s0,16(sp)
    80001fac:	00913423          	sd	s1,8(sp)
    80001fb0:	01213023          	sd	s2,0(sp)
    80001fb4:	02010413          	addi	s0,sp,32
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001fb8:	00000913          	li	s2,0
    80001fbc:	0180006f          	j	80001fd4 <_ZN14BuddyAllocator10printBuddyEv+0x34>
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    80001fc0:	00005517          	auipc	a0,0x5
    80001fc4:	25050513          	addi	a0,a0,592 # 80007210 <CONSOLE_STATUS+0x200>
    80001fc8:	00000097          	auipc	ra,0x0
    80001fcc:	764080e7          	jalr	1892(ra) # 8000272c <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001fd0:	00190913          	addi	s2,s2,1
    80001fd4:	00b00793          	li	a5,11
    80001fd8:	0727e663          	bltu	a5,s2,80002044 <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80001fdc:	00000613          	li	a2,0
    80001fe0:	00a00593          	li	a1,10
    80001fe4:	0019051b          	addiw	a0,s2,1
    80001fe8:	00001097          	auipc	ra,0x1
    80001fec:	8dc080e7          	jalr	-1828(ra) # 800028c4 <_Z8printIntiii>
        printString(": ");
    80001ff0:	00005517          	auipc	a0,0x5
    80001ff4:	14850513          	addi	a0,a0,328 # 80007138 <CONSOLE_STATUS+0x128>
    80001ff8:	00000097          	auipc	ra,0x0
    80001ffc:	734080e7          	jalr	1844(ra) # 8000272c <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80002000:	00391713          	slli	a4,s2,0x3
    80002004:	00007797          	auipc	a5,0x7
    80002008:	f6c78793          	addi	a5,a5,-148 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    8000200c:	00e787b3          	add	a5,a5,a4
    80002010:	0007b483          	ld	s1,0(a5)
    80002014:	fa0486e3          	beqz	s1,80001fc0 <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    80002018:	00000613          	li	a2,0
    8000201c:	00a00593          	li	a1,10
    80002020:	0084a503          	lw	a0,8(s1)
    80002024:	00001097          	auipc	ra,0x1
    80002028:	8a0080e7          	jalr	-1888(ra) # 800028c4 <_Z8printIntiii>
            printString(" ");
    8000202c:	00005517          	auipc	a0,0x5
    80002030:	11450513          	addi	a0,a0,276 # 80007140 <CONSOLE_STATUS+0x130>
    80002034:	00000097          	auipc	ra,0x0
    80002038:	6f8080e7          	jalr	1784(ra) # 8000272c <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    8000203c:	0004b483          	ld	s1,0(s1)
    80002040:	fd5ff06f          	j	80002014 <_ZN14BuddyAllocator10printBuddyEv+0x74>
    }
}
    80002044:	01813083          	ld	ra,24(sp)
    80002048:	01013403          	ld	s0,16(sp)
    8000204c:	00813483          	ld	s1,8(sp)
    80002050:	00013903          	ld	s2,0(sp)
    80002054:	02010113          	addi	sp,sp,32
    80002058:	00008067          	ret

000000008000205c <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
    8000205c:	ff010113          	addi	sp,sp,-16
    80002060:	00813423          	sd	s0,8(sp)
    80002064:	01010413          	addi	s0,sp,16
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
    80002068:	00053023          	sd	zero,0(a0)
        entry->addr = addr;
    8000206c:	00a53423          	sd	a0,8(a0)
        return entry;
}
    80002070:	00813403          	ld	s0,8(sp)
    80002074:	01010113          	addi	sp,sp,16
    80002078:	00008067          	ret

000000008000207c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>:

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    8000207c:	ff010113          	addi	sp,sp,-16
    80002080:	00813423          	sd	s0,8(sp)
    80002084:	01010413          	addi	s0,sp,16
    size--;
    80002088:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize) return -1;
    8000208c:	00b00793          	li	a5,11
    80002090:	08a7ec63          	bltu	a5,a0,80002128 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xac>

    if(buddy[size] == nullptr) {
    80002094:	00351713          	slli	a4,a0,0x3
    80002098:	00007797          	auipc	a5,0x7
    8000209c:	ed878793          	addi	a5,a5,-296 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    800020a0:	00e787b3          	add	a5,a5,a4
    800020a4:	0007b783          	ld	a5,0(a5)
    800020a8:	00078663          	beqz	a5,800020b4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x38>
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    800020ac:	00000613          	li	a2,0
    800020b0:	0200006f          	j	800020d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x54>
        buddy[size] = entry;
    800020b4:	00007797          	auipc	a5,0x7
    800020b8:	ebc78793          	addi	a5,a5,-324 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    800020bc:	00e78533          	add	a0,a5,a4
    800020c0:	00b53023          	sd	a1,0(a0)
        return 0;
    800020c4:	00000513          	li	a0,0
    800020c8:	06c0006f          	j	80002134 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    800020cc:	00070793          	mv	a5,a4
    800020d0:	06078063          	beqz	a5,80002130 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb4>
        if(curr->addr > entry->addr) {
    800020d4:	0087b683          	ld	a3,8(a5)
    800020d8:	0085b703          	ld	a4,8(a1)
    800020dc:	00d76e63          	bltu	a4,a3,800020f8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x7c>
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
    800020e0:	0007b703          	ld	a4,0(a5)
            curr->next = entry;
            break;
        }
        prev = curr;
    800020e4:	00078613          	mv	a2,a5
        if(curr->next == nullptr) {
    800020e8:	fe0712e3          	bnez	a4,800020cc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x50>
            curr->next = entry;
    800020ec:	00b7b023          	sd	a1,0(a5)
    }

    return 0;
    800020f0:	00000513          	li	a0,0
            break;
    800020f4:	0400006f          	j	80002134 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
            entry->next = curr;
    800020f8:	00f5b023          	sd	a5,0(a1)
            if(prev) {
    800020fc:	00060863          	beqz	a2,8000210c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x90>
                prev->next = curr;
    80002100:	00f63023          	sd	a5,0(a2)
    return 0;
    80002104:	00000513          	li	a0,0
    80002108:	02c0006f          	j	80002134 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
                buddy[size] = entry;
    8000210c:	00351513          	slli	a0,a0,0x3
    80002110:	00007797          	auipc	a5,0x7
    80002114:	e6078793          	addi	a5,a5,-416 # 80008f70 <_ZN14BuddyAllocator5buddyE>
    80002118:	00a78533          	add	a0,a5,a0
    8000211c:	00b53023          	sd	a1,0(a0)
    return 0;
    80002120:	00000513          	li	a0,0
    80002124:	0100006f          	j	80002134 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    if(size >= maxPowerSize) return -1;
    80002128:	fff00513          	li	a0,-1
    8000212c:	0080006f          	j	80002134 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    return 0;
    80002130:	00000513          	li	a0,0
}
    80002134:	00813403          	ld	s0,8(sp)
    80002138:	01010113          	addi	sp,sp,16
    8000213c:	00008067          	ret

0000000080002140 <_ZN14BuddyAllocator9initBuddyEv>:
    if(startAddr != nullptr) return 1;
    80002140:	00007797          	auipc	a5,0x7
    80002144:	e907b783          	ld	a5,-368(a5) # 80008fd0 <_ZN14BuddyAllocator9startAddrE>
    80002148:	00078663          	beqz	a5,80002154 <_ZN14BuddyAllocator9initBuddyEv+0x14>
    8000214c:	00100513          	li	a0,1
}
    80002150:	00008067          	ret
int BuddyAllocator::initBuddy() {
    80002154:	ff010113          	addi	sp,sp,-16
    80002158:	00113423          	sd	ra,8(sp)
    8000215c:	00813023          	sd	s0,0(sp)
    80002160:	01010413          	addi	s0,sp,16
    startAddr = (void*)HEAP_START_ADDR;
    80002164:	00007797          	auipc	a5,0x7
    80002168:	d147b783          	ld	a5,-748(a5) # 80008e78 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000216c:	0007b503          	ld	a0,0(a5)
    80002170:	00007797          	auipc	a5,0x7
    80002174:	e6a7b023          	sd	a0,-416(a5) # 80008fd0 <_ZN14BuddyAllocator9startAddrE>
    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    80002178:	00000097          	auipc	ra,0x0
    8000217c:	ee4080e7          	jalr	-284(ra) # 8000205c <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    80002180:	00050593          	mv	a1,a0
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);
    80002184:	00c00513          	li	a0,12
    80002188:	00000097          	auipc	ra,0x0
    8000218c:	ef4080e7          	jalr	-268(ra) # 8000207c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
}
    80002190:	00813083          	ld	ra,8(sp)
    80002194:	00013403          	ld	s0,0(sp)
    80002198:	01010113          	addi	sp,sp,16
    8000219c:	00008067          	ret

00000000800021a0 <_ZN14BuddyAllocator10buddyAllocEm>:
void *BuddyAllocator::buddyAlloc(size_t size) {
    800021a0:	fd010113          	addi	sp,sp,-48
    800021a4:	02113423          	sd	ra,40(sp)
    800021a8:	02813023          	sd	s0,32(sp)
    800021ac:	00913c23          	sd	s1,24(sp)
    800021b0:	01213823          	sd	s2,16(sp)
    800021b4:	01313423          	sd	s3,8(sp)
    800021b8:	01413023          	sd	s4,0(sp)
    800021bc:	03010413          	addi	s0,sp,48
    size--;
    800021c0:	fff50a13          	addi	s4,a0,-1
    if(size >= maxPowerSize) return nullptr;
    800021c4:	00b00793          	li	a5,11
    800021c8:	0747ea63          	bltu	a5,s4,8000223c <_ZN14BuddyAllocator10buddyAllocEm+0x9c>
    for(size_t curr = size; curr < maxPowerSize; curr++) {
    800021cc:	000a0493          	mv	s1,s4
    800021d0:	0080006f          	j	800021d8 <_ZN14BuddyAllocator10buddyAllocEm+0x38>
    800021d4:	00098493          	mv	s1,s3
    800021d8:	00b00793          	li	a5,11
    800021dc:	0697e463          	bltu	a5,s1,80002244 <_ZN14BuddyAllocator10buddyAllocEm+0xa4>
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
    800021e0:	00148993          	addi	s3,s1,1
    800021e4:	00098513          	mv	a0,s3
    800021e8:	00000097          	auipc	ra,0x0
    800021ec:	cd4080e7          	jalr	-812(ra) # 80001ebc <_ZN14BuddyAllocator12popFreeBlockEm>
    800021f0:	00050913          	mv	s2,a0
        if(block != nullptr) { // postoji slobodan blok ove velicine
    800021f4:	fe0500e3          	beqz	a0,800021d4 <_ZN14BuddyAllocator10buddyAllocEm+0x34>
            while(curr > size) {
    800021f8:	029a7e63          	bgeu	s4,s1,80002234 <_ZN14BuddyAllocator10buddyAllocEm+0x94>

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
    static size_t sizeInBytes(size_t size) {
        size--;
    800021fc:	fff48993          	addi	s3,s1,-1
        return (1<<size)*blockSize;
    80002200:	00100793          	li	a5,1
    80002204:	013797bb          	sllw	a5,a5,s3
    80002208:	00c79793          	slli	a5,a5,0xc
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
    8000220c:	00893503          	ld	a0,8(s2)
    80002210:	00f50533          	add	a0,a0,a5
    80002214:	00000097          	auipc	ra,0x0
    80002218:	e48080e7          	jalr	-440(ra) # 8000205c <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    8000221c:	00050593          	mv	a1,a0
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment
    80002220:	00048513          	mv	a0,s1
    80002224:	00000097          	auipc	ra,0x0
    80002228:	e58080e7          	jalr	-424(ra) # 8000207c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
                curr--;
    8000222c:	00098493          	mv	s1,s3
            while(curr > size) {
    80002230:	fc9ff06f          	j	800021f8 <_ZN14BuddyAllocator10buddyAllocEm+0x58>
            void* res = block->addr;
    80002234:	00893503          	ld	a0,8(s2)
            return res;
    80002238:	0100006f          	j	80002248 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    if(size >= maxPowerSize) return nullptr;
    8000223c:	00000513          	li	a0,0
    80002240:	0080006f          	j	80002248 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    return nullptr;
    80002244:	00000513          	li	a0,0
}
    80002248:	02813083          	ld	ra,40(sp)
    8000224c:	02013403          	ld	s0,32(sp)
    80002250:	01813483          	ld	s1,24(sp)
    80002254:	01013903          	ld	s2,16(sp)
    80002258:	00813983          	ld	s3,8(sp)
    8000225c:	00013a03          	ld	s4,0(sp)
    80002260:	03010113          	addi	sp,sp,48
    80002264:	00008067          	ret

0000000080002268 <_ZN14BuddyAllocator9buddyFreeEPvm>:
    size--;
    80002268:	fff58593          	addi	a1,a1,-1
    if(size >= maxPowerSize || addr == nullptr) return -1;
    8000226c:	00b00793          	li	a5,11
    80002270:	0ab7ec63          	bltu	a5,a1,80002328 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc0>
int BuddyAllocator::buddyFree(void *addr, size_t size) {
    80002274:	fd010113          	addi	sp,sp,-48
    80002278:	02113423          	sd	ra,40(sp)
    8000227c:	02813023          	sd	s0,32(sp)
    80002280:	00913c23          	sd	s1,24(sp)
    80002284:	01213823          	sd	s2,16(sp)
    80002288:	01313423          	sd	s3,8(sp)
    8000228c:	01413023          	sd	s4,0(sp)
    80002290:	03010413          	addi	s0,sp,48
    80002294:	00050a13          	mv	s4,a0
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002298:	00051a63          	bnez	a0,800022ac <_ZN14BuddyAllocator9buddyFreeEPvm+0x44>
    8000229c:	fff00513          	li	a0,-1
    800022a0:	0940006f          	j	80002334 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
            next = other;
    800022a4:	00048a13          	mv	s4,s1
    800022a8:	00098593          	mv	a1,s3
    while(size < maxPowerSize) {
    800022ac:	00b00793          	li	a5,11
    800022b0:	08b7e063          	bltu	a5,a1,80002330 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc8>
    }

    static void* relativeAddress(void* addr) {
        return (char*)addr - (size_t)startAddr;
    800022b4:	00007917          	auipc	s2,0x7
    800022b8:	d1c93903          	ld	s2,-740(s2) # 80008fd0 <_ZN14BuddyAllocator9startAddrE>
    800022bc:	412a0933          	sub	s2,s4,s2
        size--;
    800022c0:	00158993          	addi	s3,a1,1
        return (1<<size)*blockSize;
    800022c4:	00100793          	li	a5,1
    800022c8:	0137973b          	sllw	a4,a5,s3
    800022cc:	00c71713          	slli	a4,a4,0xc
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
    800022d0:	02e97933          	remu	s2,s2,a4
    800022d4:	00b797bb          	sllw	a5,a5,a1
    800022d8:	00c79793          	slli	a5,a5,0xc
        other = (void*)((char*)other + (module == 0 ? offset : -offset));
    800022dc:	00090463          	beqz	s2,800022e4 <_ZN14BuddyAllocator9buddyFreeEPvm+0x7c>
    800022e0:	40f007b3          	neg	a5,a5
    800022e4:	00fa04b3          	add	s1,s4,a5
        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
    800022e8:	00048593          	mv	a1,s1
    800022ec:	00098513          	mv	a0,s3
    800022f0:	00000097          	auipc	ra,0x0
    800022f4:	c28080e7          	jalr	-984(ra) # 80001f18 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
    800022f8:	00050663          	beqz	a0,80002304 <_ZN14BuddyAllocator9buddyFreeEPvm+0x9c>
        if(module != 0) {
    800022fc:	fa0914e3          	bnez	s2,800022a4 <_ZN14BuddyAllocator9buddyFreeEPvm+0x3c>
    80002300:	fa9ff06f          	j	800022a8 <_ZN14BuddyAllocator9buddyFreeEPvm+0x40>
            BuddyEntry* entry = BuddyEntry::createEntry(next);
    80002304:	000a0513          	mv	a0,s4
    80002308:	00000097          	auipc	ra,0x0
    8000230c:	d54080e7          	jalr	-684(ra) # 8000205c <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    80002310:	00050593          	mv	a1,a0
            BuddyEntry::addEntry(size+1, entry);
    80002314:	00098513          	mv	a0,s3
    80002318:	00000097          	auipc	ra,0x0
    8000231c:	d64080e7          	jalr	-668(ra) # 8000207c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
    return 0;
    80002320:	00000513          	li	a0,0
            break;
    80002324:	0100006f          	j	80002334 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002328:	fff00513          	li	a0,-1
}
    8000232c:	00008067          	ret
    return 0;
    80002330:	00000513          	li	a0,0
}
    80002334:	02813083          	ld	ra,40(sp)
    80002338:	02013403          	ld	s0,32(sp)
    8000233c:	01813483          	ld	s1,24(sp)
    80002340:	01013903          	ld	s2,16(sp)
    80002344:	00813983          	ld	s3,8(sp)
    80002348:	00013a03          	ld	s4,0(sp)
    8000234c:	03010113          	addi	sp,sp,48
    80002350:	00008067          	ret

0000000080002354 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    80002354:	fe010113          	addi	sp,sp,-32
    80002358:	00113c23          	sd	ra,24(sp)
    8000235c:	00813823          	sd	s0,16(sp)
    80002360:	00913423          	sd	s1,8(sp)
    80002364:	01213023          	sd	s2,0(sp)
    80002368:	02010413          	addi	s0,sp,32
    8000236c:	00050493          	mv	s1,a0
    80002370:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80002374:	01000513          	li	a0,16
    80002378:	00002097          	auipc	ra,0x2
    8000237c:	b40080e7          	jalr	-1216(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80002380:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80002384:	01250423          	sb	s2,8(a0)
    if(!head) {
    80002388:	0004b783          	ld	a5,0(s1)
    8000238c:	02078863          	beqz	a5,800023bc <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80002390:	0084b783          	ld	a5,8(s1)
    80002394:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80002398:	0084b783          	ld	a5,8(s1)
    8000239c:	0007b783          	ld	a5,0(a5)
    800023a0:	00f4b423          	sd	a5,8(s1)
    }
}
    800023a4:	01813083          	ld	ra,24(sp)
    800023a8:	01013403          	ld	s0,16(sp)
    800023ac:	00813483          	ld	s1,8(sp)
    800023b0:	00013903          	ld	s2,0(sp)
    800023b4:	02010113          	addi	sp,sp,32
    800023b8:	00008067          	ret
        head = tail = newElem;
    800023bc:	00a4b423          	sd	a0,8(s1)
    800023c0:	00a4b023          	sd	a0,0(s1)
    800023c4:	fe1ff06f          	j	800023a4 <_ZN8IOBuffer8pushBackEc+0x50>

00000000800023c8 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void*) {
    800023c8:	fe010113          	addi	sp,sp,-32
    800023cc:	00113c23          	sd	ra,24(sp)
    800023d0:	00813823          	sd	s0,16(sp)
    800023d4:	00913423          	sd	s1,8(sp)
    800023d8:	02010413          	addi	s0,sp,32
    800023dc:	04c0006f          	j	80002428 <_ZN3CCB9inputBodyEPv+0x60>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    800023e0:	00007797          	auipc	a5,0x7
    800023e4:	a807b783          	ld	a5,-1408(a5) # 80008e60 <_GLOBAL_OFFSET_TABLE_+0x8>
    800023e8:	0007b783          	ld	a5,0(a5)
    800023ec:	00007497          	auipc	s1,0x7
    800023f0:	bec48493          	addi	s1,s1,-1044 # 80008fd8 <_ZN3CCB11inputBufferE>
    800023f4:	0007c583          	lbu	a1,0(a5)
    800023f8:	00048513          	mv	a0,s1
    800023fc:	00000097          	auipc	ra,0x0
    80002400:	f58080e7          	jalr	-168(ra) # 80002354 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80002404:	0104b503          	ld	a0,16(s1)
    80002408:	fffff097          	auipc	ra,0xfffff
    8000240c:	fd8080e7          	jalr	-40(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    80002410:	00a00513          	li	a0,10
    80002414:	00003097          	auipc	ra,0x3
    80002418:	eb8080e7          	jalr	-328(ra) # 800052cc <plic_complete>
            sem_wait(semInput);
    8000241c:	0184b503          	ld	a0,24(s1)
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	f78080e7          	jalr	-136(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002428:	00007797          	auipc	a5,0x7
    8000242c:	a487b783          	ld	a5,-1464(a5) # 80008e70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002430:	0007b783          	ld	a5,0(a5)
    80002434:	0007c783          	lbu	a5,0(a5)
    80002438:	0017f793          	andi	a5,a5,1
    8000243c:	fa0792e3          	bnez	a5,800023e0 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    80002440:	fffff097          	auipc	ra,0xfffff
    80002444:	e34080e7          	jalr	-460(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002448:	fe1ff06f          	j	80002428 <_ZN3CCB9inputBodyEPv+0x60>

000000008000244c <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    8000244c:	fe010113          	addi	sp,sp,-32
    80002450:	00113c23          	sd	ra,24(sp)
    80002454:	00813823          	sd	s0,16(sp)
    80002458:	00913423          	sd	s1,8(sp)
    8000245c:	02010413          	addi	s0,sp,32
    80002460:	00050793          	mv	a5,a0
    if(!head) return 0;
    80002464:	00053503          	ld	a0,0(a0)
    80002468:	04050063          	beqz	a0,800024a8 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    8000246c:	00053703          	ld	a4,0(a0)
    80002470:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80002474:	0087b703          	ld	a4,8(a5)
    80002478:	02e50463          	beq	a0,a4,800024a0 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    8000247c:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80002480:	00002097          	auipc	ra,0x2
    80002484:	ba8080e7          	jalr	-1112(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80002488:	00048513          	mv	a0,s1
    8000248c:	01813083          	ld	ra,24(sp)
    80002490:	01013403          	ld	s0,16(sp)
    80002494:	00813483          	ld	s1,8(sp)
    80002498:	02010113          	addi	sp,sp,32
    8000249c:	00008067          	ret
    if(tail == curr) tail = nullptr;
    800024a0:	0007b423          	sd	zero,8(a5)
    800024a4:	fd9ff06f          	j	8000247c <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    800024a8:	00000493          	li	s1,0
    800024ac:	fddff06f          	j	80002488 <_ZN8IOBuffer8popFrontEv+0x3c>

00000000800024b0 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    800024b0:	ff010113          	addi	sp,sp,-16
    800024b4:	00813423          	sd	s0,8(sp)
    800024b8:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    800024bc:	00853783          	ld	a5,8(a0)
    800024c0:	00078a63          	beqz	a5,800024d4 <_ZN8IOBuffer8peekBackEv+0x24>
    800024c4:	0087c503          	lbu	a0,8(a5)
}
    800024c8:	00813403          	ld	s0,8(sp)
    800024cc:	01010113          	addi	sp,sp,16
    800024d0:	00008067          	ret
    return tail ? tail->data : 0;
    800024d4:	00000513          	li	a0,0
    800024d8:	ff1ff06f          	j	800024c8 <_ZN8IOBuffer8peekBackEv+0x18>

00000000800024dc <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    800024dc:	ff010113          	addi	sp,sp,-16
    800024e0:	00813423          	sd	s0,8(sp)
    800024e4:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    800024e8:	00053783          	ld	a5,0(a0)
    800024ec:	00078a63          	beqz	a5,80002500 <_ZN8IOBuffer9peekFrontEv+0x24>
    800024f0:	0087c503          	lbu	a0,8(a5)
}
    800024f4:	00813403          	ld	s0,8(sp)
    800024f8:	01010113          	addi	sp,sp,16
    800024fc:	00008067          	ret
    return head ? head->data : 0;
    80002500:	00000513          	li	a0,0
    80002504:	ff1ff06f          	j	800024f4 <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080002508 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void*) {
    80002508:	fe010113          	addi	sp,sp,-32
    8000250c:	00113c23          	sd	ra,24(sp)
    80002510:	00813823          	sd	s0,16(sp)
    80002514:	00913423          	sd	s1,8(sp)
    80002518:	02010413          	addi	s0,sp,32
    8000251c:	00c0006f          	j	80002528 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	d54080e7          	jalr	-684(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002528:	00007797          	auipc	a5,0x7
    8000252c:	9487b783          	ld	a5,-1720(a5) # 80008e70 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002530:	0007b783          	ld	a5,0(a5)
    80002534:	0007c783          	lbu	a5,0(a5)
    80002538:	0207f793          	andi	a5,a5,32
    8000253c:	fe0782e3          	beqz	a5,80002520 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80002540:	00007517          	auipc	a0,0x7
    80002544:	ab850513          	addi	a0,a0,-1352 # 80008ff8 <_ZN3CCB12outputBufferE>
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	f94080e7          	jalr	-108(ra) # 800024dc <_ZN8IOBuffer9peekFrontEv>
    80002550:	fc0508e3          	beqz	a0,80002520 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80002554:	00007797          	auipc	a5,0x7
    80002558:	93c7b783          	ld	a5,-1732(a5) # 80008e90 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000255c:	0007b483          	ld	s1,0(a5)
    80002560:	00007517          	auipc	a0,0x7
    80002564:	a9850513          	addi	a0,a0,-1384 # 80008ff8 <_ZN3CCB12outputBufferE>
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	ee4080e7          	jalr	-284(ra) # 8000244c <_ZN8IOBuffer8popFrontEv>
    80002570:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    80002574:	00007517          	auipc	a0,0x7
    80002578:	a9453503          	ld	a0,-1388(a0) # 80009008 <_ZN3CCB9semOutputE>
    8000257c:	fffff097          	auipc	ra,0xfffff
    80002580:	e1c080e7          	jalr	-484(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002584:	fa5ff06f          	j	80002528 <_ZN3CCB10outputBodyEPv+0x20>

0000000080002588 <_ZN13SlabAllocator13initAllocatorEPvi>:
#include "../h/SlabAllocator.h"
#include "../h/BuddyAllocator.h"

void SlabAllocator::initAllocator(void *space, int blockNum) {
    80002588:	ff010113          	addi	sp,sp,-16
    8000258c:	00113423          	sd	ra,8(sp)
    80002590:	00813023          	sd	s0,0(sp)
    80002594:	01010413          	addi	s0,sp,16
    BuddyAllocator::initBuddy();
    80002598:	00000097          	auipc	ra,0x0
    8000259c:	ba8080e7          	jalr	-1112(ra) # 80002140 <_ZN14BuddyAllocator9initBuddyEv>
}
    800025a0:	00813083          	ld	ra,8(sp)
    800025a4:	00013403          	ld	s0,0(sp)
    800025a8:	01010113          	addi	sp,sp,16
    800025ac:	00008067          	ret

00000000800025b0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800025b0:	fc010113          	addi	sp,sp,-64
    800025b4:	02113c23          	sd	ra,56(sp)
    800025b8:	02813823          	sd	s0,48(sp)
    800025bc:	02913423          	sd	s1,40(sp)
    800025c0:	03213023          	sd	s2,32(sp)
    800025c4:	01313c23          	sd	s3,24(sp)
    800025c8:	01413823          	sd	s4,16(sp)
    800025cc:	01513423          	sd	s5,8(sp)
    800025d0:	04010413          	addi	s0,sp,64
    800025d4:	00050913          	mv	s2,a0
    800025d8:	00058993          	mv	s3,a1
    800025dc:	00060a13          	mv	s4,a2
    800025e0:	00068a93          	mv	s5,a3
    Cache* cache = (Cache*)BuddyAllocator::buddyAlloc(1);
    800025e4:	00100513          	li	a0,1
    800025e8:	00000097          	auipc	ra,0x0
    800025ec:	bb8080e7          	jalr	-1096(ra) # 800021a0 <_ZN14BuddyAllocator10buddyAllocEm>
    800025f0:	00050493          	mv	s1,a0
    cache->initCache(name, size, ctor, dtor);
    800025f4:	000a8713          	mv	a4,s5
    800025f8:	000a0693          	mv	a3,s4
    800025fc:	00098613          	mv	a2,s3
    80002600:	00090593          	mv	a1,s2
    80002604:	00001097          	auipc	ra,0x1
    80002608:	158080e7          	jalr	344(ra) # 8000375c <_ZN5Cache9initCacheEPKcmPFvPvES4_>

    return cache;
}
    8000260c:	00048513          	mv	a0,s1
    80002610:	03813083          	ld	ra,56(sp)
    80002614:	03013403          	ld	s0,48(sp)
    80002618:	02813483          	ld	s1,40(sp)
    8000261c:	02013903          	ld	s2,32(sp)
    80002620:	01813983          	ld	s3,24(sp)
    80002624:	01013a03          	ld	s4,16(sp)
    80002628:	00813a83          	ld	s5,8(sp)
    8000262c:	04010113          	addi	sp,sp,64
    80002630:	00008067          	ret

0000000080002634 <_ZN13SlabAllocator9allocSlotEP5Cache>:

void *SlabAllocator::allocSlot(Cache *cache) {
    80002634:	ff010113          	addi	sp,sp,-16
    80002638:	00113423          	sd	ra,8(sp)
    8000263c:	00813023          	sd	s0,0(sp)
    80002640:	01010413          	addi	s0,sp,16
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
    80002644:	00002097          	auipc	ra,0x2
    80002648:	814080e7          	jalr	-2028(ra) # 80003e58 <_ZN5Cache12allocateSlotEv>
}
    8000264c:	01850513          	addi	a0,a0,24
    80002650:	00813083          	ld	ra,8(sp)
    80002654:	00013403          	ld	s0,0(sp)
    80002658:	01010113          	addi	sp,sp,16
    8000265c:	00008067          	ret

0000000080002660 <_ZN13SlabAllocator8freeSlotEP5CachePv>:

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    80002660:	ff010113          	addi	sp,sp,-16
    80002664:	00113423          	sd	ra,8(sp)
    80002668:	00813023          	sd	s0,0(sp)
    8000266c:	01010413          	addi	s0,sp,16
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
    80002670:	fe858593          	addi	a1,a1,-24
    80002674:	00001097          	auipc	ra,0x1
    80002678:	66c080e7          	jalr	1644(ra) # 80003ce0 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    8000267c:	00813083          	ld	ra,8(sp)
    80002680:	00013403          	ld	s0,0(sp)
    80002684:	01010113          	addi	sp,sp,16
    80002688:	00008067          	ret

000000008000268c <_ZN13SlabAllocator17printErrorMessageEP5Cache>:

int SlabAllocator::printErrorMessage(Cache *cache) {
    8000268c:	ff010113          	addi	sp,sp,-16
    80002690:	00113423          	sd	ra,8(sp)
    80002694:	00813023          	sd	s0,0(sp)
    80002698:	01010413          	addi	s0,sp,16
    return cache->printErrorMessage();
    8000269c:	00001097          	auipc	ra,0x1
    800026a0:	2c8080e7          	jalr	712(ra) # 80003964 <_ZN5Cache17printErrorMessageEv>
}
    800026a4:	00813083          	ld	ra,8(sp)
    800026a8:	00013403          	ld	s0,0(sp)
    800026ac:	01010113          	addi	sp,sp,16
    800026b0:	00008067          	ret

00000000800026b4 <_ZN13SlabAllocator14printCacheInfoEP5Cache>:

void SlabAllocator::printCacheInfo(Cache *cache) {
    800026b4:	ff010113          	addi	sp,sp,-16
    800026b8:	00113423          	sd	ra,8(sp)
    800026bc:	00813023          	sd	s0,0(sp)
    800026c0:	01010413          	addi	s0,sp,16
    cache->printCacheInfo();
    800026c4:	00001097          	auipc	ra,0x1
    800026c8:	360080e7          	jalr	864(ra) # 80003a24 <_ZN5Cache14printCacheInfoEv>
}
    800026cc:	00813083          	ld	ra,8(sp)
    800026d0:	00013403          	ld	s0,0(sp)
    800026d4:	01010113          	addi	sp,sp,16
    800026d8:	00008067          	ret

00000000800026dc <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>:

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    800026dc:	ff010113          	addi	sp,sp,-16
    800026e0:	00113423          	sd	ra,8(sp)
    800026e4:	00813023          	sd	s0,0(sp)
    800026e8:	01010413          	addi	s0,sp,16
    return cache->deallocFreeSlabs();
    800026ec:	00001097          	auipc	ra,0x1
    800026f0:	4d0080e7          	jalr	1232(ra) # 80003bbc <_ZN5Cache16deallocFreeSlabsEv>
}
    800026f4:	00813083          	ld	ra,8(sp)
    800026f8:	00013403          	ld	s0,0(sp)
    800026fc:	01010113          	addi	sp,sp,16
    80002700:	00008067          	ret

0000000080002704 <_ZN13SlabAllocator12deallocCacheEP5Cache>:

void SlabAllocator::deallocCache(Cache *cache) {
    80002704:	ff010113          	addi	sp,sp,-16
    80002708:	00113423          	sd	ra,8(sp)
    8000270c:	00813023          	sd	s0,0(sp)
    80002710:	01010413          	addi	s0,sp,16
    cache->deallocCache();
    80002714:	00001097          	auipc	ra,0x1
    80002718:	514080e7          	jalr	1300(ra) # 80003c28 <_ZN5Cache12deallocCacheEv>
}
    8000271c:	00813083          	ld	ra,8(sp)
    80002720:	00013403          	ld	s0,0(sp)
    80002724:	01010113          	addi	sp,sp,16
    80002728:	00008067          	ret

000000008000272c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000272c:	fe010113          	addi	sp,sp,-32
    80002730:	00113c23          	sd	ra,24(sp)
    80002734:	00813823          	sd	s0,16(sp)
    80002738:	00913423          	sd	s1,8(sp)
    8000273c:	02010413          	addi	s0,sp,32
    80002740:	00050493          	mv	s1,a0
    LOCK();
    80002744:	00100613          	li	a2,1
    80002748:	00000593          	li	a1,0
    8000274c:	00007517          	auipc	a0,0x7
    80002750:	8d450513          	addi	a0,a0,-1836 # 80009020 <lockPrint>
    80002754:	fffff097          	auipc	ra,0xfffff
    80002758:	9fc080e7          	jalr	-1540(ra) # 80001150 <copy_and_swap>
    8000275c:	fe0514e3          	bnez	a0,80002744 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002760:	0004c503          	lbu	a0,0(s1)
    80002764:	00050a63          	beqz	a0,80002778 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002768:	fffff097          	auipc	ra,0xfffff
    8000276c:	d70080e7          	jalr	-656(ra) # 800014d8 <_Z4putcc>
        string++;
    80002770:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002774:	fedff06f          	j	80002760 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002778:	00000613          	li	a2,0
    8000277c:	00100593          	li	a1,1
    80002780:	00007517          	auipc	a0,0x7
    80002784:	8a050513          	addi	a0,a0,-1888 # 80009020 <lockPrint>
    80002788:	fffff097          	auipc	ra,0xfffff
    8000278c:	9c8080e7          	jalr	-1592(ra) # 80001150 <copy_and_swap>
    80002790:	fe0514e3          	bnez	a0,80002778 <_Z11printStringPKc+0x4c>
}
    80002794:	01813083          	ld	ra,24(sp)
    80002798:	01013403          	ld	s0,16(sp)
    8000279c:	00813483          	ld	s1,8(sp)
    800027a0:	02010113          	addi	sp,sp,32
    800027a4:	00008067          	ret

00000000800027a8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800027a8:	fd010113          	addi	sp,sp,-48
    800027ac:	02113423          	sd	ra,40(sp)
    800027b0:	02813023          	sd	s0,32(sp)
    800027b4:	00913c23          	sd	s1,24(sp)
    800027b8:	01213823          	sd	s2,16(sp)
    800027bc:	01313423          	sd	s3,8(sp)
    800027c0:	01413023          	sd	s4,0(sp)
    800027c4:	03010413          	addi	s0,sp,48
    800027c8:	00050993          	mv	s3,a0
    800027cc:	00058a13          	mv	s4,a1
    LOCK();
    800027d0:	00100613          	li	a2,1
    800027d4:	00000593          	li	a1,0
    800027d8:	00007517          	auipc	a0,0x7
    800027dc:	84850513          	addi	a0,a0,-1976 # 80009020 <lockPrint>
    800027e0:	fffff097          	auipc	ra,0xfffff
    800027e4:	970080e7          	jalr	-1680(ra) # 80001150 <copy_and_swap>
    800027e8:	fe0514e3          	bnez	a0,800027d0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800027ec:	00000913          	li	s2,0
    800027f0:	00090493          	mv	s1,s2
    800027f4:	0019091b          	addiw	s2,s2,1
    800027f8:	03495a63          	bge	s2,s4,8000282c <_Z9getStringPci+0x84>
        cc = getc();
    800027fc:	fffff097          	auipc	ra,0xfffff
    80002800:	cac080e7          	jalr	-852(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80002804:	02050463          	beqz	a0,8000282c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002808:	009984b3          	add	s1,s3,s1
    8000280c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002810:	00a00793          	li	a5,10
    80002814:	00f50a63          	beq	a0,a5,80002828 <_Z9getStringPci+0x80>
    80002818:	00d00793          	li	a5,13
    8000281c:	fcf51ae3          	bne	a0,a5,800027f0 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002820:	00090493          	mv	s1,s2
    80002824:	0080006f          	j	8000282c <_Z9getStringPci+0x84>
    80002828:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000282c:	009984b3          	add	s1,s3,s1
    80002830:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002834:	00000613          	li	a2,0
    80002838:	00100593          	li	a1,1
    8000283c:	00006517          	auipc	a0,0x6
    80002840:	7e450513          	addi	a0,a0,2020 # 80009020 <lockPrint>
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	90c080e7          	jalr	-1780(ra) # 80001150 <copy_and_swap>
    8000284c:	fe0514e3          	bnez	a0,80002834 <_Z9getStringPci+0x8c>
    return buf;
}
    80002850:	00098513          	mv	a0,s3
    80002854:	02813083          	ld	ra,40(sp)
    80002858:	02013403          	ld	s0,32(sp)
    8000285c:	01813483          	ld	s1,24(sp)
    80002860:	01013903          	ld	s2,16(sp)
    80002864:	00813983          	ld	s3,8(sp)
    80002868:	00013a03          	ld	s4,0(sp)
    8000286c:	03010113          	addi	sp,sp,48
    80002870:	00008067          	ret

0000000080002874 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002874:	ff010113          	addi	sp,sp,-16
    80002878:	00813423          	sd	s0,8(sp)
    8000287c:	01010413          	addi	s0,sp,16
    80002880:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002884:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002888:	0006c603          	lbu	a2,0(a3)
    8000288c:	fd06071b          	addiw	a4,a2,-48
    80002890:	0ff77713          	andi	a4,a4,255
    80002894:	00900793          	li	a5,9
    80002898:	02e7e063          	bltu	a5,a4,800028b8 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000289c:	0025179b          	slliw	a5,a0,0x2
    800028a0:	00a787bb          	addw	a5,a5,a0
    800028a4:	0017979b          	slliw	a5,a5,0x1
    800028a8:	00168693          	addi	a3,a3,1
    800028ac:	00c787bb          	addw	a5,a5,a2
    800028b0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800028b4:	fd5ff06f          	j	80002888 <_Z11stringToIntPKc+0x14>
    return n;
}
    800028b8:	00813403          	ld	s0,8(sp)
    800028bc:	01010113          	addi	sp,sp,16
    800028c0:	00008067          	ret

00000000800028c4 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800028c4:	fc010113          	addi	sp,sp,-64
    800028c8:	02113c23          	sd	ra,56(sp)
    800028cc:	02813823          	sd	s0,48(sp)
    800028d0:	02913423          	sd	s1,40(sp)
    800028d4:	03213023          	sd	s2,32(sp)
    800028d8:	01313c23          	sd	s3,24(sp)
    800028dc:	04010413          	addi	s0,sp,64
    800028e0:	00050493          	mv	s1,a0
    800028e4:	00058913          	mv	s2,a1
    800028e8:	00060993          	mv	s3,a2
    LOCK();
    800028ec:	00100613          	li	a2,1
    800028f0:	00000593          	li	a1,0
    800028f4:	00006517          	auipc	a0,0x6
    800028f8:	72c50513          	addi	a0,a0,1836 # 80009020 <lockPrint>
    800028fc:	fffff097          	auipc	ra,0xfffff
    80002900:	854080e7          	jalr	-1964(ra) # 80001150 <copy_and_swap>
    80002904:	fe0514e3          	bnez	a0,800028ec <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002908:	00098463          	beqz	s3,80002910 <_Z8printIntiii+0x4c>
    8000290c:	0804c463          	bltz	s1,80002994 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002910:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002914:	00000593          	li	a1,0
    }

    i = 0;
    80002918:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000291c:	0009079b          	sext.w	a5,s2
    80002920:	0325773b          	remuw	a4,a0,s2
    80002924:	00048613          	mv	a2,s1
    80002928:	0014849b          	addiw	s1,s1,1
    8000292c:	02071693          	slli	a3,a4,0x20
    80002930:	0206d693          	srli	a3,a3,0x20
    80002934:	00006717          	auipc	a4,0x6
    80002938:	49470713          	addi	a4,a4,1172 # 80008dc8 <digits>
    8000293c:	00d70733          	add	a4,a4,a3
    80002940:	00074683          	lbu	a3,0(a4)
    80002944:	fd040713          	addi	a4,s0,-48
    80002948:	00c70733          	add	a4,a4,a2
    8000294c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002950:	0005071b          	sext.w	a4,a0
    80002954:	0325553b          	divuw	a0,a0,s2
    80002958:	fcf772e3          	bgeu	a4,a5,8000291c <_Z8printIntiii+0x58>
    if(neg)
    8000295c:	00058c63          	beqz	a1,80002974 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002960:	fd040793          	addi	a5,s0,-48
    80002964:	009784b3          	add	s1,a5,s1
    80002968:	02d00793          	li	a5,45
    8000296c:	fef48823          	sb	a5,-16(s1)
    80002970:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002974:	fff4849b          	addiw	s1,s1,-1
    80002978:	0204c463          	bltz	s1,800029a0 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000297c:	fd040793          	addi	a5,s0,-48
    80002980:	009787b3          	add	a5,a5,s1
    80002984:	ff07c503          	lbu	a0,-16(a5)
    80002988:	fffff097          	auipc	ra,0xfffff
    8000298c:	b50080e7          	jalr	-1200(ra) # 800014d8 <_Z4putcc>
    80002990:	fe5ff06f          	j	80002974 <_Z8printIntiii+0xb0>
        x = -xx;
    80002994:	4090053b          	negw	a0,s1
        neg = 1;
    80002998:	00100593          	li	a1,1
        x = -xx;
    8000299c:	f7dff06f          	j	80002918 <_Z8printIntiii+0x54>

    UNLOCK();
    800029a0:	00000613          	li	a2,0
    800029a4:	00100593          	li	a1,1
    800029a8:	00006517          	auipc	a0,0x6
    800029ac:	67850513          	addi	a0,a0,1656 # 80009020 <lockPrint>
    800029b0:	ffffe097          	auipc	ra,0xffffe
    800029b4:	7a0080e7          	jalr	1952(ra) # 80001150 <copy_and_swap>
    800029b8:	fe0514e3          	bnez	a0,800029a0 <_Z8printIntiii+0xdc>
    800029bc:	03813083          	ld	ra,56(sp)
    800029c0:	03013403          	ld	s0,48(sp)
    800029c4:	02813483          	ld	s1,40(sp)
    800029c8:	02013903          	ld	s2,32(sp)
    800029cc:	01813983          	ld	s3,24(sp)
    800029d0:	04010113          	addi	sp,sp,64
    800029d4:	00008067          	ret

00000000800029d8 <_Z8userMainv>:
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
#include "../h/slab.h"
void userMain() {
    800029d8:	ff010113          	addi	sp,sp,-16
    800029dc:	00113423          	sd	ra,8(sp)
    800029e0:	00813023          	sd	s0,0(sp)
    800029e4:	01010413          	addi	s0,sp,16
    printString("Hello world!");
    800029e8:	00004517          	auipc	a0,0x4
    800029ec:	76050513          	addi	a0,a0,1888 # 80007148 <CONSOLE_STATUS+0x138>
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	d3c080e7          	jalr	-708(ra) # 8000272c <_Z11printStringPKc>

    800029f8:	00813083          	ld	ra,8(sp)
    800029fc:	00013403          	ld	s0,0(sp)
    80002a00:	01010113          	addi	sp,sp,16
    80002a04:	00008067          	ret

0000000080002a08 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002a08:	ff010113          	addi	sp,sp,-16
    80002a0c:	00813423          	sd	s0,8(sp)
    80002a10:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002a14:	02050663          	beqz	a0,80002a40 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002a18:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002a1c:	00006797          	auipc	a5,0x6
    80002a20:	60c7b783          	ld	a5,1548(a5) # 80009028 <_ZN9Scheduler4tailE>
    80002a24:	02078463          	beqz	a5,80002a4c <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002a28:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002a2c:	00006797          	auipc	a5,0x6
    80002a30:	5fc78793          	addi	a5,a5,1532 # 80009028 <_ZN9Scheduler4tailE>
    80002a34:	0007b703          	ld	a4,0(a5)
    80002a38:	00073703          	ld	a4,0(a4)
    80002a3c:	00e7b023          	sd	a4,0(a5)
    }
}
    80002a40:	00813403          	ld	s0,8(sp)
    80002a44:	01010113          	addi	sp,sp,16
    80002a48:	00008067          	ret
        head = tail = process;
    80002a4c:	00006797          	auipc	a5,0x6
    80002a50:	5dc78793          	addi	a5,a5,1500 # 80009028 <_ZN9Scheduler4tailE>
    80002a54:	00a7b023          	sd	a0,0(a5)
    80002a58:	00a7b423          	sd	a0,8(a5)
    80002a5c:	fe5ff06f          	j	80002a40 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002a60 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002a60:	ff010113          	addi	sp,sp,-16
    80002a64:	00813423          	sd	s0,8(sp)
    80002a68:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002a6c:	00006517          	auipc	a0,0x6
    80002a70:	5c453503          	ld	a0,1476(a0) # 80009030 <_ZN9Scheduler4headE>
    80002a74:	02050463          	beqz	a0,80002a9c <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002a78:	00053703          	ld	a4,0(a0)
    80002a7c:	00006797          	auipc	a5,0x6
    80002a80:	5ac78793          	addi	a5,a5,1452 # 80009028 <_ZN9Scheduler4tailE>
    80002a84:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002a88:	0007b783          	ld	a5,0(a5)
    80002a8c:	00f50e63          	beq	a0,a5,80002aa8 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002a90:	00813403          	ld	s0,8(sp)
    80002a94:	01010113          	addi	sp,sp,16
    80002a98:	00008067          	ret
        return idleProcess;
    80002a9c:	00006517          	auipc	a0,0x6
    80002aa0:	59c53503          	ld	a0,1436(a0) # 80009038 <_ZN9Scheduler11idleProcessE>
    80002aa4:	fedff06f          	j	80002a90 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002aa8:	00006797          	auipc	a5,0x6
    80002aac:	58e7b023          	sd	a4,1408(a5) # 80009028 <_ZN9Scheduler4tailE>
    80002ab0:	fe1ff06f          	j	80002a90 <_ZN9Scheduler3getEv+0x30>

0000000080002ab4 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002ab4:	ff010113          	addi	sp,sp,-16
    80002ab8:	00813423          	sd	s0,8(sp)
    80002abc:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002ac0:	00050e63          	beqz	a0,80002adc <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002ac4:	00006797          	auipc	a5,0x6
    80002ac8:	56c7b783          	ld	a5,1388(a5) # 80009030 <_ZN9Scheduler4headE>
    80002acc:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002ad0:	00078c63          	beqz	a5,80002ae8 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002ad4:	00006797          	auipc	a5,0x6
    80002ad8:	54a7be23          	sd	a0,1372(a5) # 80009030 <_ZN9Scheduler4headE>
    }
}
    80002adc:	00813403          	ld	s0,8(sp)
    80002ae0:	01010113          	addi	sp,sp,16
    80002ae4:	00008067          	ret
        head = tail = process;
    80002ae8:	00006797          	auipc	a5,0x6
    80002aec:	54078793          	addi	a5,a5,1344 # 80009028 <_ZN9Scheduler4tailE>
    80002af0:	00a7b023          	sd	a0,0(a5)
    80002af4:	00a7b423          	sd	a0,8(a5)
    80002af8:	fe5ff06f          	j	80002adc <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002afc <idleProcess>:
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002afc:	ff010113          	addi	sp,sp,-16
    80002b00:	00813423          	sd	s0,8(sp)
    80002b04:	01010413          	addi	s0,sp,16
    while(true) {}
    80002b08:	0000006f          	j	80002b08 <idleProcess+0xc>

0000000080002b0c <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    80002b0c:	ff010113          	addi	sp,sp,-16
    80002b10:	00113423          	sd	ra,8(sp)
    80002b14:	00813023          	sd	s0,0(sp)
    80002b18:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	ebc080e7          	jalr	-324(ra) # 800029d8 <_Z8userMainv>
}
    80002b24:	00813083          	ld	ra,8(sp)
    80002b28:	00013403          	ld	s0,0(sp)
    80002b2c:	01010113          	addi	sp,sp,16
    80002b30:	00008067          	ret

0000000080002b34 <_Z8userModev>:
void userMode() {
    80002b34:	ff010113          	addi	sp,sp,-16
    80002b38:	00813423          	sd	s0,8(sp)
    80002b3c:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80002b40:	04300793          	li	a5,67
    80002b44:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002b48:	00000073          	ecall
}
    80002b4c:	00813403          	ld	s0,8(sp)
    80002b50:	01010113          	addi	sp,sp,16
    80002b54:	00008067          	ret

0000000080002b58 <main>:
}
// ------------

int main() {
    80002b58:	ff010113          	addi	sp,sp,-16
    80002b5c:	00113423          	sd	ra,8(sp)
    80002b60:	00813023          	sd	s0,0(sp)
    80002b64:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002b68:	00006797          	auipc	a5,0x6
    80002b6c:	3807b783          	ld	a5,896(a5) # 80008ee8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002b70:	10579073          	csrw	stvec,a5
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);
    80002b74:	010005b7          	lui	a1,0x1000
    80002b78:	00006797          	auipc	a5,0x6
    80002b7c:	3007b783          	ld	a5,768(a5) # 80008e78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002b80:	0007b503          	ld	a0,0(a5)
    80002b84:	00001097          	auipc	ra,0x1
    80002b88:	658080e7          	jalr	1624(ra) # 800041dc <_Z9kmem_initPvi>

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002b8c:	00000593          	li	a1,0
    80002b90:	00000513          	li	a0,0
    80002b94:	fffff097          	auipc	ra,0xfffff
    80002b98:	258080e7          	jalr	600(ra) # 80001dec <_ZN3PCB16createSysProcessEPFvvEPv>
    PCB::running = main;
    80002b9c:	00006797          	auipc	a5,0x6
    80002ba0:	3247b783          	ld	a5,804(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002ba4:	00a7b023          	sd	a0,0(a5)
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002ba8:	00000613          	li	a2,0
    80002bac:	00006597          	auipc	a1,0x6
    80002bb0:	2fc5b583          	ld	a1,764(a1) # 80008ea8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002bb4:	00006517          	auipc	a0,0x6
    80002bb8:	34c53503          	ld	a0,844(a0) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002bbc:	ffffe097          	auipc	ra,0xffffe
    80002bc0:	744080e7          	jalr	1860(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002bc4:	00000613          	li	a2,0
    80002bc8:	00006597          	auipc	a1,0x6
    80002bcc:	3305b583          	ld	a1,816(a1) # 80008ef8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002bd0:	00006517          	auipc	a0,0x6
    80002bd4:	29853503          	ld	a0,664(a0) # 80008e68 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002bd8:	ffffe097          	auipc	ra,0xffffe
    80002bdc:	728080e7          	jalr	1832(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002be0:	00000613          	li	a2,0
    80002be4:	00000597          	auipc	a1,0x0
    80002be8:	f1858593          	addi	a1,a1,-232 # 80002afc <idleProcess>
    80002bec:	00006517          	auipc	a0,0x6
    80002bf0:	2cc53503          	ld	a0,716(a0) # 80008eb8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bf4:	ffffe097          	auipc	ra,0xffffe
    80002bf8:	614080e7          	jalr	1556(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80002bfc:	00006797          	auipc	a5,0x6
    80002c00:	2bc7b783          	ld	a5,700(a5) # 80008eb8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c04:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    80002c08:	00100713          	li	a4,1
    80002c0c:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    80002c10:	00100713          	li	a4,1
    80002c14:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    80002c18:	00000593          	li	a1,0
    80002c1c:	00006517          	auipc	a0,0x6
    80002c20:	2d453503          	ld	a0,724(a0) # 80008ef0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002c24:	ffffe097          	auipc	ra,0xffffe
    80002c28:	72c080e7          	jalr	1836(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    80002c2c:	00000593          	li	a1,0
    80002c30:	00006517          	auipc	a0,0x6
    80002c34:	2a053503          	ld	a0,672(a0) # 80008ed0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002c38:	ffffe097          	auipc	ra,0xffffe
    80002c3c:	718080e7          	jalr	1816(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);
    80002c40:	00000593          	li	a1,0
    80002c44:	00006517          	auipc	a0,0x6
    80002c48:	29c53503          	ld	a0,668(a0) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c4c:	ffffe097          	auipc	ra,0xffffe
    80002c50:	704080e7          	jalr	1796(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002c54:	00200793          	li	a5,2
    80002c58:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&userProcess, userMainWrapper, nullptr);
    80002c5c:	00000613          	li	a2,0
    80002c60:	00000597          	auipc	a1,0x0
    80002c64:	eac58593          	addi	a1,a1,-340 # 80002b0c <_Z15userMainWrapperPv>
    80002c68:	00006517          	auipc	a0,0x6
    80002c6c:	3d850513          	addi	a0,a0,984 # 80009040 <userProcess>
    80002c70:	ffffe097          	auipc	ra,0xffffe
    80002c74:	690080e7          	jalr	1680(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----
    kmem_cache_info(PCB::pcbCache);
    80002c78:	00006797          	auipc	a5,0x6
    80002c7c:	2387b783          	ld	a5,568(a5) # 80008eb0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002c80:	0007b503          	ld	a0,0(a5)
    80002c84:	00001097          	auipc	ra,0x1
    80002c88:	648080e7          	jalr	1608(ra) # 800042cc <_Z15kmem_cache_infoP12kmem_cache_s>
    kmem_cache_info(SCB::scbCache);
    80002c8c:	00006797          	auipc	a5,0x6
    80002c90:	24c7b783          	ld	a5,588(a5) # 80008ed8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002c94:	0007b503          	ld	a0,0(a5)
    80002c98:	00001097          	auipc	ra,0x1
    80002c9c:	634080e7          	jalr	1588(ra) # 800042cc <_Z15kmem_cache_infoP12kmem_cache_s>
    while(!userProcess->isFinished()) {
    80002ca0:	00006797          	auipc	a5,0x6
    80002ca4:	3a07b783          	ld	a5,928(a5) # 80009040 <userProcess>
        return finished;
    80002ca8:	0287c783          	lbu	a5,40(a5)
    80002cac:	00079863          	bnez	a5,80002cbc <main+0x164>
        thread_dispatch();
    80002cb0:	ffffe097          	auipc	ra,0xffffe
    80002cb4:	5c4080e7          	jalr	1476(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    80002cb8:	fe9ff06f          	j	80002ca0 <main+0x148>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    80002cbc:	00006797          	auipc	a5,0x6
    80002cc0:	2147b783          	ld	a5,532(a5) # 80008ed0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002cc4:	0007b783          	ld	a5,0(a5)
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    80002cc8:	0107a783          	lw	a5,16(a5)
    80002ccc:	00078863          	beqz	a5,80002cdc <main+0x184>
        thread_dispatch();
    80002cd0:	ffffe097          	auipc	ra,0xffffe
    80002cd4:	5a4080e7          	jalr	1444(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    80002cd8:	fe5ff06f          	j	80002cbc <main+0x164>
    }
    return 0;
    80002cdc:	00000513          	li	a0,0
    80002ce0:	00813083          	ld	ra,8(sp)
    80002ce4:	00013403          	ld	s0,0(sp)
    80002ce8:	01010113          	addi	sp,sp,16
    80002cec:	00008067          	ret

0000000080002cf0 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002cf0:	fe010113          	addi	sp,sp,-32
    80002cf4:	00113c23          	sd	ra,24(sp)
    80002cf8:	00813823          	sd	s0,16(sp)
    80002cfc:	00913423          	sd	s1,8(sp)
    80002d00:	02010413          	addi	s0,sp,32
    80002d04:	00006797          	auipc	a5,0x6
    80002d08:	11c78793          	addi	a5,a5,284 # 80008e20 <_ZTV6Thread+0x10>
    80002d0c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002d10:	00853483          	ld	s1,8(a0)
    80002d14:	00048e63          	beqz	s1,80002d30 <_ZN6ThreadD1Ev+0x40>
    80002d18:	00048513          	mv	a0,s1
    80002d1c:	fffff097          	auipc	ra,0xfffff
    80002d20:	e68080e7          	jalr	-408(ra) # 80001b84 <_ZN3PCBD1Ev>
    80002d24:	00048513          	mv	a0,s1
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	ed0080e7          	jalr	-304(ra) # 80001bf8 <_ZN3PCBdlEPv>
}
    80002d30:	01813083          	ld	ra,24(sp)
    80002d34:	01013403          	ld	s0,16(sp)
    80002d38:	00813483          	ld	s1,8(sp)
    80002d3c:	02010113          	addi	sp,sp,32
    80002d40:	00008067          	ret

0000000080002d44 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002d44:	ff010113          	addi	sp,sp,-16
    80002d48:	00113423          	sd	ra,8(sp)
    80002d4c:	00813023          	sd	s0,0(sp)
    80002d50:	01010413          	addi	s0,sp,16
    80002d54:	00006797          	auipc	a5,0x6
    80002d58:	0f478793          	addi	a5,a5,244 # 80008e48 <_ZTV9Semaphore+0x10>
    80002d5c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002d60:	00853503          	ld	a0,8(a0)
    80002d64:	ffffe097          	auipc	ra,0xffffe
    80002d68:	6bc080e7          	jalr	1724(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80002d6c:	00813083          	ld	ra,8(sp)
    80002d70:	00013403          	ld	s0,0(sp)
    80002d74:	01010113          	addi	sp,sp,16
    80002d78:	00008067          	ret

0000000080002d7c <_Znwm>:
void* operator new (size_t size) {
    80002d7c:	ff010113          	addi	sp,sp,-16
    80002d80:	00113423          	sd	ra,8(sp)
    80002d84:	00813023          	sd	s0,0(sp)
    80002d88:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002d8c:	ffffe097          	auipc	ra,0xffffe
    80002d90:	408080e7          	jalr	1032(ra) # 80001194 <_Z9mem_allocm>
}
    80002d94:	00813083          	ld	ra,8(sp)
    80002d98:	00013403          	ld	s0,0(sp)
    80002d9c:	01010113          	addi	sp,sp,16
    80002da0:	00008067          	ret

0000000080002da4 <_Znam>:
void* operator new [](size_t size) {
    80002da4:	ff010113          	addi	sp,sp,-16
    80002da8:	00113423          	sd	ra,8(sp)
    80002dac:	00813023          	sd	s0,0(sp)
    80002db0:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002db4:	ffffe097          	auipc	ra,0xffffe
    80002db8:	3e0080e7          	jalr	992(ra) # 80001194 <_Z9mem_allocm>
}
    80002dbc:	00813083          	ld	ra,8(sp)
    80002dc0:	00013403          	ld	s0,0(sp)
    80002dc4:	01010113          	addi	sp,sp,16
    80002dc8:	00008067          	ret

0000000080002dcc <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002dcc:	ff010113          	addi	sp,sp,-16
    80002dd0:	00113423          	sd	ra,8(sp)
    80002dd4:	00813023          	sd	s0,0(sp)
    80002dd8:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002ddc:	ffffe097          	auipc	ra,0xffffe
    80002de0:	3f8080e7          	jalr	1016(ra) # 800011d4 <_Z8mem_freePv>
}
    80002de4:	00813083          	ld	ra,8(sp)
    80002de8:	00013403          	ld	s0,0(sp)
    80002dec:	01010113          	addi	sp,sp,16
    80002df0:	00008067          	ret

0000000080002df4 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002df4:	fe010113          	addi	sp,sp,-32
    80002df8:	00113c23          	sd	ra,24(sp)
    80002dfc:	00813823          	sd	s0,16(sp)
    80002e00:	00913423          	sd	s1,8(sp)
    80002e04:	02010413          	addi	s0,sp,32
    80002e08:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002e0c:	00053503          	ld	a0,0(a0)
    80002e10:	0104b783          	ld	a5,16(s1)
    80002e14:	00f50533          	add	a0,a0,a5
    80002e18:	0084b783          	ld	a5,8(s1)
    80002e1c:	0017f713          	andi	a4,a5,1
    80002e20:	00070863          	beqz	a4,80002e30 <_Z13threadWrapperPv+0x3c>
    80002e24:	00053703          	ld	a4,0(a0)
    80002e28:	00f707b3          	add	a5,a4,a5
    80002e2c:	fff7b783          	ld	a5,-1(a5)
    80002e30:	000780e7          	jalr	a5
    delete tArg;
    80002e34:	00048863          	beqz	s1,80002e44 <_Z13threadWrapperPv+0x50>
    80002e38:	00048513          	mv	a0,s1
    80002e3c:	00000097          	auipc	ra,0x0
    80002e40:	f90080e7          	jalr	-112(ra) # 80002dcc <_ZdlPv>
}
    80002e44:	01813083          	ld	ra,24(sp)
    80002e48:	01013403          	ld	s0,16(sp)
    80002e4c:	00813483          	ld	s1,8(sp)
    80002e50:	02010113          	addi	sp,sp,32
    80002e54:	00008067          	ret

0000000080002e58 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002e58:	ff010113          	addi	sp,sp,-16
    80002e5c:	00113423          	sd	ra,8(sp)
    80002e60:	00813023          	sd	s0,0(sp)
    80002e64:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002e68:	ffffe097          	auipc	ra,0xffffe
    80002e6c:	36c080e7          	jalr	876(ra) # 800011d4 <_Z8mem_freePv>
}
    80002e70:	00813083          	ld	ra,8(sp)
    80002e74:	00013403          	ld	s0,0(sp)
    80002e78:	01010113          	addi	sp,sp,16
    80002e7c:	00008067          	ret

0000000080002e80 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002e80:	ff010113          	addi	sp,sp,-16
    80002e84:	00113423          	sd	ra,8(sp)
    80002e88:	00813023          	sd	s0,0(sp)
    80002e8c:	01010413          	addi	s0,sp,16
    80002e90:	00006797          	auipc	a5,0x6
    80002e94:	f9078793          	addi	a5,a5,-112 # 80008e20 <_ZTV6Thread+0x10>
    80002e98:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002e9c:	00850513          	addi	a0,a0,8
    80002ea0:	ffffe097          	auipc	ra,0xffffe
    80002ea4:	368080e7          	jalr	872(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002ea8:	00813083          	ld	ra,8(sp)
    80002eac:	00013403          	ld	s0,0(sp)
    80002eb0:	01010113          	addi	sp,sp,16
    80002eb4:	00008067          	ret

0000000080002eb8 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002eb8:	ff010113          	addi	sp,sp,-16
    80002ebc:	00113423          	sd	ra,8(sp)
    80002ec0:	00813023          	sd	s0,0(sp)
    80002ec4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002ec8:	00001097          	auipc	ra,0x1
    80002ecc:	ff0080e7          	jalr	-16(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002ed0:	00813083          	ld	ra,8(sp)
    80002ed4:	00013403          	ld	s0,0(sp)
    80002ed8:	01010113          	addi	sp,sp,16
    80002edc:	00008067          	ret

0000000080002ee0 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002ee0:	ff010113          	addi	sp,sp,-16
    80002ee4:	00113423          	sd	ra,8(sp)
    80002ee8:	00813023          	sd	s0,0(sp)
    80002eec:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002ef0:	00001097          	auipc	ra,0x1
    80002ef4:	138080e7          	jalr	312(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002ef8:	00813083          	ld	ra,8(sp)
    80002efc:	00013403          	ld	s0,0(sp)
    80002f00:	01010113          	addi	sp,sp,16
    80002f04:	00008067          	ret

0000000080002f08 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002f08:	fe010113          	addi	sp,sp,-32
    80002f0c:	00113c23          	sd	ra,24(sp)
    80002f10:	00813823          	sd	s0,16(sp)
    80002f14:	00913423          	sd	s1,8(sp)
    80002f18:	02010413          	addi	s0,sp,32
    80002f1c:	00050493          	mv	s1,a0
}
    80002f20:	00000097          	auipc	ra,0x0
    80002f24:	dd0080e7          	jalr	-560(ra) # 80002cf0 <_ZN6ThreadD1Ev>
    80002f28:	00048513          	mv	a0,s1
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	fb4080e7          	jalr	-76(ra) # 80002ee0 <_ZN6ThreaddlEPv>
    80002f34:	01813083          	ld	ra,24(sp)
    80002f38:	01013403          	ld	s0,16(sp)
    80002f3c:	00813483          	ld	s1,8(sp)
    80002f40:	02010113          	addi	sp,sp,32
    80002f44:	00008067          	ret

0000000080002f48 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002f48:	ff010113          	addi	sp,sp,-16
    80002f4c:	00113423          	sd	ra,8(sp)
    80002f50:	00813023          	sd	s0,0(sp)
    80002f54:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002f58:	ffffe097          	auipc	ra,0xffffe
    80002f5c:	31c080e7          	jalr	796(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002f60:	00813083          	ld	ra,8(sp)
    80002f64:	00013403          	ld	s0,0(sp)
    80002f68:	01010113          	addi	sp,sp,16
    80002f6c:	00008067          	ret

0000000080002f70 <_ZN6Thread5startEv>:
int Thread::start() {
    80002f70:	ff010113          	addi	sp,sp,-16
    80002f74:	00113423          	sd	ra,8(sp)
    80002f78:	00813023          	sd	s0,0(sp)
    80002f7c:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002f80:	00850513          	addi	a0,a0,8
    80002f84:	ffffe097          	auipc	ra,0xffffe
    80002f88:	34c080e7          	jalr	844(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002f8c:	00000513          	li	a0,0
    80002f90:	00813083          	ld	ra,8(sp)
    80002f94:	00013403          	ld	s0,0(sp)
    80002f98:	01010113          	addi	sp,sp,16
    80002f9c:	00008067          	ret

0000000080002fa0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002fa0:	fe010113          	addi	sp,sp,-32
    80002fa4:	00113c23          	sd	ra,24(sp)
    80002fa8:	00813823          	sd	s0,16(sp)
    80002fac:	00913423          	sd	s1,8(sp)
    80002fb0:	02010413          	addi	s0,sp,32
    80002fb4:	00050493          	mv	s1,a0
    80002fb8:	00006797          	auipc	a5,0x6
    80002fbc:	e6878793          	addi	a5,a5,-408 # 80008e20 <_ZTV6Thread+0x10>
    80002fc0:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002fc4:	01800513          	li	a0,24
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	db4080e7          	jalr	-588(ra) # 80002d7c <_Znwm>
    80002fd0:	00050613          	mv	a2,a0
    80002fd4:	00953023          	sd	s1,0(a0)
    80002fd8:	01100793          	li	a5,17
    80002fdc:	00f53423          	sd	a5,8(a0)
    80002fe0:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002fe4:	00000597          	auipc	a1,0x0
    80002fe8:	e1058593          	addi	a1,a1,-496 # 80002df4 <_Z13threadWrapperPv>
    80002fec:	00848513          	addi	a0,s1,8
    80002ff0:	ffffe097          	auipc	ra,0xffffe
    80002ff4:	218080e7          	jalr	536(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002ff8:	01813083          	ld	ra,24(sp)
    80002ffc:	01013403          	ld	s0,16(sp)
    80003000:	00813483          	ld	s1,8(sp)
    80003004:	02010113          	addi	sp,sp,32
    80003008:	00008067          	ret

000000008000300c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000300c:	ff010113          	addi	sp,sp,-16
    80003010:	00113423          	sd	ra,8(sp)
    80003014:	00813023          	sd	s0,0(sp)
    80003018:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000301c:	ffffe097          	auipc	ra,0xffffe
    80003020:	444080e7          	jalr	1092(ra) # 80001460 <_Z10time_sleepm>
}
    80003024:	00813083          	ld	ra,8(sp)
    80003028:	00013403          	ld	s0,0(sp)
    8000302c:	01010113          	addi	sp,sp,16
    80003030:	00008067          	ret

0000000080003034 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80003034:	fe010113          	addi	sp,sp,-32
    80003038:	00113c23          	sd	ra,24(sp)
    8000303c:	00813823          	sd	s0,16(sp)
    80003040:	00913423          	sd	s1,8(sp)
    80003044:	02010413          	addi	s0,sp,32
    80003048:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    8000304c:	0200006f          	j	8000306c <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80003050:	00053703          	ld	a4,0(a0)
    80003054:	00f707b3          	add	a5,a4,a5
    80003058:	fff7b783          	ld	a5,-1(a5)
    8000305c:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80003060:	0184b503          	ld	a0,24(s1)
    80003064:	00000097          	auipc	ra,0x0
    80003068:	fa8080e7          	jalr	-88(ra) # 8000300c <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    8000306c:	0004b503          	ld	a0,0(s1)
    80003070:	0104b783          	ld	a5,16(s1)
    80003074:	00f50533          	add	a0,a0,a5
    80003078:	0084b783          	ld	a5,8(s1)
    8000307c:	0017f713          	andi	a4,a5,1
    80003080:	fc070ee3          	beqz	a4,8000305c <_Z21periodicThreadWrapperPv+0x28>
    80003084:	fcdff06f          	j	80003050 <_Z21periodicThreadWrapperPv+0x1c>

0000000080003088 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003088:	fe010113          	addi	sp,sp,-32
    8000308c:	00113c23          	sd	ra,24(sp)
    80003090:	00813823          	sd	s0,16(sp)
    80003094:	00913423          	sd	s1,8(sp)
    80003098:	01213023          	sd	s2,0(sp)
    8000309c:	02010413          	addi	s0,sp,32
    800030a0:	00050493          	mv	s1,a0
    800030a4:	00006797          	auipc	a5,0x6
    800030a8:	da478793          	addi	a5,a5,-604 # 80008e48 <_ZTV9Semaphore+0x10>
    800030ac:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    800030b0:	00058913          	mv	s2,a1

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1);

    800030b4:	01800513          	li	a0,24
    800030b8:	00000097          	auipc	ra,0x0
    800030bc:	474080e7          	jalr	1140(ra) # 8000352c <_ZN3SCBnwEm>
    static SCB* createSysSemaphore(int semValue = 1);

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();

    static void createObject(void* addr) {}
    800030c0:	00053023          	sd	zero,0(a0)
    800030c4:	00053423          	sd	zero,8(a0)
    static void freeObject(void* addr) {}
    800030c8:	01252823          	sw	s2,16(a0)
    800030cc:	00a4b423          	sd	a0,8(s1)
}
    800030d0:	01813083          	ld	ra,24(sp)
    800030d4:	01013403          	ld	s0,16(sp)
    800030d8:	00813483          	ld	s1,8(sp)
    800030dc:	00013903          	ld	s2,0(sp)
    800030e0:	02010113          	addi	sp,sp,32
    800030e4:	00008067          	ret

00000000800030e8 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800030e8:	ff010113          	addi	sp,sp,-16
    800030ec:	00113423          	sd	ra,8(sp)
    800030f0:	00813023          	sd	s0,0(sp)
    800030f4:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800030f8:	00853503          	ld	a0,8(a0)
    800030fc:	ffffe097          	auipc	ra,0xffffe
    80003100:	29c080e7          	jalr	668(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80003104:	00813083          	ld	ra,8(sp)
    80003108:	00013403          	ld	s0,0(sp)
    8000310c:	01010113          	addi	sp,sp,16
    80003110:	00008067          	ret

0000000080003114 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003114:	ff010113          	addi	sp,sp,-16
    80003118:	00113423          	sd	ra,8(sp)
    8000311c:	00813023          	sd	s0,0(sp)
    80003120:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003124:	00853503          	ld	a0,8(a0)
    80003128:	ffffe097          	auipc	ra,0xffffe
    8000312c:	2b8080e7          	jalr	696(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80003130:	00813083          	ld	ra,8(sp)
    80003134:	00013403          	ld	s0,0(sp)
    80003138:	01010113          	addi	sp,sp,16
    8000313c:	00008067          	ret

0000000080003140 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00113423          	sd	ra,8(sp)
    80003148:	00813023          	sd	s0,0(sp)
    8000314c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003150:	00001097          	auipc	ra,0x1
    80003154:	ed8080e7          	jalr	-296(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003158:	00813083          	ld	ra,8(sp)
    8000315c:	00013403          	ld	s0,0(sp)
    80003160:	01010113          	addi	sp,sp,16
    80003164:	00008067          	ret

0000000080003168 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80003168:	fe010113          	addi	sp,sp,-32
    8000316c:	00113c23          	sd	ra,24(sp)
    80003170:	00813823          	sd	s0,16(sp)
    80003174:	00913423          	sd	s1,8(sp)
    80003178:	02010413          	addi	s0,sp,32
    8000317c:	00050493          	mv	s1,a0
}
    80003180:	00000097          	auipc	ra,0x0
    80003184:	bc4080e7          	jalr	-1084(ra) # 80002d44 <_ZN9SemaphoreD1Ev>
    80003188:	00048513          	mv	a0,s1
    8000318c:	00000097          	auipc	ra,0x0
    80003190:	fb4080e7          	jalr	-76(ra) # 80003140 <_ZN9SemaphoredlEPv>
    80003194:	01813083          	ld	ra,24(sp)
    80003198:	01013403          	ld	s0,16(sp)
    8000319c:	00813483          	ld	s1,8(sp)
    800031a0:	02010113          	addi	sp,sp,32
    800031a4:	00008067          	ret

00000000800031a8 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    800031a8:	ff010113          	addi	sp,sp,-16
    800031ac:	00113423          	sd	ra,8(sp)
    800031b0:	00813023          	sd	s0,0(sp)
    800031b4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800031b8:	00001097          	auipc	ra,0x1
    800031bc:	d00080e7          	jalr	-768(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
}
    800031c0:	00813083          	ld	ra,8(sp)
    800031c4:	00013403          	ld	s0,0(sp)
    800031c8:	01010113          	addi	sp,sp,16
    800031cc:	00008067          	ret

00000000800031d0 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    800031d0:	fe010113          	addi	sp,sp,-32
    800031d4:	00113c23          	sd	ra,24(sp)
    800031d8:	00813823          	sd	s0,16(sp)
    800031dc:	00913423          	sd	s1,8(sp)
    800031e0:	01213023          	sd	s2,0(sp)
    800031e4:	02010413          	addi	s0,sp,32
    800031e8:	00050493          	mv	s1,a0
    800031ec:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    800031f0:	02000513          	li	a0,32
    800031f4:	00000097          	auipc	ra,0x0
    800031f8:	b88080e7          	jalr	-1144(ra) # 80002d7c <_Znwm>
    800031fc:	00050613          	mv	a2,a0
    80003200:	00953023          	sd	s1,0(a0)
    80003204:	01900793          	li	a5,25
    80003208:	00f53423          	sd	a5,8(a0)
    8000320c:	00053823          	sd	zero,16(a0)
    80003210:	01253c23          	sd	s2,24(a0)
    80003214:	00000597          	auipc	a1,0x0
    80003218:	e2058593          	addi	a1,a1,-480 # 80003034 <_Z21periodicThreadWrapperPv>
    8000321c:	00048513          	mv	a0,s1
    80003220:	00000097          	auipc	ra,0x0
    80003224:	c60080e7          	jalr	-928(ra) # 80002e80 <_ZN6ThreadC1EPFvPvES0_>
    80003228:	00006797          	auipc	a5,0x6
    8000322c:	bc878793          	addi	a5,a5,-1080 # 80008df0 <_ZTV14PeriodicThread+0x10>
    80003230:	00f4b023          	sd	a5,0(s1)
{}
    80003234:	01813083          	ld	ra,24(sp)
    80003238:	01013403          	ld	s0,16(sp)
    8000323c:	00813483          	ld	s1,8(sp)
    80003240:	00013903          	ld	s2,0(sp)
    80003244:	02010113          	addi	sp,sp,32
    80003248:	00008067          	ret

000000008000324c <_ZN7Console4getcEv>:


char Console::getc() {
    8000324c:	ff010113          	addi	sp,sp,-16
    80003250:	00113423          	sd	ra,8(sp)
    80003254:	00813023          	sd	s0,0(sp)
    80003258:	01010413          	addi	s0,sp,16
    return ::getc();
    8000325c:	ffffe097          	auipc	ra,0xffffe
    80003260:	24c080e7          	jalr	588(ra) # 800014a8 <_Z4getcv>
}
    80003264:	00813083          	ld	ra,8(sp)
    80003268:	00013403          	ld	s0,0(sp)
    8000326c:	01010113          	addi	sp,sp,16
    80003270:	00008067          	ret

0000000080003274 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003274:	ff010113          	addi	sp,sp,-16
    80003278:	00113423          	sd	ra,8(sp)
    8000327c:	00813023          	sd	s0,0(sp)
    80003280:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80003284:	ffffe097          	auipc	ra,0xffffe
    80003288:	254080e7          	jalr	596(ra) # 800014d8 <_Z4putcc>
}
    8000328c:	00813083          	ld	ra,8(sp)
    80003290:	00013403          	ld	s0,0(sp)
    80003294:	01010113          	addi	sp,sp,16
    80003298:	00008067          	ret

000000008000329c <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    8000329c:	ff010113          	addi	sp,sp,-16
    800032a0:	00813423          	sd	s0,8(sp)
    800032a4:	01010413          	addi	s0,sp,16
    800032a8:	00813403          	ld	s0,8(sp)
    800032ac:	01010113          	addi	sp,sp,16
    800032b0:	00008067          	ret

00000000800032b4 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    800032b4:	ff010113          	addi	sp,sp,-16
    800032b8:	00813423          	sd	s0,8(sp)
    800032bc:	01010413          	addi	s0,sp,16
    800032c0:	00813403          	ld	s0,8(sp)
    800032c4:	01010113          	addi	sp,sp,16
    800032c8:	00008067          	ret

00000000800032cc <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800032cc:	ff010113          	addi	sp,sp,-16
    800032d0:	00113423          	sd	ra,8(sp)
    800032d4:	00813023          	sd	s0,0(sp)
    800032d8:	01010413          	addi	s0,sp,16
    800032dc:	00006797          	auipc	a5,0x6
    800032e0:	b1478793          	addi	a5,a5,-1260 # 80008df0 <_ZTV14PeriodicThread+0x10>
    800032e4:	00f53023          	sd	a5,0(a0)
    800032e8:	00000097          	auipc	ra,0x0
    800032ec:	a08080e7          	jalr	-1528(ra) # 80002cf0 <_ZN6ThreadD1Ev>
    800032f0:	00813083          	ld	ra,8(sp)
    800032f4:	00013403          	ld	s0,0(sp)
    800032f8:	01010113          	addi	sp,sp,16
    800032fc:	00008067          	ret

0000000080003300 <_ZN14PeriodicThreadD0Ev>:
    80003300:	fe010113          	addi	sp,sp,-32
    80003304:	00113c23          	sd	ra,24(sp)
    80003308:	00813823          	sd	s0,16(sp)
    8000330c:	00913423          	sd	s1,8(sp)
    80003310:	02010413          	addi	s0,sp,32
    80003314:	00050493          	mv	s1,a0
    80003318:	00006797          	auipc	a5,0x6
    8000331c:	ad878793          	addi	a5,a5,-1320 # 80008df0 <_ZTV14PeriodicThread+0x10>
    80003320:	00f53023          	sd	a5,0(a0)
    80003324:	00000097          	auipc	ra,0x0
    80003328:	9cc080e7          	jalr	-1588(ra) # 80002cf0 <_ZN6ThreadD1Ev>
    8000332c:	00048513          	mv	a0,s1
    80003330:	00000097          	auipc	ra,0x0
    80003334:	bb0080e7          	jalr	-1104(ra) # 80002ee0 <_ZN6ThreaddlEPv>
    80003338:	01813083          	ld	ra,24(sp)
    8000333c:	01013403          	ld	s0,16(sp)
    80003340:	00813483          	ld	s1,8(sp)
    80003344:	02010113          	addi	sp,sp,32
    80003348:	00008067          	ret

000000008000334c <_ZN3SCB5blockEv>:
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

kmem_cache_t* SCB::scbCache = nullptr;

void SCB::block() {
    8000334c:	ff010113          	addi	sp,sp,-16
    80003350:	00813423          	sd	s0,8(sp)
    80003354:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80003358:	00006797          	auipc	a5,0x6
    8000335c:	b687b783          	ld	a5,-1176(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003360:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80003364:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80003368:	00853783          	ld	a5,8(a0)
    8000336c:	04078063          	beqz	a5,800033ac <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80003370:	00006717          	auipc	a4,0x6
    80003374:	b5073703          	ld	a4,-1200(a4) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003378:	00073703          	ld	a4,0(a4)
    8000337c:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80003380:	00853783          	ld	a5,8(a0)
        return nextInList;
    80003384:	0007b783          	ld	a5,0(a5)
    80003388:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    8000338c:	00006797          	auipc	a5,0x6
    80003390:	b347b783          	ld	a5,-1228(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003394:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80003398:	00100713          	li	a4,1
    8000339c:	02e784a3          	sb	a4,41(a5)
}
    800033a0:	00813403          	ld	s0,8(sp)
    800033a4:	01010113          	addi	sp,sp,16
    800033a8:	00008067          	ret
        head = tail = PCB::running;
    800033ac:	00006797          	auipc	a5,0x6
    800033b0:	b147b783          	ld	a5,-1260(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033b4:	0007b783          	ld	a5,0(a5)
    800033b8:	00f53423          	sd	a5,8(a0)
    800033bc:	00f53023          	sd	a5,0(a0)
    800033c0:	fcdff06f          	j	8000338c <_ZN3SCB5blockEv+0x40>

00000000800033c4 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800033c4:	ff010113          	addi	sp,sp,-16
    800033c8:	00813423          	sd	s0,8(sp)
    800033cc:	01010413          	addi	s0,sp,16
    800033d0:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800033d4:	00053503          	ld	a0,0(a0)
    800033d8:	00050e63          	beqz	a0,800033f4 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800033dc:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800033e0:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800033e4:	0087b683          	ld	a3,8(a5)
    800033e8:	00d50c63          	beq	a0,a3,80003400 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    800033ec:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    800033f0:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    800033f4:	00813403          	ld	s0,8(sp)
    800033f8:	01010113          	addi	sp,sp,16
    800033fc:	00008067          	ret
        tail = head;
    80003400:	00e7b423          	sd	a4,8(a5)
    80003404:	fe9ff06f          	j	800033ec <_ZN3SCB7unblockEv+0x28>

0000000080003408 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003408:	01052783          	lw	a5,16(a0)
    8000340c:	fff7879b          	addiw	a5,a5,-1
    80003410:	00f52823          	sw	a5,16(a0)
    80003414:	02079713          	slli	a4,a5,0x20
    80003418:	02074063          	bltz	a4,80003438 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000341c:	00006797          	auipc	a5,0x6
    80003420:	aa47b783          	ld	a5,-1372(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003424:	0007b783          	ld	a5,0(a5)
    80003428:	02a7c783          	lbu	a5,42(a5)
    8000342c:	06079463          	bnez	a5,80003494 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003430:	00000513          	li	a0,0
    80003434:	00008067          	ret
int SCB::wait() {
    80003438:	ff010113          	addi	sp,sp,-16
    8000343c:	00113423          	sd	ra,8(sp)
    80003440:	00813023          	sd	s0,0(sp)
    80003444:	01010413          	addi	s0,sp,16
        block();
    80003448:	00000097          	auipc	ra,0x0
    8000344c:	f04080e7          	jalr	-252(ra) # 8000334c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80003450:	00006797          	auipc	a5,0x6
    80003454:	a487b783          	ld	a5,-1464(a5) # 80008e98 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003458:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    8000345c:	ffffe097          	auipc	ra,0xffffe
    80003460:	698080e7          	jalr	1688(ra) # 80001af4 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80003464:	00006797          	auipc	a5,0x6
    80003468:	a5c7b783          	ld	a5,-1444(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000346c:	0007b783          	ld	a5,0(a5)
    80003470:	02a7c783          	lbu	a5,42(a5)
    80003474:	00079c63          	bnez	a5,8000348c <_ZN3SCB4waitEv+0x84>
    return 0;
    80003478:	00000513          	li	a0,0

}
    8000347c:	00813083          	ld	ra,8(sp)
    80003480:	00013403          	ld	s0,0(sp)
    80003484:	01010113          	addi	sp,sp,16
    80003488:	00008067          	ret
        return -2;
    8000348c:	ffe00513          	li	a0,-2
    80003490:	fedff06f          	j	8000347c <_ZN3SCB4waitEv+0x74>
    80003494:	ffe00513          	li	a0,-2
}
    80003498:	00008067          	ret

000000008000349c <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    8000349c:	01052783          	lw	a5,16(a0)
    800034a0:	0017879b          	addiw	a5,a5,1
    800034a4:	0007871b          	sext.w	a4,a5
    800034a8:	00f52823          	sw	a5,16(a0)
    800034ac:	00e05463          	blez	a4,800034b4 <_ZN3SCB6signalEv+0x18>
    800034b0:	00008067          	ret
void SCB::signal() {
    800034b4:	ff010113          	addi	sp,sp,-16
    800034b8:	00113423          	sd	ra,8(sp)
    800034bc:	00813023          	sd	s0,0(sp)
    800034c0:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800034c4:	00000097          	auipc	ra,0x0
    800034c8:	f00080e7          	jalr	-256(ra) # 800033c4 <_ZN3SCB7unblockEv>
    800034cc:	fffff097          	auipc	ra,0xfffff
    800034d0:	53c080e7          	jalr	1340(ra) # 80002a08 <_ZN9Scheduler3putEP3PCB>
    }

}
    800034d4:	00813083          	ld	ra,8(sp)
    800034d8:	00013403          	ld	s0,0(sp)
    800034dc:	01010113          	addi	sp,sp,16
    800034e0:	00008067          	ret

00000000800034e4 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    800034e4:	01052783          	lw	a5,16(a0)
    800034e8:	0017879b          	addiw	a5,a5,1
    800034ec:	0007871b          	sext.w	a4,a5
    800034f0:	00f52823          	sw	a5,16(a0)
    800034f4:	00e05463          	blez	a4,800034fc <_ZN3SCB14prioritySignalEv+0x18>
    800034f8:	00008067          	ret
void SCB::prioritySignal() {
    800034fc:	ff010113          	addi	sp,sp,-16
    80003500:	00113423          	sd	ra,8(sp)
    80003504:	00813023          	sd	s0,0(sp)
    80003508:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000350c:	00000097          	auipc	ra,0x0
    80003510:	eb8080e7          	jalr	-328(ra) # 800033c4 <_ZN3SCB7unblockEv>
    80003514:	fffff097          	auipc	ra,0xfffff
    80003518:	5a0080e7          	jalr	1440(ra) # 80002ab4 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000351c:	00813083          	ld	ra,8(sp)
    80003520:	00013403          	ld	s0,0(sp)
    80003524:	01010113          	addi	sp,sp,16
    80003528:	00008067          	ret

000000008000352c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000352c:	ff010113          	addi	sp,sp,-16
    80003530:	00113423          	sd	ra,8(sp)
    80003534:	00813023          	sd	s0,0(sp)
    80003538:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000353c:	00001097          	auipc	ra,0x1
    80003540:	97c080e7          	jalr	-1668(ra) # 80003eb8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003544:	00813083          	ld	ra,8(sp)
    80003548:	00013403          	ld	s0,0(sp)
    8000354c:	01010113          	addi	sp,sp,16
    80003550:	00008067          	ret

0000000080003554 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80003554:	ff010113          	addi	sp,sp,-16
    80003558:	00113423          	sd	ra,8(sp)
    8000355c:	00813023          	sd	s0,0(sp)
    80003560:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003564:	00001097          	auipc	ra,0x1
    80003568:	ac4080e7          	jalr	-1340(ra) # 80004028 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000356c:	00813083          	ld	ra,8(sp)
    80003570:	00013403          	ld	s0,0(sp)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    8000357c:	fe010113          	addi	sp,sp,-32
    80003580:	00113c23          	sd	ra,24(sp)
    80003584:	00813823          	sd	s0,16(sp)
    80003588:	00913423          	sd	s1,8(sp)
    8000358c:	01213023          	sd	s2,0(sp)
    80003590:	02010413          	addi	s0,sp,32
    80003594:	00050913          	mv	s2,a0
    PCB* curr = head;
    80003598:	00053503          	ld	a0,0(a0)
    while(curr) {
    8000359c:	02050263          	beqz	a0,800035c0 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800035a0:	00100793          	li	a5,1
    800035a4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800035a8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800035ac:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	458080e7          	jalr	1112(ra) # 80002a08 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800035b8:	00048513          	mv	a0,s1
    while(curr) {
    800035bc:	fe1ff06f          	j	8000359c <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    800035c0:	00093423          	sd	zero,8(s2)
    800035c4:	00093023          	sd	zero,0(s2)
}
    800035c8:	01813083          	ld	ra,24(sp)
    800035cc:	01013403          	ld	s0,16(sp)
    800035d0:	00813483          	ld	s1,8(sp)
    800035d4:	00013903          	ld	s2,0(sp)
    800035d8:	02010113          	addi	sp,sp,32
    800035dc:	00008067          	ret

00000000800035e0 <_ZN3SCB15createSemaphoreEi>:
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    object->scbInit(semValue);
    return object;
}

SCB *SCB::createSemaphore(int semValue) {
    800035e0:	fe010113          	addi	sp,sp,-32
    800035e4:	00113c23          	sd	ra,24(sp)
    800035e8:	00813823          	sd	s0,16(sp)
    800035ec:	00913423          	sd	s1,8(sp)
    800035f0:	02010413          	addi	s0,sp,32
    800035f4:	00050493          	mv	s1,a0
    return new SCB(semValue);
    800035f8:	01800513          	li	a0,24
    800035fc:	00000097          	auipc	ra,0x0
    80003600:	f30080e7          	jalr	-208(ra) # 8000352c <_ZN3SCBnwEm>
    static kmem_cache_t* scbCache;//TODO private
    static void initSCBCache();
private:

    void scbInit(int semValue);
    SCB(int semValue_ = 1) {
    80003604:	00053023          	sd	zero,0(a0)
    80003608:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000360c:	00952823          	sw	s1,16(a0)
}
    80003610:	01813083          	ld	ra,24(sp)
    80003614:	01013403          	ld	s0,16(sp)
    80003618:	00813483          	ld	s1,8(sp)
    8000361c:	02010113          	addi	sp,sp,32
    80003620:	00008067          	ret

0000000080003624 <_ZN3SCB7scbInitEi>:

void SCB::scbInit(int semValue_) {
    80003624:	ff010113          	addi	sp,sp,-16
    80003628:	00813423          	sd	s0,8(sp)
    8000362c:	01010413          	addi	s0,sp,16
    head = tail = nullptr;
    80003630:	00053423          	sd	zero,8(a0)
    80003634:	00053023          	sd	zero,0(a0)
    semValue = semValue_;
    80003638:	00b52823          	sw	a1,16(a0)
}
    8000363c:	00813403          	ld	s0,8(sp)
    80003640:	01010113          	addi	sp,sp,16
    80003644:	00008067          	ret

0000000080003648 <_ZN3SCB12initSCBCacheEv>:

void SCB::initSCBCache() {
    80003648:	ff010113          	addi	sp,sp,-16
    8000364c:	00113423          	sd	ra,8(sp)
    80003650:	00813023          	sd	s0,0(sp)
    80003654:	01010413          	addi	s0,sp,16
    scbCache = kmem_cache_create("SCB", sizeof(SCB), &createObject, &freeObject);
    80003658:	00000697          	auipc	a3,0x0
    8000365c:	0c468693          	addi	a3,a3,196 # 8000371c <_ZN3SCB10freeObjectEPv>
    80003660:	00000617          	auipc	a2,0x0
    80003664:	0a460613          	addi	a2,a2,164 # 80003704 <_ZN3SCB12createObjectEPv>
    80003668:	01800593          	li	a1,24
    8000366c:	00004517          	auipc	a0,0x4
    80003670:	aec50513          	addi	a0,a0,-1300 # 80007158 <CONSOLE_STATUS+0x148>
    80003674:	00001097          	auipc	ra,0x1
    80003678:	b90080e7          	jalr	-1136(ra) # 80004204 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000367c:	00006797          	auipc	a5,0x6
    80003680:	9ca7b623          	sd	a0,-1588(a5) # 80009048 <_ZN3SCB8scbCacheE>
}
    80003684:	00813083          	ld	ra,8(sp)
    80003688:	00013403          	ld	s0,0(sp)
    8000368c:	01010113          	addi	sp,sp,16
    80003690:	00008067          	ret

0000000080003694 <_ZN3SCB18createSysSemaphoreEi>:
SCB *SCB::createSysSemaphore(int semValue) {
    80003694:	fe010113          	addi	sp,sp,-32
    80003698:	00113c23          	sd	ra,24(sp)
    8000369c:	00813823          	sd	s0,16(sp)
    800036a0:	00913423          	sd	s1,8(sp)
    800036a4:	01213023          	sd	s2,0(sp)
    800036a8:	02010413          	addi	s0,sp,32
    800036ac:	00050913          	mv	s2,a0
    if(!scbCache) initSCBCache();
    800036b0:	00006797          	auipc	a5,0x6
    800036b4:	9987b783          	ld	a5,-1640(a5) # 80009048 <_ZN3SCB8scbCacheE>
    800036b8:	04078063          	beqz	a5,800036f8 <_ZN3SCB18createSysSemaphoreEi+0x64>
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    800036bc:	00006517          	auipc	a0,0x6
    800036c0:	98c53503          	ld	a0,-1652(a0) # 80009048 <_ZN3SCB8scbCacheE>
    800036c4:	00001097          	auipc	ra,0x1
    800036c8:	b90080e7          	jalr	-1136(ra) # 80004254 <_Z16kmem_cache_allocP12kmem_cache_s>
    800036cc:	00050493          	mv	s1,a0
    object->scbInit(semValue);
    800036d0:	00090593          	mv	a1,s2
    800036d4:	00000097          	auipc	ra,0x0
    800036d8:	f50080e7          	jalr	-176(ra) # 80003624 <_ZN3SCB7scbInitEi>
}
    800036dc:	00048513          	mv	a0,s1
    800036e0:	01813083          	ld	ra,24(sp)
    800036e4:	01013403          	ld	s0,16(sp)
    800036e8:	00813483          	ld	s1,8(sp)
    800036ec:	00013903          	ld	s2,0(sp)
    800036f0:	02010113          	addi	sp,sp,32
    800036f4:	00008067          	ret
    if(!scbCache) initSCBCache();
    800036f8:	00000097          	auipc	ra,0x0
    800036fc:	f50080e7          	jalr	-176(ra) # 80003648 <_ZN3SCB12initSCBCacheEv>
    80003700:	fbdff06f          	j	800036bc <_ZN3SCB18createSysSemaphoreEi+0x28>

0000000080003704 <_ZN3SCB12createObjectEPv>:
    static void createObject(void* addr) {}
    80003704:	ff010113          	addi	sp,sp,-16
    80003708:	00813423          	sd	s0,8(sp)
    8000370c:	01010413          	addi	s0,sp,16
    80003710:	00813403          	ld	s0,8(sp)
    80003714:	01010113          	addi	sp,sp,16
    80003718:	00008067          	ret

000000008000371c <_ZN3SCB10freeObjectEPv>:
    static void freeObject(void* addr) {}
    8000371c:	ff010113          	addi	sp,sp,-16
    80003720:	00813423          	sd	s0,8(sp)
    80003724:	01010413          	addi	s0,sp,16
    80003728:	00813403          	ld	s0,8(sp)
    8000372c:	01010113          	addi	sp,sp,16
    80003730:	00008067          	ret

0000000080003734 <_ZN5Cache11getNumSlotsEm>:
    slotSize = objectSize + sizeof(Slot);

    optimalSlots = getNumSlots(slotSize);
}

int Cache::getNumSlots(size_t objSize) {
    80003734:	ff010113          	addi	sp,sp,-16
    80003738:	00813423          	sd	s0,8(sp)
    8000373c:	01010413          	addi	s0,sp,16
    return (BLKSIZE - sizeof(Slab)) / objSize;
    80003740:	000017b7          	lui	a5,0x1
    80003744:	fd878793          	addi	a5,a5,-40 # fd8 <_entry-0x7ffff028>
    80003748:	02a7d533          	divu	a0,a5,a0
}
    8000374c:	0005051b          	sext.w	a0,a0
    80003750:	00813403          	ld	s0,8(sp)
    80003754:	01010113          	addi	sp,sp,16
    80003758:	00008067          	ret

000000008000375c <_ZN5Cache9initCacheEPKcmPFvPvES4_>:
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    8000375c:	fe010113          	addi	sp,sp,-32
    80003760:	00113c23          	sd	ra,24(sp)
    80003764:	00813823          	sd	s0,16(sp)
    80003768:	00913423          	sd	s1,8(sp)
    8000376c:	02010413          	addi	s0,sp,32
    80003770:	00050493          	mv	s1,a0
    for(int i = 0;; i++) {
    80003774:	00000793          	li	a5,0
        cacheName[i] = name[i];
    80003778:	00f58833          	add	a6,a1,a5
    8000377c:	00084303          	lbu	t1,0(a6)
    80003780:	00f488b3          	add	a7,s1,a5
    80003784:	02688023          	sb	t1,32(a7)
        if(name[i] == '\0') break;
    80003788:	00084803          	lbu	a6,0(a6)
    8000378c:	00080663          	beqz	a6,80003798 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x3c>
    for(int i = 0;; i++) {
    80003790:	0017879b          	addiw	a5,a5,1
        cacheName[i] = name[i];
    80003794:	fe5ff06f          	j	80003778 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x1c>
    for(int i = 0; i < 3; i++) {
    80003798:	00000793          	li	a5,0
    8000379c:	00200593          	li	a1,2
    800037a0:	00f5cc63          	blt	a1,a5,800037b8 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x5c>
        slabList[i] = nullptr;
    800037a4:	00379593          	slli	a1,a5,0x3
    800037a8:	00b485b3          	add	a1,s1,a1
    800037ac:	0005b423          	sd	zero,8(a1)
    for(int i = 0; i < 3; i++) {
    800037b0:	0017879b          	addiw	a5,a5,1
    800037b4:	fe9ff06f          	j	8000379c <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x40>
    objectSize = size;
    800037b8:	02c4b823          	sd	a2,48(s1)
    constructor = ctor;
    800037bc:	04d4b423          	sd	a3,72(s1)
    destructor = dtor;
    800037c0:	04e4b823          	sd	a4,80(s1)
    slotSize = objectSize + sizeof(Slot);
    800037c4:	01860513          	addi	a0,a2,24
    800037c8:	04a4b023          	sd	a0,64(s1)
    optimalSlots = getNumSlots(slotSize);
    800037cc:	00000097          	auipc	ra,0x0
    800037d0:	f68080e7          	jalr	-152(ra) # 80003734 <_ZN5Cache11getNumSlotsEm>
    800037d4:	02a4bc23          	sd	a0,56(s1)
}
    800037d8:	01813083          	ld	ra,24(sp)
    800037dc:	01013403          	ld	s0,16(sp)
    800037e0:	00813483          	ld	s1,8(sp)
    800037e4:	02010113          	addi	sp,sp,32
    800037e8:	00008067          	ret

00000000800037ec <_ZN5Cache12allocateSlabEv>:

    Slab* slab = allocateSlab();
    return slab->getFreeSlot();
}

Cache::Slab *Cache::allocateSlab() {
    800037ec:	fc010113          	addi	sp,sp,-64
    800037f0:	02113c23          	sd	ra,56(sp)
    800037f4:	02813823          	sd	s0,48(sp)
    800037f8:	02913423          	sd	s1,40(sp)
    800037fc:	03213023          	sd	s2,32(sp)
    80003800:	01313c23          	sd	s3,24(sp)
    80003804:	01413823          	sd	s4,16(sp)
    80003808:	01513423          	sd	s5,8(sp)
    8000380c:	04010413          	addi	s0,sp,64
    80003810:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(1);
    80003814:	00100513          	li	a0,1
    80003818:	fffff097          	auipc	ra,0xfffff
    8000381c:	988080e7          	jalr	-1656(ra) # 800021a0 <_ZN14BuddyAllocator10buddyAllocEm>
    80003820:	00050a13          	mv	s4,a0
    slab->parentCache = this;
    80003824:	01253c23          	sd	s2,24(a0)
    slab->next = nullptr;
    80003828:	00053423          	sd	zero,8(a0)
    slab->state = CREATED;
    8000382c:	00300793          	li	a5,3
    80003830:	00f52823          	sw	a5,16(a0)
    slab->allocatedSlots = 0;
    80003834:	00053023          	sd	zero,0(a0)
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    80003838:	02850a93          	addi	s5,a0,40
    Slot* prev = nullptr;
    for(size_t i = 0; i < this->optimalSlots; i++) {
    8000383c:	00000493          	li	s1,0
    Slot* prev = nullptr;
    80003840:	00000993          	li	s3,0
    80003844:	0140006f          	j	80003858 <_ZN5Cache12allocateSlabEv+0x6c>
        curr->allocated = false;
        if(prev) {
            prev->next= curr;
        }
        else {
            slab->slotHead = curr;
    80003848:	02fa3023          	sd	a5,32(s4)
        }
        curr->next = nullptr;
    8000384c:	0007b423          	sd	zero,8(a5)
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003850:	00148493          	addi	s1,s1,1
        prev = curr;
    80003854:	00078993          	mv	s3,a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003858:	03893783          	ld	a5,56(s2)
    8000385c:	02f4fe63          	bgeu	s1,a5,80003898 <_ZN5Cache12allocateSlabEv+0xac>
        if(constructor) {
    80003860:	04893783          	ld	a5,72(s2)
    80003864:	00078a63          	beqz	a5,80003878 <_ZN5Cache12allocateSlabEv+0x8c>
            constructor((void*)((char*)startAddr + i*slotSize));
    80003868:	04093503          	ld	a0,64(s2)
    8000386c:	02950533          	mul	a0,a0,s1
    80003870:	00aa8533          	add	a0,s5,a0
    80003874:	000780e7          	jalr	a5
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
    80003878:	04093783          	ld	a5,64(s2)
    8000387c:	029787b3          	mul	a5,a5,s1
    80003880:	00fa87b3          	add	a5,s5,a5
        curr->parentSlab = slab;
    80003884:	0147b823          	sd	s4,16(a5)
        curr->allocated = false;
    80003888:	00078023          	sb	zero,0(a5)
        if(prev) {
    8000388c:	fa098ee3          	beqz	s3,80003848 <_ZN5Cache12allocateSlabEv+0x5c>
            prev->next= curr;
    80003890:	00f9b423          	sd	a5,8(s3)
    80003894:	fb9ff06f          	j	8000384c <_ZN5Cache12allocateSlabEv+0x60>
    }

    return slab;
}
    80003898:	000a0513          	mv	a0,s4
    8000389c:	03813083          	ld	ra,56(sp)
    800038a0:	03013403          	ld	s0,48(sp)
    800038a4:	02813483          	ld	s1,40(sp)
    800038a8:	02013903          	ld	s2,32(sp)
    800038ac:	01813983          	ld	s3,24(sp)
    800038b0:	01013a03          	ld	s4,16(sp)
    800038b4:	00813a83          	ld	s5,8(sp)
    800038b8:	04010113          	addi	sp,sp,64
    800038bc:	00008067          	ret

00000000800038c0 <_ZN5Cache11slabListPutEPNS_4SlabEi>:


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    800038c0:	ff010113          	addi	sp,sp,-16
    800038c4:	00813423          	sd	s0,8(sp)
    800038c8:	01010413          	addi	s0,sp,16
    if (!slab || listNum < 0 || listNum > 2) return;
    800038cc:	02058a63          	beqz	a1,80003900 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    800038d0:	02064863          	bltz	a2,80003900 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    800038d4:	00200793          	li	a5,2
    800038d8:	02c7c463          	blt	a5,a2,80003900 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    slab->state = (SlabState)listNum;
    800038dc:	00c5a823          	sw	a2,16(a1)
    if(slabList[listNum]) {
    800038e0:	00361793          	slli	a5,a2,0x3
    800038e4:	00f507b3          	add	a5,a0,a5
    800038e8:	0087b783          	ld	a5,8(a5)
    800038ec:	00078463          	beqz	a5,800038f4 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x34>
        slab->next = slabList[listNum];
    800038f0:	00f5b423          	sd	a5,8(a1)
    }
    slabList[listNum] = slab;
    800038f4:	00361613          	slli	a2,a2,0x3
    800038f8:	00c50633          	add	a2,a0,a2
    800038fc:	00b63423          	sd	a1,8(a2)
}
    80003900:	00813403          	ld	s0,8(sp)
    80003904:	01010113          	addi	sp,sp,16
    80003908:	00008067          	ret

000000008000390c <_ZN5Cache14slabListRemoveEPNS_4SlabEi>:
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    8000390c:	ff010113          	addi	sp,sp,-16
    80003910:	00813423          	sd	s0,8(sp)
    80003914:	01010413          	addi	s0,sp,16
    if(!slab || listNum < 0 || listNum > 2) return;
    80003918:	04058063          	beqz	a1,80003958 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    8000391c:	02064e63          	bltz	a2,80003958 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    80003920:	00200793          	li	a5,2
    80003924:	02c7ca63          	blt	a5,a2,80003958 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003928:	00361613          	slli	a2,a2,0x3
    8000392c:	00c50633          	add	a2,a0,a2
    80003930:	00863783          	ld	a5,8(a2)
    Slab* prev = nullptr;
    80003934:	00000713          	li	a4,0
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003938:	02078063          	beqz	a5,80003958 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
        if(curr == slab) {
    8000393c:	00b78863          	beq	a5,a1,8000394c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x40>
            prev->next = curr->next;
            curr->next = nullptr;
            break;
        }
        prev = curr;
    80003940:	00078713          	mv	a4,a5
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003944:	0087b783          	ld	a5,8(a5)
    80003948:	ff1ff06f          	j	80003938 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x2c>
            prev->next = curr->next;
    8000394c:	0087b683          	ld	a3,8(a5)
    80003950:	00d73423          	sd	a3,8(a4)
            curr->next = nullptr;
    80003954:	0007b423          	sd	zero,8(a5)
    }
}
    80003958:	00813403          	ld	s0,8(sp)
    8000395c:	01010113          	addi	sp,sp,16
    80003960:	00008067          	ret

0000000080003964 <_ZN5Cache17printErrorMessageEv>:

int Cache::printErrorMessage() {
    80003964:	fe010113          	addi	sp,sp,-32
    80003968:	00113c23          	sd	ra,24(sp)
    8000396c:	00813823          	sd	s0,16(sp)
    80003970:	00913423          	sd	s1,8(sp)
    80003974:	02010413          	addi	s0,sp,32
    80003978:	00050493          	mv	s1,a0
    switch(errortype) {
    8000397c:	00052703          	lw	a4,0(a0)
    80003980:	00100793          	li	a5,1
    80003984:	02f70663          	beq	a4,a5,800039b0 <_ZN5Cache17printErrorMessageEv+0x4c>
        case FREESLOTERROR:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    80003988:	00003517          	auipc	a0,0x3
    8000398c:	7f850513          	addi	a0,a0,2040 # 80007180 <CONSOLE_STATUS+0x170>
    80003990:	fffff097          	auipc	ra,0xfffff
    80003994:	d9c080e7          	jalr	-612(ra) # 8000272c <_Z11printStringPKc>
    }
    return errortype;
}
    80003998:	0004a503          	lw	a0,0(s1)
    8000399c:	01813083          	ld	ra,24(sp)
    800039a0:	01013403          	ld	s0,16(sp)
    800039a4:	00813483          	ld	s1,8(sp)
    800039a8:	02010113          	addi	sp,sp,32
    800039ac:	00008067          	ret
            printString("Greska u oslobadjanju slota");
    800039b0:	00003517          	auipc	a0,0x3
    800039b4:	7b050513          	addi	a0,a0,1968 # 80007160 <CONSOLE_STATUS+0x150>
    800039b8:	fffff097          	auipc	ra,0xfffff
    800039bc:	d74080e7          	jalr	-652(ra) # 8000272c <_Z11printStringPKc>
    800039c0:	fc9ff06f          	j	80003988 <_ZN5Cache17printErrorMessageEv+0x24>

00000000800039c4 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>:
    printString(", ");
    printInt(numSlots);

}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    800039c4:	ff010113          	addi	sp,sp,-16
    800039c8:	00813423          	sd	s0,8(sp)
    800039cc:	01010413          	addi	s0,sp,16
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
    800039d0:	00000893          	li	a7,0
    int slabs = 0, slots = 0;
    800039d4:	00000713          	li	a4,0
    800039d8:	00000693          	li	a3,0
    800039dc:	0080006f          	j	800039e4 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x20>
    for(int i = 0; i < 3; i++) {
    800039e0:	0018889b          	addiw	a7,a7,1
    800039e4:	00200793          	li	a5,2
    800039e8:	0317c463          	blt	a5,a7,80003a10 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x4c>
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    800039ec:	00389793          	slli	a5,a7,0x3
    800039f0:	00f507b3          	add	a5,a0,a5
    800039f4:	0087b783          	ld	a5,8(a5)
    800039f8:	fe0784e3          	beqz	a5,800039e0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x1c>
             slabs++;
    800039fc:	0016869b          	addiw	a3,a3,1
             slots += curr->allocatedSlots;
    80003a00:	0007b803          	ld	a6,0(a5)
    80003a04:	00e8073b          	addw	a4,a6,a4
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003a08:	0087b783          	ld	a5,8(a5)
    80003a0c:	fedff06f          	j	800039f8 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x34>
        }
    }
    (*numSlabs) = slabs;
    80003a10:	00d5a023          	sw	a3,0(a1)
    (*numSlots) = slots;
    80003a14:	00e62023          	sw	a4,0(a2)
}
    80003a18:	00813403          	ld	s0,8(sp)
    80003a1c:	01010113          	addi	sp,sp,16
    80003a20:	00008067          	ret

0000000080003a24 <_ZN5Cache14printCacheInfoEv>:
void Cache::printCacheInfo() {
    80003a24:	fd010113          	addi	sp,sp,-48
    80003a28:	02113423          	sd	ra,40(sp)
    80003a2c:	02813023          	sd	s0,32(sp)
    80003a30:	00913c23          	sd	s1,24(sp)
    80003a34:	03010413          	addi	s0,sp,48
    80003a38:	00050493          	mv	s1,a0
    int numSlabs = 0, numSlots = 0;
    80003a3c:	fc042e23          	sw	zero,-36(s0)
    80003a40:	fc042c23          	sw	zero,-40(s0)
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    80003a44:	fd840613          	addi	a2,s0,-40
    80003a48:	fdc40593          	addi	a1,s0,-36
    80003a4c:	00000097          	auipc	ra,0x0
    80003a50:	f78080e7          	jalr	-136(ra) # 800039c4 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>
    printString("ime kesa, velicina objekta, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    80003a54:	00003517          	auipc	a0,0x3
    80003a58:	75450513          	addi	a0,a0,1876 # 800071a8 <CONSOLE_STATUS+0x198>
    80003a5c:	fffff097          	auipc	ra,0xfffff
    80003a60:	cd0080e7          	jalr	-816(ra) # 8000272c <_Z11printStringPKc>
    printString(cacheName);
    80003a64:	02048513          	addi	a0,s1,32
    80003a68:	fffff097          	auipc	ra,0xfffff
    80003a6c:	cc4080e7          	jalr	-828(ra) # 8000272c <_Z11printStringPKc>
    printString(", ");
    80003a70:	00003517          	auipc	a0,0x3
    80003a74:	7a850513          	addi	a0,a0,1960 # 80007218 <CONSOLE_STATUS+0x208>
    80003a78:	fffff097          	auipc	ra,0xfffff
    80003a7c:	cb4080e7          	jalr	-844(ra) # 8000272c <_Z11printStringPKc>
    printInt(objectSize);
    80003a80:	00000613          	li	a2,0
    80003a84:	00a00593          	li	a1,10
    80003a88:	0304a503          	lw	a0,48(s1)
    80003a8c:	fffff097          	auipc	ra,0xfffff
    80003a90:	e38080e7          	jalr	-456(ra) # 800028c4 <_Z8printIntiii>
    printString(", ");
    80003a94:	00003517          	auipc	a0,0x3
    80003a98:	78450513          	addi	a0,a0,1924 # 80007218 <CONSOLE_STATUS+0x208>
    80003a9c:	fffff097          	auipc	ra,0xfffff
    80003aa0:	c90080e7          	jalr	-880(ra) # 8000272c <_Z11printStringPKc>
    printInt(numSlabs);
    80003aa4:	00000613          	li	a2,0
    80003aa8:	00a00593          	li	a1,10
    80003aac:	fdc42503          	lw	a0,-36(s0)
    80003ab0:	fffff097          	auipc	ra,0xfffff
    80003ab4:	e14080e7          	jalr	-492(ra) # 800028c4 <_Z8printIntiii>
    printString(", ");
    80003ab8:	00003517          	auipc	a0,0x3
    80003abc:	76050513          	addi	a0,a0,1888 # 80007218 <CONSOLE_STATUS+0x208>
    80003ac0:	fffff097          	auipc	ra,0xfffff
    80003ac4:	c6c080e7          	jalr	-916(ra) # 8000272c <_Z11printStringPKc>
    printInt(optimalSlots);
    80003ac8:	00000613          	li	a2,0
    80003acc:	00a00593          	li	a1,10
    80003ad0:	0384a503          	lw	a0,56(s1)
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	df0080e7          	jalr	-528(ra) # 800028c4 <_Z8printIntiii>
    printString(", ");
    80003adc:	00003517          	auipc	a0,0x3
    80003ae0:	73c50513          	addi	a0,a0,1852 # 80007218 <CONSOLE_STATUS+0x208>
    80003ae4:	fffff097          	auipc	ra,0xfffff
    80003ae8:	c48080e7          	jalr	-952(ra) # 8000272c <_Z11printStringPKc>
    printInt(slotSize);
    80003aec:	00000613          	li	a2,0
    80003af0:	00a00593          	li	a1,10
    80003af4:	0404a503          	lw	a0,64(s1)
    80003af8:	fffff097          	auipc	ra,0xfffff
    80003afc:	dcc080e7          	jalr	-564(ra) # 800028c4 <_Z8printIntiii>
    printString(", ");
    80003b00:	00003517          	auipc	a0,0x3
    80003b04:	71850513          	addi	a0,a0,1816 # 80007218 <CONSOLE_STATUS+0x208>
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	c24080e7          	jalr	-988(ra) # 8000272c <_Z11printStringPKc>
    printInt(numSlots);
    80003b10:	00000613          	li	a2,0
    80003b14:	00a00593          	li	a1,10
    80003b18:	fd842503          	lw	a0,-40(s0)
    80003b1c:	fffff097          	auipc	ra,0xfffff
    80003b20:	da8080e7          	jalr	-600(ra) # 800028c4 <_Z8printIntiii>
}
    80003b24:	02813083          	ld	ra,40(sp)
    80003b28:	02013403          	ld	s0,32(sp)
    80003b2c:	01813483          	ld	s1,24(sp)
    80003b30:	03010113          	addi	sp,sp,48
    80003b34:	00008067          	ret

0000000080003b38 <_ZN5Cache11deallocSlabEPNS_4SlabE>:
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    80003b38:	fd010113          	addi	sp,sp,-48
    80003b3c:	02113423          	sd	ra,40(sp)
    80003b40:	02813023          	sd	s0,32(sp)
    80003b44:	00913c23          	sd	s1,24(sp)
    80003b48:	01213823          	sd	s2,16(sp)
    80003b4c:	01313423          	sd	s3,8(sp)
    80003b50:	03010413          	addi	s0,sp,48
    80003b54:	00058993          	mv	s3,a1
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    if(destructor) {
    80003b58:	05053783          	ld	a5,80(a0)
    80003b5c:	02078a63          	beqz	a5,80003b90 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x58>
    80003b60:	00050913          	mv	s2,a0
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003b64:	00000493          	li	s1,0
    80003b68:	0200006f          	j	80003b88 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x50>
            destructor((void*)((char*)startAddr + i*slotSize));
    80003b6c:	05093783          	ld	a5,80(s2)
    80003b70:	04093503          	ld	a0,64(s2)
    80003b74:	02950533          	mul	a0,a0,s1
    80003b78:	02850513          	addi	a0,a0,40
    80003b7c:	00a98533          	add	a0,s3,a0
    80003b80:	000780e7          	jalr	a5
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003b84:	00148493          	addi	s1,s1,1
    80003b88:	03893783          	ld	a5,56(s2)
    80003b8c:	fef4e0e3          	bltu	s1,a5,80003b6c <_ZN5Cache11deallocSlabEPNS_4SlabE+0x34>
        }
    }
    BuddyAllocator::buddyFree(slab, 1);
    80003b90:	00100593          	li	a1,1
    80003b94:	00098513          	mv	a0,s3
    80003b98:	ffffe097          	auipc	ra,0xffffe
    80003b9c:	6d0080e7          	jalr	1744(ra) # 80002268 <_ZN14BuddyAllocator9buddyFreeEPvm>
}
    80003ba0:	02813083          	ld	ra,40(sp)
    80003ba4:	02013403          	ld	s0,32(sp)
    80003ba8:	01813483          	ld	s1,24(sp)
    80003bac:	01013903          	ld	s2,16(sp)
    80003bb0:	00813983          	ld	s3,8(sp)
    80003bb4:	03010113          	addi	sp,sp,48
    80003bb8:	00008067          	ret

0000000080003bbc <_ZN5Cache16deallocFreeSlabsEv>:
int Cache::deallocFreeSlabs() {
    80003bbc:	fd010113          	addi	sp,sp,-48
    80003bc0:	02113423          	sd	ra,40(sp)
    80003bc4:	02813023          	sd	s0,32(sp)
    80003bc8:	00913c23          	sd	s1,24(sp)
    80003bcc:	01213823          	sd	s2,16(sp)
    80003bd0:	01313423          	sd	s3,8(sp)
    80003bd4:	03010413          	addi	s0,sp,48
    80003bd8:	00050993          	mv	s3,a0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003bdc:	00853583          	ld	a1,8(a0)
    int numSlabs = 0;
    80003be0:	00000493          	li	s1,0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003be4:	02058063          	beqz	a1,80003c04 <_ZN5Cache16deallocFreeSlabsEv+0x48>
        numSlabs++;
    80003be8:	0014849b          	addiw	s1,s1,1
        curr = curr->next;
    80003bec:	0085b903          	ld	s2,8(a1)
        deallocSlab(old);
    80003bf0:	00098513          	mv	a0,s3
    80003bf4:	00000097          	auipc	ra,0x0
    80003bf8:	f44080e7          	jalr	-188(ra) # 80003b38 <_ZN5Cache11deallocSlabEPNS_4SlabE>
        curr = curr->next;
    80003bfc:	00090593          	mv	a1,s2
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003c00:	fe5ff06f          	j	80003be4 <_ZN5Cache16deallocFreeSlabsEv+0x28>
    slabList[EMPTY] = nullptr;
    80003c04:	0009b423          	sd	zero,8(s3)
}
    80003c08:	00048513          	mv	a0,s1
    80003c0c:	02813083          	ld	ra,40(sp)
    80003c10:	02013403          	ld	s0,32(sp)
    80003c14:	01813483          	ld	s1,24(sp)
    80003c18:	01013903          	ld	s2,16(sp)
    80003c1c:	00813983          	ld	s3,8(sp)
    80003c20:	03010113          	addi	sp,sp,48
    80003c24:	00008067          	ret

0000000080003c28 <_ZN5Cache12deallocCacheEv>:

void Cache::deallocCache() {
    80003c28:	fd010113          	addi	sp,sp,-48
    80003c2c:	02113423          	sd	ra,40(sp)
    80003c30:	02813023          	sd	s0,32(sp)
    80003c34:	00913c23          	sd	s1,24(sp)
    80003c38:	01213823          	sd	s2,16(sp)
    80003c3c:	01313423          	sd	s3,8(sp)
    80003c40:	03010413          	addi	s0,sp,48
    80003c44:	00050913          	mv	s2,a0
    for(int i = 0; i < 3; i++) {
    80003c48:	00000993          	li	s3,0
    80003c4c:	0080006f          	j	80003c54 <_ZN5Cache12deallocCacheEv+0x2c>
    80003c50:	0019899b          	addiw	s3,s3,1
    80003c54:	00200793          	li	a5,2
    80003c58:	0337c663          	blt	a5,s3,80003c84 <_ZN5Cache12deallocCacheEv+0x5c>
        Slab* curr = slabList[i];
    80003c5c:	00399793          	slli	a5,s3,0x3
    80003c60:	00f907b3          	add	a5,s2,a5
    80003c64:	0087b583          	ld	a1,8(a5)
        while(curr) {
    80003c68:	fe0584e3          	beqz	a1,80003c50 <_ZN5Cache12deallocCacheEv+0x28>
            Slab* old = curr;
            curr = curr->next;
    80003c6c:	0085b483          	ld	s1,8(a1)
            deallocSlab(old);
    80003c70:	00090513          	mv	a0,s2
    80003c74:	00000097          	auipc	ra,0x0
    80003c78:	ec4080e7          	jalr	-316(ra) # 80003b38 <_ZN5Cache11deallocSlabEPNS_4SlabE>
            curr = curr->next;
    80003c7c:	00048593          	mv	a1,s1
        while(curr) {
    80003c80:	fe9ff06f          	j	80003c68 <_ZN5Cache12deallocCacheEv+0x40>
        }
    }
}
    80003c84:	02813083          	ld	ra,40(sp)
    80003c88:	02013403          	ld	s0,32(sp)
    80003c8c:	01813483          	ld	s1,24(sp)
    80003c90:	01013903          	ld	s2,16(sp)
    80003c94:	00813983          	ld	s3,8(sp)
    80003c98:	03010113          	addi	sp,sp,48
    80003c9c:	00008067          	ret

0000000080003ca0 <_ZN5Cache4Slab17calculateNewStateEv>:
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    80003ca0:	ff010113          	addi	sp,sp,-16
    80003ca4:	00813423          	sd	s0,8(sp)
    80003ca8:	01010413          	addi	s0,sp,16
    if(allocatedSlots == 0) {
    80003cac:	00053783          	ld	a5,0(a0)
    80003cb0:	02078063          	beqz	a5,80003cd0 <_ZN5Cache4Slab17calculateNewStateEv+0x30>
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
    80003cb4:	01853703          	ld	a4,24(a0)
    80003cb8:	03873703          	ld	a4,56(a4)
    80003cbc:	00e78e63          	beq	a5,a4,80003cd8 <_ZN5Cache4Slab17calculateNewStateEv+0x38>
        return FULL;
    }
    return PARTIAL;
    80003cc0:	00100513          	li	a0,1
}
    80003cc4:	00813403          	ld	s0,8(sp)
    80003cc8:	01010113          	addi	sp,sp,16
    80003ccc:	00008067          	ret
        return EMPTY;
    80003cd0:	00000513          	li	a0,0
    80003cd4:	ff1ff06f          	j	80003cc4 <_ZN5Cache4Slab17calculateNewStateEv+0x24>
        return FULL;
    80003cd8:	00200513          	li	a0,2
    80003cdc:	fe9ff06f          	j	80003cc4 <_ZN5Cache4Slab17calculateNewStateEv+0x24>

0000000080003ce0 <_ZN5Cache8freeSlotEPNS_4SlotE>:
void Cache::freeSlot(Slot* slot) {
    80003ce0:	fd010113          	addi	sp,sp,-48
    80003ce4:	02113423          	sd	ra,40(sp)
    80003ce8:	02813023          	sd	s0,32(sp)
    80003cec:	00913c23          	sd	s1,24(sp)
    80003cf0:	01213823          	sd	s2,16(sp)
    80003cf4:	01313423          	sd	s3,8(sp)
    80003cf8:	03010413          	addi	s0,sp,48
    if(slot->parentSlab->parentCache != this) {
    80003cfc:	0105b483          	ld	s1,16(a1)
    80003d00:	0184b903          	ld	s2,24(s1)
    80003d04:	02a90463          	beq	s2,a0,80003d2c <_ZN5Cache8freeSlotEPNS_4SlotE+0x4c>
        errortype = FREESLOTERROR;
    80003d08:	00100793          	li	a5,1
    80003d0c:	00f52023          	sw	a5,0(a0)
}
    80003d10:	02813083          	ld	ra,40(sp)
    80003d14:	02013403          	ld	s0,32(sp)
    80003d18:	01813483          	ld	s1,24(sp)
    80003d1c:	01013903          	ld	s2,16(sp)
    80003d20:	00813983          	ld	s3,8(sp)
    80003d24:	03010113          	addi	sp,sp,48
    80003d28:	00008067          	ret
    slot->allocated = false;
    80003d2c:	00058023          	sb	zero,0(a1)
    parentSlab->allocatedSlots--;
    80003d30:	0004b783          	ld	a5,0(s1)
    80003d34:	fff78793          	addi	a5,a5,-1
    80003d38:	00f4b023          	sd	a5,0(s1)
    SlabState newState = parentSlab->calculateNewState();
    80003d3c:	00048513          	mv	a0,s1
    80003d40:	00000097          	auipc	ra,0x0
    80003d44:	f60080e7          	jalr	-160(ra) # 80003ca0 <_ZN5Cache4Slab17calculateNewStateEv>
    80003d48:	00050993          	mv	s3,a0
    if(parentSlab->state != newState) {
    80003d4c:	0104a603          	lw	a2,16(s1)
    80003d50:	fca600e3          	beq	a2,a0,80003d10 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003d54:	00300793          	li	a5,3
    80003d58:	00f61e63          	bne	a2,a5,80003d74 <_ZN5Cache8freeSlotEPNS_4SlotE+0x94>
        parentCache->slabListPut(parentSlab, newState);
    80003d5c:	0009861b          	sext.w	a2,s3
    80003d60:	00048593          	mv	a1,s1
    80003d64:	00090513          	mv	a0,s2
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	b58080e7          	jalr	-1192(ra) # 800038c0 <_ZN5Cache11slabListPutEPNS_4SlabEi>
    80003d70:	fa1ff06f          	j	80003d10 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003d74:	00048593          	mv	a1,s1
    80003d78:	00090513          	mv	a0,s2
    80003d7c:	00000097          	auipc	ra,0x0
    80003d80:	b90080e7          	jalr	-1136(ra) # 8000390c <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80003d84:	fd9ff06f          	j	80003d5c <_ZN5Cache8freeSlotEPNS_4SlotE+0x7c>

0000000080003d88 <_ZN5Cache4Slab11getFreeSlotEv>:
Cache::Slot *Cache::Slab::getFreeSlot() {
    80003d88:	fd010113          	addi	sp,sp,-48
    80003d8c:	02113423          	sd	ra,40(sp)
    80003d90:	02813023          	sd	s0,32(sp)
    80003d94:	00913c23          	sd	s1,24(sp)
    80003d98:	01213823          	sd	s2,16(sp)
    80003d9c:	01313423          	sd	s3,8(sp)
    80003da0:	03010413          	addi	s0,sp,48
    if(!slotHead || state == FULL) return nullptr;
    80003da4:	02053483          	ld	s1,32(a0)
    80003da8:	06048a63          	beqz	s1,80003e1c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
    80003dac:	00050913          	mv	s2,a0
    80003db0:	01052703          	lw	a4,16(a0)
    80003db4:	00200793          	li	a5,2
    80003db8:	08f70c63          	beq	a4,a5,80003e50 <_ZN5Cache4Slab11getFreeSlotEv+0xc8>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003dbc:	06048063          	beqz	s1,80003e1c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
        if(curr->allocated == false) {
    80003dc0:	0004c783          	lbu	a5,0(s1)
    80003dc4:	00078663          	beqz	a5,80003dd0 <_ZN5Cache4Slab11getFreeSlotEv+0x48>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003dc8:	0084b483          	ld	s1,8(s1)
    80003dcc:	ff1ff06f          	j	80003dbc <_ZN5Cache4Slab11getFreeSlotEv+0x34>
            this->allocatedSlots++;
    80003dd0:	00093783          	ld	a5,0(s2)
    80003dd4:	00178793          	addi	a5,a5,1
    80003dd8:	00f93023          	sd	a5,0(s2)
            curr->allocated = true;
    80003ddc:	00100793          	li	a5,1
    80003de0:	00f48023          	sb	a5,0(s1)
            curr->parentSlab = this;
    80003de4:	0124b823          	sd	s2,16(s1)
            SlabState newState = calculateNewState();
    80003de8:	00090513          	mv	a0,s2
    80003dec:	00000097          	auipc	ra,0x0
    80003df0:	eb4080e7          	jalr	-332(ra) # 80003ca0 <_ZN5Cache4Slab17calculateNewStateEv>
    80003df4:	00050993          	mv	s3,a0
            if(this->state != newState) {
    80003df8:	01092603          	lw	a2,16(s2)
    80003dfc:	02a60063          	beq	a2,a0,80003e1c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80003e00:	00300793          	li	a5,3
    80003e04:	02f61c63          	bne	a2,a5,80003e3c <_ZN5Cache4Slab11getFreeSlotEv+0xb4>
                parentCache->slabListPut(this, newState);
    80003e08:	0009861b          	sext.w	a2,s3
    80003e0c:	00090593          	mv	a1,s2
    80003e10:	01893503          	ld	a0,24(s2)
    80003e14:	00000097          	auipc	ra,0x0
    80003e18:	aac080e7          	jalr	-1364(ra) # 800038c0 <_ZN5Cache11slabListPutEPNS_4SlabEi>
}
    80003e1c:	00048513          	mv	a0,s1
    80003e20:	02813083          	ld	ra,40(sp)
    80003e24:	02013403          	ld	s0,32(sp)
    80003e28:	01813483          	ld	s1,24(sp)
    80003e2c:	01013903          	ld	s2,16(sp)
    80003e30:	00813983          	ld	s3,8(sp)
    80003e34:	03010113          	addi	sp,sp,48
    80003e38:	00008067          	ret
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80003e3c:	00090593          	mv	a1,s2
    80003e40:	01893503          	ld	a0,24(s2)
    80003e44:	00000097          	auipc	ra,0x0
    80003e48:	ac8080e7          	jalr	-1336(ra) # 8000390c <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80003e4c:	fbdff06f          	j	80003e08 <_ZN5Cache4Slab11getFreeSlotEv+0x80>
    if(!slotHead || state == FULL) return nullptr;
    80003e50:	00000493          	li	s1,0
    80003e54:	fc9ff06f          	j	80003e1c <_ZN5Cache4Slab11getFreeSlotEv+0x94>

0000000080003e58 <_ZN5Cache12allocateSlotEv>:
void *Cache::allocateSlot() {
    80003e58:	ff010113          	addi	sp,sp,-16
    80003e5c:	00113423          	sd	ra,8(sp)
    80003e60:	00813023          	sd	s0,0(sp)
    80003e64:	01010413          	addi	s0,sp,16
    80003e68:	00050793          	mv	a5,a0
    if(slabList[PARTIAL]) {
    80003e6c:	01053503          	ld	a0,16(a0)
    80003e70:	00050e63          	beqz	a0,80003e8c <_ZN5Cache12allocateSlotEv+0x34>
        return slab->getFreeSlot();
    80003e74:	00000097          	auipc	ra,0x0
    80003e78:	f14080e7          	jalr	-236(ra) # 80003d88 <_ZN5Cache4Slab11getFreeSlotEv>
}
    80003e7c:	00813083          	ld	ra,8(sp)
    80003e80:	00013403          	ld	s0,0(sp)
    80003e84:	01010113          	addi	sp,sp,16
    80003e88:	00008067          	ret
    else if(slabList[EMPTY]) {
    80003e8c:	0087b503          	ld	a0,8(a5)
    80003e90:	00050863          	beqz	a0,80003ea0 <_ZN5Cache12allocateSlotEv+0x48>
        Slot* slot = slab->getFreeSlot();
    80003e94:	00000097          	auipc	ra,0x0
    80003e98:	ef4080e7          	jalr	-268(ra) # 80003d88 <_ZN5Cache4Slab11getFreeSlotEv>
        return slot;
    80003e9c:	fe1ff06f          	j	80003e7c <_ZN5Cache12allocateSlotEv+0x24>
    Slab* slab = allocateSlab();
    80003ea0:	00078513          	mv	a0,a5
    80003ea4:	00000097          	auipc	ra,0x0
    80003ea8:	948080e7          	jalr	-1720(ra) # 800037ec <_ZN5Cache12allocateSlabEv>
    return slab->getFreeSlot();
    80003eac:	00000097          	auipc	ra,0x0
    80003eb0:	edc080e7          	jalr	-292(ra) # 80003d88 <_ZN5Cache4Slab11getFreeSlotEv>
    80003eb4:	fc9ff06f          	j	80003e7c <_ZN5Cache12allocateSlotEv+0x24>

0000000080003eb8 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;
void *MemoryAllocator::mem_alloc(size_t size) {
    80003eb8:	ff010113          	addi	sp,sp,-16
    80003ebc:	00813423          	sd	s0,8(sp)
    80003ec0:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80003ec4:	00005797          	auipc	a5,0x5
    80003ec8:	18c7b783          	ld	a5,396(a5) # 80009050 <_ZN15MemoryAllocator4headE>
    80003ecc:	02078c63          	beqz	a5,80003f04 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
    static void* userHeapStartAddr() {
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    }

    static void* userHeapEndAddr() {
        return (void*)HEAP_END_ADDR;
    80003ed0:	00005717          	auipc	a4,0x5
    80003ed4:	ff873703          	ld	a4,-8(a4) # 80008ec8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003ed8:	00073703          	ld	a4,0(a4)
        head = (FreeSegment*)userHeapStartAddr();
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    80003edc:	14e78263          	beq	a5,a4,80004020 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80003ee0:	00850713          	addi	a4,a0,8
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80003ee4:	00675813          	srli	a6,a4,0x6
    80003ee8:	03f77793          	andi	a5,a4,63
    80003eec:	00f037b3          	snez	a5,a5
    80003ef0:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80003ef4:	00005517          	auipc	a0,0x5
    80003ef8:	15c53503          	ld	a0,348(a0) # 80009050 <_ZN15MemoryAllocator4headE>
    80003efc:	00000613          	li	a2,0
    80003f00:	0b40006f          	j	80003fb4 <_ZN15MemoryAllocator9mem_allocEm+0xfc>
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    80003f04:	00005797          	auipc	a5,0x5
    80003f08:	f747b783          	ld	a5,-140(a5) # 80008e78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003f0c:	0007b703          	ld	a4,0(a5)
    80003f10:	010007b7          	lui	a5,0x1000
    80003f14:	00f707b3          	add	a5,a4,a5
        head = (FreeSegment*)userHeapStartAddr();
    80003f18:	00005697          	auipc	a3,0x5
    80003f1c:	12f6bc23          	sd	a5,312(a3) # 80009050 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
    80003f20:	020006b7          	lui	a3,0x2000
    80003f24:	00d70733          	add	a4,a4,a3
    80003f28:	00e7b023          	sd	a4,0(a5) # 1000000 <_entry-0x7f000000>
        return (void*)HEAP_END_ADDR;
    80003f2c:	00005717          	auipc	a4,0x5
    80003f30:	f9c73703          	ld	a4,-100(a4) # 80008ec8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003f34:	00073703          	ld	a4,0(a4)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    80003f38:	40f70733          	sub	a4,a4,a5
    80003f3c:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80003f40:	0007b823          	sd	zero,16(a5)
    80003f44:	f9dff06f          	j	80003ee0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80003f48:	00060e63          	beqz	a2,80003f64 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            if(!prev->next) return;
    80003f4c:	01063703          	ld	a4,16(a2)
    80003f50:	04070a63          	beqz	a4,80003fa4 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    80003f54:	01073703          	ld	a4,16(a4)
    80003f58:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80003f5c:	00078813          	mv	a6,a5
    80003f60:	0ac0006f          	j	8000400c <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80003f64:	01053703          	ld	a4,16(a0)
    80003f68:	00070a63          	beqz	a4,80003f7c <_ZN15MemoryAllocator9mem_allocEm+0xc4>
                        head = (FreeSegment*)userHeapEndAddr();
                    }
                    else {
                        head = curr->next;
    80003f6c:	00005697          	auipc	a3,0x5
    80003f70:	0ee6b223          	sd	a4,228(a3) # 80009050 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80003f74:	00078813          	mv	a6,a5
    80003f78:	0940006f          	j	8000400c <_ZN15MemoryAllocator9mem_allocEm+0x154>
        return (void*)HEAP_END_ADDR;
    80003f7c:	00005717          	auipc	a4,0x5
    80003f80:	f4c73703          	ld	a4,-180(a4) # 80008ec8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003f84:	00073703          	ld	a4,0(a4)
                        head = (FreeSegment*)userHeapEndAddr();
    80003f88:	00005697          	auipc	a3,0x5
    80003f8c:	0ce6b423          	sd	a4,200(a3) # 80009050 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80003f90:	00078813          	mv	a6,a5
    80003f94:	0780006f          	j	8000400c <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80003f98:	00005797          	auipc	a5,0x5
    80003f9c:	0ae7bc23          	sd	a4,184(a5) # 80009050 <_ZN15MemoryAllocator4headE>
    80003fa0:	06c0006f          	j	8000400c <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80003fa4:	00078813          	mv	a6,a5
    80003fa8:	0640006f          	j	8000400c <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80003fac:	00050613          	mv	a2,a0
        curr = curr->next;
    80003fb0:	01053503          	ld	a0,16(a0)
    while(curr) {
    80003fb4:	06050063          	beqz	a0,80004014 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80003fb8:	00853783          	ld	a5,8(a0)
    80003fbc:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80003fc0:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80003fc4:	fee7e4e3          	bltu	a5,a4,80003fac <_ZN15MemoryAllocator9mem_allocEm+0xf4>
    80003fc8:	ff06e2e3          	bltu	a3,a6,80003fac <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80003fcc:	f7068ee3          	beq	a3,a6,80003f48 <_ZN15MemoryAllocator9mem_allocEm+0x90>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80003fd0:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80003fd4:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80003fd8:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80003fdc:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80003fe0:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80003fe4:	01053783          	ld	a5,16(a0)
    80003fe8:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80003fec:	fa0606e3          	beqz	a2,80003f98 <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            if(!prev->next) return;
    80003ff0:	01063783          	ld	a5,16(a2)
    80003ff4:	00078663          	beqz	a5,80004000 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    80003ff8:	0107b783          	ld	a5,16(a5)
    80003ffc:	00f63823          	sd	a5,16(a2)
            curr->next = prev->next;
    80004000:	01063783          	ld	a5,16(a2)
    80004004:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80004008:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    8000400c:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80004010:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80004014:	00813403          	ld	s0,8(sp)
    80004018:	01010113          	addi	sp,sp,16
    8000401c:	00008067          	ret
        return nullptr;
    80004020:	00000513          	li	a0,0
    80004024:	ff1ff06f          	j	80004014 <_ZN15MemoryAllocator9mem_allocEm+0x15c>

0000000080004028 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80004028:	ff010113          	addi	sp,sp,-16
    8000402c:	00813423          	sd	s0,8(sp)
    80004030:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004034:	16050463          	beqz	a0,8000419c <_ZN15MemoryAllocator8mem_freeEPv+0x174>
    80004038:	ff850713          	addi	a4,a0,-8
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    8000403c:	00005797          	auipc	a5,0x5
    80004040:	e3c7b783          	ld	a5,-452(a5) # 80008e78 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004044:	0007b783          	ld	a5,0(a5)
    80004048:	010006b7          	lui	a3,0x1000
    8000404c:	00d787b3          	add	a5,a5,a3
    80004050:	14f76a63          	bltu	a4,a5,800041a4 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80004054:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80004058:	fff58693          	addi	a3,a1,-1
    8000405c:	00d706b3          	add	a3,a4,a3
        return (void*)HEAP_END_ADDR;
    80004060:	00005617          	auipc	a2,0x5
    80004064:	e6863603          	ld	a2,-408(a2) # 80008ec8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004068:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000406c:	14c6f063          	bgeu	a3,a2,800041ac <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80004070:	14070263          	beqz	a4,800041b4 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
        return (size_t)address - (size_t)userHeapStartAddr();
    80004074:	40f707b3          	sub	a5,a4,a5
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80004078:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000407c:	14079063          	bnez	a5,800041bc <_ZN15MemoryAllocator8mem_freeEPv+0x194>
    80004080:	03f00793          	li	a5,63
    80004084:	14b7f063          	bgeu	a5,a1,800041c4 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
        return BAD_POINTER;
    }

    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    80004088:	00005797          	auipc	a5,0x5
    8000408c:	fc87b783          	ld	a5,-56(a5) # 80009050 <_ZN15MemoryAllocator4headE>
    80004090:	02c78063          	beq	a5,a2,800040b0 <_ZN15MemoryAllocator8mem_freeEPv+0x88>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80004094:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80004098:	02078a63          	beqz	a5,800040cc <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
    8000409c:	0007b683          	ld	a3,0(a5)
    800040a0:	02e6f663          	bgeu	a3,a4,800040cc <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
        prev = curr;
    800040a4:	00078613          	mv	a2,a5
        curr = curr->next;
    800040a8:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800040ac:	fedff06f          	j	80004098 <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        newFreeSegment->size = size;
    800040b0:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    800040b4:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800040b8:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800040bc:	00005797          	auipc	a5,0x5
    800040c0:	f8e7ba23          	sd	a4,-108(a5) # 80009050 <_ZN15MemoryAllocator4headE>
        return 0;
    800040c4:	00000513          	li	a0,0
    800040c8:	0480006f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    }

    if(prev == nullptr) {
    800040cc:	04060863          	beqz	a2,8000411c <_ZN15MemoryAllocator8mem_freeEPv+0xf4>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800040d0:	00063683          	ld	a3,0(a2)
    800040d4:	00863803          	ld	a6,8(a2)
    800040d8:	010686b3          	add	a3,a3,a6
    800040dc:	08e68a63          	beq	a3,a4,80004170 <_ZN15MemoryAllocator8mem_freeEPv+0x148>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800040e0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800040e4:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800040e8:	01063683          	ld	a3,16(a2)
    800040ec:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800040f0:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800040f4:	0e078063          	beqz	a5,800041d4 <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    800040f8:	0007b583          	ld	a1,0(a5)
    800040fc:	00073683          	ld	a3,0(a4)
    80004100:	00873603          	ld	a2,8(a4)
    80004104:	00c686b3          	add	a3,a3,a2
    80004108:	06d58c63          	beq	a1,a3,80004180 <_ZN15MemoryAllocator8mem_freeEPv+0x158>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    8000410c:	00000513          	li	a0,0
}
    80004110:	00813403          	ld	s0,8(sp)
    80004114:	01010113          	addi	sp,sp,16
    80004118:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    8000411c:	0a078863          	beqz	a5,800041cc <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
            newFreeSegment->size = size;
    80004120:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80004124:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80004128:	00005797          	auipc	a5,0x5
    8000412c:	f287b783          	ld	a5,-216(a5) # 80009050 <_ZN15MemoryAllocator4headE>
    80004130:	0007b603          	ld	a2,0(a5)
    80004134:	00b706b3          	add	a3,a4,a1
    80004138:	00d60c63          	beq	a2,a3,80004150 <_ZN15MemoryAllocator8mem_freeEPv+0x128>
                newFreeSegment->next = head;
    8000413c:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80004140:	00005797          	auipc	a5,0x5
    80004144:	f0e7b823          	sd	a4,-240(a5) # 80009050 <_ZN15MemoryAllocator4headE>
            return 0;
    80004148:	00000513          	li	a0,0
    8000414c:	fc5ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
                newFreeSegment->size += head->size;
    80004150:	0087b783          	ld	a5,8(a5)
    80004154:	00b785b3          	add	a1,a5,a1
    80004158:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000415c:	00005797          	auipc	a5,0x5
    80004160:	ef47b783          	ld	a5,-268(a5) # 80009050 <_ZN15MemoryAllocator4headE>
    80004164:	0107b783          	ld	a5,16(a5)
    80004168:	00f53423          	sd	a5,8(a0)
    8000416c:	fd5ff06f          	j	80004140 <_ZN15MemoryAllocator8mem_freeEPv+0x118>
            prev->size += size;
    80004170:	00b805b3          	add	a1,a6,a1
    80004174:	00b63423          	sd	a1,8(a2)
    80004178:	00060713          	mv	a4,a2
    8000417c:	f79ff06f          	j	800040f4 <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
            prev->size += curr->size;
    80004180:	0087b683          	ld	a3,8(a5)
    80004184:	00d60633          	add	a2,a2,a3
    80004188:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000418c:	0107b783          	ld	a5,16(a5)
    80004190:	00f73823          	sd	a5,16(a4)
    return 0;
    80004194:	00000513          	li	a0,0
    80004198:	f79ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    8000419c:	fff00513          	li	a0,-1
    800041a0:	f71ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    800041a4:	fff00513          	li	a0,-1
    800041a8:	f69ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
        return BAD_POINTER;
    800041ac:	fff00513          	li	a0,-1
    800041b0:	f61ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    800041b4:	fff00513          	li	a0,-1
    800041b8:	f59ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    800041bc:	fff00513          	li	a0,-1
    800041c0:	f51ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    800041c4:	fff00513          	li	a0,-1
    800041c8:	f49ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
            return BAD_POINTER;
    800041cc:	fff00513          	li	a0,-1
    800041d0:	f41ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    return 0;
    800041d4:	00000513          	li	a0,0
    800041d8:	f39ff06f          	j	80004110 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>

00000000800041dc <_Z9kmem_initPvi>:
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    800041dc:	ff010113          	addi	sp,sp,-16
    800041e0:	00113423          	sd	ra,8(sp)
    800041e4:	00813023          	sd	s0,0(sp)
    800041e8:	01010413          	addi	s0,sp,16
    SlabAllocator::initAllocator(space, block_num);
    800041ec:	ffffe097          	auipc	ra,0xffffe
    800041f0:	39c080e7          	jalr	924(ra) # 80002588 <_ZN13SlabAllocator13initAllocatorEPvi>
}
    800041f4:	00813083          	ld	ra,8(sp)
    800041f8:	00013403          	ld	s0,0(sp)
    800041fc:	01010113          	addi	sp,sp,16
    80004200:	00008067          	ret

0000000080004204 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004204:	ff010113          	addi	sp,sp,-16
    80004208:	00113423          	sd	ra,8(sp)
    8000420c:	00813023          	sd	s0,0(sp)
    80004210:	01010413          	addi	s0,sp,16
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
    80004214:	ffffe097          	auipc	ra,0xffffe
    80004218:	39c080e7          	jalr	924(ra) # 800025b0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    8000421c:	00813083          	ld	ra,8(sp)
    80004220:	00013403          	ld	s0,0(sp)
    80004224:	01010113          	addi	sp,sp,16
    80004228:	00008067          	ret

000000008000422c <_Z17kmem_cache_shrinkP12kmem_cache_s>:

int kmem_cache_shrink(kmem_cache_t *cachep) {
    8000422c:	ff010113          	addi	sp,sp,-16
    80004230:	00113423          	sd	ra,8(sp)
    80004234:	00813023          	sd	s0,0(sp)
    80004238:	01010413          	addi	s0,sp,16
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
    8000423c:	ffffe097          	auipc	ra,0xffffe
    80004240:	4a0080e7          	jalr	1184(ra) # 800026dc <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>
}
    80004244:	00813083          	ld	ra,8(sp)
    80004248:	00013403          	ld	s0,0(sp)
    8000424c:	01010113          	addi	sp,sp,16
    80004250:	00008067          	ret

0000000080004254 <_Z16kmem_cache_allocP12kmem_cache_s>:
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    80004254:	ff010113          	addi	sp,sp,-16
    80004258:	00113423          	sd	ra,8(sp)
    8000425c:	00813023          	sd	s0,0(sp)
    80004260:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocSlot((Cache*)cachep);
    80004264:	ffffe097          	auipc	ra,0xffffe
    80004268:	3d0080e7          	jalr	976(ra) # 80002634 <_ZN13SlabAllocator9allocSlotEP5Cache>
}
    8000426c:	00813083          	ld	ra,8(sp)
    80004270:	00013403          	ld	s0,0(sp)
    80004274:	01010113          	addi	sp,sp,16
    80004278:	00008067          	ret

000000008000427c <_Z15kmem_cache_freeP12kmem_cache_sPv>:
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    8000427c:	ff010113          	addi	sp,sp,-16
    80004280:	00113423          	sd	ra,8(sp)
    80004284:	00813023          	sd	s0,0(sp)
    80004288:	01010413          	addi	s0,sp,16
    SlabAllocator::freeSlot((Cache*)cachep, objp);
    8000428c:	ffffe097          	auipc	ra,0xffffe
    80004290:	3d4080e7          	jalr	980(ra) # 80002660 <_ZN13SlabAllocator8freeSlotEP5CachePv>
}
    80004294:	00813083          	ld	ra,8(sp)
    80004298:	00013403          	ld	s0,0(sp)
    8000429c:	01010113          	addi	sp,sp,16
    800042a0:	00008067          	ret

00000000800042a4 <_Z18kmem_cache_destroyP12kmem_cache_s>:

void *kmalloc(size_t size); // Alloacate one small memory buffer
void kfree(const void *objp); // Deallocate one small memory buffer
void kmem_cache_destroy(kmem_cache_t *cachep) {
    800042a4:	ff010113          	addi	sp,sp,-16
    800042a8:	00113423          	sd	ra,8(sp)
    800042ac:	00813023          	sd	s0,0(sp)
    800042b0:	01010413          	addi	s0,sp,16
    SlabAllocator::deallocCache((Cache*)cachep);
    800042b4:	ffffe097          	auipc	ra,0xffffe
    800042b8:	450080e7          	jalr	1104(ra) # 80002704 <_ZN13SlabAllocator12deallocCacheEP5Cache>
}
    800042bc:	00813083          	ld	ra,8(sp)
    800042c0:	00013403          	ld	s0,0(sp)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret

00000000800042cc <_Z15kmem_cache_infoP12kmem_cache_s>:
void kmem_cache_info(kmem_cache_t *cachep) {
    800042cc:	ff010113          	addi	sp,sp,-16
    800042d0:	00113423          	sd	ra,8(sp)
    800042d4:	00813023          	sd	s0,0(sp)
    800042d8:	01010413          	addi	s0,sp,16
    SlabAllocator::printCacheInfo((Cache*)cachep);
    800042dc:	ffffe097          	auipc	ra,0xffffe
    800042e0:	3d8080e7          	jalr	984(ra) # 800026b4 <_ZN13SlabAllocator14printCacheInfoEP5Cache>
}
    800042e4:	00813083          	ld	ra,8(sp)
    800042e8:	00013403          	ld	s0,0(sp)
    800042ec:	01010113          	addi	sp,sp,16
    800042f0:	00008067          	ret

00000000800042f4 <_Z16kmem_cache_errorP12kmem_cache_s>:
int kmem_cache_error(kmem_cache_t *cachep) {
    800042f4:	ff010113          	addi	sp,sp,-16
    800042f8:	00113423          	sd	ra,8(sp)
    800042fc:	00813023          	sd	s0,0(sp)
    80004300:	01010413          	addi	s0,sp,16
    return SlabAllocator::printErrorMessage((Cache*)cachep);
    80004304:	ffffe097          	auipc	ra,0xffffe
    80004308:	388080e7          	jalr	904(ra) # 8000268c <_ZN13SlabAllocator17printErrorMessageEP5Cache>
    8000430c:	00813083          	ld	ra,8(sp)
    80004310:	00013403          	ld	s0,0(sp)
    80004314:	01010113          	addi	sp,sp,16
    80004318:	00008067          	ret

000000008000431c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000431c:	fd010113          	addi	sp,sp,-48
    80004320:	02113423          	sd	ra,40(sp)
    80004324:	02813023          	sd	s0,32(sp)
    80004328:	00913c23          	sd	s1,24(sp)
    8000432c:	01213823          	sd	s2,16(sp)
    80004330:	01313423          	sd	s3,8(sp)
    80004334:	03010413          	addi	s0,sp,48
    80004338:	00050493          	mv	s1,a0
    8000433c:	00058913          	mv	s2,a1
    80004340:	0015879b          	addiw	a5,a1,1
    80004344:	0007851b          	sext.w	a0,a5
    80004348:	00f4a023          	sw	a5,0(s1)
    8000434c:	0004a823          	sw	zero,16(s1)
    80004350:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004354:	00251513          	slli	a0,a0,0x2
    80004358:	ffffd097          	auipc	ra,0xffffd
    8000435c:	e3c080e7          	jalr	-452(ra) # 80001194 <_Z9mem_allocm>
    80004360:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004364:	01000513          	li	a0,16
    80004368:	fffff097          	auipc	ra,0xfffff
    8000436c:	e40080e7          	jalr	-448(ra) # 800031a8 <_ZN9SemaphorenwEm>
    80004370:	00050993          	mv	s3,a0
    80004374:	00000593          	li	a1,0
    80004378:	fffff097          	auipc	ra,0xfffff
    8000437c:	d10080e7          	jalr	-752(ra) # 80003088 <_ZN9SemaphoreC1Ej>
    80004380:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004384:	01000513          	li	a0,16
    80004388:	fffff097          	auipc	ra,0xfffff
    8000438c:	e20080e7          	jalr	-480(ra) # 800031a8 <_ZN9SemaphorenwEm>
    80004390:	00050993          	mv	s3,a0
    80004394:	00090593          	mv	a1,s2
    80004398:	fffff097          	auipc	ra,0xfffff
    8000439c:	cf0080e7          	jalr	-784(ra) # 80003088 <_ZN9SemaphoreC1Ej>
    800043a0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800043a4:	01000513          	li	a0,16
    800043a8:	fffff097          	auipc	ra,0xfffff
    800043ac:	e00080e7          	jalr	-512(ra) # 800031a8 <_ZN9SemaphorenwEm>
    800043b0:	00050913          	mv	s2,a0
    800043b4:	00100593          	li	a1,1
    800043b8:	fffff097          	auipc	ra,0xfffff
    800043bc:	cd0080e7          	jalr	-816(ra) # 80003088 <_ZN9SemaphoreC1Ej>
    800043c0:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800043c4:	01000513          	li	a0,16
    800043c8:	fffff097          	auipc	ra,0xfffff
    800043cc:	de0080e7          	jalr	-544(ra) # 800031a8 <_ZN9SemaphorenwEm>
    800043d0:	00050913          	mv	s2,a0
    800043d4:	00100593          	li	a1,1
    800043d8:	fffff097          	auipc	ra,0xfffff
    800043dc:	cb0080e7          	jalr	-848(ra) # 80003088 <_ZN9SemaphoreC1Ej>
    800043e0:	0324b823          	sd	s2,48(s1)
}
    800043e4:	02813083          	ld	ra,40(sp)
    800043e8:	02013403          	ld	s0,32(sp)
    800043ec:	01813483          	ld	s1,24(sp)
    800043f0:	01013903          	ld	s2,16(sp)
    800043f4:	00813983          	ld	s3,8(sp)
    800043f8:	03010113          	addi	sp,sp,48
    800043fc:	00008067          	ret
    80004400:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004404:	00098513          	mv	a0,s3
    80004408:	fffff097          	auipc	ra,0xfffff
    8000440c:	d38080e7          	jalr	-712(ra) # 80003140 <_ZN9SemaphoredlEPv>
    80004410:	00048513          	mv	a0,s1
    80004414:	00006097          	auipc	ra,0x6
    80004418:	d14080e7          	jalr	-748(ra) # 8000a128 <_Unwind_Resume>
    8000441c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004420:	00098513          	mv	a0,s3
    80004424:	fffff097          	auipc	ra,0xfffff
    80004428:	d1c080e7          	jalr	-740(ra) # 80003140 <_ZN9SemaphoredlEPv>
    8000442c:	00048513          	mv	a0,s1
    80004430:	00006097          	auipc	ra,0x6
    80004434:	cf8080e7          	jalr	-776(ra) # 8000a128 <_Unwind_Resume>
    80004438:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000443c:	00090513          	mv	a0,s2
    80004440:	fffff097          	auipc	ra,0xfffff
    80004444:	d00080e7          	jalr	-768(ra) # 80003140 <_ZN9SemaphoredlEPv>
    80004448:	00048513          	mv	a0,s1
    8000444c:	00006097          	auipc	ra,0x6
    80004450:	cdc080e7          	jalr	-804(ra) # 8000a128 <_Unwind_Resume>
    80004454:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004458:	00090513          	mv	a0,s2
    8000445c:	fffff097          	auipc	ra,0xfffff
    80004460:	ce4080e7          	jalr	-796(ra) # 80003140 <_ZN9SemaphoredlEPv>
    80004464:	00048513          	mv	a0,s1
    80004468:	00006097          	auipc	ra,0x6
    8000446c:	cc0080e7          	jalr	-832(ra) # 8000a128 <_Unwind_Resume>

0000000080004470 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004470:	fe010113          	addi	sp,sp,-32
    80004474:	00113c23          	sd	ra,24(sp)
    80004478:	00813823          	sd	s0,16(sp)
    8000447c:	00913423          	sd	s1,8(sp)
    80004480:	01213023          	sd	s2,0(sp)
    80004484:	02010413          	addi	s0,sp,32
    80004488:	00050493          	mv	s1,a0
    8000448c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004490:	01853503          	ld	a0,24(a0)
    80004494:	fffff097          	auipc	ra,0xfffff
    80004498:	c54080e7          	jalr	-940(ra) # 800030e8 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000449c:	0304b503          	ld	a0,48(s1)
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	c48080e7          	jalr	-952(ra) # 800030e8 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800044a8:	0084b783          	ld	a5,8(s1)
    800044ac:	0144a703          	lw	a4,20(s1)
    800044b0:	00271713          	slli	a4,a4,0x2
    800044b4:	00e787b3          	add	a5,a5,a4
    800044b8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800044bc:	0144a783          	lw	a5,20(s1)
    800044c0:	0017879b          	addiw	a5,a5,1
    800044c4:	0004a703          	lw	a4,0(s1)
    800044c8:	02e7e7bb          	remw	a5,a5,a4
    800044cc:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800044d0:	0304b503          	ld	a0,48(s1)
    800044d4:	fffff097          	auipc	ra,0xfffff
    800044d8:	c40080e7          	jalr	-960(ra) # 80003114 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800044dc:	0204b503          	ld	a0,32(s1)
    800044e0:	fffff097          	auipc	ra,0xfffff
    800044e4:	c34080e7          	jalr	-972(ra) # 80003114 <_ZN9Semaphore6signalEv>

}
    800044e8:	01813083          	ld	ra,24(sp)
    800044ec:	01013403          	ld	s0,16(sp)
    800044f0:	00813483          	ld	s1,8(sp)
    800044f4:	00013903          	ld	s2,0(sp)
    800044f8:	02010113          	addi	sp,sp,32
    800044fc:	00008067          	ret

0000000080004500 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004500:	fe010113          	addi	sp,sp,-32
    80004504:	00113c23          	sd	ra,24(sp)
    80004508:	00813823          	sd	s0,16(sp)
    8000450c:	00913423          	sd	s1,8(sp)
    80004510:	01213023          	sd	s2,0(sp)
    80004514:	02010413          	addi	s0,sp,32
    80004518:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000451c:	02053503          	ld	a0,32(a0)
    80004520:	fffff097          	auipc	ra,0xfffff
    80004524:	bc8080e7          	jalr	-1080(ra) # 800030e8 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004528:	0284b503          	ld	a0,40(s1)
    8000452c:	fffff097          	auipc	ra,0xfffff
    80004530:	bbc080e7          	jalr	-1092(ra) # 800030e8 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004534:	0084b703          	ld	a4,8(s1)
    80004538:	0104a783          	lw	a5,16(s1)
    8000453c:	00279693          	slli	a3,a5,0x2
    80004540:	00d70733          	add	a4,a4,a3
    80004544:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004548:	0017879b          	addiw	a5,a5,1
    8000454c:	0004a703          	lw	a4,0(s1)
    80004550:	02e7e7bb          	remw	a5,a5,a4
    80004554:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004558:	0284b503          	ld	a0,40(s1)
    8000455c:	fffff097          	auipc	ra,0xfffff
    80004560:	bb8080e7          	jalr	-1096(ra) # 80003114 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004564:	0184b503          	ld	a0,24(s1)
    80004568:	fffff097          	auipc	ra,0xfffff
    8000456c:	bac080e7          	jalr	-1108(ra) # 80003114 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004570:	00090513          	mv	a0,s2
    80004574:	01813083          	ld	ra,24(sp)
    80004578:	01013403          	ld	s0,16(sp)
    8000457c:	00813483          	ld	s1,8(sp)
    80004580:	00013903          	ld	s2,0(sp)
    80004584:	02010113          	addi	sp,sp,32
    80004588:	00008067          	ret

000000008000458c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000458c:	fe010113          	addi	sp,sp,-32
    80004590:	00113c23          	sd	ra,24(sp)
    80004594:	00813823          	sd	s0,16(sp)
    80004598:	00913423          	sd	s1,8(sp)
    8000459c:	01213023          	sd	s2,0(sp)
    800045a0:	02010413          	addi	s0,sp,32
    800045a4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800045a8:	02853503          	ld	a0,40(a0)
    800045ac:	fffff097          	auipc	ra,0xfffff
    800045b0:	b3c080e7          	jalr	-1220(ra) # 800030e8 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800045b4:	0304b503          	ld	a0,48(s1)
    800045b8:	fffff097          	auipc	ra,0xfffff
    800045bc:	b30080e7          	jalr	-1232(ra) # 800030e8 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800045c0:	0144a783          	lw	a5,20(s1)
    800045c4:	0104a903          	lw	s2,16(s1)
    800045c8:	0327ce63          	blt	a5,s2,80004604 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800045cc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800045d0:	0304b503          	ld	a0,48(s1)
    800045d4:	fffff097          	auipc	ra,0xfffff
    800045d8:	b40080e7          	jalr	-1216(ra) # 80003114 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800045dc:	0284b503          	ld	a0,40(s1)
    800045e0:	fffff097          	auipc	ra,0xfffff
    800045e4:	b34080e7          	jalr	-1228(ra) # 80003114 <_ZN9Semaphore6signalEv>

    return ret;
}
    800045e8:	00090513          	mv	a0,s2
    800045ec:	01813083          	ld	ra,24(sp)
    800045f0:	01013403          	ld	s0,16(sp)
    800045f4:	00813483          	ld	s1,8(sp)
    800045f8:	00013903          	ld	s2,0(sp)
    800045fc:	02010113          	addi	sp,sp,32
    80004600:	00008067          	ret
        ret = cap - head + tail;
    80004604:	0004a703          	lw	a4,0(s1)
    80004608:	4127093b          	subw	s2,a4,s2
    8000460c:	00f9093b          	addw	s2,s2,a5
    80004610:	fc1ff06f          	j	800045d0 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004614 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004614:	fe010113          	addi	sp,sp,-32
    80004618:	00113c23          	sd	ra,24(sp)
    8000461c:	00813823          	sd	s0,16(sp)
    80004620:	00913423          	sd	s1,8(sp)
    80004624:	02010413          	addi	s0,sp,32
    80004628:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000462c:	00a00513          	li	a0,10
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	c44080e7          	jalr	-956(ra) # 80003274 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004638:	00003517          	auipc	a0,0x3
    8000463c:	be850513          	addi	a0,a0,-1048 # 80007220 <CONSOLE_STATUS+0x210>
    80004640:	ffffe097          	auipc	ra,0xffffe
    80004644:	0ec080e7          	jalr	236(ra) # 8000272c <_Z11printStringPKc>
    while (getCnt()) {
    80004648:	00048513          	mv	a0,s1
    8000464c:	00000097          	auipc	ra,0x0
    80004650:	f40080e7          	jalr	-192(ra) # 8000458c <_ZN9BufferCPP6getCntEv>
    80004654:	02050c63          	beqz	a0,8000468c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004658:	0084b783          	ld	a5,8(s1)
    8000465c:	0104a703          	lw	a4,16(s1)
    80004660:	00271713          	slli	a4,a4,0x2
    80004664:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004668:	0007c503          	lbu	a0,0(a5)
    8000466c:	fffff097          	auipc	ra,0xfffff
    80004670:	c08080e7          	jalr	-1016(ra) # 80003274 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004674:	0104a783          	lw	a5,16(s1)
    80004678:	0017879b          	addiw	a5,a5,1
    8000467c:	0004a703          	lw	a4,0(s1)
    80004680:	02e7e7bb          	remw	a5,a5,a4
    80004684:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004688:	fc1ff06f          	j	80004648 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000468c:	02100513          	li	a0,33
    80004690:	fffff097          	auipc	ra,0xfffff
    80004694:	be4080e7          	jalr	-1052(ra) # 80003274 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004698:	00a00513          	li	a0,10
    8000469c:	fffff097          	auipc	ra,0xfffff
    800046a0:	bd8080e7          	jalr	-1064(ra) # 80003274 <_ZN7Console4putcEc>
    mem_free(buffer);
    800046a4:	0084b503          	ld	a0,8(s1)
    800046a8:	ffffd097          	auipc	ra,0xffffd
    800046ac:	b2c080e7          	jalr	-1236(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    800046b0:	0204b503          	ld	a0,32(s1)
    800046b4:	00050863          	beqz	a0,800046c4 <_ZN9BufferCPPD1Ev+0xb0>
    800046b8:	00053783          	ld	a5,0(a0)
    800046bc:	0087b783          	ld	a5,8(a5)
    800046c0:	000780e7          	jalr	a5
    delete spaceAvailable;
    800046c4:	0184b503          	ld	a0,24(s1)
    800046c8:	00050863          	beqz	a0,800046d8 <_ZN9BufferCPPD1Ev+0xc4>
    800046cc:	00053783          	ld	a5,0(a0)
    800046d0:	0087b783          	ld	a5,8(a5)
    800046d4:	000780e7          	jalr	a5
    delete mutexTail;
    800046d8:	0304b503          	ld	a0,48(s1)
    800046dc:	00050863          	beqz	a0,800046ec <_ZN9BufferCPPD1Ev+0xd8>
    800046e0:	00053783          	ld	a5,0(a0)
    800046e4:	0087b783          	ld	a5,8(a5)
    800046e8:	000780e7          	jalr	a5
    delete mutexHead;
    800046ec:	0284b503          	ld	a0,40(s1)
    800046f0:	00050863          	beqz	a0,80004700 <_ZN9BufferCPPD1Ev+0xec>
    800046f4:	00053783          	ld	a5,0(a0)
    800046f8:	0087b783          	ld	a5,8(a5)
    800046fc:	000780e7          	jalr	a5
}
    80004700:	01813083          	ld	ra,24(sp)
    80004704:	01013403          	ld	s0,16(sp)
    80004708:	00813483          	ld	s1,8(sp)
    8000470c:	02010113          	addi	sp,sp,32
    80004710:	00008067          	ret

0000000080004714 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004714:	fe010113          	addi	sp,sp,-32
    80004718:	00113c23          	sd	ra,24(sp)
    8000471c:	00813823          	sd	s0,16(sp)
    80004720:	00913423          	sd	s1,8(sp)
    80004724:	01213023          	sd	s2,0(sp)
    80004728:	02010413          	addi	s0,sp,32
    8000472c:	00050493          	mv	s1,a0
    80004730:	00058913          	mv	s2,a1
    80004734:	0015879b          	addiw	a5,a1,1
    80004738:	0007851b          	sext.w	a0,a5
    8000473c:	00f4a023          	sw	a5,0(s1)
    80004740:	0004a823          	sw	zero,16(s1)
    80004744:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004748:	00251513          	slli	a0,a0,0x2
    8000474c:	ffffd097          	auipc	ra,0xffffd
    80004750:	a48080e7          	jalr	-1464(ra) # 80001194 <_Z9mem_allocm>
    80004754:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004758:	00000593          	li	a1,0
    8000475c:	02048513          	addi	a0,s1,32
    80004760:	ffffd097          	auipc	ra,0xffffd
    80004764:	bf0080e7          	jalr	-1040(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80004768:	00090593          	mv	a1,s2
    8000476c:	01848513          	addi	a0,s1,24
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	be0080e7          	jalr	-1056(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80004778:	00100593          	li	a1,1
    8000477c:	02848513          	addi	a0,s1,40
    80004780:	ffffd097          	auipc	ra,0xffffd
    80004784:	bd0080e7          	jalr	-1072(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80004788:	00100593          	li	a1,1
    8000478c:	03048513          	addi	a0,s1,48
    80004790:	ffffd097          	auipc	ra,0xffffd
    80004794:	bc0080e7          	jalr	-1088(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80004798:	01813083          	ld	ra,24(sp)
    8000479c:	01013403          	ld	s0,16(sp)
    800047a0:	00813483          	ld	s1,8(sp)
    800047a4:	00013903          	ld	s2,0(sp)
    800047a8:	02010113          	addi	sp,sp,32
    800047ac:	00008067          	ret

00000000800047b0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800047b0:	fe010113          	addi	sp,sp,-32
    800047b4:	00113c23          	sd	ra,24(sp)
    800047b8:	00813823          	sd	s0,16(sp)
    800047bc:	00913423          	sd	s1,8(sp)
    800047c0:	01213023          	sd	s2,0(sp)
    800047c4:	02010413          	addi	s0,sp,32
    800047c8:	00050493          	mv	s1,a0
    800047cc:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800047d0:	01853503          	ld	a0,24(a0)
    800047d4:	ffffd097          	auipc	ra,0xffffd
    800047d8:	bc4080e7          	jalr	-1084(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    800047dc:	0304b503          	ld	a0,48(s1)
    800047e0:	ffffd097          	auipc	ra,0xffffd
    800047e4:	bb8080e7          	jalr	-1096(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    800047e8:	0084b783          	ld	a5,8(s1)
    800047ec:	0144a703          	lw	a4,20(s1)
    800047f0:	00271713          	slli	a4,a4,0x2
    800047f4:	00e787b3          	add	a5,a5,a4
    800047f8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800047fc:	0144a783          	lw	a5,20(s1)
    80004800:	0017879b          	addiw	a5,a5,1
    80004804:	0004a703          	lw	a4,0(s1)
    80004808:	02e7e7bb          	remw	a5,a5,a4
    8000480c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004810:	0304b503          	ld	a0,48(s1)
    80004814:	ffffd097          	auipc	ra,0xffffd
    80004818:	bcc080e7          	jalr	-1076(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    8000481c:	0204b503          	ld	a0,32(s1)
    80004820:	ffffd097          	auipc	ra,0xffffd
    80004824:	bc0080e7          	jalr	-1088(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80004828:	01813083          	ld	ra,24(sp)
    8000482c:	01013403          	ld	s0,16(sp)
    80004830:	00813483          	ld	s1,8(sp)
    80004834:	00013903          	ld	s2,0(sp)
    80004838:	02010113          	addi	sp,sp,32
    8000483c:	00008067          	ret

0000000080004840 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004840:	fe010113          	addi	sp,sp,-32
    80004844:	00113c23          	sd	ra,24(sp)
    80004848:	00813823          	sd	s0,16(sp)
    8000484c:	00913423          	sd	s1,8(sp)
    80004850:	01213023          	sd	s2,0(sp)
    80004854:	02010413          	addi	s0,sp,32
    80004858:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000485c:	02053503          	ld	a0,32(a0)
    80004860:	ffffd097          	auipc	ra,0xffffd
    80004864:	b38080e7          	jalr	-1224(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80004868:	0284b503          	ld	a0,40(s1)
    8000486c:	ffffd097          	auipc	ra,0xffffd
    80004870:	b2c080e7          	jalr	-1236(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80004874:	0084b703          	ld	a4,8(s1)
    80004878:	0104a783          	lw	a5,16(s1)
    8000487c:	00279693          	slli	a3,a5,0x2
    80004880:	00d70733          	add	a4,a4,a3
    80004884:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004888:	0017879b          	addiw	a5,a5,1
    8000488c:	0004a703          	lw	a4,0(s1)
    80004890:	02e7e7bb          	remw	a5,a5,a4
    80004894:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004898:	0284b503          	ld	a0,40(s1)
    8000489c:	ffffd097          	auipc	ra,0xffffd
    800048a0:	b44080e7          	jalr	-1212(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    800048a4:	0184b503          	ld	a0,24(s1)
    800048a8:	ffffd097          	auipc	ra,0xffffd
    800048ac:	b38080e7          	jalr	-1224(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    800048b0:	00090513          	mv	a0,s2
    800048b4:	01813083          	ld	ra,24(sp)
    800048b8:	01013403          	ld	s0,16(sp)
    800048bc:	00813483          	ld	s1,8(sp)
    800048c0:	00013903          	ld	s2,0(sp)
    800048c4:	02010113          	addi	sp,sp,32
    800048c8:	00008067          	ret

00000000800048cc <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800048cc:	fe010113          	addi	sp,sp,-32
    800048d0:	00113c23          	sd	ra,24(sp)
    800048d4:	00813823          	sd	s0,16(sp)
    800048d8:	00913423          	sd	s1,8(sp)
    800048dc:	01213023          	sd	s2,0(sp)
    800048e0:	02010413          	addi	s0,sp,32
    800048e4:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800048e8:	02853503          	ld	a0,40(a0)
    800048ec:	ffffd097          	auipc	ra,0xffffd
    800048f0:	aac080e7          	jalr	-1364(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    800048f4:	0304b503          	ld	a0,48(s1)
    800048f8:	ffffd097          	auipc	ra,0xffffd
    800048fc:	aa0080e7          	jalr	-1376(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80004900:	0144a783          	lw	a5,20(s1)
    80004904:	0104a903          	lw	s2,16(s1)
    80004908:	0327ce63          	blt	a5,s2,80004944 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000490c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004910:	0304b503          	ld	a0,48(s1)
    80004914:	ffffd097          	auipc	ra,0xffffd
    80004918:	acc080e7          	jalr	-1332(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    8000491c:	0284b503          	ld	a0,40(s1)
    80004920:	ffffd097          	auipc	ra,0xffffd
    80004924:	ac0080e7          	jalr	-1344(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80004928:	00090513          	mv	a0,s2
    8000492c:	01813083          	ld	ra,24(sp)
    80004930:	01013403          	ld	s0,16(sp)
    80004934:	00813483          	ld	s1,8(sp)
    80004938:	00013903          	ld	s2,0(sp)
    8000493c:	02010113          	addi	sp,sp,32
    80004940:	00008067          	ret
        ret = cap - head + tail;
    80004944:	0004a703          	lw	a4,0(s1)
    80004948:	4127093b          	subw	s2,a4,s2
    8000494c:	00f9093b          	addw	s2,s2,a5
    80004950:	fc1ff06f          	j	80004910 <_ZN6Buffer6getCntEv+0x44>

0000000080004954 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80004954:	fe010113          	addi	sp,sp,-32
    80004958:	00113c23          	sd	ra,24(sp)
    8000495c:	00813823          	sd	s0,16(sp)
    80004960:	00913423          	sd	s1,8(sp)
    80004964:	02010413          	addi	s0,sp,32
    80004968:	00050493          	mv	s1,a0
    putc('\n');
    8000496c:	00a00513          	li	a0,10
    80004970:	ffffd097          	auipc	ra,0xffffd
    80004974:	b68080e7          	jalr	-1176(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004978:	00003517          	auipc	a0,0x3
    8000497c:	8a850513          	addi	a0,a0,-1880 # 80007220 <CONSOLE_STATUS+0x210>
    80004980:	ffffe097          	auipc	ra,0xffffe
    80004984:	dac080e7          	jalr	-596(ra) # 8000272c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004988:	00048513          	mv	a0,s1
    8000498c:	00000097          	auipc	ra,0x0
    80004990:	f40080e7          	jalr	-192(ra) # 800048cc <_ZN6Buffer6getCntEv>
    80004994:	02a05c63          	blez	a0,800049cc <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004998:	0084b783          	ld	a5,8(s1)
    8000499c:	0104a703          	lw	a4,16(s1)
    800049a0:	00271713          	slli	a4,a4,0x2
    800049a4:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800049a8:	0007c503          	lbu	a0,0(a5)
    800049ac:	ffffd097          	auipc	ra,0xffffd
    800049b0:	b2c080e7          	jalr	-1236(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    800049b4:	0104a783          	lw	a5,16(s1)
    800049b8:	0017879b          	addiw	a5,a5,1
    800049bc:	0004a703          	lw	a4,0(s1)
    800049c0:	02e7e7bb          	remw	a5,a5,a4
    800049c4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800049c8:	fc1ff06f          	j	80004988 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800049cc:	02100513          	li	a0,33
    800049d0:	ffffd097          	auipc	ra,0xffffd
    800049d4:	b08080e7          	jalr	-1272(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    800049d8:	00a00513          	li	a0,10
    800049dc:	ffffd097          	auipc	ra,0xffffd
    800049e0:	afc080e7          	jalr	-1284(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    800049e4:	0084b503          	ld	a0,8(s1)
    800049e8:	ffffc097          	auipc	ra,0xffffc
    800049ec:	7ec080e7          	jalr	2028(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800049f0:	0204b503          	ld	a0,32(s1)
    800049f4:	ffffd097          	auipc	ra,0xffffd
    800049f8:	a2c080e7          	jalr	-1492(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    800049fc:	0184b503          	ld	a0,24(s1)
    80004a00:	ffffd097          	auipc	ra,0xffffd
    80004a04:	a20080e7          	jalr	-1504(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80004a08:	0304b503          	ld	a0,48(s1)
    80004a0c:	ffffd097          	auipc	ra,0xffffd
    80004a10:	a14080e7          	jalr	-1516(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80004a14:	0284b503          	ld	a0,40(s1)
    80004a18:	ffffd097          	auipc	ra,0xffffd
    80004a1c:	a08080e7          	jalr	-1528(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80004a20:	01813083          	ld	ra,24(sp)
    80004a24:	01013403          	ld	s0,16(sp)
    80004a28:	00813483          	ld	s1,8(sp)
    80004a2c:	02010113          	addi	sp,sp,32
    80004a30:	00008067          	ret

0000000080004a34 <start>:
    80004a34:	ff010113          	addi	sp,sp,-16
    80004a38:	00813423          	sd	s0,8(sp)
    80004a3c:	01010413          	addi	s0,sp,16
    80004a40:	300027f3          	csrr	a5,mstatus
    80004a44:	ffffe737          	lui	a4,0xffffe
    80004a48:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff453f>
    80004a4c:	00e7f7b3          	and	a5,a5,a4
    80004a50:	00001737          	lui	a4,0x1
    80004a54:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004a58:	00e7e7b3          	or	a5,a5,a4
    80004a5c:	30079073          	csrw	mstatus,a5
    80004a60:	00000797          	auipc	a5,0x0
    80004a64:	16078793          	addi	a5,a5,352 # 80004bc0 <system_main>
    80004a68:	34179073          	csrw	mepc,a5
    80004a6c:	00000793          	li	a5,0
    80004a70:	18079073          	csrw	satp,a5
    80004a74:	000107b7          	lui	a5,0x10
    80004a78:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004a7c:	30279073          	csrw	medeleg,a5
    80004a80:	30379073          	csrw	mideleg,a5
    80004a84:	104027f3          	csrr	a5,sie
    80004a88:	2227e793          	ori	a5,a5,546
    80004a8c:	10479073          	csrw	sie,a5
    80004a90:	fff00793          	li	a5,-1
    80004a94:	00a7d793          	srli	a5,a5,0xa
    80004a98:	3b079073          	csrw	pmpaddr0,a5
    80004a9c:	00f00793          	li	a5,15
    80004aa0:	3a079073          	csrw	pmpcfg0,a5
    80004aa4:	f14027f3          	csrr	a5,mhartid
    80004aa8:	0200c737          	lui	a4,0x200c
    80004aac:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004ab0:	0007869b          	sext.w	a3,a5
    80004ab4:	00269713          	slli	a4,a3,0x2
    80004ab8:	000f4637          	lui	a2,0xf4
    80004abc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004ac0:	00d70733          	add	a4,a4,a3
    80004ac4:	0037979b          	slliw	a5,a5,0x3
    80004ac8:	020046b7          	lui	a3,0x2004
    80004acc:	00d787b3          	add	a5,a5,a3
    80004ad0:	00c585b3          	add	a1,a1,a2
    80004ad4:	00371693          	slli	a3,a4,0x3
    80004ad8:	00004717          	auipc	a4,0x4
    80004adc:	58870713          	addi	a4,a4,1416 # 80009060 <timer_scratch>
    80004ae0:	00b7b023          	sd	a1,0(a5)
    80004ae4:	00d70733          	add	a4,a4,a3
    80004ae8:	00f73c23          	sd	a5,24(a4)
    80004aec:	02c73023          	sd	a2,32(a4)
    80004af0:	34071073          	csrw	mscratch,a4
    80004af4:	00000797          	auipc	a5,0x0
    80004af8:	6ec78793          	addi	a5,a5,1772 # 800051e0 <timervec>
    80004afc:	30579073          	csrw	mtvec,a5
    80004b00:	300027f3          	csrr	a5,mstatus
    80004b04:	0087e793          	ori	a5,a5,8
    80004b08:	30079073          	csrw	mstatus,a5
    80004b0c:	304027f3          	csrr	a5,mie
    80004b10:	0807e793          	ori	a5,a5,128
    80004b14:	30479073          	csrw	mie,a5
    80004b18:	f14027f3          	csrr	a5,mhartid
    80004b1c:	0007879b          	sext.w	a5,a5
    80004b20:	00078213          	mv	tp,a5
    80004b24:	30200073          	mret
    80004b28:	00813403          	ld	s0,8(sp)
    80004b2c:	01010113          	addi	sp,sp,16
    80004b30:	00008067          	ret

0000000080004b34 <timerinit>:
    80004b34:	ff010113          	addi	sp,sp,-16
    80004b38:	00813423          	sd	s0,8(sp)
    80004b3c:	01010413          	addi	s0,sp,16
    80004b40:	f14027f3          	csrr	a5,mhartid
    80004b44:	0200c737          	lui	a4,0x200c
    80004b48:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004b4c:	0007869b          	sext.w	a3,a5
    80004b50:	00269713          	slli	a4,a3,0x2
    80004b54:	000f4637          	lui	a2,0xf4
    80004b58:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004b5c:	00d70733          	add	a4,a4,a3
    80004b60:	0037979b          	slliw	a5,a5,0x3
    80004b64:	020046b7          	lui	a3,0x2004
    80004b68:	00d787b3          	add	a5,a5,a3
    80004b6c:	00c585b3          	add	a1,a1,a2
    80004b70:	00371693          	slli	a3,a4,0x3
    80004b74:	00004717          	auipc	a4,0x4
    80004b78:	4ec70713          	addi	a4,a4,1260 # 80009060 <timer_scratch>
    80004b7c:	00b7b023          	sd	a1,0(a5)
    80004b80:	00d70733          	add	a4,a4,a3
    80004b84:	00f73c23          	sd	a5,24(a4)
    80004b88:	02c73023          	sd	a2,32(a4)
    80004b8c:	34071073          	csrw	mscratch,a4
    80004b90:	00000797          	auipc	a5,0x0
    80004b94:	65078793          	addi	a5,a5,1616 # 800051e0 <timervec>
    80004b98:	30579073          	csrw	mtvec,a5
    80004b9c:	300027f3          	csrr	a5,mstatus
    80004ba0:	0087e793          	ori	a5,a5,8
    80004ba4:	30079073          	csrw	mstatus,a5
    80004ba8:	304027f3          	csrr	a5,mie
    80004bac:	0807e793          	ori	a5,a5,128
    80004bb0:	30479073          	csrw	mie,a5
    80004bb4:	00813403          	ld	s0,8(sp)
    80004bb8:	01010113          	addi	sp,sp,16
    80004bbc:	00008067          	ret

0000000080004bc0 <system_main>:
    80004bc0:	fe010113          	addi	sp,sp,-32
    80004bc4:	00813823          	sd	s0,16(sp)
    80004bc8:	00913423          	sd	s1,8(sp)
    80004bcc:	00113c23          	sd	ra,24(sp)
    80004bd0:	02010413          	addi	s0,sp,32
    80004bd4:	00000097          	auipc	ra,0x0
    80004bd8:	0c4080e7          	jalr	196(ra) # 80004c98 <cpuid>
    80004bdc:	00004497          	auipc	s1,0x4
    80004be0:	34448493          	addi	s1,s1,836 # 80008f20 <started>
    80004be4:	02050263          	beqz	a0,80004c08 <system_main+0x48>
    80004be8:	0004a783          	lw	a5,0(s1)
    80004bec:	0007879b          	sext.w	a5,a5
    80004bf0:	fe078ce3          	beqz	a5,80004be8 <system_main+0x28>
    80004bf4:	0ff0000f          	fence
    80004bf8:	00002517          	auipc	a0,0x2
    80004bfc:	67050513          	addi	a0,a0,1648 # 80007268 <CONSOLE_STATUS+0x258>
    80004c00:	00001097          	auipc	ra,0x1
    80004c04:	a7c080e7          	jalr	-1412(ra) # 8000567c <panic>
    80004c08:	00001097          	auipc	ra,0x1
    80004c0c:	9d0080e7          	jalr	-1584(ra) # 800055d8 <consoleinit>
    80004c10:	00001097          	auipc	ra,0x1
    80004c14:	15c080e7          	jalr	348(ra) # 80005d6c <printfinit>
    80004c18:	00002517          	auipc	a0,0x2
    80004c1c:	5f850513          	addi	a0,a0,1528 # 80007210 <CONSOLE_STATUS+0x200>
    80004c20:	00001097          	auipc	ra,0x1
    80004c24:	ab8080e7          	jalr	-1352(ra) # 800056d8 <__printf>
    80004c28:	00002517          	auipc	a0,0x2
    80004c2c:	61050513          	addi	a0,a0,1552 # 80007238 <CONSOLE_STATUS+0x228>
    80004c30:	00001097          	auipc	ra,0x1
    80004c34:	aa8080e7          	jalr	-1368(ra) # 800056d8 <__printf>
    80004c38:	00002517          	auipc	a0,0x2
    80004c3c:	5d850513          	addi	a0,a0,1496 # 80007210 <CONSOLE_STATUS+0x200>
    80004c40:	00001097          	auipc	ra,0x1
    80004c44:	a98080e7          	jalr	-1384(ra) # 800056d8 <__printf>
    80004c48:	00001097          	auipc	ra,0x1
    80004c4c:	4b0080e7          	jalr	1200(ra) # 800060f8 <kinit>
    80004c50:	00000097          	auipc	ra,0x0
    80004c54:	148080e7          	jalr	328(ra) # 80004d98 <trapinit>
    80004c58:	00000097          	auipc	ra,0x0
    80004c5c:	16c080e7          	jalr	364(ra) # 80004dc4 <trapinithart>
    80004c60:	00000097          	auipc	ra,0x0
    80004c64:	5c0080e7          	jalr	1472(ra) # 80005220 <plicinit>
    80004c68:	00000097          	auipc	ra,0x0
    80004c6c:	5e0080e7          	jalr	1504(ra) # 80005248 <plicinithart>
    80004c70:	00000097          	auipc	ra,0x0
    80004c74:	078080e7          	jalr	120(ra) # 80004ce8 <userinit>
    80004c78:	0ff0000f          	fence
    80004c7c:	00100793          	li	a5,1
    80004c80:	00002517          	auipc	a0,0x2
    80004c84:	5d050513          	addi	a0,a0,1488 # 80007250 <CONSOLE_STATUS+0x240>
    80004c88:	00f4a023          	sw	a5,0(s1)
    80004c8c:	00001097          	auipc	ra,0x1
    80004c90:	a4c080e7          	jalr	-1460(ra) # 800056d8 <__printf>
    80004c94:	0000006f          	j	80004c94 <system_main+0xd4>

0000000080004c98 <cpuid>:
    80004c98:	ff010113          	addi	sp,sp,-16
    80004c9c:	00813423          	sd	s0,8(sp)
    80004ca0:	01010413          	addi	s0,sp,16
    80004ca4:	00020513          	mv	a0,tp
    80004ca8:	00813403          	ld	s0,8(sp)
    80004cac:	0005051b          	sext.w	a0,a0
    80004cb0:	01010113          	addi	sp,sp,16
    80004cb4:	00008067          	ret

0000000080004cb8 <mycpu>:
    80004cb8:	ff010113          	addi	sp,sp,-16
    80004cbc:	00813423          	sd	s0,8(sp)
    80004cc0:	01010413          	addi	s0,sp,16
    80004cc4:	00020793          	mv	a5,tp
    80004cc8:	00813403          	ld	s0,8(sp)
    80004ccc:	0007879b          	sext.w	a5,a5
    80004cd0:	00779793          	slli	a5,a5,0x7
    80004cd4:	00005517          	auipc	a0,0x5
    80004cd8:	3bc50513          	addi	a0,a0,956 # 8000a090 <cpus>
    80004cdc:	00f50533          	add	a0,a0,a5
    80004ce0:	01010113          	addi	sp,sp,16
    80004ce4:	00008067          	ret

0000000080004ce8 <userinit>:
    80004ce8:	ff010113          	addi	sp,sp,-16
    80004cec:	00813423          	sd	s0,8(sp)
    80004cf0:	01010413          	addi	s0,sp,16
    80004cf4:	00813403          	ld	s0,8(sp)
    80004cf8:	01010113          	addi	sp,sp,16
    80004cfc:	ffffe317          	auipc	t1,0xffffe
    80004d00:	e5c30067          	jr	-420(t1) # 80002b58 <main>

0000000080004d04 <either_copyout>:
    80004d04:	ff010113          	addi	sp,sp,-16
    80004d08:	00813023          	sd	s0,0(sp)
    80004d0c:	00113423          	sd	ra,8(sp)
    80004d10:	01010413          	addi	s0,sp,16
    80004d14:	02051663          	bnez	a0,80004d40 <either_copyout+0x3c>
    80004d18:	00058513          	mv	a0,a1
    80004d1c:	00060593          	mv	a1,a2
    80004d20:	0006861b          	sext.w	a2,a3
    80004d24:	00002097          	auipc	ra,0x2
    80004d28:	c60080e7          	jalr	-928(ra) # 80006984 <__memmove>
    80004d2c:	00813083          	ld	ra,8(sp)
    80004d30:	00013403          	ld	s0,0(sp)
    80004d34:	00000513          	li	a0,0
    80004d38:	01010113          	addi	sp,sp,16
    80004d3c:	00008067          	ret
    80004d40:	00002517          	auipc	a0,0x2
    80004d44:	55050513          	addi	a0,a0,1360 # 80007290 <CONSOLE_STATUS+0x280>
    80004d48:	00001097          	auipc	ra,0x1
    80004d4c:	934080e7          	jalr	-1740(ra) # 8000567c <panic>

0000000080004d50 <either_copyin>:
    80004d50:	ff010113          	addi	sp,sp,-16
    80004d54:	00813023          	sd	s0,0(sp)
    80004d58:	00113423          	sd	ra,8(sp)
    80004d5c:	01010413          	addi	s0,sp,16
    80004d60:	02059463          	bnez	a1,80004d88 <either_copyin+0x38>
    80004d64:	00060593          	mv	a1,a2
    80004d68:	0006861b          	sext.w	a2,a3
    80004d6c:	00002097          	auipc	ra,0x2
    80004d70:	c18080e7          	jalr	-1000(ra) # 80006984 <__memmove>
    80004d74:	00813083          	ld	ra,8(sp)
    80004d78:	00013403          	ld	s0,0(sp)
    80004d7c:	00000513          	li	a0,0
    80004d80:	01010113          	addi	sp,sp,16
    80004d84:	00008067          	ret
    80004d88:	00002517          	auipc	a0,0x2
    80004d8c:	53050513          	addi	a0,a0,1328 # 800072b8 <CONSOLE_STATUS+0x2a8>
    80004d90:	00001097          	auipc	ra,0x1
    80004d94:	8ec080e7          	jalr	-1812(ra) # 8000567c <panic>

0000000080004d98 <trapinit>:
    80004d98:	ff010113          	addi	sp,sp,-16
    80004d9c:	00813423          	sd	s0,8(sp)
    80004da0:	01010413          	addi	s0,sp,16
    80004da4:	00813403          	ld	s0,8(sp)
    80004da8:	00002597          	auipc	a1,0x2
    80004dac:	53858593          	addi	a1,a1,1336 # 800072e0 <CONSOLE_STATUS+0x2d0>
    80004db0:	00005517          	auipc	a0,0x5
    80004db4:	36050513          	addi	a0,a0,864 # 8000a110 <tickslock>
    80004db8:	01010113          	addi	sp,sp,16
    80004dbc:	00001317          	auipc	t1,0x1
    80004dc0:	5cc30067          	jr	1484(t1) # 80006388 <initlock>

0000000080004dc4 <trapinithart>:
    80004dc4:	ff010113          	addi	sp,sp,-16
    80004dc8:	00813423          	sd	s0,8(sp)
    80004dcc:	01010413          	addi	s0,sp,16
    80004dd0:	00000797          	auipc	a5,0x0
    80004dd4:	30078793          	addi	a5,a5,768 # 800050d0 <kernelvec>
    80004dd8:	10579073          	csrw	stvec,a5
    80004ddc:	00813403          	ld	s0,8(sp)
    80004de0:	01010113          	addi	sp,sp,16
    80004de4:	00008067          	ret

0000000080004de8 <usertrap>:
    80004de8:	ff010113          	addi	sp,sp,-16
    80004dec:	00813423          	sd	s0,8(sp)
    80004df0:	01010413          	addi	s0,sp,16
    80004df4:	00813403          	ld	s0,8(sp)
    80004df8:	01010113          	addi	sp,sp,16
    80004dfc:	00008067          	ret

0000000080004e00 <usertrapret>:
    80004e00:	ff010113          	addi	sp,sp,-16
    80004e04:	00813423          	sd	s0,8(sp)
    80004e08:	01010413          	addi	s0,sp,16
    80004e0c:	00813403          	ld	s0,8(sp)
    80004e10:	01010113          	addi	sp,sp,16
    80004e14:	00008067          	ret

0000000080004e18 <kerneltrap>:
    80004e18:	fe010113          	addi	sp,sp,-32
    80004e1c:	00813823          	sd	s0,16(sp)
    80004e20:	00113c23          	sd	ra,24(sp)
    80004e24:	00913423          	sd	s1,8(sp)
    80004e28:	02010413          	addi	s0,sp,32
    80004e2c:	142025f3          	csrr	a1,scause
    80004e30:	100027f3          	csrr	a5,sstatus
    80004e34:	0027f793          	andi	a5,a5,2
    80004e38:	10079c63          	bnez	a5,80004f50 <kerneltrap+0x138>
    80004e3c:	142027f3          	csrr	a5,scause
    80004e40:	0207ce63          	bltz	a5,80004e7c <kerneltrap+0x64>
    80004e44:	00002517          	auipc	a0,0x2
    80004e48:	4e450513          	addi	a0,a0,1252 # 80007328 <CONSOLE_STATUS+0x318>
    80004e4c:	00001097          	auipc	ra,0x1
    80004e50:	88c080e7          	jalr	-1908(ra) # 800056d8 <__printf>
    80004e54:	141025f3          	csrr	a1,sepc
    80004e58:	14302673          	csrr	a2,stval
    80004e5c:	00002517          	auipc	a0,0x2
    80004e60:	4dc50513          	addi	a0,a0,1244 # 80007338 <CONSOLE_STATUS+0x328>
    80004e64:	00001097          	auipc	ra,0x1
    80004e68:	874080e7          	jalr	-1932(ra) # 800056d8 <__printf>
    80004e6c:	00002517          	auipc	a0,0x2
    80004e70:	4e450513          	addi	a0,a0,1252 # 80007350 <CONSOLE_STATUS+0x340>
    80004e74:	00001097          	auipc	ra,0x1
    80004e78:	808080e7          	jalr	-2040(ra) # 8000567c <panic>
    80004e7c:	0ff7f713          	andi	a4,a5,255
    80004e80:	00900693          	li	a3,9
    80004e84:	04d70063          	beq	a4,a3,80004ec4 <kerneltrap+0xac>
    80004e88:	fff00713          	li	a4,-1
    80004e8c:	03f71713          	slli	a4,a4,0x3f
    80004e90:	00170713          	addi	a4,a4,1
    80004e94:	fae798e3          	bne	a5,a4,80004e44 <kerneltrap+0x2c>
    80004e98:	00000097          	auipc	ra,0x0
    80004e9c:	e00080e7          	jalr	-512(ra) # 80004c98 <cpuid>
    80004ea0:	06050663          	beqz	a0,80004f0c <kerneltrap+0xf4>
    80004ea4:	144027f3          	csrr	a5,sip
    80004ea8:	ffd7f793          	andi	a5,a5,-3
    80004eac:	14479073          	csrw	sip,a5
    80004eb0:	01813083          	ld	ra,24(sp)
    80004eb4:	01013403          	ld	s0,16(sp)
    80004eb8:	00813483          	ld	s1,8(sp)
    80004ebc:	02010113          	addi	sp,sp,32
    80004ec0:	00008067          	ret
    80004ec4:	00000097          	auipc	ra,0x0
    80004ec8:	3d0080e7          	jalr	976(ra) # 80005294 <plic_claim>
    80004ecc:	00a00793          	li	a5,10
    80004ed0:	00050493          	mv	s1,a0
    80004ed4:	06f50863          	beq	a0,a5,80004f44 <kerneltrap+0x12c>
    80004ed8:	fc050ce3          	beqz	a0,80004eb0 <kerneltrap+0x98>
    80004edc:	00050593          	mv	a1,a0
    80004ee0:	00002517          	auipc	a0,0x2
    80004ee4:	42850513          	addi	a0,a0,1064 # 80007308 <CONSOLE_STATUS+0x2f8>
    80004ee8:	00000097          	auipc	ra,0x0
    80004eec:	7f0080e7          	jalr	2032(ra) # 800056d8 <__printf>
    80004ef0:	01013403          	ld	s0,16(sp)
    80004ef4:	01813083          	ld	ra,24(sp)
    80004ef8:	00048513          	mv	a0,s1
    80004efc:	00813483          	ld	s1,8(sp)
    80004f00:	02010113          	addi	sp,sp,32
    80004f04:	00000317          	auipc	t1,0x0
    80004f08:	3c830067          	jr	968(t1) # 800052cc <plic_complete>
    80004f0c:	00005517          	auipc	a0,0x5
    80004f10:	20450513          	addi	a0,a0,516 # 8000a110 <tickslock>
    80004f14:	00001097          	auipc	ra,0x1
    80004f18:	498080e7          	jalr	1176(ra) # 800063ac <acquire>
    80004f1c:	00004717          	auipc	a4,0x4
    80004f20:	00870713          	addi	a4,a4,8 # 80008f24 <ticks>
    80004f24:	00072783          	lw	a5,0(a4)
    80004f28:	00005517          	auipc	a0,0x5
    80004f2c:	1e850513          	addi	a0,a0,488 # 8000a110 <tickslock>
    80004f30:	0017879b          	addiw	a5,a5,1
    80004f34:	00f72023          	sw	a5,0(a4)
    80004f38:	00001097          	auipc	ra,0x1
    80004f3c:	540080e7          	jalr	1344(ra) # 80006478 <release>
    80004f40:	f65ff06f          	j	80004ea4 <kerneltrap+0x8c>
    80004f44:	00001097          	auipc	ra,0x1
    80004f48:	09c080e7          	jalr	156(ra) # 80005fe0 <uartintr>
    80004f4c:	fa5ff06f          	j	80004ef0 <kerneltrap+0xd8>
    80004f50:	00002517          	auipc	a0,0x2
    80004f54:	39850513          	addi	a0,a0,920 # 800072e8 <CONSOLE_STATUS+0x2d8>
    80004f58:	00000097          	auipc	ra,0x0
    80004f5c:	724080e7          	jalr	1828(ra) # 8000567c <panic>

0000000080004f60 <clockintr>:
    80004f60:	fe010113          	addi	sp,sp,-32
    80004f64:	00813823          	sd	s0,16(sp)
    80004f68:	00913423          	sd	s1,8(sp)
    80004f6c:	00113c23          	sd	ra,24(sp)
    80004f70:	02010413          	addi	s0,sp,32
    80004f74:	00005497          	auipc	s1,0x5
    80004f78:	19c48493          	addi	s1,s1,412 # 8000a110 <tickslock>
    80004f7c:	00048513          	mv	a0,s1
    80004f80:	00001097          	auipc	ra,0x1
    80004f84:	42c080e7          	jalr	1068(ra) # 800063ac <acquire>
    80004f88:	00004717          	auipc	a4,0x4
    80004f8c:	f9c70713          	addi	a4,a4,-100 # 80008f24 <ticks>
    80004f90:	00072783          	lw	a5,0(a4)
    80004f94:	01013403          	ld	s0,16(sp)
    80004f98:	01813083          	ld	ra,24(sp)
    80004f9c:	00048513          	mv	a0,s1
    80004fa0:	0017879b          	addiw	a5,a5,1
    80004fa4:	00813483          	ld	s1,8(sp)
    80004fa8:	00f72023          	sw	a5,0(a4)
    80004fac:	02010113          	addi	sp,sp,32
    80004fb0:	00001317          	auipc	t1,0x1
    80004fb4:	4c830067          	jr	1224(t1) # 80006478 <release>

0000000080004fb8 <devintr>:
    80004fb8:	142027f3          	csrr	a5,scause
    80004fbc:	00000513          	li	a0,0
    80004fc0:	0007c463          	bltz	a5,80004fc8 <devintr+0x10>
    80004fc4:	00008067          	ret
    80004fc8:	fe010113          	addi	sp,sp,-32
    80004fcc:	00813823          	sd	s0,16(sp)
    80004fd0:	00113c23          	sd	ra,24(sp)
    80004fd4:	00913423          	sd	s1,8(sp)
    80004fd8:	02010413          	addi	s0,sp,32
    80004fdc:	0ff7f713          	andi	a4,a5,255
    80004fe0:	00900693          	li	a3,9
    80004fe4:	04d70c63          	beq	a4,a3,8000503c <devintr+0x84>
    80004fe8:	fff00713          	li	a4,-1
    80004fec:	03f71713          	slli	a4,a4,0x3f
    80004ff0:	00170713          	addi	a4,a4,1
    80004ff4:	00e78c63          	beq	a5,a4,8000500c <devintr+0x54>
    80004ff8:	01813083          	ld	ra,24(sp)
    80004ffc:	01013403          	ld	s0,16(sp)
    80005000:	00813483          	ld	s1,8(sp)
    80005004:	02010113          	addi	sp,sp,32
    80005008:	00008067          	ret
    8000500c:	00000097          	auipc	ra,0x0
    80005010:	c8c080e7          	jalr	-884(ra) # 80004c98 <cpuid>
    80005014:	06050663          	beqz	a0,80005080 <devintr+0xc8>
    80005018:	144027f3          	csrr	a5,sip
    8000501c:	ffd7f793          	andi	a5,a5,-3
    80005020:	14479073          	csrw	sip,a5
    80005024:	01813083          	ld	ra,24(sp)
    80005028:	01013403          	ld	s0,16(sp)
    8000502c:	00813483          	ld	s1,8(sp)
    80005030:	00200513          	li	a0,2
    80005034:	02010113          	addi	sp,sp,32
    80005038:	00008067          	ret
    8000503c:	00000097          	auipc	ra,0x0
    80005040:	258080e7          	jalr	600(ra) # 80005294 <plic_claim>
    80005044:	00a00793          	li	a5,10
    80005048:	00050493          	mv	s1,a0
    8000504c:	06f50663          	beq	a0,a5,800050b8 <devintr+0x100>
    80005050:	00100513          	li	a0,1
    80005054:	fa0482e3          	beqz	s1,80004ff8 <devintr+0x40>
    80005058:	00048593          	mv	a1,s1
    8000505c:	00002517          	auipc	a0,0x2
    80005060:	2ac50513          	addi	a0,a0,684 # 80007308 <CONSOLE_STATUS+0x2f8>
    80005064:	00000097          	auipc	ra,0x0
    80005068:	674080e7          	jalr	1652(ra) # 800056d8 <__printf>
    8000506c:	00048513          	mv	a0,s1
    80005070:	00000097          	auipc	ra,0x0
    80005074:	25c080e7          	jalr	604(ra) # 800052cc <plic_complete>
    80005078:	00100513          	li	a0,1
    8000507c:	f7dff06f          	j	80004ff8 <devintr+0x40>
    80005080:	00005517          	auipc	a0,0x5
    80005084:	09050513          	addi	a0,a0,144 # 8000a110 <tickslock>
    80005088:	00001097          	auipc	ra,0x1
    8000508c:	324080e7          	jalr	804(ra) # 800063ac <acquire>
    80005090:	00004717          	auipc	a4,0x4
    80005094:	e9470713          	addi	a4,a4,-364 # 80008f24 <ticks>
    80005098:	00072783          	lw	a5,0(a4)
    8000509c:	00005517          	auipc	a0,0x5
    800050a0:	07450513          	addi	a0,a0,116 # 8000a110 <tickslock>
    800050a4:	0017879b          	addiw	a5,a5,1
    800050a8:	00f72023          	sw	a5,0(a4)
    800050ac:	00001097          	auipc	ra,0x1
    800050b0:	3cc080e7          	jalr	972(ra) # 80006478 <release>
    800050b4:	f65ff06f          	j	80005018 <devintr+0x60>
    800050b8:	00001097          	auipc	ra,0x1
    800050bc:	f28080e7          	jalr	-216(ra) # 80005fe0 <uartintr>
    800050c0:	fadff06f          	j	8000506c <devintr+0xb4>
	...

00000000800050d0 <kernelvec>:
    800050d0:	f0010113          	addi	sp,sp,-256
    800050d4:	00113023          	sd	ra,0(sp)
    800050d8:	00213423          	sd	sp,8(sp)
    800050dc:	00313823          	sd	gp,16(sp)
    800050e0:	00413c23          	sd	tp,24(sp)
    800050e4:	02513023          	sd	t0,32(sp)
    800050e8:	02613423          	sd	t1,40(sp)
    800050ec:	02713823          	sd	t2,48(sp)
    800050f0:	02813c23          	sd	s0,56(sp)
    800050f4:	04913023          	sd	s1,64(sp)
    800050f8:	04a13423          	sd	a0,72(sp)
    800050fc:	04b13823          	sd	a1,80(sp)
    80005100:	04c13c23          	sd	a2,88(sp)
    80005104:	06d13023          	sd	a3,96(sp)
    80005108:	06e13423          	sd	a4,104(sp)
    8000510c:	06f13823          	sd	a5,112(sp)
    80005110:	07013c23          	sd	a6,120(sp)
    80005114:	09113023          	sd	a7,128(sp)
    80005118:	09213423          	sd	s2,136(sp)
    8000511c:	09313823          	sd	s3,144(sp)
    80005120:	09413c23          	sd	s4,152(sp)
    80005124:	0b513023          	sd	s5,160(sp)
    80005128:	0b613423          	sd	s6,168(sp)
    8000512c:	0b713823          	sd	s7,176(sp)
    80005130:	0b813c23          	sd	s8,184(sp)
    80005134:	0d913023          	sd	s9,192(sp)
    80005138:	0da13423          	sd	s10,200(sp)
    8000513c:	0db13823          	sd	s11,208(sp)
    80005140:	0dc13c23          	sd	t3,216(sp)
    80005144:	0fd13023          	sd	t4,224(sp)
    80005148:	0fe13423          	sd	t5,232(sp)
    8000514c:	0ff13823          	sd	t6,240(sp)
    80005150:	cc9ff0ef          	jal	ra,80004e18 <kerneltrap>
    80005154:	00013083          	ld	ra,0(sp)
    80005158:	00813103          	ld	sp,8(sp)
    8000515c:	01013183          	ld	gp,16(sp)
    80005160:	02013283          	ld	t0,32(sp)
    80005164:	02813303          	ld	t1,40(sp)
    80005168:	03013383          	ld	t2,48(sp)
    8000516c:	03813403          	ld	s0,56(sp)
    80005170:	04013483          	ld	s1,64(sp)
    80005174:	04813503          	ld	a0,72(sp)
    80005178:	05013583          	ld	a1,80(sp)
    8000517c:	05813603          	ld	a2,88(sp)
    80005180:	06013683          	ld	a3,96(sp)
    80005184:	06813703          	ld	a4,104(sp)
    80005188:	07013783          	ld	a5,112(sp)
    8000518c:	07813803          	ld	a6,120(sp)
    80005190:	08013883          	ld	a7,128(sp)
    80005194:	08813903          	ld	s2,136(sp)
    80005198:	09013983          	ld	s3,144(sp)
    8000519c:	09813a03          	ld	s4,152(sp)
    800051a0:	0a013a83          	ld	s5,160(sp)
    800051a4:	0a813b03          	ld	s6,168(sp)
    800051a8:	0b013b83          	ld	s7,176(sp)
    800051ac:	0b813c03          	ld	s8,184(sp)
    800051b0:	0c013c83          	ld	s9,192(sp)
    800051b4:	0c813d03          	ld	s10,200(sp)
    800051b8:	0d013d83          	ld	s11,208(sp)
    800051bc:	0d813e03          	ld	t3,216(sp)
    800051c0:	0e013e83          	ld	t4,224(sp)
    800051c4:	0e813f03          	ld	t5,232(sp)
    800051c8:	0f013f83          	ld	t6,240(sp)
    800051cc:	10010113          	addi	sp,sp,256
    800051d0:	10200073          	sret
    800051d4:	00000013          	nop
    800051d8:	00000013          	nop
    800051dc:	00000013          	nop

00000000800051e0 <timervec>:
    800051e0:	34051573          	csrrw	a0,mscratch,a0
    800051e4:	00b53023          	sd	a1,0(a0)
    800051e8:	00c53423          	sd	a2,8(a0)
    800051ec:	00d53823          	sd	a3,16(a0)
    800051f0:	01853583          	ld	a1,24(a0)
    800051f4:	02053603          	ld	a2,32(a0)
    800051f8:	0005b683          	ld	a3,0(a1)
    800051fc:	00c686b3          	add	a3,a3,a2
    80005200:	00d5b023          	sd	a3,0(a1)
    80005204:	00200593          	li	a1,2
    80005208:	14459073          	csrw	sip,a1
    8000520c:	01053683          	ld	a3,16(a0)
    80005210:	00853603          	ld	a2,8(a0)
    80005214:	00053583          	ld	a1,0(a0)
    80005218:	34051573          	csrrw	a0,mscratch,a0
    8000521c:	30200073          	mret

0000000080005220 <plicinit>:
    80005220:	ff010113          	addi	sp,sp,-16
    80005224:	00813423          	sd	s0,8(sp)
    80005228:	01010413          	addi	s0,sp,16
    8000522c:	00813403          	ld	s0,8(sp)
    80005230:	0c0007b7          	lui	a5,0xc000
    80005234:	00100713          	li	a4,1
    80005238:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000523c:	00e7a223          	sw	a4,4(a5)
    80005240:	01010113          	addi	sp,sp,16
    80005244:	00008067          	ret

0000000080005248 <plicinithart>:
    80005248:	ff010113          	addi	sp,sp,-16
    8000524c:	00813023          	sd	s0,0(sp)
    80005250:	00113423          	sd	ra,8(sp)
    80005254:	01010413          	addi	s0,sp,16
    80005258:	00000097          	auipc	ra,0x0
    8000525c:	a40080e7          	jalr	-1472(ra) # 80004c98 <cpuid>
    80005260:	0085171b          	slliw	a4,a0,0x8
    80005264:	0c0027b7          	lui	a5,0xc002
    80005268:	00e787b3          	add	a5,a5,a4
    8000526c:	40200713          	li	a4,1026
    80005270:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005274:	00813083          	ld	ra,8(sp)
    80005278:	00013403          	ld	s0,0(sp)
    8000527c:	00d5151b          	slliw	a0,a0,0xd
    80005280:	0c2017b7          	lui	a5,0xc201
    80005284:	00a78533          	add	a0,a5,a0
    80005288:	00052023          	sw	zero,0(a0)
    8000528c:	01010113          	addi	sp,sp,16
    80005290:	00008067          	ret

0000000080005294 <plic_claim>:
    80005294:	ff010113          	addi	sp,sp,-16
    80005298:	00813023          	sd	s0,0(sp)
    8000529c:	00113423          	sd	ra,8(sp)
    800052a0:	01010413          	addi	s0,sp,16
    800052a4:	00000097          	auipc	ra,0x0
    800052a8:	9f4080e7          	jalr	-1548(ra) # 80004c98 <cpuid>
    800052ac:	00813083          	ld	ra,8(sp)
    800052b0:	00013403          	ld	s0,0(sp)
    800052b4:	00d5151b          	slliw	a0,a0,0xd
    800052b8:	0c2017b7          	lui	a5,0xc201
    800052bc:	00a78533          	add	a0,a5,a0
    800052c0:	00452503          	lw	a0,4(a0)
    800052c4:	01010113          	addi	sp,sp,16
    800052c8:	00008067          	ret

00000000800052cc <plic_complete>:
    800052cc:	fe010113          	addi	sp,sp,-32
    800052d0:	00813823          	sd	s0,16(sp)
    800052d4:	00913423          	sd	s1,8(sp)
    800052d8:	00113c23          	sd	ra,24(sp)
    800052dc:	02010413          	addi	s0,sp,32
    800052e0:	00050493          	mv	s1,a0
    800052e4:	00000097          	auipc	ra,0x0
    800052e8:	9b4080e7          	jalr	-1612(ra) # 80004c98 <cpuid>
    800052ec:	01813083          	ld	ra,24(sp)
    800052f0:	01013403          	ld	s0,16(sp)
    800052f4:	00d5179b          	slliw	a5,a0,0xd
    800052f8:	0c201737          	lui	a4,0xc201
    800052fc:	00f707b3          	add	a5,a4,a5
    80005300:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005304:	00813483          	ld	s1,8(sp)
    80005308:	02010113          	addi	sp,sp,32
    8000530c:	00008067          	ret

0000000080005310 <consolewrite>:
    80005310:	fb010113          	addi	sp,sp,-80
    80005314:	04813023          	sd	s0,64(sp)
    80005318:	04113423          	sd	ra,72(sp)
    8000531c:	02913c23          	sd	s1,56(sp)
    80005320:	03213823          	sd	s2,48(sp)
    80005324:	03313423          	sd	s3,40(sp)
    80005328:	03413023          	sd	s4,32(sp)
    8000532c:	01513c23          	sd	s5,24(sp)
    80005330:	05010413          	addi	s0,sp,80
    80005334:	06c05c63          	blez	a2,800053ac <consolewrite+0x9c>
    80005338:	00060993          	mv	s3,a2
    8000533c:	00050a13          	mv	s4,a0
    80005340:	00058493          	mv	s1,a1
    80005344:	00000913          	li	s2,0
    80005348:	fff00a93          	li	s5,-1
    8000534c:	01c0006f          	j	80005368 <consolewrite+0x58>
    80005350:	fbf44503          	lbu	a0,-65(s0)
    80005354:	0019091b          	addiw	s2,s2,1
    80005358:	00148493          	addi	s1,s1,1
    8000535c:	00001097          	auipc	ra,0x1
    80005360:	a9c080e7          	jalr	-1380(ra) # 80005df8 <uartputc>
    80005364:	03298063          	beq	s3,s2,80005384 <consolewrite+0x74>
    80005368:	00048613          	mv	a2,s1
    8000536c:	00100693          	li	a3,1
    80005370:	000a0593          	mv	a1,s4
    80005374:	fbf40513          	addi	a0,s0,-65
    80005378:	00000097          	auipc	ra,0x0
    8000537c:	9d8080e7          	jalr	-1576(ra) # 80004d50 <either_copyin>
    80005380:	fd5518e3          	bne	a0,s5,80005350 <consolewrite+0x40>
    80005384:	04813083          	ld	ra,72(sp)
    80005388:	04013403          	ld	s0,64(sp)
    8000538c:	03813483          	ld	s1,56(sp)
    80005390:	02813983          	ld	s3,40(sp)
    80005394:	02013a03          	ld	s4,32(sp)
    80005398:	01813a83          	ld	s5,24(sp)
    8000539c:	00090513          	mv	a0,s2
    800053a0:	03013903          	ld	s2,48(sp)
    800053a4:	05010113          	addi	sp,sp,80
    800053a8:	00008067          	ret
    800053ac:	00000913          	li	s2,0
    800053b0:	fd5ff06f          	j	80005384 <consolewrite+0x74>

00000000800053b4 <consoleread>:
    800053b4:	f9010113          	addi	sp,sp,-112
    800053b8:	06813023          	sd	s0,96(sp)
    800053bc:	04913c23          	sd	s1,88(sp)
    800053c0:	05213823          	sd	s2,80(sp)
    800053c4:	05313423          	sd	s3,72(sp)
    800053c8:	05413023          	sd	s4,64(sp)
    800053cc:	03513c23          	sd	s5,56(sp)
    800053d0:	03613823          	sd	s6,48(sp)
    800053d4:	03713423          	sd	s7,40(sp)
    800053d8:	03813023          	sd	s8,32(sp)
    800053dc:	06113423          	sd	ra,104(sp)
    800053e0:	01913c23          	sd	s9,24(sp)
    800053e4:	07010413          	addi	s0,sp,112
    800053e8:	00060b93          	mv	s7,a2
    800053ec:	00050913          	mv	s2,a0
    800053f0:	00058c13          	mv	s8,a1
    800053f4:	00060b1b          	sext.w	s6,a2
    800053f8:	00005497          	auipc	s1,0x5
    800053fc:	d4048493          	addi	s1,s1,-704 # 8000a138 <cons>
    80005400:	00400993          	li	s3,4
    80005404:	fff00a13          	li	s4,-1
    80005408:	00a00a93          	li	s5,10
    8000540c:	05705e63          	blez	s7,80005468 <consoleread+0xb4>
    80005410:	09c4a703          	lw	a4,156(s1)
    80005414:	0984a783          	lw	a5,152(s1)
    80005418:	0007071b          	sext.w	a4,a4
    8000541c:	08e78463          	beq	a5,a4,800054a4 <consoleread+0xf0>
    80005420:	07f7f713          	andi	a4,a5,127
    80005424:	00e48733          	add	a4,s1,a4
    80005428:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000542c:	0017869b          	addiw	a3,a5,1
    80005430:	08d4ac23          	sw	a3,152(s1)
    80005434:	00070c9b          	sext.w	s9,a4
    80005438:	0b370663          	beq	a4,s3,800054e4 <consoleread+0x130>
    8000543c:	00100693          	li	a3,1
    80005440:	f9f40613          	addi	a2,s0,-97
    80005444:	000c0593          	mv	a1,s8
    80005448:	00090513          	mv	a0,s2
    8000544c:	f8e40fa3          	sb	a4,-97(s0)
    80005450:	00000097          	auipc	ra,0x0
    80005454:	8b4080e7          	jalr	-1868(ra) # 80004d04 <either_copyout>
    80005458:	01450863          	beq	a0,s4,80005468 <consoleread+0xb4>
    8000545c:	001c0c13          	addi	s8,s8,1
    80005460:	fffb8b9b          	addiw	s7,s7,-1
    80005464:	fb5c94e3          	bne	s9,s5,8000540c <consoleread+0x58>
    80005468:	000b851b          	sext.w	a0,s7
    8000546c:	06813083          	ld	ra,104(sp)
    80005470:	06013403          	ld	s0,96(sp)
    80005474:	05813483          	ld	s1,88(sp)
    80005478:	05013903          	ld	s2,80(sp)
    8000547c:	04813983          	ld	s3,72(sp)
    80005480:	04013a03          	ld	s4,64(sp)
    80005484:	03813a83          	ld	s5,56(sp)
    80005488:	02813b83          	ld	s7,40(sp)
    8000548c:	02013c03          	ld	s8,32(sp)
    80005490:	01813c83          	ld	s9,24(sp)
    80005494:	40ab053b          	subw	a0,s6,a0
    80005498:	03013b03          	ld	s6,48(sp)
    8000549c:	07010113          	addi	sp,sp,112
    800054a0:	00008067          	ret
    800054a4:	00001097          	auipc	ra,0x1
    800054a8:	1d8080e7          	jalr	472(ra) # 8000667c <push_on>
    800054ac:	0984a703          	lw	a4,152(s1)
    800054b0:	09c4a783          	lw	a5,156(s1)
    800054b4:	0007879b          	sext.w	a5,a5
    800054b8:	fef70ce3          	beq	a4,a5,800054b0 <consoleread+0xfc>
    800054bc:	00001097          	auipc	ra,0x1
    800054c0:	234080e7          	jalr	564(ra) # 800066f0 <pop_on>
    800054c4:	0984a783          	lw	a5,152(s1)
    800054c8:	07f7f713          	andi	a4,a5,127
    800054cc:	00e48733          	add	a4,s1,a4
    800054d0:	01874703          	lbu	a4,24(a4)
    800054d4:	0017869b          	addiw	a3,a5,1
    800054d8:	08d4ac23          	sw	a3,152(s1)
    800054dc:	00070c9b          	sext.w	s9,a4
    800054e0:	f5371ee3          	bne	a4,s3,8000543c <consoleread+0x88>
    800054e4:	000b851b          	sext.w	a0,s7
    800054e8:	f96bf2e3          	bgeu	s7,s6,8000546c <consoleread+0xb8>
    800054ec:	08f4ac23          	sw	a5,152(s1)
    800054f0:	f7dff06f          	j	8000546c <consoleread+0xb8>

00000000800054f4 <consputc>:
    800054f4:	10000793          	li	a5,256
    800054f8:	00f50663          	beq	a0,a5,80005504 <consputc+0x10>
    800054fc:	00001317          	auipc	t1,0x1
    80005500:	9f430067          	jr	-1548(t1) # 80005ef0 <uartputc_sync>
    80005504:	ff010113          	addi	sp,sp,-16
    80005508:	00113423          	sd	ra,8(sp)
    8000550c:	00813023          	sd	s0,0(sp)
    80005510:	01010413          	addi	s0,sp,16
    80005514:	00800513          	li	a0,8
    80005518:	00001097          	auipc	ra,0x1
    8000551c:	9d8080e7          	jalr	-1576(ra) # 80005ef0 <uartputc_sync>
    80005520:	02000513          	li	a0,32
    80005524:	00001097          	auipc	ra,0x1
    80005528:	9cc080e7          	jalr	-1588(ra) # 80005ef0 <uartputc_sync>
    8000552c:	00013403          	ld	s0,0(sp)
    80005530:	00813083          	ld	ra,8(sp)
    80005534:	00800513          	li	a0,8
    80005538:	01010113          	addi	sp,sp,16
    8000553c:	00001317          	auipc	t1,0x1
    80005540:	9b430067          	jr	-1612(t1) # 80005ef0 <uartputc_sync>

0000000080005544 <consoleintr>:
    80005544:	fe010113          	addi	sp,sp,-32
    80005548:	00813823          	sd	s0,16(sp)
    8000554c:	00913423          	sd	s1,8(sp)
    80005550:	01213023          	sd	s2,0(sp)
    80005554:	00113c23          	sd	ra,24(sp)
    80005558:	02010413          	addi	s0,sp,32
    8000555c:	00005917          	auipc	s2,0x5
    80005560:	bdc90913          	addi	s2,s2,-1060 # 8000a138 <cons>
    80005564:	00050493          	mv	s1,a0
    80005568:	00090513          	mv	a0,s2
    8000556c:	00001097          	auipc	ra,0x1
    80005570:	e40080e7          	jalr	-448(ra) # 800063ac <acquire>
    80005574:	02048c63          	beqz	s1,800055ac <consoleintr+0x68>
    80005578:	0a092783          	lw	a5,160(s2)
    8000557c:	09892703          	lw	a4,152(s2)
    80005580:	07f00693          	li	a3,127
    80005584:	40e7873b          	subw	a4,a5,a4
    80005588:	02e6e263          	bltu	a3,a4,800055ac <consoleintr+0x68>
    8000558c:	00d00713          	li	a4,13
    80005590:	04e48063          	beq	s1,a4,800055d0 <consoleintr+0x8c>
    80005594:	07f7f713          	andi	a4,a5,127
    80005598:	00e90733          	add	a4,s2,a4
    8000559c:	0017879b          	addiw	a5,a5,1
    800055a0:	0af92023          	sw	a5,160(s2)
    800055a4:	00970c23          	sb	s1,24(a4)
    800055a8:	08f92e23          	sw	a5,156(s2)
    800055ac:	01013403          	ld	s0,16(sp)
    800055b0:	01813083          	ld	ra,24(sp)
    800055b4:	00813483          	ld	s1,8(sp)
    800055b8:	00013903          	ld	s2,0(sp)
    800055bc:	00005517          	auipc	a0,0x5
    800055c0:	b7c50513          	addi	a0,a0,-1156 # 8000a138 <cons>
    800055c4:	02010113          	addi	sp,sp,32
    800055c8:	00001317          	auipc	t1,0x1
    800055cc:	eb030067          	jr	-336(t1) # 80006478 <release>
    800055d0:	00a00493          	li	s1,10
    800055d4:	fc1ff06f          	j	80005594 <consoleintr+0x50>

00000000800055d8 <consoleinit>:
    800055d8:	fe010113          	addi	sp,sp,-32
    800055dc:	00113c23          	sd	ra,24(sp)
    800055e0:	00813823          	sd	s0,16(sp)
    800055e4:	00913423          	sd	s1,8(sp)
    800055e8:	02010413          	addi	s0,sp,32
    800055ec:	00005497          	auipc	s1,0x5
    800055f0:	b4c48493          	addi	s1,s1,-1204 # 8000a138 <cons>
    800055f4:	00048513          	mv	a0,s1
    800055f8:	00002597          	auipc	a1,0x2
    800055fc:	d6858593          	addi	a1,a1,-664 # 80007360 <CONSOLE_STATUS+0x350>
    80005600:	00001097          	auipc	ra,0x1
    80005604:	d88080e7          	jalr	-632(ra) # 80006388 <initlock>
    80005608:	00000097          	auipc	ra,0x0
    8000560c:	7ac080e7          	jalr	1964(ra) # 80005db4 <uartinit>
    80005610:	01813083          	ld	ra,24(sp)
    80005614:	01013403          	ld	s0,16(sp)
    80005618:	00000797          	auipc	a5,0x0
    8000561c:	d9c78793          	addi	a5,a5,-612 # 800053b4 <consoleread>
    80005620:	0af4bc23          	sd	a5,184(s1)
    80005624:	00000797          	auipc	a5,0x0
    80005628:	cec78793          	addi	a5,a5,-788 # 80005310 <consolewrite>
    8000562c:	0cf4b023          	sd	a5,192(s1)
    80005630:	00813483          	ld	s1,8(sp)
    80005634:	02010113          	addi	sp,sp,32
    80005638:	00008067          	ret

000000008000563c <console_read>:
    8000563c:	ff010113          	addi	sp,sp,-16
    80005640:	00813423          	sd	s0,8(sp)
    80005644:	01010413          	addi	s0,sp,16
    80005648:	00813403          	ld	s0,8(sp)
    8000564c:	00005317          	auipc	t1,0x5
    80005650:	ba433303          	ld	t1,-1116(t1) # 8000a1f0 <devsw+0x10>
    80005654:	01010113          	addi	sp,sp,16
    80005658:	00030067          	jr	t1

000000008000565c <console_write>:
    8000565c:	ff010113          	addi	sp,sp,-16
    80005660:	00813423          	sd	s0,8(sp)
    80005664:	01010413          	addi	s0,sp,16
    80005668:	00813403          	ld	s0,8(sp)
    8000566c:	00005317          	auipc	t1,0x5
    80005670:	b8c33303          	ld	t1,-1140(t1) # 8000a1f8 <devsw+0x18>
    80005674:	01010113          	addi	sp,sp,16
    80005678:	00030067          	jr	t1

000000008000567c <panic>:
    8000567c:	fe010113          	addi	sp,sp,-32
    80005680:	00113c23          	sd	ra,24(sp)
    80005684:	00813823          	sd	s0,16(sp)
    80005688:	00913423          	sd	s1,8(sp)
    8000568c:	02010413          	addi	s0,sp,32
    80005690:	00050493          	mv	s1,a0
    80005694:	00002517          	auipc	a0,0x2
    80005698:	cd450513          	addi	a0,a0,-812 # 80007368 <CONSOLE_STATUS+0x358>
    8000569c:	00005797          	auipc	a5,0x5
    800056a0:	be07ae23          	sw	zero,-1028(a5) # 8000a298 <pr+0x18>
    800056a4:	00000097          	auipc	ra,0x0
    800056a8:	034080e7          	jalr	52(ra) # 800056d8 <__printf>
    800056ac:	00048513          	mv	a0,s1
    800056b0:	00000097          	auipc	ra,0x0
    800056b4:	028080e7          	jalr	40(ra) # 800056d8 <__printf>
    800056b8:	00002517          	auipc	a0,0x2
    800056bc:	b5850513          	addi	a0,a0,-1192 # 80007210 <CONSOLE_STATUS+0x200>
    800056c0:	00000097          	auipc	ra,0x0
    800056c4:	018080e7          	jalr	24(ra) # 800056d8 <__printf>
    800056c8:	00100793          	li	a5,1
    800056cc:	00004717          	auipc	a4,0x4
    800056d0:	84f72e23          	sw	a5,-1956(a4) # 80008f28 <panicked>
    800056d4:	0000006f          	j	800056d4 <panic+0x58>

00000000800056d8 <__printf>:
    800056d8:	f3010113          	addi	sp,sp,-208
    800056dc:	08813023          	sd	s0,128(sp)
    800056e0:	07313423          	sd	s3,104(sp)
    800056e4:	09010413          	addi	s0,sp,144
    800056e8:	05813023          	sd	s8,64(sp)
    800056ec:	08113423          	sd	ra,136(sp)
    800056f0:	06913c23          	sd	s1,120(sp)
    800056f4:	07213823          	sd	s2,112(sp)
    800056f8:	07413023          	sd	s4,96(sp)
    800056fc:	05513c23          	sd	s5,88(sp)
    80005700:	05613823          	sd	s6,80(sp)
    80005704:	05713423          	sd	s7,72(sp)
    80005708:	03913c23          	sd	s9,56(sp)
    8000570c:	03a13823          	sd	s10,48(sp)
    80005710:	03b13423          	sd	s11,40(sp)
    80005714:	00005317          	auipc	t1,0x5
    80005718:	b6c30313          	addi	t1,t1,-1172 # 8000a280 <pr>
    8000571c:	01832c03          	lw	s8,24(t1)
    80005720:	00b43423          	sd	a1,8(s0)
    80005724:	00c43823          	sd	a2,16(s0)
    80005728:	00d43c23          	sd	a3,24(s0)
    8000572c:	02e43023          	sd	a4,32(s0)
    80005730:	02f43423          	sd	a5,40(s0)
    80005734:	03043823          	sd	a6,48(s0)
    80005738:	03143c23          	sd	a7,56(s0)
    8000573c:	00050993          	mv	s3,a0
    80005740:	4a0c1663          	bnez	s8,80005bec <__printf+0x514>
    80005744:	60098c63          	beqz	s3,80005d5c <__printf+0x684>
    80005748:	0009c503          	lbu	a0,0(s3)
    8000574c:	00840793          	addi	a5,s0,8
    80005750:	f6f43c23          	sd	a5,-136(s0)
    80005754:	00000493          	li	s1,0
    80005758:	22050063          	beqz	a0,80005978 <__printf+0x2a0>
    8000575c:	00002a37          	lui	s4,0x2
    80005760:	00018ab7          	lui	s5,0x18
    80005764:	000f4b37          	lui	s6,0xf4
    80005768:	00989bb7          	lui	s7,0x989
    8000576c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005770:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005774:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005778:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000577c:	00148c9b          	addiw	s9,s1,1
    80005780:	02500793          	li	a5,37
    80005784:	01998933          	add	s2,s3,s9
    80005788:	38f51263          	bne	a0,a5,80005b0c <__printf+0x434>
    8000578c:	00094783          	lbu	a5,0(s2)
    80005790:	00078c9b          	sext.w	s9,a5
    80005794:	1e078263          	beqz	a5,80005978 <__printf+0x2a0>
    80005798:	0024849b          	addiw	s1,s1,2
    8000579c:	07000713          	li	a4,112
    800057a0:	00998933          	add	s2,s3,s1
    800057a4:	38e78a63          	beq	a5,a4,80005b38 <__printf+0x460>
    800057a8:	20f76863          	bltu	a4,a5,800059b8 <__printf+0x2e0>
    800057ac:	42a78863          	beq	a5,a0,80005bdc <__printf+0x504>
    800057b0:	06400713          	li	a4,100
    800057b4:	40e79663          	bne	a5,a4,80005bc0 <__printf+0x4e8>
    800057b8:	f7843783          	ld	a5,-136(s0)
    800057bc:	0007a603          	lw	a2,0(a5)
    800057c0:	00878793          	addi	a5,a5,8
    800057c4:	f6f43c23          	sd	a5,-136(s0)
    800057c8:	42064a63          	bltz	a2,80005bfc <__printf+0x524>
    800057cc:	00a00713          	li	a4,10
    800057d0:	02e677bb          	remuw	a5,a2,a4
    800057d4:	00002d97          	auipc	s11,0x2
    800057d8:	bbcd8d93          	addi	s11,s11,-1092 # 80007390 <digits>
    800057dc:	00900593          	li	a1,9
    800057e0:	0006051b          	sext.w	a0,a2
    800057e4:	00000c93          	li	s9,0
    800057e8:	02079793          	slli	a5,a5,0x20
    800057ec:	0207d793          	srli	a5,a5,0x20
    800057f0:	00fd87b3          	add	a5,s11,a5
    800057f4:	0007c783          	lbu	a5,0(a5)
    800057f8:	02e656bb          	divuw	a3,a2,a4
    800057fc:	f8f40023          	sb	a5,-128(s0)
    80005800:	14c5d863          	bge	a1,a2,80005950 <__printf+0x278>
    80005804:	06300593          	li	a1,99
    80005808:	00100c93          	li	s9,1
    8000580c:	02e6f7bb          	remuw	a5,a3,a4
    80005810:	02079793          	slli	a5,a5,0x20
    80005814:	0207d793          	srli	a5,a5,0x20
    80005818:	00fd87b3          	add	a5,s11,a5
    8000581c:	0007c783          	lbu	a5,0(a5)
    80005820:	02e6d73b          	divuw	a4,a3,a4
    80005824:	f8f400a3          	sb	a5,-127(s0)
    80005828:	12a5f463          	bgeu	a1,a0,80005950 <__printf+0x278>
    8000582c:	00a00693          	li	a3,10
    80005830:	00900593          	li	a1,9
    80005834:	02d777bb          	remuw	a5,a4,a3
    80005838:	02079793          	slli	a5,a5,0x20
    8000583c:	0207d793          	srli	a5,a5,0x20
    80005840:	00fd87b3          	add	a5,s11,a5
    80005844:	0007c503          	lbu	a0,0(a5)
    80005848:	02d757bb          	divuw	a5,a4,a3
    8000584c:	f8a40123          	sb	a0,-126(s0)
    80005850:	48e5f263          	bgeu	a1,a4,80005cd4 <__printf+0x5fc>
    80005854:	06300513          	li	a0,99
    80005858:	02d7f5bb          	remuw	a1,a5,a3
    8000585c:	02059593          	slli	a1,a1,0x20
    80005860:	0205d593          	srli	a1,a1,0x20
    80005864:	00bd85b3          	add	a1,s11,a1
    80005868:	0005c583          	lbu	a1,0(a1)
    8000586c:	02d7d7bb          	divuw	a5,a5,a3
    80005870:	f8b401a3          	sb	a1,-125(s0)
    80005874:	48e57263          	bgeu	a0,a4,80005cf8 <__printf+0x620>
    80005878:	3e700513          	li	a0,999
    8000587c:	02d7f5bb          	remuw	a1,a5,a3
    80005880:	02059593          	slli	a1,a1,0x20
    80005884:	0205d593          	srli	a1,a1,0x20
    80005888:	00bd85b3          	add	a1,s11,a1
    8000588c:	0005c583          	lbu	a1,0(a1)
    80005890:	02d7d7bb          	divuw	a5,a5,a3
    80005894:	f8b40223          	sb	a1,-124(s0)
    80005898:	46e57663          	bgeu	a0,a4,80005d04 <__printf+0x62c>
    8000589c:	02d7f5bb          	remuw	a1,a5,a3
    800058a0:	02059593          	slli	a1,a1,0x20
    800058a4:	0205d593          	srli	a1,a1,0x20
    800058a8:	00bd85b3          	add	a1,s11,a1
    800058ac:	0005c583          	lbu	a1,0(a1)
    800058b0:	02d7d7bb          	divuw	a5,a5,a3
    800058b4:	f8b402a3          	sb	a1,-123(s0)
    800058b8:	46ea7863          	bgeu	s4,a4,80005d28 <__printf+0x650>
    800058bc:	02d7f5bb          	remuw	a1,a5,a3
    800058c0:	02059593          	slli	a1,a1,0x20
    800058c4:	0205d593          	srli	a1,a1,0x20
    800058c8:	00bd85b3          	add	a1,s11,a1
    800058cc:	0005c583          	lbu	a1,0(a1)
    800058d0:	02d7d7bb          	divuw	a5,a5,a3
    800058d4:	f8b40323          	sb	a1,-122(s0)
    800058d8:	3eeaf863          	bgeu	s5,a4,80005cc8 <__printf+0x5f0>
    800058dc:	02d7f5bb          	remuw	a1,a5,a3
    800058e0:	02059593          	slli	a1,a1,0x20
    800058e4:	0205d593          	srli	a1,a1,0x20
    800058e8:	00bd85b3          	add	a1,s11,a1
    800058ec:	0005c583          	lbu	a1,0(a1)
    800058f0:	02d7d7bb          	divuw	a5,a5,a3
    800058f4:	f8b403a3          	sb	a1,-121(s0)
    800058f8:	42eb7e63          	bgeu	s6,a4,80005d34 <__printf+0x65c>
    800058fc:	02d7f5bb          	remuw	a1,a5,a3
    80005900:	02059593          	slli	a1,a1,0x20
    80005904:	0205d593          	srli	a1,a1,0x20
    80005908:	00bd85b3          	add	a1,s11,a1
    8000590c:	0005c583          	lbu	a1,0(a1)
    80005910:	02d7d7bb          	divuw	a5,a5,a3
    80005914:	f8b40423          	sb	a1,-120(s0)
    80005918:	42ebfc63          	bgeu	s7,a4,80005d50 <__printf+0x678>
    8000591c:	02079793          	slli	a5,a5,0x20
    80005920:	0207d793          	srli	a5,a5,0x20
    80005924:	00fd8db3          	add	s11,s11,a5
    80005928:	000dc703          	lbu	a4,0(s11)
    8000592c:	00a00793          	li	a5,10
    80005930:	00900c93          	li	s9,9
    80005934:	f8e404a3          	sb	a4,-119(s0)
    80005938:	00065c63          	bgez	a2,80005950 <__printf+0x278>
    8000593c:	f9040713          	addi	a4,s0,-112
    80005940:	00f70733          	add	a4,a4,a5
    80005944:	02d00693          	li	a3,45
    80005948:	fed70823          	sb	a3,-16(a4)
    8000594c:	00078c93          	mv	s9,a5
    80005950:	f8040793          	addi	a5,s0,-128
    80005954:	01978cb3          	add	s9,a5,s9
    80005958:	f7f40d13          	addi	s10,s0,-129
    8000595c:	000cc503          	lbu	a0,0(s9)
    80005960:	fffc8c93          	addi	s9,s9,-1
    80005964:	00000097          	auipc	ra,0x0
    80005968:	b90080e7          	jalr	-1136(ra) # 800054f4 <consputc>
    8000596c:	ffac98e3          	bne	s9,s10,8000595c <__printf+0x284>
    80005970:	00094503          	lbu	a0,0(s2)
    80005974:	e00514e3          	bnez	a0,8000577c <__printf+0xa4>
    80005978:	1a0c1663          	bnez	s8,80005b24 <__printf+0x44c>
    8000597c:	08813083          	ld	ra,136(sp)
    80005980:	08013403          	ld	s0,128(sp)
    80005984:	07813483          	ld	s1,120(sp)
    80005988:	07013903          	ld	s2,112(sp)
    8000598c:	06813983          	ld	s3,104(sp)
    80005990:	06013a03          	ld	s4,96(sp)
    80005994:	05813a83          	ld	s5,88(sp)
    80005998:	05013b03          	ld	s6,80(sp)
    8000599c:	04813b83          	ld	s7,72(sp)
    800059a0:	04013c03          	ld	s8,64(sp)
    800059a4:	03813c83          	ld	s9,56(sp)
    800059a8:	03013d03          	ld	s10,48(sp)
    800059ac:	02813d83          	ld	s11,40(sp)
    800059b0:	0d010113          	addi	sp,sp,208
    800059b4:	00008067          	ret
    800059b8:	07300713          	li	a4,115
    800059bc:	1ce78a63          	beq	a5,a4,80005b90 <__printf+0x4b8>
    800059c0:	07800713          	li	a4,120
    800059c4:	1ee79e63          	bne	a5,a4,80005bc0 <__printf+0x4e8>
    800059c8:	f7843783          	ld	a5,-136(s0)
    800059cc:	0007a703          	lw	a4,0(a5)
    800059d0:	00878793          	addi	a5,a5,8
    800059d4:	f6f43c23          	sd	a5,-136(s0)
    800059d8:	28074263          	bltz	a4,80005c5c <__printf+0x584>
    800059dc:	00002d97          	auipc	s11,0x2
    800059e0:	9b4d8d93          	addi	s11,s11,-1612 # 80007390 <digits>
    800059e4:	00f77793          	andi	a5,a4,15
    800059e8:	00fd87b3          	add	a5,s11,a5
    800059ec:	0007c683          	lbu	a3,0(a5)
    800059f0:	00f00613          	li	a2,15
    800059f4:	0007079b          	sext.w	a5,a4
    800059f8:	f8d40023          	sb	a3,-128(s0)
    800059fc:	0047559b          	srliw	a1,a4,0x4
    80005a00:	0047569b          	srliw	a3,a4,0x4
    80005a04:	00000c93          	li	s9,0
    80005a08:	0ee65063          	bge	a2,a4,80005ae8 <__printf+0x410>
    80005a0c:	00f6f693          	andi	a3,a3,15
    80005a10:	00dd86b3          	add	a3,s11,a3
    80005a14:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005a18:	0087d79b          	srliw	a5,a5,0x8
    80005a1c:	00100c93          	li	s9,1
    80005a20:	f8d400a3          	sb	a3,-127(s0)
    80005a24:	0cb67263          	bgeu	a2,a1,80005ae8 <__printf+0x410>
    80005a28:	00f7f693          	andi	a3,a5,15
    80005a2c:	00dd86b3          	add	a3,s11,a3
    80005a30:	0006c583          	lbu	a1,0(a3)
    80005a34:	00f00613          	li	a2,15
    80005a38:	0047d69b          	srliw	a3,a5,0x4
    80005a3c:	f8b40123          	sb	a1,-126(s0)
    80005a40:	0047d593          	srli	a1,a5,0x4
    80005a44:	28f67e63          	bgeu	a2,a5,80005ce0 <__printf+0x608>
    80005a48:	00f6f693          	andi	a3,a3,15
    80005a4c:	00dd86b3          	add	a3,s11,a3
    80005a50:	0006c503          	lbu	a0,0(a3)
    80005a54:	0087d813          	srli	a6,a5,0x8
    80005a58:	0087d69b          	srliw	a3,a5,0x8
    80005a5c:	f8a401a3          	sb	a0,-125(s0)
    80005a60:	28b67663          	bgeu	a2,a1,80005cec <__printf+0x614>
    80005a64:	00f6f693          	andi	a3,a3,15
    80005a68:	00dd86b3          	add	a3,s11,a3
    80005a6c:	0006c583          	lbu	a1,0(a3)
    80005a70:	00c7d513          	srli	a0,a5,0xc
    80005a74:	00c7d69b          	srliw	a3,a5,0xc
    80005a78:	f8b40223          	sb	a1,-124(s0)
    80005a7c:	29067a63          	bgeu	a2,a6,80005d10 <__printf+0x638>
    80005a80:	00f6f693          	andi	a3,a3,15
    80005a84:	00dd86b3          	add	a3,s11,a3
    80005a88:	0006c583          	lbu	a1,0(a3)
    80005a8c:	0107d813          	srli	a6,a5,0x10
    80005a90:	0107d69b          	srliw	a3,a5,0x10
    80005a94:	f8b402a3          	sb	a1,-123(s0)
    80005a98:	28a67263          	bgeu	a2,a0,80005d1c <__printf+0x644>
    80005a9c:	00f6f693          	andi	a3,a3,15
    80005aa0:	00dd86b3          	add	a3,s11,a3
    80005aa4:	0006c683          	lbu	a3,0(a3)
    80005aa8:	0147d79b          	srliw	a5,a5,0x14
    80005aac:	f8d40323          	sb	a3,-122(s0)
    80005ab0:	21067663          	bgeu	a2,a6,80005cbc <__printf+0x5e4>
    80005ab4:	02079793          	slli	a5,a5,0x20
    80005ab8:	0207d793          	srli	a5,a5,0x20
    80005abc:	00fd8db3          	add	s11,s11,a5
    80005ac0:	000dc683          	lbu	a3,0(s11)
    80005ac4:	00800793          	li	a5,8
    80005ac8:	00700c93          	li	s9,7
    80005acc:	f8d403a3          	sb	a3,-121(s0)
    80005ad0:	00075c63          	bgez	a4,80005ae8 <__printf+0x410>
    80005ad4:	f9040713          	addi	a4,s0,-112
    80005ad8:	00f70733          	add	a4,a4,a5
    80005adc:	02d00693          	li	a3,45
    80005ae0:	fed70823          	sb	a3,-16(a4)
    80005ae4:	00078c93          	mv	s9,a5
    80005ae8:	f8040793          	addi	a5,s0,-128
    80005aec:	01978cb3          	add	s9,a5,s9
    80005af0:	f7f40d13          	addi	s10,s0,-129
    80005af4:	000cc503          	lbu	a0,0(s9)
    80005af8:	fffc8c93          	addi	s9,s9,-1
    80005afc:	00000097          	auipc	ra,0x0
    80005b00:	9f8080e7          	jalr	-1544(ra) # 800054f4 <consputc>
    80005b04:	ff9d18e3          	bne	s10,s9,80005af4 <__printf+0x41c>
    80005b08:	0100006f          	j	80005b18 <__printf+0x440>
    80005b0c:	00000097          	auipc	ra,0x0
    80005b10:	9e8080e7          	jalr	-1560(ra) # 800054f4 <consputc>
    80005b14:	000c8493          	mv	s1,s9
    80005b18:	00094503          	lbu	a0,0(s2)
    80005b1c:	c60510e3          	bnez	a0,8000577c <__printf+0xa4>
    80005b20:	e40c0ee3          	beqz	s8,8000597c <__printf+0x2a4>
    80005b24:	00004517          	auipc	a0,0x4
    80005b28:	75c50513          	addi	a0,a0,1884 # 8000a280 <pr>
    80005b2c:	00001097          	auipc	ra,0x1
    80005b30:	94c080e7          	jalr	-1716(ra) # 80006478 <release>
    80005b34:	e49ff06f          	j	8000597c <__printf+0x2a4>
    80005b38:	f7843783          	ld	a5,-136(s0)
    80005b3c:	03000513          	li	a0,48
    80005b40:	01000d13          	li	s10,16
    80005b44:	00878713          	addi	a4,a5,8
    80005b48:	0007bc83          	ld	s9,0(a5)
    80005b4c:	f6e43c23          	sd	a4,-136(s0)
    80005b50:	00000097          	auipc	ra,0x0
    80005b54:	9a4080e7          	jalr	-1628(ra) # 800054f4 <consputc>
    80005b58:	07800513          	li	a0,120
    80005b5c:	00000097          	auipc	ra,0x0
    80005b60:	998080e7          	jalr	-1640(ra) # 800054f4 <consputc>
    80005b64:	00002d97          	auipc	s11,0x2
    80005b68:	82cd8d93          	addi	s11,s11,-2004 # 80007390 <digits>
    80005b6c:	03ccd793          	srli	a5,s9,0x3c
    80005b70:	00fd87b3          	add	a5,s11,a5
    80005b74:	0007c503          	lbu	a0,0(a5)
    80005b78:	fffd0d1b          	addiw	s10,s10,-1
    80005b7c:	004c9c93          	slli	s9,s9,0x4
    80005b80:	00000097          	auipc	ra,0x0
    80005b84:	974080e7          	jalr	-1676(ra) # 800054f4 <consputc>
    80005b88:	fe0d12e3          	bnez	s10,80005b6c <__printf+0x494>
    80005b8c:	f8dff06f          	j	80005b18 <__printf+0x440>
    80005b90:	f7843783          	ld	a5,-136(s0)
    80005b94:	0007bc83          	ld	s9,0(a5)
    80005b98:	00878793          	addi	a5,a5,8
    80005b9c:	f6f43c23          	sd	a5,-136(s0)
    80005ba0:	000c9a63          	bnez	s9,80005bb4 <__printf+0x4dc>
    80005ba4:	1080006f          	j	80005cac <__printf+0x5d4>
    80005ba8:	001c8c93          	addi	s9,s9,1
    80005bac:	00000097          	auipc	ra,0x0
    80005bb0:	948080e7          	jalr	-1720(ra) # 800054f4 <consputc>
    80005bb4:	000cc503          	lbu	a0,0(s9)
    80005bb8:	fe0518e3          	bnez	a0,80005ba8 <__printf+0x4d0>
    80005bbc:	f5dff06f          	j	80005b18 <__printf+0x440>
    80005bc0:	02500513          	li	a0,37
    80005bc4:	00000097          	auipc	ra,0x0
    80005bc8:	930080e7          	jalr	-1744(ra) # 800054f4 <consputc>
    80005bcc:	000c8513          	mv	a0,s9
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	924080e7          	jalr	-1756(ra) # 800054f4 <consputc>
    80005bd8:	f41ff06f          	j	80005b18 <__printf+0x440>
    80005bdc:	02500513          	li	a0,37
    80005be0:	00000097          	auipc	ra,0x0
    80005be4:	914080e7          	jalr	-1772(ra) # 800054f4 <consputc>
    80005be8:	f31ff06f          	j	80005b18 <__printf+0x440>
    80005bec:	00030513          	mv	a0,t1
    80005bf0:	00000097          	auipc	ra,0x0
    80005bf4:	7bc080e7          	jalr	1980(ra) # 800063ac <acquire>
    80005bf8:	b4dff06f          	j	80005744 <__printf+0x6c>
    80005bfc:	40c0053b          	negw	a0,a2
    80005c00:	00a00713          	li	a4,10
    80005c04:	02e576bb          	remuw	a3,a0,a4
    80005c08:	00001d97          	auipc	s11,0x1
    80005c0c:	788d8d93          	addi	s11,s11,1928 # 80007390 <digits>
    80005c10:	ff700593          	li	a1,-9
    80005c14:	02069693          	slli	a3,a3,0x20
    80005c18:	0206d693          	srli	a3,a3,0x20
    80005c1c:	00dd86b3          	add	a3,s11,a3
    80005c20:	0006c683          	lbu	a3,0(a3)
    80005c24:	02e557bb          	divuw	a5,a0,a4
    80005c28:	f8d40023          	sb	a3,-128(s0)
    80005c2c:	10b65e63          	bge	a2,a1,80005d48 <__printf+0x670>
    80005c30:	06300593          	li	a1,99
    80005c34:	02e7f6bb          	remuw	a3,a5,a4
    80005c38:	02069693          	slli	a3,a3,0x20
    80005c3c:	0206d693          	srli	a3,a3,0x20
    80005c40:	00dd86b3          	add	a3,s11,a3
    80005c44:	0006c683          	lbu	a3,0(a3)
    80005c48:	02e7d73b          	divuw	a4,a5,a4
    80005c4c:	00200793          	li	a5,2
    80005c50:	f8d400a3          	sb	a3,-127(s0)
    80005c54:	bca5ece3          	bltu	a1,a0,8000582c <__printf+0x154>
    80005c58:	ce5ff06f          	j	8000593c <__printf+0x264>
    80005c5c:	40e007bb          	negw	a5,a4
    80005c60:	00001d97          	auipc	s11,0x1
    80005c64:	730d8d93          	addi	s11,s11,1840 # 80007390 <digits>
    80005c68:	00f7f693          	andi	a3,a5,15
    80005c6c:	00dd86b3          	add	a3,s11,a3
    80005c70:	0006c583          	lbu	a1,0(a3)
    80005c74:	ff100613          	li	a2,-15
    80005c78:	0047d69b          	srliw	a3,a5,0x4
    80005c7c:	f8b40023          	sb	a1,-128(s0)
    80005c80:	0047d59b          	srliw	a1,a5,0x4
    80005c84:	0ac75e63          	bge	a4,a2,80005d40 <__printf+0x668>
    80005c88:	00f6f693          	andi	a3,a3,15
    80005c8c:	00dd86b3          	add	a3,s11,a3
    80005c90:	0006c603          	lbu	a2,0(a3)
    80005c94:	00f00693          	li	a3,15
    80005c98:	0087d79b          	srliw	a5,a5,0x8
    80005c9c:	f8c400a3          	sb	a2,-127(s0)
    80005ca0:	d8b6e4e3          	bltu	a3,a1,80005a28 <__printf+0x350>
    80005ca4:	00200793          	li	a5,2
    80005ca8:	e2dff06f          	j	80005ad4 <__printf+0x3fc>
    80005cac:	00001c97          	auipc	s9,0x1
    80005cb0:	6c4c8c93          	addi	s9,s9,1732 # 80007370 <CONSOLE_STATUS+0x360>
    80005cb4:	02800513          	li	a0,40
    80005cb8:	ef1ff06f          	j	80005ba8 <__printf+0x4d0>
    80005cbc:	00700793          	li	a5,7
    80005cc0:	00600c93          	li	s9,6
    80005cc4:	e0dff06f          	j	80005ad0 <__printf+0x3f8>
    80005cc8:	00700793          	li	a5,7
    80005ccc:	00600c93          	li	s9,6
    80005cd0:	c69ff06f          	j	80005938 <__printf+0x260>
    80005cd4:	00300793          	li	a5,3
    80005cd8:	00200c93          	li	s9,2
    80005cdc:	c5dff06f          	j	80005938 <__printf+0x260>
    80005ce0:	00300793          	li	a5,3
    80005ce4:	00200c93          	li	s9,2
    80005ce8:	de9ff06f          	j	80005ad0 <__printf+0x3f8>
    80005cec:	00400793          	li	a5,4
    80005cf0:	00300c93          	li	s9,3
    80005cf4:	dddff06f          	j	80005ad0 <__printf+0x3f8>
    80005cf8:	00400793          	li	a5,4
    80005cfc:	00300c93          	li	s9,3
    80005d00:	c39ff06f          	j	80005938 <__printf+0x260>
    80005d04:	00500793          	li	a5,5
    80005d08:	00400c93          	li	s9,4
    80005d0c:	c2dff06f          	j	80005938 <__printf+0x260>
    80005d10:	00500793          	li	a5,5
    80005d14:	00400c93          	li	s9,4
    80005d18:	db9ff06f          	j	80005ad0 <__printf+0x3f8>
    80005d1c:	00600793          	li	a5,6
    80005d20:	00500c93          	li	s9,5
    80005d24:	dadff06f          	j	80005ad0 <__printf+0x3f8>
    80005d28:	00600793          	li	a5,6
    80005d2c:	00500c93          	li	s9,5
    80005d30:	c09ff06f          	j	80005938 <__printf+0x260>
    80005d34:	00800793          	li	a5,8
    80005d38:	00700c93          	li	s9,7
    80005d3c:	bfdff06f          	j	80005938 <__printf+0x260>
    80005d40:	00100793          	li	a5,1
    80005d44:	d91ff06f          	j	80005ad4 <__printf+0x3fc>
    80005d48:	00100793          	li	a5,1
    80005d4c:	bf1ff06f          	j	8000593c <__printf+0x264>
    80005d50:	00900793          	li	a5,9
    80005d54:	00800c93          	li	s9,8
    80005d58:	be1ff06f          	j	80005938 <__printf+0x260>
    80005d5c:	00001517          	auipc	a0,0x1
    80005d60:	61c50513          	addi	a0,a0,1564 # 80007378 <CONSOLE_STATUS+0x368>
    80005d64:	00000097          	auipc	ra,0x0
    80005d68:	918080e7          	jalr	-1768(ra) # 8000567c <panic>

0000000080005d6c <printfinit>:
    80005d6c:	fe010113          	addi	sp,sp,-32
    80005d70:	00813823          	sd	s0,16(sp)
    80005d74:	00913423          	sd	s1,8(sp)
    80005d78:	00113c23          	sd	ra,24(sp)
    80005d7c:	02010413          	addi	s0,sp,32
    80005d80:	00004497          	auipc	s1,0x4
    80005d84:	50048493          	addi	s1,s1,1280 # 8000a280 <pr>
    80005d88:	00048513          	mv	a0,s1
    80005d8c:	00001597          	auipc	a1,0x1
    80005d90:	5fc58593          	addi	a1,a1,1532 # 80007388 <CONSOLE_STATUS+0x378>
    80005d94:	00000097          	auipc	ra,0x0
    80005d98:	5f4080e7          	jalr	1524(ra) # 80006388 <initlock>
    80005d9c:	01813083          	ld	ra,24(sp)
    80005da0:	01013403          	ld	s0,16(sp)
    80005da4:	0004ac23          	sw	zero,24(s1)
    80005da8:	00813483          	ld	s1,8(sp)
    80005dac:	02010113          	addi	sp,sp,32
    80005db0:	00008067          	ret

0000000080005db4 <uartinit>:
    80005db4:	ff010113          	addi	sp,sp,-16
    80005db8:	00813423          	sd	s0,8(sp)
    80005dbc:	01010413          	addi	s0,sp,16
    80005dc0:	100007b7          	lui	a5,0x10000
    80005dc4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005dc8:	f8000713          	li	a4,-128
    80005dcc:	00e781a3          	sb	a4,3(a5)
    80005dd0:	00300713          	li	a4,3
    80005dd4:	00e78023          	sb	a4,0(a5)
    80005dd8:	000780a3          	sb	zero,1(a5)
    80005ddc:	00e781a3          	sb	a4,3(a5)
    80005de0:	00700693          	li	a3,7
    80005de4:	00d78123          	sb	a3,2(a5)
    80005de8:	00e780a3          	sb	a4,1(a5)
    80005dec:	00813403          	ld	s0,8(sp)
    80005df0:	01010113          	addi	sp,sp,16
    80005df4:	00008067          	ret

0000000080005df8 <uartputc>:
    80005df8:	00003797          	auipc	a5,0x3
    80005dfc:	1307a783          	lw	a5,304(a5) # 80008f28 <panicked>
    80005e00:	00078463          	beqz	a5,80005e08 <uartputc+0x10>
    80005e04:	0000006f          	j	80005e04 <uartputc+0xc>
    80005e08:	fd010113          	addi	sp,sp,-48
    80005e0c:	02813023          	sd	s0,32(sp)
    80005e10:	00913c23          	sd	s1,24(sp)
    80005e14:	01213823          	sd	s2,16(sp)
    80005e18:	01313423          	sd	s3,8(sp)
    80005e1c:	02113423          	sd	ra,40(sp)
    80005e20:	03010413          	addi	s0,sp,48
    80005e24:	00003917          	auipc	s2,0x3
    80005e28:	10c90913          	addi	s2,s2,268 # 80008f30 <uart_tx_r>
    80005e2c:	00093783          	ld	a5,0(s2)
    80005e30:	00003497          	auipc	s1,0x3
    80005e34:	10848493          	addi	s1,s1,264 # 80008f38 <uart_tx_w>
    80005e38:	0004b703          	ld	a4,0(s1)
    80005e3c:	02078693          	addi	a3,a5,32
    80005e40:	00050993          	mv	s3,a0
    80005e44:	02e69c63          	bne	a3,a4,80005e7c <uartputc+0x84>
    80005e48:	00001097          	auipc	ra,0x1
    80005e4c:	834080e7          	jalr	-1996(ra) # 8000667c <push_on>
    80005e50:	00093783          	ld	a5,0(s2)
    80005e54:	0004b703          	ld	a4,0(s1)
    80005e58:	02078793          	addi	a5,a5,32
    80005e5c:	00e79463          	bne	a5,a4,80005e64 <uartputc+0x6c>
    80005e60:	0000006f          	j	80005e60 <uartputc+0x68>
    80005e64:	00001097          	auipc	ra,0x1
    80005e68:	88c080e7          	jalr	-1908(ra) # 800066f0 <pop_on>
    80005e6c:	00093783          	ld	a5,0(s2)
    80005e70:	0004b703          	ld	a4,0(s1)
    80005e74:	02078693          	addi	a3,a5,32
    80005e78:	fce688e3          	beq	a3,a4,80005e48 <uartputc+0x50>
    80005e7c:	01f77693          	andi	a3,a4,31
    80005e80:	00004597          	auipc	a1,0x4
    80005e84:	42058593          	addi	a1,a1,1056 # 8000a2a0 <uart_tx_buf>
    80005e88:	00d586b3          	add	a3,a1,a3
    80005e8c:	00170713          	addi	a4,a4,1
    80005e90:	01368023          	sb	s3,0(a3)
    80005e94:	00e4b023          	sd	a4,0(s1)
    80005e98:	10000637          	lui	a2,0x10000
    80005e9c:	02f71063          	bne	a4,a5,80005ebc <uartputc+0xc4>
    80005ea0:	0340006f          	j	80005ed4 <uartputc+0xdc>
    80005ea4:	00074703          	lbu	a4,0(a4)
    80005ea8:	00f93023          	sd	a5,0(s2)
    80005eac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005eb0:	00093783          	ld	a5,0(s2)
    80005eb4:	0004b703          	ld	a4,0(s1)
    80005eb8:	00f70e63          	beq	a4,a5,80005ed4 <uartputc+0xdc>
    80005ebc:	00564683          	lbu	a3,5(a2)
    80005ec0:	01f7f713          	andi	a4,a5,31
    80005ec4:	00e58733          	add	a4,a1,a4
    80005ec8:	0206f693          	andi	a3,a3,32
    80005ecc:	00178793          	addi	a5,a5,1
    80005ed0:	fc069ae3          	bnez	a3,80005ea4 <uartputc+0xac>
    80005ed4:	02813083          	ld	ra,40(sp)
    80005ed8:	02013403          	ld	s0,32(sp)
    80005edc:	01813483          	ld	s1,24(sp)
    80005ee0:	01013903          	ld	s2,16(sp)
    80005ee4:	00813983          	ld	s3,8(sp)
    80005ee8:	03010113          	addi	sp,sp,48
    80005eec:	00008067          	ret

0000000080005ef0 <uartputc_sync>:
    80005ef0:	ff010113          	addi	sp,sp,-16
    80005ef4:	00813423          	sd	s0,8(sp)
    80005ef8:	01010413          	addi	s0,sp,16
    80005efc:	00003717          	auipc	a4,0x3
    80005f00:	02c72703          	lw	a4,44(a4) # 80008f28 <panicked>
    80005f04:	02071663          	bnez	a4,80005f30 <uartputc_sync+0x40>
    80005f08:	00050793          	mv	a5,a0
    80005f0c:	100006b7          	lui	a3,0x10000
    80005f10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005f14:	02077713          	andi	a4,a4,32
    80005f18:	fe070ce3          	beqz	a4,80005f10 <uartputc_sync+0x20>
    80005f1c:	0ff7f793          	andi	a5,a5,255
    80005f20:	00f68023          	sb	a5,0(a3)
    80005f24:	00813403          	ld	s0,8(sp)
    80005f28:	01010113          	addi	sp,sp,16
    80005f2c:	00008067          	ret
    80005f30:	0000006f          	j	80005f30 <uartputc_sync+0x40>

0000000080005f34 <uartstart>:
    80005f34:	ff010113          	addi	sp,sp,-16
    80005f38:	00813423          	sd	s0,8(sp)
    80005f3c:	01010413          	addi	s0,sp,16
    80005f40:	00003617          	auipc	a2,0x3
    80005f44:	ff060613          	addi	a2,a2,-16 # 80008f30 <uart_tx_r>
    80005f48:	00003517          	auipc	a0,0x3
    80005f4c:	ff050513          	addi	a0,a0,-16 # 80008f38 <uart_tx_w>
    80005f50:	00063783          	ld	a5,0(a2)
    80005f54:	00053703          	ld	a4,0(a0)
    80005f58:	04f70263          	beq	a4,a5,80005f9c <uartstart+0x68>
    80005f5c:	100005b7          	lui	a1,0x10000
    80005f60:	00004817          	auipc	a6,0x4
    80005f64:	34080813          	addi	a6,a6,832 # 8000a2a0 <uart_tx_buf>
    80005f68:	01c0006f          	j	80005f84 <uartstart+0x50>
    80005f6c:	0006c703          	lbu	a4,0(a3)
    80005f70:	00f63023          	sd	a5,0(a2)
    80005f74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005f78:	00063783          	ld	a5,0(a2)
    80005f7c:	00053703          	ld	a4,0(a0)
    80005f80:	00f70e63          	beq	a4,a5,80005f9c <uartstart+0x68>
    80005f84:	01f7f713          	andi	a4,a5,31
    80005f88:	00e806b3          	add	a3,a6,a4
    80005f8c:	0055c703          	lbu	a4,5(a1)
    80005f90:	00178793          	addi	a5,a5,1
    80005f94:	02077713          	andi	a4,a4,32
    80005f98:	fc071ae3          	bnez	a4,80005f6c <uartstart+0x38>
    80005f9c:	00813403          	ld	s0,8(sp)
    80005fa0:	01010113          	addi	sp,sp,16
    80005fa4:	00008067          	ret

0000000080005fa8 <uartgetc>:
    80005fa8:	ff010113          	addi	sp,sp,-16
    80005fac:	00813423          	sd	s0,8(sp)
    80005fb0:	01010413          	addi	s0,sp,16
    80005fb4:	10000737          	lui	a4,0x10000
    80005fb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005fbc:	0017f793          	andi	a5,a5,1
    80005fc0:	00078c63          	beqz	a5,80005fd8 <uartgetc+0x30>
    80005fc4:	00074503          	lbu	a0,0(a4)
    80005fc8:	0ff57513          	andi	a0,a0,255
    80005fcc:	00813403          	ld	s0,8(sp)
    80005fd0:	01010113          	addi	sp,sp,16
    80005fd4:	00008067          	ret
    80005fd8:	fff00513          	li	a0,-1
    80005fdc:	ff1ff06f          	j	80005fcc <uartgetc+0x24>

0000000080005fe0 <uartintr>:
    80005fe0:	100007b7          	lui	a5,0x10000
    80005fe4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005fe8:	0017f793          	andi	a5,a5,1
    80005fec:	0a078463          	beqz	a5,80006094 <uartintr+0xb4>
    80005ff0:	fe010113          	addi	sp,sp,-32
    80005ff4:	00813823          	sd	s0,16(sp)
    80005ff8:	00913423          	sd	s1,8(sp)
    80005ffc:	00113c23          	sd	ra,24(sp)
    80006000:	02010413          	addi	s0,sp,32
    80006004:	100004b7          	lui	s1,0x10000
    80006008:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000600c:	0ff57513          	andi	a0,a0,255
    80006010:	fffff097          	auipc	ra,0xfffff
    80006014:	534080e7          	jalr	1332(ra) # 80005544 <consoleintr>
    80006018:	0054c783          	lbu	a5,5(s1)
    8000601c:	0017f793          	andi	a5,a5,1
    80006020:	fe0794e3          	bnez	a5,80006008 <uartintr+0x28>
    80006024:	00003617          	auipc	a2,0x3
    80006028:	f0c60613          	addi	a2,a2,-244 # 80008f30 <uart_tx_r>
    8000602c:	00003517          	auipc	a0,0x3
    80006030:	f0c50513          	addi	a0,a0,-244 # 80008f38 <uart_tx_w>
    80006034:	00063783          	ld	a5,0(a2)
    80006038:	00053703          	ld	a4,0(a0)
    8000603c:	04f70263          	beq	a4,a5,80006080 <uartintr+0xa0>
    80006040:	100005b7          	lui	a1,0x10000
    80006044:	00004817          	auipc	a6,0x4
    80006048:	25c80813          	addi	a6,a6,604 # 8000a2a0 <uart_tx_buf>
    8000604c:	01c0006f          	j	80006068 <uartintr+0x88>
    80006050:	0006c703          	lbu	a4,0(a3)
    80006054:	00f63023          	sd	a5,0(a2)
    80006058:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000605c:	00063783          	ld	a5,0(a2)
    80006060:	00053703          	ld	a4,0(a0)
    80006064:	00f70e63          	beq	a4,a5,80006080 <uartintr+0xa0>
    80006068:	01f7f713          	andi	a4,a5,31
    8000606c:	00e806b3          	add	a3,a6,a4
    80006070:	0055c703          	lbu	a4,5(a1)
    80006074:	00178793          	addi	a5,a5,1
    80006078:	02077713          	andi	a4,a4,32
    8000607c:	fc071ae3          	bnez	a4,80006050 <uartintr+0x70>
    80006080:	01813083          	ld	ra,24(sp)
    80006084:	01013403          	ld	s0,16(sp)
    80006088:	00813483          	ld	s1,8(sp)
    8000608c:	02010113          	addi	sp,sp,32
    80006090:	00008067          	ret
    80006094:	00003617          	auipc	a2,0x3
    80006098:	e9c60613          	addi	a2,a2,-356 # 80008f30 <uart_tx_r>
    8000609c:	00003517          	auipc	a0,0x3
    800060a0:	e9c50513          	addi	a0,a0,-356 # 80008f38 <uart_tx_w>
    800060a4:	00063783          	ld	a5,0(a2)
    800060a8:	00053703          	ld	a4,0(a0)
    800060ac:	04f70263          	beq	a4,a5,800060f0 <uartintr+0x110>
    800060b0:	100005b7          	lui	a1,0x10000
    800060b4:	00004817          	auipc	a6,0x4
    800060b8:	1ec80813          	addi	a6,a6,492 # 8000a2a0 <uart_tx_buf>
    800060bc:	01c0006f          	j	800060d8 <uartintr+0xf8>
    800060c0:	0006c703          	lbu	a4,0(a3)
    800060c4:	00f63023          	sd	a5,0(a2)
    800060c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800060cc:	00063783          	ld	a5,0(a2)
    800060d0:	00053703          	ld	a4,0(a0)
    800060d4:	02f70063          	beq	a4,a5,800060f4 <uartintr+0x114>
    800060d8:	01f7f713          	andi	a4,a5,31
    800060dc:	00e806b3          	add	a3,a6,a4
    800060e0:	0055c703          	lbu	a4,5(a1)
    800060e4:	00178793          	addi	a5,a5,1
    800060e8:	02077713          	andi	a4,a4,32
    800060ec:	fc071ae3          	bnez	a4,800060c0 <uartintr+0xe0>
    800060f0:	00008067          	ret
    800060f4:	00008067          	ret

00000000800060f8 <kinit>:
    800060f8:	fc010113          	addi	sp,sp,-64
    800060fc:	02913423          	sd	s1,40(sp)
    80006100:	fffff7b7          	lui	a5,0xfffff
    80006104:	00005497          	auipc	s1,0x5
    80006108:	1bb48493          	addi	s1,s1,443 # 8000b2bf <end+0xfff>
    8000610c:	02813823          	sd	s0,48(sp)
    80006110:	01313c23          	sd	s3,24(sp)
    80006114:	00f4f4b3          	and	s1,s1,a5
    80006118:	02113c23          	sd	ra,56(sp)
    8000611c:	03213023          	sd	s2,32(sp)
    80006120:	01413823          	sd	s4,16(sp)
    80006124:	01513423          	sd	s5,8(sp)
    80006128:	04010413          	addi	s0,sp,64
    8000612c:	000017b7          	lui	a5,0x1
    80006130:	01100993          	li	s3,17
    80006134:	00f487b3          	add	a5,s1,a5
    80006138:	01b99993          	slli	s3,s3,0x1b
    8000613c:	06f9e063          	bltu	s3,a5,8000619c <kinit+0xa4>
    80006140:	00004a97          	auipc	s5,0x4
    80006144:	180a8a93          	addi	s5,s5,384 # 8000a2c0 <end>
    80006148:	0754ec63          	bltu	s1,s5,800061c0 <kinit+0xc8>
    8000614c:	0734fa63          	bgeu	s1,s3,800061c0 <kinit+0xc8>
    80006150:	00088a37          	lui	s4,0x88
    80006154:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006158:	00003917          	auipc	s2,0x3
    8000615c:	de890913          	addi	s2,s2,-536 # 80008f40 <kmem>
    80006160:	00ca1a13          	slli	s4,s4,0xc
    80006164:	0140006f          	j	80006178 <kinit+0x80>
    80006168:	000017b7          	lui	a5,0x1
    8000616c:	00f484b3          	add	s1,s1,a5
    80006170:	0554e863          	bltu	s1,s5,800061c0 <kinit+0xc8>
    80006174:	0534f663          	bgeu	s1,s3,800061c0 <kinit+0xc8>
    80006178:	00001637          	lui	a2,0x1
    8000617c:	00100593          	li	a1,1
    80006180:	00048513          	mv	a0,s1
    80006184:	00000097          	auipc	ra,0x0
    80006188:	5e4080e7          	jalr	1508(ra) # 80006768 <__memset>
    8000618c:	00093783          	ld	a5,0(s2)
    80006190:	00f4b023          	sd	a5,0(s1)
    80006194:	00993023          	sd	s1,0(s2)
    80006198:	fd4498e3          	bne	s1,s4,80006168 <kinit+0x70>
    8000619c:	03813083          	ld	ra,56(sp)
    800061a0:	03013403          	ld	s0,48(sp)
    800061a4:	02813483          	ld	s1,40(sp)
    800061a8:	02013903          	ld	s2,32(sp)
    800061ac:	01813983          	ld	s3,24(sp)
    800061b0:	01013a03          	ld	s4,16(sp)
    800061b4:	00813a83          	ld	s5,8(sp)
    800061b8:	04010113          	addi	sp,sp,64
    800061bc:	00008067          	ret
    800061c0:	00001517          	auipc	a0,0x1
    800061c4:	1e850513          	addi	a0,a0,488 # 800073a8 <digits+0x18>
    800061c8:	fffff097          	auipc	ra,0xfffff
    800061cc:	4b4080e7          	jalr	1204(ra) # 8000567c <panic>

00000000800061d0 <freerange>:
    800061d0:	fc010113          	addi	sp,sp,-64
    800061d4:	000017b7          	lui	a5,0x1
    800061d8:	02913423          	sd	s1,40(sp)
    800061dc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800061e0:	009504b3          	add	s1,a0,s1
    800061e4:	fffff537          	lui	a0,0xfffff
    800061e8:	02813823          	sd	s0,48(sp)
    800061ec:	02113c23          	sd	ra,56(sp)
    800061f0:	03213023          	sd	s2,32(sp)
    800061f4:	01313c23          	sd	s3,24(sp)
    800061f8:	01413823          	sd	s4,16(sp)
    800061fc:	01513423          	sd	s5,8(sp)
    80006200:	01613023          	sd	s6,0(sp)
    80006204:	04010413          	addi	s0,sp,64
    80006208:	00a4f4b3          	and	s1,s1,a0
    8000620c:	00f487b3          	add	a5,s1,a5
    80006210:	06f5e463          	bltu	a1,a5,80006278 <freerange+0xa8>
    80006214:	00004a97          	auipc	s5,0x4
    80006218:	0aca8a93          	addi	s5,s5,172 # 8000a2c0 <end>
    8000621c:	0954e263          	bltu	s1,s5,800062a0 <freerange+0xd0>
    80006220:	01100993          	li	s3,17
    80006224:	01b99993          	slli	s3,s3,0x1b
    80006228:	0734fc63          	bgeu	s1,s3,800062a0 <freerange+0xd0>
    8000622c:	00058a13          	mv	s4,a1
    80006230:	00003917          	auipc	s2,0x3
    80006234:	d1090913          	addi	s2,s2,-752 # 80008f40 <kmem>
    80006238:	00002b37          	lui	s6,0x2
    8000623c:	0140006f          	j	80006250 <freerange+0x80>
    80006240:	000017b7          	lui	a5,0x1
    80006244:	00f484b3          	add	s1,s1,a5
    80006248:	0554ec63          	bltu	s1,s5,800062a0 <freerange+0xd0>
    8000624c:	0534fa63          	bgeu	s1,s3,800062a0 <freerange+0xd0>
    80006250:	00001637          	lui	a2,0x1
    80006254:	00100593          	li	a1,1
    80006258:	00048513          	mv	a0,s1
    8000625c:	00000097          	auipc	ra,0x0
    80006260:	50c080e7          	jalr	1292(ra) # 80006768 <__memset>
    80006264:	00093703          	ld	a4,0(s2)
    80006268:	016487b3          	add	a5,s1,s6
    8000626c:	00e4b023          	sd	a4,0(s1)
    80006270:	00993023          	sd	s1,0(s2)
    80006274:	fcfa76e3          	bgeu	s4,a5,80006240 <freerange+0x70>
    80006278:	03813083          	ld	ra,56(sp)
    8000627c:	03013403          	ld	s0,48(sp)
    80006280:	02813483          	ld	s1,40(sp)
    80006284:	02013903          	ld	s2,32(sp)
    80006288:	01813983          	ld	s3,24(sp)
    8000628c:	01013a03          	ld	s4,16(sp)
    80006290:	00813a83          	ld	s5,8(sp)
    80006294:	00013b03          	ld	s6,0(sp)
    80006298:	04010113          	addi	sp,sp,64
    8000629c:	00008067          	ret
    800062a0:	00001517          	auipc	a0,0x1
    800062a4:	10850513          	addi	a0,a0,264 # 800073a8 <digits+0x18>
    800062a8:	fffff097          	auipc	ra,0xfffff
    800062ac:	3d4080e7          	jalr	980(ra) # 8000567c <panic>

00000000800062b0 <kfree>:
    800062b0:	fe010113          	addi	sp,sp,-32
    800062b4:	00813823          	sd	s0,16(sp)
    800062b8:	00113c23          	sd	ra,24(sp)
    800062bc:	00913423          	sd	s1,8(sp)
    800062c0:	02010413          	addi	s0,sp,32
    800062c4:	03451793          	slli	a5,a0,0x34
    800062c8:	04079c63          	bnez	a5,80006320 <kfree+0x70>
    800062cc:	00004797          	auipc	a5,0x4
    800062d0:	ff478793          	addi	a5,a5,-12 # 8000a2c0 <end>
    800062d4:	00050493          	mv	s1,a0
    800062d8:	04f56463          	bltu	a0,a5,80006320 <kfree+0x70>
    800062dc:	01100793          	li	a5,17
    800062e0:	01b79793          	slli	a5,a5,0x1b
    800062e4:	02f57e63          	bgeu	a0,a5,80006320 <kfree+0x70>
    800062e8:	00001637          	lui	a2,0x1
    800062ec:	00100593          	li	a1,1
    800062f0:	00000097          	auipc	ra,0x0
    800062f4:	478080e7          	jalr	1144(ra) # 80006768 <__memset>
    800062f8:	00003797          	auipc	a5,0x3
    800062fc:	c4878793          	addi	a5,a5,-952 # 80008f40 <kmem>
    80006300:	0007b703          	ld	a4,0(a5)
    80006304:	01813083          	ld	ra,24(sp)
    80006308:	01013403          	ld	s0,16(sp)
    8000630c:	00e4b023          	sd	a4,0(s1)
    80006310:	0097b023          	sd	s1,0(a5)
    80006314:	00813483          	ld	s1,8(sp)
    80006318:	02010113          	addi	sp,sp,32
    8000631c:	00008067          	ret
    80006320:	00001517          	auipc	a0,0x1
    80006324:	08850513          	addi	a0,a0,136 # 800073a8 <digits+0x18>
    80006328:	fffff097          	auipc	ra,0xfffff
    8000632c:	354080e7          	jalr	852(ra) # 8000567c <panic>

0000000080006330 <kalloc>:
    80006330:	fe010113          	addi	sp,sp,-32
    80006334:	00813823          	sd	s0,16(sp)
    80006338:	00913423          	sd	s1,8(sp)
    8000633c:	00113c23          	sd	ra,24(sp)
    80006340:	02010413          	addi	s0,sp,32
    80006344:	00003797          	auipc	a5,0x3
    80006348:	bfc78793          	addi	a5,a5,-1028 # 80008f40 <kmem>
    8000634c:	0007b483          	ld	s1,0(a5)
    80006350:	02048063          	beqz	s1,80006370 <kalloc+0x40>
    80006354:	0004b703          	ld	a4,0(s1)
    80006358:	00001637          	lui	a2,0x1
    8000635c:	00500593          	li	a1,5
    80006360:	00048513          	mv	a0,s1
    80006364:	00e7b023          	sd	a4,0(a5)
    80006368:	00000097          	auipc	ra,0x0
    8000636c:	400080e7          	jalr	1024(ra) # 80006768 <__memset>
    80006370:	01813083          	ld	ra,24(sp)
    80006374:	01013403          	ld	s0,16(sp)
    80006378:	00048513          	mv	a0,s1
    8000637c:	00813483          	ld	s1,8(sp)
    80006380:	02010113          	addi	sp,sp,32
    80006384:	00008067          	ret

0000000080006388 <initlock>:
    80006388:	ff010113          	addi	sp,sp,-16
    8000638c:	00813423          	sd	s0,8(sp)
    80006390:	01010413          	addi	s0,sp,16
    80006394:	00813403          	ld	s0,8(sp)
    80006398:	00b53423          	sd	a1,8(a0)
    8000639c:	00052023          	sw	zero,0(a0)
    800063a0:	00053823          	sd	zero,16(a0)
    800063a4:	01010113          	addi	sp,sp,16
    800063a8:	00008067          	ret

00000000800063ac <acquire>:
    800063ac:	fe010113          	addi	sp,sp,-32
    800063b0:	00813823          	sd	s0,16(sp)
    800063b4:	00913423          	sd	s1,8(sp)
    800063b8:	00113c23          	sd	ra,24(sp)
    800063bc:	01213023          	sd	s2,0(sp)
    800063c0:	02010413          	addi	s0,sp,32
    800063c4:	00050493          	mv	s1,a0
    800063c8:	10002973          	csrr	s2,sstatus
    800063cc:	100027f3          	csrr	a5,sstatus
    800063d0:	ffd7f793          	andi	a5,a5,-3
    800063d4:	10079073          	csrw	sstatus,a5
    800063d8:	fffff097          	auipc	ra,0xfffff
    800063dc:	8e0080e7          	jalr	-1824(ra) # 80004cb8 <mycpu>
    800063e0:	07852783          	lw	a5,120(a0)
    800063e4:	06078e63          	beqz	a5,80006460 <acquire+0xb4>
    800063e8:	fffff097          	auipc	ra,0xfffff
    800063ec:	8d0080e7          	jalr	-1840(ra) # 80004cb8 <mycpu>
    800063f0:	07852783          	lw	a5,120(a0)
    800063f4:	0004a703          	lw	a4,0(s1)
    800063f8:	0017879b          	addiw	a5,a5,1
    800063fc:	06f52c23          	sw	a5,120(a0)
    80006400:	04071063          	bnez	a4,80006440 <acquire+0x94>
    80006404:	00100713          	li	a4,1
    80006408:	00070793          	mv	a5,a4
    8000640c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006410:	0007879b          	sext.w	a5,a5
    80006414:	fe079ae3          	bnez	a5,80006408 <acquire+0x5c>
    80006418:	0ff0000f          	fence
    8000641c:	fffff097          	auipc	ra,0xfffff
    80006420:	89c080e7          	jalr	-1892(ra) # 80004cb8 <mycpu>
    80006424:	01813083          	ld	ra,24(sp)
    80006428:	01013403          	ld	s0,16(sp)
    8000642c:	00a4b823          	sd	a0,16(s1)
    80006430:	00013903          	ld	s2,0(sp)
    80006434:	00813483          	ld	s1,8(sp)
    80006438:	02010113          	addi	sp,sp,32
    8000643c:	00008067          	ret
    80006440:	0104b903          	ld	s2,16(s1)
    80006444:	fffff097          	auipc	ra,0xfffff
    80006448:	874080e7          	jalr	-1932(ra) # 80004cb8 <mycpu>
    8000644c:	faa91ce3          	bne	s2,a0,80006404 <acquire+0x58>
    80006450:	00001517          	auipc	a0,0x1
    80006454:	f6050513          	addi	a0,a0,-160 # 800073b0 <digits+0x20>
    80006458:	fffff097          	auipc	ra,0xfffff
    8000645c:	224080e7          	jalr	548(ra) # 8000567c <panic>
    80006460:	00195913          	srli	s2,s2,0x1
    80006464:	fffff097          	auipc	ra,0xfffff
    80006468:	854080e7          	jalr	-1964(ra) # 80004cb8 <mycpu>
    8000646c:	00197913          	andi	s2,s2,1
    80006470:	07252e23          	sw	s2,124(a0)
    80006474:	f75ff06f          	j	800063e8 <acquire+0x3c>

0000000080006478 <release>:
    80006478:	fe010113          	addi	sp,sp,-32
    8000647c:	00813823          	sd	s0,16(sp)
    80006480:	00113c23          	sd	ra,24(sp)
    80006484:	00913423          	sd	s1,8(sp)
    80006488:	01213023          	sd	s2,0(sp)
    8000648c:	02010413          	addi	s0,sp,32
    80006490:	00052783          	lw	a5,0(a0)
    80006494:	00079a63          	bnez	a5,800064a8 <release+0x30>
    80006498:	00001517          	auipc	a0,0x1
    8000649c:	f2050513          	addi	a0,a0,-224 # 800073b8 <digits+0x28>
    800064a0:	fffff097          	auipc	ra,0xfffff
    800064a4:	1dc080e7          	jalr	476(ra) # 8000567c <panic>
    800064a8:	01053903          	ld	s2,16(a0)
    800064ac:	00050493          	mv	s1,a0
    800064b0:	fffff097          	auipc	ra,0xfffff
    800064b4:	808080e7          	jalr	-2040(ra) # 80004cb8 <mycpu>
    800064b8:	fea910e3          	bne	s2,a0,80006498 <release+0x20>
    800064bc:	0004b823          	sd	zero,16(s1)
    800064c0:	0ff0000f          	fence
    800064c4:	0f50000f          	fence	iorw,ow
    800064c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800064cc:	ffffe097          	auipc	ra,0xffffe
    800064d0:	7ec080e7          	jalr	2028(ra) # 80004cb8 <mycpu>
    800064d4:	100027f3          	csrr	a5,sstatus
    800064d8:	0027f793          	andi	a5,a5,2
    800064dc:	04079a63          	bnez	a5,80006530 <release+0xb8>
    800064e0:	07852783          	lw	a5,120(a0)
    800064e4:	02f05e63          	blez	a5,80006520 <release+0xa8>
    800064e8:	fff7871b          	addiw	a4,a5,-1
    800064ec:	06e52c23          	sw	a4,120(a0)
    800064f0:	00071c63          	bnez	a4,80006508 <release+0x90>
    800064f4:	07c52783          	lw	a5,124(a0)
    800064f8:	00078863          	beqz	a5,80006508 <release+0x90>
    800064fc:	100027f3          	csrr	a5,sstatus
    80006500:	0027e793          	ori	a5,a5,2
    80006504:	10079073          	csrw	sstatus,a5
    80006508:	01813083          	ld	ra,24(sp)
    8000650c:	01013403          	ld	s0,16(sp)
    80006510:	00813483          	ld	s1,8(sp)
    80006514:	00013903          	ld	s2,0(sp)
    80006518:	02010113          	addi	sp,sp,32
    8000651c:	00008067          	ret
    80006520:	00001517          	auipc	a0,0x1
    80006524:	eb850513          	addi	a0,a0,-328 # 800073d8 <digits+0x48>
    80006528:	fffff097          	auipc	ra,0xfffff
    8000652c:	154080e7          	jalr	340(ra) # 8000567c <panic>
    80006530:	00001517          	auipc	a0,0x1
    80006534:	e9050513          	addi	a0,a0,-368 # 800073c0 <digits+0x30>
    80006538:	fffff097          	auipc	ra,0xfffff
    8000653c:	144080e7          	jalr	324(ra) # 8000567c <panic>

0000000080006540 <holding>:
    80006540:	00052783          	lw	a5,0(a0)
    80006544:	00079663          	bnez	a5,80006550 <holding+0x10>
    80006548:	00000513          	li	a0,0
    8000654c:	00008067          	ret
    80006550:	fe010113          	addi	sp,sp,-32
    80006554:	00813823          	sd	s0,16(sp)
    80006558:	00913423          	sd	s1,8(sp)
    8000655c:	00113c23          	sd	ra,24(sp)
    80006560:	02010413          	addi	s0,sp,32
    80006564:	01053483          	ld	s1,16(a0)
    80006568:	ffffe097          	auipc	ra,0xffffe
    8000656c:	750080e7          	jalr	1872(ra) # 80004cb8 <mycpu>
    80006570:	01813083          	ld	ra,24(sp)
    80006574:	01013403          	ld	s0,16(sp)
    80006578:	40a48533          	sub	a0,s1,a0
    8000657c:	00153513          	seqz	a0,a0
    80006580:	00813483          	ld	s1,8(sp)
    80006584:	02010113          	addi	sp,sp,32
    80006588:	00008067          	ret

000000008000658c <push_off>:
    8000658c:	fe010113          	addi	sp,sp,-32
    80006590:	00813823          	sd	s0,16(sp)
    80006594:	00113c23          	sd	ra,24(sp)
    80006598:	00913423          	sd	s1,8(sp)
    8000659c:	02010413          	addi	s0,sp,32
    800065a0:	100024f3          	csrr	s1,sstatus
    800065a4:	100027f3          	csrr	a5,sstatus
    800065a8:	ffd7f793          	andi	a5,a5,-3
    800065ac:	10079073          	csrw	sstatus,a5
    800065b0:	ffffe097          	auipc	ra,0xffffe
    800065b4:	708080e7          	jalr	1800(ra) # 80004cb8 <mycpu>
    800065b8:	07852783          	lw	a5,120(a0)
    800065bc:	02078663          	beqz	a5,800065e8 <push_off+0x5c>
    800065c0:	ffffe097          	auipc	ra,0xffffe
    800065c4:	6f8080e7          	jalr	1784(ra) # 80004cb8 <mycpu>
    800065c8:	07852783          	lw	a5,120(a0)
    800065cc:	01813083          	ld	ra,24(sp)
    800065d0:	01013403          	ld	s0,16(sp)
    800065d4:	0017879b          	addiw	a5,a5,1
    800065d8:	06f52c23          	sw	a5,120(a0)
    800065dc:	00813483          	ld	s1,8(sp)
    800065e0:	02010113          	addi	sp,sp,32
    800065e4:	00008067          	ret
    800065e8:	0014d493          	srli	s1,s1,0x1
    800065ec:	ffffe097          	auipc	ra,0xffffe
    800065f0:	6cc080e7          	jalr	1740(ra) # 80004cb8 <mycpu>
    800065f4:	0014f493          	andi	s1,s1,1
    800065f8:	06952e23          	sw	s1,124(a0)
    800065fc:	fc5ff06f          	j	800065c0 <push_off+0x34>

0000000080006600 <pop_off>:
    80006600:	ff010113          	addi	sp,sp,-16
    80006604:	00813023          	sd	s0,0(sp)
    80006608:	00113423          	sd	ra,8(sp)
    8000660c:	01010413          	addi	s0,sp,16
    80006610:	ffffe097          	auipc	ra,0xffffe
    80006614:	6a8080e7          	jalr	1704(ra) # 80004cb8 <mycpu>
    80006618:	100027f3          	csrr	a5,sstatus
    8000661c:	0027f793          	andi	a5,a5,2
    80006620:	04079663          	bnez	a5,8000666c <pop_off+0x6c>
    80006624:	07852783          	lw	a5,120(a0)
    80006628:	02f05a63          	blez	a5,8000665c <pop_off+0x5c>
    8000662c:	fff7871b          	addiw	a4,a5,-1
    80006630:	06e52c23          	sw	a4,120(a0)
    80006634:	00071c63          	bnez	a4,8000664c <pop_off+0x4c>
    80006638:	07c52783          	lw	a5,124(a0)
    8000663c:	00078863          	beqz	a5,8000664c <pop_off+0x4c>
    80006640:	100027f3          	csrr	a5,sstatus
    80006644:	0027e793          	ori	a5,a5,2
    80006648:	10079073          	csrw	sstatus,a5
    8000664c:	00813083          	ld	ra,8(sp)
    80006650:	00013403          	ld	s0,0(sp)
    80006654:	01010113          	addi	sp,sp,16
    80006658:	00008067          	ret
    8000665c:	00001517          	auipc	a0,0x1
    80006660:	d7c50513          	addi	a0,a0,-644 # 800073d8 <digits+0x48>
    80006664:	fffff097          	auipc	ra,0xfffff
    80006668:	018080e7          	jalr	24(ra) # 8000567c <panic>
    8000666c:	00001517          	auipc	a0,0x1
    80006670:	d5450513          	addi	a0,a0,-684 # 800073c0 <digits+0x30>
    80006674:	fffff097          	auipc	ra,0xfffff
    80006678:	008080e7          	jalr	8(ra) # 8000567c <panic>

000000008000667c <push_on>:
    8000667c:	fe010113          	addi	sp,sp,-32
    80006680:	00813823          	sd	s0,16(sp)
    80006684:	00113c23          	sd	ra,24(sp)
    80006688:	00913423          	sd	s1,8(sp)
    8000668c:	02010413          	addi	s0,sp,32
    80006690:	100024f3          	csrr	s1,sstatus
    80006694:	100027f3          	csrr	a5,sstatus
    80006698:	0027e793          	ori	a5,a5,2
    8000669c:	10079073          	csrw	sstatus,a5
    800066a0:	ffffe097          	auipc	ra,0xffffe
    800066a4:	618080e7          	jalr	1560(ra) # 80004cb8 <mycpu>
    800066a8:	07852783          	lw	a5,120(a0)
    800066ac:	02078663          	beqz	a5,800066d8 <push_on+0x5c>
    800066b0:	ffffe097          	auipc	ra,0xffffe
    800066b4:	608080e7          	jalr	1544(ra) # 80004cb8 <mycpu>
    800066b8:	07852783          	lw	a5,120(a0)
    800066bc:	01813083          	ld	ra,24(sp)
    800066c0:	01013403          	ld	s0,16(sp)
    800066c4:	0017879b          	addiw	a5,a5,1
    800066c8:	06f52c23          	sw	a5,120(a0)
    800066cc:	00813483          	ld	s1,8(sp)
    800066d0:	02010113          	addi	sp,sp,32
    800066d4:	00008067          	ret
    800066d8:	0014d493          	srli	s1,s1,0x1
    800066dc:	ffffe097          	auipc	ra,0xffffe
    800066e0:	5dc080e7          	jalr	1500(ra) # 80004cb8 <mycpu>
    800066e4:	0014f493          	andi	s1,s1,1
    800066e8:	06952e23          	sw	s1,124(a0)
    800066ec:	fc5ff06f          	j	800066b0 <push_on+0x34>

00000000800066f0 <pop_on>:
    800066f0:	ff010113          	addi	sp,sp,-16
    800066f4:	00813023          	sd	s0,0(sp)
    800066f8:	00113423          	sd	ra,8(sp)
    800066fc:	01010413          	addi	s0,sp,16
    80006700:	ffffe097          	auipc	ra,0xffffe
    80006704:	5b8080e7          	jalr	1464(ra) # 80004cb8 <mycpu>
    80006708:	100027f3          	csrr	a5,sstatus
    8000670c:	0027f793          	andi	a5,a5,2
    80006710:	04078463          	beqz	a5,80006758 <pop_on+0x68>
    80006714:	07852783          	lw	a5,120(a0)
    80006718:	02f05863          	blez	a5,80006748 <pop_on+0x58>
    8000671c:	fff7879b          	addiw	a5,a5,-1
    80006720:	06f52c23          	sw	a5,120(a0)
    80006724:	07853783          	ld	a5,120(a0)
    80006728:	00079863          	bnez	a5,80006738 <pop_on+0x48>
    8000672c:	100027f3          	csrr	a5,sstatus
    80006730:	ffd7f793          	andi	a5,a5,-3
    80006734:	10079073          	csrw	sstatus,a5
    80006738:	00813083          	ld	ra,8(sp)
    8000673c:	00013403          	ld	s0,0(sp)
    80006740:	01010113          	addi	sp,sp,16
    80006744:	00008067          	ret
    80006748:	00001517          	auipc	a0,0x1
    8000674c:	cb850513          	addi	a0,a0,-840 # 80007400 <digits+0x70>
    80006750:	fffff097          	auipc	ra,0xfffff
    80006754:	f2c080e7          	jalr	-212(ra) # 8000567c <panic>
    80006758:	00001517          	auipc	a0,0x1
    8000675c:	c8850513          	addi	a0,a0,-888 # 800073e0 <digits+0x50>
    80006760:	fffff097          	auipc	ra,0xfffff
    80006764:	f1c080e7          	jalr	-228(ra) # 8000567c <panic>

0000000080006768 <__memset>:
    80006768:	ff010113          	addi	sp,sp,-16
    8000676c:	00813423          	sd	s0,8(sp)
    80006770:	01010413          	addi	s0,sp,16
    80006774:	1a060e63          	beqz	a2,80006930 <__memset+0x1c8>
    80006778:	40a007b3          	neg	a5,a0
    8000677c:	0077f793          	andi	a5,a5,7
    80006780:	00778693          	addi	a3,a5,7
    80006784:	00b00813          	li	a6,11
    80006788:	0ff5f593          	andi	a1,a1,255
    8000678c:	fff6071b          	addiw	a4,a2,-1
    80006790:	1b06e663          	bltu	a3,a6,8000693c <__memset+0x1d4>
    80006794:	1cd76463          	bltu	a4,a3,8000695c <__memset+0x1f4>
    80006798:	1a078e63          	beqz	a5,80006954 <__memset+0x1ec>
    8000679c:	00b50023          	sb	a1,0(a0)
    800067a0:	00100713          	li	a4,1
    800067a4:	1ae78463          	beq	a5,a4,8000694c <__memset+0x1e4>
    800067a8:	00b500a3          	sb	a1,1(a0)
    800067ac:	00200713          	li	a4,2
    800067b0:	1ae78a63          	beq	a5,a4,80006964 <__memset+0x1fc>
    800067b4:	00b50123          	sb	a1,2(a0)
    800067b8:	00300713          	li	a4,3
    800067bc:	18e78463          	beq	a5,a4,80006944 <__memset+0x1dc>
    800067c0:	00b501a3          	sb	a1,3(a0)
    800067c4:	00400713          	li	a4,4
    800067c8:	1ae78263          	beq	a5,a4,8000696c <__memset+0x204>
    800067cc:	00b50223          	sb	a1,4(a0)
    800067d0:	00500713          	li	a4,5
    800067d4:	1ae78063          	beq	a5,a4,80006974 <__memset+0x20c>
    800067d8:	00b502a3          	sb	a1,5(a0)
    800067dc:	00700713          	li	a4,7
    800067e0:	18e79e63          	bne	a5,a4,8000697c <__memset+0x214>
    800067e4:	00b50323          	sb	a1,6(a0)
    800067e8:	00700e93          	li	t4,7
    800067ec:	00859713          	slli	a4,a1,0x8
    800067f0:	00e5e733          	or	a4,a1,a4
    800067f4:	01059e13          	slli	t3,a1,0x10
    800067f8:	01c76e33          	or	t3,a4,t3
    800067fc:	01859313          	slli	t1,a1,0x18
    80006800:	006e6333          	or	t1,t3,t1
    80006804:	02059893          	slli	a7,a1,0x20
    80006808:	40f60e3b          	subw	t3,a2,a5
    8000680c:	011368b3          	or	a7,t1,a7
    80006810:	02859813          	slli	a6,a1,0x28
    80006814:	0108e833          	or	a6,a7,a6
    80006818:	03059693          	slli	a3,a1,0x30
    8000681c:	003e589b          	srliw	a7,t3,0x3
    80006820:	00d866b3          	or	a3,a6,a3
    80006824:	03859713          	slli	a4,a1,0x38
    80006828:	00389813          	slli	a6,a7,0x3
    8000682c:	00f507b3          	add	a5,a0,a5
    80006830:	00e6e733          	or	a4,a3,a4
    80006834:	000e089b          	sext.w	a7,t3
    80006838:	00f806b3          	add	a3,a6,a5
    8000683c:	00e7b023          	sd	a4,0(a5)
    80006840:	00878793          	addi	a5,a5,8
    80006844:	fed79ce3          	bne	a5,a3,8000683c <__memset+0xd4>
    80006848:	ff8e7793          	andi	a5,t3,-8
    8000684c:	0007871b          	sext.w	a4,a5
    80006850:	01d787bb          	addw	a5,a5,t4
    80006854:	0ce88e63          	beq	a7,a4,80006930 <__memset+0x1c8>
    80006858:	00f50733          	add	a4,a0,a5
    8000685c:	00b70023          	sb	a1,0(a4)
    80006860:	0017871b          	addiw	a4,a5,1
    80006864:	0cc77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006868:	00e50733          	add	a4,a0,a4
    8000686c:	00b70023          	sb	a1,0(a4)
    80006870:	0027871b          	addiw	a4,a5,2
    80006874:	0ac77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006878:	00e50733          	add	a4,a0,a4
    8000687c:	00b70023          	sb	a1,0(a4)
    80006880:	0037871b          	addiw	a4,a5,3
    80006884:	0ac77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006888:	00e50733          	add	a4,a0,a4
    8000688c:	00b70023          	sb	a1,0(a4)
    80006890:	0047871b          	addiw	a4,a5,4
    80006894:	08c77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006898:	00e50733          	add	a4,a0,a4
    8000689c:	00b70023          	sb	a1,0(a4)
    800068a0:	0057871b          	addiw	a4,a5,5
    800068a4:	08c77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068a8:	00e50733          	add	a4,a0,a4
    800068ac:	00b70023          	sb	a1,0(a4)
    800068b0:	0067871b          	addiw	a4,a5,6
    800068b4:	06c77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068b8:	00e50733          	add	a4,a0,a4
    800068bc:	00b70023          	sb	a1,0(a4)
    800068c0:	0077871b          	addiw	a4,a5,7
    800068c4:	06c77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068c8:	00e50733          	add	a4,a0,a4
    800068cc:	00b70023          	sb	a1,0(a4)
    800068d0:	0087871b          	addiw	a4,a5,8
    800068d4:	04c77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068d8:	00e50733          	add	a4,a0,a4
    800068dc:	00b70023          	sb	a1,0(a4)
    800068e0:	0097871b          	addiw	a4,a5,9
    800068e4:	04c77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068e8:	00e50733          	add	a4,a0,a4
    800068ec:	00b70023          	sb	a1,0(a4)
    800068f0:	00a7871b          	addiw	a4,a5,10
    800068f4:	02c77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    800068f8:	00e50733          	add	a4,a0,a4
    800068fc:	00b70023          	sb	a1,0(a4)
    80006900:	00b7871b          	addiw	a4,a5,11
    80006904:	02c77663          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006908:	00e50733          	add	a4,a0,a4
    8000690c:	00b70023          	sb	a1,0(a4)
    80006910:	00c7871b          	addiw	a4,a5,12
    80006914:	00c77e63          	bgeu	a4,a2,80006930 <__memset+0x1c8>
    80006918:	00e50733          	add	a4,a0,a4
    8000691c:	00b70023          	sb	a1,0(a4)
    80006920:	00d7879b          	addiw	a5,a5,13
    80006924:	00c7f663          	bgeu	a5,a2,80006930 <__memset+0x1c8>
    80006928:	00f507b3          	add	a5,a0,a5
    8000692c:	00b78023          	sb	a1,0(a5)
    80006930:	00813403          	ld	s0,8(sp)
    80006934:	01010113          	addi	sp,sp,16
    80006938:	00008067          	ret
    8000693c:	00b00693          	li	a3,11
    80006940:	e55ff06f          	j	80006794 <__memset+0x2c>
    80006944:	00300e93          	li	t4,3
    80006948:	ea5ff06f          	j	800067ec <__memset+0x84>
    8000694c:	00100e93          	li	t4,1
    80006950:	e9dff06f          	j	800067ec <__memset+0x84>
    80006954:	00000e93          	li	t4,0
    80006958:	e95ff06f          	j	800067ec <__memset+0x84>
    8000695c:	00000793          	li	a5,0
    80006960:	ef9ff06f          	j	80006858 <__memset+0xf0>
    80006964:	00200e93          	li	t4,2
    80006968:	e85ff06f          	j	800067ec <__memset+0x84>
    8000696c:	00400e93          	li	t4,4
    80006970:	e7dff06f          	j	800067ec <__memset+0x84>
    80006974:	00500e93          	li	t4,5
    80006978:	e75ff06f          	j	800067ec <__memset+0x84>
    8000697c:	00600e93          	li	t4,6
    80006980:	e6dff06f          	j	800067ec <__memset+0x84>

0000000080006984 <__memmove>:
    80006984:	ff010113          	addi	sp,sp,-16
    80006988:	00813423          	sd	s0,8(sp)
    8000698c:	01010413          	addi	s0,sp,16
    80006990:	0e060863          	beqz	a2,80006a80 <__memmove+0xfc>
    80006994:	fff6069b          	addiw	a3,a2,-1
    80006998:	0006881b          	sext.w	a6,a3
    8000699c:	0ea5e863          	bltu	a1,a0,80006a8c <__memmove+0x108>
    800069a0:	00758713          	addi	a4,a1,7
    800069a4:	00a5e7b3          	or	a5,a1,a0
    800069a8:	40a70733          	sub	a4,a4,a0
    800069ac:	0077f793          	andi	a5,a5,7
    800069b0:	00f73713          	sltiu	a4,a4,15
    800069b4:	00174713          	xori	a4,a4,1
    800069b8:	0017b793          	seqz	a5,a5
    800069bc:	00e7f7b3          	and	a5,a5,a4
    800069c0:	10078863          	beqz	a5,80006ad0 <__memmove+0x14c>
    800069c4:	00900793          	li	a5,9
    800069c8:	1107f463          	bgeu	a5,a6,80006ad0 <__memmove+0x14c>
    800069cc:	0036581b          	srliw	a6,a2,0x3
    800069d0:	fff8081b          	addiw	a6,a6,-1
    800069d4:	02081813          	slli	a6,a6,0x20
    800069d8:	01d85893          	srli	a7,a6,0x1d
    800069dc:	00858813          	addi	a6,a1,8
    800069e0:	00058793          	mv	a5,a1
    800069e4:	00050713          	mv	a4,a0
    800069e8:	01088833          	add	a6,a7,a6
    800069ec:	0007b883          	ld	a7,0(a5)
    800069f0:	00878793          	addi	a5,a5,8
    800069f4:	00870713          	addi	a4,a4,8
    800069f8:	ff173c23          	sd	a7,-8(a4)
    800069fc:	ff0798e3          	bne	a5,a6,800069ec <__memmove+0x68>
    80006a00:	ff867713          	andi	a4,a2,-8
    80006a04:	02071793          	slli	a5,a4,0x20
    80006a08:	0207d793          	srli	a5,a5,0x20
    80006a0c:	00f585b3          	add	a1,a1,a5
    80006a10:	40e686bb          	subw	a3,a3,a4
    80006a14:	00f507b3          	add	a5,a0,a5
    80006a18:	06e60463          	beq	a2,a4,80006a80 <__memmove+0xfc>
    80006a1c:	0005c703          	lbu	a4,0(a1)
    80006a20:	00e78023          	sb	a4,0(a5)
    80006a24:	04068e63          	beqz	a3,80006a80 <__memmove+0xfc>
    80006a28:	0015c603          	lbu	a2,1(a1)
    80006a2c:	00100713          	li	a4,1
    80006a30:	00c780a3          	sb	a2,1(a5)
    80006a34:	04e68663          	beq	a3,a4,80006a80 <__memmove+0xfc>
    80006a38:	0025c603          	lbu	a2,2(a1)
    80006a3c:	00200713          	li	a4,2
    80006a40:	00c78123          	sb	a2,2(a5)
    80006a44:	02e68e63          	beq	a3,a4,80006a80 <__memmove+0xfc>
    80006a48:	0035c603          	lbu	a2,3(a1)
    80006a4c:	00300713          	li	a4,3
    80006a50:	00c781a3          	sb	a2,3(a5)
    80006a54:	02e68663          	beq	a3,a4,80006a80 <__memmove+0xfc>
    80006a58:	0045c603          	lbu	a2,4(a1)
    80006a5c:	00400713          	li	a4,4
    80006a60:	00c78223          	sb	a2,4(a5)
    80006a64:	00e68e63          	beq	a3,a4,80006a80 <__memmove+0xfc>
    80006a68:	0055c603          	lbu	a2,5(a1)
    80006a6c:	00500713          	li	a4,5
    80006a70:	00c782a3          	sb	a2,5(a5)
    80006a74:	00e68663          	beq	a3,a4,80006a80 <__memmove+0xfc>
    80006a78:	0065c703          	lbu	a4,6(a1)
    80006a7c:	00e78323          	sb	a4,6(a5)
    80006a80:	00813403          	ld	s0,8(sp)
    80006a84:	01010113          	addi	sp,sp,16
    80006a88:	00008067          	ret
    80006a8c:	02061713          	slli	a4,a2,0x20
    80006a90:	02075713          	srli	a4,a4,0x20
    80006a94:	00e587b3          	add	a5,a1,a4
    80006a98:	f0f574e3          	bgeu	a0,a5,800069a0 <__memmove+0x1c>
    80006a9c:	02069613          	slli	a2,a3,0x20
    80006aa0:	02065613          	srli	a2,a2,0x20
    80006aa4:	fff64613          	not	a2,a2
    80006aa8:	00e50733          	add	a4,a0,a4
    80006aac:	00c78633          	add	a2,a5,a2
    80006ab0:	fff7c683          	lbu	a3,-1(a5)
    80006ab4:	fff78793          	addi	a5,a5,-1
    80006ab8:	fff70713          	addi	a4,a4,-1
    80006abc:	00d70023          	sb	a3,0(a4)
    80006ac0:	fec798e3          	bne	a5,a2,80006ab0 <__memmove+0x12c>
    80006ac4:	00813403          	ld	s0,8(sp)
    80006ac8:	01010113          	addi	sp,sp,16
    80006acc:	00008067          	ret
    80006ad0:	02069713          	slli	a4,a3,0x20
    80006ad4:	02075713          	srli	a4,a4,0x20
    80006ad8:	00170713          	addi	a4,a4,1
    80006adc:	00e50733          	add	a4,a0,a4
    80006ae0:	00050793          	mv	a5,a0
    80006ae4:	0005c683          	lbu	a3,0(a1)
    80006ae8:	00178793          	addi	a5,a5,1
    80006aec:	00158593          	addi	a1,a1,1
    80006af0:	fed78fa3          	sb	a3,-1(a5)
    80006af4:	fee798e3          	bne	a5,a4,80006ae4 <__memmove+0x160>
    80006af8:	f89ff06f          	j	80006a80 <__memmove+0xfc>
	...
