
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	0d013103          	ld	sp,208(sp) # 800060d0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	579020ef          	jal	ra,80002d94 <start>

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
    8000100c:	425000ef          	jal	ra,80001c30 <_ZN3PCB10getContextEv>
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
    8000109c:	470000ef          	jal	ra,8000150c <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	391000ef          	jal	ra,80001c30 <_ZN3PCB10getContextEv>

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

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
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
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
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
    800013b0:	04078463          	beqz	a5,800013f8 <_Z8sem_waitP3SCB+0x60>
    asm volatile("mv a1, a0");
    800013b4:	00050593          	mv	a1,a0

    if(callInterrupt(code)) {
    800013b8:	02300513          	li	a0,35
    800013bc:	00000097          	auipc	ra,0x0
    800013c0:	db4080e7          	jalr	-588(ra) # 80001170 <_Z13callInterruptm>
    800013c4:	00050663          	beqz	a0,800013d0 <_Z8sem_waitP3SCB+0x38>
        thread_dispatch();
    800013c8:	00000097          	auipc	ra,0x0
    800013cc:	eac080e7          	jalr	-340(ra) # 80001274 <_Z15thread_dispatchv>
    }

    if(PCB::running->isSemaphoreDeleted()) return -2; // semafor je obrisan pre nego sto je proces odblokiran
    800013d0:	00005797          	auipc	a5,0x5
    800013d4:	d107b783          	ld	a5,-752(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800013d8:	0007b783          	ld	a5,0(a5)
    bool isFinished() const {
        return finished;
    }
    // vraca true ako je semafor obrisan pre nego sto je proces odblokiran
    bool isSemaphoreDeleted() const {
        return semDeleted;
    800013dc:	02a7c783          	lbu	a5,42(a5)
    800013e0:	02079063          	bnez	a5,80001400 <_Z8sem_waitP3SCB+0x68>

    return 0;
    800013e4:	00000513          	li	a0,0
}
    800013e8:	01813083          	ld	ra,24(sp)
    800013ec:	01013403          	ld	s0,16(sp)
    800013f0:	02010113          	addi	sp,sp,32
    800013f4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013f8:	fff00513          	li	a0,-1
    800013fc:	fedff06f          	j	800013e8 <_Z8sem_waitP3SCB+0x50>
    if(PCB::running->isSemaphoreDeleted()) return -2; // semafor je obrisan pre nego sto je proces odblokiran
    80001400:	ffe00513          	li	a0,-2
    80001404:	fe5ff06f          	j	800013e8 <_Z8sem_waitP3SCB+0x50>

0000000080001408 <_Z10sem_signalP3SCB>:

int sem_signal (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(handle == nullptr) return -1;
    80001408:	04050663          	beqz	a0,80001454 <_Z10sem_signalP3SCB+0x4c>
int sem_signal (sem_t handle) {
    8000140c:	fe010113          	addi	sp,sp,-32
    80001410:	00113c23          	sd	ra,24(sp)
    80001414:	00813823          	sd	s0,16(sp)
    80001418:	02010413          	addi	s0,sp,32
    asm volatile("mv a1, a0");
    8000141c:	00050593          	mv	a1,a0

    PCB* process = (PCB*)callInterrupt(code);
    80001420:	02400513          	li	a0,36
    80001424:	00000097          	auipc	ra,0x0
    80001428:	d4c080e7          	jalr	-692(ra) # 80001170 <_Z13callInterruptm>
    8000142c:	fea43423          	sd	a0,-24(s0)
    if(process) {
    80001430:	02050663          	beqz	a0,8000145c <_Z10sem_signalP3SCB+0x54>
        thread_start(&process);
    80001434:	fe840513          	addi	a0,s0,-24
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	e98080e7          	jalr	-360(ra) # 800012d0 <_Z12thread_startPP3PCB>
    }

    return 0;
    80001440:	00000513          	li	a0,0
}
    80001444:	01813083          	ld	ra,24(sp)
    80001448:	01013403          	ld	s0,16(sp)
    8000144c:	02010113          	addi	sp,sp,32
    80001450:	00008067          	ret
    if(handle == nullptr) return -1;
    80001454:	fff00513          	li	a0,-1
}
    80001458:	00008067          	ret
    return 0;
    8000145c:	00000513          	li	a0,0
    80001460:	fe5ff06f          	j	80001444 <_Z10sem_signalP3SCB+0x3c>

0000000080001464 <_Z9sem_closeP3SCB>:

int sem_close (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_close;
    if(handle == nullptr) return -1;
    80001464:	02050c63          	beqz	a0,8000149c <_Z9sem_closeP3SCB+0x38>
int sem_close (sem_t handle) {
    80001468:	ff010113          	addi	sp,sp,-16
    8000146c:	00113423          	sd	ra,8(sp)
    80001470:	00813023          	sd	s0,0(sp)
    80001474:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001478:	00050593          	mv	a1,a0
    callInterrupt(code);
    8000147c:	02200513          	li	a0,34
    80001480:	00000097          	auipc	ra,0x0
    80001484:	cf0080e7          	jalr	-784(ra) # 80001170 <_Z13callInterruptm>
    return 0;
    80001488:	00000513          	li	a0,0
}
    8000148c:	00813083          	ld	ra,8(sp)
    80001490:	00013403          	ld	s0,0(sp)
    80001494:	01010113          	addi	sp,sp,16
    80001498:	00008067          	ret
    if(handle == nullptr) return -1;
    8000149c:	fff00513          	li	a0,-1
}
    800014a0:	00008067          	ret

00000000800014a4 <_Z10time_sleepm>:

int time_sleep (time_t time) {
    size_t code = Kernel::sysCallCodes::time_sleep;
    if(time <= 0) return -1;
    800014a4:	04050063          	beqz	a0,800014e4 <_Z10time_sleepm+0x40>
int time_sleep (time_t time) {
    800014a8:	ff010113          	addi	sp,sp,-16
    800014ac:	00113423          	sd	ra,8(sp)
    800014b0:	00813023          	sd	s0,0(sp)
    800014b4:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    800014b8:	00050593          	mv	a1,a0
    callInterrupt(code);
    800014bc:	03100513          	li	a0,49
    800014c0:	00000097          	auipc	ra,0x0
    800014c4:	cb0080e7          	jalr	-848(ra) # 80001170 <_Z13callInterruptm>

    thread_dispatch(); // radimo odmah dispatch da bi zaustavili tekuci proces
    800014c8:	00000097          	auipc	ra,0x0
    800014cc:	dac080e7          	jalr	-596(ra) # 80001274 <_Z15thread_dispatchv>

    return 0;
    800014d0:	00000513          	li	a0,0
}
    800014d4:	00813083          	ld	ra,8(sp)
    800014d8:	00013403          	ld	s0,0(sp)
    800014dc:	01010113          	addi	sp,sp,16
    800014e0:	00008067          	ret
    if(time <= 0) return -1;
    800014e4:	fff00513          	li	a0,-1
}
    800014e8:	00008067          	ret

00000000800014ec <_ZN6Kernel10popSppSpieEv>:
#include "../h/print.h"
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"

void Kernel::popSppSpie() {
    800014ec:	ff010113          	addi	sp,sp,-16
    800014f0:	00813423          	sd	s0,8(sp)
    800014f4:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    800014f8:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    800014fc:	10200073          	sret
}
    80001500:	00813403          	ld	s0,8(sp)
    80001504:	01010113          	addi	sp,sp,16
    80001508:	00008067          	ret

000000008000150c <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    8000150c:	fa010113          	addi	sp,sp,-96
    80001510:	04113c23          	sd	ra,88(sp)
    80001514:	04813823          	sd	s0,80(sp)
    80001518:	04913423          	sd	s1,72(sp)
    8000151c:	05213023          	sd	s2,64(sp)
    80001520:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001524:	142027f3          	csrr	a5,scause
    80001528:	fcf43023          	sd	a5,-64(s0)
        return scause;
    8000152c:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001530:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001534:	141027f3          	csrr	a5,sepc
    80001538:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    8000153c:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80001540:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001544:	100027f3          	csrr	a5,sstatus
    80001548:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    8000154c:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001550:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001554:	fd843703          	ld	a4,-40(s0)
    80001558:	00900793          	li	a5,9
    8000155c:	04f70263          	beq	a4,a5,800015a0 <interruptHandler+0x94>
    80001560:	fd843703          	ld	a4,-40(s0)
    80001564:	00800793          	li	a5,8
    80001568:	02f70c63          	beq	a4,a5,800015a0 <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    8000156c:	fd843703          	ld	a4,-40(s0)
    80001570:	fff00793          	li	a5,-1
    80001574:	03f79793          	slli	a5,a5,0x3f
    80001578:	00178793          	addi	a5,a5,1
    8000157c:	26f70063          	beq	a4,a5,800017dc <interruptHandler+0x2d0>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    80001580:	fd843703          	ld	a4,-40(s0)
    80001584:	fff00793          	li	a5,-1
    80001588:	03f79793          	slli	a5,a5,0x3f
    8000158c:	00978793          	addi	a5,a5,9
    80001590:	2af70663          	beq	a4,a5,8000183c <interruptHandler+0x330>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    80001594:	00001097          	auipc	ra,0x1
    80001598:	718080e7          	jalr	1816(ra) # 80002cac <_Z10printErrorv>
    8000159c:	0840006f          	j	80001620 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015a0:	fd043783          	ld	a5,-48(s0)
    800015a4:	00478793          	addi	a5,a5,4
    800015a8:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015ac:	00005797          	auipc	a5,0x5
    800015b0:	b347b783          	ld	a5,-1228(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800015b4:	0007b503          	ld	a0,0(a5)
    800015b8:	01853703          	ld	a4,24(a0)
    800015bc:	05073783          	ld	a5,80(a4)
    800015c0:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015c4:	fa843783          	ld	a5,-88(s0)
    800015c8:	03100693          	li	a3,49
    800015cc:	20f6e263          	bltu	a3,a5,800017d0 <interruptHandler+0x2c4>
    800015d0:	00279793          	slli	a5,a5,0x2
    800015d4:	00004697          	auipc	a3,0x4
    800015d8:	a4c68693          	addi	a3,a3,-1460 # 80005020 <CONSOLE_STATUS+0x10>
    800015dc:	00d787b3          	add	a5,a5,a3
    800015e0:	0007a783          	lw	a5,0(a5)
    800015e4:	00d787b3          	add	a5,a5,a3
    800015e8:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    800015ec:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    800015f0:	00651513          	slli	a0,a0,0x6
    800015f4:	00001097          	auipc	ra,0x1
    800015f8:	0fc080e7          	jalr	252(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
    800015fc:	00005797          	auipc	a5,0x5
    80001600:	ae47b783          	ld	a5,-1308(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001604:	0007b783          	ld	a5,0(a5)
    80001608:	0187b783          	ld	a5,24(a5)
    8000160c:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001610:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001614:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001618:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000161c:	10079073          	csrw	sstatus,a5
    }

}
    80001620:	05813083          	ld	ra,88(sp)
    80001624:	05013403          	ld	s0,80(sp)
    80001628:	04813483          	ld	s1,72(sp)
    8000162c:	04013903          	ld	s2,64(sp)
    80001630:	06010113          	addi	sp,sp,96
    80001634:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001638:	05873503          	ld	a0,88(a4)
    8000163c:	00001097          	auipc	ra,0x1
    80001640:	218080e7          	jalr	536(ra) # 80002854 <_ZN15MemoryAllocator8mem_freeEPv>
    80001644:	00005797          	auipc	a5,0x5
    80001648:	a9c7b783          	ld	a5,-1380(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000164c:	0007b783          	ld	a5,0(a5)
    80001650:	0187b783          	ld	a5,24(a5)
    80001654:	04a7b823          	sd	a0,80(a5)
                break;
    80001658:	fb9ff06f          	j	80001610 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    8000165c:	00005797          	auipc	a5,0x5
    80001660:	a6c7b783          	ld	a5,-1428(a5) # 800060c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001664:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	368080e7          	jalr	872(ra) # 800019d0 <_ZN3PCB8dispatchEv>
                break;
    80001670:	fa1ff06f          	j	80001610 <interruptHandler+0x104>
                PCB::running->finished = true;
    80001674:	00100793          	li	a5,1
    80001678:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    8000167c:	00005797          	auipc	a5,0x5
    80001680:	a4c7b783          	ld	a5,-1460(a5) # 800060c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001684:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001688:	00000097          	auipc	ra,0x0
    8000168c:	348080e7          	jalr	840(ra) # 800019d0 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    80001690:	00005797          	auipc	a5,0x5
    80001694:	a507b783          	ld	a5,-1456(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001698:	0007b783          	ld	a5,0(a5)
    8000169c:	0187b783          	ld	a5,24(a5)
    800016a0:	0407b823          	sd	zero,80(a5)
                break;
    800016a4:	f6dff06f          	j	80001610 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800016a8:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800016ac:	0007b503          	ld	a0,0(a5)
    800016b0:	00000097          	auipc	ra,0x0
    800016b4:	5a4080e7          	jalr	1444(ra) # 80001c54 <_ZN9Scheduler3putEP3PCB>
                break;
    800016b8:	f59ff06f          	j	80001610 <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016bc:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016c0:	06873583          	ld	a1,104(a4)
    800016c4:	06073503          	ld	a0,96(a4)
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	4e0080e7          	jalr	1248(ra) # 80001ba8 <_ZN3PCB14createProccessEPFvvEPv>
    800016d0:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016d4:	00005797          	auipc	a5,0x5
    800016d8:	a0c7b783          	ld	a5,-1524(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800016dc:	0007b783          	ld	a5,0(a5)
    800016e0:	0187b703          	ld	a4,24(a5)
    800016e4:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    800016e8:	0004b703          	ld	a4,0(s1)
    800016ec:	f20702e3          	beqz	a4,80001610 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    800016f0:	0187b783          	ld	a5,24(a5)
    800016f4:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    800016f8:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    800016fc:	00008737          	lui	a4,0x8
    80001700:	00e787b3          	add	a5,a5,a4
    80001704:	0004b703          	ld	a4,0(s1)
    80001708:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    8000170c:	00f73823          	sd	a5,16(a4)
                break;
    80001710:	f01ff06f          	j	80001610 <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001714:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001718:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    8000171c:	01800513          	li	a0,24
    80001720:	00001097          	auipc	ra,0x1
    80001724:	f1c080e7          	jalr	-228(ra) # 8000263c <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    80001728:	00053023          	sd	zero,0(a0)
    8000172c:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80001730:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001734:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001738:	00005797          	auipc	a5,0x5
    8000173c:	9a87b783          	ld	a5,-1624(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001740:	0007b783          	ld	a5,0(a5)
    80001744:	0187b783          	ld	a5,24(a5)
    80001748:	0497b823          	sd	s1,80(a5)
                break;
    8000174c:	ec5ff06f          	j	80001610 <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // true kao proces treba da se blokira, false ako ne
    80001750:	05873503          	ld	a0,88(a4)
    80001754:	00001097          	auipc	ra,0x1
    80001758:	e5c080e7          	jalr	-420(ra) # 800025b0 <_ZN3SCB4waitEv>
    8000175c:	00005797          	auipc	a5,0x5
    80001760:	9847b783          	ld	a5,-1660(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001764:	0007b783          	ld	a5,0(a5)
    80001768:	0187b783          	ld	a5,24(a5)
    8000176c:	04a7b823          	sd	a0,80(a5)
                break;
    80001770:	ea1ff06f          	j	80001610 <interruptHandler+0x104>
                PCB::running->registers[10] = (size_t)sem->signal(); // vraca pokazivac na PCB ako ga treba staviti u Scheduler
    80001774:	05873503          	ld	a0,88(a4)
    80001778:	00001097          	auipc	ra,0x1
    8000177c:	e80080e7          	jalr	-384(ra) # 800025f8 <_ZN3SCB6signalEv>
    80001780:	00005797          	auipc	a5,0x5
    80001784:	9607b783          	ld	a5,-1696(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001788:	0007b783          	ld	a5,0(a5)
    8000178c:	0187b783          	ld	a5,24(a5)
    80001790:	04a7b823          	sd	a0,80(a5)
                break;
    80001794:	e7dff06f          	j	80001610 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001798:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000179c:	00048513          	mv	a0,s1
    800017a0:	00001097          	auipc	ra,0x1
    800017a4:	eec080e7          	jalr	-276(ra) # 8000268c <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017a8:	e60484e3          	beqz	s1,80001610 <interruptHandler+0x104>
    800017ac:	00048513          	mv	a0,s1
    800017b0:	00001097          	auipc	ra,0x1
    800017b4:	eb4080e7          	jalr	-332(ra) # 80002664 <_ZN3SCBdlEPv>
    800017b8:	e59ff06f          	j	80001610 <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    800017bc:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017c0:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017c4:	00000097          	auipc	ra,0x0
    800017c8:	084080e7          	jalr	132(ra) # 80001848 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017cc:	e45ff06f          	j	80001610 <interruptHandler+0x104>
                printError();
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	4dc080e7          	jalr	1244(ra) # 80002cac <_Z10printErrorv>
                break;
    800017d8:	e39ff06f          	j	80001610 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800017dc:	00005497          	auipc	s1,0x5
    800017e0:	8ec4b483          	ld	s1,-1812(s1) # 800060c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    800017e4:	0004b783          	ld	a5,0(s1)
    800017e8:	00178793          	addi	a5,a5,1
    800017ec:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	0e8080e7          	jalr	232(ra) # 800018d8 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800017f8:	00005797          	auipc	a5,0x5
    800017fc:	8e87b783          	ld	a5,-1816(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001800:	0007b783          	ld	a5,0(a5)
    80001804:	0407b703          	ld	a4,64(a5)
    80001808:	0004b783          	ld	a5,0(s1)
    8000180c:	00e7f863          	bgeu	a5,a4,8000181c <interruptHandler+0x310>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001810:	00200793          	li	a5,2
    80001814:	1447b073          	csrc	sip,a5
    }
    80001818:	e09ff06f          	j	80001620 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    8000181c:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001820:	00000097          	auipc	ra,0x0
    80001824:	1b0080e7          	jalr	432(ra) # 800019d0 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    80001828:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000182c:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    80001830:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001834:	10079073          	csrw	sstatus,a5
    }
    80001838:	fd9ff06f          	j	80001810 <interruptHandler+0x304>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    8000183c:	00003097          	auipc	ra,0x3
    80001840:	694080e7          	jalr	1684(ra) # 80004ed0 <console_handler>
    80001844:	dddff06f          	j	80001620 <interruptHandler+0x114>

0000000080001848 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00813423          	sd	s0,8(sp)
    80001850:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001854:	00005797          	auipc	a5,0x5
    80001858:	8ec7b783          	ld	a5,-1812(a5) # 80006140 <_ZN17SleepingProcesses4headE>
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    8000185c:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001860:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001864:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001868:	00078e63          	beqz	a5,80001884 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    8000186c:	0307b683          	ld	a3,48(a5)
    80001870:	00e6fa63          	bgeu	a3,a4,80001884 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001874:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001878:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    8000187c:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001880:	fe9ff06f          	j	80001868 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001884:	00100693          	li	a3,1
    80001888:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    8000188c:	02060663          	beqz	a2,800018b8 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    80001890:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    80001894:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001898:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    8000189c:	00078863          	beqz	a5,800018ac <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800018a0:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800018a4:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    800018a8:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    800018ac:	00813403          	ld	s0,8(sp)
    800018b0:	01010113          	addi	sp,sp,16
    800018b4:	00008067          	ret
        head = process;
    800018b8:	00005717          	auipc	a4,0x5
    800018bc:	88a73423          	sd	a0,-1912(a4) # 80006140 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    800018c0:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800018c4:	fe0784e3          	beqz	a5,800018ac <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800018c8:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800018cc:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    800018d0:	02b7b823          	sd	a1,48(a5)
    }
    800018d4:	fd9ff06f          	j	800018ac <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

00000000800018d8 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    800018d8:	00005517          	auipc	a0,0x5
    800018dc:	86853503          	ld	a0,-1944(a0) # 80006140 <_ZN17SleepingProcesses4headE>
    800018e0:	08050063          	beqz	a0,80001960 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800018e4:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800018e8:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800018ec:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800018f0:	06050263          	beqz	a0,80001954 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800018f4:	03053783          	ld	a5,48(a0)
    800018f8:	04079e63          	bnez	a5,80001954 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800018fc:	fe010113          	addi	sp,sp,-32
    80001900:	00113c23          	sd	ra,24(sp)
    80001904:	00813823          	sd	s0,16(sp)
    80001908:	00913423          	sd	s1,8(sp)
    8000190c:	02010413          	addi	s0,sp,32
    80001910:	00c0006f          	j	8000191c <_ZN17SleepingProcesses6wakeUpEv+0x44>
    80001914:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    80001918:	02079063          	bnez	a5,80001938 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    8000191c:	00053483          	ld	s1,0(a0)
        nextInList = next;
    80001920:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001924:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001928:	00000097          	auipc	ra,0x0
    8000192c:	32c080e7          	jalr	812(ra) # 80001c54 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001930:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001934:	fe0490e3          	bnez	s1,80001914 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001938:	00005797          	auipc	a5,0x5
    8000193c:	80a7b423          	sd	a0,-2040(a5) # 80006140 <_ZN17SleepingProcesses4headE>
}
    80001940:	01813083          	ld	ra,24(sp)
    80001944:	01013403          	ld	s0,16(sp)
    80001948:	00813483          	ld	s1,8(sp)
    8000194c:	02010113          	addi	sp,sp,32
    80001950:	00008067          	ret
    head = curr;
    80001954:	00004797          	auipc	a5,0x4
    80001958:	7ea7b623          	sd	a0,2028(a5) # 80006140 <_ZN17SleepingProcesses4headE>
    8000195c:	00008067          	ret
    80001960:	00008067          	ret

0000000080001964 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001964:	ff010113          	addi	sp,sp,-16
    80001968:	00113423          	sd	ra,8(sp)
    8000196c:	00813023          	sd	s0,0(sp)
    80001970:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001974:	00000097          	auipc	ra,0x0
    80001978:	b78080e7          	jalr	-1160(ra) # 800014ec <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    8000197c:	00004797          	auipc	a5,0x4
    80001980:	7cc7b783          	ld	a5,1996(a5) # 80006148 <_ZN3PCB7runningE>
    80001984:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001988:	00070513          	mv	a0,a4
    running->main();
    8000198c:	0207b783          	ld	a5,32(a5)
    80001990:	000780e7          	jalr	a5
    thread_exit();
    80001994:	00000097          	auipc	ra,0x0
    80001998:	90c080e7          	jalr	-1780(ra) # 800012a0 <_Z11thread_exitv>
}
    8000199c:	00813083          	ld	ra,8(sp)
    800019a0:	00013403          	ld	s0,0(sp)
    800019a4:	01010113          	addi	sp,sp,16
    800019a8:	00008067          	ret

00000000800019ac <_ZN3PCB5yieldEv>:
void PCB::yield() {
    800019ac:	ff010113          	addi	sp,sp,-16
    800019b0:	00813423          	sd	s0,8(sp)
    800019b4:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    800019b8:	01300793          	li	a5,19
    800019bc:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    800019c0:	00000073          	ecall
}
    800019c4:	00813403          	ld	s0,8(sp)
    800019c8:	01010113          	addi	sp,sp,16
    800019cc:	00008067          	ret

00000000800019d0 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    800019d0:	fe010113          	addi	sp,sp,-32
    800019d4:	00113c23          	sd	ra,24(sp)
    800019d8:	00813823          	sd	s0,16(sp)
    800019dc:	00913423          	sd	s1,8(sp)
    800019e0:	02010413          	addi	s0,sp,32
    PCB* old = running;
    800019e4:	00004497          	auipc	s1,0x4
    800019e8:	7644b483          	ld	s1,1892(s1) # 80006148 <_ZN3PCB7runningE>
        return finished;
    800019ec:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    800019f0:	00079663          	bnez	a5,800019fc <_ZN3PCB8dispatchEv+0x2c>
    800019f4:	0294c783          	lbu	a5,41(s1)
    800019f8:	04078263          	beqz	a5,80001a3c <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	2b0080e7          	jalr	688(ra) # 80001cac <_ZN9Scheduler3getEv>
    80001a04:	00004797          	auipc	a5,0x4
    80001a08:	74a7b223          	sd	a0,1860(a5) # 80006148 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001a0c:	04854783          	lbu	a5,72(a0)
    80001a10:	02078e63          	beqz	a5,80001a4c <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001a14:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001a18:	01853583          	ld	a1,24(a0)
    80001a1c:	0184b503          	ld	a0,24(s1)
    80001a20:	fffff097          	auipc	ra,0xfffff
    80001a24:	708080e7          	jalr	1800(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001a28:	01813083          	ld	ra,24(sp)
    80001a2c:	01013403          	ld	s0,16(sp)
    80001a30:	00813483          	ld	s1,8(sp)
    80001a34:	02010113          	addi	sp,sp,32
    80001a38:	00008067          	ret
        Scheduler::put(old);
    80001a3c:	00048513          	mv	a0,s1
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	214080e7          	jalr	532(ra) # 80001c54 <_ZN9Scheduler3putEP3PCB>
    80001a48:	fb5ff06f          	j	800019fc <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001a4c:	01853583          	ld	a1,24(a0)
    80001a50:	0184b503          	ld	a0,24(s1)
    80001a54:	fffff097          	auipc	ra,0xfffff
    80001a58:	6e8080e7          	jalr	1768(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001a5c:	fcdff06f          	j	80001a28 <_ZN3PCB8dispatchEv+0x58>

0000000080001a60 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001a60:	fe010113          	addi	sp,sp,-32
    80001a64:	00113c23          	sd	ra,24(sp)
    80001a68:	00813823          	sd	s0,16(sp)
    80001a6c:	00913423          	sd	s1,8(sp)
    80001a70:	02010413          	addi	s0,sp,32
    80001a74:	00050493          	mv	s1,a0
    80001a78:	00053023          	sd	zero,0(a0)
    80001a7c:	00053c23          	sd	zero,24(a0)
    80001a80:	02053823          	sd	zero,48(a0)
    80001a84:	00100793          	li	a5,1
    80001a88:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001a8c:	02050523          	sb	zero,42(a0)
    80001a90:	020504a3          	sb	zero,41(a0)
    80001a94:	02050423          	sb	zero,40(a0)
    main = main_;
    80001a98:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001a9c:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001aa0:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001aa4:	10800513          	li	a0,264
    80001aa8:	00001097          	auipc	ra,0x1
    80001aac:	c48080e7          	jalr	-952(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
    80001ab0:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001ab4:	00008537          	lui	a0,0x8
    80001ab8:	00001097          	auipc	ra,0x1
    80001abc:	c38080e7          	jalr	-968(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
    80001ac0:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001ac4:	000087b7          	lui	a5,0x8
    80001ac8:	00f50533          	add	a0,a0,a5
    80001acc:	0184b783          	ld	a5,24(s1)
    80001ad0:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001ad4:	0184b783          	ld	a5,24(s1)
    80001ad8:	00000717          	auipc	a4,0x0
    80001adc:	e8c70713          	addi	a4,a4,-372 # 80001964 <_ZN3PCB15proccessWrapperEv>
    80001ae0:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001ae4:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ae8:	0204b783          	ld	a5,32(s1)
    80001aec:	00078c63          	beqz	a5,80001b04 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001af0:	01813083          	ld	ra,24(sp)
    80001af4:	01013403          	ld	s0,16(sp)
    80001af8:	00813483          	ld	s1,8(sp)
    80001afc:	02010113          	addi	sp,sp,32
    80001b00:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001b04:	04048423          	sb	zero,72(s1)
}
    80001b08:	fe9ff06f          	j	80001af0 <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001b0c <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001b0c:	fe010113          	addi	sp,sp,-32
    80001b10:	00113c23          	sd	ra,24(sp)
    80001b14:	00813823          	sd	s0,16(sp)
    80001b18:	00913423          	sd	s1,8(sp)
    80001b1c:	02010413          	addi	s0,sp,32
    80001b20:	00050493          	mv	s1,a0
    delete[] stack;
    80001b24:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001b28:	00050663          	beqz	a0,80001b34 <_ZN3PCBD1Ev+0x28>
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	5bc080e7          	jalr	1468(ra) # 800020e8 <_ZdaPv>
    delete[] sysStack;
    80001b34:	0104b503          	ld	a0,16(s1)
    80001b38:	00050663          	beqz	a0,80001b44 <_ZN3PCBD1Ev+0x38>
    80001b3c:	00000097          	auipc	ra,0x0
    80001b40:	5ac080e7          	jalr	1452(ra) # 800020e8 <_ZdaPv>
}
    80001b44:	01813083          	ld	ra,24(sp)
    80001b48:	01013403          	ld	s0,16(sp)
    80001b4c:	00813483          	ld	s1,8(sp)
    80001b50:	02010113          	addi	sp,sp,32
    80001b54:	00008067          	ret

0000000080001b58 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001b58:	ff010113          	addi	sp,sp,-16
    80001b5c:	00113423          	sd	ra,8(sp)
    80001b60:	00813023          	sd	s0,0(sp)
    80001b64:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001b68:	00001097          	auipc	ra,0x1
    80001b6c:	b88080e7          	jalr	-1144(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001b70:	00813083          	ld	ra,8(sp)
    80001b74:	00013403          	ld	s0,0(sp)
    80001b78:	01010113          	addi	sp,sp,16
    80001b7c:	00008067          	ret

0000000080001b80 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001b80:	ff010113          	addi	sp,sp,-16
    80001b84:	00113423          	sd	ra,8(sp)
    80001b88:	00813023          	sd	s0,0(sp)
    80001b8c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001b90:	00001097          	auipc	ra,0x1
    80001b94:	cc4080e7          	jalr	-828(ra) # 80002854 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001b98:	00813083          	ld	ra,8(sp)
    80001b9c:	00013403          	ld	s0,0(sp)
    80001ba0:	01010113          	addi	sp,sp,16
    80001ba4:	00008067          	ret

0000000080001ba8 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001ba8:	fd010113          	addi	sp,sp,-48
    80001bac:	02113423          	sd	ra,40(sp)
    80001bb0:	02813023          	sd	s0,32(sp)
    80001bb4:	00913c23          	sd	s1,24(sp)
    80001bb8:	01213823          	sd	s2,16(sp)
    80001bbc:	01313423          	sd	s3,8(sp)
    80001bc0:	03010413          	addi	s0,sp,48
    80001bc4:	00050913          	mv	s2,a0
    80001bc8:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001bcc:	05000513          	li	a0,80
    80001bd0:	00000097          	auipc	ra,0x0
    80001bd4:	f88080e7          	jalr	-120(ra) # 80001b58 <_ZN3PCBnwEm>
    80001bd8:	00050493          	mv	s1,a0
    80001bdc:	00098693          	mv	a3,s3
    80001be0:	00200613          	li	a2,2
    80001be4:	00090593          	mv	a1,s2
    80001be8:	00000097          	auipc	ra,0x0
    80001bec:	e78080e7          	jalr	-392(ra) # 80001a60 <_ZN3PCBC1EPFvvEmPv>
    80001bf0:	0200006f          	j	80001c10 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001bf4:	00050913          	mv	s2,a0
    80001bf8:	00048513          	mv	a0,s1
    80001bfc:	00000097          	auipc	ra,0x0
    80001c00:	f84080e7          	jalr	-124(ra) # 80001b80 <_ZN3PCBdlEPv>
    80001c04:	00090513          	mv	a0,s2
    80001c08:	00005097          	auipc	ra,0x5
    80001c0c:	650080e7          	jalr	1616(ra) # 80007258 <_Unwind_Resume>
}
    80001c10:	00048513          	mv	a0,s1
    80001c14:	02813083          	ld	ra,40(sp)
    80001c18:	02013403          	ld	s0,32(sp)
    80001c1c:	01813483          	ld	s1,24(sp)
    80001c20:	01013903          	ld	s2,16(sp)
    80001c24:	00813983          	ld	s3,8(sp)
    80001c28:	03010113          	addi	sp,sp,48
    80001c2c:	00008067          	ret

0000000080001c30 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001c30:	ff010113          	addi	sp,sp,-16
    80001c34:	00813423          	sd	s0,8(sp)
    80001c38:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001c3c:	00004797          	auipc	a5,0x4
    80001c40:	50c7b783          	ld	a5,1292(a5) # 80006148 <_ZN3PCB7runningE>
    80001c44:	0187b503          	ld	a0,24(a5)
    80001c48:	00813403          	ld	s0,8(sp)
    80001c4c:	01010113          	addi	sp,sp,16
    80001c50:	00008067          	ret

0000000080001c54 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001c54:	ff010113          	addi	sp,sp,-16
    80001c58:	00813423          	sd	s0,8(sp)
    80001c5c:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001c60:	02050663          	beqz	a0,80001c8c <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001c64:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001c68:	00004797          	auipc	a5,0x4
    80001c6c:	4f07b783          	ld	a5,1264(a5) # 80006158 <_ZN9Scheduler4tailE>
    80001c70:	02078463          	beqz	a5,80001c98 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001c74:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001c78:	00004797          	auipc	a5,0x4
    80001c7c:	4e078793          	addi	a5,a5,1248 # 80006158 <_ZN9Scheduler4tailE>
    80001c80:	0007b703          	ld	a4,0(a5)
    80001c84:	00073703          	ld	a4,0(a4)
    80001c88:	00e7b023          	sd	a4,0(a5)
    }
}
    80001c8c:	00813403          	ld	s0,8(sp)
    80001c90:	01010113          	addi	sp,sp,16
    80001c94:	00008067          	ret
        head = tail = process;
    80001c98:	00004797          	auipc	a5,0x4
    80001c9c:	4c078793          	addi	a5,a5,1216 # 80006158 <_ZN9Scheduler4tailE>
    80001ca0:	00a7b023          	sd	a0,0(a5)
    80001ca4:	00a7b423          	sd	a0,8(a5)
    80001ca8:	fe5ff06f          	j	80001c8c <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001cac <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001cac:	ff010113          	addi	sp,sp,-16
    80001cb0:	00813423          	sd	s0,8(sp)
    80001cb4:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001cb8:	00004517          	auipc	a0,0x4
    80001cbc:	4a853503          	ld	a0,1192(a0) # 80006160 <_ZN9Scheduler4headE>
    80001cc0:	02050463          	beqz	a0,80001ce8 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001cc4:	00053703          	ld	a4,0(a0)
    80001cc8:	00004797          	auipc	a5,0x4
    80001ccc:	49078793          	addi	a5,a5,1168 # 80006158 <_ZN9Scheduler4tailE>
    80001cd0:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001cd4:	0007b783          	ld	a5,0(a5)
    80001cd8:	00f50e63          	beq	a0,a5,80001cf4 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001cdc:	00813403          	ld	s0,8(sp)
    80001ce0:	01010113          	addi	sp,sp,16
    80001ce4:	00008067          	ret
        return idleProcess;
    80001ce8:	00004517          	auipc	a0,0x4
    80001cec:	48053503          	ld	a0,1152(a0) # 80006168 <_ZN9Scheduler11idleProcessE>
    80001cf0:	fedff06f          	j	80001cdc <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001cf4:	00004797          	auipc	a5,0x4
    80001cf8:	46e7b223          	sd	a4,1124(a5) # 80006158 <_ZN9Scheduler4tailE>
    80001cfc:	fe1ff06f          	j	80001cdc <_ZN9Scheduler3getEv+0x30>

0000000080001d00 <_Z11idleProcessv>:
    }
};


// Kernel inicijalizaccija
void idleProcess() {
    80001d00:	ff010113          	addi	sp,sp,-16
    80001d04:	00813423          	sd	s0,8(sp)
    80001d08:	01010413          	addi	s0,sp,16
    while(true) {}
    80001d0c:	0000006f          	j	80001d0c <_Z11idleProcessv+0xc>

0000000080001d10 <main>:
}
extern "C" void interrupt();
// ------------
int main() {
    80001d10:	fe010113          	addi	sp,sp,-32
    80001d14:	00113c23          	sd	ra,24(sp)
    80001d18:	00813823          	sd	s0,16(sp)
    80001d1c:	00913423          	sd	s1,8(sp)
    80001d20:	01213023          	sd	s2,0(sp)
    80001d24:	02010413          	addi	s0,sp,32
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001d28:	00004797          	auipc	a5,0x4
    80001d2c:	3c87b783          	ld	a5,968(a5) # 800060f0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001d30:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001d34:	00000593          	li	a1,0
    80001d38:	00000513          	li	a0,0
    80001d3c:	00000097          	auipc	ra,0x0
    80001d40:	e6c080e7          	jalr	-404(ra) # 80001ba8 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001d44:	00004797          	auipc	a5,0x4
    80001d48:	39c7b783          	ld	a5,924(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001d4c:	00a7b023          	sd	a0,0(a5)
    Scheduler::idleProcess = PCB::createProccess(idleProcess, nullptr);
    80001d50:	00000593          	li	a1,0
    80001d54:	00000517          	auipc	a0,0x0
    80001d58:	fac50513          	addi	a0,a0,-84 # 80001d00 <_Z11idleProcessv>
    80001d5c:	00000097          	auipc	ra,0x0
    80001d60:	e4c080e7          	jalr	-436(ra) # 80001ba8 <_ZN3PCB14createProccessEPFvvEPv>
    80001d64:	00004797          	auipc	a5,0x4
    80001d68:	3747b783          	ld	a5,884(a5) # 800060d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001d6c:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001d70:	00200793          	li	a5,2
    80001d74:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    // ----

    periodicnaNit *pNit = new periodicnaNit(10);
    80001d78:	01000513          	li	a0,16
    80001d7c:	00000097          	auipc	ra,0x0
    80001d80:	3cc080e7          	jalr	972(ra) # 80002148 <_ZN6ThreadnwEm>
    80001d84:	00050493          	mv	s1,a0
    periodicnaNit(time_t period) : PeriodicThread(period) {}
    80001d88:	00a00593          	li	a1,10
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	6ec080e7          	jalr	1772(ra) # 80002478 <_ZN14PeriodicThreadC1Em>
    80001d94:	00004797          	auipc	a5,0x4
    80001d98:	2a478793          	addi	a5,a5,676 # 80006038 <_ZTV13periodicnaNit+0x10>
    80001d9c:	00f4b023          	sd	a5,0(s1)
    pNit->start();
    80001da0:	00048513          	mv	a0,s1
    80001da4:	00000097          	auipc	ra,0x0
    80001da8:	45c080e7          	jalr	1116(ra) # 80002200 <_ZN6Thread5startEv>
    time_sleep(10);
    80001dac:	00a00513          	li	a0,10
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	6f4080e7          	jalr	1780(ra) # 800014a4 <_Z10time_sleepm>
    delete pNit;
    80001db8:	00048a63          	beqz	s1,80001dcc <main+0xbc>
    80001dbc:	0004b783          	ld	a5,0(s1)
    80001dc0:	0087b783          	ld	a5,8(a5)
    80001dc4:	00048513          	mv	a0,s1
    80001dc8:	000780e7          	jalr	a5
    return 0;
    80001dcc:	00000513          	li	a0,0
    80001dd0:	01813083          	ld	ra,24(sp)
    80001dd4:	01013403          	ld	s0,16(sp)
    80001dd8:	00813483          	ld	s1,8(sp)
    80001ddc:	00013903          	ld	s2,0(sp)
    80001de0:	02010113          	addi	sp,sp,32
    80001de4:	00008067          	ret
    80001de8:	00050913          	mv	s2,a0
    periodicnaNit *pNit = new periodicnaNit(10);
    80001dec:	00048513          	mv	a0,s1
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	380080e7          	jalr	896(ra) # 80002170 <_ZN6ThreaddlEPv>
    80001df8:	00090513          	mv	a0,s2
    80001dfc:	00005097          	auipc	ra,0x5
    80001e00:	45c080e7          	jalr	1116(ra) # 80007258 <_Unwind_Resume>

0000000080001e04 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80001e04:	ff010113          	addi	sp,sp,-16
    80001e08:	00813423          	sd	s0,8(sp)
    80001e0c:	01010413          	addi	s0,sp,16
    80001e10:	00813403          	ld	s0,8(sp)
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00008067          	ret

0000000080001e1c <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00813423          	sd	s0,8(sp)
    80001e24:	01010413          	addi	s0,sp,16
    80001e28:	00813403          	ld	s0,8(sp)
    80001e2c:	01010113          	addi	sp,sp,16
    80001e30:	00008067          	ret

0000000080001e34 <_ZN13periodicnaNit18periodicActivationEv>:
    void periodicActivation() override {
    80001e34:	ff010113          	addi	sp,sp,-16
    80001e38:	00113423          	sd	ra,8(sp)
    80001e3c:	00813023          	sd	s0,0(sp)
    80001e40:	01010413          	addi	s0,sp,16
        printString("Test");
    80001e44:	00003517          	auipc	a0,0x3
    80001e48:	2a450513          	addi	a0,a0,676 # 800050e8 <CONSOLE_STATUS+0xd8>
    80001e4c:	00001097          	auipc	ra,0x1
    80001e50:	bb4080e7          	jalr	-1100(ra) # 80002a00 <_Z11printStringPKc>
        printInt(i);
    80001e54:	00000613          	li	a2,0
    80001e58:	00a00593          	li	a1,10
    80001e5c:	00004517          	auipc	a0,0x4
    80001e60:	31452503          	lw	a0,788(a0) # 80006170 <_ZZN13periodicnaNit18periodicActivationEvE1i>
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	d34080e7          	jalr	-716(ra) # 80002b98 <_Z8printIntiii>
        printString("\n");
    80001e6c:	00003517          	auipc	a0,0x3
    80001e70:	3bc50513          	addi	a0,a0,956 # 80005228 <CONSOLE_STATUS+0x218>
    80001e74:	00001097          	auipc	ra,0x1
    80001e78:	b8c080e7          	jalr	-1140(ra) # 80002a00 <_Z11printStringPKc>
    }
    80001e7c:	00813083          	ld	ra,8(sp)
    80001e80:	00013403          	ld	s0,0(sp)
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret

0000000080001e8c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80001e8c:	ff010113          	addi	sp,sp,-16
    80001e90:	00113423          	sd	ra,8(sp)
    80001e94:	00813023          	sd	s0,0(sp)
    80001e98:	01010413          	addi	s0,sp,16
    80001e9c:	00004797          	auipc	a5,0x4
    80001ea0:	16c78793          	addi	a5,a5,364 # 80006008 <_ZTV14PeriodicThread+0x10>
    80001ea4:	00f53023          	sd	a5,0(a0)
    80001ea8:	00000097          	auipc	ra,0x0
    80001eac:	13c080e7          	jalr	316(ra) # 80001fe4 <_ZN6ThreadD1Ev>
    80001eb0:	00813083          	ld	ra,8(sp)
    80001eb4:	00013403          	ld	s0,0(sp)
    80001eb8:	01010113          	addi	sp,sp,16
    80001ebc:	00008067          	ret

0000000080001ec0 <_ZN14PeriodicThreadD0Ev>:
    80001ec0:	fe010113          	addi	sp,sp,-32
    80001ec4:	00113c23          	sd	ra,24(sp)
    80001ec8:	00813823          	sd	s0,16(sp)
    80001ecc:	00913423          	sd	s1,8(sp)
    80001ed0:	02010413          	addi	s0,sp,32
    80001ed4:	00050493          	mv	s1,a0
    80001ed8:	00004797          	auipc	a5,0x4
    80001edc:	13078793          	addi	a5,a5,304 # 80006008 <_ZTV14PeriodicThread+0x10>
    80001ee0:	00f53023          	sd	a5,0(a0)
    80001ee4:	00000097          	auipc	ra,0x0
    80001ee8:	100080e7          	jalr	256(ra) # 80001fe4 <_ZN6ThreadD1Ev>
    80001eec:	00048513          	mv	a0,s1
    80001ef0:	00000097          	auipc	ra,0x0
    80001ef4:	280080e7          	jalr	640(ra) # 80002170 <_ZN6ThreaddlEPv>
    80001ef8:	01813083          	ld	ra,24(sp)
    80001efc:	01013403          	ld	s0,16(sp)
    80001f00:	00813483          	ld	s1,8(sp)
    80001f04:	02010113          	addi	sp,sp,32
    80001f08:	00008067          	ret

0000000080001f0c <_ZN13periodicnaNitD1Ev>:
class periodicnaNit : public PeriodicThread {
    80001f0c:	ff010113          	addi	sp,sp,-16
    80001f10:	00113423          	sd	ra,8(sp)
    80001f14:	00813023          	sd	s0,0(sp)
    80001f18:	01010413          	addi	s0,sp,16
    80001f1c:	00004797          	auipc	a5,0x4
    80001f20:	0ec78793          	addi	a5,a5,236 # 80006008 <_ZTV14PeriodicThread+0x10>
    80001f24:	00f53023          	sd	a5,0(a0)
    80001f28:	00000097          	auipc	ra,0x0
    80001f2c:	0bc080e7          	jalr	188(ra) # 80001fe4 <_ZN6ThreadD1Ev>
    80001f30:	00813083          	ld	ra,8(sp)
    80001f34:	00013403          	ld	s0,0(sp)
    80001f38:	01010113          	addi	sp,sp,16
    80001f3c:	00008067          	ret

0000000080001f40 <_ZN13periodicnaNitD0Ev>:
    80001f40:	fe010113          	addi	sp,sp,-32
    80001f44:	00113c23          	sd	ra,24(sp)
    80001f48:	00813823          	sd	s0,16(sp)
    80001f4c:	00913423          	sd	s1,8(sp)
    80001f50:	02010413          	addi	s0,sp,32
    80001f54:	00050493          	mv	s1,a0
    80001f58:	00004797          	auipc	a5,0x4
    80001f5c:	0b078793          	addi	a5,a5,176 # 80006008 <_ZTV14PeriodicThread+0x10>
    80001f60:	00f53023          	sd	a5,0(a0)
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	080080e7          	jalr	128(ra) # 80001fe4 <_ZN6ThreadD1Ev>
    80001f6c:	00048513          	mv	a0,s1
    80001f70:	00000097          	auipc	ra,0x0
    80001f74:	200080e7          	jalr	512(ra) # 80002170 <_ZN6ThreaddlEPv>
    80001f78:	01813083          	ld	ra,24(sp)
    80001f7c:	01013403          	ld	s0,16(sp)
    80001f80:	00813483          	ld	s1,8(sp)
    80001f84:	02010113          	addi	sp,sp,32
    80001f88:	00008067          	ret

0000000080001f8c <_Z13threadWrapperPv>:
Thread::Thread() {
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    thread_create_only(&myHandle, threadWrapper, tArg);
}

void threadWrapper(void* thread) {
    80001f8c:	fd010113          	addi	sp,sp,-48
    80001f90:	02113423          	sd	ra,40(sp)
    80001f94:	02813023          	sd	s0,32(sp)
    80001f98:	03010413          	addi	s0,sp,48
    threadArg tArg = *(threadArg*)thread;
    80001f9c:	00053783          	ld	a5,0(a0)
    80001fa0:	fcf43c23          	sd	a5,-40(s0)
    80001fa4:	00853703          	ld	a4,8(a0)
    80001fa8:	fee43023          	sd	a4,-32(s0)
    80001fac:	01053503          	ld	a0,16(a0)
    80001fb0:	fea43423          	sd	a0,-24(s0)
    (((Thread*)tArg.thread)->*(tArg.run))();
    80001fb4:	00a78533          	add	a0,a5,a0
    80001fb8:	00070793          	mv	a5,a4
    80001fbc:	00177693          	andi	a3,a4,1
    80001fc0:	00068863          	beqz	a3,80001fd0 <_Z13threadWrapperPv+0x44>
    80001fc4:	00053783          	ld	a5,0(a0)
    80001fc8:	00e78733          	add	a4,a5,a4
    80001fcc:	fff73783          	ld	a5,-1(a4)
    80001fd0:	000780e7          	jalr	a5
}
    80001fd4:	02813083          	ld	ra,40(sp)
    80001fd8:	02013403          	ld	s0,32(sp)
    80001fdc:	03010113          	addi	sp,sp,48
    80001fe0:	00008067          	ret

0000000080001fe4 <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    80001fe4:	fe010113          	addi	sp,sp,-32
    80001fe8:	00113c23          	sd	ra,24(sp)
    80001fec:	00813823          	sd	s0,16(sp)
    80001ff0:	00913423          	sd	s1,8(sp)
    80001ff4:	02010413          	addi	s0,sp,32
    80001ff8:	00004797          	auipc	a5,0x4
    80001ffc:	07078793          	addi	a5,a5,112 # 80006068 <_ZTV6Thread+0x10>
    80002000:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002004:	00853483          	ld	s1,8(a0)
    80002008:	00048e63          	beqz	s1,80002024 <_ZN6ThreadD1Ev+0x40>
    8000200c:	00048513          	mv	a0,s1
    80002010:	00000097          	auipc	ra,0x0
    80002014:	afc080e7          	jalr	-1284(ra) # 80001b0c <_ZN3PCBD1Ev>
    80002018:	00048513          	mv	a0,s1
    8000201c:	00000097          	auipc	ra,0x0
    80002020:	b64080e7          	jalr	-1180(ra) # 80001b80 <_ZN3PCBdlEPv>
}
    80002024:	01813083          	ld	ra,24(sp)
    80002028:	01013403          	ld	s0,16(sp)
    8000202c:	00813483          	ld	s1,8(sp)
    80002030:	02010113          	addi	sp,sp,32
    80002034:	00008067          	ret

0000000080002038 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002038:	ff010113          	addi	sp,sp,-16
    8000203c:	00113423          	sd	ra,8(sp)
    80002040:	00813023          	sd	s0,0(sp)
    80002044:	01010413          	addi	s0,sp,16
    80002048:	00004797          	auipc	a5,0x4
    8000204c:	04878793          	addi	a5,a5,72 # 80006090 <_ZTV9Semaphore+0x10>
    80002050:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002054:	00853503          	ld	a0,8(a0)
    80002058:	fffff097          	auipc	ra,0xfffff
    8000205c:	40c080e7          	jalr	1036(ra) # 80001464 <_Z9sem_closeP3SCB>
}
    80002060:	00813083          	ld	ra,8(sp)
    80002064:	00013403          	ld	s0,0(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <_Znwm>:
void* operator new (size_t size) {
    80002070:	ff010113          	addi	sp,sp,-16
    80002074:	00113423          	sd	ra,8(sp)
    80002078:	00813023          	sd	s0,0(sp)
    8000207c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002080:	fffff097          	auipc	ra,0xfffff
    80002084:	114080e7          	jalr	276(ra) # 80001194 <_Z9mem_allocm>
}
    80002088:	00813083          	ld	ra,8(sp)
    8000208c:	00013403          	ld	s0,0(sp)
    80002090:	01010113          	addi	sp,sp,16
    80002094:	00008067          	ret

0000000080002098 <_Znam>:
void* operator new [](size_t size) {
    80002098:	ff010113          	addi	sp,sp,-16
    8000209c:	00113423          	sd	ra,8(sp)
    800020a0:	00813023          	sd	s0,0(sp)
    800020a4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	0ec080e7          	jalr	236(ra) # 80001194 <_Z9mem_allocm>
}
    800020b0:	00813083          	ld	ra,8(sp)
    800020b4:	00013403          	ld	s0,0(sp)
    800020b8:	01010113          	addi	sp,sp,16
    800020bc:	00008067          	ret

00000000800020c0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800020c0:	ff010113          	addi	sp,sp,-16
    800020c4:	00113423          	sd	ra,8(sp)
    800020c8:	00813023          	sd	s0,0(sp)
    800020cc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800020d0:	fffff097          	auipc	ra,0xfffff
    800020d4:	104080e7          	jalr	260(ra) # 800011d4 <_Z8mem_freePv>
}
    800020d8:	00813083          	ld	ra,8(sp)
    800020dc:	00013403          	ld	s0,0(sp)
    800020e0:	01010113          	addi	sp,sp,16
    800020e4:	00008067          	ret

00000000800020e8 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    800020e8:	ff010113          	addi	sp,sp,-16
    800020ec:	00113423          	sd	ra,8(sp)
    800020f0:	00813023          	sd	s0,0(sp)
    800020f4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800020f8:	fffff097          	auipc	ra,0xfffff
    800020fc:	0dc080e7          	jalr	220(ra) # 800011d4 <_Z8mem_freePv>
}
    80002100:	00813083          	ld	ra,8(sp)
    80002104:	00013403          	ld	s0,0(sp)
    80002108:	01010113          	addi	sp,sp,16
    8000210c:	00008067          	ret

0000000080002110 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002110:	ff010113          	addi	sp,sp,-16
    80002114:	00113423          	sd	ra,8(sp)
    80002118:	00813023          	sd	s0,0(sp)
    8000211c:	01010413          	addi	s0,sp,16
    80002120:	00004797          	auipc	a5,0x4
    80002124:	f4878793          	addi	a5,a5,-184 # 80006068 <_ZTV6Thread+0x10>
    80002128:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    8000212c:	00850513          	addi	a0,a0,8
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	0d8080e7          	jalr	216(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002138:	00813083          	ld	ra,8(sp)
    8000213c:	00013403          	ld	s0,0(sp)
    80002140:	01010113          	addi	sp,sp,16
    80002144:	00008067          	ret

0000000080002148 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00113423          	sd	ra,8(sp)
    80002150:	00813023          	sd	s0,0(sp)
    80002154:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	598080e7          	jalr	1432(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002160:	00813083          	ld	ra,8(sp)
    80002164:	00013403          	ld	s0,0(sp)
    80002168:	01010113          	addi	sp,sp,16
    8000216c:	00008067          	ret

0000000080002170 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002170:	ff010113          	addi	sp,sp,-16
    80002174:	00113423          	sd	ra,8(sp)
    80002178:	00813023          	sd	s0,0(sp)
    8000217c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002180:	00000097          	auipc	ra,0x0
    80002184:	6d4080e7          	jalr	1748(ra) # 80002854 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002188:	00813083          	ld	ra,8(sp)
    8000218c:	00013403          	ld	s0,0(sp)
    80002190:	01010113          	addi	sp,sp,16
    80002194:	00008067          	ret

0000000080002198 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002198:	fe010113          	addi	sp,sp,-32
    8000219c:	00113c23          	sd	ra,24(sp)
    800021a0:	00813823          	sd	s0,16(sp)
    800021a4:	00913423          	sd	s1,8(sp)
    800021a8:	02010413          	addi	s0,sp,32
    800021ac:	00050493          	mv	s1,a0
}
    800021b0:	00000097          	auipc	ra,0x0
    800021b4:	e34080e7          	jalr	-460(ra) # 80001fe4 <_ZN6ThreadD1Ev>
    800021b8:	00048513          	mv	a0,s1
    800021bc:	00000097          	auipc	ra,0x0
    800021c0:	fb4080e7          	jalr	-76(ra) # 80002170 <_ZN6ThreaddlEPv>
    800021c4:	01813083          	ld	ra,24(sp)
    800021c8:	01013403          	ld	s0,16(sp)
    800021cc:	00813483          	ld	s1,8(sp)
    800021d0:	02010113          	addi	sp,sp,32
    800021d4:	00008067          	ret

00000000800021d8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800021d8:	ff010113          	addi	sp,sp,-16
    800021dc:	00113423          	sd	ra,8(sp)
    800021e0:	00813023          	sd	s0,0(sp)
    800021e4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	08c080e7          	jalr	140(ra) # 80001274 <_Z15thread_dispatchv>
}
    800021f0:	00813083          	ld	ra,8(sp)
    800021f4:	00013403          	ld	s0,0(sp)
    800021f8:	01010113          	addi	sp,sp,16
    800021fc:	00008067          	ret

0000000080002200 <_ZN6Thread5startEv>:
int Thread::start() {
    80002200:	ff010113          	addi	sp,sp,-16
    80002204:	00113423          	sd	ra,8(sp)
    80002208:	00813023          	sd	s0,0(sp)
    8000220c:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002210:	00850513          	addi	a0,a0,8
    80002214:	fffff097          	auipc	ra,0xfffff
    80002218:	0bc080e7          	jalr	188(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    8000221c:	00000513          	li	a0,0
    80002220:	00813083          	ld	ra,8(sp)
    80002224:	00013403          	ld	s0,0(sp)
    80002228:	01010113          	addi	sp,sp,16
    8000222c:	00008067          	ret

0000000080002230 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002230:	fe010113          	addi	sp,sp,-32
    80002234:	00113c23          	sd	ra,24(sp)
    80002238:	00813823          	sd	s0,16(sp)
    8000223c:	00913423          	sd	s1,8(sp)
    80002240:	02010413          	addi	s0,sp,32
    80002244:	00050493          	mv	s1,a0
    80002248:	00004797          	auipc	a5,0x4
    8000224c:	e2078793          	addi	a5,a5,-480 # 80006068 <_ZTV6Thread+0x10>
    80002250:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002254:	01800513          	li	a0,24
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	e18080e7          	jalr	-488(ra) # 80002070 <_Znwm>
    80002260:	00050613          	mv	a2,a0
    80002264:	00953023          	sd	s1,0(a0)
    80002268:	01100793          	li	a5,17
    8000226c:	00f53423          	sd	a5,8(a0)
    80002270:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002274:	00000597          	auipc	a1,0x0
    80002278:	d1858593          	addi	a1,a1,-744 # 80001f8c <_Z13threadWrapperPv>
    8000227c:	00848513          	addi	a0,s1,8
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	f88080e7          	jalr	-120(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002288:	01813083          	ld	ra,24(sp)
    8000228c:	01013403          	ld	s0,16(sp)
    80002290:	00813483          	ld	s1,8(sp)
    80002294:	02010113          	addi	sp,sp,32
    80002298:	00008067          	ret

000000008000229c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    8000229c:	ff010113          	addi	sp,sp,-16
    800022a0:	00113423          	sd	ra,8(sp)
    800022a4:	00813023          	sd	s0,0(sp)
    800022a8:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    800022ac:	fffff097          	auipc	ra,0xfffff
    800022b0:	1f8080e7          	jalr	504(ra) # 800014a4 <_Z10time_sleepm>
}
    800022b4:	00813083          	ld	ra,8(sp)
    800022b8:	00013403          	ld	s0,0(sp)
    800022bc:	01010113          	addi	sp,sp,16
    800022c0:	00008067          	ret

00000000800022c4 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    800022c4:	fd010113          	addi	sp,sp,-48
    800022c8:	02113423          	sd	ra,40(sp)
    800022cc:	02813023          	sd	s0,32(sp)
    800022d0:	03010413          	addi	s0,sp,48
    periodicThreadArg pArg = *(periodicThreadArg*)periodicThread;
    800022d4:	00053603          	ld	a2,0(a0)
    800022d8:	00853683          	ld	a3,8(a0)
    800022dc:	01053703          	ld	a4,16(a0)
    800022e0:	01853783          	ld	a5,24(a0)
    800022e4:	fcc43823          	sd	a2,-48(s0)
    800022e8:	fcd43c23          	sd	a3,-40(s0)
    800022ec:	fee43023          	sd	a4,-32(s0)
    800022f0:	fef43423          	sd	a5,-24(s0)
    800022f4:	0200006f          	j	80002314 <_Z21periodicThreadWrapperPv+0x50>
    while(true) {
        (((PeriodicThread*)pArg.periodicThread)->*((pArg.periodicActivation)))();
    800022f8:	00053703          	ld	a4,0(a0)
    800022fc:	00f707b3          	add	a5,a4,a5
    80002300:	fff7b783          	ld	a5,-1(a5)
    80002304:	000780e7          	jalr	a5
        Thread::sleep(pArg.period);
    80002308:	fe843503          	ld	a0,-24(s0)
    8000230c:	00000097          	auipc	ra,0x0
    80002310:	f90080e7          	jalr	-112(ra) # 8000229c <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg.periodicThread)->*((pArg.periodicActivation)))();
    80002314:	fd043503          	ld	a0,-48(s0)
    80002318:	fe043783          	ld	a5,-32(s0)
    8000231c:	00f50533          	add	a0,a0,a5
    80002320:	fd843783          	ld	a5,-40(s0)
    80002324:	0017f713          	andi	a4,a5,1
    80002328:	fc070ee3          	beqz	a4,80002304 <_Z21periodicThreadWrapperPv+0x40>
    8000232c:	fcdff06f          	j	800022f8 <_Z21periodicThreadWrapperPv+0x34>

0000000080002330 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002330:	fe010113          	addi	sp,sp,-32
    80002334:	00113c23          	sd	ra,24(sp)
    80002338:	00813823          	sd	s0,16(sp)
    8000233c:	00913423          	sd	s1,8(sp)
    80002340:	01213023          	sd	s2,0(sp)
    80002344:	02010413          	addi	s0,sp,32
    80002348:	00050493          	mv	s1,a0
    8000234c:	00004797          	auipc	a5,0x4
    80002350:	d4478793          	addi	a5,a5,-700 # 80006090 <_ZTV9Semaphore+0x10>
    80002354:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002358:	00058913          	mv	s2,a1
        return new SCB(semValue);
    8000235c:	01800513          	li	a0,24
    80002360:	00000097          	auipc	ra,0x0
    80002364:	2dc080e7          	jalr	732(ra) # 8000263c <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002368:	00053023          	sd	zero,0(a0)
    8000236c:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80002370:	01252823          	sw	s2,16(a0)
    80002374:	00a4b423          	sd	a0,8(s1)
}
    80002378:	01813083          	ld	ra,24(sp)
    8000237c:	01013403          	ld	s0,16(sp)
    80002380:	00813483          	ld	s1,8(sp)
    80002384:	00013903          	ld	s2,0(sp)
    80002388:	02010113          	addi	sp,sp,32
    8000238c:	00008067          	ret

0000000080002390 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002390:	ff010113          	addi	sp,sp,-16
    80002394:	00113423          	sd	ra,8(sp)
    80002398:	00813023          	sd	s0,0(sp)
    8000239c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800023a0:	00853503          	ld	a0,8(a0)
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	ff4080e7          	jalr	-12(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    800023ac:	00813083          	ld	ra,8(sp)
    800023b0:	00013403          	ld	s0,0(sp)
    800023b4:	01010113          	addi	sp,sp,16
    800023b8:	00008067          	ret

00000000800023bc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800023bc:	ff010113          	addi	sp,sp,-16
    800023c0:	00113423          	sd	ra,8(sp)
    800023c4:	00813023          	sd	s0,0(sp)
    800023c8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800023cc:	00853503          	ld	a0,8(a0)
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	038080e7          	jalr	56(ra) # 80001408 <_Z10sem_signalP3SCB>
}
    800023d8:	00813083          	ld	ra,8(sp)
    800023dc:	00013403          	ld	s0,0(sp)
    800023e0:	01010113          	addi	sp,sp,16
    800023e4:	00008067          	ret

00000000800023e8 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    800023e8:	ff010113          	addi	sp,sp,-16
    800023ec:	00113423          	sd	ra,8(sp)
    800023f0:	00813023          	sd	s0,0(sp)
    800023f4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800023f8:	00000097          	auipc	ra,0x0
    800023fc:	45c080e7          	jalr	1116(ra) # 80002854 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002400:	00813083          	ld	ra,8(sp)
    80002404:	00013403          	ld	s0,0(sp)
    80002408:	01010113          	addi	sp,sp,16
    8000240c:	00008067          	ret

0000000080002410 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002410:	fe010113          	addi	sp,sp,-32
    80002414:	00113c23          	sd	ra,24(sp)
    80002418:	00813823          	sd	s0,16(sp)
    8000241c:	00913423          	sd	s1,8(sp)
    80002420:	02010413          	addi	s0,sp,32
    80002424:	00050493          	mv	s1,a0
}
    80002428:	00000097          	auipc	ra,0x0
    8000242c:	c10080e7          	jalr	-1008(ra) # 80002038 <_ZN9SemaphoreD1Ev>
    80002430:	00048513          	mv	a0,s1
    80002434:	00000097          	auipc	ra,0x0
    80002438:	fb4080e7          	jalr	-76(ra) # 800023e8 <_ZN9SemaphoredlEPv>
    8000243c:	01813083          	ld	ra,24(sp)
    80002440:	01013403          	ld	s0,16(sp)
    80002444:	00813483          	ld	s1,8(sp)
    80002448:	02010113          	addi	sp,sp,32
    8000244c:	00008067          	ret

0000000080002450 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002450:	ff010113          	addi	sp,sp,-16
    80002454:	00113423          	sd	ra,8(sp)
    80002458:	00813023          	sd	s0,0(sp)
    8000245c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002460:	00000097          	auipc	ra,0x0
    80002464:	290080e7          	jalr	656(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002468:	00813083          	ld	ra,8(sp)
    8000246c:	00013403          	ld	s0,0(sp)
    80002470:	01010113          	addi	sp,sp,16
    80002474:	00008067          	ret

0000000080002478 <_ZN14PeriodicThreadC1Em>:
    }
}

PeriodicThread::PeriodicThread(time_t period)
    80002478:	fe010113          	addi	sp,sp,-32
    8000247c:	00113c23          	sd	ra,24(sp)
    80002480:	00813823          	sd	s0,16(sp)
    80002484:	00913423          	sd	s1,8(sp)
    80002488:	01213023          	sd	s2,0(sp)
    8000248c:	02010413          	addi	s0,sp,32
    80002490:	00050493          	mv	s1,a0
    80002494:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002498:	02000513          	li	a0,32
    8000249c:	00000097          	auipc	ra,0x0
    800024a0:	bd4080e7          	jalr	-1068(ra) # 80002070 <_Znwm>
    800024a4:	00050613          	mv	a2,a0
    800024a8:	00953023          	sd	s1,0(a0)
    800024ac:	01900793          	li	a5,25
    800024b0:	00f53423          	sd	a5,8(a0)
    800024b4:	00053823          	sd	zero,16(a0)
    800024b8:	01253c23          	sd	s2,24(a0)
    800024bc:	00000597          	auipc	a1,0x0
    800024c0:	e0858593          	addi	a1,a1,-504 # 800022c4 <_Z21periodicThreadWrapperPv>
    800024c4:	00048513          	mv	a0,s1
    800024c8:	00000097          	auipc	ra,0x0
    800024cc:	c48080e7          	jalr	-952(ra) # 80002110 <_ZN6ThreadC1EPFvPvES0_>
    800024d0:	00004797          	auipc	a5,0x4
    800024d4:	b3878793          	addi	a5,a5,-1224 # 80006008 <_ZTV14PeriodicThread+0x10>
    800024d8:	00f4b023          	sd	a5,0(s1)
{}
    800024dc:	01813083          	ld	ra,24(sp)
    800024e0:	01013403          	ld	s0,16(sp)
    800024e4:	00813483          	ld	s1,8(sp)
    800024e8:	00013903          	ld	s2,0(sp)
    800024ec:	02010113          	addi	sp,sp,32
    800024f0:	00008067          	ret

00000000800024f4 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    800024f4:	ff010113          	addi	sp,sp,-16
    800024f8:	00813423          	sd	s0,8(sp)
    800024fc:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002500:	00004797          	auipc	a5,0x4
    80002504:	be07b783          	ld	a5,-1056(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002508:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    8000250c:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002510:	00853783          	ld	a5,8(a0)
    80002514:	04078063          	beqz	a5,80002554 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002518:	00004717          	auipc	a4,0x4
    8000251c:	bc873703          	ld	a4,-1080(a4) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002520:	00073703          	ld	a4,0(a4)
    80002524:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002528:	00853783          	ld	a5,8(a0)
        return nextInList;
    8000252c:	0007b783          	ld	a5,0(a5)
    80002530:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002534:	00004797          	auipc	a5,0x4
    80002538:	bac7b783          	ld	a5,-1108(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000253c:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002540:	00100713          	li	a4,1
    80002544:	02e784a3          	sb	a4,41(a5)
}
    80002548:	00813403          	ld	s0,8(sp)
    8000254c:	01010113          	addi	sp,sp,16
    80002550:	00008067          	ret
        head = tail = PCB::running;
    80002554:	00004797          	auipc	a5,0x4
    80002558:	b8c7b783          	ld	a5,-1140(a5) # 800060e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000255c:	0007b783          	ld	a5,0(a5)
    80002560:	00f53423          	sd	a5,8(a0)
    80002564:	00f53023          	sd	a5,0(a0)
    80002568:	fcdff06f          	j	80002534 <_ZN3SCB5blockEv+0x40>

000000008000256c <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    8000256c:	ff010113          	addi	sp,sp,-16
    80002570:	00813423          	sd	s0,8(sp)
    80002574:	01010413          	addi	s0,sp,16
    80002578:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    8000257c:	00053503          	ld	a0,0(a0)
    80002580:	00050e63          	beqz	a0,8000259c <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    80002584:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80002588:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    8000258c:	0087b683          	ld	a3,8(a5)
    80002590:	00d50c63          	beq	a0,a3,800025a8 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80002594:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80002598:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    8000259c:	00813403          	ld	s0,8(sp)
    800025a0:	01010113          	addi	sp,sp,16
    800025a4:	00008067          	ret
        tail = head;
    800025a8:	00e7b423          	sd	a4,8(a5)
    800025ac:	fe9ff06f          	j	80002594 <_ZN3SCB7unblockEv+0x28>

00000000800025b0 <_ZN3SCB4waitEv>:

bool SCB::wait() {
    if((int)(--semValue)<0) {
    800025b0:	01052783          	lw	a5,16(a0)
    800025b4:	fff7879b          	addiw	a5,a5,-1
    800025b8:	00f52823          	sw	a5,16(a0)
    800025bc:	02079713          	slli	a4,a5,0x20
    800025c0:	00074663          	bltz	a4,800025cc <_ZN3SCB4waitEv+0x1c>
        block();
        return true;
    }
    return false;
    800025c4:	00000513          	li	a0,0
}
    800025c8:	00008067          	ret
bool SCB::wait() {
    800025cc:	ff010113          	addi	sp,sp,-16
    800025d0:	00113423          	sd	ra,8(sp)
    800025d4:	00813023          	sd	s0,0(sp)
    800025d8:	01010413          	addi	s0,sp,16
        block();
    800025dc:	00000097          	auipc	ra,0x0
    800025e0:	f18080e7          	jalr	-232(ra) # 800024f4 <_ZN3SCB5blockEv>
        return true;
    800025e4:	00100513          	li	a0,1
}
    800025e8:	00813083          	ld	ra,8(sp)
    800025ec:	00013403          	ld	s0,0(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret

00000000800025f8 <_ZN3SCB6signalEv>:

PCB* SCB::signal() {
    if((int)(++semValue)<=0) {
    800025f8:	01052783          	lw	a5,16(a0)
    800025fc:	0017879b          	addiw	a5,a5,1
    80002600:	0007871b          	sext.w	a4,a5
    80002604:	00f52823          	sw	a5,16(a0)
    80002608:	00e05663          	blez	a4,80002614 <_ZN3SCB6signalEv+0x1c>
        return unblock();
    }
    return nullptr;
    8000260c:	00000513          	li	a0,0
}
    80002610:	00008067          	ret
PCB* SCB::signal() {
    80002614:	ff010113          	addi	sp,sp,-16
    80002618:	00113423          	sd	ra,8(sp)
    8000261c:	00813023          	sd	s0,0(sp)
    80002620:	01010413          	addi	s0,sp,16
        return unblock();
    80002624:	00000097          	auipc	ra,0x0
    80002628:	f48080e7          	jalr	-184(ra) # 8000256c <_ZN3SCB7unblockEv>
}
    8000262c:	00813083          	ld	ra,8(sp)
    80002630:	00013403          	ld	s0,0(sp)
    80002634:	01010113          	addi	sp,sp,16
    80002638:	00008067          	ret

000000008000263c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000263c:	ff010113          	addi	sp,sp,-16
    80002640:	00113423          	sd	ra,8(sp)
    80002644:	00813023          	sd	s0,0(sp)
    80002648:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000264c:	00000097          	auipc	ra,0x0
    80002650:	0a4080e7          	jalr	164(ra) # 800026f0 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002654:	00813083          	ld	ra,8(sp)
    80002658:	00013403          	ld	s0,0(sp)
    8000265c:	01010113          	addi	sp,sp,16
    80002660:	00008067          	ret

0000000080002664 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002664:	ff010113          	addi	sp,sp,-16
    80002668:	00113423          	sd	ra,8(sp)
    8000266c:	00813023          	sd	s0,0(sp)
    80002670:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002674:	00000097          	auipc	ra,0x0
    80002678:	1e0080e7          	jalr	480(ra) # 80002854 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000267c:	00813083          	ld	ra,8(sp)
    80002680:	00013403          	ld	s0,0(sp)
    80002684:	01010113          	addi	sp,sp,16
    80002688:	00008067          	ret

000000008000268c <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    8000268c:	fe010113          	addi	sp,sp,-32
    80002690:	00113c23          	sd	ra,24(sp)
    80002694:	00813823          	sd	s0,16(sp)
    80002698:	00913423          	sd	s1,8(sp)
    8000269c:	01213023          	sd	s2,0(sp)
    800026a0:	02010413          	addi	s0,sp,32
    800026a4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800026a8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800026ac:	02050263          	beqz	a0,800026d0 <_ZN3SCB13signalClosingEv+0x44>
    }

    void setSemDeleted(bool newState) {
        semDeleted = newState;
    800026b0:	00100793          	li	a5,1
    800026b4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800026b8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800026bc:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800026c0:	fffff097          	auipc	ra,0xfffff
    800026c4:	594080e7          	jalr	1428(ra) # 80001c54 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800026c8:	00048513          	mv	a0,s1
    while(curr) {
    800026cc:	fe1ff06f          	j	800026ac <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    800026d0:	00093423          	sd	zero,8(s2)
    800026d4:	00093023          	sd	zero,0(s2)
}
    800026d8:	01813083          	ld	ra,24(sp)
    800026dc:	01013403          	ld	s0,16(sp)
    800026e0:	00813483          	ld	s1,8(sp)
    800026e4:	00013903          	ld	s2,0(sp)
    800026e8:	02010113          	addi	sp,sp,32
    800026ec:	00008067          	ret

00000000800026f0 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    800026f0:	ff010113          	addi	sp,sp,-16
    800026f4:	00813423          	sd	s0,8(sp)
    800026f8:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800026fc:	00004797          	auipc	a5,0x4
    80002700:	a7c7b783          	ld	a5,-1412(a5) # 80006178 <_ZN15MemoryAllocator4headE>
    80002704:	02078c63          	beqz	a5,8000273c <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002708:	00004717          	auipc	a4,0x4
    8000270c:	9e073703          	ld	a4,-1568(a4) # 800060e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002710:	00073703          	ld	a4,0(a4)
    80002714:	12e78c63          	beq	a5,a4,8000284c <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002718:	00850713          	addi	a4,a0,8
    8000271c:	00675813          	srli	a6,a4,0x6
    80002720:	03f77793          	andi	a5,a4,63
    80002724:	00f037b3          	snez	a5,a5
    80002728:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000272c:	00004517          	auipc	a0,0x4
    80002730:	a4c53503          	ld	a0,-1460(a0) # 80006178 <_ZN15MemoryAllocator4headE>
    80002734:	00000613          	li	a2,0
    80002738:	0a80006f          	j	800027e0 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    8000273c:	00004697          	auipc	a3,0x4
    80002740:	9846b683          	ld	a3,-1660(a3) # 800060c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002744:	0006b783          	ld	a5,0(a3)
    80002748:	00004717          	auipc	a4,0x4
    8000274c:	a2f73823          	sd	a5,-1488(a4) # 80006178 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80002750:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80002754:	00004717          	auipc	a4,0x4
    80002758:	99473703          	ld	a4,-1644(a4) # 800060e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000275c:	00073703          	ld	a4,0(a4)
    80002760:	0006b683          	ld	a3,0(a3)
    80002764:	40d70733          	sub	a4,a4,a3
    80002768:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    8000276c:	0007b823          	sd	zero,16(a5)
    80002770:	fa9ff06f          	j	80002718 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80002774:	00060e63          	beqz	a2,80002790 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002778:	01063703          	ld	a4,16(a2)
    8000277c:	04070a63          	beqz	a4,800027d0 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002780:	01073703          	ld	a4,16(a4)
    80002784:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002788:	00078813          	mv	a6,a5
    8000278c:	0ac0006f          	j	80002838 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002790:	01053703          	ld	a4,16(a0)
    80002794:	00070a63          	beqz	a4,800027a8 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002798:	00004697          	auipc	a3,0x4
    8000279c:	9ee6b023          	sd	a4,-1568(a3) # 80006178 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800027a0:	00078813          	mv	a6,a5
    800027a4:	0940006f          	j	80002838 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    800027a8:	00004717          	auipc	a4,0x4
    800027ac:	94073703          	ld	a4,-1728(a4) # 800060e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800027b0:	00073703          	ld	a4,0(a4)
    800027b4:	00004697          	auipc	a3,0x4
    800027b8:	9ce6b223          	sd	a4,-1596(a3) # 80006178 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800027bc:	00078813          	mv	a6,a5
    800027c0:	0780006f          	j	80002838 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    800027c4:	00004797          	auipc	a5,0x4
    800027c8:	9ae7ba23          	sd	a4,-1612(a5) # 80006178 <_ZN15MemoryAllocator4headE>
    800027cc:	06c0006f          	j	80002838 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    800027d0:	00078813          	mv	a6,a5
    800027d4:	0640006f          	j	80002838 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    800027d8:	00050613          	mv	a2,a0
        curr = curr->next;
    800027dc:	01053503          	ld	a0,16(a0)
    while(curr) {
    800027e0:	06050063          	beqz	a0,80002840 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    800027e4:	00853783          	ld	a5,8(a0)
    800027e8:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    800027ec:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800027f0:	fee7e4e3          	bltu	a5,a4,800027d8 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    800027f4:	ff06e2e3          	bltu	a3,a6,800027d8 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800027f8:	f7068ee3          	beq	a3,a6,80002774 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    800027fc:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002800:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002804:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002808:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    8000280c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002810:	01053783          	ld	a5,16(a0)
    80002814:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002818:	fa0606e3          	beqz	a2,800027c4 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    8000281c:	01063783          	ld	a5,16(a2)
    80002820:	00078663          	beqz	a5,8000282c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002824:	0107b783          	ld	a5,16(a5)
    80002828:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    8000282c:	01063783          	ld	a5,16(a2)
    80002830:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002834:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002838:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    8000283c:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80002840:	00813403          	ld	s0,8(sp)
    80002844:	01010113          	addi	sp,sp,16
    80002848:	00008067          	ret
        return nullptr;
    8000284c:	00000513          	li	a0,0
    80002850:	ff1ff06f          	j	80002840 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080002854 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80002854:	ff010113          	addi	sp,sp,-16
    80002858:	00813423          	sd	s0,8(sp)
    8000285c:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002860:	16050063          	beqz	a0,800029c0 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80002864:	ff850713          	addi	a4,a0,-8
    80002868:	00004797          	auipc	a5,0x4
    8000286c:	8587b783          	ld	a5,-1960(a5) # 800060c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002870:	0007b783          	ld	a5,0(a5)
    80002874:	14f76a63          	bltu	a4,a5,800029c8 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002878:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    8000287c:	fff58693          	addi	a3,a1,-1
    80002880:	00d706b3          	add	a3,a4,a3
    80002884:	00004617          	auipc	a2,0x4
    80002888:	86463603          	ld	a2,-1948(a2) # 800060e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000288c:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002890:	14c6f063          	bgeu	a3,a2,800029d0 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002894:	14070263          	beqz	a4,800029d8 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002898:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    8000289c:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800028a0:	14079063          	bnez	a5,800029e0 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    800028a4:	03f00793          	li	a5,63
    800028a8:	14b7f063          	bgeu	a5,a1,800029e8 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    800028ac:	00004797          	auipc	a5,0x4
    800028b0:	8cc7b783          	ld	a5,-1844(a5) # 80006178 <_ZN15MemoryAllocator4headE>
    800028b4:	02f60063          	beq	a2,a5,800028d4 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    800028b8:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800028bc:	02078a63          	beqz	a5,800028f0 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    800028c0:	0007b683          	ld	a3,0(a5)
    800028c4:	02e6f663          	bgeu	a3,a4,800028f0 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    800028c8:	00078613          	mv	a2,a5
        curr = curr->next;
    800028cc:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800028d0:	fedff06f          	j	800028bc <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    800028d4:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    800028d8:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    800028dc:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    800028e0:	00004797          	auipc	a5,0x4
    800028e4:	88e7bc23          	sd	a4,-1896(a5) # 80006178 <_ZN15MemoryAllocator4headE>
        return 0;
    800028e8:	00000513          	li	a0,0
    800028ec:	0480006f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    800028f0:	04060863          	beqz	a2,80002940 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800028f4:	00063683          	ld	a3,0(a2)
    800028f8:	00863803          	ld	a6,8(a2)
    800028fc:	010686b3          	add	a3,a3,a6
    80002900:	08e68a63          	beq	a3,a4,80002994 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002904:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002908:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000290c:	01063683          	ld	a3,16(a2)
    80002910:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002914:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002918:	0e078063          	beqz	a5,800029f8 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000291c:	0007b583          	ld	a1,0(a5)
    80002920:	00073683          	ld	a3,0(a4)
    80002924:	00873603          	ld	a2,8(a4)
    80002928:	00c686b3          	add	a3,a3,a2
    8000292c:	06d58c63          	beq	a1,a3,800029a4 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80002930:	00000513          	li	a0,0
}
    80002934:	00813403          	ld	s0,8(sp)
    80002938:	01010113          	addi	sp,sp,16
    8000293c:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80002940:	0a078863          	beqz	a5,800029f0 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80002944:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002948:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    8000294c:	00004797          	auipc	a5,0x4
    80002950:	82c7b783          	ld	a5,-2004(a5) # 80006178 <_ZN15MemoryAllocator4headE>
    80002954:	0007b603          	ld	a2,0(a5)
    80002958:	00b706b3          	add	a3,a4,a1
    8000295c:	00d60c63          	beq	a2,a3,80002974 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80002960:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80002964:	00004797          	auipc	a5,0x4
    80002968:	80e7ba23          	sd	a4,-2028(a5) # 80006178 <_ZN15MemoryAllocator4headE>
            return 0;
    8000296c:	00000513          	li	a0,0
    80002970:	fc5ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80002974:	0087b783          	ld	a5,8(a5)
    80002978:	00b785b3          	add	a1,a5,a1
    8000297c:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80002980:	00003797          	auipc	a5,0x3
    80002984:	7f87b783          	ld	a5,2040(a5) # 80006178 <_ZN15MemoryAllocator4headE>
    80002988:	0107b783          	ld	a5,16(a5)
    8000298c:	00f53423          	sd	a5,8(a0)
    80002990:	fd5ff06f          	j	80002964 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002994:	00b805b3          	add	a1,a6,a1
    80002998:	00b63423          	sd	a1,8(a2)
    8000299c:	00060713          	mv	a4,a2
    800029a0:	f79ff06f          	j	80002918 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800029a4:	0087b683          	ld	a3,8(a5)
    800029a8:	00d60633          	add	a2,a2,a3
    800029ac:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800029b0:	0107b783          	ld	a5,16(a5)
    800029b4:	00f73823          	sd	a5,16(a4)
    return 0;
    800029b8:	00000513          	li	a0,0
    800029bc:	f79ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800029c0:	fff00513          	li	a0,-1
    800029c4:	f71ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800029c8:	fff00513          	li	a0,-1
    800029cc:	f69ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800029d0:	fff00513          	li	a0,-1
    800029d4:	f61ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800029d8:	fff00513          	li	a0,-1
    800029dc:	f59ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800029e0:	fff00513          	li	a0,-1
    800029e4:	f51ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800029e8:	fff00513          	li	a0,-1
    800029ec:	f49ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    800029f0:	fff00513          	li	a0,-1
    800029f4:	f41ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    800029f8:	00000513          	li	a0,0
    800029fc:	f39ff06f          	j	80002934 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002a00 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002a00:	fe010113          	addi	sp,sp,-32
    80002a04:	00113c23          	sd	ra,24(sp)
    80002a08:	00813823          	sd	s0,16(sp)
    80002a0c:	00913423          	sd	s1,8(sp)
    80002a10:	02010413          	addi	s0,sp,32
    80002a14:	00050493          	mv	s1,a0
    LOCK();
    80002a18:	00100613          	li	a2,1
    80002a1c:	00000593          	li	a1,0
    80002a20:	00003517          	auipc	a0,0x3
    80002a24:	76050513          	addi	a0,a0,1888 # 80006180 <lockPrint>
    80002a28:	ffffe097          	auipc	ra,0xffffe
    80002a2c:	728080e7          	jalr	1832(ra) # 80001150 <copy_and_swap>
    80002a30:	fe0514e3          	bnez	a0,80002a18 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002a34:	0004c503          	lbu	a0,0(s1)
    80002a38:	00050a63          	beqz	a0,80002a4c <_Z11printStringPKc+0x4c>
    {
        __putc(*string);
    80002a3c:	00002097          	auipc	ra,0x2
    80002a40:	420080e7          	jalr	1056(ra) # 80004e5c <__putc>
        string++;
    80002a44:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002a48:	fedff06f          	j	80002a34 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002a4c:	00000613          	li	a2,0
    80002a50:	00100593          	li	a1,1
    80002a54:	00003517          	auipc	a0,0x3
    80002a58:	72c50513          	addi	a0,a0,1836 # 80006180 <lockPrint>
    80002a5c:	ffffe097          	auipc	ra,0xffffe
    80002a60:	6f4080e7          	jalr	1780(ra) # 80001150 <copy_and_swap>
    80002a64:	fe0514e3          	bnez	a0,80002a4c <_Z11printStringPKc+0x4c>
}
    80002a68:	01813083          	ld	ra,24(sp)
    80002a6c:	01013403          	ld	s0,16(sp)
    80002a70:	00813483          	ld	s1,8(sp)
    80002a74:	02010113          	addi	sp,sp,32
    80002a78:	00008067          	ret

0000000080002a7c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002a7c:	fd010113          	addi	sp,sp,-48
    80002a80:	02113423          	sd	ra,40(sp)
    80002a84:	02813023          	sd	s0,32(sp)
    80002a88:	00913c23          	sd	s1,24(sp)
    80002a8c:	01213823          	sd	s2,16(sp)
    80002a90:	01313423          	sd	s3,8(sp)
    80002a94:	01413023          	sd	s4,0(sp)
    80002a98:	03010413          	addi	s0,sp,48
    80002a9c:	00050993          	mv	s3,a0
    80002aa0:	00058a13          	mv	s4,a1
    LOCK();
    80002aa4:	00100613          	li	a2,1
    80002aa8:	00000593          	li	a1,0
    80002aac:	00003517          	auipc	a0,0x3
    80002ab0:	6d450513          	addi	a0,a0,1748 # 80006180 <lockPrint>
    80002ab4:	ffffe097          	auipc	ra,0xffffe
    80002ab8:	69c080e7          	jalr	1692(ra) # 80001150 <copy_and_swap>
    80002abc:	fe0514e3          	bnez	a0,80002aa4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002ac0:	00000913          	li	s2,0
    80002ac4:	00090493          	mv	s1,s2
    80002ac8:	0019091b          	addiw	s2,s2,1
    80002acc:	03495a63          	bge	s2,s4,80002b00 <_Z9getStringPci+0x84>
        cc = __getc();
    80002ad0:	00002097          	auipc	ra,0x2
    80002ad4:	3c8080e7          	jalr	968(ra) # 80004e98 <__getc>
        if(cc < 1)
    80002ad8:	02050463          	beqz	a0,80002b00 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002adc:	009984b3          	add	s1,s3,s1
    80002ae0:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002ae4:	00a00793          	li	a5,10
    80002ae8:	00f50a63          	beq	a0,a5,80002afc <_Z9getStringPci+0x80>
    80002aec:	00d00793          	li	a5,13
    80002af0:	fcf51ae3          	bne	a0,a5,80002ac4 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002af4:	00090493          	mv	s1,s2
    80002af8:	0080006f          	j	80002b00 <_Z9getStringPci+0x84>
    80002afc:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002b00:	009984b3          	add	s1,s3,s1
    80002b04:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002b08:	00000613          	li	a2,0
    80002b0c:	00100593          	li	a1,1
    80002b10:	00003517          	auipc	a0,0x3
    80002b14:	67050513          	addi	a0,a0,1648 # 80006180 <lockPrint>
    80002b18:	ffffe097          	auipc	ra,0xffffe
    80002b1c:	638080e7          	jalr	1592(ra) # 80001150 <copy_and_swap>
    80002b20:	fe0514e3          	bnez	a0,80002b08 <_Z9getStringPci+0x8c>
    return buf;
}
    80002b24:	00098513          	mv	a0,s3
    80002b28:	02813083          	ld	ra,40(sp)
    80002b2c:	02013403          	ld	s0,32(sp)
    80002b30:	01813483          	ld	s1,24(sp)
    80002b34:	01013903          	ld	s2,16(sp)
    80002b38:	00813983          	ld	s3,8(sp)
    80002b3c:	00013a03          	ld	s4,0(sp)
    80002b40:	03010113          	addi	sp,sp,48
    80002b44:	00008067          	ret

0000000080002b48 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002b48:	ff010113          	addi	sp,sp,-16
    80002b4c:	00813423          	sd	s0,8(sp)
    80002b50:	01010413          	addi	s0,sp,16
    80002b54:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002b58:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002b5c:	0006c603          	lbu	a2,0(a3)
    80002b60:	fd06071b          	addiw	a4,a2,-48
    80002b64:	0ff77713          	andi	a4,a4,255
    80002b68:	00900793          	li	a5,9
    80002b6c:	02e7e063          	bltu	a5,a4,80002b8c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002b70:	0025179b          	slliw	a5,a0,0x2
    80002b74:	00a787bb          	addw	a5,a5,a0
    80002b78:	0017979b          	slliw	a5,a5,0x1
    80002b7c:	00168693          	addi	a3,a3,1
    80002b80:	00c787bb          	addw	a5,a5,a2
    80002b84:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002b88:	fd5ff06f          	j	80002b5c <_Z11stringToIntPKc+0x14>
    return n;
}
    80002b8c:	00813403          	ld	s0,8(sp)
    80002b90:	01010113          	addi	sp,sp,16
    80002b94:	00008067          	ret

0000000080002b98 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002b98:	fc010113          	addi	sp,sp,-64
    80002b9c:	02113c23          	sd	ra,56(sp)
    80002ba0:	02813823          	sd	s0,48(sp)
    80002ba4:	02913423          	sd	s1,40(sp)
    80002ba8:	03213023          	sd	s2,32(sp)
    80002bac:	01313c23          	sd	s3,24(sp)
    80002bb0:	04010413          	addi	s0,sp,64
    80002bb4:	00050493          	mv	s1,a0
    80002bb8:	00058913          	mv	s2,a1
    80002bbc:	00060993          	mv	s3,a2
    LOCK();
    80002bc0:	00100613          	li	a2,1
    80002bc4:	00000593          	li	a1,0
    80002bc8:	00003517          	auipc	a0,0x3
    80002bcc:	5b850513          	addi	a0,a0,1464 # 80006180 <lockPrint>
    80002bd0:	ffffe097          	auipc	ra,0xffffe
    80002bd4:	580080e7          	jalr	1408(ra) # 80001150 <copy_and_swap>
    80002bd8:	fe0514e3          	bnez	a0,80002bc0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002bdc:	00098463          	beqz	s3,80002be4 <_Z8printIntiii+0x4c>
    80002be0:	0804c463          	bltz	s1,80002c68 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002be4:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002be8:	00000593          	li	a1,0
    }

    i = 0;
    80002bec:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002bf0:	0009079b          	sext.w	a5,s2
    80002bf4:	0325773b          	remuw	a4,a0,s2
    80002bf8:	00048613          	mv	a2,s1
    80002bfc:	0014849b          	addiw	s1,s1,1
    80002c00:	02071693          	slli	a3,a4,0x20
    80002c04:	0206d693          	srli	a3,a3,0x20
    80002c08:	00003717          	auipc	a4,0x3
    80002c0c:	49870713          	addi	a4,a4,1176 # 800060a0 <digits>
    80002c10:	00d70733          	add	a4,a4,a3
    80002c14:	00074683          	lbu	a3,0(a4)
    80002c18:	fd040713          	addi	a4,s0,-48
    80002c1c:	00c70733          	add	a4,a4,a2
    80002c20:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002c24:	0005071b          	sext.w	a4,a0
    80002c28:	0325553b          	divuw	a0,a0,s2
    80002c2c:	fcf772e3          	bgeu	a4,a5,80002bf0 <_Z8printIntiii+0x58>
    if(neg)
    80002c30:	00058c63          	beqz	a1,80002c48 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002c34:	fd040793          	addi	a5,s0,-48
    80002c38:	009784b3          	add	s1,a5,s1
    80002c3c:	02d00793          	li	a5,45
    80002c40:	fef48823          	sb	a5,-16(s1)
    80002c44:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002c48:	fff4849b          	addiw	s1,s1,-1
    80002c4c:	0204c463          	bltz	s1,80002c74 <_Z8printIntiii+0xdc>
        __putc(buf[i]);
    80002c50:	fd040793          	addi	a5,s0,-48
    80002c54:	009787b3          	add	a5,a5,s1
    80002c58:	ff07c503          	lbu	a0,-16(a5)
    80002c5c:	00002097          	auipc	ra,0x2
    80002c60:	200080e7          	jalr	512(ra) # 80004e5c <__putc>
    80002c64:	fe5ff06f          	j	80002c48 <_Z8printIntiii+0xb0>
        x = -xx;
    80002c68:	4090053b          	negw	a0,s1
        neg = 1;
    80002c6c:	00100593          	li	a1,1
        x = -xx;
    80002c70:	f7dff06f          	j	80002bec <_Z8printIntiii+0x54>

    UNLOCK();
    80002c74:	00000613          	li	a2,0
    80002c78:	00100593          	li	a1,1
    80002c7c:	00003517          	auipc	a0,0x3
    80002c80:	50450513          	addi	a0,a0,1284 # 80006180 <lockPrint>
    80002c84:	ffffe097          	auipc	ra,0xffffe
    80002c88:	4cc080e7          	jalr	1228(ra) # 80001150 <copy_and_swap>
    80002c8c:	fe0514e3          	bnez	a0,80002c74 <_Z8printIntiii+0xdc>
}
    80002c90:	03813083          	ld	ra,56(sp)
    80002c94:	03013403          	ld	s0,48(sp)
    80002c98:	02813483          	ld	s1,40(sp)
    80002c9c:	02013903          	ld	s2,32(sp)
    80002ca0:	01813983          	ld	s3,24(sp)
    80002ca4:	04010113          	addi	sp,sp,64
    80002ca8:	00008067          	ret

