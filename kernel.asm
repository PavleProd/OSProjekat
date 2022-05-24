
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	c5813103          	ld	sp,-936(sp) # 80005c58 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	644020ef          	jal	ra,80002660 <start>

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
    8000100c:	211000ef          	jal	ra,80001a1c <_ZN3PCB10getContextEv>
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
    8000109c:	3bc000ef          	jal	ra,80001458 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	17d000ef          	jal	ra,80001a1c <_ZN3PCB10getContextEv>

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

0000000080001150 <_Z13callInterruptm>:
#include "../h/PCB.h"
#include "../h/console.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt(size_t volatile code) {
    80001150:	fe010113          	addi	sp,sp,-32
    80001154:	00813c23          	sd	s0,24(sp)
    80001158:	02010413          	addi	s0,sp,32
    8000115c:	fea43423          	sd	a0,-24(s0)
    void* res;
    asm volatile("ecall");
    80001160:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001164:	00050513          	mv	a0,a0
    return res;
}
    80001168:	01813403          	ld	s0,24(sp)
    8000116c:	02010113          	addi	sp,sp,32
    80001170:	00008067          	ret

0000000080001174 <_Z9mem_allocm>:

// a0 code a1 size
void* mem_alloc(size_t size) {
    80001174:	ff010113          	addi	sp,sp,-16
    80001178:	00113423          	sd	ra,8(sp)
    8000117c:	00813023          	sd	s0,0(sp)
    80001180:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001184:	00655793          	srli	a5,a0,0x6
    80001188:	03f57513          	andi	a0,a0,63
    8000118c:	00a03533          	snez	a0,a0
    80001190:	00a78533          	add	a0,a5,a0
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    80001194:	00050593          	mv	a1,a0

    return (void*)callInterrupt(code);
    80001198:	00100513          	li	a0,1
    8000119c:	00000097          	auipc	ra,0x0
    800011a0:	fb4080e7          	jalr	-76(ra) # 80001150 <_Z13callInterruptm>
}
    800011a4:	00813083          	ld	ra,8(sp)
    800011a8:	00013403          	ld	s0,0(sp)
    800011ac:	01010113          	addi	sp,sp,16
    800011b0:	00008067          	ret

00000000800011b4 <_Z8mem_freePv>:

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    800011b4:	ff010113          	addi	sp,sp,-16
    800011b8:	00113423          	sd	ra,8(sp)
    800011bc:	00813023          	sd	s0,0(sp)
    800011c0:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    800011c4:	00050593          	mv	a1,a0

    return (size_t)(callInterrupt(code));
    800011c8:	00200513          	li	a0,2
    800011cc:	00000097          	auipc	ra,0x0
    800011d0:	f84080e7          	jalr	-124(ra) # 80001150 <_Z13callInterruptm>
}
    800011d4:	0005051b          	sext.w	a0,a0
    800011d8:	00813083          	ld	ra,8(sp)
    800011dc:	00013403          	ld	s0,0(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret

00000000800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create_only (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800011e8:	ff010113          	addi	sp,sp,-16
    800011ec:	00113423          	sd	ra,8(sp)
    800011f0:	00813023          	sd	s0,0(sp)
    800011f4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    800011f8:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    800011fc:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
    80001200:	00050713          	mv	a4,a0

    size_t* stack = (size_t*)mem_alloc(sizeof(size_t)*DEFAULT_STACK_SIZE); // pravimo stack procesa
    80001204:	00008537          	lui	a0,0x8
    80001208:	00000097          	auipc	ra,0x0
    8000120c:	f6c080e7          	jalr	-148(ra) # 80001174 <_Z9mem_allocm>
    if(stack == nullptr) return -1;
    80001210:	02050a63          	beqz	a0,80001244 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x5c>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    80001214:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001218:	00050713          	mv	a4,a0

    handle = (thread_t*)(callInterrupt(code)); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    8000121c:	01100513          	li	a0,17
    80001220:	00000097          	auipc	ra,0x0
    80001224:	f30080e7          	jalr	-208(ra) # 80001150 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001228:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    8000122c:	02078063          	beqz	a5,8000124c <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x64>
        return -1;
    }
    return 0;
    80001230:	00000513          	li	a0,0
}
    80001234:	00813083          	ld	ra,8(sp)
    80001238:	00013403          	ld	s0,0(sp)
    8000123c:	01010113          	addi	sp,sp,16
    80001240:	00008067          	ret
    if(stack == nullptr) return -1;
    80001244:	fff00513          	li	a0,-1
    80001248:	fedff06f          	j	80001234 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>
        return -1;
    8000124c:	fff00513          	li	a0,-1
    80001250:	fe5ff06f          	j	80001234 <_Z18thread_create_onlyPP3PCBPFvPvES2_+0x4c>

0000000080001254 <_Z15thread_dispatchv>:
    int res = thread_create_only(handle, startRoutine, arg);
    thread_start(handle);
    return res;
}

void thread_dispatch () {
    80001254:	ff010113          	addi	sp,sp,-16
    80001258:	00113423          	sd	ra,8(sp)
    8000125c:	00813023          	sd	s0,0(sp)
    80001260:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    callInterrupt(code);
    80001264:	01300513          	li	a0,19
    80001268:	00000097          	auipc	ra,0x0
    8000126c:	ee8080e7          	jalr	-280(ra) # 80001150 <_Z13callInterruptm>
}
    80001270:	00813083          	ld	ra,8(sp)
    80001274:	00013403          	ld	s0,0(sp)
    80001278:	01010113          	addi	sp,sp,16
    8000127c:	00008067          	ret

0000000080001280 <_Z11thread_exitv>:

int thread_exit () {
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00113423          	sd	ra,8(sp)
    80001288:	00813023          	sd	s0,0(sp)
    8000128c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_exit;
    return (size_t)(callInterrupt(code));
    80001290:	01200513          	li	a0,18
    80001294:	00000097          	auipc	ra,0x0
    80001298:	ebc080e7          	jalr	-324(ra) # 80001150 <_Z13callInterruptm>
}
    8000129c:	0005051b          	sext.w	a0,a0
    800012a0:	00813083          	ld	ra,8(sp)
    800012a4:	00013403          	ld	s0,0(sp)
    800012a8:	01010113          	addi	sp,sp,16
    800012ac:	00008067          	ret

00000000800012b0 <_Z12thread_startPP3PCB>:

