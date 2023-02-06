
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	6c013103          	ld	sp,1728(sp) # 800076c0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	531030ef          	jal	ra,80003d4c <start>

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
    800015d4:	00006797          	auipc	a5,0x6
    800015d8:	1047b783          	ld	a5,260(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015dc:	0007b503          	ld	a0,0(a5)
    800015e0:	01853703          	ld	a4,24(a0)
    800015e4:	05073783          	ld	a5,80(a4)
    800015e8:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015ec:	fa843783          	ld	a5,-88(s0)
    800015f0:	04300693          	li	a3,67
    800015f4:	04f6e263          	bltu	a3,a5,80001638 <interruptHandler+0x110>
    800015f8:	00279793          	slli	a5,a5,0x2
    800015fc:	00005697          	auipc	a3,0x5
    80001600:	a2468693          	addi	a3,a3,-1500 # 80006020 <CONSOLE_STATUS+0x10>
    80001604:	00d787b3          	add	a5,a5,a3
    80001608:	0007a783          	lw	a5,0(a5)
    8000160c:	00d787b3          	add	a5,a5,a3
    80001610:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001614:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001618:	00651513          	slli	a0,a0,0x6
    8000161c:	00002097          	auipc	ra,0x2
    80001620:	cf4080e7          	jalr	-780(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
    80001624:	00006797          	auipc	a5,0x6
    80001628:	0b47b783          	ld	a5,180(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001650:	00002097          	auipc	ra,0x2
    80001654:	e30080e7          	jalr	-464(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
    80001658:	00006797          	auipc	a5,0x6
    8000165c:	0807b783          	ld	a5,128(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001660:	0007b783          	ld	a5,0(a5)
    80001664:	0187b783          	ld	a5,24(a5)
    80001668:	04a7b823          	sd	a0,80(a5)
                break;
    8000166c:	fcdff06f          	j	80001638 <interruptHandler+0x110>
                PCB::timeSliceCounter = 0;
    80001670:	00006797          	auipc	a5,0x6
    80001674:	0487b783          	ld	a5,72(a5) # 800076b8 <_GLOBAL_OFFSET_TABLE_+0x40>
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
    80001690:	00006797          	auipc	a5,0x6
    80001694:	0287b783          	ld	a5,40(a5) # 800076b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001698:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000169c:	00000097          	auipc	ra,0x0
    800016a0:	3d4080e7          	jalr	980(ra) # 80001a70 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016a4:	00006797          	auipc	a5,0x6
    800016a8:	0347b783          	ld	a5,52(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800016c8:	0b4080e7          	jalr	180(ra) # 80002778 <_ZN9Scheduler3putEP3PCB>
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
    800016e8:	00006797          	auipc	a5,0x6
    800016ec:	ff07b783          	ld	a5,-16(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001734:	00002097          	auipc	ra,0x2
    80001738:	b28080e7          	jalr	-1240(ra) # 8000325c <_ZN3SCBnwEm>
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
    8000174c:	00006797          	auipc	a5,0x6
    80001750:	f8c7b783          	ld	a5,-116(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001754:	0007b783          	ld	a5,0(a5)
    80001758:	0187b783          	ld	a5,24(a5)
    8000175c:	0497b823          	sd	s1,80(a5)
                break;
    80001760:	ed9ff06f          	j	80001638 <interruptHandler+0x110>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001764:	05873503          	ld	a0,88(a4)
    80001768:	00002097          	auipc	ra,0x2
    8000176c:	9d0080e7          	jalr	-1584(ra) # 80003138 <_ZN3SCB4waitEv>
    80001770:	00006797          	auipc	a5,0x6
    80001774:	f687b783          	ld	a5,-152(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001778:	0007b783          	ld	a5,0(a5)
    8000177c:	0187b783          	ld	a5,24(a5)
    80001780:	04a7b823          	sd	a0,80(a5)
                break;
    80001784:	eb5ff06f          	j	80001638 <interruptHandler+0x110>
                sem->signal();
    80001788:	05873503          	ld	a0,88(a4)
    8000178c:	00002097          	auipc	ra,0x2
    80001790:	a40080e7          	jalr	-1472(ra) # 800031cc <_ZN3SCB6signalEv>
                break;
    80001794:	ea5ff06f          	j	80001638 <interruptHandler+0x110>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001798:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000179c:	00048513          	mv	a0,s1
    800017a0:	00002097          	auipc	ra,0x2
    800017a4:	b0c080e7          	jalr	-1268(ra) # 800032ac <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017a8:	e80488e3          	beqz	s1,80001638 <interruptHandler+0x110>
    800017ac:	00048513          	mv	a0,s1
    800017b0:	00002097          	auipc	ra,0x2
    800017b4:	ad4080e7          	jalr	-1324(ra) # 80003284 <_ZN3SCBdlEPv>
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
    800017d4:	00006517          	auipc	a0,0x6
    800017d8:	ecc53503          	ld	a0,-308(a0) # 800076a0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017dc:	00001097          	auipc	ra,0x1
    800017e0:	9fc080e7          	jalr	-1540(ra) # 800021d8 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    800017e4:	00006797          	auipc	a5,0x6
    800017e8:	f047b783          	ld	a5,-252(a5) # 800076e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    800017ec:	0007b503          	ld	a0,0(a5)
    800017f0:	00002097          	auipc	ra,0x2
    800017f4:	9dc080e7          	jalr	-1572(ra) # 800031cc <_ZN3SCB6signalEv>
                break;
    800017f8:	e41ff06f          	j	80001638 <interruptHandler+0x110>
                CCB::semInput->signal();
    800017fc:	00006797          	auipc	a5,0x6
    80001800:	f047b783          	ld	a5,-252(a5) # 80007700 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001804:	0007b503          	ld	a0,0(a5)
    80001808:	00002097          	auipc	ra,0x2
    8000180c:	9c4080e7          	jalr	-1596(ra) # 800031cc <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001810:	00006517          	auipc	a0,0x6
    80001814:	e9853503          	ld	a0,-360(a0) # 800076a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001818:	00001097          	auipc	ra,0x1
    8000181c:	b48080e7          	jalr	-1208(ra) # 80002360 <_ZN8IOBuffer9peekFrontEv>
    80001820:	00051e63          	bnez	a0,8000183c <interruptHandler+0x314>
                    CCB::inputBufferEmpty->wait();
    80001824:	00006797          	auipc	a5,0x6
    80001828:	ecc7b783          	ld	a5,-308(a5) # 800076f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000182c:	0007b503          	ld	a0,0(a5)
    80001830:	00002097          	auipc	ra,0x2
    80001834:	908080e7          	jalr	-1784(ra) # 80003138 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001838:	fd9ff06f          	j	80001810 <interruptHandler+0x2e8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000183c:	00006517          	auipc	a0,0x6
    80001840:	e6c53503          	ld	a0,-404(a0) # 800076a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001844:	00001097          	auipc	ra,0x1
    80001848:	a8c080e7          	jalr	-1396(ra) # 800022d0 <_ZN8IOBuffer8popFrontEv>
    8000184c:	00006797          	auipc	a5,0x6
    80001850:	e8c7b783          	ld	a5,-372(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001874:	00006497          	auipc	s1,0x6
    80001878:	e444b483          	ld	s1,-444(s1) # 800076b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000187c:	0004b783          	ld	a5,0(s1)
    80001880:	00178793          	addi	a5,a5,1
    80001884:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	0f0080e7          	jalr	240(ra) # 80001978 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001890:	00006797          	auipc	a5,0x6
    80001894:	e487b783          	ld	a5,-440(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800018d8:	cd0080e7          	jalr	-816(ra) # 800045a4 <plic_claim>
        plic_complete(code);
    800018dc:	00003097          	auipc	ra,0x3
    800018e0:	d00080e7          	jalr	-768(ra) # 800045dc <plic_complete>
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
    800018f4:	00006797          	auipc	a5,0x6
    800018f8:	e6c7b783          	ld	a5,-404(a5) # 80007760 <_ZN17SleepingProcesses4headE>
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
    80001958:	00006717          	auipc	a4,0x6
    8000195c:	e0a73423          	sd	a0,-504(a4) # 80007760 <_ZN17SleepingProcesses4headE>
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
    80001978:	00006517          	auipc	a0,0x6
    8000197c:	de853503          	ld	a0,-536(a0) # 80007760 <_ZN17SleepingProcesses4headE>
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
    800019c8:	00001097          	auipc	ra,0x1
    800019cc:	db0080e7          	jalr	-592(ra) # 80002778 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019d0:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019d4:	fe0490e3          	bnez	s1,800019b4 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019d8:	00006797          	auipc	a5,0x6
    800019dc:	d8a7b423          	sd	a0,-632(a5) # 80007760 <_ZN17SleepingProcesses4headE>
}
    800019e0:	01813083          	ld	ra,24(sp)
    800019e4:	01013403          	ld	s0,16(sp)
    800019e8:	00813483          	ld	s1,8(sp)
    800019ec:	02010113          	addi	sp,sp,32
    800019f0:	00008067          	ret
    head = curr;
    800019f4:	00006797          	auipc	a5,0x6
    800019f8:	d6a7b623          	sd	a0,-660(a5) # 80007760 <_ZN17SleepingProcesses4headE>
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
    80001a1c:	00006797          	auipc	a5,0x6
    80001a20:	d4c7b783          	ld	a5,-692(a5) # 80007768 <_ZN3PCB7runningE>
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
    80001a84:	00006497          	auipc	s1,0x6
    80001a88:	ce44b483          	ld	s1,-796(s1) # 80007768 <_ZN3PCB7runningE>
        return finished;
    80001a8c:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001a90:	00079663          	bnez	a5,80001a9c <_ZN3PCB8dispatchEv+0x2c>
    80001a94:	0294c783          	lbu	a5,41(s1)
    80001a98:	04078263          	beqz	a5,80001adc <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001a9c:	00001097          	auipc	ra,0x1
    80001aa0:	d34080e7          	jalr	-716(ra) # 800027d0 <_ZN9Scheduler3getEv>
    80001aa4:	00006797          	auipc	a5,0x6
    80001aa8:	cca7b223          	sd	a0,-828(a5) # 80007768 <_ZN3PCB7runningE>
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
    80001ae0:	00001097          	auipc	ra,0x1
    80001ae4:	c98080e7          	jalr	-872(ra) # 80002778 <_ZN9Scheduler3putEP3PCB>
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
    80001b4c:	7c8080e7          	jalr	1992(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
    80001b50:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001b54:	00008537          	lui	a0,0x8
    80001b58:	00001097          	auipc	ra,0x1
    80001b5c:	7b8080e7          	jalr	1976(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
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
    80001bcc:	00001097          	auipc	ra,0x1
    80001bd0:	fbc080e7          	jalr	-68(ra) # 80002b88 <_ZdaPv>
    delete[] sysStack;
    80001bd4:	0104b503          	ld	a0,16(s1)
    80001bd8:	00050663          	beqz	a0,80001be4 <_ZN3PCBD1Ev+0x38>
    80001bdc:	00001097          	auipc	ra,0x1
    80001be0:	fac080e7          	jalr	-84(ra) # 80002b88 <_ZdaPv>
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
    80001c0c:	708080e7          	jalr	1800(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
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
    80001c30:	00002097          	auipc	ra,0x2
    80001c34:	850080e7          	jalr	-1968(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
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
    80001ca8:	00007097          	auipc	ra,0x7
    80001cac:	c80080e7          	jalr	-896(ra) # 80008928 <_Unwind_Resume>
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
    80001cdc:	00006797          	auipc	a5,0x6
    80001ce0:	a8c7b783          	ld	a5,-1396(a5) # 80007768 <_ZN3PCB7runningE>
    80001ce4:	0187b503          	ld	a0,24(a5)
    80001ce8:	00813403          	ld	s0,8(sp)
    80001cec:	01010113          	addi	sp,sp,16
    80001cf0:	00008067          	ret

0000000080001cf4 <_ZN14BuddyAllocator12getFreeBlockEm>:
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    80001cf4:	ff010113          	addi	sp,sp,-16
    80001cf8:	00813423          	sd	s0,8(sp)
    80001cfc:	01010413          	addi	s0,sp,16
    size--;
    80001d00:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001d04:	00b00793          	li	a5,11
    80001d08:	02a7e463          	bltu	a5,a0,80001d30 <_ZN14BuddyAllocator12getFreeBlockEm+0x3c>
    80001d0c:	00351513          	slli	a0,a0,0x3
    80001d10:	00006797          	auipc	a5,0x6
    80001d14:	a6878793          	addi	a5,a5,-1432 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001d18:	00a78533          	add	a0,a5,a0
    80001d1c:	00053503          	ld	a0,0(a0)
    80001d20:	00050c63          	beqz	a0,80001d38 <_ZN14BuddyAllocator12getFreeBlockEm+0x44>

    BuddyEntry* block = buddy[size];
    return block;
}
    80001d24:	00813403          	ld	s0,8(sp)
    80001d28:	01010113          	addi	sp,sp,16
    80001d2c:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001d30:	00000513          	li	a0,0
    80001d34:	ff1ff06f          	j	80001d24 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>
    80001d38:	00000513          	li	a0,0
    80001d3c:	fe9ff06f          	j	80001d24 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>

0000000080001d40 <_ZN14BuddyAllocator12popFreeBlockEm>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    80001d40:	ff010113          	addi	sp,sp,-16
    80001d44:	00813423          	sd	s0,8(sp)
    80001d48:	01010413          	addi	s0,sp,16
    size--;
    80001d4c:	fff50793          	addi	a5,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001d50:	00b00713          	li	a4,11
    80001d54:	04f76063          	bltu	a4,a5,80001d94 <_ZN14BuddyAllocator12popFreeBlockEm+0x54>
    80001d58:	00379693          	slli	a3,a5,0x3
    80001d5c:	00006717          	auipc	a4,0x6
    80001d60:	a1c70713          	addi	a4,a4,-1508 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001d64:	00d70733          	add	a4,a4,a3
    80001d68:	00073503          	ld	a0,0(a4)
    80001d6c:	00050e63          	beqz	a0,80001d88 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001d70:	00053683          	ld	a3,0(a0)
    80001d74:	00379793          	slli	a5,a5,0x3
    80001d78:	00006717          	auipc	a4,0x6
    80001d7c:	a0070713          	addi	a4,a4,-1536 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001d80:	00f707b3          	add	a5,a4,a5
    80001d84:	00d7b023          	sd	a3,0(a5)
    return block;
}
    80001d88:	00813403          	ld	s0,8(sp)
    80001d8c:	01010113          	addi	sp,sp,16
    80001d90:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001d94:	00000513          	li	a0,0
    80001d98:	ff1ff06f          	j	80001d88 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

0000000080001d9c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    80001d9c:	ff010113          	addi	sp,sp,-16
    80001da0:	00813423          	sd	s0,8(sp)
    80001da4:	01010413          	addi	s0,sp,16
    size--;
    80001da8:	fff50693          	addi	a3,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80001dac:	00b00793          	li	a5,11
    80001db0:	06d7e663          	bltu	a5,a3,80001e1c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x80>

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001db4:	00369713          	slli	a4,a3,0x3
    80001db8:	00006797          	auipc	a5,0x6
    80001dbc:	9c078793          	addi	a5,a5,-1600 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001dc0:	00e787b3          	add	a5,a5,a4
    80001dc4:	0007b603          	ld	a2,0(a5)
    80001dc8:	00060513          	mv	a0,a2
    BuddyEntry *prev = nullptr;
    80001dcc:	00000713          	li	a4,0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001dd0:	02050263          	beqz	a0,80001df4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
        if(curr->addr == addr) {
    80001dd4:	00853783          	ld	a5,8(a0)
    80001dd8:	00b78863          	beq	a5,a1,80001de8 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x4c>
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    80001ddc:	00050713          	mv	a4,a0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001de0:	00053503          	ld	a0,0(a0)
    80001de4:	fedff06f          	j	80001dd0 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x34>
            if(prev) {
    80001de8:	00070c63          	beqz	a4,80001e00 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x64>
                prev->next = curr->next;
    80001dec:	00053783          	ld	a5,0(a0)
    80001df0:	00f73023          	sd	a5,0(a4)
    }

    return nullptr;
}
    80001df4:	00813403          	ld	s0,8(sp)
    80001df8:	01010113          	addi	sp,sp,16
    80001dfc:	00008067          	ret
                buddy[size] = buddy[size]->next;
    80001e00:	00063703          	ld	a4,0(a2)
    80001e04:	00369693          	slli	a3,a3,0x3
    80001e08:	00006797          	auipc	a5,0x6
    80001e0c:	97078793          	addi	a5,a5,-1680 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001e10:	00d786b3          	add	a3,a5,a3
    80001e14:	00e6b023          	sd	a4,0(a3)
            return curr;
    80001e18:	fddff06f          	j	80001df4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
    if(size >= maxPowerSize) return nullptr;
    80001e1c:	00000513          	li	a0,0
    80001e20:	fd5ff06f          	j	80001df4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>

0000000080001e24 <_ZN14BuddyAllocator10printBuddyEv>:

void BuddyAllocator::printBuddy() {
    80001e24:	fe010113          	addi	sp,sp,-32
    80001e28:	00113c23          	sd	ra,24(sp)
    80001e2c:	00813823          	sd	s0,16(sp)
    80001e30:	00913423          	sd	s1,8(sp)
    80001e34:	01213023          	sd	s2,0(sp)
    80001e38:	02010413          	addi	s0,sp,32
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001e3c:	00000913          	li	s2,0
    80001e40:	0180006f          	j	80001e58 <_ZN14BuddyAllocator10printBuddyEv+0x34>
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    80001e44:	00004517          	auipc	a0,0x4
    80001e48:	42c50513          	addi	a0,a0,1068 # 80006270 <CONSOLE_STATUS+0x260>
    80001e4c:	00000097          	auipc	ra,0x0
    80001e50:	5c0080e7          	jalr	1472(ra) # 8000240c <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001e54:	00190913          	addi	s2,s2,1
    80001e58:	00b00793          	li	a5,11
    80001e5c:	0727e663          	bltu	a5,s2,80001ec8 <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80001e60:	00000613          	li	a2,0
    80001e64:	00a00593          	li	a1,10
    80001e68:	0019051b          	addiw	a0,s2,1
    80001e6c:	00000097          	auipc	ra,0x0
    80001e70:	738080e7          	jalr	1848(ra) # 800025a4 <_Z8printIntiii>
        printString(": ");
    80001e74:	00004517          	auipc	a0,0x4
    80001e78:	2bc50513          	addi	a0,a0,700 # 80006130 <CONSOLE_STATUS+0x120>
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	590080e7          	jalr	1424(ra) # 8000240c <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80001e84:	00391713          	slli	a4,s2,0x3
    80001e88:	00006797          	auipc	a5,0x6
    80001e8c:	8f078793          	addi	a5,a5,-1808 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001e90:	00e787b3          	add	a5,a5,a4
    80001e94:	0007b483          	ld	s1,0(a5)
    80001e98:	fa0486e3          	beqz	s1,80001e44 <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    80001e9c:	00000613          	li	a2,0
    80001ea0:	00a00593          	li	a1,10
    80001ea4:	0084a503          	lw	a0,8(s1)
    80001ea8:	00000097          	auipc	ra,0x0
    80001eac:	6fc080e7          	jalr	1788(ra) # 800025a4 <_Z8printIntiii>
            printString(" ");
    80001eb0:	00004517          	auipc	a0,0x4
    80001eb4:	28850513          	addi	a0,a0,648 # 80006138 <CONSOLE_STATUS+0x128>
    80001eb8:	00000097          	auipc	ra,0x0
    80001ebc:	554080e7          	jalr	1364(ra) # 8000240c <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80001ec0:	0004b483          	ld	s1,0(s1)
    80001ec4:	fd5ff06f          	j	80001e98 <_ZN14BuddyAllocator10printBuddyEv+0x74>
    }
}
    80001ec8:	01813083          	ld	ra,24(sp)
    80001ecc:	01013403          	ld	s0,16(sp)
    80001ed0:	00813483          	ld	s1,8(sp)
    80001ed4:	00013903          	ld	s2,0(sp)
    80001ed8:	02010113          	addi	sp,sp,32
    80001edc:	00008067          	ret

0000000080001ee0 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
    80001ee0:	ff010113          	addi	sp,sp,-16
    80001ee4:	00813423          	sd	s0,8(sp)
    80001ee8:	01010413          	addi	s0,sp,16
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
    80001eec:	00053023          	sd	zero,0(a0)
        entry->addr = addr;
    80001ef0:	00a53423          	sd	a0,8(a0)
        return entry;
}
    80001ef4:	00813403          	ld	s0,8(sp)
    80001ef8:	01010113          	addi	sp,sp,16
    80001efc:	00008067          	ret

0000000080001f00 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>:

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    80001f00:	ff010113          	addi	sp,sp,-16
    80001f04:	00813423          	sd	s0,8(sp)
    80001f08:	01010413          	addi	s0,sp,16
    size--;
    80001f0c:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize) return -1;
    80001f10:	00b00793          	li	a5,11
    80001f14:	08a7ec63          	bltu	a5,a0,80001fac <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xac>

    if(buddy[size] == nullptr) {
    80001f18:	00351713          	slli	a4,a0,0x3
    80001f1c:	00006797          	auipc	a5,0x6
    80001f20:	85c78793          	addi	a5,a5,-1956 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001f24:	00e787b3          	add	a5,a5,a4
    80001f28:	0007b783          	ld	a5,0(a5)
    80001f2c:	00078663          	beqz	a5,80001f38 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x38>
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    80001f30:	00000613          	li	a2,0
    80001f34:	0200006f          	j	80001f54 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x54>
        buddy[size] = entry;
    80001f38:	00006797          	auipc	a5,0x6
    80001f3c:	84078793          	addi	a5,a5,-1984 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001f40:	00e78533          	add	a0,a5,a4
    80001f44:	00b53023          	sd	a1,0(a0)
        return 0;
    80001f48:	00000513          	li	a0,0
    80001f4c:	06c0006f          	j	80001fb8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f50:	00070793          	mv	a5,a4
    80001f54:	06078063          	beqz	a5,80001fb4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb4>
        if(curr->addr > entry->addr) {
    80001f58:	0087b683          	ld	a3,8(a5)
    80001f5c:	0085b703          	ld	a4,8(a1)
    80001f60:	00d76e63          	bltu	a4,a3,80001f7c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x7c>
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
    80001f64:	0007b703          	ld	a4,0(a5)
            curr->next = entry;
            break;
        }
        prev = curr;
    80001f68:	00078613          	mv	a2,a5
        if(curr->next == nullptr) {
    80001f6c:	fe0712e3          	bnez	a4,80001f50 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x50>
            curr->next = entry;
    80001f70:	00b7b023          	sd	a1,0(a5)
    }

    return 0;
    80001f74:	00000513          	li	a0,0
            break;
    80001f78:	0400006f          	j	80001fb8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
            entry->next = curr;
    80001f7c:	00f5b023          	sd	a5,0(a1)
            if(prev) {
    80001f80:	00060863          	beqz	a2,80001f90 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x90>
                prev->next = curr;
    80001f84:	00f63023          	sd	a5,0(a2)
    return 0;
    80001f88:	00000513          	li	a0,0
    80001f8c:	02c0006f          	j	80001fb8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
                buddy[size] = entry;
    80001f90:	00351513          	slli	a0,a0,0x3
    80001f94:	00005797          	auipc	a5,0x5
    80001f98:	7e478793          	addi	a5,a5,2020 # 80007778 <_ZN14BuddyAllocator5buddyE>
    80001f9c:	00a78533          	add	a0,a5,a0
    80001fa0:	00b53023          	sd	a1,0(a0)
    return 0;
    80001fa4:	00000513          	li	a0,0
    80001fa8:	0100006f          	j	80001fb8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    if(size >= maxPowerSize) return -1;
    80001fac:	fff00513          	li	a0,-1
    80001fb0:	0080006f          	j	80001fb8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    return 0;
    80001fb4:	00000513          	li	a0,0
}
    80001fb8:	00813403          	ld	s0,8(sp)
    80001fbc:	01010113          	addi	sp,sp,16
    80001fc0:	00008067          	ret

0000000080001fc4 <_ZN14BuddyAllocator9initBuddyEv>:
    if(startAddr != nullptr) return 1;
    80001fc4:	00006797          	auipc	a5,0x6
    80001fc8:	8147b783          	ld	a5,-2028(a5) # 800077d8 <_ZN14BuddyAllocator9startAddrE>
    80001fcc:	00078663          	beqz	a5,80001fd8 <_ZN14BuddyAllocator9initBuddyEv+0x14>
    80001fd0:	00100513          	li	a0,1
}
    80001fd4:	00008067          	ret
int BuddyAllocator::initBuddy() {
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00113423          	sd	ra,8(sp)
    80001fe0:	00813023          	sd	s0,0(sp)
    80001fe4:	01010413          	addi	s0,sp,16
    startAddr = (void*)HEAP_START_ADDR;
    80001fe8:	00005797          	auipc	a5,0x5
    80001fec:	6b07b783          	ld	a5,1712(a5) # 80007698 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001ff0:	0007b503          	ld	a0,0(a5)
    80001ff4:	00005797          	auipc	a5,0x5
    80001ff8:	7ea7b223          	sd	a0,2020(a5) # 800077d8 <_ZN14BuddyAllocator9startAddrE>
    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	ee4080e7          	jalr	-284(ra) # 80001ee0 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    80002004:	00050593          	mv	a1,a0
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);
    80002008:	00c00513          	li	a0,12
    8000200c:	00000097          	auipc	ra,0x0
    80002010:	ef4080e7          	jalr	-268(ra) # 80001f00 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
}
    80002014:	00813083          	ld	ra,8(sp)
    80002018:	00013403          	ld	s0,0(sp)
    8000201c:	01010113          	addi	sp,sp,16
    80002020:	00008067          	ret

0000000080002024 <_ZN14BuddyAllocator10buddyAllocEm>:
void *BuddyAllocator::buddyAlloc(size_t size) {
    80002024:	fd010113          	addi	sp,sp,-48
    80002028:	02113423          	sd	ra,40(sp)
    8000202c:	02813023          	sd	s0,32(sp)
    80002030:	00913c23          	sd	s1,24(sp)
    80002034:	01213823          	sd	s2,16(sp)
    80002038:	01313423          	sd	s3,8(sp)
    8000203c:	01413023          	sd	s4,0(sp)
    80002040:	03010413          	addi	s0,sp,48
    size--;
    80002044:	fff50a13          	addi	s4,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80002048:	00b00793          	li	a5,11
    8000204c:	0747ea63          	bltu	a5,s4,800020c0 <_ZN14BuddyAllocator10buddyAllocEm+0x9c>
    for(size_t curr = size; curr < maxPowerSize; curr++) {
    80002050:	000a0493          	mv	s1,s4
    80002054:	0080006f          	j	8000205c <_ZN14BuddyAllocator10buddyAllocEm+0x38>
    80002058:	00098493          	mv	s1,s3
    8000205c:	00b00793          	li	a5,11
    80002060:	0697e463          	bltu	a5,s1,800020c8 <_ZN14BuddyAllocator10buddyAllocEm+0xa4>
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
    80002064:	00148993          	addi	s3,s1,1
    80002068:	00098513          	mv	a0,s3
    8000206c:	00000097          	auipc	ra,0x0
    80002070:	cd4080e7          	jalr	-812(ra) # 80001d40 <_ZN14BuddyAllocator12popFreeBlockEm>
    80002074:	00050913          	mv	s2,a0
        if(block != nullptr) { // postoji slobodan blok ove velicine
    80002078:	fe0500e3          	beqz	a0,80002058 <_ZN14BuddyAllocator10buddyAllocEm+0x34>
            while(curr > size) {
    8000207c:	029a7e63          	bgeu	s4,s1,800020b8 <_ZN14BuddyAllocator10buddyAllocEm+0x94>

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
    static size_t sizeInBytes(size_t size) {
        size--;
    80002080:	fff48993          	addi	s3,s1,-1
        return (1<<size)*blockSize;
    80002084:	00100793          	li	a5,1
    80002088:	013797bb          	sllw	a5,a5,s3
    8000208c:	00c79793          	slli	a5,a5,0xc
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
    80002090:	00893503          	ld	a0,8(s2)
    80002094:	00f50533          	add	a0,a0,a5
    80002098:	00000097          	auipc	ra,0x0
    8000209c:	e48080e7          	jalr	-440(ra) # 80001ee0 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800020a0:	00050593          	mv	a1,a0
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment
    800020a4:	00048513          	mv	a0,s1
    800020a8:	00000097          	auipc	ra,0x0
    800020ac:	e58080e7          	jalr	-424(ra) # 80001f00 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
                curr--;
    800020b0:	00098493          	mv	s1,s3
            while(curr > size) {
    800020b4:	fc9ff06f          	j	8000207c <_ZN14BuddyAllocator10buddyAllocEm+0x58>
            void* res = block->addr;
    800020b8:	00893503          	ld	a0,8(s2)
            return res;
    800020bc:	0100006f          	j	800020cc <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    if(size >= maxPowerSize) return nullptr;
    800020c0:	00000513          	li	a0,0
    800020c4:	0080006f          	j	800020cc <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    return nullptr;
    800020c8:	00000513          	li	a0,0
}
    800020cc:	02813083          	ld	ra,40(sp)
    800020d0:	02013403          	ld	s0,32(sp)
    800020d4:	01813483          	ld	s1,24(sp)
    800020d8:	01013903          	ld	s2,16(sp)
    800020dc:	00813983          	ld	s3,8(sp)
    800020e0:	00013a03          	ld	s4,0(sp)
    800020e4:	03010113          	addi	sp,sp,48
    800020e8:	00008067          	ret

00000000800020ec <_ZN14BuddyAllocator9buddyFreeEPvm>:
    size--;
    800020ec:	fff58593          	addi	a1,a1,-1
    if(size >= maxPowerSize || addr == nullptr) return -1;
    800020f0:	00b00793          	li	a5,11
    800020f4:	0ab7ec63          	bltu	a5,a1,800021ac <_ZN14BuddyAllocator9buddyFreeEPvm+0xc0>
int BuddyAllocator::buddyFree(void *addr, size_t size) {
    800020f8:	fd010113          	addi	sp,sp,-48
    800020fc:	02113423          	sd	ra,40(sp)
    80002100:	02813023          	sd	s0,32(sp)
    80002104:	00913c23          	sd	s1,24(sp)
    80002108:	01213823          	sd	s2,16(sp)
    8000210c:	01313423          	sd	s3,8(sp)
    80002110:	01413023          	sd	s4,0(sp)
    80002114:	03010413          	addi	s0,sp,48
    80002118:	00050a13          	mv	s4,a0
    if(size >= maxPowerSize || addr == nullptr) return -1;
    8000211c:	00051a63          	bnez	a0,80002130 <_ZN14BuddyAllocator9buddyFreeEPvm+0x44>
    80002120:	fff00513          	li	a0,-1
    80002124:	0940006f          	j	800021b8 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
            next = other;
    80002128:	00048a13          	mv	s4,s1
    8000212c:	00098593          	mv	a1,s3
    while(size < maxPowerSize) {
    80002130:	00b00793          	li	a5,11
    80002134:	08b7e063          	bltu	a5,a1,800021b4 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc8>
    }

    static void* relativeAddress(void* addr) {
        return (char*)addr - (size_t)startAddr;
    80002138:	00005917          	auipc	s2,0x5
    8000213c:	6a093903          	ld	s2,1696(s2) # 800077d8 <_ZN14BuddyAllocator9startAddrE>
    80002140:	412a0933          	sub	s2,s4,s2
        size--;
    80002144:	00158993          	addi	s3,a1,1
        return (1<<size)*blockSize;
    80002148:	00100793          	li	a5,1
    8000214c:	0137973b          	sllw	a4,a5,s3
    80002150:	00c71713          	slli	a4,a4,0xc
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
    80002154:	02e97933          	remu	s2,s2,a4
    80002158:	00b797bb          	sllw	a5,a5,a1
    8000215c:	00c79793          	slli	a5,a5,0xc
        other = (void*)((char*)other + (module == 0 ? offset : -offset));
    80002160:	00090463          	beqz	s2,80002168 <_ZN14BuddyAllocator9buddyFreeEPvm+0x7c>
    80002164:	40f007b3          	neg	a5,a5
    80002168:	00fa04b3          	add	s1,s4,a5
        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
    8000216c:	00048593          	mv	a1,s1
    80002170:	00098513          	mv	a0,s3
    80002174:	00000097          	auipc	ra,0x0
    80002178:	c28080e7          	jalr	-984(ra) # 80001d9c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
    8000217c:	00050663          	beqz	a0,80002188 <_ZN14BuddyAllocator9buddyFreeEPvm+0x9c>
        if(module != 0) {
    80002180:	fa0914e3          	bnez	s2,80002128 <_ZN14BuddyAllocator9buddyFreeEPvm+0x3c>
    80002184:	fa9ff06f          	j	8000212c <_ZN14BuddyAllocator9buddyFreeEPvm+0x40>
            BuddyEntry* entry = BuddyEntry::createEntry(next);
    80002188:	000a0513          	mv	a0,s4
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	d54080e7          	jalr	-684(ra) # 80001ee0 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    80002194:	00050593          	mv	a1,a0
            BuddyEntry::addEntry(size+1, entry);
    80002198:	00098513          	mv	a0,s3
    8000219c:	00000097          	auipc	ra,0x0
    800021a0:	d64080e7          	jalr	-668(ra) # 80001f00 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
    return 0;
    800021a4:	00000513          	li	a0,0
            break;
    800021a8:	0100006f          	j	800021b8 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
    if(size >= maxPowerSize || addr == nullptr) return -1;
    800021ac:	fff00513          	li	a0,-1
}
    800021b0:	00008067          	ret
    return 0;
    800021b4:	00000513          	li	a0,0
}
    800021b8:	02813083          	ld	ra,40(sp)
    800021bc:	02013403          	ld	s0,32(sp)
    800021c0:	01813483          	ld	s1,24(sp)
    800021c4:	01013903          	ld	s2,16(sp)
    800021c8:	00813983          	ld	s3,8(sp)
    800021cc:	00013a03          	ld	s4,0(sp)
    800021d0:	03010113          	addi	sp,sp,48
    800021d4:	00008067          	ret

00000000800021d8 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    800021d8:	fe010113          	addi	sp,sp,-32
    800021dc:	00113c23          	sd	ra,24(sp)
    800021e0:	00813823          	sd	s0,16(sp)
    800021e4:	00913423          	sd	s1,8(sp)
    800021e8:	01213023          	sd	s2,0(sp)
    800021ec:	02010413          	addi	s0,sp,32
    800021f0:	00050493          	mv	s1,a0
    800021f4:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    800021f8:	01000513          	li	a0,16
    800021fc:	00001097          	auipc	ra,0x1
    80002200:	114080e7          	jalr	276(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80002204:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80002208:	01250423          	sb	s2,8(a0)
    if(!head) {
    8000220c:	0004b783          	ld	a5,0(s1)
    80002210:	02078863          	beqz	a5,80002240 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80002214:	0084b783          	ld	a5,8(s1)
    80002218:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    8000221c:	0084b783          	ld	a5,8(s1)
    80002220:	0007b783          	ld	a5,0(a5)
    80002224:	00f4b423          	sd	a5,8(s1)
    }
}
    80002228:	01813083          	ld	ra,24(sp)
    8000222c:	01013403          	ld	s0,16(sp)
    80002230:	00813483          	ld	s1,8(sp)
    80002234:	00013903          	ld	s2,0(sp)
    80002238:	02010113          	addi	sp,sp,32
    8000223c:	00008067          	ret
        head = tail = newElem;
    80002240:	00a4b423          	sd	a0,8(s1)
    80002244:	00a4b023          	sd	a0,0(s1)
    80002248:	fe1ff06f          	j	80002228 <_ZN8IOBuffer8pushBackEc+0x50>

000000008000224c <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    8000224c:	fe010113          	addi	sp,sp,-32
    80002250:	00113c23          	sd	ra,24(sp)
    80002254:	00813823          	sd	s0,16(sp)
    80002258:	00913423          	sd	s1,8(sp)
    8000225c:	02010413          	addi	s0,sp,32
    80002260:	04c0006f          	j	800022ac <_ZN3CCB9inputBodyEPv+0x60>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80002264:	00005797          	auipc	a5,0x5
    80002268:	41c7b783          	ld	a5,1052(a5) # 80007680 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000226c:	0007b783          	ld	a5,0(a5)
    80002270:	00005497          	auipc	s1,0x5
    80002274:	57048493          	addi	s1,s1,1392 # 800077e0 <_ZN3CCB11inputBufferE>
    80002278:	0007c583          	lbu	a1,0(a5)
    8000227c:	00048513          	mv	a0,s1
    80002280:	00000097          	auipc	ra,0x0
    80002284:	f58080e7          	jalr	-168(ra) # 800021d8 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80002288:	0104b503          	ld	a0,16(s1)
    8000228c:	fffff097          	auipc	ra,0xfffff
    80002290:	154080e7          	jalr	340(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    80002294:	00a00513          	li	a0,10
    80002298:	00002097          	auipc	ra,0x2
    8000229c:	344080e7          	jalr	836(ra) # 800045dc <plic_complete>
            sem_wait(semInput);
    800022a0:	0184b503          	ld	a0,24(s1)
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	0f4080e7          	jalr	244(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    800022ac:	00005797          	auipc	a5,0x5
    800022b0:	3e47b783          	ld	a5,996(a5) # 80007690 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022b4:	0007b783          	ld	a5,0(a5)
    800022b8:	0007c783          	lbu	a5,0(a5)
    800022bc:	0017f793          	andi	a5,a5,1
    800022c0:	fa0792e3          	bnez	a5,80002264 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	fb0080e7          	jalr	-80(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    800022cc:	fe1ff06f          	j	800022ac <_ZN3CCB9inputBodyEPv+0x60>

00000000800022d0 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    800022d0:	fe010113          	addi	sp,sp,-32
    800022d4:	00113c23          	sd	ra,24(sp)
    800022d8:	00813823          	sd	s0,16(sp)
    800022dc:	00913423          	sd	s1,8(sp)
    800022e0:	02010413          	addi	s0,sp,32
    800022e4:	00050793          	mv	a5,a0
    if(!head) return 0;
    800022e8:	00053503          	ld	a0,0(a0)
    800022ec:	04050063          	beqz	a0,8000232c <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    800022f0:	00053703          	ld	a4,0(a0)
    800022f4:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    800022f8:	0087b703          	ld	a4,8(a5)
    800022fc:	02e50463          	beq	a0,a4,80002324 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80002300:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80002304:	00001097          	auipc	ra,0x1
    80002308:	17c080e7          	jalr	380(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    8000230c:	00048513          	mv	a0,s1
    80002310:	01813083          	ld	ra,24(sp)
    80002314:	01013403          	ld	s0,16(sp)
    80002318:	00813483          	ld	s1,8(sp)
    8000231c:	02010113          	addi	sp,sp,32
    80002320:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80002324:	0007b423          	sd	zero,8(a5)
    80002328:	fd9ff06f          	j	80002300 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    8000232c:	00000493          	li	s1,0
    80002330:	fddff06f          	j	8000230c <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080002334 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80002334:	ff010113          	addi	sp,sp,-16
    80002338:	00813423          	sd	s0,8(sp)
    8000233c:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80002340:	00853783          	ld	a5,8(a0)
    80002344:	00078a63          	beqz	a5,80002358 <_ZN8IOBuffer8peekBackEv+0x24>
    80002348:	0087c503          	lbu	a0,8(a5)
}
    8000234c:	00813403          	ld	s0,8(sp)
    80002350:	01010113          	addi	sp,sp,16
    80002354:	00008067          	ret
    return tail ? tail->data : 0;
    80002358:	00000513          	li	a0,0
    8000235c:	ff1ff06f          	j	8000234c <_ZN8IOBuffer8peekBackEv+0x18>

0000000080002360 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80002360:	ff010113          	addi	sp,sp,-16
    80002364:	00813423          	sd	s0,8(sp)
    80002368:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    8000236c:	00053783          	ld	a5,0(a0)
    80002370:	00078a63          	beqz	a5,80002384 <_ZN8IOBuffer9peekFrontEv+0x24>
    80002374:	0087c503          	lbu	a0,8(a5)
}
    80002378:	00813403          	ld	s0,8(sp)
    8000237c:	01010113          	addi	sp,sp,16
    80002380:	00008067          	ret
    return head ? head->data : 0;
    80002384:	00000513          	li	a0,0
    80002388:	ff1ff06f          	j	80002378 <_ZN8IOBuffer9peekFrontEv+0x18>

000000008000238c <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    8000238c:	fe010113          	addi	sp,sp,-32
    80002390:	00113c23          	sd	ra,24(sp)
    80002394:	00813823          	sd	s0,16(sp)
    80002398:	00913423          	sd	s1,8(sp)
    8000239c:	02010413          	addi	s0,sp,32
    800023a0:	00c0006f          	j	800023ac <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	ed0080e7          	jalr	-304(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    800023ac:	00005797          	auipc	a5,0x5
    800023b0:	2e47b783          	ld	a5,740(a5) # 80007690 <_GLOBAL_OFFSET_TABLE_+0x18>
    800023b4:	0007b783          	ld	a5,0(a5)
    800023b8:	0007c783          	lbu	a5,0(a5)
    800023bc:	0207f793          	andi	a5,a5,32
    800023c0:	fe0782e3          	beqz	a5,800023a4 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    800023c4:	00005517          	auipc	a0,0x5
    800023c8:	43c50513          	addi	a0,a0,1084 # 80007800 <_ZN3CCB12outputBufferE>
    800023cc:	00000097          	auipc	ra,0x0
    800023d0:	f94080e7          	jalr	-108(ra) # 80002360 <_ZN8IOBuffer9peekFrontEv>
    800023d4:	fc0508e3          	beqz	a0,800023a4 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    800023d8:	00005797          	auipc	a5,0x5
    800023dc:	2d87b783          	ld	a5,728(a5) # 800076b0 <_GLOBAL_OFFSET_TABLE_+0x38>
    800023e0:	0007b483          	ld	s1,0(a5)
    800023e4:	00005517          	auipc	a0,0x5
    800023e8:	41c50513          	addi	a0,a0,1052 # 80007800 <_ZN3CCB12outputBufferE>
    800023ec:	00000097          	auipc	ra,0x0
    800023f0:	ee4080e7          	jalr	-284(ra) # 800022d0 <_ZN8IOBuffer8popFrontEv>
    800023f4:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    800023f8:	00005517          	auipc	a0,0x5
    800023fc:	41853503          	ld	a0,1048(a0) # 80007810 <_ZN3CCB9semOutputE>
    80002400:	fffff097          	auipc	ra,0xfffff
    80002404:	f98080e7          	jalr	-104(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002408:	fa5ff06f          	j	800023ac <_ZN3CCB10outputBodyEPv+0x20>

000000008000240c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000240c:	fe010113          	addi	sp,sp,-32
    80002410:	00113c23          	sd	ra,24(sp)
    80002414:	00813823          	sd	s0,16(sp)
    80002418:	00913423          	sd	s1,8(sp)
    8000241c:	02010413          	addi	s0,sp,32
    80002420:	00050493          	mv	s1,a0
    LOCK();
    80002424:	00100613          	li	a2,1
    80002428:	00000593          	li	a1,0
    8000242c:	00005517          	auipc	a0,0x5
    80002430:	3fc50513          	addi	a0,a0,1020 # 80007828 <lockPrint>
    80002434:	fffff097          	auipc	ra,0xfffff
    80002438:	d1c080e7          	jalr	-740(ra) # 80001150 <copy_and_swap>
    8000243c:	fe0514e3          	bnez	a0,80002424 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002440:	0004c503          	lbu	a0,0(s1)
    80002444:	00050a63          	beqz	a0,80002458 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002448:	fffff097          	auipc	ra,0xfffff
    8000244c:	090080e7          	jalr	144(ra) # 800014d8 <_Z4putcc>
        string++;
    80002450:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002454:	fedff06f          	j	80002440 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002458:	00000613          	li	a2,0
    8000245c:	00100593          	li	a1,1
    80002460:	00005517          	auipc	a0,0x5
    80002464:	3c850513          	addi	a0,a0,968 # 80007828 <lockPrint>
    80002468:	fffff097          	auipc	ra,0xfffff
    8000246c:	ce8080e7          	jalr	-792(ra) # 80001150 <copy_and_swap>
    80002470:	fe0514e3          	bnez	a0,80002458 <_Z11printStringPKc+0x4c>
}
    80002474:	01813083          	ld	ra,24(sp)
    80002478:	01013403          	ld	s0,16(sp)
    8000247c:	00813483          	ld	s1,8(sp)
    80002480:	02010113          	addi	sp,sp,32
    80002484:	00008067          	ret

0000000080002488 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002488:	fd010113          	addi	sp,sp,-48
    8000248c:	02113423          	sd	ra,40(sp)
    80002490:	02813023          	sd	s0,32(sp)
    80002494:	00913c23          	sd	s1,24(sp)
    80002498:	01213823          	sd	s2,16(sp)
    8000249c:	01313423          	sd	s3,8(sp)
    800024a0:	01413023          	sd	s4,0(sp)
    800024a4:	03010413          	addi	s0,sp,48
    800024a8:	00050993          	mv	s3,a0
    800024ac:	00058a13          	mv	s4,a1
    LOCK();
    800024b0:	00100613          	li	a2,1
    800024b4:	00000593          	li	a1,0
    800024b8:	00005517          	auipc	a0,0x5
    800024bc:	37050513          	addi	a0,a0,880 # 80007828 <lockPrint>
    800024c0:	fffff097          	auipc	ra,0xfffff
    800024c4:	c90080e7          	jalr	-880(ra) # 80001150 <copy_and_swap>
    800024c8:	fe0514e3          	bnez	a0,800024b0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800024cc:	00000913          	li	s2,0
    800024d0:	00090493          	mv	s1,s2
    800024d4:	0019091b          	addiw	s2,s2,1
    800024d8:	03495a63          	bge	s2,s4,8000250c <_Z9getStringPci+0x84>
        cc = getc();
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	fcc080e7          	jalr	-52(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    800024e4:	02050463          	beqz	a0,8000250c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800024e8:	009984b3          	add	s1,s3,s1
    800024ec:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800024f0:	00a00793          	li	a5,10
    800024f4:	00f50a63          	beq	a0,a5,80002508 <_Z9getStringPci+0x80>
    800024f8:	00d00793          	li	a5,13
    800024fc:	fcf51ae3          	bne	a0,a5,800024d0 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002500:	00090493          	mv	s1,s2
    80002504:	0080006f          	j	8000250c <_Z9getStringPci+0x84>
    80002508:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000250c:	009984b3          	add	s1,s3,s1
    80002510:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002514:	00000613          	li	a2,0
    80002518:	00100593          	li	a1,1
    8000251c:	00005517          	auipc	a0,0x5
    80002520:	30c50513          	addi	a0,a0,780 # 80007828 <lockPrint>
    80002524:	fffff097          	auipc	ra,0xfffff
    80002528:	c2c080e7          	jalr	-980(ra) # 80001150 <copy_and_swap>
    8000252c:	fe0514e3          	bnez	a0,80002514 <_Z9getStringPci+0x8c>
    return buf;
}
    80002530:	00098513          	mv	a0,s3
    80002534:	02813083          	ld	ra,40(sp)
    80002538:	02013403          	ld	s0,32(sp)
    8000253c:	01813483          	ld	s1,24(sp)
    80002540:	01013903          	ld	s2,16(sp)
    80002544:	00813983          	ld	s3,8(sp)
    80002548:	00013a03          	ld	s4,0(sp)
    8000254c:	03010113          	addi	sp,sp,48
    80002550:	00008067          	ret

0000000080002554 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002554:	ff010113          	addi	sp,sp,-16
    80002558:	00813423          	sd	s0,8(sp)
    8000255c:	01010413          	addi	s0,sp,16
    80002560:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002564:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002568:	0006c603          	lbu	a2,0(a3)
    8000256c:	fd06071b          	addiw	a4,a2,-48
    80002570:	0ff77713          	andi	a4,a4,255
    80002574:	00900793          	li	a5,9
    80002578:	02e7e063          	bltu	a5,a4,80002598 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000257c:	0025179b          	slliw	a5,a0,0x2
    80002580:	00a787bb          	addw	a5,a5,a0
    80002584:	0017979b          	slliw	a5,a5,0x1
    80002588:	00168693          	addi	a3,a3,1
    8000258c:	00c787bb          	addw	a5,a5,a2
    80002590:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002594:	fd5ff06f          	j	80002568 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002598:	00813403          	ld	s0,8(sp)
    8000259c:	01010113          	addi	sp,sp,16
    800025a0:	00008067          	ret

00000000800025a4 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800025a4:	fc010113          	addi	sp,sp,-64
    800025a8:	02113c23          	sd	ra,56(sp)
    800025ac:	02813823          	sd	s0,48(sp)
    800025b0:	02913423          	sd	s1,40(sp)
    800025b4:	03213023          	sd	s2,32(sp)
    800025b8:	01313c23          	sd	s3,24(sp)
    800025bc:	04010413          	addi	s0,sp,64
    800025c0:	00050493          	mv	s1,a0
    800025c4:	00058913          	mv	s2,a1
    800025c8:	00060993          	mv	s3,a2
    LOCK();
    800025cc:	00100613          	li	a2,1
    800025d0:	00000593          	li	a1,0
    800025d4:	00005517          	auipc	a0,0x5
    800025d8:	25450513          	addi	a0,a0,596 # 80007828 <lockPrint>
    800025dc:	fffff097          	auipc	ra,0xfffff
    800025e0:	b74080e7          	jalr	-1164(ra) # 80001150 <copy_and_swap>
    800025e4:	fe0514e3          	bnez	a0,800025cc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800025e8:	00098463          	beqz	s3,800025f0 <_Z8printIntiii+0x4c>
    800025ec:	0804c463          	bltz	s1,80002674 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800025f0:	0004851b          	sext.w	a0,s1
    neg = 0;
    800025f4:	00000593          	li	a1,0
    }

    i = 0;
    800025f8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800025fc:	0009079b          	sext.w	a5,s2
    80002600:	0325773b          	remuw	a4,a0,s2
    80002604:	00048613          	mv	a2,s1
    80002608:	0014849b          	addiw	s1,s1,1
    8000260c:	02071693          	slli	a3,a4,0x20
    80002610:	0206d693          	srli	a3,a3,0x20
    80002614:	00005717          	auipc	a4,0x5
    80002618:	fd470713          	addi	a4,a4,-44 # 800075e8 <digits>
    8000261c:	00d70733          	add	a4,a4,a3
    80002620:	00074683          	lbu	a3,0(a4)
    80002624:	fd040713          	addi	a4,s0,-48
    80002628:	00c70733          	add	a4,a4,a2
    8000262c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002630:	0005071b          	sext.w	a4,a0
    80002634:	0325553b          	divuw	a0,a0,s2
    80002638:	fcf772e3          	bgeu	a4,a5,800025fc <_Z8printIntiii+0x58>
    if(neg)
    8000263c:	00058c63          	beqz	a1,80002654 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002640:	fd040793          	addi	a5,s0,-48
    80002644:	009784b3          	add	s1,a5,s1
    80002648:	02d00793          	li	a5,45
    8000264c:	fef48823          	sb	a5,-16(s1)
    80002650:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002654:	fff4849b          	addiw	s1,s1,-1
    80002658:	0204c463          	bltz	s1,80002680 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000265c:	fd040793          	addi	a5,s0,-48
    80002660:	009787b3          	add	a5,a5,s1
    80002664:	ff07c503          	lbu	a0,-16(a5)
    80002668:	fffff097          	auipc	ra,0xfffff
    8000266c:	e70080e7          	jalr	-400(ra) # 800014d8 <_Z4putcc>
    80002670:	fe5ff06f          	j	80002654 <_Z8printIntiii+0xb0>
        x = -xx;
    80002674:	4090053b          	negw	a0,s1
        neg = 1;
    80002678:	00100593          	li	a1,1
        x = -xx;
    8000267c:	f7dff06f          	j	800025f8 <_Z8printIntiii+0x54>

    UNLOCK();
    80002680:	00000613          	li	a2,0
    80002684:	00100593          	li	a1,1
    80002688:	00005517          	auipc	a0,0x5
    8000268c:	1a050513          	addi	a0,a0,416 # 80007828 <lockPrint>
    80002690:	fffff097          	auipc	ra,0xfffff
    80002694:	ac0080e7          	jalr	-1344(ra) # 80001150 <copy_and_swap>
    80002698:	fe0514e3          	bnez	a0,80002680 <_Z8printIntiii+0xdc>
    8000269c:	03813083          	ld	ra,56(sp)
    800026a0:	03013403          	ld	s0,48(sp)
    800026a4:	02813483          	ld	s1,40(sp)
    800026a8:	02013903          	ld	s2,32(sp)
    800026ac:	01813983          	ld	s3,24(sp)
    800026b0:	04010113          	addi	sp,sp,64
    800026b4:	00008067          	ret

00000000800026b8 <_Z8userMainv>:
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
void userMain() {
    800026b8:	fe010113          	addi	sp,sp,-32
    800026bc:	00113c23          	sd	ra,24(sp)
    800026c0:	00813823          	sd	s0,16(sp)
    800026c4:	00913423          	sd	s1,8(sp)
    800026c8:	01213023          	sd	s2,0(sp)
    800026cc:	02010413          	addi	s0,sp,32
    BuddyAllocator::initBuddy();
    800026d0:	00000097          	auipc	ra,0x0
    800026d4:	8f4080e7          	jalr	-1804(ra) # 80001fc4 <_ZN14BuddyAllocator9initBuddyEv>

    int N = (1<<11) - 1;
    void* niz[N];
    800026d8:	ffffc7b7          	lui	a5,0xffffc
    800026dc:	00f10133          	add	sp,sp,a5
    800026e0:	00010913          	mv	s2,sp
    for(int i  = 0; i < N; i++) {
    800026e4:	00000493          	li	s1,0
    800026e8:	7fe00793          	li	a5,2046
    800026ec:	0297c263          	blt	a5,s1,80002710 <_Z8userMainv+0x58>
        niz[i] = BuddyAllocator::buddyAlloc(1);
    800026f0:	00100513          	li	a0,1
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	930080e7          	jalr	-1744(ra) # 80002024 <_ZN14BuddyAllocator10buddyAllocEm>
    800026fc:	00349793          	slli	a5,s1,0x3
    80002700:	00f907b3          	add	a5,s2,a5
    80002704:	00a7b023          	sd	a0,0(a5) # ffffffffffffc000 <end+0xffffffff7fff3540>
    for(int i  = 0; i < N; i++) {
    80002708:	0014849b          	addiw	s1,s1,1
    8000270c:	fddff06f          	j	800026e8 <_Z8userMainv+0x30>
    }
    /*printString("alocirana adresa: ");
    printInt((size_t)addr);
    printString("\n");*/
    BuddyAllocator::printBuddy();
    80002710:	fffff097          	auipc	ra,0xfffff
    80002714:	714080e7          	jalr	1812(ra) # 80001e24 <_ZN14BuddyAllocator10printBuddyEv>
    printString("posle\n");
    80002718:	00004517          	auipc	a0,0x4
    8000271c:	a2850513          	addi	a0,a0,-1496 # 80006140 <CONSOLE_STATUS+0x130>
    80002720:	00000097          	auipc	ra,0x0
    80002724:	cec080e7          	jalr	-788(ra) # 8000240c <_Z11printStringPKc>
    for(int i = 0; i < N; i++) {
    80002728:	00000493          	li	s1,0
    8000272c:	7fe00793          	li	a5,2046
    80002730:	0297c263          	blt	a5,s1,80002754 <_Z8userMainv+0x9c>
        BuddyAllocator::buddyFree(niz[i], 1);
    80002734:	00349793          	slli	a5,s1,0x3
    80002738:	00f907b3          	add	a5,s2,a5
    8000273c:	00100593          	li	a1,1
    80002740:	0007b503          	ld	a0,0(a5)
    80002744:	00000097          	auipc	ra,0x0
    80002748:	9a8080e7          	jalr	-1624(ra) # 800020ec <_ZN14BuddyAllocator9buddyFreeEPvm>
    for(int i = 0; i < N; i++) {
    8000274c:	0014849b          	addiw	s1,s1,1
    80002750:	fddff06f          	j	8000272c <_Z8userMainv+0x74>
    }
    BuddyAllocator::printBuddy();
    80002754:	fffff097          	auipc	ra,0xfffff
    80002758:	6d0080e7          	jalr	1744(ra) # 80001e24 <_ZN14BuddyAllocator10printBuddyEv>
    8000275c:	fe040113          	addi	sp,s0,-32
    80002760:	01813083          	ld	ra,24(sp)
    80002764:	01013403          	ld	s0,16(sp)
    80002768:	00813483          	ld	s1,8(sp)
    8000276c:	00013903          	ld	s2,0(sp)
    80002770:	02010113          	addi	sp,sp,32
    80002774:	00008067          	ret

0000000080002778 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002778:	ff010113          	addi	sp,sp,-16
    8000277c:	00813423          	sd	s0,8(sp)
    80002780:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002784:	02050663          	beqz	a0,800027b0 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002788:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    8000278c:	00005797          	auipc	a5,0x5
    80002790:	0a47b783          	ld	a5,164(a5) # 80007830 <_ZN9Scheduler4tailE>
    80002794:	02078463          	beqz	a5,800027bc <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002798:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    8000279c:	00005797          	auipc	a5,0x5
    800027a0:	09478793          	addi	a5,a5,148 # 80007830 <_ZN9Scheduler4tailE>
    800027a4:	0007b703          	ld	a4,0(a5)
    800027a8:	00073703          	ld	a4,0(a4)
    800027ac:	00e7b023          	sd	a4,0(a5)
    }
}
    800027b0:	00813403          	ld	s0,8(sp)
    800027b4:	01010113          	addi	sp,sp,16
    800027b8:	00008067          	ret
        head = tail = process;
    800027bc:	00005797          	auipc	a5,0x5
    800027c0:	07478793          	addi	a5,a5,116 # 80007830 <_ZN9Scheduler4tailE>
    800027c4:	00a7b023          	sd	a0,0(a5)
    800027c8:	00a7b423          	sd	a0,8(a5)
    800027cc:	fe5ff06f          	j	800027b0 <_ZN9Scheduler3putEP3PCB+0x38>

00000000800027d0 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800027d0:	ff010113          	addi	sp,sp,-16
    800027d4:	00813423          	sd	s0,8(sp)
    800027d8:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800027dc:	00005517          	auipc	a0,0x5
    800027e0:	05c53503          	ld	a0,92(a0) # 80007838 <_ZN9Scheduler4headE>
    800027e4:	02050463          	beqz	a0,8000280c <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    800027e8:	00053703          	ld	a4,0(a0)
    800027ec:	00005797          	auipc	a5,0x5
    800027f0:	04478793          	addi	a5,a5,68 # 80007830 <_ZN9Scheduler4tailE>
    800027f4:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800027f8:	0007b783          	ld	a5,0(a5)
    800027fc:	00f50e63          	beq	a0,a5,80002818 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002800:	00813403          	ld	s0,8(sp)
    80002804:	01010113          	addi	sp,sp,16
    80002808:	00008067          	ret
        return idleProcess;
    8000280c:	00005517          	auipc	a0,0x5
    80002810:	03453503          	ld	a0,52(a0) # 80007840 <_ZN9Scheduler11idleProcessE>
    80002814:	fedff06f          	j	80002800 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002818:	00005797          	auipc	a5,0x5
    8000281c:	00e7bc23          	sd	a4,24(a5) # 80007830 <_ZN9Scheduler4tailE>
    80002820:	fe1ff06f          	j	80002800 <_ZN9Scheduler3getEv+0x30>

0000000080002824 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002824:	ff010113          	addi	sp,sp,-16
    80002828:	00813423          	sd	s0,8(sp)
    8000282c:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002830:	00050e63          	beqz	a0,8000284c <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002834:	00005797          	auipc	a5,0x5
    80002838:	0047b783          	ld	a5,4(a5) # 80007838 <_ZN9Scheduler4headE>
    8000283c:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002840:	00078c63          	beqz	a5,80002858 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002844:	00005797          	auipc	a5,0x5
    80002848:	fea7ba23          	sd	a0,-12(a5) # 80007838 <_ZN9Scheduler4headE>
    }
}
    8000284c:	00813403          	ld	s0,8(sp)
    80002850:	01010113          	addi	sp,sp,16
    80002854:	00008067          	ret
        head = tail = process;
    80002858:	00005797          	auipc	a5,0x5
    8000285c:	fd878793          	addi	a5,a5,-40 # 80007830 <_ZN9Scheduler4tailE>
    80002860:	00a7b023          	sd	a0,0(a5)
    80002864:	00a7b423          	sd	a0,8(a5)
    80002868:	fe5ff06f          	j	8000284c <_ZN9Scheduler10putInFrontEP3PCB+0x28>

000000008000286c <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    8000286c:	ff010113          	addi	sp,sp,-16
    80002870:	00813423          	sd	s0,8(sp)
    80002874:	01010413          	addi	s0,sp,16
    while(true) {}
    80002878:	0000006f          	j	80002878 <idleProcess+0xc>

000000008000287c <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    8000287c:	ff010113          	addi	sp,sp,-16
    80002880:	00113423          	sd	ra,8(sp)
    80002884:	00813023          	sd	s0,0(sp)
    80002888:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    8000288c:	00000097          	auipc	ra,0x0
    80002890:	e2c080e7          	jalr	-468(ra) # 800026b8 <_Z8userMainv>
}
    80002894:	00813083          	ld	ra,8(sp)
    80002898:	00013403          	ld	s0,0(sp)
    8000289c:	01010113          	addi	sp,sp,16
    800028a0:	00008067          	ret

00000000800028a4 <_Z8userModev>:
void userMode() {
    800028a4:	ff010113          	addi	sp,sp,-16
    800028a8:	00813423          	sd	s0,8(sp)
    800028ac:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    800028b0:	04300793          	li	a5,67
    800028b4:	00078513          	mv	a0,a5
    asm volatile("ecall");
    800028b8:	00000073          	ecall
}
    800028bc:	00813403          	ld	s0,8(sp)
    800028c0:	01010113          	addi	sp,sp,16
    800028c4:	00008067          	ret

00000000800028c8 <main>:
}
// ------------

int main() {
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00113423          	sd	ra,8(sp)
    800028d0:	00813023          	sd	s0,0(sp)
    800028d4:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    800028d8:	00005797          	auipc	a5,0x5
    800028dc:	e207b783          	ld	a5,-480(a5) # 800076f8 <_GLOBAL_OFFSET_TABLE_+0x80>
    800028e0:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    800028e4:	00000593          	li	a1,0
    800028e8:	00000513          	li	a0,0
    800028ec:	fffff097          	auipc	ra,0xfffff
    800028f0:	35c080e7          	jalr	860(ra) # 80001c48 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    800028f4:	00005797          	auipc	a5,0x5
    800028f8:	de47b783          	ld	a5,-540(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800028fc:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    80002900:	00000593          	li	a1,0
    80002904:	00005517          	auipc	a0,0x5
    80002908:	dfc53503          	ld	a0,-516(a0) # 80007700 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000290c:	fffff097          	auipc	ra,0xfffff
    80002910:	a44080e7          	jalr	-1468(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    80002914:	00000593          	li	a1,0
    80002918:	00005517          	auipc	a0,0x5
    8000291c:	dd053503          	ld	a0,-560(a0) # 800076e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	a30080e7          	jalr	-1488(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    80002928:	00000593          	li	a1,0
    8000292c:	00005517          	auipc	a0,0x5
    80002930:	dc453503          	ld	a0,-572(a0) # 800076f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002934:	fffff097          	auipc	ra,0xfffff
    80002938:	a1c080e7          	jalr	-1508(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000293c:	00200793          	li	a5,2
    80002940:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002944:	00000613          	li	a2,0
    80002948:	00005597          	auipc	a1,0x5
    8000294c:	d805b583          	ld	a1,-640(a1) # 800076c8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002950:	00005517          	auipc	a0,0x5
    80002954:	dc053503          	ld	a0,-576(a0) # 80007710 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002958:	fffff097          	auipc	ra,0xfffff
    8000295c:	9a8080e7          	jalr	-1624(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002960:	00000613          	li	a2,0
    80002964:	00005597          	auipc	a1,0x5
    80002968:	da45b583          	ld	a1,-604(a1) # 80007708 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000296c:	00005517          	auipc	a0,0x5
    80002970:	d1c53503          	ld	a0,-740(a0) # 80007688 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002974:	fffff097          	auipc	ra,0xfffff
    80002978:	98c080e7          	jalr	-1652(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    8000297c:	00000613          	li	a2,0
    80002980:	00000597          	auipc	a1,0x0
    80002984:	eec58593          	addi	a1,a1,-276 # 8000286c <idleProcess>
    80002988:	00005517          	auipc	a0,0x5
    8000298c:	d4853503          	ld	a0,-696(a0) # 800076d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002990:	fffff097          	auipc	ra,0xfffff
    80002994:	878080e7          	jalr	-1928(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80002998:	00005797          	auipc	a5,0x5
    8000299c:	d387b783          	ld	a5,-712(a5) # 800076d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    800029a0:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    800029a4:	00100713          	li	a4,1
    800029a8:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    800029ac:	00100713          	li	a4,1
    800029b0:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);
    thread_create(&userProcess, userMainWrapper, nullptr);
    800029b4:	00000613          	li	a2,0
    800029b8:	00000597          	auipc	a1,0x0
    800029bc:	ec458593          	addi	a1,a1,-316 # 8000287c <_Z15userMainWrapperPv>
    800029c0:	00005517          	auipc	a0,0x5
    800029c4:	e8850513          	addi	a0,a0,-376 # 80007848 <userProcess>
    800029c8:	fffff097          	auipc	ra,0xfffff
    800029cc:	938080e7          	jalr	-1736(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    800029d0:	00005797          	auipc	a5,0x5
    800029d4:	e787b783          	ld	a5,-392(a5) # 80007848 <userProcess>
        return finished;
    800029d8:	0287c783          	lbu	a5,40(a5)
    800029dc:	00079863          	bnez	a5,800029ec <main+0x124>
        thread_dispatch();
    800029e0:	fffff097          	auipc	ra,0xfffff
    800029e4:	894080e7          	jalr	-1900(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    800029e8:	fe9ff06f          	j	800029d0 <main+0x108>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    800029ec:	00005797          	auipc	a5,0x5
    800029f0:	cfc7b783          	ld	a5,-772(a5) # 800076e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    800029f4:	0007b783          	ld	a5,0(a5)
        return semValue;
    800029f8:	0107a783          	lw	a5,16(a5)
    800029fc:	00078863          	beqz	a5,80002a0c <main+0x144>
        thread_dispatch();
    80002a00:	fffff097          	auipc	ra,0xfffff
    80002a04:	874080e7          	jalr	-1932(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    80002a08:	fe5ff06f          	j	800029ec <main+0x124>
    }
    return 0;
    80002a0c:	00000513          	li	a0,0
    80002a10:	00813083          	ld	ra,8(sp)
    80002a14:	00013403          	ld	s0,0(sp)
    80002a18:	01010113          	addi	sp,sp,16
    80002a1c:	00008067          	ret

0000000080002a20 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002a20:	fe010113          	addi	sp,sp,-32
    80002a24:	00113c23          	sd	ra,24(sp)
    80002a28:	00813823          	sd	s0,16(sp)
    80002a2c:	00913423          	sd	s1,8(sp)
    80002a30:	02010413          	addi	s0,sp,32
    80002a34:	00005797          	auipc	a5,0x5
    80002a38:	c0c78793          	addi	a5,a5,-1012 # 80007640 <_ZTV6Thread+0x10>
    80002a3c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002a40:	00853483          	ld	s1,8(a0)
    80002a44:	00048e63          	beqz	s1,80002a60 <_ZN6ThreadD1Ev+0x40>
    80002a48:	00048513          	mv	a0,s1
    80002a4c:	fffff097          	auipc	ra,0xfffff
    80002a50:	160080e7          	jalr	352(ra) # 80001bac <_ZN3PCBD1Ev>
    80002a54:	00048513          	mv	a0,s1
    80002a58:	fffff097          	auipc	ra,0xfffff
    80002a5c:	1c8080e7          	jalr	456(ra) # 80001c20 <_ZN3PCBdlEPv>
}
    80002a60:	01813083          	ld	ra,24(sp)
    80002a64:	01013403          	ld	s0,16(sp)
    80002a68:	00813483          	ld	s1,8(sp)
    80002a6c:	02010113          	addi	sp,sp,32
    80002a70:	00008067          	ret

0000000080002a74 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002a74:	ff010113          	addi	sp,sp,-16
    80002a78:	00113423          	sd	ra,8(sp)
    80002a7c:	00813023          	sd	s0,0(sp)
    80002a80:	01010413          	addi	s0,sp,16
    80002a84:	00005797          	auipc	a5,0x5
    80002a88:	be478793          	addi	a5,a5,-1052 # 80007668 <_ZTV9Semaphore+0x10>
    80002a8c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002a90:	00853503          	ld	a0,8(a0)
    80002a94:	fffff097          	auipc	ra,0xfffff
    80002a98:	98c080e7          	jalr	-1652(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80002a9c:	00813083          	ld	ra,8(sp)
    80002aa0:	00013403          	ld	s0,0(sp)
    80002aa4:	01010113          	addi	sp,sp,16
    80002aa8:	00008067          	ret

0000000080002aac <_Znwm>:
void* operator new (size_t size) {
    80002aac:	ff010113          	addi	sp,sp,-16
    80002ab0:	00113423          	sd	ra,8(sp)
    80002ab4:	00813023          	sd	s0,0(sp)
    80002ab8:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002abc:	ffffe097          	auipc	ra,0xffffe
    80002ac0:	6d8080e7          	jalr	1752(ra) # 80001194 <_Z9mem_allocm>
}
    80002ac4:	00813083          	ld	ra,8(sp)
    80002ac8:	00013403          	ld	s0,0(sp)
    80002acc:	01010113          	addi	sp,sp,16
    80002ad0:	00008067          	ret

0000000080002ad4 <_Znam>:
void* operator new [](size_t size) {
    80002ad4:	ff010113          	addi	sp,sp,-16
    80002ad8:	00113423          	sd	ra,8(sp)
    80002adc:	00813023          	sd	s0,0(sp)
    80002ae0:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002ae4:	ffffe097          	auipc	ra,0xffffe
    80002ae8:	6b0080e7          	jalr	1712(ra) # 80001194 <_Z9mem_allocm>
}
    80002aec:	00813083          	ld	ra,8(sp)
    80002af0:	00013403          	ld	s0,0(sp)
    80002af4:	01010113          	addi	sp,sp,16
    80002af8:	00008067          	ret

0000000080002afc <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002afc:	ff010113          	addi	sp,sp,-16
    80002b00:	00113423          	sd	ra,8(sp)
    80002b04:	00813023          	sd	s0,0(sp)
    80002b08:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002b0c:	ffffe097          	auipc	ra,0xffffe
    80002b10:	6c8080e7          	jalr	1736(ra) # 800011d4 <_Z8mem_freePv>
}
    80002b14:	00813083          	ld	ra,8(sp)
    80002b18:	00013403          	ld	s0,0(sp)
    80002b1c:	01010113          	addi	sp,sp,16
    80002b20:	00008067          	ret

0000000080002b24 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002b24:	fe010113          	addi	sp,sp,-32
    80002b28:	00113c23          	sd	ra,24(sp)
    80002b2c:	00813823          	sd	s0,16(sp)
    80002b30:	00913423          	sd	s1,8(sp)
    80002b34:	02010413          	addi	s0,sp,32
    80002b38:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002b3c:	00053503          	ld	a0,0(a0)
    80002b40:	0104b783          	ld	a5,16(s1)
    80002b44:	00f50533          	add	a0,a0,a5
    80002b48:	0084b783          	ld	a5,8(s1)
    80002b4c:	0017f713          	andi	a4,a5,1
    80002b50:	00070863          	beqz	a4,80002b60 <_Z13threadWrapperPv+0x3c>
    80002b54:	00053703          	ld	a4,0(a0)
    80002b58:	00f707b3          	add	a5,a4,a5
    80002b5c:	fff7b783          	ld	a5,-1(a5)
    80002b60:	000780e7          	jalr	a5
    delete tArg;
    80002b64:	00048863          	beqz	s1,80002b74 <_Z13threadWrapperPv+0x50>
    80002b68:	00048513          	mv	a0,s1
    80002b6c:	00000097          	auipc	ra,0x0
    80002b70:	f90080e7          	jalr	-112(ra) # 80002afc <_ZdlPv>
}
    80002b74:	01813083          	ld	ra,24(sp)
    80002b78:	01013403          	ld	s0,16(sp)
    80002b7c:	00813483          	ld	s1,8(sp)
    80002b80:	02010113          	addi	sp,sp,32
    80002b84:	00008067          	ret

0000000080002b88 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002b88:	ff010113          	addi	sp,sp,-16
    80002b8c:	00113423          	sd	ra,8(sp)
    80002b90:	00813023          	sd	s0,0(sp)
    80002b94:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002b98:	ffffe097          	auipc	ra,0xffffe
    80002b9c:	63c080e7          	jalr	1596(ra) # 800011d4 <_Z8mem_freePv>
}
    80002ba0:	00813083          	ld	ra,8(sp)
    80002ba4:	00013403          	ld	s0,0(sp)
    80002ba8:	01010113          	addi	sp,sp,16
    80002bac:	00008067          	ret

0000000080002bb0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002bb0:	ff010113          	addi	sp,sp,-16
    80002bb4:	00113423          	sd	ra,8(sp)
    80002bb8:	00813023          	sd	s0,0(sp)
    80002bbc:	01010413          	addi	s0,sp,16
    80002bc0:	00005797          	auipc	a5,0x5
    80002bc4:	a8078793          	addi	a5,a5,-1408 # 80007640 <_ZTV6Thread+0x10>
    80002bc8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002bcc:	00850513          	addi	a0,a0,8
    80002bd0:	ffffe097          	auipc	ra,0xffffe
    80002bd4:	638080e7          	jalr	1592(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002bd8:	00813083          	ld	ra,8(sp)
    80002bdc:	00013403          	ld	s0,0(sp)
    80002be0:	01010113          	addi	sp,sp,16
    80002be4:	00008067          	ret

0000000080002be8 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002be8:	ff010113          	addi	sp,sp,-16
    80002bec:	00113423          	sd	ra,8(sp)
    80002bf0:	00813023          	sd	s0,0(sp)
    80002bf4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002bf8:	00000097          	auipc	ra,0x0
    80002bfc:	718080e7          	jalr	1816(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002c00:	00813083          	ld	ra,8(sp)
    80002c04:	00013403          	ld	s0,0(sp)
    80002c08:	01010113          	addi	sp,sp,16
    80002c0c:	00008067          	ret

0000000080002c10 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002c10:	ff010113          	addi	sp,sp,-16
    80002c14:	00113423          	sd	ra,8(sp)
    80002c18:	00813023          	sd	s0,0(sp)
    80002c1c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002c20:	00001097          	auipc	ra,0x1
    80002c24:	860080e7          	jalr	-1952(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002c28:	00813083          	ld	ra,8(sp)
    80002c2c:	00013403          	ld	s0,0(sp)
    80002c30:	01010113          	addi	sp,sp,16
    80002c34:	00008067          	ret

0000000080002c38 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002c38:	fe010113          	addi	sp,sp,-32
    80002c3c:	00113c23          	sd	ra,24(sp)
    80002c40:	00813823          	sd	s0,16(sp)
    80002c44:	00913423          	sd	s1,8(sp)
    80002c48:	02010413          	addi	s0,sp,32
    80002c4c:	00050493          	mv	s1,a0
}
    80002c50:	00000097          	auipc	ra,0x0
    80002c54:	dd0080e7          	jalr	-560(ra) # 80002a20 <_ZN6ThreadD1Ev>
    80002c58:	00048513          	mv	a0,s1
    80002c5c:	00000097          	auipc	ra,0x0
    80002c60:	fb4080e7          	jalr	-76(ra) # 80002c10 <_ZN6ThreaddlEPv>
    80002c64:	01813083          	ld	ra,24(sp)
    80002c68:	01013403          	ld	s0,16(sp)
    80002c6c:	00813483          	ld	s1,8(sp)
    80002c70:	02010113          	addi	sp,sp,32
    80002c74:	00008067          	ret

0000000080002c78 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002c78:	ff010113          	addi	sp,sp,-16
    80002c7c:	00113423          	sd	ra,8(sp)
    80002c80:	00813023          	sd	s0,0(sp)
    80002c84:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002c88:	ffffe097          	auipc	ra,0xffffe
    80002c8c:	5ec080e7          	jalr	1516(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002c90:	00813083          	ld	ra,8(sp)
    80002c94:	00013403          	ld	s0,0(sp)
    80002c98:	01010113          	addi	sp,sp,16
    80002c9c:	00008067          	ret

0000000080002ca0 <_ZN6Thread5startEv>:
int Thread::start() {
    80002ca0:	ff010113          	addi	sp,sp,-16
    80002ca4:	00113423          	sd	ra,8(sp)
    80002ca8:	00813023          	sd	s0,0(sp)
    80002cac:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002cb0:	00850513          	addi	a0,a0,8
    80002cb4:	ffffe097          	auipc	ra,0xffffe
    80002cb8:	61c080e7          	jalr	1564(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002cbc:	00000513          	li	a0,0
    80002cc0:	00813083          	ld	ra,8(sp)
    80002cc4:	00013403          	ld	s0,0(sp)
    80002cc8:	01010113          	addi	sp,sp,16
    80002ccc:	00008067          	ret

0000000080002cd0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002cd0:	fe010113          	addi	sp,sp,-32
    80002cd4:	00113c23          	sd	ra,24(sp)
    80002cd8:	00813823          	sd	s0,16(sp)
    80002cdc:	00913423          	sd	s1,8(sp)
    80002ce0:	02010413          	addi	s0,sp,32
    80002ce4:	00050493          	mv	s1,a0
    80002ce8:	00005797          	auipc	a5,0x5
    80002cec:	95878793          	addi	a5,a5,-1704 # 80007640 <_ZTV6Thread+0x10>
    80002cf0:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002cf4:	01800513          	li	a0,24
    80002cf8:	00000097          	auipc	ra,0x0
    80002cfc:	db4080e7          	jalr	-588(ra) # 80002aac <_Znwm>
    80002d00:	00050613          	mv	a2,a0
    80002d04:	00953023          	sd	s1,0(a0)
    80002d08:	01100793          	li	a5,17
    80002d0c:	00f53423          	sd	a5,8(a0)
    80002d10:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002d14:	00000597          	auipc	a1,0x0
    80002d18:	e1058593          	addi	a1,a1,-496 # 80002b24 <_Z13threadWrapperPv>
    80002d1c:	00848513          	addi	a0,s1,8
    80002d20:	ffffe097          	auipc	ra,0xffffe
    80002d24:	4e8080e7          	jalr	1256(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002d28:	01813083          	ld	ra,24(sp)
    80002d2c:	01013403          	ld	s0,16(sp)
    80002d30:	00813483          	ld	s1,8(sp)
    80002d34:	02010113          	addi	sp,sp,32
    80002d38:	00008067          	ret

0000000080002d3c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002d3c:	ff010113          	addi	sp,sp,-16
    80002d40:	00113423          	sd	ra,8(sp)
    80002d44:	00813023          	sd	s0,0(sp)
    80002d48:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002d4c:	ffffe097          	auipc	ra,0xffffe
    80002d50:	714080e7          	jalr	1812(ra) # 80001460 <_Z10time_sleepm>
}
    80002d54:	00813083          	ld	ra,8(sp)
    80002d58:	00013403          	ld	s0,0(sp)
    80002d5c:	01010113          	addi	sp,sp,16
    80002d60:	00008067          	ret

0000000080002d64 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002d64:	fe010113          	addi	sp,sp,-32
    80002d68:	00113c23          	sd	ra,24(sp)
    80002d6c:	00813823          	sd	s0,16(sp)
    80002d70:	00913423          	sd	s1,8(sp)
    80002d74:	02010413          	addi	s0,sp,32
    80002d78:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002d7c:	0200006f          	j	80002d9c <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002d80:	00053703          	ld	a4,0(a0)
    80002d84:	00f707b3          	add	a5,a4,a5
    80002d88:	fff7b783          	ld	a5,-1(a5)
    80002d8c:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002d90:	0184b503          	ld	a0,24(s1)
    80002d94:	00000097          	auipc	ra,0x0
    80002d98:	fa8080e7          	jalr	-88(ra) # 80002d3c <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002d9c:	0004b503          	ld	a0,0(s1)
    80002da0:	0104b783          	ld	a5,16(s1)
    80002da4:	00f50533          	add	a0,a0,a5
    80002da8:	0084b783          	ld	a5,8(s1)
    80002dac:	0017f713          	andi	a4,a5,1
    80002db0:	fc070ee3          	beqz	a4,80002d8c <_Z21periodicThreadWrapperPv+0x28>
    80002db4:	fcdff06f          	j	80002d80 <_Z21periodicThreadWrapperPv+0x1c>

0000000080002db8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002db8:	fe010113          	addi	sp,sp,-32
    80002dbc:	00113c23          	sd	ra,24(sp)
    80002dc0:	00813823          	sd	s0,16(sp)
    80002dc4:	00913423          	sd	s1,8(sp)
    80002dc8:	01213023          	sd	s2,0(sp)
    80002dcc:	02010413          	addi	s0,sp,32
    80002dd0:	00050493          	mv	s1,a0
    80002dd4:	00005797          	auipc	a5,0x5
    80002dd8:	89478793          	addi	a5,a5,-1900 # 80007668 <_ZTV9Semaphore+0x10>
    80002ddc:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002de0:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002de4:	01800513          	li	a0,24
    80002de8:	00000097          	auipc	ra,0x0
    80002dec:	474080e7          	jalr	1140(ra) # 8000325c <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002df0:	00053023          	sd	zero,0(a0)
    80002df4:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80002df8:	01252823          	sw	s2,16(a0)
    80002dfc:	00a4b423          	sd	a0,8(s1)
}
    80002e00:	01813083          	ld	ra,24(sp)
    80002e04:	01013403          	ld	s0,16(sp)
    80002e08:	00813483          	ld	s1,8(sp)
    80002e0c:	00013903          	ld	s2,0(sp)
    80002e10:	02010113          	addi	sp,sp,32
    80002e14:	00008067          	ret

0000000080002e18 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002e18:	ff010113          	addi	sp,sp,-16
    80002e1c:	00113423          	sd	ra,8(sp)
    80002e20:	00813023          	sd	s0,0(sp)
    80002e24:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002e28:	00853503          	ld	a0,8(a0)
    80002e2c:	ffffe097          	auipc	ra,0xffffe
    80002e30:	56c080e7          	jalr	1388(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80002e34:	00813083          	ld	ra,8(sp)
    80002e38:	00013403          	ld	s0,0(sp)
    80002e3c:	01010113          	addi	sp,sp,16
    80002e40:	00008067          	ret

0000000080002e44 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002e44:	ff010113          	addi	sp,sp,-16
    80002e48:	00113423          	sd	ra,8(sp)
    80002e4c:	00813023          	sd	s0,0(sp)
    80002e50:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002e54:	00853503          	ld	a0,8(a0)
    80002e58:	ffffe097          	auipc	ra,0xffffe
    80002e5c:	588080e7          	jalr	1416(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80002e60:	00813083          	ld	ra,8(sp)
    80002e64:	00013403          	ld	s0,0(sp)
    80002e68:	01010113          	addi	sp,sp,16
    80002e6c:	00008067          	ret

0000000080002e70 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002e70:	ff010113          	addi	sp,sp,-16
    80002e74:	00113423          	sd	ra,8(sp)
    80002e78:	00813023          	sd	s0,0(sp)
    80002e7c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	600080e7          	jalr	1536(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002e88:	00813083          	ld	ra,8(sp)
    80002e8c:	00013403          	ld	s0,0(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret

0000000080002e98 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002e98:	fe010113          	addi	sp,sp,-32
    80002e9c:	00113c23          	sd	ra,24(sp)
    80002ea0:	00813823          	sd	s0,16(sp)
    80002ea4:	00913423          	sd	s1,8(sp)
    80002ea8:	02010413          	addi	s0,sp,32
    80002eac:	00050493          	mv	s1,a0
}
    80002eb0:	00000097          	auipc	ra,0x0
    80002eb4:	bc4080e7          	jalr	-1084(ra) # 80002a74 <_ZN9SemaphoreD1Ev>
    80002eb8:	00048513          	mv	a0,s1
    80002ebc:	00000097          	auipc	ra,0x0
    80002ec0:	fb4080e7          	jalr	-76(ra) # 80002e70 <_ZN9SemaphoredlEPv>
    80002ec4:	01813083          	ld	ra,24(sp)
    80002ec8:	01013403          	ld	s0,16(sp)
    80002ecc:	00813483          	ld	s1,8(sp)
    80002ed0:	02010113          	addi	sp,sp,32
    80002ed4:	00008067          	ret

0000000080002ed8 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002ed8:	ff010113          	addi	sp,sp,-16
    80002edc:	00113423          	sd	ra,8(sp)
    80002ee0:	00813023          	sd	s0,0(sp)
    80002ee4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	428080e7          	jalr	1064(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002ef0:	00813083          	ld	ra,8(sp)
    80002ef4:	00013403          	ld	s0,0(sp)
    80002ef8:	01010113          	addi	sp,sp,16
    80002efc:	00008067          	ret

0000000080002f00 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80002f00:	fe010113          	addi	sp,sp,-32
    80002f04:	00113c23          	sd	ra,24(sp)
    80002f08:	00813823          	sd	s0,16(sp)
    80002f0c:	00913423          	sd	s1,8(sp)
    80002f10:	01213023          	sd	s2,0(sp)
    80002f14:	02010413          	addi	s0,sp,32
    80002f18:	00050493          	mv	s1,a0
    80002f1c:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002f20:	02000513          	li	a0,32
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	b88080e7          	jalr	-1144(ra) # 80002aac <_Znwm>
    80002f2c:	00050613          	mv	a2,a0
    80002f30:	00953023          	sd	s1,0(a0)
    80002f34:	01900793          	li	a5,25
    80002f38:	00f53423          	sd	a5,8(a0)
    80002f3c:	00053823          	sd	zero,16(a0)
    80002f40:	01253c23          	sd	s2,24(a0)
    80002f44:	00000597          	auipc	a1,0x0
    80002f48:	e2058593          	addi	a1,a1,-480 # 80002d64 <_Z21periodicThreadWrapperPv>
    80002f4c:	00048513          	mv	a0,s1
    80002f50:	00000097          	auipc	ra,0x0
    80002f54:	c60080e7          	jalr	-928(ra) # 80002bb0 <_ZN6ThreadC1EPFvPvES0_>
    80002f58:	00004797          	auipc	a5,0x4
    80002f5c:	6b878793          	addi	a5,a5,1720 # 80007610 <_ZTV14PeriodicThread+0x10>
    80002f60:	00f4b023          	sd	a5,0(s1)
{}
    80002f64:	01813083          	ld	ra,24(sp)
    80002f68:	01013403          	ld	s0,16(sp)
    80002f6c:	00813483          	ld	s1,8(sp)
    80002f70:	00013903          	ld	s2,0(sp)
    80002f74:	02010113          	addi	sp,sp,32
    80002f78:	00008067          	ret

0000000080002f7c <_ZN7Console4getcEv>:


char Console::getc() {
    80002f7c:	ff010113          	addi	sp,sp,-16
    80002f80:	00113423          	sd	ra,8(sp)
    80002f84:	00813023          	sd	s0,0(sp)
    80002f88:	01010413          	addi	s0,sp,16
    return ::getc();
    80002f8c:	ffffe097          	auipc	ra,0xffffe
    80002f90:	51c080e7          	jalr	1308(ra) # 800014a8 <_Z4getcv>
}
    80002f94:	00813083          	ld	ra,8(sp)
    80002f98:	00013403          	ld	s0,0(sp)
    80002f9c:	01010113          	addi	sp,sp,16
    80002fa0:	00008067          	ret

0000000080002fa4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002fa4:	ff010113          	addi	sp,sp,-16
    80002fa8:	00113423          	sd	ra,8(sp)
    80002fac:	00813023          	sd	s0,0(sp)
    80002fb0:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002fb4:	ffffe097          	auipc	ra,0xffffe
    80002fb8:	524080e7          	jalr	1316(ra) # 800014d8 <_Z4putcc>
}
    80002fbc:	00813083          	ld	ra,8(sp)
    80002fc0:	00013403          	ld	s0,0(sp)
    80002fc4:	01010113          	addi	sp,sp,16
    80002fc8:	00008067          	ret

0000000080002fcc <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002fcc:	ff010113          	addi	sp,sp,-16
    80002fd0:	00813423          	sd	s0,8(sp)
    80002fd4:	01010413          	addi	s0,sp,16
    80002fd8:	00813403          	ld	s0,8(sp)
    80002fdc:	01010113          	addi	sp,sp,16
    80002fe0:	00008067          	ret

0000000080002fe4 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002fe4:	ff010113          	addi	sp,sp,-16
    80002fe8:	00813423          	sd	s0,8(sp)
    80002fec:	01010413          	addi	s0,sp,16
    80002ff0:	00813403          	ld	s0,8(sp)
    80002ff4:	01010113          	addi	sp,sp,16
    80002ff8:	00008067          	ret

0000000080002ffc <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80002ffc:	ff010113          	addi	sp,sp,-16
    80003000:	00113423          	sd	ra,8(sp)
    80003004:	00813023          	sd	s0,0(sp)
    80003008:	01010413          	addi	s0,sp,16
    8000300c:	00004797          	auipc	a5,0x4
    80003010:	60478793          	addi	a5,a5,1540 # 80007610 <_ZTV14PeriodicThread+0x10>
    80003014:	00f53023          	sd	a5,0(a0)
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	a08080e7          	jalr	-1528(ra) # 80002a20 <_ZN6ThreadD1Ev>
    80003020:	00813083          	ld	ra,8(sp)
    80003024:	00013403          	ld	s0,0(sp)
    80003028:	01010113          	addi	sp,sp,16
    8000302c:	00008067          	ret

0000000080003030 <_ZN14PeriodicThreadD0Ev>:
    80003030:	fe010113          	addi	sp,sp,-32
    80003034:	00113c23          	sd	ra,24(sp)
    80003038:	00813823          	sd	s0,16(sp)
    8000303c:	00913423          	sd	s1,8(sp)
    80003040:	02010413          	addi	s0,sp,32
    80003044:	00050493          	mv	s1,a0
    80003048:	00004797          	auipc	a5,0x4
    8000304c:	5c878793          	addi	a5,a5,1480 # 80007610 <_ZTV14PeriodicThread+0x10>
    80003050:	00f53023          	sd	a5,0(a0)
    80003054:	00000097          	auipc	ra,0x0
    80003058:	9cc080e7          	jalr	-1588(ra) # 80002a20 <_ZN6ThreadD1Ev>
    8000305c:	00048513          	mv	a0,s1
    80003060:	00000097          	auipc	ra,0x0
    80003064:	bb0080e7          	jalr	-1104(ra) # 80002c10 <_ZN6ThreaddlEPv>
    80003068:	01813083          	ld	ra,24(sp)
    8000306c:	01013403          	ld	s0,16(sp)
    80003070:	00813483          	ld	s1,8(sp)
    80003074:	02010113          	addi	sp,sp,32
    80003078:	00008067          	ret

000000008000307c <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    8000307c:	ff010113          	addi	sp,sp,-16
    80003080:	00813423          	sd	s0,8(sp)
    80003084:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80003088:	00004797          	auipc	a5,0x4
    8000308c:	6507b783          	ld	a5,1616(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003090:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80003094:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80003098:	00853783          	ld	a5,8(a0)
    8000309c:	04078063          	beqz	a5,800030dc <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    800030a0:	00004717          	auipc	a4,0x4
    800030a4:	63873703          	ld	a4,1592(a4) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800030a8:	00073703          	ld	a4,0(a4)
    800030ac:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    800030b0:	00853783          	ld	a5,8(a0)
        return nextInList;
    800030b4:	0007b783          	ld	a5,0(a5)
    800030b8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    800030bc:	00004797          	auipc	a5,0x4
    800030c0:	61c7b783          	ld	a5,1564(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800030c4:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    800030c8:	00100713          	li	a4,1
    800030cc:	02e784a3          	sb	a4,41(a5)
}
    800030d0:	00813403          	ld	s0,8(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret
        head = tail = PCB::running;
    800030dc:	00004797          	auipc	a5,0x4
    800030e0:	5fc7b783          	ld	a5,1532(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800030e4:	0007b783          	ld	a5,0(a5)
    800030e8:	00f53423          	sd	a5,8(a0)
    800030ec:	00f53023          	sd	a5,0(a0)
    800030f0:	fcdff06f          	j	800030bc <_ZN3SCB5blockEv+0x40>

00000000800030f4 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800030f4:	ff010113          	addi	sp,sp,-16
    800030f8:	00813423          	sd	s0,8(sp)
    800030fc:	01010413          	addi	s0,sp,16
    80003100:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80003104:	00053503          	ld	a0,0(a0)
    80003108:	00050e63          	beqz	a0,80003124 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    8000310c:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80003110:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80003114:	0087b683          	ld	a3,8(a5)
    80003118:	00d50c63          	beq	a0,a3,80003130 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    8000311c:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80003120:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80003124:	00813403          	ld	s0,8(sp)
    80003128:	01010113          	addi	sp,sp,16
    8000312c:	00008067          	ret
        tail = head;
    80003130:	00e7b423          	sd	a4,8(a5)
    80003134:	fe9ff06f          	j	8000311c <_ZN3SCB7unblockEv+0x28>

0000000080003138 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003138:	01052783          	lw	a5,16(a0)
    8000313c:	fff7879b          	addiw	a5,a5,-1
    80003140:	00f52823          	sw	a5,16(a0)
    80003144:	02079713          	slli	a4,a5,0x20
    80003148:	02074063          	bltz	a4,80003168 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000314c:	00004797          	auipc	a5,0x4
    80003150:	58c7b783          	ld	a5,1420(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003154:	0007b783          	ld	a5,0(a5)
    80003158:	02a7c783          	lbu	a5,42(a5)
    8000315c:	06079463          	bnez	a5,800031c4 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003160:	00000513          	li	a0,0
    80003164:	00008067          	ret
int SCB::wait() {
    80003168:	ff010113          	addi	sp,sp,-16
    8000316c:	00113423          	sd	ra,8(sp)
    80003170:	00813023          	sd	s0,0(sp)
    80003174:	01010413          	addi	s0,sp,16
        block();
    80003178:	00000097          	auipc	ra,0x0
    8000317c:	f04080e7          	jalr	-252(ra) # 8000307c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80003180:	00004797          	auipc	a5,0x4
    80003184:	5387b783          	ld	a5,1336(a5) # 800076b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003188:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    8000318c:	fffff097          	auipc	ra,0xfffff
    80003190:	8e4080e7          	jalr	-1820(ra) # 80001a70 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80003194:	00004797          	auipc	a5,0x4
    80003198:	5447b783          	ld	a5,1348(a5) # 800076d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000319c:	0007b783          	ld	a5,0(a5)
    800031a0:	02a7c783          	lbu	a5,42(a5)
    800031a4:	00079c63          	bnez	a5,800031bc <_ZN3SCB4waitEv+0x84>
    return 0;
    800031a8:	00000513          	li	a0,0

}
    800031ac:	00813083          	ld	ra,8(sp)
    800031b0:	00013403          	ld	s0,0(sp)
    800031b4:	01010113          	addi	sp,sp,16
    800031b8:	00008067          	ret
        return -2;
    800031bc:	ffe00513          	li	a0,-2
    800031c0:	fedff06f          	j	800031ac <_ZN3SCB4waitEv+0x74>
    800031c4:	ffe00513          	li	a0,-2
}
    800031c8:	00008067          	ret

00000000800031cc <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    800031cc:	01052783          	lw	a5,16(a0)
    800031d0:	0017879b          	addiw	a5,a5,1
    800031d4:	0007871b          	sext.w	a4,a5
    800031d8:	00f52823          	sw	a5,16(a0)
    800031dc:	00e05463          	blez	a4,800031e4 <_ZN3SCB6signalEv+0x18>
    800031e0:	00008067          	ret
void SCB::signal() {
    800031e4:	ff010113          	addi	sp,sp,-16
    800031e8:	00113423          	sd	ra,8(sp)
    800031ec:	00813023          	sd	s0,0(sp)
    800031f0:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800031f4:	00000097          	auipc	ra,0x0
    800031f8:	f00080e7          	jalr	-256(ra) # 800030f4 <_ZN3SCB7unblockEv>
    800031fc:	fffff097          	auipc	ra,0xfffff
    80003200:	57c080e7          	jalr	1404(ra) # 80002778 <_ZN9Scheduler3putEP3PCB>
    }

}
    80003204:	00813083          	ld	ra,8(sp)
    80003208:	00013403          	ld	s0,0(sp)
    8000320c:	01010113          	addi	sp,sp,16
    80003210:	00008067          	ret

0000000080003214 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    80003214:	01052783          	lw	a5,16(a0)
    80003218:	0017879b          	addiw	a5,a5,1
    8000321c:	0007871b          	sext.w	a4,a5
    80003220:	00f52823          	sw	a5,16(a0)
    80003224:	00e05463          	blez	a4,8000322c <_ZN3SCB14prioritySignalEv+0x18>
    80003228:	00008067          	ret
void SCB::prioritySignal() {
    8000322c:	ff010113          	addi	sp,sp,-16
    80003230:	00113423          	sd	ra,8(sp)
    80003234:	00813023          	sd	s0,0(sp)
    80003238:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000323c:	00000097          	auipc	ra,0x0
    80003240:	eb8080e7          	jalr	-328(ra) # 800030f4 <_ZN3SCB7unblockEv>
    80003244:	fffff097          	auipc	ra,0xfffff
    80003248:	5e0080e7          	jalr	1504(ra) # 80002824 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000324c:	00813083          	ld	ra,8(sp)
    80003250:	00013403          	ld	s0,0(sp)
    80003254:	01010113          	addi	sp,sp,16
    80003258:	00008067          	ret

000000008000325c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000325c:	ff010113          	addi	sp,sp,-16
    80003260:	00113423          	sd	ra,8(sp)
    80003264:	00813023          	sd	s0,0(sp)
    80003268:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000326c:	00000097          	auipc	ra,0x0
    80003270:	0a4080e7          	jalr	164(ra) # 80003310 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003274:	00813083          	ld	ra,8(sp)
    80003278:	00013403          	ld	s0,0(sp)
    8000327c:	01010113          	addi	sp,sp,16
    80003280:	00008067          	ret

0000000080003284 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80003284:	ff010113          	addi	sp,sp,-16
    80003288:	00113423          	sd	ra,8(sp)
    8000328c:	00813023          	sd	s0,0(sp)
    80003290:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003294:	00000097          	auipc	ra,0x0
    80003298:	1ec080e7          	jalr	492(ra) # 80003480 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000329c:	00813083          	ld	ra,8(sp)
    800032a0:	00013403          	ld	s0,0(sp)
    800032a4:	01010113          	addi	sp,sp,16
    800032a8:	00008067          	ret

00000000800032ac <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800032ac:	fe010113          	addi	sp,sp,-32
    800032b0:	00113c23          	sd	ra,24(sp)
    800032b4:	00813823          	sd	s0,16(sp)
    800032b8:	00913423          	sd	s1,8(sp)
    800032bc:	01213023          	sd	s2,0(sp)
    800032c0:	02010413          	addi	s0,sp,32
    800032c4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800032c8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800032cc:	02050263          	beqz	a0,800032f0 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800032d0:	00100793          	li	a5,1
    800032d4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800032d8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800032dc:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800032e0:	fffff097          	auipc	ra,0xfffff
    800032e4:	498080e7          	jalr	1176(ra) # 80002778 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800032e8:	00048513          	mv	a0,s1
    while(curr) {
    800032ec:	fe1ff06f          	j	800032cc <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    800032f0:	00093423          	sd	zero,8(s2)
    800032f4:	00093023          	sd	zero,0(s2)
}
    800032f8:	01813083          	ld	ra,24(sp)
    800032fc:	01013403          	ld	s0,16(sp)
    80003300:	00813483          	ld	s1,8(sp)
    80003304:	00013903          	ld	s2,0(sp)
    80003308:	02010113          	addi	sp,sp,32
    8000330c:	00008067          	ret

0000000080003310 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;
void *MemoryAllocator::mem_alloc(size_t size) {
    80003310:	ff010113          	addi	sp,sp,-16
    80003314:	00813423          	sd	s0,8(sp)
    80003318:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000331c:	00004797          	auipc	a5,0x4
    80003320:	5347b783          	ld	a5,1332(a5) # 80007850 <_ZN15MemoryAllocator4headE>
    80003324:	02078c63          	beqz	a5,8000335c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
    static inline void* userHeapStartAddr() {
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    }

    static inline void* userHeapEndAddr() {
        return (void*)HEAP_END_ADDR;
    80003328:	00004717          	auipc	a4,0x4
    8000332c:	3b873703          	ld	a4,952(a4) # 800076e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003330:	00073703          	ld	a4,0(a4)
        head = (FreeSegment*)userHeapStartAddr();
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    80003334:	14e78263          	beq	a5,a4,80003478 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80003338:	00850713          	addi	a4,a0,8
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    8000333c:	00675813          	srli	a6,a4,0x6
    80003340:	03f77793          	andi	a5,a4,63
    80003344:	00f037b3          	snez	a5,a5
    80003348:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000334c:	00004517          	auipc	a0,0x4
    80003350:	50453503          	ld	a0,1284(a0) # 80007850 <_ZN15MemoryAllocator4headE>
    80003354:	00000613          	li	a2,0
    80003358:	0b40006f          	j	8000340c <_ZN15MemoryAllocator9mem_allocEm+0xfc>
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    8000335c:	00004797          	auipc	a5,0x4
    80003360:	33c7b783          	ld	a5,828(a5) # 80007698 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003364:	0007b703          	ld	a4,0(a5)
    80003368:	010007b7          	lui	a5,0x1000
    8000336c:	00f707b3          	add	a5,a4,a5
        head = (FreeSegment*)userHeapStartAddr();
    80003370:	00004697          	auipc	a3,0x4
    80003374:	4ef6b023          	sd	a5,1248(a3) # 80007850 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
    80003378:	020006b7          	lui	a3,0x2000
    8000337c:	00d70733          	add	a4,a4,a3
    80003380:	00e7b023          	sd	a4,0(a5) # 1000000 <_entry-0x7f000000>
        return (void*)HEAP_END_ADDR;
    80003384:	00004717          	auipc	a4,0x4
    80003388:	35c73703          	ld	a4,860(a4) # 800076e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000338c:	00073703          	ld	a4,0(a4)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    80003390:	40f70733          	sub	a4,a4,a5
    80003394:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80003398:	0007b823          	sd	zero,16(a5)
    8000339c:	f9dff06f          	j	80003338 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800033a0:	00060e63          	beqz	a2,800033bc <_ZN15MemoryAllocator9mem_allocEm+0xac>
            if(!prev->next) return;
    800033a4:	01063703          	ld	a4,16(a2)
    800033a8:	04070a63          	beqz	a4,800033fc <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    800033ac:	01073703          	ld	a4,16(a4)
    800033b0:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800033b4:	00078813          	mv	a6,a5
    800033b8:	0ac0006f          	j	80003464 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800033bc:	01053703          	ld	a4,16(a0)
    800033c0:	00070a63          	beqz	a4,800033d4 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
                        head = (FreeSegment*)userHeapEndAddr();
                    }
                    else {
                        head = curr->next;
    800033c4:	00004697          	auipc	a3,0x4
    800033c8:	48e6b623          	sd	a4,1164(a3) # 80007850 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800033cc:	00078813          	mv	a6,a5
    800033d0:	0940006f          	j	80003464 <_ZN15MemoryAllocator9mem_allocEm+0x154>
        return (void*)HEAP_END_ADDR;
    800033d4:	00004717          	auipc	a4,0x4
    800033d8:	30c73703          	ld	a4,780(a4) # 800076e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033dc:	00073703          	ld	a4,0(a4)
                        head = (FreeSegment*)userHeapEndAddr();
    800033e0:	00004697          	auipc	a3,0x4
    800033e4:	46e6b823          	sd	a4,1136(a3) # 80007850 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800033e8:	00078813          	mv	a6,a5
    800033ec:	0780006f          	j	80003464 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    800033f0:	00004797          	auipc	a5,0x4
    800033f4:	46e7b023          	sd	a4,1120(a5) # 80007850 <_ZN15MemoryAllocator4headE>
    800033f8:	06c0006f          	j	80003464 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    800033fc:	00078813          	mv	a6,a5
    80003400:	0640006f          	j	80003464 <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80003404:	00050613          	mv	a2,a0
        curr = curr->next;
    80003408:	01053503          	ld	a0,16(a0)
    while(curr) {
    8000340c:	06050063          	beqz	a0,8000346c <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80003410:	00853783          	ld	a5,8(a0)
    80003414:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80003418:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000341c:	fee7e4e3          	bltu	a5,a4,80003404 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
    80003420:	ff06e2e3          	bltu	a3,a6,80003404 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80003424:	f7068ee3          	beq	a3,a6,800033a0 <_ZN15MemoryAllocator9mem_allocEm+0x90>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80003428:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000342c:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80003430:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80003434:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80003438:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    8000343c:	01053783          	ld	a5,16(a0)
    80003440:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80003444:	fa0606e3          	beqz	a2,800033f0 <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            if(!prev->next) return;
    80003448:	01063783          	ld	a5,16(a2)
    8000344c:	00078663          	beqz	a5,80003458 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    80003450:	0107b783          	ld	a5,16(a5)
    80003454:	00f63823          	sd	a5,16(a2)
            curr->next = prev->next;
    80003458:	01063783          	ld	a5,16(a2)
    8000345c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80003460:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80003464:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80003468:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    8000346c:	00813403          	ld	s0,8(sp)
    80003470:	01010113          	addi	sp,sp,16
    80003474:	00008067          	ret
        return nullptr;
    80003478:	00000513          	li	a0,0
    8000347c:	ff1ff06f          	j	8000346c <_ZN15MemoryAllocator9mem_allocEm+0x15c>

0000000080003480 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80003480:	ff010113          	addi	sp,sp,-16
    80003484:	00813423          	sd	s0,8(sp)
    80003488:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    8000348c:	16050463          	beqz	a0,800035f4 <_ZN15MemoryAllocator8mem_freeEPv+0x174>
    80003490:	ff850713          	addi	a4,a0,-8
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    80003494:	00004797          	auipc	a5,0x4
    80003498:	2047b783          	ld	a5,516(a5) # 80007698 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000349c:	0007b783          	ld	a5,0(a5)
    800034a0:	010006b7          	lui	a3,0x1000
    800034a4:	00d787b3          	add	a5,a5,a3
    800034a8:	14f76a63          	bltu	a4,a5,800035fc <_ZN15MemoryAllocator8mem_freeEPv+0x17c>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800034ac:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800034b0:	fff58693          	addi	a3,a1,-1
    800034b4:	00d706b3          	add	a3,a4,a3
        return (void*)HEAP_END_ADDR;
    800034b8:	00004617          	auipc	a2,0x4
    800034bc:	22863603          	ld	a2,552(a2) # 800076e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800034c0:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800034c4:	14c6f063          	bgeu	a3,a2,80003604 <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800034c8:	14070263          	beqz	a4,8000360c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
        return (size_t)address - (size_t)userHeapStartAddr();
    800034cc:	40f707b3          	sub	a5,a4,a5
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800034d0:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800034d4:	14079063          	bnez	a5,80003614 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
    800034d8:	03f00793          	li	a5,63
    800034dc:	14b7f063          	bgeu	a5,a1,8000361c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
        return BAD_POINTER;
    }

    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    800034e0:	00004797          	auipc	a5,0x4
    800034e4:	3707b783          	ld	a5,880(a5) # 80007850 <_ZN15MemoryAllocator4headE>
    800034e8:	02c78063          	beq	a5,a2,80003508 <_ZN15MemoryAllocator8mem_freeEPv+0x88>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800034ec:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800034f0:	02078a63          	beqz	a5,80003524 <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
    800034f4:	0007b683          	ld	a3,0(a5)
    800034f8:	02e6f663          	bgeu	a3,a4,80003524 <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
        prev = curr;
    800034fc:	00078613          	mv	a2,a5
        curr = curr->next;
    80003500:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80003504:	fedff06f          	j	800034f0 <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        newFreeSegment->size = size;
    80003508:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    8000350c:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80003510:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80003514:	00004797          	auipc	a5,0x4
    80003518:	32e7be23          	sd	a4,828(a5) # 80007850 <_ZN15MemoryAllocator4headE>
        return 0;
    8000351c:	00000513          	li	a0,0
    80003520:	0480006f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    }

    if(prev == nullptr) {
    80003524:	04060863          	beqz	a2,80003574 <_ZN15MemoryAllocator8mem_freeEPv+0xf4>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003528:	00063683          	ld	a3,0(a2)
    8000352c:	00863803          	ld	a6,8(a2)
    80003530:	010686b3          	add	a3,a3,a6
    80003534:	08e68a63          	beq	a3,a4,800035c8 <_ZN15MemoryAllocator8mem_freeEPv+0x148>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003538:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    8000353c:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80003540:	01063683          	ld	a3,16(a2)
    80003544:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003548:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    8000354c:	0e078063          	beqz	a5,8000362c <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    80003550:	0007b583          	ld	a1,0(a5)
    80003554:	00073683          	ld	a3,0(a4)
    80003558:	00873603          	ld	a2,8(a4)
    8000355c:	00c686b3          	add	a3,a3,a2
    80003560:	06d58c63          	beq	a1,a3,800035d8 <_ZN15MemoryAllocator8mem_freeEPv+0x158>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80003564:	00000513          	li	a0,0
}
    80003568:	00813403          	ld	s0,8(sp)
    8000356c:	01010113          	addi	sp,sp,16
    80003570:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80003574:	0a078863          	beqz	a5,80003624 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
            newFreeSegment->size = size;
    80003578:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    8000357c:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80003580:	00004797          	auipc	a5,0x4
    80003584:	2d07b783          	ld	a5,720(a5) # 80007850 <_ZN15MemoryAllocator4headE>
    80003588:	0007b603          	ld	a2,0(a5)
    8000358c:	00b706b3          	add	a3,a4,a1
    80003590:	00d60c63          	beq	a2,a3,800035a8 <_ZN15MemoryAllocator8mem_freeEPv+0x128>
                newFreeSegment->next = head;
    80003594:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80003598:	00004797          	auipc	a5,0x4
    8000359c:	2ae7bc23          	sd	a4,696(a5) # 80007850 <_ZN15MemoryAllocator4headE>
            return 0;
    800035a0:	00000513          	li	a0,0
    800035a4:	fc5ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
                newFreeSegment->size += head->size;
    800035a8:	0087b783          	ld	a5,8(a5)
    800035ac:	00b785b3          	add	a1,a5,a1
    800035b0:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800035b4:	00004797          	auipc	a5,0x4
    800035b8:	29c7b783          	ld	a5,668(a5) # 80007850 <_ZN15MemoryAllocator4headE>
    800035bc:	0107b783          	ld	a5,16(a5)
    800035c0:	00f53423          	sd	a5,8(a0)
    800035c4:	fd5ff06f          	j	80003598 <_ZN15MemoryAllocator8mem_freeEPv+0x118>
            prev->size += size;
    800035c8:	00b805b3          	add	a1,a6,a1
    800035cc:	00b63423          	sd	a1,8(a2)
    800035d0:	00060713          	mv	a4,a2
    800035d4:	f79ff06f          	j	8000354c <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
            prev->size += curr->size;
    800035d8:	0087b683          	ld	a3,8(a5)
    800035dc:	00d60633          	add	a2,a2,a3
    800035e0:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800035e4:	0107b783          	ld	a5,16(a5)
    800035e8:	00f73823          	sd	a5,16(a4)
    return 0;
    800035ec:	00000513          	li	a0,0
    800035f0:	f79ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    800035f4:	fff00513          	li	a0,-1
    800035f8:	f71ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    800035fc:	fff00513          	li	a0,-1
    80003600:	f69ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
        return BAD_POINTER;
    80003604:	fff00513          	li	a0,-1
    80003608:	f61ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    8000360c:	fff00513          	li	a0,-1
    80003610:	f59ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80003614:	fff00513          	li	a0,-1
    80003618:	f51ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    8000361c:	fff00513          	li	a0,-1
    80003620:	f49ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
            return BAD_POINTER;
    80003624:	fff00513          	li	a0,-1
    80003628:	f41ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    return 0;
    8000362c:	00000513          	li	a0,0
    80003630:	f39ff06f          	j	80003568 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>

0000000080003634 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003634:	fd010113          	addi	sp,sp,-48
    80003638:	02113423          	sd	ra,40(sp)
    8000363c:	02813023          	sd	s0,32(sp)
    80003640:	00913c23          	sd	s1,24(sp)
    80003644:	01213823          	sd	s2,16(sp)
    80003648:	01313423          	sd	s3,8(sp)
    8000364c:	03010413          	addi	s0,sp,48
    80003650:	00050493          	mv	s1,a0
    80003654:	00058913          	mv	s2,a1
    80003658:	0015879b          	addiw	a5,a1,1
    8000365c:	0007851b          	sext.w	a0,a5
    80003660:	00f4a023          	sw	a5,0(s1)
    80003664:	0004a823          	sw	zero,16(s1)
    80003668:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000366c:	00251513          	slli	a0,a0,0x2
    80003670:	ffffe097          	auipc	ra,0xffffe
    80003674:	b24080e7          	jalr	-1244(ra) # 80001194 <_Z9mem_allocm>
    80003678:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000367c:	01000513          	li	a0,16
    80003680:	00000097          	auipc	ra,0x0
    80003684:	858080e7          	jalr	-1960(ra) # 80002ed8 <_ZN9SemaphorenwEm>
    80003688:	00050993          	mv	s3,a0
    8000368c:	00000593          	li	a1,0
    80003690:	fffff097          	auipc	ra,0xfffff
    80003694:	728080e7          	jalr	1832(ra) # 80002db8 <_ZN9SemaphoreC1Ej>
    80003698:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000369c:	01000513          	li	a0,16
    800036a0:	00000097          	auipc	ra,0x0
    800036a4:	838080e7          	jalr	-1992(ra) # 80002ed8 <_ZN9SemaphorenwEm>
    800036a8:	00050993          	mv	s3,a0
    800036ac:	00090593          	mv	a1,s2
    800036b0:	fffff097          	auipc	ra,0xfffff
    800036b4:	708080e7          	jalr	1800(ra) # 80002db8 <_ZN9SemaphoreC1Ej>
    800036b8:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800036bc:	01000513          	li	a0,16
    800036c0:	00000097          	auipc	ra,0x0
    800036c4:	818080e7          	jalr	-2024(ra) # 80002ed8 <_ZN9SemaphorenwEm>
    800036c8:	00050913          	mv	s2,a0
    800036cc:	00100593          	li	a1,1
    800036d0:	fffff097          	auipc	ra,0xfffff
    800036d4:	6e8080e7          	jalr	1768(ra) # 80002db8 <_ZN9SemaphoreC1Ej>
    800036d8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800036dc:	01000513          	li	a0,16
    800036e0:	fffff097          	auipc	ra,0xfffff
    800036e4:	7f8080e7          	jalr	2040(ra) # 80002ed8 <_ZN9SemaphorenwEm>
    800036e8:	00050913          	mv	s2,a0
    800036ec:	00100593          	li	a1,1
    800036f0:	fffff097          	auipc	ra,0xfffff
    800036f4:	6c8080e7          	jalr	1736(ra) # 80002db8 <_ZN9SemaphoreC1Ej>
    800036f8:	0324b823          	sd	s2,48(s1)
}
    800036fc:	02813083          	ld	ra,40(sp)
    80003700:	02013403          	ld	s0,32(sp)
    80003704:	01813483          	ld	s1,24(sp)
    80003708:	01013903          	ld	s2,16(sp)
    8000370c:	00813983          	ld	s3,8(sp)
    80003710:	03010113          	addi	sp,sp,48
    80003714:	00008067          	ret
    80003718:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000371c:	00098513          	mv	a0,s3
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	750080e7          	jalr	1872(ra) # 80002e70 <_ZN9SemaphoredlEPv>
    80003728:	00048513          	mv	a0,s1
    8000372c:	00005097          	auipc	ra,0x5
    80003730:	1fc080e7          	jalr	508(ra) # 80008928 <_Unwind_Resume>
    80003734:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80003738:	00098513          	mv	a0,s3
    8000373c:	fffff097          	auipc	ra,0xfffff
    80003740:	734080e7          	jalr	1844(ra) # 80002e70 <_ZN9SemaphoredlEPv>
    80003744:	00048513          	mv	a0,s1
    80003748:	00005097          	auipc	ra,0x5
    8000374c:	1e0080e7          	jalr	480(ra) # 80008928 <_Unwind_Resume>
    80003750:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80003754:	00090513          	mv	a0,s2
    80003758:	fffff097          	auipc	ra,0xfffff
    8000375c:	718080e7          	jalr	1816(ra) # 80002e70 <_ZN9SemaphoredlEPv>
    80003760:	00048513          	mv	a0,s1
    80003764:	00005097          	auipc	ra,0x5
    80003768:	1c4080e7          	jalr	452(ra) # 80008928 <_Unwind_Resume>
    8000376c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80003770:	00090513          	mv	a0,s2
    80003774:	fffff097          	auipc	ra,0xfffff
    80003778:	6fc080e7          	jalr	1788(ra) # 80002e70 <_ZN9SemaphoredlEPv>
    8000377c:	00048513          	mv	a0,s1
    80003780:	00005097          	auipc	ra,0x5
    80003784:	1a8080e7          	jalr	424(ra) # 80008928 <_Unwind_Resume>

0000000080003788 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80003788:	fe010113          	addi	sp,sp,-32
    8000378c:	00113c23          	sd	ra,24(sp)
    80003790:	00813823          	sd	s0,16(sp)
    80003794:	00913423          	sd	s1,8(sp)
    80003798:	01213023          	sd	s2,0(sp)
    8000379c:	02010413          	addi	s0,sp,32
    800037a0:	00050493          	mv	s1,a0
    800037a4:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800037a8:	01853503          	ld	a0,24(a0)
    800037ac:	fffff097          	auipc	ra,0xfffff
    800037b0:	66c080e7          	jalr	1644(ra) # 80002e18 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800037b4:	0304b503          	ld	a0,48(s1)
    800037b8:	fffff097          	auipc	ra,0xfffff
    800037bc:	660080e7          	jalr	1632(ra) # 80002e18 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800037c0:	0084b783          	ld	a5,8(s1)
    800037c4:	0144a703          	lw	a4,20(s1)
    800037c8:	00271713          	slli	a4,a4,0x2
    800037cc:	00e787b3          	add	a5,a5,a4
    800037d0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800037d4:	0144a783          	lw	a5,20(s1)
    800037d8:	0017879b          	addiw	a5,a5,1
    800037dc:	0004a703          	lw	a4,0(s1)
    800037e0:	02e7e7bb          	remw	a5,a5,a4
    800037e4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800037e8:	0304b503          	ld	a0,48(s1)
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	658080e7          	jalr	1624(ra) # 80002e44 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800037f4:	0204b503          	ld	a0,32(s1)
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	64c080e7          	jalr	1612(ra) # 80002e44 <_ZN9Semaphore6signalEv>

}
    80003800:	01813083          	ld	ra,24(sp)
    80003804:	01013403          	ld	s0,16(sp)
    80003808:	00813483          	ld	s1,8(sp)
    8000380c:	00013903          	ld	s2,0(sp)
    80003810:	02010113          	addi	sp,sp,32
    80003814:	00008067          	ret

0000000080003818 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003818:	fe010113          	addi	sp,sp,-32
    8000381c:	00113c23          	sd	ra,24(sp)
    80003820:	00813823          	sd	s0,16(sp)
    80003824:	00913423          	sd	s1,8(sp)
    80003828:	01213023          	sd	s2,0(sp)
    8000382c:	02010413          	addi	s0,sp,32
    80003830:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003834:	02053503          	ld	a0,32(a0)
    80003838:	fffff097          	auipc	ra,0xfffff
    8000383c:	5e0080e7          	jalr	1504(ra) # 80002e18 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003840:	0284b503          	ld	a0,40(s1)
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	5d4080e7          	jalr	1492(ra) # 80002e18 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000384c:	0084b703          	ld	a4,8(s1)
    80003850:	0104a783          	lw	a5,16(s1)
    80003854:	00279693          	slli	a3,a5,0x2
    80003858:	00d70733          	add	a4,a4,a3
    8000385c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003860:	0017879b          	addiw	a5,a5,1
    80003864:	0004a703          	lw	a4,0(s1)
    80003868:	02e7e7bb          	remw	a5,a5,a4
    8000386c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003870:	0284b503          	ld	a0,40(s1)
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	5d0080e7          	jalr	1488(ra) # 80002e44 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000387c:	0184b503          	ld	a0,24(s1)
    80003880:	fffff097          	auipc	ra,0xfffff
    80003884:	5c4080e7          	jalr	1476(ra) # 80002e44 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003888:	00090513          	mv	a0,s2
    8000388c:	01813083          	ld	ra,24(sp)
    80003890:	01013403          	ld	s0,16(sp)
    80003894:	00813483          	ld	s1,8(sp)
    80003898:	00013903          	ld	s2,0(sp)
    8000389c:	02010113          	addi	sp,sp,32
    800038a0:	00008067          	ret

00000000800038a4 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800038a4:	fe010113          	addi	sp,sp,-32
    800038a8:	00113c23          	sd	ra,24(sp)
    800038ac:	00813823          	sd	s0,16(sp)
    800038b0:	00913423          	sd	s1,8(sp)
    800038b4:	01213023          	sd	s2,0(sp)
    800038b8:	02010413          	addi	s0,sp,32
    800038bc:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800038c0:	02853503          	ld	a0,40(a0)
    800038c4:	fffff097          	auipc	ra,0xfffff
    800038c8:	554080e7          	jalr	1364(ra) # 80002e18 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800038cc:	0304b503          	ld	a0,48(s1)
    800038d0:	fffff097          	auipc	ra,0xfffff
    800038d4:	548080e7          	jalr	1352(ra) # 80002e18 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800038d8:	0144a783          	lw	a5,20(s1)
    800038dc:	0104a903          	lw	s2,16(s1)
    800038e0:	0327ce63          	blt	a5,s2,8000391c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800038e4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800038e8:	0304b503          	ld	a0,48(s1)
    800038ec:	fffff097          	auipc	ra,0xfffff
    800038f0:	558080e7          	jalr	1368(ra) # 80002e44 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800038f4:	0284b503          	ld	a0,40(s1)
    800038f8:	fffff097          	auipc	ra,0xfffff
    800038fc:	54c080e7          	jalr	1356(ra) # 80002e44 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003900:	00090513          	mv	a0,s2
    80003904:	01813083          	ld	ra,24(sp)
    80003908:	01013403          	ld	s0,16(sp)
    8000390c:	00813483          	ld	s1,8(sp)
    80003910:	00013903          	ld	s2,0(sp)
    80003914:	02010113          	addi	sp,sp,32
    80003918:	00008067          	ret
        ret = cap - head + tail;
    8000391c:	0004a703          	lw	a4,0(s1)
    80003920:	4127093b          	subw	s2,a4,s2
    80003924:	00f9093b          	addw	s2,s2,a5
    80003928:	fc1ff06f          	j	800038e8 <_ZN9BufferCPP6getCntEv+0x44>

000000008000392c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000392c:	fe010113          	addi	sp,sp,-32
    80003930:	00113c23          	sd	ra,24(sp)
    80003934:	00813823          	sd	s0,16(sp)
    80003938:	00913423          	sd	s1,8(sp)
    8000393c:	02010413          	addi	s0,sp,32
    80003940:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003944:	00a00513          	li	a0,10
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	65c080e7          	jalr	1628(ra) # 80002fa4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003950:	00002517          	auipc	a0,0x2
    80003954:	7f850513          	addi	a0,a0,2040 # 80006148 <CONSOLE_STATUS+0x138>
    80003958:	fffff097          	auipc	ra,0xfffff
    8000395c:	ab4080e7          	jalr	-1356(ra) # 8000240c <_Z11printStringPKc>
    while (getCnt()) {
    80003960:	00048513          	mv	a0,s1
    80003964:	00000097          	auipc	ra,0x0
    80003968:	f40080e7          	jalr	-192(ra) # 800038a4 <_ZN9BufferCPP6getCntEv>
    8000396c:	02050c63          	beqz	a0,800039a4 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80003970:	0084b783          	ld	a5,8(s1)
    80003974:	0104a703          	lw	a4,16(s1)
    80003978:	00271713          	slli	a4,a4,0x2
    8000397c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80003980:	0007c503          	lbu	a0,0(a5)
    80003984:	fffff097          	auipc	ra,0xfffff
    80003988:	620080e7          	jalr	1568(ra) # 80002fa4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000398c:	0104a783          	lw	a5,16(s1)
    80003990:	0017879b          	addiw	a5,a5,1
    80003994:	0004a703          	lw	a4,0(s1)
    80003998:	02e7e7bb          	remw	a5,a5,a4
    8000399c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800039a0:	fc1ff06f          	j	80003960 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800039a4:	02100513          	li	a0,33
    800039a8:	fffff097          	auipc	ra,0xfffff
    800039ac:	5fc080e7          	jalr	1532(ra) # 80002fa4 <_ZN7Console4putcEc>
    Console::putc('\n');
    800039b0:	00a00513          	li	a0,10
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	5f0080e7          	jalr	1520(ra) # 80002fa4 <_ZN7Console4putcEc>
    mem_free(buffer);
    800039bc:	0084b503          	ld	a0,8(s1)
    800039c0:	ffffe097          	auipc	ra,0xffffe
    800039c4:	814080e7          	jalr	-2028(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    800039c8:	0204b503          	ld	a0,32(s1)
    800039cc:	00050863          	beqz	a0,800039dc <_ZN9BufferCPPD1Ev+0xb0>
    800039d0:	00053783          	ld	a5,0(a0)
    800039d4:	0087b783          	ld	a5,8(a5)
    800039d8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800039dc:	0184b503          	ld	a0,24(s1)
    800039e0:	00050863          	beqz	a0,800039f0 <_ZN9BufferCPPD1Ev+0xc4>
    800039e4:	00053783          	ld	a5,0(a0)
    800039e8:	0087b783          	ld	a5,8(a5)
    800039ec:	000780e7          	jalr	a5
    delete mutexTail;
    800039f0:	0304b503          	ld	a0,48(s1)
    800039f4:	00050863          	beqz	a0,80003a04 <_ZN9BufferCPPD1Ev+0xd8>
    800039f8:	00053783          	ld	a5,0(a0)
    800039fc:	0087b783          	ld	a5,8(a5)
    80003a00:	000780e7          	jalr	a5
    delete mutexHead;
    80003a04:	0284b503          	ld	a0,40(s1)
    80003a08:	00050863          	beqz	a0,80003a18 <_ZN9BufferCPPD1Ev+0xec>
    80003a0c:	00053783          	ld	a5,0(a0)
    80003a10:	0087b783          	ld	a5,8(a5)
    80003a14:	000780e7          	jalr	a5
}
    80003a18:	01813083          	ld	ra,24(sp)
    80003a1c:	01013403          	ld	s0,16(sp)
    80003a20:	00813483          	ld	s1,8(sp)
    80003a24:	02010113          	addi	sp,sp,32
    80003a28:	00008067          	ret

0000000080003a2c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003a2c:	fe010113          	addi	sp,sp,-32
    80003a30:	00113c23          	sd	ra,24(sp)
    80003a34:	00813823          	sd	s0,16(sp)
    80003a38:	00913423          	sd	s1,8(sp)
    80003a3c:	01213023          	sd	s2,0(sp)
    80003a40:	02010413          	addi	s0,sp,32
    80003a44:	00050493          	mv	s1,a0
    80003a48:	00058913          	mv	s2,a1
    80003a4c:	0015879b          	addiw	a5,a1,1
    80003a50:	0007851b          	sext.w	a0,a5
    80003a54:	00f4a023          	sw	a5,0(s1)
    80003a58:	0004a823          	sw	zero,16(s1)
    80003a5c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003a60:	00251513          	slli	a0,a0,0x2
    80003a64:	ffffd097          	auipc	ra,0xffffd
    80003a68:	730080e7          	jalr	1840(ra) # 80001194 <_Z9mem_allocm>
    80003a6c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003a70:	00000593          	li	a1,0
    80003a74:	02048513          	addi	a0,s1,32
    80003a78:	ffffe097          	auipc	ra,0xffffe
    80003a7c:	8d8080e7          	jalr	-1832(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80003a80:	00090593          	mv	a1,s2
    80003a84:	01848513          	addi	a0,s1,24
    80003a88:	ffffe097          	auipc	ra,0xffffe
    80003a8c:	8c8080e7          	jalr	-1848(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003a90:	00100593          	li	a1,1
    80003a94:	02848513          	addi	a0,s1,40
    80003a98:	ffffe097          	auipc	ra,0xffffe
    80003a9c:	8b8080e7          	jalr	-1864(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003aa0:	00100593          	li	a1,1
    80003aa4:	03048513          	addi	a0,s1,48
    80003aa8:	ffffe097          	auipc	ra,0xffffe
    80003aac:	8a8080e7          	jalr	-1880(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003ab0:	01813083          	ld	ra,24(sp)
    80003ab4:	01013403          	ld	s0,16(sp)
    80003ab8:	00813483          	ld	s1,8(sp)
    80003abc:	00013903          	ld	s2,0(sp)
    80003ac0:	02010113          	addi	sp,sp,32
    80003ac4:	00008067          	ret

0000000080003ac8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80003ac8:	fe010113          	addi	sp,sp,-32
    80003acc:	00113c23          	sd	ra,24(sp)
    80003ad0:	00813823          	sd	s0,16(sp)
    80003ad4:	00913423          	sd	s1,8(sp)
    80003ad8:	01213023          	sd	s2,0(sp)
    80003adc:	02010413          	addi	s0,sp,32
    80003ae0:	00050493          	mv	s1,a0
    80003ae4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003ae8:	01853503          	ld	a0,24(a0)
    80003aec:	ffffe097          	auipc	ra,0xffffe
    80003af0:	8ac080e7          	jalr	-1876(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80003af4:	0304b503          	ld	a0,48(s1)
    80003af8:	ffffe097          	auipc	ra,0xffffe
    80003afc:	8a0080e7          	jalr	-1888(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80003b00:	0084b783          	ld	a5,8(s1)
    80003b04:	0144a703          	lw	a4,20(s1)
    80003b08:	00271713          	slli	a4,a4,0x2
    80003b0c:	00e787b3          	add	a5,a5,a4
    80003b10:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003b14:	0144a783          	lw	a5,20(s1)
    80003b18:	0017879b          	addiw	a5,a5,1
    80003b1c:	0004a703          	lw	a4,0(s1)
    80003b20:	02e7e7bb          	remw	a5,a5,a4
    80003b24:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003b28:	0304b503          	ld	a0,48(s1)
    80003b2c:	ffffe097          	auipc	ra,0xffffe
    80003b30:	8b4080e7          	jalr	-1868(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80003b34:	0204b503          	ld	a0,32(s1)
    80003b38:	ffffe097          	auipc	ra,0xffffe
    80003b3c:	8a8080e7          	jalr	-1880(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80003b40:	01813083          	ld	ra,24(sp)
    80003b44:	01013403          	ld	s0,16(sp)
    80003b48:	00813483          	ld	s1,8(sp)
    80003b4c:	00013903          	ld	s2,0(sp)
    80003b50:	02010113          	addi	sp,sp,32
    80003b54:	00008067          	ret

0000000080003b58 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003b58:	fe010113          	addi	sp,sp,-32
    80003b5c:	00113c23          	sd	ra,24(sp)
    80003b60:	00813823          	sd	s0,16(sp)
    80003b64:	00913423          	sd	s1,8(sp)
    80003b68:	01213023          	sd	s2,0(sp)
    80003b6c:	02010413          	addi	s0,sp,32
    80003b70:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003b74:	02053503          	ld	a0,32(a0)
    80003b78:	ffffe097          	auipc	ra,0xffffe
    80003b7c:	820080e7          	jalr	-2016(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003b80:	0284b503          	ld	a0,40(s1)
    80003b84:	ffffe097          	auipc	ra,0xffffe
    80003b88:	814080e7          	jalr	-2028(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003b8c:	0084b703          	ld	a4,8(s1)
    80003b90:	0104a783          	lw	a5,16(s1)
    80003b94:	00279693          	slli	a3,a5,0x2
    80003b98:	00d70733          	add	a4,a4,a3
    80003b9c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003ba0:	0017879b          	addiw	a5,a5,1
    80003ba4:	0004a703          	lw	a4,0(s1)
    80003ba8:	02e7e7bb          	remw	a5,a5,a4
    80003bac:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003bb0:	0284b503          	ld	a0,40(s1)
    80003bb4:	ffffe097          	auipc	ra,0xffffe
    80003bb8:	82c080e7          	jalr	-2004(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003bbc:	0184b503          	ld	a0,24(s1)
    80003bc0:	ffffe097          	auipc	ra,0xffffe
    80003bc4:	820080e7          	jalr	-2016(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003bc8:	00090513          	mv	a0,s2
    80003bcc:	01813083          	ld	ra,24(sp)
    80003bd0:	01013403          	ld	s0,16(sp)
    80003bd4:	00813483          	ld	s1,8(sp)
    80003bd8:	00013903          	ld	s2,0(sp)
    80003bdc:	02010113          	addi	sp,sp,32
    80003be0:	00008067          	ret

0000000080003be4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003be4:	fe010113          	addi	sp,sp,-32
    80003be8:	00113c23          	sd	ra,24(sp)
    80003bec:	00813823          	sd	s0,16(sp)
    80003bf0:	00913423          	sd	s1,8(sp)
    80003bf4:	01213023          	sd	s2,0(sp)
    80003bf8:	02010413          	addi	s0,sp,32
    80003bfc:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80003c00:	02853503          	ld	a0,40(a0)
    80003c04:	ffffd097          	auipc	ra,0xffffd
    80003c08:	794080e7          	jalr	1940(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    80003c0c:	0304b503          	ld	a0,48(s1)
    80003c10:	ffffd097          	auipc	ra,0xffffd
    80003c14:	788080e7          	jalr	1928(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80003c18:	0144a783          	lw	a5,20(s1)
    80003c1c:	0104a903          	lw	s2,16(s1)
    80003c20:	0327ce63          	blt	a5,s2,80003c5c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80003c24:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80003c28:	0304b503          	ld	a0,48(s1)
    80003c2c:	ffffd097          	auipc	ra,0xffffd
    80003c30:	7b4080e7          	jalr	1972(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    80003c34:	0284b503          	ld	a0,40(s1)
    80003c38:	ffffd097          	auipc	ra,0xffffd
    80003c3c:	7a8080e7          	jalr	1960(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80003c40:	00090513          	mv	a0,s2
    80003c44:	01813083          	ld	ra,24(sp)
    80003c48:	01013403          	ld	s0,16(sp)
    80003c4c:	00813483          	ld	s1,8(sp)
    80003c50:	00013903          	ld	s2,0(sp)
    80003c54:	02010113          	addi	sp,sp,32
    80003c58:	00008067          	ret
        ret = cap - head + tail;
    80003c5c:	0004a703          	lw	a4,0(s1)
    80003c60:	4127093b          	subw	s2,a4,s2
    80003c64:	00f9093b          	addw	s2,s2,a5
    80003c68:	fc1ff06f          	j	80003c28 <_ZN6Buffer6getCntEv+0x44>

0000000080003c6c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003c6c:	fe010113          	addi	sp,sp,-32
    80003c70:	00113c23          	sd	ra,24(sp)
    80003c74:	00813823          	sd	s0,16(sp)
    80003c78:	00913423          	sd	s1,8(sp)
    80003c7c:	02010413          	addi	s0,sp,32
    80003c80:	00050493          	mv	s1,a0
    putc('\n');
    80003c84:	00a00513          	li	a0,10
    80003c88:	ffffe097          	auipc	ra,0xffffe
    80003c8c:	850080e7          	jalr	-1968(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003c90:	00002517          	auipc	a0,0x2
    80003c94:	4b850513          	addi	a0,a0,1208 # 80006148 <CONSOLE_STATUS+0x138>
    80003c98:	ffffe097          	auipc	ra,0xffffe
    80003c9c:	774080e7          	jalr	1908(ra) # 8000240c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003ca0:	00048513          	mv	a0,s1
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	f40080e7          	jalr	-192(ra) # 80003be4 <_ZN6Buffer6getCntEv>
    80003cac:	02a05c63          	blez	a0,80003ce4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003cb0:	0084b783          	ld	a5,8(s1)
    80003cb4:	0104a703          	lw	a4,16(s1)
    80003cb8:	00271713          	slli	a4,a4,0x2
    80003cbc:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003cc0:	0007c503          	lbu	a0,0(a5)
    80003cc4:	ffffe097          	auipc	ra,0xffffe
    80003cc8:	814080e7          	jalr	-2028(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80003ccc:	0104a783          	lw	a5,16(s1)
    80003cd0:	0017879b          	addiw	a5,a5,1
    80003cd4:	0004a703          	lw	a4,0(s1)
    80003cd8:	02e7e7bb          	remw	a5,a5,a4
    80003cdc:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003ce0:	fc1ff06f          	j	80003ca0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003ce4:	02100513          	li	a0,33
    80003ce8:	ffffd097          	auipc	ra,0xffffd
    80003cec:	7f0080e7          	jalr	2032(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    80003cf0:	00a00513          	li	a0,10
    80003cf4:	ffffd097          	auipc	ra,0xffffd
    80003cf8:	7e4080e7          	jalr	2020(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    80003cfc:	0084b503          	ld	a0,8(s1)
    80003d00:	ffffd097          	auipc	ra,0xffffd
    80003d04:	4d4080e7          	jalr	1236(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003d08:	0204b503          	ld	a0,32(s1)
    80003d0c:	ffffd097          	auipc	ra,0xffffd
    80003d10:	714080e7          	jalr	1812(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003d14:	0184b503          	ld	a0,24(s1)
    80003d18:	ffffd097          	auipc	ra,0xffffd
    80003d1c:	708080e7          	jalr	1800(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003d20:	0304b503          	ld	a0,48(s1)
    80003d24:	ffffd097          	auipc	ra,0xffffd
    80003d28:	6fc080e7          	jalr	1788(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80003d2c:	0284b503          	ld	a0,40(s1)
    80003d30:	ffffd097          	auipc	ra,0xffffd
    80003d34:	6f0080e7          	jalr	1776(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003d38:	01813083          	ld	ra,24(sp)
    80003d3c:	01013403          	ld	s0,16(sp)
    80003d40:	00813483          	ld	s1,8(sp)
    80003d44:	02010113          	addi	sp,sp,32
    80003d48:	00008067          	ret

0000000080003d4c <start>:
    80003d4c:	ff010113          	addi	sp,sp,-16
    80003d50:	00813423          	sd	s0,8(sp)
    80003d54:	01010413          	addi	s0,sp,16
    80003d58:	300027f3          	csrr	a5,mstatus
    80003d5c:	ffffe737          	lui	a4,0xffffe
    80003d60:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5d3f>
    80003d64:	00e7f7b3          	and	a5,a5,a4
    80003d68:	00001737          	lui	a4,0x1
    80003d6c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003d70:	00e7e7b3          	or	a5,a5,a4
    80003d74:	30079073          	csrw	mstatus,a5
    80003d78:	00000797          	auipc	a5,0x0
    80003d7c:	16078793          	addi	a5,a5,352 # 80003ed8 <system_main>
    80003d80:	34179073          	csrw	mepc,a5
    80003d84:	00000793          	li	a5,0
    80003d88:	18079073          	csrw	satp,a5
    80003d8c:	000107b7          	lui	a5,0x10
    80003d90:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003d94:	30279073          	csrw	medeleg,a5
    80003d98:	30379073          	csrw	mideleg,a5
    80003d9c:	104027f3          	csrr	a5,sie
    80003da0:	2227e793          	ori	a5,a5,546
    80003da4:	10479073          	csrw	sie,a5
    80003da8:	fff00793          	li	a5,-1
    80003dac:	00a7d793          	srli	a5,a5,0xa
    80003db0:	3b079073          	csrw	pmpaddr0,a5
    80003db4:	00f00793          	li	a5,15
    80003db8:	3a079073          	csrw	pmpcfg0,a5
    80003dbc:	f14027f3          	csrr	a5,mhartid
    80003dc0:	0200c737          	lui	a4,0x200c
    80003dc4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003dc8:	0007869b          	sext.w	a3,a5
    80003dcc:	00269713          	slli	a4,a3,0x2
    80003dd0:	000f4637          	lui	a2,0xf4
    80003dd4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003dd8:	00d70733          	add	a4,a4,a3
    80003ddc:	0037979b          	slliw	a5,a5,0x3
    80003de0:	020046b7          	lui	a3,0x2004
    80003de4:	00d787b3          	add	a5,a5,a3
    80003de8:	00c585b3          	add	a1,a1,a2
    80003dec:	00371693          	slli	a3,a4,0x3
    80003df0:	00004717          	auipc	a4,0x4
    80003df4:	a7070713          	addi	a4,a4,-1424 # 80007860 <timer_scratch>
    80003df8:	00b7b023          	sd	a1,0(a5)
    80003dfc:	00d70733          	add	a4,a4,a3
    80003e00:	00f73c23          	sd	a5,24(a4)
    80003e04:	02c73023          	sd	a2,32(a4)
    80003e08:	34071073          	csrw	mscratch,a4
    80003e0c:	00000797          	auipc	a5,0x0
    80003e10:	6e478793          	addi	a5,a5,1764 # 800044f0 <timervec>
    80003e14:	30579073          	csrw	mtvec,a5
    80003e18:	300027f3          	csrr	a5,mstatus
    80003e1c:	0087e793          	ori	a5,a5,8
    80003e20:	30079073          	csrw	mstatus,a5
    80003e24:	304027f3          	csrr	a5,mie
    80003e28:	0807e793          	ori	a5,a5,128
    80003e2c:	30479073          	csrw	mie,a5
    80003e30:	f14027f3          	csrr	a5,mhartid
    80003e34:	0007879b          	sext.w	a5,a5
    80003e38:	00078213          	mv	tp,a5
    80003e3c:	30200073          	mret
    80003e40:	00813403          	ld	s0,8(sp)
    80003e44:	01010113          	addi	sp,sp,16
    80003e48:	00008067          	ret

0000000080003e4c <timerinit>:
    80003e4c:	ff010113          	addi	sp,sp,-16
    80003e50:	00813423          	sd	s0,8(sp)
    80003e54:	01010413          	addi	s0,sp,16
    80003e58:	f14027f3          	csrr	a5,mhartid
    80003e5c:	0200c737          	lui	a4,0x200c
    80003e60:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003e64:	0007869b          	sext.w	a3,a5
    80003e68:	00269713          	slli	a4,a3,0x2
    80003e6c:	000f4637          	lui	a2,0xf4
    80003e70:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003e74:	00d70733          	add	a4,a4,a3
    80003e78:	0037979b          	slliw	a5,a5,0x3
    80003e7c:	020046b7          	lui	a3,0x2004
    80003e80:	00d787b3          	add	a5,a5,a3
    80003e84:	00c585b3          	add	a1,a1,a2
    80003e88:	00371693          	slli	a3,a4,0x3
    80003e8c:	00004717          	auipc	a4,0x4
    80003e90:	9d470713          	addi	a4,a4,-1580 # 80007860 <timer_scratch>
    80003e94:	00b7b023          	sd	a1,0(a5)
    80003e98:	00d70733          	add	a4,a4,a3
    80003e9c:	00f73c23          	sd	a5,24(a4)
    80003ea0:	02c73023          	sd	a2,32(a4)
    80003ea4:	34071073          	csrw	mscratch,a4
    80003ea8:	00000797          	auipc	a5,0x0
    80003eac:	64878793          	addi	a5,a5,1608 # 800044f0 <timervec>
    80003eb0:	30579073          	csrw	mtvec,a5
    80003eb4:	300027f3          	csrr	a5,mstatus
    80003eb8:	0087e793          	ori	a5,a5,8
    80003ebc:	30079073          	csrw	mstatus,a5
    80003ec0:	304027f3          	csrr	a5,mie
    80003ec4:	0807e793          	ori	a5,a5,128
    80003ec8:	30479073          	csrw	mie,a5
    80003ecc:	00813403          	ld	s0,8(sp)
    80003ed0:	01010113          	addi	sp,sp,16
    80003ed4:	00008067          	ret

0000000080003ed8 <system_main>:
    80003ed8:	fe010113          	addi	sp,sp,-32
    80003edc:	00813823          	sd	s0,16(sp)
    80003ee0:	00913423          	sd	s1,8(sp)
    80003ee4:	00113c23          	sd	ra,24(sp)
    80003ee8:	02010413          	addi	s0,sp,32
    80003eec:	00000097          	auipc	ra,0x0
    80003ef0:	0c4080e7          	jalr	196(ra) # 80003fb0 <cpuid>
    80003ef4:	00004497          	auipc	s1,0x4
    80003ef8:	83c48493          	addi	s1,s1,-1988 # 80007730 <started>
    80003efc:	02050263          	beqz	a0,80003f20 <system_main+0x48>
    80003f00:	0004a783          	lw	a5,0(s1)
    80003f04:	0007879b          	sext.w	a5,a5
    80003f08:	fe078ce3          	beqz	a5,80003f00 <system_main+0x28>
    80003f0c:	0ff0000f          	fence
    80003f10:	00002517          	auipc	a0,0x2
    80003f14:	28050513          	addi	a0,a0,640 # 80006190 <CONSOLE_STATUS+0x180>
    80003f18:	00001097          	auipc	ra,0x1
    80003f1c:	a74080e7          	jalr	-1420(ra) # 8000498c <panic>
    80003f20:	00001097          	auipc	ra,0x1
    80003f24:	9c8080e7          	jalr	-1592(ra) # 800048e8 <consoleinit>
    80003f28:	00001097          	auipc	ra,0x1
    80003f2c:	154080e7          	jalr	340(ra) # 8000507c <printfinit>
    80003f30:	00002517          	auipc	a0,0x2
    80003f34:	34050513          	addi	a0,a0,832 # 80006270 <CONSOLE_STATUS+0x260>
    80003f38:	00001097          	auipc	ra,0x1
    80003f3c:	ab0080e7          	jalr	-1360(ra) # 800049e8 <__printf>
    80003f40:	00002517          	auipc	a0,0x2
    80003f44:	22050513          	addi	a0,a0,544 # 80006160 <CONSOLE_STATUS+0x150>
    80003f48:	00001097          	auipc	ra,0x1
    80003f4c:	aa0080e7          	jalr	-1376(ra) # 800049e8 <__printf>
    80003f50:	00002517          	auipc	a0,0x2
    80003f54:	32050513          	addi	a0,a0,800 # 80006270 <CONSOLE_STATUS+0x260>
    80003f58:	00001097          	auipc	ra,0x1
    80003f5c:	a90080e7          	jalr	-1392(ra) # 800049e8 <__printf>
    80003f60:	00001097          	auipc	ra,0x1
    80003f64:	4a8080e7          	jalr	1192(ra) # 80005408 <kinit>
    80003f68:	00000097          	auipc	ra,0x0
    80003f6c:	148080e7          	jalr	328(ra) # 800040b0 <trapinit>
    80003f70:	00000097          	auipc	ra,0x0
    80003f74:	16c080e7          	jalr	364(ra) # 800040dc <trapinithart>
    80003f78:	00000097          	auipc	ra,0x0
    80003f7c:	5b8080e7          	jalr	1464(ra) # 80004530 <plicinit>
    80003f80:	00000097          	auipc	ra,0x0
    80003f84:	5d8080e7          	jalr	1496(ra) # 80004558 <plicinithart>
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	078080e7          	jalr	120(ra) # 80004000 <userinit>
    80003f90:	0ff0000f          	fence
    80003f94:	00100793          	li	a5,1
    80003f98:	00002517          	auipc	a0,0x2
    80003f9c:	1e050513          	addi	a0,a0,480 # 80006178 <CONSOLE_STATUS+0x168>
    80003fa0:	00f4a023          	sw	a5,0(s1)
    80003fa4:	00001097          	auipc	ra,0x1
    80003fa8:	a44080e7          	jalr	-1468(ra) # 800049e8 <__printf>
    80003fac:	0000006f          	j	80003fac <system_main+0xd4>

0000000080003fb0 <cpuid>:
    80003fb0:	ff010113          	addi	sp,sp,-16
    80003fb4:	00813423          	sd	s0,8(sp)
    80003fb8:	01010413          	addi	s0,sp,16
    80003fbc:	00020513          	mv	a0,tp
    80003fc0:	00813403          	ld	s0,8(sp)
    80003fc4:	0005051b          	sext.w	a0,a0
    80003fc8:	01010113          	addi	sp,sp,16
    80003fcc:	00008067          	ret

0000000080003fd0 <mycpu>:
    80003fd0:	ff010113          	addi	sp,sp,-16
    80003fd4:	00813423          	sd	s0,8(sp)
    80003fd8:	01010413          	addi	s0,sp,16
    80003fdc:	00020793          	mv	a5,tp
    80003fe0:	00813403          	ld	s0,8(sp)
    80003fe4:	0007879b          	sext.w	a5,a5
    80003fe8:	00779793          	slli	a5,a5,0x7
    80003fec:	00005517          	auipc	a0,0x5
    80003ff0:	8a450513          	addi	a0,a0,-1884 # 80008890 <cpus>
    80003ff4:	00f50533          	add	a0,a0,a5
    80003ff8:	01010113          	addi	sp,sp,16
    80003ffc:	00008067          	ret

0000000080004000 <userinit>:
    80004000:	ff010113          	addi	sp,sp,-16
    80004004:	00813423          	sd	s0,8(sp)
    80004008:	01010413          	addi	s0,sp,16
    8000400c:	00813403          	ld	s0,8(sp)
    80004010:	01010113          	addi	sp,sp,16
    80004014:	fffff317          	auipc	t1,0xfffff
    80004018:	8b430067          	jr	-1868(t1) # 800028c8 <main>

000000008000401c <either_copyout>:
    8000401c:	ff010113          	addi	sp,sp,-16
    80004020:	00813023          	sd	s0,0(sp)
    80004024:	00113423          	sd	ra,8(sp)
    80004028:	01010413          	addi	s0,sp,16
    8000402c:	02051663          	bnez	a0,80004058 <either_copyout+0x3c>
    80004030:	00058513          	mv	a0,a1
    80004034:	00060593          	mv	a1,a2
    80004038:	0006861b          	sext.w	a2,a3
    8000403c:	00002097          	auipc	ra,0x2
    80004040:	c58080e7          	jalr	-936(ra) # 80005c94 <__memmove>
    80004044:	00813083          	ld	ra,8(sp)
    80004048:	00013403          	ld	s0,0(sp)
    8000404c:	00000513          	li	a0,0
    80004050:	01010113          	addi	sp,sp,16
    80004054:	00008067          	ret
    80004058:	00002517          	auipc	a0,0x2
    8000405c:	16050513          	addi	a0,a0,352 # 800061b8 <CONSOLE_STATUS+0x1a8>
    80004060:	00001097          	auipc	ra,0x1
    80004064:	92c080e7          	jalr	-1748(ra) # 8000498c <panic>

0000000080004068 <either_copyin>:
    80004068:	ff010113          	addi	sp,sp,-16
    8000406c:	00813023          	sd	s0,0(sp)
    80004070:	00113423          	sd	ra,8(sp)
    80004074:	01010413          	addi	s0,sp,16
    80004078:	02059463          	bnez	a1,800040a0 <either_copyin+0x38>
    8000407c:	00060593          	mv	a1,a2
    80004080:	0006861b          	sext.w	a2,a3
    80004084:	00002097          	auipc	ra,0x2
    80004088:	c10080e7          	jalr	-1008(ra) # 80005c94 <__memmove>
    8000408c:	00813083          	ld	ra,8(sp)
    80004090:	00013403          	ld	s0,0(sp)
    80004094:	00000513          	li	a0,0
    80004098:	01010113          	addi	sp,sp,16
    8000409c:	00008067          	ret
    800040a0:	00002517          	auipc	a0,0x2
    800040a4:	14050513          	addi	a0,a0,320 # 800061e0 <CONSOLE_STATUS+0x1d0>
    800040a8:	00001097          	auipc	ra,0x1
    800040ac:	8e4080e7          	jalr	-1820(ra) # 8000498c <panic>

00000000800040b0 <trapinit>:
    800040b0:	ff010113          	addi	sp,sp,-16
    800040b4:	00813423          	sd	s0,8(sp)
    800040b8:	01010413          	addi	s0,sp,16
    800040bc:	00813403          	ld	s0,8(sp)
    800040c0:	00002597          	auipc	a1,0x2
    800040c4:	14858593          	addi	a1,a1,328 # 80006208 <CONSOLE_STATUS+0x1f8>
    800040c8:	00005517          	auipc	a0,0x5
    800040cc:	84850513          	addi	a0,a0,-1976 # 80008910 <tickslock>
    800040d0:	01010113          	addi	sp,sp,16
    800040d4:	00001317          	auipc	t1,0x1
    800040d8:	5c430067          	jr	1476(t1) # 80005698 <initlock>

00000000800040dc <trapinithart>:
    800040dc:	ff010113          	addi	sp,sp,-16
    800040e0:	00813423          	sd	s0,8(sp)
    800040e4:	01010413          	addi	s0,sp,16
    800040e8:	00000797          	auipc	a5,0x0
    800040ec:	2f878793          	addi	a5,a5,760 # 800043e0 <kernelvec>
    800040f0:	10579073          	csrw	stvec,a5
    800040f4:	00813403          	ld	s0,8(sp)
    800040f8:	01010113          	addi	sp,sp,16
    800040fc:	00008067          	ret

0000000080004100 <usertrap>:
    80004100:	ff010113          	addi	sp,sp,-16
    80004104:	00813423          	sd	s0,8(sp)
    80004108:	01010413          	addi	s0,sp,16
    8000410c:	00813403          	ld	s0,8(sp)
    80004110:	01010113          	addi	sp,sp,16
    80004114:	00008067          	ret

0000000080004118 <usertrapret>:
    80004118:	ff010113          	addi	sp,sp,-16
    8000411c:	00813423          	sd	s0,8(sp)
    80004120:	01010413          	addi	s0,sp,16
    80004124:	00813403          	ld	s0,8(sp)
    80004128:	01010113          	addi	sp,sp,16
    8000412c:	00008067          	ret

0000000080004130 <kerneltrap>:
    80004130:	fe010113          	addi	sp,sp,-32
    80004134:	00813823          	sd	s0,16(sp)
    80004138:	00113c23          	sd	ra,24(sp)
    8000413c:	00913423          	sd	s1,8(sp)
    80004140:	02010413          	addi	s0,sp,32
    80004144:	142025f3          	csrr	a1,scause
    80004148:	100027f3          	csrr	a5,sstatus
    8000414c:	0027f793          	andi	a5,a5,2
    80004150:	10079c63          	bnez	a5,80004268 <kerneltrap+0x138>
    80004154:	142027f3          	csrr	a5,scause
    80004158:	0207ce63          	bltz	a5,80004194 <kerneltrap+0x64>
    8000415c:	00002517          	auipc	a0,0x2
    80004160:	0f450513          	addi	a0,a0,244 # 80006250 <CONSOLE_STATUS+0x240>
    80004164:	00001097          	auipc	ra,0x1
    80004168:	884080e7          	jalr	-1916(ra) # 800049e8 <__printf>
    8000416c:	141025f3          	csrr	a1,sepc
    80004170:	14302673          	csrr	a2,stval
    80004174:	00002517          	auipc	a0,0x2
    80004178:	0ec50513          	addi	a0,a0,236 # 80006260 <CONSOLE_STATUS+0x250>
    8000417c:	00001097          	auipc	ra,0x1
    80004180:	86c080e7          	jalr	-1940(ra) # 800049e8 <__printf>
    80004184:	00002517          	auipc	a0,0x2
    80004188:	0f450513          	addi	a0,a0,244 # 80006278 <CONSOLE_STATUS+0x268>
    8000418c:	00001097          	auipc	ra,0x1
    80004190:	800080e7          	jalr	-2048(ra) # 8000498c <panic>
    80004194:	0ff7f713          	andi	a4,a5,255
    80004198:	00900693          	li	a3,9
    8000419c:	04d70063          	beq	a4,a3,800041dc <kerneltrap+0xac>
    800041a0:	fff00713          	li	a4,-1
    800041a4:	03f71713          	slli	a4,a4,0x3f
    800041a8:	00170713          	addi	a4,a4,1
    800041ac:	fae798e3          	bne	a5,a4,8000415c <kerneltrap+0x2c>
    800041b0:	00000097          	auipc	ra,0x0
    800041b4:	e00080e7          	jalr	-512(ra) # 80003fb0 <cpuid>
    800041b8:	06050663          	beqz	a0,80004224 <kerneltrap+0xf4>
    800041bc:	144027f3          	csrr	a5,sip
    800041c0:	ffd7f793          	andi	a5,a5,-3
    800041c4:	14479073          	csrw	sip,a5
    800041c8:	01813083          	ld	ra,24(sp)
    800041cc:	01013403          	ld	s0,16(sp)
    800041d0:	00813483          	ld	s1,8(sp)
    800041d4:	02010113          	addi	sp,sp,32
    800041d8:	00008067          	ret
    800041dc:	00000097          	auipc	ra,0x0
    800041e0:	3c8080e7          	jalr	968(ra) # 800045a4 <plic_claim>
    800041e4:	00a00793          	li	a5,10
    800041e8:	00050493          	mv	s1,a0
    800041ec:	06f50863          	beq	a0,a5,8000425c <kerneltrap+0x12c>
    800041f0:	fc050ce3          	beqz	a0,800041c8 <kerneltrap+0x98>
    800041f4:	00050593          	mv	a1,a0
    800041f8:	00002517          	auipc	a0,0x2
    800041fc:	03850513          	addi	a0,a0,56 # 80006230 <CONSOLE_STATUS+0x220>
    80004200:	00000097          	auipc	ra,0x0
    80004204:	7e8080e7          	jalr	2024(ra) # 800049e8 <__printf>
    80004208:	01013403          	ld	s0,16(sp)
    8000420c:	01813083          	ld	ra,24(sp)
    80004210:	00048513          	mv	a0,s1
    80004214:	00813483          	ld	s1,8(sp)
    80004218:	02010113          	addi	sp,sp,32
    8000421c:	00000317          	auipc	t1,0x0
    80004220:	3c030067          	jr	960(t1) # 800045dc <plic_complete>
    80004224:	00004517          	auipc	a0,0x4
    80004228:	6ec50513          	addi	a0,a0,1772 # 80008910 <tickslock>
    8000422c:	00001097          	auipc	ra,0x1
    80004230:	490080e7          	jalr	1168(ra) # 800056bc <acquire>
    80004234:	00003717          	auipc	a4,0x3
    80004238:	50070713          	addi	a4,a4,1280 # 80007734 <ticks>
    8000423c:	00072783          	lw	a5,0(a4)
    80004240:	00004517          	auipc	a0,0x4
    80004244:	6d050513          	addi	a0,a0,1744 # 80008910 <tickslock>
    80004248:	0017879b          	addiw	a5,a5,1
    8000424c:	00f72023          	sw	a5,0(a4)
    80004250:	00001097          	auipc	ra,0x1
    80004254:	538080e7          	jalr	1336(ra) # 80005788 <release>
    80004258:	f65ff06f          	j	800041bc <kerneltrap+0x8c>
    8000425c:	00001097          	auipc	ra,0x1
    80004260:	094080e7          	jalr	148(ra) # 800052f0 <uartintr>
    80004264:	fa5ff06f          	j	80004208 <kerneltrap+0xd8>
    80004268:	00002517          	auipc	a0,0x2
    8000426c:	fa850513          	addi	a0,a0,-88 # 80006210 <CONSOLE_STATUS+0x200>
    80004270:	00000097          	auipc	ra,0x0
    80004274:	71c080e7          	jalr	1820(ra) # 8000498c <panic>

0000000080004278 <clockintr>:
    80004278:	fe010113          	addi	sp,sp,-32
    8000427c:	00813823          	sd	s0,16(sp)
    80004280:	00913423          	sd	s1,8(sp)
    80004284:	00113c23          	sd	ra,24(sp)
    80004288:	02010413          	addi	s0,sp,32
    8000428c:	00004497          	auipc	s1,0x4
    80004290:	68448493          	addi	s1,s1,1668 # 80008910 <tickslock>
    80004294:	00048513          	mv	a0,s1
    80004298:	00001097          	auipc	ra,0x1
    8000429c:	424080e7          	jalr	1060(ra) # 800056bc <acquire>
    800042a0:	00003717          	auipc	a4,0x3
    800042a4:	49470713          	addi	a4,a4,1172 # 80007734 <ticks>
    800042a8:	00072783          	lw	a5,0(a4)
    800042ac:	01013403          	ld	s0,16(sp)
    800042b0:	01813083          	ld	ra,24(sp)
    800042b4:	00048513          	mv	a0,s1
    800042b8:	0017879b          	addiw	a5,a5,1
    800042bc:	00813483          	ld	s1,8(sp)
    800042c0:	00f72023          	sw	a5,0(a4)
    800042c4:	02010113          	addi	sp,sp,32
    800042c8:	00001317          	auipc	t1,0x1
    800042cc:	4c030067          	jr	1216(t1) # 80005788 <release>

00000000800042d0 <devintr>:
    800042d0:	142027f3          	csrr	a5,scause
    800042d4:	00000513          	li	a0,0
    800042d8:	0007c463          	bltz	a5,800042e0 <devintr+0x10>
    800042dc:	00008067          	ret
    800042e0:	fe010113          	addi	sp,sp,-32
    800042e4:	00813823          	sd	s0,16(sp)
    800042e8:	00113c23          	sd	ra,24(sp)
    800042ec:	00913423          	sd	s1,8(sp)
    800042f0:	02010413          	addi	s0,sp,32
    800042f4:	0ff7f713          	andi	a4,a5,255
    800042f8:	00900693          	li	a3,9
    800042fc:	04d70c63          	beq	a4,a3,80004354 <devintr+0x84>
    80004300:	fff00713          	li	a4,-1
    80004304:	03f71713          	slli	a4,a4,0x3f
    80004308:	00170713          	addi	a4,a4,1
    8000430c:	00e78c63          	beq	a5,a4,80004324 <devintr+0x54>
    80004310:	01813083          	ld	ra,24(sp)
    80004314:	01013403          	ld	s0,16(sp)
    80004318:	00813483          	ld	s1,8(sp)
    8000431c:	02010113          	addi	sp,sp,32
    80004320:	00008067          	ret
    80004324:	00000097          	auipc	ra,0x0
    80004328:	c8c080e7          	jalr	-884(ra) # 80003fb0 <cpuid>
    8000432c:	06050663          	beqz	a0,80004398 <devintr+0xc8>
    80004330:	144027f3          	csrr	a5,sip
    80004334:	ffd7f793          	andi	a5,a5,-3
    80004338:	14479073          	csrw	sip,a5
    8000433c:	01813083          	ld	ra,24(sp)
    80004340:	01013403          	ld	s0,16(sp)
    80004344:	00813483          	ld	s1,8(sp)
    80004348:	00200513          	li	a0,2
    8000434c:	02010113          	addi	sp,sp,32
    80004350:	00008067          	ret
    80004354:	00000097          	auipc	ra,0x0
    80004358:	250080e7          	jalr	592(ra) # 800045a4 <plic_claim>
    8000435c:	00a00793          	li	a5,10
    80004360:	00050493          	mv	s1,a0
    80004364:	06f50663          	beq	a0,a5,800043d0 <devintr+0x100>
    80004368:	00100513          	li	a0,1
    8000436c:	fa0482e3          	beqz	s1,80004310 <devintr+0x40>
    80004370:	00048593          	mv	a1,s1
    80004374:	00002517          	auipc	a0,0x2
    80004378:	ebc50513          	addi	a0,a0,-324 # 80006230 <CONSOLE_STATUS+0x220>
    8000437c:	00000097          	auipc	ra,0x0
    80004380:	66c080e7          	jalr	1644(ra) # 800049e8 <__printf>
    80004384:	00048513          	mv	a0,s1
    80004388:	00000097          	auipc	ra,0x0
    8000438c:	254080e7          	jalr	596(ra) # 800045dc <plic_complete>
    80004390:	00100513          	li	a0,1
    80004394:	f7dff06f          	j	80004310 <devintr+0x40>
    80004398:	00004517          	auipc	a0,0x4
    8000439c:	57850513          	addi	a0,a0,1400 # 80008910 <tickslock>
    800043a0:	00001097          	auipc	ra,0x1
    800043a4:	31c080e7          	jalr	796(ra) # 800056bc <acquire>
    800043a8:	00003717          	auipc	a4,0x3
    800043ac:	38c70713          	addi	a4,a4,908 # 80007734 <ticks>
    800043b0:	00072783          	lw	a5,0(a4)
    800043b4:	00004517          	auipc	a0,0x4
    800043b8:	55c50513          	addi	a0,a0,1372 # 80008910 <tickslock>
    800043bc:	0017879b          	addiw	a5,a5,1
    800043c0:	00f72023          	sw	a5,0(a4)
    800043c4:	00001097          	auipc	ra,0x1
    800043c8:	3c4080e7          	jalr	964(ra) # 80005788 <release>
    800043cc:	f65ff06f          	j	80004330 <devintr+0x60>
    800043d0:	00001097          	auipc	ra,0x1
    800043d4:	f20080e7          	jalr	-224(ra) # 800052f0 <uartintr>
    800043d8:	fadff06f          	j	80004384 <devintr+0xb4>
    800043dc:	0000                	unimp
	...

00000000800043e0 <kernelvec>:
    800043e0:	f0010113          	addi	sp,sp,-256
    800043e4:	00113023          	sd	ra,0(sp)
    800043e8:	00213423          	sd	sp,8(sp)
    800043ec:	00313823          	sd	gp,16(sp)
    800043f0:	00413c23          	sd	tp,24(sp)
    800043f4:	02513023          	sd	t0,32(sp)
    800043f8:	02613423          	sd	t1,40(sp)
    800043fc:	02713823          	sd	t2,48(sp)
    80004400:	02813c23          	sd	s0,56(sp)
    80004404:	04913023          	sd	s1,64(sp)
    80004408:	04a13423          	sd	a0,72(sp)
    8000440c:	04b13823          	sd	a1,80(sp)
    80004410:	04c13c23          	sd	a2,88(sp)
    80004414:	06d13023          	sd	a3,96(sp)
    80004418:	06e13423          	sd	a4,104(sp)
    8000441c:	06f13823          	sd	a5,112(sp)
    80004420:	07013c23          	sd	a6,120(sp)
    80004424:	09113023          	sd	a7,128(sp)
    80004428:	09213423          	sd	s2,136(sp)
    8000442c:	09313823          	sd	s3,144(sp)
    80004430:	09413c23          	sd	s4,152(sp)
    80004434:	0b513023          	sd	s5,160(sp)
    80004438:	0b613423          	sd	s6,168(sp)
    8000443c:	0b713823          	sd	s7,176(sp)
    80004440:	0b813c23          	sd	s8,184(sp)
    80004444:	0d913023          	sd	s9,192(sp)
    80004448:	0da13423          	sd	s10,200(sp)
    8000444c:	0db13823          	sd	s11,208(sp)
    80004450:	0dc13c23          	sd	t3,216(sp)
    80004454:	0fd13023          	sd	t4,224(sp)
    80004458:	0fe13423          	sd	t5,232(sp)
    8000445c:	0ff13823          	sd	t6,240(sp)
    80004460:	cd1ff0ef          	jal	ra,80004130 <kerneltrap>
    80004464:	00013083          	ld	ra,0(sp)
    80004468:	00813103          	ld	sp,8(sp)
    8000446c:	01013183          	ld	gp,16(sp)
    80004470:	02013283          	ld	t0,32(sp)
    80004474:	02813303          	ld	t1,40(sp)
    80004478:	03013383          	ld	t2,48(sp)
    8000447c:	03813403          	ld	s0,56(sp)
    80004480:	04013483          	ld	s1,64(sp)
    80004484:	04813503          	ld	a0,72(sp)
    80004488:	05013583          	ld	a1,80(sp)
    8000448c:	05813603          	ld	a2,88(sp)
    80004490:	06013683          	ld	a3,96(sp)
    80004494:	06813703          	ld	a4,104(sp)
    80004498:	07013783          	ld	a5,112(sp)
    8000449c:	07813803          	ld	a6,120(sp)
    800044a0:	08013883          	ld	a7,128(sp)
    800044a4:	08813903          	ld	s2,136(sp)
    800044a8:	09013983          	ld	s3,144(sp)
    800044ac:	09813a03          	ld	s4,152(sp)
    800044b0:	0a013a83          	ld	s5,160(sp)
    800044b4:	0a813b03          	ld	s6,168(sp)
    800044b8:	0b013b83          	ld	s7,176(sp)
    800044bc:	0b813c03          	ld	s8,184(sp)
    800044c0:	0c013c83          	ld	s9,192(sp)
    800044c4:	0c813d03          	ld	s10,200(sp)
    800044c8:	0d013d83          	ld	s11,208(sp)
    800044cc:	0d813e03          	ld	t3,216(sp)
    800044d0:	0e013e83          	ld	t4,224(sp)
    800044d4:	0e813f03          	ld	t5,232(sp)
    800044d8:	0f013f83          	ld	t6,240(sp)
    800044dc:	10010113          	addi	sp,sp,256
    800044e0:	10200073          	sret
    800044e4:	00000013          	nop
    800044e8:	00000013          	nop
    800044ec:	00000013          	nop

00000000800044f0 <timervec>:
    800044f0:	34051573          	csrrw	a0,mscratch,a0
    800044f4:	00b53023          	sd	a1,0(a0)
    800044f8:	00c53423          	sd	a2,8(a0)
    800044fc:	00d53823          	sd	a3,16(a0)
    80004500:	01853583          	ld	a1,24(a0)
    80004504:	02053603          	ld	a2,32(a0)
    80004508:	0005b683          	ld	a3,0(a1)
    8000450c:	00c686b3          	add	a3,a3,a2
    80004510:	00d5b023          	sd	a3,0(a1)
    80004514:	00200593          	li	a1,2
    80004518:	14459073          	csrw	sip,a1
    8000451c:	01053683          	ld	a3,16(a0)
    80004520:	00853603          	ld	a2,8(a0)
    80004524:	00053583          	ld	a1,0(a0)
    80004528:	34051573          	csrrw	a0,mscratch,a0
    8000452c:	30200073          	mret

0000000080004530 <plicinit>:
    80004530:	ff010113          	addi	sp,sp,-16
    80004534:	00813423          	sd	s0,8(sp)
    80004538:	01010413          	addi	s0,sp,16
    8000453c:	00813403          	ld	s0,8(sp)
    80004540:	0c0007b7          	lui	a5,0xc000
    80004544:	00100713          	li	a4,1
    80004548:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000454c:	00e7a223          	sw	a4,4(a5)
    80004550:	01010113          	addi	sp,sp,16
    80004554:	00008067          	ret

0000000080004558 <plicinithart>:
    80004558:	ff010113          	addi	sp,sp,-16
    8000455c:	00813023          	sd	s0,0(sp)
    80004560:	00113423          	sd	ra,8(sp)
    80004564:	01010413          	addi	s0,sp,16
    80004568:	00000097          	auipc	ra,0x0
    8000456c:	a48080e7          	jalr	-1464(ra) # 80003fb0 <cpuid>
    80004570:	0085171b          	slliw	a4,a0,0x8
    80004574:	0c0027b7          	lui	a5,0xc002
    80004578:	00e787b3          	add	a5,a5,a4
    8000457c:	40200713          	li	a4,1026
    80004580:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80004584:	00813083          	ld	ra,8(sp)
    80004588:	00013403          	ld	s0,0(sp)
    8000458c:	00d5151b          	slliw	a0,a0,0xd
    80004590:	0c2017b7          	lui	a5,0xc201
    80004594:	00a78533          	add	a0,a5,a0
    80004598:	00052023          	sw	zero,0(a0)
    8000459c:	01010113          	addi	sp,sp,16
    800045a0:	00008067          	ret

00000000800045a4 <plic_claim>:
    800045a4:	ff010113          	addi	sp,sp,-16
    800045a8:	00813023          	sd	s0,0(sp)
    800045ac:	00113423          	sd	ra,8(sp)
    800045b0:	01010413          	addi	s0,sp,16
    800045b4:	00000097          	auipc	ra,0x0
    800045b8:	9fc080e7          	jalr	-1540(ra) # 80003fb0 <cpuid>
    800045bc:	00813083          	ld	ra,8(sp)
    800045c0:	00013403          	ld	s0,0(sp)
    800045c4:	00d5151b          	slliw	a0,a0,0xd
    800045c8:	0c2017b7          	lui	a5,0xc201
    800045cc:	00a78533          	add	a0,a5,a0
    800045d0:	00452503          	lw	a0,4(a0)
    800045d4:	01010113          	addi	sp,sp,16
    800045d8:	00008067          	ret

00000000800045dc <plic_complete>:
    800045dc:	fe010113          	addi	sp,sp,-32
    800045e0:	00813823          	sd	s0,16(sp)
    800045e4:	00913423          	sd	s1,8(sp)
    800045e8:	00113c23          	sd	ra,24(sp)
    800045ec:	02010413          	addi	s0,sp,32
    800045f0:	00050493          	mv	s1,a0
    800045f4:	00000097          	auipc	ra,0x0
    800045f8:	9bc080e7          	jalr	-1604(ra) # 80003fb0 <cpuid>
    800045fc:	01813083          	ld	ra,24(sp)
    80004600:	01013403          	ld	s0,16(sp)
    80004604:	00d5179b          	slliw	a5,a0,0xd
    80004608:	0c201737          	lui	a4,0xc201
    8000460c:	00f707b3          	add	a5,a4,a5
    80004610:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004614:	00813483          	ld	s1,8(sp)
    80004618:	02010113          	addi	sp,sp,32
    8000461c:	00008067          	ret

0000000080004620 <consolewrite>:
    80004620:	fb010113          	addi	sp,sp,-80
    80004624:	04813023          	sd	s0,64(sp)
    80004628:	04113423          	sd	ra,72(sp)
    8000462c:	02913c23          	sd	s1,56(sp)
    80004630:	03213823          	sd	s2,48(sp)
    80004634:	03313423          	sd	s3,40(sp)
    80004638:	03413023          	sd	s4,32(sp)
    8000463c:	01513c23          	sd	s5,24(sp)
    80004640:	05010413          	addi	s0,sp,80
    80004644:	06c05c63          	blez	a2,800046bc <consolewrite+0x9c>
    80004648:	00060993          	mv	s3,a2
    8000464c:	00050a13          	mv	s4,a0
    80004650:	00058493          	mv	s1,a1
    80004654:	00000913          	li	s2,0
    80004658:	fff00a93          	li	s5,-1
    8000465c:	01c0006f          	j	80004678 <consolewrite+0x58>
    80004660:	fbf44503          	lbu	a0,-65(s0)
    80004664:	0019091b          	addiw	s2,s2,1
    80004668:	00148493          	addi	s1,s1,1
    8000466c:	00001097          	auipc	ra,0x1
    80004670:	a9c080e7          	jalr	-1380(ra) # 80005108 <uartputc>
    80004674:	03298063          	beq	s3,s2,80004694 <consolewrite+0x74>
    80004678:	00048613          	mv	a2,s1
    8000467c:	00100693          	li	a3,1
    80004680:	000a0593          	mv	a1,s4
    80004684:	fbf40513          	addi	a0,s0,-65
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	9e0080e7          	jalr	-1568(ra) # 80004068 <either_copyin>
    80004690:	fd5518e3          	bne	a0,s5,80004660 <consolewrite+0x40>
    80004694:	04813083          	ld	ra,72(sp)
    80004698:	04013403          	ld	s0,64(sp)
    8000469c:	03813483          	ld	s1,56(sp)
    800046a0:	02813983          	ld	s3,40(sp)
    800046a4:	02013a03          	ld	s4,32(sp)
    800046a8:	01813a83          	ld	s5,24(sp)
    800046ac:	00090513          	mv	a0,s2
    800046b0:	03013903          	ld	s2,48(sp)
    800046b4:	05010113          	addi	sp,sp,80
    800046b8:	00008067          	ret
    800046bc:	00000913          	li	s2,0
    800046c0:	fd5ff06f          	j	80004694 <consolewrite+0x74>

00000000800046c4 <consoleread>:
    800046c4:	f9010113          	addi	sp,sp,-112
    800046c8:	06813023          	sd	s0,96(sp)
    800046cc:	04913c23          	sd	s1,88(sp)
    800046d0:	05213823          	sd	s2,80(sp)
    800046d4:	05313423          	sd	s3,72(sp)
    800046d8:	05413023          	sd	s4,64(sp)
    800046dc:	03513c23          	sd	s5,56(sp)
    800046e0:	03613823          	sd	s6,48(sp)
    800046e4:	03713423          	sd	s7,40(sp)
    800046e8:	03813023          	sd	s8,32(sp)
    800046ec:	06113423          	sd	ra,104(sp)
    800046f0:	01913c23          	sd	s9,24(sp)
    800046f4:	07010413          	addi	s0,sp,112
    800046f8:	00060b93          	mv	s7,a2
    800046fc:	00050913          	mv	s2,a0
    80004700:	00058c13          	mv	s8,a1
    80004704:	00060b1b          	sext.w	s6,a2
    80004708:	00004497          	auipc	s1,0x4
    8000470c:	23048493          	addi	s1,s1,560 # 80008938 <cons>
    80004710:	00400993          	li	s3,4
    80004714:	fff00a13          	li	s4,-1
    80004718:	00a00a93          	li	s5,10
    8000471c:	05705e63          	blez	s7,80004778 <consoleread+0xb4>
    80004720:	09c4a703          	lw	a4,156(s1)
    80004724:	0984a783          	lw	a5,152(s1)
    80004728:	0007071b          	sext.w	a4,a4
    8000472c:	08e78463          	beq	a5,a4,800047b4 <consoleread+0xf0>
    80004730:	07f7f713          	andi	a4,a5,127
    80004734:	00e48733          	add	a4,s1,a4
    80004738:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000473c:	0017869b          	addiw	a3,a5,1
    80004740:	08d4ac23          	sw	a3,152(s1)
    80004744:	00070c9b          	sext.w	s9,a4
    80004748:	0b370663          	beq	a4,s3,800047f4 <consoleread+0x130>
    8000474c:	00100693          	li	a3,1
    80004750:	f9f40613          	addi	a2,s0,-97
    80004754:	000c0593          	mv	a1,s8
    80004758:	00090513          	mv	a0,s2
    8000475c:	f8e40fa3          	sb	a4,-97(s0)
    80004760:	00000097          	auipc	ra,0x0
    80004764:	8bc080e7          	jalr	-1860(ra) # 8000401c <either_copyout>
    80004768:	01450863          	beq	a0,s4,80004778 <consoleread+0xb4>
    8000476c:	001c0c13          	addi	s8,s8,1
    80004770:	fffb8b9b          	addiw	s7,s7,-1
    80004774:	fb5c94e3          	bne	s9,s5,8000471c <consoleread+0x58>
    80004778:	000b851b          	sext.w	a0,s7
    8000477c:	06813083          	ld	ra,104(sp)
    80004780:	06013403          	ld	s0,96(sp)
    80004784:	05813483          	ld	s1,88(sp)
    80004788:	05013903          	ld	s2,80(sp)
    8000478c:	04813983          	ld	s3,72(sp)
    80004790:	04013a03          	ld	s4,64(sp)
    80004794:	03813a83          	ld	s5,56(sp)
    80004798:	02813b83          	ld	s7,40(sp)
    8000479c:	02013c03          	ld	s8,32(sp)
    800047a0:	01813c83          	ld	s9,24(sp)
    800047a4:	40ab053b          	subw	a0,s6,a0
    800047a8:	03013b03          	ld	s6,48(sp)
    800047ac:	07010113          	addi	sp,sp,112
    800047b0:	00008067          	ret
    800047b4:	00001097          	auipc	ra,0x1
    800047b8:	1d8080e7          	jalr	472(ra) # 8000598c <push_on>
    800047bc:	0984a703          	lw	a4,152(s1)
    800047c0:	09c4a783          	lw	a5,156(s1)
    800047c4:	0007879b          	sext.w	a5,a5
    800047c8:	fef70ce3          	beq	a4,a5,800047c0 <consoleread+0xfc>
    800047cc:	00001097          	auipc	ra,0x1
    800047d0:	234080e7          	jalr	564(ra) # 80005a00 <pop_on>
    800047d4:	0984a783          	lw	a5,152(s1)
    800047d8:	07f7f713          	andi	a4,a5,127
    800047dc:	00e48733          	add	a4,s1,a4
    800047e0:	01874703          	lbu	a4,24(a4)
    800047e4:	0017869b          	addiw	a3,a5,1
    800047e8:	08d4ac23          	sw	a3,152(s1)
    800047ec:	00070c9b          	sext.w	s9,a4
    800047f0:	f5371ee3          	bne	a4,s3,8000474c <consoleread+0x88>
    800047f4:	000b851b          	sext.w	a0,s7
    800047f8:	f96bf2e3          	bgeu	s7,s6,8000477c <consoleread+0xb8>
    800047fc:	08f4ac23          	sw	a5,152(s1)
    80004800:	f7dff06f          	j	8000477c <consoleread+0xb8>

0000000080004804 <consputc>:
    80004804:	10000793          	li	a5,256
    80004808:	00f50663          	beq	a0,a5,80004814 <consputc+0x10>
    8000480c:	00001317          	auipc	t1,0x1
    80004810:	9f430067          	jr	-1548(t1) # 80005200 <uartputc_sync>
    80004814:	ff010113          	addi	sp,sp,-16
    80004818:	00113423          	sd	ra,8(sp)
    8000481c:	00813023          	sd	s0,0(sp)
    80004820:	01010413          	addi	s0,sp,16
    80004824:	00800513          	li	a0,8
    80004828:	00001097          	auipc	ra,0x1
    8000482c:	9d8080e7          	jalr	-1576(ra) # 80005200 <uartputc_sync>
    80004830:	02000513          	li	a0,32
    80004834:	00001097          	auipc	ra,0x1
    80004838:	9cc080e7          	jalr	-1588(ra) # 80005200 <uartputc_sync>
    8000483c:	00013403          	ld	s0,0(sp)
    80004840:	00813083          	ld	ra,8(sp)
    80004844:	00800513          	li	a0,8
    80004848:	01010113          	addi	sp,sp,16
    8000484c:	00001317          	auipc	t1,0x1
    80004850:	9b430067          	jr	-1612(t1) # 80005200 <uartputc_sync>

0000000080004854 <consoleintr>:
    80004854:	fe010113          	addi	sp,sp,-32
    80004858:	00813823          	sd	s0,16(sp)
    8000485c:	00913423          	sd	s1,8(sp)
    80004860:	01213023          	sd	s2,0(sp)
    80004864:	00113c23          	sd	ra,24(sp)
    80004868:	02010413          	addi	s0,sp,32
    8000486c:	00004917          	auipc	s2,0x4
    80004870:	0cc90913          	addi	s2,s2,204 # 80008938 <cons>
    80004874:	00050493          	mv	s1,a0
    80004878:	00090513          	mv	a0,s2
    8000487c:	00001097          	auipc	ra,0x1
    80004880:	e40080e7          	jalr	-448(ra) # 800056bc <acquire>
    80004884:	02048c63          	beqz	s1,800048bc <consoleintr+0x68>
    80004888:	0a092783          	lw	a5,160(s2)
    8000488c:	09892703          	lw	a4,152(s2)
    80004890:	07f00693          	li	a3,127
    80004894:	40e7873b          	subw	a4,a5,a4
    80004898:	02e6e263          	bltu	a3,a4,800048bc <consoleintr+0x68>
    8000489c:	00d00713          	li	a4,13
    800048a0:	04e48063          	beq	s1,a4,800048e0 <consoleintr+0x8c>
    800048a4:	07f7f713          	andi	a4,a5,127
    800048a8:	00e90733          	add	a4,s2,a4
    800048ac:	0017879b          	addiw	a5,a5,1
    800048b0:	0af92023          	sw	a5,160(s2)
    800048b4:	00970c23          	sb	s1,24(a4)
    800048b8:	08f92e23          	sw	a5,156(s2)
    800048bc:	01013403          	ld	s0,16(sp)
    800048c0:	01813083          	ld	ra,24(sp)
    800048c4:	00813483          	ld	s1,8(sp)
    800048c8:	00013903          	ld	s2,0(sp)
    800048cc:	00004517          	auipc	a0,0x4
    800048d0:	06c50513          	addi	a0,a0,108 # 80008938 <cons>
    800048d4:	02010113          	addi	sp,sp,32
    800048d8:	00001317          	auipc	t1,0x1
    800048dc:	eb030067          	jr	-336(t1) # 80005788 <release>
    800048e0:	00a00493          	li	s1,10
    800048e4:	fc1ff06f          	j	800048a4 <consoleintr+0x50>

00000000800048e8 <consoleinit>:
    800048e8:	fe010113          	addi	sp,sp,-32
    800048ec:	00113c23          	sd	ra,24(sp)
    800048f0:	00813823          	sd	s0,16(sp)
    800048f4:	00913423          	sd	s1,8(sp)
    800048f8:	02010413          	addi	s0,sp,32
    800048fc:	00004497          	auipc	s1,0x4
    80004900:	03c48493          	addi	s1,s1,60 # 80008938 <cons>
    80004904:	00048513          	mv	a0,s1
    80004908:	00002597          	auipc	a1,0x2
    8000490c:	98058593          	addi	a1,a1,-1664 # 80006288 <CONSOLE_STATUS+0x278>
    80004910:	00001097          	auipc	ra,0x1
    80004914:	d88080e7          	jalr	-632(ra) # 80005698 <initlock>
    80004918:	00000097          	auipc	ra,0x0
    8000491c:	7ac080e7          	jalr	1964(ra) # 800050c4 <uartinit>
    80004920:	01813083          	ld	ra,24(sp)
    80004924:	01013403          	ld	s0,16(sp)
    80004928:	00000797          	auipc	a5,0x0
    8000492c:	d9c78793          	addi	a5,a5,-612 # 800046c4 <consoleread>
    80004930:	0af4bc23          	sd	a5,184(s1)
    80004934:	00000797          	auipc	a5,0x0
    80004938:	cec78793          	addi	a5,a5,-788 # 80004620 <consolewrite>
    8000493c:	0cf4b023          	sd	a5,192(s1)
    80004940:	00813483          	ld	s1,8(sp)
    80004944:	02010113          	addi	sp,sp,32
    80004948:	00008067          	ret

000000008000494c <console_read>:
    8000494c:	ff010113          	addi	sp,sp,-16
    80004950:	00813423          	sd	s0,8(sp)
    80004954:	01010413          	addi	s0,sp,16
    80004958:	00813403          	ld	s0,8(sp)
    8000495c:	00004317          	auipc	t1,0x4
    80004960:	09433303          	ld	t1,148(t1) # 800089f0 <devsw+0x10>
    80004964:	01010113          	addi	sp,sp,16
    80004968:	00030067          	jr	t1

000000008000496c <console_write>:
    8000496c:	ff010113          	addi	sp,sp,-16
    80004970:	00813423          	sd	s0,8(sp)
    80004974:	01010413          	addi	s0,sp,16
    80004978:	00813403          	ld	s0,8(sp)
    8000497c:	00004317          	auipc	t1,0x4
    80004980:	07c33303          	ld	t1,124(t1) # 800089f8 <devsw+0x18>
    80004984:	01010113          	addi	sp,sp,16
    80004988:	00030067          	jr	t1

000000008000498c <panic>:
    8000498c:	fe010113          	addi	sp,sp,-32
    80004990:	00113c23          	sd	ra,24(sp)
    80004994:	00813823          	sd	s0,16(sp)
    80004998:	00913423          	sd	s1,8(sp)
    8000499c:	02010413          	addi	s0,sp,32
    800049a0:	00050493          	mv	s1,a0
    800049a4:	00002517          	auipc	a0,0x2
    800049a8:	8ec50513          	addi	a0,a0,-1812 # 80006290 <CONSOLE_STATUS+0x280>
    800049ac:	00004797          	auipc	a5,0x4
    800049b0:	0e07a623          	sw	zero,236(a5) # 80008a98 <pr+0x18>
    800049b4:	00000097          	auipc	ra,0x0
    800049b8:	034080e7          	jalr	52(ra) # 800049e8 <__printf>
    800049bc:	00048513          	mv	a0,s1
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	028080e7          	jalr	40(ra) # 800049e8 <__printf>
    800049c8:	00002517          	auipc	a0,0x2
    800049cc:	8a850513          	addi	a0,a0,-1880 # 80006270 <CONSOLE_STATUS+0x260>
    800049d0:	00000097          	auipc	ra,0x0
    800049d4:	018080e7          	jalr	24(ra) # 800049e8 <__printf>
    800049d8:	00100793          	li	a5,1
    800049dc:	00003717          	auipc	a4,0x3
    800049e0:	d4f72e23          	sw	a5,-676(a4) # 80007738 <panicked>
    800049e4:	0000006f          	j	800049e4 <panic+0x58>

00000000800049e8 <__printf>:
    800049e8:	f3010113          	addi	sp,sp,-208
    800049ec:	08813023          	sd	s0,128(sp)
    800049f0:	07313423          	sd	s3,104(sp)
    800049f4:	09010413          	addi	s0,sp,144
    800049f8:	05813023          	sd	s8,64(sp)
    800049fc:	08113423          	sd	ra,136(sp)
    80004a00:	06913c23          	sd	s1,120(sp)
    80004a04:	07213823          	sd	s2,112(sp)
    80004a08:	07413023          	sd	s4,96(sp)
    80004a0c:	05513c23          	sd	s5,88(sp)
    80004a10:	05613823          	sd	s6,80(sp)
    80004a14:	05713423          	sd	s7,72(sp)
    80004a18:	03913c23          	sd	s9,56(sp)
    80004a1c:	03a13823          	sd	s10,48(sp)
    80004a20:	03b13423          	sd	s11,40(sp)
    80004a24:	00004317          	auipc	t1,0x4
    80004a28:	05c30313          	addi	t1,t1,92 # 80008a80 <pr>
    80004a2c:	01832c03          	lw	s8,24(t1)
    80004a30:	00b43423          	sd	a1,8(s0)
    80004a34:	00c43823          	sd	a2,16(s0)
    80004a38:	00d43c23          	sd	a3,24(s0)
    80004a3c:	02e43023          	sd	a4,32(s0)
    80004a40:	02f43423          	sd	a5,40(s0)
    80004a44:	03043823          	sd	a6,48(s0)
    80004a48:	03143c23          	sd	a7,56(s0)
    80004a4c:	00050993          	mv	s3,a0
    80004a50:	4a0c1663          	bnez	s8,80004efc <__printf+0x514>
    80004a54:	60098c63          	beqz	s3,8000506c <__printf+0x684>
    80004a58:	0009c503          	lbu	a0,0(s3)
    80004a5c:	00840793          	addi	a5,s0,8
    80004a60:	f6f43c23          	sd	a5,-136(s0)
    80004a64:	00000493          	li	s1,0
    80004a68:	22050063          	beqz	a0,80004c88 <__printf+0x2a0>
    80004a6c:	00002a37          	lui	s4,0x2
    80004a70:	00018ab7          	lui	s5,0x18
    80004a74:	000f4b37          	lui	s6,0xf4
    80004a78:	00989bb7          	lui	s7,0x989
    80004a7c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004a80:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004a84:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004a88:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80004a8c:	00148c9b          	addiw	s9,s1,1
    80004a90:	02500793          	li	a5,37
    80004a94:	01998933          	add	s2,s3,s9
    80004a98:	38f51263          	bne	a0,a5,80004e1c <__printf+0x434>
    80004a9c:	00094783          	lbu	a5,0(s2)
    80004aa0:	00078c9b          	sext.w	s9,a5
    80004aa4:	1e078263          	beqz	a5,80004c88 <__printf+0x2a0>
    80004aa8:	0024849b          	addiw	s1,s1,2
    80004aac:	07000713          	li	a4,112
    80004ab0:	00998933          	add	s2,s3,s1
    80004ab4:	38e78a63          	beq	a5,a4,80004e48 <__printf+0x460>
    80004ab8:	20f76863          	bltu	a4,a5,80004cc8 <__printf+0x2e0>
    80004abc:	42a78863          	beq	a5,a0,80004eec <__printf+0x504>
    80004ac0:	06400713          	li	a4,100
    80004ac4:	40e79663          	bne	a5,a4,80004ed0 <__printf+0x4e8>
    80004ac8:	f7843783          	ld	a5,-136(s0)
    80004acc:	0007a603          	lw	a2,0(a5)
    80004ad0:	00878793          	addi	a5,a5,8
    80004ad4:	f6f43c23          	sd	a5,-136(s0)
    80004ad8:	42064a63          	bltz	a2,80004f0c <__printf+0x524>
    80004adc:	00a00713          	li	a4,10
    80004ae0:	02e677bb          	remuw	a5,a2,a4
    80004ae4:	00001d97          	auipc	s11,0x1
    80004ae8:	7d4d8d93          	addi	s11,s11,2004 # 800062b8 <digits>
    80004aec:	00900593          	li	a1,9
    80004af0:	0006051b          	sext.w	a0,a2
    80004af4:	00000c93          	li	s9,0
    80004af8:	02079793          	slli	a5,a5,0x20
    80004afc:	0207d793          	srli	a5,a5,0x20
    80004b00:	00fd87b3          	add	a5,s11,a5
    80004b04:	0007c783          	lbu	a5,0(a5)
    80004b08:	02e656bb          	divuw	a3,a2,a4
    80004b0c:	f8f40023          	sb	a5,-128(s0)
    80004b10:	14c5d863          	bge	a1,a2,80004c60 <__printf+0x278>
    80004b14:	06300593          	li	a1,99
    80004b18:	00100c93          	li	s9,1
    80004b1c:	02e6f7bb          	remuw	a5,a3,a4
    80004b20:	02079793          	slli	a5,a5,0x20
    80004b24:	0207d793          	srli	a5,a5,0x20
    80004b28:	00fd87b3          	add	a5,s11,a5
    80004b2c:	0007c783          	lbu	a5,0(a5)
    80004b30:	02e6d73b          	divuw	a4,a3,a4
    80004b34:	f8f400a3          	sb	a5,-127(s0)
    80004b38:	12a5f463          	bgeu	a1,a0,80004c60 <__printf+0x278>
    80004b3c:	00a00693          	li	a3,10
    80004b40:	00900593          	li	a1,9
    80004b44:	02d777bb          	remuw	a5,a4,a3
    80004b48:	02079793          	slli	a5,a5,0x20
    80004b4c:	0207d793          	srli	a5,a5,0x20
    80004b50:	00fd87b3          	add	a5,s11,a5
    80004b54:	0007c503          	lbu	a0,0(a5)
    80004b58:	02d757bb          	divuw	a5,a4,a3
    80004b5c:	f8a40123          	sb	a0,-126(s0)
    80004b60:	48e5f263          	bgeu	a1,a4,80004fe4 <__printf+0x5fc>
    80004b64:	06300513          	li	a0,99
    80004b68:	02d7f5bb          	remuw	a1,a5,a3
    80004b6c:	02059593          	slli	a1,a1,0x20
    80004b70:	0205d593          	srli	a1,a1,0x20
    80004b74:	00bd85b3          	add	a1,s11,a1
    80004b78:	0005c583          	lbu	a1,0(a1)
    80004b7c:	02d7d7bb          	divuw	a5,a5,a3
    80004b80:	f8b401a3          	sb	a1,-125(s0)
    80004b84:	48e57263          	bgeu	a0,a4,80005008 <__printf+0x620>
    80004b88:	3e700513          	li	a0,999
    80004b8c:	02d7f5bb          	remuw	a1,a5,a3
    80004b90:	02059593          	slli	a1,a1,0x20
    80004b94:	0205d593          	srli	a1,a1,0x20
    80004b98:	00bd85b3          	add	a1,s11,a1
    80004b9c:	0005c583          	lbu	a1,0(a1)
    80004ba0:	02d7d7bb          	divuw	a5,a5,a3
    80004ba4:	f8b40223          	sb	a1,-124(s0)
    80004ba8:	46e57663          	bgeu	a0,a4,80005014 <__printf+0x62c>
    80004bac:	02d7f5bb          	remuw	a1,a5,a3
    80004bb0:	02059593          	slli	a1,a1,0x20
    80004bb4:	0205d593          	srli	a1,a1,0x20
    80004bb8:	00bd85b3          	add	a1,s11,a1
    80004bbc:	0005c583          	lbu	a1,0(a1)
    80004bc0:	02d7d7bb          	divuw	a5,a5,a3
    80004bc4:	f8b402a3          	sb	a1,-123(s0)
    80004bc8:	46ea7863          	bgeu	s4,a4,80005038 <__printf+0x650>
    80004bcc:	02d7f5bb          	remuw	a1,a5,a3
    80004bd0:	02059593          	slli	a1,a1,0x20
    80004bd4:	0205d593          	srli	a1,a1,0x20
    80004bd8:	00bd85b3          	add	a1,s11,a1
    80004bdc:	0005c583          	lbu	a1,0(a1)
    80004be0:	02d7d7bb          	divuw	a5,a5,a3
    80004be4:	f8b40323          	sb	a1,-122(s0)
    80004be8:	3eeaf863          	bgeu	s5,a4,80004fd8 <__printf+0x5f0>
    80004bec:	02d7f5bb          	remuw	a1,a5,a3
    80004bf0:	02059593          	slli	a1,a1,0x20
    80004bf4:	0205d593          	srli	a1,a1,0x20
    80004bf8:	00bd85b3          	add	a1,s11,a1
    80004bfc:	0005c583          	lbu	a1,0(a1)
    80004c00:	02d7d7bb          	divuw	a5,a5,a3
    80004c04:	f8b403a3          	sb	a1,-121(s0)
    80004c08:	42eb7e63          	bgeu	s6,a4,80005044 <__printf+0x65c>
    80004c0c:	02d7f5bb          	remuw	a1,a5,a3
    80004c10:	02059593          	slli	a1,a1,0x20
    80004c14:	0205d593          	srli	a1,a1,0x20
    80004c18:	00bd85b3          	add	a1,s11,a1
    80004c1c:	0005c583          	lbu	a1,0(a1)
    80004c20:	02d7d7bb          	divuw	a5,a5,a3
    80004c24:	f8b40423          	sb	a1,-120(s0)
    80004c28:	42ebfc63          	bgeu	s7,a4,80005060 <__printf+0x678>
    80004c2c:	02079793          	slli	a5,a5,0x20
    80004c30:	0207d793          	srli	a5,a5,0x20
    80004c34:	00fd8db3          	add	s11,s11,a5
    80004c38:	000dc703          	lbu	a4,0(s11)
    80004c3c:	00a00793          	li	a5,10
    80004c40:	00900c93          	li	s9,9
    80004c44:	f8e404a3          	sb	a4,-119(s0)
    80004c48:	00065c63          	bgez	a2,80004c60 <__printf+0x278>
    80004c4c:	f9040713          	addi	a4,s0,-112
    80004c50:	00f70733          	add	a4,a4,a5
    80004c54:	02d00693          	li	a3,45
    80004c58:	fed70823          	sb	a3,-16(a4)
    80004c5c:	00078c93          	mv	s9,a5
    80004c60:	f8040793          	addi	a5,s0,-128
    80004c64:	01978cb3          	add	s9,a5,s9
    80004c68:	f7f40d13          	addi	s10,s0,-129
    80004c6c:	000cc503          	lbu	a0,0(s9)
    80004c70:	fffc8c93          	addi	s9,s9,-1
    80004c74:	00000097          	auipc	ra,0x0
    80004c78:	b90080e7          	jalr	-1136(ra) # 80004804 <consputc>
    80004c7c:	ffac98e3          	bne	s9,s10,80004c6c <__printf+0x284>
    80004c80:	00094503          	lbu	a0,0(s2)
    80004c84:	e00514e3          	bnez	a0,80004a8c <__printf+0xa4>
    80004c88:	1a0c1663          	bnez	s8,80004e34 <__printf+0x44c>
    80004c8c:	08813083          	ld	ra,136(sp)
    80004c90:	08013403          	ld	s0,128(sp)
    80004c94:	07813483          	ld	s1,120(sp)
    80004c98:	07013903          	ld	s2,112(sp)
    80004c9c:	06813983          	ld	s3,104(sp)
    80004ca0:	06013a03          	ld	s4,96(sp)
    80004ca4:	05813a83          	ld	s5,88(sp)
    80004ca8:	05013b03          	ld	s6,80(sp)
    80004cac:	04813b83          	ld	s7,72(sp)
    80004cb0:	04013c03          	ld	s8,64(sp)
    80004cb4:	03813c83          	ld	s9,56(sp)
    80004cb8:	03013d03          	ld	s10,48(sp)
    80004cbc:	02813d83          	ld	s11,40(sp)
    80004cc0:	0d010113          	addi	sp,sp,208
    80004cc4:	00008067          	ret
    80004cc8:	07300713          	li	a4,115
    80004ccc:	1ce78a63          	beq	a5,a4,80004ea0 <__printf+0x4b8>
    80004cd0:	07800713          	li	a4,120
    80004cd4:	1ee79e63          	bne	a5,a4,80004ed0 <__printf+0x4e8>
    80004cd8:	f7843783          	ld	a5,-136(s0)
    80004cdc:	0007a703          	lw	a4,0(a5)
    80004ce0:	00878793          	addi	a5,a5,8
    80004ce4:	f6f43c23          	sd	a5,-136(s0)
    80004ce8:	28074263          	bltz	a4,80004f6c <__printf+0x584>
    80004cec:	00001d97          	auipc	s11,0x1
    80004cf0:	5ccd8d93          	addi	s11,s11,1484 # 800062b8 <digits>
    80004cf4:	00f77793          	andi	a5,a4,15
    80004cf8:	00fd87b3          	add	a5,s11,a5
    80004cfc:	0007c683          	lbu	a3,0(a5)
    80004d00:	00f00613          	li	a2,15
    80004d04:	0007079b          	sext.w	a5,a4
    80004d08:	f8d40023          	sb	a3,-128(s0)
    80004d0c:	0047559b          	srliw	a1,a4,0x4
    80004d10:	0047569b          	srliw	a3,a4,0x4
    80004d14:	00000c93          	li	s9,0
    80004d18:	0ee65063          	bge	a2,a4,80004df8 <__printf+0x410>
    80004d1c:	00f6f693          	andi	a3,a3,15
    80004d20:	00dd86b3          	add	a3,s11,a3
    80004d24:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004d28:	0087d79b          	srliw	a5,a5,0x8
    80004d2c:	00100c93          	li	s9,1
    80004d30:	f8d400a3          	sb	a3,-127(s0)
    80004d34:	0cb67263          	bgeu	a2,a1,80004df8 <__printf+0x410>
    80004d38:	00f7f693          	andi	a3,a5,15
    80004d3c:	00dd86b3          	add	a3,s11,a3
    80004d40:	0006c583          	lbu	a1,0(a3)
    80004d44:	00f00613          	li	a2,15
    80004d48:	0047d69b          	srliw	a3,a5,0x4
    80004d4c:	f8b40123          	sb	a1,-126(s0)
    80004d50:	0047d593          	srli	a1,a5,0x4
    80004d54:	28f67e63          	bgeu	a2,a5,80004ff0 <__printf+0x608>
    80004d58:	00f6f693          	andi	a3,a3,15
    80004d5c:	00dd86b3          	add	a3,s11,a3
    80004d60:	0006c503          	lbu	a0,0(a3)
    80004d64:	0087d813          	srli	a6,a5,0x8
    80004d68:	0087d69b          	srliw	a3,a5,0x8
    80004d6c:	f8a401a3          	sb	a0,-125(s0)
    80004d70:	28b67663          	bgeu	a2,a1,80004ffc <__printf+0x614>
    80004d74:	00f6f693          	andi	a3,a3,15
    80004d78:	00dd86b3          	add	a3,s11,a3
    80004d7c:	0006c583          	lbu	a1,0(a3)
    80004d80:	00c7d513          	srli	a0,a5,0xc
    80004d84:	00c7d69b          	srliw	a3,a5,0xc
    80004d88:	f8b40223          	sb	a1,-124(s0)
    80004d8c:	29067a63          	bgeu	a2,a6,80005020 <__printf+0x638>
    80004d90:	00f6f693          	andi	a3,a3,15
    80004d94:	00dd86b3          	add	a3,s11,a3
    80004d98:	0006c583          	lbu	a1,0(a3)
    80004d9c:	0107d813          	srli	a6,a5,0x10
    80004da0:	0107d69b          	srliw	a3,a5,0x10
    80004da4:	f8b402a3          	sb	a1,-123(s0)
    80004da8:	28a67263          	bgeu	a2,a0,8000502c <__printf+0x644>
    80004dac:	00f6f693          	andi	a3,a3,15
    80004db0:	00dd86b3          	add	a3,s11,a3
    80004db4:	0006c683          	lbu	a3,0(a3)
    80004db8:	0147d79b          	srliw	a5,a5,0x14
    80004dbc:	f8d40323          	sb	a3,-122(s0)
    80004dc0:	21067663          	bgeu	a2,a6,80004fcc <__printf+0x5e4>
    80004dc4:	02079793          	slli	a5,a5,0x20
    80004dc8:	0207d793          	srli	a5,a5,0x20
    80004dcc:	00fd8db3          	add	s11,s11,a5
    80004dd0:	000dc683          	lbu	a3,0(s11)
    80004dd4:	00800793          	li	a5,8
    80004dd8:	00700c93          	li	s9,7
    80004ddc:	f8d403a3          	sb	a3,-121(s0)
    80004de0:	00075c63          	bgez	a4,80004df8 <__printf+0x410>
    80004de4:	f9040713          	addi	a4,s0,-112
    80004de8:	00f70733          	add	a4,a4,a5
    80004dec:	02d00693          	li	a3,45
    80004df0:	fed70823          	sb	a3,-16(a4)
    80004df4:	00078c93          	mv	s9,a5
    80004df8:	f8040793          	addi	a5,s0,-128
    80004dfc:	01978cb3          	add	s9,a5,s9
    80004e00:	f7f40d13          	addi	s10,s0,-129
    80004e04:	000cc503          	lbu	a0,0(s9)
    80004e08:	fffc8c93          	addi	s9,s9,-1
    80004e0c:	00000097          	auipc	ra,0x0
    80004e10:	9f8080e7          	jalr	-1544(ra) # 80004804 <consputc>
    80004e14:	ff9d18e3          	bne	s10,s9,80004e04 <__printf+0x41c>
    80004e18:	0100006f          	j	80004e28 <__printf+0x440>
    80004e1c:	00000097          	auipc	ra,0x0
    80004e20:	9e8080e7          	jalr	-1560(ra) # 80004804 <consputc>
    80004e24:	000c8493          	mv	s1,s9
    80004e28:	00094503          	lbu	a0,0(s2)
    80004e2c:	c60510e3          	bnez	a0,80004a8c <__printf+0xa4>
    80004e30:	e40c0ee3          	beqz	s8,80004c8c <__printf+0x2a4>
    80004e34:	00004517          	auipc	a0,0x4
    80004e38:	c4c50513          	addi	a0,a0,-948 # 80008a80 <pr>
    80004e3c:	00001097          	auipc	ra,0x1
    80004e40:	94c080e7          	jalr	-1716(ra) # 80005788 <release>
    80004e44:	e49ff06f          	j	80004c8c <__printf+0x2a4>
    80004e48:	f7843783          	ld	a5,-136(s0)
    80004e4c:	03000513          	li	a0,48
    80004e50:	01000d13          	li	s10,16
    80004e54:	00878713          	addi	a4,a5,8
    80004e58:	0007bc83          	ld	s9,0(a5)
    80004e5c:	f6e43c23          	sd	a4,-136(s0)
    80004e60:	00000097          	auipc	ra,0x0
    80004e64:	9a4080e7          	jalr	-1628(ra) # 80004804 <consputc>
    80004e68:	07800513          	li	a0,120
    80004e6c:	00000097          	auipc	ra,0x0
    80004e70:	998080e7          	jalr	-1640(ra) # 80004804 <consputc>
    80004e74:	00001d97          	auipc	s11,0x1
    80004e78:	444d8d93          	addi	s11,s11,1092 # 800062b8 <digits>
    80004e7c:	03ccd793          	srli	a5,s9,0x3c
    80004e80:	00fd87b3          	add	a5,s11,a5
    80004e84:	0007c503          	lbu	a0,0(a5)
    80004e88:	fffd0d1b          	addiw	s10,s10,-1
    80004e8c:	004c9c93          	slli	s9,s9,0x4
    80004e90:	00000097          	auipc	ra,0x0
    80004e94:	974080e7          	jalr	-1676(ra) # 80004804 <consputc>
    80004e98:	fe0d12e3          	bnez	s10,80004e7c <__printf+0x494>
    80004e9c:	f8dff06f          	j	80004e28 <__printf+0x440>
    80004ea0:	f7843783          	ld	a5,-136(s0)
    80004ea4:	0007bc83          	ld	s9,0(a5)
    80004ea8:	00878793          	addi	a5,a5,8
    80004eac:	f6f43c23          	sd	a5,-136(s0)
    80004eb0:	000c9a63          	bnez	s9,80004ec4 <__printf+0x4dc>
    80004eb4:	1080006f          	j	80004fbc <__printf+0x5d4>
    80004eb8:	001c8c93          	addi	s9,s9,1
    80004ebc:	00000097          	auipc	ra,0x0
    80004ec0:	948080e7          	jalr	-1720(ra) # 80004804 <consputc>
    80004ec4:	000cc503          	lbu	a0,0(s9)
    80004ec8:	fe0518e3          	bnez	a0,80004eb8 <__printf+0x4d0>
    80004ecc:	f5dff06f          	j	80004e28 <__printf+0x440>
    80004ed0:	02500513          	li	a0,37
    80004ed4:	00000097          	auipc	ra,0x0
    80004ed8:	930080e7          	jalr	-1744(ra) # 80004804 <consputc>
    80004edc:	000c8513          	mv	a0,s9
    80004ee0:	00000097          	auipc	ra,0x0
    80004ee4:	924080e7          	jalr	-1756(ra) # 80004804 <consputc>
    80004ee8:	f41ff06f          	j	80004e28 <__printf+0x440>
    80004eec:	02500513          	li	a0,37
    80004ef0:	00000097          	auipc	ra,0x0
    80004ef4:	914080e7          	jalr	-1772(ra) # 80004804 <consputc>
    80004ef8:	f31ff06f          	j	80004e28 <__printf+0x440>
    80004efc:	00030513          	mv	a0,t1
    80004f00:	00000097          	auipc	ra,0x0
    80004f04:	7bc080e7          	jalr	1980(ra) # 800056bc <acquire>
    80004f08:	b4dff06f          	j	80004a54 <__printf+0x6c>
    80004f0c:	40c0053b          	negw	a0,a2
    80004f10:	00a00713          	li	a4,10
    80004f14:	02e576bb          	remuw	a3,a0,a4
    80004f18:	00001d97          	auipc	s11,0x1
    80004f1c:	3a0d8d93          	addi	s11,s11,928 # 800062b8 <digits>
    80004f20:	ff700593          	li	a1,-9
    80004f24:	02069693          	slli	a3,a3,0x20
    80004f28:	0206d693          	srli	a3,a3,0x20
    80004f2c:	00dd86b3          	add	a3,s11,a3
    80004f30:	0006c683          	lbu	a3,0(a3)
    80004f34:	02e557bb          	divuw	a5,a0,a4
    80004f38:	f8d40023          	sb	a3,-128(s0)
    80004f3c:	10b65e63          	bge	a2,a1,80005058 <__printf+0x670>
    80004f40:	06300593          	li	a1,99
    80004f44:	02e7f6bb          	remuw	a3,a5,a4
    80004f48:	02069693          	slli	a3,a3,0x20
    80004f4c:	0206d693          	srli	a3,a3,0x20
    80004f50:	00dd86b3          	add	a3,s11,a3
    80004f54:	0006c683          	lbu	a3,0(a3)
    80004f58:	02e7d73b          	divuw	a4,a5,a4
    80004f5c:	00200793          	li	a5,2
    80004f60:	f8d400a3          	sb	a3,-127(s0)
    80004f64:	bca5ece3          	bltu	a1,a0,80004b3c <__printf+0x154>
    80004f68:	ce5ff06f          	j	80004c4c <__printf+0x264>
    80004f6c:	40e007bb          	negw	a5,a4
    80004f70:	00001d97          	auipc	s11,0x1
    80004f74:	348d8d93          	addi	s11,s11,840 # 800062b8 <digits>
    80004f78:	00f7f693          	andi	a3,a5,15
    80004f7c:	00dd86b3          	add	a3,s11,a3
    80004f80:	0006c583          	lbu	a1,0(a3)
    80004f84:	ff100613          	li	a2,-15
    80004f88:	0047d69b          	srliw	a3,a5,0x4
    80004f8c:	f8b40023          	sb	a1,-128(s0)
    80004f90:	0047d59b          	srliw	a1,a5,0x4
    80004f94:	0ac75e63          	bge	a4,a2,80005050 <__printf+0x668>
    80004f98:	00f6f693          	andi	a3,a3,15
    80004f9c:	00dd86b3          	add	a3,s11,a3
    80004fa0:	0006c603          	lbu	a2,0(a3)
    80004fa4:	00f00693          	li	a3,15
    80004fa8:	0087d79b          	srliw	a5,a5,0x8
    80004fac:	f8c400a3          	sb	a2,-127(s0)
    80004fb0:	d8b6e4e3          	bltu	a3,a1,80004d38 <__printf+0x350>
    80004fb4:	00200793          	li	a5,2
    80004fb8:	e2dff06f          	j	80004de4 <__printf+0x3fc>
    80004fbc:	00001c97          	auipc	s9,0x1
    80004fc0:	2dcc8c93          	addi	s9,s9,732 # 80006298 <CONSOLE_STATUS+0x288>
    80004fc4:	02800513          	li	a0,40
    80004fc8:	ef1ff06f          	j	80004eb8 <__printf+0x4d0>
    80004fcc:	00700793          	li	a5,7
    80004fd0:	00600c93          	li	s9,6
    80004fd4:	e0dff06f          	j	80004de0 <__printf+0x3f8>
    80004fd8:	00700793          	li	a5,7
    80004fdc:	00600c93          	li	s9,6
    80004fe0:	c69ff06f          	j	80004c48 <__printf+0x260>
    80004fe4:	00300793          	li	a5,3
    80004fe8:	00200c93          	li	s9,2
    80004fec:	c5dff06f          	j	80004c48 <__printf+0x260>
    80004ff0:	00300793          	li	a5,3
    80004ff4:	00200c93          	li	s9,2
    80004ff8:	de9ff06f          	j	80004de0 <__printf+0x3f8>
    80004ffc:	00400793          	li	a5,4
    80005000:	00300c93          	li	s9,3
    80005004:	dddff06f          	j	80004de0 <__printf+0x3f8>
    80005008:	00400793          	li	a5,4
    8000500c:	00300c93          	li	s9,3
    80005010:	c39ff06f          	j	80004c48 <__printf+0x260>
    80005014:	00500793          	li	a5,5
    80005018:	00400c93          	li	s9,4
    8000501c:	c2dff06f          	j	80004c48 <__printf+0x260>
    80005020:	00500793          	li	a5,5
    80005024:	00400c93          	li	s9,4
    80005028:	db9ff06f          	j	80004de0 <__printf+0x3f8>
    8000502c:	00600793          	li	a5,6
    80005030:	00500c93          	li	s9,5
    80005034:	dadff06f          	j	80004de0 <__printf+0x3f8>
    80005038:	00600793          	li	a5,6
    8000503c:	00500c93          	li	s9,5
    80005040:	c09ff06f          	j	80004c48 <__printf+0x260>
    80005044:	00800793          	li	a5,8
    80005048:	00700c93          	li	s9,7
    8000504c:	bfdff06f          	j	80004c48 <__printf+0x260>
    80005050:	00100793          	li	a5,1
    80005054:	d91ff06f          	j	80004de4 <__printf+0x3fc>
    80005058:	00100793          	li	a5,1
    8000505c:	bf1ff06f          	j	80004c4c <__printf+0x264>
    80005060:	00900793          	li	a5,9
    80005064:	00800c93          	li	s9,8
    80005068:	be1ff06f          	j	80004c48 <__printf+0x260>
    8000506c:	00001517          	auipc	a0,0x1
    80005070:	23450513          	addi	a0,a0,564 # 800062a0 <CONSOLE_STATUS+0x290>
    80005074:	00000097          	auipc	ra,0x0
    80005078:	918080e7          	jalr	-1768(ra) # 8000498c <panic>

000000008000507c <printfinit>:
    8000507c:	fe010113          	addi	sp,sp,-32
    80005080:	00813823          	sd	s0,16(sp)
    80005084:	00913423          	sd	s1,8(sp)
    80005088:	00113c23          	sd	ra,24(sp)
    8000508c:	02010413          	addi	s0,sp,32
    80005090:	00004497          	auipc	s1,0x4
    80005094:	9f048493          	addi	s1,s1,-1552 # 80008a80 <pr>
    80005098:	00048513          	mv	a0,s1
    8000509c:	00001597          	auipc	a1,0x1
    800050a0:	21458593          	addi	a1,a1,532 # 800062b0 <CONSOLE_STATUS+0x2a0>
    800050a4:	00000097          	auipc	ra,0x0
    800050a8:	5f4080e7          	jalr	1524(ra) # 80005698 <initlock>
    800050ac:	01813083          	ld	ra,24(sp)
    800050b0:	01013403          	ld	s0,16(sp)
    800050b4:	0004ac23          	sw	zero,24(s1)
    800050b8:	00813483          	ld	s1,8(sp)
    800050bc:	02010113          	addi	sp,sp,32
    800050c0:	00008067          	ret

00000000800050c4 <uartinit>:
    800050c4:	ff010113          	addi	sp,sp,-16
    800050c8:	00813423          	sd	s0,8(sp)
    800050cc:	01010413          	addi	s0,sp,16
    800050d0:	100007b7          	lui	a5,0x10000
    800050d4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800050d8:	f8000713          	li	a4,-128
    800050dc:	00e781a3          	sb	a4,3(a5)
    800050e0:	00300713          	li	a4,3
    800050e4:	00e78023          	sb	a4,0(a5)
    800050e8:	000780a3          	sb	zero,1(a5)
    800050ec:	00e781a3          	sb	a4,3(a5)
    800050f0:	00700693          	li	a3,7
    800050f4:	00d78123          	sb	a3,2(a5)
    800050f8:	00e780a3          	sb	a4,1(a5)
    800050fc:	00813403          	ld	s0,8(sp)
    80005100:	01010113          	addi	sp,sp,16
    80005104:	00008067          	ret

0000000080005108 <uartputc>:
    80005108:	00002797          	auipc	a5,0x2
    8000510c:	6307a783          	lw	a5,1584(a5) # 80007738 <panicked>
    80005110:	00078463          	beqz	a5,80005118 <uartputc+0x10>
    80005114:	0000006f          	j	80005114 <uartputc+0xc>
    80005118:	fd010113          	addi	sp,sp,-48
    8000511c:	02813023          	sd	s0,32(sp)
    80005120:	00913c23          	sd	s1,24(sp)
    80005124:	01213823          	sd	s2,16(sp)
    80005128:	01313423          	sd	s3,8(sp)
    8000512c:	02113423          	sd	ra,40(sp)
    80005130:	03010413          	addi	s0,sp,48
    80005134:	00002917          	auipc	s2,0x2
    80005138:	60c90913          	addi	s2,s2,1548 # 80007740 <uart_tx_r>
    8000513c:	00093783          	ld	a5,0(s2)
    80005140:	00002497          	auipc	s1,0x2
    80005144:	60848493          	addi	s1,s1,1544 # 80007748 <uart_tx_w>
    80005148:	0004b703          	ld	a4,0(s1)
    8000514c:	02078693          	addi	a3,a5,32
    80005150:	00050993          	mv	s3,a0
    80005154:	02e69c63          	bne	a3,a4,8000518c <uartputc+0x84>
    80005158:	00001097          	auipc	ra,0x1
    8000515c:	834080e7          	jalr	-1996(ra) # 8000598c <push_on>
    80005160:	00093783          	ld	a5,0(s2)
    80005164:	0004b703          	ld	a4,0(s1)
    80005168:	02078793          	addi	a5,a5,32
    8000516c:	00e79463          	bne	a5,a4,80005174 <uartputc+0x6c>
    80005170:	0000006f          	j	80005170 <uartputc+0x68>
    80005174:	00001097          	auipc	ra,0x1
    80005178:	88c080e7          	jalr	-1908(ra) # 80005a00 <pop_on>
    8000517c:	00093783          	ld	a5,0(s2)
    80005180:	0004b703          	ld	a4,0(s1)
    80005184:	02078693          	addi	a3,a5,32
    80005188:	fce688e3          	beq	a3,a4,80005158 <uartputc+0x50>
    8000518c:	01f77693          	andi	a3,a4,31
    80005190:	00004597          	auipc	a1,0x4
    80005194:	91058593          	addi	a1,a1,-1776 # 80008aa0 <uart_tx_buf>
    80005198:	00d586b3          	add	a3,a1,a3
    8000519c:	00170713          	addi	a4,a4,1
    800051a0:	01368023          	sb	s3,0(a3)
    800051a4:	00e4b023          	sd	a4,0(s1)
    800051a8:	10000637          	lui	a2,0x10000
    800051ac:	02f71063          	bne	a4,a5,800051cc <uartputc+0xc4>
    800051b0:	0340006f          	j	800051e4 <uartputc+0xdc>
    800051b4:	00074703          	lbu	a4,0(a4)
    800051b8:	00f93023          	sd	a5,0(s2)
    800051bc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800051c0:	00093783          	ld	a5,0(s2)
    800051c4:	0004b703          	ld	a4,0(s1)
    800051c8:	00f70e63          	beq	a4,a5,800051e4 <uartputc+0xdc>
    800051cc:	00564683          	lbu	a3,5(a2)
    800051d0:	01f7f713          	andi	a4,a5,31
    800051d4:	00e58733          	add	a4,a1,a4
    800051d8:	0206f693          	andi	a3,a3,32
    800051dc:	00178793          	addi	a5,a5,1
    800051e0:	fc069ae3          	bnez	a3,800051b4 <uartputc+0xac>
    800051e4:	02813083          	ld	ra,40(sp)
    800051e8:	02013403          	ld	s0,32(sp)
    800051ec:	01813483          	ld	s1,24(sp)
    800051f0:	01013903          	ld	s2,16(sp)
    800051f4:	00813983          	ld	s3,8(sp)
    800051f8:	03010113          	addi	sp,sp,48
    800051fc:	00008067          	ret

0000000080005200 <uartputc_sync>:
    80005200:	ff010113          	addi	sp,sp,-16
    80005204:	00813423          	sd	s0,8(sp)
    80005208:	01010413          	addi	s0,sp,16
    8000520c:	00002717          	auipc	a4,0x2
    80005210:	52c72703          	lw	a4,1324(a4) # 80007738 <panicked>
    80005214:	02071663          	bnez	a4,80005240 <uartputc_sync+0x40>
    80005218:	00050793          	mv	a5,a0
    8000521c:	100006b7          	lui	a3,0x10000
    80005220:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005224:	02077713          	andi	a4,a4,32
    80005228:	fe070ce3          	beqz	a4,80005220 <uartputc_sync+0x20>
    8000522c:	0ff7f793          	andi	a5,a5,255
    80005230:	00f68023          	sb	a5,0(a3)
    80005234:	00813403          	ld	s0,8(sp)
    80005238:	01010113          	addi	sp,sp,16
    8000523c:	00008067          	ret
    80005240:	0000006f          	j	80005240 <uartputc_sync+0x40>

0000000080005244 <uartstart>:
    80005244:	ff010113          	addi	sp,sp,-16
    80005248:	00813423          	sd	s0,8(sp)
    8000524c:	01010413          	addi	s0,sp,16
    80005250:	00002617          	auipc	a2,0x2
    80005254:	4f060613          	addi	a2,a2,1264 # 80007740 <uart_tx_r>
    80005258:	00002517          	auipc	a0,0x2
    8000525c:	4f050513          	addi	a0,a0,1264 # 80007748 <uart_tx_w>
    80005260:	00063783          	ld	a5,0(a2)
    80005264:	00053703          	ld	a4,0(a0)
    80005268:	04f70263          	beq	a4,a5,800052ac <uartstart+0x68>
    8000526c:	100005b7          	lui	a1,0x10000
    80005270:	00004817          	auipc	a6,0x4
    80005274:	83080813          	addi	a6,a6,-2000 # 80008aa0 <uart_tx_buf>
    80005278:	01c0006f          	j	80005294 <uartstart+0x50>
    8000527c:	0006c703          	lbu	a4,0(a3)
    80005280:	00f63023          	sd	a5,0(a2)
    80005284:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005288:	00063783          	ld	a5,0(a2)
    8000528c:	00053703          	ld	a4,0(a0)
    80005290:	00f70e63          	beq	a4,a5,800052ac <uartstart+0x68>
    80005294:	01f7f713          	andi	a4,a5,31
    80005298:	00e806b3          	add	a3,a6,a4
    8000529c:	0055c703          	lbu	a4,5(a1)
    800052a0:	00178793          	addi	a5,a5,1
    800052a4:	02077713          	andi	a4,a4,32
    800052a8:	fc071ae3          	bnez	a4,8000527c <uartstart+0x38>
    800052ac:	00813403          	ld	s0,8(sp)
    800052b0:	01010113          	addi	sp,sp,16
    800052b4:	00008067          	ret

00000000800052b8 <uartgetc>:
    800052b8:	ff010113          	addi	sp,sp,-16
    800052bc:	00813423          	sd	s0,8(sp)
    800052c0:	01010413          	addi	s0,sp,16
    800052c4:	10000737          	lui	a4,0x10000
    800052c8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800052cc:	0017f793          	andi	a5,a5,1
    800052d0:	00078c63          	beqz	a5,800052e8 <uartgetc+0x30>
    800052d4:	00074503          	lbu	a0,0(a4)
    800052d8:	0ff57513          	andi	a0,a0,255
    800052dc:	00813403          	ld	s0,8(sp)
    800052e0:	01010113          	addi	sp,sp,16
    800052e4:	00008067          	ret
    800052e8:	fff00513          	li	a0,-1
    800052ec:	ff1ff06f          	j	800052dc <uartgetc+0x24>

00000000800052f0 <uartintr>:
    800052f0:	100007b7          	lui	a5,0x10000
    800052f4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800052f8:	0017f793          	andi	a5,a5,1
    800052fc:	0a078463          	beqz	a5,800053a4 <uartintr+0xb4>
    80005300:	fe010113          	addi	sp,sp,-32
    80005304:	00813823          	sd	s0,16(sp)
    80005308:	00913423          	sd	s1,8(sp)
    8000530c:	00113c23          	sd	ra,24(sp)
    80005310:	02010413          	addi	s0,sp,32
    80005314:	100004b7          	lui	s1,0x10000
    80005318:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000531c:	0ff57513          	andi	a0,a0,255
    80005320:	fffff097          	auipc	ra,0xfffff
    80005324:	534080e7          	jalr	1332(ra) # 80004854 <consoleintr>
    80005328:	0054c783          	lbu	a5,5(s1)
    8000532c:	0017f793          	andi	a5,a5,1
    80005330:	fe0794e3          	bnez	a5,80005318 <uartintr+0x28>
    80005334:	00002617          	auipc	a2,0x2
    80005338:	40c60613          	addi	a2,a2,1036 # 80007740 <uart_tx_r>
    8000533c:	00002517          	auipc	a0,0x2
    80005340:	40c50513          	addi	a0,a0,1036 # 80007748 <uart_tx_w>
    80005344:	00063783          	ld	a5,0(a2)
    80005348:	00053703          	ld	a4,0(a0)
    8000534c:	04f70263          	beq	a4,a5,80005390 <uartintr+0xa0>
    80005350:	100005b7          	lui	a1,0x10000
    80005354:	00003817          	auipc	a6,0x3
    80005358:	74c80813          	addi	a6,a6,1868 # 80008aa0 <uart_tx_buf>
    8000535c:	01c0006f          	j	80005378 <uartintr+0x88>
    80005360:	0006c703          	lbu	a4,0(a3)
    80005364:	00f63023          	sd	a5,0(a2)
    80005368:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000536c:	00063783          	ld	a5,0(a2)
    80005370:	00053703          	ld	a4,0(a0)
    80005374:	00f70e63          	beq	a4,a5,80005390 <uartintr+0xa0>
    80005378:	01f7f713          	andi	a4,a5,31
    8000537c:	00e806b3          	add	a3,a6,a4
    80005380:	0055c703          	lbu	a4,5(a1)
    80005384:	00178793          	addi	a5,a5,1
    80005388:	02077713          	andi	a4,a4,32
    8000538c:	fc071ae3          	bnez	a4,80005360 <uartintr+0x70>
    80005390:	01813083          	ld	ra,24(sp)
    80005394:	01013403          	ld	s0,16(sp)
    80005398:	00813483          	ld	s1,8(sp)
    8000539c:	02010113          	addi	sp,sp,32
    800053a0:	00008067          	ret
    800053a4:	00002617          	auipc	a2,0x2
    800053a8:	39c60613          	addi	a2,a2,924 # 80007740 <uart_tx_r>
    800053ac:	00002517          	auipc	a0,0x2
    800053b0:	39c50513          	addi	a0,a0,924 # 80007748 <uart_tx_w>
    800053b4:	00063783          	ld	a5,0(a2)
    800053b8:	00053703          	ld	a4,0(a0)
    800053bc:	04f70263          	beq	a4,a5,80005400 <uartintr+0x110>
    800053c0:	100005b7          	lui	a1,0x10000
    800053c4:	00003817          	auipc	a6,0x3
    800053c8:	6dc80813          	addi	a6,a6,1756 # 80008aa0 <uart_tx_buf>
    800053cc:	01c0006f          	j	800053e8 <uartintr+0xf8>
    800053d0:	0006c703          	lbu	a4,0(a3)
    800053d4:	00f63023          	sd	a5,0(a2)
    800053d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800053dc:	00063783          	ld	a5,0(a2)
    800053e0:	00053703          	ld	a4,0(a0)
    800053e4:	02f70063          	beq	a4,a5,80005404 <uartintr+0x114>
    800053e8:	01f7f713          	andi	a4,a5,31
    800053ec:	00e806b3          	add	a3,a6,a4
    800053f0:	0055c703          	lbu	a4,5(a1)
    800053f4:	00178793          	addi	a5,a5,1
    800053f8:	02077713          	andi	a4,a4,32
    800053fc:	fc071ae3          	bnez	a4,800053d0 <uartintr+0xe0>
    80005400:	00008067          	ret
    80005404:	00008067          	ret

0000000080005408 <kinit>:
    80005408:	fc010113          	addi	sp,sp,-64
    8000540c:	02913423          	sd	s1,40(sp)
    80005410:	fffff7b7          	lui	a5,0xfffff
    80005414:	00004497          	auipc	s1,0x4
    80005418:	6ab48493          	addi	s1,s1,1707 # 80009abf <end+0xfff>
    8000541c:	02813823          	sd	s0,48(sp)
    80005420:	01313c23          	sd	s3,24(sp)
    80005424:	00f4f4b3          	and	s1,s1,a5
    80005428:	02113c23          	sd	ra,56(sp)
    8000542c:	03213023          	sd	s2,32(sp)
    80005430:	01413823          	sd	s4,16(sp)
    80005434:	01513423          	sd	s5,8(sp)
    80005438:	04010413          	addi	s0,sp,64
    8000543c:	000017b7          	lui	a5,0x1
    80005440:	01100993          	li	s3,17
    80005444:	00f487b3          	add	a5,s1,a5
    80005448:	01b99993          	slli	s3,s3,0x1b
    8000544c:	06f9e063          	bltu	s3,a5,800054ac <kinit+0xa4>
    80005450:	00003a97          	auipc	s5,0x3
    80005454:	670a8a93          	addi	s5,s5,1648 # 80008ac0 <end>
    80005458:	0754ec63          	bltu	s1,s5,800054d0 <kinit+0xc8>
    8000545c:	0734fa63          	bgeu	s1,s3,800054d0 <kinit+0xc8>
    80005460:	00088a37          	lui	s4,0x88
    80005464:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005468:	00002917          	auipc	s2,0x2
    8000546c:	2e890913          	addi	s2,s2,744 # 80007750 <kmem>
    80005470:	00ca1a13          	slli	s4,s4,0xc
    80005474:	0140006f          	j	80005488 <kinit+0x80>
    80005478:	000017b7          	lui	a5,0x1
    8000547c:	00f484b3          	add	s1,s1,a5
    80005480:	0554e863          	bltu	s1,s5,800054d0 <kinit+0xc8>
    80005484:	0534f663          	bgeu	s1,s3,800054d0 <kinit+0xc8>
    80005488:	00001637          	lui	a2,0x1
    8000548c:	00100593          	li	a1,1
    80005490:	00048513          	mv	a0,s1
    80005494:	00000097          	auipc	ra,0x0
    80005498:	5e4080e7          	jalr	1508(ra) # 80005a78 <__memset>
    8000549c:	00093783          	ld	a5,0(s2)
    800054a0:	00f4b023          	sd	a5,0(s1)
    800054a4:	00993023          	sd	s1,0(s2)
    800054a8:	fd4498e3          	bne	s1,s4,80005478 <kinit+0x70>
    800054ac:	03813083          	ld	ra,56(sp)
    800054b0:	03013403          	ld	s0,48(sp)
    800054b4:	02813483          	ld	s1,40(sp)
    800054b8:	02013903          	ld	s2,32(sp)
    800054bc:	01813983          	ld	s3,24(sp)
    800054c0:	01013a03          	ld	s4,16(sp)
    800054c4:	00813a83          	ld	s5,8(sp)
    800054c8:	04010113          	addi	sp,sp,64
    800054cc:	00008067          	ret
    800054d0:	00001517          	auipc	a0,0x1
    800054d4:	e0050513          	addi	a0,a0,-512 # 800062d0 <digits+0x18>
    800054d8:	fffff097          	auipc	ra,0xfffff
    800054dc:	4b4080e7          	jalr	1204(ra) # 8000498c <panic>

00000000800054e0 <freerange>:
    800054e0:	fc010113          	addi	sp,sp,-64
    800054e4:	000017b7          	lui	a5,0x1
    800054e8:	02913423          	sd	s1,40(sp)
    800054ec:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800054f0:	009504b3          	add	s1,a0,s1
    800054f4:	fffff537          	lui	a0,0xfffff
    800054f8:	02813823          	sd	s0,48(sp)
    800054fc:	02113c23          	sd	ra,56(sp)
    80005500:	03213023          	sd	s2,32(sp)
    80005504:	01313c23          	sd	s3,24(sp)
    80005508:	01413823          	sd	s4,16(sp)
    8000550c:	01513423          	sd	s5,8(sp)
    80005510:	01613023          	sd	s6,0(sp)
    80005514:	04010413          	addi	s0,sp,64
    80005518:	00a4f4b3          	and	s1,s1,a0
    8000551c:	00f487b3          	add	a5,s1,a5
    80005520:	06f5e463          	bltu	a1,a5,80005588 <freerange+0xa8>
    80005524:	00003a97          	auipc	s5,0x3
    80005528:	59ca8a93          	addi	s5,s5,1436 # 80008ac0 <end>
    8000552c:	0954e263          	bltu	s1,s5,800055b0 <freerange+0xd0>
    80005530:	01100993          	li	s3,17
    80005534:	01b99993          	slli	s3,s3,0x1b
    80005538:	0734fc63          	bgeu	s1,s3,800055b0 <freerange+0xd0>
    8000553c:	00058a13          	mv	s4,a1
    80005540:	00002917          	auipc	s2,0x2
    80005544:	21090913          	addi	s2,s2,528 # 80007750 <kmem>
    80005548:	00002b37          	lui	s6,0x2
    8000554c:	0140006f          	j	80005560 <freerange+0x80>
    80005550:	000017b7          	lui	a5,0x1
    80005554:	00f484b3          	add	s1,s1,a5
    80005558:	0554ec63          	bltu	s1,s5,800055b0 <freerange+0xd0>
    8000555c:	0534fa63          	bgeu	s1,s3,800055b0 <freerange+0xd0>
    80005560:	00001637          	lui	a2,0x1
    80005564:	00100593          	li	a1,1
    80005568:	00048513          	mv	a0,s1
    8000556c:	00000097          	auipc	ra,0x0
    80005570:	50c080e7          	jalr	1292(ra) # 80005a78 <__memset>
    80005574:	00093703          	ld	a4,0(s2)
    80005578:	016487b3          	add	a5,s1,s6
    8000557c:	00e4b023          	sd	a4,0(s1)
    80005580:	00993023          	sd	s1,0(s2)
    80005584:	fcfa76e3          	bgeu	s4,a5,80005550 <freerange+0x70>
    80005588:	03813083          	ld	ra,56(sp)
    8000558c:	03013403          	ld	s0,48(sp)
    80005590:	02813483          	ld	s1,40(sp)
    80005594:	02013903          	ld	s2,32(sp)
    80005598:	01813983          	ld	s3,24(sp)
    8000559c:	01013a03          	ld	s4,16(sp)
    800055a0:	00813a83          	ld	s5,8(sp)
    800055a4:	00013b03          	ld	s6,0(sp)
    800055a8:	04010113          	addi	sp,sp,64
    800055ac:	00008067          	ret
    800055b0:	00001517          	auipc	a0,0x1
    800055b4:	d2050513          	addi	a0,a0,-736 # 800062d0 <digits+0x18>
    800055b8:	fffff097          	auipc	ra,0xfffff
    800055bc:	3d4080e7          	jalr	980(ra) # 8000498c <panic>

00000000800055c0 <kfree>:
    800055c0:	fe010113          	addi	sp,sp,-32
    800055c4:	00813823          	sd	s0,16(sp)
    800055c8:	00113c23          	sd	ra,24(sp)
    800055cc:	00913423          	sd	s1,8(sp)
    800055d0:	02010413          	addi	s0,sp,32
    800055d4:	03451793          	slli	a5,a0,0x34
    800055d8:	04079c63          	bnez	a5,80005630 <kfree+0x70>
    800055dc:	00003797          	auipc	a5,0x3
    800055e0:	4e478793          	addi	a5,a5,1252 # 80008ac0 <end>
    800055e4:	00050493          	mv	s1,a0
    800055e8:	04f56463          	bltu	a0,a5,80005630 <kfree+0x70>
    800055ec:	01100793          	li	a5,17
    800055f0:	01b79793          	slli	a5,a5,0x1b
    800055f4:	02f57e63          	bgeu	a0,a5,80005630 <kfree+0x70>
    800055f8:	00001637          	lui	a2,0x1
    800055fc:	00100593          	li	a1,1
    80005600:	00000097          	auipc	ra,0x0
    80005604:	478080e7          	jalr	1144(ra) # 80005a78 <__memset>
    80005608:	00002797          	auipc	a5,0x2
    8000560c:	14878793          	addi	a5,a5,328 # 80007750 <kmem>
    80005610:	0007b703          	ld	a4,0(a5)
    80005614:	01813083          	ld	ra,24(sp)
    80005618:	01013403          	ld	s0,16(sp)
    8000561c:	00e4b023          	sd	a4,0(s1)
    80005620:	0097b023          	sd	s1,0(a5)
    80005624:	00813483          	ld	s1,8(sp)
    80005628:	02010113          	addi	sp,sp,32
    8000562c:	00008067          	ret
    80005630:	00001517          	auipc	a0,0x1
    80005634:	ca050513          	addi	a0,a0,-864 # 800062d0 <digits+0x18>
    80005638:	fffff097          	auipc	ra,0xfffff
    8000563c:	354080e7          	jalr	852(ra) # 8000498c <panic>

0000000080005640 <kalloc>:
    80005640:	fe010113          	addi	sp,sp,-32
    80005644:	00813823          	sd	s0,16(sp)
    80005648:	00913423          	sd	s1,8(sp)
    8000564c:	00113c23          	sd	ra,24(sp)
    80005650:	02010413          	addi	s0,sp,32
    80005654:	00002797          	auipc	a5,0x2
    80005658:	0fc78793          	addi	a5,a5,252 # 80007750 <kmem>
    8000565c:	0007b483          	ld	s1,0(a5)
    80005660:	02048063          	beqz	s1,80005680 <kalloc+0x40>
    80005664:	0004b703          	ld	a4,0(s1)
    80005668:	00001637          	lui	a2,0x1
    8000566c:	00500593          	li	a1,5
    80005670:	00048513          	mv	a0,s1
    80005674:	00e7b023          	sd	a4,0(a5)
    80005678:	00000097          	auipc	ra,0x0
    8000567c:	400080e7          	jalr	1024(ra) # 80005a78 <__memset>
    80005680:	01813083          	ld	ra,24(sp)
    80005684:	01013403          	ld	s0,16(sp)
    80005688:	00048513          	mv	a0,s1
    8000568c:	00813483          	ld	s1,8(sp)
    80005690:	02010113          	addi	sp,sp,32
    80005694:	00008067          	ret

0000000080005698 <initlock>:
    80005698:	ff010113          	addi	sp,sp,-16
    8000569c:	00813423          	sd	s0,8(sp)
    800056a0:	01010413          	addi	s0,sp,16
    800056a4:	00813403          	ld	s0,8(sp)
    800056a8:	00b53423          	sd	a1,8(a0)
    800056ac:	00052023          	sw	zero,0(a0)
    800056b0:	00053823          	sd	zero,16(a0)
    800056b4:	01010113          	addi	sp,sp,16
    800056b8:	00008067          	ret

00000000800056bc <acquire>:
    800056bc:	fe010113          	addi	sp,sp,-32
    800056c0:	00813823          	sd	s0,16(sp)
    800056c4:	00913423          	sd	s1,8(sp)
    800056c8:	00113c23          	sd	ra,24(sp)
    800056cc:	01213023          	sd	s2,0(sp)
    800056d0:	02010413          	addi	s0,sp,32
    800056d4:	00050493          	mv	s1,a0
    800056d8:	10002973          	csrr	s2,sstatus
    800056dc:	100027f3          	csrr	a5,sstatus
    800056e0:	ffd7f793          	andi	a5,a5,-3
    800056e4:	10079073          	csrw	sstatus,a5
    800056e8:	fffff097          	auipc	ra,0xfffff
    800056ec:	8e8080e7          	jalr	-1816(ra) # 80003fd0 <mycpu>
    800056f0:	07852783          	lw	a5,120(a0)
    800056f4:	06078e63          	beqz	a5,80005770 <acquire+0xb4>
    800056f8:	fffff097          	auipc	ra,0xfffff
    800056fc:	8d8080e7          	jalr	-1832(ra) # 80003fd0 <mycpu>
    80005700:	07852783          	lw	a5,120(a0)
    80005704:	0004a703          	lw	a4,0(s1)
    80005708:	0017879b          	addiw	a5,a5,1
    8000570c:	06f52c23          	sw	a5,120(a0)
    80005710:	04071063          	bnez	a4,80005750 <acquire+0x94>
    80005714:	00100713          	li	a4,1
    80005718:	00070793          	mv	a5,a4
    8000571c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005720:	0007879b          	sext.w	a5,a5
    80005724:	fe079ae3          	bnez	a5,80005718 <acquire+0x5c>
    80005728:	0ff0000f          	fence
    8000572c:	fffff097          	auipc	ra,0xfffff
    80005730:	8a4080e7          	jalr	-1884(ra) # 80003fd0 <mycpu>
    80005734:	01813083          	ld	ra,24(sp)
    80005738:	01013403          	ld	s0,16(sp)
    8000573c:	00a4b823          	sd	a0,16(s1)
    80005740:	00013903          	ld	s2,0(sp)
    80005744:	00813483          	ld	s1,8(sp)
    80005748:	02010113          	addi	sp,sp,32
    8000574c:	00008067          	ret
    80005750:	0104b903          	ld	s2,16(s1)
    80005754:	fffff097          	auipc	ra,0xfffff
    80005758:	87c080e7          	jalr	-1924(ra) # 80003fd0 <mycpu>
    8000575c:	faa91ce3          	bne	s2,a0,80005714 <acquire+0x58>
    80005760:	00001517          	auipc	a0,0x1
    80005764:	b7850513          	addi	a0,a0,-1160 # 800062d8 <digits+0x20>
    80005768:	fffff097          	auipc	ra,0xfffff
    8000576c:	224080e7          	jalr	548(ra) # 8000498c <panic>
    80005770:	00195913          	srli	s2,s2,0x1
    80005774:	fffff097          	auipc	ra,0xfffff
    80005778:	85c080e7          	jalr	-1956(ra) # 80003fd0 <mycpu>
    8000577c:	00197913          	andi	s2,s2,1
    80005780:	07252e23          	sw	s2,124(a0)
    80005784:	f75ff06f          	j	800056f8 <acquire+0x3c>

0000000080005788 <release>:
    80005788:	fe010113          	addi	sp,sp,-32
    8000578c:	00813823          	sd	s0,16(sp)
    80005790:	00113c23          	sd	ra,24(sp)
    80005794:	00913423          	sd	s1,8(sp)
    80005798:	01213023          	sd	s2,0(sp)
    8000579c:	02010413          	addi	s0,sp,32
    800057a0:	00052783          	lw	a5,0(a0)
    800057a4:	00079a63          	bnez	a5,800057b8 <release+0x30>
    800057a8:	00001517          	auipc	a0,0x1
    800057ac:	b3850513          	addi	a0,a0,-1224 # 800062e0 <digits+0x28>
    800057b0:	fffff097          	auipc	ra,0xfffff
    800057b4:	1dc080e7          	jalr	476(ra) # 8000498c <panic>
    800057b8:	01053903          	ld	s2,16(a0)
    800057bc:	00050493          	mv	s1,a0
    800057c0:	fffff097          	auipc	ra,0xfffff
    800057c4:	810080e7          	jalr	-2032(ra) # 80003fd0 <mycpu>
    800057c8:	fea910e3          	bne	s2,a0,800057a8 <release+0x20>
    800057cc:	0004b823          	sd	zero,16(s1)
    800057d0:	0ff0000f          	fence
    800057d4:	0f50000f          	fence	iorw,ow
    800057d8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800057dc:	ffffe097          	auipc	ra,0xffffe
    800057e0:	7f4080e7          	jalr	2036(ra) # 80003fd0 <mycpu>
    800057e4:	100027f3          	csrr	a5,sstatus
    800057e8:	0027f793          	andi	a5,a5,2
    800057ec:	04079a63          	bnez	a5,80005840 <release+0xb8>
    800057f0:	07852783          	lw	a5,120(a0)
    800057f4:	02f05e63          	blez	a5,80005830 <release+0xa8>
    800057f8:	fff7871b          	addiw	a4,a5,-1
    800057fc:	06e52c23          	sw	a4,120(a0)
    80005800:	00071c63          	bnez	a4,80005818 <release+0x90>
    80005804:	07c52783          	lw	a5,124(a0)
    80005808:	00078863          	beqz	a5,80005818 <release+0x90>
    8000580c:	100027f3          	csrr	a5,sstatus
    80005810:	0027e793          	ori	a5,a5,2
    80005814:	10079073          	csrw	sstatus,a5
    80005818:	01813083          	ld	ra,24(sp)
    8000581c:	01013403          	ld	s0,16(sp)
    80005820:	00813483          	ld	s1,8(sp)
    80005824:	00013903          	ld	s2,0(sp)
    80005828:	02010113          	addi	sp,sp,32
    8000582c:	00008067          	ret
    80005830:	00001517          	auipc	a0,0x1
    80005834:	ad050513          	addi	a0,a0,-1328 # 80006300 <digits+0x48>
    80005838:	fffff097          	auipc	ra,0xfffff
    8000583c:	154080e7          	jalr	340(ra) # 8000498c <panic>
    80005840:	00001517          	auipc	a0,0x1
    80005844:	aa850513          	addi	a0,a0,-1368 # 800062e8 <digits+0x30>
    80005848:	fffff097          	auipc	ra,0xfffff
    8000584c:	144080e7          	jalr	324(ra) # 8000498c <panic>

0000000080005850 <holding>:
    80005850:	00052783          	lw	a5,0(a0)
    80005854:	00079663          	bnez	a5,80005860 <holding+0x10>
    80005858:	00000513          	li	a0,0
    8000585c:	00008067          	ret
    80005860:	fe010113          	addi	sp,sp,-32
    80005864:	00813823          	sd	s0,16(sp)
    80005868:	00913423          	sd	s1,8(sp)
    8000586c:	00113c23          	sd	ra,24(sp)
    80005870:	02010413          	addi	s0,sp,32
    80005874:	01053483          	ld	s1,16(a0)
    80005878:	ffffe097          	auipc	ra,0xffffe
    8000587c:	758080e7          	jalr	1880(ra) # 80003fd0 <mycpu>
    80005880:	01813083          	ld	ra,24(sp)
    80005884:	01013403          	ld	s0,16(sp)
    80005888:	40a48533          	sub	a0,s1,a0
    8000588c:	00153513          	seqz	a0,a0
    80005890:	00813483          	ld	s1,8(sp)
    80005894:	02010113          	addi	sp,sp,32
    80005898:	00008067          	ret

000000008000589c <push_off>:
    8000589c:	fe010113          	addi	sp,sp,-32
    800058a0:	00813823          	sd	s0,16(sp)
    800058a4:	00113c23          	sd	ra,24(sp)
    800058a8:	00913423          	sd	s1,8(sp)
    800058ac:	02010413          	addi	s0,sp,32
    800058b0:	100024f3          	csrr	s1,sstatus
    800058b4:	100027f3          	csrr	a5,sstatus
    800058b8:	ffd7f793          	andi	a5,a5,-3
    800058bc:	10079073          	csrw	sstatus,a5
    800058c0:	ffffe097          	auipc	ra,0xffffe
    800058c4:	710080e7          	jalr	1808(ra) # 80003fd0 <mycpu>
    800058c8:	07852783          	lw	a5,120(a0)
    800058cc:	02078663          	beqz	a5,800058f8 <push_off+0x5c>
    800058d0:	ffffe097          	auipc	ra,0xffffe
    800058d4:	700080e7          	jalr	1792(ra) # 80003fd0 <mycpu>
    800058d8:	07852783          	lw	a5,120(a0)
    800058dc:	01813083          	ld	ra,24(sp)
    800058e0:	01013403          	ld	s0,16(sp)
    800058e4:	0017879b          	addiw	a5,a5,1
    800058e8:	06f52c23          	sw	a5,120(a0)
    800058ec:	00813483          	ld	s1,8(sp)
    800058f0:	02010113          	addi	sp,sp,32
    800058f4:	00008067          	ret
    800058f8:	0014d493          	srli	s1,s1,0x1
    800058fc:	ffffe097          	auipc	ra,0xffffe
    80005900:	6d4080e7          	jalr	1748(ra) # 80003fd0 <mycpu>
    80005904:	0014f493          	andi	s1,s1,1
    80005908:	06952e23          	sw	s1,124(a0)
    8000590c:	fc5ff06f          	j	800058d0 <push_off+0x34>

0000000080005910 <pop_off>:
    80005910:	ff010113          	addi	sp,sp,-16
    80005914:	00813023          	sd	s0,0(sp)
    80005918:	00113423          	sd	ra,8(sp)
    8000591c:	01010413          	addi	s0,sp,16
    80005920:	ffffe097          	auipc	ra,0xffffe
    80005924:	6b0080e7          	jalr	1712(ra) # 80003fd0 <mycpu>
    80005928:	100027f3          	csrr	a5,sstatus
    8000592c:	0027f793          	andi	a5,a5,2
    80005930:	04079663          	bnez	a5,8000597c <pop_off+0x6c>
    80005934:	07852783          	lw	a5,120(a0)
    80005938:	02f05a63          	blez	a5,8000596c <pop_off+0x5c>
    8000593c:	fff7871b          	addiw	a4,a5,-1
    80005940:	06e52c23          	sw	a4,120(a0)
    80005944:	00071c63          	bnez	a4,8000595c <pop_off+0x4c>
    80005948:	07c52783          	lw	a5,124(a0)
    8000594c:	00078863          	beqz	a5,8000595c <pop_off+0x4c>
    80005950:	100027f3          	csrr	a5,sstatus
    80005954:	0027e793          	ori	a5,a5,2
    80005958:	10079073          	csrw	sstatus,a5
    8000595c:	00813083          	ld	ra,8(sp)
    80005960:	00013403          	ld	s0,0(sp)
    80005964:	01010113          	addi	sp,sp,16
    80005968:	00008067          	ret
    8000596c:	00001517          	auipc	a0,0x1
    80005970:	99450513          	addi	a0,a0,-1644 # 80006300 <digits+0x48>
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	018080e7          	jalr	24(ra) # 8000498c <panic>
    8000597c:	00001517          	auipc	a0,0x1
    80005980:	96c50513          	addi	a0,a0,-1684 # 800062e8 <digits+0x30>
    80005984:	fffff097          	auipc	ra,0xfffff
    80005988:	008080e7          	jalr	8(ra) # 8000498c <panic>

000000008000598c <push_on>:
    8000598c:	fe010113          	addi	sp,sp,-32
    80005990:	00813823          	sd	s0,16(sp)
    80005994:	00113c23          	sd	ra,24(sp)
    80005998:	00913423          	sd	s1,8(sp)
    8000599c:	02010413          	addi	s0,sp,32
    800059a0:	100024f3          	csrr	s1,sstatus
    800059a4:	100027f3          	csrr	a5,sstatus
    800059a8:	0027e793          	ori	a5,a5,2
    800059ac:	10079073          	csrw	sstatus,a5
    800059b0:	ffffe097          	auipc	ra,0xffffe
    800059b4:	620080e7          	jalr	1568(ra) # 80003fd0 <mycpu>
    800059b8:	07852783          	lw	a5,120(a0)
    800059bc:	02078663          	beqz	a5,800059e8 <push_on+0x5c>
    800059c0:	ffffe097          	auipc	ra,0xffffe
    800059c4:	610080e7          	jalr	1552(ra) # 80003fd0 <mycpu>
    800059c8:	07852783          	lw	a5,120(a0)
    800059cc:	01813083          	ld	ra,24(sp)
    800059d0:	01013403          	ld	s0,16(sp)
    800059d4:	0017879b          	addiw	a5,a5,1
    800059d8:	06f52c23          	sw	a5,120(a0)
    800059dc:	00813483          	ld	s1,8(sp)
    800059e0:	02010113          	addi	sp,sp,32
    800059e4:	00008067          	ret
    800059e8:	0014d493          	srli	s1,s1,0x1
    800059ec:	ffffe097          	auipc	ra,0xffffe
    800059f0:	5e4080e7          	jalr	1508(ra) # 80003fd0 <mycpu>
    800059f4:	0014f493          	andi	s1,s1,1
    800059f8:	06952e23          	sw	s1,124(a0)
    800059fc:	fc5ff06f          	j	800059c0 <push_on+0x34>

0000000080005a00 <pop_on>:
    80005a00:	ff010113          	addi	sp,sp,-16
    80005a04:	00813023          	sd	s0,0(sp)
    80005a08:	00113423          	sd	ra,8(sp)
    80005a0c:	01010413          	addi	s0,sp,16
    80005a10:	ffffe097          	auipc	ra,0xffffe
    80005a14:	5c0080e7          	jalr	1472(ra) # 80003fd0 <mycpu>
    80005a18:	100027f3          	csrr	a5,sstatus
    80005a1c:	0027f793          	andi	a5,a5,2
    80005a20:	04078463          	beqz	a5,80005a68 <pop_on+0x68>
    80005a24:	07852783          	lw	a5,120(a0)
    80005a28:	02f05863          	blez	a5,80005a58 <pop_on+0x58>
    80005a2c:	fff7879b          	addiw	a5,a5,-1
    80005a30:	06f52c23          	sw	a5,120(a0)
    80005a34:	07853783          	ld	a5,120(a0)
    80005a38:	00079863          	bnez	a5,80005a48 <pop_on+0x48>
    80005a3c:	100027f3          	csrr	a5,sstatus
    80005a40:	ffd7f793          	andi	a5,a5,-3
    80005a44:	10079073          	csrw	sstatus,a5
    80005a48:	00813083          	ld	ra,8(sp)
    80005a4c:	00013403          	ld	s0,0(sp)
    80005a50:	01010113          	addi	sp,sp,16
    80005a54:	00008067          	ret
    80005a58:	00001517          	auipc	a0,0x1
    80005a5c:	8d050513          	addi	a0,a0,-1840 # 80006328 <digits+0x70>
    80005a60:	fffff097          	auipc	ra,0xfffff
    80005a64:	f2c080e7          	jalr	-212(ra) # 8000498c <panic>
    80005a68:	00001517          	auipc	a0,0x1
    80005a6c:	8a050513          	addi	a0,a0,-1888 # 80006308 <digits+0x50>
    80005a70:	fffff097          	auipc	ra,0xfffff
    80005a74:	f1c080e7          	jalr	-228(ra) # 8000498c <panic>

0000000080005a78 <__memset>:
    80005a78:	ff010113          	addi	sp,sp,-16
    80005a7c:	00813423          	sd	s0,8(sp)
    80005a80:	01010413          	addi	s0,sp,16
    80005a84:	1a060e63          	beqz	a2,80005c40 <__memset+0x1c8>
    80005a88:	40a007b3          	neg	a5,a0
    80005a8c:	0077f793          	andi	a5,a5,7
    80005a90:	00778693          	addi	a3,a5,7
    80005a94:	00b00813          	li	a6,11
    80005a98:	0ff5f593          	andi	a1,a1,255
    80005a9c:	fff6071b          	addiw	a4,a2,-1
    80005aa0:	1b06e663          	bltu	a3,a6,80005c4c <__memset+0x1d4>
    80005aa4:	1cd76463          	bltu	a4,a3,80005c6c <__memset+0x1f4>
    80005aa8:	1a078e63          	beqz	a5,80005c64 <__memset+0x1ec>
    80005aac:	00b50023          	sb	a1,0(a0)
    80005ab0:	00100713          	li	a4,1
    80005ab4:	1ae78463          	beq	a5,a4,80005c5c <__memset+0x1e4>
    80005ab8:	00b500a3          	sb	a1,1(a0)
    80005abc:	00200713          	li	a4,2
    80005ac0:	1ae78a63          	beq	a5,a4,80005c74 <__memset+0x1fc>
    80005ac4:	00b50123          	sb	a1,2(a0)
    80005ac8:	00300713          	li	a4,3
    80005acc:	18e78463          	beq	a5,a4,80005c54 <__memset+0x1dc>
    80005ad0:	00b501a3          	sb	a1,3(a0)
    80005ad4:	00400713          	li	a4,4
    80005ad8:	1ae78263          	beq	a5,a4,80005c7c <__memset+0x204>
    80005adc:	00b50223          	sb	a1,4(a0)
    80005ae0:	00500713          	li	a4,5
    80005ae4:	1ae78063          	beq	a5,a4,80005c84 <__memset+0x20c>
    80005ae8:	00b502a3          	sb	a1,5(a0)
    80005aec:	00700713          	li	a4,7
    80005af0:	18e79e63          	bne	a5,a4,80005c8c <__memset+0x214>
    80005af4:	00b50323          	sb	a1,6(a0)
    80005af8:	00700e93          	li	t4,7
    80005afc:	00859713          	slli	a4,a1,0x8
    80005b00:	00e5e733          	or	a4,a1,a4
    80005b04:	01059e13          	slli	t3,a1,0x10
    80005b08:	01c76e33          	or	t3,a4,t3
    80005b0c:	01859313          	slli	t1,a1,0x18
    80005b10:	006e6333          	or	t1,t3,t1
    80005b14:	02059893          	slli	a7,a1,0x20
    80005b18:	40f60e3b          	subw	t3,a2,a5
    80005b1c:	011368b3          	or	a7,t1,a7
    80005b20:	02859813          	slli	a6,a1,0x28
    80005b24:	0108e833          	or	a6,a7,a6
    80005b28:	03059693          	slli	a3,a1,0x30
    80005b2c:	003e589b          	srliw	a7,t3,0x3
    80005b30:	00d866b3          	or	a3,a6,a3
    80005b34:	03859713          	slli	a4,a1,0x38
    80005b38:	00389813          	slli	a6,a7,0x3
    80005b3c:	00f507b3          	add	a5,a0,a5
    80005b40:	00e6e733          	or	a4,a3,a4
    80005b44:	000e089b          	sext.w	a7,t3
    80005b48:	00f806b3          	add	a3,a6,a5
    80005b4c:	00e7b023          	sd	a4,0(a5)
    80005b50:	00878793          	addi	a5,a5,8
    80005b54:	fed79ce3          	bne	a5,a3,80005b4c <__memset+0xd4>
    80005b58:	ff8e7793          	andi	a5,t3,-8
    80005b5c:	0007871b          	sext.w	a4,a5
    80005b60:	01d787bb          	addw	a5,a5,t4
    80005b64:	0ce88e63          	beq	a7,a4,80005c40 <__memset+0x1c8>
    80005b68:	00f50733          	add	a4,a0,a5
    80005b6c:	00b70023          	sb	a1,0(a4)
    80005b70:	0017871b          	addiw	a4,a5,1
    80005b74:	0cc77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005b78:	00e50733          	add	a4,a0,a4
    80005b7c:	00b70023          	sb	a1,0(a4)
    80005b80:	0027871b          	addiw	a4,a5,2
    80005b84:	0ac77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005b88:	00e50733          	add	a4,a0,a4
    80005b8c:	00b70023          	sb	a1,0(a4)
    80005b90:	0037871b          	addiw	a4,a5,3
    80005b94:	0ac77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005b98:	00e50733          	add	a4,a0,a4
    80005b9c:	00b70023          	sb	a1,0(a4)
    80005ba0:	0047871b          	addiw	a4,a5,4
    80005ba4:	08c77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005ba8:	00e50733          	add	a4,a0,a4
    80005bac:	00b70023          	sb	a1,0(a4)
    80005bb0:	0057871b          	addiw	a4,a5,5
    80005bb4:	08c77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005bb8:	00e50733          	add	a4,a0,a4
    80005bbc:	00b70023          	sb	a1,0(a4)
    80005bc0:	0067871b          	addiw	a4,a5,6
    80005bc4:	06c77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005bc8:	00e50733          	add	a4,a0,a4
    80005bcc:	00b70023          	sb	a1,0(a4)
    80005bd0:	0077871b          	addiw	a4,a5,7
    80005bd4:	06c77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005bd8:	00e50733          	add	a4,a0,a4
    80005bdc:	00b70023          	sb	a1,0(a4)
    80005be0:	0087871b          	addiw	a4,a5,8
    80005be4:	04c77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005be8:	00e50733          	add	a4,a0,a4
    80005bec:	00b70023          	sb	a1,0(a4)
    80005bf0:	0097871b          	addiw	a4,a5,9
    80005bf4:	04c77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005bf8:	00e50733          	add	a4,a0,a4
    80005bfc:	00b70023          	sb	a1,0(a4)
    80005c00:	00a7871b          	addiw	a4,a5,10
    80005c04:	02c77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005c08:	00e50733          	add	a4,a0,a4
    80005c0c:	00b70023          	sb	a1,0(a4)
    80005c10:	00b7871b          	addiw	a4,a5,11
    80005c14:	02c77663          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005c18:	00e50733          	add	a4,a0,a4
    80005c1c:	00b70023          	sb	a1,0(a4)
    80005c20:	00c7871b          	addiw	a4,a5,12
    80005c24:	00c77e63          	bgeu	a4,a2,80005c40 <__memset+0x1c8>
    80005c28:	00e50733          	add	a4,a0,a4
    80005c2c:	00b70023          	sb	a1,0(a4)
    80005c30:	00d7879b          	addiw	a5,a5,13
    80005c34:	00c7f663          	bgeu	a5,a2,80005c40 <__memset+0x1c8>
    80005c38:	00f507b3          	add	a5,a0,a5
    80005c3c:	00b78023          	sb	a1,0(a5)
    80005c40:	00813403          	ld	s0,8(sp)
    80005c44:	01010113          	addi	sp,sp,16
    80005c48:	00008067          	ret
    80005c4c:	00b00693          	li	a3,11
    80005c50:	e55ff06f          	j	80005aa4 <__memset+0x2c>
    80005c54:	00300e93          	li	t4,3
    80005c58:	ea5ff06f          	j	80005afc <__memset+0x84>
    80005c5c:	00100e93          	li	t4,1
    80005c60:	e9dff06f          	j	80005afc <__memset+0x84>
    80005c64:	00000e93          	li	t4,0
    80005c68:	e95ff06f          	j	80005afc <__memset+0x84>
    80005c6c:	00000793          	li	a5,0
    80005c70:	ef9ff06f          	j	80005b68 <__memset+0xf0>
    80005c74:	00200e93          	li	t4,2
    80005c78:	e85ff06f          	j	80005afc <__memset+0x84>
    80005c7c:	00400e93          	li	t4,4
    80005c80:	e7dff06f          	j	80005afc <__memset+0x84>
    80005c84:	00500e93          	li	t4,5
    80005c88:	e75ff06f          	j	80005afc <__memset+0x84>
    80005c8c:	00600e93          	li	t4,6
    80005c90:	e6dff06f          	j	80005afc <__memset+0x84>

0000000080005c94 <__memmove>:
    80005c94:	ff010113          	addi	sp,sp,-16
    80005c98:	00813423          	sd	s0,8(sp)
    80005c9c:	01010413          	addi	s0,sp,16
    80005ca0:	0e060863          	beqz	a2,80005d90 <__memmove+0xfc>
    80005ca4:	fff6069b          	addiw	a3,a2,-1
    80005ca8:	0006881b          	sext.w	a6,a3
    80005cac:	0ea5e863          	bltu	a1,a0,80005d9c <__memmove+0x108>
    80005cb0:	00758713          	addi	a4,a1,7
    80005cb4:	00a5e7b3          	or	a5,a1,a0
    80005cb8:	40a70733          	sub	a4,a4,a0
    80005cbc:	0077f793          	andi	a5,a5,7
    80005cc0:	00f73713          	sltiu	a4,a4,15
    80005cc4:	00174713          	xori	a4,a4,1
    80005cc8:	0017b793          	seqz	a5,a5
    80005ccc:	00e7f7b3          	and	a5,a5,a4
    80005cd0:	10078863          	beqz	a5,80005de0 <__memmove+0x14c>
    80005cd4:	00900793          	li	a5,9
    80005cd8:	1107f463          	bgeu	a5,a6,80005de0 <__memmove+0x14c>
    80005cdc:	0036581b          	srliw	a6,a2,0x3
    80005ce0:	fff8081b          	addiw	a6,a6,-1
    80005ce4:	02081813          	slli	a6,a6,0x20
    80005ce8:	01d85893          	srli	a7,a6,0x1d
    80005cec:	00858813          	addi	a6,a1,8
    80005cf0:	00058793          	mv	a5,a1
    80005cf4:	00050713          	mv	a4,a0
    80005cf8:	01088833          	add	a6,a7,a6
    80005cfc:	0007b883          	ld	a7,0(a5)
    80005d00:	00878793          	addi	a5,a5,8
    80005d04:	00870713          	addi	a4,a4,8
    80005d08:	ff173c23          	sd	a7,-8(a4)
    80005d0c:	ff0798e3          	bne	a5,a6,80005cfc <__memmove+0x68>
    80005d10:	ff867713          	andi	a4,a2,-8
    80005d14:	02071793          	slli	a5,a4,0x20
    80005d18:	0207d793          	srli	a5,a5,0x20
    80005d1c:	00f585b3          	add	a1,a1,a5
    80005d20:	40e686bb          	subw	a3,a3,a4
    80005d24:	00f507b3          	add	a5,a0,a5
    80005d28:	06e60463          	beq	a2,a4,80005d90 <__memmove+0xfc>
    80005d2c:	0005c703          	lbu	a4,0(a1)
    80005d30:	00e78023          	sb	a4,0(a5)
    80005d34:	04068e63          	beqz	a3,80005d90 <__memmove+0xfc>
    80005d38:	0015c603          	lbu	a2,1(a1)
    80005d3c:	00100713          	li	a4,1
    80005d40:	00c780a3          	sb	a2,1(a5)
    80005d44:	04e68663          	beq	a3,a4,80005d90 <__memmove+0xfc>
    80005d48:	0025c603          	lbu	a2,2(a1)
    80005d4c:	00200713          	li	a4,2
    80005d50:	00c78123          	sb	a2,2(a5)
    80005d54:	02e68e63          	beq	a3,a4,80005d90 <__memmove+0xfc>
    80005d58:	0035c603          	lbu	a2,3(a1)
    80005d5c:	00300713          	li	a4,3
    80005d60:	00c781a3          	sb	a2,3(a5)
    80005d64:	02e68663          	beq	a3,a4,80005d90 <__memmove+0xfc>
    80005d68:	0045c603          	lbu	a2,4(a1)
    80005d6c:	00400713          	li	a4,4
    80005d70:	00c78223          	sb	a2,4(a5)
    80005d74:	00e68e63          	beq	a3,a4,80005d90 <__memmove+0xfc>
    80005d78:	0055c603          	lbu	a2,5(a1)
    80005d7c:	00500713          	li	a4,5
    80005d80:	00c782a3          	sb	a2,5(a5)
    80005d84:	00e68663          	beq	a3,a4,80005d90 <__memmove+0xfc>
    80005d88:	0065c703          	lbu	a4,6(a1)
    80005d8c:	00e78323          	sb	a4,6(a5)
    80005d90:	00813403          	ld	s0,8(sp)
    80005d94:	01010113          	addi	sp,sp,16
    80005d98:	00008067          	ret
    80005d9c:	02061713          	slli	a4,a2,0x20
    80005da0:	02075713          	srli	a4,a4,0x20
    80005da4:	00e587b3          	add	a5,a1,a4
    80005da8:	f0f574e3          	bgeu	a0,a5,80005cb0 <__memmove+0x1c>
    80005dac:	02069613          	slli	a2,a3,0x20
    80005db0:	02065613          	srli	a2,a2,0x20
    80005db4:	fff64613          	not	a2,a2
    80005db8:	00e50733          	add	a4,a0,a4
    80005dbc:	00c78633          	add	a2,a5,a2
    80005dc0:	fff7c683          	lbu	a3,-1(a5)
    80005dc4:	fff78793          	addi	a5,a5,-1
    80005dc8:	fff70713          	addi	a4,a4,-1
    80005dcc:	00d70023          	sb	a3,0(a4)
    80005dd0:	fec798e3          	bne	a5,a2,80005dc0 <__memmove+0x12c>
    80005dd4:	00813403          	ld	s0,8(sp)
    80005dd8:	01010113          	addi	sp,sp,16
    80005ddc:	00008067          	ret
    80005de0:	02069713          	slli	a4,a3,0x20
    80005de4:	02075713          	srli	a4,a4,0x20
    80005de8:	00170713          	addi	a4,a4,1
    80005dec:	00e50733          	add	a4,a0,a4
    80005df0:	00050793          	mv	a5,a0
    80005df4:	0005c683          	lbu	a3,0(a1)
    80005df8:	00178793          	addi	a5,a5,1
    80005dfc:	00158593          	addi	a1,a1,1
    80005e00:	fed78fa3          	sb	a3,-1(a5)
    80005e04:	fee798e3          	bne	a5,a4,80005df4 <__memmove+0x160>
    80005e08:	f89ff06f          	j	80005d90 <__memmove+0xfc>
	...