0000000080002cac <_Z10printErrorv>:
void printError() {
    80002cac:	fd010113          	addi	sp,sp,-48
    80002cb0:	02113423          	sd	ra,40(sp)
    80002cb4:	02813023          	sd	s0,32(sp)
    80002cb8:	03010413          	addi	s0,sp,48
    LOCK();
    80002cbc:	00100613          	li	a2,1
    80002cc0:	00000593          	li	a1,0
    80002cc4:	00003517          	auipc	a0,0x3
    80002cc8:	4bc50513          	addi	a0,a0,1212 # 80006180 <lockPrint>
    80002ccc:	ffffe097          	auipc	ra,0xffffe
    80002cd0:	484080e7          	jalr	1156(ra) # 80001150 <copy_and_swap>
    80002cd4:	fe0514e3          	bnez	a0,80002cbc <_Z10printErrorv+0x10>
    printString("scause: ");
    80002cd8:	00002517          	auipc	a0,0x2
    80002cdc:	41850513          	addi	a0,a0,1048 # 800050f0 <CONSOLE_STATUS+0xe0>
    80002ce0:	00000097          	auipc	ra,0x0
    80002ce4:	d20080e7          	jalr	-736(ra) # 80002a00 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002ce8:	142027f3          	csrr	a5,scause
    80002cec:	fef43423          	sd	a5,-24(s0)
        return scause;
    80002cf0:	fe843503          	ld	a0,-24(s0)
    printInt(Kernel::r_scause());
    80002cf4:	00000613          	li	a2,0
    80002cf8:	00a00593          	li	a1,10
    80002cfc:	0005051b          	sext.w	a0,a0
    80002d00:	00000097          	auipc	ra,0x0
    80002d04:	e98080e7          	jalr	-360(ra) # 80002b98 <_Z8printIntiii>
    printString("\nsepc: ");
    80002d08:	00002517          	auipc	a0,0x2
    80002d0c:	3f850513          	addi	a0,a0,1016 # 80005100 <CONSOLE_STATUS+0xf0>
    80002d10:	00000097          	auipc	ra,0x0
    80002d14:	cf0080e7          	jalr	-784(ra) # 80002a00 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002d18:	141027f3          	csrr	a5,sepc
    80002d1c:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80002d20:	fe043503          	ld	a0,-32(s0)
    printInt(Kernel::r_sepc());
    80002d24:	00000613          	li	a2,0
    80002d28:	00a00593          	li	a1,10
    80002d2c:	0005051b          	sext.w	a0,a0
    80002d30:	00000097          	auipc	ra,0x0
    80002d34:	e68080e7          	jalr	-408(ra) # 80002b98 <_Z8printIntiii>
    printString("\nstval: ");
    80002d38:	00002517          	auipc	a0,0x2
    80002d3c:	3d050513          	addi	a0,a0,976 # 80005108 <CONSOLE_STATUS+0xf8>
    80002d40:	00000097          	auipc	ra,0x0
    80002d44:	cc0080e7          	jalr	-832(ra) # 80002a00 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002d48:	143027f3          	csrr	a5,stval
    80002d4c:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    80002d50:	fd843503          	ld	a0,-40(s0)
    printInt(Kernel::r_stval());
    80002d54:	00000613          	li	a2,0
    80002d58:	00a00593          	li	a1,10
    80002d5c:	0005051b          	sext.w	a0,a0
    80002d60:	00000097          	auipc	ra,0x0
    80002d64:	e38080e7          	jalr	-456(ra) # 80002b98 <_Z8printIntiii>
    UNLOCK();
    80002d68:	00000613          	li	a2,0
    80002d6c:	00100593          	li	a1,1
    80002d70:	00003517          	auipc	a0,0x3
    80002d74:	41050513          	addi	a0,a0,1040 # 80006180 <lockPrint>
    80002d78:	ffffe097          	auipc	ra,0xffffe
    80002d7c:	3d8080e7          	jalr	984(ra) # 80001150 <copy_and_swap>
    80002d80:	fe0514e3          	bnez	a0,80002d68 <_Z10printErrorv+0xbc>
    80002d84:	02813083          	ld	ra,40(sp)
    80002d88:	02013403          	ld	s0,32(sp)
    80002d8c:	03010113          	addi	sp,sp,48
    80002d90:	00008067          	ret

0000000080002d94 <start>:
    80002d94:	ff010113          	addi	sp,sp,-16
    80002d98:	00813423          	sd	s0,8(sp)
    80002d9c:	01010413          	addi	s0,sp,16
    80002da0:	300027f3          	csrr	a5,mstatus
    80002da4:	ffffe737          	lui	a4,0xffffe
    80002da8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff740f>
    80002dac:	00e7f7b3          	and	a5,a5,a4
    80002db0:	00001737          	lui	a4,0x1
    80002db4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002db8:	00e7e7b3          	or	a5,a5,a4
    80002dbc:	30079073          	csrw	mstatus,a5
    80002dc0:	00000797          	auipc	a5,0x0
    80002dc4:	16078793          	addi	a5,a5,352 # 80002f20 <system_main>
    80002dc8:	34179073          	csrw	mepc,a5
    80002dcc:	00000793          	li	a5,0
    80002dd0:	18079073          	csrw	satp,a5
    80002dd4:	000107b7          	lui	a5,0x10
    80002dd8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002ddc:	30279073          	csrw	medeleg,a5
    80002de0:	30379073          	csrw	mideleg,a5
    80002de4:	104027f3          	csrr	a5,sie
    80002de8:	2227e793          	ori	a5,a5,546
    80002dec:	10479073          	csrw	sie,a5
    80002df0:	fff00793          	li	a5,-1
    80002df4:	00a7d793          	srli	a5,a5,0xa
    80002df8:	3b079073          	csrw	pmpaddr0,a5
    80002dfc:	00f00793          	li	a5,15
    80002e00:	3a079073          	csrw	pmpcfg0,a5
    80002e04:	f14027f3          	csrr	a5,mhartid
    80002e08:	0200c737          	lui	a4,0x200c
    80002e0c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002e10:	0007869b          	sext.w	a3,a5
    80002e14:	00269713          	slli	a4,a3,0x2
    80002e18:	000f4637          	lui	a2,0xf4
    80002e1c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002e20:	00d70733          	add	a4,a4,a3
    80002e24:	0037979b          	slliw	a5,a5,0x3
    80002e28:	020046b7          	lui	a3,0x2004
    80002e2c:	00d787b3          	add	a5,a5,a3
    80002e30:	00c585b3          	add	a1,a1,a2
    80002e34:	00371693          	slli	a3,a4,0x3
    80002e38:	00003717          	auipc	a4,0x3
    80002e3c:	35870713          	addi	a4,a4,856 # 80006190 <timer_scratch>
    80002e40:	00b7b023          	sd	a1,0(a5)
    80002e44:	00d70733          	add	a4,a4,a3
    80002e48:	00f73c23          	sd	a5,24(a4)
    80002e4c:	02c73023          	sd	a2,32(a4)
    80002e50:	34071073          	csrw	mscratch,a4
    80002e54:	00000797          	auipc	a5,0x0
    80002e58:	6ec78793          	addi	a5,a5,1772 # 80003540 <timervec>
    80002e5c:	30579073          	csrw	mtvec,a5
    80002e60:	300027f3          	csrr	a5,mstatus
    80002e64:	0087e793          	ori	a5,a5,8
    80002e68:	30079073          	csrw	mstatus,a5
    80002e6c:	304027f3          	csrr	a5,mie
    80002e70:	0807e793          	ori	a5,a5,128
    80002e74:	30479073          	csrw	mie,a5
    80002e78:	f14027f3          	csrr	a5,mhartid
    80002e7c:	0007879b          	sext.w	a5,a5
    80002e80:	00078213          	mv	tp,a5
    80002e84:	30200073          	mret
    80002e88:	00813403          	ld	s0,8(sp)
    80002e8c:	01010113          	addi	sp,sp,16
    80002e90:	00008067          	ret

0000000080002e94 <timerinit>:
    80002e94:	ff010113          	addi	sp,sp,-16
    80002e98:	00813423          	sd	s0,8(sp)
    80002e9c:	01010413          	addi	s0,sp,16
    80002ea0:	f14027f3          	csrr	a5,mhartid
    80002ea4:	0200c737          	lui	a4,0x200c
    80002ea8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002eac:	0007869b          	sext.w	a3,a5
    80002eb0:	00269713          	slli	a4,a3,0x2
    80002eb4:	000f4637          	lui	a2,0xf4
    80002eb8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002ebc:	00d70733          	add	a4,a4,a3
    80002ec0:	0037979b          	slliw	a5,a5,0x3
    80002ec4:	020046b7          	lui	a3,0x2004
    80002ec8:	00d787b3          	add	a5,a5,a3
    80002ecc:	00c585b3          	add	a1,a1,a2
    80002ed0:	00371693          	slli	a3,a4,0x3
    80002ed4:	00003717          	auipc	a4,0x3
    80002ed8:	2bc70713          	addi	a4,a4,700 # 80006190 <timer_scratch>
    80002edc:	00b7b023          	sd	a1,0(a5)
    80002ee0:	00d70733          	add	a4,a4,a3
    80002ee4:	00f73c23          	sd	a5,24(a4)
    80002ee8:	02c73023          	sd	a2,32(a4)
    80002eec:	34071073          	csrw	mscratch,a4
    80002ef0:	00000797          	auipc	a5,0x0
    80002ef4:	65078793          	addi	a5,a5,1616 # 80003540 <timervec>
    80002ef8:	30579073          	csrw	mtvec,a5
    80002efc:	300027f3          	csrr	a5,mstatus
    80002f00:	0087e793          	ori	a5,a5,8
    80002f04:	30079073          	csrw	mstatus,a5
    80002f08:	304027f3          	csrr	a5,mie
    80002f0c:	0807e793          	ori	a5,a5,128
    80002f10:	30479073          	csrw	mie,a5
    80002f14:	00813403          	ld	s0,8(sp)
    80002f18:	01010113          	addi	sp,sp,16
    80002f1c:	00008067          	ret

0000000080002f20 <system_main>:
    80002f20:	fe010113          	addi	sp,sp,-32
    80002f24:	00813823          	sd	s0,16(sp)
    80002f28:	00913423          	sd	s1,8(sp)
    80002f2c:	00113c23          	sd	ra,24(sp)
    80002f30:	02010413          	addi	s0,sp,32
    80002f34:	00000097          	auipc	ra,0x0
    80002f38:	0c4080e7          	jalr	196(ra) # 80002ff8 <cpuid>
    80002f3c:	00003497          	auipc	s1,0x3
    80002f40:	1d448493          	addi	s1,s1,468 # 80006110 <started>
    80002f44:	02050263          	beqz	a0,80002f68 <system_main+0x48>
    80002f48:	0004a783          	lw	a5,0(s1)
    80002f4c:	0007879b          	sext.w	a5,a5
    80002f50:	fe078ce3          	beqz	a5,80002f48 <system_main+0x28>
    80002f54:	0ff0000f          	fence
    80002f58:	00002517          	auipc	a0,0x2
    80002f5c:	1f050513          	addi	a0,a0,496 # 80005148 <CONSOLE_STATUS+0x138>
    80002f60:	00001097          	auipc	ra,0x1
    80002f64:	a7c080e7          	jalr	-1412(ra) # 800039dc <panic>
    80002f68:	00001097          	auipc	ra,0x1
    80002f6c:	9d0080e7          	jalr	-1584(ra) # 80003938 <consoleinit>
    80002f70:	00001097          	auipc	ra,0x1
    80002f74:	15c080e7          	jalr	348(ra) # 800040cc <printfinit>
    80002f78:	00002517          	auipc	a0,0x2
    80002f7c:	2b050513          	addi	a0,a0,688 # 80005228 <CONSOLE_STATUS+0x218>
    80002f80:	00001097          	auipc	ra,0x1
    80002f84:	ab8080e7          	jalr	-1352(ra) # 80003a38 <__printf>
    80002f88:	00002517          	auipc	a0,0x2
    80002f8c:	19050513          	addi	a0,a0,400 # 80005118 <CONSOLE_STATUS+0x108>
    80002f90:	00001097          	auipc	ra,0x1
    80002f94:	aa8080e7          	jalr	-1368(ra) # 80003a38 <__printf>
    80002f98:	00002517          	auipc	a0,0x2
    80002f9c:	29050513          	addi	a0,a0,656 # 80005228 <CONSOLE_STATUS+0x218>
    80002fa0:	00001097          	auipc	ra,0x1
    80002fa4:	a98080e7          	jalr	-1384(ra) # 80003a38 <__printf>
    80002fa8:	00001097          	auipc	ra,0x1
    80002fac:	4b0080e7          	jalr	1200(ra) # 80004458 <kinit>
    80002fb0:	00000097          	auipc	ra,0x0
    80002fb4:	148080e7          	jalr	328(ra) # 800030f8 <trapinit>
    80002fb8:	00000097          	auipc	ra,0x0
    80002fbc:	16c080e7          	jalr	364(ra) # 80003124 <trapinithart>
    80002fc0:	00000097          	auipc	ra,0x0
    80002fc4:	5c0080e7          	jalr	1472(ra) # 80003580 <plicinit>
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	5e0080e7          	jalr	1504(ra) # 800035a8 <plicinithart>
    80002fd0:	00000097          	auipc	ra,0x0
    80002fd4:	078080e7          	jalr	120(ra) # 80003048 <userinit>
    80002fd8:	0ff0000f          	fence
    80002fdc:	00100793          	li	a5,1
    80002fe0:	00002517          	auipc	a0,0x2
    80002fe4:	15050513          	addi	a0,a0,336 # 80005130 <CONSOLE_STATUS+0x120>
    80002fe8:	00f4a023          	sw	a5,0(s1)
    80002fec:	00001097          	auipc	ra,0x1
    80002ff0:	a4c080e7          	jalr	-1460(ra) # 80003a38 <__printf>
    80002ff4:	0000006f          	j	80002ff4 <system_main+0xd4>

0000000080002ff8 <cpuid>:
    80002ff8:	ff010113          	addi	sp,sp,-16
    80002ffc:	00813423          	sd	s0,8(sp)
    80003000:	01010413          	addi	s0,sp,16
    80003004:	00020513          	mv	a0,tp
    80003008:	00813403          	ld	s0,8(sp)
    8000300c:	0005051b          	sext.w	a0,a0
    80003010:	01010113          	addi	sp,sp,16
    80003014:	00008067          	ret

0000000080003018 <mycpu>:
    80003018:	ff010113          	addi	sp,sp,-16
    8000301c:	00813423          	sd	s0,8(sp)
    80003020:	01010413          	addi	s0,sp,16
    80003024:	00020793          	mv	a5,tp
    80003028:	00813403          	ld	s0,8(sp)
    8000302c:	0007879b          	sext.w	a5,a5
    80003030:	00779793          	slli	a5,a5,0x7
    80003034:	00004517          	auipc	a0,0x4
    80003038:	18c50513          	addi	a0,a0,396 # 800071c0 <cpus>
    8000303c:	00f50533          	add	a0,a0,a5
    80003040:	01010113          	addi	sp,sp,16
    80003044:	00008067          	ret

0000000080003048 <userinit>:
    80003048:	ff010113          	addi	sp,sp,-16
    8000304c:	00813423          	sd	s0,8(sp)
    80003050:	01010413          	addi	s0,sp,16
    80003054:	00813403          	ld	s0,8(sp)
    80003058:	01010113          	addi	sp,sp,16
    8000305c:	fffff317          	auipc	t1,0xfffff
    80003060:	cb430067          	jr	-844(t1) # 80001d10 <main>

0000000080003064 <either_copyout>:
    80003064:	ff010113          	addi	sp,sp,-16
    80003068:	00813023          	sd	s0,0(sp)
    8000306c:	00113423          	sd	ra,8(sp)
    80003070:	01010413          	addi	s0,sp,16
    80003074:	02051663          	bnez	a0,800030a0 <either_copyout+0x3c>
    80003078:	00058513          	mv	a0,a1
    8000307c:	00060593          	mv	a1,a2
    80003080:	0006861b          	sext.w	a2,a3
    80003084:	00002097          	auipc	ra,0x2
    80003088:	c60080e7          	jalr	-928(ra) # 80004ce4 <__memmove>
    8000308c:	00813083          	ld	ra,8(sp)
    80003090:	00013403          	ld	s0,0(sp)
    80003094:	00000513          	li	a0,0
    80003098:	01010113          	addi	sp,sp,16
    8000309c:	00008067          	ret
    800030a0:	00002517          	auipc	a0,0x2
    800030a4:	0d050513          	addi	a0,a0,208 # 80005170 <CONSOLE_STATUS+0x160>
    800030a8:	00001097          	auipc	ra,0x1
    800030ac:	934080e7          	jalr	-1740(ra) # 800039dc <panic>

00000000800030b0 <either_copyin>:
    800030b0:	ff010113          	addi	sp,sp,-16
    800030b4:	00813023          	sd	s0,0(sp)
    800030b8:	00113423          	sd	ra,8(sp)
    800030bc:	01010413          	addi	s0,sp,16
    800030c0:	02059463          	bnez	a1,800030e8 <either_copyin+0x38>
    800030c4:	00060593          	mv	a1,a2
    800030c8:	0006861b          	sext.w	a2,a3
    800030cc:	00002097          	auipc	ra,0x2
    800030d0:	c18080e7          	jalr	-1000(ra) # 80004ce4 <__memmove>
    800030d4:	00813083          	ld	ra,8(sp)
    800030d8:	00013403          	ld	s0,0(sp)
    800030dc:	00000513          	li	a0,0
    800030e0:	01010113          	addi	sp,sp,16
    800030e4:	00008067          	ret
    800030e8:	00002517          	auipc	a0,0x2
    800030ec:	0b050513          	addi	a0,a0,176 # 80005198 <CONSOLE_STATUS+0x188>
    800030f0:	00001097          	auipc	ra,0x1
    800030f4:	8ec080e7          	jalr	-1812(ra) # 800039dc <panic>

00000000800030f8 <trapinit>:
    800030f8:	ff010113          	addi	sp,sp,-16
    800030fc:	00813423          	sd	s0,8(sp)
    80003100:	01010413          	addi	s0,sp,16
    80003104:	00813403          	ld	s0,8(sp)
    80003108:	00002597          	auipc	a1,0x2
    8000310c:	0b858593          	addi	a1,a1,184 # 800051c0 <CONSOLE_STATUS+0x1b0>
    80003110:	00004517          	auipc	a0,0x4
    80003114:	13050513          	addi	a0,a0,304 # 80007240 <tickslock>
    80003118:	01010113          	addi	sp,sp,16
    8000311c:	00001317          	auipc	t1,0x1
    80003120:	5cc30067          	jr	1484(t1) # 800046e8 <initlock>

0000000080003124 <trapinithart>:
    80003124:	ff010113          	addi	sp,sp,-16
    80003128:	00813423          	sd	s0,8(sp)
    8000312c:	01010413          	addi	s0,sp,16
    80003130:	00000797          	auipc	a5,0x0
    80003134:	30078793          	addi	a5,a5,768 # 80003430 <kernelvec>
    80003138:	10579073          	csrw	stvec,a5
    8000313c:	00813403          	ld	s0,8(sp)
    80003140:	01010113          	addi	sp,sp,16
    80003144:	00008067          	ret

0000000080003148 <usertrap>:
    80003148:	ff010113          	addi	sp,sp,-16
    8000314c:	00813423          	sd	s0,8(sp)
    80003150:	01010413          	addi	s0,sp,16
    80003154:	00813403          	ld	s0,8(sp)
    80003158:	01010113          	addi	sp,sp,16
    8000315c:	00008067          	ret

0000000080003160 <usertrapret>:
    80003160:	ff010113          	addi	sp,sp,-16
    80003164:	00813423          	sd	s0,8(sp)
    80003168:	01010413          	addi	s0,sp,16
    8000316c:	00813403          	ld	s0,8(sp)
    80003170:	01010113          	addi	sp,sp,16
    80003174:	00008067          	ret

0000000080003178 <kerneltrap>:
    80003178:	fe010113          	addi	sp,sp,-32
    8000317c:	00813823          	sd	s0,16(sp)
    80003180:	00113c23          	sd	ra,24(sp)
    80003184:	00913423          	sd	s1,8(sp)
    80003188:	02010413          	addi	s0,sp,32
    8000318c:	142025f3          	csrr	a1,scause
    80003190:	100027f3          	csrr	a5,sstatus
    80003194:	0027f793          	andi	a5,a5,2
    80003198:	10079c63          	bnez	a5,800032b0 <kerneltrap+0x138>
    8000319c:	142027f3          	csrr	a5,scause
    800031a0:	0207ce63          	bltz	a5,800031dc <kerneltrap+0x64>
    800031a4:	00002517          	auipc	a0,0x2
    800031a8:	06450513          	addi	a0,a0,100 # 80005208 <CONSOLE_STATUS+0x1f8>
    800031ac:	00001097          	auipc	ra,0x1
    800031b0:	88c080e7          	jalr	-1908(ra) # 80003a38 <__printf>
    800031b4:	141025f3          	csrr	a1,sepc
    800031b8:	14302673          	csrr	a2,stval
    800031bc:	00002517          	auipc	a0,0x2
    800031c0:	05c50513          	addi	a0,a0,92 # 80005218 <CONSOLE_STATUS+0x208>
    800031c4:	00001097          	auipc	ra,0x1
    800031c8:	874080e7          	jalr	-1932(ra) # 80003a38 <__printf>
    800031cc:	00002517          	auipc	a0,0x2
    800031d0:	06450513          	addi	a0,a0,100 # 80005230 <CONSOLE_STATUS+0x220>
    800031d4:	00001097          	auipc	ra,0x1
    800031d8:	808080e7          	jalr	-2040(ra) # 800039dc <panic>
    800031dc:	0ff7f713          	andi	a4,a5,255
    800031e0:	00900693          	li	a3,9
    800031e4:	04d70063          	beq	a4,a3,80003224 <kerneltrap+0xac>
    800031e8:	fff00713          	li	a4,-1
    800031ec:	03f71713          	slli	a4,a4,0x3f
    800031f0:	00170713          	addi	a4,a4,1
    800031f4:	fae798e3          	bne	a5,a4,800031a4 <kerneltrap+0x2c>
    800031f8:	00000097          	auipc	ra,0x0
    800031fc:	e00080e7          	jalr	-512(ra) # 80002ff8 <cpuid>
    80003200:	06050663          	beqz	a0,8000326c <kerneltrap+0xf4>
    80003204:	144027f3          	csrr	a5,sip
    80003208:	ffd7f793          	andi	a5,a5,-3
    8000320c:	14479073          	csrw	sip,a5
    80003210:	01813083          	ld	ra,24(sp)
    80003214:	01013403          	ld	s0,16(sp)
    80003218:	00813483          	ld	s1,8(sp)
    8000321c:	02010113          	addi	sp,sp,32
    80003220:	00008067          	ret
    80003224:	00000097          	auipc	ra,0x0
    80003228:	3d0080e7          	jalr	976(ra) # 800035f4 <plic_claim>
    8000322c:	00a00793          	li	a5,10
    80003230:	00050493          	mv	s1,a0
    80003234:	06f50863          	beq	a0,a5,800032a4 <kerneltrap+0x12c>
    80003238:	fc050ce3          	beqz	a0,80003210 <kerneltrap+0x98>
    8000323c:	00050593          	mv	a1,a0
    80003240:	00002517          	auipc	a0,0x2
    80003244:	fa850513          	addi	a0,a0,-88 # 800051e8 <CONSOLE_STATUS+0x1d8>
    80003248:	00000097          	auipc	ra,0x0
    8000324c:	7f0080e7          	jalr	2032(ra) # 80003a38 <__printf>
    80003250:	01013403          	ld	s0,16(sp)
    80003254:	01813083          	ld	ra,24(sp)
    80003258:	00048513          	mv	a0,s1
    8000325c:	00813483          	ld	s1,8(sp)
    80003260:	02010113          	addi	sp,sp,32
    80003264:	00000317          	auipc	t1,0x0
    80003268:	3c830067          	jr	968(t1) # 8000362c <plic_complete>
    8000326c:	00004517          	auipc	a0,0x4
    80003270:	fd450513          	addi	a0,a0,-44 # 80007240 <tickslock>
    80003274:	00001097          	auipc	ra,0x1
    80003278:	498080e7          	jalr	1176(ra) # 8000470c <acquire>
    8000327c:	00003717          	auipc	a4,0x3
    80003280:	e9870713          	addi	a4,a4,-360 # 80006114 <ticks>
    80003284:	00072783          	lw	a5,0(a4)
    80003288:	00004517          	auipc	a0,0x4
    8000328c:	fb850513          	addi	a0,a0,-72 # 80007240 <tickslock>
    80003290:	0017879b          	addiw	a5,a5,1
    80003294:	00f72023          	sw	a5,0(a4)
    80003298:	00001097          	auipc	ra,0x1
    8000329c:	540080e7          	jalr	1344(ra) # 800047d8 <release>
    800032a0:	f65ff06f          	j	80003204 <kerneltrap+0x8c>
    800032a4:	00001097          	auipc	ra,0x1
    800032a8:	09c080e7          	jalr	156(ra) # 80004340 <uartintr>
    800032ac:	fa5ff06f          	j	80003250 <kerneltrap+0xd8>
    800032b0:	00002517          	auipc	a0,0x2
    800032b4:	f1850513          	addi	a0,a0,-232 # 800051c8 <CONSOLE_STATUS+0x1b8>
    800032b8:	00000097          	auipc	ra,0x0
    800032bc:	724080e7          	jalr	1828(ra) # 800039dc <panic>

00000000800032c0 <clockintr>:
    800032c0:	fe010113          	addi	sp,sp,-32
    800032c4:	00813823          	sd	s0,16(sp)
    800032c8:	00913423          	sd	s1,8(sp)
    800032cc:	00113c23          	sd	ra,24(sp)
    800032d0:	02010413          	addi	s0,sp,32
    800032d4:	00004497          	auipc	s1,0x4
    800032d8:	f6c48493          	addi	s1,s1,-148 # 80007240 <tickslock>
    800032dc:	00048513          	mv	a0,s1
    800032e0:	00001097          	auipc	ra,0x1
    800032e4:	42c080e7          	jalr	1068(ra) # 8000470c <acquire>
    800032e8:	00003717          	auipc	a4,0x3
    800032ec:	e2c70713          	addi	a4,a4,-468 # 80006114 <ticks>
    800032f0:	00072783          	lw	a5,0(a4)
    800032f4:	01013403          	ld	s0,16(sp)
    800032f8:	01813083          	ld	ra,24(sp)
    800032fc:	00048513          	mv	a0,s1
    80003300:	0017879b          	addiw	a5,a5,1
    80003304:	00813483          	ld	s1,8(sp)
    80003308:	00f72023          	sw	a5,0(a4)
    8000330c:	02010113          	addi	sp,sp,32
    80003310:	00001317          	auipc	t1,0x1
    80003314:	4c830067          	jr	1224(t1) # 800047d8 <release>

0000000080003318 <devintr>:
    80003318:	142027f3          	csrr	a5,scause
    8000331c:	00000513          	li	a0,0
    80003320:	0007c463          	bltz	a5,80003328 <devintr+0x10>
    80003324:	00008067          	ret
    80003328:	fe010113          	addi	sp,sp,-32
    8000332c:	00813823          	sd	s0,16(sp)
    80003330:	00113c23          	sd	ra,24(sp)
    80003334:	00913423          	sd	s1,8(sp)
    80003338:	02010413          	addi	s0,sp,32
    8000333c:	0ff7f713          	andi	a4,a5,255
    80003340:	00900693          	li	a3,9
    80003344:	04d70c63          	beq	a4,a3,8000339c <devintr+0x84>
    80003348:	fff00713          	li	a4,-1
    8000334c:	03f71713          	slli	a4,a4,0x3f
    80003350:	00170713          	addi	a4,a4,1
    80003354:	00e78c63          	beq	a5,a4,8000336c <devintr+0x54>
    80003358:	01813083          	ld	ra,24(sp)
    8000335c:	01013403          	ld	s0,16(sp)
    80003360:	00813483          	ld	s1,8(sp)
    80003364:	02010113          	addi	sp,sp,32
    80003368:	00008067          	ret
    8000336c:	00000097          	auipc	ra,0x0
    80003370:	c8c080e7          	jalr	-884(ra) # 80002ff8 <cpuid>
    80003374:	06050663          	beqz	a0,800033e0 <devintr+0xc8>
    80003378:	144027f3          	csrr	a5,sip
    8000337c:	ffd7f793          	andi	a5,a5,-3
    80003380:	14479073          	csrw	sip,a5
    80003384:	01813083          	ld	ra,24(sp)
    80003388:	01013403          	ld	s0,16(sp)
    8000338c:	00813483          	ld	s1,8(sp)
    80003390:	00200513          	li	a0,2
    80003394:	02010113          	addi	sp,sp,32
    80003398:	00008067          	ret
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	258080e7          	jalr	600(ra) # 800035f4 <plic_claim>
    800033a4:	00a00793          	li	a5,10
    800033a8:	00050493          	mv	s1,a0
    800033ac:	06f50663          	beq	a0,a5,80003418 <devintr+0x100>
    800033b0:	00100513          	li	a0,1
    800033b4:	fa0482e3          	beqz	s1,80003358 <devintr+0x40>
    800033b8:	00048593          	mv	a1,s1
    800033bc:	00002517          	auipc	a0,0x2
    800033c0:	e2c50513          	addi	a0,a0,-468 # 800051e8 <CONSOLE_STATUS+0x1d8>
    800033c4:	00000097          	auipc	ra,0x0
    800033c8:	674080e7          	jalr	1652(ra) # 80003a38 <__printf>
    800033cc:	00048513          	mv	a0,s1
    800033d0:	00000097          	auipc	ra,0x0
    800033d4:	25c080e7          	jalr	604(ra) # 8000362c <plic_complete>
    800033d8:	00100513          	li	a0,1
    800033dc:	f7dff06f          	j	80003358 <devintr+0x40>
    800033e0:	00004517          	auipc	a0,0x4
    800033e4:	e6050513          	addi	a0,a0,-416 # 80007240 <tickslock>
    800033e8:	00001097          	auipc	ra,0x1
    800033ec:	324080e7          	jalr	804(ra) # 8000470c <acquire>
    800033f0:	00003717          	auipc	a4,0x3
    800033f4:	d2470713          	addi	a4,a4,-732 # 80006114 <ticks>
    800033f8:	00072783          	lw	a5,0(a4)
    800033fc:	00004517          	auipc	a0,0x4
    80003400:	e4450513          	addi	a0,a0,-444 # 80007240 <tickslock>
    80003404:	0017879b          	addiw	a5,a5,1
    80003408:	00f72023          	sw	a5,0(a4)
    8000340c:	00001097          	auipc	ra,0x1
    80003410:	3cc080e7          	jalr	972(ra) # 800047d8 <release>
    80003414:	f65ff06f          	j	80003378 <devintr+0x60>
    80003418:	00001097          	auipc	ra,0x1
    8000341c:	f28080e7          	jalr	-216(ra) # 80004340 <uartintr>
    80003420:	fadff06f          	j	800033cc <devintr+0xb4>
	...

0000000080003430 <kernelvec>:
    80003430:	f0010113          	addi	sp,sp,-256
    80003434:	00113023          	sd	ra,0(sp)
    80003438:	00213423          	sd	sp,8(sp)
    8000343c:	00313823          	sd	gp,16(sp)
    80003440:	00413c23          	sd	tp,24(sp)
    80003444:	02513023          	sd	t0,32(sp)
    80003448:	02613423          	sd	t1,40(sp)
    8000344c:	02713823          	sd	t2,48(sp)
    80003450:	02813c23          	sd	s0,56(sp)
    80003454:	04913023          	sd	s1,64(sp)
    80003458:	04a13423          	sd	a0,72(sp)
    8000345c:	04b13823          	sd	a1,80(sp)
    80003460:	04c13c23          	sd	a2,88(sp)
    80003464:	06d13023          	sd	a3,96(sp)
    80003468:	06e13423          	sd	a4,104(sp)
    8000346c:	06f13823          	sd	a5,112(sp)
    80003470:	07013c23          	sd	a6,120(sp)
    80003474:	09113023          	sd	a7,128(sp)
    80003478:	09213423          	sd	s2,136(sp)
    8000347c:	09313823          	sd	s3,144(sp)
    80003480:	09413c23          	sd	s4,152(sp)
    80003484:	0b513023          	sd	s5,160(sp)
    80003488:	0b613423          	sd	s6,168(sp)
    8000348c:	0b713823          	sd	s7,176(sp)
    80003490:	0b813c23          	sd	s8,184(sp)
    80003494:	0d913023          	sd	s9,192(sp)
    80003498:	0da13423          	sd	s10,200(sp)
    8000349c:	0db13823          	sd	s11,208(sp)
    800034a0:	0dc13c23          	sd	t3,216(sp)
    800034a4:	0fd13023          	sd	t4,224(sp)
    800034a8:	0fe13423          	sd	t5,232(sp)
    800034ac:	0ff13823          	sd	t6,240(sp)
    800034b0:	cc9ff0ef          	jal	ra,80003178 <kerneltrap>
    800034b4:	00013083          	ld	ra,0(sp)
    800034b8:	00813103          	ld	sp,8(sp)
    800034bc:	01013183          	ld	gp,16(sp)
    800034c0:	02013283          	ld	t0,32(sp)
    800034c4:	02813303          	ld	t1,40(sp)
    800034c8:	03013383          	ld	t2,48(sp)
    800034cc:	03813403          	ld	s0,56(sp)
    800034d0:	04013483          	ld	s1,64(sp)
    800034d4:	04813503          	ld	a0,72(sp)
    800034d8:	05013583          	ld	a1,80(sp)
    800034dc:	05813603          	ld	a2,88(sp)
    800034e0:	06013683          	ld	a3,96(sp)
    800034e4:	06813703          	ld	a4,104(sp)
    800034e8:	07013783          	ld	a5,112(sp)
    800034ec:	07813803          	ld	a6,120(sp)
    800034f0:	08013883          	ld	a7,128(sp)
    800034f4:	08813903          	ld	s2,136(sp)
    800034f8:	09013983          	ld	s3,144(sp)
    800034fc:	09813a03          	ld	s4,152(sp)
    80003500:	0a013a83          	ld	s5,160(sp)
    80003504:	0a813b03          	ld	s6,168(sp)
    80003508:	0b013b83          	ld	s7,176(sp)
    8000350c:	0b813c03          	ld	s8,184(sp)
    80003510:	0c013c83          	ld	s9,192(sp)
    80003514:	0c813d03          	ld	s10,200(sp)
    80003518:	0d013d83          	ld	s11,208(sp)
    8000351c:	0d813e03          	ld	t3,216(sp)
    80003520:	0e013e83          	ld	t4,224(sp)
    80003524:	0e813f03          	ld	t5,232(sp)
    80003528:	0f013f83          	ld	t6,240(sp)
    8000352c:	10010113          	addi	sp,sp,256
    80003530:	10200073          	sret
    80003534:	00000013          	nop
    80003538:	00000013          	nop
    8000353c:	00000013          	nop

0000000080003540 <timervec>:
    80003540:	34051573          	csrrw	a0,mscratch,a0
    80003544:	00b53023          	sd	a1,0(a0)
    80003548:	00c53423          	sd	a2,8(a0)
    8000354c:	00d53823          	sd	a3,16(a0)
    80003550:	01853583          	ld	a1,24(a0)
    80003554:	02053603          	ld	a2,32(a0)
    80003558:	0005b683          	ld	a3,0(a1)
    8000355c:	00c686b3          	add	a3,a3,a2
    80003560:	00d5b023          	sd	a3,0(a1)
    80003564:	00200593          	li	a1,2
    80003568:	14459073          	csrw	sip,a1
    8000356c:	01053683          	ld	a3,16(a0)
    80003570:	00853603          	ld	a2,8(a0)
    80003574:	00053583          	ld	a1,0(a0)
    80003578:	34051573          	csrrw	a0,mscratch,a0
    8000357c:	30200073          	mret

0000000080003580 <plicinit>:
    80003580:	ff010113          	addi	sp,sp,-16
    80003584:	00813423          	sd	s0,8(sp)
    80003588:	01010413          	addi	s0,sp,16
    8000358c:	00813403          	ld	s0,8(sp)
    80003590:	0c0007b7          	lui	a5,0xc000
    80003594:	00100713          	li	a4,1
    80003598:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000359c:	00e7a223          	sw	a4,4(a5)
    800035a0:	01010113          	addi	sp,sp,16
    800035a4:	00008067          	ret

00000000800035a8 <plicinithart>:
    800035a8:	ff010113          	addi	sp,sp,-16
    800035ac:	00813023          	sd	s0,0(sp)
    800035b0:	00113423          	sd	ra,8(sp)
    800035b4:	01010413          	addi	s0,sp,16
    800035b8:	00000097          	auipc	ra,0x0
    800035bc:	a40080e7          	jalr	-1472(ra) # 80002ff8 <cpuid>
    800035c0:	0085171b          	slliw	a4,a0,0x8
    800035c4:	0c0027b7          	lui	a5,0xc002
    800035c8:	00e787b3          	add	a5,a5,a4
    800035cc:	40200713          	li	a4,1026
    800035d0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800035d4:	00813083          	ld	ra,8(sp)
    800035d8:	00013403          	ld	s0,0(sp)
    800035dc:	00d5151b          	slliw	a0,a0,0xd
    800035e0:	0c2017b7          	lui	a5,0xc201
    800035e4:	00a78533          	add	a0,a5,a0
    800035e8:	00052023          	sw	zero,0(a0)
    800035ec:	01010113          	addi	sp,sp,16
    800035f0:	00008067          	ret

00000000800035f4 <plic_claim>:
    800035f4:	ff010113          	addi	sp,sp,-16
    800035f8:	00813023          	sd	s0,0(sp)
    800035fc:	00113423          	sd	ra,8(sp)
    80003600:	01010413          	addi	s0,sp,16
    80003604:	00000097          	auipc	ra,0x0
    80003608:	9f4080e7          	jalr	-1548(ra) # 80002ff8 <cpuid>
    8000360c:	00813083          	ld	ra,8(sp)
    80003610:	00013403          	ld	s0,0(sp)
    80003614:	00d5151b          	slliw	a0,a0,0xd
    80003618:	0c2017b7          	lui	a5,0xc201
    8000361c:	00a78533          	add	a0,a5,a0
    80003620:	00452503          	lw	a0,4(a0)
    80003624:	01010113          	addi	sp,sp,16
    80003628:	00008067          	ret

000000008000362c <plic_complete>:
    8000362c:	fe010113          	addi	sp,sp,-32
    80003630:	00813823          	sd	s0,16(sp)
    80003634:	00913423          	sd	s1,8(sp)
    80003638:	00113c23          	sd	ra,24(sp)
    8000363c:	02010413          	addi	s0,sp,32
    80003640:	00050493          	mv	s1,a0
    80003644:	00000097          	auipc	ra,0x0
    80003648:	9b4080e7          	jalr	-1612(ra) # 80002ff8 <cpuid>
    8000364c:	01813083          	ld	ra,24(sp)
    80003650:	01013403          	ld	s0,16(sp)
    80003654:	00d5179b          	slliw	a5,a0,0xd
    80003658:	0c201737          	lui	a4,0xc201
    8000365c:	00f707b3          	add	a5,a4,a5
    80003660:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003664:	00813483          	ld	s1,8(sp)
    80003668:	02010113          	addi	sp,sp,32
    8000366c:	00008067          	ret

0000000080003670 <consolewrite>:
    80003670:	fb010113          	addi	sp,sp,-80
    80003674:	04813023          	sd	s0,64(sp)
    80003678:	04113423          	sd	ra,72(sp)
    8000367c:	02913c23          	sd	s1,56(sp)
    80003680:	03213823          	sd	s2,48(sp)
    80003684:	03313423          	sd	s3,40(sp)
    80003688:	03413023          	sd	s4,32(sp)
    8000368c:	01513c23          	sd	s5,24(sp)
    80003690:	05010413          	addi	s0,sp,80
    80003694:	06c05c63          	blez	a2,8000370c <consolewrite+0x9c>
    80003698:	00060993          	mv	s3,a2
    8000369c:	00050a13          	mv	s4,a0
    800036a0:	00058493          	mv	s1,a1
    800036a4:	00000913          	li	s2,0
    800036a8:	fff00a93          	li	s5,-1
    800036ac:	01c0006f          	j	800036c8 <consolewrite+0x58>
    800036b0:	fbf44503          	lbu	a0,-65(s0)
    800036b4:	0019091b          	addiw	s2,s2,1
    800036b8:	00148493          	addi	s1,s1,1
    800036bc:	00001097          	auipc	ra,0x1
    800036c0:	a9c080e7          	jalr	-1380(ra) # 80004158 <uartputc>
    800036c4:	03298063          	beq	s3,s2,800036e4 <consolewrite+0x74>
    800036c8:	00048613          	mv	a2,s1
    800036cc:	00100693          	li	a3,1
    800036d0:	000a0593          	mv	a1,s4
    800036d4:	fbf40513          	addi	a0,s0,-65
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	9d8080e7          	jalr	-1576(ra) # 800030b0 <either_copyin>
    800036e0:	fd5518e3          	bne	a0,s5,800036b0 <consolewrite+0x40>
    800036e4:	04813083          	ld	ra,72(sp)
    800036e8:	04013403          	ld	s0,64(sp)
    800036ec:	03813483          	ld	s1,56(sp)
    800036f0:	02813983          	ld	s3,40(sp)
    800036f4:	02013a03          	ld	s4,32(sp)
    800036f8:	01813a83          	ld	s5,24(sp)
    800036fc:	00090513          	mv	a0,s2
    80003700:	03013903          	ld	s2,48(sp)
    80003704:	05010113          	addi	sp,sp,80
    80003708:	00008067          	ret
    8000370c:	00000913          	li	s2,0
    80003710:	fd5ff06f          	j	800036e4 <consolewrite+0x74>

0000000080003714 <consoleread>:
    80003714:	f9010113          	addi	sp,sp,-112
    80003718:	06813023          	sd	s0,96(sp)
    8000371c:	04913c23          	sd	s1,88(sp)
    80003720:	05213823          	sd	s2,80(sp)
    80003724:	05313423          	sd	s3,72(sp)
    80003728:	05413023          	sd	s4,64(sp)
    8000372c:	03513c23          	sd	s5,56(sp)
    80003730:	03613823          	sd	s6,48(sp)
    80003734:	03713423          	sd	s7,40(sp)
    80003738:	03813023          	sd	s8,32(sp)
    8000373c:	06113423          	sd	ra,104(sp)
    80003740:	01913c23          	sd	s9,24(sp)
    80003744:	07010413          	addi	s0,sp,112
    80003748:	00060b93          	mv	s7,a2
    8000374c:	00050913          	mv	s2,a0
    80003750:	00058c13          	mv	s8,a1
    80003754:	00060b1b          	sext.w	s6,a2
    80003758:	00004497          	auipc	s1,0x4
    8000375c:	b1048493          	addi	s1,s1,-1264 # 80007268 <cons>
    80003760:	00400993          	li	s3,4
    80003764:	fff00a13          	li	s4,-1
    80003768:	00a00a93          	li	s5,10
    8000376c:	05705e63          	blez	s7,800037c8 <consoleread+0xb4>
    80003770:	09c4a703          	lw	a4,156(s1)
    80003774:	0984a783          	lw	a5,152(s1)
    80003778:	0007071b          	sext.w	a4,a4
    8000377c:	08e78463          	beq	a5,a4,80003804 <consoleread+0xf0>
    80003780:	07f7f713          	andi	a4,a5,127
    80003784:	00e48733          	add	a4,s1,a4
    80003788:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000378c:	0017869b          	addiw	a3,a5,1
    80003790:	08d4ac23          	sw	a3,152(s1)
    80003794:	00070c9b          	sext.w	s9,a4
    80003798:	0b370663          	beq	a4,s3,80003844 <consoleread+0x130>
    8000379c:	00100693          	li	a3,1
    800037a0:	f9f40613          	addi	a2,s0,-97
    800037a4:	000c0593          	mv	a1,s8
    800037a8:	00090513          	mv	a0,s2
    800037ac:	f8e40fa3          	sb	a4,-97(s0)
    800037b0:	00000097          	auipc	ra,0x0
    800037b4:	8b4080e7          	jalr	-1868(ra) # 80003064 <either_copyout>
    800037b8:	01450863          	beq	a0,s4,800037c8 <consoleread+0xb4>
    800037bc:	001c0c13          	addi	s8,s8,1
    800037c0:	fffb8b9b          	addiw	s7,s7,-1
    800037c4:	fb5c94e3          	bne	s9,s5,8000376c <consoleread+0x58>
    800037c8:	000b851b          	sext.w	a0,s7
    800037cc:	06813083          	ld	ra,104(sp)
    800037d0:	06013403          	ld	s0,96(sp)
    800037d4:	05813483          	ld	s1,88(sp)
    800037d8:	05013903          	ld	s2,80(sp)
    800037dc:	04813983          	ld	s3,72(sp)
    800037e0:	04013a03          	ld	s4,64(sp)
    800037e4:	03813a83          	ld	s5,56(sp)
    800037e8:	02813b83          	ld	s7,40(sp)
    800037ec:	02013c03          	ld	s8,32(sp)
    800037f0:	01813c83          	ld	s9,24(sp)
    800037f4:	40ab053b          	subw	a0,s6,a0
    800037f8:	03013b03          	ld	s6,48(sp)
    800037fc:	07010113          	addi	sp,sp,112
    80003800:	00008067          	ret
    80003804:	00001097          	auipc	ra,0x1
    80003808:	1d8080e7          	jalr	472(ra) # 800049dc <push_on>
    8000380c:	0984a703          	lw	a4,152(s1)
    80003810:	09c4a783          	lw	a5,156(s1)
    80003814:	0007879b          	sext.w	a5,a5
    80003818:	fef70ce3          	beq	a4,a5,80003810 <consoleread+0xfc>
    8000381c:	00001097          	auipc	ra,0x1
    80003820:	234080e7          	jalr	564(ra) # 80004a50 <pop_on>
    80003824:	0984a783          	lw	a5,152(s1)
    80003828:	07f7f713          	andi	a4,a5,127
    8000382c:	00e48733          	add	a4,s1,a4
    80003830:	01874703          	lbu	a4,24(a4)
    80003834:	0017869b          	addiw	a3,a5,1
    80003838:	08d4ac23          	sw	a3,152(s1)
    8000383c:	00070c9b          	sext.w	s9,a4
    80003840:	f5371ee3          	bne	a4,s3,8000379c <consoleread+0x88>
    80003844:	000b851b          	sext.w	a0,s7
    80003848:	f96bf2e3          	bgeu	s7,s6,800037cc <consoleread+0xb8>
    8000384c:	08f4ac23          	sw	a5,152(s1)
    80003850:	f7dff06f          	j	800037cc <consoleread+0xb8>

0000000080003854 <consputc>:
    80003854:	10000793          	li	a5,256
    80003858:	00f50663          	beq	a0,a5,80003864 <consputc+0x10>
    8000385c:	00001317          	auipc	t1,0x1
    80003860:	9f430067          	jr	-1548(t1) # 80004250 <uartputc_sync>
    80003864:	ff010113          	addi	sp,sp,-16
    80003868:	00113423          	sd	ra,8(sp)
    8000386c:	00813023          	sd	s0,0(sp)
    80003870:	01010413          	addi	s0,sp,16
    80003874:	00800513          	li	a0,8
    80003878:	00001097          	auipc	ra,0x1
    8000387c:	9d8080e7          	jalr	-1576(ra) # 80004250 <uartputc_sync>
    80003880:	02000513          	li	a0,32
    80003884:	00001097          	auipc	ra,0x1
    80003888:	9cc080e7          	jalr	-1588(ra) # 80004250 <uartputc_sync>
    8000388c:	00013403          	ld	s0,0(sp)
    80003890:	00813083          	ld	ra,8(sp)
    80003894:	00800513          	li	a0,8
    80003898:	01010113          	addi	sp,sp,16
    8000389c:	00001317          	auipc	t1,0x1
    800038a0:	9b430067          	jr	-1612(t1) # 80004250 <uartputc_sync>

00000000800038a4 <consoleintr>:
    800038a4:	fe010113          	addi	sp,sp,-32
    800038a8:	00813823          	sd	s0,16(sp)
    800038ac:	00913423          	sd	s1,8(sp)
    800038b0:	01213023          	sd	s2,0(sp)
    800038b4:	00113c23          	sd	ra,24(sp)
    800038b8:	02010413          	addi	s0,sp,32
    800038bc:	00004917          	auipc	s2,0x4
    800038c0:	9ac90913          	addi	s2,s2,-1620 # 80007268 <cons>
    800038c4:	00050493          	mv	s1,a0
    800038c8:	00090513          	mv	a0,s2
    800038cc:	00001097          	auipc	ra,0x1
    800038d0:	e40080e7          	jalr	-448(ra) # 8000470c <acquire>
    800038d4:	02048c63          	beqz	s1,8000390c <consoleintr+0x68>
    800038d8:	0a092783          	lw	a5,160(s2)
    800038dc:	09892703          	lw	a4,152(s2)
    800038e0:	07f00693          	li	a3,127
    800038e4:	40e7873b          	subw	a4,a5,a4
    800038e8:	02e6e263          	bltu	a3,a4,8000390c <consoleintr+0x68>
    800038ec:	00d00713          	li	a4,13
    800038f0:	04e48063          	beq	s1,a4,80003930 <consoleintr+0x8c>
    800038f4:	07f7f713          	andi	a4,a5,127
    800038f8:	00e90733          	add	a4,s2,a4
    800038fc:	0017879b          	addiw	a5,a5,1
    80003900:	0af92023          	sw	a5,160(s2)
    80003904:	00970c23          	sb	s1,24(a4)
    80003908:	08f92e23          	sw	a5,156(s2)
    8000390c:	01013403          	ld	s0,16(sp)
    80003910:	01813083          	ld	ra,24(sp)
    80003914:	00813483          	ld	s1,8(sp)
    80003918:	00013903          	ld	s2,0(sp)
    8000391c:	00004517          	auipc	a0,0x4
    80003920:	94c50513          	addi	a0,a0,-1716 # 80007268 <cons>
    80003924:	02010113          	addi	sp,sp,32
    80003928:	00001317          	auipc	t1,0x1
    8000392c:	eb030067          	jr	-336(t1) # 800047d8 <release>
    80003930:	00a00493          	li	s1,10
    80003934:	fc1ff06f          	j	800038f4 <consoleintr+0x50>

0000000080003938 <consoleinit>:
    80003938:	fe010113          	addi	sp,sp,-32
    8000393c:	00113c23          	sd	ra,24(sp)
    80003940:	00813823          	sd	s0,16(sp)
    80003944:	00913423          	sd	s1,8(sp)
    80003948:	02010413          	addi	s0,sp,32
    8000394c:	00004497          	auipc	s1,0x4
    80003950:	91c48493          	addi	s1,s1,-1764 # 80007268 <cons>
    80003954:	00048513          	mv	a0,s1
    80003958:	00002597          	auipc	a1,0x2
    8000395c:	8e858593          	addi	a1,a1,-1816 # 80005240 <CONSOLE_STATUS+0x230>
    80003960:	00001097          	auipc	ra,0x1
    80003964:	d88080e7          	jalr	-632(ra) # 800046e8 <initlock>
    80003968:	00000097          	auipc	ra,0x0
    8000396c:	7ac080e7          	jalr	1964(ra) # 80004114 <uartinit>
    80003970:	01813083          	ld	ra,24(sp)
    80003974:	01013403          	ld	s0,16(sp)
    80003978:	00000797          	auipc	a5,0x0
    8000397c:	d9c78793          	addi	a5,a5,-612 # 80003714 <consoleread>
    80003980:	0af4bc23          	sd	a5,184(s1)
    80003984:	00000797          	auipc	a5,0x0
    80003988:	cec78793          	addi	a5,a5,-788 # 80003670 <consolewrite>
    8000398c:	0cf4b023          	sd	a5,192(s1)
    80003990:	00813483          	ld	s1,8(sp)
    80003994:	02010113          	addi	sp,sp,32
    80003998:	00008067          	ret

000000008000399c <console_read>:
    8000399c:	ff010113          	addi	sp,sp,-16
    800039a0:	00813423          	sd	s0,8(sp)
    800039a4:	01010413          	addi	s0,sp,16
    800039a8:	00813403          	ld	s0,8(sp)
    800039ac:	00004317          	auipc	t1,0x4
    800039b0:	97433303          	ld	t1,-1676(t1) # 80007320 <devsw+0x10>
    800039b4:	01010113          	addi	sp,sp,16
    800039b8:	00030067          	jr	t1

00000000800039bc <console_write>:
    800039bc:	ff010113          	addi	sp,sp,-16
    800039c0:	00813423          	sd	s0,8(sp)
    800039c4:	01010413          	addi	s0,sp,16
    800039c8:	00813403          	ld	s0,8(sp)
    800039cc:	00004317          	auipc	t1,0x4
    800039d0:	95c33303          	ld	t1,-1700(t1) # 80007328 <devsw+0x18>
    800039d4:	01010113          	addi	sp,sp,16
    800039d8:	00030067          	jr	t1

00000000800039dc <panic>:
    800039dc:	fe010113          	addi	sp,sp,-32
    800039e0:	00113c23          	sd	ra,24(sp)
    800039e4:	00813823          	sd	s0,16(sp)
    800039e8:	00913423          	sd	s1,8(sp)
    800039ec:	02010413          	addi	s0,sp,32
    800039f0:	00050493          	mv	s1,a0
    800039f4:	00002517          	auipc	a0,0x2
    800039f8:	85450513          	addi	a0,a0,-1964 # 80005248 <CONSOLE_STATUS+0x238>
    800039fc:	00004797          	auipc	a5,0x4
    80003a00:	9c07a623          	sw	zero,-1588(a5) # 800073c8 <pr+0x18>
    80003a04:	00000097          	auipc	ra,0x0
    80003a08:	034080e7          	jalr	52(ra) # 80003a38 <__printf>
    80003a0c:	00048513          	mv	a0,s1
    80003a10:	00000097          	auipc	ra,0x0
    80003a14:	028080e7          	jalr	40(ra) # 80003a38 <__printf>
    80003a18:	00002517          	auipc	a0,0x2
    80003a1c:	81050513          	addi	a0,a0,-2032 # 80005228 <CONSOLE_STATUS+0x218>
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	018080e7          	jalr	24(ra) # 80003a38 <__printf>
    80003a28:	00100793          	li	a5,1
    80003a2c:	00002717          	auipc	a4,0x2
    80003a30:	6ef72623          	sw	a5,1772(a4) # 80006118 <panicked>
    80003a34:	0000006f          	j	80003a34 <panic+0x58>

0000000080003a38 <__printf>:
    80003a38:	f3010113          	addi	sp,sp,-208
    80003a3c:	08813023          	sd	s0,128(sp)
    80003a40:	07313423          	sd	s3,104(sp)
    80003a44:	09010413          	addi	s0,sp,144
    80003a48:	05813023          	sd	s8,64(sp)
    80003a4c:	08113423          	sd	ra,136(sp)
    80003a50:	06913c23          	sd	s1,120(sp)
    80003a54:	07213823          	sd	s2,112(sp)
    80003a58:	07413023          	sd	s4,96(sp)
    80003a5c:	05513c23          	sd	s5,88(sp)
    80003a60:	05613823          	sd	s6,80(sp)
    80003a64:	05713423          	sd	s7,72(sp)
    80003a68:	03913c23          	sd	s9,56(sp)
    80003a6c:	03a13823          	sd	s10,48(sp)
    80003a70:	03b13423          	sd	s11,40(sp)
    80003a74:	00004317          	auipc	t1,0x4
    80003a78:	93c30313          	addi	t1,t1,-1732 # 800073b0 <pr>
    80003a7c:	01832c03          	lw	s8,24(t1)
    80003a80:	00b43423          	sd	a1,8(s0)
    80003a84:	00c43823          	sd	a2,16(s0)
    80003a88:	00d43c23          	sd	a3,24(s0)
    80003a8c:	02e43023          	sd	a4,32(s0)
    80003a90:	02f43423          	sd	a5,40(s0)
    80003a94:	03043823          	sd	a6,48(s0)
    80003a98:	03143c23          	sd	a7,56(s0)
    80003a9c:	00050993          	mv	s3,a0
    80003aa0:	4a0c1663          	bnez	s8,80003f4c <__printf+0x514>
    80003aa4:	60098c63          	beqz	s3,800040bc <__printf+0x684>
    80003aa8:	0009c503          	lbu	a0,0(s3)
    80003aac:	00840793          	addi	a5,s0,8
    80003ab0:	f6f43c23          	sd	a5,-136(s0)
    80003ab4:	00000493          	li	s1,0
    80003ab8:	22050063          	beqz	a0,80003cd8 <__printf+0x2a0>
    80003abc:	00002a37          	lui	s4,0x2
    80003ac0:	00018ab7          	lui	s5,0x18
    80003ac4:	000f4b37          	lui	s6,0xf4
    80003ac8:	00989bb7          	lui	s7,0x989
    80003acc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003ad0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003ad4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003ad8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80003adc:	00148c9b          	addiw	s9,s1,1
    80003ae0:	02500793          	li	a5,37
    80003ae4:	01998933          	add	s2,s3,s9
    80003ae8:	38f51263          	bne	a0,a5,80003e6c <__printf+0x434>
    80003aec:	00094783          	lbu	a5,0(s2)
    80003af0:	00078c9b          	sext.w	s9,a5
    80003af4:	1e078263          	beqz	a5,80003cd8 <__printf+0x2a0>
    80003af8:	0024849b          	addiw	s1,s1,2
    80003afc:	07000713          	li	a4,112
    80003b00:	00998933          	add	s2,s3,s1
    80003b04:	38e78a63          	beq	a5,a4,80003e98 <__printf+0x460>
    80003b08:	20f76863          	bltu	a4,a5,80003d18 <__printf+0x2e0>
    80003b0c:	42a78863          	beq	a5,a0,80003f3c <__printf+0x504>
    80003b10:	06400713          	li	a4,100
    80003b14:	40e79663          	bne	a5,a4,80003f20 <__printf+0x4e8>
    80003b18:	f7843783          	ld	a5,-136(s0)
    80003b1c:	0007a603          	lw	a2,0(a5)
    80003b20:	00878793          	addi	a5,a5,8
    80003b24:	f6f43c23          	sd	a5,-136(s0)
    80003b28:	42064a63          	bltz	a2,80003f5c <__printf+0x524>
    80003b2c:	00a00713          	li	a4,10
    80003b30:	02e677bb          	remuw	a5,a2,a4
    80003b34:	00001d97          	auipc	s11,0x1
    80003b38:	73cd8d93          	addi	s11,s11,1852 # 80005270 <digits>
    80003b3c:	00900593          	li	a1,9
    80003b40:	0006051b          	sext.w	a0,a2
    80003b44:	00000c93          	li	s9,0
    80003b48:	02079793          	slli	a5,a5,0x20
    80003b4c:	0207d793          	srli	a5,a5,0x20
    80003b50:	00fd87b3          	add	a5,s11,a5
    80003b54:	0007c783          	lbu	a5,0(a5)
    80003b58:	02e656bb          	divuw	a3,a2,a4
    80003b5c:	f8f40023          	sb	a5,-128(s0)
    80003b60:	14c5d863          	bge	a1,a2,80003cb0 <__printf+0x278>
    80003b64:	06300593          	li	a1,99
    80003b68:	00100c93          	li	s9,1
    80003b6c:	02e6f7bb          	remuw	a5,a3,a4
    80003b70:	02079793          	slli	a5,a5,0x20
    80003b74:	0207d793          	srli	a5,a5,0x20
    80003b78:	00fd87b3          	add	a5,s11,a5
    80003b7c:	0007c783          	lbu	a5,0(a5)
    80003b80:	02e6d73b          	divuw	a4,a3,a4
    80003b84:	f8f400a3          	sb	a5,-127(s0)
    80003b88:	12a5f463          	bgeu	a1,a0,80003cb0 <__printf+0x278>
    80003b8c:	00a00693          	li	a3,10
    80003b90:	00900593          	li	a1,9
    80003b94:	02d777bb          	remuw	a5,a4,a3
    80003b98:	02079793          	slli	a5,a5,0x20
    80003b9c:	0207d793          	srli	a5,a5,0x20
    80003ba0:	00fd87b3          	add	a5,s11,a5
    80003ba4:	0007c503          	lbu	a0,0(a5)
    80003ba8:	02d757bb          	divuw	a5,a4,a3
    80003bac:	f8a40123          	sb	a0,-126(s0)
    80003bb0:	48e5f263          	bgeu	a1,a4,80004034 <__printf+0x5fc>
    80003bb4:	06300513          	li	a0,99
    80003bb8:	02d7f5bb          	remuw	a1,a5,a3
    80003bbc:	02059593          	slli	a1,a1,0x20
    80003bc0:	0205d593          	srli	a1,a1,0x20
    80003bc4:	00bd85b3          	add	a1,s11,a1
    80003bc8:	0005c583          	lbu	a1,0(a1)
    80003bcc:	02d7d7bb          	divuw	a5,a5,a3
    80003bd0:	f8b401a3          	sb	a1,-125(s0)
    80003bd4:	48e57263          	bgeu	a0,a4,80004058 <__printf+0x620>
    80003bd8:	3e700513          	li	a0,999
    80003bdc:	02d7f5bb          	remuw	a1,a5,a3
    80003be0:	02059593          	slli	a1,a1,0x20
    80003be4:	0205d593          	srli	a1,a1,0x20
    80003be8:	00bd85b3          	add	a1,s11,a1
    80003bec:	0005c583          	lbu	a1,0(a1)
    80003bf0:	02d7d7bb          	divuw	a5,a5,a3
    80003bf4:	f8b40223          	sb	a1,-124(s0)
    80003bf8:	46e57663          	bgeu	a0,a4,80004064 <__printf+0x62c>
    80003bfc:	02d7f5bb          	remuw	a1,a5,a3
    80003c00:	02059593          	slli	a1,a1,0x20
    80003c04:	0205d593          	srli	a1,a1,0x20
    80003c08:	00bd85b3          	add	a1,s11,a1
    80003c0c:	0005c583          	lbu	a1,0(a1)
    80003c10:	02d7d7bb          	divuw	a5,a5,a3
    80003c14:	f8b402a3          	sb	a1,-123(s0)
    80003c18:	46ea7863          	bgeu	s4,a4,80004088 <__printf+0x650>
    80003c1c:	02d7f5bb          	remuw	a1,a5,a3
    80003c20:	02059593          	slli	a1,a1,0x20
    80003c24:	0205d593          	srli	a1,a1,0x20
    80003c28:	00bd85b3          	add	a1,s11,a1
    80003c2c:	0005c583          	lbu	a1,0(a1)
    80003c30:	02d7d7bb          	divuw	a5,a5,a3
    80003c34:	f8b40323          	sb	a1,-122(s0)
    80003c38:	3eeaf863          	bgeu	s5,a4,80004028 <__printf+0x5f0>
    80003c3c:	02d7f5bb          	remuw	a1,a5,a3
    80003c40:	02059593          	slli	a1,a1,0x20
    80003c44:	0205d593          	srli	a1,a1,0x20
    80003c48:	00bd85b3          	add	a1,s11,a1
    80003c4c:	0005c583          	lbu	a1,0(a1)
    80003c50:	02d7d7bb          	divuw	a5,a5,a3
    80003c54:	f8b403a3          	sb	a1,-121(s0)
    80003c58:	42eb7e63          	bgeu	s6,a4,80004094 <__printf+0x65c>
    80003c5c:	02d7f5bb          	remuw	a1,a5,a3
    80003c60:	02059593          	slli	a1,a1,0x20
    80003c64:	0205d593          	srli	a1,a1,0x20
    80003c68:	00bd85b3          	add	a1,s11,a1
    80003c6c:	0005c583          	lbu	a1,0(a1)
    80003c70:	02d7d7bb          	divuw	a5,a5,a3
    80003c74:	f8b40423          	sb	a1,-120(s0)
    80003c78:	42ebfc63          	bgeu	s7,a4,800040b0 <__printf+0x678>
    80003c7c:	02079793          	slli	a5,a5,0x20
    80003c80:	0207d793          	srli	a5,a5,0x20
    80003c84:	00fd8db3          	add	s11,s11,a5
    80003c88:	000dc703          	lbu	a4,0(s11)
    80003c8c:	00a00793          	li	a5,10
    80003c90:	00900c93          	li	s9,9
    80003c94:	f8e404a3          	sb	a4,-119(s0)
    80003c98:	00065c63          	bgez	a2,80003cb0 <__printf+0x278>
    80003c9c:	f9040713          	addi	a4,s0,-112
    80003ca0:	00f70733          	add	a4,a4,a5
    80003ca4:	02d00693          	li	a3,45
    80003ca8:	fed70823          	sb	a3,-16(a4)
    80003cac:	00078c93          	mv	s9,a5
    80003cb0:	f8040793          	addi	a5,s0,-128
    80003cb4:	01978cb3          	add	s9,a5,s9
    80003cb8:	f7f40d13          	addi	s10,s0,-129
    80003cbc:	000cc503          	lbu	a0,0(s9)
    80003cc0:	fffc8c93          	addi	s9,s9,-1
    80003cc4:	00000097          	auipc	ra,0x0
    80003cc8:	b90080e7          	jalr	-1136(ra) # 80003854 <consputc>
    80003ccc:	ffac98e3          	bne	s9,s10,80003cbc <__printf+0x284>
    80003cd0:	00094503          	lbu	a0,0(s2)
    80003cd4:	e00514e3          	bnez	a0,80003adc <__printf+0xa4>
    80003cd8:	1a0c1663          	bnez	s8,80003e84 <__printf+0x44c>
    80003cdc:	08813083          	ld	ra,136(sp)
    80003ce0:	08013403          	ld	s0,128(sp)
    80003ce4:	07813483          	ld	s1,120(sp)
    80003ce8:	07013903          	ld	s2,112(sp)
    80003cec:	06813983          	ld	s3,104(sp)
    80003cf0:	06013a03          	ld	s4,96(sp)
    80003cf4:	05813a83          	ld	s5,88(sp)
    80003cf8:	05013b03          	ld	s6,80(sp)
    80003cfc:	04813b83          	ld	s7,72(sp)
    80003d00:	04013c03          	ld	s8,64(sp)
    80003d04:	03813c83          	ld	s9,56(sp)
    80003d08:	03013d03          	ld	s10,48(sp)
    80003d0c:	02813d83          	ld	s11,40(sp)
    80003d10:	0d010113          	addi	sp,sp,208
    80003d14:	00008067          	ret
    80003d18:	07300713          	li	a4,115
    80003d1c:	1ce78a63          	beq	a5,a4,80003ef0 <__printf+0x4b8>
    80003d20:	07800713          	li	a4,120
    80003d24:	1ee79e63          	bne	a5,a4,80003f20 <__printf+0x4e8>
    80003d28:	f7843783          	ld	a5,-136(s0)
    80003d2c:	0007a703          	lw	a4,0(a5)
    80003d30:	00878793          	addi	a5,a5,8
    80003d34:	f6f43c23          	sd	a5,-136(s0)
    80003d38:	28074263          	bltz	a4,80003fbc <__printf+0x584>
    80003d3c:	00001d97          	auipc	s11,0x1
    80003d40:	534d8d93          	addi	s11,s11,1332 # 80005270 <digits>
    80003d44:	00f77793          	andi	a5,a4,15
    80003d48:	00fd87b3          	add	a5,s11,a5
    80003d4c:	0007c683          	lbu	a3,0(a5)
    80003d50:	00f00613          	li	a2,15
    80003d54:	0007079b          	sext.w	a5,a4
    80003d58:	f8d40023          	sb	a3,-128(s0)
    80003d5c:	0047559b          	srliw	a1,a4,0x4
    80003d60:	0047569b          	srliw	a3,a4,0x4
    80003d64:	00000c93          	li	s9,0
    80003d68:	0ee65063          	bge	a2,a4,80003e48 <__printf+0x410>
    80003d6c:	00f6f693          	andi	a3,a3,15
    80003d70:	00dd86b3          	add	a3,s11,a3
    80003d74:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003d78:	0087d79b          	srliw	a5,a5,0x8
    80003d7c:	00100c93          	li	s9,1
    80003d80:	f8d400a3          	sb	a3,-127(s0)
    80003d84:	0cb67263          	bgeu	a2,a1,80003e48 <__printf+0x410>
    80003d88:	00f7f693          	andi	a3,a5,15
    80003d8c:	00dd86b3          	add	a3,s11,a3
    80003d90:	0006c583          	lbu	a1,0(a3)
    80003d94:	00f00613          	li	a2,15
    80003d98:	0047d69b          	srliw	a3,a5,0x4
    80003d9c:	f8b40123          	sb	a1,-126(s0)
    80003da0:	0047d593          	srli	a1,a5,0x4
    80003da4:	28f67e63          	bgeu	a2,a5,80004040 <__printf+0x608>
    80003da8:	00f6f693          	andi	a3,a3,15
    80003dac:	00dd86b3          	add	a3,s11,a3
    80003db0:	0006c503          	lbu	a0,0(a3)
    80003db4:	0087d813          	srli	a6,a5,0x8
    80003db8:	0087d69b          	srliw	a3,a5,0x8
    80003dbc:	f8a401a3          	sb	a0,-125(s0)
    80003dc0:	28b67663          	bgeu	a2,a1,8000404c <__printf+0x614>
    80003dc4:	00f6f693          	andi	a3,a3,15
    80003dc8:	00dd86b3          	add	a3,s11,a3
    80003dcc:	0006c583          	lbu	a1,0(a3)
    80003dd0:	00c7d513          	srli	a0,a5,0xc
    80003dd4:	00c7d69b          	srliw	a3,a5,0xc
    80003dd8:	f8b40223          	sb	a1,-124(s0)
    80003ddc:	29067a63          	bgeu	a2,a6,80004070 <__printf+0x638>
    80003de0:	00f6f693          	andi	a3,a3,15
    80003de4:	00dd86b3          	add	a3,s11,a3
    80003de8:	0006c583          	lbu	a1,0(a3)
    80003dec:	0107d813          	srli	a6,a5,0x10
    80003df0:	0107d69b          	srliw	a3,a5,0x10
    80003df4:	f8b402a3          	sb	a1,-123(s0)
    80003df8:	28a67263          	bgeu	a2,a0,8000407c <__printf+0x644>
    80003dfc:	00f6f693          	andi	a3,a3,15
    80003e00:	00dd86b3          	add	a3,s11,a3
    80003e04:	0006c683          	lbu	a3,0(a3)
    80003e08:	0147d79b          	srliw	a5,a5,0x14
    80003e0c:	f8d40323          	sb	a3,-122(s0)
    80003e10:	21067663          	bgeu	a2,a6,8000401c <__printf+0x5e4>
    80003e14:	02079793          	slli	a5,a5,0x20
    80003e18:	0207d793          	srli	a5,a5,0x20
    80003e1c:	00fd8db3          	add	s11,s11,a5
    80003e20:	000dc683          	lbu	a3,0(s11)
    80003e24:	00800793          	li	a5,8
    80003e28:	00700c93          	li	s9,7
    80003e2c:	f8d403a3          	sb	a3,-121(s0)
    80003e30:	00075c63          	bgez	a4,80003e48 <__printf+0x410>
    80003e34:	f9040713          	addi	a4,s0,-112
    80003e38:	00f70733          	add	a4,a4,a5
    80003e3c:	02d00693          	li	a3,45
    80003e40:	fed70823          	sb	a3,-16(a4)
    80003e44:	00078c93          	mv	s9,a5
    80003e48:	f8040793          	addi	a5,s0,-128
    80003e4c:	01978cb3          	add	s9,a5,s9
    80003e50:	f7f40d13          	addi	s10,s0,-129
    80003e54:	000cc503          	lbu	a0,0(s9)
    80003e58:	fffc8c93          	addi	s9,s9,-1
    80003e5c:	00000097          	auipc	ra,0x0
    80003e60:	9f8080e7          	jalr	-1544(ra) # 80003854 <consputc>
    80003e64:	ff9d18e3          	bne	s10,s9,80003e54 <__printf+0x41c>
    80003e68:	0100006f          	j	80003e78 <__printf+0x440>
    80003e6c:	00000097          	auipc	ra,0x0
    80003e70:	9e8080e7          	jalr	-1560(ra) # 80003854 <consputc>
    80003e74:	000c8493          	mv	s1,s9
    80003e78:	00094503          	lbu	a0,0(s2)
    80003e7c:	c60510e3          	bnez	a0,80003adc <__printf+0xa4>
    80003e80:	e40c0ee3          	beqz	s8,80003cdc <__printf+0x2a4>
    80003e84:	00003517          	auipc	a0,0x3
    80003e88:	52c50513          	addi	a0,a0,1324 # 800073b0 <pr>
    80003e8c:	00001097          	auipc	ra,0x1
    80003e90:	94c080e7          	jalr	-1716(ra) # 800047d8 <release>
    80003e94:	e49ff06f          	j	80003cdc <__printf+0x2a4>
    80003e98:	f7843783          	ld	a5,-136(s0)
    80003e9c:	03000513          	li	a0,48
    80003ea0:	01000d13          	li	s10,16
    80003ea4:	00878713          	addi	a4,a5,8
    80003ea8:	0007bc83          	ld	s9,0(a5)
    80003eac:	f6e43c23          	sd	a4,-136(s0)
    80003eb0:	00000097          	auipc	ra,0x0
    80003eb4:	9a4080e7          	jalr	-1628(ra) # 80003854 <consputc>
    80003eb8:	07800513          	li	a0,120
    80003ebc:	00000097          	auipc	ra,0x0
    80003ec0:	998080e7          	jalr	-1640(ra) # 80003854 <consputc>
    80003ec4:	00001d97          	auipc	s11,0x1
    80003ec8:	3acd8d93          	addi	s11,s11,940 # 80005270 <digits>
    80003ecc:	03ccd793          	srli	a5,s9,0x3c
    80003ed0:	00fd87b3          	add	a5,s11,a5
    80003ed4:	0007c503          	lbu	a0,0(a5)
    80003ed8:	fffd0d1b          	addiw	s10,s10,-1
    80003edc:	004c9c93          	slli	s9,s9,0x4
    80003ee0:	00000097          	auipc	ra,0x0
    80003ee4:	974080e7          	jalr	-1676(ra) # 80003854 <consputc>
    80003ee8:	fe0d12e3          	bnez	s10,80003ecc <__printf+0x494>
    80003eec:	f8dff06f          	j	80003e78 <__printf+0x440>
    80003ef0:	f7843783          	ld	a5,-136(s0)
    80003ef4:	0007bc83          	ld	s9,0(a5)
    80003ef8:	00878793          	addi	a5,a5,8
    80003efc:	f6f43c23          	sd	a5,-136(s0)
    80003f00:	000c9a63          	bnez	s9,80003f14 <__printf+0x4dc>
    80003f04:	1080006f          	j	8000400c <__printf+0x5d4>
    80003f08:	001c8c93          	addi	s9,s9,1
    80003f0c:	00000097          	auipc	ra,0x0
    80003f10:	948080e7          	jalr	-1720(ra) # 80003854 <consputc>
    80003f14:	000cc503          	lbu	a0,0(s9)
    80003f18:	fe0518e3          	bnez	a0,80003f08 <__printf+0x4d0>
    80003f1c:	f5dff06f          	j	80003e78 <__printf+0x440>
    80003f20:	02500513          	li	a0,37
    80003f24:	00000097          	auipc	ra,0x0
    80003f28:	930080e7          	jalr	-1744(ra) # 80003854 <consputc>
    80003f2c:	000c8513          	mv	a0,s9
    80003f30:	00000097          	auipc	ra,0x0
    80003f34:	924080e7          	jalr	-1756(ra) # 80003854 <consputc>
    80003f38:	f41ff06f          	j	80003e78 <__printf+0x440>
    80003f3c:	02500513          	li	a0,37
    80003f40:	00000097          	auipc	ra,0x0
    80003f44:	914080e7          	jalr	-1772(ra) # 80003854 <consputc>
    80003f48:	f31ff06f          	j	80003e78 <__printf+0x440>
    80003f4c:	00030513          	mv	a0,t1
    80003f50:	00000097          	auipc	ra,0x0
    80003f54:	7bc080e7          	jalr	1980(ra) # 8000470c <acquire>
    80003f58:	b4dff06f          	j	80003aa4 <__printf+0x6c>
    80003f5c:	40c0053b          	negw	a0,a2
    80003f60:	00a00713          	li	a4,10
    80003f64:	02e576bb          	remuw	a3,a0,a4
    80003f68:	00001d97          	auipc	s11,0x1
    80003f6c:	308d8d93          	addi	s11,s11,776 # 80005270 <digits>
    80003f70:	ff700593          	li	a1,-9
    80003f74:	02069693          	slli	a3,a3,0x20
    80003f78:	0206d693          	srli	a3,a3,0x20
    80003f7c:	00dd86b3          	add	a3,s11,a3
    80003f80:	0006c683          	lbu	a3,0(a3)
    80003f84:	02e557bb          	divuw	a5,a0,a4
    80003f88:	f8d40023          	sb	a3,-128(s0)
    80003f8c:	10b65e63          	bge	a2,a1,800040a8 <__printf+0x670>
    80003f90:	06300593          	li	a1,99
    80003f94:	02e7f6bb          	remuw	a3,a5,a4
    80003f98:	02069693          	slli	a3,a3,0x20
    80003f9c:	0206d693          	srli	a3,a3,0x20
    80003fa0:	00dd86b3          	add	a3,s11,a3
    80003fa4:	0006c683          	lbu	a3,0(a3)
    80003fa8:	02e7d73b          	divuw	a4,a5,a4
    80003fac:	00200793          	li	a5,2
    80003fb0:	f8d400a3          	sb	a3,-127(s0)
    80003fb4:	bca5ece3          	bltu	a1,a0,80003b8c <__printf+0x154>
    80003fb8:	ce5ff06f          	j	80003c9c <__printf+0x264>
    80003fbc:	40e007bb          	negw	a5,a4
    80003fc0:	00001d97          	auipc	s11,0x1
    80003fc4:	2b0d8d93          	addi	s11,s11,688 # 80005270 <digits>
    80003fc8:	00f7f693          	andi	a3,a5,15
    80003fcc:	00dd86b3          	add	a3,s11,a3
    80003fd0:	0006c583          	lbu	a1,0(a3)
    80003fd4:	ff100613          	li	a2,-15
    80003fd8:	0047d69b          	srliw	a3,a5,0x4
    80003fdc:	f8b40023          	sb	a1,-128(s0)
    80003fe0:	0047d59b          	srliw	a1,a5,0x4
    80003fe4:	0ac75e63          	bge	a4,a2,800040a0 <__printf+0x668>
    80003fe8:	00f6f693          	andi	a3,a3,15
    80003fec:	00dd86b3          	add	a3,s11,a3
    80003ff0:	0006c603          	lbu	a2,0(a3)
    80003ff4:	00f00693          	li	a3,15
    80003ff8:	0087d79b          	srliw	a5,a5,0x8
    80003ffc:	f8c400a3          	sb	a2,-127(s0)
    80004000:	d8b6e4e3          	bltu	a3,a1,80003d88 <__printf+0x350>
    80004004:	00200793          	li	a5,2
    80004008:	e2dff06f          	j	80003e34 <__printf+0x3fc>
    8000400c:	00001c97          	auipc	s9,0x1
    80004010:	244c8c93          	addi	s9,s9,580 # 80005250 <CONSOLE_STATUS+0x240>
    80004014:	02800513          	li	a0,40
    80004018:	ef1ff06f          	j	80003f08 <__printf+0x4d0>
    8000401c:	00700793          	li	a5,7
    80004020:	00600c93          	li	s9,6
    80004024:	e0dff06f          	j	80003e30 <__printf+0x3f8>
    80004028:	00700793          	li	a5,7
    8000402c:	00600c93          	li	s9,6
    80004030:	c69ff06f          	j	80003c98 <__printf+0x260>
    80004034:	00300793          	li	a5,3
    80004038:	00200c93          	li	s9,2
    8000403c:	c5dff06f          	j	80003c98 <__printf+0x260>
    80004040:	00300793          	li	a5,3
    80004044:	00200c93          	li	s9,2
    80004048:	de9ff06f          	j	80003e30 <__printf+0x3f8>
    8000404c:	00400793          	li	a5,4
    80004050:	00300c93          	li	s9,3
    80004054:	dddff06f          	j	80003e30 <__printf+0x3f8>
    80004058:	00400793          	li	a5,4
    8000405c:	00300c93          	li	s9,3
    80004060:	c39ff06f          	j	80003c98 <__printf+0x260>
    80004064:	00500793          	li	a5,5
    80004068:	00400c93          	li	s9,4
    8000406c:	c2dff06f          	j	80003c98 <__printf+0x260>
    80004070:	00500793          	li	a5,5
    80004074:	00400c93          	li	s9,4
    80004078:	db9ff06f          	j	80003e30 <__printf+0x3f8>
    8000407c:	00600793          	li	a5,6
    80004080:	00500c93          	li	s9,5
    80004084:	dadff06f          	j	80003e30 <__printf+0x3f8>
    80004088:	00600793          	li	a5,6
    8000408c:	00500c93          	li	s9,5
    80004090:	c09ff06f          	j	80003c98 <__printf+0x260>
    80004094:	00800793          	li	a5,8
    80004098:	00700c93          	li	s9,7
    8000409c:	bfdff06f          	j	80003c98 <__printf+0x260>
    800040a0:	00100793          	li	a5,1
    800040a4:	d91ff06f          	j	80003e34 <__printf+0x3fc>
    800040a8:	00100793          	li	a5,1
    800040ac:	bf1ff06f          	j	80003c9c <__printf+0x264>
    800040b0:	00900793          	li	a5,9
    800040b4:	00800c93          	li	s9,8
    800040b8:	be1ff06f          	j	80003c98 <__printf+0x260>
    800040bc:	00001517          	auipc	a0,0x1
    800040c0:	19c50513          	addi	a0,a0,412 # 80005258 <CONSOLE_STATUS+0x248>
    800040c4:	00000097          	auipc	ra,0x0
    800040c8:	918080e7          	jalr	-1768(ra) # 800039dc <panic>

00000000800040cc <printfinit>:
    800040cc:	fe010113          	addi	sp,sp,-32
    800040d0:	00813823          	sd	s0,16(sp)
    800040d4:	00913423          	sd	s1,8(sp)
    800040d8:	00113c23          	sd	ra,24(sp)
    800040dc:	02010413          	addi	s0,sp,32
    800040e0:	00003497          	auipc	s1,0x3
    800040e4:	2d048493          	addi	s1,s1,720 # 800073b0 <pr>
    800040e8:	00048513          	mv	a0,s1
    800040ec:	00001597          	auipc	a1,0x1
    800040f0:	17c58593          	addi	a1,a1,380 # 80005268 <CONSOLE_STATUS+0x258>
    800040f4:	00000097          	auipc	ra,0x0
    800040f8:	5f4080e7          	jalr	1524(ra) # 800046e8 <initlock>
    800040fc:	01813083          	ld	ra,24(sp)
    80004100:	01013403          	ld	s0,16(sp)
    80004104:	0004ac23          	sw	zero,24(s1)
    80004108:	00813483          	ld	s1,8(sp)
    8000410c:	02010113          	addi	sp,sp,32
    80004110:	00008067          	ret

0000000080004114 <uartinit>:
    80004114:	ff010113          	addi	sp,sp,-16
    80004118:	00813423          	sd	s0,8(sp)
    8000411c:	01010413          	addi	s0,sp,16
    80004120:	100007b7          	lui	a5,0x10000
    80004124:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004128:	f8000713          	li	a4,-128
    8000412c:	00e781a3          	sb	a4,3(a5)
    80004130:	00300713          	li	a4,3
    80004134:	00e78023          	sb	a4,0(a5)
    80004138:	000780a3          	sb	zero,1(a5)
    8000413c:	00e781a3          	sb	a4,3(a5)
    80004140:	00700693          	li	a3,7
    80004144:	00d78123          	sb	a3,2(a5)
    80004148:	00e780a3          	sb	a4,1(a5)
    8000414c:	00813403          	ld	s0,8(sp)
    80004150:	01010113          	addi	sp,sp,16
    80004154:	00008067          	ret

0000000080004158 <uartputc>:
    80004158:	00002797          	auipc	a5,0x2
    8000415c:	fc07a783          	lw	a5,-64(a5) # 80006118 <panicked>
    80004160:	00078463          	beqz	a5,80004168 <uartputc+0x10>
    80004164:	0000006f          	j	80004164 <uartputc+0xc>
    80004168:	fd010113          	addi	sp,sp,-48
    8000416c:	02813023          	sd	s0,32(sp)
    80004170:	00913c23          	sd	s1,24(sp)
    80004174:	01213823          	sd	s2,16(sp)
    80004178:	01313423          	sd	s3,8(sp)
    8000417c:	02113423          	sd	ra,40(sp)
    80004180:	03010413          	addi	s0,sp,48
    80004184:	00002917          	auipc	s2,0x2
    80004188:	f9c90913          	addi	s2,s2,-100 # 80006120 <uart_tx_r>
    8000418c:	00093783          	ld	a5,0(s2)
    80004190:	00002497          	auipc	s1,0x2
    80004194:	f9848493          	addi	s1,s1,-104 # 80006128 <uart_tx_w>
    80004198:	0004b703          	ld	a4,0(s1)
    8000419c:	02078693          	addi	a3,a5,32
    800041a0:	00050993          	mv	s3,a0
    800041a4:	02e69c63          	bne	a3,a4,800041dc <uartputc+0x84>
    800041a8:	00001097          	auipc	ra,0x1
    800041ac:	834080e7          	jalr	-1996(ra) # 800049dc <push_on>
    800041b0:	00093783          	ld	a5,0(s2)
    800041b4:	0004b703          	ld	a4,0(s1)
    800041b8:	02078793          	addi	a5,a5,32
    800041bc:	00e79463          	bne	a5,a4,800041c4 <uartputc+0x6c>
    800041c0:	0000006f          	j	800041c0 <uartputc+0x68>
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	88c080e7          	jalr	-1908(ra) # 80004a50 <pop_on>
    800041cc:	00093783          	ld	a5,0(s2)
    800041d0:	0004b703          	ld	a4,0(s1)
    800041d4:	02078693          	addi	a3,a5,32
    800041d8:	fce688e3          	beq	a3,a4,800041a8 <uartputc+0x50>
    800041dc:	01f77693          	andi	a3,a4,31
    800041e0:	00003597          	auipc	a1,0x3
    800041e4:	1f058593          	addi	a1,a1,496 # 800073d0 <uart_tx_buf>
    800041e8:	00d586b3          	add	a3,a1,a3
    800041ec:	00170713          	addi	a4,a4,1
    800041f0:	01368023          	sb	s3,0(a3)
    800041f4:	00e4b023          	sd	a4,0(s1)
    800041f8:	10000637          	lui	a2,0x10000
    800041fc:	02f71063          	bne	a4,a5,8000421c <uartputc+0xc4>
    80004200:	0340006f          	j	80004234 <uartputc+0xdc>
    80004204:	00074703          	lbu	a4,0(a4)
    80004208:	00f93023          	sd	a5,0(s2)
    8000420c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004210:	00093783          	ld	a5,0(s2)
    80004214:	0004b703          	ld	a4,0(s1)
    80004218:	00f70e63          	beq	a4,a5,80004234 <uartputc+0xdc>
    8000421c:	00564683          	lbu	a3,5(a2)
    80004220:	01f7f713          	andi	a4,a5,31
    80004224:	00e58733          	add	a4,a1,a4
    80004228:	0206f693          	andi	a3,a3,32
    8000422c:	00178793          	addi	a5,a5,1
    80004230:	fc069ae3          	bnez	a3,80004204 <uartputc+0xac>
    80004234:	02813083          	ld	ra,40(sp)
    80004238:	02013403          	ld	s0,32(sp)
    8000423c:	01813483          	ld	s1,24(sp)
    80004240:	01013903          	ld	s2,16(sp)
    80004244:	00813983          	ld	s3,8(sp)
    80004248:	03010113          	addi	sp,sp,48
    8000424c:	00008067          	ret

0000000080004250 <uartputc_sync>:
    80004250:	ff010113          	addi	sp,sp,-16
    80004254:	00813423          	sd	s0,8(sp)
    80004258:	01010413          	addi	s0,sp,16
    8000425c:	00002717          	auipc	a4,0x2
    80004260:	ebc72703          	lw	a4,-324(a4) # 80006118 <panicked>
    80004264:	02071663          	bnez	a4,80004290 <uartputc_sync+0x40>
    80004268:	00050793          	mv	a5,a0
    8000426c:	100006b7          	lui	a3,0x10000
    80004270:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004274:	02077713          	andi	a4,a4,32
    80004278:	fe070ce3          	beqz	a4,80004270 <uartputc_sync+0x20>
    8000427c:	0ff7f793          	andi	a5,a5,255
    80004280:	00f68023          	sb	a5,0(a3)
    80004284:	00813403          	ld	s0,8(sp)
    80004288:	01010113          	addi	sp,sp,16
    8000428c:	00008067          	ret
    80004290:	0000006f          	j	80004290 <uartputc_sync+0x40>

0000000080004294 <uartstart>:
    80004294:	ff010113          	addi	sp,sp,-16
    80004298:	00813423          	sd	s0,8(sp)
    8000429c:	01010413          	addi	s0,sp,16
    800042a0:	00002617          	auipc	a2,0x2
    800042a4:	e8060613          	addi	a2,a2,-384 # 80006120 <uart_tx_r>
    800042a8:	00002517          	auipc	a0,0x2
    800042ac:	e8050513          	addi	a0,a0,-384 # 80006128 <uart_tx_w>
    800042b0:	00063783          	ld	a5,0(a2)
    800042b4:	00053703          	ld	a4,0(a0)
    800042b8:	04f70263          	beq	a4,a5,800042fc <uartstart+0x68>
    800042bc:	100005b7          	lui	a1,0x10000
    800042c0:	00003817          	auipc	a6,0x3
    800042c4:	11080813          	addi	a6,a6,272 # 800073d0 <uart_tx_buf>
    800042c8:	01c0006f          	j	800042e4 <uartstart+0x50>
    800042cc:	0006c703          	lbu	a4,0(a3)
    800042d0:	00f63023          	sd	a5,0(a2)
    800042d4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800042d8:	00063783          	ld	a5,0(a2)
    800042dc:	00053703          	ld	a4,0(a0)
    800042e0:	00f70e63          	beq	a4,a5,800042fc <uartstart+0x68>
    800042e4:	01f7f713          	andi	a4,a5,31
    800042e8:	00e806b3          	add	a3,a6,a4
    800042ec:	0055c703          	lbu	a4,5(a1)
    800042f0:	00178793          	addi	a5,a5,1
    800042f4:	02077713          	andi	a4,a4,32
    800042f8:	fc071ae3          	bnez	a4,800042cc <uartstart+0x38>
    800042fc:	00813403          	ld	s0,8(sp)
    80004300:	01010113          	addi	sp,sp,16
    80004304:	00008067          	ret

0000000080004308 <uartgetc>:
    80004308:	ff010113          	addi	sp,sp,-16
    8000430c:	00813423          	sd	s0,8(sp)
    80004310:	01010413          	addi	s0,sp,16
    80004314:	10000737          	lui	a4,0x10000
    80004318:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000431c:	0017f793          	andi	a5,a5,1
    80004320:	00078c63          	beqz	a5,80004338 <uartgetc+0x30>
    80004324:	00074503          	lbu	a0,0(a4)
    80004328:	0ff57513          	andi	a0,a0,255
    8000432c:	00813403          	ld	s0,8(sp)
    80004330:	01010113          	addi	sp,sp,16
    80004334:	00008067          	ret
    80004338:	fff00513          	li	a0,-1
    8000433c:	ff1ff06f          	j	8000432c <uartgetc+0x24>

0000000080004340 <uartintr>:
    80004340:	100007b7          	lui	a5,0x10000
    80004344:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004348:	0017f793          	andi	a5,a5,1
    8000434c:	0a078463          	beqz	a5,800043f4 <uartintr+0xb4>
    80004350:	fe010113          	addi	sp,sp,-32
    80004354:	00813823          	sd	s0,16(sp)
    80004358:	00913423          	sd	s1,8(sp)
    8000435c:	00113c23          	sd	ra,24(sp)
    80004360:	02010413          	addi	s0,sp,32
    80004364:	100004b7          	lui	s1,0x10000
    80004368:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000436c:	0ff57513          	andi	a0,a0,255
    80004370:	fffff097          	auipc	ra,0xfffff
    80004374:	534080e7          	jalr	1332(ra) # 800038a4 <consoleintr>
    80004378:	0054c783          	lbu	a5,5(s1)
    8000437c:	0017f793          	andi	a5,a5,1
    80004380:	fe0794e3          	bnez	a5,80004368 <uartintr+0x28>
    80004384:	00002617          	auipc	a2,0x2
    80004388:	d9c60613          	addi	a2,a2,-612 # 80006120 <uart_tx_r>
    8000438c:	00002517          	auipc	a0,0x2
    80004390:	d9c50513          	addi	a0,a0,-612 # 80006128 <uart_tx_w>
    80004394:	00063783          	ld	a5,0(a2)
    80004398:	00053703          	ld	a4,0(a0)
    8000439c:	04f70263          	beq	a4,a5,800043e0 <uartintr+0xa0>
    800043a0:	100005b7          	lui	a1,0x10000
    800043a4:	00003817          	auipc	a6,0x3
    800043a8:	02c80813          	addi	a6,a6,44 # 800073d0 <uart_tx_buf>
    800043ac:	01c0006f          	j	800043c8 <uartintr+0x88>
    800043b0:	0006c703          	lbu	a4,0(a3)
    800043b4:	00f63023          	sd	a5,0(a2)
    800043b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800043bc:	00063783          	ld	a5,0(a2)
    800043c0:	00053703          	ld	a4,0(a0)
    800043c4:	00f70e63          	beq	a4,a5,800043e0 <uartintr+0xa0>
    800043c8:	01f7f713          	andi	a4,a5,31
    800043cc:	00e806b3          	add	a3,a6,a4
    800043d0:	0055c703          	lbu	a4,5(a1)
    800043d4:	00178793          	addi	a5,a5,1
    800043d8:	02077713          	andi	a4,a4,32
    800043dc:	fc071ae3          	bnez	a4,800043b0 <uartintr+0x70>
    800043e0:	01813083          	ld	ra,24(sp)
    800043e4:	01013403          	ld	s0,16(sp)
    800043e8:	00813483          	ld	s1,8(sp)
    800043ec:	02010113          	addi	sp,sp,32
    800043f0:	00008067          	ret
    800043f4:	00002617          	auipc	a2,0x2
    800043f8:	d2c60613          	addi	a2,a2,-724 # 80006120 <uart_tx_r>
    800043fc:	00002517          	auipc	a0,0x2
    80004400:	d2c50513          	addi	a0,a0,-724 # 80006128 <uart_tx_w>
    80004404:	00063783          	ld	a5,0(a2)
    80004408:	00053703          	ld	a4,0(a0)
    8000440c:	04f70263          	beq	a4,a5,80004450 <uartintr+0x110>
    80004410:	100005b7          	lui	a1,0x10000
    80004414:	00003817          	auipc	a6,0x3
    80004418:	fbc80813          	addi	a6,a6,-68 # 800073d0 <uart_tx_buf>
    8000441c:	01c0006f          	j	80004438 <uartintr+0xf8>
    80004420:	0006c703          	lbu	a4,0(a3)
    80004424:	00f63023          	sd	a5,0(a2)
    80004428:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000442c:	00063783          	ld	a5,0(a2)
    80004430:	00053703          	ld	a4,0(a0)
    80004434:	02f70063          	beq	a4,a5,80004454 <uartintr+0x114>
    80004438:	01f7f713          	andi	a4,a5,31
    8000443c:	00e806b3          	add	a3,a6,a4
    80004440:	0055c703          	lbu	a4,5(a1)
    80004444:	00178793          	addi	a5,a5,1
    80004448:	02077713          	andi	a4,a4,32
    8000444c:	fc071ae3          	bnez	a4,80004420 <uartintr+0xe0>
    80004450:	00008067          	ret
    80004454:	00008067          	ret

0000000080004458 <kinit>:
    80004458:	fc010113          	addi	sp,sp,-64
    8000445c:	02913423          	sd	s1,40(sp)
    80004460:	fffff7b7          	lui	a5,0xfffff
    80004464:	00004497          	auipc	s1,0x4
    80004468:	f8b48493          	addi	s1,s1,-117 # 800083ef <end+0xfff>
    8000446c:	02813823          	sd	s0,48(sp)
    80004470:	01313c23          	sd	s3,24(sp)
    80004474:	00f4f4b3          	and	s1,s1,a5
    80004478:	02113c23          	sd	ra,56(sp)
    8000447c:	03213023          	sd	s2,32(sp)
    80004480:	01413823          	sd	s4,16(sp)
    80004484:	01513423          	sd	s5,8(sp)
    80004488:	04010413          	addi	s0,sp,64
    8000448c:	000017b7          	lui	a5,0x1
    80004490:	01100993          	li	s3,17
    80004494:	00f487b3          	add	a5,s1,a5
    80004498:	01b99993          	slli	s3,s3,0x1b
    8000449c:	06f9e063          	bltu	s3,a5,800044fc <kinit+0xa4>
    800044a0:	00003a97          	auipc	s5,0x3
    800044a4:	f50a8a93          	addi	s5,s5,-176 # 800073f0 <end>
    800044a8:	0754ec63          	bltu	s1,s5,80004520 <kinit+0xc8>
    800044ac:	0734fa63          	bgeu	s1,s3,80004520 <kinit+0xc8>
    800044b0:	00088a37          	lui	s4,0x88
    800044b4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800044b8:	00002917          	auipc	s2,0x2
    800044bc:	c7890913          	addi	s2,s2,-904 # 80006130 <kmem>
    800044c0:	00ca1a13          	slli	s4,s4,0xc
    800044c4:	0140006f          	j	800044d8 <kinit+0x80>
    800044c8:	000017b7          	lui	a5,0x1
    800044cc:	00f484b3          	add	s1,s1,a5
    800044d0:	0554e863          	bltu	s1,s5,80004520 <kinit+0xc8>
    800044d4:	0534f663          	bgeu	s1,s3,80004520 <kinit+0xc8>
    800044d8:	00001637          	lui	a2,0x1
    800044dc:	00100593          	li	a1,1
    800044e0:	00048513          	mv	a0,s1
    800044e4:	00000097          	auipc	ra,0x0
    800044e8:	5e4080e7          	jalr	1508(ra) # 80004ac8 <__memset>
    800044ec:	00093783          	ld	a5,0(s2)
    800044f0:	00f4b023          	sd	a5,0(s1)
    800044f4:	00993023          	sd	s1,0(s2)
    800044f8:	fd4498e3          	bne	s1,s4,800044c8 <kinit+0x70>
    800044fc:	03813083          	ld	ra,56(sp)
    80004500:	03013403          	ld	s0,48(sp)
    80004504:	02813483          	ld	s1,40(sp)
    80004508:	02013903          	ld	s2,32(sp)
    8000450c:	01813983          	ld	s3,24(sp)
    80004510:	01013a03          	ld	s4,16(sp)
    80004514:	00813a83          	ld	s5,8(sp)
    80004518:	04010113          	addi	sp,sp,64
    8000451c:	00008067          	ret
    80004520:	00001517          	auipc	a0,0x1
    80004524:	d6850513          	addi	a0,a0,-664 # 80005288 <digits+0x18>
    80004528:	fffff097          	auipc	ra,0xfffff
    8000452c:	4b4080e7          	jalr	1204(ra) # 800039dc <panic>

0000000080004530 <freerange>:
    80004530:	fc010113          	addi	sp,sp,-64
    80004534:	000017b7          	lui	a5,0x1
    80004538:	02913423          	sd	s1,40(sp)
    8000453c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004540:	009504b3          	add	s1,a0,s1
    80004544:	fffff537          	lui	a0,0xfffff
    80004548:	02813823          	sd	s0,48(sp)
    8000454c:	02113c23          	sd	ra,56(sp)
    80004550:	03213023          	sd	s2,32(sp)
    80004554:	01313c23          	sd	s3,24(sp)
    80004558:	01413823          	sd	s4,16(sp)
    8000455c:	01513423          	sd	s5,8(sp)
    80004560:	01613023          	sd	s6,0(sp)
    80004564:	04010413          	addi	s0,sp,64
    80004568:	00a4f4b3          	and	s1,s1,a0
    8000456c:	00f487b3          	add	a5,s1,a5
    80004570:	06f5e463          	bltu	a1,a5,800045d8 <freerange+0xa8>
    80004574:	00003a97          	auipc	s5,0x3
    80004578:	e7ca8a93          	addi	s5,s5,-388 # 800073f0 <end>
    8000457c:	0954e263          	bltu	s1,s5,80004600 <freerange+0xd0>
    80004580:	01100993          	li	s3,17
    80004584:	01b99993          	slli	s3,s3,0x1b
    80004588:	0734fc63          	bgeu	s1,s3,80004600 <freerange+0xd0>
    8000458c:	00058a13          	mv	s4,a1
    80004590:	00002917          	auipc	s2,0x2
    80004594:	ba090913          	addi	s2,s2,-1120 # 80006130 <kmem>
    80004598:	00002b37          	lui	s6,0x2
    8000459c:	0140006f          	j	800045b0 <freerange+0x80>
    800045a0:	000017b7          	lui	a5,0x1
    800045a4:	00f484b3          	add	s1,s1,a5
    800045a8:	0554ec63          	bltu	s1,s5,80004600 <freerange+0xd0>
    800045ac:	0534fa63          	bgeu	s1,s3,80004600 <freerange+0xd0>
    800045b0:	00001637          	lui	a2,0x1
    800045b4:	00100593          	li	a1,1
    800045b8:	00048513          	mv	a0,s1
    800045bc:	00000097          	auipc	ra,0x0
    800045c0:	50c080e7          	jalr	1292(ra) # 80004ac8 <__memset>
    800045c4:	00093703          	ld	a4,0(s2)
    800045c8:	016487b3          	add	a5,s1,s6
    800045cc:	00e4b023          	sd	a4,0(s1)
    800045d0:	00993023          	sd	s1,0(s2)
    800045d4:	fcfa76e3          	bgeu	s4,a5,800045a0 <freerange+0x70>
    800045d8:	03813083          	ld	ra,56(sp)
    800045dc:	03013403          	ld	s0,48(sp)
    800045e0:	02813483          	ld	s1,40(sp)
    800045e4:	02013903          	ld	s2,32(sp)
    800045e8:	01813983          	ld	s3,24(sp)
    800045ec:	01013a03          	ld	s4,16(sp)
    800045f0:	00813a83          	ld	s5,8(sp)
    800045f4:	00013b03          	ld	s6,0(sp)
    800045f8:	04010113          	addi	sp,sp,64
    800045fc:	00008067          	ret
    80004600:	00001517          	auipc	a0,0x1
    80004604:	c8850513          	addi	a0,a0,-888 # 80005288 <digits+0x18>
    80004608:	fffff097          	auipc	ra,0xfffff
    8000460c:	3d4080e7          	jalr	980(ra) # 800039dc <panic>

0000000080004610 <kfree>:
    80004610:	fe010113          	addi	sp,sp,-32
    80004614:	00813823          	sd	s0,16(sp)
    80004618:	00113c23          	sd	ra,24(sp)
    8000461c:	00913423          	sd	s1,8(sp)
    80004620:	02010413          	addi	s0,sp,32
    80004624:	03451793          	slli	a5,a0,0x34
    80004628:	04079c63          	bnez	a5,80004680 <kfree+0x70>
    8000462c:	00003797          	auipc	a5,0x3
    80004630:	dc478793          	addi	a5,a5,-572 # 800073f0 <end>
    80004634:	00050493          	mv	s1,a0
    80004638:	04f56463          	bltu	a0,a5,80004680 <kfree+0x70>
    8000463c:	01100793          	li	a5,17
    80004640:	01b79793          	slli	a5,a5,0x1b
    80004644:	02f57e63          	bgeu	a0,a5,80004680 <kfree+0x70>
    80004648:	00001637          	lui	a2,0x1
    8000464c:	00100593          	li	a1,1
    80004650:	00000097          	auipc	ra,0x0
    80004654:	478080e7          	jalr	1144(ra) # 80004ac8 <__memset>
    80004658:	00002797          	auipc	a5,0x2
    8000465c:	ad878793          	addi	a5,a5,-1320 # 80006130 <kmem>
    80004660:	0007b703          	ld	a4,0(a5)
    80004664:	01813083          	ld	ra,24(sp)
    80004668:	01013403          	ld	s0,16(sp)
    8000466c:	00e4b023          	sd	a4,0(s1)
    80004670:	0097b023          	sd	s1,0(a5)
    80004674:	00813483          	ld	s1,8(sp)
    80004678:	02010113          	addi	sp,sp,32
    8000467c:	00008067          	ret
    80004680:	00001517          	auipc	a0,0x1
    80004684:	c0850513          	addi	a0,a0,-1016 # 80005288 <digits+0x18>
    80004688:	fffff097          	auipc	ra,0xfffff
    8000468c:	354080e7          	jalr	852(ra) # 800039dc <panic>

0000000080004690 <kalloc>:
    80004690:	fe010113          	addi	sp,sp,-32
    80004694:	00813823          	sd	s0,16(sp)
    80004698:	00913423          	sd	s1,8(sp)
    8000469c:	00113c23          	sd	ra,24(sp)
    800046a0:	02010413          	addi	s0,sp,32
    800046a4:	00002797          	auipc	a5,0x2
    800046a8:	a8c78793          	addi	a5,a5,-1396 # 80006130 <kmem>
    800046ac:	0007b483          	ld	s1,0(a5)
    800046b0:	02048063          	beqz	s1,800046d0 <kalloc+0x40>
    800046b4:	0004b703          	ld	a4,0(s1)
    800046b8:	00001637          	lui	a2,0x1
    800046bc:	00500593          	li	a1,5
    800046c0:	00048513          	mv	a0,s1
    800046c4:	00e7b023          	sd	a4,0(a5)
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	400080e7          	jalr	1024(ra) # 80004ac8 <__memset>
    800046d0:	01813083          	ld	ra,24(sp)
    800046d4:	01013403          	ld	s0,16(sp)
    800046d8:	00048513          	mv	a0,s1
    800046dc:	00813483          	ld	s1,8(sp)
    800046e0:	02010113          	addi	sp,sp,32
    800046e4:	00008067          	ret

00000000800046e8 <initlock>:
    800046e8:	ff010113          	addi	sp,sp,-16
    800046ec:	00813423          	sd	s0,8(sp)
    800046f0:	01010413          	addi	s0,sp,16
    800046f4:	00813403          	ld	s0,8(sp)
    800046f8:	00b53423          	sd	a1,8(a0)
    800046fc:	00052023          	sw	zero,0(a0)
    80004700:	00053823          	sd	zero,16(a0)
    80004704:	01010113          	addi	sp,sp,16
    80004708:	00008067          	ret

000000008000470c <acquire>:
    8000470c:	fe010113          	addi	sp,sp,-32
    80004710:	00813823          	sd	s0,16(sp)
    80004714:	00913423          	sd	s1,8(sp)
    80004718:	00113c23          	sd	ra,24(sp)
    8000471c:	01213023          	sd	s2,0(sp)
    80004720:	02010413          	addi	s0,sp,32
    80004724:	00050493          	mv	s1,a0
    80004728:	10002973          	csrr	s2,sstatus
    8000472c:	100027f3          	csrr	a5,sstatus
    80004730:	ffd7f793          	andi	a5,a5,-3
    80004734:	10079073          	csrw	sstatus,a5
    80004738:	fffff097          	auipc	ra,0xfffff
    8000473c:	8e0080e7          	jalr	-1824(ra) # 80003018 <mycpu>
    80004740:	07852783          	lw	a5,120(a0)
    80004744:	06078e63          	beqz	a5,800047c0 <acquire+0xb4>
    80004748:	fffff097          	auipc	ra,0xfffff
    8000474c:	8d0080e7          	jalr	-1840(ra) # 80003018 <mycpu>
    80004750:	07852783          	lw	a5,120(a0)
    80004754:	0004a703          	lw	a4,0(s1)
    80004758:	0017879b          	addiw	a5,a5,1
    8000475c:	06f52c23          	sw	a5,120(a0)
    80004760:	04071063          	bnez	a4,800047a0 <acquire+0x94>
    80004764:	00100713          	li	a4,1
    80004768:	00070793          	mv	a5,a4
    8000476c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004770:	0007879b          	sext.w	a5,a5
    80004774:	fe079ae3          	bnez	a5,80004768 <acquire+0x5c>
    80004778:	0ff0000f          	fence
    8000477c:	fffff097          	auipc	ra,0xfffff
    80004780:	89c080e7          	jalr	-1892(ra) # 80003018 <mycpu>
    80004784:	01813083          	ld	ra,24(sp)
    80004788:	01013403          	ld	s0,16(sp)
    8000478c:	00a4b823          	sd	a0,16(s1)
    80004790:	00013903          	ld	s2,0(sp)
    80004794:	00813483          	ld	s1,8(sp)
    80004798:	02010113          	addi	sp,sp,32
    8000479c:	00008067          	ret
    800047a0:	0104b903          	ld	s2,16(s1)
    800047a4:	fffff097          	auipc	ra,0xfffff
    800047a8:	874080e7          	jalr	-1932(ra) # 80003018 <mycpu>
    800047ac:	faa91ce3          	bne	s2,a0,80004764 <acquire+0x58>
    800047b0:	00001517          	auipc	a0,0x1
    800047b4:	ae050513          	addi	a0,a0,-1312 # 80005290 <digits+0x20>
    800047b8:	fffff097          	auipc	ra,0xfffff
    800047bc:	224080e7          	jalr	548(ra) # 800039dc <panic>
    800047c0:	00195913          	srli	s2,s2,0x1
    800047c4:	fffff097          	auipc	ra,0xfffff
    800047c8:	854080e7          	jalr	-1964(ra) # 80003018 <mycpu>
    800047cc:	00197913          	andi	s2,s2,1
    800047d0:	07252e23          	sw	s2,124(a0)
    800047d4:	f75ff06f          	j	80004748 <acquire+0x3c>

00000000800047d8 <release>:
    800047d8:	fe010113          	addi	sp,sp,-32
    800047dc:	00813823          	sd	s0,16(sp)
    800047e0:	00113c23          	sd	ra,24(sp)
    800047e4:	00913423          	sd	s1,8(sp)
    800047e8:	01213023          	sd	s2,0(sp)
    800047ec:	02010413          	addi	s0,sp,32
    800047f0:	00052783          	lw	a5,0(a0)
    800047f4:	00079a63          	bnez	a5,80004808 <release+0x30>
    800047f8:	00001517          	auipc	a0,0x1
    800047fc:	aa050513          	addi	a0,a0,-1376 # 80005298 <digits+0x28>
    80004800:	fffff097          	auipc	ra,0xfffff
    80004804:	1dc080e7          	jalr	476(ra) # 800039dc <panic>
    80004808:	01053903          	ld	s2,16(a0)
    8000480c:	00050493          	mv	s1,a0
    80004810:	fffff097          	auipc	ra,0xfffff
    80004814:	808080e7          	jalr	-2040(ra) # 80003018 <mycpu>
    80004818:	fea910e3          	bne	s2,a0,800047f8 <release+0x20>
    8000481c:	0004b823          	sd	zero,16(s1)
    80004820:	0ff0000f          	fence
    80004824:	0f50000f          	fence	iorw,ow
    80004828:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000482c:	ffffe097          	auipc	ra,0xffffe
    80004830:	7ec080e7          	jalr	2028(ra) # 80003018 <mycpu>
    80004834:	100027f3          	csrr	a5,sstatus
    80004838:	0027f793          	andi	a5,a5,2
    8000483c:	04079a63          	bnez	a5,80004890 <release+0xb8>
    80004840:	07852783          	lw	a5,120(a0)
    80004844:	02f05e63          	blez	a5,80004880 <release+0xa8>
    80004848:	fff7871b          	addiw	a4,a5,-1
    8000484c:	06e52c23          	sw	a4,120(a0)
    80004850:	00071c63          	bnez	a4,80004868 <release+0x90>
    80004854:	07c52783          	lw	a5,124(a0)
    80004858:	00078863          	beqz	a5,80004868 <release+0x90>
    8000485c:	100027f3          	csrr	a5,sstatus
    80004860:	0027e793          	ori	a5,a5,2
    80004864:	10079073          	csrw	sstatus,a5
    80004868:	01813083          	ld	ra,24(sp)
    8000486c:	01013403          	ld	s0,16(sp)
    80004870:	00813483          	ld	s1,8(sp)
    80004874:	00013903          	ld	s2,0(sp)
    80004878:	02010113          	addi	sp,sp,32
    8000487c:	00008067          	ret
    80004880:	00001517          	auipc	a0,0x1
    80004884:	a3850513          	addi	a0,a0,-1480 # 800052b8 <digits+0x48>
    80004888:	fffff097          	auipc	ra,0xfffff
    8000488c:	154080e7          	jalr	340(ra) # 800039dc <panic>
    80004890:	00001517          	auipc	a0,0x1
    80004894:	a1050513          	addi	a0,a0,-1520 # 800052a0 <digits+0x30>
    80004898:	fffff097          	auipc	ra,0xfffff
    8000489c:	144080e7          	jalr	324(ra) # 800039dc <panic>

00000000800048a0 <holding>:
    800048a0:	00052783          	lw	a5,0(a0)
    800048a4:	00079663          	bnez	a5,800048b0 <holding+0x10>
    800048a8:	00000513          	li	a0,0
    800048ac:	00008067          	ret
    800048b0:	fe010113          	addi	sp,sp,-32
    800048b4:	00813823          	sd	s0,16(sp)
    800048b8:	00913423          	sd	s1,8(sp)
    800048bc:	00113c23          	sd	ra,24(sp)
    800048c0:	02010413          	addi	s0,sp,32
    800048c4:	01053483          	ld	s1,16(a0)
    800048c8:	ffffe097          	auipc	ra,0xffffe
    800048cc:	750080e7          	jalr	1872(ra) # 80003018 <mycpu>
    800048d0:	01813083          	ld	ra,24(sp)
    800048d4:	01013403          	ld	s0,16(sp)
    800048d8:	40a48533          	sub	a0,s1,a0
    800048dc:	00153513          	seqz	a0,a0
    800048e0:	00813483          	ld	s1,8(sp)
    800048e4:	02010113          	addi	sp,sp,32
    800048e8:	00008067          	ret

00000000800048ec <push_off>:
    800048ec:	fe010113          	addi	sp,sp,-32
    800048f0:	00813823          	sd	s0,16(sp)
    800048f4:	00113c23          	sd	ra,24(sp)
    800048f8:	00913423          	sd	s1,8(sp)
    800048fc:	02010413          	addi	s0,sp,32
    80004900:	100024f3          	csrr	s1,sstatus
    80004904:	100027f3          	csrr	a5,sstatus
    80004908:	ffd7f793          	andi	a5,a5,-3
    8000490c:	10079073          	csrw	sstatus,a5
    80004910:	ffffe097          	auipc	ra,0xffffe
    80004914:	708080e7          	jalr	1800(ra) # 80003018 <mycpu>
    80004918:	07852783          	lw	a5,120(a0)
    8000491c:	02078663          	beqz	a5,80004948 <push_off+0x5c>
    80004920:	ffffe097          	auipc	ra,0xffffe
    80004924:	6f8080e7          	jalr	1784(ra) # 80003018 <mycpu>
    80004928:	07852783          	lw	a5,120(a0)
    8000492c:	01813083          	ld	ra,24(sp)
    80004930:	01013403          	ld	s0,16(sp)
    80004934:	0017879b          	addiw	a5,a5,1
    80004938:	06f52c23          	sw	a5,120(a0)
    8000493c:	00813483          	ld	s1,8(sp)
    80004940:	02010113          	addi	sp,sp,32
    80004944:	00008067          	ret
    80004948:	0014d493          	srli	s1,s1,0x1
    8000494c:	ffffe097          	auipc	ra,0xffffe
    80004950:	6cc080e7          	jalr	1740(ra) # 80003018 <mycpu>
    80004954:	0014f493          	andi	s1,s1,1
    80004958:	06952e23          	sw	s1,124(a0)
    8000495c:	fc5ff06f          	j	80004920 <push_off+0x34>

0000000080004960 <pop_off>:
    80004960:	ff010113          	addi	sp,sp,-16
    80004964:	00813023          	sd	s0,0(sp)
    80004968:	00113423          	sd	ra,8(sp)
    8000496c:	01010413          	addi	s0,sp,16
    80004970:	ffffe097          	auipc	ra,0xffffe
    80004974:	6a8080e7          	jalr	1704(ra) # 80003018 <mycpu>
    80004978:	100027f3          	csrr	a5,sstatus
    8000497c:	0027f793          	andi	a5,a5,2
    80004980:	04079663          	bnez	a5,800049cc <pop_off+0x6c>
    80004984:	07852783          	lw	a5,120(a0)
    80004988:	02f05a63          	blez	a5,800049bc <pop_off+0x5c>
    8000498c:	fff7871b          	addiw	a4,a5,-1
    80004990:	06e52c23          	sw	a4,120(a0)
    80004994:	00071c63          	bnez	a4,800049ac <pop_off+0x4c>
    80004998:	07c52783          	lw	a5,124(a0)
    8000499c:	00078863          	beqz	a5,800049ac <pop_off+0x4c>
    800049a0:	100027f3          	csrr	a5,sstatus
    800049a4:	0027e793          	ori	a5,a5,2
    800049a8:	10079073          	csrw	sstatus,a5
    800049ac:	00813083          	ld	ra,8(sp)
    800049b0:	00013403          	ld	s0,0(sp)
    800049b4:	01010113          	addi	sp,sp,16
    800049b8:	00008067          	ret
    800049bc:	00001517          	auipc	a0,0x1
    800049c0:	8fc50513          	addi	a0,a0,-1796 # 800052b8 <digits+0x48>
    800049c4:	fffff097          	auipc	ra,0xfffff
    800049c8:	018080e7          	jalr	24(ra) # 800039dc <panic>
    800049cc:	00001517          	auipc	a0,0x1
    800049d0:	8d450513          	addi	a0,a0,-1836 # 800052a0 <digits+0x30>
    800049d4:	fffff097          	auipc	ra,0xfffff
    800049d8:	008080e7          	jalr	8(ra) # 800039dc <panic>

00000000800049dc <push_on>:
    800049dc:	fe010113          	addi	sp,sp,-32
    800049e0:	00813823          	sd	s0,16(sp)
    800049e4:	00113c23          	sd	ra,24(sp)
    800049e8:	00913423          	sd	s1,8(sp)
    800049ec:	02010413          	addi	s0,sp,32
    800049f0:	100024f3          	csrr	s1,sstatus
    800049f4:	100027f3          	csrr	a5,sstatus
    800049f8:	0027e793          	ori	a5,a5,2
    800049fc:	10079073          	csrw	sstatus,a5
    80004a00:	ffffe097          	auipc	ra,0xffffe
    80004a04:	618080e7          	jalr	1560(ra) # 80003018 <mycpu>
    80004a08:	07852783          	lw	a5,120(a0)
    80004a0c:	02078663          	beqz	a5,80004a38 <push_on+0x5c>
    80004a10:	ffffe097          	auipc	ra,0xffffe
    80004a14:	608080e7          	jalr	1544(ra) # 80003018 <mycpu>
    80004a18:	07852783          	lw	a5,120(a0)
    80004a1c:	01813083          	ld	ra,24(sp)
    80004a20:	01013403          	ld	s0,16(sp)
    80004a24:	0017879b          	addiw	a5,a5,1
    80004a28:	06f52c23          	sw	a5,120(a0)
    80004a2c:	00813483          	ld	s1,8(sp)
    80004a30:	02010113          	addi	sp,sp,32
    80004a34:	00008067          	ret
    80004a38:	0014d493          	srli	s1,s1,0x1
    80004a3c:	ffffe097          	auipc	ra,0xffffe
    80004a40:	5dc080e7          	jalr	1500(ra) # 80003018 <mycpu>
    80004a44:	0014f493          	andi	s1,s1,1
    80004a48:	06952e23          	sw	s1,124(a0)
    80004a4c:	fc5ff06f          	j	80004a10 <push_on+0x34>

0000000080004a50 <pop_on>:
    80004a50:	ff010113          	addi	sp,sp,-16
    80004a54:	00813023          	sd	s0,0(sp)
    80004a58:	00113423          	sd	ra,8(sp)
    80004a5c:	01010413          	addi	s0,sp,16
    80004a60:	ffffe097          	auipc	ra,0xffffe
    80004a64:	5b8080e7          	jalr	1464(ra) # 80003018 <mycpu>
    80004a68:	100027f3          	csrr	a5,sstatus
    80004a6c:	0027f793          	andi	a5,a5,2
    80004a70:	04078463          	beqz	a5,80004ab8 <pop_on+0x68>
    80004a74:	07852783          	lw	a5,120(a0)
    80004a78:	02f05863          	blez	a5,80004aa8 <pop_on+0x58>
    80004a7c:	fff7879b          	addiw	a5,a5,-1
    80004a80:	06f52c23          	sw	a5,120(a0)
    80004a84:	07853783          	ld	a5,120(a0)
    80004a88:	00079863          	bnez	a5,80004a98 <pop_on+0x48>
    80004a8c:	100027f3          	csrr	a5,sstatus
    80004a90:	ffd7f793          	andi	a5,a5,-3
    80004a94:	10079073          	csrw	sstatus,a5
    80004a98:	00813083          	ld	ra,8(sp)
    80004a9c:	00013403          	ld	s0,0(sp)
    80004aa0:	01010113          	addi	sp,sp,16
    80004aa4:	00008067          	ret
    80004aa8:	00001517          	auipc	a0,0x1
    80004aac:	83850513          	addi	a0,a0,-1992 # 800052e0 <digits+0x70>
    80004ab0:	fffff097          	auipc	ra,0xfffff
    80004ab4:	f2c080e7          	jalr	-212(ra) # 800039dc <panic>
    80004ab8:	00001517          	auipc	a0,0x1
    80004abc:	80850513          	addi	a0,a0,-2040 # 800052c0 <digits+0x50>
    80004ac0:	fffff097          	auipc	ra,0xfffff
    80004ac4:	f1c080e7          	jalr	-228(ra) # 800039dc <panic>

0000000080004ac8 <__memset>:
    80004ac8:	ff010113          	addi	sp,sp,-16
    80004acc:	00813423          	sd	s0,8(sp)
    80004ad0:	01010413          	addi	s0,sp,16
    80004ad4:	1a060e63          	beqz	a2,80004c90 <__memset+0x1c8>
    80004ad8:	40a007b3          	neg	a5,a0
    80004adc:	0077f793          	andi	a5,a5,7
    80004ae0:	00778693          	addi	a3,a5,7
    80004ae4:	00b00813          	li	a6,11
    80004ae8:	0ff5f593          	andi	a1,a1,255
    80004aec:	fff6071b          	addiw	a4,a2,-1
    80004af0:	1b06e663          	bltu	a3,a6,80004c9c <__memset+0x1d4>
    80004af4:	1cd76463          	bltu	a4,a3,80004cbc <__memset+0x1f4>
    80004af8:	1a078e63          	beqz	a5,80004cb4 <__memset+0x1ec>
    80004afc:	00b50023          	sb	a1,0(a0)
    80004b00:	00100713          	li	a4,1
    80004b04:	1ae78463          	beq	a5,a4,80004cac <__memset+0x1e4>
    80004b08:	00b500a3          	sb	a1,1(a0)
    80004b0c:	00200713          	li	a4,2
    80004b10:	1ae78a63          	beq	a5,a4,80004cc4 <__memset+0x1fc>
    80004b14:	00b50123          	sb	a1,2(a0)
    80004b18:	00300713          	li	a4,3
    80004b1c:	18e78463          	beq	a5,a4,80004ca4 <__memset+0x1dc>
    80004b20:	00b501a3          	sb	a1,3(a0)
    80004b24:	00400713          	li	a4,4
    80004b28:	1ae78263          	beq	a5,a4,80004ccc <__memset+0x204>
    80004b2c:	00b50223          	sb	a1,4(a0)
    80004b30:	00500713          	li	a4,5
    80004b34:	1ae78063          	beq	a5,a4,80004cd4 <__memset+0x20c>
    80004b38:	00b502a3          	sb	a1,5(a0)
    80004b3c:	00700713          	li	a4,7
    80004b40:	18e79e63          	bne	a5,a4,80004cdc <__memset+0x214>
    80004b44:	00b50323          	sb	a1,6(a0)
    80004b48:	00700e93          	li	t4,7
    80004b4c:	00859713          	slli	a4,a1,0x8
    80004b50:	00e5e733          	or	a4,a1,a4
    80004b54:	01059e13          	slli	t3,a1,0x10
    80004b58:	01c76e33          	or	t3,a4,t3
    80004b5c:	01859313          	slli	t1,a1,0x18
    80004b60:	006e6333          	or	t1,t3,t1
    80004b64:	02059893          	slli	a7,a1,0x20
    80004b68:	40f60e3b          	subw	t3,a2,a5
    80004b6c:	011368b3          	or	a7,t1,a7
    80004b70:	02859813          	slli	a6,a1,0x28
    80004b74:	0108e833          	or	a6,a7,a6
    80004b78:	03059693          	slli	a3,a1,0x30
    80004b7c:	003e589b          	srliw	a7,t3,0x3
    80004b80:	00d866b3          	or	a3,a6,a3
    80004b84:	03859713          	slli	a4,a1,0x38
    80004b88:	00389813          	slli	a6,a7,0x3
    80004b8c:	00f507b3          	add	a5,a0,a5
    80004b90:	00e6e733          	or	a4,a3,a4
    80004b94:	000e089b          	sext.w	a7,t3
    80004b98:	00f806b3          	add	a3,a6,a5
    80004b9c:	00e7b023          	sd	a4,0(a5)
    80004ba0:	00878793          	addi	a5,a5,8
    80004ba4:	fed79ce3          	bne	a5,a3,80004b9c <__memset+0xd4>
    80004ba8:	ff8e7793          	andi	a5,t3,-8
    80004bac:	0007871b          	sext.w	a4,a5
    80004bb0:	01d787bb          	addw	a5,a5,t4
    80004bb4:	0ce88e63          	beq	a7,a4,80004c90 <__memset+0x1c8>
    80004bb8:	00f50733          	add	a4,a0,a5
    80004bbc:	00b70023          	sb	a1,0(a4)
    80004bc0:	0017871b          	addiw	a4,a5,1
    80004bc4:	0cc77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004bc8:	00e50733          	add	a4,a0,a4
    80004bcc:	00b70023          	sb	a1,0(a4)
    80004bd0:	0027871b          	addiw	a4,a5,2
    80004bd4:	0ac77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004bd8:	00e50733          	add	a4,a0,a4
    80004bdc:	00b70023          	sb	a1,0(a4)
    80004be0:	0037871b          	addiw	a4,a5,3
    80004be4:	0ac77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004be8:	00e50733          	add	a4,a0,a4
    80004bec:	00b70023          	sb	a1,0(a4)
    80004bf0:	0047871b          	addiw	a4,a5,4
    80004bf4:	08c77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004bf8:	00e50733          	add	a4,a0,a4
    80004bfc:	00b70023          	sb	a1,0(a4)
    80004c00:	0057871b          	addiw	a4,a5,5
    80004c04:	08c77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c08:	00e50733          	add	a4,a0,a4
    80004c0c:	00b70023          	sb	a1,0(a4)
    80004c10:	0067871b          	addiw	a4,a5,6
    80004c14:	06c77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c18:	00e50733          	add	a4,a0,a4
    80004c1c:	00b70023          	sb	a1,0(a4)
    80004c20:	0077871b          	addiw	a4,a5,7
    80004c24:	06c77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c28:	00e50733          	add	a4,a0,a4
    80004c2c:	00b70023          	sb	a1,0(a4)
    80004c30:	0087871b          	addiw	a4,a5,8
    80004c34:	04c77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c38:	00e50733          	add	a4,a0,a4
    80004c3c:	00b70023          	sb	a1,0(a4)
    80004c40:	0097871b          	addiw	a4,a5,9
    80004c44:	04c77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c48:	00e50733          	add	a4,a0,a4
    80004c4c:	00b70023          	sb	a1,0(a4)
    80004c50:	00a7871b          	addiw	a4,a5,10
    80004c54:	02c77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c58:	00e50733          	add	a4,a0,a4
    80004c5c:	00b70023          	sb	a1,0(a4)
    80004c60:	00b7871b          	addiw	a4,a5,11
    80004c64:	02c77663          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c68:	00e50733          	add	a4,a0,a4
    80004c6c:	00b70023          	sb	a1,0(a4)
    80004c70:	00c7871b          	addiw	a4,a5,12
    80004c74:	00c77e63          	bgeu	a4,a2,80004c90 <__memset+0x1c8>
    80004c78:	00e50733          	add	a4,a0,a4
    80004c7c:	00b70023          	sb	a1,0(a4)
    80004c80:	00d7879b          	addiw	a5,a5,13
    80004c84:	00c7f663          	bgeu	a5,a2,80004c90 <__memset+0x1c8>
    80004c88:	00f507b3          	add	a5,a0,a5
    80004c8c:	00b78023          	sb	a1,0(a5)
    80004c90:	00813403          	ld	s0,8(sp)
    80004c94:	01010113          	addi	sp,sp,16
    80004c98:	00008067          	ret
    80004c9c:	00b00693          	li	a3,11
    80004ca0:	e55ff06f          	j	80004af4 <__memset+0x2c>
    80004ca4:	00300e93          	li	t4,3
    80004ca8:	ea5ff06f          	j	80004b4c <__memset+0x84>
    80004cac:	00100e93          	li	t4,1
    80004cb0:	e9dff06f          	j	80004b4c <__memset+0x84>
    80004cb4:	00000e93          	li	t4,0
    80004cb8:	e95ff06f          	j	80004b4c <__memset+0x84>
    80004cbc:	00000793          	li	a5,0
    80004cc0:	ef9ff06f          	j	80004bb8 <__memset+0xf0>
    80004cc4:	00200e93          	li	t4,2
    80004cc8:	e85ff06f          	j	80004b4c <__memset+0x84>
    80004ccc:	00400e93          	li	t4,4
    80004cd0:	e7dff06f          	j	80004b4c <__memset+0x84>
    80004cd4:	00500e93          	li	t4,5
    80004cd8:	e75ff06f          	j	80004b4c <__memset+0x84>
    80004cdc:	00600e93          	li	t4,6
    80004ce0:	e6dff06f          	j	80004b4c <__memset+0x84>

0000000080004ce4 <__memmove>:
    80004ce4:	ff010113          	addi	sp,sp,-16
    80004ce8:	00813423          	sd	s0,8(sp)
    80004cec:	01010413          	addi	s0,sp,16
    80004cf0:	0e060863          	beqz	a2,80004de0 <__memmove+0xfc>
    80004cf4:	fff6069b          	addiw	a3,a2,-1
    80004cf8:	0006881b          	sext.w	a6,a3
    80004cfc:	0ea5e863          	bltu	a1,a0,80004dec <__memmove+0x108>
    80004d00:	00758713          	addi	a4,a1,7
    80004d04:	00a5e7b3          	or	a5,a1,a0
    80004d08:	40a70733          	sub	a4,a4,a0
    80004d0c:	0077f793          	andi	a5,a5,7
    80004d10:	00f73713          	sltiu	a4,a4,15
    80004d14:	00174713          	xori	a4,a4,1
    80004d18:	0017b793          	seqz	a5,a5
    80004d1c:	00e7f7b3          	and	a5,a5,a4
    80004d20:	10078863          	beqz	a5,80004e30 <__memmove+0x14c>
    80004d24:	00900793          	li	a5,9
    80004d28:	1107f463          	bgeu	a5,a6,80004e30 <__memmove+0x14c>
    80004d2c:	0036581b          	srliw	a6,a2,0x3
    80004d30:	fff8081b          	addiw	a6,a6,-1
    80004d34:	02081813          	slli	a6,a6,0x20
    80004d38:	01d85893          	srli	a7,a6,0x1d
    80004d3c:	00858813          	addi	a6,a1,8
    80004d40:	00058793          	mv	a5,a1
    80004d44:	00050713          	mv	a4,a0
    80004d48:	01088833          	add	a6,a7,a6
    80004d4c:	0007b883          	ld	a7,0(a5)
    80004d50:	00878793          	addi	a5,a5,8
    80004d54:	00870713          	addi	a4,a4,8
    80004d58:	ff173c23          	sd	a7,-8(a4)
    80004d5c:	ff0798e3          	bne	a5,a6,80004d4c <__memmove+0x68>
    80004d60:	ff867713          	andi	a4,a2,-8
    80004d64:	02071793          	slli	a5,a4,0x20
    80004d68:	0207d793          	srli	a5,a5,0x20
    80004d6c:	00f585b3          	add	a1,a1,a5
    80004d70:	40e686bb          	subw	a3,a3,a4
    80004d74:	00f507b3          	add	a5,a0,a5
    80004d78:	06e60463          	beq	a2,a4,80004de0 <__memmove+0xfc>
    80004d7c:	0005c703          	lbu	a4,0(a1)
    80004d80:	00e78023          	sb	a4,0(a5)
    80004d84:	04068e63          	beqz	a3,80004de0 <__memmove+0xfc>
    80004d88:	0015c603          	lbu	a2,1(a1)
    80004d8c:	00100713          	li	a4,1
    80004d90:	00c780a3          	sb	a2,1(a5)
    80004d94:	04e68663          	beq	a3,a4,80004de0 <__memmove+0xfc>
    80004d98:	0025c603          	lbu	a2,2(a1)
    80004d9c:	00200713          	li	a4,2
    80004da0:	00c78123          	sb	a2,2(a5)
    80004da4:	02e68e63          	beq	a3,a4,80004de0 <__memmove+0xfc>
    80004da8:	0035c603          	lbu	a2,3(a1)
    80004dac:	00300713          	li	a4,3
    80004db0:	00c781a3          	sb	a2,3(a5)
    80004db4:	02e68663          	beq	a3,a4,80004de0 <__memmove+0xfc>
    80004db8:	0045c603          	lbu	a2,4(a1)
    80004dbc:	00400713          	li	a4,4
    80004dc0:	00c78223          	sb	a2,4(a5)
    80004dc4:	00e68e63          	beq	a3,a4,80004de0 <__memmove+0xfc>
    80004dc8:	0055c603          	lbu	a2,5(a1)
    80004dcc:	00500713          	li	a4,5
    80004dd0:	00c782a3          	sb	a2,5(a5)
    80004dd4:	00e68663          	beq	a3,a4,80004de0 <__memmove+0xfc>
    80004dd8:	0065c703          	lbu	a4,6(a1)
    80004ddc:	00e78323          	sb	a4,6(a5)
    80004de0:	00813403          	ld	s0,8(sp)
    80004de4:	01010113          	addi	sp,sp,16
    80004de8:	00008067          	ret
    80004dec:	02061713          	slli	a4,a2,0x20
    80004df0:	02075713          	srli	a4,a4,0x20
    80004df4:	00e587b3          	add	a5,a1,a4
    80004df8:	f0f574e3          	bgeu	a0,a5,80004d00 <__memmove+0x1c>
    80004dfc:	02069613          	slli	a2,a3,0x20
    80004e00:	02065613          	srli	a2,a2,0x20
    80004e04:	fff64613          	not	a2,a2
    80004e08:	00e50733          	add	a4,a0,a4
    80004e0c:	00c78633          	add	a2,a5,a2
    80004e10:	fff7c683          	lbu	a3,-1(a5)
    80004e14:	fff78793          	addi	a5,a5,-1
    80004e18:	fff70713          	addi	a4,a4,-1
    80004e1c:	00d70023          	sb	a3,0(a4)
    80004e20:	fec798e3          	bne	a5,a2,80004e10 <__memmove+0x12c>
    80004e24:	00813403          	ld	s0,8(sp)
    80004e28:	01010113          	addi	sp,sp,16
    80004e2c:	00008067          	ret
    80004e30:	02069713          	slli	a4,a3,0x20
    80004e34:	02075713          	srli	a4,a4,0x20
    80004e38:	00170713          	addi	a4,a4,1
    80004e3c:	00e50733          	add	a4,a0,a4
    80004e40:	00050793          	mv	a5,a0
    80004e44:	0005c683          	lbu	a3,0(a1)
    80004e48:	00178793          	addi	a5,a5,1
    80004e4c:	00158593          	addi	a1,a1,1
    80004e50:	fed78fa3          	sb	a3,-1(a5)
    80004e54:	fee798e3          	bne	a5,a4,80004e44 <__memmove+0x160>
    80004e58:	f89ff06f          	j	80004de0 <__memmove+0xfc>

0000000080004e5c <__putc>:
    80004e5c:	fe010113          	addi	sp,sp,-32
    80004e60:	00813823          	sd	s0,16(sp)
    80004e64:	00113c23          	sd	ra,24(sp)
    80004e68:	02010413          	addi	s0,sp,32
    80004e6c:	00050793          	mv	a5,a0
    80004e70:	fef40593          	addi	a1,s0,-17
    80004e74:	00100613          	li	a2,1
    80004e78:	00000513          	li	a0,0
    80004e7c:	fef407a3          	sb	a5,-17(s0)
    80004e80:	fffff097          	auipc	ra,0xfffff
    80004e84:	b3c080e7          	jalr	-1220(ra) # 800039bc <console_write>
    80004e88:	01813083          	ld	ra,24(sp)
    80004e8c:	01013403          	ld	s0,16(sp)
    80004e90:	02010113          	addi	sp,sp,32
    80004e94:	00008067          	ret

0000000080004e98 <__getc>:
    80004e98:	fe010113          	addi	sp,sp,-32
    80004e9c:	00813823          	sd	s0,16(sp)
    80004ea0:	00113c23          	sd	ra,24(sp)
    80004ea4:	02010413          	addi	s0,sp,32
    80004ea8:	fe840593          	addi	a1,s0,-24
    80004eac:	00100613          	li	a2,1
    80004eb0:	00000513          	li	a0,0
    80004eb4:	fffff097          	auipc	ra,0xfffff
    80004eb8:	ae8080e7          	jalr	-1304(ra) # 8000399c <console_read>
    80004ebc:	fe844503          	lbu	a0,-24(s0)
    80004ec0:	01813083          	ld	ra,24(sp)
    80004ec4:	01013403          	ld	s0,16(sp)
    80004ec8:	02010113          	addi	sp,sp,32
    80004ecc:	00008067          	ret

0000000080004ed0 <console_handler>:
    80004ed0:	fe010113          	addi	sp,sp,-32
    80004ed4:	00813823          	sd	s0,16(sp)
    80004ed8:	00113c23          	sd	ra,24(sp)
    80004edc:	00913423          	sd	s1,8(sp)
    80004ee0:	02010413          	addi	s0,sp,32
    80004ee4:	14202773          	csrr	a4,scause
    80004ee8:	100027f3          	csrr	a5,sstatus
    80004eec:	0027f793          	andi	a5,a5,2
    80004ef0:	06079e63          	bnez	a5,80004f6c <console_handler+0x9c>
    80004ef4:	00074c63          	bltz	a4,80004f0c <console_handler+0x3c>
    80004ef8:	01813083          	ld	ra,24(sp)
    80004efc:	01013403          	ld	s0,16(sp)
    80004f00:	00813483          	ld	s1,8(sp)
    80004f04:	02010113          	addi	sp,sp,32
    80004f08:	00008067          	ret
    80004f0c:	0ff77713          	andi	a4,a4,255
    80004f10:	00900793          	li	a5,9
    80004f14:	fef712e3          	bne	a4,a5,80004ef8 <console_handler+0x28>
    80004f18:	ffffe097          	auipc	ra,0xffffe
    80004f1c:	6dc080e7          	jalr	1756(ra) # 800035f4 <plic_claim>
    80004f20:	00a00793          	li	a5,10
    80004f24:	00050493          	mv	s1,a0
    80004f28:	02f50c63          	beq	a0,a5,80004f60 <console_handler+0x90>
    80004f2c:	fc0506e3          	beqz	a0,80004ef8 <console_handler+0x28>
    80004f30:	00050593          	mv	a1,a0
    80004f34:	00000517          	auipc	a0,0x0
    80004f38:	2b450513          	addi	a0,a0,692 # 800051e8 <CONSOLE_STATUS+0x1d8>
    80004f3c:	fffff097          	auipc	ra,0xfffff
    80004f40:	afc080e7          	jalr	-1284(ra) # 80003a38 <__printf>
    80004f44:	01013403          	ld	s0,16(sp)
    80004f48:	01813083          	ld	ra,24(sp)
    80004f4c:	00048513          	mv	a0,s1
    80004f50:	00813483          	ld	s1,8(sp)
    80004f54:	02010113          	addi	sp,sp,32
    80004f58:	ffffe317          	auipc	t1,0xffffe
    80004f5c:	6d430067          	jr	1748(t1) # 8000362c <plic_complete>
    80004f60:	fffff097          	auipc	ra,0xfffff
    80004f64:	3e0080e7          	jalr	992(ra) # 80004340 <uartintr>
    80004f68:	fddff06f          	j	80004f44 <console_handler+0x74>
    80004f6c:	00000517          	auipc	a0,0x0
    80004f70:	37c50513          	addi	a0,a0,892 # 800052e8 <digits+0x78>
    80004f74:	fffff097          	auipc	ra,0xfffff
    80004f78:	a68080e7          	jalr	-1432(ra) # 800039dc <panic>
	...
