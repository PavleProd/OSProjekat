
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	4b013103          	ld	sp,1200(sp) # 800074b0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	700030ef          	jal	ra,8000371c <start>

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
    8000100c:	501000ef          	jal	ra,80001d0c <_ZN3PCB10getContextEv>
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
    800010a0:	46d000ef          	jal	ra,80001d0c <_ZN3PCB10getContextEv>

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
#include "../h/PCB.h"
#include "../h/console.h"

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
    80001598:	2af70c63          	beq	a4,a5,80001850 <interruptHandler+0x328>
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
    800015ac:	30f70263          	beq	a4,a5,800018b0 <interruptHandler+0x388>
        else {
            plic_complete(CONSOLE_IRQ);
        }
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800015b0:	00002097          	auipc	ra,0x2
    800015b4:	084080e7          	jalr	132(ra) # 80003634 <_Z10printErrorv>
    800015b8:	0840006f          	j	8000163c <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015bc:	fd043783          	ld	a5,-48(s0)
    800015c0:	00478793          	addi	a5,a5,4
    800015c4:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015c8:	00006797          	auipc	a5,0x6
    800015cc:	f007b783          	ld	a5,-256(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015d0:	0007b503          	ld	a0,0(a5)
    800015d4:	01853703          	ld	a4,24(a0)
    800015d8:	05073783          	ld	a5,80(a4)
    800015dc:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015e0:	fa843783          	ld	a5,-88(s0)
    800015e4:	04200693          	li	a3,66
    800015e8:	24f6ee63          	bltu	a3,a5,80001844 <interruptHandler+0x31c>
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
    80001610:	00001097          	auipc	ra,0x1
    80001614:	7ec080e7          	jalr	2028(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
    80001618:	00006797          	auipc	a5,0x6
    8000161c:	eb07b783          	ld	a5,-336(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    8000165c:	908080e7          	jalr	-1784(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
    80001660:	00006797          	auipc	a5,0x6
    80001664:	e687b783          	ld	a5,-408(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001668:	0007b783          	ld	a5,0(a5)
    8000166c:	0187b783          	ld	a5,24(a5)
    80001670:	04a7b823          	sd	a0,80(a5)
                break;
    80001674:	fb9ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    80001678:	00006797          	auipc	a5,0x6
    8000167c:	e307b783          	ld	a5,-464(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001680:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001684:	00000097          	auipc	ra,0x0
    80001688:	428080e7          	jalr	1064(ra) # 80001aac <_ZN3PCB8dispatchEv>
                break;
    8000168c:	fa1ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->finished = true;
    80001690:	00100793          	li	a5,1
    80001694:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001698:	00006797          	auipc	a5,0x6
    8000169c:	e107b783          	ld	a5,-496(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016a0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	408080e7          	jalr	1032(ra) # 80001aac <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016ac:	00006797          	auipc	a5,0x6
    800016b0:	e1c7b783          	ld	a5,-484(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800016d0:	c04080e7          	jalr	-1020(ra) # 800022d0 <_ZN9Scheduler3putEP3PCB>
                break;
    800016d4:	f59ff06f          	j	8000162c <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d8:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016dc:	06873583          	ld	a1,104(a4)
    800016e0:	06073503          	ld	a0,96(a4)
    800016e4:	00000097          	auipc	ra,0x0
    800016e8:	5a0080e7          	jalr	1440(ra) # 80001c84 <_ZN3PCB14createProccessEPFvvEPv>
    800016ec:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016f0:	00006797          	auipc	a5,0x6
    800016f4:	dd87b783          	ld	a5,-552(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    8000173c:	00001097          	auipc	ra,0x1
    80001740:	60c080e7          	jalr	1548(ra) # 80002d48 <_ZN3SCBnwEm>
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
    80001758:	d747b783          	ld	a5,-652(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000175c:	0007b783          	ld	a5,0(a5)
    80001760:	0187b783          	ld	a5,24(a5)
    80001764:	0497b823          	sd	s1,80(a5)
                break;
    80001768:	ec5ff06f          	j	8000162c <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    8000176c:	05873503          	ld	a0,88(a4)
    80001770:	00001097          	auipc	ra,0x1
    80001774:	4fc080e7          	jalr	1276(ra) # 80002c6c <_ZN3SCB4waitEv>
    80001778:	00006797          	auipc	a5,0x6
    8000177c:	d507b783          	ld	a5,-688(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001780:	0007b783          	ld	a5,0(a5)
    80001784:	0187b783          	ld	a5,24(a5)
    80001788:	04a7b823          	sd	a0,80(a5)
                break;
    8000178c:	ea1ff06f          	j	8000162c <interruptHandler+0x104>
                sem->signal();
    80001790:	05873503          	ld	a0,88(a4)
    80001794:	00001097          	auipc	ra,0x1
    80001798:	56c080e7          	jalr	1388(ra) # 80002d00 <_ZN3SCB6signalEv>
                break;
    8000179c:	e91ff06f          	j	8000162c <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017a0:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017a4:	00048513          	mv	a0,s1
    800017a8:	00001097          	auipc	ra,0x1
    800017ac:	5f0080e7          	jalr	1520(ra) # 80002d98 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017b0:	e6048ee3          	beqz	s1,8000162c <interruptHandler+0x104>
    800017b4:	00048513          	mv	a0,s1
    800017b8:	00001097          	auipc	ra,0x1
    800017bc:	5b8080e7          	jalr	1464(ra) # 80002d70 <_ZN3SCBdlEPv>
    800017c0:	e6dff06f          	j	8000162c <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    800017c4:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017c8:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	158080e7          	jalr	344(ra) # 80001924 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017d4:	e59ff06f          	j	8000162c <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    800017d8:	05874583          	lbu	a1,88(a4)
    800017dc:	00006517          	auipc	a0,0x6
    800017e0:	cb453503          	ld	a0,-844(a0) # 80007490 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017e4:	00000097          	auipc	ra,0x0
    800017e8:	54c080e7          	jalr	1356(ra) # 80001d30 <_ZN8IOBuffer8pushBackEc>
                break;
    800017ec:	e41ff06f          	j	8000162c <interruptHandler+0x104>
                while(CCB::inputBuffer.peekFront() == 0) {
    800017f0:	00006517          	auipc	a0,0x6
    800017f4:	ca853503          	ld	a0,-856(a0) # 80007498 <_GLOBAL_OFFSET_TABLE_+0x30>
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	6bc080e7          	jalr	1724(ra) # 80001eb4 <_ZN8IOBuffer9peekFrontEv>
    80001800:	00051e63          	bnez	a0,8000181c <interruptHandler+0x2f4>
                    CCB::inputBufferEmpty->wait();
    80001804:	00006797          	auipc	a5,0x6
    80001808:	cdc7b783          	ld	a5,-804(a5) # 800074e0 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00001097          	auipc	ra,0x1
    80001814:	45c080e7          	jalr	1116(ra) # 80002c6c <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001818:	fd9ff06f          	j	800017f0 <interruptHandler+0x2c8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000181c:	00006517          	auipc	a0,0x6
    80001820:	c7c53503          	ld	a0,-900(a0) # 80007498 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001824:	00000097          	auipc	ra,0x0
    80001828:	600080e7          	jalr	1536(ra) # 80001e24 <_ZN8IOBuffer8popFrontEv>
    8000182c:	00006797          	auipc	a5,0x6
    80001830:	c9c7b783          	ld	a5,-868(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001834:	0007b783          	ld	a5,0(a5)
    80001838:	0187b783          	ld	a5,24(a5)
    8000183c:	04a7b823          	sd	a0,80(a5)
                break;
    80001840:	dedff06f          	j	8000162c <interruptHandler+0x104>
                printError();
    80001844:	00002097          	auipc	ra,0x2
    80001848:	df0080e7          	jalr	-528(ra) # 80003634 <_Z10printErrorv>
                break;
    8000184c:	de1ff06f          	j	8000162c <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    80001850:	00006497          	auipc	s1,0x6
    80001854:	c584b483          	ld	s1,-936(s1) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001858:	0004b783          	ld	a5,0(s1)
    8000185c:	00178793          	addi	a5,a5,1
    80001860:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001864:	00000097          	auipc	ra,0x0
    80001868:	150080e7          	jalr	336(ra) # 800019b4 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    8000186c:	00006797          	auipc	a5,0x6
    80001870:	c5c7b783          	ld	a5,-932(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001874:	0007b783          	ld	a5,0(a5)
    80001878:	0407b703          	ld	a4,64(a5)
    8000187c:	0004b783          	ld	a5,0(s1)
    80001880:	00e7f863          	bgeu	a5,a4,80001890 <interruptHandler+0x368>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001884:	00200793          	li	a5,2
    80001888:	1447b073          	csrc	sip,a5
    }
    8000188c:	db1ff06f          	j	8000163c <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    80001890:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001894:	00000097          	auipc	ra,0x0
    80001898:	218080e7          	jalr	536(ra) # 80001aac <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    8000189c:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018a0:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018a4:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018a8:	10079073          	csrw	sstatus,a5
    }
    800018ac:	fd9ff06f          	j	80001884 <interruptHandler+0x35c>
        if(plic_claim() == CONSOLE_IRQ) {
    800018b0:	00002097          	auipc	ra,0x2
    800018b4:	6c4080e7          	jalr	1732(ra) # 80003f74 <plic_claim>
    800018b8:	00a00793          	li	a5,10
    800018bc:	04f51c63          	bne	a0,a5,80001914 <interruptHandler+0x3ec>
            if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) { // putc
    800018c0:	00006797          	auipc	a5,0x6
    800018c4:	bc07b783          	ld	a5,-1088(a5) # 80007480 <_GLOBAL_OFFSET_TABLE_+0x18>
    800018c8:	0007b483          	ld	s1,0(a5)
    800018cc:	0004c783          	lbu	a5,0(s1)
    800018d0:	0207f793          	andi	a5,a5,32
    800018d4:	02079463          	bnez	a5,800018fc <interruptHandler+0x3d4>
            if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) { // getc
    800018d8:	0004c783          	lbu	a5,0(s1)
    800018dc:	0017f793          	andi	a5,a5,1
    800018e0:	d4078ee3          	beqz	a5,8000163c <interruptHandler+0x114>
                CCB::semInput->signal();
    800018e4:	00006797          	auipc	a5,0x6
    800018e8:	c0c7b783          	ld	a5,-1012(a5) # 800074f0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800018ec:	0007b503          	ld	a0,0(a5)
    800018f0:	00001097          	auipc	ra,0x1
    800018f4:	410080e7          	jalr	1040(ra) # 80002d00 <_ZN3SCB6signalEv>
    800018f8:	d45ff06f          	j	8000163c <interruptHandler+0x114>
                CCB::semOutput->signal();
    800018fc:	00006797          	auipc	a5,0x6
    80001900:	bdc7b783          	ld	a5,-1060(a5) # 800074d8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001904:	0007b503          	ld	a0,0(a5)
    80001908:	00001097          	auipc	ra,0x1
    8000190c:	3f8080e7          	jalr	1016(ra) # 80002d00 <_ZN3SCB6signalEv>
    80001910:	fc9ff06f          	j	800018d8 <interruptHandler+0x3b0>
            plic_complete(CONSOLE_IRQ);
    80001914:	00a00513          	li	a0,10
    80001918:	00002097          	auipc	ra,0x2
    8000191c:	694080e7          	jalr	1684(ra) # 80003fac <plic_complete>
    80001920:	d1dff06f          	j	8000163c <interruptHandler+0x114>

0000000080001924 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001924:	ff010113          	addi	sp,sp,-16
    80001928:	00813423          	sd	s0,8(sp)
    8000192c:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001930:	00006797          	auipc	a5,0x6
    80001934:	c207b783          	ld	a5,-992(a5) # 80007550 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001938:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    8000193c:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001940:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001944:	00078e63          	beqz	a5,80001960 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    80001948:	0307b683          	ld	a3,48(a5)
    8000194c:	00e6fa63          	bgeu	a3,a4,80001960 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001950:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001954:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001958:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000195c:	fe9ff06f          	j	80001944 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001960:	00100693          	li	a3,1
    80001964:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    80001968:	02060663          	beqz	a2,80001994 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    8000196c:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001970:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001974:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    80001978:	00078863          	beqz	a5,80001988 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    8000197c:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001980:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001984:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    80001988:	00813403          	ld	s0,8(sp)
    8000198c:	01010113          	addi	sp,sp,16
    80001990:	00008067          	ret
        head = process;
    80001994:	00006717          	auipc	a4,0x6
    80001998:	baa73e23          	sd	a0,-1092(a4) # 80007550 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    8000199c:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800019a0:	fe0784e3          	beqz	a5,80001988 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019a4:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019a8:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    800019ac:	02b7b823          	sd	a1,48(a5)
    }
    800019b0:	fd9ff06f          	j	80001988 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

00000000800019b4 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    800019b4:	00006517          	auipc	a0,0x6
    800019b8:	b9c53503          	ld	a0,-1124(a0) # 80007550 <_ZN17SleepingProcesses4headE>
    800019bc:	08050063          	beqz	a0,80001a3c <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800019c0:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800019c4:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800019c8:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800019cc:	06050263          	beqz	a0,80001a30 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800019d0:	03053783          	ld	a5,48(a0)
    800019d4:	04079e63          	bnez	a5,80001a30 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800019d8:	fe010113          	addi	sp,sp,-32
    800019dc:	00113c23          	sd	ra,24(sp)
    800019e0:	00813823          	sd	s0,16(sp)
    800019e4:	00913423          	sd	s1,8(sp)
    800019e8:	02010413          	addi	s0,sp,32
    800019ec:	00c0006f          	j	800019f8 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    800019f0:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800019f4:	02079063          	bnez	a5,80001a14 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800019f8:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800019fc:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001a00:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001a04:	00001097          	auipc	ra,0x1
    80001a08:	8cc080e7          	jalr	-1844(ra) # 800022d0 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001a0c:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001a10:	fe0490e3          	bnez	s1,800019f0 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001a14:	00006797          	auipc	a5,0x6
    80001a18:	b2a7be23          	sd	a0,-1220(a5) # 80007550 <_ZN17SleepingProcesses4headE>
}
    80001a1c:	01813083          	ld	ra,24(sp)
    80001a20:	01013403          	ld	s0,16(sp)
    80001a24:	00813483          	ld	s1,8(sp)
    80001a28:	02010113          	addi	sp,sp,32
    80001a2c:	00008067          	ret
    head = curr;
    80001a30:	00006797          	auipc	a5,0x6
    80001a34:	b2a7b023          	sd	a0,-1248(a5) # 80007550 <_ZN17SleepingProcesses4headE>
    80001a38:	00008067          	ret
    80001a3c:	00008067          	ret

0000000080001a40 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a40:	ff010113          	addi	sp,sp,-16
    80001a44:	00113423          	sd	ra,8(sp)
    80001a48:	00813023          	sd	s0,0(sp)
    80001a4c:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a50:	00000097          	auipc	ra,0x0
    80001a54:	ab8080e7          	jalr	-1352(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a58:	00006797          	auipc	a5,0x6
    80001a5c:	b007b783          	ld	a5,-1280(a5) # 80007558 <_ZN3PCB7runningE>
    80001a60:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a64:	00070513          	mv	a0,a4
    running->main();
    80001a68:	0207b783          	ld	a5,32(a5)
    80001a6c:	000780e7          	jalr	a5
    thread_exit();
    80001a70:	00000097          	auipc	ra,0x0
    80001a74:	830080e7          	jalr	-2000(ra) # 800012a0 <_Z11thread_exitv>
}
    80001a78:	00813083          	ld	ra,8(sp)
    80001a7c:	00013403          	ld	s0,0(sp)
    80001a80:	01010113          	addi	sp,sp,16
    80001a84:	00008067          	ret

0000000080001a88 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001a88:	ff010113          	addi	sp,sp,-16
    80001a8c:	00813423          	sd	s0,8(sp)
    80001a90:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001a94:	01300793          	li	a5,19
    80001a98:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001a9c:	00000073          	ecall
}
    80001aa0:	00813403          	ld	s0,8(sp)
    80001aa4:	01010113          	addi	sp,sp,16
    80001aa8:	00008067          	ret

0000000080001aac <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001aac:	fe010113          	addi	sp,sp,-32
    80001ab0:	00113c23          	sd	ra,24(sp)
    80001ab4:	00813823          	sd	s0,16(sp)
    80001ab8:	00913423          	sd	s1,8(sp)
    80001abc:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001ac0:	00006497          	auipc	s1,0x6
    80001ac4:	a984b483          	ld	s1,-1384(s1) # 80007558 <_ZN3PCB7runningE>
        return finished;
    80001ac8:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001acc:	00079663          	bnez	a5,80001ad8 <_ZN3PCB8dispatchEv+0x2c>
    80001ad0:	0294c783          	lbu	a5,41(s1)
    80001ad4:	04078263          	beqz	a5,80001b18 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001ad8:	00001097          	auipc	ra,0x1
    80001adc:	850080e7          	jalr	-1968(ra) # 80002328 <_ZN9Scheduler3getEv>
    80001ae0:	00006797          	auipc	a5,0x6
    80001ae4:	a6a7bc23          	sd	a0,-1416(a5) # 80007558 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001ae8:	04854783          	lbu	a5,72(a0)
    80001aec:	02078e63          	beqz	a5,80001b28 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001af0:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001af4:	01853583          	ld	a1,24(a0)
    80001af8:	0184b503          	ld	a0,24(s1)
    80001afc:	fffff097          	auipc	ra,0xfffff
    80001b00:	62c080e7          	jalr	1580(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001b04:	01813083          	ld	ra,24(sp)
    80001b08:	01013403          	ld	s0,16(sp)
    80001b0c:	00813483          	ld	s1,8(sp)
    80001b10:	02010113          	addi	sp,sp,32
    80001b14:	00008067          	ret
        Scheduler::put(old);
    80001b18:	00048513          	mv	a0,s1
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	7b4080e7          	jalr	1972(ra) # 800022d0 <_ZN9Scheduler3putEP3PCB>
    80001b24:	fb5ff06f          	j	80001ad8 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b28:	01853583          	ld	a1,24(a0)
    80001b2c:	0184b503          	ld	a0,24(s1)
    80001b30:	fffff097          	auipc	ra,0xfffff
    80001b34:	60c080e7          	jalr	1548(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b38:	fcdff06f          	j	80001b04 <_ZN3PCB8dispatchEv+0x58>

0000000080001b3c <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001b3c:	fe010113          	addi	sp,sp,-32
    80001b40:	00113c23          	sd	ra,24(sp)
    80001b44:	00813823          	sd	s0,16(sp)
    80001b48:	00913423          	sd	s1,8(sp)
    80001b4c:	02010413          	addi	s0,sp,32
    80001b50:	00050493          	mv	s1,a0
    80001b54:	00053023          	sd	zero,0(a0)
    80001b58:	00053c23          	sd	zero,24(a0)
    80001b5c:	02053823          	sd	zero,48(a0)
    80001b60:	00100793          	li	a5,1
    80001b64:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001b68:	02050523          	sb	zero,42(a0)
    80001b6c:	020504a3          	sb	zero,41(a0)
    80001b70:	02050423          	sb	zero,40(a0)
    main = main_;
    80001b74:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001b78:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001b7c:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001b80:	10800513          	li	a0,264
    80001b84:	00001097          	auipc	ra,0x1
    80001b88:	278080e7          	jalr	632(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
    80001b8c:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001b90:	00008537          	lui	a0,0x8
    80001b94:	00001097          	auipc	ra,0x1
    80001b98:	268080e7          	jalr	616(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
    80001b9c:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001ba0:	000087b7          	lui	a5,0x8
    80001ba4:	00f50533          	add	a0,a0,a5
    80001ba8:	0184b783          	ld	a5,24(s1)
    80001bac:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001bb0:	0184b783          	ld	a5,24(s1)
    80001bb4:	00000717          	auipc	a4,0x0
    80001bb8:	e8c70713          	addi	a4,a4,-372 # 80001a40 <_ZN3PCB15proccessWrapperEv>
    80001bbc:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001bc0:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001bc4:	0204b783          	ld	a5,32(s1)
    80001bc8:	00078c63          	beqz	a5,80001be0 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001bcc:	01813083          	ld	ra,24(sp)
    80001bd0:	01013403          	ld	s0,16(sp)
    80001bd4:	00813483          	ld	s1,8(sp)
    80001bd8:	02010113          	addi	sp,sp,32
    80001bdc:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001be0:	04048423          	sb	zero,72(s1)
}
    80001be4:	fe9ff06f          	j	80001bcc <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001be8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001be8:	fe010113          	addi	sp,sp,-32
    80001bec:	00113c23          	sd	ra,24(sp)
    80001bf0:	00813823          	sd	s0,16(sp)
    80001bf4:	00913423          	sd	s1,8(sp)
    80001bf8:	02010413          	addi	s0,sp,32
    80001bfc:	00050493          	mv	s1,a0
    delete[] stack;
    80001c00:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001c04:	00050663          	beqz	a0,80001c10 <_ZN3PCBD1Ev+0x28>
    80001c08:	00001097          	auipc	ra,0x1
    80001c0c:	ab4080e7          	jalr	-1356(ra) # 800026bc <_ZdaPv>
    delete[] sysStack;
    80001c10:	0104b503          	ld	a0,16(s1)
    80001c14:	00050663          	beqz	a0,80001c20 <_ZN3PCBD1Ev+0x38>
    80001c18:	00001097          	auipc	ra,0x1
    80001c1c:	aa4080e7          	jalr	-1372(ra) # 800026bc <_ZdaPv>
}
    80001c20:	01813083          	ld	ra,24(sp)
    80001c24:	01013403          	ld	s0,16(sp)
    80001c28:	00813483          	ld	s1,8(sp)
    80001c2c:	02010113          	addi	sp,sp,32
    80001c30:	00008067          	ret

0000000080001c34 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001c34:	ff010113          	addi	sp,sp,-16
    80001c38:	00113423          	sd	ra,8(sp)
    80001c3c:	00813023          	sd	s0,0(sp)
    80001c40:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c44:	00001097          	auipc	ra,0x1
    80001c48:	1b8080e7          	jalr	440(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
}
    80001c4c:	00813083          	ld	ra,8(sp)
    80001c50:	00013403          	ld	s0,0(sp)
    80001c54:	01010113          	addi	sp,sp,16
    80001c58:	00008067          	ret

0000000080001c5c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c5c:	ff010113          	addi	sp,sp,-16
    80001c60:	00113423          	sd	ra,8(sp)
    80001c64:	00813023          	sd	s0,0(sp)
    80001c68:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c6c:	00001097          	auipc	ra,0x1
    80001c70:	2f4080e7          	jalr	756(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c74:	00813083          	ld	ra,8(sp)
    80001c78:	00013403          	ld	s0,0(sp)
    80001c7c:	01010113          	addi	sp,sp,16
    80001c80:	00008067          	ret

0000000080001c84 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001c84:	fd010113          	addi	sp,sp,-48
    80001c88:	02113423          	sd	ra,40(sp)
    80001c8c:	02813023          	sd	s0,32(sp)
    80001c90:	00913c23          	sd	s1,24(sp)
    80001c94:	01213823          	sd	s2,16(sp)
    80001c98:	01313423          	sd	s3,8(sp)
    80001c9c:	03010413          	addi	s0,sp,48
    80001ca0:	00050913          	mv	s2,a0
    80001ca4:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001ca8:	05000513          	li	a0,80
    80001cac:	00000097          	auipc	ra,0x0
    80001cb0:	f88080e7          	jalr	-120(ra) # 80001c34 <_ZN3PCBnwEm>
    80001cb4:	00050493          	mv	s1,a0
    80001cb8:	00098693          	mv	a3,s3
    80001cbc:	00200613          	li	a2,2
    80001cc0:	00090593          	mv	a1,s2
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	e78080e7          	jalr	-392(ra) # 80001b3c <_ZN3PCBC1EPFvvEmPv>
    80001ccc:	0200006f          	j	80001cec <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001cd0:	00050913          	mv	s2,a0
    80001cd4:	00048513          	mv	a0,s1
    80001cd8:	00000097          	auipc	ra,0x0
    80001cdc:	f84080e7          	jalr	-124(ra) # 80001c5c <_ZN3PCBdlEPv>
    80001ce0:	00090513          	mv	a0,s2
    80001ce4:	00007097          	auipc	ra,0x7
    80001ce8:	9c4080e7          	jalr	-1596(ra) # 800086a8 <_Unwind_Resume>
}
    80001cec:	00048513          	mv	a0,s1
    80001cf0:	02813083          	ld	ra,40(sp)
    80001cf4:	02013403          	ld	s0,32(sp)
    80001cf8:	01813483          	ld	s1,24(sp)
    80001cfc:	01013903          	ld	s2,16(sp)
    80001d00:	00813983          	ld	s3,8(sp)
    80001d04:	03010113          	addi	sp,sp,48
    80001d08:	00008067          	ret

0000000080001d0c <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001d0c:	ff010113          	addi	sp,sp,-16
    80001d10:	00813423          	sd	s0,8(sp)
    80001d14:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001d18:	00006797          	auipc	a5,0x6
    80001d1c:	8407b783          	ld	a5,-1984(a5) # 80007558 <_ZN3PCB7runningE>
    80001d20:	0187b503          	ld	a0,24(a5)
    80001d24:	00813403          	ld	s0,8(sp)
    80001d28:	01010113          	addi	sp,sp,16
    80001d2c:	00008067          	ret

0000000080001d30 <_ZN8IOBuffer8pushBackEc>:
        sem_wait(semOutput);
    }
}


void IOBuffer::pushBack(char c) {
    80001d30:	fe010113          	addi	sp,sp,-32
    80001d34:	00113c23          	sd	ra,24(sp)
    80001d38:	00813823          	sd	s0,16(sp)
    80001d3c:	00913423          	sd	s1,8(sp)
    80001d40:	01213023          	sd	s2,0(sp)
    80001d44:	02010413          	addi	s0,sp,32
    80001d48:	00050493          	mv	s1,a0
    80001d4c:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001d50:	01000513          	li	a0,16
    80001d54:	00001097          	auipc	ra,0x1
    80001d58:	0a8080e7          	jalr	168(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001d5c:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001d60:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001d64:	0004b783          	ld	a5,0(s1)
    80001d68:	02078863          	beqz	a5,80001d98 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001d6c:	0084b783          	ld	a5,8(s1)
    80001d70:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001d74:	0084b783          	ld	a5,8(s1)
    80001d78:	0007b783          	ld	a5,0(a5)
    80001d7c:	00f4b423          	sd	a5,8(s1)
    }
}
    80001d80:	01813083          	ld	ra,24(sp)
    80001d84:	01013403          	ld	s0,16(sp)
    80001d88:	00813483          	ld	s1,8(sp)
    80001d8c:	00013903          	ld	s2,0(sp)
    80001d90:	02010113          	addi	sp,sp,32
    80001d94:	00008067          	ret
        head = tail = newElem;
    80001d98:	00a4b423          	sd	a0,8(s1)
    80001d9c:	00a4b023          	sd	a0,0(s1)
    80001da0:	fe1ff06f          	j	80001d80 <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001da4 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001da4:	fe010113          	addi	sp,sp,-32
    80001da8:	00113c23          	sd	ra,24(sp)
    80001dac:	00813823          	sd	s0,16(sp)
    80001db0:	00913423          	sd	s1,8(sp)
    80001db4:	02010413          	addi	s0,sp,32
    80001db8:	0340006f          	j	80001dec <_ZN3CCB9inputBodyEPv+0x48>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001dbc:	00005797          	auipc	a5,0x5
    80001dc0:	6b47b783          	ld	a5,1716(a5) # 80007470 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001dc4:	0007b783          	ld	a5,0(a5)
    80001dc8:	00005497          	auipc	s1,0x5
    80001dcc:	7a048493          	addi	s1,s1,1952 # 80007568 <_ZN3CCB11inputBufferE>
    80001dd0:	0007c583          	lbu	a1,0(a5)
    80001dd4:	00048513          	mv	a0,s1
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	f58080e7          	jalr	-168(ra) # 80001d30 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001de0:	0104b503          	ld	a0,16(s1)
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	5fc080e7          	jalr	1532(ra) # 800013e0 <_Z10sem_signalP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001dec:	00005797          	auipc	a5,0x5
    80001df0:	6947b783          	ld	a5,1684(a5) # 80007480 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001df4:	0007b783          	ld	a5,0(a5)
    80001df8:	0007c783          	lbu	a5,0(a5)
    80001dfc:	0017f793          	andi	a5,a5,1
    80001e00:	fa079ee3          	bnez	a5,80001dbc <_ZN3CCB9inputBodyEPv+0x18>
        plic_complete(CONSOLE_IRQ);
    80001e04:	00a00513          	li	a0,10
    80001e08:	00002097          	auipc	ra,0x2
    80001e0c:	1a4080e7          	jalr	420(ra) # 80003fac <plic_complete>
        sem_wait(CCB::semInput);
    80001e10:	00005517          	auipc	a0,0x5
    80001e14:	77053503          	ld	a0,1904(a0) # 80007580 <_ZN3CCB8semInputE>
    80001e18:	fffff097          	auipc	ra,0xfffff
    80001e1c:	580080e7          	jalr	1408(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001e20:	fcdff06f          	j	80001dec <_ZN3CCB9inputBodyEPv+0x48>

0000000080001e24 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001e24:	fe010113          	addi	sp,sp,-32
    80001e28:	00113c23          	sd	ra,24(sp)
    80001e2c:	00813823          	sd	s0,16(sp)
    80001e30:	00913423          	sd	s1,8(sp)
    80001e34:	02010413          	addi	s0,sp,32
    80001e38:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001e3c:	00053503          	ld	a0,0(a0)
    80001e40:	04050063          	beqz	a0,80001e80 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001e44:	00053703          	ld	a4,0(a0)
    80001e48:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001e4c:	0087b703          	ld	a4,8(a5)
    80001e50:	02e50463          	beq	a0,a4,80001e78 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001e54:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001e58:	00001097          	auipc	ra,0x1
    80001e5c:	108080e7          	jalr	264(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001e60:	00048513          	mv	a0,s1
    80001e64:	01813083          	ld	ra,24(sp)
    80001e68:	01013403          	ld	s0,16(sp)
    80001e6c:	00813483          	ld	s1,8(sp)
    80001e70:	02010113          	addi	sp,sp,32
    80001e74:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001e78:	0007b423          	sd	zero,8(a5)
    80001e7c:	fd9ff06f          	j	80001e54 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001e80:	00000493          	li	s1,0
    80001e84:	fddff06f          	j	80001e60 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001e88 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001e88:	ff010113          	addi	sp,sp,-16
    80001e8c:	00813423          	sd	s0,8(sp)
    80001e90:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001e94:	00853783          	ld	a5,8(a0)
    80001e98:	00078a63          	beqz	a5,80001eac <_ZN8IOBuffer8peekBackEv+0x24>
    80001e9c:	0087c503          	lbu	a0,8(a5)
}
    80001ea0:	00813403          	ld	s0,8(sp)
    80001ea4:	01010113          	addi	sp,sp,16
    80001ea8:	00008067          	ret
    return tail ? tail->data : 0;
    80001eac:	00000513          	li	a0,0
    80001eb0:	ff1ff06f          	j	80001ea0 <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001eb4 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001eb4:	ff010113          	addi	sp,sp,-16
    80001eb8:	00813423          	sd	s0,8(sp)
    80001ebc:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001ec0:	00053783          	ld	a5,0(a0)
    80001ec4:	00078a63          	beqz	a5,80001ed8 <_ZN8IOBuffer9peekFrontEv+0x24>
    80001ec8:	0087c503          	lbu	a0,8(a5)
}
    80001ecc:	00813403          	ld	s0,8(sp)
    80001ed0:	01010113          	addi	sp,sp,16
    80001ed4:	00008067          	ret
    return head ? head->data : 0;
    80001ed8:	00000513          	li	a0,0
    80001edc:	ff1ff06f          	j	80001ecc <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001ee0 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001ee0:	fe010113          	addi	sp,sp,-32
    80001ee4:	00113c23          	sd	ra,24(sp)
    80001ee8:	00813823          	sd	s0,16(sp)
    80001eec:	00913423          	sd	s1,8(sp)
    80001ef0:	02010413          	addi	s0,sp,32
    80001ef4:	0200006f          	j	80001f14 <_ZN3CCB10outputBodyEPv+0x34>
        plic_complete(CONSOLE_IRQ);
    80001ef8:	00a00513          	li	a0,10
    80001efc:	00002097          	auipc	ra,0x2
    80001f00:	0b0080e7          	jalr	176(ra) # 80003fac <plic_complete>
        sem_wait(semOutput);
    80001f04:	00005517          	auipc	a0,0x5
    80001f08:	69453503          	ld	a0,1684(a0) # 80007598 <_ZN3CCB9semOutputE>
    80001f0c:	fffff097          	auipc	ra,0xfffff
    80001f10:	48c080e7          	jalr	1164(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f14:	00005797          	auipc	a5,0x5
    80001f18:	56c7b783          	ld	a5,1388(a5) # 80007480 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001f1c:	0007b783          	ld	a5,0(a5)
    80001f20:	0007c783          	lbu	a5,0(a5)
    80001f24:	0207f793          	andi	a5,a5,32
    80001f28:	fc0788e3          	beqz	a5,80001ef8 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() == 0) break;
    80001f2c:	00005517          	auipc	a0,0x5
    80001f30:	65c50513          	addi	a0,a0,1628 # 80007588 <_ZN3CCB12outputBufferE>
    80001f34:	00000097          	auipc	ra,0x0
    80001f38:	f80080e7          	jalr	-128(ra) # 80001eb4 <_ZN8IOBuffer9peekFrontEv>
    80001f3c:	fa050ee3          	beqz	a0,80001ef8 <_ZN3CCB10outputBodyEPv+0x18>
            *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001f40:	00005797          	auipc	a5,0x5
    80001f44:	5607b783          	ld	a5,1376(a5) # 800074a0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001f48:	0007b483          	ld	s1,0(a5)
    80001f4c:	00005517          	auipc	a0,0x5
    80001f50:	63c50513          	addi	a0,a0,1596 # 80007588 <_ZN3CCB12outputBufferE>
    80001f54:	00000097          	auipc	ra,0x0
    80001f58:	ed0080e7          	jalr	-304(ra) # 80001e24 <_ZN8IOBuffer8popFrontEv>
    80001f5c:	00a48023          	sb	a0,0(s1)
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f60:	fb5ff06f          	j	80001f14 <_ZN3CCB10outputBodyEPv+0x34>

0000000080001f64 <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"
#include "../h/console.h"

BufferCPP::BufferCPP(int _cap) : cap(_cap), head(0), tail(0) {
    80001f64:	fe010113          	addi	sp,sp,-32
    80001f68:	00113c23          	sd	ra,24(sp)
    80001f6c:	00813823          	sd	s0,16(sp)
    80001f70:	00913423          	sd	s1,8(sp)
    80001f74:	01213023          	sd	s2,0(sp)
    80001f78:	02010413          	addi	s0,sp,32
    80001f7c:	00050493          	mv	s1,a0
    80001f80:	00b52023          	sw	a1,0(a0)
    80001f84:	00052823          	sw	zero,16(a0)
    80001f88:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80001f8c:	00259513          	slli	a0,a1,0x2
    80001f90:	fffff097          	auipc	ra,0xfffff
    80001f94:	204080e7          	jalr	516(ra) # 80001194 <_Z9mem_allocm>
    80001f98:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80001f9c:	01000513          	li	a0,16
    80001fa0:	00001097          	auipc	ra,0x1
    80001fa4:	a6c080e7          	jalr	-1428(ra) # 80002a0c <_ZN9SemaphorenwEm>
    80001fa8:	00050913          	mv	s2,a0
    80001fac:	00000593          	li	a1,0
    80001fb0:	00001097          	auipc	ra,0x1
    80001fb4:	93c080e7          	jalr	-1732(ra) # 800028ec <_ZN9SemaphoreC1Ej>
    80001fb8:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(cap);
    80001fbc:	01000513          	li	a0,16
    80001fc0:	00001097          	auipc	ra,0x1
    80001fc4:	a4c080e7          	jalr	-1460(ra) # 80002a0c <_ZN9SemaphorenwEm>
    80001fc8:	00050913          	mv	s2,a0
    80001fcc:	0004a583          	lw	a1,0(s1)
    80001fd0:	00001097          	auipc	ra,0x1
    80001fd4:	91c080e7          	jalr	-1764(ra) # 800028ec <_ZN9SemaphoreC1Ej>
    80001fd8:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80001fdc:	01000513          	li	a0,16
    80001fe0:	00001097          	auipc	ra,0x1
    80001fe4:	a2c080e7          	jalr	-1492(ra) # 80002a0c <_ZN9SemaphorenwEm>
    80001fe8:	00050913          	mv	s2,a0
    80001fec:	00100593          	li	a1,1
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	8fc080e7          	jalr	-1796(ra) # 800028ec <_ZN9SemaphoreC1Ej>
    80001ff8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80001ffc:	01000513          	li	a0,16
    80002000:	00001097          	auipc	ra,0x1
    80002004:	a0c080e7          	jalr	-1524(ra) # 80002a0c <_ZN9SemaphorenwEm>
    80002008:	00050913          	mv	s2,a0
    8000200c:	00100593          	li	a1,1
    80002010:	00001097          	auipc	ra,0x1
    80002014:	8dc080e7          	jalr	-1828(ra) # 800028ec <_ZN9SemaphoreC1Ej>
    80002018:	0324b823          	sd	s2,48(s1)
}
    8000201c:	01813083          	ld	ra,24(sp)
    80002020:	01013403          	ld	s0,16(sp)
    80002024:	00813483          	ld	s1,8(sp)
    80002028:	00013903          	ld	s2,0(sp)
    8000202c:	02010113          	addi	sp,sp,32
    80002030:	00008067          	ret
    80002034:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80002038:	00090513          	mv	a0,s2
    8000203c:	00001097          	auipc	ra,0x1
    80002040:	968080e7          	jalr	-1688(ra) # 800029a4 <_ZN9SemaphoredlEPv>
    80002044:	00048513          	mv	a0,s1
    80002048:	00006097          	auipc	ra,0x6
    8000204c:	660080e7          	jalr	1632(ra) # 800086a8 <_Unwind_Resume>
    80002050:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(cap);
    80002054:	00090513          	mv	a0,s2
    80002058:	00001097          	auipc	ra,0x1
    8000205c:	94c080e7          	jalr	-1716(ra) # 800029a4 <_ZN9SemaphoredlEPv>
    80002060:	00048513          	mv	a0,s1
    80002064:	00006097          	auipc	ra,0x6
    80002068:	644080e7          	jalr	1604(ra) # 800086a8 <_Unwind_Resume>
    8000206c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80002070:	00090513          	mv	a0,s2
    80002074:	00001097          	auipc	ra,0x1
    80002078:	930080e7          	jalr	-1744(ra) # 800029a4 <_ZN9SemaphoredlEPv>
    8000207c:	00048513          	mv	a0,s1
    80002080:	00006097          	auipc	ra,0x6
    80002084:	628080e7          	jalr	1576(ra) # 800086a8 <_Unwind_Resume>
    80002088:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000208c:	00090513          	mv	a0,s2
    80002090:	00001097          	auipc	ra,0x1
    80002094:	914080e7          	jalr	-1772(ra) # 800029a4 <_ZN9SemaphoredlEPv>
    80002098:	00048513          	mv	a0,s1
    8000209c:	00006097          	auipc	ra,0x6
    800020a0:	60c080e7          	jalr	1548(ra) # 800086a8 <_Unwind_Resume>

00000000800020a4 <_ZN9BufferCPPD1Ev>:

BufferCPP::~BufferCPP() {
    800020a4:	fe010113          	addi	sp,sp,-32
    800020a8:	00113c23          	sd	ra,24(sp)
    800020ac:	00813823          	sd	s0,16(sp)
    800020b0:	00913423          	sd	s1,8(sp)
    800020b4:	02010413          	addi	s0,sp,32
    800020b8:	00050493          	mv	s1,a0
    __putc('\n');
    800020bc:	00a00513          	li	a0,10
    800020c0:	00003097          	auipc	ra,0x3
    800020c4:	71c080e7          	jalr	1820(ra) # 800057dc <__putc>
    printString("Buffer deleted!\n");
    800020c8:	00004517          	auipc	a0,0x4
    800020cc:	06850513          	addi	a0,a0,104 # 80006130 <CONSOLE_STATUS+0x120>
    800020d0:	00001097          	auipc	ra,0x1
    800020d4:	2b8080e7          	jalr	696(ra) # 80003388 <_Z11printStringPKc>
    while (head != tail) {
    800020d8:	0104a783          	lw	a5,16(s1)
    800020dc:	0144a703          	lw	a4,20(s1)
    800020e0:	02e78a63          	beq	a5,a4,80002114 <_ZN9BufferCPPD1Ev+0x70>
        char ch = buffer[head];
    800020e4:	0084b703          	ld	a4,8(s1)
    800020e8:	00279793          	slli	a5,a5,0x2
    800020ec:	00f707b3          	add	a5,a4,a5
        __putc(ch);
    800020f0:	0007c503          	lbu	a0,0(a5)
    800020f4:	00003097          	auipc	ra,0x3
    800020f8:	6e8080e7          	jalr	1768(ra) # 800057dc <__putc>
        head = (head + 1) % cap;
    800020fc:	0104a783          	lw	a5,16(s1)
    80002100:	0017879b          	addiw	a5,a5,1
    80002104:	0004a703          	lw	a4,0(s1)
    80002108:	02e7e7bb          	remw	a5,a5,a4
    8000210c:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80002110:	fc9ff06f          	j	800020d8 <_ZN9BufferCPPD1Ev+0x34>
    }
    __putc('!');
    80002114:	02100513          	li	a0,33
    80002118:	00003097          	auipc	ra,0x3
    8000211c:	6c4080e7          	jalr	1732(ra) # 800057dc <__putc>
    __putc('\n');
    80002120:	00a00513          	li	a0,10
    80002124:	00003097          	auipc	ra,0x3
    80002128:	6b8080e7          	jalr	1720(ra) # 800057dc <__putc>

    mem_free(buffer);
    8000212c:	0084b503          	ld	a0,8(s1)
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	0a4080e7          	jalr	164(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80002138:	0204b503          	ld	a0,32(s1)
    8000213c:	00050863          	beqz	a0,8000214c <_ZN9BufferCPPD1Ev+0xa8>
    80002140:	00053783          	ld	a5,0(a0)
    80002144:	0087b783          	ld	a5,8(a5)
    80002148:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000214c:	0184b503          	ld	a0,24(s1)
    80002150:	00050863          	beqz	a0,80002160 <_ZN9BufferCPPD1Ev+0xbc>
    80002154:	00053783          	ld	a5,0(a0)
    80002158:	0087b783          	ld	a5,8(a5)
    8000215c:	000780e7          	jalr	a5
    delete mutexTail;
    80002160:	0304b503          	ld	a0,48(s1)
    80002164:	00050863          	beqz	a0,80002174 <_ZN9BufferCPPD1Ev+0xd0>
    80002168:	00053783          	ld	a5,0(a0)
    8000216c:	0087b783          	ld	a5,8(a5)
    80002170:	000780e7          	jalr	a5
    delete mutexHead;
    80002174:	0284b503          	ld	a0,40(s1)
    80002178:	00050863          	beqz	a0,80002188 <_ZN9BufferCPPD1Ev+0xe4>
    8000217c:	00053783          	ld	a5,0(a0)
    80002180:	0087b783          	ld	a5,8(a5)
    80002184:	000780e7          	jalr	a5

}
    80002188:	01813083          	ld	ra,24(sp)
    8000218c:	01013403          	ld	s0,16(sp)
    80002190:	00813483          	ld	s1,8(sp)
    80002194:	02010113          	addi	sp,sp,32
    80002198:	00008067          	ret

000000008000219c <_ZN9BufferCPP3putEi>:

void BufferCPP::put(int val) {
    8000219c:	fe010113          	addi	sp,sp,-32
    800021a0:	00113c23          	sd	ra,24(sp)
    800021a4:	00813823          	sd	s0,16(sp)
    800021a8:	00913423          	sd	s1,8(sp)
    800021ac:	01213023          	sd	s2,0(sp)
    800021b0:	02010413          	addi	s0,sp,32
    800021b4:	00050493          	mv	s1,a0
    800021b8:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800021bc:	01853503          	ld	a0,24(a0)
    800021c0:	00000097          	auipc	ra,0x0
    800021c4:	78c080e7          	jalr	1932(ra) # 8000294c <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800021c8:	0304b503          	ld	a0,48(s1)
    800021cc:	00000097          	auipc	ra,0x0
    800021d0:	780080e7          	jalr	1920(ra) # 8000294c <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800021d4:	0084b783          	ld	a5,8(s1)
    800021d8:	0144a703          	lw	a4,20(s1)
    800021dc:	00271713          	slli	a4,a4,0x2
    800021e0:	00e787b3          	add	a5,a5,a4
    800021e4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800021e8:	0144a783          	lw	a5,20(s1)
    800021ec:	0017879b          	addiw	a5,a5,1
    800021f0:	0004a703          	lw	a4,0(s1)
    800021f4:	02e7e7bb          	remw	a5,a5,a4
    800021f8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800021fc:	0304b503          	ld	a0,48(s1)
    80002200:	00000097          	auipc	ra,0x0
    80002204:	778080e7          	jalr	1912(ra) # 80002978 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80002208:	0204b503          	ld	a0,32(s1)
    8000220c:	00000097          	auipc	ra,0x0
    80002210:	76c080e7          	jalr	1900(ra) # 80002978 <_ZN9Semaphore6signalEv>

}
    80002214:	01813083          	ld	ra,24(sp)
    80002218:	01013403          	ld	s0,16(sp)
    8000221c:	00813483          	ld	s1,8(sp)
    80002220:	00013903          	ld	s2,0(sp)
    80002224:	02010113          	addi	sp,sp,32
    80002228:	00008067          	ret

000000008000222c <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    8000222c:	fe010113          	addi	sp,sp,-32
    80002230:	00113c23          	sd	ra,24(sp)
    80002234:	00813823          	sd	s0,16(sp)
    80002238:	00913423          	sd	s1,8(sp)
    8000223c:	01213023          	sd	s2,0(sp)
    80002240:	02010413          	addi	s0,sp,32
    80002244:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80002248:	02053503          	ld	a0,32(a0)
    8000224c:	00000097          	auipc	ra,0x0
    80002250:	700080e7          	jalr	1792(ra) # 8000294c <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80002254:	0284b503          	ld	a0,40(s1)
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	6f4080e7          	jalr	1780(ra) # 8000294c <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80002260:	0084b703          	ld	a4,8(s1)
    80002264:	0104a783          	lw	a5,16(s1)
    80002268:	00279693          	slli	a3,a5,0x2
    8000226c:	00d70733          	add	a4,a4,a3
    80002270:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80002274:	0017879b          	addiw	a5,a5,1
    80002278:	0004a703          	lw	a4,0(s1)
    8000227c:	02e7e7bb          	remw	a5,a5,a4
    80002280:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80002284:	0284b503          	ld	a0,40(s1)
    80002288:	00000097          	auipc	ra,0x0
    8000228c:	6f0080e7          	jalr	1776(ra) # 80002978 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80002290:	0184b503          	ld	a0,24(s1)
    80002294:	00000097          	auipc	ra,0x0
    80002298:	6e4080e7          	jalr	1764(ra) # 80002978 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000229c:	00090513          	mv	a0,s2
    800022a0:	01813083          	ld	ra,24(sp)
    800022a4:	01013403          	ld	s0,16(sp)
    800022a8:	00813483          	ld	s1,8(sp)
    800022ac:	00013903          	ld	s2,0(sp)
    800022b0:	02010113          	addi	sp,sp,32
    800022b4:	00008067          	ret

00000000800022b8 <_Z8userMainv>:
    __putc('\n');
}*/



void userMain() {
    800022b8:	ff010113          	addi	sp,sp,-16
    800022bc:	00813423          	sd	s0,8(sp)
    800022c0:	01010413          	addi	s0,sp,16
    return;
}
    800022c4:	00813403          	ld	s0,8(sp)
    800022c8:	01010113          	addi	sp,sp,16
    800022cc:	00008067          	ret

00000000800022d0 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800022d0:	ff010113          	addi	sp,sp,-16
    800022d4:	00813423          	sd	s0,8(sp)
    800022d8:	01010413          	addi	s0,sp,16
    if(!process) return;
    800022dc:	02050663          	beqz	a0,80002308 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    800022e0:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800022e4:	00005797          	auipc	a5,0x5
    800022e8:	2cc7b783          	ld	a5,716(a5) # 800075b0 <_ZN9Scheduler4tailE>
    800022ec:	02078463          	beqz	a5,80002314 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    800022f0:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    800022f4:	00005797          	auipc	a5,0x5
    800022f8:	2bc78793          	addi	a5,a5,700 # 800075b0 <_ZN9Scheduler4tailE>
    800022fc:	0007b703          	ld	a4,0(a5)
    80002300:	00073703          	ld	a4,0(a4)
    80002304:	00e7b023          	sd	a4,0(a5)
    }
}
    80002308:	00813403          	ld	s0,8(sp)
    8000230c:	01010113          	addi	sp,sp,16
    80002310:	00008067          	ret
        head = tail = process;
    80002314:	00005797          	auipc	a5,0x5
    80002318:	29c78793          	addi	a5,a5,668 # 800075b0 <_ZN9Scheduler4tailE>
    8000231c:	00a7b023          	sd	a0,0(a5)
    80002320:	00a7b423          	sd	a0,8(a5)
    80002324:	fe5ff06f          	j	80002308 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002328 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00813423          	sd	s0,8(sp)
    80002330:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002334:	00005517          	auipc	a0,0x5
    80002338:	28453503          	ld	a0,644(a0) # 800075b8 <_ZN9Scheduler4headE>
    8000233c:	02050463          	beqz	a0,80002364 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002340:	00053703          	ld	a4,0(a0)
    80002344:	00005797          	auipc	a5,0x5
    80002348:	26c78793          	addi	a5,a5,620 # 800075b0 <_ZN9Scheduler4tailE>
    8000234c:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002350:	0007b783          	ld	a5,0(a5)
    80002354:	00f50e63          	beq	a0,a5,80002370 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002358:	00813403          	ld	s0,8(sp)
    8000235c:	01010113          	addi	sp,sp,16
    80002360:	00008067          	ret
        return idleProcess;
    80002364:	00005517          	auipc	a0,0x5
    80002368:	25c53503          	ld	a0,604(a0) # 800075c0 <_ZN9Scheduler11idleProcessE>
    8000236c:	fedff06f          	j	80002358 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002370:	00005797          	auipc	a5,0x5
    80002374:	24e7b023          	sd	a4,576(a5) # 800075b0 <_ZN9Scheduler4tailE>
    80002378:	fe1ff06f          	j	80002358 <_ZN9Scheduler3getEv+0x30>

000000008000237c <_Z8userModev>:

PCB* userProcess;

void userMain();
extern "C" void interrupt();
void userMode() {
    8000237c:	fe010113          	addi	sp,sp,-32
    80002380:	00813c23          	sd	s0,24(sp)
    80002384:	02010413          	addi	s0,sp,32
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002388:	00005797          	auipc	a5,0x5
    8000238c:	1607b783          	ld	a5,352(a5) # 800074e8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002390:	10579073          	csrw	stvec,a5
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002394:	10000793          	li	a5,256
    80002398:	1007b073          	csrc	sstatus,a5
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000239c:	141027f3          	csrr	a5,sepc
    800023a0:	fef43023          	sd	a5,-32(s0)
        return sepc;
    800023a4:	fe043783          	ld	a5,-32(s0)
    Kernel::mc_sstatus(Kernel::BitMaskSstatus::SSTATUS_SPP); // vraticemo se u korisnicki rezim
    size_t volatile sepc = Kernel::r_sepc();
    800023a8:	fef43423          	sd	a5,-24(s0)
    sepc += 4;
    800023ac:	fe843783          	ld	a5,-24(s0)
    800023b0:	00478793          	addi	a5,a5,4
    800023b4:	fef43423          	sd	a5,-24(s0)
    Kernel::w_sepc(sepc);
    800023b8:	fe843783          	ld	a5,-24(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800023bc:	14179073          	csrw	sepc,a5
    asm volatile("sret");
    800023c0:	10200073          	sret
}
    800023c4:	01813403          	ld	s0,24(sp)
    800023c8:	02010113          	addi	sp,sp,32
    800023cc:	00008067          	ret

00000000800023d0 <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    800023d0:	ff010113          	addi	sp,sp,-16
    800023d4:	00813423          	sd	s0,8(sp)
    800023d8:	01010413          	addi	s0,sp,16
    while(true) {}
    800023dc:	0000006f          	j	800023dc <idleProcess+0xc>

00000000800023e0 <_Z15userMainWrapperPv>:

void userMainWrapper(void*) {
    800023e0:	ff010113          	addi	sp,sp,-16
    800023e4:	00113423          	sd	ra,8(sp)
    800023e8:	00813023          	sd	s0,0(sp)
    800023ec:	01010413          	addi	s0,sp,16
    asm volatile("csrw stvec, %0" : : "r" (&userMode));
    800023f0:	00000797          	auipc	a5,0x0
    800023f4:	f8c78793          	addi	a5,a5,-116 # 8000237c <_Z8userModev>
    800023f8:	10579073          	csrw	stvec,a5
    asm volatile("ecall"); // da bismo presli u korisnicki rezim
    800023fc:	00000073          	ecall
    userMain();
    80002400:	00000097          	auipc	ra,0x0
    80002404:	eb8080e7          	jalr	-328(ra) # 800022b8 <_Z8userMainv>
}
    80002408:	00813083          	ld	ra,8(sp)
    8000240c:	00013403          	ld	s0,0(sp)
    80002410:	01010113          	addi	sp,sp,16
    80002414:	00008067          	ret

0000000080002418 <main>:
}
// ------------

int main() {
    80002418:	ff010113          	addi	sp,sp,-16
    8000241c:	00113423          	sd	ra,8(sp)
    80002420:	00813023          	sd	s0,0(sp)
    80002424:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002428:	00005797          	auipc	a5,0x5
    8000242c:	0c07b783          	ld	a5,192(a5) # 800074e8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002430:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002434:	00000593          	li	a1,0
    80002438:	00000513          	li	a0,0
    8000243c:	00000097          	auipc	ra,0x0
    80002440:	848080e7          	jalr	-1976(ra) # 80001c84 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80002444:	00005797          	auipc	a5,0x5
    80002448:	0847b783          	ld	a5,132(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000244c:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    80002450:	00000593          	li	a1,0
    80002454:	00005517          	auipc	a0,0x5
    80002458:	09c53503          	ld	a0,156(a0) # 800074f0 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000245c:	fffff097          	auipc	ra,0xfffff
    80002460:	ef4080e7          	jalr	-268(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    80002464:	00000593          	li	a1,0
    80002468:	00005517          	auipc	a0,0x5
    8000246c:	07053503          	ld	a0,112(a0) # 800074d8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002470:	fffff097          	auipc	ra,0xfffff
    80002474:	ee0080e7          	jalr	-288(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    80002478:	00000593          	li	a1,0
    8000247c:	00005517          	auipc	a0,0x5
    80002480:	06453503          	ld	a0,100(a0) # 800074e0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002484:	fffff097          	auipc	ra,0xfffff
    80002488:	ecc080e7          	jalr	-308(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000248c:	00200793          	li	a5,2
    80002490:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002494:	00000613          	li	a2,0
    80002498:	00005597          	auipc	a1,0x5
    8000249c:	0205b583          	ld	a1,32(a1) # 800074b8 <_GLOBAL_OFFSET_TABLE_+0x50>
    800024a0:	00005517          	auipc	a0,0x5
    800024a4:	06053503          	ld	a0,96(a0) # 80007500 <_GLOBAL_OFFSET_TABLE_+0x98>
    800024a8:	fffff097          	auipc	ra,0xfffff
    800024ac:	e58080e7          	jalr	-424(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800024b0:	00000613          	li	a2,0
    800024b4:	00005597          	auipc	a1,0x5
    800024b8:	0445b583          	ld	a1,68(a1) # 800074f8 <_GLOBAL_OFFSET_TABLE_+0x90>
    800024bc:	00005517          	auipc	a0,0x5
    800024c0:	fbc53503          	ld	a0,-68(a0) # 80007478 <_GLOBAL_OFFSET_TABLE_+0x10>
    800024c4:	fffff097          	auipc	ra,0xfffff
    800024c8:	e3c080e7          	jalr	-452(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    800024cc:	00000613          	li	a2,0
    800024d0:	00000597          	auipc	a1,0x0
    800024d4:	f0058593          	addi	a1,a1,-256 # 800023d0 <idleProcess>
    800024d8:	00005517          	auipc	a0,0x5
    800024dc:	fe853503          	ld	a0,-24(a0) # 800074c0 <_GLOBAL_OFFSET_TABLE_+0x58>
    800024e0:	fffff097          	auipc	ra,0xfffff
    800024e4:	d28080e7          	jalr	-728(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    thread_create(&userProcess, userMainWrapper, nullptr);
    800024e8:	00000613          	li	a2,0
    800024ec:	00000597          	auipc	a1,0x0
    800024f0:	ef458593          	addi	a1,a1,-268 # 800023e0 <_Z15userMainWrapperPv>
    800024f4:	00005517          	auipc	a0,0x5
    800024f8:	0d450513          	addi	a0,a0,212 # 800075c8 <userProcess>
    800024fc:	fffff097          	auipc	ra,0xfffff
    80002500:	e04080e7          	jalr	-508(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {thread_dispatch();}
    80002504:	00005797          	auipc	a5,0x5
    80002508:	0c47b783          	ld	a5,196(a5) # 800075c8 <userProcess>
    8000250c:	0287c783          	lbu	a5,40(a5)
    80002510:	00079863          	bnez	a5,80002520 <main+0x108>
    80002514:	fffff097          	auipc	ra,0xfffff
    80002518:	d60080e7          	jalr	-672(ra) # 80001274 <_Z15thread_dispatchv>
    8000251c:	fe9ff06f          	j	80002504 <main+0xec>
    while(CCB::outputBuffer.peekFront() != 0) {thread_dispatch();}
    80002520:	00005517          	auipc	a0,0x5
    80002524:	f7053503          	ld	a0,-144(a0) # 80007490 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002528:	00000097          	auipc	ra,0x0
    8000252c:	98c080e7          	jalr	-1652(ra) # 80001eb4 <_ZN8IOBuffer9peekFrontEv>
    80002530:	00050863          	beqz	a0,80002540 <main+0x128>
    80002534:	fffff097          	auipc	ra,0xfffff
    80002538:	d40080e7          	jalr	-704(ra) # 80001274 <_Z15thread_dispatchv>
    8000253c:	fe5ff06f          	j	80002520 <main+0x108>
    return 0;
    80002540:	00000513          	li	a0,0
    80002544:	00813083          	ld	ra,8(sp)
    80002548:	00013403          	ld	s0,0(sp)
    8000254c:	01010113          	addi	sp,sp,16
    80002550:	00008067          	ret

0000000080002554 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002554:	fe010113          	addi	sp,sp,-32
    80002558:	00113c23          	sd	ra,24(sp)
    8000255c:	00813823          	sd	s0,16(sp)
    80002560:	00913423          	sd	s1,8(sp)
    80002564:	02010413          	addi	s0,sp,32
    80002568:	00005797          	auipc	a5,0x5
    8000256c:	eb078793          	addi	a5,a5,-336 # 80007418 <_ZTV6Thread+0x10>
    80002570:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002574:	00853483          	ld	s1,8(a0)
    80002578:	00048e63          	beqz	s1,80002594 <_ZN6ThreadD1Ev+0x40>
    8000257c:	00048513          	mv	a0,s1
    80002580:	fffff097          	auipc	ra,0xfffff
    80002584:	668080e7          	jalr	1640(ra) # 80001be8 <_ZN3PCBD1Ev>
    80002588:	00048513          	mv	a0,s1
    8000258c:	fffff097          	auipc	ra,0xfffff
    80002590:	6d0080e7          	jalr	1744(ra) # 80001c5c <_ZN3PCBdlEPv>
}
    80002594:	01813083          	ld	ra,24(sp)
    80002598:	01013403          	ld	s0,16(sp)
    8000259c:	00813483          	ld	s1,8(sp)
    800025a0:	02010113          	addi	sp,sp,32
    800025a4:	00008067          	ret

00000000800025a8 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    800025a8:	ff010113          	addi	sp,sp,-16
    800025ac:	00113423          	sd	ra,8(sp)
    800025b0:	00813023          	sd	s0,0(sp)
    800025b4:	01010413          	addi	s0,sp,16
    800025b8:	00005797          	auipc	a5,0x5
    800025bc:	e8878793          	addi	a5,a5,-376 # 80007440 <_ZTV9Semaphore+0x10>
    800025c0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800025c4:	00853503          	ld	a0,8(a0)
    800025c8:	fffff097          	auipc	ra,0xfffff
    800025cc:	e58080e7          	jalr	-424(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    800025d0:	00813083          	ld	ra,8(sp)
    800025d4:	00013403          	ld	s0,0(sp)
    800025d8:	01010113          	addi	sp,sp,16
    800025dc:	00008067          	ret

00000000800025e0 <_Znwm>:
void* operator new (size_t size) {
    800025e0:	ff010113          	addi	sp,sp,-16
    800025e4:	00113423          	sd	ra,8(sp)
    800025e8:	00813023          	sd	s0,0(sp)
    800025ec:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800025f0:	fffff097          	auipc	ra,0xfffff
    800025f4:	ba4080e7          	jalr	-1116(ra) # 80001194 <_Z9mem_allocm>
}
    800025f8:	00813083          	ld	ra,8(sp)
    800025fc:	00013403          	ld	s0,0(sp)
    80002600:	01010113          	addi	sp,sp,16
    80002604:	00008067          	ret

0000000080002608 <_Znam>:
void* operator new [](size_t size) {
    80002608:	ff010113          	addi	sp,sp,-16
    8000260c:	00113423          	sd	ra,8(sp)
    80002610:	00813023          	sd	s0,0(sp)
    80002614:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002618:	fffff097          	auipc	ra,0xfffff
    8000261c:	b7c080e7          	jalr	-1156(ra) # 80001194 <_Z9mem_allocm>
}
    80002620:	00813083          	ld	ra,8(sp)
    80002624:	00013403          	ld	s0,0(sp)
    80002628:	01010113          	addi	sp,sp,16
    8000262c:	00008067          	ret

0000000080002630 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002630:	ff010113          	addi	sp,sp,-16
    80002634:	00113423          	sd	ra,8(sp)
    80002638:	00813023          	sd	s0,0(sp)
    8000263c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002640:	fffff097          	auipc	ra,0xfffff
    80002644:	b94080e7          	jalr	-1132(ra) # 800011d4 <_Z8mem_freePv>
}
    80002648:	00813083          	ld	ra,8(sp)
    8000264c:	00013403          	ld	s0,0(sp)
    80002650:	01010113          	addi	sp,sp,16
    80002654:	00008067          	ret

0000000080002658 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002658:	fe010113          	addi	sp,sp,-32
    8000265c:	00113c23          	sd	ra,24(sp)
    80002660:	00813823          	sd	s0,16(sp)
    80002664:	00913423          	sd	s1,8(sp)
    80002668:	02010413          	addi	s0,sp,32
    8000266c:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002670:	00053503          	ld	a0,0(a0)
    80002674:	0104b783          	ld	a5,16(s1)
    80002678:	00f50533          	add	a0,a0,a5
    8000267c:	0084b783          	ld	a5,8(s1)
    80002680:	0017f713          	andi	a4,a5,1
    80002684:	00070863          	beqz	a4,80002694 <_Z13threadWrapperPv+0x3c>
    80002688:	00053703          	ld	a4,0(a0)
    8000268c:	00f707b3          	add	a5,a4,a5
    80002690:	fff7b783          	ld	a5,-1(a5)
    80002694:	000780e7          	jalr	a5
    delete tArg;
    80002698:	00048863          	beqz	s1,800026a8 <_Z13threadWrapperPv+0x50>
    8000269c:	00048513          	mv	a0,s1
    800026a0:	00000097          	auipc	ra,0x0
    800026a4:	f90080e7          	jalr	-112(ra) # 80002630 <_ZdlPv>
}
    800026a8:	01813083          	ld	ra,24(sp)
    800026ac:	01013403          	ld	s0,16(sp)
    800026b0:	00813483          	ld	s1,8(sp)
    800026b4:	02010113          	addi	sp,sp,32
    800026b8:	00008067          	ret

00000000800026bc <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    800026bc:	ff010113          	addi	sp,sp,-16
    800026c0:	00113423          	sd	ra,8(sp)
    800026c4:	00813023          	sd	s0,0(sp)
    800026c8:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800026cc:	fffff097          	auipc	ra,0xfffff
    800026d0:	b08080e7          	jalr	-1272(ra) # 800011d4 <_Z8mem_freePv>
}
    800026d4:	00813083          	ld	ra,8(sp)
    800026d8:	00013403          	ld	s0,0(sp)
    800026dc:	01010113          	addi	sp,sp,16
    800026e0:	00008067          	ret

00000000800026e4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800026e4:	ff010113          	addi	sp,sp,-16
    800026e8:	00113423          	sd	ra,8(sp)
    800026ec:	00813023          	sd	s0,0(sp)
    800026f0:	01010413          	addi	s0,sp,16
    800026f4:	00005797          	auipc	a5,0x5
    800026f8:	d2478793          	addi	a5,a5,-732 # 80007418 <_ZTV6Thread+0x10>
    800026fc:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002700:	00850513          	addi	a0,a0,8
    80002704:	fffff097          	auipc	ra,0xfffff
    80002708:	b04080e7          	jalr	-1276(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    8000270c:	00813083          	ld	ra,8(sp)
    80002710:	00013403          	ld	s0,0(sp)
    80002714:	01010113          	addi	sp,sp,16
    80002718:	00008067          	ret

000000008000271c <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    8000271c:	ff010113          	addi	sp,sp,-16
    80002720:	00113423          	sd	ra,8(sp)
    80002724:	00813023          	sd	s0,0(sp)
    80002728:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	6d0080e7          	jalr	1744(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
}
    80002734:	00813083          	ld	ra,8(sp)
    80002738:	00013403          	ld	s0,0(sp)
    8000273c:	01010113          	addi	sp,sp,16
    80002740:	00008067          	ret

0000000080002744 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002744:	ff010113          	addi	sp,sp,-16
    80002748:	00113423          	sd	ra,8(sp)
    8000274c:	00813023          	sd	s0,0(sp)
    80002750:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002754:	00001097          	auipc	ra,0x1
    80002758:	80c080e7          	jalr	-2036(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000275c:	00813083          	ld	ra,8(sp)
    80002760:	00013403          	ld	s0,0(sp)
    80002764:	01010113          	addi	sp,sp,16
    80002768:	00008067          	ret

000000008000276c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000276c:	fe010113          	addi	sp,sp,-32
    80002770:	00113c23          	sd	ra,24(sp)
    80002774:	00813823          	sd	s0,16(sp)
    80002778:	00913423          	sd	s1,8(sp)
    8000277c:	02010413          	addi	s0,sp,32
    80002780:	00050493          	mv	s1,a0
}
    80002784:	00000097          	auipc	ra,0x0
    80002788:	dd0080e7          	jalr	-560(ra) # 80002554 <_ZN6ThreadD1Ev>
    8000278c:	00048513          	mv	a0,s1
    80002790:	00000097          	auipc	ra,0x0
    80002794:	fb4080e7          	jalr	-76(ra) # 80002744 <_ZN6ThreaddlEPv>
    80002798:	01813083          	ld	ra,24(sp)
    8000279c:	01013403          	ld	s0,16(sp)
    800027a0:	00813483          	ld	s1,8(sp)
    800027a4:	02010113          	addi	sp,sp,32
    800027a8:	00008067          	ret

00000000800027ac <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800027ac:	ff010113          	addi	sp,sp,-16
    800027b0:	00113423          	sd	ra,8(sp)
    800027b4:	00813023          	sd	s0,0(sp)
    800027b8:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	ab8080e7          	jalr	-1352(ra) # 80001274 <_Z15thread_dispatchv>
}
    800027c4:	00813083          	ld	ra,8(sp)
    800027c8:	00013403          	ld	s0,0(sp)
    800027cc:	01010113          	addi	sp,sp,16
    800027d0:	00008067          	ret

00000000800027d4 <_ZN6Thread5startEv>:
int Thread::start() {
    800027d4:	ff010113          	addi	sp,sp,-16
    800027d8:	00113423          	sd	ra,8(sp)
    800027dc:	00813023          	sd	s0,0(sp)
    800027e0:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    800027e4:	00850513          	addi	a0,a0,8
    800027e8:	fffff097          	auipc	ra,0xfffff
    800027ec:	ae8080e7          	jalr	-1304(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    800027f0:	00000513          	li	a0,0
    800027f4:	00813083          	ld	ra,8(sp)
    800027f8:	00013403          	ld	s0,0(sp)
    800027fc:	01010113          	addi	sp,sp,16
    80002800:	00008067          	ret

0000000080002804 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002804:	fe010113          	addi	sp,sp,-32
    80002808:	00113c23          	sd	ra,24(sp)
    8000280c:	00813823          	sd	s0,16(sp)
    80002810:	00913423          	sd	s1,8(sp)
    80002814:	02010413          	addi	s0,sp,32
    80002818:	00050493          	mv	s1,a0
    8000281c:	00005797          	auipc	a5,0x5
    80002820:	bfc78793          	addi	a5,a5,-1028 # 80007418 <_ZTV6Thread+0x10>
    80002824:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002828:	01800513          	li	a0,24
    8000282c:	00000097          	auipc	ra,0x0
    80002830:	db4080e7          	jalr	-588(ra) # 800025e0 <_Znwm>
    80002834:	00050613          	mv	a2,a0
    80002838:	00953023          	sd	s1,0(a0)
    8000283c:	01100793          	li	a5,17
    80002840:	00f53423          	sd	a5,8(a0)
    80002844:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002848:	00000597          	auipc	a1,0x0
    8000284c:	e1058593          	addi	a1,a1,-496 # 80002658 <_Z13threadWrapperPv>
    80002850:	00848513          	addi	a0,s1,8
    80002854:	fffff097          	auipc	ra,0xfffff
    80002858:	9b4080e7          	jalr	-1612(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    8000285c:	01813083          	ld	ra,24(sp)
    80002860:	01013403          	ld	s0,16(sp)
    80002864:	00813483          	ld	s1,8(sp)
    80002868:	02010113          	addi	sp,sp,32
    8000286c:	00008067          	ret

0000000080002870 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002870:	ff010113          	addi	sp,sp,-16
    80002874:	00113423          	sd	ra,8(sp)
    80002878:	00813023          	sd	s0,0(sp)
    8000287c:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002880:	fffff097          	auipc	ra,0xfffff
    80002884:	be0080e7          	jalr	-1056(ra) # 80001460 <_Z10time_sleepm>
}
    80002888:	00813083          	ld	ra,8(sp)
    8000288c:	00013403          	ld	s0,0(sp)
    80002890:	01010113          	addi	sp,sp,16
    80002894:	00008067          	ret

0000000080002898 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002898:	fe010113          	addi	sp,sp,-32
    8000289c:	00113c23          	sd	ra,24(sp)
    800028a0:	00813823          	sd	s0,16(sp)
    800028a4:	00913423          	sd	s1,8(sp)
    800028a8:	02010413          	addi	s0,sp,32
    800028ac:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    800028b0:	0200006f          	j	800028d0 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800028b4:	00053703          	ld	a4,0(a0)
    800028b8:	00f707b3          	add	a5,a4,a5
    800028bc:	fff7b783          	ld	a5,-1(a5)
    800028c0:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    800028c4:	0184b503          	ld	a0,24(s1)
    800028c8:	00000097          	auipc	ra,0x0
    800028cc:	fa8080e7          	jalr	-88(ra) # 80002870 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800028d0:	0004b503          	ld	a0,0(s1)
    800028d4:	0104b783          	ld	a5,16(s1)
    800028d8:	00f50533          	add	a0,a0,a5
    800028dc:	0084b783          	ld	a5,8(s1)
    800028e0:	0017f713          	andi	a4,a5,1
    800028e4:	fc070ee3          	beqz	a4,800028c0 <_Z21periodicThreadWrapperPv+0x28>
    800028e8:	fcdff06f          	j	800028b4 <_Z21periodicThreadWrapperPv+0x1c>

00000000800028ec <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800028ec:	fe010113          	addi	sp,sp,-32
    800028f0:	00113c23          	sd	ra,24(sp)
    800028f4:	00813823          	sd	s0,16(sp)
    800028f8:	00913423          	sd	s1,8(sp)
    800028fc:	01213023          	sd	s2,0(sp)
    80002900:	02010413          	addi	s0,sp,32
    80002904:	00050493          	mv	s1,a0
    80002908:	00005797          	auipc	a5,0x5
    8000290c:	b3878793          	addi	a5,a5,-1224 # 80007440 <_ZTV9Semaphore+0x10>
    80002910:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002914:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002918:	01800513          	li	a0,24
    8000291c:	00000097          	auipc	ra,0x0
    80002920:	42c080e7          	jalr	1068(ra) # 80002d48 <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002924:	00053023          	sd	zero,0(a0)
    80002928:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000292c:	01252823          	sw	s2,16(a0)
    80002930:	00a4b423          	sd	a0,8(s1)
}
    80002934:	01813083          	ld	ra,24(sp)
    80002938:	01013403          	ld	s0,16(sp)
    8000293c:	00813483          	ld	s1,8(sp)
    80002940:	00013903          	ld	s2,0(sp)
    80002944:	02010113          	addi	sp,sp,32
    80002948:	00008067          	ret

000000008000294c <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    8000294c:	ff010113          	addi	sp,sp,-16
    80002950:	00113423          	sd	ra,8(sp)
    80002954:	00813023          	sd	s0,0(sp)
    80002958:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000295c:	00853503          	ld	a0,8(a0)
    80002960:	fffff097          	auipc	ra,0xfffff
    80002964:	a38080e7          	jalr	-1480(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80002968:	00813083          	ld	ra,8(sp)
    8000296c:	00013403          	ld	s0,0(sp)
    80002970:	01010113          	addi	sp,sp,16
    80002974:	00008067          	ret

0000000080002978 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00113423          	sd	ra,8(sp)
    80002980:	00813023          	sd	s0,0(sp)
    80002984:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002988:	00853503          	ld	a0,8(a0)
    8000298c:	fffff097          	auipc	ra,0xfffff
    80002990:	a54080e7          	jalr	-1452(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80002994:	00813083          	ld	ra,8(sp)
    80002998:	00013403          	ld	s0,0(sp)
    8000299c:	01010113          	addi	sp,sp,16
    800029a0:	00008067          	ret

00000000800029a4 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    800029a4:	ff010113          	addi	sp,sp,-16
    800029a8:	00113423          	sd	ra,8(sp)
    800029ac:	00813023          	sd	s0,0(sp)
    800029b0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800029b4:	00000097          	auipc	ra,0x0
    800029b8:	5ac080e7          	jalr	1452(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800029bc:	00813083          	ld	ra,8(sp)
    800029c0:	00013403          	ld	s0,0(sp)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    800029cc:	fe010113          	addi	sp,sp,-32
    800029d0:	00113c23          	sd	ra,24(sp)
    800029d4:	00813823          	sd	s0,16(sp)
    800029d8:	00913423          	sd	s1,8(sp)
    800029dc:	02010413          	addi	s0,sp,32
    800029e0:	00050493          	mv	s1,a0
}
    800029e4:	00000097          	auipc	ra,0x0
    800029e8:	bc4080e7          	jalr	-1084(ra) # 800025a8 <_ZN9SemaphoreD1Ev>
    800029ec:	00048513          	mv	a0,s1
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	fb4080e7          	jalr	-76(ra) # 800029a4 <_ZN9SemaphoredlEPv>
    800029f8:	01813083          	ld	ra,24(sp)
    800029fc:	01013403          	ld	s0,16(sp)
    80002a00:	00813483          	ld	s1,8(sp)
    80002a04:	02010113          	addi	sp,sp,32
    80002a08:	00008067          	ret

0000000080002a0c <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002a0c:	ff010113          	addi	sp,sp,-16
    80002a10:	00113423          	sd	ra,8(sp)
    80002a14:	00813023          	sd	s0,0(sp)
    80002a18:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	3e0080e7          	jalr	992(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
}
    80002a24:	00813083          	ld	ra,8(sp)
    80002a28:	00013403          	ld	s0,0(sp)
    80002a2c:	01010113          	addi	sp,sp,16
    80002a30:	00008067          	ret

0000000080002a34 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80002a34:	fe010113          	addi	sp,sp,-32
    80002a38:	00113c23          	sd	ra,24(sp)
    80002a3c:	00813823          	sd	s0,16(sp)
    80002a40:	00913423          	sd	s1,8(sp)
    80002a44:	01213023          	sd	s2,0(sp)
    80002a48:	02010413          	addi	s0,sp,32
    80002a4c:	00050493          	mv	s1,a0
    80002a50:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002a54:	02000513          	li	a0,32
    80002a58:	00000097          	auipc	ra,0x0
    80002a5c:	b88080e7          	jalr	-1144(ra) # 800025e0 <_Znwm>
    80002a60:	00050613          	mv	a2,a0
    80002a64:	00953023          	sd	s1,0(a0)
    80002a68:	01900793          	li	a5,25
    80002a6c:	00f53423          	sd	a5,8(a0)
    80002a70:	00053823          	sd	zero,16(a0)
    80002a74:	01253c23          	sd	s2,24(a0)
    80002a78:	00000597          	auipc	a1,0x0
    80002a7c:	e2058593          	addi	a1,a1,-480 # 80002898 <_Z21periodicThreadWrapperPv>
    80002a80:	00048513          	mv	a0,s1
    80002a84:	00000097          	auipc	ra,0x0
    80002a88:	c60080e7          	jalr	-928(ra) # 800026e4 <_ZN6ThreadC1EPFvPvES0_>
    80002a8c:	00005797          	auipc	a5,0x5
    80002a90:	95c78793          	addi	a5,a5,-1700 # 800073e8 <_ZTV14PeriodicThread+0x10>
    80002a94:	00f4b023          	sd	a5,0(s1)
{}
    80002a98:	01813083          	ld	ra,24(sp)
    80002a9c:	01013403          	ld	s0,16(sp)
    80002aa0:	00813483          	ld	s1,8(sp)
    80002aa4:	00013903          	ld	s2,0(sp)
    80002aa8:	02010113          	addi	sp,sp,32
    80002aac:	00008067          	ret

0000000080002ab0 <_ZN7Console4getcEv>:


char Console::getc() {
    80002ab0:	ff010113          	addi	sp,sp,-16
    80002ab4:	00113423          	sd	ra,8(sp)
    80002ab8:	00813023          	sd	s0,0(sp)
    80002abc:	01010413          	addi	s0,sp,16
    return ::getc();
    80002ac0:	fffff097          	auipc	ra,0xfffff
    80002ac4:	9e8080e7          	jalr	-1560(ra) # 800014a8 <_Z4getcv>
}
    80002ac8:	00813083          	ld	ra,8(sp)
    80002acc:	00013403          	ld	s0,0(sp)
    80002ad0:	01010113          	addi	sp,sp,16
    80002ad4:	00008067          	ret

0000000080002ad8 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002ad8:	ff010113          	addi	sp,sp,-16
    80002adc:	00113423          	sd	ra,8(sp)
    80002ae0:	00813023          	sd	s0,0(sp)
    80002ae4:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002ae8:	fffff097          	auipc	ra,0xfffff
    80002aec:	9f0080e7          	jalr	-1552(ra) # 800014d8 <_Z4putcc>
}
    80002af0:	00813083          	ld	ra,8(sp)
    80002af4:	00013403          	ld	s0,0(sp)
    80002af8:	01010113          	addi	sp,sp,16
    80002afc:	00008067          	ret

0000000080002b00 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002b00:	ff010113          	addi	sp,sp,-16
    80002b04:	00813423          	sd	s0,8(sp)
    80002b08:	01010413          	addi	s0,sp,16
    80002b0c:	00813403          	ld	s0,8(sp)
    80002b10:	01010113          	addi	sp,sp,16
    80002b14:	00008067          	ret

0000000080002b18 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002b18:	ff010113          	addi	sp,sp,-16
    80002b1c:	00813423          	sd	s0,8(sp)
    80002b20:	01010413          	addi	s0,sp,16
    80002b24:	00813403          	ld	s0,8(sp)
    80002b28:	01010113          	addi	sp,sp,16
    80002b2c:	00008067          	ret

0000000080002b30 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80002b30:	ff010113          	addi	sp,sp,-16
    80002b34:	00113423          	sd	ra,8(sp)
    80002b38:	00813023          	sd	s0,0(sp)
    80002b3c:	01010413          	addi	s0,sp,16
    80002b40:	00005797          	auipc	a5,0x5
    80002b44:	8a878793          	addi	a5,a5,-1880 # 800073e8 <_ZTV14PeriodicThread+0x10>
    80002b48:	00f53023          	sd	a5,0(a0)
    80002b4c:	00000097          	auipc	ra,0x0
    80002b50:	a08080e7          	jalr	-1528(ra) # 80002554 <_ZN6ThreadD1Ev>
    80002b54:	00813083          	ld	ra,8(sp)
    80002b58:	00013403          	ld	s0,0(sp)
    80002b5c:	01010113          	addi	sp,sp,16
    80002b60:	00008067          	ret

0000000080002b64 <_ZN14PeriodicThreadD0Ev>:
    80002b64:	fe010113          	addi	sp,sp,-32
    80002b68:	00113c23          	sd	ra,24(sp)
    80002b6c:	00813823          	sd	s0,16(sp)
    80002b70:	00913423          	sd	s1,8(sp)
    80002b74:	02010413          	addi	s0,sp,32
    80002b78:	00050493          	mv	s1,a0
    80002b7c:	00005797          	auipc	a5,0x5
    80002b80:	86c78793          	addi	a5,a5,-1940 # 800073e8 <_ZTV14PeriodicThread+0x10>
    80002b84:	00f53023          	sd	a5,0(a0)
    80002b88:	00000097          	auipc	ra,0x0
    80002b8c:	9cc080e7          	jalr	-1588(ra) # 80002554 <_ZN6ThreadD1Ev>
    80002b90:	00048513          	mv	a0,s1
    80002b94:	00000097          	auipc	ra,0x0
    80002b98:	bb0080e7          	jalr	-1104(ra) # 80002744 <_ZN6ThreaddlEPv>
    80002b9c:	01813083          	ld	ra,24(sp)
    80002ba0:	01013403          	ld	s0,16(sp)
    80002ba4:	00813483          	ld	s1,8(sp)
    80002ba8:	02010113          	addi	sp,sp,32
    80002bac:	00008067          	ret

0000000080002bb0 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002bb0:	ff010113          	addi	sp,sp,-16
    80002bb4:	00813423          	sd	s0,8(sp)
    80002bb8:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002bbc:	00005797          	auipc	a5,0x5
    80002bc0:	90c7b783          	ld	a5,-1780(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bc4:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80002bc8:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002bcc:	00853783          	ld	a5,8(a0)
    80002bd0:	04078063          	beqz	a5,80002c10 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002bd4:	00005717          	auipc	a4,0x5
    80002bd8:	8f473703          	ld	a4,-1804(a4) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bdc:	00073703          	ld	a4,0(a4)
    80002be0:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002be4:	00853783          	ld	a5,8(a0)
        return nextInList;
    80002be8:	0007b783          	ld	a5,0(a5)
    80002bec:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002bf0:	00005797          	auipc	a5,0x5
    80002bf4:	8d87b783          	ld	a5,-1832(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bf8:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002bfc:	00100713          	li	a4,1
    80002c00:	02e784a3          	sb	a4,41(a5)
}
    80002c04:	00813403          	ld	s0,8(sp)
    80002c08:	01010113          	addi	sp,sp,16
    80002c0c:	00008067          	ret
        head = tail = PCB::running;
    80002c10:	00005797          	auipc	a5,0x5
    80002c14:	8b87b783          	ld	a5,-1864(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c18:	0007b783          	ld	a5,0(a5)
    80002c1c:	00f53423          	sd	a5,8(a0)
    80002c20:	00f53023          	sd	a5,0(a0)
    80002c24:	fcdff06f          	j	80002bf0 <_ZN3SCB5blockEv+0x40>

0000000080002c28 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80002c28:	ff010113          	addi	sp,sp,-16
    80002c2c:	00813423          	sd	s0,8(sp)
    80002c30:	01010413          	addi	s0,sp,16
    80002c34:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80002c38:	00053503          	ld	a0,0(a0)
    80002c3c:	00050e63          	beqz	a0,80002c58 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    80002c40:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80002c44:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80002c48:	0087b683          	ld	a3,8(a5)
    80002c4c:	00d50c63          	beq	a0,a3,80002c64 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80002c50:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80002c54:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80002c58:	00813403          	ld	s0,8(sp)
    80002c5c:	01010113          	addi	sp,sp,16
    80002c60:	00008067          	ret
        tail = head;
    80002c64:	00e7b423          	sd	a4,8(a5)
    80002c68:	fe9ff06f          	j	80002c50 <_ZN3SCB7unblockEv+0x28>

0000000080002c6c <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80002c6c:	01052783          	lw	a5,16(a0)
    80002c70:	fff7879b          	addiw	a5,a5,-1
    80002c74:	00f52823          	sw	a5,16(a0)
    80002c78:	02079713          	slli	a4,a5,0x20
    80002c7c:	02074063          	bltz	a4,80002c9c <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002c80:	00005797          	auipc	a5,0x5
    80002c84:	8487b783          	ld	a5,-1976(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c88:	0007b783          	ld	a5,0(a5)
    80002c8c:	02a7c783          	lbu	a5,42(a5)
    80002c90:	06079463          	bnez	a5,80002cf8 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80002c94:	00000513          	li	a0,0
    80002c98:	00008067          	ret
int SCB::wait() {
    80002c9c:	ff010113          	addi	sp,sp,-16
    80002ca0:	00113423          	sd	ra,8(sp)
    80002ca4:	00813023          	sd	s0,0(sp)
    80002ca8:	01010413          	addi	s0,sp,16
        block();
    80002cac:	00000097          	auipc	ra,0x0
    80002cb0:	f04080e7          	jalr	-252(ra) # 80002bb0 <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80002cb4:	00004797          	auipc	a5,0x4
    80002cb8:	7f47b783          	ld	a5,2036(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002cbc:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80002cc0:	fffff097          	auipc	ra,0xfffff
    80002cc4:	dec080e7          	jalr	-532(ra) # 80001aac <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002cc8:	00005797          	auipc	a5,0x5
    80002ccc:	8007b783          	ld	a5,-2048(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002cd0:	0007b783          	ld	a5,0(a5)
    80002cd4:	02a7c783          	lbu	a5,42(a5)
    80002cd8:	00079c63          	bnez	a5,80002cf0 <_ZN3SCB4waitEv+0x84>
    return 0;
    80002cdc:	00000513          	li	a0,0

}
    80002ce0:	00813083          	ld	ra,8(sp)
    80002ce4:	00013403          	ld	s0,0(sp)
    80002ce8:	01010113          	addi	sp,sp,16
    80002cec:	00008067          	ret
        return -2;
    80002cf0:	ffe00513          	li	a0,-2
    80002cf4:	fedff06f          	j	80002ce0 <_ZN3SCB4waitEv+0x74>
    80002cf8:	ffe00513          	li	a0,-2
}
    80002cfc:	00008067          	ret

0000000080002d00 <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    80002d00:	01052783          	lw	a5,16(a0)
    80002d04:	0017879b          	addiw	a5,a5,1
    80002d08:	0007871b          	sext.w	a4,a5
    80002d0c:	00f52823          	sw	a5,16(a0)
    80002d10:	00e05463          	blez	a4,80002d18 <_ZN3SCB6signalEv+0x18>
    80002d14:	00008067          	ret
void SCB::signal() {
    80002d18:	ff010113          	addi	sp,sp,-16
    80002d1c:	00113423          	sd	ra,8(sp)
    80002d20:	00813023          	sd	s0,0(sp)
    80002d24:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    80002d28:	00000097          	auipc	ra,0x0
    80002d2c:	f00080e7          	jalr	-256(ra) # 80002c28 <_ZN3SCB7unblockEv>
    80002d30:	fffff097          	auipc	ra,0xfffff
    80002d34:	5a0080e7          	jalr	1440(ra) # 800022d0 <_ZN9Scheduler3putEP3PCB>
    }
}
    80002d38:	00813083          	ld	ra,8(sp)
    80002d3c:	00013403          	ld	s0,0(sp)
    80002d40:	01010113          	addi	sp,sp,16
    80002d44:	00008067          	ret

0000000080002d48 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80002d48:	ff010113          	addi	sp,sp,-16
    80002d4c:	00113423          	sd	ra,8(sp)
    80002d50:	00813023          	sd	s0,0(sp)
    80002d54:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002d58:	00000097          	auipc	ra,0x0
    80002d5c:	0a4080e7          	jalr	164(ra) # 80002dfc <_ZN15MemoryAllocator9mem_allocEm>
}
    80002d60:	00813083          	ld	ra,8(sp)
    80002d64:	00013403          	ld	s0,0(sp)
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00008067          	ret

0000000080002d70 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002d70:	ff010113          	addi	sp,sp,-16
    80002d74:	00113423          	sd	ra,8(sp)
    80002d78:	00813023          	sd	s0,0(sp)
    80002d7c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002d80:	00000097          	auipc	ra,0x0
    80002d84:	1e0080e7          	jalr	480(ra) # 80002f60 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002d88:	00813083          	ld	ra,8(sp)
    80002d8c:	00013403          	ld	s0,0(sp)
    80002d90:	01010113          	addi	sp,sp,16
    80002d94:	00008067          	ret

0000000080002d98 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80002d98:	fe010113          	addi	sp,sp,-32
    80002d9c:	00113c23          	sd	ra,24(sp)
    80002da0:	00813823          	sd	s0,16(sp)
    80002da4:	00913423          	sd	s1,8(sp)
    80002da8:	01213023          	sd	s2,0(sp)
    80002dac:	02010413          	addi	s0,sp,32
    80002db0:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002db4:	00053503          	ld	a0,0(a0)
    while(curr) {
    80002db8:	02050263          	beqz	a0,80002ddc <_ZN3SCB13signalClosingEv+0x44>
    }

    void setSemDeleted(bool newState) {
        semDeleted = newState;
    80002dbc:	00100793          	li	a5,1
    80002dc0:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    80002dc4:	020504a3          	sb	zero,41(a0)
        return nextInList;
    80002dc8:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80002dcc:	fffff097          	auipc	ra,0xfffff
    80002dd0:	504080e7          	jalr	1284(ra) # 800022d0 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80002dd4:	00048513          	mv	a0,s1
    while(curr) {
    80002dd8:	fe1ff06f          	j	80002db8 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002ddc:	00093423          	sd	zero,8(s2)
    80002de0:	00093023          	sd	zero,0(s2)
}
    80002de4:	01813083          	ld	ra,24(sp)
    80002de8:	01013403          	ld	s0,16(sp)
    80002dec:	00813483          	ld	s1,8(sp)
    80002df0:	00013903          	ld	s2,0(sp)
    80002df4:	02010113          	addi	sp,sp,32
    80002df8:	00008067          	ret

0000000080002dfc <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002dfc:	ff010113          	addi	sp,sp,-16
    80002e00:	00813423          	sd	s0,8(sp)
    80002e04:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002e08:	00004797          	auipc	a5,0x4
    80002e0c:	7c87b783          	ld	a5,1992(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
    80002e10:	02078c63          	beqz	a5,80002e48 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002e14:	00004717          	auipc	a4,0x4
    80002e18:	6bc73703          	ld	a4,1724(a4) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002e1c:	00073703          	ld	a4,0(a4)
    80002e20:	12e78c63          	beq	a5,a4,80002f58 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002e24:	00850713          	addi	a4,a0,8
    80002e28:	00675813          	srli	a6,a4,0x6
    80002e2c:	03f77793          	andi	a5,a4,63
    80002e30:	00f037b3          	snez	a5,a5
    80002e34:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80002e38:	00004517          	auipc	a0,0x4
    80002e3c:	79853503          	ld	a0,1944(a0) # 800075d0 <_ZN15MemoryAllocator4headE>
    80002e40:	00000613          	li	a2,0
    80002e44:	0a80006f          	j	80002eec <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80002e48:	00004697          	auipc	a3,0x4
    80002e4c:	6406b683          	ld	a3,1600(a3) # 80007488 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002e50:	0006b783          	ld	a5,0(a3)
    80002e54:	00004717          	auipc	a4,0x4
    80002e58:	76f73e23          	sd	a5,1916(a4) # 800075d0 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80002e5c:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80002e60:	00004717          	auipc	a4,0x4
    80002e64:	67073703          	ld	a4,1648(a4) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002e68:	00073703          	ld	a4,0(a4)
    80002e6c:	0006b683          	ld	a3,0(a3)
    80002e70:	40d70733          	sub	a4,a4,a3
    80002e74:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80002e78:	0007b823          	sd	zero,16(a5)
    80002e7c:	fa9ff06f          	j	80002e24 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80002e80:	00060e63          	beqz	a2,80002e9c <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002e84:	01063703          	ld	a4,16(a2)
    80002e88:	04070a63          	beqz	a4,80002edc <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002e8c:	01073703          	ld	a4,16(a4)
    80002e90:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002e94:	00078813          	mv	a6,a5
    80002e98:	0ac0006f          	j	80002f44 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002e9c:	01053703          	ld	a4,16(a0)
    80002ea0:	00070a63          	beqz	a4,80002eb4 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002ea4:	00004697          	auipc	a3,0x4
    80002ea8:	72e6b623          	sd	a4,1836(a3) # 800075d0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002eac:	00078813          	mv	a6,a5
    80002eb0:	0940006f          	j	80002f44 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002eb4:	00004717          	auipc	a4,0x4
    80002eb8:	61c73703          	ld	a4,1564(a4) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002ebc:	00073703          	ld	a4,0(a4)
    80002ec0:	00004697          	auipc	a3,0x4
    80002ec4:	70e6b823          	sd	a4,1808(a3) # 800075d0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002ec8:	00078813          	mv	a6,a5
    80002ecc:	0780006f          	j	80002f44 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002ed0:	00004797          	auipc	a5,0x4
    80002ed4:	70e7b023          	sd	a4,1792(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
    80002ed8:	06c0006f          	j	80002f44 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002edc:	00078813          	mv	a6,a5
    80002ee0:	0640006f          	j	80002f44 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002ee4:	00050613          	mv	a2,a0
        curr = curr->next;
    80002ee8:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002eec:	06050063          	beqz	a0,80002f4c <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002ef0:	00853783          	ld	a5,8(a0)
    80002ef4:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002ef8:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002efc:	fee7e4e3          	bltu	a5,a4,80002ee4 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002f00:	ff06e2e3          	bltu	a3,a6,80002ee4 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002f04:	f7068ee3          	beq	a3,a6,80002e80 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002f08:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002f0c:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002f10:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002f14:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002f18:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002f1c:	01053783          	ld	a5,16(a0)
    80002f20:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002f24:	fa0606e3          	beqz	a2,80002ed0 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002f28:	01063783          	ld	a5,16(a2)
    80002f2c:	00078663          	beqz	a5,80002f38 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002f30:	0107b783          	ld	a5,16(a5)
    80002f34:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80002f38:	01063783          	ld	a5,16(a2)
    80002f3c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002f40:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002f44:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80002f48:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80002f4c:	00813403          	ld	s0,8(sp)
    80002f50:	01010113          	addi	sp,sp,16
    80002f54:	00008067          	ret
        return nullptr;
    80002f58:	00000513          	li	a0,0
    80002f5c:	ff1ff06f          	j	80002f4c <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080002f60 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002f6c:	16050063          	beqz	a0,800030cc <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80002f70:	ff850713          	addi	a4,a0,-8
    80002f74:	00004797          	auipc	a5,0x4
    80002f78:	5147b783          	ld	a5,1300(a5) # 80007488 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002f7c:	0007b783          	ld	a5,0(a5)
    80002f80:	14f76a63          	bltu	a4,a5,800030d4 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002f84:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002f88:	fff58693          	addi	a3,a1,-1
    80002f8c:	00d706b3          	add	a3,a4,a3
    80002f90:	00004617          	auipc	a2,0x4
    80002f94:	54063603          	ld	a2,1344(a2) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002f98:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002f9c:	14c6f063          	bgeu	a3,a2,800030dc <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002fa0:	14070263          	beqz	a4,800030e4 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002fa4:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002fa8:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002fac:	14079063          	bnez	a5,800030ec <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002fb0:	03f00793          	li	a5,63
    80002fb4:	14b7f063          	bgeu	a5,a1,800030f4 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002fb8:	00004797          	auipc	a5,0x4
    80002fbc:	6187b783          	ld	a5,1560(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
    80002fc0:	02f60063          	beq	a2,a5,80002fe0 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002fc4:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002fc8:	02078a63          	beqz	a5,80002ffc <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002fcc:	0007b683          	ld	a3,0(a5)
    80002fd0:	02e6f663          	bgeu	a3,a4,80002ffc <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002fd4:	00078613          	mv	a2,a5
        curr = curr->next;
    80002fd8:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002fdc:	fedff06f          	j	80002fc8 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002fe0:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002fe4:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002fe8:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002fec:	00004797          	auipc	a5,0x4
    80002ff0:	5ee7b223          	sd	a4,1508(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
        return 0;
    80002ff4:	00000513          	li	a0,0
    80002ff8:	0480006f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002ffc:	04060863          	beqz	a2,8000304c <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003000:	00063683          	ld	a3,0(a2)
    80003004:	00863803          	ld	a6,8(a2)
    80003008:	010686b3          	add	a3,a3,a6
    8000300c:	08e68a63          	beq	a3,a4,800030a0 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003010:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003014:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80003018:	01063683          	ld	a3,16(a2)
    8000301c:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003020:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80003024:	0e078063          	beqz	a5,80003104 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80003028:	0007b583          	ld	a1,0(a5)
    8000302c:	00073683          	ld	a3,0(a4)
    80003030:	00873603          	ld	a2,8(a4)
    80003034:	00c686b3          	add	a3,a3,a2
    80003038:	06d58c63          	beq	a1,a3,800030b0 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    8000303c:	00000513          	li	a0,0
}
    80003040:	00813403          	ld	s0,8(sp)
    80003044:	01010113          	addi	sp,sp,16
    80003048:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    8000304c:	0a078863          	beqz	a5,800030fc <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80003050:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003054:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80003058:	00004797          	auipc	a5,0x4
    8000305c:	5787b783          	ld	a5,1400(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
    80003060:	0007b603          	ld	a2,0(a5)
    80003064:	00b706b3          	add	a3,a4,a1
    80003068:	00d60c63          	beq	a2,a3,80003080 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    8000306c:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80003070:	00004797          	auipc	a5,0x4
    80003074:	56e7b023          	sd	a4,1376(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
            return 0;
    80003078:	00000513          	li	a0,0
    8000307c:	fc5ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80003080:	0087b783          	ld	a5,8(a5)
    80003084:	00b785b3          	add	a1,a5,a1
    80003088:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000308c:	00004797          	auipc	a5,0x4
    80003090:	5447b783          	ld	a5,1348(a5) # 800075d0 <_ZN15MemoryAllocator4headE>
    80003094:	0107b783          	ld	a5,16(a5)
    80003098:	00f53423          	sd	a5,8(a0)
    8000309c:	fd5ff06f          	j	80003070 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800030a0:	00b805b3          	add	a1,a6,a1
    800030a4:	00b63423          	sd	a1,8(a2)
    800030a8:	00060713          	mv	a4,a2
    800030ac:	f79ff06f          	j	80003024 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800030b0:	0087b683          	ld	a3,8(a5)
    800030b4:	00d60633          	add	a2,a2,a3
    800030b8:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800030bc:	0107b783          	ld	a5,16(a5)
    800030c0:	00f73823          	sd	a5,16(a4)
    return 0;
    800030c4:	00000513          	li	a0,0
    800030c8:	f79ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800030cc:	fff00513          	li	a0,-1
    800030d0:	f71ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800030d4:	fff00513          	li	a0,-1
    800030d8:	f69ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800030dc:	fff00513          	li	a0,-1
    800030e0:	f61ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800030e4:	fff00513          	li	a0,-1
    800030e8:	f59ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800030ec:	fff00513          	li	a0,-1
    800030f0:	f51ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800030f4:	fff00513          	li	a0,-1
    800030f8:	f49ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    800030fc:	fff00513          	li	a0,-1
    80003100:	f41ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80003104:	00000513          	li	a0,0
    80003108:	f39ff06f          	j	80003040 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000310c <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"
#include "../h/console.h"

Buffer::Buffer(int _cap) : cap(_cap), head(0), tail(0) {
    8000310c:	fe010113          	addi	sp,sp,-32
    80003110:	00113c23          	sd	ra,24(sp)
    80003114:	00813823          	sd	s0,16(sp)
    80003118:	00913423          	sd	s1,8(sp)
    8000311c:	02010413          	addi	s0,sp,32
    80003120:	00050493          	mv	s1,a0
    80003124:	00b52023          	sw	a1,0(a0)
    80003128:	00052823          	sw	zero,16(a0)
    8000312c:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003130:	00259513          	slli	a0,a1,0x2
    80003134:	ffffe097          	auipc	ra,0xffffe
    80003138:	060080e7          	jalr	96(ra) # 80001194 <_Z9mem_allocm>
    8000313c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003140:	00000593          	li	a1,0
    80003144:	02048513          	addi	a0,s1,32
    80003148:	ffffe097          	auipc	ra,0xffffe
    8000314c:	208080e7          	jalr	520(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, cap);
    80003150:	0004a583          	lw	a1,0(s1)
    80003154:	01848513          	addi	a0,s1,24
    80003158:	ffffe097          	auipc	ra,0xffffe
    8000315c:	1f8080e7          	jalr	504(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003160:	00100593          	li	a1,1
    80003164:	02848513          	addi	a0,s1,40
    80003168:	ffffe097          	auipc	ra,0xffffe
    8000316c:	1e8080e7          	jalr	488(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003170:	00100593          	li	a1,1
    80003174:	03048513          	addi	a0,s1,48
    80003178:	ffffe097          	auipc	ra,0xffffe
    8000317c:	1d8080e7          	jalr	472(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80003180:	01813083          	ld	ra,24(sp)
    80003184:	01013403          	ld	s0,16(sp)
    80003188:	00813483          	ld	s1,8(sp)
    8000318c:	02010113          	addi	sp,sp,32
    80003190:	00008067          	ret

0000000080003194 <_ZN6BufferD1Ev>:

Buffer::~Buffer() {
    80003194:	fe010113          	addi	sp,sp,-32
    80003198:	00113c23          	sd	ra,24(sp)
    8000319c:	00813823          	sd	s0,16(sp)
    800031a0:	00913423          	sd	s1,8(sp)
    800031a4:	02010413          	addi	s0,sp,32
    800031a8:	00050493          	mv	s1,a0
    __putc('\n');
    800031ac:	00a00513          	li	a0,10
    800031b0:	00002097          	auipc	ra,0x2
    800031b4:	62c080e7          	jalr	1580(ra) # 800057dc <__putc>
    printString("Buffer deleted!\n");
    800031b8:	00003517          	auipc	a0,0x3
    800031bc:	f7850513          	addi	a0,a0,-136 # 80006130 <CONSOLE_STATUS+0x120>
    800031c0:	00000097          	auipc	ra,0x0
    800031c4:	1c8080e7          	jalr	456(ra) # 80003388 <_Z11printStringPKc>
    while (head != tail) {
    800031c8:	0104a783          	lw	a5,16(s1)
    800031cc:	0144a703          	lw	a4,20(s1)
    800031d0:	02e78a63          	beq	a5,a4,80003204 <_ZN6BufferD1Ev+0x70>
        char ch = buffer[head];
    800031d4:	0084b703          	ld	a4,8(s1)
    800031d8:	00279793          	slli	a5,a5,0x2
    800031dc:	00f707b3          	add	a5,a4,a5
        __putc(ch);
    800031e0:	0007c503          	lbu	a0,0(a5)
    800031e4:	00002097          	auipc	ra,0x2
    800031e8:	5f8080e7          	jalr	1528(ra) # 800057dc <__putc>
        head = (head + 1) % cap;
    800031ec:	0104a783          	lw	a5,16(s1)
    800031f0:	0017879b          	addiw	a5,a5,1
    800031f4:	0004a703          	lw	a4,0(s1)
    800031f8:	02e7e7bb          	remw	a5,a5,a4
    800031fc:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003200:	fc9ff06f          	j	800031c8 <_ZN6BufferD1Ev+0x34>
    }
    __putc('!');
    80003204:	02100513          	li	a0,33
    80003208:	00002097          	auipc	ra,0x2
    8000320c:	5d4080e7          	jalr	1492(ra) # 800057dc <__putc>
    __putc('\n');
    80003210:	00a00513          	li	a0,10
    80003214:	00002097          	auipc	ra,0x2
    80003218:	5c8080e7          	jalr	1480(ra) # 800057dc <__putc>

    mem_free(buffer);
    8000321c:	0084b503          	ld	a0,8(s1)
    80003220:	ffffe097          	auipc	ra,0xffffe
    80003224:	fb4080e7          	jalr	-76(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003228:	0204b503          	ld	a0,32(s1)
    8000322c:	ffffe097          	auipc	ra,0xffffe
    80003230:	1f4080e7          	jalr	500(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003234:	0184b503          	ld	a0,24(s1)
    80003238:	ffffe097          	auipc	ra,0xffffe
    8000323c:	1e8080e7          	jalr	488(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003240:	0304b503          	ld	a0,48(s1)
    80003244:	ffffe097          	auipc	ra,0xffffe
    80003248:	1dc080e7          	jalr	476(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    8000324c:	0284b503          	ld	a0,40(s1)
    80003250:	ffffe097          	auipc	ra,0xffffe
    80003254:	1d0080e7          	jalr	464(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003258:	01813083          	ld	ra,24(sp)
    8000325c:	01013403          	ld	s0,16(sp)
    80003260:	00813483          	ld	s1,8(sp)
    80003264:	02010113          	addi	sp,sp,32
    80003268:	00008067          	ret

000000008000326c <_ZN6Buffer3putEi>:

void Buffer::put(int val) {
    8000326c:	fe010113          	addi	sp,sp,-32
    80003270:	00113c23          	sd	ra,24(sp)
    80003274:	00813823          	sd	s0,16(sp)
    80003278:	00913423          	sd	s1,8(sp)
    8000327c:	01213023          	sd	s2,0(sp)
    80003280:	02010413          	addi	s0,sp,32
    80003284:	00050493          	mv	s1,a0
    80003288:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000328c:	01853503          	ld	a0,24(a0)
    80003290:	ffffe097          	auipc	ra,0xffffe
    80003294:	108080e7          	jalr	264(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80003298:	0304b503          	ld	a0,48(s1)
    8000329c:	ffffe097          	auipc	ra,0xffffe
    800032a0:	0fc080e7          	jalr	252(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    800032a4:	0084b783          	ld	a5,8(s1)
    800032a8:	0144a703          	lw	a4,20(s1)
    800032ac:	00271713          	slli	a4,a4,0x2
    800032b0:	00e787b3          	add	a5,a5,a4
    800032b4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800032b8:	0144a783          	lw	a5,20(s1)
    800032bc:	0017879b          	addiw	a5,a5,1
    800032c0:	0004a703          	lw	a4,0(s1)
    800032c4:	02e7e7bb          	remw	a5,a5,a4
    800032c8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800032cc:	0304b503          	ld	a0,48(s1)
    800032d0:	ffffe097          	auipc	ra,0xffffe
    800032d4:	110080e7          	jalr	272(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    800032d8:	0204b503          	ld	a0,32(s1)
    800032dc:	ffffe097          	auipc	ra,0xffffe
    800032e0:	104080e7          	jalr	260(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    800032e4:	01813083          	ld	ra,24(sp)
    800032e8:	01013403          	ld	s0,16(sp)
    800032ec:	00813483          	ld	s1,8(sp)
    800032f0:	00013903          	ld	s2,0(sp)
    800032f4:	02010113          	addi	sp,sp,32
    800032f8:	00008067          	ret

00000000800032fc <_ZN6Buffer3getEv>:

int Buffer::get() {
    800032fc:	fe010113          	addi	sp,sp,-32
    80003300:	00113c23          	sd	ra,24(sp)
    80003304:	00813823          	sd	s0,16(sp)
    80003308:	00913423          	sd	s1,8(sp)
    8000330c:	01213023          	sd	s2,0(sp)
    80003310:	02010413          	addi	s0,sp,32
    80003314:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003318:	02053503          	ld	a0,32(a0)
    8000331c:	ffffe097          	auipc	ra,0xffffe
    80003320:	07c080e7          	jalr	124(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003324:	0284b503          	ld	a0,40(s1)
    80003328:	ffffe097          	auipc	ra,0xffffe
    8000332c:	070080e7          	jalr	112(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003330:	0084b703          	ld	a4,8(s1)
    80003334:	0104a783          	lw	a5,16(s1)
    80003338:	00279693          	slli	a3,a5,0x2
    8000333c:	00d70733          	add	a4,a4,a3
    80003340:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003344:	0017879b          	addiw	a5,a5,1
    80003348:	0004a703          	lw	a4,0(s1)
    8000334c:	02e7e7bb          	remw	a5,a5,a4
    80003350:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003354:	0284b503          	ld	a0,40(s1)
    80003358:	ffffe097          	auipc	ra,0xffffe
    8000335c:	088080e7          	jalr	136(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003360:	0184b503          	ld	a0,24(s1)
    80003364:	ffffe097          	auipc	ra,0xffffe
    80003368:	07c080e7          	jalr	124(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    8000336c:	00090513          	mv	a0,s2
    80003370:	01813083          	ld	ra,24(sp)
    80003374:	01013403          	ld	s0,16(sp)
    80003378:	00813483          	ld	s1,8(sp)
    8000337c:	00013903          	ld	s2,0(sp)
    80003380:	02010113          	addi	sp,sp,32
    80003384:	00008067          	ret

0000000080003388 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003388:	fe010113          	addi	sp,sp,-32
    8000338c:	00113c23          	sd	ra,24(sp)
    80003390:	00813823          	sd	s0,16(sp)
    80003394:	00913423          	sd	s1,8(sp)
    80003398:	02010413          	addi	s0,sp,32
    8000339c:	00050493          	mv	s1,a0
    LOCK();
    800033a0:	00100613          	li	a2,1
    800033a4:	00000593          	li	a1,0
    800033a8:	00004517          	auipc	a0,0x4
    800033ac:	23050513          	addi	a0,a0,560 # 800075d8 <lockPrint>
    800033b0:	ffffe097          	auipc	ra,0xffffe
    800033b4:	da0080e7          	jalr	-608(ra) # 80001150 <copy_and_swap>
    800033b8:	fe0514e3          	bnez	a0,800033a0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800033bc:	0004c503          	lbu	a0,0(s1)
    800033c0:	00050a63          	beqz	a0,800033d4 <_Z11printStringPKc+0x4c>
    {
        __putc(*string);
    800033c4:	00002097          	auipc	ra,0x2
    800033c8:	418080e7          	jalr	1048(ra) # 800057dc <__putc>
        string++;
    800033cc:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800033d0:	fedff06f          	j	800033bc <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800033d4:	00000613          	li	a2,0
    800033d8:	00100593          	li	a1,1
    800033dc:	00004517          	auipc	a0,0x4
    800033e0:	1fc50513          	addi	a0,a0,508 # 800075d8 <lockPrint>
    800033e4:	ffffe097          	auipc	ra,0xffffe
    800033e8:	d6c080e7          	jalr	-660(ra) # 80001150 <copy_and_swap>
    800033ec:	fe0514e3          	bnez	a0,800033d4 <_Z11printStringPKc+0x4c>
}
    800033f0:	01813083          	ld	ra,24(sp)
    800033f4:	01013403          	ld	s0,16(sp)
    800033f8:	00813483          	ld	s1,8(sp)
    800033fc:	02010113          	addi	sp,sp,32
    80003400:	00008067          	ret

0000000080003404 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003404:	fd010113          	addi	sp,sp,-48
    80003408:	02113423          	sd	ra,40(sp)
    8000340c:	02813023          	sd	s0,32(sp)
    80003410:	00913c23          	sd	s1,24(sp)
    80003414:	01213823          	sd	s2,16(sp)
    80003418:	01313423          	sd	s3,8(sp)
    8000341c:	01413023          	sd	s4,0(sp)
    80003420:	03010413          	addi	s0,sp,48
    80003424:	00050993          	mv	s3,a0
    80003428:	00058a13          	mv	s4,a1
    LOCK();
    8000342c:	00100613          	li	a2,1
    80003430:	00000593          	li	a1,0
    80003434:	00004517          	auipc	a0,0x4
    80003438:	1a450513          	addi	a0,a0,420 # 800075d8 <lockPrint>
    8000343c:	ffffe097          	auipc	ra,0xffffe
    80003440:	d14080e7          	jalr	-748(ra) # 80001150 <copy_and_swap>
    80003444:	fe0514e3          	bnez	a0,8000342c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003448:	00000913          	li	s2,0
    8000344c:	00090493          	mv	s1,s2
    80003450:	0019091b          	addiw	s2,s2,1
    80003454:	03495a63          	bge	s2,s4,80003488 <_Z9getStringPci+0x84>
        cc = __getc();
    80003458:	00002097          	auipc	ra,0x2
    8000345c:	3c0080e7          	jalr	960(ra) # 80005818 <__getc>
        if(cc < 1)
    80003460:	02050463          	beqz	a0,80003488 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80003464:	009984b3          	add	s1,s3,s1
    80003468:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000346c:	00a00793          	li	a5,10
    80003470:	00f50a63          	beq	a0,a5,80003484 <_Z9getStringPci+0x80>
    80003474:	00d00793          	li	a5,13
    80003478:	fcf51ae3          	bne	a0,a5,8000344c <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000347c:	00090493          	mv	s1,s2
    80003480:	0080006f          	j	80003488 <_Z9getStringPci+0x84>
    80003484:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003488:	009984b3          	add	s1,s3,s1
    8000348c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003490:	00000613          	li	a2,0
    80003494:	00100593          	li	a1,1
    80003498:	00004517          	auipc	a0,0x4
    8000349c:	14050513          	addi	a0,a0,320 # 800075d8 <lockPrint>
    800034a0:	ffffe097          	auipc	ra,0xffffe
    800034a4:	cb0080e7          	jalr	-848(ra) # 80001150 <copy_and_swap>
    800034a8:	fe0514e3          	bnez	a0,80003490 <_Z9getStringPci+0x8c>
    return buf;
}
    800034ac:	00098513          	mv	a0,s3
    800034b0:	02813083          	ld	ra,40(sp)
    800034b4:	02013403          	ld	s0,32(sp)
    800034b8:	01813483          	ld	s1,24(sp)
    800034bc:	01013903          	ld	s2,16(sp)
    800034c0:	00813983          	ld	s3,8(sp)
    800034c4:	00013a03          	ld	s4,0(sp)
    800034c8:	03010113          	addi	sp,sp,48
    800034cc:	00008067          	ret

00000000800034d0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800034d0:	ff010113          	addi	sp,sp,-16
    800034d4:	00813423          	sd	s0,8(sp)
    800034d8:	01010413          	addi	s0,sp,16
    800034dc:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800034e0:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800034e4:	0006c603          	lbu	a2,0(a3)
    800034e8:	fd06071b          	addiw	a4,a2,-48
    800034ec:	0ff77713          	andi	a4,a4,255
    800034f0:	00900793          	li	a5,9
    800034f4:	02e7e063          	bltu	a5,a4,80003514 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800034f8:	0025179b          	slliw	a5,a0,0x2
    800034fc:	00a787bb          	addw	a5,a5,a0
    80003500:	0017979b          	slliw	a5,a5,0x1
    80003504:	00168693          	addi	a3,a3,1
    80003508:	00c787bb          	addw	a5,a5,a2
    8000350c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003510:	fd5ff06f          	j	800034e4 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003514:	00813403          	ld	s0,8(sp)
    80003518:	01010113          	addi	sp,sp,16
    8000351c:	00008067          	ret

0000000080003520 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003520:	fc010113          	addi	sp,sp,-64
    80003524:	02113c23          	sd	ra,56(sp)
    80003528:	02813823          	sd	s0,48(sp)
    8000352c:	02913423          	sd	s1,40(sp)
    80003530:	03213023          	sd	s2,32(sp)
    80003534:	01313c23          	sd	s3,24(sp)
    80003538:	04010413          	addi	s0,sp,64
    8000353c:	00050493          	mv	s1,a0
    80003540:	00058913          	mv	s2,a1
    80003544:	00060993          	mv	s3,a2
    LOCK();
    80003548:	00100613          	li	a2,1
    8000354c:	00000593          	li	a1,0
    80003550:	00004517          	auipc	a0,0x4
    80003554:	08850513          	addi	a0,a0,136 # 800075d8 <lockPrint>
    80003558:	ffffe097          	auipc	ra,0xffffe
    8000355c:	bf8080e7          	jalr	-1032(ra) # 80001150 <copy_and_swap>
    80003560:	fe0514e3          	bnez	a0,80003548 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003564:	00098463          	beqz	s3,8000356c <_Z8printIntiii+0x4c>
    80003568:	0804c463          	bltz	s1,800035f0 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000356c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003570:	00000593          	li	a1,0
    }

    i = 0;
    80003574:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003578:	0009079b          	sext.w	a5,s2
    8000357c:	0325773b          	remuw	a4,a0,s2
    80003580:	00048613          	mv	a2,s1
    80003584:	0014849b          	addiw	s1,s1,1
    80003588:	02071693          	slli	a3,a4,0x20
    8000358c:	0206d693          	srli	a3,a3,0x20
    80003590:	00004717          	auipc	a4,0x4
    80003594:	ec070713          	addi	a4,a4,-320 # 80007450 <digits>
    80003598:	00d70733          	add	a4,a4,a3
    8000359c:	00074683          	lbu	a3,0(a4)
    800035a0:	fd040713          	addi	a4,s0,-48
    800035a4:	00c70733          	add	a4,a4,a2
    800035a8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800035ac:	0005071b          	sext.w	a4,a0
    800035b0:	0325553b          	divuw	a0,a0,s2
    800035b4:	fcf772e3          	bgeu	a4,a5,80003578 <_Z8printIntiii+0x58>
    if(neg)
    800035b8:	00058c63          	beqz	a1,800035d0 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800035bc:	fd040793          	addi	a5,s0,-48
    800035c0:	009784b3          	add	s1,a5,s1
    800035c4:	02d00793          	li	a5,45
    800035c8:	fef48823          	sb	a5,-16(s1)
    800035cc:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800035d0:	fff4849b          	addiw	s1,s1,-1
    800035d4:	0204c463          	bltz	s1,800035fc <_Z8printIntiii+0xdc>
        __putc(buf[i]);
    800035d8:	fd040793          	addi	a5,s0,-48
    800035dc:	009787b3          	add	a5,a5,s1
    800035e0:	ff07c503          	lbu	a0,-16(a5)
    800035e4:	00002097          	auipc	ra,0x2
    800035e8:	1f8080e7          	jalr	504(ra) # 800057dc <__putc>
    800035ec:	fe5ff06f          	j	800035d0 <_Z8printIntiii+0xb0>
        x = -xx;
    800035f0:	4090053b          	negw	a0,s1
        neg = 1;
    800035f4:	00100593          	li	a1,1
        x = -xx;
    800035f8:	f7dff06f          	j	80003574 <_Z8printIntiii+0x54>

    UNLOCK();
    800035fc:	00000613          	li	a2,0
    80003600:	00100593          	li	a1,1
    80003604:	00004517          	auipc	a0,0x4
    80003608:	fd450513          	addi	a0,a0,-44 # 800075d8 <lockPrint>
    8000360c:	ffffe097          	auipc	ra,0xffffe
    80003610:	b44080e7          	jalr	-1212(ra) # 80001150 <copy_and_swap>
    80003614:	fe0514e3          	bnez	a0,800035fc <_Z8printIntiii+0xdc>
}
    80003618:	03813083          	ld	ra,56(sp)
    8000361c:	03013403          	ld	s0,48(sp)
    80003620:	02813483          	ld	s1,40(sp)
    80003624:	02013903          	ld	s2,32(sp)
    80003628:	01813983          	ld	s3,24(sp)
    8000362c:	04010113          	addi	sp,sp,64
    80003630:	00008067          	ret

0000000080003634 <_Z10printErrorv>:
void printError() {
    80003634:	fd010113          	addi	sp,sp,-48
    80003638:	02113423          	sd	ra,40(sp)
    8000363c:	02813023          	sd	s0,32(sp)
    80003640:	03010413          	addi	s0,sp,48
    LOCK();
    80003644:	00100613          	li	a2,1
    80003648:	00000593          	li	a1,0
    8000364c:	00004517          	auipc	a0,0x4
    80003650:	f8c50513          	addi	a0,a0,-116 # 800075d8 <lockPrint>
    80003654:	ffffe097          	auipc	ra,0xffffe
    80003658:	afc080e7          	jalr	-1284(ra) # 80001150 <copy_and_swap>
    8000365c:	fe0514e3          	bnez	a0,80003644 <_Z10printErrorv+0x10>
    printString("scause: ");
    80003660:	00003517          	auipc	a0,0x3
    80003664:	ae850513          	addi	a0,a0,-1304 # 80006148 <CONSOLE_STATUS+0x138>
    80003668:	00000097          	auipc	ra,0x0
    8000366c:	d20080e7          	jalr	-736(ra) # 80003388 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003670:	142027f3          	csrr	a5,scause
    80003674:	fef43423          	sd	a5,-24(s0)
        return scause;
    80003678:	fe843503          	ld	a0,-24(s0)
    printInt(Kernel::r_scause());
    8000367c:	00000613          	li	a2,0
    80003680:	00a00593          	li	a1,10
    80003684:	0005051b          	sext.w	a0,a0
    80003688:	00000097          	auipc	ra,0x0
    8000368c:	e98080e7          	jalr	-360(ra) # 80003520 <_Z8printIntiii>
    printString("\nsepc: ");
    80003690:	00003517          	auipc	a0,0x3
    80003694:	ac850513          	addi	a0,a0,-1336 # 80006158 <CONSOLE_STATUS+0x148>
    80003698:	00000097          	auipc	ra,0x0
    8000369c:	cf0080e7          	jalr	-784(ra) # 80003388 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800036a0:	141027f3          	csrr	a5,sepc
    800036a4:	fef43023          	sd	a5,-32(s0)
        return sepc;
    800036a8:	fe043503          	ld	a0,-32(s0)
    printInt(Kernel::r_sepc());
    800036ac:	00000613          	li	a2,0
    800036b0:	00a00593          	li	a1,10
    800036b4:	0005051b          	sext.w	a0,a0
    800036b8:	00000097          	auipc	ra,0x0
    800036bc:	e68080e7          	jalr	-408(ra) # 80003520 <_Z8printIntiii>
    printString("\nstval: ");
    800036c0:	00003517          	auipc	a0,0x3
    800036c4:	aa050513          	addi	a0,a0,-1376 # 80006160 <CONSOLE_STATUS+0x150>
    800036c8:	00000097          	auipc	ra,0x0
    800036cc:	cc0080e7          	jalr	-832(ra) # 80003388 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800036d0:	143027f3          	csrr	a5,stval
    800036d4:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    800036d8:	fd843503          	ld	a0,-40(s0)
    printInt(Kernel::r_stval());
    800036dc:	00000613          	li	a2,0
    800036e0:	00a00593          	li	a1,10
    800036e4:	0005051b          	sext.w	a0,a0
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	e38080e7          	jalr	-456(ra) # 80003520 <_Z8printIntiii>
    UNLOCK();
    800036f0:	00000613          	li	a2,0
    800036f4:	00100593          	li	a1,1
    800036f8:	00004517          	auipc	a0,0x4
    800036fc:	ee050513          	addi	a0,a0,-288 # 800075d8 <lockPrint>
    80003700:	ffffe097          	auipc	ra,0xffffe
    80003704:	a50080e7          	jalr	-1456(ra) # 80001150 <copy_and_swap>
    80003708:	fe0514e3          	bnez	a0,800036f0 <_Z10printErrorv+0xbc>
    8000370c:	02813083          	ld	ra,40(sp)
    80003710:	02013403          	ld	s0,32(sp)
    80003714:	03010113          	addi	sp,sp,48
    80003718:	00008067          	ret

000000008000371c <start>:
    8000371c:	ff010113          	addi	sp,sp,-16
    80003720:	00813423          	sd	s0,8(sp)
    80003724:	01010413          	addi	s0,sp,16
    80003728:	300027f3          	csrr	a5,mstatus
    8000372c:	ffffe737          	lui	a4,0xffffe
    80003730:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5fbf>
    80003734:	00e7f7b3          	and	a5,a5,a4
    80003738:	00001737          	lui	a4,0x1
    8000373c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003740:	00e7e7b3          	or	a5,a5,a4
    80003744:	30079073          	csrw	mstatus,a5
    80003748:	00000797          	auipc	a5,0x0
    8000374c:	16078793          	addi	a5,a5,352 # 800038a8 <system_main>
    80003750:	34179073          	csrw	mepc,a5
    80003754:	00000793          	li	a5,0
    80003758:	18079073          	csrw	satp,a5
    8000375c:	000107b7          	lui	a5,0x10
    80003760:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003764:	30279073          	csrw	medeleg,a5
    80003768:	30379073          	csrw	mideleg,a5
    8000376c:	104027f3          	csrr	a5,sie
    80003770:	2227e793          	ori	a5,a5,546
    80003774:	10479073          	csrw	sie,a5
    80003778:	fff00793          	li	a5,-1
    8000377c:	00a7d793          	srli	a5,a5,0xa
    80003780:	3b079073          	csrw	pmpaddr0,a5
    80003784:	00f00793          	li	a5,15
    80003788:	3a079073          	csrw	pmpcfg0,a5
    8000378c:	f14027f3          	csrr	a5,mhartid
    80003790:	0200c737          	lui	a4,0x200c
    80003794:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003798:	0007869b          	sext.w	a3,a5
    8000379c:	00269713          	slli	a4,a3,0x2
    800037a0:	000f4637          	lui	a2,0xf4
    800037a4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800037a8:	00d70733          	add	a4,a4,a3
    800037ac:	0037979b          	slliw	a5,a5,0x3
    800037b0:	020046b7          	lui	a3,0x2004
    800037b4:	00d787b3          	add	a5,a5,a3
    800037b8:	00c585b3          	add	a1,a1,a2
    800037bc:	00371693          	slli	a3,a4,0x3
    800037c0:	00004717          	auipc	a4,0x4
    800037c4:	e2070713          	addi	a4,a4,-480 # 800075e0 <timer_scratch>
    800037c8:	00b7b023          	sd	a1,0(a5)
    800037cc:	00d70733          	add	a4,a4,a3
    800037d0:	00f73c23          	sd	a5,24(a4)
    800037d4:	02c73023          	sd	a2,32(a4)
    800037d8:	34071073          	csrw	mscratch,a4
    800037dc:	00000797          	auipc	a5,0x0
    800037e0:	6e478793          	addi	a5,a5,1764 # 80003ec0 <timervec>
    800037e4:	30579073          	csrw	mtvec,a5
    800037e8:	300027f3          	csrr	a5,mstatus
    800037ec:	0087e793          	ori	a5,a5,8
    800037f0:	30079073          	csrw	mstatus,a5
    800037f4:	304027f3          	csrr	a5,mie
    800037f8:	0807e793          	ori	a5,a5,128
    800037fc:	30479073          	csrw	mie,a5
    80003800:	f14027f3          	csrr	a5,mhartid
    80003804:	0007879b          	sext.w	a5,a5
    80003808:	00078213          	mv	tp,a5
    8000380c:	30200073          	mret
    80003810:	00813403          	ld	s0,8(sp)
    80003814:	01010113          	addi	sp,sp,16
    80003818:	00008067          	ret

000000008000381c <timerinit>:
    8000381c:	ff010113          	addi	sp,sp,-16
    80003820:	00813423          	sd	s0,8(sp)
    80003824:	01010413          	addi	s0,sp,16
    80003828:	f14027f3          	csrr	a5,mhartid
    8000382c:	0200c737          	lui	a4,0x200c
    80003830:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003834:	0007869b          	sext.w	a3,a5
    80003838:	00269713          	slli	a4,a3,0x2
    8000383c:	000f4637          	lui	a2,0xf4
    80003840:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003844:	00d70733          	add	a4,a4,a3
    80003848:	0037979b          	slliw	a5,a5,0x3
    8000384c:	020046b7          	lui	a3,0x2004
    80003850:	00d787b3          	add	a5,a5,a3
    80003854:	00c585b3          	add	a1,a1,a2
    80003858:	00371693          	slli	a3,a4,0x3
    8000385c:	00004717          	auipc	a4,0x4
    80003860:	d8470713          	addi	a4,a4,-636 # 800075e0 <timer_scratch>
    80003864:	00b7b023          	sd	a1,0(a5)
    80003868:	00d70733          	add	a4,a4,a3
    8000386c:	00f73c23          	sd	a5,24(a4)
    80003870:	02c73023          	sd	a2,32(a4)
    80003874:	34071073          	csrw	mscratch,a4
    80003878:	00000797          	auipc	a5,0x0
    8000387c:	64878793          	addi	a5,a5,1608 # 80003ec0 <timervec>
    80003880:	30579073          	csrw	mtvec,a5
    80003884:	300027f3          	csrr	a5,mstatus
    80003888:	0087e793          	ori	a5,a5,8
    8000388c:	30079073          	csrw	mstatus,a5
    80003890:	304027f3          	csrr	a5,mie
    80003894:	0807e793          	ori	a5,a5,128
    80003898:	30479073          	csrw	mie,a5
    8000389c:	00813403          	ld	s0,8(sp)
    800038a0:	01010113          	addi	sp,sp,16
    800038a4:	00008067          	ret

00000000800038a8 <system_main>:
    800038a8:	fe010113          	addi	sp,sp,-32
    800038ac:	00813823          	sd	s0,16(sp)
    800038b0:	00913423          	sd	s1,8(sp)
    800038b4:	00113c23          	sd	ra,24(sp)
    800038b8:	02010413          	addi	s0,sp,32
    800038bc:	00000097          	auipc	ra,0x0
    800038c0:	0c4080e7          	jalr	196(ra) # 80003980 <cpuid>
    800038c4:	00004497          	auipc	s1,0x4
    800038c8:	c5c48493          	addi	s1,s1,-932 # 80007520 <started>
    800038cc:	02050263          	beqz	a0,800038f0 <system_main+0x48>
    800038d0:	0004a783          	lw	a5,0(s1)
    800038d4:	0007879b          	sext.w	a5,a5
    800038d8:	fe078ce3          	beqz	a5,800038d0 <system_main+0x28>
    800038dc:	0ff0000f          	fence
    800038e0:	00003517          	auipc	a0,0x3
    800038e4:	8c050513          	addi	a0,a0,-1856 # 800061a0 <CONSOLE_STATUS+0x190>
    800038e8:	00001097          	auipc	ra,0x1
    800038ec:	a74080e7          	jalr	-1420(ra) # 8000435c <panic>
    800038f0:	00001097          	auipc	ra,0x1
    800038f4:	9c8080e7          	jalr	-1592(ra) # 800042b8 <consoleinit>
    800038f8:	00001097          	auipc	ra,0x1
    800038fc:	154080e7          	jalr	340(ra) # 80004a4c <printfinit>
    80003900:	00003517          	auipc	a0,0x3
    80003904:	98050513          	addi	a0,a0,-1664 # 80006280 <CONSOLE_STATUS+0x270>
    80003908:	00001097          	auipc	ra,0x1
    8000390c:	ab0080e7          	jalr	-1360(ra) # 800043b8 <__printf>
    80003910:	00003517          	auipc	a0,0x3
    80003914:	86050513          	addi	a0,a0,-1952 # 80006170 <CONSOLE_STATUS+0x160>
    80003918:	00001097          	auipc	ra,0x1
    8000391c:	aa0080e7          	jalr	-1376(ra) # 800043b8 <__printf>
    80003920:	00003517          	auipc	a0,0x3
    80003924:	96050513          	addi	a0,a0,-1696 # 80006280 <CONSOLE_STATUS+0x270>
    80003928:	00001097          	auipc	ra,0x1
    8000392c:	a90080e7          	jalr	-1392(ra) # 800043b8 <__printf>
    80003930:	00001097          	auipc	ra,0x1
    80003934:	4a8080e7          	jalr	1192(ra) # 80004dd8 <kinit>
    80003938:	00000097          	auipc	ra,0x0
    8000393c:	148080e7          	jalr	328(ra) # 80003a80 <trapinit>
    80003940:	00000097          	auipc	ra,0x0
    80003944:	16c080e7          	jalr	364(ra) # 80003aac <trapinithart>
    80003948:	00000097          	auipc	ra,0x0
    8000394c:	5b8080e7          	jalr	1464(ra) # 80003f00 <plicinit>
    80003950:	00000097          	auipc	ra,0x0
    80003954:	5d8080e7          	jalr	1496(ra) # 80003f28 <plicinithart>
    80003958:	00000097          	auipc	ra,0x0
    8000395c:	078080e7          	jalr	120(ra) # 800039d0 <userinit>
    80003960:	0ff0000f          	fence
    80003964:	00100793          	li	a5,1
    80003968:	00003517          	auipc	a0,0x3
    8000396c:	82050513          	addi	a0,a0,-2016 # 80006188 <CONSOLE_STATUS+0x178>
    80003970:	00f4a023          	sw	a5,0(s1)
    80003974:	00001097          	auipc	ra,0x1
    80003978:	a44080e7          	jalr	-1468(ra) # 800043b8 <__printf>
    8000397c:	0000006f          	j	8000397c <system_main+0xd4>

0000000080003980 <cpuid>:
    80003980:	ff010113          	addi	sp,sp,-16
    80003984:	00813423          	sd	s0,8(sp)
    80003988:	01010413          	addi	s0,sp,16
    8000398c:	00020513          	mv	a0,tp
    80003990:	00813403          	ld	s0,8(sp)
    80003994:	0005051b          	sext.w	a0,a0
    80003998:	01010113          	addi	sp,sp,16
    8000399c:	00008067          	ret

00000000800039a0 <mycpu>:
    800039a0:	ff010113          	addi	sp,sp,-16
    800039a4:	00813423          	sd	s0,8(sp)
    800039a8:	01010413          	addi	s0,sp,16
    800039ac:	00020793          	mv	a5,tp
    800039b0:	00813403          	ld	s0,8(sp)
    800039b4:	0007879b          	sext.w	a5,a5
    800039b8:	00779793          	slli	a5,a5,0x7
    800039bc:	00005517          	auipc	a0,0x5
    800039c0:	c5450513          	addi	a0,a0,-940 # 80008610 <cpus>
    800039c4:	00f50533          	add	a0,a0,a5
    800039c8:	01010113          	addi	sp,sp,16
    800039cc:	00008067          	ret

00000000800039d0 <userinit>:
    800039d0:	ff010113          	addi	sp,sp,-16
    800039d4:	00813423          	sd	s0,8(sp)
    800039d8:	01010413          	addi	s0,sp,16
    800039dc:	00813403          	ld	s0,8(sp)
    800039e0:	01010113          	addi	sp,sp,16
    800039e4:	fffff317          	auipc	t1,0xfffff
    800039e8:	a3430067          	jr	-1484(t1) # 80002418 <main>

00000000800039ec <either_copyout>:
    800039ec:	ff010113          	addi	sp,sp,-16
    800039f0:	00813023          	sd	s0,0(sp)
    800039f4:	00113423          	sd	ra,8(sp)
    800039f8:	01010413          	addi	s0,sp,16
    800039fc:	02051663          	bnez	a0,80003a28 <either_copyout+0x3c>
    80003a00:	00058513          	mv	a0,a1
    80003a04:	00060593          	mv	a1,a2
    80003a08:	0006861b          	sext.w	a2,a3
    80003a0c:	00002097          	auipc	ra,0x2
    80003a10:	c58080e7          	jalr	-936(ra) # 80005664 <__memmove>
    80003a14:	00813083          	ld	ra,8(sp)
    80003a18:	00013403          	ld	s0,0(sp)
    80003a1c:	00000513          	li	a0,0
    80003a20:	01010113          	addi	sp,sp,16
    80003a24:	00008067          	ret
    80003a28:	00002517          	auipc	a0,0x2
    80003a2c:	7a050513          	addi	a0,a0,1952 # 800061c8 <CONSOLE_STATUS+0x1b8>
    80003a30:	00001097          	auipc	ra,0x1
    80003a34:	92c080e7          	jalr	-1748(ra) # 8000435c <panic>

0000000080003a38 <either_copyin>:
    80003a38:	ff010113          	addi	sp,sp,-16
    80003a3c:	00813023          	sd	s0,0(sp)
    80003a40:	00113423          	sd	ra,8(sp)
    80003a44:	01010413          	addi	s0,sp,16
    80003a48:	02059463          	bnez	a1,80003a70 <either_copyin+0x38>
    80003a4c:	00060593          	mv	a1,a2
    80003a50:	0006861b          	sext.w	a2,a3
    80003a54:	00002097          	auipc	ra,0x2
    80003a58:	c10080e7          	jalr	-1008(ra) # 80005664 <__memmove>
    80003a5c:	00813083          	ld	ra,8(sp)
    80003a60:	00013403          	ld	s0,0(sp)
    80003a64:	00000513          	li	a0,0
    80003a68:	01010113          	addi	sp,sp,16
    80003a6c:	00008067          	ret
    80003a70:	00002517          	auipc	a0,0x2
    80003a74:	78050513          	addi	a0,a0,1920 # 800061f0 <CONSOLE_STATUS+0x1e0>
    80003a78:	00001097          	auipc	ra,0x1
    80003a7c:	8e4080e7          	jalr	-1820(ra) # 8000435c <panic>

0000000080003a80 <trapinit>:
    80003a80:	ff010113          	addi	sp,sp,-16
    80003a84:	00813423          	sd	s0,8(sp)
    80003a88:	01010413          	addi	s0,sp,16
    80003a8c:	00813403          	ld	s0,8(sp)
    80003a90:	00002597          	auipc	a1,0x2
    80003a94:	78858593          	addi	a1,a1,1928 # 80006218 <CONSOLE_STATUS+0x208>
    80003a98:	00005517          	auipc	a0,0x5
    80003a9c:	bf850513          	addi	a0,a0,-1032 # 80008690 <tickslock>
    80003aa0:	01010113          	addi	sp,sp,16
    80003aa4:	00001317          	auipc	t1,0x1
    80003aa8:	5c430067          	jr	1476(t1) # 80005068 <initlock>

0000000080003aac <trapinithart>:
    80003aac:	ff010113          	addi	sp,sp,-16
    80003ab0:	00813423          	sd	s0,8(sp)
    80003ab4:	01010413          	addi	s0,sp,16
    80003ab8:	00000797          	auipc	a5,0x0
    80003abc:	2f878793          	addi	a5,a5,760 # 80003db0 <kernelvec>
    80003ac0:	10579073          	csrw	stvec,a5
    80003ac4:	00813403          	ld	s0,8(sp)
    80003ac8:	01010113          	addi	sp,sp,16
    80003acc:	00008067          	ret

0000000080003ad0 <usertrap>:
    80003ad0:	ff010113          	addi	sp,sp,-16
    80003ad4:	00813423          	sd	s0,8(sp)
    80003ad8:	01010413          	addi	s0,sp,16
    80003adc:	00813403          	ld	s0,8(sp)
    80003ae0:	01010113          	addi	sp,sp,16
    80003ae4:	00008067          	ret

0000000080003ae8 <usertrapret>:
    80003ae8:	ff010113          	addi	sp,sp,-16
    80003aec:	00813423          	sd	s0,8(sp)
    80003af0:	01010413          	addi	s0,sp,16
    80003af4:	00813403          	ld	s0,8(sp)
    80003af8:	01010113          	addi	sp,sp,16
    80003afc:	00008067          	ret

0000000080003b00 <kerneltrap>:
    80003b00:	fe010113          	addi	sp,sp,-32
    80003b04:	00813823          	sd	s0,16(sp)
    80003b08:	00113c23          	sd	ra,24(sp)
    80003b0c:	00913423          	sd	s1,8(sp)
    80003b10:	02010413          	addi	s0,sp,32
    80003b14:	142025f3          	csrr	a1,scause
    80003b18:	100027f3          	csrr	a5,sstatus
    80003b1c:	0027f793          	andi	a5,a5,2
    80003b20:	10079c63          	bnez	a5,80003c38 <kerneltrap+0x138>
    80003b24:	142027f3          	csrr	a5,scause
    80003b28:	0207ce63          	bltz	a5,80003b64 <kerneltrap+0x64>
    80003b2c:	00002517          	auipc	a0,0x2
    80003b30:	73450513          	addi	a0,a0,1844 # 80006260 <CONSOLE_STATUS+0x250>
    80003b34:	00001097          	auipc	ra,0x1
    80003b38:	884080e7          	jalr	-1916(ra) # 800043b8 <__printf>
    80003b3c:	141025f3          	csrr	a1,sepc
    80003b40:	14302673          	csrr	a2,stval
    80003b44:	00002517          	auipc	a0,0x2
    80003b48:	72c50513          	addi	a0,a0,1836 # 80006270 <CONSOLE_STATUS+0x260>
    80003b4c:	00001097          	auipc	ra,0x1
    80003b50:	86c080e7          	jalr	-1940(ra) # 800043b8 <__printf>
    80003b54:	00002517          	auipc	a0,0x2
    80003b58:	73450513          	addi	a0,a0,1844 # 80006288 <CONSOLE_STATUS+0x278>
    80003b5c:	00001097          	auipc	ra,0x1
    80003b60:	800080e7          	jalr	-2048(ra) # 8000435c <panic>
    80003b64:	0ff7f713          	andi	a4,a5,255
    80003b68:	00900693          	li	a3,9
    80003b6c:	04d70063          	beq	a4,a3,80003bac <kerneltrap+0xac>
    80003b70:	fff00713          	li	a4,-1
    80003b74:	03f71713          	slli	a4,a4,0x3f
    80003b78:	00170713          	addi	a4,a4,1
    80003b7c:	fae798e3          	bne	a5,a4,80003b2c <kerneltrap+0x2c>
    80003b80:	00000097          	auipc	ra,0x0
    80003b84:	e00080e7          	jalr	-512(ra) # 80003980 <cpuid>
    80003b88:	06050663          	beqz	a0,80003bf4 <kerneltrap+0xf4>
    80003b8c:	144027f3          	csrr	a5,sip
    80003b90:	ffd7f793          	andi	a5,a5,-3
    80003b94:	14479073          	csrw	sip,a5
    80003b98:	01813083          	ld	ra,24(sp)
    80003b9c:	01013403          	ld	s0,16(sp)
    80003ba0:	00813483          	ld	s1,8(sp)
    80003ba4:	02010113          	addi	sp,sp,32
    80003ba8:	00008067          	ret
    80003bac:	00000097          	auipc	ra,0x0
    80003bb0:	3c8080e7          	jalr	968(ra) # 80003f74 <plic_claim>
    80003bb4:	00a00793          	li	a5,10
    80003bb8:	00050493          	mv	s1,a0
    80003bbc:	06f50863          	beq	a0,a5,80003c2c <kerneltrap+0x12c>
    80003bc0:	fc050ce3          	beqz	a0,80003b98 <kerneltrap+0x98>
    80003bc4:	00050593          	mv	a1,a0
    80003bc8:	00002517          	auipc	a0,0x2
    80003bcc:	67850513          	addi	a0,a0,1656 # 80006240 <CONSOLE_STATUS+0x230>
    80003bd0:	00000097          	auipc	ra,0x0
    80003bd4:	7e8080e7          	jalr	2024(ra) # 800043b8 <__printf>
    80003bd8:	01013403          	ld	s0,16(sp)
    80003bdc:	01813083          	ld	ra,24(sp)
    80003be0:	00048513          	mv	a0,s1
    80003be4:	00813483          	ld	s1,8(sp)
    80003be8:	02010113          	addi	sp,sp,32
    80003bec:	00000317          	auipc	t1,0x0
    80003bf0:	3c030067          	jr	960(t1) # 80003fac <plic_complete>
    80003bf4:	00005517          	auipc	a0,0x5
    80003bf8:	a9c50513          	addi	a0,a0,-1380 # 80008690 <tickslock>
    80003bfc:	00001097          	auipc	ra,0x1
    80003c00:	490080e7          	jalr	1168(ra) # 8000508c <acquire>
    80003c04:	00004717          	auipc	a4,0x4
    80003c08:	92070713          	addi	a4,a4,-1760 # 80007524 <ticks>
    80003c0c:	00072783          	lw	a5,0(a4)
    80003c10:	00005517          	auipc	a0,0x5
    80003c14:	a8050513          	addi	a0,a0,-1408 # 80008690 <tickslock>
    80003c18:	0017879b          	addiw	a5,a5,1
    80003c1c:	00f72023          	sw	a5,0(a4)
    80003c20:	00001097          	auipc	ra,0x1
    80003c24:	538080e7          	jalr	1336(ra) # 80005158 <release>
    80003c28:	f65ff06f          	j	80003b8c <kerneltrap+0x8c>
    80003c2c:	00001097          	auipc	ra,0x1
    80003c30:	094080e7          	jalr	148(ra) # 80004cc0 <uartintr>
    80003c34:	fa5ff06f          	j	80003bd8 <kerneltrap+0xd8>
    80003c38:	00002517          	auipc	a0,0x2
    80003c3c:	5e850513          	addi	a0,a0,1512 # 80006220 <CONSOLE_STATUS+0x210>
    80003c40:	00000097          	auipc	ra,0x0
    80003c44:	71c080e7          	jalr	1820(ra) # 8000435c <panic>

0000000080003c48 <clockintr>:
    80003c48:	fe010113          	addi	sp,sp,-32
    80003c4c:	00813823          	sd	s0,16(sp)
    80003c50:	00913423          	sd	s1,8(sp)
    80003c54:	00113c23          	sd	ra,24(sp)
    80003c58:	02010413          	addi	s0,sp,32
    80003c5c:	00005497          	auipc	s1,0x5
    80003c60:	a3448493          	addi	s1,s1,-1484 # 80008690 <tickslock>
    80003c64:	00048513          	mv	a0,s1
    80003c68:	00001097          	auipc	ra,0x1
    80003c6c:	424080e7          	jalr	1060(ra) # 8000508c <acquire>
    80003c70:	00004717          	auipc	a4,0x4
    80003c74:	8b470713          	addi	a4,a4,-1868 # 80007524 <ticks>
    80003c78:	00072783          	lw	a5,0(a4)
    80003c7c:	01013403          	ld	s0,16(sp)
    80003c80:	01813083          	ld	ra,24(sp)
    80003c84:	00048513          	mv	a0,s1
    80003c88:	0017879b          	addiw	a5,a5,1
    80003c8c:	00813483          	ld	s1,8(sp)
    80003c90:	00f72023          	sw	a5,0(a4)
    80003c94:	02010113          	addi	sp,sp,32
    80003c98:	00001317          	auipc	t1,0x1
    80003c9c:	4c030067          	jr	1216(t1) # 80005158 <release>

0000000080003ca0 <devintr>:
    80003ca0:	142027f3          	csrr	a5,scause
    80003ca4:	00000513          	li	a0,0
    80003ca8:	0007c463          	bltz	a5,80003cb0 <devintr+0x10>
    80003cac:	00008067          	ret
    80003cb0:	fe010113          	addi	sp,sp,-32
    80003cb4:	00813823          	sd	s0,16(sp)
    80003cb8:	00113c23          	sd	ra,24(sp)
    80003cbc:	00913423          	sd	s1,8(sp)
    80003cc0:	02010413          	addi	s0,sp,32
    80003cc4:	0ff7f713          	andi	a4,a5,255
    80003cc8:	00900693          	li	a3,9
    80003ccc:	04d70c63          	beq	a4,a3,80003d24 <devintr+0x84>
    80003cd0:	fff00713          	li	a4,-1
    80003cd4:	03f71713          	slli	a4,a4,0x3f
    80003cd8:	00170713          	addi	a4,a4,1
    80003cdc:	00e78c63          	beq	a5,a4,80003cf4 <devintr+0x54>
    80003ce0:	01813083          	ld	ra,24(sp)
    80003ce4:	01013403          	ld	s0,16(sp)
    80003ce8:	00813483          	ld	s1,8(sp)
    80003cec:	02010113          	addi	sp,sp,32
    80003cf0:	00008067          	ret
    80003cf4:	00000097          	auipc	ra,0x0
    80003cf8:	c8c080e7          	jalr	-884(ra) # 80003980 <cpuid>
    80003cfc:	06050663          	beqz	a0,80003d68 <devintr+0xc8>
    80003d00:	144027f3          	csrr	a5,sip
    80003d04:	ffd7f793          	andi	a5,a5,-3
    80003d08:	14479073          	csrw	sip,a5
    80003d0c:	01813083          	ld	ra,24(sp)
    80003d10:	01013403          	ld	s0,16(sp)
    80003d14:	00813483          	ld	s1,8(sp)
    80003d18:	00200513          	li	a0,2
    80003d1c:	02010113          	addi	sp,sp,32
    80003d20:	00008067          	ret
    80003d24:	00000097          	auipc	ra,0x0
    80003d28:	250080e7          	jalr	592(ra) # 80003f74 <plic_claim>
    80003d2c:	00a00793          	li	a5,10
    80003d30:	00050493          	mv	s1,a0
    80003d34:	06f50663          	beq	a0,a5,80003da0 <devintr+0x100>
    80003d38:	00100513          	li	a0,1
    80003d3c:	fa0482e3          	beqz	s1,80003ce0 <devintr+0x40>
    80003d40:	00048593          	mv	a1,s1
    80003d44:	00002517          	auipc	a0,0x2
    80003d48:	4fc50513          	addi	a0,a0,1276 # 80006240 <CONSOLE_STATUS+0x230>
    80003d4c:	00000097          	auipc	ra,0x0
    80003d50:	66c080e7          	jalr	1644(ra) # 800043b8 <__printf>
    80003d54:	00048513          	mv	a0,s1
    80003d58:	00000097          	auipc	ra,0x0
    80003d5c:	254080e7          	jalr	596(ra) # 80003fac <plic_complete>
    80003d60:	00100513          	li	a0,1
    80003d64:	f7dff06f          	j	80003ce0 <devintr+0x40>
    80003d68:	00005517          	auipc	a0,0x5
    80003d6c:	92850513          	addi	a0,a0,-1752 # 80008690 <tickslock>
    80003d70:	00001097          	auipc	ra,0x1
    80003d74:	31c080e7          	jalr	796(ra) # 8000508c <acquire>
    80003d78:	00003717          	auipc	a4,0x3
    80003d7c:	7ac70713          	addi	a4,a4,1964 # 80007524 <ticks>
    80003d80:	00072783          	lw	a5,0(a4)
    80003d84:	00005517          	auipc	a0,0x5
    80003d88:	90c50513          	addi	a0,a0,-1780 # 80008690 <tickslock>
    80003d8c:	0017879b          	addiw	a5,a5,1
    80003d90:	00f72023          	sw	a5,0(a4)
    80003d94:	00001097          	auipc	ra,0x1
    80003d98:	3c4080e7          	jalr	964(ra) # 80005158 <release>
    80003d9c:	f65ff06f          	j	80003d00 <devintr+0x60>
    80003da0:	00001097          	auipc	ra,0x1
    80003da4:	f20080e7          	jalr	-224(ra) # 80004cc0 <uartintr>
    80003da8:	fadff06f          	j	80003d54 <devintr+0xb4>
    80003dac:	0000                	unimp
	...

0000000080003db0 <kernelvec>:
    80003db0:	f0010113          	addi	sp,sp,-256
    80003db4:	00113023          	sd	ra,0(sp)
    80003db8:	00213423          	sd	sp,8(sp)
    80003dbc:	00313823          	sd	gp,16(sp)
    80003dc0:	00413c23          	sd	tp,24(sp)
    80003dc4:	02513023          	sd	t0,32(sp)
    80003dc8:	02613423          	sd	t1,40(sp)
    80003dcc:	02713823          	sd	t2,48(sp)
    80003dd0:	02813c23          	sd	s0,56(sp)
    80003dd4:	04913023          	sd	s1,64(sp)
    80003dd8:	04a13423          	sd	a0,72(sp)
    80003ddc:	04b13823          	sd	a1,80(sp)
    80003de0:	04c13c23          	sd	a2,88(sp)
    80003de4:	06d13023          	sd	a3,96(sp)
    80003de8:	06e13423          	sd	a4,104(sp)
    80003dec:	06f13823          	sd	a5,112(sp)
    80003df0:	07013c23          	sd	a6,120(sp)
    80003df4:	09113023          	sd	a7,128(sp)
    80003df8:	09213423          	sd	s2,136(sp)
    80003dfc:	09313823          	sd	s3,144(sp)
    80003e00:	09413c23          	sd	s4,152(sp)
    80003e04:	0b513023          	sd	s5,160(sp)
    80003e08:	0b613423          	sd	s6,168(sp)
    80003e0c:	0b713823          	sd	s7,176(sp)
    80003e10:	0b813c23          	sd	s8,184(sp)
    80003e14:	0d913023          	sd	s9,192(sp)
    80003e18:	0da13423          	sd	s10,200(sp)
    80003e1c:	0db13823          	sd	s11,208(sp)
    80003e20:	0dc13c23          	sd	t3,216(sp)
    80003e24:	0fd13023          	sd	t4,224(sp)
    80003e28:	0fe13423          	sd	t5,232(sp)
    80003e2c:	0ff13823          	sd	t6,240(sp)
    80003e30:	cd1ff0ef          	jal	ra,80003b00 <kerneltrap>
    80003e34:	00013083          	ld	ra,0(sp)
    80003e38:	00813103          	ld	sp,8(sp)
    80003e3c:	01013183          	ld	gp,16(sp)
    80003e40:	02013283          	ld	t0,32(sp)
    80003e44:	02813303          	ld	t1,40(sp)
    80003e48:	03013383          	ld	t2,48(sp)
    80003e4c:	03813403          	ld	s0,56(sp)
    80003e50:	04013483          	ld	s1,64(sp)
    80003e54:	04813503          	ld	a0,72(sp)
    80003e58:	05013583          	ld	a1,80(sp)
    80003e5c:	05813603          	ld	a2,88(sp)
    80003e60:	06013683          	ld	a3,96(sp)
    80003e64:	06813703          	ld	a4,104(sp)
    80003e68:	07013783          	ld	a5,112(sp)
    80003e6c:	07813803          	ld	a6,120(sp)
    80003e70:	08013883          	ld	a7,128(sp)
    80003e74:	08813903          	ld	s2,136(sp)
    80003e78:	09013983          	ld	s3,144(sp)
    80003e7c:	09813a03          	ld	s4,152(sp)
    80003e80:	0a013a83          	ld	s5,160(sp)
    80003e84:	0a813b03          	ld	s6,168(sp)
    80003e88:	0b013b83          	ld	s7,176(sp)
    80003e8c:	0b813c03          	ld	s8,184(sp)
    80003e90:	0c013c83          	ld	s9,192(sp)
    80003e94:	0c813d03          	ld	s10,200(sp)
    80003e98:	0d013d83          	ld	s11,208(sp)
    80003e9c:	0d813e03          	ld	t3,216(sp)
    80003ea0:	0e013e83          	ld	t4,224(sp)
    80003ea4:	0e813f03          	ld	t5,232(sp)
    80003ea8:	0f013f83          	ld	t6,240(sp)
    80003eac:	10010113          	addi	sp,sp,256
    80003eb0:	10200073          	sret
    80003eb4:	00000013          	nop
    80003eb8:	00000013          	nop
    80003ebc:	00000013          	nop

0000000080003ec0 <timervec>:
    80003ec0:	34051573          	csrrw	a0,mscratch,a0
    80003ec4:	00b53023          	sd	a1,0(a0)
    80003ec8:	00c53423          	sd	a2,8(a0)
    80003ecc:	00d53823          	sd	a3,16(a0)
    80003ed0:	01853583          	ld	a1,24(a0)
    80003ed4:	02053603          	ld	a2,32(a0)
    80003ed8:	0005b683          	ld	a3,0(a1)
    80003edc:	00c686b3          	add	a3,a3,a2
    80003ee0:	00d5b023          	sd	a3,0(a1)
    80003ee4:	00200593          	li	a1,2
    80003ee8:	14459073          	csrw	sip,a1
    80003eec:	01053683          	ld	a3,16(a0)
    80003ef0:	00853603          	ld	a2,8(a0)
    80003ef4:	00053583          	ld	a1,0(a0)
    80003ef8:	34051573          	csrrw	a0,mscratch,a0
    80003efc:	30200073          	mret

0000000080003f00 <plicinit>:
    80003f00:	ff010113          	addi	sp,sp,-16
    80003f04:	00813423          	sd	s0,8(sp)
    80003f08:	01010413          	addi	s0,sp,16
    80003f0c:	00813403          	ld	s0,8(sp)
    80003f10:	0c0007b7          	lui	a5,0xc000
    80003f14:	00100713          	li	a4,1
    80003f18:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003f1c:	00e7a223          	sw	a4,4(a5)
    80003f20:	01010113          	addi	sp,sp,16
    80003f24:	00008067          	ret

0000000080003f28 <plicinithart>:
    80003f28:	ff010113          	addi	sp,sp,-16
    80003f2c:	00813023          	sd	s0,0(sp)
    80003f30:	00113423          	sd	ra,8(sp)
    80003f34:	01010413          	addi	s0,sp,16
    80003f38:	00000097          	auipc	ra,0x0
    80003f3c:	a48080e7          	jalr	-1464(ra) # 80003980 <cpuid>
    80003f40:	0085171b          	slliw	a4,a0,0x8
    80003f44:	0c0027b7          	lui	a5,0xc002
    80003f48:	00e787b3          	add	a5,a5,a4
    80003f4c:	40200713          	li	a4,1026
    80003f50:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003f54:	00813083          	ld	ra,8(sp)
    80003f58:	00013403          	ld	s0,0(sp)
    80003f5c:	00d5151b          	slliw	a0,a0,0xd
    80003f60:	0c2017b7          	lui	a5,0xc201
    80003f64:	00a78533          	add	a0,a5,a0
    80003f68:	00052023          	sw	zero,0(a0)
    80003f6c:	01010113          	addi	sp,sp,16
    80003f70:	00008067          	ret

0000000080003f74 <plic_claim>:
    80003f74:	ff010113          	addi	sp,sp,-16
    80003f78:	00813023          	sd	s0,0(sp)
    80003f7c:	00113423          	sd	ra,8(sp)
    80003f80:	01010413          	addi	s0,sp,16
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	9fc080e7          	jalr	-1540(ra) # 80003980 <cpuid>
    80003f8c:	00813083          	ld	ra,8(sp)
    80003f90:	00013403          	ld	s0,0(sp)
    80003f94:	00d5151b          	slliw	a0,a0,0xd
    80003f98:	0c2017b7          	lui	a5,0xc201
    80003f9c:	00a78533          	add	a0,a5,a0
    80003fa0:	00452503          	lw	a0,4(a0)
    80003fa4:	01010113          	addi	sp,sp,16
    80003fa8:	00008067          	ret

0000000080003fac <plic_complete>:
    80003fac:	fe010113          	addi	sp,sp,-32
    80003fb0:	00813823          	sd	s0,16(sp)
    80003fb4:	00913423          	sd	s1,8(sp)
    80003fb8:	00113c23          	sd	ra,24(sp)
    80003fbc:	02010413          	addi	s0,sp,32
    80003fc0:	00050493          	mv	s1,a0
    80003fc4:	00000097          	auipc	ra,0x0
    80003fc8:	9bc080e7          	jalr	-1604(ra) # 80003980 <cpuid>
    80003fcc:	01813083          	ld	ra,24(sp)
    80003fd0:	01013403          	ld	s0,16(sp)
    80003fd4:	00d5179b          	slliw	a5,a0,0xd
    80003fd8:	0c201737          	lui	a4,0xc201
    80003fdc:	00f707b3          	add	a5,a4,a5
    80003fe0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003fe4:	00813483          	ld	s1,8(sp)
    80003fe8:	02010113          	addi	sp,sp,32
    80003fec:	00008067          	ret

0000000080003ff0 <consolewrite>:
    80003ff0:	fb010113          	addi	sp,sp,-80
    80003ff4:	04813023          	sd	s0,64(sp)
    80003ff8:	04113423          	sd	ra,72(sp)
    80003ffc:	02913c23          	sd	s1,56(sp)
    80004000:	03213823          	sd	s2,48(sp)
    80004004:	03313423          	sd	s3,40(sp)
    80004008:	03413023          	sd	s4,32(sp)
    8000400c:	01513c23          	sd	s5,24(sp)
    80004010:	05010413          	addi	s0,sp,80
    80004014:	06c05c63          	blez	a2,8000408c <consolewrite+0x9c>
    80004018:	00060993          	mv	s3,a2
    8000401c:	00050a13          	mv	s4,a0
    80004020:	00058493          	mv	s1,a1
    80004024:	00000913          	li	s2,0
    80004028:	fff00a93          	li	s5,-1
    8000402c:	01c0006f          	j	80004048 <consolewrite+0x58>
    80004030:	fbf44503          	lbu	a0,-65(s0)
    80004034:	0019091b          	addiw	s2,s2,1
    80004038:	00148493          	addi	s1,s1,1
    8000403c:	00001097          	auipc	ra,0x1
    80004040:	a9c080e7          	jalr	-1380(ra) # 80004ad8 <uartputc>
    80004044:	03298063          	beq	s3,s2,80004064 <consolewrite+0x74>
    80004048:	00048613          	mv	a2,s1
    8000404c:	00100693          	li	a3,1
    80004050:	000a0593          	mv	a1,s4
    80004054:	fbf40513          	addi	a0,s0,-65
    80004058:	00000097          	auipc	ra,0x0
    8000405c:	9e0080e7          	jalr	-1568(ra) # 80003a38 <either_copyin>
    80004060:	fd5518e3          	bne	a0,s5,80004030 <consolewrite+0x40>
    80004064:	04813083          	ld	ra,72(sp)
    80004068:	04013403          	ld	s0,64(sp)
    8000406c:	03813483          	ld	s1,56(sp)
    80004070:	02813983          	ld	s3,40(sp)
    80004074:	02013a03          	ld	s4,32(sp)
    80004078:	01813a83          	ld	s5,24(sp)
    8000407c:	00090513          	mv	a0,s2
    80004080:	03013903          	ld	s2,48(sp)
    80004084:	05010113          	addi	sp,sp,80
    80004088:	00008067          	ret
    8000408c:	00000913          	li	s2,0
    80004090:	fd5ff06f          	j	80004064 <consolewrite+0x74>

0000000080004094 <consoleread>:
    80004094:	f9010113          	addi	sp,sp,-112
    80004098:	06813023          	sd	s0,96(sp)
    8000409c:	04913c23          	sd	s1,88(sp)
    800040a0:	05213823          	sd	s2,80(sp)
    800040a4:	05313423          	sd	s3,72(sp)
    800040a8:	05413023          	sd	s4,64(sp)
    800040ac:	03513c23          	sd	s5,56(sp)
    800040b0:	03613823          	sd	s6,48(sp)
    800040b4:	03713423          	sd	s7,40(sp)
    800040b8:	03813023          	sd	s8,32(sp)
    800040bc:	06113423          	sd	ra,104(sp)
    800040c0:	01913c23          	sd	s9,24(sp)
    800040c4:	07010413          	addi	s0,sp,112
    800040c8:	00060b93          	mv	s7,a2
    800040cc:	00050913          	mv	s2,a0
    800040d0:	00058c13          	mv	s8,a1
    800040d4:	00060b1b          	sext.w	s6,a2
    800040d8:	00004497          	auipc	s1,0x4
    800040dc:	5e048493          	addi	s1,s1,1504 # 800086b8 <cons>
    800040e0:	00400993          	li	s3,4
    800040e4:	fff00a13          	li	s4,-1
    800040e8:	00a00a93          	li	s5,10
    800040ec:	05705e63          	blez	s7,80004148 <consoleread+0xb4>
    800040f0:	09c4a703          	lw	a4,156(s1)
    800040f4:	0984a783          	lw	a5,152(s1)
    800040f8:	0007071b          	sext.w	a4,a4
    800040fc:	08e78463          	beq	a5,a4,80004184 <consoleread+0xf0>
    80004100:	07f7f713          	andi	a4,a5,127
    80004104:	00e48733          	add	a4,s1,a4
    80004108:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000410c:	0017869b          	addiw	a3,a5,1
    80004110:	08d4ac23          	sw	a3,152(s1)
    80004114:	00070c9b          	sext.w	s9,a4
    80004118:	0b370663          	beq	a4,s3,800041c4 <consoleread+0x130>
    8000411c:	00100693          	li	a3,1
    80004120:	f9f40613          	addi	a2,s0,-97
    80004124:	000c0593          	mv	a1,s8
    80004128:	00090513          	mv	a0,s2
    8000412c:	f8e40fa3          	sb	a4,-97(s0)
    80004130:	00000097          	auipc	ra,0x0
    80004134:	8bc080e7          	jalr	-1860(ra) # 800039ec <either_copyout>
    80004138:	01450863          	beq	a0,s4,80004148 <consoleread+0xb4>
    8000413c:	001c0c13          	addi	s8,s8,1
    80004140:	fffb8b9b          	addiw	s7,s7,-1
    80004144:	fb5c94e3          	bne	s9,s5,800040ec <consoleread+0x58>
    80004148:	000b851b          	sext.w	a0,s7
    8000414c:	06813083          	ld	ra,104(sp)
    80004150:	06013403          	ld	s0,96(sp)
    80004154:	05813483          	ld	s1,88(sp)
    80004158:	05013903          	ld	s2,80(sp)
    8000415c:	04813983          	ld	s3,72(sp)
    80004160:	04013a03          	ld	s4,64(sp)
    80004164:	03813a83          	ld	s5,56(sp)
    80004168:	02813b83          	ld	s7,40(sp)
    8000416c:	02013c03          	ld	s8,32(sp)
    80004170:	01813c83          	ld	s9,24(sp)
    80004174:	40ab053b          	subw	a0,s6,a0
    80004178:	03013b03          	ld	s6,48(sp)
    8000417c:	07010113          	addi	sp,sp,112
    80004180:	00008067          	ret
    80004184:	00001097          	auipc	ra,0x1
    80004188:	1d8080e7          	jalr	472(ra) # 8000535c <push_on>
    8000418c:	0984a703          	lw	a4,152(s1)
    80004190:	09c4a783          	lw	a5,156(s1)
    80004194:	0007879b          	sext.w	a5,a5
    80004198:	fef70ce3          	beq	a4,a5,80004190 <consoleread+0xfc>
    8000419c:	00001097          	auipc	ra,0x1
    800041a0:	234080e7          	jalr	564(ra) # 800053d0 <pop_on>
    800041a4:	0984a783          	lw	a5,152(s1)
    800041a8:	07f7f713          	andi	a4,a5,127
    800041ac:	00e48733          	add	a4,s1,a4
    800041b0:	01874703          	lbu	a4,24(a4)
    800041b4:	0017869b          	addiw	a3,a5,1
    800041b8:	08d4ac23          	sw	a3,152(s1)
    800041bc:	00070c9b          	sext.w	s9,a4
    800041c0:	f5371ee3          	bne	a4,s3,8000411c <consoleread+0x88>
    800041c4:	000b851b          	sext.w	a0,s7
    800041c8:	f96bf2e3          	bgeu	s7,s6,8000414c <consoleread+0xb8>
    800041cc:	08f4ac23          	sw	a5,152(s1)
    800041d0:	f7dff06f          	j	8000414c <consoleread+0xb8>

00000000800041d4 <consputc>:
    800041d4:	10000793          	li	a5,256
    800041d8:	00f50663          	beq	a0,a5,800041e4 <consputc+0x10>
    800041dc:	00001317          	auipc	t1,0x1
    800041e0:	9f430067          	jr	-1548(t1) # 80004bd0 <uartputc_sync>
    800041e4:	ff010113          	addi	sp,sp,-16
    800041e8:	00113423          	sd	ra,8(sp)
    800041ec:	00813023          	sd	s0,0(sp)
    800041f0:	01010413          	addi	s0,sp,16
    800041f4:	00800513          	li	a0,8
    800041f8:	00001097          	auipc	ra,0x1
    800041fc:	9d8080e7          	jalr	-1576(ra) # 80004bd0 <uartputc_sync>
    80004200:	02000513          	li	a0,32
    80004204:	00001097          	auipc	ra,0x1
    80004208:	9cc080e7          	jalr	-1588(ra) # 80004bd0 <uartputc_sync>
    8000420c:	00013403          	ld	s0,0(sp)
    80004210:	00813083          	ld	ra,8(sp)
    80004214:	00800513          	li	a0,8
    80004218:	01010113          	addi	sp,sp,16
    8000421c:	00001317          	auipc	t1,0x1
    80004220:	9b430067          	jr	-1612(t1) # 80004bd0 <uartputc_sync>

0000000080004224 <consoleintr>:
    80004224:	fe010113          	addi	sp,sp,-32
    80004228:	00813823          	sd	s0,16(sp)
    8000422c:	00913423          	sd	s1,8(sp)
    80004230:	01213023          	sd	s2,0(sp)
    80004234:	00113c23          	sd	ra,24(sp)
    80004238:	02010413          	addi	s0,sp,32
    8000423c:	00004917          	auipc	s2,0x4
    80004240:	47c90913          	addi	s2,s2,1148 # 800086b8 <cons>
    80004244:	00050493          	mv	s1,a0
    80004248:	00090513          	mv	a0,s2
    8000424c:	00001097          	auipc	ra,0x1
    80004250:	e40080e7          	jalr	-448(ra) # 8000508c <acquire>
    80004254:	02048c63          	beqz	s1,8000428c <consoleintr+0x68>
    80004258:	0a092783          	lw	a5,160(s2)
    8000425c:	09892703          	lw	a4,152(s2)
    80004260:	07f00693          	li	a3,127
    80004264:	40e7873b          	subw	a4,a5,a4
    80004268:	02e6e263          	bltu	a3,a4,8000428c <consoleintr+0x68>
    8000426c:	00d00713          	li	a4,13
    80004270:	04e48063          	beq	s1,a4,800042b0 <consoleintr+0x8c>
    80004274:	07f7f713          	andi	a4,a5,127
    80004278:	00e90733          	add	a4,s2,a4
    8000427c:	0017879b          	addiw	a5,a5,1
    80004280:	0af92023          	sw	a5,160(s2)
    80004284:	00970c23          	sb	s1,24(a4)
    80004288:	08f92e23          	sw	a5,156(s2)
    8000428c:	01013403          	ld	s0,16(sp)
    80004290:	01813083          	ld	ra,24(sp)
    80004294:	00813483          	ld	s1,8(sp)
    80004298:	00013903          	ld	s2,0(sp)
    8000429c:	00004517          	auipc	a0,0x4
    800042a0:	41c50513          	addi	a0,a0,1052 # 800086b8 <cons>
    800042a4:	02010113          	addi	sp,sp,32
    800042a8:	00001317          	auipc	t1,0x1
    800042ac:	eb030067          	jr	-336(t1) # 80005158 <release>
    800042b0:	00a00493          	li	s1,10
    800042b4:	fc1ff06f          	j	80004274 <consoleintr+0x50>

00000000800042b8 <consoleinit>:
    800042b8:	fe010113          	addi	sp,sp,-32
    800042bc:	00113c23          	sd	ra,24(sp)
    800042c0:	00813823          	sd	s0,16(sp)
    800042c4:	00913423          	sd	s1,8(sp)
    800042c8:	02010413          	addi	s0,sp,32
    800042cc:	00004497          	auipc	s1,0x4
    800042d0:	3ec48493          	addi	s1,s1,1004 # 800086b8 <cons>
    800042d4:	00048513          	mv	a0,s1
    800042d8:	00002597          	auipc	a1,0x2
    800042dc:	fc058593          	addi	a1,a1,-64 # 80006298 <CONSOLE_STATUS+0x288>
    800042e0:	00001097          	auipc	ra,0x1
    800042e4:	d88080e7          	jalr	-632(ra) # 80005068 <initlock>
    800042e8:	00000097          	auipc	ra,0x0
    800042ec:	7ac080e7          	jalr	1964(ra) # 80004a94 <uartinit>
    800042f0:	01813083          	ld	ra,24(sp)
    800042f4:	01013403          	ld	s0,16(sp)
    800042f8:	00000797          	auipc	a5,0x0
    800042fc:	d9c78793          	addi	a5,a5,-612 # 80004094 <consoleread>
    80004300:	0af4bc23          	sd	a5,184(s1)
    80004304:	00000797          	auipc	a5,0x0
    80004308:	cec78793          	addi	a5,a5,-788 # 80003ff0 <consolewrite>
    8000430c:	0cf4b023          	sd	a5,192(s1)
    80004310:	00813483          	ld	s1,8(sp)
    80004314:	02010113          	addi	sp,sp,32
    80004318:	00008067          	ret

000000008000431c <console_read>:
    8000431c:	ff010113          	addi	sp,sp,-16
    80004320:	00813423          	sd	s0,8(sp)
    80004324:	01010413          	addi	s0,sp,16
    80004328:	00813403          	ld	s0,8(sp)
    8000432c:	00004317          	auipc	t1,0x4
    80004330:	44433303          	ld	t1,1092(t1) # 80008770 <devsw+0x10>
    80004334:	01010113          	addi	sp,sp,16
    80004338:	00030067          	jr	t1

000000008000433c <console_write>:
    8000433c:	ff010113          	addi	sp,sp,-16
    80004340:	00813423          	sd	s0,8(sp)
    80004344:	01010413          	addi	s0,sp,16
    80004348:	00813403          	ld	s0,8(sp)
    8000434c:	00004317          	auipc	t1,0x4
    80004350:	42c33303          	ld	t1,1068(t1) # 80008778 <devsw+0x18>
    80004354:	01010113          	addi	sp,sp,16
    80004358:	00030067          	jr	t1

000000008000435c <panic>:
    8000435c:	fe010113          	addi	sp,sp,-32
    80004360:	00113c23          	sd	ra,24(sp)
    80004364:	00813823          	sd	s0,16(sp)
    80004368:	00913423          	sd	s1,8(sp)
    8000436c:	02010413          	addi	s0,sp,32
    80004370:	00050493          	mv	s1,a0
    80004374:	00002517          	auipc	a0,0x2
    80004378:	f2c50513          	addi	a0,a0,-212 # 800062a0 <CONSOLE_STATUS+0x290>
    8000437c:	00004797          	auipc	a5,0x4
    80004380:	4807ae23          	sw	zero,1180(a5) # 80008818 <pr+0x18>
    80004384:	00000097          	auipc	ra,0x0
    80004388:	034080e7          	jalr	52(ra) # 800043b8 <__printf>
    8000438c:	00048513          	mv	a0,s1
    80004390:	00000097          	auipc	ra,0x0
    80004394:	028080e7          	jalr	40(ra) # 800043b8 <__printf>
    80004398:	00002517          	auipc	a0,0x2
    8000439c:	ee850513          	addi	a0,a0,-280 # 80006280 <CONSOLE_STATUS+0x270>
    800043a0:	00000097          	auipc	ra,0x0
    800043a4:	018080e7          	jalr	24(ra) # 800043b8 <__printf>
    800043a8:	00100793          	li	a5,1
    800043ac:	00003717          	auipc	a4,0x3
    800043b0:	16f72e23          	sw	a5,380(a4) # 80007528 <panicked>
    800043b4:	0000006f          	j	800043b4 <panic+0x58>

00000000800043b8 <__printf>:
    800043b8:	f3010113          	addi	sp,sp,-208
    800043bc:	08813023          	sd	s0,128(sp)
    800043c0:	07313423          	sd	s3,104(sp)
    800043c4:	09010413          	addi	s0,sp,144
    800043c8:	05813023          	sd	s8,64(sp)
    800043cc:	08113423          	sd	ra,136(sp)
    800043d0:	06913c23          	sd	s1,120(sp)
    800043d4:	07213823          	sd	s2,112(sp)
    800043d8:	07413023          	sd	s4,96(sp)
    800043dc:	05513c23          	sd	s5,88(sp)
    800043e0:	05613823          	sd	s6,80(sp)
    800043e4:	05713423          	sd	s7,72(sp)
    800043e8:	03913c23          	sd	s9,56(sp)
    800043ec:	03a13823          	sd	s10,48(sp)
    800043f0:	03b13423          	sd	s11,40(sp)
    800043f4:	00004317          	auipc	t1,0x4
    800043f8:	40c30313          	addi	t1,t1,1036 # 80008800 <pr>
    800043fc:	01832c03          	lw	s8,24(t1)
    80004400:	00b43423          	sd	a1,8(s0)
    80004404:	00c43823          	sd	a2,16(s0)
    80004408:	00d43c23          	sd	a3,24(s0)
    8000440c:	02e43023          	sd	a4,32(s0)
    80004410:	02f43423          	sd	a5,40(s0)
    80004414:	03043823          	sd	a6,48(s0)
    80004418:	03143c23          	sd	a7,56(s0)
    8000441c:	00050993          	mv	s3,a0
    80004420:	4a0c1663          	bnez	s8,800048cc <__printf+0x514>
    80004424:	60098c63          	beqz	s3,80004a3c <__printf+0x684>
    80004428:	0009c503          	lbu	a0,0(s3)
    8000442c:	00840793          	addi	a5,s0,8
    80004430:	f6f43c23          	sd	a5,-136(s0)
    80004434:	00000493          	li	s1,0
    80004438:	22050063          	beqz	a0,80004658 <__printf+0x2a0>
    8000443c:	00002a37          	lui	s4,0x2
    80004440:	00018ab7          	lui	s5,0x18
    80004444:	000f4b37          	lui	s6,0xf4
    80004448:	00989bb7          	lui	s7,0x989
    8000444c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004450:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004454:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004458:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000445c:	00148c9b          	addiw	s9,s1,1
    80004460:	02500793          	li	a5,37
    80004464:	01998933          	add	s2,s3,s9
    80004468:	38f51263          	bne	a0,a5,800047ec <__printf+0x434>
    8000446c:	00094783          	lbu	a5,0(s2)
    80004470:	00078c9b          	sext.w	s9,a5
    80004474:	1e078263          	beqz	a5,80004658 <__printf+0x2a0>
    80004478:	0024849b          	addiw	s1,s1,2
    8000447c:	07000713          	li	a4,112
    80004480:	00998933          	add	s2,s3,s1
    80004484:	38e78a63          	beq	a5,a4,80004818 <__printf+0x460>
    80004488:	20f76863          	bltu	a4,a5,80004698 <__printf+0x2e0>
    8000448c:	42a78863          	beq	a5,a0,800048bc <__printf+0x504>
    80004490:	06400713          	li	a4,100
    80004494:	40e79663          	bne	a5,a4,800048a0 <__printf+0x4e8>
    80004498:	f7843783          	ld	a5,-136(s0)
    8000449c:	0007a603          	lw	a2,0(a5)
    800044a0:	00878793          	addi	a5,a5,8
    800044a4:	f6f43c23          	sd	a5,-136(s0)
    800044a8:	42064a63          	bltz	a2,800048dc <__printf+0x524>
    800044ac:	00a00713          	li	a4,10
    800044b0:	02e677bb          	remuw	a5,a2,a4
    800044b4:	00002d97          	auipc	s11,0x2
    800044b8:	e14d8d93          	addi	s11,s11,-492 # 800062c8 <digits>
    800044bc:	00900593          	li	a1,9
    800044c0:	0006051b          	sext.w	a0,a2
    800044c4:	00000c93          	li	s9,0
    800044c8:	02079793          	slli	a5,a5,0x20
    800044cc:	0207d793          	srli	a5,a5,0x20
    800044d0:	00fd87b3          	add	a5,s11,a5
    800044d4:	0007c783          	lbu	a5,0(a5)
    800044d8:	02e656bb          	divuw	a3,a2,a4
    800044dc:	f8f40023          	sb	a5,-128(s0)
    800044e0:	14c5d863          	bge	a1,a2,80004630 <__printf+0x278>
    800044e4:	06300593          	li	a1,99
    800044e8:	00100c93          	li	s9,1
    800044ec:	02e6f7bb          	remuw	a5,a3,a4
    800044f0:	02079793          	slli	a5,a5,0x20
    800044f4:	0207d793          	srli	a5,a5,0x20
    800044f8:	00fd87b3          	add	a5,s11,a5
    800044fc:	0007c783          	lbu	a5,0(a5)
    80004500:	02e6d73b          	divuw	a4,a3,a4
    80004504:	f8f400a3          	sb	a5,-127(s0)
    80004508:	12a5f463          	bgeu	a1,a0,80004630 <__printf+0x278>
    8000450c:	00a00693          	li	a3,10
    80004510:	00900593          	li	a1,9
    80004514:	02d777bb          	remuw	a5,a4,a3
    80004518:	02079793          	slli	a5,a5,0x20
    8000451c:	0207d793          	srli	a5,a5,0x20
    80004520:	00fd87b3          	add	a5,s11,a5
    80004524:	0007c503          	lbu	a0,0(a5)
    80004528:	02d757bb          	divuw	a5,a4,a3
    8000452c:	f8a40123          	sb	a0,-126(s0)
    80004530:	48e5f263          	bgeu	a1,a4,800049b4 <__printf+0x5fc>
    80004534:	06300513          	li	a0,99
    80004538:	02d7f5bb          	remuw	a1,a5,a3
    8000453c:	02059593          	slli	a1,a1,0x20
    80004540:	0205d593          	srli	a1,a1,0x20
    80004544:	00bd85b3          	add	a1,s11,a1
    80004548:	0005c583          	lbu	a1,0(a1)
    8000454c:	02d7d7bb          	divuw	a5,a5,a3
    80004550:	f8b401a3          	sb	a1,-125(s0)
    80004554:	48e57263          	bgeu	a0,a4,800049d8 <__printf+0x620>
    80004558:	3e700513          	li	a0,999
    8000455c:	02d7f5bb          	remuw	a1,a5,a3
    80004560:	02059593          	slli	a1,a1,0x20
    80004564:	0205d593          	srli	a1,a1,0x20
    80004568:	00bd85b3          	add	a1,s11,a1
    8000456c:	0005c583          	lbu	a1,0(a1)
    80004570:	02d7d7bb          	divuw	a5,a5,a3
    80004574:	f8b40223          	sb	a1,-124(s0)
    80004578:	46e57663          	bgeu	a0,a4,800049e4 <__printf+0x62c>
    8000457c:	02d7f5bb          	remuw	a1,a5,a3
    80004580:	02059593          	slli	a1,a1,0x20
    80004584:	0205d593          	srli	a1,a1,0x20
    80004588:	00bd85b3          	add	a1,s11,a1
    8000458c:	0005c583          	lbu	a1,0(a1)
    80004590:	02d7d7bb          	divuw	a5,a5,a3
    80004594:	f8b402a3          	sb	a1,-123(s0)
    80004598:	46ea7863          	bgeu	s4,a4,80004a08 <__printf+0x650>
    8000459c:	02d7f5bb          	remuw	a1,a5,a3
    800045a0:	02059593          	slli	a1,a1,0x20
    800045a4:	0205d593          	srli	a1,a1,0x20
    800045a8:	00bd85b3          	add	a1,s11,a1
    800045ac:	0005c583          	lbu	a1,0(a1)
    800045b0:	02d7d7bb          	divuw	a5,a5,a3
    800045b4:	f8b40323          	sb	a1,-122(s0)
    800045b8:	3eeaf863          	bgeu	s5,a4,800049a8 <__printf+0x5f0>
    800045bc:	02d7f5bb          	remuw	a1,a5,a3
    800045c0:	02059593          	slli	a1,a1,0x20
    800045c4:	0205d593          	srli	a1,a1,0x20
    800045c8:	00bd85b3          	add	a1,s11,a1
    800045cc:	0005c583          	lbu	a1,0(a1)
    800045d0:	02d7d7bb          	divuw	a5,a5,a3
    800045d4:	f8b403a3          	sb	a1,-121(s0)
    800045d8:	42eb7e63          	bgeu	s6,a4,80004a14 <__printf+0x65c>
    800045dc:	02d7f5bb          	remuw	a1,a5,a3
    800045e0:	02059593          	slli	a1,a1,0x20
    800045e4:	0205d593          	srli	a1,a1,0x20
    800045e8:	00bd85b3          	add	a1,s11,a1
    800045ec:	0005c583          	lbu	a1,0(a1)
    800045f0:	02d7d7bb          	divuw	a5,a5,a3
    800045f4:	f8b40423          	sb	a1,-120(s0)
    800045f8:	42ebfc63          	bgeu	s7,a4,80004a30 <__printf+0x678>
    800045fc:	02079793          	slli	a5,a5,0x20
    80004600:	0207d793          	srli	a5,a5,0x20
    80004604:	00fd8db3          	add	s11,s11,a5
    80004608:	000dc703          	lbu	a4,0(s11)
    8000460c:	00a00793          	li	a5,10
    80004610:	00900c93          	li	s9,9
    80004614:	f8e404a3          	sb	a4,-119(s0)
    80004618:	00065c63          	bgez	a2,80004630 <__printf+0x278>
    8000461c:	f9040713          	addi	a4,s0,-112
    80004620:	00f70733          	add	a4,a4,a5
    80004624:	02d00693          	li	a3,45
    80004628:	fed70823          	sb	a3,-16(a4)
    8000462c:	00078c93          	mv	s9,a5
    80004630:	f8040793          	addi	a5,s0,-128
    80004634:	01978cb3          	add	s9,a5,s9
    80004638:	f7f40d13          	addi	s10,s0,-129
    8000463c:	000cc503          	lbu	a0,0(s9)
    80004640:	fffc8c93          	addi	s9,s9,-1
    80004644:	00000097          	auipc	ra,0x0
    80004648:	b90080e7          	jalr	-1136(ra) # 800041d4 <consputc>
    8000464c:	ffac98e3          	bne	s9,s10,8000463c <__printf+0x284>
    80004650:	00094503          	lbu	a0,0(s2)
    80004654:	e00514e3          	bnez	a0,8000445c <__printf+0xa4>
    80004658:	1a0c1663          	bnez	s8,80004804 <__printf+0x44c>
    8000465c:	08813083          	ld	ra,136(sp)
    80004660:	08013403          	ld	s0,128(sp)
    80004664:	07813483          	ld	s1,120(sp)
    80004668:	07013903          	ld	s2,112(sp)
    8000466c:	06813983          	ld	s3,104(sp)
    80004670:	06013a03          	ld	s4,96(sp)
    80004674:	05813a83          	ld	s5,88(sp)
    80004678:	05013b03          	ld	s6,80(sp)
    8000467c:	04813b83          	ld	s7,72(sp)
    80004680:	04013c03          	ld	s8,64(sp)
    80004684:	03813c83          	ld	s9,56(sp)
    80004688:	03013d03          	ld	s10,48(sp)
    8000468c:	02813d83          	ld	s11,40(sp)
    80004690:	0d010113          	addi	sp,sp,208
    80004694:	00008067          	ret
    80004698:	07300713          	li	a4,115
    8000469c:	1ce78a63          	beq	a5,a4,80004870 <__printf+0x4b8>
    800046a0:	07800713          	li	a4,120
    800046a4:	1ee79e63          	bne	a5,a4,800048a0 <__printf+0x4e8>
    800046a8:	f7843783          	ld	a5,-136(s0)
    800046ac:	0007a703          	lw	a4,0(a5)
    800046b0:	00878793          	addi	a5,a5,8
    800046b4:	f6f43c23          	sd	a5,-136(s0)
    800046b8:	28074263          	bltz	a4,8000493c <__printf+0x584>
    800046bc:	00002d97          	auipc	s11,0x2
    800046c0:	c0cd8d93          	addi	s11,s11,-1012 # 800062c8 <digits>
    800046c4:	00f77793          	andi	a5,a4,15
    800046c8:	00fd87b3          	add	a5,s11,a5
    800046cc:	0007c683          	lbu	a3,0(a5)
    800046d0:	00f00613          	li	a2,15
    800046d4:	0007079b          	sext.w	a5,a4
    800046d8:	f8d40023          	sb	a3,-128(s0)
    800046dc:	0047559b          	srliw	a1,a4,0x4
    800046e0:	0047569b          	srliw	a3,a4,0x4
    800046e4:	00000c93          	li	s9,0
    800046e8:	0ee65063          	bge	a2,a4,800047c8 <__printf+0x410>
    800046ec:	00f6f693          	andi	a3,a3,15
    800046f0:	00dd86b3          	add	a3,s11,a3
    800046f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800046f8:	0087d79b          	srliw	a5,a5,0x8
    800046fc:	00100c93          	li	s9,1
    80004700:	f8d400a3          	sb	a3,-127(s0)
    80004704:	0cb67263          	bgeu	a2,a1,800047c8 <__printf+0x410>
    80004708:	00f7f693          	andi	a3,a5,15
    8000470c:	00dd86b3          	add	a3,s11,a3
    80004710:	0006c583          	lbu	a1,0(a3)
    80004714:	00f00613          	li	a2,15
    80004718:	0047d69b          	srliw	a3,a5,0x4
    8000471c:	f8b40123          	sb	a1,-126(s0)
    80004720:	0047d593          	srli	a1,a5,0x4
    80004724:	28f67e63          	bgeu	a2,a5,800049c0 <__printf+0x608>
    80004728:	00f6f693          	andi	a3,a3,15
    8000472c:	00dd86b3          	add	a3,s11,a3
    80004730:	0006c503          	lbu	a0,0(a3)
    80004734:	0087d813          	srli	a6,a5,0x8
    80004738:	0087d69b          	srliw	a3,a5,0x8
    8000473c:	f8a401a3          	sb	a0,-125(s0)
    80004740:	28b67663          	bgeu	a2,a1,800049cc <__printf+0x614>
    80004744:	00f6f693          	andi	a3,a3,15
    80004748:	00dd86b3          	add	a3,s11,a3
    8000474c:	0006c583          	lbu	a1,0(a3)
    80004750:	00c7d513          	srli	a0,a5,0xc
    80004754:	00c7d69b          	srliw	a3,a5,0xc
    80004758:	f8b40223          	sb	a1,-124(s0)
    8000475c:	29067a63          	bgeu	a2,a6,800049f0 <__printf+0x638>
    80004760:	00f6f693          	andi	a3,a3,15
    80004764:	00dd86b3          	add	a3,s11,a3
    80004768:	0006c583          	lbu	a1,0(a3)
    8000476c:	0107d813          	srli	a6,a5,0x10
    80004770:	0107d69b          	srliw	a3,a5,0x10
    80004774:	f8b402a3          	sb	a1,-123(s0)
    80004778:	28a67263          	bgeu	a2,a0,800049fc <__printf+0x644>
    8000477c:	00f6f693          	andi	a3,a3,15
    80004780:	00dd86b3          	add	a3,s11,a3
    80004784:	0006c683          	lbu	a3,0(a3)
    80004788:	0147d79b          	srliw	a5,a5,0x14
    8000478c:	f8d40323          	sb	a3,-122(s0)
    80004790:	21067663          	bgeu	a2,a6,8000499c <__printf+0x5e4>
    80004794:	02079793          	slli	a5,a5,0x20
    80004798:	0207d793          	srli	a5,a5,0x20
    8000479c:	00fd8db3          	add	s11,s11,a5
    800047a0:	000dc683          	lbu	a3,0(s11)
    800047a4:	00800793          	li	a5,8
    800047a8:	00700c93          	li	s9,7
    800047ac:	f8d403a3          	sb	a3,-121(s0)
    800047b0:	00075c63          	bgez	a4,800047c8 <__printf+0x410>
    800047b4:	f9040713          	addi	a4,s0,-112
    800047b8:	00f70733          	add	a4,a4,a5
    800047bc:	02d00693          	li	a3,45
    800047c0:	fed70823          	sb	a3,-16(a4)
    800047c4:	00078c93          	mv	s9,a5
    800047c8:	f8040793          	addi	a5,s0,-128
    800047cc:	01978cb3          	add	s9,a5,s9
    800047d0:	f7f40d13          	addi	s10,s0,-129
    800047d4:	000cc503          	lbu	a0,0(s9)
    800047d8:	fffc8c93          	addi	s9,s9,-1
    800047dc:	00000097          	auipc	ra,0x0
    800047e0:	9f8080e7          	jalr	-1544(ra) # 800041d4 <consputc>
    800047e4:	ff9d18e3          	bne	s10,s9,800047d4 <__printf+0x41c>
    800047e8:	0100006f          	j	800047f8 <__printf+0x440>
    800047ec:	00000097          	auipc	ra,0x0
    800047f0:	9e8080e7          	jalr	-1560(ra) # 800041d4 <consputc>
    800047f4:	000c8493          	mv	s1,s9
    800047f8:	00094503          	lbu	a0,0(s2)
    800047fc:	c60510e3          	bnez	a0,8000445c <__printf+0xa4>
    80004800:	e40c0ee3          	beqz	s8,8000465c <__printf+0x2a4>
    80004804:	00004517          	auipc	a0,0x4
    80004808:	ffc50513          	addi	a0,a0,-4 # 80008800 <pr>
    8000480c:	00001097          	auipc	ra,0x1
    80004810:	94c080e7          	jalr	-1716(ra) # 80005158 <release>
    80004814:	e49ff06f          	j	8000465c <__printf+0x2a4>
    80004818:	f7843783          	ld	a5,-136(s0)
    8000481c:	03000513          	li	a0,48
    80004820:	01000d13          	li	s10,16
    80004824:	00878713          	addi	a4,a5,8
    80004828:	0007bc83          	ld	s9,0(a5)
    8000482c:	f6e43c23          	sd	a4,-136(s0)
    80004830:	00000097          	auipc	ra,0x0
    80004834:	9a4080e7          	jalr	-1628(ra) # 800041d4 <consputc>
    80004838:	07800513          	li	a0,120
    8000483c:	00000097          	auipc	ra,0x0
    80004840:	998080e7          	jalr	-1640(ra) # 800041d4 <consputc>
    80004844:	00002d97          	auipc	s11,0x2
    80004848:	a84d8d93          	addi	s11,s11,-1404 # 800062c8 <digits>
    8000484c:	03ccd793          	srli	a5,s9,0x3c
    80004850:	00fd87b3          	add	a5,s11,a5
    80004854:	0007c503          	lbu	a0,0(a5)
    80004858:	fffd0d1b          	addiw	s10,s10,-1
    8000485c:	004c9c93          	slli	s9,s9,0x4
    80004860:	00000097          	auipc	ra,0x0
    80004864:	974080e7          	jalr	-1676(ra) # 800041d4 <consputc>
    80004868:	fe0d12e3          	bnez	s10,8000484c <__printf+0x494>
    8000486c:	f8dff06f          	j	800047f8 <__printf+0x440>
    80004870:	f7843783          	ld	a5,-136(s0)
    80004874:	0007bc83          	ld	s9,0(a5)
    80004878:	00878793          	addi	a5,a5,8
    8000487c:	f6f43c23          	sd	a5,-136(s0)
    80004880:	000c9a63          	bnez	s9,80004894 <__printf+0x4dc>
    80004884:	1080006f          	j	8000498c <__printf+0x5d4>
    80004888:	001c8c93          	addi	s9,s9,1
    8000488c:	00000097          	auipc	ra,0x0
    80004890:	948080e7          	jalr	-1720(ra) # 800041d4 <consputc>
    80004894:	000cc503          	lbu	a0,0(s9)
    80004898:	fe0518e3          	bnez	a0,80004888 <__printf+0x4d0>
    8000489c:	f5dff06f          	j	800047f8 <__printf+0x440>
    800048a0:	02500513          	li	a0,37
    800048a4:	00000097          	auipc	ra,0x0
    800048a8:	930080e7          	jalr	-1744(ra) # 800041d4 <consputc>
    800048ac:	000c8513          	mv	a0,s9
    800048b0:	00000097          	auipc	ra,0x0
    800048b4:	924080e7          	jalr	-1756(ra) # 800041d4 <consputc>
    800048b8:	f41ff06f          	j	800047f8 <__printf+0x440>
    800048bc:	02500513          	li	a0,37
    800048c0:	00000097          	auipc	ra,0x0
    800048c4:	914080e7          	jalr	-1772(ra) # 800041d4 <consputc>
    800048c8:	f31ff06f          	j	800047f8 <__printf+0x440>
    800048cc:	00030513          	mv	a0,t1
    800048d0:	00000097          	auipc	ra,0x0
    800048d4:	7bc080e7          	jalr	1980(ra) # 8000508c <acquire>
    800048d8:	b4dff06f          	j	80004424 <__printf+0x6c>
    800048dc:	40c0053b          	negw	a0,a2
    800048e0:	00a00713          	li	a4,10
    800048e4:	02e576bb          	remuw	a3,a0,a4
    800048e8:	00002d97          	auipc	s11,0x2
    800048ec:	9e0d8d93          	addi	s11,s11,-1568 # 800062c8 <digits>
    800048f0:	ff700593          	li	a1,-9
    800048f4:	02069693          	slli	a3,a3,0x20
    800048f8:	0206d693          	srli	a3,a3,0x20
    800048fc:	00dd86b3          	add	a3,s11,a3
    80004900:	0006c683          	lbu	a3,0(a3)
    80004904:	02e557bb          	divuw	a5,a0,a4
    80004908:	f8d40023          	sb	a3,-128(s0)
    8000490c:	10b65e63          	bge	a2,a1,80004a28 <__printf+0x670>
    80004910:	06300593          	li	a1,99
    80004914:	02e7f6bb          	remuw	a3,a5,a4
    80004918:	02069693          	slli	a3,a3,0x20
    8000491c:	0206d693          	srli	a3,a3,0x20
    80004920:	00dd86b3          	add	a3,s11,a3
    80004924:	0006c683          	lbu	a3,0(a3)
    80004928:	02e7d73b          	divuw	a4,a5,a4
    8000492c:	00200793          	li	a5,2
    80004930:	f8d400a3          	sb	a3,-127(s0)
    80004934:	bca5ece3          	bltu	a1,a0,8000450c <__printf+0x154>
    80004938:	ce5ff06f          	j	8000461c <__printf+0x264>
    8000493c:	40e007bb          	negw	a5,a4
    80004940:	00002d97          	auipc	s11,0x2
    80004944:	988d8d93          	addi	s11,s11,-1656 # 800062c8 <digits>
    80004948:	00f7f693          	andi	a3,a5,15
    8000494c:	00dd86b3          	add	a3,s11,a3
    80004950:	0006c583          	lbu	a1,0(a3)
    80004954:	ff100613          	li	a2,-15
    80004958:	0047d69b          	srliw	a3,a5,0x4
    8000495c:	f8b40023          	sb	a1,-128(s0)
    80004960:	0047d59b          	srliw	a1,a5,0x4
    80004964:	0ac75e63          	bge	a4,a2,80004a20 <__printf+0x668>
    80004968:	00f6f693          	andi	a3,a3,15
    8000496c:	00dd86b3          	add	a3,s11,a3
    80004970:	0006c603          	lbu	a2,0(a3)
    80004974:	00f00693          	li	a3,15
    80004978:	0087d79b          	srliw	a5,a5,0x8
    8000497c:	f8c400a3          	sb	a2,-127(s0)
    80004980:	d8b6e4e3          	bltu	a3,a1,80004708 <__printf+0x350>
    80004984:	00200793          	li	a5,2
    80004988:	e2dff06f          	j	800047b4 <__printf+0x3fc>
    8000498c:	00002c97          	auipc	s9,0x2
    80004990:	91cc8c93          	addi	s9,s9,-1764 # 800062a8 <CONSOLE_STATUS+0x298>
    80004994:	02800513          	li	a0,40
    80004998:	ef1ff06f          	j	80004888 <__printf+0x4d0>
    8000499c:	00700793          	li	a5,7
    800049a0:	00600c93          	li	s9,6
    800049a4:	e0dff06f          	j	800047b0 <__printf+0x3f8>
    800049a8:	00700793          	li	a5,7
    800049ac:	00600c93          	li	s9,6
    800049b0:	c69ff06f          	j	80004618 <__printf+0x260>
    800049b4:	00300793          	li	a5,3
    800049b8:	00200c93          	li	s9,2
    800049bc:	c5dff06f          	j	80004618 <__printf+0x260>
    800049c0:	00300793          	li	a5,3
    800049c4:	00200c93          	li	s9,2
    800049c8:	de9ff06f          	j	800047b0 <__printf+0x3f8>
    800049cc:	00400793          	li	a5,4
    800049d0:	00300c93          	li	s9,3
    800049d4:	dddff06f          	j	800047b0 <__printf+0x3f8>
    800049d8:	00400793          	li	a5,4
    800049dc:	00300c93          	li	s9,3
    800049e0:	c39ff06f          	j	80004618 <__printf+0x260>
    800049e4:	00500793          	li	a5,5
    800049e8:	00400c93          	li	s9,4
    800049ec:	c2dff06f          	j	80004618 <__printf+0x260>
    800049f0:	00500793          	li	a5,5
    800049f4:	00400c93          	li	s9,4
    800049f8:	db9ff06f          	j	800047b0 <__printf+0x3f8>
    800049fc:	00600793          	li	a5,6
    80004a00:	00500c93          	li	s9,5
    80004a04:	dadff06f          	j	800047b0 <__printf+0x3f8>
    80004a08:	00600793          	li	a5,6
    80004a0c:	00500c93          	li	s9,5
    80004a10:	c09ff06f          	j	80004618 <__printf+0x260>
    80004a14:	00800793          	li	a5,8
    80004a18:	00700c93          	li	s9,7
    80004a1c:	bfdff06f          	j	80004618 <__printf+0x260>
    80004a20:	00100793          	li	a5,1
    80004a24:	d91ff06f          	j	800047b4 <__printf+0x3fc>
    80004a28:	00100793          	li	a5,1
    80004a2c:	bf1ff06f          	j	8000461c <__printf+0x264>
    80004a30:	00900793          	li	a5,9
    80004a34:	00800c93          	li	s9,8
    80004a38:	be1ff06f          	j	80004618 <__printf+0x260>
    80004a3c:	00002517          	auipc	a0,0x2
    80004a40:	87450513          	addi	a0,a0,-1932 # 800062b0 <CONSOLE_STATUS+0x2a0>
    80004a44:	00000097          	auipc	ra,0x0
    80004a48:	918080e7          	jalr	-1768(ra) # 8000435c <panic>

0000000080004a4c <printfinit>:
    80004a4c:	fe010113          	addi	sp,sp,-32
    80004a50:	00813823          	sd	s0,16(sp)
    80004a54:	00913423          	sd	s1,8(sp)
    80004a58:	00113c23          	sd	ra,24(sp)
    80004a5c:	02010413          	addi	s0,sp,32
    80004a60:	00004497          	auipc	s1,0x4
    80004a64:	da048493          	addi	s1,s1,-608 # 80008800 <pr>
    80004a68:	00048513          	mv	a0,s1
    80004a6c:	00002597          	auipc	a1,0x2
    80004a70:	85458593          	addi	a1,a1,-1964 # 800062c0 <CONSOLE_STATUS+0x2b0>
    80004a74:	00000097          	auipc	ra,0x0
    80004a78:	5f4080e7          	jalr	1524(ra) # 80005068 <initlock>
    80004a7c:	01813083          	ld	ra,24(sp)
    80004a80:	01013403          	ld	s0,16(sp)
    80004a84:	0004ac23          	sw	zero,24(s1)
    80004a88:	00813483          	ld	s1,8(sp)
    80004a8c:	02010113          	addi	sp,sp,32
    80004a90:	00008067          	ret

0000000080004a94 <uartinit>:
    80004a94:	ff010113          	addi	sp,sp,-16
    80004a98:	00813423          	sd	s0,8(sp)
    80004a9c:	01010413          	addi	s0,sp,16
    80004aa0:	100007b7          	lui	a5,0x10000
    80004aa4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004aa8:	f8000713          	li	a4,-128
    80004aac:	00e781a3          	sb	a4,3(a5)
    80004ab0:	00300713          	li	a4,3
    80004ab4:	00e78023          	sb	a4,0(a5)
    80004ab8:	000780a3          	sb	zero,1(a5)
    80004abc:	00e781a3          	sb	a4,3(a5)
    80004ac0:	00700693          	li	a3,7
    80004ac4:	00d78123          	sb	a3,2(a5)
    80004ac8:	00e780a3          	sb	a4,1(a5)
    80004acc:	00813403          	ld	s0,8(sp)
    80004ad0:	01010113          	addi	sp,sp,16
    80004ad4:	00008067          	ret

0000000080004ad8 <uartputc>:
    80004ad8:	00003797          	auipc	a5,0x3
    80004adc:	a507a783          	lw	a5,-1456(a5) # 80007528 <panicked>
    80004ae0:	00078463          	beqz	a5,80004ae8 <uartputc+0x10>
    80004ae4:	0000006f          	j	80004ae4 <uartputc+0xc>
    80004ae8:	fd010113          	addi	sp,sp,-48
    80004aec:	02813023          	sd	s0,32(sp)
    80004af0:	00913c23          	sd	s1,24(sp)
    80004af4:	01213823          	sd	s2,16(sp)
    80004af8:	01313423          	sd	s3,8(sp)
    80004afc:	02113423          	sd	ra,40(sp)
    80004b00:	03010413          	addi	s0,sp,48
    80004b04:	00003917          	auipc	s2,0x3
    80004b08:	a2c90913          	addi	s2,s2,-1492 # 80007530 <uart_tx_r>
    80004b0c:	00093783          	ld	a5,0(s2)
    80004b10:	00003497          	auipc	s1,0x3
    80004b14:	a2848493          	addi	s1,s1,-1496 # 80007538 <uart_tx_w>
    80004b18:	0004b703          	ld	a4,0(s1)
    80004b1c:	02078693          	addi	a3,a5,32
    80004b20:	00050993          	mv	s3,a0
    80004b24:	02e69c63          	bne	a3,a4,80004b5c <uartputc+0x84>
    80004b28:	00001097          	auipc	ra,0x1
    80004b2c:	834080e7          	jalr	-1996(ra) # 8000535c <push_on>
    80004b30:	00093783          	ld	a5,0(s2)
    80004b34:	0004b703          	ld	a4,0(s1)
    80004b38:	02078793          	addi	a5,a5,32
    80004b3c:	00e79463          	bne	a5,a4,80004b44 <uartputc+0x6c>
    80004b40:	0000006f          	j	80004b40 <uartputc+0x68>
    80004b44:	00001097          	auipc	ra,0x1
    80004b48:	88c080e7          	jalr	-1908(ra) # 800053d0 <pop_on>
    80004b4c:	00093783          	ld	a5,0(s2)
    80004b50:	0004b703          	ld	a4,0(s1)
    80004b54:	02078693          	addi	a3,a5,32
    80004b58:	fce688e3          	beq	a3,a4,80004b28 <uartputc+0x50>
    80004b5c:	01f77693          	andi	a3,a4,31
    80004b60:	00004597          	auipc	a1,0x4
    80004b64:	cc058593          	addi	a1,a1,-832 # 80008820 <uart_tx_buf>
    80004b68:	00d586b3          	add	a3,a1,a3
    80004b6c:	00170713          	addi	a4,a4,1
    80004b70:	01368023          	sb	s3,0(a3)
    80004b74:	00e4b023          	sd	a4,0(s1)
    80004b78:	10000637          	lui	a2,0x10000
    80004b7c:	02f71063          	bne	a4,a5,80004b9c <uartputc+0xc4>
    80004b80:	0340006f          	j	80004bb4 <uartputc+0xdc>
    80004b84:	00074703          	lbu	a4,0(a4)
    80004b88:	00f93023          	sd	a5,0(s2)
    80004b8c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004b90:	00093783          	ld	a5,0(s2)
    80004b94:	0004b703          	ld	a4,0(s1)
    80004b98:	00f70e63          	beq	a4,a5,80004bb4 <uartputc+0xdc>
    80004b9c:	00564683          	lbu	a3,5(a2)
    80004ba0:	01f7f713          	andi	a4,a5,31
    80004ba4:	00e58733          	add	a4,a1,a4
    80004ba8:	0206f693          	andi	a3,a3,32
    80004bac:	00178793          	addi	a5,a5,1
    80004bb0:	fc069ae3          	bnez	a3,80004b84 <uartputc+0xac>
    80004bb4:	02813083          	ld	ra,40(sp)
    80004bb8:	02013403          	ld	s0,32(sp)
    80004bbc:	01813483          	ld	s1,24(sp)
    80004bc0:	01013903          	ld	s2,16(sp)
    80004bc4:	00813983          	ld	s3,8(sp)
    80004bc8:	03010113          	addi	sp,sp,48
    80004bcc:	00008067          	ret

0000000080004bd0 <uartputc_sync>:
    80004bd0:	ff010113          	addi	sp,sp,-16
    80004bd4:	00813423          	sd	s0,8(sp)
    80004bd8:	01010413          	addi	s0,sp,16
    80004bdc:	00003717          	auipc	a4,0x3
    80004be0:	94c72703          	lw	a4,-1716(a4) # 80007528 <panicked>
    80004be4:	02071663          	bnez	a4,80004c10 <uartputc_sync+0x40>
    80004be8:	00050793          	mv	a5,a0
    80004bec:	100006b7          	lui	a3,0x10000
    80004bf0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004bf4:	02077713          	andi	a4,a4,32
    80004bf8:	fe070ce3          	beqz	a4,80004bf0 <uartputc_sync+0x20>
    80004bfc:	0ff7f793          	andi	a5,a5,255
    80004c00:	00f68023          	sb	a5,0(a3)
    80004c04:	00813403          	ld	s0,8(sp)
    80004c08:	01010113          	addi	sp,sp,16
    80004c0c:	00008067          	ret
    80004c10:	0000006f          	j	80004c10 <uartputc_sync+0x40>

0000000080004c14 <uartstart>:
    80004c14:	ff010113          	addi	sp,sp,-16
    80004c18:	00813423          	sd	s0,8(sp)
    80004c1c:	01010413          	addi	s0,sp,16
    80004c20:	00003617          	auipc	a2,0x3
    80004c24:	91060613          	addi	a2,a2,-1776 # 80007530 <uart_tx_r>
    80004c28:	00003517          	auipc	a0,0x3
    80004c2c:	91050513          	addi	a0,a0,-1776 # 80007538 <uart_tx_w>
    80004c30:	00063783          	ld	a5,0(a2)
    80004c34:	00053703          	ld	a4,0(a0)
    80004c38:	04f70263          	beq	a4,a5,80004c7c <uartstart+0x68>
    80004c3c:	100005b7          	lui	a1,0x10000
    80004c40:	00004817          	auipc	a6,0x4
    80004c44:	be080813          	addi	a6,a6,-1056 # 80008820 <uart_tx_buf>
    80004c48:	01c0006f          	j	80004c64 <uartstart+0x50>
    80004c4c:	0006c703          	lbu	a4,0(a3)
    80004c50:	00f63023          	sd	a5,0(a2)
    80004c54:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004c58:	00063783          	ld	a5,0(a2)
    80004c5c:	00053703          	ld	a4,0(a0)
    80004c60:	00f70e63          	beq	a4,a5,80004c7c <uartstart+0x68>
    80004c64:	01f7f713          	andi	a4,a5,31
    80004c68:	00e806b3          	add	a3,a6,a4
    80004c6c:	0055c703          	lbu	a4,5(a1)
    80004c70:	00178793          	addi	a5,a5,1
    80004c74:	02077713          	andi	a4,a4,32
    80004c78:	fc071ae3          	bnez	a4,80004c4c <uartstart+0x38>
    80004c7c:	00813403          	ld	s0,8(sp)
    80004c80:	01010113          	addi	sp,sp,16
    80004c84:	00008067          	ret

0000000080004c88 <uartgetc>:
    80004c88:	ff010113          	addi	sp,sp,-16
    80004c8c:	00813423          	sd	s0,8(sp)
    80004c90:	01010413          	addi	s0,sp,16
    80004c94:	10000737          	lui	a4,0x10000
    80004c98:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80004c9c:	0017f793          	andi	a5,a5,1
    80004ca0:	00078c63          	beqz	a5,80004cb8 <uartgetc+0x30>
    80004ca4:	00074503          	lbu	a0,0(a4)
    80004ca8:	0ff57513          	andi	a0,a0,255
    80004cac:	00813403          	ld	s0,8(sp)
    80004cb0:	01010113          	addi	sp,sp,16
    80004cb4:	00008067          	ret
    80004cb8:	fff00513          	li	a0,-1
    80004cbc:	ff1ff06f          	j	80004cac <uartgetc+0x24>

0000000080004cc0 <uartintr>:
    80004cc0:	100007b7          	lui	a5,0x10000
    80004cc4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004cc8:	0017f793          	andi	a5,a5,1
    80004ccc:	0a078463          	beqz	a5,80004d74 <uartintr+0xb4>
    80004cd0:	fe010113          	addi	sp,sp,-32
    80004cd4:	00813823          	sd	s0,16(sp)
    80004cd8:	00913423          	sd	s1,8(sp)
    80004cdc:	00113c23          	sd	ra,24(sp)
    80004ce0:	02010413          	addi	s0,sp,32
    80004ce4:	100004b7          	lui	s1,0x10000
    80004ce8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80004cec:	0ff57513          	andi	a0,a0,255
    80004cf0:	fffff097          	auipc	ra,0xfffff
    80004cf4:	534080e7          	jalr	1332(ra) # 80004224 <consoleintr>
    80004cf8:	0054c783          	lbu	a5,5(s1)
    80004cfc:	0017f793          	andi	a5,a5,1
    80004d00:	fe0794e3          	bnez	a5,80004ce8 <uartintr+0x28>
    80004d04:	00003617          	auipc	a2,0x3
    80004d08:	82c60613          	addi	a2,a2,-2004 # 80007530 <uart_tx_r>
    80004d0c:	00003517          	auipc	a0,0x3
    80004d10:	82c50513          	addi	a0,a0,-2004 # 80007538 <uart_tx_w>
    80004d14:	00063783          	ld	a5,0(a2)
    80004d18:	00053703          	ld	a4,0(a0)
    80004d1c:	04f70263          	beq	a4,a5,80004d60 <uartintr+0xa0>
    80004d20:	100005b7          	lui	a1,0x10000
    80004d24:	00004817          	auipc	a6,0x4
    80004d28:	afc80813          	addi	a6,a6,-1284 # 80008820 <uart_tx_buf>
    80004d2c:	01c0006f          	j	80004d48 <uartintr+0x88>
    80004d30:	0006c703          	lbu	a4,0(a3)
    80004d34:	00f63023          	sd	a5,0(a2)
    80004d38:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004d3c:	00063783          	ld	a5,0(a2)
    80004d40:	00053703          	ld	a4,0(a0)
    80004d44:	00f70e63          	beq	a4,a5,80004d60 <uartintr+0xa0>
    80004d48:	01f7f713          	andi	a4,a5,31
    80004d4c:	00e806b3          	add	a3,a6,a4
    80004d50:	0055c703          	lbu	a4,5(a1)
    80004d54:	00178793          	addi	a5,a5,1
    80004d58:	02077713          	andi	a4,a4,32
    80004d5c:	fc071ae3          	bnez	a4,80004d30 <uartintr+0x70>
    80004d60:	01813083          	ld	ra,24(sp)
    80004d64:	01013403          	ld	s0,16(sp)
    80004d68:	00813483          	ld	s1,8(sp)
    80004d6c:	02010113          	addi	sp,sp,32
    80004d70:	00008067          	ret
    80004d74:	00002617          	auipc	a2,0x2
    80004d78:	7bc60613          	addi	a2,a2,1980 # 80007530 <uart_tx_r>
    80004d7c:	00002517          	auipc	a0,0x2
    80004d80:	7bc50513          	addi	a0,a0,1980 # 80007538 <uart_tx_w>
    80004d84:	00063783          	ld	a5,0(a2)
    80004d88:	00053703          	ld	a4,0(a0)
    80004d8c:	04f70263          	beq	a4,a5,80004dd0 <uartintr+0x110>
    80004d90:	100005b7          	lui	a1,0x10000
    80004d94:	00004817          	auipc	a6,0x4
    80004d98:	a8c80813          	addi	a6,a6,-1396 # 80008820 <uart_tx_buf>
    80004d9c:	01c0006f          	j	80004db8 <uartintr+0xf8>
    80004da0:	0006c703          	lbu	a4,0(a3)
    80004da4:	00f63023          	sd	a5,0(a2)
    80004da8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004dac:	00063783          	ld	a5,0(a2)
    80004db0:	00053703          	ld	a4,0(a0)
    80004db4:	02f70063          	beq	a4,a5,80004dd4 <uartintr+0x114>
    80004db8:	01f7f713          	andi	a4,a5,31
    80004dbc:	00e806b3          	add	a3,a6,a4
    80004dc0:	0055c703          	lbu	a4,5(a1)
    80004dc4:	00178793          	addi	a5,a5,1
    80004dc8:	02077713          	andi	a4,a4,32
    80004dcc:	fc071ae3          	bnez	a4,80004da0 <uartintr+0xe0>
    80004dd0:	00008067          	ret
    80004dd4:	00008067          	ret

0000000080004dd8 <kinit>:
    80004dd8:	fc010113          	addi	sp,sp,-64
    80004ddc:	02913423          	sd	s1,40(sp)
    80004de0:	fffff7b7          	lui	a5,0xfffff
    80004de4:	00005497          	auipc	s1,0x5
    80004de8:	a5b48493          	addi	s1,s1,-1445 # 8000983f <end+0xfff>
    80004dec:	02813823          	sd	s0,48(sp)
    80004df0:	01313c23          	sd	s3,24(sp)
    80004df4:	00f4f4b3          	and	s1,s1,a5
    80004df8:	02113c23          	sd	ra,56(sp)
    80004dfc:	03213023          	sd	s2,32(sp)
    80004e00:	01413823          	sd	s4,16(sp)
    80004e04:	01513423          	sd	s5,8(sp)
    80004e08:	04010413          	addi	s0,sp,64
    80004e0c:	000017b7          	lui	a5,0x1
    80004e10:	01100993          	li	s3,17
    80004e14:	00f487b3          	add	a5,s1,a5
    80004e18:	01b99993          	slli	s3,s3,0x1b
    80004e1c:	06f9e063          	bltu	s3,a5,80004e7c <kinit+0xa4>
    80004e20:	00004a97          	auipc	s5,0x4
    80004e24:	a20a8a93          	addi	s5,s5,-1504 # 80008840 <end>
    80004e28:	0754ec63          	bltu	s1,s5,80004ea0 <kinit+0xc8>
    80004e2c:	0734fa63          	bgeu	s1,s3,80004ea0 <kinit+0xc8>
    80004e30:	00088a37          	lui	s4,0x88
    80004e34:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004e38:	00002917          	auipc	s2,0x2
    80004e3c:	70890913          	addi	s2,s2,1800 # 80007540 <kmem>
    80004e40:	00ca1a13          	slli	s4,s4,0xc
    80004e44:	0140006f          	j	80004e58 <kinit+0x80>
    80004e48:	000017b7          	lui	a5,0x1
    80004e4c:	00f484b3          	add	s1,s1,a5
    80004e50:	0554e863          	bltu	s1,s5,80004ea0 <kinit+0xc8>
    80004e54:	0534f663          	bgeu	s1,s3,80004ea0 <kinit+0xc8>
    80004e58:	00001637          	lui	a2,0x1
    80004e5c:	00100593          	li	a1,1
    80004e60:	00048513          	mv	a0,s1
    80004e64:	00000097          	auipc	ra,0x0
    80004e68:	5e4080e7          	jalr	1508(ra) # 80005448 <__memset>
    80004e6c:	00093783          	ld	a5,0(s2)
    80004e70:	00f4b023          	sd	a5,0(s1)
    80004e74:	00993023          	sd	s1,0(s2)
    80004e78:	fd4498e3          	bne	s1,s4,80004e48 <kinit+0x70>
    80004e7c:	03813083          	ld	ra,56(sp)
    80004e80:	03013403          	ld	s0,48(sp)
    80004e84:	02813483          	ld	s1,40(sp)
    80004e88:	02013903          	ld	s2,32(sp)
    80004e8c:	01813983          	ld	s3,24(sp)
    80004e90:	01013a03          	ld	s4,16(sp)
    80004e94:	00813a83          	ld	s5,8(sp)
    80004e98:	04010113          	addi	sp,sp,64
    80004e9c:	00008067          	ret
    80004ea0:	00001517          	auipc	a0,0x1
    80004ea4:	44050513          	addi	a0,a0,1088 # 800062e0 <digits+0x18>
    80004ea8:	fffff097          	auipc	ra,0xfffff
    80004eac:	4b4080e7          	jalr	1204(ra) # 8000435c <panic>

0000000080004eb0 <freerange>:
    80004eb0:	fc010113          	addi	sp,sp,-64
    80004eb4:	000017b7          	lui	a5,0x1
    80004eb8:	02913423          	sd	s1,40(sp)
    80004ebc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004ec0:	009504b3          	add	s1,a0,s1
    80004ec4:	fffff537          	lui	a0,0xfffff
    80004ec8:	02813823          	sd	s0,48(sp)
    80004ecc:	02113c23          	sd	ra,56(sp)
    80004ed0:	03213023          	sd	s2,32(sp)
    80004ed4:	01313c23          	sd	s3,24(sp)
    80004ed8:	01413823          	sd	s4,16(sp)
    80004edc:	01513423          	sd	s5,8(sp)
    80004ee0:	01613023          	sd	s6,0(sp)
    80004ee4:	04010413          	addi	s0,sp,64
    80004ee8:	00a4f4b3          	and	s1,s1,a0
    80004eec:	00f487b3          	add	a5,s1,a5
    80004ef0:	06f5e463          	bltu	a1,a5,80004f58 <freerange+0xa8>
    80004ef4:	00004a97          	auipc	s5,0x4
    80004ef8:	94ca8a93          	addi	s5,s5,-1716 # 80008840 <end>
    80004efc:	0954e263          	bltu	s1,s5,80004f80 <freerange+0xd0>
    80004f00:	01100993          	li	s3,17
    80004f04:	01b99993          	slli	s3,s3,0x1b
    80004f08:	0734fc63          	bgeu	s1,s3,80004f80 <freerange+0xd0>
    80004f0c:	00058a13          	mv	s4,a1
    80004f10:	00002917          	auipc	s2,0x2
    80004f14:	63090913          	addi	s2,s2,1584 # 80007540 <kmem>
    80004f18:	00002b37          	lui	s6,0x2
    80004f1c:	0140006f          	j	80004f30 <freerange+0x80>
    80004f20:	000017b7          	lui	a5,0x1
    80004f24:	00f484b3          	add	s1,s1,a5
    80004f28:	0554ec63          	bltu	s1,s5,80004f80 <freerange+0xd0>
    80004f2c:	0534fa63          	bgeu	s1,s3,80004f80 <freerange+0xd0>
    80004f30:	00001637          	lui	a2,0x1
    80004f34:	00100593          	li	a1,1
    80004f38:	00048513          	mv	a0,s1
    80004f3c:	00000097          	auipc	ra,0x0
    80004f40:	50c080e7          	jalr	1292(ra) # 80005448 <__memset>
    80004f44:	00093703          	ld	a4,0(s2)
    80004f48:	016487b3          	add	a5,s1,s6
    80004f4c:	00e4b023          	sd	a4,0(s1)
    80004f50:	00993023          	sd	s1,0(s2)
    80004f54:	fcfa76e3          	bgeu	s4,a5,80004f20 <freerange+0x70>
    80004f58:	03813083          	ld	ra,56(sp)
    80004f5c:	03013403          	ld	s0,48(sp)
    80004f60:	02813483          	ld	s1,40(sp)
    80004f64:	02013903          	ld	s2,32(sp)
    80004f68:	01813983          	ld	s3,24(sp)
    80004f6c:	01013a03          	ld	s4,16(sp)
    80004f70:	00813a83          	ld	s5,8(sp)
    80004f74:	00013b03          	ld	s6,0(sp)
    80004f78:	04010113          	addi	sp,sp,64
    80004f7c:	00008067          	ret
    80004f80:	00001517          	auipc	a0,0x1
    80004f84:	36050513          	addi	a0,a0,864 # 800062e0 <digits+0x18>
    80004f88:	fffff097          	auipc	ra,0xfffff
    80004f8c:	3d4080e7          	jalr	980(ra) # 8000435c <panic>

0000000080004f90 <kfree>:
    80004f90:	fe010113          	addi	sp,sp,-32
    80004f94:	00813823          	sd	s0,16(sp)
    80004f98:	00113c23          	sd	ra,24(sp)
    80004f9c:	00913423          	sd	s1,8(sp)
    80004fa0:	02010413          	addi	s0,sp,32
    80004fa4:	03451793          	slli	a5,a0,0x34
    80004fa8:	04079c63          	bnez	a5,80005000 <kfree+0x70>
    80004fac:	00004797          	auipc	a5,0x4
    80004fb0:	89478793          	addi	a5,a5,-1900 # 80008840 <end>
    80004fb4:	00050493          	mv	s1,a0
    80004fb8:	04f56463          	bltu	a0,a5,80005000 <kfree+0x70>
    80004fbc:	01100793          	li	a5,17
    80004fc0:	01b79793          	slli	a5,a5,0x1b
    80004fc4:	02f57e63          	bgeu	a0,a5,80005000 <kfree+0x70>
    80004fc8:	00001637          	lui	a2,0x1
    80004fcc:	00100593          	li	a1,1
    80004fd0:	00000097          	auipc	ra,0x0
    80004fd4:	478080e7          	jalr	1144(ra) # 80005448 <__memset>
    80004fd8:	00002797          	auipc	a5,0x2
    80004fdc:	56878793          	addi	a5,a5,1384 # 80007540 <kmem>
    80004fe0:	0007b703          	ld	a4,0(a5)
    80004fe4:	01813083          	ld	ra,24(sp)
    80004fe8:	01013403          	ld	s0,16(sp)
    80004fec:	00e4b023          	sd	a4,0(s1)
    80004ff0:	0097b023          	sd	s1,0(a5)
    80004ff4:	00813483          	ld	s1,8(sp)
    80004ff8:	02010113          	addi	sp,sp,32
    80004ffc:	00008067          	ret
    80005000:	00001517          	auipc	a0,0x1
    80005004:	2e050513          	addi	a0,a0,736 # 800062e0 <digits+0x18>
    80005008:	fffff097          	auipc	ra,0xfffff
    8000500c:	354080e7          	jalr	852(ra) # 8000435c <panic>

0000000080005010 <kalloc>:
    80005010:	fe010113          	addi	sp,sp,-32
    80005014:	00813823          	sd	s0,16(sp)
    80005018:	00913423          	sd	s1,8(sp)
    8000501c:	00113c23          	sd	ra,24(sp)
    80005020:	02010413          	addi	s0,sp,32
    80005024:	00002797          	auipc	a5,0x2
    80005028:	51c78793          	addi	a5,a5,1308 # 80007540 <kmem>
    8000502c:	0007b483          	ld	s1,0(a5)
    80005030:	02048063          	beqz	s1,80005050 <kalloc+0x40>
    80005034:	0004b703          	ld	a4,0(s1)
    80005038:	00001637          	lui	a2,0x1
    8000503c:	00500593          	li	a1,5
    80005040:	00048513          	mv	a0,s1
    80005044:	00e7b023          	sd	a4,0(a5)
    80005048:	00000097          	auipc	ra,0x0
    8000504c:	400080e7          	jalr	1024(ra) # 80005448 <__memset>
    80005050:	01813083          	ld	ra,24(sp)
    80005054:	01013403          	ld	s0,16(sp)
    80005058:	00048513          	mv	a0,s1
    8000505c:	00813483          	ld	s1,8(sp)
    80005060:	02010113          	addi	sp,sp,32
    80005064:	00008067          	ret

0000000080005068 <initlock>:
    80005068:	ff010113          	addi	sp,sp,-16
    8000506c:	00813423          	sd	s0,8(sp)
    80005070:	01010413          	addi	s0,sp,16
    80005074:	00813403          	ld	s0,8(sp)
    80005078:	00b53423          	sd	a1,8(a0)
    8000507c:	00052023          	sw	zero,0(a0)
    80005080:	00053823          	sd	zero,16(a0)
    80005084:	01010113          	addi	sp,sp,16
    80005088:	00008067          	ret

000000008000508c <acquire>:
    8000508c:	fe010113          	addi	sp,sp,-32
    80005090:	00813823          	sd	s0,16(sp)
    80005094:	00913423          	sd	s1,8(sp)
    80005098:	00113c23          	sd	ra,24(sp)
    8000509c:	01213023          	sd	s2,0(sp)
    800050a0:	02010413          	addi	s0,sp,32
    800050a4:	00050493          	mv	s1,a0
    800050a8:	10002973          	csrr	s2,sstatus
    800050ac:	100027f3          	csrr	a5,sstatus
    800050b0:	ffd7f793          	andi	a5,a5,-3
    800050b4:	10079073          	csrw	sstatus,a5
    800050b8:	fffff097          	auipc	ra,0xfffff
    800050bc:	8e8080e7          	jalr	-1816(ra) # 800039a0 <mycpu>
    800050c0:	07852783          	lw	a5,120(a0)
    800050c4:	06078e63          	beqz	a5,80005140 <acquire+0xb4>
    800050c8:	fffff097          	auipc	ra,0xfffff
    800050cc:	8d8080e7          	jalr	-1832(ra) # 800039a0 <mycpu>
    800050d0:	07852783          	lw	a5,120(a0)
    800050d4:	0004a703          	lw	a4,0(s1)
    800050d8:	0017879b          	addiw	a5,a5,1
    800050dc:	06f52c23          	sw	a5,120(a0)
    800050e0:	04071063          	bnez	a4,80005120 <acquire+0x94>
    800050e4:	00100713          	li	a4,1
    800050e8:	00070793          	mv	a5,a4
    800050ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800050f0:	0007879b          	sext.w	a5,a5
    800050f4:	fe079ae3          	bnez	a5,800050e8 <acquire+0x5c>
    800050f8:	0ff0000f          	fence
    800050fc:	fffff097          	auipc	ra,0xfffff
    80005100:	8a4080e7          	jalr	-1884(ra) # 800039a0 <mycpu>
    80005104:	01813083          	ld	ra,24(sp)
    80005108:	01013403          	ld	s0,16(sp)
    8000510c:	00a4b823          	sd	a0,16(s1)
    80005110:	00013903          	ld	s2,0(sp)
    80005114:	00813483          	ld	s1,8(sp)
    80005118:	02010113          	addi	sp,sp,32
    8000511c:	00008067          	ret
    80005120:	0104b903          	ld	s2,16(s1)
    80005124:	fffff097          	auipc	ra,0xfffff
    80005128:	87c080e7          	jalr	-1924(ra) # 800039a0 <mycpu>
    8000512c:	faa91ce3          	bne	s2,a0,800050e4 <acquire+0x58>
    80005130:	00001517          	auipc	a0,0x1
    80005134:	1b850513          	addi	a0,a0,440 # 800062e8 <digits+0x20>
    80005138:	fffff097          	auipc	ra,0xfffff
    8000513c:	224080e7          	jalr	548(ra) # 8000435c <panic>
    80005140:	00195913          	srli	s2,s2,0x1
    80005144:	fffff097          	auipc	ra,0xfffff
    80005148:	85c080e7          	jalr	-1956(ra) # 800039a0 <mycpu>
    8000514c:	00197913          	andi	s2,s2,1
    80005150:	07252e23          	sw	s2,124(a0)
    80005154:	f75ff06f          	j	800050c8 <acquire+0x3c>

0000000080005158 <release>:
    80005158:	fe010113          	addi	sp,sp,-32
    8000515c:	00813823          	sd	s0,16(sp)
    80005160:	00113c23          	sd	ra,24(sp)
    80005164:	00913423          	sd	s1,8(sp)
    80005168:	01213023          	sd	s2,0(sp)
    8000516c:	02010413          	addi	s0,sp,32
    80005170:	00052783          	lw	a5,0(a0)
    80005174:	00079a63          	bnez	a5,80005188 <release+0x30>
    80005178:	00001517          	auipc	a0,0x1
    8000517c:	17850513          	addi	a0,a0,376 # 800062f0 <digits+0x28>
    80005180:	fffff097          	auipc	ra,0xfffff
    80005184:	1dc080e7          	jalr	476(ra) # 8000435c <panic>
    80005188:	01053903          	ld	s2,16(a0)
    8000518c:	00050493          	mv	s1,a0
    80005190:	fffff097          	auipc	ra,0xfffff
    80005194:	810080e7          	jalr	-2032(ra) # 800039a0 <mycpu>
    80005198:	fea910e3          	bne	s2,a0,80005178 <release+0x20>
    8000519c:	0004b823          	sd	zero,16(s1)
    800051a0:	0ff0000f          	fence
    800051a4:	0f50000f          	fence	iorw,ow
    800051a8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800051ac:	ffffe097          	auipc	ra,0xffffe
    800051b0:	7f4080e7          	jalr	2036(ra) # 800039a0 <mycpu>
    800051b4:	100027f3          	csrr	a5,sstatus
    800051b8:	0027f793          	andi	a5,a5,2
    800051bc:	04079a63          	bnez	a5,80005210 <release+0xb8>
    800051c0:	07852783          	lw	a5,120(a0)
    800051c4:	02f05e63          	blez	a5,80005200 <release+0xa8>
    800051c8:	fff7871b          	addiw	a4,a5,-1
    800051cc:	06e52c23          	sw	a4,120(a0)
    800051d0:	00071c63          	bnez	a4,800051e8 <release+0x90>
    800051d4:	07c52783          	lw	a5,124(a0)
    800051d8:	00078863          	beqz	a5,800051e8 <release+0x90>
    800051dc:	100027f3          	csrr	a5,sstatus
    800051e0:	0027e793          	ori	a5,a5,2
    800051e4:	10079073          	csrw	sstatus,a5
    800051e8:	01813083          	ld	ra,24(sp)
    800051ec:	01013403          	ld	s0,16(sp)
    800051f0:	00813483          	ld	s1,8(sp)
    800051f4:	00013903          	ld	s2,0(sp)
    800051f8:	02010113          	addi	sp,sp,32
    800051fc:	00008067          	ret
    80005200:	00001517          	auipc	a0,0x1
    80005204:	11050513          	addi	a0,a0,272 # 80006310 <digits+0x48>
    80005208:	fffff097          	auipc	ra,0xfffff
    8000520c:	154080e7          	jalr	340(ra) # 8000435c <panic>
    80005210:	00001517          	auipc	a0,0x1
    80005214:	0e850513          	addi	a0,a0,232 # 800062f8 <digits+0x30>
    80005218:	fffff097          	auipc	ra,0xfffff
    8000521c:	144080e7          	jalr	324(ra) # 8000435c <panic>

0000000080005220 <holding>:
    80005220:	00052783          	lw	a5,0(a0)
    80005224:	00079663          	bnez	a5,80005230 <holding+0x10>
    80005228:	00000513          	li	a0,0
    8000522c:	00008067          	ret
    80005230:	fe010113          	addi	sp,sp,-32
    80005234:	00813823          	sd	s0,16(sp)
    80005238:	00913423          	sd	s1,8(sp)
    8000523c:	00113c23          	sd	ra,24(sp)
    80005240:	02010413          	addi	s0,sp,32
    80005244:	01053483          	ld	s1,16(a0)
    80005248:	ffffe097          	auipc	ra,0xffffe
    8000524c:	758080e7          	jalr	1880(ra) # 800039a0 <mycpu>
    80005250:	01813083          	ld	ra,24(sp)
    80005254:	01013403          	ld	s0,16(sp)
    80005258:	40a48533          	sub	a0,s1,a0
    8000525c:	00153513          	seqz	a0,a0
    80005260:	00813483          	ld	s1,8(sp)
    80005264:	02010113          	addi	sp,sp,32
    80005268:	00008067          	ret

000000008000526c <push_off>:
    8000526c:	fe010113          	addi	sp,sp,-32
    80005270:	00813823          	sd	s0,16(sp)
    80005274:	00113c23          	sd	ra,24(sp)
    80005278:	00913423          	sd	s1,8(sp)
    8000527c:	02010413          	addi	s0,sp,32
    80005280:	100024f3          	csrr	s1,sstatus
    80005284:	100027f3          	csrr	a5,sstatus
    80005288:	ffd7f793          	andi	a5,a5,-3
    8000528c:	10079073          	csrw	sstatus,a5
    80005290:	ffffe097          	auipc	ra,0xffffe
    80005294:	710080e7          	jalr	1808(ra) # 800039a0 <mycpu>
    80005298:	07852783          	lw	a5,120(a0)
    8000529c:	02078663          	beqz	a5,800052c8 <push_off+0x5c>
    800052a0:	ffffe097          	auipc	ra,0xffffe
    800052a4:	700080e7          	jalr	1792(ra) # 800039a0 <mycpu>
    800052a8:	07852783          	lw	a5,120(a0)
    800052ac:	01813083          	ld	ra,24(sp)
    800052b0:	01013403          	ld	s0,16(sp)
    800052b4:	0017879b          	addiw	a5,a5,1
    800052b8:	06f52c23          	sw	a5,120(a0)
    800052bc:	00813483          	ld	s1,8(sp)
    800052c0:	02010113          	addi	sp,sp,32
    800052c4:	00008067          	ret
    800052c8:	0014d493          	srli	s1,s1,0x1
    800052cc:	ffffe097          	auipc	ra,0xffffe
    800052d0:	6d4080e7          	jalr	1748(ra) # 800039a0 <mycpu>
    800052d4:	0014f493          	andi	s1,s1,1
    800052d8:	06952e23          	sw	s1,124(a0)
    800052dc:	fc5ff06f          	j	800052a0 <push_off+0x34>

00000000800052e0 <pop_off>:
    800052e0:	ff010113          	addi	sp,sp,-16
    800052e4:	00813023          	sd	s0,0(sp)
    800052e8:	00113423          	sd	ra,8(sp)
    800052ec:	01010413          	addi	s0,sp,16
    800052f0:	ffffe097          	auipc	ra,0xffffe
    800052f4:	6b0080e7          	jalr	1712(ra) # 800039a0 <mycpu>
    800052f8:	100027f3          	csrr	a5,sstatus
    800052fc:	0027f793          	andi	a5,a5,2
    80005300:	04079663          	bnez	a5,8000534c <pop_off+0x6c>
    80005304:	07852783          	lw	a5,120(a0)
    80005308:	02f05a63          	blez	a5,8000533c <pop_off+0x5c>
    8000530c:	fff7871b          	addiw	a4,a5,-1
    80005310:	06e52c23          	sw	a4,120(a0)
    80005314:	00071c63          	bnez	a4,8000532c <pop_off+0x4c>
    80005318:	07c52783          	lw	a5,124(a0)
    8000531c:	00078863          	beqz	a5,8000532c <pop_off+0x4c>
    80005320:	100027f3          	csrr	a5,sstatus
    80005324:	0027e793          	ori	a5,a5,2
    80005328:	10079073          	csrw	sstatus,a5
    8000532c:	00813083          	ld	ra,8(sp)
    80005330:	00013403          	ld	s0,0(sp)
    80005334:	01010113          	addi	sp,sp,16
    80005338:	00008067          	ret
    8000533c:	00001517          	auipc	a0,0x1
    80005340:	fd450513          	addi	a0,a0,-44 # 80006310 <digits+0x48>
    80005344:	fffff097          	auipc	ra,0xfffff
    80005348:	018080e7          	jalr	24(ra) # 8000435c <panic>
    8000534c:	00001517          	auipc	a0,0x1
    80005350:	fac50513          	addi	a0,a0,-84 # 800062f8 <digits+0x30>
    80005354:	fffff097          	auipc	ra,0xfffff
    80005358:	008080e7          	jalr	8(ra) # 8000435c <panic>

000000008000535c <push_on>:
    8000535c:	fe010113          	addi	sp,sp,-32
    80005360:	00813823          	sd	s0,16(sp)
    80005364:	00113c23          	sd	ra,24(sp)
    80005368:	00913423          	sd	s1,8(sp)
    8000536c:	02010413          	addi	s0,sp,32
    80005370:	100024f3          	csrr	s1,sstatus
    80005374:	100027f3          	csrr	a5,sstatus
    80005378:	0027e793          	ori	a5,a5,2
    8000537c:	10079073          	csrw	sstatus,a5
    80005380:	ffffe097          	auipc	ra,0xffffe
    80005384:	620080e7          	jalr	1568(ra) # 800039a0 <mycpu>
    80005388:	07852783          	lw	a5,120(a0)
    8000538c:	02078663          	beqz	a5,800053b8 <push_on+0x5c>
    80005390:	ffffe097          	auipc	ra,0xffffe
    80005394:	610080e7          	jalr	1552(ra) # 800039a0 <mycpu>
    80005398:	07852783          	lw	a5,120(a0)
    8000539c:	01813083          	ld	ra,24(sp)
    800053a0:	01013403          	ld	s0,16(sp)
    800053a4:	0017879b          	addiw	a5,a5,1
    800053a8:	06f52c23          	sw	a5,120(a0)
    800053ac:	00813483          	ld	s1,8(sp)
    800053b0:	02010113          	addi	sp,sp,32
    800053b4:	00008067          	ret
    800053b8:	0014d493          	srli	s1,s1,0x1
    800053bc:	ffffe097          	auipc	ra,0xffffe
    800053c0:	5e4080e7          	jalr	1508(ra) # 800039a0 <mycpu>
    800053c4:	0014f493          	andi	s1,s1,1
    800053c8:	06952e23          	sw	s1,124(a0)
    800053cc:	fc5ff06f          	j	80005390 <push_on+0x34>

00000000800053d0 <pop_on>:
    800053d0:	ff010113          	addi	sp,sp,-16
    800053d4:	00813023          	sd	s0,0(sp)
    800053d8:	00113423          	sd	ra,8(sp)
    800053dc:	01010413          	addi	s0,sp,16
    800053e0:	ffffe097          	auipc	ra,0xffffe
    800053e4:	5c0080e7          	jalr	1472(ra) # 800039a0 <mycpu>
    800053e8:	100027f3          	csrr	a5,sstatus
    800053ec:	0027f793          	andi	a5,a5,2
    800053f0:	04078463          	beqz	a5,80005438 <pop_on+0x68>
    800053f4:	07852783          	lw	a5,120(a0)
    800053f8:	02f05863          	blez	a5,80005428 <pop_on+0x58>
    800053fc:	fff7879b          	addiw	a5,a5,-1
    80005400:	06f52c23          	sw	a5,120(a0)
    80005404:	07853783          	ld	a5,120(a0)
    80005408:	00079863          	bnez	a5,80005418 <pop_on+0x48>
    8000540c:	100027f3          	csrr	a5,sstatus
    80005410:	ffd7f793          	andi	a5,a5,-3
    80005414:	10079073          	csrw	sstatus,a5
    80005418:	00813083          	ld	ra,8(sp)
    8000541c:	00013403          	ld	s0,0(sp)
    80005420:	01010113          	addi	sp,sp,16
    80005424:	00008067          	ret
    80005428:	00001517          	auipc	a0,0x1
    8000542c:	f1050513          	addi	a0,a0,-240 # 80006338 <digits+0x70>
    80005430:	fffff097          	auipc	ra,0xfffff
    80005434:	f2c080e7          	jalr	-212(ra) # 8000435c <panic>
    80005438:	00001517          	auipc	a0,0x1
    8000543c:	ee050513          	addi	a0,a0,-288 # 80006318 <digits+0x50>
    80005440:	fffff097          	auipc	ra,0xfffff
    80005444:	f1c080e7          	jalr	-228(ra) # 8000435c <panic>

0000000080005448 <__memset>:
    80005448:	ff010113          	addi	sp,sp,-16
    8000544c:	00813423          	sd	s0,8(sp)
    80005450:	01010413          	addi	s0,sp,16
    80005454:	1a060e63          	beqz	a2,80005610 <__memset+0x1c8>
    80005458:	40a007b3          	neg	a5,a0
    8000545c:	0077f793          	andi	a5,a5,7
    80005460:	00778693          	addi	a3,a5,7
    80005464:	00b00813          	li	a6,11
    80005468:	0ff5f593          	andi	a1,a1,255
    8000546c:	fff6071b          	addiw	a4,a2,-1
    80005470:	1b06e663          	bltu	a3,a6,8000561c <__memset+0x1d4>
    80005474:	1cd76463          	bltu	a4,a3,8000563c <__memset+0x1f4>
    80005478:	1a078e63          	beqz	a5,80005634 <__memset+0x1ec>
    8000547c:	00b50023          	sb	a1,0(a0)
    80005480:	00100713          	li	a4,1
    80005484:	1ae78463          	beq	a5,a4,8000562c <__memset+0x1e4>
    80005488:	00b500a3          	sb	a1,1(a0)
    8000548c:	00200713          	li	a4,2
    80005490:	1ae78a63          	beq	a5,a4,80005644 <__memset+0x1fc>
    80005494:	00b50123          	sb	a1,2(a0)
    80005498:	00300713          	li	a4,3
    8000549c:	18e78463          	beq	a5,a4,80005624 <__memset+0x1dc>
    800054a0:	00b501a3          	sb	a1,3(a0)
    800054a4:	00400713          	li	a4,4
    800054a8:	1ae78263          	beq	a5,a4,8000564c <__memset+0x204>
    800054ac:	00b50223          	sb	a1,4(a0)
    800054b0:	00500713          	li	a4,5
    800054b4:	1ae78063          	beq	a5,a4,80005654 <__memset+0x20c>
    800054b8:	00b502a3          	sb	a1,5(a0)
    800054bc:	00700713          	li	a4,7
    800054c0:	18e79e63          	bne	a5,a4,8000565c <__memset+0x214>
    800054c4:	00b50323          	sb	a1,6(a0)
    800054c8:	00700e93          	li	t4,7
    800054cc:	00859713          	slli	a4,a1,0x8
    800054d0:	00e5e733          	or	a4,a1,a4
    800054d4:	01059e13          	slli	t3,a1,0x10
    800054d8:	01c76e33          	or	t3,a4,t3
    800054dc:	01859313          	slli	t1,a1,0x18
    800054e0:	006e6333          	or	t1,t3,t1
    800054e4:	02059893          	slli	a7,a1,0x20
    800054e8:	40f60e3b          	subw	t3,a2,a5
    800054ec:	011368b3          	or	a7,t1,a7
    800054f0:	02859813          	slli	a6,a1,0x28
    800054f4:	0108e833          	or	a6,a7,a6
    800054f8:	03059693          	slli	a3,a1,0x30
    800054fc:	003e589b          	srliw	a7,t3,0x3
    80005500:	00d866b3          	or	a3,a6,a3
    80005504:	03859713          	slli	a4,a1,0x38
    80005508:	00389813          	slli	a6,a7,0x3
    8000550c:	00f507b3          	add	a5,a0,a5
    80005510:	00e6e733          	or	a4,a3,a4
    80005514:	000e089b          	sext.w	a7,t3
    80005518:	00f806b3          	add	a3,a6,a5
    8000551c:	00e7b023          	sd	a4,0(a5)
    80005520:	00878793          	addi	a5,a5,8
    80005524:	fed79ce3          	bne	a5,a3,8000551c <__memset+0xd4>
    80005528:	ff8e7793          	andi	a5,t3,-8
    8000552c:	0007871b          	sext.w	a4,a5
    80005530:	01d787bb          	addw	a5,a5,t4
    80005534:	0ce88e63          	beq	a7,a4,80005610 <__memset+0x1c8>
    80005538:	00f50733          	add	a4,a0,a5
    8000553c:	00b70023          	sb	a1,0(a4)
    80005540:	0017871b          	addiw	a4,a5,1
    80005544:	0cc77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005548:	00e50733          	add	a4,a0,a4
    8000554c:	00b70023          	sb	a1,0(a4)
    80005550:	0027871b          	addiw	a4,a5,2
    80005554:	0ac77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005558:	00e50733          	add	a4,a0,a4
    8000555c:	00b70023          	sb	a1,0(a4)
    80005560:	0037871b          	addiw	a4,a5,3
    80005564:	0ac77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005568:	00e50733          	add	a4,a0,a4
    8000556c:	00b70023          	sb	a1,0(a4)
    80005570:	0047871b          	addiw	a4,a5,4
    80005574:	08c77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005578:	00e50733          	add	a4,a0,a4
    8000557c:	00b70023          	sb	a1,0(a4)
    80005580:	0057871b          	addiw	a4,a5,5
    80005584:	08c77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005588:	00e50733          	add	a4,a0,a4
    8000558c:	00b70023          	sb	a1,0(a4)
    80005590:	0067871b          	addiw	a4,a5,6
    80005594:	06c77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    80005598:	00e50733          	add	a4,a0,a4
    8000559c:	00b70023          	sb	a1,0(a4)
    800055a0:	0077871b          	addiw	a4,a5,7
    800055a4:	06c77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055a8:	00e50733          	add	a4,a0,a4
    800055ac:	00b70023          	sb	a1,0(a4)
    800055b0:	0087871b          	addiw	a4,a5,8
    800055b4:	04c77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055b8:	00e50733          	add	a4,a0,a4
    800055bc:	00b70023          	sb	a1,0(a4)
    800055c0:	0097871b          	addiw	a4,a5,9
    800055c4:	04c77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055c8:	00e50733          	add	a4,a0,a4
    800055cc:	00b70023          	sb	a1,0(a4)
    800055d0:	00a7871b          	addiw	a4,a5,10
    800055d4:	02c77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055d8:	00e50733          	add	a4,a0,a4
    800055dc:	00b70023          	sb	a1,0(a4)
    800055e0:	00b7871b          	addiw	a4,a5,11
    800055e4:	02c77663          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055e8:	00e50733          	add	a4,a0,a4
    800055ec:	00b70023          	sb	a1,0(a4)
    800055f0:	00c7871b          	addiw	a4,a5,12
    800055f4:	00c77e63          	bgeu	a4,a2,80005610 <__memset+0x1c8>
    800055f8:	00e50733          	add	a4,a0,a4
    800055fc:	00b70023          	sb	a1,0(a4)
    80005600:	00d7879b          	addiw	a5,a5,13
    80005604:	00c7f663          	bgeu	a5,a2,80005610 <__memset+0x1c8>
    80005608:	00f507b3          	add	a5,a0,a5
    8000560c:	00b78023          	sb	a1,0(a5)
    80005610:	00813403          	ld	s0,8(sp)
    80005614:	01010113          	addi	sp,sp,16
    80005618:	00008067          	ret
    8000561c:	00b00693          	li	a3,11
    80005620:	e55ff06f          	j	80005474 <__memset+0x2c>
    80005624:	00300e93          	li	t4,3
    80005628:	ea5ff06f          	j	800054cc <__memset+0x84>
    8000562c:	00100e93          	li	t4,1
    80005630:	e9dff06f          	j	800054cc <__memset+0x84>
    80005634:	00000e93          	li	t4,0
    80005638:	e95ff06f          	j	800054cc <__memset+0x84>
    8000563c:	00000793          	li	a5,0
    80005640:	ef9ff06f          	j	80005538 <__memset+0xf0>
    80005644:	00200e93          	li	t4,2
    80005648:	e85ff06f          	j	800054cc <__memset+0x84>
    8000564c:	00400e93          	li	t4,4
    80005650:	e7dff06f          	j	800054cc <__memset+0x84>
    80005654:	00500e93          	li	t4,5
    80005658:	e75ff06f          	j	800054cc <__memset+0x84>
    8000565c:	00600e93          	li	t4,6
    80005660:	e6dff06f          	j	800054cc <__memset+0x84>

0000000080005664 <__memmove>:
    80005664:	ff010113          	addi	sp,sp,-16
    80005668:	00813423          	sd	s0,8(sp)
    8000566c:	01010413          	addi	s0,sp,16
    80005670:	0e060863          	beqz	a2,80005760 <__memmove+0xfc>
    80005674:	fff6069b          	addiw	a3,a2,-1
    80005678:	0006881b          	sext.w	a6,a3
    8000567c:	0ea5e863          	bltu	a1,a0,8000576c <__memmove+0x108>
    80005680:	00758713          	addi	a4,a1,7
    80005684:	00a5e7b3          	or	a5,a1,a0
    80005688:	40a70733          	sub	a4,a4,a0
    8000568c:	0077f793          	andi	a5,a5,7
    80005690:	00f73713          	sltiu	a4,a4,15
    80005694:	00174713          	xori	a4,a4,1
    80005698:	0017b793          	seqz	a5,a5
    8000569c:	00e7f7b3          	and	a5,a5,a4
    800056a0:	10078863          	beqz	a5,800057b0 <__memmove+0x14c>
    800056a4:	00900793          	li	a5,9
    800056a8:	1107f463          	bgeu	a5,a6,800057b0 <__memmove+0x14c>
    800056ac:	0036581b          	srliw	a6,a2,0x3
    800056b0:	fff8081b          	addiw	a6,a6,-1
    800056b4:	02081813          	slli	a6,a6,0x20
    800056b8:	01d85893          	srli	a7,a6,0x1d
    800056bc:	00858813          	addi	a6,a1,8
    800056c0:	00058793          	mv	a5,a1
    800056c4:	00050713          	mv	a4,a0
    800056c8:	01088833          	add	a6,a7,a6
    800056cc:	0007b883          	ld	a7,0(a5)
    800056d0:	00878793          	addi	a5,a5,8
    800056d4:	00870713          	addi	a4,a4,8
    800056d8:	ff173c23          	sd	a7,-8(a4)
    800056dc:	ff0798e3          	bne	a5,a6,800056cc <__memmove+0x68>
    800056e0:	ff867713          	andi	a4,a2,-8
    800056e4:	02071793          	slli	a5,a4,0x20
    800056e8:	0207d793          	srli	a5,a5,0x20
    800056ec:	00f585b3          	add	a1,a1,a5
    800056f0:	40e686bb          	subw	a3,a3,a4
    800056f4:	00f507b3          	add	a5,a0,a5
    800056f8:	06e60463          	beq	a2,a4,80005760 <__memmove+0xfc>
    800056fc:	0005c703          	lbu	a4,0(a1)
    80005700:	00e78023          	sb	a4,0(a5)
    80005704:	04068e63          	beqz	a3,80005760 <__memmove+0xfc>
    80005708:	0015c603          	lbu	a2,1(a1)
    8000570c:	00100713          	li	a4,1
    80005710:	00c780a3          	sb	a2,1(a5)
    80005714:	04e68663          	beq	a3,a4,80005760 <__memmove+0xfc>
    80005718:	0025c603          	lbu	a2,2(a1)
    8000571c:	00200713          	li	a4,2
    80005720:	00c78123          	sb	a2,2(a5)
    80005724:	02e68e63          	beq	a3,a4,80005760 <__memmove+0xfc>
    80005728:	0035c603          	lbu	a2,3(a1)
    8000572c:	00300713          	li	a4,3
    80005730:	00c781a3          	sb	a2,3(a5)
    80005734:	02e68663          	beq	a3,a4,80005760 <__memmove+0xfc>
    80005738:	0045c603          	lbu	a2,4(a1)
    8000573c:	00400713          	li	a4,4
    80005740:	00c78223          	sb	a2,4(a5)
    80005744:	00e68e63          	beq	a3,a4,80005760 <__memmove+0xfc>
    80005748:	0055c603          	lbu	a2,5(a1)
    8000574c:	00500713          	li	a4,5
    80005750:	00c782a3          	sb	a2,5(a5)
    80005754:	00e68663          	beq	a3,a4,80005760 <__memmove+0xfc>
    80005758:	0065c703          	lbu	a4,6(a1)
    8000575c:	00e78323          	sb	a4,6(a5)
    80005760:	00813403          	ld	s0,8(sp)
    80005764:	01010113          	addi	sp,sp,16
    80005768:	00008067          	ret
    8000576c:	02061713          	slli	a4,a2,0x20
    80005770:	02075713          	srli	a4,a4,0x20
    80005774:	00e587b3          	add	a5,a1,a4
    80005778:	f0f574e3          	bgeu	a0,a5,80005680 <__memmove+0x1c>
    8000577c:	02069613          	slli	a2,a3,0x20
    80005780:	02065613          	srli	a2,a2,0x20
    80005784:	fff64613          	not	a2,a2
    80005788:	00e50733          	add	a4,a0,a4
    8000578c:	00c78633          	add	a2,a5,a2
    80005790:	fff7c683          	lbu	a3,-1(a5)
    80005794:	fff78793          	addi	a5,a5,-1
    80005798:	fff70713          	addi	a4,a4,-1
    8000579c:	00d70023          	sb	a3,0(a4)
    800057a0:	fec798e3          	bne	a5,a2,80005790 <__memmove+0x12c>
    800057a4:	00813403          	ld	s0,8(sp)
    800057a8:	01010113          	addi	sp,sp,16
    800057ac:	00008067          	ret
    800057b0:	02069713          	slli	a4,a3,0x20
    800057b4:	02075713          	srli	a4,a4,0x20
    800057b8:	00170713          	addi	a4,a4,1
    800057bc:	00e50733          	add	a4,a0,a4
    800057c0:	00050793          	mv	a5,a0
    800057c4:	0005c683          	lbu	a3,0(a1)
    800057c8:	00178793          	addi	a5,a5,1
    800057cc:	00158593          	addi	a1,a1,1
    800057d0:	fed78fa3          	sb	a3,-1(a5)
    800057d4:	fee798e3          	bne	a5,a4,800057c4 <__memmove+0x160>
    800057d8:	f89ff06f          	j	80005760 <__memmove+0xfc>

00000000800057dc <__putc>:
    800057dc:	fe010113          	addi	sp,sp,-32
    800057e0:	00813823          	sd	s0,16(sp)
    800057e4:	00113c23          	sd	ra,24(sp)
    800057e8:	02010413          	addi	s0,sp,32
    800057ec:	00050793          	mv	a5,a0
    800057f0:	fef40593          	addi	a1,s0,-17
    800057f4:	00100613          	li	a2,1
    800057f8:	00000513          	li	a0,0
    800057fc:	fef407a3          	sb	a5,-17(s0)
    80005800:	fffff097          	auipc	ra,0xfffff
    80005804:	b3c080e7          	jalr	-1220(ra) # 8000433c <console_write>
    80005808:	01813083          	ld	ra,24(sp)
    8000580c:	01013403          	ld	s0,16(sp)
    80005810:	02010113          	addi	sp,sp,32
    80005814:	00008067          	ret

0000000080005818 <__getc>:
    80005818:	fe010113          	addi	sp,sp,-32
    8000581c:	00813823          	sd	s0,16(sp)
    80005820:	00113c23          	sd	ra,24(sp)
    80005824:	02010413          	addi	s0,sp,32
    80005828:	fe840593          	addi	a1,s0,-24
    8000582c:	00100613          	li	a2,1
    80005830:	00000513          	li	a0,0
    80005834:	fffff097          	auipc	ra,0xfffff
    80005838:	ae8080e7          	jalr	-1304(ra) # 8000431c <console_read>
    8000583c:	fe844503          	lbu	a0,-24(s0)
    80005840:	01813083          	ld	ra,24(sp)
    80005844:	01013403          	ld	s0,16(sp)
    80005848:	02010113          	addi	sp,sp,32
    8000584c:	00008067          	ret

0000000080005850 <console_handler>:
    80005850:	fe010113          	addi	sp,sp,-32
    80005854:	00813823          	sd	s0,16(sp)
    80005858:	00113c23          	sd	ra,24(sp)
    8000585c:	00913423          	sd	s1,8(sp)
    80005860:	02010413          	addi	s0,sp,32
    80005864:	14202773          	csrr	a4,scause
    80005868:	100027f3          	csrr	a5,sstatus
    8000586c:	0027f793          	andi	a5,a5,2
    80005870:	06079e63          	bnez	a5,800058ec <console_handler+0x9c>
    80005874:	00074c63          	bltz	a4,8000588c <console_handler+0x3c>
    80005878:	01813083          	ld	ra,24(sp)
    8000587c:	01013403          	ld	s0,16(sp)
    80005880:	00813483          	ld	s1,8(sp)
    80005884:	02010113          	addi	sp,sp,32
    80005888:	00008067          	ret
    8000588c:	0ff77713          	andi	a4,a4,255
    80005890:	00900793          	li	a5,9
    80005894:	fef712e3          	bne	a4,a5,80005878 <console_handler+0x28>
    80005898:	ffffe097          	auipc	ra,0xffffe
    8000589c:	6dc080e7          	jalr	1756(ra) # 80003f74 <plic_claim>
    800058a0:	00a00793          	li	a5,10
    800058a4:	00050493          	mv	s1,a0
    800058a8:	02f50c63          	beq	a0,a5,800058e0 <console_handler+0x90>
    800058ac:	fc0506e3          	beqz	a0,80005878 <console_handler+0x28>
    800058b0:	00050593          	mv	a1,a0
    800058b4:	00001517          	auipc	a0,0x1
    800058b8:	98c50513          	addi	a0,a0,-1652 # 80006240 <CONSOLE_STATUS+0x230>
    800058bc:	fffff097          	auipc	ra,0xfffff
    800058c0:	afc080e7          	jalr	-1284(ra) # 800043b8 <__printf>
    800058c4:	01013403          	ld	s0,16(sp)
    800058c8:	01813083          	ld	ra,24(sp)
    800058cc:	00048513          	mv	a0,s1
    800058d0:	00813483          	ld	s1,8(sp)
    800058d4:	02010113          	addi	sp,sp,32
    800058d8:	ffffe317          	auipc	t1,0xffffe
    800058dc:	6d430067          	jr	1748(t1) # 80003fac <plic_complete>
    800058e0:	fffff097          	auipc	ra,0xfffff
    800058e4:	3e0080e7          	jalr	992(ra) # 80004cc0 <uartintr>
    800058e8:	fddff06f          	j	800058c4 <console_handler+0x74>
    800058ec:	00001517          	auipc	a0,0x1
    800058f0:	a5450513          	addi	a0,a0,-1452 # 80006340 <digits+0x78>
    800058f4:	fffff097          	auipc	ra,0xfffff
    800058f8:	a68080e7          	jalr	-1432(ra) # 8000435c <panic>
	...
