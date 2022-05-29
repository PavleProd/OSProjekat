
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	49013103          	ld	sp,1168(sp) # 80007490 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	720030ef          	jal	ra,8000373c <start>

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
    8000100c:	559000ef          	jal	ra,80001d64 <_ZN3PCB10getContextEv>
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
    8000109c:	4d0000ef          	jal	ra,8000156c <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	4c5000ef          	jal	ra,80001d64 <_ZN3PCB10getContextEv>

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
    800013d0:	00006797          	auipc	a5,0x6
    800013d4:	0d87b783          	ld	a5,216(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
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

00000000800014ec <_Z4getcv>:

char getc () {
    800014ec:	ff010113          	addi	sp,sp,-16
    800014f0:	00113423          	sd	ra,8(sp)
    800014f4:	00813023          	sd	s0,0(sp)
    800014f8:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::getc;
    return (char)(size_t)callInterrupt(code);
    800014fc:	04100513          	li	a0,65
    80001500:	00000097          	auipc	ra,0x0
    80001504:	c70080e7          	jalr	-912(ra) # 80001170 <_Z13callInterruptm>
}
    80001508:	0ff57513          	andi	a0,a0,255
    8000150c:	00813083          	ld	ra,8(sp)
    80001510:	00013403          	ld	s0,0(sp)
    80001514:	01010113          	addi	sp,sp,16
    80001518:	00008067          	ret

000000008000151c <_Z4putcc>:

void putc(char c) {
    8000151c:	ff010113          	addi	sp,sp,-16
    80001520:	00113423          	sd	ra,8(sp)
    80001524:	00813023          	sd	s0,0(sp)
    80001528:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::putc;
    asm volatile("mv a1, a0"); // a1 = c
    8000152c:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001530:	04200513          	li	a0,66
    80001534:	00000097          	auipc	ra,0x0
    80001538:	c3c080e7          	jalr	-964(ra) # 80001170 <_Z13callInterruptm>
}
    8000153c:	00813083          	ld	ra,8(sp)
    80001540:	00013403          	ld	s0,0(sp)
    80001544:	01010113          	addi	sp,sp,16
    80001548:	00008067          	ret

000000008000154c <_ZN6Kernel10popSppSpieEv>:
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"
#include "../h/CCB.h"
#include "../h/syscall_c.h"
void Kernel::popSppSpie() {
    8000154c:	ff010113          	addi	sp,sp,-16
    80001550:	00813423          	sd	s0,8(sp)
    80001554:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001558:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    8000155c:	10200073          	sret
}
    80001560:	00813403          	ld	s0,8(sp)
    80001564:	01010113          	addi	sp,sp,16
    80001568:	00008067          	ret

000000008000156c <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    8000156c:	fa010113          	addi	sp,sp,-96
    80001570:	04113c23          	sd	ra,88(sp)
    80001574:	04813823          	sd	s0,80(sp)
    80001578:	04913423          	sd	s1,72(sp)
    8000157c:	05213023          	sd	s2,64(sp)
    80001580:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001584:	142027f3          	csrr	a5,scause
    80001588:	fcf43023          	sd	a5,-64(s0)
        return scause;
    8000158c:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001590:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001594:	141027f3          	csrr	a5,sepc
    80001598:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    8000159c:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    800015a0:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800015a4:	100027f3          	csrr	a5,sstatus
    800015a8:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    800015ac:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    800015b0:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800015b4:	fd843703          	ld	a4,-40(s0)
    800015b8:	00900793          	li	a5,9
    800015bc:	04f70263          	beq	a4,a5,80001600 <interruptHandler+0x94>
    800015c0:	fd843703          	ld	a4,-40(s0)
    800015c4:	00800793          	li	a5,8
    800015c8:	02f70c63          	beq	a4,a5,80001600 <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800015cc:	fd843703          	ld	a4,-40(s0)
    800015d0:	fff00793          	li	a5,-1
    800015d4:	03f79793          	slli	a5,a5,0x3f
    800015d8:	00178793          	addi	a5,a5,1
    800015dc:	2cf70663          	beq	a4,a5,800018a8 <interruptHandler+0x33c>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800015e0:	fd843703          	ld	a4,-40(s0)
    800015e4:	fff00793          	li	a5,-1
    800015e8:	03f79793          	slli	a5,a5,0x3f
    800015ec:	00978793          	addi	a5,a5,9
    800015f0:	30f70c63          	beq	a4,a5,80001908 <interruptHandler+0x39c>
        else {
            plic_complete(CONSOLE_IRQ);
        }
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800015f4:	00002097          	auipc	ra,0x2
    800015f8:	060080e7          	jalr	96(ra) # 80003654 <_Z10printErrorv>
    800015fc:	0840006f          	j	80001680 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001600:	fd043783          	ld	a5,-48(s0)
    80001604:	00478793          	addi	a5,a5,4
    80001608:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    8000160c:	00006797          	auipc	a5,0x6
    80001610:	e9c7b783          	ld	a5,-356(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001614:	0007b503          	ld	a0,0(a5)
    80001618:	01853703          	ld	a4,24(a0)
    8000161c:	05073783          	ld	a5,80(a4)
    80001620:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    80001624:	fa843783          	ld	a5,-88(s0)
    80001628:	04200693          	li	a3,66
    8000162c:	26f6e863          	bltu	a3,a5,8000189c <interruptHandler+0x330>
    80001630:	00279793          	slli	a5,a5,0x2
    80001634:	00005697          	auipc	a3,0x5
    80001638:	9ec68693          	addi	a3,a3,-1556 # 80006020 <CONSOLE_STATUS+0x10>
    8000163c:	00d787b3          	add	a5,a5,a3
    80001640:	0007a783          	lw	a5,0(a5)
    80001644:	00d787b3          	add	a5,a5,a3
    80001648:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    8000164c:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001650:	00651513          	slli	a0,a0,0x6
    80001654:	00001097          	auipc	ra,0x1
    80001658:	7c8080e7          	jalr	1992(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
    8000165c:	00006797          	auipc	a5,0x6
    80001660:	e4c7b783          	ld	a5,-436(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001664:	0007b783          	ld	a5,0(a5)
    80001668:	0187b783          	ld	a5,24(a5)
    8000166c:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001670:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001674:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001678:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000167c:	10079073          	csrw	sstatus,a5
    }

}
    80001680:	05813083          	ld	ra,88(sp)
    80001684:	05013403          	ld	s0,80(sp)
    80001688:	04813483          	ld	s1,72(sp)
    8000168c:	04013903          	ld	s2,64(sp)
    80001690:	06010113          	addi	sp,sp,96
    80001694:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001698:	05873503          	ld	a0,88(a4)
    8000169c:	00002097          	auipc	ra,0x2
    800016a0:	8e4080e7          	jalr	-1820(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
    800016a4:	00006797          	auipc	a5,0x6
    800016a8:	e047b783          	ld	a5,-508(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016ac:	0007b783          	ld	a5,0(a5)
    800016b0:	0187b783          	ld	a5,24(a5)
    800016b4:	04a7b823          	sd	a0,80(a5)
                break;
    800016b8:	fb9ff06f          	j	80001670 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    800016bc:	00006797          	auipc	a5,0x6
    800016c0:	dcc7b783          	ld	a5,-564(a5) # 80007488 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016c4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	43c080e7          	jalr	1084(ra) # 80001b04 <_ZN3PCB8dispatchEv>
                break;
    800016d0:	fa1ff06f          	j	80001670 <interruptHandler+0x104>
                PCB::running->finished = true;
    800016d4:	00100793          	li	a5,1
    800016d8:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    800016dc:	00006797          	auipc	a5,0x6
    800016e0:	dac7b783          	ld	a5,-596(a5) # 80007488 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016e4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	41c080e7          	jalr	1052(ra) # 80001b04 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016f0:	00006797          	auipc	a5,0x6
    800016f4:	db87b783          	ld	a5,-584(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016f8:	0007b783          	ld	a5,0(a5)
    800016fc:	0187b783          	ld	a5,24(a5)
    80001700:	0407b823          	sd	zero,80(a5)
                break;
    80001704:	f6dff06f          	j	80001670 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    80001708:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    8000170c:	0007b503          	ld	a0,0(a5)
    80001710:	00001097          	auipc	ra,0x1
    80001714:	c60080e7          	jalr	-928(ra) # 80002370 <_ZN9Scheduler3putEP3PCB>
                break;
    80001718:	f59ff06f          	j	80001670 <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    8000171c:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    80001720:	06873583          	ld	a1,104(a4)
    80001724:	06073503          	ld	a0,96(a4)
    80001728:	00000097          	auipc	ra,0x0
    8000172c:	5b4080e7          	jalr	1460(ra) # 80001cdc <_ZN3PCB14createProccessEPFvvEPv>
    80001730:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001734:	00006797          	auipc	a5,0x6
    80001738:	d747b783          	ld	a5,-652(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000173c:	0007b783          	ld	a5,0(a5)
    80001740:	0187b703          	ld	a4,24(a5)
    80001744:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001748:	0004b703          	ld	a4,0(s1)
    8000174c:	f20702e3          	beqz	a4,80001670 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001750:	0187b783          	ld	a5,24(a5)
    80001754:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001758:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    8000175c:	00008737          	lui	a4,0x8
    80001760:	00e787b3          	add	a5,a5,a4
    80001764:	0004b703          	ld	a4,0(s1)
    80001768:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    8000176c:	00f73823          	sd	a5,16(a4)
                break;
    80001770:	f01ff06f          	j	80001670 <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001774:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001778:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    8000177c:	01800513          	li	a0,24
    80001780:	00001097          	auipc	ra,0x1
    80001784:	5e8080e7          	jalr	1512(ra) # 80002d68 <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    80001788:	00053023          	sd	zero,0(a0)
    8000178c:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80001790:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001794:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001798:	00006797          	auipc	a5,0x6
    8000179c:	d107b783          	ld	a5,-752(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017a0:	0007b783          	ld	a5,0(a5)
    800017a4:	0187b783          	ld	a5,24(a5)
    800017a8:	0497b823          	sd	s1,80(a5)
                break;
    800017ac:	ec5ff06f          	j	80001670 <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // true kao proces treba da se blokira, false ako ne
    800017b0:	05873503          	ld	a0,88(a4)
    800017b4:	00001097          	auipc	ra,0x1
    800017b8:	528080e7          	jalr	1320(ra) # 80002cdc <_ZN3SCB4waitEv>
    800017bc:	00006797          	auipc	a5,0x6
    800017c0:	cec7b783          	ld	a5,-788(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017c4:	0007b783          	ld	a5,0(a5)
    800017c8:	0187b783          	ld	a5,24(a5)
    800017cc:	04a7b823          	sd	a0,80(a5)
                break;
    800017d0:	ea1ff06f          	j	80001670 <interruptHandler+0x104>
                PCB::running->registers[10] = (size_t)sem->signal(); // vraca pokazivac na PCB ako ga treba staviti u Scheduler
    800017d4:	05873503          	ld	a0,88(a4)
    800017d8:	00001097          	auipc	ra,0x1
    800017dc:	54c080e7          	jalr	1356(ra) # 80002d24 <_ZN3SCB6signalEv>
    800017e0:	00006797          	auipc	a5,0x6
    800017e4:	cc87b783          	ld	a5,-824(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017e8:	0007b783          	ld	a5,0(a5)
    800017ec:	0187b783          	ld	a5,24(a5)
    800017f0:	04a7b823          	sd	a0,80(a5)
                break;
    800017f4:	e7dff06f          	j	80001670 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017f8:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017fc:	00048513          	mv	a0,s1
    80001800:	00001097          	auipc	ra,0x1
    80001804:	5b8080e7          	jalr	1464(ra) # 80002db8 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    80001808:	e60484e3          	beqz	s1,80001670 <interruptHandler+0x104>
    8000180c:	00048513          	mv	a0,s1
    80001810:	00001097          	auipc	ra,0x1
    80001814:	580080e7          	jalr	1408(ra) # 80002d90 <_ZN3SCBdlEPv>
    80001818:	e59ff06f          	j	80001670 <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    8000181c:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    80001820:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    80001824:	00000097          	auipc	ra,0x0
    80001828:	158080e7          	jalr	344(ra) # 8000197c <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    8000182c:	e45ff06f          	j	80001670 <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    80001830:	05874583          	lbu	a1,88(a4)
    80001834:	00006517          	auipc	a0,0x6
    80001838:	c3c53503          	ld	a0,-964(a0) # 80007470 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	54c080e7          	jalr	1356(ra) # 80001d88 <_ZN8IOBuffer8pushBackEc>
                break;
    80001844:	e2dff06f          	j	80001670 <interruptHandler+0x104>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001848:	00006517          	auipc	a0,0x6
    8000184c:	c3053503          	ld	a0,-976(a0) # 80007478 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001850:	00000097          	auipc	ra,0x0
    80001854:	6d0080e7          	jalr	1744(ra) # 80001f20 <_ZN8IOBuffer9peekFrontEv>
    80001858:	00051e63          	bnez	a0,80001874 <interruptHandler+0x308>
                    sem_wait(CCB::inputBufferEmpty);
    8000185c:	00006797          	auipc	a5,0x6
    80001860:	c647b783          	ld	a5,-924(a5) # 800074c0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80001864:	0007b503          	ld	a0,0(a5)
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	b30080e7          	jalr	-1232(ra) # 80001398 <_Z8sem_waitP3SCB>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001870:	fd9ff06f          	j	80001848 <interruptHandler+0x2dc>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    80001874:	00006517          	auipc	a0,0x6
    80001878:	c0453503          	ld	a0,-1020(a0) # 80007478 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	614080e7          	jalr	1556(ra) # 80001e90 <_ZN8IOBuffer8popFrontEv>
    80001884:	00006797          	auipc	a5,0x6
    80001888:	c247b783          	ld	a5,-988(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000188c:	0007b783          	ld	a5,0(a5)
    80001890:	0187b783          	ld	a5,24(a5)
    80001894:	04a7b823          	sd	a0,80(a5)
                break;
    80001898:	dd9ff06f          	j	80001670 <interruptHandler+0x104>
                printError();
    8000189c:	00002097          	auipc	ra,0x2
    800018a0:	db8080e7          	jalr	-584(ra) # 80003654 <_Z10printErrorv>
                break;
    800018a4:	dcdff06f          	j	80001670 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800018a8:	00006497          	auipc	s1,0x6
    800018ac:	be04b483          	ld	s1,-1056(s1) # 80007488 <_GLOBAL_OFFSET_TABLE_+0x40>
    800018b0:	0004b783          	ld	a5,0(s1)
    800018b4:	00178793          	addi	a5,a5,1
    800018b8:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800018bc:	00000097          	auipc	ra,0x0
    800018c0:	150080e7          	jalr	336(ra) # 80001a0c <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800018c4:	00006797          	auipc	a5,0x6
    800018c8:	be47b783          	ld	a5,-1052(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018cc:	0007b783          	ld	a5,0(a5)
    800018d0:	0407b703          	ld	a4,64(a5)
    800018d4:	0004b783          	ld	a5,0(s1)
    800018d8:	00e7f863          	bgeu	a5,a4,800018e8 <interruptHandler+0x37c>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018dc:	00200793          	li	a5,2
    800018e0:	1447b073          	csrc	sip,a5
    }
    800018e4:	d9dff06f          	j	80001680 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    800018e8:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800018ec:	00000097          	auipc	ra,0x0
    800018f0:	218080e7          	jalr	536(ra) # 80001b04 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018f4:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018f8:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018fc:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001900:	10079073          	csrw	sstatus,a5
    }
    80001904:	fd9ff06f          	j	800018dc <interruptHandler+0x370>
        if(plic_claim() == CONSOLE_IRQ) {
    80001908:	00002097          	auipc	ra,0x2
    8000190c:	68c080e7          	jalr	1676(ra) # 80003f94 <plic_claim>
    80001910:	00a00793          	li	a5,10
    80001914:	04f51c63          	bne	a0,a5,8000196c <interruptHandler+0x400>
            if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) { // putc
    80001918:	00006797          	auipc	a5,0x6
    8000191c:	b487b783          	ld	a5,-1208(a5) # 80007460 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001920:	0007b483          	ld	s1,0(a5)
    80001924:	0004c783          	lbu	a5,0(s1)
    80001928:	0207f793          	andi	a5,a5,32
    8000192c:	02079463          	bnez	a5,80001954 <interruptHandler+0x3e8>
            if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) { // getc
    80001930:	0004c783          	lbu	a5,0(s1)
    80001934:	0017f793          	andi	a5,a5,1
    80001938:	d40784e3          	beqz	a5,80001680 <interruptHandler+0x114>
                sem_signal(CCB::semInput);
    8000193c:	00006797          	auipc	a5,0x6
    80001940:	b947b783          	ld	a5,-1132(a5) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001944:	0007b503          	ld	a0,0(a5)
    80001948:	00000097          	auipc	ra,0x0
    8000194c:	ac0080e7          	jalr	-1344(ra) # 80001408 <_Z10sem_signalP3SCB>
    80001950:	d31ff06f          	j	80001680 <interruptHandler+0x114>
                sem_signal(CCB::semOutput);
    80001954:	00006797          	auipc	a5,0x6
    80001958:	b647b783          	ld	a5,-1180(a5) # 800074b8 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000195c:	0007b503          	ld	a0,0(a5)
    80001960:	00000097          	auipc	ra,0x0
    80001964:	aa8080e7          	jalr	-1368(ra) # 80001408 <_Z10sem_signalP3SCB>
    80001968:	fc9ff06f          	j	80001930 <interruptHandler+0x3c4>
            plic_complete(CONSOLE_IRQ);
    8000196c:	00a00513          	li	a0,10
    80001970:	00002097          	auipc	ra,0x2
    80001974:	65c080e7          	jalr	1628(ra) # 80003fcc <plic_complete>
    80001978:	d09ff06f          	j	80001680 <interruptHandler+0x114>

000000008000197c <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    8000197c:	ff010113          	addi	sp,sp,-16
    80001980:	00813423          	sd	s0,8(sp)
    80001984:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001988:	00006797          	auipc	a5,0x6
    8000198c:	ba87b783          	ld	a5,-1112(a5) # 80007530 <_ZN17SleepingProcesses4headE>
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001990:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001994:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001998:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000199c:	00078e63          	beqz	a5,800019b8 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    800019a0:	0307b683          	ld	a3,48(a5)
    800019a4:	00e6fa63          	bgeu	a3,a4,800019b8 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    800019a8:	40d70733          	sub	a4,a4,a3
        prev = curr;
    800019ac:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    800019b0:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    800019b4:	fe9ff06f          	j	8000199c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    800019b8:	00100693          	li	a3,1
    800019bc:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    800019c0:	02060663          	beqz	a2,800019ec <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    800019c4:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    800019c8:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    800019cc:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    800019d0:	00078863          	beqz	a5,800019e0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019d4:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019d8:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    800019dc:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    800019e0:	00813403          	ld	s0,8(sp)
    800019e4:	01010113          	addi	sp,sp,16
    800019e8:	00008067          	ret
        head = process;
    800019ec:	00006717          	auipc	a4,0x6
    800019f0:	b4a73223          	sd	a0,-1212(a4) # 80007530 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    800019f4:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800019f8:	fe0784e3          	beqz	a5,800019e0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019fc:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001a00:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    80001a04:	02b7b823          	sd	a1,48(a5)
    }
    80001a08:	fd9ff06f          	j	800019e0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

0000000080001a0c <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    80001a0c:	00006517          	auipc	a0,0x6
    80001a10:	b2453503          	ld	a0,-1244(a0) # 80007530 <_ZN17SleepingProcesses4headE>
    80001a14:	08050063          	beqz	a0,80001a94 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    80001a18:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    80001a1c:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    80001a20:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    80001a24:	06050263          	beqz	a0,80001a88 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    80001a28:	03053783          	ld	a5,48(a0)
    80001a2c:	04079e63          	bnez	a5,80001a88 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    80001a30:	fe010113          	addi	sp,sp,-32
    80001a34:	00113c23          	sd	ra,24(sp)
    80001a38:	00813823          	sd	s0,16(sp)
    80001a3c:	00913423          	sd	s1,8(sp)
    80001a40:	02010413          	addi	s0,sp,32
    80001a44:	00c0006f          	j	80001a50 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    80001a48:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    80001a4c:	02079063          	bnez	a5,80001a6c <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    80001a50:	00053483          	ld	s1,0(a0)
        nextInList = next;
    80001a54:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001a58:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001a5c:	00001097          	auipc	ra,0x1
    80001a60:	914080e7          	jalr	-1772(ra) # 80002370 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001a64:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001a68:	fe0490e3          	bnez	s1,80001a48 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001a6c:	00006797          	auipc	a5,0x6
    80001a70:	aca7b223          	sd	a0,-1340(a5) # 80007530 <_ZN17SleepingProcesses4headE>
}
    80001a74:	01813083          	ld	ra,24(sp)
    80001a78:	01013403          	ld	s0,16(sp)
    80001a7c:	00813483          	ld	s1,8(sp)
    80001a80:	02010113          	addi	sp,sp,32
    80001a84:	00008067          	ret
    head = curr;
    80001a88:	00006797          	auipc	a5,0x6
    80001a8c:	aaa7b423          	sd	a0,-1368(a5) # 80007530 <_ZN17SleepingProcesses4headE>
    80001a90:	00008067          	ret
    80001a94:	00008067          	ret

0000000080001a98 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001a98:	ff010113          	addi	sp,sp,-16
    80001a9c:	00113423          	sd	ra,8(sp)
    80001aa0:	00813023          	sd	s0,0(sp)
    80001aa4:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001aa8:	00000097          	auipc	ra,0x0
    80001aac:	aa4080e7          	jalr	-1372(ra) # 8000154c <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001ab0:	00006797          	auipc	a5,0x6
    80001ab4:	a887b783          	ld	a5,-1400(a5) # 80007538 <_ZN3PCB7runningE>
    80001ab8:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001abc:	00070513          	mv	a0,a4
    running->main();
    80001ac0:	0207b783          	ld	a5,32(a5)
    80001ac4:	000780e7          	jalr	a5
    thread_exit();
    80001ac8:	fffff097          	auipc	ra,0xfffff
    80001acc:	7d8080e7          	jalr	2008(ra) # 800012a0 <_Z11thread_exitv>
}
    80001ad0:	00813083          	ld	ra,8(sp)
    80001ad4:	00013403          	ld	s0,0(sp)
    80001ad8:	01010113          	addi	sp,sp,16
    80001adc:	00008067          	ret

0000000080001ae0 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001ae0:	ff010113          	addi	sp,sp,-16
    80001ae4:	00813423          	sd	s0,8(sp)
    80001ae8:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001aec:	01300793          	li	a5,19
    80001af0:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001af4:	00000073          	ecall
}
    80001af8:	00813403          	ld	s0,8(sp)
    80001afc:	01010113          	addi	sp,sp,16
    80001b00:	00008067          	ret

0000000080001b04 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001b04:	fe010113          	addi	sp,sp,-32
    80001b08:	00113c23          	sd	ra,24(sp)
    80001b0c:	00813823          	sd	s0,16(sp)
    80001b10:	00913423          	sd	s1,8(sp)
    80001b14:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001b18:	00006497          	auipc	s1,0x6
    80001b1c:	a204b483          	ld	s1,-1504(s1) # 80007538 <_ZN3PCB7runningE>
        return finished;
    80001b20:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001b24:	00079663          	bnez	a5,80001b30 <_ZN3PCB8dispatchEv+0x2c>
    80001b28:	0294c783          	lbu	a5,41(s1)
    80001b2c:	04078263          	beqz	a5,80001b70 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b30:	00001097          	auipc	ra,0x1
    80001b34:	898080e7          	jalr	-1896(ra) # 800023c8 <_ZN9Scheduler3getEv>
    80001b38:	00006797          	auipc	a5,0x6
    80001b3c:	a0a7b023          	sd	a0,-1536(a5) # 80007538 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001b40:	04854783          	lbu	a5,72(a0)
    80001b44:	02078e63          	beqz	a5,80001b80 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b48:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001b4c:	01853583          	ld	a1,24(a0)
    80001b50:	0184b503          	ld	a0,24(s1)
    80001b54:	fffff097          	auipc	ra,0xfffff
    80001b58:	5d4080e7          	jalr	1492(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001b5c:	01813083          	ld	ra,24(sp)
    80001b60:	01013403          	ld	s0,16(sp)
    80001b64:	00813483          	ld	s1,8(sp)
    80001b68:	02010113          	addi	sp,sp,32
    80001b6c:	00008067          	ret
        Scheduler::put(old);
    80001b70:	00048513          	mv	a0,s1
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	7fc080e7          	jalr	2044(ra) # 80002370 <_ZN9Scheduler3putEP3PCB>
    80001b7c:	fb5ff06f          	j	80001b30 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001b80:	01853583          	ld	a1,24(a0)
    80001b84:	0184b503          	ld	a0,24(s1)
    80001b88:	fffff097          	auipc	ra,0xfffff
    80001b8c:	5b4080e7          	jalr	1460(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001b90:	fcdff06f          	j	80001b5c <_ZN3PCB8dispatchEv+0x58>

0000000080001b94 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001b94:	fe010113          	addi	sp,sp,-32
    80001b98:	00113c23          	sd	ra,24(sp)
    80001b9c:	00813823          	sd	s0,16(sp)
    80001ba0:	00913423          	sd	s1,8(sp)
    80001ba4:	02010413          	addi	s0,sp,32
    80001ba8:	00050493          	mv	s1,a0
    80001bac:	00053023          	sd	zero,0(a0)
    80001bb0:	00053c23          	sd	zero,24(a0)
    80001bb4:	02053823          	sd	zero,48(a0)
    80001bb8:	00100793          	li	a5,1
    80001bbc:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001bc0:	02050523          	sb	zero,42(a0)
    80001bc4:	020504a3          	sb	zero,41(a0)
    80001bc8:	02050423          	sb	zero,40(a0)
    main = main_;
    80001bcc:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001bd0:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001bd4:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001bd8:	10800513          	li	a0,264
    80001bdc:	00001097          	auipc	ra,0x1
    80001be0:	240080e7          	jalr	576(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
    80001be4:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001be8:	00008537          	lui	a0,0x8
    80001bec:	00001097          	auipc	ra,0x1
    80001bf0:	230080e7          	jalr	560(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
    80001bf4:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001bf8:	000087b7          	lui	a5,0x8
    80001bfc:	00f50533          	add	a0,a0,a5
    80001c00:	0184b783          	ld	a5,24(s1)
    80001c04:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001c08:	0184b783          	ld	a5,24(s1)
    80001c0c:	00000717          	auipc	a4,0x0
    80001c10:	e8c70713          	addi	a4,a4,-372 # 80001a98 <_ZN3PCB15proccessWrapperEv>
    80001c14:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001c18:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001c1c:	0204b783          	ld	a5,32(s1)
    80001c20:	00078c63          	beqz	a5,80001c38 <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001c24:	01813083          	ld	ra,24(sp)
    80001c28:	01013403          	ld	s0,16(sp)
    80001c2c:	00813483          	ld	s1,8(sp)
    80001c30:	02010113          	addi	sp,sp,32
    80001c34:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001c38:	04048423          	sb	zero,72(s1)
}
    80001c3c:	fe9ff06f          	j	80001c24 <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001c40 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001c40:	fe010113          	addi	sp,sp,-32
    80001c44:	00113c23          	sd	ra,24(sp)
    80001c48:	00813823          	sd	s0,16(sp)
    80001c4c:	00913423          	sd	s1,8(sp)
    80001c50:	02010413          	addi	s0,sp,32
    80001c54:	00050493          	mv	s1,a0
    delete[] stack;
    80001c58:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001c5c:	00050663          	beqz	a0,80001c68 <_ZN3PCBD1Ev+0x28>
    80001c60:	00001097          	auipc	ra,0x1
    80001c64:	acc080e7          	jalr	-1332(ra) # 8000272c <_ZdaPv>
    delete[] sysStack;
    80001c68:	0104b503          	ld	a0,16(s1)
    80001c6c:	00050663          	beqz	a0,80001c78 <_ZN3PCBD1Ev+0x38>
    80001c70:	00001097          	auipc	ra,0x1
    80001c74:	abc080e7          	jalr	-1348(ra) # 8000272c <_ZdaPv>
}
    80001c78:	01813083          	ld	ra,24(sp)
    80001c7c:	01013403          	ld	s0,16(sp)
    80001c80:	00813483          	ld	s1,8(sp)
    80001c84:	02010113          	addi	sp,sp,32
    80001c88:	00008067          	ret

0000000080001c8c <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001c8c:	ff010113          	addi	sp,sp,-16
    80001c90:	00113423          	sd	ra,8(sp)
    80001c94:	00813023          	sd	s0,0(sp)
    80001c98:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c9c:	00001097          	auipc	ra,0x1
    80001ca0:	180080e7          	jalr	384(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
}
    80001ca4:	00813083          	ld	ra,8(sp)
    80001ca8:	00013403          	ld	s0,0(sp)
    80001cac:	01010113          	addi	sp,sp,16
    80001cb0:	00008067          	ret

0000000080001cb4 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001cb4:	ff010113          	addi	sp,sp,-16
    80001cb8:	00113423          	sd	ra,8(sp)
    80001cbc:	00813023          	sd	s0,0(sp)
    80001cc0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001cc4:	00001097          	auipc	ra,0x1
    80001cc8:	2bc080e7          	jalr	700(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001ccc:	00813083          	ld	ra,8(sp)
    80001cd0:	00013403          	ld	s0,0(sp)
    80001cd4:	01010113          	addi	sp,sp,16
    80001cd8:	00008067          	ret

0000000080001cdc <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001cdc:	fd010113          	addi	sp,sp,-48
    80001ce0:	02113423          	sd	ra,40(sp)
    80001ce4:	02813023          	sd	s0,32(sp)
    80001ce8:	00913c23          	sd	s1,24(sp)
    80001cec:	01213823          	sd	s2,16(sp)
    80001cf0:	01313423          	sd	s3,8(sp)
    80001cf4:	03010413          	addi	s0,sp,48
    80001cf8:	00050913          	mv	s2,a0
    80001cfc:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001d00:	05000513          	li	a0,80
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	f88080e7          	jalr	-120(ra) # 80001c8c <_ZN3PCBnwEm>
    80001d0c:	00050493          	mv	s1,a0
    80001d10:	00098693          	mv	a3,s3
    80001d14:	00200613          	li	a2,2
    80001d18:	00090593          	mv	a1,s2
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	e78080e7          	jalr	-392(ra) # 80001b94 <_ZN3PCBC1EPFvvEmPv>
    80001d24:	0200006f          	j	80001d44 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001d28:	00050913          	mv	s2,a0
    80001d2c:	00048513          	mv	a0,s1
    80001d30:	00000097          	auipc	ra,0x0
    80001d34:	f84080e7          	jalr	-124(ra) # 80001cb4 <_ZN3PCBdlEPv>
    80001d38:	00090513          	mv	a0,s2
    80001d3c:	00007097          	auipc	ra,0x7
    80001d40:	94c080e7          	jalr	-1716(ra) # 80008688 <_Unwind_Resume>
}
    80001d44:	00048513          	mv	a0,s1
    80001d48:	02813083          	ld	ra,40(sp)
    80001d4c:	02013403          	ld	s0,32(sp)
    80001d50:	01813483          	ld	s1,24(sp)
    80001d54:	01013903          	ld	s2,16(sp)
    80001d58:	00813983          	ld	s3,8(sp)
    80001d5c:	03010113          	addi	sp,sp,48
    80001d60:	00008067          	ret

0000000080001d64 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001d64:	ff010113          	addi	sp,sp,-16
    80001d68:	00813423          	sd	s0,8(sp)
    80001d6c:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001d70:	00005797          	auipc	a5,0x5
    80001d74:	7c87b783          	ld	a5,1992(a5) # 80007538 <_ZN3PCB7runningE>
    80001d78:	0187b503          	ld	a0,24(a5)
    80001d7c:	00813403          	ld	s0,8(sp)
    80001d80:	01010113          	addi	sp,sp,16
    80001d84:	00008067          	ret

0000000080001d88 <_ZN8IOBuffer8pushBackEc>:
        sem_wait(semOutput);
    }
}


void IOBuffer::pushBack(char c) {
    80001d88:	fe010113          	addi	sp,sp,-32
    80001d8c:	00113c23          	sd	ra,24(sp)
    80001d90:	00813823          	sd	s0,16(sp)
    80001d94:	00913423          	sd	s1,8(sp)
    80001d98:	01213023          	sd	s2,0(sp)
    80001d9c:	02010413          	addi	s0,sp,32
    80001da0:	00050493          	mv	s1,a0
    80001da4:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001da8:	01000513          	li	a0,16
    80001dac:	00001097          	auipc	ra,0x1
    80001db0:	070080e7          	jalr	112(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001db4:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001db8:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001dbc:	0004b783          	ld	a5,0(s1)
    80001dc0:	02078863          	beqz	a5,80001df0 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001dc4:	0084b783          	ld	a5,8(s1)
    80001dc8:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001dcc:	0084b783          	ld	a5,8(s1)
    80001dd0:	0007b783          	ld	a5,0(a5)
    80001dd4:	00f4b423          	sd	a5,8(s1)
    }
}
    80001dd8:	01813083          	ld	ra,24(sp)
    80001ddc:	01013403          	ld	s0,16(sp)
    80001de0:	00813483          	ld	s1,8(sp)
    80001de4:	00013903          	ld	s2,0(sp)
    80001de8:	02010113          	addi	sp,sp,32
    80001dec:	00008067          	ret
        head = tail = newElem;
    80001df0:	00a4b423          	sd	a0,8(s1)
    80001df4:	00a4b023          	sd	a0,0(s1)
    80001df8:	fe1ff06f          	j	80001dd8 <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001dfc <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001dfc:	fe010113          	addi	sp,sp,-32
    80001e00:	00113c23          	sd	ra,24(sp)
    80001e04:	00813823          	sd	s0,16(sp)
    80001e08:	00913423          	sd	s1,8(sp)
    80001e0c:	01213023          	sd	s2,0(sp)
    80001e10:	02010413          	addi	s0,sp,32
    bool t = false;
    80001e14:	00000493          	li	s1,0
    80001e18:	0480006f          	j	80001e60 <_ZN3CCB9inputBodyEPv+0x64>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001e1c:	00005797          	auipc	a5,0x5
    80001e20:	6347b783          	ld	a5,1588(a5) # 80007450 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001e24:	0007b783          	ld	a5,0(a5)
    80001e28:	00005917          	auipc	s2,0x5
    80001e2c:	72090913          	addi	s2,s2,1824 # 80007548 <_ZN3CCB11inputBufferE>
    80001e30:	0007c583          	lbu	a1,0(a5)
    80001e34:	00090513          	mv	a0,s2
    80001e38:	00000097          	auipc	ra,0x0
    80001e3c:	f50080e7          	jalr	-176(ra) # 80001d88 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001e40:	01093503          	ld	a0,16(s2)
    80001e44:	fffff097          	auipc	ra,0xfffff
    80001e48:	5c4080e7          	jalr	1476(ra) # 80001408 <_Z10sem_signalP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001e4c:	0140006f          	j	80001e60 <_ZN3CCB9inputBodyEPv+0x64>
        sem_wait(CCB::semInput);
    80001e50:	00005517          	auipc	a0,0x5
    80001e54:	71053503          	ld	a0,1808(a0) # 80007560 <_ZN3CCB8semInputE>
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	540080e7          	jalr	1344(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001e60:	00005797          	auipc	a5,0x5
    80001e64:	6007b783          	ld	a5,1536(a5) # 80007460 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001e68:	0007b783          	ld	a5,0(a5)
    80001e6c:	0007c783          	lbu	a5,0(a5)
    80001e70:	0017f793          	andi	a5,a5,1
    80001e74:	fa0794e3          	bnez	a5,80001e1c <_ZN3CCB9inputBodyEPv+0x20>
        if(!t){
    80001e78:	fc049ce3          	bnez	s1,80001e50 <_ZN3CCB9inputBodyEPv+0x54>
            plic_complete(CONSOLE_IRQ);
    80001e7c:	00a00513          	li	a0,10
    80001e80:	00002097          	auipc	ra,0x2
    80001e84:	14c080e7          	jalr	332(ra) # 80003fcc <plic_complete>
            t = true;
    80001e88:	00100493          	li	s1,1
    80001e8c:	fc5ff06f          	j	80001e50 <_ZN3CCB9inputBodyEPv+0x54>

0000000080001e90 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001e90:	fe010113          	addi	sp,sp,-32
    80001e94:	00113c23          	sd	ra,24(sp)
    80001e98:	00813823          	sd	s0,16(sp)
    80001e9c:	00913423          	sd	s1,8(sp)
    80001ea0:	02010413          	addi	s0,sp,32
    80001ea4:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001ea8:	00053503          	ld	a0,0(a0)
    80001eac:	04050063          	beqz	a0,80001eec <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001eb0:	00053703          	ld	a4,0(a0)
    80001eb4:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001eb8:	0087b703          	ld	a4,8(a5)
    80001ebc:	02e50463          	beq	a0,a4,80001ee4 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001ec0:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001ec4:	00001097          	auipc	ra,0x1
    80001ec8:	0bc080e7          	jalr	188(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001ecc:	00048513          	mv	a0,s1
    80001ed0:	01813083          	ld	ra,24(sp)
    80001ed4:	01013403          	ld	s0,16(sp)
    80001ed8:	00813483          	ld	s1,8(sp)
    80001edc:	02010113          	addi	sp,sp,32
    80001ee0:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001ee4:	0007b423          	sd	zero,8(a5)
    80001ee8:	fd9ff06f          	j	80001ec0 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001eec:	00000493          	li	s1,0
    80001ef0:	fddff06f          	j	80001ecc <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001ef4 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001ef4:	ff010113          	addi	sp,sp,-16
    80001ef8:	00813423          	sd	s0,8(sp)
    80001efc:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001f00:	00853783          	ld	a5,8(a0)
    80001f04:	00078a63          	beqz	a5,80001f18 <_ZN8IOBuffer8peekBackEv+0x24>
    80001f08:	0087c503          	lbu	a0,8(a5)
}
    80001f0c:	00813403          	ld	s0,8(sp)
    80001f10:	01010113          	addi	sp,sp,16
    80001f14:	00008067          	ret
    return tail ? tail->data : 0;
    80001f18:	00000513          	li	a0,0
    80001f1c:	ff1ff06f          	j	80001f0c <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001f20 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001f20:	ff010113          	addi	sp,sp,-16
    80001f24:	00813423          	sd	s0,8(sp)
    80001f28:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001f2c:	00053783          	ld	a5,0(a0)
    80001f30:	00078a63          	beqz	a5,80001f44 <_ZN8IOBuffer9peekFrontEv+0x24>
    80001f34:	0087c503          	lbu	a0,8(a5)
}
    80001f38:	00813403          	ld	s0,8(sp)
    80001f3c:	01010113          	addi	sp,sp,16
    80001f40:	00008067          	ret
    return head ? head->data : 0;
    80001f44:	00000513          	li	a0,0
    80001f48:	ff1ff06f          	j	80001f38 <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001f4c <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001f4c:	fe010113          	addi	sp,sp,-32
    80001f50:	00113c23          	sd	ra,24(sp)
    80001f54:	00813823          	sd	s0,16(sp)
    80001f58:	00913423          	sd	s1,8(sp)
    80001f5c:	01213023          	sd	s2,0(sp)
    80001f60:	02010413          	addi	s0,sp,32
    bool t = false;
    80001f64:	00000493          	li	s1,0
    80001f68:	0280006f          	j	80001f90 <_ZN3CCB10outputBodyEPv+0x44>
        if(!t) {
    80001f6c:	00049a63          	bnez	s1,80001f80 <_ZN3CCB10outputBodyEPv+0x34>
            plic_complete(CONSOLE_IRQ);
    80001f70:	00a00513          	li	a0,10
    80001f74:	00002097          	auipc	ra,0x2
    80001f78:	058080e7          	jalr	88(ra) # 80003fcc <plic_complete>
            t = true;
    80001f7c:	00100493          	li	s1,1
        sem_wait(semOutput);
    80001f80:	00005517          	auipc	a0,0x5
    80001f84:	5f853503          	ld	a0,1528(a0) # 80007578 <_ZN3CCB9semOutputE>
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	410080e7          	jalr	1040(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001f90:	00005797          	auipc	a5,0x5
    80001f94:	4d07b783          	ld	a5,1232(a5) # 80007460 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001f98:	0007b783          	ld	a5,0(a5)
    80001f9c:	0007c783          	lbu	a5,0(a5)
    80001fa0:	0207f793          	andi	a5,a5,32
    80001fa4:	fc0784e3          	beqz	a5,80001f6c <_ZN3CCB10outputBodyEPv+0x20>
            if(outputBuffer.peekFront() == 0) break;
    80001fa8:	00005517          	auipc	a0,0x5
    80001fac:	5c050513          	addi	a0,a0,1472 # 80007568 <_ZN3CCB12outputBufferE>
    80001fb0:	00000097          	auipc	ra,0x0
    80001fb4:	f70080e7          	jalr	-144(ra) # 80001f20 <_ZN8IOBuffer9peekFrontEv>
    80001fb8:	fa050ae3          	beqz	a0,80001f6c <_ZN3CCB10outputBodyEPv+0x20>
            *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001fbc:	00005797          	auipc	a5,0x5
    80001fc0:	4c47b783          	ld	a5,1220(a5) # 80007480 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001fc4:	0007b903          	ld	s2,0(a5)
    80001fc8:	00005517          	auipc	a0,0x5
    80001fcc:	5a050513          	addi	a0,a0,1440 # 80007568 <_ZN3CCB12outputBufferE>
    80001fd0:	00000097          	auipc	ra,0x0
    80001fd4:	ec0080e7          	jalr	-320(ra) # 80001e90 <_ZN8IOBuffer8popFrontEv>
    80001fd8:	00a90023          	sb	a0,0(s2)
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001fdc:	fb5ff06f          	j	80001f90 <_ZN3CCB10outputBodyEPv+0x44>

0000000080001fe0 <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"
#include "../h/console.h"

BufferCPP::BufferCPP(int _cap) : cap(_cap), head(0), tail(0) {
    80001fe0:	fe010113          	addi	sp,sp,-32
    80001fe4:	00113c23          	sd	ra,24(sp)
    80001fe8:	00813823          	sd	s0,16(sp)
    80001fec:	00913423          	sd	s1,8(sp)
    80001ff0:	01213023          	sd	s2,0(sp)
    80001ff4:	02010413          	addi	s0,sp,32
    80001ff8:	00050493          	mv	s1,a0
    80001ffc:	00b52023          	sw	a1,0(a0)
    80002000:	00052823          	sw	zero,16(a0)
    80002004:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80002008:	00259513          	slli	a0,a1,0x2
    8000200c:	fffff097          	auipc	ra,0xfffff
    80002010:	188080e7          	jalr	392(ra) # 80001194 <_Z9mem_allocm>
    80002014:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80002018:	01000513          	li	a0,16
    8000201c:	00001097          	auipc	ra,0x1
    80002020:	a60080e7          	jalr	-1440(ra) # 80002a7c <_ZN9SemaphorenwEm>
    80002024:	00050913          	mv	s2,a0
    80002028:	00000593          	li	a1,0
    8000202c:	00001097          	auipc	ra,0x1
    80002030:	930080e7          	jalr	-1744(ra) # 8000295c <_ZN9SemaphoreC1Ej>
    80002034:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(cap);
    80002038:	01000513          	li	a0,16
    8000203c:	00001097          	auipc	ra,0x1
    80002040:	a40080e7          	jalr	-1472(ra) # 80002a7c <_ZN9SemaphorenwEm>
    80002044:	00050913          	mv	s2,a0
    80002048:	0004a583          	lw	a1,0(s1)
    8000204c:	00001097          	auipc	ra,0x1
    80002050:	910080e7          	jalr	-1776(ra) # 8000295c <_ZN9SemaphoreC1Ej>
    80002054:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80002058:	01000513          	li	a0,16
    8000205c:	00001097          	auipc	ra,0x1
    80002060:	a20080e7          	jalr	-1504(ra) # 80002a7c <_ZN9SemaphorenwEm>
    80002064:	00050913          	mv	s2,a0
    80002068:	00100593          	li	a1,1
    8000206c:	00001097          	auipc	ra,0x1
    80002070:	8f0080e7          	jalr	-1808(ra) # 8000295c <_ZN9SemaphoreC1Ej>
    80002074:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80002078:	01000513          	li	a0,16
    8000207c:	00001097          	auipc	ra,0x1
    80002080:	a00080e7          	jalr	-1536(ra) # 80002a7c <_ZN9SemaphorenwEm>
    80002084:	00050913          	mv	s2,a0
    80002088:	00100593          	li	a1,1
    8000208c:	00001097          	auipc	ra,0x1
    80002090:	8d0080e7          	jalr	-1840(ra) # 8000295c <_ZN9SemaphoreC1Ej>
    80002094:	0324b823          	sd	s2,48(s1)
}
    80002098:	01813083          	ld	ra,24(sp)
    8000209c:	01013403          	ld	s0,16(sp)
    800020a0:	00813483          	ld	s1,8(sp)
    800020a4:	00013903          	ld	s2,0(sp)
    800020a8:	02010113          	addi	sp,sp,32
    800020ac:	00008067          	ret
    800020b0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800020b4:	00090513          	mv	a0,s2
    800020b8:	00001097          	auipc	ra,0x1
    800020bc:	95c080e7          	jalr	-1700(ra) # 80002a14 <_ZN9SemaphoredlEPv>
    800020c0:	00048513          	mv	a0,s1
    800020c4:	00006097          	auipc	ra,0x6
    800020c8:	5c4080e7          	jalr	1476(ra) # 80008688 <_Unwind_Resume>
    800020cc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(cap);
    800020d0:	00090513          	mv	a0,s2
    800020d4:	00001097          	auipc	ra,0x1
    800020d8:	940080e7          	jalr	-1728(ra) # 80002a14 <_ZN9SemaphoredlEPv>
    800020dc:	00048513          	mv	a0,s1
    800020e0:	00006097          	auipc	ra,0x6
    800020e4:	5a8080e7          	jalr	1448(ra) # 80008688 <_Unwind_Resume>
    800020e8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800020ec:	00090513          	mv	a0,s2
    800020f0:	00001097          	auipc	ra,0x1
    800020f4:	924080e7          	jalr	-1756(ra) # 80002a14 <_ZN9SemaphoredlEPv>
    800020f8:	00048513          	mv	a0,s1
    800020fc:	00006097          	auipc	ra,0x6
    80002100:	58c080e7          	jalr	1420(ra) # 80008688 <_Unwind_Resume>
    80002104:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80002108:	00090513          	mv	a0,s2
    8000210c:	00001097          	auipc	ra,0x1
    80002110:	908080e7          	jalr	-1784(ra) # 80002a14 <_ZN9SemaphoredlEPv>
    80002114:	00048513          	mv	a0,s1
    80002118:	00006097          	auipc	ra,0x6
    8000211c:	570080e7          	jalr	1392(ra) # 80008688 <_Unwind_Resume>

0000000080002120 <_ZN9BufferCPPD1Ev>:

BufferCPP::~BufferCPP() {
    80002120:	fe010113          	addi	sp,sp,-32
    80002124:	00113c23          	sd	ra,24(sp)
    80002128:	00813823          	sd	s0,16(sp)
    8000212c:	00913423          	sd	s1,8(sp)
    80002130:	02010413          	addi	s0,sp,32
    80002134:	00050493          	mv	s1,a0
    __putc('\n');
    80002138:	00a00513          	li	a0,10
    8000213c:	00003097          	auipc	ra,0x3
    80002140:	6c0080e7          	jalr	1728(ra) # 800057fc <__putc>
    printString("Buffer deleted!\n");
    80002144:	00004517          	auipc	a0,0x4
    80002148:	fec50513          	addi	a0,a0,-20 # 80006130 <CONSOLE_STATUS+0x120>
    8000214c:	00001097          	auipc	ra,0x1
    80002150:	25c080e7          	jalr	604(ra) # 800033a8 <_Z11printStringPKc>
    while (head != tail) {
    80002154:	0104a783          	lw	a5,16(s1)
    80002158:	0144a703          	lw	a4,20(s1)
    8000215c:	02e78a63          	beq	a5,a4,80002190 <_ZN9BufferCPPD1Ev+0x70>
        char ch = buffer[head];
    80002160:	0084b703          	ld	a4,8(s1)
    80002164:	00279793          	slli	a5,a5,0x2
    80002168:	00f707b3          	add	a5,a4,a5
        __putc(ch);
    8000216c:	0007c503          	lbu	a0,0(a5)
    80002170:	00003097          	auipc	ra,0x3
    80002174:	68c080e7          	jalr	1676(ra) # 800057fc <__putc>
        head = (head + 1) % cap;
    80002178:	0104a783          	lw	a5,16(s1)
    8000217c:	0017879b          	addiw	a5,a5,1
    80002180:	0004a703          	lw	a4,0(s1)
    80002184:	02e7e7bb          	remw	a5,a5,a4
    80002188:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    8000218c:	fc9ff06f          	j	80002154 <_ZN9BufferCPPD1Ev+0x34>
    }
    __putc('!');
    80002190:	02100513          	li	a0,33
    80002194:	00003097          	auipc	ra,0x3
    80002198:	668080e7          	jalr	1640(ra) # 800057fc <__putc>
    __putc('\n');
    8000219c:	00a00513          	li	a0,10
    800021a0:	00003097          	auipc	ra,0x3
    800021a4:	65c080e7          	jalr	1628(ra) # 800057fc <__putc>

    mem_free(buffer);
    800021a8:	0084b503          	ld	a0,8(s1)
    800021ac:	fffff097          	auipc	ra,0xfffff
    800021b0:	028080e7          	jalr	40(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    800021b4:	0204b503          	ld	a0,32(s1)
    800021b8:	00050863          	beqz	a0,800021c8 <_ZN9BufferCPPD1Ev+0xa8>
    800021bc:	00053783          	ld	a5,0(a0)
    800021c0:	0087b783          	ld	a5,8(a5)
    800021c4:	000780e7          	jalr	a5
    delete spaceAvailable;
    800021c8:	0184b503          	ld	a0,24(s1)
    800021cc:	00050863          	beqz	a0,800021dc <_ZN9BufferCPPD1Ev+0xbc>
    800021d0:	00053783          	ld	a5,0(a0)
    800021d4:	0087b783          	ld	a5,8(a5)
    800021d8:	000780e7          	jalr	a5
    delete mutexTail;
    800021dc:	0304b503          	ld	a0,48(s1)
    800021e0:	00050863          	beqz	a0,800021f0 <_ZN9BufferCPPD1Ev+0xd0>
    800021e4:	00053783          	ld	a5,0(a0)
    800021e8:	0087b783          	ld	a5,8(a5)
    800021ec:	000780e7          	jalr	a5
    delete mutexHead;
    800021f0:	0284b503          	ld	a0,40(s1)
    800021f4:	00050863          	beqz	a0,80002204 <_ZN9BufferCPPD1Ev+0xe4>
    800021f8:	00053783          	ld	a5,0(a0)
    800021fc:	0087b783          	ld	a5,8(a5)
    80002200:	000780e7          	jalr	a5

}
    80002204:	01813083          	ld	ra,24(sp)
    80002208:	01013403          	ld	s0,16(sp)
    8000220c:	00813483          	ld	s1,8(sp)
    80002210:	02010113          	addi	sp,sp,32
    80002214:	00008067          	ret

0000000080002218 <_ZN9BufferCPP3putEi>:

void BufferCPP::put(int val) {
    80002218:	fe010113          	addi	sp,sp,-32
    8000221c:	00113c23          	sd	ra,24(sp)
    80002220:	00813823          	sd	s0,16(sp)
    80002224:	00913423          	sd	s1,8(sp)
    80002228:	01213023          	sd	s2,0(sp)
    8000222c:	02010413          	addi	s0,sp,32
    80002230:	00050493          	mv	s1,a0
    80002234:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80002238:	01853503          	ld	a0,24(a0)
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	780080e7          	jalr	1920(ra) # 800029bc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80002244:	0304b503          	ld	a0,48(s1)
    80002248:	00000097          	auipc	ra,0x0
    8000224c:	774080e7          	jalr	1908(ra) # 800029bc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80002250:	0084b783          	ld	a5,8(s1)
    80002254:	0144a703          	lw	a4,20(s1)
    80002258:	00271713          	slli	a4,a4,0x2
    8000225c:	00e787b3          	add	a5,a5,a4
    80002260:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002264:	0144a783          	lw	a5,20(s1)
    80002268:	0017879b          	addiw	a5,a5,1
    8000226c:	0004a703          	lw	a4,0(s1)
    80002270:	02e7e7bb          	remw	a5,a5,a4
    80002274:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80002278:	0304b503          	ld	a0,48(s1)
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	76c080e7          	jalr	1900(ra) # 800029e8 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80002284:	0204b503          	ld	a0,32(s1)
    80002288:	00000097          	auipc	ra,0x0
    8000228c:	760080e7          	jalr	1888(ra) # 800029e8 <_ZN9Semaphore6signalEv>

}
    80002290:	01813083          	ld	ra,24(sp)
    80002294:	01013403          	ld	s0,16(sp)
    80002298:	00813483          	ld	s1,8(sp)
    8000229c:	00013903          	ld	s2,0(sp)
    800022a0:	02010113          	addi	sp,sp,32
    800022a4:	00008067          	ret

00000000800022a8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800022a8:	fe010113          	addi	sp,sp,-32
    800022ac:	00113c23          	sd	ra,24(sp)
    800022b0:	00813823          	sd	s0,16(sp)
    800022b4:	00913423          	sd	s1,8(sp)
    800022b8:	01213023          	sd	s2,0(sp)
    800022bc:	02010413          	addi	s0,sp,32
    800022c0:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800022c4:	02053503          	ld	a0,32(a0)
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	6f4080e7          	jalr	1780(ra) # 800029bc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800022d0:	0284b503          	ld	a0,40(s1)
    800022d4:	00000097          	auipc	ra,0x0
    800022d8:	6e8080e7          	jalr	1768(ra) # 800029bc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800022dc:	0084b703          	ld	a4,8(s1)
    800022e0:	0104a783          	lw	a5,16(s1)
    800022e4:	00279693          	slli	a3,a5,0x2
    800022e8:	00d70733          	add	a4,a4,a3
    800022ec:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800022f0:	0017879b          	addiw	a5,a5,1
    800022f4:	0004a703          	lw	a4,0(s1)
    800022f8:	02e7e7bb          	remw	a5,a5,a4
    800022fc:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80002300:	0284b503          	ld	a0,40(s1)
    80002304:	00000097          	auipc	ra,0x0
    80002308:	6e4080e7          	jalr	1764(ra) # 800029e8 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000230c:	0184b503          	ld	a0,24(s1)
    80002310:	00000097          	auipc	ra,0x0
    80002314:	6d8080e7          	jalr	1752(ra) # 800029e8 <_ZN9Semaphore6signalEv>

    return ret;
}
    80002318:	00090513          	mv	a0,s2
    8000231c:	01813083          	ld	ra,24(sp)
    80002320:	01013403          	ld	s0,16(sp)
    80002324:	00813483          	ld	s1,8(sp)
    80002328:	00013903          	ld	s2,0(sp)
    8000232c:	02010113          	addi	sp,sp,32
    80002330:	00008067          	ret

0000000080002334 <_Z8userMainv>:
    __putc('\n');
}*/



void userMain() {
    80002334:	ff010113          	addi	sp,sp,-16
    80002338:	00113423          	sd	ra,8(sp)
    8000233c:	00813023          	sd	s0,0(sp)
    80002340:	01010413          	addi	s0,sp,16
    }

    for(auto& proces : procesi) {
        delete proces;
    }*/
    time_sleep(10);
    80002344:	00a00513          	li	a0,10
    80002348:	fffff097          	auipc	ra,0xfffff
    8000234c:	15c080e7          	jalr	348(ra) # 800014a4 <_Z10time_sleepm>
    char c = __getc();
    80002350:	00003097          	auipc	ra,0x3
    80002354:	4e8080e7          	jalr	1256(ra) # 80005838 <__getc>
    __putc(c);
    80002358:	00003097          	auipc	ra,0x3
    8000235c:	4a4080e7          	jalr	1188(ra) # 800057fc <__putc>
}
    80002360:	00813083          	ld	ra,8(sp)
    80002364:	00013403          	ld	s0,0(sp)
    80002368:	01010113          	addi	sp,sp,16
    8000236c:	00008067          	ret

0000000080002370 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002370:	ff010113          	addi	sp,sp,-16
    80002374:	00813423          	sd	s0,8(sp)
    80002378:	01010413          	addi	s0,sp,16
    if(!process) return;
    8000237c:	02050663          	beqz	a0,800023a8 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002380:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002384:	00005797          	auipc	a5,0x5
    80002388:	20c7b783          	ld	a5,524(a5) # 80007590 <_ZN9Scheduler4tailE>
    8000238c:	02078463          	beqz	a5,800023b4 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002390:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002394:	00005797          	auipc	a5,0x5
    80002398:	1fc78793          	addi	a5,a5,508 # 80007590 <_ZN9Scheduler4tailE>
    8000239c:	0007b703          	ld	a4,0(a5)
    800023a0:	00073703          	ld	a4,0(a4)
    800023a4:	00e7b023          	sd	a4,0(a5)
    }
}
    800023a8:	00813403          	ld	s0,8(sp)
    800023ac:	01010113          	addi	sp,sp,16
    800023b0:	00008067          	ret
        head = tail = process;
    800023b4:	00005797          	auipc	a5,0x5
    800023b8:	1dc78793          	addi	a5,a5,476 # 80007590 <_ZN9Scheduler4tailE>
    800023bc:	00a7b023          	sd	a0,0(a5)
    800023c0:	00a7b423          	sd	a0,8(a5)
    800023c4:	fe5ff06f          	j	800023a8 <_ZN9Scheduler3putEP3PCB+0x38>

00000000800023c8 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800023c8:	ff010113          	addi	sp,sp,-16
    800023cc:	00813423          	sd	s0,8(sp)
    800023d0:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800023d4:	00005517          	auipc	a0,0x5
    800023d8:	1c453503          	ld	a0,452(a0) # 80007598 <_ZN9Scheduler4headE>
    800023dc:	02050463          	beqz	a0,80002404 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    800023e0:	00053703          	ld	a4,0(a0)
    800023e4:	00005797          	auipc	a5,0x5
    800023e8:	1ac78793          	addi	a5,a5,428 # 80007590 <_ZN9Scheduler4tailE>
    800023ec:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800023f0:	0007b783          	ld	a5,0(a5)
    800023f4:	00f50e63          	beq	a0,a5,80002410 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    800023f8:	00813403          	ld	s0,8(sp)
    800023fc:	01010113          	addi	sp,sp,16
    80002400:	00008067          	ret
        return idleProcess;
    80002404:	00005517          	auipc	a0,0x5
    80002408:	19c53503          	ld	a0,412(a0) # 800075a0 <_ZN9Scheduler11idleProcessE>
    8000240c:	fedff06f          	j	800023f8 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002410:	00005797          	auipc	a5,0x5
    80002414:	18e7b023          	sd	a4,384(a5) # 80007590 <_ZN9Scheduler4tailE>
    80002418:	fe1ff06f          	j	800023f8 <_ZN9Scheduler3getEv+0x30>

000000008000241c <idleProcess>:
    sepc += 4;
    Kernel::w_sepc(sepc);
    asm volatile("sret");
}

extern "C" void idleProcess(void* arg) {
    8000241c:	ff010113          	addi	sp,sp,-16
    80002420:	00813423          	sd	s0,8(sp)
    80002424:	01010413          	addi	s0,sp,16
    while(true) {}
    80002428:	0000006f          	j	80002428 <idleProcess+0xc>

000000008000242c <userMode>:
extern "C" void userMode() {
    8000242c:	fe010113          	addi	sp,sp,-32
    80002430:	00813c23          	sd	s0,24(sp)
    80002434:	02010413          	addi	s0,sp,32
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002438:	00005797          	auipc	a5,0x5
    8000243c:	0907b783          	ld	a5,144(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002440:	10579073          	csrw	stvec,a5
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002444:	10000793          	li	a5,256
    80002448:	1007b073          	csrc	sstatus,a5
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000244c:	141027f3          	csrr	a5,sepc
    80002450:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80002454:	fe043783          	ld	a5,-32(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80002458:	fef43423          	sd	a5,-24(s0)
    sepc += 4;
    8000245c:	fe843783          	ld	a5,-24(s0)
    80002460:	00478793          	addi	a5,a5,4
    80002464:	fef43423          	sd	a5,-24(s0)
    Kernel::w_sepc(sepc);
    80002468:	fe843783          	ld	a5,-24(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000246c:	14179073          	csrw	sepc,a5
    asm volatile("sret");
    80002470:	10200073          	sret
}
    80002474:	01813403          	ld	s0,24(sp)
    80002478:	02010113          	addi	sp,sp,32
    8000247c:	00008067          	ret

0000000080002480 <main>:
}
// ------------

int main() {
    80002480:	ff010113          	addi	sp,sp,-16
    80002484:	00113423          	sd	ra,8(sp)
    80002488:	00813023          	sd	s0,0(sp)
    8000248c:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    //asm volatile("csrw stvec, %0" : : "r" (&userMode));
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002490:	00005797          	auipc	a5,0x5
    80002494:	0387b783          	ld	a5,56(a5) # 800074c8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002498:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    8000249c:	00000593          	li	a1,0
    800024a0:	00000513          	li	a0,0
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	838080e7          	jalr	-1992(ra) # 80001cdc <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    800024ac:	00005797          	auipc	a5,0x5
    800024b0:	ffc7b783          	ld	a5,-4(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800024b4:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    800024b8:	00000593          	li	a1,0
    800024bc:	00005517          	auipc	a0,0x5
    800024c0:	01453503          	ld	a0,20(a0) # 800074d0 <_GLOBAL_OFFSET_TABLE_+0x88>
    800024c4:	fffff097          	auipc	ra,0xfffff
    800024c8:	e8c080e7          	jalr	-372(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    800024cc:	00000593          	li	a1,0
    800024d0:	00005517          	auipc	a0,0x5
    800024d4:	fe853503          	ld	a0,-24(a0) # 800074b8 <_GLOBAL_OFFSET_TABLE_+0x70>
    800024d8:	fffff097          	auipc	ra,0xfffff
    800024dc:	e78080e7          	jalr	-392(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    800024e0:	00000593          	li	a1,0
    800024e4:	00005517          	auipc	a0,0x5
    800024e8:	fdc53503          	ld	a0,-36(a0) # 800074c0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800024ec:	fffff097          	auipc	ra,0xfffff
    800024f0:	e64080e7          	jalr	-412(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800024f4:	00200793          	li	a5,2
    800024f8:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    800024fc:	00000613          	li	a2,0
    80002500:	00005597          	auipc	a1,0x5
    80002504:	f985b583          	ld	a1,-104(a1) # 80007498 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002508:	00005517          	auipc	a0,0x5
    8000250c:	fd853503          	ld	a0,-40(a0) # 800074e0 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002510:	fffff097          	auipc	ra,0xfffff
    80002514:	df0080e7          	jalr	-528(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002518:	00000613          	li	a2,0
    8000251c:	00005597          	auipc	a1,0x5
    80002520:	fbc5b583          	ld	a1,-68(a1) # 800074d8 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002524:	00005517          	auipc	a0,0x5
    80002528:	f3453503          	ld	a0,-204(a0) # 80007458 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000252c:	fffff097          	auipc	ra,0xfffff
    80002530:	dd4080e7          	jalr	-556(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002534:	00000613          	li	a2,0
    80002538:	00000597          	auipc	a1,0x0
    8000253c:	ee458593          	addi	a1,a1,-284 # 8000241c <idleProcess>
    80002540:	00005517          	auipc	a0,0x5
    80002544:	f6053503          	ld	a0,-160(a0) # 800074a0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002548:	fffff097          	auipc	ra,0xfffff
    8000254c:	cc0080e7          	jalr	-832(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>

    //asm volatile("ecall"); // da bismo presli u korisnicki rezim
    // ----
    putc('g');
    80002550:	06700513          	li	a0,103
    80002554:	fffff097          	auipc	ra,0xfffff
    80002558:	fc8080e7          	jalr	-56(ra) # 8000151c <_Z4putcc>
    putc('d');
    8000255c:	06400513          	li	a0,100
    80002560:	fffff097          	auipc	ra,0xfffff
    80002564:	fbc080e7          	jalr	-68(ra) # 8000151c <_Z4putcc>
    //char c = getc();
    //putc(c);
    putc('e');
    80002568:	06500513          	li	a0,101
    8000256c:	fffff097          	auipc	ra,0xfffff
    80002570:	fb0080e7          	jalr	-80(ra) # 8000151c <_Z4putcc>
    putc(' ');
    80002574:	02000513          	li	a0,32
    80002578:	fffff097          	auipc	ra,0xfffff
    8000257c:	fa4080e7          	jalr	-92(ra) # 8000151c <_Z4putcc>
    putc('l');
    80002580:	06c00513          	li	a0,108
    80002584:	fffff097          	auipc	ra,0xfffff
    80002588:	f98080e7          	jalr	-104(ra) # 8000151c <_Z4putcc>
    putc('a');
    8000258c:	06100513          	li	a0,97
    80002590:	fffff097          	auipc	ra,0xfffff
    80002594:	f8c080e7          	jalr	-116(ra) # 8000151c <_Z4putcc>
    putc('k');
    80002598:	06b00513          	li	a0,107
    8000259c:	fffff097          	auipc	ra,0xfffff
    800025a0:	f80080e7          	jalr	-128(ra) # 8000151c <_Z4putcc>
    putc('o');
    800025a4:	06f00513          	li	a0,111
    800025a8:	fffff097          	auipc	ra,0xfffff
    800025ac:	f74080e7          	jalr	-140(ra) # 8000151c <_Z4putcc>
    //userMain();
    //__putc('l');
    //while(true) {}
    //time_sleep(100);
    return 0;
    800025b0:	00000513          	li	a0,0
    800025b4:	00813083          	ld	ra,8(sp)
    800025b8:	00013403          	ld	s0,0(sp)
    800025bc:	01010113          	addi	sp,sp,16
    800025c0:	00008067          	ret

00000000800025c4 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    800025c4:	fe010113          	addi	sp,sp,-32
    800025c8:	00113c23          	sd	ra,24(sp)
    800025cc:	00813823          	sd	s0,16(sp)
    800025d0:	00913423          	sd	s1,8(sp)
    800025d4:	02010413          	addi	s0,sp,32
    800025d8:	00005797          	auipc	a5,0x5
    800025dc:	e2078793          	addi	a5,a5,-480 # 800073f8 <_ZTV6Thread+0x10>
    800025e0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800025e4:	00853483          	ld	s1,8(a0)
    800025e8:	00048e63          	beqz	s1,80002604 <_ZN6ThreadD1Ev+0x40>
    800025ec:	00048513          	mv	a0,s1
    800025f0:	fffff097          	auipc	ra,0xfffff
    800025f4:	650080e7          	jalr	1616(ra) # 80001c40 <_ZN3PCBD1Ev>
    800025f8:	00048513          	mv	a0,s1
    800025fc:	fffff097          	auipc	ra,0xfffff
    80002600:	6b8080e7          	jalr	1720(ra) # 80001cb4 <_ZN3PCBdlEPv>
}
    80002604:	01813083          	ld	ra,24(sp)
    80002608:	01013403          	ld	s0,16(sp)
    8000260c:	00813483          	ld	s1,8(sp)
    80002610:	02010113          	addi	sp,sp,32
    80002614:	00008067          	ret

0000000080002618 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002618:	ff010113          	addi	sp,sp,-16
    8000261c:	00113423          	sd	ra,8(sp)
    80002620:	00813023          	sd	s0,0(sp)
    80002624:	01010413          	addi	s0,sp,16
    80002628:	00005797          	auipc	a5,0x5
    8000262c:	df878793          	addi	a5,a5,-520 # 80007420 <_ZTV9Semaphore+0x10>
    80002630:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002634:	00853503          	ld	a0,8(a0)
    80002638:	fffff097          	auipc	ra,0xfffff
    8000263c:	e2c080e7          	jalr	-468(ra) # 80001464 <_Z9sem_closeP3SCB>
}
    80002640:	00813083          	ld	ra,8(sp)
    80002644:	00013403          	ld	s0,0(sp)
    80002648:	01010113          	addi	sp,sp,16
    8000264c:	00008067          	ret

0000000080002650 <_Znwm>:
void* operator new (size_t size) {
    80002650:	ff010113          	addi	sp,sp,-16
    80002654:	00113423          	sd	ra,8(sp)
    80002658:	00813023          	sd	s0,0(sp)
    8000265c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002660:	fffff097          	auipc	ra,0xfffff
    80002664:	b34080e7          	jalr	-1228(ra) # 80001194 <_Z9mem_allocm>
}
    80002668:	00813083          	ld	ra,8(sp)
    8000266c:	00013403          	ld	s0,0(sp)
    80002670:	01010113          	addi	sp,sp,16
    80002674:	00008067          	ret

0000000080002678 <_Znam>:
void* operator new [](size_t size) {
    80002678:	ff010113          	addi	sp,sp,-16
    8000267c:	00113423          	sd	ra,8(sp)
    80002680:	00813023          	sd	s0,0(sp)
    80002684:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002688:	fffff097          	auipc	ra,0xfffff
    8000268c:	b0c080e7          	jalr	-1268(ra) # 80001194 <_Z9mem_allocm>
}
    80002690:	00813083          	ld	ra,8(sp)
    80002694:	00013403          	ld	s0,0(sp)
    80002698:	01010113          	addi	sp,sp,16
    8000269c:	00008067          	ret

00000000800026a0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800026a0:	ff010113          	addi	sp,sp,-16
    800026a4:	00113423          	sd	ra,8(sp)
    800026a8:	00813023          	sd	s0,0(sp)
    800026ac:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800026b0:	fffff097          	auipc	ra,0xfffff
    800026b4:	b24080e7          	jalr	-1244(ra) # 800011d4 <_Z8mem_freePv>
}
    800026b8:	00813083          	ld	ra,8(sp)
    800026bc:	00013403          	ld	s0,0(sp)
    800026c0:	01010113          	addi	sp,sp,16
    800026c4:	00008067          	ret

00000000800026c8 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    800026c8:	fe010113          	addi	sp,sp,-32
    800026cc:	00113c23          	sd	ra,24(sp)
    800026d0:	00813823          	sd	s0,16(sp)
    800026d4:	00913423          	sd	s1,8(sp)
    800026d8:	02010413          	addi	s0,sp,32
    800026dc:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    800026e0:	00053503          	ld	a0,0(a0)
    800026e4:	0104b783          	ld	a5,16(s1)
    800026e8:	00f50533          	add	a0,a0,a5
    800026ec:	0084b783          	ld	a5,8(s1)
    800026f0:	0017f713          	andi	a4,a5,1
    800026f4:	00070863          	beqz	a4,80002704 <_Z13threadWrapperPv+0x3c>
    800026f8:	00053703          	ld	a4,0(a0)
    800026fc:	00f707b3          	add	a5,a4,a5
    80002700:	fff7b783          	ld	a5,-1(a5)
    80002704:	000780e7          	jalr	a5
    delete tArg;
    80002708:	00048863          	beqz	s1,80002718 <_Z13threadWrapperPv+0x50>
    8000270c:	00048513          	mv	a0,s1
    80002710:	00000097          	auipc	ra,0x0
    80002714:	f90080e7          	jalr	-112(ra) # 800026a0 <_ZdlPv>
}
    80002718:	01813083          	ld	ra,24(sp)
    8000271c:	01013403          	ld	s0,16(sp)
    80002720:	00813483          	ld	s1,8(sp)
    80002724:	02010113          	addi	sp,sp,32
    80002728:	00008067          	ret

000000008000272c <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    8000272c:	ff010113          	addi	sp,sp,-16
    80002730:	00113423          	sd	ra,8(sp)
    80002734:	00813023          	sd	s0,0(sp)
    80002738:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    8000273c:	fffff097          	auipc	ra,0xfffff
    80002740:	a98080e7          	jalr	-1384(ra) # 800011d4 <_Z8mem_freePv>
}
    80002744:	00813083          	ld	ra,8(sp)
    80002748:	00013403          	ld	s0,0(sp)
    8000274c:	01010113          	addi	sp,sp,16
    80002750:	00008067          	ret

0000000080002754 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002754:	ff010113          	addi	sp,sp,-16
    80002758:	00113423          	sd	ra,8(sp)
    8000275c:	00813023          	sd	s0,0(sp)
    80002760:	01010413          	addi	s0,sp,16
    80002764:	00005797          	auipc	a5,0x5
    80002768:	c9478793          	addi	a5,a5,-876 # 800073f8 <_ZTV6Thread+0x10>
    8000276c:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002770:	00850513          	addi	a0,a0,8
    80002774:	fffff097          	auipc	ra,0xfffff
    80002778:	a94080e7          	jalr	-1388(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    8000277c:	00813083          	ld	ra,8(sp)
    80002780:	00013403          	ld	s0,0(sp)
    80002784:	01010113          	addi	sp,sp,16
    80002788:	00008067          	ret

000000008000278c <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    8000278c:	ff010113          	addi	sp,sp,-16
    80002790:	00113423          	sd	ra,8(sp)
    80002794:	00813023          	sd	s0,0(sp)
    80002798:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	680080e7          	jalr	1664(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
}
    800027a4:	00813083          	ld	ra,8(sp)
    800027a8:	00013403          	ld	s0,0(sp)
    800027ac:	01010113          	addi	sp,sp,16
    800027b0:	00008067          	ret

00000000800027b4 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    800027b4:	ff010113          	addi	sp,sp,-16
    800027b8:	00113423          	sd	ra,8(sp)
    800027bc:	00813023          	sd	s0,0(sp)
    800027c0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	7bc080e7          	jalr	1980(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800027cc:	00813083          	ld	ra,8(sp)
    800027d0:	00013403          	ld	s0,0(sp)
    800027d4:	01010113          	addi	sp,sp,16
    800027d8:	00008067          	ret

00000000800027dc <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800027dc:	fe010113          	addi	sp,sp,-32
    800027e0:	00113c23          	sd	ra,24(sp)
    800027e4:	00813823          	sd	s0,16(sp)
    800027e8:	00913423          	sd	s1,8(sp)
    800027ec:	02010413          	addi	s0,sp,32
    800027f0:	00050493          	mv	s1,a0
}
    800027f4:	00000097          	auipc	ra,0x0
    800027f8:	dd0080e7          	jalr	-560(ra) # 800025c4 <_ZN6ThreadD1Ev>
    800027fc:	00048513          	mv	a0,s1
    80002800:	00000097          	auipc	ra,0x0
    80002804:	fb4080e7          	jalr	-76(ra) # 800027b4 <_ZN6ThreaddlEPv>
    80002808:	01813083          	ld	ra,24(sp)
    8000280c:	01013403          	ld	s0,16(sp)
    80002810:	00813483          	ld	s1,8(sp)
    80002814:	02010113          	addi	sp,sp,32
    80002818:	00008067          	ret

000000008000281c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000281c:	ff010113          	addi	sp,sp,-16
    80002820:	00113423          	sd	ra,8(sp)
    80002824:	00813023          	sd	s0,0(sp)
    80002828:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000282c:	fffff097          	auipc	ra,0xfffff
    80002830:	a48080e7          	jalr	-1464(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002834:	00813083          	ld	ra,8(sp)
    80002838:	00013403          	ld	s0,0(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret

0000000080002844 <_ZN6Thread5startEv>:
int Thread::start() {
    80002844:	ff010113          	addi	sp,sp,-16
    80002848:	00113423          	sd	ra,8(sp)
    8000284c:	00813023          	sd	s0,0(sp)
    80002850:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002854:	00850513          	addi	a0,a0,8
    80002858:	fffff097          	auipc	ra,0xfffff
    8000285c:	a78080e7          	jalr	-1416(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002860:	00000513          	li	a0,0
    80002864:	00813083          	ld	ra,8(sp)
    80002868:	00013403          	ld	s0,0(sp)
    8000286c:	01010113          	addi	sp,sp,16
    80002870:	00008067          	ret

0000000080002874 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002874:	fe010113          	addi	sp,sp,-32
    80002878:	00113c23          	sd	ra,24(sp)
    8000287c:	00813823          	sd	s0,16(sp)
    80002880:	00913423          	sd	s1,8(sp)
    80002884:	02010413          	addi	s0,sp,32
    80002888:	00050493          	mv	s1,a0
    8000288c:	00005797          	auipc	a5,0x5
    80002890:	b6c78793          	addi	a5,a5,-1172 # 800073f8 <_ZTV6Thread+0x10>
    80002894:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80002898:	01800513          	li	a0,24
    8000289c:	00000097          	auipc	ra,0x0
    800028a0:	db4080e7          	jalr	-588(ra) # 80002650 <_Znwm>
    800028a4:	00050613          	mv	a2,a0
    800028a8:	00953023          	sd	s1,0(a0)
    800028ac:	01100793          	li	a5,17
    800028b0:	00f53423          	sd	a5,8(a0)
    800028b4:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    800028b8:	00000597          	auipc	a1,0x0
    800028bc:	e1058593          	addi	a1,a1,-496 # 800026c8 <_Z13threadWrapperPv>
    800028c0:	00848513          	addi	a0,s1,8
    800028c4:	fffff097          	auipc	ra,0xfffff
    800028c8:	944080e7          	jalr	-1724(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800028cc:	01813083          	ld	ra,24(sp)
    800028d0:	01013403          	ld	s0,16(sp)
    800028d4:	00813483          	ld	s1,8(sp)
    800028d8:	02010113          	addi	sp,sp,32
    800028dc:	00008067          	ret

00000000800028e0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800028e0:	ff010113          	addi	sp,sp,-16
    800028e4:	00113423          	sd	ra,8(sp)
    800028e8:	00813023          	sd	s0,0(sp)
    800028ec:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    800028f0:	fffff097          	auipc	ra,0xfffff
    800028f4:	bb4080e7          	jalr	-1100(ra) # 800014a4 <_Z10time_sleepm>
}
    800028f8:	00813083          	ld	ra,8(sp)
    800028fc:	00013403          	ld	s0,0(sp)
    80002900:	01010113          	addi	sp,sp,16
    80002904:	00008067          	ret

0000000080002908 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002908:	fe010113          	addi	sp,sp,-32
    8000290c:	00113c23          	sd	ra,24(sp)
    80002910:	00813823          	sd	s0,16(sp)
    80002914:	00913423          	sd	s1,8(sp)
    80002918:	02010413          	addi	s0,sp,32
    8000291c:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002920:	0200006f          	j	80002940 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002924:	00053703          	ld	a4,0(a0)
    80002928:	00f707b3          	add	a5,a4,a5
    8000292c:	fff7b783          	ld	a5,-1(a5)
    80002930:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002934:	0184b503          	ld	a0,24(s1)
    80002938:	00000097          	auipc	ra,0x0
    8000293c:	fa8080e7          	jalr	-88(ra) # 800028e0 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002940:	0004b503          	ld	a0,0(s1)
    80002944:	0104b783          	ld	a5,16(s1)
    80002948:	00f50533          	add	a0,a0,a5
    8000294c:	0084b783          	ld	a5,8(s1)
    80002950:	0017f713          	andi	a4,a5,1
    80002954:	fc070ee3          	beqz	a4,80002930 <_Z21periodicThreadWrapperPv+0x28>
    80002958:	fcdff06f          	j	80002924 <_Z21periodicThreadWrapperPv+0x1c>

000000008000295c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000295c:	fe010113          	addi	sp,sp,-32
    80002960:	00113c23          	sd	ra,24(sp)
    80002964:	00813823          	sd	s0,16(sp)
    80002968:	00913423          	sd	s1,8(sp)
    8000296c:	01213023          	sd	s2,0(sp)
    80002970:	02010413          	addi	s0,sp,32
    80002974:	00050493          	mv	s1,a0
    80002978:	00005797          	auipc	a5,0x5
    8000297c:	aa878793          	addi	a5,a5,-1368 # 80007420 <_ZTV9Semaphore+0x10>
    80002980:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002984:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002988:	01800513          	li	a0,24
    8000298c:	00000097          	auipc	ra,0x0
    80002990:	3dc080e7          	jalr	988(ra) # 80002d68 <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    80002994:	00053023          	sd	zero,0(a0)
    80002998:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000299c:	01252823          	sw	s2,16(a0)
    800029a0:	00a4b423          	sd	a0,8(s1)
}
    800029a4:	01813083          	ld	ra,24(sp)
    800029a8:	01013403          	ld	s0,16(sp)
    800029ac:	00813483          	ld	s1,8(sp)
    800029b0:	00013903          	ld	s2,0(sp)
    800029b4:	02010113          	addi	sp,sp,32
    800029b8:	00008067          	ret

00000000800029bc <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800029bc:	ff010113          	addi	sp,sp,-16
    800029c0:	00113423          	sd	ra,8(sp)
    800029c4:	00813023          	sd	s0,0(sp)
    800029c8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800029cc:	00853503          	ld	a0,8(a0)
    800029d0:	fffff097          	auipc	ra,0xfffff
    800029d4:	9c8080e7          	jalr	-1592(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    800029d8:	00813083          	ld	ra,8(sp)
    800029dc:	00013403          	ld	s0,0(sp)
    800029e0:	01010113          	addi	sp,sp,16
    800029e4:	00008067          	ret

00000000800029e8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800029e8:	ff010113          	addi	sp,sp,-16
    800029ec:	00113423          	sd	ra,8(sp)
    800029f0:	00813023          	sd	s0,0(sp)
    800029f4:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800029f8:	00853503          	ld	a0,8(a0)
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	a0c080e7          	jalr	-1524(ra) # 80001408 <_Z10sem_signalP3SCB>
}
    80002a04:	00813083          	ld	ra,8(sp)
    80002a08:	00013403          	ld	s0,0(sp)
    80002a0c:	01010113          	addi	sp,sp,16
    80002a10:	00008067          	ret

0000000080002a14 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002a14:	ff010113          	addi	sp,sp,-16
    80002a18:	00113423          	sd	ra,8(sp)
    80002a1c:	00813023          	sd	s0,0(sp)
    80002a20:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002a24:	00000097          	auipc	ra,0x0
    80002a28:	55c080e7          	jalr	1372(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002a2c:	00813083          	ld	ra,8(sp)
    80002a30:	00013403          	ld	s0,0(sp)
    80002a34:	01010113          	addi	sp,sp,16
    80002a38:	00008067          	ret

0000000080002a3c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002a3c:	fe010113          	addi	sp,sp,-32
    80002a40:	00113c23          	sd	ra,24(sp)
    80002a44:	00813823          	sd	s0,16(sp)
    80002a48:	00913423          	sd	s1,8(sp)
    80002a4c:	02010413          	addi	s0,sp,32
    80002a50:	00050493          	mv	s1,a0
}
    80002a54:	00000097          	auipc	ra,0x0
    80002a58:	bc4080e7          	jalr	-1084(ra) # 80002618 <_ZN9SemaphoreD1Ev>
    80002a5c:	00048513          	mv	a0,s1
    80002a60:	00000097          	auipc	ra,0x0
    80002a64:	fb4080e7          	jalr	-76(ra) # 80002a14 <_ZN9SemaphoredlEPv>
    80002a68:	01813083          	ld	ra,24(sp)
    80002a6c:	01013403          	ld	s0,16(sp)
    80002a70:	00813483          	ld	s1,8(sp)
    80002a74:	02010113          	addi	sp,sp,32
    80002a78:	00008067          	ret

0000000080002a7c <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    80002a7c:	ff010113          	addi	sp,sp,-16
    80002a80:	00113423          	sd	ra,8(sp)
    80002a84:	00813023          	sd	s0,0(sp)
    80002a88:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002a8c:	00000097          	auipc	ra,0x0
    80002a90:	390080e7          	jalr	912(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
}
    80002a94:	00813083          	ld	ra,8(sp)
    80002a98:	00013403          	ld	s0,0(sp)
    80002a9c:	01010113          	addi	sp,sp,16
    80002aa0:	00008067          	ret

0000000080002aa4 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80002aa4:	fe010113          	addi	sp,sp,-32
    80002aa8:	00113c23          	sd	ra,24(sp)
    80002aac:	00813823          	sd	s0,16(sp)
    80002ab0:	00913423          	sd	s1,8(sp)
    80002ab4:	01213023          	sd	s2,0(sp)
    80002ab8:	02010413          	addi	s0,sp,32
    80002abc:	00050493          	mv	s1,a0
    80002ac0:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80002ac4:	02000513          	li	a0,32
    80002ac8:	00000097          	auipc	ra,0x0
    80002acc:	b88080e7          	jalr	-1144(ra) # 80002650 <_Znwm>
    80002ad0:	00050613          	mv	a2,a0
    80002ad4:	00953023          	sd	s1,0(a0)
    80002ad8:	01900793          	li	a5,25
    80002adc:	00f53423          	sd	a5,8(a0)
    80002ae0:	00053823          	sd	zero,16(a0)
    80002ae4:	01253c23          	sd	s2,24(a0)
    80002ae8:	00000597          	auipc	a1,0x0
    80002aec:	e2058593          	addi	a1,a1,-480 # 80002908 <_Z21periodicThreadWrapperPv>
    80002af0:	00048513          	mv	a0,s1
    80002af4:	00000097          	auipc	ra,0x0
    80002af8:	c60080e7          	jalr	-928(ra) # 80002754 <_ZN6ThreadC1EPFvPvES0_>
    80002afc:	00005797          	auipc	a5,0x5
    80002b00:	8cc78793          	addi	a5,a5,-1844 # 800073c8 <_ZTV14PeriodicThread+0x10>
    80002b04:	00f4b023          	sd	a5,0(s1)
{}
    80002b08:	01813083          	ld	ra,24(sp)
    80002b0c:	01013403          	ld	s0,16(sp)
    80002b10:	00813483          	ld	s1,8(sp)
    80002b14:	00013903          	ld	s2,0(sp)
    80002b18:	02010113          	addi	sp,sp,32
    80002b1c:	00008067          	ret

0000000080002b20 <_ZN7Console4getcEv>:


char Console::getc() {
    80002b20:	ff010113          	addi	sp,sp,-16
    80002b24:	00113423          	sd	ra,8(sp)
    80002b28:	00813023          	sd	s0,0(sp)
    80002b2c:	01010413          	addi	s0,sp,16
    return ::getc();
    80002b30:	fffff097          	auipc	ra,0xfffff
    80002b34:	9bc080e7          	jalr	-1604(ra) # 800014ec <_Z4getcv>
}
    80002b38:	00813083          	ld	ra,8(sp)
    80002b3c:	00013403          	ld	s0,0(sp)
    80002b40:	01010113          	addi	sp,sp,16
    80002b44:	00008067          	ret

0000000080002b48 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002b48:	ff010113          	addi	sp,sp,-16
    80002b4c:	00113423          	sd	ra,8(sp)
    80002b50:	00813023          	sd	s0,0(sp)
    80002b54:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002b58:	fffff097          	auipc	ra,0xfffff
    80002b5c:	9c4080e7          	jalr	-1596(ra) # 8000151c <_Z4putcc>
}
    80002b60:	00813083          	ld	ra,8(sp)
    80002b64:	00013403          	ld	s0,0(sp)
    80002b68:	01010113          	addi	sp,sp,16
    80002b6c:	00008067          	ret

0000000080002b70 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002b70:	ff010113          	addi	sp,sp,-16
    80002b74:	00813423          	sd	s0,8(sp)
    80002b78:	01010413          	addi	s0,sp,16
    80002b7c:	00813403          	ld	s0,8(sp)
    80002b80:	01010113          	addi	sp,sp,16
    80002b84:	00008067          	ret

0000000080002b88 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002b88:	ff010113          	addi	sp,sp,-16
    80002b8c:	00813423          	sd	s0,8(sp)
    80002b90:	01010413          	addi	s0,sp,16
    80002b94:	00813403          	ld	s0,8(sp)
    80002b98:	01010113          	addi	sp,sp,16
    80002b9c:	00008067          	ret

0000000080002ba0 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80002ba0:	ff010113          	addi	sp,sp,-16
    80002ba4:	00113423          	sd	ra,8(sp)
    80002ba8:	00813023          	sd	s0,0(sp)
    80002bac:	01010413          	addi	s0,sp,16
    80002bb0:	00005797          	auipc	a5,0x5
    80002bb4:	81878793          	addi	a5,a5,-2024 # 800073c8 <_ZTV14PeriodicThread+0x10>
    80002bb8:	00f53023          	sd	a5,0(a0)
    80002bbc:	00000097          	auipc	ra,0x0
    80002bc0:	a08080e7          	jalr	-1528(ra) # 800025c4 <_ZN6ThreadD1Ev>
    80002bc4:	00813083          	ld	ra,8(sp)
    80002bc8:	00013403          	ld	s0,0(sp)
    80002bcc:	01010113          	addi	sp,sp,16
    80002bd0:	00008067          	ret

0000000080002bd4 <_ZN14PeriodicThreadD0Ev>:
    80002bd4:	fe010113          	addi	sp,sp,-32
    80002bd8:	00113c23          	sd	ra,24(sp)
    80002bdc:	00813823          	sd	s0,16(sp)
    80002be0:	00913423          	sd	s1,8(sp)
    80002be4:	02010413          	addi	s0,sp,32
    80002be8:	00050493          	mv	s1,a0
    80002bec:	00004797          	auipc	a5,0x4
    80002bf0:	7dc78793          	addi	a5,a5,2012 # 800073c8 <_ZTV14PeriodicThread+0x10>
    80002bf4:	00f53023          	sd	a5,0(a0)
    80002bf8:	00000097          	auipc	ra,0x0
    80002bfc:	9cc080e7          	jalr	-1588(ra) # 800025c4 <_ZN6ThreadD1Ev>
    80002c00:	00048513          	mv	a0,s1
    80002c04:	00000097          	auipc	ra,0x0
    80002c08:	bb0080e7          	jalr	-1104(ra) # 800027b4 <_ZN6ThreaddlEPv>
    80002c0c:	01813083          	ld	ra,24(sp)
    80002c10:	01013403          	ld	s0,16(sp)
    80002c14:	00813483          	ld	s1,8(sp)
    80002c18:	02010113          	addi	sp,sp,32
    80002c1c:	00008067          	ret

0000000080002c20 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00813423          	sd	s0,8(sp)
    80002c28:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002c2c:	00005797          	auipc	a5,0x5
    80002c30:	87c7b783          	ld	a5,-1924(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c34:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80002c38:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002c3c:	00853783          	ld	a5,8(a0)
    80002c40:	04078063          	beqz	a5,80002c80 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002c44:	00005717          	auipc	a4,0x5
    80002c48:	86473703          	ld	a4,-1948(a4) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c4c:	00073703          	ld	a4,0(a4)
    80002c50:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002c54:	00853783          	ld	a5,8(a0)
        return nextInList;
    80002c58:	0007b783          	ld	a5,0(a5)
    80002c5c:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002c60:	00005797          	auipc	a5,0x5
    80002c64:	8487b783          	ld	a5,-1976(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c68:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    80002c6c:	00100713          	li	a4,1
    80002c70:	02e784a3          	sb	a4,41(a5)
}
    80002c74:	00813403          	ld	s0,8(sp)
    80002c78:	01010113          	addi	sp,sp,16
    80002c7c:	00008067          	ret
        head = tail = PCB::running;
    80002c80:	00005797          	auipc	a5,0x5
    80002c84:	8287b783          	ld	a5,-2008(a5) # 800074a8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c88:	0007b783          	ld	a5,0(a5)
    80002c8c:	00f53423          	sd	a5,8(a0)
    80002c90:	00f53023          	sd	a5,0(a0)
    80002c94:	fcdff06f          	j	80002c60 <_ZN3SCB5blockEv+0x40>

0000000080002c98 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80002c98:	ff010113          	addi	sp,sp,-16
    80002c9c:	00813423          	sd	s0,8(sp)
    80002ca0:	01010413          	addi	s0,sp,16
    80002ca4:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80002ca8:	00053503          	ld	a0,0(a0)
    80002cac:	00050e63          	beqz	a0,80002cc8 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    80002cb0:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80002cb4:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80002cb8:	0087b683          	ld	a3,8(a5)
    80002cbc:	00d50c63          	beq	a0,a3,80002cd4 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80002cc0:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80002cc4:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80002cc8:	00813403          	ld	s0,8(sp)
    80002ccc:	01010113          	addi	sp,sp,16
    80002cd0:	00008067          	ret
        tail = head;
    80002cd4:	00e7b423          	sd	a4,8(a5)
    80002cd8:	fe9ff06f          	j	80002cc0 <_ZN3SCB7unblockEv+0x28>

0000000080002cdc <_ZN3SCB4waitEv>:

bool SCB::wait() {
    if((int)(--semValue)<0) {
    80002cdc:	01052783          	lw	a5,16(a0)
    80002ce0:	fff7879b          	addiw	a5,a5,-1
    80002ce4:	00f52823          	sw	a5,16(a0)
    80002ce8:	02079713          	slli	a4,a5,0x20
    80002cec:	00074663          	bltz	a4,80002cf8 <_ZN3SCB4waitEv+0x1c>
        block();
        return true;
    }
    return false;
    80002cf0:	00000513          	li	a0,0
}
    80002cf4:	00008067          	ret
bool SCB::wait() {
    80002cf8:	ff010113          	addi	sp,sp,-16
    80002cfc:	00113423          	sd	ra,8(sp)
    80002d00:	00813023          	sd	s0,0(sp)
    80002d04:	01010413          	addi	s0,sp,16
        block();
    80002d08:	00000097          	auipc	ra,0x0
    80002d0c:	f18080e7          	jalr	-232(ra) # 80002c20 <_ZN3SCB5blockEv>
        return true;
    80002d10:	00100513          	li	a0,1
}
    80002d14:	00813083          	ld	ra,8(sp)
    80002d18:	00013403          	ld	s0,0(sp)
    80002d1c:	01010113          	addi	sp,sp,16
    80002d20:	00008067          	ret

0000000080002d24 <_ZN3SCB6signalEv>:

PCB* SCB::signal() {
    if((int)(++semValue)<=0) {
    80002d24:	01052783          	lw	a5,16(a0)
    80002d28:	0017879b          	addiw	a5,a5,1
    80002d2c:	0007871b          	sext.w	a4,a5
    80002d30:	00f52823          	sw	a5,16(a0)
    80002d34:	00e05663          	blez	a4,80002d40 <_ZN3SCB6signalEv+0x1c>
        return unblock();
    }
    return nullptr;
    80002d38:	00000513          	li	a0,0
}
    80002d3c:	00008067          	ret
PCB* SCB::signal() {
    80002d40:	ff010113          	addi	sp,sp,-16
    80002d44:	00113423          	sd	ra,8(sp)
    80002d48:	00813023          	sd	s0,0(sp)
    80002d4c:	01010413          	addi	s0,sp,16
        return unblock();
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	f48080e7          	jalr	-184(ra) # 80002c98 <_ZN3SCB7unblockEv>
}
    80002d58:	00813083          	ld	ra,8(sp)
    80002d5c:	00013403          	ld	s0,0(sp)
    80002d60:	01010113          	addi	sp,sp,16
    80002d64:	00008067          	ret

0000000080002d68 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80002d68:	ff010113          	addi	sp,sp,-16
    80002d6c:	00113423          	sd	ra,8(sp)
    80002d70:	00813023          	sd	s0,0(sp)
    80002d74:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	0a4080e7          	jalr	164(ra) # 80002e1c <_ZN15MemoryAllocator9mem_allocEm>
}
    80002d80:	00813083          	ld	ra,8(sp)
    80002d84:	00013403          	ld	s0,0(sp)
    80002d88:	01010113          	addi	sp,sp,16
    80002d8c:	00008067          	ret

0000000080002d90 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002d90:	ff010113          	addi	sp,sp,-16
    80002d94:	00113423          	sd	ra,8(sp)
    80002d98:	00813023          	sd	s0,0(sp)
    80002d9c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	1e0080e7          	jalr	480(ra) # 80002f80 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002da8:	00813083          	ld	ra,8(sp)
    80002dac:	00013403          	ld	s0,0(sp)
    80002db0:	01010113          	addi	sp,sp,16
    80002db4:	00008067          	ret

0000000080002db8 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80002db8:	fe010113          	addi	sp,sp,-32
    80002dbc:	00113c23          	sd	ra,24(sp)
    80002dc0:	00813823          	sd	s0,16(sp)
    80002dc4:	00913423          	sd	s1,8(sp)
    80002dc8:	01213023          	sd	s2,0(sp)
    80002dcc:	02010413          	addi	s0,sp,32
    80002dd0:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002dd4:	00053503          	ld	a0,0(a0)
    while(curr) {
    80002dd8:	02050263          	beqz	a0,80002dfc <_ZN3SCB13signalClosingEv+0x44>
    }

    void setSemDeleted(bool newState) {
        semDeleted = newState;
    80002ddc:	00100793          	li	a5,1
    80002de0:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    80002de4:	020504a3          	sb	zero,41(a0)
        return nextInList;
    80002de8:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80002dec:	fffff097          	auipc	ra,0xfffff
    80002df0:	584080e7          	jalr	1412(ra) # 80002370 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80002df4:	00048513          	mv	a0,s1
    while(curr) {
    80002df8:	fe1ff06f          	j	80002dd8 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002dfc:	00093423          	sd	zero,8(s2)
    80002e00:	00093023          	sd	zero,0(s2)
}
    80002e04:	01813083          	ld	ra,24(sp)
    80002e08:	01013403          	ld	s0,16(sp)
    80002e0c:	00813483          	ld	s1,8(sp)
    80002e10:	00013903          	ld	s2,0(sp)
    80002e14:	02010113          	addi	sp,sp,32
    80002e18:	00008067          	ret

0000000080002e1c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002e1c:	ff010113          	addi	sp,sp,-16
    80002e20:	00813423          	sd	s0,8(sp)
    80002e24:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002e28:	00004797          	auipc	a5,0x4
    80002e2c:	7807b783          	ld	a5,1920(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
    80002e30:	02078c63          	beqz	a5,80002e68 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002e34:	00004717          	auipc	a4,0x4
    80002e38:	67c73703          	ld	a4,1660(a4) # 800074b0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002e3c:	00073703          	ld	a4,0(a4)
    80002e40:	12e78c63          	beq	a5,a4,80002f78 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002e44:	00850713          	addi	a4,a0,8
    80002e48:	00675813          	srli	a6,a4,0x6
    80002e4c:	03f77793          	andi	a5,a4,63
    80002e50:	00f037b3          	snez	a5,a5
    80002e54:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80002e58:	00004517          	auipc	a0,0x4
    80002e5c:	75053503          	ld	a0,1872(a0) # 800075a8 <_ZN15MemoryAllocator4headE>
    80002e60:	00000613          	li	a2,0
    80002e64:	0a80006f          	j	80002f0c <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80002e68:	00004697          	auipc	a3,0x4
    80002e6c:	6006b683          	ld	a3,1536(a3) # 80007468 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002e70:	0006b783          	ld	a5,0(a3)
    80002e74:	00004717          	auipc	a4,0x4
    80002e78:	72f73a23          	sd	a5,1844(a4) # 800075a8 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80002e7c:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80002e80:	00004717          	auipc	a4,0x4
    80002e84:	63073703          	ld	a4,1584(a4) # 800074b0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002e88:	00073703          	ld	a4,0(a4)
    80002e8c:	0006b683          	ld	a3,0(a3)
    80002e90:	40d70733          	sub	a4,a4,a3
    80002e94:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80002e98:	0007b823          	sd	zero,16(a5)
    80002e9c:	fa9ff06f          	j	80002e44 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80002ea0:	00060e63          	beqz	a2,80002ebc <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002ea4:	01063703          	ld	a4,16(a2)
    80002ea8:	04070a63          	beqz	a4,80002efc <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002eac:	01073703          	ld	a4,16(a4)
    80002eb0:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002eb4:	00078813          	mv	a6,a5
    80002eb8:	0ac0006f          	j	80002f64 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002ebc:	01053703          	ld	a4,16(a0)
    80002ec0:	00070a63          	beqz	a4,80002ed4 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002ec4:	00004697          	auipc	a3,0x4
    80002ec8:	6ee6b223          	sd	a4,1764(a3) # 800075a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002ecc:	00078813          	mv	a6,a5
    80002ed0:	0940006f          	j	80002f64 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002ed4:	00004717          	auipc	a4,0x4
    80002ed8:	5dc73703          	ld	a4,1500(a4) # 800074b0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002edc:	00073703          	ld	a4,0(a4)
    80002ee0:	00004697          	auipc	a3,0x4
    80002ee4:	6ce6b423          	sd	a4,1736(a3) # 800075a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002ee8:	00078813          	mv	a6,a5
    80002eec:	0780006f          	j	80002f64 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002ef0:	00004797          	auipc	a5,0x4
    80002ef4:	6ae7bc23          	sd	a4,1720(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
    80002ef8:	06c0006f          	j	80002f64 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002efc:	00078813          	mv	a6,a5
    80002f00:	0640006f          	j	80002f64 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002f04:	00050613          	mv	a2,a0
        curr = curr->next;
    80002f08:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002f0c:	06050063          	beqz	a0,80002f6c <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002f10:	00853783          	ld	a5,8(a0)
    80002f14:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002f18:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002f1c:	fee7e4e3          	bltu	a5,a4,80002f04 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002f20:	ff06e2e3          	bltu	a3,a6,80002f04 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002f24:	f7068ee3          	beq	a3,a6,80002ea0 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002f28:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002f2c:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002f30:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002f34:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002f38:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002f3c:	01053783          	ld	a5,16(a0)
    80002f40:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002f44:	fa0606e3          	beqz	a2,80002ef0 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002f48:	01063783          	ld	a5,16(a2)
    80002f4c:	00078663          	beqz	a5,80002f58 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002f50:	0107b783          	ld	a5,16(a5)
    80002f54:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80002f58:	01063783          	ld	a5,16(a2)
    80002f5c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002f60:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002f64:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80002f68:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80002f6c:	00813403          	ld	s0,8(sp)
    80002f70:	01010113          	addi	sp,sp,16
    80002f74:	00008067          	ret
        return nullptr;
    80002f78:	00000513          	li	a0,0
    80002f7c:	ff1ff06f          	j	80002f6c <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080002f80 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80002f80:	ff010113          	addi	sp,sp,-16
    80002f84:	00813423          	sd	s0,8(sp)
    80002f88:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002f8c:	16050063          	beqz	a0,800030ec <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80002f90:	ff850713          	addi	a4,a0,-8
    80002f94:	00004797          	auipc	a5,0x4
    80002f98:	4d47b783          	ld	a5,1236(a5) # 80007468 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002f9c:	0007b783          	ld	a5,0(a5)
    80002fa0:	14f76a63          	bltu	a4,a5,800030f4 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002fa4:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002fa8:	fff58693          	addi	a3,a1,-1
    80002fac:	00d706b3          	add	a3,a4,a3
    80002fb0:	00004617          	auipc	a2,0x4
    80002fb4:	50063603          	ld	a2,1280(a2) # 800074b0 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002fb8:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002fbc:	14c6f063          	bgeu	a3,a2,800030fc <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002fc0:	14070263          	beqz	a4,80003104 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002fc4:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002fc8:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002fcc:	14079063          	bnez	a5,8000310c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002fd0:	03f00793          	li	a5,63
    80002fd4:	14b7f063          	bgeu	a5,a1,80003114 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002fd8:	00004797          	auipc	a5,0x4
    80002fdc:	5d07b783          	ld	a5,1488(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
    80002fe0:	02f60063          	beq	a2,a5,80003000 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002fe4:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002fe8:	02078a63          	beqz	a5,8000301c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002fec:	0007b683          	ld	a3,0(a5)
    80002ff0:	02e6f663          	bgeu	a3,a4,8000301c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002ff4:	00078613          	mv	a2,a5
        curr = curr->next;
    80002ff8:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002ffc:	fedff06f          	j	80002fe8 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80003000:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80003004:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80003008:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000300c:	00004797          	auipc	a5,0x4
    80003010:	58e7be23          	sd	a4,1436(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
        return 0;
    80003014:	00000513          	li	a0,0
    80003018:	0480006f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    8000301c:	04060863          	beqz	a2,8000306c <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80003020:	00063683          	ld	a3,0(a2)
    80003024:	00863803          	ld	a6,8(a2)
    80003028:	010686b3          	add	a3,a3,a6
    8000302c:	08e68a63          	beq	a3,a4,800030c0 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80003030:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003034:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80003038:	01063683          	ld	a3,16(a2)
    8000303c:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80003040:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80003044:	0e078063          	beqz	a5,80003124 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80003048:	0007b583          	ld	a1,0(a5)
    8000304c:	00073683          	ld	a3,0(a4)
    80003050:	00873603          	ld	a2,8(a4)
    80003054:	00c686b3          	add	a3,a3,a2
    80003058:	06d58c63          	beq	a1,a3,800030d0 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    8000305c:	00000513          	li	a0,0
}
    80003060:	00813403          	ld	s0,8(sp)
    80003064:	01010113          	addi	sp,sp,16
    80003068:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    8000306c:	0a078863          	beqz	a5,8000311c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80003070:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80003074:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80003078:	00004797          	auipc	a5,0x4
    8000307c:	5307b783          	ld	a5,1328(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
    80003080:	0007b603          	ld	a2,0(a5)
    80003084:	00b706b3          	add	a3,a4,a1
    80003088:	00d60c63          	beq	a2,a3,800030a0 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    8000308c:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80003090:	00004797          	auipc	a5,0x4
    80003094:	50e7bc23          	sd	a4,1304(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
            return 0;
    80003098:	00000513          	li	a0,0
    8000309c:	fc5ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800030a0:	0087b783          	ld	a5,8(a5)
    800030a4:	00b785b3          	add	a1,a5,a1
    800030a8:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800030ac:	00004797          	auipc	a5,0x4
    800030b0:	4fc7b783          	ld	a5,1276(a5) # 800075a8 <_ZN15MemoryAllocator4headE>
    800030b4:	0107b783          	ld	a5,16(a5)
    800030b8:	00f53423          	sd	a5,8(a0)
    800030bc:	fd5ff06f          	j	80003090 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    800030c0:	00b805b3          	add	a1,a6,a1
    800030c4:	00b63423          	sd	a1,8(a2)
    800030c8:	00060713          	mv	a4,a2
    800030cc:	f79ff06f          	j	80003044 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    800030d0:	0087b683          	ld	a3,8(a5)
    800030d4:	00d60633          	add	a2,a2,a3
    800030d8:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    800030dc:	0107b783          	ld	a5,16(a5)
    800030e0:	00f73823          	sd	a5,16(a4)
    return 0;
    800030e4:	00000513          	li	a0,0
    800030e8:	f79ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800030ec:	fff00513          	li	a0,-1
    800030f0:	f71ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800030f4:	fff00513          	li	a0,-1
    800030f8:	f69ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800030fc:	fff00513          	li	a0,-1
    80003100:	f61ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003104:	fff00513          	li	a0,-1
    80003108:	f59ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000310c:	fff00513          	li	a0,-1
    80003110:	f51ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80003114:	fff00513          	li	a0,-1
    80003118:	f49ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    8000311c:	fff00513          	li	a0,-1
    80003120:	f41ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80003124:	00000513          	li	a0,0
    80003128:	f39ff06f          	j	80003060 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000312c <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"
#include "../h/console.h"

Buffer::Buffer(int _cap) : cap(_cap), head(0), tail(0) {
    8000312c:	fe010113          	addi	sp,sp,-32
    80003130:	00113c23          	sd	ra,24(sp)
    80003134:	00813823          	sd	s0,16(sp)
    80003138:	00913423          	sd	s1,8(sp)
    8000313c:	02010413          	addi	s0,sp,32
    80003140:	00050493          	mv	s1,a0
    80003144:	00b52023          	sw	a1,0(a0)
    80003148:	00052823          	sw	zero,16(a0)
    8000314c:	00052a23          	sw	zero,20(a0)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003150:	00259513          	slli	a0,a1,0x2
    80003154:	ffffe097          	auipc	ra,0xffffe
    80003158:	040080e7          	jalr	64(ra) # 80001194 <_Z9mem_allocm>
    8000315c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003160:	00000593          	li	a1,0
    80003164:	02048513          	addi	a0,s1,32
    80003168:	ffffe097          	auipc	ra,0xffffe
    8000316c:	1e8080e7          	jalr	488(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, cap);
    80003170:	0004a583          	lw	a1,0(s1)
    80003174:	01848513          	addi	a0,s1,24
    80003178:	ffffe097          	auipc	ra,0xffffe
    8000317c:	1d8080e7          	jalr	472(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80003180:	00100593          	li	a1,1
    80003184:	02848513          	addi	a0,s1,40
    80003188:	ffffe097          	auipc	ra,0xffffe
    8000318c:	1c8080e7          	jalr	456(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80003190:	00100593          	li	a1,1
    80003194:	03048513          	addi	a0,s1,48
    80003198:	ffffe097          	auipc	ra,0xffffe
    8000319c:	1b8080e7          	jalr	440(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    800031a0:	01813083          	ld	ra,24(sp)
    800031a4:	01013403          	ld	s0,16(sp)
    800031a8:	00813483          	ld	s1,8(sp)
    800031ac:	02010113          	addi	sp,sp,32
    800031b0:	00008067          	ret

00000000800031b4 <_ZN6BufferD1Ev>:

Buffer::~Buffer() {
    800031b4:	fe010113          	addi	sp,sp,-32
    800031b8:	00113c23          	sd	ra,24(sp)
    800031bc:	00813823          	sd	s0,16(sp)
    800031c0:	00913423          	sd	s1,8(sp)
    800031c4:	02010413          	addi	s0,sp,32
    800031c8:	00050493          	mv	s1,a0
    __putc('\n');
    800031cc:	00a00513          	li	a0,10
    800031d0:	00002097          	auipc	ra,0x2
    800031d4:	62c080e7          	jalr	1580(ra) # 800057fc <__putc>
    printString("Buffer deleted!\n");
    800031d8:	00003517          	auipc	a0,0x3
    800031dc:	f5850513          	addi	a0,a0,-168 # 80006130 <CONSOLE_STATUS+0x120>
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	1c8080e7          	jalr	456(ra) # 800033a8 <_Z11printStringPKc>
    while (head != tail) {
    800031e8:	0104a783          	lw	a5,16(s1)
    800031ec:	0144a703          	lw	a4,20(s1)
    800031f0:	02e78a63          	beq	a5,a4,80003224 <_ZN6BufferD1Ev+0x70>
        char ch = buffer[head];
    800031f4:	0084b703          	ld	a4,8(s1)
    800031f8:	00279793          	slli	a5,a5,0x2
    800031fc:	00f707b3          	add	a5,a4,a5
        __putc(ch);
    80003200:	0007c503          	lbu	a0,0(a5)
    80003204:	00002097          	auipc	ra,0x2
    80003208:	5f8080e7          	jalr	1528(ra) # 800057fc <__putc>
        head = (head + 1) % cap;
    8000320c:	0104a783          	lw	a5,16(s1)
    80003210:	0017879b          	addiw	a5,a5,1
    80003214:	0004a703          	lw	a4,0(s1)
    80003218:	02e7e7bb          	remw	a5,a5,a4
    8000321c:	00f4a823          	sw	a5,16(s1)
    while (head != tail) {
    80003220:	fc9ff06f          	j	800031e8 <_ZN6BufferD1Ev+0x34>
    }
    __putc('!');
    80003224:	02100513          	li	a0,33
    80003228:	00002097          	auipc	ra,0x2
    8000322c:	5d4080e7          	jalr	1492(ra) # 800057fc <__putc>
    __putc('\n');
    80003230:	00a00513          	li	a0,10
    80003234:	00002097          	auipc	ra,0x2
    80003238:	5c8080e7          	jalr	1480(ra) # 800057fc <__putc>

    mem_free(buffer);
    8000323c:	0084b503          	ld	a0,8(s1)
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	f94080e7          	jalr	-108(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003248:	0204b503          	ld	a0,32(s1)
    8000324c:	ffffe097          	auipc	ra,0xffffe
    80003250:	218080e7          	jalr	536(ra) # 80001464 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80003254:	0184b503          	ld	a0,24(s1)
    80003258:	ffffe097          	auipc	ra,0xffffe
    8000325c:	20c080e7          	jalr	524(ra) # 80001464 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80003260:	0304b503          	ld	a0,48(s1)
    80003264:	ffffe097          	auipc	ra,0xffffe
    80003268:	200080e7          	jalr	512(ra) # 80001464 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    8000326c:	0284b503          	ld	a0,40(s1)
    80003270:	ffffe097          	auipc	ra,0xffffe
    80003274:	1f4080e7          	jalr	500(ra) # 80001464 <_Z9sem_closeP3SCB>
}
    80003278:	01813083          	ld	ra,24(sp)
    8000327c:	01013403          	ld	s0,16(sp)
    80003280:	00813483          	ld	s1,8(sp)
    80003284:	02010113          	addi	sp,sp,32
    80003288:	00008067          	ret

000000008000328c <_ZN6Buffer3putEi>:

void Buffer::put(int val) {
    8000328c:	fe010113          	addi	sp,sp,-32
    80003290:	00113c23          	sd	ra,24(sp)
    80003294:	00813823          	sd	s0,16(sp)
    80003298:	00913423          	sd	s1,8(sp)
    8000329c:	01213023          	sd	s2,0(sp)
    800032a0:	02010413          	addi	s0,sp,32
    800032a4:	00050493          	mv	s1,a0
    800032a8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800032ac:	01853503          	ld	a0,24(a0)
    800032b0:	ffffe097          	auipc	ra,0xffffe
    800032b4:	0e8080e7          	jalr	232(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    800032b8:	0304b503          	ld	a0,48(s1)
    800032bc:	ffffe097          	auipc	ra,0xffffe
    800032c0:	0dc080e7          	jalr	220(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    800032c4:	0084b783          	ld	a5,8(s1)
    800032c8:	0144a703          	lw	a4,20(s1)
    800032cc:	00271713          	slli	a4,a4,0x2
    800032d0:	00e787b3          	add	a5,a5,a4
    800032d4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800032d8:	0144a783          	lw	a5,20(s1)
    800032dc:	0017879b          	addiw	a5,a5,1
    800032e0:	0004a703          	lw	a4,0(s1)
    800032e4:	02e7e7bb          	remw	a5,a5,a4
    800032e8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800032ec:	0304b503          	ld	a0,48(s1)
    800032f0:	ffffe097          	auipc	ra,0xffffe
    800032f4:	118080e7          	jalr	280(ra) # 80001408 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    800032f8:	0204b503          	ld	a0,32(s1)
    800032fc:	ffffe097          	auipc	ra,0xffffe
    80003300:	10c080e7          	jalr	268(ra) # 80001408 <_Z10sem_signalP3SCB>

}
    80003304:	01813083          	ld	ra,24(sp)
    80003308:	01013403          	ld	s0,16(sp)
    8000330c:	00813483          	ld	s1,8(sp)
    80003310:	00013903          	ld	s2,0(sp)
    80003314:	02010113          	addi	sp,sp,32
    80003318:	00008067          	ret

000000008000331c <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000331c:	fe010113          	addi	sp,sp,-32
    80003320:	00113c23          	sd	ra,24(sp)
    80003324:	00813823          	sd	s0,16(sp)
    80003328:	00913423          	sd	s1,8(sp)
    8000332c:	01213023          	sd	s2,0(sp)
    80003330:	02010413          	addi	s0,sp,32
    80003334:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003338:	02053503          	ld	a0,32(a0)
    8000333c:	ffffe097          	auipc	ra,0xffffe
    80003340:	05c080e7          	jalr	92(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80003344:	0284b503          	ld	a0,40(s1)
    80003348:	ffffe097          	auipc	ra,0xffffe
    8000334c:	050080e7          	jalr	80(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80003350:	0084b703          	ld	a4,8(s1)
    80003354:	0104a783          	lw	a5,16(s1)
    80003358:	00279693          	slli	a3,a5,0x2
    8000335c:	00d70733          	add	a4,a4,a3
    80003360:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003364:	0017879b          	addiw	a5,a5,1
    80003368:	0004a703          	lw	a4,0(s1)
    8000336c:	02e7e7bb          	remw	a5,a5,a4
    80003370:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003374:	0284b503          	ld	a0,40(s1)
    80003378:	ffffe097          	auipc	ra,0xffffe
    8000337c:	090080e7          	jalr	144(ra) # 80001408 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80003380:	0184b503          	ld	a0,24(s1)
    80003384:	ffffe097          	auipc	ra,0xffffe
    80003388:	084080e7          	jalr	132(ra) # 80001408 <_Z10sem_signalP3SCB>

    return ret;
}
    8000338c:	00090513          	mv	a0,s2
    80003390:	01813083          	ld	ra,24(sp)
    80003394:	01013403          	ld	s0,16(sp)
    80003398:	00813483          	ld	s1,8(sp)
    8000339c:	00013903          	ld	s2,0(sp)
    800033a0:	02010113          	addi	sp,sp,32
    800033a4:	00008067          	ret

00000000800033a8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800033a8:	fe010113          	addi	sp,sp,-32
    800033ac:	00113c23          	sd	ra,24(sp)
    800033b0:	00813823          	sd	s0,16(sp)
    800033b4:	00913423          	sd	s1,8(sp)
    800033b8:	02010413          	addi	s0,sp,32
    800033bc:	00050493          	mv	s1,a0
    LOCK();
    800033c0:	00100613          	li	a2,1
    800033c4:	00000593          	li	a1,0
    800033c8:	00004517          	auipc	a0,0x4
    800033cc:	1e850513          	addi	a0,a0,488 # 800075b0 <lockPrint>
    800033d0:	ffffe097          	auipc	ra,0xffffe
    800033d4:	d80080e7          	jalr	-640(ra) # 80001150 <copy_and_swap>
    800033d8:	fe0514e3          	bnez	a0,800033c0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800033dc:	0004c503          	lbu	a0,0(s1)
    800033e0:	00050a63          	beqz	a0,800033f4 <_Z11printStringPKc+0x4c>
    {
        __putc(*string);
    800033e4:	00002097          	auipc	ra,0x2
    800033e8:	418080e7          	jalr	1048(ra) # 800057fc <__putc>
        string++;
    800033ec:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800033f0:	fedff06f          	j	800033dc <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800033f4:	00000613          	li	a2,0
    800033f8:	00100593          	li	a1,1
    800033fc:	00004517          	auipc	a0,0x4
    80003400:	1b450513          	addi	a0,a0,436 # 800075b0 <lockPrint>
    80003404:	ffffe097          	auipc	ra,0xffffe
    80003408:	d4c080e7          	jalr	-692(ra) # 80001150 <copy_and_swap>
    8000340c:	fe0514e3          	bnez	a0,800033f4 <_Z11printStringPKc+0x4c>
}
    80003410:	01813083          	ld	ra,24(sp)
    80003414:	01013403          	ld	s0,16(sp)
    80003418:	00813483          	ld	s1,8(sp)
    8000341c:	02010113          	addi	sp,sp,32
    80003420:	00008067          	ret

0000000080003424 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003424:	fd010113          	addi	sp,sp,-48
    80003428:	02113423          	sd	ra,40(sp)
    8000342c:	02813023          	sd	s0,32(sp)
    80003430:	00913c23          	sd	s1,24(sp)
    80003434:	01213823          	sd	s2,16(sp)
    80003438:	01313423          	sd	s3,8(sp)
    8000343c:	01413023          	sd	s4,0(sp)
    80003440:	03010413          	addi	s0,sp,48
    80003444:	00050993          	mv	s3,a0
    80003448:	00058a13          	mv	s4,a1
    LOCK();
    8000344c:	00100613          	li	a2,1
    80003450:	00000593          	li	a1,0
    80003454:	00004517          	auipc	a0,0x4
    80003458:	15c50513          	addi	a0,a0,348 # 800075b0 <lockPrint>
    8000345c:	ffffe097          	auipc	ra,0xffffe
    80003460:	cf4080e7          	jalr	-780(ra) # 80001150 <copy_and_swap>
    80003464:	fe0514e3          	bnez	a0,8000344c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003468:	00000913          	li	s2,0
    8000346c:	00090493          	mv	s1,s2
    80003470:	0019091b          	addiw	s2,s2,1
    80003474:	03495a63          	bge	s2,s4,800034a8 <_Z9getStringPci+0x84>
        cc = __getc();
    80003478:	00002097          	auipc	ra,0x2
    8000347c:	3c0080e7          	jalr	960(ra) # 80005838 <__getc>
        if(cc < 1)
    80003480:	02050463          	beqz	a0,800034a8 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80003484:	009984b3          	add	s1,s3,s1
    80003488:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000348c:	00a00793          	li	a5,10
    80003490:	00f50a63          	beq	a0,a5,800034a4 <_Z9getStringPci+0x80>
    80003494:	00d00793          	li	a5,13
    80003498:	fcf51ae3          	bne	a0,a5,8000346c <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000349c:	00090493          	mv	s1,s2
    800034a0:	0080006f          	j	800034a8 <_Z9getStringPci+0x84>
    800034a4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800034a8:	009984b3          	add	s1,s3,s1
    800034ac:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800034b0:	00000613          	li	a2,0
    800034b4:	00100593          	li	a1,1
    800034b8:	00004517          	auipc	a0,0x4
    800034bc:	0f850513          	addi	a0,a0,248 # 800075b0 <lockPrint>
    800034c0:	ffffe097          	auipc	ra,0xffffe
    800034c4:	c90080e7          	jalr	-880(ra) # 80001150 <copy_and_swap>
    800034c8:	fe0514e3          	bnez	a0,800034b0 <_Z9getStringPci+0x8c>
    return buf;
}
    800034cc:	00098513          	mv	a0,s3
    800034d0:	02813083          	ld	ra,40(sp)
    800034d4:	02013403          	ld	s0,32(sp)
    800034d8:	01813483          	ld	s1,24(sp)
    800034dc:	01013903          	ld	s2,16(sp)
    800034e0:	00813983          	ld	s3,8(sp)
    800034e4:	00013a03          	ld	s4,0(sp)
    800034e8:	03010113          	addi	sp,sp,48
    800034ec:	00008067          	ret

00000000800034f0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800034f0:	ff010113          	addi	sp,sp,-16
    800034f4:	00813423          	sd	s0,8(sp)
    800034f8:	01010413          	addi	s0,sp,16
    800034fc:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003500:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003504:	0006c603          	lbu	a2,0(a3)
    80003508:	fd06071b          	addiw	a4,a2,-48
    8000350c:	0ff77713          	andi	a4,a4,255
    80003510:	00900793          	li	a5,9
    80003514:	02e7e063          	bltu	a5,a4,80003534 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003518:	0025179b          	slliw	a5,a0,0x2
    8000351c:	00a787bb          	addw	a5,a5,a0
    80003520:	0017979b          	slliw	a5,a5,0x1
    80003524:	00168693          	addi	a3,a3,1
    80003528:	00c787bb          	addw	a5,a5,a2
    8000352c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003530:	fd5ff06f          	j	80003504 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003534:	00813403          	ld	s0,8(sp)
    80003538:	01010113          	addi	sp,sp,16
    8000353c:	00008067          	ret

0000000080003540 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003540:	fc010113          	addi	sp,sp,-64
    80003544:	02113c23          	sd	ra,56(sp)
    80003548:	02813823          	sd	s0,48(sp)
    8000354c:	02913423          	sd	s1,40(sp)
    80003550:	03213023          	sd	s2,32(sp)
    80003554:	01313c23          	sd	s3,24(sp)
    80003558:	04010413          	addi	s0,sp,64
    8000355c:	00050493          	mv	s1,a0
    80003560:	00058913          	mv	s2,a1
    80003564:	00060993          	mv	s3,a2
    LOCK();
    80003568:	00100613          	li	a2,1
    8000356c:	00000593          	li	a1,0
    80003570:	00004517          	auipc	a0,0x4
    80003574:	04050513          	addi	a0,a0,64 # 800075b0 <lockPrint>
    80003578:	ffffe097          	auipc	ra,0xffffe
    8000357c:	bd8080e7          	jalr	-1064(ra) # 80001150 <copy_and_swap>
    80003580:	fe0514e3          	bnez	a0,80003568 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003584:	00098463          	beqz	s3,8000358c <_Z8printIntiii+0x4c>
    80003588:	0804c463          	bltz	s1,80003610 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000358c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003590:	00000593          	li	a1,0
    }

    i = 0;
    80003594:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003598:	0009079b          	sext.w	a5,s2
    8000359c:	0325773b          	remuw	a4,a0,s2
    800035a0:	00048613          	mv	a2,s1
    800035a4:	0014849b          	addiw	s1,s1,1
    800035a8:	02071693          	slli	a3,a4,0x20
    800035ac:	0206d693          	srli	a3,a3,0x20
    800035b0:	00004717          	auipc	a4,0x4
    800035b4:	e8070713          	addi	a4,a4,-384 # 80007430 <digits>
    800035b8:	00d70733          	add	a4,a4,a3
    800035bc:	00074683          	lbu	a3,0(a4)
    800035c0:	fd040713          	addi	a4,s0,-48
    800035c4:	00c70733          	add	a4,a4,a2
    800035c8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800035cc:	0005071b          	sext.w	a4,a0
    800035d0:	0325553b          	divuw	a0,a0,s2
    800035d4:	fcf772e3          	bgeu	a4,a5,80003598 <_Z8printIntiii+0x58>
    if(neg)
    800035d8:	00058c63          	beqz	a1,800035f0 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800035dc:	fd040793          	addi	a5,s0,-48
    800035e0:	009784b3          	add	s1,a5,s1
    800035e4:	02d00793          	li	a5,45
    800035e8:	fef48823          	sb	a5,-16(s1)
    800035ec:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800035f0:	fff4849b          	addiw	s1,s1,-1
    800035f4:	0204c463          	bltz	s1,8000361c <_Z8printIntiii+0xdc>
        __putc(buf[i]);
    800035f8:	fd040793          	addi	a5,s0,-48
    800035fc:	009787b3          	add	a5,a5,s1
    80003600:	ff07c503          	lbu	a0,-16(a5)
    80003604:	00002097          	auipc	ra,0x2
    80003608:	1f8080e7          	jalr	504(ra) # 800057fc <__putc>
    8000360c:	fe5ff06f          	j	800035f0 <_Z8printIntiii+0xb0>
        x = -xx;
    80003610:	4090053b          	negw	a0,s1
        neg = 1;
    80003614:	00100593          	li	a1,1
        x = -xx;
    80003618:	f7dff06f          	j	80003594 <_Z8printIntiii+0x54>

    UNLOCK();
    8000361c:	00000613          	li	a2,0
    80003620:	00100593          	li	a1,1
    80003624:	00004517          	auipc	a0,0x4
    80003628:	f8c50513          	addi	a0,a0,-116 # 800075b0 <lockPrint>
    8000362c:	ffffe097          	auipc	ra,0xffffe
    80003630:	b24080e7          	jalr	-1244(ra) # 80001150 <copy_and_swap>
    80003634:	fe0514e3          	bnez	a0,8000361c <_Z8printIntiii+0xdc>
}
    80003638:	03813083          	ld	ra,56(sp)
    8000363c:	03013403          	ld	s0,48(sp)
    80003640:	02813483          	ld	s1,40(sp)
    80003644:	02013903          	ld	s2,32(sp)
    80003648:	01813983          	ld	s3,24(sp)
    8000364c:	04010113          	addi	sp,sp,64
    80003650:	00008067          	ret

0000000080003654 <_Z10printErrorv>:
void printError() {
    80003654:	fd010113          	addi	sp,sp,-48
    80003658:	02113423          	sd	ra,40(sp)
    8000365c:	02813023          	sd	s0,32(sp)
    80003660:	03010413          	addi	s0,sp,48
    LOCK();
    80003664:	00100613          	li	a2,1
    80003668:	00000593          	li	a1,0
    8000366c:	00004517          	auipc	a0,0x4
    80003670:	f4450513          	addi	a0,a0,-188 # 800075b0 <lockPrint>
    80003674:	ffffe097          	auipc	ra,0xffffe
    80003678:	adc080e7          	jalr	-1316(ra) # 80001150 <copy_and_swap>
    8000367c:	fe0514e3          	bnez	a0,80003664 <_Z10printErrorv+0x10>
    printString("scause: ");
    80003680:	00003517          	auipc	a0,0x3
    80003684:	ac850513          	addi	a0,a0,-1336 # 80006148 <CONSOLE_STATUS+0x138>
    80003688:	00000097          	auipc	ra,0x0
    8000368c:	d20080e7          	jalr	-736(ra) # 800033a8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003690:	142027f3          	csrr	a5,scause
    80003694:	fef43423          	sd	a5,-24(s0)
        return scause;
    80003698:	fe843503          	ld	a0,-24(s0)
    printInt(Kernel::r_scause());
    8000369c:	00000613          	li	a2,0
    800036a0:	00a00593          	li	a1,10
    800036a4:	0005051b          	sext.w	a0,a0
    800036a8:	00000097          	auipc	ra,0x0
    800036ac:	e98080e7          	jalr	-360(ra) # 80003540 <_Z8printIntiii>
    printString("\nsepc: ");
    800036b0:	00003517          	auipc	a0,0x3
    800036b4:	aa850513          	addi	a0,a0,-1368 # 80006158 <CONSOLE_STATUS+0x148>
    800036b8:	00000097          	auipc	ra,0x0
    800036bc:	cf0080e7          	jalr	-784(ra) # 800033a8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800036c0:	141027f3          	csrr	a5,sepc
    800036c4:	fef43023          	sd	a5,-32(s0)
        return sepc;
    800036c8:	fe043503          	ld	a0,-32(s0)
    printInt(Kernel::r_sepc());
    800036cc:	00000613          	li	a2,0
    800036d0:	00a00593          	li	a1,10
    800036d4:	0005051b          	sext.w	a0,a0
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	e68080e7          	jalr	-408(ra) # 80003540 <_Z8printIntiii>
    printString("\nstval: ");
    800036e0:	00003517          	auipc	a0,0x3
    800036e4:	a8050513          	addi	a0,a0,-1408 # 80006160 <CONSOLE_STATUS+0x150>
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	cc0080e7          	jalr	-832(ra) # 800033a8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800036f0:	143027f3          	csrr	a5,stval
    800036f4:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    800036f8:	fd843503          	ld	a0,-40(s0)
    printInt(Kernel::r_stval());
    800036fc:	00000613          	li	a2,0
    80003700:	00a00593          	li	a1,10
    80003704:	0005051b          	sext.w	a0,a0
    80003708:	00000097          	auipc	ra,0x0
    8000370c:	e38080e7          	jalr	-456(ra) # 80003540 <_Z8printIntiii>
    UNLOCK();
    80003710:	00000613          	li	a2,0
    80003714:	00100593          	li	a1,1
    80003718:	00004517          	auipc	a0,0x4
    8000371c:	e9850513          	addi	a0,a0,-360 # 800075b0 <lockPrint>
    80003720:	ffffe097          	auipc	ra,0xffffe
    80003724:	a30080e7          	jalr	-1488(ra) # 80001150 <copy_and_swap>
    80003728:	fe0514e3          	bnez	a0,80003710 <_Z10printErrorv+0xbc>
    8000372c:	02813083          	ld	ra,40(sp)
    80003730:	02013403          	ld	s0,32(sp)
    80003734:	03010113          	addi	sp,sp,48
    80003738:	00008067          	ret

000000008000373c <start>:
    8000373c:	ff010113          	addi	sp,sp,-16
    80003740:	00813423          	sd	s0,8(sp)
    80003744:	01010413          	addi	s0,sp,16
    80003748:	300027f3          	csrr	a5,mstatus
    8000374c:	ffffe737          	lui	a4,0xffffe
    80003750:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5fdf>
    80003754:	00e7f7b3          	and	a5,a5,a4
    80003758:	00001737          	lui	a4,0x1
    8000375c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003760:	00e7e7b3          	or	a5,a5,a4
    80003764:	30079073          	csrw	mstatus,a5
    80003768:	00000797          	auipc	a5,0x0
    8000376c:	16078793          	addi	a5,a5,352 # 800038c8 <system_main>
    80003770:	34179073          	csrw	mepc,a5
    80003774:	00000793          	li	a5,0
    80003778:	18079073          	csrw	satp,a5
    8000377c:	000107b7          	lui	a5,0x10
    80003780:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003784:	30279073          	csrw	medeleg,a5
    80003788:	30379073          	csrw	mideleg,a5
    8000378c:	104027f3          	csrr	a5,sie
    80003790:	2227e793          	ori	a5,a5,546
    80003794:	10479073          	csrw	sie,a5
    80003798:	fff00793          	li	a5,-1
    8000379c:	00a7d793          	srli	a5,a5,0xa
    800037a0:	3b079073          	csrw	pmpaddr0,a5
    800037a4:	00f00793          	li	a5,15
    800037a8:	3a079073          	csrw	pmpcfg0,a5
    800037ac:	f14027f3          	csrr	a5,mhartid
    800037b0:	0200c737          	lui	a4,0x200c
    800037b4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800037b8:	0007869b          	sext.w	a3,a5
    800037bc:	00269713          	slli	a4,a3,0x2
    800037c0:	000f4637          	lui	a2,0xf4
    800037c4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800037c8:	00d70733          	add	a4,a4,a3
    800037cc:	0037979b          	slliw	a5,a5,0x3
    800037d0:	020046b7          	lui	a3,0x2004
    800037d4:	00d787b3          	add	a5,a5,a3
    800037d8:	00c585b3          	add	a1,a1,a2
    800037dc:	00371693          	slli	a3,a4,0x3
    800037e0:	00004717          	auipc	a4,0x4
    800037e4:	de070713          	addi	a4,a4,-544 # 800075c0 <timer_scratch>
    800037e8:	00b7b023          	sd	a1,0(a5)
    800037ec:	00d70733          	add	a4,a4,a3
    800037f0:	00f73c23          	sd	a5,24(a4)
    800037f4:	02c73023          	sd	a2,32(a4)
    800037f8:	34071073          	csrw	mscratch,a4
    800037fc:	00000797          	auipc	a5,0x0
    80003800:	6e478793          	addi	a5,a5,1764 # 80003ee0 <timervec>
    80003804:	30579073          	csrw	mtvec,a5
    80003808:	300027f3          	csrr	a5,mstatus
    8000380c:	0087e793          	ori	a5,a5,8
    80003810:	30079073          	csrw	mstatus,a5
    80003814:	304027f3          	csrr	a5,mie
    80003818:	0807e793          	ori	a5,a5,128
    8000381c:	30479073          	csrw	mie,a5
    80003820:	f14027f3          	csrr	a5,mhartid
    80003824:	0007879b          	sext.w	a5,a5
    80003828:	00078213          	mv	tp,a5
    8000382c:	30200073          	mret
    80003830:	00813403          	ld	s0,8(sp)
    80003834:	01010113          	addi	sp,sp,16
    80003838:	00008067          	ret

000000008000383c <timerinit>:
    8000383c:	ff010113          	addi	sp,sp,-16
    80003840:	00813423          	sd	s0,8(sp)
    80003844:	01010413          	addi	s0,sp,16
    80003848:	f14027f3          	csrr	a5,mhartid
    8000384c:	0200c737          	lui	a4,0x200c
    80003850:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003854:	0007869b          	sext.w	a3,a5
    80003858:	00269713          	slli	a4,a3,0x2
    8000385c:	000f4637          	lui	a2,0xf4
    80003860:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003864:	00d70733          	add	a4,a4,a3
    80003868:	0037979b          	slliw	a5,a5,0x3
    8000386c:	020046b7          	lui	a3,0x2004
    80003870:	00d787b3          	add	a5,a5,a3
    80003874:	00c585b3          	add	a1,a1,a2
    80003878:	00371693          	slli	a3,a4,0x3
    8000387c:	00004717          	auipc	a4,0x4
    80003880:	d4470713          	addi	a4,a4,-700 # 800075c0 <timer_scratch>
    80003884:	00b7b023          	sd	a1,0(a5)
    80003888:	00d70733          	add	a4,a4,a3
    8000388c:	00f73c23          	sd	a5,24(a4)
    80003890:	02c73023          	sd	a2,32(a4)
    80003894:	34071073          	csrw	mscratch,a4
    80003898:	00000797          	auipc	a5,0x0
    8000389c:	64878793          	addi	a5,a5,1608 # 80003ee0 <timervec>
    800038a0:	30579073          	csrw	mtvec,a5
    800038a4:	300027f3          	csrr	a5,mstatus
    800038a8:	0087e793          	ori	a5,a5,8
    800038ac:	30079073          	csrw	mstatus,a5
    800038b0:	304027f3          	csrr	a5,mie
    800038b4:	0807e793          	ori	a5,a5,128
    800038b8:	30479073          	csrw	mie,a5
    800038bc:	00813403          	ld	s0,8(sp)
    800038c0:	01010113          	addi	sp,sp,16
    800038c4:	00008067          	ret

00000000800038c8 <system_main>:
    800038c8:	fe010113          	addi	sp,sp,-32
    800038cc:	00813823          	sd	s0,16(sp)
    800038d0:	00913423          	sd	s1,8(sp)
    800038d4:	00113c23          	sd	ra,24(sp)
    800038d8:	02010413          	addi	s0,sp,32
    800038dc:	00000097          	auipc	ra,0x0
    800038e0:	0c4080e7          	jalr	196(ra) # 800039a0 <cpuid>
    800038e4:	00004497          	auipc	s1,0x4
    800038e8:	c1c48493          	addi	s1,s1,-996 # 80007500 <started>
    800038ec:	02050263          	beqz	a0,80003910 <system_main+0x48>
    800038f0:	0004a783          	lw	a5,0(s1)
    800038f4:	0007879b          	sext.w	a5,a5
    800038f8:	fe078ce3          	beqz	a5,800038f0 <system_main+0x28>
    800038fc:	0ff0000f          	fence
    80003900:	00003517          	auipc	a0,0x3
    80003904:	8a050513          	addi	a0,a0,-1888 # 800061a0 <CONSOLE_STATUS+0x190>
    80003908:	00001097          	auipc	ra,0x1
    8000390c:	a74080e7          	jalr	-1420(ra) # 8000437c <panic>
    80003910:	00001097          	auipc	ra,0x1
    80003914:	9c8080e7          	jalr	-1592(ra) # 800042d8 <consoleinit>
    80003918:	00001097          	auipc	ra,0x1
    8000391c:	154080e7          	jalr	340(ra) # 80004a6c <printfinit>
    80003920:	00003517          	auipc	a0,0x3
    80003924:	96050513          	addi	a0,a0,-1696 # 80006280 <CONSOLE_STATUS+0x270>
    80003928:	00001097          	auipc	ra,0x1
    8000392c:	ab0080e7          	jalr	-1360(ra) # 800043d8 <__printf>
    80003930:	00003517          	auipc	a0,0x3
    80003934:	84050513          	addi	a0,a0,-1984 # 80006170 <CONSOLE_STATUS+0x160>
    80003938:	00001097          	auipc	ra,0x1
    8000393c:	aa0080e7          	jalr	-1376(ra) # 800043d8 <__printf>
    80003940:	00003517          	auipc	a0,0x3
    80003944:	94050513          	addi	a0,a0,-1728 # 80006280 <CONSOLE_STATUS+0x270>
    80003948:	00001097          	auipc	ra,0x1
    8000394c:	a90080e7          	jalr	-1392(ra) # 800043d8 <__printf>
    80003950:	00001097          	auipc	ra,0x1
    80003954:	4a8080e7          	jalr	1192(ra) # 80004df8 <kinit>
    80003958:	00000097          	auipc	ra,0x0
    8000395c:	148080e7          	jalr	328(ra) # 80003aa0 <trapinit>
    80003960:	00000097          	auipc	ra,0x0
    80003964:	16c080e7          	jalr	364(ra) # 80003acc <trapinithart>
    80003968:	00000097          	auipc	ra,0x0
    8000396c:	5b8080e7          	jalr	1464(ra) # 80003f20 <plicinit>
    80003970:	00000097          	auipc	ra,0x0
    80003974:	5d8080e7          	jalr	1496(ra) # 80003f48 <plicinithart>
    80003978:	00000097          	auipc	ra,0x0
    8000397c:	078080e7          	jalr	120(ra) # 800039f0 <userinit>
    80003980:	0ff0000f          	fence
    80003984:	00100793          	li	a5,1
    80003988:	00003517          	auipc	a0,0x3
    8000398c:	80050513          	addi	a0,a0,-2048 # 80006188 <CONSOLE_STATUS+0x178>
    80003990:	00f4a023          	sw	a5,0(s1)
    80003994:	00001097          	auipc	ra,0x1
    80003998:	a44080e7          	jalr	-1468(ra) # 800043d8 <__printf>
    8000399c:	0000006f          	j	8000399c <system_main+0xd4>

00000000800039a0 <cpuid>:
    800039a0:	ff010113          	addi	sp,sp,-16
    800039a4:	00813423          	sd	s0,8(sp)
    800039a8:	01010413          	addi	s0,sp,16
    800039ac:	00020513          	mv	a0,tp
    800039b0:	00813403          	ld	s0,8(sp)
    800039b4:	0005051b          	sext.w	a0,a0
    800039b8:	01010113          	addi	sp,sp,16
    800039bc:	00008067          	ret

00000000800039c0 <mycpu>:
    800039c0:	ff010113          	addi	sp,sp,-16
    800039c4:	00813423          	sd	s0,8(sp)
    800039c8:	01010413          	addi	s0,sp,16
    800039cc:	00020793          	mv	a5,tp
    800039d0:	00813403          	ld	s0,8(sp)
    800039d4:	0007879b          	sext.w	a5,a5
    800039d8:	00779793          	slli	a5,a5,0x7
    800039dc:	00005517          	auipc	a0,0x5
    800039e0:	c1450513          	addi	a0,a0,-1004 # 800085f0 <cpus>
    800039e4:	00f50533          	add	a0,a0,a5
    800039e8:	01010113          	addi	sp,sp,16
    800039ec:	00008067          	ret

00000000800039f0 <userinit>:
    800039f0:	ff010113          	addi	sp,sp,-16
    800039f4:	00813423          	sd	s0,8(sp)
    800039f8:	01010413          	addi	s0,sp,16
    800039fc:	00813403          	ld	s0,8(sp)
    80003a00:	01010113          	addi	sp,sp,16
    80003a04:	fffff317          	auipc	t1,0xfffff
    80003a08:	a7c30067          	jr	-1412(t1) # 80002480 <main>

0000000080003a0c <either_copyout>:
    80003a0c:	ff010113          	addi	sp,sp,-16
    80003a10:	00813023          	sd	s0,0(sp)
    80003a14:	00113423          	sd	ra,8(sp)
    80003a18:	01010413          	addi	s0,sp,16
    80003a1c:	02051663          	bnez	a0,80003a48 <either_copyout+0x3c>
    80003a20:	00058513          	mv	a0,a1
    80003a24:	00060593          	mv	a1,a2
    80003a28:	0006861b          	sext.w	a2,a3
    80003a2c:	00002097          	auipc	ra,0x2
    80003a30:	c58080e7          	jalr	-936(ra) # 80005684 <__memmove>
    80003a34:	00813083          	ld	ra,8(sp)
    80003a38:	00013403          	ld	s0,0(sp)
    80003a3c:	00000513          	li	a0,0
    80003a40:	01010113          	addi	sp,sp,16
    80003a44:	00008067          	ret
    80003a48:	00002517          	auipc	a0,0x2
    80003a4c:	78050513          	addi	a0,a0,1920 # 800061c8 <CONSOLE_STATUS+0x1b8>
    80003a50:	00001097          	auipc	ra,0x1
    80003a54:	92c080e7          	jalr	-1748(ra) # 8000437c <panic>

0000000080003a58 <either_copyin>:
    80003a58:	ff010113          	addi	sp,sp,-16
    80003a5c:	00813023          	sd	s0,0(sp)
    80003a60:	00113423          	sd	ra,8(sp)
    80003a64:	01010413          	addi	s0,sp,16
    80003a68:	02059463          	bnez	a1,80003a90 <either_copyin+0x38>
    80003a6c:	00060593          	mv	a1,a2
    80003a70:	0006861b          	sext.w	a2,a3
    80003a74:	00002097          	auipc	ra,0x2
    80003a78:	c10080e7          	jalr	-1008(ra) # 80005684 <__memmove>
    80003a7c:	00813083          	ld	ra,8(sp)
    80003a80:	00013403          	ld	s0,0(sp)
    80003a84:	00000513          	li	a0,0
    80003a88:	01010113          	addi	sp,sp,16
    80003a8c:	00008067          	ret
    80003a90:	00002517          	auipc	a0,0x2
    80003a94:	76050513          	addi	a0,a0,1888 # 800061f0 <CONSOLE_STATUS+0x1e0>
    80003a98:	00001097          	auipc	ra,0x1
    80003a9c:	8e4080e7          	jalr	-1820(ra) # 8000437c <panic>

0000000080003aa0 <trapinit>:
    80003aa0:	ff010113          	addi	sp,sp,-16
    80003aa4:	00813423          	sd	s0,8(sp)
    80003aa8:	01010413          	addi	s0,sp,16
    80003aac:	00813403          	ld	s0,8(sp)
    80003ab0:	00002597          	auipc	a1,0x2
    80003ab4:	76858593          	addi	a1,a1,1896 # 80006218 <CONSOLE_STATUS+0x208>
    80003ab8:	00005517          	auipc	a0,0x5
    80003abc:	bb850513          	addi	a0,a0,-1096 # 80008670 <tickslock>
    80003ac0:	01010113          	addi	sp,sp,16
    80003ac4:	00001317          	auipc	t1,0x1
    80003ac8:	5c430067          	jr	1476(t1) # 80005088 <initlock>

0000000080003acc <trapinithart>:
    80003acc:	ff010113          	addi	sp,sp,-16
    80003ad0:	00813423          	sd	s0,8(sp)
    80003ad4:	01010413          	addi	s0,sp,16
    80003ad8:	00000797          	auipc	a5,0x0
    80003adc:	2f878793          	addi	a5,a5,760 # 80003dd0 <kernelvec>
    80003ae0:	10579073          	csrw	stvec,a5
    80003ae4:	00813403          	ld	s0,8(sp)
    80003ae8:	01010113          	addi	sp,sp,16
    80003aec:	00008067          	ret

0000000080003af0 <usertrap>:
    80003af0:	ff010113          	addi	sp,sp,-16
    80003af4:	00813423          	sd	s0,8(sp)
    80003af8:	01010413          	addi	s0,sp,16
    80003afc:	00813403          	ld	s0,8(sp)
    80003b00:	01010113          	addi	sp,sp,16
    80003b04:	00008067          	ret

0000000080003b08 <usertrapret>:
    80003b08:	ff010113          	addi	sp,sp,-16
    80003b0c:	00813423          	sd	s0,8(sp)
    80003b10:	01010413          	addi	s0,sp,16
    80003b14:	00813403          	ld	s0,8(sp)
    80003b18:	01010113          	addi	sp,sp,16
    80003b1c:	00008067          	ret

0000000080003b20 <kerneltrap>:
    80003b20:	fe010113          	addi	sp,sp,-32
    80003b24:	00813823          	sd	s0,16(sp)
    80003b28:	00113c23          	sd	ra,24(sp)
    80003b2c:	00913423          	sd	s1,8(sp)
    80003b30:	02010413          	addi	s0,sp,32
    80003b34:	142025f3          	csrr	a1,scause
    80003b38:	100027f3          	csrr	a5,sstatus
    80003b3c:	0027f793          	andi	a5,a5,2
    80003b40:	10079c63          	bnez	a5,80003c58 <kerneltrap+0x138>
    80003b44:	142027f3          	csrr	a5,scause
    80003b48:	0207ce63          	bltz	a5,80003b84 <kerneltrap+0x64>
    80003b4c:	00002517          	auipc	a0,0x2
    80003b50:	71450513          	addi	a0,a0,1812 # 80006260 <CONSOLE_STATUS+0x250>
    80003b54:	00001097          	auipc	ra,0x1
    80003b58:	884080e7          	jalr	-1916(ra) # 800043d8 <__printf>
    80003b5c:	141025f3          	csrr	a1,sepc
    80003b60:	14302673          	csrr	a2,stval
    80003b64:	00002517          	auipc	a0,0x2
    80003b68:	70c50513          	addi	a0,a0,1804 # 80006270 <CONSOLE_STATUS+0x260>
    80003b6c:	00001097          	auipc	ra,0x1
    80003b70:	86c080e7          	jalr	-1940(ra) # 800043d8 <__printf>
    80003b74:	00002517          	auipc	a0,0x2
    80003b78:	71450513          	addi	a0,a0,1812 # 80006288 <CONSOLE_STATUS+0x278>
    80003b7c:	00001097          	auipc	ra,0x1
    80003b80:	800080e7          	jalr	-2048(ra) # 8000437c <panic>
    80003b84:	0ff7f713          	andi	a4,a5,255
    80003b88:	00900693          	li	a3,9
    80003b8c:	04d70063          	beq	a4,a3,80003bcc <kerneltrap+0xac>
    80003b90:	fff00713          	li	a4,-1
    80003b94:	03f71713          	slli	a4,a4,0x3f
    80003b98:	00170713          	addi	a4,a4,1
    80003b9c:	fae798e3          	bne	a5,a4,80003b4c <kerneltrap+0x2c>
    80003ba0:	00000097          	auipc	ra,0x0
    80003ba4:	e00080e7          	jalr	-512(ra) # 800039a0 <cpuid>
    80003ba8:	06050663          	beqz	a0,80003c14 <kerneltrap+0xf4>
    80003bac:	144027f3          	csrr	a5,sip
    80003bb0:	ffd7f793          	andi	a5,a5,-3
    80003bb4:	14479073          	csrw	sip,a5
    80003bb8:	01813083          	ld	ra,24(sp)
    80003bbc:	01013403          	ld	s0,16(sp)
    80003bc0:	00813483          	ld	s1,8(sp)
    80003bc4:	02010113          	addi	sp,sp,32
    80003bc8:	00008067          	ret
    80003bcc:	00000097          	auipc	ra,0x0
    80003bd0:	3c8080e7          	jalr	968(ra) # 80003f94 <plic_claim>
    80003bd4:	00a00793          	li	a5,10
    80003bd8:	00050493          	mv	s1,a0
    80003bdc:	06f50863          	beq	a0,a5,80003c4c <kerneltrap+0x12c>
    80003be0:	fc050ce3          	beqz	a0,80003bb8 <kerneltrap+0x98>
    80003be4:	00050593          	mv	a1,a0
    80003be8:	00002517          	auipc	a0,0x2
    80003bec:	65850513          	addi	a0,a0,1624 # 80006240 <CONSOLE_STATUS+0x230>
    80003bf0:	00000097          	auipc	ra,0x0
    80003bf4:	7e8080e7          	jalr	2024(ra) # 800043d8 <__printf>
    80003bf8:	01013403          	ld	s0,16(sp)
    80003bfc:	01813083          	ld	ra,24(sp)
    80003c00:	00048513          	mv	a0,s1
    80003c04:	00813483          	ld	s1,8(sp)
    80003c08:	02010113          	addi	sp,sp,32
    80003c0c:	00000317          	auipc	t1,0x0
    80003c10:	3c030067          	jr	960(t1) # 80003fcc <plic_complete>
    80003c14:	00005517          	auipc	a0,0x5
    80003c18:	a5c50513          	addi	a0,a0,-1444 # 80008670 <tickslock>
    80003c1c:	00001097          	auipc	ra,0x1
    80003c20:	490080e7          	jalr	1168(ra) # 800050ac <acquire>
    80003c24:	00004717          	auipc	a4,0x4
    80003c28:	8e070713          	addi	a4,a4,-1824 # 80007504 <ticks>
    80003c2c:	00072783          	lw	a5,0(a4)
    80003c30:	00005517          	auipc	a0,0x5
    80003c34:	a4050513          	addi	a0,a0,-1472 # 80008670 <tickslock>
    80003c38:	0017879b          	addiw	a5,a5,1
    80003c3c:	00f72023          	sw	a5,0(a4)
    80003c40:	00001097          	auipc	ra,0x1
    80003c44:	538080e7          	jalr	1336(ra) # 80005178 <release>
    80003c48:	f65ff06f          	j	80003bac <kerneltrap+0x8c>
    80003c4c:	00001097          	auipc	ra,0x1
    80003c50:	094080e7          	jalr	148(ra) # 80004ce0 <uartintr>
    80003c54:	fa5ff06f          	j	80003bf8 <kerneltrap+0xd8>
    80003c58:	00002517          	auipc	a0,0x2
    80003c5c:	5c850513          	addi	a0,a0,1480 # 80006220 <CONSOLE_STATUS+0x210>
    80003c60:	00000097          	auipc	ra,0x0
    80003c64:	71c080e7          	jalr	1820(ra) # 8000437c <panic>

0000000080003c68 <clockintr>:
    80003c68:	fe010113          	addi	sp,sp,-32
    80003c6c:	00813823          	sd	s0,16(sp)
    80003c70:	00913423          	sd	s1,8(sp)
    80003c74:	00113c23          	sd	ra,24(sp)
    80003c78:	02010413          	addi	s0,sp,32
    80003c7c:	00005497          	auipc	s1,0x5
    80003c80:	9f448493          	addi	s1,s1,-1548 # 80008670 <tickslock>
    80003c84:	00048513          	mv	a0,s1
    80003c88:	00001097          	auipc	ra,0x1
    80003c8c:	424080e7          	jalr	1060(ra) # 800050ac <acquire>
    80003c90:	00004717          	auipc	a4,0x4
    80003c94:	87470713          	addi	a4,a4,-1932 # 80007504 <ticks>
    80003c98:	00072783          	lw	a5,0(a4)
    80003c9c:	01013403          	ld	s0,16(sp)
    80003ca0:	01813083          	ld	ra,24(sp)
    80003ca4:	00048513          	mv	a0,s1
    80003ca8:	0017879b          	addiw	a5,a5,1
    80003cac:	00813483          	ld	s1,8(sp)
    80003cb0:	00f72023          	sw	a5,0(a4)
    80003cb4:	02010113          	addi	sp,sp,32
    80003cb8:	00001317          	auipc	t1,0x1
    80003cbc:	4c030067          	jr	1216(t1) # 80005178 <release>

0000000080003cc0 <devintr>:
    80003cc0:	142027f3          	csrr	a5,scause
    80003cc4:	00000513          	li	a0,0
    80003cc8:	0007c463          	bltz	a5,80003cd0 <devintr+0x10>
    80003ccc:	00008067          	ret
    80003cd0:	fe010113          	addi	sp,sp,-32
    80003cd4:	00813823          	sd	s0,16(sp)
    80003cd8:	00113c23          	sd	ra,24(sp)
    80003cdc:	00913423          	sd	s1,8(sp)
    80003ce0:	02010413          	addi	s0,sp,32
    80003ce4:	0ff7f713          	andi	a4,a5,255
    80003ce8:	00900693          	li	a3,9
    80003cec:	04d70c63          	beq	a4,a3,80003d44 <devintr+0x84>
    80003cf0:	fff00713          	li	a4,-1
    80003cf4:	03f71713          	slli	a4,a4,0x3f
    80003cf8:	00170713          	addi	a4,a4,1
    80003cfc:	00e78c63          	beq	a5,a4,80003d14 <devintr+0x54>
    80003d00:	01813083          	ld	ra,24(sp)
    80003d04:	01013403          	ld	s0,16(sp)
    80003d08:	00813483          	ld	s1,8(sp)
    80003d0c:	02010113          	addi	sp,sp,32
    80003d10:	00008067          	ret
    80003d14:	00000097          	auipc	ra,0x0
    80003d18:	c8c080e7          	jalr	-884(ra) # 800039a0 <cpuid>
    80003d1c:	06050663          	beqz	a0,80003d88 <devintr+0xc8>
    80003d20:	144027f3          	csrr	a5,sip
    80003d24:	ffd7f793          	andi	a5,a5,-3
    80003d28:	14479073          	csrw	sip,a5
    80003d2c:	01813083          	ld	ra,24(sp)
    80003d30:	01013403          	ld	s0,16(sp)
    80003d34:	00813483          	ld	s1,8(sp)
    80003d38:	00200513          	li	a0,2
    80003d3c:	02010113          	addi	sp,sp,32
    80003d40:	00008067          	ret
    80003d44:	00000097          	auipc	ra,0x0
    80003d48:	250080e7          	jalr	592(ra) # 80003f94 <plic_claim>
    80003d4c:	00a00793          	li	a5,10
    80003d50:	00050493          	mv	s1,a0
    80003d54:	06f50663          	beq	a0,a5,80003dc0 <devintr+0x100>
    80003d58:	00100513          	li	a0,1
    80003d5c:	fa0482e3          	beqz	s1,80003d00 <devintr+0x40>
    80003d60:	00048593          	mv	a1,s1
    80003d64:	00002517          	auipc	a0,0x2
    80003d68:	4dc50513          	addi	a0,a0,1244 # 80006240 <CONSOLE_STATUS+0x230>
    80003d6c:	00000097          	auipc	ra,0x0
    80003d70:	66c080e7          	jalr	1644(ra) # 800043d8 <__printf>
    80003d74:	00048513          	mv	a0,s1
    80003d78:	00000097          	auipc	ra,0x0
    80003d7c:	254080e7          	jalr	596(ra) # 80003fcc <plic_complete>
    80003d80:	00100513          	li	a0,1
    80003d84:	f7dff06f          	j	80003d00 <devintr+0x40>
    80003d88:	00005517          	auipc	a0,0x5
    80003d8c:	8e850513          	addi	a0,a0,-1816 # 80008670 <tickslock>
    80003d90:	00001097          	auipc	ra,0x1
    80003d94:	31c080e7          	jalr	796(ra) # 800050ac <acquire>
    80003d98:	00003717          	auipc	a4,0x3
    80003d9c:	76c70713          	addi	a4,a4,1900 # 80007504 <ticks>
    80003da0:	00072783          	lw	a5,0(a4)
    80003da4:	00005517          	auipc	a0,0x5
    80003da8:	8cc50513          	addi	a0,a0,-1844 # 80008670 <tickslock>
    80003dac:	0017879b          	addiw	a5,a5,1
    80003db0:	00f72023          	sw	a5,0(a4)
    80003db4:	00001097          	auipc	ra,0x1
    80003db8:	3c4080e7          	jalr	964(ra) # 80005178 <release>
    80003dbc:	f65ff06f          	j	80003d20 <devintr+0x60>
    80003dc0:	00001097          	auipc	ra,0x1
    80003dc4:	f20080e7          	jalr	-224(ra) # 80004ce0 <uartintr>
    80003dc8:	fadff06f          	j	80003d74 <devintr+0xb4>
    80003dcc:	0000                	unimp
	...

0000000080003dd0 <kernelvec>:
    80003dd0:	f0010113          	addi	sp,sp,-256
    80003dd4:	00113023          	sd	ra,0(sp)
    80003dd8:	00213423          	sd	sp,8(sp)
    80003ddc:	00313823          	sd	gp,16(sp)
    80003de0:	00413c23          	sd	tp,24(sp)
    80003de4:	02513023          	sd	t0,32(sp)
    80003de8:	02613423          	sd	t1,40(sp)
    80003dec:	02713823          	sd	t2,48(sp)
    80003df0:	02813c23          	sd	s0,56(sp)
    80003df4:	04913023          	sd	s1,64(sp)
    80003df8:	04a13423          	sd	a0,72(sp)
    80003dfc:	04b13823          	sd	a1,80(sp)
    80003e00:	04c13c23          	sd	a2,88(sp)
    80003e04:	06d13023          	sd	a3,96(sp)
    80003e08:	06e13423          	sd	a4,104(sp)
    80003e0c:	06f13823          	sd	a5,112(sp)
    80003e10:	07013c23          	sd	a6,120(sp)
    80003e14:	09113023          	sd	a7,128(sp)
    80003e18:	09213423          	sd	s2,136(sp)
    80003e1c:	09313823          	sd	s3,144(sp)
    80003e20:	09413c23          	sd	s4,152(sp)
    80003e24:	0b513023          	sd	s5,160(sp)
    80003e28:	0b613423          	sd	s6,168(sp)
    80003e2c:	0b713823          	sd	s7,176(sp)
    80003e30:	0b813c23          	sd	s8,184(sp)
    80003e34:	0d913023          	sd	s9,192(sp)
    80003e38:	0da13423          	sd	s10,200(sp)
    80003e3c:	0db13823          	sd	s11,208(sp)
    80003e40:	0dc13c23          	sd	t3,216(sp)
    80003e44:	0fd13023          	sd	t4,224(sp)
    80003e48:	0fe13423          	sd	t5,232(sp)
    80003e4c:	0ff13823          	sd	t6,240(sp)
    80003e50:	cd1ff0ef          	jal	ra,80003b20 <kerneltrap>
    80003e54:	00013083          	ld	ra,0(sp)
    80003e58:	00813103          	ld	sp,8(sp)
    80003e5c:	01013183          	ld	gp,16(sp)
    80003e60:	02013283          	ld	t0,32(sp)
    80003e64:	02813303          	ld	t1,40(sp)
    80003e68:	03013383          	ld	t2,48(sp)
    80003e6c:	03813403          	ld	s0,56(sp)
    80003e70:	04013483          	ld	s1,64(sp)
    80003e74:	04813503          	ld	a0,72(sp)
    80003e78:	05013583          	ld	a1,80(sp)
    80003e7c:	05813603          	ld	a2,88(sp)
    80003e80:	06013683          	ld	a3,96(sp)
    80003e84:	06813703          	ld	a4,104(sp)
    80003e88:	07013783          	ld	a5,112(sp)
    80003e8c:	07813803          	ld	a6,120(sp)
    80003e90:	08013883          	ld	a7,128(sp)
    80003e94:	08813903          	ld	s2,136(sp)
    80003e98:	09013983          	ld	s3,144(sp)
    80003e9c:	09813a03          	ld	s4,152(sp)
    80003ea0:	0a013a83          	ld	s5,160(sp)
    80003ea4:	0a813b03          	ld	s6,168(sp)
    80003ea8:	0b013b83          	ld	s7,176(sp)
    80003eac:	0b813c03          	ld	s8,184(sp)
    80003eb0:	0c013c83          	ld	s9,192(sp)
    80003eb4:	0c813d03          	ld	s10,200(sp)
    80003eb8:	0d013d83          	ld	s11,208(sp)
    80003ebc:	0d813e03          	ld	t3,216(sp)
    80003ec0:	0e013e83          	ld	t4,224(sp)
    80003ec4:	0e813f03          	ld	t5,232(sp)
    80003ec8:	0f013f83          	ld	t6,240(sp)
    80003ecc:	10010113          	addi	sp,sp,256
    80003ed0:	10200073          	sret
    80003ed4:	00000013          	nop
    80003ed8:	00000013          	nop
    80003edc:	00000013          	nop

0000000080003ee0 <timervec>:
    80003ee0:	34051573          	csrrw	a0,mscratch,a0
    80003ee4:	00b53023          	sd	a1,0(a0)
    80003ee8:	00c53423          	sd	a2,8(a0)
    80003eec:	00d53823          	sd	a3,16(a0)
    80003ef0:	01853583          	ld	a1,24(a0)
    80003ef4:	02053603          	ld	a2,32(a0)
    80003ef8:	0005b683          	ld	a3,0(a1)
    80003efc:	00c686b3          	add	a3,a3,a2
    80003f00:	00d5b023          	sd	a3,0(a1)
    80003f04:	00200593          	li	a1,2
    80003f08:	14459073          	csrw	sip,a1
    80003f0c:	01053683          	ld	a3,16(a0)
    80003f10:	00853603          	ld	a2,8(a0)
    80003f14:	00053583          	ld	a1,0(a0)
    80003f18:	34051573          	csrrw	a0,mscratch,a0
    80003f1c:	30200073          	mret

0000000080003f20 <plicinit>:
    80003f20:	ff010113          	addi	sp,sp,-16
    80003f24:	00813423          	sd	s0,8(sp)
    80003f28:	01010413          	addi	s0,sp,16
    80003f2c:	00813403          	ld	s0,8(sp)
    80003f30:	0c0007b7          	lui	a5,0xc000
    80003f34:	00100713          	li	a4,1
    80003f38:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003f3c:	00e7a223          	sw	a4,4(a5)
    80003f40:	01010113          	addi	sp,sp,16
    80003f44:	00008067          	ret

0000000080003f48 <plicinithart>:
    80003f48:	ff010113          	addi	sp,sp,-16
    80003f4c:	00813023          	sd	s0,0(sp)
    80003f50:	00113423          	sd	ra,8(sp)
    80003f54:	01010413          	addi	s0,sp,16
    80003f58:	00000097          	auipc	ra,0x0
    80003f5c:	a48080e7          	jalr	-1464(ra) # 800039a0 <cpuid>
    80003f60:	0085171b          	slliw	a4,a0,0x8
    80003f64:	0c0027b7          	lui	a5,0xc002
    80003f68:	00e787b3          	add	a5,a5,a4
    80003f6c:	40200713          	li	a4,1026
    80003f70:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003f74:	00813083          	ld	ra,8(sp)
    80003f78:	00013403          	ld	s0,0(sp)
    80003f7c:	00d5151b          	slliw	a0,a0,0xd
    80003f80:	0c2017b7          	lui	a5,0xc201
    80003f84:	00a78533          	add	a0,a5,a0
    80003f88:	00052023          	sw	zero,0(a0)
    80003f8c:	01010113          	addi	sp,sp,16
    80003f90:	00008067          	ret

0000000080003f94 <plic_claim>:
    80003f94:	ff010113          	addi	sp,sp,-16
    80003f98:	00813023          	sd	s0,0(sp)
    80003f9c:	00113423          	sd	ra,8(sp)
    80003fa0:	01010413          	addi	s0,sp,16
    80003fa4:	00000097          	auipc	ra,0x0
    80003fa8:	9fc080e7          	jalr	-1540(ra) # 800039a0 <cpuid>
    80003fac:	00813083          	ld	ra,8(sp)
    80003fb0:	00013403          	ld	s0,0(sp)
    80003fb4:	00d5151b          	slliw	a0,a0,0xd
    80003fb8:	0c2017b7          	lui	a5,0xc201
    80003fbc:	00a78533          	add	a0,a5,a0
    80003fc0:	00452503          	lw	a0,4(a0)
    80003fc4:	01010113          	addi	sp,sp,16
    80003fc8:	00008067          	ret

0000000080003fcc <plic_complete>:
    80003fcc:	fe010113          	addi	sp,sp,-32
    80003fd0:	00813823          	sd	s0,16(sp)
    80003fd4:	00913423          	sd	s1,8(sp)
    80003fd8:	00113c23          	sd	ra,24(sp)
    80003fdc:	02010413          	addi	s0,sp,32
    80003fe0:	00050493          	mv	s1,a0
    80003fe4:	00000097          	auipc	ra,0x0
    80003fe8:	9bc080e7          	jalr	-1604(ra) # 800039a0 <cpuid>
    80003fec:	01813083          	ld	ra,24(sp)
    80003ff0:	01013403          	ld	s0,16(sp)
    80003ff4:	00d5179b          	slliw	a5,a0,0xd
    80003ff8:	0c201737          	lui	a4,0xc201
    80003ffc:	00f707b3          	add	a5,a4,a5
    80004000:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004004:	00813483          	ld	s1,8(sp)
    80004008:	02010113          	addi	sp,sp,32
    8000400c:	00008067          	ret

0000000080004010 <consolewrite>:
    80004010:	fb010113          	addi	sp,sp,-80
    80004014:	04813023          	sd	s0,64(sp)
    80004018:	04113423          	sd	ra,72(sp)
    8000401c:	02913c23          	sd	s1,56(sp)
    80004020:	03213823          	sd	s2,48(sp)
    80004024:	03313423          	sd	s3,40(sp)
    80004028:	03413023          	sd	s4,32(sp)
    8000402c:	01513c23          	sd	s5,24(sp)
    80004030:	05010413          	addi	s0,sp,80
    80004034:	06c05c63          	blez	a2,800040ac <consolewrite+0x9c>
    80004038:	00060993          	mv	s3,a2
    8000403c:	00050a13          	mv	s4,a0
    80004040:	00058493          	mv	s1,a1
    80004044:	00000913          	li	s2,0
    80004048:	fff00a93          	li	s5,-1
    8000404c:	01c0006f          	j	80004068 <consolewrite+0x58>
    80004050:	fbf44503          	lbu	a0,-65(s0)
    80004054:	0019091b          	addiw	s2,s2,1
    80004058:	00148493          	addi	s1,s1,1
    8000405c:	00001097          	auipc	ra,0x1
    80004060:	a9c080e7          	jalr	-1380(ra) # 80004af8 <uartputc>
    80004064:	03298063          	beq	s3,s2,80004084 <consolewrite+0x74>
    80004068:	00048613          	mv	a2,s1
    8000406c:	00100693          	li	a3,1
    80004070:	000a0593          	mv	a1,s4
    80004074:	fbf40513          	addi	a0,s0,-65
    80004078:	00000097          	auipc	ra,0x0
    8000407c:	9e0080e7          	jalr	-1568(ra) # 80003a58 <either_copyin>
    80004080:	fd5518e3          	bne	a0,s5,80004050 <consolewrite+0x40>
    80004084:	04813083          	ld	ra,72(sp)
    80004088:	04013403          	ld	s0,64(sp)
    8000408c:	03813483          	ld	s1,56(sp)
    80004090:	02813983          	ld	s3,40(sp)
    80004094:	02013a03          	ld	s4,32(sp)
    80004098:	01813a83          	ld	s5,24(sp)
    8000409c:	00090513          	mv	a0,s2
    800040a0:	03013903          	ld	s2,48(sp)
    800040a4:	05010113          	addi	sp,sp,80
    800040a8:	00008067          	ret
    800040ac:	00000913          	li	s2,0
    800040b0:	fd5ff06f          	j	80004084 <consolewrite+0x74>

00000000800040b4 <consoleread>:
    800040b4:	f9010113          	addi	sp,sp,-112
    800040b8:	06813023          	sd	s0,96(sp)
    800040bc:	04913c23          	sd	s1,88(sp)
    800040c0:	05213823          	sd	s2,80(sp)
    800040c4:	05313423          	sd	s3,72(sp)
    800040c8:	05413023          	sd	s4,64(sp)
    800040cc:	03513c23          	sd	s5,56(sp)
    800040d0:	03613823          	sd	s6,48(sp)
    800040d4:	03713423          	sd	s7,40(sp)
    800040d8:	03813023          	sd	s8,32(sp)
    800040dc:	06113423          	sd	ra,104(sp)
    800040e0:	01913c23          	sd	s9,24(sp)
    800040e4:	07010413          	addi	s0,sp,112
    800040e8:	00060b93          	mv	s7,a2
    800040ec:	00050913          	mv	s2,a0
    800040f0:	00058c13          	mv	s8,a1
    800040f4:	00060b1b          	sext.w	s6,a2
    800040f8:	00004497          	auipc	s1,0x4
    800040fc:	5a048493          	addi	s1,s1,1440 # 80008698 <cons>
    80004100:	00400993          	li	s3,4
    80004104:	fff00a13          	li	s4,-1
    80004108:	00a00a93          	li	s5,10
    8000410c:	05705e63          	blez	s7,80004168 <consoleread+0xb4>
    80004110:	09c4a703          	lw	a4,156(s1)
    80004114:	0984a783          	lw	a5,152(s1)
    80004118:	0007071b          	sext.w	a4,a4
    8000411c:	08e78463          	beq	a5,a4,800041a4 <consoleread+0xf0>
    80004120:	07f7f713          	andi	a4,a5,127
    80004124:	00e48733          	add	a4,s1,a4
    80004128:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000412c:	0017869b          	addiw	a3,a5,1
    80004130:	08d4ac23          	sw	a3,152(s1)
    80004134:	00070c9b          	sext.w	s9,a4
    80004138:	0b370663          	beq	a4,s3,800041e4 <consoleread+0x130>
    8000413c:	00100693          	li	a3,1
    80004140:	f9f40613          	addi	a2,s0,-97
    80004144:	000c0593          	mv	a1,s8
    80004148:	00090513          	mv	a0,s2
    8000414c:	f8e40fa3          	sb	a4,-97(s0)
    80004150:	00000097          	auipc	ra,0x0
    80004154:	8bc080e7          	jalr	-1860(ra) # 80003a0c <either_copyout>
    80004158:	01450863          	beq	a0,s4,80004168 <consoleread+0xb4>
    8000415c:	001c0c13          	addi	s8,s8,1
    80004160:	fffb8b9b          	addiw	s7,s7,-1
    80004164:	fb5c94e3          	bne	s9,s5,8000410c <consoleread+0x58>
    80004168:	000b851b          	sext.w	a0,s7
    8000416c:	06813083          	ld	ra,104(sp)
    80004170:	06013403          	ld	s0,96(sp)
    80004174:	05813483          	ld	s1,88(sp)
    80004178:	05013903          	ld	s2,80(sp)
    8000417c:	04813983          	ld	s3,72(sp)
    80004180:	04013a03          	ld	s4,64(sp)
    80004184:	03813a83          	ld	s5,56(sp)
    80004188:	02813b83          	ld	s7,40(sp)
    8000418c:	02013c03          	ld	s8,32(sp)
    80004190:	01813c83          	ld	s9,24(sp)
    80004194:	40ab053b          	subw	a0,s6,a0
    80004198:	03013b03          	ld	s6,48(sp)
    8000419c:	07010113          	addi	sp,sp,112
    800041a0:	00008067          	ret
    800041a4:	00001097          	auipc	ra,0x1
    800041a8:	1d8080e7          	jalr	472(ra) # 8000537c <push_on>
    800041ac:	0984a703          	lw	a4,152(s1)
    800041b0:	09c4a783          	lw	a5,156(s1)
    800041b4:	0007879b          	sext.w	a5,a5
    800041b8:	fef70ce3          	beq	a4,a5,800041b0 <consoleread+0xfc>
    800041bc:	00001097          	auipc	ra,0x1
    800041c0:	234080e7          	jalr	564(ra) # 800053f0 <pop_on>
    800041c4:	0984a783          	lw	a5,152(s1)
    800041c8:	07f7f713          	andi	a4,a5,127
    800041cc:	00e48733          	add	a4,s1,a4
    800041d0:	01874703          	lbu	a4,24(a4)
    800041d4:	0017869b          	addiw	a3,a5,1
    800041d8:	08d4ac23          	sw	a3,152(s1)
    800041dc:	00070c9b          	sext.w	s9,a4
    800041e0:	f5371ee3          	bne	a4,s3,8000413c <consoleread+0x88>
    800041e4:	000b851b          	sext.w	a0,s7
    800041e8:	f96bf2e3          	bgeu	s7,s6,8000416c <consoleread+0xb8>
    800041ec:	08f4ac23          	sw	a5,152(s1)
    800041f0:	f7dff06f          	j	8000416c <consoleread+0xb8>

00000000800041f4 <consputc>:
    800041f4:	10000793          	li	a5,256
    800041f8:	00f50663          	beq	a0,a5,80004204 <consputc+0x10>
    800041fc:	00001317          	auipc	t1,0x1
    80004200:	9f430067          	jr	-1548(t1) # 80004bf0 <uartputc_sync>
    80004204:	ff010113          	addi	sp,sp,-16
    80004208:	00113423          	sd	ra,8(sp)
    8000420c:	00813023          	sd	s0,0(sp)
    80004210:	01010413          	addi	s0,sp,16
    80004214:	00800513          	li	a0,8
    80004218:	00001097          	auipc	ra,0x1
    8000421c:	9d8080e7          	jalr	-1576(ra) # 80004bf0 <uartputc_sync>
    80004220:	02000513          	li	a0,32
    80004224:	00001097          	auipc	ra,0x1
    80004228:	9cc080e7          	jalr	-1588(ra) # 80004bf0 <uartputc_sync>
    8000422c:	00013403          	ld	s0,0(sp)
    80004230:	00813083          	ld	ra,8(sp)
    80004234:	00800513          	li	a0,8
    80004238:	01010113          	addi	sp,sp,16
    8000423c:	00001317          	auipc	t1,0x1
    80004240:	9b430067          	jr	-1612(t1) # 80004bf0 <uartputc_sync>

0000000080004244 <consoleintr>:
    80004244:	fe010113          	addi	sp,sp,-32
    80004248:	00813823          	sd	s0,16(sp)
    8000424c:	00913423          	sd	s1,8(sp)
    80004250:	01213023          	sd	s2,0(sp)
    80004254:	00113c23          	sd	ra,24(sp)
    80004258:	02010413          	addi	s0,sp,32
    8000425c:	00004917          	auipc	s2,0x4
    80004260:	43c90913          	addi	s2,s2,1084 # 80008698 <cons>
    80004264:	00050493          	mv	s1,a0
    80004268:	00090513          	mv	a0,s2
    8000426c:	00001097          	auipc	ra,0x1
    80004270:	e40080e7          	jalr	-448(ra) # 800050ac <acquire>
    80004274:	02048c63          	beqz	s1,800042ac <consoleintr+0x68>
    80004278:	0a092783          	lw	a5,160(s2)
    8000427c:	09892703          	lw	a4,152(s2)
    80004280:	07f00693          	li	a3,127
    80004284:	40e7873b          	subw	a4,a5,a4
    80004288:	02e6e263          	bltu	a3,a4,800042ac <consoleintr+0x68>
    8000428c:	00d00713          	li	a4,13
    80004290:	04e48063          	beq	s1,a4,800042d0 <consoleintr+0x8c>
    80004294:	07f7f713          	andi	a4,a5,127
    80004298:	00e90733          	add	a4,s2,a4
    8000429c:	0017879b          	addiw	a5,a5,1
    800042a0:	0af92023          	sw	a5,160(s2)
    800042a4:	00970c23          	sb	s1,24(a4)
    800042a8:	08f92e23          	sw	a5,156(s2)
    800042ac:	01013403          	ld	s0,16(sp)
    800042b0:	01813083          	ld	ra,24(sp)
    800042b4:	00813483          	ld	s1,8(sp)
    800042b8:	00013903          	ld	s2,0(sp)
    800042bc:	00004517          	auipc	a0,0x4
    800042c0:	3dc50513          	addi	a0,a0,988 # 80008698 <cons>
    800042c4:	02010113          	addi	sp,sp,32
    800042c8:	00001317          	auipc	t1,0x1
    800042cc:	eb030067          	jr	-336(t1) # 80005178 <release>
    800042d0:	00a00493          	li	s1,10
    800042d4:	fc1ff06f          	j	80004294 <consoleintr+0x50>

00000000800042d8 <consoleinit>:
    800042d8:	fe010113          	addi	sp,sp,-32
    800042dc:	00113c23          	sd	ra,24(sp)
    800042e0:	00813823          	sd	s0,16(sp)
    800042e4:	00913423          	sd	s1,8(sp)
    800042e8:	02010413          	addi	s0,sp,32
    800042ec:	00004497          	auipc	s1,0x4
    800042f0:	3ac48493          	addi	s1,s1,940 # 80008698 <cons>
    800042f4:	00048513          	mv	a0,s1
    800042f8:	00002597          	auipc	a1,0x2
    800042fc:	fa058593          	addi	a1,a1,-96 # 80006298 <CONSOLE_STATUS+0x288>
    80004300:	00001097          	auipc	ra,0x1
    80004304:	d88080e7          	jalr	-632(ra) # 80005088 <initlock>
    80004308:	00000097          	auipc	ra,0x0
    8000430c:	7ac080e7          	jalr	1964(ra) # 80004ab4 <uartinit>
    80004310:	01813083          	ld	ra,24(sp)
    80004314:	01013403          	ld	s0,16(sp)
    80004318:	00000797          	auipc	a5,0x0
    8000431c:	d9c78793          	addi	a5,a5,-612 # 800040b4 <consoleread>
    80004320:	0af4bc23          	sd	a5,184(s1)
    80004324:	00000797          	auipc	a5,0x0
    80004328:	cec78793          	addi	a5,a5,-788 # 80004010 <consolewrite>
    8000432c:	0cf4b023          	sd	a5,192(s1)
    80004330:	00813483          	ld	s1,8(sp)
    80004334:	02010113          	addi	sp,sp,32
    80004338:	00008067          	ret

000000008000433c <console_read>:
    8000433c:	ff010113          	addi	sp,sp,-16
    80004340:	00813423          	sd	s0,8(sp)
    80004344:	01010413          	addi	s0,sp,16
    80004348:	00813403          	ld	s0,8(sp)
    8000434c:	00004317          	auipc	t1,0x4
    80004350:	40433303          	ld	t1,1028(t1) # 80008750 <devsw+0x10>
    80004354:	01010113          	addi	sp,sp,16
    80004358:	00030067          	jr	t1

000000008000435c <console_write>:
    8000435c:	ff010113          	addi	sp,sp,-16
    80004360:	00813423          	sd	s0,8(sp)
    80004364:	01010413          	addi	s0,sp,16
    80004368:	00813403          	ld	s0,8(sp)
    8000436c:	00004317          	auipc	t1,0x4
    80004370:	3ec33303          	ld	t1,1004(t1) # 80008758 <devsw+0x18>
    80004374:	01010113          	addi	sp,sp,16
    80004378:	00030067          	jr	t1

000000008000437c <panic>:
    8000437c:	fe010113          	addi	sp,sp,-32
    80004380:	00113c23          	sd	ra,24(sp)
    80004384:	00813823          	sd	s0,16(sp)
    80004388:	00913423          	sd	s1,8(sp)
    8000438c:	02010413          	addi	s0,sp,32
    80004390:	00050493          	mv	s1,a0
    80004394:	00002517          	auipc	a0,0x2
    80004398:	f0c50513          	addi	a0,a0,-244 # 800062a0 <CONSOLE_STATUS+0x290>
    8000439c:	00004797          	auipc	a5,0x4
    800043a0:	4407ae23          	sw	zero,1116(a5) # 800087f8 <pr+0x18>
    800043a4:	00000097          	auipc	ra,0x0
    800043a8:	034080e7          	jalr	52(ra) # 800043d8 <__printf>
    800043ac:	00048513          	mv	a0,s1
    800043b0:	00000097          	auipc	ra,0x0
    800043b4:	028080e7          	jalr	40(ra) # 800043d8 <__printf>
    800043b8:	00002517          	auipc	a0,0x2
    800043bc:	ec850513          	addi	a0,a0,-312 # 80006280 <CONSOLE_STATUS+0x270>
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	018080e7          	jalr	24(ra) # 800043d8 <__printf>
    800043c8:	00100793          	li	a5,1
    800043cc:	00003717          	auipc	a4,0x3
    800043d0:	12f72e23          	sw	a5,316(a4) # 80007508 <panicked>
    800043d4:	0000006f          	j	800043d4 <panic+0x58>

00000000800043d8 <__printf>:
    800043d8:	f3010113          	addi	sp,sp,-208
    800043dc:	08813023          	sd	s0,128(sp)
    800043e0:	07313423          	sd	s3,104(sp)
    800043e4:	09010413          	addi	s0,sp,144
    800043e8:	05813023          	sd	s8,64(sp)
    800043ec:	08113423          	sd	ra,136(sp)
    800043f0:	06913c23          	sd	s1,120(sp)
    800043f4:	07213823          	sd	s2,112(sp)
    800043f8:	07413023          	sd	s4,96(sp)
    800043fc:	05513c23          	sd	s5,88(sp)
    80004400:	05613823          	sd	s6,80(sp)
    80004404:	05713423          	sd	s7,72(sp)
    80004408:	03913c23          	sd	s9,56(sp)
    8000440c:	03a13823          	sd	s10,48(sp)
    80004410:	03b13423          	sd	s11,40(sp)
    80004414:	00004317          	auipc	t1,0x4
    80004418:	3cc30313          	addi	t1,t1,972 # 800087e0 <pr>
    8000441c:	01832c03          	lw	s8,24(t1)
    80004420:	00b43423          	sd	a1,8(s0)
    80004424:	00c43823          	sd	a2,16(s0)
    80004428:	00d43c23          	sd	a3,24(s0)
    8000442c:	02e43023          	sd	a4,32(s0)
    80004430:	02f43423          	sd	a5,40(s0)
    80004434:	03043823          	sd	a6,48(s0)
    80004438:	03143c23          	sd	a7,56(s0)
    8000443c:	00050993          	mv	s3,a0
    80004440:	4a0c1663          	bnez	s8,800048ec <__printf+0x514>
    80004444:	60098c63          	beqz	s3,80004a5c <__printf+0x684>
    80004448:	0009c503          	lbu	a0,0(s3)
    8000444c:	00840793          	addi	a5,s0,8
    80004450:	f6f43c23          	sd	a5,-136(s0)
    80004454:	00000493          	li	s1,0
    80004458:	22050063          	beqz	a0,80004678 <__printf+0x2a0>
    8000445c:	00002a37          	lui	s4,0x2
    80004460:	00018ab7          	lui	s5,0x18
    80004464:	000f4b37          	lui	s6,0xf4
    80004468:	00989bb7          	lui	s7,0x989
    8000446c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004470:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004474:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004478:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000447c:	00148c9b          	addiw	s9,s1,1
    80004480:	02500793          	li	a5,37
    80004484:	01998933          	add	s2,s3,s9
    80004488:	38f51263          	bne	a0,a5,8000480c <__printf+0x434>
    8000448c:	00094783          	lbu	a5,0(s2)
    80004490:	00078c9b          	sext.w	s9,a5
    80004494:	1e078263          	beqz	a5,80004678 <__printf+0x2a0>
    80004498:	0024849b          	addiw	s1,s1,2
    8000449c:	07000713          	li	a4,112
    800044a0:	00998933          	add	s2,s3,s1
    800044a4:	38e78a63          	beq	a5,a4,80004838 <__printf+0x460>
    800044a8:	20f76863          	bltu	a4,a5,800046b8 <__printf+0x2e0>
    800044ac:	42a78863          	beq	a5,a0,800048dc <__printf+0x504>
    800044b0:	06400713          	li	a4,100
    800044b4:	40e79663          	bne	a5,a4,800048c0 <__printf+0x4e8>
    800044b8:	f7843783          	ld	a5,-136(s0)
    800044bc:	0007a603          	lw	a2,0(a5)
    800044c0:	00878793          	addi	a5,a5,8
    800044c4:	f6f43c23          	sd	a5,-136(s0)
    800044c8:	42064a63          	bltz	a2,800048fc <__printf+0x524>
    800044cc:	00a00713          	li	a4,10
    800044d0:	02e677bb          	remuw	a5,a2,a4
    800044d4:	00002d97          	auipc	s11,0x2
    800044d8:	df4d8d93          	addi	s11,s11,-524 # 800062c8 <digits>
    800044dc:	00900593          	li	a1,9
    800044e0:	0006051b          	sext.w	a0,a2
    800044e4:	00000c93          	li	s9,0
    800044e8:	02079793          	slli	a5,a5,0x20
    800044ec:	0207d793          	srli	a5,a5,0x20
    800044f0:	00fd87b3          	add	a5,s11,a5
    800044f4:	0007c783          	lbu	a5,0(a5)
    800044f8:	02e656bb          	divuw	a3,a2,a4
    800044fc:	f8f40023          	sb	a5,-128(s0)
    80004500:	14c5d863          	bge	a1,a2,80004650 <__printf+0x278>
    80004504:	06300593          	li	a1,99
    80004508:	00100c93          	li	s9,1
    8000450c:	02e6f7bb          	remuw	a5,a3,a4
    80004510:	02079793          	slli	a5,a5,0x20
    80004514:	0207d793          	srli	a5,a5,0x20
    80004518:	00fd87b3          	add	a5,s11,a5
    8000451c:	0007c783          	lbu	a5,0(a5)
    80004520:	02e6d73b          	divuw	a4,a3,a4
    80004524:	f8f400a3          	sb	a5,-127(s0)
    80004528:	12a5f463          	bgeu	a1,a0,80004650 <__printf+0x278>
    8000452c:	00a00693          	li	a3,10
    80004530:	00900593          	li	a1,9
    80004534:	02d777bb          	remuw	a5,a4,a3
    80004538:	02079793          	slli	a5,a5,0x20
    8000453c:	0207d793          	srli	a5,a5,0x20
    80004540:	00fd87b3          	add	a5,s11,a5
    80004544:	0007c503          	lbu	a0,0(a5)
    80004548:	02d757bb          	divuw	a5,a4,a3
    8000454c:	f8a40123          	sb	a0,-126(s0)
    80004550:	48e5f263          	bgeu	a1,a4,800049d4 <__printf+0x5fc>
    80004554:	06300513          	li	a0,99
    80004558:	02d7f5bb          	remuw	a1,a5,a3
    8000455c:	02059593          	slli	a1,a1,0x20
    80004560:	0205d593          	srli	a1,a1,0x20
    80004564:	00bd85b3          	add	a1,s11,a1
    80004568:	0005c583          	lbu	a1,0(a1)
    8000456c:	02d7d7bb          	divuw	a5,a5,a3
    80004570:	f8b401a3          	sb	a1,-125(s0)
    80004574:	48e57263          	bgeu	a0,a4,800049f8 <__printf+0x620>
    80004578:	3e700513          	li	a0,999
    8000457c:	02d7f5bb          	remuw	a1,a5,a3
    80004580:	02059593          	slli	a1,a1,0x20
    80004584:	0205d593          	srli	a1,a1,0x20
    80004588:	00bd85b3          	add	a1,s11,a1
    8000458c:	0005c583          	lbu	a1,0(a1)
    80004590:	02d7d7bb          	divuw	a5,a5,a3
    80004594:	f8b40223          	sb	a1,-124(s0)
    80004598:	46e57663          	bgeu	a0,a4,80004a04 <__printf+0x62c>
    8000459c:	02d7f5bb          	remuw	a1,a5,a3
    800045a0:	02059593          	slli	a1,a1,0x20
    800045a4:	0205d593          	srli	a1,a1,0x20
    800045a8:	00bd85b3          	add	a1,s11,a1
    800045ac:	0005c583          	lbu	a1,0(a1)
    800045b0:	02d7d7bb          	divuw	a5,a5,a3
    800045b4:	f8b402a3          	sb	a1,-123(s0)
    800045b8:	46ea7863          	bgeu	s4,a4,80004a28 <__printf+0x650>
    800045bc:	02d7f5bb          	remuw	a1,a5,a3
    800045c0:	02059593          	slli	a1,a1,0x20
    800045c4:	0205d593          	srli	a1,a1,0x20
    800045c8:	00bd85b3          	add	a1,s11,a1
    800045cc:	0005c583          	lbu	a1,0(a1)
    800045d0:	02d7d7bb          	divuw	a5,a5,a3
    800045d4:	f8b40323          	sb	a1,-122(s0)
    800045d8:	3eeaf863          	bgeu	s5,a4,800049c8 <__printf+0x5f0>
    800045dc:	02d7f5bb          	remuw	a1,a5,a3
    800045e0:	02059593          	slli	a1,a1,0x20
    800045e4:	0205d593          	srli	a1,a1,0x20
    800045e8:	00bd85b3          	add	a1,s11,a1
    800045ec:	0005c583          	lbu	a1,0(a1)
    800045f0:	02d7d7bb          	divuw	a5,a5,a3
    800045f4:	f8b403a3          	sb	a1,-121(s0)
    800045f8:	42eb7e63          	bgeu	s6,a4,80004a34 <__printf+0x65c>
    800045fc:	02d7f5bb          	remuw	a1,a5,a3
    80004600:	02059593          	slli	a1,a1,0x20
    80004604:	0205d593          	srli	a1,a1,0x20
    80004608:	00bd85b3          	add	a1,s11,a1
    8000460c:	0005c583          	lbu	a1,0(a1)
    80004610:	02d7d7bb          	divuw	a5,a5,a3
    80004614:	f8b40423          	sb	a1,-120(s0)
    80004618:	42ebfc63          	bgeu	s7,a4,80004a50 <__printf+0x678>
    8000461c:	02079793          	slli	a5,a5,0x20
    80004620:	0207d793          	srli	a5,a5,0x20
    80004624:	00fd8db3          	add	s11,s11,a5
    80004628:	000dc703          	lbu	a4,0(s11)
    8000462c:	00a00793          	li	a5,10
    80004630:	00900c93          	li	s9,9
    80004634:	f8e404a3          	sb	a4,-119(s0)
    80004638:	00065c63          	bgez	a2,80004650 <__printf+0x278>
    8000463c:	f9040713          	addi	a4,s0,-112
    80004640:	00f70733          	add	a4,a4,a5
    80004644:	02d00693          	li	a3,45
    80004648:	fed70823          	sb	a3,-16(a4)
    8000464c:	00078c93          	mv	s9,a5
    80004650:	f8040793          	addi	a5,s0,-128
    80004654:	01978cb3          	add	s9,a5,s9
    80004658:	f7f40d13          	addi	s10,s0,-129
    8000465c:	000cc503          	lbu	a0,0(s9)
    80004660:	fffc8c93          	addi	s9,s9,-1
    80004664:	00000097          	auipc	ra,0x0
    80004668:	b90080e7          	jalr	-1136(ra) # 800041f4 <consputc>
    8000466c:	ffac98e3          	bne	s9,s10,8000465c <__printf+0x284>
    80004670:	00094503          	lbu	a0,0(s2)
    80004674:	e00514e3          	bnez	a0,8000447c <__printf+0xa4>
    80004678:	1a0c1663          	bnez	s8,80004824 <__printf+0x44c>
    8000467c:	08813083          	ld	ra,136(sp)
    80004680:	08013403          	ld	s0,128(sp)
    80004684:	07813483          	ld	s1,120(sp)
    80004688:	07013903          	ld	s2,112(sp)
    8000468c:	06813983          	ld	s3,104(sp)
    80004690:	06013a03          	ld	s4,96(sp)
    80004694:	05813a83          	ld	s5,88(sp)
    80004698:	05013b03          	ld	s6,80(sp)
    8000469c:	04813b83          	ld	s7,72(sp)
    800046a0:	04013c03          	ld	s8,64(sp)
    800046a4:	03813c83          	ld	s9,56(sp)
    800046a8:	03013d03          	ld	s10,48(sp)
    800046ac:	02813d83          	ld	s11,40(sp)
    800046b0:	0d010113          	addi	sp,sp,208
    800046b4:	00008067          	ret
    800046b8:	07300713          	li	a4,115
    800046bc:	1ce78a63          	beq	a5,a4,80004890 <__printf+0x4b8>
    800046c0:	07800713          	li	a4,120
    800046c4:	1ee79e63          	bne	a5,a4,800048c0 <__printf+0x4e8>
    800046c8:	f7843783          	ld	a5,-136(s0)
    800046cc:	0007a703          	lw	a4,0(a5)
    800046d0:	00878793          	addi	a5,a5,8
    800046d4:	f6f43c23          	sd	a5,-136(s0)
    800046d8:	28074263          	bltz	a4,8000495c <__printf+0x584>
    800046dc:	00002d97          	auipc	s11,0x2
    800046e0:	becd8d93          	addi	s11,s11,-1044 # 800062c8 <digits>
    800046e4:	00f77793          	andi	a5,a4,15
    800046e8:	00fd87b3          	add	a5,s11,a5
    800046ec:	0007c683          	lbu	a3,0(a5)
    800046f0:	00f00613          	li	a2,15
    800046f4:	0007079b          	sext.w	a5,a4
    800046f8:	f8d40023          	sb	a3,-128(s0)
    800046fc:	0047559b          	srliw	a1,a4,0x4
    80004700:	0047569b          	srliw	a3,a4,0x4
    80004704:	00000c93          	li	s9,0
    80004708:	0ee65063          	bge	a2,a4,800047e8 <__printf+0x410>
    8000470c:	00f6f693          	andi	a3,a3,15
    80004710:	00dd86b3          	add	a3,s11,a3
    80004714:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004718:	0087d79b          	srliw	a5,a5,0x8
    8000471c:	00100c93          	li	s9,1
    80004720:	f8d400a3          	sb	a3,-127(s0)
    80004724:	0cb67263          	bgeu	a2,a1,800047e8 <__printf+0x410>
    80004728:	00f7f693          	andi	a3,a5,15
    8000472c:	00dd86b3          	add	a3,s11,a3
    80004730:	0006c583          	lbu	a1,0(a3)
    80004734:	00f00613          	li	a2,15
    80004738:	0047d69b          	srliw	a3,a5,0x4
    8000473c:	f8b40123          	sb	a1,-126(s0)
    80004740:	0047d593          	srli	a1,a5,0x4
    80004744:	28f67e63          	bgeu	a2,a5,800049e0 <__printf+0x608>
    80004748:	00f6f693          	andi	a3,a3,15
    8000474c:	00dd86b3          	add	a3,s11,a3
    80004750:	0006c503          	lbu	a0,0(a3)
    80004754:	0087d813          	srli	a6,a5,0x8
    80004758:	0087d69b          	srliw	a3,a5,0x8
    8000475c:	f8a401a3          	sb	a0,-125(s0)
    80004760:	28b67663          	bgeu	a2,a1,800049ec <__printf+0x614>
    80004764:	00f6f693          	andi	a3,a3,15
    80004768:	00dd86b3          	add	a3,s11,a3
    8000476c:	0006c583          	lbu	a1,0(a3)
    80004770:	00c7d513          	srli	a0,a5,0xc
    80004774:	00c7d69b          	srliw	a3,a5,0xc
    80004778:	f8b40223          	sb	a1,-124(s0)
    8000477c:	29067a63          	bgeu	a2,a6,80004a10 <__printf+0x638>
    80004780:	00f6f693          	andi	a3,a3,15
    80004784:	00dd86b3          	add	a3,s11,a3
    80004788:	0006c583          	lbu	a1,0(a3)
    8000478c:	0107d813          	srli	a6,a5,0x10
    80004790:	0107d69b          	srliw	a3,a5,0x10
    80004794:	f8b402a3          	sb	a1,-123(s0)
    80004798:	28a67263          	bgeu	a2,a0,80004a1c <__printf+0x644>
    8000479c:	00f6f693          	andi	a3,a3,15
    800047a0:	00dd86b3          	add	a3,s11,a3
    800047a4:	0006c683          	lbu	a3,0(a3)
    800047a8:	0147d79b          	srliw	a5,a5,0x14
    800047ac:	f8d40323          	sb	a3,-122(s0)
    800047b0:	21067663          	bgeu	a2,a6,800049bc <__printf+0x5e4>
    800047b4:	02079793          	slli	a5,a5,0x20
    800047b8:	0207d793          	srli	a5,a5,0x20
    800047bc:	00fd8db3          	add	s11,s11,a5
    800047c0:	000dc683          	lbu	a3,0(s11)
    800047c4:	00800793          	li	a5,8
    800047c8:	00700c93          	li	s9,7
    800047cc:	f8d403a3          	sb	a3,-121(s0)
    800047d0:	00075c63          	bgez	a4,800047e8 <__printf+0x410>
    800047d4:	f9040713          	addi	a4,s0,-112
    800047d8:	00f70733          	add	a4,a4,a5
    800047dc:	02d00693          	li	a3,45
    800047e0:	fed70823          	sb	a3,-16(a4)
    800047e4:	00078c93          	mv	s9,a5
    800047e8:	f8040793          	addi	a5,s0,-128
    800047ec:	01978cb3          	add	s9,a5,s9
    800047f0:	f7f40d13          	addi	s10,s0,-129
    800047f4:	000cc503          	lbu	a0,0(s9)
    800047f8:	fffc8c93          	addi	s9,s9,-1
    800047fc:	00000097          	auipc	ra,0x0
    80004800:	9f8080e7          	jalr	-1544(ra) # 800041f4 <consputc>
    80004804:	ff9d18e3          	bne	s10,s9,800047f4 <__printf+0x41c>
    80004808:	0100006f          	j	80004818 <__printf+0x440>
    8000480c:	00000097          	auipc	ra,0x0
    80004810:	9e8080e7          	jalr	-1560(ra) # 800041f4 <consputc>
    80004814:	000c8493          	mv	s1,s9
    80004818:	00094503          	lbu	a0,0(s2)
    8000481c:	c60510e3          	bnez	a0,8000447c <__printf+0xa4>
    80004820:	e40c0ee3          	beqz	s8,8000467c <__printf+0x2a4>
    80004824:	00004517          	auipc	a0,0x4
    80004828:	fbc50513          	addi	a0,a0,-68 # 800087e0 <pr>
    8000482c:	00001097          	auipc	ra,0x1
    80004830:	94c080e7          	jalr	-1716(ra) # 80005178 <release>
    80004834:	e49ff06f          	j	8000467c <__printf+0x2a4>
    80004838:	f7843783          	ld	a5,-136(s0)
    8000483c:	03000513          	li	a0,48
    80004840:	01000d13          	li	s10,16
    80004844:	00878713          	addi	a4,a5,8
    80004848:	0007bc83          	ld	s9,0(a5)
    8000484c:	f6e43c23          	sd	a4,-136(s0)
    80004850:	00000097          	auipc	ra,0x0
    80004854:	9a4080e7          	jalr	-1628(ra) # 800041f4 <consputc>
    80004858:	07800513          	li	a0,120
    8000485c:	00000097          	auipc	ra,0x0
    80004860:	998080e7          	jalr	-1640(ra) # 800041f4 <consputc>
    80004864:	00002d97          	auipc	s11,0x2
    80004868:	a64d8d93          	addi	s11,s11,-1436 # 800062c8 <digits>
    8000486c:	03ccd793          	srli	a5,s9,0x3c
    80004870:	00fd87b3          	add	a5,s11,a5
    80004874:	0007c503          	lbu	a0,0(a5)
    80004878:	fffd0d1b          	addiw	s10,s10,-1
    8000487c:	004c9c93          	slli	s9,s9,0x4
    80004880:	00000097          	auipc	ra,0x0
    80004884:	974080e7          	jalr	-1676(ra) # 800041f4 <consputc>
    80004888:	fe0d12e3          	bnez	s10,8000486c <__printf+0x494>
    8000488c:	f8dff06f          	j	80004818 <__printf+0x440>
    80004890:	f7843783          	ld	a5,-136(s0)
    80004894:	0007bc83          	ld	s9,0(a5)
    80004898:	00878793          	addi	a5,a5,8
    8000489c:	f6f43c23          	sd	a5,-136(s0)
    800048a0:	000c9a63          	bnez	s9,800048b4 <__printf+0x4dc>
    800048a4:	1080006f          	j	800049ac <__printf+0x5d4>
    800048a8:	001c8c93          	addi	s9,s9,1
    800048ac:	00000097          	auipc	ra,0x0
    800048b0:	948080e7          	jalr	-1720(ra) # 800041f4 <consputc>
    800048b4:	000cc503          	lbu	a0,0(s9)
    800048b8:	fe0518e3          	bnez	a0,800048a8 <__printf+0x4d0>
    800048bc:	f5dff06f          	j	80004818 <__printf+0x440>
    800048c0:	02500513          	li	a0,37
    800048c4:	00000097          	auipc	ra,0x0
    800048c8:	930080e7          	jalr	-1744(ra) # 800041f4 <consputc>
    800048cc:	000c8513          	mv	a0,s9
    800048d0:	00000097          	auipc	ra,0x0
    800048d4:	924080e7          	jalr	-1756(ra) # 800041f4 <consputc>
    800048d8:	f41ff06f          	j	80004818 <__printf+0x440>
    800048dc:	02500513          	li	a0,37
    800048e0:	00000097          	auipc	ra,0x0
    800048e4:	914080e7          	jalr	-1772(ra) # 800041f4 <consputc>
    800048e8:	f31ff06f          	j	80004818 <__printf+0x440>
    800048ec:	00030513          	mv	a0,t1
    800048f0:	00000097          	auipc	ra,0x0
    800048f4:	7bc080e7          	jalr	1980(ra) # 800050ac <acquire>
    800048f8:	b4dff06f          	j	80004444 <__printf+0x6c>
    800048fc:	40c0053b          	negw	a0,a2
    80004900:	00a00713          	li	a4,10
    80004904:	02e576bb          	remuw	a3,a0,a4
    80004908:	00002d97          	auipc	s11,0x2
    8000490c:	9c0d8d93          	addi	s11,s11,-1600 # 800062c8 <digits>
    80004910:	ff700593          	li	a1,-9
    80004914:	02069693          	slli	a3,a3,0x20
    80004918:	0206d693          	srli	a3,a3,0x20
    8000491c:	00dd86b3          	add	a3,s11,a3
    80004920:	0006c683          	lbu	a3,0(a3)
    80004924:	02e557bb          	divuw	a5,a0,a4
    80004928:	f8d40023          	sb	a3,-128(s0)
    8000492c:	10b65e63          	bge	a2,a1,80004a48 <__printf+0x670>
    80004930:	06300593          	li	a1,99
    80004934:	02e7f6bb          	remuw	a3,a5,a4
    80004938:	02069693          	slli	a3,a3,0x20
    8000493c:	0206d693          	srli	a3,a3,0x20
    80004940:	00dd86b3          	add	a3,s11,a3
    80004944:	0006c683          	lbu	a3,0(a3)
    80004948:	02e7d73b          	divuw	a4,a5,a4
    8000494c:	00200793          	li	a5,2
    80004950:	f8d400a3          	sb	a3,-127(s0)
    80004954:	bca5ece3          	bltu	a1,a0,8000452c <__printf+0x154>
    80004958:	ce5ff06f          	j	8000463c <__printf+0x264>
    8000495c:	40e007bb          	negw	a5,a4
    80004960:	00002d97          	auipc	s11,0x2
    80004964:	968d8d93          	addi	s11,s11,-1688 # 800062c8 <digits>
    80004968:	00f7f693          	andi	a3,a5,15
    8000496c:	00dd86b3          	add	a3,s11,a3
    80004970:	0006c583          	lbu	a1,0(a3)
    80004974:	ff100613          	li	a2,-15
    80004978:	0047d69b          	srliw	a3,a5,0x4
    8000497c:	f8b40023          	sb	a1,-128(s0)
    80004980:	0047d59b          	srliw	a1,a5,0x4
    80004984:	0ac75e63          	bge	a4,a2,80004a40 <__printf+0x668>
    80004988:	00f6f693          	andi	a3,a3,15
    8000498c:	00dd86b3          	add	a3,s11,a3
    80004990:	0006c603          	lbu	a2,0(a3)
    80004994:	00f00693          	li	a3,15
    80004998:	0087d79b          	srliw	a5,a5,0x8
    8000499c:	f8c400a3          	sb	a2,-127(s0)
    800049a0:	d8b6e4e3          	bltu	a3,a1,80004728 <__printf+0x350>
    800049a4:	00200793          	li	a5,2
    800049a8:	e2dff06f          	j	800047d4 <__printf+0x3fc>
    800049ac:	00002c97          	auipc	s9,0x2
    800049b0:	8fcc8c93          	addi	s9,s9,-1796 # 800062a8 <CONSOLE_STATUS+0x298>
    800049b4:	02800513          	li	a0,40
    800049b8:	ef1ff06f          	j	800048a8 <__printf+0x4d0>
    800049bc:	00700793          	li	a5,7
    800049c0:	00600c93          	li	s9,6
    800049c4:	e0dff06f          	j	800047d0 <__printf+0x3f8>
    800049c8:	00700793          	li	a5,7
    800049cc:	00600c93          	li	s9,6
    800049d0:	c69ff06f          	j	80004638 <__printf+0x260>
    800049d4:	00300793          	li	a5,3
    800049d8:	00200c93          	li	s9,2
    800049dc:	c5dff06f          	j	80004638 <__printf+0x260>
    800049e0:	00300793          	li	a5,3
    800049e4:	00200c93          	li	s9,2
    800049e8:	de9ff06f          	j	800047d0 <__printf+0x3f8>
    800049ec:	00400793          	li	a5,4
    800049f0:	00300c93          	li	s9,3
    800049f4:	dddff06f          	j	800047d0 <__printf+0x3f8>
    800049f8:	00400793          	li	a5,4
    800049fc:	00300c93          	li	s9,3
    80004a00:	c39ff06f          	j	80004638 <__printf+0x260>
    80004a04:	00500793          	li	a5,5
    80004a08:	00400c93          	li	s9,4
    80004a0c:	c2dff06f          	j	80004638 <__printf+0x260>
    80004a10:	00500793          	li	a5,5
    80004a14:	00400c93          	li	s9,4
    80004a18:	db9ff06f          	j	800047d0 <__printf+0x3f8>
    80004a1c:	00600793          	li	a5,6
    80004a20:	00500c93          	li	s9,5
    80004a24:	dadff06f          	j	800047d0 <__printf+0x3f8>
    80004a28:	00600793          	li	a5,6
    80004a2c:	00500c93          	li	s9,5
    80004a30:	c09ff06f          	j	80004638 <__printf+0x260>
    80004a34:	00800793          	li	a5,8
    80004a38:	00700c93          	li	s9,7
    80004a3c:	bfdff06f          	j	80004638 <__printf+0x260>
    80004a40:	00100793          	li	a5,1
    80004a44:	d91ff06f          	j	800047d4 <__printf+0x3fc>
    80004a48:	00100793          	li	a5,1
    80004a4c:	bf1ff06f          	j	8000463c <__printf+0x264>
    80004a50:	00900793          	li	a5,9
    80004a54:	00800c93          	li	s9,8
    80004a58:	be1ff06f          	j	80004638 <__printf+0x260>
    80004a5c:	00002517          	auipc	a0,0x2
    80004a60:	85450513          	addi	a0,a0,-1964 # 800062b0 <CONSOLE_STATUS+0x2a0>
    80004a64:	00000097          	auipc	ra,0x0
    80004a68:	918080e7          	jalr	-1768(ra) # 8000437c <panic>

0000000080004a6c <printfinit>:
    80004a6c:	fe010113          	addi	sp,sp,-32
    80004a70:	00813823          	sd	s0,16(sp)
    80004a74:	00913423          	sd	s1,8(sp)
    80004a78:	00113c23          	sd	ra,24(sp)
    80004a7c:	02010413          	addi	s0,sp,32
    80004a80:	00004497          	auipc	s1,0x4
    80004a84:	d6048493          	addi	s1,s1,-672 # 800087e0 <pr>
    80004a88:	00048513          	mv	a0,s1
    80004a8c:	00002597          	auipc	a1,0x2
    80004a90:	83458593          	addi	a1,a1,-1996 # 800062c0 <CONSOLE_STATUS+0x2b0>
    80004a94:	00000097          	auipc	ra,0x0
    80004a98:	5f4080e7          	jalr	1524(ra) # 80005088 <initlock>
    80004a9c:	01813083          	ld	ra,24(sp)
    80004aa0:	01013403          	ld	s0,16(sp)
    80004aa4:	0004ac23          	sw	zero,24(s1)
    80004aa8:	00813483          	ld	s1,8(sp)
    80004aac:	02010113          	addi	sp,sp,32
    80004ab0:	00008067          	ret

0000000080004ab4 <uartinit>:
    80004ab4:	ff010113          	addi	sp,sp,-16
    80004ab8:	00813423          	sd	s0,8(sp)
    80004abc:	01010413          	addi	s0,sp,16
    80004ac0:	100007b7          	lui	a5,0x10000
    80004ac4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004ac8:	f8000713          	li	a4,-128
    80004acc:	00e781a3          	sb	a4,3(a5)
    80004ad0:	00300713          	li	a4,3
    80004ad4:	00e78023          	sb	a4,0(a5)
    80004ad8:	000780a3          	sb	zero,1(a5)
    80004adc:	00e781a3          	sb	a4,3(a5)
    80004ae0:	00700693          	li	a3,7
    80004ae4:	00d78123          	sb	a3,2(a5)
    80004ae8:	00e780a3          	sb	a4,1(a5)
    80004aec:	00813403          	ld	s0,8(sp)
    80004af0:	01010113          	addi	sp,sp,16
    80004af4:	00008067          	ret

0000000080004af8 <uartputc>:
    80004af8:	00003797          	auipc	a5,0x3
    80004afc:	a107a783          	lw	a5,-1520(a5) # 80007508 <panicked>
    80004b00:	00078463          	beqz	a5,80004b08 <uartputc+0x10>
    80004b04:	0000006f          	j	80004b04 <uartputc+0xc>
    80004b08:	fd010113          	addi	sp,sp,-48
    80004b0c:	02813023          	sd	s0,32(sp)
    80004b10:	00913c23          	sd	s1,24(sp)
    80004b14:	01213823          	sd	s2,16(sp)
    80004b18:	01313423          	sd	s3,8(sp)
    80004b1c:	02113423          	sd	ra,40(sp)
    80004b20:	03010413          	addi	s0,sp,48
    80004b24:	00003917          	auipc	s2,0x3
    80004b28:	9ec90913          	addi	s2,s2,-1556 # 80007510 <uart_tx_r>
    80004b2c:	00093783          	ld	a5,0(s2)
    80004b30:	00003497          	auipc	s1,0x3
    80004b34:	9e848493          	addi	s1,s1,-1560 # 80007518 <uart_tx_w>
    80004b38:	0004b703          	ld	a4,0(s1)
    80004b3c:	02078693          	addi	a3,a5,32
    80004b40:	00050993          	mv	s3,a0
    80004b44:	02e69c63          	bne	a3,a4,80004b7c <uartputc+0x84>
    80004b48:	00001097          	auipc	ra,0x1
    80004b4c:	834080e7          	jalr	-1996(ra) # 8000537c <push_on>
    80004b50:	00093783          	ld	a5,0(s2)
    80004b54:	0004b703          	ld	a4,0(s1)
    80004b58:	02078793          	addi	a5,a5,32
    80004b5c:	00e79463          	bne	a5,a4,80004b64 <uartputc+0x6c>
    80004b60:	0000006f          	j	80004b60 <uartputc+0x68>
    80004b64:	00001097          	auipc	ra,0x1
    80004b68:	88c080e7          	jalr	-1908(ra) # 800053f0 <pop_on>
    80004b6c:	00093783          	ld	a5,0(s2)
    80004b70:	0004b703          	ld	a4,0(s1)
    80004b74:	02078693          	addi	a3,a5,32
    80004b78:	fce688e3          	beq	a3,a4,80004b48 <uartputc+0x50>
    80004b7c:	01f77693          	andi	a3,a4,31
    80004b80:	00004597          	auipc	a1,0x4
    80004b84:	c8058593          	addi	a1,a1,-896 # 80008800 <uart_tx_buf>
    80004b88:	00d586b3          	add	a3,a1,a3
    80004b8c:	00170713          	addi	a4,a4,1
    80004b90:	01368023          	sb	s3,0(a3)
    80004b94:	00e4b023          	sd	a4,0(s1)
    80004b98:	10000637          	lui	a2,0x10000
    80004b9c:	02f71063          	bne	a4,a5,80004bbc <uartputc+0xc4>
    80004ba0:	0340006f          	j	80004bd4 <uartputc+0xdc>
    80004ba4:	00074703          	lbu	a4,0(a4)
    80004ba8:	00f93023          	sd	a5,0(s2)
    80004bac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004bb0:	00093783          	ld	a5,0(s2)
    80004bb4:	0004b703          	ld	a4,0(s1)
    80004bb8:	00f70e63          	beq	a4,a5,80004bd4 <uartputc+0xdc>
    80004bbc:	00564683          	lbu	a3,5(a2)
    80004bc0:	01f7f713          	andi	a4,a5,31
    80004bc4:	00e58733          	add	a4,a1,a4
    80004bc8:	0206f693          	andi	a3,a3,32
    80004bcc:	00178793          	addi	a5,a5,1
    80004bd0:	fc069ae3          	bnez	a3,80004ba4 <uartputc+0xac>
    80004bd4:	02813083          	ld	ra,40(sp)
    80004bd8:	02013403          	ld	s0,32(sp)
    80004bdc:	01813483          	ld	s1,24(sp)
    80004be0:	01013903          	ld	s2,16(sp)
    80004be4:	00813983          	ld	s3,8(sp)
    80004be8:	03010113          	addi	sp,sp,48
    80004bec:	00008067          	ret

0000000080004bf0 <uartputc_sync>:
    80004bf0:	ff010113          	addi	sp,sp,-16
    80004bf4:	00813423          	sd	s0,8(sp)
    80004bf8:	01010413          	addi	s0,sp,16
    80004bfc:	00003717          	auipc	a4,0x3
    80004c00:	90c72703          	lw	a4,-1780(a4) # 80007508 <panicked>
    80004c04:	02071663          	bnez	a4,80004c30 <uartputc_sync+0x40>
    80004c08:	00050793          	mv	a5,a0
    80004c0c:	100006b7          	lui	a3,0x10000
    80004c10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004c14:	02077713          	andi	a4,a4,32
    80004c18:	fe070ce3          	beqz	a4,80004c10 <uartputc_sync+0x20>
    80004c1c:	0ff7f793          	andi	a5,a5,255
    80004c20:	00f68023          	sb	a5,0(a3)
    80004c24:	00813403          	ld	s0,8(sp)
    80004c28:	01010113          	addi	sp,sp,16
    80004c2c:	00008067          	ret
    80004c30:	0000006f          	j	80004c30 <uartputc_sync+0x40>

0000000080004c34 <uartstart>:
    80004c34:	ff010113          	addi	sp,sp,-16
    80004c38:	00813423          	sd	s0,8(sp)
    80004c3c:	01010413          	addi	s0,sp,16
    80004c40:	00003617          	auipc	a2,0x3
    80004c44:	8d060613          	addi	a2,a2,-1840 # 80007510 <uart_tx_r>
    80004c48:	00003517          	auipc	a0,0x3
    80004c4c:	8d050513          	addi	a0,a0,-1840 # 80007518 <uart_tx_w>
    80004c50:	00063783          	ld	a5,0(a2)
    80004c54:	00053703          	ld	a4,0(a0)
    80004c58:	04f70263          	beq	a4,a5,80004c9c <uartstart+0x68>
    80004c5c:	100005b7          	lui	a1,0x10000
    80004c60:	00004817          	auipc	a6,0x4
    80004c64:	ba080813          	addi	a6,a6,-1120 # 80008800 <uart_tx_buf>
    80004c68:	01c0006f          	j	80004c84 <uartstart+0x50>
    80004c6c:	0006c703          	lbu	a4,0(a3)
    80004c70:	00f63023          	sd	a5,0(a2)
    80004c74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004c78:	00063783          	ld	a5,0(a2)
    80004c7c:	00053703          	ld	a4,0(a0)
    80004c80:	00f70e63          	beq	a4,a5,80004c9c <uartstart+0x68>
    80004c84:	01f7f713          	andi	a4,a5,31
    80004c88:	00e806b3          	add	a3,a6,a4
    80004c8c:	0055c703          	lbu	a4,5(a1)
    80004c90:	00178793          	addi	a5,a5,1
    80004c94:	02077713          	andi	a4,a4,32
    80004c98:	fc071ae3          	bnez	a4,80004c6c <uartstart+0x38>
    80004c9c:	00813403          	ld	s0,8(sp)
    80004ca0:	01010113          	addi	sp,sp,16
    80004ca4:	00008067          	ret

0000000080004ca8 <uartgetc>:
    80004ca8:	ff010113          	addi	sp,sp,-16
    80004cac:	00813423          	sd	s0,8(sp)
    80004cb0:	01010413          	addi	s0,sp,16
    80004cb4:	10000737          	lui	a4,0x10000
    80004cb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80004cbc:	0017f793          	andi	a5,a5,1
    80004cc0:	00078c63          	beqz	a5,80004cd8 <uartgetc+0x30>
    80004cc4:	00074503          	lbu	a0,0(a4)
    80004cc8:	0ff57513          	andi	a0,a0,255
    80004ccc:	00813403          	ld	s0,8(sp)
    80004cd0:	01010113          	addi	sp,sp,16
    80004cd4:	00008067          	ret
    80004cd8:	fff00513          	li	a0,-1
    80004cdc:	ff1ff06f          	j	80004ccc <uartgetc+0x24>

0000000080004ce0 <uartintr>:
    80004ce0:	100007b7          	lui	a5,0x10000
    80004ce4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004ce8:	0017f793          	andi	a5,a5,1
    80004cec:	0a078463          	beqz	a5,80004d94 <uartintr+0xb4>
    80004cf0:	fe010113          	addi	sp,sp,-32
    80004cf4:	00813823          	sd	s0,16(sp)
    80004cf8:	00913423          	sd	s1,8(sp)
    80004cfc:	00113c23          	sd	ra,24(sp)
    80004d00:	02010413          	addi	s0,sp,32
    80004d04:	100004b7          	lui	s1,0x10000
    80004d08:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80004d0c:	0ff57513          	andi	a0,a0,255
    80004d10:	fffff097          	auipc	ra,0xfffff
    80004d14:	534080e7          	jalr	1332(ra) # 80004244 <consoleintr>
    80004d18:	0054c783          	lbu	a5,5(s1)
    80004d1c:	0017f793          	andi	a5,a5,1
    80004d20:	fe0794e3          	bnez	a5,80004d08 <uartintr+0x28>
    80004d24:	00002617          	auipc	a2,0x2
    80004d28:	7ec60613          	addi	a2,a2,2028 # 80007510 <uart_tx_r>
    80004d2c:	00002517          	auipc	a0,0x2
    80004d30:	7ec50513          	addi	a0,a0,2028 # 80007518 <uart_tx_w>
    80004d34:	00063783          	ld	a5,0(a2)
    80004d38:	00053703          	ld	a4,0(a0)
    80004d3c:	04f70263          	beq	a4,a5,80004d80 <uartintr+0xa0>
    80004d40:	100005b7          	lui	a1,0x10000
    80004d44:	00004817          	auipc	a6,0x4
    80004d48:	abc80813          	addi	a6,a6,-1348 # 80008800 <uart_tx_buf>
    80004d4c:	01c0006f          	j	80004d68 <uartintr+0x88>
    80004d50:	0006c703          	lbu	a4,0(a3)
    80004d54:	00f63023          	sd	a5,0(a2)
    80004d58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004d5c:	00063783          	ld	a5,0(a2)
    80004d60:	00053703          	ld	a4,0(a0)
    80004d64:	00f70e63          	beq	a4,a5,80004d80 <uartintr+0xa0>
    80004d68:	01f7f713          	andi	a4,a5,31
    80004d6c:	00e806b3          	add	a3,a6,a4
    80004d70:	0055c703          	lbu	a4,5(a1)
    80004d74:	00178793          	addi	a5,a5,1
    80004d78:	02077713          	andi	a4,a4,32
    80004d7c:	fc071ae3          	bnez	a4,80004d50 <uartintr+0x70>
    80004d80:	01813083          	ld	ra,24(sp)
    80004d84:	01013403          	ld	s0,16(sp)
    80004d88:	00813483          	ld	s1,8(sp)
    80004d8c:	02010113          	addi	sp,sp,32
    80004d90:	00008067          	ret
    80004d94:	00002617          	auipc	a2,0x2
    80004d98:	77c60613          	addi	a2,a2,1916 # 80007510 <uart_tx_r>
    80004d9c:	00002517          	auipc	a0,0x2
    80004da0:	77c50513          	addi	a0,a0,1916 # 80007518 <uart_tx_w>
    80004da4:	00063783          	ld	a5,0(a2)
    80004da8:	00053703          	ld	a4,0(a0)
    80004dac:	04f70263          	beq	a4,a5,80004df0 <uartintr+0x110>
    80004db0:	100005b7          	lui	a1,0x10000
    80004db4:	00004817          	auipc	a6,0x4
    80004db8:	a4c80813          	addi	a6,a6,-1460 # 80008800 <uart_tx_buf>
    80004dbc:	01c0006f          	j	80004dd8 <uartintr+0xf8>
    80004dc0:	0006c703          	lbu	a4,0(a3)
    80004dc4:	00f63023          	sd	a5,0(a2)
    80004dc8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004dcc:	00063783          	ld	a5,0(a2)
    80004dd0:	00053703          	ld	a4,0(a0)
    80004dd4:	02f70063          	beq	a4,a5,80004df4 <uartintr+0x114>
    80004dd8:	01f7f713          	andi	a4,a5,31
    80004ddc:	00e806b3          	add	a3,a6,a4
    80004de0:	0055c703          	lbu	a4,5(a1)
    80004de4:	00178793          	addi	a5,a5,1
    80004de8:	02077713          	andi	a4,a4,32
    80004dec:	fc071ae3          	bnez	a4,80004dc0 <uartintr+0xe0>
    80004df0:	00008067          	ret
    80004df4:	00008067          	ret

0000000080004df8 <kinit>:
    80004df8:	fc010113          	addi	sp,sp,-64
    80004dfc:	02913423          	sd	s1,40(sp)
    80004e00:	fffff7b7          	lui	a5,0xfffff
    80004e04:	00005497          	auipc	s1,0x5
    80004e08:	a1b48493          	addi	s1,s1,-1509 # 8000981f <end+0xfff>
    80004e0c:	02813823          	sd	s0,48(sp)
    80004e10:	01313c23          	sd	s3,24(sp)
    80004e14:	00f4f4b3          	and	s1,s1,a5
    80004e18:	02113c23          	sd	ra,56(sp)
    80004e1c:	03213023          	sd	s2,32(sp)
    80004e20:	01413823          	sd	s4,16(sp)
    80004e24:	01513423          	sd	s5,8(sp)
    80004e28:	04010413          	addi	s0,sp,64
    80004e2c:	000017b7          	lui	a5,0x1
    80004e30:	01100993          	li	s3,17
    80004e34:	00f487b3          	add	a5,s1,a5
    80004e38:	01b99993          	slli	s3,s3,0x1b
    80004e3c:	06f9e063          	bltu	s3,a5,80004e9c <kinit+0xa4>
    80004e40:	00004a97          	auipc	s5,0x4
    80004e44:	9e0a8a93          	addi	s5,s5,-1568 # 80008820 <end>
    80004e48:	0754ec63          	bltu	s1,s5,80004ec0 <kinit+0xc8>
    80004e4c:	0734fa63          	bgeu	s1,s3,80004ec0 <kinit+0xc8>
    80004e50:	00088a37          	lui	s4,0x88
    80004e54:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004e58:	00002917          	auipc	s2,0x2
    80004e5c:	6c890913          	addi	s2,s2,1736 # 80007520 <kmem>
    80004e60:	00ca1a13          	slli	s4,s4,0xc
    80004e64:	0140006f          	j	80004e78 <kinit+0x80>
    80004e68:	000017b7          	lui	a5,0x1
    80004e6c:	00f484b3          	add	s1,s1,a5
    80004e70:	0554e863          	bltu	s1,s5,80004ec0 <kinit+0xc8>
    80004e74:	0534f663          	bgeu	s1,s3,80004ec0 <kinit+0xc8>
    80004e78:	00001637          	lui	a2,0x1
    80004e7c:	00100593          	li	a1,1
    80004e80:	00048513          	mv	a0,s1
    80004e84:	00000097          	auipc	ra,0x0
    80004e88:	5e4080e7          	jalr	1508(ra) # 80005468 <__memset>
    80004e8c:	00093783          	ld	a5,0(s2)
    80004e90:	00f4b023          	sd	a5,0(s1)
    80004e94:	00993023          	sd	s1,0(s2)
    80004e98:	fd4498e3          	bne	s1,s4,80004e68 <kinit+0x70>
    80004e9c:	03813083          	ld	ra,56(sp)
    80004ea0:	03013403          	ld	s0,48(sp)
    80004ea4:	02813483          	ld	s1,40(sp)
    80004ea8:	02013903          	ld	s2,32(sp)
    80004eac:	01813983          	ld	s3,24(sp)
    80004eb0:	01013a03          	ld	s4,16(sp)
    80004eb4:	00813a83          	ld	s5,8(sp)
    80004eb8:	04010113          	addi	sp,sp,64
    80004ebc:	00008067          	ret
    80004ec0:	00001517          	auipc	a0,0x1
    80004ec4:	42050513          	addi	a0,a0,1056 # 800062e0 <digits+0x18>
    80004ec8:	fffff097          	auipc	ra,0xfffff
    80004ecc:	4b4080e7          	jalr	1204(ra) # 8000437c <panic>

0000000080004ed0 <freerange>:
    80004ed0:	fc010113          	addi	sp,sp,-64
    80004ed4:	000017b7          	lui	a5,0x1
    80004ed8:	02913423          	sd	s1,40(sp)
    80004edc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004ee0:	009504b3          	add	s1,a0,s1
    80004ee4:	fffff537          	lui	a0,0xfffff
    80004ee8:	02813823          	sd	s0,48(sp)
    80004eec:	02113c23          	sd	ra,56(sp)
    80004ef0:	03213023          	sd	s2,32(sp)
    80004ef4:	01313c23          	sd	s3,24(sp)
    80004ef8:	01413823          	sd	s4,16(sp)
    80004efc:	01513423          	sd	s5,8(sp)
    80004f00:	01613023          	sd	s6,0(sp)
    80004f04:	04010413          	addi	s0,sp,64
    80004f08:	00a4f4b3          	and	s1,s1,a0
    80004f0c:	00f487b3          	add	a5,s1,a5
    80004f10:	06f5e463          	bltu	a1,a5,80004f78 <freerange+0xa8>
    80004f14:	00004a97          	auipc	s5,0x4
    80004f18:	90ca8a93          	addi	s5,s5,-1780 # 80008820 <end>
    80004f1c:	0954e263          	bltu	s1,s5,80004fa0 <freerange+0xd0>
    80004f20:	01100993          	li	s3,17
    80004f24:	01b99993          	slli	s3,s3,0x1b
    80004f28:	0734fc63          	bgeu	s1,s3,80004fa0 <freerange+0xd0>
    80004f2c:	00058a13          	mv	s4,a1
    80004f30:	00002917          	auipc	s2,0x2
    80004f34:	5f090913          	addi	s2,s2,1520 # 80007520 <kmem>
    80004f38:	00002b37          	lui	s6,0x2
    80004f3c:	0140006f          	j	80004f50 <freerange+0x80>
    80004f40:	000017b7          	lui	a5,0x1
    80004f44:	00f484b3          	add	s1,s1,a5
    80004f48:	0554ec63          	bltu	s1,s5,80004fa0 <freerange+0xd0>
    80004f4c:	0534fa63          	bgeu	s1,s3,80004fa0 <freerange+0xd0>
    80004f50:	00001637          	lui	a2,0x1
    80004f54:	00100593          	li	a1,1
    80004f58:	00048513          	mv	a0,s1
    80004f5c:	00000097          	auipc	ra,0x0
    80004f60:	50c080e7          	jalr	1292(ra) # 80005468 <__memset>
    80004f64:	00093703          	ld	a4,0(s2)
    80004f68:	016487b3          	add	a5,s1,s6
    80004f6c:	00e4b023          	sd	a4,0(s1)
    80004f70:	00993023          	sd	s1,0(s2)
    80004f74:	fcfa76e3          	bgeu	s4,a5,80004f40 <freerange+0x70>
    80004f78:	03813083          	ld	ra,56(sp)
    80004f7c:	03013403          	ld	s0,48(sp)
    80004f80:	02813483          	ld	s1,40(sp)
    80004f84:	02013903          	ld	s2,32(sp)
    80004f88:	01813983          	ld	s3,24(sp)
    80004f8c:	01013a03          	ld	s4,16(sp)
    80004f90:	00813a83          	ld	s5,8(sp)
    80004f94:	00013b03          	ld	s6,0(sp)
    80004f98:	04010113          	addi	sp,sp,64
    80004f9c:	00008067          	ret
    80004fa0:	00001517          	auipc	a0,0x1
    80004fa4:	34050513          	addi	a0,a0,832 # 800062e0 <digits+0x18>
    80004fa8:	fffff097          	auipc	ra,0xfffff
    80004fac:	3d4080e7          	jalr	980(ra) # 8000437c <panic>

0000000080004fb0 <kfree>:
    80004fb0:	fe010113          	addi	sp,sp,-32
    80004fb4:	00813823          	sd	s0,16(sp)
    80004fb8:	00113c23          	sd	ra,24(sp)
    80004fbc:	00913423          	sd	s1,8(sp)
    80004fc0:	02010413          	addi	s0,sp,32
    80004fc4:	03451793          	slli	a5,a0,0x34
    80004fc8:	04079c63          	bnez	a5,80005020 <kfree+0x70>
    80004fcc:	00004797          	auipc	a5,0x4
    80004fd0:	85478793          	addi	a5,a5,-1964 # 80008820 <end>
    80004fd4:	00050493          	mv	s1,a0
    80004fd8:	04f56463          	bltu	a0,a5,80005020 <kfree+0x70>
    80004fdc:	01100793          	li	a5,17
    80004fe0:	01b79793          	slli	a5,a5,0x1b
    80004fe4:	02f57e63          	bgeu	a0,a5,80005020 <kfree+0x70>
    80004fe8:	00001637          	lui	a2,0x1
    80004fec:	00100593          	li	a1,1
    80004ff0:	00000097          	auipc	ra,0x0
    80004ff4:	478080e7          	jalr	1144(ra) # 80005468 <__memset>
    80004ff8:	00002797          	auipc	a5,0x2
    80004ffc:	52878793          	addi	a5,a5,1320 # 80007520 <kmem>
    80005000:	0007b703          	ld	a4,0(a5)
    80005004:	01813083          	ld	ra,24(sp)
    80005008:	01013403          	ld	s0,16(sp)
    8000500c:	00e4b023          	sd	a4,0(s1)
    80005010:	0097b023          	sd	s1,0(a5)
    80005014:	00813483          	ld	s1,8(sp)
    80005018:	02010113          	addi	sp,sp,32
    8000501c:	00008067          	ret
    80005020:	00001517          	auipc	a0,0x1
    80005024:	2c050513          	addi	a0,a0,704 # 800062e0 <digits+0x18>
    80005028:	fffff097          	auipc	ra,0xfffff
    8000502c:	354080e7          	jalr	852(ra) # 8000437c <panic>

0000000080005030 <kalloc>:
    80005030:	fe010113          	addi	sp,sp,-32
    80005034:	00813823          	sd	s0,16(sp)
    80005038:	00913423          	sd	s1,8(sp)
    8000503c:	00113c23          	sd	ra,24(sp)
    80005040:	02010413          	addi	s0,sp,32
    80005044:	00002797          	auipc	a5,0x2
    80005048:	4dc78793          	addi	a5,a5,1244 # 80007520 <kmem>
    8000504c:	0007b483          	ld	s1,0(a5)
    80005050:	02048063          	beqz	s1,80005070 <kalloc+0x40>
    80005054:	0004b703          	ld	a4,0(s1)
    80005058:	00001637          	lui	a2,0x1
    8000505c:	00500593          	li	a1,5
    80005060:	00048513          	mv	a0,s1
    80005064:	00e7b023          	sd	a4,0(a5)
    80005068:	00000097          	auipc	ra,0x0
    8000506c:	400080e7          	jalr	1024(ra) # 80005468 <__memset>
    80005070:	01813083          	ld	ra,24(sp)
    80005074:	01013403          	ld	s0,16(sp)
    80005078:	00048513          	mv	a0,s1
    8000507c:	00813483          	ld	s1,8(sp)
    80005080:	02010113          	addi	sp,sp,32
    80005084:	00008067          	ret

0000000080005088 <initlock>:
    80005088:	ff010113          	addi	sp,sp,-16
    8000508c:	00813423          	sd	s0,8(sp)
    80005090:	01010413          	addi	s0,sp,16
    80005094:	00813403          	ld	s0,8(sp)
    80005098:	00b53423          	sd	a1,8(a0)
    8000509c:	00052023          	sw	zero,0(a0)
    800050a0:	00053823          	sd	zero,16(a0)
    800050a4:	01010113          	addi	sp,sp,16
    800050a8:	00008067          	ret

00000000800050ac <acquire>:
    800050ac:	fe010113          	addi	sp,sp,-32
    800050b0:	00813823          	sd	s0,16(sp)
    800050b4:	00913423          	sd	s1,8(sp)
    800050b8:	00113c23          	sd	ra,24(sp)
    800050bc:	01213023          	sd	s2,0(sp)
    800050c0:	02010413          	addi	s0,sp,32
    800050c4:	00050493          	mv	s1,a0
    800050c8:	10002973          	csrr	s2,sstatus
    800050cc:	100027f3          	csrr	a5,sstatus
    800050d0:	ffd7f793          	andi	a5,a5,-3
    800050d4:	10079073          	csrw	sstatus,a5
    800050d8:	fffff097          	auipc	ra,0xfffff
    800050dc:	8e8080e7          	jalr	-1816(ra) # 800039c0 <mycpu>
    800050e0:	07852783          	lw	a5,120(a0)
    800050e4:	06078e63          	beqz	a5,80005160 <acquire+0xb4>
    800050e8:	fffff097          	auipc	ra,0xfffff
    800050ec:	8d8080e7          	jalr	-1832(ra) # 800039c0 <mycpu>
    800050f0:	07852783          	lw	a5,120(a0)
    800050f4:	0004a703          	lw	a4,0(s1)
    800050f8:	0017879b          	addiw	a5,a5,1
    800050fc:	06f52c23          	sw	a5,120(a0)
    80005100:	04071063          	bnez	a4,80005140 <acquire+0x94>
    80005104:	00100713          	li	a4,1
    80005108:	00070793          	mv	a5,a4
    8000510c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005110:	0007879b          	sext.w	a5,a5
    80005114:	fe079ae3          	bnez	a5,80005108 <acquire+0x5c>
    80005118:	0ff0000f          	fence
    8000511c:	fffff097          	auipc	ra,0xfffff
    80005120:	8a4080e7          	jalr	-1884(ra) # 800039c0 <mycpu>
    80005124:	01813083          	ld	ra,24(sp)
    80005128:	01013403          	ld	s0,16(sp)
    8000512c:	00a4b823          	sd	a0,16(s1)
    80005130:	00013903          	ld	s2,0(sp)
    80005134:	00813483          	ld	s1,8(sp)
    80005138:	02010113          	addi	sp,sp,32
    8000513c:	00008067          	ret
    80005140:	0104b903          	ld	s2,16(s1)
    80005144:	fffff097          	auipc	ra,0xfffff
    80005148:	87c080e7          	jalr	-1924(ra) # 800039c0 <mycpu>
    8000514c:	faa91ce3          	bne	s2,a0,80005104 <acquire+0x58>
    80005150:	00001517          	auipc	a0,0x1
    80005154:	19850513          	addi	a0,a0,408 # 800062e8 <digits+0x20>
    80005158:	fffff097          	auipc	ra,0xfffff
    8000515c:	224080e7          	jalr	548(ra) # 8000437c <panic>
    80005160:	00195913          	srli	s2,s2,0x1
    80005164:	fffff097          	auipc	ra,0xfffff
    80005168:	85c080e7          	jalr	-1956(ra) # 800039c0 <mycpu>
    8000516c:	00197913          	andi	s2,s2,1
    80005170:	07252e23          	sw	s2,124(a0)
    80005174:	f75ff06f          	j	800050e8 <acquire+0x3c>

0000000080005178 <release>:
    80005178:	fe010113          	addi	sp,sp,-32
    8000517c:	00813823          	sd	s0,16(sp)
    80005180:	00113c23          	sd	ra,24(sp)
    80005184:	00913423          	sd	s1,8(sp)
    80005188:	01213023          	sd	s2,0(sp)
    8000518c:	02010413          	addi	s0,sp,32
    80005190:	00052783          	lw	a5,0(a0)
    80005194:	00079a63          	bnez	a5,800051a8 <release+0x30>
    80005198:	00001517          	auipc	a0,0x1
    8000519c:	15850513          	addi	a0,a0,344 # 800062f0 <digits+0x28>
    800051a0:	fffff097          	auipc	ra,0xfffff
    800051a4:	1dc080e7          	jalr	476(ra) # 8000437c <panic>
    800051a8:	01053903          	ld	s2,16(a0)
    800051ac:	00050493          	mv	s1,a0
    800051b0:	fffff097          	auipc	ra,0xfffff
    800051b4:	810080e7          	jalr	-2032(ra) # 800039c0 <mycpu>
    800051b8:	fea910e3          	bne	s2,a0,80005198 <release+0x20>
    800051bc:	0004b823          	sd	zero,16(s1)
    800051c0:	0ff0000f          	fence
    800051c4:	0f50000f          	fence	iorw,ow
    800051c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800051cc:	ffffe097          	auipc	ra,0xffffe
    800051d0:	7f4080e7          	jalr	2036(ra) # 800039c0 <mycpu>
    800051d4:	100027f3          	csrr	a5,sstatus
    800051d8:	0027f793          	andi	a5,a5,2
    800051dc:	04079a63          	bnez	a5,80005230 <release+0xb8>
    800051e0:	07852783          	lw	a5,120(a0)
    800051e4:	02f05e63          	blez	a5,80005220 <release+0xa8>
    800051e8:	fff7871b          	addiw	a4,a5,-1
    800051ec:	06e52c23          	sw	a4,120(a0)
    800051f0:	00071c63          	bnez	a4,80005208 <release+0x90>
    800051f4:	07c52783          	lw	a5,124(a0)
    800051f8:	00078863          	beqz	a5,80005208 <release+0x90>
    800051fc:	100027f3          	csrr	a5,sstatus
    80005200:	0027e793          	ori	a5,a5,2
    80005204:	10079073          	csrw	sstatus,a5
    80005208:	01813083          	ld	ra,24(sp)
    8000520c:	01013403          	ld	s0,16(sp)
    80005210:	00813483          	ld	s1,8(sp)
    80005214:	00013903          	ld	s2,0(sp)
    80005218:	02010113          	addi	sp,sp,32
    8000521c:	00008067          	ret
    80005220:	00001517          	auipc	a0,0x1
    80005224:	0f050513          	addi	a0,a0,240 # 80006310 <digits+0x48>
    80005228:	fffff097          	auipc	ra,0xfffff
    8000522c:	154080e7          	jalr	340(ra) # 8000437c <panic>
    80005230:	00001517          	auipc	a0,0x1
    80005234:	0c850513          	addi	a0,a0,200 # 800062f8 <digits+0x30>
    80005238:	fffff097          	auipc	ra,0xfffff
    8000523c:	144080e7          	jalr	324(ra) # 8000437c <panic>

0000000080005240 <holding>:
    80005240:	00052783          	lw	a5,0(a0)
    80005244:	00079663          	bnez	a5,80005250 <holding+0x10>
    80005248:	00000513          	li	a0,0
    8000524c:	00008067          	ret
    80005250:	fe010113          	addi	sp,sp,-32
    80005254:	00813823          	sd	s0,16(sp)
    80005258:	00913423          	sd	s1,8(sp)
    8000525c:	00113c23          	sd	ra,24(sp)
    80005260:	02010413          	addi	s0,sp,32
    80005264:	01053483          	ld	s1,16(a0)
    80005268:	ffffe097          	auipc	ra,0xffffe
    8000526c:	758080e7          	jalr	1880(ra) # 800039c0 <mycpu>
    80005270:	01813083          	ld	ra,24(sp)
    80005274:	01013403          	ld	s0,16(sp)
    80005278:	40a48533          	sub	a0,s1,a0
    8000527c:	00153513          	seqz	a0,a0
    80005280:	00813483          	ld	s1,8(sp)
    80005284:	02010113          	addi	sp,sp,32
    80005288:	00008067          	ret

000000008000528c <push_off>:
    8000528c:	fe010113          	addi	sp,sp,-32
    80005290:	00813823          	sd	s0,16(sp)
    80005294:	00113c23          	sd	ra,24(sp)
    80005298:	00913423          	sd	s1,8(sp)
    8000529c:	02010413          	addi	s0,sp,32
    800052a0:	100024f3          	csrr	s1,sstatus
    800052a4:	100027f3          	csrr	a5,sstatus
    800052a8:	ffd7f793          	andi	a5,a5,-3
    800052ac:	10079073          	csrw	sstatus,a5
    800052b0:	ffffe097          	auipc	ra,0xffffe
    800052b4:	710080e7          	jalr	1808(ra) # 800039c0 <mycpu>
    800052b8:	07852783          	lw	a5,120(a0)
    800052bc:	02078663          	beqz	a5,800052e8 <push_off+0x5c>
    800052c0:	ffffe097          	auipc	ra,0xffffe
    800052c4:	700080e7          	jalr	1792(ra) # 800039c0 <mycpu>
    800052c8:	07852783          	lw	a5,120(a0)
    800052cc:	01813083          	ld	ra,24(sp)
    800052d0:	01013403          	ld	s0,16(sp)
    800052d4:	0017879b          	addiw	a5,a5,1
    800052d8:	06f52c23          	sw	a5,120(a0)
    800052dc:	00813483          	ld	s1,8(sp)
    800052e0:	02010113          	addi	sp,sp,32
    800052e4:	00008067          	ret
    800052e8:	0014d493          	srli	s1,s1,0x1
    800052ec:	ffffe097          	auipc	ra,0xffffe
    800052f0:	6d4080e7          	jalr	1748(ra) # 800039c0 <mycpu>
    800052f4:	0014f493          	andi	s1,s1,1
    800052f8:	06952e23          	sw	s1,124(a0)
    800052fc:	fc5ff06f          	j	800052c0 <push_off+0x34>

0000000080005300 <pop_off>:
    80005300:	ff010113          	addi	sp,sp,-16
    80005304:	00813023          	sd	s0,0(sp)
    80005308:	00113423          	sd	ra,8(sp)
    8000530c:	01010413          	addi	s0,sp,16
    80005310:	ffffe097          	auipc	ra,0xffffe
    80005314:	6b0080e7          	jalr	1712(ra) # 800039c0 <mycpu>
    80005318:	100027f3          	csrr	a5,sstatus
    8000531c:	0027f793          	andi	a5,a5,2
    80005320:	04079663          	bnez	a5,8000536c <pop_off+0x6c>
    80005324:	07852783          	lw	a5,120(a0)
    80005328:	02f05a63          	blez	a5,8000535c <pop_off+0x5c>
    8000532c:	fff7871b          	addiw	a4,a5,-1
    80005330:	06e52c23          	sw	a4,120(a0)
    80005334:	00071c63          	bnez	a4,8000534c <pop_off+0x4c>
    80005338:	07c52783          	lw	a5,124(a0)
    8000533c:	00078863          	beqz	a5,8000534c <pop_off+0x4c>
    80005340:	100027f3          	csrr	a5,sstatus
    80005344:	0027e793          	ori	a5,a5,2
    80005348:	10079073          	csrw	sstatus,a5
    8000534c:	00813083          	ld	ra,8(sp)
    80005350:	00013403          	ld	s0,0(sp)
    80005354:	01010113          	addi	sp,sp,16
    80005358:	00008067          	ret
    8000535c:	00001517          	auipc	a0,0x1
    80005360:	fb450513          	addi	a0,a0,-76 # 80006310 <digits+0x48>
    80005364:	fffff097          	auipc	ra,0xfffff
    80005368:	018080e7          	jalr	24(ra) # 8000437c <panic>
    8000536c:	00001517          	auipc	a0,0x1
    80005370:	f8c50513          	addi	a0,a0,-116 # 800062f8 <digits+0x30>
    80005374:	fffff097          	auipc	ra,0xfffff
    80005378:	008080e7          	jalr	8(ra) # 8000437c <panic>

000000008000537c <push_on>:
    8000537c:	fe010113          	addi	sp,sp,-32
    80005380:	00813823          	sd	s0,16(sp)
    80005384:	00113c23          	sd	ra,24(sp)
    80005388:	00913423          	sd	s1,8(sp)
    8000538c:	02010413          	addi	s0,sp,32
    80005390:	100024f3          	csrr	s1,sstatus
    80005394:	100027f3          	csrr	a5,sstatus
    80005398:	0027e793          	ori	a5,a5,2
    8000539c:	10079073          	csrw	sstatus,a5
    800053a0:	ffffe097          	auipc	ra,0xffffe
    800053a4:	620080e7          	jalr	1568(ra) # 800039c0 <mycpu>
    800053a8:	07852783          	lw	a5,120(a0)
    800053ac:	02078663          	beqz	a5,800053d8 <push_on+0x5c>
    800053b0:	ffffe097          	auipc	ra,0xffffe
    800053b4:	610080e7          	jalr	1552(ra) # 800039c0 <mycpu>
    800053b8:	07852783          	lw	a5,120(a0)
    800053bc:	01813083          	ld	ra,24(sp)
    800053c0:	01013403          	ld	s0,16(sp)
    800053c4:	0017879b          	addiw	a5,a5,1
    800053c8:	06f52c23          	sw	a5,120(a0)
    800053cc:	00813483          	ld	s1,8(sp)
    800053d0:	02010113          	addi	sp,sp,32
    800053d4:	00008067          	ret
    800053d8:	0014d493          	srli	s1,s1,0x1
    800053dc:	ffffe097          	auipc	ra,0xffffe
    800053e0:	5e4080e7          	jalr	1508(ra) # 800039c0 <mycpu>
    800053e4:	0014f493          	andi	s1,s1,1
    800053e8:	06952e23          	sw	s1,124(a0)
    800053ec:	fc5ff06f          	j	800053b0 <push_on+0x34>

00000000800053f0 <pop_on>:
    800053f0:	ff010113          	addi	sp,sp,-16
    800053f4:	00813023          	sd	s0,0(sp)
    800053f8:	00113423          	sd	ra,8(sp)
    800053fc:	01010413          	addi	s0,sp,16
    80005400:	ffffe097          	auipc	ra,0xffffe
    80005404:	5c0080e7          	jalr	1472(ra) # 800039c0 <mycpu>
    80005408:	100027f3          	csrr	a5,sstatus
    8000540c:	0027f793          	andi	a5,a5,2
    80005410:	04078463          	beqz	a5,80005458 <pop_on+0x68>
    80005414:	07852783          	lw	a5,120(a0)
    80005418:	02f05863          	blez	a5,80005448 <pop_on+0x58>
    8000541c:	fff7879b          	addiw	a5,a5,-1
    80005420:	06f52c23          	sw	a5,120(a0)
    80005424:	07853783          	ld	a5,120(a0)
    80005428:	00079863          	bnez	a5,80005438 <pop_on+0x48>
    8000542c:	100027f3          	csrr	a5,sstatus
    80005430:	ffd7f793          	andi	a5,a5,-3
    80005434:	10079073          	csrw	sstatus,a5
    80005438:	00813083          	ld	ra,8(sp)
    8000543c:	00013403          	ld	s0,0(sp)
    80005440:	01010113          	addi	sp,sp,16
    80005444:	00008067          	ret
    80005448:	00001517          	auipc	a0,0x1
    8000544c:	ef050513          	addi	a0,a0,-272 # 80006338 <digits+0x70>
    80005450:	fffff097          	auipc	ra,0xfffff
    80005454:	f2c080e7          	jalr	-212(ra) # 8000437c <panic>
    80005458:	00001517          	auipc	a0,0x1
    8000545c:	ec050513          	addi	a0,a0,-320 # 80006318 <digits+0x50>
    80005460:	fffff097          	auipc	ra,0xfffff
    80005464:	f1c080e7          	jalr	-228(ra) # 8000437c <panic>

0000000080005468 <__memset>:
    80005468:	ff010113          	addi	sp,sp,-16
    8000546c:	00813423          	sd	s0,8(sp)
    80005470:	01010413          	addi	s0,sp,16
    80005474:	1a060e63          	beqz	a2,80005630 <__memset+0x1c8>
    80005478:	40a007b3          	neg	a5,a0
    8000547c:	0077f793          	andi	a5,a5,7
    80005480:	00778693          	addi	a3,a5,7
    80005484:	00b00813          	li	a6,11
    80005488:	0ff5f593          	andi	a1,a1,255
    8000548c:	fff6071b          	addiw	a4,a2,-1
    80005490:	1b06e663          	bltu	a3,a6,8000563c <__memset+0x1d4>
    80005494:	1cd76463          	bltu	a4,a3,8000565c <__memset+0x1f4>
    80005498:	1a078e63          	beqz	a5,80005654 <__memset+0x1ec>
    8000549c:	00b50023          	sb	a1,0(a0)
    800054a0:	00100713          	li	a4,1
    800054a4:	1ae78463          	beq	a5,a4,8000564c <__memset+0x1e4>
    800054a8:	00b500a3          	sb	a1,1(a0)
    800054ac:	00200713          	li	a4,2
    800054b0:	1ae78a63          	beq	a5,a4,80005664 <__memset+0x1fc>
    800054b4:	00b50123          	sb	a1,2(a0)
    800054b8:	00300713          	li	a4,3
    800054bc:	18e78463          	beq	a5,a4,80005644 <__memset+0x1dc>
    800054c0:	00b501a3          	sb	a1,3(a0)
    800054c4:	00400713          	li	a4,4
    800054c8:	1ae78263          	beq	a5,a4,8000566c <__memset+0x204>
    800054cc:	00b50223          	sb	a1,4(a0)
    800054d0:	00500713          	li	a4,5
    800054d4:	1ae78063          	beq	a5,a4,80005674 <__memset+0x20c>
    800054d8:	00b502a3          	sb	a1,5(a0)
    800054dc:	00700713          	li	a4,7
    800054e0:	18e79e63          	bne	a5,a4,8000567c <__memset+0x214>
    800054e4:	00b50323          	sb	a1,6(a0)
    800054e8:	00700e93          	li	t4,7
    800054ec:	00859713          	slli	a4,a1,0x8
    800054f0:	00e5e733          	or	a4,a1,a4
    800054f4:	01059e13          	slli	t3,a1,0x10
    800054f8:	01c76e33          	or	t3,a4,t3
    800054fc:	01859313          	slli	t1,a1,0x18
    80005500:	006e6333          	or	t1,t3,t1
    80005504:	02059893          	slli	a7,a1,0x20
    80005508:	40f60e3b          	subw	t3,a2,a5
    8000550c:	011368b3          	or	a7,t1,a7
    80005510:	02859813          	slli	a6,a1,0x28
    80005514:	0108e833          	or	a6,a7,a6
    80005518:	03059693          	slli	a3,a1,0x30
    8000551c:	003e589b          	srliw	a7,t3,0x3
    80005520:	00d866b3          	or	a3,a6,a3
    80005524:	03859713          	slli	a4,a1,0x38
    80005528:	00389813          	slli	a6,a7,0x3
    8000552c:	00f507b3          	add	a5,a0,a5
    80005530:	00e6e733          	or	a4,a3,a4
    80005534:	000e089b          	sext.w	a7,t3
    80005538:	00f806b3          	add	a3,a6,a5
    8000553c:	00e7b023          	sd	a4,0(a5)
    80005540:	00878793          	addi	a5,a5,8
    80005544:	fed79ce3          	bne	a5,a3,8000553c <__memset+0xd4>
    80005548:	ff8e7793          	andi	a5,t3,-8
    8000554c:	0007871b          	sext.w	a4,a5
    80005550:	01d787bb          	addw	a5,a5,t4
    80005554:	0ce88e63          	beq	a7,a4,80005630 <__memset+0x1c8>
    80005558:	00f50733          	add	a4,a0,a5
    8000555c:	00b70023          	sb	a1,0(a4)
    80005560:	0017871b          	addiw	a4,a5,1
    80005564:	0cc77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005568:	00e50733          	add	a4,a0,a4
    8000556c:	00b70023          	sb	a1,0(a4)
    80005570:	0027871b          	addiw	a4,a5,2
    80005574:	0ac77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005578:	00e50733          	add	a4,a0,a4
    8000557c:	00b70023          	sb	a1,0(a4)
    80005580:	0037871b          	addiw	a4,a5,3
    80005584:	0ac77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005588:	00e50733          	add	a4,a0,a4
    8000558c:	00b70023          	sb	a1,0(a4)
    80005590:	0047871b          	addiw	a4,a5,4
    80005594:	08c77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005598:	00e50733          	add	a4,a0,a4
    8000559c:	00b70023          	sb	a1,0(a4)
    800055a0:	0057871b          	addiw	a4,a5,5
    800055a4:	08c77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055a8:	00e50733          	add	a4,a0,a4
    800055ac:	00b70023          	sb	a1,0(a4)
    800055b0:	0067871b          	addiw	a4,a5,6
    800055b4:	06c77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055b8:	00e50733          	add	a4,a0,a4
    800055bc:	00b70023          	sb	a1,0(a4)
    800055c0:	0077871b          	addiw	a4,a5,7
    800055c4:	06c77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055c8:	00e50733          	add	a4,a0,a4
    800055cc:	00b70023          	sb	a1,0(a4)
    800055d0:	0087871b          	addiw	a4,a5,8
    800055d4:	04c77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055d8:	00e50733          	add	a4,a0,a4
    800055dc:	00b70023          	sb	a1,0(a4)
    800055e0:	0097871b          	addiw	a4,a5,9
    800055e4:	04c77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055e8:	00e50733          	add	a4,a0,a4
    800055ec:	00b70023          	sb	a1,0(a4)
    800055f0:	00a7871b          	addiw	a4,a5,10
    800055f4:	02c77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    800055f8:	00e50733          	add	a4,a0,a4
    800055fc:	00b70023          	sb	a1,0(a4)
    80005600:	00b7871b          	addiw	a4,a5,11
    80005604:	02c77663          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005608:	00e50733          	add	a4,a0,a4
    8000560c:	00b70023          	sb	a1,0(a4)
    80005610:	00c7871b          	addiw	a4,a5,12
    80005614:	00c77e63          	bgeu	a4,a2,80005630 <__memset+0x1c8>
    80005618:	00e50733          	add	a4,a0,a4
    8000561c:	00b70023          	sb	a1,0(a4)
    80005620:	00d7879b          	addiw	a5,a5,13
    80005624:	00c7f663          	bgeu	a5,a2,80005630 <__memset+0x1c8>
    80005628:	00f507b3          	add	a5,a0,a5
    8000562c:	00b78023          	sb	a1,0(a5)
    80005630:	00813403          	ld	s0,8(sp)
    80005634:	01010113          	addi	sp,sp,16
    80005638:	00008067          	ret
    8000563c:	00b00693          	li	a3,11
    80005640:	e55ff06f          	j	80005494 <__memset+0x2c>
    80005644:	00300e93          	li	t4,3
    80005648:	ea5ff06f          	j	800054ec <__memset+0x84>
    8000564c:	00100e93          	li	t4,1
    80005650:	e9dff06f          	j	800054ec <__memset+0x84>
    80005654:	00000e93          	li	t4,0
    80005658:	e95ff06f          	j	800054ec <__memset+0x84>
    8000565c:	00000793          	li	a5,0
    80005660:	ef9ff06f          	j	80005558 <__memset+0xf0>
    80005664:	00200e93          	li	t4,2
    80005668:	e85ff06f          	j	800054ec <__memset+0x84>
    8000566c:	00400e93          	li	t4,4
    80005670:	e7dff06f          	j	800054ec <__memset+0x84>
    80005674:	00500e93          	li	t4,5
    80005678:	e75ff06f          	j	800054ec <__memset+0x84>
    8000567c:	00600e93          	li	t4,6
    80005680:	e6dff06f          	j	800054ec <__memset+0x84>

0000000080005684 <__memmove>:
    80005684:	ff010113          	addi	sp,sp,-16
    80005688:	00813423          	sd	s0,8(sp)
    8000568c:	01010413          	addi	s0,sp,16
    80005690:	0e060863          	beqz	a2,80005780 <__memmove+0xfc>
    80005694:	fff6069b          	addiw	a3,a2,-1
    80005698:	0006881b          	sext.w	a6,a3
    8000569c:	0ea5e863          	bltu	a1,a0,8000578c <__memmove+0x108>
    800056a0:	00758713          	addi	a4,a1,7
    800056a4:	00a5e7b3          	or	a5,a1,a0
    800056a8:	40a70733          	sub	a4,a4,a0
    800056ac:	0077f793          	andi	a5,a5,7
    800056b0:	00f73713          	sltiu	a4,a4,15
    800056b4:	00174713          	xori	a4,a4,1
    800056b8:	0017b793          	seqz	a5,a5
    800056bc:	00e7f7b3          	and	a5,a5,a4
    800056c0:	10078863          	beqz	a5,800057d0 <__memmove+0x14c>
    800056c4:	00900793          	li	a5,9
    800056c8:	1107f463          	bgeu	a5,a6,800057d0 <__memmove+0x14c>
    800056cc:	0036581b          	srliw	a6,a2,0x3
    800056d0:	fff8081b          	addiw	a6,a6,-1
    800056d4:	02081813          	slli	a6,a6,0x20
    800056d8:	01d85893          	srli	a7,a6,0x1d
    800056dc:	00858813          	addi	a6,a1,8
    800056e0:	00058793          	mv	a5,a1
    800056e4:	00050713          	mv	a4,a0
    800056e8:	01088833          	add	a6,a7,a6
    800056ec:	0007b883          	ld	a7,0(a5)
    800056f0:	00878793          	addi	a5,a5,8
    800056f4:	00870713          	addi	a4,a4,8
    800056f8:	ff173c23          	sd	a7,-8(a4)
    800056fc:	ff0798e3          	bne	a5,a6,800056ec <__memmove+0x68>
    80005700:	ff867713          	andi	a4,a2,-8
    80005704:	02071793          	slli	a5,a4,0x20
    80005708:	0207d793          	srli	a5,a5,0x20
    8000570c:	00f585b3          	add	a1,a1,a5
    80005710:	40e686bb          	subw	a3,a3,a4
    80005714:	00f507b3          	add	a5,a0,a5
    80005718:	06e60463          	beq	a2,a4,80005780 <__memmove+0xfc>
    8000571c:	0005c703          	lbu	a4,0(a1)
    80005720:	00e78023          	sb	a4,0(a5)
    80005724:	04068e63          	beqz	a3,80005780 <__memmove+0xfc>
    80005728:	0015c603          	lbu	a2,1(a1)
    8000572c:	00100713          	li	a4,1
    80005730:	00c780a3          	sb	a2,1(a5)
    80005734:	04e68663          	beq	a3,a4,80005780 <__memmove+0xfc>
    80005738:	0025c603          	lbu	a2,2(a1)
    8000573c:	00200713          	li	a4,2
    80005740:	00c78123          	sb	a2,2(a5)
    80005744:	02e68e63          	beq	a3,a4,80005780 <__memmove+0xfc>
    80005748:	0035c603          	lbu	a2,3(a1)
    8000574c:	00300713          	li	a4,3
    80005750:	00c781a3          	sb	a2,3(a5)
    80005754:	02e68663          	beq	a3,a4,80005780 <__memmove+0xfc>
    80005758:	0045c603          	lbu	a2,4(a1)
    8000575c:	00400713          	li	a4,4
    80005760:	00c78223          	sb	a2,4(a5)
    80005764:	00e68e63          	beq	a3,a4,80005780 <__memmove+0xfc>
    80005768:	0055c603          	lbu	a2,5(a1)
    8000576c:	00500713          	li	a4,5
    80005770:	00c782a3          	sb	a2,5(a5)
    80005774:	00e68663          	beq	a3,a4,80005780 <__memmove+0xfc>
    80005778:	0065c703          	lbu	a4,6(a1)
    8000577c:	00e78323          	sb	a4,6(a5)
    80005780:	00813403          	ld	s0,8(sp)
    80005784:	01010113          	addi	sp,sp,16
    80005788:	00008067          	ret
    8000578c:	02061713          	slli	a4,a2,0x20
    80005790:	02075713          	srli	a4,a4,0x20
    80005794:	00e587b3          	add	a5,a1,a4
    80005798:	f0f574e3          	bgeu	a0,a5,800056a0 <__memmove+0x1c>
    8000579c:	02069613          	slli	a2,a3,0x20
    800057a0:	02065613          	srli	a2,a2,0x20
    800057a4:	fff64613          	not	a2,a2
    800057a8:	00e50733          	add	a4,a0,a4
    800057ac:	00c78633          	add	a2,a5,a2
    800057b0:	fff7c683          	lbu	a3,-1(a5)
    800057b4:	fff78793          	addi	a5,a5,-1
    800057b8:	fff70713          	addi	a4,a4,-1
    800057bc:	00d70023          	sb	a3,0(a4)
    800057c0:	fec798e3          	bne	a5,a2,800057b0 <__memmove+0x12c>
    800057c4:	00813403          	ld	s0,8(sp)
    800057c8:	01010113          	addi	sp,sp,16
    800057cc:	00008067          	ret
    800057d0:	02069713          	slli	a4,a3,0x20
    800057d4:	02075713          	srli	a4,a4,0x20
    800057d8:	00170713          	addi	a4,a4,1
    800057dc:	00e50733          	add	a4,a0,a4
    800057e0:	00050793          	mv	a5,a0
    800057e4:	0005c683          	lbu	a3,0(a1)
    800057e8:	00178793          	addi	a5,a5,1
    800057ec:	00158593          	addi	a1,a1,1
    800057f0:	fed78fa3          	sb	a3,-1(a5)
    800057f4:	fee798e3          	bne	a5,a4,800057e4 <__memmove+0x160>
    800057f8:	f89ff06f          	j	80005780 <__memmove+0xfc>

00000000800057fc <__putc>:
    800057fc:	fe010113          	addi	sp,sp,-32
    80005800:	00813823          	sd	s0,16(sp)
    80005804:	00113c23          	sd	ra,24(sp)
    80005808:	02010413          	addi	s0,sp,32
    8000580c:	00050793          	mv	a5,a0
    80005810:	fef40593          	addi	a1,s0,-17
    80005814:	00100613          	li	a2,1
    80005818:	00000513          	li	a0,0
    8000581c:	fef407a3          	sb	a5,-17(s0)
    80005820:	fffff097          	auipc	ra,0xfffff
    80005824:	b3c080e7          	jalr	-1220(ra) # 8000435c <console_write>
    80005828:	01813083          	ld	ra,24(sp)
    8000582c:	01013403          	ld	s0,16(sp)
    80005830:	02010113          	addi	sp,sp,32
    80005834:	00008067          	ret

0000000080005838 <__getc>:
    80005838:	fe010113          	addi	sp,sp,-32
    8000583c:	00813823          	sd	s0,16(sp)
    80005840:	00113c23          	sd	ra,24(sp)
    80005844:	02010413          	addi	s0,sp,32
    80005848:	fe840593          	addi	a1,s0,-24
    8000584c:	00100613          	li	a2,1
    80005850:	00000513          	li	a0,0
    80005854:	fffff097          	auipc	ra,0xfffff
    80005858:	ae8080e7          	jalr	-1304(ra) # 8000433c <console_read>
    8000585c:	fe844503          	lbu	a0,-24(s0)
    80005860:	01813083          	ld	ra,24(sp)
    80005864:	01013403          	ld	s0,16(sp)
    80005868:	02010113          	addi	sp,sp,32
    8000586c:	00008067          	ret

0000000080005870 <console_handler>:
    80005870:	fe010113          	addi	sp,sp,-32
    80005874:	00813823          	sd	s0,16(sp)
    80005878:	00113c23          	sd	ra,24(sp)
    8000587c:	00913423          	sd	s1,8(sp)
    80005880:	02010413          	addi	s0,sp,32
    80005884:	14202773          	csrr	a4,scause
    80005888:	100027f3          	csrr	a5,sstatus
    8000588c:	0027f793          	andi	a5,a5,2
    80005890:	06079e63          	bnez	a5,8000590c <console_handler+0x9c>
    80005894:	00074c63          	bltz	a4,800058ac <console_handler+0x3c>
    80005898:	01813083          	ld	ra,24(sp)
    8000589c:	01013403          	ld	s0,16(sp)
    800058a0:	00813483          	ld	s1,8(sp)
    800058a4:	02010113          	addi	sp,sp,32
    800058a8:	00008067          	ret
    800058ac:	0ff77713          	andi	a4,a4,255
    800058b0:	00900793          	li	a5,9
    800058b4:	fef712e3          	bne	a4,a5,80005898 <console_handler+0x28>
    800058b8:	ffffe097          	auipc	ra,0xffffe
    800058bc:	6dc080e7          	jalr	1756(ra) # 80003f94 <plic_claim>
    800058c0:	00a00793          	li	a5,10
    800058c4:	00050493          	mv	s1,a0
    800058c8:	02f50c63          	beq	a0,a5,80005900 <console_handler+0x90>
    800058cc:	fc0506e3          	beqz	a0,80005898 <console_handler+0x28>
    800058d0:	00050593          	mv	a1,a0
    800058d4:	00001517          	auipc	a0,0x1
    800058d8:	96c50513          	addi	a0,a0,-1684 # 80006240 <CONSOLE_STATUS+0x230>
    800058dc:	fffff097          	auipc	ra,0xfffff
    800058e0:	afc080e7          	jalr	-1284(ra) # 800043d8 <__printf>
    800058e4:	01013403          	ld	s0,16(sp)
    800058e8:	01813083          	ld	ra,24(sp)
    800058ec:	00048513          	mv	a0,s1
    800058f0:	00813483          	ld	s1,8(sp)
    800058f4:	02010113          	addi	sp,sp,32
    800058f8:	ffffe317          	auipc	t1,0xffffe
    800058fc:	6d430067          	jr	1748(t1) # 80003fcc <plic_complete>
    80005900:	fffff097          	auipc	ra,0xfffff
    80005904:	3e0080e7          	jalr	992(ra) # 80004ce0 <uartintr>
    80005908:	fddff06f          	j	800058e4 <console_handler+0x74>
    8000590c:	00001517          	auipc	a0,0x1
    80005910:	a3450513          	addi	a0,a0,-1484 # 80006340 <digits+0x78>
    80005914:	fffff097          	auipc	ra,0xfffff
    80005918:	a68080e7          	jalr	-1432(ra) # 8000437c <panic>
	...