void thread_start(thread_t* handle) {
    800012b0:	ff010113          	addi	sp,sp,-16
    800012b4:	00113423          	sd	ra,8(sp)
    800012b8:	00813023          	sd	s0,0(sp)
    800012bc:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_start;
    asm volatile("mv a1, a0"); // a1 = handle
    800012c0:	00050593          	mv	a1,a0
    callInterrupt(code);
    800012c4:	01400513          	li	a0,20
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	e88080e7          	jalr	-376(ra) # 80001150 <_Z13callInterruptm>
}
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_Z13thread_createPP3PCBPFvPvES2_>:
int thread_create(thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800012e0:	fe010113          	addi	sp,sp,-32
    800012e4:	00113c23          	sd	ra,24(sp)
    800012e8:	00813823          	sd	s0,16(sp)
    800012ec:	00913423          	sd	s1,8(sp)
    800012f0:	01213023          	sd	s2,0(sp)
    800012f4:	02010413          	addi	s0,sp,32
    800012f8:	00050913          	mv	s2,a0
    int res = thread_create_only(handle, startRoutine, arg);
    800012fc:	00000097          	auipc	ra,0x0
    80001300:	eec080e7          	jalr	-276(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    80001304:	00050493          	mv	s1,a0
    thread_start(handle);
    80001308:	00090513          	mv	a0,s2
    8000130c:	00000097          	auipc	ra,0x0
    80001310:	fa4080e7          	jalr	-92(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    80001314:	00048513          	mv	a0,s1
    80001318:	01813083          	ld	ra,24(sp)
    8000131c:	01013403          	ld	s0,16(sp)
    80001320:	00813483          	ld	s1,8(sp)
    80001324:	00013903          	ld	s2,0(sp)
    80001328:	02010113          	addi	sp,sp,32
    8000132c:	00008067          	ret

0000000080001330 <_Z8sem_openPP3SCBj>:

int sem_open (sem_t* handle, unsigned init) {
    80001330:	ff010113          	addi	sp,sp,-16
    80001334:	00113423          	sd	ra,8(sp)
    80001338:	00813023          	sd	s0,0(sp)
    8000133c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::sem_open;

    asm volatile("mv a2, a1"); // a2 = init
    80001340:	00058613          	mv	a2,a1
    asm volatile("mv a1, a0"); // a1 = handle
    80001344:	00050593          	mv	a1,a0

    handle = (sem_t*)callInterrupt(code);
    80001348:	02100513          	li	a0,33
    8000134c:	00000097          	auipc	ra,0x0
    80001350:	e04080e7          	jalr	-508(ra) # 80001150 <_Z13callInterruptm>
    if(*handle == nullptr) {
    80001354:	00053783          	ld	a5,0(a0)
    80001358:	00078c63          	beqz	a5,80001370 <_Z8sem_openPP3SCBj+0x40>
        return -1;
    }

    return 0;
    8000135c:	00000513          	li	a0,0
}
    80001360:	00813083          	ld	ra,8(sp)
    80001364:	00013403          	ld	s0,0(sp)
    80001368:	01010113          	addi	sp,sp,16
    8000136c:	00008067          	ret
        return -1;
    80001370:	fff00513          	li	a0,-1
    80001374:	fedff06f          	j	80001360 <_Z8sem_openPP3SCBj+0x30>

0000000080001378 <_Z8sem_waitP3SCB>:

int sem_wait (sem_t volatile id) {
    80001378:	fe010113          	addi	sp,sp,-32
    8000137c:	00113c23          	sd	ra,24(sp)
    80001380:	00813823          	sd	s0,16(sp)
    80001384:	02010413          	addi	s0,sp,32
    80001388:	fea43423          	sd	a0,-24(s0)
    size_t code = Kernel::sysCallCodes::sem_wait;
    if(id == nullptr) return -1;
    8000138c:	fe843783          	ld	a5,-24(s0)
    80001390:	02078e63          	beqz	a5,800013cc <_Z8sem_waitP3SCB+0x54>
    asm volatile("mv a1, a0");
    80001394:	00050593          	mv	a1,a0

    if(callInterrupt(code)) {
    80001398:	02300513          	li	a0,35
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	db4080e7          	jalr	-588(ra) # 80001150 <_Z13callInterruptm>
    800013a4:	00050663          	beqz	a0,800013b0 <_Z8sem_waitP3SCB+0x38>
        thread_dispatch();
    800013a8:	00000097          	auipc	ra,0x0
    800013ac:	eac080e7          	jalr	-340(ra) # 80001254 <_Z15thread_dispatchv>
    }

    if(id == nullptr) return -2; // ?
    800013b0:	fe843783          	ld	a5,-24(s0)
    800013b4:	02078063          	beqz	a5,800013d4 <_Z8sem_waitP3SCB+0x5c>

    return 0;
    800013b8:	00000513          	li	a0,0
}
    800013bc:	01813083          	ld	ra,24(sp)
    800013c0:	01013403          	ld	s0,16(sp)
    800013c4:	02010113          	addi	sp,sp,32
    800013c8:	00008067          	ret
    if(id == nullptr) return -1;
    800013cc:	fff00513          	li	a0,-1
    800013d0:	fedff06f          	j	800013bc <_Z8sem_waitP3SCB+0x44>
    if(id == nullptr) return -2; // ?
    800013d4:	ffe00513          	li	a0,-2
    800013d8:	fe5ff06f          	j	800013bc <_Z8sem_waitP3SCB+0x44>

00000000800013dc <_Z10sem_signalP3SCB>:

int sem_signal (sem_t id) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(id == nullptr) return -1;
    800013dc:	04050663          	beqz	a0,80001428 <_Z10sem_signalP3SCB+0x4c>
int sem_signal (sem_t id) {
    800013e0:	fe010113          	addi	sp,sp,-32
    800013e4:	00113c23          	sd	ra,24(sp)
    800013e8:	00813823          	sd	s0,16(sp)
    800013ec:	02010413          	addi	s0,sp,32
    asm volatile("mv a1, a0");
    800013f0:	00050593          	mv	a1,a0

    PCB* process = (PCB*)callInterrupt(code);
    800013f4:	02400513          	li	a0,36
    800013f8:	00000097          	auipc	ra,0x0
    800013fc:	d58080e7          	jalr	-680(ra) # 80001150 <_Z13callInterruptm>
    80001400:	fea43423          	sd	a0,-24(s0)
    if(process) {
    80001404:	02050663          	beqz	a0,80001430 <_Z10sem_signalP3SCB+0x54>
        thread_start(&process);
    80001408:	fe840513          	addi	a0,s0,-24
    8000140c:	00000097          	auipc	ra,0x0
    80001410:	ea4080e7          	jalr	-348(ra) # 800012b0 <_Z12thread_startPP3PCB>
    }

    return 0;
    80001414:	00000513          	li	a0,0
}
    80001418:	01813083          	ld	ra,24(sp)
    8000141c:	01013403          	ld	s0,16(sp)
    80001420:	02010113          	addi	sp,sp,32
    80001424:	00008067          	ret
    if(id == nullptr) return -1;
    80001428:	fff00513          	li	a0,-1
}
    8000142c:	00008067          	ret
    return 0;
    80001430:	00000513          	li	a0,0
    80001434:	fe5ff06f          	j	80001418 <_Z10sem_signalP3SCB+0x3c>

0000000080001438 <_ZN6Kernel10popSppSpieEv>:
#include "../h/console.h"
#include "../h/print.h"
#include "../h/Scheduler.h"
#include "../h/SCB.h"

void Kernel::popSppSpie() {
    80001438:	ff010113          	addi	sp,sp,-16
    8000143c:	00813423          	sd	s0,8(sp)
    80001440:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001444:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001448:	10200073          	sret
}
    8000144c:	00813403          	ld	s0,8(sp)
    80001450:	01010113          	addi	sp,sp,16
    80001454:	00008067          	ret

0000000080001458 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001458:	fa010113          	addi	sp,sp,-96
    8000145c:	04113c23          	sd	ra,88(sp)
    80001460:	04813823          	sd	s0,80(sp)
    80001464:	04913423          	sd	s1,72(sp)
    80001468:	05213023          	sd	s2,64(sp)
    8000146c:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001470:	142027f3          	csrr	a5,scause
    80001474:	fcf43023          	sd	a5,-64(s0)
        return scause;
    80001478:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    8000147c:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001480:	141027f3          	csrr	a5,sepc
    80001484:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    80001488:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    8000148c:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001490:	100027f3          	csrr	a5,sstatus
    80001494:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    80001498:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    8000149c:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800014a0:	fd843703          	ld	a4,-40(s0)
    800014a4:	00900793          	li	a5,9
    800014a8:	04f70263          	beq	a4,a5,800014ec <interruptHandler+0x94>
    800014ac:	fd843703          	ld	a4,-40(s0)
    800014b0:	00800793          	li	a5,8
    800014b4:	02f70c63          	beq	a4,a5,800014ec <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800014b8:	fd843703          	ld	a4,-40(s0)
    800014bc:	fff00793          	li	a5,-1
    800014c0:	03f79793          	slli	a5,a5,0x3f
    800014c4:	00178793          	addi	a5,a5,1
    800014c8:	22f70463          	beq	a4,a5,800016f0 <interruptHandler+0x298>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800014cc:	fd843703          	ld	a4,-40(s0)
    800014d0:	fff00793          	li	a5,-1
    800014d4:	03f79793          	slli	a5,a5,0x3f
    800014d8:	00978793          	addi	a5,a5,9
    800014dc:	26f70863          	beq	a4,a5,8000174c <interruptHandler+0x2f4>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    800014e0:	00001097          	auipc	ra,0x1
    800014e4:	0c8080e7          	jalr	200(ra) # 800025a8 <_Z10printErrorv>
    800014e8:	0840006f          	j	8000156c <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    800014ec:	fd043783          	ld	a5,-48(s0)
    800014f0:	00478793          	addi	a5,a5,4
    800014f4:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800014f8:	00004797          	auipc	a5,0x4
    800014fc:	7687b783          	ld	a5,1896(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001500:	0007b683          	ld	a3,0(a5)
    80001504:	0186b703          	ld	a4,24(a3)
    80001508:	05073783          	ld	a5,80(a4)
    8000150c:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    80001510:	fa843783          	ld	a5,-88(s0)
    80001514:	02400613          	li	a2,36
    80001518:	1cf66663          	bltu	a2,a5,800016e4 <interruptHandler+0x28c>
    8000151c:	00279793          	slli	a5,a5,0x2
    80001520:	00004617          	auipc	a2,0x4
    80001524:	b0060613          	addi	a2,a2,-1280 # 80005020 <CONSOLE_STATUS+0x10>
    80001528:	00c787b3          	add	a5,a5,a2
    8000152c:	0007a783          	lw	a5,0(a5)
    80001530:	00c787b3          	add	a5,a5,a2
    80001534:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001538:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    8000153c:	00651513          	slli	a0,a0,0x6
    80001540:	00001097          	auipc	ra,0x1
    80001544:	c2c080e7          	jalr	-980(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
    80001548:	00004797          	auipc	a5,0x4
    8000154c:	7187b783          	ld	a5,1816(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001550:	0007b783          	ld	a5,0(a5)
    80001554:	0187b783          	ld	a5,24(a5)
    80001558:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    8000155c:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001560:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001564:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001568:	10079073          	csrw	sstatus,a5
    }

}
    8000156c:	05813083          	ld	ra,88(sp)
    80001570:	05013403          	ld	s0,80(sp)
    80001574:	04813483          	ld	s1,72(sp)
    80001578:	04013903          	ld	s2,64(sp)
    8000157c:	06010113          	addi	sp,sp,96
    80001580:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001584:	05873503          	ld	a0,88(a4)
    80001588:	00001097          	auipc	ra,0x1
    8000158c:	d48080e7          	jalr	-696(ra) # 800022d0 <_ZN15MemoryAllocator8mem_freeEPv>
    80001590:	00004797          	auipc	a5,0x4
    80001594:	6d07b783          	ld	a5,1744(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001598:	0007b783          	ld	a5,0(a5)
    8000159c:	0187b783          	ld	a5,24(a5)
    800015a0:	04a7b823          	sd	a0,80(a5)
                break;
    800015a4:	fb9ff06f          	j	8000155c <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    800015a8:	00004797          	auipc	a5,0x4
    800015ac:	6a87b783          	ld	a5,1704(a5) # 80005c50 <_GLOBAL_OFFSET_TABLE_+0x10>
    800015b0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800015b4:	00000097          	auipc	ra,0x0
    800015b8:	210080e7          	jalr	528(ra) # 800017c4 <_ZN3PCB8dispatchEv>
                break;
    800015bc:	fa1ff06f          	j	8000155c <interruptHandler+0x104>
                PCB::running->finished = true;
    800015c0:	00100793          	li	a5,1
    800015c4:	02f68423          	sb	a5,40(a3)
                PCB::timeSliceCounter = 0;
    800015c8:	00004797          	auipc	a5,0x4
    800015cc:	6887b783          	ld	a5,1672(a5) # 80005c50 <_GLOBAL_OFFSET_TABLE_+0x10>
    800015d0:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    800015d4:	00000097          	auipc	ra,0x0
    800015d8:	1f0080e7          	jalr	496(ra) # 800017c4 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    800015dc:	00004797          	auipc	a5,0x4
    800015e0:	6847b783          	ld	a5,1668(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    800015e4:	0007b783          	ld	a5,0(a5)
    800015e8:	0187b783          	ld	a5,24(a5)
    800015ec:	0407b823          	sd	zero,80(a5)
                break;
    800015f0:	f6dff06f          	j	8000155c <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    800015f4:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800015f8:	0007b503          	ld	a0,0(a5)
    800015fc:	00000097          	auipc	ra,0x0
    80001600:	444080e7          	jalr	1092(ra) # 80001a40 <_ZN9Scheduler3putEP3PCB>
                break;
    80001604:	f59ff06f          	j	8000155c <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    80001608:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    8000160c:	06873583          	ld	a1,104(a4)
    80001610:	06073503          	ld	a0,96(a4)
    80001614:	00000097          	auipc	ra,0x0
    80001618:	380080e7          	jalr	896(ra) # 80001994 <_ZN3PCB14createProccessEPFvvEPv>
    8000161c:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001620:	00004797          	auipc	a5,0x4
    80001624:	6407b783          	ld	a5,1600(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001628:	0007b783          	ld	a5,0(a5)
    8000162c:	0187b703          	ld	a4,24(a5)
    80001630:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001634:	0004b703          	ld	a4,0(s1)
    80001638:	f20702e3          	beqz	a4,8000155c <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    8000163c:	0187b783          	ld	a5,24(a5)
    80001640:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001644:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001648:	00008737          	lui	a4,0x8
    8000164c:	00e787b3          	add	a5,a5,a4
    80001650:	0004b703          	ld	a4,0(s1)
    80001654:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001658:	00f73823          	sd	a5,16(a4)
                break;
    8000165c:	f01ff06f          	j	8000155c <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001660:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    80001664:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    80001668:	01800513          	li	a0,24
    8000166c:	00001097          	auipc	ra,0x1
    80001670:	ab0080e7          	jalr	-1360(ra) # 8000211c <_ZN3SCBnwEm>
    }
private:
    SCB(int semValue_ = 1) {
    80001674:	00053023          	sd	zero,0(a0)
    80001678:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    8000167c:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001680:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001684:	00004797          	auipc	a5,0x4
    80001688:	5dc7b783          	ld	a5,1500(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000168c:	0007b783          	ld	a5,0(a5)
    80001690:	0187b783          	ld	a5,24(a5)
    80001694:	0497b823          	sd	s1,80(a5)
                break;
    80001698:	ec5ff06f          	j	8000155c <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // true kao proces treba da se blokira, false ako ne
    8000169c:	05873503          	ld	a0,88(a4)
    800016a0:	00001097          	auipc	ra,0x1
    800016a4:	9f0080e7          	jalr	-1552(ra) # 80002090 <_ZN3SCB4waitEv>
    800016a8:	00004797          	auipc	a5,0x4
    800016ac:	5b87b783          	ld	a5,1464(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    800016b0:	0007b783          	ld	a5,0(a5)
    800016b4:	0187b783          	ld	a5,24(a5)
    800016b8:	04a7b823          	sd	a0,80(a5)
                break;
    800016bc:	ea1ff06f          	j	8000155c <interruptHandler+0x104>
                PCB::running->registers[10] = (size_t)sem->signal(); // vraca pokazivac na PCB ako ga treba staviti u Scheduler
    800016c0:	05873503          	ld	a0,88(a4)
    800016c4:	00001097          	auipc	ra,0x1
    800016c8:	a14080e7          	jalr	-1516(ra) # 800020d8 <_ZN3SCB6signalEv>
    800016cc:	00004797          	auipc	a5,0x4
    800016d0:	5947b783          	ld	a5,1428(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    800016d4:	0007b783          	ld	a5,0(a5)
    800016d8:	0187b783          	ld	a5,24(a5)
    800016dc:	04a7b823          	sd	a0,80(a5)
                break;
    800016e0:	e7dff06f          	j	8000155c <interruptHandler+0x104>
                printError();
    800016e4:	00001097          	auipc	ra,0x1
    800016e8:	ec4080e7          	jalr	-316(ra) # 800025a8 <_Z10printErrorv>
                break;
    800016ec:	e71ff06f          	j	8000155c <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800016f0:	00004717          	auipc	a4,0x4
    800016f4:	56073703          	ld	a4,1376(a4) # 80005c50 <_GLOBAL_OFFSET_TABLE_+0x10>
    800016f8:	00073783          	ld	a5,0(a4)
    800016fc:	00178793          	addi	a5,a5,1
    80001700:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001704:	00004717          	auipc	a4,0x4
    80001708:	55c73703          	ld	a4,1372(a4) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000170c:	00073703          	ld	a4,0(a4)
    80001710:	03873703          	ld	a4,56(a4)
    80001714:	00e7f863          	bgeu	a5,a4,80001724 <interruptHandler+0x2cc>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001718:	00200793          	li	a5,2
    8000171c:	1447b073          	csrc	sip,a5
    }
    80001720:	e4dff06f          	j	8000156c <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    80001724:	00004797          	auipc	a5,0x4
    80001728:	52c7b783          	ld	a5,1324(a5) # 80005c50 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000172c:	0007b023          	sd	zero,0(a5)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001730:	00000097          	auipc	ra,0x0
    80001734:	094080e7          	jalr	148(ra) # 800017c4 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    80001738:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000173c:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    80001740:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001744:	10079073          	csrw	sstatus,a5
    }
    80001748:	fd1ff06f          	j	80001718 <interruptHandler+0x2c0>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    8000174c:	00003097          	auipc	ra,0x3
    80001750:	044080e7          	jalr	68(ra) # 80004790 <console_handler>
    80001754:	e19ff06f          	j	8000156c <interruptHandler+0x114>

0000000080001758 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00113423          	sd	ra,8(sp)
    80001760:	00813023          	sd	s0,0(sp)
    80001764:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001768:	00000097          	auipc	ra,0x0
    8000176c:	cd0080e7          	jalr	-816(ra) # 80001438 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001770:	00004797          	auipc	a5,0x4
    80001774:	5507b783          	ld	a5,1360(a5) # 80005cc0 <_ZN3PCB7runningE>
    80001778:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    8000177c:	00070513          	mv	a0,a4
    running->main();
    80001780:	0207b783          	ld	a5,32(a5)
    80001784:	000780e7          	jalr	a5
    thread_exit();
    80001788:	00000097          	auipc	ra,0x0
    8000178c:	af8080e7          	jalr	-1288(ra) # 80001280 <_Z11thread_exitv>
}
    80001790:	00813083          	ld	ra,8(sp)
    80001794:	00013403          	ld	s0,0(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret

00000000800017a0 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    800017a0:	ff010113          	addi	sp,sp,-16
    800017a4:	00813423          	sd	s0,8(sp)
    800017a8:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    800017ac:	01300793          	li	a5,19
    800017b0:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    800017b4:	00000073          	ecall
}
    800017b8:	00813403          	ld	s0,8(sp)
    800017bc:	01010113          	addi	sp,sp,16
    800017c0:	00008067          	ret

00000000800017c4 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    800017c4:	fe010113          	addi	sp,sp,-32
    800017c8:	00113c23          	sd	ra,24(sp)
    800017cc:	00813823          	sd	s0,16(sp)
    800017d0:	00913423          	sd	s1,8(sp)
    800017d4:	02010413          	addi	s0,sp,32
    PCB* old = running;
    800017d8:	00004497          	auipc	s1,0x4
    800017dc:	4e84b483          	ld	s1,1256(s1) # 80005cc0 <_ZN3PCB7runningE>
friend void interruptHandler();
friend class Kernel;
public:
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    800017e0:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    800017e4:	00079663          	bnez	a5,800017f0 <_ZN3PCB8dispatchEv+0x2c>
    800017e8:	0294c783          	lbu	a5,41(s1)
    800017ec:	04078263          	beqz	a5,80001830 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	2a8080e7          	jalr	680(ra) # 80001a98 <_ZN9Scheduler3getEv>
    800017f8:	00004797          	auipc	a5,0x4
    800017fc:	4ca7b423          	sd	a0,1224(a5) # 80005cc0 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001800:	04054783          	lbu	a5,64(a0)
    80001804:	02078e63          	beqz	a5,80001840 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001808:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    8000180c:	01853583          	ld	a1,24(a0)
    80001810:	0184b503          	ld	a0,24(s1)
    80001814:	00000097          	auipc	ra,0x0
    80001818:	914080e7          	jalr	-1772(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    8000181c:	01813083          	ld	ra,24(sp)
    80001820:	01013403          	ld	s0,16(sp)
    80001824:	00813483          	ld	s1,8(sp)
    80001828:	02010113          	addi	sp,sp,32
    8000182c:	00008067          	ret
        Scheduler::put(old);
    80001830:	00048513          	mv	a0,s1
    80001834:	00000097          	auipc	ra,0x0
    80001838:	20c080e7          	jalr	524(ra) # 80001a40 <_ZN9Scheduler3putEP3PCB>
    8000183c:	fb5ff06f          	j	800017f0 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001840:	01853583          	ld	a1,24(a0)
    80001844:	0184b503          	ld	a0,24(s1)
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	8f4080e7          	jalr	-1804(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001850:	fcdff06f          	j	8000181c <_ZN3PCB8dispatchEv+0x58>

0000000080001854 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001854:	fe010113          	addi	sp,sp,-32
    80001858:	00113c23          	sd	ra,24(sp)
    8000185c:	00813823          	sd	s0,16(sp)
    80001860:	00913423          	sd	s1,8(sp)
    80001864:	02010413          	addi	s0,sp,32
    80001868:	00050493          	mv	s1,a0
    8000186c:	00053023          	sd	zero,0(a0)
    80001870:	00053c23          	sd	zero,24(a0)
    80001874:	00100793          	li	a5,1
    80001878:	04f50023          	sb	a5,64(a0)
    finished = blocked = false;
    8000187c:	020504a3          	sb	zero,41(a0)
    80001880:	02050423          	sb	zero,40(a0)
    main = main_;
    80001884:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001888:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    8000188c:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001890:	10800513          	li	a0,264
    80001894:	00001097          	auipc	ra,0x1
    80001898:	8d8080e7          	jalr	-1832(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
    8000189c:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    800018a0:	00008537          	lui	a0,0x8
    800018a4:	00001097          	auipc	ra,0x1
    800018a8:	8c8080e7          	jalr	-1848(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
    800018ac:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    800018b0:	000087b7          	lui	a5,0x8
    800018b4:	00f50533          	add	a0,a0,a5
    800018b8:	0184b783          	ld	a5,24(s1)
    800018bc:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    800018c0:	0184b783          	ld	a5,24(s1)
    800018c4:	00000717          	auipc	a4,0x0
    800018c8:	e9470713          	addi	a4,a4,-364 # 80001758 <_ZN3PCB15proccessWrapperEv>
    800018cc:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    800018d0:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    800018d4:	0204b783          	ld	a5,32(s1)
    800018d8:	00078c63          	beqz	a5,800018f0 <_ZN3PCBC1EPFvvEmPv+0x9c>
}
    800018dc:	01813083          	ld	ra,24(sp)
    800018e0:	01013403          	ld	s0,16(sp)
    800018e4:	00813483          	ld	s1,8(sp)
    800018e8:	02010113          	addi	sp,sp,32
    800018ec:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    800018f0:	04048023          	sb	zero,64(s1)
}
    800018f4:	fe9ff06f          	j	800018dc <_ZN3PCBC1EPFvvEmPv+0x88>

00000000800018f8 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    800018f8:	fe010113          	addi	sp,sp,-32
    800018fc:	00113c23          	sd	ra,24(sp)
    80001900:	00813823          	sd	s0,16(sp)
    80001904:	00913423          	sd	s1,8(sp)
    80001908:	02010413          	addi	s0,sp,32
    8000190c:	00050493          	mv	s1,a0
    delete[] stack;
    80001910:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001914:	00050663          	beqz	a0,80001920 <_ZN3PCBD1Ev+0x28>
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	518080e7          	jalr	1304(ra) # 80001e30 <_ZdaPv>
    delete[] sysStack;
    80001920:	0104b503          	ld	a0,16(s1)
    80001924:	00050663          	beqz	a0,80001930 <_ZN3PCBD1Ev+0x38>
    80001928:	00000097          	auipc	ra,0x0
    8000192c:	508080e7          	jalr	1288(ra) # 80001e30 <_ZdaPv>
}
    80001930:	01813083          	ld	ra,24(sp)
    80001934:	01013403          	ld	s0,16(sp)
    80001938:	00813483          	ld	s1,8(sp)
    8000193c:	02010113          	addi	sp,sp,32
    80001940:	00008067          	ret

0000000080001944 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001944:	ff010113          	addi	sp,sp,-16
    80001948:	00113423          	sd	ra,8(sp)
    8000194c:	00813023          	sd	s0,0(sp)
    80001950:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001954:	00001097          	auipc	ra,0x1
    80001958:	818080e7          	jalr	-2024(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
}
    8000195c:	00813083          	ld	ra,8(sp)
    80001960:	00013403          	ld	s0,0(sp)
    80001964:	01010113          	addi	sp,sp,16
    80001968:	00008067          	ret

000000008000196c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    8000196c:	ff010113          	addi	sp,sp,-16
    80001970:	00113423          	sd	ra,8(sp)
    80001974:	00813023          	sd	s0,0(sp)
    80001978:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    8000197c:	00001097          	auipc	ra,0x1
    80001980:	954080e7          	jalr	-1708(ra) # 800022d0 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001984:	00813083          	ld	ra,8(sp)
    80001988:	00013403          	ld	s0,0(sp)
    8000198c:	01010113          	addi	sp,sp,16
    80001990:	00008067          	ret

0000000080001994 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001994:	fd010113          	addi	sp,sp,-48
    80001998:	02113423          	sd	ra,40(sp)
    8000199c:	02813023          	sd	s0,32(sp)
    800019a0:	00913c23          	sd	s1,24(sp)
    800019a4:	01213823          	sd	s2,16(sp)
    800019a8:	01313423          	sd	s3,8(sp)
    800019ac:	03010413          	addi	s0,sp,48
    800019b0:	00050913          	mv	s2,a0
    800019b4:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    800019b8:	04800513          	li	a0,72
    800019bc:	00000097          	auipc	ra,0x0
    800019c0:	f88080e7          	jalr	-120(ra) # 80001944 <_ZN3PCBnwEm>
    800019c4:	00050493          	mv	s1,a0
    800019c8:	00098693          	mv	a3,s3
    800019cc:	00200613          	li	a2,2
    800019d0:	00090593          	mv	a1,s2
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	e80080e7          	jalr	-384(ra) # 80001854 <_ZN3PCBC1EPFvvEmPv>
    800019dc:	0200006f          	j	800019fc <_ZN3PCB14createProccessEPFvvEPv+0x68>
    800019e0:	00050913          	mv	s2,a0
    800019e4:	00048513          	mv	a0,s1
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	f84080e7          	jalr	-124(ra) # 8000196c <_ZN3PCBdlEPv>
    800019f0:	00090513          	mv	a0,s2
    800019f4:	00005097          	auipc	ra,0x5
    800019f8:	3d4080e7          	jalr	980(ra) # 80006dc8 <_Unwind_Resume>
}
    800019fc:	00048513          	mv	a0,s1
    80001a00:	02813083          	ld	ra,40(sp)
    80001a04:	02013403          	ld	s0,32(sp)
    80001a08:	01813483          	ld	s1,24(sp)
    80001a0c:	01013903          	ld	s2,16(sp)
    80001a10:	00813983          	ld	s3,8(sp)
    80001a14:	03010113          	addi	sp,sp,48
    80001a18:	00008067          	ret

0000000080001a1c <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001a1c:	ff010113          	addi	sp,sp,-16
    80001a20:	00813423          	sd	s0,8(sp)
    80001a24:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001a28:	00004797          	auipc	a5,0x4
    80001a2c:	2987b783          	ld	a5,664(a5) # 80005cc0 <_ZN3PCB7runningE>
    80001a30:	0187b503          	ld	a0,24(a5)
    80001a34:	00813403          	ld	s0,8(sp)
    80001a38:	01010113          	addi	sp,sp,16
    80001a3c:	00008067          	ret

0000000080001a40 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001a40:	ff010113          	addi	sp,sp,-16
    80001a44:	00813423          	sd	s0,8(sp)
    80001a48:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001a4c:	02050663          	beqz	a0,80001a78 <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001a50:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001a54:	00004797          	auipc	a5,0x4
    80001a58:	27c7b783          	ld	a5,636(a5) # 80005cd0 <_ZN9Scheduler4tailE>
    80001a5c:	02078463          	beqz	a5,80001a84 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001a60:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001a64:	00004797          	auipc	a5,0x4
    80001a68:	26c78793          	addi	a5,a5,620 # 80005cd0 <_ZN9Scheduler4tailE>
    80001a6c:	0007b703          	ld	a4,0(a5)
    80001a70:	00073703          	ld	a4,0(a4)
    80001a74:	00e7b023          	sd	a4,0(a5)
    }
}
    80001a78:	00813403          	ld	s0,8(sp)
    80001a7c:	01010113          	addi	sp,sp,16
    80001a80:	00008067          	ret
        head = tail = process;
    80001a84:	00004797          	auipc	a5,0x4
    80001a88:	24c78793          	addi	a5,a5,588 # 80005cd0 <_ZN9Scheduler4tailE>
    80001a8c:	00a7b023          	sd	a0,0(a5)
    80001a90:	00a7b423          	sd	a0,8(a5)
    80001a94:	fe5ff06f          	j	80001a78 <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001a98 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001a98:	ff010113          	addi	sp,sp,-16
    80001a9c:	00813423          	sd	s0,8(sp)
    80001aa0:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001aa4:	00004517          	auipc	a0,0x4
    80001aa8:	23453503          	ld	a0,564(a0) # 80005cd8 <_ZN9Scheduler4headE>
    80001aac:	02050463          	beqz	a0,80001ad4 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001ab0:	00053703          	ld	a4,0(a0)
    80001ab4:	00004797          	auipc	a5,0x4
    80001ab8:	21c78793          	addi	a5,a5,540 # 80005cd0 <_ZN9Scheduler4tailE>
    80001abc:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001ac0:	0007b783          	ld	a5,0(a5)
    80001ac4:	00f50e63          	beq	a0,a5,80001ae0 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001ac8:	00813403          	ld	s0,8(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret
        return idleProcess;
    80001ad4:	00004517          	auipc	a0,0x4
    80001ad8:	20c53503          	ld	a0,524(a0) # 80005ce0 <_ZN9Scheduler11idleProcessE>
    80001adc:	fedff06f          	j	80001ac8 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001ae0:	00004797          	auipc	a5,0x4
    80001ae4:	1ee7b823          	sd	a4,496(a5) # 80005cd0 <_ZN9Scheduler4tailE>
    80001ae8:	fe1ff06f          	j	80001ac8 <_ZN9Scheduler3getEv+0x30>

0000000080001aec <_Z11workerBodyAPv>:
#include "../h/SCB.h"

SCB* semafor;

void workerBodyA(void* arg)
{
    80001aec:	fd010113          	addi	sp,sp,-48
    80001af0:	02113423          	sd	ra,40(sp)
    80001af4:	02813023          	sd	s0,32(sp)
    80001af8:	00913c23          	sd	s1,24(sp)
    80001afc:	01213823          	sd	s2,16(sp)
    80001b00:	01313423          	sd	s3,8(sp)
    80001b04:	03010413          	addi	s0,sp,48
    80001b08:	00050993          	mv	s3,a0
    sem_wait(semafor);
    80001b0c:	00004517          	auipc	a0,0x4
    80001b10:	1dc53503          	ld	a0,476(a0) # 80005ce8 <semafor>
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	864080e7          	jalr	-1948(ra) # 80001378 <_Z8sem_waitP3SCB>

    for (uint64 i = 0; i < 3; i++) {
    80001b1c:	00000913          	li	s2,0
    80001b20:	0380006f          	j	80001b58 <_Z11workerBodyAPv+0x6c>
        printString("Nit broj: ");
        printInteger(*(int*)arg);
        printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001b24:	fffff097          	auipc	ra,0xfffff
    80001b28:	730080e7          	jalr	1840(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001b2c:	00148493          	addi	s1,s1,1
    80001b30:	000027b7          	lui	a5,0x2
    80001b34:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001b38:	0097ee63          	bltu	a5,s1,80001b54 <_Z11workerBodyAPv+0x68>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001b3c:	00000713          	li	a4,0
    80001b40:	000077b7          	lui	a5,0x7
    80001b44:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001b48:	fce7eee3          	bltu	a5,a4,80001b24 <_Z11workerBodyAPv+0x38>
    80001b4c:	00170713          	addi	a4,a4,1
    80001b50:	ff1ff06f          	j	80001b40 <_Z11workerBodyAPv+0x54>
    for (uint64 i = 0; i < 3; i++) {
    80001b54:	00190913          	addi	s2,s2,1
    80001b58:	00200793          	li	a5,2
    80001b5c:	0727e263          	bltu	a5,s2,80001bc0 <_Z11workerBodyAPv+0xd4>
        printString("A: i="); printInteger(i); printString("\n");
    80001b60:	00003517          	auipc	a0,0x3
    80001b64:	55850513          	addi	a0,a0,1368 # 800050b8 <CONSOLE_STATUS+0xa8>
    80001b68:	00001097          	auipc	ra,0x1
    80001b6c:	914080e7          	jalr	-1772(ra) # 8000247c <_Z11printStringPKc>
    80001b70:	00090513          	mv	a0,s2
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	978080e7          	jalr	-1672(ra) # 800024ec <_Z12printIntegerm>
    80001b7c:	00003517          	auipc	a0,0x3
    80001b80:	6bc50513          	addi	a0,a0,1724 # 80005238 <_ZZ12printIntegermE6digits+0x120>
    80001b84:	00001097          	auipc	ra,0x1
    80001b88:	8f8080e7          	jalr	-1800(ra) # 8000247c <_Z11printStringPKc>
        printString("Nit broj: ");
    80001b8c:	00003517          	auipc	a0,0x3
    80001b90:	53450513          	addi	a0,a0,1332 # 800050c0 <CONSOLE_STATUS+0xb0>
    80001b94:	00001097          	auipc	ra,0x1
    80001b98:	8e8080e7          	jalr	-1816(ra) # 8000247c <_Z11printStringPKc>
        printInteger(*(int*)arg);
    80001b9c:	0009a503          	lw	a0,0(s3)
    80001ba0:	00001097          	auipc	ra,0x1
    80001ba4:	94c080e7          	jalr	-1716(ra) # 800024ec <_Z12printIntegerm>
        printString("\n");
    80001ba8:	00003517          	auipc	a0,0x3
    80001bac:	69050513          	addi	a0,a0,1680 # 80005238 <_ZZ12printIntegermE6digits+0x120>
    80001bb0:	00001097          	auipc	ra,0x1
    80001bb4:	8cc080e7          	jalr	-1844(ra) # 8000247c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001bb8:	00000493          	li	s1,0
    80001bbc:	f75ff06f          	j	80001b30 <_Z11workerBodyAPv+0x44>
        }
    }
    printString("A finished!\n");
    80001bc0:	00003517          	auipc	a0,0x3
    80001bc4:	51050513          	addi	a0,a0,1296 # 800050d0 <CONSOLE_STATUS+0xc0>
    80001bc8:	00001097          	auipc	ra,0x1
    80001bcc:	8b4080e7          	jalr	-1868(ra) # 8000247c <_Z11printStringPKc>
    sem_signal(semafor);
    80001bd0:	00004517          	auipc	a0,0x4
    80001bd4:	11853503          	ld	a0,280(a0) # 80005ce8 <semafor>
    80001bd8:	00000097          	auipc	ra,0x0
    80001bdc:	804080e7          	jalr	-2044(ra) # 800013dc <_Z10sem_signalP3SCB>
}
    80001be0:	02813083          	ld	ra,40(sp)
    80001be4:	02013403          	ld	s0,32(sp)
    80001be8:	01813483          	ld	s1,24(sp)
    80001bec:	01013903          	ld	s2,16(sp)
    80001bf0:	00813983          	ld	s3,8(sp)
    80001bf4:	03010113          	addi	sp,sp,48
    80001bf8:	00008067          	ret

0000000080001bfc <main>:

extern "C" void interrupt();
int main() {
    80001bfc:	fb010113          	addi	sp,sp,-80
    80001c00:	04113423          	sd	ra,72(sp)
    80001c04:	04813023          	sd	s0,64(sp)
    80001c08:	02913c23          	sd	s1,56(sp)
    80001c0c:	03213823          	sd	s2,48(sp)
    80001c10:	05010413          	addi	s0,sp,80
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001c14:	00004797          	auipc	a5,0x4
    80001c18:	05c7b783          	ld	a5,92(a5) # 80005c70 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001c1c:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001c20:	00000593          	li	a1,0
    80001c24:	00000513          	li	a0,0
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	d6c080e7          	jalr	-660(ra) # 80001994 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001c30:	00004797          	auipc	a5,0x4
    80001c34:	0307b783          	ld	a5,48(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001c38:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001c3c:	00200793          	li	a5,2
    80001c40:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    sem_open(&semafor, 1);
    80001c44:	00100593          	li	a1,1
    80001c48:	00004517          	auipc	a0,0x4
    80001c4c:	0a050513          	addi	a0,a0,160 # 80005ce8 <semafor>
    80001c50:	fffff097          	auipc	ra,0xfffff
    80001c54:	6e0080e7          	jalr	1760(ra) # 80001330 <_Z8sem_openPP3SCBj>
    PCB* procesi[4];
    int niz[4] = {0,1,2,3};
    80001c58:	00003797          	auipc	a5,0x3
    80001c5c:	48878793          	addi	a5,a5,1160 # 800050e0 <CONSOLE_STATUS+0xd0>
    80001c60:	0007b703          	ld	a4,0(a5)
    80001c64:	fae43823          	sd	a4,-80(s0)
    80001c68:	0087b783          	ld	a5,8(a5)
    80001c6c:	faf43c23          	sd	a5,-72(s0)
    for(int i = 0; i < 4; i++) {
    80001c70:	00000493          	li	s1,0
    80001c74:	00300793          	li	a5,3
    80001c78:	0297ce63          	blt	a5,s1,80001cb4 <main+0xb8>
        thread_create(&procesi[i], workerBodyA, &niz[i]);
    80001c7c:	00249713          	slli	a4,s1,0x2
    80001c80:	00349793          	slli	a5,s1,0x3
    80001c84:	fb040613          	addi	a2,s0,-80
    80001c88:	00e60633          	add	a2,a2,a4
    80001c8c:	00000597          	auipc	a1,0x0
    80001c90:	e6058593          	addi	a1,a1,-416 # 80001aec <_Z11workerBodyAPv>
    80001c94:	fc040513          	addi	a0,s0,-64
    80001c98:	00f50533          	add	a0,a0,a5
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	644080e7          	jalr	1604(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    for(int i = 0; i < 4; i++) {
    80001ca4:	0014849b          	addiw	s1,s1,1
    80001ca8:	fcdff06f          	j	80001c74 <main+0x78>
    }

    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        Thread::dispatch();
    80001cac:	00000097          	auipc	ra,0x0
    80001cb0:	274080e7          	jalr	628(ra) # 80001f20 <_ZN6Thread8dispatchEv>
    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
    80001cb4:	fc043783          	ld	a5,-64(s0)
    80001cb8:	0287c783          	lbu	a5,40(a5)
    80001cbc:	fe0788e3          	beqz	a5,80001cac <main+0xb0>
    80001cc0:	fc843783          	ld	a5,-56(s0)
    80001cc4:	0287c783          	lbu	a5,40(a5)
    80001cc8:	fe0782e3          	beqz	a5,80001cac <main+0xb0>
    80001ccc:	fd043783          	ld	a5,-48(s0)
    80001cd0:	0287c783          	lbu	a5,40(a5)
    80001cd4:	fc078ce3          	beqz	a5,80001cac <main+0xb0>
    80001cd8:	fd843783          	ld	a5,-40(s0)
    80001cdc:	0287c783          	lbu	a5,40(a5)
    80001ce0:	fc0786e3          	beqz	a5,80001cac <main+0xb0>
    80001ce4:	fc040493          	addi	s1,s0,-64
    80001ce8:	0080006f          	j	80001cf0 <main+0xf4>
    }

    for(auto& proces : procesi) {
    80001cec:	00848493          	addi	s1,s1,8
    80001cf0:	fe040793          	addi	a5,s0,-32
    80001cf4:	02f48463          	beq	s1,a5,80001d1c <main+0x120>
        delete proces;
    80001cf8:	0004b903          	ld	s2,0(s1)
    80001cfc:	fe0908e3          	beqz	s2,80001cec <main+0xf0>
    80001d00:	00090513          	mv	a0,s2
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	bf4080e7          	jalr	-1036(ra) # 800018f8 <_ZN3PCBD1Ev>
    80001d0c:	00090513          	mv	a0,s2
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	c5c080e7          	jalr	-932(ra) # 8000196c <_ZN3PCBdlEPv>
    80001d18:	fd5ff06f          	j	80001cec <main+0xf0>
    }

    return 0;
    80001d1c:	00000513          	li	a0,0
    80001d20:	04813083          	ld	ra,72(sp)
    80001d24:	04013403          	ld	s0,64(sp)
    80001d28:	03813483          	ld	s1,56(sp)
    80001d2c:	03013903          	ld	s2,48(sp)
    80001d30:	05010113          	addi	sp,sp,80
    80001d34:	00008067          	ret

0000000080001d38 <_Z13threadWrapperPv>:
void threadWrapper(void* thread);
Thread::Thread() {
    thread_create_only(&myHandle, threadWrapper, this);
}

void threadWrapper(void* thread) {
    80001d38:	ff010113          	addi	sp,sp,-16
    80001d3c:	00113423          	sd	ra,8(sp)
    80001d40:	00813023          	sd	s0,0(sp)
    80001d44:	01010413          	addi	s0,sp,16
    ((Thread*)thread)->run();
    80001d48:	00053783          	ld	a5,0(a0)
    80001d4c:	0107b783          	ld	a5,16(a5)
    80001d50:	000780e7          	jalr	a5
}
    80001d54:	00813083          	ld	ra,8(sp)
    80001d58:	00013403          	ld	s0,0(sp)
    80001d5c:	01010113          	addi	sp,sp,16
    80001d60:	00008067          	ret

0000000080001d64 <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    80001d64:	fe010113          	addi	sp,sp,-32
    80001d68:	00113c23          	sd	ra,24(sp)
    80001d6c:	00813823          	sd	s0,16(sp)
    80001d70:	00913423          	sd	s1,8(sp)
    80001d74:	02010413          	addi	s0,sp,32
    80001d78:	00004797          	auipc	a5,0x4
    80001d7c:	eb078793          	addi	a5,a5,-336 # 80005c28 <_ZTV6Thread+0x10>
    80001d80:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80001d84:	00853483          	ld	s1,8(a0)
    80001d88:	00048e63          	beqz	s1,80001da4 <_ZN6ThreadD1Ev+0x40>
    80001d8c:	00048513          	mv	a0,s1
    80001d90:	00000097          	auipc	ra,0x0
    80001d94:	b68080e7          	jalr	-1176(ra) # 800018f8 <_ZN3PCBD1Ev>
    80001d98:	00048513          	mv	a0,s1
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	bd0080e7          	jalr	-1072(ra) # 8000196c <_ZN3PCBdlEPv>
}
    80001da4:	01813083          	ld	ra,24(sp)
    80001da8:	01013403          	ld	s0,16(sp)
    80001dac:	00813483          	ld	s1,8(sp)
    80001db0:	02010113          	addi	sp,sp,32
    80001db4:	00008067          	ret

0000000080001db8 <_Znwm>:
void* operator new (size_t size) {
    80001db8:	ff010113          	addi	sp,sp,-16
    80001dbc:	00113423          	sd	ra,8(sp)
    80001dc0:	00813023          	sd	s0,0(sp)
    80001dc4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	3ac080e7          	jalr	940(ra) # 80001174 <_Z9mem_allocm>
}
    80001dd0:	00813083          	ld	ra,8(sp)
    80001dd4:	00013403          	ld	s0,0(sp)
    80001dd8:	01010113          	addi	sp,sp,16
    80001ddc:	00008067          	ret

0000000080001de0 <_Znam>:
void* operator new [](size_t size) {
    80001de0:	ff010113          	addi	sp,sp,-16
    80001de4:	00113423          	sd	ra,8(sp)
    80001de8:	00813023          	sd	s0,0(sp)
    80001dec:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001df0:	fffff097          	auipc	ra,0xfffff
    80001df4:	384080e7          	jalr	900(ra) # 80001174 <_Z9mem_allocm>
}
    80001df8:	00813083          	ld	ra,8(sp)
    80001dfc:	00013403          	ld	s0,0(sp)
    80001e00:	01010113          	addi	sp,sp,16
    80001e04:	00008067          	ret

0000000080001e08 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001e08:	ff010113          	addi	sp,sp,-16
    80001e0c:	00113423          	sd	ra,8(sp)
    80001e10:	00813023          	sd	s0,0(sp)
    80001e14:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001e18:	fffff097          	auipc	ra,0xfffff
    80001e1c:	39c080e7          	jalr	924(ra) # 800011b4 <_Z8mem_freePv>
}
    80001e20:	00813083          	ld	ra,8(sp)
    80001e24:	00013403          	ld	s0,0(sp)
    80001e28:	01010113          	addi	sp,sp,16
    80001e2c:	00008067          	ret

0000000080001e30 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001e30:	ff010113          	addi	sp,sp,-16
    80001e34:	00113423          	sd	ra,8(sp)
    80001e38:	00813023          	sd	s0,0(sp)
    80001e3c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001e40:	fffff097          	auipc	ra,0xfffff
    80001e44:	374080e7          	jalr	884(ra) # 800011b4 <_Z8mem_freePv>
}
    80001e48:	00813083          	ld	ra,8(sp)
    80001e4c:	00013403          	ld	s0,0(sp)
    80001e50:	01010113          	addi	sp,sp,16
    80001e54:	00008067          	ret

0000000080001e58 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001e58:	ff010113          	addi	sp,sp,-16
    80001e5c:	00113423          	sd	ra,8(sp)
    80001e60:	00813023          	sd	s0,0(sp)
    80001e64:	01010413          	addi	s0,sp,16
    80001e68:	00004797          	auipc	a5,0x4
    80001e6c:	dc078793          	addi	a5,a5,-576 # 80005c28 <_ZTV6Thread+0x10>
    80001e70:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80001e74:	00850513          	addi	a0,a0,8
    80001e78:	fffff097          	auipc	ra,0xfffff
    80001e7c:	370080e7          	jalr	880(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80001e80:	00813083          	ld	ra,8(sp)
    80001e84:	00013403          	ld	s0,0(sp)
    80001e88:	01010113          	addi	sp,sp,16
    80001e8c:	00008067          	ret

0000000080001e90 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80001e90:	ff010113          	addi	sp,sp,-16
    80001e94:	00113423          	sd	ra,8(sp)
    80001e98:	00813023          	sd	s0,0(sp)
    80001e9c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	2cc080e7          	jalr	716(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
}
    80001ea8:	00813083          	ld	ra,8(sp)
    80001eac:	00013403          	ld	s0,0(sp)
    80001eb0:	01010113          	addi	sp,sp,16
    80001eb4:	00008067          	ret

0000000080001eb8 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80001eb8:	ff010113          	addi	sp,sp,-16
    80001ebc:	00113423          	sd	ra,8(sp)
    80001ec0:	00813023          	sd	s0,0(sp)
    80001ec4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001ec8:	00000097          	auipc	ra,0x0
    80001ecc:	408080e7          	jalr	1032(ra) # 800022d0 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001ed0:	00813083          	ld	ra,8(sp)
    80001ed4:	00013403          	ld	s0,0(sp)
    80001ed8:	01010113          	addi	sp,sp,16
    80001edc:	00008067          	ret

0000000080001ee0 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001ee0:	fe010113          	addi	sp,sp,-32
    80001ee4:	00113c23          	sd	ra,24(sp)
    80001ee8:	00813823          	sd	s0,16(sp)
    80001eec:	00913423          	sd	s1,8(sp)
    80001ef0:	02010413          	addi	s0,sp,32
    80001ef4:	00050493          	mv	s1,a0
}
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	e6c080e7          	jalr	-404(ra) # 80001d64 <_ZN6ThreadD1Ev>
    80001f00:	00048513          	mv	a0,s1
    80001f04:	00000097          	auipc	ra,0x0
    80001f08:	fb4080e7          	jalr	-76(ra) # 80001eb8 <_ZN6ThreaddlEPv>
    80001f0c:	01813083          	ld	ra,24(sp)
    80001f10:	01013403          	ld	s0,16(sp)
    80001f14:	00813483          	ld	s1,8(sp)
    80001f18:	02010113          	addi	sp,sp,32
    80001f1c:	00008067          	ret

0000000080001f20 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001f20:	ff010113          	addi	sp,sp,-16
    80001f24:	00113423          	sd	ra,8(sp)
    80001f28:	00813023          	sd	s0,0(sp)
    80001f2c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	324080e7          	jalr	804(ra) # 80001254 <_Z15thread_dispatchv>
}
    80001f38:	00813083          	ld	ra,8(sp)
    80001f3c:	00013403          	ld	s0,0(sp)
    80001f40:	01010113          	addi	sp,sp,16
    80001f44:	00008067          	ret

0000000080001f48 <_ZN6Thread5startEv>:
int Thread::start() {
    80001f48:	ff010113          	addi	sp,sp,-16
    80001f4c:	00113423          	sd	ra,8(sp)
    80001f50:	00813023          	sd	s0,0(sp)
    80001f54:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80001f58:	00850513          	addi	a0,a0,8
    80001f5c:	fffff097          	auipc	ra,0xfffff
    80001f60:	354080e7          	jalr	852(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    80001f64:	00000513          	li	a0,0
    80001f68:	00813083          	ld	ra,8(sp)
    80001f6c:	00013403          	ld	s0,0(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret

0000000080001f78 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001f78:	ff010113          	addi	sp,sp,-16
    80001f7c:	00113423          	sd	ra,8(sp)
    80001f80:	00813023          	sd	s0,0(sp)
    80001f84:	01010413          	addi	s0,sp,16
    80001f88:	00004797          	auipc	a5,0x4
    80001f8c:	ca078793          	addi	a5,a5,-864 # 80005c28 <_ZTV6Thread+0x10>
    80001f90:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, threadWrapper, this);
    80001f94:	00050613          	mv	a2,a0
    80001f98:	00000597          	auipc	a1,0x0
    80001f9c:	da058593          	addi	a1,a1,-608 # 80001d38 <_Z13threadWrapperPv>
    80001fa0:	00850513          	addi	a0,a0,8
    80001fa4:	fffff097          	auipc	ra,0xfffff
    80001fa8:	244080e7          	jalr	580(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80001fac:	00813083          	ld	ra,8(sp)
    80001fb0:	00013403          	ld	s0,0(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret

0000000080001fbc <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80001fbc:	ff010113          	addi	sp,sp,-16
    80001fc0:	00813423          	sd	s0,8(sp)
    80001fc4:	01010413          	addi	s0,sp,16
    80001fc8:	00813403          	ld	s0,8(sp)
    80001fcc:	01010113          	addi	sp,sp,16
    80001fd0:	00008067          	ret

0000000080001fd4 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80001fd4:	ff010113          	addi	sp,sp,-16
    80001fd8:	00813423          	sd	s0,8(sp)
    80001fdc:	01010413          	addi	s0,sp,16
    PCB::running->nextInList = nullptr;
    80001fe0:	00004797          	auipc	a5,0x4
    80001fe4:	c807b783          	ld	a5,-896(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001fe8:	0007b783          	ld	a5,0(a5)
    80001fec:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001ff0:	00853783          	ld	a5,8(a0)
    80001ff4:	04078063          	beqz	a5,80002034 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->nextInList = PCB::running;
    80001ff8:	00004717          	auipc	a4,0x4
    80001ffc:	c6873703          	ld	a4,-920(a4) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002000:	00073703          	ld	a4,0(a4)
    80002004:	00e7b023          	sd	a4,0(a5)
        tail = tail->nextInList;
    80002008:	00853783          	ld	a5,8(a0)
    8000200c:	0007b783          	ld	a5,0(a5)
    80002010:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->blocked = true;
    80002014:	00004797          	auipc	a5,0x4
    80002018:	c4c7b783          	ld	a5,-948(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000201c:	0007b783          	ld	a5,0(a5)
    80002020:	00100713          	li	a4,1
    80002024:	02e784a3          	sb	a4,41(a5)
    //PCB::yield(); // ovo treba da radi sistemski poziv
}
    80002028:	00813403          	ld	s0,8(sp)
    8000202c:	01010113          	addi	sp,sp,16
    80002030:	00008067          	ret
        head = tail = PCB::running;
    80002034:	00004797          	auipc	a5,0x4
    80002038:	c2c7b783          	ld	a5,-980(a5) # 80005c60 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000203c:	0007b783          	ld	a5,0(a5)
    80002040:	00f53423          	sd	a5,8(a0)
    80002044:	00f53023          	sd	a5,0(a0)
    80002048:	fcdff06f          	j	80002014 <_ZN3SCB5blockEv+0x40>

000000008000204c <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    8000204c:	ff010113          	addi	sp,sp,-16
    80002050:	00813423          	sd	s0,8(sp)
    80002054:	01010413          	addi	s0,sp,16
    80002058:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    8000205c:	00053503          	ld	a0,0(a0)
    80002060:	00050e63          	beqz	a0,8000207c <_ZN3SCB7unblockEv+0x30>
    PCB* curr = head;
    head = head->nextInList;
    80002064:	00053703          	ld	a4,0(a0)
    80002068:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    8000206c:	0087b683          	ld	a3,8(a5)
    80002070:	00d50c63          	beq	a0,a3,80002088 <_ZN3SCB7unblockEv+0x3c>
        tail = head;
    }
    curr->blocked = false;
    80002074:	020504a3          	sb	zero,41(a0)
    curr->nextInList = nullptr;
    80002078:	00053023          	sd	zero,0(a0)
    return curr;
}
    8000207c:	00813403          	ld	s0,8(sp)
    80002080:	01010113          	addi	sp,sp,16
    80002084:	00008067          	ret
        tail = head;
    80002088:	00e7b423          	sd	a4,8(a5)
    8000208c:	fe9ff06f          	j	80002074 <_ZN3SCB7unblockEv+0x28>

0000000080002090 <_ZN3SCB4waitEv>:

bool SCB::wait() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(--semValue)<0) {
    80002090:	01052783          	lw	a5,16(a0)
    80002094:	fff7879b          	addiw	a5,a5,-1
    80002098:	00f52823          	sw	a5,16(a0)
    8000209c:	02079713          	slli	a4,a5,0x20
    800020a0:	00074663          	bltz	a4,800020ac <_ZN3SCB4waitEv+0x1c>
        block();
        return true;
    }
    return false;
    800020a4:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    800020a8:	00008067          	ret
bool SCB::wait() {
    800020ac:	ff010113          	addi	sp,sp,-16
    800020b0:	00113423          	sd	ra,8(sp)
    800020b4:	00813023          	sd	s0,0(sp)
    800020b8:	01010413          	addi	s0,sp,16
        block();
    800020bc:	00000097          	auipc	ra,0x0
    800020c0:	f18080e7          	jalr	-232(ra) # 80001fd4 <_ZN3SCB5blockEv>
        return true;
    800020c4:	00100513          	li	a0,1
}
    800020c8:	00813083          	ld	ra,8(sp)
    800020cc:	00013403          	ld	s0,0(sp)
    800020d0:	01010113          	addi	sp,sp,16
    800020d4:	00008067          	ret

00000000800020d8 <_ZN3SCB6signalEv>:

PCB* SCB::signal() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(++semValue)<=0) {
    800020d8:	01052783          	lw	a5,16(a0)
    800020dc:	0017879b          	addiw	a5,a5,1
    800020e0:	0007871b          	sext.w	a4,a5
    800020e4:	00f52823          	sw	a5,16(a0)
    800020e8:	00e05663          	blez	a4,800020f4 <_ZN3SCB6signalEv+0x1c>
        return unblock();
    }
    return nullptr;
    800020ec:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    800020f0:	00008067          	ret
PCB* SCB::signal() {
    800020f4:	ff010113          	addi	sp,sp,-16
    800020f8:	00113423          	sd	ra,8(sp)
    800020fc:	00813023          	sd	s0,0(sp)
    80002100:	01010413          	addi	s0,sp,16
        return unblock();
    80002104:	00000097          	auipc	ra,0x0
    80002108:	f48080e7          	jalr	-184(ra) # 8000204c <_ZN3SCB7unblockEv>
}
    8000210c:	00813083          	ld	ra,8(sp)
    80002110:	00013403          	ld	s0,0(sp)
    80002114:	01010113          	addi	sp,sp,16
    80002118:	00008067          	ret

000000008000211c <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    8000211c:	ff010113          	addi	sp,sp,-16
    80002120:	00113423          	sd	ra,8(sp)
    80002124:	00813023          	sd	s0,0(sp)
    80002128:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000212c:	00000097          	auipc	ra,0x0
    80002130:	040080e7          	jalr	64(ra) # 8000216c <_ZN15MemoryAllocator9mem_allocEm>
}
    80002134:	00813083          	ld	ra,8(sp)
    80002138:	00013403          	ld	s0,0(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002144:	ff010113          	addi	sp,sp,-16
    80002148:	00113423          	sd	ra,8(sp)
    8000214c:	00813023          	sd	s0,0(sp)
    80002150:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002154:	00000097          	auipc	ra,0x0
    80002158:	17c080e7          	jalr	380(ra) # 800022d0 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000215c:	00813083          	ld	ra,8(sp)
    80002160:	00013403          	ld	s0,0(sp)
    80002164:	01010113          	addi	sp,sp,16
    80002168:	00008067          	ret

000000008000216c <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    8000216c:	ff010113          	addi	sp,sp,-16
    80002170:	00813423          	sd	s0,8(sp)
    80002174:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002178:	00004797          	auipc	a5,0x4
    8000217c:	b787b783          	ld	a5,-1160(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
    80002180:	02078c63          	beqz	a5,800021b8 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002184:	00004717          	auipc	a4,0x4
    80002188:	ae473703          	ld	a4,-1308(a4) # 80005c68 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000218c:	00073703          	ld	a4,0(a4)
    80002190:	12e78c63          	beq	a5,a4,800022c8 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002194:	00850713          	addi	a4,a0,8
    80002198:	00675813          	srli	a6,a4,0x6
    8000219c:	03f77793          	andi	a5,a4,63
    800021a0:	00f037b3          	snez	a5,a5
    800021a4:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800021a8:	00004517          	auipc	a0,0x4
    800021ac:	b4853503          	ld	a0,-1208(a0) # 80005cf0 <_ZN15MemoryAllocator4headE>
    800021b0:	00000613          	li	a2,0
    800021b4:	0a80006f          	j	8000225c <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800021b8:	00004697          	auipc	a3,0x4
    800021bc:	a906b683          	ld	a3,-1392(a3) # 80005c48 <_GLOBAL_OFFSET_TABLE_+0x8>
    800021c0:	0006b783          	ld	a5,0(a3)
    800021c4:	00004717          	auipc	a4,0x4
    800021c8:	b2f73623          	sd	a5,-1236(a4) # 80005cf0 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800021cc:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800021d0:	00004717          	auipc	a4,0x4
    800021d4:	a9873703          	ld	a4,-1384(a4) # 80005c68 <_GLOBAL_OFFSET_TABLE_+0x28>
    800021d8:	00073703          	ld	a4,0(a4)
    800021dc:	0006b683          	ld	a3,0(a3)
    800021e0:	40d70733          	sub	a4,a4,a3
    800021e4:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800021e8:	0007b823          	sd	zero,16(a5)
    800021ec:	fa9ff06f          	j	80002194 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800021f0:	00060e63          	beqz	a2,8000220c <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800021f4:	01063703          	ld	a4,16(a2)
    800021f8:	04070a63          	beqz	a4,8000224c <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800021fc:	01073703          	ld	a4,16(a4)
    80002200:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002204:	00078813          	mv	a6,a5
    80002208:	0ac0006f          	j	800022b4 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    8000220c:	01053703          	ld	a4,16(a0)
    80002210:	00070a63          	beqz	a4,80002224 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002214:	00004697          	auipc	a3,0x4
    80002218:	ace6be23          	sd	a4,-1316(a3) # 80005cf0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000221c:	00078813          	mv	a6,a5
    80002220:	0940006f          	j	800022b4 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002224:	00004717          	auipc	a4,0x4
    80002228:	a4473703          	ld	a4,-1468(a4) # 80005c68 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000222c:	00073703          	ld	a4,0(a4)
    80002230:	00004697          	auipc	a3,0x4
    80002234:	ace6b023          	sd	a4,-1344(a3) # 80005cf0 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002238:	00078813          	mv	a6,a5
    8000223c:	0780006f          	j	800022b4 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002240:	00004797          	auipc	a5,0x4
    80002244:	aae7b823          	sd	a4,-1360(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
    80002248:	06c0006f          	j	800022b4 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    8000224c:	00078813          	mv	a6,a5
    80002250:	0640006f          	j	800022b4 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002254:	00050613          	mv	a2,a0
        curr = curr->next;
    80002258:	01053503          	ld	a0,16(a0)
    while(curr) {
    8000225c:	06050063          	beqz	a0,800022bc <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002260:	00853783          	ld	a5,8(a0)
    80002264:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002268:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000226c:	fee7e4e3          	bltu	a5,a4,80002254 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002270:	ff06e2e3          	bltu	a3,a6,80002254 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002274:	f7068ee3          	beq	a3,a6,800021f0 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002278:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000227c:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002280:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002284:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002288:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    8000228c:	01053783          	ld	a5,16(a0)
    80002290:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002294:	fa0606e3          	beqz	a2,80002240 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002298:	01063783          	ld	a5,16(a2)
    8000229c:	00078663          	beqz	a5,800022a8 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    800022a0:	0107b783          	ld	a5,16(a5)
    800022a4:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800022a8:	01063783          	ld	a5,16(a2)
    800022ac:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800022b0:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800022b4:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800022b8:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800022bc:	00813403          	ld	s0,8(sp)
    800022c0:	01010113          	addi	sp,sp,16
    800022c4:	00008067          	ret
        return nullptr;
    800022c8:	00000513          	li	a0,0
    800022cc:	ff1ff06f          	j	800022bc <_ZN15MemoryAllocator9mem_allocEm+0x150>

00000000800022d0 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800022d0:	ff010113          	addi	sp,sp,-16
    800022d4:	00813423          	sd	s0,8(sp)
    800022d8:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800022dc:	16050063          	beqz	a0,8000243c <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800022e0:	ff850713          	addi	a4,a0,-8
    800022e4:	00004797          	auipc	a5,0x4
    800022e8:	9647b783          	ld	a5,-1692(a5) # 80005c48 <_GLOBAL_OFFSET_TABLE_+0x8>
    800022ec:	0007b783          	ld	a5,0(a5)
    800022f0:	14f76a63          	bltu	a4,a5,80002444 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800022f4:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800022f8:	fff58693          	addi	a3,a1,-1
    800022fc:	00d706b3          	add	a3,a4,a3
    80002300:	00004617          	auipc	a2,0x4
    80002304:	96863603          	ld	a2,-1688(a2) # 80005c68 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002308:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000230c:	14c6f063          	bgeu	a3,a2,8000244c <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002310:	14070263          	beqz	a4,80002454 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002314:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002318:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000231c:	14079063          	bnez	a5,8000245c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002320:	03f00793          	li	a5,63
    80002324:	14b7f063          	bgeu	a5,a1,80002464 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002328:	00004797          	auipc	a5,0x4
    8000232c:	9c87b783          	ld	a5,-1592(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
    80002330:	02f60063          	beq	a2,a5,80002350 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002334:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002338:	02078a63          	beqz	a5,8000236c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    8000233c:	0007b683          	ld	a3,0(a5)
    80002340:	02e6f663          	bgeu	a3,a4,8000236c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002344:	00078613          	mv	a2,a5
        curr = curr->next;
    80002348:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000234c:	fedff06f          	j	80002338 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002350:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002354:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002358:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000235c:	00004797          	auipc	a5,0x4
    80002360:	98e7ba23          	sd	a4,-1644(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
        return 0;
    80002364:	00000513          	li	a0,0
    80002368:	0480006f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    8000236c:	04060863          	beqz	a2,800023bc <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002370:	00063683          	ld	a3,0(a2)
    80002374:	00863803          	ld	a6,8(a2)
    80002378:	010686b3          	add	a3,a3,a6
    8000237c:	08e68a63          	beq	a3,a4,80002410 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002380:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002384:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80002388:	01063683          	ld	a3,16(a2)
    8000238c:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002390:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002394:	0e078063          	beqz	a5,80002474 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80002398:	0007b583          	ld	a1,0(a5)
    8000239c:	00073683          	ld	a3,0(a4)
    800023a0:	00873603          	ld	a2,8(a4)
    800023a4:	00c686b3          	add	a3,a3,a2
    800023a8:	06d58c63          	beq	a1,a3,80002420 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800023ac:	00000513          	li	a0,0
}
    800023b0:	00813403          	ld	s0,8(sp)
    800023b4:	01010113          	addi	sp,sp,16
    800023b8:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800023bc:	0a078863          	beqz	a5,8000246c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800023c0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800023c4:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800023c8:	00004797          	auipc	a5,0x4
    800023cc:	9287b783          	ld	a5,-1752(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
    800023d0:	0007b603          	ld	a2,0(a5)
    800023d4:	00b706b3          	add	a3,a4,a1
    800023d8:	00d60c63          	beq	a2,a3,800023f0 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800023dc:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800023e0:	00004797          	auipc	a5,0x4
    800023e4:	90e7b823          	sd	a4,-1776(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
            return 0;
    800023e8:	00000513          	li	a0,0
    800023ec:	fc5ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800023f0:	0087b783          	ld	a5,8(a5)
    800023f4:	00b785b3          	add	a1,a5,a1
    800023f8:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800023fc:	00004797          	auipc	a5,0x4
    80002400:	8f47b783          	ld	a5,-1804(a5) # 80005cf0 <_ZN15MemoryAllocator4headE>
    80002404:	0107b783          	ld	a5,16(a5)
    80002408:	00f53423          	sd	a5,8(a0)
    8000240c:	fd5ff06f          	j	800023e0 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002410:	00b805b3          	add	a1,a6,a1
    80002414:	00b63423          	sd	a1,8(a2)
    80002418:	00060713          	mv	a4,a2
    8000241c:	f79ff06f          	j	80002394 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002420:	0087b683          	ld	a3,8(a5)
    80002424:	00d60633          	add	a2,a2,a3
    80002428:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000242c:	0107b783          	ld	a5,16(a5)
    80002430:	00f73823          	sd	a5,16(a4)
    return 0;
    80002434:	00000513          	li	a0,0
    80002438:	f79ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    8000243c:	fff00513          	li	a0,-1
    80002440:	f71ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002444:	fff00513          	li	a0,-1
    80002448:	f69ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    8000244c:	fff00513          	li	a0,-1
    80002450:	f61ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002454:	fff00513          	li	a0,-1
    80002458:	f59ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000245c:	fff00513          	li	a0,-1
    80002460:	f51ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002464:	fff00513          	li	a0,-1
    80002468:	f49ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    8000246c:	fff00513          	li	a0,-1
    80002470:	f41ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002474:	00000513          	li	a0,0
    80002478:	f39ff06f          	j	800023b0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000247c <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    8000247c:	fd010113          	addi	sp,sp,-48
    80002480:	02113423          	sd	ra,40(sp)
    80002484:	02813023          	sd	s0,32(sp)
    80002488:	00913c23          	sd	s1,24(sp)
    8000248c:	01213823          	sd	s2,16(sp)
    80002490:	03010413          	addi	s0,sp,48
    80002494:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002498:	100027f3          	csrr	a5,sstatus
    8000249c:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800024a0:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800024a4:	00200793          	li	a5,2
    800024a8:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    800024ac:	0004c503          	lbu	a0,0(s1)
    800024b0:	00050a63          	beqz	a0,800024c4 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    800024b4:	00002097          	auipc	ra,0x2
    800024b8:	268080e7          	jalr	616(ra) # 8000471c <__putc>
        string++;
    800024bc:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800024c0:	fedff06f          	j	800024ac <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800024c4:	0009091b          	sext.w	s2,s2
    800024c8:	00297913          	andi	s2,s2,2
    800024cc:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800024d0:	10092073          	csrs	sstatus,s2
}
    800024d4:	02813083          	ld	ra,40(sp)
    800024d8:	02013403          	ld	s0,32(sp)
    800024dc:	01813483          	ld	s1,24(sp)
    800024e0:	01013903          	ld	s2,16(sp)
    800024e4:	03010113          	addi	sp,sp,48
    800024e8:	00008067          	ret

00000000800024ec <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    800024ec:	fc010113          	addi	sp,sp,-64
    800024f0:	02113c23          	sd	ra,56(sp)
    800024f4:	02813823          	sd	s0,48(sp)
    800024f8:	02913423          	sd	s1,40(sp)
    800024fc:	03213023          	sd	s2,32(sp)
    80002500:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002504:	100027f3          	csrr	a5,sstatus
    80002508:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    8000250c:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002510:	00200793          	li	a5,2
    80002514:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80002518:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    8000251c:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002520:	00a00613          	li	a2,10
    80002524:	02c5773b          	remuw	a4,a0,a2
    80002528:	02071693          	slli	a3,a4,0x20
    8000252c:	0206d693          	srli	a3,a3,0x20
    80002530:	00003717          	auipc	a4,0x3
    80002534:	be870713          	addi	a4,a4,-1048 # 80005118 <_ZZ12printIntegermE6digits>
    80002538:	00d70733          	add	a4,a4,a3
    8000253c:	00074703          	lbu	a4,0(a4)
    80002540:	fe040693          	addi	a3,s0,-32
    80002544:	009687b3          	add	a5,a3,s1
    80002548:	0014849b          	addiw	s1,s1,1
    8000254c:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002550:	0005071b          	sext.w	a4,a0
    80002554:	02c5553b          	divuw	a0,a0,a2
    80002558:	00900793          	li	a5,9
    8000255c:	fce7e2e3          	bltu	a5,a4,80002520 <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80002560:	fff4849b          	addiw	s1,s1,-1
    80002564:	0004ce63          	bltz	s1,80002580 <_Z12printIntegerm+0x94>
    80002568:	fe040793          	addi	a5,s0,-32
    8000256c:	009787b3          	add	a5,a5,s1
    80002570:	ff07c503          	lbu	a0,-16(a5)
    80002574:	00002097          	auipc	ra,0x2
    80002578:	1a8080e7          	jalr	424(ra) # 8000471c <__putc>
    8000257c:	fe5ff06f          	j	80002560 <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002580:	0009091b          	sext.w	s2,s2
    80002584:	00297913          	andi	s2,s2,2
    80002588:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000258c:	10092073          	csrs	sstatus,s2
}
    80002590:	03813083          	ld	ra,56(sp)
    80002594:	03013403          	ld	s0,48(sp)
    80002598:	02813483          	ld	s1,40(sp)
    8000259c:	02013903          	ld	s2,32(sp)
    800025a0:	04010113          	addi	sp,sp,64
    800025a4:	00008067          	ret

00000000800025a8 <_Z10printErrorv>:
void printError() {
    800025a8:	fc010113          	addi	sp,sp,-64
    800025ac:	02113c23          	sd	ra,56(sp)
    800025b0:	02813823          	sd	s0,48(sp)
    800025b4:	02913423          	sd	s1,40(sp)
    800025b8:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800025bc:	100027f3          	csrr	a5,sstatus
    800025c0:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800025c4:	fd843483          	ld	s1,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800025c8:	00200793          	li	a5,2
    800025cc:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    printString("scause: ");
    800025d0:	00003517          	auipc	a0,0x3
    800025d4:	b2050513          	addi	a0,a0,-1248 # 800050f0 <CONSOLE_STATUS+0xe0>
    800025d8:	00000097          	auipc	ra,0x0
    800025dc:	ea4080e7          	jalr	-348(ra) # 8000247c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800025e0:	142027f3          	csrr	a5,scause
    800025e4:	fcf43823          	sd	a5,-48(s0)
        return scause;
    800025e8:	fd043503          	ld	a0,-48(s0)
    printInteger(Kernel::r_scause());
    800025ec:	00000097          	auipc	ra,0x0
    800025f0:	f00080e7          	jalr	-256(ra) # 800024ec <_Z12printIntegerm>
    printString("\nsepc: ");
    800025f4:	00003517          	auipc	a0,0x3
    800025f8:	b0c50513          	addi	a0,a0,-1268 # 80005100 <CONSOLE_STATUS+0xf0>
    800025fc:	00000097          	auipc	ra,0x0
    80002600:	e80080e7          	jalr	-384(ra) # 8000247c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002604:	141027f3          	csrr	a5,sepc
    80002608:	fcf43423          	sd	a5,-56(s0)
        return sepc;
    8000260c:	fc843503          	ld	a0,-56(s0)
    printInteger(Kernel::r_sepc());
    80002610:	00000097          	auipc	ra,0x0
    80002614:	edc080e7          	jalr	-292(ra) # 800024ec <_Z12printIntegerm>
    printString("\nstval: ");
    80002618:	00003517          	auipc	a0,0x3
    8000261c:	af050513          	addi	a0,a0,-1296 # 80005108 <CONSOLE_STATUS+0xf8>
    80002620:	00000097          	auipc	ra,0x0
    80002624:	e5c080e7          	jalr	-420(ra) # 8000247c <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002628:	143027f3          	csrr	a5,stval
    8000262c:	fcf43023          	sd	a5,-64(s0)
        return stval;
    80002630:	fc043503          	ld	a0,-64(s0)
    printInteger(Kernel::r_stval());
    80002634:	00000097          	auipc	ra,0x0
    80002638:	eb8080e7          	jalr	-328(ra) # 800024ec <_Z12printIntegerm>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    8000263c:	0004849b          	sext.w	s1,s1
    80002640:	0024f493          	andi	s1,s1,2
    80002644:	0004849b          	sext.w	s1,s1
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002648:	1004a073          	csrs	sstatus,s1
    8000264c:	03813083          	ld	ra,56(sp)
    80002650:	03013403          	ld	s0,48(sp)
    80002654:	02813483          	ld	s1,40(sp)
    80002658:	04010113          	addi	sp,sp,64
    8000265c:	00008067          	ret

0000000080002660 <start>:
    80002660:	ff010113          	addi	sp,sp,-16
    80002664:	00813423          	sd	s0,8(sp)
    80002668:	01010413          	addi	s0,sp,16
    8000266c:	300027f3          	csrr	a5,mstatus
    80002670:	ffffe737          	lui	a4,0xffffe
    80002674:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff789f>
    80002678:	00e7f7b3          	and	a5,a5,a4
    8000267c:	00001737          	lui	a4,0x1
    80002680:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002684:	00e7e7b3          	or	a5,a5,a4
    80002688:	30079073          	csrw	mstatus,a5
    8000268c:	00000797          	auipc	a5,0x0
    80002690:	16078793          	addi	a5,a5,352 # 800027ec <system_main>
    80002694:	34179073          	csrw	mepc,a5
    80002698:	00000793          	li	a5,0
    8000269c:	18079073          	csrw	satp,a5
    800026a0:	000107b7          	lui	a5,0x10
    800026a4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800026a8:	30279073          	csrw	medeleg,a5
    800026ac:	30379073          	csrw	mideleg,a5
    800026b0:	104027f3          	csrr	a5,sie
    800026b4:	2227e793          	ori	a5,a5,546
    800026b8:	10479073          	csrw	sie,a5
    800026bc:	fff00793          	li	a5,-1
    800026c0:	00a7d793          	srli	a5,a5,0xa
    800026c4:	3b079073          	csrw	pmpaddr0,a5
    800026c8:	00f00793          	li	a5,15
    800026cc:	3a079073          	csrw	pmpcfg0,a5
    800026d0:	f14027f3          	csrr	a5,mhartid
    800026d4:	0200c737          	lui	a4,0x200c
    800026d8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800026dc:	0007869b          	sext.w	a3,a5
    800026e0:	00269713          	slli	a4,a3,0x2
    800026e4:	000f4637          	lui	a2,0xf4
    800026e8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800026ec:	00d70733          	add	a4,a4,a3
    800026f0:	0037979b          	slliw	a5,a5,0x3
    800026f4:	020046b7          	lui	a3,0x2004
    800026f8:	00d787b3          	add	a5,a5,a3
    800026fc:	00c585b3          	add	a1,a1,a2
    80002700:	00371693          	slli	a3,a4,0x3
    80002704:	00003717          	auipc	a4,0x3
    80002708:	5fc70713          	addi	a4,a4,1532 # 80005d00 <timer_scratch>
    8000270c:	00b7b023          	sd	a1,0(a5)
    80002710:	00d70733          	add	a4,a4,a3
    80002714:	00f73c23          	sd	a5,24(a4)
    80002718:	02c73023          	sd	a2,32(a4)
    8000271c:	34071073          	csrw	mscratch,a4
    80002720:	00000797          	auipc	a5,0x0
    80002724:	6e078793          	addi	a5,a5,1760 # 80002e00 <timervec>
    80002728:	30579073          	csrw	mtvec,a5
    8000272c:	300027f3          	csrr	a5,mstatus
    80002730:	0087e793          	ori	a5,a5,8
    80002734:	30079073          	csrw	mstatus,a5
    80002738:	304027f3          	csrr	a5,mie
    8000273c:	0807e793          	ori	a5,a5,128
    80002740:	30479073          	csrw	mie,a5
    80002744:	f14027f3          	csrr	a5,mhartid
    80002748:	0007879b          	sext.w	a5,a5
    8000274c:	00078213          	mv	tp,a5
    80002750:	30200073          	mret
    80002754:	00813403          	ld	s0,8(sp)
    80002758:	01010113          	addi	sp,sp,16
    8000275c:	00008067          	ret

0000000080002760 <timerinit>:
    80002760:	ff010113          	addi	sp,sp,-16
    80002764:	00813423          	sd	s0,8(sp)
    80002768:	01010413          	addi	s0,sp,16
    8000276c:	f14027f3          	csrr	a5,mhartid
    80002770:	0200c737          	lui	a4,0x200c
    80002774:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002778:	0007869b          	sext.w	a3,a5
    8000277c:	00269713          	slli	a4,a3,0x2
    80002780:	000f4637          	lui	a2,0xf4
    80002784:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002788:	00d70733          	add	a4,a4,a3
    8000278c:	0037979b          	slliw	a5,a5,0x3
    80002790:	020046b7          	lui	a3,0x2004
    80002794:	00d787b3          	add	a5,a5,a3
    80002798:	00c585b3          	add	a1,a1,a2
    8000279c:	00371693          	slli	a3,a4,0x3
    800027a0:	00003717          	auipc	a4,0x3
    800027a4:	56070713          	addi	a4,a4,1376 # 80005d00 <timer_scratch>
    800027a8:	00b7b023          	sd	a1,0(a5)
    800027ac:	00d70733          	add	a4,a4,a3
    800027b0:	00f73c23          	sd	a5,24(a4)
    800027b4:	02c73023          	sd	a2,32(a4)
    800027b8:	34071073          	csrw	mscratch,a4
    800027bc:	00000797          	auipc	a5,0x0
    800027c0:	64478793          	addi	a5,a5,1604 # 80002e00 <timervec>
    800027c4:	30579073          	csrw	mtvec,a5
    800027c8:	300027f3          	csrr	a5,mstatus
    800027cc:	0087e793          	ori	a5,a5,8
    800027d0:	30079073          	csrw	mstatus,a5
    800027d4:	304027f3          	csrr	a5,mie
    800027d8:	0807e793          	ori	a5,a5,128
    800027dc:	30479073          	csrw	mie,a5
    800027e0:	00813403          	ld	s0,8(sp)
    800027e4:	01010113          	addi	sp,sp,16
    800027e8:	00008067          	ret

00000000800027ec <system_main>:
    800027ec:	fe010113          	addi	sp,sp,-32
    800027f0:	00813823          	sd	s0,16(sp)
    800027f4:	00913423          	sd	s1,8(sp)
    800027f8:	00113c23          	sd	ra,24(sp)
    800027fc:	02010413          	addi	s0,sp,32
    80002800:	00000097          	auipc	ra,0x0
    80002804:	0c4080e7          	jalr	196(ra) # 800028c4 <cpuid>
    80002808:	00003497          	auipc	s1,0x3
    8000280c:	48848493          	addi	s1,s1,1160 # 80005c90 <started>
    80002810:	02050263          	beqz	a0,80002834 <system_main+0x48>
    80002814:	0004a783          	lw	a5,0(s1)
    80002818:	0007879b          	sext.w	a5,a5
    8000281c:	fe078ce3          	beqz	a5,80002814 <system_main+0x28>
    80002820:	0ff0000f          	fence
    80002824:	00003517          	auipc	a0,0x3
    80002828:	93450513          	addi	a0,a0,-1740 # 80005158 <_ZZ12printIntegermE6digits+0x40>
    8000282c:	00001097          	auipc	ra,0x1
    80002830:	a70080e7          	jalr	-1424(ra) # 8000329c <panic>
    80002834:	00001097          	auipc	ra,0x1
    80002838:	9c4080e7          	jalr	-1596(ra) # 800031f8 <consoleinit>
    8000283c:	00001097          	auipc	ra,0x1
    80002840:	150080e7          	jalr	336(ra) # 8000398c <printfinit>
    80002844:	00003517          	auipc	a0,0x3
    80002848:	9f450513          	addi	a0,a0,-1548 # 80005238 <_ZZ12printIntegermE6digits+0x120>
    8000284c:	00001097          	auipc	ra,0x1
    80002850:	aac080e7          	jalr	-1364(ra) # 800032f8 <__printf>
    80002854:	00003517          	auipc	a0,0x3
    80002858:	8d450513          	addi	a0,a0,-1836 # 80005128 <_ZZ12printIntegermE6digits+0x10>
    8000285c:	00001097          	auipc	ra,0x1
    80002860:	a9c080e7          	jalr	-1380(ra) # 800032f8 <__printf>
    80002864:	00003517          	auipc	a0,0x3
    80002868:	9d450513          	addi	a0,a0,-1580 # 80005238 <_ZZ12printIntegermE6digits+0x120>
    8000286c:	00001097          	auipc	ra,0x1
    80002870:	a8c080e7          	jalr	-1396(ra) # 800032f8 <__printf>
    80002874:	00001097          	auipc	ra,0x1
    80002878:	4a4080e7          	jalr	1188(ra) # 80003d18 <kinit>
    8000287c:	00000097          	auipc	ra,0x0
    80002880:	148080e7          	jalr	328(ra) # 800029c4 <trapinit>
    80002884:	00000097          	auipc	ra,0x0
    80002888:	16c080e7          	jalr	364(ra) # 800029f0 <trapinithart>
    8000288c:	00000097          	auipc	ra,0x0
    80002890:	5b4080e7          	jalr	1460(ra) # 80002e40 <plicinit>
    80002894:	00000097          	auipc	ra,0x0
    80002898:	5d4080e7          	jalr	1492(ra) # 80002e68 <plicinithart>
    8000289c:	00000097          	auipc	ra,0x0
    800028a0:	078080e7          	jalr	120(ra) # 80002914 <userinit>
    800028a4:	0ff0000f          	fence
    800028a8:	00100793          	li	a5,1
    800028ac:	00003517          	auipc	a0,0x3
    800028b0:	89450513          	addi	a0,a0,-1900 # 80005140 <_ZZ12printIntegermE6digits+0x28>
    800028b4:	00f4a023          	sw	a5,0(s1)
    800028b8:	00001097          	auipc	ra,0x1
    800028bc:	a40080e7          	jalr	-1472(ra) # 800032f8 <__printf>
    800028c0:	0000006f          	j	800028c0 <system_main+0xd4>

00000000800028c4 <cpuid>:
    800028c4:	ff010113          	addi	sp,sp,-16
    800028c8:	00813423          	sd	s0,8(sp)
    800028cc:	01010413          	addi	s0,sp,16
    800028d0:	00020513          	mv	a0,tp
    800028d4:	00813403          	ld	s0,8(sp)
    800028d8:	0005051b          	sext.w	a0,a0
    800028dc:	01010113          	addi	sp,sp,16
    800028e0:	00008067          	ret

00000000800028e4 <mycpu>:
    800028e4:	ff010113          	addi	sp,sp,-16
    800028e8:	00813423          	sd	s0,8(sp)
    800028ec:	01010413          	addi	s0,sp,16
    800028f0:	00020793          	mv	a5,tp
    800028f4:	00813403          	ld	s0,8(sp)
    800028f8:	0007879b          	sext.w	a5,a5
    800028fc:	00779793          	slli	a5,a5,0x7
    80002900:	00004517          	auipc	a0,0x4
    80002904:	43050513          	addi	a0,a0,1072 # 80006d30 <cpus>
    80002908:	00f50533          	add	a0,a0,a5
    8000290c:	01010113          	addi	sp,sp,16
    80002910:	00008067          	ret

0000000080002914 <userinit>:
    80002914:	ff010113          	addi	sp,sp,-16
    80002918:	00813423          	sd	s0,8(sp)
    8000291c:	01010413          	addi	s0,sp,16
    80002920:	00813403          	ld	s0,8(sp)
    80002924:	01010113          	addi	sp,sp,16
    80002928:	fffff317          	auipc	t1,0xfffff
    8000292c:	2d430067          	jr	724(t1) # 80001bfc <main>

0000000080002930 <either_copyout>:
    80002930:	ff010113          	addi	sp,sp,-16
    80002934:	00813023          	sd	s0,0(sp)
    80002938:	00113423          	sd	ra,8(sp)
    8000293c:	01010413          	addi	s0,sp,16
    80002940:	02051663          	bnez	a0,8000296c <either_copyout+0x3c>
    80002944:	00058513          	mv	a0,a1
    80002948:	00060593          	mv	a1,a2
    8000294c:	0006861b          	sext.w	a2,a3
    80002950:	00002097          	auipc	ra,0x2
    80002954:	c54080e7          	jalr	-940(ra) # 800045a4 <__memmove>
    80002958:	00813083          	ld	ra,8(sp)
    8000295c:	00013403          	ld	s0,0(sp)
    80002960:	00000513          	li	a0,0
    80002964:	01010113          	addi	sp,sp,16
    80002968:	00008067          	ret
    8000296c:	00003517          	auipc	a0,0x3
    80002970:	81450513          	addi	a0,a0,-2028 # 80005180 <_ZZ12printIntegermE6digits+0x68>
    80002974:	00001097          	auipc	ra,0x1
    80002978:	928080e7          	jalr	-1752(ra) # 8000329c <panic>

000000008000297c <either_copyin>:
    8000297c:	ff010113          	addi	sp,sp,-16
    80002980:	00813023          	sd	s0,0(sp)
    80002984:	00113423          	sd	ra,8(sp)
    80002988:	01010413          	addi	s0,sp,16
    8000298c:	02059463          	bnez	a1,800029b4 <either_copyin+0x38>
    80002990:	00060593          	mv	a1,a2
    80002994:	0006861b          	sext.w	a2,a3
    80002998:	00002097          	auipc	ra,0x2
    8000299c:	c0c080e7          	jalr	-1012(ra) # 800045a4 <__memmove>
    800029a0:	00813083          	ld	ra,8(sp)
    800029a4:	00013403          	ld	s0,0(sp)
    800029a8:	00000513          	li	a0,0
    800029ac:	01010113          	addi	sp,sp,16
    800029b0:	00008067          	ret
    800029b4:	00002517          	auipc	a0,0x2
    800029b8:	7f450513          	addi	a0,a0,2036 # 800051a8 <_ZZ12printIntegermE6digits+0x90>
    800029bc:	00001097          	auipc	ra,0x1
    800029c0:	8e0080e7          	jalr	-1824(ra) # 8000329c <panic>

00000000800029c4 <trapinit>:
    800029c4:	ff010113          	addi	sp,sp,-16
    800029c8:	00813423          	sd	s0,8(sp)
    800029cc:	01010413          	addi	s0,sp,16
    800029d0:	00813403          	ld	s0,8(sp)
    800029d4:	00002597          	auipc	a1,0x2
    800029d8:	7fc58593          	addi	a1,a1,2044 # 800051d0 <_ZZ12printIntegermE6digits+0xb8>
    800029dc:	00004517          	auipc	a0,0x4
    800029e0:	3d450513          	addi	a0,a0,980 # 80006db0 <tickslock>
    800029e4:	01010113          	addi	sp,sp,16
    800029e8:	00001317          	auipc	t1,0x1
    800029ec:	5c030067          	jr	1472(t1) # 80003fa8 <initlock>

00000000800029f0 <trapinithart>:
    800029f0:	ff010113          	addi	sp,sp,-16
    800029f4:	00813423          	sd	s0,8(sp)
    800029f8:	01010413          	addi	s0,sp,16
    800029fc:	00000797          	auipc	a5,0x0
    80002a00:	2f478793          	addi	a5,a5,756 # 80002cf0 <kernelvec>
    80002a04:	10579073          	csrw	stvec,a5
    80002a08:	00813403          	ld	s0,8(sp)
    80002a0c:	01010113          	addi	sp,sp,16
    80002a10:	00008067          	ret

0000000080002a14 <usertrap>:
    80002a14:	ff010113          	addi	sp,sp,-16
    80002a18:	00813423          	sd	s0,8(sp)
    80002a1c:	01010413          	addi	s0,sp,16
    80002a20:	00813403          	ld	s0,8(sp)
    80002a24:	01010113          	addi	sp,sp,16
    80002a28:	00008067          	ret

0000000080002a2c <usertrapret>:
    80002a2c:	ff010113          	addi	sp,sp,-16
    80002a30:	00813423          	sd	s0,8(sp)
    80002a34:	01010413          	addi	s0,sp,16
    80002a38:	00813403          	ld	s0,8(sp)
    80002a3c:	01010113          	addi	sp,sp,16
    80002a40:	00008067          	ret

0000000080002a44 <kerneltrap>:
    80002a44:	fe010113          	addi	sp,sp,-32
    80002a48:	00813823          	sd	s0,16(sp)
    80002a4c:	00113c23          	sd	ra,24(sp)
    80002a50:	00913423          	sd	s1,8(sp)
    80002a54:	02010413          	addi	s0,sp,32
    80002a58:	142025f3          	csrr	a1,scause
    80002a5c:	100027f3          	csrr	a5,sstatus
    80002a60:	0027f793          	andi	a5,a5,2
    80002a64:	10079c63          	bnez	a5,80002b7c <kerneltrap+0x138>
    80002a68:	142027f3          	csrr	a5,scause
    80002a6c:	0207ce63          	bltz	a5,80002aa8 <kerneltrap+0x64>
    80002a70:	00002517          	auipc	a0,0x2
    80002a74:	7a850513          	addi	a0,a0,1960 # 80005218 <_ZZ12printIntegermE6digits+0x100>
    80002a78:	00001097          	auipc	ra,0x1
    80002a7c:	880080e7          	jalr	-1920(ra) # 800032f8 <__printf>
    80002a80:	141025f3          	csrr	a1,sepc
    80002a84:	14302673          	csrr	a2,stval
    80002a88:	00002517          	auipc	a0,0x2
    80002a8c:	7a050513          	addi	a0,a0,1952 # 80005228 <_ZZ12printIntegermE6digits+0x110>
    80002a90:	00001097          	auipc	ra,0x1
    80002a94:	868080e7          	jalr	-1944(ra) # 800032f8 <__printf>
    80002a98:	00002517          	auipc	a0,0x2
    80002a9c:	7a850513          	addi	a0,a0,1960 # 80005240 <_ZZ12printIntegermE6digits+0x128>
    80002aa0:	00000097          	auipc	ra,0x0
    80002aa4:	7fc080e7          	jalr	2044(ra) # 8000329c <panic>
    80002aa8:	0ff7f713          	andi	a4,a5,255
    80002aac:	00900693          	li	a3,9
    80002ab0:	04d70063          	beq	a4,a3,80002af0 <kerneltrap+0xac>
    80002ab4:	fff00713          	li	a4,-1
    80002ab8:	03f71713          	slli	a4,a4,0x3f
    80002abc:	00170713          	addi	a4,a4,1
    80002ac0:	fae798e3          	bne	a5,a4,80002a70 <kerneltrap+0x2c>
    80002ac4:	00000097          	auipc	ra,0x0
    80002ac8:	e00080e7          	jalr	-512(ra) # 800028c4 <cpuid>
    80002acc:	06050663          	beqz	a0,80002b38 <kerneltrap+0xf4>
    80002ad0:	144027f3          	csrr	a5,sip
    80002ad4:	ffd7f793          	andi	a5,a5,-3
    80002ad8:	14479073          	csrw	sip,a5
    80002adc:	01813083          	ld	ra,24(sp)
    80002ae0:	01013403          	ld	s0,16(sp)
    80002ae4:	00813483          	ld	s1,8(sp)
    80002ae8:	02010113          	addi	sp,sp,32
    80002aec:	00008067          	ret
    80002af0:	00000097          	auipc	ra,0x0
    80002af4:	3c4080e7          	jalr	964(ra) # 80002eb4 <plic_claim>
    80002af8:	00a00793          	li	a5,10
    80002afc:	00050493          	mv	s1,a0
    80002b00:	06f50863          	beq	a0,a5,80002b70 <kerneltrap+0x12c>
    80002b04:	fc050ce3          	beqz	a0,80002adc <kerneltrap+0x98>
    80002b08:	00050593          	mv	a1,a0
    80002b0c:	00002517          	auipc	a0,0x2
    80002b10:	6ec50513          	addi	a0,a0,1772 # 800051f8 <_ZZ12printIntegermE6digits+0xe0>
    80002b14:	00000097          	auipc	ra,0x0
    80002b18:	7e4080e7          	jalr	2020(ra) # 800032f8 <__printf>
    80002b1c:	01013403          	ld	s0,16(sp)
    80002b20:	01813083          	ld	ra,24(sp)
    80002b24:	00048513          	mv	a0,s1
    80002b28:	00813483          	ld	s1,8(sp)
    80002b2c:	02010113          	addi	sp,sp,32
    80002b30:	00000317          	auipc	t1,0x0
    80002b34:	3bc30067          	jr	956(t1) # 80002eec <plic_complete>
    80002b38:	00004517          	auipc	a0,0x4
    80002b3c:	27850513          	addi	a0,a0,632 # 80006db0 <tickslock>
    80002b40:	00001097          	auipc	ra,0x1
    80002b44:	48c080e7          	jalr	1164(ra) # 80003fcc <acquire>
    80002b48:	00003717          	auipc	a4,0x3
    80002b4c:	14c70713          	addi	a4,a4,332 # 80005c94 <ticks>
    80002b50:	00072783          	lw	a5,0(a4)
    80002b54:	00004517          	auipc	a0,0x4
    80002b58:	25c50513          	addi	a0,a0,604 # 80006db0 <tickslock>
    80002b5c:	0017879b          	addiw	a5,a5,1
    80002b60:	00f72023          	sw	a5,0(a4)
    80002b64:	00001097          	auipc	ra,0x1
    80002b68:	534080e7          	jalr	1332(ra) # 80004098 <release>
    80002b6c:	f65ff06f          	j	80002ad0 <kerneltrap+0x8c>
    80002b70:	00001097          	auipc	ra,0x1
    80002b74:	090080e7          	jalr	144(ra) # 80003c00 <uartintr>
    80002b78:	fa5ff06f          	j	80002b1c <kerneltrap+0xd8>
    80002b7c:	00002517          	auipc	a0,0x2
    80002b80:	65c50513          	addi	a0,a0,1628 # 800051d8 <_ZZ12printIntegermE6digits+0xc0>
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	718080e7          	jalr	1816(ra) # 8000329c <panic>

0000000080002b8c <clockintr>:
    80002b8c:	fe010113          	addi	sp,sp,-32
    80002b90:	00813823          	sd	s0,16(sp)
    80002b94:	00913423          	sd	s1,8(sp)
    80002b98:	00113c23          	sd	ra,24(sp)
    80002b9c:	02010413          	addi	s0,sp,32
    80002ba0:	00004497          	auipc	s1,0x4
    80002ba4:	21048493          	addi	s1,s1,528 # 80006db0 <tickslock>
    80002ba8:	00048513          	mv	a0,s1
    80002bac:	00001097          	auipc	ra,0x1
    80002bb0:	420080e7          	jalr	1056(ra) # 80003fcc <acquire>
    80002bb4:	00003717          	auipc	a4,0x3
    80002bb8:	0e070713          	addi	a4,a4,224 # 80005c94 <ticks>
    80002bbc:	00072783          	lw	a5,0(a4)
    80002bc0:	01013403          	ld	s0,16(sp)
    80002bc4:	01813083          	ld	ra,24(sp)
    80002bc8:	00048513          	mv	a0,s1
    80002bcc:	0017879b          	addiw	a5,a5,1
    80002bd0:	00813483          	ld	s1,8(sp)
    80002bd4:	00f72023          	sw	a5,0(a4)
    80002bd8:	02010113          	addi	sp,sp,32
    80002bdc:	00001317          	auipc	t1,0x1
    80002be0:	4bc30067          	jr	1212(t1) # 80004098 <release>

0000000080002be4 <devintr>:
    80002be4:	142027f3          	csrr	a5,scause
    80002be8:	00000513          	li	a0,0
    80002bec:	0007c463          	bltz	a5,80002bf4 <devintr+0x10>
    80002bf0:	00008067          	ret
    80002bf4:	fe010113          	addi	sp,sp,-32
    80002bf8:	00813823          	sd	s0,16(sp)
    80002bfc:	00113c23          	sd	ra,24(sp)
    80002c00:	00913423          	sd	s1,8(sp)
    80002c04:	02010413          	addi	s0,sp,32
    80002c08:	0ff7f713          	andi	a4,a5,255
    80002c0c:	00900693          	li	a3,9
    80002c10:	04d70c63          	beq	a4,a3,80002c68 <devintr+0x84>
    80002c14:	fff00713          	li	a4,-1
    80002c18:	03f71713          	slli	a4,a4,0x3f
    80002c1c:	00170713          	addi	a4,a4,1
    80002c20:	00e78c63          	beq	a5,a4,80002c38 <devintr+0x54>
    80002c24:	01813083          	ld	ra,24(sp)
    80002c28:	01013403          	ld	s0,16(sp)
    80002c2c:	00813483          	ld	s1,8(sp)
    80002c30:	02010113          	addi	sp,sp,32
    80002c34:	00008067          	ret
    80002c38:	00000097          	auipc	ra,0x0
    80002c3c:	c8c080e7          	jalr	-884(ra) # 800028c4 <cpuid>
    80002c40:	06050663          	beqz	a0,80002cac <devintr+0xc8>
    80002c44:	144027f3          	csrr	a5,sip
    80002c48:	ffd7f793          	andi	a5,a5,-3
    80002c4c:	14479073          	csrw	sip,a5
    80002c50:	01813083          	ld	ra,24(sp)
    80002c54:	01013403          	ld	s0,16(sp)
    80002c58:	00813483          	ld	s1,8(sp)
    80002c5c:	00200513          	li	a0,2
    80002c60:	02010113          	addi	sp,sp,32
    80002c64:	00008067          	ret
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	24c080e7          	jalr	588(ra) # 80002eb4 <plic_claim>
    80002c70:	00a00793          	li	a5,10
    80002c74:	00050493          	mv	s1,a0
    80002c78:	06f50663          	beq	a0,a5,80002ce4 <devintr+0x100>
    80002c7c:	00100513          	li	a0,1
    80002c80:	fa0482e3          	beqz	s1,80002c24 <devintr+0x40>
    80002c84:	00048593          	mv	a1,s1
    80002c88:	00002517          	auipc	a0,0x2
    80002c8c:	57050513          	addi	a0,a0,1392 # 800051f8 <_ZZ12printIntegermE6digits+0xe0>
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	668080e7          	jalr	1640(ra) # 800032f8 <__printf>
    80002c98:	00048513          	mv	a0,s1
    80002c9c:	00000097          	auipc	ra,0x0
    80002ca0:	250080e7          	jalr	592(ra) # 80002eec <plic_complete>
    80002ca4:	00100513          	li	a0,1
    80002ca8:	f7dff06f          	j	80002c24 <devintr+0x40>
    80002cac:	00004517          	auipc	a0,0x4
    80002cb0:	10450513          	addi	a0,a0,260 # 80006db0 <tickslock>
    80002cb4:	00001097          	auipc	ra,0x1
    80002cb8:	318080e7          	jalr	792(ra) # 80003fcc <acquire>
    80002cbc:	00003717          	auipc	a4,0x3
    80002cc0:	fd870713          	addi	a4,a4,-40 # 80005c94 <ticks>
    80002cc4:	00072783          	lw	a5,0(a4)
    80002cc8:	00004517          	auipc	a0,0x4
    80002ccc:	0e850513          	addi	a0,a0,232 # 80006db0 <tickslock>
    80002cd0:	0017879b          	addiw	a5,a5,1
    80002cd4:	00f72023          	sw	a5,0(a4)
    80002cd8:	00001097          	auipc	ra,0x1
    80002cdc:	3c0080e7          	jalr	960(ra) # 80004098 <release>
    80002ce0:	f65ff06f          	j	80002c44 <devintr+0x60>
    80002ce4:	00001097          	auipc	ra,0x1
    80002ce8:	f1c080e7          	jalr	-228(ra) # 80003c00 <uartintr>
    80002cec:	fadff06f          	j	80002c98 <devintr+0xb4>

0000000080002cf0 <kernelvec>:
    80002cf0:	f0010113          	addi	sp,sp,-256
    80002cf4:	00113023          	sd	ra,0(sp)
    80002cf8:	00213423          	sd	sp,8(sp)
    80002cfc:	00313823          	sd	gp,16(sp)
    80002d00:	00413c23          	sd	tp,24(sp)
    80002d04:	02513023          	sd	t0,32(sp)
    80002d08:	02613423          	sd	t1,40(sp)
    80002d0c:	02713823          	sd	t2,48(sp)
    80002d10:	02813c23          	sd	s0,56(sp)
    80002d14:	04913023          	sd	s1,64(sp)
    80002d18:	04a13423          	sd	a0,72(sp)
    80002d1c:	04b13823          	sd	a1,80(sp)
    80002d20:	04c13c23          	sd	a2,88(sp)
    80002d24:	06d13023          	sd	a3,96(sp)
    80002d28:	06e13423          	sd	a4,104(sp)
    80002d2c:	06f13823          	sd	a5,112(sp)
    80002d30:	07013c23          	sd	a6,120(sp)
    80002d34:	09113023          	sd	a7,128(sp)
    80002d38:	09213423          	sd	s2,136(sp)
    80002d3c:	09313823          	sd	s3,144(sp)
    80002d40:	09413c23          	sd	s4,152(sp)
    80002d44:	0b513023          	sd	s5,160(sp)
    80002d48:	0b613423          	sd	s6,168(sp)
    80002d4c:	0b713823          	sd	s7,176(sp)
    80002d50:	0b813c23          	sd	s8,184(sp)
    80002d54:	0d913023          	sd	s9,192(sp)
    80002d58:	0da13423          	sd	s10,200(sp)
    80002d5c:	0db13823          	sd	s11,208(sp)
    80002d60:	0dc13c23          	sd	t3,216(sp)
    80002d64:	0fd13023          	sd	t4,224(sp)
    80002d68:	0fe13423          	sd	t5,232(sp)
    80002d6c:	0ff13823          	sd	t6,240(sp)
    80002d70:	cd5ff0ef          	jal	ra,80002a44 <kerneltrap>
    80002d74:	00013083          	ld	ra,0(sp)
    80002d78:	00813103          	ld	sp,8(sp)
    80002d7c:	01013183          	ld	gp,16(sp)
    80002d80:	02013283          	ld	t0,32(sp)
    80002d84:	02813303          	ld	t1,40(sp)
    80002d88:	03013383          	ld	t2,48(sp)
    80002d8c:	03813403          	ld	s0,56(sp)
    80002d90:	04013483          	ld	s1,64(sp)
    80002d94:	04813503          	ld	a0,72(sp)
    80002d98:	05013583          	ld	a1,80(sp)
    80002d9c:	05813603          	ld	a2,88(sp)
    80002da0:	06013683          	ld	a3,96(sp)
    80002da4:	06813703          	ld	a4,104(sp)
    80002da8:	07013783          	ld	a5,112(sp)
    80002dac:	07813803          	ld	a6,120(sp)
    80002db0:	08013883          	ld	a7,128(sp)
    80002db4:	08813903          	ld	s2,136(sp)
    80002db8:	09013983          	ld	s3,144(sp)
    80002dbc:	09813a03          	ld	s4,152(sp)
    80002dc0:	0a013a83          	ld	s5,160(sp)
    80002dc4:	0a813b03          	ld	s6,168(sp)
    80002dc8:	0b013b83          	ld	s7,176(sp)
    80002dcc:	0b813c03          	ld	s8,184(sp)
    80002dd0:	0c013c83          	ld	s9,192(sp)
    80002dd4:	0c813d03          	ld	s10,200(sp)
    80002dd8:	0d013d83          	ld	s11,208(sp)
    80002ddc:	0d813e03          	ld	t3,216(sp)
    80002de0:	0e013e83          	ld	t4,224(sp)
    80002de4:	0e813f03          	ld	t5,232(sp)
    80002de8:	0f013f83          	ld	t6,240(sp)
    80002dec:	10010113          	addi	sp,sp,256
    80002df0:	10200073          	sret
    80002df4:	00000013          	nop
    80002df8:	00000013          	nop
    80002dfc:	00000013          	nop

0000000080002e00 <timervec>:
    80002e00:	34051573          	csrrw	a0,mscratch,a0
    80002e04:	00b53023          	sd	a1,0(a0)
    80002e08:	00c53423          	sd	a2,8(a0)
    80002e0c:	00d53823          	sd	a3,16(a0)
    80002e10:	01853583          	ld	a1,24(a0)
    80002e14:	02053603          	ld	a2,32(a0)
    80002e18:	0005b683          	ld	a3,0(a1)
    80002e1c:	00c686b3          	add	a3,a3,a2
    80002e20:	00d5b023          	sd	a3,0(a1)
    80002e24:	00200593          	li	a1,2
    80002e28:	14459073          	csrw	sip,a1
    80002e2c:	01053683          	ld	a3,16(a0)
    80002e30:	00853603          	ld	a2,8(a0)
    80002e34:	00053583          	ld	a1,0(a0)
    80002e38:	34051573          	csrrw	a0,mscratch,a0
    80002e3c:	30200073          	mret

0000000080002e40 <plicinit>:
    80002e40:	ff010113          	addi	sp,sp,-16
    80002e44:	00813423          	sd	s0,8(sp)
    80002e48:	01010413          	addi	s0,sp,16
    80002e4c:	00813403          	ld	s0,8(sp)
    80002e50:	0c0007b7          	lui	a5,0xc000
    80002e54:	00100713          	li	a4,1
    80002e58:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002e5c:	00e7a223          	sw	a4,4(a5)
    80002e60:	01010113          	addi	sp,sp,16
    80002e64:	00008067          	ret

0000000080002e68 <plicinithart>:
    80002e68:	ff010113          	addi	sp,sp,-16
    80002e6c:	00813023          	sd	s0,0(sp)
    80002e70:	00113423          	sd	ra,8(sp)
    80002e74:	01010413          	addi	s0,sp,16
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	a4c080e7          	jalr	-1460(ra) # 800028c4 <cpuid>
    80002e80:	0085171b          	slliw	a4,a0,0x8
    80002e84:	0c0027b7          	lui	a5,0xc002
    80002e88:	00e787b3          	add	a5,a5,a4
    80002e8c:	40200713          	li	a4,1026
    80002e90:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002e94:	00813083          	ld	ra,8(sp)
    80002e98:	00013403          	ld	s0,0(sp)
    80002e9c:	00d5151b          	slliw	a0,a0,0xd
    80002ea0:	0c2017b7          	lui	a5,0xc201
    80002ea4:	00a78533          	add	a0,a5,a0
    80002ea8:	00052023          	sw	zero,0(a0)
    80002eac:	01010113          	addi	sp,sp,16
    80002eb0:	00008067          	ret

0000000080002eb4 <plic_claim>:
    80002eb4:	ff010113          	addi	sp,sp,-16
    80002eb8:	00813023          	sd	s0,0(sp)
    80002ebc:	00113423          	sd	ra,8(sp)
    80002ec0:	01010413          	addi	s0,sp,16
    80002ec4:	00000097          	auipc	ra,0x0
    80002ec8:	a00080e7          	jalr	-1536(ra) # 800028c4 <cpuid>
    80002ecc:	00813083          	ld	ra,8(sp)
    80002ed0:	00013403          	ld	s0,0(sp)
    80002ed4:	00d5151b          	slliw	a0,a0,0xd
    80002ed8:	0c2017b7          	lui	a5,0xc201
    80002edc:	00a78533          	add	a0,a5,a0
    80002ee0:	00452503          	lw	a0,4(a0)
    80002ee4:	01010113          	addi	sp,sp,16
    80002ee8:	00008067          	ret

0000000080002eec <plic_complete>:
    80002eec:	fe010113          	addi	sp,sp,-32
    80002ef0:	00813823          	sd	s0,16(sp)
    80002ef4:	00913423          	sd	s1,8(sp)
    80002ef8:	00113c23          	sd	ra,24(sp)
    80002efc:	02010413          	addi	s0,sp,32
    80002f00:	00050493          	mv	s1,a0
    80002f04:	00000097          	auipc	ra,0x0
    80002f08:	9c0080e7          	jalr	-1600(ra) # 800028c4 <cpuid>
    80002f0c:	01813083          	ld	ra,24(sp)
    80002f10:	01013403          	ld	s0,16(sp)
    80002f14:	00d5179b          	slliw	a5,a0,0xd
    80002f18:	0c201737          	lui	a4,0xc201
    80002f1c:	00f707b3          	add	a5,a4,a5
    80002f20:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002f24:	00813483          	ld	s1,8(sp)
    80002f28:	02010113          	addi	sp,sp,32
    80002f2c:	00008067          	ret

0000000080002f30 <consolewrite>:
    80002f30:	fb010113          	addi	sp,sp,-80
    80002f34:	04813023          	sd	s0,64(sp)
    80002f38:	04113423          	sd	ra,72(sp)
    80002f3c:	02913c23          	sd	s1,56(sp)
    80002f40:	03213823          	sd	s2,48(sp)
    80002f44:	03313423          	sd	s3,40(sp)
    80002f48:	03413023          	sd	s4,32(sp)
    80002f4c:	01513c23          	sd	s5,24(sp)
    80002f50:	05010413          	addi	s0,sp,80
    80002f54:	06c05c63          	blez	a2,80002fcc <consolewrite+0x9c>
    80002f58:	00060993          	mv	s3,a2
    80002f5c:	00050a13          	mv	s4,a0
    80002f60:	00058493          	mv	s1,a1
    80002f64:	00000913          	li	s2,0
    80002f68:	fff00a93          	li	s5,-1
    80002f6c:	01c0006f          	j	80002f88 <consolewrite+0x58>
    80002f70:	fbf44503          	lbu	a0,-65(s0)
    80002f74:	0019091b          	addiw	s2,s2,1
    80002f78:	00148493          	addi	s1,s1,1
    80002f7c:	00001097          	auipc	ra,0x1
    80002f80:	a9c080e7          	jalr	-1380(ra) # 80003a18 <uartputc>
    80002f84:	03298063          	beq	s3,s2,80002fa4 <consolewrite+0x74>
    80002f88:	00048613          	mv	a2,s1
    80002f8c:	00100693          	li	a3,1
    80002f90:	000a0593          	mv	a1,s4
    80002f94:	fbf40513          	addi	a0,s0,-65
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	9e4080e7          	jalr	-1564(ra) # 8000297c <either_copyin>
    80002fa0:	fd5518e3          	bne	a0,s5,80002f70 <consolewrite+0x40>
    80002fa4:	04813083          	ld	ra,72(sp)
    80002fa8:	04013403          	ld	s0,64(sp)
    80002fac:	03813483          	ld	s1,56(sp)
    80002fb0:	02813983          	ld	s3,40(sp)
    80002fb4:	02013a03          	ld	s4,32(sp)
    80002fb8:	01813a83          	ld	s5,24(sp)
    80002fbc:	00090513          	mv	a0,s2
    80002fc0:	03013903          	ld	s2,48(sp)
    80002fc4:	05010113          	addi	sp,sp,80
    80002fc8:	00008067          	ret
    80002fcc:	00000913          	li	s2,0
    80002fd0:	fd5ff06f          	j	80002fa4 <consolewrite+0x74>

0000000080002fd4 <consoleread>:
    80002fd4:	f9010113          	addi	sp,sp,-112
    80002fd8:	06813023          	sd	s0,96(sp)
    80002fdc:	04913c23          	sd	s1,88(sp)
    80002fe0:	05213823          	sd	s2,80(sp)
    80002fe4:	05313423          	sd	s3,72(sp)
    80002fe8:	05413023          	sd	s4,64(sp)
    80002fec:	03513c23          	sd	s5,56(sp)
    80002ff0:	03613823          	sd	s6,48(sp)
    80002ff4:	03713423          	sd	s7,40(sp)
    80002ff8:	03813023          	sd	s8,32(sp)
    80002ffc:	06113423          	sd	ra,104(sp)
    80003000:	01913c23          	sd	s9,24(sp)
    80003004:	07010413          	addi	s0,sp,112
    80003008:	00060b93          	mv	s7,a2
    8000300c:	00050913          	mv	s2,a0
    80003010:	00058c13          	mv	s8,a1
    80003014:	00060b1b          	sext.w	s6,a2
    80003018:	00004497          	auipc	s1,0x4
    8000301c:	dc048493          	addi	s1,s1,-576 # 80006dd8 <cons>
    80003020:	00400993          	li	s3,4
    80003024:	fff00a13          	li	s4,-1
    80003028:	00a00a93          	li	s5,10
    8000302c:	05705e63          	blez	s7,80003088 <consoleread+0xb4>
    80003030:	09c4a703          	lw	a4,156(s1)
    80003034:	0984a783          	lw	a5,152(s1)
    80003038:	0007071b          	sext.w	a4,a4
    8000303c:	08e78463          	beq	a5,a4,800030c4 <consoleread+0xf0>
    80003040:	07f7f713          	andi	a4,a5,127
    80003044:	00e48733          	add	a4,s1,a4
    80003048:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000304c:	0017869b          	addiw	a3,a5,1
    80003050:	08d4ac23          	sw	a3,152(s1)
    80003054:	00070c9b          	sext.w	s9,a4
    80003058:	0b370663          	beq	a4,s3,80003104 <consoleread+0x130>
    8000305c:	00100693          	li	a3,1
    80003060:	f9f40613          	addi	a2,s0,-97
    80003064:	000c0593          	mv	a1,s8
    80003068:	00090513          	mv	a0,s2
    8000306c:	f8e40fa3          	sb	a4,-97(s0)
    80003070:	00000097          	auipc	ra,0x0
    80003074:	8c0080e7          	jalr	-1856(ra) # 80002930 <either_copyout>
    80003078:	01450863          	beq	a0,s4,80003088 <consoleread+0xb4>
    8000307c:	001c0c13          	addi	s8,s8,1
    80003080:	fffb8b9b          	addiw	s7,s7,-1
    80003084:	fb5c94e3          	bne	s9,s5,8000302c <consoleread+0x58>
    80003088:	000b851b          	sext.w	a0,s7
    8000308c:	06813083          	ld	ra,104(sp)
    80003090:	06013403          	ld	s0,96(sp)
    80003094:	05813483          	ld	s1,88(sp)
    80003098:	05013903          	ld	s2,80(sp)
    8000309c:	04813983          	ld	s3,72(sp)
    800030a0:	04013a03          	ld	s4,64(sp)
    800030a4:	03813a83          	ld	s5,56(sp)
    800030a8:	02813b83          	ld	s7,40(sp)
    800030ac:	02013c03          	ld	s8,32(sp)
    800030b0:	01813c83          	ld	s9,24(sp)
    800030b4:	40ab053b          	subw	a0,s6,a0
    800030b8:	03013b03          	ld	s6,48(sp)
    800030bc:	07010113          	addi	sp,sp,112
    800030c0:	00008067          	ret
    800030c4:	00001097          	auipc	ra,0x1
    800030c8:	1d8080e7          	jalr	472(ra) # 8000429c <push_on>
    800030cc:	0984a703          	lw	a4,152(s1)
    800030d0:	09c4a783          	lw	a5,156(s1)
    800030d4:	0007879b          	sext.w	a5,a5
    800030d8:	fef70ce3          	beq	a4,a5,800030d0 <consoleread+0xfc>
    800030dc:	00001097          	auipc	ra,0x1
    800030e0:	234080e7          	jalr	564(ra) # 80004310 <pop_on>
    800030e4:	0984a783          	lw	a5,152(s1)
    800030e8:	07f7f713          	andi	a4,a5,127
    800030ec:	00e48733          	add	a4,s1,a4
    800030f0:	01874703          	lbu	a4,24(a4)
    800030f4:	0017869b          	addiw	a3,a5,1
    800030f8:	08d4ac23          	sw	a3,152(s1)
    800030fc:	00070c9b          	sext.w	s9,a4
    80003100:	f5371ee3          	bne	a4,s3,8000305c <consoleread+0x88>
    80003104:	000b851b          	sext.w	a0,s7
    80003108:	f96bf2e3          	bgeu	s7,s6,8000308c <consoleread+0xb8>
    8000310c:	08f4ac23          	sw	a5,152(s1)
    80003110:	f7dff06f          	j	8000308c <consoleread+0xb8>

0000000080003114 <consputc>:
    80003114:	10000793          	li	a5,256
    80003118:	00f50663          	beq	a0,a5,80003124 <consputc+0x10>
    8000311c:	00001317          	auipc	t1,0x1
    80003120:	9f430067          	jr	-1548(t1) # 80003b10 <uartputc_sync>
    80003124:	ff010113          	addi	sp,sp,-16
    80003128:	00113423          	sd	ra,8(sp)
    8000312c:	00813023          	sd	s0,0(sp)
    80003130:	01010413          	addi	s0,sp,16
    80003134:	00800513          	li	a0,8
    80003138:	00001097          	auipc	ra,0x1
    8000313c:	9d8080e7          	jalr	-1576(ra) # 80003b10 <uartputc_sync>
    80003140:	02000513          	li	a0,32
    80003144:	00001097          	auipc	ra,0x1
    80003148:	9cc080e7          	jalr	-1588(ra) # 80003b10 <uartputc_sync>
    8000314c:	00013403          	ld	s0,0(sp)
    80003150:	00813083          	ld	ra,8(sp)
    80003154:	00800513          	li	a0,8
    80003158:	01010113          	addi	sp,sp,16
    8000315c:	00001317          	auipc	t1,0x1
    80003160:	9b430067          	jr	-1612(t1) # 80003b10 <uartputc_sync>

0000000080003164 <consoleintr>:
    80003164:	fe010113          	addi	sp,sp,-32
    80003168:	00813823          	sd	s0,16(sp)
    8000316c:	00913423          	sd	s1,8(sp)
    80003170:	01213023          	sd	s2,0(sp)
    80003174:	00113c23          	sd	ra,24(sp)
    80003178:	02010413          	addi	s0,sp,32
    8000317c:	00004917          	auipc	s2,0x4
    80003180:	c5c90913          	addi	s2,s2,-932 # 80006dd8 <cons>
    80003184:	00050493          	mv	s1,a0
    80003188:	00090513          	mv	a0,s2
    8000318c:	00001097          	auipc	ra,0x1
    80003190:	e40080e7          	jalr	-448(ra) # 80003fcc <acquire>
    80003194:	02048c63          	beqz	s1,800031cc <consoleintr+0x68>
    80003198:	0a092783          	lw	a5,160(s2)
    8000319c:	09892703          	lw	a4,152(s2)
    800031a0:	07f00693          	li	a3,127
    800031a4:	40e7873b          	subw	a4,a5,a4
    800031a8:	02e6e263          	bltu	a3,a4,800031cc <consoleintr+0x68>
    800031ac:	00d00713          	li	a4,13
    800031b0:	04e48063          	beq	s1,a4,800031f0 <consoleintr+0x8c>
    800031b4:	07f7f713          	andi	a4,a5,127
    800031b8:	00e90733          	add	a4,s2,a4
    800031bc:	0017879b          	addiw	a5,a5,1
    800031c0:	0af92023          	sw	a5,160(s2)
    800031c4:	00970c23          	sb	s1,24(a4)
    800031c8:	08f92e23          	sw	a5,156(s2)
    800031cc:	01013403          	ld	s0,16(sp)
    800031d0:	01813083          	ld	ra,24(sp)
    800031d4:	00813483          	ld	s1,8(sp)
    800031d8:	00013903          	ld	s2,0(sp)
    800031dc:	00004517          	auipc	a0,0x4
    800031e0:	bfc50513          	addi	a0,a0,-1028 # 80006dd8 <cons>
    800031e4:	02010113          	addi	sp,sp,32
    800031e8:	00001317          	auipc	t1,0x1
    800031ec:	eb030067          	jr	-336(t1) # 80004098 <release>
    800031f0:	00a00493          	li	s1,10
    800031f4:	fc1ff06f          	j	800031b4 <consoleintr+0x50>

00000000800031f8 <consoleinit>:
    800031f8:	fe010113          	addi	sp,sp,-32
    800031fc:	00113c23          	sd	ra,24(sp)
    80003200:	00813823          	sd	s0,16(sp)
    80003204:	00913423          	sd	s1,8(sp)
    80003208:	02010413          	addi	s0,sp,32
    8000320c:	00004497          	auipc	s1,0x4
    80003210:	bcc48493          	addi	s1,s1,-1076 # 80006dd8 <cons>
    80003214:	00048513          	mv	a0,s1
    80003218:	00002597          	auipc	a1,0x2
    8000321c:	03858593          	addi	a1,a1,56 # 80005250 <_ZZ12printIntegermE6digits+0x138>
    80003220:	00001097          	auipc	ra,0x1
    80003224:	d88080e7          	jalr	-632(ra) # 80003fa8 <initlock>
    80003228:	00000097          	auipc	ra,0x0
    8000322c:	7ac080e7          	jalr	1964(ra) # 800039d4 <uartinit>
    80003230:	01813083          	ld	ra,24(sp)
    80003234:	01013403          	ld	s0,16(sp)
    80003238:	00000797          	auipc	a5,0x0
    8000323c:	d9c78793          	addi	a5,a5,-612 # 80002fd4 <consoleread>
    80003240:	0af4bc23          	sd	a5,184(s1)
    80003244:	00000797          	auipc	a5,0x0
    80003248:	cec78793          	addi	a5,a5,-788 # 80002f30 <consolewrite>
    8000324c:	0cf4b023          	sd	a5,192(s1)
    80003250:	00813483          	ld	s1,8(sp)
    80003254:	02010113          	addi	sp,sp,32
    80003258:	00008067          	ret

000000008000325c <console_read>:
    8000325c:	ff010113          	addi	sp,sp,-16
    80003260:	00813423          	sd	s0,8(sp)
    80003264:	01010413          	addi	s0,sp,16
    80003268:	00813403          	ld	s0,8(sp)
    8000326c:	00004317          	auipc	t1,0x4
    80003270:	c2433303          	ld	t1,-988(t1) # 80006e90 <devsw+0x10>
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00030067          	jr	t1

000000008000327c <console_write>:
    8000327c:	ff010113          	addi	sp,sp,-16
    80003280:	00813423          	sd	s0,8(sp)
    80003284:	01010413          	addi	s0,sp,16
    80003288:	00813403          	ld	s0,8(sp)
    8000328c:	00004317          	auipc	t1,0x4
    80003290:	c0c33303          	ld	t1,-1012(t1) # 80006e98 <devsw+0x18>
    80003294:	01010113          	addi	sp,sp,16
    80003298:	00030067          	jr	t1

000000008000329c <panic>:
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00113c23          	sd	ra,24(sp)
    800032a4:	00813823          	sd	s0,16(sp)
    800032a8:	00913423          	sd	s1,8(sp)
    800032ac:	02010413          	addi	s0,sp,32
    800032b0:	00050493          	mv	s1,a0
    800032b4:	00002517          	auipc	a0,0x2
    800032b8:	fa450513          	addi	a0,a0,-92 # 80005258 <_ZZ12printIntegermE6digits+0x140>
    800032bc:	00004797          	auipc	a5,0x4
    800032c0:	c607ae23          	sw	zero,-900(a5) # 80006f38 <pr+0x18>
    800032c4:	00000097          	auipc	ra,0x0
    800032c8:	034080e7          	jalr	52(ra) # 800032f8 <__printf>
    800032cc:	00048513          	mv	a0,s1
    800032d0:	00000097          	auipc	ra,0x0
    800032d4:	028080e7          	jalr	40(ra) # 800032f8 <__printf>
    800032d8:	00002517          	auipc	a0,0x2
    800032dc:	f6050513          	addi	a0,a0,-160 # 80005238 <_ZZ12printIntegermE6digits+0x120>
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	018080e7          	jalr	24(ra) # 800032f8 <__printf>
    800032e8:	00100793          	li	a5,1
    800032ec:	00003717          	auipc	a4,0x3
    800032f0:	9af72623          	sw	a5,-1620(a4) # 80005c98 <panicked>
    800032f4:	0000006f          	j	800032f4 <panic+0x58>

00000000800032f8 <__printf>:
    800032f8:	f3010113          	addi	sp,sp,-208
    800032fc:	08813023          	sd	s0,128(sp)
    80003300:	07313423          	sd	s3,104(sp)
    80003304:	09010413          	addi	s0,sp,144
    80003308:	05813023          	sd	s8,64(sp)
    8000330c:	08113423          	sd	ra,136(sp)
    80003310:	06913c23          	sd	s1,120(sp)
    80003314:	07213823          	sd	s2,112(sp)
    80003318:	07413023          	sd	s4,96(sp)
    8000331c:	05513c23          	sd	s5,88(sp)
    80003320:	05613823          	sd	s6,80(sp)
    80003324:	05713423          	sd	s7,72(sp)
    80003328:	03913c23          	sd	s9,56(sp)
    8000332c:	03a13823          	sd	s10,48(sp)
    80003330:	03b13423          	sd	s11,40(sp)
    80003334:	00004317          	auipc	t1,0x4
    80003338:	bec30313          	addi	t1,t1,-1044 # 80006f20 <pr>
    8000333c:	01832c03          	lw	s8,24(t1)
    80003340:	00b43423          	sd	a1,8(s0)
    80003344:	00c43823          	sd	a2,16(s0)
    80003348:	00d43c23          	sd	a3,24(s0)
    8000334c:	02e43023          	sd	a4,32(s0)
    80003350:	02f43423          	sd	a5,40(s0)
    80003354:	03043823          	sd	a6,48(s0)
    80003358:	03143c23          	sd	a7,56(s0)
    8000335c:	00050993          	mv	s3,a0
    80003360:	4a0c1663          	bnez	s8,8000380c <__printf+0x514>
    80003364:	60098c63          	beqz	s3,8000397c <__printf+0x684>
    80003368:	0009c503          	lbu	a0,0(s3)
    8000336c:	00840793          	addi	a5,s0,8
    80003370:	f6f43c23          	sd	a5,-136(s0)
    80003374:	00000493          	li	s1,0
    80003378:	22050063          	beqz	a0,80003598 <__printf+0x2a0>
    8000337c:	00002a37          	lui	s4,0x2
    80003380:	00018ab7          	lui	s5,0x18
    80003384:	000f4b37          	lui	s6,0xf4
    80003388:	00989bb7          	lui	s7,0x989
    8000338c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003390:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003394:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003398:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000339c:	00148c9b          	addiw	s9,s1,1
    800033a0:	02500793          	li	a5,37
    800033a4:	01998933          	add	s2,s3,s9
    800033a8:	38f51263          	bne	a0,a5,8000372c <__printf+0x434>
    800033ac:	00094783          	lbu	a5,0(s2)
    800033b0:	00078c9b          	sext.w	s9,a5
    800033b4:	1e078263          	beqz	a5,80003598 <__printf+0x2a0>
    800033b8:	0024849b          	addiw	s1,s1,2
    800033bc:	07000713          	li	a4,112
    800033c0:	00998933          	add	s2,s3,s1
    800033c4:	38e78a63          	beq	a5,a4,80003758 <__printf+0x460>
    800033c8:	20f76863          	bltu	a4,a5,800035d8 <__printf+0x2e0>
    800033cc:	42a78863          	beq	a5,a0,800037fc <__printf+0x504>
    800033d0:	06400713          	li	a4,100
    800033d4:	40e79663          	bne	a5,a4,800037e0 <__printf+0x4e8>
    800033d8:	f7843783          	ld	a5,-136(s0)
    800033dc:	0007a603          	lw	a2,0(a5)
    800033e0:	00878793          	addi	a5,a5,8
    800033e4:	f6f43c23          	sd	a5,-136(s0)
    800033e8:	42064a63          	bltz	a2,8000381c <__printf+0x524>
    800033ec:	00a00713          	li	a4,10
    800033f0:	02e677bb          	remuw	a5,a2,a4
    800033f4:	00002d97          	auipc	s11,0x2
    800033f8:	e8cd8d93          	addi	s11,s11,-372 # 80005280 <digits>
    800033fc:	00900593          	li	a1,9
    80003400:	0006051b          	sext.w	a0,a2
    80003404:	00000c93          	li	s9,0
    80003408:	02079793          	slli	a5,a5,0x20
    8000340c:	0207d793          	srli	a5,a5,0x20
    80003410:	00fd87b3          	add	a5,s11,a5
    80003414:	0007c783          	lbu	a5,0(a5)
    80003418:	02e656bb          	divuw	a3,a2,a4
    8000341c:	f8f40023          	sb	a5,-128(s0)
    80003420:	14c5d863          	bge	a1,a2,80003570 <__printf+0x278>
    80003424:	06300593          	li	a1,99
    80003428:	00100c93          	li	s9,1
    8000342c:	02e6f7bb          	remuw	a5,a3,a4
    80003430:	02079793          	slli	a5,a5,0x20
    80003434:	0207d793          	srli	a5,a5,0x20
    80003438:	00fd87b3          	add	a5,s11,a5
    8000343c:	0007c783          	lbu	a5,0(a5)
    80003440:	02e6d73b          	divuw	a4,a3,a4
    80003444:	f8f400a3          	sb	a5,-127(s0)
    80003448:	12a5f463          	bgeu	a1,a0,80003570 <__printf+0x278>
    8000344c:	00a00693          	li	a3,10
    80003450:	00900593          	li	a1,9
    80003454:	02d777bb          	remuw	a5,a4,a3
    80003458:	02079793          	slli	a5,a5,0x20
    8000345c:	0207d793          	srli	a5,a5,0x20
    80003460:	00fd87b3          	add	a5,s11,a5
    80003464:	0007c503          	lbu	a0,0(a5)
    80003468:	02d757bb          	divuw	a5,a4,a3
    8000346c:	f8a40123          	sb	a0,-126(s0)
    80003470:	48e5f263          	bgeu	a1,a4,800038f4 <__printf+0x5fc>
    80003474:	06300513          	li	a0,99
    80003478:	02d7f5bb          	remuw	a1,a5,a3
    8000347c:	02059593          	slli	a1,a1,0x20
    80003480:	0205d593          	srli	a1,a1,0x20
    80003484:	00bd85b3          	add	a1,s11,a1
    80003488:	0005c583          	lbu	a1,0(a1)
    8000348c:	02d7d7bb          	divuw	a5,a5,a3
    80003490:	f8b401a3          	sb	a1,-125(s0)
    80003494:	48e57263          	bgeu	a0,a4,80003918 <__printf+0x620>
    80003498:	3e700513          	li	a0,999
    8000349c:	02d7f5bb          	remuw	a1,a5,a3
    800034a0:	02059593          	slli	a1,a1,0x20
    800034a4:	0205d593          	srli	a1,a1,0x20
    800034a8:	00bd85b3          	add	a1,s11,a1
    800034ac:	0005c583          	lbu	a1,0(a1)
    800034b0:	02d7d7bb          	divuw	a5,a5,a3
    800034b4:	f8b40223          	sb	a1,-124(s0)
    800034b8:	46e57663          	bgeu	a0,a4,80003924 <__printf+0x62c>
    800034bc:	02d7f5bb          	remuw	a1,a5,a3
    800034c0:	02059593          	slli	a1,a1,0x20
    800034c4:	0205d593          	srli	a1,a1,0x20
    800034c8:	00bd85b3          	add	a1,s11,a1
    800034cc:	0005c583          	lbu	a1,0(a1)
    800034d0:	02d7d7bb          	divuw	a5,a5,a3
    800034d4:	f8b402a3          	sb	a1,-123(s0)
    800034d8:	46ea7863          	bgeu	s4,a4,80003948 <__printf+0x650>
    800034dc:	02d7f5bb          	remuw	a1,a5,a3
    800034e0:	02059593          	slli	a1,a1,0x20
    800034e4:	0205d593          	srli	a1,a1,0x20
    800034e8:	00bd85b3          	add	a1,s11,a1
    800034ec:	0005c583          	lbu	a1,0(a1)
    800034f0:	02d7d7bb          	divuw	a5,a5,a3
    800034f4:	f8b40323          	sb	a1,-122(s0)
    800034f8:	3eeaf863          	bgeu	s5,a4,800038e8 <__printf+0x5f0>
    800034fc:	02d7f5bb          	remuw	a1,a5,a3
    80003500:	02059593          	slli	a1,a1,0x20
    80003504:	0205d593          	srli	a1,a1,0x20
    80003508:	00bd85b3          	add	a1,s11,a1
    8000350c:	0005c583          	lbu	a1,0(a1)
    80003510:	02d7d7bb          	divuw	a5,a5,a3
    80003514:	f8b403a3          	sb	a1,-121(s0)
    80003518:	42eb7e63          	bgeu	s6,a4,80003954 <__printf+0x65c>
    8000351c:	02d7f5bb          	remuw	a1,a5,a3
    80003520:	02059593          	slli	a1,a1,0x20
    80003524:	0205d593          	srli	a1,a1,0x20
    80003528:	00bd85b3          	add	a1,s11,a1
    8000352c:	0005c583          	lbu	a1,0(a1)
    80003530:	02d7d7bb          	divuw	a5,a5,a3
    80003534:	f8b40423          	sb	a1,-120(s0)
    80003538:	42ebfc63          	bgeu	s7,a4,80003970 <__printf+0x678>
    8000353c:	02079793          	slli	a5,a5,0x20
    80003540:	0207d793          	srli	a5,a5,0x20
    80003544:	00fd8db3          	add	s11,s11,a5
    80003548:	000dc703          	lbu	a4,0(s11)
    8000354c:	00a00793          	li	a5,10
    80003550:	00900c93          	li	s9,9
    80003554:	f8e404a3          	sb	a4,-119(s0)
    80003558:	00065c63          	bgez	a2,80003570 <__printf+0x278>
    8000355c:	f9040713          	addi	a4,s0,-112
    80003560:	00f70733          	add	a4,a4,a5
    80003564:	02d00693          	li	a3,45
    80003568:	fed70823          	sb	a3,-16(a4)
    8000356c:	00078c93          	mv	s9,a5
    80003570:	f8040793          	addi	a5,s0,-128
    80003574:	01978cb3          	add	s9,a5,s9
    80003578:	f7f40d13          	addi	s10,s0,-129
    8000357c:	000cc503          	lbu	a0,0(s9)
    80003580:	fffc8c93          	addi	s9,s9,-1
    80003584:	00000097          	auipc	ra,0x0
    80003588:	b90080e7          	jalr	-1136(ra) # 80003114 <consputc>
    8000358c:	ffac98e3          	bne	s9,s10,8000357c <__printf+0x284>
    80003590:	00094503          	lbu	a0,0(s2)
    80003594:	e00514e3          	bnez	a0,8000339c <__printf+0xa4>
    80003598:	1a0c1663          	bnez	s8,80003744 <__printf+0x44c>
    8000359c:	08813083          	ld	ra,136(sp)
    800035a0:	08013403          	ld	s0,128(sp)
    800035a4:	07813483          	ld	s1,120(sp)
    800035a8:	07013903          	ld	s2,112(sp)
    800035ac:	06813983          	ld	s3,104(sp)
    800035b0:	06013a03          	ld	s4,96(sp)
    800035b4:	05813a83          	ld	s5,88(sp)
    800035b8:	05013b03          	ld	s6,80(sp)
    800035bc:	04813b83          	ld	s7,72(sp)
    800035c0:	04013c03          	ld	s8,64(sp)
    800035c4:	03813c83          	ld	s9,56(sp)
    800035c8:	03013d03          	ld	s10,48(sp)
    800035cc:	02813d83          	ld	s11,40(sp)
    800035d0:	0d010113          	addi	sp,sp,208
    800035d4:	00008067          	ret
    800035d8:	07300713          	li	a4,115
    800035dc:	1ce78a63          	beq	a5,a4,800037b0 <__printf+0x4b8>
    800035e0:	07800713          	li	a4,120
    800035e4:	1ee79e63          	bne	a5,a4,800037e0 <__printf+0x4e8>
    800035e8:	f7843783          	ld	a5,-136(s0)
    800035ec:	0007a703          	lw	a4,0(a5)
    800035f0:	00878793          	addi	a5,a5,8
    800035f4:	f6f43c23          	sd	a5,-136(s0)
    800035f8:	28074263          	bltz	a4,8000387c <__printf+0x584>
    800035fc:	00002d97          	auipc	s11,0x2
    80003600:	c84d8d93          	addi	s11,s11,-892 # 80005280 <digits>
    80003604:	00f77793          	andi	a5,a4,15
    80003608:	00fd87b3          	add	a5,s11,a5
    8000360c:	0007c683          	lbu	a3,0(a5)
    80003610:	00f00613          	li	a2,15
    80003614:	0007079b          	sext.w	a5,a4
    80003618:	f8d40023          	sb	a3,-128(s0)
    8000361c:	0047559b          	srliw	a1,a4,0x4
    80003620:	0047569b          	srliw	a3,a4,0x4
    80003624:	00000c93          	li	s9,0
    80003628:	0ee65063          	bge	a2,a4,80003708 <__printf+0x410>
    8000362c:	00f6f693          	andi	a3,a3,15
    80003630:	00dd86b3          	add	a3,s11,a3
    80003634:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003638:	0087d79b          	srliw	a5,a5,0x8
    8000363c:	00100c93          	li	s9,1
    80003640:	f8d400a3          	sb	a3,-127(s0)
    80003644:	0cb67263          	bgeu	a2,a1,80003708 <__printf+0x410>
    80003648:	00f7f693          	andi	a3,a5,15
    8000364c:	00dd86b3          	add	a3,s11,a3
    80003650:	0006c583          	lbu	a1,0(a3)
    80003654:	00f00613          	li	a2,15
    80003658:	0047d69b          	srliw	a3,a5,0x4
    8000365c:	f8b40123          	sb	a1,-126(s0)
    80003660:	0047d593          	srli	a1,a5,0x4
    80003664:	28f67e63          	bgeu	a2,a5,80003900 <__printf+0x608>
    80003668:	00f6f693          	andi	a3,a3,15
    8000366c:	00dd86b3          	add	a3,s11,a3
    80003670:	0006c503          	lbu	a0,0(a3)
    80003674:	0087d813          	srli	a6,a5,0x8
    80003678:	0087d69b          	srliw	a3,a5,0x8
    8000367c:	f8a401a3          	sb	a0,-125(s0)
    80003680:	28b67663          	bgeu	a2,a1,8000390c <__printf+0x614>
    80003684:	00f6f693          	andi	a3,a3,15
    80003688:	00dd86b3          	add	a3,s11,a3
    8000368c:	0006c583          	lbu	a1,0(a3)
    80003690:	00c7d513          	srli	a0,a5,0xc
    80003694:	00c7d69b          	srliw	a3,a5,0xc
    80003698:	f8b40223          	sb	a1,-124(s0)
    8000369c:	29067a63          	bgeu	a2,a6,80003930 <__printf+0x638>
    800036a0:	00f6f693          	andi	a3,a3,15
    800036a4:	00dd86b3          	add	a3,s11,a3
    800036a8:	0006c583          	lbu	a1,0(a3)
    800036ac:	0107d813          	srli	a6,a5,0x10
    800036b0:	0107d69b          	srliw	a3,a5,0x10
    800036b4:	f8b402a3          	sb	a1,-123(s0)
    800036b8:	28a67263          	bgeu	a2,a0,8000393c <__printf+0x644>
    800036bc:	00f6f693          	andi	a3,a3,15
    800036c0:	00dd86b3          	add	a3,s11,a3
    800036c4:	0006c683          	lbu	a3,0(a3)
    800036c8:	0147d79b          	srliw	a5,a5,0x14
    800036cc:	f8d40323          	sb	a3,-122(s0)
    800036d0:	21067663          	bgeu	a2,a6,800038dc <__printf+0x5e4>
    800036d4:	02079793          	slli	a5,a5,0x20
    800036d8:	0207d793          	srli	a5,a5,0x20
    800036dc:	00fd8db3          	add	s11,s11,a5
    800036e0:	000dc683          	lbu	a3,0(s11)
    800036e4:	00800793          	li	a5,8
    800036e8:	00700c93          	li	s9,7
    800036ec:	f8d403a3          	sb	a3,-121(s0)
    800036f0:	00075c63          	bgez	a4,80003708 <__printf+0x410>
    800036f4:	f9040713          	addi	a4,s0,-112
    800036f8:	00f70733          	add	a4,a4,a5
    800036fc:	02d00693          	li	a3,45
    80003700:	fed70823          	sb	a3,-16(a4)
    80003704:	00078c93          	mv	s9,a5
    80003708:	f8040793          	addi	a5,s0,-128
    8000370c:	01978cb3          	add	s9,a5,s9
    80003710:	f7f40d13          	addi	s10,s0,-129
    80003714:	000cc503          	lbu	a0,0(s9)
    80003718:	fffc8c93          	addi	s9,s9,-1
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	9f8080e7          	jalr	-1544(ra) # 80003114 <consputc>
    80003724:	ff9d18e3          	bne	s10,s9,80003714 <__printf+0x41c>
    80003728:	0100006f          	j	80003738 <__printf+0x440>
    8000372c:	00000097          	auipc	ra,0x0
    80003730:	9e8080e7          	jalr	-1560(ra) # 80003114 <consputc>
    80003734:	000c8493          	mv	s1,s9
    80003738:	00094503          	lbu	a0,0(s2)
    8000373c:	c60510e3          	bnez	a0,8000339c <__printf+0xa4>
    80003740:	e40c0ee3          	beqz	s8,8000359c <__printf+0x2a4>
    80003744:	00003517          	auipc	a0,0x3
    80003748:	7dc50513          	addi	a0,a0,2012 # 80006f20 <pr>
    8000374c:	00001097          	auipc	ra,0x1
    80003750:	94c080e7          	jalr	-1716(ra) # 80004098 <release>
    80003754:	e49ff06f          	j	8000359c <__printf+0x2a4>
    80003758:	f7843783          	ld	a5,-136(s0)
    8000375c:	03000513          	li	a0,48
    80003760:	01000d13          	li	s10,16
    80003764:	00878713          	addi	a4,a5,8
    80003768:	0007bc83          	ld	s9,0(a5)
    8000376c:	f6e43c23          	sd	a4,-136(s0)
    80003770:	00000097          	auipc	ra,0x0
    80003774:	9a4080e7          	jalr	-1628(ra) # 80003114 <consputc>
    80003778:	07800513          	li	a0,120
    8000377c:	00000097          	auipc	ra,0x0
    80003780:	998080e7          	jalr	-1640(ra) # 80003114 <consputc>
    80003784:	00002d97          	auipc	s11,0x2
    80003788:	afcd8d93          	addi	s11,s11,-1284 # 80005280 <digits>
    8000378c:	03ccd793          	srli	a5,s9,0x3c
    80003790:	00fd87b3          	add	a5,s11,a5
    80003794:	0007c503          	lbu	a0,0(a5)
    80003798:	fffd0d1b          	addiw	s10,s10,-1
    8000379c:	004c9c93          	slli	s9,s9,0x4
    800037a0:	00000097          	auipc	ra,0x0
    800037a4:	974080e7          	jalr	-1676(ra) # 80003114 <consputc>
    800037a8:	fe0d12e3          	bnez	s10,8000378c <__printf+0x494>
    800037ac:	f8dff06f          	j	80003738 <__printf+0x440>
    800037b0:	f7843783          	ld	a5,-136(s0)
    800037b4:	0007bc83          	ld	s9,0(a5)
    800037b8:	00878793          	addi	a5,a5,8
    800037bc:	f6f43c23          	sd	a5,-136(s0)
    800037c0:	000c9a63          	bnez	s9,800037d4 <__printf+0x4dc>
    800037c4:	1080006f          	j	800038cc <__printf+0x5d4>
    800037c8:	001c8c93          	addi	s9,s9,1
    800037cc:	00000097          	auipc	ra,0x0
    800037d0:	948080e7          	jalr	-1720(ra) # 80003114 <consputc>
    800037d4:	000cc503          	lbu	a0,0(s9)
    800037d8:	fe0518e3          	bnez	a0,800037c8 <__printf+0x4d0>
    800037dc:	f5dff06f          	j	80003738 <__printf+0x440>
    800037e0:	02500513          	li	a0,37
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	930080e7          	jalr	-1744(ra) # 80003114 <consputc>
    800037ec:	000c8513          	mv	a0,s9
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	924080e7          	jalr	-1756(ra) # 80003114 <consputc>
    800037f8:	f41ff06f          	j	80003738 <__printf+0x440>
    800037fc:	02500513          	li	a0,37
    80003800:	00000097          	auipc	ra,0x0
    80003804:	914080e7          	jalr	-1772(ra) # 80003114 <consputc>
    80003808:	f31ff06f          	j	80003738 <__printf+0x440>
    8000380c:	00030513          	mv	a0,t1
    80003810:	00000097          	auipc	ra,0x0
    80003814:	7bc080e7          	jalr	1980(ra) # 80003fcc <acquire>
    80003818:	b4dff06f          	j	80003364 <__printf+0x6c>
    8000381c:	40c0053b          	negw	a0,a2
    80003820:	00a00713          	li	a4,10
    80003824:	02e576bb          	remuw	a3,a0,a4
    80003828:	00002d97          	auipc	s11,0x2
    8000382c:	a58d8d93          	addi	s11,s11,-1448 # 80005280 <digits>
    80003830:	ff700593          	li	a1,-9
    80003834:	02069693          	slli	a3,a3,0x20
    80003838:	0206d693          	srli	a3,a3,0x20
    8000383c:	00dd86b3          	add	a3,s11,a3
    80003840:	0006c683          	lbu	a3,0(a3)
    80003844:	02e557bb          	divuw	a5,a0,a4
    80003848:	f8d40023          	sb	a3,-128(s0)
    8000384c:	10b65e63          	bge	a2,a1,80003968 <__printf+0x670>
    80003850:	06300593          	li	a1,99
    80003854:	02e7f6bb          	remuw	a3,a5,a4
    80003858:	02069693          	slli	a3,a3,0x20
    8000385c:	0206d693          	srli	a3,a3,0x20
    80003860:	00dd86b3          	add	a3,s11,a3
    80003864:	0006c683          	lbu	a3,0(a3)
    80003868:	02e7d73b          	divuw	a4,a5,a4
    8000386c:	00200793          	li	a5,2
    80003870:	f8d400a3          	sb	a3,-127(s0)
    80003874:	bca5ece3          	bltu	a1,a0,8000344c <__printf+0x154>
    80003878:	ce5ff06f          	j	8000355c <__printf+0x264>
    8000387c:	40e007bb          	negw	a5,a4
    80003880:	00002d97          	auipc	s11,0x2
    80003884:	a00d8d93          	addi	s11,s11,-1536 # 80005280 <digits>
    80003888:	00f7f693          	andi	a3,a5,15
    8000388c:	00dd86b3          	add	a3,s11,a3
    80003890:	0006c583          	lbu	a1,0(a3)
    80003894:	ff100613          	li	a2,-15
    80003898:	0047d69b          	srliw	a3,a5,0x4
    8000389c:	f8b40023          	sb	a1,-128(s0)
    800038a0:	0047d59b          	srliw	a1,a5,0x4
    800038a4:	0ac75e63          	bge	a4,a2,80003960 <__printf+0x668>
    800038a8:	00f6f693          	andi	a3,a3,15
    800038ac:	00dd86b3          	add	a3,s11,a3
    800038b0:	0006c603          	lbu	a2,0(a3)
    800038b4:	00f00693          	li	a3,15
    800038b8:	0087d79b          	srliw	a5,a5,0x8
    800038bc:	f8c400a3          	sb	a2,-127(s0)
    800038c0:	d8b6e4e3          	bltu	a3,a1,80003648 <__printf+0x350>
    800038c4:	00200793          	li	a5,2
    800038c8:	e2dff06f          	j	800036f4 <__printf+0x3fc>
    800038cc:	00002c97          	auipc	s9,0x2
    800038d0:	994c8c93          	addi	s9,s9,-1644 # 80005260 <_ZZ12printIntegermE6digits+0x148>
    800038d4:	02800513          	li	a0,40
    800038d8:	ef1ff06f          	j	800037c8 <__printf+0x4d0>
    800038dc:	00700793          	li	a5,7
    800038e0:	00600c93          	li	s9,6
    800038e4:	e0dff06f          	j	800036f0 <__printf+0x3f8>
    800038e8:	00700793          	li	a5,7
    800038ec:	00600c93          	li	s9,6
    800038f0:	c69ff06f          	j	80003558 <__printf+0x260>
    800038f4:	00300793          	li	a5,3
    800038f8:	00200c93          	li	s9,2
    800038fc:	c5dff06f          	j	80003558 <__printf+0x260>
    80003900:	00300793          	li	a5,3
    80003904:	00200c93          	li	s9,2
    80003908:	de9ff06f          	j	800036f0 <__printf+0x3f8>
    8000390c:	00400793          	li	a5,4
    80003910:	00300c93          	li	s9,3
    80003914:	dddff06f          	j	800036f0 <__printf+0x3f8>
    80003918:	00400793          	li	a5,4
    8000391c:	00300c93          	li	s9,3
    80003920:	c39ff06f          	j	80003558 <__printf+0x260>
    80003924:	00500793          	li	a5,5
    80003928:	00400c93          	li	s9,4
    8000392c:	c2dff06f          	j	80003558 <__printf+0x260>
    80003930:	00500793          	li	a5,5
    80003934:	00400c93          	li	s9,4
    80003938:	db9ff06f          	j	800036f0 <__printf+0x3f8>
    8000393c:	00600793          	li	a5,6
    80003940:	00500c93          	li	s9,5
    80003944:	dadff06f          	j	800036f0 <__printf+0x3f8>
    80003948:	00600793          	li	a5,6
    8000394c:	00500c93          	li	s9,5
    80003950:	c09ff06f          	j	80003558 <__printf+0x260>
    80003954:	00800793          	li	a5,8
    80003958:	00700c93          	li	s9,7
    8000395c:	bfdff06f          	j	80003558 <__printf+0x260>
    80003960:	00100793          	li	a5,1
    80003964:	d91ff06f          	j	800036f4 <__printf+0x3fc>
    80003968:	00100793          	li	a5,1
    8000396c:	bf1ff06f          	j	8000355c <__printf+0x264>
    80003970:	00900793          	li	a5,9
    80003974:	00800c93          	li	s9,8
    80003978:	be1ff06f          	j	80003558 <__printf+0x260>
    8000397c:	00002517          	auipc	a0,0x2
    80003980:	8ec50513          	addi	a0,a0,-1812 # 80005268 <_ZZ12printIntegermE6digits+0x150>
    80003984:	00000097          	auipc	ra,0x0
    80003988:	918080e7          	jalr	-1768(ra) # 8000329c <panic>

000000008000398c <printfinit>:
    8000398c:	fe010113          	addi	sp,sp,-32
    80003990:	00813823          	sd	s0,16(sp)
    80003994:	00913423          	sd	s1,8(sp)
    80003998:	00113c23          	sd	ra,24(sp)
    8000399c:	02010413          	addi	s0,sp,32
    800039a0:	00003497          	auipc	s1,0x3
    800039a4:	58048493          	addi	s1,s1,1408 # 80006f20 <pr>
    800039a8:	00048513          	mv	a0,s1
    800039ac:	00002597          	auipc	a1,0x2
    800039b0:	8cc58593          	addi	a1,a1,-1844 # 80005278 <_ZZ12printIntegermE6digits+0x160>
    800039b4:	00000097          	auipc	ra,0x0
    800039b8:	5f4080e7          	jalr	1524(ra) # 80003fa8 <initlock>
    800039bc:	01813083          	ld	ra,24(sp)
    800039c0:	01013403          	ld	s0,16(sp)
    800039c4:	0004ac23          	sw	zero,24(s1)
    800039c8:	00813483          	ld	s1,8(sp)
    800039cc:	02010113          	addi	sp,sp,32
    800039d0:	00008067          	ret

00000000800039d4 <uartinit>:
    800039d4:	ff010113          	addi	sp,sp,-16
    800039d8:	00813423          	sd	s0,8(sp)
    800039dc:	01010413          	addi	s0,sp,16
    800039e0:	100007b7          	lui	a5,0x10000
    800039e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800039e8:	f8000713          	li	a4,-128
    800039ec:	00e781a3          	sb	a4,3(a5)
    800039f0:	00300713          	li	a4,3
    800039f4:	00e78023          	sb	a4,0(a5)
    800039f8:	000780a3          	sb	zero,1(a5)
    800039fc:	00e781a3          	sb	a4,3(a5)
    80003a00:	00700693          	li	a3,7
    80003a04:	00d78123          	sb	a3,2(a5)
    80003a08:	00e780a3          	sb	a4,1(a5)
    80003a0c:	00813403          	ld	s0,8(sp)
    80003a10:	01010113          	addi	sp,sp,16
    80003a14:	00008067          	ret

0000000080003a18 <uartputc>:
    80003a18:	00002797          	auipc	a5,0x2
    80003a1c:	2807a783          	lw	a5,640(a5) # 80005c98 <panicked>
    80003a20:	00078463          	beqz	a5,80003a28 <uartputc+0x10>
    80003a24:	0000006f          	j	80003a24 <uartputc+0xc>
    80003a28:	fd010113          	addi	sp,sp,-48
    80003a2c:	02813023          	sd	s0,32(sp)
    80003a30:	00913c23          	sd	s1,24(sp)
    80003a34:	01213823          	sd	s2,16(sp)
    80003a38:	01313423          	sd	s3,8(sp)
    80003a3c:	02113423          	sd	ra,40(sp)
    80003a40:	03010413          	addi	s0,sp,48
    80003a44:	00002917          	auipc	s2,0x2
    80003a48:	25c90913          	addi	s2,s2,604 # 80005ca0 <uart_tx_r>
    80003a4c:	00093783          	ld	a5,0(s2)
    80003a50:	00002497          	auipc	s1,0x2
    80003a54:	25848493          	addi	s1,s1,600 # 80005ca8 <uart_tx_w>
    80003a58:	0004b703          	ld	a4,0(s1)
    80003a5c:	02078693          	addi	a3,a5,32
    80003a60:	00050993          	mv	s3,a0
    80003a64:	02e69c63          	bne	a3,a4,80003a9c <uartputc+0x84>
    80003a68:	00001097          	auipc	ra,0x1
    80003a6c:	834080e7          	jalr	-1996(ra) # 8000429c <push_on>
    80003a70:	00093783          	ld	a5,0(s2)
    80003a74:	0004b703          	ld	a4,0(s1)
    80003a78:	02078793          	addi	a5,a5,32
    80003a7c:	00e79463          	bne	a5,a4,80003a84 <uartputc+0x6c>
    80003a80:	0000006f          	j	80003a80 <uartputc+0x68>
    80003a84:	00001097          	auipc	ra,0x1
    80003a88:	88c080e7          	jalr	-1908(ra) # 80004310 <pop_on>
    80003a8c:	00093783          	ld	a5,0(s2)
    80003a90:	0004b703          	ld	a4,0(s1)
    80003a94:	02078693          	addi	a3,a5,32
    80003a98:	fce688e3          	beq	a3,a4,80003a68 <uartputc+0x50>
    80003a9c:	01f77693          	andi	a3,a4,31
    80003aa0:	00003597          	auipc	a1,0x3
    80003aa4:	4a058593          	addi	a1,a1,1184 # 80006f40 <uart_tx_buf>
    80003aa8:	00d586b3          	add	a3,a1,a3
    80003aac:	00170713          	addi	a4,a4,1
    80003ab0:	01368023          	sb	s3,0(a3)
    80003ab4:	00e4b023          	sd	a4,0(s1)
    80003ab8:	10000637          	lui	a2,0x10000
    80003abc:	02f71063          	bne	a4,a5,80003adc <uartputc+0xc4>
    80003ac0:	0340006f          	j	80003af4 <uartputc+0xdc>
    80003ac4:	00074703          	lbu	a4,0(a4)
    80003ac8:	00f93023          	sd	a5,0(s2)
    80003acc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003ad0:	00093783          	ld	a5,0(s2)
    80003ad4:	0004b703          	ld	a4,0(s1)
    80003ad8:	00f70e63          	beq	a4,a5,80003af4 <uartputc+0xdc>
    80003adc:	00564683          	lbu	a3,5(a2)
    80003ae0:	01f7f713          	andi	a4,a5,31
    80003ae4:	00e58733          	add	a4,a1,a4
    80003ae8:	0206f693          	andi	a3,a3,32
    80003aec:	00178793          	addi	a5,a5,1
    80003af0:	fc069ae3          	bnez	a3,80003ac4 <uartputc+0xac>
    80003af4:	02813083          	ld	ra,40(sp)
    80003af8:	02013403          	ld	s0,32(sp)
    80003afc:	01813483          	ld	s1,24(sp)
    80003b00:	01013903          	ld	s2,16(sp)
    80003b04:	00813983          	ld	s3,8(sp)
    80003b08:	03010113          	addi	sp,sp,48
    80003b0c:	00008067          	ret

0000000080003b10 <uartputc_sync>:
    80003b10:	ff010113          	addi	sp,sp,-16
    80003b14:	00813423          	sd	s0,8(sp)
    80003b18:	01010413          	addi	s0,sp,16
    80003b1c:	00002717          	auipc	a4,0x2
    80003b20:	17c72703          	lw	a4,380(a4) # 80005c98 <panicked>
    80003b24:	02071663          	bnez	a4,80003b50 <uartputc_sync+0x40>
    80003b28:	00050793          	mv	a5,a0
    80003b2c:	100006b7          	lui	a3,0x10000
    80003b30:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003b34:	02077713          	andi	a4,a4,32
    80003b38:	fe070ce3          	beqz	a4,80003b30 <uartputc_sync+0x20>
    80003b3c:	0ff7f793          	andi	a5,a5,255
    80003b40:	00f68023          	sb	a5,0(a3)
    80003b44:	00813403          	ld	s0,8(sp)
    80003b48:	01010113          	addi	sp,sp,16
    80003b4c:	00008067          	ret
    80003b50:	0000006f          	j	80003b50 <uartputc_sync+0x40>

0000000080003b54 <uartstart>:
    80003b54:	ff010113          	addi	sp,sp,-16
    80003b58:	00813423          	sd	s0,8(sp)
    80003b5c:	01010413          	addi	s0,sp,16
    80003b60:	00002617          	auipc	a2,0x2
    80003b64:	14060613          	addi	a2,a2,320 # 80005ca0 <uart_tx_r>
    80003b68:	00002517          	auipc	a0,0x2
    80003b6c:	14050513          	addi	a0,a0,320 # 80005ca8 <uart_tx_w>
    80003b70:	00063783          	ld	a5,0(a2)
    80003b74:	00053703          	ld	a4,0(a0)
    80003b78:	04f70263          	beq	a4,a5,80003bbc <uartstart+0x68>
    80003b7c:	100005b7          	lui	a1,0x10000
    80003b80:	00003817          	auipc	a6,0x3
    80003b84:	3c080813          	addi	a6,a6,960 # 80006f40 <uart_tx_buf>
    80003b88:	01c0006f          	j	80003ba4 <uartstart+0x50>
    80003b8c:	0006c703          	lbu	a4,0(a3)
    80003b90:	00f63023          	sd	a5,0(a2)
    80003b94:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003b98:	00063783          	ld	a5,0(a2)
    80003b9c:	00053703          	ld	a4,0(a0)
    80003ba0:	00f70e63          	beq	a4,a5,80003bbc <uartstart+0x68>
    80003ba4:	01f7f713          	andi	a4,a5,31
    80003ba8:	00e806b3          	add	a3,a6,a4
    80003bac:	0055c703          	lbu	a4,5(a1)
    80003bb0:	00178793          	addi	a5,a5,1
    80003bb4:	02077713          	andi	a4,a4,32
    80003bb8:	fc071ae3          	bnez	a4,80003b8c <uartstart+0x38>
    80003bbc:	00813403          	ld	s0,8(sp)
    80003bc0:	01010113          	addi	sp,sp,16
    80003bc4:	00008067          	ret

0000000080003bc8 <uartgetc>:
    80003bc8:	ff010113          	addi	sp,sp,-16
    80003bcc:	00813423          	sd	s0,8(sp)
    80003bd0:	01010413          	addi	s0,sp,16
    80003bd4:	10000737          	lui	a4,0x10000
    80003bd8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003bdc:	0017f793          	andi	a5,a5,1
    80003be0:	00078c63          	beqz	a5,80003bf8 <uartgetc+0x30>
    80003be4:	00074503          	lbu	a0,0(a4)
    80003be8:	0ff57513          	andi	a0,a0,255
    80003bec:	00813403          	ld	s0,8(sp)
    80003bf0:	01010113          	addi	sp,sp,16
    80003bf4:	00008067          	ret
    80003bf8:	fff00513          	li	a0,-1
    80003bfc:	ff1ff06f          	j	80003bec <uartgetc+0x24>

0000000080003c00 <uartintr>:
    80003c00:	100007b7          	lui	a5,0x10000
    80003c04:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003c08:	0017f793          	andi	a5,a5,1
    80003c0c:	0a078463          	beqz	a5,80003cb4 <uartintr+0xb4>
    80003c10:	fe010113          	addi	sp,sp,-32
    80003c14:	00813823          	sd	s0,16(sp)
    80003c18:	00913423          	sd	s1,8(sp)
    80003c1c:	00113c23          	sd	ra,24(sp)
    80003c20:	02010413          	addi	s0,sp,32
    80003c24:	100004b7          	lui	s1,0x10000
    80003c28:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003c2c:	0ff57513          	andi	a0,a0,255
    80003c30:	fffff097          	auipc	ra,0xfffff
    80003c34:	534080e7          	jalr	1332(ra) # 80003164 <consoleintr>
    80003c38:	0054c783          	lbu	a5,5(s1)
    80003c3c:	0017f793          	andi	a5,a5,1
    80003c40:	fe0794e3          	bnez	a5,80003c28 <uartintr+0x28>
    80003c44:	00002617          	auipc	a2,0x2
    80003c48:	05c60613          	addi	a2,a2,92 # 80005ca0 <uart_tx_r>
    80003c4c:	00002517          	auipc	a0,0x2
    80003c50:	05c50513          	addi	a0,a0,92 # 80005ca8 <uart_tx_w>
    80003c54:	00063783          	ld	a5,0(a2)
    80003c58:	00053703          	ld	a4,0(a0)
    80003c5c:	04f70263          	beq	a4,a5,80003ca0 <uartintr+0xa0>
    80003c60:	100005b7          	lui	a1,0x10000
    80003c64:	00003817          	auipc	a6,0x3
    80003c68:	2dc80813          	addi	a6,a6,732 # 80006f40 <uart_tx_buf>
    80003c6c:	01c0006f          	j	80003c88 <uartintr+0x88>
    80003c70:	0006c703          	lbu	a4,0(a3)
    80003c74:	00f63023          	sd	a5,0(a2)
    80003c78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003c7c:	00063783          	ld	a5,0(a2)
    80003c80:	00053703          	ld	a4,0(a0)
    80003c84:	00f70e63          	beq	a4,a5,80003ca0 <uartintr+0xa0>
    80003c88:	01f7f713          	andi	a4,a5,31
    80003c8c:	00e806b3          	add	a3,a6,a4
    80003c90:	0055c703          	lbu	a4,5(a1)
    80003c94:	00178793          	addi	a5,a5,1
    80003c98:	02077713          	andi	a4,a4,32
    80003c9c:	fc071ae3          	bnez	a4,80003c70 <uartintr+0x70>
    80003ca0:	01813083          	ld	ra,24(sp)
    80003ca4:	01013403          	ld	s0,16(sp)
    80003ca8:	00813483          	ld	s1,8(sp)
    80003cac:	02010113          	addi	sp,sp,32
    80003cb0:	00008067          	ret
    80003cb4:	00002617          	auipc	a2,0x2
    80003cb8:	fec60613          	addi	a2,a2,-20 # 80005ca0 <uart_tx_r>
    80003cbc:	00002517          	auipc	a0,0x2
    80003cc0:	fec50513          	addi	a0,a0,-20 # 80005ca8 <uart_tx_w>
    80003cc4:	00063783          	ld	a5,0(a2)
    80003cc8:	00053703          	ld	a4,0(a0)
    80003ccc:	04f70263          	beq	a4,a5,80003d10 <uartintr+0x110>
    80003cd0:	100005b7          	lui	a1,0x10000
    80003cd4:	00003817          	auipc	a6,0x3
    80003cd8:	26c80813          	addi	a6,a6,620 # 80006f40 <uart_tx_buf>
    80003cdc:	01c0006f          	j	80003cf8 <uartintr+0xf8>
    80003ce0:	0006c703          	lbu	a4,0(a3)
    80003ce4:	00f63023          	sd	a5,0(a2)
    80003ce8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003cec:	00063783          	ld	a5,0(a2)
    80003cf0:	00053703          	ld	a4,0(a0)
    80003cf4:	02f70063          	beq	a4,a5,80003d14 <uartintr+0x114>
    80003cf8:	01f7f713          	andi	a4,a5,31
    80003cfc:	00e806b3          	add	a3,a6,a4
    80003d00:	0055c703          	lbu	a4,5(a1)
    80003d04:	00178793          	addi	a5,a5,1
    80003d08:	02077713          	andi	a4,a4,32
    80003d0c:	fc071ae3          	bnez	a4,80003ce0 <uartintr+0xe0>
    80003d10:	00008067          	ret
    80003d14:	00008067          	ret

0000000080003d18 <kinit>:
    80003d18:	fc010113          	addi	sp,sp,-64
    80003d1c:	02913423          	sd	s1,40(sp)
    80003d20:	fffff7b7          	lui	a5,0xfffff
    80003d24:	00004497          	auipc	s1,0x4
    80003d28:	23b48493          	addi	s1,s1,571 # 80007f5f <end+0xfff>
    80003d2c:	02813823          	sd	s0,48(sp)
    80003d30:	01313c23          	sd	s3,24(sp)
    80003d34:	00f4f4b3          	and	s1,s1,a5
    80003d38:	02113c23          	sd	ra,56(sp)
    80003d3c:	03213023          	sd	s2,32(sp)
    80003d40:	01413823          	sd	s4,16(sp)
    80003d44:	01513423          	sd	s5,8(sp)
    80003d48:	04010413          	addi	s0,sp,64
    80003d4c:	000017b7          	lui	a5,0x1
    80003d50:	01100993          	li	s3,17
    80003d54:	00f487b3          	add	a5,s1,a5
    80003d58:	01b99993          	slli	s3,s3,0x1b
    80003d5c:	06f9e063          	bltu	s3,a5,80003dbc <kinit+0xa4>
    80003d60:	00003a97          	auipc	s5,0x3
    80003d64:	200a8a93          	addi	s5,s5,512 # 80006f60 <end>
    80003d68:	0754ec63          	bltu	s1,s5,80003de0 <kinit+0xc8>
    80003d6c:	0734fa63          	bgeu	s1,s3,80003de0 <kinit+0xc8>
    80003d70:	00088a37          	lui	s4,0x88
    80003d74:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003d78:	00002917          	auipc	s2,0x2
    80003d7c:	f3890913          	addi	s2,s2,-200 # 80005cb0 <kmem>
    80003d80:	00ca1a13          	slli	s4,s4,0xc
    80003d84:	0140006f          	j	80003d98 <kinit+0x80>
    80003d88:	000017b7          	lui	a5,0x1
    80003d8c:	00f484b3          	add	s1,s1,a5
    80003d90:	0554e863          	bltu	s1,s5,80003de0 <kinit+0xc8>
    80003d94:	0534f663          	bgeu	s1,s3,80003de0 <kinit+0xc8>
    80003d98:	00001637          	lui	a2,0x1
    80003d9c:	00100593          	li	a1,1
    80003da0:	00048513          	mv	a0,s1
    80003da4:	00000097          	auipc	ra,0x0
    80003da8:	5e4080e7          	jalr	1508(ra) # 80004388 <__memset>
    80003dac:	00093783          	ld	a5,0(s2)
    80003db0:	00f4b023          	sd	a5,0(s1)
    80003db4:	00993023          	sd	s1,0(s2)
    80003db8:	fd4498e3          	bne	s1,s4,80003d88 <kinit+0x70>
    80003dbc:	03813083          	ld	ra,56(sp)
    80003dc0:	03013403          	ld	s0,48(sp)
    80003dc4:	02813483          	ld	s1,40(sp)
    80003dc8:	02013903          	ld	s2,32(sp)
    80003dcc:	01813983          	ld	s3,24(sp)
    80003dd0:	01013a03          	ld	s4,16(sp)
    80003dd4:	00813a83          	ld	s5,8(sp)
    80003dd8:	04010113          	addi	sp,sp,64
    80003ddc:	00008067          	ret
    80003de0:	00001517          	auipc	a0,0x1
    80003de4:	4b850513          	addi	a0,a0,1208 # 80005298 <digits+0x18>
    80003de8:	fffff097          	auipc	ra,0xfffff
    80003dec:	4b4080e7          	jalr	1204(ra) # 8000329c <panic>

0000000080003df0 <freerange>:
    80003df0:	fc010113          	addi	sp,sp,-64
    80003df4:	000017b7          	lui	a5,0x1
    80003df8:	02913423          	sd	s1,40(sp)
    80003dfc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003e00:	009504b3          	add	s1,a0,s1
    80003e04:	fffff537          	lui	a0,0xfffff
    80003e08:	02813823          	sd	s0,48(sp)
    80003e0c:	02113c23          	sd	ra,56(sp)
    80003e10:	03213023          	sd	s2,32(sp)
    80003e14:	01313c23          	sd	s3,24(sp)
    80003e18:	01413823          	sd	s4,16(sp)
    80003e1c:	01513423          	sd	s5,8(sp)
    80003e20:	01613023          	sd	s6,0(sp)
    80003e24:	04010413          	addi	s0,sp,64
    80003e28:	00a4f4b3          	and	s1,s1,a0
    80003e2c:	00f487b3          	add	a5,s1,a5
    80003e30:	06f5e463          	bltu	a1,a5,80003e98 <freerange+0xa8>
    80003e34:	00003a97          	auipc	s5,0x3
    80003e38:	12ca8a93          	addi	s5,s5,300 # 80006f60 <end>
    80003e3c:	0954e263          	bltu	s1,s5,80003ec0 <freerange+0xd0>
    80003e40:	01100993          	li	s3,17
    80003e44:	01b99993          	slli	s3,s3,0x1b
    80003e48:	0734fc63          	bgeu	s1,s3,80003ec0 <freerange+0xd0>
    80003e4c:	00058a13          	mv	s4,a1
    80003e50:	00002917          	auipc	s2,0x2
    80003e54:	e6090913          	addi	s2,s2,-416 # 80005cb0 <kmem>
    80003e58:	00002b37          	lui	s6,0x2
    80003e5c:	0140006f          	j	80003e70 <freerange+0x80>
    80003e60:	000017b7          	lui	a5,0x1
    80003e64:	00f484b3          	add	s1,s1,a5
    80003e68:	0554ec63          	bltu	s1,s5,80003ec0 <freerange+0xd0>
    80003e6c:	0534fa63          	bgeu	s1,s3,80003ec0 <freerange+0xd0>
    80003e70:	00001637          	lui	a2,0x1
    80003e74:	00100593          	li	a1,1
    80003e78:	00048513          	mv	a0,s1
    80003e7c:	00000097          	auipc	ra,0x0
    80003e80:	50c080e7          	jalr	1292(ra) # 80004388 <__memset>
    80003e84:	00093703          	ld	a4,0(s2)
    80003e88:	016487b3          	add	a5,s1,s6
    80003e8c:	00e4b023          	sd	a4,0(s1)
    80003e90:	00993023          	sd	s1,0(s2)
    80003e94:	fcfa76e3          	bgeu	s4,a5,80003e60 <freerange+0x70>
    80003e98:	03813083          	ld	ra,56(sp)
    80003e9c:	03013403          	ld	s0,48(sp)
    80003ea0:	02813483          	ld	s1,40(sp)
    80003ea4:	02013903          	ld	s2,32(sp)
    80003ea8:	01813983          	ld	s3,24(sp)
    80003eac:	01013a03          	ld	s4,16(sp)
    80003eb0:	00813a83          	ld	s5,8(sp)
    80003eb4:	00013b03          	ld	s6,0(sp)
    80003eb8:	04010113          	addi	sp,sp,64
    80003ebc:	00008067          	ret
    80003ec0:	00001517          	auipc	a0,0x1
    80003ec4:	3d850513          	addi	a0,a0,984 # 80005298 <digits+0x18>
    80003ec8:	fffff097          	auipc	ra,0xfffff
    80003ecc:	3d4080e7          	jalr	980(ra) # 8000329c <panic>

0000000080003ed0 <kfree>:
    80003ed0:	fe010113          	addi	sp,sp,-32
    80003ed4:	00813823          	sd	s0,16(sp)
    80003ed8:	00113c23          	sd	ra,24(sp)
    80003edc:	00913423          	sd	s1,8(sp)
    80003ee0:	02010413          	addi	s0,sp,32
    80003ee4:	03451793          	slli	a5,a0,0x34
    80003ee8:	04079c63          	bnez	a5,80003f40 <kfree+0x70>
    80003eec:	00003797          	auipc	a5,0x3
    80003ef0:	07478793          	addi	a5,a5,116 # 80006f60 <end>
    80003ef4:	00050493          	mv	s1,a0
    80003ef8:	04f56463          	bltu	a0,a5,80003f40 <kfree+0x70>
    80003efc:	01100793          	li	a5,17
    80003f00:	01b79793          	slli	a5,a5,0x1b
    80003f04:	02f57e63          	bgeu	a0,a5,80003f40 <kfree+0x70>
    80003f08:	00001637          	lui	a2,0x1
    80003f0c:	00100593          	li	a1,1
    80003f10:	00000097          	auipc	ra,0x0
    80003f14:	478080e7          	jalr	1144(ra) # 80004388 <__memset>
    80003f18:	00002797          	auipc	a5,0x2
    80003f1c:	d9878793          	addi	a5,a5,-616 # 80005cb0 <kmem>
    80003f20:	0007b703          	ld	a4,0(a5)
    80003f24:	01813083          	ld	ra,24(sp)
    80003f28:	01013403          	ld	s0,16(sp)
    80003f2c:	00e4b023          	sd	a4,0(s1)
    80003f30:	0097b023          	sd	s1,0(a5)
    80003f34:	00813483          	ld	s1,8(sp)
    80003f38:	02010113          	addi	sp,sp,32
    80003f3c:	00008067          	ret
    80003f40:	00001517          	auipc	a0,0x1
    80003f44:	35850513          	addi	a0,a0,856 # 80005298 <digits+0x18>
    80003f48:	fffff097          	auipc	ra,0xfffff
    80003f4c:	354080e7          	jalr	852(ra) # 8000329c <panic>

0000000080003f50 <kalloc>:
    80003f50:	fe010113          	addi	sp,sp,-32
    80003f54:	00813823          	sd	s0,16(sp)
    80003f58:	00913423          	sd	s1,8(sp)
    80003f5c:	00113c23          	sd	ra,24(sp)
    80003f60:	02010413          	addi	s0,sp,32
    80003f64:	00002797          	auipc	a5,0x2
    80003f68:	d4c78793          	addi	a5,a5,-692 # 80005cb0 <kmem>
    80003f6c:	0007b483          	ld	s1,0(a5)
    80003f70:	02048063          	beqz	s1,80003f90 <kalloc+0x40>
    80003f74:	0004b703          	ld	a4,0(s1)
    80003f78:	00001637          	lui	a2,0x1
    80003f7c:	00500593          	li	a1,5
    80003f80:	00048513          	mv	a0,s1
    80003f84:	00e7b023          	sd	a4,0(a5)
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	400080e7          	jalr	1024(ra) # 80004388 <__memset>
    80003f90:	01813083          	ld	ra,24(sp)
    80003f94:	01013403          	ld	s0,16(sp)
    80003f98:	00048513          	mv	a0,s1
    80003f9c:	00813483          	ld	s1,8(sp)
    80003fa0:	02010113          	addi	sp,sp,32
    80003fa4:	00008067          	ret

0000000080003fa8 <initlock>:
    80003fa8:	ff010113          	addi	sp,sp,-16
    80003fac:	00813423          	sd	s0,8(sp)
    80003fb0:	01010413          	addi	s0,sp,16
    80003fb4:	00813403          	ld	s0,8(sp)
    80003fb8:	00b53423          	sd	a1,8(a0)
    80003fbc:	00052023          	sw	zero,0(a0)
    80003fc0:	00053823          	sd	zero,16(a0)
    80003fc4:	01010113          	addi	sp,sp,16
    80003fc8:	00008067          	ret

0000000080003fcc <acquire>:
    80003fcc:	fe010113          	addi	sp,sp,-32
    80003fd0:	00813823          	sd	s0,16(sp)
    80003fd4:	00913423          	sd	s1,8(sp)
    80003fd8:	00113c23          	sd	ra,24(sp)
    80003fdc:	01213023          	sd	s2,0(sp)
    80003fe0:	02010413          	addi	s0,sp,32
    80003fe4:	00050493          	mv	s1,a0
    80003fe8:	10002973          	csrr	s2,sstatus
    80003fec:	100027f3          	csrr	a5,sstatus
    80003ff0:	ffd7f793          	andi	a5,a5,-3
    80003ff4:	10079073          	csrw	sstatus,a5
    80003ff8:	fffff097          	auipc	ra,0xfffff
    80003ffc:	8ec080e7          	jalr	-1812(ra) # 800028e4 <mycpu>
    80004000:	07852783          	lw	a5,120(a0)
    80004004:	06078e63          	beqz	a5,80004080 <acquire+0xb4>
    80004008:	fffff097          	auipc	ra,0xfffff
    8000400c:	8dc080e7          	jalr	-1828(ra) # 800028e4 <mycpu>
    80004010:	07852783          	lw	a5,120(a0)
    80004014:	0004a703          	lw	a4,0(s1)
    80004018:	0017879b          	addiw	a5,a5,1
    8000401c:	06f52c23          	sw	a5,120(a0)
    80004020:	04071063          	bnez	a4,80004060 <acquire+0x94>
    80004024:	00100713          	li	a4,1
    80004028:	00070793          	mv	a5,a4
    8000402c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004030:	0007879b          	sext.w	a5,a5
    80004034:	fe079ae3          	bnez	a5,80004028 <acquire+0x5c>
    80004038:	0ff0000f          	fence
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	8a8080e7          	jalr	-1880(ra) # 800028e4 <mycpu>
    80004044:	01813083          	ld	ra,24(sp)
    80004048:	01013403          	ld	s0,16(sp)
    8000404c:	00a4b823          	sd	a0,16(s1)
    80004050:	00013903          	ld	s2,0(sp)
    80004054:	00813483          	ld	s1,8(sp)
    80004058:	02010113          	addi	sp,sp,32
    8000405c:	00008067          	ret
    80004060:	0104b903          	ld	s2,16(s1)
    80004064:	fffff097          	auipc	ra,0xfffff
    80004068:	880080e7          	jalr	-1920(ra) # 800028e4 <mycpu>
    8000406c:	faa91ce3          	bne	s2,a0,80004024 <acquire+0x58>
    80004070:	00001517          	auipc	a0,0x1
    80004074:	23050513          	addi	a0,a0,560 # 800052a0 <digits+0x20>
    80004078:	fffff097          	auipc	ra,0xfffff
    8000407c:	224080e7          	jalr	548(ra) # 8000329c <panic>
    80004080:	00195913          	srli	s2,s2,0x1
    80004084:	fffff097          	auipc	ra,0xfffff
    80004088:	860080e7          	jalr	-1952(ra) # 800028e4 <mycpu>
    8000408c:	00197913          	andi	s2,s2,1
    80004090:	07252e23          	sw	s2,124(a0)
    80004094:	f75ff06f          	j	80004008 <acquire+0x3c>

0000000080004098 <release>:
    80004098:	fe010113          	addi	sp,sp,-32
    8000409c:	00813823          	sd	s0,16(sp)
    800040a0:	00113c23          	sd	ra,24(sp)
    800040a4:	00913423          	sd	s1,8(sp)
    800040a8:	01213023          	sd	s2,0(sp)
    800040ac:	02010413          	addi	s0,sp,32
    800040b0:	00052783          	lw	a5,0(a0)
    800040b4:	00079a63          	bnez	a5,800040c8 <release+0x30>
    800040b8:	00001517          	auipc	a0,0x1
    800040bc:	1f050513          	addi	a0,a0,496 # 800052a8 <digits+0x28>
    800040c0:	fffff097          	auipc	ra,0xfffff
    800040c4:	1dc080e7          	jalr	476(ra) # 8000329c <panic>
    800040c8:	01053903          	ld	s2,16(a0)
    800040cc:	00050493          	mv	s1,a0
    800040d0:	fffff097          	auipc	ra,0xfffff
    800040d4:	814080e7          	jalr	-2028(ra) # 800028e4 <mycpu>
    800040d8:	fea910e3          	bne	s2,a0,800040b8 <release+0x20>
    800040dc:	0004b823          	sd	zero,16(s1)
    800040e0:	0ff0000f          	fence
    800040e4:	0f50000f          	fence	iorw,ow
    800040e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800040ec:	ffffe097          	auipc	ra,0xffffe
    800040f0:	7f8080e7          	jalr	2040(ra) # 800028e4 <mycpu>
    800040f4:	100027f3          	csrr	a5,sstatus
    800040f8:	0027f793          	andi	a5,a5,2
    800040fc:	04079a63          	bnez	a5,80004150 <release+0xb8>
    80004100:	07852783          	lw	a5,120(a0)
    80004104:	02f05e63          	blez	a5,80004140 <release+0xa8>
    80004108:	fff7871b          	addiw	a4,a5,-1
    8000410c:	06e52c23          	sw	a4,120(a0)
    80004110:	00071c63          	bnez	a4,80004128 <release+0x90>
    80004114:	07c52783          	lw	a5,124(a0)
    80004118:	00078863          	beqz	a5,80004128 <release+0x90>
    8000411c:	100027f3          	csrr	a5,sstatus
    80004120:	0027e793          	ori	a5,a5,2
    80004124:	10079073          	csrw	sstatus,a5
    80004128:	01813083          	ld	ra,24(sp)
    8000412c:	01013403          	ld	s0,16(sp)
    80004130:	00813483          	ld	s1,8(sp)
    80004134:	00013903          	ld	s2,0(sp)
    80004138:	02010113          	addi	sp,sp,32
    8000413c:	00008067          	ret
    80004140:	00001517          	auipc	a0,0x1
    80004144:	18850513          	addi	a0,a0,392 # 800052c8 <digits+0x48>
    80004148:	fffff097          	auipc	ra,0xfffff
    8000414c:	154080e7          	jalr	340(ra) # 8000329c <panic>
    80004150:	00001517          	auipc	a0,0x1
    80004154:	16050513          	addi	a0,a0,352 # 800052b0 <digits+0x30>
    80004158:	fffff097          	auipc	ra,0xfffff
    8000415c:	144080e7          	jalr	324(ra) # 8000329c <panic>

0000000080004160 <holding>:
    80004160:	00052783          	lw	a5,0(a0)
    80004164:	00079663          	bnez	a5,80004170 <holding+0x10>
    80004168:	00000513          	li	a0,0
    8000416c:	00008067          	ret
    80004170:	fe010113          	addi	sp,sp,-32
    80004174:	00813823          	sd	s0,16(sp)
    80004178:	00913423          	sd	s1,8(sp)
    8000417c:	00113c23          	sd	ra,24(sp)
    80004180:	02010413          	addi	s0,sp,32
    80004184:	01053483          	ld	s1,16(a0)
    80004188:	ffffe097          	auipc	ra,0xffffe
    8000418c:	75c080e7          	jalr	1884(ra) # 800028e4 <mycpu>
    80004190:	01813083          	ld	ra,24(sp)
    80004194:	01013403          	ld	s0,16(sp)
    80004198:	40a48533          	sub	a0,s1,a0
    8000419c:	00153513          	seqz	a0,a0
    800041a0:	00813483          	ld	s1,8(sp)
    800041a4:	02010113          	addi	sp,sp,32
    800041a8:	00008067          	ret

00000000800041ac <push_off>:
    800041ac:	fe010113          	addi	sp,sp,-32
    800041b0:	00813823          	sd	s0,16(sp)
    800041b4:	00113c23          	sd	ra,24(sp)
    800041b8:	00913423          	sd	s1,8(sp)
    800041bc:	02010413          	addi	s0,sp,32
    800041c0:	100024f3          	csrr	s1,sstatus
    800041c4:	100027f3          	csrr	a5,sstatus
    800041c8:	ffd7f793          	andi	a5,a5,-3
    800041cc:	10079073          	csrw	sstatus,a5
    800041d0:	ffffe097          	auipc	ra,0xffffe
    800041d4:	714080e7          	jalr	1812(ra) # 800028e4 <mycpu>
    800041d8:	07852783          	lw	a5,120(a0)
    800041dc:	02078663          	beqz	a5,80004208 <push_off+0x5c>
    800041e0:	ffffe097          	auipc	ra,0xffffe
    800041e4:	704080e7          	jalr	1796(ra) # 800028e4 <mycpu>
    800041e8:	07852783          	lw	a5,120(a0)
    800041ec:	01813083          	ld	ra,24(sp)
    800041f0:	01013403          	ld	s0,16(sp)
    800041f4:	0017879b          	addiw	a5,a5,1
    800041f8:	06f52c23          	sw	a5,120(a0)
    800041fc:	00813483          	ld	s1,8(sp)
    80004200:	02010113          	addi	sp,sp,32
    80004204:	00008067          	ret
    80004208:	0014d493          	srli	s1,s1,0x1
    8000420c:	ffffe097          	auipc	ra,0xffffe
    80004210:	6d8080e7          	jalr	1752(ra) # 800028e4 <mycpu>
    80004214:	0014f493          	andi	s1,s1,1
    80004218:	06952e23          	sw	s1,124(a0)
    8000421c:	fc5ff06f          	j	800041e0 <push_off+0x34>

0000000080004220 <pop_off>:
    80004220:	ff010113          	addi	sp,sp,-16
    80004224:	00813023          	sd	s0,0(sp)
    80004228:	00113423          	sd	ra,8(sp)
    8000422c:	01010413          	addi	s0,sp,16
    80004230:	ffffe097          	auipc	ra,0xffffe
    80004234:	6b4080e7          	jalr	1716(ra) # 800028e4 <mycpu>
    80004238:	100027f3          	csrr	a5,sstatus
    8000423c:	0027f793          	andi	a5,a5,2
    80004240:	04079663          	bnez	a5,8000428c <pop_off+0x6c>
    80004244:	07852783          	lw	a5,120(a0)
    80004248:	02f05a63          	blez	a5,8000427c <pop_off+0x5c>
    8000424c:	fff7871b          	addiw	a4,a5,-1
    80004250:	06e52c23          	sw	a4,120(a0)
    80004254:	00071c63          	bnez	a4,8000426c <pop_off+0x4c>
    80004258:	07c52783          	lw	a5,124(a0)
    8000425c:	00078863          	beqz	a5,8000426c <pop_off+0x4c>
    80004260:	100027f3          	csrr	a5,sstatus
    80004264:	0027e793          	ori	a5,a5,2
    80004268:	10079073          	csrw	sstatus,a5
    8000426c:	00813083          	ld	ra,8(sp)
    80004270:	00013403          	ld	s0,0(sp)
    80004274:	01010113          	addi	sp,sp,16
    80004278:	00008067          	ret
    8000427c:	00001517          	auipc	a0,0x1
    80004280:	04c50513          	addi	a0,a0,76 # 800052c8 <digits+0x48>
    80004284:	fffff097          	auipc	ra,0xfffff
    80004288:	018080e7          	jalr	24(ra) # 8000329c <panic>
    8000428c:	00001517          	auipc	a0,0x1
    80004290:	02450513          	addi	a0,a0,36 # 800052b0 <digits+0x30>
    80004294:	fffff097          	auipc	ra,0xfffff
    80004298:	008080e7          	jalr	8(ra) # 8000329c <panic>

000000008000429c <push_on>:
    8000429c:	fe010113          	addi	sp,sp,-32
    800042a0:	00813823          	sd	s0,16(sp)
    800042a4:	00113c23          	sd	ra,24(sp)
    800042a8:	00913423          	sd	s1,8(sp)
    800042ac:	02010413          	addi	s0,sp,32
    800042b0:	100024f3          	csrr	s1,sstatus
    800042b4:	100027f3          	csrr	a5,sstatus
    800042b8:	0027e793          	ori	a5,a5,2
    800042bc:	10079073          	csrw	sstatus,a5
    800042c0:	ffffe097          	auipc	ra,0xffffe
    800042c4:	624080e7          	jalr	1572(ra) # 800028e4 <mycpu>
    800042c8:	07852783          	lw	a5,120(a0)
    800042cc:	02078663          	beqz	a5,800042f8 <push_on+0x5c>
    800042d0:	ffffe097          	auipc	ra,0xffffe
    800042d4:	614080e7          	jalr	1556(ra) # 800028e4 <mycpu>
    800042d8:	07852783          	lw	a5,120(a0)
    800042dc:	01813083          	ld	ra,24(sp)
    800042e0:	01013403          	ld	s0,16(sp)
    800042e4:	0017879b          	addiw	a5,a5,1
    800042e8:	06f52c23          	sw	a5,120(a0)
    800042ec:	00813483          	ld	s1,8(sp)
    800042f0:	02010113          	addi	sp,sp,32
    800042f4:	00008067          	ret
    800042f8:	0014d493          	srli	s1,s1,0x1
    800042fc:	ffffe097          	auipc	ra,0xffffe
    80004300:	5e8080e7          	jalr	1512(ra) # 800028e4 <mycpu>
    80004304:	0014f493          	andi	s1,s1,1
    80004308:	06952e23          	sw	s1,124(a0)
    8000430c:	fc5ff06f          	j	800042d0 <push_on+0x34>

0000000080004310 <pop_on>:
    80004310:	ff010113          	addi	sp,sp,-16
    80004314:	00813023          	sd	s0,0(sp)
    80004318:	00113423          	sd	ra,8(sp)
    8000431c:	01010413          	addi	s0,sp,16
    80004320:	ffffe097          	auipc	ra,0xffffe
    80004324:	5c4080e7          	jalr	1476(ra) # 800028e4 <mycpu>
    80004328:	100027f3          	csrr	a5,sstatus
    8000432c:	0027f793          	andi	a5,a5,2
    80004330:	04078463          	beqz	a5,80004378 <pop_on+0x68>
    80004334:	07852783          	lw	a5,120(a0)
    80004338:	02f05863          	blez	a5,80004368 <pop_on+0x58>
    8000433c:	fff7879b          	addiw	a5,a5,-1
    80004340:	06f52c23          	sw	a5,120(a0)
    80004344:	07853783          	ld	a5,120(a0)
    80004348:	00079863          	bnez	a5,80004358 <pop_on+0x48>
    8000434c:	100027f3          	csrr	a5,sstatus
    80004350:	ffd7f793          	andi	a5,a5,-3
    80004354:	10079073          	csrw	sstatus,a5
    80004358:	00813083          	ld	ra,8(sp)
    8000435c:	00013403          	ld	s0,0(sp)
    80004360:	01010113          	addi	sp,sp,16
    80004364:	00008067          	ret
    80004368:	00001517          	auipc	a0,0x1
    8000436c:	f8850513          	addi	a0,a0,-120 # 800052f0 <digits+0x70>
    80004370:	fffff097          	auipc	ra,0xfffff
    80004374:	f2c080e7          	jalr	-212(ra) # 8000329c <panic>
    80004378:	00001517          	auipc	a0,0x1
    8000437c:	f5850513          	addi	a0,a0,-168 # 800052d0 <digits+0x50>
    80004380:	fffff097          	auipc	ra,0xfffff
    80004384:	f1c080e7          	jalr	-228(ra) # 8000329c <panic>

0000000080004388 <__memset>:
    80004388:	ff010113          	addi	sp,sp,-16
    8000438c:	00813423          	sd	s0,8(sp)
    80004390:	01010413          	addi	s0,sp,16
    80004394:	1a060e63          	beqz	a2,80004550 <__memset+0x1c8>
    80004398:	40a007b3          	neg	a5,a0
    8000439c:	0077f793          	andi	a5,a5,7
    800043a0:	00778693          	addi	a3,a5,7
    800043a4:	00b00813          	li	a6,11
    800043a8:	0ff5f593          	andi	a1,a1,255
    800043ac:	fff6071b          	addiw	a4,a2,-1
    800043b0:	1b06e663          	bltu	a3,a6,8000455c <__memset+0x1d4>
    800043b4:	1cd76463          	bltu	a4,a3,8000457c <__memset+0x1f4>
    800043b8:	1a078e63          	beqz	a5,80004574 <__memset+0x1ec>
    800043bc:	00b50023          	sb	a1,0(a0)
    800043c0:	00100713          	li	a4,1
    800043c4:	1ae78463          	beq	a5,a4,8000456c <__memset+0x1e4>
    800043c8:	00b500a3          	sb	a1,1(a0)
    800043cc:	00200713          	li	a4,2
    800043d0:	1ae78a63          	beq	a5,a4,80004584 <__memset+0x1fc>
    800043d4:	00b50123          	sb	a1,2(a0)
    800043d8:	00300713          	li	a4,3
    800043dc:	18e78463          	beq	a5,a4,80004564 <__memset+0x1dc>
    800043e0:	00b501a3          	sb	a1,3(a0)
    800043e4:	00400713          	li	a4,4
    800043e8:	1ae78263          	beq	a5,a4,8000458c <__memset+0x204>
    800043ec:	00b50223          	sb	a1,4(a0)
    800043f0:	00500713          	li	a4,5
    800043f4:	1ae78063          	beq	a5,a4,80004594 <__memset+0x20c>
    800043f8:	00b502a3          	sb	a1,5(a0)
    800043fc:	00700713          	li	a4,7
    80004400:	18e79e63          	bne	a5,a4,8000459c <__memset+0x214>
    80004404:	00b50323          	sb	a1,6(a0)
    80004408:	00700e93          	li	t4,7
    8000440c:	00859713          	slli	a4,a1,0x8
    80004410:	00e5e733          	or	a4,a1,a4
    80004414:	01059e13          	slli	t3,a1,0x10
    80004418:	01c76e33          	or	t3,a4,t3
    8000441c:	01859313          	slli	t1,a1,0x18
    80004420:	006e6333          	or	t1,t3,t1
    80004424:	02059893          	slli	a7,a1,0x20
    80004428:	40f60e3b          	subw	t3,a2,a5
    8000442c:	011368b3          	or	a7,t1,a7
    80004430:	02859813          	slli	a6,a1,0x28
    80004434:	0108e833          	or	a6,a7,a6
    80004438:	03059693          	slli	a3,a1,0x30
    8000443c:	003e589b          	srliw	a7,t3,0x3
    80004440:	00d866b3          	or	a3,a6,a3
    80004444:	03859713          	slli	a4,a1,0x38
    80004448:	00389813          	slli	a6,a7,0x3
    8000444c:	00f507b3          	add	a5,a0,a5
    80004450:	00e6e733          	or	a4,a3,a4
    80004454:	000e089b          	sext.w	a7,t3
    80004458:	00f806b3          	add	a3,a6,a5
    8000445c:	00e7b023          	sd	a4,0(a5)
    80004460:	00878793          	addi	a5,a5,8
    80004464:	fed79ce3          	bne	a5,a3,8000445c <__memset+0xd4>
    80004468:	ff8e7793          	andi	a5,t3,-8
    8000446c:	0007871b          	sext.w	a4,a5
    80004470:	01d787bb          	addw	a5,a5,t4
    80004474:	0ce88e63          	beq	a7,a4,80004550 <__memset+0x1c8>
    80004478:	00f50733          	add	a4,a0,a5
    8000447c:	00b70023          	sb	a1,0(a4)
    80004480:	0017871b          	addiw	a4,a5,1
    80004484:	0cc77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004488:	00e50733          	add	a4,a0,a4
    8000448c:	00b70023          	sb	a1,0(a4)
    80004490:	0027871b          	addiw	a4,a5,2
    80004494:	0ac77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004498:	00e50733          	add	a4,a0,a4
    8000449c:	00b70023          	sb	a1,0(a4)
    800044a0:	0037871b          	addiw	a4,a5,3
    800044a4:	0ac77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044a8:	00e50733          	add	a4,a0,a4
    800044ac:	00b70023          	sb	a1,0(a4)
    800044b0:	0047871b          	addiw	a4,a5,4
    800044b4:	08c77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044b8:	00e50733          	add	a4,a0,a4
    800044bc:	00b70023          	sb	a1,0(a4)
    800044c0:	0057871b          	addiw	a4,a5,5
    800044c4:	08c77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044c8:	00e50733          	add	a4,a0,a4
    800044cc:	00b70023          	sb	a1,0(a4)
    800044d0:	0067871b          	addiw	a4,a5,6
    800044d4:	06c77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044d8:	00e50733          	add	a4,a0,a4
    800044dc:	00b70023          	sb	a1,0(a4)
    800044e0:	0077871b          	addiw	a4,a5,7
    800044e4:	06c77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044e8:	00e50733          	add	a4,a0,a4
    800044ec:	00b70023          	sb	a1,0(a4)
    800044f0:	0087871b          	addiw	a4,a5,8
    800044f4:	04c77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    800044f8:	00e50733          	add	a4,a0,a4
    800044fc:	00b70023          	sb	a1,0(a4)
    80004500:	0097871b          	addiw	a4,a5,9
    80004504:	04c77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004508:	00e50733          	add	a4,a0,a4
    8000450c:	00b70023          	sb	a1,0(a4)
    80004510:	00a7871b          	addiw	a4,a5,10
    80004514:	02c77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004518:	00e50733          	add	a4,a0,a4
    8000451c:	00b70023          	sb	a1,0(a4)
    80004520:	00b7871b          	addiw	a4,a5,11
    80004524:	02c77663          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004528:	00e50733          	add	a4,a0,a4
    8000452c:	00b70023          	sb	a1,0(a4)
    80004530:	00c7871b          	addiw	a4,a5,12
    80004534:	00c77e63          	bgeu	a4,a2,80004550 <__memset+0x1c8>
    80004538:	00e50733          	add	a4,a0,a4
    8000453c:	00b70023          	sb	a1,0(a4)
    80004540:	00d7879b          	addiw	a5,a5,13
    80004544:	00c7f663          	bgeu	a5,a2,80004550 <__memset+0x1c8>
    80004548:	00f507b3          	add	a5,a0,a5
    8000454c:	00b78023          	sb	a1,0(a5)
    80004550:	00813403          	ld	s0,8(sp)
    80004554:	01010113          	addi	sp,sp,16
    80004558:	00008067          	ret
    8000455c:	00b00693          	li	a3,11
    80004560:	e55ff06f          	j	800043b4 <__memset+0x2c>
    80004564:	00300e93          	li	t4,3
    80004568:	ea5ff06f          	j	8000440c <__memset+0x84>
    8000456c:	00100e93          	li	t4,1
    80004570:	e9dff06f          	j	8000440c <__memset+0x84>
    80004574:	00000e93          	li	t4,0
    80004578:	e95ff06f          	j	8000440c <__memset+0x84>
    8000457c:	00000793          	li	a5,0
    80004580:	ef9ff06f          	j	80004478 <__memset+0xf0>
    80004584:	00200e93          	li	t4,2
    80004588:	e85ff06f          	j	8000440c <__memset+0x84>
    8000458c:	00400e93          	li	t4,4
    80004590:	e7dff06f          	j	8000440c <__memset+0x84>
    80004594:	00500e93          	li	t4,5
    80004598:	e75ff06f          	j	8000440c <__memset+0x84>
    8000459c:	00600e93          	li	t4,6
    800045a0:	e6dff06f          	j	8000440c <__memset+0x84>

00000000800045a4 <__memmove>:
    800045a4:	ff010113          	addi	sp,sp,-16
    800045a8:	00813423          	sd	s0,8(sp)
    800045ac:	01010413          	addi	s0,sp,16
    800045b0:	0e060863          	beqz	a2,800046a0 <__memmove+0xfc>
    800045b4:	fff6069b          	addiw	a3,a2,-1
    800045b8:	0006881b          	sext.w	a6,a3
    800045bc:	0ea5e863          	bltu	a1,a0,800046ac <__memmove+0x108>
    800045c0:	00758713          	addi	a4,a1,7
    800045c4:	00a5e7b3          	or	a5,a1,a0
    800045c8:	40a70733          	sub	a4,a4,a0
    800045cc:	0077f793          	andi	a5,a5,7
    800045d0:	00f73713          	sltiu	a4,a4,15
    800045d4:	00174713          	xori	a4,a4,1
    800045d8:	0017b793          	seqz	a5,a5
    800045dc:	00e7f7b3          	and	a5,a5,a4
    800045e0:	10078863          	beqz	a5,800046f0 <__memmove+0x14c>
    800045e4:	00900793          	li	a5,9
    800045e8:	1107f463          	bgeu	a5,a6,800046f0 <__memmove+0x14c>
    800045ec:	0036581b          	srliw	a6,a2,0x3
    800045f0:	fff8081b          	addiw	a6,a6,-1
    800045f4:	02081813          	slli	a6,a6,0x20
    800045f8:	01d85893          	srli	a7,a6,0x1d
    800045fc:	00858813          	addi	a6,a1,8
    80004600:	00058793          	mv	a5,a1
    80004604:	00050713          	mv	a4,a0
    80004608:	01088833          	add	a6,a7,a6
    8000460c:	0007b883          	ld	a7,0(a5)
    80004610:	00878793          	addi	a5,a5,8
    80004614:	00870713          	addi	a4,a4,8
    80004618:	ff173c23          	sd	a7,-8(a4)
    8000461c:	ff0798e3          	bne	a5,a6,8000460c <__memmove+0x68>
    80004620:	ff867713          	andi	a4,a2,-8
    80004624:	02071793          	slli	a5,a4,0x20
    80004628:	0207d793          	srli	a5,a5,0x20
    8000462c:	00f585b3          	add	a1,a1,a5
    80004630:	40e686bb          	subw	a3,a3,a4
    80004634:	00f507b3          	add	a5,a0,a5
    80004638:	06e60463          	beq	a2,a4,800046a0 <__memmove+0xfc>
    8000463c:	0005c703          	lbu	a4,0(a1)
    80004640:	00e78023          	sb	a4,0(a5)
    80004644:	04068e63          	beqz	a3,800046a0 <__memmove+0xfc>
    80004648:	0015c603          	lbu	a2,1(a1)
    8000464c:	00100713          	li	a4,1
    80004650:	00c780a3          	sb	a2,1(a5)
    80004654:	04e68663          	beq	a3,a4,800046a0 <__memmove+0xfc>
    80004658:	0025c603          	lbu	a2,2(a1)
    8000465c:	00200713          	li	a4,2
    80004660:	00c78123          	sb	a2,2(a5)
    80004664:	02e68e63          	beq	a3,a4,800046a0 <__memmove+0xfc>
    80004668:	0035c603          	lbu	a2,3(a1)
    8000466c:	00300713          	li	a4,3
    80004670:	00c781a3          	sb	a2,3(a5)
    80004674:	02e68663          	beq	a3,a4,800046a0 <__memmove+0xfc>
    80004678:	0045c603          	lbu	a2,4(a1)
    8000467c:	00400713          	li	a4,4
    80004680:	00c78223          	sb	a2,4(a5)
    80004684:	00e68e63          	beq	a3,a4,800046a0 <__memmove+0xfc>
    80004688:	0055c603          	lbu	a2,5(a1)
    8000468c:	00500713          	li	a4,5
    80004690:	00c782a3          	sb	a2,5(a5)
    80004694:	00e68663          	beq	a3,a4,800046a0 <__memmove+0xfc>
    80004698:	0065c703          	lbu	a4,6(a1)
    8000469c:	00e78323          	sb	a4,6(a5)
    800046a0:	00813403          	ld	s0,8(sp)
    800046a4:	01010113          	addi	sp,sp,16
    800046a8:	00008067          	ret
    800046ac:	02061713          	slli	a4,a2,0x20
    800046b0:	02075713          	srli	a4,a4,0x20
    800046b4:	00e587b3          	add	a5,a1,a4
    800046b8:	f0f574e3          	bgeu	a0,a5,800045c0 <__memmove+0x1c>
    800046bc:	02069613          	slli	a2,a3,0x20
    800046c0:	02065613          	srli	a2,a2,0x20
    800046c4:	fff64613          	not	a2,a2
    800046c8:	00e50733          	add	a4,a0,a4
    800046cc:	00c78633          	add	a2,a5,a2
    800046d0:	fff7c683          	lbu	a3,-1(a5)
    800046d4:	fff78793          	addi	a5,a5,-1
    800046d8:	fff70713          	addi	a4,a4,-1
    800046dc:	00d70023          	sb	a3,0(a4)
    800046e0:	fec798e3          	bne	a5,a2,800046d0 <__memmove+0x12c>
    800046e4:	00813403          	ld	s0,8(sp)
    800046e8:	01010113          	addi	sp,sp,16
    800046ec:	00008067          	ret
    800046f0:	02069713          	slli	a4,a3,0x20
    800046f4:	02075713          	srli	a4,a4,0x20
    800046f8:	00170713          	addi	a4,a4,1
    800046fc:	00e50733          	add	a4,a0,a4
    80004700:	00050793          	mv	a5,a0
    80004704:	0005c683          	lbu	a3,0(a1)
    80004708:	00178793          	addi	a5,a5,1
    8000470c:	00158593          	addi	a1,a1,1
    80004710:	fed78fa3          	sb	a3,-1(a5)
    80004714:	fee798e3          	bne	a5,a4,80004704 <__memmove+0x160>
    80004718:	f89ff06f          	j	800046a0 <__memmove+0xfc>

000000008000471c <__putc>:
    8000471c:	fe010113          	addi	sp,sp,-32
    80004720:	00813823          	sd	s0,16(sp)
    80004724:	00113c23          	sd	ra,24(sp)
    80004728:	02010413          	addi	s0,sp,32
    8000472c:	00050793          	mv	a5,a0
    80004730:	fef40593          	addi	a1,s0,-17
    80004734:	00100613          	li	a2,1
    80004738:	00000513          	li	a0,0
    8000473c:	fef407a3          	sb	a5,-17(s0)
    80004740:	fffff097          	auipc	ra,0xfffff
    80004744:	b3c080e7          	jalr	-1220(ra) # 8000327c <console_write>
    80004748:	01813083          	ld	ra,24(sp)
    8000474c:	01013403          	ld	s0,16(sp)
    80004750:	02010113          	addi	sp,sp,32
    80004754:	00008067          	ret

0000000080004758 <__getc>:
    80004758:	fe010113          	addi	sp,sp,-32
    8000475c:	00813823          	sd	s0,16(sp)
    80004760:	00113c23          	sd	ra,24(sp)
    80004764:	02010413          	addi	s0,sp,32
    80004768:	fe840593          	addi	a1,s0,-24
    8000476c:	00100613          	li	a2,1
    80004770:	00000513          	li	a0,0
    80004774:	fffff097          	auipc	ra,0xfffff
    80004778:	ae8080e7          	jalr	-1304(ra) # 8000325c <console_read>
    8000477c:	fe844503          	lbu	a0,-24(s0)
    80004780:	01813083          	ld	ra,24(sp)
    80004784:	01013403          	ld	s0,16(sp)
    80004788:	02010113          	addi	sp,sp,32
    8000478c:	00008067          	ret

0000000080004790 <console_handler>:
    80004790:	fe010113          	addi	sp,sp,-32
    80004794:	00813823          	sd	s0,16(sp)
    80004798:	00113c23          	sd	ra,24(sp)
    8000479c:	00913423          	sd	s1,8(sp)
    800047a0:	02010413          	addi	s0,sp,32
    800047a4:	14202773          	csrr	a4,scause
    800047a8:	100027f3          	csrr	a5,sstatus
    800047ac:	0027f793          	andi	a5,a5,2
    800047b0:	06079e63          	bnez	a5,8000482c <console_handler+0x9c>
    800047b4:	00074c63          	bltz	a4,800047cc <console_handler+0x3c>
    800047b8:	01813083          	ld	ra,24(sp)
    800047bc:	01013403          	ld	s0,16(sp)
    800047c0:	00813483          	ld	s1,8(sp)
    800047c4:	02010113          	addi	sp,sp,32
    800047c8:	00008067          	ret
    800047cc:	0ff77713          	andi	a4,a4,255
    800047d0:	00900793          	li	a5,9
    800047d4:	fef712e3          	bne	a4,a5,800047b8 <console_handler+0x28>
    800047d8:	ffffe097          	auipc	ra,0xffffe
    800047dc:	6dc080e7          	jalr	1756(ra) # 80002eb4 <plic_claim>
    800047e0:	00a00793          	li	a5,10
    800047e4:	00050493          	mv	s1,a0
    800047e8:	02f50c63          	beq	a0,a5,80004820 <console_handler+0x90>
    800047ec:	fc0506e3          	beqz	a0,800047b8 <console_handler+0x28>
    800047f0:	00050593          	mv	a1,a0
    800047f4:	00001517          	auipc	a0,0x1
    800047f8:	a0450513          	addi	a0,a0,-1532 # 800051f8 <_ZZ12printIntegermE6digits+0xe0>
    800047fc:	fffff097          	auipc	ra,0xfffff
    80004800:	afc080e7          	jalr	-1284(ra) # 800032f8 <__printf>
    80004804:	01013403          	ld	s0,16(sp)
    80004808:	01813083          	ld	ra,24(sp)
    8000480c:	00048513          	mv	a0,s1
    80004810:	00813483          	ld	s1,8(sp)
    80004814:	02010113          	addi	sp,sp,32
    80004818:	ffffe317          	auipc	t1,0xffffe
    8000481c:	6d430067          	jr	1748(t1) # 80002eec <plic_complete>
    80004820:	fffff097          	auipc	ra,0xfffff
    80004824:	3e0080e7          	jalr	992(ra) # 80003c00 <uartintr>
    80004828:	fddff06f          	j	80004804 <console_handler+0x74>
    8000482c:	00001517          	auipc	a0,0x1
    80004830:	acc50513          	addi	a0,a0,-1332 # 800052f8 <digits+0x78>
    80004834:	fffff097          	auipc	ra,0xfffff
    80004838:	a68080e7          	jalr	-1432(ra) # 8000329c <panic>
	...
