
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	18813103          	ld	sp,392(sp) # 80009188 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	539040ef          	jal	ra,80004d54 <start>

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
    800015d0:	bdc7b783          	ld	a5,-1060(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    80001618:	b74080e7          	jalr	-1164(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
    8000161c:	00008797          	auipc	a5,0x8
    80001620:	b8c7b783          	ld	a5,-1140(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    8000164c:	cb0080e7          	jalr	-848(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
    80001650:	00008797          	auipc	a5,0x8
    80001654:	b587b783          	ld	a5,-1192(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001658:	0007b783          	ld	a5,0(a5)
    8000165c:	0187b783          	ld	a5,24(a5)
    80001660:	04a7b823          	sd	a0,80(a5)
                break;
    80001664:	fcdff06f          	j	80001630 <interruptHandler+0x108>
                PCB::timeSliceCounter = 0;
    80001668:	00008797          	auipc	a5,0x8
    8000166c:	b187b783          	ld	a5,-1256(a5) # 80009180 <_GLOBAL_OFFSET_TABLE_+0x40>
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
    8000168c:	af87b783          	ld	a5,-1288(a5) # 80009180 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001690:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001694:	00000097          	auipc	ra,0x0
    80001698:	460080e7          	jalr	1120(ra) # 80001af4 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    8000169c:	00008797          	auipc	a5,0x8
    800016a0:	b0c7b783          	ld	a5,-1268(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    800016c0:	3b4080e7          	jalr	948(ra) # 80002a70 <_ZN9Scheduler3putEP3PCB>
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
    800016ec:	00008797          	auipc	a5,0x8
    800016f0:	abc7b783          	ld	a5,-1348(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    80001754:	ee0080e7          	jalr	-288(ra) # 80003630 <_ZN3SCB15createSemaphoreEi>
    80001758:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    8000175c:	00008797          	auipc	a5,0x8
    80001760:	a4c7b783          	ld	a5,-1460(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001764:	0007b783          	ld	a5,0(a5)
    80001768:	0187b783          	ld	a5,24(a5)
    8000176c:	0497b823          	sd	s1,80(a5)
                break;
    80001770:	ec1ff06f          	j	80001630 <interruptHandler+0x108>
                    (*handle) = SCB::createSysSemaphore(init);
    80001774:	00002097          	auipc	ra,0x2
    80001778:	f70080e7          	jalr	-144(ra) # 800036e4 <_ZN3SCB18createSysSemaphoreEi>
    8000177c:	00a4b023          	sd	a0,0(s1)
    80001780:	fddff06f          	j	8000175c <interruptHandler+0x234>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001784:	05873503          	ld	a0,88(a4)
    80001788:	00002097          	auipc	ra,0x2
    8000178c:	cd0080e7          	jalr	-816(ra) # 80003458 <_ZN3SCB4waitEv>
    80001790:	00008797          	auipc	a5,0x8
    80001794:	a187b783          	ld	a5,-1512(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001798:	0007b783          	ld	a5,0(a5)
    8000179c:	0187b783          	ld	a5,24(a5)
    800017a0:	04a7b823          	sd	a0,80(a5)
                break;
    800017a4:	e8dff06f          	j	80001630 <interruptHandler+0x108>
                sem->signal();
    800017a8:	05873503          	ld	a0,88(a4)
    800017ac:	00002097          	auipc	ra,0x2
    800017b0:	d40080e7          	jalr	-704(ra) # 800034ec <_ZN3SCB6signalEv>
                break;
    800017b4:	e7dff06f          	j	80001630 <interruptHandler+0x108>
                SCB* sem = (SCB*) PCB::running->registers[11];
    800017b8:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    800017bc:	00048513          	mv	a0,s1
    800017c0:	00002097          	auipc	ra,0x2
    800017c4:	e0c080e7          	jalr	-500(ra) # 800035cc <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    800017c8:	e60484e3          	beqz	s1,80001630 <interruptHandler+0x108>
    800017cc:	00048513          	mv	a0,s1
    800017d0:	00002097          	auipc	ra,0x2
    800017d4:	dd4080e7          	jalr	-556(ra) # 800035a4 <_ZN3SCBdlEPv>
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
    800017f4:	00008517          	auipc	a0,0x8
    800017f8:	97453503          	ld	a0,-1676(a0) # 80009168 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017fc:	00001097          	auipc	ra,0x1
    80001800:	b58080e7          	jalr	-1192(ra) # 80002354 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    80001804:	00008797          	auipc	a5,0x8
    80001808:	9b47b783          	ld	a5,-1612(a5) # 800091b8 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00002097          	auipc	ra,0x2
    80001814:	cdc080e7          	jalr	-804(ra) # 800034ec <_ZN3SCB6signalEv>
                break;
    80001818:	e19ff06f          	j	80001630 <interruptHandler+0x108>
                CCB::semInput->signal();
    8000181c:	00008797          	auipc	a5,0x8
    80001820:	9bc7b783          	ld	a5,-1604(a5) # 800091d8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80001824:	0007b503          	ld	a0,0(a5)
    80001828:	00002097          	auipc	ra,0x2
    8000182c:	cc4080e7          	jalr	-828(ra) # 800034ec <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001830:	00008517          	auipc	a0,0x8
    80001834:	94053503          	ld	a0,-1728(a0) # 80009170 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001838:	00001097          	auipc	ra,0x1
    8000183c:	ca4080e7          	jalr	-860(ra) # 800024dc <_ZN8IOBuffer9peekFrontEv>
    80001840:	00051e63          	bnez	a0,8000185c <interruptHandler+0x334>
                    CCB::inputBufferEmpty->wait();
    80001844:	00008797          	auipc	a5,0x8
    80001848:	9847b783          	ld	a5,-1660(a5) # 800091c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000184c:	0007b503          	ld	a0,0(a5)
    80001850:	00002097          	auipc	ra,0x2
    80001854:	c08080e7          	jalr	-1016(ra) # 80003458 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001858:	fd9ff06f          	j	80001830 <interruptHandler+0x308>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000185c:	00008517          	auipc	a0,0x8
    80001860:	91453503          	ld	a0,-1772(a0) # 80009170 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001864:	00001097          	auipc	ra,0x1
    80001868:	be8080e7          	jalr	-1048(ra) # 8000244c <_ZN8IOBuffer8popFrontEv>
    8000186c:	00008797          	auipc	a5,0x8
    80001870:	93c7b783          	ld	a5,-1732(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    80001894:	00008497          	auipc	s1,0x8
    80001898:	8ec4b483          	ld	s1,-1812(s1) # 80009180 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000189c:	0004b783          	ld	a5,0(s1)
    800018a0:	00178793          	addi	a5,a5,1
    800018a4:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800018a8:	00000097          	auipc	ra,0x0
    800018ac:	0f0080e7          	jalr	240(ra) # 80001998 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800018b0:	00008797          	auipc	a5,0x8
    800018b4:	8f87b783          	ld	a5,-1800(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
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
    800018f8:	cc0080e7          	jalr	-832(ra) # 800055b4 <plic_claim>
        plic_complete(code);
    800018fc:	00004097          	auipc	ra,0x4
    80001900:	cf0080e7          	jalr	-784(ra) # 800055ec <plic_complete>
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
    80001914:	00008797          	auipc	a5,0x8
    80001918:	91c7b783          	ld	a5,-1764(a5) # 80009230 <_ZN17SleepingProcesses4headE>
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
    80001978:	00008717          	auipc	a4,0x8
    8000197c:	8aa73c23          	sd	a0,-1864(a4) # 80009230 <_ZN17SleepingProcesses4headE>
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
    80001998:	00008517          	auipc	a0,0x8
    8000199c:	89853503          	ld	a0,-1896(a0) # 80009230 <_ZN17SleepingProcesses4headE>
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
    800019ec:	088080e7          	jalr	136(ra) # 80002a70 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019f0:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019f4:	fe0490e3          	bnez	s1,800019d4 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019f8:	00008797          	auipc	a5,0x8
    800019fc:	82a7bc23          	sd	a0,-1992(a5) # 80009230 <_ZN17SleepingProcesses4headE>
}
    80001a00:	01813083          	ld	ra,24(sp)
    80001a04:	01013403          	ld	s0,16(sp)
    80001a08:	00813483          	ld	s1,8(sp)
    80001a0c:	02010113          	addi	sp,sp,32
    80001a10:	00008067          	ret
    head = curr;
    80001a14:	00008797          	auipc	a5,0x8
    80001a18:	80a7be23          	sd	a0,-2020(a5) # 80009230 <_ZN17SleepingProcesses4headE>
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
    80001a60:	464080e7          	jalr	1124(ra) # 80002ec0 <_ZdaPv>
    delete[] object->sysStack;
    80001a64:	0104b503          	ld	a0,16(s1)
    80001a68:	00050663          	beqz	a0,80001a74 <_ZN3PCB10freeObjectEPv+0x38>
    80001a6c:	00001097          	auipc	ra,0x1
    80001a70:	454080e7          	jalr	1108(ra) # 80002ec0 <_ZdaPv>
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
    80001aa4:	7987b783          	ld	a5,1944(a5) # 80009238 <_ZN3PCB7runningE>
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
    80001b0c:	7304b483          	ld	s1,1840(s1) # 80009238 <_ZN3PCB7runningE>
        return finished;
    80001b10:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001b14:	00079663          	bnez	a5,80001b20 <_ZN3PCB8dispatchEv+0x2c>
    80001b18:	0294c783          	lbu	a5,41(s1)
    80001b1c:	04078263          	beqz	a5,80001b60 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b20:	00001097          	auipc	ra,0x1
    80001b24:	fa8080e7          	jalr	-88(ra) # 80002ac8 <_ZN9Scheduler3getEv>
    80001b28:	00007797          	auipc	a5,0x7
    80001b2c:	70a7b823          	sd	a0,1808(a5) # 80009238 <_ZN3PCB7runningE>
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
    80001b68:	f0c080e7          	jalr	-244(ra) # 80002a70 <_ZN9Scheduler3putEP3PCB>
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
    80001ba8:	31c080e7          	jalr	796(ra) # 80002ec0 <_ZdaPv>
    delete[] sysStack;
    80001bac:	0104b503          	ld	a0,16(s1)
    80001bb0:	00050663          	beqz	a0,80001bbc <_ZN3PCBD1Ev+0x38>
    80001bb4:	00001097          	auipc	ra,0x1
    80001bb8:	30c080e7          	jalr	780(ra) # 80002ec0 <_ZdaPv>
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
    80001be4:	5a8080e7          	jalr	1448(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
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
    80001c0c:	6f0080e7          	jalr	1776(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
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
    80001c30:	60c7b783          	ld	a5,1548(a5) # 80009238 <_ZN3PCB7runningE>
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
    80001c90:	4fc080e7          	jalr	1276(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
    80001c94:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001c98:	00008537          	lui	a0,0x8
    80001c9c:	00002097          	auipc	ra,0x2
    80001ca0:	4ec080e7          	jalr	1260(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
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
    80001d7c:	6f0080e7          	jalr	1776(ra) # 8000a468 <_Unwind_Resume>
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
    80001dd0:	708080e7          	jalr	1800(ra) # 800044d4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001dd4:	00007797          	auipc	a5,0x7
    80001dd8:	46a7b623          	sd	a0,1132(a5) # 80009240 <_ZN3PCB8pcbCacheE>
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
    80001e14:	4307b783          	ld	a5,1072(a5) # 80009240 <_ZN3PCB8pcbCacheE>
    80001e18:	04078663          	beqz	a5,80001e64 <_ZN3PCB16createSysProcessEPFvvEPv+0x78>
    PCB* object = (PCB*) kmem_cache_alloc(pcbCache);
    80001e1c:	00007517          	auipc	a0,0x7
    80001e20:	42453503          	ld	a0,1060(a0) # 80009240 <_ZN3PCB8pcbCacheE>
    80001e24:	00002097          	auipc	ra,0x2
    80001e28:	700080e7          	jalr	1792(ra) # 80004524 <_Z16kmem_cache_allocP12kmem_cache_s>
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
    80001e90:	3c478793          	addi	a5,a5,964 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80001edc:	37870713          	addi	a4,a4,888 # 80009250 <_ZN14BuddyAllocator5buddyE>
    80001ee0:	00d70733          	add	a4,a4,a3
    80001ee4:	00073503          	ld	a0,0(a4)
    80001ee8:	00050e63          	beqz	a0,80001f04 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001eec:	00053683          	ld	a3,0(a0)
    80001ef0:	00379793          	slli	a5,a5,0x3
    80001ef4:	00007717          	auipc	a4,0x7
    80001ef8:	35c70713          	addi	a4,a4,860 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80001f38:	31c78793          	addi	a5,a5,796 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80001f88:	2cc78793          	addi	a5,a5,716 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80001fc4:	26850513          	addi	a0,a0,616 # 80007228 <CONSOLE_STATUS+0x218>
    80001fc8:	00000097          	auipc	ra,0x0
    80001fcc:	7b8080e7          	jalr	1976(ra) # 80002780 <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    80001fd0:	00190913          	addi	s2,s2,1
    80001fd4:	00b00793          	li	a5,11
    80001fd8:	0727e663          	bltu	a5,s2,80002044 <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80001fdc:	00000613          	li	a2,0
    80001fe0:	00a00593          	li	a1,10
    80001fe4:	0019051b          	addiw	a0,s2,1
    80001fe8:	00001097          	auipc	ra,0x1
    80001fec:	930080e7          	jalr	-1744(ra) # 80002918 <_Z8printIntiii>
        printString(": ");
    80001ff0:	00005517          	auipc	a0,0x5
    80001ff4:	14850513          	addi	a0,a0,328 # 80007138 <CONSOLE_STATUS+0x128>
    80001ff8:	00000097          	auipc	ra,0x0
    80001ffc:	788080e7          	jalr	1928(ra) # 80002780 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    80002000:	00391713          	slli	a4,s2,0x3
    80002004:	00007797          	auipc	a5,0x7
    80002008:	24c78793          	addi	a5,a5,588 # 80009250 <_ZN14BuddyAllocator5buddyE>
    8000200c:	00e787b3          	add	a5,a5,a4
    80002010:	0007b483          	ld	s1,0(a5)
    80002014:	fa0486e3          	beqz	s1,80001fc0 <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    80002018:	00000613          	li	a2,0
    8000201c:	00a00593          	li	a1,10
    80002020:	0084a503          	lw	a0,8(s1)
    80002024:	00001097          	auipc	ra,0x1
    80002028:	8f4080e7          	jalr	-1804(ra) # 80002918 <_Z8printIntiii>
            printString(" ");
    8000202c:	00005517          	auipc	a0,0x5
    80002030:	11450513          	addi	a0,a0,276 # 80007140 <CONSOLE_STATUS+0x130>
    80002034:	00000097          	auipc	ra,0x0
    80002038:	74c080e7          	jalr	1868(ra) # 80002780 <_Z11printStringPKc>
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
    8000209c:	1b878793          	addi	a5,a5,440 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    800020b8:	19c78793          	addi	a5,a5,412 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80002114:	14078793          	addi	a5,a5,320 # 80009250 <_ZN14BuddyAllocator5buddyE>
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
    80002144:	1707b783          	ld	a5,368(a5) # 800092b0 <_ZN14BuddyAllocator9startAddrE>
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
    80002168:	ffc7b783          	ld	a5,-4(a5) # 80009160 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000216c:	0007b503          	ld	a0,0(a5)
    80002170:	00007797          	auipc	a5,0x7
    80002174:	14a7b023          	sd	a0,320(a5) # 800092b0 <_ZN14BuddyAllocator9startAddrE>
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
    800022b8:	ffc93903          	ld	s2,-4(s2) # 800092b0 <_ZN14BuddyAllocator9startAddrE>
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
    8000237c:	e10080e7          	jalr	-496(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
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
    800023e4:	d687b783          	ld	a5,-664(a5) # 80009148 <_GLOBAL_OFFSET_TABLE_+0x8>
    800023e8:	0007b783          	ld	a5,0(a5)
    800023ec:	00007497          	auipc	s1,0x7
    800023f0:	ecc48493          	addi	s1,s1,-308 # 800092b8 <_ZN3CCB11inputBufferE>
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
    80002418:	1d8080e7          	jalr	472(ra) # 800055ec <plic_complete>
            sem_wait(semInput);
    8000241c:	0184b503          	ld	a0,24(s1)
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	f78080e7          	jalr	-136(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002428:	00007797          	auipc	a5,0x7
    8000242c:	d307b783          	ld	a5,-720(a5) # 80009158 <_GLOBAL_OFFSET_TABLE_+0x18>
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
    80002484:	e78080e7          	jalr	-392(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
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
    8000252c:	c307b783          	ld	a5,-976(a5) # 80009158 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002530:	0007b783          	ld	a5,0(a5)
    80002534:	0007c783          	lbu	a5,0(a5)
    80002538:	0207f793          	andi	a5,a5,32
    8000253c:	fe0782e3          	beqz	a5,80002520 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80002540:	00007517          	auipc	a0,0x7
    80002544:	d9850513          	addi	a0,a0,-616 # 800092d8 <_ZN3CCB12outputBufferE>
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	f94080e7          	jalr	-108(ra) # 800024dc <_ZN8IOBuffer9peekFrontEv>
    80002550:	fc0508e3          	beqz	a0,80002520 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80002554:	00007797          	auipc	a5,0x7
    80002558:	c247b783          	ld	a5,-988(a5) # 80009178 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000255c:	0007b483          	ld	s1,0(a5)
    80002560:	00007517          	auipc	a0,0x7
    80002564:	d7850513          	addi	a0,a0,-648 # 800092d8 <_ZN3CCB12outputBufferE>
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	ee4080e7          	jalr	-284(ra) # 8000244c <_ZN8IOBuffer8popFrontEv>
    80002570:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    80002574:	00007517          	auipc	a0,0x7
    80002578:	d7453503          	ld	a0,-652(a0) # 800092e8 <_ZN3CCB9semOutputE>
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
    Cache* cache = Cache::createCache();
    800025e4:	00001097          	auipc	ra,0x1
    800025e8:	6e4080e7          	jalr	1764(ra) # 80003cc8 <_ZN5Cache11createCacheEv>
    800025ec:	00050493          	mv	s1,a0
    cache->initCache(name, size, ctor, dtor);
    800025f0:	000a8713          	mv	a4,s5
    800025f4:	000a0693          	mv	a3,s4
    800025f8:	00098613          	mv	a2,s3
    800025fc:	00090593          	mv	a1,s2
    80002600:	00001097          	auipc	ra,0x1
    80002604:	730080e7          	jalr	1840(ra) # 80003d30 <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    return cache;
}
    80002608:	00048513          	mv	a0,s1
    8000260c:	03813083          	ld	ra,56(sp)
    80002610:	03013403          	ld	s0,48(sp)
    80002614:	02813483          	ld	s1,40(sp)
    80002618:	02013903          	ld	s2,32(sp)
    8000261c:	01813983          	ld	s3,24(sp)
    80002620:	01013a03          	ld	s4,16(sp)
    80002624:	00813a83          	ld	s5,8(sp)
    80002628:	04010113          	addi	sp,sp,64
    8000262c:	00008067          	ret

0000000080002630 <_ZN13SlabAllocator9allocSlotEP5Cache>:

void *SlabAllocator::allocSlot(Cache *cache) {
    80002630:	ff010113          	addi	sp,sp,-16
    80002634:	00113423          	sd	ra,8(sp)
    80002638:	00813023          	sd	s0,0(sp)
    8000263c:	01010413          	addi	s0,sp,16
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
    80002640:	00002097          	auipc	ra,0x2
    80002644:	a1c080e7          	jalr	-1508(ra) # 8000405c <_ZN5Cache12allocateSlotEv>
}
    80002648:	01850513          	addi	a0,a0,24
    8000264c:	00813083          	ld	ra,8(sp)
    80002650:	00013403          	ld	s0,0(sp)
    80002654:	01010113          	addi	sp,sp,16
    80002658:	00008067          	ret

000000008000265c <_ZN13SlabAllocator8freeSlotEP5CachePv>:

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    8000265c:	ff010113          	addi	sp,sp,-16
    80002660:	00113423          	sd	ra,8(sp)
    80002664:	00813023          	sd	s0,0(sp)
    80002668:	01010413          	addi	s0,sp,16
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
    8000266c:	fe858593          	addi	a1,a1,-24
    80002670:	00002097          	auipc	ra,0x2
    80002674:	840080e7          	jalr	-1984(ra) # 80003eb0 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80002678:	00813083          	ld	ra,8(sp)
    8000267c:	00013403          	ld	s0,0(sp)
    80002680:	01010113          	addi	sp,sp,16
    80002684:	00008067          	ret

0000000080002688 <_ZN13SlabAllocator17printErrorMessageEP5Cache>:

int SlabAllocator::printErrorMessage(Cache *cache) {
    80002688:	ff010113          	addi	sp,sp,-16
    8000268c:	00113423          	sd	ra,8(sp)
    80002690:	00813023          	sd	s0,0(sp)
    80002694:	01010413          	addi	s0,sp,16
    return cache->printErrorMessage();
    80002698:	00001097          	auipc	ra,0x1
    8000269c:	1b8080e7          	jalr	440(ra) # 80003850 <_ZN5Cache17printErrorMessageEv>
}
    800026a0:	00813083          	ld	ra,8(sp)
    800026a4:	00013403          	ld	s0,0(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret

00000000800026b0 <_ZN13SlabAllocator14printCacheInfoEP5Cache>:

void SlabAllocator::printCacheInfo(Cache *cache) {
    800026b0:	ff010113          	addi	sp,sp,-16
    800026b4:	00113423          	sd	ra,8(sp)
    800026b8:	00813023          	sd	s0,0(sp)
    800026bc:	01010413          	addi	s0,sp,16
    cache->printCacheInfo();
    800026c0:	00001097          	auipc	ra,0x1
    800026c4:	250080e7          	jalr	592(ra) # 80003910 <_ZN5Cache14printCacheInfoEv>
}
    800026c8:	00813083          	ld	ra,8(sp)
    800026cc:	00013403          	ld	s0,0(sp)
    800026d0:	01010113          	addi	sp,sp,16
    800026d4:	00008067          	ret

00000000800026d8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>:

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    800026d8:	ff010113          	addi	sp,sp,-16
    800026dc:	00113423          	sd	ra,8(sp)
    800026e0:	00813023          	sd	s0,0(sp)
    800026e4:	01010413          	addi	s0,sp,16
    return cache->deallocFreeSlabs();
    800026e8:	00001097          	auipc	ra,0x1
    800026ec:	3d8080e7          	jalr	984(ra) # 80003ac0 <_ZN5Cache16deallocFreeSlabsEv>
}
    800026f0:	00813083          	ld	ra,8(sp)
    800026f4:	00013403          	ld	s0,0(sp)
    800026f8:	01010113          	addi	sp,sp,16
    800026fc:	00008067          	ret

0000000080002700 <_ZN13SlabAllocator12deallocCacheEP5Cache>:

void SlabAllocator::deallocCache(Cache *cache) {
    80002700:	ff010113          	addi	sp,sp,-16
    80002704:	00113423          	sd	ra,8(sp)
    80002708:	00813023          	sd	s0,0(sp)
    8000270c:	01010413          	addi	s0,sp,16
    cache->deallocCache();
    80002710:	00001097          	auipc	ra,0x1
    80002714:	41c080e7          	jalr	1052(ra) # 80003b2c <_ZN5Cache12deallocCacheEv>
}
    80002718:	00813083          	ld	ra,8(sp)
    8000271c:	00013403          	ld	s0,0(sp)
    80002720:	01010113          	addi	sp,sp,16
    80002724:	00008067          	ret

0000000080002728 <_ZN13SlabAllocator9allocBuffEm>:

void *SlabAllocator::allocBuff(size_t size) {
    80002728:	ff010113          	addi	sp,sp,-16
    8000272c:	00113423          	sd	ra,8(sp)
    80002730:	00813023          	sd	s0,0(sp)
    80002734:	01010413          	addi	s0,sp,16
    return (void*)((char*)Cache::allocateBuffer(size) + sizeof(Cache::Slot)); // za pocetnu adresu bafera
    80002738:	00002097          	auipc	ra,0x2
    8000273c:	984080e7          	jalr	-1660(ra) # 800040bc <_ZN5Cache14allocateBufferEm>
}
    80002740:	01850513          	addi	a0,a0,24
    80002744:	00813083          	ld	ra,8(sp)
    80002748:	00013403          	ld	s0,0(sp)
    8000274c:	01010113          	addi	sp,sp,16
    80002750:	00008067          	ret

0000000080002754 <_ZN13SlabAllocator8freeBuffEPKv>:

void SlabAllocator::freeBuff(const void *buff) {
    80002754:	ff010113          	addi	sp,sp,-16
    80002758:	00113423          	sd	ra,8(sp)
    8000275c:	00813023          	sd	s0,0(sp)
    80002760:	01010413          	addi	s0,sp,16
    Cache::freeBuffer((Cache::Slot*)((char*)buff - sizeof(Cache::Slot))); // za pocetnu adresu slota
    80002764:	fe850513          	addi	a0,a0,-24
    80002768:	00001097          	auipc	ra,0x1
    8000276c:	7f0080e7          	jalr	2032(ra) # 80003f58 <_ZN5Cache10freeBufferEPNS_4SlotE>
}
    80002770:	00813083          	ld	ra,8(sp)
    80002774:	00013403          	ld	s0,0(sp)
    80002778:	01010113          	addi	sp,sp,16
    8000277c:	00008067          	ret

0000000080002780 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002780:	fe010113          	addi	sp,sp,-32
    80002784:	00113c23          	sd	ra,24(sp)
    80002788:	00813823          	sd	s0,16(sp)
    8000278c:	00913423          	sd	s1,8(sp)
    80002790:	02010413          	addi	s0,sp,32
    80002794:	00050493          	mv	s1,a0
    LOCK();
    80002798:	00100613          	li	a2,1
    8000279c:	00000593          	li	a1,0
    800027a0:	00007517          	auipc	a0,0x7
    800027a4:	b6050513          	addi	a0,a0,-1184 # 80009300 <lockPrint>
    800027a8:	fffff097          	auipc	ra,0xfffff
    800027ac:	9a8080e7          	jalr	-1624(ra) # 80001150 <copy_and_swap>
    800027b0:	fe0514e3          	bnez	a0,80002798 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800027b4:	0004c503          	lbu	a0,0(s1)
    800027b8:	00050a63          	beqz	a0,800027cc <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	d1c080e7          	jalr	-740(ra) # 800014d8 <_Z4putcc>
        string++;
    800027c4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800027c8:	fedff06f          	j	800027b4 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800027cc:	00000613          	li	a2,0
    800027d0:	00100593          	li	a1,1
    800027d4:	00007517          	auipc	a0,0x7
    800027d8:	b2c50513          	addi	a0,a0,-1236 # 80009300 <lockPrint>
    800027dc:	fffff097          	auipc	ra,0xfffff
    800027e0:	974080e7          	jalr	-1676(ra) # 80001150 <copy_and_swap>
    800027e4:	fe0514e3          	bnez	a0,800027cc <_Z11printStringPKc+0x4c>
}
    800027e8:	01813083          	ld	ra,24(sp)
    800027ec:	01013403          	ld	s0,16(sp)
    800027f0:	00813483          	ld	s1,8(sp)
    800027f4:	02010113          	addi	sp,sp,32
    800027f8:	00008067          	ret

00000000800027fc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800027fc:	fd010113          	addi	sp,sp,-48
    80002800:	02113423          	sd	ra,40(sp)
    80002804:	02813023          	sd	s0,32(sp)
    80002808:	00913c23          	sd	s1,24(sp)
    8000280c:	01213823          	sd	s2,16(sp)
    80002810:	01313423          	sd	s3,8(sp)
    80002814:	01413023          	sd	s4,0(sp)
    80002818:	03010413          	addi	s0,sp,48
    8000281c:	00050993          	mv	s3,a0
    80002820:	00058a13          	mv	s4,a1
    LOCK();
    80002824:	00100613          	li	a2,1
    80002828:	00000593          	li	a1,0
    8000282c:	00007517          	auipc	a0,0x7
    80002830:	ad450513          	addi	a0,a0,-1324 # 80009300 <lockPrint>
    80002834:	fffff097          	auipc	ra,0xfffff
    80002838:	91c080e7          	jalr	-1764(ra) # 80001150 <copy_and_swap>
    8000283c:	fe0514e3          	bnez	a0,80002824 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002840:	00000913          	li	s2,0
    80002844:	00090493          	mv	s1,s2
    80002848:	0019091b          	addiw	s2,s2,1
    8000284c:	03495a63          	bge	s2,s4,80002880 <_Z9getStringPci+0x84>
        cc = getc();
    80002850:	fffff097          	auipc	ra,0xfffff
    80002854:	c58080e7          	jalr	-936(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80002858:	02050463          	beqz	a0,80002880 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000285c:	009984b3          	add	s1,s3,s1
    80002860:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002864:	00a00793          	li	a5,10
    80002868:	00f50a63          	beq	a0,a5,8000287c <_Z9getStringPci+0x80>
    8000286c:	00d00793          	li	a5,13
    80002870:	fcf51ae3          	bne	a0,a5,80002844 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002874:	00090493          	mv	s1,s2
    80002878:	0080006f          	j	80002880 <_Z9getStringPci+0x84>
    8000287c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002880:	009984b3          	add	s1,s3,s1
    80002884:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002888:	00000613          	li	a2,0
    8000288c:	00100593          	li	a1,1
    80002890:	00007517          	auipc	a0,0x7
    80002894:	a7050513          	addi	a0,a0,-1424 # 80009300 <lockPrint>
    80002898:	fffff097          	auipc	ra,0xfffff
    8000289c:	8b8080e7          	jalr	-1864(ra) # 80001150 <copy_and_swap>
    800028a0:	fe0514e3          	bnez	a0,80002888 <_Z9getStringPci+0x8c>
    return buf;
}
    800028a4:	00098513          	mv	a0,s3
    800028a8:	02813083          	ld	ra,40(sp)
    800028ac:	02013403          	ld	s0,32(sp)
    800028b0:	01813483          	ld	s1,24(sp)
    800028b4:	01013903          	ld	s2,16(sp)
    800028b8:	00813983          	ld	s3,8(sp)
    800028bc:	00013a03          	ld	s4,0(sp)
    800028c0:	03010113          	addi	sp,sp,48
    800028c4:	00008067          	ret

00000000800028c8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00813423          	sd	s0,8(sp)
    800028d0:	01010413          	addi	s0,sp,16
    800028d4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800028d8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800028dc:	0006c603          	lbu	a2,0(a3)
    800028e0:	fd06071b          	addiw	a4,a2,-48
    800028e4:	0ff77713          	andi	a4,a4,255
    800028e8:	00900793          	li	a5,9
    800028ec:	02e7e063          	bltu	a5,a4,8000290c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800028f0:	0025179b          	slliw	a5,a0,0x2
    800028f4:	00a787bb          	addw	a5,a5,a0
    800028f8:	0017979b          	slliw	a5,a5,0x1
    800028fc:	00168693          	addi	a3,a3,1
    80002900:	00c787bb          	addw	a5,a5,a2
    80002904:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002908:	fd5ff06f          	j	800028dc <_Z11stringToIntPKc+0x14>
    return n;
}
    8000290c:	00813403          	ld	s0,8(sp)
    80002910:	01010113          	addi	sp,sp,16
    80002914:	00008067          	ret

0000000080002918 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002918:	fc010113          	addi	sp,sp,-64
    8000291c:	02113c23          	sd	ra,56(sp)
    80002920:	02813823          	sd	s0,48(sp)
    80002924:	02913423          	sd	s1,40(sp)
    80002928:	03213023          	sd	s2,32(sp)
    8000292c:	01313c23          	sd	s3,24(sp)
    80002930:	04010413          	addi	s0,sp,64
    80002934:	00050493          	mv	s1,a0
    80002938:	00058913          	mv	s2,a1
    8000293c:	00060993          	mv	s3,a2
    LOCK();
    80002940:	00100613          	li	a2,1
    80002944:	00000593          	li	a1,0
    80002948:	00007517          	auipc	a0,0x7
    8000294c:	9b850513          	addi	a0,a0,-1608 # 80009300 <lockPrint>
    80002950:	fffff097          	auipc	ra,0xfffff
    80002954:	800080e7          	jalr	-2048(ra) # 80001150 <copy_and_swap>
    80002958:	fe0514e3          	bnez	a0,80002940 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000295c:	00098463          	beqz	s3,80002964 <_Z8printIntiii+0x4c>
    80002960:	0804c463          	bltz	s1,800029e8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002964:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002968:	00000593          	li	a1,0
    }

    i = 0;
    8000296c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002970:	0009079b          	sext.w	a5,s2
    80002974:	0325773b          	remuw	a4,a0,s2
    80002978:	00048613          	mv	a2,s1
    8000297c:	0014849b          	addiw	s1,s1,1
    80002980:	02071693          	slli	a3,a4,0x20
    80002984:	0206d693          	srli	a3,a3,0x20
    80002988:	00006717          	auipc	a4,0x6
    8000298c:	6c070713          	addi	a4,a4,1728 # 80009048 <digits>
    80002990:	00d70733          	add	a4,a4,a3
    80002994:	00074683          	lbu	a3,0(a4)
    80002998:	fd040713          	addi	a4,s0,-48
    8000299c:	00c70733          	add	a4,a4,a2
    800029a0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800029a4:	0005071b          	sext.w	a4,a0
    800029a8:	0325553b          	divuw	a0,a0,s2
    800029ac:	fcf772e3          	bgeu	a4,a5,80002970 <_Z8printIntiii+0x58>
    if(neg)
    800029b0:	00058c63          	beqz	a1,800029c8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800029b4:	fd040793          	addi	a5,s0,-48
    800029b8:	009784b3          	add	s1,a5,s1
    800029bc:	02d00793          	li	a5,45
    800029c0:	fef48823          	sb	a5,-16(s1)
    800029c4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800029c8:	fff4849b          	addiw	s1,s1,-1
    800029cc:	0204c463          	bltz	s1,800029f4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    800029d0:	fd040793          	addi	a5,s0,-48
    800029d4:	009787b3          	add	a5,a5,s1
    800029d8:	ff07c503          	lbu	a0,-16(a5)
    800029dc:	fffff097          	auipc	ra,0xfffff
    800029e0:	afc080e7          	jalr	-1284(ra) # 800014d8 <_Z4putcc>
    800029e4:	fe5ff06f          	j	800029c8 <_Z8printIntiii+0xb0>
        x = -xx;
    800029e8:	4090053b          	negw	a0,s1
        neg = 1;
    800029ec:	00100593          	li	a1,1
        x = -xx;
    800029f0:	f7dff06f          	j	8000296c <_Z8printIntiii+0x54>

    UNLOCK();
    800029f4:	00000613          	li	a2,0
    800029f8:	00100593          	li	a1,1
    800029fc:	00007517          	auipc	a0,0x7
    80002a00:	90450513          	addi	a0,a0,-1788 # 80009300 <lockPrint>
    80002a04:	ffffe097          	auipc	ra,0xffffe
    80002a08:	74c080e7          	jalr	1868(ra) # 80001150 <copy_and_swap>
    80002a0c:	fe0514e3          	bnez	a0,800029f4 <_Z8printIntiii+0xdc>
    80002a10:	03813083          	ld	ra,56(sp)
    80002a14:	03013403          	ld	s0,48(sp)
    80002a18:	02813483          	ld	s1,40(sp)
    80002a1c:	02013903          	ld	s2,32(sp)
    80002a20:	01813983          	ld	s3,24(sp)
    80002a24:	04010113          	addi	sp,sp,64
    80002a28:	00008067          	ret

0000000080002a2c <_Z8userMainv>:
#include "../h/BuddyAllocator.h"
#include "../h/printing.hpp"
#include "../h/slab.h"
#include "../h/Cache.h"
void userMain() {
    80002a2c:	ff010113          	addi	sp,sp,-16
    80002a30:	00113423          	sd	ra,8(sp)
    80002a34:	00813023          	sd	s0,0(sp)
    80002a38:	01010413          	addi	s0,sp,16
    printString("\nHello world!\n");
    80002a3c:	00004517          	auipc	a0,0x4
    80002a40:	70c50513          	addi	a0,a0,1804 # 80007148 <CONSOLE_STATUS+0x138>
    80002a44:	00000097          	auipc	ra,0x0
    80002a48:	d3c080e7          	jalr	-708(ra) # 80002780 <_Z11printStringPKc>
    kmalloc(1<<16);
    80002a4c:	00010537          	lui	a0,0x10
    80002a50:	00002097          	auipc	ra,0x2
    80002a54:	b24080e7          	jalr	-1244(ra) # 80004574 <_Z7kmallocm>
    Cache::allBufferInfo();
    80002a58:	00001097          	auipc	ra,0x1
    80002a5c:	398080e7          	jalr	920(ra) # 80003df0 <_ZN5Cache13allBufferInfoEv>
    80002a60:	00813083          	ld	ra,8(sp)
    80002a64:	00013403          	ld	s0,0(sp)
    80002a68:	01010113          	addi	sp,sp,16
    80002a6c:	00008067          	ret

0000000080002a70 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002a70:	ff010113          	addi	sp,sp,-16
    80002a74:	00813423          	sd	s0,8(sp)
    80002a78:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002a7c:	02050663          	beqz	a0,80002aa8 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002a80:	00053023          	sd	zero,0(a0) # 10000 <_entry-0x7fff0000>
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002a84:	00007797          	auipc	a5,0x7
    80002a88:	8847b783          	ld	a5,-1916(a5) # 80009308 <_ZN9Scheduler4tailE>
    80002a8c:	02078463          	beqz	a5,80002ab4 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002a90:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002a94:	00007797          	auipc	a5,0x7
    80002a98:	87478793          	addi	a5,a5,-1932 # 80009308 <_ZN9Scheduler4tailE>
    80002a9c:	0007b703          	ld	a4,0(a5)
    80002aa0:	00073703          	ld	a4,0(a4)
    80002aa4:	00e7b023          	sd	a4,0(a5)
    }
}
    80002aa8:	00813403          	ld	s0,8(sp)
    80002aac:	01010113          	addi	sp,sp,16
    80002ab0:	00008067          	ret
        head = tail = process;
    80002ab4:	00007797          	auipc	a5,0x7
    80002ab8:	85478793          	addi	a5,a5,-1964 # 80009308 <_ZN9Scheduler4tailE>
    80002abc:	00a7b023          	sd	a0,0(a5)
    80002ac0:	00a7b423          	sd	a0,8(a5)
    80002ac4:	fe5ff06f          	j	80002aa8 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002ac8 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002ac8:	ff010113          	addi	sp,sp,-16
    80002acc:	00813423          	sd	s0,8(sp)
    80002ad0:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002ad4:	00007517          	auipc	a0,0x7
    80002ad8:	83c53503          	ld	a0,-1988(a0) # 80009310 <_ZN9Scheduler4headE>
    80002adc:	02050463          	beqz	a0,80002b04 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002ae0:	00053703          	ld	a4,0(a0)
    80002ae4:	00007797          	auipc	a5,0x7
    80002ae8:	82478793          	addi	a5,a5,-2012 # 80009308 <_ZN9Scheduler4tailE>
    80002aec:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002af0:	0007b783          	ld	a5,0(a5)
    80002af4:	00f50e63          	beq	a0,a5,80002b10 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002af8:	00813403          	ld	s0,8(sp)
    80002afc:	01010113          	addi	sp,sp,16
    80002b00:	00008067          	ret
        return idleProcess;
    80002b04:	00007517          	auipc	a0,0x7
    80002b08:	81453503          	ld	a0,-2028(a0) # 80009318 <_ZN9Scheduler11idleProcessE>
    80002b0c:	fedff06f          	j	80002af8 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002b10:	00006797          	auipc	a5,0x6
    80002b14:	7ee7bc23          	sd	a4,2040(a5) # 80009308 <_ZN9Scheduler4tailE>
    80002b18:	fe1ff06f          	j	80002af8 <_ZN9Scheduler3getEv+0x30>

0000000080002b1c <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002b1c:	ff010113          	addi	sp,sp,-16
    80002b20:	00813423          	sd	s0,8(sp)
    80002b24:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002b28:	00050e63          	beqz	a0,80002b44 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002b2c:	00006797          	auipc	a5,0x6
    80002b30:	7e47b783          	ld	a5,2020(a5) # 80009310 <_ZN9Scheduler4headE>
    80002b34:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002b38:	00078c63          	beqz	a5,80002b50 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002b3c:	00006797          	auipc	a5,0x6
    80002b40:	7ca7ba23          	sd	a0,2004(a5) # 80009310 <_ZN9Scheduler4headE>
    }
}
    80002b44:	00813403          	ld	s0,8(sp)
    80002b48:	01010113          	addi	sp,sp,16
    80002b4c:	00008067          	ret
        head = tail = process;
    80002b50:	00006797          	auipc	a5,0x6
    80002b54:	7b878793          	addi	a5,a5,1976 # 80009308 <_ZN9Scheduler4tailE>
    80002b58:	00a7b023          	sd	a0,0(a5)
    80002b5c:	00a7b423          	sd	a0,8(a5)
    80002b60:	fe5ff06f          	j	80002b44 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002b64 <idleProcess>:
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002b64:	ff010113          	addi	sp,sp,-16
    80002b68:	00813423          	sd	s0,8(sp)
    80002b6c:	01010413          	addi	s0,sp,16
    while(true) {}
    80002b70:	0000006f          	j	80002b70 <idleProcess+0xc>

0000000080002b74 <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    80002b74:	ff010113          	addi	sp,sp,-16
    80002b78:	00113423          	sd	ra,8(sp)
    80002b7c:	00813023          	sd	s0,0(sp)
    80002b80:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	ea8080e7          	jalr	-344(ra) # 80002a2c <_Z8userMainv>
}
    80002b8c:	00813083          	ld	ra,8(sp)
    80002b90:	00013403          	ld	s0,0(sp)
    80002b94:	01010113          	addi	sp,sp,16
    80002b98:	00008067          	ret

0000000080002b9c <_Z8userModev>:
void userMode() {
    80002b9c:	ff010113          	addi	sp,sp,-16
    80002ba0:	00813423          	sd	s0,8(sp)
    80002ba4:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80002ba8:	04300793          	li	a5,67
    80002bac:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002bb0:	00000073          	ecall
}
    80002bb4:	00813403          	ld	s0,8(sp)
    80002bb8:	01010113          	addi	sp,sp,16
    80002bbc:	00008067          	ret

0000000080002bc0 <main>:
}
// ------------

int main() {
    80002bc0:	ff010113          	addi	sp,sp,-16
    80002bc4:	00113423          	sd	ra,8(sp)
    80002bc8:	00813023          	sd	s0,0(sp)
    80002bcc:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002bd0:	00006797          	auipc	a5,0x6
    80002bd4:	6007b783          	ld	a5,1536(a5) # 800091d0 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002bd8:	10579073          	csrw	stvec,a5
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);
    80002bdc:	010005b7          	lui	a1,0x1000
    80002be0:	00006797          	auipc	a5,0x6
    80002be4:	5807b783          	ld	a5,1408(a5) # 80009160 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002be8:	0007b503          	ld	a0,0(a5)
    80002bec:	00002097          	auipc	ra,0x2
    80002bf0:	8c0080e7          	jalr	-1856(ra) # 800044ac <_Z9kmem_initPvi>

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002bf4:	00000593          	li	a1,0
    80002bf8:	00000513          	li	a0,0
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	1f0080e7          	jalr	496(ra) # 80001dec <_ZN3PCB16createSysProcessEPFvvEPv>
    PCB::running = main;
    80002c04:	00006797          	auipc	a5,0x6
    80002c08:	5a47b783          	ld	a5,1444(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002c0c:	00a7b023          	sd	a0,0(a5)
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002c10:	00000613          	li	a2,0
    80002c14:	00006597          	auipc	a1,0x6
    80002c18:	57c5b583          	ld	a1,1404(a1) # 80009190 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002c1c:	00006517          	auipc	a0,0x6
    80002c20:	5cc53503          	ld	a0,1484(a0) # 800091e8 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80002c24:	ffffe097          	auipc	ra,0xffffe
    80002c28:	6dc080e7          	jalr	1756(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002c2c:	00000613          	li	a2,0
    80002c30:	00006597          	auipc	a1,0x6
    80002c34:	5b05b583          	ld	a1,1456(a1) # 800091e0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002c38:	00006517          	auipc	a0,0x6
    80002c3c:	51853503          	ld	a0,1304(a0) # 80009150 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002c40:	ffffe097          	auipc	ra,0xffffe
    80002c44:	6c0080e7          	jalr	1728(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002c48:	00000613          	li	a2,0
    80002c4c:	00000597          	auipc	a1,0x0
    80002c50:	f1858593          	addi	a1,a1,-232 # 80002b64 <idleProcess>
    80002c54:	00006517          	auipc	a0,0x6
    80002c58:	54c53503          	ld	a0,1356(a0) # 800091a0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c5c:	ffffe097          	auipc	ra,0xffffe
    80002c60:	5ac080e7          	jalr	1452(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80002c64:	00006797          	auipc	a5,0x6
    80002c68:	53c7b783          	ld	a5,1340(a5) # 800091a0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c6c:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    80002c70:	00100713          	li	a4,1
    80002c74:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    80002c78:	00100713          	li	a4,1
    80002c7c:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    80002c80:	00000593          	li	a1,0
    80002c84:	00006517          	auipc	a0,0x6
    80002c88:	55453503          	ld	a0,1364(a0) # 800091d8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002c8c:	ffffe097          	auipc	ra,0xffffe
    80002c90:	6c4080e7          	jalr	1732(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    80002c94:	00000593          	li	a1,0
    80002c98:	00006517          	auipc	a0,0x6
    80002c9c:	52053503          	ld	a0,1312(a0) # 800091b8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002ca0:	ffffe097          	auipc	ra,0xffffe
    80002ca4:	6b0080e7          	jalr	1712(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);
    80002ca8:	00000593          	li	a1,0
    80002cac:	00006517          	auipc	a0,0x6
    80002cb0:	51c53503          	ld	a0,1308(a0) # 800091c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002cb4:	ffffe097          	auipc	ra,0xffffe
    80002cb8:	69c080e7          	jalr	1692(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002cbc:	00200793          	li	a5,2
    80002cc0:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&userProcess, userMainWrapper, nullptr);
    80002cc4:	00000613          	li	a2,0
    80002cc8:	00000597          	auipc	a1,0x0
    80002ccc:	eac58593          	addi	a1,a1,-340 # 80002b74 <_Z15userMainWrapperPv>
    80002cd0:	00006517          	auipc	a0,0x6
    80002cd4:	65050513          	addi	a0,a0,1616 # 80009320 <userProcess>
    80002cd8:	ffffe097          	auipc	ra,0xffffe
    80002cdc:	628080e7          	jalr	1576(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----
    kmem_cache_info(PCB::pcbCache);
    80002ce0:	00006797          	auipc	a5,0x6
    80002ce4:	4b87b783          	ld	a5,1208(a5) # 80009198 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002ce8:	0007b503          	ld	a0,0(a5)
    80002cec:	00002097          	auipc	ra,0x2
    80002cf0:	900080e7          	jalr	-1792(ra) # 800045ec <_Z15kmem_cache_infoP12kmem_cache_s>
    kmem_cache_info(SCB::scbCache);
    80002cf4:	00006797          	auipc	a5,0x6
    80002cf8:	4cc7b783          	ld	a5,1228(a5) # 800091c0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002cfc:	0007b503          	ld	a0,0(a5)
    80002d00:	00002097          	auipc	ra,0x2
    80002d04:	8ec080e7          	jalr	-1812(ra) # 800045ec <_Z15kmem_cache_infoP12kmem_cache_s>
    while(!userProcess->isFinished()) {
    80002d08:	00006797          	auipc	a5,0x6
    80002d0c:	6187b783          	ld	a5,1560(a5) # 80009320 <userProcess>
        return finished;
    80002d10:	0287c783          	lbu	a5,40(a5)
    80002d14:	00079863          	bnez	a5,80002d24 <main+0x164>
        thread_dispatch();
    80002d18:	ffffe097          	auipc	ra,0xffffe
    80002d1c:	55c080e7          	jalr	1372(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    80002d20:	fe9ff06f          	j	80002d08 <main+0x148>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    80002d24:	00006797          	auipc	a5,0x6
    80002d28:	4947b783          	ld	a5,1172(a5) # 800091b8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002d2c:	0007b783          	ld	a5,0(a5)
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    80002d30:	0107a783          	lw	a5,16(a5)
    80002d34:	00078863          	beqz	a5,80002d44 <main+0x184>
        thread_dispatch();
    80002d38:	ffffe097          	auipc	ra,0xffffe
    80002d3c:	53c080e7          	jalr	1340(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    80002d40:	fe5ff06f          	j	80002d24 <main+0x164>
    }
    return 0;
    80002d44:	00000513          	li	a0,0
    80002d48:	00813083          	ld	ra,8(sp)
    80002d4c:	00013403          	ld	s0,0(sp)
    80002d50:	01010113          	addi	sp,sp,16
    80002d54:	00008067          	ret

0000000080002d58 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80002d58:	fe010113          	addi	sp,sp,-32
    80002d5c:	00113c23          	sd	ra,24(sp)
    80002d60:	00813823          	sd	s0,16(sp)
    80002d64:	00913423          	sd	s1,8(sp)
    80002d68:	02010413          	addi	s0,sp,32
    80002d6c:	00006797          	auipc	a5,0x6
    80002d70:	33478793          	addi	a5,a5,820 # 800090a0 <_ZTV6Thread+0x10>
    80002d74:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002d78:	00853483          	ld	s1,8(a0)
    80002d7c:	00048e63          	beqz	s1,80002d98 <_ZN6ThreadD1Ev+0x40>
    80002d80:	00048513          	mv	a0,s1
    80002d84:	fffff097          	auipc	ra,0xfffff
    80002d88:	e00080e7          	jalr	-512(ra) # 80001b84 <_ZN3PCBD1Ev>
    80002d8c:	00048513          	mv	a0,s1
    80002d90:	fffff097          	auipc	ra,0xfffff
    80002d94:	e68080e7          	jalr	-408(ra) # 80001bf8 <_ZN3PCBdlEPv>
}
    80002d98:	01813083          	ld	ra,24(sp)
    80002d9c:	01013403          	ld	s0,16(sp)
    80002da0:	00813483          	ld	s1,8(sp)
    80002da4:	02010113          	addi	sp,sp,32
    80002da8:	00008067          	ret

0000000080002dac <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002dac:	ff010113          	addi	sp,sp,-16
    80002db0:	00113423          	sd	ra,8(sp)
    80002db4:	00813023          	sd	s0,0(sp)
    80002db8:	01010413          	addi	s0,sp,16
    80002dbc:	00006797          	auipc	a5,0x6
    80002dc0:	30c78793          	addi	a5,a5,780 # 800090c8 <_ZTV9Semaphore+0x10>
    80002dc4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002dc8:	00853503          	ld	a0,8(a0)
    80002dcc:	ffffe097          	auipc	ra,0xffffe
    80002dd0:	654080e7          	jalr	1620(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80002dd4:	00813083          	ld	ra,8(sp)
    80002dd8:	00013403          	ld	s0,0(sp)
    80002ddc:	01010113          	addi	sp,sp,16
    80002de0:	00008067          	ret

0000000080002de4 <_Znwm>:
void* operator new (size_t size) {
    80002de4:	ff010113          	addi	sp,sp,-16
    80002de8:	00113423          	sd	ra,8(sp)
    80002dec:	00813023          	sd	s0,0(sp)
    80002df0:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002df4:	ffffe097          	auipc	ra,0xffffe
    80002df8:	3a0080e7          	jalr	928(ra) # 80001194 <_Z9mem_allocm>
}
    80002dfc:	00813083          	ld	ra,8(sp)
    80002e00:	00013403          	ld	s0,0(sp)
    80002e04:	01010113          	addi	sp,sp,16
    80002e08:	00008067          	ret

0000000080002e0c <_Znam>:
void* operator new [](size_t size) {
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00113423          	sd	ra,8(sp)
    80002e14:	00813023          	sd	s0,0(sp)
    80002e18:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002e1c:	ffffe097          	auipc	ra,0xffffe
    80002e20:	378080e7          	jalr	888(ra) # 80001194 <_Z9mem_allocm>
}
    80002e24:	00813083          	ld	ra,8(sp)
    80002e28:	00013403          	ld	s0,0(sp)
    80002e2c:	01010113          	addi	sp,sp,16
    80002e30:	00008067          	ret

0000000080002e34 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80002e34:	ff010113          	addi	sp,sp,-16
    80002e38:	00113423          	sd	ra,8(sp)
    80002e3c:	00813023          	sd	s0,0(sp)
    80002e40:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002e44:	ffffe097          	auipc	ra,0xffffe
    80002e48:	390080e7          	jalr	912(ra) # 800011d4 <_Z8mem_freePv>
}
    80002e4c:	00813083          	ld	ra,8(sp)
    80002e50:	00013403          	ld	s0,0(sp)
    80002e54:	01010113          	addi	sp,sp,16
    80002e58:	00008067          	ret

0000000080002e5c <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    80002e5c:	fe010113          	addi	sp,sp,-32
    80002e60:	00113c23          	sd	ra,24(sp)
    80002e64:	00813823          	sd	s0,16(sp)
    80002e68:	00913423          	sd	s1,8(sp)
    80002e6c:	02010413          	addi	s0,sp,32
    80002e70:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80002e74:	00053503          	ld	a0,0(a0)
    80002e78:	0104b783          	ld	a5,16(s1)
    80002e7c:	00f50533          	add	a0,a0,a5
    80002e80:	0084b783          	ld	a5,8(s1)
    80002e84:	0017f713          	andi	a4,a5,1
    80002e88:	00070863          	beqz	a4,80002e98 <_Z13threadWrapperPv+0x3c>
    80002e8c:	00053703          	ld	a4,0(a0)
    80002e90:	00f707b3          	add	a5,a4,a5
    80002e94:	fff7b783          	ld	a5,-1(a5)
    80002e98:	000780e7          	jalr	a5
    delete tArg;
    80002e9c:	00048863          	beqz	s1,80002eac <_Z13threadWrapperPv+0x50>
    80002ea0:	00048513          	mv	a0,s1
    80002ea4:	00000097          	auipc	ra,0x0
    80002ea8:	f90080e7          	jalr	-112(ra) # 80002e34 <_ZdlPv>
}
    80002eac:	01813083          	ld	ra,24(sp)
    80002eb0:	01013403          	ld	s0,16(sp)
    80002eb4:	00813483          	ld	s1,8(sp)
    80002eb8:	02010113          	addi	sp,sp,32
    80002ebc:	00008067          	ret

0000000080002ec0 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80002ec0:	ff010113          	addi	sp,sp,-16
    80002ec4:	00113423          	sd	ra,8(sp)
    80002ec8:	00813023          	sd	s0,0(sp)
    80002ecc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80002ed0:	ffffe097          	auipc	ra,0xffffe
    80002ed4:	304080e7          	jalr	772(ra) # 800011d4 <_Z8mem_freePv>
}
    80002ed8:	00813083          	ld	ra,8(sp)
    80002edc:	00013403          	ld	s0,0(sp)
    80002ee0:	01010113          	addi	sp,sp,16
    80002ee4:	00008067          	ret

0000000080002ee8 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002ee8:	ff010113          	addi	sp,sp,-16
    80002eec:	00113423          	sd	ra,8(sp)
    80002ef0:	00813023          	sd	s0,0(sp)
    80002ef4:	01010413          	addi	s0,sp,16
    80002ef8:	00006797          	auipc	a5,0x6
    80002efc:	1a878793          	addi	a5,a5,424 # 800090a0 <_ZTV6Thread+0x10>
    80002f00:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002f04:	00850513          	addi	a0,a0,8
    80002f08:	ffffe097          	auipc	ra,0xffffe
    80002f0c:	300080e7          	jalr	768(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002f10:	00813083          	ld	ra,8(sp)
    80002f14:	00013403          	ld	s0,0(sp)
    80002f18:	01010113          	addi	sp,sp,16
    80002f1c:	00008067          	ret

0000000080002f20 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80002f20:	ff010113          	addi	sp,sp,-16
    80002f24:	00113423          	sd	ra,8(sp)
    80002f28:	00813023          	sd	s0,0(sp)
    80002f2c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002f30:	00001097          	auipc	ra,0x1
    80002f34:	258080e7          	jalr	600(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002f38:	00813083          	ld	ra,8(sp)
    80002f3c:	00013403          	ld	s0,0(sp)
    80002f40:	01010113          	addi	sp,sp,16
    80002f44:	00008067          	ret

0000000080002f48 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002f48:	ff010113          	addi	sp,sp,-16
    80002f4c:	00113423          	sd	ra,8(sp)
    80002f50:	00813023          	sd	s0,0(sp)
    80002f54:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002f58:	00001097          	auipc	ra,0x1
    80002f5c:	3a0080e7          	jalr	928(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002f60:	00813083          	ld	ra,8(sp)
    80002f64:	00013403          	ld	s0,0(sp)
    80002f68:	01010113          	addi	sp,sp,16
    80002f6c:	00008067          	ret

0000000080002f70 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002f70:	fe010113          	addi	sp,sp,-32
    80002f74:	00113c23          	sd	ra,24(sp)
    80002f78:	00813823          	sd	s0,16(sp)
    80002f7c:	00913423          	sd	s1,8(sp)
    80002f80:	02010413          	addi	s0,sp,32
    80002f84:	00050493          	mv	s1,a0
}
    80002f88:	00000097          	auipc	ra,0x0
    80002f8c:	dd0080e7          	jalr	-560(ra) # 80002d58 <_ZN6ThreadD1Ev>
    80002f90:	00048513          	mv	a0,s1
    80002f94:	00000097          	auipc	ra,0x0
    80002f98:	fb4080e7          	jalr	-76(ra) # 80002f48 <_ZN6ThreaddlEPv>
    80002f9c:	01813083          	ld	ra,24(sp)
    80002fa0:	01013403          	ld	s0,16(sp)
    80002fa4:	00813483          	ld	s1,8(sp)
    80002fa8:	02010113          	addi	sp,sp,32
    80002fac:	00008067          	ret

0000000080002fb0 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002fb0:	ff010113          	addi	sp,sp,-16
    80002fb4:	00113423          	sd	ra,8(sp)
    80002fb8:	00813023          	sd	s0,0(sp)
    80002fbc:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002fc0:	ffffe097          	auipc	ra,0xffffe
    80002fc4:	2b4080e7          	jalr	692(ra) # 80001274 <_Z15thread_dispatchv>
}
    80002fc8:	00813083          	ld	ra,8(sp)
    80002fcc:	00013403          	ld	s0,0(sp)
    80002fd0:	01010113          	addi	sp,sp,16
    80002fd4:	00008067          	ret

0000000080002fd8 <_ZN6Thread5startEv>:
int Thread::start() {
    80002fd8:	ff010113          	addi	sp,sp,-16
    80002fdc:	00113423          	sd	ra,8(sp)
    80002fe0:	00813023          	sd	s0,0(sp)
    80002fe4:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002fe8:	00850513          	addi	a0,a0,8
    80002fec:	ffffe097          	auipc	ra,0xffffe
    80002ff0:	2e4080e7          	jalr	740(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    80002ff4:	00000513          	li	a0,0
    80002ff8:	00813083          	ld	ra,8(sp)
    80002ffc:	00013403          	ld	s0,0(sp)
    80003000:	01010113          	addi	sp,sp,16
    80003004:	00008067          	ret

0000000080003008 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003008:	fe010113          	addi	sp,sp,-32
    8000300c:	00113c23          	sd	ra,24(sp)
    80003010:	00813823          	sd	s0,16(sp)
    80003014:	00913423          	sd	s1,8(sp)
    80003018:	02010413          	addi	s0,sp,32
    8000301c:	00050493          	mv	s1,a0
    80003020:	00006797          	auipc	a5,0x6
    80003024:	08078793          	addi	a5,a5,128 # 800090a0 <_ZTV6Thread+0x10>
    80003028:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    8000302c:	01800513          	li	a0,24
    80003030:	00000097          	auipc	ra,0x0
    80003034:	db4080e7          	jalr	-588(ra) # 80002de4 <_Znwm>
    80003038:	00050613          	mv	a2,a0
    8000303c:	00953023          	sd	s1,0(a0)
    80003040:	01100793          	li	a5,17
    80003044:	00f53423          	sd	a5,8(a0)
    80003048:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    8000304c:	00000597          	auipc	a1,0x0
    80003050:	e1058593          	addi	a1,a1,-496 # 80002e5c <_Z13threadWrapperPv>
    80003054:	00848513          	addi	a0,s1,8
    80003058:	ffffe097          	auipc	ra,0xffffe
    8000305c:	1b0080e7          	jalr	432(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80003060:	01813083          	ld	ra,24(sp)
    80003064:	01013403          	ld	s0,16(sp)
    80003068:	00813483          	ld	s1,8(sp)
    8000306c:	02010113          	addi	sp,sp,32
    80003070:	00008067          	ret

0000000080003074 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003074:	ff010113          	addi	sp,sp,-16
    80003078:	00113423          	sd	ra,8(sp)
    8000307c:	00813023          	sd	s0,0(sp)
    80003080:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003084:	ffffe097          	auipc	ra,0xffffe
    80003088:	3dc080e7          	jalr	988(ra) # 80001460 <_Z10time_sleepm>
}
    8000308c:	00813083          	ld	ra,8(sp)
    80003090:	00013403          	ld	s0,0(sp)
    80003094:	01010113          	addi	sp,sp,16
    80003098:	00008067          	ret

000000008000309c <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    8000309c:	fe010113          	addi	sp,sp,-32
    800030a0:	00113c23          	sd	ra,24(sp)
    800030a4:	00813823          	sd	s0,16(sp)
    800030a8:	00913423          	sd	s1,8(sp)
    800030ac:	02010413          	addi	s0,sp,32
    800030b0:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    800030b4:	0200006f          	j	800030d4 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800030b8:	00053703          	ld	a4,0(a0)
    800030bc:	00f707b3          	add	a5,a4,a5
    800030c0:	fff7b783          	ld	a5,-1(a5)
    800030c4:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    800030c8:	0184b503          	ld	a0,24(s1)
    800030cc:	00000097          	auipc	ra,0x0
    800030d0:	fa8080e7          	jalr	-88(ra) # 80003074 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800030d4:	0004b503          	ld	a0,0(s1)
    800030d8:	0104b783          	ld	a5,16(s1)
    800030dc:	00f50533          	add	a0,a0,a5
    800030e0:	0084b783          	ld	a5,8(s1)
    800030e4:	0017f713          	andi	a4,a5,1
    800030e8:	fc070ee3          	beqz	a4,800030c4 <_Z21periodicThreadWrapperPv+0x28>
    800030ec:	fcdff06f          	j	800030b8 <_Z21periodicThreadWrapperPv+0x1c>

00000000800030f0 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800030f0:	fe010113          	addi	sp,sp,-32
    800030f4:	00113c23          	sd	ra,24(sp)
    800030f8:	00813823          	sd	s0,16(sp)
    800030fc:	00913423          	sd	s1,8(sp)
    80003100:	02010413          	addi	s0,sp,32
    80003104:	00050493          	mv	s1,a0
    80003108:	00006797          	auipc	a5,0x6
    8000310c:	fc078793          	addi	a5,a5,-64 # 800090c8 <_ZTV9Semaphore+0x10>
    80003110:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80003114:	00058513          	mv	a0,a1
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	518080e7          	jalr	1304(ra) # 80003630 <_ZN3SCB15createSemaphoreEi>
    80003120:	00a4b423          	sd	a0,8(s1)
}
    80003124:	01813083          	ld	ra,24(sp)
    80003128:	01013403          	ld	s0,16(sp)
    8000312c:	00813483          	ld	s1,8(sp)
    80003130:	02010113          	addi	sp,sp,32
    80003134:	00008067          	ret

0000000080003138 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80003138:	ff010113          	addi	sp,sp,-16
    8000313c:	00113423          	sd	ra,8(sp)
    80003140:	00813023          	sd	s0,0(sp)
    80003144:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003148:	00853503          	ld	a0,8(a0)
    8000314c:	ffffe097          	auipc	ra,0xffffe
    80003150:	24c080e7          	jalr	588(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80003154:	00813083          	ld	ra,8(sp)
    80003158:	00013403          	ld	s0,0(sp)
    8000315c:	01010113          	addi	sp,sp,16
    80003160:	00008067          	ret

0000000080003164 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00113423          	sd	ra,8(sp)
    8000316c:	00813023          	sd	s0,0(sp)
    80003170:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003174:	00853503          	ld	a0,8(a0)
    80003178:	ffffe097          	auipc	ra,0xffffe
    8000317c:	268080e7          	jalr	616(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80003180:	00813083          	ld	ra,8(sp)
    80003184:	00013403          	ld	s0,0(sp)
    80003188:	01010113          	addi	sp,sp,16
    8000318c:	00008067          	ret

0000000080003190 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80003190:	ff010113          	addi	sp,sp,-16
    80003194:	00113423          	sd	ra,8(sp)
    80003198:	00813023          	sd	s0,0(sp)
    8000319c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800031a0:	00001097          	auipc	ra,0x1
    800031a4:	158080e7          	jalr	344(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800031a8:	00813083          	ld	ra,8(sp)
    800031ac:	00013403          	ld	s0,0(sp)
    800031b0:	01010113          	addi	sp,sp,16
    800031b4:	00008067          	ret

00000000800031b8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    800031b8:	fe010113          	addi	sp,sp,-32
    800031bc:	00113c23          	sd	ra,24(sp)
    800031c0:	00813823          	sd	s0,16(sp)
    800031c4:	00913423          	sd	s1,8(sp)
    800031c8:	02010413          	addi	s0,sp,32
    800031cc:	00050493          	mv	s1,a0
}
    800031d0:	00000097          	auipc	ra,0x0
    800031d4:	bdc080e7          	jalr	-1060(ra) # 80002dac <_ZN9SemaphoreD1Ev>
    800031d8:	00048513          	mv	a0,s1
    800031dc:	00000097          	auipc	ra,0x0
    800031e0:	fb4080e7          	jalr	-76(ra) # 80003190 <_ZN9SemaphoredlEPv>
    800031e4:	01813083          	ld	ra,24(sp)
    800031e8:	01013403          	ld	s0,16(sp)
    800031ec:	00813483          	ld	s1,8(sp)
    800031f0:	02010113          	addi	sp,sp,32
    800031f4:	00008067          	ret

00000000800031f8 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    800031f8:	ff010113          	addi	sp,sp,-16
    800031fc:	00113423          	sd	ra,8(sp)
    80003200:	00813023          	sd	s0,0(sp)
    80003204:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80003208:	00001097          	auipc	ra,0x1
    8000320c:	f80080e7          	jalr	-128(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003210:	00813083          	ld	ra,8(sp)
    80003214:	00013403          	ld	s0,0(sp)
    80003218:	01010113          	addi	sp,sp,16
    8000321c:	00008067          	ret

0000000080003220 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    80003220:	fe010113          	addi	sp,sp,-32
    80003224:	00113c23          	sd	ra,24(sp)
    80003228:	00813823          	sd	s0,16(sp)
    8000322c:	00913423          	sd	s1,8(sp)
    80003230:	01213023          	sd	s2,0(sp)
    80003234:	02010413          	addi	s0,sp,32
    80003238:	00050493          	mv	s1,a0
    8000323c:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80003240:	02000513          	li	a0,32
    80003244:	00000097          	auipc	ra,0x0
    80003248:	ba0080e7          	jalr	-1120(ra) # 80002de4 <_Znwm>
    8000324c:	00050613          	mv	a2,a0
    80003250:	00953023          	sd	s1,0(a0)
    80003254:	01900793          	li	a5,25
    80003258:	00f53423          	sd	a5,8(a0)
    8000325c:	00053823          	sd	zero,16(a0)
    80003260:	01253c23          	sd	s2,24(a0)
    80003264:	00000597          	auipc	a1,0x0
    80003268:	e3858593          	addi	a1,a1,-456 # 8000309c <_Z21periodicThreadWrapperPv>
    8000326c:	00048513          	mv	a0,s1
    80003270:	00000097          	auipc	ra,0x0
    80003274:	c78080e7          	jalr	-904(ra) # 80002ee8 <_ZN6ThreadC1EPFvPvES0_>
    80003278:	00006797          	auipc	a5,0x6
    8000327c:	df878793          	addi	a5,a5,-520 # 80009070 <_ZTV14PeriodicThread+0x10>
    80003280:	00f4b023          	sd	a5,0(s1)
{}
    80003284:	01813083          	ld	ra,24(sp)
    80003288:	01013403          	ld	s0,16(sp)
    8000328c:	00813483          	ld	s1,8(sp)
    80003290:	00013903          	ld	s2,0(sp)
    80003294:	02010113          	addi	sp,sp,32
    80003298:	00008067          	ret

000000008000329c <_ZN7Console4getcEv>:


char Console::getc() {
    8000329c:	ff010113          	addi	sp,sp,-16
    800032a0:	00113423          	sd	ra,8(sp)
    800032a4:	00813023          	sd	s0,0(sp)
    800032a8:	01010413          	addi	s0,sp,16
    return ::getc();
    800032ac:	ffffe097          	auipc	ra,0xffffe
    800032b0:	1fc080e7          	jalr	508(ra) # 800014a8 <_Z4getcv>
}
    800032b4:	00813083          	ld	ra,8(sp)
    800032b8:	00013403          	ld	s0,0(sp)
    800032bc:	01010113          	addi	sp,sp,16
    800032c0:	00008067          	ret

00000000800032c4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800032c4:	ff010113          	addi	sp,sp,-16
    800032c8:	00113423          	sd	ra,8(sp)
    800032cc:	00813023          	sd	s0,0(sp)
    800032d0:	01010413          	addi	s0,sp,16
    return ::putc(c);
    800032d4:	ffffe097          	auipc	ra,0xffffe
    800032d8:	204080e7          	jalr	516(ra) # 800014d8 <_Z4putcc>
}
    800032dc:	00813083          	ld	ra,8(sp)
    800032e0:	00013403          	ld	s0,0(sp)
    800032e4:	01010113          	addi	sp,sp,16
    800032e8:	00008067          	ret

00000000800032ec <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    800032ec:	ff010113          	addi	sp,sp,-16
    800032f0:	00813423          	sd	s0,8(sp)
    800032f4:	01010413          	addi	s0,sp,16
    800032f8:	00813403          	ld	s0,8(sp)
    800032fc:	01010113          	addi	sp,sp,16
    80003300:	00008067          	ret

0000000080003304 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80003304:	ff010113          	addi	sp,sp,-16
    80003308:	00813423          	sd	s0,8(sp)
    8000330c:	01010413          	addi	s0,sp,16
    80003310:	00813403          	ld	s0,8(sp)
    80003314:	01010113          	addi	sp,sp,16
    80003318:	00008067          	ret

000000008000331c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    8000331c:	ff010113          	addi	sp,sp,-16
    80003320:	00113423          	sd	ra,8(sp)
    80003324:	00813023          	sd	s0,0(sp)
    80003328:	01010413          	addi	s0,sp,16
    8000332c:	00006797          	auipc	a5,0x6
    80003330:	d4478793          	addi	a5,a5,-700 # 80009070 <_ZTV14PeriodicThread+0x10>
    80003334:	00f53023          	sd	a5,0(a0)
    80003338:	00000097          	auipc	ra,0x0
    8000333c:	a20080e7          	jalr	-1504(ra) # 80002d58 <_ZN6ThreadD1Ev>
    80003340:	00813083          	ld	ra,8(sp)
    80003344:	00013403          	ld	s0,0(sp)
    80003348:	01010113          	addi	sp,sp,16
    8000334c:	00008067          	ret

0000000080003350 <_ZN14PeriodicThreadD0Ev>:
    80003350:	fe010113          	addi	sp,sp,-32
    80003354:	00113c23          	sd	ra,24(sp)
    80003358:	00813823          	sd	s0,16(sp)
    8000335c:	00913423          	sd	s1,8(sp)
    80003360:	02010413          	addi	s0,sp,32
    80003364:	00050493          	mv	s1,a0
    80003368:	00006797          	auipc	a5,0x6
    8000336c:	d0878793          	addi	a5,a5,-760 # 80009070 <_ZTV14PeriodicThread+0x10>
    80003370:	00f53023          	sd	a5,0(a0)
    80003374:	00000097          	auipc	ra,0x0
    80003378:	9e4080e7          	jalr	-1564(ra) # 80002d58 <_ZN6ThreadD1Ev>
    8000337c:	00048513          	mv	a0,s1
    80003380:	00000097          	auipc	ra,0x0
    80003384:	bc8080e7          	jalr	-1080(ra) # 80002f48 <_ZN6ThreaddlEPv>
    80003388:	01813083          	ld	ra,24(sp)
    8000338c:	01013403          	ld	s0,16(sp)
    80003390:	00813483          	ld	s1,8(sp)
    80003394:	02010113          	addi	sp,sp,32
    80003398:	00008067          	ret

000000008000339c <_ZN3SCB5blockEv>:
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

kmem_cache_t* SCB::scbCache = nullptr;

void SCB::block() {
    8000339c:	ff010113          	addi	sp,sp,-16
    800033a0:	00813423          	sd	s0,8(sp)
    800033a4:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    800033a8:	00006797          	auipc	a5,0x6
    800033ac:	e007b783          	ld	a5,-512(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033b0:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    800033b4:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800033b8:	00853783          	ld	a5,8(a0)
    800033bc:	04078063          	beqz	a5,800033fc <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    800033c0:	00006717          	auipc	a4,0x6
    800033c4:	de873703          	ld	a4,-536(a4) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033c8:	00073703          	ld	a4,0(a4)
    800033cc:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    800033d0:	00853783          	ld	a5,8(a0)
        return nextInList;
    800033d4:	0007b783          	ld	a5,0(a5)
    800033d8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    800033dc:	00006797          	auipc	a5,0x6
    800033e0:	dcc7b783          	ld	a5,-564(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    800033e4:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    800033e8:	00100713          	li	a4,1
    800033ec:	02e784a3          	sb	a4,41(a5)
}
    800033f0:	00813403          	ld	s0,8(sp)
    800033f4:	01010113          	addi	sp,sp,16
    800033f8:	00008067          	ret
        head = tail = PCB::running;
    800033fc:	00006797          	auipc	a5,0x6
    80003400:	dac7b783          	ld	a5,-596(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003404:	0007b783          	ld	a5,0(a5)
    80003408:	00f53423          	sd	a5,8(a0)
    8000340c:	00f53023          	sd	a5,0(a0)
    80003410:	fcdff06f          	j	800033dc <_ZN3SCB5blockEv+0x40>

0000000080003414 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80003414:	ff010113          	addi	sp,sp,-16
    80003418:	00813423          	sd	s0,8(sp)
    8000341c:	01010413          	addi	s0,sp,16
    80003420:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80003424:	00053503          	ld	a0,0(a0)
    80003428:	00050e63          	beqz	a0,80003444 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    8000342c:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80003430:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80003434:	0087b683          	ld	a3,8(a5)
    80003438:	00d50c63          	beq	a0,a3,80003450 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    8000343c:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80003440:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80003444:	00813403          	ld	s0,8(sp)
    80003448:	01010113          	addi	sp,sp,16
    8000344c:	00008067          	ret
        tail = head;
    80003450:	00e7b423          	sd	a4,8(a5)
    80003454:	fe9ff06f          	j	8000343c <_ZN3SCB7unblockEv+0x28>

0000000080003458 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003458:	01052783          	lw	a5,16(a0)
    8000345c:	fff7879b          	addiw	a5,a5,-1
    80003460:	00f52823          	sw	a5,16(a0)
    80003464:	02079713          	slli	a4,a5,0x20
    80003468:	02074063          	bltz	a4,80003488 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000346c:	00006797          	auipc	a5,0x6
    80003470:	d3c7b783          	ld	a5,-708(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003474:	0007b783          	ld	a5,0(a5)
    80003478:	02a7c783          	lbu	a5,42(a5)
    8000347c:	06079463          	bnez	a5,800034e4 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003480:	00000513          	li	a0,0
    80003484:	00008067          	ret
int SCB::wait() {
    80003488:	ff010113          	addi	sp,sp,-16
    8000348c:	00113423          	sd	ra,8(sp)
    80003490:	00813023          	sd	s0,0(sp)
    80003494:	01010413          	addi	s0,sp,16
        block();
    80003498:	00000097          	auipc	ra,0x0
    8000349c:	f04080e7          	jalr	-252(ra) # 8000339c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    800034a0:	00006797          	auipc	a5,0x6
    800034a4:	ce07b783          	ld	a5,-800(a5) # 80009180 <_GLOBAL_OFFSET_TABLE_+0x40>
    800034a8:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    800034ac:	ffffe097          	auipc	ra,0xffffe
    800034b0:	648080e7          	jalr	1608(ra) # 80001af4 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    800034b4:	00006797          	auipc	a5,0x6
    800034b8:	cf47b783          	ld	a5,-780(a5) # 800091a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    800034bc:	0007b783          	ld	a5,0(a5)
    800034c0:	02a7c783          	lbu	a5,42(a5)
    800034c4:	00079c63          	bnez	a5,800034dc <_ZN3SCB4waitEv+0x84>
    return 0;
    800034c8:	00000513          	li	a0,0

}
    800034cc:	00813083          	ld	ra,8(sp)
    800034d0:	00013403          	ld	s0,0(sp)
    800034d4:	01010113          	addi	sp,sp,16
    800034d8:	00008067          	ret
        return -2;
    800034dc:	ffe00513          	li	a0,-2
    800034e0:	fedff06f          	j	800034cc <_ZN3SCB4waitEv+0x74>
    800034e4:	ffe00513          	li	a0,-2
}
    800034e8:	00008067          	ret

00000000800034ec <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    800034ec:	01052783          	lw	a5,16(a0)
    800034f0:	0017879b          	addiw	a5,a5,1
    800034f4:	0007871b          	sext.w	a4,a5
    800034f8:	00f52823          	sw	a5,16(a0)
    800034fc:	00e05463          	blez	a4,80003504 <_ZN3SCB6signalEv+0x18>
    80003500:	00008067          	ret
void SCB::signal() {
    80003504:	ff010113          	addi	sp,sp,-16
    80003508:	00113423          	sd	ra,8(sp)
    8000350c:	00813023          	sd	s0,0(sp)
    80003510:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    80003514:	00000097          	auipc	ra,0x0
    80003518:	f00080e7          	jalr	-256(ra) # 80003414 <_ZN3SCB7unblockEv>
    8000351c:	fffff097          	auipc	ra,0xfffff
    80003520:	554080e7          	jalr	1364(ra) # 80002a70 <_ZN9Scheduler3putEP3PCB>
    }

}
    80003524:	00813083          	ld	ra,8(sp)
    80003528:	00013403          	ld	s0,0(sp)
    8000352c:	01010113          	addi	sp,sp,16
    80003530:	00008067          	ret

0000000080003534 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    80003534:	01052783          	lw	a5,16(a0)
    80003538:	0017879b          	addiw	a5,a5,1
    8000353c:	0007871b          	sext.w	a4,a5
    80003540:	00f52823          	sw	a5,16(a0)
    80003544:	00e05463          	blez	a4,8000354c <_ZN3SCB14prioritySignalEv+0x18>
    80003548:	00008067          	ret
void SCB::prioritySignal() {
    8000354c:	ff010113          	addi	sp,sp,-16
    80003550:	00113423          	sd	ra,8(sp)
    80003554:	00813023          	sd	s0,0(sp)
    80003558:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	eb8080e7          	jalr	-328(ra) # 80003414 <_ZN3SCB7unblockEv>
    80003564:	fffff097          	auipc	ra,0xfffff
    80003568:	5b8080e7          	jalr	1464(ra) # 80002b1c <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000356c:	00813083          	ld	ra,8(sp)
    80003570:	00013403          	ld	s0,0(sp)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000357c:	ff010113          	addi	sp,sp,-16
    80003580:	00113423          	sd	ra,8(sp)
    80003584:	00813023          	sd	s0,0(sp)
    80003588:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000358c:	00001097          	auipc	ra,0x1
    80003590:	bfc080e7          	jalr	-1028(ra) # 80004188 <_ZN15MemoryAllocator9mem_allocEm>
}
    80003594:	00813083          	ld	ra,8(sp)
    80003598:	00013403          	ld	s0,0(sp)
    8000359c:	01010113          	addi	sp,sp,16
    800035a0:	00008067          	ret

00000000800035a4 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    800035a4:	ff010113          	addi	sp,sp,-16
    800035a8:	00113423          	sd	ra,8(sp)
    800035ac:	00813023          	sd	s0,0(sp)
    800035b0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800035b4:	00001097          	auipc	ra,0x1
    800035b8:	d44080e7          	jalr	-700(ra) # 800042f8 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800035bc:	00813083          	ld	ra,8(sp)
    800035c0:	00013403          	ld	s0,0(sp)
    800035c4:	01010113          	addi	sp,sp,16
    800035c8:	00008067          	ret

00000000800035cc <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800035cc:	fe010113          	addi	sp,sp,-32
    800035d0:	00113c23          	sd	ra,24(sp)
    800035d4:	00813823          	sd	s0,16(sp)
    800035d8:	00913423          	sd	s1,8(sp)
    800035dc:	01213023          	sd	s2,0(sp)
    800035e0:	02010413          	addi	s0,sp,32
    800035e4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800035e8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800035ec:	02050263          	beqz	a0,80003610 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800035f0:	00100793          	li	a5,1
    800035f4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800035f8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800035fc:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80003600:	fffff097          	auipc	ra,0xfffff
    80003604:	470080e7          	jalr	1136(ra) # 80002a70 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80003608:	00048513          	mv	a0,s1
    while(curr) {
    8000360c:	fe1ff06f          	j	800035ec <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80003610:	00093423          	sd	zero,8(s2)
    80003614:	00093023          	sd	zero,0(s2)
}
    80003618:	01813083          	ld	ra,24(sp)
    8000361c:	01013403          	ld	s0,16(sp)
    80003620:	00813483          	ld	s1,8(sp)
    80003624:	00013903          	ld	s2,0(sp)
    80003628:	02010113          	addi	sp,sp,32
    8000362c:	00008067          	ret

0000000080003630 <_ZN3SCB15createSemaphoreEi>:
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    object->scbInit(semValue);
    return object;
}

SCB *SCB::createSemaphore(int semValue) {
    80003630:	fe010113          	addi	sp,sp,-32
    80003634:	00113c23          	sd	ra,24(sp)
    80003638:	00813823          	sd	s0,16(sp)
    8000363c:	00913423          	sd	s1,8(sp)
    80003640:	02010413          	addi	s0,sp,32
    80003644:	00050493          	mv	s1,a0
    return new SCB(semValue);
    80003648:	01800513          	li	a0,24
    8000364c:	00000097          	auipc	ra,0x0
    80003650:	f30080e7          	jalr	-208(ra) # 8000357c <_ZN3SCBnwEm>
    static kmem_cache_t* scbCache;//TODO private
    static void initSCBCache();
private:

    void scbInit(int semValue);
    SCB(int semValue_ = 1) {
    80003654:	00053023          	sd	zero,0(a0)
    80003658:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000365c:	00952823          	sw	s1,16(a0)
}
    80003660:	01813083          	ld	ra,24(sp)
    80003664:	01013403          	ld	s0,16(sp)
    80003668:	00813483          	ld	s1,8(sp)
    8000366c:	02010113          	addi	sp,sp,32
    80003670:	00008067          	ret

0000000080003674 <_ZN3SCB7scbInitEi>:

void SCB::scbInit(int semValue_) {
    80003674:	ff010113          	addi	sp,sp,-16
    80003678:	00813423          	sd	s0,8(sp)
    8000367c:	01010413          	addi	s0,sp,16
    head = tail = nullptr;
    80003680:	00053423          	sd	zero,8(a0)
    80003684:	00053023          	sd	zero,0(a0)
    semValue = semValue_;
    80003688:	00b52823          	sw	a1,16(a0)
}
    8000368c:	00813403          	ld	s0,8(sp)
    80003690:	01010113          	addi	sp,sp,16
    80003694:	00008067          	ret

0000000080003698 <_ZN3SCB12initSCBCacheEv>:

void SCB::initSCBCache() {
    80003698:	ff010113          	addi	sp,sp,-16
    8000369c:	00113423          	sd	ra,8(sp)
    800036a0:	00813023          	sd	s0,0(sp)
    800036a4:	01010413          	addi	s0,sp,16
    scbCache = kmem_cache_create("SCB", sizeof(SCB), &createObject, &freeObject);
    800036a8:	00000697          	auipc	a3,0x0
    800036ac:	0c468693          	addi	a3,a3,196 # 8000376c <_ZN3SCB10freeObjectEPv>
    800036b0:	00000617          	auipc	a2,0x0
    800036b4:	0a460613          	addi	a2,a2,164 # 80003754 <_ZN3SCB12createObjectEPv>
    800036b8:	01800593          	li	a1,24
    800036bc:	00004517          	auipc	a0,0x4
    800036c0:	a9c50513          	addi	a0,a0,-1380 # 80007158 <CONSOLE_STATUS+0x148>
    800036c4:	00001097          	auipc	ra,0x1
    800036c8:	e10080e7          	jalr	-496(ra) # 800044d4 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800036cc:	00006797          	auipc	a5,0x6
    800036d0:	c4a7be23          	sd	a0,-932(a5) # 80009328 <_ZN3SCB8scbCacheE>
}
    800036d4:	00813083          	ld	ra,8(sp)
    800036d8:	00013403          	ld	s0,0(sp)
    800036dc:	01010113          	addi	sp,sp,16
    800036e0:	00008067          	ret

00000000800036e4 <_ZN3SCB18createSysSemaphoreEi>:
SCB *SCB::createSysSemaphore(int semValue) {
    800036e4:	fe010113          	addi	sp,sp,-32
    800036e8:	00113c23          	sd	ra,24(sp)
    800036ec:	00813823          	sd	s0,16(sp)
    800036f0:	00913423          	sd	s1,8(sp)
    800036f4:	01213023          	sd	s2,0(sp)
    800036f8:	02010413          	addi	s0,sp,32
    800036fc:	00050913          	mv	s2,a0
    if(!scbCache) initSCBCache();
    80003700:	00006797          	auipc	a5,0x6
    80003704:	c287b783          	ld	a5,-984(a5) # 80009328 <_ZN3SCB8scbCacheE>
    80003708:	04078063          	beqz	a5,80003748 <_ZN3SCB18createSysSemaphoreEi+0x64>
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    8000370c:	00006517          	auipc	a0,0x6
    80003710:	c1c53503          	ld	a0,-996(a0) # 80009328 <_ZN3SCB8scbCacheE>
    80003714:	00001097          	auipc	ra,0x1
    80003718:	e10080e7          	jalr	-496(ra) # 80004524 <_Z16kmem_cache_allocP12kmem_cache_s>
    8000371c:	00050493          	mv	s1,a0
    object->scbInit(semValue);
    80003720:	00090593          	mv	a1,s2
    80003724:	00000097          	auipc	ra,0x0
    80003728:	f50080e7          	jalr	-176(ra) # 80003674 <_ZN3SCB7scbInitEi>
}
    8000372c:	00048513          	mv	a0,s1
    80003730:	01813083          	ld	ra,24(sp)
    80003734:	01013403          	ld	s0,16(sp)
    80003738:	00813483          	ld	s1,8(sp)
    8000373c:	00013903          	ld	s2,0(sp)
    80003740:	02010113          	addi	sp,sp,32
    80003744:	00008067          	ret
    if(!scbCache) initSCBCache();
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	f50080e7          	jalr	-176(ra) # 80003698 <_ZN3SCB12initSCBCacheEv>
    80003750:	fbdff06f          	j	8000370c <_ZN3SCB18createSysSemaphoreEi+0x28>

0000000080003754 <_ZN3SCB12createObjectEPv>:
    static void createObject(void* addr) {}
    80003754:	ff010113          	addi	sp,sp,-16
    80003758:	00813423          	sd	s0,8(sp)
    8000375c:	01010413          	addi	s0,sp,16
    80003760:	00813403          	ld	s0,8(sp)
    80003764:	01010113          	addi	sp,sp,16
    80003768:	00008067          	ret

000000008000376c <_ZN3SCB10freeObjectEPv>:
    static void freeObject(void* addr) {}
    8000376c:	ff010113          	addi	sp,sp,-16
    80003770:	00813423          	sd	s0,8(sp)
    80003774:	01010413          	addi	s0,sp,16
    80003778:	00813403          	ld	s0,8(sp)
    8000377c:	01010113          	addi	sp,sp,16
    80003780:	00008067          	ret

0000000080003784 <_ZN5Cache11getNumSlotsEmm>:
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima

    optimalSlots = getNumSlots(slabSize, slotSize);
}

int Cache::getNumSlots(size_t slabSize, size_t objSize) {
    80003784:	ff010113          	addi	sp,sp,-16
    80003788:	00813423          	sd	s0,8(sp)
    8000378c:	01010413          	addi	s0,sp,16
    return (slabSize*BLKSIZE - sizeof(Slab)) / objSize;
    80003790:	00c51513          	slli	a0,a0,0xc
    80003794:	fd850513          	addi	a0,a0,-40
    80003798:	02b55533          	divu	a0,a0,a1
}
    8000379c:	0005051b          	sext.w	a0,a0
    800037a0:	00813403          	ld	s0,8(sp)
    800037a4:	01010113          	addi	sp,sp,16
    800037a8:	00008067          	ret

00000000800037ac <_ZN5Cache11slabListPutEPNS_4SlabEi>:

    return slab;
}


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    800037ac:	ff010113          	addi	sp,sp,-16
    800037b0:	00813423          	sd	s0,8(sp)
    800037b4:	01010413          	addi	s0,sp,16
    if (!slab || listNum < 0 || listNum > 2) return;
    800037b8:	02058a63          	beqz	a1,800037ec <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    800037bc:	02064863          	bltz	a2,800037ec <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    800037c0:	00200793          	li	a5,2
    800037c4:	02c7c463          	blt	a5,a2,800037ec <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    slab->state = (SlabState)listNum;
    800037c8:	00c5a823          	sw	a2,16(a1)
    if(slabList[listNum]) {
    800037cc:	00361793          	slli	a5,a2,0x3
    800037d0:	00f507b3          	add	a5,a0,a5
    800037d4:	0087b783          	ld	a5,8(a5)
    800037d8:	00078463          	beqz	a5,800037e0 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x34>
        slab->next = slabList[listNum];
    800037dc:	00f5b423          	sd	a5,8(a1)
    }
    slabList[listNum] = slab;
    800037e0:	00361613          	slli	a2,a2,0x3
    800037e4:	00c50633          	add	a2,a0,a2
    800037e8:	00b63423          	sd	a1,8(a2)
}
    800037ec:	00813403          	ld	s0,8(sp)
    800037f0:	01010113          	addi	sp,sp,16
    800037f4:	00008067          	ret

00000000800037f8 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>:
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    800037f8:	ff010113          	addi	sp,sp,-16
    800037fc:	00813423          	sd	s0,8(sp)
    80003800:	01010413          	addi	s0,sp,16
    if(!slab || listNum < 0 || listNum > 2) return;
    80003804:	04058063          	beqz	a1,80003844 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    80003808:	02064e63          	bltz	a2,80003844 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
    8000380c:	00200793          	li	a5,2
    80003810:	02c7ca63          	blt	a5,a2,80003844 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003814:	00361613          	slli	a2,a2,0x3
    80003818:	00c50633          	add	a2,a0,a2
    8000381c:	00863783          	ld	a5,8(a2)
    Slab* prev = nullptr;
    80003820:	00000713          	li	a4,0
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003824:	02078063          	beqz	a5,80003844 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>
        if(curr == slab) {
    80003828:	00b78863          	beq	a5,a1,80003838 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x40>
            prev->next = curr->next;
            curr->next = nullptr;
            break;
        }
        prev = curr;
    8000382c:	00078713          	mv	a4,a5
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003830:	0087b783          	ld	a5,8(a5)
    80003834:	ff1ff06f          	j	80003824 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x2c>
            prev->next = curr->next;
    80003838:	0087b683          	ld	a3,8(a5)
    8000383c:	00d73423          	sd	a3,8(a4)
            curr->next = nullptr;
    80003840:	0007b423          	sd	zero,8(a5)
    }
}
    80003844:	00813403          	ld	s0,8(sp)
    80003848:	01010113          	addi	sp,sp,16
    8000384c:	00008067          	ret

0000000080003850 <_ZN5Cache17printErrorMessageEv>:

int Cache::printErrorMessage() {
    80003850:	fe010113          	addi	sp,sp,-32
    80003854:	00113c23          	sd	ra,24(sp)
    80003858:	00813823          	sd	s0,16(sp)
    8000385c:	00913423          	sd	s1,8(sp)
    80003860:	02010413          	addi	s0,sp,32
    80003864:	00050493          	mv	s1,a0
    switch(errortype) {
    80003868:	00052703          	lw	a4,0(a0)
    8000386c:	00100793          	li	a5,1
    80003870:	02f70663          	beq	a4,a5,8000389c <_ZN5Cache17printErrorMessageEv+0x4c>
        case FreeSlotError:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    80003874:	00004517          	auipc	a0,0x4
    80003878:	90c50513          	addi	a0,a0,-1780 # 80007180 <CONSOLE_STATUS+0x170>
    8000387c:	fffff097          	auipc	ra,0xfffff
    80003880:	f04080e7          	jalr	-252(ra) # 80002780 <_Z11printStringPKc>
    }
    return errortype;
}
    80003884:	0004a503          	lw	a0,0(s1)
    80003888:	01813083          	ld	ra,24(sp)
    8000388c:	01013403          	ld	s0,16(sp)
    80003890:	00813483          	ld	s1,8(sp)
    80003894:	02010113          	addi	sp,sp,32
    80003898:	00008067          	ret
            printString("Greska u oslobadjanju slota");
    8000389c:	00004517          	auipc	a0,0x4
    800038a0:	8c450513          	addi	a0,a0,-1852 # 80007160 <CONSOLE_STATUS+0x150>
    800038a4:	fffff097          	auipc	ra,0xfffff
    800038a8:	edc080e7          	jalr	-292(ra) # 80002780 <_Z11printStringPKc>
    800038ac:	fc9ff06f          	j	80003874 <_ZN5Cache17printErrorMessageEv+0x24>

00000000800038b0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>:
    printString(", ");
    printInt(numSlots);

}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    800038b0:	ff010113          	addi	sp,sp,-16
    800038b4:	00813423          	sd	s0,8(sp)
    800038b8:	01010413          	addi	s0,sp,16
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
    800038bc:	00000893          	li	a7,0
    int slabs = 0, slots = 0;
    800038c0:	00000713          	li	a4,0
    800038c4:	00000693          	li	a3,0
    800038c8:	0080006f          	j	800038d0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x20>
    for(int i = 0; i < 3; i++) {
    800038cc:	0018889b          	addiw	a7,a7,1
    800038d0:	00200793          	li	a5,2
    800038d4:	0317c463          	blt	a5,a7,800038fc <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x4c>
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    800038d8:	00389793          	slli	a5,a7,0x3
    800038dc:	00f507b3          	add	a5,a0,a5
    800038e0:	0087b783          	ld	a5,8(a5)
    800038e4:	fe0784e3          	beqz	a5,800038cc <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x1c>
             slabs++;
    800038e8:	0016869b          	addiw	a3,a3,1
             slots += curr->allocatedSlots;
    800038ec:	0007b803          	ld	a6,0(a5)
    800038f0:	00e8073b          	addw	a4,a6,a4
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    800038f4:	0087b783          	ld	a5,8(a5)
    800038f8:	fedff06f          	j	800038e4 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x34>
        }
    }
    (*numSlabs) = slabs;
    800038fc:	00d5a023          	sw	a3,0(a1)
    (*numSlots) = slots;
    80003900:	00e62023          	sw	a4,0(a2)
}
    80003904:	00813403          	ld	s0,8(sp)
    80003908:	01010113          	addi	sp,sp,16
    8000390c:	00008067          	ret

0000000080003910 <_ZN5Cache14printCacheInfoEv>:
void Cache::printCacheInfo() {
    80003910:	fd010113          	addi	sp,sp,-48
    80003914:	02113423          	sd	ra,40(sp)
    80003918:	02813023          	sd	s0,32(sp)
    8000391c:	00913c23          	sd	s1,24(sp)
    80003920:	03010413          	addi	s0,sp,48
    80003924:	00050493          	mv	s1,a0
    int numSlabs = 0, numSlots = 0;
    80003928:	fc042e23          	sw	zero,-36(s0)
    8000392c:	fc042c23          	sw	zero,-40(s0)
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    80003930:	fd840613          	addi	a2,s0,-40
    80003934:	fdc40593          	addi	a1,s0,-36
    80003938:	00000097          	auipc	ra,0x0
    8000393c:	f78080e7          	jalr	-136(ra) # 800038b0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>
    printString(cacheName);
    80003940:	02048513          	addi	a0,s1,32
    80003944:	fffff097          	auipc	ra,0xfffff
    80003948:	e3c080e7          	jalr	-452(ra) # 80002780 <_Z11printStringPKc>
    printString(", ");
    8000394c:	00004517          	auipc	a0,0x4
    80003950:	85c50513          	addi	a0,a0,-1956 # 800071a8 <CONSOLE_STATUS+0x198>
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	e2c080e7          	jalr	-468(ra) # 80002780 <_Z11printStringPKc>
    printInt(objectSize);
    8000395c:	00000613          	li	a2,0
    80003960:	00a00593          	li	a1,10
    80003964:	0304a503          	lw	a0,48(s1)
    80003968:	fffff097          	auipc	ra,0xfffff
    8000396c:	fb0080e7          	jalr	-80(ra) # 80002918 <_Z8printIntiii>
    printString(", ");
    80003970:	00004517          	auipc	a0,0x4
    80003974:	83850513          	addi	a0,a0,-1992 # 800071a8 <CONSOLE_STATUS+0x198>
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	e08080e7          	jalr	-504(ra) # 80002780 <_Z11printStringPKc>
    printInt(BLKSIZE*slabSize);
    80003980:	0484b503          	ld	a0,72(s1)
    80003984:	00000613          	li	a2,0
    80003988:	00a00593          	li	a1,10
    8000398c:	00c5151b          	slliw	a0,a0,0xc
    80003990:	fffff097          	auipc	ra,0xfffff
    80003994:	f88080e7          	jalr	-120(ra) # 80002918 <_Z8printIntiii>
    printString(", ");
    80003998:	00004517          	auipc	a0,0x4
    8000399c:	81050513          	addi	a0,a0,-2032 # 800071a8 <CONSOLE_STATUS+0x198>
    800039a0:	fffff097          	auipc	ra,0xfffff
    800039a4:	de0080e7          	jalr	-544(ra) # 80002780 <_Z11printStringPKc>
    printInt(numSlabs);
    800039a8:	00000613          	li	a2,0
    800039ac:	00a00593          	li	a1,10
    800039b0:	fdc42503          	lw	a0,-36(s0)
    800039b4:	fffff097          	auipc	ra,0xfffff
    800039b8:	f64080e7          	jalr	-156(ra) # 80002918 <_Z8printIntiii>
    printString(", ");
    800039bc:	00003517          	auipc	a0,0x3
    800039c0:	7ec50513          	addi	a0,a0,2028 # 800071a8 <CONSOLE_STATUS+0x198>
    800039c4:	fffff097          	auipc	ra,0xfffff
    800039c8:	dbc080e7          	jalr	-580(ra) # 80002780 <_Z11printStringPKc>
    printInt(optimalSlots);
    800039cc:	00000613          	li	a2,0
    800039d0:	00a00593          	li	a1,10
    800039d4:	0384a503          	lw	a0,56(s1)
    800039d8:	fffff097          	auipc	ra,0xfffff
    800039dc:	f40080e7          	jalr	-192(ra) # 80002918 <_Z8printIntiii>
    printString(", ");
    800039e0:	00003517          	auipc	a0,0x3
    800039e4:	7c850513          	addi	a0,a0,1992 # 800071a8 <CONSOLE_STATUS+0x198>
    800039e8:	fffff097          	auipc	ra,0xfffff
    800039ec:	d98080e7          	jalr	-616(ra) # 80002780 <_Z11printStringPKc>
    printInt(slotSize);
    800039f0:	00000613          	li	a2,0
    800039f4:	00a00593          	li	a1,10
    800039f8:	0404a503          	lw	a0,64(s1)
    800039fc:	fffff097          	auipc	ra,0xfffff
    80003a00:	f1c080e7          	jalr	-228(ra) # 80002918 <_Z8printIntiii>
    printString(", ");
    80003a04:	00003517          	auipc	a0,0x3
    80003a08:	7a450513          	addi	a0,a0,1956 # 800071a8 <CONSOLE_STATUS+0x198>
    80003a0c:	fffff097          	auipc	ra,0xfffff
    80003a10:	d74080e7          	jalr	-652(ra) # 80002780 <_Z11printStringPKc>
    printInt(numSlots);
    80003a14:	00000613          	li	a2,0
    80003a18:	00a00593          	li	a1,10
    80003a1c:	fd842503          	lw	a0,-40(s0)
    80003a20:	fffff097          	auipc	ra,0xfffff
    80003a24:	ef8080e7          	jalr	-264(ra) # 80002918 <_Z8printIntiii>
}
    80003a28:	02813083          	ld	ra,40(sp)
    80003a2c:	02013403          	ld	s0,32(sp)
    80003a30:	01813483          	ld	s1,24(sp)
    80003a34:	03010113          	addi	sp,sp,48
    80003a38:	00008067          	ret

0000000080003a3c <_ZN5Cache11deallocSlabEPNS_4SlabE>:
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    80003a3c:	fd010113          	addi	sp,sp,-48
    80003a40:	02113423          	sd	ra,40(sp)
    80003a44:	02813023          	sd	s0,32(sp)
    80003a48:	00913c23          	sd	s1,24(sp)
    80003a4c:	01213823          	sd	s2,16(sp)
    80003a50:	01313423          	sd	s3,8(sp)
    80003a54:	03010413          	addi	s0,sp,48
    80003a58:	00058993          	mv	s3,a1
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    if(destructor) {
    80003a5c:	05853783          	ld	a5,88(a0)
    80003a60:	02078a63          	beqz	a5,80003a94 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x58>
    80003a64:	00050913          	mv	s2,a0
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003a68:	00000493          	li	s1,0
    80003a6c:	0200006f          	j	80003a8c <_ZN5Cache11deallocSlabEPNS_4SlabE+0x50>
            destructor((void*)((char*)startAddr + i*slotSize));
    80003a70:	05893783          	ld	a5,88(s2)
    80003a74:	04093503          	ld	a0,64(s2)
    80003a78:	02950533          	mul	a0,a0,s1
    80003a7c:	02850513          	addi	a0,a0,40
    80003a80:	00a98533          	add	a0,s3,a0
    80003a84:	000780e7          	jalr	a5
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003a88:	00148493          	addi	s1,s1,1
    80003a8c:	03893783          	ld	a5,56(s2)
    80003a90:	fef4e0e3          	bltu	s1,a5,80003a70 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x34>
        }
    }
    BuddyAllocator::buddyFree(slab, 1);
    80003a94:	00100593          	li	a1,1
    80003a98:	00098513          	mv	a0,s3
    80003a9c:	ffffe097          	auipc	ra,0xffffe
    80003aa0:	7cc080e7          	jalr	1996(ra) # 80002268 <_ZN14BuddyAllocator9buddyFreeEPvm>
}
    80003aa4:	02813083          	ld	ra,40(sp)
    80003aa8:	02013403          	ld	s0,32(sp)
    80003aac:	01813483          	ld	s1,24(sp)
    80003ab0:	01013903          	ld	s2,16(sp)
    80003ab4:	00813983          	ld	s3,8(sp)
    80003ab8:	03010113          	addi	sp,sp,48
    80003abc:	00008067          	ret

0000000080003ac0 <_ZN5Cache16deallocFreeSlabsEv>:
int Cache::deallocFreeSlabs() {
    80003ac0:	fd010113          	addi	sp,sp,-48
    80003ac4:	02113423          	sd	ra,40(sp)
    80003ac8:	02813023          	sd	s0,32(sp)
    80003acc:	00913c23          	sd	s1,24(sp)
    80003ad0:	01213823          	sd	s2,16(sp)
    80003ad4:	01313423          	sd	s3,8(sp)
    80003ad8:	03010413          	addi	s0,sp,48
    80003adc:	00050993          	mv	s3,a0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003ae0:	00853583          	ld	a1,8(a0)
    int numSlabs = 0;
    80003ae4:	00000493          	li	s1,0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003ae8:	02058063          	beqz	a1,80003b08 <_ZN5Cache16deallocFreeSlabsEv+0x48>
        numSlabs++;
    80003aec:	0014849b          	addiw	s1,s1,1
        curr = curr->next;
    80003af0:	0085b903          	ld	s2,8(a1)
        deallocSlab(old);
    80003af4:	00098513          	mv	a0,s3
    80003af8:	00000097          	auipc	ra,0x0
    80003afc:	f44080e7          	jalr	-188(ra) # 80003a3c <_ZN5Cache11deallocSlabEPNS_4SlabE>
        curr = curr->next;
    80003b00:	00090593          	mv	a1,s2
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003b04:	fe5ff06f          	j	80003ae8 <_ZN5Cache16deallocFreeSlabsEv+0x28>
    slabList[EMPTY] = nullptr;
    80003b08:	0009b423          	sd	zero,8(s3)
}
    80003b0c:	00048513          	mv	a0,s1
    80003b10:	02813083          	ld	ra,40(sp)
    80003b14:	02013403          	ld	s0,32(sp)
    80003b18:	01813483          	ld	s1,24(sp)
    80003b1c:	01013903          	ld	s2,16(sp)
    80003b20:	00813983          	ld	s3,8(sp)
    80003b24:	03010113          	addi	sp,sp,48
    80003b28:	00008067          	ret

0000000080003b2c <_ZN5Cache12deallocCacheEv>:

void Cache::deallocCache() {
    80003b2c:	fd010113          	addi	sp,sp,-48
    80003b30:	02113423          	sd	ra,40(sp)
    80003b34:	02813023          	sd	s0,32(sp)
    80003b38:	00913c23          	sd	s1,24(sp)
    80003b3c:	01213823          	sd	s2,16(sp)
    80003b40:	01313423          	sd	s3,8(sp)
    80003b44:	03010413          	addi	s0,sp,48
    80003b48:	00050913          	mv	s2,a0
    for(int i = 0; i < 3; i++) {
    80003b4c:	00000993          	li	s3,0
    80003b50:	0080006f          	j	80003b58 <_ZN5Cache12deallocCacheEv+0x2c>
    80003b54:	0019899b          	addiw	s3,s3,1
    80003b58:	00200793          	li	a5,2
    80003b5c:	0337c663          	blt	a5,s3,80003b88 <_ZN5Cache12deallocCacheEv+0x5c>
        Slab* curr = slabList[i];
    80003b60:	00399793          	slli	a5,s3,0x3
    80003b64:	00f907b3          	add	a5,s2,a5
    80003b68:	0087b583          	ld	a1,8(a5)
        while(curr) {
    80003b6c:	fe0584e3          	beqz	a1,80003b54 <_ZN5Cache12deallocCacheEv+0x28>
            Slab* old = curr;
            curr = curr->next;
    80003b70:	0085b483          	ld	s1,8(a1)
            deallocSlab(old);
    80003b74:	00090513          	mv	a0,s2
    80003b78:	00000097          	auipc	ra,0x0
    80003b7c:	ec4080e7          	jalr	-316(ra) # 80003a3c <_ZN5Cache11deallocSlabEPNS_4SlabE>
            curr = curr->next;
    80003b80:	00048593          	mv	a1,s1
        while(curr) {
    80003b84:	fe9ff06f          	j	80003b6c <_ZN5Cache12deallocCacheEv+0x40>
        }
    }
}
    80003b88:	02813083          	ld	ra,40(sp)
    80003b8c:	02013403          	ld	s0,32(sp)
    80003b90:	01813483          	ld	s1,24(sp)
    80003b94:	01013903          	ld	s2,16(sp)
    80003b98:	00813983          	ld	s3,8(sp)
    80003b9c:	03010113          	addi	sp,sp,48
    80003ba0:	00008067          	ret

0000000080003ba4 <_ZN5Cache10powerOfTwoEm>:
void Cache::freeBuffer(Slot* slot) {
    Cache* parentCache = slot->parentSlab->parentCache;
    parentCache->freeSlot(slot);
}

size_t Cache::powerOfTwo(size_t size) {
    80003ba4:	ff010113          	addi	sp,sp,-16
    80003ba8:	00813423          	sd	s0,8(sp)
    80003bac:	01010413          	addi	s0,sp,16
    80003bb0:	00050613          	mv	a2,a0
    size_t t = size;
    80003bb4:	00050793          	mv	a5,a0
    size_t pow = 0, powerValue = 1;
    80003bb8:	00100713          	li	a4,1
    80003bbc:	00000513          	li	a0,0
    while(t > 1) {
    80003bc0:	00100693          	li	a3,1
    80003bc4:	00f6fa63          	bgeu	a3,a5,80003bd8 <_ZN5Cache10powerOfTwoEm+0x34>
        t /= 2;
    80003bc8:	0017d793          	srli	a5,a5,0x1
        powerValue *= 2;
    80003bcc:	00171713          	slli	a4,a4,0x1
        pow++;
    80003bd0:	00150513          	addi	a0,a0,1
    while(t > 1) {
    80003bd4:	fedff06f          	j	80003bc0 <_ZN5Cache10powerOfTwoEm+0x1c>
    }
    if(size != powerValue) pow++;
    80003bd8:	00c70463          	beq	a4,a2,80003be0 <_ZN5Cache10powerOfTwoEm+0x3c>
    80003bdc:	00150513          	addi	a0,a0,1
    return pow;
}
    80003be0:	00813403          	ld	s0,8(sp)
    80003be4:	01010113          	addi	sp,sp,16
    80003be8:	00008067          	ret

0000000080003bec <_ZN5Cache12allocateSlabEv>:
Cache::Slab *Cache::allocateSlab() {
    80003bec:	fc010113          	addi	sp,sp,-64
    80003bf0:	02113c23          	sd	ra,56(sp)
    80003bf4:	02813823          	sd	s0,48(sp)
    80003bf8:	02913423          	sd	s1,40(sp)
    80003bfc:	03213023          	sd	s2,32(sp)
    80003c00:	01313c23          	sd	s3,24(sp)
    80003c04:	01413823          	sd	s4,16(sp)
    80003c08:	01513423          	sd	s5,8(sp)
    80003c0c:	04010413          	addi	s0,sp,64
    80003c10:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(powerOfTwo(slabSize)); // 2 ako nije dovoljno
    80003c14:	04853503          	ld	a0,72(a0)
    80003c18:	00000097          	auipc	ra,0x0
    80003c1c:	f8c080e7          	jalr	-116(ra) # 80003ba4 <_ZN5Cache10powerOfTwoEm>
    80003c20:	ffffe097          	auipc	ra,0xffffe
    80003c24:	580080e7          	jalr	1408(ra) # 800021a0 <_ZN14BuddyAllocator10buddyAllocEm>
    80003c28:	00050a13          	mv	s4,a0
    slab->parentCache = this;
    80003c2c:	01253c23          	sd	s2,24(a0)
    slab->next = nullptr;
    80003c30:	00053423          	sd	zero,8(a0)
    slab->state = CREATED;
    80003c34:	00300793          	li	a5,3
    80003c38:	00f52823          	sw	a5,16(a0)
    slab->allocatedSlots = 0;
    80003c3c:	00053023          	sd	zero,0(a0)
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    80003c40:	02850a93          	addi	s5,a0,40
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003c44:	00000493          	li	s1,0
    Slot* prev = nullptr;
    80003c48:	00000993          	li	s3,0
    80003c4c:	0140006f          	j	80003c60 <_ZN5Cache12allocateSlabEv+0x74>
            slab->slotHead = curr;
    80003c50:	02fa3023          	sd	a5,32(s4)
        curr->next = nullptr;
    80003c54:	0007b423          	sd	zero,8(a5)
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003c58:	00148493          	addi	s1,s1,1
        prev = curr;
    80003c5c:	00078993          	mv	s3,a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80003c60:	03893783          	ld	a5,56(s2)
    80003c64:	02f4fe63          	bgeu	s1,a5,80003ca0 <_ZN5Cache12allocateSlabEv+0xb4>
        if(constructor) {
    80003c68:	05093783          	ld	a5,80(s2)
    80003c6c:	00078a63          	beqz	a5,80003c80 <_ZN5Cache12allocateSlabEv+0x94>
            constructor((void*)((char*)startAddr + i*slotSize));
    80003c70:	04093503          	ld	a0,64(s2)
    80003c74:	02950533          	mul	a0,a0,s1
    80003c78:	00aa8533          	add	a0,s5,a0
    80003c7c:	000780e7          	jalr	a5
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
    80003c80:	04093783          	ld	a5,64(s2)
    80003c84:	029787b3          	mul	a5,a5,s1
    80003c88:	00fa87b3          	add	a5,s5,a5
        curr->parentSlab = slab;
    80003c8c:	0147b823          	sd	s4,16(a5)
        curr->allocated = false;
    80003c90:	00078023          	sb	zero,0(a5)
        if(prev) {
    80003c94:	fa098ee3          	beqz	s3,80003c50 <_ZN5Cache12allocateSlabEv+0x64>
            prev->next= curr;
    80003c98:	00f9b423          	sd	a5,8(s3)
    80003c9c:	fb9ff06f          	j	80003c54 <_ZN5Cache12allocateSlabEv+0x68>
}
    80003ca0:	000a0513          	mv	a0,s4
    80003ca4:	03813083          	ld	ra,56(sp)
    80003ca8:	03013403          	ld	s0,48(sp)
    80003cac:	02813483          	ld	s1,40(sp)
    80003cb0:	02013903          	ld	s2,32(sp)
    80003cb4:	01813983          	ld	s3,24(sp)
    80003cb8:	01013a03          	ld	s4,16(sp)
    80003cbc:	00813a83          	ld	s5,8(sp)
    80003cc0:	04010113          	addi	sp,sp,64
    80003cc4:	00008067          	ret

0000000080003cc8 <_ZN5Cache11createCacheEv>:

Cache *Cache::createCache() {
    80003cc8:	ff010113          	addi	sp,sp,-16
    80003ccc:	00113423          	sd	ra,8(sp)
    80003cd0:	00813023          	sd	s0,0(sp)
    80003cd4:	01010413          	addi	s0,sp,16
    return (Cache*)BuddyAllocator::buddyAlloc(1);
    80003cd8:	00100513          	li	a0,1
    80003cdc:	ffffe097          	auipc	ra,0xffffe
    80003ce0:	4c4080e7          	jalr	1220(ra) # 800021a0 <_ZN14BuddyAllocator10buddyAllocEm>
}
    80003ce4:	00813083          	ld	ra,8(sp)
    80003ce8:	00013403          	ld	s0,0(sp)
    80003cec:	01010113          	addi	sp,sp,16
    80003cf0:	00008067          	ret

0000000080003cf4 <_ZN5Cache6strcpyEPcPKc>:

void Cache::strcpy(char *string1, const char *string2) {
    80003cf4:	ff010113          	addi	sp,sp,-16
    80003cf8:	00813423          	sd	s0,8(sp)
    80003cfc:	01010413          	addi	s0,sp,16
        for(int i = 0;; i++) {
    80003d00:	00000693          	li	a3,0
            string1[i] = string2[i];
    80003d04:	00d587b3          	add	a5,a1,a3
    80003d08:	00d50733          	add	a4,a0,a3
    80003d0c:	0007c603          	lbu	a2,0(a5)
    80003d10:	00c70023          	sb	a2,0(a4)
            if(string2[i] == '\0') break;
    80003d14:	0007c783          	lbu	a5,0(a5)
    80003d18:	00078663          	beqz	a5,80003d24 <_ZN5Cache6strcpyEPcPKc+0x30>
        for(int i = 0;; i++) {
    80003d1c:	0016869b          	addiw	a3,a3,1
            string1[i] = string2[i];
    80003d20:	fe5ff06f          	j	80003d04 <_ZN5Cache6strcpyEPcPKc+0x10>
        }
}
    80003d24:	00813403          	ld	s0,8(sp)
    80003d28:	01010113          	addi	sp,sp,16
    80003d2c:	00008067          	ret

0000000080003d30 <_ZN5Cache9initCacheEPKcmPFvPvES4_>:
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80003d30:	fd010113          	addi	sp,sp,-48
    80003d34:	02113423          	sd	ra,40(sp)
    80003d38:	02813023          	sd	s0,32(sp)
    80003d3c:	00913c23          	sd	s1,24(sp)
    80003d40:	01213823          	sd	s2,16(sp)
    80003d44:	01313423          	sd	s3,8(sp)
    80003d48:	01413023          	sd	s4,0(sp)
    80003d4c:	03010413          	addi	s0,sp,48
    80003d50:	00050493          	mv	s1,a0
    80003d54:	00060913          	mv	s2,a2
    80003d58:	00068a13          	mv	s4,a3
    80003d5c:	00070993          	mv	s3,a4
    strcpy(cacheName, name);
    80003d60:	02050513          	addi	a0,a0,32
    80003d64:	00000097          	auipc	ra,0x0
    80003d68:	f90080e7          	jalr	-112(ra) # 80003cf4 <_ZN5Cache6strcpyEPcPKc>
    for(int i = 0; i < 3; i++) {
    80003d6c:	00000793          	li	a5,0
    80003d70:	0140006f          	j	80003d84 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x54>
        slabList[i] = nullptr;
    80003d74:	00379513          	slli	a0,a5,0x3
    80003d78:	00a48533          	add	a0,s1,a0
    80003d7c:	00053423          	sd	zero,8(a0)
    for(int i = 0; i < 3; i++) {
    80003d80:	0017879b          	addiw	a5,a5,1
    80003d84:	00200613          	li	a2,2
    80003d88:	fef656e3          	bge	a2,a5,80003d74 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x44>
    objectSize = size;
    80003d8c:	0324b823          	sd	s2,48(s1)
    constructor = ctor;
    80003d90:	0544b823          	sd	s4,80(s1)
    destructor = dtor;
    80003d94:	0534bc23          	sd	s3,88(s1)
    slotSize = objectSize + sizeof(Slot);
    80003d98:	01890593          	addi	a1,s2,24
    80003d9c:	04b4b023          	sd	a1,64(s1)
    slabSize = slotSize / BLKSIZE;
    80003da0:	00c5d713          	srli	a4,a1,0xc
    80003da4:	04e4b423          	sd	a4,72(s1)
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima
    80003da8:	000017b7          	lui	a5,0x1
    80003dac:	fff78793          	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80003db0:	00f5f7b3          	and	a5,a1,a5
    80003db4:	00078663          	beqz	a5,80003dc0 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x90>
    80003db8:	00170713          	addi	a4,a4,1
    80003dbc:	04e4b423          	sd	a4,72(s1)
    optimalSlots = getNumSlots(slabSize, slotSize);
    80003dc0:	0484b503          	ld	a0,72(s1)
    80003dc4:	00000097          	auipc	ra,0x0
    80003dc8:	9c0080e7          	jalr	-1600(ra) # 80003784 <_ZN5Cache11getNumSlotsEmm>
    80003dcc:	02a4bc23          	sd	a0,56(s1)
}
    80003dd0:	02813083          	ld	ra,40(sp)
    80003dd4:	02013403          	ld	s0,32(sp)
    80003dd8:	01813483          	ld	s1,24(sp)
    80003ddc:	01013903          	ld	s2,16(sp)
    80003de0:	00813983          	ld	s3,8(sp)
    80003de4:	00013a03          	ld	s4,0(sp)
    80003de8:	03010113          	addi	sp,sp,48
    80003dec:	00008067          	ret

0000000080003df0 <_ZN5Cache13allBufferInfoEv>:

void Cache::allBufferInfo() {
    80003df0:	fe010113          	addi	sp,sp,-32
    80003df4:	00113c23          	sd	ra,24(sp)
    80003df8:	00813823          	sd	s0,16(sp)
    80003dfc:	00913423          	sd	s1,8(sp)
    80003e00:	02010413          	addi	s0,sp,32
    printString("ime kesa, velicina objekta, velicina slaba, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    80003e04:	00003517          	auipc	a0,0x3
    80003e08:	3ac50513          	addi	a0,a0,940 # 800071b0 <CONSOLE_STATUS+0x1a0>
    80003e0c:	fffff097          	auipc	ra,0xfffff
    80003e10:	974080e7          	jalr	-1676(ra) # 80002780 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80003e14:	00000493          	li	s1,0
    80003e18:	0200006f          	j	80003e38 <_ZN5Cache13allBufferInfoEv+0x48>
        if(bufferCache[i]) bufferCache[i]->printCacheInfo();
    80003e1c:	00000097          	auipc	ra,0x0
    80003e20:	af4080e7          	jalr	-1292(ra) # 80003910 <_ZN5Cache14printCacheInfoEv>
        printString("\n");
    80003e24:	00003517          	auipc	a0,0x3
    80003e28:	40450513          	addi	a0,a0,1028 # 80007228 <CONSOLE_STATUS+0x218>
    80003e2c:	fffff097          	auipc	ra,0xfffff
    80003e30:	954080e7          	jalr	-1708(ra) # 80002780 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80003e34:	0014849b          	addiw	s1,s1,1
    80003e38:	00c00793          	li	a5,12
    80003e3c:	0297c063          	blt	a5,s1,80003e5c <_ZN5Cache13allBufferInfoEv+0x6c>
        if(bufferCache[i]) bufferCache[i]->printCacheInfo();
    80003e40:	00349713          	slli	a4,s1,0x3
    80003e44:	00005797          	auipc	a5,0x5
    80003e48:	4ec78793          	addi	a5,a5,1260 # 80009330 <_ZN5Cache11bufferCacheE>
    80003e4c:	00e787b3          	add	a5,a5,a4
    80003e50:	0007b503          	ld	a0,0(a5)
    80003e54:	fc0514e3          	bnez	a0,80003e1c <_ZN5Cache13allBufferInfoEv+0x2c>
    80003e58:	fcdff06f          	j	80003e24 <_ZN5Cache13allBufferInfoEv+0x34>
    }
}
    80003e5c:	01813083          	ld	ra,24(sp)
    80003e60:	01013403          	ld	s0,16(sp)
    80003e64:	00813483          	ld	s1,8(sp)
    80003e68:	02010113          	addi	sp,sp,32
    80003e6c:	00008067          	ret

0000000080003e70 <_ZN5Cache4Slab17calculateNewStateEv>:
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    80003e70:	ff010113          	addi	sp,sp,-16
    80003e74:	00813423          	sd	s0,8(sp)
    80003e78:	01010413          	addi	s0,sp,16
    if(allocatedSlots == 0) {
    80003e7c:	00053783          	ld	a5,0(a0)
    80003e80:	02078063          	beqz	a5,80003ea0 <_ZN5Cache4Slab17calculateNewStateEv+0x30>
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
    80003e84:	01853703          	ld	a4,24(a0)
    80003e88:	03873703          	ld	a4,56(a4)
    80003e8c:	00e78e63          	beq	a5,a4,80003ea8 <_ZN5Cache4Slab17calculateNewStateEv+0x38>
        return FULL;
    }
    return PARTIAL;
    80003e90:	00100513          	li	a0,1
}
    80003e94:	00813403          	ld	s0,8(sp)
    80003e98:	01010113          	addi	sp,sp,16
    80003e9c:	00008067          	ret
        return EMPTY;
    80003ea0:	00000513          	li	a0,0
    80003ea4:	ff1ff06f          	j	80003e94 <_ZN5Cache4Slab17calculateNewStateEv+0x24>
        return FULL;
    80003ea8:	00200513          	li	a0,2
    80003eac:	fe9ff06f          	j	80003e94 <_ZN5Cache4Slab17calculateNewStateEv+0x24>

0000000080003eb0 <_ZN5Cache8freeSlotEPNS_4SlotE>:
void Cache::freeSlot(Slot* slot) {
    80003eb0:	fd010113          	addi	sp,sp,-48
    80003eb4:	02113423          	sd	ra,40(sp)
    80003eb8:	02813023          	sd	s0,32(sp)
    80003ebc:	00913c23          	sd	s1,24(sp)
    80003ec0:	01213823          	sd	s2,16(sp)
    80003ec4:	01313423          	sd	s3,8(sp)
    80003ec8:	03010413          	addi	s0,sp,48
    if(slot->parentSlab->parentCache != this) {
    80003ecc:	0105b483          	ld	s1,16(a1)
    80003ed0:	0184b903          	ld	s2,24(s1)
    80003ed4:	02a90463          	beq	s2,a0,80003efc <_ZN5Cache8freeSlotEPNS_4SlotE+0x4c>
        errortype = FreeSlotError;
    80003ed8:	00100793          	li	a5,1
    80003edc:	00f52023          	sw	a5,0(a0)
}
    80003ee0:	02813083          	ld	ra,40(sp)
    80003ee4:	02013403          	ld	s0,32(sp)
    80003ee8:	01813483          	ld	s1,24(sp)
    80003eec:	01013903          	ld	s2,16(sp)
    80003ef0:	00813983          	ld	s3,8(sp)
    80003ef4:	03010113          	addi	sp,sp,48
    80003ef8:	00008067          	ret
    slot->allocated = false;
    80003efc:	00058023          	sb	zero,0(a1)
    parentSlab->allocatedSlots--;
    80003f00:	0004b783          	ld	a5,0(s1)
    80003f04:	fff78793          	addi	a5,a5,-1
    80003f08:	00f4b023          	sd	a5,0(s1)
    SlabState newState = parentSlab->calculateNewState();
    80003f0c:	00048513          	mv	a0,s1
    80003f10:	00000097          	auipc	ra,0x0
    80003f14:	f60080e7          	jalr	-160(ra) # 80003e70 <_ZN5Cache4Slab17calculateNewStateEv>
    80003f18:	00050993          	mv	s3,a0
    if(parentSlab->state != newState) {
    80003f1c:	0104a603          	lw	a2,16(s1)
    80003f20:	fca600e3          	beq	a2,a0,80003ee0 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003f24:	00300793          	li	a5,3
    80003f28:	00f61e63          	bne	a2,a5,80003f44 <_ZN5Cache8freeSlotEPNS_4SlotE+0x94>
        parentCache->slabListPut(parentSlab, newState);
    80003f2c:	0009861b          	sext.w	a2,s3
    80003f30:	00048593          	mv	a1,s1
    80003f34:	00090513          	mv	a0,s2
    80003f38:	00000097          	auipc	ra,0x0
    80003f3c:	874080e7          	jalr	-1932(ra) # 800037ac <_ZN5Cache11slabListPutEPNS_4SlabEi>
    80003f40:	fa1ff06f          	j	80003ee0 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80003f44:	00048593          	mv	a1,s1
    80003f48:	00090513          	mv	a0,s2
    80003f4c:	00000097          	auipc	ra,0x0
    80003f50:	8ac080e7          	jalr	-1876(ra) # 800037f8 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80003f54:	fd9ff06f          	j	80003f2c <_ZN5Cache8freeSlotEPNS_4SlotE+0x7c>

0000000080003f58 <_ZN5Cache10freeBufferEPNS_4SlotE>:
void Cache::freeBuffer(Slot* slot) {
    80003f58:	ff010113          	addi	sp,sp,-16
    80003f5c:	00113423          	sd	ra,8(sp)
    80003f60:	00813023          	sd	s0,0(sp)
    80003f64:	01010413          	addi	s0,sp,16
    80003f68:	00050593          	mv	a1,a0
    Cache* parentCache = slot->parentSlab->parentCache;
    80003f6c:	01053783          	ld	a5,16(a0)
    parentCache->freeSlot(slot);
    80003f70:	0187b503          	ld	a0,24(a5)
    80003f74:	00000097          	auipc	ra,0x0
    80003f78:	f3c080e7          	jalr	-196(ra) # 80003eb0 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80003f7c:	00813083          	ld	ra,8(sp)
    80003f80:	00013403          	ld	s0,0(sp)
    80003f84:	01010113          	addi	sp,sp,16
    80003f88:	00008067          	ret

0000000080003f8c <_ZN5Cache4Slab11getFreeSlotEv>:
Cache::Slot *Cache::Slab::getFreeSlot() {
    80003f8c:	fd010113          	addi	sp,sp,-48
    80003f90:	02113423          	sd	ra,40(sp)
    80003f94:	02813023          	sd	s0,32(sp)
    80003f98:	00913c23          	sd	s1,24(sp)
    80003f9c:	01213823          	sd	s2,16(sp)
    80003fa0:	01313423          	sd	s3,8(sp)
    80003fa4:	03010413          	addi	s0,sp,48
    if(!slotHead || state == FULL) return nullptr;
    80003fa8:	02053483          	ld	s1,32(a0)
    80003fac:	06048a63          	beqz	s1,80004020 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
    80003fb0:	00050913          	mv	s2,a0
    80003fb4:	01052703          	lw	a4,16(a0)
    80003fb8:	00200793          	li	a5,2
    80003fbc:	08f70c63          	beq	a4,a5,80004054 <_ZN5Cache4Slab11getFreeSlotEv+0xc8>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003fc0:	06048063          	beqz	s1,80004020 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
        if(curr->allocated == false) {
    80003fc4:	0004c783          	lbu	a5,0(s1)
    80003fc8:	00078663          	beqz	a5,80003fd4 <_ZN5Cache4Slab11getFreeSlotEv+0x48>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    80003fcc:	0084b483          	ld	s1,8(s1)
    80003fd0:	ff1ff06f          	j	80003fc0 <_ZN5Cache4Slab11getFreeSlotEv+0x34>
            this->allocatedSlots++;
    80003fd4:	00093783          	ld	a5,0(s2)
    80003fd8:	00178793          	addi	a5,a5,1
    80003fdc:	00f93023          	sd	a5,0(s2)
            curr->allocated = true;
    80003fe0:	00100793          	li	a5,1
    80003fe4:	00f48023          	sb	a5,0(s1)
            curr->parentSlab = this;
    80003fe8:	0124b823          	sd	s2,16(s1)
            SlabState newState = calculateNewState();
    80003fec:	00090513          	mv	a0,s2
    80003ff0:	00000097          	auipc	ra,0x0
    80003ff4:	e80080e7          	jalr	-384(ra) # 80003e70 <_ZN5Cache4Slab17calculateNewStateEv>
    80003ff8:	00050993          	mv	s3,a0
            if(this->state != newState) {
    80003ffc:	01092603          	lw	a2,16(s2)
    80004000:	02a60063          	beq	a2,a0,80004020 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80004004:	00300793          	li	a5,3
    80004008:	02f61c63          	bne	a2,a5,80004040 <_ZN5Cache4Slab11getFreeSlotEv+0xb4>
                parentCache->slabListPut(this, newState);
    8000400c:	0009861b          	sext.w	a2,s3
    80004010:	00090593          	mv	a1,s2
    80004014:	01893503          	ld	a0,24(s2)
    80004018:	fffff097          	auipc	ra,0xfffff
    8000401c:	794080e7          	jalr	1940(ra) # 800037ac <_ZN5Cache11slabListPutEPNS_4SlabEi>
}
    80004020:	00048513          	mv	a0,s1
    80004024:	02813083          	ld	ra,40(sp)
    80004028:	02013403          	ld	s0,32(sp)
    8000402c:	01813483          	ld	s1,24(sp)
    80004030:	01013903          	ld	s2,16(sp)
    80004034:	00813983          	ld	s3,8(sp)
    80004038:	03010113          	addi	sp,sp,48
    8000403c:	00008067          	ret
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80004040:	00090593          	mv	a1,s2
    80004044:	01893503          	ld	a0,24(s2)
    80004048:	fffff097          	auipc	ra,0xfffff
    8000404c:	7b0080e7          	jalr	1968(ra) # 800037f8 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80004050:	fbdff06f          	j	8000400c <_ZN5Cache4Slab11getFreeSlotEv+0x80>
    if(!slotHead || state == FULL) return nullptr;
    80004054:	00000493          	li	s1,0
    80004058:	fc9ff06f          	j	80004020 <_ZN5Cache4Slab11getFreeSlotEv+0x94>

000000008000405c <_ZN5Cache12allocateSlotEv>:
void *Cache::allocateSlot() {
    8000405c:	ff010113          	addi	sp,sp,-16
    80004060:	00113423          	sd	ra,8(sp)
    80004064:	00813023          	sd	s0,0(sp)
    80004068:	01010413          	addi	s0,sp,16
    8000406c:	00050793          	mv	a5,a0
    if(slabList[PARTIAL]) {
    80004070:	01053503          	ld	a0,16(a0)
    80004074:	00050e63          	beqz	a0,80004090 <_ZN5Cache12allocateSlotEv+0x34>
        return slab->getFreeSlot();
    80004078:	00000097          	auipc	ra,0x0
    8000407c:	f14080e7          	jalr	-236(ra) # 80003f8c <_ZN5Cache4Slab11getFreeSlotEv>
}
    80004080:	00813083          	ld	ra,8(sp)
    80004084:	00013403          	ld	s0,0(sp)
    80004088:	01010113          	addi	sp,sp,16
    8000408c:	00008067          	ret
    else if(slabList[EMPTY]) {
    80004090:	0087b503          	ld	a0,8(a5)
    80004094:	00050863          	beqz	a0,800040a4 <_ZN5Cache12allocateSlotEv+0x48>
        Slot* slot = slab->getFreeSlot();
    80004098:	00000097          	auipc	ra,0x0
    8000409c:	ef4080e7          	jalr	-268(ra) # 80003f8c <_ZN5Cache4Slab11getFreeSlotEv>
        return slot;
    800040a0:	fe1ff06f          	j	80004080 <_ZN5Cache12allocateSlotEv+0x24>
    Slab* slab = allocateSlab();
    800040a4:	00078513          	mv	a0,a5
    800040a8:	00000097          	auipc	ra,0x0
    800040ac:	b44080e7          	jalr	-1212(ra) # 80003bec <_ZN5Cache12allocateSlabEv>
    return slab->getFreeSlot();
    800040b0:	00000097          	auipc	ra,0x0
    800040b4:	edc080e7          	jalr	-292(ra) # 80003f8c <_ZN5Cache4Slab11getFreeSlotEv>
    800040b8:	fc9ff06f          	j	80004080 <_ZN5Cache12allocateSlotEv+0x24>

00000000800040bc <_ZN5Cache14allocateBufferEm>:
void *Cache::allocateBuffer(size_t size) {
    800040bc:	fe010113          	addi	sp,sp,-32
    800040c0:	00113c23          	sd	ra,24(sp)
    800040c4:	00813823          	sd	s0,16(sp)
    800040c8:	00913423          	sd	s1,8(sp)
    800040cc:	01213023          	sd	s2,0(sp)
    800040d0:	02010413          	addi	s0,sp,32
    size_t objectPowSize = powerOfTwo(size);
    800040d4:	00000097          	auipc	ra,0x0
    800040d8:	ad0080e7          	jalr	-1328(ra) # 80003ba4 <_ZN5Cache10powerOfTwoEm>
    if(objectPowSize <  MINSIZEBUFFER || objectPowSize > MAXSIZEBUFFER) {
    800040dc:	ffb50493          	addi	s1,a0,-5
    800040e0:	00c00793          	li	a5,12
    800040e4:	0897ee63          	bltu	a5,s1,80004180 <_ZN5Cache14allocateBufferEm+0xc4>
    800040e8:	00050913          	mv	s2,a0
    if(bufferCache[entry] == nullptr) {
    800040ec:	00349713          	slli	a4,s1,0x3
    800040f0:	00005797          	auipc	a5,0x5
    800040f4:	24078793          	addi	a5,a5,576 # 80009330 <_ZN5Cache11bufferCacheE>
    800040f8:	00e787b3          	add	a5,a5,a4
    800040fc:	0007b783          	ld	a5,0(a5)
    80004100:	02078c63          	beqz	a5,80004138 <_ZN5Cache14allocateBufferEm+0x7c>
    return bufferCache[entry]->allocateSlot();
    80004104:	00349493          	slli	s1,s1,0x3
    80004108:	00005797          	auipc	a5,0x5
    8000410c:	22878793          	addi	a5,a5,552 # 80009330 <_ZN5Cache11bufferCacheE>
    80004110:	009784b3          	add	s1,a5,s1
    80004114:	0004b503          	ld	a0,0(s1)
    80004118:	00000097          	auipc	ra,0x0
    8000411c:	f44080e7          	jalr	-188(ra) # 8000405c <_ZN5Cache12allocateSlotEv>
}
    80004120:	01813083          	ld	ra,24(sp)
    80004124:	01013403          	ld	s0,16(sp)
    80004128:	00813483          	ld	s1,8(sp)
    8000412c:	00013903          	ld	s2,0(sp)
    80004130:	02010113          	addi	sp,sp,32
    80004134:	00008067          	ret
        bufferCache[entry] = createCache();
    80004138:	00000097          	auipc	ra,0x0
    8000413c:	b90080e7          	jalr	-1136(ra) # 80003cc8 <_ZN5Cache11createCacheEv>
    80004140:	00349693          	slli	a3,s1,0x3
    80004144:	00005717          	auipc	a4,0x5
    80004148:	1ec70713          	addi	a4,a4,492 # 80009330 <_ZN5Cache11bufferCacheE>
    8000414c:	00d70733          	add	a4,a4,a3
    80004150:	00a73023          	sd	a0,0(a4)
        bufferCache[entry]->initCache(bufferNames[entry], 1<<objectPowSize, NULL,NULL);
    80004154:	00005797          	auipc	a5,0x5
    80004158:	f8478793          	addi	a5,a5,-124 # 800090d8 <_ZN5Cache11bufferNamesE>
    8000415c:	00d787b3          	add	a5,a5,a3
    80004160:	00000713          	li	a4,0
    80004164:	00000693          	li	a3,0
    80004168:	00100613          	li	a2,1
    8000416c:	0126163b          	sllw	a2,a2,s2
    80004170:	0007b583          	ld	a1,0(a5)
    80004174:	00000097          	auipc	ra,0x0
    80004178:	bbc080e7          	jalr	-1092(ra) # 80003d30 <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    8000417c:	f89ff06f          	j	80004104 <_ZN5Cache14allocateBufferEm+0x48>
        return nullptr;
    80004180:	00000513          	li	a0,0
    80004184:	f9dff06f          	j	80004120 <_ZN5Cache14allocateBufferEm+0x64>

0000000080004188 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;
void *MemoryAllocator::mem_alloc(size_t size) {
    80004188:	ff010113          	addi	sp,sp,-16
    8000418c:	00813423          	sd	s0,8(sp)
    80004190:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80004194:	00005797          	auipc	a5,0x5
    80004198:	2047b783          	ld	a5,516(a5) # 80009398 <_ZN15MemoryAllocator4headE>
    8000419c:	02078c63          	beqz	a5,800041d4 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
    static void* userHeapStartAddr() {
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    }

    static void* userHeapEndAddr() {
        return (void*)HEAP_END_ADDR;
    800041a0:	00005717          	auipc	a4,0x5
    800041a4:	01073703          	ld	a4,16(a4) # 800091b0 <_GLOBAL_OFFSET_TABLE_+0x70>
    800041a8:	00073703          	ld	a4,0(a4)
        head = (FreeSegment*)userHeapStartAddr();
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    800041ac:	14e78263          	beq	a5,a4,800042f0 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800041b0:	00850713          	addi	a4,a0,8
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800041b4:	00675813          	srli	a6,a4,0x6
    800041b8:	03f77793          	andi	a5,a4,63
    800041bc:	00f037b3          	snez	a5,a5
    800041c0:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800041c4:	00005517          	auipc	a0,0x5
    800041c8:	1d453503          	ld	a0,468(a0) # 80009398 <_ZN15MemoryAllocator4headE>
    800041cc:	00000613          	li	a2,0
    800041d0:	0b40006f          	j	80004284 <_ZN15MemoryAllocator9mem_allocEm+0xfc>
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    800041d4:	00005797          	auipc	a5,0x5
    800041d8:	f8c7b783          	ld	a5,-116(a5) # 80009160 <_GLOBAL_OFFSET_TABLE_+0x20>
    800041dc:	0007b703          	ld	a4,0(a5)
    800041e0:	010007b7          	lui	a5,0x1000
    800041e4:	00f707b3          	add	a5,a4,a5
        head = (FreeSegment*)userHeapStartAddr();
    800041e8:	00005697          	auipc	a3,0x5
    800041ec:	1af6b823          	sd	a5,432(a3) # 80009398 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)((char*)userHeapStartAddr() + (size_t)(1<<24));
    800041f0:	020006b7          	lui	a3,0x2000
    800041f4:	00d70733          	add	a4,a4,a3
    800041f8:	00e7b023          	sd	a4,0(a5) # 1000000 <_entry-0x7f000000>
        return (void*)HEAP_END_ADDR;
    800041fc:	00005717          	auipc	a4,0x5
    80004200:	fb473703          	ld	a4,-76(a4) # 800091b0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004204:	00073703          	ld	a4,0(a4)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    80004208:	40f70733          	sub	a4,a4,a5
    8000420c:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80004210:	0007b823          	sd	zero,16(a5)
    80004214:	f9dff06f          	j	800041b0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80004218:	00060e63          	beqz	a2,80004234 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            if(!prev->next) return;
    8000421c:	01063703          	ld	a4,16(a2)
    80004220:	04070a63          	beqz	a4,80004274 <_ZN15MemoryAllocator9mem_allocEm+0xec>
            prev->next = curr->next;
    80004224:	01073703          	ld	a4,16(a4)
    80004228:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    8000422c:	00078813          	mv	a6,a5
    80004230:	0ac0006f          	j	800042dc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80004234:	01053703          	ld	a4,16(a0)
    80004238:	00070a63          	beqz	a4,8000424c <_ZN15MemoryAllocator9mem_allocEm+0xc4>
                        head = (FreeSegment*)userHeapEndAddr();
                    }
                    else {
                        head = curr->next;
    8000423c:	00005697          	auipc	a3,0x5
    80004240:	14e6be23          	sd	a4,348(a3) # 80009398 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80004244:	00078813          	mv	a6,a5
    80004248:	0940006f          	j	800042dc <_ZN15MemoryAllocator9mem_allocEm+0x154>
        return (void*)HEAP_END_ADDR;
    8000424c:	00005717          	auipc	a4,0x5
    80004250:	f6473703          	ld	a4,-156(a4) # 800091b0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004254:	00073703          	ld	a4,0(a4)
                        head = (FreeSegment*)userHeapEndAddr();
    80004258:	00005697          	auipc	a3,0x5
    8000425c:	14e6b023          	sd	a4,320(a3) # 80009398 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80004260:	00078813          	mv	a6,a5
    80004264:	0780006f          	j	800042dc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80004268:	00005797          	auipc	a5,0x5
    8000426c:	12e7b823          	sd	a4,304(a5) # 80009398 <_ZN15MemoryAllocator4headE>
    80004270:	06c0006f          	j	800042dc <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80004274:	00078813          	mv	a6,a5
    80004278:	0640006f          	j	800042dc <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    8000427c:	00050613          	mv	a2,a0
        curr = curr->next;
    80004280:	01053503          	ld	a0,16(a0)
    while(curr) {
    80004284:	06050063          	beqz	a0,800042e4 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80004288:	00853783          	ld	a5,8(a0)
    8000428c:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80004290:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80004294:	fee7e4e3          	bltu	a5,a4,8000427c <_ZN15MemoryAllocator9mem_allocEm+0xf4>
    80004298:	ff06e2e3          	bltu	a3,a6,8000427c <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    8000429c:	f7068ee3          	beq	a3,a6,80004218 <_ZN15MemoryAllocator9mem_allocEm+0x90>
        return numOfBlocks * MEM_BLOCK_SIZE;
    800042a0:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    800042a4:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    800042a8:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800042ac:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800042b0:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800042b4:	01053783          	ld	a5,16(a0)
    800042b8:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800042bc:	fa0606e3          	beqz	a2,80004268 <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            if(!prev->next) return;
    800042c0:	01063783          	ld	a5,16(a2)
    800042c4:	00078663          	beqz	a5,800042d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    800042c8:	0107b783          	ld	a5,16(a5)
    800042cc:	00f63823          	sd	a5,16(a2)
            curr->next = prev->next;
    800042d0:	01063783          	ld	a5,16(a2)
    800042d4:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800042d8:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800042dc:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800042e0:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800042e4:	00813403          	ld	s0,8(sp)
    800042e8:	01010113          	addi	sp,sp,16
    800042ec:	00008067          	ret
        return nullptr;
    800042f0:	00000513          	li	a0,0
    800042f4:	ff1ff06f          	j	800042e4 <_ZN15MemoryAllocator9mem_allocEm+0x15c>

00000000800042f8 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800042f8:	ff010113          	addi	sp,sp,-16
    800042fc:	00813423          	sd	s0,8(sp)
    80004300:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004304:	16050463          	beqz	a0,8000446c <_ZN15MemoryAllocator8mem_freeEPv+0x174>
    80004308:	ff850713          	addi	a4,a0,-8
        return (void*)((char*)HEAP_START_ADDR + (1<<24));
    8000430c:	00005797          	auipc	a5,0x5
    80004310:	e547b783          	ld	a5,-428(a5) # 80009160 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004314:	0007b783          	ld	a5,0(a5)
    80004318:	010006b7          	lui	a3,0x1000
    8000431c:	00d787b3          	add	a5,a5,a3
    80004320:	14f76a63          	bltu	a4,a5,80004474 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80004324:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80004328:	fff58693          	addi	a3,a1,-1
    8000432c:	00d706b3          	add	a3,a4,a3
        return (void*)HEAP_END_ADDR;
    80004330:	00005617          	auipc	a2,0x5
    80004334:	e8063603          	ld	a2,-384(a2) # 800091b0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004338:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000433c:	14c6f063          	bgeu	a3,a2,8000447c <_ZN15MemoryAllocator8mem_freeEPv+0x184>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    80004340:	14070263          	beqz	a4,80004484 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
        return (size_t)address - (size_t)userHeapStartAddr();
    80004344:	40f707b3          	sub	a5,a4,a5
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80004348:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000434c:	14079063          	bnez	a5,8000448c <_ZN15MemoryAllocator8mem_freeEPv+0x194>
    80004350:	03f00793          	li	a5,63
    80004354:	14b7f063          	bgeu	a5,a1,80004494 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
        return BAD_POINTER;
    }

    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    80004358:	00005797          	auipc	a5,0x5
    8000435c:	0407b783          	ld	a5,64(a5) # 80009398 <_ZN15MemoryAllocator4headE>
    80004360:	02c78063          	beq	a5,a2,80004380 <_ZN15MemoryAllocator8mem_freeEPv+0x88>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80004364:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80004368:	02078a63          	beqz	a5,8000439c <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
    8000436c:	0007b683          	ld	a3,0(a5)
    80004370:	02e6f663          	bgeu	a3,a4,8000439c <_ZN15MemoryAllocator8mem_freeEPv+0xa4>
        prev = curr;
    80004374:	00078613          	mv	a2,a5
        curr = curr->next;
    80004378:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000437c:	fedff06f          	j	80004368 <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        newFreeSegment->size = size;
    80004380:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80004384:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80004388:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000438c:	00005797          	auipc	a5,0x5
    80004390:	00e7b623          	sd	a4,12(a5) # 80009398 <_ZN15MemoryAllocator4headE>
        return 0;
    80004394:	00000513          	li	a0,0
    80004398:	0480006f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    }

    if(prev == nullptr) {
    8000439c:	04060863          	beqz	a2,800043ec <_ZN15MemoryAllocator8mem_freeEPv+0xf4>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    800043a0:	00063683          	ld	a3,0(a2)
    800043a4:	00863803          	ld	a6,8(a2)
    800043a8:	010686b3          	add	a3,a3,a6
    800043ac:	08e68a63          	beq	a3,a4,80004440 <_ZN15MemoryAllocator8mem_freeEPv+0x148>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800043b0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800043b4:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800043b8:	01063683          	ld	a3,16(a2)
    800043bc:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800043c0:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800043c4:	0e078063          	beqz	a5,800044a4 <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    800043c8:	0007b583          	ld	a1,0(a5)
    800043cc:	00073683          	ld	a3,0(a4)
    800043d0:	00873603          	ld	a2,8(a4)
    800043d4:	00c686b3          	add	a3,a3,a2
    800043d8:	06d58c63          	beq	a1,a3,80004450 <_ZN15MemoryAllocator8mem_freeEPv+0x158>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800043dc:	00000513          	li	a0,0
}
    800043e0:	00813403          	ld	s0,8(sp)
    800043e4:	01010113          	addi	sp,sp,16
    800043e8:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800043ec:	0a078863          	beqz	a5,8000449c <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
            newFreeSegment->size = size;
    800043f0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800043f4:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800043f8:	00005797          	auipc	a5,0x5
    800043fc:	fa07b783          	ld	a5,-96(a5) # 80009398 <_ZN15MemoryAllocator4headE>
    80004400:	0007b603          	ld	a2,0(a5)
    80004404:	00b706b3          	add	a3,a4,a1
    80004408:	00d60c63          	beq	a2,a3,80004420 <_ZN15MemoryAllocator8mem_freeEPv+0x128>
                newFreeSegment->next = head;
    8000440c:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80004410:	00005797          	auipc	a5,0x5
    80004414:	f8e7b423          	sd	a4,-120(a5) # 80009398 <_ZN15MemoryAllocator4headE>
            return 0;
    80004418:	00000513          	li	a0,0
    8000441c:	fc5ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
                newFreeSegment->size += head->size;
    80004420:	0087b783          	ld	a5,8(a5)
    80004424:	00b785b3          	add	a1,a5,a1
    80004428:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000442c:	00005797          	auipc	a5,0x5
    80004430:	f6c7b783          	ld	a5,-148(a5) # 80009398 <_ZN15MemoryAllocator4headE>
    80004434:	0107b783          	ld	a5,16(a5)
    80004438:	00f53423          	sd	a5,8(a0)
    8000443c:	fd5ff06f          	j	80004410 <_ZN15MemoryAllocator8mem_freeEPv+0x118>
            prev->size += size;
    80004440:	00b805b3          	add	a1,a6,a1
    80004444:	00b63423          	sd	a1,8(a2)
    80004448:	00060713          	mv	a4,a2
    8000444c:	f79ff06f          	j	800043c4 <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
            prev->size += curr->size;
    80004450:	0087b683          	ld	a3,8(a5)
    80004454:	00d60633          	add	a2,a2,a3
    80004458:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000445c:	0107b783          	ld	a5,16(a5)
    80004460:	00f73823          	sd	a5,16(a4)
    return 0;
    80004464:	00000513          	li	a0,0
    80004468:	f79ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    8000446c:	fff00513          	li	a0,-1
    80004470:	f71ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004474:	fff00513          	li	a0,-1
    80004478:	f69ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
        return BAD_POINTER;
    8000447c:	fff00513          	li	a0,-1
    80004480:	f61ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004484:	fff00513          	li	a0,-1
    80004488:	f59ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    8000448c:	fff00513          	li	a0,-1
    80004490:	f51ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    80004494:	fff00513          	li	a0,-1
    80004498:	f49ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
            return BAD_POINTER;
    8000449c:	fff00513          	li	a0,-1
    800044a0:	f41ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>
    return 0;
    800044a4:	00000513          	li	a0,0
    800044a8:	f39ff06f          	j	800043e0 <_ZN15MemoryAllocator8mem_freeEPv+0xe8>

00000000800044ac <_Z9kmem_initPvi>:
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    800044ac:	ff010113          	addi	sp,sp,-16
    800044b0:	00113423          	sd	ra,8(sp)
    800044b4:	00813023          	sd	s0,0(sp)
    800044b8:	01010413          	addi	s0,sp,16
    SlabAllocator::initAllocator(space, block_num);
    800044bc:	ffffe097          	auipc	ra,0xffffe
    800044c0:	0cc080e7          	jalr	204(ra) # 80002588 <_ZN13SlabAllocator13initAllocatorEPvi>
}
    800044c4:	00813083          	ld	ra,8(sp)
    800044c8:	00013403          	ld	s0,0(sp)
    800044cc:	01010113          	addi	sp,sp,16
    800044d0:	00008067          	ret

00000000800044d4 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800044d4:	ff010113          	addi	sp,sp,-16
    800044d8:	00113423          	sd	ra,8(sp)
    800044dc:	00813023          	sd	s0,0(sp)
    800044e0:	01010413          	addi	s0,sp,16
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
    800044e4:	ffffe097          	auipc	ra,0xffffe
    800044e8:	0cc080e7          	jalr	204(ra) # 800025b0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    800044ec:	00813083          	ld	ra,8(sp)
    800044f0:	00013403          	ld	s0,0(sp)
    800044f4:	01010113          	addi	sp,sp,16
    800044f8:	00008067          	ret

00000000800044fc <_Z17kmem_cache_shrinkP12kmem_cache_s>:

int kmem_cache_shrink(kmem_cache_t *cachep) {
    800044fc:	ff010113          	addi	sp,sp,-16
    80004500:	00113423          	sd	ra,8(sp)
    80004504:	00813023          	sd	s0,0(sp)
    80004508:	01010413          	addi	s0,sp,16
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
    8000450c:	ffffe097          	auipc	ra,0xffffe
    80004510:	1cc080e7          	jalr	460(ra) # 800026d8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>
}
    80004514:	00813083          	ld	ra,8(sp)
    80004518:	00013403          	ld	s0,0(sp)
    8000451c:	01010113          	addi	sp,sp,16
    80004520:	00008067          	ret

0000000080004524 <_Z16kmem_cache_allocP12kmem_cache_s>:
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    80004524:	ff010113          	addi	sp,sp,-16
    80004528:	00113423          	sd	ra,8(sp)
    8000452c:	00813023          	sd	s0,0(sp)
    80004530:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocSlot((Cache*)cachep);
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	0fc080e7          	jalr	252(ra) # 80002630 <_ZN13SlabAllocator9allocSlotEP5Cache>
}
    8000453c:	00813083          	ld	ra,8(sp)
    80004540:	00013403          	ld	s0,0(sp)
    80004544:	01010113          	addi	sp,sp,16
    80004548:	00008067          	ret

000000008000454c <_Z15kmem_cache_freeP12kmem_cache_sPv>:
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    8000454c:	ff010113          	addi	sp,sp,-16
    80004550:	00113423          	sd	ra,8(sp)
    80004554:	00813023          	sd	s0,0(sp)
    80004558:	01010413          	addi	s0,sp,16
    SlabAllocator::freeSlot((Cache*)cachep, objp);
    8000455c:	ffffe097          	auipc	ra,0xffffe
    80004560:	100080e7          	jalr	256(ra) # 8000265c <_ZN13SlabAllocator8freeSlotEP5CachePv>
}
    80004564:	00813083          	ld	ra,8(sp)
    80004568:	00013403          	ld	s0,0(sp)
    8000456c:	01010113          	addi	sp,sp,16
    80004570:	00008067          	ret

0000000080004574 <_Z7kmallocm>:

void *kmalloc(size_t size) {
    80004574:	ff010113          	addi	sp,sp,-16
    80004578:	00113423          	sd	ra,8(sp)
    8000457c:	00813023          	sd	s0,0(sp)
    80004580:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocBuff(size);
    80004584:	ffffe097          	auipc	ra,0xffffe
    80004588:	1a4080e7          	jalr	420(ra) # 80002728 <_ZN13SlabAllocator9allocBuffEm>
}
    8000458c:	00813083          	ld	ra,8(sp)
    80004590:	00013403          	ld	s0,0(sp)
    80004594:	01010113          	addi	sp,sp,16
    80004598:	00008067          	ret

000000008000459c <_Z5kfreePKv>:

void kfree(const void *objp) {
    8000459c:	ff010113          	addi	sp,sp,-16
    800045a0:	00113423          	sd	ra,8(sp)
    800045a4:	00813023          	sd	s0,0(sp)
    800045a8:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuff(objp);
    800045ac:	ffffe097          	auipc	ra,0xffffe
    800045b0:	1a8080e7          	jalr	424(ra) # 80002754 <_ZN13SlabAllocator8freeBuffEPKv>
}
    800045b4:	00813083          	ld	ra,8(sp)
    800045b8:	00013403          	ld	s0,0(sp)
    800045bc:	01010113          	addi	sp,sp,16
    800045c0:	00008067          	ret

00000000800045c4 <_Z18kmem_cache_destroyP12kmem_cache_s>:

void kmem_cache_destroy(kmem_cache_t *cachep) {
    800045c4:	ff010113          	addi	sp,sp,-16
    800045c8:	00113423          	sd	ra,8(sp)
    800045cc:	00813023          	sd	s0,0(sp)
    800045d0:	01010413          	addi	s0,sp,16
    SlabAllocator::deallocCache((Cache*)cachep);
    800045d4:	ffffe097          	auipc	ra,0xffffe
    800045d8:	12c080e7          	jalr	300(ra) # 80002700 <_ZN13SlabAllocator12deallocCacheEP5Cache>
}
    800045dc:	00813083          	ld	ra,8(sp)
    800045e0:	00013403          	ld	s0,0(sp)
    800045e4:	01010113          	addi	sp,sp,16
    800045e8:	00008067          	ret

00000000800045ec <_Z15kmem_cache_infoP12kmem_cache_s>:
void kmem_cache_info(kmem_cache_t *cachep) {
    800045ec:	ff010113          	addi	sp,sp,-16
    800045f0:	00113423          	sd	ra,8(sp)
    800045f4:	00813023          	sd	s0,0(sp)
    800045f8:	01010413          	addi	s0,sp,16
    SlabAllocator::printCacheInfo((Cache*)cachep);
    800045fc:	ffffe097          	auipc	ra,0xffffe
    80004600:	0b4080e7          	jalr	180(ra) # 800026b0 <_ZN13SlabAllocator14printCacheInfoEP5Cache>
}
    80004604:	00813083          	ld	ra,8(sp)
    80004608:	00013403          	ld	s0,0(sp)
    8000460c:	01010113          	addi	sp,sp,16
    80004610:	00008067          	ret

0000000080004614 <_Z16kmem_cache_errorP12kmem_cache_s>:
int kmem_cache_error(kmem_cache_t *cachep) {
    80004614:	ff010113          	addi	sp,sp,-16
    80004618:	00113423          	sd	ra,8(sp)
    8000461c:	00813023          	sd	s0,0(sp)
    80004620:	01010413          	addi	s0,sp,16
    return SlabAllocator::printErrorMessage((Cache*)cachep);
    80004624:	ffffe097          	auipc	ra,0xffffe
    80004628:	064080e7          	jalr	100(ra) # 80002688 <_ZN13SlabAllocator17printErrorMessageEP5Cache>
    8000462c:	00813083          	ld	ra,8(sp)
    80004630:	00013403          	ld	s0,0(sp)
    80004634:	01010113          	addi	sp,sp,16
    80004638:	00008067          	ret

000000008000463c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000463c:	fd010113          	addi	sp,sp,-48
    80004640:	02113423          	sd	ra,40(sp)
    80004644:	02813023          	sd	s0,32(sp)
    80004648:	00913c23          	sd	s1,24(sp)
    8000464c:	01213823          	sd	s2,16(sp)
    80004650:	01313423          	sd	s3,8(sp)
    80004654:	03010413          	addi	s0,sp,48
    80004658:	00050493          	mv	s1,a0
    8000465c:	00058913          	mv	s2,a1
    80004660:	0015879b          	addiw	a5,a1,1
    80004664:	0007851b          	sext.w	a0,a5
    80004668:	00f4a023          	sw	a5,0(s1)
    8000466c:	0004a823          	sw	zero,16(s1)
    80004670:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004674:	00251513          	slli	a0,a0,0x2
    80004678:	ffffd097          	auipc	ra,0xffffd
    8000467c:	b1c080e7          	jalr	-1252(ra) # 80001194 <_Z9mem_allocm>
    80004680:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004684:	01000513          	li	a0,16
    80004688:	fffff097          	auipc	ra,0xfffff
    8000468c:	b70080e7          	jalr	-1168(ra) # 800031f8 <_ZN9SemaphorenwEm>
    80004690:	00050993          	mv	s3,a0
    80004694:	00000593          	li	a1,0
    80004698:	fffff097          	auipc	ra,0xfffff
    8000469c:	a58080e7          	jalr	-1448(ra) # 800030f0 <_ZN9SemaphoreC1Ej>
    800046a0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800046a4:	01000513          	li	a0,16
    800046a8:	fffff097          	auipc	ra,0xfffff
    800046ac:	b50080e7          	jalr	-1200(ra) # 800031f8 <_ZN9SemaphorenwEm>
    800046b0:	00050993          	mv	s3,a0
    800046b4:	00090593          	mv	a1,s2
    800046b8:	fffff097          	auipc	ra,0xfffff
    800046bc:	a38080e7          	jalr	-1480(ra) # 800030f0 <_ZN9SemaphoreC1Ej>
    800046c0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800046c4:	01000513          	li	a0,16
    800046c8:	fffff097          	auipc	ra,0xfffff
    800046cc:	b30080e7          	jalr	-1232(ra) # 800031f8 <_ZN9SemaphorenwEm>
    800046d0:	00050913          	mv	s2,a0
    800046d4:	00100593          	li	a1,1
    800046d8:	fffff097          	auipc	ra,0xfffff
    800046dc:	a18080e7          	jalr	-1512(ra) # 800030f0 <_ZN9SemaphoreC1Ej>
    800046e0:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800046e4:	01000513          	li	a0,16
    800046e8:	fffff097          	auipc	ra,0xfffff
    800046ec:	b10080e7          	jalr	-1264(ra) # 800031f8 <_ZN9SemaphorenwEm>
    800046f0:	00050913          	mv	s2,a0
    800046f4:	00100593          	li	a1,1
    800046f8:	fffff097          	auipc	ra,0xfffff
    800046fc:	9f8080e7          	jalr	-1544(ra) # 800030f0 <_ZN9SemaphoreC1Ej>
    80004700:	0324b823          	sd	s2,48(s1)
}
    80004704:	02813083          	ld	ra,40(sp)
    80004708:	02013403          	ld	s0,32(sp)
    8000470c:	01813483          	ld	s1,24(sp)
    80004710:	01013903          	ld	s2,16(sp)
    80004714:	00813983          	ld	s3,8(sp)
    80004718:	03010113          	addi	sp,sp,48
    8000471c:	00008067          	ret
    80004720:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004724:	00098513          	mv	a0,s3
    80004728:	fffff097          	auipc	ra,0xfffff
    8000472c:	a68080e7          	jalr	-1432(ra) # 80003190 <_ZN9SemaphoredlEPv>
    80004730:	00048513          	mv	a0,s1
    80004734:	00006097          	auipc	ra,0x6
    80004738:	d34080e7          	jalr	-716(ra) # 8000a468 <_Unwind_Resume>
    8000473c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004740:	00098513          	mv	a0,s3
    80004744:	fffff097          	auipc	ra,0xfffff
    80004748:	a4c080e7          	jalr	-1460(ra) # 80003190 <_ZN9SemaphoredlEPv>
    8000474c:	00048513          	mv	a0,s1
    80004750:	00006097          	auipc	ra,0x6
    80004754:	d18080e7          	jalr	-744(ra) # 8000a468 <_Unwind_Resume>
    80004758:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000475c:	00090513          	mv	a0,s2
    80004760:	fffff097          	auipc	ra,0xfffff
    80004764:	a30080e7          	jalr	-1488(ra) # 80003190 <_ZN9SemaphoredlEPv>
    80004768:	00048513          	mv	a0,s1
    8000476c:	00006097          	auipc	ra,0x6
    80004770:	cfc080e7          	jalr	-772(ra) # 8000a468 <_Unwind_Resume>
    80004774:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004778:	00090513          	mv	a0,s2
    8000477c:	fffff097          	auipc	ra,0xfffff
    80004780:	a14080e7          	jalr	-1516(ra) # 80003190 <_ZN9SemaphoredlEPv>
    80004784:	00048513          	mv	a0,s1
    80004788:	00006097          	auipc	ra,0x6
    8000478c:	ce0080e7          	jalr	-800(ra) # 8000a468 <_Unwind_Resume>

0000000080004790 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004790:	fe010113          	addi	sp,sp,-32
    80004794:	00113c23          	sd	ra,24(sp)
    80004798:	00813823          	sd	s0,16(sp)
    8000479c:	00913423          	sd	s1,8(sp)
    800047a0:	01213023          	sd	s2,0(sp)
    800047a4:	02010413          	addi	s0,sp,32
    800047a8:	00050493          	mv	s1,a0
    800047ac:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800047b0:	01853503          	ld	a0,24(a0)
    800047b4:	fffff097          	auipc	ra,0xfffff
    800047b8:	984080e7          	jalr	-1660(ra) # 80003138 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800047bc:	0304b503          	ld	a0,48(s1)
    800047c0:	fffff097          	auipc	ra,0xfffff
    800047c4:	978080e7          	jalr	-1672(ra) # 80003138 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800047c8:	0084b783          	ld	a5,8(s1)
    800047cc:	0144a703          	lw	a4,20(s1)
    800047d0:	00271713          	slli	a4,a4,0x2
    800047d4:	00e787b3          	add	a5,a5,a4
    800047d8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800047dc:	0144a783          	lw	a5,20(s1)
    800047e0:	0017879b          	addiw	a5,a5,1
    800047e4:	0004a703          	lw	a4,0(s1)
    800047e8:	02e7e7bb          	remw	a5,a5,a4
    800047ec:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800047f0:	0304b503          	ld	a0,48(s1)
    800047f4:	fffff097          	auipc	ra,0xfffff
    800047f8:	970080e7          	jalr	-1680(ra) # 80003164 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800047fc:	0204b503          	ld	a0,32(s1)
    80004800:	fffff097          	auipc	ra,0xfffff
    80004804:	964080e7          	jalr	-1692(ra) # 80003164 <_ZN9Semaphore6signalEv>

}
    80004808:	01813083          	ld	ra,24(sp)
    8000480c:	01013403          	ld	s0,16(sp)
    80004810:	00813483          	ld	s1,8(sp)
    80004814:	00013903          	ld	s2,0(sp)
    80004818:	02010113          	addi	sp,sp,32
    8000481c:	00008067          	ret

0000000080004820 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004820:	fe010113          	addi	sp,sp,-32
    80004824:	00113c23          	sd	ra,24(sp)
    80004828:	00813823          	sd	s0,16(sp)
    8000482c:	00913423          	sd	s1,8(sp)
    80004830:	01213023          	sd	s2,0(sp)
    80004834:	02010413          	addi	s0,sp,32
    80004838:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000483c:	02053503          	ld	a0,32(a0)
    80004840:	fffff097          	auipc	ra,0xfffff
    80004844:	8f8080e7          	jalr	-1800(ra) # 80003138 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004848:	0284b503          	ld	a0,40(s1)
    8000484c:	fffff097          	auipc	ra,0xfffff
    80004850:	8ec080e7          	jalr	-1812(ra) # 80003138 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004854:	0084b703          	ld	a4,8(s1)
    80004858:	0104a783          	lw	a5,16(s1)
    8000485c:	00279693          	slli	a3,a5,0x2
    80004860:	00d70733          	add	a4,a4,a3
    80004864:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004868:	0017879b          	addiw	a5,a5,1
    8000486c:	0004a703          	lw	a4,0(s1)
    80004870:	02e7e7bb          	remw	a5,a5,a4
    80004874:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004878:	0284b503          	ld	a0,40(s1)
    8000487c:	fffff097          	auipc	ra,0xfffff
    80004880:	8e8080e7          	jalr	-1816(ra) # 80003164 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004884:	0184b503          	ld	a0,24(s1)
    80004888:	fffff097          	auipc	ra,0xfffff
    8000488c:	8dc080e7          	jalr	-1828(ra) # 80003164 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004890:	00090513          	mv	a0,s2
    80004894:	01813083          	ld	ra,24(sp)
    80004898:	01013403          	ld	s0,16(sp)
    8000489c:	00813483          	ld	s1,8(sp)
    800048a0:	00013903          	ld	s2,0(sp)
    800048a4:	02010113          	addi	sp,sp,32
    800048a8:	00008067          	ret

00000000800048ac <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800048ac:	fe010113          	addi	sp,sp,-32
    800048b0:	00113c23          	sd	ra,24(sp)
    800048b4:	00813823          	sd	s0,16(sp)
    800048b8:	00913423          	sd	s1,8(sp)
    800048bc:	01213023          	sd	s2,0(sp)
    800048c0:	02010413          	addi	s0,sp,32
    800048c4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800048c8:	02853503          	ld	a0,40(a0)
    800048cc:	fffff097          	auipc	ra,0xfffff
    800048d0:	86c080e7          	jalr	-1940(ra) # 80003138 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800048d4:	0304b503          	ld	a0,48(s1)
    800048d8:	fffff097          	auipc	ra,0xfffff
    800048dc:	860080e7          	jalr	-1952(ra) # 80003138 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800048e0:	0144a783          	lw	a5,20(s1)
    800048e4:	0104a903          	lw	s2,16(s1)
    800048e8:	0327ce63          	blt	a5,s2,80004924 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800048ec:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800048f0:	0304b503          	ld	a0,48(s1)
    800048f4:	fffff097          	auipc	ra,0xfffff
    800048f8:	870080e7          	jalr	-1936(ra) # 80003164 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800048fc:	0284b503          	ld	a0,40(s1)
    80004900:	fffff097          	auipc	ra,0xfffff
    80004904:	864080e7          	jalr	-1948(ra) # 80003164 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004908:	00090513          	mv	a0,s2
    8000490c:	01813083          	ld	ra,24(sp)
    80004910:	01013403          	ld	s0,16(sp)
    80004914:	00813483          	ld	s1,8(sp)
    80004918:	00013903          	ld	s2,0(sp)
    8000491c:	02010113          	addi	sp,sp,32
    80004920:	00008067          	ret
        ret = cap - head + tail;
    80004924:	0004a703          	lw	a4,0(s1)
    80004928:	4127093b          	subw	s2,a4,s2
    8000492c:	00f9093b          	addw	s2,s2,a5
    80004930:	fc1ff06f          	j	800048f0 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004934 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004934:	fe010113          	addi	sp,sp,-32
    80004938:	00113c23          	sd	ra,24(sp)
    8000493c:	00813823          	sd	s0,16(sp)
    80004940:	00913423          	sd	s1,8(sp)
    80004944:	02010413          	addi	s0,sp,32
    80004948:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000494c:	00a00513          	li	a0,10
    80004950:	fffff097          	auipc	ra,0xfffff
    80004954:	974080e7          	jalr	-1676(ra) # 800032c4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004958:	00003517          	auipc	a0,0x3
    8000495c:	99850513          	addi	a0,a0,-1640 # 800072f0 <CONSOLE_STATUS+0x2e0>
    80004960:	ffffe097          	auipc	ra,0xffffe
    80004964:	e20080e7          	jalr	-480(ra) # 80002780 <_Z11printStringPKc>
    while (getCnt()) {
    80004968:	00048513          	mv	a0,s1
    8000496c:	00000097          	auipc	ra,0x0
    80004970:	f40080e7          	jalr	-192(ra) # 800048ac <_ZN9BufferCPP6getCntEv>
    80004974:	02050c63          	beqz	a0,800049ac <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004978:	0084b783          	ld	a5,8(s1)
    8000497c:	0104a703          	lw	a4,16(s1)
    80004980:	00271713          	slli	a4,a4,0x2
    80004984:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004988:	0007c503          	lbu	a0,0(a5)
    8000498c:	fffff097          	auipc	ra,0xfffff
    80004990:	938080e7          	jalr	-1736(ra) # 800032c4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004994:	0104a783          	lw	a5,16(s1)
    80004998:	0017879b          	addiw	a5,a5,1
    8000499c:	0004a703          	lw	a4,0(s1)
    800049a0:	02e7e7bb          	remw	a5,a5,a4
    800049a4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800049a8:	fc1ff06f          	j	80004968 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800049ac:	02100513          	li	a0,33
    800049b0:	fffff097          	auipc	ra,0xfffff
    800049b4:	914080e7          	jalr	-1772(ra) # 800032c4 <_ZN7Console4putcEc>
    Console::putc('\n');
    800049b8:	00a00513          	li	a0,10
    800049bc:	fffff097          	auipc	ra,0xfffff
    800049c0:	908080e7          	jalr	-1784(ra) # 800032c4 <_ZN7Console4putcEc>
    mem_free(buffer);
    800049c4:	0084b503          	ld	a0,8(s1)
    800049c8:	ffffd097          	auipc	ra,0xffffd
    800049cc:	80c080e7          	jalr	-2036(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    800049d0:	0204b503          	ld	a0,32(s1)
    800049d4:	00050863          	beqz	a0,800049e4 <_ZN9BufferCPPD1Ev+0xb0>
    800049d8:	00053783          	ld	a5,0(a0)
    800049dc:	0087b783          	ld	a5,8(a5)
    800049e0:	000780e7          	jalr	a5
    delete spaceAvailable;
    800049e4:	0184b503          	ld	a0,24(s1)
    800049e8:	00050863          	beqz	a0,800049f8 <_ZN9BufferCPPD1Ev+0xc4>
    800049ec:	00053783          	ld	a5,0(a0)
    800049f0:	0087b783          	ld	a5,8(a5)
    800049f4:	000780e7          	jalr	a5
    delete mutexTail;
    800049f8:	0304b503          	ld	a0,48(s1)
    800049fc:	00050863          	beqz	a0,80004a0c <_ZN9BufferCPPD1Ev+0xd8>
    80004a00:	00053783          	ld	a5,0(a0)
    80004a04:	0087b783          	ld	a5,8(a5)
    80004a08:	000780e7          	jalr	a5
    delete mutexHead;
    80004a0c:	0284b503          	ld	a0,40(s1)
    80004a10:	00050863          	beqz	a0,80004a20 <_ZN9BufferCPPD1Ev+0xec>
    80004a14:	00053783          	ld	a5,0(a0)
    80004a18:	0087b783          	ld	a5,8(a5)
    80004a1c:	000780e7          	jalr	a5
}
    80004a20:	01813083          	ld	ra,24(sp)
    80004a24:	01013403          	ld	s0,16(sp)
    80004a28:	00813483          	ld	s1,8(sp)
    80004a2c:	02010113          	addi	sp,sp,32
    80004a30:	00008067          	ret

0000000080004a34 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004a34:	fe010113          	addi	sp,sp,-32
    80004a38:	00113c23          	sd	ra,24(sp)
    80004a3c:	00813823          	sd	s0,16(sp)
    80004a40:	00913423          	sd	s1,8(sp)
    80004a44:	01213023          	sd	s2,0(sp)
    80004a48:	02010413          	addi	s0,sp,32
    80004a4c:	00050493          	mv	s1,a0
    80004a50:	00058913          	mv	s2,a1
    80004a54:	0015879b          	addiw	a5,a1,1
    80004a58:	0007851b          	sext.w	a0,a5
    80004a5c:	00f4a023          	sw	a5,0(s1)
    80004a60:	0004a823          	sw	zero,16(s1)
    80004a64:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004a68:	00251513          	slli	a0,a0,0x2
    80004a6c:	ffffc097          	auipc	ra,0xffffc
    80004a70:	728080e7          	jalr	1832(ra) # 80001194 <_Z9mem_allocm>
    80004a74:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004a78:	00000593          	li	a1,0
    80004a7c:	02048513          	addi	a0,s1,32
    80004a80:	ffffd097          	auipc	ra,0xffffd
    80004a84:	8d0080e7          	jalr	-1840(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80004a88:	00090593          	mv	a1,s2
    80004a8c:	01848513          	addi	a0,s1,24
    80004a90:	ffffd097          	auipc	ra,0xffffd
    80004a94:	8c0080e7          	jalr	-1856(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80004a98:	00100593          	li	a1,1
    80004a9c:	02848513          	addi	a0,s1,40
    80004aa0:	ffffd097          	auipc	ra,0xffffd
    80004aa4:	8b0080e7          	jalr	-1872(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80004aa8:	00100593          	li	a1,1
    80004aac:	03048513          	addi	a0,s1,48
    80004ab0:	ffffd097          	auipc	ra,0xffffd
    80004ab4:	8a0080e7          	jalr	-1888(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80004ab8:	01813083          	ld	ra,24(sp)
    80004abc:	01013403          	ld	s0,16(sp)
    80004ac0:	00813483          	ld	s1,8(sp)
    80004ac4:	00013903          	ld	s2,0(sp)
    80004ac8:	02010113          	addi	sp,sp,32
    80004acc:	00008067          	ret

0000000080004ad0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004ad0:	fe010113          	addi	sp,sp,-32
    80004ad4:	00113c23          	sd	ra,24(sp)
    80004ad8:	00813823          	sd	s0,16(sp)
    80004adc:	00913423          	sd	s1,8(sp)
    80004ae0:	01213023          	sd	s2,0(sp)
    80004ae4:	02010413          	addi	s0,sp,32
    80004ae8:	00050493          	mv	s1,a0
    80004aec:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004af0:	01853503          	ld	a0,24(a0)
    80004af4:	ffffd097          	auipc	ra,0xffffd
    80004af8:	8a4080e7          	jalr	-1884(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80004afc:	0304b503          	ld	a0,48(s1)
    80004b00:	ffffd097          	auipc	ra,0xffffd
    80004b04:	898080e7          	jalr	-1896(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80004b08:	0084b783          	ld	a5,8(s1)
    80004b0c:	0144a703          	lw	a4,20(s1)
    80004b10:	00271713          	slli	a4,a4,0x2
    80004b14:	00e787b3          	add	a5,a5,a4
    80004b18:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004b1c:	0144a783          	lw	a5,20(s1)
    80004b20:	0017879b          	addiw	a5,a5,1
    80004b24:	0004a703          	lw	a4,0(s1)
    80004b28:	02e7e7bb          	remw	a5,a5,a4
    80004b2c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004b30:	0304b503          	ld	a0,48(s1)
    80004b34:	ffffd097          	auipc	ra,0xffffd
    80004b38:	8ac080e7          	jalr	-1876(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80004b3c:	0204b503          	ld	a0,32(s1)
    80004b40:	ffffd097          	auipc	ra,0xffffd
    80004b44:	8a0080e7          	jalr	-1888(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80004b48:	01813083          	ld	ra,24(sp)
    80004b4c:	01013403          	ld	s0,16(sp)
    80004b50:	00813483          	ld	s1,8(sp)
    80004b54:	00013903          	ld	s2,0(sp)
    80004b58:	02010113          	addi	sp,sp,32
    80004b5c:	00008067          	ret

0000000080004b60 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004b60:	fe010113          	addi	sp,sp,-32
    80004b64:	00113c23          	sd	ra,24(sp)
    80004b68:	00813823          	sd	s0,16(sp)
    80004b6c:	00913423          	sd	s1,8(sp)
    80004b70:	01213023          	sd	s2,0(sp)
    80004b74:	02010413          	addi	s0,sp,32
    80004b78:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004b7c:	02053503          	ld	a0,32(a0)
    80004b80:	ffffd097          	auipc	ra,0xffffd
    80004b84:	818080e7          	jalr	-2024(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80004b88:	0284b503          	ld	a0,40(s1)
    80004b8c:	ffffd097          	auipc	ra,0xffffd
    80004b90:	80c080e7          	jalr	-2036(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80004b94:	0084b703          	ld	a4,8(s1)
    80004b98:	0104a783          	lw	a5,16(s1)
    80004b9c:	00279693          	slli	a3,a5,0x2
    80004ba0:	00d70733          	add	a4,a4,a3
    80004ba4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004ba8:	0017879b          	addiw	a5,a5,1
    80004bac:	0004a703          	lw	a4,0(s1)
    80004bb0:	02e7e7bb          	remw	a5,a5,a4
    80004bb4:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004bb8:	0284b503          	ld	a0,40(s1)
    80004bbc:	ffffd097          	auipc	ra,0xffffd
    80004bc0:	824080e7          	jalr	-2012(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80004bc4:	0184b503          	ld	a0,24(s1)
    80004bc8:	ffffd097          	auipc	ra,0xffffd
    80004bcc:	818080e7          	jalr	-2024(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80004bd0:	00090513          	mv	a0,s2
    80004bd4:	01813083          	ld	ra,24(sp)
    80004bd8:	01013403          	ld	s0,16(sp)
    80004bdc:	00813483          	ld	s1,8(sp)
    80004be0:	00013903          	ld	s2,0(sp)
    80004be4:	02010113          	addi	sp,sp,32
    80004be8:	00008067          	ret

0000000080004bec <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004bec:	fe010113          	addi	sp,sp,-32
    80004bf0:	00113c23          	sd	ra,24(sp)
    80004bf4:	00813823          	sd	s0,16(sp)
    80004bf8:	00913423          	sd	s1,8(sp)
    80004bfc:	01213023          	sd	s2,0(sp)
    80004c00:	02010413          	addi	s0,sp,32
    80004c04:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004c08:	02853503          	ld	a0,40(a0)
    80004c0c:	ffffc097          	auipc	ra,0xffffc
    80004c10:	78c080e7          	jalr	1932(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    80004c14:	0304b503          	ld	a0,48(s1)
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	780080e7          	jalr	1920(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    80004c20:	0144a783          	lw	a5,20(s1)
    80004c24:	0104a903          	lw	s2,16(s1)
    80004c28:	0327ce63          	blt	a5,s2,80004c64 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004c2c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004c30:	0304b503          	ld	a0,48(s1)
    80004c34:	ffffc097          	auipc	ra,0xffffc
    80004c38:	7ac080e7          	jalr	1964(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    80004c3c:	0284b503          	ld	a0,40(s1)
    80004c40:	ffffc097          	auipc	ra,0xffffc
    80004c44:	7a0080e7          	jalr	1952(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80004c48:	00090513          	mv	a0,s2
    80004c4c:	01813083          	ld	ra,24(sp)
    80004c50:	01013403          	ld	s0,16(sp)
    80004c54:	00813483          	ld	s1,8(sp)
    80004c58:	00013903          	ld	s2,0(sp)
    80004c5c:	02010113          	addi	sp,sp,32
    80004c60:	00008067          	ret
        ret = cap - head + tail;
    80004c64:	0004a703          	lw	a4,0(s1)
    80004c68:	4127093b          	subw	s2,a4,s2
    80004c6c:	00f9093b          	addw	s2,s2,a5
    80004c70:	fc1ff06f          	j	80004c30 <_ZN6Buffer6getCntEv+0x44>

0000000080004c74 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80004c74:	fe010113          	addi	sp,sp,-32
    80004c78:	00113c23          	sd	ra,24(sp)
    80004c7c:	00813823          	sd	s0,16(sp)
    80004c80:	00913423          	sd	s1,8(sp)
    80004c84:	02010413          	addi	s0,sp,32
    80004c88:	00050493          	mv	s1,a0
    putc('\n');
    80004c8c:	00a00513          	li	a0,10
    80004c90:	ffffd097          	auipc	ra,0xffffd
    80004c94:	848080e7          	jalr	-1976(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004c98:	00002517          	auipc	a0,0x2
    80004c9c:	65850513          	addi	a0,a0,1624 # 800072f0 <CONSOLE_STATUS+0x2e0>
    80004ca0:	ffffe097          	auipc	ra,0xffffe
    80004ca4:	ae0080e7          	jalr	-1312(ra) # 80002780 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004ca8:	00048513          	mv	a0,s1
    80004cac:	00000097          	auipc	ra,0x0
    80004cb0:	f40080e7          	jalr	-192(ra) # 80004bec <_ZN6Buffer6getCntEv>
    80004cb4:	02a05c63          	blez	a0,80004cec <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004cb8:	0084b783          	ld	a5,8(s1)
    80004cbc:	0104a703          	lw	a4,16(s1)
    80004cc0:	00271713          	slli	a4,a4,0x2
    80004cc4:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80004cc8:	0007c503          	lbu	a0,0(a5)
    80004ccc:	ffffd097          	auipc	ra,0xffffd
    80004cd0:	80c080e7          	jalr	-2036(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    80004cd4:	0104a783          	lw	a5,16(s1)
    80004cd8:	0017879b          	addiw	a5,a5,1
    80004cdc:	0004a703          	lw	a4,0(s1)
    80004ce0:	02e7e7bb          	remw	a5,a5,a4
    80004ce4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80004ce8:	fc1ff06f          	j	80004ca8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004cec:	02100513          	li	a0,33
    80004cf0:	ffffc097          	auipc	ra,0xffffc
    80004cf4:	7e8080e7          	jalr	2024(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    80004cf8:	00a00513          	li	a0,10
    80004cfc:	ffffc097          	auipc	ra,0xffffc
    80004d00:	7dc080e7          	jalr	2012(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    80004d04:	0084b503          	ld	a0,8(s1)
    80004d08:	ffffc097          	auipc	ra,0xffffc
    80004d0c:	4cc080e7          	jalr	1228(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004d10:	0204b503          	ld	a0,32(s1)
    80004d14:	ffffc097          	auipc	ra,0xffffc
    80004d18:	70c080e7          	jalr	1804(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    80004d1c:	0184b503          	ld	a0,24(s1)
    80004d20:	ffffc097          	auipc	ra,0xffffc
    80004d24:	700080e7          	jalr	1792(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    80004d28:	0304b503          	ld	a0,48(s1)
    80004d2c:	ffffc097          	auipc	ra,0xffffc
    80004d30:	6f4080e7          	jalr	1780(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80004d34:	0284b503          	ld	a0,40(s1)
    80004d38:	ffffc097          	auipc	ra,0xffffc
    80004d3c:	6e8080e7          	jalr	1768(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80004d40:	01813083          	ld	ra,24(sp)
    80004d44:	01013403          	ld	s0,16(sp)
    80004d48:	00813483          	ld	s1,8(sp)
    80004d4c:	02010113          	addi	sp,sp,32
    80004d50:	00008067          	ret

0000000080004d54 <start>:
    80004d54:	ff010113          	addi	sp,sp,-16
    80004d58:	00813423          	sd	s0,8(sp)
    80004d5c:	01010413          	addi	s0,sp,16
    80004d60:	300027f3          	csrr	a5,mstatus
    80004d64:	ffffe737          	lui	a4,0xffffe
    80004d68:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff41ff>
    80004d6c:	00e7f7b3          	and	a5,a5,a4
    80004d70:	00001737          	lui	a4,0x1
    80004d74:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d78:	00e7e7b3          	or	a5,a5,a4
    80004d7c:	30079073          	csrw	mstatus,a5
    80004d80:	00000797          	auipc	a5,0x0
    80004d84:	16078793          	addi	a5,a5,352 # 80004ee0 <system_main>
    80004d88:	34179073          	csrw	mepc,a5
    80004d8c:	00000793          	li	a5,0
    80004d90:	18079073          	csrw	satp,a5
    80004d94:	000107b7          	lui	a5,0x10
    80004d98:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004d9c:	30279073          	csrw	medeleg,a5
    80004da0:	30379073          	csrw	mideleg,a5
    80004da4:	104027f3          	csrr	a5,sie
    80004da8:	2227e793          	ori	a5,a5,546
    80004dac:	10479073          	csrw	sie,a5
    80004db0:	fff00793          	li	a5,-1
    80004db4:	00a7d793          	srli	a5,a5,0xa
    80004db8:	3b079073          	csrw	pmpaddr0,a5
    80004dbc:	00f00793          	li	a5,15
    80004dc0:	3a079073          	csrw	pmpcfg0,a5
    80004dc4:	f14027f3          	csrr	a5,mhartid
    80004dc8:	0200c737          	lui	a4,0x200c
    80004dcc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004dd0:	0007869b          	sext.w	a3,a5
    80004dd4:	00269713          	slli	a4,a3,0x2
    80004dd8:	000f4637          	lui	a2,0xf4
    80004ddc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004de0:	00d70733          	add	a4,a4,a3
    80004de4:	0037979b          	slliw	a5,a5,0x3
    80004de8:	020046b7          	lui	a3,0x2004
    80004dec:	00d787b3          	add	a5,a5,a3
    80004df0:	00c585b3          	add	a1,a1,a2
    80004df4:	00371693          	slli	a3,a4,0x3
    80004df8:	00004717          	auipc	a4,0x4
    80004dfc:	5a870713          	addi	a4,a4,1448 # 800093a0 <timer_scratch>
    80004e00:	00b7b023          	sd	a1,0(a5)
    80004e04:	00d70733          	add	a4,a4,a3
    80004e08:	00f73c23          	sd	a5,24(a4)
    80004e0c:	02c73023          	sd	a2,32(a4)
    80004e10:	34071073          	csrw	mscratch,a4
    80004e14:	00000797          	auipc	a5,0x0
    80004e18:	6ec78793          	addi	a5,a5,1772 # 80005500 <timervec>
    80004e1c:	30579073          	csrw	mtvec,a5
    80004e20:	300027f3          	csrr	a5,mstatus
    80004e24:	0087e793          	ori	a5,a5,8
    80004e28:	30079073          	csrw	mstatus,a5
    80004e2c:	304027f3          	csrr	a5,mie
    80004e30:	0807e793          	ori	a5,a5,128
    80004e34:	30479073          	csrw	mie,a5
    80004e38:	f14027f3          	csrr	a5,mhartid
    80004e3c:	0007879b          	sext.w	a5,a5
    80004e40:	00078213          	mv	tp,a5
    80004e44:	30200073          	mret
    80004e48:	00813403          	ld	s0,8(sp)
    80004e4c:	01010113          	addi	sp,sp,16
    80004e50:	00008067          	ret

0000000080004e54 <timerinit>:
    80004e54:	ff010113          	addi	sp,sp,-16
    80004e58:	00813423          	sd	s0,8(sp)
    80004e5c:	01010413          	addi	s0,sp,16
    80004e60:	f14027f3          	csrr	a5,mhartid
    80004e64:	0200c737          	lui	a4,0x200c
    80004e68:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004e6c:	0007869b          	sext.w	a3,a5
    80004e70:	00269713          	slli	a4,a3,0x2
    80004e74:	000f4637          	lui	a2,0xf4
    80004e78:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004e7c:	00d70733          	add	a4,a4,a3
    80004e80:	0037979b          	slliw	a5,a5,0x3
    80004e84:	020046b7          	lui	a3,0x2004
    80004e88:	00d787b3          	add	a5,a5,a3
    80004e8c:	00c585b3          	add	a1,a1,a2
    80004e90:	00371693          	slli	a3,a4,0x3
    80004e94:	00004717          	auipc	a4,0x4
    80004e98:	50c70713          	addi	a4,a4,1292 # 800093a0 <timer_scratch>
    80004e9c:	00b7b023          	sd	a1,0(a5)
    80004ea0:	00d70733          	add	a4,a4,a3
    80004ea4:	00f73c23          	sd	a5,24(a4)
    80004ea8:	02c73023          	sd	a2,32(a4)
    80004eac:	34071073          	csrw	mscratch,a4
    80004eb0:	00000797          	auipc	a5,0x0
    80004eb4:	65078793          	addi	a5,a5,1616 # 80005500 <timervec>
    80004eb8:	30579073          	csrw	mtvec,a5
    80004ebc:	300027f3          	csrr	a5,mstatus
    80004ec0:	0087e793          	ori	a5,a5,8
    80004ec4:	30079073          	csrw	mstatus,a5
    80004ec8:	304027f3          	csrr	a5,mie
    80004ecc:	0807e793          	ori	a5,a5,128
    80004ed0:	30479073          	csrw	mie,a5
    80004ed4:	00813403          	ld	s0,8(sp)
    80004ed8:	01010113          	addi	sp,sp,16
    80004edc:	00008067          	ret

0000000080004ee0 <system_main>:
    80004ee0:	fe010113          	addi	sp,sp,-32
    80004ee4:	00813823          	sd	s0,16(sp)
    80004ee8:	00913423          	sd	s1,8(sp)
    80004eec:	00113c23          	sd	ra,24(sp)
    80004ef0:	02010413          	addi	s0,sp,32
    80004ef4:	00000097          	auipc	ra,0x0
    80004ef8:	0c4080e7          	jalr	196(ra) # 80004fb8 <cpuid>
    80004efc:	00004497          	auipc	s1,0x4
    80004f00:	30448493          	addi	s1,s1,772 # 80009200 <started>
    80004f04:	02050263          	beqz	a0,80004f28 <system_main+0x48>
    80004f08:	0004a783          	lw	a5,0(s1)
    80004f0c:	0007879b          	sext.w	a5,a5
    80004f10:	fe078ce3          	beqz	a5,80004f08 <system_main+0x28>
    80004f14:	0ff0000f          	fence
    80004f18:	00002517          	auipc	a0,0x2
    80004f1c:	42050513          	addi	a0,a0,1056 # 80007338 <CONSOLE_STATUS+0x328>
    80004f20:	00001097          	auipc	ra,0x1
    80004f24:	a7c080e7          	jalr	-1412(ra) # 8000599c <panic>
    80004f28:	00001097          	auipc	ra,0x1
    80004f2c:	9d0080e7          	jalr	-1584(ra) # 800058f8 <consoleinit>
    80004f30:	00001097          	auipc	ra,0x1
    80004f34:	15c080e7          	jalr	348(ra) # 8000608c <printfinit>
    80004f38:	00002517          	auipc	a0,0x2
    80004f3c:	2f050513          	addi	a0,a0,752 # 80007228 <CONSOLE_STATUS+0x218>
    80004f40:	00001097          	auipc	ra,0x1
    80004f44:	ab8080e7          	jalr	-1352(ra) # 800059f8 <__printf>
    80004f48:	00002517          	auipc	a0,0x2
    80004f4c:	3c050513          	addi	a0,a0,960 # 80007308 <CONSOLE_STATUS+0x2f8>
    80004f50:	00001097          	auipc	ra,0x1
    80004f54:	aa8080e7          	jalr	-1368(ra) # 800059f8 <__printf>
    80004f58:	00002517          	auipc	a0,0x2
    80004f5c:	2d050513          	addi	a0,a0,720 # 80007228 <CONSOLE_STATUS+0x218>
    80004f60:	00001097          	auipc	ra,0x1
    80004f64:	a98080e7          	jalr	-1384(ra) # 800059f8 <__printf>
    80004f68:	00001097          	auipc	ra,0x1
    80004f6c:	4b0080e7          	jalr	1200(ra) # 80006418 <kinit>
    80004f70:	00000097          	auipc	ra,0x0
    80004f74:	148080e7          	jalr	328(ra) # 800050b8 <trapinit>
    80004f78:	00000097          	auipc	ra,0x0
    80004f7c:	16c080e7          	jalr	364(ra) # 800050e4 <trapinithart>
    80004f80:	00000097          	auipc	ra,0x0
    80004f84:	5c0080e7          	jalr	1472(ra) # 80005540 <plicinit>
    80004f88:	00000097          	auipc	ra,0x0
    80004f8c:	5e0080e7          	jalr	1504(ra) # 80005568 <plicinithart>
    80004f90:	00000097          	auipc	ra,0x0
    80004f94:	078080e7          	jalr	120(ra) # 80005008 <userinit>
    80004f98:	0ff0000f          	fence
    80004f9c:	00100793          	li	a5,1
    80004fa0:	00002517          	auipc	a0,0x2
    80004fa4:	38050513          	addi	a0,a0,896 # 80007320 <CONSOLE_STATUS+0x310>
    80004fa8:	00f4a023          	sw	a5,0(s1)
    80004fac:	00001097          	auipc	ra,0x1
    80004fb0:	a4c080e7          	jalr	-1460(ra) # 800059f8 <__printf>
    80004fb4:	0000006f          	j	80004fb4 <system_main+0xd4>

0000000080004fb8 <cpuid>:
    80004fb8:	ff010113          	addi	sp,sp,-16
    80004fbc:	00813423          	sd	s0,8(sp)
    80004fc0:	01010413          	addi	s0,sp,16
    80004fc4:	00020513          	mv	a0,tp
    80004fc8:	00813403          	ld	s0,8(sp)
    80004fcc:	0005051b          	sext.w	a0,a0
    80004fd0:	01010113          	addi	sp,sp,16
    80004fd4:	00008067          	ret

0000000080004fd8 <mycpu>:
    80004fd8:	ff010113          	addi	sp,sp,-16
    80004fdc:	00813423          	sd	s0,8(sp)
    80004fe0:	01010413          	addi	s0,sp,16
    80004fe4:	00020793          	mv	a5,tp
    80004fe8:	00813403          	ld	s0,8(sp)
    80004fec:	0007879b          	sext.w	a5,a5
    80004ff0:	00779793          	slli	a5,a5,0x7
    80004ff4:	00005517          	auipc	a0,0x5
    80004ff8:	3dc50513          	addi	a0,a0,988 # 8000a3d0 <cpus>
    80004ffc:	00f50533          	add	a0,a0,a5
    80005000:	01010113          	addi	sp,sp,16
    80005004:	00008067          	ret

0000000080005008 <userinit>:
    80005008:	ff010113          	addi	sp,sp,-16
    8000500c:	00813423          	sd	s0,8(sp)
    80005010:	01010413          	addi	s0,sp,16
    80005014:	00813403          	ld	s0,8(sp)
    80005018:	01010113          	addi	sp,sp,16
    8000501c:	ffffe317          	auipc	t1,0xffffe
    80005020:	ba430067          	jr	-1116(t1) # 80002bc0 <main>

0000000080005024 <either_copyout>:
    80005024:	ff010113          	addi	sp,sp,-16
    80005028:	00813023          	sd	s0,0(sp)
    8000502c:	00113423          	sd	ra,8(sp)
    80005030:	01010413          	addi	s0,sp,16
    80005034:	02051663          	bnez	a0,80005060 <either_copyout+0x3c>
    80005038:	00058513          	mv	a0,a1
    8000503c:	00060593          	mv	a1,a2
    80005040:	0006861b          	sext.w	a2,a3
    80005044:	00002097          	auipc	ra,0x2
    80005048:	c60080e7          	jalr	-928(ra) # 80006ca4 <__memmove>
    8000504c:	00813083          	ld	ra,8(sp)
    80005050:	00013403          	ld	s0,0(sp)
    80005054:	00000513          	li	a0,0
    80005058:	01010113          	addi	sp,sp,16
    8000505c:	00008067          	ret
    80005060:	00002517          	auipc	a0,0x2
    80005064:	30050513          	addi	a0,a0,768 # 80007360 <CONSOLE_STATUS+0x350>
    80005068:	00001097          	auipc	ra,0x1
    8000506c:	934080e7          	jalr	-1740(ra) # 8000599c <panic>

0000000080005070 <either_copyin>:
    80005070:	ff010113          	addi	sp,sp,-16
    80005074:	00813023          	sd	s0,0(sp)
    80005078:	00113423          	sd	ra,8(sp)
    8000507c:	01010413          	addi	s0,sp,16
    80005080:	02059463          	bnez	a1,800050a8 <either_copyin+0x38>
    80005084:	00060593          	mv	a1,a2
    80005088:	0006861b          	sext.w	a2,a3
    8000508c:	00002097          	auipc	ra,0x2
    80005090:	c18080e7          	jalr	-1000(ra) # 80006ca4 <__memmove>
    80005094:	00813083          	ld	ra,8(sp)
    80005098:	00013403          	ld	s0,0(sp)
    8000509c:	00000513          	li	a0,0
    800050a0:	01010113          	addi	sp,sp,16
    800050a4:	00008067          	ret
    800050a8:	00002517          	auipc	a0,0x2
    800050ac:	2e050513          	addi	a0,a0,736 # 80007388 <CONSOLE_STATUS+0x378>
    800050b0:	00001097          	auipc	ra,0x1
    800050b4:	8ec080e7          	jalr	-1812(ra) # 8000599c <panic>

00000000800050b8 <trapinit>:
    800050b8:	ff010113          	addi	sp,sp,-16
    800050bc:	00813423          	sd	s0,8(sp)
    800050c0:	01010413          	addi	s0,sp,16
    800050c4:	00813403          	ld	s0,8(sp)
    800050c8:	00002597          	auipc	a1,0x2
    800050cc:	2e858593          	addi	a1,a1,744 # 800073b0 <CONSOLE_STATUS+0x3a0>
    800050d0:	00005517          	auipc	a0,0x5
    800050d4:	38050513          	addi	a0,a0,896 # 8000a450 <tickslock>
    800050d8:	01010113          	addi	sp,sp,16
    800050dc:	00001317          	auipc	t1,0x1
    800050e0:	5cc30067          	jr	1484(t1) # 800066a8 <initlock>

00000000800050e4 <trapinithart>:
    800050e4:	ff010113          	addi	sp,sp,-16
    800050e8:	00813423          	sd	s0,8(sp)
    800050ec:	01010413          	addi	s0,sp,16
    800050f0:	00000797          	auipc	a5,0x0
    800050f4:	30078793          	addi	a5,a5,768 # 800053f0 <kernelvec>
    800050f8:	10579073          	csrw	stvec,a5
    800050fc:	00813403          	ld	s0,8(sp)
    80005100:	01010113          	addi	sp,sp,16
    80005104:	00008067          	ret

0000000080005108 <usertrap>:
    80005108:	ff010113          	addi	sp,sp,-16
    8000510c:	00813423          	sd	s0,8(sp)
    80005110:	01010413          	addi	s0,sp,16
    80005114:	00813403          	ld	s0,8(sp)
    80005118:	01010113          	addi	sp,sp,16
    8000511c:	00008067          	ret

0000000080005120 <usertrapret>:
    80005120:	ff010113          	addi	sp,sp,-16
    80005124:	00813423          	sd	s0,8(sp)
    80005128:	01010413          	addi	s0,sp,16
    8000512c:	00813403          	ld	s0,8(sp)
    80005130:	01010113          	addi	sp,sp,16
    80005134:	00008067          	ret

0000000080005138 <kerneltrap>:
    80005138:	fe010113          	addi	sp,sp,-32
    8000513c:	00813823          	sd	s0,16(sp)
    80005140:	00113c23          	sd	ra,24(sp)
    80005144:	00913423          	sd	s1,8(sp)
    80005148:	02010413          	addi	s0,sp,32
    8000514c:	142025f3          	csrr	a1,scause
    80005150:	100027f3          	csrr	a5,sstatus
    80005154:	0027f793          	andi	a5,a5,2
    80005158:	10079c63          	bnez	a5,80005270 <kerneltrap+0x138>
    8000515c:	142027f3          	csrr	a5,scause
    80005160:	0207ce63          	bltz	a5,8000519c <kerneltrap+0x64>
    80005164:	00002517          	auipc	a0,0x2
    80005168:	29450513          	addi	a0,a0,660 # 800073f8 <CONSOLE_STATUS+0x3e8>
    8000516c:	00001097          	auipc	ra,0x1
    80005170:	88c080e7          	jalr	-1908(ra) # 800059f8 <__printf>
    80005174:	141025f3          	csrr	a1,sepc
    80005178:	14302673          	csrr	a2,stval
    8000517c:	00002517          	auipc	a0,0x2
    80005180:	28c50513          	addi	a0,a0,652 # 80007408 <CONSOLE_STATUS+0x3f8>
    80005184:	00001097          	auipc	ra,0x1
    80005188:	874080e7          	jalr	-1932(ra) # 800059f8 <__printf>
    8000518c:	00002517          	auipc	a0,0x2
    80005190:	29450513          	addi	a0,a0,660 # 80007420 <CONSOLE_STATUS+0x410>
    80005194:	00001097          	auipc	ra,0x1
    80005198:	808080e7          	jalr	-2040(ra) # 8000599c <panic>
    8000519c:	0ff7f713          	andi	a4,a5,255
    800051a0:	00900693          	li	a3,9
    800051a4:	04d70063          	beq	a4,a3,800051e4 <kerneltrap+0xac>
    800051a8:	fff00713          	li	a4,-1
    800051ac:	03f71713          	slli	a4,a4,0x3f
    800051b0:	00170713          	addi	a4,a4,1
    800051b4:	fae798e3          	bne	a5,a4,80005164 <kerneltrap+0x2c>
    800051b8:	00000097          	auipc	ra,0x0
    800051bc:	e00080e7          	jalr	-512(ra) # 80004fb8 <cpuid>
    800051c0:	06050663          	beqz	a0,8000522c <kerneltrap+0xf4>
    800051c4:	144027f3          	csrr	a5,sip
    800051c8:	ffd7f793          	andi	a5,a5,-3
    800051cc:	14479073          	csrw	sip,a5
    800051d0:	01813083          	ld	ra,24(sp)
    800051d4:	01013403          	ld	s0,16(sp)
    800051d8:	00813483          	ld	s1,8(sp)
    800051dc:	02010113          	addi	sp,sp,32
    800051e0:	00008067          	ret
    800051e4:	00000097          	auipc	ra,0x0
    800051e8:	3d0080e7          	jalr	976(ra) # 800055b4 <plic_claim>
    800051ec:	00a00793          	li	a5,10
    800051f0:	00050493          	mv	s1,a0
    800051f4:	06f50863          	beq	a0,a5,80005264 <kerneltrap+0x12c>
    800051f8:	fc050ce3          	beqz	a0,800051d0 <kerneltrap+0x98>
    800051fc:	00050593          	mv	a1,a0
    80005200:	00002517          	auipc	a0,0x2
    80005204:	1d850513          	addi	a0,a0,472 # 800073d8 <CONSOLE_STATUS+0x3c8>
    80005208:	00000097          	auipc	ra,0x0
    8000520c:	7f0080e7          	jalr	2032(ra) # 800059f8 <__printf>
    80005210:	01013403          	ld	s0,16(sp)
    80005214:	01813083          	ld	ra,24(sp)
    80005218:	00048513          	mv	a0,s1
    8000521c:	00813483          	ld	s1,8(sp)
    80005220:	02010113          	addi	sp,sp,32
    80005224:	00000317          	auipc	t1,0x0
    80005228:	3c830067          	jr	968(t1) # 800055ec <plic_complete>
    8000522c:	00005517          	auipc	a0,0x5
    80005230:	22450513          	addi	a0,a0,548 # 8000a450 <tickslock>
    80005234:	00001097          	auipc	ra,0x1
    80005238:	498080e7          	jalr	1176(ra) # 800066cc <acquire>
    8000523c:	00004717          	auipc	a4,0x4
    80005240:	fc870713          	addi	a4,a4,-56 # 80009204 <ticks>
    80005244:	00072783          	lw	a5,0(a4)
    80005248:	00005517          	auipc	a0,0x5
    8000524c:	20850513          	addi	a0,a0,520 # 8000a450 <tickslock>
    80005250:	0017879b          	addiw	a5,a5,1
    80005254:	00f72023          	sw	a5,0(a4)
    80005258:	00001097          	auipc	ra,0x1
    8000525c:	540080e7          	jalr	1344(ra) # 80006798 <release>
    80005260:	f65ff06f          	j	800051c4 <kerneltrap+0x8c>
    80005264:	00001097          	auipc	ra,0x1
    80005268:	09c080e7          	jalr	156(ra) # 80006300 <uartintr>
    8000526c:	fa5ff06f          	j	80005210 <kerneltrap+0xd8>
    80005270:	00002517          	auipc	a0,0x2
    80005274:	14850513          	addi	a0,a0,328 # 800073b8 <CONSOLE_STATUS+0x3a8>
    80005278:	00000097          	auipc	ra,0x0
    8000527c:	724080e7          	jalr	1828(ra) # 8000599c <panic>

0000000080005280 <clockintr>:
    80005280:	fe010113          	addi	sp,sp,-32
    80005284:	00813823          	sd	s0,16(sp)
    80005288:	00913423          	sd	s1,8(sp)
    8000528c:	00113c23          	sd	ra,24(sp)
    80005290:	02010413          	addi	s0,sp,32
    80005294:	00005497          	auipc	s1,0x5
    80005298:	1bc48493          	addi	s1,s1,444 # 8000a450 <tickslock>
    8000529c:	00048513          	mv	a0,s1
    800052a0:	00001097          	auipc	ra,0x1
    800052a4:	42c080e7          	jalr	1068(ra) # 800066cc <acquire>
    800052a8:	00004717          	auipc	a4,0x4
    800052ac:	f5c70713          	addi	a4,a4,-164 # 80009204 <ticks>
    800052b0:	00072783          	lw	a5,0(a4)
    800052b4:	01013403          	ld	s0,16(sp)
    800052b8:	01813083          	ld	ra,24(sp)
    800052bc:	00048513          	mv	a0,s1
    800052c0:	0017879b          	addiw	a5,a5,1
    800052c4:	00813483          	ld	s1,8(sp)
    800052c8:	00f72023          	sw	a5,0(a4)
    800052cc:	02010113          	addi	sp,sp,32
    800052d0:	00001317          	auipc	t1,0x1
    800052d4:	4c830067          	jr	1224(t1) # 80006798 <release>

00000000800052d8 <devintr>:
    800052d8:	142027f3          	csrr	a5,scause
    800052dc:	00000513          	li	a0,0
    800052e0:	0007c463          	bltz	a5,800052e8 <devintr+0x10>
    800052e4:	00008067          	ret
    800052e8:	fe010113          	addi	sp,sp,-32
    800052ec:	00813823          	sd	s0,16(sp)
    800052f0:	00113c23          	sd	ra,24(sp)
    800052f4:	00913423          	sd	s1,8(sp)
    800052f8:	02010413          	addi	s0,sp,32
    800052fc:	0ff7f713          	andi	a4,a5,255
    80005300:	00900693          	li	a3,9
    80005304:	04d70c63          	beq	a4,a3,8000535c <devintr+0x84>
    80005308:	fff00713          	li	a4,-1
    8000530c:	03f71713          	slli	a4,a4,0x3f
    80005310:	00170713          	addi	a4,a4,1
    80005314:	00e78c63          	beq	a5,a4,8000532c <devintr+0x54>
    80005318:	01813083          	ld	ra,24(sp)
    8000531c:	01013403          	ld	s0,16(sp)
    80005320:	00813483          	ld	s1,8(sp)
    80005324:	02010113          	addi	sp,sp,32
    80005328:	00008067          	ret
    8000532c:	00000097          	auipc	ra,0x0
    80005330:	c8c080e7          	jalr	-884(ra) # 80004fb8 <cpuid>
    80005334:	06050663          	beqz	a0,800053a0 <devintr+0xc8>
    80005338:	144027f3          	csrr	a5,sip
    8000533c:	ffd7f793          	andi	a5,a5,-3
    80005340:	14479073          	csrw	sip,a5
    80005344:	01813083          	ld	ra,24(sp)
    80005348:	01013403          	ld	s0,16(sp)
    8000534c:	00813483          	ld	s1,8(sp)
    80005350:	00200513          	li	a0,2
    80005354:	02010113          	addi	sp,sp,32
    80005358:	00008067          	ret
    8000535c:	00000097          	auipc	ra,0x0
    80005360:	258080e7          	jalr	600(ra) # 800055b4 <plic_claim>
    80005364:	00a00793          	li	a5,10
    80005368:	00050493          	mv	s1,a0
    8000536c:	06f50663          	beq	a0,a5,800053d8 <devintr+0x100>
    80005370:	00100513          	li	a0,1
    80005374:	fa0482e3          	beqz	s1,80005318 <devintr+0x40>
    80005378:	00048593          	mv	a1,s1
    8000537c:	00002517          	auipc	a0,0x2
    80005380:	05c50513          	addi	a0,a0,92 # 800073d8 <CONSOLE_STATUS+0x3c8>
    80005384:	00000097          	auipc	ra,0x0
    80005388:	674080e7          	jalr	1652(ra) # 800059f8 <__printf>
    8000538c:	00048513          	mv	a0,s1
    80005390:	00000097          	auipc	ra,0x0
    80005394:	25c080e7          	jalr	604(ra) # 800055ec <plic_complete>
    80005398:	00100513          	li	a0,1
    8000539c:	f7dff06f          	j	80005318 <devintr+0x40>
    800053a0:	00005517          	auipc	a0,0x5
    800053a4:	0b050513          	addi	a0,a0,176 # 8000a450 <tickslock>
    800053a8:	00001097          	auipc	ra,0x1
    800053ac:	324080e7          	jalr	804(ra) # 800066cc <acquire>
    800053b0:	00004717          	auipc	a4,0x4
    800053b4:	e5470713          	addi	a4,a4,-428 # 80009204 <ticks>
    800053b8:	00072783          	lw	a5,0(a4)
    800053bc:	00005517          	auipc	a0,0x5
    800053c0:	09450513          	addi	a0,a0,148 # 8000a450 <tickslock>
    800053c4:	0017879b          	addiw	a5,a5,1
    800053c8:	00f72023          	sw	a5,0(a4)
    800053cc:	00001097          	auipc	ra,0x1
    800053d0:	3cc080e7          	jalr	972(ra) # 80006798 <release>
    800053d4:	f65ff06f          	j	80005338 <devintr+0x60>
    800053d8:	00001097          	auipc	ra,0x1
    800053dc:	f28080e7          	jalr	-216(ra) # 80006300 <uartintr>
    800053e0:	fadff06f          	j	8000538c <devintr+0xb4>
	...

00000000800053f0 <kernelvec>:
    800053f0:	f0010113          	addi	sp,sp,-256
    800053f4:	00113023          	sd	ra,0(sp)
    800053f8:	00213423          	sd	sp,8(sp)
    800053fc:	00313823          	sd	gp,16(sp)
    80005400:	00413c23          	sd	tp,24(sp)
    80005404:	02513023          	sd	t0,32(sp)
    80005408:	02613423          	sd	t1,40(sp)
    8000540c:	02713823          	sd	t2,48(sp)
    80005410:	02813c23          	sd	s0,56(sp)
    80005414:	04913023          	sd	s1,64(sp)
    80005418:	04a13423          	sd	a0,72(sp)
    8000541c:	04b13823          	sd	a1,80(sp)
    80005420:	04c13c23          	sd	a2,88(sp)
    80005424:	06d13023          	sd	a3,96(sp)
    80005428:	06e13423          	sd	a4,104(sp)
    8000542c:	06f13823          	sd	a5,112(sp)
    80005430:	07013c23          	sd	a6,120(sp)
    80005434:	09113023          	sd	a7,128(sp)
    80005438:	09213423          	sd	s2,136(sp)
    8000543c:	09313823          	sd	s3,144(sp)
    80005440:	09413c23          	sd	s4,152(sp)
    80005444:	0b513023          	sd	s5,160(sp)
    80005448:	0b613423          	sd	s6,168(sp)
    8000544c:	0b713823          	sd	s7,176(sp)
    80005450:	0b813c23          	sd	s8,184(sp)
    80005454:	0d913023          	sd	s9,192(sp)
    80005458:	0da13423          	sd	s10,200(sp)
    8000545c:	0db13823          	sd	s11,208(sp)
    80005460:	0dc13c23          	sd	t3,216(sp)
    80005464:	0fd13023          	sd	t4,224(sp)
    80005468:	0fe13423          	sd	t5,232(sp)
    8000546c:	0ff13823          	sd	t6,240(sp)
    80005470:	cc9ff0ef          	jal	ra,80005138 <kerneltrap>
    80005474:	00013083          	ld	ra,0(sp)
    80005478:	00813103          	ld	sp,8(sp)
    8000547c:	01013183          	ld	gp,16(sp)
    80005480:	02013283          	ld	t0,32(sp)
    80005484:	02813303          	ld	t1,40(sp)
    80005488:	03013383          	ld	t2,48(sp)
    8000548c:	03813403          	ld	s0,56(sp)
    80005490:	04013483          	ld	s1,64(sp)
    80005494:	04813503          	ld	a0,72(sp)
    80005498:	05013583          	ld	a1,80(sp)
    8000549c:	05813603          	ld	a2,88(sp)
    800054a0:	06013683          	ld	a3,96(sp)
    800054a4:	06813703          	ld	a4,104(sp)
    800054a8:	07013783          	ld	a5,112(sp)
    800054ac:	07813803          	ld	a6,120(sp)
    800054b0:	08013883          	ld	a7,128(sp)
    800054b4:	08813903          	ld	s2,136(sp)
    800054b8:	09013983          	ld	s3,144(sp)
    800054bc:	09813a03          	ld	s4,152(sp)
    800054c0:	0a013a83          	ld	s5,160(sp)
    800054c4:	0a813b03          	ld	s6,168(sp)
    800054c8:	0b013b83          	ld	s7,176(sp)
    800054cc:	0b813c03          	ld	s8,184(sp)
    800054d0:	0c013c83          	ld	s9,192(sp)
    800054d4:	0c813d03          	ld	s10,200(sp)
    800054d8:	0d013d83          	ld	s11,208(sp)
    800054dc:	0d813e03          	ld	t3,216(sp)
    800054e0:	0e013e83          	ld	t4,224(sp)
    800054e4:	0e813f03          	ld	t5,232(sp)
    800054e8:	0f013f83          	ld	t6,240(sp)
    800054ec:	10010113          	addi	sp,sp,256
    800054f0:	10200073          	sret
    800054f4:	00000013          	nop
    800054f8:	00000013          	nop
    800054fc:	00000013          	nop

0000000080005500 <timervec>:
    80005500:	34051573          	csrrw	a0,mscratch,a0
    80005504:	00b53023          	sd	a1,0(a0)
    80005508:	00c53423          	sd	a2,8(a0)
    8000550c:	00d53823          	sd	a3,16(a0)
    80005510:	01853583          	ld	a1,24(a0)
    80005514:	02053603          	ld	a2,32(a0)
    80005518:	0005b683          	ld	a3,0(a1)
    8000551c:	00c686b3          	add	a3,a3,a2
    80005520:	00d5b023          	sd	a3,0(a1)
    80005524:	00200593          	li	a1,2
    80005528:	14459073          	csrw	sip,a1
    8000552c:	01053683          	ld	a3,16(a0)
    80005530:	00853603          	ld	a2,8(a0)
    80005534:	00053583          	ld	a1,0(a0)
    80005538:	34051573          	csrrw	a0,mscratch,a0
    8000553c:	30200073          	mret

0000000080005540 <plicinit>:
    80005540:	ff010113          	addi	sp,sp,-16
    80005544:	00813423          	sd	s0,8(sp)
    80005548:	01010413          	addi	s0,sp,16
    8000554c:	00813403          	ld	s0,8(sp)
    80005550:	0c0007b7          	lui	a5,0xc000
    80005554:	00100713          	li	a4,1
    80005558:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000555c:	00e7a223          	sw	a4,4(a5)
    80005560:	01010113          	addi	sp,sp,16
    80005564:	00008067          	ret

0000000080005568 <plicinithart>:
    80005568:	ff010113          	addi	sp,sp,-16
    8000556c:	00813023          	sd	s0,0(sp)
    80005570:	00113423          	sd	ra,8(sp)
    80005574:	01010413          	addi	s0,sp,16
    80005578:	00000097          	auipc	ra,0x0
    8000557c:	a40080e7          	jalr	-1472(ra) # 80004fb8 <cpuid>
    80005580:	0085171b          	slliw	a4,a0,0x8
    80005584:	0c0027b7          	lui	a5,0xc002
    80005588:	00e787b3          	add	a5,a5,a4
    8000558c:	40200713          	li	a4,1026
    80005590:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005594:	00813083          	ld	ra,8(sp)
    80005598:	00013403          	ld	s0,0(sp)
    8000559c:	00d5151b          	slliw	a0,a0,0xd
    800055a0:	0c2017b7          	lui	a5,0xc201
    800055a4:	00a78533          	add	a0,a5,a0
    800055a8:	00052023          	sw	zero,0(a0)
    800055ac:	01010113          	addi	sp,sp,16
    800055b0:	00008067          	ret

00000000800055b4 <plic_claim>:
    800055b4:	ff010113          	addi	sp,sp,-16
    800055b8:	00813023          	sd	s0,0(sp)
    800055bc:	00113423          	sd	ra,8(sp)
    800055c0:	01010413          	addi	s0,sp,16
    800055c4:	00000097          	auipc	ra,0x0
    800055c8:	9f4080e7          	jalr	-1548(ra) # 80004fb8 <cpuid>
    800055cc:	00813083          	ld	ra,8(sp)
    800055d0:	00013403          	ld	s0,0(sp)
    800055d4:	00d5151b          	slliw	a0,a0,0xd
    800055d8:	0c2017b7          	lui	a5,0xc201
    800055dc:	00a78533          	add	a0,a5,a0
    800055e0:	00452503          	lw	a0,4(a0)
    800055e4:	01010113          	addi	sp,sp,16
    800055e8:	00008067          	ret

00000000800055ec <plic_complete>:
    800055ec:	fe010113          	addi	sp,sp,-32
    800055f0:	00813823          	sd	s0,16(sp)
    800055f4:	00913423          	sd	s1,8(sp)
    800055f8:	00113c23          	sd	ra,24(sp)
    800055fc:	02010413          	addi	s0,sp,32
    80005600:	00050493          	mv	s1,a0
    80005604:	00000097          	auipc	ra,0x0
    80005608:	9b4080e7          	jalr	-1612(ra) # 80004fb8 <cpuid>
    8000560c:	01813083          	ld	ra,24(sp)
    80005610:	01013403          	ld	s0,16(sp)
    80005614:	00d5179b          	slliw	a5,a0,0xd
    80005618:	0c201737          	lui	a4,0xc201
    8000561c:	00f707b3          	add	a5,a4,a5
    80005620:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005624:	00813483          	ld	s1,8(sp)
    80005628:	02010113          	addi	sp,sp,32
    8000562c:	00008067          	ret

0000000080005630 <consolewrite>:
    80005630:	fb010113          	addi	sp,sp,-80
    80005634:	04813023          	sd	s0,64(sp)
    80005638:	04113423          	sd	ra,72(sp)
    8000563c:	02913c23          	sd	s1,56(sp)
    80005640:	03213823          	sd	s2,48(sp)
    80005644:	03313423          	sd	s3,40(sp)
    80005648:	03413023          	sd	s4,32(sp)
    8000564c:	01513c23          	sd	s5,24(sp)
    80005650:	05010413          	addi	s0,sp,80
    80005654:	06c05c63          	blez	a2,800056cc <consolewrite+0x9c>
    80005658:	00060993          	mv	s3,a2
    8000565c:	00050a13          	mv	s4,a0
    80005660:	00058493          	mv	s1,a1
    80005664:	00000913          	li	s2,0
    80005668:	fff00a93          	li	s5,-1
    8000566c:	01c0006f          	j	80005688 <consolewrite+0x58>
    80005670:	fbf44503          	lbu	a0,-65(s0)
    80005674:	0019091b          	addiw	s2,s2,1
    80005678:	00148493          	addi	s1,s1,1
    8000567c:	00001097          	auipc	ra,0x1
    80005680:	a9c080e7          	jalr	-1380(ra) # 80006118 <uartputc>
    80005684:	03298063          	beq	s3,s2,800056a4 <consolewrite+0x74>
    80005688:	00048613          	mv	a2,s1
    8000568c:	00100693          	li	a3,1
    80005690:	000a0593          	mv	a1,s4
    80005694:	fbf40513          	addi	a0,s0,-65
    80005698:	00000097          	auipc	ra,0x0
    8000569c:	9d8080e7          	jalr	-1576(ra) # 80005070 <either_copyin>
    800056a0:	fd5518e3          	bne	a0,s5,80005670 <consolewrite+0x40>
    800056a4:	04813083          	ld	ra,72(sp)
    800056a8:	04013403          	ld	s0,64(sp)
    800056ac:	03813483          	ld	s1,56(sp)
    800056b0:	02813983          	ld	s3,40(sp)
    800056b4:	02013a03          	ld	s4,32(sp)
    800056b8:	01813a83          	ld	s5,24(sp)
    800056bc:	00090513          	mv	a0,s2
    800056c0:	03013903          	ld	s2,48(sp)
    800056c4:	05010113          	addi	sp,sp,80
    800056c8:	00008067          	ret
    800056cc:	00000913          	li	s2,0
    800056d0:	fd5ff06f          	j	800056a4 <consolewrite+0x74>

00000000800056d4 <consoleread>:
    800056d4:	f9010113          	addi	sp,sp,-112
    800056d8:	06813023          	sd	s0,96(sp)
    800056dc:	04913c23          	sd	s1,88(sp)
    800056e0:	05213823          	sd	s2,80(sp)
    800056e4:	05313423          	sd	s3,72(sp)
    800056e8:	05413023          	sd	s4,64(sp)
    800056ec:	03513c23          	sd	s5,56(sp)
    800056f0:	03613823          	sd	s6,48(sp)
    800056f4:	03713423          	sd	s7,40(sp)
    800056f8:	03813023          	sd	s8,32(sp)
    800056fc:	06113423          	sd	ra,104(sp)
    80005700:	01913c23          	sd	s9,24(sp)
    80005704:	07010413          	addi	s0,sp,112
    80005708:	00060b93          	mv	s7,a2
    8000570c:	00050913          	mv	s2,a0
    80005710:	00058c13          	mv	s8,a1
    80005714:	00060b1b          	sext.w	s6,a2
    80005718:	00005497          	auipc	s1,0x5
    8000571c:	d6048493          	addi	s1,s1,-672 # 8000a478 <cons>
    80005720:	00400993          	li	s3,4
    80005724:	fff00a13          	li	s4,-1
    80005728:	00a00a93          	li	s5,10
    8000572c:	05705e63          	blez	s7,80005788 <consoleread+0xb4>
    80005730:	09c4a703          	lw	a4,156(s1)
    80005734:	0984a783          	lw	a5,152(s1)
    80005738:	0007071b          	sext.w	a4,a4
    8000573c:	08e78463          	beq	a5,a4,800057c4 <consoleread+0xf0>
    80005740:	07f7f713          	andi	a4,a5,127
    80005744:	00e48733          	add	a4,s1,a4
    80005748:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000574c:	0017869b          	addiw	a3,a5,1
    80005750:	08d4ac23          	sw	a3,152(s1)
    80005754:	00070c9b          	sext.w	s9,a4
    80005758:	0b370663          	beq	a4,s3,80005804 <consoleread+0x130>
    8000575c:	00100693          	li	a3,1
    80005760:	f9f40613          	addi	a2,s0,-97
    80005764:	000c0593          	mv	a1,s8
    80005768:	00090513          	mv	a0,s2
    8000576c:	f8e40fa3          	sb	a4,-97(s0)
    80005770:	00000097          	auipc	ra,0x0
    80005774:	8b4080e7          	jalr	-1868(ra) # 80005024 <either_copyout>
    80005778:	01450863          	beq	a0,s4,80005788 <consoleread+0xb4>
    8000577c:	001c0c13          	addi	s8,s8,1
    80005780:	fffb8b9b          	addiw	s7,s7,-1
    80005784:	fb5c94e3          	bne	s9,s5,8000572c <consoleread+0x58>
    80005788:	000b851b          	sext.w	a0,s7
    8000578c:	06813083          	ld	ra,104(sp)
    80005790:	06013403          	ld	s0,96(sp)
    80005794:	05813483          	ld	s1,88(sp)
    80005798:	05013903          	ld	s2,80(sp)
    8000579c:	04813983          	ld	s3,72(sp)
    800057a0:	04013a03          	ld	s4,64(sp)
    800057a4:	03813a83          	ld	s5,56(sp)
    800057a8:	02813b83          	ld	s7,40(sp)
    800057ac:	02013c03          	ld	s8,32(sp)
    800057b0:	01813c83          	ld	s9,24(sp)
    800057b4:	40ab053b          	subw	a0,s6,a0
    800057b8:	03013b03          	ld	s6,48(sp)
    800057bc:	07010113          	addi	sp,sp,112
    800057c0:	00008067          	ret
    800057c4:	00001097          	auipc	ra,0x1
    800057c8:	1d8080e7          	jalr	472(ra) # 8000699c <push_on>
    800057cc:	0984a703          	lw	a4,152(s1)
    800057d0:	09c4a783          	lw	a5,156(s1)
    800057d4:	0007879b          	sext.w	a5,a5
    800057d8:	fef70ce3          	beq	a4,a5,800057d0 <consoleread+0xfc>
    800057dc:	00001097          	auipc	ra,0x1
    800057e0:	234080e7          	jalr	564(ra) # 80006a10 <pop_on>
    800057e4:	0984a783          	lw	a5,152(s1)
    800057e8:	07f7f713          	andi	a4,a5,127
    800057ec:	00e48733          	add	a4,s1,a4
    800057f0:	01874703          	lbu	a4,24(a4)
    800057f4:	0017869b          	addiw	a3,a5,1
    800057f8:	08d4ac23          	sw	a3,152(s1)
    800057fc:	00070c9b          	sext.w	s9,a4
    80005800:	f5371ee3          	bne	a4,s3,8000575c <consoleread+0x88>
    80005804:	000b851b          	sext.w	a0,s7
    80005808:	f96bf2e3          	bgeu	s7,s6,8000578c <consoleread+0xb8>
    8000580c:	08f4ac23          	sw	a5,152(s1)
    80005810:	f7dff06f          	j	8000578c <consoleread+0xb8>

0000000080005814 <consputc>:
    80005814:	10000793          	li	a5,256
    80005818:	00f50663          	beq	a0,a5,80005824 <consputc+0x10>
    8000581c:	00001317          	auipc	t1,0x1
    80005820:	9f430067          	jr	-1548(t1) # 80006210 <uartputc_sync>
    80005824:	ff010113          	addi	sp,sp,-16
    80005828:	00113423          	sd	ra,8(sp)
    8000582c:	00813023          	sd	s0,0(sp)
    80005830:	01010413          	addi	s0,sp,16
    80005834:	00800513          	li	a0,8
    80005838:	00001097          	auipc	ra,0x1
    8000583c:	9d8080e7          	jalr	-1576(ra) # 80006210 <uartputc_sync>
    80005840:	02000513          	li	a0,32
    80005844:	00001097          	auipc	ra,0x1
    80005848:	9cc080e7          	jalr	-1588(ra) # 80006210 <uartputc_sync>
    8000584c:	00013403          	ld	s0,0(sp)
    80005850:	00813083          	ld	ra,8(sp)
    80005854:	00800513          	li	a0,8
    80005858:	01010113          	addi	sp,sp,16
    8000585c:	00001317          	auipc	t1,0x1
    80005860:	9b430067          	jr	-1612(t1) # 80006210 <uartputc_sync>

0000000080005864 <consoleintr>:
    80005864:	fe010113          	addi	sp,sp,-32
    80005868:	00813823          	sd	s0,16(sp)
    8000586c:	00913423          	sd	s1,8(sp)
    80005870:	01213023          	sd	s2,0(sp)
    80005874:	00113c23          	sd	ra,24(sp)
    80005878:	02010413          	addi	s0,sp,32
    8000587c:	00005917          	auipc	s2,0x5
    80005880:	bfc90913          	addi	s2,s2,-1028 # 8000a478 <cons>
    80005884:	00050493          	mv	s1,a0
    80005888:	00090513          	mv	a0,s2
    8000588c:	00001097          	auipc	ra,0x1
    80005890:	e40080e7          	jalr	-448(ra) # 800066cc <acquire>
    80005894:	02048c63          	beqz	s1,800058cc <consoleintr+0x68>
    80005898:	0a092783          	lw	a5,160(s2)
    8000589c:	09892703          	lw	a4,152(s2)
    800058a0:	07f00693          	li	a3,127
    800058a4:	40e7873b          	subw	a4,a5,a4
    800058a8:	02e6e263          	bltu	a3,a4,800058cc <consoleintr+0x68>
    800058ac:	00d00713          	li	a4,13
    800058b0:	04e48063          	beq	s1,a4,800058f0 <consoleintr+0x8c>
    800058b4:	07f7f713          	andi	a4,a5,127
    800058b8:	00e90733          	add	a4,s2,a4
    800058bc:	0017879b          	addiw	a5,a5,1
    800058c0:	0af92023          	sw	a5,160(s2)
    800058c4:	00970c23          	sb	s1,24(a4)
    800058c8:	08f92e23          	sw	a5,156(s2)
    800058cc:	01013403          	ld	s0,16(sp)
    800058d0:	01813083          	ld	ra,24(sp)
    800058d4:	00813483          	ld	s1,8(sp)
    800058d8:	00013903          	ld	s2,0(sp)
    800058dc:	00005517          	auipc	a0,0x5
    800058e0:	b9c50513          	addi	a0,a0,-1124 # 8000a478 <cons>
    800058e4:	02010113          	addi	sp,sp,32
    800058e8:	00001317          	auipc	t1,0x1
    800058ec:	eb030067          	jr	-336(t1) # 80006798 <release>
    800058f0:	00a00493          	li	s1,10
    800058f4:	fc1ff06f          	j	800058b4 <consoleintr+0x50>

00000000800058f8 <consoleinit>:
    800058f8:	fe010113          	addi	sp,sp,-32
    800058fc:	00113c23          	sd	ra,24(sp)
    80005900:	00813823          	sd	s0,16(sp)
    80005904:	00913423          	sd	s1,8(sp)
    80005908:	02010413          	addi	s0,sp,32
    8000590c:	00005497          	auipc	s1,0x5
    80005910:	b6c48493          	addi	s1,s1,-1172 # 8000a478 <cons>
    80005914:	00048513          	mv	a0,s1
    80005918:	00002597          	auipc	a1,0x2
    8000591c:	b1858593          	addi	a1,a1,-1256 # 80007430 <CONSOLE_STATUS+0x420>
    80005920:	00001097          	auipc	ra,0x1
    80005924:	d88080e7          	jalr	-632(ra) # 800066a8 <initlock>
    80005928:	00000097          	auipc	ra,0x0
    8000592c:	7ac080e7          	jalr	1964(ra) # 800060d4 <uartinit>
    80005930:	01813083          	ld	ra,24(sp)
    80005934:	01013403          	ld	s0,16(sp)
    80005938:	00000797          	auipc	a5,0x0
    8000593c:	d9c78793          	addi	a5,a5,-612 # 800056d4 <consoleread>
    80005940:	0af4bc23          	sd	a5,184(s1)
    80005944:	00000797          	auipc	a5,0x0
    80005948:	cec78793          	addi	a5,a5,-788 # 80005630 <consolewrite>
    8000594c:	0cf4b023          	sd	a5,192(s1)
    80005950:	00813483          	ld	s1,8(sp)
    80005954:	02010113          	addi	sp,sp,32
    80005958:	00008067          	ret

000000008000595c <console_read>:
    8000595c:	ff010113          	addi	sp,sp,-16
    80005960:	00813423          	sd	s0,8(sp)
    80005964:	01010413          	addi	s0,sp,16
    80005968:	00813403          	ld	s0,8(sp)
    8000596c:	00005317          	auipc	t1,0x5
    80005970:	bc433303          	ld	t1,-1084(t1) # 8000a530 <devsw+0x10>
    80005974:	01010113          	addi	sp,sp,16
    80005978:	00030067          	jr	t1

000000008000597c <console_write>:
    8000597c:	ff010113          	addi	sp,sp,-16
    80005980:	00813423          	sd	s0,8(sp)
    80005984:	01010413          	addi	s0,sp,16
    80005988:	00813403          	ld	s0,8(sp)
    8000598c:	00005317          	auipc	t1,0x5
    80005990:	bac33303          	ld	t1,-1108(t1) # 8000a538 <devsw+0x18>
    80005994:	01010113          	addi	sp,sp,16
    80005998:	00030067          	jr	t1

000000008000599c <panic>:
    8000599c:	fe010113          	addi	sp,sp,-32
    800059a0:	00113c23          	sd	ra,24(sp)
    800059a4:	00813823          	sd	s0,16(sp)
    800059a8:	00913423          	sd	s1,8(sp)
    800059ac:	02010413          	addi	s0,sp,32
    800059b0:	00050493          	mv	s1,a0
    800059b4:	00002517          	auipc	a0,0x2
    800059b8:	a8450513          	addi	a0,a0,-1404 # 80007438 <CONSOLE_STATUS+0x428>
    800059bc:	00005797          	auipc	a5,0x5
    800059c0:	c007ae23          	sw	zero,-996(a5) # 8000a5d8 <pr+0x18>
    800059c4:	00000097          	auipc	ra,0x0
    800059c8:	034080e7          	jalr	52(ra) # 800059f8 <__printf>
    800059cc:	00048513          	mv	a0,s1
    800059d0:	00000097          	auipc	ra,0x0
    800059d4:	028080e7          	jalr	40(ra) # 800059f8 <__printf>
    800059d8:	00002517          	auipc	a0,0x2
    800059dc:	85050513          	addi	a0,a0,-1968 # 80007228 <CONSOLE_STATUS+0x218>
    800059e0:	00000097          	auipc	ra,0x0
    800059e4:	018080e7          	jalr	24(ra) # 800059f8 <__printf>
    800059e8:	00100793          	li	a5,1
    800059ec:	00004717          	auipc	a4,0x4
    800059f0:	80f72e23          	sw	a5,-2020(a4) # 80009208 <panicked>
    800059f4:	0000006f          	j	800059f4 <panic+0x58>

00000000800059f8 <__printf>:
    800059f8:	f3010113          	addi	sp,sp,-208
    800059fc:	08813023          	sd	s0,128(sp)
    80005a00:	07313423          	sd	s3,104(sp)
    80005a04:	09010413          	addi	s0,sp,144
    80005a08:	05813023          	sd	s8,64(sp)
    80005a0c:	08113423          	sd	ra,136(sp)
    80005a10:	06913c23          	sd	s1,120(sp)
    80005a14:	07213823          	sd	s2,112(sp)
    80005a18:	07413023          	sd	s4,96(sp)
    80005a1c:	05513c23          	sd	s5,88(sp)
    80005a20:	05613823          	sd	s6,80(sp)
    80005a24:	05713423          	sd	s7,72(sp)
    80005a28:	03913c23          	sd	s9,56(sp)
    80005a2c:	03a13823          	sd	s10,48(sp)
    80005a30:	03b13423          	sd	s11,40(sp)
    80005a34:	00005317          	auipc	t1,0x5
    80005a38:	b8c30313          	addi	t1,t1,-1140 # 8000a5c0 <pr>
    80005a3c:	01832c03          	lw	s8,24(t1)
    80005a40:	00b43423          	sd	a1,8(s0)
    80005a44:	00c43823          	sd	a2,16(s0)
    80005a48:	00d43c23          	sd	a3,24(s0)
    80005a4c:	02e43023          	sd	a4,32(s0)
    80005a50:	02f43423          	sd	a5,40(s0)
    80005a54:	03043823          	sd	a6,48(s0)
    80005a58:	03143c23          	sd	a7,56(s0)
    80005a5c:	00050993          	mv	s3,a0
    80005a60:	4a0c1663          	bnez	s8,80005f0c <__printf+0x514>
    80005a64:	60098c63          	beqz	s3,8000607c <__printf+0x684>
    80005a68:	0009c503          	lbu	a0,0(s3)
    80005a6c:	00840793          	addi	a5,s0,8
    80005a70:	f6f43c23          	sd	a5,-136(s0)
    80005a74:	00000493          	li	s1,0
    80005a78:	22050063          	beqz	a0,80005c98 <__printf+0x2a0>
    80005a7c:	00002a37          	lui	s4,0x2
    80005a80:	00018ab7          	lui	s5,0x18
    80005a84:	000f4b37          	lui	s6,0xf4
    80005a88:	00989bb7          	lui	s7,0x989
    80005a8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005a90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005a94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005a98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005a9c:	00148c9b          	addiw	s9,s1,1
    80005aa0:	02500793          	li	a5,37
    80005aa4:	01998933          	add	s2,s3,s9
    80005aa8:	38f51263          	bne	a0,a5,80005e2c <__printf+0x434>
    80005aac:	00094783          	lbu	a5,0(s2)
    80005ab0:	00078c9b          	sext.w	s9,a5
    80005ab4:	1e078263          	beqz	a5,80005c98 <__printf+0x2a0>
    80005ab8:	0024849b          	addiw	s1,s1,2
    80005abc:	07000713          	li	a4,112
    80005ac0:	00998933          	add	s2,s3,s1
    80005ac4:	38e78a63          	beq	a5,a4,80005e58 <__printf+0x460>
    80005ac8:	20f76863          	bltu	a4,a5,80005cd8 <__printf+0x2e0>
    80005acc:	42a78863          	beq	a5,a0,80005efc <__printf+0x504>
    80005ad0:	06400713          	li	a4,100
    80005ad4:	40e79663          	bne	a5,a4,80005ee0 <__printf+0x4e8>
    80005ad8:	f7843783          	ld	a5,-136(s0)
    80005adc:	0007a603          	lw	a2,0(a5)
    80005ae0:	00878793          	addi	a5,a5,8
    80005ae4:	f6f43c23          	sd	a5,-136(s0)
    80005ae8:	42064a63          	bltz	a2,80005f1c <__printf+0x524>
    80005aec:	00a00713          	li	a4,10
    80005af0:	02e677bb          	remuw	a5,a2,a4
    80005af4:	00002d97          	auipc	s11,0x2
    80005af8:	96cd8d93          	addi	s11,s11,-1684 # 80007460 <digits>
    80005afc:	00900593          	li	a1,9
    80005b00:	0006051b          	sext.w	a0,a2
    80005b04:	00000c93          	li	s9,0
    80005b08:	02079793          	slli	a5,a5,0x20
    80005b0c:	0207d793          	srli	a5,a5,0x20
    80005b10:	00fd87b3          	add	a5,s11,a5
    80005b14:	0007c783          	lbu	a5,0(a5)
    80005b18:	02e656bb          	divuw	a3,a2,a4
    80005b1c:	f8f40023          	sb	a5,-128(s0)
    80005b20:	14c5d863          	bge	a1,a2,80005c70 <__printf+0x278>
    80005b24:	06300593          	li	a1,99
    80005b28:	00100c93          	li	s9,1
    80005b2c:	02e6f7bb          	remuw	a5,a3,a4
    80005b30:	02079793          	slli	a5,a5,0x20
    80005b34:	0207d793          	srli	a5,a5,0x20
    80005b38:	00fd87b3          	add	a5,s11,a5
    80005b3c:	0007c783          	lbu	a5,0(a5)
    80005b40:	02e6d73b          	divuw	a4,a3,a4
    80005b44:	f8f400a3          	sb	a5,-127(s0)
    80005b48:	12a5f463          	bgeu	a1,a0,80005c70 <__printf+0x278>
    80005b4c:	00a00693          	li	a3,10
    80005b50:	00900593          	li	a1,9
    80005b54:	02d777bb          	remuw	a5,a4,a3
    80005b58:	02079793          	slli	a5,a5,0x20
    80005b5c:	0207d793          	srli	a5,a5,0x20
    80005b60:	00fd87b3          	add	a5,s11,a5
    80005b64:	0007c503          	lbu	a0,0(a5)
    80005b68:	02d757bb          	divuw	a5,a4,a3
    80005b6c:	f8a40123          	sb	a0,-126(s0)
    80005b70:	48e5f263          	bgeu	a1,a4,80005ff4 <__printf+0x5fc>
    80005b74:	06300513          	li	a0,99
    80005b78:	02d7f5bb          	remuw	a1,a5,a3
    80005b7c:	02059593          	slli	a1,a1,0x20
    80005b80:	0205d593          	srli	a1,a1,0x20
    80005b84:	00bd85b3          	add	a1,s11,a1
    80005b88:	0005c583          	lbu	a1,0(a1)
    80005b8c:	02d7d7bb          	divuw	a5,a5,a3
    80005b90:	f8b401a3          	sb	a1,-125(s0)
    80005b94:	48e57263          	bgeu	a0,a4,80006018 <__printf+0x620>
    80005b98:	3e700513          	li	a0,999
    80005b9c:	02d7f5bb          	remuw	a1,a5,a3
    80005ba0:	02059593          	slli	a1,a1,0x20
    80005ba4:	0205d593          	srli	a1,a1,0x20
    80005ba8:	00bd85b3          	add	a1,s11,a1
    80005bac:	0005c583          	lbu	a1,0(a1)
    80005bb0:	02d7d7bb          	divuw	a5,a5,a3
    80005bb4:	f8b40223          	sb	a1,-124(s0)
    80005bb8:	46e57663          	bgeu	a0,a4,80006024 <__printf+0x62c>
    80005bbc:	02d7f5bb          	remuw	a1,a5,a3
    80005bc0:	02059593          	slli	a1,a1,0x20
    80005bc4:	0205d593          	srli	a1,a1,0x20
    80005bc8:	00bd85b3          	add	a1,s11,a1
    80005bcc:	0005c583          	lbu	a1,0(a1)
    80005bd0:	02d7d7bb          	divuw	a5,a5,a3
    80005bd4:	f8b402a3          	sb	a1,-123(s0)
    80005bd8:	46ea7863          	bgeu	s4,a4,80006048 <__printf+0x650>
    80005bdc:	02d7f5bb          	remuw	a1,a5,a3
    80005be0:	02059593          	slli	a1,a1,0x20
    80005be4:	0205d593          	srli	a1,a1,0x20
    80005be8:	00bd85b3          	add	a1,s11,a1
    80005bec:	0005c583          	lbu	a1,0(a1)
    80005bf0:	02d7d7bb          	divuw	a5,a5,a3
    80005bf4:	f8b40323          	sb	a1,-122(s0)
    80005bf8:	3eeaf863          	bgeu	s5,a4,80005fe8 <__printf+0x5f0>
    80005bfc:	02d7f5bb          	remuw	a1,a5,a3
    80005c00:	02059593          	slli	a1,a1,0x20
    80005c04:	0205d593          	srli	a1,a1,0x20
    80005c08:	00bd85b3          	add	a1,s11,a1
    80005c0c:	0005c583          	lbu	a1,0(a1)
    80005c10:	02d7d7bb          	divuw	a5,a5,a3
    80005c14:	f8b403a3          	sb	a1,-121(s0)
    80005c18:	42eb7e63          	bgeu	s6,a4,80006054 <__printf+0x65c>
    80005c1c:	02d7f5bb          	remuw	a1,a5,a3
    80005c20:	02059593          	slli	a1,a1,0x20
    80005c24:	0205d593          	srli	a1,a1,0x20
    80005c28:	00bd85b3          	add	a1,s11,a1
    80005c2c:	0005c583          	lbu	a1,0(a1)
    80005c30:	02d7d7bb          	divuw	a5,a5,a3
    80005c34:	f8b40423          	sb	a1,-120(s0)
    80005c38:	42ebfc63          	bgeu	s7,a4,80006070 <__printf+0x678>
    80005c3c:	02079793          	slli	a5,a5,0x20
    80005c40:	0207d793          	srli	a5,a5,0x20
    80005c44:	00fd8db3          	add	s11,s11,a5
    80005c48:	000dc703          	lbu	a4,0(s11)
    80005c4c:	00a00793          	li	a5,10
    80005c50:	00900c93          	li	s9,9
    80005c54:	f8e404a3          	sb	a4,-119(s0)
    80005c58:	00065c63          	bgez	a2,80005c70 <__printf+0x278>
    80005c5c:	f9040713          	addi	a4,s0,-112
    80005c60:	00f70733          	add	a4,a4,a5
    80005c64:	02d00693          	li	a3,45
    80005c68:	fed70823          	sb	a3,-16(a4)
    80005c6c:	00078c93          	mv	s9,a5
    80005c70:	f8040793          	addi	a5,s0,-128
    80005c74:	01978cb3          	add	s9,a5,s9
    80005c78:	f7f40d13          	addi	s10,s0,-129
    80005c7c:	000cc503          	lbu	a0,0(s9)
    80005c80:	fffc8c93          	addi	s9,s9,-1
    80005c84:	00000097          	auipc	ra,0x0
    80005c88:	b90080e7          	jalr	-1136(ra) # 80005814 <consputc>
    80005c8c:	ffac98e3          	bne	s9,s10,80005c7c <__printf+0x284>
    80005c90:	00094503          	lbu	a0,0(s2)
    80005c94:	e00514e3          	bnez	a0,80005a9c <__printf+0xa4>
    80005c98:	1a0c1663          	bnez	s8,80005e44 <__printf+0x44c>
    80005c9c:	08813083          	ld	ra,136(sp)
    80005ca0:	08013403          	ld	s0,128(sp)
    80005ca4:	07813483          	ld	s1,120(sp)
    80005ca8:	07013903          	ld	s2,112(sp)
    80005cac:	06813983          	ld	s3,104(sp)
    80005cb0:	06013a03          	ld	s4,96(sp)
    80005cb4:	05813a83          	ld	s5,88(sp)
    80005cb8:	05013b03          	ld	s6,80(sp)
    80005cbc:	04813b83          	ld	s7,72(sp)
    80005cc0:	04013c03          	ld	s8,64(sp)
    80005cc4:	03813c83          	ld	s9,56(sp)
    80005cc8:	03013d03          	ld	s10,48(sp)
    80005ccc:	02813d83          	ld	s11,40(sp)
    80005cd0:	0d010113          	addi	sp,sp,208
    80005cd4:	00008067          	ret
    80005cd8:	07300713          	li	a4,115
    80005cdc:	1ce78a63          	beq	a5,a4,80005eb0 <__printf+0x4b8>
    80005ce0:	07800713          	li	a4,120
    80005ce4:	1ee79e63          	bne	a5,a4,80005ee0 <__printf+0x4e8>
    80005ce8:	f7843783          	ld	a5,-136(s0)
    80005cec:	0007a703          	lw	a4,0(a5)
    80005cf0:	00878793          	addi	a5,a5,8
    80005cf4:	f6f43c23          	sd	a5,-136(s0)
    80005cf8:	28074263          	bltz	a4,80005f7c <__printf+0x584>
    80005cfc:	00001d97          	auipc	s11,0x1
    80005d00:	764d8d93          	addi	s11,s11,1892 # 80007460 <digits>
    80005d04:	00f77793          	andi	a5,a4,15
    80005d08:	00fd87b3          	add	a5,s11,a5
    80005d0c:	0007c683          	lbu	a3,0(a5)
    80005d10:	00f00613          	li	a2,15
    80005d14:	0007079b          	sext.w	a5,a4
    80005d18:	f8d40023          	sb	a3,-128(s0)
    80005d1c:	0047559b          	srliw	a1,a4,0x4
    80005d20:	0047569b          	srliw	a3,a4,0x4
    80005d24:	00000c93          	li	s9,0
    80005d28:	0ee65063          	bge	a2,a4,80005e08 <__printf+0x410>
    80005d2c:	00f6f693          	andi	a3,a3,15
    80005d30:	00dd86b3          	add	a3,s11,a3
    80005d34:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005d38:	0087d79b          	srliw	a5,a5,0x8
    80005d3c:	00100c93          	li	s9,1
    80005d40:	f8d400a3          	sb	a3,-127(s0)
    80005d44:	0cb67263          	bgeu	a2,a1,80005e08 <__printf+0x410>
    80005d48:	00f7f693          	andi	a3,a5,15
    80005d4c:	00dd86b3          	add	a3,s11,a3
    80005d50:	0006c583          	lbu	a1,0(a3)
    80005d54:	00f00613          	li	a2,15
    80005d58:	0047d69b          	srliw	a3,a5,0x4
    80005d5c:	f8b40123          	sb	a1,-126(s0)
    80005d60:	0047d593          	srli	a1,a5,0x4
    80005d64:	28f67e63          	bgeu	a2,a5,80006000 <__printf+0x608>
    80005d68:	00f6f693          	andi	a3,a3,15
    80005d6c:	00dd86b3          	add	a3,s11,a3
    80005d70:	0006c503          	lbu	a0,0(a3)
    80005d74:	0087d813          	srli	a6,a5,0x8
    80005d78:	0087d69b          	srliw	a3,a5,0x8
    80005d7c:	f8a401a3          	sb	a0,-125(s0)
    80005d80:	28b67663          	bgeu	a2,a1,8000600c <__printf+0x614>
    80005d84:	00f6f693          	andi	a3,a3,15
    80005d88:	00dd86b3          	add	a3,s11,a3
    80005d8c:	0006c583          	lbu	a1,0(a3)
    80005d90:	00c7d513          	srli	a0,a5,0xc
    80005d94:	00c7d69b          	srliw	a3,a5,0xc
    80005d98:	f8b40223          	sb	a1,-124(s0)
    80005d9c:	29067a63          	bgeu	a2,a6,80006030 <__printf+0x638>
    80005da0:	00f6f693          	andi	a3,a3,15
    80005da4:	00dd86b3          	add	a3,s11,a3
    80005da8:	0006c583          	lbu	a1,0(a3)
    80005dac:	0107d813          	srli	a6,a5,0x10
    80005db0:	0107d69b          	srliw	a3,a5,0x10
    80005db4:	f8b402a3          	sb	a1,-123(s0)
    80005db8:	28a67263          	bgeu	a2,a0,8000603c <__printf+0x644>
    80005dbc:	00f6f693          	andi	a3,a3,15
    80005dc0:	00dd86b3          	add	a3,s11,a3
    80005dc4:	0006c683          	lbu	a3,0(a3)
    80005dc8:	0147d79b          	srliw	a5,a5,0x14
    80005dcc:	f8d40323          	sb	a3,-122(s0)
    80005dd0:	21067663          	bgeu	a2,a6,80005fdc <__printf+0x5e4>
    80005dd4:	02079793          	slli	a5,a5,0x20
    80005dd8:	0207d793          	srli	a5,a5,0x20
    80005ddc:	00fd8db3          	add	s11,s11,a5
    80005de0:	000dc683          	lbu	a3,0(s11)
    80005de4:	00800793          	li	a5,8
    80005de8:	00700c93          	li	s9,7
    80005dec:	f8d403a3          	sb	a3,-121(s0)
    80005df0:	00075c63          	bgez	a4,80005e08 <__printf+0x410>
    80005df4:	f9040713          	addi	a4,s0,-112
    80005df8:	00f70733          	add	a4,a4,a5
    80005dfc:	02d00693          	li	a3,45
    80005e00:	fed70823          	sb	a3,-16(a4)
    80005e04:	00078c93          	mv	s9,a5
    80005e08:	f8040793          	addi	a5,s0,-128
    80005e0c:	01978cb3          	add	s9,a5,s9
    80005e10:	f7f40d13          	addi	s10,s0,-129
    80005e14:	000cc503          	lbu	a0,0(s9)
    80005e18:	fffc8c93          	addi	s9,s9,-1
    80005e1c:	00000097          	auipc	ra,0x0
    80005e20:	9f8080e7          	jalr	-1544(ra) # 80005814 <consputc>
    80005e24:	ff9d18e3          	bne	s10,s9,80005e14 <__printf+0x41c>
    80005e28:	0100006f          	j	80005e38 <__printf+0x440>
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	9e8080e7          	jalr	-1560(ra) # 80005814 <consputc>
    80005e34:	000c8493          	mv	s1,s9
    80005e38:	00094503          	lbu	a0,0(s2)
    80005e3c:	c60510e3          	bnez	a0,80005a9c <__printf+0xa4>
    80005e40:	e40c0ee3          	beqz	s8,80005c9c <__printf+0x2a4>
    80005e44:	00004517          	auipc	a0,0x4
    80005e48:	77c50513          	addi	a0,a0,1916 # 8000a5c0 <pr>
    80005e4c:	00001097          	auipc	ra,0x1
    80005e50:	94c080e7          	jalr	-1716(ra) # 80006798 <release>
    80005e54:	e49ff06f          	j	80005c9c <__printf+0x2a4>
    80005e58:	f7843783          	ld	a5,-136(s0)
    80005e5c:	03000513          	li	a0,48
    80005e60:	01000d13          	li	s10,16
    80005e64:	00878713          	addi	a4,a5,8
    80005e68:	0007bc83          	ld	s9,0(a5)
    80005e6c:	f6e43c23          	sd	a4,-136(s0)
    80005e70:	00000097          	auipc	ra,0x0
    80005e74:	9a4080e7          	jalr	-1628(ra) # 80005814 <consputc>
    80005e78:	07800513          	li	a0,120
    80005e7c:	00000097          	auipc	ra,0x0
    80005e80:	998080e7          	jalr	-1640(ra) # 80005814 <consputc>
    80005e84:	00001d97          	auipc	s11,0x1
    80005e88:	5dcd8d93          	addi	s11,s11,1500 # 80007460 <digits>
    80005e8c:	03ccd793          	srli	a5,s9,0x3c
    80005e90:	00fd87b3          	add	a5,s11,a5
    80005e94:	0007c503          	lbu	a0,0(a5)
    80005e98:	fffd0d1b          	addiw	s10,s10,-1
    80005e9c:	004c9c93          	slli	s9,s9,0x4
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	974080e7          	jalr	-1676(ra) # 80005814 <consputc>
    80005ea8:	fe0d12e3          	bnez	s10,80005e8c <__printf+0x494>
    80005eac:	f8dff06f          	j	80005e38 <__printf+0x440>
    80005eb0:	f7843783          	ld	a5,-136(s0)
    80005eb4:	0007bc83          	ld	s9,0(a5)
    80005eb8:	00878793          	addi	a5,a5,8
    80005ebc:	f6f43c23          	sd	a5,-136(s0)
    80005ec0:	000c9a63          	bnez	s9,80005ed4 <__printf+0x4dc>
    80005ec4:	1080006f          	j	80005fcc <__printf+0x5d4>
    80005ec8:	001c8c93          	addi	s9,s9,1
    80005ecc:	00000097          	auipc	ra,0x0
    80005ed0:	948080e7          	jalr	-1720(ra) # 80005814 <consputc>
    80005ed4:	000cc503          	lbu	a0,0(s9)
    80005ed8:	fe0518e3          	bnez	a0,80005ec8 <__printf+0x4d0>
    80005edc:	f5dff06f          	j	80005e38 <__printf+0x440>
    80005ee0:	02500513          	li	a0,37
    80005ee4:	00000097          	auipc	ra,0x0
    80005ee8:	930080e7          	jalr	-1744(ra) # 80005814 <consputc>
    80005eec:	000c8513          	mv	a0,s9
    80005ef0:	00000097          	auipc	ra,0x0
    80005ef4:	924080e7          	jalr	-1756(ra) # 80005814 <consputc>
    80005ef8:	f41ff06f          	j	80005e38 <__printf+0x440>
    80005efc:	02500513          	li	a0,37
    80005f00:	00000097          	auipc	ra,0x0
    80005f04:	914080e7          	jalr	-1772(ra) # 80005814 <consputc>
    80005f08:	f31ff06f          	j	80005e38 <__printf+0x440>
    80005f0c:	00030513          	mv	a0,t1
    80005f10:	00000097          	auipc	ra,0x0
    80005f14:	7bc080e7          	jalr	1980(ra) # 800066cc <acquire>
    80005f18:	b4dff06f          	j	80005a64 <__printf+0x6c>
    80005f1c:	40c0053b          	negw	a0,a2
    80005f20:	00a00713          	li	a4,10
    80005f24:	02e576bb          	remuw	a3,a0,a4
    80005f28:	00001d97          	auipc	s11,0x1
    80005f2c:	538d8d93          	addi	s11,s11,1336 # 80007460 <digits>
    80005f30:	ff700593          	li	a1,-9
    80005f34:	02069693          	slli	a3,a3,0x20
    80005f38:	0206d693          	srli	a3,a3,0x20
    80005f3c:	00dd86b3          	add	a3,s11,a3
    80005f40:	0006c683          	lbu	a3,0(a3)
    80005f44:	02e557bb          	divuw	a5,a0,a4
    80005f48:	f8d40023          	sb	a3,-128(s0)
    80005f4c:	10b65e63          	bge	a2,a1,80006068 <__printf+0x670>
    80005f50:	06300593          	li	a1,99
    80005f54:	02e7f6bb          	remuw	a3,a5,a4
    80005f58:	02069693          	slli	a3,a3,0x20
    80005f5c:	0206d693          	srli	a3,a3,0x20
    80005f60:	00dd86b3          	add	a3,s11,a3
    80005f64:	0006c683          	lbu	a3,0(a3)
    80005f68:	02e7d73b          	divuw	a4,a5,a4
    80005f6c:	00200793          	li	a5,2
    80005f70:	f8d400a3          	sb	a3,-127(s0)
    80005f74:	bca5ece3          	bltu	a1,a0,80005b4c <__printf+0x154>
    80005f78:	ce5ff06f          	j	80005c5c <__printf+0x264>
    80005f7c:	40e007bb          	negw	a5,a4
    80005f80:	00001d97          	auipc	s11,0x1
    80005f84:	4e0d8d93          	addi	s11,s11,1248 # 80007460 <digits>
    80005f88:	00f7f693          	andi	a3,a5,15
    80005f8c:	00dd86b3          	add	a3,s11,a3
    80005f90:	0006c583          	lbu	a1,0(a3)
    80005f94:	ff100613          	li	a2,-15
    80005f98:	0047d69b          	srliw	a3,a5,0x4
    80005f9c:	f8b40023          	sb	a1,-128(s0)
    80005fa0:	0047d59b          	srliw	a1,a5,0x4
    80005fa4:	0ac75e63          	bge	a4,a2,80006060 <__printf+0x668>
    80005fa8:	00f6f693          	andi	a3,a3,15
    80005fac:	00dd86b3          	add	a3,s11,a3
    80005fb0:	0006c603          	lbu	a2,0(a3)
    80005fb4:	00f00693          	li	a3,15
    80005fb8:	0087d79b          	srliw	a5,a5,0x8
    80005fbc:	f8c400a3          	sb	a2,-127(s0)
    80005fc0:	d8b6e4e3          	bltu	a3,a1,80005d48 <__printf+0x350>
    80005fc4:	00200793          	li	a5,2
    80005fc8:	e2dff06f          	j	80005df4 <__printf+0x3fc>
    80005fcc:	00001c97          	auipc	s9,0x1
    80005fd0:	474c8c93          	addi	s9,s9,1140 # 80007440 <CONSOLE_STATUS+0x430>
    80005fd4:	02800513          	li	a0,40
    80005fd8:	ef1ff06f          	j	80005ec8 <__printf+0x4d0>
    80005fdc:	00700793          	li	a5,7
    80005fe0:	00600c93          	li	s9,6
    80005fe4:	e0dff06f          	j	80005df0 <__printf+0x3f8>
    80005fe8:	00700793          	li	a5,7
    80005fec:	00600c93          	li	s9,6
    80005ff0:	c69ff06f          	j	80005c58 <__printf+0x260>
    80005ff4:	00300793          	li	a5,3
    80005ff8:	00200c93          	li	s9,2
    80005ffc:	c5dff06f          	j	80005c58 <__printf+0x260>
    80006000:	00300793          	li	a5,3
    80006004:	00200c93          	li	s9,2
    80006008:	de9ff06f          	j	80005df0 <__printf+0x3f8>
    8000600c:	00400793          	li	a5,4
    80006010:	00300c93          	li	s9,3
    80006014:	dddff06f          	j	80005df0 <__printf+0x3f8>
    80006018:	00400793          	li	a5,4
    8000601c:	00300c93          	li	s9,3
    80006020:	c39ff06f          	j	80005c58 <__printf+0x260>
    80006024:	00500793          	li	a5,5
    80006028:	00400c93          	li	s9,4
    8000602c:	c2dff06f          	j	80005c58 <__printf+0x260>
    80006030:	00500793          	li	a5,5
    80006034:	00400c93          	li	s9,4
    80006038:	db9ff06f          	j	80005df0 <__printf+0x3f8>
    8000603c:	00600793          	li	a5,6
    80006040:	00500c93          	li	s9,5
    80006044:	dadff06f          	j	80005df0 <__printf+0x3f8>
    80006048:	00600793          	li	a5,6
    8000604c:	00500c93          	li	s9,5
    80006050:	c09ff06f          	j	80005c58 <__printf+0x260>
    80006054:	00800793          	li	a5,8
    80006058:	00700c93          	li	s9,7
    8000605c:	bfdff06f          	j	80005c58 <__printf+0x260>
    80006060:	00100793          	li	a5,1
    80006064:	d91ff06f          	j	80005df4 <__printf+0x3fc>
    80006068:	00100793          	li	a5,1
    8000606c:	bf1ff06f          	j	80005c5c <__printf+0x264>
    80006070:	00900793          	li	a5,9
    80006074:	00800c93          	li	s9,8
    80006078:	be1ff06f          	j	80005c58 <__printf+0x260>
    8000607c:	00001517          	auipc	a0,0x1
    80006080:	3cc50513          	addi	a0,a0,972 # 80007448 <CONSOLE_STATUS+0x438>
    80006084:	00000097          	auipc	ra,0x0
    80006088:	918080e7          	jalr	-1768(ra) # 8000599c <panic>

000000008000608c <printfinit>:
    8000608c:	fe010113          	addi	sp,sp,-32
    80006090:	00813823          	sd	s0,16(sp)
    80006094:	00913423          	sd	s1,8(sp)
    80006098:	00113c23          	sd	ra,24(sp)
    8000609c:	02010413          	addi	s0,sp,32
    800060a0:	00004497          	auipc	s1,0x4
    800060a4:	52048493          	addi	s1,s1,1312 # 8000a5c0 <pr>
    800060a8:	00048513          	mv	a0,s1
    800060ac:	00001597          	auipc	a1,0x1
    800060b0:	3ac58593          	addi	a1,a1,940 # 80007458 <CONSOLE_STATUS+0x448>
    800060b4:	00000097          	auipc	ra,0x0
    800060b8:	5f4080e7          	jalr	1524(ra) # 800066a8 <initlock>
    800060bc:	01813083          	ld	ra,24(sp)
    800060c0:	01013403          	ld	s0,16(sp)
    800060c4:	0004ac23          	sw	zero,24(s1)
    800060c8:	00813483          	ld	s1,8(sp)
    800060cc:	02010113          	addi	sp,sp,32
    800060d0:	00008067          	ret

00000000800060d4 <uartinit>:
    800060d4:	ff010113          	addi	sp,sp,-16
    800060d8:	00813423          	sd	s0,8(sp)
    800060dc:	01010413          	addi	s0,sp,16
    800060e0:	100007b7          	lui	a5,0x10000
    800060e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800060e8:	f8000713          	li	a4,-128
    800060ec:	00e781a3          	sb	a4,3(a5)
    800060f0:	00300713          	li	a4,3
    800060f4:	00e78023          	sb	a4,0(a5)
    800060f8:	000780a3          	sb	zero,1(a5)
    800060fc:	00e781a3          	sb	a4,3(a5)
    80006100:	00700693          	li	a3,7
    80006104:	00d78123          	sb	a3,2(a5)
    80006108:	00e780a3          	sb	a4,1(a5)
    8000610c:	00813403          	ld	s0,8(sp)
    80006110:	01010113          	addi	sp,sp,16
    80006114:	00008067          	ret

0000000080006118 <uartputc>:
    80006118:	00003797          	auipc	a5,0x3
    8000611c:	0f07a783          	lw	a5,240(a5) # 80009208 <panicked>
    80006120:	00078463          	beqz	a5,80006128 <uartputc+0x10>
    80006124:	0000006f          	j	80006124 <uartputc+0xc>
    80006128:	fd010113          	addi	sp,sp,-48
    8000612c:	02813023          	sd	s0,32(sp)
    80006130:	00913c23          	sd	s1,24(sp)
    80006134:	01213823          	sd	s2,16(sp)
    80006138:	01313423          	sd	s3,8(sp)
    8000613c:	02113423          	sd	ra,40(sp)
    80006140:	03010413          	addi	s0,sp,48
    80006144:	00003917          	auipc	s2,0x3
    80006148:	0cc90913          	addi	s2,s2,204 # 80009210 <uart_tx_r>
    8000614c:	00093783          	ld	a5,0(s2)
    80006150:	00003497          	auipc	s1,0x3
    80006154:	0c848493          	addi	s1,s1,200 # 80009218 <uart_tx_w>
    80006158:	0004b703          	ld	a4,0(s1)
    8000615c:	02078693          	addi	a3,a5,32
    80006160:	00050993          	mv	s3,a0
    80006164:	02e69c63          	bne	a3,a4,8000619c <uartputc+0x84>
    80006168:	00001097          	auipc	ra,0x1
    8000616c:	834080e7          	jalr	-1996(ra) # 8000699c <push_on>
    80006170:	00093783          	ld	a5,0(s2)
    80006174:	0004b703          	ld	a4,0(s1)
    80006178:	02078793          	addi	a5,a5,32
    8000617c:	00e79463          	bne	a5,a4,80006184 <uartputc+0x6c>
    80006180:	0000006f          	j	80006180 <uartputc+0x68>
    80006184:	00001097          	auipc	ra,0x1
    80006188:	88c080e7          	jalr	-1908(ra) # 80006a10 <pop_on>
    8000618c:	00093783          	ld	a5,0(s2)
    80006190:	0004b703          	ld	a4,0(s1)
    80006194:	02078693          	addi	a3,a5,32
    80006198:	fce688e3          	beq	a3,a4,80006168 <uartputc+0x50>
    8000619c:	01f77693          	andi	a3,a4,31
    800061a0:	00004597          	auipc	a1,0x4
    800061a4:	44058593          	addi	a1,a1,1088 # 8000a5e0 <uart_tx_buf>
    800061a8:	00d586b3          	add	a3,a1,a3
    800061ac:	00170713          	addi	a4,a4,1
    800061b0:	01368023          	sb	s3,0(a3)
    800061b4:	00e4b023          	sd	a4,0(s1)
    800061b8:	10000637          	lui	a2,0x10000
    800061bc:	02f71063          	bne	a4,a5,800061dc <uartputc+0xc4>
    800061c0:	0340006f          	j	800061f4 <uartputc+0xdc>
    800061c4:	00074703          	lbu	a4,0(a4)
    800061c8:	00f93023          	sd	a5,0(s2)
    800061cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800061d0:	00093783          	ld	a5,0(s2)
    800061d4:	0004b703          	ld	a4,0(s1)
    800061d8:	00f70e63          	beq	a4,a5,800061f4 <uartputc+0xdc>
    800061dc:	00564683          	lbu	a3,5(a2)
    800061e0:	01f7f713          	andi	a4,a5,31
    800061e4:	00e58733          	add	a4,a1,a4
    800061e8:	0206f693          	andi	a3,a3,32
    800061ec:	00178793          	addi	a5,a5,1
    800061f0:	fc069ae3          	bnez	a3,800061c4 <uartputc+0xac>
    800061f4:	02813083          	ld	ra,40(sp)
    800061f8:	02013403          	ld	s0,32(sp)
    800061fc:	01813483          	ld	s1,24(sp)
    80006200:	01013903          	ld	s2,16(sp)
    80006204:	00813983          	ld	s3,8(sp)
    80006208:	03010113          	addi	sp,sp,48
    8000620c:	00008067          	ret

0000000080006210 <uartputc_sync>:
    80006210:	ff010113          	addi	sp,sp,-16
    80006214:	00813423          	sd	s0,8(sp)
    80006218:	01010413          	addi	s0,sp,16
    8000621c:	00003717          	auipc	a4,0x3
    80006220:	fec72703          	lw	a4,-20(a4) # 80009208 <panicked>
    80006224:	02071663          	bnez	a4,80006250 <uartputc_sync+0x40>
    80006228:	00050793          	mv	a5,a0
    8000622c:	100006b7          	lui	a3,0x10000
    80006230:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006234:	02077713          	andi	a4,a4,32
    80006238:	fe070ce3          	beqz	a4,80006230 <uartputc_sync+0x20>
    8000623c:	0ff7f793          	andi	a5,a5,255
    80006240:	00f68023          	sb	a5,0(a3)
    80006244:	00813403          	ld	s0,8(sp)
    80006248:	01010113          	addi	sp,sp,16
    8000624c:	00008067          	ret
    80006250:	0000006f          	j	80006250 <uartputc_sync+0x40>

0000000080006254 <uartstart>:
    80006254:	ff010113          	addi	sp,sp,-16
    80006258:	00813423          	sd	s0,8(sp)
    8000625c:	01010413          	addi	s0,sp,16
    80006260:	00003617          	auipc	a2,0x3
    80006264:	fb060613          	addi	a2,a2,-80 # 80009210 <uart_tx_r>
    80006268:	00003517          	auipc	a0,0x3
    8000626c:	fb050513          	addi	a0,a0,-80 # 80009218 <uart_tx_w>
    80006270:	00063783          	ld	a5,0(a2)
    80006274:	00053703          	ld	a4,0(a0)
    80006278:	04f70263          	beq	a4,a5,800062bc <uartstart+0x68>
    8000627c:	100005b7          	lui	a1,0x10000
    80006280:	00004817          	auipc	a6,0x4
    80006284:	36080813          	addi	a6,a6,864 # 8000a5e0 <uart_tx_buf>
    80006288:	01c0006f          	j	800062a4 <uartstart+0x50>
    8000628c:	0006c703          	lbu	a4,0(a3)
    80006290:	00f63023          	sd	a5,0(a2)
    80006294:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006298:	00063783          	ld	a5,0(a2)
    8000629c:	00053703          	ld	a4,0(a0)
    800062a0:	00f70e63          	beq	a4,a5,800062bc <uartstart+0x68>
    800062a4:	01f7f713          	andi	a4,a5,31
    800062a8:	00e806b3          	add	a3,a6,a4
    800062ac:	0055c703          	lbu	a4,5(a1)
    800062b0:	00178793          	addi	a5,a5,1
    800062b4:	02077713          	andi	a4,a4,32
    800062b8:	fc071ae3          	bnez	a4,8000628c <uartstart+0x38>
    800062bc:	00813403          	ld	s0,8(sp)
    800062c0:	01010113          	addi	sp,sp,16
    800062c4:	00008067          	ret

00000000800062c8 <uartgetc>:
    800062c8:	ff010113          	addi	sp,sp,-16
    800062cc:	00813423          	sd	s0,8(sp)
    800062d0:	01010413          	addi	s0,sp,16
    800062d4:	10000737          	lui	a4,0x10000
    800062d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800062dc:	0017f793          	andi	a5,a5,1
    800062e0:	00078c63          	beqz	a5,800062f8 <uartgetc+0x30>
    800062e4:	00074503          	lbu	a0,0(a4)
    800062e8:	0ff57513          	andi	a0,a0,255
    800062ec:	00813403          	ld	s0,8(sp)
    800062f0:	01010113          	addi	sp,sp,16
    800062f4:	00008067          	ret
    800062f8:	fff00513          	li	a0,-1
    800062fc:	ff1ff06f          	j	800062ec <uartgetc+0x24>

0000000080006300 <uartintr>:
    80006300:	100007b7          	lui	a5,0x10000
    80006304:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006308:	0017f793          	andi	a5,a5,1
    8000630c:	0a078463          	beqz	a5,800063b4 <uartintr+0xb4>
    80006310:	fe010113          	addi	sp,sp,-32
    80006314:	00813823          	sd	s0,16(sp)
    80006318:	00913423          	sd	s1,8(sp)
    8000631c:	00113c23          	sd	ra,24(sp)
    80006320:	02010413          	addi	s0,sp,32
    80006324:	100004b7          	lui	s1,0x10000
    80006328:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000632c:	0ff57513          	andi	a0,a0,255
    80006330:	fffff097          	auipc	ra,0xfffff
    80006334:	534080e7          	jalr	1332(ra) # 80005864 <consoleintr>
    80006338:	0054c783          	lbu	a5,5(s1)
    8000633c:	0017f793          	andi	a5,a5,1
    80006340:	fe0794e3          	bnez	a5,80006328 <uartintr+0x28>
    80006344:	00003617          	auipc	a2,0x3
    80006348:	ecc60613          	addi	a2,a2,-308 # 80009210 <uart_tx_r>
    8000634c:	00003517          	auipc	a0,0x3
    80006350:	ecc50513          	addi	a0,a0,-308 # 80009218 <uart_tx_w>
    80006354:	00063783          	ld	a5,0(a2)
    80006358:	00053703          	ld	a4,0(a0)
    8000635c:	04f70263          	beq	a4,a5,800063a0 <uartintr+0xa0>
    80006360:	100005b7          	lui	a1,0x10000
    80006364:	00004817          	auipc	a6,0x4
    80006368:	27c80813          	addi	a6,a6,636 # 8000a5e0 <uart_tx_buf>
    8000636c:	01c0006f          	j	80006388 <uartintr+0x88>
    80006370:	0006c703          	lbu	a4,0(a3)
    80006374:	00f63023          	sd	a5,0(a2)
    80006378:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000637c:	00063783          	ld	a5,0(a2)
    80006380:	00053703          	ld	a4,0(a0)
    80006384:	00f70e63          	beq	a4,a5,800063a0 <uartintr+0xa0>
    80006388:	01f7f713          	andi	a4,a5,31
    8000638c:	00e806b3          	add	a3,a6,a4
    80006390:	0055c703          	lbu	a4,5(a1)
    80006394:	00178793          	addi	a5,a5,1
    80006398:	02077713          	andi	a4,a4,32
    8000639c:	fc071ae3          	bnez	a4,80006370 <uartintr+0x70>
    800063a0:	01813083          	ld	ra,24(sp)
    800063a4:	01013403          	ld	s0,16(sp)
    800063a8:	00813483          	ld	s1,8(sp)
    800063ac:	02010113          	addi	sp,sp,32
    800063b0:	00008067          	ret
    800063b4:	00003617          	auipc	a2,0x3
    800063b8:	e5c60613          	addi	a2,a2,-420 # 80009210 <uart_tx_r>
    800063bc:	00003517          	auipc	a0,0x3
    800063c0:	e5c50513          	addi	a0,a0,-420 # 80009218 <uart_tx_w>
    800063c4:	00063783          	ld	a5,0(a2)
    800063c8:	00053703          	ld	a4,0(a0)
    800063cc:	04f70263          	beq	a4,a5,80006410 <uartintr+0x110>
    800063d0:	100005b7          	lui	a1,0x10000
    800063d4:	00004817          	auipc	a6,0x4
    800063d8:	20c80813          	addi	a6,a6,524 # 8000a5e0 <uart_tx_buf>
    800063dc:	01c0006f          	j	800063f8 <uartintr+0xf8>
    800063e0:	0006c703          	lbu	a4,0(a3)
    800063e4:	00f63023          	sd	a5,0(a2)
    800063e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800063ec:	00063783          	ld	a5,0(a2)
    800063f0:	00053703          	ld	a4,0(a0)
    800063f4:	02f70063          	beq	a4,a5,80006414 <uartintr+0x114>
    800063f8:	01f7f713          	andi	a4,a5,31
    800063fc:	00e806b3          	add	a3,a6,a4
    80006400:	0055c703          	lbu	a4,5(a1)
    80006404:	00178793          	addi	a5,a5,1
    80006408:	02077713          	andi	a4,a4,32
    8000640c:	fc071ae3          	bnez	a4,800063e0 <uartintr+0xe0>
    80006410:	00008067          	ret
    80006414:	00008067          	ret

0000000080006418 <kinit>:
    80006418:	fc010113          	addi	sp,sp,-64
    8000641c:	02913423          	sd	s1,40(sp)
    80006420:	fffff7b7          	lui	a5,0xfffff
    80006424:	00005497          	auipc	s1,0x5
    80006428:	1db48493          	addi	s1,s1,475 # 8000b5ff <end+0xfff>
    8000642c:	02813823          	sd	s0,48(sp)
    80006430:	01313c23          	sd	s3,24(sp)
    80006434:	00f4f4b3          	and	s1,s1,a5
    80006438:	02113c23          	sd	ra,56(sp)
    8000643c:	03213023          	sd	s2,32(sp)
    80006440:	01413823          	sd	s4,16(sp)
    80006444:	01513423          	sd	s5,8(sp)
    80006448:	04010413          	addi	s0,sp,64
    8000644c:	000017b7          	lui	a5,0x1
    80006450:	01100993          	li	s3,17
    80006454:	00f487b3          	add	a5,s1,a5
    80006458:	01b99993          	slli	s3,s3,0x1b
    8000645c:	06f9e063          	bltu	s3,a5,800064bc <kinit+0xa4>
    80006460:	00004a97          	auipc	s5,0x4
    80006464:	1a0a8a93          	addi	s5,s5,416 # 8000a600 <end>
    80006468:	0754ec63          	bltu	s1,s5,800064e0 <kinit+0xc8>
    8000646c:	0734fa63          	bgeu	s1,s3,800064e0 <kinit+0xc8>
    80006470:	00088a37          	lui	s4,0x88
    80006474:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006478:	00003917          	auipc	s2,0x3
    8000647c:	da890913          	addi	s2,s2,-600 # 80009220 <kmem>
    80006480:	00ca1a13          	slli	s4,s4,0xc
    80006484:	0140006f          	j	80006498 <kinit+0x80>
    80006488:	000017b7          	lui	a5,0x1
    8000648c:	00f484b3          	add	s1,s1,a5
    80006490:	0554e863          	bltu	s1,s5,800064e0 <kinit+0xc8>
    80006494:	0534f663          	bgeu	s1,s3,800064e0 <kinit+0xc8>
    80006498:	00001637          	lui	a2,0x1
    8000649c:	00100593          	li	a1,1
    800064a0:	00048513          	mv	a0,s1
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	5e4080e7          	jalr	1508(ra) # 80006a88 <__memset>
    800064ac:	00093783          	ld	a5,0(s2)
    800064b0:	00f4b023          	sd	a5,0(s1)
    800064b4:	00993023          	sd	s1,0(s2)
    800064b8:	fd4498e3          	bne	s1,s4,80006488 <kinit+0x70>
    800064bc:	03813083          	ld	ra,56(sp)
    800064c0:	03013403          	ld	s0,48(sp)
    800064c4:	02813483          	ld	s1,40(sp)
    800064c8:	02013903          	ld	s2,32(sp)
    800064cc:	01813983          	ld	s3,24(sp)
    800064d0:	01013a03          	ld	s4,16(sp)
    800064d4:	00813a83          	ld	s5,8(sp)
    800064d8:	04010113          	addi	sp,sp,64
    800064dc:	00008067          	ret
    800064e0:	00001517          	auipc	a0,0x1
    800064e4:	f9850513          	addi	a0,a0,-104 # 80007478 <digits+0x18>
    800064e8:	fffff097          	auipc	ra,0xfffff
    800064ec:	4b4080e7          	jalr	1204(ra) # 8000599c <panic>

00000000800064f0 <freerange>:
    800064f0:	fc010113          	addi	sp,sp,-64
    800064f4:	000017b7          	lui	a5,0x1
    800064f8:	02913423          	sd	s1,40(sp)
    800064fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006500:	009504b3          	add	s1,a0,s1
    80006504:	fffff537          	lui	a0,0xfffff
    80006508:	02813823          	sd	s0,48(sp)
    8000650c:	02113c23          	sd	ra,56(sp)
    80006510:	03213023          	sd	s2,32(sp)
    80006514:	01313c23          	sd	s3,24(sp)
    80006518:	01413823          	sd	s4,16(sp)
    8000651c:	01513423          	sd	s5,8(sp)
    80006520:	01613023          	sd	s6,0(sp)
    80006524:	04010413          	addi	s0,sp,64
    80006528:	00a4f4b3          	and	s1,s1,a0
    8000652c:	00f487b3          	add	a5,s1,a5
    80006530:	06f5e463          	bltu	a1,a5,80006598 <freerange+0xa8>
    80006534:	00004a97          	auipc	s5,0x4
    80006538:	0cca8a93          	addi	s5,s5,204 # 8000a600 <end>
    8000653c:	0954e263          	bltu	s1,s5,800065c0 <freerange+0xd0>
    80006540:	01100993          	li	s3,17
    80006544:	01b99993          	slli	s3,s3,0x1b
    80006548:	0734fc63          	bgeu	s1,s3,800065c0 <freerange+0xd0>
    8000654c:	00058a13          	mv	s4,a1
    80006550:	00003917          	auipc	s2,0x3
    80006554:	cd090913          	addi	s2,s2,-816 # 80009220 <kmem>
    80006558:	00002b37          	lui	s6,0x2
    8000655c:	0140006f          	j	80006570 <freerange+0x80>
    80006560:	000017b7          	lui	a5,0x1
    80006564:	00f484b3          	add	s1,s1,a5
    80006568:	0554ec63          	bltu	s1,s5,800065c0 <freerange+0xd0>
    8000656c:	0534fa63          	bgeu	s1,s3,800065c0 <freerange+0xd0>
    80006570:	00001637          	lui	a2,0x1
    80006574:	00100593          	li	a1,1
    80006578:	00048513          	mv	a0,s1
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	50c080e7          	jalr	1292(ra) # 80006a88 <__memset>
    80006584:	00093703          	ld	a4,0(s2)
    80006588:	016487b3          	add	a5,s1,s6
    8000658c:	00e4b023          	sd	a4,0(s1)
    80006590:	00993023          	sd	s1,0(s2)
    80006594:	fcfa76e3          	bgeu	s4,a5,80006560 <freerange+0x70>
    80006598:	03813083          	ld	ra,56(sp)
    8000659c:	03013403          	ld	s0,48(sp)
    800065a0:	02813483          	ld	s1,40(sp)
    800065a4:	02013903          	ld	s2,32(sp)
    800065a8:	01813983          	ld	s3,24(sp)
    800065ac:	01013a03          	ld	s4,16(sp)
    800065b0:	00813a83          	ld	s5,8(sp)
    800065b4:	00013b03          	ld	s6,0(sp)
    800065b8:	04010113          	addi	sp,sp,64
    800065bc:	00008067          	ret
    800065c0:	00001517          	auipc	a0,0x1
    800065c4:	eb850513          	addi	a0,a0,-328 # 80007478 <digits+0x18>
    800065c8:	fffff097          	auipc	ra,0xfffff
    800065cc:	3d4080e7          	jalr	980(ra) # 8000599c <panic>

00000000800065d0 <kfree>:
    800065d0:	fe010113          	addi	sp,sp,-32
    800065d4:	00813823          	sd	s0,16(sp)
    800065d8:	00113c23          	sd	ra,24(sp)
    800065dc:	00913423          	sd	s1,8(sp)
    800065e0:	02010413          	addi	s0,sp,32
    800065e4:	03451793          	slli	a5,a0,0x34
    800065e8:	04079c63          	bnez	a5,80006640 <kfree+0x70>
    800065ec:	00004797          	auipc	a5,0x4
    800065f0:	01478793          	addi	a5,a5,20 # 8000a600 <end>
    800065f4:	00050493          	mv	s1,a0
    800065f8:	04f56463          	bltu	a0,a5,80006640 <kfree+0x70>
    800065fc:	01100793          	li	a5,17
    80006600:	01b79793          	slli	a5,a5,0x1b
    80006604:	02f57e63          	bgeu	a0,a5,80006640 <kfree+0x70>
    80006608:	00001637          	lui	a2,0x1
    8000660c:	00100593          	li	a1,1
    80006610:	00000097          	auipc	ra,0x0
    80006614:	478080e7          	jalr	1144(ra) # 80006a88 <__memset>
    80006618:	00003797          	auipc	a5,0x3
    8000661c:	c0878793          	addi	a5,a5,-1016 # 80009220 <kmem>
    80006620:	0007b703          	ld	a4,0(a5)
    80006624:	01813083          	ld	ra,24(sp)
    80006628:	01013403          	ld	s0,16(sp)
    8000662c:	00e4b023          	sd	a4,0(s1)
    80006630:	0097b023          	sd	s1,0(a5)
    80006634:	00813483          	ld	s1,8(sp)
    80006638:	02010113          	addi	sp,sp,32
    8000663c:	00008067          	ret
    80006640:	00001517          	auipc	a0,0x1
    80006644:	e3850513          	addi	a0,a0,-456 # 80007478 <digits+0x18>
    80006648:	fffff097          	auipc	ra,0xfffff
    8000664c:	354080e7          	jalr	852(ra) # 8000599c <panic>

0000000080006650 <kalloc>:
    80006650:	fe010113          	addi	sp,sp,-32
    80006654:	00813823          	sd	s0,16(sp)
    80006658:	00913423          	sd	s1,8(sp)
    8000665c:	00113c23          	sd	ra,24(sp)
    80006660:	02010413          	addi	s0,sp,32
    80006664:	00003797          	auipc	a5,0x3
    80006668:	bbc78793          	addi	a5,a5,-1092 # 80009220 <kmem>
    8000666c:	0007b483          	ld	s1,0(a5)
    80006670:	02048063          	beqz	s1,80006690 <kalloc+0x40>
    80006674:	0004b703          	ld	a4,0(s1)
    80006678:	00001637          	lui	a2,0x1
    8000667c:	00500593          	li	a1,5
    80006680:	00048513          	mv	a0,s1
    80006684:	00e7b023          	sd	a4,0(a5)
    80006688:	00000097          	auipc	ra,0x0
    8000668c:	400080e7          	jalr	1024(ra) # 80006a88 <__memset>
    80006690:	01813083          	ld	ra,24(sp)
    80006694:	01013403          	ld	s0,16(sp)
    80006698:	00048513          	mv	a0,s1
    8000669c:	00813483          	ld	s1,8(sp)
    800066a0:	02010113          	addi	sp,sp,32
    800066a4:	00008067          	ret

00000000800066a8 <initlock>:
    800066a8:	ff010113          	addi	sp,sp,-16
    800066ac:	00813423          	sd	s0,8(sp)
    800066b0:	01010413          	addi	s0,sp,16
    800066b4:	00813403          	ld	s0,8(sp)
    800066b8:	00b53423          	sd	a1,8(a0)
    800066bc:	00052023          	sw	zero,0(a0)
    800066c0:	00053823          	sd	zero,16(a0)
    800066c4:	01010113          	addi	sp,sp,16
    800066c8:	00008067          	ret

00000000800066cc <acquire>:
    800066cc:	fe010113          	addi	sp,sp,-32
    800066d0:	00813823          	sd	s0,16(sp)
    800066d4:	00913423          	sd	s1,8(sp)
    800066d8:	00113c23          	sd	ra,24(sp)
    800066dc:	01213023          	sd	s2,0(sp)
    800066e0:	02010413          	addi	s0,sp,32
    800066e4:	00050493          	mv	s1,a0
    800066e8:	10002973          	csrr	s2,sstatus
    800066ec:	100027f3          	csrr	a5,sstatus
    800066f0:	ffd7f793          	andi	a5,a5,-3
    800066f4:	10079073          	csrw	sstatus,a5
    800066f8:	fffff097          	auipc	ra,0xfffff
    800066fc:	8e0080e7          	jalr	-1824(ra) # 80004fd8 <mycpu>
    80006700:	07852783          	lw	a5,120(a0)
    80006704:	06078e63          	beqz	a5,80006780 <acquire+0xb4>
    80006708:	fffff097          	auipc	ra,0xfffff
    8000670c:	8d0080e7          	jalr	-1840(ra) # 80004fd8 <mycpu>
    80006710:	07852783          	lw	a5,120(a0)
    80006714:	0004a703          	lw	a4,0(s1)
    80006718:	0017879b          	addiw	a5,a5,1
    8000671c:	06f52c23          	sw	a5,120(a0)
    80006720:	04071063          	bnez	a4,80006760 <acquire+0x94>
    80006724:	00100713          	li	a4,1
    80006728:	00070793          	mv	a5,a4
    8000672c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006730:	0007879b          	sext.w	a5,a5
    80006734:	fe079ae3          	bnez	a5,80006728 <acquire+0x5c>
    80006738:	0ff0000f          	fence
    8000673c:	fffff097          	auipc	ra,0xfffff
    80006740:	89c080e7          	jalr	-1892(ra) # 80004fd8 <mycpu>
    80006744:	01813083          	ld	ra,24(sp)
    80006748:	01013403          	ld	s0,16(sp)
    8000674c:	00a4b823          	sd	a0,16(s1)
    80006750:	00013903          	ld	s2,0(sp)
    80006754:	00813483          	ld	s1,8(sp)
    80006758:	02010113          	addi	sp,sp,32
    8000675c:	00008067          	ret
    80006760:	0104b903          	ld	s2,16(s1)
    80006764:	fffff097          	auipc	ra,0xfffff
    80006768:	874080e7          	jalr	-1932(ra) # 80004fd8 <mycpu>
    8000676c:	faa91ce3          	bne	s2,a0,80006724 <acquire+0x58>
    80006770:	00001517          	auipc	a0,0x1
    80006774:	d1050513          	addi	a0,a0,-752 # 80007480 <digits+0x20>
    80006778:	fffff097          	auipc	ra,0xfffff
    8000677c:	224080e7          	jalr	548(ra) # 8000599c <panic>
    80006780:	00195913          	srli	s2,s2,0x1
    80006784:	fffff097          	auipc	ra,0xfffff
    80006788:	854080e7          	jalr	-1964(ra) # 80004fd8 <mycpu>
    8000678c:	00197913          	andi	s2,s2,1
    80006790:	07252e23          	sw	s2,124(a0)
    80006794:	f75ff06f          	j	80006708 <acquire+0x3c>

0000000080006798 <release>:
    80006798:	fe010113          	addi	sp,sp,-32
    8000679c:	00813823          	sd	s0,16(sp)
    800067a0:	00113c23          	sd	ra,24(sp)
    800067a4:	00913423          	sd	s1,8(sp)
    800067a8:	01213023          	sd	s2,0(sp)
    800067ac:	02010413          	addi	s0,sp,32
    800067b0:	00052783          	lw	a5,0(a0)
    800067b4:	00079a63          	bnez	a5,800067c8 <release+0x30>
    800067b8:	00001517          	auipc	a0,0x1
    800067bc:	cd050513          	addi	a0,a0,-816 # 80007488 <digits+0x28>
    800067c0:	fffff097          	auipc	ra,0xfffff
    800067c4:	1dc080e7          	jalr	476(ra) # 8000599c <panic>
    800067c8:	01053903          	ld	s2,16(a0)
    800067cc:	00050493          	mv	s1,a0
    800067d0:	fffff097          	auipc	ra,0xfffff
    800067d4:	808080e7          	jalr	-2040(ra) # 80004fd8 <mycpu>
    800067d8:	fea910e3          	bne	s2,a0,800067b8 <release+0x20>
    800067dc:	0004b823          	sd	zero,16(s1)
    800067e0:	0ff0000f          	fence
    800067e4:	0f50000f          	fence	iorw,ow
    800067e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800067ec:	ffffe097          	auipc	ra,0xffffe
    800067f0:	7ec080e7          	jalr	2028(ra) # 80004fd8 <mycpu>
    800067f4:	100027f3          	csrr	a5,sstatus
    800067f8:	0027f793          	andi	a5,a5,2
    800067fc:	04079a63          	bnez	a5,80006850 <release+0xb8>
    80006800:	07852783          	lw	a5,120(a0)
    80006804:	02f05e63          	blez	a5,80006840 <release+0xa8>
    80006808:	fff7871b          	addiw	a4,a5,-1
    8000680c:	06e52c23          	sw	a4,120(a0)
    80006810:	00071c63          	bnez	a4,80006828 <release+0x90>
    80006814:	07c52783          	lw	a5,124(a0)
    80006818:	00078863          	beqz	a5,80006828 <release+0x90>
    8000681c:	100027f3          	csrr	a5,sstatus
    80006820:	0027e793          	ori	a5,a5,2
    80006824:	10079073          	csrw	sstatus,a5
    80006828:	01813083          	ld	ra,24(sp)
    8000682c:	01013403          	ld	s0,16(sp)
    80006830:	00813483          	ld	s1,8(sp)
    80006834:	00013903          	ld	s2,0(sp)
    80006838:	02010113          	addi	sp,sp,32
    8000683c:	00008067          	ret
    80006840:	00001517          	auipc	a0,0x1
    80006844:	c6850513          	addi	a0,a0,-920 # 800074a8 <digits+0x48>
    80006848:	fffff097          	auipc	ra,0xfffff
    8000684c:	154080e7          	jalr	340(ra) # 8000599c <panic>
    80006850:	00001517          	auipc	a0,0x1
    80006854:	c4050513          	addi	a0,a0,-960 # 80007490 <digits+0x30>
    80006858:	fffff097          	auipc	ra,0xfffff
    8000685c:	144080e7          	jalr	324(ra) # 8000599c <panic>

0000000080006860 <holding>:
    80006860:	00052783          	lw	a5,0(a0)
    80006864:	00079663          	bnez	a5,80006870 <holding+0x10>
    80006868:	00000513          	li	a0,0
    8000686c:	00008067          	ret
    80006870:	fe010113          	addi	sp,sp,-32
    80006874:	00813823          	sd	s0,16(sp)
    80006878:	00913423          	sd	s1,8(sp)
    8000687c:	00113c23          	sd	ra,24(sp)
    80006880:	02010413          	addi	s0,sp,32
    80006884:	01053483          	ld	s1,16(a0)
    80006888:	ffffe097          	auipc	ra,0xffffe
    8000688c:	750080e7          	jalr	1872(ra) # 80004fd8 <mycpu>
    80006890:	01813083          	ld	ra,24(sp)
    80006894:	01013403          	ld	s0,16(sp)
    80006898:	40a48533          	sub	a0,s1,a0
    8000689c:	00153513          	seqz	a0,a0
    800068a0:	00813483          	ld	s1,8(sp)
    800068a4:	02010113          	addi	sp,sp,32
    800068a8:	00008067          	ret

00000000800068ac <push_off>:
    800068ac:	fe010113          	addi	sp,sp,-32
    800068b0:	00813823          	sd	s0,16(sp)
    800068b4:	00113c23          	sd	ra,24(sp)
    800068b8:	00913423          	sd	s1,8(sp)
    800068bc:	02010413          	addi	s0,sp,32
    800068c0:	100024f3          	csrr	s1,sstatus
    800068c4:	100027f3          	csrr	a5,sstatus
    800068c8:	ffd7f793          	andi	a5,a5,-3
    800068cc:	10079073          	csrw	sstatus,a5
    800068d0:	ffffe097          	auipc	ra,0xffffe
    800068d4:	708080e7          	jalr	1800(ra) # 80004fd8 <mycpu>
    800068d8:	07852783          	lw	a5,120(a0)
    800068dc:	02078663          	beqz	a5,80006908 <push_off+0x5c>
    800068e0:	ffffe097          	auipc	ra,0xffffe
    800068e4:	6f8080e7          	jalr	1784(ra) # 80004fd8 <mycpu>
    800068e8:	07852783          	lw	a5,120(a0)
    800068ec:	01813083          	ld	ra,24(sp)
    800068f0:	01013403          	ld	s0,16(sp)
    800068f4:	0017879b          	addiw	a5,a5,1
    800068f8:	06f52c23          	sw	a5,120(a0)
    800068fc:	00813483          	ld	s1,8(sp)
    80006900:	02010113          	addi	sp,sp,32
    80006904:	00008067          	ret
    80006908:	0014d493          	srli	s1,s1,0x1
    8000690c:	ffffe097          	auipc	ra,0xffffe
    80006910:	6cc080e7          	jalr	1740(ra) # 80004fd8 <mycpu>
    80006914:	0014f493          	andi	s1,s1,1
    80006918:	06952e23          	sw	s1,124(a0)
    8000691c:	fc5ff06f          	j	800068e0 <push_off+0x34>

0000000080006920 <pop_off>:
    80006920:	ff010113          	addi	sp,sp,-16
    80006924:	00813023          	sd	s0,0(sp)
    80006928:	00113423          	sd	ra,8(sp)
    8000692c:	01010413          	addi	s0,sp,16
    80006930:	ffffe097          	auipc	ra,0xffffe
    80006934:	6a8080e7          	jalr	1704(ra) # 80004fd8 <mycpu>
    80006938:	100027f3          	csrr	a5,sstatus
    8000693c:	0027f793          	andi	a5,a5,2
    80006940:	04079663          	bnez	a5,8000698c <pop_off+0x6c>
    80006944:	07852783          	lw	a5,120(a0)
    80006948:	02f05a63          	blez	a5,8000697c <pop_off+0x5c>
    8000694c:	fff7871b          	addiw	a4,a5,-1
    80006950:	06e52c23          	sw	a4,120(a0)
    80006954:	00071c63          	bnez	a4,8000696c <pop_off+0x4c>
    80006958:	07c52783          	lw	a5,124(a0)
    8000695c:	00078863          	beqz	a5,8000696c <pop_off+0x4c>
    80006960:	100027f3          	csrr	a5,sstatus
    80006964:	0027e793          	ori	a5,a5,2
    80006968:	10079073          	csrw	sstatus,a5
    8000696c:	00813083          	ld	ra,8(sp)
    80006970:	00013403          	ld	s0,0(sp)
    80006974:	01010113          	addi	sp,sp,16
    80006978:	00008067          	ret
    8000697c:	00001517          	auipc	a0,0x1
    80006980:	b2c50513          	addi	a0,a0,-1236 # 800074a8 <digits+0x48>
    80006984:	fffff097          	auipc	ra,0xfffff
    80006988:	018080e7          	jalr	24(ra) # 8000599c <panic>
    8000698c:	00001517          	auipc	a0,0x1
    80006990:	b0450513          	addi	a0,a0,-1276 # 80007490 <digits+0x30>
    80006994:	fffff097          	auipc	ra,0xfffff
    80006998:	008080e7          	jalr	8(ra) # 8000599c <panic>

000000008000699c <push_on>:
    8000699c:	fe010113          	addi	sp,sp,-32
    800069a0:	00813823          	sd	s0,16(sp)
    800069a4:	00113c23          	sd	ra,24(sp)
    800069a8:	00913423          	sd	s1,8(sp)
    800069ac:	02010413          	addi	s0,sp,32
    800069b0:	100024f3          	csrr	s1,sstatus
    800069b4:	100027f3          	csrr	a5,sstatus
    800069b8:	0027e793          	ori	a5,a5,2
    800069bc:	10079073          	csrw	sstatus,a5
    800069c0:	ffffe097          	auipc	ra,0xffffe
    800069c4:	618080e7          	jalr	1560(ra) # 80004fd8 <mycpu>
    800069c8:	07852783          	lw	a5,120(a0)
    800069cc:	02078663          	beqz	a5,800069f8 <push_on+0x5c>
    800069d0:	ffffe097          	auipc	ra,0xffffe
    800069d4:	608080e7          	jalr	1544(ra) # 80004fd8 <mycpu>
    800069d8:	07852783          	lw	a5,120(a0)
    800069dc:	01813083          	ld	ra,24(sp)
    800069e0:	01013403          	ld	s0,16(sp)
    800069e4:	0017879b          	addiw	a5,a5,1
    800069e8:	06f52c23          	sw	a5,120(a0)
    800069ec:	00813483          	ld	s1,8(sp)
    800069f0:	02010113          	addi	sp,sp,32
    800069f4:	00008067          	ret
    800069f8:	0014d493          	srli	s1,s1,0x1
    800069fc:	ffffe097          	auipc	ra,0xffffe
    80006a00:	5dc080e7          	jalr	1500(ra) # 80004fd8 <mycpu>
    80006a04:	0014f493          	andi	s1,s1,1
    80006a08:	06952e23          	sw	s1,124(a0)
    80006a0c:	fc5ff06f          	j	800069d0 <push_on+0x34>

0000000080006a10 <pop_on>:
    80006a10:	ff010113          	addi	sp,sp,-16
    80006a14:	00813023          	sd	s0,0(sp)
    80006a18:	00113423          	sd	ra,8(sp)
    80006a1c:	01010413          	addi	s0,sp,16
    80006a20:	ffffe097          	auipc	ra,0xffffe
    80006a24:	5b8080e7          	jalr	1464(ra) # 80004fd8 <mycpu>
    80006a28:	100027f3          	csrr	a5,sstatus
    80006a2c:	0027f793          	andi	a5,a5,2
    80006a30:	04078463          	beqz	a5,80006a78 <pop_on+0x68>
    80006a34:	07852783          	lw	a5,120(a0)
    80006a38:	02f05863          	blez	a5,80006a68 <pop_on+0x58>
    80006a3c:	fff7879b          	addiw	a5,a5,-1
    80006a40:	06f52c23          	sw	a5,120(a0)
    80006a44:	07853783          	ld	a5,120(a0)
    80006a48:	00079863          	bnez	a5,80006a58 <pop_on+0x48>
    80006a4c:	100027f3          	csrr	a5,sstatus
    80006a50:	ffd7f793          	andi	a5,a5,-3
    80006a54:	10079073          	csrw	sstatus,a5
    80006a58:	00813083          	ld	ra,8(sp)
    80006a5c:	00013403          	ld	s0,0(sp)
    80006a60:	01010113          	addi	sp,sp,16
    80006a64:	00008067          	ret
    80006a68:	00001517          	auipc	a0,0x1
    80006a6c:	a6850513          	addi	a0,a0,-1432 # 800074d0 <digits+0x70>
    80006a70:	fffff097          	auipc	ra,0xfffff
    80006a74:	f2c080e7          	jalr	-212(ra) # 8000599c <panic>
    80006a78:	00001517          	auipc	a0,0x1
    80006a7c:	a3850513          	addi	a0,a0,-1480 # 800074b0 <digits+0x50>
    80006a80:	fffff097          	auipc	ra,0xfffff
    80006a84:	f1c080e7          	jalr	-228(ra) # 8000599c <panic>

0000000080006a88 <__memset>:
    80006a88:	ff010113          	addi	sp,sp,-16
    80006a8c:	00813423          	sd	s0,8(sp)
    80006a90:	01010413          	addi	s0,sp,16
    80006a94:	1a060e63          	beqz	a2,80006c50 <__memset+0x1c8>
    80006a98:	40a007b3          	neg	a5,a0
    80006a9c:	0077f793          	andi	a5,a5,7
    80006aa0:	00778693          	addi	a3,a5,7
    80006aa4:	00b00813          	li	a6,11
    80006aa8:	0ff5f593          	andi	a1,a1,255
    80006aac:	fff6071b          	addiw	a4,a2,-1
    80006ab0:	1b06e663          	bltu	a3,a6,80006c5c <__memset+0x1d4>
    80006ab4:	1cd76463          	bltu	a4,a3,80006c7c <__memset+0x1f4>
    80006ab8:	1a078e63          	beqz	a5,80006c74 <__memset+0x1ec>
    80006abc:	00b50023          	sb	a1,0(a0)
    80006ac0:	00100713          	li	a4,1
    80006ac4:	1ae78463          	beq	a5,a4,80006c6c <__memset+0x1e4>
    80006ac8:	00b500a3          	sb	a1,1(a0)
    80006acc:	00200713          	li	a4,2
    80006ad0:	1ae78a63          	beq	a5,a4,80006c84 <__memset+0x1fc>
    80006ad4:	00b50123          	sb	a1,2(a0)
    80006ad8:	00300713          	li	a4,3
    80006adc:	18e78463          	beq	a5,a4,80006c64 <__memset+0x1dc>
    80006ae0:	00b501a3          	sb	a1,3(a0)
    80006ae4:	00400713          	li	a4,4
    80006ae8:	1ae78263          	beq	a5,a4,80006c8c <__memset+0x204>
    80006aec:	00b50223          	sb	a1,4(a0)
    80006af0:	00500713          	li	a4,5
    80006af4:	1ae78063          	beq	a5,a4,80006c94 <__memset+0x20c>
    80006af8:	00b502a3          	sb	a1,5(a0)
    80006afc:	00700713          	li	a4,7
    80006b00:	18e79e63          	bne	a5,a4,80006c9c <__memset+0x214>
    80006b04:	00b50323          	sb	a1,6(a0)
    80006b08:	00700e93          	li	t4,7
    80006b0c:	00859713          	slli	a4,a1,0x8
    80006b10:	00e5e733          	or	a4,a1,a4
    80006b14:	01059e13          	slli	t3,a1,0x10
    80006b18:	01c76e33          	or	t3,a4,t3
    80006b1c:	01859313          	slli	t1,a1,0x18
    80006b20:	006e6333          	or	t1,t3,t1
    80006b24:	02059893          	slli	a7,a1,0x20
    80006b28:	40f60e3b          	subw	t3,a2,a5
    80006b2c:	011368b3          	or	a7,t1,a7
    80006b30:	02859813          	slli	a6,a1,0x28
    80006b34:	0108e833          	or	a6,a7,a6
    80006b38:	03059693          	slli	a3,a1,0x30
    80006b3c:	003e589b          	srliw	a7,t3,0x3
    80006b40:	00d866b3          	or	a3,a6,a3
    80006b44:	03859713          	slli	a4,a1,0x38
    80006b48:	00389813          	slli	a6,a7,0x3
    80006b4c:	00f507b3          	add	a5,a0,a5
    80006b50:	00e6e733          	or	a4,a3,a4
    80006b54:	000e089b          	sext.w	a7,t3
    80006b58:	00f806b3          	add	a3,a6,a5
    80006b5c:	00e7b023          	sd	a4,0(a5)
    80006b60:	00878793          	addi	a5,a5,8
    80006b64:	fed79ce3          	bne	a5,a3,80006b5c <__memset+0xd4>
    80006b68:	ff8e7793          	andi	a5,t3,-8
    80006b6c:	0007871b          	sext.w	a4,a5
    80006b70:	01d787bb          	addw	a5,a5,t4
    80006b74:	0ce88e63          	beq	a7,a4,80006c50 <__memset+0x1c8>
    80006b78:	00f50733          	add	a4,a0,a5
    80006b7c:	00b70023          	sb	a1,0(a4)
    80006b80:	0017871b          	addiw	a4,a5,1
    80006b84:	0cc77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006b88:	00e50733          	add	a4,a0,a4
    80006b8c:	00b70023          	sb	a1,0(a4)
    80006b90:	0027871b          	addiw	a4,a5,2
    80006b94:	0ac77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006b98:	00e50733          	add	a4,a0,a4
    80006b9c:	00b70023          	sb	a1,0(a4)
    80006ba0:	0037871b          	addiw	a4,a5,3
    80006ba4:	0ac77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006ba8:	00e50733          	add	a4,a0,a4
    80006bac:	00b70023          	sb	a1,0(a4)
    80006bb0:	0047871b          	addiw	a4,a5,4
    80006bb4:	08c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bb8:	00e50733          	add	a4,a0,a4
    80006bbc:	00b70023          	sb	a1,0(a4)
    80006bc0:	0057871b          	addiw	a4,a5,5
    80006bc4:	08c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bc8:	00e50733          	add	a4,a0,a4
    80006bcc:	00b70023          	sb	a1,0(a4)
    80006bd0:	0067871b          	addiw	a4,a5,6
    80006bd4:	06c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bd8:	00e50733          	add	a4,a0,a4
    80006bdc:	00b70023          	sb	a1,0(a4)
    80006be0:	0077871b          	addiw	a4,a5,7
    80006be4:	06c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006be8:	00e50733          	add	a4,a0,a4
    80006bec:	00b70023          	sb	a1,0(a4)
    80006bf0:	0087871b          	addiw	a4,a5,8
    80006bf4:	04c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bf8:	00e50733          	add	a4,a0,a4
    80006bfc:	00b70023          	sb	a1,0(a4)
    80006c00:	0097871b          	addiw	a4,a5,9
    80006c04:	04c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c08:	00e50733          	add	a4,a0,a4
    80006c0c:	00b70023          	sb	a1,0(a4)
    80006c10:	00a7871b          	addiw	a4,a5,10
    80006c14:	02c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c18:	00e50733          	add	a4,a0,a4
    80006c1c:	00b70023          	sb	a1,0(a4)
    80006c20:	00b7871b          	addiw	a4,a5,11
    80006c24:	02c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c28:	00e50733          	add	a4,a0,a4
    80006c2c:	00b70023          	sb	a1,0(a4)
    80006c30:	00c7871b          	addiw	a4,a5,12
    80006c34:	00c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c38:	00e50733          	add	a4,a0,a4
    80006c3c:	00b70023          	sb	a1,0(a4)
    80006c40:	00d7879b          	addiw	a5,a5,13
    80006c44:	00c7f663          	bgeu	a5,a2,80006c50 <__memset+0x1c8>
    80006c48:	00f507b3          	add	a5,a0,a5
    80006c4c:	00b78023          	sb	a1,0(a5)
    80006c50:	00813403          	ld	s0,8(sp)
    80006c54:	01010113          	addi	sp,sp,16
    80006c58:	00008067          	ret
    80006c5c:	00b00693          	li	a3,11
    80006c60:	e55ff06f          	j	80006ab4 <__memset+0x2c>
    80006c64:	00300e93          	li	t4,3
    80006c68:	ea5ff06f          	j	80006b0c <__memset+0x84>
    80006c6c:	00100e93          	li	t4,1
    80006c70:	e9dff06f          	j	80006b0c <__memset+0x84>
    80006c74:	00000e93          	li	t4,0
    80006c78:	e95ff06f          	j	80006b0c <__memset+0x84>
    80006c7c:	00000793          	li	a5,0
    80006c80:	ef9ff06f          	j	80006b78 <__memset+0xf0>
    80006c84:	00200e93          	li	t4,2
    80006c88:	e85ff06f          	j	80006b0c <__memset+0x84>
    80006c8c:	00400e93          	li	t4,4
    80006c90:	e7dff06f          	j	80006b0c <__memset+0x84>
    80006c94:	00500e93          	li	t4,5
    80006c98:	e75ff06f          	j	80006b0c <__memset+0x84>
    80006c9c:	00600e93          	li	t4,6
    80006ca0:	e6dff06f          	j	80006b0c <__memset+0x84>

0000000080006ca4 <__memmove>:
    80006ca4:	ff010113          	addi	sp,sp,-16
    80006ca8:	00813423          	sd	s0,8(sp)
    80006cac:	01010413          	addi	s0,sp,16
    80006cb0:	0e060863          	beqz	a2,80006da0 <__memmove+0xfc>
    80006cb4:	fff6069b          	addiw	a3,a2,-1
    80006cb8:	0006881b          	sext.w	a6,a3
    80006cbc:	0ea5e863          	bltu	a1,a0,80006dac <__memmove+0x108>
    80006cc0:	00758713          	addi	a4,a1,7
    80006cc4:	00a5e7b3          	or	a5,a1,a0
    80006cc8:	40a70733          	sub	a4,a4,a0
    80006ccc:	0077f793          	andi	a5,a5,7
    80006cd0:	00f73713          	sltiu	a4,a4,15
    80006cd4:	00174713          	xori	a4,a4,1
    80006cd8:	0017b793          	seqz	a5,a5
    80006cdc:	00e7f7b3          	and	a5,a5,a4
    80006ce0:	10078863          	beqz	a5,80006df0 <__memmove+0x14c>
    80006ce4:	00900793          	li	a5,9
    80006ce8:	1107f463          	bgeu	a5,a6,80006df0 <__memmove+0x14c>
    80006cec:	0036581b          	srliw	a6,a2,0x3
    80006cf0:	fff8081b          	addiw	a6,a6,-1
    80006cf4:	02081813          	slli	a6,a6,0x20
    80006cf8:	01d85893          	srli	a7,a6,0x1d
    80006cfc:	00858813          	addi	a6,a1,8
    80006d00:	00058793          	mv	a5,a1
    80006d04:	00050713          	mv	a4,a0
    80006d08:	01088833          	add	a6,a7,a6
    80006d0c:	0007b883          	ld	a7,0(a5)
    80006d10:	00878793          	addi	a5,a5,8
    80006d14:	00870713          	addi	a4,a4,8
    80006d18:	ff173c23          	sd	a7,-8(a4)
    80006d1c:	ff0798e3          	bne	a5,a6,80006d0c <__memmove+0x68>
    80006d20:	ff867713          	andi	a4,a2,-8
    80006d24:	02071793          	slli	a5,a4,0x20
    80006d28:	0207d793          	srli	a5,a5,0x20
    80006d2c:	00f585b3          	add	a1,a1,a5
    80006d30:	40e686bb          	subw	a3,a3,a4
    80006d34:	00f507b3          	add	a5,a0,a5
    80006d38:	06e60463          	beq	a2,a4,80006da0 <__memmove+0xfc>
    80006d3c:	0005c703          	lbu	a4,0(a1)
    80006d40:	00e78023          	sb	a4,0(a5)
    80006d44:	04068e63          	beqz	a3,80006da0 <__memmove+0xfc>
    80006d48:	0015c603          	lbu	a2,1(a1)
    80006d4c:	00100713          	li	a4,1
    80006d50:	00c780a3          	sb	a2,1(a5)
    80006d54:	04e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d58:	0025c603          	lbu	a2,2(a1)
    80006d5c:	00200713          	li	a4,2
    80006d60:	00c78123          	sb	a2,2(a5)
    80006d64:	02e68e63          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d68:	0035c603          	lbu	a2,3(a1)
    80006d6c:	00300713          	li	a4,3
    80006d70:	00c781a3          	sb	a2,3(a5)
    80006d74:	02e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d78:	0045c603          	lbu	a2,4(a1)
    80006d7c:	00400713          	li	a4,4
    80006d80:	00c78223          	sb	a2,4(a5)
    80006d84:	00e68e63          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d88:	0055c603          	lbu	a2,5(a1)
    80006d8c:	00500713          	li	a4,5
    80006d90:	00c782a3          	sb	a2,5(a5)
    80006d94:	00e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d98:	0065c703          	lbu	a4,6(a1)
    80006d9c:	00e78323          	sb	a4,6(a5)
    80006da0:	00813403          	ld	s0,8(sp)
    80006da4:	01010113          	addi	sp,sp,16
    80006da8:	00008067          	ret
    80006dac:	02061713          	slli	a4,a2,0x20
    80006db0:	02075713          	srli	a4,a4,0x20
    80006db4:	00e587b3          	add	a5,a1,a4
    80006db8:	f0f574e3          	bgeu	a0,a5,80006cc0 <__memmove+0x1c>
    80006dbc:	02069613          	slli	a2,a3,0x20
    80006dc0:	02065613          	srli	a2,a2,0x20
    80006dc4:	fff64613          	not	a2,a2
    80006dc8:	00e50733          	add	a4,a0,a4
    80006dcc:	00c78633          	add	a2,a5,a2
    80006dd0:	fff7c683          	lbu	a3,-1(a5)
    80006dd4:	fff78793          	addi	a5,a5,-1
    80006dd8:	fff70713          	addi	a4,a4,-1
    80006ddc:	00d70023          	sb	a3,0(a4)
    80006de0:	fec798e3          	bne	a5,a2,80006dd0 <__memmove+0x12c>
    80006de4:	00813403          	ld	s0,8(sp)
    80006de8:	01010113          	addi	sp,sp,16
    80006dec:	00008067          	ret
    80006df0:	02069713          	slli	a4,a3,0x20
    80006df4:	02075713          	srli	a4,a4,0x20
    80006df8:	00170713          	addi	a4,a4,1
    80006dfc:	00e50733          	add	a4,a0,a4
    80006e00:	00050793          	mv	a5,a0
    80006e04:	0005c683          	lbu	a3,0(a1)
    80006e08:	00178793          	addi	a5,a5,1
    80006e0c:	00158593          	addi	a1,a1,1
    80006e10:	fed78fa3          	sb	a3,-1(a5)
    80006e14:	fee798e3          	bne	a5,a4,80006e04 <__memmove+0x160>
    80006e18:	f89ff06f          	j	80006da0 <__memmove+0xfc>
	...
