
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	ee813103          	ld	sp,-280(sp) # 80008ee8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	0ad040ef          	jal	ra,800048c8 <start>

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
    8000100c:	3f5000ef          	jal	ra,80001c00 <_ZN3PCB10getContextEv>
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
    800010a0:	361000ef          	jal	ra,80001c00 <_ZN3PCB10getContextEv>

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
    800015d4:	00008797          	auipc	a5,0x8
    800015d8:	92c7b783          	ld	a5,-1748(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    8000161c:	00002097          	auipc	ra,0x2
    80001620:	730080e7          	jalr	1840(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
    80001624:	00008797          	auipc	a5,0x8
    80001628:	8dc7b783          	ld	a5,-1828(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001650:	00003097          	auipc	ra,0x3
    80001654:	86c080e7          	jalr	-1940(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
    80001658:	00008797          	auipc	a5,0x8
    8000165c:	8a87b783          	ld	a5,-1880(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001660:	0007b783          	ld	a5,0(a5)
    80001664:	0187b783          	ld	a5,24(a5)
    80001668:	04a7b823          	sd	a0,80(a5)
                break;
    8000166c:	fcdff06f          	j	80001638 <interruptHandler+0x110>
                PCB::timeSliceCounter = 0;
    80001670:	00008797          	auipc	a5,0x8
    80001674:	8707b783          	ld	a5,-1936(a5) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001678:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	458080e7          	jalr	1112(ra) # 80001ad4 <_ZN3PCB8dispatchEv>
                break;
    80001684:	fb5ff06f          	j	80001638 <interruptHandler+0x110>
                PCB::running->finished = true;
    80001688:	00100793          	li	a5,1
    8000168c:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001690:	00008797          	auipc	a5,0x8
    80001694:	8507b783          	ld	a5,-1968(a5) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001698:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000169c:	00000097          	auipc	ra,0x0
    800016a0:	438080e7          	jalr	1080(ra) # 80001ad4 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016a4:	00008797          	auipc	a5,0x8
    800016a8:	85c7b783          	ld	a5,-1956(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800016c8:	348080e7          	jalr	840(ra) # 80002a0c <_ZN9Scheduler3putEP3PCB>
                break;
    800016cc:	f6dff06f          	j	80001638 <interruptHandler+0x110>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016d0:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016d4:	06873583          	ld	a1,104(a4)
    800016d8:	06073503          	ld	a0,96(a4)
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	688080e7          	jalr	1672(ra) # 80001d64 <_ZN3PCB14createProccessEPFvvEPv>
    800016e4:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016e8:	00008797          	auipc	a5,0x8
    800016ec:	8187b783          	ld	a5,-2024(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001738:	ddc080e7          	jalr	-548(ra) # 80003510 <_ZN3SCBnwEm>
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
    80001750:	7b47b783          	ld	a5,1972(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001754:	0007b783          	ld	a5,0(a5)
    80001758:	0187b783          	ld	a5,24(a5)
    8000175c:	0497b823          	sd	s1,80(a5)
                break;
    80001760:	ed9ff06f          	j	80001638 <interruptHandler+0x110>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001764:	05873503          	ld	a0,88(a4)
    80001768:	00002097          	auipc	ra,0x2
    8000176c:	c84080e7          	jalr	-892(ra) # 800033ec <_ZN3SCB4waitEv>
    80001770:	00007797          	auipc	a5,0x7
    80001774:	7907b783          	ld	a5,1936(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001778:	0007b783          	ld	a5,0(a5)
    8000177c:	0187b783          	ld	a5,24(a5)
    80001780:	04a7b823          	sd	a0,80(a5)
                break;
    80001784:	eb5ff06f          	j	80001638 <interruptHandler+0x110>
                sem->signal();
    80001788:	05873503          	ld	a0,88(a4)
    8000178c:	00002097          	auipc	ra,0x2
    80001790:	cf4080e7          	jalr	-780(ra) # 80003480 <_ZN3SCB6signalEv>
                break;
    80001794:	ea5ff06f          	j	80001638 <interruptHandler+0x110>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001798:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000179c:	00048513          	mv	a0,s1
    800017a0:	00002097          	auipc	ra,0x2
    800017a4:	dc0080e7          	jalr	-576(ra) # 80003560 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017a8:	e80488e3          	beqz	s1,80001638 <interruptHandler+0x110>
    800017ac:	00048513          	mv	a0,s1
    800017b0:	00002097          	auipc	ra,0x2
    800017b4:	d88080e7          	jalr	-632(ra) # 80003538 <_ZN3SCBdlEPv>
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
    800017d8:	6f453503          	ld	a0,1780(a0) # 80008ec8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017dc:	00001097          	auipc	ra,0x1
    800017e0:	b40080e7          	jalr	-1216(ra) # 8000231c <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    800017e4:	00007797          	auipc	a5,0x7
    800017e8:	72c7b783          	ld	a5,1836(a5) # 80008f10 <_GLOBAL_OFFSET_TABLE_+0x70>
    800017ec:	0007b503          	ld	a0,0(a5)
    800017f0:	00002097          	auipc	ra,0x2
    800017f4:	c90080e7          	jalr	-880(ra) # 80003480 <_ZN3SCB6signalEv>
                break;
    800017f8:	e41ff06f          	j	80001638 <interruptHandler+0x110>
                CCB::semInput->signal();
    800017fc:	00007797          	auipc	a5,0x7
    80001800:	72c7b783          	ld	a5,1836(a5) # 80008f28 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001804:	0007b503          	ld	a0,0(a5)
    80001808:	00002097          	auipc	ra,0x2
    8000180c:	c78080e7          	jalr	-904(ra) # 80003480 <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001810:	00007517          	auipc	a0,0x7
    80001814:	6c053503          	ld	a0,1728(a0) # 80008ed0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001818:	00001097          	auipc	ra,0x1
    8000181c:	c8c080e7          	jalr	-884(ra) # 800024a4 <_ZN8IOBuffer9peekFrontEv>
    80001820:	00051e63          	bnez	a0,8000183c <interruptHandler+0x314>
                    CCB::inputBufferEmpty->wait();
    80001824:	00007797          	auipc	a5,0x7
    80001828:	6f47b783          	ld	a5,1780(a5) # 80008f18 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000182c:	0007b503          	ld	a0,0(a5)
    80001830:	00002097          	auipc	ra,0x2
    80001834:	bbc080e7          	jalr	-1092(ra) # 800033ec <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001838:	fd9ff06f          	j	80001810 <interruptHandler+0x2e8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000183c:	00007517          	auipc	a0,0x7
    80001840:	69453503          	ld	a0,1684(a0) # 80008ed0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001844:	00001097          	auipc	ra,0x1
    80001848:	bd0080e7          	jalr	-1072(ra) # 80002414 <_ZN8IOBuffer8popFrontEv>
    8000184c:	00007797          	auipc	a5,0x7
    80001850:	6b47b783          	ld	a5,1716(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    80001878:	66c4b483          	ld	s1,1644(s1) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000187c:	0004b783          	ld	a5,0(s1)
    80001880:	00178793          	addi	a5,a5,1
    80001884:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	0f0080e7          	jalr	240(ra) # 80001978 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001890:	00007797          	auipc	a5,0x7
    80001894:	6707b783          	ld	a5,1648(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
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
    800018bc:	21c080e7          	jalr	540(ra) # 80001ad4 <_ZN3PCB8dispatchEv>
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
    800018d4:	00004097          	auipc	ra,0x4
    800018d8:	850080e7          	jalr	-1968(ra) # 80005124 <plic_claim>
        plic_complete(code);
    800018dc:	00004097          	auipc	ra,0x4
    800018e0:	880080e7          	jalr	-1920(ra) # 8000515c <plic_complete>
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
    800018f8:	68c7b783          	ld	a5,1676(a5) # 80008f80 <_ZN17SleepingProcesses4headE>
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
    8000195c:	62a73423          	sd	a0,1576(a4) # 80008f80 <_ZN17SleepingProcesses4headE>
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
    8000197c:	60853503          	ld	a0,1544(a0) # 80008f80 <_ZN17SleepingProcesses4headE>
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
    800019cc:	044080e7          	jalr	68(ra) # 80002a0c <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019d0:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019d4:	fe0490e3          	bnez	s1,800019b4 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019d8:	00007797          	auipc	a5,0x7
    800019dc:	5aa7b423          	sd	a0,1448(a5) # 80008f80 <_ZN17SleepingProcesses4headE>
}
    800019e0:	01813083          	ld	ra,24(sp)
    800019e4:	01013403          	ld	s0,16(sp)
    800019e8:	00813483          	ld	s1,8(sp)
    800019ec:	02010113          	addi	sp,sp,32
    800019f0:	00008067          	ret
    head = curr;
    800019f4:	00007797          	auipc	a5,0x7
    800019f8:	58a7b623          	sd	a0,1420(a5) # 80008f80 <_ZN17SleepingProcesses4headE>
    800019fc:	00008067          	ret
    80001a00:	00008067          	ret

0000000080001a04 <_ZN3PCB12createObjectEPv>:
#include "../h/slab.h"

PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

void PCB::createObject(void* addr) {
    80001a04:	ff010113          	addi	sp,sp,-16
    80001a08:	00813423          	sd	s0,8(sp)
    80001a0c:	01010413          	addi	s0,sp,16
}
    80001a10:	00813403          	ld	s0,8(sp)
    80001a14:	01010113          	addi	sp,sp,16
    80001a18:	00008067          	ret

0000000080001a1c <_ZN3PCB10freeObjectEPv>:

void PCB::freeObject(void* addr) {
    80001a1c:	fe010113          	addi	sp,sp,-32
    80001a20:	00113c23          	sd	ra,24(sp)
    80001a24:	00813823          	sd	s0,16(sp)
    80001a28:	00913423          	sd	s1,8(sp)
    80001a2c:	02010413          	addi	s0,sp,32
    80001a30:	00050493          	mv	s1,a0
    PCB* object = (PCB*)addr;
    delete[] object->stack;
    80001a34:	00853503          	ld	a0,8(a0)
    80001a38:	00050663          	beqz	a0,80001a44 <_ZN3PCB10freeObjectEPv+0x28>
    80001a3c:	00001097          	auipc	ra,0x1
    80001a40:	400080e7          	jalr	1024(ra) # 80002e3c <_ZdaPv>
    delete[] object->sysStack;
    80001a44:	0104b503          	ld	a0,16(s1)
    80001a48:	00050663          	beqz	a0,80001a54 <_ZN3PCB10freeObjectEPv+0x38>
    80001a4c:	00001097          	auipc	ra,0x1
    80001a50:	3f0080e7          	jalr	1008(ra) # 80002e3c <_ZdaPv>
}
    80001a54:	01813083          	ld	ra,24(sp)
    80001a58:	01013403          	ld	s0,16(sp)
    80001a5c:	00813483          	ld	s1,8(sp)
    80001a60:	02010113          	addi	sp,sp,32
    80001a64:	00008067          	ret

0000000080001a68 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a68:	ff010113          	addi	sp,sp,-16
    80001a6c:	00113423          	sd	ra,8(sp)
    80001a70:	00813023          	sd	s0,0(sp)
    80001a74:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	a90080e7          	jalr	-1392(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a80:	00007797          	auipc	a5,0x7
    80001a84:	5087b783          	ld	a5,1288(a5) # 80008f88 <_ZN3PCB7runningE>
    80001a88:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a8c:	00070513          	mv	a0,a4
    running->main();
    80001a90:	0207b783          	ld	a5,32(a5)
    80001a94:	000780e7          	jalr	a5
    thread_exit();
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	808080e7          	jalr	-2040(ra) # 800012a0 <_Z11thread_exitv>
}
    80001aa0:	00813083          	ld	ra,8(sp)
    80001aa4:	00013403          	ld	s0,0(sp)
    80001aa8:	01010113          	addi	sp,sp,16
    80001aac:	00008067          	ret

0000000080001ab0 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001ab0:	ff010113          	addi	sp,sp,-16
    80001ab4:	00813423          	sd	s0,8(sp)
    80001ab8:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001abc:	01300793          	li	a5,19
    80001ac0:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001ac4:	00000073          	ecall
}
    80001ac8:	00813403          	ld	s0,8(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret

0000000080001ad4 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001ad4:	fe010113          	addi	sp,sp,-32
    80001ad8:	00113c23          	sd	ra,24(sp)
    80001adc:	00813823          	sd	s0,16(sp)
    80001ae0:	00913423          	sd	s1,8(sp)
    80001ae4:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001ae8:	00007497          	auipc	s1,0x7
    80001aec:	4a04b483          	ld	s1,1184(s1) # 80008f88 <_ZN3PCB7runningE>
        return finished;
    80001af0:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001af4:	00079663          	bnez	a5,80001b00 <_ZN3PCB8dispatchEv+0x2c>
    80001af8:	0294c783          	lbu	a5,41(s1)
    80001afc:	04078263          	beqz	a5,80001b40 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b00:	00001097          	auipc	ra,0x1
    80001b04:	f64080e7          	jalr	-156(ra) # 80002a64 <_ZN9Scheduler3getEv>
    80001b08:	00007797          	auipc	a5,0x7
    80001b0c:	48a7b023          	sd	a0,1152(a5) # 80008f88 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001b10:	04854783          	lbu	a5,72(a0)
    80001b14:	02078e63          	beqz	a5,80001b50 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b18:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001b1c:	01853583          	ld	a1,24(a0)
    80001b20:	0184b503          	ld	a0,24(s1)
    80001b24:	fffff097          	auipc	ra,0xfffff
    80001b28:	604080e7          	jalr	1540(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001b2c:	01813083          	ld	ra,24(sp)
    80001b30:	01013403          	ld	s0,16(sp)
    80001b34:	00813483          	ld	s1,8(sp)
    80001b38:	02010113          	addi	sp,sp,32
    80001b3c:	00008067          	ret
        Scheduler::put(old);
    80001b40:	00048513          	mv	a0,s1
    80001b44:	00001097          	auipc	ra,0x1
    80001b48:	ec8080e7          	jalr	-312(ra) # 80002a0c <_ZN9Scheduler3putEP3PCB>
    80001b4c:	fb5ff06f          	j	80001b00 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b50:	01853583          	ld	a1,24(a0)
    80001b54:	0184b503          	ld	a0,24(s1)
    80001b58:	fffff097          	auipc	ra,0xfffff
    80001b5c:	5e4080e7          	jalr	1508(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b60:	fcdff06f          	j	80001b2c <_ZN3PCB8dispatchEv+0x58>

0000000080001b64 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001b64:	fe010113          	addi	sp,sp,-32
    80001b68:	00113c23          	sd	ra,24(sp)
    80001b6c:	00813823          	sd	s0,16(sp)
    80001b70:	00913423          	sd	s1,8(sp)
    80001b74:	02010413          	addi	s0,sp,32
    80001b78:	00050493          	mv	s1,a0
    delete[] stack;
    80001b7c:	00853503          	ld	a0,8(a0)
    80001b80:	00050663          	beqz	a0,80001b8c <_ZN3PCBD1Ev+0x28>
    80001b84:	00001097          	auipc	ra,0x1
    80001b88:	2b8080e7          	jalr	696(ra) # 80002e3c <_ZdaPv>
    delete[] sysStack;
    80001b8c:	0104b503          	ld	a0,16(s1)
    80001b90:	00050663          	beqz	a0,80001b9c <_ZN3PCBD1Ev+0x38>
    80001b94:	00001097          	auipc	ra,0x1
    80001b98:	2a8080e7          	jalr	680(ra) # 80002e3c <_ZdaPv>
}
    80001b9c:	01813083          	ld	ra,24(sp)
    80001ba0:	01013403          	ld	s0,16(sp)
    80001ba4:	00813483          	ld	s1,8(sp)
    80001ba8:	02010113          	addi	sp,sp,32
    80001bac:	00008067          	ret

0000000080001bb0 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001bb0:	ff010113          	addi	sp,sp,-16
    80001bb4:	00113423          	sd	ra,8(sp)
    80001bb8:	00813023          	sd	s0,0(sp)
    80001bbc:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001bc0:	00002097          	auipc	ra,0x2
    80001bc4:	18c080e7          	jalr	396(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
}
    80001bc8:	00813083          	ld	ra,8(sp)
    80001bcc:	00013403          	ld	s0,0(sp)
    80001bd0:	01010113          	addi	sp,sp,16
    80001bd4:	00008067          	ret

0000000080001bd8 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001bd8:	ff010113          	addi	sp,sp,-16
    80001bdc:	00113423          	sd	ra,8(sp)
    80001be0:	00813023          	sd	s0,0(sp)
    80001be4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001be8:	00002097          	auipc	ra,0x2
    80001bec:	2d4080e7          	jalr	724(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001bf0:	00813083          	ld	ra,8(sp)
    80001bf4:	00013403          	ld	s0,0(sp)
    80001bf8:	01010113          	addi	sp,sp,16
    80001bfc:	00008067          	ret

0000000080001c00 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001c00:	ff010113          	addi	sp,sp,-16
    80001c04:	00813423          	sd	s0,8(sp)
    80001c08:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001c0c:	00007797          	auipc	a5,0x7
    80001c10:	37c7b783          	ld	a5,892(a5) # 80008f88 <_ZN3PCB7runningE>
    80001c14:	0187b503          	ld	a0,24(a5)
    80001c18:	00813403          	ld	s0,8(sp)
    80001c1c:	01010113          	addi	sp,sp,16
    80001c20:	00008067          	ret

0000000080001c24 <_ZN3PCB10initObjectEPFvvEmPv>:

void PCB::initObject(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001c24:	fe010113          	addi	sp,sp,-32
    80001c28:	00113c23          	sd	ra,24(sp)
    80001c2c:	00813823          	sd	s0,16(sp)
    80001c30:	00913423          	sd	s1,8(sp)
    80001c34:	02010413          	addi	s0,sp,32
    80001c38:	00050493          	mv	s1,a0
    finished = blocked = semDeleted = false;
    80001c3c:	02050523          	sb	zero,42(a0)
    80001c40:	020504a3          	sb	zero,41(a0)
    80001c44:	02050423          	sb	zero,40(a0)
    main = main_;
    80001c48:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001c4c:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001c50:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001c54:	10800513          	li	a0,264
    80001c58:	00002097          	auipc	ra,0x2
    80001c5c:	0f4080e7          	jalr	244(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
    80001c60:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001c64:	00008537          	lui	a0,0x8
    80001c68:	00002097          	auipc	ra,0x2
    80001c6c:	0e4080e7          	jalr	228(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
    80001c70:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001c74:	000087b7          	lui	a5,0x8
    80001c78:	00f50533          	add	a0,a0,a5
    80001c7c:	0184b783          	ld	a5,24(s1)
    80001c80:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001c84:	0184b783          	ld	a5,24(s1)
    80001c88:	00000717          	auipc	a4,0x0
    80001c8c:	de070713          	addi	a4,a4,-544 # 80001a68 <_ZN3PCB15proccessWrapperEv>
    80001c90:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001c94:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001c98:	0204b783          	ld	a5,32(s1)
    80001c9c:	00078c63          	beqz	a5,80001cb4 <_ZN3PCB10initObjectEPFvvEmPv+0x90>
}
    80001ca0:	01813083          	ld	ra,24(sp)
    80001ca4:	01013403          	ld	s0,16(sp)
    80001ca8:	00813483          	ld	s1,8(sp)
    80001cac:	02010113          	addi	sp,sp,32
    80001cb0:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001cb4:	04048423          	sb	zero,72(s1)
}
    80001cb8:	fe9ff06f          	j	80001ca0 <_ZN3PCB10initObjectEPFvvEmPv+0x7c>

0000000080001cbc <_ZN3PCB16createSysProcessEPFvvEPv>:
PCB *PCB::createSysProcess(PCB::processMain main, void* arguments) {
    80001cbc:	fd010113          	addi	sp,sp,-48
    80001cc0:	02113423          	sd	ra,40(sp)
    80001cc4:	02813023          	sd	s0,32(sp)
    80001cc8:	00913c23          	sd	s1,24(sp)
    80001ccc:	01213823          	sd	s2,16(sp)
    80001cd0:	01313423          	sd	s3,8(sp)
    80001cd4:	03010413          	addi	s0,sp,48
    80001cd8:	00050913          	mv	s2,a0
    80001cdc:	00058993          	mv	s3,a1
    PCB* object = (PCB*) kmem_cache_alloc(pcbCache);
    80001ce0:	00007517          	auipc	a0,0x7
    80001ce4:	2b053503          	ld	a0,688(a0) # 80008f90 <_ZN3PCB8pcbCacheE>
    80001ce8:	00002097          	auipc	ra,0x2
    80001cec:	400080e7          	jalr	1024(ra) # 800040e8 <_Z16kmem_cache_allocP12kmem_cache_s>
    80001cf0:	00050493          	mv	s1,a0
    object->initObject(main, DEFAULT_TIME_SLICE, arguments);
    80001cf4:	00098693          	mv	a3,s3
    80001cf8:	00200613          	li	a2,2
    80001cfc:	00090593          	mv	a1,s2
    80001d00:	00000097          	auipc	ra,0x0
    80001d04:	f24080e7          	jalr	-220(ra) # 80001c24 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001d08:	00048513          	mv	a0,s1
    80001d0c:	02813083          	ld	ra,40(sp)
    80001d10:	02013403          	ld	s0,32(sp)
    80001d14:	01813483          	ld	s1,24(sp)
    80001d18:	01013903          	ld	s2,16(sp)
    80001d1c:	00813983          	ld	s3,8(sp)
    80001d20:	03010113          	addi	sp,sp,48
    80001d24:	00008067          	ret

0000000080001d28 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001d28:	ff010113          	addi	sp,sp,-16
    80001d2c:	00113423          	sd	ra,8(sp)
    80001d30:	00813023          	sd	s0,0(sp)
    80001d34:	01010413          	addi	s0,sp,16
    80001d38:	00053023          	sd	zero,0(a0)
    80001d3c:	00053c23          	sd	zero,24(a0)
    80001d40:	02053823          	sd	zero,48(a0)
    80001d44:	00100713          	li	a4,1
    80001d48:	04e50423          	sb	a4,72(a0)
    initObject(main_, timeSlice_, mainArguments_);
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	ed8080e7          	jalr	-296(ra) # 80001c24 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001d54:	00813083          	ld	ra,8(sp)
    80001d58:	00013403          	ld	s0,0(sp)
    80001d5c:	01010113          	addi	sp,sp,16
    80001d60:	00008067          	ret

0000000080001d64 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001d64:	fd010113          	addi	sp,sp,-48
    80001d68:	02113423          	sd	ra,40(sp)
    80001d6c:	02813023          	sd	s0,32(sp)
    80001d70:	00913c23          	sd	s1,24(sp)
    80001d74:	01213823          	sd	s2,16(sp)
    80001d78:	01313423          	sd	s3,8(sp)
    80001d7c:	03010413          	addi	s0,sp,48
    80001d80:	00050913          	mv	s2,a0
    80001d84:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001d88:	05000513          	li	a0,80
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	e24080e7          	jalr	-476(ra) # 80001bb0 <_ZN3PCBnwEm>
    80001d94:	00050493          	mv	s1,a0
    80001d98:	00098693          	mv	a3,s3
    80001d9c:	00200613          	li	a2,2
    80001da0:	00090593          	mv	a1,s2
    80001da4:	00000097          	auipc	ra,0x0
    80001da8:	f84080e7          	jalr	-124(ra) # 80001d28 <_ZN3PCBC1EPFvvEmPv>
    80001dac:	0200006f          	j	80001dcc <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001db0:	00050913          	mv	s2,a0
    80001db4:	00048513          	mv	a0,s1
    80001db8:	00000097          	auipc	ra,0x0
    80001dbc:	e20080e7          	jalr	-480(ra) # 80001bd8 <_ZN3PCBdlEPv>
    80001dc0:	00090513          	mv	a0,s2
    80001dc4:	00008097          	auipc	ra,0x8
    80001dc8:	384080e7          	jalr	900(ra) # 8000a148 <_Unwind_Resume>
}
    80001dcc:	00048513          	mv	a0,s1
    80001dd0:	02813083          	ld	ra,40(sp)
    80001dd4:	02013403          	ld	s0,32(sp)
    80001dd8:	01813483          	ld	s1,24(sp)
    80001ddc:	01013903          	ld	s2,16(sp)
    80001de0:	00813983          	ld	s3,8(sp)
    80001de4:	03010113          	addi	sp,sp,48
    80001de8:	00008067          	ret

0000000080001dec <_ZN3PCB12initPCBCacheEv>:

void PCB::initPCBCache() {
    80001dec:	ff010113          	addi	sp,sp,-16
    80001df0:	00113423          	sd	ra,8(sp)
    80001df4:	00813023          	sd	s0,0(sp)
    80001df8:	01010413          	addi	s0,sp,16
    pcbCache = (kmem_cache_t*)kmem_cache_create("PCB", sizeof(PCB), &createObject, &freeObject);
    80001dfc:	00000697          	auipc	a3,0x0
    80001e00:	c2068693          	addi	a3,a3,-992 # 80001a1c <_ZN3PCB10freeObjectEPv>
    80001e04:	00000617          	auipc	a2,0x0
    80001e08:	c0060613          	addi	a2,a2,-1024 # 80001a04 <_ZN3PCB12createObjectEPv>
    80001e0c:	05000593          	li	a1,80
    80001e10:	00005517          	auipc	a0,0x5
    80001e14:	32050513          	addi	a0,a0,800 # 80007130 <CONSOLE_STATUS+0x120>
    80001e18:	00002097          	auipc	ra,0x2
    80001e1c:	280080e7          	jalr	640(ra) # 80004098 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001e20:	00007797          	auipc	a5,0x7
    80001e24:	16a7b823          	sd	a0,368(a5) # 80008f90 <_ZN3PCB8pcbCacheE>
}
    80001e28:	00813083          	ld	ra,8(sp)
    80001e2c:	00013403          	ld	s0,0(sp)
    80001e30:	01010113          	addi	sp,sp,16
    80001e34:	00008067          	ret

0000000080001e38 <_ZN14BuddyAllocator12getFreeBlockEm>:
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    80001e38:	ff010113          	addi	sp,sp,-16
    80001e3c:	00813423          	sd	s0,8(sp)
    80001e40:	01010413          	addi	s0,sp,16
    size--;
    80001e44:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001e48:	00b00793          	li	a5,11
    80001e4c:	02a7e463          	bltu	a5,a0,80001e74 <_ZN14BuddyAllocator12getFreeBlockEm+0x3c>
    80001e50:	00351513          	slli	a0,a0,0x3
    80001e54:	00007797          	auipc	a5,0x7
    80001e58:	14c78793          	addi	a5,a5,332 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001e5c:	00a78533          	add	a0,a5,a0
    80001e60:	00053503          	ld	a0,0(a0)
    80001e64:	00050c63          	beqz	a0,80001e7c <_ZN14BuddyAllocator12getFreeBlockEm+0x44>

    BuddyEntry* block = buddy[size];
    return block;
}
    80001e68:	00813403          	ld	s0,8(sp)
    80001e6c:	01010113          	addi	sp,sp,16
    80001e70:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001e74:	00000513          	li	a0,0
    80001e78:	ff1ff06f          	j	80001e68 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>
    80001e7c:	00000513          	li	a0,0
    80001e80:	fe9ff06f          	j	80001e68 <_ZN14BuddyAllocator12getFreeBlockEm+0x30>

0000000080001e84 <_ZN14BuddyAllocator12popFreeBlockEm>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    80001e84:	ff010113          	addi	sp,sp,-16
    80001e88:	00813423          	sd	s0,8(sp)
    80001e8c:	01010413          	addi	s0,sp,16
    size--;
    80001e90:	fff50793          	addi	a5,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001e94:	00b00713          	li	a4,11
    80001e98:	04f76063          	bltu	a4,a5,80001ed8 <_ZN14BuddyAllocator12popFreeBlockEm+0x54>
    80001e9c:	00379693          	slli	a3,a5,0x3
    80001ea0:	00007717          	auipc	a4,0x7
    80001ea4:	10070713          	addi	a4,a4,256 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001ea8:	00d70733          	add	a4,a4,a3
    80001eac:	00073503          	ld	a0,0(a4)
    80001eb0:	00050e63          	beqz	a0,80001ecc <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001eb4:	00053683          	ld	a3,0(a0)
    80001eb8:	00379793          	slli	a5,a5,0x3
    80001ebc:	00007717          	auipc	a4,0x7
    80001ec0:	0e470713          	addi	a4,a4,228 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001ec4:	00f707b3          	add	a5,a4,a5
    80001ec8:	00d7b023          	sd	a3,0(a5)
    return block;
}
    80001ecc:	00813403          	ld	s0,8(sp)
    80001ed0:	01010113          	addi	sp,sp,16
    80001ed4:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001ed8:	00000513          	li	a0,0
    80001edc:	ff1ff06f          	j	80001ecc <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

0000000080001ee0 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    80001ee0:	ff010113          	addi	sp,sp,-16
    80001ee4:	00813423          	sd	s0,8(sp)
    80001ee8:	01010413          	addi	s0,sp,16
    size--;
    80001eec:	fff50693          	addi	a3,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80001ef0:	00b00793          	li	a5,11
    80001ef4:	06d7e663          	bltu	a5,a3,80001f60 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x80>

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001ef8:	00369713          	slli	a4,a3,0x3
    80001efc:	00007797          	auipc	a5,0x7
    80001f00:	0a478793          	addi	a5,a5,164 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001f04:	00e787b3          	add	a5,a5,a4
    80001f08:	0007b603          	ld	a2,0(a5)
    80001f0c:	00060513          	mv	a0,a2
    BuddyEntry *prev = nullptr;
    80001f10:	00000713          	li	a4,0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f14:	02050263          	beqz	a0,80001f38 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
        if(curr->addr == addr) {
    80001f18:	00853783          	ld	a5,8(a0)
    80001f1c:	00b78863          	beq	a5,a1,80001f2c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x4c>
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    80001f20:	00050713          	mv	a4,a0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001f24:	00053503          	ld	a0,0(a0)
    80001f28:	fedff06f          	j	80001f14 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x34>
            if(prev) {
    80001f2c:	00070c63          	beqz	a4,80001f44 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x64>
                prev->next = curr->next;
    80001f30:	00053783          	ld	a5,0(a0)
    80001f34:	00f73023          	sd	a5,0(a4)
    }

    return nullptr;
}
    80001f38:	00813403          	ld	s0,8(sp)
    80001f3c:	01010113          	addi	sp,sp,16
    80001f40:	00008067          	ret
                buddy[size] = buddy[size]->next;
    80001f44:	00063703          	ld	a4,0(a2)
    80001f48:	00369693          	slli	a3,a3,0x3
    80001f4c:	00007797          	auipc	a5,0x7
    80001f50:	05478793          	addi	a5,a5,84 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001f54:	00d786b3          	add	a3,a5,a3
    80001f58:	00e6b023          	sd	a4,0(a3)
            return curr;
    80001f5c:	fddff06f          	j	80001f38 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
    if(size >= maxPowerSize) return nullptr;
    80001f60:	00000513          	li	a0,0
    80001f64:	fd5ff06f          	j	80001f38 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>

0000000080001f68 <_ZN14BuddyAllocator10printBuddyEv>:

void BuddyAllocator::printBuddy() {
    80001f68:	fe010113          	addi	sp,sp,-32
    80001f6c:	00113c23          	sd	ra,24(sp)
    80001f70:	00813823          	sd	s0,16(sp)
    80001f74:	00913423          	sd	s1,8(sp)
    80001f78:	01213023          	sd	s2,0(sp)
    80001f7c:	02010413          	addi	s0,sp,32
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001f80:	00000913          	li	s2,0
    80001f84:	0180006f          	j	80001f9c <_ZN14BuddyAllocator10printBuddyEv+0x34>
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    80001f88:	00005517          	auipc	a0,0x5
    80001f8c:	34850513          	addi	a0,a0,840 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80001f90:	00000097          	auipc	ra,0x0
    80001f94:	7a0080e7          	jalr	1952(ra) # 80002730 <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001f98:	00190913          	addi	s2,s2,1
    80001f9c:	00b00793          	li	a5,11
    80001fa0:	0727e663          	bltu	a5,s2,8000200c <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80001fa4:	00000613          	li	a2,0
    80001fa8:	00a00593          	li	a1,10
    80001fac:	0019051b          	addiw	a0,s2,1
    80001fb0:	00001097          	auipc	ra,0x1
    80001fb4:	918080e7          	jalr	-1768(ra) # 800028c8 <_Z8printIntiii>
        printString(": ");
    80001fb8:	00005517          	auipc	a0,0x5
    80001fbc:	18050513          	addi	a0,a0,384 # 80007138 <CONSOLE_STATUS+0x128>
    80001fc0:	00000097          	auipc	ra,0x0
    80001fc4:	770080e7          	jalr	1904(ra) # 80002730 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80001fc8:	00391713          	slli	a4,s2,0x3
    80001fcc:	00007797          	auipc	a5,0x7
    80001fd0:	fd478793          	addi	a5,a5,-44 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80001fd4:	00e787b3          	add	a5,a5,a4
    80001fd8:	0007b483          	ld	s1,0(a5)
    80001fdc:	fa0486e3          	beqz	s1,80001f88 <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    80001fe0:	00000613          	li	a2,0
    80001fe4:	00a00593          	li	a1,10
    80001fe8:	0084a503          	lw	a0,8(s1)
    80001fec:	00001097          	auipc	ra,0x1
    80001ff0:	8dc080e7          	jalr	-1828(ra) # 800028c8 <_Z8printIntiii>
            printString(" ");
    80001ff4:	00005517          	auipc	a0,0x5
    80001ff8:	14c50513          	addi	a0,a0,332 # 80007140 <CONSOLE_STATUS+0x130>
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	734080e7          	jalr	1844(ra) # 80002730 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80002004:	0004b483          	ld	s1,0(s1)
    80002008:	fd5ff06f          	j	80001fdc <_ZN14BuddyAllocator10printBuddyEv+0x74>
    }
}
    8000200c:	01813083          	ld	ra,24(sp)
    80002010:	01013403          	ld	s0,16(sp)
    80002014:	00813483          	ld	s1,8(sp)
    80002018:	00013903          	ld	s2,0(sp)
    8000201c:	02010113          	addi	sp,sp,32
    80002020:	00008067          	ret

0000000080002024 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
    80002024:	ff010113          	addi	sp,sp,-16
    80002028:	00813423          	sd	s0,8(sp)
    8000202c:	01010413          	addi	s0,sp,16
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
    80002030:	00053023          	sd	zero,0(a0)
        entry->addr = addr;
    80002034:	00a53423          	sd	a0,8(a0)
        return entry;
}
    80002038:	00813403          	ld	s0,8(sp)
    8000203c:	01010113          	addi	sp,sp,16
    80002040:	00008067          	ret

0000000080002044 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>:

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00813423          	sd	s0,8(sp)
    8000204c:	01010413          	addi	s0,sp,16
    size--;
    80002050:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize) return -1;
    80002054:	00b00793          	li	a5,11
    80002058:	08a7ec63          	bltu	a5,a0,800020f0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xac>

    if(buddy[size] == nullptr) {
    8000205c:	00351713          	slli	a4,a0,0x3
    80002060:	00007797          	auipc	a5,0x7
    80002064:	f4078793          	addi	a5,a5,-192 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80002068:	00e787b3          	add	a5,a5,a4
    8000206c:	0007b783          	ld	a5,0(a5)
    80002070:	00078663          	beqz	a5,8000207c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x38>
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    80002074:	00000613          	li	a2,0
    80002078:	0200006f          	j	80002098 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x54>
        buddy[size] = entry;
    8000207c:	00007797          	auipc	a5,0x7
    80002080:	f2478793          	addi	a5,a5,-220 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    80002084:	00e78533          	add	a0,a5,a4
    80002088:	00b53023          	sd	a1,0(a0)
        return 0;
    8000208c:	00000513          	li	a0,0
    80002090:	06c0006f          	j	800020fc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80002094:	00070793          	mv	a5,a4
    80002098:	06078063          	beqz	a5,800020f8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb4>
        if(curr->addr > entry->addr) {
    8000209c:	0087b683          	ld	a3,8(a5)
    800020a0:	0085b703          	ld	a4,8(a1)
    800020a4:	00d76e63          	bltu	a4,a3,800020c0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x7c>
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
    800020a8:	0007b703          	ld	a4,0(a5)
            curr->next = entry;
            break;
        }
        prev = curr;
    800020ac:	00078613          	mv	a2,a5
        if(curr->next == nullptr) {
    800020b0:	fe0712e3          	bnez	a4,80002094 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x50>
            curr->next = entry;
    800020b4:	00b7b023          	sd	a1,0(a5)
    }

    return 0;
    800020b8:	00000513          	li	a0,0
            break;
    800020bc:	0400006f          	j	800020fc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
            entry->next = curr;
    800020c0:	00f5b023          	sd	a5,0(a1)
            if(prev) {
    800020c4:	00060863          	beqz	a2,800020d4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x90>
                prev->next = curr;
    800020c8:	00f63023          	sd	a5,0(a2)
    return 0;
    800020cc:	00000513          	li	a0,0
    800020d0:	02c0006f          	j	800020fc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
                buddy[size] = entry;
    800020d4:	00351513          	slli	a0,a0,0x3
    800020d8:	00007797          	auipc	a5,0x7
    800020dc:	ec878793          	addi	a5,a5,-312 # 80008fa0 <_ZN14BuddyAllocator5buddyE>
    800020e0:	00a78533          	add	a0,a5,a0
    800020e4:	00b53023          	sd	a1,0(a0)
    return 0;
    800020e8:	00000513          	li	a0,0
    800020ec:	0100006f          	j	800020fc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    if(size >= maxPowerSize) return -1;
    800020f0:	fff00513          	li	a0,-1
    800020f4:	0080006f          	j	800020fc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    return 0;
    800020f8:	00000513          	li	a0,0
}
    800020fc:	00813403          	ld	s0,8(sp)
    80002100:	01010113          	addi	sp,sp,16
    80002104:	00008067          	ret

0000000080002108 <_ZN14BuddyAllocator9initBuddyEv>:
    if(startAddr != nullptr) return 1;
    80002108:	00007797          	auipc	a5,0x7
    8000210c:	ef87b783          	ld	a5,-264(a5) # 80009000 <_ZN14BuddyAllocator9startAddrE>
    80002110:	00078663          	beqz	a5,8000211c <_ZN14BuddyAllocator9initBuddyEv+0x14>
    80002114:	00100513          	li	a0,1
}
    80002118:	00008067          	ret
int BuddyAllocator::initBuddy() {
    8000211c:	ff010113          	addi	sp,sp,-16
    80002120:	00113423          	sd	ra,8(sp)
    80002124:	00813023          	sd	s0,0(sp)
    80002128:	01010413          	addi	s0,sp,16
    startAddr = (void*)HEAP_START_ADDR;
    8000212c:	00007797          	auipc	a5,0x7
    80002130:	d947b783          	ld	a5,-620(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002134:	0007b503          	ld	a0,0(a5)
    80002138:	00007797          	auipc	a5,0x7
    8000213c:	eca7b423          	sd	a0,-312(a5) # 80009000 <_ZN14BuddyAllocator9startAddrE>
    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    80002140:	00000097          	auipc	ra,0x0
    80002144:	ee4080e7          	jalr	-284(ra) # 80002024 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    80002148:	00050593          	mv	a1,a0
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);
    8000214c:	00c00513          	li	a0,12
    80002150:	00000097          	auipc	ra,0x0
    80002154:	ef4080e7          	jalr	-268(ra) # 80002044 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
}
    80002158:	00813083          	ld	ra,8(sp)
    8000215c:	00013403          	ld	s0,0(sp)
    80002160:	01010113          	addi	sp,sp,16
    80002164:	00008067          	ret

0000000080002168 <_ZN14BuddyAllocator10buddyAllocEm>:
void *BuddyAllocator::buddyAlloc(size_t size) {
    80002168:	fd010113          	addi	sp,sp,-48
    8000216c:	02113423          	sd	ra,40(sp)
    80002170:	02813023          	sd	s0,32(sp)
    80002174:	00913c23          	sd	s1,24(sp)
    80002178:	01213823          	sd	s2,16(sp)
    8000217c:	01313423          	sd	s3,8(sp)
    80002180:	01413023          	sd	s4,0(sp)
    80002184:	03010413          	addi	s0,sp,48
    size--;
    80002188:	fff50a13          	addi	s4,a0,-1
    if(size >= maxPowerSize) return nullptr;
    8000218c:	00b00793          	li	a5,11
    80002190:	0747ea63          	bltu	a5,s4,80002204 <_ZN14BuddyAllocator10buddyAllocEm+0x9c>
    for(size_t curr = size; curr < maxPowerSize; curr++) {
    80002194:	000a0493          	mv	s1,s4
    80002198:	0080006f          	j	800021a0 <_ZN14BuddyAllocator10buddyAllocEm+0x38>
    8000219c:	00098493          	mv	s1,s3
    800021a0:	00b00793          	li	a5,11
    800021a4:	0697e463          	bltu	a5,s1,8000220c <_ZN14BuddyAllocator10buddyAllocEm+0xa4>
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
    800021a8:	00148993          	addi	s3,s1,1
    800021ac:	00098513          	mv	a0,s3
    800021b0:	00000097          	auipc	ra,0x0
    800021b4:	cd4080e7          	jalr	-812(ra) # 80001e84 <_ZN14BuddyAllocator12popFreeBlockEm>
    800021b8:	00050913          	mv	s2,a0
        if(block != nullptr) { // postoji slobodan blok ove velicine
    800021bc:	fe0500e3          	beqz	a0,8000219c <_ZN14BuddyAllocator10buddyAllocEm+0x34>
            while(curr > size) {
    800021c0:	029a7e63          	bgeu	s4,s1,800021fc <_ZN14BuddyAllocator10buddyAllocEm+0x94>

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
    static size_t sizeInBytes(size_t size) {
        size--;
    800021c4:	fff48993          	addi	s3,s1,-1
        return (1<<size)*blockSize;
    800021c8:	00100793          	li	a5,1
    800021cc:	013797bb          	sllw	a5,a5,s3
    800021d0:	00c79793          	slli	a5,a5,0xc
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
    800021d4:	00893503          	ld	a0,8(s2)
    800021d8:	00f50533          	add	a0,a0,a5
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	e48080e7          	jalr	-440(ra) # 80002024 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800021e4:	00050593          	mv	a1,a0
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment
    800021e8:	00048513          	mv	a0,s1
    800021ec:	00000097          	auipc	ra,0x0
    800021f0:	e58080e7          	jalr	-424(ra) # 80002044 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
                curr--;
    800021f4:	00098493          	mv	s1,s3
            while(curr > size) {
    800021f8:	fc9ff06f          	j	800021c0 <_ZN14BuddyAllocator10buddyAllocEm+0x58>
            void* res = block->addr;
    800021fc:	00893503          	ld	a0,8(s2)
            return res;
    80002200:	0100006f          	j	80002210 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    if(size >= maxPowerSize) return nullptr;
    80002204:	00000513          	li	a0,0
    80002208:	0080006f          	j	80002210 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    return nullptr;
    8000220c:	00000513          	li	a0,0
}
    80002210:	02813083          	ld	ra,40(sp)
    80002214:	02013403          	ld	s0,32(sp)
    80002218:	01813483          	ld	s1,24(sp)
    8000221c:	01013903          	ld	s2,16(sp)
    80002220:	00813983          	ld	s3,8(sp)
    80002224:	00013a03          	ld	s4,0(sp)
    80002228:	03010113          	addi	sp,sp,48
    8000222c:	00008067          	ret

0000000080002230 <_ZN14BuddyAllocator9buddyFreeEPvm>:
    size--;
    80002230:	fff58593          	addi	a1,a1,-1
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002234:	00b00793          	li	a5,11
    80002238:	0ab7ec63          	bltu	a5,a1,800022f0 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc0>
int BuddyAllocator::buddyFree(void *addr, size_t size) {
    8000223c:	fd010113          	addi	sp,sp,-48
    80002240:	02113423          	sd	ra,40(sp)
    80002244:	02813023          	sd	s0,32(sp)
    80002248:	00913c23          	sd	s1,24(sp)
    8000224c:	01213823          	sd	s2,16(sp)
    80002250:	01313423          	sd	s3,8(sp)
    80002254:	01413023          	sd	s4,0(sp)
    80002258:	03010413          	addi	s0,sp,48
    8000225c:	00050a13          	mv	s4,a0
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002260:	00051a63          	bnez	a0,80002274 <_ZN14BuddyAllocator9buddyFreeEPvm+0x44>
    80002264:	fff00513          	li	a0,-1
    80002268:	0940006f          	j	800022fc <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
            next = other;
    8000226c:	00048a13          	mv	s4,s1
    80002270:	00098593          	mv	a1,s3
    while(size < maxPowerSize) {
    80002274:	00b00793          	li	a5,11
    80002278:	08b7e063          	bltu	a5,a1,800022f8 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc8>
    }

    static void* relativeAddress(void* addr) {
        return (char*)addr - (size_t)startAddr;
    8000227c:	00007917          	auipc	s2,0x7
    80002280:	d8493903          	ld	s2,-636(s2) # 80009000 <_ZN14BuddyAllocator9startAddrE>
    80002284:	412a0933          	sub	s2,s4,s2
        size--;
    80002288:	00158993          	addi	s3,a1,1
        return (1<<size)*blockSize;
    8000228c:	00100793          	li	a5,1
    80002290:	0137973b          	sllw	a4,a5,s3
    80002294:	00c71713          	slli	a4,a4,0xc
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
    80002298:	02e97933          	remu	s2,s2,a4
    8000229c:	00b797bb          	sllw	a5,a5,a1
    800022a0:	00c79793          	slli	a5,a5,0xc
        other = (void*)((char*)other + (module == 0 ? offset : -offset));
    800022a4:	00090463          	beqz	s2,800022ac <_ZN14BuddyAllocator9buddyFreeEPvm+0x7c>
    800022a8:	40f007b3          	neg	a5,a5
    800022ac:	00fa04b3          	add	s1,s4,a5
        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
    800022b0:	00048593          	mv	a1,s1
    800022b4:	00098513          	mv	a0,s3
    800022b8:	00000097          	auipc	ra,0x0
    800022bc:	c28080e7          	jalr	-984(ra) # 80001ee0 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
    800022c0:	00050663          	beqz	a0,800022cc <_ZN14BuddyAllocator9buddyFreeEPvm+0x9c>
        if(module != 0) {
    800022c4:	fa0914e3          	bnez	s2,8000226c <_ZN14BuddyAllocator9buddyFreeEPvm+0x3c>
    800022c8:	fa9ff06f          	j	80002270 <_ZN14BuddyAllocator9buddyFreeEPvm+0x40>
            BuddyEntry* entry = BuddyEntry::createEntry(next);
    800022cc:	000a0513          	mv	a0,s4
    800022d0:	00000097          	auipc	ra,0x0
    800022d4:	d54080e7          	jalr	-684(ra) # 80002024 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800022d8:	00050593          	mv	a1,a0
            BuddyEntry::addEntry(size+1, entry);
    800022dc:	00098513          	mv	a0,s3
    800022e0:	00000097          	auipc	ra,0x0
    800022e4:	d64080e7          	jalr	-668(ra) # 80002044 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
    return 0;
    800022e8:	00000513          	li	a0,0
            break;
    800022ec:	0100006f          	j	800022fc <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
    if(size >= maxPowerSize || addr == nullptr) return -1;
    800022f0:	fff00513          	li	a0,-1
}
    800022f4:	00008067          	ret
    return 0;
    800022f8:	00000513          	li	a0,0
}
    800022fc:	02813083          	ld	ra,40(sp)
    80002300:	02013403          	ld	s0,32(sp)
    80002304:	01813483          	ld	s1,24(sp)
    80002308:	01013903          	ld	s2,16(sp)
    8000230c:	00813983          	ld	s3,8(sp)
    80002310:	00013a03          	ld	s4,0(sp)
    80002314:	03010113          	addi	sp,sp,48
    80002318:	00008067          	ret

000000008000231c <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    8000231c:	fe010113          	addi	sp,sp,-32
    80002320:	00113c23          	sd	ra,24(sp)
    80002324:	00813823          	sd	s0,16(sp)
    80002328:	00913423          	sd	s1,8(sp)
    8000232c:	01213023          	sd	s2,0(sp)
    80002330:	02010413          	addi	s0,sp,32
    80002334:	00050493          	mv	s1,a0
    80002338:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    8000233c:	01000513          	li	a0,16
    80002340:	00002097          	auipc	ra,0x2
    80002344:	a0c080e7          	jalr	-1524(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80002348:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    8000234c:	01250423          	sb	s2,8(a0)
    if(!head) {
    80002350:	0004b783          	ld	a5,0(s1)
    80002354:	02078863          	beqz	a5,80002384 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80002358:	0084b783          	ld	a5,8(s1)
    8000235c:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80002360:	0084b783          	ld	a5,8(s1)
    80002364:	0007b783          	ld	a5,0(a5)
    80002368:	00f4b423          	sd	a5,8(s1)
    }
}
    8000236c:	01813083          	ld	ra,24(sp)
    80002370:	01013403          	ld	s0,16(sp)
    80002374:	00813483          	ld	s1,8(sp)
    80002378:	00013903          	ld	s2,0(sp)
    8000237c:	02010113          	addi	sp,sp,32
    80002380:	00008067          	ret
        head = tail = newElem;
    80002384:	00a4b423          	sd	a0,8(s1)
    80002388:	00a4b023          	sd	a0,0(s1)
    8000238c:	fe1ff06f          	j	8000236c <_ZN8IOBuffer8pushBackEc+0x50>

0000000080002390 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void*) {
    80002390:	fe010113          	addi	sp,sp,-32
    80002394:	00113c23          	sd	ra,24(sp)
    80002398:	00813823          	sd	s0,16(sp)
    8000239c:	00913423          	sd	s1,8(sp)
    800023a0:	02010413          	addi	s0,sp,32
    800023a4:	04c0006f          	j	800023f0 <_ZN3CCB9inputBodyEPv+0x60>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    800023a8:	00007797          	auipc	a5,0x7
    800023ac:	b007b783          	ld	a5,-1280(a5) # 80008ea8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800023b0:	0007b783          	ld	a5,0(a5)
    800023b4:	00007497          	auipc	s1,0x7
    800023b8:	c5448493          	addi	s1,s1,-940 # 80009008 <_ZN3CCB11inputBufferE>
    800023bc:	0007c583          	lbu	a1,0(a5)
    800023c0:	00048513          	mv	a0,s1
    800023c4:	00000097          	auipc	ra,0x0
    800023c8:	f58080e7          	jalr	-168(ra) # 8000231c <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    800023cc:	0104b503          	ld	a0,16(s1)
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	010080e7          	jalr	16(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    800023d8:	00a00513          	li	a0,10
    800023dc:	00003097          	auipc	ra,0x3
    800023e0:	d80080e7          	jalr	-640(ra) # 8000515c <plic_complete>
            sem_wait(semInput);
    800023e4:	0184b503          	ld	a0,24(s1)
    800023e8:	fffff097          	auipc	ra,0xfffff
    800023ec:	fb0080e7          	jalr	-80(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    800023f0:	00007797          	auipc	a5,0x7
    800023f4:	ac87b783          	ld	a5,-1336(a5) # 80008eb8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800023f8:	0007b783          	ld	a5,0(a5)
    800023fc:	0007c783          	lbu	a5,0(a5)
    80002400:	0017f793          	andi	a5,a5,1
    80002404:	fa0792e3          	bnez	a5,800023a8 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    80002408:	fffff097          	auipc	ra,0xfffff
    8000240c:	e6c080e7          	jalr	-404(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002410:	fe1ff06f          	j	800023f0 <_ZN3CCB9inputBodyEPv+0x60>

0000000080002414 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80002414:	fe010113          	addi	sp,sp,-32
    80002418:	00113c23          	sd	ra,24(sp)
    8000241c:	00813823          	sd	s0,16(sp)
    80002420:	00913423          	sd	s1,8(sp)
    80002424:	02010413          	addi	s0,sp,32
    80002428:	00050793          	mv	a5,a0
    if(!head) return 0;
    8000242c:	00053503          	ld	a0,0(a0)
    80002430:	04050063          	beqz	a0,80002470 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80002434:	00053703          	ld	a4,0(a0)
    80002438:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    8000243c:	0087b703          	ld	a4,8(a5)
    80002440:	02e50463          	beq	a0,a4,80002468 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80002444:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80002448:	00002097          	auipc	ra,0x2
    8000244c:	a74080e7          	jalr	-1420(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80002450:	00048513          	mv	a0,s1
    80002454:	01813083          	ld	ra,24(sp)
    80002458:	01013403          	ld	s0,16(sp)
    8000245c:	00813483          	ld	s1,8(sp)
    80002460:	02010113          	addi	sp,sp,32
    80002464:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80002468:	0007b423          	sd	zero,8(a5)
    8000246c:	fd9ff06f          	j	80002444 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80002470:	00000493          	li	s1,0
    80002474:	fddff06f          	j	80002450 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080002478 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80002478:	ff010113          	addi	sp,sp,-16
    8000247c:	00813423          	sd	s0,8(sp)
    80002480:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80002484:	00853783          	ld	a5,8(a0)
    80002488:	00078a63          	beqz	a5,8000249c <_ZN8IOBuffer8peekBackEv+0x24>
    8000248c:	0087c503          	lbu	a0,8(a5)
}
    80002490:	00813403          	ld	s0,8(sp)
    80002494:	01010113          	addi	sp,sp,16
    80002498:	00008067          	ret
    return tail ? tail->data : 0;
    8000249c:	00000513          	li	a0,0
    800024a0:	ff1ff06f          	j	80002490 <_ZN8IOBuffer8peekBackEv+0x18>

00000000800024a4 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    800024a4:	ff010113          	addi	sp,sp,-16
    800024a8:	00813423          	sd	s0,8(sp)
    800024ac:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    800024b0:	00053783          	ld	a5,0(a0)
    800024b4:	00078a63          	beqz	a5,800024c8 <_ZN8IOBuffer9peekFrontEv+0x24>
    800024b8:	0087c503          	lbu	a0,8(a5)
}
    800024bc:	00813403          	ld	s0,8(sp)
    800024c0:	01010113          	addi	sp,sp,16
    800024c4:	00008067          	ret
    return head ? head->data : 0;
    800024c8:	00000513          	li	a0,0
    800024cc:	ff1ff06f          	j	800024bc <_ZN8IOBuffer9peekFrontEv+0x18>

00000000800024d0 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void*) {
    800024d0:	fe010113          	addi	sp,sp,-32
    800024d4:	00113c23          	sd	ra,24(sp)
    800024d8:	00813823          	sd	s0,16(sp)
    800024dc:	00913423          	sd	s1,8(sp)
    800024e0:	02010413          	addi	s0,sp,32
    800024e4:	00c0006f          	j	800024f0 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    800024e8:	fffff097          	auipc	ra,0xfffff
    800024ec:	d8c080e7          	jalr	-628(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    800024f0:	00007797          	auipc	a5,0x7
    800024f4:	9c87b783          	ld	a5,-1592(a5) # 80008eb8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800024f8:	0007b783          	ld	a5,0(a5)
    800024fc:	0007c783          	lbu	a5,0(a5)
    80002500:	0207f793          	andi	a5,a5,32
    80002504:	fe0782e3          	beqz	a5,800024e8 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80002508:	00007517          	auipc	a0,0x7
    8000250c:	b2050513          	addi	a0,a0,-1248 # 80009028 <_ZN3CCB12outputBufferE>
    80002510:	00000097          	auipc	ra,0x0
    80002514:	f94080e7          	jalr	-108(ra) # 800024a4 <_ZN8IOBuffer9peekFrontEv>
    80002518:	fc0508e3          	beqz	a0,800024e8 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    8000251c:	00007797          	auipc	a5,0x7
    80002520:	9bc7b783          	ld	a5,-1604(a5) # 80008ed8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002524:	0007b483          	ld	s1,0(a5)
    80002528:	00007517          	auipc	a0,0x7
    8000252c:	b0050513          	addi	a0,a0,-1280 # 80009028 <_ZN3CCB12outputBufferE>
    80002530:	00000097          	auipc	ra,0x0
    80002534:	ee4080e7          	jalr	-284(ra) # 80002414 <_ZN8IOBuffer8popFrontEv>
    80002538:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    8000253c:	00007517          	auipc	a0,0x7
    80002540:	afc53503          	ld	a0,-1284(a0) # 80009038 <_ZN3CCB9semOutputE>
    80002544:	fffff097          	auipc	ra,0xfffff
    80002548:	e54080e7          	jalr	-428(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    8000254c:	fa5ff06f          	j	800024f0 <_ZN3CCB10outputBodyEPv+0x20>

0000000080002550 <_ZN13SlabAllocator13initAllocatorEPvi>:
const char* SlabAllocator::names[] = {"size-32", "size-64", "size-128", "size-256",
                                      "size-512", "size-1024", "size-2048",
                                      "size-4096", "size-8192", "size-16384",
                                      "size-32768", "size-65536", "size-131072", "PCB", "SEM"};

void SlabAllocator::initAllocator(void *space, int blockNum) {
    80002550:	ff010113          	addi	sp,sp,-16
    80002554:	00113423          	sd	ra,8(sp)
    80002558:	00813023          	sd	s0,0(sp)
    8000255c:	01010413          	addi	s0,sp,16
    BuddyAllocator::initBuddy();
    80002560:	00000097          	auipc	ra,0x0
    80002564:	ba8080e7          	jalr	-1112(ra) # 80002108 <_ZN14BuddyAllocator9initBuddyEv>
}
    80002568:	00813083          	ld	ra,8(sp)
    8000256c:	00013403          	ld	s0,0(sp)
    80002570:	01010113          	addi	sp,sp,16
    80002574:	00008067          	ret

0000000080002578 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80002578:	fc010113          	addi	sp,sp,-64
    8000257c:	02113c23          	sd	ra,56(sp)
    80002580:	02813823          	sd	s0,48(sp)
    80002584:	02913423          	sd	s1,40(sp)
    80002588:	03213023          	sd	s2,32(sp)
    8000258c:	01313c23          	sd	s3,24(sp)
    80002590:	01413823          	sd	s4,16(sp)
    80002594:	01513423          	sd	s5,8(sp)
    80002598:	04010413          	addi	s0,sp,64
    8000259c:	00050493          	mv	s1,a0
    800025a0:	00058913          	mv	s2,a1
    800025a4:	00060993          	mv	s3,a2
    800025a8:	00068a13          	mv	s4,a3
    for(int i = 0; i < cacheNameNum; i++) {
    800025ac:	00000793          	li	a5,0
    800025b0:	00e00713          	li	a4,14
    800025b4:	02f74663          	blt	a4,a5,800025e0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x68>
        if(names[i] == name) break;
    800025b8:	00379813          	slli	a6,a5,0x3
    800025bc:	00006717          	auipc	a4,0x6
    800025c0:	7dc70713          	addi	a4,a4,2012 # 80008d98 <_ZN13SlabAllocator5namesE>
    800025c4:	01070733          	add	a4,a4,a6
    800025c8:	00073703          	ld	a4,0(a4)
    800025cc:	00970a63          	beq	a4,s1,800025e0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x68>
        if(i == cacheNameNum - 1) return nullptr;
    800025d0:	00e00713          	li	a4,14
    800025d4:	04e78e63          	beq	a5,a4,80002630 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0xb8>
    for(int i = 0; i < cacheNameNum; i++) {
    800025d8:	0017879b          	addiw	a5,a5,1
    800025dc:	fd5ff06f          	j	800025b0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x38>
    }

    Cache* cache = (Cache*)BuddyAllocator::buddyAlloc(1);
    800025e0:	00100513          	li	a0,1
    800025e4:	00000097          	auipc	ra,0x0
    800025e8:	b84080e7          	jalr	-1148(ra) # 80002168 <_ZN14BuddyAllocator10buddyAllocEm>
    800025ec:	00050a93          	mv	s5,a0
    cache->initCache(name, size, ctor, dtor);
    800025f0:	000a0713          	mv	a4,s4
    800025f4:	00098693          	mv	a3,s3
    800025f8:	00090613          	mv	a2,s2
    800025fc:	00048593          	mv	a1,s1
    80002600:	00001097          	auipc	ra,0x1
    80002604:	fec080e7          	jalr	-20(ra) # 800035ec <_ZN5Cache9initCacheEPKcmPFvPvES4_>

    return cache;
}
    80002608:	000a8513          	mv	a0,s5
    8000260c:	03813083          	ld	ra,56(sp)
    80002610:	03013403          	ld	s0,48(sp)
    80002614:	02813483          	ld	s1,40(sp)
    80002618:	02013903          	ld	s2,32(sp)
    8000261c:	01813983          	ld	s3,24(sp)
    80002620:	01013a03          	ld	s4,16(sp)
    80002624:	00813a83          	ld	s5,8(sp)
    80002628:	04010113          	addi	sp,sp,64
    8000262c:	00008067          	ret
        if(i == cacheNameNum - 1) return nullptr;
    80002630:	00000a93          	li	s5,0
    80002634:	fd5ff06f          	j	80002608 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x90>

0000000080002638 <_ZN13SlabAllocator9allocSlotEP5Cache>:

void *SlabAllocator::allocSlot(Cache *cache) {
    80002638:	ff010113          	addi	sp,sp,-16
    8000263c:	00113423          	sd	ra,8(sp)
    80002640:	00813023          	sd	s0,0(sp)
    80002644:	01010413          	addi	s0,sp,16
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
    80002648:	00001097          	auipc	ra,0x1
    8000264c:	694080e7          	jalr	1684(ra) # 80003cdc <_ZN5Cache12allocateSlotEv>
}
    80002650:	01850513          	addi	a0,a0,24
    80002654:	00813083          	ld	ra,8(sp)
    80002658:	00013403          	ld	s0,0(sp)
    8000265c:	01010113          	addi	sp,sp,16
    80002660:	00008067          	ret

0000000080002664 <_ZN13SlabAllocator8freeSlotEP5CachePv>:

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    80002664:	ff010113          	addi	sp,sp,-16
    80002668:	00113423          	sd	ra,8(sp)
    8000266c:	00813023          	sd	s0,0(sp)
    80002670:	01010413          	addi	s0,sp,16
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
    80002674:	fe858593          	addi	a1,a1,-24
    80002678:	00001097          	auipc	ra,0x1
    8000267c:	4ec080e7          	jalr	1260(ra) # 80003b64 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_ZN13SlabAllocator17printErrorMessageEP5Cache>:

int SlabAllocator::printErrorMessage(Cache *cache) {
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    return cache->printErrorMessage();
    800026a0:	00001097          	auipc	ra,0x1
    800026a4:	150080e7          	jalr	336(ra) # 800037f0 <_ZN5Cache17printErrorMessageEv>
}
    800026a8:	00813083          	ld	ra,8(sp)
    800026ac:	00013403          	ld	s0,0(sp)
    800026b0:	01010113          	addi	sp,sp,16
    800026b4:	00008067          	ret

00000000800026b8 <_ZN13SlabAllocator14printCacheInfoEP5Cache>:

void SlabAllocator::printCacheInfo(Cache *cache) {
    800026b8:	ff010113          	addi	sp,sp,-16
    800026bc:	00113423          	sd	ra,8(sp)
    800026c0:	00813023          	sd	s0,0(sp)
    800026c4:	01010413          	addi	s0,sp,16
    cache->printCacheInfo();
    800026c8:	00001097          	auipc	ra,0x1
    800026cc:	1e8080e7          	jalr	488(ra) # 800038b0 <_ZN5Cache14printCacheInfoEv>
}
    800026d0:	00813083          	ld	ra,8(sp)
    800026d4:	00013403          	ld	s0,0(sp)
    800026d8:	01010113          	addi	sp,sp,16
    800026dc:	00008067          	ret

00000000800026e0 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>:

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    800026e0:	ff010113          	addi	sp,sp,-16
    800026e4:	00113423          	sd	ra,8(sp)
    800026e8:	00813023          	sd	s0,0(sp)
    800026ec:	01010413          	addi	s0,sp,16
    return cache->deallocFreeSlabs();
    800026f0:	00001097          	auipc	ra,0x1
    800026f4:	350080e7          	jalr	848(ra) # 80003a40 <_ZN5Cache16deallocFreeSlabsEv>
}
    800026f8:	00813083          	ld	ra,8(sp)
    800026fc:	00013403          	ld	s0,0(sp)
    80002700:	01010113          	addi	sp,sp,16
    80002704:	00008067          	ret

0000000080002708 <_ZN13SlabAllocator12deallocCacheEP5Cache>:

void SlabAllocator::deallocCache(Cache *cache) {
    80002708:	ff010113          	addi	sp,sp,-16
    8000270c:	00113423          	sd	ra,8(sp)
    80002710:	00813023          	sd	s0,0(sp)
    80002714:	01010413          	addi	s0,sp,16
    cache->deallocCache();
    80002718:	00001097          	auipc	ra,0x1
    8000271c:	394080e7          	jalr	916(ra) # 80003aac <_ZN5Cache12deallocCacheEv>
}
    80002720:	00813083          	ld	ra,8(sp)
    80002724:	00013403          	ld	s0,0(sp)
    80002728:	01010113          	addi	sp,sp,16
    8000272c:	00008067          	ret

0000000080002730 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002730:	fe010113          	addi	sp,sp,-32
    80002734:	00113c23          	sd	ra,24(sp)
    80002738:	00813823          	sd	s0,16(sp)
    8000273c:	00913423          	sd	s1,8(sp)
    80002740:	02010413          	addi	s0,sp,32
    80002744:	00050493          	mv	s1,a0
    LOCK();
    80002748:	00100613          	li	a2,1
    8000274c:	00000593          	li	a1,0
    80002750:	00007517          	auipc	a0,0x7
    80002754:	90050513          	addi	a0,a0,-1792 # 80009050 <lockPrint>
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	9f8080e7          	jalr	-1544(ra) # 80001150 <copy_and_swap>
    80002760:	fe0514e3          	bnez	a0,80002748 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002764:	0004c503          	lbu	a0,0(s1)
    80002768:	00050a63          	beqz	a0,8000277c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	d6c080e7          	jalr	-660(ra) # 800014d8 <_Z4putcc>
        string++;
    80002774:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002778:	fedff06f          	j	80002764 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000277c:	00000613          	li	a2,0
    80002780:	00100593          	li	a1,1
    80002784:	00007517          	auipc	a0,0x7
    80002788:	8cc50513          	addi	a0,a0,-1844 # 80009050 <lockPrint>
    8000278c:	fffff097          	auipc	ra,0xfffff
    80002790:	9c4080e7          	jalr	-1596(ra) # 80001150 <copy_and_swap>
    80002794:	fe0514e3          	bnez	a0,8000277c <_Z11printStringPKc+0x4c>
}
    80002798:	01813083          	ld	ra,24(sp)
    8000279c:	01013403          	ld	s0,16(sp)
    800027a0:	00813483          	ld	s1,8(sp)
    800027a4:	02010113          	addi	sp,sp,32
    800027a8:	00008067          	ret

00000000800027ac <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800027ac:	fd010113          	addi	sp,sp,-48
    800027b0:	02113423          	sd	ra,40(sp)
    800027b4:	02813023          	sd	s0,32(sp)
    800027b8:	00913c23          	sd	s1,24(sp)
    800027bc:	01213823          	sd	s2,16(sp)
    800027c0:	01313423          	sd	s3,8(sp)
    800027c4:	01413023          	sd	s4,0(sp)
    800027c8:	03010413          	addi	s0,sp,48
    800027cc:	00050993          	mv	s3,a0
    800027d0:	00058a13          	mv	s4,a1
    LOCK();
    800027d4:	00100613          	li	a2,1
    800027d8:	00000593          	li	a1,0
    800027dc:	00007517          	auipc	a0,0x7
    800027e0:	87450513          	addi	a0,a0,-1932 # 80009050 <lockPrint>
    800027e4:	fffff097          	auipc	ra,0xfffff
    800027e8:	96c080e7          	jalr	-1684(ra) # 80001150 <copy_and_swap>
    800027ec:	fe0514e3          	bnez	a0,800027d4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800027f0:	00000913          	li	s2,0
    800027f4:	00090493          	mv	s1,s2
    800027f8:	0019091b          	addiw	s2,s2,1
    800027fc:	03495a63          	bge	s2,s4,80002830 <_Z9getStringPci+0x84>
        cc = getc();
    80002800:	fffff097          	auipc	ra,0xfffff
    80002804:	ca8080e7          	jalr	-856(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80002808:	02050463          	beqz	a0,80002830 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000280c:	009984b3          	add	s1,s3,s1
    80002810:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002814:	00a00793          	li	a5,10
    80002818:	00f50a63          	beq	a0,a5,8000282c <_Z9getStringPci+0x80>
    8000281c:	00d00793          	li	a5,13
    80002820:	fcf51ae3          	bne	a0,a5,800027f4 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002824:	00090493          	mv	s1,s2
    80002828:	0080006f          	j	80002830 <_Z9getStringPci+0x84>
    8000282c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002830:	009984b3          	add	s1,s3,s1
    80002834:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002838:	00000613          	li	a2,0
    8000283c:	00100593          	li	a1,1
    80002840:	00007517          	auipc	a0,0x7
    80002844:	81050513          	addi	a0,a0,-2032 # 80009050 <lockPrint>
    80002848:	fffff097          	auipc	ra,0xfffff
    8000284c:	908080e7          	jalr	-1784(ra) # 80001150 <copy_and_swap>
    80002850:	fe0514e3          	bnez	a0,80002838 <_Z9getStringPci+0x8c>
    return buf;
}
    80002854:	00098513          	mv	a0,s3
    80002858:	02813083          	ld	ra,40(sp)
    8000285c:	02013403          	ld	s0,32(sp)
    80002860:	01813483          	ld	s1,24(sp)
    80002864:	01013903          	ld	s2,16(sp)
    80002868:	00813983          	ld	s3,8(sp)
    8000286c:	00013a03          	ld	s4,0(sp)
    80002870:	03010113          	addi	sp,sp,48
    80002874:	00008067          	ret

0000000080002878 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002878:	ff010113          	addi	sp,sp,-16
    8000287c:	00813423          	sd	s0,8(sp)
    80002880:	01010413          	addi	s0,sp,16
    80002884:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002888:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000288c:	0006c603          	lbu	a2,0(a3)
    80002890:	fd06071b          	addiw	a4,a2,-48
    80002894:	0ff77713          	andi	a4,a4,255
    80002898:	00900793          	li	a5,9
    8000289c:	02e7e063          	bltu	a5,a4,800028bc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800028a0:	0025179b          	slliw	a5,a0,0x2
    800028a4:	00a787bb          	addw	a5,a5,a0
    800028a8:	0017979b          	slliw	a5,a5,0x1
    800028ac:	00168693          	addi	a3,a3,1
    800028b0:	00c787bb          	addw	a5,a5,a2
    800028b4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800028b8:	fd5ff06f          	j	8000288c <_Z11stringToIntPKc+0x14>
    return n;
}
    800028bc:	00813403          	ld	s0,8(sp)
    800028c0:	01010113          	addi	sp,sp,16
    800028c4:	00008067          	ret

00000000800028c8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800028c8:	fc010113          	addi	sp,sp,-64
    800028cc:	02113c23          	sd	ra,56(sp)
    800028d0:	02813823          	sd	s0,48(sp)
    800028d4:	02913423          	sd	s1,40(sp)
    800028d8:	03213023          	sd	s2,32(sp)
    800028dc:	01313c23          	sd	s3,24(sp)
    800028e0:	04010413          	addi	s0,sp,64
    800028e4:	00050493          	mv	s1,a0
    800028e8:	00058913          	mv	s2,a1
    800028ec:	00060993          	mv	s3,a2
    LOCK();
    800028f0:	00100613          	li	a2,1
    800028f4:	00000593          	li	a1,0
    800028f8:	00006517          	auipc	a0,0x6
    800028fc:	75850513          	addi	a0,a0,1880 # 80009050 <lockPrint>
    80002900:	fffff097          	auipc	ra,0xfffff
    80002904:	850080e7          	jalr	-1968(ra) # 80001150 <copy_and_swap>
    80002908:	fe0514e3          	bnez	a0,800028f0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000290c:	00098463          	beqz	s3,80002914 <_Z8printIntiii+0x4c>
    80002910:	0804c463          	bltz	s1,80002998 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002914:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002918:	00000593          	li	a1,0
    }

    i = 0;
    8000291c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002920:	0009079b          	sext.w	a5,s2
    80002924:	0325773b          	remuw	a4,a0,s2
    80002928:	00048613          	mv	a2,s1
    8000292c:	0014849b          	addiw	s1,s1,1
    80002930:	02071693          	slli	a3,a4,0x20
    80002934:	0206d693          	srli	a3,a3,0x20
    80002938:	00006717          	auipc	a4,0x6
    8000293c:	4d870713          	addi	a4,a4,1240 # 80008e10 <digits>
    80002940:	00d70733          	add	a4,a4,a3
    80002944:	00074683          	lbu	a3,0(a4)
    80002948:	fd040713          	addi	a4,s0,-48
    8000294c:	00c70733          	add	a4,a4,a2
    80002950:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002954:	0005071b          	sext.w	a4,a0
    80002958:	0325553b          	divuw	a0,a0,s2
    8000295c:	fcf772e3          	bgeu	a4,a5,80002920 <_Z8printIntiii+0x58>
    if(neg)
    80002960:	00058c63          	beqz	a1,80002978 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002964:	fd040793          	addi	a5,s0,-48
    80002968:	009784b3          	add	s1,a5,s1
    8000296c:	02d00793          	li	a5,45
    80002970:	fef48823          	sb	a5,-16(s1)
    80002974:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002978:	fff4849b          	addiw	s1,s1,-1
    8000297c:	0204c463          	bltz	s1,800029a4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002980:	fd040793          	addi	a5,s0,-48
    80002984:	009787b3          	add	a5,a5,s1
    80002988:	ff07c503          	lbu	a0,-16(a5)
    8000298c:	fffff097          	auipc	ra,0xfffff
    80002990:	b4c080e7          	jalr	-1204(ra) # 800014d8 <_Z4putcc>
    80002994:	fe5ff06f          	j	80002978 <_Z8printIntiii+0xb0>
        x = -xx;
    80002998:	4090053b          	negw	a0,s1
        neg = 1;
    8000299c:	00100593          	li	a1,1
        x = -xx;
    800029a0:	f7dff06f          	j	8000291c <_Z8printIntiii+0x54>

    UNLOCK();
    800029a4:	00000613          	li	a2,0
    800029a8:	00100593          	li	a1,1
    800029ac:	00006517          	auipc	a0,0x6
    800029b0:	6a450513          	addi	a0,a0,1700 # 80009050 <lockPrint>
    800029b4:	ffffe097          	auipc	ra,0xffffe
    800029b8:	79c080e7          	jalr	1948(ra) # 80001150 <copy_and_swap>
    800029bc:	fe0514e3          	bnez	a0,800029a4 <_Z8printIntiii+0xdc>
    800029c0:	03813083          	ld	ra,56(sp)
    800029c4:	03013403          	ld	s0,48(sp)
    800029c8:	02813483          	ld	s1,40(sp)
    800029cc:	02013903          	ld	s2,32(sp)
    800029d0:	01813983          	ld	s3,24(sp)
    800029d4:	04010113          	addi	sp,sp,64
    800029d8:	00008067          	ret

00000000800029dc <_Z8userMainv>:
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
void userMain() {
    800029dc:	ff010113          	addi	sp,sp,-16
    800029e0:	00113423          	sd	ra,8(sp)
    800029e4:	00813023          	sd	s0,0(sp)
    800029e8:	01010413          	addi	s0,sp,16
    printString("Hello world!");
    800029ec:	00005517          	auipc	a0,0x5
    800029f0:	82450513          	addi	a0,a0,-2012 # 80007210 <CONSOLE_STATUS+0x200>
    800029f4:	00000097          	auipc	ra,0x0
    800029f8:	d3c080e7          	jalr	-708(ra) # 80002730 <_Z11printStringPKc>
    800029fc:	00813083          	ld	ra,8(sp)
    80002a00:	00013403          	ld	s0,0(sp)
    80002a04:	01010113          	addi	sp,sp,16
    80002a08:	00008067          	ret

0000000080002a0c <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002a0c:	ff010113          	addi	sp,sp,-16
    80002a10:	00813423          	sd	s0,8(sp)
    80002a14:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002a18:	02050663          	beqz	a0,80002a44 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002a1c:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002a20:	00006797          	auipc	a5,0x6
    80002a24:	6387b783          	ld	a5,1592(a5) # 80009058 <_ZN9Scheduler4tailE>
    80002a28:	02078463          	beqz	a5,80002a50 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002a2c:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002a30:	00006797          	auipc	a5,0x6
    80002a34:	62878793          	addi	a5,a5,1576 # 80009058 <_ZN9Scheduler4tailE>
    80002a38:	0007b703          	ld	a4,0(a5)
    80002a3c:	00073703          	ld	a4,0(a4)
    80002a40:	00e7b023          	sd	a4,0(a5)
    }
}
    80002a44:	00813403          	ld	s0,8(sp)
    80002a48:	01010113          	addi	sp,sp,16
    80002a4c:	00008067          	ret
        head = tail = process;
    80002a50:	00006797          	auipc	a5,0x6
    80002a54:	60878793          	addi	a5,a5,1544 # 80009058 <_ZN9Scheduler4tailE>
    80002a58:	00a7b023          	sd	a0,0(a5)
    80002a5c:	00a7b423          	sd	a0,8(a5)
    80002a60:	fe5ff06f          	j	80002a44 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002a64 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002a64:	ff010113          	addi	sp,sp,-16
    80002a68:	00813423          	sd	s0,8(sp)
    80002a6c:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002a70:	00006517          	auipc	a0,0x6
    80002a74:	5f053503          	ld	a0,1520(a0) # 80009060 <_ZN9Scheduler4headE>
    80002a78:	02050463          	beqz	a0,80002aa0 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002a7c:	00053703          	ld	a4,0(a0)
    80002a80:	00006797          	auipc	a5,0x6
    80002a84:	5d878793          	addi	a5,a5,1496 # 80009058 <_ZN9Scheduler4tailE>
    80002a88:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002a8c:	0007b783          	ld	a5,0(a5)
    80002a90:	00f50e63          	beq	a0,a5,80002aac <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002a94:	00813403          	ld	s0,8(sp)
    80002a98:	01010113          	addi	sp,sp,16
    80002a9c:	00008067          	ret
        return idleProcess;
    80002aa0:	00006517          	auipc	a0,0x6
    80002aa4:	5c853503          	ld	a0,1480(a0) # 80009068 <_ZN9Scheduler11idleProcessE>
    80002aa8:	fedff06f          	j	80002a94 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002aac:	00006797          	auipc	a5,0x6
    80002ab0:	5ae7b623          	sd	a4,1452(a5) # 80009058 <_ZN9Scheduler4tailE>
    80002ab4:	fe1ff06f          	j	80002a94 <_ZN9Scheduler3getEv+0x30>

0000000080002ab8 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002ab8:	ff010113          	addi	sp,sp,-16
    80002abc:	00813423          	sd	s0,8(sp)
    80002ac0:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002ac4:	00050e63          	beqz	a0,80002ae0 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002ac8:	00006797          	auipc	a5,0x6
    80002acc:	5987b783          	ld	a5,1432(a5) # 80009060 <_ZN9Scheduler4headE>
    80002ad0:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002ad4:	00078c63          	beqz	a5,80002aec <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002ad8:	00006797          	auipc	a5,0x6
    80002adc:	58a7b423          	sd	a0,1416(a5) # 80009060 <_ZN9Scheduler4headE>
    }
}
    80002ae0:	00813403          	ld	s0,8(sp)
    80002ae4:	01010113          	addi	sp,sp,16
    80002ae8:	00008067          	ret
        head = tail = process;
    80002aec:	00006797          	auipc	a5,0x6
    80002af0:	56c78793          	addi	a5,a5,1388 # 80009058 <_ZN9Scheduler4tailE>
    80002af4:	00a7b023          	sd	a0,0(a5)
    80002af8:	00a7b423          	sd	a0,8(a5)
    80002afc:	fe5ff06f          	j	80002ae0 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002b00 <idleProcess>:
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002b00:	ff010113          	addi	sp,sp,-16
    80002b04:	00813423          	sd	s0,8(sp)
    80002b08:	01010413          	addi	s0,sp,16
    while(true) {}
    80002b0c:	0000006f          	j	80002b0c <idleProcess+0xc>

0000000080002b10 <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    80002b10:	ff010113          	addi	sp,sp,-16
    80002b14:	00113423          	sd	ra,8(sp)
    80002b18:	00813023          	sd	s0,0(sp)
    80002b1c:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    80002b20:	00000097          	auipc	ra,0x0
    80002b24:	ebc080e7          	jalr	-324(ra) # 800029dc <_Z8userMainv>
}
    80002b28:	00813083          	ld	ra,8(sp)
    80002b2c:	00013403          	ld	s0,0(sp)
    80002b30:	01010113          	addi	sp,sp,16
    80002b34:	00008067          	ret

0000000080002b38 <_Z8userModev>:
void userMode() {
    80002b38:	ff010113          	addi	sp,sp,-16
    80002b3c:	00813423          	sd	s0,8(sp)
    80002b40:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80002b44:	04300793          	li	a5,67
    80002b48:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002b4c:	00000073          	ecall
}
    80002b50:	00813403          	ld	s0,8(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <main>:
}
// ------------

int main() {
    80002b5c:	ff010113          	addi	sp,sp,-16
    80002b60:	00113423          	sd	ra,8(sp)
    80002b64:	00813023          	sd	s0,0(sp)
    80002b68:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002b6c:	00006797          	auipc	a5,0x6
    80002b70:	3b47b783          	ld	a5,948(a5) # 80008f20 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002b74:	10579073          	csrw	stvec,a5
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);
    80002b78:	010005b7          	lui	a1,0x1000
    80002b7c:	00006797          	auipc	a5,0x6
    80002b80:	3447b783          	ld	a5,836(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002b84:	0007b503          	ld	a0,0(a5)
    80002b88:	00001097          	auipc	ra,0x1
    80002b8c:	4e8080e7          	jalr	1256(ra) # 80004070 <_Z9kmem_initPvi>
    PCB::initPCBCache();
    80002b90:	fffff097          	auipc	ra,0xfffff
    80002b94:	25c080e7          	jalr	604(ra) # 80001dec <_ZN3PCB12initPCBCacheEv>

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002b98:	00000593          	li	a1,0
    80002b9c:	00000513          	li	a0,0
    80002ba0:	fffff097          	auipc	ra,0xfffff
    80002ba4:	11c080e7          	jalr	284(ra) # 80001cbc <_ZN3PCB16createSysProcessEPFvvEPv>
    PCB::running = main;
    80002ba8:	00006797          	auipc	a5,0x6
    80002bac:	3587b783          	ld	a5,856(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bb0:	00a7b023          	sd	a0,0(a5)
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002bb4:	00000613          	li	a2,0
    80002bb8:	00006597          	auipc	a1,0x6
    80002bbc:	3385b583          	ld	a1,824(a1) # 80008ef0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002bc0:	00006517          	auipc	a0,0x6
    80002bc4:	37853503          	ld	a0,888(a0) # 80008f38 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002bc8:	ffffe097          	auipc	ra,0xffffe
    80002bcc:	738080e7          	jalr	1848(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002bd0:	00000613          	li	a2,0
    80002bd4:	00006597          	auipc	a1,0x6
    80002bd8:	35c5b583          	ld	a1,860(a1) # 80008f30 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002bdc:	00006517          	auipc	a0,0x6
    80002be0:	2d453503          	ld	a0,724(a0) # 80008eb0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002be4:	ffffe097          	auipc	ra,0xffffe
    80002be8:	71c080e7          	jalr	1820(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002bec:	00000613          	li	a2,0
    80002bf0:	00000597          	auipc	a1,0x0
    80002bf4:	f1058593          	addi	a1,a1,-240 # 80002b00 <idleProcess>
    80002bf8:	00006517          	auipc	a0,0x6
    80002bfc:	30053503          	ld	a0,768(a0) # 80008ef8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002c00:	ffffe097          	auipc	ra,0xffffe
    80002c04:	608080e7          	jalr	1544(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80002c08:	00006797          	auipc	a5,0x6
    80002c0c:	2f07b783          	ld	a5,752(a5) # 80008ef8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002c10:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    80002c14:	00100713          	li	a4,1
    80002c18:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    80002c1c:	00100713          	li	a4,1
    80002c20:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    80002c24:	00000593          	li	a1,0
    80002c28:	00006517          	auipc	a0,0x6
    80002c2c:	30053503          	ld	a0,768(a0) # 80008f28 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c30:	ffffe097          	auipc	ra,0xffffe
    80002c34:	720080e7          	jalr	1824(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    80002c38:	00000593          	li	a1,0
    80002c3c:	00006517          	auipc	a0,0x6
    80002c40:	2d453503          	ld	a0,724(a0) # 80008f10 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002c44:	ffffe097          	auipc	ra,0xffffe
    80002c48:	70c080e7          	jalr	1804(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);
    80002c4c:	00000593          	li	a1,0
    80002c50:	00006517          	auipc	a0,0x6
    80002c54:	2c853503          	ld	a0,712(a0) # 80008f18 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002c58:	ffffe097          	auipc	ra,0xffffe
    80002c5c:	6f8080e7          	jalr	1784(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002c60:	00200793          	li	a5,2
    80002c64:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi


    thread_create(&userProcess, userMainWrapper, nullptr);
    80002c68:	00000613          	li	a2,0
    80002c6c:	00000597          	auipc	a1,0x0
    80002c70:	ea458593          	addi	a1,a1,-348 # 80002b10 <_Z15userMainWrapperPv>
    80002c74:	00006517          	auipc	a0,0x6
    80002c78:	3fc50513          	addi	a0,a0,1020 # 80009070 <userProcess>
    80002c7c:	ffffe097          	auipc	ra,0xffffe
    80002c80:	684080e7          	jalr	1668(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    80002c84:	00006797          	auipc	a5,0x6
    80002c88:	3ec7b783          	ld	a5,1004(a5) # 80009070 <userProcess>
        return finished;
    80002c8c:	0287c783          	lbu	a5,40(a5)
    80002c90:	00079863          	bnez	a5,80002ca0 <main+0x144>
        thread_dispatch();
    80002c94:	ffffe097          	auipc	ra,0xffffe
    80002c98:	5e0080e7          	jalr	1504(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    80002c9c:	fe9ff06f          	j	80002c84 <main+0x128>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    80002ca0:	00006797          	auipc	a5,0x6
    80002ca4:	2707b783          	ld	a5,624(a5) # 80008f10 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002ca8:	0007b783          	ld	a5,0(a5)
        return semValue;
    80002cac:	0107a783          	lw	a5,16(a5)
    80002cb0:	00078863          	beqz	a5,80002cc0 <main+0x164>
        thread_dispatch();
    80002cb4:	ffffe097          	auipc	ra,0xffffe
    80002cb8:	5c0080e7          	jalr	1472(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    80002cbc:	fe5ff06f          	j	80002ca0 <main+0x144>
    }
    return 0;
    80002cc0:	00000513          	li	a0,0
    80002cc4:	00813083          	ld	ra,8(sp)
    80002cc8:	00013403          	ld	s0,0(sp)
    80002ccc:	01010113          	addi	sp,sp,16
    80002cd0:	00008067          	ret

0000000080002cd4 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002cd4:	fe010113          	addi	sp,sp,-32
    80002cd8:	00113c23          	sd	ra,24(sp)
    80002cdc:	00813823          	sd	s0,16(sp)
    80002ce0:	00913423          	sd	s1,8(sp)
    80002ce4:	02010413          	addi	s0,sp,32
    80002ce8:	00006797          	auipc	a5,0x6
    80002cec:	18078793          	addi	a5,a5,384 # 80008e68 <_ZTV6Thread+0x10>
    80002cf0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002cf4:	00853483          	ld	s1,8(a0)
    80002cf8:	00048e63          	beqz	s1,80002d14 <_ZN6ThreadD1Ev+0x40>
    80002cfc:	00048513          	mv	a0,s1
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	e64080e7          	jalr	-412(ra) # 80001b64 <_ZN3PCBD1Ev>
    80002d08:	00048513          	mv	a0,s1
    80002d0c:	fffff097          	auipc	ra,0xfffff
    80002d10:	ecc080e7          	jalr	-308(ra) # 80001bd8 <_ZN3PCBdlEPv>
}
    80002d14:	01813083          	ld	ra,24(sp)
    80002d18:	01013403          	ld	s0,16(sp)
    80002d1c:	00813483          	ld	s1,8(sp)
    80002d20:	02010113          	addi	sp,sp,32
    80002d24:	00008067          	ret

0000000080002d28 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002d28:	ff010113          	addi	sp,sp,-16
    80002d2c:	00113423          	sd	ra,8(sp)
    80002d30:	00813023          	sd	s0,0(sp)
    80002d34:	01010413          	addi	s0,sp,16
    80002d38:	00006797          	auipc	a5,0x6
    80002d3c:	15878793          	addi	a5,a5,344 # 80008e90 <_ZTV9Semaphore+0x10>
    80002d40:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002d44:	00853503          	ld	a0,8(a0)
    80002d48:	ffffe097          	auipc	ra,0xffffe
    80002d4c:	6d8080e7          	jalr	1752(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80002d50:	00813083          	ld	ra,8(sp)
    80002d54:	00013403          	ld	s0,0(sp)
    80002d58:	01010113          	addi	sp,sp,16
    80002d5c:	00008067          	ret

0000000080002d60 <_Znwm>:
void* operator new (size_t size) {
    80002d60:	ff010113          	addi	sp,sp,-16
    80002d64:	00113423          	sd	ra,8(sp)
    80002d68:	00813023          	sd	s0,0(sp)
    80002d6c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002d70:	ffffe097          	auipc	ra,0xffffe
    80002d74:	424080e7          	jalr	1060(ra) # 80001194 <_Z9mem_allocm>
}
    80002d78:	00813083          	ld	ra,8(sp)
    80002d7c:	00013403          	ld	s0,0(sp)
    80002d80:	01010113          	addi	sp,sp,16
    80002d84:	00008067          	ret

0000000080002d88 <_Znam>:
void* operator new [](size_t size) {
    80002d88:	ff010113          	addi	sp,sp,-16
    80002d8c:	00113423          	sd	ra,8(sp)
    80002d90:	00813023          	sd	s0,0(sp)
    80002d94:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002d98:	ffffe097          	auipc	ra,0xffffe
    80002d9c:	3fc080e7          	jalr	1020(ra) # 80001194 <_Z9mem_allocm>
}
    80002da0:	00813083          	ld	ra,8(sp)
    80002da4:	00013403          	ld	s0,0(sp)
    80002da8:	01010113          	addi	sp,sp,16
    80002dac:	00008067          	ret

0000000080002db0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002db0:	ff010113          	addi	sp,sp,-16
    80002db4:	00113423          	sd	ra,8(sp)
    80002db8:	00813023          	sd	s0,0(sp)
    80002dbc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002dc0:	ffffe097          	auipc	ra,0xffffe
    80002dc4:	414080e7          	jalr	1044(ra) # 800011d4 <_Z8mem_freePv>
}
    80002dc8:	00813083          	ld	ra,8(sp)
    80002dcc:	00013403          	ld	s0,0(sp)
    80002dd0:	01010113          	addi	sp,sp,16
    80002dd4:	00008067          	ret

0000000080002dd8 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002dd8:	fe010113          	addi	sp,sp,-32
    80002ddc:	00113c23          	sd	ra,24(sp)
    80002de0:	00813823          	sd	s0,16(sp)
    80002de4:	00913423          	sd	s1,8(sp)
    80002de8:	02010413          	addi	s0,sp,32
    80002dec:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002df0:	00053503          	ld	a0,0(a0)
    80002df4:	0104b783          	ld	a5,16(s1)
    80002df8:	00f50533          	add	a0,a0,a5
    80002dfc:	0084b783          	ld	a5,8(s1)
    80002e00:	0017f713          	andi	a4,a5,1
    80002e04:	00070863          	beqz	a4,80002e14 <_Z13threadWrapperPv+0x3c>
    80002e08:	00053703          	ld	a4,0(a0)
    80002e0c:	00f707b3          	add	a5,a4,a5
    80002e10:	fff7b783          	ld	a5,-1(a5)
    80002e14:	000780e7          	jalr	a5
    delete tArg;
    80002e18:	00048863          	beqz	s1,80002e28 <_Z13threadWrapperPv+0x50>
    80002e1c:	00048513          	mv	a0,s1
    80002e20:	00000097          	auipc	ra,0x0
    80002e24:	f90080e7          	jalr	-112(ra) # 80002db0 <_ZdlPv>
}
    80002e28:	01813083          	ld	ra,24(sp)
    80002e2c:	01013403          	ld	s0,16(sp)
    80002e30:	00813483          	ld	s1,8(sp)
    80002e34:	02010113          	addi	sp,sp,32
    80002e38:	00008067          	ret

0000000080002e3c <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002e3c:	ff010113          	addi	sp,sp,-16
    80002e40:	00113423          	sd	ra,8(sp)
    80002e44:	00813023          	sd	s0,0(sp)
    80002e48:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002e4c:	ffffe097          	auipc	ra,0xffffe
    80002e50:	388080e7          	jalr	904(ra) # 800011d4 <_Z8mem_freePv>
}
    80002e54:	00813083          	ld	ra,8(sp)
    80002e58:	00013403          	ld	s0,0(sp)
    80002e5c:	01010113          	addi	sp,sp,16
    80002e60:	00008067          	ret

0000000080002e64 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002e64:	ff010113          	addi	sp,sp,-16
    80002e68:	00113423          	sd	ra,8(sp)
    80002e6c:	00813023          	sd	s0,0(sp)
    80002e70:	01010413          	addi	s0,sp,16
    80002e74:	00006797          	auipc	a5,0x6
    80002e78:	ff478793          	addi	a5,a5,-12 # 80008e68 <_ZTV6Thread+0x10>
    80002e7c:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002e80:	00850513          	addi	a0,a0,8
    80002e84:	ffffe097          	auipc	ra,0xffffe
    80002e88:	384080e7          	jalr	900(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002e8c:	00813083          	ld	ra,8(sp)
    80002e90:	00013403          	ld	s0,0(sp)
    80002e94:	01010113          	addi	sp,sp,16
    80002e98:	00008067          	ret

0000000080002e9c <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002e9c:	ff010113          	addi	sp,sp,-16
    80002ea0:	00113423          	sd	ra,8(sp)
    80002ea4:	00813023          	sd	s0,0(sp)
    80002ea8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002eac:	00001097          	auipc	ra,0x1
    80002eb0:	ea0080e7          	jalr	-352(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
}
    80002eb4:	00813083          	ld	ra,8(sp)
    80002eb8:	00013403          	ld	s0,0(sp)
    80002ebc:	01010113          	addi	sp,sp,16
    80002ec0:	00008067          	ret

0000000080002ec4 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002ec4:	ff010113          	addi	sp,sp,-16
    80002ec8:	00113423          	sd	ra,8(sp)
    80002ecc:	00813023          	sd	s0,0(sp)
    80002ed0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002ed4:	00001097          	auipc	ra,0x1
    80002ed8:	fe8080e7          	jalr	-24(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002edc:	00813083          	ld	ra,8(sp)
    80002ee0:	00013403          	ld	s0,0(sp)
    80002ee4:	01010113          	addi	sp,sp,16
    80002ee8:	00008067          	ret

0000000080002eec <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002eec:	fe010113          	addi	sp,sp,-32
    80002ef0:	00113c23          	sd	ra,24(sp)
    80002ef4:	00813823          	sd	s0,16(sp)
    80002ef8:	00913423          	sd	s1,8(sp)
    80002efc:	02010413          	addi	s0,sp,32
    80002f00:	00050493          	mv	s1,a0
}
    80002f04:	00000097          	auipc	ra,0x0
    80002f08:	dd0080e7          	jalr	-560(ra) # 80002cd4 <_ZN6ThreadD1Ev>
    80002f0c:	00048513          	mv	a0,s1
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	fb4080e7          	jalr	-76(ra) # 80002ec4 <_ZN6ThreaddlEPv>
    80002f18:	01813083          	ld	ra,24(sp)
    80002f1c:	01013403          	ld	s0,16(sp)
    80002f20:	00813483          	ld	s1,8(sp)
    80002f24:	02010113          	addi	sp,sp,32
    80002f28:	00008067          	ret

0000000080002f2c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002f2c:	ff010113          	addi	sp,sp,-16
    80002f30:	00113423          	sd	ra,8(sp)
    80002f34:	00813023          	sd	s0,0(sp)
    80002f38:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002f3c:	ffffe097          	auipc	ra,0xffffe
    80002f40:	338080e7          	jalr	824(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002f44:	00813083          	ld	ra,8(sp)
    80002f48:	00013403          	ld	s0,0(sp)
    80002f4c:	01010113          	addi	sp,sp,16
    80002f50:	00008067          	ret

0000000080002f54 <_ZN6Thread5startEv>:
int Thread::start() {
    80002f54:	ff010113          	addi	sp,sp,-16
    80002f58:	00113423          	sd	ra,8(sp)
    80002f5c:	00813023          	sd	s0,0(sp)
    80002f60:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002f64:	00850513          	addi	a0,a0,8
    80002f68:	ffffe097          	auipc	ra,0xffffe
    80002f6c:	368080e7          	jalr	872(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002f70:	00000513          	li	a0,0
    80002f74:	00813083          	ld	ra,8(sp)
    80002f78:	00013403          	ld	s0,0(sp)
    80002f7c:	01010113          	addi	sp,sp,16
    80002f80:	00008067          	ret

0000000080002f84 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002f84:	fe010113          	addi	sp,sp,-32
    80002f88:	00113c23          	sd	ra,24(sp)
    80002f8c:	00813823          	sd	s0,16(sp)
    80002f90:	00913423          	sd	s1,8(sp)
    80002f94:	02010413          	addi	s0,sp,32
    80002f98:	00050493          	mv	s1,a0
    80002f9c:	00006797          	auipc	a5,0x6
    80002fa0:	ecc78793          	addi	a5,a5,-308 # 80008e68 <_ZTV6Thread+0x10>
    80002fa4:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002fa8:	01800513          	li	a0,24
    80002fac:	00000097          	auipc	ra,0x0
    80002fb0:	db4080e7          	jalr	-588(ra) # 80002d60 <_Znwm>
    80002fb4:	00050613          	mv	a2,a0
    80002fb8:	00953023          	sd	s1,0(a0)
    80002fbc:	01100793          	li	a5,17
    80002fc0:	00f53423          	sd	a5,8(a0)
    80002fc4:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80002fc8:	00000597          	auipc	a1,0x0
    80002fcc:	e1058593          	addi	a1,a1,-496 # 80002dd8 <_Z13threadWrapperPv>
    80002fd0:	00848513          	addi	a0,s1,8
    80002fd4:	ffffe097          	auipc	ra,0xffffe
    80002fd8:	234080e7          	jalr	564(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002fdc:	01813083          	ld	ra,24(sp)
    80002fe0:	01013403          	ld	s0,16(sp)
    80002fe4:	00813483          	ld	s1,8(sp)
    80002fe8:	02010113          	addi	sp,sp,32
    80002fec:	00008067          	ret

0000000080002ff0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002ff0:	ff010113          	addi	sp,sp,-16
    80002ff4:	00113423          	sd	ra,8(sp)
    80002ff8:	00813023          	sd	s0,0(sp)
    80002ffc:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003000:	ffffe097          	auipc	ra,0xffffe
    80003004:	460080e7          	jalr	1120(ra) # 80001460 <_Z10time_sleepm>
}
    80003008:	00813083          	ld	ra,8(sp)
    8000300c:	00013403          	ld	s0,0(sp)
    80003010:	01010113          	addi	sp,sp,16
    80003014:	00008067          	ret

0000000080003018 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80003018:	fe010113          	addi	sp,sp,-32
    8000301c:	00113c23          	sd	ra,24(sp)
    80003020:	00813823          	sd	s0,16(sp)
    80003024:	00913423          	sd	s1,8(sp)
    80003028:	02010413          	addi	s0,sp,32
    8000302c:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80003030:	0200006f          	j	80003050 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80003034:	00053703          	ld	a4,0(a0)
    80003038:	00f707b3          	add	a5,a4,a5
    8000303c:	fff7b783          	ld	a5,-1(a5)
    80003040:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80003044:	0184b503          	ld	a0,24(s1)
    80003048:	00000097          	auipc	ra,0x0
    8000304c:	fa8080e7          	jalr	-88(ra) # 80002ff0 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80003050:	0004b503          	ld	a0,0(s1)
    80003054:	0104b783          	ld	a5,16(s1)
    80003058:	00f50533          	add	a0,a0,a5
    8000305c:	0084b783          	ld	a5,8(s1)
    80003060:	0017f713          	andi	a4,a5,1
    80003064:	fc070ee3          	beqz	a4,80003040 <_Z21periodicThreadWrapperPv+0x28>
    80003068:	fcdff06f          	j	80003034 <_Z21periodicThreadWrapperPv+0x1c>

000000008000306c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000306c:	fe010113          	addi	sp,sp,-32
    80003070:	00113c23          	sd	ra,24(sp)
    80003074:	00813823          	sd	s0,16(sp)
    80003078:	00913423          	sd	s1,8(sp)
    8000307c:	01213023          	sd	s2,0(sp)
    80003080:	02010413          	addi	s0,sp,32
    80003084:	00050493          	mv	s1,a0
    80003088:	00006797          	auipc	a5,0x6
    8000308c:	e0878793          	addi	a5,a5,-504 # 80008e90 <_ZTV9Semaphore+0x10>
    80003090:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80003094:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80003098:	01800513          	li	a0,24
    8000309c:	00000097          	auipc	ra,0x0
    800030a0:	474080e7          	jalr	1140(ra) # 80003510 <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    800030a4:	00053023          	sd	zero,0(a0)
    800030a8:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    800030ac:	01252823          	sw	s2,16(a0)
    800030b0:	00a4b423          	sd	a0,8(s1)
}
    800030b4:	01813083          	ld	ra,24(sp)
    800030b8:	01013403          	ld	s0,16(sp)
    800030bc:	00813483          	ld	s1,8(sp)
    800030c0:	00013903          	ld	s2,0(sp)
    800030c4:	02010113          	addi	sp,sp,32
    800030c8:	00008067          	ret

00000000800030cc <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800030cc:	ff010113          	addi	sp,sp,-16
    800030d0:	00113423          	sd	ra,8(sp)
    800030d4:	00813023          	sd	s0,0(sp)
    800030d8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800030dc:	00853503          	ld	a0,8(a0)
    800030e0:	ffffe097          	auipc	ra,0xffffe
    800030e4:	2b8080e7          	jalr	696(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    800030e8:	00813083          	ld	ra,8(sp)
    800030ec:	00013403          	ld	s0,0(sp)
    800030f0:	01010113          	addi	sp,sp,16
    800030f4:	00008067          	ret

00000000800030f8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800030f8:	ff010113          	addi	sp,sp,-16
    800030fc:	00113423          	sd	ra,8(sp)
    80003100:	00813023          	sd	s0,0(sp)
    80003104:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003108:	00853503          	ld	a0,8(a0)
    8000310c:	ffffe097          	auipc	ra,0xffffe
    80003110:	2d4080e7          	jalr	724(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80003114:	00813083          	ld	ra,8(sp)
    80003118:	00013403          	ld	s0,0(sp)
    8000311c:	01010113          	addi	sp,sp,16
    80003120:	00008067          	ret

0000000080003124 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80003124:	ff010113          	addi	sp,sp,-16
    80003128:	00113423          	sd	ra,8(sp)
    8000312c:	00813023          	sd	s0,0(sp)
    80003130:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003134:	00001097          	auipc	ra,0x1
    80003138:	d88080e7          	jalr	-632(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000313c:	00813083          	ld	ra,8(sp)
    80003140:	00013403          	ld	s0,0(sp)
    80003144:	01010113          	addi	sp,sp,16
    80003148:	00008067          	ret

000000008000314c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    8000314c:	fe010113          	addi	sp,sp,-32
    80003150:	00113c23          	sd	ra,24(sp)
    80003154:	00813823          	sd	s0,16(sp)
    80003158:	00913423          	sd	s1,8(sp)
    8000315c:	02010413          	addi	s0,sp,32
    80003160:	00050493          	mv	s1,a0
}
    80003164:	00000097          	auipc	ra,0x0
    80003168:	bc4080e7          	jalr	-1084(ra) # 80002d28 <_ZN9SemaphoreD1Ev>
    8000316c:	00048513          	mv	a0,s1
    80003170:	00000097          	auipc	ra,0x0
    80003174:	fb4080e7          	jalr	-76(ra) # 80003124 <_ZN9SemaphoredlEPv>
    80003178:	01813083          	ld	ra,24(sp)
    8000317c:	01013403          	ld	s0,16(sp)
    80003180:	00813483          	ld	s1,8(sp)
    80003184:	02010113          	addi	sp,sp,32
    80003188:	00008067          	ret

000000008000318c <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    8000318c:	ff010113          	addi	sp,sp,-16
    80003190:	00113423          	sd	ra,8(sp)
    80003194:	00813023          	sd	s0,0(sp)
    80003198:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000319c:	00001097          	auipc	ra,0x1
    800031a0:	bb0080e7          	jalr	-1104(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
}
    800031a4:	00813083          	ld	ra,8(sp)
    800031a8:	00013403          	ld	s0,0(sp)
    800031ac:	01010113          	addi	sp,sp,16
    800031b0:	00008067          	ret

00000000800031b4 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    800031b4:	fe010113          	addi	sp,sp,-32
    800031b8:	00113c23          	sd	ra,24(sp)
    800031bc:	00813823          	sd	s0,16(sp)
    800031c0:	00913423          	sd	s1,8(sp)
    800031c4:	01213023          	sd	s2,0(sp)
    800031c8:	02010413          	addi	s0,sp,32
    800031cc:	00050493          	mv	s1,a0
    800031d0:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    800031d4:	02000513          	li	a0,32
    800031d8:	00000097          	auipc	ra,0x0
    800031dc:	b88080e7          	jalr	-1144(ra) # 80002d60 <_Znwm>
    800031e0:	00050613          	mv	a2,a0
    800031e4:	00953023          	sd	s1,0(a0)
    800031e8:	01900793          	li	a5,25
    800031ec:	00f53423          	sd	a5,8(a0)
    800031f0:	00053823          	sd	zero,16(a0)
    800031f4:	01253c23          	sd	s2,24(a0)
    800031f8:	00000597          	auipc	a1,0x0
    800031fc:	e2058593          	addi	a1,a1,-480 # 80003018 <_Z21periodicThreadWrapperPv>
    80003200:	00048513          	mv	a0,s1
    80003204:	00000097          	auipc	ra,0x0
    80003208:	c60080e7          	jalr	-928(ra) # 80002e64 <_ZN6ThreadC1EPFvPvES0_>
    8000320c:	00006797          	auipc	a5,0x6
    80003210:	c2c78793          	addi	a5,a5,-980 # 80008e38 <_ZTV14PeriodicThread+0x10>
    80003214:	00f4b023          	sd	a5,0(s1)
{}
    80003218:	01813083          	ld	ra,24(sp)
    8000321c:	01013403          	ld	s0,16(sp)
    80003220:	00813483          	ld	s1,8(sp)
    80003224:	00013903          	ld	s2,0(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <_ZN7Console4getcEv>:


char Console::getc() {
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00113423          	sd	ra,8(sp)
    80003238:	00813023          	sd	s0,0(sp)
    8000323c:	01010413          	addi	s0,sp,16
    return ::getc();
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	268080e7          	jalr	616(ra) # 800014a8 <_Z4getcv>
}
    80003248:	00813083          	ld	ra,8(sp)
    8000324c:	00013403          	ld	s0,0(sp)
    80003250:	01010113          	addi	sp,sp,16
    80003254:	00008067          	ret

0000000080003258 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003258:	ff010113          	addi	sp,sp,-16
    8000325c:	00113423          	sd	ra,8(sp)
    80003260:	00813023          	sd	s0,0(sp)
    80003264:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80003268:	ffffe097          	auipc	ra,0xffffe
    8000326c:	270080e7          	jalr	624(ra) # 800014d8 <_Z4putcc>
}
    80003270:	00813083          	ld	ra,8(sp)
    80003274:	00013403          	ld	s0,0(sp)
    80003278:	01010113          	addi	sp,sp,16
    8000327c:	00008067          	ret

0000000080003280 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80003280:	ff010113          	addi	sp,sp,-16
    80003284:	00813423          	sd	s0,8(sp)
    80003288:	01010413          	addi	s0,sp,16
    8000328c:	00813403          	ld	s0,8(sp)
    80003290:	01010113          	addi	sp,sp,16
    80003294:	00008067          	ret

0000000080003298 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80003298:	ff010113          	addi	sp,sp,-16
    8000329c:	00813423          	sd	s0,8(sp)
    800032a0:	01010413          	addi	s0,sp,16
    800032a4:	00813403          	ld	s0,8(sp)
    800032a8:	01010113          	addi	sp,sp,16
    800032ac:	00008067          	ret

00000000800032b0 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800032b0:	ff010113          	addi	sp,sp,-16
    800032b4:	00113423          	sd	ra,8(sp)
    800032b8:	00813023          	sd	s0,0(sp)
    800032bc:	01010413          	addi	s0,sp,16
    800032c0:	00006797          	auipc	a5,0x6
    800032c4:	b7878793          	addi	a5,a5,-1160 # 80008e38 <_ZTV14PeriodicThread+0x10>
    800032c8:	00f53023          	sd	a5,0(a0)
    800032cc:	00000097          	auipc	ra,0x0
    800032d0:	a08080e7          	jalr	-1528(ra) # 80002cd4 <_ZN6ThreadD1Ev>
    800032d4:	00813083          	ld	ra,8(sp)
    800032d8:	00013403          	ld	s0,0(sp)
    800032dc:	01010113          	addi	sp,sp,16
    800032e0:	00008067          	ret

00000000800032e4 <_ZN14PeriodicThreadD0Ev>:
    800032e4:	fe010113          	addi	sp,sp,-32
    800032e8:	00113c23          	sd	ra,24(sp)
    800032ec:	00813823          	sd	s0,16(sp)
    800032f0:	00913423          	sd	s1,8(sp)
    800032f4:	02010413          	addi	s0,sp,32
    800032f8:	00050493          	mv	s1,a0
    800032fc:	00006797          	auipc	a5,0x6
    80003300:	b3c78793          	addi	a5,a5,-1220 # 80008e38 <_ZTV14PeriodicThread+0x10>
    80003304:	00f53023          	sd	a5,0(a0)
    80003308:	00000097          	auipc	ra,0x0
    8000330c:	9cc080e7          	jalr	-1588(ra) # 80002cd4 <_ZN6ThreadD1Ev>
    80003310:	00048513          	mv	a0,s1
    80003314:	00000097          	auipc	ra,0x0
    80003318:	bb0080e7          	jalr	-1104(ra) # 80002ec4 <_ZN6ThreaddlEPv>
    8000331c:	01813083          	ld	ra,24(sp)
    80003320:	01013403          	ld	s0,16(sp)
    80003324:	00813483          	ld	s1,8(sp)
    80003328:	02010113          	addi	sp,sp,32
    8000332c:	00008067          	ret

0000000080003330 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80003330:	ff010113          	addi	sp,sp,-16
    80003334:	00813423          	sd	s0,8(sp)
    80003338:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    8000333c:	00006797          	auipc	a5,0x6
    80003340:	bc47b783          	ld	a5,-1084(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003344:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80003348:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    8000334c:	00853783          	ld	a5,8(a0)
    80003350:	04078063          	beqz	a5,80003390 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80003354:	00006717          	auipc	a4,0x6
    80003358:	bac73703          	ld	a4,-1108(a4) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000335c:	00073703          	ld	a4,0(a4)
    80003360:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80003364:	00853783          	ld	a5,8(a0)
        return nextInList;
    80003368:	0007b783          	ld	a5,0(a5)
    8000336c:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80003370:	00006797          	auipc	a5,0x6
    80003374:	b907b783          	ld	a5,-1136(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003378:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    8000337c:	00100713          	li	a4,1
    80003380:	02e784a3          	sb	a4,41(a5)
}
    80003384:	00813403          	ld	s0,8(sp)
    80003388:	01010113          	addi	sp,sp,16
    8000338c:	00008067          	ret
        head = tail = PCB::running;
    80003390:	00006797          	auipc	a5,0x6
    80003394:	b707b783          	ld	a5,-1168(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003398:	0007b783          	ld	a5,0(a5)
    8000339c:	00f53423          	sd	a5,8(a0)
    800033a0:	00f53023          	sd	a5,0(a0)
    800033a4:	fcdff06f          	j	80003370 <_ZN3SCB5blockEv+0x40>

00000000800033a8 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800033a8:	ff010113          	addi	sp,sp,-16
    800033ac:	00813423          	sd	s0,8(sp)
    800033b0:	01010413          	addi	s0,sp,16
    800033b4:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800033b8:	00053503          	ld	a0,0(a0)
    800033bc:	00050e63          	beqz	a0,800033d8 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800033c0:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800033c4:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800033c8:	0087b683          	ld	a3,8(a5)
    800033cc:	00d50c63          	beq	a0,a3,800033e4 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    800033d0:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    800033d4:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    800033d8:	00813403          	ld	s0,8(sp)
    800033dc:	01010113          	addi	sp,sp,16
    800033e0:	00008067          	ret
        tail = head;
    800033e4:	00e7b423          	sd	a4,8(a5)
    800033e8:	fe9ff06f          	j	800033d0 <_ZN3SCB7unblockEv+0x28>

00000000800033ec <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    800033ec:	01052783          	lw	a5,16(a0)
    800033f0:	fff7879b          	addiw	a5,a5,-1
    800033f4:	00f52823          	sw	a5,16(a0)
    800033f8:	02079713          	slli	a4,a5,0x20
    800033fc:	02074063          	bltz	a4,8000341c <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80003400:	00006797          	auipc	a5,0x6
    80003404:	b007b783          	ld	a5,-1280(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003408:	0007b783          	ld	a5,0(a5)
    8000340c:	02a7c783          	lbu	a5,42(a5)
    80003410:	06079463          	bnez	a5,80003478 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003414:	00000513          	li	a0,0
    80003418:	00008067          	ret
int SCB::wait() {
    8000341c:	ff010113          	addi	sp,sp,-16
    80003420:	00113423          	sd	ra,8(sp)
    80003424:	00813023          	sd	s0,0(sp)
    80003428:	01010413          	addi	s0,sp,16
        block();
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	f04080e7          	jalr	-252(ra) # 80003330 <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80003434:	00006797          	auipc	a5,0x6
    80003438:	aac7b783          	ld	a5,-1364(a5) # 80008ee0 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000343c:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80003440:	ffffe097          	auipc	ra,0xffffe
    80003444:	694080e7          	jalr	1684(ra) # 80001ad4 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80003448:	00006797          	auipc	a5,0x6
    8000344c:	ab87b783          	ld	a5,-1352(a5) # 80008f00 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003450:	0007b783          	ld	a5,0(a5)
    80003454:	02a7c783          	lbu	a5,42(a5)
    80003458:	00079c63          	bnez	a5,80003470 <_ZN3SCB4waitEv+0x84>
    return 0;
    8000345c:	00000513          	li	a0,0

}
    80003460:	00813083          	ld	ra,8(sp)
    80003464:	00013403          	ld	s0,0(sp)
    80003468:	01010113          	addi	sp,sp,16
    8000346c:	00008067          	ret
        return -2;
    80003470:	ffe00513          	li	a0,-2
    80003474:	fedff06f          	j	80003460 <_ZN3SCB4waitEv+0x74>
    80003478:	ffe00513          	li	a0,-2
}
    8000347c:	00008067          	ret

0000000080003480 <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    80003480:	01052783          	lw	a5,16(a0)
    80003484:	0017879b          	addiw	a5,a5,1
    80003488:	0007871b          	sext.w	a4,a5
    8000348c:	00f52823          	sw	a5,16(a0)
    80003490:	00e05463          	blez	a4,80003498 <_ZN3SCB6signalEv+0x18>
    80003494:	00008067          	ret
void SCB::signal() {
    80003498:	ff010113          	addi	sp,sp,-16
    8000349c:	00113423          	sd	ra,8(sp)
    800034a0:	00813023          	sd	s0,0(sp)
    800034a4:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800034a8:	00000097          	auipc	ra,0x0
    800034ac:	f00080e7          	jalr	-256(ra) # 800033a8 <_ZN3SCB7unblockEv>
    800034b0:	fffff097          	auipc	ra,0xfffff
    800034b4:	55c080e7          	jalr	1372(ra) # 80002a0c <_ZN9Scheduler3putEP3PCB>
    }

}
    800034b8:	00813083          	ld	ra,8(sp)
    800034bc:	00013403          	ld	s0,0(sp)
    800034c0:	01010113          	addi	sp,sp,16
    800034c4:	00008067          	ret

00000000800034c8 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    800034c8:	01052783          	lw	a5,16(a0)
    800034cc:	0017879b          	addiw	a5,a5,1
    800034d0:	0007871b          	sext.w	a4,a5
    800034d4:	00f52823          	sw	a5,16(a0)
    800034d8:	00e05463          	blez	a4,800034e0 <_ZN3SCB14prioritySignalEv+0x18>
    800034dc:	00008067          	ret
void SCB::prioritySignal() {
    800034e0:	ff010113          	addi	sp,sp,-16
    800034e4:	00113423          	sd	ra,8(sp)
    800034e8:	00813023          	sd	s0,0(sp)
    800034ec:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    800034f0:	00000097          	auipc	ra,0x0
    800034f4:	eb8080e7          	jalr	-328(ra) # 800033a8 <_ZN3SCB7unblockEv>
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	5c0080e7          	jalr	1472(ra) # 80002ab8 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    80003500:	00813083          	ld	ra,8(sp)
    80003504:	00013403          	ld	s0,0(sp)
    80003508:	01010113          	addi	sp,sp,16
    8000350c:	00008067          	ret

0000000080003510 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80003510:	ff010113          	addi	sp,sp,-16
    80003514:	00113423          	sd	ra,8(sp)
    80003518:	00813023          	sd	s0,0(sp)
    8000351c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80003520:	00001097          	auipc	ra,0x1
    80003524:	82c080e7          	jalr	-2004(ra) # 80003d4c <_ZN15MemoryAllocator9mem_allocEm>
}
    80003528:	00813083          	ld	ra,8(sp)
    8000352c:	00013403          	ld	s0,0(sp)
    80003530:	01010113          	addi	sp,sp,16
    80003534:	00008067          	ret

0000000080003538 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80003538:	ff010113          	addi	sp,sp,-16
    8000353c:	00113423          	sd	ra,8(sp)
    80003540:	00813023          	sd	s0,0(sp)
    80003544:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003548:	00001097          	auipc	ra,0x1
    8000354c:	974080e7          	jalr	-1676(ra) # 80003ebc <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003550:	00813083          	ld	ra,8(sp)
    80003554:	00013403          	ld	s0,0(sp)
    80003558:	01010113          	addi	sp,sp,16
    8000355c:	00008067          	ret

0000000080003560 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80003560:	fe010113          	addi	sp,sp,-32
    80003564:	00113c23          	sd	ra,24(sp)
    80003568:	00813823          	sd	s0,16(sp)
    8000356c:	00913423          	sd	s1,8(sp)
    80003570:	01213023          	sd	s2,0(sp)
    80003574:	02010413          	addi	s0,sp,32
    80003578:	00050913          	mv	s2,a0
    PCB* curr = head;
    8000357c:	00053503          	ld	a0,0(a0)
    while(curr) {
    80003580:	02050263          	beqz	a0,800035a4 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    80003584:	00100793          	li	a5,1
    80003588:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    8000358c:	020504a3          	sb	zero,41(a0)
        return nextInList;
    80003590:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	478080e7          	jalr	1144(ra) # 80002a0c <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    8000359c:	00048513          	mv	a0,s1
    while(curr) {
    800035a0:	fe1ff06f          	j	80003580 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    800035a4:	00093423          	sd	zero,8(s2)
    800035a8:	00093023          	sd	zero,0(s2)
}
    800035ac:	01813083          	ld	ra,24(sp)
    800035b0:	01013403          	ld	s0,16(sp)
    800035b4:	00813483          	ld	s1,8(sp)
    800035b8:	00013903          	ld	s2,0(sp)
    800035bc:	02010113          	addi	sp,sp,32
    800035c0:	00008067          	ret

00000000800035c4 <_ZN5Cache11getNumSlotsEm>:
    slotSize = objectSize + sizeof(Slot);

    optimalSlots = getNumSlots(slotSize);
}

int Cache::getNumSlots(size_t objSize) {
    800035c4:	ff010113          	addi	sp,sp,-16
    800035c8:	00813423          	sd	s0,8(sp)
    800035cc:	01010413          	addi	s0,sp,16
    return (BLKSIZE - sizeof(Slab)) / objSize;
    800035d0:	000017b7          	lui	a5,0x1
    800035d4:	fd878793          	addi	a5,a5,-40 # fd8 <_entry-0x7ffff028>
    800035d8:	02a7d533          	divu	a0,a5,a0
}
    800035dc:	0005051b          	sext.w	a0,a0
    800035e0:	00813403          	ld	s0,8(sp)
    800035e4:	01010113          	addi	sp,sp,16
    800035e8:	00008067          	ret

00000000800035ec <_ZN5Cache9initCacheEPKcmPFvPvES4_>:
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800035ec:	fe010113          	addi	sp,sp,-32
    800035f0:	00113c23          	sd	ra,24(sp)
    800035f4:	00813823          	sd	s0,16(sp)
    800035f8:	00913423          	sd	s1,8(sp)
    800035fc:	02010413          	addi	s0,sp,32
    80003600:	00050493          	mv	s1,a0
    for(int i = 0;; i++) {
    80003604:	00000793          	li	a5,0
        cacheName[i] = name[i];
    80003608:	00f58833          	add	a6,a1,a5
    8000360c:	00084303          	lbu	t1,0(a6)
    80003610:	00f488b3          	add	a7,s1,a5
    80003614:	02688023          	sb	t1,32(a7)
        if(name[i] == '\0') break;
    80003618:	00084803          	lbu	a6,0(a6)
    8000361c:	00080663          	beqz	a6,80003628 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x3c>
    for(int i = 0;; i++) {
    80003620:	0017879b          	addiw	a5,a5,1
        cacheName[i] = name[i];
    80003624:	fe5ff06f          	j	80003608 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x1c>
    for(int i = 0; i < 3; i++) {
    80003628:	00000793          	li	a5,0
    8000362c:	00200593          	li	a1,2
    80003630:	00f5cc63          	blt	a1,a5,80003648 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x5c>
        slabList[i] = nullptr;
    80003634:	00379593          	slli	a1,a5,0x3
    80003638:	00b485b3          	add	a1,s1,a1
    8000363c:	0005b423          	sd	zero,8(a1)
    for(int i = 0; i < 3; i++) {
    80003640:	0017879b          	addiw	a5,a5,1
    80003644:	fe9ff06f          	j	8000362c <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x40>
    objectSize = size;
    80003648:	02c4b823          	sd	a2,48(s1)
    constructor = ctor;
    8000364c:	04d4b423          	sd	a3,72(s1)
    destructor = dtor;
    80003650:	04e4b823          	sd	a4,80(s1)
    slotSize = objectSize + sizeof(Slot);
    80003654:	01860513          	addi	a0,a2,24
    80003658:	04a4b023          	sd	a0,64(s1)
    optimalSlots = getNumSlots(slotSize);
    8000365c:	00000097          	auipc	ra,0x0
    80003660:	f68080e7          	jalr	-152(ra) # 800035c4 <_ZN5Cache11getNumSlotsEm>
    80003664:	02a4bc23          	sd	a0,56(s1)
}
    80003668:	01813083          	ld	ra,24(sp)
    8000366c:	01013403          	ld	s0,16(sp)
    80003670:	00813483          	ld	s1,8(sp)
    80003674:	02010113          	addi	sp,sp,32
    80003678:	00008067          	ret

000000008000367c <_ZN5Cache12allocateSlabEv>:
    }

    return nullptr;
}

Cache::Slab *Cache::allocateSlab() {
    8000367c:	fc010113          	addi	sp,sp,-64
    80003680:	02113c23          	sd	ra,56(sp)
    80003684:	02813823          	sd	s0,48(sp)
    80003688:	02913423          	sd	s1,40(sp)
    8000368c:	03213023          	sd	s2,32(sp)
    80003690:	01313c23          	sd	s3,24(sp)
    80003694:	01413823          	sd	s4,16(sp)
    80003698:	01513423          	sd	s5,8(sp)
    8000369c:	04010413          	addi	s0,sp,64
    800036a0:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(1);
    800036a4:	00100513          	li	a0,1
    800036a8:	fffff097          	auipc	ra,0xfffff
    800036ac:	ac0080e7          	jalr	-1344(ra) # 80002168 <_ZN14BuddyAllocator10buddyAllocEm>
    800036b0:	00050a13          	mv	s4,a0
    slab->parentCache = this;
    800036b4:	01253c23          	sd	s2,24(a0)
    slab->next = nullptr;
    800036b8:	00053423          	sd	zero,8(a0)
    slab->state = CREATED;
    800036bc:	00300793          	li	a5,3
    800036c0:	00f52823          	sw	a5,16(a0)
    slab->allocatedSlots = 0;
    800036c4:	00053023          	sd	zero,0(a0)
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    800036c8:	02850a93          	addi	s5,a0,40
    Slot* prev = nullptr;
    for(size_t i = 0; i < this->optimalSlots; i++) {
    800036cc:	00000493          	li	s1,0
    Slot* prev = nullptr;
    800036d0:	00000993          	li	s3,0
    800036d4:	0140006f          	j	800036e8 <_ZN5Cache12allocateSlabEv+0x6c>
        curr->allocated = false;
        if(prev) {
            prev->next= curr;
        }
        else {
            slab->slotHead = curr;
    800036d8:	02fa3023          	sd	a5,32(s4)
        }
        curr->next = nullptr;
    800036dc:	0007b423          	sd	zero,8(a5)
    for(size_t i = 0; i < this->optimalSlots; i++) {
    800036e0:	00148493          	addi	s1,s1,1
        prev = curr;
    800036e4:	00078993          	mv	s3,a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    800036e8:	03893783          	ld	a5,56(s2)
    800036ec:	02f4fc63          	bgeu	s1,a5,80003724 <_ZN5Cache12allocateSlabEv+0xa8>
        constructor((void*)((char*)startAddr + i*slotSize));
    800036f0:	04893783          	ld	a5,72(s2)
    800036f4:	04093503          	ld	a0,64(s2)
    800036f8:	02950533          	mul	a0,a0,s1
    800036fc:	00aa8533          	add	a0,s5,a0
    80003700:	000780e7          	jalr	a5
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
    80003704:	04093783          	ld	a5,64(s2)
    80003708:	029787b3          	mul	a5,a5,s1
    8000370c:	00fa87b3          	add	a5,s5,a5
        curr->parentSlab = slab;
    80003710:	0147b823          	sd	s4,16(a5)
        curr->allocated = false;
    80003714:	00078023          	sb	zero,0(a5)
        if(prev) {
    80003718:	fc0980e3          	beqz	s3,800036d8 <_ZN5Cache12allocateSlabEv+0x5c>
            prev->next= curr;
    8000371c:	00f9b423          	sd	a5,8(s3)
    80003720:	fbdff06f          	j	800036dc <_ZN5Cache12allocateSlabEv+0x60>
    }

    return slab;
}
    80003724:	000a0513          	mv	a0,s4
    80003728:	03813083          	ld	ra,56(sp)
    8000372c:	03013403          	ld	s0,48(sp)
    80003730:	02813483          	ld	s1,40(sp)
    80003734:	02013903          	ld	s2,32(sp)
    80003738:	01813983          	ld	s3,24(sp)
    8000373c:	01013a03          	ld	s4,16(sp)
    80003740:	00813a83          	ld	s5,8(sp)
    80003744:	04010113          	addi	sp,sp,64
    80003748:	00008067          	ret

000000008000374c <_ZN5Cache11slabListPutEPNS_4SlabEi>:


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    8000374c:	ff010113          	addi	sp,sp,-16
    80003750:	00813423          	sd	s0,8(sp)
    80003754:	01010413          	addi	s0,sp,16
    if (!slab || listNum < 0 || listNum > 2) return;
    80003758:	02058a63          	beqz	a1,8000378c <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    8000375c:	02064863          	bltz	a2,8000378c <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    80003760:	00200793          	li	a5,2
    80003764:	02c7c463          	blt	a5,a2,8000378c <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    slab->state = (SlabState)listNum;
    80003768:	00c5a823          	sw	a2,16(a1)
    if(slabList[listNum]) {
    8000376c:	00361793          	slli	a5,a2,0x3
    80003770:	00f507b3          	add	a5,a0,a5
    80003774:	0087b783          	ld	a5,8(a5)
    80003778:	00078463          	beqz	a5,80003780 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x34>
        slab->next = slabList[listNum];
    8000377c:	00f5b423          	sd	a5,8(a1)
    }
    slabList[listNum] = slab;
    80003780:	00361613          	slli	a2,a2,0x3
    80003784:	00c50633          	add	a2,a0,a2
    80003788:	00b63423          	sd	a1,8(a2)
}
    8000378c:	00813403          	ld	s0,8(sp)
    80003790:	01010113          	addi	sp,sp,16
    80003794:	00008067          	ret

0000000080003798 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>:
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    80003798:	ff010113          	addi	sp,sp,-16
    8000379c:	00813423          	sd	s0,8(sp)
    800037a0:	01010413          	addi	s0,sp,16
    if(!slab || listNum < 0 || listNum > 2) return;
    800037a4:	04058063          	beqz	a1,800037e4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    800037a8:	02064e63          	bltz	a2,800037e4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    800037ac:	00200793          	li	a5,2
    800037b0:	02c7ca63          	blt	a5,a2,800037e4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    800037b4:	00361613          	slli	a2,a2,0x3
    800037b8:	00c50633          	add	a2,a0,a2
    800037bc:	00863783          	ld	a5,8(a2)
    Slab* prev = nullptr;
    800037c0:	00000713          	li	a4,0
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    800037c4:	02078063          	beqz	a5,800037e4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
        if(curr == slab) {
    800037c8:	00b78863          	beq	a5,a1,800037d8 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x40>
            prev->next = curr->next;
            curr->next = nullptr;
            break;
        }
        prev = curr;
    800037cc:	00078713          	mv	a4,a5
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    800037d0:	0087b783          	ld	a5,8(a5)
    800037d4:	ff1ff06f          	j	800037c4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x2c>
            prev->next = curr->next;
    800037d8:	0087b683          	ld	a3,8(a5)
    800037dc:	00d73423          	sd	a3,8(a4)
            curr->next = nullptr;
    800037e0:	0007b423          	sd	zero,8(a5)
    }
}
    800037e4:	00813403          	ld	s0,8(sp)
    800037e8:	01010113          	addi	sp,sp,16
    800037ec:	00008067          	ret

00000000800037f0 <_ZN5Cache17printErrorMessageEv>:

int Cache::printErrorMessage() {
    800037f0:	fe010113          	addi	sp,sp,-32
    800037f4:	00113c23          	sd	ra,24(sp)
    800037f8:	00813823          	sd	s0,16(sp)
    800037fc:	00913423          	sd	s1,8(sp)
    80003800:	02010413          	addi	s0,sp,32
    80003804:	00050493          	mv	s1,a0
    switch(errortype) {
    80003808:	00052703          	lw	a4,0(a0)
    8000380c:	00100793          	li	a5,1
    80003810:	02f70663          	beq	a4,a5,8000383c <_ZN5Cache17printErrorMessageEv+0x4c>
        case FREESLOTERROR:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    80003814:	00004517          	auipc	a0,0x4
    80003818:	a2c50513          	addi	a0,a0,-1492 # 80007240 <CONSOLE_STATUS+0x230>
    8000381c:	fffff097          	auipc	ra,0xfffff
    80003820:	f14080e7          	jalr	-236(ra) # 80002730 <_Z11printStringPKc>
    }
    return errortype;
}
    80003824:	0004a503          	lw	a0,0(s1)
    80003828:	01813083          	ld	ra,24(sp)
    8000382c:	01013403          	ld	s0,16(sp)
    80003830:	00813483          	ld	s1,8(sp)
    80003834:	02010113          	addi	sp,sp,32
    80003838:	00008067          	ret
            printString("Greska u oslobadjanju slota");
    8000383c:	00004517          	auipc	a0,0x4
    80003840:	9e450513          	addi	a0,a0,-1564 # 80007220 <CONSOLE_STATUS+0x210>
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	eec080e7          	jalr	-276(ra) # 80002730 <_Z11printStringPKc>
    8000384c:	fc9ff06f          	j	80003814 <_ZN5Cache17printErrorMessageEv+0x24>

0000000080003850 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>:
    printString(", ");
    printInt(numSlots);

}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    80003850:	ff010113          	addi	sp,sp,-16
    80003854:	00813423          	sd	s0,8(sp)
    80003858:	01010413          	addi	s0,sp,16
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
    8000385c:	00000893          	li	a7,0
    int slabs = 0, slots = 0;
    80003860:	00000713          	li	a4,0
    80003864:	00000693          	li	a3,0
    80003868:	0080006f          	j	80003870 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x20>
    for(int i = 0; i < 3; i++) {
    8000386c:	0018889b          	addiw	a7,a7,1
    80003870:	00200793          	li	a5,2
    80003874:	0317c463          	blt	a5,a7,8000389c <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x4c>
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003878:	00389793          	slli	a5,a7,0x3
    8000387c:	00f507b3          	add	a5,a0,a5
    80003880:	0087b783          	ld	a5,8(a5)
    80003884:	fe0784e3          	beqz	a5,8000386c <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x1c>
             slabs++;
    80003888:	0016869b          	addiw	a3,a3,1
             slots += curr->allocatedSlots;
    8000388c:	0007b803          	ld	a6,0(a5)
    80003890:	00e8073b          	addw	a4,a6,a4
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003894:	0087b783          	ld	a5,8(a5)
    80003898:	fedff06f          	j	80003884 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x34>
        }
    }
    (*numSlabs) = slabs;
    8000389c:	00d5a023          	sw	a3,0(a1)
    (*numSlots) = slots;
    800038a0:	00e62023          	sw	a4,0(a2)
}
    800038a4:	00813403          	ld	s0,8(sp)
    800038a8:	01010113          	addi	sp,sp,16
    800038ac:	00008067          	ret

00000000800038b0 <_ZN5Cache14printCacheInfoEv>:
void Cache::printCacheInfo() {
    800038b0:	fd010113          	addi	sp,sp,-48
    800038b4:	02113423          	sd	ra,40(sp)
    800038b8:	02813023          	sd	s0,32(sp)
    800038bc:	00913c23          	sd	s1,24(sp)
    800038c0:	03010413          	addi	s0,sp,48
    800038c4:	00050493          	mv	s1,a0
    int numSlabs = 0, numSlots = 0;
    800038c8:	fc042e23          	sw	zero,-36(s0)
    800038cc:	fc042c23          	sw	zero,-40(s0)
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    800038d0:	fd840613          	addi	a2,s0,-40
    800038d4:	fdc40593          	addi	a1,s0,-36
    800038d8:	00000097          	auipc	ra,0x0
    800038dc:	f78080e7          	jalr	-136(ra) # 80003850 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>
    printString("ime kesa, velicina objekta, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    800038e0:	00004517          	auipc	a0,0x4
    800038e4:	98850513          	addi	a0,a0,-1656 # 80007268 <CONSOLE_STATUS+0x258>
    800038e8:	fffff097          	auipc	ra,0xfffff
    800038ec:	e48080e7          	jalr	-440(ra) # 80002730 <_Z11printStringPKc>
    printString(cacheName);
    800038f0:	02048513          	addi	a0,s1,32
    800038f4:	fffff097          	auipc	ra,0xfffff
    800038f8:	e3c080e7          	jalr	-452(ra) # 80002730 <_Z11printStringPKc>
    printString(", ");
    800038fc:	00004517          	auipc	a0,0x4
    80003900:	9dc50513          	addi	a0,a0,-1572 # 800072d8 <CONSOLE_STATUS+0x2c8>
    80003904:	fffff097          	auipc	ra,0xfffff
    80003908:	e2c080e7          	jalr	-468(ra) # 80002730 <_Z11printStringPKc>
    printInt(objectSize);
    8000390c:	00000613          	li	a2,0
    80003910:	00a00593          	li	a1,10
    80003914:	0304a503          	lw	a0,48(s1)
    80003918:	fffff097          	auipc	ra,0xfffff
    8000391c:	fb0080e7          	jalr	-80(ra) # 800028c8 <_Z8printIntiii>
    printString(", ");
    80003920:	00004517          	auipc	a0,0x4
    80003924:	9b850513          	addi	a0,a0,-1608 # 800072d8 <CONSOLE_STATUS+0x2c8>
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	e08080e7          	jalr	-504(ra) # 80002730 <_Z11printStringPKc>
    printInt(numSlabs);
    80003930:	00000613          	li	a2,0
    80003934:	00a00593          	li	a1,10
    80003938:	fdc42503          	lw	a0,-36(s0)
    8000393c:	fffff097          	auipc	ra,0xfffff
    80003940:	f8c080e7          	jalr	-116(ra) # 800028c8 <_Z8printIntiii>
    printString(", ");
    80003944:	00004517          	auipc	a0,0x4
    80003948:	99450513          	addi	a0,a0,-1644 # 800072d8 <CONSOLE_STATUS+0x2c8>
    8000394c:	fffff097          	auipc	ra,0xfffff
    80003950:	de4080e7          	jalr	-540(ra) # 80002730 <_Z11printStringPKc>
    printInt(slotSize);
    80003954:	00000613          	li	a2,0
    80003958:	00a00593          	li	a1,10
    8000395c:	0404a503          	lw	a0,64(s1)
    80003960:	fffff097          	auipc	ra,0xfffff
    80003964:	f68080e7          	jalr	-152(ra) # 800028c8 <_Z8printIntiii>
    printString(", ");
    80003968:	00004517          	auipc	a0,0x4
    8000396c:	97050513          	addi	a0,a0,-1680 # 800072d8 <CONSOLE_STATUS+0x2c8>
    80003970:	fffff097          	auipc	ra,0xfffff
    80003974:	dc0080e7          	jalr	-576(ra) # 80002730 <_Z11printStringPKc>
    printInt(optimalSlots);
    80003978:	00000613          	li	a2,0
    8000397c:	00a00593          	li	a1,10
    80003980:	0384a503          	lw	a0,56(s1)
    80003984:	fffff097          	auipc	ra,0xfffff
    80003988:	f44080e7          	jalr	-188(ra) # 800028c8 <_Z8printIntiii>
    printString(", ");
    8000398c:	00004517          	auipc	a0,0x4
    80003990:	94c50513          	addi	a0,a0,-1716 # 800072d8 <CONSOLE_STATUS+0x2c8>
    80003994:	fffff097          	auipc	ra,0xfffff
    80003998:	d9c080e7          	jalr	-612(ra) # 80002730 <_Z11printStringPKc>
    printInt(numSlots);
    8000399c:	00000613          	li	a2,0
    800039a0:	00a00593          	li	a1,10
    800039a4:	fd842503          	lw	a0,-40(s0)
    800039a8:	fffff097          	auipc	ra,0xfffff
    800039ac:	f20080e7          	jalr	-224(ra) # 800028c8 <_Z8printIntiii>
}
    800039b0:	02813083          	ld	ra,40(sp)
    800039b4:	02013403          	ld	s0,32(sp)
    800039b8:	01813483          	ld	s1,24(sp)
    800039bc:	03010113          	addi	sp,sp,48
    800039c0:	00008067          	ret

00000000800039c4 <_ZN5Cache11deallocSlabEPNS_4SlabE>:
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    800039c4:	fd010113          	addi	sp,sp,-48
    800039c8:	02113423          	sd	ra,40(sp)
    800039cc:	02813023          	sd	s0,32(sp)
    800039d0:	00913c23          	sd	s1,24(sp)
    800039d4:	01213823          	sd	s2,16(sp)
    800039d8:	01313423          	sd	s3,8(sp)
    800039dc:	03010413          	addi	s0,sp,48
    800039e0:	00050913          	mv	s2,a0
    800039e4:	00058993          	mv	s3,a1
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    for(size_t i = 0; i < this->optimalSlots; i++) {
    800039e8:	00000493          	li	s1,0
    800039ec:	03893783          	ld	a5,56(s2)
    800039f0:	02f4f263          	bgeu	s1,a5,80003a14 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x50>
        destructor((void*)((char*)startAddr + i*slotSize));
    800039f4:	05093783          	ld	a5,80(s2)
    800039f8:	04093503          	ld	a0,64(s2)
    800039fc:	02950533          	mul	a0,a0,s1
    80003a00:	02850513          	addi	a0,a0,40
    80003a04:	00a98533          	add	a0,s3,a0
    80003a08:	000780e7          	jalr	a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003a0c:	00148493          	addi	s1,s1,1
    80003a10:	fddff06f          	j	800039ec <_ZN5Cache11deallocSlabEPNS_4SlabE+0x28>
    }
    BuddyAllocator::buddyFree(slab, 1);
    80003a14:	00100593          	li	a1,1
    80003a18:	00098513          	mv	a0,s3
    80003a1c:	fffff097          	auipc	ra,0xfffff
    80003a20:	814080e7          	jalr	-2028(ra) # 80002230 <_ZN14BuddyAllocator9buddyFreeEPvm>
}
    80003a24:	02813083          	ld	ra,40(sp)
    80003a28:	02013403          	ld	s0,32(sp)
    80003a2c:	01813483          	ld	s1,24(sp)
    80003a30:	01013903          	ld	s2,16(sp)
    80003a34:	00813983          	ld	s3,8(sp)
    80003a38:	03010113          	addi	sp,sp,48
    80003a3c:	00008067          	ret

0000000080003a40 <_ZN5Cache16deallocFreeSlabsEv>:
int Cache::deallocFreeSlabs() {
    80003a40:	fd010113          	addi	sp,sp,-48
    80003a44:	02113423          	sd	ra,40(sp)
    80003a48:	02813023          	sd	s0,32(sp)
    80003a4c:	00913c23          	sd	s1,24(sp)
    80003a50:	01213823          	sd	s2,16(sp)
    80003a54:	01313423          	sd	s3,8(sp)
    80003a58:	03010413          	addi	s0,sp,48
    80003a5c:	00050993          	mv	s3,a0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003a60:	00853583          	ld	a1,8(a0)
    int numSlabs = 0;
    80003a64:	00000493          	li	s1,0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003a68:	02058063          	beqz	a1,80003a88 <_ZN5Cache16deallocFreeSlabsEv+0x48>
        numSlabs++;
    80003a6c:	0014849b          	addiw	s1,s1,1
        curr = curr->next;
    80003a70:	0085b903          	ld	s2,8(a1)
        deallocSlab(old);
    80003a74:	00098513          	mv	a0,s3
    80003a78:	00000097          	auipc	ra,0x0
    80003a7c:	f4c080e7          	jalr	-180(ra) # 800039c4 <_ZN5Cache11deallocSlabEPNS_4SlabE>
        curr = curr->next;
    80003a80:	00090593          	mv	a1,s2
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003a84:	fe5ff06f          	j	80003a68 <_ZN5Cache16deallocFreeSlabsEv+0x28>
    slabList[EMPTY] = nullptr;
    80003a88:	0009b423          	sd	zero,8(s3)
}
    80003a8c:	00048513          	mv	a0,s1
    80003a90:	02813083          	ld	ra,40(sp)
    80003a94:	02013403          	ld	s0,32(sp)
    80003a98:	01813483          	ld	s1,24(sp)
    80003a9c:	01013903          	ld	s2,16(sp)
    80003aa0:	00813983          	ld	s3,8(sp)
    80003aa4:	03010113          	addi	sp,sp,48
    80003aa8:	00008067          	ret

0000000080003aac <_ZN5Cache12deallocCacheEv>:

void Cache::deallocCache() {
    80003aac:	fd010113          	addi	sp,sp,-48
    80003ab0:	02113423          	sd	ra,40(sp)
    80003ab4:	02813023          	sd	s0,32(sp)
    80003ab8:	00913c23          	sd	s1,24(sp)
    80003abc:	01213823          	sd	s2,16(sp)
    80003ac0:	01313423          	sd	s3,8(sp)
    80003ac4:	03010413          	addi	s0,sp,48
    80003ac8:	00050913          	mv	s2,a0
    for(int i = 0; i < 3; i++) {
    80003acc:	00000993          	li	s3,0
    80003ad0:	0080006f          	j	80003ad8 <_ZN5Cache12deallocCacheEv+0x2c>
    80003ad4:	0019899b          	addiw	s3,s3,1
    80003ad8:	00200793          	li	a5,2
    80003adc:	0337c663          	blt	a5,s3,80003b08 <_ZN5Cache12deallocCacheEv+0x5c>
        Slab* curr = slabList[i];
    80003ae0:	00399793          	slli	a5,s3,0x3
    80003ae4:	00f907b3          	add	a5,s2,a5
    80003ae8:	0087b583          	ld	a1,8(a5)
        while(curr) {
    80003aec:	fe0584e3          	beqz	a1,80003ad4 <_ZN5Cache12deallocCacheEv+0x28>
            Slab* old = curr;
            curr = curr->next;
    80003af0:	0085b483          	ld	s1,8(a1)
            deallocSlab(old);
    80003af4:	00090513          	mv	a0,s2
    80003af8:	00000097          	auipc	ra,0x0
    80003afc:	ecc080e7          	jalr	-308(ra) # 800039c4 <_ZN5Cache11deallocSlabEPNS_4SlabE>
            curr = curr->next;
    80003b00:	00048593          	mv	a1,s1
        while(curr) {
    80003b04:	fe9ff06f          	j	80003aec <_ZN5Cache12deallocCacheEv+0x40>
        }
    }
}
    80003b08:	02813083          	ld	ra,40(sp)
    80003b0c:	02013403          	ld	s0,32(sp)
    80003b10:	01813483          	ld	s1,24(sp)
    80003b14:	01013903          	ld	s2,16(sp)
    80003b18:	00813983          	ld	s3,8(sp)
    80003b1c:	03010113          	addi	sp,sp,48
    80003b20:	00008067          	ret

0000000080003b24 <_ZN5Cache4Slab17calculateNewStateEv>:
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    80003b24:	ff010113          	addi	sp,sp,-16
    80003b28:	00813423          	sd	s0,8(sp)
    80003b2c:	01010413          	addi	s0,sp,16
    if(allocatedSlots == 0) {
    80003b30:	00053783          	ld	a5,0(a0)
    80003b34:	02078063          	beqz	a5,80003b54 <_ZN5Cache4Slab17calculateNewStateEv+0x30>
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
    80003b38:	01853703          	ld	a4,24(a0)
    80003b3c:	03873703          	ld	a4,56(a4)
    80003b40:	00e78e63          	beq	a5,a4,80003b5c <_ZN5Cache4Slab17calculateNewStateEv+0x38>
        return FULL;
    }
    return PARTIAL;
    80003b44:	00100513          	li	a0,1
}
    80003b48:	00813403          	ld	s0,8(sp)
    80003b4c:	01010113          	addi	sp,sp,16
    80003b50:	00008067          	ret
        return EMPTY;
    80003b54:	00000513          	li	a0,0
    80003b58:	ff1ff06f          	j	80003b48 <_ZN5Cache4Slab17calculateNewStateEv+0x24>
        return FULL;
    80003b5c:	00200513          	li	a0,2
    80003b60:	fe9ff06f          	j	80003b48 <_ZN5Cache4Slab17calculateNewStateEv+0x24>

0000000080003b64 <_ZN5Cache8freeSlotEPNS_4SlotE>:
void Cache::freeSlot(Slot* slot) {
    80003b64:	fd010113          	addi	sp,sp,-48
    80003b68:	02113423          	sd	ra,40(sp)
    80003b6c:	02813023          	sd	s0,32(sp)
    80003b70:	00913c23          	sd	s1,24(sp)
    80003b74:	01213823          	sd	s2,16(sp)
    80003b78:	01313423          	sd	s3,8(sp)
    80003b7c:	03010413          	addi	s0,sp,48
    if(slot->parentSlab->parentCache != this) {
    80003b80:	0105b483          	ld	s1,16(a1)
    80003b84:	0184b903          	ld	s2,24(s1)
    80003b88:	02a90463          	beq	s2,a0,80003bb0 <_ZN5Cache8freeSlotEPNS_4SlotE+0x4c>
        errortype = FREESLOTERROR;
    80003b8c:	00100793          	li	a5,1
    80003b90:	00f52023          	sw	a5,0(a0)
}
    80003b94:	02813083          	ld	ra,40(sp)
    80003b98:	02013403          	ld	s0,32(sp)
    80003b9c:	01813483          	ld	s1,24(sp)
    80003ba0:	01013903          	ld	s2,16(sp)
    80003ba4:	00813983          	ld	s3,8(sp)
    80003ba8:	03010113          	addi	sp,sp,48
    80003bac:	00008067          	ret
    slot->allocated = false;
    80003bb0:	00058023          	sb	zero,0(a1)
    parentSlab->allocatedSlots--;
    80003bb4:	0004b783          	ld	a5,0(s1)
    80003bb8:	fff78793          	addi	a5,a5,-1
    80003bbc:	00f4b023          	sd	a5,0(s1)
    SlabState newState = parentSlab->calculateNewState();
    80003bc0:	00048513          	mv	a0,s1
    80003bc4:	00000097          	auipc	ra,0x0
    80003bc8:	f60080e7          	jalr	-160(ra) # 80003b24 <_ZN5Cache4Slab17calculateNewStateEv>
    80003bcc:	00050993          	mv	s3,a0
    if(parentSlab->state != newState) {
    80003bd0:	0104a603          	lw	a2,16(s1)
    80003bd4:	fca600e3          	beq	a2,a0,80003b94 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003bd8:	00300793          	li	a5,3
    80003bdc:	00f61e63          	bne	a2,a5,80003bf8 <_ZN5Cache8freeSlotEPNS_4SlotE+0x94>
        parentCache->slabListPut(parentSlab, newState);
    80003be0:	0009861b          	sext.w	a2,s3
    80003be4:	00048593          	mv	a1,s1
    80003be8:	00090513          	mv	a0,s2
    80003bec:	00000097          	auipc	ra,0x0
    80003bf0:	b60080e7          	jalr	-1184(ra) # 8000374c <_ZN5Cache11slabListPutEPNS_4SlabEi>
    80003bf4:	fa1ff06f          	j	80003b94 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003bf8:	00048593          	mv	a1,s1
    80003bfc:	00090513          	mv	a0,s2
    80003c00:	00000097          	auipc	ra,0x0
    80003c04:	b98080e7          	jalr	-1128(ra) # 80003798 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80003c08:	fd9ff06f          	j	80003be0 <_ZN5Cache8freeSlotEPNS_4SlotE+0x7c>

0000000080003c0c <_ZN5Cache4Slab11getFreeSlotEv>:
Cache::Slot *Cache::Slab::getFreeSlot() {
    80003c0c:	fd010113          	addi	sp,sp,-48
    80003c10:	02113423          	sd	ra,40(sp)
    80003c14:	02813023          	sd	s0,32(sp)
    80003c18:	00913c23          	sd	s1,24(sp)
    80003c1c:	01213823          	sd	s2,16(sp)
    80003c20:	01313423          	sd	s3,8(sp)
    80003c24:	03010413          	addi	s0,sp,48
    if(!slotHead || state == FULL) return nullptr;
    80003c28:	02053483          	ld	s1,32(a0)
    80003c2c:	06048a63          	beqz	s1,80003ca0 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
    80003c30:	00050913          	mv	s2,a0
    80003c34:	01052703          	lw	a4,16(a0)
    80003c38:	00200793          	li	a5,2
    80003c3c:	08f70c63          	beq	a4,a5,80003cd4 <_ZN5Cache4Slab11getFreeSlotEv+0xc8>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003c40:	06048063          	beqz	s1,80003ca0 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
        if(curr->allocated == false) {
    80003c44:	0004c783          	lbu	a5,0(s1)
    80003c48:	00078663          	beqz	a5,80003c54 <_ZN5Cache4Slab11getFreeSlotEv+0x48>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003c4c:	0084b483          	ld	s1,8(s1)
    80003c50:	ff1ff06f          	j	80003c40 <_ZN5Cache4Slab11getFreeSlotEv+0x34>
            this->allocatedSlots++;
    80003c54:	00093783          	ld	a5,0(s2)
    80003c58:	00178793          	addi	a5,a5,1
    80003c5c:	00f93023          	sd	a5,0(s2)
            curr->allocated = true;
    80003c60:	00100793          	li	a5,1
    80003c64:	00f48023          	sb	a5,0(s1)
            curr->parentSlab = this;
    80003c68:	0124b823          	sd	s2,16(s1)
            SlabState newState = calculateNewState();
    80003c6c:	00090513          	mv	a0,s2
    80003c70:	00000097          	auipc	ra,0x0
    80003c74:	eb4080e7          	jalr	-332(ra) # 80003b24 <_ZN5Cache4Slab17calculateNewStateEv>
    80003c78:	00050993          	mv	s3,a0
            if(this->state != newState) {
    80003c7c:	01092603          	lw	a2,16(s2)
    80003c80:	02a60063          	beq	a2,a0,80003ca0 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80003c84:	00300793          	li	a5,3
    80003c88:	02f61c63          	bne	a2,a5,80003cc0 <_ZN5Cache4Slab11getFreeSlotEv+0xb4>
                parentCache->slabListPut(this, newState);
    80003c8c:	0009861b          	sext.w	a2,s3
    80003c90:	00090593          	mv	a1,s2
    80003c94:	01893503          	ld	a0,24(s2)
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	ab4080e7          	jalr	-1356(ra) # 8000374c <_ZN5Cache11slabListPutEPNS_4SlabEi>
}
    80003ca0:	00048513          	mv	a0,s1
    80003ca4:	02813083          	ld	ra,40(sp)
    80003ca8:	02013403          	ld	s0,32(sp)
    80003cac:	01813483          	ld	s1,24(sp)
    80003cb0:	01013903          	ld	s2,16(sp)
    80003cb4:	00813983          	ld	s3,8(sp)
    80003cb8:	03010113          	addi	sp,sp,48
    80003cbc:	00008067          	ret
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80003cc0:	00090593          	mv	a1,s2
    80003cc4:	01893503          	ld	a0,24(s2)
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	ad0080e7          	jalr	-1328(ra) # 80003798 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80003cd0:	fbdff06f          	j	80003c8c <_ZN5Cache4Slab11getFreeSlotEv+0x80>
    if(!slotHead || state == FULL) return nullptr;
    80003cd4:	00000493          	li	s1,0
    80003cd8:	fc9ff06f          	j	80003ca0 <_ZN5Cache4Slab11getFreeSlotEv+0x94>

0000000080003cdc <_ZN5Cache12allocateSlotEv>:
void *Cache::allocateSlot() {
    80003cdc:	ff010113          	addi	sp,sp,-16
    80003ce0:	00113423          	sd	ra,8(sp)
    80003ce4:	00813023          	sd	s0,0(sp)
    80003ce8:	01010413          	addi	s0,sp,16
    80003cec:	00050793          	mv	a5,a0
    if(slabList[PARTIAL]) {
    80003cf0:	01053503          	ld	a0,16(a0)
    80003cf4:	02050263          	beqz	a0,80003d18 <_ZN5Cache12allocateSlotEv+0x3c>
        slabList[PARTIAL] = slabList[PARTIAL]->next;
    80003cf8:	00853703          	ld	a4,8(a0)
    80003cfc:	00e7b823          	sd	a4,16(a5)
        return slab->getFreeSlot();
    80003d00:	00000097          	auipc	ra,0x0
    80003d04:	f0c080e7          	jalr	-244(ra) # 80003c0c <_ZN5Cache4Slab11getFreeSlotEv>
}
    80003d08:	00813083          	ld	ra,8(sp)
    80003d0c:	00013403          	ld	s0,0(sp)
    80003d10:	01010113          	addi	sp,sp,16
    80003d14:	00008067          	ret
    else if(slabList[EMPTY]) {
    80003d18:	0087b503          	ld	a0,8(a5)
    80003d1c:	00050c63          	beqz	a0,80003d34 <_ZN5Cache12allocateSlotEv+0x58>
        slabList[EMPTY] = slabList[EMPTY]->next;
    80003d20:	00853703          	ld	a4,8(a0)
    80003d24:	00e7b423          	sd	a4,8(a5)
        Slot* slot = slab->getFreeSlot();
    80003d28:	00000097          	auipc	ra,0x0
    80003d2c:	ee4080e7          	jalr	-284(ra) # 80003c0c <_ZN5Cache4Slab11getFreeSlotEv>
        return slot;
    80003d30:	fd9ff06f          	j	80003d08 <_ZN5Cache12allocateSlotEv+0x2c>
        Slab* slab = allocateSlab();
    80003d34:	00078513          	mv	a0,a5
    80003d38:	00000097          	auipc	ra,0x0
    80003d3c:	944080e7          	jalr	-1724(ra) # 8000367c <_ZN5Cache12allocateSlabEv>
        return slab->getFreeSlot();
    80003d40:	00000097          	auipc	ra,0x0
    80003d44:	ecc080e7          	jalr	-308(ra) # 80003c0c <_ZN5Cache4Slab11getFreeSlotEv>
    80003d48:	fc1ff06f          	j	80003d08 <_ZN5Cache12allocateSlotEv+0x2c>

0000000080003d4c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;
void *MemoryAllocator::mem_alloc(size_t size) {
    80003d4c:	ff010113          	addi	sp,sp,-16
    80003d50:	00813423          	sd	s0,8(sp)
    80003d54:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80003d58:	00005797          	auipc	a5,0x5
    80003d5c:	3207b783          	ld	a5,800(a5) # 80009078 <_ZN15MemoryAllocator4headE>
    80003d60:	02078c63          	beqz	a5,80003d98 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
    static void* userHeapStartAddr() {
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    }

    static void* userHeapEndAddr() {
        return (void*)HEAP_END_ADDR;
    80003d64:	00005717          	auipc	a4,0x5
    80003d68:	1a473703          	ld	a4,420(a4) # 80008f08 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003d6c:	00073703          	ld	a4,0(a4)
        head = (FreeSegment*)userHeapStartAddr();
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    80003d70:	14e78263          	beq	a5,a4,80003eb4 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80003d74:	00850713          	addi	a4,a0,8
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80003d78:	00675813          	srli	a6,a4,0x6
    80003d7c:	03f77793          	andi	a5,a4,63
    80003d80:	00f037b3          	snez	a5,a5
    80003d84:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80003d88:	00005517          	auipc	a0,0x5
    80003d8c:	2f053503          	ld	a0,752(a0) # 80009078 <_ZN15MemoryAllocator4headE>
    80003d90:	00000613          	li	a2,0
    80003d94:	0b40006f          	j	80003e48 <_ZN15MemoryAllocator9mem_allocEm+0xfc>
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    80003d98:	00005797          	auipc	a5,0x5
    80003d9c:	1287b783          	ld	a5,296(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003da0:	0007b703          	ld	a4,0(a5)
    80003da4:	010007b7          	lui	a5,0x1000
    80003da8:	00f707b3          	add	a5,a4,a5
        head = (FreeSegment*)userHeapStartAddr();
    80003dac:	00005697          	auipc	a3,0x5
    80003db0:	2cf6b623          	sd	a5,716(a3) # 80009078 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
    80003db4:	020006b7          	lui	a3,0x2000
    80003db8:	00d70733          	add	a4,a4,a3
    80003dbc:	00e7b023          	sd	a4,0(a5) # 1000000 <_entry-0x7f000000>
        return (void*)HEAP_END_ADDR;
    80003dc0:	00005717          	auipc	a4,0x5
    80003dc4:	14873703          	ld	a4,328(a4) # 80008f08 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003dc8:	00073703          	ld	a4,0(a4)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    80003dcc:	40f70733          	sub	a4,a4,a5
    80003dd0:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80003dd4:	0007b823          	sd	zero,16(a5)
    80003dd8:	f9dff06f          	j	80003d74 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80003ddc:	00060e63          	beqz	a2,80003df8 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            if(!prev->next) return;
    80003de0:	01063703          	ld	a4,16(a2)
    80003de4:	04070a63          	beqz	a4,80003e38 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    80003de8:	01073703          	ld	a4,16(a4)
    80003dec:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80003df0:	00078813          	mv	a6,a5
    80003df4:	0ac0006f          	j	80003ea0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80003df8:	01053703          	ld	a4,16(a0)
    80003dfc:	00070a63          	beqz	a4,80003e10 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
                        head = (FreeSegment*)userHeapEndAddr();
                    }
                    else {
                        head = curr->next;
    80003e00:	00005697          	auipc	a3,0x5
    80003e04:	26e6bc23          	sd	a4,632(a3) # 80009078 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80003e08:	00078813          	mv	a6,a5
    80003e0c:	0940006f          	j	80003ea0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
        return (void*)HEAP_END_ADDR;
    80003e10:	00005717          	auipc	a4,0x5
    80003e14:	0f873703          	ld	a4,248(a4) # 80008f08 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003e18:	00073703          	ld	a4,0(a4)
                        head = (FreeSegment*)userHeapEndAddr();
    80003e1c:	00005697          	auipc	a3,0x5
    80003e20:	24e6be23          	sd	a4,604(a3) # 80009078 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80003e24:	00078813          	mv	a6,a5
    80003e28:	0780006f          	j	80003ea0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80003e2c:	00005797          	auipc	a5,0x5
    80003e30:	24e7b623          	sd	a4,588(a5) # 80009078 <_ZN15MemoryAllocator4headE>
    80003e34:	06c0006f          	j	80003ea0 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80003e38:	00078813          	mv	a6,a5
    80003e3c:	0640006f          	j	80003ea0 <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80003e40:	00050613          	mv	a2,a0
        curr = curr->next;
    80003e44:	01053503          	ld	a0,16(a0)
    while(curr) {
    80003e48:	06050063          	beqz	a0,80003ea8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80003e4c:	00853783          	ld	a5,8(a0)
    80003e50:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80003e54:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80003e58:	fee7e4e3          	bltu	a5,a4,80003e40 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
    80003e5c:	ff06e2e3          	bltu	a3,a6,80003e40 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80003e60:	f7068ee3          	beq	a3,a6,80003ddc <_ZN15MemoryAllocator9mem_allocEm+0x90>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80003e64:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80003e68:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80003e6c:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80003e70:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80003e74:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80003e78:	01053783          	ld	a5,16(a0)
    80003e7c:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80003e80:	fa0606e3          	beqz	a2,80003e2c <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            if(!prev->next) return;
    80003e84:	01063783          	ld	a5,16(a2)
    80003e88:	00078663          	beqz	a5,80003e94 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    80003e8c:	0107b783          	ld	a5,16(a5)
    80003e90:	00f63823          	sd	a5,16(a2)
            curr->next = prev->next;
    80003e94:	01063783          	ld	a5,16(a2)
    80003e98:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80003e9c:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80003ea0:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80003ea4:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80003ea8:	00813403          	ld	s0,8(sp)
    80003eac:	01010113          	addi	sp,sp,16
    80003eb0:	00008067          	ret
        return nullptr;
    80003eb4:	00000513          	li	a0,0
    80003eb8:	ff1ff06f          	j	80003ea8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>

0000000080003ebc <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80003ebc:	ff010113          	addi	sp,sp,-16
    80003ec0:	00813423          	sd	s0,8(sp)
    80003ec4:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80003ec8:	16050463          	beqz	a0,80004030 <_ZN15MemoryAllocator8mem_freeEPv+0x174>
    80003ecc:	ff850713          	addi	a4,a0,-8
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    80003ed0:	00005797          	auipc	a5,0x5
    80003ed4:	ff07b783          	ld	a5,-16(a5) # 80008ec0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003ed8:	0007b783          	ld	a5,0(a5)
    80003edc:	010006b7          	lui	a3,0x1000
    80003ee0:	00d787b3          	add	a5,a5,a3
    80003ee4:	14f76a63          	bltu	a4,a5,80004038 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80003ee8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80003eec:	fff58693          	addi	a3,a1,-1
    80003ef0:	00d706b3          	add	a3,a4,a3
        return (void*)HEAP_END_ADDR;
    80003ef4:	00005617          	auipc	a2,0x5
    80003ef8:	01463603          	ld	a2,20(a2) # 80008f08 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003efc:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80003f00:	14c6f063          	bgeu	a3,a2,80004040 <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80003f04:	14070263          	beqz	a4,80004048 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
        return (size_t)address - (size_t)userHeapStartAddr();
    80003f08:	40f707b3          	sub	a5,a4,a5
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80003f0c:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80003f10:	14079063          	bnez	a5,80004050 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
    80003f14:	03f00793          	li	a5,63
    80003f18:	14b7f063          	bgeu	a5,a1,80004058 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
        return BAD_POINTER;
    }

    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    80003f1c:	00005797          	auipc	a5,0x5
    80003f20:	15c7b783          	ld	a5,348(a5) # 80009078 <_ZN15MemoryAllocator4headE>
    80003f24:	02c78063          	beq	a5,a2,80003f44 <_ZN15MemoryAllocator8mem_freeEPv+0x88>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80003f28:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80003f2c:	02078a63          	beqz	a5,80003f60 <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
    80003f30:	0007b683          	ld	a3,0(a5)
    80003f34:	02e6f663          	bgeu	a3,a4,80003f60 <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
        prev = curr;
    80003f38:	00078613          	mv	a2,a5
        curr = curr->next;
    80003f3c:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80003f40:	fedff06f          	j	80003f2c <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        newFreeSegment->size = size;
    80003f44:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80003f48:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80003f4c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80003f50:	00005797          	auipc	a5,0x5
    80003f54:	12e7b423          	sd	a4,296(a5) # 80009078 <_ZN15MemoryAllocator4headE>
        return 0;
    80003f58:	00000513          	li	a0,0
    80003f5c:	0480006f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    }

    if(prev == nullptr) {
    80003f60:	04060863          	beqz	a2,80003fb0 <_ZN15MemoryAllocator8mem_freeEPv+0xf4>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003f64:	00063683          	ld	a3,0(a2)
    80003f68:	00863803          	ld	a6,8(a2)
    80003f6c:	010686b3          	add	a3,a3,a6
    80003f70:	08e68a63          	beq	a3,a4,80004004 <_ZN15MemoryAllocator8mem_freeEPv+0x148>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003f74:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003f78:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80003f7c:	01063683          	ld	a3,16(a2)
    80003f80:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003f84:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80003f88:	0e078063          	beqz	a5,80004068 <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    80003f8c:	0007b583          	ld	a1,0(a5)
    80003f90:	00073683          	ld	a3,0(a4)
    80003f94:	00873603          	ld	a2,8(a4)
    80003f98:	00c686b3          	add	a3,a3,a2
    80003f9c:	06d58c63          	beq	a1,a3,80004014 <_ZN15MemoryAllocator8mem_freeEPv+0x158>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80003fa0:	00000513          	li	a0,0
}
    80003fa4:	00813403          	ld	s0,8(sp)
    80003fa8:	01010113          	addi	sp,sp,16
    80003fac:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80003fb0:	0a078863          	beqz	a5,80004060 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
            newFreeSegment->size = size;
    80003fb4:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003fb8:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80003fbc:	00005797          	auipc	a5,0x5
    80003fc0:	0bc7b783          	ld	a5,188(a5) # 80009078 <_ZN15MemoryAllocator4headE>
    80003fc4:	0007b603          	ld	a2,0(a5)
    80003fc8:	00b706b3          	add	a3,a4,a1
    80003fcc:	00d60c63          	beq	a2,a3,80003fe4 <_ZN15MemoryAllocator8mem_freeEPv+0x128>
                newFreeSegment->next = head;
    80003fd0:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80003fd4:	00005797          	auipc	a5,0x5
    80003fd8:	0ae7b223          	sd	a4,164(a5) # 80009078 <_ZN15MemoryAllocator4headE>
            return 0;
    80003fdc:	00000513          	li	a0,0
    80003fe0:	fc5ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
                newFreeSegment->size += head->size;
    80003fe4:	0087b783          	ld	a5,8(a5)
    80003fe8:	00b785b3          	add	a1,a5,a1
    80003fec:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80003ff0:	00005797          	auipc	a5,0x5
    80003ff4:	0887b783          	ld	a5,136(a5) # 80009078 <_ZN15MemoryAllocator4headE>
    80003ff8:	0107b783          	ld	a5,16(a5)
    80003ffc:	00f53423          	sd	a5,8(a0)
    80004000:	fd5ff06f          	j	80003fd4 <_ZN15MemoryAllocator8mem_freeEPv+0x118>
            prev->size += size;
    80004004:	00b805b3          	add	a1,a6,a1
    80004008:	00b63423          	sd	a1,8(a2)
    8000400c:	00060713          	mv	a4,a2
    80004010:	f79ff06f          	j	80003f88 <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
            prev->size += curr->size;
    80004014:	0087b683          	ld	a3,8(a5)
    80004018:	00d60633          	add	a2,a2,a3
    8000401c:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80004020:	0107b783          	ld	a5,16(a5)
    80004024:	00f73823          	sd	a5,16(a4)
    return 0;
    80004028:	00000513          	li	a0,0
    8000402c:	f79ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004030:	fff00513          	li	a0,-1
    80004034:	f71ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004038:	fff00513          	li	a0,-1
    8000403c:	f69ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
        return BAD_POINTER;
    80004040:	fff00513          	li	a0,-1
    80004044:	f61ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004048:	fff00513          	li	a0,-1
    8000404c:	f59ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004050:	fff00513          	li	a0,-1
    80004054:	f51ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004058:	fff00513          	li	a0,-1
    8000405c:	f49ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
            return BAD_POINTER;
    80004060:	fff00513          	li	a0,-1
    80004064:	f41ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    return 0;
    80004068:	00000513          	li	a0,0
    8000406c:	f39ff06f          	j	80003fa4 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>

0000000080004070 <_Z9kmem_initPvi>:
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    80004070:	ff010113          	addi	sp,sp,-16
    80004074:	00113423          	sd	ra,8(sp)
    80004078:	00813023          	sd	s0,0(sp)
    8000407c:	01010413          	addi	s0,sp,16
    SlabAllocator::initAllocator(space, block_num);
    80004080:	ffffe097          	auipc	ra,0xffffe
    80004084:	4d0080e7          	jalr	1232(ra) # 80002550 <_ZN13SlabAllocator13initAllocatorEPvi>
}
    80004088:	00813083          	ld	ra,8(sp)
    8000408c:	00013403          	ld	s0,0(sp)
    80004090:	01010113          	addi	sp,sp,16
    80004094:	00008067          	ret

0000000080004098 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004098:	ff010113          	addi	sp,sp,-16
    8000409c:	00113423          	sd	ra,8(sp)
    800040a0:	00813023          	sd	s0,0(sp)
    800040a4:	01010413          	addi	s0,sp,16
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
    800040a8:	ffffe097          	auipc	ra,0xffffe
    800040ac:	4d0080e7          	jalr	1232(ra) # 80002578 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    800040b0:	00813083          	ld	ra,8(sp)
    800040b4:	00013403          	ld	s0,0(sp)
    800040b8:	01010113          	addi	sp,sp,16
    800040bc:	00008067          	ret

00000000800040c0 <_Z17kmem_cache_shrinkP12kmem_cache_s>:

int kmem_cache_shrink(kmem_cache_t *cachep) {
    800040c0:	ff010113          	addi	sp,sp,-16
    800040c4:	00113423          	sd	ra,8(sp)
    800040c8:	00813023          	sd	s0,0(sp)
    800040cc:	01010413          	addi	s0,sp,16
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
    800040d0:	ffffe097          	auipc	ra,0xffffe
    800040d4:	610080e7          	jalr	1552(ra) # 800026e0 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>
}
    800040d8:	00813083          	ld	ra,8(sp)
    800040dc:	00013403          	ld	s0,0(sp)
    800040e0:	01010113          	addi	sp,sp,16
    800040e4:	00008067          	ret

00000000800040e8 <_Z16kmem_cache_allocP12kmem_cache_s>:
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    800040e8:	ff010113          	addi	sp,sp,-16
    800040ec:	00113423          	sd	ra,8(sp)
    800040f0:	00813023          	sd	s0,0(sp)
    800040f4:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocSlot((Cache*)cachep);
    800040f8:	ffffe097          	auipc	ra,0xffffe
    800040fc:	540080e7          	jalr	1344(ra) # 80002638 <_ZN13SlabAllocator9allocSlotEP5Cache>
}
    80004100:	00813083          	ld	ra,8(sp)
    80004104:	00013403          	ld	s0,0(sp)
    80004108:	01010113          	addi	sp,sp,16
    8000410c:	00008067          	ret

0000000080004110 <_Z15kmem_cache_freeP12kmem_cache_sPv>:
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    80004110:	ff010113          	addi	sp,sp,-16
    80004114:	00113423          	sd	ra,8(sp)
    80004118:	00813023          	sd	s0,0(sp)
    8000411c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeSlot((Cache*)cachep, objp);
    80004120:	ffffe097          	auipc	ra,0xffffe
    80004124:	544080e7          	jalr	1348(ra) # 80002664 <_ZN13SlabAllocator8freeSlotEP5CachePv>
}
    80004128:	00813083          	ld	ra,8(sp)
    8000412c:	00013403          	ld	s0,0(sp)
    80004130:	01010113          	addi	sp,sp,16
    80004134:	00008067          	ret

0000000080004138 <_Z18kmem_cache_destroyP12kmem_cache_s>:

void *kmalloc(size_t size); // Alloacate one small memory buffer
void kfree(const void *objp); // Deallocate one small memory buffer
void kmem_cache_destroy(kmem_cache_t *cachep) {
    80004138:	ff010113          	addi	sp,sp,-16
    8000413c:	00113423          	sd	ra,8(sp)
    80004140:	00813023          	sd	s0,0(sp)
    80004144:	01010413          	addi	s0,sp,16
    SlabAllocator::deallocCache((Cache*)cachep);
    80004148:	ffffe097          	auipc	ra,0xffffe
    8000414c:	5c0080e7          	jalr	1472(ra) # 80002708 <_ZN13SlabAllocator12deallocCacheEP5Cache>
}
    80004150:	00813083          	ld	ra,8(sp)
    80004154:	00013403          	ld	s0,0(sp)
    80004158:	01010113          	addi	sp,sp,16
    8000415c:	00008067          	ret

0000000080004160 <_Z15kmem_cache_infoP12kmem_cache_s>:
void kmem_cache_info(kmem_cache_t *cachep) {
    80004160:	ff010113          	addi	sp,sp,-16
    80004164:	00113423          	sd	ra,8(sp)
    80004168:	00813023          	sd	s0,0(sp)
    8000416c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCacheInfo((Cache*)cachep);
    80004170:	ffffe097          	auipc	ra,0xffffe
    80004174:	548080e7          	jalr	1352(ra) # 800026b8 <_ZN13SlabAllocator14printCacheInfoEP5Cache>
}
    80004178:	00813083          	ld	ra,8(sp)
    8000417c:	00013403          	ld	s0,0(sp)
    80004180:	01010113          	addi	sp,sp,16
    80004184:	00008067          	ret

0000000080004188 <_Z16kmem_cache_errorP12kmem_cache_s>:
int kmem_cache_error(kmem_cache_t *cachep) {
    80004188:	ff010113          	addi	sp,sp,-16
    8000418c:	00113423          	sd	ra,8(sp)
    80004190:	00813023          	sd	s0,0(sp)
    80004194:	01010413          	addi	s0,sp,16
    return SlabAllocator::printErrorMessage((Cache*)cachep);
    80004198:	ffffe097          	auipc	ra,0xffffe
    8000419c:	4f8080e7          	jalr	1272(ra) # 80002690 <_ZN13SlabAllocator17printErrorMessageEP5Cache>
    800041a0:	00813083          	ld	ra,8(sp)
    800041a4:	00013403          	ld	s0,0(sp)
    800041a8:	01010113          	addi	sp,sp,16
    800041ac:	00008067          	ret

00000000800041b0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800041b0:	fd010113          	addi	sp,sp,-48
    800041b4:	02113423          	sd	ra,40(sp)
    800041b8:	02813023          	sd	s0,32(sp)
    800041bc:	00913c23          	sd	s1,24(sp)
    800041c0:	01213823          	sd	s2,16(sp)
    800041c4:	01313423          	sd	s3,8(sp)
    800041c8:	03010413          	addi	s0,sp,48
    800041cc:	00050493          	mv	s1,a0
    800041d0:	00058913          	mv	s2,a1
    800041d4:	0015879b          	addiw	a5,a1,1
    800041d8:	0007851b          	sext.w	a0,a5
    800041dc:	00f4a023          	sw	a5,0(s1)
    800041e0:	0004a823          	sw	zero,16(s1)
    800041e4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800041e8:	00251513          	slli	a0,a0,0x2
    800041ec:	ffffd097          	auipc	ra,0xffffd
    800041f0:	fa8080e7          	jalr	-88(ra) # 80001194 <_Z9mem_allocm>
    800041f4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800041f8:	01000513          	li	a0,16
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	f90080e7          	jalr	-112(ra) # 8000318c <_ZN9SemaphorenwEm>
    80004204:	00050993          	mv	s3,a0
    80004208:	00000593          	li	a1,0
    8000420c:	fffff097          	auipc	ra,0xfffff
    80004210:	e60080e7          	jalr	-416(ra) # 8000306c <_ZN9SemaphoreC1Ej>
    80004214:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004218:	01000513          	li	a0,16
    8000421c:	fffff097          	auipc	ra,0xfffff
    80004220:	f70080e7          	jalr	-144(ra) # 8000318c <_ZN9SemaphorenwEm>
    80004224:	00050993          	mv	s3,a0
    80004228:	00090593          	mv	a1,s2
    8000422c:	fffff097          	auipc	ra,0xfffff
    80004230:	e40080e7          	jalr	-448(ra) # 8000306c <_ZN9SemaphoreC1Ej>
    80004234:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004238:	01000513          	li	a0,16
    8000423c:	fffff097          	auipc	ra,0xfffff
    80004240:	f50080e7          	jalr	-176(ra) # 8000318c <_ZN9SemaphorenwEm>
    80004244:	00050913          	mv	s2,a0
    80004248:	00100593          	li	a1,1
    8000424c:	fffff097          	auipc	ra,0xfffff
    80004250:	e20080e7          	jalr	-480(ra) # 8000306c <_ZN9SemaphoreC1Ej>
    80004254:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004258:	01000513          	li	a0,16
    8000425c:	fffff097          	auipc	ra,0xfffff
    80004260:	f30080e7          	jalr	-208(ra) # 8000318c <_ZN9SemaphorenwEm>
    80004264:	00050913          	mv	s2,a0
    80004268:	00100593          	li	a1,1
    8000426c:	fffff097          	auipc	ra,0xfffff
    80004270:	e00080e7          	jalr	-512(ra) # 8000306c <_ZN9SemaphoreC1Ej>
    80004274:	0324b823          	sd	s2,48(s1)
}
    80004278:	02813083          	ld	ra,40(sp)
    8000427c:	02013403          	ld	s0,32(sp)
    80004280:	01813483          	ld	s1,24(sp)
    80004284:	01013903          	ld	s2,16(sp)
    80004288:	00813983          	ld	s3,8(sp)
    8000428c:	03010113          	addi	sp,sp,48
    80004290:	00008067          	ret
    80004294:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004298:	00098513          	mv	a0,s3
    8000429c:	fffff097          	auipc	ra,0xfffff
    800042a0:	e88080e7          	jalr	-376(ra) # 80003124 <_ZN9SemaphoredlEPv>
    800042a4:	00048513          	mv	a0,s1
    800042a8:	00006097          	auipc	ra,0x6
    800042ac:	ea0080e7          	jalr	-352(ra) # 8000a148 <_Unwind_Resume>
    800042b0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800042b4:	00098513          	mv	a0,s3
    800042b8:	fffff097          	auipc	ra,0xfffff
    800042bc:	e6c080e7          	jalr	-404(ra) # 80003124 <_ZN9SemaphoredlEPv>
    800042c0:	00048513          	mv	a0,s1
    800042c4:	00006097          	auipc	ra,0x6
    800042c8:	e84080e7          	jalr	-380(ra) # 8000a148 <_Unwind_Resume>
    800042cc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800042d0:	00090513          	mv	a0,s2
    800042d4:	fffff097          	auipc	ra,0xfffff
    800042d8:	e50080e7          	jalr	-432(ra) # 80003124 <_ZN9SemaphoredlEPv>
    800042dc:	00048513          	mv	a0,s1
    800042e0:	00006097          	auipc	ra,0x6
    800042e4:	e68080e7          	jalr	-408(ra) # 8000a148 <_Unwind_Resume>
    800042e8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800042ec:	00090513          	mv	a0,s2
    800042f0:	fffff097          	auipc	ra,0xfffff
    800042f4:	e34080e7          	jalr	-460(ra) # 80003124 <_ZN9SemaphoredlEPv>
    800042f8:	00048513          	mv	a0,s1
    800042fc:	00006097          	auipc	ra,0x6
    80004300:	e4c080e7          	jalr	-436(ra) # 8000a148 <_Unwind_Resume>

0000000080004304 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004304:	fe010113          	addi	sp,sp,-32
    80004308:	00113c23          	sd	ra,24(sp)
    8000430c:	00813823          	sd	s0,16(sp)
    80004310:	00913423          	sd	s1,8(sp)
    80004314:	01213023          	sd	s2,0(sp)
    80004318:	02010413          	addi	s0,sp,32
    8000431c:	00050493          	mv	s1,a0
    80004320:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004324:	01853503          	ld	a0,24(a0)
    80004328:	fffff097          	auipc	ra,0xfffff
    8000432c:	da4080e7          	jalr	-604(ra) # 800030cc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004330:	0304b503          	ld	a0,48(s1)
    80004334:	fffff097          	auipc	ra,0xfffff
    80004338:	d98080e7          	jalr	-616(ra) # 800030cc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000433c:	0084b783          	ld	a5,8(s1)
    80004340:	0144a703          	lw	a4,20(s1)
    80004344:	00271713          	slli	a4,a4,0x2
    80004348:	00e787b3          	add	a5,a5,a4
    8000434c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004350:	0144a783          	lw	a5,20(s1)
    80004354:	0017879b          	addiw	a5,a5,1
    80004358:	0004a703          	lw	a4,0(s1)
    8000435c:	02e7e7bb          	remw	a5,a5,a4
    80004360:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004364:	0304b503          	ld	a0,48(s1)
    80004368:	fffff097          	auipc	ra,0xfffff
    8000436c:	d90080e7          	jalr	-624(ra) # 800030f8 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004370:	0204b503          	ld	a0,32(s1)
    80004374:	fffff097          	auipc	ra,0xfffff
    80004378:	d84080e7          	jalr	-636(ra) # 800030f8 <_ZN9Semaphore6signalEv>

}
    8000437c:	01813083          	ld	ra,24(sp)
    80004380:	01013403          	ld	s0,16(sp)
    80004384:	00813483          	ld	s1,8(sp)
    80004388:	00013903          	ld	s2,0(sp)
    8000438c:	02010113          	addi	sp,sp,32
    80004390:	00008067          	ret

0000000080004394 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004394:	fe010113          	addi	sp,sp,-32
    80004398:	00113c23          	sd	ra,24(sp)
    8000439c:	00813823          	sd	s0,16(sp)
    800043a0:	00913423          	sd	s1,8(sp)
    800043a4:	01213023          	sd	s2,0(sp)
    800043a8:	02010413          	addi	s0,sp,32
    800043ac:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800043b0:	02053503          	ld	a0,32(a0)
    800043b4:	fffff097          	auipc	ra,0xfffff
    800043b8:	d18080e7          	jalr	-744(ra) # 800030cc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800043bc:	0284b503          	ld	a0,40(s1)
    800043c0:	fffff097          	auipc	ra,0xfffff
    800043c4:	d0c080e7          	jalr	-756(ra) # 800030cc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800043c8:	0084b703          	ld	a4,8(s1)
    800043cc:	0104a783          	lw	a5,16(s1)
    800043d0:	00279693          	slli	a3,a5,0x2
    800043d4:	00d70733          	add	a4,a4,a3
    800043d8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800043dc:	0017879b          	addiw	a5,a5,1
    800043e0:	0004a703          	lw	a4,0(s1)
    800043e4:	02e7e7bb          	remw	a5,a5,a4
    800043e8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800043ec:	0284b503          	ld	a0,40(s1)
    800043f0:	fffff097          	auipc	ra,0xfffff
    800043f4:	d08080e7          	jalr	-760(ra) # 800030f8 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800043f8:	0184b503          	ld	a0,24(s1)
    800043fc:	fffff097          	auipc	ra,0xfffff
    80004400:	cfc080e7          	jalr	-772(ra) # 800030f8 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004404:	00090513          	mv	a0,s2
    80004408:	01813083          	ld	ra,24(sp)
    8000440c:	01013403          	ld	s0,16(sp)
    80004410:	00813483          	ld	s1,8(sp)
    80004414:	00013903          	ld	s2,0(sp)
    80004418:	02010113          	addi	sp,sp,32
    8000441c:	00008067          	ret

0000000080004420 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004420:	fe010113          	addi	sp,sp,-32
    80004424:	00113c23          	sd	ra,24(sp)
    80004428:	00813823          	sd	s0,16(sp)
    8000442c:	00913423          	sd	s1,8(sp)
    80004430:	01213023          	sd	s2,0(sp)
    80004434:	02010413          	addi	s0,sp,32
    80004438:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000443c:	02853503          	ld	a0,40(a0)
    80004440:	fffff097          	auipc	ra,0xfffff
    80004444:	c8c080e7          	jalr	-884(ra) # 800030cc <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004448:	0304b503          	ld	a0,48(s1)
    8000444c:	fffff097          	auipc	ra,0xfffff
    80004450:	c80080e7          	jalr	-896(ra) # 800030cc <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004454:	0144a783          	lw	a5,20(s1)
    80004458:	0104a903          	lw	s2,16(s1)
    8000445c:	0327ce63          	blt	a5,s2,80004498 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004460:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004464:	0304b503          	ld	a0,48(s1)
    80004468:	fffff097          	auipc	ra,0xfffff
    8000446c:	c90080e7          	jalr	-880(ra) # 800030f8 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004470:	0284b503          	ld	a0,40(s1)
    80004474:	fffff097          	auipc	ra,0xfffff
    80004478:	c84080e7          	jalr	-892(ra) # 800030f8 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000447c:	00090513          	mv	a0,s2
    80004480:	01813083          	ld	ra,24(sp)
    80004484:	01013403          	ld	s0,16(sp)
    80004488:	00813483          	ld	s1,8(sp)
    8000448c:	00013903          	ld	s2,0(sp)
    80004490:	02010113          	addi	sp,sp,32
    80004494:	00008067          	ret
        ret = cap - head + tail;
    80004498:	0004a703          	lw	a4,0(s1)
    8000449c:	4127093b          	subw	s2,a4,s2
    800044a0:	00f9093b          	addw	s2,s2,a5
    800044a4:	fc1ff06f          	j	80004464 <_ZN9BufferCPP6getCntEv+0x44>

00000000800044a8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800044a8:	fe010113          	addi	sp,sp,-32
    800044ac:	00113c23          	sd	ra,24(sp)
    800044b0:	00813823          	sd	s0,16(sp)
    800044b4:	00913423          	sd	s1,8(sp)
    800044b8:	02010413          	addi	s0,sp,32
    800044bc:	00050493          	mv	s1,a0
    Console::putc('\n');
    800044c0:	00a00513          	li	a0,10
    800044c4:	fffff097          	auipc	ra,0xfffff
    800044c8:	d94080e7          	jalr	-620(ra) # 80003258 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800044cc:	00003517          	auipc	a0,0x3
    800044d0:	e1450513          	addi	a0,a0,-492 # 800072e0 <CONSOLE_STATUS+0x2d0>
    800044d4:	ffffe097          	auipc	ra,0xffffe
    800044d8:	25c080e7          	jalr	604(ra) # 80002730 <_Z11printStringPKc>
    while (getCnt()) {
    800044dc:	00048513          	mv	a0,s1
    800044e0:	00000097          	auipc	ra,0x0
    800044e4:	f40080e7          	jalr	-192(ra) # 80004420 <_ZN9BufferCPP6getCntEv>
    800044e8:	02050c63          	beqz	a0,80004520 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800044ec:	0084b783          	ld	a5,8(s1)
    800044f0:	0104a703          	lw	a4,16(s1)
    800044f4:	00271713          	slli	a4,a4,0x2
    800044f8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800044fc:	0007c503          	lbu	a0,0(a5)
    80004500:	fffff097          	auipc	ra,0xfffff
    80004504:	d58080e7          	jalr	-680(ra) # 80003258 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004508:	0104a783          	lw	a5,16(s1)
    8000450c:	0017879b          	addiw	a5,a5,1
    80004510:	0004a703          	lw	a4,0(s1)
    80004514:	02e7e7bb          	remw	a5,a5,a4
    80004518:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000451c:	fc1ff06f          	j	800044dc <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004520:	02100513          	li	a0,33
    80004524:	fffff097          	auipc	ra,0xfffff
    80004528:	d34080e7          	jalr	-716(ra) # 80003258 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000452c:	00a00513          	li	a0,10
    80004530:	fffff097          	auipc	ra,0xfffff
    80004534:	d28080e7          	jalr	-728(ra) # 80003258 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004538:	0084b503          	ld	a0,8(s1)
    8000453c:	ffffd097          	auipc	ra,0xffffd
    80004540:	c98080e7          	jalr	-872(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80004544:	0204b503          	ld	a0,32(s1)
    80004548:	00050863          	beqz	a0,80004558 <_ZN9BufferCPPD1Ev+0xb0>
    8000454c:	00053783          	ld	a5,0(a0)
    80004550:	0087b783          	ld	a5,8(a5)
    80004554:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004558:	0184b503          	ld	a0,24(s1)
    8000455c:	00050863          	beqz	a0,8000456c <_ZN9BufferCPPD1Ev+0xc4>
    80004560:	00053783          	ld	a5,0(a0)
    80004564:	0087b783          	ld	a5,8(a5)
    80004568:	000780e7          	jalr	a5
    delete mutexTail;
    8000456c:	0304b503          	ld	a0,48(s1)
    80004570:	00050863          	beqz	a0,80004580 <_ZN9BufferCPPD1Ev+0xd8>
    80004574:	00053783          	ld	a5,0(a0)
    80004578:	0087b783          	ld	a5,8(a5)
    8000457c:	000780e7          	jalr	a5
    delete mutexHead;
    80004580:	0284b503          	ld	a0,40(s1)
    80004584:	00050863          	beqz	a0,80004594 <_ZN9BufferCPPD1Ev+0xec>
    80004588:	00053783          	ld	a5,0(a0)
    8000458c:	0087b783          	ld	a5,8(a5)
    80004590:	000780e7          	jalr	a5
}
    80004594:	01813083          	ld	ra,24(sp)
    80004598:	01013403          	ld	s0,16(sp)
    8000459c:	00813483          	ld	s1,8(sp)
    800045a0:	02010113          	addi	sp,sp,32
    800045a4:	00008067          	ret

00000000800045a8 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800045a8:	fe010113          	addi	sp,sp,-32
    800045ac:	00113c23          	sd	ra,24(sp)
    800045b0:	00813823          	sd	s0,16(sp)
    800045b4:	00913423          	sd	s1,8(sp)
    800045b8:	01213023          	sd	s2,0(sp)
    800045bc:	02010413          	addi	s0,sp,32
    800045c0:	00050493          	mv	s1,a0
    800045c4:	00058913          	mv	s2,a1
    800045c8:	0015879b          	addiw	a5,a1,1
    800045cc:	0007851b          	sext.w	a0,a5
    800045d0:	00f4a023          	sw	a5,0(s1)
    800045d4:	0004a823          	sw	zero,16(s1)
    800045d8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800045dc:	00251513          	slli	a0,a0,0x2
    800045e0:	ffffd097          	auipc	ra,0xffffd
    800045e4:	bb4080e7          	jalr	-1100(ra) # 80001194 <_Z9mem_allocm>
    800045e8:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800045ec:	00000593          	li	a1,0
    800045f0:	02048513          	addi	a0,s1,32
    800045f4:	ffffd097          	auipc	ra,0xffffd
    800045f8:	d5c080e7          	jalr	-676(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    800045fc:	00090593          	mv	a1,s2
    80004600:	01848513          	addi	a0,s1,24
    80004604:	ffffd097          	auipc	ra,0xffffd
    80004608:	d4c080e7          	jalr	-692(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    8000460c:	00100593          	li	a1,1
    80004610:	02848513          	addi	a0,s1,40
    80004614:	ffffd097          	auipc	ra,0xffffd
    80004618:	d3c080e7          	jalr	-708(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    8000461c:	00100593          	li	a1,1
    80004620:	03048513          	addi	a0,s1,48
    80004624:	ffffd097          	auipc	ra,0xffffd
    80004628:	d2c080e7          	jalr	-724(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    8000462c:	01813083          	ld	ra,24(sp)
    80004630:	01013403          	ld	s0,16(sp)
    80004634:	00813483          	ld	s1,8(sp)
    80004638:	00013903          	ld	s2,0(sp)
    8000463c:	02010113          	addi	sp,sp,32
    80004640:	00008067          	ret

0000000080004644 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004644:	fe010113          	addi	sp,sp,-32
    80004648:	00113c23          	sd	ra,24(sp)
    8000464c:	00813823          	sd	s0,16(sp)
    80004650:	00913423          	sd	s1,8(sp)
    80004654:	01213023          	sd	s2,0(sp)
    80004658:	02010413          	addi	s0,sp,32
    8000465c:	00050493          	mv	s1,a0
    80004660:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004664:	01853503          	ld	a0,24(a0)
    80004668:	ffffd097          	auipc	ra,0xffffd
    8000466c:	d30080e7          	jalr	-720(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80004670:	0304b503          	ld	a0,48(s1)
    80004674:	ffffd097          	auipc	ra,0xffffd
    80004678:	d24080e7          	jalr	-732(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    8000467c:	0084b783          	ld	a5,8(s1)
    80004680:	0144a703          	lw	a4,20(s1)
    80004684:	00271713          	slli	a4,a4,0x2
    80004688:	00e787b3          	add	a5,a5,a4
    8000468c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004690:	0144a783          	lw	a5,20(s1)
    80004694:	0017879b          	addiw	a5,a5,1
    80004698:	0004a703          	lw	a4,0(s1)
    8000469c:	02e7e7bb          	remw	a5,a5,a4
    800046a0:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800046a4:	0304b503          	ld	a0,48(s1)
    800046a8:	ffffd097          	auipc	ra,0xffffd
    800046ac:	d38080e7          	jalr	-712(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    800046b0:	0204b503          	ld	a0,32(s1)
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	d2c080e7          	jalr	-724(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    800046bc:	01813083          	ld	ra,24(sp)
    800046c0:	01013403          	ld	s0,16(sp)
    800046c4:	00813483          	ld	s1,8(sp)
    800046c8:	00013903          	ld	s2,0(sp)
    800046cc:	02010113          	addi	sp,sp,32
    800046d0:	00008067          	ret

00000000800046d4 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800046d4:	fe010113          	addi	sp,sp,-32
    800046d8:	00113c23          	sd	ra,24(sp)
    800046dc:	00813823          	sd	s0,16(sp)
    800046e0:	00913423          	sd	s1,8(sp)
    800046e4:	01213023          	sd	s2,0(sp)
    800046e8:	02010413          	addi	s0,sp,32
    800046ec:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800046f0:	02053503          	ld	a0,32(a0)
    800046f4:	ffffd097          	auipc	ra,0xffffd
    800046f8:	ca4080e7          	jalr	-860(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    800046fc:	0284b503          	ld	a0,40(s1)
    80004700:	ffffd097          	auipc	ra,0xffffd
    80004704:	c98080e7          	jalr	-872(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80004708:	0084b703          	ld	a4,8(s1)
    8000470c:	0104a783          	lw	a5,16(s1)
    80004710:	00279693          	slli	a3,a5,0x2
    80004714:	00d70733          	add	a4,a4,a3
    80004718:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000471c:	0017879b          	addiw	a5,a5,1
    80004720:	0004a703          	lw	a4,0(s1)
    80004724:	02e7e7bb          	remw	a5,a5,a4
    80004728:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000472c:	0284b503          	ld	a0,40(s1)
    80004730:	ffffd097          	auipc	ra,0xffffd
    80004734:	cb0080e7          	jalr	-848(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80004738:	0184b503          	ld	a0,24(s1)
    8000473c:	ffffd097          	auipc	ra,0xffffd
    80004740:	ca4080e7          	jalr	-860(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80004744:	00090513          	mv	a0,s2
    80004748:	01813083          	ld	ra,24(sp)
    8000474c:	01013403          	ld	s0,16(sp)
    80004750:	00813483          	ld	s1,8(sp)
    80004754:	00013903          	ld	s2,0(sp)
    80004758:	02010113          	addi	sp,sp,32
    8000475c:	00008067          	ret

0000000080004760 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004760:	fe010113          	addi	sp,sp,-32
    80004764:	00113c23          	sd	ra,24(sp)
    80004768:	00813823          	sd	s0,16(sp)
    8000476c:	00913423          	sd	s1,8(sp)
    80004770:	01213023          	sd	s2,0(sp)
    80004774:	02010413          	addi	s0,sp,32
    80004778:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000477c:	02853503          	ld	a0,40(a0)
    80004780:	ffffd097          	auipc	ra,0xffffd
    80004784:	c18080e7          	jalr	-1000(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    80004788:	0304b503          	ld	a0,48(s1)
    8000478c:	ffffd097          	auipc	ra,0xffffd
    80004790:	c0c080e7          	jalr	-1012(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80004794:	0144a783          	lw	a5,20(s1)
    80004798:	0104a903          	lw	s2,16(s1)
    8000479c:	0327ce63          	blt	a5,s2,800047d8 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800047a0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800047a4:	0304b503          	ld	a0,48(s1)
    800047a8:	ffffd097          	auipc	ra,0xffffd
    800047ac:	c38080e7          	jalr	-968(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    800047b0:	0284b503          	ld	a0,40(s1)
    800047b4:	ffffd097          	auipc	ra,0xffffd
    800047b8:	c2c080e7          	jalr	-980(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    800047bc:	00090513          	mv	a0,s2
    800047c0:	01813083          	ld	ra,24(sp)
    800047c4:	01013403          	ld	s0,16(sp)
    800047c8:	00813483          	ld	s1,8(sp)
    800047cc:	00013903          	ld	s2,0(sp)
    800047d0:	02010113          	addi	sp,sp,32
    800047d4:	00008067          	ret
        ret = cap - head + tail;
    800047d8:	0004a703          	lw	a4,0(s1)
    800047dc:	4127093b          	subw	s2,a4,s2
    800047e0:	00f9093b          	addw	s2,s2,a5
    800047e4:	fc1ff06f          	j	800047a4 <_ZN6Buffer6getCntEv+0x44>

00000000800047e8 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800047e8:	fe010113          	addi	sp,sp,-32
    800047ec:	00113c23          	sd	ra,24(sp)
    800047f0:	00813823          	sd	s0,16(sp)
    800047f4:	00913423          	sd	s1,8(sp)
    800047f8:	02010413          	addi	s0,sp,32
    800047fc:	00050493          	mv	s1,a0
    putc('\n');
    80004800:	00a00513          	li	a0,10
    80004804:	ffffd097          	auipc	ra,0xffffd
    80004808:	cd4080e7          	jalr	-812(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    8000480c:	00003517          	auipc	a0,0x3
    80004810:	ad450513          	addi	a0,a0,-1324 # 800072e0 <CONSOLE_STATUS+0x2d0>
    80004814:	ffffe097          	auipc	ra,0xffffe
    80004818:	f1c080e7          	jalr	-228(ra) # 80002730 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000481c:	00048513          	mv	a0,s1
    80004820:	00000097          	auipc	ra,0x0
    80004824:	f40080e7          	jalr	-192(ra) # 80004760 <_ZN6Buffer6getCntEv>
    80004828:	02a05c63          	blez	a0,80004860 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000482c:	0084b783          	ld	a5,8(s1)
    80004830:	0104a703          	lw	a4,16(s1)
    80004834:	00271713          	slli	a4,a4,0x2
    80004838:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000483c:	0007c503          	lbu	a0,0(a5)
    80004840:	ffffd097          	auipc	ra,0xffffd
    80004844:	c98080e7          	jalr	-872(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80004848:	0104a783          	lw	a5,16(s1)
    8000484c:	0017879b          	addiw	a5,a5,1
    80004850:	0004a703          	lw	a4,0(s1)
    80004854:	02e7e7bb          	remw	a5,a5,a4
    80004858:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000485c:	fc1ff06f          	j	8000481c <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004860:	02100513          	li	a0,33
    80004864:	ffffd097          	auipc	ra,0xffffd
    80004868:	c74080e7          	jalr	-908(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    8000486c:	00a00513          	li	a0,10
    80004870:	ffffd097          	auipc	ra,0xffffd
    80004874:	c68080e7          	jalr	-920(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    80004878:	0084b503          	ld	a0,8(s1)
    8000487c:	ffffd097          	auipc	ra,0xffffd
    80004880:	958080e7          	jalr	-1704(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004884:	0204b503          	ld	a0,32(s1)
    80004888:	ffffd097          	auipc	ra,0xffffd
    8000488c:	b98080e7          	jalr	-1128(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80004890:	0184b503          	ld	a0,24(s1)
    80004894:	ffffd097          	auipc	ra,0xffffd
    80004898:	b8c080e7          	jalr	-1140(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    8000489c:	0304b503          	ld	a0,48(s1)
    800048a0:	ffffd097          	auipc	ra,0xffffd
    800048a4:	b80080e7          	jalr	-1152(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    800048a8:	0284b503          	ld	a0,40(s1)
    800048ac:	ffffd097          	auipc	ra,0xffffd
    800048b0:	b74080e7          	jalr	-1164(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    800048b4:	01813083          	ld	ra,24(sp)
    800048b8:	01013403          	ld	s0,16(sp)
    800048bc:	00813483          	ld	s1,8(sp)
    800048c0:	02010113          	addi	sp,sp,32
    800048c4:	00008067          	ret

00000000800048c8 <start>:
    800048c8:	ff010113          	addi	sp,sp,-16
    800048cc:	00813423          	sd	s0,8(sp)
    800048d0:	01010413          	addi	s0,sp,16
    800048d4:	300027f3          	csrr	a5,mstatus
    800048d8:	ffffe737          	lui	a4,0xffffe
    800048dc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff451f>
    800048e0:	00e7f7b3          	and	a5,a5,a4
    800048e4:	00001737          	lui	a4,0x1
    800048e8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800048ec:	00e7e7b3          	or	a5,a5,a4
    800048f0:	30079073          	csrw	mstatus,a5
    800048f4:	00000797          	auipc	a5,0x0
    800048f8:	16078793          	addi	a5,a5,352 # 80004a54 <system_main>
    800048fc:	34179073          	csrw	mepc,a5
    80004900:	00000793          	li	a5,0
    80004904:	18079073          	csrw	satp,a5
    80004908:	000107b7          	lui	a5,0x10
    8000490c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004910:	30279073          	csrw	medeleg,a5
    80004914:	30379073          	csrw	mideleg,a5
    80004918:	104027f3          	csrr	a5,sie
    8000491c:	2227e793          	ori	a5,a5,546
    80004920:	10479073          	csrw	sie,a5
    80004924:	fff00793          	li	a5,-1
    80004928:	00a7d793          	srli	a5,a5,0xa
    8000492c:	3b079073          	csrw	pmpaddr0,a5
    80004930:	00f00793          	li	a5,15
    80004934:	3a079073          	csrw	pmpcfg0,a5
    80004938:	f14027f3          	csrr	a5,mhartid
    8000493c:	0200c737          	lui	a4,0x200c
    80004940:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004944:	0007869b          	sext.w	a3,a5
    80004948:	00269713          	slli	a4,a3,0x2
    8000494c:	000f4637          	lui	a2,0xf4
    80004950:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004954:	00d70733          	add	a4,a4,a3
    80004958:	0037979b          	slliw	a5,a5,0x3
    8000495c:	020046b7          	lui	a3,0x2004
    80004960:	00d787b3          	add	a5,a5,a3
    80004964:	00c585b3          	add	a1,a1,a2
    80004968:	00371693          	slli	a3,a4,0x3
    8000496c:	00004717          	auipc	a4,0x4
    80004970:	71470713          	addi	a4,a4,1812 # 80009080 <timer_scratch>
    80004974:	00b7b023          	sd	a1,0(a5)
    80004978:	00d70733          	add	a4,a4,a3
    8000497c:	00f73c23          	sd	a5,24(a4)
    80004980:	02c73023          	sd	a2,32(a4)
    80004984:	34071073          	csrw	mscratch,a4
    80004988:	00000797          	auipc	a5,0x0
    8000498c:	6e878793          	addi	a5,a5,1768 # 80005070 <timervec>
    80004990:	30579073          	csrw	mtvec,a5
    80004994:	300027f3          	csrr	a5,mstatus
    80004998:	0087e793          	ori	a5,a5,8
    8000499c:	30079073          	csrw	mstatus,a5
    800049a0:	304027f3          	csrr	a5,mie
    800049a4:	0807e793          	ori	a5,a5,128
    800049a8:	30479073          	csrw	mie,a5
    800049ac:	f14027f3          	csrr	a5,mhartid
    800049b0:	0007879b          	sext.w	a5,a5
    800049b4:	00078213          	mv	tp,a5
    800049b8:	30200073          	mret
    800049bc:	00813403          	ld	s0,8(sp)
    800049c0:	01010113          	addi	sp,sp,16
    800049c4:	00008067          	ret

00000000800049c8 <timerinit>:
    800049c8:	ff010113          	addi	sp,sp,-16
    800049cc:	00813423          	sd	s0,8(sp)
    800049d0:	01010413          	addi	s0,sp,16
    800049d4:	f14027f3          	csrr	a5,mhartid
    800049d8:	0200c737          	lui	a4,0x200c
    800049dc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800049e0:	0007869b          	sext.w	a3,a5
    800049e4:	00269713          	slli	a4,a3,0x2
    800049e8:	000f4637          	lui	a2,0xf4
    800049ec:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800049f0:	00d70733          	add	a4,a4,a3
    800049f4:	0037979b          	slliw	a5,a5,0x3
    800049f8:	020046b7          	lui	a3,0x2004
    800049fc:	00d787b3          	add	a5,a5,a3
    80004a00:	00c585b3          	add	a1,a1,a2
    80004a04:	00371693          	slli	a3,a4,0x3
    80004a08:	00004717          	auipc	a4,0x4
    80004a0c:	67870713          	addi	a4,a4,1656 # 80009080 <timer_scratch>
    80004a10:	00b7b023          	sd	a1,0(a5)
    80004a14:	00d70733          	add	a4,a4,a3
    80004a18:	00f73c23          	sd	a5,24(a4)
    80004a1c:	02c73023          	sd	a2,32(a4)
    80004a20:	34071073          	csrw	mscratch,a4
    80004a24:	00000797          	auipc	a5,0x0
    80004a28:	64c78793          	addi	a5,a5,1612 # 80005070 <timervec>
    80004a2c:	30579073          	csrw	mtvec,a5
    80004a30:	300027f3          	csrr	a5,mstatus
    80004a34:	0087e793          	ori	a5,a5,8
    80004a38:	30079073          	csrw	mstatus,a5
    80004a3c:	304027f3          	csrr	a5,mie
    80004a40:	0807e793          	ori	a5,a5,128
    80004a44:	30479073          	csrw	mie,a5
    80004a48:	00813403          	ld	s0,8(sp)
    80004a4c:	01010113          	addi	sp,sp,16
    80004a50:	00008067          	ret

0000000080004a54 <system_main>:
    80004a54:	fe010113          	addi	sp,sp,-32
    80004a58:	00813823          	sd	s0,16(sp)
    80004a5c:	00913423          	sd	s1,8(sp)
    80004a60:	00113c23          	sd	ra,24(sp)
    80004a64:	02010413          	addi	s0,sp,32
    80004a68:	00000097          	auipc	ra,0x0
    80004a6c:	0c4080e7          	jalr	196(ra) # 80004b2c <cpuid>
    80004a70:	00004497          	auipc	s1,0x4
    80004a74:	4e048493          	addi	s1,s1,1248 # 80008f50 <started>
    80004a78:	02050263          	beqz	a0,80004a9c <system_main+0x48>
    80004a7c:	0004a783          	lw	a5,0(s1)
    80004a80:	0007879b          	sext.w	a5,a5
    80004a84:	fe078ce3          	beqz	a5,80004a7c <system_main+0x28>
    80004a88:	0ff0000f          	fence
    80004a8c:	00003517          	auipc	a0,0x3
    80004a90:	89c50513          	addi	a0,a0,-1892 # 80007328 <CONSOLE_STATUS+0x318>
    80004a94:	00001097          	auipc	ra,0x1
    80004a98:	a78080e7          	jalr	-1416(ra) # 8000550c <panic>
    80004a9c:	00001097          	auipc	ra,0x1
    80004aa0:	9cc080e7          	jalr	-1588(ra) # 80005468 <consoleinit>
    80004aa4:	00001097          	auipc	ra,0x1
    80004aa8:	158080e7          	jalr	344(ra) # 80005bfc <printfinit>
    80004aac:	00003517          	auipc	a0,0x3
    80004ab0:	82450513          	addi	a0,a0,-2012 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80004ab4:	00001097          	auipc	ra,0x1
    80004ab8:	ab4080e7          	jalr	-1356(ra) # 80005568 <__printf>
    80004abc:	00003517          	auipc	a0,0x3
    80004ac0:	83c50513          	addi	a0,a0,-1988 # 800072f8 <CONSOLE_STATUS+0x2e8>
    80004ac4:	00001097          	auipc	ra,0x1
    80004ac8:	aa4080e7          	jalr	-1372(ra) # 80005568 <__printf>
    80004acc:	00003517          	auipc	a0,0x3
    80004ad0:	80450513          	addi	a0,a0,-2044 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80004ad4:	00001097          	auipc	ra,0x1
    80004ad8:	a94080e7          	jalr	-1388(ra) # 80005568 <__printf>
    80004adc:	00001097          	auipc	ra,0x1
    80004ae0:	4ac080e7          	jalr	1196(ra) # 80005f88 <kinit>
    80004ae4:	00000097          	auipc	ra,0x0
    80004ae8:	148080e7          	jalr	328(ra) # 80004c2c <trapinit>
    80004aec:	00000097          	auipc	ra,0x0
    80004af0:	16c080e7          	jalr	364(ra) # 80004c58 <trapinithart>
    80004af4:	00000097          	auipc	ra,0x0
    80004af8:	5bc080e7          	jalr	1468(ra) # 800050b0 <plicinit>
    80004afc:	00000097          	auipc	ra,0x0
    80004b00:	5dc080e7          	jalr	1500(ra) # 800050d8 <plicinithart>
    80004b04:	00000097          	auipc	ra,0x0
    80004b08:	078080e7          	jalr	120(ra) # 80004b7c <userinit>
    80004b0c:	0ff0000f          	fence
    80004b10:	00100793          	li	a5,1
    80004b14:	00002517          	auipc	a0,0x2
    80004b18:	7fc50513          	addi	a0,a0,2044 # 80007310 <CONSOLE_STATUS+0x300>
    80004b1c:	00f4a023          	sw	a5,0(s1)
    80004b20:	00001097          	auipc	ra,0x1
    80004b24:	a48080e7          	jalr	-1464(ra) # 80005568 <__printf>
    80004b28:	0000006f          	j	80004b28 <system_main+0xd4>

0000000080004b2c <cpuid>:
    80004b2c:	ff010113          	addi	sp,sp,-16
    80004b30:	00813423          	sd	s0,8(sp)
    80004b34:	01010413          	addi	s0,sp,16
    80004b38:	00020513          	mv	a0,tp
    80004b3c:	00813403          	ld	s0,8(sp)
    80004b40:	0005051b          	sext.w	a0,a0
    80004b44:	01010113          	addi	sp,sp,16
    80004b48:	00008067          	ret

0000000080004b4c <mycpu>:
    80004b4c:	ff010113          	addi	sp,sp,-16
    80004b50:	00813423          	sd	s0,8(sp)
    80004b54:	01010413          	addi	s0,sp,16
    80004b58:	00020793          	mv	a5,tp
    80004b5c:	00813403          	ld	s0,8(sp)
    80004b60:	0007879b          	sext.w	a5,a5
    80004b64:	00779793          	slli	a5,a5,0x7
    80004b68:	00005517          	auipc	a0,0x5
    80004b6c:	54850513          	addi	a0,a0,1352 # 8000a0b0 <cpus>
    80004b70:	00f50533          	add	a0,a0,a5
    80004b74:	01010113          	addi	sp,sp,16
    80004b78:	00008067          	ret

0000000080004b7c <userinit>:
    80004b7c:	ff010113          	addi	sp,sp,-16
    80004b80:	00813423          	sd	s0,8(sp)
    80004b84:	01010413          	addi	s0,sp,16
    80004b88:	00813403          	ld	s0,8(sp)
    80004b8c:	01010113          	addi	sp,sp,16
    80004b90:	ffffe317          	auipc	t1,0xffffe
    80004b94:	fcc30067          	jr	-52(t1) # 80002b5c <main>

0000000080004b98 <either_copyout>:
    80004b98:	ff010113          	addi	sp,sp,-16
    80004b9c:	00813023          	sd	s0,0(sp)
    80004ba0:	00113423          	sd	ra,8(sp)
    80004ba4:	01010413          	addi	s0,sp,16
    80004ba8:	02051663          	bnez	a0,80004bd4 <either_copyout+0x3c>
    80004bac:	00058513          	mv	a0,a1
    80004bb0:	00060593          	mv	a1,a2
    80004bb4:	0006861b          	sext.w	a2,a3
    80004bb8:	00002097          	auipc	ra,0x2
    80004bbc:	c5c080e7          	jalr	-932(ra) # 80006814 <__memmove>
    80004bc0:	00813083          	ld	ra,8(sp)
    80004bc4:	00013403          	ld	s0,0(sp)
    80004bc8:	00000513          	li	a0,0
    80004bcc:	01010113          	addi	sp,sp,16
    80004bd0:	00008067          	ret
    80004bd4:	00002517          	auipc	a0,0x2
    80004bd8:	77c50513          	addi	a0,a0,1916 # 80007350 <CONSOLE_STATUS+0x340>
    80004bdc:	00001097          	auipc	ra,0x1
    80004be0:	930080e7          	jalr	-1744(ra) # 8000550c <panic>

0000000080004be4 <either_copyin>:
    80004be4:	ff010113          	addi	sp,sp,-16
    80004be8:	00813023          	sd	s0,0(sp)
    80004bec:	00113423          	sd	ra,8(sp)
    80004bf0:	01010413          	addi	s0,sp,16
    80004bf4:	02059463          	bnez	a1,80004c1c <either_copyin+0x38>
    80004bf8:	00060593          	mv	a1,a2
    80004bfc:	0006861b          	sext.w	a2,a3
    80004c00:	00002097          	auipc	ra,0x2
    80004c04:	c14080e7          	jalr	-1004(ra) # 80006814 <__memmove>
    80004c08:	00813083          	ld	ra,8(sp)
    80004c0c:	00013403          	ld	s0,0(sp)
    80004c10:	00000513          	li	a0,0
    80004c14:	01010113          	addi	sp,sp,16
    80004c18:	00008067          	ret
    80004c1c:	00002517          	auipc	a0,0x2
    80004c20:	75c50513          	addi	a0,a0,1884 # 80007378 <CONSOLE_STATUS+0x368>
    80004c24:	00001097          	auipc	ra,0x1
    80004c28:	8e8080e7          	jalr	-1816(ra) # 8000550c <panic>

0000000080004c2c <trapinit>:
    80004c2c:	ff010113          	addi	sp,sp,-16
    80004c30:	00813423          	sd	s0,8(sp)
    80004c34:	01010413          	addi	s0,sp,16
    80004c38:	00813403          	ld	s0,8(sp)
    80004c3c:	00002597          	auipc	a1,0x2
    80004c40:	76458593          	addi	a1,a1,1892 # 800073a0 <CONSOLE_STATUS+0x390>
    80004c44:	00005517          	auipc	a0,0x5
    80004c48:	4ec50513          	addi	a0,a0,1260 # 8000a130 <tickslock>
    80004c4c:	01010113          	addi	sp,sp,16
    80004c50:	00001317          	auipc	t1,0x1
    80004c54:	5c830067          	jr	1480(t1) # 80006218 <initlock>

0000000080004c58 <trapinithart>:
    80004c58:	ff010113          	addi	sp,sp,-16
    80004c5c:	00813423          	sd	s0,8(sp)
    80004c60:	01010413          	addi	s0,sp,16
    80004c64:	00000797          	auipc	a5,0x0
    80004c68:	2fc78793          	addi	a5,a5,764 # 80004f60 <kernelvec>
    80004c6c:	10579073          	csrw	stvec,a5
    80004c70:	00813403          	ld	s0,8(sp)
    80004c74:	01010113          	addi	sp,sp,16
    80004c78:	00008067          	ret

0000000080004c7c <usertrap>:
    80004c7c:	ff010113          	addi	sp,sp,-16
    80004c80:	00813423          	sd	s0,8(sp)
    80004c84:	01010413          	addi	s0,sp,16
    80004c88:	00813403          	ld	s0,8(sp)
    80004c8c:	01010113          	addi	sp,sp,16
    80004c90:	00008067          	ret

0000000080004c94 <usertrapret>:
    80004c94:	ff010113          	addi	sp,sp,-16
    80004c98:	00813423          	sd	s0,8(sp)
    80004c9c:	01010413          	addi	s0,sp,16
    80004ca0:	00813403          	ld	s0,8(sp)
    80004ca4:	01010113          	addi	sp,sp,16
    80004ca8:	00008067          	ret

0000000080004cac <kerneltrap>:
    80004cac:	fe010113          	addi	sp,sp,-32
    80004cb0:	00813823          	sd	s0,16(sp)
    80004cb4:	00113c23          	sd	ra,24(sp)
    80004cb8:	00913423          	sd	s1,8(sp)
    80004cbc:	02010413          	addi	s0,sp,32
    80004cc0:	142025f3          	csrr	a1,scause
    80004cc4:	100027f3          	csrr	a5,sstatus
    80004cc8:	0027f793          	andi	a5,a5,2
    80004ccc:	10079c63          	bnez	a5,80004de4 <kerneltrap+0x138>
    80004cd0:	142027f3          	csrr	a5,scause
    80004cd4:	0207ce63          	bltz	a5,80004d10 <kerneltrap+0x64>
    80004cd8:	00002517          	auipc	a0,0x2
    80004cdc:	71050513          	addi	a0,a0,1808 # 800073e8 <CONSOLE_STATUS+0x3d8>
    80004ce0:	00001097          	auipc	ra,0x1
    80004ce4:	888080e7          	jalr	-1912(ra) # 80005568 <__printf>
    80004ce8:	141025f3          	csrr	a1,sepc
    80004cec:	14302673          	csrr	a2,stval
    80004cf0:	00002517          	auipc	a0,0x2
    80004cf4:	70850513          	addi	a0,a0,1800 # 800073f8 <CONSOLE_STATUS+0x3e8>
    80004cf8:	00001097          	auipc	ra,0x1
    80004cfc:	870080e7          	jalr	-1936(ra) # 80005568 <__printf>
    80004d00:	00002517          	auipc	a0,0x2
    80004d04:	71050513          	addi	a0,a0,1808 # 80007410 <CONSOLE_STATUS+0x400>
    80004d08:	00001097          	auipc	ra,0x1
    80004d0c:	804080e7          	jalr	-2044(ra) # 8000550c <panic>
    80004d10:	0ff7f713          	andi	a4,a5,255
    80004d14:	00900693          	li	a3,9
    80004d18:	04d70063          	beq	a4,a3,80004d58 <kerneltrap+0xac>
    80004d1c:	fff00713          	li	a4,-1
    80004d20:	03f71713          	slli	a4,a4,0x3f
    80004d24:	00170713          	addi	a4,a4,1
    80004d28:	fae798e3          	bne	a5,a4,80004cd8 <kerneltrap+0x2c>
    80004d2c:	00000097          	auipc	ra,0x0
    80004d30:	e00080e7          	jalr	-512(ra) # 80004b2c <cpuid>
    80004d34:	06050663          	beqz	a0,80004da0 <kerneltrap+0xf4>
    80004d38:	144027f3          	csrr	a5,sip
    80004d3c:	ffd7f793          	andi	a5,a5,-3
    80004d40:	14479073          	csrw	sip,a5
    80004d44:	01813083          	ld	ra,24(sp)
    80004d48:	01013403          	ld	s0,16(sp)
    80004d4c:	00813483          	ld	s1,8(sp)
    80004d50:	02010113          	addi	sp,sp,32
    80004d54:	00008067          	ret
    80004d58:	00000097          	auipc	ra,0x0
    80004d5c:	3cc080e7          	jalr	972(ra) # 80005124 <plic_claim>
    80004d60:	00a00793          	li	a5,10
    80004d64:	00050493          	mv	s1,a0
    80004d68:	06f50863          	beq	a0,a5,80004dd8 <kerneltrap+0x12c>
    80004d6c:	fc050ce3          	beqz	a0,80004d44 <kerneltrap+0x98>
    80004d70:	00050593          	mv	a1,a0
    80004d74:	00002517          	auipc	a0,0x2
    80004d78:	65450513          	addi	a0,a0,1620 # 800073c8 <CONSOLE_STATUS+0x3b8>
    80004d7c:	00000097          	auipc	ra,0x0
    80004d80:	7ec080e7          	jalr	2028(ra) # 80005568 <__printf>
    80004d84:	01013403          	ld	s0,16(sp)
    80004d88:	01813083          	ld	ra,24(sp)
    80004d8c:	00048513          	mv	a0,s1
    80004d90:	00813483          	ld	s1,8(sp)
    80004d94:	02010113          	addi	sp,sp,32
    80004d98:	00000317          	auipc	t1,0x0
    80004d9c:	3c430067          	jr	964(t1) # 8000515c <plic_complete>
    80004da0:	00005517          	auipc	a0,0x5
    80004da4:	39050513          	addi	a0,a0,912 # 8000a130 <tickslock>
    80004da8:	00001097          	auipc	ra,0x1
    80004dac:	494080e7          	jalr	1172(ra) # 8000623c <acquire>
    80004db0:	00004717          	auipc	a4,0x4
    80004db4:	1a470713          	addi	a4,a4,420 # 80008f54 <ticks>
    80004db8:	00072783          	lw	a5,0(a4)
    80004dbc:	00005517          	auipc	a0,0x5
    80004dc0:	37450513          	addi	a0,a0,884 # 8000a130 <tickslock>
    80004dc4:	0017879b          	addiw	a5,a5,1
    80004dc8:	00f72023          	sw	a5,0(a4)
    80004dcc:	00001097          	auipc	ra,0x1
    80004dd0:	53c080e7          	jalr	1340(ra) # 80006308 <release>
    80004dd4:	f65ff06f          	j	80004d38 <kerneltrap+0x8c>
    80004dd8:	00001097          	auipc	ra,0x1
    80004ddc:	098080e7          	jalr	152(ra) # 80005e70 <uartintr>
    80004de0:	fa5ff06f          	j	80004d84 <kerneltrap+0xd8>
    80004de4:	00002517          	auipc	a0,0x2
    80004de8:	5c450513          	addi	a0,a0,1476 # 800073a8 <CONSOLE_STATUS+0x398>
    80004dec:	00000097          	auipc	ra,0x0
    80004df0:	720080e7          	jalr	1824(ra) # 8000550c <panic>

0000000080004df4 <clockintr>:
    80004df4:	fe010113          	addi	sp,sp,-32
    80004df8:	00813823          	sd	s0,16(sp)
    80004dfc:	00913423          	sd	s1,8(sp)
    80004e00:	00113c23          	sd	ra,24(sp)
    80004e04:	02010413          	addi	s0,sp,32
    80004e08:	00005497          	auipc	s1,0x5
    80004e0c:	32848493          	addi	s1,s1,808 # 8000a130 <tickslock>
    80004e10:	00048513          	mv	a0,s1
    80004e14:	00001097          	auipc	ra,0x1
    80004e18:	428080e7          	jalr	1064(ra) # 8000623c <acquire>
    80004e1c:	00004717          	auipc	a4,0x4
    80004e20:	13870713          	addi	a4,a4,312 # 80008f54 <ticks>
    80004e24:	00072783          	lw	a5,0(a4)
    80004e28:	01013403          	ld	s0,16(sp)
    80004e2c:	01813083          	ld	ra,24(sp)
    80004e30:	00048513          	mv	a0,s1
    80004e34:	0017879b          	addiw	a5,a5,1
    80004e38:	00813483          	ld	s1,8(sp)
    80004e3c:	00f72023          	sw	a5,0(a4)
    80004e40:	02010113          	addi	sp,sp,32
    80004e44:	00001317          	auipc	t1,0x1
    80004e48:	4c430067          	jr	1220(t1) # 80006308 <release>

0000000080004e4c <devintr>:
    80004e4c:	142027f3          	csrr	a5,scause
    80004e50:	00000513          	li	a0,0
    80004e54:	0007c463          	bltz	a5,80004e5c <devintr+0x10>
    80004e58:	00008067          	ret
    80004e5c:	fe010113          	addi	sp,sp,-32
    80004e60:	00813823          	sd	s0,16(sp)
    80004e64:	00113c23          	sd	ra,24(sp)
    80004e68:	00913423          	sd	s1,8(sp)
    80004e6c:	02010413          	addi	s0,sp,32
    80004e70:	0ff7f713          	andi	a4,a5,255
    80004e74:	00900693          	li	a3,9
    80004e78:	04d70c63          	beq	a4,a3,80004ed0 <devintr+0x84>
    80004e7c:	fff00713          	li	a4,-1
    80004e80:	03f71713          	slli	a4,a4,0x3f
    80004e84:	00170713          	addi	a4,a4,1
    80004e88:	00e78c63          	beq	a5,a4,80004ea0 <devintr+0x54>
    80004e8c:	01813083          	ld	ra,24(sp)
    80004e90:	01013403          	ld	s0,16(sp)
    80004e94:	00813483          	ld	s1,8(sp)
    80004e98:	02010113          	addi	sp,sp,32
    80004e9c:	00008067          	ret
    80004ea0:	00000097          	auipc	ra,0x0
    80004ea4:	c8c080e7          	jalr	-884(ra) # 80004b2c <cpuid>
    80004ea8:	06050663          	beqz	a0,80004f14 <devintr+0xc8>
    80004eac:	144027f3          	csrr	a5,sip
    80004eb0:	ffd7f793          	andi	a5,a5,-3
    80004eb4:	14479073          	csrw	sip,a5
    80004eb8:	01813083          	ld	ra,24(sp)
    80004ebc:	01013403          	ld	s0,16(sp)
    80004ec0:	00813483          	ld	s1,8(sp)
    80004ec4:	00200513          	li	a0,2
    80004ec8:	02010113          	addi	sp,sp,32
    80004ecc:	00008067          	ret
    80004ed0:	00000097          	auipc	ra,0x0
    80004ed4:	254080e7          	jalr	596(ra) # 80005124 <plic_claim>
    80004ed8:	00a00793          	li	a5,10
    80004edc:	00050493          	mv	s1,a0
    80004ee0:	06f50663          	beq	a0,a5,80004f4c <devintr+0x100>
    80004ee4:	00100513          	li	a0,1
    80004ee8:	fa0482e3          	beqz	s1,80004e8c <devintr+0x40>
    80004eec:	00048593          	mv	a1,s1
    80004ef0:	00002517          	auipc	a0,0x2
    80004ef4:	4d850513          	addi	a0,a0,1240 # 800073c8 <CONSOLE_STATUS+0x3b8>
    80004ef8:	00000097          	auipc	ra,0x0
    80004efc:	670080e7          	jalr	1648(ra) # 80005568 <__printf>
    80004f00:	00048513          	mv	a0,s1
    80004f04:	00000097          	auipc	ra,0x0
    80004f08:	258080e7          	jalr	600(ra) # 8000515c <plic_complete>
    80004f0c:	00100513          	li	a0,1
    80004f10:	f7dff06f          	j	80004e8c <devintr+0x40>
    80004f14:	00005517          	auipc	a0,0x5
    80004f18:	21c50513          	addi	a0,a0,540 # 8000a130 <tickslock>
    80004f1c:	00001097          	auipc	ra,0x1
    80004f20:	320080e7          	jalr	800(ra) # 8000623c <acquire>
    80004f24:	00004717          	auipc	a4,0x4
    80004f28:	03070713          	addi	a4,a4,48 # 80008f54 <ticks>
    80004f2c:	00072783          	lw	a5,0(a4)
    80004f30:	00005517          	auipc	a0,0x5
    80004f34:	20050513          	addi	a0,a0,512 # 8000a130 <tickslock>
    80004f38:	0017879b          	addiw	a5,a5,1
    80004f3c:	00f72023          	sw	a5,0(a4)
    80004f40:	00001097          	auipc	ra,0x1
    80004f44:	3c8080e7          	jalr	968(ra) # 80006308 <release>
    80004f48:	f65ff06f          	j	80004eac <devintr+0x60>
    80004f4c:	00001097          	auipc	ra,0x1
    80004f50:	f24080e7          	jalr	-220(ra) # 80005e70 <uartintr>
    80004f54:	fadff06f          	j	80004f00 <devintr+0xb4>
	...

0000000080004f60 <kernelvec>:
    80004f60:	f0010113          	addi	sp,sp,-256
    80004f64:	00113023          	sd	ra,0(sp)
    80004f68:	00213423          	sd	sp,8(sp)
    80004f6c:	00313823          	sd	gp,16(sp)
    80004f70:	00413c23          	sd	tp,24(sp)
    80004f74:	02513023          	sd	t0,32(sp)
    80004f78:	02613423          	sd	t1,40(sp)
    80004f7c:	02713823          	sd	t2,48(sp)
    80004f80:	02813c23          	sd	s0,56(sp)
    80004f84:	04913023          	sd	s1,64(sp)
    80004f88:	04a13423          	sd	a0,72(sp)
    80004f8c:	04b13823          	sd	a1,80(sp)
    80004f90:	04c13c23          	sd	a2,88(sp)
    80004f94:	06d13023          	sd	a3,96(sp)
    80004f98:	06e13423          	sd	a4,104(sp)
    80004f9c:	06f13823          	sd	a5,112(sp)
    80004fa0:	07013c23          	sd	a6,120(sp)
    80004fa4:	09113023          	sd	a7,128(sp)
    80004fa8:	09213423          	sd	s2,136(sp)
    80004fac:	09313823          	sd	s3,144(sp)
    80004fb0:	09413c23          	sd	s4,152(sp)
    80004fb4:	0b513023          	sd	s5,160(sp)
    80004fb8:	0b613423          	sd	s6,168(sp)
    80004fbc:	0b713823          	sd	s7,176(sp)
    80004fc0:	0b813c23          	sd	s8,184(sp)
    80004fc4:	0d913023          	sd	s9,192(sp)
    80004fc8:	0da13423          	sd	s10,200(sp)
    80004fcc:	0db13823          	sd	s11,208(sp)
    80004fd0:	0dc13c23          	sd	t3,216(sp)
    80004fd4:	0fd13023          	sd	t4,224(sp)
    80004fd8:	0fe13423          	sd	t5,232(sp)
    80004fdc:	0ff13823          	sd	t6,240(sp)
    80004fe0:	ccdff0ef          	jal	ra,80004cac <kerneltrap>
    80004fe4:	00013083          	ld	ra,0(sp)
    80004fe8:	00813103          	ld	sp,8(sp)
    80004fec:	01013183          	ld	gp,16(sp)
    80004ff0:	02013283          	ld	t0,32(sp)
    80004ff4:	02813303          	ld	t1,40(sp)
    80004ff8:	03013383          	ld	t2,48(sp)
    80004ffc:	03813403          	ld	s0,56(sp)
    80005000:	04013483          	ld	s1,64(sp)
    80005004:	04813503          	ld	a0,72(sp)
    80005008:	05013583          	ld	a1,80(sp)
    8000500c:	05813603          	ld	a2,88(sp)
    80005010:	06013683          	ld	a3,96(sp)
    80005014:	06813703          	ld	a4,104(sp)
    80005018:	07013783          	ld	a5,112(sp)
    8000501c:	07813803          	ld	a6,120(sp)
    80005020:	08013883          	ld	a7,128(sp)
    80005024:	08813903          	ld	s2,136(sp)
    80005028:	09013983          	ld	s3,144(sp)
    8000502c:	09813a03          	ld	s4,152(sp)
    80005030:	0a013a83          	ld	s5,160(sp)
    80005034:	0a813b03          	ld	s6,168(sp)
    80005038:	0b013b83          	ld	s7,176(sp)
    8000503c:	0b813c03          	ld	s8,184(sp)
    80005040:	0c013c83          	ld	s9,192(sp)
    80005044:	0c813d03          	ld	s10,200(sp)
    80005048:	0d013d83          	ld	s11,208(sp)
    8000504c:	0d813e03          	ld	t3,216(sp)
    80005050:	0e013e83          	ld	t4,224(sp)
    80005054:	0e813f03          	ld	t5,232(sp)
    80005058:	0f013f83          	ld	t6,240(sp)
    8000505c:	10010113          	addi	sp,sp,256
    80005060:	10200073          	sret
    80005064:	00000013          	nop
    80005068:	00000013          	nop
    8000506c:	00000013          	nop

0000000080005070 <timervec>:
    80005070:	34051573          	csrrw	a0,mscratch,a0
    80005074:	00b53023          	sd	a1,0(a0)
    80005078:	00c53423          	sd	a2,8(a0)
    8000507c:	00d53823          	sd	a3,16(a0)
    80005080:	01853583          	ld	a1,24(a0)
    80005084:	02053603          	ld	a2,32(a0)
    80005088:	0005b683          	ld	a3,0(a1)
    8000508c:	00c686b3          	add	a3,a3,a2
    80005090:	00d5b023          	sd	a3,0(a1)
    80005094:	00200593          	li	a1,2
    80005098:	14459073          	csrw	sip,a1
    8000509c:	01053683          	ld	a3,16(a0)
    800050a0:	00853603          	ld	a2,8(a0)
    800050a4:	00053583          	ld	a1,0(a0)
    800050a8:	34051573          	csrrw	a0,mscratch,a0
    800050ac:	30200073          	mret

00000000800050b0 <plicinit>:
    800050b0:	ff010113          	addi	sp,sp,-16
    800050b4:	00813423          	sd	s0,8(sp)
    800050b8:	01010413          	addi	s0,sp,16
    800050bc:	00813403          	ld	s0,8(sp)
    800050c0:	0c0007b7          	lui	a5,0xc000
    800050c4:	00100713          	li	a4,1
    800050c8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800050cc:	00e7a223          	sw	a4,4(a5)
    800050d0:	01010113          	addi	sp,sp,16
    800050d4:	00008067          	ret

00000000800050d8 <plicinithart>:
    800050d8:	ff010113          	addi	sp,sp,-16
    800050dc:	00813023          	sd	s0,0(sp)
    800050e0:	00113423          	sd	ra,8(sp)
    800050e4:	01010413          	addi	s0,sp,16
    800050e8:	00000097          	auipc	ra,0x0
    800050ec:	a44080e7          	jalr	-1468(ra) # 80004b2c <cpuid>
    800050f0:	0085171b          	slliw	a4,a0,0x8
    800050f4:	0c0027b7          	lui	a5,0xc002
    800050f8:	00e787b3          	add	a5,a5,a4
    800050fc:	40200713          	li	a4,1026
    80005100:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005104:	00813083          	ld	ra,8(sp)
    80005108:	00013403          	ld	s0,0(sp)
    8000510c:	00d5151b          	slliw	a0,a0,0xd
    80005110:	0c2017b7          	lui	a5,0xc201
    80005114:	00a78533          	add	a0,a5,a0
    80005118:	00052023          	sw	zero,0(a0)
    8000511c:	01010113          	addi	sp,sp,16
    80005120:	00008067          	ret

0000000080005124 <plic_claim>:
    80005124:	ff010113          	addi	sp,sp,-16
    80005128:	00813023          	sd	s0,0(sp)
    8000512c:	00113423          	sd	ra,8(sp)
    80005130:	01010413          	addi	s0,sp,16
    80005134:	00000097          	auipc	ra,0x0
    80005138:	9f8080e7          	jalr	-1544(ra) # 80004b2c <cpuid>
    8000513c:	00813083          	ld	ra,8(sp)
    80005140:	00013403          	ld	s0,0(sp)
    80005144:	00d5151b          	slliw	a0,a0,0xd
    80005148:	0c2017b7          	lui	a5,0xc201
    8000514c:	00a78533          	add	a0,a5,a0
    80005150:	00452503          	lw	a0,4(a0)
    80005154:	01010113          	addi	sp,sp,16
    80005158:	00008067          	ret

000000008000515c <plic_complete>:
    8000515c:	fe010113          	addi	sp,sp,-32
    80005160:	00813823          	sd	s0,16(sp)
    80005164:	00913423          	sd	s1,8(sp)
    80005168:	00113c23          	sd	ra,24(sp)
    8000516c:	02010413          	addi	s0,sp,32
    80005170:	00050493          	mv	s1,a0
    80005174:	00000097          	auipc	ra,0x0
    80005178:	9b8080e7          	jalr	-1608(ra) # 80004b2c <cpuid>
    8000517c:	01813083          	ld	ra,24(sp)
    80005180:	01013403          	ld	s0,16(sp)
    80005184:	00d5179b          	slliw	a5,a0,0xd
    80005188:	0c201737          	lui	a4,0xc201
    8000518c:	00f707b3          	add	a5,a4,a5
    80005190:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005194:	00813483          	ld	s1,8(sp)
    80005198:	02010113          	addi	sp,sp,32
    8000519c:	00008067          	ret

00000000800051a0 <consolewrite>:
    800051a0:	fb010113          	addi	sp,sp,-80
    800051a4:	04813023          	sd	s0,64(sp)
    800051a8:	04113423          	sd	ra,72(sp)
    800051ac:	02913c23          	sd	s1,56(sp)
    800051b0:	03213823          	sd	s2,48(sp)
    800051b4:	03313423          	sd	s3,40(sp)
    800051b8:	03413023          	sd	s4,32(sp)
    800051bc:	01513c23          	sd	s5,24(sp)
    800051c0:	05010413          	addi	s0,sp,80
    800051c4:	06c05c63          	blez	a2,8000523c <consolewrite+0x9c>
    800051c8:	00060993          	mv	s3,a2
    800051cc:	00050a13          	mv	s4,a0
    800051d0:	00058493          	mv	s1,a1
    800051d4:	00000913          	li	s2,0
    800051d8:	fff00a93          	li	s5,-1
    800051dc:	01c0006f          	j	800051f8 <consolewrite+0x58>
    800051e0:	fbf44503          	lbu	a0,-65(s0)
    800051e4:	0019091b          	addiw	s2,s2,1
    800051e8:	00148493          	addi	s1,s1,1
    800051ec:	00001097          	auipc	ra,0x1
    800051f0:	a9c080e7          	jalr	-1380(ra) # 80005c88 <uartputc>
    800051f4:	03298063          	beq	s3,s2,80005214 <consolewrite+0x74>
    800051f8:	00048613          	mv	a2,s1
    800051fc:	00100693          	li	a3,1
    80005200:	000a0593          	mv	a1,s4
    80005204:	fbf40513          	addi	a0,s0,-65
    80005208:	00000097          	auipc	ra,0x0
    8000520c:	9dc080e7          	jalr	-1572(ra) # 80004be4 <either_copyin>
    80005210:	fd5518e3          	bne	a0,s5,800051e0 <consolewrite+0x40>
    80005214:	04813083          	ld	ra,72(sp)
    80005218:	04013403          	ld	s0,64(sp)
    8000521c:	03813483          	ld	s1,56(sp)
    80005220:	02813983          	ld	s3,40(sp)
    80005224:	02013a03          	ld	s4,32(sp)
    80005228:	01813a83          	ld	s5,24(sp)
    8000522c:	00090513          	mv	a0,s2
    80005230:	03013903          	ld	s2,48(sp)
    80005234:	05010113          	addi	sp,sp,80
    80005238:	00008067          	ret
    8000523c:	00000913          	li	s2,0
    80005240:	fd5ff06f          	j	80005214 <consolewrite+0x74>

0000000080005244 <consoleread>:
    80005244:	f9010113          	addi	sp,sp,-112
    80005248:	06813023          	sd	s0,96(sp)
    8000524c:	04913c23          	sd	s1,88(sp)
    80005250:	05213823          	sd	s2,80(sp)
    80005254:	05313423          	sd	s3,72(sp)
    80005258:	05413023          	sd	s4,64(sp)
    8000525c:	03513c23          	sd	s5,56(sp)
    80005260:	03613823          	sd	s6,48(sp)
    80005264:	03713423          	sd	s7,40(sp)
    80005268:	03813023          	sd	s8,32(sp)
    8000526c:	06113423          	sd	ra,104(sp)
    80005270:	01913c23          	sd	s9,24(sp)
    80005274:	07010413          	addi	s0,sp,112
    80005278:	00060b93          	mv	s7,a2
    8000527c:	00050913          	mv	s2,a0
    80005280:	00058c13          	mv	s8,a1
    80005284:	00060b1b          	sext.w	s6,a2
    80005288:	00005497          	auipc	s1,0x5
    8000528c:	ed048493          	addi	s1,s1,-304 # 8000a158 <cons>
    80005290:	00400993          	li	s3,4
    80005294:	fff00a13          	li	s4,-1
    80005298:	00a00a93          	li	s5,10
    8000529c:	05705e63          	blez	s7,800052f8 <consoleread+0xb4>
    800052a0:	09c4a703          	lw	a4,156(s1)
    800052a4:	0984a783          	lw	a5,152(s1)
    800052a8:	0007071b          	sext.w	a4,a4
    800052ac:	08e78463          	beq	a5,a4,80005334 <consoleread+0xf0>
    800052b0:	07f7f713          	andi	a4,a5,127
    800052b4:	00e48733          	add	a4,s1,a4
    800052b8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800052bc:	0017869b          	addiw	a3,a5,1
    800052c0:	08d4ac23          	sw	a3,152(s1)
    800052c4:	00070c9b          	sext.w	s9,a4
    800052c8:	0b370663          	beq	a4,s3,80005374 <consoleread+0x130>
    800052cc:	00100693          	li	a3,1
    800052d0:	f9f40613          	addi	a2,s0,-97
    800052d4:	000c0593          	mv	a1,s8
    800052d8:	00090513          	mv	a0,s2
    800052dc:	f8e40fa3          	sb	a4,-97(s0)
    800052e0:	00000097          	auipc	ra,0x0
    800052e4:	8b8080e7          	jalr	-1864(ra) # 80004b98 <either_copyout>
    800052e8:	01450863          	beq	a0,s4,800052f8 <consoleread+0xb4>
    800052ec:	001c0c13          	addi	s8,s8,1
    800052f0:	fffb8b9b          	addiw	s7,s7,-1
    800052f4:	fb5c94e3          	bne	s9,s5,8000529c <consoleread+0x58>
    800052f8:	000b851b          	sext.w	a0,s7
    800052fc:	06813083          	ld	ra,104(sp)
    80005300:	06013403          	ld	s0,96(sp)
    80005304:	05813483          	ld	s1,88(sp)
    80005308:	05013903          	ld	s2,80(sp)
    8000530c:	04813983          	ld	s3,72(sp)
    80005310:	04013a03          	ld	s4,64(sp)
    80005314:	03813a83          	ld	s5,56(sp)
    80005318:	02813b83          	ld	s7,40(sp)
    8000531c:	02013c03          	ld	s8,32(sp)
    80005320:	01813c83          	ld	s9,24(sp)
    80005324:	40ab053b          	subw	a0,s6,a0
    80005328:	03013b03          	ld	s6,48(sp)
    8000532c:	07010113          	addi	sp,sp,112
    80005330:	00008067          	ret
    80005334:	00001097          	auipc	ra,0x1
    80005338:	1d8080e7          	jalr	472(ra) # 8000650c <push_on>
    8000533c:	0984a703          	lw	a4,152(s1)
    80005340:	09c4a783          	lw	a5,156(s1)
    80005344:	0007879b          	sext.w	a5,a5
    80005348:	fef70ce3          	beq	a4,a5,80005340 <consoleread+0xfc>
    8000534c:	00001097          	auipc	ra,0x1
    80005350:	234080e7          	jalr	564(ra) # 80006580 <pop_on>
    80005354:	0984a783          	lw	a5,152(s1)
    80005358:	07f7f713          	andi	a4,a5,127
    8000535c:	00e48733          	add	a4,s1,a4
    80005360:	01874703          	lbu	a4,24(a4)
    80005364:	0017869b          	addiw	a3,a5,1
    80005368:	08d4ac23          	sw	a3,152(s1)
    8000536c:	00070c9b          	sext.w	s9,a4
    80005370:	f5371ee3          	bne	a4,s3,800052cc <consoleread+0x88>
    80005374:	000b851b          	sext.w	a0,s7
    80005378:	f96bf2e3          	bgeu	s7,s6,800052fc <consoleread+0xb8>
    8000537c:	08f4ac23          	sw	a5,152(s1)
    80005380:	f7dff06f          	j	800052fc <consoleread+0xb8>

0000000080005384 <consputc>:
    80005384:	10000793          	li	a5,256
    80005388:	00f50663          	beq	a0,a5,80005394 <consputc+0x10>
    8000538c:	00001317          	auipc	t1,0x1
    80005390:	9f430067          	jr	-1548(t1) # 80005d80 <uartputc_sync>
    80005394:	ff010113          	addi	sp,sp,-16
    80005398:	00113423          	sd	ra,8(sp)
    8000539c:	00813023          	sd	s0,0(sp)
    800053a0:	01010413          	addi	s0,sp,16
    800053a4:	00800513          	li	a0,8
    800053a8:	00001097          	auipc	ra,0x1
    800053ac:	9d8080e7          	jalr	-1576(ra) # 80005d80 <uartputc_sync>
    800053b0:	02000513          	li	a0,32
    800053b4:	00001097          	auipc	ra,0x1
    800053b8:	9cc080e7          	jalr	-1588(ra) # 80005d80 <uartputc_sync>
    800053bc:	00013403          	ld	s0,0(sp)
    800053c0:	00813083          	ld	ra,8(sp)
    800053c4:	00800513          	li	a0,8
    800053c8:	01010113          	addi	sp,sp,16
    800053cc:	00001317          	auipc	t1,0x1
    800053d0:	9b430067          	jr	-1612(t1) # 80005d80 <uartputc_sync>

00000000800053d4 <consoleintr>:
    800053d4:	fe010113          	addi	sp,sp,-32
    800053d8:	00813823          	sd	s0,16(sp)
    800053dc:	00913423          	sd	s1,8(sp)
    800053e0:	01213023          	sd	s2,0(sp)
    800053e4:	00113c23          	sd	ra,24(sp)
    800053e8:	02010413          	addi	s0,sp,32
    800053ec:	00005917          	auipc	s2,0x5
    800053f0:	d6c90913          	addi	s2,s2,-660 # 8000a158 <cons>
    800053f4:	00050493          	mv	s1,a0
    800053f8:	00090513          	mv	a0,s2
    800053fc:	00001097          	auipc	ra,0x1
    80005400:	e40080e7          	jalr	-448(ra) # 8000623c <acquire>
    80005404:	02048c63          	beqz	s1,8000543c <consoleintr+0x68>
    80005408:	0a092783          	lw	a5,160(s2)
    8000540c:	09892703          	lw	a4,152(s2)
    80005410:	07f00693          	li	a3,127
    80005414:	40e7873b          	subw	a4,a5,a4
    80005418:	02e6e263          	bltu	a3,a4,8000543c <consoleintr+0x68>
    8000541c:	00d00713          	li	a4,13
    80005420:	04e48063          	beq	s1,a4,80005460 <consoleintr+0x8c>
    80005424:	07f7f713          	andi	a4,a5,127
    80005428:	00e90733          	add	a4,s2,a4
    8000542c:	0017879b          	addiw	a5,a5,1
    80005430:	0af92023          	sw	a5,160(s2)
    80005434:	00970c23          	sb	s1,24(a4)
    80005438:	08f92e23          	sw	a5,156(s2)
    8000543c:	01013403          	ld	s0,16(sp)
    80005440:	01813083          	ld	ra,24(sp)
    80005444:	00813483          	ld	s1,8(sp)
    80005448:	00013903          	ld	s2,0(sp)
    8000544c:	00005517          	auipc	a0,0x5
    80005450:	d0c50513          	addi	a0,a0,-756 # 8000a158 <cons>
    80005454:	02010113          	addi	sp,sp,32
    80005458:	00001317          	auipc	t1,0x1
    8000545c:	eb030067          	jr	-336(t1) # 80006308 <release>
    80005460:	00a00493          	li	s1,10
    80005464:	fc1ff06f          	j	80005424 <consoleintr+0x50>

0000000080005468 <consoleinit>:
    80005468:	fe010113          	addi	sp,sp,-32
    8000546c:	00113c23          	sd	ra,24(sp)
    80005470:	00813823          	sd	s0,16(sp)
    80005474:	00913423          	sd	s1,8(sp)
    80005478:	02010413          	addi	s0,sp,32
    8000547c:	00005497          	auipc	s1,0x5
    80005480:	cdc48493          	addi	s1,s1,-804 # 8000a158 <cons>
    80005484:	00048513          	mv	a0,s1
    80005488:	00002597          	auipc	a1,0x2
    8000548c:	f9858593          	addi	a1,a1,-104 # 80007420 <CONSOLE_STATUS+0x410>
    80005490:	00001097          	auipc	ra,0x1
    80005494:	d88080e7          	jalr	-632(ra) # 80006218 <initlock>
    80005498:	00000097          	auipc	ra,0x0
    8000549c:	7ac080e7          	jalr	1964(ra) # 80005c44 <uartinit>
    800054a0:	01813083          	ld	ra,24(sp)
    800054a4:	01013403          	ld	s0,16(sp)
    800054a8:	00000797          	auipc	a5,0x0
    800054ac:	d9c78793          	addi	a5,a5,-612 # 80005244 <consoleread>
    800054b0:	0af4bc23          	sd	a5,184(s1)
    800054b4:	00000797          	auipc	a5,0x0
    800054b8:	cec78793          	addi	a5,a5,-788 # 800051a0 <consolewrite>
    800054bc:	0cf4b023          	sd	a5,192(s1)
    800054c0:	00813483          	ld	s1,8(sp)
    800054c4:	02010113          	addi	sp,sp,32
    800054c8:	00008067          	ret

00000000800054cc <console_read>:
    800054cc:	ff010113          	addi	sp,sp,-16
    800054d0:	00813423          	sd	s0,8(sp)
    800054d4:	01010413          	addi	s0,sp,16
    800054d8:	00813403          	ld	s0,8(sp)
    800054dc:	00005317          	auipc	t1,0x5
    800054e0:	d3433303          	ld	t1,-716(t1) # 8000a210 <devsw+0x10>
    800054e4:	01010113          	addi	sp,sp,16
    800054e8:	00030067          	jr	t1

00000000800054ec <console_write>:
    800054ec:	ff010113          	addi	sp,sp,-16
    800054f0:	00813423          	sd	s0,8(sp)
    800054f4:	01010413          	addi	s0,sp,16
    800054f8:	00813403          	ld	s0,8(sp)
    800054fc:	00005317          	auipc	t1,0x5
    80005500:	d1c33303          	ld	t1,-740(t1) # 8000a218 <devsw+0x18>
    80005504:	01010113          	addi	sp,sp,16
    80005508:	00030067          	jr	t1

000000008000550c <panic>:
    8000550c:	fe010113          	addi	sp,sp,-32
    80005510:	00113c23          	sd	ra,24(sp)
    80005514:	00813823          	sd	s0,16(sp)
    80005518:	00913423          	sd	s1,8(sp)
    8000551c:	02010413          	addi	s0,sp,32
    80005520:	00050493          	mv	s1,a0
    80005524:	00002517          	auipc	a0,0x2
    80005528:	f0450513          	addi	a0,a0,-252 # 80007428 <CONSOLE_STATUS+0x418>
    8000552c:	00005797          	auipc	a5,0x5
    80005530:	d807a623          	sw	zero,-628(a5) # 8000a2b8 <pr+0x18>
    80005534:	00000097          	auipc	ra,0x0
    80005538:	034080e7          	jalr	52(ra) # 80005568 <__printf>
    8000553c:	00048513          	mv	a0,s1
    80005540:	00000097          	auipc	ra,0x0
    80005544:	028080e7          	jalr	40(ra) # 80005568 <__printf>
    80005548:	00002517          	auipc	a0,0x2
    8000554c:	d8850513          	addi	a0,a0,-632 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80005550:	00000097          	auipc	ra,0x0
    80005554:	018080e7          	jalr	24(ra) # 80005568 <__printf>
    80005558:	00100793          	li	a5,1
    8000555c:	00004717          	auipc	a4,0x4
    80005560:	9ef72e23          	sw	a5,-1540(a4) # 80008f58 <panicked>
    80005564:	0000006f          	j	80005564 <panic+0x58>

0000000080005568 <__printf>:
    80005568:	f3010113          	addi	sp,sp,-208
    8000556c:	08813023          	sd	s0,128(sp)
    80005570:	07313423          	sd	s3,104(sp)
    80005574:	09010413          	addi	s0,sp,144
    80005578:	05813023          	sd	s8,64(sp)
    8000557c:	08113423          	sd	ra,136(sp)
    80005580:	06913c23          	sd	s1,120(sp)
    80005584:	07213823          	sd	s2,112(sp)
    80005588:	07413023          	sd	s4,96(sp)
    8000558c:	05513c23          	sd	s5,88(sp)
    80005590:	05613823          	sd	s6,80(sp)
    80005594:	05713423          	sd	s7,72(sp)
    80005598:	03913c23          	sd	s9,56(sp)
    8000559c:	03a13823          	sd	s10,48(sp)
    800055a0:	03b13423          	sd	s11,40(sp)
    800055a4:	00005317          	auipc	t1,0x5
    800055a8:	cfc30313          	addi	t1,t1,-772 # 8000a2a0 <pr>
    800055ac:	01832c03          	lw	s8,24(t1)
    800055b0:	00b43423          	sd	a1,8(s0)
    800055b4:	00c43823          	sd	a2,16(s0)
    800055b8:	00d43c23          	sd	a3,24(s0)
    800055bc:	02e43023          	sd	a4,32(s0)
    800055c0:	02f43423          	sd	a5,40(s0)
    800055c4:	03043823          	sd	a6,48(s0)
    800055c8:	03143c23          	sd	a7,56(s0)
    800055cc:	00050993          	mv	s3,a0
    800055d0:	4a0c1663          	bnez	s8,80005a7c <__printf+0x514>
    800055d4:	60098c63          	beqz	s3,80005bec <__printf+0x684>
    800055d8:	0009c503          	lbu	a0,0(s3)
    800055dc:	00840793          	addi	a5,s0,8
    800055e0:	f6f43c23          	sd	a5,-136(s0)
    800055e4:	00000493          	li	s1,0
    800055e8:	22050063          	beqz	a0,80005808 <__printf+0x2a0>
    800055ec:	00002a37          	lui	s4,0x2
    800055f0:	00018ab7          	lui	s5,0x18
    800055f4:	000f4b37          	lui	s6,0xf4
    800055f8:	00989bb7          	lui	s7,0x989
    800055fc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005600:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005604:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005608:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000560c:	00148c9b          	addiw	s9,s1,1
    80005610:	02500793          	li	a5,37
    80005614:	01998933          	add	s2,s3,s9
    80005618:	38f51263          	bne	a0,a5,8000599c <__printf+0x434>
    8000561c:	00094783          	lbu	a5,0(s2)
    80005620:	00078c9b          	sext.w	s9,a5
    80005624:	1e078263          	beqz	a5,80005808 <__printf+0x2a0>
    80005628:	0024849b          	addiw	s1,s1,2
    8000562c:	07000713          	li	a4,112
    80005630:	00998933          	add	s2,s3,s1
    80005634:	38e78a63          	beq	a5,a4,800059c8 <__printf+0x460>
    80005638:	20f76863          	bltu	a4,a5,80005848 <__printf+0x2e0>
    8000563c:	42a78863          	beq	a5,a0,80005a6c <__printf+0x504>
    80005640:	06400713          	li	a4,100
    80005644:	40e79663          	bne	a5,a4,80005a50 <__printf+0x4e8>
    80005648:	f7843783          	ld	a5,-136(s0)
    8000564c:	0007a603          	lw	a2,0(a5)
    80005650:	00878793          	addi	a5,a5,8
    80005654:	f6f43c23          	sd	a5,-136(s0)
    80005658:	42064a63          	bltz	a2,80005a8c <__printf+0x524>
    8000565c:	00a00713          	li	a4,10
    80005660:	02e677bb          	remuw	a5,a2,a4
    80005664:	00002d97          	auipc	s11,0x2
    80005668:	decd8d93          	addi	s11,s11,-532 # 80007450 <digits>
    8000566c:	00900593          	li	a1,9
    80005670:	0006051b          	sext.w	a0,a2
    80005674:	00000c93          	li	s9,0
    80005678:	02079793          	slli	a5,a5,0x20
    8000567c:	0207d793          	srli	a5,a5,0x20
    80005680:	00fd87b3          	add	a5,s11,a5
    80005684:	0007c783          	lbu	a5,0(a5)
    80005688:	02e656bb          	divuw	a3,a2,a4
    8000568c:	f8f40023          	sb	a5,-128(s0)
    80005690:	14c5d863          	bge	a1,a2,800057e0 <__printf+0x278>
    80005694:	06300593          	li	a1,99
    80005698:	00100c93          	li	s9,1
    8000569c:	02e6f7bb          	remuw	a5,a3,a4
    800056a0:	02079793          	slli	a5,a5,0x20
    800056a4:	0207d793          	srli	a5,a5,0x20
    800056a8:	00fd87b3          	add	a5,s11,a5
    800056ac:	0007c783          	lbu	a5,0(a5)
    800056b0:	02e6d73b          	divuw	a4,a3,a4
    800056b4:	f8f400a3          	sb	a5,-127(s0)
    800056b8:	12a5f463          	bgeu	a1,a0,800057e0 <__printf+0x278>
    800056bc:	00a00693          	li	a3,10
    800056c0:	00900593          	li	a1,9
    800056c4:	02d777bb          	remuw	a5,a4,a3
    800056c8:	02079793          	slli	a5,a5,0x20
    800056cc:	0207d793          	srli	a5,a5,0x20
    800056d0:	00fd87b3          	add	a5,s11,a5
    800056d4:	0007c503          	lbu	a0,0(a5)
    800056d8:	02d757bb          	divuw	a5,a4,a3
    800056dc:	f8a40123          	sb	a0,-126(s0)
    800056e0:	48e5f263          	bgeu	a1,a4,80005b64 <__printf+0x5fc>
    800056e4:	06300513          	li	a0,99
    800056e8:	02d7f5bb          	remuw	a1,a5,a3
    800056ec:	02059593          	slli	a1,a1,0x20
    800056f0:	0205d593          	srli	a1,a1,0x20
    800056f4:	00bd85b3          	add	a1,s11,a1
    800056f8:	0005c583          	lbu	a1,0(a1)
    800056fc:	02d7d7bb          	divuw	a5,a5,a3
    80005700:	f8b401a3          	sb	a1,-125(s0)
    80005704:	48e57263          	bgeu	a0,a4,80005b88 <__printf+0x620>
    80005708:	3e700513          	li	a0,999
    8000570c:	02d7f5bb          	remuw	a1,a5,a3
    80005710:	02059593          	slli	a1,a1,0x20
    80005714:	0205d593          	srli	a1,a1,0x20
    80005718:	00bd85b3          	add	a1,s11,a1
    8000571c:	0005c583          	lbu	a1,0(a1)
    80005720:	02d7d7bb          	divuw	a5,a5,a3
    80005724:	f8b40223          	sb	a1,-124(s0)
    80005728:	46e57663          	bgeu	a0,a4,80005b94 <__printf+0x62c>
    8000572c:	02d7f5bb          	remuw	a1,a5,a3
    80005730:	02059593          	slli	a1,a1,0x20
    80005734:	0205d593          	srli	a1,a1,0x20
    80005738:	00bd85b3          	add	a1,s11,a1
    8000573c:	0005c583          	lbu	a1,0(a1)
    80005740:	02d7d7bb          	divuw	a5,a5,a3
    80005744:	f8b402a3          	sb	a1,-123(s0)
    80005748:	46ea7863          	bgeu	s4,a4,80005bb8 <__printf+0x650>
    8000574c:	02d7f5bb          	remuw	a1,a5,a3
    80005750:	02059593          	slli	a1,a1,0x20
    80005754:	0205d593          	srli	a1,a1,0x20
    80005758:	00bd85b3          	add	a1,s11,a1
    8000575c:	0005c583          	lbu	a1,0(a1)
    80005760:	02d7d7bb          	divuw	a5,a5,a3
    80005764:	f8b40323          	sb	a1,-122(s0)
    80005768:	3eeaf863          	bgeu	s5,a4,80005b58 <__printf+0x5f0>
    8000576c:	02d7f5bb          	remuw	a1,a5,a3
    80005770:	02059593          	slli	a1,a1,0x20
    80005774:	0205d593          	srli	a1,a1,0x20
    80005778:	00bd85b3          	add	a1,s11,a1
    8000577c:	0005c583          	lbu	a1,0(a1)
    80005780:	02d7d7bb          	divuw	a5,a5,a3
    80005784:	f8b403a3          	sb	a1,-121(s0)
    80005788:	42eb7e63          	bgeu	s6,a4,80005bc4 <__printf+0x65c>
    8000578c:	02d7f5bb          	remuw	a1,a5,a3
    80005790:	02059593          	slli	a1,a1,0x20
    80005794:	0205d593          	srli	a1,a1,0x20
    80005798:	00bd85b3          	add	a1,s11,a1
    8000579c:	0005c583          	lbu	a1,0(a1)
    800057a0:	02d7d7bb          	divuw	a5,a5,a3
    800057a4:	f8b40423          	sb	a1,-120(s0)
    800057a8:	42ebfc63          	bgeu	s7,a4,80005be0 <__printf+0x678>
    800057ac:	02079793          	slli	a5,a5,0x20
    800057b0:	0207d793          	srli	a5,a5,0x20
    800057b4:	00fd8db3          	add	s11,s11,a5
    800057b8:	000dc703          	lbu	a4,0(s11)
    800057bc:	00a00793          	li	a5,10
    800057c0:	00900c93          	li	s9,9
    800057c4:	f8e404a3          	sb	a4,-119(s0)
    800057c8:	00065c63          	bgez	a2,800057e0 <__printf+0x278>
    800057cc:	f9040713          	addi	a4,s0,-112
    800057d0:	00f70733          	add	a4,a4,a5
    800057d4:	02d00693          	li	a3,45
    800057d8:	fed70823          	sb	a3,-16(a4)
    800057dc:	00078c93          	mv	s9,a5
    800057e0:	f8040793          	addi	a5,s0,-128
    800057e4:	01978cb3          	add	s9,a5,s9
    800057e8:	f7f40d13          	addi	s10,s0,-129
    800057ec:	000cc503          	lbu	a0,0(s9)
    800057f0:	fffc8c93          	addi	s9,s9,-1
    800057f4:	00000097          	auipc	ra,0x0
    800057f8:	b90080e7          	jalr	-1136(ra) # 80005384 <consputc>
    800057fc:	ffac98e3          	bne	s9,s10,800057ec <__printf+0x284>
    80005800:	00094503          	lbu	a0,0(s2)
    80005804:	e00514e3          	bnez	a0,8000560c <__printf+0xa4>
    80005808:	1a0c1663          	bnez	s8,800059b4 <__printf+0x44c>
    8000580c:	08813083          	ld	ra,136(sp)
    80005810:	08013403          	ld	s0,128(sp)
    80005814:	07813483          	ld	s1,120(sp)
    80005818:	07013903          	ld	s2,112(sp)
    8000581c:	06813983          	ld	s3,104(sp)
    80005820:	06013a03          	ld	s4,96(sp)
    80005824:	05813a83          	ld	s5,88(sp)
    80005828:	05013b03          	ld	s6,80(sp)
    8000582c:	04813b83          	ld	s7,72(sp)
    80005830:	04013c03          	ld	s8,64(sp)
    80005834:	03813c83          	ld	s9,56(sp)
    80005838:	03013d03          	ld	s10,48(sp)
    8000583c:	02813d83          	ld	s11,40(sp)
    80005840:	0d010113          	addi	sp,sp,208
    80005844:	00008067          	ret
    80005848:	07300713          	li	a4,115
    8000584c:	1ce78a63          	beq	a5,a4,80005a20 <__printf+0x4b8>
    80005850:	07800713          	li	a4,120
    80005854:	1ee79e63          	bne	a5,a4,80005a50 <__printf+0x4e8>
    80005858:	f7843783          	ld	a5,-136(s0)
    8000585c:	0007a703          	lw	a4,0(a5)
    80005860:	00878793          	addi	a5,a5,8
    80005864:	f6f43c23          	sd	a5,-136(s0)
    80005868:	28074263          	bltz	a4,80005aec <__printf+0x584>
    8000586c:	00002d97          	auipc	s11,0x2
    80005870:	be4d8d93          	addi	s11,s11,-1052 # 80007450 <digits>
    80005874:	00f77793          	andi	a5,a4,15
    80005878:	00fd87b3          	add	a5,s11,a5
    8000587c:	0007c683          	lbu	a3,0(a5)
    80005880:	00f00613          	li	a2,15
    80005884:	0007079b          	sext.w	a5,a4
    80005888:	f8d40023          	sb	a3,-128(s0)
    8000588c:	0047559b          	srliw	a1,a4,0x4
    80005890:	0047569b          	srliw	a3,a4,0x4
    80005894:	00000c93          	li	s9,0
    80005898:	0ee65063          	bge	a2,a4,80005978 <__printf+0x410>
    8000589c:	00f6f693          	andi	a3,a3,15
    800058a0:	00dd86b3          	add	a3,s11,a3
    800058a4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800058a8:	0087d79b          	srliw	a5,a5,0x8
    800058ac:	00100c93          	li	s9,1
    800058b0:	f8d400a3          	sb	a3,-127(s0)
    800058b4:	0cb67263          	bgeu	a2,a1,80005978 <__printf+0x410>
    800058b8:	00f7f693          	andi	a3,a5,15
    800058bc:	00dd86b3          	add	a3,s11,a3
    800058c0:	0006c583          	lbu	a1,0(a3)
    800058c4:	00f00613          	li	a2,15
    800058c8:	0047d69b          	srliw	a3,a5,0x4
    800058cc:	f8b40123          	sb	a1,-126(s0)
    800058d0:	0047d593          	srli	a1,a5,0x4
    800058d4:	28f67e63          	bgeu	a2,a5,80005b70 <__printf+0x608>
    800058d8:	00f6f693          	andi	a3,a3,15
    800058dc:	00dd86b3          	add	a3,s11,a3
    800058e0:	0006c503          	lbu	a0,0(a3)
    800058e4:	0087d813          	srli	a6,a5,0x8
    800058e8:	0087d69b          	srliw	a3,a5,0x8
    800058ec:	f8a401a3          	sb	a0,-125(s0)
    800058f0:	28b67663          	bgeu	a2,a1,80005b7c <__printf+0x614>
    800058f4:	00f6f693          	andi	a3,a3,15
    800058f8:	00dd86b3          	add	a3,s11,a3
    800058fc:	0006c583          	lbu	a1,0(a3)
    80005900:	00c7d513          	srli	a0,a5,0xc
    80005904:	00c7d69b          	srliw	a3,a5,0xc
    80005908:	f8b40223          	sb	a1,-124(s0)
    8000590c:	29067a63          	bgeu	a2,a6,80005ba0 <__printf+0x638>
    80005910:	00f6f693          	andi	a3,a3,15
    80005914:	00dd86b3          	add	a3,s11,a3
    80005918:	0006c583          	lbu	a1,0(a3)
    8000591c:	0107d813          	srli	a6,a5,0x10
    80005920:	0107d69b          	srliw	a3,a5,0x10
    80005924:	f8b402a3          	sb	a1,-123(s0)
    80005928:	28a67263          	bgeu	a2,a0,80005bac <__printf+0x644>
    8000592c:	00f6f693          	andi	a3,a3,15
    80005930:	00dd86b3          	add	a3,s11,a3
    80005934:	0006c683          	lbu	a3,0(a3)
    80005938:	0147d79b          	srliw	a5,a5,0x14
    8000593c:	f8d40323          	sb	a3,-122(s0)
    80005940:	21067663          	bgeu	a2,a6,80005b4c <__printf+0x5e4>
    80005944:	02079793          	slli	a5,a5,0x20
    80005948:	0207d793          	srli	a5,a5,0x20
    8000594c:	00fd8db3          	add	s11,s11,a5
    80005950:	000dc683          	lbu	a3,0(s11)
    80005954:	00800793          	li	a5,8
    80005958:	00700c93          	li	s9,7
    8000595c:	f8d403a3          	sb	a3,-121(s0)
    80005960:	00075c63          	bgez	a4,80005978 <__printf+0x410>
    80005964:	f9040713          	addi	a4,s0,-112
    80005968:	00f70733          	add	a4,a4,a5
    8000596c:	02d00693          	li	a3,45
    80005970:	fed70823          	sb	a3,-16(a4)
    80005974:	00078c93          	mv	s9,a5
    80005978:	f8040793          	addi	a5,s0,-128
    8000597c:	01978cb3          	add	s9,a5,s9
    80005980:	f7f40d13          	addi	s10,s0,-129
    80005984:	000cc503          	lbu	a0,0(s9)
    80005988:	fffc8c93          	addi	s9,s9,-1
    8000598c:	00000097          	auipc	ra,0x0
    80005990:	9f8080e7          	jalr	-1544(ra) # 80005384 <consputc>
    80005994:	ff9d18e3          	bne	s10,s9,80005984 <__printf+0x41c>
    80005998:	0100006f          	j	800059a8 <__printf+0x440>
    8000599c:	00000097          	auipc	ra,0x0
    800059a0:	9e8080e7          	jalr	-1560(ra) # 80005384 <consputc>
    800059a4:	000c8493          	mv	s1,s9
    800059a8:	00094503          	lbu	a0,0(s2)
    800059ac:	c60510e3          	bnez	a0,8000560c <__printf+0xa4>
    800059b0:	e40c0ee3          	beqz	s8,8000580c <__printf+0x2a4>
    800059b4:	00005517          	auipc	a0,0x5
    800059b8:	8ec50513          	addi	a0,a0,-1812 # 8000a2a0 <pr>
    800059bc:	00001097          	auipc	ra,0x1
    800059c0:	94c080e7          	jalr	-1716(ra) # 80006308 <release>
    800059c4:	e49ff06f          	j	8000580c <__printf+0x2a4>
    800059c8:	f7843783          	ld	a5,-136(s0)
    800059cc:	03000513          	li	a0,48
    800059d0:	01000d13          	li	s10,16
    800059d4:	00878713          	addi	a4,a5,8
    800059d8:	0007bc83          	ld	s9,0(a5)
    800059dc:	f6e43c23          	sd	a4,-136(s0)
    800059e0:	00000097          	auipc	ra,0x0
    800059e4:	9a4080e7          	jalr	-1628(ra) # 80005384 <consputc>
    800059e8:	07800513          	li	a0,120
    800059ec:	00000097          	auipc	ra,0x0
    800059f0:	998080e7          	jalr	-1640(ra) # 80005384 <consputc>
    800059f4:	00002d97          	auipc	s11,0x2
    800059f8:	a5cd8d93          	addi	s11,s11,-1444 # 80007450 <digits>
    800059fc:	03ccd793          	srli	a5,s9,0x3c
    80005a00:	00fd87b3          	add	a5,s11,a5
    80005a04:	0007c503          	lbu	a0,0(a5)
    80005a08:	fffd0d1b          	addiw	s10,s10,-1
    80005a0c:	004c9c93          	slli	s9,s9,0x4
    80005a10:	00000097          	auipc	ra,0x0
    80005a14:	974080e7          	jalr	-1676(ra) # 80005384 <consputc>
    80005a18:	fe0d12e3          	bnez	s10,800059fc <__printf+0x494>
    80005a1c:	f8dff06f          	j	800059a8 <__printf+0x440>
    80005a20:	f7843783          	ld	a5,-136(s0)
    80005a24:	0007bc83          	ld	s9,0(a5)
    80005a28:	00878793          	addi	a5,a5,8
    80005a2c:	f6f43c23          	sd	a5,-136(s0)
    80005a30:	000c9a63          	bnez	s9,80005a44 <__printf+0x4dc>
    80005a34:	1080006f          	j	80005b3c <__printf+0x5d4>
    80005a38:	001c8c93          	addi	s9,s9,1
    80005a3c:	00000097          	auipc	ra,0x0
    80005a40:	948080e7          	jalr	-1720(ra) # 80005384 <consputc>
    80005a44:	000cc503          	lbu	a0,0(s9)
    80005a48:	fe0518e3          	bnez	a0,80005a38 <__printf+0x4d0>
    80005a4c:	f5dff06f          	j	800059a8 <__printf+0x440>
    80005a50:	02500513          	li	a0,37
    80005a54:	00000097          	auipc	ra,0x0
    80005a58:	930080e7          	jalr	-1744(ra) # 80005384 <consputc>
    80005a5c:	000c8513          	mv	a0,s9
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	924080e7          	jalr	-1756(ra) # 80005384 <consputc>
    80005a68:	f41ff06f          	j	800059a8 <__printf+0x440>
    80005a6c:	02500513          	li	a0,37
    80005a70:	00000097          	auipc	ra,0x0
    80005a74:	914080e7          	jalr	-1772(ra) # 80005384 <consputc>
    80005a78:	f31ff06f          	j	800059a8 <__printf+0x440>
    80005a7c:	00030513          	mv	a0,t1
    80005a80:	00000097          	auipc	ra,0x0
    80005a84:	7bc080e7          	jalr	1980(ra) # 8000623c <acquire>
    80005a88:	b4dff06f          	j	800055d4 <__printf+0x6c>
    80005a8c:	40c0053b          	negw	a0,a2
    80005a90:	00a00713          	li	a4,10
    80005a94:	02e576bb          	remuw	a3,a0,a4
    80005a98:	00002d97          	auipc	s11,0x2
    80005a9c:	9b8d8d93          	addi	s11,s11,-1608 # 80007450 <digits>
    80005aa0:	ff700593          	li	a1,-9
    80005aa4:	02069693          	slli	a3,a3,0x20
    80005aa8:	0206d693          	srli	a3,a3,0x20
    80005aac:	00dd86b3          	add	a3,s11,a3
    80005ab0:	0006c683          	lbu	a3,0(a3)
    80005ab4:	02e557bb          	divuw	a5,a0,a4
    80005ab8:	f8d40023          	sb	a3,-128(s0)
    80005abc:	10b65e63          	bge	a2,a1,80005bd8 <__printf+0x670>
    80005ac0:	06300593          	li	a1,99
    80005ac4:	02e7f6bb          	remuw	a3,a5,a4
    80005ac8:	02069693          	slli	a3,a3,0x20
    80005acc:	0206d693          	srli	a3,a3,0x20
    80005ad0:	00dd86b3          	add	a3,s11,a3
    80005ad4:	0006c683          	lbu	a3,0(a3)
    80005ad8:	02e7d73b          	divuw	a4,a5,a4
    80005adc:	00200793          	li	a5,2
    80005ae0:	f8d400a3          	sb	a3,-127(s0)
    80005ae4:	bca5ece3          	bltu	a1,a0,800056bc <__printf+0x154>
    80005ae8:	ce5ff06f          	j	800057cc <__printf+0x264>
    80005aec:	40e007bb          	negw	a5,a4
    80005af0:	00002d97          	auipc	s11,0x2
    80005af4:	960d8d93          	addi	s11,s11,-1696 # 80007450 <digits>
    80005af8:	00f7f693          	andi	a3,a5,15
    80005afc:	00dd86b3          	add	a3,s11,a3
    80005b00:	0006c583          	lbu	a1,0(a3)
    80005b04:	ff100613          	li	a2,-15
    80005b08:	0047d69b          	srliw	a3,a5,0x4
    80005b0c:	f8b40023          	sb	a1,-128(s0)
    80005b10:	0047d59b          	srliw	a1,a5,0x4
    80005b14:	0ac75e63          	bge	a4,a2,80005bd0 <__printf+0x668>
    80005b18:	00f6f693          	andi	a3,a3,15
    80005b1c:	00dd86b3          	add	a3,s11,a3
    80005b20:	0006c603          	lbu	a2,0(a3)
    80005b24:	00f00693          	li	a3,15
    80005b28:	0087d79b          	srliw	a5,a5,0x8
    80005b2c:	f8c400a3          	sb	a2,-127(s0)
    80005b30:	d8b6e4e3          	bltu	a3,a1,800058b8 <__printf+0x350>
    80005b34:	00200793          	li	a5,2
    80005b38:	e2dff06f          	j	80005964 <__printf+0x3fc>
    80005b3c:	00002c97          	auipc	s9,0x2
    80005b40:	8f4c8c93          	addi	s9,s9,-1804 # 80007430 <CONSOLE_STATUS+0x420>
    80005b44:	02800513          	li	a0,40
    80005b48:	ef1ff06f          	j	80005a38 <__printf+0x4d0>
    80005b4c:	00700793          	li	a5,7
    80005b50:	00600c93          	li	s9,6
    80005b54:	e0dff06f          	j	80005960 <__printf+0x3f8>
    80005b58:	00700793          	li	a5,7
    80005b5c:	00600c93          	li	s9,6
    80005b60:	c69ff06f          	j	800057c8 <__printf+0x260>
    80005b64:	00300793          	li	a5,3
    80005b68:	00200c93          	li	s9,2
    80005b6c:	c5dff06f          	j	800057c8 <__printf+0x260>
    80005b70:	00300793          	li	a5,3
    80005b74:	00200c93          	li	s9,2
    80005b78:	de9ff06f          	j	80005960 <__printf+0x3f8>
    80005b7c:	00400793          	li	a5,4
    80005b80:	00300c93          	li	s9,3
    80005b84:	dddff06f          	j	80005960 <__printf+0x3f8>
    80005b88:	00400793          	li	a5,4
    80005b8c:	00300c93          	li	s9,3
    80005b90:	c39ff06f          	j	800057c8 <__printf+0x260>
    80005b94:	00500793          	li	a5,5
    80005b98:	00400c93          	li	s9,4
    80005b9c:	c2dff06f          	j	800057c8 <__printf+0x260>
    80005ba0:	00500793          	li	a5,5
    80005ba4:	00400c93          	li	s9,4
    80005ba8:	db9ff06f          	j	80005960 <__printf+0x3f8>
    80005bac:	00600793          	li	a5,6
    80005bb0:	00500c93          	li	s9,5
    80005bb4:	dadff06f          	j	80005960 <__printf+0x3f8>
    80005bb8:	00600793          	li	a5,6
    80005bbc:	00500c93          	li	s9,5
    80005bc0:	c09ff06f          	j	800057c8 <__printf+0x260>
    80005bc4:	00800793          	li	a5,8
    80005bc8:	00700c93          	li	s9,7
    80005bcc:	bfdff06f          	j	800057c8 <__printf+0x260>
    80005bd0:	00100793          	li	a5,1
    80005bd4:	d91ff06f          	j	80005964 <__printf+0x3fc>
    80005bd8:	00100793          	li	a5,1
    80005bdc:	bf1ff06f          	j	800057cc <__printf+0x264>
    80005be0:	00900793          	li	a5,9
    80005be4:	00800c93          	li	s9,8
    80005be8:	be1ff06f          	j	800057c8 <__printf+0x260>
    80005bec:	00002517          	auipc	a0,0x2
    80005bf0:	84c50513          	addi	a0,a0,-1972 # 80007438 <CONSOLE_STATUS+0x428>
    80005bf4:	00000097          	auipc	ra,0x0
    80005bf8:	918080e7          	jalr	-1768(ra) # 8000550c <panic>

0000000080005bfc <printfinit>:
    80005bfc:	fe010113          	addi	sp,sp,-32
    80005c00:	00813823          	sd	s0,16(sp)
    80005c04:	00913423          	sd	s1,8(sp)
    80005c08:	00113c23          	sd	ra,24(sp)
    80005c0c:	02010413          	addi	s0,sp,32
    80005c10:	00004497          	auipc	s1,0x4
    80005c14:	69048493          	addi	s1,s1,1680 # 8000a2a0 <pr>
    80005c18:	00048513          	mv	a0,s1
    80005c1c:	00002597          	auipc	a1,0x2
    80005c20:	82c58593          	addi	a1,a1,-2004 # 80007448 <CONSOLE_STATUS+0x438>
    80005c24:	00000097          	auipc	ra,0x0
    80005c28:	5f4080e7          	jalr	1524(ra) # 80006218 <initlock>
    80005c2c:	01813083          	ld	ra,24(sp)
    80005c30:	01013403          	ld	s0,16(sp)
    80005c34:	0004ac23          	sw	zero,24(s1)
    80005c38:	00813483          	ld	s1,8(sp)
    80005c3c:	02010113          	addi	sp,sp,32
    80005c40:	00008067          	ret

0000000080005c44 <uartinit>:
    80005c44:	ff010113          	addi	sp,sp,-16
    80005c48:	00813423          	sd	s0,8(sp)
    80005c4c:	01010413          	addi	s0,sp,16
    80005c50:	100007b7          	lui	a5,0x10000
    80005c54:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005c58:	f8000713          	li	a4,-128
    80005c5c:	00e781a3          	sb	a4,3(a5)
    80005c60:	00300713          	li	a4,3
    80005c64:	00e78023          	sb	a4,0(a5)
    80005c68:	000780a3          	sb	zero,1(a5)
    80005c6c:	00e781a3          	sb	a4,3(a5)
    80005c70:	00700693          	li	a3,7
    80005c74:	00d78123          	sb	a3,2(a5)
    80005c78:	00e780a3          	sb	a4,1(a5)
    80005c7c:	00813403          	ld	s0,8(sp)
    80005c80:	01010113          	addi	sp,sp,16
    80005c84:	00008067          	ret

0000000080005c88 <uartputc>:
    80005c88:	00003797          	auipc	a5,0x3
    80005c8c:	2d07a783          	lw	a5,720(a5) # 80008f58 <panicked>
    80005c90:	00078463          	beqz	a5,80005c98 <uartputc+0x10>
    80005c94:	0000006f          	j	80005c94 <uartputc+0xc>
    80005c98:	fd010113          	addi	sp,sp,-48
    80005c9c:	02813023          	sd	s0,32(sp)
    80005ca0:	00913c23          	sd	s1,24(sp)
    80005ca4:	01213823          	sd	s2,16(sp)
    80005ca8:	01313423          	sd	s3,8(sp)
    80005cac:	02113423          	sd	ra,40(sp)
    80005cb0:	03010413          	addi	s0,sp,48
    80005cb4:	00003917          	auipc	s2,0x3
    80005cb8:	2ac90913          	addi	s2,s2,684 # 80008f60 <uart_tx_r>
    80005cbc:	00093783          	ld	a5,0(s2)
    80005cc0:	00003497          	auipc	s1,0x3
    80005cc4:	2a848493          	addi	s1,s1,680 # 80008f68 <uart_tx_w>
    80005cc8:	0004b703          	ld	a4,0(s1)
    80005ccc:	02078693          	addi	a3,a5,32
    80005cd0:	00050993          	mv	s3,a0
    80005cd4:	02e69c63          	bne	a3,a4,80005d0c <uartputc+0x84>
    80005cd8:	00001097          	auipc	ra,0x1
    80005cdc:	834080e7          	jalr	-1996(ra) # 8000650c <push_on>
    80005ce0:	00093783          	ld	a5,0(s2)
    80005ce4:	0004b703          	ld	a4,0(s1)
    80005ce8:	02078793          	addi	a5,a5,32
    80005cec:	00e79463          	bne	a5,a4,80005cf4 <uartputc+0x6c>
    80005cf0:	0000006f          	j	80005cf0 <uartputc+0x68>
    80005cf4:	00001097          	auipc	ra,0x1
    80005cf8:	88c080e7          	jalr	-1908(ra) # 80006580 <pop_on>
    80005cfc:	00093783          	ld	a5,0(s2)
    80005d00:	0004b703          	ld	a4,0(s1)
    80005d04:	02078693          	addi	a3,a5,32
    80005d08:	fce688e3          	beq	a3,a4,80005cd8 <uartputc+0x50>
    80005d0c:	01f77693          	andi	a3,a4,31
    80005d10:	00004597          	auipc	a1,0x4
    80005d14:	5b058593          	addi	a1,a1,1456 # 8000a2c0 <uart_tx_buf>
    80005d18:	00d586b3          	add	a3,a1,a3
    80005d1c:	00170713          	addi	a4,a4,1
    80005d20:	01368023          	sb	s3,0(a3)
    80005d24:	00e4b023          	sd	a4,0(s1)
    80005d28:	10000637          	lui	a2,0x10000
    80005d2c:	02f71063          	bne	a4,a5,80005d4c <uartputc+0xc4>
    80005d30:	0340006f          	j	80005d64 <uartputc+0xdc>
    80005d34:	00074703          	lbu	a4,0(a4)
    80005d38:	00f93023          	sd	a5,0(s2)
    80005d3c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005d40:	00093783          	ld	a5,0(s2)
    80005d44:	0004b703          	ld	a4,0(s1)
    80005d48:	00f70e63          	beq	a4,a5,80005d64 <uartputc+0xdc>
    80005d4c:	00564683          	lbu	a3,5(a2)
    80005d50:	01f7f713          	andi	a4,a5,31
    80005d54:	00e58733          	add	a4,a1,a4
    80005d58:	0206f693          	andi	a3,a3,32
    80005d5c:	00178793          	addi	a5,a5,1
    80005d60:	fc069ae3          	bnez	a3,80005d34 <uartputc+0xac>
    80005d64:	02813083          	ld	ra,40(sp)
    80005d68:	02013403          	ld	s0,32(sp)
    80005d6c:	01813483          	ld	s1,24(sp)
    80005d70:	01013903          	ld	s2,16(sp)
    80005d74:	00813983          	ld	s3,8(sp)
    80005d78:	03010113          	addi	sp,sp,48
    80005d7c:	00008067          	ret

0000000080005d80 <uartputc_sync>:
    80005d80:	ff010113          	addi	sp,sp,-16
    80005d84:	00813423          	sd	s0,8(sp)
    80005d88:	01010413          	addi	s0,sp,16
    80005d8c:	00003717          	auipc	a4,0x3
    80005d90:	1cc72703          	lw	a4,460(a4) # 80008f58 <panicked>
    80005d94:	02071663          	bnez	a4,80005dc0 <uartputc_sync+0x40>
    80005d98:	00050793          	mv	a5,a0
    80005d9c:	100006b7          	lui	a3,0x10000
    80005da0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005da4:	02077713          	andi	a4,a4,32
    80005da8:	fe070ce3          	beqz	a4,80005da0 <uartputc_sync+0x20>
    80005dac:	0ff7f793          	andi	a5,a5,255
    80005db0:	00f68023          	sb	a5,0(a3)
    80005db4:	00813403          	ld	s0,8(sp)
    80005db8:	01010113          	addi	sp,sp,16
    80005dbc:	00008067          	ret
    80005dc0:	0000006f          	j	80005dc0 <uartputc_sync+0x40>

0000000080005dc4 <uartstart>:
    80005dc4:	ff010113          	addi	sp,sp,-16
    80005dc8:	00813423          	sd	s0,8(sp)
    80005dcc:	01010413          	addi	s0,sp,16
    80005dd0:	00003617          	auipc	a2,0x3
    80005dd4:	19060613          	addi	a2,a2,400 # 80008f60 <uart_tx_r>
    80005dd8:	00003517          	auipc	a0,0x3
    80005ddc:	19050513          	addi	a0,a0,400 # 80008f68 <uart_tx_w>
    80005de0:	00063783          	ld	a5,0(a2)
    80005de4:	00053703          	ld	a4,0(a0)
    80005de8:	04f70263          	beq	a4,a5,80005e2c <uartstart+0x68>
    80005dec:	100005b7          	lui	a1,0x10000
    80005df0:	00004817          	auipc	a6,0x4
    80005df4:	4d080813          	addi	a6,a6,1232 # 8000a2c0 <uart_tx_buf>
    80005df8:	01c0006f          	j	80005e14 <uartstart+0x50>
    80005dfc:	0006c703          	lbu	a4,0(a3)
    80005e00:	00f63023          	sd	a5,0(a2)
    80005e04:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005e08:	00063783          	ld	a5,0(a2)
    80005e0c:	00053703          	ld	a4,0(a0)
    80005e10:	00f70e63          	beq	a4,a5,80005e2c <uartstart+0x68>
    80005e14:	01f7f713          	andi	a4,a5,31
    80005e18:	00e806b3          	add	a3,a6,a4
    80005e1c:	0055c703          	lbu	a4,5(a1)
    80005e20:	00178793          	addi	a5,a5,1
    80005e24:	02077713          	andi	a4,a4,32
    80005e28:	fc071ae3          	bnez	a4,80005dfc <uartstart+0x38>
    80005e2c:	00813403          	ld	s0,8(sp)
    80005e30:	01010113          	addi	sp,sp,16
    80005e34:	00008067          	ret

0000000080005e38 <uartgetc>:
    80005e38:	ff010113          	addi	sp,sp,-16
    80005e3c:	00813423          	sd	s0,8(sp)
    80005e40:	01010413          	addi	s0,sp,16
    80005e44:	10000737          	lui	a4,0x10000
    80005e48:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005e4c:	0017f793          	andi	a5,a5,1
    80005e50:	00078c63          	beqz	a5,80005e68 <uartgetc+0x30>
    80005e54:	00074503          	lbu	a0,0(a4)
    80005e58:	0ff57513          	andi	a0,a0,255
    80005e5c:	00813403          	ld	s0,8(sp)
    80005e60:	01010113          	addi	sp,sp,16
    80005e64:	00008067          	ret
    80005e68:	fff00513          	li	a0,-1
    80005e6c:	ff1ff06f          	j	80005e5c <uartgetc+0x24>

0000000080005e70 <uartintr>:
    80005e70:	100007b7          	lui	a5,0x10000
    80005e74:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005e78:	0017f793          	andi	a5,a5,1
    80005e7c:	0a078463          	beqz	a5,80005f24 <uartintr+0xb4>
    80005e80:	fe010113          	addi	sp,sp,-32
    80005e84:	00813823          	sd	s0,16(sp)
    80005e88:	00913423          	sd	s1,8(sp)
    80005e8c:	00113c23          	sd	ra,24(sp)
    80005e90:	02010413          	addi	s0,sp,32
    80005e94:	100004b7          	lui	s1,0x10000
    80005e98:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80005e9c:	0ff57513          	andi	a0,a0,255
    80005ea0:	fffff097          	auipc	ra,0xfffff
    80005ea4:	534080e7          	jalr	1332(ra) # 800053d4 <consoleintr>
    80005ea8:	0054c783          	lbu	a5,5(s1)
    80005eac:	0017f793          	andi	a5,a5,1
    80005eb0:	fe0794e3          	bnez	a5,80005e98 <uartintr+0x28>
    80005eb4:	00003617          	auipc	a2,0x3
    80005eb8:	0ac60613          	addi	a2,a2,172 # 80008f60 <uart_tx_r>
    80005ebc:	00003517          	auipc	a0,0x3
    80005ec0:	0ac50513          	addi	a0,a0,172 # 80008f68 <uart_tx_w>
    80005ec4:	00063783          	ld	a5,0(a2)
    80005ec8:	00053703          	ld	a4,0(a0)
    80005ecc:	04f70263          	beq	a4,a5,80005f10 <uartintr+0xa0>
    80005ed0:	100005b7          	lui	a1,0x10000
    80005ed4:	00004817          	auipc	a6,0x4
    80005ed8:	3ec80813          	addi	a6,a6,1004 # 8000a2c0 <uart_tx_buf>
    80005edc:	01c0006f          	j	80005ef8 <uartintr+0x88>
    80005ee0:	0006c703          	lbu	a4,0(a3)
    80005ee4:	00f63023          	sd	a5,0(a2)
    80005ee8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005eec:	00063783          	ld	a5,0(a2)
    80005ef0:	00053703          	ld	a4,0(a0)
    80005ef4:	00f70e63          	beq	a4,a5,80005f10 <uartintr+0xa0>
    80005ef8:	01f7f713          	andi	a4,a5,31
    80005efc:	00e806b3          	add	a3,a6,a4
    80005f00:	0055c703          	lbu	a4,5(a1)
    80005f04:	00178793          	addi	a5,a5,1
    80005f08:	02077713          	andi	a4,a4,32
    80005f0c:	fc071ae3          	bnez	a4,80005ee0 <uartintr+0x70>
    80005f10:	01813083          	ld	ra,24(sp)
    80005f14:	01013403          	ld	s0,16(sp)
    80005f18:	00813483          	ld	s1,8(sp)
    80005f1c:	02010113          	addi	sp,sp,32
    80005f20:	00008067          	ret
    80005f24:	00003617          	auipc	a2,0x3
    80005f28:	03c60613          	addi	a2,a2,60 # 80008f60 <uart_tx_r>
    80005f2c:	00003517          	auipc	a0,0x3
    80005f30:	03c50513          	addi	a0,a0,60 # 80008f68 <uart_tx_w>
    80005f34:	00063783          	ld	a5,0(a2)
    80005f38:	00053703          	ld	a4,0(a0)
    80005f3c:	04f70263          	beq	a4,a5,80005f80 <uartintr+0x110>
    80005f40:	100005b7          	lui	a1,0x10000
    80005f44:	00004817          	auipc	a6,0x4
    80005f48:	37c80813          	addi	a6,a6,892 # 8000a2c0 <uart_tx_buf>
    80005f4c:	01c0006f          	j	80005f68 <uartintr+0xf8>
    80005f50:	0006c703          	lbu	a4,0(a3)
    80005f54:	00f63023          	sd	a5,0(a2)
    80005f58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005f5c:	00063783          	ld	a5,0(a2)
    80005f60:	00053703          	ld	a4,0(a0)
    80005f64:	02f70063          	beq	a4,a5,80005f84 <uartintr+0x114>
    80005f68:	01f7f713          	andi	a4,a5,31
    80005f6c:	00e806b3          	add	a3,a6,a4
    80005f70:	0055c703          	lbu	a4,5(a1)
    80005f74:	00178793          	addi	a5,a5,1
    80005f78:	02077713          	andi	a4,a4,32
    80005f7c:	fc071ae3          	bnez	a4,80005f50 <uartintr+0xe0>
    80005f80:	00008067          	ret
    80005f84:	00008067          	ret

0000000080005f88 <kinit>:
    80005f88:	fc010113          	addi	sp,sp,-64
    80005f8c:	02913423          	sd	s1,40(sp)
    80005f90:	fffff7b7          	lui	a5,0xfffff
    80005f94:	00005497          	auipc	s1,0x5
    80005f98:	34b48493          	addi	s1,s1,843 # 8000b2df <end+0xfff>
    80005f9c:	02813823          	sd	s0,48(sp)
    80005fa0:	01313c23          	sd	s3,24(sp)
    80005fa4:	00f4f4b3          	and	s1,s1,a5
    80005fa8:	02113c23          	sd	ra,56(sp)
    80005fac:	03213023          	sd	s2,32(sp)
    80005fb0:	01413823          	sd	s4,16(sp)
    80005fb4:	01513423          	sd	s5,8(sp)
    80005fb8:	04010413          	addi	s0,sp,64
    80005fbc:	000017b7          	lui	a5,0x1
    80005fc0:	01100993          	li	s3,17
    80005fc4:	00f487b3          	add	a5,s1,a5
    80005fc8:	01b99993          	slli	s3,s3,0x1b
    80005fcc:	06f9e063          	bltu	s3,a5,8000602c <kinit+0xa4>
    80005fd0:	00004a97          	auipc	s5,0x4
    80005fd4:	310a8a93          	addi	s5,s5,784 # 8000a2e0 <end>
    80005fd8:	0754ec63          	bltu	s1,s5,80006050 <kinit+0xc8>
    80005fdc:	0734fa63          	bgeu	s1,s3,80006050 <kinit+0xc8>
    80005fe0:	00088a37          	lui	s4,0x88
    80005fe4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005fe8:	00003917          	auipc	s2,0x3
    80005fec:	f8890913          	addi	s2,s2,-120 # 80008f70 <kmem>
    80005ff0:	00ca1a13          	slli	s4,s4,0xc
    80005ff4:	0140006f          	j	80006008 <kinit+0x80>
    80005ff8:	000017b7          	lui	a5,0x1
    80005ffc:	00f484b3          	add	s1,s1,a5
    80006000:	0554e863          	bltu	s1,s5,80006050 <kinit+0xc8>
    80006004:	0534f663          	bgeu	s1,s3,80006050 <kinit+0xc8>
    80006008:	00001637          	lui	a2,0x1
    8000600c:	00100593          	li	a1,1
    80006010:	00048513          	mv	a0,s1
    80006014:	00000097          	auipc	ra,0x0
    80006018:	5e4080e7          	jalr	1508(ra) # 800065f8 <__memset>
    8000601c:	00093783          	ld	a5,0(s2)
    80006020:	00f4b023          	sd	a5,0(s1)
    80006024:	00993023          	sd	s1,0(s2)
    80006028:	fd4498e3          	bne	s1,s4,80005ff8 <kinit+0x70>
    8000602c:	03813083          	ld	ra,56(sp)
    80006030:	03013403          	ld	s0,48(sp)
    80006034:	02813483          	ld	s1,40(sp)
    80006038:	02013903          	ld	s2,32(sp)
    8000603c:	01813983          	ld	s3,24(sp)
    80006040:	01013a03          	ld	s4,16(sp)
    80006044:	00813a83          	ld	s5,8(sp)
    80006048:	04010113          	addi	sp,sp,64
    8000604c:	00008067          	ret
    80006050:	00001517          	auipc	a0,0x1
    80006054:	41850513          	addi	a0,a0,1048 # 80007468 <digits+0x18>
    80006058:	fffff097          	auipc	ra,0xfffff
    8000605c:	4b4080e7          	jalr	1204(ra) # 8000550c <panic>

0000000080006060 <freerange>:
    80006060:	fc010113          	addi	sp,sp,-64
    80006064:	000017b7          	lui	a5,0x1
    80006068:	02913423          	sd	s1,40(sp)
    8000606c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006070:	009504b3          	add	s1,a0,s1
    80006074:	fffff537          	lui	a0,0xfffff
    80006078:	02813823          	sd	s0,48(sp)
    8000607c:	02113c23          	sd	ra,56(sp)
    80006080:	03213023          	sd	s2,32(sp)
    80006084:	01313c23          	sd	s3,24(sp)
    80006088:	01413823          	sd	s4,16(sp)
    8000608c:	01513423          	sd	s5,8(sp)
    80006090:	01613023          	sd	s6,0(sp)
    80006094:	04010413          	addi	s0,sp,64
    80006098:	00a4f4b3          	and	s1,s1,a0
    8000609c:	00f487b3          	add	a5,s1,a5
    800060a0:	06f5e463          	bltu	a1,a5,80006108 <freerange+0xa8>
    800060a4:	00004a97          	auipc	s5,0x4
    800060a8:	23ca8a93          	addi	s5,s5,572 # 8000a2e0 <end>
    800060ac:	0954e263          	bltu	s1,s5,80006130 <freerange+0xd0>
    800060b0:	01100993          	li	s3,17
    800060b4:	01b99993          	slli	s3,s3,0x1b
    800060b8:	0734fc63          	bgeu	s1,s3,80006130 <freerange+0xd0>
    800060bc:	00058a13          	mv	s4,a1
    800060c0:	00003917          	auipc	s2,0x3
    800060c4:	eb090913          	addi	s2,s2,-336 # 80008f70 <kmem>
    800060c8:	00002b37          	lui	s6,0x2
    800060cc:	0140006f          	j	800060e0 <freerange+0x80>
    800060d0:	000017b7          	lui	a5,0x1
    800060d4:	00f484b3          	add	s1,s1,a5
    800060d8:	0554ec63          	bltu	s1,s5,80006130 <freerange+0xd0>
    800060dc:	0534fa63          	bgeu	s1,s3,80006130 <freerange+0xd0>
    800060e0:	00001637          	lui	a2,0x1
    800060e4:	00100593          	li	a1,1
    800060e8:	00048513          	mv	a0,s1
    800060ec:	00000097          	auipc	ra,0x0
    800060f0:	50c080e7          	jalr	1292(ra) # 800065f8 <__memset>
    800060f4:	00093703          	ld	a4,0(s2)
    800060f8:	016487b3          	add	a5,s1,s6
    800060fc:	00e4b023          	sd	a4,0(s1)
    80006100:	00993023          	sd	s1,0(s2)
    80006104:	fcfa76e3          	bgeu	s4,a5,800060d0 <freerange+0x70>
    80006108:	03813083          	ld	ra,56(sp)
    8000610c:	03013403          	ld	s0,48(sp)
    80006110:	02813483          	ld	s1,40(sp)
    80006114:	02013903          	ld	s2,32(sp)
    80006118:	01813983          	ld	s3,24(sp)
    8000611c:	01013a03          	ld	s4,16(sp)
    80006120:	00813a83          	ld	s5,8(sp)
    80006124:	00013b03          	ld	s6,0(sp)
    80006128:	04010113          	addi	sp,sp,64
    8000612c:	00008067          	ret
    80006130:	00001517          	auipc	a0,0x1
    80006134:	33850513          	addi	a0,a0,824 # 80007468 <digits+0x18>
    80006138:	fffff097          	auipc	ra,0xfffff
    8000613c:	3d4080e7          	jalr	980(ra) # 8000550c <panic>

0000000080006140 <kfree>:
    80006140:	fe010113          	addi	sp,sp,-32
    80006144:	00813823          	sd	s0,16(sp)
    80006148:	00113c23          	sd	ra,24(sp)
    8000614c:	00913423          	sd	s1,8(sp)
    80006150:	02010413          	addi	s0,sp,32
    80006154:	03451793          	slli	a5,a0,0x34
    80006158:	04079c63          	bnez	a5,800061b0 <kfree+0x70>
    8000615c:	00004797          	auipc	a5,0x4
    80006160:	18478793          	addi	a5,a5,388 # 8000a2e0 <end>
    80006164:	00050493          	mv	s1,a0
    80006168:	04f56463          	bltu	a0,a5,800061b0 <kfree+0x70>
    8000616c:	01100793          	li	a5,17
    80006170:	01b79793          	slli	a5,a5,0x1b
    80006174:	02f57e63          	bgeu	a0,a5,800061b0 <kfree+0x70>
    80006178:	00001637          	lui	a2,0x1
    8000617c:	00100593          	li	a1,1
    80006180:	00000097          	auipc	ra,0x0
    80006184:	478080e7          	jalr	1144(ra) # 800065f8 <__memset>
    80006188:	00003797          	auipc	a5,0x3
    8000618c:	de878793          	addi	a5,a5,-536 # 80008f70 <kmem>
    80006190:	0007b703          	ld	a4,0(a5)
    80006194:	01813083          	ld	ra,24(sp)
    80006198:	01013403          	ld	s0,16(sp)
    8000619c:	00e4b023          	sd	a4,0(s1)
    800061a0:	0097b023          	sd	s1,0(a5)
    800061a4:	00813483          	ld	s1,8(sp)
    800061a8:	02010113          	addi	sp,sp,32
    800061ac:	00008067          	ret
    800061b0:	00001517          	auipc	a0,0x1
    800061b4:	2b850513          	addi	a0,a0,696 # 80007468 <digits+0x18>
    800061b8:	fffff097          	auipc	ra,0xfffff
    800061bc:	354080e7          	jalr	852(ra) # 8000550c <panic>

00000000800061c0 <kalloc>:
    800061c0:	fe010113          	addi	sp,sp,-32
    800061c4:	00813823          	sd	s0,16(sp)
    800061c8:	00913423          	sd	s1,8(sp)
    800061cc:	00113c23          	sd	ra,24(sp)
    800061d0:	02010413          	addi	s0,sp,32
    800061d4:	00003797          	auipc	a5,0x3
    800061d8:	d9c78793          	addi	a5,a5,-612 # 80008f70 <kmem>
    800061dc:	0007b483          	ld	s1,0(a5)
    800061e0:	02048063          	beqz	s1,80006200 <kalloc+0x40>
    800061e4:	0004b703          	ld	a4,0(s1)
    800061e8:	00001637          	lui	a2,0x1
    800061ec:	00500593          	li	a1,5
    800061f0:	00048513          	mv	a0,s1
    800061f4:	00e7b023          	sd	a4,0(a5)
    800061f8:	00000097          	auipc	ra,0x0
    800061fc:	400080e7          	jalr	1024(ra) # 800065f8 <__memset>
    80006200:	01813083          	ld	ra,24(sp)
    80006204:	01013403          	ld	s0,16(sp)
    80006208:	00048513          	mv	a0,s1
    8000620c:	00813483          	ld	s1,8(sp)
    80006210:	02010113          	addi	sp,sp,32
    80006214:	00008067          	ret

0000000080006218 <initlock>:
    80006218:	ff010113          	addi	sp,sp,-16
    8000621c:	00813423          	sd	s0,8(sp)
    80006220:	01010413          	addi	s0,sp,16
    80006224:	00813403          	ld	s0,8(sp)
    80006228:	00b53423          	sd	a1,8(a0)
    8000622c:	00052023          	sw	zero,0(a0)
    80006230:	00053823          	sd	zero,16(a0)
    80006234:	01010113          	addi	sp,sp,16
    80006238:	00008067          	ret

000000008000623c <acquire>:
    8000623c:	fe010113          	addi	sp,sp,-32
    80006240:	00813823          	sd	s0,16(sp)
    80006244:	00913423          	sd	s1,8(sp)
    80006248:	00113c23          	sd	ra,24(sp)
    8000624c:	01213023          	sd	s2,0(sp)
    80006250:	02010413          	addi	s0,sp,32
    80006254:	00050493          	mv	s1,a0
    80006258:	10002973          	csrr	s2,sstatus
    8000625c:	100027f3          	csrr	a5,sstatus
    80006260:	ffd7f793          	andi	a5,a5,-3
    80006264:	10079073          	csrw	sstatus,a5
    80006268:	fffff097          	auipc	ra,0xfffff
    8000626c:	8e4080e7          	jalr	-1820(ra) # 80004b4c <mycpu>
    80006270:	07852783          	lw	a5,120(a0)
    80006274:	06078e63          	beqz	a5,800062f0 <acquire+0xb4>
    80006278:	fffff097          	auipc	ra,0xfffff
    8000627c:	8d4080e7          	jalr	-1836(ra) # 80004b4c <mycpu>
    80006280:	07852783          	lw	a5,120(a0)
    80006284:	0004a703          	lw	a4,0(s1)
    80006288:	0017879b          	addiw	a5,a5,1
    8000628c:	06f52c23          	sw	a5,120(a0)
    80006290:	04071063          	bnez	a4,800062d0 <acquire+0x94>
    80006294:	00100713          	li	a4,1
    80006298:	00070793          	mv	a5,a4
    8000629c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800062a0:	0007879b          	sext.w	a5,a5
    800062a4:	fe079ae3          	bnez	a5,80006298 <acquire+0x5c>
    800062a8:	0ff0000f          	fence
    800062ac:	fffff097          	auipc	ra,0xfffff
    800062b0:	8a0080e7          	jalr	-1888(ra) # 80004b4c <mycpu>
    800062b4:	01813083          	ld	ra,24(sp)
    800062b8:	01013403          	ld	s0,16(sp)
    800062bc:	00a4b823          	sd	a0,16(s1)
    800062c0:	00013903          	ld	s2,0(sp)
    800062c4:	00813483          	ld	s1,8(sp)
    800062c8:	02010113          	addi	sp,sp,32
    800062cc:	00008067          	ret
    800062d0:	0104b903          	ld	s2,16(s1)
    800062d4:	fffff097          	auipc	ra,0xfffff
    800062d8:	878080e7          	jalr	-1928(ra) # 80004b4c <mycpu>
    800062dc:	faa91ce3          	bne	s2,a0,80006294 <acquire+0x58>
    800062e0:	00001517          	auipc	a0,0x1
    800062e4:	19050513          	addi	a0,a0,400 # 80007470 <digits+0x20>
    800062e8:	fffff097          	auipc	ra,0xfffff
    800062ec:	224080e7          	jalr	548(ra) # 8000550c <panic>
    800062f0:	00195913          	srli	s2,s2,0x1
    800062f4:	fffff097          	auipc	ra,0xfffff
    800062f8:	858080e7          	jalr	-1960(ra) # 80004b4c <mycpu>
    800062fc:	00197913          	andi	s2,s2,1
    80006300:	07252e23          	sw	s2,124(a0)
    80006304:	f75ff06f          	j	80006278 <acquire+0x3c>

0000000080006308 <release>:
    80006308:	fe010113          	addi	sp,sp,-32
    8000630c:	00813823          	sd	s0,16(sp)
    80006310:	00113c23          	sd	ra,24(sp)
    80006314:	00913423          	sd	s1,8(sp)
    80006318:	01213023          	sd	s2,0(sp)
    8000631c:	02010413          	addi	s0,sp,32
    80006320:	00052783          	lw	a5,0(a0)
    80006324:	00079a63          	bnez	a5,80006338 <release+0x30>
    80006328:	00001517          	auipc	a0,0x1
    8000632c:	15050513          	addi	a0,a0,336 # 80007478 <digits+0x28>
    80006330:	fffff097          	auipc	ra,0xfffff
    80006334:	1dc080e7          	jalr	476(ra) # 8000550c <panic>
    80006338:	01053903          	ld	s2,16(a0)
    8000633c:	00050493          	mv	s1,a0
    80006340:	fffff097          	auipc	ra,0xfffff
    80006344:	80c080e7          	jalr	-2036(ra) # 80004b4c <mycpu>
    80006348:	fea910e3          	bne	s2,a0,80006328 <release+0x20>
    8000634c:	0004b823          	sd	zero,16(s1)
    80006350:	0ff0000f          	fence
    80006354:	0f50000f          	fence	iorw,ow
    80006358:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000635c:	ffffe097          	auipc	ra,0xffffe
    80006360:	7f0080e7          	jalr	2032(ra) # 80004b4c <mycpu>
    80006364:	100027f3          	csrr	a5,sstatus
    80006368:	0027f793          	andi	a5,a5,2
    8000636c:	04079a63          	bnez	a5,800063c0 <release+0xb8>
    80006370:	07852783          	lw	a5,120(a0)
    80006374:	02f05e63          	blez	a5,800063b0 <release+0xa8>
    80006378:	fff7871b          	addiw	a4,a5,-1
    8000637c:	06e52c23          	sw	a4,120(a0)
    80006380:	00071c63          	bnez	a4,80006398 <release+0x90>
    80006384:	07c52783          	lw	a5,124(a0)
    80006388:	00078863          	beqz	a5,80006398 <release+0x90>
    8000638c:	100027f3          	csrr	a5,sstatus
    80006390:	0027e793          	ori	a5,a5,2
    80006394:	10079073          	csrw	sstatus,a5
    80006398:	01813083          	ld	ra,24(sp)
    8000639c:	01013403          	ld	s0,16(sp)
    800063a0:	00813483          	ld	s1,8(sp)
    800063a4:	00013903          	ld	s2,0(sp)
    800063a8:	02010113          	addi	sp,sp,32
    800063ac:	00008067          	ret
    800063b0:	00001517          	auipc	a0,0x1
    800063b4:	0e850513          	addi	a0,a0,232 # 80007498 <digits+0x48>
    800063b8:	fffff097          	auipc	ra,0xfffff
    800063bc:	154080e7          	jalr	340(ra) # 8000550c <panic>
    800063c0:	00001517          	auipc	a0,0x1
    800063c4:	0c050513          	addi	a0,a0,192 # 80007480 <digits+0x30>
    800063c8:	fffff097          	auipc	ra,0xfffff
    800063cc:	144080e7          	jalr	324(ra) # 8000550c <panic>

00000000800063d0 <holding>:
    800063d0:	00052783          	lw	a5,0(a0)
    800063d4:	00079663          	bnez	a5,800063e0 <holding+0x10>
    800063d8:	00000513          	li	a0,0
    800063dc:	00008067          	ret
    800063e0:	fe010113          	addi	sp,sp,-32
    800063e4:	00813823          	sd	s0,16(sp)
    800063e8:	00913423          	sd	s1,8(sp)
    800063ec:	00113c23          	sd	ra,24(sp)
    800063f0:	02010413          	addi	s0,sp,32
    800063f4:	01053483          	ld	s1,16(a0)
    800063f8:	ffffe097          	auipc	ra,0xffffe
    800063fc:	754080e7          	jalr	1876(ra) # 80004b4c <mycpu>
    80006400:	01813083          	ld	ra,24(sp)
    80006404:	01013403          	ld	s0,16(sp)
    80006408:	40a48533          	sub	a0,s1,a0
    8000640c:	00153513          	seqz	a0,a0
    80006410:	00813483          	ld	s1,8(sp)
    80006414:	02010113          	addi	sp,sp,32
    80006418:	00008067          	ret

000000008000641c <push_off>:
    8000641c:	fe010113          	addi	sp,sp,-32
    80006420:	00813823          	sd	s0,16(sp)
    80006424:	00113c23          	sd	ra,24(sp)
    80006428:	00913423          	sd	s1,8(sp)
    8000642c:	02010413          	addi	s0,sp,32
    80006430:	100024f3          	csrr	s1,sstatus
    80006434:	100027f3          	csrr	a5,sstatus
    80006438:	ffd7f793          	andi	a5,a5,-3
    8000643c:	10079073          	csrw	sstatus,a5
    80006440:	ffffe097          	auipc	ra,0xffffe
    80006444:	70c080e7          	jalr	1804(ra) # 80004b4c <mycpu>
    80006448:	07852783          	lw	a5,120(a0)
    8000644c:	02078663          	beqz	a5,80006478 <push_off+0x5c>
    80006450:	ffffe097          	auipc	ra,0xffffe
    80006454:	6fc080e7          	jalr	1788(ra) # 80004b4c <mycpu>
    80006458:	07852783          	lw	a5,120(a0)
    8000645c:	01813083          	ld	ra,24(sp)
    80006460:	01013403          	ld	s0,16(sp)
    80006464:	0017879b          	addiw	a5,a5,1
    80006468:	06f52c23          	sw	a5,120(a0)
    8000646c:	00813483          	ld	s1,8(sp)
    80006470:	02010113          	addi	sp,sp,32
    80006474:	00008067          	ret
    80006478:	0014d493          	srli	s1,s1,0x1
    8000647c:	ffffe097          	auipc	ra,0xffffe
    80006480:	6d0080e7          	jalr	1744(ra) # 80004b4c <mycpu>
    80006484:	0014f493          	andi	s1,s1,1
    80006488:	06952e23          	sw	s1,124(a0)
    8000648c:	fc5ff06f          	j	80006450 <push_off+0x34>

0000000080006490 <pop_off>:
    80006490:	ff010113          	addi	sp,sp,-16
    80006494:	00813023          	sd	s0,0(sp)
    80006498:	00113423          	sd	ra,8(sp)
    8000649c:	01010413          	addi	s0,sp,16
    800064a0:	ffffe097          	auipc	ra,0xffffe
    800064a4:	6ac080e7          	jalr	1708(ra) # 80004b4c <mycpu>
    800064a8:	100027f3          	csrr	a5,sstatus
    800064ac:	0027f793          	andi	a5,a5,2
    800064b0:	04079663          	bnez	a5,800064fc <pop_off+0x6c>
    800064b4:	07852783          	lw	a5,120(a0)
    800064b8:	02f05a63          	blez	a5,800064ec <pop_off+0x5c>
    800064bc:	fff7871b          	addiw	a4,a5,-1
    800064c0:	06e52c23          	sw	a4,120(a0)
    800064c4:	00071c63          	bnez	a4,800064dc <pop_off+0x4c>
    800064c8:	07c52783          	lw	a5,124(a0)
    800064cc:	00078863          	beqz	a5,800064dc <pop_off+0x4c>
    800064d0:	100027f3          	csrr	a5,sstatus
    800064d4:	0027e793          	ori	a5,a5,2
    800064d8:	10079073          	csrw	sstatus,a5
    800064dc:	00813083          	ld	ra,8(sp)
    800064e0:	00013403          	ld	s0,0(sp)
    800064e4:	01010113          	addi	sp,sp,16
    800064e8:	00008067          	ret
    800064ec:	00001517          	auipc	a0,0x1
    800064f0:	fac50513          	addi	a0,a0,-84 # 80007498 <digits+0x48>
    800064f4:	fffff097          	auipc	ra,0xfffff
    800064f8:	018080e7          	jalr	24(ra) # 8000550c <panic>
    800064fc:	00001517          	auipc	a0,0x1
    80006500:	f8450513          	addi	a0,a0,-124 # 80007480 <digits+0x30>
    80006504:	fffff097          	auipc	ra,0xfffff
    80006508:	008080e7          	jalr	8(ra) # 8000550c <panic>

000000008000650c <push_on>:
    8000650c:	fe010113          	addi	sp,sp,-32
    80006510:	00813823          	sd	s0,16(sp)
    80006514:	00113c23          	sd	ra,24(sp)
    80006518:	00913423          	sd	s1,8(sp)
    8000651c:	02010413          	addi	s0,sp,32
    80006520:	100024f3          	csrr	s1,sstatus
    80006524:	100027f3          	csrr	a5,sstatus
    80006528:	0027e793          	ori	a5,a5,2
    8000652c:	10079073          	csrw	sstatus,a5
    80006530:	ffffe097          	auipc	ra,0xffffe
    80006534:	61c080e7          	jalr	1564(ra) # 80004b4c <mycpu>
    80006538:	07852783          	lw	a5,120(a0)
    8000653c:	02078663          	beqz	a5,80006568 <push_on+0x5c>
    80006540:	ffffe097          	auipc	ra,0xffffe
    80006544:	60c080e7          	jalr	1548(ra) # 80004b4c <mycpu>
    80006548:	07852783          	lw	a5,120(a0)
    8000654c:	01813083          	ld	ra,24(sp)
    80006550:	01013403          	ld	s0,16(sp)
    80006554:	0017879b          	addiw	a5,a5,1
    80006558:	06f52c23          	sw	a5,120(a0)
    8000655c:	00813483          	ld	s1,8(sp)
    80006560:	02010113          	addi	sp,sp,32
    80006564:	00008067          	ret
    80006568:	0014d493          	srli	s1,s1,0x1
    8000656c:	ffffe097          	auipc	ra,0xffffe
    80006570:	5e0080e7          	jalr	1504(ra) # 80004b4c <mycpu>
    80006574:	0014f493          	andi	s1,s1,1
    80006578:	06952e23          	sw	s1,124(a0)
    8000657c:	fc5ff06f          	j	80006540 <push_on+0x34>

0000000080006580 <pop_on>:
    80006580:	ff010113          	addi	sp,sp,-16
    80006584:	00813023          	sd	s0,0(sp)
    80006588:	00113423          	sd	ra,8(sp)
    8000658c:	01010413          	addi	s0,sp,16
    80006590:	ffffe097          	auipc	ra,0xffffe
    80006594:	5bc080e7          	jalr	1468(ra) # 80004b4c <mycpu>
    80006598:	100027f3          	csrr	a5,sstatus
    8000659c:	0027f793          	andi	a5,a5,2
    800065a0:	04078463          	beqz	a5,800065e8 <pop_on+0x68>
    800065a4:	07852783          	lw	a5,120(a0)
    800065a8:	02f05863          	blez	a5,800065d8 <pop_on+0x58>
    800065ac:	fff7879b          	addiw	a5,a5,-1
    800065b0:	06f52c23          	sw	a5,120(a0)
    800065b4:	07853783          	ld	a5,120(a0)
    800065b8:	00079863          	bnez	a5,800065c8 <pop_on+0x48>
    800065bc:	100027f3          	csrr	a5,sstatus
    800065c0:	ffd7f793          	andi	a5,a5,-3
    800065c4:	10079073          	csrw	sstatus,a5
    800065c8:	00813083          	ld	ra,8(sp)
    800065cc:	00013403          	ld	s0,0(sp)
    800065d0:	01010113          	addi	sp,sp,16
    800065d4:	00008067          	ret
    800065d8:	00001517          	auipc	a0,0x1
    800065dc:	ee850513          	addi	a0,a0,-280 # 800074c0 <digits+0x70>
    800065e0:	fffff097          	auipc	ra,0xfffff
    800065e4:	f2c080e7          	jalr	-212(ra) # 8000550c <panic>
    800065e8:	00001517          	auipc	a0,0x1
    800065ec:	eb850513          	addi	a0,a0,-328 # 800074a0 <digits+0x50>
    800065f0:	fffff097          	auipc	ra,0xfffff
    800065f4:	f1c080e7          	jalr	-228(ra) # 8000550c <panic>

00000000800065f8 <__memset>:
    800065f8:	ff010113          	addi	sp,sp,-16
    800065fc:	00813423          	sd	s0,8(sp)
    80006600:	01010413          	addi	s0,sp,16
    80006604:	1a060e63          	beqz	a2,800067c0 <__memset+0x1c8>
    80006608:	40a007b3          	neg	a5,a0
    8000660c:	0077f793          	andi	a5,a5,7
    80006610:	00778693          	addi	a3,a5,7
    80006614:	00b00813          	li	a6,11
    80006618:	0ff5f593          	andi	a1,a1,255
    8000661c:	fff6071b          	addiw	a4,a2,-1
    80006620:	1b06e663          	bltu	a3,a6,800067cc <__memset+0x1d4>
    80006624:	1cd76463          	bltu	a4,a3,800067ec <__memset+0x1f4>
    80006628:	1a078e63          	beqz	a5,800067e4 <__memset+0x1ec>
    8000662c:	00b50023          	sb	a1,0(a0)
    80006630:	00100713          	li	a4,1
    80006634:	1ae78463          	beq	a5,a4,800067dc <__memset+0x1e4>
    80006638:	00b500a3          	sb	a1,1(a0)
    8000663c:	00200713          	li	a4,2
    80006640:	1ae78a63          	beq	a5,a4,800067f4 <__memset+0x1fc>
    80006644:	00b50123          	sb	a1,2(a0)
    80006648:	00300713          	li	a4,3
    8000664c:	18e78463          	beq	a5,a4,800067d4 <__memset+0x1dc>
    80006650:	00b501a3          	sb	a1,3(a0)
    80006654:	00400713          	li	a4,4
    80006658:	1ae78263          	beq	a5,a4,800067fc <__memset+0x204>
    8000665c:	00b50223          	sb	a1,4(a0)
    80006660:	00500713          	li	a4,5
    80006664:	1ae78063          	beq	a5,a4,80006804 <__memset+0x20c>
    80006668:	00b502a3          	sb	a1,5(a0)
    8000666c:	00700713          	li	a4,7
    80006670:	18e79e63          	bne	a5,a4,8000680c <__memset+0x214>
    80006674:	00b50323          	sb	a1,6(a0)
    80006678:	00700e93          	li	t4,7
    8000667c:	00859713          	slli	a4,a1,0x8
    80006680:	00e5e733          	or	a4,a1,a4
    80006684:	01059e13          	slli	t3,a1,0x10
    80006688:	01c76e33          	or	t3,a4,t3
    8000668c:	01859313          	slli	t1,a1,0x18
    80006690:	006e6333          	or	t1,t3,t1
    80006694:	02059893          	slli	a7,a1,0x20
    80006698:	40f60e3b          	subw	t3,a2,a5
    8000669c:	011368b3          	or	a7,t1,a7
    800066a0:	02859813          	slli	a6,a1,0x28
    800066a4:	0108e833          	or	a6,a7,a6
    800066a8:	03059693          	slli	a3,a1,0x30
    800066ac:	003e589b          	srliw	a7,t3,0x3
    800066b0:	00d866b3          	or	a3,a6,a3
    800066b4:	03859713          	slli	a4,a1,0x38
    800066b8:	00389813          	slli	a6,a7,0x3
    800066bc:	00f507b3          	add	a5,a0,a5
    800066c0:	00e6e733          	or	a4,a3,a4
    800066c4:	000e089b          	sext.w	a7,t3
    800066c8:	00f806b3          	add	a3,a6,a5
    800066cc:	00e7b023          	sd	a4,0(a5)
    800066d0:	00878793          	addi	a5,a5,8
    800066d4:	fed79ce3          	bne	a5,a3,800066cc <__memset+0xd4>
    800066d8:	ff8e7793          	andi	a5,t3,-8
    800066dc:	0007871b          	sext.w	a4,a5
    800066e0:	01d787bb          	addw	a5,a5,t4
    800066e4:	0ce88e63          	beq	a7,a4,800067c0 <__memset+0x1c8>
    800066e8:	00f50733          	add	a4,a0,a5
    800066ec:	00b70023          	sb	a1,0(a4)
    800066f0:	0017871b          	addiw	a4,a5,1
    800066f4:	0cc77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    800066f8:	00e50733          	add	a4,a0,a4
    800066fc:	00b70023          	sb	a1,0(a4)
    80006700:	0027871b          	addiw	a4,a5,2
    80006704:	0ac77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006708:	00e50733          	add	a4,a0,a4
    8000670c:	00b70023          	sb	a1,0(a4)
    80006710:	0037871b          	addiw	a4,a5,3
    80006714:	0ac77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006718:	00e50733          	add	a4,a0,a4
    8000671c:	00b70023          	sb	a1,0(a4)
    80006720:	0047871b          	addiw	a4,a5,4
    80006724:	08c77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006728:	00e50733          	add	a4,a0,a4
    8000672c:	00b70023          	sb	a1,0(a4)
    80006730:	0057871b          	addiw	a4,a5,5
    80006734:	08c77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006738:	00e50733          	add	a4,a0,a4
    8000673c:	00b70023          	sb	a1,0(a4)
    80006740:	0067871b          	addiw	a4,a5,6
    80006744:	06c77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006748:	00e50733          	add	a4,a0,a4
    8000674c:	00b70023          	sb	a1,0(a4)
    80006750:	0077871b          	addiw	a4,a5,7
    80006754:	06c77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006758:	00e50733          	add	a4,a0,a4
    8000675c:	00b70023          	sb	a1,0(a4)
    80006760:	0087871b          	addiw	a4,a5,8
    80006764:	04c77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006768:	00e50733          	add	a4,a0,a4
    8000676c:	00b70023          	sb	a1,0(a4)
    80006770:	0097871b          	addiw	a4,a5,9
    80006774:	04c77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006778:	00e50733          	add	a4,a0,a4
    8000677c:	00b70023          	sb	a1,0(a4)
    80006780:	00a7871b          	addiw	a4,a5,10
    80006784:	02c77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006788:	00e50733          	add	a4,a0,a4
    8000678c:	00b70023          	sb	a1,0(a4)
    80006790:	00b7871b          	addiw	a4,a5,11
    80006794:	02c77663          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    80006798:	00e50733          	add	a4,a0,a4
    8000679c:	00b70023          	sb	a1,0(a4)
    800067a0:	00c7871b          	addiw	a4,a5,12
    800067a4:	00c77e63          	bgeu	a4,a2,800067c0 <__memset+0x1c8>
    800067a8:	00e50733          	add	a4,a0,a4
    800067ac:	00b70023          	sb	a1,0(a4)
    800067b0:	00d7879b          	addiw	a5,a5,13
    800067b4:	00c7f663          	bgeu	a5,a2,800067c0 <__memset+0x1c8>
    800067b8:	00f507b3          	add	a5,a0,a5
    800067bc:	00b78023          	sb	a1,0(a5)
    800067c0:	00813403          	ld	s0,8(sp)
    800067c4:	01010113          	addi	sp,sp,16
    800067c8:	00008067          	ret
    800067cc:	00b00693          	li	a3,11
    800067d0:	e55ff06f          	j	80006624 <__memset+0x2c>
    800067d4:	00300e93          	li	t4,3
    800067d8:	ea5ff06f          	j	8000667c <__memset+0x84>
    800067dc:	00100e93          	li	t4,1
    800067e0:	e9dff06f          	j	8000667c <__memset+0x84>
    800067e4:	00000e93          	li	t4,0
    800067e8:	e95ff06f          	j	8000667c <__memset+0x84>
    800067ec:	00000793          	li	a5,0
    800067f0:	ef9ff06f          	j	800066e8 <__memset+0xf0>
    800067f4:	00200e93          	li	t4,2
    800067f8:	e85ff06f          	j	8000667c <__memset+0x84>
    800067fc:	00400e93          	li	t4,4
    80006800:	e7dff06f          	j	8000667c <__memset+0x84>
    80006804:	00500e93          	li	t4,5
    80006808:	e75ff06f          	j	8000667c <__memset+0x84>
    8000680c:	00600e93          	li	t4,6
    80006810:	e6dff06f          	j	8000667c <__memset+0x84>

0000000080006814 <__memmove>:
    80006814:	ff010113          	addi	sp,sp,-16
    80006818:	00813423          	sd	s0,8(sp)
    8000681c:	01010413          	addi	s0,sp,16
    80006820:	0e060863          	beqz	a2,80006910 <__memmove+0xfc>
    80006824:	fff6069b          	addiw	a3,a2,-1
    80006828:	0006881b          	sext.w	a6,a3
    8000682c:	0ea5e863          	bltu	a1,a0,8000691c <__memmove+0x108>
    80006830:	00758713          	addi	a4,a1,7
    80006834:	00a5e7b3          	or	a5,a1,a0
    80006838:	40a70733          	sub	a4,a4,a0
    8000683c:	0077f793          	andi	a5,a5,7
    80006840:	00f73713          	sltiu	a4,a4,15
    80006844:	00174713          	xori	a4,a4,1
    80006848:	0017b793          	seqz	a5,a5
    8000684c:	00e7f7b3          	and	a5,a5,a4
    80006850:	10078863          	beqz	a5,80006960 <__memmove+0x14c>
    80006854:	00900793          	li	a5,9
    80006858:	1107f463          	bgeu	a5,a6,80006960 <__memmove+0x14c>
    8000685c:	0036581b          	srliw	a6,a2,0x3
    80006860:	fff8081b          	addiw	a6,a6,-1
    80006864:	02081813          	slli	a6,a6,0x20
    80006868:	01d85893          	srli	a7,a6,0x1d
    8000686c:	00858813          	addi	a6,a1,8
    80006870:	00058793          	mv	a5,a1
    80006874:	00050713          	mv	a4,a0
    80006878:	01088833          	add	a6,a7,a6
    8000687c:	0007b883          	ld	a7,0(a5)
    80006880:	00878793          	addi	a5,a5,8
    80006884:	00870713          	addi	a4,a4,8
    80006888:	ff173c23          	sd	a7,-8(a4)
    8000688c:	ff0798e3          	bne	a5,a6,8000687c <__memmove+0x68>
    80006890:	ff867713          	andi	a4,a2,-8
    80006894:	02071793          	slli	a5,a4,0x20
    80006898:	0207d793          	srli	a5,a5,0x20
    8000689c:	00f585b3          	add	a1,a1,a5
    800068a0:	40e686bb          	subw	a3,a3,a4
    800068a4:	00f507b3          	add	a5,a0,a5
    800068a8:	06e60463          	beq	a2,a4,80006910 <__memmove+0xfc>
    800068ac:	0005c703          	lbu	a4,0(a1)
    800068b0:	00e78023          	sb	a4,0(a5)
    800068b4:	04068e63          	beqz	a3,80006910 <__memmove+0xfc>
    800068b8:	0015c603          	lbu	a2,1(a1)
    800068bc:	00100713          	li	a4,1
    800068c0:	00c780a3          	sb	a2,1(a5)
    800068c4:	04e68663          	beq	a3,a4,80006910 <__memmove+0xfc>
    800068c8:	0025c603          	lbu	a2,2(a1)
    800068cc:	00200713          	li	a4,2
    800068d0:	00c78123          	sb	a2,2(a5)
    800068d4:	02e68e63          	beq	a3,a4,80006910 <__memmove+0xfc>
    800068d8:	0035c603          	lbu	a2,3(a1)
    800068dc:	00300713          	li	a4,3
    800068e0:	00c781a3          	sb	a2,3(a5)
    800068e4:	02e68663          	beq	a3,a4,80006910 <__memmove+0xfc>
    800068e8:	0045c603          	lbu	a2,4(a1)
    800068ec:	00400713          	li	a4,4
    800068f0:	00c78223          	sb	a2,4(a5)
    800068f4:	00e68e63          	beq	a3,a4,80006910 <__memmove+0xfc>
    800068f8:	0055c603          	lbu	a2,5(a1)
    800068fc:	00500713          	li	a4,5
    80006900:	00c782a3          	sb	a2,5(a5)
    80006904:	00e68663          	beq	a3,a4,80006910 <__memmove+0xfc>
    80006908:	0065c703          	lbu	a4,6(a1)
    8000690c:	00e78323          	sb	a4,6(a5)
    80006910:	00813403          	ld	s0,8(sp)
    80006914:	01010113          	addi	sp,sp,16
    80006918:	00008067          	ret
    8000691c:	02061713          	slli	a4,a2,0x20
    80006920:	02075713          	srli	a4,a4,0x20
    80006924:	00e587b3          	add	a5,a1,a4
    80006928:	f0f574e3          	bgeu	a0,a5,80006830 <__memmove+0x1c>
    8000692c:	02069613          	slli	a2,a3,0x20
    80006930:	02065613          	srli	a2,a2,0x20
    80006934:	fff64613          	not	a2,a2
    80006938:	00e50733          	add	a4,a0,a4
    8000693c:	00c78633          	add	a2,a5,a2
    80006940:	fff7c683          	lbu	a3,-1(a5)
    80006944:	fff78793          	addi	a5,a5,-1
    80006948:	fff70713          	addi	a4,a4,-1
    8000694c:	00d70023          	sb	a3,0(a4)
    80006950:	fec798e3          	bne	a5,a2,80006940 <__memmove+0x12c>
    80006954:	00813403          	ld	s0,8(sp)
    80006958:	01010113          	addi	sp,sp,16
    8000695c:	00008067          	ret
    80006960:	02069713          	slli	a4,a3,0x20
    80006964:	02075713          	srli	a4,a4,0x20
    80006968:	00170713          	addi	a4,a4,1
    8000696c:	00e50733          	add	a4,a0,a4
    80006970:	00050793          	mv	a5,a0
    80006974:	0005c683          	lbu	a3,0(a1)
    80006978:	00178793          	addi	a5,a5,1
    8000697c:	00158593          	addi	a1,a1,1
    80006980:	fed78fa3          	sb	a3,-1(a5)
    80006984:	fee798e3          	bne	a5,a4,80006974 <__memmove+0x160>
    80006988:	f89ff06f          	j	80006910 <__memmove+0xfc>
	...
