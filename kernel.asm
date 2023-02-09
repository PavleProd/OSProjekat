
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
    8000001c:	208050ef          	jal	ra,80005224 <start>

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
    8000100c:	479000ef          	jal	ra,80001c84 <_ZN3PCB10getContextEv>
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
    8000109c:	4e4000ef          	jal	ra,80001580 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	3e5000ef          	jal	ra,80001c84 <_ZN3PCB10getContextEv>

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
    80001208:	fe010113          	addi	sp,sp,-32
    8000120c:	00113c23          	sd	ra,24(sp)
    80001210:	00813823          	sd	s0,16(sp)
    80001214:	00913423          	sd	s1,8(sp)
    80001218:	02010413          	addi	s0,sp,32
    8000121c:	00050493          	mv	s1,a0
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    80001220:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    80001224:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a4 = handle privremeno cuvamo da bismo posle vratili u a1
    80001228:	00050713          	mv	a4,a0


    size_t* stack = (size_t*)mem_alloc(sizeof(size_t)*DEFAULT_STACK_SIZE); // pravimo stack procesa
    8000122c:	00008537          	lui	a0,0x8
    80001230:	00000097          	auipc	ra,0x0
    80001234:	f64080e7          	jalr	-156(ra) # 80001194 <_Z9mem_allocm>
    if(stack == nullptr) {
    80001238:	02050c63          	beqz	a0,80001270 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x68>
        *handle = nullptr;
        return -1;
    }

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    8000123c:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001240:	00050713          	mv	a4,a0

    handle = (thread_t*)(callInterrupt(code)); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    80001244:	01100513          	li	a0,17
    80001248:	00000097          	auipc	ra,0x0
    8000124c:	f28080e7          	jalr	-216(ra) # 80001170 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001250:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    80001254:	02078463          	beqz	a5,8000127c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x74>
        return -1;
    }
    return 0;
    80001258:	00000513          	li	a0,0
}
    8000125c:	01813083          	ld	ra,24(sp)
    80001260:	01013403          	ld	s0,16(sp)
    80001264:	00813483          	ld	s1,8(sp)
    80001268:	02010113          	addi	sp,sp,32
    8000126c:	00008067          	ret
        *handle = nullptr;
    80001270:	0004b023          	sd	zero,0(s1)
        return -1;
    80001274:	fff00513          	li	a0,-1
    80001278:	fe5ff06f          	j	8000125c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x54>
        return -1;
    8000127c:	fff00513          	li	a0,-1
    80001280:	fddff06f          	j	8000125c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x54>

0000000080001284 <_Z15thread_dispatchv>:
    int res = thread_create_only(handle, startRoutine, arg);
    thread_start(handle);
    return res;
}

void thread_dispatch () {
    80001284:	ff010113          	addi	sp,sp,-16
    80001288:	00113423          	sd	ra,8(sp)
    8000128c:	00813023          	sd	s0,0(sp)
    80001290:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    callInterrupt(code);
    80001294:	01300513          	li	a0,19
    80001298:	00000097          	auipc	ra,0x0
    8000129c:	ed8080e7          	jalr	-296(ra) # 80001170 <_Z13callInterruptm>
}
    800012a0:	00813083          	ld	ra,8(sp)
    800012a4:	00013403          	ld	s0,0(sp)
    800012a8:	01010113          	addi	sp,sp,16
    800012ac:	00008067          	ret

00000000800012b0 <_Z11thread_exitv>:

int thread_exit () {
    800012b0:	ff010113          	addi	sp,sp,-16
    800012b4:	00113423          	sd	ra,8(sp)
    800012b8:	00813023          	sd	s0,0(sp)
    800012bc:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_exit;
    return (size_t)(callInterrupt(code));
    800012c0:	01200513          	li	a0,18
    800012c4:	00000097          	auipc	ra,0x0
    800012c8:	eac080e7          	jalr	-340(ra) # 80001170 <_Z13callInterruptm>
}
    800012cc:	0005051b          	sext.w	a0,a0
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_Z12thread_startPP3PCB>:

void thread_start(thread_t* handle) {
    800012e0:	ff010113          	addi	sp,sp,-16
    800012e4:	00113423          	sd	ra,8(sp)
    800012e8:	00813023          	sd	s0,0(sp)
    800012ec:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a1, a0"); // a1 = handle
    800012f0:	00050593          	mv	a1,a0
    callInterrupt(code);
    800012f4:	01400513          	li	a0,20
    800012f8:	00000097          	auipc	ra,0x0
    800012fc:	e78080e7          	jalr	-392(ra) # 80001170 <_Z13callInterruptm>
}
    80001300:	00813083          	ld	ra,8(sp)
    80001304:	00013403          	ld	s0,0(sp)
    80001308:	01010113          	addi	sp,sp,16
    8000130c:	00008067          	ret

0000000080001310 <_Z13thread_createPP3PCBPFvPvES2_>:
int thread_create(thread_t* handle, void(*startRoutine)(void*), void* arg) {
    80001310:	fe010113          	addi	sp,sp,-32
    80001314:	00113c23          	sd	ra,24(sp)
    80001318:	00813823          	sd	s0,16(sp)
    8000131c:	00913423          	sd	s1,8(sp)
    80001320:	01213023          	sd	s2,0(sp)
    80001324:	02010413          	addi	s0,sp,32
    80001328:	00050913          	mv	s2,a0
    int res = thread_create_only(handle, startRoutine, arg);
    8000132c:	00000097          	auipc	ra,0x0
    80001330:	edc080e7          	jalr	-292(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    80001334:	00050493          	mv	s1,a0
    thread_start(handle);
    80001338:	00090513          	mv	a0,s2
    8000133c:	00000097          	auipc	ra,0x0
    80001340:	fa4080e7          	jalr	-92(ra) # 800012e0 <_Z12thread_startPP3PCB>
}
    80001344:	00048513          	mv	a0,s1
    80001348:	01813083          	ld	ra,24(sp)
    8000134c:	01013403          	ld	s0,16(sp)
    80001350:	00813483          	ld	s1,8(sp)
    80001354:	00013903          	ld	s2,0(sp)
    80001358:	02010113          	addi	sp,sp,32
    8000135c:	00008067          	ret

0000000080001360 <_Z8sem_openPP3SCBj>:

int sem_open (sem_t* handle, unsigned init) {
    80001360:	ff010113          	addi	sp,sp,-16
    80001364:	00113423          	sd	ra,8(sp)
    80001368:	00813023          	sd	s0,0(sp)
    8000136c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::sem_open;

    asm volatile("mv a2, a1"); // a2 = init
    80001370:	00058613          	mv	a2,a1
    asm volatile("mv a1, a0"); // a1 = handle
    80001374:	00050593          	mv	a1,a0

    handle = (sem_t*)callInterrupt(code);
    80001378:	02100513          	li	a0,33
    8000137c:	00000097          	auipc	ra,0x0
    80001380:	df4080e7          	jalr	-524(ra) # 80001170 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001384:	00053783          	ld	a5,0(a0)
    80001388:	00078c63          	beqz	a5,800013a0 <_Z8sem_openPP3SCBj+0x40>
        return -1;
    }

    return 0;
    8000138c:	00000513          	li	a0,0
}
    80001390:	00813083          	ld	ra,8(sp)
    80001394:	00013403          	ld	s0,0(sp)
    80001398:	01010113          	addi	sp,sp,16
    8000139c:	00008067          	ret
        return -1;
    800013a0:	fff00513          	li	a0,-1
    800013a4:	fedff06f          	j	80001390 <_Z8sem_openPP3SCBj+0x30>

00000000800013a8 <_Z8sem_waitP3SCB>:

int sem_wait (sem_t volatile handle) {
    800013a8:	fe010113          	addi	sp,sp,-32
    800013ac:	00113c23          	sd	ra,24(sp)
    800013b0:	00813823          	sd	s0,16(sp)
    800013b4:	02010413          	addi	s0,sp,32
    800013b8:	fea43423          	sd	a0,-24(s0)
    size_t code = Kernel::sysCallCodes::sem_wait;
    if(handle == nullptr) return -1;
    800013bc:	fe843783          	ld	a5,-24(s0)
    800013c0:	02078463          	beqz	a5,800013e8 <_Z8sem_waitP3SCB+0x40>
    asm volatile("mv a1, a0");
    800013c4:	00050593          	mv	a1,a0

    return (int)(size_t)callInterrupt(code);
    800013c8:	02300513          	li	a0,35
    800013cc:	00000097          	auipc	ra,0x0
    800013d0:	da4080e7          	jalr	-604(ra) # 80001170 <_Z13callInterruptm>
    800013d4:	0005051b          	sext.w	a0,a0
}
    800013d8:	01813083          	ld	ra,24(sp)
    800013dc:	01013403          	ld	s0,16(sp)
    800013e0:	02010113          	addi	sp,sp,32
    800013e4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013e8:	fff00513          	li	a0,-1
    800013ec:	fedff06f          	j	800013d8 <_Z8sem_waitP3SCB+0x30>

00000000800013f0 <_Z10sem_signalP3SCB>:

int sem_signal (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(handle == nullptr) return -1;
    800013f0:	02050c63          	beqz	a0,80001428 <_Z10sem_signalP3SCB+0x38>
int sem_signal (sem_t handle) {
    800013f4:	ff010113          	addi	sp,sp,-16
    800013f8:	00113423          	sd	ra,8(sp)
    800013fc:	00813023          	sd	s0,0(sp)
    80001400:	01010413          	addi	s0,sp,16
    asm volatile("mv a1, a0");
    80001404:	00050593          	mv	a1,a0

    callInterrupt(code);
    80001408:	02400513          	li	a0,36
    8000140c:	00000097          	auipc	ra,0x0
    80001410:	d64080e7          	jalr	-668(ra) # 80001170 <_Z13callInterruptm>

    return 0;
    80001414:	00000513          	li	a0,0
}
    80001418:	00813083          	ld	ra,8(sp)
    8000141c:	00013403          	ld	s0,0(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret
    if(handle == nullptr) return -1;
    80001428:	fff00513          	li	a0,-1
}
    8000142c:	00008067          	ret

0000000080001430 <_Z9sem_closeP3SCB>:

int sem_close (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_close;
    if(handle == nullptr) return -1;
    80001430:	02050c63          	beqz	a0,80001468 <_Z9sem_closeP3SCB+0x38>
int sem_close (sem_t handle) {
    80001434:	ff010113          	addi	sp,sp,-16
    80001438:	00113423          	sd	ra,8(sp)
    8000143c:	00813023          	sd	s0,0(sp)
    80001440:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001444:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001448:	02200513          	li	a0,34
    8000144c:	00000097          	auipc	ra,0x0
    80001450:	d24080e7          	jalr	-732(ra) # 80001170 <_Z13callInterruptm>
    return 0;
    80001454:	00000513          	li	a0,0
}
    80001458:	00813083          	ld	ra,8(sp)
    8000145c:	00013403          	ld	s0,0(sp)
    80001460:	01010113          	addi	sp,sp,16
    80001464:	00008067          	ret
    if(handle == nullptr) return -1;
    80001468:	fff00513          	li	a0,-1
}
    8000146c:	00008067          	ret

0000000080001470 <_Z10time_sleepm>:

int time_sleep (time_t time) {
    size_t code = Kernel::sysCallCodes::time_sleep;
    if(time <= 0) return -1;
    80001470:	04050063          	beqz	a0,800014b0 <_Z10time_sleepm+0x40>
int time_sleep (time_t time) {
    80001474:	ff010113          	addi	sp,sp,-16
    80001478:	00113423          	sd	ra,8(sp)
    8000147c:	00813023          	sd	s0,0(sp)
    80001480:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001484:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001488:	03100513          	li	a0,49
    8000148c:	00000097          	auipc	ra,0x0
    80001490:	ce4080e7          	jalr	-796(ra) # 80001170 <_Z13callInterruptm>

    thread_dispatch(); // radimo odmah dispatch da bi zaustavili tekuci proces
    80001494:	00000097          	auipc	ra,0x0
    80001498:	df0080e7          	jalr	-528(ra) # 80001284 <_Z15thread_dispatchv>

    return 0;
    8000149c:	00000513          	li	a0,0
}
    800014a0:	00813083          	ld	ra,8(sp)
    800014a4:	00013403          	ld	s0,0(sp)
    800014a8:	01010113          	addi	sp,sp,16
    800014ac:	00008067          	ret
    if(time <= 0) return -1;
    800014b0:	fff00513          	li	a0,-1
}
    800014b4:	00008067          	ret

00000000800014b8 <_Z4getcv>:

char getc () {
    800014b8:	ff010113          	addi	sp,sp,-16
    800014bc:	00113423          	sd	ra,8(sp)
    800014c0:	00813023          	sd	s0,0(sp)
    800014c4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::getc;
    return (char)(size_t)callInterrupt(code);
    800014c8:	04100513          	li	a0,65
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	ca4080e7          	jalr	-860(ra) # 80001170 <_Z13callInterruptm>
}
    800014d4:	0ff57513          	andi	a0,a0,255
    800014d8:	00813083          	ld	ra,8(sp)
    800014dc:	00013403          	ld	s0,0(sp)
    800014e0:	01010113          	addi	sp,sp,16
    800014e4:	00008067          	ret

00000000800014e8 <_Z4putcc>:

void putc(char c) {
    800014e8:	ff010113          	addi	sp,sp,-16
    800014ec:	00113423          	sd	ra,8(sp)
    800014f0:	00813023          	sd	s0,0(sp)
    800014f4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::putc;
    asm volatile("mv a1, a0"); // a1 = c
    800014f8:	00050593          	mv	a1,a0
    callInterrupt(code);
    800014fc:	04200513          	li	a0,66
    80001500:	00000097          	auipc	ra,0x0
    80001504:	c70080e7          	jalr	-912(ra) # 80001170 <_Z13callInterruptm>
}
    80001508:	00813083          	ld	ra,8(sp)
    8000150c:	00013403          	ld	s0,0(sp)
    80001510:	01010113          	addi	sp,sp,16
    80001514:	00008067          	ret

0000000080001518 <_ZN6Kernel10popSppSpieEv>:
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"
#include "../h/CCB.h"
#include "../h/syscall_c.h"
void Kernel::popSppSpie() {
    80001518:	ff010113          	addi	sp,sp,-16
    8000151c:	00813423          	sd	s0,8(sp)
    80001520:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001524:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001528:	10200073          	sret
}
    8000152c:	00813403          	ld	s0,8(sp)
    80001530:	01010113          	addi	sp,sp,16
    80001534:	00008067          	ret

0000000080001538 <_Z5kPutcc>:


void kPutc(char c) {
    80001538:	ff010113          	addi	sp,sp,-16
    8000153c:	00113423          	sd	ra,8(sp)
    80001540:	00813023          	sd	s0,0(sp)
    80001544:	01010413          	addi	s0,sp,16
    80001548:	00050593          	mv	a1,a0
    CCB::outputBuffer.pushBack(c);
    8000154c:	00009517          	auipc	a0,0x9
    80001550:	e5453503          	ld	a0,-428(a0) # 8000a3a0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001554:	00001097          	auipc	ra,0x1
    80001558:	eac080e7          	jalr	-340(ra) # 80002400 <_ZN8IOBuffer8pushBackEc>
    CCB::semOutput->signal();
    8000155c:	00009797          	auipc	a5,0x9
    80001560:	e8c7b783          	ld	a5,-372(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001564:	0007b503          	ld	a0,0(a5)
    80001568:	00002097          	auipc	ra,0x2
    8000156c:	374080e7          	jalr	884(ra) # 800038dc <_ZN3SCB6signalEv>
}
    80001570:	00813083          	ld	ra,8(sp)
    80001574:	00013403          	ld	s0,0(sp)
    80001578:	01010113          	addi	sp,sp,16
    8000157c:	00008067          	ret

0000000080001580 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001580:	fa010113          	addi	sp,sp,-96
    80001584:	04113c23          	sd	ra,88(sp)
    80001588:	04813823          	sd	s0,80(sp)
    8000158c:	04913423          	sd	s1,72(sp)
    80001590:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001594:	142027f3          	csrr	a5,scause
    80001598:	fcf43023          	sd	a5,-64(s0)
        return scause;
    8000159c:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    800015a0:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800015a4:	141027f3          	csrr	a5,sepc
    800015a8:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    800015ac:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    800015b0:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800015b4:	100027f3          	csrr	a5,sstatus
    800015b8:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    800015bc:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    800015c0:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800015c4:	fd843703          	ld	a4,-40(s0)
    800015c8:	00900793          	li	a5,9
    800015cc:	04f70463          	beq	a4,a5,80001614 <interruptHandler+0x94>
    800015d0:	fd843703          	ld	a4,-40(s0)
    800015d4:	00800793          	li	a5,8
    800015d8:	02f70e63          	beq	a4,a5,80001614 <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800015dc:	fd843703          	ld	a4,-40(s0)
    800015e0:	fff00793          	li	a5,-1
    800015e4:	03f79793          	slli	a5,a5,0x3f
    800015e8:	00178793          	addi	a5,a5,1
    800015ec:	30f70663          	beq	a4,a5,800018f8 <interruptHandler+0x378>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800015f0:	fd843703          	ld	a4,-40(s0)
    800015f4:	fff00793          	li	a5,-1
    800015f8:	03f79793          	slli	a5,a5,0x3f
    800015fc:	00978793          	addi	a5,a5,9
    80001600:	34f70c63          	beq	a4,a5,80001958 <interruptHandler+0x3d8>
        plic_complete(code);


    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        kPutc('c');
    80001604:	06300513          	li	a0,99
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	f30080e7          	jalr	-208(ra) # 80001538 <_Z5kPutcc>
    80001610:	0840006f          	j	80001694 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001614:	fd043783          	ld	a5,-48(s0)
    80001618:	00478793          	addi	a5,a5,4
    8000161c:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    80001620:	00009797          	auipc	a5,0x9
    80001624:	db87b783          	ld	a5,-584(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001628:	0007b503          	ld	a0,0(a5)
    8000162c:	01853703          	ld	a4,24(a0)
    80001630:	05073783          	ld	a5,80(a4)
    80001634:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    80001638:	fa843783          	ld	a5,-88(s0)
    8000163c:	04300693          	li	a3,67
    80001640:	04f6e263          	bltu	a3,a5,80001684 <interruptHandler+0x104>
    80001644:	00279793          	slli	a5,a5,0x2
    80001648:	00007697          	auipc	a3,0x7
    8000164c:	9d868693          	addi	a3,a3,-1576 # 80008020 <CONSOLE_STATUS+0x10>
    80001650:	00d787b3          	add	a5,a5,a3
    80001654:	0007a783          	lw	a5,0(a5)
    80001658:	00d787b3          	add	a5,a5,a3
    8000165c:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001660:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001664:	00651513          	slli	a0,a0,0x6
    80001668:	00003097          	auipc	ra,0x3
    8000166c:	f94080e7          	jalr	-108(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
    80001670:	00009797          	auipc	a5,0x9
    80001674:	d687b783          	ld	a5,-664(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001678:	0007b783          	ld	a5,0(a5)
    8000167c:	0187b783          	ld	a5,24(a5)
    80001680:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001684:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001688:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    8000168c:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001690:	10079073          	csrw	sstatus,a5
    }

}
    80001694:	05813083          	ld	ra,88(sp)
    80001698:	05013403          	ld	s0,80(sp)
    8000169c:	04813483          	ld	s1,72(sp)
    800016a0:	06010113          	addi	sp,sp,96
    800016a4:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    800016a8:	05873503          	ld	a0,88(a4)
    800016ac:	00003097          	auipc	ra,0x3
    800016b0:	0e4080e7          	jalr	228(ra) # 80004790 <_ZN15MemoryAllocator8mem_freeEPv>
    800016b4:	00009797          	auipc	a5,0x9
    800016b8:	d247b783          	ld	a5,-732(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016bc:	0007b783          	ld	a5,0(a5)
    800016c0:	0187b783          	ld	a5,24(a5)
    800016c4:	04a7b823          	sd	a0,80(a5)
                break;
    800016c8:	fbdff06f          	j	80001684 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    800016cc:	00009797          	auipc	a5,0x9
    800016d0:	cec7b783          	ld	a5,-788(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016d4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	480080e7          	jalr	1152(ra) # 80001b58 <_ZN3PCB8dispatchEv>
                break;
    800016e0:	fa5ff06f          	j	80001684 <interruptHandler+0x104>
                PCB::running->finished = true;
    800016e4:	00100793          	li	a5,1
    800016e8:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    800016ec:	00009797          	auipc	a5,0x9
    800016f0:	ccc7b783          	ld	a5,-820(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800016f4:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800016f8:	00000097          	auipc	ra,0x0
    800016fc:	460080e7          	jalr	1120(ra) # 80001b58 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    80001700:	00009797          	auipc	a5,0x9
    80001704:	cd87b783          	ld	a5,-808(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001708:	0007b783          	ld	a5,0(a5)
    8000170c:	0187b783          	ld	a5,24(a5)
    80001710:	0407b823          	sd	zero,80(a5)
                break;
    80001714:	f71ff06f          	j	80001684 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    80001718:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    8000171c:	0007b503          	ld	a0,0(a5)
    80001720:	00001097          	auipc	ra,0x1
    80001724:	74c080e7          	jalr	1868(ra) # 80002e6c <_ZN9Scheduler3putEP3PCB>
                break;
    80001728:	f5dff06f          	j	80001684 <interruptHandler+0x104>
                PCB::processMain main = (PCB::processMain)PCB::running->registers[12];
    8000172c:	06073503          	ld	a0,96(a4)
                void *arg = (void*)PCB::running->registers[13];
    80001730:	06873583          	ld	a1,104(a4)
                PCB **handle = (PCB**)PCB::running->registers[11];
    80001734:	05873483          	ld	s1,88(a4)
                if(scause == 9) { // sistemski rezim
    80001738:	fd843703          	ld	a4,-40(s0)
    8000173c:	00900793          	li	a5,9
    80001740:	04f70863          	beq	a4,a5,80001790 <interruptHandler+0x210>
                    *handle = PCB::createProccess(main, arg);
    80001744:	00000097          	auipc	ra,0x0
    80001748:	640080e7          	jalr	1600(ra) # 80001d84 <_ZN3PCB14createProccessEPFvvEPv>
    8000174c:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001750:	00009797          	auipc	a5,0x9
    80001754:	c887b783          	ld	a5,-888(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001758:	0007b783          	ld	a5,0(a5)
    8000175c:	0187b703          	ld	a4,24(a5)
    80001760:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001764:	0004b703          	ld	a4,0(s1)
    80001768:	f0070ee3          	beqz	a4,80001684 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    8000176c:	0187b783          	ld	a5,24(a5)
    80001770:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001774:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001778:	00008737          	lui	a4,0x8
    8000177c:	00e787b3          	add	a5,a5,a4
    80001780:	0004b703          	ld	a4,0(s1)
    80001784:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001788:	00f73823          	sd	a5,16(a4)
                break;
    8000178c:	ef9ff06f          	j	80001684 <interruptHandler+0x104>
                    *handle = PCB::createSysProcess(main, arg);
    80001790:	00000097          	auipc	ra,0x0
    80001794:	6e8080e7          	jalr	1768(ra) # 80001e78 <_ZN3PCB16createSysProcessEPFvvEPv>
    80001798:	00a4b023          	sd	a0,0(s1)
    8000179c:	fb5ff06f          	j	80001750 <interruptHandler+0x1d0>
                SCB **handle = (SCB**) PCB::running->registers[11];
    800017a0:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    800017a4:	06072503          	lw	a0,96(a4)
                if(scause == 9) { // sistemski rezim
    800017a8:	fd843703          	ld	a4,-40(s0)
    800017ac:	00900793          	li	a5,9
    800017b0:	02f70463          	beq	a4,a5,800017d8 <interruptHandler+0x258>
                    (*handle) = SCB::createSemaphore(init);
    800017b4:	00002097          	auipc	ra,0x2
    800017b8:	26c080e7          	jalr	620(ra) # 80003a20 <_ZN3SCB15createSemaphoreEi>
    800017bc:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800017c0:	00009797          	auipc	a5,0x9
    800017c4:	c187b783          	ld	a5,-1000(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017c8:	0007b783          	ld	a5,0(a5)
    800017cc:	0187b783          	ld	a5,24(a5)
    800017d0:	0497b823          	sd	s1,80(a5)
                break;
    800017d4:	eb1ff06f          	j	80001684 <interruptHandler+0x104>
                    (*handle) = SCB::createSysSemaphore(init);
    800017d8:	00002097          	auipc	ra,0x2
    800017dc:	300080e7          	jalr	768(ra) # 80003ad8 <_ZN3SCB18createSysSemaphoreEi>
    800017e0:	00a4b023          	sd	a0,0(s1)
    800017e4:	fddff06f          	j	800017c0 <interruptHandler+0x240>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    800017e8:	05873503          	ld	a0,88(a4)
    800017ec:	00002097          	auipc	ra,0x2
    800017f0:	05c080e7          	jalr	92(ra) # 80003848 <_ZN3SCB4waitEv>
    800017f4:	00009797          	auipc	a5,0x9
    800017f8:	be47b783          	ld	a5,-1052(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800017fc:	0007b783          	ld	a5,0(a5)
    80001800:	0187b783          	ld	a5,24(a5)
    80001804:	04a7b823          	sd	a0,80(a5)
                break;
    80001808:	e7dff06f          	j	80001684 <interruptHandler+0x104>
                sem->signal();
    8000180c:	05873503          	ld	a0,88(a4)
    80001810:	00002097          	auipc	ra,0x2
    80001814:	0cc080e7          	jalr	204(ra) # 800038dc <_ZN3SCB6signalEv>
                break;
    80001818:	e6dff06f          	j	80001684 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    8000181c:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    80001820:	00048513          	mv	a0,s1
    80001824:	00002097          	auipc	ra,0x2
    80001828:	198080e7          	jalr	408(ra) # 800039bc <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    8000182c:	e4048ce3          	beqz	s1,80001684 <interruptHandler+0x104>
    80001830:	00048513          	mv	a0,s1
    80001834:	00002097          	auipc	ra,0x2
    80001838:	160080e7          	jalr	352(ra) # 80003994 <_ZN3SCBdlEPv>
    8000183c:	e49ff06f          	j	80001684 <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    80001840:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    80001844:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	124080e7          	jalr	292(ra) # 8000196c <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    80001850:	e35ff06f          	j	80001684 <interruptHandler+0x104>
                CCB::outputBuffer.pushBack(character);
    80001854:	05874583          	lbu	a1,88(a4)
    80001858:	00009517          	auipc	a0,0x9
    8000185c:	b4853503          	ld	a0,-1208(a0) # 8000a3a0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001860:	00001097          	auipc	ra,0x1
    80001864:	ba0080e7          	jalr	-1120(ra) # 80002400 <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    80001868:	00009797          	auipc	a5,0x9
    8000186c:	b807b783          	ld	a5,-1152(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001870:	0007b503          	ld	a0,0(a5)
    80001874:	00002097          	auipc	ra,0x2
    80001878:	068080e7          	jalr	104(ra) # 800038dc <_ZN3SCB6signalEv>
                break;
    8000187c:	e09ff06f          	j	80001684 <interruptHandler+0x104>
                CCB::semInput->signal();
    80001880:	00009797          	auipc	a5,0x9
    80001884:	b807b783          	ld	a5,-1152(a5) # 8000a400 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001888:	0007b503          	ld	a0,0(a5)
    8000188c:	00002097          	auipc	ra,0x2
    80001890:	050080e7          	jalr	80(ra) # 800038dc <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001894:	00009517          	auipc	a0,0x9
    80001898:	b1453503          	ld	a0,-1260(a0) # 8000a3a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000189c:	00001097          	auipc	ra,0x1
    800018a0:	d14080e7          	jalr	-748(ra) # 800025b0 <_ZN8IOBuffer9peekFrontEv>
    800018a4:	00051e63          	bnez	a0,800018c0 <interruptHandler+0x340>
                    CCB::inputBufferEmpty->wait();
    800018a8:	00009797          	auipc	a5,0x9
    800018ac:	b487b783          	ld	a5,-1208(a5) # 8000a3f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800018b0:	0007b503          	ld	a0,0(a5)
    800018b4:	00002097          	auipc	ra,0x2
    800018b8:	f94080e7          	jalr	-108(ra) # 80003848 <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    800018bc:	fd9ff06f          	j	80001894 <interruptHandler+0x314>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    800018c0:	00009517          	auipc	a0,0x9
    800018c4:	ae853503          	ld	a0,-1304(a0) # 8000a3a8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800018c8:	00001097          	auipc	ra,0x1
    800018cc:	c50080e7          	jalr	-944(ra) # 80002518 <_ZN8IOBuffer8popFrontEv>
    800018d0:	00009797          	auipc	a5,0x9
    800018d4:	b087b783          	ld	a5,-1272(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018d8:	0007b783          	ld	a5,0(a5)
    800018dc:	0187b783          	ld	a5,24(a5)
    800018e0:	04a7b823          	sd	a0,80(a5)
                break;
    800018e4:	da1ff06f          	j	80001684 <interruptHandler+0x104>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    800018e8:	fc843783          	ld	a5,-56(s0)
    800018ec:	eff7f793          	andi	a5,a5,-257
    800018f0:	fcf43423          	sd	a5,-56(s0)
                break;
    800018f4:	d91ff06f          	j	80001684 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800018f8:	00009497          	auipc	s1,0x9
    800018fc:	ac04b483          	ld	s1,-1344(s1) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001900:	0004b783          	ld	a5,0(s1)
    80001904:	00178793          	addi	a5,a5,1
    80001908:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	0f0080e7          	jalr	240(ra) # 800019fc <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001914:	00009797          	auipc	a5,0x9
    80001918:	ac47b783          	ld	a5,-1340(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000191c:	0007b783          	ld	a5,0(a5)
    80001920:	0407b703          	ld	a4,64(a5)
    80001924:	0004b783          	ld	a5,0(s1)
    80001928:	00e7f863          	bgeu	a5,a4,80001938 <interruptHandler+0x3b8>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000192c:	00200793          	li	a5,2
    80001930:	1447b073          	csrc	sip,a5
    }
    80001934:	d61ff06f          	j	80001694 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    80001938:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    8000193c:	00000097          	auipc	ra,0x0
    80001940:	21c080e7          	jalr	540(ra) # 80001b58 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    80001944:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001948:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    8000194c:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001950:	10079073          	csrw	sstatus,a5
    }
    80001954:	fd9ff06f          	j	8000192c <interruptHandler+0x3ac>
        size_t code = plic_claim();
    80001958:	00004097          	auipc	ra,0x4
    8000195c:	12c080e7          	jalr	300(ra) # 80005a84 <plic_claim>
        plic_complete(code);
    80001960:	00004097          	auipc	ra,0x4
    80001964:	15c080e7          	jalr	348(ra) # 80005abc <plic_complete>
    80001968:	d2dff06f          	j	80001694 <interruptHandler+0x114>

000000008000196c <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    8000196c:	ff010113          	addi	sp,sp,-16
    80001970:	00813423          	sd	s0,8(sp)
    80001974:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001978:	00009797          	auipc	a5,0x9
    8000197c:	ae87b783          	ld	a5,-1304(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001980:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    80001984:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    80001988:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    8000198c:	00078e63          	beqz	a5,800019a8 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    80001990:	0307b683          	ld	a3,48(a5)
    80001994:	00e6fa63          	bgeu	a3,a4,800019a8 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    80001998:	40d70733          	sub	a4,a4,a3
        prev = curr;
    8000199c:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    800019a0:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    800019a4:	fe9ff06f          	j	8000198c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    800019a8:	00100693          	li	a3,1
    800019ac:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    800019b0:	02060663          	beqz	a2,800019dc <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    800019b4:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    800019b8:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    800019bc:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    800019c0:	00078863          	beqz	a5,800019d0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019c4:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019c8:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    800019cc:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    800019d0:	00813403          	ld	s0,8(sp)
    800019d4:	01010113          	addi	sp,sp,16
    800019d8:	00008067          	ret
        head = process;
    800019dc:	00009717          	auipc	a4,0x9
    800019e0:	a8a73223          	sd	a0,-1404(a4) # 8000a460 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    800019e4:	00f53023          	sd	a5,0(a0)
        if(curr) {
    800019e8:	fe0784e3          	beqz	a5,800019d0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    800019ec:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    800019f0:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    800019f4:	02b7b823          	sd	a1,48(a5)
    }
    800019f8:	fd9ff06f          	j	800019d0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

00000000800019fc <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    800019fc:	00009517          	auipc	a0,0x9
    80001a00:	a6453503          	ld	a0,-1436(a0) # 8000a460 <_ZN17SleepingProcesses4headE>
    80001a04:	08050063          	beqz	a0,80001a84 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    80001a08:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    80001a0c:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    80001a10:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    80001a14:	06050263          	beqz	a0,80001a78 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    80001a18:	03053783          	ld	a5,48(a0)
    80001a1c:	04079e63          	bnez	a5,80001a78 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    80001a20:	fe010113          	addi	sp,sp,-32
    80001a24:	00113c23          	sd	ra,24(sp)
    80001a28:	00813823          	sd	s0,16(sp)
    80001a2c:	00913423          	sd	s1,8(sp)
    80001a30:	02010413          	addi	s0,sp,32
    80001a34:	00c0006f          	j	80001a40 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    80001a38:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    80001a3c:	02079063          	bnez	a5,80001a5c <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    80001a40:	00053483          	ld	s1,0(a0)
        nextInList = next;
    80001a44:	00053023          	sd	zero,0(a0)
        blocked = newState;
    80001a48:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    80001a4c:	00001097          	auipc	ra,0x1
    80001a50:	420080e7          	jalr	1056(ra) # 80002e6c <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80001a54:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    80001a58:	fe0490e3          	bnez	s1,80001a38 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    80001a5c:	00009797          	auipc	a5,0x9
    80001a60:	a0a7b223          	sd	a0,-1532(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
}
    80001a64:	01813083          	ld	ra,24(sp)
    80001a68:	01013403          	ld	s0,16(sp)
    80001a6c:	00813483          	ld	s1,8(sp)
    80001a70:	02010113          	addi	sp,sp,32
    80001a74:	00008067          	ret
    head = curr;
    80001a78:	00009797          	auipc	a5,0x9
    80001a7c:	9ea7b423          	sd	a0,-1560(a5) # 8000a460 <_ZN17SleepingProcesses4headE>
    80001a80:	00008067          	ret
    80001a84:	00008067          	ret

0000000080001a88 <_ZN3PCB12createObjectEPv>:
#include "../h/slab.h"

PCB* PCB::running = nullptr;
size_t PCB::timeSliceCounter = 0;

void PCB::createObject(void* addr) {
    80001a88:	ff010113          	addi	sp,sp,-16
    80001a8c:	00813423          	sd	s0,8(sp)
    80001a90:	01010413          	addi	s0,sp,16
}
    80001a94:	00813403          	ld	s0,8(sp)
    80001a98:	01010113          	addi	sp,sp,16
    80001a9c:	00008067          	ret

0000000080001aa0 <_ZN3PCB10freeObjectEPv>:

void PCB::freeObject(void* addr) {
    80001aa0:	fe010113          	addi	sp,sp,-32
    80001aa4:	00113c23          	sd	ra,24(sp)
    80001aa8:	00813823          	sd	s0,16(sp)
    80001aac:	00913423          	sd	s1,8(sp)
    80001ab0:	02010413          	addi	s0,sp,32
    80001ab4:	00050493          	mv	s1,a0
    PCB* object = (PCB*)addr;
    delete[] object->stack;
    80001ab8:	00853503          	ld	a0,8(a0)
    80001abc:	00050663          	beqz	a0,80001ac8 <_ZN3PCB10freeObjectEPv+0x28>
    80001ac0:	00001097          	auipc	ra,0x1
    80001ac4:	7d8080e7          	jalr	2008(ra) # 80003298 <_ZdaPv>
    delete[] object->sysStack;
    80001ac8:	0104b503          	ld	a0,16(s1)
    80001acc:	00050663          	beqz	a0,80001ad8 <_ZN3PCB10freeObjectEPv+0x38>
    80001ad0:	00001097          	auipc	ra,0x1
    80001ad4:	7c8080e7          	jalr	1992(ra) # 80003298 <_ZdaPv>
}
    80001ad8:	01813083          	ld	ra,24(sp)
    80001adc:	01013403          	ld	s0,16(sp)
    80001ae0:	00813483          	ld	s1,8(sp)
    80001ae4:	02010113          	addi	sp,sp,32
    80001ae8:	00008067          	ret

0000000080001aec <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001aec:	ff010113          	addi	sp,sp,-16
    80001af0:	00113423          	sd	ra,8(sp)
    80001af4:	00813023          	sd	s0,0(sp)
    80001af8:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001afc:	00000097          	auipc	ra,0x0
    80001b00:	a1c080e7          	jalr	-1508(ra) # 80001518 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001b04:	00009797          	auipc	a5,0x9
    80001b08:	9647b783          	ld	a5,-1692(a5) # 8000a468 <_ZN3PCB7runningE>
    80001b0c:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001b10:	00070513          	mv	a0,a4
    running->main();
    80001b14:	0207b783          	ld	a5,32(a5)
    80001b18:	000780e7          	jalr	a5
    thread_exit();
    80001b1c:	fffff097          	auipc	ra,0xfffff
    80001b20:	794080e7          	jalr	1940(ra) # 800012b0 <_Z11thread_exitv>
}
    80001b24:	00813083          	ld	ra,8(sp)
    80001b28:	00013403          	ld	s0,0(sp)
    80001b2c:	01010113          	addi	sp,sp,16
    80001b30:	00008067          	ret

0000000080001b34 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001b34:	ff010113          	addi	sp,sp,-16
    80001b38:	00813423          	sd	s0,8(sp)
    80001b3c:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001b40:	01300793          	li	a5,19
    80001b44:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001b48:	00000073          	ecall
}
    80001b4c:	00813403          	ld	s0,8(sp)
    80001b50:	01010113          	addi	sp,sp,16
    80001b54:	00008067          	ret

0000000080001b58 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001b58:	fe010113          	addi	sp,sp,-32
    80001b5c:	00113c23          	sd	ra,24(sp)
    80001b60:	00813823          	sd	s0,16(sp)
    80001b64:	00913423          	sd	s1,8(sp)
    80001b68:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001b6c:	00009497          	auipc	s1,0x9
    80001b70:	8fc4b483          	ld	s1,-1796(s1) # 8000a468 <_ZN3PCB7runningE>
        return finished;
    80001b74:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001b78:	00079663          	bnez	a5,80001b84 <_ZN3PCB8dispatchEv+0x2c>
    80001b7c:	0294c783          	lbu	a5,41(s1)
    80001b80:	04078263          	beqz	a5,80001bc4 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001b84:	00001097          	auipc	ra,0x1
    80001b88:	340080e7          	jalr	832(ra) # 80002ec4 <_ZN9Scheduler3getEv>
    80001b8c:	00009797          	auipc	a5,0x9
    80001b90:	8ca7be23          	sd	a0,-1828(a5) # 8000a468 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001b94:	04854783          	lbu	a5,72(a0)
    80001b98:	02078e63          	beqz	a5,80001bd4 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001b9c:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001ba0:	01853583          	ld	a1,24(a0)
    80001ba4:	0184b503          	ld	a0,24(s1)
    80001ba8:	fffff097          	auipc	ra,0xfffff
    80001bac:	580080e7          	jalr	1408(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001bb0:	01813083          	ld	ra,24(sp)
    80001bb4:	01013403          	ld	s0,16(sp)
    80001bb8:	00813483          	ld	s1,8(sp)
    80001bbc:	02010113          	addi	sp,sp,32
    80001bc0:	00008067          	ret
        Scheduler::put(old);
    80001bc4:	00048513          	mv	a0,s1
    80001bc8:	00001097          	auipc	ra,0x1
    80001bcc:	2a4080e7          	jalr	676(ra) # 80002e6c <_ZN9Scheduler3putEP3PCB>
    80001bd0:	fb5ff06f          	j	80001b84 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001bd4:	01853583          	ld	a1,24(a0)
    80001bd8:	0184b503          	ld	a0,24(s1)
    80001bdc:	fffff097          	auipc	ra,0xfffff
    80001be0:	560080e7          	jalr	1376(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001be4:	fcdff06f          	j	80001bb0 <_ZN3PCB8dispatchEv+0x58>

0000000080001be8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001be8:	fe010113          	addi	sp,sp,-32
    80001bec:	00113c23          	sd	ra,24(sp)
    80001bf0:	00813823          	sd	s0,16(sp)
    80001bf4:	00913423          	sd	s1,8(sp)
    80001bf8:	02010413          	addi	s0,sp,32
    80001bfc:	00050493          	mv	s1,a0
    delete[] stack;
    80001c00:	00853503          	ld	a0,8(a0)
    80001c04:	00050663          	beqz	a0,80001c10 <_ZN3PCBD1Ev+0x28>
    80001c08:	00001097          	auipc	ra,0x1
    80001c0c:	690080e7          	jalr	1680(ra) # 80003298 <_ZdaPv>
    delete[] sysStack;
    80001c10:	0104b503          	ld	a0,16(s1)
    80001c14:	00050663          	beqz	a0,80001c20 <_ZN3PCBD1Ev+0x38>
    80001c18:	00001097          	auipc	ra,0x1
    80001c1c:	680080e7          	jalr	1664(ra) # 80003298 <_ZdaPv>
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
    80001c44:	00003097          	auipc	ra,0x3
    80001c48:	9b8080e7          	jalr	-1608(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
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
    80001c6c:	00003097          	auipc	ra,0x3
    80001c70:	b24080e7          	jalr	-1244(ra) # 80004790 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c74:	00813083          	ld	ra,8(sp)
    80001c78:	00013403          	ld	s0,0(sp)
    80001c7c:	01010113          	addi	sp,sp,16
    80001c80:	00008067          	ret

0000000080001c84 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001c84:	ff010113          	addi	sp,sp,-16
    80001c88:	00813423          	sd	s0,8(sp)
    80001c8c:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001c90:	00008797          	auipc	a5,0x8
    80001c94:	7d87b783          	ld	a5,2008(a5) # 8000a468 <_ZN3PCB7runningE>
    80001c98:	0187b503          	ld	a0,24(a5)
    80001c9c:	00813403          	ld	s0,8(sp)
    80001ca0:	01010113          	addi	sp,sp,16
    80001ca4:	00008067          	ret

0000000080001ca8 <_ZN3PCB10initObjectEPFvvEmPv>:

void PCB::initObject(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001ca8:	fe010113          	addi	sp,sp,-32
    80001cac:	00113c23          	sd	ra,24(sp)
    80001cb0:	00813823          	sd	s0,16(sp)
    80001cb4:	00913423          	sd	s1,8(sp)
    80001cb8:	02010413          	addi	s0,sp,32
    80001cbc:	00050493          	mv	s1,a0
    firstCall = true;
    80001cc0:	00100793          	li	a5,1
    80001cc4:	04f50423          	sb	a5,72(a0)
    registers = nullptr;
    80001cc8:	00053c23          	sd	zero,24(a0)
    nextInList = nullptr;
    80001ccc:	00053023          	sd	zero,0(a0)
    timeSleeping = 0;
    80001cd0:	02053823          	sd	zero,48(a0)
    finished = blocked = semDeleted = false;
    80001cd4:	02050523          	sb	zero,42(a0)
    80001cd8:	020504a3          	sb	zero,41(a0)
    80001cdc:	02050423          	sb	zero,40(a0)
    main = main_;
    80001ce0:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001ce4:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001ce8:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001cec:	10800513          	li	a0,264
    80001cf0:	00003097          	auipc	ra,0x3
    80001cf4:	90c080e7          	jalr	-1780(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
    80001cf8:	00a4bc23          	sd	a0,24(s1)
    if(!registers) return; // greska
    80001cfc:	04050263          	beqz	a0,80001d40 <_ZN3PCB10initObjectEPFvvEmPv+0x98>
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001d00:	00008537          	lui	a0,0x8
    80001d04:	00003097          	auipc	ra,0x3
    80001d08:	8f8080e7          	jalr	-1800(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
    80001d0c:	00a4b823          	sd	a0,16(s1)
    if(!sysStack) return; // greska
    80001d10:	02050863          	beqz	a0,80001d40 <_ZN3PCB10initObjectEPFvvEmPv+0x98>
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001d14:	000087b7          	lui	a5,0x8
    80001d18:	00f50533          	add	a0,a0,a5
    80001d1c:	0184b783          	ld	a5,24(s1)
    80001d20:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001d24:	0184b783          	ld	a5,24(s1)
    80001d28:	00000717          	auipc	a4,0x0
    80001d2c:	dc470713          	addi	a4,a4,-572 # 80001aec <_ZN3PCB15proccessWrapperEv>
    80001d30:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001d34:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001d38:	0204b783          	ld	a5,32(s1)
    80001d3c:	00078c63          	beqz	a5,80001d54 <_ZN3PCB10initObjectEPFvvEmPv+0xac>
}
    80001d40:	01813083          	ld	ra,24(sp)
    80001d44:	01013403          	ld	s0,16(sp)
    80001d48:	00813483          	ld	s1,8(sp)
    80001d4c:	02010113          	addi	sp,sp,32
    80001d50:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001d54:	04048423          	sb	zero,72(s1)
    80001d58:	fe9ff06f          	j	80001d40 <_ZN3PCB10initObjectEPFvvEmPv+0x98>

0000000080001d5c <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001d5c:	ff010113          	addi	sp,sp,-16
    80001d60:	00113423          	sd	ra,8(sp)
    80001d64:	00813023          	sd	s0,0(sp)
    80001d68:	01010413          	addi	s0,sp,16
    initObject(main_, timeSlice_, mainArguments_);
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	f3c080e7          	jalr	-196(ra) # 80001ca8 <_ZN3PCB10initObjectEPFvvEmPv>
}
    80001d74:	00813083          	ld	ra,8(sp)
    80001d78:	00013403          	ld	s0,0(sp)
    80001d7c:	01010113          	addi	sp,sp,16
    80001d80:	00008067          	ret

0000000080001d84 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001d84:	fd010113          	addi	sp,sp,-48
    80001d88:	02113423          	sd	ra,40(sp)
    80001d8c:	02813023          	sd	s0,32(sp)
    80001d90:	00913c23          	sd	s1,24(sp)
    80001d94:	01213823          	sd	s2,16(sp)
    80001d98:	01313423          	sd	s3,8(sp)
    80001d9c:	03010413          	addi	s0,sp,48
    80001da0:	00050913          	mv	s2,a0
    80001da4:	00058993          	mv	s3,a1
    PCB* object = new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001da8:	05000513          	li	a0,80
    80001dac:	00000097          	auipc	ra,0x0
    80001db0:	e88080e7          	jalr	-376(ra) # 80001c34 <_ZN3PCBnwEm>
    80001db4:	00050493          	mv	s1,a0
    80001db8:	00050c63          	beqz	a0,80001dd0 <_ZN3PCB14createProccessEPFvvEPv+0x4c>
    80001dbc:	00098693          	mv	a3,s3
    80001dc0:	00200613          	li	a2,2
    80001dc4:	00090593          	mv	a1,s2
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	f94080e7          	jalr	-108(ra) # 80001d5c <_ZN3PCBC1EPFvvEmPv>
    if(!object->registers || !object->sysStack) return nullptr;
    80001dd0:	0184b783          	ld	a5,24(s1)
    80001dd4:	02078663          	beqz	a5,80001e00 <_ZN3PCB14createProccessEPFvvEPv+0x7c>
    80001dd8:	0104b783          	ld	a5,16(s1)
    80001ddc:	02078663          	beqz	a5,80001e08 <_ZN3PCB14createProccessEPFvvEPv+0x84>
}
    80001de0:	00048513          	mv	a0,s1
    80001de4:	02813083          	ld	ra,40(sp)
    80001de8:	02013403          	ld	s0,32(sp)
    80001dec:	01813483          	ld	s1,24(sp)
    80001df0:	01013903          	ld	s2,16(sp)
    80001df4:	00813983          	ld	s3,8(sp)
    80001df8:	03010113          	addi	sp,sp,48
    80001dfc:	00008067          	ret
    if(!object->registers || !object->sysStack) return nullptr;
    80001e00:	00000493          	li	s1,0
    80001e04:	fddff06f          	j	80001de0 <_ZN3PCB14createProccessEPFvvEPv+0x5c>
    80001e08:	00000493          	li	s1,0
    80001e0c:	fd5ff06f          	j	80001de0 <_ZN3PCB14createProccessEPFvvEPv+0x5c>
    80001e10:	00050913          	mv	s2,a0
    PCB* object = new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001e14:	00048513          	mv	a0,s1
    80001e18:	00000097          	auipc	ra,0x0
    80001e1c:	e44080e7          	jalr	-444(ra) # 80001c5c <_ZN3PCBdlEPv>
    80001e20:	00090513          	mv	a0,s2
    80001e24:	0000a097          	auipc	ra,0xa
    80001e28:	854080e7          	jalr	-1964(ra) # 8000b678 <_Unwind_Resume>

0000000080001e2c <_ZN3PCB12initPCBCacheEv>:

void PCB::initPCBCache() {
    80001e2c:	ff010113          	addi	sp,sp,-16
    80001e30:	00113423          	sd	ra,8(sp)
    80001e34:	00813023          	sd	s0,0(sp)
    80001e38:	01010413          	addi	s0,sp,16
    pcbCache = (kmem_cache_t*)kmem_cache_create("PCB", sizeof(PCB), &createObject, &freeObject);
    80001e3c:	00000697          	auipc	a3,0x0
    80001e40:	c6468693          	addi	a3,a3,-924 # 80001aa0 <_ZN3PCB10freeObjectEPv>
    80001e44:	00000617          	auipc	a2,0x0
    80001e48:	c4460613          	addi	a2,a2,-956 # 80001a88 <_ZN3PCB12createObjectEPv>
    80001e4c:	05000593          	li	a1,80
    80001e50:	00006517          	auipc	a0,0x6
    80001e54:	2e050513          	addi	a0,a0,736 # 80008130 <CONSOLE_STATUS+0x120>
    80001e58:	00003097          	auipc	ra,0x3
    80001e5c:	b3c080e7          	jalr	-1220(ra) # 80004994 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80001e60:	00008797          	auipc	a5,0x8
    80001e64:	60a7b823          	sd	a0,1552(a5) # 8000a470 <_ZN3PCB8pcbCacheE>
}
    80001e68:	00813083          	ld	ra,8(sp)
    80001e6c:	00013403          	ld	s0,0(sp)
    80001e70:	01010113          	addi	sp,sp,16
    80001e74:	00008067          	ret

0000000080001e78 <_ZN3PCB16createSysProcessEPFvvEPv>:
PCB *PCB::createSysProcess(PCB::processMain main, void* arguments) {
    80001e78:	fd010113          	addi	sp,sp,-48
    80001e7c:	02113423          	sd	ra,40(sp)
    80001e80:	02813023          	sd	s0,32(sp)
    80001e84:	00913c23          	sd	s1,24(sp)
    80001e88:	01213823          	sd	s2,16(sp)
    80001e8c:	01313423          	sd	s3,8(sp)
    80001e90:	03010413          	addi	s0,sp,48
    80001e94:	00050913          	mv	s2,a0
    80001e98:	00058993          	mv	s3,a1
    if(!pcbCache) initPCBCache();
    80001e9c:	00008797          	auipc	a5,0x8
    80001ea0:	5d47b783          	ld	a5,1492(a5) # 8000a470 <_ZN3PCB8pcbCacheE>
    80001ea4:	04078e63          	beqz	a5,80001f00 <_ZN3PCB16createSysProcessEPFvvEPv+0x88>
    PCB* object = (PCB*) kmem_cache_alloc(pcbCache);
    80001ea8:	00008517          	auipc	a0,0x8
    80001eac:	5c853503          	ld	a0,1480(a0) # 8000a470 <_ZN3PCB8pcbCacheE>
    80001eb0:	00003097          	auipc	ra,0x3
    80001eb4:	b34080e7          	jalr	-1228(ra) # 800049e4 <_Z16kmem_cache_allocP12kmem_cache_s>
    80001eb8:	00050493          	mv	s1,a0
    object->initObject(main, DEFAULT_TIME_SLICE, arguments);
    80001ebc:	00098693          	mv	a3,s3
    80001ec0:	00200613          	li	a2,2
    80001ec4:	00090593          	mv	a1,s2
    80001ec8:	00000097          	auipc	ra,0x0
    80001ecc:	de0080e7          	jalr	-544(ra) # 80001ca8 <_ZN3PCB10initObjectEPFvvEmPv>
    if(!object->registers || !object->sysStack) return nullptr;
    80001ed0:	0184b783          	ld	a5,24(s1)
    80001ed4:	02078c63          	beqz	a5,80001f0c <_ZN3PCB16createSysProcessEPFvvEPv+0x94>
    80001ed8:	0104b783          	ld	a5,16(s1)
    80001edc:	02078c63          	beqz	a5,80001f14 <_ZN3PCB16createSysProcessEPFvvEPv+0x9c>
}
    80001ee0:	00048513          	mv	a0,s1
    80001ee4:	02813083          	ld	ra,40(sp)
    80001ee8:	02013403          	ld	s0,32(sp)
    80001eec:	01813483          	ld	s1,24(sp)
    80001ef0:	01013903          	ld	s2,16(sp)
    80001ef4:	00813983          	ld	s3,8(sp)
    80001ef8:	03010113          	addi	sp,sp,48
    80001efc:	00008067          	ret
    if(!pcbCache) initPCBCache();
    80001f00:	00000097          	auipc	ra,0x0
    80001f04:	f2c080e7          	jalr	-212(ra) # 80001e2c <_ZN3PCB12initPCBCacheEv>
    80001f08:	fa1ff06f          	j	80001ea8 <_ZN3PCB16createSysProcessEPFvvEPv+0x30>
    if(!object->registers || !object->sysStack) return nullptr;
    80001f0c:	00000493          	li	s1,0
    80001f10:	fd1ff06f          	j	80001ee0 <_ZN3PCB16createSysProcessEPFvvEPv+0x68>
    80001f14:	00000493          	li	s1,0
    80001f18:	fc9ff06f          	j	80001ee0 <_ZN3PCB16createSysProcessEPFvvEPv+0x68>

0000000080001f1c <_ZN14BuddyAllocator12getFreeBlockEm>:
    }

    return 0;
}

BuddyAllocator::BuddyEntry *BuddyAllocator::getFreeBlock(size_t size) {
    80001f1c:	ff010113          	addi	sp,sp,-16
    80001f20:	00813423          	sd	s0,8(sp)
    80001f24:	01010413          	addi	s0,sp,16
    size--;
    80001f28:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f2c:	00b00793          	li	a5,11
    80001f30:	02a7e463          	bltu	a5,a0,80001f58 <_ZN14BuddyAllocator12getFreeBlockEm+0x3c>
    80001f34:	00351513          	slli	a0,a0,0x3
    80001f38:	00008797          	auipc	a5,0x8
    80001f3c:	54878793          	addi	a5,a5,1352 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001f40:	00a78533          	add	a0,a5,a0
    80001f44:	00053503          	ld	a0,0(a0)
    80001f48:	00050c63          	beqz	a0,80001f60 <_ZN14BuddyAllocator12getFreeBlockEm+0x44>

    BuddyEntry* block = buddy[size];
    return block;
}
    80001f4c:	00813403          	ld	s0,8(sp)
    80001f50:	01010113          	addi	sp,sp,16
    80001f54:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f58:	00000513          	li	a0,0
    80001f5c:	ff1ff06f          	j	80001f4c <_ZN14BuddyAllocator12getFreeBlockEm+0x30>
    80001f60:	00000513          	li	a0,0
    80001f64:	fe9ff06f          	j	80001f4c <_ZN14BuddyAllocator12getFreeBlockEm+0x30>

0000000080001f68 <_ZN14BuddyAllocator12popFreeBlockEm>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlock(size_t size) {
    80001f68:	ff010113          	addi	sp,sp,-16
    80001f6c:	00813423          	sd	s0,8(sp)
    80001f70:	01010413          	addi	s0,sp,16
    size--;
    80001f74:	fff50793          	addi	a5,a0,-1
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001f78:	00b00713          	li	a4,11
    80001f7c:	04f76063          	bltu	a4,a5,80001fbc <_ZN14BuddyAllocator12popFreeBlockEm+0x54>
    80001f80:	00379693          	slli	a3,a5,0x3
    80001f84:	00008717          	auipc	a4,0x8
    80001f88:	4fc70713          	addi	a4,a4,1276 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001f8c:	00d70733          	add	a4,a4,a3
    80001f90:	00073503          	ld	a0,0(a4)
    80001f94:	00050e63          	beqz	a0,80001fb0 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

    BuddyEntry* block = buddy[size];
    buddy[size] = buddy[size]->next;
    80001f98:	00053683          	ld	a3,0(a0)
    80001f9c:	00379793          	slli	a5,a5,0x3
    80001fa0:	00008717          	auipc	a4,0x8
    80001fa4:	4e070713          	addi	a4,a4,1248 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001fa8:	00f707b3          	add	a5,a4,a5
    80001fac:	00d7b023          	sd	a3,0(a5)
    return block;
}
    80001fb0:	00813403          	ld	s0,8(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret
    if(size >= maxPowerSize || buddy[size] == nullptr) return nullptr;
    80001fbc:	00000513          	li	a0,0
    80001fc0:	ff1ff06f          	j	80001fb0 <_ZN14BuddyAllocator12popFreeBlockEm+0x48>

0000000080001fc4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::popFreeBlockAddr(size_t size, void* addr) {
    80001fc4:	ff010113          	addi	sp,sp,-16
    80001fc8:	00813423          	sd	s0,8(sp)
    80001fcc:	01010413          	addi	s0,sp,16
    size--;
    80001fd0:	fff50693          	addi	a3,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80001fd4:	00b00793          	li	a5,11
    80001fd8:	06d7e663          	bltu	a5,a3,80002044 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x80>

    BuddyEntry *prev = nullptr;
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001fdc:	00369713          	slli	a4,a3,0x3
    80001fe0:	00008797          	auipc	a5,0x8
    80001fe4:	4a078793          	addi	a5,a5,1184 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80001fe8:	00e787b3          	add	a5,a5,a4
    80001fec:	0007b603          	ld	a2,0(a5)
    80001ff0:	00060513          	mv	a0,a2
    BuddyEntry *prev = nullptr;
    80001ff4:	00000713          	li	a4,0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80001ff8:	02050263          	beqz	a0,8000201c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
        if(curr->addr == addr) {
    80001ffc:	00853783          	ld	a5,8(a0)
    80002000:	00b78863          	beq	a5,a1,80002010 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x4c>
            else {
                buddy[size] = buddy[size]->next;
            }
            return curr;
        }
        prev = curr;
    80002004:	00050713          	mv	a4,a0
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80002008:	00053503          	ld	a0,0(a0)
    8000200c:	fedff06f          	j	80001ff8 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x34>
            if(prev) {
    80002010:	00070c63          	beqz	a4,80002028 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x64>
                prev->next = curr->next;
    80002014:	00053783          	ld	a5,0(a0)
    80002018:	00f73023          	sd	a5,0(a4)
    }

    return nullptr;
}
    8000201c:	00813403          	ld	s0,8(sp)
    80002020:	01010113          	addi	sp,sp,16
    80002024:	00008067          	ret
                buddy[size] = buddy[size]->next;
    80002028:	00063703          	ld	a4,0(a2)
    8000202c:	00369693          	slli	a3,a3,0x3
    80002030:	00008797          	auipc	a5,0x8
    80002034:	45078793          	addi	a5,a5,1104 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80002038:	00d786b3          	add	a3,a5,a3
    8000203c:	00e6b023          	sd	a4,0(a3)
            return curr;
    80002040:	fddff06f          	j	8000201c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>
    if(size >= maxPowerSize) return nullptr;
    80002044:	00000513          	li	a0,0
    80002048:	fd5ff06f          	j	8000201c <_ZN14BuddyAllocator16popFreeBlockAddrEmPv+0x58>

000000008000204c <_ZN14BuddyAllocator10printBuddyEv>:

void BuddyAllocator::printBuddy() {
    8000204c:	fe010113          	addi	sp,sp,-32
    80002050:	00113c23          	sd	ra,24(sp)
    80002054:	00813823          	sd	s0,16(sp)
    80002058:	00913423          	sd	s1,8(sp)
    8000205c:	01213023          	sd	s2,0(sp)
    80002060:	02010413          	addi	s0,sp,32
    for(size_t i = 0; i < maxPowerSize; i++) {
    80002064:	00000913          	li	s2,0
    80002068:	0180006f          	j	80002080 <_ZN14BuddyAllocator10printBuddyEv+0x34>
        printString(": ");
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
            printInt((size_t)curr->addr);
            printString(" ");
        }
        printString("\n");
    8000206c:	00006517          	auipc	a0,0x6
    80002070:	1f450513          	addi	a0,a0,500 # 80008260 <CONSOLE_STATUS+0x250>
    80002074:	00000097          	auipc	ra,0x0
    80002078:	7ec080e7          	jalr	2028(ra) # 80002860 <_Z11printStringPKc>
    for(size_t i = 0; i < maxPowerSize; i++) {
    8000207c:	00190913          	addi	s2,s2,1
    80002080:	00b00793          	li	a5,11
    80002084:	0727e663          	bltu	a5,s2,800020f0 <_ZN14BuddyAllocator10printBuddyEv+0xa4>
        printInt(i+1);
    80002088:	00000613          	li	a2,0
    8000208c:	00a00593          	li	a1,10
    80002090:	0019051b          	addiw	a0,s2,1
    80002094:	00001097          	auipc	ra,0x1
    80002098:	964080e7          	jalr	-1692(ra) # 800029f8 <_Z8printIntiii>
        printString(": ");
    8000209c:	00006517          	auipc	a0,0x6
    800020a0:	09c50513          	addi	a0,a0,156 # 80008138 <CONSOLE_STATUS+0x128>
    800020a4:	00000097          	auipc	ra,0x0
    800020a8:	7bc080e7          	jalr	1980(ra) # 80002860 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    800020ac:	00391713          	slli	a4,s2,0x3
    800020b0:	00008797          	auipc	a5,0x8
    800020b4:	3d078793          	addi	a5,a5,976 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    800020b8:	00e787b3          	add	a5,a5,a4
    800020bc:	0007b483          	ld	s1,0(a5)
    800020c0:	fa0486e3          	beqz	s1,8000206c <_ZN14BuddyAllocator10printBuddyEv+0x20>
            printInt((size_t)curr->addr);
    800020c4:	00000613          	li	a2,0
    800020c8:	00a00593          	li	a1,10
    800020cc:	0084a503          	lw	a0,8(s1)
    800020d0:	00001097          	auipc	ra,0x1
    800020d4:	928080e7          	jalr	-1752(ra) # 800029f8 <_Z8printIntiii>
            printString(" ");
    800020d8:	00006517          	auipc	a0,0x6
    800020dc:	06850513          	addi	a0,a0,104 # 80008140 <CONSOLE_STATUS+0x130>
    800020e0:	00000097          	auipc	ra,0x0
    800020e4:	780080e7          	jalr	1920(ra) # 80002860 <_Z11printStringPKc>
        for(BuddyEntry* curr = buddy[i]; curr != nullptr; curr = curr->next) {
    800020e8:	0004b483          	ld	s1,0(s1)
    800020ec:	fd5ff06f          	j	800020c0 <_ZN14BuddyAllocator10printBuddyEv+0x74>
    }
}
    800020f0:	01813083          	ld	ra,24(sp)
    800020f4:	01013403          	ld	s0,16(sp)
    800020f8:	00813483          	ld	s1,8(sp)
    800020fc:	00013903          	ld	s2,0(sp)
    80002100:	02010113          	addi	sp,sp,32
    80002104:	00008067          	ret

0000000080002108 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>:

BuddyAllocator::BuddyEntry *BuddyAllocator::BuddyEntry::createEntry(void* addr) {
    80002108:	ff010113          	addi	sp,sp,-16
    8000210c:	00813423          	sd	s0,8(sp)
    80002110:	01010413          	addi	s0,sp,16
        BuddyEntry* entry = (BuddyEntry*)addr;
        entry->next = nullptr;
    80002114:	00053023          	sd	zero,0(a0)
        entry->addr = addr;
    80002118:	00a53423          	sd	a0,8(a0)
        return entry;
}
    8000211c:	00813403          	ld	s0,8(sp)
    80002120:	01010113          	addi	sp,sp,16
    80002124:	00008067          	ret

0000000080002128 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>:

int BuddyAllocator::BuddyEntry::addEntry(size_t size, BuddyEntry* entry) {
    80002128:	ff010113          	addi	sp,sp,-16
    8000212c:	00813423          	sd	s0,8(sp)
    80002130:	01010413          	addi	s0,sp,16
    size--;
    80002134:	fff50513          	addi	a0,a0,-1
    if(size >= maxPowerSize) return -1;
    80002138:	00b00793          	li	a5,11
    8000213c:	08a7ec63          	bltu	a5,a0,800021d4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xac>

    if(buddy[size] == nullptr) {
    80002140:	00351713          	slli	a4,a0,0x3
    80002144:	00008797          	auipc	a5,0x8
    80002148:	33c78793          	addi	a5,a5,828 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    8000214c:	00e787b3          	add	a5,a5,a4
    80002150:	0007b783          	ld	a5,0(a5)
    80002154:	00078663          	beqz	a5,80002160 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x38>
        buddy[size] = entry;
        return 0;
    }

    BuddyEntry* prev = nullptr;
    80002158:	00000613          	li	a2,0
    8000215c:	0200006f          	j	8000217c <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x54>
        buddy[size] = entry;
    80002160:	00008797          	auipc	a5,0x8
    80002164:	32078793          	addi	a5,a5,800 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    80002168:	00e78533          	add	a0,a5,a4
    8000216c:	00b53023          	sd	a1,0(a0)
        return 0;
    80002170:	00000513          	li	a0,0
    80002174:	06c0006f          	j	800021e0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    for(BuddyEntry* curr = buddy[size]; curr != nullptr; curr = curr->next) {
    80002178:	00070793          	mv	a5,a4
    8000217c:	06078063          	beqz	a5,800021dc <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb4>
        if(curr->addr > entry->addr) {
    80002180:	0087b683          	ld	a3,8(a5)
    80002184:	0085b703          	ld	a4,8(a1)
    80002188:	00d76e63          	bltu	a4,a3,800021a4 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x7c>
                buddy[size] = entry;
            }
            break;
        }

        if(curr->next == nullptr) {
    8000218c:	0007b703          	ld	a4,0(a5)
            curr->next = entry;
            break;
        }
        prev = curr;
    80002190:	00078613          	mv	a2,a5
        if(curr->next == nullptr) {
    80002194:	fe0712e3          	bnez	a4,80002178 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x50>
            curr->next = entry;
    80002198:	00b7b023          	sd	a1,0(a5)
    }

    return 0;
    8000219c:	00000513          	li	a0,0
            break;
    800021a0:	0400006f          	j	800021e0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
            entry->next = curr;
    800021a4:	00f5b023          	sd	a5,0(a1)
            if(prev) {
    800021a8:	00060863          	beqz	a2,800021b8 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0x90>
                prev->next = curr;
    800021ac:	00f63023          	sd	a5,0(a2)
    return 0;
    800021b0:	00000513          	li	a0,0
    800021b4:	02c0006f          	j	800021e0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
                buddy[size] = entry;
    800021b8:	00351513          	slli	a0,a0,0x3
    800021bc:	00008797          	auipc	a5,0x8
    800021c0:	2c478793          	addi	a5,a5,708 # 8000a480 <_ZN14BuddyAllocator5buddyE>
    800021c4:	00a78533          	add	a0,a5,a0
    800021c8:	00b53023          	sd	a1,0(a0)
    return 0;
    800021cc:	00000513          	li	a0,0
    800021d0:	0100006f          	j	800021e0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    if(size >= maxPowerSize) return -1;
    800021d4:	fff00513          	li	a0,-1
    800021d8:	0080006f          	j	800021e0 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_+0xb8>
    return 0;
    800021dc:	00000513          	li	a0,0
}
    800021e0:	00813403          	ld	s0,8(sp)
    800021e4:	01010113          	addi	sp,sp,16
    800021e8:	00008067          	ret

00000000800021ec <_ZN14BuddyAllocator9initBuddyEv>:
    if(startAddr != nullptr) return 1;
    800021ec:	00008797          	auipc	a5,0x8
    800021f0:	2f47b783          	ld	a5,756(a5) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    800021f4:	00078663          	beqz	a5,80002200 <_ZN14BuddyAllocator9initBuddyEv+0x14>
    800021f8:	00100513          	li	a0,1
}
    800021fc:	00008067          	ret
int BuddyAllocator::initBuddy() {
    80002200:	ff010113          	addi	sp,sp,-16
    80002204:	00113423          	sd	ra,8(sp)
    80002208:	00813023          	sd	s0,0(sp)
    8000220c:	01010413          	addi	s0,sp,16
    startAddr = (void*)HEAP_START_ADDR;
    80002210:	00008797          	auipc	a5,0x8
    80002214:	1887b783          	ld	a5,392(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002218:	0007b503          	ld	a0,0(a5)
    8000221c:	00008797          	auipc	a5,0x8
    80002220:	2ca7b223          	sd	a0,708(a5) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    BuddyEntry* entry = BuddyEntry::createEntry(startAddr);
    80002224:	00000097          	auipc	ra,0x0
    80002228:	ee4080e7          	jalr	-284(ra) # 80002108 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    8000222c:	00050593          	mv	a1,a0
    int ret = BuddyEntry::addEntry(maxPowerSize, entry);
    80002230:	00c00513          	li	a0,12
    80002234:	00000097          	auipc	ra,0x0
    80002238:	ef4080e7          	jalr	-268(ra) # 80002128 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
}
    8000223c:	00813083          	ld	ra,8(sp)
    80002240:	00013403          	ld	s0,0(sp)
    80002244:	01010113          	addi	sp,sp,16
    80002248:	00008067          	ret

000000008000224c <_ZN14BuddyAllocator10buddyAllocEm>:
void *BuddyAllocator::buddyAlloc(size_t size) {
    8000224c:	fd010113          	addi	sp,sp,-48
    80002250:	02113423          	sd	ra,40(sp)
    80002254:	02813023          	sd	s0,32(sp)
    80002258:	00913c23          	sd	s1,24(sp)
    8000225c:	01213823          	sd	s2,16(sp)
    80002260:	01313423          	sd	s3,8(sp)
    80002264:	01413023          	sd	s4,0(sp)
    80002268:	03010413          	addi	s0,sp,48
    size--;
    8000226c:	fff50a13          	addi	s4,a0,-1
    if(size >= maxPowerSize) return nullptr;
    80002270:	00b00793          	li	a5,11
    80002274:	0747ea63          	bltu	a5,s4,800022e8 <_ZN14BuddyAllocator10buddyAllocEm+0x9c>
    for(size_t curr = size; curr < maxPowerSize; curr++) {
    80002278:	000a0493          	mv	s1,s4
    8000227c:	0080006f          	j	80002284 <_ZN14BuddyAllocator10buddyAllocEm+0x38>
    80002280:	00098493          	mv	s1,s3
    80002284:	00b00793          	li	a5,11
    80002288:	0697e463          	bltu	a5,s1,800022f0 <_ZN14BuddyAllocator10buddyAllocEm+0xa4>
        BuddyEntry* block = popFreeBlock(curr+1); // +1 zato sto je indeksiranje od nule
    8000228c:	00148993          	addi	s3,s1,1
    80002290:	00098513          	mv	a0,s3
    80002294:	00000097          	auipc	ra,0x0
    80002298:	cd4080e7          	jalr	-812(ra) # 80001f68 <_ZN14BuddyAllocator12popFreeBlockEm>
    8000229c:	00050913          	mv	s2,a0
        if(block != nullptr) { // postoji slobodan blok ove velicine
    800022a0:	fe0500e3          	beqz	a0,80002280 <_ZN14BuddyAllocator10buddyAllocEm+0x34>
            while(curr > size) {
    800022a4:	029a7e63          	bgeu	s4,s1,800022e0 <_ZN14BuddyAllocator10buddyAllocEm+0x94>

    static BuddyEntry* getFreeBlock(size_t size);
    static BuddyEntry* popFreeBlock(size_t size);
    static BuddyEntry* popFreeBlockAddr(size_t size, void* addr);
    static size_t sizeInBytes(size_t size) {
        size--;
    800022a8:	fff48993          	addi	s3,s1,-1
        return (1<<size)*blockSize;
    800022ac:	00100793          	li	a5,1
    800022b0:	013797bb          	sllw	a5,a5,s3
    800022b4:	00c79793          	slli	a5,a5,0xc
                BuddyEntry* other = BuddyEntry::createEntry((void*)((char*)block->addr + offset));
    800022b8:	00893503          	ld	a0,8(s2)
    800022bc:	00f50533          	add	a0,a0,a5
    800022c0:	00000097          	auipc	ra,0x0
    800022c4:	e48080e7          	jalr	-440(ra) # 80002108 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800022c8:	00050593          	mv	a1,a0
                BuddyEntry::addEntry(curr, other); // jedan dalje splitujemo, drugi ubacujemo kao slobodan segment
    800022cc:	00048513          	mv	a0,s1
    800022d0:	00000097          	auipc	ra,0x0
    800022d4:	e58080e7          	jalr	-424(ra) # 80002128 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
                curr--;
    800022d8:	00098493          	mv	s1,s3
            while(curr > size) {
    800022dc:	fc9ff06f          	j	800022a4 <_ZN14BuddyAllocator10buddyAllocEm+0x58>
            void* res = block->addr;
    800022e0:	00893503          	ld	a0,8(s2)
            return res;
    800022e4:	0100006f          	j	800022f4 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    if(size >= maxPowerSize) return nullptr;
    800022e8:	00000513          	li	a0,0
    800022ec:	0080006f          	j	800022f4 <_ZN14BuddyAllocator10buddyAllocEm+0xa8>
    return nullptr;
    800022f0:	00000513          	li	a0,0
}
    800022f4:	02813083          	ld	ra,40(sp)
    800022f8:	02013403          	ld	s0,32(sp)
    800022fc:	01813483          	ld	s1,24(sp)
    80002300:	01013903          	ld	s2,16(sp)
    80002304:	00813983          	ld	s3,8(sp)
    80002308:	00013a03          	ld	s4,0(sp)
    8000230c:	03010113          	addi	sp,sp,48
    80002310:	00008067          	ret

0000000080002314 <_ZN14BuddyAllocator9buddyFreeEPvm>:
    size--;
    80002314:	fff58593          	addi	a1,a1,-1
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002318:	00b00793          	li	a5,11
    8000231c:	0ab7ec63          	bltu	a5,a1,800023d4 <_ZN14BuddyAllocator9buddyFreeEPvm+0xc0>
int BuddyAllocator::buddyFree(void *addr, size_t size) {
    80002320:	fd010113          	addi	sp,sp,-48
    80002324:	02113423          	sd	ra,40(sp)
    80002328:	02813023          	sd	s0,32(sp)
    8000232c:	00913c23          	sd	s1,24(sp)
    80002330:	01213823          	sd	s2,16(sp)
    80002334:	01313423          	sd	s3,8(sp)
    80002338:	01413023          	sd	s4,0(sp)
    8000233c:	03010413          	addi	s0,sp,48
    80002340:	00050a13          	mv	s4,a0
    if(size >= maxPowerSize || addr == nullptr) return -1;
    80002344:	00051a63          	bnez	a0,80002358 <_ZN14BuddyAllocator9buddyFreeEPvm+0x44>
    80002348:	fff00513          	li	a0,-1
    8000234c:	0940006f          	j	800023e0 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
            next = other;
    80002350:	00048a13          	mv	s4,s1
    80002354:	00098593          	mv	a1,s3
    while(size < maxPowerSize) {
    80002358:	00b00793          	li	a5,11
    8000235c:	08b7e063          	bltu	a5,a1,800023dc <_ZN14BuddyAllocator9buddyFreeEPvm+0xc8>
    }

    static void* relativeAddress(void* addr) {
        return (char*)addr - (size_t)startAddr;
    80002360:	00008917          	auipc	s2,0x8
    80002364:	18093903          	ld	s2,384(s2) # 8000a4e0 <_ZN14BuddyAllocator9startAddrE>
    80002368:	412a0933          	sub	s2,s4,s2
        size--;
    8000236c:	00158993          	addi	s3,a1,1
        return (1<<size)*blockSize;
    80002370:	00100793          	li	a5,1
    80002374:	0137973b          	sllw	a4,a5,s3
    80002378:	00c71713          	slli	a4,a4,0xc
        size_t module = (size_t)relativeAddress(next) % sizeInBytes(size+2); // jer imamo blok npr 0 i 0+2^(size+1)
    8000237c:	02e97933          	remu	s2,s2,a4
    80002380:	00b797bb          	sllw	a5,a5,a1
    80002384:	00c79793          	slli	a5,a5,0xc
        other = (void*)((char*)other + (module == 0 ? offset : -offset));
    80002388:	00090463          	beqz	s2,80002390 <_ZN14BuddyAllocator9buddyFreeEPvm+0x7c>
    8000238c:	40f007b3          	neg	a5,a5
    80002390:	00fa04b3          	add	s1,s4,a5
        BuddyEntry* otherEntry = popFreeBlockAddr(size+1, other);
    80002394:	00048593          	mv	a1,s1
    80002398:	00098513          	mv	a0,s3
    8000239c:	00000097          	auipc	ra,0x0
    800023a0:	c28080e7          	jalr	-984(ra) # 80001fc4 <_ZN14BuddyAllocator16popFreeBlockAddrEmPv>
        if(!otherEntry){ // nema buddy bloka sa kojim moze da se spoji
    800023a4:	00050663          	beqz	a0,800023b0 <_ZN14BuddyAllocator9buddyFreeEPvm+0x9c>
        if(module != 0) {
    800023a8:	fa0914e3          	bnez	s2,80002350 <_ZN14BuddyAllocator9buddyFreeEPvm+0x3c>
    800023ac:	fa9ff06f          	j	80002354 <_ZN14BuddyAllocator9buddyFreeEPvm+0x40>
            BuddyEntry* entry = BuddyEntry::createEntry(next);
    800023b0:	000a0513          	mv	a0,s4
    800023b4:	00000097          	auipc	ra,0x0
    800023b8:	d54080e7          	jalr	-684(ra) # 80002108 <_ZN14BuddyAllocator10BuddyEntry11createEntryEPv>
    800023bc:	00050593          	mv	a1,a0
            BuddyEntry::addEntry(size+1, entry);
    800023c0:	00098513          	mv	a0,s3
    800023c4:	00000097          	auipc	ra,0x0
    800023c8:	d64080e7          	jalr	-668(ra) # 80002128 <_ZN14BuddyAllocator10BuddyEntry8addEntryEmPS0_>
    return 0;
    800023cc:	00000513          	li	a0,0
            break;
    800023d0:	0100006f          	j	800023e0 <_ZN14BuddyAllocator9buddyFreeEPvm+0xcc>
    if(size >= maxPowerSize || addr == nullptr) return -1;
    800023d4:	fff00513          	li	a0,-1
}
    800023d8:	00008067          	ret
    return 0;
    800023dc:	00000513          	li	a0,0
}
    800023e0:	02813083          	ld	ra,40(sp)
    800023e4:	02013403          	ld	s0,32(sp)
    800023e8:	01813483          	ld	s1,24(sp)
    800023ec:	01013903          	ld	s2,16(sp)
    800023f0:	00813983          	ld	s3,8(sp)
    800023f4:	00013a03          	ld	s4,0(sp)
    800023f8:	03010113          	addi	sp,sp,48
    800023fc:	00008067          	ret

0000000080002400 <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    80002400:	fe010113          	addi	sp,sp,-32
    80002404:	00113c23          	sd	ra,24(sp)
    80002408:	00813823          	sd	s0,16(sp)
    8000240c:	00913423          	sd	s1,8(sp)
    80002410:	01213023          	sd	s2,0(sp)
    80002414:	02010413          	addi	s0,sp,32
    80002418:	00050493          	mv	s1,a0
    8000241c:	00058913          	mv	s2,a1
    if(!array) {
    80002420:	01053783          	ld	a5,16(a0)
    80002424:	04078863          	beqz	a5,80002474 <_ZN8IOBuffer8pushBackEc+0x74>
        array = (char*)kmalloc(capacity);
    }
    array[tail] = c;
    80002428:	0104b783          	ld	a5,16(s1)
    8000242c:	0084a703          	lw	a4,8(s1)
    80002430:	00e787b3          	add	a5,a5,a4
    80002434:	01278023          	sb	s2,0(a5)
    size++;
    80002438:	00c4a783          	lw	a5,12(s1)
    8000243c:	0017879b          	addiw	a5,a5,1
    80002440:	00f4a623          	sw	a5,12(s1)
    tail = tail == capacity - 1 ? 0 : tail + 1;
    80002444:	0084a783          	lw	a5,8(s1)
    80002448:	0004a703          	lw	a4,0(s1)
    8000244c:	fff7071b          	addiw	a4,a4,-1
    80002450:	02e78c63          	beq	a5,a4,80002488 <_ZN8IOBuffer8pushBackEc+0x88>
    80002454:	0017879b          	addiw	a5,a5,1
    80002458:	00f4a423          	sw	a5,8(s1)
}
    8000245c:	01813083          	ld	ra,24(sp)
    80002460:	01013403          	ld	s0,16(sp)
    80002464:	00813483          	ld	s1,8(sp)
    80002468:	00013903          	ld	s2,0(sp)
    8000246c:	02010113          	addi	sp,sp,32
    80002470:	00008067          	ret
        array = (char*)kmalloc(capacity);
    80002474:	00052503          	lw	a0,0(a0)
    80002478:	00002097          	auipc	ra,0x2
    8000247c:	5bc080e7          	jalr	1468(ra) # 80004a34 <_Z7kmallocm>
    80002480:	00a4b823          	sd	a0,16(s1)
    80002484:	fa5ff06f          	j	80002428 <_ZN8IOBuffer8pushBackEc+0x28>
    tail = tail == capacity - 1 ? 0 : tail + 1;
    80002488:	00000793          	li	a5,0
    8000248c:	fcdff06f          	j	80002458 <_ZN8IOBuffer8pushBackEc+0x58>

0000000080002490 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void*) {
    80002490:	fe010113          	addi	sp,sp,-32
    80002494:	00113c23          	sd	ra,24(sp)
    80002498:	00813823          	sd	s0,16(sp)
    8000249c:	00913423          	sd	s1,8(sp)
    800024a0:	02010413          	addi	s0,sp,32
    800024a4:	0500006f          	j	800024f4 <_ZN3CCB9inputBodyEPv+0x64>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    800024a8:	00008797          	auipc	a5,0x8
    800024ac:	ed87b783          	ld	a5,-296(a5) # 8000a380 <_GLOBAL_OFFSET_TABLE_+0x8>
    800024b0:	0007b783          	ld	a5,0(a5)
    800024b4:	0007c583          	lbu	a1,0(a5)
    800024b8:	00008517          	auipc	a0,0x8
    800024bc:	d7050513          	addi	a0,a0,-656 # 8000a228 <_ZN3CCB11inputBufferE>
    800024c0:	00000097          	auipc	ra,0x0
    800024c4:	f40080e7          	jalr	-192(ra) # 80002400 <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    800024c8:	00008497          	auipc	s1,0x8
    800024cc:	02048493          	addi	s1,s1,32 # 8000a4e8 <_ZN3CCB16inputBufferEmptyE>
    800024d0:	0004b503          	ld	a0,0(s1)
    800024d4:	fffff097          	auipc	ra,0xfffff
    800024d8:	f1c080e7          	jalr	-228(ra) # 800013f0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    800024dc:	00a00513          	li	a0,10
    800024e0:	00003097          	auipc	ra,0x3
    800024e4:	5dc080e7          	jalr	1500(ra) # 80005abc <plic_complete>
            sem_wait(semInput);
    800024e8:	0084b503          	ld	a0,8(s1)
    800024ec:	fffff097          	auipc	ra,0xfffff
    800024f0:	ebc080e7          	jalr	-324(ra) # 800013a8 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    800024f4:	00008797          	auipc	a5,0x8
    800024f8:	e9c7b783          	ld	a5,-356(a5) # 8000a390 <_GLOBAL_OFFSET_TABLE_+0x18>
    800024fc:	0007b783          	ld	a5,0(a5)
    80002500:	0007c783          	lbu	a5,0(a5)
    80002504:	0017f793          	andi	a5,a5,1
    80002508:	fa0790e3          	bnez	a5,800024a8 <_ZN3CCB9inputBodyEPv+0x18>
        thread_dispatch();
    8000250c:	fffff097          	auipc	ra,0xfffff
    80002510:	d78080e7          	jalr	-648(ra) # 80001284 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80002514:	fe1ff06f          	j	800024f4 <_ZN3CCB9inputBodyEPv+0x64>

0000000080002518 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80002518:	ff010113          	addi	sp,sp,-16
    8000251c:	00813423          	sd	s0,8(sp)
    80002520:	01010413          	addi	s0,sp,16
    if(!size) return 0;
    80002524:	00c52703          	lw	a4,12(a0)
    80002528:	04070463          	beqz	a4,80002570 <_ZN8IOBuffer8popFrontEv+0x58>
    8000252c:	00050793          	mv	a5,a0

    char c = array[head];
    80002530:	01053603          	ld	a2,16(a0)
    80002534:	00452683          	lw	a3,4(a0)
    80002538:	00d60633          	add	a2,a2,a3
    8000253c:	00064503          	lbu	a0,0(a2)
    size--;
    80002540:	fff7071b          	addiw	a4,a4,-1
    80002544:	00e7a623          	sw	a4,12(a5)
    head = head == capacity - 1 ? 0 : head + 1;
    80002548:	0007a703          	lw	a4,0(a5)
    8000254c:	fff7071b          	addiw	a4,a4,-1
    80002550:	00e68c63          	beq	a3,a4,80002568 <_ZN8IOBuffer8popFrontEv+0x50>
    80002554:	0016869b          	addiw	a3,a3,1
    80002558:	00d7a223          	sw	a3,4(a5)
    return c;
}
    8000255c:	00813403          	ld	s0,8(sp)
    80002560:	01010113          	addi	sp,sp,16
    80002564:	00008067          	ret
    head = head == capacity - 1 ? 0 : head + 1;
    80002568:	00000693          	li	a3,0
    8000256c:	fedff06f          	j	80002558 <_ZN8IOBuffer8popFrontEv+0x40>
    if(!size) return 0;
    80002570:	00000513          	li	a0,0
    80002574:	fe9ff06f          	j	8000255c <_ZN8IOBuffer8popFrontEv+0x44>

0000000080002578 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80002578:	ff010113          	addi	sp,sp,-16
    8000257c:	00813423          	sd	s0,8(sp)
    80002580:	01010413          	addi	s0,sp,16
    return size > 0 ? array[tail] : 0;
    80002584:	00c52783          	lw	a5,12(a0)
    80002588:	02f05063          	blez	a5,800025a8 <_ZN8IOBuffer8peekBackEv+0x30>
    8000258c:	01053783          	ld	a5,16(a0)
    80002590:	00852703          	lw	a4,8(a0)
    80002594:	00e787b3          	add	a5,a5,a4
    80002598:	0007c503          	lbu	a0,0(a5)
}
    8000259c:	00813403          	ld	s0,8(sp)
    800025a0:	01010113          	addi	sp,sp,16
    800025a4:	00008067          	ret
    return size > 0 ? array[tail] : 0;
    800025a8:	00000513          	li	a0,0
    800025ac:	ff1ff06f          	j	8000259c <_ZN8IOBuffer8peekBackEv+0x24>

00000000800025b0 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    800025b0:	ff010113          	addi	sp,sp,-16
    800025b4:	00813423          	sd	s0,8(sp)
    800025b8:	01010413          	addi	s0,sp,16
    return size > 0 ? array[head] : 0;
    800025bc:	00c52783          	lw	a5,12(a0)
    800025c0:	02f05063          	blez	a5,800025e0 <_ZN8IOBuffer9peekFrontEv+0x30>
    800025c4:	01053783          	ld	a5,16(a0)
    800025c8:	00452703          	lw	a4,4(a0)
    800025cc:	00e787b3          	add	a5,a5,a4
    800025d0:	0007c503          	lbu	a0,0(a5)
}
    800025d4:	00813403          	ld	s0,8(sp)
    800025d8:	01010113          	addi	sp,sp,16
    800025dc:	00008067          	ret
    return size > 0 ? array[head] : 0;
    800025e0:	00000513          	li	a0,0
    800025e4:	ff1ff06f          	j	800025d4 <_ZN8IOBuffer9peekFrontEv+0x24>

00000000800025e8 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void*) {
    800025e8:	fe010113          	addi	sp,sp,-32
    800025ec:	00113c23          	sd	ra,24(sp)
    800025f0:	00813823          	sd	s0,16(sp)
    800025f4:	00913423          	sd	s1,8(sp)
    800025f8:	02010413          	addi	s0,sp,32
    800025fc:	00c0006f          	j	80002608 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    80002600:	fffff097          	auipc	ra,0xfffff
    80002604:	c84080e7          	jalr	-892(ra) # 80001284 <_Z15thread_dispatchv>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002608:	00008797          	auipc	a5,0x8
    8000260c:	d887b783          	ld	a5,-632(a5) # 8000a390 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002610:	0007b783          	ld	a5,0(a5)
    80002614:	0007c783          	lbu	a5,0(a5)
    80002618:	0207f793          	andi	a5,a5,32
    8000261c:	fe0782e3          	beqz	a5,80002600 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80002620:	00008517          	auipc	a0,0x8
    80002624:	c2050513          	addi	a0,a0,-992 # 8000a240 <_ZN3CCB12outputBufferE>
    80002628:	00000097          	auipc	ra,0x0
    8000262c:	f88080e7          	jalr	-120(ra) # 800025b0 <_ZN8IOBuffer9peekFrontEv>
    80002630:	fc0508e3          	beqz	a0,80002600 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80002634:	00008797          	auipc	a5,0x8
    80002638:	d7c7b783          	ld	a5,-644(a5) # 8000a3b0 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000263c:	0007b483          	ld	s1,0(a5)
    80002640:	00008517          	auipc	a0,0x8
    80002644:	c0050513          	addi	a0,a0,-1024 # 8000a240 <_ZN3CCB12outputBufferE>
    80002648:	00000097          	auipc	ra,0x0
    8000264c:	ed0080e7          	jalr	-304(ra) # 80002518 <_ZN8IOBuffer8popFrontEv>
    80002650:	00a48023          	sb	a0,0(s1)
                sem_wait(semOutput);
    80002654:	00008517          	auipc	a0,0x8
    80002658:	ea453503          	ld	a0,-348(a0) # 8000a4f8 <_ZN3CCB9semOutputE>
    8000265c:	fffff097          	auipc	ra,0xfffff
    80002660:	d4c080e7          	jalr	-692(ra) # 800013a8 <_Z8sem_waitP3SCB>
        while(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80002664:	fa5ff06f          	j	80002608 <_ZN3CCB10outputBodyEPv+0x20>

0000000080002668 <_ZN13SlabAllocator13initAllocatorEPvi>:
#include "../h/SlabAllocator.h"
#include "../h/BuddyAllocator.h"

void SlabAllocator::initAllocator(void *space, int blockNum) {
    80002668:	ff010113          	addi	sp,sp,-16
    8000266c:	00113423          	sd	ra,8(sp)
    80002670:	00813023          	sd	s0,0(sp)
    80002674:	01010413          	addi	s0,sp,16
    BuddyAllocator::initBuddy();
    80002678:	00000097          	auipc	ra,0x0
    8000267c:	b74080e7          	jalr	-1164(ra) # 800021ec <_ZN14BuddyAllocator9initBuddyEv>
}
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80002690:	fc010113          	addi	sp,sp,-64
    80002694:	02113c23          	sd	ra,56(sp)
    80002698:	02813823          	sd	s0,48(sp)
    8000269c:	02913423          	sd	s1,40(sp)
    800026a0:	03213023          	sd	s2,32(sp)
    800026a4:	01313c23          	sd	s3,24(sp)
    800026a8:	01413823          	sd	s4,16(sp)
    800026ac:	01513423          	sd	s5,8(sp)
    800026b0:	04010413          	addi	s0,sp,64
    800026b4:	00050913          	mv	s2,a0
    800026b8:	00058993          	mv	s3,a1
    800026bc:	00060a13          	mv	s4,a2
    800026c0:	00068a93          	mv	s5,a3
    Cache* cache = Cache::createCache();
    800026c4:	00002097          	auipc	ra,0x2
    800026c8:	a28080e7          	jalr	-1496(ra) # 800040ec <_ZN5Cache11createCacheEv>
    800026cc:	00050493          	mv	s1,a0
    cache->initCache(name, size, ctor, dtor);
    800026d0:	000a8713          	mv	a4,s5
    800026d4:	000a0693          	mv	a3,s4
    800026d8:	00098613          	mv	a2,s3
    800026dc:	00090593          	mv	a1,s2
    800026e0:	00002097          	auipc	ra,0x2
    800026e4:	a74080e7          	jalr	-1420(ra) # 80004154 <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    return cache;
}
    800026e8:	00048513          	mv	a0,s1
    800026ec:	03813083          	ld	ra,56(sp)
    800026f0:	03013403          	ld	s0,48(sp)
    800026f4:	02813483          	ld	s1,40(sp)
    800026f8:	02013903          	ld	s2,32(sp)
    800026fc:	01813983          	ld	s3,24(sp)
    80002700:	01013a03          	ld	s4,16(sp)
    80002704:	00813a83          	ld	s5,8(sp)
    80002708:	04010113          	addi	sp,sp,64
    8000270c:	00008067          	ret

0000000080002710 <_ZN13SlabAllocator9allocSlotEP5Cache>:

void *SlabAllocator::allocSlot(Cache *cache) {
    80002710:	ff010113          	addi	sp,sp,-16
    80002714:	00113423          	sd	ra,8(sp)
    80002718:	00813023          	sd	s0,0(sp)
    8000271c:	01010413          	addi	s0,sp,16
    return (void*)((char*)cache->allocateSlot() + sizeof(Cache::Slot)); // za pocetnu adresu objekta
    80002720:	00002097          	auipc	ra,0x2
    80002724:	d60080e7          	jalr	-672(ra) # 80004480 <_ZN5Cache12allocateSlotEv>
}
    80002728:	01850513          	addi	a0,a0,24
    8000272c:	00813083          	ld	ra,8(sp)
    80002730:	00013403          	ld	s0,0(sp)
    80002734:	01010113          	addi	sp,sp,16
    80002738:	00008067          	ret

000000008000273c <_ZN13SlabAllocator8freeSlotEP5CachePv>:

void SlabAllocator::freeSlot(Cache *cache, void *obj) {
    8000273c:	ff010113          	addi	sp,sp,-16
    80002740:	00113423          	sd	ra,8(sp)
    80002744:	00813023          	sd	s0,0(sp)
    80002748:	01010413          	addi	s0,sp,16
    cache->freeSlot((Cache::Slot*)((char*)obj - sizeof(Cache::Slot))); // za pocetnu adresu slota
    8000274c:	fe858593          	addi	a1,a1,-24
    80002750:	00002097          	auipc	ra,0x2
    80002754:	b84080e7          	jalr	-1148(ra) # 800042d4 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    80002758:	00813083          	ld	ra,8(sp)
    8000275c:	00013403          	ld	s0,0(sp)
    80002760:	01010113          	addi	sp,sp,16
    80002764:	00008067          	ret

0000000080002768 <_ZN13SlabAllocator17printErrorMessageEP5Cache>:

int SlabAllocator::printErrorMessage(Cache *cache) {
    80002768:	ff010113          	addi	sp,sp,-16
    8000276c:	00113423          	sd	ra,8(sp)
    80002770:	00813023          	sd	s0,0(sp)
    80002774:	01010413          	addi	s0,sp,16
    return cache->printErrorMessage();
    80002778:	00001097          	auipc	ra,0x1
    8000277c:	4e4080e7          	jalr	1252(ra) # 80003c5c <_ZN5Cache17printErrorMessageEv>
}
    80002780:	00813083          	ld	ra,8(sp)
    80002784:	00013403          	ld	s0,0(sp)
    80002788:	01010113          	addi	sp,sp,16
    8000278c:	00008067          	ret

0000000080002790 <_ZN13SlabAllocator14printCacheInfoEP5Cache>:

void SlabAllocator::printCacheInfo(Cache *cache) {
    80002790:	ff010113          	addi	sp,sp,-16
    80002794:	00113423          	sd	ra,8(sp)
    80002798:	00813023          	sd	s0,0(sp)
    8000279c:	01010413          	addi	s0,sp,16
    cache->printCacheInfo();
    800027a0:	00001097          	auipc	ra,0x1
    800027a4:	57c080e7          	jalr	1404(ra) # 80003d1c <_ZN5Cache14printCacheInfoEv>
}
    800027a8:	00813083          	ld	ra,8(sp)
    800027ac:	00013403          	ld	s0,0(sp)
    800027b0:	01010113          	addi	sp,sp,16
    800027b4:	00008067          	ret

00000000800027b8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>:

int SlabAllocator::deallocFreeSlabs(Cache *cache) {
    800027b8:	ff010113          	addi	sp,sp,-16
    800027bc:	00113423          	sd	ra,8(sp)
    800027c0:	00813023          	sd	s0,0(sp)
    800027c4:	01010413          	addi	s0,sp,16
    return cache->deallocFreeSlabs();
    800027c8:	00001097          	auipc	ra,0x1
    800027cc:	714080e7          	jalr	1812(ra) # 80003edc <_ZN5Cache16deallocFreeSlabsEv>
}
    800027d0:	00813083          	ld	ra,8(sp)
    800027d4:	00013403          	ld	s0,0(sp)
    800027d8:	01010113          	addi	sp,sp,16
    800027dc:	00008067          	ret

00000000800027e0 <_ZN13SlabAllocator12deallocCacheEP5Cache>:

void SlabAllocator::deallocCache(Cache *cache) {
    800027e0:	ff010113          	addi	sp,sp,-16
    800027e4:	00113423          	sd	ra,8(sp)
    800027e8:	00813023          	sd	s0,0(sp)
    800027ec:	01010413          	addi	s0,sp,16
    cache->deallocCache();
    800027f0:	00001097          	auipc	ra,0x1
    800027f4:	758080e7          	jalr	1880(ra) # 80003f48 <_ZN5Cache12deallocCacheEv>
}
    800027f8:	00813083          	ld	ra,8(sp)
    800027fc:	00013403          	ld	s0,0(sp)
    80002800:	01010113          	addi	sp,sp,16
    80002804:	00008067          	ret

0000000080002808 <_ZN13SlabAllocator9allocBuffEm>:

void *SlabAllocator::allocBuff(size_t size) {
    80002808:	ff010113          	addi	sp,sp,-16
    8000280c:	00113423          	sd	ra,8(sp)
    80002810:	00813023          	sd	s0,0(sp)
    80002814:	01010413          	addi	s0,sp,16
    return (void*)((char*)Cache::allocateBuffer(size) + sizeof(Cache::Slot)); // za pocetnu adresu bafera
    80002818:	00002097          	auipc	ra,0x2
    8000281c:	cc8080e7          	jalr	-824(ra) # 800044e0 <_ZN5Cache14allocateBufferEm>
}
    80002820:	01850513          	addi	a0,a0,24
    80002824:	00813083          	ld	ra,8(sp)
    80002828:	00013403          	ld	s0,0(sp)
    8000282c:	01010113          	addi	sp,sp,16
    80002830:	00008067          	ret

0000000080002834 <_ZN13SlabAllocator8freeBuffEPKv>:

void SlabAllocator::freeBuff(const void *buff) {
    80002834:	ff010113          	addi	sp,sp,-16
    80002838:	00113423          	sd	ra,8(sp)
    8000283c:	00813023          	sd	s0,0(sp)
    80002840:	01010413          	addi	s0,sp,16
    Cache::freeBuffer((Cache::Slot*)((char*)buff - sizeof(Cache::Slot))); // za pocetnu adresu slota
    80002844:	fe850513          	addi	a0,a0,-24
    80002848:	00002097          	auipc	ra,0x2
    8000284c:	b34080e7          	jalr	-1228(ra) # 8000437c <_ZN5Cache10freeBufferEPNS_4SlotE>
}
    80002850:	00813083          	ld	ra,8(sp)
    80002854:	00013403          	ld	s0,0(sp)
    80002858:	01010113          	addi	sp,sp,16
    8000285c:	00008067          	ret

0000000080002860 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002860:	fe010113          	addi	sp,sp,-32
    80002864:	00113c23          	sd	ra,24(sp)
    80002868:	00813823          	sd	s0,16(sp)
    8000286c:	00913423          	sd	s1,8(sp)
    80002870:	02010413          	addi	s0,sp,32
    80002874:	00050493          	mv	s1,a0
    LOCK();
    80002878:	00100613          	li	a2,1
    8000287c:	00000593          	li	a1,0
    80002880:	00008517          	auipc	a0,0x8
    80002884:	c9050513          	addi	a0,a0,-880 # 8000a510 <lockPrint>
    80002888:	fffff097          	auipc	ra,0xfffff
    8000288c:	8c8080e7          	jalr	-1848(ra) # 80001150 <copy_and_swap>
    80002890:	fe0514e3          	bnez	a0,80002878 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002894:	0004c503          	lbu	a0,0(s1)
    80002898:	00050a63          	beqz	a0,800028ac <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000289c:	fffff097          	auipc	ra,0xfffff
    800028a0:	c4c080e7          	jalr	-948(ra) # 800014e8 <_Z4putcc>
        string++;
    800028a4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800028a8:	fedff06f          	j	80002894 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800028ac:	00000613          	li	a2,0
    800028b0:	00100593          	li	a1,1
    800028b4:	00008517          	auipc	a0,0x8
    800028b8:	c5c50513          	addi	a0,a0,-932 # 8000a510 <lockPrint>
    800028bc:	fffff097          	auipc	ra,0xfffff
    800028c0:	894080e7          	jalr	-1900(ra) # 80001150 <copy_and_swap>
    800028c4:	fe0514e3          	bnez	a0,800028ac <_Z11printStringPKc+0x4c>
}
    800028c8:	01813083          	ld	ra,24(sp)
    800028cc:	01013403          	ld	s0,16(sp)
    800028d0:	00813483          	ld	s1,8(sp)
    800028d4:	02010113          	addi	sp,sp,32
    800028d8:	00008067          	ret

00000000800028dc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800028dc:	fd010113          	addi	sp,sp,-48
    800028e0:	02113423          	sd	ra,40(sp)
    800028e4:	02813023          	sd	s0,32(sp)
    800028e8:	00913c23          	sd	s1,24(sp)
    800028ec:	01213823          	sd	s2,16(sp)
    800028f0:	01313423          	sd	s3,8(sp)
    800028f4:	01413023          	sd	s4,0(sp)
    800028f8:	03010413          	addi	s0,sp,48
    800028fc:	00050993          	mv	s3,a0
    80002900:	00058a13          	mv	s4,a1
    LOCK();
    80002904:	00100613          	li	a2,1
    80002908:	00000593          	li	a1,0
    8000290c:	00008517          	auipc	a0,0x8
    80002910:	c0450513          	addi	a0,a0,-1020 # 8000a510 <lockPrint>
    80002914:	fffff097          	auipc	ra,0xfffff
    80002918:	83c080e7          	jalr	-1988(ra) # 80001150 <copy_and_swap>
    8000291c:	fe0514e3          	bnez	a0,80002904 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002920:	00000913          	li	s2,0
    80002924:	00090493          	mv	s1,s2
    80002928:	0019091b          	addiw	s2,s2,1
    8000292c:	03495a63          	bge	s2,s4,80002960 <_Z9getStringPci+0x84>
        cc = getc();
    80002930:	fffff097          	auipc	ra,0xfffff
    80002934:	b88080e7          	jalr	-1144(ra) # 800014b8 <_Z4getcv>
        if(cc < 1)
    80002938:	02050463          	beqz	a0,80002960 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000293c:	009984b3          	add	s1,s3,s1
    80002940:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002944:	00a00793          	li	a5,10
    80002948:	00f50a63          	beq	a0,a5,8000295c <_Z9getStringPci+0x80>
    8000294c:	00d00793          	li	a5,13
    80002950:	fcf51ae3          	bne	a0,a5,80002924 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002954:	00090493          	mv	s1,s2
    80002958:	0080006f          	j	80002960 <_Z9getStringPci+0x84>
    8000295c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002960:	009984b3          	add	s1,s3,s1
    80002964:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002968:	00000613          	li	a2,0
    8000296c:	00100593          	li	a1,1
    80002970:	00008517          	auipc	a0,0x8
    80002974:	ba050513          	addi	a0,a0,-1120 # 8000a510 <lockPrint>
    80002978:	ffffe097          	auipc	ra,0xffffe
    8000297c:	7d8080e7          	jalr	2008(ra) # 80001150 <copy_and_swap>
    80002980:	fe0514e3          	bnez	a0,80002968 <_Z9getStringPci+0x8c>
    return buf;
}
    80002984:	00098513          	mv	a0,s3
    80002988:	02813083          	ld	ra,40(sp)
    8000298c:	02013403          	ld	s0,32(sp)
    80002990:	01813483          	ld	s1,24(sp)
    80002994:	01013903          	ld	s2,16(sp)
    80002998:	00813983          	ld	s3,8(sp)
    8000299c:	00013a03          	ld	s4,0(sp)
    800029a0:	03010113          	addi	sp,sp,48
    800029a4:	00008067          	ret

00000000800029a8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800029a8:	ff010113          	addi	sp,sp,-16
    800029ac:	00813423          	sd	s0,8(sp)
    800029b0:	01010413          	addi	s0,sp,16
    800029b4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800029b8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800029bc:	0006c603          	lbu	a2,0(a3)
    800029c0:	fd06071b          	addiw	a4,a2,-48
    800029c4:	0ff77713          	andi	a4,a4,255
    800029c8:	00900793          	li	a5,9
    800029cc:	02e7e063          	bltu	a5,a4,800029ec <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800029d0:	0025179b          	slliw	a5,a0,0x2
    800029d4:	00a787bb          	addw	a5,a5,a0
    800029d8:	0017979b          	slliw	a5,a5,0x1
    800029dc:	00168693          	addi	a3,a3,1
    800029e0:	00c787bb          	addw	a5,a5,a2
    800029e4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800029e8:	fd5ff06f          	j	800029bc <_Z11stringToIntPKc+0x14>
    return n;
}
    800029ec:	00813403          	ld	s0,8(sp)
    800029f0:	01010113          	addi	sp,sp,16
    800029f4:	00008067          	ret

00000000800029f8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800029f8:	fc010113          	addi	sp,sp,-64
    800029fc:	02113c23          	sd	ra,56(sp)
    80002a00:	02813823          	sd	s0,48(sp)
    80002a04:	02913423          	sd	s1,40(sp)
    80002a08:	03213023          	sd	s2,32(sp)
    80002a0c:	01313c23          	sd	s3,24(sp)
    80002a10:	04010413          	addi	s0,sp,64
    80002a14:	00050493          	mv	s1,a0
    80002a18:	00058913          	mv	s2,a1
    80002a1c:	00060993          	mv	s3,a2
    LOCK();
    80002a20:	00100613          	li	a2,1
    80002a24:	00000593          	li	a1,0
    80002a28:	00008517          	auipc	a0,0x8
    80002a2c:	ae850513          	addi	a0,a0,-1304 # 8000a510 <lockPrint>
    80002a30:	ffffe097          	auipc	ra,0xffffe
    80002a34:	720080e7          	jalr	1824(ra) # 80001150 <copy_and_swap>
    80002a38:	fe0514e3          	bnez	a0,80002a20 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a3c:	00098463          	beqz	s3,80002a44 <_Z8printIntiii+0x4c>
    80002a40:	0804c463          	bltz	s1,80002ac8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a44:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002a48:	00000593          	li	a1,0
    }

    i = 0;
    80002a4c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a50:	0009079b          	sext.w	a5,s2
    80002a54:	0325773b          	remuw	a4,a0,s2
    80002a58:	00048613          	mv	a2,s1
    80002a5c:	0014849b          	addiw	s1,s1,1
    80002a60:	02071693          	slli	a3,a4,0x20
    80002a64:	0206d693          	srli	a3,a3,0x20
    80002a68:	00007717          	auipc	a4,0x7
    80002a6c:	7f070713          	addi	a4,a4,2032 # 8000a258 <digits>
    80002a70:	00d70733          	add	a4,a4,a3
    80002a74:	00074683          	lbu	a3,0(a4)
    80002a78:	fd040713          	addi	a4,s0,-48
    80002a7c:	00c70733          	add	a4,a4,a2
    80002a80:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002a84:	0005071b          	sext.w	a4,a0
    80002a88:	0325553b          	divuw	a0,a0,s2
    80002a8c:	fcf772e3          	bgeu	a4,a5,80002a50 <_Z8printIntiii+0x58>
    if(neg)
    80002a90:	00058c63          	beqz	a1,80002aa8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002a94:	fd040793          	addi	a5,s0,-48
    80002a98:	009784b3          	add	s1,a5,s1
    80002a9c:	02d00793          	li	a5,45
    80002aa0:	fef48823          	sb	a5,-16(s1)
    80002aa4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002aa8:	fff4849b          	addiw	s1,s1,-1
    80002aac:	0204c463          	bltz	s1,80002ad4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002ab0:	fd040793          	addi	a5,s0,-48
    80002ab4:	009787b3          	add	a5,a5,s1
    80002ab8:	ff07c503          	lbu	a0,-16(a5)
    80002abc:	fffff097          	auipc	ra,0xfffff
    80002ac0:	a2c080e7          	jalr	-1492(ra) # 800014e8 <_Z4putcc>
    80002ac4:	fe5ff06f          	j	80002aa8 <_Z8printIntiii+0xb0>
        x = -xx;
    80002ac8:	4090053b          	negw	a0,s1
        neg = 1;
    80002acc:	00100593          	li	a1,1
        x = -xx;
    80002ad0:	f7dff06f          	j	80002a4c <_Z8printIntiii+0x54>

    UNLOCK();
    80002ad4:	00000613          	li	a2,0
    80002ad8:	00100593          	li	a1,1
    80002adc:	00008517          	auipc	a0,0x8
    80002ae0:	a3450513          	addi	a0,a0,-1484 # 8000a510 <lockPrint>
    80002ae4:	ffffe097          	auipc	ra,0xffffe
    80002ae8:	66c080e7          	jalr	1644(ra) # 80001150 <copy_and_swap>
    80002aec:	fe0514e3          	bnez	a0,80002ad4 <_Z8printIntiii+0xdc>
    80002af0:	03813083          	ld	ra,56(sp)
    80002af4:	03013403          	ld	s0,48(sp)
    80002af8:	02813483          	ld	s1,40(sp)
    80002afc:	02013903          	ld	s2,32(sp)
    80002b00:	01813983          	ld	s3,24(sp)
    80002b04:	04010113          	addi	sp,sp,64
    80002b08:	00008067          	ret

0000000080002b0c <_Z8userMainv>:
    long id;
    bool finished;
};


void userMain() {
    80002b0c:	fc010113          	addi	sp,sp,-64
    80002b10:	02113c23          	sd	ra,56(sp)
    80002b14:	02813823          	sd	s0,48(sp)
    80002b18:	02913423          	sd	s1,40(sp)
    80002b1c:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002b20:	fc040493          	addi	s1,s0,-64
    80002b24:	00048513          	mv	a0,s1
    80002b28:	00001097          	auipc	ra,0x1
    80002b2c:	8c8080e7          	jalr	-1848(ra) # 800033f0 <_ZN6ThreadC1Ev>
    80002b30:	00007797          	auipc	a5,0x7
    80002b34:	75078793          	addi	a5,a5,1872 # 8000a280 <_ZTV10ForkThread+0x10>
    80002b38:	fcf43023          	sd	a5,-64(s0)
    80002b3c:	00100793          	li	a5,1
    80002b40:	fcf43823          	sd	a5,-48(s0)
    80002b44:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    80002b48:	00048513          	mv	a0,s1
    80002b4c:	00001097          	auipc	ra,0x1
    80002b50:	864080e7          	jalr	-1948(ra) # 800033b0 <_ZN6Thread5startEv>
        return finished;
    80002b54:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    80002b58:	00079863          	bnez	a5,80002b68 <_Z8userMainv+0x5c>
        thread_dispatch();
    80002b5c:	ffffe097          	auipc	ra,0xffffe
    80002b60:	728080e7          	jalr	1832(ra) # 80001284 <_Z15thread_dispatchv>
    80002b64:	ff1ff06f          	j	80002b54 <_Z8userMainv+0x48>
    }

    printString("User main finished\n");
    80002b68:	00005517          	auipc	a0,0x5
    80002b6c:	61050513          	addi	a0,a0,1552 # 80008178 <CONSOLE_STATUS+0x168>
    80002b70:	00000097          	auipc	ra,0x0
    80002b74:	cf0080e7          	jalr	-784(ra) # 80002860 <_Z11printStringPKc>
class ForkThread : public Thread {
    80002b78:	00007797          	auipc	a5,0x7
    80002b7c:	70878793          	addi	a5,a5,1800 # 8000a280 <_ZTV10ForkThread+0x10>
    80002b80:	fcf43023          	sd	a5,-64(s0)
    80002b84:	fc040513          	addi	a0,s0,-64
    80002b88:	00000097          	auipc	ra,0x0
    80002b8c:	5a4080e7          	jalr	1444(ra) # 8000312c <_ZN6ThreadD1Ev>
    80002b90:	03813083          	ld	ra,56(sp)
    80002b94:	03013403          	ld	s0,48(sp)
    80002b98:	02813483          	ld	s1,40(sp)
    80002b9c:	04010113          	addi	sp,sp,64
    80002ba0:	00008067          	ret
    80002ba4:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80002ba8:	00007797          	auipc	a5,0x7
    80002bac:	6d878793          	addi	a5,a5,1752 # 8000a280 <_ZTV10ForkThread+0x10>
    80002bb0:	fcf43023          	sd	a5,-64(s0)
    80002bb4:	fc040513          	addi	a0,s0,-64
    80002bb8:	00000097          	auipc	ra,0x0
    80002bbc:	574080e7          	jalr	1396(ra) # 8000312c <_ZN6ThreadD1Ev>
    80002bc0:	00048513          	mv	a0,s1
    80002bc4:	00009097          	auipc	ra,0x9
    80002bc8:	ab4080e7          	jalr	-1356(ra) # 8000b678 <_Unwind_Resume>

0000000080002bcc <_ZN10ForkThread3runEv>:
    virtual void run() {
    80002bcc:	fc010113          	addi	sp,sp,-64
    80002bd0:	02113c23          	sd	ra,56(sp)
    80002bd4:	02813823          	sd	s0,48(sp)
    80002bd8:	02913423          	sd	s1,40(sp)
    80002bdc:	03213023          	sd	s2,32(sp)
    80002be0:	01313c23          	sd	s3,24(sp)
    80002be4:	01413823          	sd	s4,16(sp)
    80002be8:	01513423          	sd	s5,8(sp)
    80002bec:	01613023          	sd	s6,0(sp)
    80002bf0:	04010413          	addi	s0,sp,64
    80002bf4:	00050a13          	mv	s4,a0
        printString("Started thread id:");
    80002bf8:	00005517          	auipc	a0,0x5
    80002bfc:	55050513          	addi	a0,a0,1360 # 80008148 <CONSOLE_STATUS+0x138>
    80002c00:	00000097          	auipc	ra,0x0
    80002c04:	c60080e7          	jalr	-928(ra) # 80002860 <_Z11printStringPKc>
        printInt(id);
    80002c08:	00000613          	li	a2,0
    80002c0c:	00a00593          	li	a1,10
    80002c10:	010a2503          	lw	a0,16(s4)
    80002c14:	00000097          	auipc	ra,0x0
    80002c18:	de4080e7          	jalr	-540(ra) # 800029f8 <_Z8printIntiii>
        printString("\n");
    80002c1c:	00005517          	auipc	a0,0x5
    80002c20:	64450513          	addi	a0,a0,1604 # 80008260 <CONSOLE_STATUS+0x250>
    80002c24:	00000097          	auipc	ra,0x0
    80002c28:	c3c080e7          	jalr	-964(ra) # 80002860 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    80002c2c:	02000513          	li	a0,32
    80002c30:	00000097          	auipc	ra,0x0
    80002c34:	6c8080e7          	jalr	1736(ra) # 800032f8 <_ZN6ThreadnwEm>
    80002c38:	00050993          	mv	s3,a0
    80002c3c:	02050463          	beqz	a0,80002c64 <_ZN10ForkThread3runEv+0x98>
    80002c40:	010a3483          	ld	s1,16(s4)
    80002c44:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002c48:	00000097          	auipc	ra,0x0
    80002c4c:	7a8080e7          	jalr	1960(ra) # 800033f0 <_ZN6ThreadC1Ev>
    80002c50:	00007797          	auipc	a5,0x7
    80002c54:	63078793          	addi	a5,a5,1584 # 8000a280 <_ZTV10ForkThread+0x10>
    80002c58:	00f9b023          	sd	a5,0(s3)
    80002c5c:	0099b823          	sd	s1,16(s3)
    80002c60:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80002c64:	010a3503          	ld	a0,16(s4)
    80002c68:	00351513          	slli	a0,a0,0x3
    80002c6c:	ffffe097          	auipc	ra,0xffffe
    80002c70:	528080e7          	jalr	1320(ra) # 80001194 <_Z9mem_allocm>
    80002c74:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    80002c78:	10050863          	beqz	a0,80002d88 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    80002c7c:	00000913          	li	s2,0
    80002c80:	0140006f          	j	80002c94 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    80002c84:	00391793          	slli	a5,s2,0x3
    80002c88:	00fa87b3          	add	a5,s5,a5
    80002c8c:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    80002c90:	00190913          	addi	s2,s2,1
    80002c94:	010a3783          	ld	a5,16(s4)
    80002c98:	02f95e63          	bge	s2,a5,80002cd4 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    80002c9c:	02000513          	li	a0,32
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	658080e7          	jalr	1624(ra) # 800032f8 <_ZN6ThreadnwEm>
    80002ca8:	00050493          	mv	s1,a0
    80002cac:	fc050ce3          	beqz	a0,80002c84 <_ZN10ForkThread3runEv+0xb8>
    80002cb0:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002cb4:	00000097          	auipc	ra,0x0
    80002cb8:	73c080e7          	jalr	1852(ra) # 800033f0 <_ZN6ThreadC1Ev>
    80002cbc:	00007797          	auipc	a5,0x7
    80002cc0:	5c478793          	addi	a5,a5,1476 # 8000a280 <_ZTV10ForkThread+0x10>
    80002cc4:	00f4b023          	sd	a5,0(s1)
    80002cc8:	0164b823          	sd	s6,16(s1)
    80002ccc:	00048c23          	sb	zero,24(s1)
    80002cd0:	fb5ff06f          	j	80002c84 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    80002cd4:	06098a63          	beqz	s3,80002d48 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    80002cd8:	00098513          	mv	a0,s3
    80002cdc:	00000097          	auipc	ra,0x0
    80002ce0:	6d4080e7          	jalr	1748(ra) # 800033b0 <_ZN6Thread5startEv>
    80002ce4:	00050913          	mv	s2,a0
    80002ce8:	04051863          	bnez	a0,80002d38 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    80002cec:	00050493          	mv	s1,a0
    80002cf0:	0100006f          	j	80002d00 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    80002cf4:	ffffe097          	auipc	ra,0xffffe
    80002cf8:	590080e7          	jalr	1424(ra) # 80001284 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80002cfc:	0014849b          	addiw	s1,s1,1
    80002d00:	000017b7          	lui	a5,0x1
    80002d04:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002d08:	0097ce63          	blt	a5,s1,80002d24 <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    80002d0c:	00090713          	mv	a4,s2
    80002d10:	000017b7          	lui	a5,0x1
    80002d14:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002d18:	fce7cee3          	blt	a5,a4,80002cf4 <_ZN10ForkThread3runEv+0x128>
    80002d1c:	0017071b          	addiw	a4,a4,1
    80002d20:	ff1ff06f          	j	80002d10 <_ZN10ForkThread3runEv+0x144>
        return finished;
    80002d24:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80002d28:	00079863          	bnez	a5,80002d38 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    80002d2c:	ffffe097          	auipc	ra,0xffffe
    80002d30:	558080e7          	jalr	1368(ra) # 80001284 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    80002d34:	ff1ff06f          	j	80002d24 <_ZN10ForkThread3runEv+0x158>
                delete thread;
    80002d38:	0009b783          	ld	a5,0(s3)
    80002d3c:	0087b783          	ld	a5,8(a5)
    80002d40:	00098513          	mv	a0,s3
    80002d44:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80002d48:	00000493          	li	s1,0
    80002d4c:	0080006f          	j	80002d54 <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    80002d50:	00148493          	addi	s1,s1,1
    80002d54:	010a3783          	ld	a5,16(s4)
    80002d58:	02f4d263          	bge	s1,a5,80002d7c <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    80002d5c:	00349793          	slli	a5,s1,0x3
    80002d60:	00fa87b3          	add	a5,s5,a5
    80002d64:	0007b503          	ld	a0,0(a5)
    80002d68:	fe0504e3          	beqz	a0,80002d50 <_ZN10ForkThread3runEv+0x184>
    80002d6c:	00053783          	ld	a5,0(a0)
    80002d70:	0087b783          	ld	a5,8(a5)
    80002d74:	000780e7          	jalr	a5
    80002d78:	fd9ff06f          	j	80002d50 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    80002d7c:	000a8513          	mv	a0,s5
    80002d80:	ffffe097          	auipc	ra,0xffffe
    80002d84:	454080e7          	jalr	1108(ra) # 800011d4 <_Z8mem_freePv>
        printString("Finished thread id:");
    80002d88:	00005517          	auipc	a0,0x5
    80002d8c:	3d850513          	addi	a0,a0,984 # 80008160 <CONSOLE_STATUS+0x150>
    80002d90:	00000097          	auipc	ra,0x0
    80002d94:	ad0080e7          	jalr	-1328(ra) # 80002860 <_Z11printStringPKc>
        printInt(id);
    80002d98:	00000613          	li	a2,0
    80002d9c:	00a00593          	li	a1,10
    80002da0:	010a2503          	lw	a0,16(s4)
    80002da4:	00000097          	auipc	ra,0x0
    80002da8:	c54080e7          	jalr	-940(ra) # 800029f8 <_Z8printIntiii>
        printString("\n");
    80002dac:	00005517          	auipc	a0,0x5
    80002db0:	4b450513          	addi	a0,a0,1204 # 80008260 <CONSOLE_STATUS+0x250>
    80002db4:	00000097          	auipc	ra,0x0
    80002db8:	aac080e7          	jalr	-1364(ra) # 80002860 <_Z11printStringPKc>
        finished = true;
    80002dbc:	00100793          	li	a5,1
    80002dc0:	00fa0c23          	sb	a5,24(s4)
    }
    80002dc4:	03813083          	ld	ra,56(sp)
    80002dc8:	03013403          	ld	s0,48(sp)
    80002dcc:	02813483          	ld	s1,40(sp)
    80002dd0:	02013903          	ld	s2,32(sp)
    80002dd4:	01813983          	ld	s3,24(sp)
    80002dd8:	01013a03          	ld	s4,16(sp)
    80002ddc:	00813a83          	ld	s5,8(sp)
    80002de0:	00013b03          	ld	s6,0(sp)
    80002de4:	04010113          	addi	sp,sp,64
    80002de8:	00008067          	ret

0000000080002dec <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    80002dec:	ff010113          	addi	sp,sp,-16
    80002df0:	00113423          	sd	ra,8(sp)
    80002df4:	00813023          	sd	s0,0(sp)
    80002df8:	01010413          	addi	s0,sp,16
    80002dfc:	00007797          	auipc	a5,0x7
    80002e00:	48478793          	addi	a5,a5,1156 # 8000a280 <_ZTV10ForkThread+0x10>
    80002e04:	00f53023          	sd	a5,0(a0)
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	324080e7          	jalr	804(ra) # 8000312c <_ZN6ThreadD1Ev>
    80002e10:	00813083          	ld	ra,8(sp)
    80002e14:	00013403          	ld	s0,0(sp)
    80002e18:	01010113          	addi	sp,sp,16
    80002e1c:	00008067          	ret

0000000080002e20 <_ZN10ForkThreadD0Ev>:
    80002e20:	fe010113          	addi	sp,sp,-32
    80002e24:	00113c23          	sd	ra,24(sp)
    80002e28:	00813823          	sd	s0,16(sp)
    80002e2c:	00913423          	sd	s1,8(sp)
    80002e30:	02010413          	addi	s0,sp,32
    80002e34:	00050493          	mv	s1,a0
    80002e38:	00007797          	auipc	a5,0x7
    80002e3c:	44878793          	addi	a5,a5,1096 # 8000a280 <_ZTV10ForkThread+0x10>
    80002e40:	00f53023          	sd	a5,0(a0)
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	2e8080e7          	jalr	744(ra) # 8000312c <_ZN6ThreadD1Ev>
    80002e4c:	00048513          	mv	a0,s1
    80002e50:	00000097          	auipc	ra,0x0
    80002e54:	4d0080e7          	jalr	1232(ra) # 80003320 <_ZN6ThreaddlEPv>
    80002e58:	01813083          	ld	ra,24(sp)
    80002e5c:	01013403          	ld	s0,16(sp)
    80002e60:	00813483          	ld	s1,8(sp)
    80002e64:	02010113          	addi	sp,sp,32
    80002e68:	00008067          	ret

0000000080002e6c <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr;
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80002e6c:	ff010113          	addi	sp,sp,-16
    80002e70:	00813423          	sd	s0,8(sp)
    80002e74:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002e78:	02050663          	beqz	a0,80002ea4 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80002e7c:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002e80:	00007797          	auipc	a5,0x7
    80002e84:	6987b783          	ld	a5,1688(a5) # 8000a518 <_ZN9Scheduler4tailE>
    80002e88:	02078463          	beqz	a5,80002eb0 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80002e8c:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80002e90:	00007797          	auipc	a5,0x7
    80002e94:	68878793          	addi	a5,a5,1672 # 8000a518 <_ZN9Scheduler4tailE>
    80002e98:	0007b703          	ld	a4,0(a5)
    80002e9c:	00073703          	ld	a4,0(a4)
    80002ea0:	00e7b023          	sd	a4,0(a5)
    }
}
    80002ea4:	00813403          	ld	s0,8(sp)
    80002ea8:	01010113          	addi	sp,sp,16
    80002eac:	00008067          	ret
        head = tail = process;
    80002eb0:	00007797          	auipc	a5,0x7
    80002eb4:	66878793          	addi	a5,a5,1640 # 8000a518 <_ZN9Scheduler4tailE>
    80002eb8:	00a7b023          	sd	a0,0(a5)
    80002ebc:	00a7b423          	sd	a0,8(a5)
    80002ec0:	fe5ff06f          	j	80002ea4 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080002ec4 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80002ec4:	ff010113          	addi	sp,sp,-16
    80002ec8:	00813423          	sd	s0,8(sp)
    80002ecc:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80002ed0:	00007517          	auipc	a0,0x7
    80002ed4:	65053503          	ld	a0,1616(a0) # 8000a520 <_ZN9Scheduler4headE>
    80002ed8:	02050463          	beqz	a0,80002f00 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80002edc:	00053703          	ld	a4,0(a0)
    80002ee0:	00007797          	auipc	a5,0x7
    80002ee4:	63878793          	addi	a5,a5,1592 # 8000a518 <_ZN9Scheduler4tailE>
    80002ee8:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80002eec:	0007b783          	ld	a5,0(a5)
    80002ef0:	00f50e63          	beq	a0,a5,80002f0c <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80002ef4:	00813403          	ld	s0,8(sp)
    80002ef8:	01010113          	addi	sp,sp,16
    80002efc:	00008067          	ret
        return idleProcess;
    80002f00:	00007517          	auipc	a0,0x7
    80002f04:	62853503          	ld	a0,1576(a0) # 8000a528 <_ZN9Scheduler11idleProcessE>
    80002f08:	fedff06f          	j	80002ef4 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80002f0c:	00007797          	auipc	a5,0x7
    80002f10:	60e7b623          	sd	a4,1548(a5) # 8000a518 <_ZN9Scheduler4tailE>
    80002f14:	fe1ff06f          	j	80002ef4 <_ZN9Scheduler3getEv+0x30>

0000000080002f18 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80002f18:	ff010113          	addi	sp,sp,-16
    80002f1c:	00813423          	sd	s0,8(sp)
    80002f20:	01010413          	addi	s0,sp,16
    if(!process) return;
    80002f24:	00050e63          	beqz	a0,80002f40 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80002f28:	00007797          	auipc	a5,0x7
    80002f2c:	5f87b783          	ld	a5,1528(a5) # 8000a520 <_ZN9Scheduler4headE>
    80002f30:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80002f34:	00078c63          	beqz	a5,80002f4c <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002f38:	00007797          	auipc	a5,0x7
    80002f3c:	5ea7b423          	sd	a0,1512(a5) # 8000a520 <_ZN9Scheduler4headE>
    }
}
    80002f40:	00813403          	ld	s0,8(sp)
    80002f44:	01010113          	addi	sp,sp,16
    80002f48:	00008067          	ret
        head = tail = process;
    80002f4c:	00007797          	auipc	a5,0x7
    80002f50:	5cc78793          	addi	a5,a5,1484 # 8000a518 <_ZN9Scheduler4tailE>
    80002f54:	00a7b023          	sd	a0,0(a5)
    80002f58:	00a7b423          	sd	a0,8(a5)
    80002f5c:	fe5ff06f          	j	80002f40 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002f60 <idleProcess>:
#include "../h/Cache.h"
#include "../h/slab.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    while(true) {}
    80002f6c:	0000006f          	j	80002f6c <idleProcess+0xc>

0000000080002f70 <_Z15userMainWrapperPv>:
    asm volatile("mv a0, %0" : : "r" (code));
    asm volatile("ecall");

}
void userMain();
void userMainWrapper(void*) {
    80002f70:	ff010113          	addi	sp,sp,-16
    80002f74:	00113423          	sd	ra,8(sp)
    80002f78:	00813023          	sd	s0,0(sp)
    80002f7c:	01010413          	addi	s0,sp,16
    //userMode(); // prelazak u user mod
    userMain();
    80002f80:	00000097          	auipc	ra,0x0
    80002f84:	b8c080e7          	jalr	-1140(ra) # 80002b0c <_Z8userMainv>
}
    80002f88:	00813083          	ld	ra,8(sp)
    80002f8c:	00013403          	ld	s0,0(sp)
    80002f90:	01010113          	addi	sp,sp,16
    80002f94:	00008067          	ret

0000000080002f98 <_Z8userModev>:
void userMode() {
    80002f98:	ff010113          	addi	sp,sp,-16
    80002f9c:	00813423          	sd	s0,8(sp)
    80002fa0:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80002fa4:	04300793          	li	a5,67
    80002fa8:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80002fac:	00000073          	ecall
}
    80002fb0:	00813403          	ld	s0,8(sp)
    80002fb4:	01010113          	addi	sp,sp,16
    80002fb8:	00008067          	ret

0000000080002fbc <main>:
}
// ------------

int main() {
    80002fbc:	ff010113          	addi	sp,sp,-16
    80002fc0:	00113423          	sd	ra,8(sp)
    80002fc4:	00813023          	sd	s0,0(sp)
    80002fc8:	01010413          	addi	s0,sp,16
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80002fcc:	00007797          	auipc	a5,0x7
    80002fd0:	42c7b783          	ld	a5,1068(a5) # 8000a3f8 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002fd4:	10579073          	csrw	stvec,a5
    kmem_init((void*)HEAP_START_ADDR, 1 << 24);
    80002fd8:	010005b7          	lui	a1,0x1000
    80002fdc:	00007797          	auipc	a5,0x7
    80002fe0:	3bc7b783          	ld	a5,956(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002fe4:	0007b503          	ld	a0,0(a5)
    80002fe8:	00002097          	auipc	ra,0x2
    80002fec:	984080e7          	jalr	-1660(ra) # 8000496c <_Z9kmem_initPvi>

    PCB* main = PCB::createSysProcess(nullptr, nullptr); // main proces(ne pravimo stek)
    80002ff0:	00000593          	li	a1,0
    80002ff4:	00000513          	li	a0,0
    80002ff8:	fffff097          	auipc	ra,0xfffff
    80002ffc:	e80080e7          	jalr	-384(ra) # 80001e78 <_ZN3PCB16createSysProcessEPFvvEPv>
    PCB::running = main;
    80003000:	00007797          	auipc	a5,0x7
    80003004:	3d87b783          	ld	a5,984(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003008:	00a7b023          	sd	a0,0(a5)
    CCB::inputProcces = PCB::createSysProcess(CCB::inputBody, nullptr);
    CCB::outputProcess = PCB::createSysProcess(CCB::outputBody, nullptr);
    Scheduler::put(CCB::inputProcces);
    Scheduler::put(CCB::outputProcess);
    Scheduler::idleProcess = PCB::createSysProcess(idleProcess, nullptr);*/
    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    8000300c:	00000613          	li	a2,0
    80003010:	00007597          	auipc	a1,0x7
    80003014:	3b85b583          	ld	a1,952(a1) # 8000a3c8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003018:	00007517          	auipc	a0,0x7
    8000301c:	3f853503          	ld	a0,1016(a0) # 8000a410 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003020:	ffffe097          	auipc	ra,0xffffe
    80003024:	2f0080e7          	jalr	752(ra) # 80001310 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    80003028:	00000613          	li	a2,0
    8000302c:	00007597          	auipc	a1,0x7
    80003030:	3dc5b583          	ld	a1,988(a1) # 8000a408 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003034:	00007517          	auipc	a0,0x7
    80003038:	35453503          	ld	a0,852(a0) # 8000a388 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000303c:	ffffe097          	auipc	ra,0xffffe
    80003040:	2d4080e7          	jalr	724(ra) # 80001310 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80003044:	00000613          	li	a2,0
    80003048:	00000597          	auipc	a1,0x0
    8000304c:	f1858593          	addi	a1,a1,-232 # 80002f60 <idleProcess>
    80003050:	00007517          	auipc	a0,0x7
    80003054:	38053503          	ld	a0,896(a0) # 8000a3d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003058:	ffffe097          	auipc	ra,0xffffe
    8000305c:	1b0080e7          	jalr	432(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    Scheduler::idleProcess->setFinished(true);
    80003060:	00007797          	auipc	a5,0x7
    80003064:	3707b783          	ld	a5,880(a5) # 8000a3d0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003068:	0007b783          	ld	a5,0(a5)
    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    }

    void setFinished(bool finished_) {
        finished = finished_;
    8000306c:	00100713          	li	a4,1
    80003070:	02e78423          	sb	a4,40(a5)
        timeSlice = timeSlice_;
    80003074:	00100713          	li	a4,1
    80003078:	04e7b023          	sd	a4,64(a5)
    Scheduler::idleProcess->setTimeSlice(1);

    //CCB::semInput = SCB::createSemaphore(0);
    sem_open(&CCB::semInput, 0);
    8000307c:	00000593          	li	a1,0
    80003080:	00007517          	auipc	a0,0x7
    80003084:	38053503          	ld	a0,896(a0) # 8000a400 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003088:	ffffe097          	auipc	ra,0xffffe
    8000308c:	2d8080e7          	jalr	728(ra) # 80001360 <_Z8sem_openPP3SCBj>
    //CCB::semOutput = SCB::createSemaphore(0);
    sem_open(&CCB::semOutput, 0);
    80003090:	00000593          	li	a1,0
    80003094:	00007517          	auipc	a0,0x7
    80003098:	35453503          	ld	a0,852(a0) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000309c:	ffffe097          	auipc	ra,0xffffe
    800030a0:	2c4080e7          	jalr	708(ra) # 80001360 <_Z8sem_openPP3SCBj>
    //CCB::inputBufferEmpty = SCB::createSemaphore(0);
    sem_open(&CCB::inputBufferEmpty, 0);
    800030a4:	00000593          	li	a1,0
    800030a8:	00007517          	auipc	a0,0x7
    800030ac:	34853503          	ld	a0,840(a0) # 8000a3f0 <_GLOBAL_OFFSET_TABLE_+0x78>
    800030b0:	ffffe097          	auipc	ra,0xffffe
    800030b4:	2b0080e7          	jalr	688(ra) # 80001360 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800030b8:	00200793          	li	a5,2
    800030bc:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&userProcess, userMainWrapper, nullptr);
    800030c0:	00000613          	li	a2,0
    800030c4:	00000597          	auipc	a1,0x0
    800030c8:	eac58593          	addi	a1,a1,-340 # 80002f70 <_Z15userMainWrapperPv>
    800030cc:	00007517          	auipc	a0,0x7
    800030d0:	46450513          	addi	a0,a0,1124 # 8000a530 <userProcess>
    800030d4:	ffffe097          	auipc	ra,0xffffe
    800030d8:	23c080e7          	jalr	572(ra) # 80001310 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----
    //kmem_cache_info(PCB::pcbCache);
    //kmem_cache_info(SCB::scbCache);
    while(!userProcess->isFinished()) {
    800030dc:	00007797          	auipc	a5,0x7
    800030e0:	4547b783          	ld	a5,1108(a5) # 8000a530 <userProcess>
        return finished;
    800030e4:	0287c783          	lbu	a5,40(a5)
    800030e8:	00079863          	bnez	a5,800030f8 <main+0x13c>
        thread_dispatch();
    800030ec:	ffffe097          	auipc	ra,0xffffe
    800030f0:	198080e7          	jalr	408(ra) # 80001284 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    800030f4:	fe9ff06f          	j	800030dc <main+0x120>
    }

    while(CCB::semOutput->getSemValue() != 0) {
    800030f8:	00007797          	auipc	a5,0x7
    800030fc:	2f07b783          	ld	a5,752(a5) # 8000a3e8 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003100:	0007b783          	ld	a5,0(a5)
#include "Scheduler.h"

class SCB { // Semaphore Control Block
public:
    int getSemValue() const {
        return semValue;
    80003104:	0107a783          	lw	a5,16(a5)
    80003108:	00078863          	beqz	a5,80003118 <main+0x15c>
        thread_dispatch();
    8000310c:	ffffe097          	auipc	ra,0xffffe
    80003110:	178080e7          	jalr	376(ra) # 80001284 <_Z15thread_dispatchv>
    while(CCB::semOutput->getSemValue() != 0) {
    80003114:	fe5ff06f          	j	800030f8 <main+0x13c>
    }
    return 0;
    80003118:	00000513          	li	a0,0
    8000311c:	00813083          	ld	ra,8(sp)
    80003120:	00013403          	ld	s0,0(sp)
    80003124:	01010113          	addi	sp,sp,16
    80003128:	00008067          	ret

000000008000312c <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    8000312c:	fe010113          	addi	sp,sp,-32
    80003130:	00113c23          	sd	ra,24(sp)
    80003134:	00813823          	sd	s0,16(sp)
    80003138:	00913423          	sd	s1,8(sp)
    8000313c:	02010413          	addi	s0,sp,32
    80003140:	00007797          	auipc	a5,0x7
    80003144:	19878793          	addi	a5,a5,408 # 8000a2d8 <_ZTV6Thread+0x10>
    80003148:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000314c:	00853483          	ld	s1,8(a0)
    80003150:	00048e63          	beqz	s1,8000316c <_ZN6ThreadD1Ev+0x40>
    80003154:	00048513          	mv	a0,s1
    80003158:	fffff097          	auipc	ra,0xfffff
    8000315c:	a90080e7          	jalr	-1392(ra) # 80001be8 <_ZN3PCBD1Ev>
    80003160:	00048513          	mv	a0,s1
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	af8080e7          	jalr	-1288(ra) # 80001c5c <_ZN3PCBdlEPv>
}
    8000316c:	01813083          	ld	ra,24(sp)
    80003170:	01013403          	ld	s0,16(sp)
    80003174:	00813483          	ld	s1,8(sp)
    80003178:	02010113          	addi	sp,sp,32
    8000317c:	00008067          	ret

0000000080003180 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80003180:	ff010113          	addi	sp,sp,-16
    80003184:	00113423          	sd	ra,8(sp)
    80003188:	00813023          	sd	s0,0(sp)
    8000318c:	01010413          	addi	s0,sp,16
    80003190:	00007797          	auipc	a5,0x7
    80003194:	17078793          	addi	a5,a5,368 # 8000a300 <_ZTV9Semaphore+0x10>
    80003198:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000319c:	00853503          	ld	a0,8(a0)
    800031a0:	ffffe097          	auipc	ra,0xffffe
    800031a4:	290080e7          	jalr	656(ra) # 80001430 <_Z9sem_closeP3SCB>
}
    800031a8:	00813083          	ld	ra,8(sp)
    800031ac:	00013403          	ld	s0,0(sp)
    800031b0:	01010113          	addi	sp,sp,16
    800031b4:	00008067          	ret

00000000800031b8 <_Znwm>:
void* operator new (size_t size) {
    800031b8:	ff010113          	addi	sp,sp,-16
    800031bc:	00113423          	sd	ra,8(sp)
    800031c0:	00813023          	sd	s0,0(sp)
    800031c4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800031c8:	ffffe097          	auipc	ra,0xffffe
    800031cc:	fcc080e7          	jalr	-52(ra) # 80001194 <_Z9mem_allocm>
}
    800031d0:	00813083          	ld	ra,8(sp)
    800031d4:	00013403          	ld	s0,0(sp)
    800031d8:	01010113          	addi	sp,sp,16
    800031dc:	00008067          	ret

00000000800031e0 <_Znam>:
void* operator new [](size_t size) {
    800031e0:	ff010113          	addi	sp,sp,-16
    800031e4:	00113423          	sd	ra,8(sp)
    800031e8:	00813023          	sd	s0,0(sp)
    800031ec:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	fa4080e7          	jalr	-92(ra) # 80001194 <_Z9mem_allocm>
}
    800031f8:	00813083          	ld	ra,8(sp)
    800031fc:	00013403          	ld	s0,0(sp)
    80003200:	01010113          	addi	sp,sp,16
    80003204:	00008067          	ret

0000000080003208 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80003208:	ff010113          	addi	sp,sp,-16
    8000320c:	00113423          	sd	ra,8(sp)
    80003210:	00813023          	sd	s0,0(sp)
    80003214:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80003218:	ffffe097          	auipc	ra,0xffffe
    8000321c:	fbc080e7          	jalr	-68(ra) # 800011d4 <_Z8mem_freePv>
}
    80003220:	00813083          	ld	ra,8(sp)
    80003224:	00013403          	ld	s0,0(sp)
    80003228:	01010113          	addi	sp,sp,16
    8000322c:	00008067          	ret

0000000080003230 <_Z13threadWrapperPv>:
    if(!tArg) return;
    80003230:	06050263          	beqz	a0,80003294 <_Z13threadWrapperPv+0x64>
void threadWrapper(void* thread) {
    80003234:	fe010113          	addi	sp,sp,-32
    80003238:	00113c23          	sd	ra,24(sp)
    8000323c:	00813823          	sd	s0,16(sp)
    80003240:	00913423          	sd	s1,8(sp)
    80003244:	02010413          	addi	s0,sp,32
    80003248:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    8000324c:	00053503          	ld	a0,0(a0)
    80003250:	0104b783          	ld	a5,16(s1)
    80003254:	00f50533          	add	a0,a0,a5
    80003258:	0084b783          	ld	a5,8(s1)
    8000325c:	0017f713          	andi	a4,a5,1
    80003260:	00070863          	beqz	a4,80003270 <_Z13threadWrapperPv+0x40>
    80003264:	00053703          	ld	a4,0(a0)
    80003268:	00f707b3          	add	a5,a4,a5
    8000326c:	fff7b783          	ld	a5,-1(a5)
    80003270:	000780e7          	jalr	a5
    delete tArg;
    80003274:	00048513          	mv	a0,s1
    80003278:	00000097          	auipc	ra,0x0
    8000327c:	f90080e7          	jalr	-112(ra) # 80003208 <_ZdlPv>
}
    80003280:	01813083          	ld	ra,24(sp)
    80003284:	01013403          	ld	s0,16(sp)
    80003288:	00813483          	ld	s1,8(sp)
    8000328c:	02010113          	addi	sp,sp,32
    80003290:	00008067          	ret
    80003294:	00008067          	ret

0000000080003298 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80003298:	ff010113          	addi	sp,sp,-16
    8000329c:	00113423          	sd	ra,8(sp)
    800032a0:	00813023          	sd	s0,0(sp)
    800032a4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800032a8:	ffffe097          	auipc	ra,0xffffe
    800032ac:	f2c080e7          	jalr	-212(ra) # 800011d4 <_Z8mem_freePv>
}
    800032b0:	00813083          	ld	ra,8(sp)
    800032b4:	00013403          	ld	s0,0(sp)
    800032b8:	01010113          	addi	sp,sp,16
    800032bc:	00008067          	ret

00000000800032c0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800032c0:	ff010113          	addi	sp,sp,-16
    800032c4:	00113423          	sd	ra,8(sp)
    800032c8:	00813023          	sd	s0,0(sp)
    800032cc:	01010413          	addi	s0,sp,16
    800032d0:	00007797          	auipc	a5,0x7
    800032d4:	00878793          	addi	a5,a5,8 # 8000a2d8 <_ZTV6Thread+0x10>
    800032d8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    800032dc:	00850513          	addi	a0,a0,8
    800032e0:	ffffe097          	auipc	ra,0xffffe
    800032e4:	f28080e7          	jalr	-216(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800032e8:	00813083          	ld	ra,8(sp)
    800032ec:	00013403          	ld	s0,0(sp)
    800032f0:	01010113          	addi	sp,sp,16
    800032f4:	00008067          	ret

00000000800032f8 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    800032f8:	ff010113          	addi	sp,sp,-16
    800032fc:	00113423          	sd	ra,8(sp)
    80003300:	00813023          	sd	s0,0(sp)
    80003304:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80003308:	00001097          	auipc	ra,0x1
    8000330c:	2f4080e7          	jalr	756(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
}
    80003310:	00813083          	ld	ra,8(sp)
    80003314:	00013403          	ld	s0,0(sp)
    80003318:	01010113          	addi	sp,sp,16
    8000331c:	00008067          	ret

0000000080003320 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80003320:	ff010113          	addi	sp,sp,-16
    80003324:	00113423          	sd	ra,8(sp)
    80003328:	00813023          	sd	s0,0(sp)
    8000332c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80003330:	00001097          	auipc	ra,0x1
    80003334:	460080e7          	jalr	1120(ra) # 80004790 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003338:	00813083          	ld	ra,8(sp)
    8000333c:	00013403          	ld	s0,0(sp)
    80003340:	01010113          	addi	sp,sp,16
    80003344:	00008067          	ret

0000000080003348 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003348:	fe010113          	addi	sp,sp,-32
    8000334c:	00113c23          	sd	ra,24(sp)
    80003350:	00813823          	sd	s0,16(sp)
    80003354:	00913423          	sd	s1,8(sp)
    80003358:	02010413          	addi	s0,sp,32
    8000335c:	00050493          	mv	s1,a0
}
    80003360:	00000097          	auipc	ra,0x0
    80003364:	dcc080e7          	jalr	-564(ra) # 8000312c <_ZN6ThreadD1Ev>
    80003368:	00048513          	mv	a0,s1
    8000336c:	00000097          	auipc	ra,0x0
    80003370:	fb4080e7          	jalr	-76(ra) # 80003320 <_ZN6ThreaddlEPv>
    80003374:	01813083          	ld	ra,24(sp)
    80003378:	01013403          	ld	s0,16(sp)
    8000337c:	00813483          	ld	s1,8(sp)
    80003380:	02010113          	addi	sp,sp,32
    80003384:	00008067          	ret

0000000080003388 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003388:	ff010113          	addi	sp,sp,-16
    8000338c:	00113423          	sd	ra,8(sp)
    80003390:	00813023          	sd	s0,0(sp)
    80003394:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003398:	ffffe097          	auipc	ra,0xffffe
    8000339c:	eec080e7          	jalr	-276(ra) # 80001284 <_Z15thread_dispatchv>
}
    800033a0:	00813083          	ld	ra,8(sp)
    800033a4:	00013403          	ld	s0,0(sp)
    800033a8:	01010113          	addi	sp,sp,16
    800033ac:	00008067          	ret

00000000800033b0 <_ZN6Thread5startEv>:
    if(myHandle == 0) return -1;
    800033b0:	00853783          	ld	a5,8(a0)
    800033b4:	02078a63          	beqz	a5,800033e8 <_ZN6Thread5startEv+0x38>
int Thread::start() {
    800033b8:	ff010113          	addi	sp,sp,-16
    800033bc:	00113423          	sd	ra,8(sp)
    800033c0:	00813023          	sd	s0,0(sp)
    800033c4:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    800033c8:	00850513          	addi	a0,a0,8
    800033cc:	ffffe097          	auipc	ra,0xffffe
    800033d0:	f14080e7          	jalr	-236(ra) # 800012e0 <_Z12thread_startPP3PCB>
    return 0;
    800033d4:	00000513          	li	a0,0
}
    800033d8:	00813083          	ld	ra,8(sp)
    800033dc:	00013403          	ld	s0,0(sp)
    800033e0:	01010113          	addi	sp,sp,16
    800033e4:	00008067          	ret
    if(myHandle == 0) return -1;
    800033e8:	fff00513          	li	a0,-1
}
    800033ec:	00008067          	ret

00000000800033f0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800033f0:	fe010113          	addi	sp,sp,-32
    800033f4:	00113c23          	sd	ra,24(sp)
    800033f8:	00813823          	sd	s0,16(sp)
    800033fc:	00913423          	sd	s1,8(sp)
    80003400:	02010413          	addi	s0,sp,32
    80003404:	00050493          	mv	s1,a0
    80003408:	00007797          	auipc	a5,0x7
    8000340c:	ed078793          	addi	a5,a5,-304 # 8000a2d8 <_ZTV6Thread+0x10>
    80003410:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    80003414:	01800513          	li	a0,24
    80003418:	00000097          	auipc	ra,0x0
    8000341c:	da0080e7          	jalr	-608(ra) # 800031b8 <_Znwm>
    80003420:	00050613          	mv	a2,a0
    80003424:	00050a63          	beqz	a0,80003438 <_ZN6ThreadC1Ev+0x48>
    80003428:	00953023          	sd	s1,0(a0)
    8000342c:	01100793          	li	a5,17
    80003430:	00f53423          	sd	a5,8(a0)
    80003434:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    80003438:	00000597          	auipc	a1,0x0
    8000343c:	df858593          	addi	a1,a1,-520 # 80003230 <_Z13threadWrapperPv>
    80003440:	00848513          	addi	a0,s1,8
    80003444:	ffffe097          	auipc	ra,0xffffe
    80003448:	dc4080e7          	jalr	-572(ra) # 80001208 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    8000344c:	01813083          	ld	ra,24(sp)
    80003450:	01013403          	ld	s0,16(sp)
    80003454:	00813483          	ld	s1,8(sp)
    80003458:	02010113          	addi	sp,sp,32
    8000345c:	00008067          	ret

0000000080003460 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003460:	ff010113          	addi	sp,sp,-16
    80003464:	00113423          	sd	ra,8(sp)
    80003468:	00813023          	sd	s0,0(sp)
    8000346c:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003470:	ffffe097          	auipc	ra,0xffffe
    80003474:	000080e7          	jalr	ra # 80001470 <_Z10time_sleepm>
}
    80003478:	00813083          	ld	ra,8(sp)
    8000347c:	00013403          	ld	s0,0(sp)
    80003480:	01010113          	addi	sp,sp,16
    80003484:	00008067          	ret

0000000080003488 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80003488:	fe010113          	addi	sp,sp,-32
    8000348c:	00113c23          	sd	ra,24(sp)
    80003490:	00813823          	sd	s0,16(sp)
    80003494:	00913423          	sd	s1,8(sp)
    80003498:	02010413          	addi	s0,sp,32
    8000349c:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    800034a0:	0200006f          	j	800034c0 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800034a4:	00053703          	ld	a4,0(a0)
    800034a8:	00f707b3          	add	a5,a4,a5
    800034ac:	fff7b783          	ld	a5,-1(a5)
    800034b0:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    800034b4:	0184b503          	ld	a0,24(s1)
    800034b8:	00000097          	auipc	ra,0x0
    800034bc:	fa8080e7          	jalr	-88(ra) # 80003460 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    800034c0:	0004b503          	ld	a0,0(s1)
    800034c4:	0104b783          	ld	a5,16(s1)
    800034c8:	00f50533          	add	a0,a0,a5
    800034cc:	0084b783          	ld	a5,8(s1)
    800034d0:	0017f713          	andi	a4,a5,1
    800034d4:	fc070ee3          	beqz	a4,800034b0 <_Z21periodicThreadWrapperPv+0x28>
    800034d8:	fcdff06f          	j	800034a4 <_Z21periodicThreadWrapperPv+0x1c>

00000000800034dc <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800034dc:	fe010113          	addi	sp,sp,-32
    800034e0:	00113c23          	sd	ra,24(sp)
    800034e4:	00813823          	sd	s0,16(sp)
    800034e8:	00913423          	sd	s1,8(sp)
    800034ec:	02010413          	addi	s0,sp,32
    800034f0:	00050493          	mv	s1,a0
    800034f4:	00007797          	auipc	a5,0x7
    800034f8:	e0c78793          	addi	a5,a5,-500 # 8000a300 <_ZTV9Semaphore+0x10>
    800034fc:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80003500:	00058513          	mv	a0,a1
    80003504:	00000097          	auipc	ra,0x0
    80003508:	51c080e7          	jalr	1308(ra) # 80003a20 <_ZN3SCB15createSemaphoreEi>
    8000350c:	00a4b423          	sd	a0,8(s1)
}
    80003510:	01813083          	ld	ra,24(sp)
    80003514:	01013403          	ld	s0,16(sp)
    80003518:	00813483          	ld	s1,8(sp)
    8000351c:	02010113          	addi	sp,sp,32
    80003520:	00008067          	ret

0000000080003524 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80003524:	ff010113          	addi	sp,sp,-16
    80003528:	00113423          	sd	ra,8(sp)
    8000352c:	00813023          	sd	s0,0(sp)
    80003530:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003534:	00853503          	ld	a0,8(a0)
    80003538:	ffffe097          	auipc	ra,0xffffe
    8000353c:	e70080e7          	jalr	-400(ra) # 800013a8 <_Z8sem_waitP3SCB>
}
    80003540:	00813083          	ld	ra,8(sp)
    80003544:	00013403          	ld	s0,0(sp)
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret

0000000080003550 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003550:	ff010113          	addi	sp,sp,-16
    80003554:	00113423          	sd	ra,8(sp)
    80003558:	00813023          	sd	s0,0(sp)
    8000355c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003560:	00853503          	ld	a0,8(a0)
    80003564:	ffffe097          	auipc	ra,0xffffe
    80003568:	e8c080e7          	jalr	-372(ra) # 800013f0 <_Z10sem_signalP3SCB>
}
    8000356c:	00813083          	ld	ra,8(sp)
    80003570:	00013403          	ld	s0,0(sp)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    8000357c:	ff010113          	addi	sp,sp,-16
    80003580:	00113423          	sd	ra,8(sp)
    80003584:	00813023          	sd	s0,0(sp)
    80003588:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    8000358c:	00001097          	auipc	ra,0x1
    80003590:	204080e7          	jalr	516(ra) # 80004790 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80003594:	00813083          	ld	ra,8(sp)
    80003598:	00013403          	ld	s0,0(sp)
    8000359c:	01010113          	addi	sp,sp,16
    800035a0:	00008067          	ret

00000000800035a4 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    800035a4:	fe010113          	addi	sp,sp,-32
    800035a8:	00113c23          	sd	ra,24(sp)
    800035ac:	00813823          	sd	s0,16(sp)
    800035b0:	00913423          	sd	s1,8(sp)
    800035b4:	02010413          	addi	s0,sp,32
    800035b8:	00050493          	mv	s1,a0
}
    800035bc:	00000097          	auipc	ra,0x0
    800035c0:	bc4080e7          	jalr	-1084(ra) # 80003180 <_ZN9SemaphoreD1Ev>
    800035c4:	00048513          	mv	a0,s1
    800035c8:	00000097          	auipc	ra,0x0
    800035cc:	fb4080e7          	jalr	-76(ra) # 8000357c <_ZN9SemaphoredlEPv>
    800035d0:	01813083          	ld	ra,24(sp)
    800035d4:	01013403          	ld	s0,16(sp)
    800035d8:	00813483          	ld	s1,8(sp)
    800035dc:	02010113          	addi	sp,sp,32
    800035e0:	00008067          	ret

00000000800035e4 <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    800035e4:	ff010113          	addi	sp,sp,-16
    800035e8:	00113423          	sd	ra,8(sp)
    800035ec:	00813023          	sd	s0,0(sp)
    800035f0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800035f4:	00001097          	auipc	ra,0x1
    800035f8:	008080e7          	jalr	8(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
}
    800035fc:	00813083          	ld	ra,8(sp)
    80003600:	00013403          	ld	s0,0(sp)
    80003604:	01010113          	addi	sp,sp,16
    80003608:	00008067          	ret

000000008000360c <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    8000360c:	fe010113          	addi	sp,sp,-32
    80003610:	00113c23          	sd	ra,24(sp)
    80003614:	00813823          	sd	s0,16(sp)
    80003618:	00913423          	sd	s1,8(sp)
    8000361c:	01213023          	sd	s2,0(sp)
    80003620:	02010413          	addi	s0,sp,32
    80003624:	00050493          	mv	s1,a0
    80003628:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    8000362c:	02000513          	li	a0,32
    80003630:	00000097          	auipc	ra,0x0
    80003634:	b88080e7          	jalr	-1144(ra) # 800031b8 <_Znwm>
    80003638:	00050613          	mv	a2,a0
    8000363c:	00050c63          	beqz	a0,80003654 <_ZN14PeriodicThreadC1Em+0x48>
    80003640:	00953023          	sd	s1,0(a0)
    80003644:	01900793          	li	a5,25
    80003648:	00f53423          	sd	a5,8(a0)
    8000364c:	00053823          	sd	zero,16(a0)
    80003650:	01253c23          	sd	s2,24(a0)
    80003654:	00000597          	auipc	a1,0x0
    80003658:	e3458593          	addi	a1,a1,-460 # 80003488 <_Z21periodicThreadWrapperPv>
    8000365c:	00048513          	mv	a0,s1
    80003660:	00000097          	auipc	ra,0x0
    80003664:	c60080e7          	jalr	-928(ra) # 800032c0 <_ZN6ThreadC1EPFvPvES0_>
    80003668:	00007797          	auipc	a5,0x7
    8000366c:	c4078793          	addi	a5,a5,-960 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    80003670:	00f4b023          	sd	a5,0(s1)
{}
    80003674:	01813083          	ld	ra,24(sp)
    80003678:	01013403          	ld	s0,16(sp)
    8000367c:	00813483          	ld	s1,8(sp)
    80003680:	00013903          	ld	s2,0(sp)
    80003684:	02010113          	addi	sp,sp,32
    80003688:	00008067          	ret

000000008000368c <_ZN7Console4getcEv>:


char Console::getc() {
    8000368c:	ff010113          	addi	sp,sp,-16
    80003690:	00113423          	sd	ra,8(sp)
    80003694:	00813023          	sd	s0,0(sp)
    80003698:	01010413          	addi	s0,sp,16
    return ::getc();
    8000369c:	ffffe097          	auipc	ra,0xffffe
    800036a0:	e1c080e7          	jalr	-484(ra) # 800014b8 <_Z4getcv>
}
    800036a4:	00813083          	ld	ra,8(sp)
    800036a8:	00013403          	ld	s0,0(sp)
    800036ac:	01010113          	addi	sp,sp,16
    800036b0:	00008067          	ret

00000000800036b4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800036b4:	ff010113          	addi	sp,sp,-16
    800036b8:	00113423          	sd	ra,8(sp)
    800036bc:	00813023          	sd	s0,0(sp)
    800036c0:	01010413          	addi	s0,sp,16
    return ::putc(c);
    800036c4:	ffffe097          	auipc	ra,0xffffe
    800036c8:	e24080e7          	jalr	-476(ra) # 800014e8 <_Z4putcc>
}
    800036cc:	00813083          	ld	ra,8(sp)
    800036d0:	00013403          	ld	s0,0(sp)
    800036d4:	01010113          	addi	sp,sp,16
    800036d8:	00008067          	ret

00000000800036dc <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    800036dc:	ff010113          	addi	sp,sp,-16
    800036e0:	00813423          	sd	s0,8(sp)
    800036e4:	01010413          	addi	s0,sp,16
    800036e8:	00813403          	ld	s0,8(sp)
    800036ec:	01010113          	addi	sp,sp,16
    800036f0:	00008067          	ret

00000000800036f4 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    800036f4:	ff010113          	addi	sp,sp,-16
    800036f8:	00813423          	sd	s0,8(sp)
    800036fc:	01010413          	addi	s0,sp,16
    80003700:	00813403          	ld	s0,8(sp)
    80003704:	01010113          	addi	sp,sp,16
    80003708:	00008067          	ret

000000008000370c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    8000370c:	ff010113          	addi	sp,sp,-16
    80003710:	00113423          	sd	ra,8(sp)
    80003714:	00813023          	sd	s0,0(sp)
    80003718:	01010413          	addi	s0,sp,16
    8000371c:	00007797          	auipc	a5,0x7
    80003720:	b8c78793          	addi	a5,a5,-1140 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    80003724:	00f53023          	sd	a5,0(a0)
    80003728:	00000097          	auipc	ra,0x0
    8000372c:	a04080e7          	jalr	-1532(ra) # 8000312c <_ZN6ThreadD1Ev>
    80003730:	00813083          	ld	ra,8(sp)
    80003734:	00013403          	ld	s0,0(sp)
    80003738:	01010113          	addi	sp,sp,16
    8000373c:	00008067          	ret

0000000080003740 <_ZN14PeriodicThreadD0Ev>:
    80003740:	fe010113          	addi	sp,sp,-32
    80003744:	00113c23          	sd	ra,24(sp)
    80003748:	00813823          	sd	s0,16(sp)
    8000374c:	00913423          	sd	s1,8(sp)
    80003750:	02010413          	addi	s0,sp,32
    80003754:	00050493          	mv	s1,a0
    80003758:	00007797          	auipc	a5,0x7
    8000375c:	b5078793          	addi	a5,a5,-1200 # 8000a2a8 <_ZTV14PeriodicThread+0x10>
    80003760:	00f53023          	sd	a5,0(a0)
    80003764:	00000097          	auipc	ra,0x0
    80003768:	9c8080e7          	jalr	-1592(ra) # 8000312c <_ZN6ThreadD1Ev>
    8000376c:	00048513          	mv	a0,s1
    80003770:	00000097          	auipc	ra,0x0
    80003774:	bb0080e7          	jalr	-1104(ra) # 80003320 <_ZN6ThreaddlEPv>
    80003778:	01813083          	ld	ra,24(sp)
    8000377c:	01013403          	ld	s0,16(sp)
    80003780:	00813483          	ld	s1,8(sp)
    80003784:	02010113          	addi	sp,sp,32
    80003788:	00008067          	ret

000000008000378c <_ZN3SCB5blockEv>:
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

kmem_cache_t* SCB::scbCache = nullptr;

void SCB::block() {
    8000378c:	ff010113          	addi	sp,sp,-16
    80003790:	00813423          	sd	s0,8(sp)
    80003794:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80003798:	00007797          	auipc	a5,0x7
    8000379c:	c407b783          	ld	a5,-960(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037a0:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    800037a4:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800037a8:	00853783          	ld	a5,8(a0)
    800037ac:	04078063          	beqz	a5,800037ec <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    800037b0:	00007717          	auipc	a4,0x7
    800037b4:	c2873703          	ld	a4,-984(a4) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037b8:	00073703          	ld	a4,0(a4)
    800037bc:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    800037c0:	00853783          	ld	a5,8(a0)
        return nextInList;
    800037c4:	0007b783          	ld	a5,0(a5)
    800037c8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    800037cc:	00007797          	auipc	a5,0x7
    800037d0:	c0c7b783          	ld	a5,-1012(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037d4:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    800037d8:	00100713          	li	a4,1
    800037dc:	02e784a3          	sb	a4,41(a5)
}
    800037e0:	00813403          	ld	s0,8(sp)
    800037e4:	01010113          	addi	sp,sp,16
    800037e8:	00008067          	ret
        head = tail = PCB::running;
    800037ec:	00007797          	auipc	a5,0x7
    800037f0:	bec7b783          	ld	a5,-1044(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037f4:	0007b783          	ld	a5,0(a5)
    800037f8:	00f53423          	sd	a5,8(a0)
    800037fc:	00f53023          	sd	a5,0(a0)
    80003800:	fcdff06f          	j	800037cc <_ZN3SCB5blockEv+0x40>

0000000080003804 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80003804:	ff010113          	addi	sp,sp,-16
    80003808:	00813423          	sd	s0,8(sp)
    8000380c:	01010413          	addi	s0,sp,16
    80003810:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80003814:	00053503          	ld	a0,0(a0)
    80003818:	00050e63          	beqz	a0,80003834 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    8000381c:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    80003820:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80003824:	0087b683          	ld	a3,8(a5)
    80003828:	00d50c63          	beq	a0,a3,80003840 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    8000382c:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80003830:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    80003834:	00813403          	ld	s0,8(sp)
    80003838:	01010113          	addi	sp,sp,16
    8000383c:	00008067          	ret
        tail = head;
    80003840:	00e7b423          	sd	a4,8(a5)
    80003844:	fe9ff06f          	j	8000382c <_ZN3SCB7unblockEv+0x28>

0000000080003848 <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    80003848:	01052783          	lw	a5,16(a0)
    8000384c:	fff7879b          	addiw	a5,a5,-1
    80003850:	00f52823          	sw	a5,16(a0)
    80003854:	02079713          	slli	a4,a5,0x20
    80003858:	02074063          	bltz	a4,80003878 <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    8000385c:	00007797          	auipc	a5,0x7
    80003860:	b7c7b783          	ld	a5,-1156(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003864:	0007b783          	ld	a5,0(a5)
    80003868:	02a7c783          	lbu	a5,42(a5)
    8000386c:	06079463          	bnez	a5,800038d4 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80003870:	00000513          	li	a0,0
    80003874:	00008067          	ret
int SCB::wait() {
    80003878:	ff010113          	addi	sp,sp,-16
    8000387c:	00113423          	sd	ra,8(sp)
    80003880:	00813023          	sd	s0,0(sp)
    80003884:	01010413          	addi	s0,sp,16
        block();
    80003888:	00000097          	auipc	ra,0x0
    8000388c:	f04080e7          	jalr	-252(ra) # 8000378c <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80003890:	00007797          	auipc	a5,0x7
    80003894:	b287b783          	ld	a5,-1240(a5) # 8000a3b8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003898:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    8000389c:	ffffe097          	auipc	ra,0xffffe
    800038a0:	2bc080e7          	jalr	700(ra) # 80001b58 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    800038a4:	00007797          	auipc	a5,0x7
    800038a8:	b347b783          	ld	a5,-1228(a5) # 8000a3d8 <_GLOBAL_OFFSET_TABLE_+0x60>
    800038ac:	0007b783          	ld	a5,0(a5)
    800038b0:	02a7c783          	lbu	a5,42(a5)
    800038b4:	00079c63          	bnez	a5,800038cc <_ZN3SCB4waitEv+0x84>
    return 0;
    800038b8:	00000513          	li	a0,0

}
    800038bc:	00813083          	ld	ra,8(sp)
    800038c0:	00013403          	ld	s0,0(sp)
    800038c4:	01010113          	addi	sp,sp,16
    800038c8:	00008067          	ret
        return -2;
    800038cc:	ffe00513          	li	a0,-2
    800038d0:	fedff06f          	j	800038bc <_ZN3SCB4waitEv+0x74>
    800038d4:	ffe00513          	li	a0,-2
}
    800038d8:	00008067          	ret

00000000800038dc <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    800038dc:	01052783          	lw	a5,16(a0)
    800038e0:	0017879b          	addiw	a5,a5,1
    800038e4:	0007871b          	sext.w	a4,a5
    800038e8:	00f52823          	sw	a5,16(a0)
    800038ec:	00e05463          	blez	a4,800038f4 <_ZN3SCB6signalEv+0x18>
    800038f0:	00008067          	ret
void SCB::signal() {
    800038f4:	ff010113          	addi	sp,sp,-16
    800038f8:	00113423          	sd	ra,8(sp)
    800038fc:	00813023          	sd	s0,0(sp)
    80003900:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    80003904:	00000097          	auipc	ra,0x0
    80003908:	f00080e7          	jalr	-256(ra) # 80003804 <_ZN3SCB7unblockEv>
    8000390c:	fffff097          	auipc	ra,0xfffff
    80003910:	560080e7          	jalr	1376(ra) # 80002e6c <_ZN9Scheduler3putEP3PCB>
    }

}
    80003914:	00813083          	ld	ra,8(sp)
    80003918:	00013403          	ld	s0,0(sp)
    8000391c:	01010113          	addi	sp,sp,16
    80003920:	00008067          	ret

0000000080003924 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    80003924:	01052783          	lw	a5,16(a0)
    80003928:	0017879b          	addiw	a5,a5,1
    8000392c:	0007871b          	sext.w	a4,a5
    80003930:	00f52823          	sw	a5,16(a0)
    80003934:	00e05463          	blez	a4,8000393c <_ZN3SCB14prioritySignalEv+0x18>
    80003938:	00008067          	ret
void SCB::prioritySignal() {
    8000393c:	ff010113          	addi	sp,sp,-16
    80003940:	00113423          	sd	ra,8(sp)
    80003944:	00813023          	sd	s0,0(sp)
    80003948:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    8000394c:	00000097          	auipc	ra,0x0
    80003950:	eb8080e7          	jalr	-328(ra) # 80003804 <_ZN3SCB7unblockEv>
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	5c4080e7          	jalr	1476(ra) # 80002f18 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    8000395c:	00813083          	ld	ra,8(sp)
    80003960:	00013403          	ld	s0,0(sp)
    80003964:	01010113          	addi	sp,sp,16
    80003968:	00008067          	ret

000000008000396c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000396c:	ff010113          	addi	sp,sp,-16
    80003970:	00113423          	sd	ra,8(sp)
    80003974:	00813023          	sd	s0,0(sp)
    80003978:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000397c:	00001097          	auipc	ra,0x1
    80003980:	c80080e7          	jalr	-896(ra) # 800045fc <_ZN15MemoryAllocator9mem_allocEm>
}
    80003984:	00813083          	ld	ra,8(sp)
    80003988:	00013403          	ld	s0,0(sp)
    8000398c:	01010113          	addi	sp,sp,16
    80003990:	00008067          	ret

0000000080003994 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80003994:	ff010113          	addi	sp,sp,-16
    80003998:	00113423          	sd	ra,8(sp)
    8000399c:	00813023          	sd	s0,0(sp)
    800039a0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800039a4:	00001097          	auipc	ra,0x1
    800039a8:	dec080e7          	jalr	-532(ra) # 80004790 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800039ac:	00813083          	ld	ra,8(sp)
    800039b0:	00013403          	ld	s0,0(sp)
    800039b4:	01010113          	addi	sp,sp,16
    800039b8:	00008067          	ret

00000000800039bc <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800039bc:	fe010113          	addi	sp,sp,-32
    800039c0:	00113c23          	sd	ra,24(sp)
    800039c4:	00813823          	sd	s0,16(sp)
    800039c8:	00913423          	sd	s1,8(sp)
    800039cc:	01213023          	sd	s2,0(sp)
    800039d0:	02010413          	addi	s0,sp,32
    800039d4:	00050913          	mv	s2,a0
    PCB* curr = head;
    800039d8:	00053503          	ld	a0,0(a0)
    while(curr) {
    800039dc:	02050263          	beqz	a0,80003a00 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    800039e0:	00100793          	li	a5,1
    800039e4:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    800039e8:	020504a3          	sb	zero,41(a0)
        return nextInList;
    800039ec:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    800039f0:	fffff097          	auipc	ra,0xfffff
    800039f4:	47c080e7          	jalr	1148(ra) # 80002e6c <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800039f8:	00048513          	mv	a0,s1
    while(curr) {
    800039fc:	fe1ff06f          	j	800039dc <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80003a00:	00093423          	sd	zero,8(s2)
    80003a04:	00093023          	sd	zero,0(s2)
}
    80003a08:	01813083          	ld	ra,24(sp)
    80003a0c:	01013403          	ld	s0,16(sp)
    80003a10:	00813483          	ld	s1,8(sp)
    80003a14:	00013903          	ld	s2,0(sp)
    80003a18:	02010113          	addi	sp,sp,32
    80003a1c:	00008067          	ret

0000000080003a20 <_ZN3SCB15createSemaphoreEi>:
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    object->scbInit(semValue);
    return object;
}

SCB *SCB::createSemaphore(int semValue) {
    80003a20:	fe010113          	addi	sp,sp,-32
    80003a24:	00113c23          	sd	ra,24(sp)
    80003a28:	00813823          	sd	s0,16(sp)
    80003a2c:	00913423          	sd	s1,8(sp)
    80003a30:	02010413          	addi	s0,sp,32
    80003a34:	00050493          	mv	s1,a0
    return new SCB(semValue);
    80003a38:	01800513          	li	a0,24
    80003a3c:	00000097          	auipc	ra,0x0
    80003a40:	f30080e7          	jalr	-208(ra) # 8000396c <_ZN3SCBnwEm>
    80003a44:	00050863          	beqz	a0,80003a54 <_ZN3SCB15createSemaphoreEi+0x34>
    static kmem_cache_t* scbCache;//TODO private
    static void initSCBCache();
private:

    void scbInit(int semValue);
    SCB(int semValue_ = 1) {
    80003a48:	00053023          	sd	zero,0(a0)
    80003a4c:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80003a50:	00952823          	sw	s1,16(a0)
}
    80003a54:	01813083          	ld	ra,24(sp)
    80003a58:	01013403          	ld	s0,16(sp)
    80003a5c:	00813483          	ld	s1,8(sp)
    80003a60:	02010113          	addi	sp,sp,32
    80003a64:	00008067          	ret

0000000080003a68 <_ZN3SCB7scbInitEi>:

void SCB::scbInit(int semValue_) {
    80003a68:	ff010113          	addi	sp,sp,-16
    80003a6c:	00813423          	sd	s0,8(sp)
    80003a70:	01010413          	addi	s0,sp,16
    head = tail = nullptr;
    80003a74:	00053423          	sd	zero,8(a0)
    80003a78:	00053023          	sd	zero,0(a0)
    semValue = semValue_;
    80003a7c:	00b52823          	sw	a1,16(a0)
}
    80003a80:	00813403          	ld	s0,8(sp)
    80003a84:	01010113          	addi	sp,sp,16
    80003a88:	00008067          	ret

0000000080003a8c <_ZN3SCB12initSCBCacheEv>:

void SCB::initSCBCache() {
    80003a8c:	ff010113          	addi	sp,sp,-16
    80003a90:	00113423          	sd	ra,8(sp)
    80003a94:	00813023          	sd	s0,0(sp)
    80003a98:	01010413          	addi	s0,sp,16
    scbCache = kmem_cache_create("SCB", sizeof(SCB), &createObject, &freeObject);
    80003a9c:	00000697          	auipc	a3,0x0
    80003aa0:	0c468693          	addi	a3,a3,196 # 80003b60 <_ZN3SCB10freeObjectEPv>
    80003aa4:	00000617          	auipc	a2,0x0
    80003aa8:	0a460613          	addi	a2,a2,164 # 80003b48 <_ZN3SCB12createObjectEPv>
    80003aac:	01800593          	li	a1,24
    80003ab0:	00004517          	auipc	a0,0x4
    80003ab4:	6e050513          	addi	a0,a0,1760 # 80008190 <CONSOLE_STATUS+0x180>
    80003ab8:	00001097          	auipc	ra,0x1
    80003abc:	edc080e7          	jalr	-292(ra) # 80004994 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003ac0:	00007797          	auipc	a5,0x7
    80003ac4:	a6a7bc23          	sd	a0,-1416(a5) # 8000a538 <_ZN3SCB8scbCacheE>
}
    80003ac8:	00813083          	ld	ra,8(sp)
    80003acc:	00013403          	ld	s0,0(sp)
    80003ad0:	01010113          	addi	sp,sp,16
    80003ad4:	00008067          	ret

0000000080003ad8 <_ZN3SCB18createSysSemaphoreEi>:
SCB *SCB::createSysSemaphore(int semValue) {
    80003ad8:	fe010113          	addi	sp,sp,-32
    80003adc:	00113c23          	sd	ra,24(sp)
    80003ae0:	00813823          	sd	s0,16(sp)
    80003ae4:	00913423          	sd	s1,8(sp)
    80003ae8:	01213023          	sd	s2,0(sp)
    80003aec:	02010413          	addi	s0,sp,32
    80003af0:	00050913          	mv	s2,a0
    if(!scbCache) initSCBCache();
    80003af4:	00007797          	auipc	a5,0x7
    80003af8:	a447b783          	ld	a5,-1468(a5) # 8000a538 <_ZN3SCB8scbCacheE>
    80003afc:	04078063          	beqz	a5,80003b3c <_ZN3SCB18createSysSemaphoreEi+0x64>
    SCB* object = (SCB*) kmem_cache_alloc(scbCache);
    80003b00:	00007517          	auipc	a0,0x7
    80003b04:	a3853503          	ld	a0,-1480(a0) # 8000a538 <_ZN3SCB8scbCacheE>
    80003b08:	00001097          	auipc	ra,0x1
    80003b0c:	edc080e7          	jalr	-292(ra) # 800049e4 <_Z16kmem_cache_allocP12kmem_cache_s>
    80003b10:	00050493          	mv	s1,a0
    object->scbInit(semValue);
    80003b14:	00090593          	mv	a1,s2
    80003b18:	00000097          	auipc	ra,0x0
    80003b1c:	f50080e7          	jalr	-176(ra) # 80003a68 <_ZN3SCB7scbInitEi>
}
    80003b20:	00048513          	mv	a0,s1
    80003b24:	01813083          	ld	ra,24(sp)
    80003b28:	01013403          	ld	s0,16(sp)
    80003b2c:	00813483          	ld	s1,8(sp)
    80003b30:	00013903          	ld	s2,0(sp)
    80003b34:	02010113          	addi	sp,sp,32
    80003b38:	00008067          	ret
    if(!scbCache) initSCBCache();
    80003b3c:	00000097          	auipc	ra,0x0
    80003b40:	f50080e7          	jalr	-176(ra) # 80003a8c <_ZN3SCB12initSCBCacheEv>
    80003b44:	fbdff06f          	j	80003b00 <_ZN3SCB18createSysSemaphoreEi+0x28>

0000000080003b48 <_ZN3SCB12createObjectEPv>:
    static void createObject(void* addr) {}
    80003b48:	ff010113          	addi	sp,sp,-16
    80003b4c:	00813423          	sd	s0,8(sp)
    80003b50:	01010413          	addi	s0,sp,16
    80003b54:	00813403          	ld	s0,8(sp)
    80003b58:	01010113          	addi	sp,sp,16
    80003b5c:	00008067          	ret

0000000080003b60 <_ZN3SCB10freeObjectEPv>:
    static void freeObject(void* addr) {}
    80003b60:	ff010113          	addi	sp,sp,-16
    80003b64:	00813423          	sd	s0,8(sp)
    80003b68:	01010413          	addi	s0,sp,16
    80003b6c:	00813403          	ld	s0,8(sp)
    80003b70:	01010113          	addi	sp,sp,16
    80003b74:	00008067          	ret

0000000080003b78 <_ZN5Cache11getNumSlotsEmm>:
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima

    optimalSlots = getNumSlots(slabSize, slotSize);
}

int Cache::getNumSlots(size_t slabSize, size_t objSize) {
    80003b78:	ff010113          	addi	sp,sp,-16
    80003b7c:	00813423          	sd	s0,8(sp)
    80003b80:	01010413          	addi	s0,sp,16
    return (slabSize*BLKSIZE - sizeof(Slab)) / objSize;
    80003b84:	00c51513          	slli	a0,a0,0xc
    80003b88:	fd850513          	addi	a0,a0,-40
    80003b8c:	02b55533          	divu	a0,a0,a1
}
    80003b90:	0005051b          	sext.w	a0,a0
    80003b94:	00813403          	ld	s0,8(sp)
    80003b98:	01010113          	addi	sp,sp,16
    80003b9c:	00008067          	ret

0000000080003ba0 <_ZN5Cache11slabListPutEPNS_4SlabEi>:

    return slab;
}


void Cache::slabListPut(Cache::Slab *slab, int listNum) {
    80003ba0:	ff010113          	addi	sp,sp,-16
    80003ba4:	00813423          	sd	s0,8(sp)
    80003ba8:	01010413          	addi	s0,sp,16
    if (!slab || listNum < 0 || listNum > 2) return;
    80003bac:	02058a63          	beqz	a1,80003be0 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    80003bb0:	02064863          	bltz	a2,80003be0 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    80003bb4:	00200793          	li	a5,2
    80003bb8:	02c7c463          	blt	a5,a2,80003be0 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x40>
    slab->state = (SlabState)listNum;
    80003bbc:	00c5a823          	sw	a2,16(a1)
    if(slabList[listNum]) {
    80003bc0:	00361793          	slli	a5,a2,0x3
    80003bc4:	00f507b3          	add	a5,a0,a5
    80003bc8:	0087b783          	ld	a5,8(a5)
    80003bcc:	00078463          	beqz	a5,80003bd4 <_ZN5Cache11slabListPutEPNS_4SlabEi+0x34>
        slab->next = slabList[listNum];
    80003bd0:	00f5b423          	sd	a5,8(a1)
    }
    slabList[listNum] = slab;
    80003bd4:	00361613          	slli	a2,a2,0x3
    80003bd8:	00c50633          	add	a2,a0,a2
    80003bdc:	00b63423          	sd	a1,8(a2)
}
    80003be0:	00813403          	ld	s0,8(sp)
    80003be4:	01010113          	addi	sp,sp,16
    80003be8:	00008067          	ret

0000000080003bec <_ZN5Cache14slabListRemoveEPNS_4SlabEi>:
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
        parentCache->slabListPut(parentSlab, newState);
    }
}

void Cache::slabListRemove(Cache::Slab *slab, int listNum) {
    80003bec:	ff010113          	addi	sp,sp,-16
    80003bf0:	00813423          	sd	s0,8(sp)
    80003bf4:	01010413          	addi	s0,sp,16
    if(!slab || listNum < 0 || listNum > 2) return;
    80003bf8:	04058263          	beqz	a1,80003c3c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
    80003bfc:	04064063          	bltz	a2,80003c3c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
    80003c00:	00200793          	li	a5,2
    80003c04:	02c7cc63          	blt	a5,a2,80003c3c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>

    Slab* prev = nullptr;
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003c08:	00361793          	slli	a5,a2,0x3
    80003c0c:	00f507b3          	add	a5,a0,a5
    80003c10:	0087b783          	ld	a5,8(a5)
    Slab* prev = nullptr;
    80003c14:	00000713          	li	a4,0
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003c18:	02078263          	beqz	a5,80003c3c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x50>
        if(curr == slab) {
    80003c1c:	00b78863          	beq	a5,a1,80003c2c <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x40>
                slabList[listNum] = curr->next;
            }
            curr->next = nullptr;
            break;
        }
        prev = curr;
    80003c20:	00078713          	mv	a4,a5
    for(Slab* curr = slabList[listNum]; curr != nullptr; curr = curr->next) {
    80003c24:	0087b783          	ld	a5,8(a5)
    80003c28:	ff1ff06f          	j	80003c18 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x2c>
            if(prev) {
    80003c2c:	00070e63          	beqz	a4,80003c48 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x5c>
                prev->next = curr->next;
    80003c30:	0087b683          	ld	a3,8(a5)
    80003c34:	00d73423          	sd	a3,8(a4)
            curr->next = nullptr;
    80003c38:	0007b423          	sd	zero,8(a5)
    }
}
    80003c3c:	00813403          	ld	s0,8(sp)
    80003c40:	01010113          	addi	sp,sp,16
    80003c44:	00008067          	ret
                slabList[listNum] = curr->next;
    80003c48:	0087b703          	ld	a4,8(a5)
    80003c4c:	00361613          	slli	a2,a2,0x3
    80003c50:	00c50633          	add	a2,a0,a2
    80003c54:	00e63423          	sd	a4,8(a2)
    80003c58:	fe1ff06f          	j	80003c38 <_ZN5Cache14slabListRemoveEPNS_4SlabEi+0x4c>

0000000080003c5c <_ZN5Cache17printErrorMessageEv>:

int Cache::printErrorMessage() {
    80003c5c:	fe010113          	addi	sp,sp,-32
    80003c60:	00113c23          	sd	ra,24(sp)
    80003c64:	00813823          	sd	s0,16(sp)
    80003c68:	00913423          	sd	s1,8(sp)
    80003c6c:	02010413          	addi	s0,sp,32
    80003c70:	00050493          	mv	s1,a0
    switch(errortype) {
    80003c74:	00052703          	lw	a4,0(a0)
    80003c78:	00100793          	li	a5,1
    80003c7c:	02f70663          	beq	a4,a5,80003ca8 <_ZN5Cache17printErrorMessageEv+0x4c>
        case FreeSlotError:
            printString("Greska u oslobadjanju slota");
        default:
            printString("Nije bilo greske u radu sa kesom");
    80003c80:	00004517          	auipc	a0,0x4
    80003c84:	53850513          	addi	a0,a0,1336 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	bd8080e7          	jalr	-1064(ra) # 80002860 <_Z11printStringPKc>
    }
    return errortype;
}
    80003c90:	0004a503          	lw	a0,0(s1)
    80003c94:	01813083          	ld	ra,24(sp)
    80003c98:	01013403          	ld	s0,16(sp)
    80003c9c:	00813483          	ld	s1,8(sp)
    80003ca0:	02010113          	addi	sp,sp,32
    80003ca4:	00008067          	ret
            printString("Greska u oslobadjanju slota");
    80003ca8:	00004517          	auipc	a0,0x4
    80003cac:	4f050513          	addi	a0,a0,1264 # 80008198 <CONSOLE_STATUS+0x188>
    80003cb0:	fffff097          	auipc	ra,0xfffff
    80003cb4:	bb0080e7          	jalr	-1104(ra) # 80002860 <_Z11printStringPKc>
    80003cb8:	fc9ff06f          	j	80003c80 <_ZN5Cache17printErrorMessageEv+0x24>

0000000080003cbc <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>:
    printString(", ");
    printInt(numSlots);
    printString("\n");
}

void Cache::getNumSlabsAndSlots(int *numSlabs, int *numSlots) {
    80003cbc:	ff010113          	addi	sp,sp,-16
    80003cc0:	00813423          	sd	s0,8(sp)
    80003cc4:	01010413          	addi	s0,sp,16
    int slabs = 0, slots = 0;
    for(int i = 0; i < 3; i++) {
    80003cc8:	00000893          	li	a7,0
    int slabs = 0, slots = 0;
    80003ccc:	00000713          	li	a4,0
    80003cd0:	00000693          	li	a3,0
    80003cd4:	0080006f          	j	80003cdc <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x20>
    for(int i = 0; i < 3; i++) {
    80003cd8:	0018889b          	addiw	a7,a7,1
    80003cdc:	00200793          	li	a5,2
    80003ce0:	0317c463          	blt	a5,a7,80003d08 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x4c>
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003ce4:	00389793          	slli	a5,a7,0x3
    80003ce8:	00f507b3          	add	a5,a0,a5
    80003cec:	0087b783          	ld	a5,8(a5)
    80003cf0:	fe0784e3          	beqz	a5,80003cd8 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x1c>
             slabs++;
    80003cf4:	0016869b          	addiw	a3,a3,1
             slots += curr->allocatedSlots;
    80003cf8:	0007b803          	ld	a6,0(a5)
    80003cfc:	00e8073b          	addw	a4,a6,a4
        for(Slab* curr = slabList[i]; curr != nullptr; curr = curr->next) {
    80003d00:	0087b783          	ld	a5,8(a5)
    80003d04:	fedff06f          	j	80003cf0 <_ZN5Cache19getNumSlabsAndSlotsEPiS0_+0x34>
        }
    }
    (*numSlabs) = slabs;
    80003d08:	00d5a023          	sw	a3,0(a1)
    (*numSlots) = slots;
    80003d0c:	00e62023          	sw	a4,0(a2)
}
    80003d10:	00813403          	ld	s0,8(sp)
    80003d14:	01010113          	addi	sp,sp,16
    80003d18:	00008067          	ret

0000000080003d1c <_ZN5Cache14printCacheInfoEv>:
void Cache::printCacheInfo() {
    80003d1c:	fd010113          	addi	sp,sp,-48
    80003d20:	02113423          	sd	ra,40(sp)
    80003d24:	02813023          	sd	s0,32(sp)
    80003d28:	00913c23          	sd	s1,24(sp)
    80003d2c:	03010413          	addi	s0,sp,48
    80003d30:	00050493          	mv	s1,a0
    int numSlabs = 0, numSlots = 0;
    80003d34:	fc042e23          	sw	zero,-36(s0)
    80003d38:	fc042c23          	sw	zero,-40(s0)
    getNumSlabsAndSlots(&numSlabs, &numSlots);
    80003d3c:	fd840613          	addi	a2,s0,-40
    80003d40:	fdc40593          	addi	a1,s0,-36
    80003d44:	00000097          	auipc	ra,0x0
    80003d48:	f78080e7          	jalr	-136(ra) # 80003cbc <_ZN5Cache19getNumSlabsAndSlotsEPiS0_>
    printString(cacheName);
    80003d4c:	02048513          	addi	a0,s1,32
    80003d50:	fffff097          	auipc	ra,0xfffff
    80003d54:	b10080e7          	jalr	-1264(ra) # 80002860 <_Z11printStringPKc>
    printString(", ");
    80003d58:	00004517          	auipc	a0,0x4
    80003d5c:	48850513          	addi	a0,a0,1160 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003d60:	fffff097          	auipc	ra,0xfffff
    80003d64:	b00080e7          	jalr	-1280(ra) # 80002860 <_Z11printStringPKc>
    printInt(objectSize);
    80003d68:	00000613          	li	a2,0
    80003d6c:	00a00593          	li	a1,10
    80003d70:	0304a503          	lw	a0,48(s1)
    80003d74:	fffff097          	auipc	ra,0xfffff
    80003d78:	c84080e7          	jalr	-892(ra) # 800029f8 <_Z8printIntiii>
    printString(", ");
    80003d7c:	00004517          	auipc	a0,0x4
    80003d80:	46450513          	addi	a0,a0,1124 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003d84:	fffff097          	auipc	ra,0xfffff
    80003d88:	adc080e7          	jalr	-1316(ra) # 80002860 <_Z11printStringPKc>
    printInt(BLKSIZE*slabSize);
    80003d8c:	0484b503          	ld	a0,72(s1)
    80003d90:	00000613          	li	a2,0
    80003d94:	00a00593          	li	a1,10
    80003d98:	00c5151b          	slliw	a0,a0,0xc
    80003d9c:	fffff097          	auipc	ra,0xfffff
    80003da0:	c5c080e7          	jalr	-932(ra) # 800029f8 <_Z8printIntiii>
    printString(", ");
    80003da4:	00004517          	auipc	a0,0x4
    80003da8:	43c50513          	addi	a0,a0,1084 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003dac:	fffff097          	auipc	ra,0xfffff
    80003db0:	ab4080e7          	jalr	-1356(ra) # 80002860 <_Z11printStringPKc>
    printInt(numSlabs);
    80003db4:	00000613          	li	a2,0
    80003db8:	00a00593          	li	a1,10
    80003dbc:	fdc42503          	lw	a0,-36(s0)
    80003dc0:	fffff097          	auipc	ra,0xfffff
    80003dc4:	c38080e7          	jalr	-968(ra) # 800029f8 <_Z8printIntiii>
    printString(", ");
    80003dc8:	00004517          	auipc	a0,0x4
    80003dcc:	41850513          	addi	a0,a0,1048 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003dd0:	fffff097          	auipc	ra,0xfffff
    80003dd4:	a90080e7          	jalr	-1392(ra) # 80002860 <_Z11printStringPKc>
    printInt(optimalSlots);
    80003dd8:	00000613          	li	a2,0
    80003ddc:	00a00593          	li	a1,10
    80003de0:	0384a503          	lw	a0,56(s1)
    80003de4:	fffff097          	auipc	ra,0xfffff
    80003de8:	c14080e7          	jalr	-1004(ra) # 800029f8 <_Z8printIntiii>
    printString(", ");
    80003dec:	00004517          	auipc	a0,0x4
    80003df0:	3f450513          	addi	a0,a0,1012 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003df4:	fffff097          	auipc	ra,0xfffff
    80003df8:	a6c080e7          	jalr	-1428(ra) # 80002860 <_Z11printStringPKc>
    printInt(slotSize);
    80003dfc:	00000613          	li	a2,0
    80003e00:	00a00593          	li	a1,10
    80003e04:	0404a503          	lw	a0,64(s1)
    80003e08:	fffff097          	auipc	ra,0xfffff
    80003e0c:	bf0080e7          	jalr	-1040(ra) # 800029f8 <_Z8printIntiii>
    printString(", ");
    80003e10:	00004517          	auipc	a0,0x4
    80003e14:	3d050513          	addi	a0,a0,976 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80003e18:	fffff097          	auipc	ra,0xfffff
    80003e1c:	a48080e7          	jalr	-1464(ra) # 80002860 <_Z11printStringPKc>
    printInt(numSlots);
    80003e20:	00000613          	li	a2,0
    80003e24:	00a00593          	li	a1,10
    80003e28:	fd842503          	lw	a0,-40(s0)
    80003e2c:	fffff097          	auipc	ra,0xfffff
    80003e30:	bcc080e7          	jalr	-1076(ra) # 800029f8 <_Z8printIntiii>
    printString("\n");
    80003e34:	00004517          	auipc	a0,0x4
    80003e38:	42c50513          	addi	a0,a0,1068 # 80008260 <CONSOLE_STATUS+0x250>
    80003e3c:	fffff097          	auipc	ra,0xfffff
    80003e40:	a24080e7          	jalr	-1500(ra) # 80002860 <_Z11printStringPKc>
}
    80003e44:	02813083          	ld	ra,40(sp)
    80003e48:	02013403          	ld	s0,32(sp)
    80003e4c:	01813483          	ld	s1,24(sp)
    80003e50:	03010113          	addi	sp,sp,48
    80003e54:	00008067          	ret

0000000080003e58 <_ZN5Cache11deallocSlabEPNS_4SlabE>:
    }
    slabList[EMPTY] = nullptr;
    return numSlabs;
}

void Cache::deallocSlab(Slab* slab) {
    80003e58:	fd010113          	addi	sp,sp,-48
    80003e5c:	02113423          	sd	ra,40(sp)
    80003e60:	02813023          	sd	s0,32(sp)
    80003e64:	00913c23          	sd	s1,24(sp)
    80003e68:	01213823          	sd	s2,16(sp)
    80003e6c:	01313423          	sd	s3,8(sp)
    80003e70:	03010413          	addi	s0,sp,48
    80003e74:	00058993          	mv	s3,a1
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    if(destructor) {
    80003e78:	05853783          	ld	a5,88(a0)
    80003e7c:	02078a63          	beqz	a5,80003eb0 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x58>
    80003e80:	00050913          	mv	s2,a0
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003e84:	00000493          	li	s1,0
    80003e88:	0200006f          	j	80003ea8 <_ZN5Cache11deallocSlabEPNS_4SlabE+0x50>
            destructor((void*)((char*)startAddr + i*slotSize));
    80003e8c:	05893783          	ld	a5,88(s2)
    80003e90:	04093503          	ld	a0,64(s2)
    80003e94:	02950533          	mul	a0,a0,s1
    80003e98:	02850513          	addi	a0,a0,40
    80003e9c:	00a98533          	add	a0,s3,a0
    80003ea0:	000780e7          	jalr	a5
        for(size_t i = 0; i < this->optimalSlots; i++) {
    80003ea4:	00148493          	addi	s1,s1,1
    80003ea8:	03893783          	ld	a5,56(s2)
    80003eac:	fef4e0e3          	bltu	s1,a5,80003e8c <_ZN5Cache11deallocSlabEPNS_4SlabE+0x34>
        }
    }
    BuddyAllocator::buddyFree(slab, 1);
    80003eb0:	00100593          	li	a1,1
    80003eb4:	00098513          	mv	a0,s3
    80003eb8:	ffffe097          	auipc	ra,0xffffe
    80003ebc:	45c080e7          	jalr	1116(ra) # 80002314 <_ZN14BuddyAllocator9buddyFreeEPvm>
}
    80003ec0:	02813083          	ld	ra,40(sp)
    80003ec4:	02013403          	ld	s0,32(sp)
    80003ec8:	01813483          	ld	s1,24(sp)
    80003ecc:	01013903          	ld	s2,16(sp)
    80003ed0:	00813983          	ld	s3,8(sp)
    80003ed4:	03010113          	addi	sp,sp,48
    80003ed8:	00008067          	ret

0000000080003edc <_ZN5Cache16deallocFreeSlabsEv>:
int Cache::deallocFreeSlabs() {
    80003edc:	fd010113          	addi	sp,sp,-48
    80003ee0:	02113423          	sd	ra,40(sp)
    80003ee4:	02813023          	sd	s0,32(sp)
    80003ee8:	00913c23          	sd	s1,24(sp)
    80003eec:	01213823          	sd	s2,16(sp)
    80003ef0:	01313423          	sd	s3,8(sp)
    80003ef4:	03010413          	addi	s0,sp,48
    80003ef8:	00050993          	mv	s3,a0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003efc:	00853583          	ld	a1,8(a0)
    int numSlabs = 0;
    80003f00:	00000493          	li	s1,0
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003f04:	02058063          	beqz	a1,80003f24 <_ZN5Cache16deallocFreeSlabsEv+0x48>
        numSlabs++;
    80003f08:	0014849b          	addiw	s1,s1,1
        curr = curr->next;
    80003f0c:	0085b903          	ld	s2,8(a1)
        deallocSlab(old);
    80003f10:	00098513          	mv	a0,s3
    80003f14:	00000097          	auipc	ra,0x0
    80003f18:	f44080e7          	jalr	-188(ra) # 80003e58 <_ZN5Cache11deallocSlabEPNS_4SlabE>
        curr = curr->next;
    80003f1c:	00090593          	mv	a1,s2
    for(Slab* curr = slabList[EMPTY]; curr != nullptr;) {
    80003f20:	fe5ff06f          	j	80003f04 <_ZN5Cache16deallocFreeSlabsEv+0x28>
    slabList[EMPTY] = nullptr;
    80003f24:	0009b423          	sd	zero,8(s3)
}
    80003f28:	00048513          	mv	a0,s1
    80003f2c:	02813083          	ld	ra,40(sp)
    80003f30:	02013403          	ld	s0,32(sp)
    80003f34:	01813483          	ld	s1,24(sp)
    80003f38:	01013903          	ld	s2,16(sp)
    80003f3c:	00813983          	ld	s3,8(sp)
    80003f40:	03010113          	addi	sp,sp,48
    80003f44:	00008067          	ret

0000000080003f48 <_ZN5Cache12deallocCacheEv>:

void Cache::deallocCache() {
    80003f48:	fd010113          	addi	sp,sp,-48
    80003f4c:	02113423          	sd	ra,40(sp)
    80003f50:	02813023          	sd	s0,32(sp)
    80003f54:	00913c23          	sd	s1,24(sp)
    80003f58:	01213823          	sd	s2,16(sp)
    80003f5c:	01313423          	sd	s3,8(sp)
    80003f60:	03010413          	addi	s0,sp,48
    80003f64:	00050913          	mv	s2,a0
    for(int i = 0; i < 3; i++) {
    80003f68:	00000993          	li	s3,0
    80003f6c:	0080006f          	j	80003f74 <_ZN5Cache12deallocCacheEv+0x2c>
    80003f70:	0019899b          	addiw	s3,s3,1
    80003f74:	00200793          	li	a5,2
    80003f78:	0337c663          	blt	a5,s3,80003fa4 <_ZN5Cache12deallocCacheEv+0x5c>
        Slab* curr = slabList[i];
    80003f7c:	00399793          	slli	a5,s3,0x3
    80003f80:	00f907b3          	add	a5,s2,a5
    80003f84:	0087b583          	ld	a1,8(a5)
        while(curr) {
    80003f88:	fe0584e3          	beqz	a1,80003f70 <_ZN5Cache12deallocCacheEv+0x28>
            Slab* old = curr;
            curr = curr->next;
    80003f8c:	0085b483          	ld	s1,8(a1)
            deallocSlab(old);
    80003f90:	00090513          	mv	a0,s2
    80003f94:	00000097          	auipc	ra,0x0
    80003f98:	ec4080e7          	jalr	-316(ra) # 80003e58 <_ZN5Cache11deallocSlabEPNS_4SlabE>
            curr = curr->next;
    80003f9c:	00048593          	mv	a1,s1
        while(curr) {
    80003fa0:	fe9ff06f          	j	80003f88 <_ZN5Cache12deallocCacheEv+0x40>
        }
    }
}
    80003fa4:	02813083          	ld	ra,40(sp)
    80003fa8:	02013403          	ld	s0,32(sp)
    80003fac:	01813483          	ld	s1,24(sp)
    80003fb0:	01013903          	ld	s2,16(sp)
    80003fb4:	00813983          	ld	s3,8(sp)
    80003fb8:	03010113          	addi	sp,sp,48
    80003fbc:	00008067          	ret

0000000080003fc0 <_ZN5Cache10powerOfTwoEm>:
void Cache::freeBuffer(Slot* slot) {
    Cache* parentCache = slot->parentSlab->parentCache;
    parentCache->freeSlot(slot);
}

size_t Cache::powerOfTwo(size_t size) {
    80003fc0:	ff010113          	addi	sp,sp,-16
    80003fc4:	00813423          	sd	s0,8(sp)
    80003fc8:	01010413          	addi	s0,sp,16
    80003fcc:	00050613          	mv	a2,a0
    size_t t = size;
    80003fd0:	00050793          	mv	a5,a0
    size_t pow = 0, powerValue = 1;
    80003fd4:	00100713          	li	a4,1
    80003fd8:	00000513          	li	a0,0
    while(t > 1) {
    80003fdc:	00100693          	li	a3,1
    80003fe0:	00f6fa63          	bgeu	a3,a5,80003ff4 <_ZN5Cache10powerOfTwoEm+0x34>
        t /= 2;
    80003fe4:	0017d793          	srli	a5,a5,0x1
        powerValue *= 2;
    80003fe8:	00171713          	slli	a4,a4,0x1
        pow++;
    80003fec:	00150513          	addi	a0,a0,1
    while(t > 1) {
    80003ff0:	fedff06f          	j	80003fdc <_ZN5Cache10powerOfTwoEm+0x1c>
    }
    if(size != powerValue) pow++;
    80003ff4:	00c70463          	beq	a4,a2,80003ffc <_ZN5Cache10powerOfTwoEm+0x3c>
    80003ff8:	00150513          	addi	a0,a0,1
    return pow;
}
    80003ffc:	00813403          	ld	s0,8(sp)
    80004000:	01010113          	addi	sp,sp,16
    80004004:	00008067          	ret

0000000080004008 <_ZN5Cache12allocateSlabEv>:
Cache::Slab *Cache::allocateSlab() {
    80004008:	fc010113          	addi	sp,sp,-64
    8000400c:	02113c23          	sd	ra,56(sp)
    80004010:	02813823          	sd	s0,48(sp)
    80004014:	02913423          	sd	s1,40(sp)
    80004018:	03213023          	sd	s2,32(sp)
    8000401c:	01313c23          	sd	s3,24(sp)
    80004020:	01413823          	sd	s4,16(sp)
    80004024:	01513423          	sd	s5,8(sp)
    80004028:	04010413          	addi	s0,sp,64
    8000402c:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)BuddyAllocator::buddyAlloc(powerOfTwo(slabSize) + 1); // 2 ako nije dovoljno
    80004030:	04853503          	ld	a0,72(a0)
    80004034:	00000097          	auipc	ra,0x0
    80004038:	f8c080e7          	jalr	-116(ra) # 80003fc0 <_ZN5Cache10powerOfTwoEm>
    8000403c:	00150513          	addi	a0,a0,1
    80004040:	ffffe097          	auipc	ra,0xffffe
    80004044:	20c080e7          	jalr	524(ra) # 8000224c <_ZN14BuddyAllocator10buddyAllocEm>
    80004048:	00050a13          	mv	s4,a0
    slab->parentCache = this;
    8000404c:	01253c23          	sd	s2,24(a0)
    slab->next = nullptr;
    80004050:	00053423          	sd	zero,8(a0)
    slab->state = CREATED;
    80004054:	00300793          	li	a5,3
    80004058:	00f52823          	sw	a5,16(a0)
    slab->allocatedSlots = 0;
    8000405c:	00053023          	sd	zero,0(a0)
    void* startAddr = (void*)((char*)slab + sizeof(Slab));
    80004060:	02850a93          	addi	s5,a0,40
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80004064:	00000493          	li	s1,0
    Slot* prev = nullptr;
    80004068:	00000993          	li	s3,0
    8000406c:	0140006f          	j	80004080 <_ZN5Cache12allocateSlabEv+0x78>
            slab->slotHead = curr;
    80004070:	02fa3023          	sd	a5,32(s4)
        curr->next = nullptr;
    80004074:	0007b423          	sd	zero,8(a5)
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80004078:	00148493          	addi	s1,s1,1
        prev = curr;
    8000407c:	00078993          	mv	s3,a5
    for(size_t i = 0; i < this->optimalSlots; i++) {
    80004080:	03893783          	ld	a5,56(s2)
    80004084:	04f4f063          	bgeu	s1,a5,800040c4 <_ZN5Cache12allocateSlabEv+0xbc>
        if(constructor) {
    80004088:	05093783          	ld	a5,80(s2)
    8000408c:	00078c63          	beqz	a5,800040a4 <_ZN5Cache12allocateSlabEv+0x9c>
            constructor((void*)((char*)startAddr + i*slotSize + sizeof(Slot)));
    80004090:	04093503          	ld	a0,64(s2)
    80004094:	02950533          	mul	a0,a0,s1
    80004098:	01850513          	addi	a0,a0,24
    8000409c:	00aa8533          	add	a0,s5,a0
    800040a0:	000780e7          	jalr	a5
        Slot* curr = (Slot*)((char*)startAddr + i*slotSize);
    800040a4:	04093783          	ld	a5,64(s2)
    800040a8:	029787b3          	mul	a5,a5,s1
    800040ac:	00fa87b3          	add	a5,s5,a5
        curr->parentSlab = slab;
    800040b0:	0147b823          	sd	s4,16(a5)
        curr->allocated = false;
    800040b4:	00078023          	sb	zero,0(a5)
        if(prev) {
    800040b8:	fa098ce3          	beqz	s3,80004070 <_ZN5Cache12allocateSlabEv+0x68>
            prev->next= curr;
    800040bc:	00f9b423          	sd	a5,8(s3)
    800040c0:	fb5ff06f          	j	80004074 <_ZN5Cache12allocateSlabEv+0x6c>
}
    800040c4:	000a0513          	mv	a0,s4
    800040c8:	03813083          	ld	ra,56(sp)
    800040cc:	03013403          	ld	s0,48(sp)
    800040d0:	02813483          	ld	s1,40(sp)
    800040d4:	02013903          	ld	s2,32(sp)
    800040d8:	01813983          	ld	s3,24(sp)
    800040dc:	01013a03          	ld	s4,16(sp)
    800040e0:	00813a83          	ld	s5,8(sp)
    800040e4:	04010113          	addi	sp,sp,64
    800040e8:	00008067          	ret

00000000800040ec <_ZN5Cache11createCacheEv>:

Cache *Cache::createCache() {
    800040ec:	ff010113          	addi	sp,sp,-16
    800040f0:	00113423          	sd	ra,8(sp)
    800040f4:	00813023          	sd	s0,0(sp)
    800040f8:	01010413          	addi	s0,sp,16
    return (Cache*)BuddyAllocator::buddyAlloc(1);
    800040fc:	00100513          	li	a0,1
    80004100:	ffffe097          	auipc	ra,0xffffe
    80004104:	14c080e7          	jalr	332(ra) # 8000224c <_ZN14BuddyAllocator10buddyAllocEm>
}
    80004108:	00813083          	ld	ra,8(sp)
    8000410c:	00013403          	ld	s0,0(sp)
    80004110:	01010113          	addi	sp,sp,16
    80004114:	00008067          	ret

0000000080004118 <_ZN5Cache6strcpyEPcPKc>:

void Cache::strcpy(char *string1, const char *string2) {
    80004118:	ff010113          	addi	sp,sp,-16
    8000411c:	00813423          	sd	s0,8(sp)
    80004120:	01010413          	addi	s0,sp,16
        for(int i = 0;; i++) {
    80004124:	00000693          	li	a3,0
            string1[i] = string2[i];
    80004128:	00d587b3          	add	a5,a1,a3
    8000412c:	00d50733          	add	a4,a0,a3
    80004130:	0007c603          	lbu	a2,0(a5)
    80004134:	00c70023          	sb	a2,0(a4)
            if(string2[i] == '\0') break;
    80004138:	0007c783          	lbu	a5,0(a5)
    8000413c:	00078663          	beqz	a5,80004148 <_ZN5Cache6strcpyEPcPKc+0x30>
        for(int i = 0;; i++) {
    80004140:	0016869b          	addiw	a3,a3,1
            string1[i] = string2[i];
    80004144:	fe5ff06f          	j	80004128 <_ZN5Cache6strcpyEPcPKc+0x10>
        }
}
    80004148:	00813403          	ld	s0,8(sp)
    8000414c:	01010113          	addi	sp,sp,16
    80004150:	00008067          	ret

0000000080004154 <_ZN5Cache9initCacheEPKcmPFvPvES4_>:
void Cache::initCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004154:	fd010113          	addi	sp,sp,-48
    80004158:	02113423          	sd	ra,40(sp)
    8000415c:	02813023          	sd	s0,32(sp)
    80004160:	00913c23          	sd	s1,24(sp)
    80004164:	01213823          	sd	s2,16(sp)
    80004168:	01313423          	sd	s3,8(sp)
    8000416c:	01413023          	sd	s4,0(sp)
    80004170:	03010413          	addi	s0,sp,48
    80004174:	00050493          	mv	s1,a0
    80004178:	00060913          	mv	s2,a2
    8000417c:	00068a13          	mv	s4,a3
    80004180:	00070993          	mv	s3,a4
    strcpy(cacheName, name);
    80004184:	02050513          	addi	a0,a0,32
    80004188:	00000097          	auipc	ra,0x0
    8000418c:	f90080e7          	jalr	-112(ra) # 80004118 <_ZN5Cache6strcpyEPcPKc>
    for(int i = 0; i < 3; i++) {
    80004190:	00000793          	li	a5,0
    80004194:	0140006f          	j	800041a8 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x54>
        slabList[i] = nullptr;
    80004198:	00379513          	slli	a0,a5,0x3
    8000419c:	00a48533          	add	a0,s1,a0
    800041a0:	00053423          	sd	zero,8(a0)
    for(int i = 0; i < 3; i++) {
    800041a4:	0017879b          	addiw	a5,a5,1
    800041a8:	00200613          	li	a2,2
    800041ac:	fef656e3          	bge	a2,a5,80004198 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x44>
    objectSize = size;
    800041b0:	0324b823          	sd	s2,48(s1)
    constructor = ctor;
    800041b4:	0544b823          	sd	s4,80(s1)
    destructor = dtor;
    800041b8:	0534bc23          	sd	s3,88(s1)
    slotSize = objectSize + sizeof(Slot);
    800041bc:	01890593          	addi	a1,s2,24
    800041c0:	04b4b023          	sd	a1,64(s1)
    slabSize = slotSize / BLKSIZE;
    800041c4:	00c5d713          	srli	a4,a1,0xc
    800041c8:	04e4b423          	sd	a4,72(s1)
    if(slotSize % BLKSIZE != 0) slabSize++; // u blokovima
    800041cc:	000017b7          	lui	a5,0x1
    800041d0:	fff78793          	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800041d4:	00f5f7b3          	and	a5,a1,a5
    800041d8:	00078663          	beqz	a5,800041e4 <_ZN5Cache9initCacheEPKcmPFvPvES4_+0x90>
    800041dc:	00170713          	addi	a4,a4,1
    800041e0:	04e4b423          	sd	a4,72(s1)
    optimalSlots = getNumSlots(slabSize, slotSize);
    800041e4:	0484b503          	ld	a0,72(s1)
    800041e8:	00000097          	auipc	ra,0x0
    800041ec:	990080e7          	jalr	-1648(ra) # 80003b78 <_ZN5Cache11getNumSlotsEmm>
    800041f0:	02a4bc23          	sd	a0,56(s1)
}
    800041f4:	02813083          	ld	ra,40(sp)
    800041f8:	02013403          	ld	s0,32(sp)
    800041fc:	01813483          	ld	s1,24(sp)
    80004200:	01013903          	ld	s2,16(sp)
    80004204:	00813983          	ld	s3,8(sp)
    80004208:	00013a03          	ld	s4,0(sp)
    8000420c:	03010113          	addi	sp,sp,48
    80004210:	00008067          	ret

0000000080004214 <_ZN5Cache13allBufferInfoEv>:

void Cache::allBufferInfo() {
    80004214:	fe010113          	addi	sp,sp,-32
    80004218:	00113c23          	sd	ra,24(sp)
    8000421c:	00813823          	sd	s0,16(sp)
    80004220:	00913423          	sd	s1,8(sp)
    80004224:	02010413          	addi	s0,sp,32
    printString("ime kesa, velicina objekta, velicina slaba, broj slabova, broj slotova po slabu, velicina slota, broj alociranih slotova\n");
    80004228:	00004517          	auipc	a0,0x4
    8000422c:	fc050513          	addi	a0,a0,-64 # 800081e8 <CONSOLE_STATUS+0x1d8>
    80004230:	ffffe097          	auipc	ra,0xffffe
    80004234:	630080e7          	jalr	1584(ra) # 80002860 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80004238:	00000493          	li	s1,0
    8000423c:	0200006f          	j	8000425c <_ZN5Cache13allBufferInfoEv+0x48>
        if(bufferCache[i]) {
            bufferCache[i]->printCacheInfo();
    80004240:	00000097          	auipc	ra,0x0
    80004244:	adc080e7          	jalr	-1316(ra) # 80003d1c <_ZN5Cache14printCacheInfoEv>
            printString("\n");
    80004248:	00004517          	auipc	a0,0x4
    8000424c:	01850513          	addi	a0,a0,24 # 80008260 <CONSOLE_STATUS+0x250>
    80004250:	ffffe097          	auipc	ra,0xffffe
    80004254:	610080e7          	jalr	1552(ra) # 80002860 <_Z11printStringPKc>
    for(int i = 0; i < MAXSIZEBUFFER - MINSIZEBUFFER + 1; i++) {
    80004258:	0014849b          	addiw	s1,s1,1
    8000425c:	00c00793          	li	a5,12
    80004260:	0297c063          	blt	a5,s1,80004280 <_ZN5Cache13allBufferInfoEv+0x6c>
        if(bufferCache[i]) {
    80004264:	00349713          	slli	a4,s1,0x3
    80004268:	00006797          	auipc	a5,0x6
    8000426c:	2d878793          	addi	a5,a5,728 # 8000a540 <_ZN5Cache11bufferCacheE>
    80004270:	00e787b3          	add	a5,a5,a4
    80004274:	0007b503          	ld	a0,0(a5)
    80004278:	fc0514e3          	bnez	a0,80004240 <_ZN5Cache13allBufferInfoEv+0x2c>
    8000427c:	fddff06f          	j	80004258 <_ZN5Cache13allBufferInfoEv+0x44>
        }
    }
}
    80004280:	01813083          	ld	ra,24(sp)
    80004284:	01013403          	ld	s0,16(sp)
    80004288:	00813483          	ld	s1,8(sp)
    8000428c:	02010113          	addi	sp,sp,32
    80004290:	00008067          	ret

0000000080004294 <_ZN5Cache4Slab17calculateNewStateEv>:
    }

    return nullptr;
}

Cache::SlabState Cache::Slab::calculateNewState() {
    80004294:	ff010113          	addi	sp,sp,-16
    80004298:	00813423          	sd	s0,8(sp)
    8000429c:	01010413          	addi	s0,sp,16
    if(allocatedSlots == 0) {
    800042a0:	00053783          	ld	a5,0(a0)
    800042a4:	02078063          	beqz	a5,800042c4 <_ZN5Cache4Slab17calculateNewStateEv+0x30>
        return EMPTY;
    }
    else if(allocatedSlots == parentCache->optimalSlots) {
    800042a8:	01853703          	ld	a4,24(a0)
    800042ac:	03873703          	ld	a4,56(a4)
    800042b0:	00e78e63          	beq	a5,a4,800042cc <_ZN5Cache4Slab17calculateNewStateEv+0x38>
        return FULL;
    }
    return PARTIAL;
    800042b4:	00100513          	li	a0,1
}
    800042b8:	00813403          	ld	s0,8(sp)
    800042bc:	01010113          	addi	sp,sp,16
    800042c0:	00008067          	ret
        return EMPTY;
    800042c4:	00000513          	li	a0,0
    800042c8:	ff1ff06f          	j	800042b8 <_ZN5Cache4Slab17calculateNewStateEv+0x24>
        return FULL;
    800042cc:	00200513          	li	a0,2
    800042d0:	fe9ff06f          	j	800042b8 <_ZN5Cache4Slab17calculateNewStateEv+0x24>

00000000800042d4 <_ZN5Cache8freeSlotEPNS_4SlotE>:
void Cache::freeSlot(Slot* slot) {
    800042d4:	fd010113          	addi	sp,sp,-48
    800042d8:	02113423          	sd	ra,40(sp)
    800042dc:	02813023          	sd	s0,32(sp)
    800042e0:	00913c23          	sd	s1,24(sp)
    800042e4:	01213823          	sd	s2,16(sp)
    800042e8:	01313423          	sd	s3,8(sp)
    800042ec:	03010413          	addi	s0,sp,48
    if(slot->parentSlab->parentCache != this) {
    800042f0:	0105b483          	ld	s1,16(a1)
    800042f4:	0184b903          	ld	s2,24(s1)
    800042f8:	02a90463          	beq	s2,a0,80004320 <_ZN5Cache8freeSlotEPNS_4SlotE+0x4c>
        errortype = FreeSlotError;
    800042fc:	00100793          	li	a5,1
    80004300:	00f52023          	sw	a5,0(a0)
}
    80004304:	02813083          	ld	ra,40(sp)
    80004308:	02013403          	ld	s0,32(sp)
    8000430c:	01813483          	ld	s1,24(sp)
    80004310:	01013903          	ld	s2,16(sp)
    80004314:	00813983          	ld	s3,8(sp)
    80004318:	03010113          	addi	sp,sp,48
    8000431c:	00008067          	ret
    slot->allocated = false;
    80004320:	00058023          	sb	zero,0(a1)
    parentSlab->allocatedSlots--;
    80004324:	0004b783          	ld	a5,0(s1)
    80004328:	fff78793          	addi	a5,a5,-1
    8000432c:	00f4b023          	sd	a5,0(s1)
    SlabState newState = parentSlab->calculateNewState();
    80004330:	00048513          	mv	a0,s1
    80004334:	00000097          	auipc	ra,0x0
    80004338:	f60080e7          	jalr	-160(ra) # 80004294 <_ZN5Cache4Slab17calculateNewStateEv>
    8000433c:	00050993          	mv	s3,a0
    if(parentSlab->state != newState) {
    80004340:	0104a603          	lw	a2,16(s1)
    80004344:	fca600e3          	beq	a2,a0,80004304 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80004348:	00300793          	li	a5,3
    8000434c:	00f61e63          	bne	a2,a5,80004368 <_ZN5Cache8freeSlotEPNS_4SlotE+0x94>
        parentCache->slabListPut(parentSlab, newState);
    80004350:	0009861b          	sext.w	a2,s3
    80004354:	00048593          	mv	a1,s1
    80004358:	00090513          	mv	a0,s2
    8000435c:	00000097          	auipc	ra,0x0
    80004360:	844080e7          	jalr	-1980(ra) # 80003ba0 <_ZN5Cache11slabListPutEPNS_4SlabEi>
    80004364:	fa1ff06f          	j	80004304 <_ZN5Cache8freeSlotEPNS_4SlotE+0x30>
        if(parentSlab->state != CREATED) parentCache->slabListRemove(parentSlab, parentSlab->state);
    80004368:	00048593          	mv	a1,s1
    8000436c:	00090513          	mv	a0,s2
    80004370:	00000097          	auipc	ra,0x0
    80004374:	87c080e7          	jalr	-1924(ra) # 80003bec <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80004378:	fd9ff06f          	j	80004350 <_ZN5Cache8freeSlotEPNS_4SlotE+0x7c>

000000008000437c <_ZN5Cache10freeBufferEPNS_4SlotE>:
void Cache::freeBuffer(Slot* slot) {
    8000437c:	ff010113          	addi	sp,sp,-16
    80004380:	00113423          	sd	ra,8(sp)
    80004384:	00813023          	sd	s0,0(sp)
    80004388:	01010413          	addi	s0,sp,16
    8000438c:	00050593          	mv	a1,a0
    Cache* parentCache = slot->parentSlab->parentCache;
    80004390:	01053783          	ld	a5,16(a0)
    parentCache->freeSlot(slot);
    80004394:	0187b503          	ld	a0,24(a5)
    80004398:	00000097          	auipc	ra,0x0
    8000439c:	f3c080e7          	jalr	-196(ra) # 800042d4 <_ZN5Cache8freeSlotEPNS_4SlotE>
}
    800043a0:	00813083          	ld	ra,8(sp)
    800043a4:	00013403          	ld	s0,0(sp)
    800043a8:	01010113          	addi	sp,sp,16
    800043ac:	00008067          	ret

00000000800043b0 <_ZN5Cache4Slab11getFreeSlotEv>:
Cache::Slot *Cache::Slab::getFreeSlot() {
    800043b0:	fd010113          	addi	sp,sp,-48
    800043b4:	02113423          	sd	ra,40(sp)
    800043b8:	02813023          	sd	s0,32(sp)
    800043bc:	00913c23          	sd	s1,24(sp)
    800043c0:	01213823          	sd	s2,16(sp)
    800043c4:	01313423          	sd	s3,8(sp)
    800043c8:	03010413          	addi	s0,sp,48
    if(!slotHead || state == FULL) return nullptr;
    800043cc:	02053483          	ld	s1,32(a0)
    800043d0:	06048a63          	beqz	s1,80004444 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
    800043d4:	00050913          	mv	s2,a0
    800043d8:	01052703          	lw	a4,16(a0)
    800043dc:	00200793          	li	a5,2
    800043e0:	08f70c63          	beq	a4,a5,80004478 <_ZN5Cache4Slab11getFreeSlotEv+0xc8>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    800043e4:	06048063          	beqz	s1,80004444 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
        if(curr->allocated == false) {
    800043e8:	0004c783          	lbu	a5,0(s1)
    800043ec:	00078663          	beqz	a5,800043f8 <_ZN5Cache4Slab11getFreeSlotEv+0x48>
    for(Slot* curr = slotHead; curr != nullptr; curr = curr->next) {
    800043f0:	0084b483          	ld	s1,8(s1)
    800043f4:	ff1ff06f          	j	800043e4 <_ZN5Cache4Slab11getFreeSlotEv+0x34>
            this->allocatedSlots++;
    800043f8:	00093783          	ld	a5,0(s2)
    800043fc:	00178793          	addi	a5,a5,1
    80004400:	00f93023          	sd	a5,0(s2)
            curr->allocated = true;
    80004404:	00100793          	li	a5,1
    80004408:	00f48023          	sb	a5,0(s1)
            curr->parentSlab = this;
    8000440c:	0124b823          	sd	s2,16(s1)
            SlabState newState = calculateNewState();
    80004410:	00090513          	mv	a0,s2
    80004414:	00000097          	auipc	ra,0x0
    80004418:	e80080e7          	jalr	-384(ra) # 80004294 <_ZN5Cache4Slab17calculateNewStateEv>
    8000441c:	00050993          	mv	s3,a0
            if(this->state != newState) {
    80004420:	01092603          	lw	a2,16(s2)
    80004424:	02a60063          	beq	a2,a0,80004444 <_ZN5Cache4Slab11getFreeSlotEv+0x94>
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80004428:	00300793          	li	a5,3
    8000442c:	02f61c63          	bne	a2,a5,80004464 <_ZN5Cache4Slab11getFreeSlotEv+0xb4>
                parentCache->slabListPut(this, newState);
    80004430:	0009861b          	sext.w	a2,s3
    80004434:	00090593          	mv	a1,s2
    80004438:	01893503          	ld	a0,24(s2)
    8000443c:	fffff097          	auipc	ra,0xfffff
    80004440:	764080e7          	jalr	1892(ra) # 80003ba0 <_ZN5Cache11slabListPutEPNS_4SlabEi>
}
    80004444:	00048513          	mv	a0,s1
    80004448:	02813083          	ld	ra,40(sp)
    8000444c:	02013403          	ld	s0,32(sp)
    80004450:	01813483          	ld	s1,24(sp)
    80004454:	01013903          	ld	s2,16(sp)
    80004458:	00813983          	ld	s3,8(sp)
    8000445c:	03010113          	addi	sp,sp,48
    80004460:	00008067          	ret
                if(this->state != CREATED) parentCache->slabListRemove(this, this->state);
    80004464:	00090593          	mv	a1,s2
    80004468:	01893503          	ld	a0,24(s2)
    8000446c:	fffff097          	auipc	ra,0xfffff
    80004470:	780080e7          	jalr	1920(ra) # 80003bec <_ZN5Cache14slabListRemoveEPNS_4SlabEi>
    80004474:	fbdff06f          	j	80004430 <_ZN5Cache4Slab11getFreeSlotEv+0x80>
    if(!slotHead || state == FULL) return nullptr;
    80004478:	00000493          	li	s1,0
    8000447c:	fc9ff06f          	j	80004444 <_ZN5Cache4Slab11getFreeSlotEv+0x94>

0000000080004480 <_ZN5Cache12allocateSlotEv>:
void *Cache::allocateSlot() {
    80004480:	ff010113          	addi	sp,sp,-16
    80004484:	00113423          	sd	ra,8(sp)
    80004488:	00813023          	sd	s0,0(sp)
    8000448c:	01010413          	addi	s0,sp,16
    80004490:	00050793          	mv	a5,a0
    if(slabList[PARTIAL]) {
    80004494:	01053503          	ld	a0,16(a0)
    80004498:	00050e63          	beqz	a0,800044b4 <_ZN5Cache12allocateSlotEv+0x34>
        return slab->getFreeSlot();
    8000449c:	00000097          	auipc	ra,0x0
    800044a0:	f14080e7          	jalr	-236(ra) # 800043b0 <_ZN5Cache4Slab11getFreeSlotEv>
}
    800044a4:	00813083          	ld	ra,8(sp)
    800044a8:	00013403          	ld	s0,0(sp)
    800044ac:	01010113          	addi	sp,sp,16
    800044b0:	00008067          	ret
    else if(slabList[EMPTY]) {
    800044b4:	0087b503          	ld	a0,8(a5)
    800044b8:	00050863          	beqz	a0,800044c8 <_ZN5Cache12allocateSlotEv+0x48>
        Slot* slot = slab->getFreeSlot();
    800044bc:	00000097          	auipc	ra,0x0
    800044c0:	ef4080e7          	jalr	-268(ra) # 800043b0 <_ZN5Cache4Slab11getFreeSlotEv>
        return slot;
    800044c4:	fe1ff06f          	j	800044a4 <_ZN5Cache12allocateSlotEv+0x24>
    Slab* slab = allocateSlab();
    800044c8:	00078513          	mv	a0,a5
    800044cc:	00000097          	auipc	ra,0x0
    800044d0:	b3c080e7          	jalr	-1220(ra) # 80004008 <_ZN5Cache12allocateSlabEv>
    return slab->getFreeSlot();
    800044d4:	00000097          	auipc	ra,0x0
    800044d8:	edc080e7          	jalr	-292(ra) # 800043b0 <_ZN5Cache4Slab11getFreeSlotEv>
    800044dc:	fc9ff06f          	j	800044a4 <_ZN5Cache12allocateSlotEv+0x24>

00000000800044e0 <_ZN5Cache14allocateBufferEm>:
void *Cache::allocateBuffer(size_t size) {
    800044e0:	fe010113          	addi	sp,sp,-32
    800044e4:	00113c23          	sd	ra,24(sp)
    800044e8:	00813823          	sd	s0,16(sp)
    800044ec:	00913423          	sd	s1,8(sp)
    800044f0:	01213023          	sd	s2,0(sp)
    800044f4:	02010413          	addi	s0,sp,32
    size_t objectPowSize = powerOfTwo(size);
    800044f8:	00000097          	auipc	ra,0x0
    800044fc:	ac8080e7          	jalr	-1336(ra) # 80003fc0 <_ZN5Cache10powerOfTwoEm>
    if(objectPowSize <  MINSIZEBUFFER || objectPowSize > MAXSIZEBUFFER) {
    80004500:	ffb50493          	addi	s1,a0,-5
    80004504:	00c00793          	li	a5,12
    80004508:	0897ee63          	bltu	a5,s1,800045a4 <_ZN5Cache14allocateBufferEm+0xc4>
    8000450c:	00050913          	mv	s2,a0
    if(bufferCache[entry] == nullptr) {
    80004510:	00349713          	slli	a4,s1,0x3
    80004514:	00006797          	auipc	a5,0x6
    80004518:	02c78793          	addi	a5,a5,44 # 8000a540 <_ZN5Cache11bufferCacheE>
    8000451c:	00e787b3          	add	a5,a5,a4
    80004520:	0007b783          	ld	a5,0(a5)
    80004524:	02078c63          	beqz	a5,8000455c <_ZN5Cache14allocateBufferEm+0x7c>
    return bufferCache[entry]->allocateSlot();
    80004528:	00349493          	slli	s1,s1,0x3
    8000452c:	00006797          	auipc	a5,0x6
    80004530:	01478793          	addi	a5,a5,20 # 8000a540 <_ZN5Cache11bufferCacheE>
    80004534:	009784b3          	add	s1,a5,s1
    80004538:	0004b503          	ld	a0,0(s1)
    8000453c:	00000097          	auipc	ra,0x0
    80004540:	f44080e7          	jalr	-188(ra) # 80004480 <_ZN5Cache12allocateSlotEv>
}
    80004544:	01813083          	ld	ra,24(sp)
    80004548:	01013403          	ld	s0,16(sp)
    8000454c:	00813483          	ld	s1,8(sp)
    80004550:	00013903          	ld	s2,0(sp)
    80004554:	02010113          	addi	sp,sp,32
    80004558:	00008067          	ret
        bufferCache[entry] = createCache();
    8000455c:	00000097          	auipc	ra,0x0
    80004560:	b90080e7          	jalr	-1136(ra) # 800040ec <_ZN5Cache11createCacheEv>
    80004564:	00349693          	slli	a3,s1,0x3
    80004568:	00006717          	auipc	a4,0x6
    8000456c:	fd870713          	addi	a4,a4,-40 # 8000a540 <_ZN5Cache11bufferCacheE>
    80004570:	00d70733          	add	a4,a4,a3
    80004574:	00a73023          	sd	a0,0(a4)
        bufferCache[entry]->initCache(bufferNames[entry], 1<<objectPowSize, NULL,NULL);
    80004578:	00006797          	auipc	a5,0x6
    8000457c:	d9878793          	addi	a5,a5,-616 # 8000a310 <_ZN5Cache11bufferNamesE>
    80004580:	00d787b3          	add	a5,a5,a3
    80004584:	00000713          	li	a4,0
    80004588:	00000693          	li	a3,0
    8000458c:	00100613          	li	a2,1
    80004590:	0126163b          	sllw	a2,a2,s2
    80004594:	0007b583          	ld	a1,0(a5)
    80004598:	00000097          	auipc	ra,0x0
    8000459c:	bbc080e7          	jalr	-1092(ra) # 80004154 <_ZN5Cache9initCacheEPKcmPFvPvES4_>
    800045a0:	f89ff06f          	j	80004528 <_ZN5Cache14allocateBufferEm+0x48>
        return nullptr;
    800045a4:	00000513          	li	a0,0
    800045a8:	f9dff06f          	j	80004544 <_ZN5Cache14allocateBufferEm+0x64>

00000000800045ac <_ZN15MemoryAllocator17userHeapStartAddrEv>:
    }

    return 0;
}

void *MemoryAllocator::userHeapStartAddr() {
    800045ac:	ff010113          	addi	sp,sp,-16
    800045b0:	00813423          	sd	s0,8(sp)
    800045b4:	01010413          	addi	s0,sp,16
    return (void*)((char*)HEAP_START_ADDR + (1<<24));
    800045b8:	00006797          	auipc	a5,0x6
    800045bc:	de07b783          	ld	a5,-544(a5) # 8000a398 <_GLOBAL_OFFSET_TABLE_+0x20>
    800045c0:	0007b503          	ld	a0,0(a5)
}
    800045c4:	010007b7          	lui	a5,0x1000
    800045c8:	00f50533          	add	a0,a0,a5
    800045cc:	00813403          	ld	s0,8(sp)
    800045d0:	01010113          	addi	sp,sp,16
    800045d4:	00008067          	ret

00000000800045d8 <_ZN15MemoryAllocator15userHeapEndAddrEv>:

void *MemoryAllocator::userHeapEndAddr() {
    800045d8:	ff010113          	addi	sp,sp,-16
    800045dc:	00813423          	sd	s0,8(sp)
    800045e0:	01010413          	addi	s0,sp,16
    return (void*)((char*)HEAP_END_ADDR);
}
    800045e4:	00006797          	auipc	a5,0x6
    800045e8:	dfc7b783          	ld	a5,-516(a5) # 8000a3e0 <_GLOBAL_OFFSET_TABLE_+0x68>
    800045ec:	0007b503          	ld	a0,0(a5)
    800045f0:	00813403          	ld	s0,8(sp)
    800045f4:	01010113          	addi	sp,sp,16
    800045f8:	00008067          	ret

00000000800045fc <_ZN15MemoryAllocator9mem_allocEm>:
void *MemoryAllocator::mem_alloc(size_t size) {
    800045fc:	fd010113          	addi	sp,sp,-48
    80004600:	02113423          	sd	ra,40(sp)
    80004604:	02813023          	sd	s0,32(sp)
    80004608:	00913c23          	sd	s1,24(sp)
    8000460c:	01213823          	sd	s2,16(sp)
    80004610:	01313423          	sd	s3,8(sp)
    80004614:	03010413          	addi	s0,sp,48
    80004618:	00050913          	mv	s2,a0
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000461c:	00006497          	auipc	s1,0x6
    80004620:	f8c4b483          	ld	s1,-116(s1) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004624:	02048a63          	beqz	s1,80004658 <_ZN15MemoryAllocator9mem_allocEm+0x5c>
    else if(head == (FreeSegment*)userHeapEndAddr()) { // ako ne postoji slobodan prostor
    80004628:	00000097          	auipc	ra,0x0
    8000462c:	fb0080e7          	jalr	-80(ra) # 800045d8 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    80004630:	14a48c63          	beq	s1,a0,80004788 <_ZN15MemoryAllocator9mem_allocEm+0x18c>
    size += SegmentOffset; // dodajemo zaglavlje
    80004634:	00890713          	addi	a4,s2,8
    80004638:	00675793          	srli	a5,a4,0x6
    8000463c:	03f77613          	andi	a2,a4,63
    80004640:	00c03633          	snez	a2,a2
    80004644:	00f60633          	add	a2,a2,a5
    FreeSegment *curr = head, *prev = nullptr;
    80004648:	00006517          	auipc	a0,0x6
    8000464c:	f6053503          	ld	a0,-160(a0) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004650:	00000693          	li	a3,0
    80004654:	0b80006f          	j	8000470c <_ZN15MemoryAllocator9mem_allocEm+0x110>
        head = (FreeSegment*)userHeapStartAddr();
    80004658:	00000097          	auipc	ra,0x0
    8000465c:	f54080e7          	jalr	-172(ra) # 800045ac <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004660:	00050493          	mv	s1,a0
    80004664:	00006997          	auipc	s3,0x6
    80004668:	f4498993          	addi	s3,s3,-188 # 8000a5a8 <_ZN15MemoryAllocator4headE>
    8000466c:	00a9b023          	sd	a0,0(s3)
        head->baseAddr = (void*)((char*)userHeapStartAddr());
    80004670:	00000097          	auipc	ra,0x0
    80004674:	f3c080e7          	jalr	-196(ra) # 800045ac <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004678:	00a4b023          	sd	a0,0(s1)
        head->size = ((size_t)userHeapEndAddr() - (size_t)userHeapStartAddr()); // HEAP_END_ADDR je adresa nakon kraja bloka
    8000467c:	00000097          	auipc	ra,0x0
    80004680:	f5c080e7          	jalr	-164(ra) # 800045d8 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    80004684:	00050493          	mv	s1,a0
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	f24080e7          	jalr	-220(ra) # 800045ac <_ZN15MemoryAllocator17userHeapStartAddrEv>
    80004690:	0009b783          	ld	a5,0(s3)
    80004694:	40a484b3          	sub	s1,s1,a0
    80004698:	0097b423          	sd	s1,8(a5)
        head->next = nullptr;
    8000469c:	0007b823          	sd	zero,16(a5)
    800046a0:	f95ff06f          	j	80004634 <_ZN15MemoryAllocator9mem_allocEm+0x38>
                if(prev == nullptr) { // ako smo na head pokazivacu
    800046a4:	00068e63          	beqz	a3,800046c0 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800046a8:	0106b783          	ld	a5,16(a3)
    800046ac:	04078863          	beqz	a5,800046fc <_ZN15MemoryAllocator9mem_allocEm+0x100>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800046b0:	0107b783          	ld	a5,16(a5)
    800046b4:	00f6b823          	sd	a5,16(a3)
                allocatedSize = curr->size;
    800046b8:	00048613          	mv	a2,s1
    800046bc:	0a80006f          	j	80004764 <_ZN15MemoryAllocator9mem_allocEm+0x168>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    800046c0:	01053783          	ld	a5,16(a0)
    800046c4:	00078a63          	beqz	a5,800046d8 <_ZN15MemoryAllocator9mem_allocEm+0xdc>
                        head = curr->next;
    800046c8:	00006717          	auipc	a4,0x6
    800046cc:	eef73023          	sd	a5,-288(a4) # 8000a5a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800046d0:	00048613          	mv	a2,s1
    800046d4:	0900006f          	j	80004764 <_ZN15MemoryAllocator9mem_allocEm+0x168>
                        head = (FreeSegment*)userHeapEndAddr();
    800046d8:	00000097          	auipc	ra,0x0
    800046dc:	f00080e7          	jalr	-256(ra) # 800045d8 <_ZN15MemoryAllocator15userHeapEndAddrEv>
    800046e0:	00006797          	auipc	a5,0x6
    800046e4:	eca7b423          	sd	a0,-312(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    800046e8:	00048613          	mv	a2,s1
    800046ec:	0780006f          	j	80004764 <_ZN15MemoryAllocator9mem_allocEm+0x168>
                    head = newSeg;
    800046f0:	00006717          	auipc	a4,0x6
    800046f4:	eaf73c23          	sd	a5,-328(a4) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800046f8:	06c0006f          	j	80004764 <_ZN15MemoryAllocator9mem_allocEm+0x168>
                allocatedSize = curr->size;
    800046fc:	00048613          	mv	a2,s1
    80004700:	0640006f          	j	80004764 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        prev = curr;
    80004704:	00050693          	mv	a3,a0
        curr = curr->next;
    80004708:	01053503          	ld	a0,16(a0)
    while(curr) {
    8000470c:	06050063          	beqz	a0,8000476c <_ZN15MemoryAllocator9mem_allocEm+0x170>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80004710:	00853483          	ld	s1,8(a0)
    80004714:	0064d793          	srli	a5,s1,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80004718:	00053903          	ld	s2,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000471c:	fee4e4e3          	bltu	s1,a4,80004704 <_ZN15MemoryAllocator9mem_allocEm+0x108>
    80004720:	fec7e2e3          	bltu	a5,a2,80004704 <_ZN15MemoryAllocator9mem_allocEm+0x108>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80004724:	f8f600e3          	beq	a2,a5,800046a4 <_ZN15MemoryAllocator9mem_allocEm+0xa8>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80004728:	00661613          	slli	a2,a2,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000472c:	00c907b3          	add	a5,s2,a2
                size_t newSize = curr->size - allocatedSize;
    80004730:	40c484b3          	sub	s1,s1,a2
                newSeg->baseAddr = newBaseAddr;
    80004734:	00f7b023          	sd	a5,0(a5)
                newSeg->size = newSize;
    80004738:	0097b423          	sd	s1,8(a5)
                newSeg->next = curr->next;
    8000473c:	01053703          	ld	a4,16(a0)
    80004740:	00e7b823          	sd	a4,16(a5)
                if(!prev) {
    80004744:	fa0686e3          	beqz	a3,800046f0 <_ZN15MemoryAllocator9mem_allocEm+0xf4>
            if(!prev->next) return;
    80004748:	0106b783          	ld	a5,16(a3)
    8000474c:	00078663          	beqz	a5,80004758 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
            prev->next = curr->next;
    80004750:	0107b783          	ld	a5,16(a5)
    80004754:	00f6b823          	sd	a5,16(a3)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80004758:	0106b783          	ld	a5,16(a3)
    8000475c:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80004760:	00a6b823          	sd	a0,16(a3)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80004764:	00c93023          	sd	a2,0(s2)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80004768:	00890513          	addi	a0,s2,8
}
    8000476c:	02813083          	ld	ra,40(sp)
    80004770:	02013403          	ld	s0,32(sp)
    80004774:	01813483          	ld	s1,24(sp)
    80004778:	01013903          	ld	s2,16(sp)
    8000477c:	00813983          	ld	s3,8(sp)
    80004780:	03010113          	addi	sp,sp,48
    80004784:	00008067          	ret
        return nullptr;
    80004788:	00000513          	li	a0,0
    8000478c:	fe1ff06f          	j	8000476c <_ZN15MemoryAllocator9mem_allocEm+0x170>

0000000080004790 <_ZN15MemoryAllocator8mem_freeEPv>:
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004790:	18050e63          	beqz	a0,8000492c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
int MemoryAllocator::mem_free(void *memSegment) {
    80004794:	fc010113          	addi	sp,sp,-64
    80004798:	02113c23          	sd	ra,56(sp)
    8000479c:	02813823          	sd	s0,48(sp)
    800047a0:	02913423          	sd	s1,40(sp)
    800047a4:	03213023          	sd	s2,32(sp)
    800047a8:	01313c23          	sd	s3,24(sp)
    800047ac:	01413823          	sd	s4,16(sp)
    800047b0:	01513423          	sd	s5,8(sp)
    800047b4:	04010413          	addi	s0,sp,64
    800047b8:	00050913          	mv	s2,a0
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    800047bc:	ff850493          	addi	s1,a0,-8
    800047c0:	00000097          	auipc	ra,0x0
    800047c4:	dec080e7          	jalr	-532(ra) # 800045ac <_ZN15MemoryAllocator17userHeapStartAddrEv>
    800047c8:	00050993          	mv	s3,a0
    800047cc:	16a4e463          	bltu	s1,a0,80004934 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800047d0:	ff893a03          	ld	s4,-8(s2)
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800047d4:	fffa0a93          	addi	s5,s4,-1
    800047d8:	01548ab3          	add	s5,s1,s5
    800047dc:	00000097          	auipc	ra,0x0
    800047e0:	dfc080e7          	jalr	-516(ra) # 800045d8 <_ZN15MemoryAllocator15userHeapEndAddrEv>
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800047e4:	14aafc63          	bgeu	s5,a0,8000493c <_ZN15MemoryAllocator8mem_freeEPv+0x1ac>
    if((char*)memSegment + size - 1 >= (char*)userHeapEndAddr() || memSegment == nullptr
    800047e8:	14048e63          	beqz	s1,80004944 <_ZN15MemoryAllocator8mem_freeEPv+0x1b4>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)userHeapStartAddr();
    800047ec:	413489b3          	sub	s3,s1,s3
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    800047f0:	03f9f993          	andi	s3,s3,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    800047f4:	14099c63          	bnez	s3,8000494c <_ZN15MemoryAllocator8mem_freeEPv+0x1bc>
    800047f8:	03f00793          	li	a5,63
    800047fc:	1547fc63          	bgeu	a5,s4,80004954 <_ZN15MemoryAllocator8mem_freeEPv+0x1c4>
    if(head == (FreeSegment*)userHeapEndAddr()) { // ako je memorija puna onda samo oslobadja dati deo
    80004800:	00006797          	auipc	a5,0x6
    80004804:	da87b783          	ld	a5,-600(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    80004808:	02f50063          	beq	a0,a5,80004828 <_ZN15MemoryAllocator8mem_freeEPv+0x98>
    FreeSegment* curr = head, *prev = nullptr;
    8000480c:	00000693          	li	a3,0
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80004810:	02078a63          	beqz	a5,80004844 <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
    80004814:	0007b703          	ld	a4,0(a5)
    80004818:	02977663          	bgeu	a4,s1,80004844 <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
        prev = curr;
    8000481c:	00078693          	mv	a3,a5
        curr = curr->next;
    80004820:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80004824:	fedff06f          	j	80004810 <_ZN15MemoryAllocator8mem_freeEPv+0x80>
        newFreeSegment->size = size;
    80004828:	01493023          	sd	s4,0(s2)
        newFreeSegment->baseAddr = memSegment;
    8000482c:	fe993c23          	sd	s1,-8(s2)
        newFreeSegment->next = nullptr;
    80004830:	00093423          	sd	zero,8(s2)
        head = newFreeSegment;
    80004834:	00006797          	auipc	a5,0x6
    80004838:	d697ba23          	sd	s1,-652(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
        return 0;
    8000483c:	00000513          	li	a0,0
    80004840:	0480006f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    if(prev == nullptr) {
    80004844:	06068463          	beqz	a3,800048ac <_ZN15MemoryAllocator8mem_freeEPv+0x11c>
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80004848:	0006b703          	ld	a4,0(a3)
    8000484c:	0086b603          	ld	a2,8(a3)
    80004850:	00c70733          	add	a4,a4,a2
    80004854:	0a970663          	beq	a4,s1,80004900 <_ZN15MemoryAllocator8mem_freeEPv+0x170>
            newFreeSegment->size = size;
    80004858:	01493023          	sd	s4,0(s2)
            newFreeSegment->baseAddr = memSegment;
    8000485c:	fe993c23          	sd	s1,-8(s2)
            curr->next = prev->next;
    80004860:	0106b703          	ld	a4,16(a3)
    80004864:	00e93423          	sd	a4,8(s2)
            prev->next = curr;
    80004868:	0096b823          	sd	s1,16(a3)
        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    8000486c:	0e078c63          	beqz	a5,80004964 <_ZN15MemoryAllocator8mem_freeEPv+0x1d4>
    80004870:	0007b603          	ld	a2,0(a5)
    80004874:	0004b703          	ld	a4,0(s1)
    80004878:	0084b683          	ld	a3,8(s1)
    8000487c:	00d70733          	add	a4,a4,a3
    80004880:	08e60863          	beq	a2,a4,80004910 <_ZN15MemoryAllocator8mem_freeEPv+0x180>
    return 0;
    80004884:	00000513          	li	a0,0
}
    80004888:	03813083          	ld	ra,56(sp)
    8000488c:	03013403          	ld	s0,48(sp)
    80004890:	02813483          	ld	s1,40(sp)
    80004894:	02013903          	ld	s2,32(sp)
    80004898:	01813983          	ld	s3,24(sp)
    8000489c:	01013a03          	ld	s4,16(sp)
    800048a0:	00813a83          	ld	s5,8(sp)
    800048a4:	04010113          	addi	sp,sp,64
    800048a8:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800048ac:	0a078863          	beqz	a5,8000495c <_ZN15MemoryAllocator8mem_freeEPv+0x1cc>
            newFreeSegment->size = size;
    800048b0:	01493023          	sd	s4,0(s2)
            newFreeSegment->baseAddr = memSegment;
    800048b4:	fe993c23          	sd	s1,-8(s2)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800048b8:	00006797          	auipc	a5,0x6
    800048bc:	cf07b783          	ld	a5,-784(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800048c0:	0007b683          	ld	a3,0(a5)
    800048c4:	01448733          	add	a4,s1,s4
    800048c8:	00e68c63          	beq	a3,a4,800048e0 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
                newFreeSegment->next = head;
    800048cc:	00f93423          	sd	a5,8(s2)
            head = newFreeSegment;
    800048d0:	00006797          	auipc	a5,0x6
    800048d4:	cc97bc23          	sd	s1,-808(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
            return 0;
    800048d8:	00000513          	li	a0,0
    800048dc:	fadff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
                newFreeSegment->size += head->size;
    800048e0:	0087b783          	ld	a5,8(a5)
    800048e4:	01478a33          	add	s4,a5,s4
    800048e8:	01493023          	sd	s4,0(s2)
                newFreeSegment->next = head->next;
    800048ec:	00006797          	auipc	a5,0x6
    800048f0:	cbc7b783          	ld	a5,-836(a5) # 8000a5a8 <_ZN15MemoryAllocator4headE>
    800048f4:	0107b783          	ld	a5,16(a5)
    800048f8:	00f93423          	sd	a5,8(s2)
    800048fc:	fd5ff06f          	j	800048d0 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
    80004900:	01460a33          	add	s4,a2,s4
    80004904:	0146b423          	sd	s4,8(a3)
    80004908:	00068493          	mv	s1,a3
    8000490c:	f61ff06f          	j	8000486c <_ZN15MemoryAllocator8mem_freeEPv+0xdc>
            prev->size += curr->size;
    80004910:	0087b703          	ld	a4,8(a5)
    80004914:	00e686b3          	add	a3,a3,a4
    80004918:	00d4b423          	sd	a3,8(s1)
            prev->next = curr->next;
    8000491c:	0107b783          	ld	a5,16(a5)
    80004920:	00f4b823          	sd	a5,16(s1)
    return 0;
    80004924:	00000513          	li	a0,0
    80004928:	f61ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    8000492c:	fff00513          	li	a0,-1
}
    80004930:	00008067          	ret
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)userHeapStartAddr()) return BAD_POINTER;
    80004934:	fff00513          	li	a0,-1
    80004938:	f51ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
        return BAD_POINTER;
    8000493c:	fff00513          	li	a0,-1
    80004940:	f49ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    80004944:	fff00513          	li	a0,-1
    80004948:	f41ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    8000494c:	fff00513          	li	a0,-1
    80004950:	f39ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    80004954:	fff00513          	li	a0,-1
    80004958:	f31ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
            return BAD_POINTER;
    8000495c:	fff00513          	li	a0,-1
    80004960:	f29ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>
    return 0;
    80004964:	00000513          	li	a0,0
    80004968:	f21ff06f          	j	80004888 <_ZN15MemoryAllocator8mem_freeEPv+0xf8>

000000008000496c <_Z9kmem_initPvi>:
#include "../h/SlabAllocator.h"

struct kmem_cache_s {
};

void kmem_init(void *space, int block_num) {
    8000496c:	ff010113          	addi	sp,sp,-16
    80004970:	00113423          	sd	ra,8(sp)
    80004974:	00813023          	sd	s0,0(sp)
    80004978:	01010413          	addi	s0,sp,16
    SlabAllocator::initAllocator(space, block_num);
    8000497c:	ffffe097          	auipc	ra,0xffffe
    80004980:	cec080e7          	jalr	-788(ra) # 80002668 <_ZN13SlabAllocator13initAllocatorEPvi>
}
    80004984:	00813083          	ld	ra,8(sp)
    80004988:	00013403          	ld	s0,0(sp)
    8000498c:	01010113          	addi	sp,sp,16
    80004990:	00008067          	ret

0000000080004994 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80004994:	ff010113          	addi	sp,sp,-16
    80004998:	00113423          	sd	ra,8(sp)
    8000499c:	00813023          	sd	s0,0(sp)
    800049a0:	01010413          	addi	s0,sp,16
    return (kmem_cache_t *)SlabAllocator::createCache(name, size, ctor, dtor);
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	cec080e7          	jalr	-788(ra) # 80002690 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    800049ac:	00813083          	ld	ra,8(sp)
    800049b0:	00013403          	ld	s0,0(sp)
    800049b4:	01010113          	addi	sp,sp,16
    800049b8:	00008067          	ret

00000000800049bc <_Z17kmem_cache_shrinkP12kmem_cache_s>:

int kmem_cache_shrink(kmem_cache_t *cachep) {
    800049bc:	ff010113          	addi	sp,sp,-16
    800049c0:	00113423          	sd	ra,8(sp)
    800049c4:	00813023          	sd	s0,0(sp)
    800049c8:	01010413          	addi	s0,sp,16
    return SlabAllocator::deallocFreeSlabs((Cache*)cachep);
    800049cc:	ffffe097          	auipc	ra,0xffffe
    800049d0:	dec080e7          	jalr	-532(ra) # 800027b8 <_ZN13SlabAllocator16deallocFreeSlabsEP5Cache>
}
    800049d4:	00813083          	ld	ra,8(sp)
    800049d8:	00013403          	ld	s0,0(sp)
    800049dc:	01010113          	addi	sp,sp,16
    800049e0:	00008067          	ret

00000000800049e4 <_Z16kmem_cache_allocP12kmem_cache_s>:
void *kmem_cache_alloc(kmem_cache_t *cachep) {
    800049e4:	ff010113          	addi	sp,sp,-16
    800049e8:	00113423          	sd	ra,8(sp)
    800049ec:	00813023          	sd	s0,0(sp)
    800049f0:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocSlot((Cache*)cachep);
    800049f4:	ffffe097          	auipc	ra,0xffffe
    800049f8:	d1c080e7          	jalr	-740(ra) # 80002710 <_ZN13SlabAllocator9allocSlotEP5Cache>
}
    800049fc:	00813083          	ld	ra,8(sp)
    80004a00:	00013403          	ld	s0,0(sp)
    80004a04:	01010113          	addi	sp,sp,16
    80004a08:	00008067          	ret

0000000080004a0c <_Z15kmem_cache_freeP12kmem_cache_sPv>:
void kmem_cache_free(kmem_cache_t *cachep, void *objp) {
    80004a0c:	ff010113          	addi	sp,sp,-16
    80004a10:	00113423          	sd	ra,8(sp)
    80004a14:	00813023          	sd	s0,0(sp)
    80004a18:	01010413          	addi	s0,sp,16
    SlabAllocator::freeSlot((Cache*)cachep, objp);
    80004a1c:	ffffe097          	auipc	ra,0xffffe
    80004a20:	d20080e7          	jalr	-736(ra) # 8000273c <_ZN13SlabAllocator8freeSlotEP5CachePv>
}
    80004a24:	00813083          	ld	ra,8(sp)
    80004a28:	00013403          	ld	s0,0(sp)
    80004a2c:	01010113          	addi	sp,sp,16
    80004a30:	00008067          	ret

0000000080004a34 <_Z7kmallocm>:

void *kmalloc(size_t size) {
    80004a34:	ff010113          	addi	sp,sp,-16
    80004a38:	00113423          	sd	ra,8(sp)
    80004a3c:	00813023          	sd	s0,0(sp)
    80004a40:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocBuff(size);
    80004a44:	ffffe097          	auipc	ra,0xffffe
    80004a48:	dc4080e7          	jalr	-572(ra) # 80002808 <_ZN13SlabAllocator9allocBuffEm>
}
    80004a4c:	00813083          	ld	ra,8(sp)
    80004a50:	00013403          	ld	s0,0(sp)
    80004a54:	01010113          	addi	sp,sp,16
    80004a58:	00008067          	ret

0000000080004a5c <_Z5kfreePKv>:

void kfree(const void *objp) {
    80004a5c:	ff010113          	addi	sp,sp,-16
    80004a60:	00113423          	sd	ra,8(sp)
    80004a64:	00813023          	sd	s0,0(sp)
    80004a68:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuff(objp);
    80004a6c:	ffffe097          	auipc	ra,0xffffe
    80004a70:	dc8080e7          	jalr	-568(ra) # 80002834 <_ZN13SlabAllocator8freeBuffEPKv>
}
    80004a74:	00813083          	ld	ra,8(sp)
    80004a78:	00013403          	ld	s0,0(sp)
    80004a7c:	01010113          	addi	sp,sp,16
    80004a80:	00008067          	ret

0000000080004a84 <_Z18kmem_cache_destroyP12kmem_cache_s>:

void kmem_cache_destroy(kmem_cache_t *cachep) {
    80004a84:	ff010113          	addi	sp,sp,-16
    80004a88:	00113423          	sd	ra,8(sp)
    80004a8c:	00813023          	sd	s0,0(sp)
    80004a90:	01010413          	addi	s0,sp,16
    SlabAllocator::deallocCache((Cache*)cachep);
    80004a94:	ffffe097          	auipc	ra,0xffffe
    80004a98:	d4c080e7          	jalr	-692(ra) # 800027e0 <_ZN13SlabAllocator12deallocCacheEP5Cache>
}
    80004a9c:	00813083          	ld	ra,8(sp)
    80004aa0:	00013403          	ld	s0,0(sp)
    80004aa4:	01010113          	addi	sp,sp,16
    80004aa8:	00008067          	ret

0000000080004aac <_Z15kmem_cache_infoP12kmem_cache_s>:
void kmem_cache_info(kmem_cache_t *cachep) {
    80004aac:	ff010113          	addi	sp,sp,-16
    80004ab0:	00113423          	sd	ra,8(sp)
    80004ab4:	00813023          	sd	s0,0(sp)
    80004ab8:	01010413          	addi	s0,sp,16
    SlabAllocator::printCacheInfo((Cache*)cachep);
    80004abc:	ffffe097          	auipc	ra,0xffffe
    80004ac0:	cd4080e7          	jalr	-812(ra) # 80002790 <_ZN13SlabAllocator14printCacheInfoEP5Cache>
}
    80004ac4:	00813083          	ld	ra,8(sp)
    80004ac8:	00013403          	ld	s0,0(sp)
    80004acc:	01010113          	addi	sp,sp,16
    80004ad0:	00008067          	ret

0000000080004ad4 <_Z16kmem_cache_errorP12kmem_cache_s>:
int kmem_cache_error(kmem_cache_t *cachep) {
    80004ad4:	ff010113          	addi	sp,sp,-16
    80004ad8:	00113423          	sd	ra,8(sp)
    80004adc:	00813023          	sd	s0,0(sp)
    80004ae0:	01010413          	addi	s0,sp,16
    return SlabAllocator::printErrorMessage((Cache*)cachep);
    80004ae4:	ffffe097          	auipc	ra,0xffffe
    80004ae8:	c84080e7          	jalr	-892(ra) # 80002768 <_ZN13SlabAllocator17printErrorMessageEP5Cache>
    80004aec:	00813083          	ld	ra,8(sp)
    80004af0:	00013403          	ld	s0,0(sp)
    80004af4:	01010113          	addi	sp,sp,16
    80004af8:	00008067          	ret

0000000080004afc <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004afc:	fd010113          	addi	sp,sp,-48
    80004b00:	02113423          	sd	ra,40(sp)
    80004b04:	02813023          	sd	s0,32(sp)
    80004b08:	00913c23          	sd	s1,24(sp)
    80004b0c:	01213823          	sd	s2,16(sp)
    80004b10:	01313423          	sd	s3,8(sp)
    80004b14:	03010413          	addi	s0,sp,48
    80004b18:	00050493          	mv	s1,a0
    80004b1c:	00058993          	mv	s3,a1
    80004b20:	0015879b          	addiw	a5,a1,1
    80004b24:	0007851b          	sext.w	a0,a5
    80004b28:	00f4a023          	sw	a5,0(s1)
    80004b2c:	0004a823          	sw	zero,16(s1)
    80004b30:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004b34:	00251513          	slli	a0,a0,0x2
    80004b38:	ffffc097          	auipc	ra,0xffffc
    80004b3c:	65c080e7          	jalr	1628(ra) # 80001194 <_Z9mem_allocm>
    80004b40:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004b44:	01000513          	li	a0,16
    80004b48:	fffff097          	auipc	ra,0xfffff
    80004b4c:	a9c080e7          	jalr	-1380(ra) # 800035e4 <_ZN9SemaphorenwEm>
    80004b50:	00050913          	mv	s2,a0
    80004b54:	00050863          	beqz	a0,80004b64 <_ZN9BufferCPPC1Ei+0x68>
    80004b58:	00000593          	li	a1,0
    80004b5c:	fffff097          	auipc	ra,0xfffff
    80004b60:	980080e7          	jalr	-1664(ra) # 800034dc <_ZN9SemaphoreC1Ej>
    80004b64:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004b68:	01000513          	li	a0,16
    80004b6c:	fffff097          	auipc	ra,0xfffff
    80004b70:	a78080e7          	jalr	-1416(ra) # 800035e4 <_ZN9SemaphorenwEm>
    80004b74:	00050913          	mv	s2,a0
    80004b78:	00050863          	beqz	a0,80004b88 <_ZN9BufferCPPC1Ei+0x8c>
    80004b7c:	00098593          	mv	a1,s3
    80004b80:	fffff097          	auipc	ra,0xfffff
    80004b84:	95c080e7          	jalr	-1700(ra) # 800034dc <_ZN9SemaphoreC1Ej>
    80004b88:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80004b8c:	01000513          	li	a0,16
    80004b90:	fffff097          	auipc	ra,0xfffff
    80004b94:	a54080e7          	jalr	-1452(ra) # 800035e4 <_ZN9SemaphorenwEm>
    80004b98:	00050913          	mv	s2,a0
    80004b9c:	00050863          	beqz	a0,80004bac <_ZN9BufferCPPC1Ei+0xb0>
    80004ba0:	00100593          	li	a1,1
    80004ba4:	fffff097          	auipc	ra,0xfffff
    80004ba8:	938080e7          	jalr	-1736(ra) # 800034dc <_ZN9SemaphoreC1Ej>
    80004bac:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004bb0:	01000513          	li	a0,16
    80004bb4:	fffff097          	auipc	ra,0xfffff
    80004bb8:	a30080e7          	jalr	-1488(ra) # 800035e4 <_ZN9SemaphorenwEm>
    80004bbc:	00050913          	mv	s2,a0
    80004bc0:	00050863          	beqz	a0,80004bd0 <_ZN9BufferCPPC1Ei+0xd4>
    80004bc4:	00100593          	li	a1,1
    80004bc8:	fffff097          	auipc	ra,0xfffff
    80004bcc:	914080e7          	jalr	-1772(ra) # 800034dc <_ZN9SemaphoreC1Ej>
    80004bd0:	0324b823          	sd	s2,48(s1)
}
    80004bd4:	02813083          	ld	ra,40(sp)
    80004bd8:	02013403          	ld	s0,32(sp)
    80004bdc:	01813483          	ld	s1,24(sp)
    80004be0:	01013903          	ld	s2,16(sp)
    80004be4:	00813983          	ld	s3,8(sp)
    80004be8:	03010113          	addi	sp,sp,48
    80004bec:	00008067          	ret
    80004bf0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004bf4:	00090513          	mv	a0,s2
    80004bf8:	fffff097          	auipc	ra,0xfffff
    80004bfc:	984080e7          	jalr	-1660(ra) # 8000357c <_ZN9SemaphoredlEPv>
    80004c00:	00048513          	mv	a0,s1
    80004c04:	00007097          	auipc	ra,0x7
    80004c08:	a74080e7          	jalr	-1420(ra) # 8000b678 <_Unwind_Resume>
    80004c0c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004c10:	00090513          	mv	a0,s2
    80004c14:	fffff097          	auipc	ra,0xfffff
    80004c18:	968080e7          	jalr	-1688(ra) # 8000357c <_ZN9SemaphoredlEPv>
    80004c1c:	00048513          	mv	a0,s1
    80004c20:	00007097          	auipc	ra,0x7
    80004c24:	a58080e7          	jalr	-1448(ra) # 8000b678 <_Unwind_Resume>
    80004c28:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004c2c:	00090513          	mv	a0,s2
    80004c30:	fffff097          	auipc	ra,0xfffff
    80004c34:	94c080e7          	jalr	-1716(ra) # 8000357c <_ZN9SemaphoredlEPv>
    80004c38:	00048513          	mv	a0,s1
    80004c3c:	00007097          	auipc	ra,0x7
    80004c40:	a3c080e7          	jalr	-1476(ra) # 8000b678 <_Unwind_Resume>
    80004c44:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004c48:	00090513          	mv	a0,s2
    80004c4c:	fffff097          	auipc	ra,0xfffff
    80004c50:	930080e7          	jalr	-1744(ra) # 8000357c <_ZN9SemaphoredlEPv>
    80004c54:	00048513          	mv	a0,s1
    80004c58:	00007097          	auipc	ra,0x7
    80004c5c:	a20080e7          	jalr	-1504(ra) # 8000b678 <_Unwind_Resume>

0000000080004c60 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004c60:	fe010113          	addi	sp,sp,-32
    80004c64:	00113c23          	sd	ra,24(sp)
    80004c68:	00813823          	sd	s0,16(sp)
    80004c6c:	00913423          	sd	s1,8(sp)
    80004c70:	01213023          	sd	s2,0(sp)
    80004c74:	02010413          	addi	s0,sp,32
    80004c78:	00050493          	mv	s1,a0
    80004c7c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004c80:	01853503          	ld	a0,24(a0)
    80004c84:	fffff097          	auipc	ra,0xfffff
    80004c88:	8a0080e7          	jalr	-1888(ra) # 80003524 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004c8c:	0304b503          	ld	a0,48(s1)
    80004c90:	fffff097          	auipc	ra,0xfffff
    80004c94:	894080e7          	jalr	-1900(ra) # 80003524 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004c98:	0084b783          	ld	a5,8(s1)
    80004c9c:	0144a703          	lw	a4,20(s1)
    80004ca0:	00271713          	slli	a4,a4,0x2
    80004ca4:	00e787b3          	add	a5,a5,a4
    80004ca8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004cac:	0144a783          	lw	a5,20(s1)
    80004cb0:	0017879b          	addiw	a5,a5,1
    80004cb4:	0004a703          	lw	a4,0(s1)
    80004cb8:	02e7e7bb          	remw	a5,a5,a4
    80004cbc:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004cc0:	0304b503          	ld	a0,48(s1)
    80004cc4:	fffff097          	auipc	ra,0xfffff
    80004cc8:	88c080e7          	jalr	-1908(ra) # 80003550 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004ccc:	0204b503          	ld	a0,32(s1)
    80004cd0:	fffff097          	auipc	ra,0xfffff
    80004cd4:	880080e7          	jalr	-1920(ra) # 80003550 <_ZN9Semaphore6signalEv>

}
    80004cd8:	01813083          	ld	ra,24(sp)
    80004cdc:	01013403          	ld	s0,16(sp)
    80004ce0:	00813483          	ld	s1,8(sp)
    80004ce4:	00013903          	ld	s2,0(sp)
    80004ce8:	02010113          	addi	sp,sp,32
    80004cec:	00008067          	ret

0000000080004cf0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004cf0:	fe010113          	addi	sp,sp,-32
    80004cf4:	00113c23          	sd	ra,24(sp)
    80004cf8:	00813823          	sd	s0,16(sp)
    80004cfc:	00913423          	sd	s1,8(sp)
    80004d00:	01213023          	sd	s2,0(sp)
    80004d04:	02010413          	addi	s0,sp,32
    80004d08:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004d0c:	02053503          	ld	a0,32(a0)
    80004d10:	fffff097          	auipc	ra,0xfffff
    80004d14:	814080e7          	jalr	-2028(ra) # 80003524 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004d18:	0284b503          	ld	a0,40(s1)
    80004d1c:	fffff097          	auipc	ra,0xfffff
    80004d20:	808080e7          	jalr	-2040(ra) # 80003524 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004d24:	0084b703          	ld	a4,8(s1)
    80004d28:	0104a783          	lw	a5,16(s1)
    80004d2c:	00279693          	slli	a3,a5,0x2
    80004d30:	00d70733          	add	a4,a4,a3
    80004d34:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004d38:	0017879b          	addiw	a5,a5,1
    80004d3c:	0004a703          	lw	a4,0(s1)
    80004d40:	02e7e7bb          	remw	a5,a5,a4
    80004d44:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004d48:	0284b503          	ld	a0,40(s1)
    80004d4c:	fffff097          	auipc	ra,0xfffff
    80004d50:	804080e7          	jalr	-2044(ra) # 80003550 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004d54:	0184b503          	ld	a0,24(s1)
    80004d58:	ffffe097          	auipc	ra,0xffffe
    80004d5c:	7f8080e7          	jalr	2040(ra) # 80003550 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004d60:	00090513          	mv	a0,s2
    80004d64:	01813083          	ld	ra,24(sp)
    80004d68:	01013403          	ld	s0,16(sp)
    80004d6c:	00813483          	ld	s1,8(sp)
    80004d70:	00013903          	ld	s2,0(sp)
    80004d74:	02010113          	addi	sp,sp,32
    80004d78:	00008067          	ret

0000000080004d7c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004d7c:	fe010113          	addi	sp,sp,-32
    80004d80:	00113c23          	sd	ra,24(sp)
    80004d84:	00813823          	sd	s0,16(sp)
    80004d88:	00913423          	sd	s1,8(sp)
    80004d8c:	01213023          	sd	s2,0(sp)
    80004d90:	02010413          	addi	s0,sp,32
    80004d94:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004d98:	02853503          	ld	a0,40(a0)
    80004d9c:	ffffe097          	auipc	ra,0xffffe
    80004da0:	788080e7          	jalr	1928(ra) # 80003524 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004da4:	0304b503          	ld	a0,48(s1)
    80004da8:	ffffe097          	auipc	ra,0xffffe
    80004dac:	77c080e7          	jalr	1916(ra) # 80003524 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004db0:	0144a783          	lw	a5,20(s1)
    80004db4:	0104a903          	lw	s2,16(s1)
    80004db8:	0327ce63          	blt	a5,s2,80004df4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004dbc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004dc0:	0304b503          	ld	a0,48(s1)
    80004dc4:	ffffe097          	auipc	ra,0xffffe
    80004dc8:	78c080e7          	jalr	1932(ra) # 80003550 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004dcc:	0284b503          	ld	a0,40(s1)
    80004dd0:	ffffe097          	auipc	ra,0xffffe
    80004dd4:	780080e7          	jalr	1920(ra) # 80003550 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004dd8:	00090513          	mv	a0,s2
    80004ddc:	01813083          	ld	ra,24(sp)
    80004de0:	01013403          	ld	s0,16(sp)
    80004de4:	00813483          	ld	s1,8(sp)
    80004de8:	00013903          	ld	s2,0(sp)
    80004dec:	02010113          	addi	sp,sp,32
    80004df0:	00008067          	ret
        ret = cap - head + tail;
    80004df4:	0004a703          	lw	a4,0(s1)
    80004df8:	4127093b          	subw	s2,a4,s2
    80004dfc:	00f9093b          	addw	s2,s2,a5
    80004e00:	fc1ff06f          	j	80004dc0 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004e04 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004e04:	fe010113          	addi	sp,sp,-32
    80004e08:	00113c23          	sd	ra,24(sp)
    80004e0c:	00813823          	sd	s0,16(sp)
    80004e10:	00913423          	sd	s1,8(sp)
    80004e14:	02010413          	addi	s0,sp,32
    80004e18:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004e1c:	00a00513          	li	a0,10
    80004e20:	fffff097          	auipc	ra,0xfffff
    80004e24:	894080e7          	jalr	-1900(ra) # 800036b4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004e28:	00003517          	auipc	a0,0x3
    80004e2c:	50050513          	addi	a0,a0,1280 # 80008328 <CONSOLE_STATUS+0x318>
    80004e30:	ffffe097          	auipc	ra,0xffffe
    80004e34:	a30080e7          	jalr	-1488(ra) # 80002860 <_Z11printStringPKc>
    while (getCnt()) {
    80004e38:	00048513          	mv	a0,s1
    80004e3c:	00000097          	auipc	ra,0x0
    80004e40:	f40080e7          	jalr	-192(ra) # 80004d7c <_ZN9BufferCPP6getCntEv>
    80004e44:	02050c63          	beqz	a0,80004e7c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004e48:	0084b783          	ld	a5,8(s1)
    80004e4c:	0104a703          	lw	a4,16(s1)
    80004e50:	00271713          	slli	a4,a4,0x2
    80004e54:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004e58:	0007c503          	lbu	a0,0(a5)
    80004e5c:	fffff097          	auipc	ra,0xfffff
    80004e60:	858080e7          	jalr	-1960(ra) # 800036b4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004e64:	0104a783          	lw	a5,16(s1)
    80004e68:	0017879b          	addiw	a5,a5,1
    80004e6c:	0004a703          	lw	a4,0(s1)
    80004e70:	02e7e7bb          	remw	a5,a5,a4
    80004e74:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004e78:	fc1ff06f          	j	80004e38 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004e7c:	02100513          	li	a0,33
    80004e80:	fffff097          	auipc	ra,0xfffff
    80004e84:	834080e7          	jalr	-1996(ra) # 800036b4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004e88:	00a00513          	li	a0,10
    80004e8c:	fffff097          	auipc	ra,0xfffff
    80004e90:	828080e7          	jalr	-2008(ra) # 800036b4 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004e94:	0084b503          	ld	a0,8(s1)
    80004e98:	ffffc097          	auipc	ra,0xffffc
    80004e9c:	33c080e7          	jalr	828(ra) # 800011d4 <_Z8mem_freePv>
    delete itemAvailable;
    80004ea0:	0204b503          	ld	a0,32(s1)
    80004ea4:	00050863          	beqz	a0,80004eb4 <_ZN9BufferCPPD1Ev+0xb0>
    80004ea8:	00053783          	ld	a5,0(a0)
    80004eac:	0087b783          	ld	a5,8(a5)
    80004eb0:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004eb4:	0184b503          	ld	a0,24(s1)
    80004eb8:	00050863          	beqz	a0,80004ec8 <_ZN9BufferCPPD1Ev+0xc4>
    80004ebc:	00053783          	ld	a5,0(a0)
    80004ec0:	0087b783          	ld	a5,8(a5)
    80004ec4:	000780e7          	jalr	a5
    delete mutexTail;
    80004ec8:	0304b503          	ld	a0,48(s1)
    80004ecc:	00050863          	beqz	a0,80004edc <_ZN9BufferCPPD1Ev+0xd8>
    80004ed0:	00053783          	ld	a5,0(a0)
    80004ed4:	0087b783          	ld	a5,8(a5)
    80004ed8:	000780e7          	jalr	a5
    delete mutexHead;
    80004edc:	0284b503          	ld	a0,40(s1)
    80004ee0:	00050863          	beqz	a0,80004ef0 <_ZN9BufferCPPD1Ev+0xec>
    80004ee4:	00053783          	ld	a5,0(a0)
    80004ee8:	0087b783          	ld	a5,8(a5)
    80004eec:	000780e7          	jalr	a5
}
    80004ef0:	01813083          	ld	ra,24(sp)
    80004ef4:	01013403          	ld	s0,16(sp)
    80004ef8:	00813483          	ld	s1,8(sp)
    80004efc:	02010113          	addi	sp,sp,32
    80004f00:	00008067          	ret

0000000080004f04 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004f04:	fe010113          	addi	sp,sp,-32
    80004f08:	00113c23          	sd	ra,24(sp)
    80004f0c:	00813823          	sd	s0,16(sp)
    80004f10:	00913423          	sd	s1,8(sp)
    80004f14:	01213023          	sd	s2,0(sp)
    80004f18:	02010413          	addi	s0,sp,32
    80004f1c:	00050493          	mv	s1,a0
    80004f20:	00058913          	mv	s2,a1
    80004f24:	0015879b          	addiw	a5,a1,1
    80004f28:	0007851b          	sext.w	a0,a5
    80004f2c:	00f4a023          	sw	a5,0(s1)
    80004f30:	0004a823          	sw	zero,16(s1)
    80004f34:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004f38:	00251513          	slli	a0,a0,0x2
    80004f3c:	ffffc097          	auipc	ra,0xffffc
    80004f40:	258080e7          	jalr	600(ra) # 80001194 <_Z9mem_allocm>
    80004f44:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004f48:	00000593          	li	a1,0
    80004f4c:	02048513          	addi	a0,s1,32
    80004f50:	ffffc097          	auipc	ra,0xffffc
    80004f54:	410080e7          	jalr	1040(ra) # 80001360 <_Z8sem_openPP3SCBj>
    sem_open(&spaceAvailable, _cap);
    80004f58:	00090593          	mv	a1,s2
    80004f5c:	01848513          	addi	a0,s1,24
    80004f60:	ffffc097          	auipc	ra,0xffffc
    80004f64:	400080e7          	jalr	1024(ra) # 80001360 <_Z8sem_openPP3SCBj>
    sem_open(&mutexHead, 1);
    80004f68:	00100593          	li	a1,1
    80004f6c:	02848513          	addi	a0,s1,40
    80004f70:	ffffc097          	auipc	ra,0xffffc
    80004f74:	3f0080e7          	jalr	1008(ra) # 80001360 <_Z8sem_openPP3SCBj>
    sem_open(&mutexTail, 1);
    80004f78:	00100593          	li	a1,1
    80004f7c:	03048513          	addi	a0,s1,48
    80004f80:	ffffc097          	auipc	ra,0xffffc
    80004f84:	3e0080e7          	jalr	992(ra) # 80001360 <_Z8sem_openPP3SCBj>
}
    80004f88:	01813083          	ld	ra,24(sp)
    80004f8c:	01013403          	ld	s0,16(sp)
    80004f90:	00813483          	ld	s1,8(sp)
    80004f94:	00013903          	ld	s2,0(sp)
    80004f98:	02010113          	addi	sp,sp,32
    80004f9c:	00008067          	ret

0000000080004fa0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004fa0:	fe010113          	addi	sp,sp,-32
    80004fa4:	00113c23          	sd	ra,24(sp)
    80004fa8:	00813823          	sd	s0,16(sp)
    80004fac:	00913423          	sd	s1,8(sp)
    80004fb0:	01213023          	sd	s2,0(sp)
    80004fb4:	02010413          	addi	s0,sp,32
    80004fb8:	00050493          	mv	s1,a0
    80004fbc:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004fc0:	01853503          	ld	a0,24(a0)
    80004fc4:	ffffc097          	auipc	ra,0xffffc
    80004fc8:	3e4080e7          	jalr	996(ra) # 800013a8 <_Z8sem_waitP3SCB>

    sem_wait(mutexTail);
    80004fcc:	0304b503          	ld	a0,48(s1)
    80004fd0:	ffffc097          	auipc	ra,0xffffc
    80004fd4:	3d8080e7          	jalr	984(ra) # 800013a8 <_Z8sem_waitP3SCB>
    buffer[tail] = val;
    80004fd8:	0084b783          	ld	a5,8(s1)
    80004fdc:	0144a703          	lw	a4,20(s1)
    80004fe0:	00271713          	slli	a4,a4,0x2
    80004fe4:	00e787b3          	add	a5,a5,a4
    80004fe8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004fec:	0144a783          	lw	a5,20(s1)
    80004ff0:	0017879b          	addiw	a5,a5,1
    80004ff4:	0004a703          	lw	a4,0(s1)
    80004ff8:	02e7e7bb          	remw	a5,a5,a4
    80004ffc:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005000:	0304b503          	ld	a0,48(s1)
    80005004:	ffffc097          	auipc	ra,0xffffc
    80005008:	3ec080e7          	jalr	1004(ra) # 800013f0 <_Z10sem_signalP3SCB>

    sem_signal(itemAvailable);
    8000500c:	0204b503          	ld	a0,32(s1)
    80005010:	ffffc097          	auipc	ra,0xffffc
    80005014:	3e0080e7          	jalr	992(ra) # 800013f0 <_Z10sem_signalP3SCB>

}
    80005018:	01813083          	ld	ra,24(sp)
    8000501c:	01013403          	ld	s0,16(sp)
    80005020:	00813483          	ld	s1,8(sp)
    80005024:	00013903          	ld	s2,0(sp)
    80005028:	02010113          	addi	sp,sp,32
    8000502c:	00008067          	ret

0000000080005030 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005030:	fe010113          	addi	sp,sp,-32
    80005034:	00113c23          	sd	ra,24(sp)
    80005038:	00813823          	sd	s0,16(sp)
    8000503c:	00913423          	sd	s1,8(sp)
    80005040:	01213023          	sd	s2,0(sp)
    80005044:	02010413          	addi	s0,sp,32
    80005048:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000504c:	02053503          	ld	a0,32(a0)
    80005050:	ffffc097          	auipc	ra,0xffffc
    80005054:	358080e7          	jalr	856(ra) # 800013a8 <_Z8sem_waitP3SCB>

    sem_wait(mutexHead);
    80005058:	0284b503          	ld	a0,40(s1)
    8000505c:	ffffc097          	auipc	ra,0xffffc
    80005060:	34c080e7          	jalr	844(ra) # 800013a8 <_Z8sem_waitP3SCB>

    int ret = buffer[head];
    80005064:	0084b703          	ld	a4,8(s1)
    80005068:	0104a783          	lw	a5,16(s1)
    8000506c:	00279693          	slli	a3,a5,0x2
    80005070:	00d70733          	add	a4,a4,a3
    80005074:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005078:	0017879b          	addiw	a5,a5,1
    8000507c:	0004a703          	lw	a4,0(s1)
    80005080:	02e7e7bb          	remw	a5,a5,a4
    80005084:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005088:	0284b503          	ld	a0,40(s1)
    8000508c:	ffffc097          	auipc	ra,0xffffc
    80005090:	364080e7          	jalr	868(ra) # 800013f0 <_Z10sem_signalP3SCB>

    sem_signal(spaceAvailable);
    80005094:	0184b503          	ld	a0,24(s1)
    80005098:	ffffc097          	auipc	ra,0xffffc
    8000509c:	358080e7          	jalr	856(ra) # 800013f0 <_Z10sem_signalP3SCB>

    return ret;
}
    800050a0:	00090513          	mv	a0,s2
    800050a4:	01813083          	ld	ra,24(sp)
    800050a8:	01013403          	ld	s0,16(sp)
    800050ac:	00813483          	ld	s1,8(sp)
    800050b0:	00013903          	ld	s2,0(sp)
    800050b4:	02010113          	addi	sp,sp,32
    800050b8:	00008067          	ret

00000000800050bc <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800050bc:	fe010113          	addi	sp,sp,-32
    800050c0:	00113c23          	sd	ra,24(sp)
    800050c4:	00813823          	sd	s0,16(sp)
    800050c8:	00913423          	sd	s1,8(sp)
    800050cc:	01213023          	sd	s2,0(sp)
    800050d0:	02010413          	addi	s0,sp,32
    800050d4:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800050d8:	02853503          	ld	a0,40(a0)
    800050dc:	ffffc097          	auipc	ra,0xffffc
    800050e0:	2cc080e7          	jalr	716(ra) # 800013a8 <_Z8sem_waitP3SCB>
    sem_wait(mutexTail);
    800050e4:	0304b503          	ld	a0,48(s1)
    800050e8:	ffffc097          	auipc	ra,0xffffc
    800050ec:	2c0080e7          	jalr	704(ra) # 800013a8 <_Z8sem_waitP3SCB>

    if (tail >= head) {
    800050f0:	0144a783          	lw	a5,20(s1)
    800050f4:	0104a903          	lw	s2,16(s1)
    800050f8:	0327ce63          	blt	a5,s2,80005134 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800050fc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005100:	0304b503          	ld	a0,48(s1)
    80005104:	ffffc097          	auipc	ra,0xffffc
    80005108:	2ec080e7          	jalr	748(ra) # 800013f0 <_Z10sem_signalP3SCB>
    sem_signal(mutexHead);
    8000510c:	0284b503          	ld	a0,40(s1)
    80005110:	ffffc097          	auipc	ra,0xffffc
    80005114:	2e0080e7          	jalr	736(ra) # 800013f0 <_Z10sem_signalP3SCB>

    return ret;
}
    80005118:	00090513          	mv	a0,s2
    8000511c:	01813083          	ld	ra,24(sp)
    80005120:	01013403          	ld	s0,16(sp)
    80005124:	00813483          	ld	s1,8(sp)
    80005128:	00013903          	ld	s2,0(sp)
    8000512c:	02010113          	addi	sp,sp,32
    80005130:	00008067          	ret
        ret = cap - head + tail;
    80005134:	0004a703          	lw	a4,0(s1)
    80005138:	4127093b          	subw	s2,a4,s2
    8000513c:	00f9093b          	addw	s2,s2,a5
    80005140:	fc1ff06f          	j	80005100 <_ZN6Buffer6getCntEv+0x44>

0000000080005144 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005144:	fe010113          	addi	sp,sp,-32
    80005148:	00113c23          	sd	ra,24(sp)
    8000514c:	00813823          	sd	s0,16(sp)
    80005150:	00913423          	sd	s1,8(sp)
    80005154:	02010413          	addi	s0,sp,32
    80005158:	00050493          	mv	s1,a0
    putc('\n');
    8000515c:	00a00513          	li	a0,10
    80005160:	ffffc097          	auipc	ra,0xffffc
    80005164:	388080e7          	jalr	904(ra) # 800014e8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005168:	00003517          	auipc	a0,0x3
    8000516c:	1c050513          	addi	a0,a0,448 # 80008328 <CONSOLE_STATUS+0x318>
    80005170:	ffffd097          	auipc	ra,0xffffd
    80005174:	6f0080e7          	jalr	1776(ra) # 80002860 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005178:	00048513          	mv	a0,s1
    8000517c:	00000097          	auipc	ra,0x0
    80005180:	f40080e7          	jalr	-192(ra) # 800050bc <_ZN6Buffer6getCntEv>
    80005184:	02a05c63          	blez	a0,800051bc <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005188:	0084b783          	ld	a5,8(s1)
    8000518c:	0104a703          	lw	a4,16(s1)
    80005190:	00271713          	slli	a4,a4,0x2
    80005194:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005198:	0007c503          	lbu	a0,0(a5)
    8000519c:	ffffc097          	auipc	ra,0xffffc
    800051a0:	34c080e7          	jalr	844(ra) # 800014e8 <_Z4putcc>
        head = (head + 1) % cap;
    800051a4:	0104a783          	lw	a5,16(s1)
    800051a8:	0017879b          	addiw	a5,a5,1
    800051ac:	0004a703          	lw	a4,0(s1)
    800051b0:	02e7e7bb          	remw	a5,a5,a4
    800051b4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800051b8:	fc1ff06f          	j	80005178 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800051bc:	02100513          	li	a0,33
    800051c0:	ffffc097          	auipc	ra,0xffffc
    800051c4:	328080e7          	jalr	808(ra) # 800014e8 <_Z4putcc>
    putc('\n');
    800051c8:	00a00513          	li	a0,10
    800051cc:	ffffc097          	auipc	ra,0xffffc
    800051d0:	31c080e7          	jalr	796(ra) # 800014e8 <_Z4putcc>
    mem_free(buffer);
    800051d4:	0084b503          	ld	a0,8(s1)
    800051d8:	ffffc097          	auipc	ra,0xffffc
    800051dc:	ffc080e7          	jalr	-4(ra) # 800011d4 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800051e0:	0204b503          	ld	a0,32(s1)
    800051e4:	ffffc097          	auipc	ra,0xffffc
    800051e8:	24c080e7          	jalr	588(ra) # 80001430 <_Z9sem_closeP3SCB>
    sem_close(spaceAvailable);
    800051ec:	0184b503          	ld	a0,24(s1)
    800051f0:	ffffc097          	auipc	ra,0xffffc
    800051f4:	240080e7          	jalr	576(ra) # 80001430 <_Z9sem_closeP3SCB>
    sem_close(mutexTail);
    800051f8:	0304b503          	ld	a0,48(s1)
    800051fc:	ffffc097          	auipc	ra,0xffffc
    80005200:	234080e7          	jalr	564(ra) # 80001430 <_Z9sem_closeP3SCB>
    sem_close(mutexHead);
    80005204:	0284b503          	ld	a0,40(s1)
    80005208:	ffffc097          	auipc	ra,0xffffc
    8000520c:	228080e7          	jalr	552(ra) # 80001430 <_Z9sem_closeP3SCB>
}
    80005210:	01813083          	ld	ra,24(sp)
    80005214:	01013403          	ld	s0,16(sp)
    80005218:	00813483          	ld	s1,8(sp)
    8000521c:	02010113          	addi	sp,sp,32
    80005220:	00008067          	ret

0000000080005224 <start>:
    80005224:	ff010113          	addi	sp,sp,-16
    80005228:	00813423          	sd	s0,8(sp)
    8000522c:	01010413          	addi	s0,sp,16
    80005230:	300027f3          	csrr	a5,mstatus
    80005234:	ffffe737          	lui	a4,0xffffe
    80005238:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff2fef>
    8000523c:	00e7f7b3          	and	a5,a5,a4
    80005240:	00001737          	lui	a4,0x1
    80005244:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005248:	00e7e7b3          	or	a5,a5,a4
    8000524c:	30079073          	csrw	mstatus,a5
    80005250:	00000797          	auipc	a5,0x0
    80005254:	16078793          	addi	a5,a5,352 # 800053b0 <system_main>
    80005258:	34179073          	csrw	mepc,a5
    8000525c:	00000793          	li	a5,0
    80005260:	18079073          	csrw	satp,a5
    80005264:	000107b7          	lui	a5,0x10
    80005268:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000526c:	30279073          	csrw	medeleg,a5
    80005270:	30379073          	csrw	mideleg,a5
    80005274:	104027f3          	csrr	a5,sie
    80005278:	2227e793          	ori	a5,a5,546
    8000527c:	10479073          	csrw	sie,a5
    80005280:	fff00793          	li	a5,-1
    80005284:	00a7d793          	srli	a5,a5,0xa
    80005288:	3b079073          	csrw	pmpaddr0,a5
    8000528c:	00f00793          	li	a5,15
    80005290:	3a079073          	csrw	pmpcfg0,a5
    80005294:	f14027f3          	csrr	a5,mhartid
    80005298:	0200c737          	lui	a4,0x200c
    8000529c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800052a0:	0007869b          	sext.w	a3,a5
    800052a4:	00269713          	slli	a4,a3,0x2
    800052a8:	000f4637          	lui	a2,0xf4
    800052ac:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800052b0:	00d70733          	add	a4,a4,a3
    800052b4:	0037979b          	slliw	a5,a5,0x3
    800052b8:	020046b7          	lui	a3,0x2004
    800052bc:	00d787b3          	add	a5,a5,a3
    800052c0:	00c585b3          	add	a1,a1,a2
    800052c4:	00371693          	slli	a3,a4,0x3
    800052c8:	00005717          	auipc	a4,0x5
    800052cc:	2e870713          	addi	a4,a4,744 # 8000a5b0 <timer_scratch>
    800052d0:	00b7b023          	sd	a1,0(a5)
    800052d4:	00d70733          	add	a4,a4,a3
    800052d8:	00f73c23          	sd	a5,24(a4)
    800052dc:	02c73023          	sd	a2,32(a4)
    800052e0:	34071073          	csrw	mscratch,a4
    800052e4:	00000797          	auipc	a5,0x0
    800052e8:	6ec78793          	addi	a5,a5,1772 # 800059d0 <timervec>
    800052ec:	30579073          	csrw	mtvec,a5
    800052f0:	300027f3          	csrr	a5,mstatus
    800052f4:	0087e793          	ori	a5,a5,8
    800052f8:	30079073          	csrw	mstatus,a5
    800052fc:	304027f3          	csrr	a5,mie
    80005300:	0807e793          	ori	a5,a5,128
    80005304:	30479073          	csrw	mie,a5
    80005308:	f14027f3          	csrr	a5,mhartid
    8000530c:	0007879b          	sext.w	a5,a5
    80005310:	00078213          	mv	tp,a5
    80005314:	30200073          	mret
    80005318:	00813403          	ld	s0,8(sp)
    8000531c:	01010113          	addi	sp,sp,16
    80005320:	00008067          	ret

0000000080005324 <timerinit>:
    80005324:	ff010113          	addi	sp,sp,-16
    80005328:	00813423          	sd	s0,8(sp)
    8000532c:	01010413          	addi	s0,sp,16
    80005330:	f14027f3          	csrr	a5,mhartid
    80005334:	0200c737          	lui	a4,0x200c
    80005338:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000533c:	0007869b          	sext.w	a3,a5
    80005340:	00269713          	slli	a4,a3,0x2
    80005344:	000f4637          	lui	a2,0xf4
    80005348:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000534c:	00d70733          	add	a4,a4,a3
    80005350:	0037979b          	slliw	a5,a5,0x3
    80005354:	020046b7          	lui	a3,0x2004
    80005358:	00d787b3          	add	a5,a5,a3
    8000535c:	00c585b3          	add	a1,a1,a2
    80005360:	00371693          	slli	a3,a4,0x3
    80005364:	00005717          	auipc	a4,0x5
    80005368:	24c70713          	addi	a4,a4,588 # 8000a5b0 <timer_scratch>
    8000536c:	00b7b023          	sd	a1,0(a5)
    80005370:	00d70733          	add	a4,a4,a3
    80005374:	00f73c23          	sd	a5,24(a4)
    80005378:	02c73023          	sd	a2,32(a4)
    8000537c:	34071073          	csrw	mscratch,a4
    80005380:	00000797          	auipc	a5,0x0
    80005384:	65078793          	addi	a5,a5,1616 # 800059d0 <timervec>
    80005388:	30579073          	csrw	mtvec,a5
    8000538c:	300027f3          	csrr	a5,mstatus
    80005390:	0087e793          	ori	a5,a5,8
    80005394:	30079073          	csrw	mstatus,a5
    80005398:	304027f3          	csrr	a5,mie
    8000539c:	0807e793          	ori	a5,a5,128
    800053a0:	30479073          	csrw	mie,a5
    800053a4:	00813403          	ld	s0,8(sp)
    800053a8:	01010113          	addi	sp,sp,16
    800053ac:	00008067          	ret

00000000800053b0 <system_main>:
    800053b0:	fe010113          	addi	sp,sp,-32
    800053b4:	00813823          	sd	s0,16(sp)
    800053b8:	00913423          	sd	s1,8(sp)
    800053bc:	00113c23          	sd	ra,24(sp)
    800053c0:	02010413          	addi	s0,sp,32
    800053c4:	00000097          	auipc	ra,0x0
    800053c8:	0c4080e7          	jalr	196(ra) # 80005488 <cpuid>
    800053cc:	00005497          	auipc	s1,0x5
    800053d0:	06448493          	addi	s1,s1,100 # 8000a430 <started>
    800053d4:	02050263          	beqz	a0,800053f8 <system_main+0x48>
    800053d8:	0004a783          	lw	a5,0(s1)
    800053dc:	0007879b          	sext.w	a5,a5
    800053e0:	fe078ce3          	beqz	a5,800053d8 <system_main+0x28>
    800053e4:	0ff0000f          	fence
    800053e8:	00003517          	auipc	a0,0x3
    800053ec:	f8850513          	addi	a0,a0,-120 # 80008370 <CONSOLE_STATUS+0x360>
    800053f0:	00001097          	auipc	ra,0x1
    800053f4:	a7c080e7          	jalr	-1412(ra) # 80005e6c <panic>
    800053f8:	00001097          	auipc	ra,0x1
    800053fc:	9d0080e7          	jalr	-1584(ra) # 80005dc8 <consoleinit>
    80005400:	00001097          	auipc	ra,0x1
    80005404:	15c080e7          	jalr	348(ra) # 8000655c <printfinit>
    80005408:	00003517          	auipc	a0,0x3
    8000540c:	e5850513          	addi	a0,a0,-424 # 80008260 <CONSOLE_STATUS+0x250>
    80005410:	00001097          	auipc	ra,0x1
    80005414:	ab8080e7          	jalr	-1352(ra) # 80005ec8 <__printf>
    80005418:	00003517          	auipc	a0,0x3
    8000541c:	f2850513          	addi	a0,a0,-216 # 80008340 <CONSOLE_STATUS+0x330>
    80005420:	00001097          	auipc	ra,0x1
    80005424:	aa8080e7          	jalr	-1368(ra) # 80005ec8 <__printf>
    80005428:	00003517          	auipc	a0,0x3
    8000542c:	e3850513          	addi	a0,a0,-456 # 80008260 <CONSOLE_STATUS+0x250>
    80005430:	00001097          	auipc	ra,0x1
    80005434:	a98080e7          	jalr	-1384(ra) # 80005ec8 <__printf>
    80005438:	00001097          	auipc	ra,0x1
    8000543c:	4b0080e7          	jalr	1200(ra) # 800068e8 <kinit>
    80005440:	00000097          	auipc	ra,0x0
    80005444:	148080e7          	jalr	328(ra) # 80005588 <trapinit>
    80005448:	00000097          	auipc	ra,0x0
    8000544c:	16c080e7          	jalr	364(ra) # 800055b4 <trapinithart>
    80005450:	00000097          	auipc	ra,0x0
    80005454:	5c0080e7          	jalr	1472(ra) # 80005a10 <plicinit>
    80005458:	00000097          	auipc	ra,0x0
    8000545c:	5e0080e7          	jalr	1504(ra) # 80005a38 <plicinithart>
    80005460:	00000097          	auipc	ra,0x0
    80005464:	078080e7          	jalr	120(ra) # 800054d8 <userinit>
    80005468:	0ff0000f          	fence
    8000546c:	00100793          	li	a5,1
    80005470:	00003517          	auipc	a0,0x3
    80005474:	ee850513          	addi	a0,a0,-280 # 80008358 <CONSOLE_STATUS+0x348>
    80005478:	00f4a023          	sw	a5,0(s1)
    8000547c:	00001097          	auipc	ra,0x1
    80005480:	a4c080e7          	jalr	-1460(ra) # 80005ec8 <__printf>
    80005484:	0000006f          	j	80005484 <system_main+0xd4>

0000000080005488 <cpuid>:
    80005488:	ff010113          	addi	sp,sp,-16
    8000548c:	00813423          	sd	s0,8(sp)
    80005490:	01010413          	addi	s0,sp,16
    80005494:	00020513          	mv	a0,tp
    80005498:	00813403          	ld	s0,8(sp)
    8000549c:	0005051b          	sext.w	a0,a0
    800054a0:	01010113          	addi	sp,sp,16
    800054a4:	00008067          	ret

00000000800054a8 <mycpu>:
    800054a8:	ff010113          	addi	sp,sp,-16
    800054ac:	00813423          	sd	s0,8(sp)
    800054b0:	01010413          	addi	s0,sp,16
    800054b4:	00020793          	mv	a5,tp
    800054b8:	00813403          	ld	s0,8(sp)
    800054bc:	0007879b          	sext.w	a5,a5
    800054c0:	00779793          	slli	a5,a5,0x7
    800054c4:	00006517          	auipc	a0,0x6
    800054c8:	11c50513          	addi	a0,a0,284 # 8000b5e0 <cpus>
    800054cc:	00f50533          	add	a0,a0,a5
    800054d0:	01010113          	addi	sp,sp,16
    800054d4:	00008067          	ret

00000000800054d8 <userinit>:
    800054d8:	ff010113          	addi	sp,sp,-16
    800054dc:	00813423          	sd	s0,8(sp)
    800054e0:	01010413          	addi	s0,sp,16
    800054e4:	00813403          	ld	s0,8(sp)
    800054e8:	01010113          	addi	sp,sp,16
    800054ec:	ffffe317          	auipc	t1,0xffffe
    800054f0:	ad030067          	jr	-1328(t1) # 80002fbc <main>

00000000800054f4 <either_copyout>:
    800054f4:	ff010113          	addi	sp,sp,-16
    800054f8:	00813023          	sd	s0,0(sp)
    800054fc:	00113423          	sd	ra,8(sp)
    80005500:	01010413          	addi	s0,sp,16
    80005504:	02051663          	bnez	a0,80005530 <either_copyout+0x3c>
    80005508:	00058513          	mv	a0,a1
    8000550c:	00060593          	mv	a1,a2
    80005510:	0006861b          	sext.w	a2,a3
    80005514:	00002097          	auipc	ra,0x2
    80005518:	c60080e7          	jalr	-928(ra) # 80007174 <__memmove>
    8000551c:	00813083          	ld	ra,8(sp)
    80005520:	00013403          	ld	s0,0(sp)
    80005524:	00000513          	li	a0,0
    80005528:	01010113          	addi	sp,sp,16
    8000552c:	00008067          	ret
    80005530:	00003517          	auipc	a0,0x3
    80005534:	e6850513          	addi	a0,a0,-408 # 80008398 <CONSOLE_STATUS+0x388>
    80005538:	00001097          	auipc	ra,0x1
    8000553c:	934080e7          	jalr	-1740(ra) # 80005e6c <panic>

0000000080005540 <either_copyin>:
    80005540:	ff010113          	addi	sp,sp,-16
    80005544:	00813023          	sd	s0,0(sp)
    80005548:	00113423          	sd	ra,8(sp)
    8000554c:	01010413          	addi	s0,sp,16
    80005550:	02059463          	bnez	a1,80005578 <either_copyin+0x38>
    80005554:	00060593          	mv	a1,a2
    80005558:	0006861b          	sext.w	a2,a3
    8000555c:	00002097          	auipc	ra,0x2
    80005560:	c18080e7          	jalr	-1000(ra) # 80007174 <__memmove>
    80005564:	00813083          	ld	ra,8(sp)
    80005568:	00013403          	ld	s0,0(sp)
    8000556c:	00000513          	li	a0,0
    80005570:	01010113          	addi	sp,sp,16
    80005574:	00008067          	ret
    80005578:	00003517          	auipc	a0,0x3
    8000557c:	e4850513          	addi	a0,a0,-440 # 800083c0 <CONSOLE_STATUS+0x3b0>
    80005580:	00001097          	auipc	ra,0x1
    80005584:	8ec080e7          	jalr	-1812(ra) # 80005e6c <panic>

0000000080005588 <trapinit>:
    80005588:	ff010113          	addi	sp,sp,-16
    8000558c:	00813423          	sd	s0,8(sp)
    80005590:	01010413          	addi	s0,sp,16
    80005594:	00813403          	ld	s0,8(sp)
    80005598:	00003597          	auipc	a1,0x3
    8000559c:	e5058593          	addi	a1,a1,-432 # 800083e8 <CONSOLE_STATUS+0x3d8>
    800055a0:	00006517          	auipc	a0,0x6
    800055a4:	0c050513          	addi	a0,a0,192 # 8000b660 <tickslock>
    800055a8:	01010113          	addi	sp,sp,16
    800055ac:	00001317          	auipc	t1,0x1
    800055b0:	5cc30067          	jr	1484(t1) # 80006b78 <initlock>

00000000800055b4 <trapinithart>:
    800055b4:	ff010113          	addi	sp,sp,-16
    800055b8:	00813423          	sd	s0,8(sp)
    800055bc:	01010413          	addi	s0,sp,16
    800055c0:	00000797          	auipc	a5,0x0
    800055c4:	30078793          	addi	a5,a5,768 # 800058c0 <kernelvec>
    800055c8:	10579073          	csrw	stvec,a5
    800055cc:	00813403          	ld	s0,8(sp)
    800055d0:	01010113          	addi	sp,sp,16
    800055d4:	00008067          	ret

00000000800055d8 <usertrap>:
    800055d8:	ff010113          	addi	sp,sp,-16
    800055dc:	00813423          	sd	s0,8(sp)
    800055e0:	01010413          	addi	s0,sp,16
    800055e4:	00813403          	ld	s0,8(sp)
    800055e8:	01010113          	addi	sp,sp,16
    800055ec:	00008067          	ret

00000000800055f0 <usertrapret>:
    800055f0:	ff010113          	addi	sp,sp,-16
    800055f4:	00813423          	sd	s0,8(sp)
    800055f8:	01010413          	addi	s0,sp,16
    800055fc:	00813403          	ld	s0,8(sp)
    80005600:	01010113          	addi	sp,sp,16
    80005604:	00008067          	ret

0000000080005608 <kerneltrap>:
    80005608:	fe010113          	addi	sp,sp,-32
    8000560c:	00813823          	sd	s0,16(sp)
    80005610:	00113c23          	sd	ra,24(sp)
    80005614:	00913423          	sd	s1,8(sp)
    80005618:	02010413          	addi	s0,sp,32
    8000561c:	142025f3          	csrr	a1,scause
    80005620:	100027f3          	csrr	a5,sstatus
    80005624:	0027f793          	andi	a5,a5,2
    80005628:	10079c63          	bnez	a5,80005740 <kerneltrap+0x138>
    8000562c:	142027f3          	csrr	a5,scause
    80005630:	0207ce63          	bltz	a5,8000566c <kerneltrap+0x64>
    80005634:	00003517          	auipc	a0,0x3
    80005638:	dfc50513          	addi	a0,a0,-516 # 80008430 <CONSOLE_STATUS+0x420>
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	88c080e7          	jalr	-1908(ra) # 80005ec8 <__printf>
    80005644:	141025f3          	csrr	a1,sepc
    80005648:	14302673          	csrr	a2,stval
    8000564c:	00003517          	auipc	a0,0x3
    80005650:	df450513          	addi	a0,a0,-524 # 80008440 <CONSOLE_STATUS+0x430>
    80005654:	00001097          	auipc	ra,0x1
    80005658:	874080e7          	jalr	-1932(ra) # 80005ec8 <__printf>
    8000565c:	00003517          	auipc	a0,0x3
    80005660:	dfc50513          	addi	a0,a0,-516 # 80008458 <CONSOLE_STATUS+0x448>
    80005664:	00001097          	auipc	ra,0x1
    80005668:	808080e7          	jalr	-2040(ra) # 80005e6c <panic>
    8000566c:	0ff7f713          	andi	a4,a5,255
    80005670:	00900693          	li	a3,9
    80005674:	04d70063          	beq	a4,a3,800056b4 <kerneltrap+0xac>
    80005678:	fff00713          	li	a4,-1
    8000567c:	03f71713          	slli	a4,a4,0x3f
    80005680:	00170713          	addi	a4,a4,1
    80005684:	fae798e3          	bne	a5,a4,80005634 <kerneltrap+0x2c>
    80005688:	00000097          	auipc	ra,0x0
    8000568c:	e00080e7          	jalr	-512(ra) # 80005488 <cpuid>
    80005690:	06050663          	beqz	a0,800056fc <kerneltrap+0xf4>
    80005694:	144027f3          	csrr	a5,sip
    80005698:	ffd7f793          	andi	a5,a5,-3
    8000569c:	14479073          	csrw	sip,a5
    800056a0:	01813083          	ld	ra,24(sp)
    800056a4:	01013403          	ld	s0,16(sp)
    800056a8:	00813483          	ld	s1,8(sp)
    800056ac:	02010113          	addi	sp,sp,32
    800056b0:	00008067          	ret
    800056b4:	00000097          	auipc	ra,0x0
    800056b8:	3d0080e7          	jalr	976(ra) # 80005a84 <plic_claim>
    800056bc:	00a00793          	li	a5,10
    800056c0:	00050493          	mv	s1,a0
    800056c4:	06f50863          	beq	a0,a5,80005734 <kerneltrap+0x12c>
    800056c8:	fc050ce3          	beqz	a0,800056a0 <kerneltrap+0x98>
    800056cc:	00050593          	mv	a1,a0
    800056d0:	00003517          	auipc	a0,0x3
    800056d4:	d4050513          	addi	a0,a0,-704 # 80008410 <CONSOLE_STATUS+0x400>
    800056d8:	00000097          	auipc	ra,0x0
    800056dc:	7f0080e7          	jalr	2032(ra) # 80005ec8 <__printf>
    800056e0:	01013403          	ld	s0,16(sp)
    800056e4:	01813083          	ld	ra,24(sp)
    800056e8:	00048513          	mv	a0,s1
    800056ec:	00813483          	ld	s1,8(sp)
    800056f0:	02010113          	addi	sp,sp,32
    800056f4:	00000317          	auipc	t1,0x0
    800056f8:	3c830067          	jr	968(t1) # 80005abc <plic_complete>
    800056fc:	00006517          	auipc	a0,0x6
    80005700:	f6450513          	addi	a0,a0,-156 # 8000b660 <tickslock>
    80005704:	00001097          	auipc	ra,0x1
    80005708:	498080e7          	jalr	1176(ra) # 80006b9c <acquire>
    8000570c:	00005717          	auipc	a4,0x5
    80005710:	d2870713          	addi	a4,a4,-728 # 8000a434 <ticks>
    80005714:	00072783          	lw	a5,0(a4)
    80005718:	00006517          	auipc	a0,0x6
    8000571c:	f4850513          	addi	a0,a0,-184 # 8000b660 <tickslock>
    80005720:	0017879b          	addiw	a5,a5,1
    80005724:	00f72023          	sw	a5,0(a4)
    80005728:	00001097          	auipc	ra,0x1
    8000572c:	540080e7          	jalr	1344(ra) # 80006c68 <release>
    80005730:	f65ff06f          	j	80005694 <kerneltrap+0x8c>
    80005734:	00001097          	auipc	ra,0x1
    80005738:	09c080e7          	jalr	156(ra) # 800067d0 <uartintr>
    8000573c:	fa5ff06f          	j	800056e0 <kerneltrap+0xd8>
    80005740:	00003517          	auipc	a0,0x3
    80005744:	cb050513          	addi	a0,a0,-848 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80005748:	00000097          	auipc	ra,0x0
    8000574c:	724080e7          	jalr	1828(ra) # 80005e6c <panic>

0000000080005750 <clockintr>:
    80005750:	fe010113          	addi	sp,sp,-32
    80005754:	00813823          	sd	s0,16(sp)
    80005758:	00913423          	sd	s1,8(sp)
    8000575c:	00113c23          	sd	ra,24(sp)
    80005760:	02010413          	addi	s0,sp,32
    80005764:	00006497          	auipc	s1,0x6
    80005768:	efc48493          	addi	s1,s1,-260 # 8000b660 <tickslock>
    8000576c:	00048513          	mv	a0,s1
    80005770:	00001097          	auipc	ra,0x1
    80005774:	42c080e7          	jalr	1068(ra) # 80006b9c <acquire>
    80005778:	00005717          	auipc	a4,0x5
    8000577c:	cbc70713          	addi	a4,a4,-836 # 8000a434 <ticks>
    80005780:	00072783          	lw	a5,0(a4)
    80005784:	01013403          	ld	s0,16(sp)
    80005788:	01813083          	ld	ra,24(sp)
    8000578c:	00048513          	mv	a0,s1
    80005790:	0017879b          	addiw	a5,a5,1
    80005794:	00813483          	ld	s1,8(sp)
    80005798:	00f72023          	sw	a5,0(a4)
    8000579c:	02010113          	addi	sp,sp,32
    800057a0:	00001317          	auipc	t1,0x1
    800057a4:	4c830067          	jr	1224(t1) # 80006c68 <release>

00000000800057a8 <devintr>:
    800057a8:	142027f3          	csrr	a5,scause
    800057ac:	00000513          	li	a0,0
    800057b0:	0007c463          	bltz	a5,800057b8 <devintr+0x10>
    800057b4:	00008067          	ret
    800057b8:	fe010113          	addi	sp,sp,-32
    800057bc:	00813823          	sd	s0,16(sp)
    800057c0:	00113c23          	sd	ra,24(sp)
    800057c4:	00913423          	sd	s1,8(sp)
    800057c8:	02010413          	addi	s0,sp,32
    800057cc:	0ff7f713          	andi	a4,a5,255
    800057d0:	00900693          	li	a3,9
    800057d4:	04d70c63          	beq	a4,a3,8000582c <devintr+0x84>
    800057d8:	fff00713          	li	a4,-1
    800057dc:	03f71713          	slli	a4,a4,0x3f
    800057e0:	00170713          	addi	a4,a4,1
    800057e4:	00e78c63          	beq	a5,a4,800057fc <devintr+0x54>
    800057e8:	01813083          	ld	ra,24(sp)
    800057ec:	01013403          	ld	s0,16(sp)
    800057f0:	00813483          	ld	s1,8(sp)
    800057f4:	02010113          	addi	sp,sp,32
    800057f8:	00008067          	ret
    800057fc:	00000097          	auipc	ra,0x0
    80005800:	c8c080e7          	jalr	-884(ra) # 80005488 <cpuid>
    80005804:	06050663          	beqz	a0,80005870 <devintr+0xc8>
    80005808:	144027f3          	csrr	a5,sip
    8000580c:	ffd7f793          	andi	a5,a5,-3
    80005810:	14479073          	csrw	sip,a5
    80005814:	01813083          	ld	ra,24(sp)
    80005818:	01013403          	ld	s0,16(sp)
    8000581c:	00813483          	ld	s1,8(sp)
    80005820:	00200513          	li	a0,2
    80005824:	02010113          	addi	sp,sp,32
    80005828:	00008067          	ret
    8000582c:	00000097          	auipc	ra,0x0
    80005830:	258080e7          	jalr	600(ra) # 80005a84 <plic_claim>
    80005834:	00a00793          	li	a5,10
    80005838:	00050493          	mv	s1,a0
    8000583c:	06f50663          	beq	a0,a5,800058a8 <devintr+0x100>
    80005840:	00100513          	li	a0,1
    80005844:	fa0482e3          	beqz	s1,800057e8 <devintr+0x40>
    80005848:	00048593          	mv	a1,s1
    8000584c:	00003517          	auipc	a0,0x3
    80005850:	bc450513          	addi	a0,a0,-1084 # 80008410 <CONSOLE_STATUS+0x400>
    80005854:	00000097          	auipc	ra,0x0
    80005858:	674080e7          	jalr	1652(ra) # 80005ec8 <__printf>
    8000585c:	00048513          	mv	a0,s1
    80005860:	00000097          	auipc	ra,0x0
    80005864:	25c080e7          	jalr	604(ra) # 80005abc <plic_complete>
    80005868:	00100513          	li	a0,1
    8000586c:	f7dff06f          	j	800057e8 <devintr+0x40>
    80005870:	00006517          	auipc	a0,0x6
    80005874:	df050513          	addi	a0,a0,-528 # 8000b660 <tickslock>
    80005878:	00001097          	auipc	ra,0x1
    8000587c:	324080e7          	jalr	804(ra) # 80006b9c <acquire>
    80005880:	00005717          	auipc	a4,0x5
    80005884:	bb470713          	addi	a4,a4,-1100 # 8000a434 <ticks>
    80005888:	00072783          	lw	a5,0(a4)
    8000588c:	00006517          	auipc	a0,0x6
    80005890:	dd450513          	addi	a0,a0,-556 # 8000b660 <tickslock>
    80005894:	0017879b          	addiw	a5,a5,1
    80005898:	00f72023          	sw	a5,0(a4)
    8000589c:	00001097          	auipc	ra,0x1
    800058a0:	3cc080e7          	jalr	972(ra) # 80006c68 <release>
    800058a4:	f65ff06f          	j	80005808 <devintr+0x60>
    800058a8:	00001097          	auipc	ra,0x1
    800058ac:	f28080e7          	jalr	-216(ra) # 800067d0 <uartintr>
    800058b0:	fadff06f          	j	8000585c <devintr+0xb4>
	...

00000000800058c0 <kernelvec>:
    800058c0:	f0010113          	addi	sp,sp,-256
    800058c4:	00113023          	sd	ra,0(sp)
    800058c8:	00213423          	sd	sp,8(sp)
    800058cc:	00313823          	sd	gp,16(sp)
    800058d0:	00413c23          	sd	tp,24(sp)
    800058d4:	02513023          	sd	t0,32(sp)
    800058d8:	02613423          	sd	t1,40(sp)
    800058dc:	02713823          	sd	t2,48(sp)
    800058e0:	02813c23          	sd	s0,56(sp)
    800058e4:	04913023          	sd	s1,64(sp)
    800058e8:	04a13423          	sd	a0,72(sp)
    800058ec:	04b13823          	sd	a1,80(sp)
    800058f0:	04c13c23          	sd	a2,88(sp)
    800058f4:	06d13023          	sd	a3,96(sp)
    800058f8:	06e13423          	sd	a4,104(sp)
    800058fc:	06f13823          	sd	a5,112(sp)
    80005900:	07013c23          	sd	a6,120(sp)
    80005904:	09113023          	sd	a7,128(sp)
    80005908:	09213423          	sd	s2,136(sp)
    8000590c:	09313823          	sd	s3,144(sp)
    80005910:	09413c23          	sd	s4,152(sp)
    80005914:	0b513023          	sd	s5,160(sp)
    80005918:	0b613423          	sd	s6,168(sp)
    8000591c:	0b713823          	sd	s7,176(sp)
    80005920:	0b813c23          	sd	s8,184(sp)
    80005924:	0d913023          	sd	s9,192(sp)
    80005928:	0da13423          	sd	s10,200(sp)
    8000592c:	0db13823          	sd	s11,208(sp)
    80005930:	0dc13c23          	sd	t3,216(sp)
    80005934:	0fd13023          	sd	t4,224(sp)
    80005938:	0fe13423          	sd	t5,232(sp)
    8000593c:	0ff13823          	sd	t6,240(sp)
    80005940:	cc9ff0ef          	jal	ra,80005608 <kerneltrap>
    80005944:	00013083          	ld	ra,0(sp)
    80005948:	00813103          	ld	sp,8(sp)
    8000594c:	01013183          	ld	gp,16(sp)
    80005950:	02013283          	ld	t0,32(sp)
    80005954:	02813303          	ld	t1,40(sp)
    80005958:	03013383          	ld	t2,48(sp)
    8000595c:	03813403          	ld	s0,56(sp)
    80005960:	04013483          	ld	s1,64(sp)
    80005964:	04813503          	ld	a0,72(sp)
    80005968:	05013583          	ld	a1,80(sp)
    8000596c:	05813603          	ld	a2,88(sp)
    80005970:	06013683          	ld	a3,96(sp)
    80005974:	06813703          	ld	a4,104(sp)
    80005978:	07013783          	ld	a5,112(sp)
    8000597c:	07813803          	ld	a6,120(sp)
    80005980:	08013883          	ld	a7,128(sp)
    80005984:	08813903          	ld	s2,136(sp)
    80005988:	09013983          	ld	s3,144(sp)
    8000598c:	09813a03          	ld	s4,152(sp)
    80005990:	0a013a83          	ld	s5,160(sp)
    80005994:	0a813b03          	ld	s6,168(sp)
    80005998:	0b013b83          	ld	s7,176(sp)
    8000599c:	0b813c03          	ld	s8,184(sp)
    800059a0:	0c013c83          	ld	s9,192(sp)
    800059a4:	0c813d03          	ld	s10,200(sp)
    800059a8:	0d013d83          	ld	s11,208(sp)
    800059ac:	0d813e03          	ld	t3,216(sp)
    800059b0:	0e013e83          	ld	t4,224(sp)
    800059b4:	0e813f03          	ld	t5,232(sp)
    800059b8:	0f013f83          	ld	t6,240(sp)
    800059bc:	10010113          	addi	sp,sp,256
    800059c0:	10200073          	sret
    800059c4:	00000013          	nop
    800059c8:	00000013          	nop
    800059cc:	00000013          	nop

00000000800059d0 <timervec>:
    800059d0:	34051573          	csrrw	a0,mscratch,a0
    800059d4:	00b53023          	sd	a1,0(a0)
    800059d8:	00c53423          	sd	a2,8(a0)
    800059dc:	00d53823          	sd	a3,16(a0)
    800059e0:	01853583          	ld	a1,24(a0)
    800059e4:	02053603          	ld	a2,32(a0)
    800059e8:	0005b683          	ld	a3,0(a1)
    800059ec:	00c686b3          	add	a3,a3,a2
    800059f0:	00d5b023          	sd	a3,0(a1)
    800059f4:	00200593          	li	a1,2
    800059f8:	14459073          	csrw	sip,a1
    800059fc:	01053683          	ld	a3,16(a0)
    80005a00:	00853603          	ld	a2,8(a0)
    80005a04:	00053583          	ld	a1,0(a0)
    80005a08:	34051573          	csrrw	a0,mscratch,a0
    80005a0c:	30200073          	mret

0000000080005a10 <plicinit>:
    80005a10:	ff010113          	addi	sp,sp,-16
    80005a14:	00813423          	sd	s0,8(sp)
    80005a18:	01010413          	addi	s0,sp,16
    80005a1c:	00813403          	ld	s0,8(sp)
    80005a20:	0c0007b7          	lui	a5,0xc000
    80005a24:	00100713          	li	a4,1
    80005a28:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005a2c:	00e7a223          	sw	a4,4(a5)
    80005a30:	01010113          	addi	sp,sp,16
    80005a34:	00008067          	ret

0000000080005a38 <plicinithart>:
    80005a38:	ff010113          	addi	sp,sp,-16
    80005a3c:	00813023          	sd	s0,0(sp)
    80005a40:	00113423          	sd	ra,8(sp)
    80005a44:	01010413          	addi	s0,sp,16
    80005a48:	00000097          	auipc	ra,0x0
    80005a4c:	a40080e7          	jalr	-1472(ra) # 80005488 <cpuid>
    80005a50:	0085171b          	slliw	a4,a0,0x8
    80005a54:	0c0027b7          	lui	a5,0xc002
    80005a58:	00e787b3          	add	a5,a5,a4
    80005a5c:	40200713          	li	a4,1026
    80005a60:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005a64:	00813083          	ld	ra,8(sp)
    80005a68:	00013403          	ld	s0,0(sp)
    80005a6c:	00d5151b          	slliw	a0,a0,0xd
    80005a70:	0c2017b7          	lui	a5,0xc201
    80005a74:	00a78533          	add	a0,a5,a0
    80005a78:	00052023          	sw	zero,0(a0)
    80005a7c:	01010113          	addi	sp,sp,16
    80005a80:	00008067          	ret

0000000080005a84 <plic_claim>:
    80005a84:	ff010113          	addi	sp,sp,-16
    80005a88:	00813023          	sd	s0,0(sp)
    80005a8c:	00113423          	sd	ra,8(sp)
    80005a90:	01010413          	addi	s0,sp,16
    80005a94:	00000097          	auipc	ra,0x0
    80005a98:	9f4080e7          	jalr	-1548(ra) # 80005488 <cpuid>
    80005a9c:	00813083          	ld	ra,8(sp)
    80005aa0:	00013403          	ld	s0,0(sp)
    80005aa4:	00d5151b          	slliw	a0,a0,0xd
    80005aa8:	0c2017b7          	lui	a5,0xc201
    80005aac:	00a78533          	add	a0,a5,a0
    80005ab0:	00452503          	lw	a0,4(a0)
    80005ab4:	01010113          	addi	sp,sp,16
    80005ab8:	00008067          	ret

0000000080005abc <plic_complete>:
    80005abc:	fe010113          	addi	sp,sp,-32
    80005ac0:	00813823          	sd	s0,16(sp)
    80005ac4:	00913423          	sd	s1,8(sp)
    80005ac8:	00113c23          	sd	ra,24(sp)
    80005acc:	02010413          	addi	s0,sp,32
    80005ad0:	00050493          	mv	s1,a0
    80005ad4:	00000097          	auipc	ra,0x0
    80005ad8:	9b4080e7          	jalr	-1612(ra) # 80005488 <cpuid>
    80005adc:	01813083          	ld	ra,24(sp)
    80005ae0:	01013403          	ld	s0,16(sp)
    80005ae4:	00d5179b          	slliw	a5,a0,0xd
    80005ae8:	0c201737          	lui	a4,0xc201
    80005aec:	00f707b3          	add	a5,a4,a5
    80005af0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005af4:	00813483          	ld	s1,8(sp)
    80005af8:	02010113          	addi	sp,sp,32
    80005afc:	00008067          	ret

0000000080005b00 <consolewrite>:
    80005b00:	fb010113          	addi	sp,sp,-80
    80005b04:	04813023          	sd	s0,64(sp)
    80005b08:	04113423          	sd	ra,72(sp)
    80005b0c:	02913c23          	sd	s1,56(sp)
    80005b10:	03213823          	sd	s2,48(sp)
    80005b14:	03313423          	sd	s3,40(sp)
    80005b18:	03413023          	sd	s4,32(sp)
    80005b1c:	01513c23          	sd	s5,24(sp)
    80005b20:	05010413          	addi	s0,sp,80
    80005b24:	06c05c63          	blez	a2,80005b9c <consolewrite+0x9c>
    80005b28:	00060993          	mv	s3,a2
    80005b2c:	00050a13          	mv	s4,a0
    80005b30:	00058493          	mv	s1,a1
    80005b34:	00000913          	li	s2,0
    80005b38:	fff00a93          	li	s5,-1
    80005b3c:	01c0006f          	j	80005b58 <consolewrite+0x58>
    80005b40:	fbf44503          	lbu	a0,-65(s0)
    80005b44:	0019091b          	addiw	s2,s2,1
    80005b48:	00148493          	addi	s1,s1,1
    80005b4c:	00001097          	auipc	ra,0x1
    80005b50:	a9c080e7          	jalr	-1380(ra) # 800065e8 <uartputc>
    80005b54:	03298063          	beq	s3,s2,80005b74 <consolewrite+0x74>
    80005b58:	00048613          	mv	a2,s1
    80005b5c:	00100693          	li	a3,1
    80005b60:	000a0593          	mv	a1,s4
    80005b64:	fbf40513          	addi	a0,s0,-65
    80005b68:	00000097          	auipc	ra,0x0
    80005b6c:	9d8080e7          	jalr	-1576(ra) # 80005540 <either_copyin>
    80005b70:	fd5518e3          	bne	a0,s5,80005b40 <consolewrite+0x40>
    80005b74:	04813083          	ld	ra,72(sp)
    80005b78:	04013403          	ld	s0,64(sp)
    80005b7c:	03813483          	ld	s1,56(sp)
    80005b80:	02813983          	ld	s3,40(sp)
    80005b84:	02013a03          	ld	s4,32(sp)
    80005b88:	01813a83          	ld	s5,24(sp)
    80005b8c:	00090513          	mv	a0,s2
    80005b90:	03013903          	ld	s2,48(sp)
    80005b94:	05010113          	addi	sp,sp,80
    80005b98:	00008067          	ret
    80005b9c:	00000913          	li	s2,0
    80005ba0:	fd5ff06f          	j	80005b74 <consolewrite+0x74>

0000000080005ba4 <consoleread>:
    80005ba4:	f9010113          	addi	sp,sp,-112
    80005ba8:	06813023          	sd	s0,96(sp)
    80005bac:	04913c23          	sd	s1,88(sp)
    80005bb0:	05213823          	sd	s2,80(sp)
    80005bb4:	05313423          	sd	s3,72(sp)
    80005bb8:	05413023          	sd	s4,64(sp)
    80005bbc:	03513c23          	sd	s5,56(sp)
    80005bc0:	03613823          	sd	s6,48(sp)
    80005bc4:	03713423          	sd	s7,40(sp)
    80005bc8:	03813023          	sd	s8,32(sp)
    80005bcc:	06113423          	sd	ra,104(sp)
    80005bd0:	01913c23          	sd	s9,24(sp)
    80005bd4:	07010413          	addi	s0,sp,112
    80005bd8:	00060b93          	mv	s7,a2
    80005bdc:	00050913          	mv	s2,a0
    80005be0:	00058c13          	mv	s8,a1
    80005be4:	00060b1b          	sext.w	s6,a2
    80005be8:	00006497          	auipc	s1,0x6
    80005bec:	aa048493          	addi	s1,s1,-1376 # 8000b688 <cons>
    80005bf0:	00400993          	li	s3,4
    80005bf4:	fff00a13          	li	s4,-1
    80005bf8:	00a00a93          	li	s5,10
    80005bfc:	05705e63          	blez	s7,80005c58 <consoleread+0xb4>
    80005c00:	09c4a703          	lw	a4,156(s1)
    80005c04:	0984a783          	lw	a5,152(s1)
    80005c08:	0007071b          	sext.w	a4,a4
    80005c0c:	08e78463          	beq	a5,a4,80005c94 <consoleread+0xf0>
    80005c10:	07f7f713          	andi	a4,a5,127
    80005c14:	00e48733          	add	a4,s1,a4
    80005c18:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005c1c:	0017869b          	addiw	a3,a5,1
    80005c20:	08d4ac23          	sw	a3,152(s1)
    80005c24:	00070c9b          	sext.w	s9,a4
    80005c28:	0b370663          	beq	a4,s3,80005cd4 <consoleread+0x130>
    80005c2c:	00100693          	li	a3,1
    80005c30:	f9f40613          	addi	a2,s0,-97
    80005c34:	000c0593          	mv	a1,s8
    80005c38:	00090513          	mv	a0,s2
    80005c3c:	f8e40fa3          	sb	a4,-97(s0)
    80005c40:	00000097          	auipc	ra,0x0
    80005c44:	8b4080e7          	jalr	-1868(ra) # 800054f4 <either_copyout>
    80005c48:	01450863          	beq	a0,s4,80005c58 <consoleread+0xb4>
    80005c4c:	001c0c13          	addi	s8,s8,1
    80005c50:	fffb8b9b          	addiw	s7,s7,-1
    80005c54:	fb5c94e3          	bne	s9,s5,80005bfc <consoleread+0x58>
    80005c58:	000b851b          	sext.w	a0,s7
    80005c5c:	06813083          	ld	ra,104(sp)
    80005c60:	06013403          	ld	s0,96(sp)
    80005c64:	05813483          	ld	s1,88(sp)
    80005c68:	05013903          	ld	s2,80(sp)
    80005c6c:	04813983          	ld	s3,72(sp)
    80005c70:	04013a03          	ld	s4,64(sp)
    80005c74:	03813a83          	ld	s5,56(sp)
    80005c78:	02813b83          	ld	s7,40(sp)
    80005c7c:	02013c03          	ld	s8,32(sp)
    80005c80:	01813c83          	ld	s9,24(sp)
    80005c84:	40ab053b          	subw	a0,s6,a0
    80005c88:	03013b03          	ld	s6,48(sp)
    80005c8c:	07010113          	addi	sp,sp,112
    80005c90:	00008067          	ret
    80005c94:	00001097          	auipc	ra,0x1
    80005c98:	1d8080e7          	jalr	472(ra) # 80006e6c <push_on>
    80005c9c:	0984a703          	lw	a4,152(s1)
    80005ca0:	09c4a783          	lw	a5,156(s1)
    80005ca4:	0007879b          	sext.w	a5,a5
    80005ca8:	fef70ce3          	beq	a4,a5,80005ca0 <consoleread+0xfc>
    80005cac:	00001097          	auipc	ra,0x1
    80005cb0:	234080e7          	jalr	564(ra) # 80006ee0 <pop_on>
    80005cb4:	0984a783          	lw	a5,152(s1)
    80005cb8:	07f7f713          	andi	a4,a5,127
    80005cbc:	00e48733          	add	a4,s1,a4
    80005cc0:	01874703          	lbu	a4,24(a4)
    80005cc4:	0017869b          	addiw	a3,a5,1
    80005cc8:	08d4ac23          	sw	a3,152(s1)
    80005ccc:	00070c9b          	sext.w	s9,a4
    80005cd0:	f5371ee3          	bne	a4,s3,80005c2c <consoleread+0x88>
    80005cd4:	000b851b          	sext.w	a0,s7
    80005cd8:	f96bf2e3          	bgeu	s7,s6,80005c5c <consoleread+0xb8>
    80005cdc:	08f4ac23          	sw	a5,152(s1)
    80005ce0:	f7dff06f          	j	80005c5c <consoleread+0xb8>

0000000080005ce4 <consputc>:
    80005ce4:	10000793          	li	a5,256
    80005ce8:	00f50663          	beq	a0,a5,80005cf4 <consputc+0x10>
    80005cec:	00001317          	auipc	t1,0x1
    80005cf0:	9f430067          	jr	-1548(t1) # 800066e0 <uartputc_sync>
    80005cf4:	ff010113          	addi	sp,sp,-16
    80005cf8:	00113423          	sd	ra,8(sp)
    80005cfc:	00813023          	sd	s0,0(sp)
    80005d00:	01010413          	addi	s0,sp,16
    80005d04:	00800513          	li	a0,8
    80005d08:	00001097          	auipc	ra,0x1
    80005d0c:	9d8080e7          	jalr	-1576(ra) # 800066e0 <uartputc_sync>
    80005d10:	02000513          	li	a0,32
    80005d14:	00001097          	auipc	ra,0x1
    80005d18:	9cc080e7          	jalr	-1588(ra) # 800066e0 <uartputc_sync>
    80005d1c:	00013403          	ld	s0,0(sp)
    80005d20:	00813083          	ld	ra,8(sp)
    80005d24:	00800513          	li	a0,8
    80005d28:	01010113          	addi	sp,sp,16
    80005d2c:	00001317          	auipc	t1,0x1
    80005d30:	9b430067          	jr	-1612(t1) # 800066e0 <uartputc_sync>

0000000080005d34 <consoleintr>:
    80005d34:	fe010113          	addi	sp,sp,-32
    80005d38:	00813823          	sd	s0,16(sp)
    80005d3c:	00913423          	sd	s1,8(sp)
    80005d40:	01213023          	sd	s2,0(sp)
    80005d44:	00113c23          	sd	ra,24(sp)
    80005d48:	02010413          	addi	s0,sp,32
    80005d4c:	00006917          	auipc	s2,0x6
    80005d50:	93c90913          	addi	s2,s2,-1732 # 8000b688 <cons>
    80005d54:	00050493          	mv	s1,a0
    80005d58:	00090513          	mv	a0,s2
    80005d5c:	00001097          	auipc	ra,0x1
    80005d60:	e40080e7          	jalr	-448(ra) # 80006b9c <acquire>
    80005d64:	02048c63          	beqz	s1,80005d9c <consoleintr+0x68>
    80005d68:	0a092783          	lw	a5,160(s2)
    80005d6c:	09892703          	lw	a4,152(s2)
    80005d70:	07f00693          	li	a3,127
    80005d74:	40e7873b          	subw	a4,a5,a4
    80005d78:	02e6e263          	bltu	a3,a4,80005d9c <consoleintr+0x68>
    80005d7c:	00d00713          	li	a4,13
    80005d80:	04e48063          	beq	s1,a4,80005dc0 <consoleintr+0x8c>
    80005d84:	07f7f713          	andi	a4,a5,127
    80005d88:	00e90733          	add	a4,s2,a4
    80005d8c:	0017879b          	addiw	a5,a5,1
    80005d90:	0af92023          	sw	a5,160(s2)
    80005d94:	00970c23          	sb	s1,24(a4)
    80005d98:	08f92e23          	sw	a5,156(s2)
    80005d9c:	01013403          	ld	s0,16(sp)
    80005da0:	01813083          	ld	ra,24(sp)
    80005da4:	00813483          	ld	s1,8(sp)
    80005da8:	00013903          	ld	s2,0(sp)
    80005dac:	00006517          	auipc	a0,0x6
    80005db0:	8dc50513          	addi	a0,a0,-1828 # 8000b688 <cons>
    80005db4:	02010113          	addi	sp,sp,32
    80005db8:	00001317          	auipc	t1,0x1
    80005dbc:	eb030067          	jr	-336(t1) # 80006c68 <release>
    80005dc0:	00a00493          	li	s1,10
    80005dc4:	fc1ff06f          	j	80005d84 <consoleintr+0x50>

0000000080005dc8 <consoleinit>:
    80005dc8:	fe010113          	addi	sp,sp,-32
    80005dcc:	00113c23          	sd	ra,24(sp)
    80005dd0:	00813823          	sd	s0,16(sp)
    80005dd4:	00913423          	sd	s1,8(sp)
    80005dd8:	02010413          	addi	s0,sp,32
    80005ddc:	00006497          	auipc	s1,0x6
    80005de0:	8ac48493          	addi	s1,s1,-1876 # 8000b688 <cons>
    80005de4:	00048513          	mv	a0,s1
    80005de8:	00002597          	auipc	a1,0x2
    80005dec:	68058593          	addi	a1,a1,1664 # 80008468 <CONSOLE_STATUS+0x458>
    80005df0:	00001097          	auipc	ra,0x1
    80005df4:	d88080e7          	jalr	-632(ra) # 80006b78 <initlock>
    80005df8:	00000097          	auipc	ra,0x0
    80005dfc:	7ac080e7          	jalr	1964(ra) # 800065a4 <uartinit>
    80005e00:	01813083          	ld	ra,24(sp)
    80005e04:	01013403          	ld	s0,16(sp)
    80005e08:	00000797          	auipc	a5,0x0
    80005e0c:	d9c78793          	addi	a5,a5,-612 # 80005ba4 <consoleread>
    80005e10:	0af4bc23          	sd	a5,184(s1)
    80005e14:	00000797          	auipc	a5,0x0
    80005e18:	cec78793          	addi	a5,a5,-788 # 80005b00 <consolewrite>
    80005e1c:	0cf4b023          	sd	a5,192(s1)
    80005e20:	00813483          	ld	s1,8(sp)
    80005e24:	02010113          	addi	sp,sp,32
    80005e28:	00008067          	ret

0000000080005e2c <console_read>:
    80005e2c:	ff010113          	addi	sp,sp,-16
    80005e30:	00813423          	sd	s0,8(sp)
    80005e34:	01010413          	addi	s0,sp,16
    80005e38:	00813403          	ld	s0,8(sp)
    80005e3c:	00006317          	auipc	t1,0x6
    80005e40:	90433303          	ld	t1,-1788(t1) # 8000b740 <devsw+0x10>
    80005e44:	01010113          	addi	sp,sp,16
    80005e48:	00030067          	jr	t1

0000000080005e4c <console_write>:
    80005e4c:	ff010113          	addi	sp,sp,-16
    80005e50:	00813423          	sd	s0,8(sp)
    80005e54:	01010413          	addi	s0,sp,16
    80005e58:	00813403          	ld	s0,8(sp)
    80005e5c:	00006317          	auipc	t1,0x6
    80005e60:	8ec33303          	ld	t1,-1812(t1) # 8000b748 <devsw+0x18>
    80005e64:	01010113          	addi	sp,sp,16
    80005e68:	00030067          	jr	t1

0000000080005e6c <panic>:
    80005e6c:	fe010113          	addi	sp,sp,-32
    80005e70:	00113c23          	sd	ra,24(sp)
    80005e74:	00813823          	sd	s0,16(sp)
    80005e78:	00913423          	sd	s1,8(sp)
    80005e7c:	02010413          	addi	s0,sp,32
    80005e80:	00050493          	mv	s1,a0
    80005e84:	00002517          	auipc	a0,0x2
    80005e88:	5ec50513          	addi	a0,a0,1516 # 80008470 <CONSOLE_STATUS+0x460>
    80005e8c:	00006797          	auipc	a5,0x6
    80005e90:	9407ae23          	sw	zero,-1700(a5) # 8000b7e8 <pr+0x18>
    80005e94:	00000097          	auipc	ra,0x0
    80005e98:	034080e7          	jalr	52(ra) # 80005ec8 <__printf>
    80005e9c:	00048513          	mv	a0,s1
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	028080e7          	jalr	40(ra) # 80005ec8 <__printf>
    80005ea8:	00002517          	auipc	a0,0x2
    80005eac:	3b850513          	addi	a0,a0,952 # 80008260 <CONSOLE_STATUS+0x250>
    80005eb0:	00000097          	auipc	ra,0x0
    80005eb4:	018080e7          	jalr	24(ra) # 80005ec8 <__printf>
    80005eb8:	00100793          	li	a5,1
    80005ebc:	00004717          	auipc	a4,0x4
    80005ec0:	56f72e23          	sw	a5,1404(a4) # 8000a438 <panicked>
    80005ec4:	0000006f          	j	80005ec4 <panic+0x58>

0000000080005ec8 <__printf>:
    80005ec8:	f3010113          	addi	sp,sp,-208
    80005ecc:	08813023          	sd	s0,128(sp)
    80005ed0:	07313423          	sd	s3,104(sp)
    80005ed4:	09010413          	addi	s0,sp,144
    80005ed8:	05813023          	sd	s8,64(sp)
    80005edc:	08113423          	sd	ra,136(sp)
    80005ee0:	06913c23          	sd	s1,120(sp)
    80005ee4:	07213823          	sd	s2,112(sp)
    80005ee8:	07413023          	sd	s4,96(sp)
    80005eec:	05513c23          	sd	s5,88(sp)
    80005ef0:	05613823          	sd	s6,80(sp)
    80005ef4:	05713423          	sd	s7,72(sp)
    80005ef8:	03913c23          	sd	s9,56(sp)
    80005efc:	03a13823          	sd	s10,48(sp)
    80005f00:	03b13423          	sd	s11,40(sp)
    80005f04:	00006317          	auipc	t1,0x6
    80005f08:	8cc30313          	addi	t1,t1,-1844 # 8000b7d0 <pr>
    80005f0c:	01832c03          	lw	s8,24(t1)
    80005f10:	00b43423          	sd	a1,8(s0)
    80005f14:	00c43823          	sd	a2,16(s0)
    80005f18:	00d43c23          	sd	a3,24(s0)
    80005f1c:	02e43023          	sd	a4,32(s0)
    80005f20:	02f43423          	sd	a5,40(s0)
    80005f24:	03043823          	sd	a6,48(s0)
    80005f28:	03143c23          	sd	a7,56(s0)
    80005f2c:	00050993          	mv	s3,a0
    80005f30:	4a0c1663          	bnez	s8,800063dc <__printf+0x514>
    80005f34:	60098c63          	beqz	s3,8000654c <__printf+0x684>
    80005f38:	0009c503          	lbu	a0,0(s3)
    80005f3c:	00840793          	addi	a5,s0,8
    80005f40:	f6f43c23          	sd	a5,-136(s0)
    80005f44:	00000493          	li	s1,0
    80005f48:	22050063          	beqz	a0,80006168 <__printf+0x2a0>
    80005f4c:	00002a37          	lui	s4,0x2
    80005f50:	00018ab7          	lui	s5,0x18
    80005f54:	000f4b37          	lui	s6,0xf4
    80005f58:	00989bb7          	lui	s7,0x989
    80005f5c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005f60:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005f64:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005f68:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005f6c:	00148c9b          	addiw	s9,s1,1
    80005f70:	02500793          	li	a5,37
    80005f74:	01998933          	add	s2,s3,s9
    80005f78:	38f51263          	bne	a0,a5,800062fc <__printf+0x434>
    80005f7c:	00094783          	lbu	a5,0(s2)
    80005f80:	00078c9b          	sext.w	s9,a5
    80005f84:	1e078263          	beqz	a5,80006168 <__printf+0x2a0>
    80005f88:	0024849b          	addiw	s1,s1,2
    80005f8c:	07000713          	li	a4,112
    80005f90:	00998933          	add	s2,s3,s1
    80005f94:	38e78a63          	beq	a5,a4,80006328 <__printf+0x460>
    80005f98:	20f76863          	bltu	a4,a5,800061a8 <__printf+0x2e0>
    80005f9c:	42a78863          	beq	a5,a0,800063cc <__printf+0x504>
    80005fa0:	06400713          	li	a4,100
    80005fa4:	40e79663          	bne	a5,a4,800063b0 <__printf+0x4e8>
    80005fa8:	f7843783          	ld	a5,-136(s0)
    80005fac:	0007a603          	lw	a2,0(a5)
    80005fb0:	00878793          	addi	a5,a5,8
    80005fb4:	f6f43c23          	sd	a5,-136(s0)
    80005fb8:	42064a63          	bltz	a2,800063ec <__printf+0x524>
    80005fbc:	00a00713          	li	a4,10
    80005fc0:	02e677bb          	remuw	a5,a2,a4
    80005fc4:	00002d97          	auipc	s11,0x2
    80005fc8:	4d4d8d93          	addi	s11,s11,1236 # 80008498 <digits>
    80005fcc:	00900593          	li	a1,9
    80005fd0:	0006051b          	sext.w	a0,a2
    80005fd4:	00000c93          	li	s9,0
    80005fd8:	02079793          	slli	a5,a5,0x20
    80005fdc:	0207d793          	srli	a5,a5,0x20
    80005fe0:	00fd87b3          	add	a5,s11,a5
    80005fe4:	0007c783          	lbu	a5,0(a5)
    80005fe8:	02e656bb          	divuw	a3,a2,a4
    80005fec:	f8f40023          	sb	a5,-128(s0)
    80005ff0:	14c5d863          	bge	a1,a2,80006140 <__printf+0x278>
    80005ff4:	06300593          	li	a1,99
    80005ff8:	00100c93          	li	s9,1
    80005ffc:	02e6f7bb          	remuw	a5,a3,a4
    80006000:	02079793          	slli	a5,a5,0x20
    80006004:	0207d793          	srli	a5,a5,0x20
    80006008:	00fd87b3          	add	a5,s11,a5
    8000600c:	0007c783          	lbu	a5,0(a5)
    80006010:	02e6d73b          	divuw	a4,a3,a4
    80006014:	f8f400a3          	sb	a5,-127(s0)
    80006018:	12a5f463          	bgeu	a1,a0,80006140 <__printf+0x278>
    8000601c:	00a00693          	li	a3,10
    80006020:	00900593          	li	a1,9
    80006024:	02d777bb          	remuw	a5,a4,a3
    80006028:	02079793          	slli	a5,a5,0x20
    8000602c:	0207d793          	srli	a5,a5,0x20
    80006030:	00fd87b3          	add	a5,s11,a5
    80006034:	0007c503          	lbu	a0,0(a5)
    80006038:	02d757bb          	divuw	a5,a4,a3
    8000603c:	f8a40123          	sb	a0,-126(s0)
    80006040:	48e5f263          	bgeu	a1,a4,800064c4 <__printf+0x5fc>
    80006044:	06300513          	li	a0,99
    80006048:	02d7f5bb          	remuw	a1,a5,a3
    8000604c:	02059593          	slli	a1,a1,0x20
    80006050:	0205d593          	srli	a1,a1,0x20
    80006054:	00bd85b3          	add	a1,s11,a1
    80006058:	0005c583          	lbu	a1,0(a1)
    8000605c:	02d7d7bb          	divuw	a5,a5,a3
    80006060:	f8b401a3          	sb	a1,-125(s0)
    80006064:	48e57263          	bgeu	a0,a4,800064e8 <__printf+0x620>
    80006068:	3e700513          	li	a0,999
    8000606c:	02d7f5bb          	remuw	a1,a5,a3
    80006070:	02059593          	slli	a1,a1,0x20
    80006074:	0205d593          	srli	a1,a1,0x20
    80006078:	00bd85b3          	add	a1,s11,a1
    8000607c:	0005c583          	lbu	a1,0(a1)
    80006080:	02d7d7bb          	divuw	a5,a5,a3
    80006084:	f8b40223          	sb	a1,-124(s0)
    80006088:	46e57663          	bgeu	a0,a4,800064f4 <__printf+0x62c>
    8000608c:	02d7f5bb          	remuw	a1,a5,a3
    80006090:	02059593          	slli	a1,a1,0x20
    80006094:	0205d593          	srli	a1,a1,0x20
    80006098:	00bd85b3          	add	a1,s11,a1
    8000609c:	0005c583          	lbu	a1,0(a1)
    800060a0:	02d7d7bb          	divuw	a5,a5,a3
    800060a4:	f8b402a3          	sb	a1,-123(s0)
    800060a8:	46ea7863          	bgeu	s4,a4,80006518 <__printf+0x650>
    800060ac:	02d7f5bb          	remuw	a1,a5,a3
    800060b0:	02059593          	slli	a1,a1,0x20
    800060b4:	0205d593          	srli	a1,a1,0x20
    800060b8:	00bd85b3          	add	a1,s11,a1
    800060bc:	0005c583          	lbu	a1,0(a1)
    800060c0:	02d7d7bb          	divuw	a5,a5,a3
    800060c4:	f8b40323          	sb	a1,-122(s0)
    800060c8:	3eeaf863          	bgeu	s5,a4,800064b8 <__printf+0x5f0>
    800060cc:	02d7f5bb          	remuw	a1,a5,a3
    800060d0:	02059593          	slli	a1,a1,0x20
    800060d4:	0205d593          	srli	a1,a1,0x20
    800060d8:	00bd85b3          	add	a1,s11,a1
    800060dc:	0005c583          	lbu	a1,0(a1)
    800060e0:	02d7d7bb          	divuw	a5,a5,a3
    800060e4:	f8b403a3          	sb	a1,-121(s0)
    800060e8:	42eb7e63          	bgeu	s6,a4,80006524 <__printf+0x65c>
    800060ec:	02d7f5bb          	remuw	a1,a5,a3
    800060f0:	02059593          	slli	a1,a1,0x20
    800060f4:	0205d593          	srli	a1,a1,0x20
    800060f8:	00bd85b3          	add	a1,s11,a1
    800060fc:	0005c583          	lbu	a1,0(a1)
    80006100:	02d7d7bb          	divuw	a5,a5,a3
    80006104:	f8b40423          	sb	a1,-120(s0)
    80006108:	42ebfc63          	bgeu	s7,a4,80006540 <__printf+0x678>
    8000610c:	02079793          	slli	a5,a5,0x20
    80006110:	0207d793          	srli	a5,a5,0x20
    80006114:	00fd8db3          	add	s11,s11,a5
    80006118:	000dc703          	lbu	a4,0(s11)
    8000611c:	00a00793          	li	a5,10
    80006120:	00900c93          	li	s9,9
    80006124:	f8e404a3          	sb	a4,-119(s0)
    80006128:	00065c63          	bgez	a2,80006140 <__printf+0x278>
    8000612c:	f9040713          	addi	a4,s0,-112
    80006130:	00f70733          	add	a4,a4,a5
    80006134:	02d00693          	li	a3,45
    80006138:	fed70823          	sb	a3,-16(a4)
    8000613c:	00078c93          	mv	s9,a5
    80006140:	f8040793          	addi	a5,s0,-128
    80006144:	01978cb3          	add	s9,a5,s9
    80006148:	f7f40d13          	addi	s10,s0,-129
    8000614c:	000cc503          	lbu	a0,0(s9)
    80006150:	fffc8c93          	addi	s9,s9,-1
    80006154:	00000097          	auipc	ra,0x0
    80006158:	b90080e7          	jalr	-1136(ra) # 80005ce4 <consputc>
    8000615c:	ffac98e3          	bne	s9,s10,8000614c <__printf+0x284>
    80006160:	00094503          	lbu	a0,0(s2)
    80006164:	e00514e3          	bnez	a0,80005f6c <__printf+0xa4>
    80006168:	1a0c1663          	bnez	s8,80006314 <__printf+0x44c>
    8000616c:	08813083          	ld	ra,136(sp)
    80006170:	08013403          	ld	s0,128(sp)
    80006174:	07813483          	ld	s1,120(sp)
    80006178:	07013903          	ld	s2,112(sp)
    8000617c:	06813983          	ld	s3,104(sp)
    80006180:	06013a03          	ld	s4,96(sp)
    80006184:	05813a83          	ld	s5,88(sp)
    80006188:	05013b03          	ld	s6,80(sp)
    8000618c:	04813b83          	ld	s7,72(sp)
    80006190:	04013c03          	ld	s8,64(sp)
    80006194:	03813c83          	ld	s9,56(sp)
    80006198:	03013d03          	ld	s10,48(sp)
    8000619c:	02813d83          	ld	s11,40(sp)
    800061a0:	0d010113          	addi	sp,sp,208
    800061a4:	00008067          	ret
    800061a8:	07300713          	li	a4,115
    800061ac:	1ce78a63          	beq	a5,a4,80006380 <__printf+0x4b8>
    800061b0:	07800713          	li	a4,120
    800061b4:	1ee79e63          	bne	a5,a4,800063b0 <__printf+0x4e8>
    800061b8:	f7843783          	ld	a5,-136(s0)
    800061bc:	0007a703          	lw	a4,0(a5)
    800061c0:	00878793          	addi	a5,a5,8
    800061c4:	f6f43c23          	sd	a5,-136(s0)
    800061c8:	28074263          	bltz	a4,8000644c <__printf+0x584>
    800061cc:	00002d97          	auipc	s11,0x2
    800061d0:	2ccd8d93          	addi	s11,s11,716 # 80008498 <digits>
    800061d4:	00f77793          	andi	a5,a4,15
    800061d8:	00fd87b3          	add	a5,s11,a5
    800061dc:	0007c683          	lbu	a3,0(a5)
    800061e0:	00f00613          	li	a2,15
    800061e4:	0007079b          	sext.w	a5,a4
    800061e8:	f8d40023          	sb	a3,-128(s0)
    800061ec:	0047559b          	srliw	a1,a4,0x4
    800061f0:	0047569b          	srliw	a3,a4,0x4
    800061f4:	00000c93          	li	s9,0
    800061f8:	0ee65063          	bge	a2,a4,800062d8 <__printf+0x410>
    800061fc:	00f6f693          	andi	a3,a3,15
    80006200:	00dd86b3          	add	a3,s11,a3
    80006204:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006208:	0087d79b          	srliw	a5,a5,0x8
    8000620c:	00100c93          	li	s9,1
    80006210:	f8d400a3          	sb	a3,-127(s0)
    80006214:	0cb67263          	bgeu	a2,a1,800062d8 <__printf+0x410>
    80006218:	00f7f693          	andi	a3,a5,15
    8000621c:	00dd86b3          	add	a3,s11,a3
    80006220:	0006c583          	lbu	a1,0(a3)
    80006224:	00f00613          	li	a2,15
    80006228:	0047d69b          	srliw	a3,a5,0x4
    8000622c:	f8b40123          	sb	a1,-126(s0)
    80006230:	0047d593          	srli	a1,a5,0x4
    80006234:	28f67e63          	bgeu	a2,a5,800064d0 <__printf+0x608>
    80006238:	00f6f693          	andi	a3,a3,15
    8000623c:	00dd86b3          	add	a3,s11,a3
    80006240:	0006c503          	lbu	a0,0(a3)
    80006244:	0087d813          	srli	a6,a5,0x8
    80006248:	0087d69b          	srliw	a3,a5,0x8
    8000624c:	f8a401a3          	sb	a0,-125(s0)
    80006250:	28b67663          	bgeu	a2,a1,800064dc <__printf+0x614>
    80006254:	00f6f693          	andi	a3,a3,15
    80006258:	00dd86b3          	add	a3,s11,a3
    8000625c:	0006c583          	lbu	a1,0(a3)
    80006260:	00c7d513          	srli	a0,a5,0xc
    80006264:	00c7d69b          	srliw	a3,a5,0xc
    80006268:	f8b40223          	sb	a1,-124(s0)
    8000626c:	29067a63          	bgeu	a2,a6,80006500 <__printf+0x638>
    80006270:	00f6f693          	andi	a3,a3,15
    80006274:	00dd86b3          	add	a3,s11,a3
    80006278:	0006c583          	lbu	a1,0(a3)
    8000627c:	0107d813          	srli	a6,a5,0x10
    80006280:	0107d69b          	srliw	a3,a5,0x10
    80006284:	f8b402a3          	sb	a1,-123(s0)
    80006288:	28a67263          	bgeu	a2,a0,8000650c <__printf+0x644>
    8000628c:	00f6f693          	andi	a3,a3,15
    80006290:	00dd86b3          	add	a3,s11,a3
    80006294:	0006c683          	lbu	a3,0(a3)
    80006298:	0147d79b          	srliw	a5,a5,0x14
    8000629c:	f8d40323          	sb	a3,-122(s0)
    800062a0:	21067663          	bgeu	a2,a6,800064ac <__printf+0x5e4>
    800062a4:	02079793          	slli	a5,a5,0x20
    800062a8:	0207d793          	srli	a5,a5,0x20
    800062ac:	00fd8db3          	add	s11,s11,a5
    800062b0:	000dc683          	lbu	a3,0(s11)
    800062b4:	00800793          	li	a5,8
    800062b8:	00700c93          	li	s9,7
    800062bc:	f8d403a3          	sb	a3,-121(s0)
    800062c0:	00075c63          	bgez	a4,800062d8 <__printf+0x410>
    800062c4:	f9040713          	addi	a4,s0,-112
    800062c8:	00f70733          	add	a4,a4,a5
    800062cc:	02d00693          	li	a3,45
    800062d0:	fed70823          	sb	a3,-16(a4)
    800062d4:	00078c93          	mv	s9,a5
    800062d8:	f8040793          	addi	a5,s0,-128
    800062dc:	01978cb3          	add	s9,a5,s9
    800062e0:	f7f40d13          	addi	s10,s0,-129
    800062e4:	000cc503          	lbu	a0,0(s9)
    800062e8:	fffc8c93          	addi	s9,s9,-1
    800062ec:	00000097          	auipc	ra,0x0
    800062f0:	9f8080e7          	jalr	-1544(ra) # 80005ce4 <consputc>
    800062f4:	ff9d18e3          	bne	s10,s9,800062e4 <__printf+0x41c>
    800062f8:	0100006f          	j	80006308 <__printf+0x440>
    800062fc:	00000097          	auipc	ra,0x0
    80006300:	9e8080e7          	jalr	-1560(ra) # 80005ce4 <consputc>
    80006304:	000c8493          	mv	s1,s9
    80006308:	00094503          	lbu	a0,0(s2)
    8000630c:	c60510e3          	bnez	a0,80005f6c <__printf+0xa4>
    80006310:	e40c0ee3          	beqz	s8,8000616c <__printf+0x2a4>
    80006314:	00005517          	auipc	a0,0x5
    80006318:	4bc50513          	addi	a0,a0,1212 # 8000b7d0 <pr>
    8000631c:	00001097          	auipc	ra,0x1
    80006320:	94c080e7          	jalr	-1716(ra) # 80006c68 <release>
    80006324:	e49ff06f          	j	8000616c <__printf+0x2a4>
    80006328:	f7843783          	ld	a5,-136(s0)
    8000632c:	03000513          	li	a0,48
    80006330:	01000d13          	li	s10,16
    80006334:	00878713          	addi	a4,a5,8
    80006338:	0007bc83          	ld	s9,0(a5)
    8000633c:	f6e43c23          	sd	a4,-136(s0)
    80006340:	00000097          	auipc	ra,0x0
    80006344:	9a4080e7          	jalr	-1628(ra) # 80005ce4 <consputc>
    80006348:	07800513          	li	a0,120
    8000634c:	00000097          	auipc	ra,0x0
    80006350:	998080e7          	jalr	-1640(ra) # 80005ce4 <consputc>
    80006354:	00002d97          	auipc	s11,0x2
    80006358:	144d8d93          	addi	s11,s11,324 # 80008498 <digits>
    8000635c:	03ccd793          	srli	a5,s9,0x3c
    80006360:	00fd87b3          	add	a5,s11,a5
    80006364:	0007c503          	lbu	a0,0(a5)
    80006368:	fffd0d1b          	addiw	s10,s10,-1
    8000636c:	004c9c93          	slli	s9,s9,0x4
    80006370:	00000097          	auipc	ra,0x0
    80006374:	974080e7          	jalr	-1676(ra) # 80005ce4 <consputc>
    80006378:	fe0d12e3          	bnez	s10,8000635c <__printf+0x494>
    8000637c:	f8dff06f          	j	80006308 <__printf+0x440>
    80006380:	f7843783          	ld	a5,-136(s0)
    80006384:	0007bc83          	ld	s9,0(a5)
    80006388:	00878793          	addi	a5,a5,8
    8000638c:	f6f43c23          	sd	a5,-136(s0)
    80006390:	000c9a63          	bnez	s9,800063a4 <__printf+0x4dc>
    80006394:	1080006f          	j	8000649c <__printf+0x5d4>
    80006398:	001c8c93          	addi	s9,s9,1
    8000639c:	00000097          	auipc	ra,0x0
    800063a0:	948080e7          	jalr	-1720(ra) # 80005ce4 <consputc>
    800063a4:	000cc503          	lbu	a0,0(s9)
    800063a8:	fe0518e3          	bnez	a0,80006398 <__printf+0x4d0>
    800063ac:	f5dff06f          	j	80006308 <__printf+0x440>
    800063b0:	02500513          	li	a0,37
    800063b4:	00000097          	auipc	ra,0x0
    800063b8:	930080e7          	jalr	-1744(ra) # 80005ce4 <consputc>
    800063bc:	000c8513          	mv	a0,s9
    800063c0:	00000097          	auipc	ra,0x0
    800063c4:	924080e7          	jalr	-1756(ra) # 80005ce4 <consputc>
    800063c8:	f41ff06f          	j	80006308 <__printf+0x440>
    800063cc:	02500513          	li	a0,37
    800063d0:	00000097          	auipc	ra,0x0
    800063d4:	914080e7          	jalr	-1772(ra) # 80005ce4 <consputc>
    800063d8:	f31ff06f          	j	80006308 <__printf+0x440>
    800063dc:	00030513          	mv	a0,t1
    800063e0:	00000097          	auipc	ra,0x0
    800063e4:	7bc080e7          	jalr	1980(ra) # 80006b9c <acquire>
    800063e8:	b4dff06f          	j	80005f34 <__printf+0x6c>
    800063ec:	40c0053b          	negw	a0,a2
    800063f0:	00a00713          	li	a4,10
    800063f4:	02e576bb          	remuw	a3,a0,a4
    800063f8:	00002d97          	auipc	s11,0x2
    800063fc:	0a0d8d93          	addi	s11,s11,160 # 80008498 <digits>
    80006400:	ff700593          	li	a1,-9
    80006404:	02069693          	slli	a3,a3,0x20
    80006408:	0206d693          	srli	a3,a3,0x20
    8000640c:	00dd86b3          	add	a3,s11,a3
    80006410:	0006c683          	lbu	a3,0(a3)
    80006414:	02e557bb          	divuw	a5,a0,a4
    80006418:	f8d40023          	sb	a3,-128(s0)
    8000641c:	10b65e63          	bge	a2,a1,80006538 <__printf+0x670>
    80006420:	06300593          	li	a1,99
    80006424:	02e7f6bb          	remuw	a3,a5,a4
    80006428:	02069693          	slli	a3,a3,0x20
    8000642c:	0206d693          	srli	a3,a3,0x20
    80006430:	00dd86b3          	add	a3,s11,a3
    80006434:	0006c683          	lbu	a3,0(a3)
    80006438:	02e7d73b          	divuw	a4,a5,a4
    8000643c:	00200793          	li	a5,2
    80006440:	f8d400a3          	sb	a3,-127(s0)
    80006444:	bca5ece3          	bltu	a1,a0,8000601c <__printf+0x154>
    80006448:	ce5ff06f          	j	8000612c <__printf+0x264>
    8000644c:	40e007bb          	negw	a5,a4
    80006450:	00002d97          	auipc	s11,0x2
    80006454:	048d8d93          	addi	s11,s11,72 # 80008498 <digits>
    80006458:	00f7f693          	andi	a3,a5,15
    8000645c:	00dd86b3          	add	a3,s11,a3
    80006460:	0006c583          	lbu	a1,0(a3)
    80006464:	ff100613          	li	a2,-15
    80006468:	0047d69b          	srliw	a3,a5,0x4
    8000646c:	f8b40023          	sb	a1,-128(s0)
    80006470:	0047d59b          	srliw	a1,a5,0x4
    80006474:	0ac75e63          	bge	a4,a2,80006530 <__printf+0x668>
    80006478:	00f6f693          	andi	a3,a3,15
    8000647c:	00dd86b3          	add	a3,s11,a3
    80006480:	0006c603          	lbu	a2,0(a3)
    80006484:	00f00693          	li	a3,15
    80006488:	0087d79b          	srliw	a5,a5,0x8
    8000648c:	f8c400a3          	sb	a2,-127(s0)
    80006490:	d8b6e4e3          	bltu	a3,a1,80006218 <__printf+0x350>
    80006494:	00200793          	li	a5,2
    80006498:	e2dff06f          	j	800062c4 <__printf+0x3fc>
    8000649c:	00002c97          	auipc	s9,0x2
    800064a0:	fdcc8c93          	addi	s9,s9,-36 # 80008478 <CONSOLE_STATUS+0x468>
    800064a4:	02800513          	li	a0,40
    800064a8:	ef1ff06f          	j	80006398 <__printf+0x4d0>
    800064ac:	00700793          	li	a5,7
    800064b0:	00600c93          	li	s9,6
    800064b4:	e0dff06f          	j	800062c0 <__printf+0x3f8>
    800064b8:	00700793          	li	a5,7
    800064bc:	00600c93          	li	s9,6
    800064c0:	c69ff06f          	j	80006128 <__printf+0x260>
    800064c4:	00300793          	li	a5,3
    800064c8:	00200c93          	li	s9,2
    800064cc:	c5dff06f          	j	80006128 <__printf+0x260>
    800064d0:	00300793          	li	a5,3
    800064d4:	00200c93          	li	s9,2
    800064d8:	de9ff06f          	j	800062c0 <__printf+0x3f8>
    800064dc:	00400793          	li	a5,4
    800064e0:	00300c93          	li	s9,3
    800064e4:	dddff06f          	j	800062c0 <__printf+0x3f8>
    800064e8:	00400793          	li	a5,4
    800064ec:	00300c93          	li	s9,3
    800064f0:	c39ff06f          	j	80006128 <__printf+0x260>
    800064f4:	00500793          	li	a5,5
    800064f8:	00400c93          	li	s9,4
    800064fc:	c2dff06f          	j	80006128 <__printf+0x260>
    80006500:	00500793          	li	a5,5
    80006504:	00400c93          	li	s9,4
    80006508:	db9ff06f          	j	800062c0 <__printf+0x3f8>
    8000650c:	00600793          	li	a5,6
    80006510:	00500c93          	li	s9,5
    80006514:	dadff06f          	j	800062c0 <__printf+0x3f8>
    80006518:	00600793          	li	a5,6
    8000651c:	00500c93          	li	s9,5
    80006520:	c09ff06f          	j	80006128 <__printf+0x260>
    80006524:	00800793          	li	a5,8
    80006528:	00700c93          	li	s9,7
    8000652c:	bfdff06f          	j	80006128 <__printf+0x260>
    80006530:	00100793          	li	a5,1
    80006534:	d91ff06f          	j	800062c4 <__printf+0x3fc>
    80006538:	00100793          	li	a5,1
    8000653c:	bf1ff06f          	j	8000612c <__printf+0x264>
    80006540:	00900793          	li	a5,9
    80006544:	00800c93          	li	s9,8
    80006548:	be1ff06f          	j	80006128 <__printf+0x260>
    8000654c:	00002517          	auipc	a0,0x2
    80006550:	f3450513          	addi	a0,a0,-204 # 80008480 <CONSOLE_STATUS+0x470>
    80006554:	00000097          	auipc	ra,0x0
    80006558:	918080e7          	jalr	-1768(ra) # 80005e6c <panic>

000000008000655c <printfinit>:
    8000655c:	fe010113          	addi	sp,sp,-32
    80006560:	00813823          	sd	s0,16(sp)
    80006564:	00913423          	sd	s1,8(sp)
    80006568:	00113c23          	sd	ra,24(sp)
    8000656c:	02010413          	addi	s0,sp,32
    80006570:	00005497          	auipc	s1,0x5
    80006574:	26048493          	addi	s1,s1,608 # 8000b7d0 <pr>
    80006578:	00048513          	mv	a0,s1
    8000657c:	00002597          	auipc	a1,0x2
    80006580:	f1458593          	addi	a1,a1,-236 # 80008490 <CONSOLE_STATUS+0x480>
    80006584:	00000097          	auipc	ra,0x0
    80006588:	5f4080e7          	jalr	1524(ra) # 80006b78 <initlock>
    8000658c:	01813083          	ld	ra,24(sp)
    80006590:	01013403          	ld	s0,16(sp)
    80006594:	0004ac23          	sw	zero,24(s1)
    80006598:	00813483          	ld	s1,8(sp)
    8000659c:	02010113          	addi	sp,sp,32
    800065a0:	00008067          	ret

00000000800065a4 <uartinit>:
    800065a4:	ff010113          	addi	sp,sp,-16
    800065a8:	00813423          	sd	s0,8(sp)
    800065ac:	01010413          	addi	s0,sp,16
    800065b0:	100007b7          	lui	a5,0x10000
    800065b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800065b8:	f8000713          	li	a4,-128
    800065bc:	00e781a3          	sb	a4,3(a5)
    800065c0:	00300713          	li	a4,3
    800065c4:	00e78023          	sb	a4,0(a5)
    800065c8:	000780a3          	sb	zero,1(a5)
    800065cc:	00e781a3          	sb	a4,3(a5)
    800065d0:	00700693          	li	a3,7
    800065d4:	00d78123          	sb	a3,2(a5)
    800065d8:	00e780a3          	sb	a4,1(a5)
    800065dc:	00813403          	ld	s0,8(sp)
    800065e0:	01010113          	addi	sp,sp,16
    800065e4:	00008067          	ret

00000000800065e8 <uartputc>:
    800065e8:	00004797          	auipc	a5,0x4
    800065ec:	e507a783          	lw	a5,-432(a5) # 8000a438 <panicked>
    800065f0:	00078463          	beqz	a5,800065f8 <uartputc+0x10>
    800065f4:	0000006f          	j	800065f4 <uartputc+0xc>
    800065f8:	fd010113          	addi	sp,sp,-48
    800065fc:	02813023          	sd	s0,32(sp)
    80006600:	00913c23          	sd	s1,24(sp)
    80006604:	01213823          	sd	s2,16(sp)
    80006608:	01313423          	sd	s3,8(sp)
    8000660c:	02113423          	sd	ra,40(sp)
    80006610:	03010413          	addi	s0,sp,48
    80006614:	00004917          	auipc	s2,0x4
    80006618:	e2c90913          	addi	s2,s2,-468 # 8000a440 <uart_tx_r>
    8000661c:	00093783          	ld	a5,0(s2)
    80006620:	00004497          	auipc	s1,0x4
    80006624:	e2848493          	addi	s1,s1,-472 # 8000a448 <uart_tx_w>
    80006628:	0004b703          	ld	a4,0(s1)
    8000662c:	02078693          	addi	a3,a5,32
    80006630:	00050993          	mv	s3,a0
    80006634:	02e69c63          	bne	a3,a4,8000666c <uartputc+0x84>
    80006638:	00001097          	auipc	ra,0x1
    8000663c:	834080e7          	jalr	-1996(ra) # 80006e6c <push_on>
    80006640:	00093783          	ld	a5,0(s2)
    80006644:	0004b703          	ld	a4,0(s1)
    80006648:	02078793          	addi	a5,a5,32
    8000664c:	00e79463          	bne	a5,a4,80006654 <uartputc+0x6c>
    80006650:	0000006f          	j	80006650 <uartputc+0x68>
    80006654:	00001097          	auipc	ra,0x1
    80006658:	88c080e7          	jalr	-1908(ra) # 80006ee0 <pop_on>
    8000665c:	00093783          	ld	a5,0(s2)
    80006660:	0004b703          	ld	a4,0(s1)
    80006664:	02078693          	addi	a3,a5,32
    80006668:	fce688e3          	beq	a3,a4,80006638 <uartputc+0x50>
    8000666c:	01f77693          	andi	a3,a4,31
    80006670:	00005597          	auipc	a1,0x5
    80006674:	18058593          	addi	a1,a1,384 # 8000b7f0 <uart_tx_buf>
    80006678:	00d586b3          	add	a3,a1,a3
    8000667c:	00170713          	addi	a4,a4,1
    80006680:	01368023          	sb	s3,0(a3)
    80006684:	00e4b023          	sd	a4,0(s1)
    80006688:	10000637          	lui	a2,0x10000
    8000668c:	02f71063          	bne	a4,a5,800066ac <uartputc+0xc4>
    80006690:	0340006f          	j	800066c4 <uartputc+0xdc>
    80006694:	00074703          	lbu	a4,0(a4)
    80006698:	00f93023          	sd	a5,0(s2)
    8000669c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800066a0:	00093783          	ld	a5,0(s2)
    800066a4:	0004b703          	ld	a4,0(s1)
    800066a8:	00f70e63          	beq	a4,a5,800066c4 <uartputc+0xdc>
    800066ac:	00564683          	lbu	a3,5(a2)
    800066b0:	01f7f713          	andi	a4,a5,31
    800066b4:	00e58733          	add	a4,a1,a4
    800066b8:	0206f693          	andi	a3,a3,32
    800066bc:	00178793          	addi	a5,a5,1
    800066c0:	fc069ae3          	bnez	a3,80006694 <uartputc+0xac>
    800066c4:	02813083          	ld	ra,40(sp)
    800066c8:	02013403          	ld	s0,32(sp)
    800066cc:	01813483          	ld	s1,24(sp)
    800066d0:	01013903          	ld	s2,16(sp)
    800066d4:	00813983          	ld	s3,8(sp)
    800066d8:	03010113          	addi	sp,sp,48
    800066dc:	00008067          	ret

00000000800066e0 <uartputc_sync>:
    800066e0:	ff010113          	addi	sp,sp,-16
    800066e4:	00813423          	sd	s0,8(sp)
    800066e8:	01010413          	addi	s0,sp,16
    800066ec:	00004717          	auipc	a4,0x4
    800066f0:	d4c72703          	lw	a4,-692(a4) # 8000a438 <panicked>
    800066f4:	02071663          	bnez	a4,80006720 <uartputc_sync+0x40>
    800066f8:	00050793          	mv	a5,a0
    800066fc:	100006b7          	lui	a3,0x10000
    80006700:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006704:	02077713          	andi	a4,a4,32
    80006708:	fe070ce3          	beqz	a4,80006700 <uartputc_sync+0x20>
    8000670c:	0ff7f793          	andi	a5,a5,255
    80006710:	00f68023          	sb	a5,0(a3)
    80006714:	00813403          	ld	s0,8(sp)
    80006718:	01010113          	addi	sp,sp,16
    8000671c:	00008067          	ret
    80006720:	0000006f          	j	80006720 <uartputc_sync+0x40>

0000000080006724 <uartstart>:
    80006724:	ff010113          	addi	sp,sp,-16
    80006728:	00813423          	sd	s0,8(sp)
    8000672c:	01010413          	addi	s0,sp,16
    80006730:	00004617          	auipc	a2,0x4
    80006734:	d1060613          	addi	a2,a2,-752 # 8000a440 <uart_tx_r>
    80006738:	00004517          	auipc	a0,0x4
    8000673c:	d1050513          	addi	a0,a0,-752 # 8000a448 <uart_tx_w>
    80006740:	00063783          	ld	a5,0(a2)
    80006744:	00053703          	ld	a4,0(a0)
    80006748:	04f70263          	beq	a4,a5,8000678c <uartstart+0x68>
    8000674c:	100005b7          	lui	a1,0x10000
    80006750:	00005817          	auipc	a6,0x5
    80006754:	0a080813          	addi	a6,a6,160 # 8000b7f0 <uart_tx_buf>
    80006758:	01c0006f          	j	80006774 <uartstart+0x50>
    8000675c:	0006c703          	lbu	a4,0(a3)
    80006760:	00f63023          	sd	a5,0(a2)
    80006764:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006768:	00063783          	ld	a5,0(a2)
    8000676c:	00053703          	ld	a4,0(a0)
    80006770:	00f70e63          	beq	a4,a5,8000678c <uartstart+0x68>
    80006774:	01f7f713          	andi	a4,a5,31
    80006778:	00e806b3          	add	a3,a6,a4
    8000677c:	0055c703          	lbu	a4,5(a1)
    80006780:	00178793          	addi	a5,a5,1
    80006784:	02077713          	andi	a4,a4,32
    80006788:	fc071ae3          	bnez	a4,8000675c <uartstart+0x38>
    8000678c:	00813403          	ld	s0,8(sp)
    80006790:	01010113          	addi	sp,sp,16
    80006794:	00008067          	ret

0000000080006798 <uartgetc>:
    80006798:	ff010113          	addi	sp,sp,-16
    8000679c:	00813423          	sd	s0,8(sp)
    800067a0:	01010413          	addi	s0,sp,16
    800067a4:	10000737          	lui	a4,0x10000
    800067a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800067ac:	0017f793          	andi	a5,a5,1
    800067b0:	00078c63          	beqz	a5,800067c8 <uartgetc+0x30>
    800067b4:	00074503          	lbu	a0,0(a4)
    800067b8:	0ff57513          	andi	a0,a0,255
    800067bc:	00813403          	ld	s0,8(sp)
    800067c0:	01010113          	addi	sp,sp,16
    800067c4:	00008067          	ret
    800067c8:	fff00513          	li	a0,-1
    800067cc:	ff1ff06f          	j	800067bc <uartgetc+0x24>

00000000800067d0 <uartintr>:
    800067d0:	100007b7          	lui	a5,0x10000
    800067d4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800067d8:	0017f793          	andi	a5,a5,1
    800067dc:	0a078463          	beqz	a5,80006884 <uartintr+0xb4>
    800067e0:	fe010113          	addi	sp,sp,-32
    800067e4:	00813823          	sd	s0,16(sp)
    800067e8:	00913423          	sd	s1,8(sp)
    800067ec:	00113c23          	sd	ra,24(sp)
    800067f0:	02010413          	addi	s0,sp,32
    800067f4:	100004b7          	lui	s1,0x10000
    800067f8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800067fc:	0ff57513          	andi	a0,a0,255
    80006800:	fffff097          	auipc	ra,0xfffff
    80006804:	534080e7          	jalr	1332(ra) # 80005d34 <consoleintr>
    80006808:	0054c783          	lbu	a5,5(s1)
    8000680c:	0017f793          	andi	a5,a5,1
    80006810:	fe0794e3          	bnez	a5,800067f8 <uartintr+0x28>
    80006814:	00004617          	auipc	a2,0x4
    80006818:	c2c60613          	addi	a2,a2,-980 # 8000a440 <uart_tx_r>
    8000681c:	00004517          	auipc	a0,0x4
    80006820:	c2c50513          	addi	a0,a0,-980 # 8000a448 <uart_tx_w>
    80006824:	00063783          	ld	a5,0(a2)
    80006828:	00053703          	ld	a4,0(a0)
    8000682c:	04f70263          	beq	a4,a5,80006870 <uartintr+0xa0>
    80006830:	100005b7          	lui	a1,0x10000
    80006834:	00005817          	auipc	a6,0x5
    80006838:	fbc80813          	addi	a6,a6,-68 # 8000b7f0 <uart_tx_buf>
    8000683c:	01c0006f          	j	80006858 <uartintr+0x88>
    80006840:	0006c703          	lbu	a4,0(a3)
    80006844:	00f63023          	sd	a5,0(a2)
    80006848:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000684c:	00063783          	ld	a5,0(a2)
    80006850:	00053703          	ld	a4,0(a0)
    80006854:	00f70e63          	beq	a4,a5,80006870 <uartintr+0xa0>
    80006858:	01f7f713          	andi	a4,a5,31
    8000685c:	00e806b3          	add	a3,a6,a4
    80006860:	0055c703          	lbu	a4,5(a1)
    80006864:	00178793          	addi	a5,a5,1
    80006868:	02077713          	andi	a4,a4,32
    8000686c:	fc071ae3          	bnez	a4,80006840 <uartintr+0x70>
    80006870:	01813083          	ld	ra,24(sp)
    80006874:	01013403          	ld	s0,16(sp)
    80006878:	00813483          	ld	s1,8(sp)
    8000687c:	02010113          	addi	sp,sp,32
    80006880:	00008067          	ret
    80006884:	00004617          	auipc	a2,0x4
    80006888:	bbc60613          	addi	a2,a2,-1092 # 8000a440 <uart_tx_r>
    8000688c:	00004517          	auipc	a0,0x4
    80006890:	bbc50513          	addi	a0,a0,-1092 # 8000a448 <uart_tx_w>
    80006894:	00063783          	ld	a5,0(a2)
    80006898:	00053703          	ld	a4,0(a0)
    8000689c:	04f70263          	beq	a4,a5,800068e0 <uartintr+0x110>
    800068a0:	100005b7          	lui	a1,0x10000
    800068a4:	00005817          	auipc	a6,0x5
    800068a8:	f4c80813          	addi	a6,a6,-180 # 8000b7f0 <uart_tx_buf>
    800068ac:	01c0006f          	j	800068c8 <uartintr+0xf8>
    800068b0:	0006c703          	lbu	a4,0(a3)
    800068b4:	00f63023          	sd	a5,0(a2)
    800068b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800068bc:	00063783          	ld	a5,0(a2)
    800068c0:	00053703          	ld	a4,0(a0)
    800068c4:	02f70063          	beq	a4,a5,800068e4 <uartintr+0x114>
    800068c8:	01f7f713          	andi	a4,a5,31
    800068cc:	00e806b3          	add	a3,a6,a4
    800068d0:	0055c703          	lbu	a4,5(a1)
    800068d4:	00178793          	addi	a5,a5,1
    800068d8:	02077713          	andi	a4,a4,32
    800068dc:	fc071ae3          	bnez	a4,800068b0 <uartintr+0xe0>
    800068e0:	00008067          	ret
    800068e4:	00008067          	ret

00000000800068e8 <kinit>:
    800068e8:	fc010113          	addi	sp,sp,-64
    800068ec:	02913423          	sd	s1,40(sp)
    800068f0:	fffff7b7          	lui	a5,0xfffff
    800068f4:	00006497          	auipc	s1,0x6
    800068f8:	f1b48493          	addi	s1,s1,-229 # 8000c80f <end+0xfff>
    800068fc:	02813823          	sd	s0,48(sp)
    80006900:	01313c23          	sd	s3,24(sp)
    80006904:	00f4f4b3          	and	s1,s1,a5
    80006908:	02113c23          	sd	ra,56(sp)
    8000690c:	03213023          	sd	s2,32(sp)
    80006910:	01413823          	sd	s4,16(sp)
    80006914:	01513423          	sd	s5,8(sp)
    80006918:	04010413          	addi	s0,sp,64
    8000691c:	000017b7          	lui	a5,0x1
    80006920:	01100993          	li	s3,17
    80006924:	00f487b3          	add	a5,s1,a5
    80006928:	01b99993          	slli	s3,s3,0x1b
    8000692c:	06f9e063          	bltu	s3,a5,8000698c <kinit+0xa4>
    80006930:	00005a97          	auipc	s5,0x5
    80006934:	ee0a8a93          	addi	s5,s5,-288 # 8000b810 <end>
    80006938:	0754ec63          	bltu	s1,s5,800069b0 <kinit+0xc8>
    8000693c:	0734fa63          	bgeu	s1,s3,800069b0 <kinit+0xc8>
    80006940:	00088a37          	lui	s4,0x88
    80006944:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006948:	00004917          	auipc	s2,0x4
    8000694c:	b0890913          	addi	s2,s2,-1272 # 8000a450 <kmem>
    80006950:	00ca1a13          	slli	s4,s4,0xc
    80006954:	0140006f          	j	80006968 <kinit+0x80>
    80006958:	000017b7          	lui	a5,0x1
    8000695c:	00f484b3          	add	s1,s1,a5
    80006960:	0554e863          	bltu	s1,s5,800069b0 <kinit+0xc8>
    80006964:	0534f663          	bgeu	s1,s3,800069b0 <kinit+0xc8>
    80006968:	00001637          	lui	a2,0x1
    8000696c:	00100593          	li	a1,1
    80006970:	00048513          	mv	a0,s1
    80006974:	00000097          	auipc	ra,0x0
    80006978:	5e4080e7          	jalr	1508(ra) # 80006f58 <__memset>
    8000697c:	00093783          	ld	a5,0(s2)
    80006980:	00f4b023          	sd	a5,0(s1)
    80006984:	00993023          	sd	s1,0(s2)
    80006988:	fd4498e3          	bne	s1,s4,80006958 <kinit+0x70>
    8000698c:	03813083          	ld	ra,56(sp)
    80006990:	03013403          	ld	s0,48(sp)
    80006994:	02813483          	ld	s1,40(sp)
    80006998:	02013903          	ld	s2,32(sp)
    8000699c:	01813983          	ld	s3,24(sp)
    800069a0:	01013a03          	ld	s4,16(sp)
    800069a4:	00813a83          	ld	s5,8(sp)
    800069a8:	04010113          	addi	sp,sp,64
    800069ac:	00008067          	ret
    800069b0:	00002517          	auipc	a0,0x2
    800069b4:	b0050513          	addi	a0,a0,-1280 # 800084b0 <digits+0x18>
    800069b8:	fffff097          	auipc	ra,0xfffff
    800069bc:	4b4080e7          	jalr	1204(ra) # 80005e6c <panic>

00000000800069c0 <freerange>:
    800069c0:	fc010113          	addi	sp,sp,-64
    800069c4:	000017b7          	lui	a5,0x1
    800069c8:	02913423          	sd	s1,40(sp)
    800069cc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800069d0:	009504b3          	add	s1,a0,s1
    800069d4:	fffff537          	lui	a0,0xfffff
    800069d8:	02813823          	sd	s0,48(sp)
    800069dc:	02113c23          	sd	ra,56(sp)
    800069e0:	03213023          	sd	s2,32(sp)
    800069e4:	01313c23          	sd	s3,24(sp)
    800069e8:	01413823          	sd	s4,16(sp)
    800069ec:	01513423          	sd	s5,8(sp)
    800069f0:	01613023          	sd	s6,0(sp)
    800069f4:	04010413          	addi	s0,sp,64
    800069f8:	00a4f4b3          	and	s1,s1,a0
    800069fc:	00f487b3          	add	a5,s1,a5
    80006a00:	06f5e463          	bltu	a1,a5,80006a68 <freerange+0xa8>
    80006a04:	00005a97          	auipc	s5,0x5
    80006a08:	e0ca8a93          	addi	s5,s5,-500 # 8000b810 <end>
    80006a0c:	0954e263          	bltu	s1,s5,80006a90 <freerange+0xd0>
    80006a10:	01100993          	li	s3,17
    80006a14:	01b99993          	slli	s3,s3,0x1b
    80006a18:	0734fc63          	bgeu	s1,s3,80006a90 <freerange+0xd0>
    80006a1c:	00058a13          	mv	s4,a1
    80006a20:	00004917          	auipc	s2,0x4
    80006a24:	a3090913          	addi	s2,s2,-1488 # 8000a450 <kmem>
    80006a28:	00002b37          	lui	s6,0x2
    80006a2c:	0140006f          	j	80006a40 <freerange+0x80>
    80006a30:	000017b7          	lui	a5,0x1
    80006a34:	00f484b3          	add	s1,s1,a5
    80006a38:	0554ec63          	bltu	s1,s5,80006a90 <freerange+0xd0>
    80006a3c:	0534fa63          	bgeu	s1,s3,80006a90 <freerange+0xd0>
    80006a40:	00001637          	lui	a2,0x1
    80006a44:	00100593          	li	a1,1
    80006a48:	00048513          	mv	a0,s1
    80006a4c:	00000097          	auipc	ra,0x0
    80006a50:	50c080e7          	jalr	1292(ra) # 80006f58 <__memset>
    80006a54:	00093703          	ld	a4,0(s2)
    80006a58:	016487b3          	add	a5,s1,s6
    80006a5c:	00e4b023          	sd	a4,0(s1)
    80006a60:	00993023          	sd	s1,0(s2)
    80006a64:	fcfa76e3          	bgeu	s4,a5,80006a30 <freerange+0x70>
    80006a68:	03813083          	ld	ra,56(sp)
    80006a6c:	03013403          	ld	s0,48(sp)
    80006a70:	02813483          	ld	s1,40(sp)
    80006a74:	02013903          	ld	s2,32(sp)
    80006a78:	01813983          	ld	s3,24(sp)
    80006a7c:	01013a03          	ld	s4,16(sp)
    80006a80:	00813a83          	ld	s5,8(sp)
    80006a84:	00013b03          	ld	s6,0(sp)
    80006a88:	04010113          	addi	sp,sp,64
    80006a8c:	00008067          	ret
    80006a90:	00002517          	auipc	a0,0x2
    80006a94:	a2050513          	addi	a0,a0,-1504 # 800084b0 <digits+0x18>
    80006a98:	fffff097          	auipc	ra,0xfffff
    80006a9c:	3d4080e7          	jalr	980(ra) # 80005e6c <panic>

0000000080006aa0 <kfree>:
    80006aa0:	fe010113          	addi	sp,sp,-32
    80006aa4:	00813823          	sd	s0,16(sp)
    80006aa8:	00113c23          	sd	ra,24(sp)
    80006aac:	00913423          	sd	s1,8(sp)
    80006ab0:	02010413          	addi	s0,sp,32
    80006ab4:	03451793          	slli	a5,a0,0x34
    80006ab8:	04079c63          	bnez	a5,80006b10 <kfree+0x70>
    80006abc:	00005797          	auipc	a5,0x5
    80006ac0:	d5478793          	addi	a5,a5,-684 # 8000b810 <end>
    80006ac4:	00050493          	mv	s1,a0
    80006ac8:	04f56463          	bltu	a0,a5,80006b10 <kfree+0x70>
    80006acc:	01100793          	li	a5,17
    80006ad0:	01b79793          	slli	a5,a5,0x1b
    80006ad4:	02f57e63          	bgeu	a0,a5,80006b10 <kfree+0x70>
    80006ad8:	00001637          	lui	a2,0x1
    80006adc:	00100593          	li	a1,1
    80006ae0:	00000097          	auipc	ra,0x0
    80006ae4:	478080e7          	jalr	1144(ra) # 80006f58 <__memset>
    80006ae8:	00004797          	auipc	a5,0x4
    80006aec:	96878793          	addi	a5,a5,-1688 # 8000a450 <kmem>
    80006af0:	0007b703          	ld	a4,0(a5)
    80006af4:	01813083          	ld	ra,24(sp)
    80006af8:	01013403          	ld	s0,16(sp)
    80006afc:	00e4b023          	sd	a4,0(s1)
    80006b00:	0097b023          	sd	s1,0(a5)
    80006b04:	00813483          	ld	s1,8(sp)
    80006b08:	02010113          	addi	sp,sp,32
    80006b0c:	00008067          	ret
    80006b10:	00002517          	auipc	a0,0x2
    80006b14:	9a050513          	addi	a0,a0,-1632 # 800084b0 <digits+0x18>
    80006b18:	fffff097          	auipc	ra,0xfffff
    80006b1c:	354080e7          	jalr	852(ra) # 80005e6c <panic>

0000000080006b20 <kalloc>:
    80006b20:	fe010113          	addi	sp,sp,-32
    80006b24:	00813823          	sd	s0,16(sp)
    80006b28:	00913423          	sd	s1,8(sp)
    80006b2c:	00113c23          	sd	ra,24(sp)
    80006b30:	02010413          	addi	s0,sp,32
    80006b34:	00004797          	auipc	a5,0x4
    80006b38:	91c78793          	addi	a5,a5,-1764 # 8000a450 <kmem>
    80006b3c:	0007b483          	ld	s1,0(a5)
    80006b40:	02048063          	beqz	s1,80006b60 <kalloc+0x40>
    80006b44:	0004b703          	ld	a4,0(s1)
    80006b48:	00001637          	lui	a2,0x1
    80006b4c:	00500593          	li	a1,5
    80006b50:	00048513          	mv	a0,s1
    80006b54:	00e7b023          	sd	a4,0(a5)
    80006b58:	00000097          	auipc	ra,0x0
    80006b5c:	400080e7          	jalr	1024(ra) # 80006f58 <__memset>
    80006b60:	01813083          	ld	ra,24(sp)
    80006b64:	01013403          	ld	s0,16(sp)
    80006b68:	00048513          	mv	a0,s1
    80006b6c:	00813483          	ld	s1,8(sp)
    80006b70:	02010113          	addi	sp,sp,32
    80006b74:	00008067          	ret

0000000080006b78 <initlock>:
    80006b78:	ff010113          	addi	sp,sp,-16
    80006b7c:	00813423          	sd	s0,8(sp)
    80006b80:	01010413          	addi	s0,sp,16
    80006b84:	00813403          	ld	s0,8(sp)
    80006b88:	00b53423          	sd	a1,8(a0)
    80006b8c:	00052023          	sw	zero,0(a0)
    80006b90:	00053823          	sd	zero,16(a0)
    80006b94:	01010113          	addi	sp,sp,16
    80006b98:	00008067          	ret

0000000080006b9c <acquire>:
    80006b9c:	fe010113          	addi	sp,sp,-32
    80006ba0:	00813823          	sd	s0,16(sp)
    80006ba4:	00913423          	sd	s1,8(sp)
    80006ba8:	00113c23          	sd	ra,24(sp)
    80006bac:	01213023          	sd	s2,0(sp)
    80006bb0:	02010413          	addi	s0,sp,32
    80006bb4:	00050493          	mv	s1,a0
    80006bb8:	10002973          	csrr	s2,sstatus
    80006bbc:	100027f3          	csrr	a5,sstatus
    80006bc0:	ffd7f793          	andi	a5,a5,-3
    80006bc4:	10079073          	csrw	sstatus,a5
    80006bc8:	fffff097          	auipc	ra,0xfffff
    80006bcc:	8e0080e7          	jalr	-1824(ra) # 800054a8 <mycpu>
    80006bd0:	07852783          	lw	a5,120(a0)
    80006bd4:	06078e63          	beqz	a5,80006c50 <acquire+0xb4>
    80006bd8:	fffff097          	auipc	ra,0xfffff
    80006bdc:	8d0080e7          	jalr	-1840(ra) # 800054a8 <mycpu>
    80006be0:	07852783          	lw	a5,120(a0)
    80006be4:	0004a703          	lw	a4,0(s1)
    80006be8:	0017879b          	addiw	a5,a5,1
    80006bec:	06f52c23          	sw	a5,120(a0)
    80006bf0:	04071063          	bnez	a4,80006c30 <acquire+0x94>
    80006bf4:	00100713          	li	a4,1
    80006bf8:	00070793          	mv	a5,a4
    80006bfc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006c00:	0007879b          	sext.w	a5,a5
    80006c04:	fe079ae3          	bnez	a5,80006bf8 <acquire+0x5c>
    80006c08:	0ff0000f          	fence
    80006c0c:	fffff097          	auipc	ra,0xfffff
    80006c10:	89c080e7          	jalr	-1892(ra) # 800054a8 <mycpu>
    80006c14:	01813083          	ld	ra,24(sp)
    80006c18:	01013403          	ld	s0,16(sp)
    80006c1c:	00a4b823          	sd	a0,16(s1)
    80006c20:	00013903          	ld	s2,0(sp)
    80006c24:	00813483          	ld	s1,8(sp)
    80006c28:	02010113          	addi	sp,sp,32
    80006c2c:	00008067          	ret
    80006c30:	0104b903          	ld	s2,16(s1)
    80006c34:	fffff097          	auipc	ra,0xfffff
    80006c38:	874080e7          	jalr	-1932(ra) # 800054a8 <mycpu>
    80006c3c:	faa91ce3          	bne	s2,a0,80006bf4 <acquire+0x58>
    80006c40:	00002517          	auipc	a0,0x2
    80006c44:	87850513          	addi	a0,a0,-1928 # 800084b8 <digits+0x20>
    80006c48:	fffff097          	auipc	ra,0xfffff
    80006c4c:	224080e7          	jalr	548(ra) # 80005e6c <panic>
    80006c50:	00195913          	srli	s2,s2,0x1
    80006c54:	fffff097          	auipc	ra,0xfffff
    80006c58:	854080e7          	jalr	-1964(ra) # 800054a8 <mycpu>
    80006c5c:	00197913          	andi	s2,s2,1
    80006c60:	07252e23          	sw	s2,124(a0)
    80006c64:	f75ff06f          	j	80006bd8 <acquire+0x3c>

0000000080006c68 <release>:
    80006c68:	fe010113          	addi	sp,sp,-32
    80006c6c:	00813823          	sd	s0,16(sp)
    80006c70:	00113c23          	sd	ra,24(sp)
    80006c74:	00913423          	sd	s1,8(sp)
    80006c78:	01213023          	sd	s2,0(sp)
    80006c7c:	02010413          	addi	s0,sp,32
    80006c80:	00052783          	lw	a5,0(a0)
    80006c84:	00079a63          	bnez	a5,80006c98 <release+0x30>
    80006c88:	00002517          	auipc	a0,0x2
    80006c8c:	83850513          	addi	a0,a0,-1992 # 800084c0 <digits+0x28>
    80006c90:	fffff097          	auipc	ra,0xfffff
    80006c94:	1dc080e7          	jalr	476(ra) # 80005e6c <panic>
    80006c98:	01053903          	ld	s2,16(a0)
    80006c9c:	00050493          	mv	s1,a0
    80006ca0:	fffff097          	auipc	ra,0xfffff
    80006ca4:	808080e7          	jalr	-2040(ra) # 800054a8 <mycpu>
    80006ca8:	fea910e3          	bne	s2,a0,80006c88 <release+0x20>
    80006cac:	0004b823          	sd	zero,16(s1)
    80006cb0:	0ff0000f          	fence
    80006cb4:	0f50000f          	fence	iorw,ow
    80006cb8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006cbc:	ffffe097          	auipc	ra,0xffffe
    80006cc0:	7ec080e7          	jalr	2028(ra) # 800054a8 <mycpu>
    80006cc4:	100027f3          	csrr	a5,sstatus
    80006cc8:	0027f793          	andi	a5,a5,2
    80006ccc:	04079a63          	bnez	a5,80006d20 <release+0xb8>
    80006cd0:	07852783          	lw	a5,120(a0)
    80006cd4:	02f05e63          	blez	a5,80006d10 <release+0xa8>
    80006cd8:	fff7871b          	addiw	a4,a5,-1
    80006cdc:	06e52c23          	sw	a4,120(a0)
    80006ce0:	00071c63          	bnez	a4,80006cf8 <release+0x90>
    80006ce4:	07c52783          	lw	a5,124(a0)
    80006ce8:	00078863          	beqz	a5,80006cf8 <release+0x90>
    80006cec:	100027f3          	csrr	a5,sstatus
    80006cf0:	0027e793          	ori	a5,a5,2
    80006cf4:	10079073          	csrw	sstatus,a5
    80006cf8:	01813083          	ld	ra,24(sp)
    80006cfc:	01013403          	ld	s0,16(sp)
    80006d00:	00813483          	ld	s1,8(sp)
    80006d04:	00013903          	ld	s2,0(sp)
    80006d08:	02010113          	addi	sp,sp,32
    80006d0c:	00008067          	ret
    80006d10:	00001517          	auipc	a0,0x1
    80006d14:	7d050513          	addi	a0,a0,2000 # 800084e0 <digits+0x48>
    80006d18:	fffff097          	auipc	ra,0xfffff
    80006d1c:	154080e7          	jalr	340(ra) # 80005e6c <panic>
    80006d20:	00001517          	auipc	a0,0x1
    80006d24:	7a850513          	addi	a0,a0,1960 # 800084c8 <digits+0x30>
    80006d28:	fffff097          	auipc	ra,0xfffff
    80006d2c:	144080e7          	jalr	324(ra) # 80005e6c <panic>

0000000080006d30 <holding>:
    80006d30:	00052783          	lw	a5,0(a0)
    80006d34:	00079663          	bnez	a5,80006d40 <holding+0x10>
    80006d38:	00000513          	li	a0,0
    80006d3c:	00008067          	ret
    80006d40:	fe010113          	addi	sp,sp,-32
    80006d44:	00813823          	sd	s0,16(sp)
    80006d48:	00913423          	sd	s1,8(sp)
    80006d4c:	00113c23          	sd	ra,24(sp)
    80006d50:	02010413          	addi	s0,sp,32
    80006d54:	01053483          	ld	s1,16(a0)
    80006d58:	ffffe097          	auipc	ra,0xffffe
    80006d5c:	750080e7          	jalr	1872(ra) # 800054a8 <mycpu>
    80006d60:	01813083          	ld	ra,24(sp)
    80006d64:	01013403          	ld	s0,16(sp)
    80006d68:	40a48533          	sub	a0,s1,a0
    80006d6c:	00153513          	seqz	a0,a0
    80006d70:	00813483          	ld	s1,8(sp)
    80006d74:	02010113          	addi	sp,sp,32
    80006d78:	00008067          	ret

0000000080006d7c <push_off>:
    80006d7c:	fe010113          	addi	sp,sp,-32
    80006d80:	00813823          	sd	s0,16(sp)
    80006d84:	00113c23          	sd	ra,24(sp)
    80006d88:	00913423          	sd	s1,8(sp)
    80006d8c:	02010413          	addi	s0,sp,32
    80006d90:	100024f3          	csrr	s1,sstatus
    80006d94:	100027f3          	csrr	a5,sstatus
    80006d98:	ffd7f793          	andi	a5,a5,-3
    80006d9c:	10079073          	csrw	sstatus,a5
    80006da0:	ffffe097          	auipc	ra,0xffffe
    80006da4:	708080e7          	jalr	1800(ra) # 800054a8 <mycpu>
    80006da8:	07852783          	lw	a5,120(a0)
    80006dac:	02078663          	beqz	a5,80006dd8 <push_off+0x5c>
    80006db0:	ffffe097          	auipc	ra,0xffffe
    80006db4:	6f8080e7          	jalr	1784(ra) # 800054a8 <mycpu>
    80006db8:	07852783          	lw	a5,120(a0)
    80006dbc:	01813083          	ld	ra,24(sp)
    80006dc0:	01013403          	ld	s0,16(sp)
    80006dc4:	0017879b          	addiw	a5,a5,1
    80006dc8:	06f52c23          	sw	a5,120(a0)
    80006dcc:	00813483          	ld	s1,8(sp)
    80006dd0:	02010113          	addi	sp,sp,32
    80006dd4:	00008067          	ret
    80006dd8:	0014d493          	srli	s1,s1,0x1
    80006ddc:	ffffe097          	auipc	ra,0xffffe
    80006de0:	6cc080e7          	jalr	1740(ra) # 800054a8 <mycpu>
    80006de4:	0014f493          	andi	s1,s1,1
    80006de8:	06952e23          	sw	s1,124(a0)
    80006dec:	fc5ff06f          	j	80006db0 <push_off+0x34>

0000000080006df0 <pop_off>:
    80006df0:	ff010113          	addi	sp,sp,-16
    80006df4:	00813023          	sd	s0,0(sp)
    80006df8:	00113423          	sd	ra,8(sp)
    80006dfc:	01010413          	addi	s0,sp,16
    80006e00:	ffffe097          	auipc	ra,0xffffe
    80006e04:	6a8080e7          	jalr	1704(ra) # 800054a8 <mycpu>
    80006e08:	100027f3          	csrr	a5,sstatus
    80006e0c:	0027f793          	andi	a5,a5,2
    80006e10:	04079663          	bnez	a5,80006e5c <pop_off+0x6c>
    80006e14:	07852783          	lw	a5,120(a0)
    80006e18:	02f05a63          	blez	a5,80006e4c <pop_off+0x5c>
    80006e1c:	fff7871b          	addiw	a4,a5,-1
    80006e20:	06e52c23          	sw	a4,120(a0)
    80006e24:	00071c63          	bnez	a4,80006e3c <pop_off+0x4c>
    80006e28:	07c52783          	lw	a5,124(a0)
    80006e2c:	00078863          	beqz	a5,80006e3c <pop_off+0x4c>
    80006e30:	100027f3          	csrr	a5,sstatus
    80006e34:	0027e793          	ori	a5,a5,2
    80006e38:	10079073          	csrw	sstatus,a5
    80006e3c:	00813083          	ld	ra,8(sp)
    80006e40:	00013403          	ld	s0,0(sp)
    80006e44:	01010113          	addi	sp,sp,16
    80006e48:	00008067          	ret
    80006e4c:	00001517          	auipc	a0,0x1
    80006e50:	69450513          	addi	a0,a0,1684 # 800084e0 <digits+0x48>
    80006e54:	fffff097          	auipc	ra,0xfffff
    80006e58:	018080e7          	jalr	24(ra) # 80005e6c <panic>
    80006e5c:	00001517          	auipc	a0,0x1
    80006e60:	66c50513          	addi	a0,a0,1644 # 800084c8 <digits+0x30>
    80006e64:	fffff097          	auipc	ra,0xfffff
    80006e68:	008080e7          	jalr	8(ra) # 80005e6c <panic>

0000000080006e6c <push_on>:
    80006e6c:	fe010113          	addi	sp,sp,-32
    80006e70:	00813823          	sd	s0,16(sp)
    80006e74:	00113c23          	sd	ra,24(sp)
    80006e78:	00913423          	sd	s1,8(sp)
    80006e7c:	02010413          	addi	s0,sp,32
    80006e80:	100024f3          	csrr	s1,sstatus
    80006e84:	100027f3          	csrr	a5,sstatus
    80006e88:	0027e793          	ori	a5,a5,2
    80006e8c:	10079073          	csrw	sstatus,a5
    80006e90:	ffffe097          	auipc	ra,0xffffe
    80006e94:	618080e7          	jalr	1560(ra) # 800054a8 <mycpu>
    80006e98:	07852783          	lw	a5,120(a0)
    80006e9c:	02078663          	beqz	a5,80006ec8 <push_on+0x5c>
    80006ea0:	ffffe097          	auipc	ra,0xffffe
    80006ea4:	608080e7          	jalr	1544(ra) # 800054a8 <mycpu>
    80006ea8:	07852783          	lw	a5,120(a0)
    80006eac:	01813083          	ld	ra,24(sp)
    80006eb0:	01013403          	ld	s0,16(sp)
    80006eb4:	0017879b          	addiw	a5,a5,1
    80006eb8:	06f52c23          	sw	a5,120(a0)
    80006ebc:	00813483          	ld	s1,8(sp)
    80006ec0:	02010113          	addi	sp,sp,32
    80006ec4:	00008067          	ret
    80006ec8:	0014d493          	srli	s1,s1,0x1
    80006ecc:	ffffe097          	auipc	ra,0xffffe
    80006ed0:	5dc080e7          	jalr	1500(ra) # 800054a8 <mycpu>
    80006ed4:	0014f493          	andi	s1,s1,1
    80006ed8:	06952e23          	sw	s1,124(a0)
    80006edc:	fc5ff06f          	j	80006ea0 <push_on+0x34>

0000000080006ee0 <pop_on>:
    80006ee0:	ff010113          	addi	sp,sp,-16
    80006ee4:	00813023          	sd	s0,0(sp)
    80006ee8:	00113423          	sd	ra,8(sp)
    80006eec:	01010413          	addi	s0,sp,16
    80006ef0:	ffffe097          	auipc	ra,0xffffe
    80006ef4:	5b8080e7          	jalr	1464(ra) # 800054a8 <mycpu>
    80006ef8:	100027f3          	csrr	a5,sstatus
    80006efc:	0027f793          	andi	a5,a5,2
    80006f00:	04078463          	beqz	a5,80006f48 <pop_on+0x68>
    80006f04:	07852783          	lw	a5,120(a0)
    80006f08:	02f05863          	blez	a5,80006f38 <pop_on+0x58>
    80006f0c:	fff7879b          	addiw	a5,a5,-1
    80006f10:	06f52c23          	sw	a5,120(a0)
    80006f14:	07853783          	ld	a5,120(a0)
    80006f18:	00079863          	bnez	a5,80006f28 <pop_on+0x48>
    80006f1c:	100027f3          	csrr	a5,sstatus
    80006f20:	ffd7f793          	andi	a5,a5,-3
    80006f24:	10079073          	csrw	sstatus,a5
    80006f28:	00813083          	ld	ra,8(sp)
    80006f2c:	00013403          	ld	s0,0(sp)
    80006f30:	01010113          	addi	sp,sp,16
    80006f34:	00008067          	ret
    80006f38:	00001517          	auipc	a0,0x1
    80006f3c:	5d050513          	addi	a0,a0,1488 # 80008508 <digits+0x70>
    80006f40:	fffff097          	auipc	ra,0xfffff
    80006f44:	f2c080e7          	jalr	-212(ra) # 80005e6c <panic>
    80006f48:	00001517          	auipc	a0,0x1
    80006f4c:	5a050513          	addi	a0,a0,1440 # 800084e8 <digits+0x50>
    80006f50:	fffff097          	auipc	ra,0xfffff
    80006f54:	f1c080e7          	jalr	-228(ra) # 80005e6c <panic>

0000000080006f58 <__memset>:
    80006f58:	ff010113          	addi	sp,sp,-16
    80006f5c:	00813423          	sd	s0,8(sp)
    80006f60:	01010413          	addi	s0,sp,16
    80006f64:	1a060e63          	beqz	a2,80007120 <__memset+0x1c8>
    80006f68:	40a007b3          	neg	a5,a0
    80006f6c:	0077f793          	andi	a5,a5,7
    80006f70:	00778693          	addi	a3,a5,7
    80006f74:	00b00813          	li	a6,11
    80006f78:	0ff5f593          	andi	a1,a1,255
    80006f7c:	fff6071b          	addiw	a4,a2,-1
    80006f80:	1b06e663          	bltu	a3,a6,8000712c <__memset+0x1d4>
    80006f84:	1cd76463          	bltu	a4,a3,8000714c <__memset+0x1f4>
    80006f88:	1a078e63          	beqz	a5,80007144 <__memset+0x1ec>
    80006f8c:	00b50023          	sb	a1,0(a0)
    80006f90:	00100713          	li	a4,1
    80006f94:	1ae78463          	beq	a5,a4,8000713c <__memset+0x1e4>
    80006f98:	00b500a3          	sb	a1,1(a0)
    80006f9c:	00200713          	li	a4,2
    80006fa0:	1ae78a63          	beq	a5,a4,80007154 <__memset+0x1fc>
    80006fa4:	00b50123          	sb	a1,2(a0)
    80006fa8:	00300713          	li	a4,3
    80006fac:	18e78463          	beq	a5,a4,80007134 <__memset+0x1dc>
    80006fb0:	00b501a3          	sb	a1,3(a0)
    80006fb4:	00400713          	li	a4,4
    80006fb8:	1ae78263          	beq	a5,a4,8000715c <__memset+0x204>
    80006fbc:	00b50223          	sb	a1,4(a0)
    80006fc0:	00500713          	li	a4,5
    80006fc4:	1ae78063          	beq	a5,a4,80007164 <__memset+0x20c>
    80006fc8:	00b502a3          	sb	a1,5(a0)
    80006fcc:	00700713          	li	a4,7
    80006fd0:	18e79e63          	bne	a5,a4,8000716c <__memset+0x214>
    80006fd4:	00b50323          	sb	a1,6(a0)
    80006fd8:	00700e93          	li	t4,7
    80006fdc:	00859713          	slli	a4,a1,0x8
    80006fe0:	00e5e733          	or	a4,a1,a4
    80006fe4:	01059e13          	slli	t3,a1,0x10
    80006fe8:	01c76e33          	or	t3,a4,t3
    80006fec:	01859313          	slli	t1,a1,0x18
    80006ff0:	006e6333          	or	t1,t3,t1
    80006ff4:	02059893          	slli	a7,a1,0x20
    80006ff8:	40f60e3b          	subw	t3,a2,a5
    80006ffc:	011368b3          	or	a7,t1,a7
    80007000:	02859813          	slli	a6,a1,0x28
    80007004:	0108e833          	or	a6,a7,a6
    80007008:	03059693          	slli	a3,a1,0x30
    8000700c:	003e589b          	srliw	a7,t3,0x3
    80007010:	00d866b3          	or	a3,a6,a3
    80007014:	03859713          	slli	a4,a1,0x38
    80007018:	00389813          	slli	a6,a7,0x3
    8000701c:	00f507b3          	add	a5,a0,a5
    80007020:	00e6e733          	or	a4,a3,a4
    80007024:	000e089b          	sext.w	a7,t3
    80007028:	00f806b3          	add	a3,a6,a5
    8000702c:	00e7b023          	sd	a4,0(a5)
    80007030:	00878793          	addi	a5,a5,8
    80007034:	fed79ce3          	bne	a5,a3,8000702c <__memset+0xd4>
    80007038:	ff8e7793          	andi	a5,t3,-8
    8000703c:	0007871b          	sext.w	a4,a5
    80007040:	01d787bb          	addw	a5,a5,t4
    80007044:	0ce88e63          	beq	a7,a4,80007120 <__memset+0x1c8>
    80007048:	00f50733          	add	a4,a0,a5
    8000704c:	00b70023          	sb	a1,0(a4)
    80007050:	0017871b          	addiw	a4,a5,1
    80007054:	0cc77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007058:	00e50733          	add	a4,a0,a4
    8000705c:	00b70023          	sb	a1,0(a4)
    80007060:	0027871b          	addiw	a4,a5,2
    80007064:	0ac77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007068:	00e50733          	add	a4,a0,a4
    8000706c:	00b70023          	sb	a1,0(a4)
    80007070:	0037871b          	addiw	a4,a5,3
    80007074:	0ac77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007078:	00e50733          	add	a4,a0,a4
    8000707c:	00b70023          	sb	a1,0(a4)
    80007080:	0047871b          	addiw	a4,a5,4
    80007084:	08c77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007088:	00e50733          	add	a4,a0,a4
    8000708c:	00b70023          	sb	a1,0(a4)
    80007090:	0057871b          	addiw	a4,a5,5
    80007094:	08c77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007098:	00e50733          	add	a4,a0,a4
    8000709c:	00b70023          	sb	a1,0(a4)
    800070a0:	0067871b          	addiw	a4,a5,6
    800070a4:	06c77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070a8:	00e50733          	add	a4,a0,a4
    800070ac:	00b70023          	sb	a1,0(a4)
    800070b0:	0077871b          	addiw	a4,a5,7
    800070b4:	06c77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070b8:	00e50733          	add	a4,a0,a4
    800070bc:	00b70023          	sb	a1,0(a4)
    800070c0:	0087871b          	addiw	a4,a5,8
    800070c4:	04c77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070c8:	00e50733          	add	a4,a0,a4
    800070cc:	00b70023          	sb	a1,0(a4)
    800070d0:	0097871b          	addiw	a4,a5,9
    800070d4:	04c77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070d8:	00e50733          	add	a4,a0,a4
    800070dc:	00b70023          	sb	a1,0(a4)
    800070e0:	00a7871b          	addiw	a4,a5,10
    800070e4:	02c77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070e8:	00e50733          	add	a4,a0,a4
    800070ec:	00b70023          	sb	a1,0(a4)
    800070f0:	00b7871b          	addiw	a4,a5,11
    800070f4:	02c77663          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    800070f8:	00e50733          	add	a4,a0,a4
    800070fc:	00b70023          	sb	a1,0(a4)
    80007100:	00c7871b          	addiw	a4,a5,12
    80007104:	00c77e63          	bgeu	a4,a2,80007120 <__memset+0x1c8>
    80007108:	00e50733          	add	a4,a0,a4
    8000710c:	00b70023          	sb	a1,0(a4)
    80007110:	00d7879b          	addiw	a5,a5,13
    80007114:	00c7f663          	bgeu	a5,a2,80007120 <__memset+0x1c8>
    80007118:	00f507b3          	add	a5,a0,a5
    8000711c:	00b78023          	sb	a1,0(a5)
    80007120:	00813403          	ld	s0,8(sp)
    80007124:	01010113          	addi	sp,sp,16
    80007128:	00008067          	ret
    8000712c:	00b00693          	li	a3,11
    80007130:	e55ff06f          	j	80006f84 <__memset+0x2c>
    80007134:	00300e93          	li	t4,3
    80007138:	ea5ff06f          	j	80006fdc <__memset+0x84>
    8000713c:	00100e93          	li	t4,1
    80007140:	e9dff06f          	j	80006fdc <__memset+0x84>
    80007144:	00000e93          	li	t4,0
    80007148:	e95ff06f          	j	80006fdc <__memset+0x84>
    8000714c:	00000793          	li	a5,0
    80007150:	ef9ff06f          	j	80007048 <__memset+0xf0>
    80007154:	00200e93          	li	t4,2
    80007158:	e85ff06f          	j	80006fdc <__memset+0x84>
    8000715c:	00400e93          	li	t4,4
    80007160:	e7dff06f          	j	80006fdc <__memset+0x84>
    80007164:	00500e93          	li	t4,5
    80007168:	e75ff06f          	j	80006fdc <__memset+0x84>
    8000716c:	00600e93          	li	t4,6
    80007170:	e6dff06f          	j	80006fdc <__memset+0x84>

0000000080007174 <__memmove>:
    80007174:	ff010113          	addi	sp,sp,-16
    80007178:	00813423          	sd	s0,8(sp)
    8000717c:	01010413          	addi	s0,sp,16
    80007180:	0e060863          	beqz	a2,80007270 <__memmove+0xfc>
    80007184:	fff6069b          	addiw	a3,a2,-1
    80007188:	0006881b          	sext.w	a6,a3
    8000718c:	0ea5e863          	bltu	a1,a0,8000727c <__memmove+0x108>
    80007190:	00758713          	addi	a4,a1,7
    80007194:	00a5e7b3          	or	a5,a1,a0
    80007198:	40a70733          	sub	a4,a4,a0
    8000719c:	0077f793          	andi	a5,a5,7
    800071a0:	00f73713          	sltiu	a4,a4,15
    800071a4:	00174713          	xori	a4,a4,1
    800071a8:	0017b793          	seqz	a5,a5
    800071ac:	00e7f7b3          	and	a5,a5,a4
    800071b0:	10078863          	beqz	a5,800072c0 <__memmove+0x14c>
    800071b4:	00900793          	li	a5,9
    800071b8:	1107f463          	bgeu	a5,a6,800072c0 <__memmove+0x14c>
    800071bc:	0036581b          	srliw	a6,a2,0x3
    800071c0:	fff8081b          	addiw	a6,a6,-1
    800071c4:	02081813          	slli	a6,a6,0x20
    800071c8:	01d85893          	srli	a7,a6,0x1d
    800071cc:	00858813          	addi	a6,a1,8
    800071d0:	00058793          	mv	a5,a1
    800071d4:	00050713          	mv	a4,a0
    800071d8:	01088833          	add	a6,a7,a6
    800071dc:	0007b883          	ld	a7,0(a5)
    800071e0:	00878793          	addi	a5,a5,8
    800071e4:	00870713          	addi	a4,a4,8
    800071e8:	ff173c23          	sd	a7,-8(a4)
    800071ec:	ff0798e3          	bne	a5,a6,800071dc <__memmove+0x68>
    800071f0:	ff867713          	andi	a4,a2,-8
    800071f4:	02071793          	slli	a5,a4,0x20
    800071f8:	0207d793          	srli	a5,a5,0x20
    800071fc:	00f585b3          	add	a1,a1,a5
    80007200:	40e686bb          	subw	a3,a3,a4
    80007204:	00f507b3          	add	a5,a0,a5
    80007208:	06e60463          	beq	a2,a4,80007270 <__memmove+0xfc>
    8000720c:	0005c703          	lbu	a4,0(a1)
    80007210:	00e78023          	sb	a4,0(a5)
    80007214:	04068e63          	beqz	a3,80007270 <__memmove+0xfc>
    80007218:	0015c603          	lbu	a2,1(a1)
    8000721c:	00100713          	li	a4,1
    80007220:	00c780a3          	sb	a2,1(a5)
    80007224:	04e68663          	beq	a3,a4,80007270 <__memmove+0xfc>
    80007228:	0025c603          	lbu	a2,2(a1)
    8000722c:	00200713          	li	a4,2
    80007230:	00c78123          	sb	a2,2(a5)
    80007234:	02e68e63          	beq	a3,a4,80007270 <__memmove+0xfc>
    80007238:	0035c603          	lbu	a2,3(a1)
    8000723c:	00300713          	li	a4,3
    80007240:	00c781a3          	sb	a2,3(a5)
    80007244:	02e68663          	beq	a3,a4,80007270 <__memmove+0xfc>
    80007248:	0045c603          	lbu	a2,4(a1)
    8000724c:	00400713          	li	a4,4
    80007250:	00c78223          	sb	a2,4(a5)
    80007254:	00e68e63          	beq	a3,a4,80007270 <__memmove+0xfc>
    80007258:	0055c603          	lbu	a2,5(a1)
    8000725c:	00500713          	li	a4,5
    80007260:	00c782a3          	sb	a2,5(a5)
    80007264:	00e68663          	beq	a3,a4,80007270 <__memmove+0xfc>
    80007268:	0065c703          	lbu	a4,6(a1)
    8000726c:	00e78323          	sb	a4,6(a5)
    80007270:	00813403          	ld	s0,8(sp)
    80007274:	01010113          	addi	sp,sp,16
    80007278:	00008067          	ret
    8000727c:	02061713          	slli	a4,a2,0x20
    80007280:	02075713          	srli	a4,a4,0x20
    80007284:	00e587b3          	add	a5,a1,a4
    80007288:	f0f574e3          	bgeu	a0,a5,80007190 <__memmove+0x1c>
    8000728c:	02069613          	slli	a2,a3,0x20
    80007290:	02065613          	srli	a2,a2,0x20
    80007294:	fff64613          	not	a2,a2
    80007298:	00e50733          	add	a4,a0,a4
    8000729c:	00c78633          	add	a2,a5,a2
    800072a0:	fff7c683          	lbu	a3,-1(a5)
    800072a4:	fff78793          	addi	a5,a5,-1
    800072a8:	fff70713          	addi	a4,a4,-1
    800072ac:	00d70023          	sb	a3,0(a4)
    800072b0:	fec798e3          	bne	a5,a2,800072a0 <__memmove+0x12c>
    800072b4:	00813403          	ld	s0,8(sp)
    800072b8:	01010113          	addi	sp,sp,16
    800072bc:	00008067          	ret
    800072c0:	02069713          	slli	a4,a3,0x20
    800072c4:	02075713          	srli	a4,a4,0x20
    800072c8:	00170713          	addi	a4,a4,1
    800072cc:	00e50733          	add	a4,a0,a4
    800072d0:	00050793          	mv	a5,a0
    800072d4:	0005c683          	lbu	a3,0(a1)
    800072d8:	00178793          	addi	a5,a5,1
    800072dc:	00158593          	addi	a1,a1,1
    800072e0:	fed78fa3          	sb	a3,-1(a5)
    800072e4:	fee798e3          	bne	a5,a4,800072d4 <__memmove+0x160>
    800072e8:	f89ff06f          	j	80007270 <__memmove+0xfc>
	...
