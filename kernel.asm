
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	3c013103          	ld	sp,960(sp) # 8000a3c0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1e0050ef          	jal	ra,800051fc <start>

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
    8000100c:	469000ef          	jal	ra,80001c74 <_ZN3PCB10getContextEv>
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
    8000109c:	4d4000ef          	jal	ra,80001570 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	3d5000ef          	jal	ra,80001c74 <_ZN3PCB10getContextEv>

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

0000000080001528 <_Z5kPutcc>:


void kPutc(char c) {
    80001528:	ff010113          	addi	sp,sp,-16
    8000152c:	00113423          	sd	ra,8(sp)
    80001530:	00813023          	sd	s0,0(sp)
    80001534:	01010413          	addi	s0,sp,16
    80001538:	00050593          	mv	a1,a0
    CCB::outputBuffer.pushBack(c);
    8000153c:	00009517          	auipc	a0,0x9
    80001540:	e6453503          	ld	a0,-412(a0) # 8000a3a0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001544:	00001097          	auipc	ra,0x1
    80001548:	eac080e7          	jalr	-340(ra) # 800023f0 <_ZN8IOBuffer8pushBackEc>
    CCB::semOutput->signal();
    8000154c:	00009797          	auipc	a5,0x9
    80001550:	e9c7b783          	ld	a5,-356(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001554:	0007b503          	ld	a0,0(a5)
    80001558:	00002097          	auipc	ra,0x2
    8000155c:	35c080e7          	jalr	860(ra) # 800038b4 <_ZN3SCB6signalEv>
}
    80001560:	00813083          	ld	ra,8(sp)
    80001564:	00013403          	ld	s0,0(sp)
    80001568:	01010113          	addi	sp,sp,16
    8000156c:	00008067          	ret

0000000080001570 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001570:	fa010113          	addi	sp,sp,-96
    80001574:	04113c23          	sd	ra,88(sp)
    80001578:	04813823          	sd	s0,80(sp)
    8000157c:	04913423          	sd	s1,72(sp)
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
    800015bc:	04f70463          	beq	a4,a5,80001604 <interruptHandler+0x94>
    800015c0:	fd843703          	ld	a4,-40(s0)
    800015c4:	00800793          	li	a5,8
    800015c8:	02f70e63          	beq	a4,a5,80001604 <interruptHandler+0x94>
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
    800015dc:	30f70663          	beq	a4,a5,800018e8 <interruptHandler+0x378>
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
    800015f0:	34f70c63          	beq	a4,a5,80001948 <interruptHandler+0x3d8>
        plic_complete(code);


    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        kPutc('c');
    800015f4:	06300513          	li	a0,99
    800015f8:	00000097          	auipc	ra,0x0
    800015fc:	f30080e7          	jalr	-208(ra) # 80001528 <_Z5kPutcc>
    80001600:	0840006f          	j	80001684 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001604:	fd043783          	ld	a5,-48(s0)
    80001608:	00478793          	addi	a5,a5,4
    8000160c:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    80001610:	00009797          	auipc	a5,0x9
    80001614:	dc87b783          	ld	a5,-568(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001618:	0007b503          	ld	a0,0(a5)
    8000161c:	01853703          	ld	a4,24(a0)
    80001620:	05073783          	ld	a5,80(a4)
    80001624:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    80001628:	fa843783          	ld	a5,-88(s0)
    8000162c:	04300693          	li	a3,67
    80001630:	04f6e263          	bltu	a3,a5,80001674 <interruptHandler+0x104>
    80001634:	00279793          	slli	a5,a5,0x2
    80001638:	00007697          	auipc	a3,0x7
    8000163c:	9e868693          	addi	a3,a3,-1560 # 80008020 <CONSOLE_STATUS+0x10>
    80001640:	00d787b3          	add	a5,a5,a3
    80001644:	0007a783          	lw	a5,0(a5)
    80001648:	00d787b3          	add	a5,a5,a3
    8000164c:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001650:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001654:	00651513          	slli	a0,a0,0x6
    80001658:	00003097          	auipc	ra,0x3
    8000165c:	f7c080e7          	jalr	-132(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
    80001660:	00009797          	auipc	a5,0x9
    80001664:	d787b783          	ld	a5,-648(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001668:	0007b783          	ld	a5,0(a5)
    8000166c:	0187b783          	ld	a5,24(a5)
    80001670:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001674:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001678:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    8000167c:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001680:	10079073          	csrw	sstatus,a5
    }

}
    80001684:	05813083          	ld	ra,88(sp)
    80001688:	05013403          	ld	s0,80(sp)
    8000168c:	04813483          	ld	s1,72(sp)
    80001690:	06010113          	addi	sp,sp,96
    80001694:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001698:	05873503          	ld	a0,88(a4)
    8000169c:	00003097          	auipc	ra,0x3
    800016a0:	0cc080e7          	jalr	204(ra) # 80004768 <_ZN15MemoryAllocator8mem_freeEPv>
    800016a4:	00009797          	auipc	a5,0x9
    800016a8:	d347b783          	ld	a5,-716(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016ac:	0007b783          	ld	a5,0(a5)
    800016b0:	0187b783          	ld	a5,24(a5)
    800016b4:	04a7b823          	sd	a0,80(a5)
                break;
    800016b8:	fbdff06f          	j	80001674 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    800016bc:	00009797          	auipc	a5,0x9
    800016c0:	cfc7b783          	ld	a5,-772(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016c4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	480080e7          	jalr	1152(ra) # 80001b48 <_ZN3PCB8dispatchEv>
                break;
    800016d0:	fa5ff06f          	j	80001674 <interruptHandler+0x104>
                PCB::running->finished = true;
    800016d4:	00100793          	li	a5,1
    800016d8:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    800016dc:	00009797          	auipc	a5,0x9
    800016e0:	cdc7b783          	ld	a5,-804(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016e4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	460080e7          	jalr	1120(ra) # 80001b48 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800016f0:	00009797          	auipc	a5,0x9
    800016f4:	ce87b783          	ld	a5,-792(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016f8:	0007b783          	ld	a5,0(a5)
    800016fc:	0187b783          	ld	a5,24(a5)
    80001700:	0407b823          	sd	zero,80(a5)
                break;
    80001704:	f71ff06f          	j	80001674 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    80001708:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    8000170c:	0007b503          	ld	a0,0(a5)
    80001710:	00001097          	auipc	ra,0x1
    80001714:	744080e7          	jalr	1860(ra) # 80002e54 <_ZN9Scheduler3putEP3PCB>
                break;
    80001718:	f5dff06f          	j	80001674 <interruptHandler+0x104>
                PCB::processMain main = (PCB::processMain)PCB::running->registers[12];
    8000171c:	06073503          	ld	a0,96(a4)
                void *arg = (void*)PCB::running->registers[13];
    80001720:	06873583          	ld	a1,104(a4)
                PCB **handle = (PCB**)PCB::running->registers[11];
    80001724:	05873483          	ld	s1,88(a4)
                if(scause == 9) { // sistemski rezim
    80001728:	fd843703          	ld	a4,-40(s0)
    8000172c:	00900793          	li	a5,9
    80001730:	04f70863          	beq	a4,a5,80001780 <interruptHandler+0x210>
                    *handle = PCB::createProccess(main, arg);
    80001734:	00000097          	auipc	ra,0x0
    80001738:	640080e7          	jalr	1600(ra) # 80001d74 <_ZN3PCB14createProccessEPFvvEPv>
    8000173c:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001740:	00009797          	auipc	a5,0x9
    80001744:	c987b783          	ld	a5,-872(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001748:	0007b783          	ld	a5,0(a5)
    8000174c:	0187b703          	ld	a4,24(a5)
    80001750:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001754:	0004b703          	ld	a4,0(s1)
    80001758:	f0070ee3          	beqz	a4,80001674 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    8000175c:	0187b783          	ld	a5,24(a5)
    80001760:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001764:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001768:	00008737          	lui	a4,0x8
    8000176c:	00e787b3          	add	a5,a5,a4
    80001770:	0004b703          	ld	a4,0(s1)
    80001774:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001778:	00f73823          	sd	a5,16(a4)
                break;
    8000177c:	ef9ff06f          	j	80001674 <interruptHandler+0x104>
                    *handle = PCB::createSysProcess(main, arg);
    80001780:	00000097          	auipc	ra,0x0
    80001784:	6e8080e7          	jalr	1768(ra) # 80001e68 <_ZN3PCB16createSysProcessEPFvvEPv>
    80001788:	00a4b023          	sd	a0,0(s1)
    8000178c:	fb5ff06f          	j	80001740 <interruptHandler+0x1d0>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001790:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001794:	06072503          	lw	a0,96(a4)
                if(scause == 9) { // sistemski rezim
    80001798:	fd843703          	ld	a4,-40(s0)
    8000179c:	00900793          	li	a5,9
    800017a0:	02f70463          	beq	a4,a5,800017c8 <interruptHandler+0x258>
                    (*handle) = SCB::createSemaphore(init);
    800017a4:	00002097          	auipc	ra,0x2
    800017a8:	254080e7          	jalr	596(ra) # 800039f8 <_ZN3SCB15createSemaphoreEi>
    800017ac:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800017b0:	00009797          	auipc	a5,0x9
    800017b4:	c287b783          	ld	a5,-984(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017b8:	0007b783          	ld	a5,0(a5)
    800017bc:	0187b783          	ld	a5,24(a5)
    800017c0:	0497b823          	sd	s1,80(a5)
                break;
    800017c4:	eb1ff06f          	j	80001674 <interruptHandler+0x104>
                    (*handle) = SCB::createSysSemaphore(init);
    800017c8:	00002097          	auipc	ra,0x2
    800017cc:	2e8080e7          	jalr	744(ra) # 80003ab0 <_ZN3SCB18createSysSemaphoreEi>
    800017d0:	00a4b023          	sd	a0,0(s1)
    800017d4:	fddff06f          	j	800017b0 <interruptHandler+0x240>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    800017d8:	05873503          	ld	a0,88(a4)
    800017dc:	00002097          	auipc	ra,0x2
    800017e0:	044080e7          	jalr	68(ra) # 80003820 <_ZN3SCB4waitEv>
    800017e4:	00009797          	auipc	a5,0x9
    800017e8:	bf47b783          	ld	a5,-1036(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017ec:	0007b783          	ld	a5,0(a5)
    800017f0:	0187b783          	ld	a5,24(a5)
    800017f4:	04a7b823          	sd	a0,80(a5)
                break;
    800017f8:	e7dff06f          	j	80001674 <interruptHandler+0x104>
                sem->signal();
    800017fc:	05873503          	ld	a0,88(a4)
    80001800:	00002097          	auipc	ra,0x2
    80001804:	0b4080e7          	jalr	180(ra) # 800038b4 <_ZN3SCB6signalEv>
                break;
    80001808:	e6dff06f          	j	80001674 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    8000180c:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    80001810:	00048513          	mv	a0,s1
    80001814:	00002097          	auipc	ra,0x2
    80001818:	180080e7          	jalr	384(ra) # 80003994 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    8000181c:	e4048ce3          	beqz	s1,80001674 <interruptHandler+0x104>
    80001820:	00048513          	mv	a0,s1
    80001824:	00002097          	auipc	ra,0x2
    80001828:	148080e7          	jalr	328(ra) # 8000396c <_ZN3SCBdlEPv>
    8000182c:	e49ff06f          	j	80001674 <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    80001830:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    80001834:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    80001838:	00000097          	auipc	ra,0x0
    8000183c:	124080e7          	jalr	292(ra) # 8000195c <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    80001840:	e35ff06f          	j	80001674 <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    80001844:	05874583          	lbu	a1,88(a4)
    80001848:	00009517          	auipc	a0,0x9
    8000184c:	b5853503          	ld	a0,-1192(a0) # 8000a3a0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001850:	00001097          	auipc	ra,0x1
    80001854:	ba0080e7          	jalr	-1120(ra) # 800023f0 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    80001858:	00009797          	auipc	a5,0x9
    8000185c:	b907b783          	ld	a5,-1136(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001860:	0007b503          	ld	a0,0(a5)
    80001864:	00002097          	auipc	ra,0x2
    80001868:	050080e7          	jalr	80(ra) # 800038b4 <_ZN3SCB6signalEv>
                break;
    8000186c:	e09ff06f          	j	80001674 <interruptHandler+0x104>
                CCB::semInput->signal();
    80001870:	00009797          	auipc	a5,0x9
    80001874:	b907b783          	ld	a5,-1136(a5) # 8000a400 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001878:	0007b503          	ld	a0,0(a5)
    8000187c:	00002097          	auipc	ra,0x2
    80001880:	038080e7          	jalr	56(ra) # 800038b4 <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001884:	00009517          	auipc	a0,0x9
    80001888:	b2453503          	ld	a0,-1244(a0) # 8000a3a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000188c:	00001097          	auipc	ra,0x1
    80001890:	d14080e7          	jalr	-748(ra) # 800025a0 <_ZN8IOBuffer9peekFrontEv>
    80001894:	00051e63          	bnez	a0,800018b0 <interruptHandler+0x340>
                    CCB::inputBufferEmpty->wait();
    80001898:	00009797          	auipc	a5,0x9
    8000189c:	b587b783          	ld	a5,-1192(a5) # 8000a3f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800018a0:	0007b503          	ld	a0,0(a5)
    800018a4:	00002097          	auipc	ra,0x2
    800018a8:	f7c080e7          	jalr	-132(ra) # 80003820 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    800018ac:	fd9ff06f          	j	80001884 <interruptHandler+0x314>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    800018b0:	00009517          	auipc	a0,0x9
    800018b4:	af853503          	ld	a0,-1288(a0) # 8000a3a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800018b8:	00001097          	auipc	ra,0x1
    800018bc:	c50080e7          	jalr	-944(ra) # 80002508 <_ZN8IOBuffer8popFrontEv>
    800018c0:	00009797          	auipc	a5,0x9
    800018c4:	b187b783          	ld	a5,-1256(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018c8:	0007b783          	ld	a5,0(a5)
    800018cc:	0187b783          	ld	a5,24(a5)
    800018d0:	04a7b823          	sd	a0,80(a5)
                break;
    800018d4:	da1ff06f          	j	80001674 <interruptHandler+0x104>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    800018d8:	fc843783          	ld	a5,-56(s0)
    800018dc:	eff7f793          	andi	a5,a5,-257
    800018e0:	fcf43423          	sd	a5,-56(s0)
                break;
    800018e4:	d91ff06f          	j	80001674 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800018e8:	00009497          	auipc	s1,0x9
    800018ec:	ad04b483          	ld	s1,-1328(s1) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800018f0:	0004b783          	ld	a5,0(s1)
    800018f4:	00178793          	addi	a5,a5,1
    800018f8:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800018fc:	00000097          	auipc	ra,0x0
    80001900:	0f0080e7          	jalr	240(ra) # 800019ec <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001904:	00009797          	auipc	a5,0x9
    80001908:	ad47b783          	ld	a5,-1324(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000190c:	0007b783          	ld	a5,0(a5)
    80001910:	0407b703          	ld	a4,64(a5)
    80001914:	0004b783          	ld	a5,0(s1)
    80001918:	00e7f863          	bgeu	a5,a4,80001928 <interruptHandler+0x3b8>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000191c:	00200793          	li	a5,2
    80001920:	1447b073          	csrc	sip,a5
    }
    80001924:	d61ff06f          	j	80001684 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    80001928:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    8000192c:	00000097          	auipc	ra,0x0
    80001930:	21c080e7          	jalr	540(ra) # 80001b48 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    80001934:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001938:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    8000193c:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001940:	10079073          	csrw	sstatus,a5
    }
    80001944:	fd9ff06f          	j	8000191c <interruptHandler+0x3ac>
        size_t code = plic_claim();
    80001948:	00004097          	auipc	ra,0x4
    8000194c:	10c080e7          	jalr	268(ra) # 80005a54 <plic_claim>
        plic_complete(code);
    80001950:	00004097          	auipc	ra,0x4
    80001954:	13c080e7          	jalr	316(ra) # 80005a8c <plic_complete>
    80001958:	d2dff06f          	j	80001684 <interruptHandler+0x114>

000000008000195c <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    8000195c:	ff010113          	addi	sp,sp,-16
    80001960:	00813423          	sd	s0,8(sp)
    80001964:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001968:	00009797          	auipc	a5,0x9
    8000196c:	af87b783          	ld	a5,-1288(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001970:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001974:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001978:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000197c:	00078e63          	beqz	a5,80001998 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    80001980:	0307b683          	ld	a3,48(a5)
    80001984:	00e6fa63          	bgeu	a3,a4,80001998 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001988:	40d70733          	sub	a4,a4,a3
        prev = curr;
    8000198c:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001990:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001994:	fe9ff06f          	j	8000197c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    80001998:	00100693          	li	a3,1
    8000199c:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    800019a0:	02060663          	beqz	a2,800019cc <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    800019a4:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    800019a8:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    800019ac:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    800019b0:	00078863          	beqz	a5,800019c0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019b4:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019b8:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    800019bc:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    800019c0:	00813403          	ld	s0,8(sp)
    800019c4:	01010113          	addi	sp,sp,16
    800019c8:	00008067          	ret
        head = process;
    800019cc:	00009717          	auipc	a4,0x9
    800019d0:	a8a73a23          	sd	a0,-1388(a4) # 8000a460 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    800019d4:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800019d8:	fe0784e3          	beqz	a5,800019c0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019dc:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019e0:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    800019e4:	02b7b823          	sd	a1,48(a5)
    }
    800019e8:	fd9ff06f          	j	800019c0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

00000000800019ec <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    800019ec:	00009517          	auipc	a0,0x9
    800019f0:	a7453503          	ld	a0,-1420(a0) # 8000a460 <_ZN17SleepingProcesses4headE>
    800019f4:	08050063          	beqz	a0,80001a74 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800019f8:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800019fc:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    80001a00:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    80001a04:	06050263          	beqz	a0,80001a68 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    80001a08:	03053783          	ld	a5,48(a0)
    80001a0c:	04079e63          	bnez	a5,80001a68 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    80001a10:	fe010113          	addi	sp,sp,-32
    80001a14:	00113c23          	sd	ra,24(sp)
    80001a18:	00813823          	sd	s0,16(sp)
    80001a1c:	00913423          	sd	s1,8(sp)
    80001a20:	02010413          	addi	s0,sp,32
    80001a24:	00c0006f          	j	80001a30 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    80001a28:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    80001a2c:	02079063          	bnez	a5,80001a4c <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    80001a30:	00053483          	ld	s1,0(a0)
        nextInList = next;
    80001a34:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001a38:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001a3c:	00001097          	auipc	ra,0x1
    80001a40:	418080e7          	jalr	1048(ra) # 80002e54 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001a44:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001a48:	fe0490e3          	bnez	s1,80001a28 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001a4c:	00009797          	auipc	a5,0x9
    80001a50:	a0a7ba23          	sd	a0,-1516(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
}
    80001a54:	01813083          	ld	ra,24(sp)
    80001a58:	01013403          	ld	s0,16(sp)
    80001a5c:	00813483          	ld	s1,8(sp)
    80001a60:	02010113          	addi	sp,sp,32
    80001a64:	00008067          	ret
    head = curr;
    80001a68:	00009797          	auipc	a5,0x9
    80001a6c:	9ea7bc23          	sd	a0,-1544(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
    80001a70:	00008067          	ret
    80001a74:	00008067          	ret

0000000080001a78 <_ZN3PCB12createObjectEPv>:
#include "../h/slab.h"

PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

void PCB::createObject(void* addr) {
    80001a78:	ff010113          	addi	sp,sp,-16
    80001a7c:	00813423          	sd	s0,8(sp)
    80001a80:	01010413          	addi	s0,sp,16
}
    80001a84:	00813403          	ld	s0,8(sp)
    80001a88:	01010113          	addi	sp,sp,16
    80001a8c:	00008067          	ret

0000000080001a90 <_ZN3PCB10freeObjectEPv>:

void PCB::freeObject(void* addr) {
    80001a90:	fe010113          	addi	sp,sp,-32
    80001a94:	00113c23          	sd	ra,24(sp)
    80001a98:	00813823          	sd	s0,16(sp)
    80001a9c:	00913423          	sd	s1,8(sp)
    80001aa0:	02010413          	addi	s0,sp,32
    80001aa4:	00050493          	mv	s1,a0
    PCB* object = (PCB*)addr;
    delete[] object->stack;
    80001aa8:	00853503          	ld	a0,8(a0)
    80001aac:	00050663          	beqz	a0,80001ab8 <_ZN3PCB10freeObjectEPv+0x28>
    80001ab0:	00001097          	auipc	ra,0x1
    80001ab4:	7d0080e7          	jalr	2000(ra) # 80003280 <_ZdaPv>
    delete[] object->sysStack;
    80001ab8:	0104b503          	ld	a0,16(s1)
    80001abc:	00050663          	beqz	a0,80001ac8 <_ZN3PCB10freeObjectEPv+0x38>
    80001ac0:	00001097          	auipc	ra,0x1
    80001ac4:	7c0080e7          	jalr	1984(ra) # 80003280 <_ZdaPv>
}
    80001ac8:	01813083          	ld	ra,24(sp)
    80001acc:	01013403          	ld	s0,16(sp)
    80001ad0:	00813483          	ld	s1,8(sp)
    80001ad4:	02010113          	addi	sp,sp,32
    80001ad8:	00008067          	ret

0000000080001adc <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001adc:	ff010113          	addi	sp,sp,-16
    80001ae0:	00113423          	sd	ra,8(sp)
    80001ae4:	00813023          	sd	s0,0(sp)
    80001ae8:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	a1c080e7          	jalr	-1508(ra) # 80001508 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001af4:	00009797          	auipc	a5,0x9
    80001af8:	9747b783          	ld	a5,-1676(a5) # 8000a468 <_ZN3PCB7runningE>
    80001afc:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001b00:	00070513          	mv	a0,a4
    running->main();
    80001b04:	0207b783          	ld	a5,32(a5)
    80001b08:	000780e7          	jalr	a5
    thread_exit();
    80001b0c:	fffff097          	auipc	ra,0xfffff
    80001b10:	794080e7          	jalr	1940(ra) # 800012a0 <_Z11thread_exitv>
}
    80001b14:	00813083          	ld	ra,8(sp)
    80001b18:	00013403          	ld	s0,0(sp)
    80001b1c:	01010113          	addi	sp,sp,16
    80001b20:	00008067          	ret

0000000080001b24 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00813423          	sd	s0,8(sp)
    80001b2c:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001b30:	01300793          	li	a5,19
    80001b34:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001b38:	00000073          	ecall
}
    80001b3c:	00813403          	ld	s0,8(sp)
    80001b40:	01010113          	addi	sp,sp,16
    80001b44:	00008067          	ret

0000000080001b48 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001b48:	fe010113          	addi	sp,sp,-32
    80001b4c:	00113c23          	sd	ra,24(sp)
    80001b50:	00813823          	sd	s0,16(sp)
    80001b54:	00913423          	sd	s1,8(sp)
    80001b58:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001b5c:	00009497          	auipc	s1,0x9
    80001b60:	90c4b483          	ld	s1,-1780(s1) # 8000a468 <_ZN3PCB7runningE>
        return finished;
    80001b64:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001b68:	00079663          	bnez	a5,80001b74 <_ZN3PCB8dispatchEv+0x2c>
    80001b6c:	0294c783          	lbu	a5,41(s1)
    80001b70:	04078263          	beqz	a5,80001bb4 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	338080e7          	jalr	824(ra) # 80002eac <_ZN9Scheduler3getEv>
    80001b7c:	00009797          	auipc	a5,0x9
    80001b80:	8ea7b623          	sd	a0,-1812(a5) # 8000a468 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001b84:	04854783          	lbu	a5,72(a0)
    80001b88:	02078e63          	beqz	a5,80001bc4 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b8c:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001b90:	01853583          	ld	a1,24(a0)
    80001b94:	0184b503          	ld	a0,24(s1)
    80001b98:	fffff097          	auipc	ra,0xfffff
    80001b9c:	590080e7          	jalr	1424(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001ba0:	01813083          	ld	ra,24(sp)
    80001ba4:	01013403          	ld	s0,16(sp)
    80001ba8:	00813483          	ld	s1,8(sp)
    80001bac:	02010113          	addi	sp,sp,32
    80001bb0:	00008067          	ret
        Scheduler::put(old);
    80001bb4:	00048513          	mv	a0,s1
    80001bb8:	00001097          	auipc	ra,0x1
    80001bbc:	29c080e7          	jalr	668(ra) # 80002e54 <_ZN9Scheduler3putEP3PCB>
    80001bc0:	fb5ff06f          	j	80001b74 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001bc4:	01853583          	ld	a1,24(a0)
    80001bc8:	0184b503          	ld	a0,24(s1)
    80001bcc:	fffff097          	auipc	ra,0xfffff
    80001bd0:	570080e7          	jalr	1392(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001bd4:	fcdff06f          	j	80001ba0 <_ZN3PCB8dispatchEv+0x58>

0000000080001bd8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001bd8:	fe010113          	addi	sp,sp,-32
    80001bdc:	00113c23          	sd	ra,24(sp)
    80001be0:	00813823          	sd	s0,16(sp)
    80001be4:	00913423          	sd	s1,8(sp)
    80001be8:	02010413          	addi	s0,sp,32
    80001bec:	00050493          	mv	s1,a0
    delete[] stack;
    80001bf0:	00853503          	ld	a0,8(a0)
    80001bf4:	00050663          	beqz	a0,80001c00 <_ZN3PCBD1Ev+0x28>
    80001bf8:	00001097          	auipc	ra,0x1
    80001bfc:	688080e7          	jalr	1672(ra) # 80003280 <_ZdaPv>
    delete[] sysStack;
    80001c00:	0104b503          	ld	a0,16(s1)
    80001c04:	00050663          	beqz	a0,80001c10 <_ZN3PCBD1Ev+0x38>
    80001c08:	00001097          	auipc	ra,0x1
    80001c0c:	678080e7          	jalr	1656(ra) # 80003280 <_ZdaPv>
}
    80001c10:	01813083          	ld	ra,24(sp)
    80001c14:	01013403          	ld	s0,16(sp)
    80001c18:	00813483          	ld	s1,8(sp)
    80001c1c:	02010113          	addi	sp,sp,32
    80001c20:	00008067          	ret

0000000080001c24 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001c24:	ff010113          	addi	sp,sp,-16
    80001c28:	00113423          	sd	ra,8(sp)
    80001c2c:	00813023          	sd	s0,0(sp)
    80001c30:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001c34:	00003097          	auipc	ra,0x3
    80001c38:	9a0080e7          	jalr	-1632(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001c3c:	00813083          	ld	ra,8(sp)
    80001c40:	00013403          	ld	s0,0(sp)
    80001c44:	01010113          	addi	sp,sp,16
    80001c48:	00008067          	ret

0000000080001c4c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c4c:	ff010113          	addi	sp,sp,-16
    80001c50:	00113423          	sd	ra,8(sp)
    80001c54:	00813023          	sd	s0,0(sp)
    80001c58:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c5c:	00003097          	auipc	ra,0x3
    80001c60:	b0c080e7          	jalr	-1268(ra) # 80004768 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c64:	00813083          	ld	ra,8(sp)
    80001c68:	00013403          	ld	s0,0(sp)
    80001c6c:	01010113          	addi	sp,sp,16
    80001c70:	00008067          	ret

0000000080001c74 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001c74:	ff010113          	addi	sp,sp,-16
    80001c78:	00813423          	sd	s0,8(sp)
    80001c7c:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001c80:	00008797          	auipc	a5,0x8
    80001c84:	7e87b783          	ld	a5,2024(a5) # 8000a468 <_ZN3PCB7runningE>
    80001c88:	0187b503          	ld	a0,24(a5)
    80001c8c:	00813403          	ld	s0,8(sp)
    80001c90:	01010113          	addi	sp,sp,16
    80001c94:	00008067          	ret

0000000080001c98 <_ZN3PCB10initObjectEPFvvEmPv>:

void PCB::initObject(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001c98:	fe010113          	addi	sp,sp,-32
    80001c9c:	00113c23          	sd	ra,24(sp)
    80001ca0:	00813823          	sd	s0,16(sp)
    80001ca4:	00913423          	sd	s1,8(sp)
    80001ca8:	02010413          	addi	s0,sp,32
    80001cac:	00050493          	mv	s1,a0
    firstCall = true;
    80001cb0:	00100793          	li	a5,1
    80001cb4:	04f50423          	sb	a5,72(a0)
    registers = nullptr;
    80001cb8:	00053c23          	sd	zero,24(a0)
    nextInList = nullptr;
    80001cbc:	00053023          	sd	zero,0(a0)
    timeSleeping = 0;
    80001cc0:	02053823          	sd	zero,48(a0)
    finished = blocked = semDeleted = false;
    80001cc4:	02050523          	sb	zero,42(a0)
    80001cc8:	020504a3          	sb	zero,41(a0)
    80001ccc:	02050423          	sb	zero,40(a0)
    main = main_;
    80001cd0:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001cd4:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001cd8:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001cdc:	10800513          	li	a0,264
    80001ce0:	00003097          	auipc	ra,0x3
    80001ce4:	8f4080e7          	jalr	-1804(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
    80001ce8:	00a4bc23          	sd	a0,24(s1)
    if(!registers) return; // greska
    80001cec:	04050263          	beqz	a0,80001d30 <_ZN3PCB10initObjectEPFvvEmPv+0x98>
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001cf0:	00008537          	lui	a0,0x8
    80001cf4:	00003097          	auipc	ra,0x3
    80001cf8:	8e0080e7          	jalr	-1824(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
    80001cfc:	00a4b823          	sd	a0,16(s1)
    if(!sysStack) return; // greska
    80001d00:	02050863          	beqz	a0,80001d30 <_ZN3PCB10initObjectEPFvvEmPv+0x98>
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001d04:	000087b7          	lui	a5,0x8
    80001d08:	00f50533          	add	a0,a0,a5
    80001d0c:	0184b783          	ld	a5,24(s1)
    80001d10:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001d14:	0184b783          	ld	a5,24(s1)
    80001d18:	00000717          	auipc	a4,0x0
    80001d1c:	dc470713          	addi	a4,a4,-572 # 80001adc <_ZN3PCB15proccessWrapperEv>
    80001d20:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001d24:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001d28:	0204b783          	ld	a5,32(s1)
    80001d2c:	00078c63          	beqz	a5,80001d44 <_ZN3PCB10initObjectEPFvvEmPv+0xac>
}
    80001d30:	01813083          	ld	ra,24(sp)
    80001d34:	01013403          	ld	s0,16(sp)
    80001d38:	00813483          	ld	s1,8(sp)
    80001d3c:	02010113          	addi	sp,sp,32
    80001d40:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001d44:	04048423          	sb	zero,72(s1)
    80001d48:	fe9ff06f          	j	80001d30 <_ZN3PCB10initObjectEPFvvEmPv+0x98>

0000000080001d4c <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001d4c:	ff010113          	addi	sp,sp,-16
    80001d50:	00113423          	sd	ra,8(sp)
    80001d54:	00813023          	sd	s0,0(sp)
    80001d58:	01010413          	addi	s0,sp,16
    initObject(main_, timeSlice_, mainArguments_);
    80001d5c:	00000097          	auipc	ra,0x0
    80001d60:	f3c080e7          	jalr	-196(ra) # 80001c98 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001d64:	00813083          	ld	ra,8(sp)
    80001d68:	00013403          	ld	s0,0(sp)
    80001d6c:	01010113          	addi	sp,sp,16
    80001d70:	00008067          	ret

0000000080001d74 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001d74:	fd010113          	addi	sp,sp,-48
    80001d78:	02113423          	sd	ra,40(sp)
    80001d7c:	02813023          	sd	s0,32(sp)
    80001d80:	00913c23          	sd	s1,24(sp)
    80001d84:	01213823          	sd	s2,16(sp)
    80001d88:	01313423          	sd	s3,8(sp)
    80001d8c:	03010413          	addi	s0,sp,48
    80001d90:	00050913          	mv	s2,a0
    80001d94:	00058993          	mv	s3,a1
    PCB* object = new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001d98:	05000513          	li	a0,80
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	e88080e7          	jalr	-376(ra) # 80001c24 <_ZN3PCBnwEm>
    80001da4:	00050493          	mv	s1,a0
    80001da8:	00050c63          	beqz	a0,80001dc0 <_ZN3PCB14createProccessEPFvvEPv+0x4c>
    80001dac:	00098693          	mv	a3,s3
    80001db0:	00200613          	li	a2,2
    80001db4:	00090593          	mv	a1,s2
    80001db8:	00000097          	auipc	ra,0x0
    80001dbc:	f94080e7          	jalr	-108(ra) # 80001d4c <_ZN3PCBC1EPFvvEmPv>
    if(!object->registers || !object->sysStack) return nullptr;
    80001dc0:	0184b783          	ld	a5,24(s1)
    80001dc4:	02078663          	beqz	a5,80001df0 <_ZN3PCB14createProccessEPFvvEPv+0x7c>
    80001dc8:	0104b783          	ld	a5,16(s1)
    80001dcc:	02078663          	beqz	a5,80001df8 <_ZN3PCB14createProccessEPFvvEPv+0x84>
}
    80001dd0:	00048513          	mv	a0,s1
    80001dd4:	02813083          	ld	ra,40(sp)
    80001dd8:	02013403          	ld	s0,32(sp)
    80001ddc:	01813483          	ld	s1,24(sp)
    80001de0:	01013903          	ld	s2,16(sp)
    80001de4:	00813983          	ld	s3,8(sp)
    80001de8:	03010113          	addi	sp,sp,48
    80001dec:	00008067          	ret
    if(!object->registers || !object->sysStack) return nullptr;
    80001df0:	00000493          	li	s1,0
    80001df4:	fddff06f          	j	80001dd0 <_ZN3PCB14createProccessEPFvvEPv+0x5c>
    80001df8:	00000493          	li	s1,0
    80001dfc:	fd5ff06f          	j	80001dd0 <_ZN3PCB14createProccessEPFvvEPv+0x5c>
    80001e00:	00050913          	mv	s2,a0
    PCB* object = new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001e04:	00048513          	mv	a0,s1
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	e44080e7          	jalr	-444(ra) # 80001c4c <_ZN3PCBdlEPv>
    80001e10:	00090513          	mv	a0,s2
    80001e14:	0000a097          	auipc	ra,0xa
    80001e18:	864080e7          	jalr	-1948(ra) # 8000b678 <_Unwind_Resume>

0000000080001e1c <_ZN3PCB12initPCBCacheEv>:

void PCB::initPCBCache() {
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00113423          	sd	ra,8(sp)
    80001e24:	00813023          	sd	s0,0(sp)
    80001e28:	01010413          	addi	s0,sp,16
    pcbCache = (kmem_cache_t*)kmem_cache_create("PCB", sizeof(PCB), &createObject, &freeObject);
    80001e2c:	00000697          	auipc	a3,0x0
    80001e30:	c6468693          	addi	a3,a3,-924 # 80001a90 <_ZN3PCB10freeObjectEPv>
    80001e34:	00000617          	auipc	a2,0x0
    80001e38:	c4460613          	addi	a2,a2,-956 # 80001a78 <_ZN3PCB12createObjectEPv>
    80001e3c:	05000593          	li	a1,80
    80001e40:	00006517          	auipc	a0,0x6
    80001e44:	2f050513          	addi	a0,a0,752 # 80008130 <CONSOLE_STATUS+0x120>
    80001e48:	00003097          	auipc	ra,0x3
    80001e4c:	b24080e7          	jalr	-1244(ra) # 8000496c <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001e50:	00008797          	auipc	a5,0x8
    80001e54:	62a7b023          	sd	a0,1568(a5) # 8000a470 <_ZN3PCB8pcbCacheE>
}
    80001e58:	00813083          	ld	ra,8(sp)
    80001e5c:	00013403          	ld	s0,0(sp)
    80001e60:	01010113          	addi	sp,sp,16
    80001e64:	00008067          	ret

0000000080001e68 <_ZN3PCB16createSysProcessEPFvvEPv>:
PCB *PCB::createSysProcess(PCB::processMain main, void* arguments) {
    80001e68:	fd010113          	addi	sp,sp,-48
    80001e6c:	02113423          	sd	ra,40(sp)
    80001e70:	02813023          	sd	s0,32(sp)
    80001e74:	00913c23          	sd	s1,24(sp)
    80001e78:	01213823          	sd	s2,16(sp)
    80001e7c:	01313423          	sd	s3,8(sp)
    80001e80:	03010413          	addi	s0,sp,48
    80001e84:	00050913          	mv	s2,a0
    80001e88:	00058993          	mv	s3,a1
    if(!pcbCache) initPCBCache();
    80001e8c:	00008797          	auipc	a5,0x8
    80001e90:	5e47b783          	ld	a5,1508(a5) # 8000a470 <_ZN3PCB8pcbCacheE>
    80001e94:	04078e63          	beqz	a5,80001ef0 <_ZN3PCB16createSysProcessEPFvvEPv+0x88>
    PCB* object = (PCB*) kmem_cache_alloc(pcbCache);
    80001e98:	00008517          	auipc	a0,0x8
    80001e9c:	5d853503          	ld	a0,1496(a0) # 8000a470 <_ZN3PCB8pcbCacheE>
    80001ea0:	00003097          	auipc	ra,0x3
    80001ea4:	b1c080e7          	jalr	-1252(ra) # 800049bc <_Z16kmem_cache_allocP12kmem_cache_s>
    80001ea8:	00050493          	mv	s1,a0
    object->initObject(main, DEFAULT_TIME_SLICE, arguments);
    80001eac:	00098693          	mv	a3,s3
    80001eb0:	00200613          	li	a2,2
    80001eb4:	00090593          	mv	a1,s2
    80001eb8:	00000097          	auipc	ra,0x0
    80001ebc:	de0080e7          	jalr	-544(ra) # 80001c98 <_ZN3PCB10initObjectEPFvvEmPv>
    if(!object->registers || !object->sysStack) return nullptr;
    80001ec0:	0184b783          	ld	a5,24(s1)
    80001ec4:	02078c63          	beqz	a5,80001efc <_ZN3PCB16createSysProcessEPFvvEPv+0x94>
    80001ec8:	0104b783          	ld	a5,16(s1)
    80001ecc:	02078c63          	beqz	a5,80001f04 <_ZN3PCB16createSysProcessEPFvvEPv+0x9c>
}
    80001ed0:	00048513          	mv	a0,s1
    80001ed4:	02813083          	ld	ra,40(sp)
    80001ed8:	02013403          	ld	s0,32(sp)
    80001edc:	01813483          	ld	s1,24(sp)
    80001ee0:	01013903          	ld	s2,16(sp)
    80001ee4:	00813983          	ld	s3,8(sp)
    80001ee8:	03010113          	addi	sp,sp,48
    80001eec:	00008067          	ret
    if(!pcbCache) initPCBCache();
    80001ef0:	00000097          	auipc	ra,0x0
    80001ef4:	f2c080e7          	jalr	-212(ra) # 80001e1c <_ZN3PCB12initPCBCacheEv>
    80001ef8:	fa1ff06f          	j	80001e98 <_ZN3PCB16createSysProcessEPFvvEPv+0x30>
    if(!object->registers || !object->sysStack) return nullptr;
    80001efc:	00000493          	li	s1,0
    80001f00:	fd1ff06f          	j	80001ed0 <_ZN3PCB16createSysProcessEPFvvEPv+0x68>
    80001f04:	00000493          	li	s1,0
    80001f08:	fc9ff06f          	j	80001ed0 <_ZN3PCB16createSysProcessEPFvvEPv+0x68>

0000000080001f0c <_ZN14BuddyAllocator12getFreeBlockEm>:
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    80001f0c:	ff010113          	addi	sp,sp,-16
    80001f10:	00813423          	sd	s0,8(sp)
    80001f14:	01010413          	addi	s0,sp,16
    size--;
    80001f18:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f1c:	00b00793          	li	a5,11
    80001f20:	02a7e463          	bltu	a5,a0,80001f48 <_ZN14BuddyAllocator12getFreeBlockEm+0x3c>
    80001f24:	00351513          	slli	a0,a0,0x3
    80001f28:	00008797          	auipc	a5,0x8
    80001f2c:	55878793          	addi	a5,a5,1368 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001f30:	00a78533          	add	a0,a5,a0
    80001f34:	00053503          	ld	a0,0(a0)
    80001f38:	00050c63          	beqz	a0,80001f50 <_ZN14BuddyAllocator12getFreeBlockEm+0x44>

    BuddyEntry* block = buddy[size];
    return block;
}
    80001f3c:	00813403          	ld	s0,8(sp)
    80001f40:	01010113          	addi	sp,sp,16
    80001f44:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f48:	00000513          	li	a0,0
    80001f4c:	ff1ff06f          	j	80001f3c <_ZN14BuddyAllocator12getFreeBlockEm+0x30>
    80001f50:	00000513          	li	a0,0
    80001f54:	fe9ff06f          	j	80001f3c <_ZN14BuddyAllocator12getFreeBlockEm+0x30>

0000000080001f58 <_ZN14BuddyAllocator12popFreeBlockEm>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    80001f58:	ff010113          	addi	sp,sp,-16
    80001f5c:	00813423          	sd	s0,8(sp)
    80001f60:	01010413          	addi	s0,sp,16
    size--;
    80001f64:	fff50793          	addi	a5,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f68:	00b00713          	li	a4,11
    80001f6c:	04f76063          	bltu	a4,a5,80001fac <_ZN14BuddyAllocator12popFreeBlockEm+0x54>
    80001f70:	00379693          	slli	a3,a5,0x3
    80001f74:	00008717          	auipc	a4,0x8
    80001f78:	50c70713          	addi	a4,a4,1292 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001f7c:	00d70733          	add	a4,a4,a3
    80001f80:	00073503          	ld	a0,0(a4)
    80001f84:	00050e63          	beqz	a0,80001fa0 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001f88:	00053683          	ld	a3,0(a0)
    80001f8c:	00379793          	slli	a5,a5,0x3
    80001f90:	00008717          	auipc	a4,0x8
    80001f94:	4f070713          	addi	a4,a4,1264 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001f98:	00f707b3          	add	a5,a4,a5
    80001f9c:	00d7b023          	sd	a3,0(a5)
    return block;
}
    80001fa0:	00813403          	ld	s0,8(sp)
    80001fa4:	01010113          	addi	sp,sp,16
    80001fa8:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001fac:	00000513          	li	a0,0
    80001fb0:	ff1ff06f          	j	80001fa0 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

0000000080001fb4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    80001fb4:	ff010113          	addi	sp,sp,-16
    80001fb8:	00813423          	sd	s0,8(sp)
    80001fbc:	01010413          	addi	s0,sp,16
    size--;
    80001fc0:	fff50693          	addi	a3,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80001fc4:	00b00793          	li	a5,11
    80001fc8:	06d7e663          	bltu	a5,a3,80002034 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x80>

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001fcc:	00369713          	slli	a4,a3,0x3
    80001fd0:	00008797          	auipc	a5,0x8
    80001fd4:	4b078793          	addi	a5,a5,1200 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001fd8:	00e787b3          	add	a5,a5,a4
    80001fdc:	0007b603          	ld	a2,0(a5)
    80001fe0:	00060513          	mv	a0,a2
    BuddyEntry *prev = nullptr;
    80001fe4:	00000713          	li	a4,0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001fe8:	02050263          	beqz	a0,8000200c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
        if(curr->addr == addr) {
    80001fec:	00853783          	ld	a5,8(a0)
    80001ff0:	00b78863          	beq	a5,a1,80002000 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x4c>
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    80001ff4:	00050713          	mv	a4,a0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001ff8:	00053503          	ld	a0,0(a0)
    80001ffc:	fedff06f          	j	80001fe8 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x34>
            if(prev) {
    80002000:	00070c63          	beqz	a4,80002018 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x64>
                prev->next = curr->next;
    80002004:	00053783          	ld	a5,0(a0)
    80002008:	00f73023          	sd	a5,0(a4)
    }

    return nullptr;
}
    8000200c:	00813403          	ld	s0,8(sp)
    80002010:	01010113          	addi	sp,sp,16
    80002014:	00008067          	ret
                buddy[size] = buddy[size]->next;
    80002018:	00063703          	ld	a4,0(a2)
    8000201c:	00369693          	slli	a3,a3,0x3
    80002020:	00008797          	auipc	a5,0x8
    80002024:	46078793          	addi	a5,a5,1120 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80002028:	00d786b3          	add	a3,a5,a3
    8000202c:	00e6b023          	sd	a4,0(a3)
            return curr;
    80002030:	fddff06f          	j	8000200c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
    if(size >= maxPowerSize) return nullptr;
    80002034:	00000513          	li	a0,0
    80002038:	fd5ff06f          	j	8000200c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>

000000008000203c <_ZN14BuddyAllocator10printBuddyEv>:

void BuddyAllocator::printBuddy() {
    8000203c:	fe010113          	addi	sp,sp,-32
    80002040:	00113c23          	sd	ra,24(sp)
    80002044:	00813823          	sd	s0,16(sp)
    80002048:	00913423          	sd	s1,8(sp)
    8000204c:	01213023          	sd	s2,0(sp)
    80002050:	02010413          	addi	s0,sp,32
    for(size_t i = 0; i < maxPowerSize; i++) {
    80002054:	00000913          	li	s2,0
    80002058:	0180006f          	j	80002070 <_ZN14BuddyAllocator10printBuddyEv+0x34>
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    8000205c:	00006517          	auipc	a0,0x6
    80002060:	20450513          	addi	a0,a0,516 # 80008260 <CONSOLE_STATUS+0x250>
    80002064:	00000097          	auipc	ra,0x0
    80002068:	7ec080e7          	jalr	2028(ra) # 80002850 <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    8000206c:	00190913          	addi	s2,s2,1
    80002070:	00b00793          	li	a5,11
    80002074:	0727e663          	bltu	a5,s2,800020e0 <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80002078:	00000613          	li	a2,0
    8000207c:	00a00593          	li	a1,10
    80002080:	0019051b          	addiw	a0,s2,1
    80002084:	00001097          	auipc	ra,0x1
    80002088:	964080e7          	jalr	-1692(ra) # 800029e8 <_Z8printIntiii>
        printString(": ");
    8000208c:	00006517          	auipc	a0,0x6
    80002090:	0ac50513          	addi	a0,a0,172 # 80008138 <CONSOLE_STATUS+0x128>
    80002094:	00000097          	auipc	ra,0x0
    80002098:	7bc080e7          	jalr	1980(ra) # 80002850 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    8000209c:	00391713          	slli	a4,s2,0x3
    800020a0:	00008797          	auipc	a5,0x8
    800020a4:	3e078793          	addi	a5,a5,992 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    800020a8:	00e787b3          	add	a5,a5,a4
    800020ac:	0007b483          	ld	s1,0(a5)
    800020b0:	fa0486e3          	beqz	s1,8000205c <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    800020b4:	00000613          	li	a2,0
    800020b8:	00a00593          	li	a1,10
    800020bc:	0084a503          	lw	a0,8(s1)
    800020c0:	00001097          	auipc	ra,0x1
    800020c4:	928080e7          	jalr	-1752(ra) # 800029e8 <_Z8printIntiii>
            printString(" ");
    800020c8:	00006517          	auipc	a0,0x6
    800020cc:	07850513          	addi	a0,a0,120 # 80008140 <CONSOLE_STATUS+0x130>
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	780080e7          	jalr	1920(ra) # 80002850 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    800020d8:	0004b483          	ld	s1,0(s1)
    800020dc:	fd5ff06f          	j	800020b0 <_ZN14BuddyAllocator10printBuddyEv+0x74>
    }
}
    800020e0:	01813083          	ld	ra,24(sp)
    800020e4:	01013403          	ld	s0,16(sp)
    800020e8:	00813483          	ld	s1,8(sp)
    800020ec:	00013903          	ld	s2,0(sp)
    800020f0:	02010113          	addi	sp,sp,32
    800020f4:	00008067          	ret

00000000800020f8 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
    800020f8:	ff010113          	addi	sp,sp,-16
    800020fc:	00813423          	sd	s0,8(sp)
    80002100:	01010413          	addi	s0,sp,16
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
    80002104:	00053023          	sd	zero,0(a0)
        entry->addr = addr;
    80002108:	00a53423          	sd	a0,8(a0)
        return entry;
}
    8000210c:	00813403          	ld	s0,8(sp)
    80002110:	01010113          	addi	sp,sp,16
    80002114:	00008067          	ret

0000000080002118 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>:

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    80002118:	ff010113          	addi	sp,sp,-16
    8000211c:	00813423          	sd	s0,8(sp)
    80002120:	01010413          	addi	s0,sp,16
    size--;
    80002124:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize) return -1;
    80002128:	00b00793          	li	a5,11
    8000212c:	08a7ec63          	bltu	a5,a0,800021c4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xac>

    if(buddy[size] == nullptr) {
    80002130:	00351713          	slli	a4,a0,0x3
    80002134:	00008797          	auipc	a5,0x8
    80002138:	34c78793          	addi	a5,a5,844 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    8000213c:	00e787b3          	add	a5,a5,a4
    80002140:	0007b783          	ld	a5,0(a5)
    80002144:	00078663          	beqz	a5,80002150 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x38>
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    80002148:	00000613          	li	a2,0
    8000214c:	0200006f          	j	8000216c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x54>
        buddy[size] = entry;
    80002150:	00008797          	auipc	a5,0x8
    80002154:	33078793          	addi	a5,a5,816 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80002158:	00e78533          	add	a0,a5,a4
    8000215c:	00b53023          	sd	a1,0(a0)
        return 0;
    80002160:	00000513          	li	a0,0
    80002164:	06c0006f          	j	800021d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80002168:	00070793          	mv	a5,a4
    8000216c:	06078063          	beqz	a5,800021cc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb4>
        if(curr->addr > entry->addr) {
    80002170:	0087b683          	ld	a3,8(a5)
    80002174:	0085b703          	ld	a4,8(a1)
    80002178:	00d76e63          	bltu	a4,a3,80002194 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x7c>
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
    8000217c:	0007b703          	ld	a4,0(a5)
            curr->next = entry;
            break;
        }
        prev = curr;
    80002180:	00078613          	mv	a2,a5
        if(curr->next == nullptr) {
    80002184:	fe0712e3          	bnez	a4,80002168 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x50>
            curr->next = entry;
    80002188:	00b7b023          	sd	a1,0(a5)
    }

    return 0;
    8000218c:	00000513          	li	a0,0
            break;
    80002190:	0400006f          	j	800021d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
            entry->next = curr;
    80002194:	00f5b023          	sd	a5,0(a1)
            if(prev) {
    80002198:	00060863          	beqz	a2,800021a8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x90>
                prev->next = curr;
    8000219c:	00f63023          	sd	a5,0(a2)
    return 0;
    800021a0:	00000513          	li	a0,0
    800021a4:	02c0006f          	j	800021d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
                buddy[size] = entry;
    800021a8:	00351513          	slli	a0,a0,0x3
    800021ac:	00008797          	auipc	a5,0x8
    800021b0:	2d478793          	addi	a5,a5,724 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    800021b4:	00a78533          	add	a0,a5,a0
    800021b8:	00b53023          	sd	a1,0(a0)
    return 0;
    800021bc:	00000513          	li	a0,0
    800021c0:	0100006f          	j	800021d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    if(size >= maxPowerSize) return -1;
    800021c4:	fff00513          	li	a0,-1
    800021c8:	0080006f          	j	800021d0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    return 0;
    800021cc:	00000513          	li	a0,0
}
    800021d0:	00813403          	ld	s0,8(sp)
    800021d4:	01010113          	addi	sp,sp,16
    800021d8:	00008067          	ret

00000000800021dc <_ZN14BuddyAllocator9initBuddyEv>:
    if(startAddr != nullptr) return 1;
    800021dc:	00008797          	auipc	a5,0x8
    800021e0:	3047b783          	ld	a5,772(a5) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    800021e4:	00078663          	beqz	a5,800021f0 <_ZN14BuddyAllocator9initBuddyEv+0x14>
    800021e8:	00100513          	li	a0,1
}
    800021ec:	00008067          	ret
int BuddyAllocator::initBuddy() {
    800021f0:	ff010113          	addi	sp,sp,-16
    800021f4:	00113423          	sd	ra,8(sp)
    800021f8:	00813023          	sd	s0,0(sp)
    800021fc:	01010413          	addi	s0,sp,16
    startAddr = (void*)HEAP_START_ADDR;
    80002200:	00008797          	auipc	a5,0x8
    80002204:	1987b783          	ld	a5,408(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002208:	0007b503          	ld	a0,0(a5)
    8000220c:	00008797          	auipc	a5,0x8
    80002210:	2ca7ba23          	sd	a0,724(a5) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    80002214:	00000097          	auipc	ra,0x0
    80002218:	ee4080e7          	jalr	-284(ra) # 800020f8 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    8000221c:	00050593          	mv	a1,a0
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);
    80002220:	00c00513          	li	a0,12
    80002224:	00000097          	auipc	ra,0x0
    80002228:	ef4080e7          	jalr	-268(ra) # 80002118 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
}
    8000222c:	00813083          	ld	ra,8(sp)
    80002230:	00013403          	ld	s0,0(sp)
    80002234:	01010113          	addi	sp,sp,16
    80002238:	00008067          	ret

000000008000223c <_ZN14BuddyAllocator10buddyAllocEm>:
void *BuddyAllocator::buddyAlloc(size_t size) {
    8000223c:	fd010113          	addi	sp,sp,-48
    80002240:	02113423          	sd	ra,40(sp)
    80002244:	02813023          	sd	s0,32(sp)
    80002248:	00913c23          	sd	s1,24(sp)
    8000224c:	01213823          	sd	s2,16(sp)
    80002250:	01313423          	sd	s3,8(sp)
    80002254:	01413023          	sd	s4,0(sp)
    80002258:	03010413          	addi	s0,sp,48
    size--;
    8000225c:	fff50a13          	addi	s4,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80002260:	00b00793          	li	a5,11
    80002264:	0747ea63          	bltu	a5,s4,800022d8 <_ZN14BuddyAllocator10buddyAllocEm+0x9c>
    for(size_t curr = size; curr < maxPowerSize; curr++) {
    80002268:	000a0493          	mv	s1,s4
    8000226c:	0080006f          	j	80002274 <_ZN14BuddyAllocator10buddyAllocEm+0x38>
    80002270:	00098493          	mv	s1,s3
    80002274:	00b00793          	li	a5,11
    80002278:	0697e463          	bltu	a5,s1,800022e0 <_ZN14BuddyAllocator10buddyAllocEm+0xa4>
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
    8000227c:	00148993          	addi	s3,s1,1
    80002280:	00098513          	mv	a0,s3
    80002284:	00000097          	auipc	ra,0x0
    80002288:	cd4080e7          	jalr	-812(ra) # 80001f58 <_ZN14BuddyAllocator12popFreeBlockEm>
    8000228c:	00050913          	mv	s2,a0
        if(block != nullptr) { // postoji slobodan blok ove velicine
    80002290:	fe0500e3          	beqz	a0,80002270 <_ZN14BuddyAllocator10buddyAllocEm+0x34>
            while(curr > size) {
    80002294:	029a7e63          	bgeu	s4,s1,800022d0 <_ZN14BuddyAllocator10buddyAllocEm+0x94>

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
    static size_t sizeInBytes(size_t size) {
        size--;
    80002298:	fff48993          	addi	s3,s1,-1
        return (1<<size)*blockSize;
    8000229c:	00100793          	li	a5,1
    800022a0:	013797bb          	sllw	a5,a5,s3
    800022a4:	00c79793          	slli	a5,a5,0xc
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
    800022a8:	00893503          	ld	a0,8(s2)
    800022ac:	00f50533          	add	a0,a0,a5
    800022b0:	00000097          	auipc	ra,0x0
    800022b4:	e48080e7          	jalr	-440(ra) # 800020f8 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800022b8:	00050593          	mv	a1,a0
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment
    800022bc:	00048513          	mv	a0,s1
    800022c0:	00000097          	auipc	ra,0x0
    800022c4:	e58080e7          	jalr	-424(ra) # 80002118 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
                curr--;
    800022c8:	00098493          	mv	s1,s3
            while(curr > size) {
    800022cc:	fc9ff06f          	j	80002294 <_ZN14BuddyAllocator10buddyAllocEm+0x58>
            void* res = block->addr;
    800022d0:	00893503          	ld	a0,8(s2)
            return res;
    800022d4:	0100006f          	j	800022e4 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    if(size >= maxPowerSize) return nullptr;
    800022d8:	00000513          	li	a0,0
    800022dc:	0080006f          	j	800022e4 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    return nullptr;
    800022e0:	00000513          	li	a0,0
}
    800022e4:	02813083          	ld	ra,40(sp)
    800022e8:	02013403          	ld	s0,32(sp)
    800022ec:	01813483          	ld	s1,24(sp)
    800022f0:	01013903          	ld	s2,16(sp)
    800022f4:	00813983          	ld	s3,8(sp)
    800022f8:	00013a03          	ld	s4,0(sp)
    800022fc:	03010113          	addi	sp,sp,48
    80002300:	00008067          	ret

0000000080002304 <_ZN14BuddyAllocator9buddyFreeEPvm>:
    size--;
    80002304:	fff58593          	addi	a1,a1,-1
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002308:	00b00793          	li	a5,11
    8000230c:	0ab7ec63          	bltu	a5,a1,800023c4 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc0>
int BuddyAllocator::buddyFree(void *addr, size_t size) {
    80002310:	fd010113          	addi	sp,sp,-48
    80002314:	02113423          	sd	ra,40(sp)
    80002318:	02813023          	sd	s0,32(sp)
    8000231c:	00913c23          	sd	s1,24(sp)
    80002320:	01213823          	sd	s2,16(sp)
    80002324:	01313423          	sd	s3,8(sp)
    80002328:	01413023          	sd	s4,0(sp)
    8000232c:	03010413          	addi	s0,sp,48
    80002330:	00050a13          	mv	s4,a0
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002334:	00051a63          	bnez	a0,80002348 <_ZN14BuddyAllocator9buddyFreeEPvm+0x44>
    80002338:	fff00513          	li	a0,-1
    8000233c:	0940006f          	j	800023d0 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
            next = other;
    80002340:	00048a13          	mv	s4,s1
    80002344:	00098593          	mv	a1,s3
    while(size < maxPowerSize) {
    80002348:	00b00793          	li	a5,11
    8000234c:	08b7e063          	bltu	a5,a1,800023cc <_ZN14BuddyAllocator9buddyFreeEPvm+0xc8>
    }

    static void* relativeAddress(void* addr) {
        return (char*)addr - (size_t)startAddr;
    80002350:	00008917          	auipc	s2,0x8
    80002354:	19093903          	ld	s2,400(s2) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    80002358:	412a0933          	sub	s2,s4,s2
        size--;
    8000235c:	00158993          	addi	s3,a1,1
        return (1<<size)*blockSize;
    80002360:	00100793          	li	a5,1
    80002364:	0137973b          	sllw	a4,a5,s3
    80002368:	00c71713          	slli	a4,a4,0xc
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
    8000236c:	02e97933          	remu	s2,s2,a4
    80002370:	00b797bb          	sllw	a5,a5,a1
    80002374:	00c79793          	slli	a5,a5,0xc
        other = (void*)((char*)other + (module == 0 ? offset : -offset));
    80002378:	00090463          	beqz	s2,80002380 <_ZN14BuddyAllocator9buddyFreeEPvm+0x7c>
    8000237c:	40f007b3          	neg	a5,a5
    80002380:	00fa04b3          	add	s1,s4,a5
        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
    80002384:	00048593          	mv	a1,s1
    80002388:	00098513          	mv	a0,s3
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	c28080e7          	jalr	-984(ra) # 80001fb4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
    80002394:	00050663          	beqz	a0,800023a0 <_ZN14BuddyAllocator9buddyFreeEPvm+0x9c>
        if(module != 0) {
    80002398:	fa0914e3          	bnez	s2,80002340 <_ZN14BuddyAllocator9buddyFreeEPvm+0x3c>
    8000239c:	fa9ff06f          	j	80002344 <_ZN14BuddyAllocator9buddyFreeEPvm+0x40>
            BuddyEntry* entry = BuddyEntry::createEntry(next);
    800023a0:	000a0513          	mv	a0,s4
    800023a4:	00000097          	auipc	ra,0x0
    800023a8:	d54080e7          	jalr	-684(ra) # 800020f8 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800023ac:	00050593          	mv	a1,a0
            BuddyEntry::addEntry(size+1, entry);
    800023b0:	00098513          	mv	a0,s3
    800023b4:	00000097          	auipc	ra,0x0
    800023b8:	d64080e7          	jalr	-668(ra) # 80002118 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
    return 0;
    800023bc:	00000513          	li	a0,0
            break;
    800023c0:	0100006f          	j	800023d0 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
    if(size >= maxPowerSize || addr == nullptr) return -1;
    800023c4:	fff00513          	li	a0,-1
}
    800023c8:	00008067          	ret
    return 0;
    800023cc:	00000513          	li	a0,0
}
    800023d0:	02813083          	ld	ra,40(sp)
    800023d4:	02013403          	ld	s0,32(sp)
    800023d8:	01813483          	ld	s1,24(sp)
    800023dc:	01013903          	ld	s2,16(sp)
    800023e0:	00813983          	ld	s3,8(sp)
    800023e4:	00013a03          	ld	s4,0(sp)
    800023e8:	03010113          	addi	sp,sp,48
    800023ec:	00008067          	ret

00000000800023f0 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    800023f0:	fe010113          	addi	sp,sp,-32
    800023f4:	00113c23          	sd	ra,24(sp)
    800023f8:	00813823          	sd	s0,16(sp)
    800023fc:	00913423          	sd	s1,8(sp)
    80002400:	01213023          	sd	s2,0(sp)
    80002404:	02010413          	addi	s0,sp,32
    80002408:	00050493          	mv	s1,a0
    8000240c:	00058913          	mv	s2,a1
    if(!array) {
    80002410:	01053783          	ld	a5,16(a0)
    80002414:	04078863          	beqz	a5,80002464 <_ZN8IOBuffer8pushBackEc+0x74>
        array = (char*)kmalloc(capacity);
    }
    array[tail] = c;
    80002418:	0104b783          	ld	a5,16(s1)
    8000241c:	0084a703          	lw	a4,8(s1)
    80002420:	00e787b3          	add	a5,a5,a4
    80002424:	01278023          	sb	s2,0(a5)
    size++;
    80002428:	00c4a783          	lw	a5,12(s1)
    8000242c:	0017879b          	addiw	a5,a5,1
    80002430:	00f4a623          	sw	a5,12(s1)
    tail = tail == capacity - 1 ? 0 : tail + 1;
    80002434:	0084a783          	lw	a5,8(s1)
    80002438:	0004a703          	lw	a4,0(s1)
    8000243c:	fff7071b          	addiw	a4,a4,-1
    80002440:	02e78c63          	beq	a5,a4,80002478 <_ZN8IOBuffer8pushBackEc+0x88>
    80002444:	0017879b          	addiw	a5,a5,1
    80002448:	00f4a423          	sw	a5,8(s1)
}
    8000244c:	01813083          	ld	ra,24(sp)
    80002450:	01013403          	ld	s0,16(sp)
    80002454:	00813483          	ld	s1,8(sp)
    80002458:	00013903          	ld	s2,0(sp)
    8000245c:	02010113          	addi	sp,sp,32
    80002460:	00008067          	ret
        array = (char*)kmalloc(capacity);
    80002464:	00052503          	lw	a0,0(a0)
    80002468:	00002097          	auipc	ra,0x2
    8000246c:	5a4080e7          	jalr	1444(ra) # 80004a0c <_Z7kmallocm>
    80002470:	00a4b823          	sd	a0,16(s1)
    80002474:	fa5ff06f          	j	80002418 <_ZN8IOBuffer8pushBackEc+0x28>
    tail = tail == capacity - 1 ? 0 : tail + 1;
    80002478:	00000793          	li	a5,0
    8000247c:	fcdff06f          	j	80002448 <_ZN8IOBuffer8pushBackEc+0x58>

0000000080002480 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void*) {
    80002480:	fe010113          	addi	sp,sp,-32
    80002484:	00113c23          	sd	ra,24(sp)
    80002488:	00813823          	sd	s0,16(sp)
    8000248c:	00913423          	sd	s1,8(sp)
    80002490:	02010413          	addi	s0,sp,32
    80002494:	0500006f          	j	800024e4 <_ZN3CCB9inputBodyEPv+0x64>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80002498:	00008797          	auipc	a5,0x8
    8000249c:	ee87b783          	ld	a5,-280(a5) # 8000a380 <_GLOBAL_OFFSET_TABLE_+0x8>
    800024a0:	0007b783          	ld	a5,0(a5)
    800024a4:	0007c583          	lbu	a1,0(a5)
    800024a8:	00008517          	auipc	a0,0x8
    800024ac:	d8050513          	addi	a0,a0,-640 # 8000a228 <_ZN3CCB11inputBufferE>
    800024b0:	00000097          	auipc	ra,0x0
    800024b4:	f40080e7          	jalr	-192(ra) # 800023f0 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    800024b8:	00008497          	auipc	s1,0x8
    800024bc:	03048493          	addi	s1,s1,48 # 8000a4e8 <_ZN3CCB16inputBufferEmptyE>
    800024c0:	0004b503          	ld	a0,0(s1)
    800024c4:	fffff097          	auipc	ra,0xfffff
    800024c8:	f1c080e7          	jalr	-228(ra) # 800013e0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    800024cc:	00a00513          	li	a0,10
    800024d0:	00003097          	auipc	ra,0x3
    800024d4:	5bc080e7          	jalr	1468(ra) # 80005a8c <plic_complete>
            sem_wait(semInput);
    800024d8:	0084b503          	ld	a0,8(s1)
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	ebc080e7          	jalr	-324(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    800024e4:	00008797          	auipc	a5,0x8
    800024e8:	eac7b783          	ld	a5,-340(a5) # 8000a390 <_GLOBAL_OFFSET_TABLE_+0x18>
    800024ec:	0007b783          	ld	a5,0(a5)
    800024f0:	0007c783          	lbu	a5,0(a5)
    800024f4:	0017f793          	andi	a5,a5,1
    800024f8:	fa0790e3          	bnez	a5,80002498 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    800024fc:	fffff097          	auipc	ra,0xfffff
    80002500:	d78080e7          	jalr	-648(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002504:	fe1ff06f          	j	800024e4 <_ZN3CCB9inputBodyEPv+0x64>

0000000080002508 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80002508:	ff010113          	addi	sp,sp,-16
    8000250c:	00813423          	sd	s0,8(sp)
    80002510:	01010413          	addi	s0,sp,16
    if(!size) return 0;
    80002514:	00c52703          	lw	a4,12(a0)
    80002518:	04070463          	beqz	a4,80002560 <_ZN8IOBuffer8popFrontEv+0x58>
    8000251c:	00050793          	mv	a5,a0

    char c = array[head];
    80002520:	01053603          	ld	a2,16(a0)
    80002524:	00452683          	lw	a3,4(a0)
    80002528:	00d60633          	add	a2,a2,a3
    8000252c:	00064503          	lbu	a0,0(a2)
    size--;
    80002530:	fff7071b          	addiw	a4,a4,-1
    80002534:	00e7a623          	sw	a4,12(a5)
    head = head == capacity - 1 ? 0 : head + 1;
    80002538:	0007a703          	lw	a4,0(a5)
    8000253c:	fff7071b          	addiw	a4,a4,-1
    80002540:	00e68c63          	beq	a3,a4,80002558 <_ZN8IOBuffer8popFrontEv+0x50>
    80002544:	0016869b          	addiw	a3,a3,1
    80002548:	00d7a223          	sw	a3,4(a5)
    return c;
}
    8000254c:	00813403          	ld	s0,8(sp)
    80002550:	01010113          	addi	sp,sp,16
    80002554:	00008067          	ret
    head = head == capacity - 1 ? 0 : head + 1;
    80002558:	00000693          	li	a3,0
    8000255c:	fedff06f          	j	80002548 <_ZN8IOBuffer8popFrontEv+0x40>
    if(!size) return 0;
    80002560:	00000513          	li	a0,0
    80002564:	fe9ff06f          	j	8000254c <_ZN8IOBuffer8popFrontEv+0x44>

0000000080002568 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80002568:	ff010113          	addi	sp,sp,-16
    8000256c:	00813423          	sd	s0,8(sp)
    80002570:	01010413          	addi	s0,sp,16
    return size > 0 ? array[tail] : 0;
    80002574:	00c52783          	lw	a5,12(a0)
    80002578:	02f05063          	blez	a5,80002598 <_ZN8IOBuffer8peekBackEv+0x30>
    8000257c:	01053783          	ld	a5,16(a0)
    80002580:	00852703          	lw	a4,8(a0)
    80002584:	00e787b3          	add	a5,a5,a4
    80002588:	0007c503          	lbu	a0,0(a5)
}
    8000258c:	00813403          	ld	s0,8(sp)
    80002590:	01010113          	addi	sp,sp,16
    80002594:	00008067          	ret
    return size > 0 ? array[tail] : 0;
    80002598:	00000513          	li	a0,0
    8000259c:	ff1ff06f          	j	8000258c <_ZN8IOBuffer8peekBackEv+0x24>

00000000800025a0 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    800025a0:	ff010113          	addi	sp,sp,-16
    800025a4:	00813423          	sd	s0,8(sp)
    800025a8:	01010413          	addi	s0,sp,16
    return size > 0 ? array[head] : 0;
    800025ac:	00c52783          	lw	a5,12(a0)
    800025b0:	02f05063          	blez	a5,800025d0 <_ZN8IOBuffer9peekFrontEv+0x30>
    800025b4:	01053783          	ld	a5,16(a0)
    800025b8:	00452703          	lw	a4,4(a0)
    800025bc:	00e787b3          	add	a5,a5,a4
    800025c0:	0007c503          	lbu	a0,0(a5)
}
    800025c4:	00813403          	ld	s0,8(sp)
    800025c8:	01010113          	addi	sp,sp,16
    800025cc:	00008067          	ret
    return size > 0 ? array[head] : 0;
    800025d0:	00000513          	li	a0,0
    800025d4:	ff1ff06f          	j	800025c4 <_ZN8IOBuffer9peekFrontEv+0x24>

00000000800025d8 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void*) {
    800025d8:	fe010113          	addi	sp,sp,-32
    800025dc:	00113c23          	sd	ra,24(sp)
    800025e0:	00813823          	sd	s0,16(sp)
    800025e4:	00913423          	sd	s1,8(sp)
    800025e8:	02010413          	addi	s0,sp,32
    800025ec:	00c0006f          	j	800025f8 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    800025f0:	fffff097          	auipc	ra,0xfffff
    800025f4:	c84080e7          	jalr	-892(ra) # 80001274 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    800025f8:	00008797          	auipc	a5,0x8
    800025fc:	d987b783          	ld	a5,-616(a5) # 8000a390 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002600:	0007b783          	ld	a5,0(a5)
    80002604:	0007c783          	lbu	a5,0(a5)
    80002608:	0207f793          	andi	a5,a5,32
    8000260c:	fe0782e3          	beqz	a5,800025f0 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80002610:	00008517          	auipc	a0,0x8
    80002614:	c3050513          	addi	a0,a0,-976 # 8000a240 <_ZN3CCB12outputBufferE>
    80002618:	00000097          	auipc	ra,0x0
    8000261c:	f88080e7          	jalr	-120(ra) # 800025a0 <_ZN8IOBuffer9peekFrontEv>
    80002620:	fc0508e3          	beqz	a0,800025f0 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80002624:	00008797          	auipc	a5,0x8
    80002628:	d8c7b783          	ld	a5,-628(a5) # 8000a3b0 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000262c:	0007b483          	ld	s1,0(a5)
    80002630:	00008517          	auipc	a0,0x8
    80002634:	c1050513          	addi	a0,a0,-1008 # 8000a240 <_ZN3CCB12outputBufferE>
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	ed0080e7          	jalr	-304(ra) # 80002508 <_ZN8IOBuffer8popFrontEv>
    80002640:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    80002644:	00008517          	auipc	a0,0x8
    80002648:	eb453503          	ld	a0,-332(a0) # 8000a4f8 <_ZN3CCB9semOutputE>
    8000264c:	fffff097          	auipc	ra,0xfffff
    80002650:	d4c080e7          	jalr	-692(ra) # 80001398 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002654:	fa5ff06f          	j	800025f8 <_ZN3CCB10outputBodyEPv+0x20>

0000000080002658 <_ZN13SlabAllocator13initAllocatorEPvi>:
#include "../h/SlabAllocator.h"
#include "../h/BuddyAllocator.h"

void SlabAllocator::initAllocator(void *space, int blockNum) {
    80002658:	ff010113          	addi	sp,sp,-16
    8000265c:	00113423          	sd	ra,8(sp)
    80002660:	00813023          	sd	s0,0(sp)
    80002664:	01010413          	addi	s0,sp,16
    BuddyAllocator::initBuddy();
    80002668:	00000097          	auipc	ra,0x0
    8000266c:	b74080e7          	jalr	-1164(ra) # 800021dc <_ZN14BuddyAllocator9initBuddyEv>
}
    80002670:	00813083          	ld	ra,8(sp)
    80002674:	00013403          	ld	s0,0(sp)
    80002678:	01010113          	addi	sp,sp,16
    8000267c:	00008067          	ret

0000000080002680 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80002680:	fc010113          	addi	sp,sp,-64
    80002684:	02113c23          	sd	ra,56(sp)
    80002688:	02813823          	sd	s0,48(sp)
    8000268c:	02913423          	sd	s1,40(sp)
    80002690:	03213023          	sd	s2,32(sp)
    80002694:	01313c23          	sd	s3,24(sp)
    80002698:	01413823          	sd	s4,16(sp)
    8000269c:	01513423          	sd	s5,8(sp)
    800026a0:	04010413          	addi	s0,sp,64
    800026a4:	00050913          	mv	s2,a0
    800026a8:	00058993          	mv	s3,a1
    800026ac:	00060a13          	mv	s4,a2
    800026b0:	00068a93          	mv	s5,a3
    Cache* cache = Cache::createCache();
    800026b4:	00002097          	auipc	ra,0x2
    800026b8:	a10080e7          	jalr	-1520(ra) # 800040c4 <_ZN5Cache11createCacheEv>
    800026bc:	00050493          	mv	s1,a0
    cache->initCache(name, size, ctor, dtor);
    800026c0:	000a8713          	mv	a4,s5
    800026c4:	000a0693          	mv	a3,s4
    800026c8:	00098613          	mv	a2,s3
    800026cc:	00090593          	mv	a1,s2
    800026d0:	00002097          	auipc	ra,0x2
    800026d4:	a5c080e7          	jalr	-1444(ra) # 8000412c <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    return cache;
}
    800026d8:	00048513          	mv	a0,s1
    800026dc:	03813083          	ld	ra,56(sp)
    800026e0:	03013403          	ld	s0,48(sp)
    800026e4:	02813483          	ld	s1,40(sp)
    800026e8:	02013903          	ld	s2,32(sp)
    800026ec:	01813983          	ld	s3,24(sp)
    800026f0:	01013a03          	ld	s4,16(sp)
    800026f4:	00813a83          	ld	s5,8(sp)
    800026f8:	04010113          	addi	sp,sp,64
    800026fc:	00008067          	ret

0000000080002700 <_ZN13SlabAllocator9allocSlotEP5Cache>:

void *SlabAllocator::allocSlot(Cache *cache) {
    80002700:	ff010113          	addi	sp,sp,-16
    80002704:	00113423          	sd	ra,8(sp)
    80002708:	00813023          	sd	s0,0(sp)
    8000270c:	01010413          	addi	s0,sp,16
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
    80002710:	00002097          	auipc	ra,0x2
    80002714:	d48080e7          	jalr	-696(ra) # 80004458 <_ZN5Cache12allocateSlotEv>
}
    80002718:	01850513          	addi	a0,a0,24
    8000271c:	00813083          	ld	ra,8(sp)
    80002720:	00013403          	ld	s0,0(sp)
    80002724:	01010113          	addi	sp,sp,16
    80002728:	00008067          	ret

000000008000272c <_ZN13SlabAllocator8freeSlotEP5CachePv>:

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    8000272c:	ff010113          	addi	sp,sp,-16
    80002730:	00113423          	sd	ra,8(sp)
    80002734:	00813023          	sd	s0,0(sp)
    80002738:	01010413          	addi	s0,sp,16
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
    8000273c:	fe858593          	addi	a1,a1,-24
    80002740:	00002097          	auipc	ra,0x2
    80002744:	b6c080e7          	jalr	-1172(ra) # 800042ac <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80002748:	00813083          	ld	ra,8(sp)
    8000274c:	00013403          	ld	s0,0(sp)
    80002750:	01010113          	addi	sp,sp,16
    80002754:	00008067          	ret

0000000080002758 <_ZN13SlabAllocator17printErrorMessageEP5Cache>:

int SlabAllocator::printErrorMessage(Cache *cache) {
    80002758:	ff010113          	addi	sp,sp,-16
    8000275c:	00113423          	sd	ra,8(sp)
    80002760:	00813023          	sd	s0,0(sp)
    80002764:	01010413          	addi	s0,sp,16
    return cache->printErrorMessage();
    80002768:	00001097          	auipc	ra,0x1
    8000276c:	4cc080e7          	jalr	1228(ra) # 80003c34 <_ZN5Cache17printErrorMessageEv>
}
    80002770:	00813083          	ld	ra,8(sp)
    80002774:	00013403          	ld	s0,0(sp)
    80002778:	01010113          	addi	sp,sp,16
    8000277c:	00008067          	ret

0000000080002780 <_ZN13SlabAllocator14printCacheInfoEP5Cache>:

void SlabAllocator::printCacheInfo(Cache *cache) {
    80002780:	ff010113          	addi	sp,sp,-16
    80002784:	00113423          	sd	ra,8(sp)
    80002788:	00813023          	sd	s0,0(sp)
    8000278c:	01010413          	addi	s0,sp,16
    cache->printCacheInfo();
    80002790:	00001097          	auipc	ra,0x1
    80002794:	564080e7          	jalr	1380(ra) # 80003cf4 <_ZN5Cache14printCacheInfoEv>
}
    80002798:	00813083          	ld	ra,8(sp)
    8000279c:	00013403          	ld	s0,0(sp)
    800027a0:	01010113          	addi	sp,sp,16
    800027a4:	00008067          	ret

00000000800027a8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>:

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    800027a8:	ff010113          	addi	sp,sp,-16
    800027ac:	00113423          	sd	ra,8(sp)
    800027b0:	00813023          	sd	s0,0(sp)
    800027b4:	01010413          	addi	s0,sp,16
    return cache->deallocFreeSlabs();
    800027b8:	00001097          	auipc	ra,0x1
    800027bc:	6fc080e7          	jalr	1788(ra) # 80003eb4 <_ZN5Cache16deallocFreeSlabsEv>
}
    800027c0:	00813083          	ld	ra,8(sp)
    800027c4:	00013403          	ld	s0,0(sp)
    800027c8:	01010113          	addi	sp,sp,16
    800027cc:	00008067          	ret

00000000800027d0 <_ZN13SlabAllocator12deallocCacheEP5Cache>:

void SlabAllocator::deallocCache(Cache *cache) {
    800027d0:	ff010113          	addi	sp,sp,-16
    800027d4:	00113423          	sd	ra,8(sp)
    800027d8:	00813023          	sd	s0,0(sp)
    800027dc:	01010413          	addi	s0,sp,16
    cache->deallocCache();
    800027e0:	00001097          	auipc	ra,0x1
    800027e4:	740080e7          	jalr	1856(ra) # 80003f20 <_ZN5Cache12deallocCacheEv>
}
    800027e8:	00813083          	ld	ra,8(sp)
    800027ec:	00013403          	ld	s0,0(sp)
    800027f0:	01010113          	addi	sp,sp,16
    800027f4:	00008067          	ret

00000000800027f8 <_ZN13SlabAllocator9allocBuffEm>:

void *SlabAllocator::allocBuff(size_t size) {
    800027f8:	ff010113          	addi	sp,sp,-16
    800027fc:	00113423          	sd	ra,8(sp)
    80002800:	00813023          	sd	s0,0(sp)
    80002804:	01010413          	addi	s0,sp,16
    return (void*)((char*)Cache::allocateBuffer(size) + sizeof(Cache::Slot)); // za pocetnu adresu bafera
    80002808:	00002097          	auipc	ra,0x2
    8000280c:	cb0080e7          	jalr	-848(ra) # 800044b8 <_ZN5Cache14allocateBufferEm>
}
    80002810:	01850513          	addi	a0,a0,24
    80002814:	00813083          	ld	ra,8(sp)
    80002818:	00013403          	ld	s0,0(sp)
    8000281c:	01010113          	addi	sp,sp,16
    80002820:	00008067          	ret

0000000080002824 <_ZN13SlabAllocator8freeBuffEPKv>:

void SlabAllocator::freeBuff(const void *buff) {
    80002824:	ff010113          	addi	sp,sp,-16
    80002828:	00113423          	sd	ra,8(sp)
    8000282c:	00813023          	sd	s0,0(sp)
    80002830:	01010413          	addi	s0,sp,16
    Cache::freeBuffer((Cache::Slot*)((char*)buff - sizeof(Cache::Slot))); // za pocetnu adresu slota
    80002834:	fe850513          	addi	a0,a0,-24
    80002838:	00002097          	auipc	ra,0x2
    8000283c:	b1c080e7          	jalr	-1252(ra) # 80004354 <_ZN5Cache10freeBufferEPNS_4SlotE>
}
    80002840:	00813083          	ld	ra,8(sp)
    80002844:	00013403          	ld	s0,0(sp)
    80002848:	01010113          	addi	sp,sp,16
    8000284c:	00008067          	ret

0000000080002850 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002850:	fe010113          	addi	sp,sp,-32
    80002854:	00113c23          	sd	ra,24(sp)
    80002858:	00813823          	sd	s0,16(sp)
    8000285c:	00913423          	sd	s1,8(sp)
    80002860:	02010413          	addi	s0,sp,32
    80002864:	00050493          	mv	s1,a0
    LOCK();
    80002868:	00100613          	li	a2,1
    8000286c:	00000593          	li	a1,0
    80002870:	00008517          	auipc	a0,0x8
    80002874:	ca050513          	addi	a0,a0,-864 # 8000a510 <lockPrint>
    80002878:	fffff097          	auipc	ra,0xfffff
    8000287c:	8d8080e7          	jalr	-1832(ra) # 80001150 <copy_and_swap>
    80002880:	fe0514e3          	bnez	a0,80002868 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002884:	0004c503          	lbu	a0,0(s1)
    80002888:	00050a63          	beqz	a0,8000289c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	c4c080e7          	jalr	-948(ra) # 800014d8 <_Z4putcc>
        string++;
    80002894:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002898:	fedff06f          	j	80002884 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000289c:	00000613          	li	a2,0
    800028a0:	00100593          	li	a1,1
    800028a4:	00008517          	auipc	a0,0x8
    800028a8:	c6c50513          	addi	a0,a0,-916 # 8000a510 <lockPrint>
    800028ac:	fffff097          	auipc	ra,0xfffff
    800028b0:	8a4080e7          	jalr	-1884(ra) # 80001150 <copy_and_swap>
    800028b4:	fe0514e3          	bnez	a0,8000289c <_Z11printStringPKc+0x4c>
}
    800028b8:	01813083          	ld	ra,24(sp)
    800028bc:	01013403          	ld	s0,16(sp)
    800028c0:	00813483          	ld	s1,8(sp)
    800028c4:	02010113          	addi	sp,sp,32
    800028c8:	00008067          	ret

00000000800028cc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800028cc:	fd010113          	addi	sp,sp,-48
    800028d0:	02113423          	sd	ra,40(sp)
    800028d4:	02813023          	sd	s0,32(sp)
    800028d8:	00913c23          	sd	s1,24(sp)
    800028dc:	01213823          	sd	s2,16(sp)
    800028e0:	01313423          	sd	s3,8(sp)
    800028e4:	01413023          	sd	s4,0(sp)
    800028e8:	03010413          	addi	s0,sp,48
    800028ec:	00050993          	mv	s3,a0
    800028f0:	00058a13          	mv	s4,a1
    LOCK();
    800028f4:	00100613          	li	a2,1
    800028f8:	00000593          	li	a1,0
    800028fc:	00008517          	auipc	a0,0x8
    80002900:	c1450513          	addi	a0,a0,-1004 # 8000a510 <lockPrint>
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	84c080e7          	jalr	-1972(ra) # 80001150 <copy_and_swap>
    8000290c:	fe0514e3          	bnez	a0,800028f4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002910:	00000913          	li	s2,0
    80002914:	00090493          	mv	s1,s2
    80002918:	0019091b          	addiw	s2,s2,1
    8000291c:	03495a63          	bge	s2,s4,80002950 <_Z9getStringPci+0x84>
        cc = getc();
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	b88080e7          	jalr	-1144(ra) # 800014a8 <_Z4getcv>
        if(cc < 1)
    80002928:	02050463          	beqz	a0,80002950 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000292c:	009984b3          	add	s1,s3,s1
    80002930:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002934:	00a00793          	li	a5,10
    80002938:	00f50a63          	beq	a0,a5,8000294c <_Z9getStringPci+0x80>
    8000293c:	00d00793          	li	a5,13
    80002940:	fcf51ae3          	bne	a0,a5,80002914 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002944:	00090493          	mv	s1,s2
    80002948:	0080006f          	j	80002950 <_Z9getStringPci+0x84>
    8000294c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002950:	009984b3          	add	s1,s3,s1
    80002954:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002958:	00000613          	li	a2,0
    8000295c:	00100593          	li	a1,1
    80002960:	00008517          	auipc	a0,0x8
    80002964:	bb050513          	addi	a0,a0,-1104 # 8000a510 <lockPrint>
    80002968:	ffffe097          	auipc	ra,0xffffe
    8000296c:	7e8080e7          	jalr	2024(ra) # 80001150 <copy_and_swap>
    80002970:	fe0514e3          	bnez	a0,80002958 <_Z9getStringPci+0x8c>
    return buf;
}
    80002974:	00098513          	mv	a0,s3
    80002978:	02813083          	ld	ra,40(sp)
    8000297c:	02013403          	ld	s0,32(sp)
    80002980:	01813483          	ld	s1,24(sp)
    80002984:	01013903          	ld	s2,16(sp)
    80002988:	00813983          	ld	s3,8(sp)
    8000298c:	00013a03          	ld	s4,0(sp)
    80002990:	03010113          	addi	sp,sp,48
    80002994:	00008067          	ret

0000000080002998 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00813423          	sd	s0,8(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800029a8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800029ac:	0006c603          	lbu	a2,0(a3)
    800029b0:	fd06071b          	addiw	a4,a2,-48
    800029b4:	0ff77713          	andi	a4,a4,255
    800029b8:	00900793          	li	a5,9
    800029bc:	02e7e063          	bltu	a5,a4,800029dc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800029c0:	0025179b          	slliw	a5,a0,0x2
    800029c4:	00a787bb          	addw	a5,a5,a0
    800029c8:	0017979b          	slliw	a5,a5,0x1
    800029cc:	00168693          	addi	a3,a3,1
    800029d0:	00c787bb          	addw	a5,a5,a2
    800029d4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800029d8:	fd5ff06f          	j	800029ac <_Z11stringToIntPKc+0x14>
    return n;
}
    800029dc:	00813403          	ld	s0,8(sp)
    800029e0:	01010113          	addi	sp,sp,16
    800029e4:	00008067          	ret

00000000800029e8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800029e8:	fc010113          	addi	sp,sp,-64
    800029ec:	02113c23          	sd	ra,56(sp)
    800029f0:	02813823          	sd	s0,48(sp)
    800029f4:	02913423          	sd	s1,40(sp)
    800029f8:	03213023          	sd	s2,32(sp)
    800029fc:	01313c23          	sd	s3,24(sp)
    80002a00:	04010413          	addi	s0,sp,64
    80002a04:	00050493          	mv	s1,a0
    80002a08:	00058913          	mv	s2,a1
    80002a0c:	00060993          	mv	s3,a2
    LOCK();
    80002a10:	00100613          	li	a2,1
    80002a14:	00000593          	li	a1,0
    80002a18:	00008517          	auipc	a0,0x8
    80002a1c:	af850513          	addi	a0,a0,-1288 # 8000a510 <lockPrint>
    80002a20:	ffffe097          	auipc	ra,0xffffe
    80002a24:	730080e7          	jalr	1840(ra) # 80001150 <copy_and_swap>
    80002a28:	fe0514e3          	bnez	a0,80002a10 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a2c:	00098463          	beqz	s3,80002a34 <_Z8printIntiii+0x4c>
    80002a30:	0804c463          	bltz	s1,80002ab8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a34:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002a38:	00000593          	li	a1,0
    }

    i = 0;
    80002a3c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a40:	0009079b          	sext.w	a5,s2
    80002a44:	0325773b          	remuw	a4,a0,s2
    80002a48:	00048613          	mv	a2,s1
    80002a4c:	0014849b          	addiw	s1,s1,1
    80002a50:	02071693          	slli	a3,a4,0x20
    80002a54:	0206d693          	srli	a3,a3,0x20
    80002a58:	00008717          	auipc	a4,0x8
    80002a5c:	80070713          	addi	a4,a4,-2048 # 8000a258 <digits>
    80002a60:	00d70733          	add	a4,a4,a3
    80002a64:	00074683          	lbu	a3,0(a4)
    80002a68:	fd040713          	addi	a4,s0,-48
    80002a6c:	00c70733          	add	a4,a4,a2
    80002a70:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002a74:	0005071b          	sext.w	a4,a0
    80002a78:	0325553b          	divuw	a0,a0,s2
    80002a7c:	fcf772e3          	bgeu	a4,a5,80002a40 <_Z8printIntiii+0x58>
    if(neg)
    80002a80:	00058c63          	beqz	a1,80002a98 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002a84:	fd040793          	addi	a5,s0,-48
    80002a88:	009784b3          	add	s1,a5,s1
    80002a8c:	02d00793          	li	a5,45
    80002a90:	fef48823          	sb	a5,-16(s1)
    80002a94:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002a98:	fff4849b          	addiw	s1,s1,-1
    80002a9c:	0204c463          	bltz	s1,80002ac4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002aa0:	fd040793          	addi	a5,s0,-48
    80002aa4:	009787b3          	add	a5,a5,s1
    80002aa8:	ff07c503          	lbu	a0,-16(a5)
    80002aac:	fffff097          	auipc	ra,0xfffff
    80002ab0:	a2c080e7          	jalr	-1492(ra) # 800014d8 <_Z4putcc>
    80002ab4:	fe5ff06f          	j	80002a98 <_Z8printIntiii+0xb0>
        x = -xx;
    80002ab8:	4090053b          	negw	a0,s1
        neg = 1;
    80002abc:	00100593          	li	a1,1
        x = -xx;
    80002ac0:	f7dff06f          	j	80002a3c <_Z8printIntiii+0x54>

    UNLOCK();
    80002ac4:	00000613          	li	a2,0
    80002ac8:	00100593          	li	a1,1
    80002acc:	00008517          	auipc	a0,0x8
    80002ad0:	a4450513          	addi	a0,a0,-1468 # 8000a510 <lockPrint>
    80002ad4:	ffffe097          	auipc	ra,0xffffe
    80002ad8:	67c080e7          	jalr	1660(ra) # 80001150 <copy_and_swap>
    80002adc:	fe0514e3          	bnez	a0,80002ac4 <_Z8printIntiii+0xdc>
    80002ae0:	03813083          	ld	ra,56(sp)
    80002ae4:	03013403          	ld	s0,48(sp)
    80002ae8:	02813483          	ld	s1,40(sp)
    80002aec:	02013903          	ld	s2,32(sp)
    80002af0:	01813983          	ld	s3,24(sp)
    80002af4:	04010113          	addi	sp,sp,64
    80002af8:	00008067          	ret

0000000080002afc <_Z8userMainv>:
    long id;
    bool finished;
};


void userMain() {
    80002afc:	fc010113          	addi	sp,sp,-64
    80002b00:	02113c23          	sd	ra,56(sp)
    80002b04:	02813823          	sd	s0,48(sp)
    80002b08:	02913423          	sd	s1,40(sp)
    80002b0c:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002b10:	fc040493          	addi	s1,s0,-64
    80002b14:	00048513          	mv	a0,s1
    80002b18:	00001097          	auipc	ra,0x1
    80002b1c:	8b0080e7          	jalr	-1872(ra) # 800033c8 <_ZN6ThreadC1Ev>
    80002b20:	00007797          	auipc	a5,0x7
    80002b24:	76078793          	addi	a5,a5,1888 # 8000a280 <_ZTV10ForkThread+0x10>
    80002b28:	fcf43023          	sd	a5,-64(s0)
    80002b2c:	00100793          	li	a5,1
    80002b30:	fcf43823          	sd	a5,-48(s0)
    80002b34:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    80002b38:	00048513          	mv	a0,s1
    80002b3c:	00001097          	auipc	ra,0x1
    80002b40:	85c080e7          	jalr	-1956(ra) # 80003398 <_ZN6Thread5startEv>
        return finished;
    80002b44:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    80002b48:	00079863          	bnez	a5,80002b58 <_Z8userMainv+0x5c>
        thread_dispatch();
    80002b4c:	ffffe097          	auipc	ra,0xffffe
    80002b50:	728080e7          	jalr	1832(ra) # 80001274 <_Z15thread_dispatchv>
    80002b54:	ff1ff06f          	j	80002b44 <_Z8userMainv+0x48>
    }

    printString("User main finished\n");
    80002b58:	00005517          	auipc	a0,0x5
    80002b5c:	62050513          	addi	a0,a0,1568 # 80008178 <CONSOLE_STATUS+0x168>
    80002b60:	00000097          	auipc	ra,0x0
    80002b64:	cf0080e7          	jalr	-784(ra) # 80002850 <_Z11printStringPKc>
class ForkThread : public Thread {
    80002b68:	00007797          	auipc	a5,0x7
    80002b6c:	71878793          	addi	a5,a5,1816 # 8000a280 <_ZTV10ForkThread+0x10>
    80002b70:	fcf43023          	sd	a5,-64(s0)
    80002b74:	fc040513          	addi	a0,s0,-64
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	59c080e7          	jalr	1436(ra) # 80003114 <_ZN6ThreadD1Ev>
    80002b80:	03813083          	ld	ra,56(sp)
    80002b84:	03013403          	ld	s0,48(sp)
    80002b88:	02813483          	ld	s1,40(sp)
    80002b8c:	04010113          	addi	sp,sp,64
    80002b90:	00008067          	ret
    80002b94:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80002b98:	00007797          	auipc	a5,0x7
    80002b9c:	6e878793          	addi	a5,a5,1768 # 8000a280 <_ZTV10ForkThread+0x10>
    80002ba0:	fcf43023          	sd	a5,-64(s0)
    80002ba4:	fc040513          	addi	a0,s0,-64
    80002ba8:	00000097          	auipc	ra,0x0
    80002bac:	56c080e7          	jalr	1388(ra) # 80003114 <_ZN6ThreadD1Ev>
    80002bb0:	00048513          	mv	a0,s1
    80002bb4:	00009097          	auipc	ra,0x9
    80002bb8:	ac4080e7          	jalr	-1340(ra) # 8000b678 <_Unwind_Resume>

0000000080002bbc <_ZN10ForkThread3runEv>:
    virtual void run() {
    80002bbc:	fc010113          	addi	sp,sp,-64
    80002bc0:	02113c23          	sd	ra,56(sp)
    80002bc4:	02813823          	sd	s0,48(sp)
    80002bc8:	02913423          	sd	s1,40(sp)
    80002bcc:	03213023          	sd	s2,32(sp)
    80002bd0:	01313c23          	sd	s3,24(sp)
    80002bd4:	01413823          	sd	s4,16(sp)
    80002bd8:	01513423          	sd	s5,8(sp)
    80002bdc:	01613023          	sd	s6,0(sp)
    80002be0:	04010413          	addi	s0,sp,64
    80002be4:	00050913          	mv	s2,a0
        printString("Started thread id:");
    80002be8:	00005517          	auipc	a0,0x5
    80002bec:	56050513          	addi	a0,a0,1376 # 80008148 <CONSOLE_STATUS+0x138>
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	c60080e7          	jalr	-928(ra) # 80002850 <_Z11printStringPKc>
        printInt(id);
    80002bf8:	00000613          	li	a2,0
    80002bfc:	00a00593          	li	a1,10
    80002c00:	01092503          	lw	a0,16(s2)
    80002c04:	00000097          	auipc	ra,0x0
    80002c08:	de4080e7          	jalr	-540(ra) # 800029e8 <_Z8printIntiii>
        printString("\n");
    80002c0c:	00005517          	auipc	a0,0x5
    80002c10:	65450513          	addi	a0,a0,1620 # 80008260 <CONSOLE_STATUS+0x250>
    80002c14:	00000097          	auipc	ra,0x0
    80002c18:	c3c080e7          	jalr	-964(ra) # 80002850 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    80002c1c:	02000513          	li	a0,32
    80002c20:	00000097          	auipc	ra,0x0
    80002c24:	6c0080e7          	jalr	1728(ra) # 800032e0 <_ZN6ThreadnwEm>
    80002c28:	00050a93          	mv	s5,a0
    80002c2c:	02050463          	beqz	a0,80002c54 <_ZN10ForkThread3runEv+0x98>
    80002c30:	01093483          	ld	s1,16(s2)
    80002c34:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002c38:	00000097          	auipc	ra,0x0
    80002c3c:	790080e7          	jalr	1936(ra) # 800033c8 <_ZN6ThreadC1Ev>
    80002c40:	00007797          	auipc	a5,0x7
    80002c44:	64078793          	addi	a5,a5,1600 # 8000a280 <_ZTV10ForkThread+0x10>
    80002c48:	00fab023          	sd	a5,0(s5)
    80002c4c:	009ab823          	sd	s1,16(s5)
    80002c50:	000a8c23          	sb	zero,24(s5)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80002c54:	01093503          	ld	a0,16(s2)
    80002c58:	00351513          	slli	a0,a0,0x3
    80002c5c:	ffffe097          	auipc	ra,0xffffe
    80002c60:	538080e7          	jalr	1336(ra) # 80001194 <_Z9mem_allocm>
    80002c64:	00050a13          	mv	s4,a0
        if (threads != nullptr) {
    80002c68:	10050463          	beqz	a0,80002d70 <_ZN10ForkThread3runEv+0x1b4>
            for (long i = 0; i < id; i++) {
    80002c6c:	00000993          	li	s3,0
    80002c70:	0140006f          	j	80002c84 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    80002c74:	00399793          	slli	a5,s3,0x3
    80002c78:	00fa07b3          	add	a5,s4,a5
    80002c7c:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    80002c80:	00198993          	addi	s3,s3,1
    80002c84:	01093783          	ld	a5,16(s2)
    80002c88:	02f9de63          	bge	s3,a5,80002cc4 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    80002c8c:	02000513          	li	a0,32
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	650080e7          	jalr	1616(ra) # 800032e0 <_ZN6ThreadnwEm>
    80002c98:	00050493          	mv	s1,a0
    80002c9c:	fc050ce3          	beqz	a0,80002c74 <_ZN10ForkThread3runEv+0xb8>
    80002ca0:	01093b03          	ld	s6,16(s2)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002ca4:	00000097          	auipc	ra,0x0
    80002ca8:	724080e7          	jalr	1828(ra) # 800033c8 <_ZN6ThreadC1Ev>
    80002cac:	00007797          	auipc	a5,0x7
    80002cb0:	5d478793          	addi	a5,a5,1492 # 8000a280 <_ZTV10ForkThread+0x10>
    80002cb4:	00f4b023          	sd	a5,0(s1)
    80002cb8:	0164b823          	sd	s6,16(s1)
    80002cbc:	00048c23          	sb	zero,24(s1)
    80002cc0:	fb5ff06f          	j	80002c74 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    80002cc4:	060a8663          	beqz	s5,80002d30 <_ZN10ForkThread3runEv+0x174>
                if (thread->start() == 0) {
    80002cc8:	000a8513          	mv	a0,s5
    80002ccc:	00000097          	auipc	ra,0x0
    80002cd0:	6cc080e7          	jalr	1740(ra) # 80003398 <_ZN6Thread5startEv>
    80002cd4:	00050993          	mv	s3,a0
    80002cd8:	04051463          	bnez	a0,80002d20 <_ZN10ForkThread3runEv+0x164>
                    for (int i = 0; i < 50; i++) {
    80002cdc:	00050493          	mv	s1,a0
    80002ce0:	0100006f          	j	80002cf0 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    80002ce4:	ffffe097          	auipc	ra,0xffffe
    80002ce8:	590080e7          	jalr	1424(ra) # 80001274 <_Z15thread_dispatchv>
                    for (int i = 0; i < 50; i++) {
    80002cec:	0014849b          	addiw	s1,s1,1
    80002cf0:	03100793          	li	a5,49
    80002cf4:	0097cc63          	blt	a5,s1,80002d0c <_ZN10ForkThread3runEv+0x150>
                        for (int j = 0; j < 50; j++) {
    80002cf8:	00098793          	mv	a5,s3
    80002cfc:	03100713          	li	a4,49
    80002d00:	fef742e3          	blt	a4,a5,80002ce4 <_ZN10ForkThread3runEv+0x128>
    80002d04:	0017879b          	addiw	a5,a5,1
    80002d08:	ff5ff06f          	j	80002cfc <_ZN10ForkThread3runEv+0x140>
        return finished;
    80002d0c:	018ac783          	lbu	a5,24(s5)
                    while (!thread->isFinished()) {
    80002d10:	00079863          	bnez	a5,80002d20 <_ZN10ForkThread3runEv+0x164>
                        thread_dispatch();
    80002d14:	ffffe097          	auipc	ra,0xffffe
    80002d18:	560080e7          	jalr	1376(ra) # 80001274 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    80002d1c:	ff1ff06f          	j	80002d0c <_ZN10ForkThread3runEv+0x150>
                delete thread;
    80002d20:	000ab783          	ld	a5,0(s5)
    80002d24:	0087b783          	ld	a5,8(a5)
    80002d28:	000a8513          	mv	a0,s5
    80002d2c:	000780e7          	jalr	a5
                        for (int j = 0; j < 50; j++) {
    80002d30:	00000493          	li	s1,0
    80002d34:	0080006f          	j	80002d3c <_ZN10ForkThread3runEv+0x180>
            for (long i = 0; i < id; i++) {
    80002d38:	00148493          	addi	s1,s1,1
    80002d3c:	01093783          	ld	a5,16(s2)
    80002d40:	02f4d263          	bge	s1,a5,80002d64 <_ZN10ForkThread3runEv+0x1a8>
                delete threads[i];
    80002d44:	00349793          	slli	a5,s1,0x3
    80002d48:	00fa07b3          	add	a5,s4,a5
    80002d4c:	0007b503          	ld	a0,0(a5)
    80002d50:	fe0504e3          	beqz	a0,80002d38 <_ZN10ForkThread3runEv+0x17c>
    80002d54:	00053783          	ld	a5,0(a0)
    80002d58:	0087b783          	ld	a5,8(a5)
    80002d5c:	000780e7          	jalr	a5
    80002d60:	fd9ff06f          	j	80002d38 <_ZN10ForkThread3runEv+0x17c>
            mem_free(threads);
    80002d64:	000a0513          	mv	a0,s4
    80002d68:	ffffe097          	auipc	ra,0xffffe
    80002d6c:	46c080e7          	jalr	1132(ra) # 800011d4 <_Z8mem_freePv>
        printString("Finished thread id:");
    80002d70:	00005517          	auipc	a0,0x5
    80002d74:	3f050513          	addi	a0,a0,1008 # 80008160 <CONSOLE_STATUS+0x150>
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	ad8080e7          	jalr	-1320(ra) # 80002850 <_Z11printStringPKc>
        printInt(id);
    80002d80:	00000613          	li	a2,0
    80002d84:	00a00593          	li	a1,10
    80002d88:	01092503          	lw	a0,16(s2)
    80002d8c:	00000097          	auipc	ra,0x0
    80002d90:	c5c080e7          	jalr	-932(ra) # 800029e8 <_Z8printIntiii>
        printString("\n");
    80002d94:	00005517          	auipc	a0,0x5
    80002d98:	4cc50513          	addi	a0,a0,1228 # 80008260 <CONSOLE_STATUS+0x250>
    80002d9c:	00000097          	auipc	ra,0x0
    80002da0:	ab4080e7          	jalr	-1356(ra) # 80002850 <_Z11printStringPKc>
        finished = true;
    80002da4:	00100793          	li	a5,1
    80002da8:	00f90c23          	sb	a5,24(s2)
    }
    80002dac:	03813083          	ld	ra,56(sp)
    80002db0:	03013403          	ld	s0,48(sp)
    80002db4:	02813483          	ld	s1,40(sp)
    80002db8:	02013903          	ld	s2,32(sp)
    80002dbc:	01813983          	ld	s3,24(sp)
    80002dc0:	01013a03          	ld	s4,16(sp)
    80002dc4:	00813a83          	ld	s5,8(sp)
    80002dc8:	00013b03          	ld	s6,0(sp)
    80002dcc:	04010113          	addi	sp,sp,64
    80002dd0:	00008067          	ret

0000000080002dd4 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    80002dd4:	ff010113          	addi	sp,sp,-16
    80002dd8:	00113423          	sd	ra,8(sp)
    80002ddc:	00813023          	sd	s0,0(sp)
    80002de0:	01010413          	addi	s0,sp,16
    80002de4:	00007797          	auipc	a5,0x7
    80002de8:	49c78793          	addi	a5,a5,1180 # 8000a280 <_ZTV10ForkThread+0x10>
    80002dec:	00f53023          	sd	a5,0(a0)
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	324080e7          	jalr	804(ra) # 80003114 <_ZN6ThreadD1Ev>
    80002df8:	00813083          	ld	ra,8(sp)
    80002dfc:	00013403          	ld	s0,0(sp)
    80002e00:	01010113          	addi	sp,sp,16
    80002e04:	00008067          	ret

0000000080002e08 <_ZN10ForkThreadD0Ev>:
    80002e08:	fe010113          	addi	sp,sp,-32
    80002e0c:	00113c23          	sd	ra,24(sp)
    80002e10:	00813823          	sd	s0,16(sp)
    80002e14:	00913423          	sd	s1,8(sp)
    80002e18:	02010413          	addi	s0,sp,32
    80002e1c:	00050493          	mv	s1,a0
    80002e20:	00007797          	auipc	a5,0x7
    80002e24:	46078793          	addi	a5,a5,1120 # 8000a280 <_ZTV10ForkThread+0x10>
    80002e28:	00f53023          	sd	a5,0(a0)
    80002e2c:	00000097          	auipc	ra,0x0
    80002e30:	2e8080e7          	jalr	744(ra) # 80003114 <_ZN6ThreadD1Ev>
    80002e34:	00048513          	mv	a0,s1
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	4d0080e7          	jalr	1232(ra) # 80003308 <_ZN6ThreaddlEPv>
    80002e40:	01813083          	ld	ra,24(sp)
    80002e44:	01013403          	ld	s0,16(sp)
    80002e48:	00813483          	ld	s1,8(sp)
    80002e4c:	02010113          	addi	sp,sp,32
    80002e50:	00008067          	ret

0000000080002e54 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002e54:	ff010113          	addi	sp,sp,-16
    80002e58:	00813423          	sd	s0,8(sp)
    80002e5c:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002e60:	02050663          	beqz	a0,80002e8c <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002e64:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002e68:	00007797          	auipc	a5,0x7
    80002e6c:	6b07b783          	ld	a5,1712(a5) # 8000a518 <_ZN9Scheduler4tailE>
    80002e70:	02078463          	beqz	a5,80002e98 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002e74:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002e78:	00007797          	auipc	a5,0x7
    80002e7c:	6a078793          	addi	a5,a5,1696 # 8000a518 <_ZN9Scheduler4tailE>
    80002e80:	0007b703          	ld	a4,0(a5)
    80002e84:	00073703          	ld	a4,0(a4)
    80002e88:	00e7b023          	sd	a4,0(a5)
    }
}
    80002e8c:	00813403          	ld	s0,8(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret
        head = tail = process;
    80002e98:	00007797          	auipc	a5,0x7
    80002e9c:	68078793          	addi	a5,a5,1664 # 8000a518 <_ZN9Scheduler4tailE>
    80002ea0:	00a7b023          	sd	a0,0(a5)
    80002ea4:	00a7b423          	sd	a0,8(a5)
    80002ea8:	fe5ff06f          	j	80002e8c <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002eac <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002eac:	ff010113          	addi	sp,sp,-16
    80002eb0:	00813423          	sd	s0,8(sp)
    80002eb4:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002eb8:	00007517          	auipc	a0,0x7
    80002ebc:	66853503          	ld	a0,1640(a0) # 8000a520 <_ZN9Scheduler4headE>
    80002ec0:	02050463          	beqz	a0,80002ee8 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002ec4:	00053703          	ld	a4,0(a0)
    80002ec8:	00007797          	auipc	a5,0x7
    80002ecc:	65078793          	addi	a5,a5,1616 # 8000a518 <_ZN9Scheduler4tailE>
    80002ed0:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002ed4:	0007b783          	ld	a5,0(a5)
    80002ed8:	00f50e63          	beq	a0,a5,80002ef4 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002edc:	00813403          	ld	s0,8(sp)
    80002ee0:	01010113          	addi	sp,sp,16
    80002ee4:	00008067          	ret
        return idleProcess;
    80002ee8:	00007517          	auipc	a0,0x7
    80002eec:	64053503          	ld	a0,1600(a0) # 8000a528 <_ZN9Scheduler11idleProcessE>
    80002ef0:	fedff06f          	j	80002edc <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002ef4:	00007797          	auipc	a5,0x7
    80002ef8:	62e7b223          	sd	a4,1572(a5) # 8000a518 <_ZN9Scheduler4tailE>
    80002efc:	fe1ff06f          	j	80002edc <_ZN9Scheduler3getEv+0x30>

0000000080002f00 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002f00:	ff010113          	addi	sp,sp,-16
    80002f04:	00813423          	sd	s0,8(sp)
    80002f08:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002f0c:	00050e63          	beqz	a0,80002f28 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002f10:	00007797          	auipc	a5,0x7
    80002f14:	6107b783          	ld	a5,1552(a5) # 8000a520 <_ZN9Scheduler4headE>
    80002f18:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002f1c:	00078c63          	beqz	a5,80002f34 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002f20:	00007797          	auipc	a5,0x7
    80002f24:	60a7b023          	sd	a0,1536(a5) # 8000a520 <_ZN9Scheduler4headE>
    }
}
    80002f28:	00813403          	ld	s0,8(sp)
    80002f2c:	01010113          	addi	sp,sp,16
    80002f30:	00008067          	ret
        head = tail = process;
    80002f34:	00007797          	auipc	a5,0x7
    80002f38:	5e478793          	addi	a5,a5,1508 # 8000a518 <_ZN9Scheduler4tailE>
    80002f3c:	00a7b023          	sd	a0,0(a5)
    80002f40:	00a7b423          	sd	a0,8(a5)
    80002f44:	fe5ff06f          	j	80002f28 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002f48 <idleProcess>:
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002f48:	ff010113          	addi	sp,sp,-16
    80002f4c:	00813423          	sd	s0,8(sp)
    80002f50:	01010413          	addi	s0,sp,16
    while(true) {}
    80002f54:	0000006f          	j	80002f54 <idleProcess+0xc>

0000000080002f58 <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    80002f58:	ff010113          	addi	sp,sp,-16
    80002f5c:	00113423          	sd	ra,8(sp)
    80002f60:	00813023          	sd	s0,0(sp)
    80002f64:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    80002f68:	00000097          	auipc	ra,0x0
    80002f6c:	b94080e7          	jalr	-1132(ra) # 80002afc <_Z8userMainv>
}
    80002f70:	00813083          	ld	ra,8(sp)
    80002f74:	00013403          	ld	s0,0(sp)
    80002f78:	01010113          	addi	sp,sp,16
    80002f7c:	00008067          	ret

0000000080002f80 <_Z8userModev>:
void userMode() {
    80002f80:	ff010113          	addi	sp,sp,-16
    80002f84:	00813423          	sd	s0,8(sp)
    80002f88:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80002f8c:	04300793          	li	a5,67
    80002f90:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002f94:	00000073          	ecall
}
    80002f98:	00813403          	ld	s0,8(sp)
    80002f9c:	01010113          	addi	sp,sp,16
    80002fa0:	00008067          	ret

0000000080002fa4 <main>:
}
// ------------

int main() {
    80002fa4:	ff010113          	addi	sp,sp,-16
    80002fa8:	00113423          	sd	ra,8(sp)
    80002fac:	00813023          	sd	s0,0(sp)
    80002fb0:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002fb4:	00007797          	auipc	a5,0x7
    80002fb8:	4447b783          	ld	a5,1092(a5) # 8000a3f8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002fbc:	10579073          	csrw	stvec,a5
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);
    80002fc0:	010005b7          	lui	a1,0x1000
    80002fc4:	00007797          	auipc	a5,0x7
    80002fc8:	3d47b783          	ld	a5,980(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002fcc:	0007b503          	ld	a0,0(a5)
    80002fd0:	00002097          	auipc	ra,0x2
    80002fd4:	974080e7          	jalr	-1676(ra) # 80004944 <_Z9kmem_initPvi>

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002fd8:	00000593          	li	a1,0
    80002fdc:	00000513          	li	a0,0
    80002fe0:	fffff097          	auipc	ra,0xfffff
    80002fe4:	e88080e7          	jalr	-376(ra) # 80001e68 <_ZN3PCB16createSysProcessEPFvvEPv>
    PCB::running = main;
    80002fe8:	00007797          	auipc	a5,0x7
    80002fec:	3f07b783          	ld	a5,1008(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002ff0:	00a7b023          	sd	a0,0(a5)
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80002ff4:	00000613          	li	a2,0
    80002ff8:	00007597          	auipc	a1,0x7
    80002ffc:	3d05b583          	ld	a1,976(a1) # 8000a3c8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003000:	00007517          	auipc	a0,0x7
    80003004:	41053503          	ld	a0,1040(a0) # 8000a410 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003008:	ffffe097          	auipc	ra,0xffffe
    8000300c:	2f8080e7          	jalr	760(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80003010:	00000613          	li	a2,0
    80003014:	00007597          	auipc	a1,0x7
    80003018:	3f45b583          	ld	a1,1012(a1) # 8000a408 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000301c:	00007517          	auipc	a0,0x7
    80003020:	36c53503          	ld	a0,876(a0) # 8000a388 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003024:	ffffe097          	auipc	ra,0xffffe
    80003028:	2dc080e7          	jalr	732(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    8000302c:	00000613          	li	a2,0
    80003030:	00000597          	auipc	a1,0x0
    80003034:	f1858593          	addi	a1,a1,-232 # 80002f48 <idleProcess>
    80003038:	00007517          	auipc	a0,0x7
    8000303c:	39853503          	ld	a0,920(a0) # 8000a3d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	1c8080e7          	jalr	456(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80003048:	00007797          	auipc	a5,0x7
    8000304c:	3887b783          	ld	a5,904(a5) # 8000a3d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003050:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    80003054:	00100713          	li	a4,1
    80003058:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    8000305c:	00100713          	li	a4,1
    80003060:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    80003064:	00000593          	li	a1,0
    80003068:	00007517          	auipc	a0,0x7
    8000306c:	39853503          	ld	a0,920(a0) # 8000a400 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003070:	ffffe097          	auipc	ra,0xffffe
    80003074:	2e0080e7          	jalr	736(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    80003078:	00000593          	li	a1,0
    8000307c:	00007517          	auipc	a0,0x7
    80003080:	36c53503          	ld	a0,876(a0) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003084:	ffffe097          	auipc	ra,0xffffe
    80003088:	2cc080e7          	jalr	716(ra) # 80001350 <_Z8sem_openPP3SCBj>
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);
    8000308c:	00000593          	li	a1,0
    80003090:	00007517          	auipc	a0,0x7
    80003094:	36053503          	ld	a0,864(a0) # 8000a3f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003098:	ffffe097          	auipc	ra,0xffffe
    8000309c:	2b8080e7          	jalr	696(ra) # 80001350 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800030a0:	00200793          	li	a5,2
    800030a4:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&userProcess, userMainWrapper, nullptr);
    800030a8:	00000613          	li	a2,0
    800030ac:	00000597          	auipc	a1,0x0
    800030b0:	eac58593          	addi	a1,a1,-340 # 80002f58 <_Z15userMainWrapperPv>
    800030b4:	00007517          	auipc	a0,0x7
    800030b8:	47c50513          	addi	a0,a0,1148 # 8000a530 <userProcess>
    800030bc:	ffffe097          	auipc	ra,0xffffe
    800030c0:	244080e7          	jalr	580(ra) # 80001300 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----
    //kmem_cache_info(PCB::pcbCache);
    //kmem_cache_info(SCB::scbCache);
    while(!userProcess->isFinished()) {
    800030c4:	00007797          	auipc	a5,0x7
    800030c8:	46c7b783          	ld	a5,1132(a5) # 8000a530 <userProcess>
        return finished;
    800030cc:	0287c783          	lbu	a5,40(a5)
    800030d0:	00079863          	bnez	a5,800030e0 <main+0x13c>
        thread_dispatch();
    800030d4:	ffffe097          	auipc	ra,0xffffe
    800030d8:	1a0080e7          	jalr	416(ra) # 80001274 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    800030dc:	fe9ff06f          	j	800030c4 <main+0x120>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    800030e0:	00007797          	auipc	a5,0x7
    800030e4:	3087b783          	ld	a5,776(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    800030e8:	0007b783          	ld	a5,0(a5)
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    800030ec:	0107a783          	lw	a5,16(a5)
    800030f0:	00078863          	beqz	a5,80003100 <main+0x15c>
        thread_dispatch();
    800030f4:	ffffe097          	auipc	ra,0xffffe
    800030f8:	180080e7          	jalr	384(ra) # 80001274 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    800030fc:	fe5ff06f          	j	800030e0 <main+0x13c>
    }
    return 0;
    80003100:	00000513          	li	a0,0
    80003104:	00813083          	ld	ra,8(sp)
    80003108:	00013403          	ld	s0,0(sp)
    8000310c:	01010113          	addi	sp,sp,16
    80003110:	00008067          	ret

0000000080003114 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    80003114:	fe010113          	addi	sp,sp,-32
    80003118:	00113c23          	sd	ra,24(sp)
    8000311c:	00813823          	sd	s0,16(sp)
    80003120:	00913423          	sd	s1,8(sp)
    80003124:	02010413          	addi	s0,sp,32
    80003128:	00007797          	auipc	a5,0x7
    8000312c:	1b078793          	addi	a5,a5,432 # 8000a2d8 <_ZTV6Thread+0x10>
    80003130:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80003134:	00853483          	ld	s1,8(a0)
    80003138:	00048e63          	beqz	s1,80003154 <_ZN6ThreadD1Ev+0x40>
    8000313c:	00048513          	mv	a0,s1
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	a98080e7          	jalr	-1384(ra) # 80001bd8 <_ZN3PCBD1Ev>
    80003148:	00048513          	mv	a0,s1
    8000314c:	fffff097          	auipc	ra,0xfffff
    80003150:	b00080e7          	jalr	-1280(ra) # 80001c4c <_ZN3PCBdlEPv>
}
    80003154:	01813083          	ld	ra,24(sp)
    80003158:	01013403          	ld	s0,16(sp)
    8000315c:	00813483          	ld	s1,8(sp)
    80003160:	02010113          	addi	sp,sp,32
    80003164:	00008067          	ret

0000000080003168 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80003168:	ff010113          	addi	sp,sp,-16
    8000316c:	00113423          	sd	ra,8(sp)
    80003170:	00813023          	sd	s0,0(sp)
    80003174:	01010413          	addi	s0,sp,16
    80003178:	00007797          	auipc	a5,0x7
    8000317c:	18878793          	addi	a5,a5,392 # 8000a300 <_ZTV9Semaphore+0x10>
    80003180:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003184:	00853503          	ld	a0,8(a0)
    80003188:	ffffe097          	auipc	ra,0xffffe
    8000318c:	298080e7          	jalr	664(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    80003190:	00813083          	ld	ra,8(sp)
    80003194:	00013403          	ld	s0,0(sp)
    80003198:	01010113          	addi	sp,sp,16
    8000319c:	00008067          	ret

00000000800031a0 <_Znwm>:
void* operator new (size_t size) {
    800031a0:	ff010113          	addi	sp,sp,-16
    800031a4:	00113423          	sd	ra,8(sp)
    800031a8:	00813023          	sd	s0,0(sp)
    800031ac:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800031b0:	ffffe097          	auipc	ra,0xffffe
    800031b4:	fe4080e7          	jalr	-28(ra) # 80001194 <_Z9mem_allocm>
}
    800031b8:	00813083          	ld	ra,8(sp)
    800031bc:	00013403          	ld	s0,0(sp)
    800031c0:	01010113          	addi	sp,sp,16
    800031c4:	00008067          	ret

00000000800031c8 <_Znam>:
void* operator new [](size_t size) {
    800031c8:	ff010113          	addi	sp,sp,-16
    800031cc:	00113423          	sd	ra,8(sp)
    800031d0:	00813023          	sd	s0,0(sp)
    800031d4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800031d8:	ffffe097          	auipc	ra,0xffffe
    800031dc:	fbc080e7          	jalr	-68(ra) # 80001194 <_Z9mem_allocm>
}
    800031e0:	00813083          	ld	ra,8(sp)
    800031e4:	00013403          	ld	s0,0(sp)
    800031e8:	01010113          	addi	sp,sp,16
    800031ec:	00008067          	ret

00000000800031f0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800031f0:	ff010113          	addi	sp,sp,-16
    800031f4:	00113423          	sd	ra,8(sp)
    800031f8:	00813023          	sd	s0,0(sp)
    800031fc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80003200:	ffffe097          	auipc	ra,0xffffe
    80003204:	fd4080e7          	jalr	-44(ra) # 800011d4 <_Z8mem_freePv>
}
    80003208:	00813083          	ld	ra,8(sp)
    8000320c:	00013403          	ld	s0,0(sp)
    80003210:	01010113          	addi	sp,sp,16
    80003214:	00008067          	ret

0000000080003218 <_Z13threadWrapperPv>:
    if(!tArg) return;
    80003218:	06050263          	beqz	a0,8000327c <_Z13threadWrapperPv+0x64>
void threadWrapper(void* thread) {
    8000321c:	fe010113          	addi	sp,sp,-32
    80003220:	00113c23          	sd	ra,24(sp)
    80003224:	00813823          	sd	s0,16(sp)
    80003228:	00913423          	sd	s1,8(sp)
    8000322c:	02010413          	addi	s0,sp,32
    80003230:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    80003234:	00053503          	ld	a0,0(a0)
    80003238:	0104b783          	ld	a5,16(s1)
    8000323c:	00f50533          	add	a0,a0,a5
    80003240:	0084b783          	ld	a5,8(s1)
    80003244:	0017f713          	andi	a4,a5,1
    80003248:	00070863          	beqz	a4,80003258 <_Z13threadWrapperPv+0x40>
    8000324c:	00053703          	ld	a4,0(a0)
    80003250:	00f707b3          	add	a5,a4,a5
    80003254:	fff7b783          	ld	a5,-1(a5)
    80003258:	000780e7          	jalr	a5
    delete tArg;
    8000325c:	00048513          	mv	a0,s1
    80003260:	00000097          	auipc	ra,0x0
    80003264:	f90080e7          	jalr	-112(ra) # 800031f0 <_ZdlPv>
}
    80003268:	01813083          	ld	ra,24(sp)
    8000326c:	01013403          	ld	s0,16(sp)
    80003270:	00813483          	ld	s1,8(sp)
    80003274:	02010113          	addi	sp,sp,32
    80003278:	00008067          	ret
    8000327c:	00008067          	ret

0000000080003280 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80003280:	ff010113          	addi	sp,sp,-16
    80003284:	00113423          	sd	ra,8(sp)
    80003288:	00813023          	sd	s0,0(sp)
    8000328c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80003290:	ffffe097          	auipc	ra,0xffffe
    80003294:	f44080e7          	jalr	-188(ra) # 800011d4 <_Z8mem_freePv>
}
    80003298:	00813083          	ld	ra,8(sp)
    8000329c:	00013403          	ld	s0,0(sp)
    800032a0:	01010113          	addi	sp,sp,16
    800032a4:	00008067          	ret

00000000800032a8 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800032a8:	ff010113          	addi	sp,sp,-16
    800032ac:	00113423          	sd	ra,8(sp)
    800032b0:	00813023          	sd	s0,0(sp)
    800032b4:	01010413          	addi	s0,sp,16
    800032b8:	00007797          	auipc	a5,0x7
    800032bc:	02078793          	addi	a5,a5,32 # 8000a2d8 <_ZTV6Thread+0x10>
    800032c0:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    800032c4:	00850513          	addi	a0,a0,8
    800032c8:	ffffe097          	auipc	ra,0xffffe
    800032cc:	f40080e7          	jalr	-192(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800032d0:	00813083          	ld	ra,8(sp)
    800032d4:	00013403          	ld	s0,0(sp)
    800032d8:	01010113          	addi	sp,sp,16
    800032dc:	00008067          	ret

00000000800032e0 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    800032e0:	ff010113          	addi	sp,sp,-16
    800032e4:	00113423          	sd	ra,8(sp)
    800032e8:	00813023          	sd	s0,0(sp)
    800032ec:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800032f0:	00001097          	auipc	ra,0x1
    800032f4:	2e4080e7          	jalr	740(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
}
    800032f8:	00813083          	ld	ra,8(sp)
    800032fc:	00013403          	ld	s0,0(sp)
    80003300:	01010113          	addi	sp,sp,16
    80003304:	00008067          	ret

0000000080003308 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80003308:	ff010113          	addi	sp,sp,-16
    8000330c:	00113423          	sd	ra,8(sp)
    80003310:	00813023          	sd	s0,0(sp)
    80003314:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003318:	00001097          	auipc	ra,0x1
    8000331c:	450080e7          	jalr	1104(ra) # 80004768 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003320:	00813083          	ld	ra,8(sp)
    80003324:	00013403          	ld	s0,0(sp)
    80003328:	01010113          	addi	sp,sp,16
    8000332c:	00008067          	ret

0000000080003330 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003330:	fe010113          	addi	sp,sp,-32
    80003334:	00113c23          	sd	ra,24(sp)
    80003338:	00813823          	sd	s0,16(sp)
    8000333c:	00913423          	sd	s1,8(sp)
    80003340:	02010413          	addi	s0,sp,32
    80003344:	00050493          	mv	s1,a0
}
    80003348:	00000097          	auipc	ra,0x0
    8000334c:	dcc080e7          	jalr	-564(ra) # 80003114 <_ZN6ThreadD1Ev>
    80003350:	00048513          	mv	a0,s1
    80003354:	00000097          	auipc	ra,0x0
    80003358:	fb4080e7          	jalr	-76(ra) # 80003308 <_ZN6ThreaddlEPv>
    8000335c:	01813083          	ld	ra,24(sp)
    80003360:	01013403          	ld	s0,16(sp)
    80003364:	00813483          	ld	s1,8(sp)
    80003368:	02010113          	addi	sp,sp,32
    8000336c:	00008067          	ret

0000000080003370 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003370:	ff010113          	addi	sp,sp,-16
    80003374:	00113423          	sd	ra,8(sp)
    80003378:	00813023          	sd	s0,0(sp)
    8000337c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003380:	ffffe097          	auipc	ra,0xffffe
    80003384:	ef4080e7          	jalr	-268(ra) # 80001274 <_Z15thread_dispatchv>
}
    80003388:	00813083          	ld	ra,8(sp)
    8000338c:	00013403          	ld	s0,0(sp)
    80003390:	01010113          	addi	sp,sp,16
    80003394:	00008067          	ret

0000000080003398 <_ZN6Thread5startEv>:
int Thread::start() {
    80003398:	ff010113          	addi	sp,sp,-16
    8000339c:	00113423          	sd	ra,8(sp)
    800033a0:	00813023          	sd	s0,0(sp)
    800033a4:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    800033a8:	00850513          	addi	a0,a0,8
    800033ac:	ffffe097          	auipc	ra,0xffffe
    800033b0:	f24080e7          	jalr	-220(ra) # 800012d0 <_Z12thread_startPP3PCB>
}
    800033b4:	00000513          	li	a0,0
    800033b8:	00813083          	ld	ra,8(sp)
    800033bc:	00013403          	ld	s0,0(sp)
    800033c0:	01010113          	addi	sp,sp,16
    800033c4:	00008067          	ret

00000000800033c8 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800033c8:	fe010113          	addi	sp,sp,-32
    800033cc:	00113c23          	sd	ra,24(sp)
    800033d0:	00813823          	sd	s0,16(sp)
    800033d4:	00913423          	sd	s1,8(sp)
    800033d8:	02010413          	addi	s0,sp,32
    800033dc:	00050493          	mv	s1,a0
    800033e0:	00007797          	auipc	a5,0x7
    800033e4:	ef878793          	addi	a5,a5,-264 # 8000a2d8 <_ZTV6Thread+0x10>
    800033e8:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    800033ec:	01800513          	li	a0,24
    800033f0:	00000097          	auipc	ra,0x0
    800033f4:	db0080e7          	jalr	-592(ra) # 800031a0 <_Znwm>
    800033f8:	00050613          	mv	a2,a0
    800033fc:	00050a63          	beqz	a0,80003410 <_ZN6ThreadC1Ev+0x48>
    80003400:	00953023          	sd	s1,0(a0)
    80003404:	01100793          	li	a5,17
    80003408:	00f53423          	sd	a5,8(a0)
    8000340c:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80003410:	00000597          	auipc	a1,0x0
    80003414:	e0858593          	addi	a1,a1,-504 # 80003218 <_Z13threadWrapperPv>
    80003418:	00848513          	addi	a0,s1,8
    8000341c:	ffffe097          	auipc	ra,0xffffe
    80003420:	dec080e7          	jalr	-532(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80003424:	01813083          	ld	ra,24(sp)
    80003428:	01013403          	ld	s0,16(sp)
    8000342c:	00813483          	ld	s1,8(sp)
    80003430:	02010113          	addi	sp,sp,32
    80003434:	00008067          	ret

0000000080003438 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003438:	ff010113          	addi	sp,sp,-16
    8000343c:	00113423          	sd	ra,8(sp)
    80003440:	00813023          	sd	s0,0(sp)
    80003444:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003448:	ffffe097          	auipc	ra,0xffffe
    8000344c:	018080e7          	jalr	24(ra) # 80001460 <_Z10time_sleepm>
}
    80003450:	00813083          	ld	ra,8(sp)
    80003454:	00013403          	ld	s0,0(sp)
    80003458:	01010113          	addi	sp,sp,16
    8000345c:	00008067          	ret

0000000080003460 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80003460:	fe010113          	addi	sp,sp,-32
    80003464:	00113c23          	sd	ra,24(sp)
    80003468:	00813823          	sd	s0,16(sp)
    8000346c:	00913423          	sd	s1,8(sp)
    80003470:	02010413          	addi	s0,sp,32
    80003474:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80003478:	0200006f          	j	80003498 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    8000347c:	00053703          	ld	a4,0(a0)
    80003480:	00f707b3          	add	a5,a4,a5
    80003484:	fff7b783          	ld	a5,-1(a5)
    80003488:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    8000348c:	0184b503          	ld	a0,24(s1)
    80003490:	00000097          	auipc	ra,0x0
    80003494:	fa8080e7          	jalr	-88(ra) # 80003438 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80003498:	0004b503          	ld	a0,0(s1)
    8000349c:	0104b783          	ld	a5,16(s1)
    800034a0:	00f50533          	add	a0,a0,a5
    800034a4:	0084b783          	ld	a5,8(s1)
    800034a8:	0017f713          	andi	a4,a5,1
    800034ac:	fc070ee3          	beqz	a4,80003488 <_Z21periodicThreadWrapperPv+0x28>
    800034b0:	fcdff06f          	j	8000347c <_Z21periodicThreadWrapperPv+0x1c>

00000000800034b4 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800034b4:	fe010113          	addi	sp,sp,-32
    800034b8:	00113c23          	sd	ra,24(sp)
    800034bc:	00813823          	sd	s0,16(sp)
    800034c0:	00913423          	sd	s1,8(sp)
    800034c4:	02010413          	addi	s0,sp,32
    800034c8:	00050493          	mv	s1,a0
    800034cc:	00007797          	auipc	a5,0x7
    800034d0:	e3478793          	addi	a5,a5,-460 # 8000a300 <_ZTV9Semaphore+0x10>
    800034d4:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    800034d8:	00058513          	mv	a0,a1
    800034dc:	00000097          	auipc	ra,0x0
    800034e0:	51c080e7          	jalr	1308(ra) # 800039f8 <_ZN3SCB15createSemaphoreEi>
    800034e4:	00a4b423          	sd	a0,8(s1)
}
    800034e8:	01813083          	ld	ra,24(sp)
    800034ec:	01013403          	ld	s0,16(sp)
    800034f0:	00813483          	ld	s1,8(sp)
    800034f4:	02010113          	addi	sp,sp,32
    800034f8:	00008067          	ret

00000000800034fc <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800034fc:	ff010113          	addi	sp,sp,-16
    80003500:	00113423          	sd	ra,8(sp)
    80003504:	00813023          	sd	s0,0(sp)
    80003508:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    8000350c:	00853503          	ld	a0,8(a0)
    80003510:	ffffe097          	auipc	ra,0xffffe
    80003514:	e88080e7          	jalr	-376(ra) # 80001398 <_Z8sem_waitP3SCB>
}
    80003518:	00813083          	ld	ra,8(sp)
    8000351c:	00013403          	ld	s0,0(sp)
    80003520:	01010113          	addi	sp,sp,16
    80003524:	00008067          	ret

0000000080003528 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003528:	ff010113          	addi	sp,sp,-16
    8000352c:	00113423          	sd	ra,8(sp)
    80003530:	00813023          	sd	s0,0(sp)
    80003534:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003538:	00853503          	ld	a0,8(a0)
    8000353c:	ffffe097          	auipc	ra,0xffffe
    80003540:	ea4080e7          	jalr	-348(ra) # 800013e0 <_Z10sem_signalP3SCB>
}
    80003544:	00813083          	ld	ra,8(sp)
    80003548:	00013403          	ld	s0,0(sp)
    8000354c:	01010113          	addi	sp,sp,16
    80003550:	00008067          	ret

0000000080003554 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80003554:	ff010113          	addi	sp,sp,-16
    80003558:	00113423          	sd	ra,8(sp)
    8000355c:	00813023          	sd	s0,0(sp)
    80003560:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003564:	00001097          	auipc	ra,0x1
    80003568:	204080e7          	jalr	516(ra) # 80004768 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000356c:	00813083          	ld	ra,8(sp)
    80003570:	00013403          	ld	s0,0(sp)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    8000357c:	fe010113          	addi	sp,sp,-32
    80003580:	00113c23          	sd	ra,24(sp)
    80003584:	00813823          	sd	s0,16(sp)
    80003588:	00913423          	sd	s1,8(sp)
    8000358c:	02010413          	addi	s0,sp,32
    80003590:	00050493          	mv	s1,a0
}
    80003594:	00000097          	auipc	ra,0x0
    80003598:	bd4080e7          	jalr	-1068(ra) # 80003168 <_ZN9SemaphoreD1Ev>
    8000359c:	00048513          	mv	a0,s1
    800035a0:	00000097          	auipc	ra,0x0
    800035a4:	fb4080e7          	jalr	-76(ra) # 80003554 <_ZN9SemaphoredlEPv>
    800035a8:	01813083          	ld	ra,24(sp)
    800035ac:	01013403          	ld	s0,16(sp)
    800035b0:	00813483          	ld	s1,8(sp)
    800035b4:	02010113          	addi	sp,sp,32
    800035b8:	00008067          	ret

00000000800035bc <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    800035bc:	ff010113          	addi	sp,sp,-16
    800035c0:	00113423          	sd	ra,8(sp)
    800035c4:	00813023          	sd	s0,0(sp)
    800035c8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800035cc:	00001097          	auipc	ra,0x1
    800035d0:	008080e7          	jalr	8(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
}
    800035d4:	00813083          	ld	ra,8(sp)
    800035d8:	00013403          	ld	s0,0(sp)
    800035dc:	01010113          	addi	sp,sp,16
    800035e0:	00008067          	ret

00000000800035e4 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    800035e4:	fe010113          	addi	sp,sp,-32
    800035e8:	00113c23          	sd	ra,24(sp)
    800035ec:	00813823          	sd	s0,16(sp)
    800035f0:	00913423          	sd	s1,8(sp)
    800035f4:	01213023          	sd	s2,0(sp)
    800035f8:	02010413          	addi	s0,sp,32
    800035fc:	00050493          	mv	s1,a0
    80003600:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    80003604:	02000513          	li	a0,32
    80003608:	00000097          	auipc	ra,0x0
    8000360c:	b98080e7          	jalr	-1128(ra) # 800031a0 <_Znwm>
    80003610:	00050613          	mv	a2,a0
    80003614:	00050c63          	beqz	a0,8000362c <_ZN14PeriodicThreadC1Em+0x48>
    80003618:	00953023          	sd	s1,0(a0)
    8000361c:	01900793          	li	a5,25
    80003620:	00f53423          	sd	a5,8(a0)
    80003624:	00053823          	sd	zero,16(a0)
    80003628:	01253c23          	sd	s2,24(a0)
    8000362c:	00000597          	auipc	a1,0x0
    80003630:	e3458593          	addi	a1,a1,-460 # 80003460 <_Z21periodicThreadWrapperPv>
    80003634:	00048513          	mv	a0,s1
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	c70080e7          	jalr	-912(ra) # 800032a8 <_ZN6ThreadC1EPFvPvES0_>
    80003640:	00007797          	auipc	a5,0x7
    80003644:	c6878793          	addi	a5,a5,-920 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    80003648:	00f4b023          	sd	a5,0(s1)
{}
    8000364c:	01813083          	ld	ra,24(sp)
    80003650:	01013403          	ld	s0,16(sp)
    80003654:	00813483          	ld	s1,8(sp)
    80003658:	00013903          	ld	s2,0(sp)
    8000365c:	02010113          	addi	sp,sp,32
    80003660:	00008067          	ret

0000000080003664 <_ZN7Console4getcEv>:


char Console::getc() {
    80003664:	ff010113          	addi	sp,sp,-16
    80003668:	00113423          	sd	ra,8(sp)
    8000366c:	00813023          	sd	s0,0(sp)
    80003670:	01010413          	addi	s0,sp,16
    return ::getc();
    80003674:	ffffe097          	auipc	ra,0xffffe
    80003678:	e34080e7          	jalr	-460(ra) # 800014a8 <_Z4getcv>
}
    8000367c:	00813083          	ld	ra,8(sp)
    80003680:	00013403          	ld	s0,0(sp)
    80003684:	01010113          	addi	sp,sp,16
    80003688:	00008067          	ret

000000008000368c <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000368c:	ff010113          	addi	sp,sp,-16
    80003690:	00113423          	sd	ra,8(sp)
    80003694:	00813023          	sd	s0,0(sp)
    80003698:	01010413          	addi	s0,sp,16
    return ::putc(c);
    8000369c:	ffffe097          	auipc	ra,0xffffe
    800036a0:	e3c080e7          	jalr	-452(ra) # 800014d8 <_Z4putcc>
}
    800036a4:	00813083          	ld	ra,8(sp)
    800036a8:	00013403          	ld	s0,0(sp)
    800036ac:	01010113          	addi	sp,sp,16
    800036b0:	00008067          	ret

00000000800036b4 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    800036b4:	ff010113          	addi	sp,sp,-16
    800036b8:	00813423          	sd	s0,8(sp)
    800036bc:	01010413          	addi	s0,sp,16
    800036c0:	00813403          	ld	s0,8(sp)
    800036c4:	01010113          	addi	sp,sp,16
    800036c8:	00008067          	ret

00000000800036cc <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    800036cc:	ff010113          	addi	sp,sp,-16
    800036d0:	00813423          	sd	s0,8(sp)
    800036d4:	01010413          	addi	s0,sp,16
    800036d8:	00813403          	ld	s0,8(sp)
    800036dc:	01010113          	addi	sp,sp,16
    800036e0:	00008067          	ret

00000000800036e4 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800036e4:	ff010113          	addi	sp,sp,-16
    800036e8:	00113423          	sd	ra,8(sp)
    800036ec:	00813023          	sd	s0,0(sp)
    800036f0:	01010413          	addi	s0,sp,16
    800036f4:	00007797          	auipc	a5,0x7
    800036f8:	bb478793          	addi	a5,a5,-1100 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    800036fc:	00f53023          	sd	a5,0(a0)
    80003700:	00000097          	auipc	ra,0x0
    80003704:	a14080e7          	jalr	-1516(ra) # 80003114 <_ZN6ThreadD1Ev>
    80003708:	00813083          	ld	ra,8(sp)
    8000370c:	00013403          	ld	s0,0(sp)
    80003710:	01010113          	addi	sp,sp,16
    80003714:	00008067          	ret

0000000080003718 <_ZN14PeriodicThreadD0Ev>:
    80003718:	fe010113          	addi	sp,sp,-32
    8000371c:	00113c23          	sd	ra,24(sp)
    80003720:	00813823          	sd	s0,16(sp)
    80003724:	00913423          	sd	s1,8(sp)
    80003728:	02010413          	addi	s0,sp,32
    8000372c:	00050493          	mv	s1,a0
    80003730:	00007797          	auipc	a5,0x7
    80003734:	b7878793          	addi	a5,a5,-1160 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    80003738:	00f53023          	sd	a5,0(a0)
    8000373c:	00000097          	auipc	ra,0x0
    80003740:	9d8080e7          	jalr	-1576(ra) # 80003114 <_ZN6ThreadD1Ev>
    80003744:	00048513          	mv	a0,s1
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	bc0080e7          	jalr	-1088(ra) # 80003308 <_ZN6ThreaddlEPv>
    80003750:	01813083          	ld	ra,24(sp)
    80003754:	01013403          	ld	s0,16(sp)
    80003758:	00813483          	ld	s1,8(sp)
    8000375c:	02010113          	addi	sp,sp,32
    80003760:	00008067          	ret

0000000080003764 <_ZN3SCB5blockEv>:
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

kmem_cache_t* SCB::scbCache = nullptr;

void SCB::block() {
    80003764:	ff010113          	addi	sp,sp,-16
    80003768:	00813423          	sd	s0,8(sp)
    8000376c:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80003770:	00007797          	auipc	a5,0x7
    80003774:	c687b783          	ld	a5,-920(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003778:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    8000377c:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80003780:	00853783          	ld	a5,8(a0)
    80003784:	04078063          	beqz	a5,800037c4 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80003788:	00007717          	auipc	a4,0x7
    8000378c:	c5073703          	ld	a4,-944(a4) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003790:	00073703          	ld	a4,0(a4)
    80003794:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80003798:	00853783          	ld	a5,8(a0)
        return nextInList;
    8000379c:	0007b783          	ld	a5,0(a5)
    800037a0:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    800037a4:	00007797          	auipc	a5,0x7
    800037a8:	c347b783          	ld	a5,-972(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037ac:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    800037b0:	00100713          	li	a4,1
    800037b4:	02e784a3          	sb	a4,41(a5)
}
    800037b8:	00813403          	ld	s0,8(sp)
    800037bc:	01010113          	addi	sp,sp,16
    800037c0:	00008067          	ret
        head = tail = PCB::running;
    800037c4:	00007797          	auipc	a5,0x7
    800037c8:	c147b783          	ld	a5,-1004(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037cc:	0007b783          	ld	a5,0(a5)
    800037d0:	00f53423          	sd	a5,8(a0)
    800037d4:	00f53023          	sd	a5,0(a0)
    800037d8:	fcdff06f          	j	800037a4 <_ZN3SCB5blockEv+0x40>

00000000800037dc <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800037dc:	ff010113          	addi	sp,sp,-16
    800037e0:	00813423          	sd	s0,8(sp)
    800037e4:	01010413          	addi	s0,sp,16
    800037e8:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800037ec:	00053503          	ld	a0,0(a0)
    800037f0:	00050e63          	beqz	a0,8000380c <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800037f4:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800037f8:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800037fc:	0087b683          	ld	a3,8(a5)
    80003800:	00d50c63          	beq	a0,a3,80003818 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80003804:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80003808:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    8000380c:	00813403          	ld	s0,8(sp)
    80003810:	01010113          	addi	sp,sp,16
    80003814:	00008067          	ret
        tail = head;
    80003818:	00e7b423          	sd	a4,8(a5)
    8000381c:	fe9ff06f          	j	80003804 <_ZN3SCB7unblockEv+0x28>

0000000080003820 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003820:	01052783          	lw	a5,16(a0)
    80003824:	fff7879b          	addiw	a5,a5,-1
    80003828:	00f52823          	sw	a5,16(a0)
    8000382c:	02079713          	slli	a4,a5,0x20
    80003830:	02074063          	bltz	a4,80003850 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80003834:	00007797          	auipc	a5,0x7
    80003838:	ba47b783          	ld	a5,-1116(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000383c:	0007b783          	ld	a5,0(a5)
    80003840:	02a7c783          	lbu	a5,42(a5)
    80003844:	06079463          	bnez	a5,800038ac <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003848:	00000513          	li	a0,0
    8000384c:	00008067          	ret
int SCB::wait() {
    80003850:	ff010113          	addi	sp,sp,-16
    80003854:	00113423          	sd	ra,8(sp)
    80003858:	00813023          	sd	s0,0(sp)
    8000385c:	01010413          	addi	s0,sp,16
        block();
    80003860:	00000097          	auipc	ra,0x0
    80003864:	f04080e7          	jalr	-252(ra) # 80003764 <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80003868:	00007797          	auipc	a5,0x7
    8000386c:	b507b783          	ld	a5,-1200(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003870:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80003874:	ffffe097          	auipc	ra,0xffffe
    80003878:	2d4080e7          	jalr	724(ra) # 80001b48 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000387c:	00007797          	auipc	a5,0x7
    80003880:	b5c7b783          	ld	a5,-1188(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003884:	0007b783          	ld	a5,0(a5)
    80003888:	02a7c783          	lbu	a5,42(a5)
    8000388c:	00079c63          	bnez	a5,800038a4 <_ZN3SCB4waitEv+0x84>
    return 0;
    80003890:	00000513          	li	a0,0

}
    80003894:	00813083          	ld	ra,8(sp)
    80003898:	00013403          	ld	s0,0(sp)
    8000389c:	01010113          	addi	sp,sp,16
    800038a0:	00008067          	ret
        return -2;
    800038a4:	ffe00513          	li	a0,-2
    800038a8:	fedff06f          	j	80003894 <_ZN3SCB4waitEv+0x74>
    800038ac:	ffe00513          	li	a0,-2
}
    800038b0:	00008067          	ret

00000000800038b4 <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    800038b4:	01052783          	lw	a5,16(a0)
    800038b8:	0017879b          	addiw	a5,a5,1
    800038bc:	0007871b          	sext.w	a4,a5
    800038c0:	00f52823          	sw	a5,16(a0)
    800038c4:	00e05463          	blez	a4,800038cc <_ZN3SCB6signalEv+0x18>
    800038c8:	00008067          	ret
void SCB::signal() {
    800038cc:	ff010113          	addi	sp,sp,-16
    800038d0:	00113423          	sd	ra,8(sp)
    800038d4:	00813023          	sd	s0,0(sp)
    800038d8:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800038dc:	00000097          	auipc	ra,0x0
    800038e0:	f00080e7          	jalr	-256(ra) # 800037dc <_ZN3SCB7unblockEv>
    800038e4:	fffff097          	auipc	ra,0xfffff
    800038e8:	570080e7          	jalr	1392(ra) # 80002e54 <_ZN9Scheduler3putEP3PCB>
    }

}
    800038ec:	00813083          	ld	ra,8(sp)
    800038f0:	00013403          	ld	s0,0(sp)
    800038f4:	01010113          	addi	sp,sp,16
    800038f8:	00008067          	ret

00000000800038fc <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    800038fc:	01052783          	lw	a5,16(a0)
    80003900:	0017879b          	addiw	a5,a5,1
    80003904:	0007871b          	sext.w	a4,a5
    80003908:	00f52823          	sw	a5,16(a0)
    8000390c:	00e05463          	blez	a4,80003914 <_ZN3SCB14prioritySignalEv+0x18>
    80003910:	00008067          	ret
void SCB::prioritySignal() {
    80003914:	ff010113          	addi	sp,sp,-16
    80003918:	00113423          	sd	ra,8(sp)
    8000391c:	00813023          	sd	s0,0(sp)
    80003920:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    80003924:	00000097          	auipc	ra,0x0
    80003928:	eb8080e7          	jalr	-328(ra) # 800037dc <_ZN3SCB7unblockEv>
    8000392c:	fffff097          	auipc	ra,0xfffff
    80003930:	5d4080e7          	jalr	1492(ra) # 80002f00 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    80003934:	00813083          	ld	ra,8(sp)
    80003938:	00013403          	ld	s0,0(sp)
    8000393c:	01010113          	addi	sp,sp,16
    80003940:	00008067          	ret

0000000080003944 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80003944:	ff010113          	addi	sp,sp,-16
    80003948:	00113423          	sd	ra,8(sp)
    8000394c:	00813023          	sd	s0,0(sp)
    80003950:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80003954:	00001097          	auipc	ra,0x1
    80003958:	c80080e7          	jalr	-896(ra) # 800045d4 <_ZN15MemoryAllocator9mem_allocEm>
}
    8000395c:	00813083          	ld	ra,8(sp)
    80003960:	00013403          	ld	s0,0(sp)
    80003964:	01010113          	addi	sp,sp,16
    80003968:	00008067          	ret

000000008000396c <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    8000396c:	ff010113          	addi	sp,sp,-16
    80003970:	00113423          	sd	ra,8(sp)
    80003974:	00813023          	sd	s0,0(sp)
    80003978:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    8000397c:	00001097          	auipc	ra,0x1
    80003980:	dec080e7          	jalr	-532(ra) # 80004768 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003984:	00813083          	ld	ra,8(sp)
    80003988:	00013403          	ld	s0,0(sp)
    8000398c:	01010113          	addi	sp,sp,16
    80003990:	00008067          	ret

0000000080003994 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80003994:	fe010113          	addi	sp,sp,-32
    80003998:	00113c23          	sd	ra,24(sp)
    8000399c:	00813823          	sd	s0,16(sp)
    800039a0:	00913423          	sd	s1,8(sp)
    800039a4:	01213023          	sd	s2,0(sp)
    800039a8:	02010413          	addi	s0,sp,32
    800039ac:	00050913          	mv	s2,a0
    PCB* curr = head;
    800039b0:	00053503          	ld	a0,0(a0)
    while(curr) {
    800039b4:	02050263          	beqz	a0,800039d8 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800039b8:	00100793          	li	a5,1
    800039bc:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800039c0:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800039c4:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800039c8:	fffff097          	auipc	ra,0xfffff
    800039cc:	48c080e7          	jalr	1164(ra) # 80002e54 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800039d0:	00048513          	mv	a0,s1
    while(curr) {
    800039d4:	fe1ff06f          	j	800039b4 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    800039d8:	00093423          	sd	zero,8(s2)
    800039dc:	00093023          	sd	zero,0(s2)
}
    800039e0:	01813083          	ld	ra,24(sp)
    800039e4:	01013403          	ld	s0,16(sp)
    800039e8:	00813483          	ld	s1,8(sp)
    800039ec:	00013903          	ld	s2,0(sp)
    800039f0:	02010113          	addi	sp,sp,32
    800039f4:	00008067          	ret

00000000800039f8 <_ZN3SCB15createSemaphoreEi>:
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    object->scbInit(semValue);
    return object;
}

SCB *SCB::createSemaphore(int semValue) {
    800039f8:	fe010113          	addi	sp,sp,-32
    800039fc:	00113c23          	sd	ra,24(sp)
    80003a00:	00813823          	sd	s0,16(sp)
    80003a04:	00913423          	sd	s1,8(sp)
    80003a08:	02010413          	addi	s0,sp,32
    80003a0c:	00050493          	mv	s1,a0
    return new SCB(semValue);
    80003a10:	01800513          	li	a0,24
    80003a14:	00000097          	auipc	ra,0x0
    80003a18:	f30080e7          	jalr	-208(ra) # 80003944 <_ZN3SCBnwEm>
    80003a1c:	00050863          	beqz	a0,80003a2c <_ZN3SCB15createSemaphoreEi+0x34>
    static kmem_cache_t* scbCache;//TODO private
    static void initSCBCache();
private:

    void scbInit(int semValue);
    SCB(int semValue_ = 1) {
    80003a20:	00053023          	sd	zero,0(a0)
    80003a24:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80003a28:	00952823          	sw	s1,16(a0)
}
    80003a2c:	01813083          	ld	ra,24(sp)
    80003a30:	01013403          	ld	s0,16(sp)
    80003a34:	00813483          	ld	s1,8(sp)
    80003a38:	02010113          	addi	sp,sp,32
    80003a3c:	00008067          	ret

0000000080003a40 <_ZN3SCB7scbInitEi>:

void SCB::scbInit(int semValue_) {
    80003a40:	ff010113          	addi	sp,sp,-16
    80003a44:	00813423          	sd	s0,8(sp)
    80003a48:	01010413          	addi	s0,sp,16
    head = tail = nullptr;
    80003a4c:	00053423          	sd	zero,8(a0)
    80003a50:	00053023          	sd	zero,0(a0)
    semValue = semValue_;
    80003a54:	00b52823          	sw	a1,16(a0)
}
    80003a58:	00813403          	ld	s0,8(sp)
    80003a5c:	01010113          	addi	sp,sp,16
    80003a60:	00008067          	ret

0000000080003a64 <_ZN3SCB12initSCBCacheEv>:

void SCB::initSCBCache() {
    80003a64:	ff010113          	addi	sp,sp,-16
    80003a68:	00113423          	sd	ra,8(sp)
    80003a6c:	00813023          	sd	s0,0(sp)
    80003a70:	01010413          	addi	s0,sp,16
    scbCache = kmem_cache_create("SCB", sizeof(SCB), &createObject, &freeObject);
    80003a74:	00000697          	auipc	a3,0x0
    80003a78:	0c468693          	addi	a3,a3,196 # 80003b38 <_ZN3SCB10freeObjectEPv>
    80003a7c:	00000617          	auipc	a2,0x0
    80003a80:	0a460613          	addi	a2,a2,164 # 80003b20 <_ZN3SCB12createObjectEPv>
    80003a84:	01800593          	li	a1,24
    80003a88:	00004517          	auipc	a0,0x4
    80003a8c:	70850513          	addi	a0,a0,1800 # 80008190 <CONSOLE_STATUS+0x180>
    80003a90:	00001097          	auipc	ra,0x1
    80003a94:	edc080e7          	jalr	-292(ra) # 8000496c <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003a98:	00007797          	auipc	a5,0x7
    80003a9c:	aaa7b023          	sd	a0,-1376(a5) # 8000a538 <_ZN3SCB8scbCacheE>
}
    80003aa0:	00813083          	ld	ra,8(sp)
    80003aa4:	00013403          	ld	s0,0(sp)
    80003aa8:	01010113          	addi	sp,sp,16
    80003aac:	00008067          	ret

0000000080003ab0 <_ZN3SCB18createSysSemaphoreEi>:
SCB *SCB::createSysSemaphore(int semValue) {
    80003ab0:	fe010113          	addi	sp,sp,-32
    80003ab4:	00113c23          	sd	ra,24(sp)
    80003ab8:	00813823          	sd	s0,16(sp)
    80003abc:	00913423          	sd	s1,8(sp)
    80003ac0:	01213023          	sd	s2,0(sp)
    80003ac4:	02010413          	addi	s0,sp,32
    80003ac8:	00050913          	mv	s2,a0
    if(!scbCache) initSCBCache();
    80003acc:	00007797          	auipc	a5,0x7
    80003ad0:	a6c7b783          	ld	a5,-1428(a5) # 8000a538 <_ZN3SCB8scbCacheE>
    80003ad4:	04078063          	beqz	a5,80003b14 <_ZN3SCB18createSysSemaphoreEi+0x64>
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    80003ad8:	00007517          	auipc	a0,0x7
    80003adc:	a6053503          	ld	a0,-1440(a0) # 8000a538 <_ZN3SCB8scbCacheE>
    80003ae0:	00001097          	auipc	ra,0x1
    80003ae4:	edc080e7          	jalr	-292(ra) # 800049bc <_Z16kmem_cache_allocP12kmem_cache_s>
    80003ae8:	00050493          	mv	s1,a0
    object->scbInit(semValue);
    80003aec:	00090593          	mv	a1,s2
    80003af0:	00000097          	auipc	ra,0x0
    80003af4:	f50080e7          	jalr	-176(ra) # 80003a40 <_ZN3SCB7scbInitEi>
}
    80003af8:	00048513          	mv	a0,s1
    80003afc:	01813083          	ld	ra,24(sp)
    80003b00:	01013403          	ld	s0,16(sp)
    80003b04:	00813483          	ld	s1,8(sp)
    80003b08:	00013903          	ld	s2,0(sp)
    80003b0c:	02010113          	addi	sp,sp,32
    80003b10:	00008067          	ret
    if(!scbCache) initSCBCache();
    80003b14:	00000097          	auipc	ra,0x0
    80003b18:	f50080e7          	jalr	-176(ra) # 80003a64 <_ZN3SCB12initSCBCacheEv>
    80003b1c:	fbdff06f          	j	80003ad8 <_ZN3SCB18createSysSemaphoreEi+0x28>

0000000080003b20 <_ZN3SCB12createObjectEPv>:
    static void createObject(void* addr) {}
    80003b20:	ff010113          	addi	sp,sp,-16
    80003b24:	00813423          	sd	s0,8(sp)
    80003b28:	01010413          	addi	s0,sp,16
    80003b2c:	00813403          	ld	s0,8(sp)
    80003b30:	01010113          	addi	sp,sp,16
    80003b34:	00008067          	ret

0000000080003b38 <_ZN3SCB10freeObjectEPv>:
    static void freeObject(void* addr) {}
    80003b38:	ff010113          	addi	sp,sp,-16
    80003b3c:	00813423          	sd	s0,8(sp)
    80003b40:	01010413          	addi	s0,sp,16
    80003b44:	00813403          	ld	s0,8(sp)
    80003b48:	01010113          	addi	sp,sp,16
    80003b4c:	00008067          	ret

0000000080003b50 <_ZN5Cache11getNumSlotsEmm>:
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima

    optimalSlots = getNumSlots(slabSize, slotSize);
}

int Cache::getNumSlots(size_t slabSize, size_t objSize) {
    80003b50:	ff010113          	addi	sp,sp,-16
    80003b54:	00813423          	sd	s0,8(sp)
    80003b58:	01010413          	addi	s0,sp,16
    return (slabSize*BLKSIZE - sizeof(Slab)) / objSize;
    80003b5c:	00c51513          	slli	a0,a0,0xc
    80003b60:	fd850513          	addi	a0,a0,-40
    80003b64:	02b55533          	divu	a0,a0,a1
}
    80003b68:	0005051b          	sext.w	a0,a0
    80003b6c:	00813403          	ld	s0,8(sp)
    80003b70:	01010113          	addi	sp,sp,16
    80003b74:	00008067          	ret

0000000080003b78 <_ZN5Cache11slabListPutEPNS_4SlabEi>:

    return slab;
}


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    80003b78:	ff010113          	addi	sp,sp,-16
    80003b7c:	00813423          	sd	s0,8(sp)
    80003b80:	01010413          	addi	s0,sp,16
    if (!slab || listNum < 0 || listNum > 2) return;
    80003b84:	02058a63          	beqz	a1,80003bb8 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    80003b88:	02064863          	bltz	a2,80003bb8 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    80003b8c:	00200793          	li	a5,2
    80003b90:	02c7c463          	blt	a5,a2,80003bb8 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    slab->state = (SlabState)listNum;
    80003b94:	00c5a823          	sw	a2,16(a1)
    if(slabList[listNum]) {
    80003b98:	00361793          	slli	a5,a2,0x3
    80003b9c:	00f507b3          	add	a5,a0,a5
    80003ba0:	0087b783          	ld	a5,8(a5)
    80003ba4:	00078463          	beqz	a5,80003bac <_ZN5Cache11slabListPutEPNS_4SlabEi+0x34>
        slab->next = slabList[listNum];
    80003ba8:	00f5b423          	sd	a5,8(a1)
    }
    slabList[listNum] = slab;
    80003bac:	00361613          	slli	a2,a2,0x3
    80003bb0:	00c50633          	add	a2,a0,a2
    80003bb4:	00b63423          	sd	a1,8(a2)
}
    80003bb8:	00813403          	ld	s0,8(sp)
    80003bbc:	01010113          	addi	sp,sp,16
    80003bc0:	00008067          	ret

0000000080003bc4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>:
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    80003bc4:	ff010113          	addi	sp,sp,-16
    80003bc8:	00813423          	sd	s0,8(sp)
    80003bcc:	01010413          	addi	s0,sp,16
    if(!slab || listNum < 0 || listNum > 2) return;
    80003bd0:	04058263          	beqz	a1,80003c14 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
    80003bd4:	04064063          	bltz	a2,80003c14 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
    80003bd8:	00200793          	li	a5,2
    80003bdc:	02c7cc63          	blt	a5,a2,80003c14 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003be0:	00361793          	slli	a5,a2,0x3
    80003be4:	00f507b3          	add	a5,a0,a5
    80003be8:	0087b783          	ld	a5,8(a5)
    Slab* prev = nullptr;
    80003bec:	00000713          	li	a4,0
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003bf0:	02078263          	beqz	a5,80003c14 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
        if(curr == slab) {
    80003bf4:	00b78863          	beq	a5,a1,80003c04 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x40>
                slabList[listNum] = curr->next;
            }
            curr->next = nullptr;
            break;
        }
        prev = curr;
    80003bf8:	00078713          	mv	a4,a5
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003bfc:	0087b783          	ld	a5,8(a5)
    80003c00:	ff1ff06f          	j	80003bf0 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x2c>
            if(prev) {
    80003c04:	00070e63          	beqz	a4,80003c20 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x5c>
                prev->next = curr->next;
    80003c08:	0087b683          	ld	a3,8(a5)
    80003c0c:	00d73423          	sd	a3,8(a4)
            curr->next = nullptr;
    80003c10:	0007b423          	sd	zero,8(a5)
    }
}
    80003c14:	00813403          	ld	s0,8(sp)
    80003c18:	01010113          	addi	sp,sp,16
    80003c1c:	00008067          	ret
                slabList[listNum] = curr->next;
    80003c20:	0087b703          	ld	a4,8(a5)
    80003c24:	00361613          	slli	a2,a2,0x3
    80003c28:	00c50633          	add	a2,a0,a2
    80003c2c:	00e63423          	sd	a4,8(a2)
    80003c30:	fe1ff06f          	j	80003c10 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>

0000000080003c34 <_ZN5Cache17printErrorMessageEv>:

int Cache::printErrorMessage() {
    80003c34:	fe010113          	addi	sp,sp,-32
    80003c38:	00113c23          	sd	ra,24(sp)
    80003c3c:	00813823          	sd	s0,16(sp)
    80003c40:	00913423          	sd	s1,8(sp)
    80003c44:	02010413          	addi	s0,sp,32
    80003c48:	00050493          	mv	s1,a0
    switch(errortype) {
    80003c4c:	00052703          	lw	a4,0(a0)
    80003c50:	00100793          	li	a5,1
    80003c54:	02f70663          	beq	a4,a5,80003c80 <_ZN5Cache17printErrorMessageEv+0x4c>
        case FreeSlotError:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    80003c58:	00004517          	auipc	a0,0x4
    80003c5c:	56050513          	addi	a0,a0,1376 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80003c60:	fffff097          	auipc	ra,0xfffff
    80003c64:	bf0080e7          	jalr	-1040(ra) # 80002850 <_Z11printStringPKc>
    }
    return errortype;
}
    80003c68:	0004a503          	lw	a0,0(s1)
    80003c6c:	01813083          	ld	ra,24(sp)
    80003c70:	01013403          	ld	s0,16(sp)
    80003c74:	00813483          	ld	s1,8(sp)
    80003c78:	02010113          	addi	sp,sp,32
    80003c7c:	00008067          	ret
            printString("Greska u oslobadjanju slota");
    80003c80:	00004517          	auipc	a0,0x4
    80003c84:	51850513          	addi	a0,a0,1304 # 80008198 <CONSOLE_STATUS+0x188>
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	bc8080e7          	jalr	-1080(ra) # 80002850 <_Z11printStringPKc>
    80003c90:	fc9ff06f          	j	80003c58 <_ZN5Cache17printErrorMessageEv+0x24>

0000000080003c94 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>:
    printString(", ");
    printInt(numSlots);
    printString("\n");
}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    80003c94:	ff010113          	addi	sp,sp,-16
    80003c98:	00813423          	sd	s0,8(sp)
    80003c9c:	01010413          	addi	s0,sp,16
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
    80003ca0:	00000893          	li	a7,0
    int slabs = 0, slots = 0;
    80003ca4:	00000713          	li	a4,0
    80003ca8:	00000693          	li	a3,0
    80003cac:	0080006f          	j	80003cb4 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x20>
    for(int i = 0; i < 3; i++) {
    80003cb0:	0018889b          	addiw	a7,a7,1
    80003cb4:	00200793          	li	a5,2
    80003cb8:	0317c463          	blt	a5,a7,80003ce0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x4c>
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003cbc:	00389793          	slli	a5,a7,0x3
    80003cc0:	00f507b3          	add	a5,a0,a5
    80003cc4:	0087b783          	ld	a5,8(a5)
    80003cc8:	fe0784e3          	beqz	a5,80003cb0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x1c>
             slabs++;
    80003ccc:	0016869b          	addiw	a3,a3,1
             slots += curr->allocatedSlots;
    80003cd0:	0007b803          	ld	a6,0(a5)
    80003cd4:	00e8073b          	addw	a4,a6,a4
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003cd8:	0087b783          	ld	a5,8(a5)
    80003cdc:	fedff06f          	j	80003cc8 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x34>
        }
    }
    (*numSlabs) = slabs;
    80003ce0:	00d5a023          	sw	a3,0(a1)
    (*numSlots) = slots;
    80003ce4:	00e62023          	sw	a4,0(a2)
}
    80003ce8:	00813403          	ld	s0,8(sp)
    80003cec:	01010113          	addi	sp,sp,16
    80003cf0:	00008067          	ret

0000000080003cf4 <_ZN5Cache14printCacheInfoEv>:
void Cache::printCacheInfo() {
    80003cf4:	fd010113          	addi	sp,sp,-48
    80003cf8:	02113423          	sd	ra,40(sp)
    80003cfc:	02813023          	sd	s0,32(sp)
    80003d00:	00913c23          	sd	s1,24(sp)
    80003d04:	03010413          	addi	s0,sp,48
    80003d08:	00050493          	mv	s1,a0
    int numSlabs = 0, numSlots = 0;
    80003d0c:	fc042e23          	sw	zero,-36(s0)
    80003d10:	fc042c23          	sw	zero,-40(s0)
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    80003d14:	fd840613          	addi	a2,s0,-40
    80003d18:	fdc40593          	addi	a1,s0,-36
    80003d1c:	00000097          	auipc	ra,0x0
    80003d20:	f78080e7          	jalr	-136(ra) # 80003c94 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>
    printString(cacheName);
    80003d24:	02048513          	addi	a0,s1,32
    80003d28:	fffff097          	auipc	ra,0xfffff
    80003d2c:	b28080e7          	jalr	-1240(ra) # 80002850 <_Z11printStringPKc>
    printString(", ");
    80003d30:	00004517          	auipc	a0,0x4
    80003d34:	4b050513          	addi	a0,a0,1200 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003d38:	fffff097          	auipc	ra,0xfffff
    80003d3c:	b18080e7          	jalr	-1256(ra) # 80002850 <_Z11printStringPKc>
    printInt(objectSize);
    80003d40:	00000613          	li	a2,0
    80003d44:	00a00593          	li	a1,10
    80003d48:	0304a503          	lw	a0,48(s1)
    80003d4c:	fffff097          	auipc	ra,0xfffff
    80003d50:	c9c080e7          	jalr	-868(ra) # 800029e8 <_Z8printIntiii>
    printString(", ");
    80003d54:	00004517          	auipc	a0,0x4
    80003d58:	48c50513          	addi	a0,a0,1164 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003d5c:	fffff097          	auipc	ra,0xfffff
    80003d60:	af4080e7          	jalr	-1292(ra) # 80002850 <_Z11printStringPKc>
    printInt(BLKSIZE*slabSize);
    80003d64:	0484b503          	ld	a0,72(s1)
    80003d68:	00000613          	li	a2,0
    80003d6c:	00a00593          	li	a1,10
    80003d70:	00c5151b          	slliw	a0,a0,0xc
    80003d74:	fffff097          	auipc	ra,0xfffff
    80003d78:	c74080e7          	jalr	-908(ra) # 800029e8 <_Z8printIntiii>
    printString(", ");
    80003d7c:	00004517          	auipc	a0,0x4
    80003d80:	46450513          	addi	a0,a0,1124 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003d84:	fffff097          	auipc	ra,0xfffff
    80003d88:	acc080e7          	jalr	-1332(ra) # 80002850 <_Z11printStringPKc>
    printInt(numSlabs);
    80003d8c:	00000613          	li	a2,0
    80003d90:	00a00593          	li	a1,10
    80003d94:	fdc42503          	lw	a0,-36(s0)
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	c50080e7          	jalr	-944(ra) # 800029e8 <_Z8printIntiii>
    printString(", ");
    80003da0:	00004517          	auipc	a0,0x4
    80003da4:	44050513          	addi	a0,a0,1088 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003da8:	fffff097          	auipc	ra,0xfffff
    80003dac:	aa8080e7          	jalr	-1368(ra) # 80002850 <_Z11printStringPKc>
    printInt(optimalSlots);
    80003db0:	00000613          	li	a2,0
    80003db4:	00a00593          	li	a1,10
    80003db8:	0384a503          	lw	a0,56(s1)
    80003dbc:	fffff097          	auipc	ra,0xfffff
    80003dc0:	c2c080e7          	jalr	-980(ra) # 800029e8 <_Z8printIntiii>
    printString(", ");
    80003dc4:	00004517          	auipc	a0,0x4
    80003dc8:	41c50513          	addi	a0,a0,1052 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003dcc:	fffff097          	auipc	ra,0xfffff
    80003dd0:	a84080e7          	jalr	-1404(ra) # 80002850 <_Z11printStringPKc>
    printInt(slotSize);
    80003dd4:	00000613          	li	a2,0
    80003dd8:	00a00593          	li	a1,10
    80003ddc:	0404a503          	lw	a0,64(s1)
    80003de0:	fffff097          	auipc	ra,0xfffff
    80003de4:	c08080e7          	jalr	-1016(ra) # 800029e8 <_Z8printIntiii>
    printString(", ");
    80003de8:	00004517          	auipc	a0,0x4
    80003dec:	3f850513          	addi	a0,a0,1016 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003df0:	fffff097          	auipc	ra,0xfffff
    80003df4:	a60080e7          	jalr	-1440(ra) # 80002850 <_Z11printStringPKc>
    printInt(numSlots);
    80003df8:	00000613          	li	a2,0
    80003dfc:	00a00593          	li	a1,10
    80003e00:	fd842503          	lw	a0,-40(s0)
    80003e04:	fffff097          	auipc	ra,0xfffff
    80003e08:	be4080e7          	jalr	-1052(ra) # 800029e8 <_Z8printIntiii>
    printString("\n");
    80003e0c:	00004517          	auipc	a0,0x4
    80003e10:	45450513          	addi	a0,a0,1108 # 80008260 <CONSOLE_STATUS+0x250>
    80003e14:	fffff097          	auipc	ra,0xfffff
    80003e18:	a3c080e7          	jalr	-1476(ra) # 80002850 <_Z11printStringPKc>
}
    80003e1c:	02813083          	ld	ra,40(sp)
    80003e20:	02013403          	ld	s0,32(sp)
    80003e24:	01813483          	ld	s1,24(sp)
    80003e28:	03010113          	addi	sp,sp,48
    80003e2c:	00008067          	ret

0000000080003e30 <_ZN5Cache11deallocSlabEPNS_4SlabE>:
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    80003e30:	fd010113          	addi	sp,sp,-48
    80003e34:	02113423          	sd	ra,40(sp)
    80003e38:	02813023          	sd	s0,32(sp)
    80003e3c:	00913c23          	sd	s1,24(sp)
    80003e40:	01213823          	sd	s2,16(sp)
    80003e44:	01313423          	sd	s3,8(sp)
    80003e48:	03010413          	addi	s0,sp,48
    80003e4c:	00058993          	mv	s3,a1
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    if(destructor) {
    80003e50:	05853783          	ld	a5,88(a0)
    80003e54:	02078a63          	beqz	a5,80003e88 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x58>
    80003e58:	00050913          	mv	s2,a0
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003e5c:	00000493          	li	s1,0
    80003e60:	0200006f          	j	80003e80 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x50>
            destructor((void*)((char*)startAddr + i*slotSize));
    80003e64:	05893783          	ld	a5,88(s2)
    80003e68:	04093503          	ld	a0,64(s2)
    80003e6c:	02950533          	mul	a0,a0,s1
    80003e70:	02850513          	addi	a0,a0,40
    80003e74:	00a98533          	add	a0,s3,a0
    80003e78:	000780e7          	jalr	a5
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003e7c:	00148493          	addi	s1,s1,1
    80003e80:	03893783          	ld	a5,56(s2)
    80003e84:	fef4e0e3          	bltu	s1,a5,80003e64 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x34>
        }
    }
    BuddyAllocator::buddyFree(slab, 1);
    80003e88:	00100593          	li	a1,1
    80003e8c:	00098513          	mv	a0,s3
    80003e90:	ffffe097          	auipc	ra,0xffffe
    80003e94:	474080e7          	jalr	1140(ra) # 80002304 <_ZN14BuddyAllocator9buddyFreeEPvm>
}
    80003e98:	02813083          	ld	ra,40(sp)
    80003e9c:	02013403          	ld	s0,32(sp)
    80003ea0:	01813483          	ld	s1,24(sp)
    80003ea4:	01013903          	ld	s2,16(sp)
    80003ea8:	00813983          	ld	s3,8(sp)
    80003eac:	03010113          	addi	sp,sp,48
    80003eb0:	00008067          	ret

0000000080003eb4 <_ZN5Cache16deallocFreeSlabsEv>:
int Cache::deallocFreeSlabs() {
    80003eb4:	fd010113          	addi	sp,sp,-48
    80003eb8:	02113423          	sd	ra,40(sp)
    80003ebc:	02813023          	sd	s0,32(sp)
    80003ec0:	00913c23          	sd	s1,24(sp)
    80003ec4:	01213823          	sd	s2,16(sp)
    80003ec8:	01313423          	sd	s3,8(sp)
    80003ecc:	03010413          	addi	s0,sp,48
    80003ed0:	00050993          	mv	s3,a0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003ed4:	00853583          	ld	a1,8(a0)
    int numSlabs = 0;
    80003ed8:	00000493          	li	s1,0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003edc:	02058063          	beqz	a1,80003efc <_ZN5Cache16deallocFreeSlabsEv+0x48>
        numSlabs++;
    80003ee0:	0014849b          	addiw	s1,s1,1
        curr = curr->next;
    80003ee4:	0085b903          	ld	s2,8(a1)
        deallocSlab(old);
    80003ee8:	00098513          	mv	a0,s3
    80003eec:	00000097          	auipc	ra,0x0
    80003ef0:	f44080e7          	jalr	-188(ra) # 80003e30 <_ZN5Cache11deallocSlabEPNS_4SlabE>
        curr = curr->next;
    80003ef4:	00090593          	mv	a1,s2
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003ef8:	fe5ff06f          	j	80003edc <_ZN5Cache16deallocFreeSlabsEv+0x28>
    slabList[EMPTY] = nullptr;
    80003efc:	0009b423          	sd	zero,8(s3)
}
    80003f00:	00048513          	mv	a0,s1
    80003f04:	02813083          	ld	ra,40(sp)
    80003f08:	02013403          	ld	s0,32(sp)
    80003f0c:	01813483          	ld	s1,24(sp)
    80003f10:	01013903          	ld	s2,16(sp)
    80003f14:	00813983          	ld	s3,8(sp)
    80003f18:	03010113          	addi	sp,sp,48
    80003f1c:	00008067          	ret

0000000080003f20 <_ZN5Cache12deallocCacheEv>:

void Cache::deallocCache() {
    80003f20:	fd010113          	addi	sp,sp,-48
    80003f24:	02113423          	sd	ra,40(sp)
    80003f28:	02813023          	sd	s0,32(sp)
    80003f2c:	00913c23          	sd	s1,24(sp)
    80003f30:	01213823          	sd	s2,16(sp)
    80003f34:	01313423          	sd	s3,8(sp)
    80003f38:	03010413          	addi	s0,sp,48
    80003f3c:	00050913          	mv	s2,a0
    for(int i = 0; i < 3; i++) {
    80003f40:	00000993          	li	s3,0
    80003f44:	0080006f          	j	80003f4c <_ZN5Cache12deallocCacheEv+0x2c>
    80003f48:	0019899b          	addiw	s3,s3,1
    80003f4c:	00200793          	li	a5,2
    80003f50:	0337c663          	blt	a5,s3,80003f7c <_ZN5Cache12deallocCacheEv+0x5c>
        Slab* curr = slabList[i];
    80003f54:	00399793          	slli	a5,s3,0x3
    80003f58:	00f907b3          	add	a5,s2,a5
    80003f5c:	0087b583          	ld	a1,8(a5)
        while(curr) {
    80003f60:	fe0584e3          	beqz	a1,80003f48 <_ZN5Cache12deallocCacheEv+0x28>
            Slab* old = curr;
            curr = curr->next;
    80003f64:	0085b483          	ld	s1,8(a1)
            deallocSlab(old);
    80003f68:	00090513          	mv	a0,s2
    80003f6c:	00000097          	auipc	ra,0x0
    80003f70:	ec4080e7          	jalr	-316(ra) # 80003e30 <_ZN5Cache11deallocSlabEPNS_4SlabE>
            curr = curr->next;
    80003f74:	00048593          	mv	a1,s1
        while(curr) {
    80003f78:	fe9ff06f          	j	80003f60 <_ZN5Cache12deallocCacheEv+0x40>
        }
    }
}
    80003f7c:	02813083          	ld	ra,40(sp)
    80003f80:	02013403          	ld	s0,32(sp)
    80003f84:	01813483          	ld	s1,24(sp)
    80003f88:	01013903          	ld	s2,16(sp)
    80003f8c:	00813983          	ld	s3,8(sp)
    80003f90:	03010113          	addi	sp,sp,48
    80003f94:	00008067          	ret

0000000080003f98 <_ZN5Cache10powerOfTwoEm>:
void Cache::freeBuffer(Slot* slot) {
    Cache* parentCache = slot->parentSlab->parentCache;
    parentCache->freeSlot(slot);
}

size_t Cache::powerOfTwo(size_t size) {
    80003f98:	ff010113          	addi	sp,sp,-16
    80003f9c:	00813423          	sd	s0,8(sp)
    80003fa0:	01010413          	addi	s0,sp,16
    80003fa4:	00050613          	mv	a2,a0
    size_t t = size;
    80003fa8:	00050793          	mv	a5,a0
    size_t pow = 0, powerValue = 1;
    80003fac:	00100713          	li	a4,1
    80003fb0:	00000513          	li	a0,0
    while(t > 1) {
    80003fb4:	00100693          	li	a3,1
    80003fb8:	00f6fa63          	bgeu	a3,a5,80003fcc <_ZN5Cache10powerOfTwoEm+0x34>
        t /= 2;
    80003fbc:	0017d793          	srli	a5,a5,0x1
        powerValue *= 2;
    80003fc0:	00171713          	slli	a4,a4,0x1
        pow++;
    80003fc4:	00150513          	addi	a0,a0,1
    while(t > 1) {
    80003fc8:	fedff06f          	j	80003fb4 <_ZN5Cache10powerOfTwoEm+0x1c>
    }
    if(size != powerValue) pow++;
    80003fcc:	00c70463          	beq	a4,a2,80003fd4 <_ZN5Cache10powerOfTwoEm+0x3c>
    80003fd0:	00150513          	addi	a0,a0,1
    return pow;
}
    80003fd4:	00813403          	ld	s0,8(sp)
    80003fd8:	01010113          	addi	sp,sp,16
    80003fdc:	00008067          	ret

0000000080003fe0 <_ZN5Cache12allocateSlabEv>:
Cache::Slab *Cache::allocateSlab() {
    80003fe0:	fc010113          	addi	sp,sp,-64
    80003fe4:	02113c23          	sd	ra,56(sp)
    80003fe8:	02813823          	sd	s0,48(sp)
    80003fec:	02913423          	sd	s1,40(sp)
    80003ff0:	03213023          	sd	s2,32(sp)
    80003ff4:	01313c23          	sd	s3,24(sp)
    80003ff8:	01413823          	sd	s4,16(sp)
    80003ffc:	01513423          	sd	s5,8(sp)
    80004000:	04010413          	addi	s0,sp,64
    80004004:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(powerOfTwo(slabSize) + 1); // 2 ako nije dovoljno
    80004008:	04853503          	ld	a0,72(a0)
    8000400c:	00000097          	auipc	ra,0x0
    80004010:	f8c080e7          	jalr	-116(ra) # 80003f98 <_ZN5Cache10powerOfTwoEm>
    80004014:	00150513          	addi	a0,a0,1
    80004018:	ffffe097          	auipc	ra,0xffffe
    8000401c:	224080e7          	jalr	548(ra) # 8000223c <_ZN14BuddyAllocator10buddyAllocEm>
    80004020:	00050a13          	mv	s4,a0
    slab->parentCache = this;
    80004024:	01253c23          	sd	s2,24(a0)
    slab->next = nullptr;
    80004028:	00053423          	sd	zero,8(a0)
    slab->state = CREATED;
    8000402c:	00300793          	li	a5,3
    80004030:	00f52823          	sw	a5,16(a0)
    slab->allocatedSlots = 0;
    80004034:	00053023          	sd	zero,0(a0)
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    80004038:	02850a93          	addi	s5,a0,40
    for(size_t i = 0; i < this->optimalSlots; i++) {
    8000403c:	00000493          	li	s1,0
    Slot* prev = nullptr;
    80004040:	00000993          	li	s3,0
    80004044:	0140006f          	j	80004058 <_ZN5Cache12allocateSlabEv+0x78>
            slab->slotHead = curr;
    80004048:	02fa3023          	sd	a5,32(s4)
        curr->next = nullptr;
    8000404c:	0007b423          	sd	zero,8(a5)
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80004050:	00148493          	addi	s1,s1,1
        prev = curr;
    80004054:	00078993          	mv	s3,a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80004058:	03893783          	ld	a5,56(s2)
    8000405c:	04f4f063          	bgeu	s1,a5,8000409c <_ZN5Cache12allocateSlabEv+0xbc>
        if(constructor) {
    80004060:	05093783          	ld	a5,80(s2)
    80004064:	00078c63          	beqz	a5,8000407c <_ZN5Cache12allocateSlabEv+0x9c>
            constructor((void*)((char*)startAddr + i*slotSize + sizeof(Slot)));
    80004068:	04093503          	ld	a0,64(s2)
    8000406c:	02950533          	mul	a0,a0,s1
    80004070:	01850513          	addi	a0,a0,24
    80004074:	00aa8533          	add	a0,s5,a0
    80004078:	000780e7          	jalr	a5
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
    8000407c:	04093783          	ld	a5,64(s2)
    80004080:	029787b3          	mul	a5,a5,s1
    80004084:	00fa87b3          	add	a5,s5,a5
        curr->parentSlab = slab;
    80004088:	0147b823          	sd	s4,16(a5)
        curr->allocated = false;
    8000408c:	00078023          	sb	zero,0(a5)
        if(prev) {
    80004090:	fa098ce3          	beqz	s3,80004048 <_ZN5Cache12allocateSlabEv+0x68>
            prev->next= curr;
    80004094:	00f9b423          	sd	a5,8(s3)
    80004098:	fb5ff06f          	j	8000404c <_ZN5Cache12allocateSlabEv+0x6c>
}
    8000409c:	000a0513          	mv	a0,s4
    800040a0:	03813083          	ld	ra,56(sp)
    800040a4:	03013403          	ld	s0,48(sp)
    800040a8:	02813483          	ld	s1,40(sp)
    800040ac:	02013903          	ld	s2,32(sp)
    800040b0:	01813983          	ld	s3,24(sp)
    800040b4:	01013a03          	ld	s4,16(sp)
    800040b8:	00813a83          	ld	s5,8(sp)
    800040bc:	04010113          	addi	sp,sp,64
    800040c0:	00008067          	ret

00000000800040c4 <_ZN5Cache11createCacheEv>:

Cache *Cache::createCache() {
    800040c4:	ff010113          	addi	sp,sp,-16
    800040c8:	00113423          	sd	ra,8(sp)
    800040cc:	00813023          	sd	s0,0(sp)
    800040d0:	01010413          	addi	s0,sp,16
    return (Cache*)BuddyAllocator::buddyAlloc(1);
    800040d4:	00100513          	li	a0,1
    800040d8:	ffffe097          	auipc	ra,0xffffe
    800040dc:	164080e7          	jalr	356(ra) # 8000223c <_ZN14BuddyAllocator10buddyAllocEm>
}
    800040e0:	00813083          	ld	ra,8(sp)
    800040e4:	00013403          	ld	s0,0(sp)
    800040e8:	01010113          	addi	sp,sp,16
    800040ec:	00008067          	ret

00000000800040f0 <_ZN5Cache6strcpyEPcPKc>:

void Cache::strcpy(char *string1, const char *string2) {
    800040f0:	ff010113          	addi	sp,sp,-16
    800040f4:	00813423          	sd	s0,8(sp)
    800040f8:	01010413          	addi	s0,sp,16
        for(int i = 0;; i++) {
    800040fc:	00000693          	li	a3,0
            string1[i] = string2[i];
    80004100:	00d587b3          	add	a5,a1,a3
    80004104:	00d50733          	add	a4,a0,a3
    80004108:	0007c603          	lbu	a2,0(a5)
    8000410c:	00c70023          	sb	a2,0(a4)
            if(string2[i] == '\0') break;
    80004110:	0007c783          	lbu	a5,0(a5)
    80004114:	00078663          	beqz	a5,80004120 <_ZN5Cache6strcpyEPcPKc+0x30>
        for(int i = 0;; i++) {
    80004118:	0016869b          	addiw	a3,a3,1
            string1[i] = string2[i];
    8000411c:	fe5ff06f          	j	80004100 <_ZN5Cache6strcpyEPcPKc+0x10>
        }
}
    80004120:	00813403          	ld	s0,8(sp)
    80004124:	01010113          	addi	sp,sp,16
    80004128:	00008067          	ret

000000008000412c <_ZN5Cache9initCacheEPKcmPFvPvES4_>:
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    8000412c:	fd010113          	addi	sp,sp,-48
    80004130:	02113423          	sd	ra,40(sp)
    80004134:	02813023          	sd	s0,32(sp)
    80004138:	00913c23          	sd	s1,24(sp)
    8000413c:	01213823          	sd	s2,16(sp)
    80004140:	01313423          	sd	s3,8(sp)
    80004144:	01413023          	sd	s4,0(sp)
    80004148:	03010413          	addi	s0,sp,48
    8000414c:	00050493          	mv	s1,a0
    80004150:	00060913          	mv	s2,a2
    80004154:	00068a13          	mv	s4,a3
    80004158:	00070993          	mv	s3,a4
    strcpy(cacheName, name);
    8000415c:	02050513          	addi	a0,a0,32
    80004160:	00000097          	auipc	ra,0x0
    80004164:	f90080e7          	jalr	-112(ra) # 800040f0 <_ZN5Cache6strcpyEPcPKc>
    for(int i = 0; i < 3; i++) {
    80004168:	00000793          	li	a5,0
    8000416c:	0140006f          	j	80004180 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x54>
        slabList[i] = nullptr;
    80004170:	00379513          	slli	a0,a5,0x3
    80004174:	00a48533          	add	a0,s1,a0
    80004178:	00053423          	sd	zero,8(a0)
    for(int i = 0; i < 3; i++) {
    8000417c:	0017879b          	addiw	a5,a5,1
    80004180:	00200613          	li	a2,2
    80004184:	fef656e3          	bge	a2,a5,80004170 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x44>
    objectSize = size;
    80004188:	0324b823          	sd	s2,48(s1)
    constructor = ctor;
    8000418c:	0544b823          	sd	s4,80(s1)
    destructor = dtor;
    80004190:	0534bc23          	sd	s3,88(s1)
    slotSize = objectSize + sizeof(Slot);
    80004194:	01890593          	addi	a1,s2,24
    80004198:	04b4b023          	sd	a1,64(s1)
    slabSize = slotSize / BLKSIZE;
    8000419c:	00c5d713          	srli	a4,a1,0xc
    800041a0:	04e4b423          	sd	a4,72(s1)
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima
    800041a4:	000017b7          	lui	a5,0x1
    800041a8:	fff78793          	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800041ac:	00f5f7b3          	and	a5,a1,a5
    800041b0:	00078663          	beqz	a5,800041bc <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x90>
    800041b4:	00170713          	addi	a4,a4,1
    800041b8:	04e4b423          	sd	a4,72(s1)
    optimalSlots = getNumSlots(slabSize, slotSize);
    800041bc:	0484b503          	ld	a0,72(s1)
    800041c0:	00000097          	auipc	ra,0x0
    800041c4:	990080e7          	jalr	-1648(ra) # 80003b50 <_ZN5Cache11getNumSlotsEmm>
    800041c8:	02a4bc23          	sd	a0,56(s1)
}
    800041cc:	02813083          	ld	ra,40(sp)
    800041d0:	02013403          	ld	s0,32(sp)
    800041d4:	01813483          	ld	s1,24(sp)
    800041d8:	01013903          	ld	s2,16(sp)
    800041dc:	00813983          	ld	s3,8(sp)
    800041e0:	00013a03          	ld	s4,0(sp)
    800041e4:	03010113          	addi	sp,sp,48
    800041e8:	00008067          	ret

00000000800041ec <_ZN5Cache13allBufferInfoEv>:

void Cache::allBufferInfo() {
    800041ec:	fe010113          	addi	sp,sp,-32
    800041f0:	00113c23          	sd	ra,24(sp)
    800041f4:	00813823          	sd	s0,16(sp)
    800041f8:	00913423          	sd	s1,8(sp)
    800041fc:	02010413          	addi	s0,sp,32
    printString("ime kesa, velicina objekta, velicina slaba, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    80004200:	00004517          	auipc	a0,0x4
    80004204:	fe850513          	addi	a0,a0,-24 # 800081e8 <CONSOLE_STATUS+0x1d8>
    80004208:	ffffe097          	auipc	ra,0xffffe
    8000420c:	648080e7          	jalr	1608(ra) # 80002850 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80004210:	00000493          	li	s1,0
    80004214:	0200006f          	j	80004234 <_ZN5Cache13allBufferInfoEv+0x48>
        if(bufferCache[i]) {
            bufferCache[i]->printCacheInfo();
    80004218:	00000097          	auipc	ra,0x0
    8000421c:	adc080e7          	jalr	-1316(ra) # 80003cf4 <_ZN5Cache14printCacheInfoEv>
            printString("\n");
    80004220:	00004517          	auipc	a0,0x4
    80004224:	04050513          	addi	a0,a0,64 # 80008260 <CONSOLE_STATUS+0x250>
    80004228:	ffffe097          	auipc	ra,0xffffe
    8000422c:	628080e7          	jalr	1576(ra) # 80002850 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80004230:	0014849b          	addiw	s1,s1,1
    80004234:	00c00793          	li	a5,12
    80004238:	0297c063          	blt	a5,s1,80004258 <_ZN5Cache13allBufferInfoEv+0x6c>
        if(bufferCache[i]) {
    8000423c:	00349713          	slli	a4,s1,0x3
    80004240:	00006797          	auipc	a5,0x6
    80004244:	30078793          	addi	a5,a5,768 # 8000a540 <_ZN5Cache11bufferCacheE>
    80004248:	00e787b3          	add	a5,a5,a4
    8000424c:	0007b503          	ld	a0,0(a5)
    80004250:	fc0514e3          	bnez	a0,80004218 <_ZN5Cache13allBufferInfoEv+0x2c>
    80004254:	fddff06f          	j	80004230 <_ZN5Cache13allBufferInfoEv+0x44>
        }
    }
}
    80004258:	01813083          	ld	ra,24(sp)
    8000425c:	01013403          	ld	s0,16(sp)
    80004260:	00813483          	ld	s1,8(sp)
    80004264:	02010113          	addi	sp,sp,32
    80004268:	00008067          	ret

000000008000426c <_ZN5Cache4Slab17calculateNewStateEv>:
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    8000426c:	ff010113          	addi	sp,sp,-16
    80004270:	00813423          	sd	s0,8(sp)
    80004274:	01010413          	addi	s0,sp,16
    if(allocatedSlots == 0) {
    80004278:	00053783          	ld	a5,0(a0)
    8000427c:	02078063          	beqz	a5,8000429c <_ZN5Cache4Slab17calculateNewStateEv+0x30>
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
    80004280:	01853703          	ld	a4,24(a0)
    80004284:	03873703          	ld	a4,56(a4)
    80004288:	00e78e63          	beq	a5,a4,800042a4 <_ZN5Cache4Slab17calculateNewStateEv+0x38>
        return FULL;
    }
    return PARTIAL;
    8000428c:	00100513          	li	a0,1
}
    80004290:	00813403          	ld	s0,8(sp)
    80004294:	01010113          	addi	sp,sp,16
    80004298:	00008067          	ret
        return EMPTY;
    8000429c:	00000513          	li	a0,0
    800042a0:	ff1ff06f          	j	80004290 <_ZN5Cache4Slab17calculateNewStateEv+0x24>
        return FULL;
    800042a4:	00200513          	li	a0,2
    800042a8:	fe9ff06f          	j	80004290 <_ZN5Cache4Slab17calculateNewStateEv+0x24>

00000000800042ac <_ZN5Cache8freeSlotEPNS_4SlotE>:
void Cache::freeSlot(Slot* slot) {
    800042ac:	fd010113          	addi	sp,sp,-48
    800042b0:	02113423          	sd	ra,40(sp)
    800042b4:	02813023          	sd	s0,32(sp)
    800042b8:	00913c23          	sd	s1,24(sp)
    800042bc:	01213823          	sd	s2,16(sp)
    800042c0:	01313423          	sd	s3,8(sp)
    800042c4:	03010413          	addi	s0,sp,48
    if(slot->parentSlab->parentCache != this) {
    800042c8:	0105b483          	ld	s1,16(a1)
    800042cc:	0184b903          	ld	s2,24(s1)
    800042d0:	02a90463          	beq	s2,a0,800042f8 <_ZN5Cache8freeSlotEPNS_4SlotE+0x4c>
        errortype = FreeSlotError;
    800042d4:	00100793          	li	a5,1
    800042d8:	00f52023          	sw	a5,0(a0)
}
    800042dc:	02813083          	ld	ra,40(sp)
    800042e0:	02013403          	ld	s0,32(sp)
    800042e4:	01813483          	ld	s1,24(sp)
    800042e8:	01013903          	ld	s2,16(sp)
    800042ec:	00813983          	ld	s3,8(sp)
    800042f0:	03010113          	addi	sp,sp,48
    800042f4:	00008067          	ret
    slot->allocated = false;
    800042f8:	00058023          	sb	zero,0(a1)
    parentSlab->allocatedSlots--;
    800042fc:	0004b783          	ld	a5,0(s1)
    80004300:	fff78793          	addi	a5,a5,-1
    80004304:	00f4b023          	sd	a5,0(s1)
    SlabState newState = parentSlab->calculateNewState();
    80004308:	00048513          	mv	a0,s1
    8000430c:	00000097          	auipc	ra,0x0
    80004310:	f60080e7          	jalr	-160(ra) # 8000426c <_ZN5Cache4Slab17calculateNewStateEv>
    80004314:	00050993          	mv	s3,a0
    if(parentSlab->state != newState) {
    80004318:	0104a603          	lw	a2,16(s1)
    8000431c:	fca600e3          	beq	a2,a0,800042dc <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80004320:	00300793          	li	a5,3
    80004324:	00f61e63          	bne	a2,a5,80004340 <_ZN5Cache8freeSlotEPNS_4SlotE+0x94>
        parentCache->slabListPut(parentSlab, newState);
    80004328:	0009861b          	sext.w	a2,s3
    8000432c:	00048593          	mv	a1,s1
    80004330:	00090513          	mv	a0,s2
    80004334:	00000097          	auipc	ra,0x0
    80004338:	844080e7          	jalr	-1980(ra) # 80003b78 <_ZN5Cache11slabListPutEPNS_4SlabEi>
    8000433c:	fa1ff06f          	j	800042dc <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80004340:	00048593          	mv	a1,s1
    80004344:	00090513          	mv	a0,s2
    80004348:	00000097          	auipc	ra,0x0
    8000434c:	87c080e7          	jalr	-1924(ra) # 80003bc4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80004350:	fd9ff06f          	j	80004328 <_ZN5Cache8freeSlotEPNS_4SlotE+0x7c>

0000000080004354 <_ZN5Cache10freeBufferEPNS_4SlotE>:
void Cache::freeBuffer(Slot* slot) {
    80004354:	ff010113          	addi	sp,sp,-16
    80004358:	00113423          	sd	ra,8(sp)
    8000435c:	00813023          	sd	s0,0(sp)
    80004360:	01010413          	addi	s0,sp,16
    80004364:	00050593          	mv	a1,a0
    Cache* parentCache = slot->parentSlab->parentCache;
    80004368:	01053783          	ld	a5,16(a0)
    parentCache->freeSlot(slot);
    8000436c:	0187b503          	ld	a0,24(a5)
    80004370:	00000097          	auipc	ra,0x0
    80004374:	f3c080e7          	jalr	-196(ra) # 800042ac <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80004378:	00813083          	ld	ra,8(sp)
    8000437c:	00013403          	ld	s0,0(sp)
    80004380:	01010113          	addi	sp,sp,16
    80004384:	00008067          	ret

0000000080004388 <_ZN5Cache4Slab11getFreeSlotEv>:
Cache::Slot *Cache::Slab::getFreeSlot() {
    80004388:	fd010113          	addi	sp,sp,-48
    8000438c:	02113423          	sd	ra,40(sp)
    80004390:	02813023          	sd	s0,32(sp)
    80004394:	00913c23          	sd	s1,24(sp)
    80004398:	01213823          	sd	s2,16(sp)
    8000439c:	01313423          	sd	s3,8(sp)
    800043a0:	03010413          	addi	s0,sp,48
    if(!slotHead || state == FULL) return nullptr;
    800043a4:	02053483          	ld	s1,32(a0)
    800043a8:	06048a63          	beqz	s1,8000441c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
    800043ac:	00050913          	mv	s2,a0
    800043b0:	01052703          	lw	a4,16(a0)
    800043b4:	00200793          	li	a5,2
    800043b8:	08f70c63          	beq	a4,a5,80004450 <_ZN5Cache4Slab11getFreeSlotEv+0xc8>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    800043bc:	06048063          	beqz	s1,8000441c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
        if(curr->allocated == false) {
    800043c0:	0004c783          	lbu	a5,0(s1)
    800043c4:	00078663          	beqz	a5,800043d0 <_ZN5Cache4Slab11getFreeSlotEv+0x48>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    800043c8:	0084b483          	ld	s1,8(s1)
    800043cc:	ff1ff06f          	j	800043bc <_ZN5Cache4Slab11getFreeSlotEv+0x34>
            this->allocatedSlots++;
    800043d0:	00093783          	ld	a5,0(s2)
    800043d4:	00178793          	addi	a5,a5,1
    800043d8:	00f93023          	sd	a5,0(s2)
            curr->allocated = true;
    800043dc:	00100793          	li	a5,1
    800043e0:	00f48023          	sb	a5,0(s1)
            curr->parentSlab = this;
    800043e4:	0124b823          	sd	s2,16(s1)
            SlabState newState = calculateNewState();
    800043e8:	00090513          	mv	a0,s2
    800043ec:	00000097          	auipc	ra,0x0
    800043f0:	e80080e7          	jalr	-384(ra) # 8000426c <_ZN5Cache4Slab17calculateNewStateEv>
    800043f4:	00050993          	mv	s3,a0
            if(this->state != newState) {
    800043f8:	01092603          	lw	a2,16(s2)
    800043fc:	02a60063          	beq	a2,a0,8000441c <_ZN5Cache4Slab11getFreeSlotEv+0x94>
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80004400:	00300793          	li	a5,3
    80004404:	02f61c63          	bne	a2,a5,8000443c <_ZN5Cache4Slab11getFreeSlotEv+0xb4>
                parentCache->slabListPut(this, newState);
    80004408:	0009861b          	sext.w	a2,s3
    8000440c:	00090593          	mv	a1,s2
    80004410:	01893503          	ld	a0,24(s2)
    80004414:	fffff097          	auipc	ra,0xfffff
    80004418:	764080e7          	jalr	1892(ra) # 80003b78 <_ZN5Cache11slabListPutEPNS_4SlabEi>
}
    8000441c:	00048513          	mv	a0,s1
    80004420:	02813083          	ld	ra,40(sp)
    80004424:	02013403          	ld	s0,32(sp)
    80004428:	01813483          	ld	s1,24(sp)
    8000442c:	01013903          	ld	s2,16(sp)
    80004430:	00813983          	ld	s3,8(sp)
    80004434:	03010113          	addi	sp,sp,48
    80004438:	00008067          	ret
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    8000443c:	00090593          	mv	a1,s2
    80004440:	01893503          	ld	a0,24(s2)
    80004444:	fffff097          	auipc	ra,0xfffff
    80004448:	780080e7          	jalr	1920(ra) # 80003bc4 <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    8000444c:	fbdff06f          	j	80004408 <_ZN5Cache4Slab11getFreeSlotEv+0x80>
    if(!slotHead || state == FULL) return nullptr;
    80004450:	00000493          	li	s1,0
    80004454:	fc9ff06f          	j	8000441c <_ZN5Cache4Slab11getFreeSlotEv+0x94>

0000000080004458 <_ZN5Cache12allocateSlotEv>:
void *Cache::allocateSlot() {
    80004458:	ff010113          	addi	sp,sp,-16
    8000445c:	00113423          	sd	ra,8(sp)
    80004460:	00813023          	sd	s0,0(sp)
    80004464:	01010413          	addi	s0,sp,16
    80004468:	00050793          	mv	a5,a0
    if(slabList[PARTIAL]) {
    8000446c:	01053503          	ld	a0,16(a0)
    80004470:	00050e63          	beqz	a0,8000448c <_ZN5Cache12allocateSlotEv+0x34>
        return slab->getFreeSlot();
    80004474:	00000097          	auipc	ra,0x0
    80004478:	f14080e7          	jalr	-236(ra) # 80004388 <_ZN5Cache4Slab11getFreeSlotEv>
}
    8000447c:	00813083          	ld	ra,8(sp)
    80004480:	00013403          	ld	s0,0(sp)
    80004484:	01010113          	addi	sp,sp,16
    80004488:	00008067          	ret
    else if(slabList[EMPTY]) {
    8000448c:	0087b503          	ld	a0,8(a5)
    80004490:	00050863          	beqz	a0,800044a0 <_ZN5Cache12allocateSlotEv+0x48>
        Slot* slot = slab->getFreeSlot();
    80004494:	00000097          	auipc	ra,0x0
    80004498:	ef4080e7          	jalr	-268(ra) # 80004388 <_ZN5Cache4Slab11getFreeSlotEv>
        return slot;
    8000449c:	fe1ff06f          	j	8000447c <_ZN5Cache12allocateSlotEv+0x24>
    Slab* slab = allocateSlab();
    800044a0:	00078513          	mv	a0,a5
    800044a4:	00000097          	auipc	ra,0x0
    800044a8:	b3c080e7          	jalr	-1220(ra) # 80003fe0 <_ZN5Cache12allocateSlabEv>
    return slab->getFreeSlot();
    800044ac:	00000097          	auipc	ra,0x0
    800044b0:	edc080e7          	jalr	-292(ra) # 80004388 <_ZN5Cache4Slab11getFreeSlotEv>
    800044b4:	fc9ff06f          	j	8000447c <_ZN5Cache12allocateSlotEv+0x24>

00000000800044b8 <_ZN5Cache14allocateBufferEm>:
void *Cache::allocateBuffer(size_t size) {
    800044b8:	fe010113          	addi	sp,sp,-32
    800044bc:	00113c23          	sd	ra,24(sp)
    800044c0:	00813823          	sd	s0,16(sp)
    800044c4:	00913423          	sd	s1,8(sp)
    800044c8:	01213023          	sd	s2,0(sp)
    800044cc:	02010413          	addi	s0,sp,32
    size_t objectPowSize = powerOfTwo(size);
    800044d0:	00000097          	auipc	ra,0x0
    800044d4:	ac8080e7          	jalr	-1336(ra) # 80003f98 <_ZN5Cache10powerOfTwoEm>
    if(objectPowSize <  MINSIZEBUFFER || objectPowSize > MAXSIZEBUFFER) {
    800044d8:	ffb50493          	addi	s1,a0,-5
    800044dc:	00c00793          	li	a5,12
    800044e0:	0897ee63          	bltu	a5,s1,8000457c <_ZN5Cache14allocateBufferEm+0xc4>
    800044e4:	00050913          	mv	s2,a0
    if(bufferCache[entry] == nullptr) {
    800044e8:	00349713          	slli	a4,s1,0x3
    800044ec:	00006797          	auipc	a5,0x6
    800044f0:	05478793          	addi	a5,a5,84 # 8000a540 <_ZN5Cache11bufferCacheE>
    800044f4:	00e787b3          	add	a5,a5,a4
    800044f8:	0007b783          	ld	a5,0(a5)
    800044fc:	02078c63          	beqz	a5,80004534 <_ZN5Cache14allocateBufferEm+0x7c>
    return bufferCache[entry]->allocateSlot();
    80004500:	00349493          	slli	s1,s1,0x3
    80004504:	00006797          	auipc	a5,0x6
    80004508:	03c78793          	addi	a5,a5,60 # 8000a540 <_ZN5Cache11bufferCacheE>
    8000450c:	009784b3          	add	s1,a5,s1
    80004510:	0004b503          	ld	a0,0(s1)
    80004514:	00000097          	auipc	ra,0x0
    80004518:	f44080e7          	jalr	-188(ra) # 80004458 <_ZN5Cache12allocateSlotEv>
}
    8000451c:	01813083          	ld	ra,24(sp)
    80004520:	01013403          	ld	s0,16(sp)
    80004524:	00813483          	ld	s1,8(sp)
    80004528:	00013903          	ld	s2,0(sp)
    8000452c:	02010113          	addi	sp,sp,32
    80004530:	00008067          	ret
        bufferCache[entry] = createCache();
    80004534:	00000097          	auipc	ra,0x0
    80004538:	b90080e7          	jalr	-1136(ra) # 800040c4 <_ZN5Cache11createCacheEv>
    8000453c:	00349693          	slli	a3,s1,0x3
    80004540:	00006717          	auipc	a4,0x6
    80004544:	00070713          	mv	a4,a4
    80004548:	00d70733          	add	a4,a4,a3
    8000454c:	00a73023          	sd	a0,0(a4) # 8000a540 <_ZN5Cache11bufferCacheE>
        bufferCache[entry]->initCache(bufferNames[entry], 1<<objectPowSize, NULL,NULL);
    80004550:	00006797          	auipc	a5,0x6
    80004554:	dc078793          	addi	a5,a5,-576 # 8000a310 <_ZN5Cache11bufferNamesE>
    80004558:	00d787b3          	add	a5,a5,a3
    8000455c:	00000713          	li	a4,0
    80004560:	00000693          	li	a3,0
    80004564:	00100613          	li	a2,1
    80004568:	0126163b          	sllw	a2,a2,s2
    8000456c:	0007b583          	ld	a1,0(a5)
    80004570:	00000097          	auipc	ra,0x0
    80004574:	bbc080e7          	jalr	-1092(ra) # 8000412c <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    80004578:	f89ff06f          	j	80004500 <_ZN5Cache14allocateBufferEm+0x48>
        return nullptr;
    8000457c:	00000513          	li	a0,0
    80004580:	f9dff06f          	j	8000451c <_ZN5Cache14allocateBufferEm+0x64>

0000000080004584 <_ZN15MemoryAllocator17userHeapStartAddrEv>:
    }

    return 0;
}

void *MemoryAllocator::userHeapStartAddr() {
    80004584:	ff010113          	addi	sp,sp,-16
    80004588:	00813423          	sd	s0,8(sp)
    8000458c:	01010413          	addi	s0,sp,16
    return (void*)((char*)HEAP_START_ADDR + (1<<24));
    80004590:	00006797          	auipc	a5,0x6
    80004594:	e087b783          	ld	a5,-504(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004598:	0007b503          	ld	a0,0(a5)
}
    8000459c:	010007b7          	lui	a5,0x1000
    800045a0:	00f50533          	add	a0,a0,a5
    800045a4:	00813403          	ld	s0,8(sp)
    800045a8:	01010113          	addi	sp,sp,16
    800045ac:	00008067          	ret

00000000800045b0 <_ZN15MemoryAllocator15userHeapEndAddrEv>:

void *MemoryAllocator::userHeapEndAddr() {
    800045b0:	ff010113          	addi	sp,sp,-16
    800045b4:	00813423          	sd	s0,8(sp)
    800045b8:	01010413          	addi	s0,sp,16
    return (void*)((char*)HEAP_END_ADDR);
}
    800045bc:	00006797          	auipc	a5,0x6
    800045c0:	e247b783          	ld	a5,-476(a5) # 8000a3e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800045c4:	0007b503          	ld	a0,0(a5)
    800045c8:	00813403          	ld	s0,8(sp)
    800045cc:	01010113          	addi	sp,sp,16
    800045d0:	00008067          	ret

00000000800045d4 <_ZN15MemoryAllocator9mem_allocEm>:
void *MemoryAllocator::mem_alloc(size_t size) {
    800045d4:	fd010113          	addi	sp,sp,-48
    800045d8:	02113423          	sd	ra,40(sp)
    800045dc:	02813023          	sd	s0,32(sp)
    800045e0:	00913c23          	sd	s1,24(sp)
    800045e4:	01213823          	sd	s2,16(sp)
    800045e8:	01313423          	sd	s3,8(sp)
    800045ec:	03010413          	addi	s0,sp,48
    800045f0:	00050913          	mv	s2,a0
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    800045f4:	00006497          	auipc	s1,0x6
    800045f8:	fb44b483          	ld	s1,-76(s1) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800045fc:	02048a63          	beqz	s1,80004630 <_ZN15MemoryAllocator9mem_allocEm+0x5c>
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    80004600:	00000097          	auipc	ra,0x0
    80004604:	fb0080e7          	jalr	-80(ra) # 800045b0 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    80004608:	14a48c63          	beq	s1,a0,80004760 <_ZN15MemoryAllocator9mem_allocEm+0x18c>
    size += SegmentOffset; // dodajemo zaglavlje
    8000460c:	00890713          	addi	a4,s2,8
    80004610:	00675793          	srli	a5,a4,0x6
    80004614:	03f77613          	andi	a2,a4,63
    80004618:	00c03633          	snez	a2,a2
    8000461c:	00f60633          	add	a2,a2,a5
    FreeSegment *curr = head, *prev = nullptr;
    80004620:	00006517          	auipc	a0,0x6
    80004624:	f8853503          	ld	a0,-120(a0) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004628:	00000693          	li	a3,0
    8000462c:	0b80006f          	j	800046e4 <_ZN15MemoryAllocator9mem_allocEm+0x110>
        head = (FreeSegment*)userHeapStartAddr();
    80004630:	00000097          	auipc	ra,0x0
    80004634:	f54080e7          	jalr	-172(ra) # 80004584 <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004638:	00050493          	mv	s1,a0
    8000463c:	00006997          	auipc	s3,0x6
    80004640:	f6c98993          	addi	s3,s3,-148 # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004644:	00a9b023          	sd	a0,0(s3)
        head->baseAddr = (void*)((char*)userHeapStartAddr());
    80004648:	00000097          	auipc	ra,0x0
    8000464c:	f3c080e7          	jalr	-196(ra) # 80004584 <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004650:	00a4b023          	sd	a0,0(s1)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    80004654:	00000097          	auipc	ra,0x0
    80004658:	f5c080e7          	jalr	-164(ra) # 800045b0 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    8000465c:	00050493          	mv	s1,a0
    80004660:	00000097          	auipc	ra,0x0
    80004664:	f24080e7          	jalr	-220(ra) # 80004584 <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004668:	0009b783          	ld	a5,0(s3)
    8000466c:	40a484b3          	sub	s1,s1,a0
    80004670:	0097b423          	sd	s1,8(a5)
        head->next = nullptr;
    80004674:	0007b823          	sd	zero,16(a5)
    80004678:	f95ff06f          	j	8000460c <_ZN15MemoryAllocator9mem_allocEm+0x38>
                if(prev == nullptr) { // ako smo na head pokazivacu
    8000467c:	00068e63          	beqz	a3,80004698 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80004680:	0106b783          	ld	a5,16(a3)
    80004684:	04078863          	beqz	a5,800046d4 <_ZN15MemoryAllocator9mem_allocEm+0x100>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80004688:	0107b783          	ld	a5,16(a5)
    8000468c:	00f6b823          	sd	a5,16(a3)
                allocatedSize = curr->size;
    80004690:	00048613          	mv	a2,s1
    80004694:	0a80006f          	j	8000473c <_ZN15MemoryAllocator9mem_allocEm+0x168>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80004698:	01053783          	ld	a5,16(a0)
    8000469c:	00078a63          	beqz	a5,800046b0 <_ZN15MemoryAllocator9mem_allocEm+0xdc>
                        head = curr->next;
    800046a0:	00006717          	auipc	a4,0x6
    800046a4:	f0f73423          	sd	a5,-248(a4) # 8000a5a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800046a8:	00048613          	mv	a2,s1
    800046ac:	0900006f          	j	8000473c <_ZN15MemoryAllocator9mem_allocEm+0x168>
                        head = (FreeSegment*)userHeapEndAddr();
    800046b0:	00000097          	auipc	ra,0x0
    800046b4:	f00080e7          	jalr	-256(ra) # 800045b0 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    800046b8:	00006797          	auipc	a5,0x6
    800046bc:	eea7b823          	sd	a0,-272(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800046c0:	00048613          	mv	a2,s1
    800046c4:	0780006f          	j	8000473c <_ZN15MemoryAllocator9mem_allocEm+0x168>
                    head = newSeg;
    800046c8:	00006717          	auipc	a4,0x6
    800046cc:	eef73023          	sd	a5,-288(a4) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800046d0:	06c0006f          	j	8000473c <_ZN15MemoryAllocator9mem_allocEm+0x168>
                allocatedSize = curr->size;
    800046d4:	00048613          	mv	a2,s1
    800046d8:	0640006f          	j	8000473c <_ZN15MemoryAllocator9mem_allocEm+0x168>
        prev = curr;
    800046dc:	00050693          	mv	a3,a0
        curr = curr->next;
    800046e0:	01053503          	ld	a0,16(a0)
    while(curr) {
    800046e4:	06050063          	beqz	a0,80004744 <_ZN15MemoryAllocator9mem_allocEm+0x170>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    800046e8:	00853483          	ld	s1,8(a0)
    800046ec:	0064d793          	srli	a5,s1,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    800046f0:	00053903          	ld	s2,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    800046f4:	fee4e4e3          	bltu	s1,a4,800046dc <_ZN15MemoryAllocator9mem_allocEm+0x108>
    800046f8:	fec7e2e3          	bltu	a5,a2,800046dc <_ZN15MemoryAllocator9mem_allocEm+0x108>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    800046fc:	f8f600e3          	beq	a2,a5,8000467c <_ZN15MemoryAllocator9mem_allocEm+0xa8>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80004700:	00661613          	slli	a2,a2,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80004704:	00c907b3          	add	a5,s2,a2
                size_t newSize = curr->size - allocatedSize;
    80004708:	40c484b3          	sub	s1,s1,a2
                newSeg->baseAddr = newBaseAddr;
    8000470c:	00f7b023          	sd	a5,0(a5)
                newSeg->size = newSize;
    80004710:	0097b423          	sd	s1,8(a5)
                newSeg->next = curr->next;
    80004714:	01053703          	ld	a4,16(a0)
    80004718:	00e7b823          	sd	a4,16(a5)
                if(!prev) {
    8000471c:	fa0686e3          	beqz	a3,800046c8 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(!prev->next) return;
    80004720:	0106b783          	ld	a5,16(a3)
    80004724:	00078663          	beqz	a5,80004730 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
            prev->next = curr->next;
    80004728:	0107b783          	ld	a5,16(a5)
    8000472c:	00f6b823          	sd	a5,16(a3)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80004730:	0106b783          	ld	a5,16(a3)
    80004734:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80004738:	00a6b823          	sd	a0,16(a3)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    8000473c:	00c93023          	sd	a2,0(s2)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80004740:	00890513          	addi	a0,s2,8
}
    80004744:	02813083          	ld	ra,40(sp)
    80004748:	02013403          	ld	s0,32(sp)
    8000474c:	01813483          	ld	s1,24(sp)
    80004750:	01013903          	ld	s2,16(sp)
    80004754:	00813983          	ld	s3,8(sp)
    80004758:	03010113          	addi	sp,sp,48
    8000475c:	00008067          	ret
        return nullptr;
    80004760:	00000513          	li	a0,0
    80004764:	fe1ff06f          	j	80004744 <_ZN15MemoryAllocator9mem_allocEm+0x170>

0000000080004768 <_ZN15MemoryAllocator8mem_freeEPv>:
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004768:	18050e63          	beqz	a0,80004904 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
int MemoryAllocator::mem_free(void *memSegment) {
    8000476c:	fc010113          	addi	sp,sp,-64
    80004770:	02113c23          	sd	ra,56(sp)
    80004774:	02813823          	sd	s0,48(sp)
    80004778:	02913423          	sd	s1,40(sp)
    8000477c:	03213023          	sd	s2,32(sp)
    80004780:	01313c23          	sd	s3,24(sp)
    80004784:	01413823          	sd	s4,16(sp)
    80004788:	01513423          	sd	s5,8(sp)
    8000478c:	04010413          	addi	s0,sp,64
    80004790:	00050913          	mv	s2,a0
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004794:	ff850493          	addi	s1,a0,-8
    80004798:	00000097          	auipc	ra,0x0
    8000479c:	dec080e7          	jalr	-532(ra) # 80004584 <_ZN15MemoryAllocator17userHeapStartAddrEv>
    800047a0:	00050993          	mv	s3,a0
    800047a4:	16a4e463          	bltu	s1,a0,8000490c <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800047a8:	ff893a03          	ld	s4,-8(s2)
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800047ac:	fffa0a93          	addi	s5,s4,-1
    800047b0:	01548ab3          	add	s5,s1,s5
    800047b4:	00000097          	auipc	ra,0x0
    800047b8:	dfc080e7          	jalr	-516(ra) # 800045b0 <_ZN15MemoryAllocator15userHeapEndAddrEv>
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800047bc:	14aafc63          	bgeu	s5,a0,80004914 <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800047c0:	14048e63          	beqz	s1,8000491c <_ZN15MemoryAllocator8mem_freeEPv+0x1b4>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)userHeapStartAddr();
    800047c4:	413489b3          	sub	s3,s1,s3
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800047c8:	03f9f993          	andi	s3,s3,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800047cc:	14099c63          	bnez	s3,80004924 <_ZN15MemoryAllocator8mem_freeEPv+0x1bc>
    800047d0:	03f00793          	li	a5,63
    800047d4:	1547fc63          	bgeu	a5,s4,8000492c <_ZN15MemoryAllocator8mem_freeEPv+0x1c4>
    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    800047d8:	00006797          	auipc	a5,0x6
    800047dc:	dd07b783          	ld	a5,-560(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800047e0:	02f50063          	beq	a0,a5,80004800 <_ZN15MemoryAllocator8mem_freeEPv+0x98>
    FreeSegment* curr = head, *prev = nullptr;
    800047e4:	00000693          	li	a3,0
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800047e8:	02078a63          	beqz	a5,8000481c <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
    800047ec:	0007b703          	ld	a4,0(a5)
    800047f0:	02977663          	bgeu	a4,s1,8000481c <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
        prev = curr;
    800047f4:	00078693          	mv	a3,a5
        curr = curr->next;
    800047f8:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    800047fc:	fedff06f          	j	800047e8 <_ZN15MemoryAllocator8mem_freeEPv+0x80>
        newFreeSegment->size = size;
    80004800:	01493023          	sd	s4,0(s2)
        newFreeSegment->baseAddr = memSegment;
    80004804:	fe993c23          	sd	s1,-8(s2)
        newFreeSegment->next = nullptr;
    80004808:	00093423          	sd	zero,8(s2)
        head = newFreeSegment;
    8000480c:	00006797          	auipc	a5,0x6
    80004810:	d897be23          	sd	s1,-612(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
        return 0;
    80004814:	00000513          	li	a0,0
    80004818:	0480006f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    if(prev == nullptr) {
    8000481c:	06068463          	beqz	a3,80004884 <_ZN15MemoryAllocator8mem_freeEPv+0x11c>
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80004820:	0006b703          	ld	a4,0(a3)
    80004824:	0086b603          	ld	a2,8(a3)
    80004828:	00c70733          	add	a4,a4,a2
    8000482c:	0a970663          	beq	a4,s1,800048d8 <_ZN15MemoryAllocator8mem_freeEPv+0x170>
            newFreeSegment->size = size;
    80004830:	01493023          	sd	s4,0(s2)
            newFreeSegment->baseAddr = memSegment;
    80004834:	fe993c23          	sd	s1,-8(s2)
            curr->next = prev->next;
    80004838:	0106b703          	ld	a4,16(a3)
    8000483c:	00e93423          	sd	a4,8(s2)
            prev->next = curr;
    80004840:	0096b823          	sd	s1,16(a3)
        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80004844:	0e078c63          	beqz	a5,8000493c <_ZN15MemoryAllocator8mem_freeEPv+0x1d4>
    80004848:	0007b603          	ld	a2,0(a5)
    8000484c:	0004b703          	ld	a4,0(s1)
    80004850:	0084b683          	ld	a3,8(s1)
    80004854:	00d70733          	add	a4,a4,a3
    80004858:	08e60863          	beq	a2,a4,800048e8 <_ZN15MemoryAllocator8mem_freeEPv+0x180>
    return 0;
    8000485c:	00000513          	li	a0,0
}
    80004860:	03813083          	ld	ra,56(sp)
    80004864:	03013403          	ld	s0,48(sp)
    80004868:	02813483          	ld	s1,40(sp)
    8000486c:	02013903          	ld	s2,32(sp)
    80004870:	01813983          	ld	s3,24(sp)
    80004874:	01013a03          	ld	s4,16(sp)
    80004878:	00813a83          	ld	s5,8(sp)
    8000487c:	04010113          	addi	sp,sp,64
    80004880:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80004884:	0a078863          	beqz	a5,80004934 <_ZN15MemoryAllocator8mem_freeEPv+0x1cc>
            newFreeSegment->size = size;
    80004888:	01493023          	sd	s4,0(s2)
            newFreeSegment->baseAddr = memSegment;
    8000488c:	fe993c23          	sd	s1,-8(s2)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80004890:	00006797          	auipc	a5,0x6
    80004894:	d187b783          	ld	a5,-744(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004898:	0007b683          	ld	a3,0(a5)
    8000489c:	01448733          	add	a4,s1,s4
    800048a0:	00e68c63          	beq	a3,a4,800048b8 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
                newFreeSegment->next = head;
    800048a4:	00f93423          	sd	a5,8(s2)
            head = newFreeSegment;
    800048a8:	00006797          	auipc	a5,0x6
    800048ac:	d097b023          	sd	s1,-768(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
            return 0;
    800048b0:	00000513          	li	a0,0
    800048b4:	fadff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
                newFreeSegment->size += head->size;
    800048b8:	0087b783          	ld	a5,8(a5)
    800048bc:	01478a33          	add	s4,a5,s4
    800048c0:	01493023          	sd	s4,0(s2)
                newFreeSegment->next = head->next;
    800048c4:	00006797          	auipc	a5,0x6
    800048c8:	ce47b783          	ld	a5,-796(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800048cc:	0107b783          	ld	a5,16(a5)
    800048d0:	00f93423          	sd	a5,8(s2)
    800048d4:	fd5ff06f          	j	800048a8 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
    800048d8:	01460a33          	add	s4,a2,s4
    800048dc:	0146b423          	sd	s4,8(a3)
    800048e0:	00068493          	mv	s1,a3
    800048e4:	f61ff06f          	j	80004844 <_ZN15MemoryAllocator8mem_freeEPv+0xdc>
            prev->size += curr->size;
    800048e8:	0087b703          	ld	a4,8(a5)
    800048ec:	00e686b3          	add	a3,a3,a4
    800048f0:	00d4b423          	sd	a3,8(s1)
            prev->next = curr->next;
    800048f4:	0107b783          	ld	a5,16(a5)
    800048f8:	00f4b823          	sd	a5,16(s1)
    return 0;
    800048fc:	00000513          	li	a0,0
    80004900:	f61ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004904:	fff00513          	li	a0,-1
}
    80004908:	00008067          	ret
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    8000490c:	fff00513          	li	a0,-1
    80004910:	f51ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
        return BAD_POINTER;
    80004914:	fff00513          	li	a0,-1
    80004918:	f49ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    8000491c:	fff00513          	li	a0,-1
    80004920:	f41ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    80004924:	fff00513          	li	a0,-1
    80004928:	f39ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    8000492c:	fff00513          	li	a0,-1
    80004930:	f31ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
            return BAD_POINTER;
    80004934:	fff00513          	li	a0,-1
    80004938:	f29ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    return 0;
    8000493c:	00000513          	li	a0,0
    80004940:	f21ff06f          	j	80004860 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>

0000000080004944 <_Z9kmem_initPvi>:
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    80004944:	ff010113          	addi	sp,sp,-16
    80004948:	00113423          	sd	ra,8(sp)
    8000494c:	00813023          	sd	s0,0(sp)
    80004950:	01010413          	addi	s0,sp,16
    SlabAllocator::initAllocator(space, block_num);
    80004954:	ffffe097          	auipc	ra,0xffffe
    80004958:	d04080e7          	jalr	-764(ra) # 80002658 <_ZN13SlabAllocator13initAllocatorEPvi>
}
    8000495c:	00813083          	ld	ra,8(sp)
    80004960:	00013403          	ld	s0,0(sp)
    80004964:	01010113          	addi	sp,sp,16
    80004968:	00008067          	ret

000000008000496c <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    8000496c:	ff010113          	addi	sp,sp,-16
    80004970:	00113423          	sd	ra,8(sp)
    80004974:	00813023          	sd	s0,0(sp)
    80004978:	01010413          	addi	s0,sp,16
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
    8000497c:	ffffe097          	auipc	ra,0xffffe
    80004980:	d04080e7          	jalr	-764(ra) # 80002680 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004984:	00813083          	ld	ra,8(sp)
    80004988:	00013403          	ld	s0,0(sp)
    8000498c:	01010113          	addi	sp,sp,16
    80004990:	00008067          	ret

0000000080004994 <_Z17kmem_cache_shrinkP12kmem_cache_s>:

int kmem_cache_shrink(kmem_cache_t *cachep) {
    80004994:	ff010113          	addi	sp,sp,-16
    80004998:	00113423          	sd	ra,8(sp)
    8000499c:	00813023          	sd	s0,0(sp)
    800049a0:	01010413          	addi	s0,sp,16
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	e04080e7          	jalr	-508(ra) # 800027a8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>
}
    800049ac:	00813083          	ld	ra,8(sp)
    800049b0:	00013403          	ld	s0,0(sp)
    800049b4:	01010113          	addi	sp,sp,16
    800049b8:	00008067          	ret

00000000800049bc <_Z16kmem_cache_allocP12kmem_cache_s>:
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    800049bc:	ff010113          	addi	sp,sp,-16
    800049c0:	00113423          	sd	ra,8(sp)
    800049c4:	00813023          	sd	s0,0(sp)
    800049c8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocSlot((Cache*)cachep);
    800049cc:	ffffe097          	auipc	ra,0xffffe
    800049d0:	d34080e7          	jalr	-716(ra) # 80002700 <_ZN13SlabAllocator9allocSlotEP5Cache>
}
    800049d4:	00813083          	ld	ra,8(sp)
    800049d8:	00013403          	ld	s0,0(sp)
    800049dc:	01010113          	addi	sp,sp,16
    800049e0:	00008067          	ret

00000000800049e4 <_Z15kmem_cache_freeP12kmem_cache_sPv>:
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    800049e4:	ff010113          	addi	sp,sp,-16
    800049e8:	00113423          	sd	ra,8(sp)
    800049ec:	00813023          	sd	s0,0(sp)
    800049f0:	01010413          	addi	s0,sp,16
    SlabAllocator::freeSlot((Cache*)cachep, objp);
    800049f4:	ffffe097          	auipc	ra,0xffffe
    800049f8:	d38080e7          	jalr	-712(ra) # 8000272c <_ZN13SlabAllocator8freeSlotEP5CachePv>
}
    800049fc:	00813083          	ld	ra,8(sp)
    80004a00:	00013403          	ld	s0,0(sp)
    80004a04:	01010113          	addi	sp,sp,16
    80004a08:	00008067          	ret

0000000080004a0c <_Z7kmallocm>:

void *kmalloc(size_t size) {
    80004a0c:	ff010113          	addi	sp,sp,-16
    80004a10:	00113423          	sd	ra,8(sp)
    80004a14:	00813023          	sd	s0,0(sp)
    80004a18:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocBuff(size);
    80004a1c:	ffffe097          	auipc	ra,0xffffe
    80004a20:	ddc080e7          	jalr	-548(ra) # 800027f8 <_ZN13SlabAllocator9allocBuffEm>
}
    80004a24:	00813083          	ld	ra,8(sp)
    80004a28:	00013403          	ld	s0,0(sp)
    80004a2c:	01010113          	addi	sp,sp,16
    80004a30:	00008067          	ret

0000000080004a34 <_Z5kfreePKv>:

void kfree(const void *objp) {
    80004a34:	ff010113          	addi	sp,sp,-16
    80004a38:	00113423          	sd	ra,8(sp)
    80004a3c:	00813023          	sd	s0,0(sp)
    80004a40:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuff(objp);
    80004a44:	ffffe097          	auipc	ra,0xffffe
    80004a48:	de0080e7          	jalr	-544(ra) # 80002824 <_ZN13SlabAllocator8freeBuffEPKv>
}
    80004a4c:	00813083          	ld	ra,8(sp)
    80004a50:	00013403          	ld	s0,0(sp)
    80004a54:	01010113          	addi	sp,sp,16
    80004a58:	00008067          	ret

0000000080004a5c <_Z18kmem_cache_destroyP12kmem_cache_s>:

void kmem_cache_destroy(kmem_cache_t *cachep) {
    80004a5c:	ff010113          	addi	sp,sp,-16
    80004a60:	00113423          	sd	ra,8(sp)
    80004a64:	00813023          	sd	s0,0(sp)
    80004a68:	01010413          	addi	s0,sp,16
    SlabAllocator::deallocCache((Cache*)cachep);
    80004a6c:	ffffe097          	auipc	ra,0xffffe
    80004a70:	d64080e7          	jalr	-668(ra) # 800027d0 <_ZN13SlabAllocator12deallocCacheEP5Cache>
}
    80004a74:	00813083          	ld	ra,8(sp)
    80004a78:	00013403          	ld	s0,0(sp)
    80004a7c:	01010113          	addi	sp,sp,16
    80004a80:	00008067          	ret

0000000080004a84 <_Z15kmem_cache_infoP12kmem_cache_s>:
void kmem_cache_info(kmem_cache_t *cachep) {
    80004a84:	ff010113          	addi	sp,sp,-16
    80004a88:	00113423          	sd	ra,8(sp)
    80004a8c:	00813023          	sd	s0,0(sp)
    80004a90:	01010413          	addi	s0,sp,16
    SlabAllocator::printCacheInfo((Cache*)cachep);
    80004a94:	ffffe097          	auipc	ra,0xffffe
    80004a98:	cec080e7          	jalr	-788(ra) # 80002780 <_ZN13SlabAllocator14printCacheInfoEP5Cache>
}
    80004a9c:	00813083          	ld	ra,8(sp)
    80004aa0:	00013403          	ld	s0,0(sp)
    80004aa4:	01010113          	addi	sp,sp,16
    80004aa8:	00008067          	ret

0000000080004aac <_Z16kmem_cache_errorP12kmem_cache_s>:
int kmem_cache_error(kmem_cache_t *cachep) {
    80004aac:	ff010113          	addi	sp,sp,-16
    80004ab0:	00113423          	sd	ra,8(sp)
    80004ab4:	00813023          	sd	s0,0(sp)
    80004ab8:	01010413          	addi	s0,sp,16
    return SlabAllocator::printErrorMessage((Cache*)cachep);
    80004abc:	ffffe097          	auipc	ra,0xffffe
    80004ac0:	c9c080e7          	jalr	-868(ra) # 80002758 <_ZN13SlabAllocator17printErrorMessageEP5Cache>
    80004ac4:	00813083          	ld	ra,8(sp)
    80004ac8:	00013403          	ld	s0,0(sp)
    80004acc:	01010113          	addi	sp,sp,16
    80004ad0:	00008067          	ret

0000000080004ad4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004ad4:	fd010113          	addi	sp,sp,-48
    80004ad8:	02113423          	sd	ra,40(sp)
    80004adc:	02813023          	sd	s0,32(sp)
    80004ae0:	00913c23          	sd	s1,24(sp)
    80004ae4:	01213823          	sd	s2,16(sp)
    80004ae8:	01313423          	sd	s3,8(sp)
    80004aec:	03010413          	addi	s0,sp,48
    80004af0:	00050493          	mv	s1,a0
    80004af4:	00058993          	mv	s3,a1
    80004af8:	0015879b          	addiw	a5,a1,1
    80004afc:	0007851b          	sext.w	a0,a5
    80004b00:	00f4a023          	sw	a5,0(s1)
    80004b04:	0004a823          	sw	zero,16(s1)
    80004b08:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004b0c:	00251513          	slli	a0,a0,0x2
    80004b10:	ffffc097          	auipc	ra,0xffffc
    80004b14:	684080e7          	jalr	1668(ra) # 80001194 <_Z9mem_allocm>
    80004b18:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004b1c:	01000513          	li	a0,16
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	a9c080e7          	jalr	-1380(ra) # 800035bc <_ZN9SemaphorenwEm>
    80004b28:	00050913          	mv	s2,a0
    80004b2c:	00050863          	beqz	a0,80004b3c <_ZN9BufferCPPC1Ei+0x68>
    80004b30:	00000593          	li	a1,0
    80004b34:	fffff097          	auipc	ra,0xfffff
    80004b38:	980080e7          	jalr	-1664(ra) # 800034b4 <_ZN9SemaphoreC1Ej>
    80004b3c:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004b40:	01000513          	li	a0,16
    80004b44:	fffff097          	auipc	ra,0xfffff
    80004b48:	a78080e7          	jalr	-1416(ra) # 800035bc <_ZN9SemaphorenwEm>
    80004b4c:	00050913          	mv	s2,a0
    80004b50:	00050863          	beqz	a0,80004b60 <_ZN9BufferCPPC1Ei+0x8c>
    80004b54:	00098593          	mv	a1,s3
    80004b58:	fffff097          	auipc	ra,0xfffff
    80004b5c:	95c080e7          	jalr	-1700(ra) # 800034b4 <_ZN9SemaphoreC1Ej>
    80004b60:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80004b64:	01000513          	li	a0,16
    80004b68:	fffff097          	auipc	ra,0xfffff
    80004b6c:	a54080e7          	jalr	-1452(ra) # 800035bc <_ZN9SemaphorenwEm>
    80004b70:	00050913          	mv	s2,a0
    80004b74:	00050863          	beqz	a0,80004b84 <_ZN9BufferCPPC1Ei+0xb0>
    80004b78:	00100593          	li	a1,1
    80004b7c:	fffff097          	auipc	ra,0xfffff
    80004b80:	938080e7          	jalr	-1736(ra) # 800034b4 <_ZN9SemaphoreC1Ej>
    80004b84:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004b88:	01000513          	li	a0,16
    80004b8c:	fffff097          	auipc	ra,0xfffff
    80004b90:	a30080e7          	jalr	-1488(ra) # 800035bc <_ZN9SemaphorenwEm>
    80004b94:	00050913          	mv	s2,a0
    80004b98:	00050863          	beqz	a0,80004ba8 <_ZN9BufferCPPC1Ei+0xd4>
    80004b9c:	00100593          	li	a1,1
    80004ba0:	fffff097          	auipc	ra,0xfffff
    80004ba4:	914080e7          	jalr	-1772(ra) # 800034b4 <_ZN9SemaphoreC1Ej>
    80004ba8:	0324b823          	sd	s2,48(s1)
}
    80004bac:	02813083          	ld	ra,40(sp)
    80004bb0:	02013403          	ld	s0,32(sp)
    80004bb4:	01813483          	ld	s1,24(sp)
    80004bb8:	01013903          	ld	s2,16(sp)
    80004bbc:	00813983          	ld	s3,8(sp)
    80004bc0:	03010113          	addi	sp,sp,48
    80004bc4:	00008067          	ret
    80004bc8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004bcc:	00090513          	mv	a0,s2
    80004bd0:	fffff097          	auipc	ra,0xfffff
    80004bd4:	984080e7          	jalr	-1660(ra) # 80003554 <_ZN9SemaphoredlEPv>
    80004bd8:	00048513          	mv	a0,s1
    80004bdc:	00007097          	auipc	ra,0x7
    80004be0:	a9c080e7          	jalr	-1380(ra) # 8000b678 <_Unwind_Resume>
    80004be4:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004be8:	00090513          	mv	a0,s2
    80004bec:	fffff097          	auipc	ra,0xfffff
    80004bf0:	968080e7          	jalr	-1688(ra) # 80003554 <_ZN9SemaphoredlEPv>
    80004bf4:	00048513          	mv	a0,s1
    80004bf8:	00007097          	auipc	ra,0x7
    80004bfc:	a80080e7          	jalr	-1408(ra) # 8000b678 <_Unwind_Resume>
    80004c00:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004c04:	00090513          	mv	a0,s2
    80004c08:	fffff097          	auipc	ra,0xfffff
    80004c0c:	94c080e7          	jalr	-1716(ra) # 80003554 <_ZN9SemaphoredlEPv>
    80004c10:	00048513          	mv	a0,s1
    80004c14:	00007097          	auipc	ra,0x7
    80004c18:	a64080e7          	jalr	-1436(ra) # 8000b678 <_Unwind_Resume>
    80004c1c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004c20:	00090513          	mv	a0,s2
    80004c24:	fffff097          	auipc	ra,0xfffff
    80004c28:	930080e7          	jalr	-1744(ra) # 80003554 <_ZN9SemaphoredlEPv>
    80004c2c:	00048513          	mv	a0,s1
    80004c30:	00007097          	auipc	ra,0x7
    80004c34:	a48080e7          	jalr	-1464(ra) # 8000b678 <_Unwind_Resume>

0000000080004c38 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004c38:	fe010113          	addi	sp,sp,-32
    80004c3c:	00113c23          	sd	ra,24(sp)
    80004c40:	00813823          	sd	s0,16(sp)
    80004c44:	00913423          	sd	s1,8(sp)
    80004c48:	01213023          	sd	s2,0(sp)
    80004c4c:	02010413          	addi	s0,sp,32
    80004c50:	00050493          	mv	s1,a0
    80004c54:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004c58:	01853503          	ld	a0,24(a0)
    80004c5c:	fffff097          	auipc	ra,0xfffff
    80004c60:	8a0080e7          	jalr	-1888(ra) # 800034fc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004c64:	0304b503          	ld	a0,48(s1)
    80004c68:	fffff097          	auipc	ra,0xfffff
    80004c6c:	894080e7          	jalr	-1900(ra) # 800034fc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004c70:	0084b783          	ld	a5,8(s1)
    80004c74:	0144a703          	lw	a4,20(s1)
    80004c78:	00271713          	slli	a4,a4,0x2
    80004c7c:	00e787b3          	add	a5,a5,a4
    80004c80:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004c84:	0144a783          	lw	a5,20(s1)
    80004c88:	0017879b          	addiw	a5,a5,1
    80004c8c:	0004a703          	lw	a4,0(s1)
    80004c90:	02e7e7bb          	remw	a5,a5,a4
    80004c94:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004c98:	0304b503          	ld	a0,48(s1)
    80004c9c:	fffff097          	auipc	ra,0xfffff
    80004ca0:	88c080e7          	jalr	-1908(ra) # 80003528 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004ca4:	0204b503          	ld	a0,32(s1)
    80004ca8:	fffff097          	auipc	ra,0xfffff
    80004cac:	880080e7          	jalr	-1920(ra) # 80003528 <_ZN9Semaphore6signalEv>

}
    80004cb0:	01813083          	ld	ra,24(sp)
    80004cb4:	01013403          	ld	s0,16(sp)
    80004cb8:	00813483          	ld	s1,8(sp)
    80004cbc:	00013903          	ld	s2,0(sp)
    80004cc0:	02010113          	addi	sp,sp,32
    80004cc4:	00008067          	ret

0000000080004cc8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004cc8:	fe010113          	addi	sp,sp,-32
    80004ccc:	00113c23          	sd	ra,24(sp)
    80004cd0:	00813823          	sd	s0,16(sp)
    80004cd4:	00913423          	sd	s1,8(sp)
    80004cd8:	01213023          	sd	s2,0(sp)
    80004cdc:	02010413          	addi	s0,sp,32
    80004ce0:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004ce4:	02053503          	ld	a0,32(a0)
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	814080e7          	jalr	-2028(ra) # 800034fc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004cf0:	0284b503          	ld	a0,40(s1)
    80004cf4:	fffff097          	auipc	ra,0xfffff
    80004cf8:	808080e7          	jalr	-2040(ra) # 800034fc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004cfc:	0084b703          	ld	a4,8(s1)
    80004d00:	0104a783          	lw	a5,16(s1)
    80004d04:	00279693          	slli	a3,a5,0x2
    80004d08:	00d70733          	add	a4,a4,a3
    80004d0c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004d10:	0017879b          	addiw	a5,a5,1
    80004d14:	0004a703          	lw	a4,0(s1)
    80004d18:	02e7e7bb          	remw	a5,a5,a4
    80004d1c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004d20:	0284b503          	ld	a0,40(s1)
    80004d24:	fffff097          	auipc	ra,0xfffff
    80004d28:	804080e7          	jalr	-2044(ra) # 80003528 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004d2c:	0184b503          	ld	a0,24(s1)
    80004d30:	ffffe097          	auipc	ra,0xffffe
    80004d34:	7f8080e7          	jalr	2040(ra) # 80003528 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004d38:	00090513          	mv	a0,s2
    80004d3c:	01813083          	ld	ra,24(sp)
    80004d40:	01013403          	ld	s0,16(sp)
    80004d44:	00813483          	ld	s1,8(sp)
    80004d48:	00013903          	ld	s2,0(sp)
    80004d4c:	02010113          	addi	sp,sp,32
    80004d50:	00008067          	ret

0000000080004d54 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004d54:	fe010113          	addi	sp,sp,-32
    80004d58:	00113c23          	sd	ra,24(sp)
    80004d5c:	00813823          	sd	s0,16(sp)
    80004d60:	00913423          	sd	s1,8(sp)
    80004d64:	01213023          	sd	s2,0(sp)
    80004d68:	02010413          	addi	s0,sp,32
    80004d6c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004d70:	02853503          	ld	a0,40(a0)
    80004d74:	ffffe097          	auipc	ra,0xffffe
    80004d78:	788080e7          	jalr	1928(ra) # 800034fc <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004d7c:	0304b503          	ld	a0,48(s1)
    80004d80:	ffffe097          	auipc	ra,0xffffe
    80004d84:	77c080e7          	jalr	1916(ra) # 800034fc <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004d88:	0144a783          	lw	a5,20(s1)
    80004d8c:	0104a903          	lw	s2,16(s1)
    80004d90:	0327ce63          	blt	a5,s2,80004dcc <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004d94:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004d98:	0304b503          	ld	a0,48(s1)
    80004d9c:	ffffe097          	auipc	ra,0xffffe
    80004da0:	78c080e7          	jalr	1932(ra) # 80003528 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004da4:	0284b503          	ld	a0,40(s1)
    80004da8:	ffffe097          	auipc	ra,0xffffe
    80004dac:	780080e7          	jalr	1920(ra) # 80003528 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004db0:	00090513          	mv	a0,s2
    80004db4:	01813083          	ld	ra,24(sp)
    80004db8:	01013403          	ld	s0,16(sp)
    80004dbc:	00813483          	ld	s1,8(sp)
    80004dc0:	00013903          	ld	s2,0(sp)
    80004dc4:	02010113          	addi	sp,sp,32
    80004dc8:	00008067          	ret
        ret = cap - head + tail;
    80004dcc:	0004a703          	lw	a4,0(s1)
    80004dd0:	4127093b          	subw	s2,a4,s2
    80004dd4:	00f9093b          	addw	s2,s2,a5
    80004dd8:	fc1ff06f          	j	80004d98 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004ddc <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004ddc:	fe010113          	addi	sp,sp,-32
    80004de0:	00113c23          	sd	ra,24(sp)
    80004de4:	00813823          	sd	s0,16(sp)
    80004de8:	00913423          	sd	s1,8(sp)
    80004dec:	02010413          	addi	s0,sp,32
    80004df0:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004df4:	00a00513          	li	a0,10
    80004df8:	fffff097          	auipc	ra,0xfffff
    80004dfc:	894080e7          	jalr	-1900(ra) # 8000368c <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004e00:	00003517          	auipc	a0,0x3
    80004e04:	52850513          	addi	a0,a0,1320 # 80008328 <CONSOLE_STATUS+0x318>
    80004e08:	ffffe097          	auipc	ra,0xffffe
    80004e0c:	a48080e7          	jalr	-1464(ra) # 80002850 <_Z11printStringPKc>
    while (getCnt()) {
    80004e10:	00048513          	mv	a0,s1
    80004e14:	00000097          	auipc	ra,0x0
    80004e18:	f40080e7          	jalr	-192(ra) # 80004d54 <_ZN9BufferCPP6getCntEv>
    80004e1c:	02050c63          	beqz	a0,80004e54 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004e20:	0084b783          	ld	a5,8(s1)
    80004e24:	0104a703          	lw	a4,16(s1)
    80004e28:	00271713          	slli	a4,a4,0x2
    80004e2c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004e30:	0007c503          	lbu	a0,0(a5)
    80004e34:	fffff097          	auipc	ra,0xfffff
    80004e38:	858080e7          	jalr	-1960(ra) # 8000368c <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004e3c:	0104a783          	lw	a5,16(s1)
    80004e40:	0017879b          	addiw	a5,a5,1
    80004e44:	0004a703          	lw	a4,0(s1)
    80004e48:	02e7e7bb          	remw	a5,a5,a4
    80004e4c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004e50:	fc1ff06f          	j	80004e10 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004e54:	02100513          	li	a0,33
    80004e58:	fffff097          	auipc	ra,0xfffff
    80004e5c:	834080e7          	jalr	-1996(ra) # 8000368c <_ZN7Console4putcEc>
    Console::putc('\n');
    80004e60:	00a00513          	li	a0,10
    80004e64:	fffff097          	auipc	ra,0xfffff
    80004e68:	828080e7          	jalr	-2008(ra) # 8000368c <_ZN7Console4putcEc>
    mem_free(buffer);
    80004e6c:	0084b503          	ld	a0,8(s1)
    80004e70:	ffffc097          	auipc	ra,0xffffc
    80004e74:	364080e7          	jalr	868(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80004e78:	0204b503          	ld	a0,32(s1)
    80004e7c:	00050863          	beqz	a0,80004e8c <_ZN9BufferCPPD1Ev+0xb0>
    80004e80:	00053783          	ld	a5,0(a0)
    80004e84:	0087b783          	ld	a5,8(a5)
    80004e88:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004e8c:	0184b503          	ld	a0,24(s1)
    80004e90:	00050863          	beqz	a0,80004ea0 <_ZN9BufferCPPD1Ev+0xc4>
    80004e94:	00053783          	ld	a5,0(a0)
    80004e98:	0087b783          	ld	a5,8(a5)
    80004e9c:	000780e7          	jalr	a5
    delete mutexTail;
    80004ea0:	0304b503          	ld	a0,48(s1)
    80004ea4:	00050863          	beqz	a0,80004eb4 <_ZN9BufferCPPD1Ev+0xd8>
    80004ea8:	00053783          	ld	a5,0(a0)
    80004eac:	0087b783          	ld	a5,8(a5)
    80004eb0:	000780e7          	jalr	a5
    delete mutexHead;
    80004eb4:	0284b503          	ld	a0,40(s1)
    80004eb8:	00050863          	beqz	a0,80004ec8 <_ZN9BufferCPPD1Ev+0xec>
    80004ebc:	00053783          	ld	a5,0(a0)
    80004ec0:	0087b783          	ld	a5,8(a5)
    80004ec4:	000780e7          	jalr	a5
}
    80004ec8:	01813083          	ld	ra,24(sp)
    80004ecc:	01013403          	ld	s0,16(sp)
    80004ed0:	00813483          	ld	s1,8(sp)
    80004ed4:	02010113          	addi	sp,sp,32
    80004ed8:	00008067          	ret

0000000080004edc <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004edc:	fe010113          	addi	sp,sp,-32
    80004ee0:	00113c23          	sd	ra,24(sp)
    80004ee4:	00813823          	sd	s0,16(sp)
    80004ee8:	00913423          	sd	s1,8(sp)
    80004eec:	01213023          	sd	s2,0(sp)
    80004ef0:	02010413          	addi	s0,sp,32
    80004ef4:	00050493          	mv	s1,a0
    80004ef8:	00058913          	mv	s2,a1
    80004efc:	0015879b          	addiw	a5,a1,1
    80004f00:	0007851b          	sext.w	a0,a5
    80004f04:	00f4a023          	sw	a5,0(s1)
    80004f08:	0004a823          	sw	zero,16(s1)
    80004f0c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004f10:	00251513          	slli	a0,a0,0x2
    80004f14:	ffffc097          	auipc	ra,0xffffc
    80004f18:	280080e7          	jalr	640(ra) # 80001194 <_Z9mem_allocm>
    80004f1c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004f20:	00000593          	li	a1,0
    80004f24:	02048513          	addi	a0,s1,32
    80004f28:	ffffc097          	auipc	ra,0xffffc
    80004f2c:	428080e7          	jalr	1064(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80004f30:	00090593          	mv	a1,s2
    80004f34:	01848513          	addi	a0,s1,24
    80004f38:	ffffc097          	auipc	ra,0xffffc
    80004f3c:	418080e7          	jalr	1048(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80004f40:	00100593          	li	a1,1
    80004f44:	02848513          	addi	a0,s1,40
    80004f48:	ffffc097          	auipc	ra,0xffffc
    80004f4c:	408080e7          	jalr	1032(ra) # 80001350 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80004f50:	00100593          	li	a1,1
    80004f54:	03048513          	addi	a0,s1,48
    80004f58:	ffffc097          	auipc	ra,0xffffc
    80004f5c:	3f8080e7          	jalr	1016(ra) # 80001350 <_Z8sem_openPP3SCBj>
}
    80004f60:	01813083          	ld	ra,24(sp)
    80004f64:	01013403          	ld	s0,16(sp)
    80004f68:	00813483          	ld	s1,8(sp)
    80004f6c:	00013903          	ld	s2,0(sp)
    80004f70:	02010113          	addi	sp,sp,32
    80004f74:	00008067          	ret

0000000080004f78 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004f78:	fe010113          	addi	sp,sp,-32
    80004f7c:	00113c23          	sd	ra,24(sp)
    80004f80:	00813823          	sd	s0,16(sp)
    80004f84:	00913423          	sd	s1,8(sp)
    80004f88:	01213023          	sd	s2,0(sp)
    80004f8c:	02010413          	addi	s0,sp,32
    80004f90:	00050493          	mv	s1,a0
    80004f94:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004f98:	01853503          	ld	a0,24(a0)
    80004f9c:	ffffc097          	auipc	ra,0xffffc
    80004fa0:	3fc080e7          	jalr	1020(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80004fa4:	0304b503          	ld	a0,48(s1)
    80004fa8:	ffffc097          	auipc	ra,0xffffc
    80004fac:	3f0080e7          	jalr	1008(ra) # 80001398 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80004fb0:	0084b783          	ld	a5,8(s1)
    80004fb4:	0144a703          	lw	a4,20(s1)
    80004fb8:	00271713          	slli	a4,a4,0x2
    80004fbc:	00e787b3          	add	a5,a5,a4
    80004fc0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004fc4:	0144a783          	lw	a5,20(s1)
    80004fc8:	0017879b          	addiw	a5,a5,1
    80004fcc:	0004a703          	lw	a4,0(s1)
    80004fd0:	02e7e7bb          	remw	a5,a5,a4
    80004fd4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004fd8:	0304b503          	ld	a0,48(s1)
    80004fdc:	ffffc097          	auipc	ra,0xffffc
    80004fe0:	404080e7          	jalr	1028(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    80004fe4:	0204b503          	ld	a0,32(s1)
    80004fe8:	ffffc097          	auipc	ra,0xffffc
    80004fec:	3f8080e7          	jalr	1016(ra) # 800013e0 <_Z10sem_signalP3SCB>

}
    80004ff0:	01813083          	ld	ra,24(sp)
    80004ff4:	01013403          	ld	s0,16(sp)
    80004ff8:	00813483          	ld	s1,8(sp)
    80004ffc:	00013903          	ld	s2,0(sp)
    80005000:	02010113          	addi	sp,sp,32
    80005004:	00008067          	ret

0000000080005008 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005008:	fe010113          	addi	sp,sp,-32
    8000500c:	00113c23          	sd	ra,24(sp)
    80005010:	00813823          	sd	s0,16(sp)
    80005014:	00913423          	sd	s1,8(sp)
    80005018:	01213023          	sd	s2,0(sp)
    8000501c:	02010413          	addi	s0,sp,32
    80005020:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005024:	02053503          	ld	a0,32(a0)
    80005028:	ffffc097          	auipc	ra,0xffffc
    8000502c:	370080e7          	jalr	880(ra) # 80001398 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80005030:	0284b503          	ld	a0,40(s1)
    80005034:	ffffc097          	auipc	ra,0xffffc
    80005038:	364080e7          	jalr	868(ra) # 80001398 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    8000503c:	0084b703          	ld	a4,8(s1)
    80005040:	0104a783          	lw	a5,16(s1)
    80005044:	00279693          	slli	a3,a5,0x2
    80005048:	00d70733          	add	a4,a4,a3
    8000504c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005050:	0017879b          	addiw	a5,a5,1
    80005054:	0004a703          	lw	a4,0(s1)
    80005058:	02e7e7bb          	remw	a5,a5,a4
    8000505c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005060:	0284b503          	ld	a0,40(s1)
    80005064:	ffffc097          	auipc	ra,0xffffc
    80005068:	37c080e7          	jalr	892(ra) # 800013e0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    8000506c:	0184b503          	ld	a0,24(s1)
    80005070:	ffffc097          	auipc	ra,0xffffc
    80005074:	370080e7          	jalr	880(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    80005078:	00090513          	mv	a0,s2
    8000507c:	01813083          	ld	ra,24(sp)
    80005080:	01013403          	ld	s0,16(sp)
    80005084:	00813483          	ld	s1,8(sp)
    80005088:	00013903          	ld	s2,0(sp)
    8000508c:	02010113          	addi	sp,sp,32
    80005090:	00008067          	ret

0000000080005094 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005094:	fe010113          	addi	sp,sp,-32
    80005098:	00113c23          	sd	ra,24(sp)
    8000509c:	00813823          	sd	s0,16(sp)
    800050a0:	00913423          	sd	s1,8(sp)
    800050a4:	01213023          	sd	s2,0(sp)
    800050a8:	02010413          	addi	s0,sp,32
    800050ac:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800050b0:	02853503          	ld	a0,40(a0)
    800050b4:	ffffc097          	auipc	ra,0xffffc
    800050b8:	2e4080e7          	jalr	740(ra) # 80001398 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    800050bc:	0304b503          	ld	a0,48(s1)
    800050c0:	ffffc097          	auipc	ra,0xffffc
    800050c4:	2d8080e7          	jalr	728(ra) # 80001398 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    800050c8:	0144a783          	lw	a5,20(s1)
    800050cc:	0104a903          	lw	s2,16(s1)
    800050d0:	0327ce63          	blt	a5,s2,8000510c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800050d4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800050d8:	0304b503          	ld	a0,48(s1)
    800050dc:	ffffc097          	auipc	ra,0xffffc
    800050e0:	304080e7          	jalr	772(ra) # 800013e0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    800050e4:	0284b503          	ld	a0,40(s1)
    800050e8:	ffffc097          	auipc	ra,0xffffc
    800050ec:	2f8080e7          	jalr	760(ra) # 800013e0 <_Z10sem_signalP3SCB>

    return ret;
}
    800050f0:	00090513          	mv	a0,s2
    800050f4:	01813083          	ld	ra,24(sp)
    800050f8:	01013403          	ld	s0,16(sp)
    800050fc:	00813483          	ld	s1,8(sp)
    80005100:	00013903          	ld	s2,0(sp)
    80005104:	02010113          	addi	sp,sp,32
    80005108:	00008067          	ret
        ret = cap - head + tail;
    8000510c:	0004a703          	lw	a4,0(s1)
    80005110:	4127093b          	subw	s2,a4,s2
    80005114:	00f9093b          	addw	s2,s2,a5
    80005118:	fc1ff06f          	j	800050d8 <_ZN6Buffer6getCntEv+0x44>

000000008000511c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000511c:	fe010113          	addi	sp,sp,-32
    80005120:	00113c23          	sd	ra,24(sp)
    80005124:	00813823          	sd	s0,16(sp)
    80005128:	00913423          	sd	s1,8(sp)
    8000512c:	02010413          	addi	s0,sp,32
    80005130:	00050493          	mv	s1,a0
    putc('\n');
    80005134:	00a00513          	li	a0,10
    80005138:	ffffc097          	auipc	ra,0xffffc
    8000513c:	3a0080e7          	jalr	928(ra) # 800014d8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005140:	00003517          	auipc	a0,0x3
    80005144:	1e850513          	addi	a0,a0,488 # 80008328 <CONSOLE_STATUS+0x318>
    80005148:	ffffd097          	auipc	ra,0xffffd
    8000514c:	708080e7          	jalr	1800(ra) # 80002850 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005150:	00048513          	mv	a0,s1
    80005154:	00000097          	auipc	ra,0x0
    80005158:	f40080e7          	jalr	-192(ra) # 80005094 <_ZN6Buffer6getCntEv>
    8000515c:	02a05c63          	blez	a0,80005194 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005160:	0084b783          	ld	a5,8(s1)
    80005164:	0104a703          	lw	a4,16(s1)
    80005168:	00271713          	slli	a4,a4,0x2
    8000516c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005170:	0007c503          	lbu	a0,0(a5)
    80005174:	ffffc097          	auipc	ra,0xffffc
    80005178:	364080e7          	jalr	868(ra) # 800014d8 <_Z4putcc>
        head = (head + 1) % cap;
    8000517c:	0104a783          	lw	a5,16(s1)
    80005180:	0017879b          	addiw	a5,a5,1
    80005184:	0004a703          	lw	a4,0(s1)
    80005188:	02e7e7bb          	remw	a5,a5,a4
    8000518c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005190:	fc1ff06f          	j	80005150 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005194:	02100513          	li	a0,33
    80005198:	ffffc097          	auipc	ra,0xffffc
    8000519c:	340080e7          	jalr	832(ra) # 800014d8 <_Z4putcc>
    putc('\n');
    800051a0:	00a00513          	li	a0,10
    800051a4:	ffffc097          	auipc	ra,0xffffc
    800051a8:	334080e7          	jalr	820(ra) # 800014d8 <_Z4putcc>
    mem_free(buffer);
    800051ac:	0084b503          	ld	a0,8(s1)
    800051b0:	ffffc097          	auipc	ra,0xffffc
    800051b4:	024080e7          	jalr	36(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800051b8:	0204b503          	ld	a0,32(s1)
    800051bc:	ffffc097          	auipc	ra,0xffffc
    800051c0:	264080e7          	jalr	612(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    800051c4:	0184b503          	ld	a0,24(s1)
    800051c8:	ffffc097          	auipc	ra,0xffffc
    800051cc:	258080e7          	jalr	600(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    800051d0:	0304b503          	ld	a0,48(s1)
    800051d4:	ffffc097          	auipc	ra,0xffffc
    800051d8:	24c080e7          	jalr	588(ra) # 80001420 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    800051dc:	0284b503          	ld	a0,40(s1)
    800051e0:	ffffc097          	auipc	ra,0xffffc
    800051e4:	240080e7          	jalr	576(ra) # 80001420 <_Z9sem_closeP3SCB>
}
    800051e8:	01813083          	ld	ra,24(sp)
    800051ec:	01013403          	ld	s0,16(sp)
    800051f0:	00813483          	ld	s1,8(sp)
    800051f4:	02010113          	addi	sp,sp,32
    800051f8:	00008067          	ret

00000000800051fc <start>:
    800051fc:	ff010113          	addi	sp,sp,-16
    80005200:	00813423          	sd	s0,8(sp)
    80005204:	01010413          	addi	s0,sp,16
    80005208:	300027f3          	csrr	a5,mstatus
    8000520c:	ffffe737          	lui	a4,0xffffe
    80005210:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff2fef>
    80005214:	00e7f7b3          	and	a5,a5,a4
    80005218:	00001737          	lui	a4,0x1
    8000521c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005220:	00e7e7b3          	or	a5,a5,a4
    80005224:	30079073          	csrw	mstatus,a5
    80005228:	00000797          	auipc	a5,0x0
    8000522c:	16078793          	addi	a5,a5,352 # 80005388 <system_main>
    80005230:	34179073          	csrw	mepc,a5
    80005234:	00000793          	li	a5,0
    80005238:	18079073          	csrw	satp,a5
    8000523c:	000107b7          	lui	a5,0x10
    80005240:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005244:	30279073          	csrw	medeleg,a5
    80005248:	30379073          	csrw	mideleg,a5
    8000524c:	104027f3          	csrr	a5,sie
    80005250:	2227e793          	ori	a5,a5,546
    80005254:	10479073          	csrw	sie,a5
    80005258:	fff00793          	li	a5,-1
    8000525c:	00a7d793          	srli	a5,a5,0xa
    80005260:	3b079073          	csrw	pmpaddr0,a5
    80005264:	00f00793          	li	a5,15
    80005268:	3a079073          	csrw	pmpcfg0,a5
    8000526c:	f14027f3          	csrr	a5,mhartid
    80005270:	0200c737          	lui	a4,0x200c
    80005274:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005278:	0007869b          	sext.w	a3,a5
    8000527c:	00269713          	slli	a4,a3,0x2
    80005280:	000f4637          	lui	a2,0xf4
    80005284:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005288:	00d70733          	add	a4,a4,a3
    8000528c:	0037979b          	slliw	a5,a5,0x3
    80005290:	020046b7          	lui	a3,0x2004
    80005294:	00d787b3          	add	a5,a5,a3
    80005298:	00c585b3          	add	a1,a1,a2
    8000529c:	00371693          	slli	a3,a4,0x3
    800052a0:	00005717          	auipc	a4,0x5
    800052a4:	31070713          	addi	a4,a4,784 # 8000a5b0 <timer_scratch>
    800052a8:	00b7b023          	sd	a1,0(a5)
    800052ac:	00d70733          	add	a4,a4,a3
    800052b0:	00f73c23          	sd	a5,24(a4)
    800052b4:	02c73023          	sd	a2,32(a4)
    800052b8:	34071073          	csrw	mscratch,a4
    800052bc:	00000797          	auipc	a5,0x0
    800052c0:	6e478793          	addi	a5,a5,1764 # 800059a0 <timervec>
    800052c4:	30579073          	csrw	mtvec,a5
    800052c8:	300027f3          	csrr	a5,mstatus
    800052cc:	0087e793          	ori	a5,a5,8
    800052d0:	30079073          	csrw	mstatus,a5
    800052d4:	304027f3          	csrr	a5,mie
    800052d8:	0807e793          	ori	a5,a5,128
    800052dc:	30479073          	csrw	mie,a5
    800052e0:	f14027f3          	csrr	a5,mhartid
    800052e4:	0007879b          	sext.w	a5,a5
    800052e8:	00078213          	mv	tp,a5
    800052ec:	30200073          	mret
    800052f0:	00813403          	ld	s0,8(sp)
    800052f4:	01010113          	addi	sp,sp,16
    800052f8:	00008067          	ret

00000000800052fc <timerinit>:
    800052fc:	ff010113          	addi	sp,sp,-16
    80005300:	00813423          	sd	s0,8(sp)
    80005304:	01010413          	addi	s0,sp,16
    80005308:	f14027f3          	csrr	a5,mhartid
    8000530c:	0200c737          	lui	a4,0x200c
    80005310:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005314:	0007869b          	sext.w	a3,a5
    80005318:	00269713          	slli	a4,a3,0x2
    8000531c:	000f4637          	lui	a2,0xf4
    80005320:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005324:	00d70733          	add	a4,a4,a3
    80005328:	0037979b          	slliw	a5,a5,0x3
    8000532c:	020046b7          	lui	a3,0x2004
    80005330:	00d787b3          	add	a5,a5,a3
    80005334:	00c585b3          	add	a1,a1,a2
    80005338:	00371693          	slli	a3,a4,0x3
    8000533c:	00005717          	auipc	a4,0x5
    80005340:	27470713          	addi	a4,a4,628 # 8000a5b0 <timer_scratch>
    80005344:	00b7b023          	sd	a1,0(a5)
    80005348:	00d70733          	add	a4,a4,a3
    8000534c:	00f73c23          	sd	a5,24(a4)
    80005350:	02c73023          	sd	a2,32(a4)
    80005354:	34071073          	csrw	mscratch,a4
    80005358:	00000797          	auipc	a5,0x0
    8000535c:	64878793          	addi	a5,a5,1608 # 800059a0 <timervec>
    80005360:	30579073          	csrw	mtvec,a5
    80005364:	300027f3          	csrr	a5,mstatus
    80005368:	0087e793          	ori	a5,a5,8
    8000536c:	30079073          	csrw	mstatus,a5
    80005370:	304027f3          	csrr	a5,mie
    80005374:	0807e793          	ori	a5,a5,128
    80005378:	30479073          	csrw	mie,a5
    8000537c:	00813403          	ld	s0,8(sp)
    80005380:	01010113          	addi	sp,sp,16
    80005384:	00008067          	ret

0000000080005388 <system_main>:
    80005388:	fe010113          	addi	sp,sp,-32
    8000538c:	00813823          	sd	s0,16(sp)
    80005390:	00913423          	sd	s1,8(sp)
    80005394:	00113c23          	sd	ra,24(sp)
    80005398:	02010413          	addi	s0,sp,32
    8000539c:	00000097          	auipc	ra,0x0
    800053a0:	0c4080e7          	jalr	196(ra) # 80005460 <cpuid>
    800053a4:	00005497          	auipc	s1,0x5
    800053a8:	08c48493          	addi	s1,s1,140 # 8000a430 <started>
    800053ac:	02050263          	beqz	a0,800053d0 <system_main+0x48>
    800053b0:	0004a783          	lw	a5,0(s1)
    800053b4:	0007879b          	sext.w	a5,a5
    800053b8:	fe078ce3          	beqz	a5,800053b0 <system_main+0x28>
    800053bc:	0ff0000f          	fence
    800053c0:	00003517          	auipc	a0,0x3
    800053c4:	fb050513          	addi	a0,a0,-80 # 80008370 <CONSOLE_STATUS+0x360>
    800053c8:	00001097          	auipc	ra,0x1
    800053cc:	a74080e7          	jalr	-1420(ra) # 80005e3c <panic>
    800053d0:	00001097          	auipc	ra,0x1
    800053d4:	9c8080e7          	jalr	-1592(ra) # 80005d98 <consoleinit>
    800053d8:	00001097          	auipc	ra,0x1
    800053dc:	154080e7          	jalr	340(ra) # 8000652c <printfinit>
    800053e0:	00003517          	auipc	a0,0x3
    800053e4:	e8050513          	addi	a0,a0,-384 # 80008260 <CONSOLE_STATUS+0x250>
    800053e8:	00001097          	auipc	ra,0x1
    800053ec:	ab0080e7          	jalr	-1360(ra) # 80005e98 <__printf>
    800053f0:	00003517          	auipc	a0,0x3
    800053f4:	f5050513          	addi	a0,a0,-176 # 80008340 <CONSOLE_STATUS+0x330>
    800053f8:	00001097          	auipc	ra,0x1
    800053fc:	aa0080e7          	jalr	-1376(ra) # 80005e98 <__printf>
    80005400:	00003517          	auipc	a0,0x3
    80005404:	e6050513          	addi	a0,a0,-416 # 80008260 <CONSOLE_STATUS+0x250>
    80005408:	00001097          	auipc	ra,0x1
    8000540c:	a90080e7          	jalr	-1392(ra) # 80005e98 <__printf>
    80005410:	00001097          	auipc	ra,0x1
    80005414:	4a8080e7          	jalr	1192(ra) # 800068b8 <kinit>
    80005418:	00000097          	auipc	ra,0x0
    8000541c:	148080e7          	jalr	328(ra) # 80005560 <trapinit>
    80005420:	00000097          	auipc	ra,0x0
    80005424:	16c080e7          	jalr	364(ra) # 8000558c <trapinithart>
    80005428:	00000097          	auipc	ra,0x0
    8000542c:	5b8080e7          	jalr	1464(ra) # 800059e0 <plicinit>
    80005430:	00000097          	auipc	ra,0x0
    80005434:	5d8080e7          	jalr	1496(ra) # 80005a08 <plicinithart>
    80005438:	00000097          	auipc	ra,0x0
    8000543c:	078080e7          	jalr	120(ra) # 800054b0 <userinit>
    80005440:	0ff0000f          	fence
    80005444:	00100793          	li	a5,1
    80005448:	00003517          	auipc	a0,0x3
    8000544c:	f1050513          	addi	a0,a0,-240 # 80008358 <CONSOLE_STATUS+0x348>
    80005450:	00f4a023          	sw	a5,0(s1)
    80005454:	00001097          	auipc	ra,0x1
    80005458:	a44080e7          	jalr	-1468(ra) # 80005e98 <__printf>
    8000545c:	0000006f          	j	8000545c <system_main+0xd4>

0000000080005460 <cpuid>:
    80005460:	ff010113          	addi	sp,sp,-16
    80005464:	00813423          	sd	s0,8(sp)
    80005468:	01010413          	addi	s0,sp,16
    8000546c:	00020513          	mv	a0,tp
    80005470:	00813403          	ld	s0,8(sp)
    80005474:	0005051b          	sext.w	a0,a0
    80005478:	01010113          	addi	sp,sp,16
    8000547c:	00008067          	ret

0000000080005480 <mycpu>:
    80005480:	ff010113          	addi	sp,sp,-16
    80005484:	00813423          	sd	s0,8(sp)
    80005488:	01010413          	addi	s0,sp,16
    8000548c:	00020793          	mv	a5,tp
    80005490:	00813403          	ld	s0,8(sp)
    80005494:	0007879b          	sext.w	a5,a5
    80005498:	00779793          	slli	a5,a5,0x7
    8000549c:	00006517          	auipc	a0,0x6
    800054a0:	14450513          	addi	a0,a0,324 # 8000b5e0 <cpus>
    800054a4:	00f50533          	add	a0,a0,a5
    800054a8:	01010113          	addi	sp,sp,16
    800054ac:	00008067          	ret

00000000800054b0 <userinit>:
    800054b0:	ff010113          	addi	sp,sp,-16
    800054b4:	00813423          	sd	s0,8(sp)
    800054b8:	01010413          	addi	s0,sp,16
    800054bc:	00813403          	ld	s0,8(sp)
    800054c0:	01010113          	addi	sp,sp,16
    800054c4:	ffffe317          	auipc	t1,0xffffe
    800054c8:	ae030067          	jr	-1312(t1) # 80002fa4 <main>

00000000800054cc <either_copyout>:
    800054cc:	ff010113          	addi	sp,sp,-16
    800054d0:	00813023          	sd	s0,0(sp)
    800054d4:	00113423          	sd	ra,8(sp)
    800054d8:	01010413          	addi	s0,sp,16
    800054dc:	02051663          	bnez	a0,80005508 <either_copyout+0x3c>
    800054e0:	00058513          	mv	a0,a1
    800054e4:	00060593          	mv	a1,a2
    800054e8:	0006861b          	sext.w	a2,a3
    800054ec:	00002097          	auipc	ra,0x2
    800054f0:	c58080e7          	jalr	-936(ra) # 80007144 <__memmove>
    800054f4:	00813083          	ld	ra,8(sp)
    800054f8:	00013403          	ld	s0,0(sp)
    800054fc:	00000513          	li	a0,0
    80005500:	01010113          	addi	sp,sp,16
    80005504:	00008067          	ret
    80005508:	00003517          	auipc	a0,0x3
    8000550c:	e9050513          	addi	a0,a0,-368 # 80008398 <CONSOLE_STATUS+0x388>
    80005510:	00001097          	auipc	ra,0x1
    80005514:	92c080e7          	jalr	-1748(ra) # 80005e3c <panic>

0000000080005518 <either_copyin>:
    80005518:	ff010113          	addi	sp,sp,-16
    8000551c:	00813023          	sd	s0,0(sp)
    80005520:	00113423          	sd	ra,8(sp)
    80005524:	01010413          	addi	s0,sp,16
    80005528:	02059463          	bnez	a1,80005550 <either_copyin+0x38>
    8000552c:	00060593          	mv	a1,a2
    80005530:	0006861b          	sext.w	a2,a3
    80005534:	00002097          	auipc	ra,0x2
    80005538:	c10080e7          	jalr	-1008(ra) # 80007144 <__memmove>
    8000553c:	00813083          	ld	ra,8(sp)
    80005540:	00013403          	ld	s0,0(sp)
    80005544:	00000513          	li	a0,0
    80005548:	01010113          	addi	sp,sp,16
    8000554c:	00008067          	ret
    80005550:	00003517          	auipc	a0,0x3
    80005554:	e7050513          	addi	a0,a0,-400 # 800083c0 <CONSOLE_STATUS+0x3b0>
    80005558:	00001097          	auipc	ra,0x1
    8000555c:	8e4080e7          	jalr	-1820(ra) # 80005e3c <panic>

0000000080005560 <trapinit>:
    80005560:	ff010113          	addi	sp,sp,-16
    80005564:	00813423          	sd	s0,8(sp)
    80005568:	01010413          	addi	s0,sp,16
    8000556c:	00813403          	ld	s0,8(sp)
    80005570:	00003597          	auipc	a1,0x3
    80005574:	e7858593          	addi	a1,a1,-392 # 800083e8 <CONSOLE_STATUS+0x3d8>
    80005578:	00006517          	auipc	a0,0x6
    8000557c:	0e850513          	addi	a0,a0,232 # 8000b660 <tickslock>
    80005580:	01010113          	addi	sp,sp,16
    80005584:	00001317          	auipc	t1,0x1
    80005588:	5c430067          	jr	1476(t1) # 80006b48 <initlock>

000000008000558c <trapinithart>:
    8000558c:	ff010113          	addi	sp,sp,-16
    80005590:	00813423          	sd	s0,8(sp)
    80005594:	01010413          	addi	s0,sp,16
    80005598:	00000797          	auipc	a5,0x0
    8000559c:	2f878793          	addi	a5,a5,760 # 80005890 <kernelvec>
    800055a0:	10579073          	csrw	stvec,a5
    800055a4:	00813403          	ld	s0,8(sp)
    800055a8:	01010113          	addi	sp,sp,16
    800055ac:	00008067          	ret

00000000800055b0 <usertrap>:
    800055b0:	ff010113          	addi	sp,sp,-16
    800055b4:	00813423          	sd	s0,8(sp)
    800055b8:	01010413          	addi	s0,sp,16
    800055bc:	00813403          	ld	s0,8(sp)
    800055c0:	01010113          	addi	sp,sp,16
    800055c4:	00008067          	ret

00000000800055c8 <usertrapret>:
    800055c8:	ff010113          	addi	sp,sp,-16
    800055cc:	00813423          	sd	s0,8(sp)
    800055d0:	01010413          	addi	s0,sp,16
    800055d4:	00813403          	ld	s0,8(sp)
    800055d8:	01010113          	addi	sp,sp,16
    800055dc:	00008067          	ret

00000000800055e0 <kerneltrap>:
    800055e0:	fe010113          	addi	sp,sp,-32
    800055e4:	00813823          	sd	s0,16(sp)
    800055e8:	00113c23          	sd	ra,24(sp)
    800055ec:	00913423          	sd	s1,8(sp)
    800055f0:	02010413          	addi	s0,sp,32
    800055f4:	142025f3          	csrr	a1,scause
    800055f8:	100027f3          	csrr	a5,sstatus
    800055fc:	0027f793          	andi	a5,a5,2
    80005600:	10079c63          	bnez	a5,80005718 <kerneltrap+0x138>
    80005604:	142027f3          	csrr	a5,scause
    80005608:	0207ce63          	bltz	a5,80005644 <kerneltrap+0x64>
    8000560c:	00003517          	auipc	a0,0x3
    80005610:	e2450513          	addi	a0,a0,-476 # 80008430 <CONSOLE_STATUS+0x420>
    80005614:	00001097          	auipc	ra,0x1
    80005618:	884080e7          	jalr	-1916(ra) # 80005e98 <__printf>
    8000561c:	141025f3          	csrr	a1,sepc
    80005620:	14302673          	csrr	a2,stval
    80005624:	00003517          	auipc	a0,0x3
    80005628:	e1c50513          	addi	a0,a0,-484 # 80008440 <CONSOLE_STATUS+0x430>
    8000562c:	00001097          	auipc	ra,0x1
    80005630:	86c080e7          	jalr	-1940(ra) # 80005e98 <__printf>
    80005634:	00003517          	auipc	a0,0x3
    80005638:	e2450513          	addi	a0,a0,-476 # 80008458 <CONSOLE_STATUS+0x448>
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	800080e7          	jalr	-2048(ra) # 80005e3c <panic>
    80005644:	0ff7f713          	andi	a4,a5,255
    80005648:	00900693          	li	a3,9
    8000564c:	04d70063          	beq	a4,a3,8000568c <kerneltrap+0xac>
    80005650:	fff00713          	li	a4,-1
    80005654:	03f71713          	slli	a4,a4,0x3f
    80005658:	00170713          	addi	a4,a4,1
    8000565c:	fae798e3          	bne	a5,a4,8000560c <kerneltrap+0x2c>
    80005660:	00000097          	auipc	ra,0x0
    80005664:	e00080e7          	jalr	-512(ra) # 80005460 <cpuid>
    80005668:	06050663          	beqz	a0,800056d4 <kerneltrap+0xf4>
    8000566c:	144027f3          	csrr	a5,sip
    80005670:	ffd7f793          	andi	a5,a5,-3
    80005674:	14479073          	csrw	sip,a5
    80005678:	01813083          	ld	ra,24(sp)
    8000567c:	01013403          	ld	s0,16(sp)
    80005680:	00813483          	ld	s1,8(sp)
    80005684:	02010113          	addi	sp,sp,32
    80005688:	00008067          	ret
    8000568c:	00000097          	auipc	ra,0x0
    80005690:	3c8080e7          	jalr	968(ra) # 80005a54 <plic_claim>
    80005694:	00a00793          	li	a5,10
    80005698:	00050493          	mv	s1,a0
    8000569c:	06f50863          	beq	a0,a5,8000570c <kerneltrap+0x12c>
    800056a0:	fc050ce3          	beqz	a0,80005678 <kerneltrap+0x98>
    800056a4:	00050593          	mv	a1,a0
    800056a8:	00003517          	auipc	a0,0x3
    800056ac:	d6850513          	addi	a0,a0,-664 # 80008410 <CONSOLE_STATUS+0x400>
    800056b0:	00000097          	auipc	ra,0x0
    800056b4:	7e8080e7          	jalr	2024(ra) # 80005e98 <__printf>
    800056b8:	01013403          	ld	s0,16(sp)
    800056bc:	01813083          	ld	ra,24(sp)
    800056c0:	00048513          	mv	a0,s1
    800056c4:	00813483          	ld	s1,8(sp)
    800056c8:	02010113          	addi	sp,sp,32
    800056cc:	00000317          	auipc	t1,0x0
    800056d0:	3c030067          	jr	960(t1) # 80005a8c <plic_complete>
    800056d4:	00006517          	auipc	a0,0x6
    800056d8:	f8c50513          	addi	a0,a0,-116 # 8000b660 <tickslock>
    800056dc:	00001097          	auipc	ra,0x1
    800056e0:	490080e7          	jalr	1168(ra) # 80006b6c <acquire>
    800056e4:	00005717          	auipc	a4,0x5
    800056e8:	d5070713          	addi	a4,a4,-688 # 8000a434 <ticks>
    800056ec:	00072783          	lw	a5,0(a4)
    800056f0:	00006517          	auipc	a0,0x6
    800056f4:	f7050513          	addi	a0,a0,-144 # 8000b660 <tickslock>
    800056f8:	0017879b          	addiw	a5,a5,1
    800056fc:	00f72023          	sw	a5,0(a4)
    80005700:	00001097          	auipc	ra,0x1
    80005704:	538080e7          	jalr	1336(ra) # 80006c38 <release>
    80005708:	f65ff06f          	j	8000566c <kerneltrap+0x8c>
    8000570c:	00001097          	auipc	ra,0x1
    80005710:	094080e7          	jalr	148(ra) # 800067a0 <uartintr>
    80005714:	fa5ff06f          	j	800056b8 <kerneltrap+0xd8>
    80005718:	00003517          	auipc	a0,0x3
    8000571c:	cd850513          	addi	a0,a0,-808 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80005720:	00000097          	auipc	ra,0x0
    80005724:	71c080e7          	jalr	1820(ra) # 80005e3c <panic>

0000000080005728 <clockintr>:
    80005728:	fe010113          	addi	sp,sp,-32
    8000572c:	00813823          	sd	s0,16(sp)
    80005730:	00913423          	sd	s1,8(sp)
    80005734:	00113c23          	sd	ra,24(sp)
    80005738:	02010413          	addi	s0,sp,32
    8000573c:	00006497          	auipc	s1,0x6
    80005740:	f2448493          	addi	s1,s1,-220 # 8000b660 <tickslock>
    80005744:	00048513          	mv	a0,s1
    80005748:	00001097          	auipc	ra,0x1
    8000574c:	424080e7          	jalr	1060(ra) # 80006b6c <acquire>
    80005750:	00005717          	auipc	a4,0x5
    80005754:	ce470713          	addi	a4,a4,-796 # 8000a434 <ticks>
    80005758:	00072783          	lw	a5,0(a4)
    8000575c:	01013403          	ld	s0,16(sp)
    80005760:	01813083          	ld	ra,24(sp)
    80005764:	00048513          	mv	a0,s1
    80005768:	0017879b          	addiw	a5,a5,1
    8000576c:	00813483          	ld	s1,8(sp)
    80005770:	00f72023          	sw	a5,0(a4)
    80005774:	02010113          	addi	sp,sp,32
    80005778:	00001317          	auipc	t1,0x1
    8000577c:	4c030067          	jr	1216(t1) # 80006c38 <release>

0000000080005780 <devintr>:
    80005780:	142027f3          	csrr	a5,scause
    80005784:	00000513          	li	a0,0
    80005788:	0007c463          	bltz	a5,80005790 <devintr+0x10>
    8000578c:	00008067          	ret
    80005790:	fe010113          	addi	sp,sp,-32
    80005794:	00813823          	sd	s0,16(sp)
    80005798:	00113c23          	sd	ra,24(sp)
    8000579c:	00913423          	sd	s1,8(sp)
    800057a0:	02010413          	addi	s0,sp,32
    800057a4:	0ff7f713          	andi	a4,a5,255
    800057a8:	00900693          	li	a3,9
    800057ac:	04d70c63          	beq	a4,a3,80005804 <devintr+0x84>
    800057b0:	fff00713          	li	a4,-1
    800057b4:	03f71713          	slli	a4,a4,0x3f
    800057b8:	00170713          	addi	a4,a4,1
    800057bc:	00e78c63          	beq	a5,a4,800057d4 <devintr+0x54>
    800057c0:	01813083          	ld	ra,24(sp)
    800057c4:	01013403          	ld	s0,16(sp)
    800057c8:	00813483          	ld	s1,8(sp)
    800057cc:	02010113          	addi	sp,sp,32
    800057d0:	00008067          	ret
    800057d4:	00000097          	auipc	ra,0x0
    800057d8:	c8c080e7          	jalr	-884(ra) # 80005460 <cpuid>
    800057dc:	06050663          	beqz	a0,80005848 <devintr+0xc8>
    800057e0:	144027f3          	csrr	a5,sip
    800057e4:	ffd7f793          	andi	a5,a5,-3
    800057e8:	14479073          	csrw	sip,a5
    800057ec:	01813083          	ld	ra,24(sp)
    800057f0:	01013403          	ld	s0,16(sp)
    800057f4:	00813483          	ld	s1,8(sp)
    800057f8:	00200513          	li	a0,2
    800057fc:	02010113          	addi	sp,sp,32
    80005800:	00008067          	ret
    80005804:	00000097          	auipc	ra,0x0
    80005808:	250080e7          	jalr	592(ra) # 80005a54 <plic_claim>
    8000580c:	00a00793          	li	a5,10
    80005810:	00050493          	mv	s1,a0
    80005814:	06f50663          	beq	a0,a5,80005880 <devintr+0x100>
    80005818:	00100513          	li	a0,1
    8000581c:	fa0482e3          	beqz	s1,800057c0 <devintr+0x40>
    80005820:	00048593          	mv	a1,s1
    80005824:	00003517          	auipc	a0,0x3
    80005828:	bec50513          	addi	a0,a0,-1044 # 80008410 <CONSOLE_STATUS+0x400>
    8000582c:	00000097          	auipc	ra,0x0
    80005830:	66c080e7          	jalr	1644(ra) # 80005e98 <__printf>
    80005834:	00048513          	mv	a0,s1
    80005838:	00000097          	auipc	ra,0x0
    8000583c:	254080e7          	jalr	596(ra) # 80005a8c <plic_complete>
    80005840:	00100513          	li	a0,1
    80005844:	f7dff06f          	j	800057c0 <devintr+0x40>
    80005848:	00006517          	auipc	a0,0x6
    8000584c:	e1850513          	addi	a0,a0,-488 # 8000b660 <tickslock>
    80005850:	00001097          	auipc	ra,0x1
    80005854:	31c080e7          	jalr	796(ra) # 80006b6c <acquire>
    80005858:	00005717          	auipc	a4,0x5
    8000585c:	bdc70713          	addi	a4,a4,-1060 # 8000a434 <ticks>
    80005860:	00072783          	lw	a5,0(a4)
    80005864:	00006517          	auipc	a0,0x6
    80005868:	dfc50513          	addi	a0,a0,-516 # 8000b660 <tickslock>
    8000586c:	0017879b          	addiw	a5,a5,1
    80005870:	00f72023          	sw	a5,0(a4)
    80005874:	00001097          	auipc	ra,0x1
    80005878:	3c4080e7          	jalr	964(ra) # 80006c38 <release>
    8000587c:	f65ff06f          	j	800057e0 <devintr+0x60>
    80005880:	00001097          	auipc	ra,0x1
    80005884:	f20080e7          	jalr	-224(ra) # 800067a0 <uartintr>
    80005888:	fadff06f          	j	80005834 <devintr+0xb4>
    8000588c:	0000                	unimp
	...

0000000080005890 <kernelvec>:
    80005890:	f0010113          	addi	sp,sp,-256
    80005894:	00113023          	sd	ra,0(sp)
    80005898:	00213423          	sd	sp,8(sp)
    8000589c:	00313823          	sd	gp,16(sp)
    800058a0:	00413c23          	sd	tp,24(sp)
    800058a4:	02513023          	sd	t0,32(sp)
    800058a8:	02613423          	sd	t1,40(sp)
    800058ac:	02713823          	sd	t2,48(sp)
    800058b0:	02813c23          	sd	s0,56(sp)
    800058b4:	04913023          	sd	s1,64(sp)
    800058b8:	04a13423          	sd	a0,72(sp)
    800058bc:	04b13823          	sd	a1,80(sp)
    800058c0:	04c13c23          	sd	a2,88(sp)
    800058c4:	06d13023          	sd	a3,96(sp)
    800058c8:	06e13423          	sd	a4,104(sp)
    800058cc:	06f13823          	sd	a5,112(sp)
    800058d0:	07013c23          	sd	a6,120(sp)
    800058d4:	09113023          	sd	a7,128(sp)
    800058d8:	09213423          	sd	s2,136(sp)
    800058dc:	09313823          	sd	s3,144(sp)
    800058e0:	09413c23          	sd	s4,152(sp)
    800058e4:	0b513023          	sd	s5,160(sp)
    800058e8:	0b613423          	sd	s6,168(sp)
    800058ec:	0b713823          	sd	s7,176(sp)
    800058f0:	0b813c23          	sd	s8,184(sp)
    800058f4:	0d913023          	sd	s9,192(sp)
    800058f8:	0da13423          	sd	s10,200(sp)
    800058fc:	0db13823          	sd	s11,208(sp)
    80005900:	0dc13c23          	sd	t3,216(sp)
    80005904:	0fd13023          	sd	t4,224(sp)
    80005908:	0fe13423          	sd	t5,232(sp)
    8000590c:	0ff13823          	sd	t6,240(sp)
    80005910:	cd1ff0ef          	jal	ra,800055e0 <kerneltrap>
    80005914:	00013083          	ld	ra,0(sp)
    80005918:	00813103          	ld	sp,8(sp)
    8000591c:	01013183          	ld	gp,16(sp)
    80005920:	02013283          	ld	t0,32(sp)
    80005924:	02813303          	ld	t1,40(sp)
    80005928:	03013383          	ld	t2,48(sp)
    8000592c:	03813403          	ld	s0,56(sp)
    80005930:	04013483          	ld	s1,64(sp)
    80005934:	04813503          	ld	a0,72(sp)
    80005938:	05013583          	ld	a1,80(sp)
    8000593c:	05813603          	ld	a2,88(sp)
    80005940:	06013683          	ld	a3,96(sp)
    80005944:	06813703          	ld	a4,104(sp)
    80005948:	07013783          	ld	a5,112(sp)
    8000594c:	07813803          	ld	a6,120(sp)
    80005950:	08013883          	ld	a7,128(sp)
    80005954:	08813903          	ld	s2,136(sp)
    80005958:	09013983          	ld	s3,144(sp)
    8000595c:	09813a03          	ld	s4,152(sp)
    80005960:	0a013a83          	ld	s5,160(sp)
    80005964:	0a813b03          	ld	s6,168(sp)
    80005968:	0b013b83          	ld	s7,176(sp)
    8000596c:	0b813c03          	ld	s8,184(sp)
    80005970:	0c013c83          	ld	s9,192(sp)
    80005974:	0c813d03          	ld	s10,200(sp)
    80005978:	0d013d83          	ld	s11,208(sp)
    8000597c:	0d813e03          	ld	t3,216(sp)
    80005980:	0e013e83          	ld	t4,224(sp)
    80005984:	0e813f03          	ld	t5,232(sp)
    80005988:	0f013f83          	ld	t6,240(sp)
    8000598c:	10010113          	addi	sp,sp,256
    80005990:	10200073          	sret
    80005994:	00000013          	nop
    80005998:	00000013          	nop
    8000599c:	00000013          	nop

00000000800059a0 <timervec>:
    800059a0:	34051573          	csrrw	a0,mscratch,a0
    800059a4:	00b53023          	sd	a1,0(a0)
    800059a8:	00c53423          	sd	a2,8(a0)
    800059ac:	00d53823          	sd	a3,16(a0)
    800059b0:	01853583          	ld	a1,24(a0)
    800059b4:	02053603          	ld	a2,32(a0)
    800059b8:	0005b683          	ld	a3,0(a1)
    800059bc:	00c686b3          	add	a3,a3,a2
    800059c0:	00d5b023          	sd	a3,0(a1)
    800059c4:	00200593          	li	a1,2
    800059c8:	14459073          	csrw	sip,a1
    800059cc:	01053683          	ld	a3,16(a0)
    800059d0:	00853603          	ld	a2,8(a0)
    800059d4:	00053583          	ld	a1,0(a0)
    800059d8:	34051573          	csrrw	a0,mscratch,a0
    800059dc:	30200073          	mret

00000000800059e0 <plicinit>:
    800059e0:	ff010113          	addi	sp,sp,-16
    800059e4:	00813423          	sd	s0,8(sp)
    800059e8:	01010413          	addi	s0,sp,16
    800059ec:	00813403          	ld	s0,8(sp)
    800059f0:	0c0007b7          	lui	a5,0xc000
    800059f4:	00100713          	li	a4,1
    800059f8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800059fc:	00e7a223          	sw	a4,4(a5)
    80005a00:	01010113          	addi	sp,sp,16
    80005a04:	00008067          	ret

0000000080005a08 <plicinithart>:
    80005a08:	ff010113          	addi	sp,sp,-16
    80005a0c:	00813023          	sd	s0,0(sp)
    80005a10:	00113423          	sd	ra,8(sp)
    80005a14:	01010413          	addi	s0,sp,16
    80005a18:	00000097          	auipc	ra,0x0
    80005a1c:	a48080e7          	jalr	-1464(ra) # 80005460 <cpuid>
    80005a20:	0085171b          	slliw	a4,a0,0x8
    80005a24:	0c0027b7          	lui	a5,0xc002
    80005a28:	00e787b3          	add	a5,a5,a4
    80005a2c:	40200713          	li	a4,1026
    80005a30:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005a34:	00813083          	ld	ra,8(sp)
    80005a38:	00013403          	ld	s0,0(sp)
    80005a3c:	00d5151b          	slliw	a0,a0,0xd
    80005a40:	0c2017b7          	lui	a5,0xc201
    80005a44:	00a78533          	add	a0,a5,a0
    80005a48:	00052023          	sw	zero,0(a0)
    80005a4c:	01010113          	addi	sp,sp,16
    80005a50:	00008067          	ret

0000000080005a54 <plic_claim>:
    80005a54:	ff010113          	addi	sp,sp,-16
    80005a58:	00813023          	sd	s0,0(sp)
    80005a5c:	00113423          	sd	ra,8(sp)
    80005a60:	01010413          	addi	s0,sp,16
    80005a64:	00000097          	auipc	ra,0x0
    80005a68:	9fc080e7          	jalr	-1540(ra) # 80005460 <cpuid>
    80005a6c:	00813083          	ld	ra,8(sp)
    80005a70:	00013403          	ld	s0,0(sp)
    80005a74:	00d5151b          	slliw	a0,a0,0xd
    80005a78:	0c2017b7          	lui	a5,0xc201
    80005a7c:	00a78533          	add	a0,a5,a0
    80005a80:	00452503          	lw	a0,4(a0)
    80005a84:	01010113          	addi	sp,sp,16
    80005a88:	00008067          	ret

0000000080005a8c <plic_complete>:
    80005a8c:	fe010113          	addi	sp,sp,-32
    80005a90:	00813823          	sd	s0,16(sp)
    80005a94:	00913423          	sd	s1,8(sp)
    80005a98:	00113c23          	sd	ra,24(sp)
    80005a9c:	02010413          	addi	s0,sp,32
    80005aa0:	00050493          	mv	s1,a0
    80005aa4:	00000097          	auipc	ra,0x0
    80005aa8:	9bc080e7          	jalr	-1604(ra) # 80005460 <cpuid>
    80005aac:	01813083          	ld	ra,24(sp)
    80005ab0:	01013403          	ld	s0,16(sp)
    80005ab4:	00d5179b          	slliw	a5,a0,0xd
    80005ab8:	0c201737          	lui	a4,0xc201
    80005abc:	00f707b3          	add	a5,a4,a5
    80005ac0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005ac4:	00813483          	ld	s1,8(sp)
    80005ac8:	02010113          	addi	sp,sp,32
    80005acc:	00008067          	ret

0000000080005ad0 <consolewrite>:
    80005ad0:	fb010113          	addi	sp,sp,-80
    80005ad4:	04813023          	sd	s0,64(sp)
    80005ad8:	04113423          	sd	ra,72(sp)
    80005adc:	02913c23          	sd	s1,56(sp)
    80005ae0:	03213823          	sd	s2,48(sp)
    80005ae4:	03313423          	sd	s3,40(sp)
    80005ae8:	03413023          	sd	s4,32(sp)
    80005aec:	01513c23          	sd	s5,24(sp)
    80005af0:	05010413          	addi	s0,sp,80
    80005af4:	06c05c63          	blez	a2,80005b6c <consolewrite+0x9c>
    80005af8:	00060993          	mv	s3,a2
    80005afc:	00050a13          	mv	s4,a0
    80005b00:	00058493          	mv	s1,a1
    80005b04:	00000913          	li	s2,0
    80005b08:	fff00a93          	li	s5,-1
    80005b0c:	01c0006f          	j	80005b28 <consolewrite+0x58>
    80005b10:	fbf44503          	lbu	a0,-65(s0)
    80005b14:	0019091b          	addiw	s2,s2,1
    80005b18:	00148493          	addi	s1,s1,1
    80005b1c:	00001097          	auipc	ra,0x1
    80005b20:	a9c080e7          	jalr	-1380(ra) # 800065b8 <uartputc>
    80005b24:	03298063          	beq	s3,s2,80005b44 <consolewrite+0x74>
    80005b28:	00048613          	mv	a2,s1
    80005b2c:	00100693          	li	a3,1
    80005b30:	000a0593          	mv	a1,s4
    80005b34:	fbf40513          	addi	a0,s0,-65
    80005b38:	00000097          	auipc	ra,0x0
    80005b3c:	9e0080e7          	jalr	-1568(ra) # 80005518 <either_copyin>
    80005b40:	fd5518e3          	bne	a0,s5,80005b10 <consolewrite+0x40>
    80005b44:	04813083          	ld	ra,72(sp)
    80005b48:	04013403          	ld	s0,64(sp)
    80005b4c:	03813483          	ld	s1,56(sp)
    80005b50:	02813983          	ld	s3,40(sp)
    80005b54:	02013a03          	ld	s4,32(sp)
    80005b58:	01813a83          	ld	s5,24(sp)
    80005b5c:	00090513          	mv	a0,s2
    80005b60:	03013903          	ld	s2,48(sp)
    80005b64:	05010113          	addi	sp,sp,80
    80005b68:	00008067          	ret
    80005b6c:	00000913          	li	s2,0
    80005b70:	fd5ff06f          	j	80005b44 <consolewrite+0x74>

0000000080005b74 <consoleread>:
    80005b74:	f9010113          	addi	sp,sp,-112
    80005b78:	06813023          	sd	s0,96(sp)
    80005b7c:	04913c23          	sd	s1,88(sp)
    80005b80:	05213823          	sd	s2,80(sp)
    80005b84:	05313423          	sd	s3,72(sp)
    80005b88:	05413023          	sd	s4,64(sp)
    80005b8c:	03513c23          	sd	s5,56(sp)
    80005b90:	03613823          	sd	s6,48(sp)
    80005b94:	03713423          	sd	s7,40(sp)
    80005b98:	03813023          	sd	s8,32(sp)
    80005b9c:	06113423          	sd	ra,104(sp)
    80005ba0:	01913c23          	sd	s9,24(sp)
    80005ba4:	07010413          	addi	s0,sp,112
    80005ba8:	00060b93          	mv	s7,a2
    80005bac:	00050913          	mv	s2,a0
    80005bb0:	00058c13          	mv	s8,a1
    80005bb4:	00060b1b          	sext.w	s6,a2
    80005bb8:	00006497          	auipc	s1,0x6
    80005bbc:	ad048493          	addi	s1,s1,-1328 # 8000b688 <cons>
    80005bc0:	00400993          	li	s3,4
    80005bc4:	fff00a13          	li	s4,-1
    80005bc8:	00a00a93          	li	s5,10
    80005bcc:	05705e63          	blez	s7,80005c28 <consoleread+0xb4>
    80005bd0:	09c4a703          	lw	a4,156(s1)
    80005bd4:	0984a783          	lw	a5,152(s1)
    80005bd8:	0007071b          	sext.w	a4,a4
    80005bdc:	08e78463          	beq	a5,a4,80005c64 <consoleread+0xf0>
    80005be0:	07f7f713          	andi	a4,a5,127
    80005be4:	00e48733          	add	a4,s1,a4
    80005be8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005bec:	0017869b          	addiw	a3,a5,1
    80005bf0:	08d4ac23          	sw	a3,152(s1)
    80005bf4:	00070c9b          	sext.w	s9,a4
    80005bf8:	0b370663          	beq	a4,s3,80005ca4 <consoleread+0x130>
    80005bfc:	00100693          	li	a3,1
    80005c00:	f9f40613          	addi	a2,s0,-97
    80005c04:	000c0593          	mv	a1,s8
    80005c08:	00090513          	mv	a0,s2
    80005c0c:	f8e40fa3          	sb	a4,-97(s0)
    80005c10:	00000097          	auipc	ra,0x0
    80005c14:	8bc080e7          	jalr	-1860(ra) # 800054cc <either_copyout>
    80005c18:	01450863          	beq	a0,s4,80005c28 <consoleread+0xb4>
    80005c1c:	001c0c13          	addi	s8,s8,1
    80005c20:	fffb8b9b          	addiw	s7,s7,-1
    80005c24:	fb5c94e3          	bne	s9,s5,80005bcc <consoleread+0x58>
    80005c28:	000b851b          	sext.w	a0,s7
    80005c2c:	06813083          	ld	ra,104(sp)
    80005c30:	06013403          	ld	s0,96(sp)
    80005c34:	05813483          	ld	s1,88(sp)
    80005c38:	05013903          	ld	s2,80(sp)
    80005c3c:	04813983          	ld	s3,72(sp)
    80005c40:	04013a03          	ld	s4,64(sp)
    80005c44:	03813a83          	ld	s5,56(sp)
    80005c48:	02813b83          	ld	s7,40(sp)
    80005c4c:	02013c03          	ld	s8,32(sp)
    80005c50:	01813c83          	ld	s9,24(sp)
    80005c54:	40ab053b          	subw	a0,s6,a0
    80005c58:	03013b03          	ld	s6,48(sp)
    80005c5c:	07010113          	addi	sp,sp,112
    80005c60:	00008067          	ret
    80005c64:	00001097          	auipc	ra,0x1
    80005c68:	1d8080e7          	jalr	472(ra) # 80006e3c <push_on>
    80005c6c:	0984a703          	lw	a4,152(s1)
    80005c70:	09c4a783          	lw	a5,156(s1)
    80005c74:	0007879b          	sext.w	a5,a5
    80005c78:	fef70ce3          	beq	a4,a5,80005c70 <consoleread+0xfc>
    80005c7c:	00001097          	auipc	ra,0x1
    80005c80:	234080e7          	jalr	564(ra) # 80006eb0 <pop_on>
    80005c84:	0984a783          	lw	a5,152(s1)
    80005c88:	07f7f713          	andi	a4,a5,127
    80005c8c:	00e48733          	add	a4,s1,a4
    80005c90:	01874703          	lbu	a4,24(a4)
    80005c94:	0017869b          	addiw	a3,a5,1
    80005c98:	08d4ac23          	sw	a3,152(s1)
    80005c9c:	00070c9b          	sext.w	s9,a4
    80005ca0:	f5371ee3          	bne	a4,s3,80005bfc <consoleread+0x88>
    80005ca4:	000b851b          	sext.w	a0,s7
    80005ca8:	f96bf2e3          	bgeu	s7,s6,80005c2c <consoleread+0xb8>
    80005cac:	08f4ac23          	sw	a5,152(s1)
    80005cb0:	f7dff06f          	j	80005c2c <consoleread+0xb8>

0000000080005cb4 <consputc>:
    80005cb4:	10000793          	li	a5,256
    80005cb8:	00f50663          	beq	a0,a5,80005cc4 <consputc+0x10>
    80005cbc:	00001317          	auipc	t1,0x1
    80005cc0:	9f430067          	jr	-1548(t1) # 800066b0 <uartputc_sync>
    80005cc4:	ff010113          	addi	sp,sp,-16
    80005cc8:	00113423          	sd	ra,8(sp)
    80005ccc:	00813023          	sd	s0,0(sp)
    80005cd0:	01010413          	addi	s0,sp,16
    80005cd4:	00800513          	li	a0,8
    80005cd8:	00001097          	auipc	ra,0x1
    80005cdc:	9d8080e7          	jalr	-1576(ra) # 800066b0 <uartputc_sync>
    80005ce0:	02000513          	li	a0,32
    80005ce4:	00001097          	auipc	ra,0x1
    80005ce8:	9cc080e7          	jalr	-1588(ra) # 800066b0 <uartputc_sync>
    80005cec:	00013403          	ld	s0,0(sp)
    80005cf0:	00813083          	ld	ra,8(sp)
    80005cf4:	00800513          	li	a0,8
    80005cf8:	01010113          	addi	sp,sp,16
    80005cfc:	00001317          	auipc	t1,0x1
    80005d00:	9b430067          	jr	-1612(t1) # 800066b0 <uartputc_sync>

0000000080005d04 <consoleintr>:
    80005d04:	fe010113          	addi	sp,sp,-32
    80005d08:	00813823          	sd	s0,16(sp)
    80005d0c:	00913423          	sd	s1,8(sp)
    80005d10:	01213023          	sd	s2,0(sp)
    80005d14:	00113c23          	sd	ra,24(sp)
    80005d18:	02010413          	addi	s0,sp,32
    80005d1c:	00006917          	auipc	s2,0x6
    80005d20:	96c90913          	addi	s2,s2,-1684 # 8000b688 <cons>
    80005d24:	00050493          	mv	s1,a0
    80005d28:	00090513          	mv	a0,s2
    80005d2c:	00001097          	auipc	ra,0x1
    80005d30:	e40080e7          	jalr	-448(ra) # 80006b6c <acquire>
    80005d34:	02048c63          	beqz	s1,80005d6c <consoleintr+0x68>
    80005d38:	0a092783          	lw	a5,160(s2)
    80005d3c:	09892703          	lw	a4,152(s2)
    80005d40:	07f00693          	li	a3,127
    80005d44:	40e7873b          	subw	a4,a5,a4
    80005d48:	02e6e263          	bltu	a3,a4,80005d6c <consoleintr+0x68>
    80005d4c:	00d00713          	li	a4,13
    80005d50:	04e48063          	beq	s1,a4,80005d90 <consoleintr+0x8c>
    80005d54:	07f7f713          	andi	a4,a5,127
    80005d58:	00e90733          	add	a4,s2,a4
    80005d5c:	0017879b          	addiw	a5,a5,1
    80005d60:	0af92023          	sw	a5,160(s2)
    80005d64:	00970c23          	sb	s1,24(a4)
    80005d68:	08f92e23          	sw	a5,156(s2)
    80005d6c:	01013403          	ld	s0,16(sp)
    80005d70:	01813083          	ld	ra,24(sp)
    80005d74:	00813483          	ld	s1,8(sp)
    80005d78:	00013903          	ld	s2,0(sp)
    80005d7c:	00006517          	auipc	a0,0x6
    80005d80:	90c50513          	addi	a0,a0,-1780 # 8000b688 <cons>
    80005d84:	02010113          	addi	sp,sp,32
    80005d88:	00001317          	auipc	t1,0x1
    80005d8c:	eb030067          	jr	-336(t1) # 80006c38 <release>
    80005d90:	00a00493          	li	s1,10
    80005d94:	fc1ff06f          	j	80005d54 <consoleintr+0x50>

0000000080005d98 <consoleinit>:
    80005d98:	fe010113          	addi	sp,sp,-32
    80005d9c:	00113c23          	sd	ra,24(sp)
    80005da0:	00813823          	sd	s0,16(sp)
    80005da4:	00913423          	sd	s1,8(sp)
    80005da8:	02010413          	addi	s0,sp,32
    80005dac:	00006497          	auipc	s1,0x6
    80005db0:	8dc48493          	addi	s1,s1,-1828 # 8000b688 <cons>
    80005db4:	00048513          	mv	a0,s1
    80005db8:	00002597          	auipc	a1,0x2
    80005dbc:	6b058593          	addi	a1,a1,1712 # 80008468 <CONSOLE_STATUS+0x458>
    80005dc0:	00001097          	auipc	ra,0x1
    80005dc4:	d88080e7          	jalr	-632(ra) # 80006b48 <initlock>
    80005dc8:	00000097          	auipc	ra,0x0
    80005dcc:	7ac080e7          	jalr	1964(ra) # 80006574 <uartinit>
    80005dd0:	01813083          	ld	ra,24(sp)
    80005dd4:	01013403          	ld	s0,16(sp)
    80005dd8:	00000797          	auipc	a5,0x0
    80005ddc:	d9c78793          	addi	a5,a5,-612 # 80005b74 <consoleread>
    80005de0:	0af4bc23          	sd	a5,184(s1)
    80005de4:	00000797          	auipc	a5,0x0
    80005de8:	cec78793          	addi	a5,a5,-788 # 80005ad0 <consolewrite>
    80005dec:	0cf4b023          	sd	a5,192(s1)
    80005df0:	00813483          	ld	s1,8(sp)
    80005df4:	02010113          	addi	sp,sp,32
    80005df8:	00008067          	ret

0000000080005dfc <console_read>:
    80005dfc:	ff010113          	addi	sp,sp,-16
    80005e00:	00813423          	sd	s0,8(sp)
    80005e04:	01010413          	addi	s0,sp,16
    80005e08:	00813403          	ld	s0,8(sp)
    80005e0c:	00006317          	auipc	t1,0x6
    80005e10:	93433303          	ld	t1,-1740(t1) # 8000b740 <devsw+0x10>
    80005e14:	01010113          	addi	sp,sp,16
    80005e18:	00030067          	jr	t1

0000000080005e1c <console_write>:
    80005e1c:	ff010113          	addi	sp,sp,-16
    80005e20:	00813423          	sd	s0,8(sp)
    80005e24:	01010413          	addi	s0,sp,16
    80005e28:	00813403          	ld	s0,8(sp)
    80005e2c:	00006317          	auipc	t1,0x6
    80005e30:	91c33303          	ld	t1,-1764(t1) # 8000b748 <devsw+0x18>
    80005e34:	01010113          	addi	sp,sp,16
    80005e38:	00030067          	jr	t1

0000000080005e3c <panic>:
    80005e3c:	fe010113          	addi	sp,sp,-32
    80005e40:	00113c23          	sd	ra,24(sp)
    80005e44:	00813823          	sd	s0,16(sp)
    80005e48:	00913423          	sd	s1,8(sp)
    80005e4c:	02010413          	addi	s0,sp,32
    80005e50:	00050493          	mv	s1,a0
    80005e54:	00002517          	auipc	a0,0x2
    80005e58:	61c50513          	addi	a0,a0,1564 # 80008470 <CONSOLE_STATUS+0x460>
    80005e5c:	00006797          	auipc	a5,0x6
    80005e60:	9807a623          	sw	zero,-1652(a5) # 8000b7e8 <pr+0x18>
    80005e64:	00000097          	auipc	ra,0x0
    80005e68:	034080e7          	jalr	52(ra) # 80005e98 <__printf>
    80005e6c:	00048513          	mv	a0,s1
    80005e70:	00000097          	auipc	ra,0x0
    80005e74:	028080e7          	jalr	40(ra) # 80005e98 <__printf>
    80005e78:	00002517          	auipc	a0,0x2
    80005e7c:	3e850513          	addi	a0,a0,1000 # 80008260 <CONSOLE_STATUS+0x250>
    80005e80:	00000097          	auipc	ra,0x0
    80005e84:	018080e7          	jalr	24(ra) # 80005e98 <__printf>
    80005e88:	00100793          	li	a5,1
    80005e8c:	00004717          	auipc	a4,0x4
    80005e90:	5af72623          	sw	a5,1452(a4) # 8000a438 <panicked>
    80005e94:	0000006f          	j	80005e94 <panic+0x58>

0000000080005e98 <__printf>:
    80005e98:	f3010113          	addi	sp,sp,-208
    80005e9c:	08813023          	sd	s0,128(sp)
    80005ea0:	07313423          	sd	s3,104(sp)
    80005ea4:	09010413          	addi	s0,sp,144
    80005ea8:	05813023          	sd	s8,64(sp)
    80005eac:	08113423          	sd	ra,136(sp)
    80005eb0:	06913c23          	sd	s1,120(sp)
    80005eb4:	07213823          	sd	s2,112(sp)
    80005eb8:	07413023          	sd	s4,96(sp)
    80005ebc:	05513c23          	sd	s5,88(sp)
    80005ec0:	05613823          	sd	s6,80(sp)
    80005ec4:	05713423          	sd	s7,72(sp)
    80005ec8:	03913c23          	sd	s9,56(sp)
    80005ecc:	03a13823          	sd	s10,48(sp)
    80005ed0:	03b13423          	sd	s11,40(sp)
    80005ed4:	00006317          	auipc	t1,0x6
    80005ed8:	8fc30313          	addi	t1,t1,-1796 # 8000b7d0 <pr>
    80005edc:	01832c03          	lw	s8,24(t1)
    80005ee0:	00b43423          	sd	a1,8(s0)
    80005ee4:	00c43823          	sd	a2,16(s0)
    80005ee8:	00d43c23          	sd	a3,24(s0)
    80005eec:	02e43023          	sd	a4,32(s0)
    80005ef0:	02f43423          	sd	a5,40(s0)
    80005ef4:	03043823          	sd	a6,48(s0)
    80005ef8:	03143c23          	sd	a7,56(s0)
    80005efc:	00050993          	mv	s3,a0
    80005f00:	4a0c1663          	bnez	s8,800063ac <__printf+0x514>
    80005f04:	60098c63          	beqz	s3,8000651c <__printf+0x684>
    80005f08:	0009c503          	lbu	a0,0(s3)
    80005f0c:	00840793          	addi	a5,s0,8
    80005f10:	f6f43c23          	sd	a5,-136(s0)
    80005f14:	00000493          	li	s1,0
    80005f18:	22050063          	beqz	a0,80006138 <__printf+0x2a0>
    80005f1c:	00002a37          	lui	s4,0x2
    80005f20:	00018ab7          	lui	s5,0x18
    80005f24:	000f4b37          	lui	s6,0xf4
    80005f28:	00989bb7          	lui	s7,0x989
    80005f2c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005f30:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005f34:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005f38:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005f3c:	00148c9b          	addiw	s9,s1,1
    80005f40:	02500793          	li	a5,37
    80005f44:	01998933          	add	s2,s3,s9
    80005f48:	38f51263          	bne	a0,a5,800062cc <__printf+0x434>
    80005f4c:	00094783          	lbu	a5,0(s2)
    80005f50:	00078c9b          	sext.w	s9,a5
    80005f54:	1e078263          	beqz	a5,80006138 <__printf+0x2a0>
    80005f58:	0024849b          	addiw	s1,s1,2
    80005f5c:	07000713          	li	a4,112
    80005f60:	00998933          	add	s2,s3,s1
    80005f64:	38e78a63          	beq	a5,a4,800062f8 <__printf+0x460>
    80005f68:	20f76863          	bltu	a4,a5,80006178 <__printf+0x2e0>
    80005f6c:	42a78863          	beq	a5,a0,8000639c <__printf+0x504>
    80005f70:	06400713          	li	a4,100
    80005f74:	40e79663          	bne	a5,a4,80006380 <__printf+0x4e8>
    80005f78:	f7843783          	ld	a5,-136(s0)
    80005f7c:	0007a603          	lw	a2,0(a5)
    80005f80:	00878793          	addi	a5,a5,8
    80005f84:	f6f43c23          	sd	a5,-136(s0)
    80005f88:	42064a63          	bltz	a2,800063bc <__printf+0x524>
    80005f8c:	00a00713          	li	a4,10
    80005f90:	02e677bb          	remuw	a5,a2,a4
    80005f94:	00002d97          	auipc	s11,0x2
    80005f98:	504d8d93          	addi	s11,s11,1284 # 80008498 <digits>
    80005f9c:	00900593          	li	a1,9
    80005fa0:	0006051b          	sext.w	a0,a2
    80005fa4:	00000c93          	li	s9,0
    80005fa8:	02079793          	slli	a5,a5,0x20
    80005fac:	0207d793          	srli	a5,a5,0x20
    80005fb0:	00fd87b3          	add	a5,s11,a5
    80005fb4:	0007c783          	lbu	a5,0(a5)
    80005fb8:	02e656bb          	divuw	a3,a2,a4
    80005fbc:	f8f40023          	sb	a5,-128(s0)
    80005fc0:	14c5d863          	bge	a1,a2,80006110 <__printf+0x278>
    80005fc4:	06300593          	li	a1,99
    80005fc8:	00100c93          	li	s9,1
    80005fcc:	02e6f7bb          	remuw	a5,a3,a4
    80005fd0:	02079793          	slli	a5,a5,0x20
    80005fd4:	0207d793          	srli	a5,a5,0x20
    80005fd8:	00fd87b3          	add	a5,s11,a5
    80005fdc:	0007c783          	lbu	a5,0(a5)
    80005fe0:	02e6d73b          	divuw	a4,a3,a4
    80005fe4:	f8f400a3          	sb	a5,-127(s0)
    80005fe8:	12a5f463          	bgeu	a1,a0,80006110 <__printf+0x278>
    80005fec:	00a00693          	li	a3,10
    80005ff0:	00900593          	li	a1,9
    80005ff4:	02d777bb          	remuw	a5,a4,a3
    80005ff8:	02079793          	slli	a5,a5,0x20
    80005ffc:	0207d793          	srli	a5,a5,0x20
    80006000:	00fd87b3          	add	a5,s11,a5
    80006004:	0007c503          	lbu	a0,0(a5)
    80006008:	02d757bb          	divuw	a5,a4,a3
    8000600c:	f8a40123          	sb	a0,-126(s0)
    80006010:	48e5f263          	bgeu	a1,a4,80006494 <__printf+0x5fc>
    80006014:	06300513          	li	a0,99
    80006018:	02d7f5bb          	remuw	a1,a5,a3
    8000601c:	02059593          	slli	a1,a1,0x20
    80006020:	0205d593          	srli	a1,a1,0x20
    80006024:	00bd85b3          	add	a1,s11,a1
    80006028:	0005c583          	lbu	a1,0(a1)
    8000602c:	02d7d7bb          	divuw	a5,a5,a3
    80006030:	f8b401a3          	sb	a1,-125(s0)
    80006034:	48e57263          	bgeu	a0,a4,800064b8 <__printf+0x620>
    80006038:	3e700513          	li	a0,999
    8000603c:	02d7f5bb          	remuw	a1,a5,a3
    80006040:	02059593          	slli	a1,a1,0x20
    80006044:	0205d593          	srli	a1,a1,0x20
    80006048:	00bd85b3          	add	a1,s11,a1
    8000604c:	0005c583          	lbu	a1,0(a1)
    80006050:	02d7d7bb          	divuw	a5,a5,a3
    80006054:	f8b40223          	sb	a1,-124(s0)
    80006058:	46e57663          	bgeu	a0,a4,800064c4 <__printf+0x62c>
    8000605c:	02d7f5bb          	remuw	a1,a5,a3
    80006060:	02059593          	slli	a1,a1,0x20
    80006064:	0205d593          	srli	a1,a1,0x20
    80006068:	00bd85b3          	add	a1,s11,a1
    8000606c:	0005c583          	lbu	a1,0(a1)
    80006070:	02d7d7bb          	divuw	a5,a5,a3
    80006074:	f8b402a3          	sb	a1,-123(s0)
    80006078:	46ea7863          	bgeu	s4,a4,800064e8 <__printf+0x650>
    8000607c:	02d7f5bb          	remuw	a1,a5,a3
    80006080:	02059593          	slli	a1,a1,0x20
    80006084:	0205d593          	srli	a1,a1,0x20
    80006088:	00bd85b3          	add	a1,s11,a1
    8000608c:	0005c583          	lbu	a1,0(a1)
    80006090:	02d7d7bb          	divuw	a5,a5,a3
    80006094:	f8b40323          	sb	a1,-122(s0)
    80006098:	3eeaf863          	bgeu	s5,a4,80006488 <__printf+0x5f0>
    8000609c:	02d7f5bb          	remuw	a1,a5,a3
    800060a0:	02059593          	slli	a1,a1,0x20
    800060a4:	0205d593          	srli	a1,a1,0x20
    800060a8:	00bd85b3          	add	a1,s11,a1
    800060ac:	0005c583          	lbu	a1,0(a1)
    800060b0:	02d7d7bb          	divuw	a5,a5,a3
    800060b4:	f8b403a3          	sb	a1,-121(s0)
    800060b8:	42eb7e63          	bgeu	s6,a4,800064f4 <__printf+0x65c>
    800060bc:	02d7f5bb          	remuw	a1,a5,a3
    800060c0:	02059593          	slli	a1,a1,0x20
    800060c4:	0205d593          	srli	a1,a1,0x20
    800060c8:	00bd85b3          	add	a1,s11,a1
    800060cc:	0005c583          	lbu	a1,0(a1)
    800060d0:	02d7d7bb          	divuw	a5,a5,a3
    800060d4:	f8b40423          	sb	a1,-120(s0)
    800060d8:	42ebfc63          	bgeu	s7,a4,80006510 <__printf+0x678>
    800060dc:	02079793          	slli	a5,a5,0x20
    800060e0:	0207d793          	srli	a5,a5,0x20
    800060e4:	00fd8db3          	add	s11,s11,a5
    800060e8:	000dc703          	lbu	a4,0(s11)
    800060ec:	00a00793          	li	a5,10
    800060f0:	00900c93          	li	s9,9
    800060f4:	f8e404a3          	sb	a4,-119(s0)
    800060f8:	00065c63          	bgez	a2,80006110 <__printf+0x278>
    800060fc:	f9040713          	addi	a4,s0,-112
    80006100:	00f70733          	add	a4,a4,a5
    80006104:	02d00693          	li	a3,45
    80006108:	fed70823          	sb	a3,-16(a4)
    8000610c:	00078c93          	mv	s9,a5
    80006110:	f8040793          	addi	a5,s0,-128
    80006114:	01978cb3          	add	s9,a5,s9
    80006118:	f7f40d13          	addi	s10,s0,-129
    8000611c:	000cc503          	lbu	a0,0(s9)
    80006120:	fffc8c93          	addi	s9,s9,-1
    80006124:	00000097          	auipc	ra,0x0
    80006128:	b90080e7          	jalr	-1136(ra) # 80005cb4 <consputc>
    8000612c:	ffac98e3          	bne	s9,s10,8000611c <__printf+0x284>
    80006130:	00094503          	lbu	a0,0(s2)
    80006134:	e00514e3          	bnez	a0,80005f3c <__printf+0xa4>
    80006138:	1a0c1663          	bnez	s8,800062e4 <__printf+0x44c>
    8000613c:	08813083          	ld	ra,136(sp)
    80006140:	08013403          	ld	s0,128(sp)
    80006144:	07813483          	ld	s1,120(sp)
    80006148:	07013903          	ld	s2,112(sp)
    8000614c:	06813983          	ld	s3,104(sp)
    80006150:	06013a03          	ld	s4,96(sp)
    80006154:	05813a83          	ld	s5,88(sp)
    80006158:	05013b03          	ld	s6,80(sp)
    8000615c:	04813b83          	ld	s7,72(sp)
    80006160:	04013c03          	ld	s8,64(sp)
    80006164:	03813c83          	ld	s9,56(sp)
    80006168:	03013d03          	ld	s10,48(sp)
    8000616c:	02813d83          	ld	s11,40(sp)
    80006170:	0d010113          	addi	sp,sp,208
    80006174:	00008067          	ret
    80006178:	07300713          	li	a4,115
    8000617c:	1ce78a63          	beq	a5,a4,80006350 <__printf+0x4b8>
    80006180:	07800713          	li	a4,120
    80006184:	1ee79e63          	bne	a5,a4,80006380 <__printf+0x4e8>
    80006188:	f7843783          	ld	a5,-136(s0)
    8000618c:	0007a703          	lw	a4,0(a5)
    80006190:	00878793          	addi	a5,a5,8
    80006194:	f6f43c23          	sd	a5,-136(s0)
    80006198:	28074263          	bltz	a4,8000641c <__printf+0x584>
    8000619c:	00002d97          	auipc	s11,0x2
    800061a0:	2fcd8d93          	addi	s11,s11,764 # 80008498 <digits>
    800061a4:	00f77793          	andi	a5,a4,15
    800061a8:	00fd87b3          	add	a5,s11,a5
    800061ac:	0007c683          	lbu	a3,0(a5)
    800061b0:	00f00613          	li	a2,15
    800061b4:	0007079b          	sext.w	a5,a4
    800061b8:	f8d40023          	sb	a3,-128(s0)
    800061bc:	0047559b          	srliw	a1,a4,0x4
    800061c0:	0047569b          	srliw	a3,a4,0x4
    800061c4:	00000c93          	li	s9,0
    800061c8:	0ee65063          	bge	a2,a4,800062a8 <__printf+0x410>
    800061cc:	00f6f693          	andi	a3,a3,15
    800061d0:	00dd86b3          	add	a3,s11,a3
    800061d4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800061d8:	0087d79b          	srliw	a5,a5,0x8
    800061dc:	00100c93          	li	s9,1
    800061e0:	f8d400a3          	sb	a3,-127(s0)
    800061e4:	0cb67263          	bgeu	a2,a1,800062a8 <__printf+0x410>
    800061e8:	00f7f693          	andi	a3,a5,15
    800061ec:	00dd86b3          	add	a3,s11,a3
    800061f0:	0006c583          	lbu	a1,0(a3)
    800061f4:	00f00613          	li	a2,15
    800061f8:	0047d69b          	srliw	a3,a5,0x4
    800061fc:	f8b40123          	sb	a1,-126(s0)
    80006200:	0047d593          	srli	a1,a5,0x4
    80006204:	28f67e63          	bgeu	a2,a5,800064a0 <__printf+0x608>
    80006208:	00f6f693          	andi	a3,a3,15
    8000620c:	00dd86b3          	add	a3,s11,a3
    80006210:	0006c503          	lbu	a0,0(a3)
    80006214:	0087d813          	srli	a6,a5,0x8
    80006218:	0087d69b          	srliw	a3,a5,0x8
    8000621c:	f8a401a3          	sb	a0,-125(s0)
    80006220:	28b67663          	bgeu	a2,a1,800064ac <__printf+0x614>
    80006224:	00f6f693          	andi	a3,a3,15
    80006228:	00dd86b3          	add	a3,s11,a3
    8000622c:	0006c583          	lbu	a1,0(a3)
    80006230:	00c7d513          	srli	a0,a5,0xc
    80006234:	00c7d69b          	srliw	a3,a5,0xc
    80006238:	f8b40223          	sb	a1,-124(s0)
    8000623c:	29067a63          	bgeu	a2,a6,800064d0 <__printf+0x638>
    80006240:	00f6f693          	andi	a3,a3,15
    80006244:	00dd86b3          	add	a3,s11,a3
    80006248:	0006c583          	lbu	a1,0(a3)
    8000624c:	0107d813          	srli	a6,a5,0x10
    80006250:	0107d69b          	srliw	a3,a5,0x10
    80006254:	f8b402a3          	sb	a1,-123(s0)
    80006258:	28a67263          	bgeu	a2,a0,800064dc <__printf+0x644>
    8000625c:	00f6f693          	andi	a3,a3,15
    80006260:	00dd86b3          	add	a3,s11,a3
    80006264:	0006c683          	lbu	a3,0(a3)
    80006268:	0147d79b          	srliw	a5,a5,0x14
    8000626c:	f8d40323          	sb	a3,-122(s0)
    80006270:	21067663          	bgeu	a2,a6,8000647c <__printf+0x5e4>
    80006274:	02079793          	slli	a5,a5,0x20
    80006278:	0207d793          	srli	a5,a5,0x20
    8000627c:	00fd8db3          	add	s11,s11,a5
    80006280:	000dc683          	lbu	a3,0(s11)
    80006284:	00800793          	li	a5,8
    80006288:	00700c93          	li	s9,7
    8000628c:	f8d403a3          	sb	a3,-121(s0)
    80006290:	00075c63          	bgez	a4,800062a8 <__printf+0x410>
    80006294:	f9040713          	addi	a4,s0,-112
    80006298:	00f70733          	add	a4,a4,a5
    8000629c:	02d00693          	li	a3,45
    800062a0:	fed70823          	sb	a3,-16(a4)
    800062a4:	00078c93          	mv	s9,a5
    800062a8:	f8040793          	addi	a5,s0,-128
    800062ac:	01978cb3          	add	s9,a5,s9
    800062b0:	f7f40d13          	addi	s10,s0,-129
    800062b4:	000cc503          	lbu	a0,0(s9)
    800062b8:	fffc8c93          	addi	s9,s9,-1
    800062bc:	00000097          	auipc	ra,0x0
    800062c0:	9f8080e7          	jalr	-1544(ra) # 80005cb4 <consputc>
    800062c4:	ff9d18e3          	bne	s10,s9,800062b4 <__printf+0x41c>
    800062c8:	0100006f          	j	800062d8 <__printf+0x440>
    800062cc:	00000097          	auipc	ra,0x0
    800062d0:	9e8080e7          	jalr	-1560(ra) # 80005cb4 <consputc>
    800062d4:	000c8493          	mv	s1,s9
    800062d8:	00094503          	lbu	a0,0(s2)
    800062dc:	c60510e3          	bnez	a0,80005f3c <__printf+0xa4>
    800062e0:	e40c0ee3          	beqz	s8,8000613c <__printf+0x2a4>
    800062e4:	00005517          	auipc	a0,0x5
    800062e8:	4ec50513          	addi	a0,a0,1260 # 8000b7d0 <pr>
    800062ec:	00001097          	auipc	ra,0x1
    800062f0:	94c080e7          	jalr	-1716(ra) # 80006c38 <release>
    800062f4:	e49ff06f          	j	8000613c <__printf+0x2a4>
    800062f8:	f7843783          	ld	a5,-136(s0)
    800062fc:	03000513          	li	a0,48
    80006300:	01000d13          	li	s10,16
    80006304:	00878713          	addi	a4,a5,8
    80006308:	0007bc83          	ld	s9,0(a5)
    8000630c:	f6e43c23          	sd	a4,-136(s0)
    80006310:	00000097          	auipc	ra,0x0
    80006314:	9a4080e7          	jalr	-1628(ra) # 80005cb4 <consputc>
    80006318:	07800513          	li	a0,120
    8000631c:	00000097          	auipc	ra,0x0
    80006320:	998080e7          	jalr	-1640(ra) # 80005cb4 <consputc>
    80006324:	00002d97          	auipc	s11,0x2
    80006328:	174d8d93          	addi	s11,s11,372 # 80008498 <digits>
    8000632c:	03ccd793          	srli	a5,s9,0x3c
    80006330:	00fd87b3          	add	a5,s11,a5
    80006334:	0007c503          	lbu	a0,0(a5)
    80006338:	fffd0d1b          	addiw	s10,s10,-1
    8000633c:	004c9c93          	slli	s9,s9,0x4
    80006340:	00000097          	auipc	ra,0x0
    80006344:	974080e7          	jalr	-1676(ra) # 80005cb4 <consputc>
    80006348:	fe0d12e3          	bnez	s10,8000632c <__printf+0x494>
    8000634c:	f8dff06f          	j	800062d8 <__printf+0x440>
    80006350:	f7843783          	ld	a5,-136(s0)
    80006354:	0007bc83          	ld	s9,0(a5)
    80006358:	00878793          	addi	a5,a5,8
    8000635c:	f6f43c23          	sd	a5,-136(s0)
    80006360:	000c9a63          	bnez	s9,80006374 <__printf+0x4dc>
    80006364:	1080006f          	j	8000646c <__printf+0x5d4>
    80006368:	001c8c93          	addi	s9,s9,1
    8000636c:	00000097          	auipc	ra,0x0
    80006370:	948080e7          	jalr	-1720(ra) # 80005cb4 <consputc>
    80006374:	000cc503          	lbu	a0,0(s9)
    80006378:	fe0518e3          	bnez	a0,80006368 <__printf+0x4d0>
    8000637c:	f5dff06f          	j	800062d8 <__printf+0x440>
    80006380:	02500513          	li	a0,37
    80006384:	00000097          	auipc	ra,0x0
    80006388:	930080e7          	jalr	-1744(ra) # 80005cb4 <consputc>
    8000638c:	000c8513          	mv	a0,s9
    80006390:	00000097          	auipc	ra,0x0
    80006394:	924080e7          	jalr	-1756(ra) # 80005cb4 <consputc>
    80006398:	f41ff06f          	j	800062d8 <__printf+0x440>
    8000639c:	02500513          	li	a0,37
    800063a0:	00000097          	auipc	ra,0x0
    800063a4:	914080e7          	jalr	-1772(ra) # 80005cb4 <consputc>
    800063a8:	f31ff06f          	j	800062d8 <__printf+0x440>
    800063ac:	00030513          	mv	a0,t1
    800063b0:	00000097          	auipc	ra,0x0
    800063b4:	7bc080e7          	jalr	1980(ra) # 80006b6c <acquire>
    800063b8:	b4dff06f          	j	80005f04 <__printf+0x6c>
    800063bc:	40c0053b          	negw	a0,a2
    800063c0:	00a00713          	li	a4,10
    800063c4:	02e576bb          	remuw	a3,a0,a4
    800063c8:	00002d97          	auipc	s11,0x2
    800063cc:	0d0d8d93          	addi	s11,s11,208 # 80008498 <digits>
    800063d0:	ff700593          	li	a1,-9
    800063d4:	02069693          	slli	a3,a3,0x20
    800063d8:	0206d693          	srli	a3,a3,0x20
    800063dc:	00dd86b3          	add	a3,s11,a3
    800063e0:	0006c683          	lbu	a3,0(a3)
    800063e4:	02e557bb          	divuw	a5,a0,a4
    800063e8:	f8d40023          	sb	a3,-128(s0)
    800063ec:	10b65e63          	bge	a2,a1,80006508 <__printf+0x670>
    800063f0:	06300593          	li	a1,99
    800063f4:	02e7f6bb          	remuw	a3,a5,a4
    800063f8:	02069693          	slli	a3,a3,0x20
    800063fc:	0206d693          	srli	a3,a3,0x20
    80006400:	00dd86b3          	add	a3,s11,a3
    80006404:	0006c683          	lbu	a3,0(a3)
    80006408:	02e7d73b          	divuw	a4,a5,a4
    8000640c:	00200793          	li	a5,2
    80006410:	f8d400a3          	sb	a3,-127(s0)
    80006414:	bca5ece3          	bltu	a1,a0,80005fec <__printf+0x154>
    80006418:	ce5ff06f          	j	800060fc <__printf+0x264>
    8000641c:	40e007bb          	negw	a5,a4
    80006420:	00002d97          	auipc	s11,0x2
    80006424:	078d8d93          	addi	s11,s11,120 # 80008498 <digits>
    80006428:	00f7f693          	andi	a3,a5,15
    8000642c:	00dd86b3          	add	a3,s11,a3
    80006430:	0006c583          	lbu	a1,0(a3)
    80006434:	ff100613          	li	a2,-15
    80006438:	0047d69b          	srliw	a3,a5,0x4
    8000643c:	f8b40023          	sb	a1,-128(s0)
    80006440:	0047d59b          	srliw	a1,a5,0x4
    80006444:	0ac75e63          	bge	a4,a2,80006500 <__printf+0x668>
    80006448:	00f6f693          	andi	a3,a3,15
    8000644c:	00dd86b3          	add	a3,s11,a3
    80006450:	0006c603          	lbu	a2,0(a3)
    80006454:	00f00693          	li	a3,15
    80006458:	0087d79b          	srliw	a5,a5,0x8
    8000645c:	f8c400a3          	sb	a2,-127(s0)
    80006460:	d8b6e4e3          	bltu	a3,a1,800061e8 <__printf+0x350>
    80006464:	00200793          	li	a5,2
    80006468:	e2dff06f          	j	80006294 <__printf+0x3fc>
    8000646c:	00002c97          	auipc	s9,0x2
    80006470:	00cc8c93          	addi	s9,s9,12 # 80008478 <CONSOLE_STATUS+0x468>
    80006474:	02800513          	li	a0,40
    80006478:	ef1ff06f          	j	80006368 <__printf+0x4d0>
    8000647c:	00700793          	li	a5,7
    80006480:	00600c93          	li	s9,6
    80006484:	e0dff06f          	j	80006290 <__printf+0x3f8>
    80006488:	00700793          	li	a5,7
    8000648c:	00600c93          	li	s9,6
    80006490:	c69ff06f          	j	800060f8 <__printf+0x260>
    80006494:	00300793          	li	a5,3
    80006498:	00200c93          	li	s9,2
    8000649c:	c5dff06f          	j	800060f8 <__printf+0x260>
    800064a0:	00300793          	li	a5,3
    800064a4:	00200c93          	li	s9,2
    800064a8:	de9ff06f          	j	80006290 <__printf+0x3f8>
    800064ac:	00400793          	li	a5,4
    800064b0:	00300c93          	li	s9,3
    800064b4:	dddff06f          	j	80006290 <__printf+0x3f8>
    800064b8:	00400793          	li	a5,4
    800064bc:	00300c93          	li	s9,3
    800064c0:	c39ff06f          	j	800060f8 <__printf+0x260>
    800064c4:	00500793          	li	a5,5
    800064c8:	00400c93          	li	s9,4
    800064cc:	c2dff06f          	j	800060f8 <__printf+0x260>
    800064d0:	00500793          	li	a5,5
    800064d4:	00400c93          	li	s9,4
    800064d8:	db9ff06f          	j	80006290 <__printf+0x3f8>
    800064dc:	00600793          	li	a5,6
    800064e0:	00500c93          	li	s9,5
    800064e4:	dadff06f          	j	80006290 <__printf+0x3f8>
    800064e8:	00600793          	li	a5,6
    800064ec:	00500c93          	li	s9,5
    800064f0:	c09ff06f          	j	800060f8 <__printf+0x260>
    800064f4:	00800793          	li	a5,8
    800064f8:	00700c93          	li	s9,7
    800064fc:	bfdff06f          	j	800060f8 <__printf+0x260>
    80006500:	00100793          	li	a5,1
    80006504:	d91ff06f          	j	80006294 <__printf+0x3fc>
    80006508:	00100793          	li	a5,1
    8000650c:	bf1ff06f          	j	800060fc <__printf+0x264>
    80006510:	00900793          	li	a5,9
    80006514:	00800c93          	li	s9,8
    80006518:	be1ff06f          	j	800060f8 <__printf+0x260>
    8000651c:	00002517          	auipc	a0,0x2
    80006520:	f6450513          	addi	a0,a0,-156 # 80008480 <CONSOLE_STATUS+0x470>
    80006524:	00000097          	auipc	ra,0x0
    80006528:	918080e7          	jalr	-1768(ra) # 80005e3c <panic>

000000008000652c <printfinit>:
    8000652c:	fe010113          	addi	sp,sp,-32
    80006530:	00813823          	sd	s0,16(sp)
    80006534:	00913423          	sd	s1,8(sp)
    80006538:	00113c23          	sd	ra,24(sp)
    8000653c:	02010413          	addi	s0,sp,32
    80006540:	00005497          	auipc	s1,0x5
    80006544:	29048493          	addi	s1,s1,656 # 8000b7d0 <pr>
    80006548:	00048513          	mv	a0,s1
    8000654c:	00002597          	auipc	a1,0x2
    80006550:	f4458593          	addi	a1,a1,-188 # 80008490 <CONSOLE_STATUS+0x480>
    80006554:	00000097          	auipc	ra,0x0
    80006558:	5f4080e7          	jalr	1524(ra) # 80006b48 <initlock>
    8000655c:	01813083          	ld	ra,24(sp)
    80006560:	01013403          	ld	s0,16(sp)
    80006564:	0004ac23          	sw	zero,24(s1)
    80006568:	00813483          	ld	s1,8(sp)
    8000656c:	02010113          	addi	sp,sp,32
    80006570:	00008067          	ret

0000000080006574 <uartinit>:
    80006574:	ff010113          	addi	sp,sp,-16
    80006578:	00813423          	sd	s0,8(sp)
    8000657c:	01010413          	addi	s0,sp,16
    80006580:	100007b7          	lui	a5,0x10000
    80006584:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006588:	f8000713          	li	a4,-128
    8000658c:	00e781a3          	sb	a4,3(a5)
    80006590:	00300713          	li	a4,3
    80006594:	00e78023          	sb	a4,0(a5)
    80006598:	000780a3          	sb	zero,1(a5)
    8000659c:	00e781a3          	sb	a4,3(a5)
    800065a0:	00700693          	li	a3,7
    800065a4:	00d78123          	sb	a3,2(a5)
    800065a8:	00e780a3          	sb	a4,1(a5)
    800065ac:	00813403          	ld	s0,8(sp)
    800065b0:	01010113          	addi	sp,sp,16
    800065b4:	00008067          	ret

00000000800065b8 <uartputc>:
    800065b8:	00004797          	auipc	a5,0x4
    800065bc:	e807a783          	lw	a5,-384(a5) # 8000a438 <panicked>
    800065c0:	00078463          	beqz	a5,800065c8 <uartputc+0x10>
    800065c4:	0000006f          	j	800065c4 <uartputc+0xc>
    800065c8:	fd010113          	addi	sp,sp,-48
    800065cc:	02813023          	sd	s0,32(sp)
    800065d0:	00913c23          	sd	s1,24(sp)
    800065d4:	01213823          	sd	s2,16(sp)
    800065d8:	01313423          	sd	s3,8(sp)
    800065dc:	02113423          	sd	ra,40(sp)
    800065e0:	03010413          	addi	s0,sp,48
    800065e4:	00004917          	auipc	s2,0x4
    800065e8:	e5c90913          	addi	s2,s2,-420 # 8000a440 <uart_tx_r>
    800065ec:	00093783          	ld	a5,0(s2)
    800065f0:	00004497          	auipc	s1,0x4
    800065f4:	e5848493          	addi	s1,s1,-424 # 8000a448 <uart_tx_w>
    800065f8:	0004b703          	ld	a4,0(s1)
    800065fc:	02078693          	addi	a3,a5,32
    80006600:	00050993          	mv	s3,a0
    80006604:	02e69c63          	bne	a3,a4,8000663c <uartputc+0x84>
    80006608:	00001097          	auipc	ra,0x1
    8000660c:	834080e7          	jalr	-1996(ra) # 80006e3c <push_on>
    80006610:	00093783          	ld	a5,0(s2)
    80006614:	0004b703          	ld	a4,0(s1)
    80006618:	02078793          	addi	a5,a5,32
    8000661c:	00e79463          	bne	a5,a4,80006624 <uartputc+0x6c>
    80006620:	0000006f          	j	80006620 <uartputc+0x68>
    80006624:	00001097          	auipc	ra,0x1
    80006628:	88c080e7          	jalr	-1908(ra) # 80006eb0 <pop_on>
    8000662c:	00093783          	ld	a5,0(s2)
    80006630:	0004b703          	ld	a4,0(s1)
    80006634:	02078693          	addi	a3,a5,32
    80006638:	fce688e3          	beq	a3,a4,80006608 <uartputc+0x50>
    8000663c:	01f77693          	andi	a3,a4,31
    80006640:	00005597          	auipc	a1,0x5
    80006644:	1b058593          	addi	a1,a1,432 # 8000b7f0 <uart_tx_buf>
    80006648:	00d586b3          	add	a3,a1,a3
    8000664c:	00170713          	addi	a4,a4,1
    80006650:	01368023          	sb	s3,0(a3)
    80006654:	00e4b023          	sd	a4,0(s1)
    80006658:	10000637          	lui	a2,0x10000
    8000665c:	02f71063          	bne	a4,a5,8000667c <uartputc+0xc4>
    80006660:	0340006f          	j	80006694 <uartputc+0xdc>
    80006664:	00074703          	lbu	a4,0(a4)
    80006668:	00f93023          	sd	a5,0(s2)
    8000666c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006670:	00093783          	ld	a5,0(s2)
    80006674:	0004b703          	ld	a4,0(s1)
    80006678:	00f70e63          	beq	a4,a5,80006694 <uartputc+0xdc>
    8000667c:	00564683          	lbu	a3,5(a2)
    80006680:	01f7f713          	andi	a4,a5,31
    80006684:	00e58733          	add	a4,a1,a4
    80006688:	0206f693          	andi	a3,a3,32
    8000668c:	00178793          	addi	a5,a5,1
    80006690:	fc069ae3          	bnez	a3,80006664 <uartputc+0xac>
    80006694:	02813083          	ld	ra,40(sp)
    80006698:	02013403          	ld	s0,32(sp)
    8000669c:	01813483          	ld	s1,24(sp)
    800066a0:	01013903          	ld	s2,16(sp)
    800066a4:	00813983          	ld	s3,8(sp)
    800066a8:	03010113          	addi	sp,sp,48
    800066ac:	00008067          	ret

00000000800066b0 <uartputc_sync>:
    800066b0:	ff010113          	addi	sp,sp,-16
    800066b4:	00813423          	sd	s0,8(sp)
    800066b8:	01010413          	addi	s0,sp,16
    800066bc:	00004717          	auipc	a4,0x4
    800066c0:	d7c72703          	lw	a4,-644(a4) # 8000a438 <panicked>
    800066c4:	02071663          	bnez	a4,800066f0 <uartputc_sync+0x40>
    800066c8:	00050793          	mv	a5,a0
    800066cc:	100006b7          	lui	a3,0x10000
    800066d0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800066d4:	02077713          	andi	a4,a4,32
    800066d8:	fe070ce3          	beqz	a4,800066d0 <uartputc_sync+0x20>
    800066dc:	0ff7f793          	andi	a5,a5,255
    800066e0:	00f68023          	sb	a5,0(a3)
    800066e4:	00813403          	ld	s0,8(sp)
    800066e8:	01010113          	addi	sp,sp,16
    800066ec:	00008067          	ret
    800066f0:	0000006f          	j	800066f0 <uartputc_sync+0x40>

00000000800066f4 <uartstart>:
    800066f4:	ff010113          	addi	sp,sp,-16
    800066f8:	00813423          	sd	s0,8(sp)
    800066fc:	01010413          	addi	s0,sp,16
    80006700:	00004617          	auipc	a2,0x4
    80006704:	d4060613          	addi	a2,a2,-704 # 8000a440 <uart_tx_r>
    80006708:	00004517          	auipc	a0,0x4
    8000670c:	d4050513          	addi	a0,a0,-704 # 8000a448 <uart_tx_w>
    80006710:	00063783          	ld	a5,0(a2)
    80006714:	00053703          	ld	a4,0(a0)
    80006718:	04f70263          	beq	a4,a5,8000675c <uartstart+0x68>
    8000671c:	100005b7          	lui	a1,0x10000
    80006720:	00005817          	auipc	a6,0x5
    80006724:	0d080813          	addi	a6,a6,208 # 8000b7f0 <uart_tx_buf>
    80006728:	01c0006f          	j	80006744 <uartstart+0x50>
    8000672c:	0006c703          	lbu	a4,0(a3)
    80006730:	00f63023          	sd	a5,0(a2)
    80006734:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006738:	00063783          	ld	a5,0(a2)
    8000673c:	00053703          	ld	a4,0(a0)
    80006740:	00f70e63          	beq	a4,a5,8000675c <uartstart+0x68>
    80006744:	01f7f713          	andi	a4,a5,31
    80006748:	00e806b3          	add	a3,a6,a4
    8000674c:	0055c703          	lbu	a4,5(a1)
    80006750:	00178793          	addi	a5,a5,1
    80006754:	02077713          	andi	a4,a4,32
    80006758:	fc071ae3          	bnez	a4,8000672c <uartstart+0x38>
    8000675c:	00813403          	ld	s0,8(sp)
    80006760:	01010113          	addi	sp,sp,16
    80006764:	00008067          	ret

0000000080006768 <uartgetc>:
    80006768:	ff010113          	addi	sp,sp,-16
    8000676c:	00813423          	sd	s0,8(sp)
    80006770:	01010413          	addi	s0,sp,16
    80006774:	10000737          	lui	a4,0x10000
    80006778:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000677c:	0017f793          	andi	a5,a5,1
    80006780:	00078c63          	beqz	a5,80006798 <uartgetc+0x30>
    80006784:	00074503          	lbu	a0,0(a4)
    80006788:	0ff57513          	andi	a0,a0,255
    8000678c:	00813403          	ld	s0,8(sp)
    80006790:	01010113          	addi	sp,sp,16
    80006794:	00008067          	ret
    80006798:	fff00513          	li	a0,-1
    8000679c:	ff1ff06f          	j	8000678c <uartgetc+0x24>

00000000800067a0 <uartintr>:
    800067a0:	100007b7          	lui	a5,0x10000
    800067a4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800067a8:	0017f793          	andi	a5,a5,1
    800067ac:	0a078463          	beqz	a5,80006854 <uartintr+0xb4>
    800067b0:	fe010113          	addi	sp,sp,-32
    800067b4:	00813823          	sd	s0,16(sp)
    800067b8:	00913423          	sd	s1,8(sp)
    800067bc:	00113c23          	sd	ra,24(sp)
    800067c0:	02010413          	addi	s0,sp,32
    800067c4:	100004b7          	lui	s1,0x10000
    800067c8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800067cc:	0ff57513          	andi	a0,a0,255
    800067d0:	fffff097          	auipc	ra,0xfffff
    800067d4:	534080e7          	jalr	1332(ra) # 80005d04 <consoleintr>
    800067d8:	0054c783          	lbu	a5,5(s1)
    800067dc:	0017f793          	andi	a5,a5,1
    800067e0:	fe0794e3          	bnez	a5,800067c8 <uartintr+0x28>
    800067e4:	00004617          	auipc	a2,0x4
    800067e8:	c5c60613          	addi	a2,a2,-932 # 8000a440 <uart_tx_r>
    800067ec:	00004517          	auipc	a0,0x4
    800067f0:	c5c50513          	addi	a0,a0,-932 # 8000a448 <uart_tx_w>
    800067f4:	00063783          	ld	a5,0(a2)
    800067f8:	00053703          	ld	a4,0(a0)
    800067fc:	04f70263          	beq	a4,a5,80006840 <uartintr+0xa0>
    80006800:	100005b7          	lui	a1,0x10000
    80006804:	00005817          	auipc	a6,0x5
    80006808:	fec80813          	addi	a6,a6,-20 # 8000b7f0 <uart_tx_buf>
    8000680c:	01c0006f          	j	80006828 <uartintr+0x88>
    80006810:	0006c703          	lbu	a4,0(a3)
    80006814:	00f63023          	sd	a5,0(a2)
    80006818:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000681c:	00063783          	ld	a5,0(a2)
    80006820:	00053703          	ld	a4,0(a0)
    80006824:	00f70e63          	beq	a4,a5,80006840 <uartintr+0xa0>
    80006828:	01f7f713          	andi	a4,a5,31
    8000682c:	00e806b3          	add	a3,a6,a4
    80006830:	0055c703          	lbu	a4,5(a1)
    80006834:	00178793          	addi	a5,a5,1
    80006838:	02077713          	andi	a4,a4,32
    8000683c:	fc071ae3          	bnez	a4,80006810 <uartintr+0x70>
    80006840:	01813083          	ld	ra,24(sp)
    80006844:	01013403          	ld	s0,16(sp)
    80006848:	00813483          	ld	s1,8(sp)
    8000684c:	02010113          	addi	sp,sp,32
    80006850:	00008067          	ret
    80006854:	00004617          	auipc	a2,0x4
    80006858:	bec60613          	addi	a2,a2,-1044 # 8000a440 <uart_tx_r>
    8000685c:	00004517          	auipc	a0,0x4
    80006860:	bec50513          	addi	a0,a0,-1044 # 8000a448 <uart_tx_w>
    80006864:	00063783          	ld	a5,0(a2)
    80006868:	00053703          	ld	a4,0(a0)
    8000686c:	04f70263          	beq	a4,a5,800068b0 <uartintr+0x110>
    80006870:	100005b7          	lui	a1,0x10000
    80006874:	00005817          	auipc	a6,0x5
    80006878:	f7c80813          	addi	a6,a6,-132 # 8000b7f0 <uart_tx_buf>
    8000687c:	01c0006f          	j	80006898 <uartintr+0xf8>
    80006880:	0006c703          	lbu	a4,0(a3)
    80006884:	00f63023          	sd	a5,0(a2)
    80006888:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000688c:	00063783          	ld	a5,0(a2)
    80006890:	00053703          	ld	a4,0(a0)
    80006894:	02f70063          	beq	a4,a5,800068b4 <uartintr+0x114>
    80006898:	01f7f713          	andi	a4,a5,31
    8000689c:	00e806b3          	add	a3,a6,a4
    800068a0:	0055c703          	lbu	a4,5(a1)
    800068a4:	00178793          	addi	a5,a5,1
    800068a8:	02077713          	andi	a4,a4,32
    800068ac:	fc071ae3          	bnez	a4,80006880 <uartintr+0xe0>
    800068b0:	00008067          	ret
    800068b4:	00008067          	ret

00000000800068b8 <kinit>:
    800068b8:	fc010113          	addi	sp,sp,-64
    800068bc:	02913423          	sd	s1,40(sp)
    800068c0:	fffff7b7          	lui	a5,0xfffff
    800068c4:	00006497          	auipc	s1,0x6
    800068c8:	f4b48493          	addi	s1,s1,-181 # 8000c80f <end+0xfff>
    800068cc:	02813823          	sd	s0,48(sp)
    800068d0:	01313c23          	sd	s3,24(sp)
    800068d4:	00f4f4b3          	and	s1,s1,a5
    800068d8:	02113c23          	sd	ra,56(sp)
    800068dc:	03213023          	sd	s2,32(sp)
    800068e0:	01413823          	sd	s4,16(sp)
    800068e4:	01513423          	sd	s5,8(sp)
    800068e8:	04010413          	addi	s0,sp,64
    800068ec:	000017b7          	lui	a5,0x1
    800068f0:	01100993          	li	s3,17
    800068f4:	00f487b3          	add	a5,s1,a5
    800068f8:	01b99993          	slli	s3,s3,0x1b
    800068fc:	06f9e063          	bltu	s3,a5,8000695c <kinit+0xa4>
    80006900:	00005a97          	auipc	s5,0x5
    80006904:	f10a8a93          	addi	s5,s5,-240 # 8000b810 <end>
    80006908:	0754ec63          	bltu	s1,s5,80006980 <kinit+0xc8>
    8000690c:	0734fa63          	bgeu	s1,s3,80006980 <kinit+0xc8>
    80006910:	00088a37          	lui	s4,0x88
    80006914:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006918:	00004917          	auipc	s2,0x4
    8000691c:	b3890913          	addi	s2,s2,-1224 # 8000a450 <kmem>
    80006920:	00ca1a13          	slli	s4,s4,0xc
    80006924:	0140006f          	j	80006938 <kinit+0x80>
    80006928:	000017b7          	lui	a5,0x1
    8000692c:	00f484b3          	add	s1,s1,a5
    80006930:	0554e863          	bltu	s1,s5,80006980 <kinit+0xc8>
    80006934:	0534f663          	bgeu	s1,s3,80006980 <kinit+0xc8>
    80006938:	00001637          	lui	a2,0x1
    8000693c:	00100593          	li	a1,1
    80006940:	00048513          	mv	a0,s1
    80006944:	00000097          	auipc	ra,0x0
    80006948:	5e4080e7          	jalr	1508(ra) # 80006f28 <__memset>
    8000694c:	00093783          	ld	a5,0(s2)
    80006950:	00f4b023          	sd	a5,0(s1)
    80006954:	00993023          	sd	s1,0(s2)
    80006958:	fd4498e3          	bne	s1,s4,80006928 <kinit+0x70>
    8000695c:	03813083          	ld	ra,56(sp)
    80006960:	03013403          	ld	s0,48(sp)
    80006964:	02813483          	ld	s1,40(sp)
    80006968:	02013903          	ld	s2,32(sp)
    8000696c:	01813983          	ld	s3,24(sp)
    80006970:	01013a03          	ld	s4,16(sp)
    80006974:	00813a83          	ld	s5,8(sp)
    80006978:	04010113          	addi	sp,sp,64
    8000697c:	00008067          	ret
    80006980:	00002517          	auipc	a0,0x2
    80006984:	b3050513          	addi	a0,a0,-1232 # 800084b0 <digits+0x18>
    80006988:	fffff097          	auipc	ra,0xfffff
    8000698c:	4b4080e7          	jalr	1204(ra) # 80005e3c <panic>

0000000080006990 <freerange>:
    80006990:	fc010113          	addi	sp,sp,-64
    80006994:	000017b7          	lui	a5,0x1
    80006998:	02913423          	sd	s1,40(sp)
    8000699c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800069a0:	009504b3          	add	s1,a0,s1
    800069a4:	fffff537          	lui	a0,0xfffff
    800069a8:	02813823          	sd	s0,48(sp)
    800069ac:	02113c23          	sd	ra,56(sp)
    800069b0:	03213023          	sd	s2,32(sp)
    800069b4:	01313c23          	sd	s3,24(sp)
    800069b8:	01413823          	sd	s4,16(sp)
    800069bc:	01513423          	sd	s5,8(sp)
    800069c0:	01613023          	sd	s6,0(sp)
    800069c4:	04010413          	addi	s0,sp,64
    800069c8:	00a4f4b3          	and	s1,s1,a0
    800069cc:	00f487b3          	add	a5,s1,a5
    800069d0:	06f5e463          	bltu	a1,a5,80006a38 <freerange+0xa8>
    800069d4:	00005a97          	auipc	s5,0x5
    800069d8:	e3ca8a93          	addi	s5,s5,-452 # 8000b810 <end>
    800069dc:	0954e263          	bltu	s1,s5,80006a60 <freerange+0xd0>
    800069e0:	01100993          	li	s3,17
    800069e4:	01b99993          	slli	s3,s3,0x1b
    800069e8:	0734fc63          	bgeu	s1,s3,80006a60 <freerange+0xd0>
    800069ec:	00058a13          	mv	s4,a1
    800069f0:	00004917          	auipc	s2,0x4
    800069f4:	a6090913          	addi	s2,s2,-1440 # 8000a450 <kmem>
    800069f8:	00002b37          	lui	s6,0x2
    800069fc:	0140006f          	j	80006a10 <freerange+0x80>
    80006a00:	000017b7          	lui	a5,0x1
    80006a04:	00f484b3          	add	s1,s1,a5
    80006a08:	0554ec63          	bltu	s1,s5,80006a60 <freerange+0xd0>
    80006a0c:	0534fa63          	bgeu	s1,s3,80006a60 <freerange+0xd0>
    80006a10:	00001637          	lui	a2,0x1
    80006a14:	00100593          	li	a1,1
    80006a18:	00048513          	mv	a0,s1
    80006a1c:	00000097          	auipc	ra,0x0
    80006a20:	50c080e7          	jalr	1292(ra) # 80006f28 <__memset>
    80006a24:	00093703          	ld	a4,0(s2)
    80006a28:	016487b3          	add	a5,s1,s6
    80006a2c:	00e4b023          	sd	a4,0(s1)
    80006a30:	00993023          	sd	s1,0(s2)
    80006a34:	fcfa76e3          	bgeu	s4,a5,80006a00 <freerange+0x70>
    80006a38:	03813083          	ld	ra,56(sp)
    80006a3c:	03013403          	ld	s0,48(sp)
    80006a40:	02813483          	ld	s1,40(sp)
    80006a44:	02013903          	ld	s2,32(sp)
    80006a48:	01813983          	ld	s3,24(sp)
    80006a4c:	01013a03          	ld	s4,16(sp)
    80006a50:	00813a83          	ld	s5,8(sp)
    80006a54:	00013b03          	ld	s6,0(sp)
    80006a58:	04010113          	addi	sp,sp,64
    80006a5c:	00008067          	ret
    80006a60:	00002517          	auipc	a0,0x2
    80006a64:	a5050513          	addi	a0,a0,-1456 # 800084b0 <digits+0x18>
    80006a68:	fffff097          	auipc	ra,0xfffff
    80006a6c:	3d4080e7          	jalr	980(ra) # 80005e3c <panic>

0000000080006a70 <kfree>:
    80006a70:	fe010113          	addi	sp,sp,-32
    80006a74:	00813823          	sd	s0,16(sp)
    80006a78:	00113c23          	sd	ra,24(sp)
    80006a7c:	00913423          	sd	s1,8(sp)
    80006a80:	02010413          	addi	s0,sp,32
    80006a84:	03451793          	slli	a5,a0,0x34
    80006a88:	04079c63          	bnez	a5,80006ae0 <kfree+0x70>
    80006a8c:	00005797          	auipc	a5,0x5
    80006a90:	d8478793          	addi	a5,a5,-636 # 8000b810 <end>
    80006a94:	00050493          	mv	s1,a0
    80006a98:	04f56463          	bltu	a0,a5,80006ae0 <kfree+0x70>
    80006a9c:	01100793          	li	a5,17
    80006aa0:	01b79793          	slli	a5,a5,0x1b
    80006aa4:	02f57e63          	bgeu	a0,a5,80006ae0 <kfree+0x70>
    80006aa8:	00001637          	lui	a2,0x1
    80006aac:	00100593          	li	a1,1
    80006ab0:	00000097          	auipc	ra,0x0
    80006ab4:	478080e7          	jalr	1144(ra) # 80006f28 <__memset>
    80006ab8:	00004797          	auipc	a5,0x4
    80006abc:	99878793          	addi	a5,a5,-1640 # 8000a450 <kmem>
    80006ac0:	0007b703          	ld	a4,0(a5)
    80006ac4:	01813083          	ld	ra,24(sp)
    80006ac8:	01013403          	ld	s0,16(sp)
    80006acc:	00e4b023          	sd	a4,0(s1)
    80006ad0:	0097b023          	sd	s1,0(a5)
    80006ad4:	00813483          	ld	s1,8(sp)
    80006ad8:	02010113          	addi	sp,sp,32
    80006adc:	00008067          	ret
    80006ae0:	00002517          	auipc	a0,0x2
    80006ae4:	9d050513          	addi	a0,a0,-1584 # 800084b0 <digits+0x18>
    80006ae8:	fffff097          	auipc	ra,0xfffff
    80006aec:	354080e7          	jalr	852(ra) # 80005e3c <panic>

0000000080006af0 <kalloc>:
    80006af0:	fe010113          	addi	sp,sp,-32
    80006af4:	00813823          	sd	s0,16(sp)
    80006af8:	00913423          	sd	s1,8(sp)
    80006afc:	00113c23          	sd	ra,24(sp)
    80006b00:	02010413          	addi	s0,sp,32
    80006b04:	00004797          	auipc	a5,0x4
    80006b08:	94c78793          	addi	a5,a5,-1716 # 8000a450 <kmem>
    80006b0c:	0007b483          	ld	s1,0(a5)
    80006b10:	02048063          	beqz	s1,80006b30 <kalloc+0x40>
    80006b14:	0004b703          	ld	a4,0(s1)
    80006b18:	00001637          	lui	a2,0x1
    80006b1c:	00500593          	li	a1,5
    80006b20:	00048513          	mv	a0,s1
    80006b24:	00e7b023          	sd	a4,0(a5)
    80006b28:	00000097          	auipc	ra,0x0
    80006b2c:	400080e7          	jalr	1024(ra) # 80006f28 <__memset>
    80006b30:	01813083          	ld	ra,24(sp)
    80006b34:	01013403          	ld	s0,16(sp)
    80006b38:	00048513          	mv	a0,s1
    80006b3c:	00813483          	ld	s1,8(sp)
    80006b40:	02010113          	addi	sp,sp,32
    80006b44:	00008067          	ret

0000000080006b48 <initlock>:
    80006b48:	ff010113          	addi	sp,sp,-16
    80006b4c:	00813423          	sd	s0,8(sp)
    80006b50:	01010413          	addi	s0,sp,16
    80006b54:	00813403          	ld	s0,8(sp)
    80006b58:	00b53423          	sd	a1,8(a0)
    80006b5c:	00052023          	sw	zero,0(a0)
    80006b60:	00053823          	sd	zero,16(a0)
    80006b64:	01010113          	addi	sp,sp,16
    80006b68:	00008067          	ret

0000000080006b6c <acquire>:
    80006b6c:	fe010113          	addi	sp,sp,-32
    80006b70:	00813823          	sd	s0,16(sp)
    80006b74:	00913423          	sd	s1,8(sp)
    80006b78:	00113c23          	sd	ra,24(sp)
    80006b7c:	01213023          	sd	s2,0(sp)
    80006b80:	02010413          	addi	s0,sp,32
    80006b84:	00050493          	mv	s1,a0
    80006b88:	10002973          	csrr	s2,sstatus
    80006b8c:	100027f3          	csrr	a5,sstatus
    80006b90:	ffd7f793          	andi	a5,a5,-3
    80006b94:	10079073          	csrw	sstatus,a5
    80006b98:	fffff097          	auipc	ra,0xfffff
    80006b9c:	8e8080e7          	jalr	-1816(ra) # 80005480 <mycpu>
    80006ba0:	07852783          	lw	a5,120(a0)
    80006ba4:	06078e63          	beqz	a5,80006c20 <acquire+0xb4>
    80006ba8:	fffff097          	auipc	ra,0xfffff
    80006bac:	8d8080e7          	jalr	-1832(ra) # 80005480 <mycpu>
    80006bb0:	07852783          	lw	a5,120(a0)
    80006bb4:	0004a703          	lw	a4,0(s1)
    80006bb8:	0017879b          	addiw	a5,a5,1
    80006bbc:	06f52c23          	sw	a5,120(a0)
    80006bc0:	04071063          	bnez	a4,80006c00 <acquire+0x94>
    80006bc4:	00100713          	li	a4,1
    80006bc8:	00070793          	mv	a5,a4
    80006bcc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006bd0:	0007879b          	sext.w	a5,a5
    80006bd4:	fe079ae3          	bnez	a5,80006bc8 <acquire+0x5c>
    80006bd8:	0ff0000f          	fence
    80006bdc:	fffff097          	auipc	ra,0xfffff
    80006be0:	8a4080e7          	jalr	-1884(ra) # 80005480 <mycpu>
    80006be4:	01813083          	ld	ra,24(sp)
    80006be8:	01013403          	ld	s0,16(sp)
    80006bec:	00a4b823          	sd	a0,16(s1)
    80006bf0:	00013903          	ld	s2,0(sp)
    80006bf4:	00813483          	ld	s1,8(sp)
    80006bf8:	02010113          	addi	sp,sp,32
    80006bfc:	00008067          	ret
    80006c00:	0104b903          	ld	s2,16(s1)
    80006c04:	fffff097          	auipc	ra,0xfffff
    80006c08:	87c080e7          	jalr	-1924(ra) # 80005480 <mycpu>
    80006c0c:	faa91ce3          	bne	s2,a0,80006bc4 <acquire+0x58>
    80006c10:	00002517          	auipc	a0,0x2
    80006c14:	8a850513          	addi	a0,a0,-1880 # 800084b8 <digits+0x20>
    80006c18:	fffff097          	auipc	ra,0xfffff
    80006c1c:	224080e7          	jalr	548(ra) # 80005e3c <panic>
    80006c20:	00195913          	srli	s2,s2,0x1
    80006c24:	fffff097          	auipc	ra,0xfffff
    80006c28:	85c080e7          	jalr	-1956(ra) # 80005480 <mycpu>
    80006c2c:	00197913          	andi	s2,s2,1
    80006c30:	07252e23          	sw	s2,124(a0)
    80006c34:	f75ff06f          	j	80006ba8 <acquire+0x3c>

0000000080006c38 <release>:
    80006c38:	fe010113          	addi	sp,sp,-32
    80006c3c:	00813823          	sd	s0,16(sp)
    80006c40:	00113c23          	sd	ra,24(sp)
    80006c44:	00913423          	sd	s1,8(sp)
    80006c48:	01213023          	sd	s2,0(sp)
    80006c4c:	02010413          	addi	s0,sp,32
    80006c50:	00052783          	lw	a5,0(a0)
    80006c54:	00079a63          	bnez	a5,80006c68 <release+0x30>
    80006c58:	00002517          	auipc	a0,0x2
    80006c5c:	86850513          	addi	a0,a0,-1944 # 800084c0 <digits+0x28>
    80006c60:	fffff097          	auipc	ra,0xfffff
    80006c64:	1dc080e7          	jalr	476(ra) # 80005e3c <panic>
    80006c68:	01053903          	ld	s2,16(a0)
    80006c6c:	00050493          	mv	s1,a0
    80006c70:	fffff097          	auipc	ra,0xfffff
    80006c74:	810080e7          	jalr	-2032(ra) # 80005480 <mycpu>
    80006c78:	fea910e3          	bne	s2,a0,80006c58 <release+0x20>
    80006c7c:	0004b823          	sd	zero,16(s1)
    80006c80:	0ff0000f          	fence
    80006c84:	0f50000f          	fence	iorw,ow
    80006c88:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006c8c:	ffffe097          	auipc	ra,0xffffe
    80006c90:	7f4080e7          	jalr	2036(ra) # 80005480 <mycpu>
    80006c94:	100027f3          	csrr	a5,sstatus
    80006c98:	0027f793          	andi	a5,a5,2
    80006c9c:	04079a63          	bnez	a5,80006cf0 <release+0xb8>
    80006ca0:	07852783          	lw	a5,120(a0)
    80006ca4:	02f05e63          	blez	a5,80006ce0 <release+0xa8>
    80006ca8:	fff7871b          	addiw	a4,a5,-1
    80006cac:	06e52c23          	sw	a4,120(a0)
    80006cb0:	00071c63          	bnez	a4,80006cc8 <release+0x90>
    80006cb4:	07c52783          	lw	a5,124(a0)
    80006cb8:	00078863          	beqz	a5,80006cc8 <release+0x90>
    80006cbc:	100027f3          	csrr	a5,sstatus
    80006cc0:	0027e793          	ori	a5,a5,2
    80006cc4:	10079073          	csrw	sstatus,a5
    80006cc8:	01813083          	ld	ra,24(sp)
    80006ccc:	01013403          	ld	s0,16(sp)
    80006cd0:	00813483          	ld	s1,8(sp)
    80006cd4:	00013903          	ld	s2,0(sp)
    80006cd8:	02010113          	addi	sp,sp,32
    80006cdc:	00008067          	ret
    80006ce0:	00002517          	auipc	a0,0x2
    80006ce4:	80050513          	addi	a0,a0,-2048 # 800084e0 <digits+0x48>
    80006ce8:	fffff097          	auipc	ra,0xfffff
    80006cec:	154080e7          	jalr	340(ra) # 80005e3c <panic>
    80006cf0:	00001517          	auipc	a0,0x1
    80006cf4:	7d850513          	addi	a0,a0,2008 # 800084c8 <digits+0x30>
    80006cf8:	fffff097          	auipc	ra,0xfffff
    80006cfc:	144080e7          	jalr	324(ra) # 80005e3c <panic>

0000000080006d00 <holding>:
    80006d00:	00052783          	lw	a5,0(a0)
    80006d04:	00079663          	bnez	a5,80006d10 <holding+0x10>
    80006d08:	00000513          	li	a0,0
    80006d0c:	00008067          	ret
    80006d10:	fe010113          	addi	sp,sp,-32
    80006d14:	00813823          	sd	s0,16(sp)
    80006d18:	00913423          	sd	s1,8(sp)
    80006d1c:	00113c23          	sd	ra,24(sp)
    80006d20:	02010413          	addi	s0,sp,32
    80006d24:	01053483          	ld	s1,16(a0)
    80006d28:	ffffe097          	auipc	ra,0xffffe
    80006d2c:	758080e7          	jalr	1880(ra) # 80005480 <mycpu>
    80006d30:	01813083          	ld	ra,24(sp)
    80006d34:	01013403          	ld	s0,16(sp)
    80006d38:	40a48533          	sub	a0,s1,a0
    80006d3c:	00153513          	seqz	a0,a0
    80006d40:	00813483          	ld	s1,8(sp)
    80006d44:	02010113          	addi	sp,sp,32
    80006d48:	00008067          	ret

0000000080006d4c <push_off>:
    80006d4c:	fe010113          	addi	sp,sp,-32
    80006d50:	00813823          	sd	s0,16(sp)
    80006d54:	00113c23          	sd	ra,24(sp)
    80006d58:	00913423          	sd	s1,8(sp)
    80006d5c:	02010413          	addi	s0,sp,32
    80006d60:	100024f3          	csrr	s1,sstatus
    80006d64:	100027f3          	csrr	a5,sstatus
    80006d68:	ffd7f793          	andi	a5,a5,-3
    80006d6c:	10079073          	csrw	sstatus,a5
    80006d70:	ffffe097          	auipc	ra,0xffffe
    80006d74:	710080e7          	jalr	1808(ra) # 80005480 <mycpu>
    80006d78:	07852783          	lw	a5,120(a0)
    80006d7c:	02078663          	beqz	a5,80006da8 <push_off+0x5c>
    80006d80:	ffffe097          	auipc	ra,0xffffe
    80006d84:	700080e7          	jalr	1792(ra) # 80005480 <mycpu>
    80006d88:	07852783          	lw	a5,120(a0)
    80006d8c:	01813083          	ld	ra,24(sp)
    80006d90:	01013403          	ld	s0,16(sp)
    80006d94:	0017879b          	addiw	a5,a5,1
    80006d98:	06f52c23          	sw	a5,120(a0)
    80006d9c:	00813483          	ld	s1,8(sp)
    80006da0:	02010113          	addi	sp,sp,32
    80006da4:	00008067          	ret
    80006da8:	0014d493          	srli	s1,s1,0x1
    80006dac:	ffffe097          	auipc	ra,0xffffe
    80006db0:	6d4080e7          	jalr	1748(ra) # 80005480 <mycpu>
    80006db4:	0014f493          	andi	s1,s1,1
    80006db8:	06952e23          	sw	s1,124(a0)
    80006dbc:	fc5ff06f          	j	80006d80 <push_off+0x34>

0000000080006dc0 <pop_off>:
    80006dc0:	ff010113          	addi	sp,sp,-16
    80006dc4:	00813023          	sd	s0,0(sp)
    80006dc8:	00113423          	sd	ra,8(sp)
    80006dcc:	01010413          	addi	s0,sp,16
    80006dd0:	ffffe097          	auipc	ra,0xffffe
    80006dd4:	6b0080e7          	jalr	1712(ra) # 80005480 <mycpu>
    80006dd8:	100027f3          	csrr	a5,sstatus
    80006ddc:	0027f793          	andi	a5,a5,2
    80006de0:	04079663          	bnez	a5,80006e2c <pop_off+0x6c>
    80006de4:	07852783          	lw	a5,120(a0)
    80006de8:	02f05a63          	blez	a5,80006e1c <pop_off+0x5c>
    80006dec:	fff7871b          	addiw	a4,a5,-1
    80006df0:	06e52c23          	sw	a4,120(a0)
    80006df4:	00071c63          	bnez	a4,80006e0c <pop_off+0x4c>
    80006df8:	07c52783          	lw	a5,124(a0)
    80006dfc:	00078863          	beqz	a5,80006e0c <pop_off+0x4c>
    80006e00:	100027f3          	csrr	a5,sstatus
    80006e04:	0027e793          	ori	a5,a5,2
    80006e08:	10079073          	csrw	sstatus,a5
    80006e0c:	00813083          	ld	ra,8(sp)
    80006e10:	00013403          	ld	s0,0(sp)
    80006e14:	01010113          	addi	sp,sp,16
    80006e18:	00008067          	ret
    80006e1c:	00001517          	auipc	a0,0x1
    80006e20:	6c450513          	addi	a0,a0,1732 # 800084e0 <digits+0x48>
    80006e24:	fffff097          	auipc	ra,0xfffff
    80006e28:	018080e7          	jalr	24(ra) # 80005e3c <panic>
    80006e2c:	00001517          	auipc	a0,0x1
    80006e30:	69c50513          	addi	a0,a0,1692 # 800084c8 <digits+0x30>
    80006e34:	fffff097          	auipc	ra,0xfffff
    80006e38:	008080e7          	jalr	8(ra) # 80005e3c <panic>

0000000080006e3c <push_on>:
    80006e3c:	fe010113          	addi	sp,sp,-32
    80006e40:	00813823          	sd	s0,16(sp)
    80006e44:	00113c23          	sd	ra,24(sp)
    80006e48:	00913423          	sd	s1,8(sp)
    80006e4c:	02010413          	addi	s0,sp,32
    80006e50:	100024f3          	csrr	s1,sstatus
    80006e54:	100027f3          	csrr	a5,sstatus
    80006e58:	0027e793          	ori	a5,a5,2
    80006e5c:	10079073          	csrw	sstatus,a5
    80006e60:	ffffe097          	auipc	ra,0xffffe
    80006e64:	620080e7          	jalr	1568(ra) # 80005480 <mycpu>
    80006e68:	07852783          	lw	a5,120(a0)
    80006e6c:	02078663          	beqz	a5,80006e98 <push_on+0x5c>
    80006e70:	ffffe097          	auipc	ra,0xffffe
    80006e74:	610080e7          	jalr	1552(ra) # 80005480 <mycpu>
    80006e78:	07852783          	lw	a5,120(a0)
    80006e7c:	01813083          	ld	ra,24(sp)
    80006e80:	01013403          	ld	s0,16(sp)
    80006e84:	0017879b          	addiw	a5,a5,1
    80006e88:	06f52c23          	sw	a5,120(a0)
    80006e8c:	00813483          	ld	s1,8(sp)
    80006e90:	02010113          	addi	sp,sp,32
    80006e94:	00008067          	ret
    80006e98:	0014d493          	srli	s1,s1,0x1
    80006e9c:	ffffe097          	auipc	ra,0xffffe
    80006ea0:	5e4080e7          	jalr	1508(ra) # 80005480 <mycpu>
    80006ea4:	0014f493          	andi	s1,s1,1
    80006ea8:	06952e23          	sw	s1,124(a0)
    80006eac:	fc5ff06f          	j	80006e70 <push_on+0x34>

0000000080006eb0 <pop_on>:
    80006eb0:	ff010113          	addi	sp,sp,-16
    80006eb4:	00813023          	sd	s0,0(sp)
    80006eb8:	00113423          	sd	ra,8(sp)
    80006ebc:	01010413          	addi	s0,sp,16
    80006ec0:	ffffe097          	auipc	ra,0xffffe
    80006ec4:	5c0080e7          	jalr	1472(ra) # 80005480 <mycpu>
    80006ec8:	100027f3          	csrr	a5,sstatus
    80006ecc:	0027f793          	andi	a5,a5,2
    80006ed0:	04078463          	beqz	a5,80006f18 <pop_on+0x68>
    80006ed4:	07852783          	lw	a5,120(a0)
    80006ed8:	02f05863          	blez	a5,80006f08 <pop_on+0x58>
    80006edc:	fff7879b          	addiw	a5,a5,-1
    80006ee0:	06f52c23          	sw	a5,120(a0)
    80006ee4:	07853783          	ld	a5,120(a0)
    80006ee8:	00079863          	bnez	a5,80006ef8 <pop_on+0x48>
    80006eec:	100027f3          	csrr	a5,sstatus
    80006ef0:	ffd7f793          	andi	a5,a5,-3
    80006ef4:	10079073          	csrw	sstatus,a5
    80006ef8:	00813083          	ld	ra,8(sp)
    80006efc:	00013403          	ld	s0,0(sp)
    80006f00:	01010113          	addi	sp,sp,16
    80006f04:	00008067          	ret
    80006f08:	00001517          	auipc	a0,0x1
    80006f0c:	60050513          	addi	a0,a0,1536 # 80008508 <digits+0x70>
    80006f10:	fffff097          	auipc	ra,0xfffff
    80006f14:	f2c080e7          	jalr	-212(ra) # 80005e3c <panic>
    80006f18:	00001517          	auipc	a0,0x1
    80006f1c:	5d050513          	addi	a0,a0,1488 # 800084e8 <digits+0x50>
    80006f20:	fffff097          	auipc	ra,0xfffff
    80006f24:	f1c080e7          	jalr	-228(ra) # 80005e3c <panic>

0000000080006f28 <__memset>:
    80006f28:	ff010113          	addi	sp,sp,-16
    80006f2c:	00813423          	sd	s0,8(sp)
    80006f30:	01010413          	addi	s0,sp,16
    80006f34:	1a060e63          	beqz	a2,800070f0 <__memset+0x1c8>
    80006f38:	40a007b3          	neg	a5,a0
    80006f3c:	0077f793          	andi	a5,a5,7
    80006f40:	00778693          	addi	a3,a5,7
    80006f44:	00b00813          	li	a6,11
    80006f48:	0ff5f593          	andi	a1,a1,255
    80006f4c:	fff6071b          	addiw	a4,a2,-1
    80006f50:	1b06e663          	bltu	a3,a6,800070fc <__memset+0x1d4>
    80006f54:	1cd76463          	bltu	a4,a3,8000711c <__memset+0x1f4>
    80006f58:	1a078e63          	beqz	a5,80007114 <__memset+0x1ec>
    80006f5c:	00b50023          	sb	a1,0(a0)
    80006f60:	00100713          	li	a4,1
    80006f64:	1ae78463          	beq	a5,a4,8000710c <__memset+0x1e4>
    80006f68:	00b500a3          	sb	a1,1(a0)
    80006f6c:	00200713          	li	a4,2
    80006f70:	1ae78a63          	beq	a5,a4,80007124 <__memset+0x1fc>
    80006f74:	00b50123          	sb	a1,2(a0)
    80006f78:	00300713          	li	a4,3
    80006f7c:	18e78463          	beq	a5,a4,80007104 <__memset+0x1dc>
    80006f80:	00b501a3          	sb	a1,3(a0)
    80006f84:	00400713          	li	a4,4
    80006f88:	1ae78263          	beq	a5,a4,8000712c <__memset+0x204>
    80006f8c:	00b50223          	sb	a1,4(a0)
    80006f90:	00500713          	li	a4,5
    80006f94:	1ae78063          	beq	a5,a4,80007134 <__memset+0x20c>
    80006f98:	00b502a3          	sb	a1,5(a0)
    80006f9c:	00700713          	li	a4,7
    80006fa0:	18e79e63          	bne	a5,a4,8000713c <__memset+0x214>
    80006fa4:	00b50323          	sb	a1,6(a0)
    80006fa8:	00700e93          	li	t4,7
    80006fac:	00859713          	slli	a4,a1,0x8
    80006fb0:	00e5e733          	or	a4,a1,a4
    80006fb4:	01059e13          	slli	t3,a1,0x10
    80006fb8:	01c76e33          	or	t3,a4,t3
    80006fbc:	01859313          	slli	t1,a1,0x18
    80006fc0:	006e6333          	or	t1,t3,t1
    80006fc4:	02059893          	slli	a7,a1,0x20
    80006fc8:	40f60e3b          	subw	t3,a2,a5
    80006fcc:	011368b3          	or	a7,t1,a7
    80006fd0:	02859813          	slli	a6,a1,0x28
    80006fd4:	0108e833          	or	a6,a7,a6
    80006fd8:	03059693          	slli	a3,a1,0x30
    80006fdc:	003e589b          	srliw	a7,t3,0x3
    80006fe0:	00d866b3          	or	a3,a6,a3
    80006fe4:	03859713          	slli	a4,a1,0x38
    80006fe8:	00389813          	slli	a6,a7,0x3
    80006fec:	00f507b3          	add	a5,a0,a5
    80006ff0:	00e6e733          	or	a4,a3,a4
    80006ff4:	000e089b          	sext.w	a7,t3
    80006ff8:	00f806b3          	add	a3,a6,a5
    80006ffc:	00e7b023          	sd	a4,0(a5)
    80007000:	00878793          	addi	a5,a5,8
    80007004:	fed79ce3          	bne	a5,a3,80006ffc <__memset+0xd4>
    80007008:	ff8e7793          	andi	a5,t3,-8
    8000700c:	0007871b          	sext.w	a4,a5
    80007010:	01d787bb          	addw	a5,a5,t4
    80007014:	0ce88e63          	beq	a7,a4,800070f0 <__memset+0x1c8>
    80007018:	00f50733          	add	a4,a0,a5
    8000701c:	00b70023          	sb	a1,0(a4)
    80007020:	0017871b          	addiw	a4,a5,1
    80007024:	0cc77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007028:	00e50733          	add	a4,a0,a4
    8000702c:	00b70023          	sb	a1,0(a4)
    80007030:	0027871b          	addiw	a4,a5,2
    80007034:	0ac77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007038:	00e50733          	add	a4,a0,a4
    8000703c:	00b70023          	sb	a1,0(a4)
    80007040:	0037871b          	addiw	a4,a5,3
    80007044:	0ac77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007048:	00e50733          	add	a4,a0,a4
    8000704c:	00b70023          	sb	a1,0(a4)
    80007050:	0047871b          	addiw	a4,a5,4
    80007054:	08c77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007058:	00e50733          	add	a4,a0,a4
    8000705c:	00b70023          	sb	a1,0(a4)
    80007060:	0057871b          	addiw	a4,a5,5
    80007064:	08c77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007068:	00e50733          	add	a4,a0,a4
    8000706c:	00b70023          	sb	a1,0(a4)
    80007070:	0067871b          	addiw	a4,a5,6
    80007074:	06c77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007078:	00e50733          	add	a4,a0,a4
    8000707c:	00b70023          	sb	a1,0(a4)
    80007080:	0077871b          	addiw	a4,a5,7
    80007084:	06c77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007088:	00e50733          	add	a4,a0,a4
    8000708c:	00b70023          	sb	a1,0(a4)
    80007090:	0087871b          	addiw	a4,a5,8
    80007094:	04c77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    80007098:	00e50733          	add	a4,a0,a4
    8000709c:	00b70023          	sb	a1,0(a4)
    800070a0:	0097871b          	addiw	a4,a5,9
    800070a4:	04c77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    800070a8:	00e50733          	add	a4,a0,a4
    800070ac:	00b70023          	sb	a1,0(a4)
    800070b0:	00a7871b          	addiw	a4,a5,10
    800070b4:	02c77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    800070b8:	00e50733          	add	a4,a0,a4
    800070bc:	00b70023          	sb	a1,0(a4)
    800070c0:	00b7871b          	addiw	a4,a5,11
    800070c4:	02c77663          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    800070c8:	00e50733          	add	a4,a0,a4
    800070cc:	00b70023          	sb	a1,0(a4)
    800070d0:	00c7871b          	addiw	a4,a5,12
    800070d4:	00c77e63          	bgeu	a4,a2,800070f0 <__memset+0x1c8>
    800070d8:	00e50733          	add	a4,a0,a4
    800070dc:	00b70023          	sb	a1,0(a4)
    800070e0:	00d7879b          	addiw	a5,a5,13
    800070e4:	00c7f663          	bgeu	a5,a2,800070f0 <__memset+0x1c8>
    800070e8:	00f507b3          	add	a5,a0,a5
    800070ec:	00b78023          	sb	a1,0(a5)
    800070f0:	00813403          	ld	s0,8(sp)
    800070f4:	01010113          	addi	sp,sp,16
    800070f8:	00008067          	ret
    800070fc:	00b00693          	li	a3,11
    80007100:	e55ff06f          	j	80006f54 <__memset+0x2c>
    80007104:	00300e93          	li	t4,3
    80007108:	ea5ff06f          	j	80006fac <__memset+0x84>
    8000710c:	00100e93          	li	t4,1
    80007110:	e9dff06f          	j	80006fac <__memset+0x84>
    80007114:	00000e93          	li	t4,0
    80007118:	e95ff06f          	j	80006fac <__memset+0x84>
    8000711c:	00000793          	li	a5,0
    80007120:	ef9ff06f          	j	80007018 <__memset+0xf0>
    80007124:	00200e93          	li	t4,2
    80007128:	e85ff06f          	j	80006fac <__memset+0x84>
    8000712c:	00400e93          	li	t4,4
    80007130:	e7dff06f          	j	80006fac <__memset+0x84>
    80007134:	00500e93          	li	t4,5
    80007138:	e75ff06f          	j	80006fac <__memset+0x84>
    8000713c:	00600e93          	li	t4,6
    80007140:	e6dff06f          	j	80006fac <__memset+0x84>

0000000080007144 <__memmove>:
    80007144:	ff010113          	addi	sp,sp,-16
    80007148:	00813423          	sd	s0,8(sp)
    8000714c:	01010413          	addi	s0,sp,16
    80007150:	0e060863          	beqz	a2,80007240 <__memmove+0xfc>
    80007154:	fff6069b          	addiw	a3,a2,-1
    80007158:	0006881b          	sext.w	a6,a3
    8000715c:	0ea5e863          	bltu	a1,a0,8000724c <__memmove+0x108>
    80007160:	00758713          	addi	a4,a1,7
    80007164:	00a5e7b3          	or	a5,a1,a0
    80007168:	40a70733          	sub	a4,a4,a0
    8000716c:	0077f793          	andi	a5,a5,7
    80007170:	00f73713          	sltiu	a4,a4,15
    80007174:	00174713          	xori	a4,a4,1
    80007178:	0017b793          	seqz	a5,a5
    8000717c:	00e7f7b3          	and	a5,a5,a4
    80007180:	10078863          	beqz	a5,80007290 <__memmove+0x14c>
    80007184:	00900793          	li	a5,9
    80007188:	1107f463          	bgeu	a5,a6,80007290 <__memmove+0x14c>
    8000718c:	0036581b          	srliw	a6,a2,0x3
    80007190:	fff8081b          	addiw	a6,a6,-1
    80007194:	02081813          	slli	a6,a6,0x20
    80007198:	01d85893          	srli	a7,a6,0x1d
    8000719c:	00858813          	addi	a6,a1,8
    800071a0:	00058793          	mv	a5,a1
    800071a4:	00050713          	mv	a4,a0
    800071a8:	01088833          	add	a6,a7,a6
    800071ac:	0007b883          	ld	a7,0(a5)
    800071b0:	00878793          	addi	a5,a5,8
    800071b4:	00870713          	addi	a4,a4,8
    800071b8:	ff173c23          	sd	a7,-8(a4)
    800071bc:	ff0798e3          	bne	a5,a6,800071ac <__memmove+0x68>
    800071c0:	ff867713          	andi	a4,a2,-8
    800071c4:	02071793          	slli	a5,a4,0x20
    800071c8:	0207d793          	srli	a5,a5,0x20
    800071cc:	00f585b3          	add	a1,a1,a5
    800071d0:	40e686bb          	subw	a3,a3,a4
    800071d4:	00f507b3          	add	a5,a0,a5
    800071d8:	06e60463          	beq	a2,a4,80007240 <__memmove+0xfc>
    800071dc:	0005c703          	lbu	a4,0(a1)
    800071e0:	00e78023          	sb	a4,0(a5)
    800071e4:	04068e63          	beqz	a3,80007240 <__memmove+0xfc>
    800071e8:	0015c603          	lbu	a2,1(a1)
    800071ec:	00100713          	li	a4,1
    800071f0:	00c780a3          	sb	a2,1(a5)
    800071f4:	04e68663          	beq	a3,a4,80007240 <__memmove+0xfc>
    800071f8:	0025c603          	lbu	a2,2(a1)
    800071fc:	00200713          	li	a4,2
    80007200:	00c78123          	sb	a2,2(a5)
    80007204:	02e68e63          	beq	a3,a4,80007240 <__memmove+0xfc>
    80007208:	0035c603          	lbu	a2,3(a1)
    8000720c:	00300713          	li	a4,3
    80007210:	00c781a3          	sb	a2,3(a5)
    80007214:	02e68663          	beq	a3,a4,80007240 <__memmove+0xfc>
    80007218:	0045c603          	lbu	a2,4(a1)
    8000721c:	00400713          	li	a4,4
    80007220:	00c78223          	sb	a2,4(a5)
    80007224:	00e68e63          	beq	a3,a4,80007240 <__memmove+0xfc>
    80007228:	0055c603          	lbu	a2,5(a1)
    8000722c:	00500713          	li	a4,5
    80007230:	00c782a3          	sb	a2,5(a5)
    80007234:	00e68663          	beq	a3,a4,80007240 <__memmove+0xfc>
    80007238:	0065c703          	lbu	a4,6(a1)
    8000723c:	00e78323          	sb	a4,6(a5)
    80007240:	00813403          	ld	s0,8(sp)
    80007244:	01010113          	addi	sp,sp,16
    80007248:	00008067          	ret
    8000724c:	02061713          	slli	a4,a2,0x20
    80007250:	02075713          	srli	a4,a4,0x20
    80007254:	00e587b3          	add	a5,a1,a4
    80007258:	f0f574e3          	bgeu	a0,a5,80007160 <__memmove+0x1c>
    8000725c:	02069613          	slli	a2,a3,0x20
    80007260:	02065613          	srli	a2,a2,0x20
    80007264:	fff64613          	not	a2,a2
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00c78633          	add	a2,a5,a2
    80007270:	fff7c683          	lbu	a3,-1(a5)
    80007274:	fff78793          	addi	a5,a5,-1
    80007278:	fff70713          	addi	a4,a4,-1
    8000727c:	00d70023          	sb	a3,0(a4)
    80007280:	fec798e3          	bne	a5,a2,80007270 <__memmove+0x12c>
    80007284:	00813403          	ld	s0,8(sp)
    80007288:	01010113          	addi	sp,sp,16
    8000728c:	00008067          	ret
    80007290:	02069713          	slli	a4,a3,0x20
    80007294:	02075713          	srli	a4,a4,0x20
    80007298:	00170713          	addi	a4,a4,1
    8000729c:	00e50733          	add	a4,a0,a4
    800072a0:	00050793          	mv	a5,a0
    800072a4:	0005c683          	lbu	a3,0(a1)
    800072a8:	00178793          	addi	a5,a5,1
    800072ac:	00158593          	addi	a1,a1,1
    800072b0:	fed78fa3          	sb	a3,-1(a5)
    800072b4:	fee798e3          	bne	a5,a4,800072a4 <__memmove+0x160>
    800072b8:	f89ff06f          	j	80007240 <__memmove+0xfc>
	...
