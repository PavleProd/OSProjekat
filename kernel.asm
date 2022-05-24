
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	cc813103          	ld	sp,-824(sp) # 80005cc8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	760020ef          	jal	ra,8000277c <start>

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
    8000100c:	285000ef          	jal	ra,80001a90 <_ZN3PCB10getContextEv>
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
    8000109c:	408000ef          	jal	ra,800014a4 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	1f1000ef          	jal	ra,80001a90 <_ZN3PCB10getContextEv>

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

int sem_wait (sem_t volatile handle) {
    80001378:	fe010113          	addi	sp,sp,-32
    8000137c:	00113c23          	sd	ra,24(sp)
    80001380:	00813823          	sd	s0,16(sp)
    80001384:	02010413          	addi	s0,sp,32
    80001388:	fea43423          	sd	a0,-24(s0)
    size_t code = Kernel::sysCallCodes::sem_wait;
    if(handle == nullptr) return -1;
    8000138c:	fe843783          	ld	a5,-24(s0)
    80001390:	04078463          	beqz	a5,800013d8 <_Z8sem_waitP3SCB+0x60>
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

    if(PCB::running->isSemaphoreDeleted()) return -2; // semafor je obrisan pre nego sto je proces odblokiran
    800013b0:	00005797          	auipc	a5,0x5
    800013b4:	9207b783          	ld	a5,-1760(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013b8:	0007b783          	ld	a5,0(a5)
    bool isFinished() const {
        return finished;
    }
    // vraca true ako je semafor obrisan pre nego sto je proces odblokiran
    bool isSemaphoreDeleted() const {
        return semDeleted;
    800013bc:	02a7c783          	lbu	a5,42(a5)
    800013c0:	02079063          	bnez	a5,800013e0 <_Z8sem_waitP3SCB+0x68>

    return 0;
    800013c4:	00000513          	li	a0,0
}
    800013c8:	01813083          	ld	ra,24(sp)
    800013cc:	01013403          	ld	s0,16(sp)
    800013d0:	02010113          	addi	sp,sp,32
    800013d4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013d8:	fff00513          	li	a0,-1
    800013dc:	fedff06f          	j	800013c8 <_Z8sem_waitP3SCB+0x50>
    if(PCB::running->isSemaphoreDeleted()) return -2; // semafor je obrisan pre nego sto je proces odblokiran
    800013e0:	ffe00513          	li	a0,-2
    800013e4:	fe5ff06f          	j	800013c8 <_Z8sem_waitP3SCB+0x50>

00000000800013e8 <_Z10sem_signalP3SCB>:

int sem_signal (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(handle == nullptr) return -1;
    800013e8:	04050663          	beqz	a0,80001434 <_Z10sem_signalP3SCB+0x4c>
int sem_signal (sem_t handle) {
    800013ec:	fe010113          	addi	sp,sp,-32
    800013f0:	00113c23          	sd	ra,24(sp)
    800013f4:	00813823          	sd	s0,16(sp)
    800013f8:	02010413          	addi	s0,sp,32
    asm volatile("mv a1, a0");
    800013fc:	00050593          	mv	a1,a0

    PCB* process = (PCB*)callInterrupt(code);
    80001400:	02400513          	li	a0,36
    80001404:	00000097          	auipc	ra,0x0
    80001408:	d4c080e7          	jalr	-692(ra) # 80001150 <_Z13callInterruptm>
    8000140c:	fea43423          	sd	a0,-24(s0)
    if(process) {
    80001410:	02050663          	beqz	a0,8000143c <_Z10sem_signalP3SCB+0x54>
        thread_start(&process);
    80001414:	fe840513          	addi	a0,s0,-24
    80001418:	00000097          	auipc	ra,0x0
    8000141c:	e98080e7          	jalr	-360(ra) # 800012b0 <_Z12thread_startPP3PCB>
    }

    return 0;
    80001420:	00000513          	li	a0,0
}
    80001424:	01813083          	ld	ra,24(sp)
    80001428:	01013403          	ld	s0,16(sp)
    8000142c:	02010113          	addi	sp,sp,32
    80001430:	00008067          	ret
    if(handle == nullptr) return -1;
    80001434:	fff00513          	li	a0,-1
}
    80001438:	00008067          	ret
    return 0;
    8000143c:	00000513          	li	a0,0
    80001440:	fe5ff06f          	j	80001424 <_Z10sem_signalP3SCB+0x3c>

0000000080001444 <_Z9sem_closeP3SCB>:

int sem_close (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_close;
    if(handle == nullptr) return -1;
    80001444:	02050c63          	beqz	a0,8000147c <_Z9sem_closeP3SCB+0x38>
int sem_close (sem_t handle) {
    80001448:	ff010113          	addi	sp,sp,-16
    8000144c:	00113423          	sd	ra,8(sp)
    80001450:	00813023          	sd	s0,0(sp)
    80001454:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001458:	00050593          	mv	a1,a0
    callInterrupt(code);
    8000145c:	02200513          	li	a0,34
    80001460:	00000097          	auipc	ra,0x0
    80001464:	cf0080e7          	jalr	-784(ra) # 80001150 <_Z13callInterruptm>
    return 0;
    80001468:	00000513          	li	a0,0
}
    8000146c:	00813083          	ld	ra,8(sp)
    80001470:	00013403          	ld	s0,0(sp)
    80001474:	01010113          	addi	sp,sp,16
    80001478:	00008067          	ret
    if(handle == nullptr) return -1;
    8000147c:	fff00513          	li	a0,-1
}
    80001480:	00008067          	ret

0000000080001484 <_ZN6Kernel10popSppSpieEv>:
#include "../h/console.h"
#include "../h/print.h"
#include "../h/Scheduler.h"
#include "../h/SCB.h"

void Kernel::popSppSpie() {
    80001484:	ff010113          	addi	sp,sp,-16
    80001488:	00813423          	sd	s0,8(sp)
    8000148c:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001490:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001494:	10200073          	sret
}
    80001498:	00813403          	ld	s0,8(sp)
    8000149c:	01010113          	addi	sp,sp,16
    800014a0:	00008067          	ret

00000000800014a4 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    800014a4:	fa010113          	addi	sp,sp,-96
    800014a8:	04113c23          	sd	ra,88(sp)
    800014ac:	04813823          	sd	s0,80(sp)
    800014b0:	04913423          	sd	s1,72(sp)
    800014b4:	05213023          	sd	s2,64(sp)
    800014b8:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800014bc:	142027f3          	csrr	a5,scause
    800014c0:	fcf43023          	sd	a5,-64(s0)
        return scause;
    800014c4:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    800014c8:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800014cc:	141027f3          	csrr	a5,sepc
    800014d0:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    800014d4:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    800014d8:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800014dc:	100027f3          	csrr	a5,sstatus
    800014e0:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    800014e4:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    800014e8:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800014ec:	fd843703          	ld	a4,-40(s0)
    800014f0:	00900793          	li	a5,9
    800014f4:	04f70263          	beq	a4,a5,80001538 <interruptHandler+0x94>
    800014f8:	fd843703          	ld	a4,-40(s0)
    800014fc:	00800793          	li	a5,8
    80001500:	02f70c63          	beq	a4,a5,80001538 <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    80001504:	fd843703          	ld	a4,-40(s0)
    80001508:	fff00793          	li	a5,-1
    8000150c:	03f79793          	slli	a5,a5,0x3f
    80001510:	00178793          	addi	a5,a5,1
    80001514:	24f70663          	beq	a4,a5,80001760 <interruptHandler+0x2bc>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    80001518:	fd843703          	ld	a4,-40(s0)
    8000151c:	fff00793          	li	a5,-1
    80001520:	03f79793          	slli	a5,a5,0x3f
    80001524:	00978793          	addi	a5,a5,9
    80001528:	28f70a63          	beq	a4,a5,800017bc <interruptHandler+0x318>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    8000152c:	00001097          	auipc	ra,0x1
    80001530:	198080e7          	jalr	408(ra) # 800026c4 <_Z10printErrorv>
    80001534:	0840006f          	j	800015b8 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001538:	fd043783          	ld	a5,-48(s0)
    8000153c:	00478793          	addi	a5,a5,4
    80001540:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    80001544:	00004797          	auipc	a5,0x4
    80001548:	78c7b783          	ld	a5,1932(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000154c:	0007b683          	ld	a3,0(a5)
    80001550:	0186b703          	ld	a4,24(a3)
    80001554:	05073783          	ld	a5,80(a4)
    80001558:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    8000155c:	fa843783          	ld	a5,-88(s0)
    80001560:	02400613          	li	a2,36
    80001564:	1ef66863          	bltu	a2,a5,80001754 <interruptHandler+0x2b0>
    80001568:	00279793          	slli	a5,a5,0x2
    8000156c:	00004617          	auipc	a2,0x4
    80001570:	ab460613          	addi	a2,a2,-1356 # 80005020 <CONSOLE_STATUS+0x10>
    80001574:	00c787b3          	add	a5,a5,a2
    80001578:	0007a783          	lw	a5,0(a5)
    8000157c:	00c787b3          	add	a5,a5,a2
    80001580:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    80001584:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    80001588:	00651513          	slli	a0,a0,0x6
    8000158c:	00001097          	auipc	ra,0x1
    80001590:	cfc080e7          	jalr	-772(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
    80001594:	00004797          	auipc	a5,0x4
    80001598:	73c7b783          	ld	a5,1852(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000159c:	0007b783          	ld	a5,0(a5)
    800015a0:	0187b783          	ld	a5,24(a5)
    800015a4:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    800015a8:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015ac:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    800015b0:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015b4:	10079073          	csrw	sstatus,a5
    }

}
    800015b8:	05813083          	ld	ra,88(sp)
    800015bc:	05013403          	ld	s0,80(sp)
    800015c0:	04813483          	ld	s1,72(sp)
    800015c4:	04013903          	ld	s2,64(sp)
    800015c8:	06010113          	addi	sp,sp,96
    800015cc:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    800015d0:	05873503          	ld	a0,88(a4)
    800015d4:	00001097          	auipc	ra,0x1
    800015d8:	e18080e7          	jalr	-488(ra) # 800023ec <_ZN15MemoryAllocator8mem_freeEPv>
    800015dc:	00004797          	auipc	a5,0x4
    800015e0:	6f47b783          	ld	a5,1780(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800015e4:	0007b783          	ld	a5,0(a5)
    800015e8:	0187b783          	ld	a5,24(a5)
    800015ec:	04a7b823          	sd	a0,80(a5)
                break;
    800015f0:	fb9ff06f          	j	800015a8 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    800015f4:	00004797          	auipc	a5,0x4
    800015f8:	6cc7b783          	ld	a5,1740(a5) # 80005cc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800015fc:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001600:	00000097          	auipc	ra,0x0
    80001604:	234080e7          	jalr	564(ra) # 80001834 <_ZN3PCB8dispatchEv>
                break;
    80001608:	fa1ff06f          	j	800015a8 <interruptHandler+0x104>
                PCB::running->finished = true;
    8000160c:	00100793          	li	a5,1
    80001610:	02f68423          	sb	a5,40(a3)
                PCB::timeSliceCounter = 0;
    80001614:	00004797          	auipc	a5,0x4
    80001618:	6ac7b783          	ld	a5,1708(a5) # 80005cc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000161c:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001620:	00000097          	auipc	ra,0x0
    80001624:	214080e7          	jalr	532(ra) # 80001834 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    80001628:	00004797          	auipc	a5,0x4
    8000162c:	6a87b783          	ld	a5,1704(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001630:	0007b783          	ld	a5,0(a5)
    80001634:	0187b783          	ld	a5,24(a5)
    80001638:	0407b823          	sd	zero,80(a5)
                break;
    8000163c:	f6dff06f          	j	800015a8 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    80001640:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    80001644:	0007b503          	ld	a0,0(a5)
    80001648:	00000097          	auipc	ra,0x0
    8000164c:	46c080e7          	jalr	1132(ra) # 80001ab4 <_ZN9Scheduler3putEP3PCB>
                break;
    80001650:	f59ff06f          	j	800015a8 <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    80001654:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    80001658:	06873583          	ld	a1,104(a4)
    8000165c:	06073503          	ld	a0,96(a4)
    80001660:	00000097          	auipc	ra,0x0
    80001664:	3a8080e7          	jalr	936(ra) # 80001a08 <_ZN3PCB14createProccessEPFvvEPv>
    80001668:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    8000166c:	00004797          	auipc	a5,0x4
    80001670:	6647b783          	ld	a5,1636(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001674:	0007b783          	ld	a5,0(a5)
    80001678:	0187b703          	ld	a4,24(a5)
    8000167c:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    80001680:	0004b703          	ld	a4,0(s1)
    80001684:	f20702e3          	beqz	a4,800015a8 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001688:	0187b783          	ld	a5,24(a5)
    8000168c:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001690:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001694:	00008737          	lui	a4,0x8
    80001698:	00e787b3          	add	a5,a5,a4
    8000169c:	0004b703          	ld	a4,0(s1)
    800016a0:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    800016a4:	00f73823          	sd	a5,16(a4)
                break;
    800016a8:	f01ff06f          	j	800015a8 <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    800016ac:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    800016b0:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    800016b4:	01800513          	li	a0,24
    800016b8:	00001097          	auipc	ra,0x1
    800016bc:	b1c080e7          	jalr	-1252(ra) # 800021d4 <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    800016c0:	00053023          	sd	zero,0(a0)
    800016c4:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    800016c8:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    800016cc:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016d0:	00004797          	auipc	a5,0x4
    800016d4:	6007b783          	ld	a5,1536(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800016d8:	0007b783          	ld	a5,0(a5)
    800016dc:	0187b783          	ld	a5,24(a5)
    800016e0:	0497b823          	sd	s1,80(a5)
                break;
    800016e4:	ec5ff06f          	j	800015a8 <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // true kao proces treba da se blokira, false ako ne
    800016e8:	05873503          	ld	a0,88(a4)
    800016ec:	00001097          	auipc	ra,0x1
    800016f0:	a5c080e7          	jalr	-1444(ra) # 80002148 <_ZN3SCB4waitEv>
    800016f4:	00004797          	auipc	a5,0x4
    800016f8:	5dc7b783          	ld	a5,1500(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800016fc:	0007b783          	ld	a5,0(a5)
    80001700:	0187b783          	ld	a5,24(a5)
    80001704:	04a7b823          	sd	a0,80(a5)
                break;
    80001708:	ea1ff06f          	j	800015a8 <interruptHandler+0x104>
                PCB::running->registers[10] = (size_t)sem->signal(); // vraca pokazivac na PCB ako ga treba staviti u Scheduler
    8000170c:	05873503          	ld	a0,88(a4)
    80001710:	00001097          	auipc	ra,0x1
    80001714:	a80080e7          	jalr	-1408(ra) # 80002190 <_ZN3SCB6signalEv>
    80001718:	00004797          	auipc	a5,0x4
    8000171c:	5b87b783          	ld	a5,1464(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001720:	0007b783          	ld	a5,0(a5)
    80001724:	0187b783          	ld	a5,24(a5)
    80001728:	04a7b823          	sd	a0,80(a5)
                break;
    8000172c:	e7dff06f          	j	800015a8 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001730:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    80001734:	00048513          	mv	a0,s1
    80001738:	00001097          	auipc	ra,0x1
    8000173c:	aec080e7          	jalr	-1300(ra) # 80002224 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    80001740:	e60484e3          	beqz	s1,800015a8 <interruptHandler+0x104>
    80001744:	00048513          	mv	a0,s1
    80001748:	00001097          	auipc	ra,0x1
    8000174c:	ab4080e7          	jalr	-1356(ra) # 800021fc <_ZN3SCBdlEPv>
    80001750:	e59ff06f          	j	800015a8 <interruptHandler+0x104>
                printError();
    80001754:	00001097          	auipc	ra,0x1
    80001758:	f70080e7          	jalr	-144(ra) # 800026c4 <_Z10printErrorv>
                break;
    8000175c:	e4dff06f          	j	800015a8 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    80001760:	00004717          	auipc	a4,0x4
    80001764:	56073703          	ld	a4,1376(a4) # 80005cc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001768:	00073783          	ld	a5,0(a4)
    8000176c:	00178793          	addi	a5,a5,1
    80001770:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001774:	00004717          	auipc	a4,0x4
    80001778:	55c73703          	ld	a4,1372(a4) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000177c:	00073703          	ld	a4,0(a4)
    80001780:	03873703          	ld	a4,56(a4)
    80001784:	00e7f863          	bgeu	a5,a4,80001794 <interruptHandler+0x2f0>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001788:	00200793          	li	a5,2
    8000178c:	1447b073          	csrc	sip,a5
    }
    80001790:	e29ff06f          	j	800015b8 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    80001794:	00004797          	auipc	a5,0x4
    80001798:	52c7b783          	ld	a5,1324(a5) # 80005cc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000179c:	0007b023          	sd	zero,0(a5)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800017a0:	00000097          	auipc	ra,0x0
    800017a4:	094080e7          	jalr	148(ra) # 80001834 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800017a8:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017ac:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800017b0:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017b4:	10079073          	csrw	sstatus,a5
    }
    800017b8:	fd1ff06f          	j	80001788 <interruptHandler+0x2e4>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    800017bc:	00003097          	auipc	ra,0x3
    800017c0:	0f4080e7          	jalr	244(ra) # 800048b0 <console_handler>
    800017c4:	df5ff06f          	j	800015b8 <interruptHandler+0x114>

00000000800017c8 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    800017c8:	ff010113          	addi	sp,sp,-16
    800017cc:	00113423          	sd	ra,8(sp)
    800017d0:	00813023          	sd	s0,0(sp)
    800017d4:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	cac080e7          	jalr	-852(ra) # 80001484 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    800017e0:	00004797          	auipc	a5,0x4
    800017e4:	5507b783          	ld	a5,1360(a5) # 80005d30 <_ZN3PCB7runningE>
    800017e8:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    800017ec:	00070513          	mv	a0,a4
    running->main();
    800017f0:	0207b783          	ld	a5,32(a5)
    800017f4:	000780e7          	jalr	a5
    thread_exit();
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	a88080e7          	jalr	-1400(ra) # 80001280 <_Z11thread_exitv>
}
    80001800:	00813083          	ld	ra,8(sp)
    80001804:	00013403          	ld	s0,0(sp)
    80001808:	01010113          	addi	sp,sp,16
    8000180c:	00008067          	ret

0000000080001810 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001810:	ff010113          	addi	sp,sp,-16
    80001814:	00813423          	sd	s0,8(sp)
    80001818:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    8000181c:	01300793          	li	a5,19
    80001820:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001824:	00000073          	ecall
}
    80001828:	00813403          	ld	s0,8(sp)
    8000182c:	01010113          	addi	sp,sp,16
    80001830:	00008067          	ret

0000000080001834 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001834:	fe010113          	addi	sp,sp,-32
    80001838:	00113c23          	sd	ra,24(sp)
    8000183c:	00813823          	sd	s0,16(sp)
    80001840:	00913423          	sd	s1,8(sp)
    80001844:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001848:	00004497          	auipc	s1,0x4
    8000184c:	4e84b483          	ld	s1,1256(s1) # 80005d30 <_ZN3PCB7runningE>
        return finished;
    80001850:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001854:	00079663          	bnez	a5,80001860 <_ZN3PCB8dispatchEv+0x2c>
    80001858:	0294c783          	lbu	a5,41(s1)
    8000185c:	04078263          	beqz	a5,800018a0 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001860:	00000097          	auipc	ra,0x0
    80001864:	2ac080e7          	jalr	684(ra) # 80001b0c <_ZN9Scheduler3getEv>
    80001868:	00004797          	auipc	a5,0x4
    8000186c:	4ca7b423          	sd	a0,1224(a5) # 80005d30 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001870:	04054783          	lbu	a5,64(a0)
    80001874:	02078e63          	beqz	a5,800018b0 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001878:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    8000187c:	01853583          	ld	a1,24(a0)
    80001880:	0184b503          	ld	a0,24(s1)
    80001884:	00000097          	auipc	ra,0x0
    80001888:	8a4080e7          	jalr	-1884(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    8000188c:	01813083          	ld	ra,24(sp)
    80001890:	01013403          	ld	s0,16(sp)
    80001894:	00813483          	ld	s1,8(sp)
    80001898:	02010113          	addi	sp,sp,32
    8000189c:	00008067          	ret
        Scheduler::put(old);
    800018a0:	00048513          	mv	a0,s1
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	210080e7          	jalr	528(ra) # 80001ab4 <_ZN9Scheduler3putEP3PCB>
    800018ac:	fb5ff06f          	j	80001860 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    800018b0:	01853583          	ld	a1,24(a0)
    800018b4:	0184b503          	ld	a0,24(s1)
    800018b8:	00000097          	auipc	ra,0x0
    800018bc:	884080e7          	jalr	-1916(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    800018c0:	fcdff06f          	j	8000188c <_ZN3PCB8dispatchEv+0x58>

00000000800018c4 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    800018c4:	fe010113          	addi	sp,sp,-32
    800018c8:	00113c23          	sd	ra,24(sp)
    800018cc:	00813823          	sd	s0,16(sp)
    800018d0:	00913423          	sd	s1,8(sp)
    800018d4:	02010413          	addi	s0,sp,32
    800018d8:	00050493          	mv	s1,a0
    800018dc:	00053023          	sd	zero,0(a0)
    800018e0:	00053c23          	sd	zero,24(a0)
    800018e4:	00100793          	li	a5,1
    800018e8:	04f50023          	sb	a5,64(a0)
    finished = blocked = semDeleted = false;
    800018ec:	02050523          	sb	zero,42(a0)
    800018f0:	020504a3          	sb	zero,41(a0)
    800018f4:	02050423          	sb	zero,40(a0)
    main = main_;
    800018f8:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    800018fc:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    80001900:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001904:	10800513          	li	a0,264
    80001908:	00001097          	auipc	ra,0x1
    8000190c:	980080e7          	jalr	-1664(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
    80001910:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001914:	00008537          	lui	a0,0x8
    80001918:	00001097          	auipc	ra,0x1
    8000191c:	970080e7          	jalr	-1680(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
    80001920:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001924:	000087b7          	lui	a5,0x8
    80001928:	00f50533          	add	a0,a0,a5
    8000192c:	0184b783          	ld	a5,24(s1)
    80001930:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001934:	0184b783          	ld	a5,24(s1)
    80001938:	00000717          	auipc	a4,0x0
    8000193c:	e9070713          	addi	a4,a4,-368 # 800017c8 <_ZN3PCB15proccessWrapperEv>
    80001940:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001944:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001948:	0204b783          	ld	a5,32(s1)
    8000194c:	00078c63          	beqz	a5,80001964 <_ZN3PCBC1EPFvvEmPv+0xa0>
}
    80001950:	01813083          	ld	ra,24(sp)
    80001954:	01013403          	ld	s0,16(sp)
    80001958:	00813483          	ld	s1,8(sp)
    8000195c:	02010113          	addi	sp,sp,32
    80001960:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001964:	04048023          	sb	zero,64(s1)
}
    80001968:	fe9ff06f          	j	80001950 <_ZN3PCBC1EPFvvEmPv+0x8c>

000000008000196c <_ZN3PCBD1Ev>:
PCB::~PCB() {
    8000196c:	fe010113          	addi	sp,sp,-32
    80001970:	00113c23          	sd	ra,24(sp)
    80001974:	00813823          	sd	s0,16(sp)
    80001978:	00913423          	sd	s1,8(sp)
    8000197c:	02010413          	addi	s0,sp,32
    80001980:	00050493          	mv	s1,a0
    delete[] stack;
    80001984:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001988:	00050663          	beqz	a0,80001994 <_ZN3PCBD1Ev+0x28>
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	55c080e7          	jalr	1372(ra) # 80001ee8 <_ZdaPv>
    delete[] sysStack;
    80001994:	0104b503          	ld	a0,16(s1)
    80001998:	00050663          	beqz	a0,800019a4 <_ZN3PCBD1Ev+0x38>
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	54c080e7          	jalr	1356(ra) # 80001ee8 <_ZdaPv>
}
    800019a4:	01813083          	ld	ra,24(sp)
    800019a8:	01013403          	ld	s0,16(sp)
    800019ac:	00813483          	ld	s1,8(sp)
    800019b0:	02010113          	addi	sp,sp,32
    800019b4:	00008067          	ret

00000000800019b8 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    800019b8:	ff010113          	addi	sp,sp,-16
    800019bc:	00113423          	sd	ra,8(sp)
    800019c0:	00813023          	sd	s0,0(sp)
    800019c4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800019c8:	00001097          	auipc	ra,0x1
    800019cc:	8c0080e7          	jalr	-1856(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
}
    800019d0:	00813083          	ld	ra,8(sp)
    800019d4:	00013403          	ld	s0,0(sp)
    800019d8:	01010113          	addi	sp,sp,16
    800019dc:	00008067          	ret

00000000800019e0 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    800019e0:	ff010113          	addi	sp,sp,-16
    800019e4:	00113423          	sd	ra,8(sp)
    800019e8:	00813023          	sd	s0,0(sp)
    800019ec:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800019f0:	00001097          	auipc	ra,0x1
    800019f4:	9fc080e7          	jalr	-1540(ra) # 800023ec <_ZN15MemoryAllocator8mem_freeEPv>
}
    800019f8:	00813083          	ld	ra,8(sp)
    800019fc:	00013403          	ld	s0,0(sp)
    80001a00:	01010113          	addi	sp,sp,16
    80001a04:	00008067          	ret

0000000080001a08 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001a08:	fd010113          	addi	sp,sp,-48
    80001a0c:	02113423          	sd	ra,40(sp)
    80001a10:	02813023          	sd	s0,32(sp)
    80001a14:	00913c23          	sd	s1,24(sp)
    80001a18:	01213823          	sd	s2,16(sp)
    80001a1c:	01313423          	sd	s3,8(sp)
    80001a20:	03010413          	addi	s0,sp,48
    80001a24:	00050913          	mv	s2,a0
    80001a28:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001a2c:	04800513          	li	a0,72
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	f88080e7          	jalr	-120(ra) # 800019b8 <_ZN3PCBnwEm>
    80001a38:	00050493          	mv	s1,a0
    80001a3c:	00098693          	mv	a3,s3
    80001a40:	00200613          	li	a2,2
    80001a44:	00090593          	mv	a1,s2
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	e7c080e7          	jalr	-388(ra) # 800018c4 <_ZN3PCBC1EPFvvEmPv>
    80001a50:	0200006f          	j	80001a70 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001a54:	00050913          	mv	s2,a0
    80001a58:	00048513          	mv	a0,s1
    80001a5c:	00000097          	auipc	ra,0x0
    80001a60:	f84080e7          	jalr	-124(ra) # 800019e0 <_ZN3PCBdlEPv>
    80001a64:	00090513          	mv	a0,s2
    80001a68:	00005097          	auipc	ra,0x5
    80001a6c:	3d0080e7          	jalr	976(ra) # 80006e38 <_Unwind_Resume>
}
    80001a70:	00048513          	mv	a0,s1
    80001a74:	02813083          	ld	ra,40(sp)
    80001a78:	02013403          	ld	s0,32(sp)
    80001a7c:	01813483          	ld	s1,24(sp)
    80001a80:	01013903          	ld	s2,16(sp)
    80001a84:	00813983          	ld	s3,8(sp)
    80001a88:	03010113          	addi	sp,sp,48
    80001a8c:	00008067          	ret

0000000080001a90 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001a90:	ff010113          	addi	sp,sp,-16
    80001a94:	00813423          	sd	s0,8(sp)
    80001a98:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001a9c:	00004797          	auipc	a5,0x4
    80001aa0:	2947b783          	ld	a5,660(a5) # 80005d30 <_ZN3PCB7runningE>
    80001aa4:	0187b503          	ld	a0,24(a5)
    80001aa8:	00813403          	ld	s0,8(sp)
    80001aac:	01010113          	addi	sp,sp,16
    80001ab0:	00008067          	ret

0000000080001ab4 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001ab4:	ff010113          	addi	sp,sp,-16
    80001ab8:	00813423          	sd	s0,8(sp)
    80001abc:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001ac0:	02050663          	beqz	a0,80001aec <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001ac4:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001ac8:	00004797          	auipc	a5,0x4
    80001acc:	2787b783          	ld	a5,632(a5) # 80005d40 <_ZN9Scheduler4tailE>
    80001ad0:	02078463          	beqz	a5,80001af8 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001ad4:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001ad8:	00004797          	auipc	a5,0x4
    80001adc:	26878793          	addi	a5,a5,616 # 80005d40 <_ZN9Scheduler4tailE>
    80001ae0:	0007b703          	ld	a4,0(a5)
    80001ae4:	00073703          	ld	a4,0(a4)
    80001ae8:	00e7b023          	sd	a4,0(a5)
    }
}
    80001aec:	00813403          	ld	s0,8(sp)
    80001af0:	01010113          	addi	sp,sp,16
    80001af4:	00008067          	ret
        head = tail = process;
    80001af8:	00004797          	auipc	a5,0x4
    80001afc:	24878793          	addi	a5,a5,584 # 80005d40 <_ZN9Scheduler4tailE>
    80001b00:	00a7b023          	sd	a0,0(a5)
    80001b04:	00a7b423          	sd	a0,8(a5)
    80001b08:	fe5ff06f          	j	80001aec <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001b0c <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001b0c:	ff010113          	addi	sp,sp,-16
    80001b10:	00813423          	sd	s0,8(sp)
    80001b14:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001b18:	00004517          	auipc	a0,0x4
    80001b1c:	23053503          	ld	a0,560(a0) # 80005d48 <_ZN9Scheduler4headE>
    80001b20:	02050463          	beqz	a0,80001b48 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001b24:	00053703          	ld	a4,0(a0)
    80001b28:	00004797          	auipc	a5,0x4
    80001b2c:	21878793          	addi	a5,a5,536 # 80005d40 <_ZN9Scheduler4tailE>
    80001b30:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001b34:	0007b783          	ld	a5,0(a5)
    80001b38:	00f50e63          	beq	a0,a5,80001b54 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001b3c:	00813403          	ld	s0,8(sp)
    80001b40:	01010113          	addi	sp,sp,16
    80001b44:	00008067          	ret
        return idleProcess;
    80001b48:	00004517          	auipc	a0,0x4
    80001b4c:	20853503          	ld	a0,520(a0) # 80005d50 <_ZN9Scheduler11idleProcessE>
    80001b50:	fedff06f          	j	80001b3c <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001b54:	00004797          	auipc	a5,0x4
    80001b58:	1ee7b623          	sd	a4,492(a5) # 80005d40 <_ZN9Scheduler4tailE>
    80001b5c:	fe1ff06f          	j	80001b3c <_ZN9Scheduler3getEv+0x30>

0000000080001b60 <_Z11workerBodyAPv>:
#include "../h/SCB.h"

SCB* semafor;

void workerBodyA(void* arg)
{
    80001b60:	fd010113          	addi	sp,sp,-48
    80001b64:	02113423          	sd	ra,40(sp)
    80001b68:	02813023          	sd	s0,32(sp)
    80001b6c:	00913c23          	sd	s1,24(sp)
    80001b70:	01213823          	sd	s2,16(sp)
    80001b74:	01313423          	sd	s3,8(sp)
    80001b78:	03010413          	addi	s0,sp,48
    80001b7c:	00050913          	mv	s2,a0
    int status = sem_wait(semafor);
    80001b80:	00004517          	auipc	a0,0x4
    80001b84:	1d853503          	ld	a0,472(a0) # 80005d58 <semafor>
    80001b88:	fffff097          	auipc	ra,0xfffff
    80001b8c:	7f0080e7          	jalr	2032(ra) # 80001378 <_Z8sem_waitP3SCB>
    80001b90:	00050493          	mv	s1,a0
    printString("Nit broj: ");
    80001b94:	00003517          	auipc	a0,0x3
    80001b98:	52450513          	addi	a0,a0,1316 # 800050b8 <CONSOLE_STATUS+0xa8>
    80001b9c:	00001097          	auipc	ra,0x1
    80001ba0:	9fc080e7          	jalr	-1540(ra) # 80002598 <_Z11printStringPKc>
    printInteger(*(int*)arg);
    80001ba4:	00092503          	lw	a0,0(s2)
    80001ba8:	00001097          	auipc	ra,0x1
    80001bac:	a60080e7          	jalr	-1440(ra) # 80002608 <_Z12printIntegerm>
    printString("\nStatus: ");
    80001bb0:	00003517          	auipc	a0,0x3
    80001bb4:	51850513          	addi	a0,a0,1304 # 800050c8 <CONSOLE_STATUS+0xb8>
    80001bb8:	00001097          	auipc	ra,0x1
    80001bbc:	9e0080e7          	jalr	-1568(ra) # 80002598 <_Z11printStringPKc>
    printInteger(status+2);
    80001bc0:	0024851b          	addiw	a0,s1,2
    80001bc4:	00001097          	auipc	ra,0x1
    80001bc8:	a44080e7          	jalr	-1468(ra) # 80002608 <_Z12printIntegerm>
    printString("\n");
    80001bcc:	00003517          	auipc	a0,0x3
    80001bd0:	67c50513          	addi	a0,a0,1660 # 80005248 <_ZZ12printIntegermE6digits+0x120>
    80001bd4:	00001097          	auipc	ra,0x1
    80001bd8:	9c4080e7          	jalr	-1596(ra) # 80002598 <_Z11printStringPKc>
    for (uint64 i = 0; i < 3; i++) {
    80001bdc:	00000993          	li	s3,0
    80001be0:	0380006f          	j	80001c18 <_Z11workerBodyAPv+0xb8>
        printString("A: i="); printInteger(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001be4:	fffff097          	auipc	ra,0xfffff
    80001be8:	670080e7          	jalr	1648(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001bec:	00148493          	addi	s1,s1,1
    80001bf0:	000027b7          	lui	a5,0x2
    80001bf4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001bf8:	0097ee63          	bltu	a5,s1,80001c14 <_Z11workerBodyAPv+0xb4>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001bfc:	00000713          	li	a4,0
    80001c00:	000077b7          	lui	a5,0x7
    80001c04:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001c08:	fce7eee3          	bltu	a5,a4,80001be4 <_Z11workerBodyAPv+0x84>
    80001c0c:	00170713          	addi	a4,a4,1
    80001c10:	ff1ff06f          	j	80001c00 <_Z11workerBodyAPv+0xa0>
    for (uint64 i = 0; i < 3; i++) {
    80001c14:	00198993          	addi	s3,s3,1
    80001c18:	00200793          	li	a5,2
    80001c1c:	0337ec63          	bltu	a5,s3,80001c54 <_Z11workerBodyAPv+0xf4>
        printString("A: i="); printInteger(i); printString("\n");
    80001c20:	00003517          	auipc	a0,0x3
    80001c24:	4b850513          	addi	a0,a0,1208 # 800050d8 <CONSOLE_STATUS+0xc8>
    80001c28:	00001097          	auipc	ra,0x1
    80001c2c:	970080e7          	jalr	-1680(ra) # 80002598 <_Z11printStringPKc>
    80001c30:	00098513          	mv	a0,s3
    80001c34:	00001097          	auipc	ra,0x1
    80001c38:	9d4080e7          	jalr	-1580(ra) # 80002608 <_Z12printIntegerm>
    80001c3c:	00003517          	auipc	a0,0x3
    80001c40:	60c50513          	addi	a0,a0,1548 # 80005248 <_ZZ12printIntegermE6digits+0x120>
    80001c44:	00001097          	auipc	ra,0x1
    80001c48:	954080e7          	jalr	-1708(ra) # 80002598 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001c4c:	00000493          	li	s1,0
    80001c50:	fa1ff06f          	j	80001bf0 <_Z11workerBodyAPv+0x90>
        }
    }
    printString("A finished!\n");
    80001c54:	00003517          	auipc	a0,0x3
    80001c58:	48c50513          	addi	a0,a0,1164 # 800050e0 <CONSOLE_STATUS+0xd0>
    80001c5c:	00001097          	auipc	ra,0x1
    80001c60:	93c080e7          	jalr	-1732(ra) # 80002598 <_Z11printStringPKc>
    sem_signal(semafor);
    80001c64:	00004517          	auipc	a0,0x4
    80001c68:	0f453503          	ld	a0,244(a0) # 80005d58 <semafor>
    80001c6c:	fffff097          	auipc	ra,0xfffff
    80001c70:	77c080e7          	jalr	1916(ra) # 800013e8 <_Z10sem_signalP3SCB>
    if(*(int*)arg == 0) {
    80001c74:	00092783          	lw	a5,0(s2)
    80001c78:	02078063          	beqz	a5,80001c98 <_Z11workerBodyAPv+0x138>
        sem_close(semafor);
        semafor = nullptr;
    }
}
    80001c7c:	02813083          	ld	ra,40(sp)
    80001c80:	02013403          	ld	s0,32(sp)
    80001c84:	01813483          	ld	s1,24(sp)
    80001c88:	01013903          	ld	s2,16(sp)
    80001c8c:	00813983          	ld	s3,8(sp)
    80001c90:	03010113          	addi	sp,sp,48
    80001c94:	00008067          	ret
        sem_close(semafor);
    80001c98:	00004497          	auipc	s1,0x4
    80001c9c:	0c048493          	addi	s1,s1,192 # 80005d58 <semafor>
    80001ca0:	0004b503          	ld	a0,0(s1)
    80001ca4:	fffff097          	auipc	ra,0xfffff
    80001ca8:	7a0080e7          	jalr	1952(ra) # 80001444 <_Z9sem_closeP3SCB>
        semafor = nullptr;
    80001cac:	0004b023          	sd	zero,0(s1)
}
    80001cb0:	fcdff06f          	j	80001c7c <_Z11workerBodyAPv+0x11c>

0000000080001cb4 <main>:

extern "C" void interrupt();
int main() {
    80001cb4:	fb010113          	addi	sp,sp,-80
    80001cb8:	04113423          	sd	ra,72(sp)
    80001cbc:	04813023          	sd	s0,64(sp)
    80001cc0:	02913c23          	sd	s1,56(sp)
    80001cc4:	03213823          	sd	s2,48(sp)
    80001cc8:	05010413          	addi	s0,sp,80
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001ccc:	00004797          	auipc	a5,0x4
    80001cd0:	0147b783          	ld	a5,20(a5) # 80005ce0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001cd4:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001cd8:	00000593          	li	a1,0
    80001cdc:	00000513          	li	a0,0
    80001ce0:	00000097          	auipc	ra,0x0
    80001ce4:	d28080e7          	jalr	-728(ra) # 80001a08 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001ce8:	00004797          	auipc	a5,0x4
    80001cec:	fe87b783          	ld	a5,-24(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001cf0:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001cf4:	00200793          	li	a5,2
    80001cf8:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    sem_open(&semafor, 1);
    80001cfc:	00100593          	li	a1,1
    80001d00:	00004517          	auipc	a0,0x4
    80001d04:	05850513          	addi	a0,a0,88 # 80005d58 <semafor>
    80001d08:	fffff097          	auipc	ra,0xfffff
    80001d0c:	628080e7          	jalr	1576(ra) # 80001330 <_Z8sem_openPP3SCBj>
    PCB* procesi[4];
    int niz[4] = {0,1,2,3};
    80001d10:	00003797          	auipc	a5,0x3
    80001d14:	3e078793          	addi	a5,a5,992 # 800050f0 <CONSOLE_STATUS+0xe0>
    80001d18:	0007b703          	ld	a4,0(a5)
    80001d1c:	fae43823          	sd	a4,-80(s0)
    80001d20:	0087b783          	ld	a5,8(a5)
    80001d24:	faf43c23          	sd	a5,-72(s0)
    for(int i = 0; i < 4; i++) {
    80001d28:	00000493          	li	s1,0
    80001d2c:	00300793          	li	a5,3
    80001d30:	0297ce63          	blt	a5,s1,80001d6c <main+0xb8>
        thread_create(&procesi[i], workerBodyA, &niz[i]);
    80001d34:	00249713          	slli	a4,s1,0x2
    80001d38:	00349793          	slli	a5,s1,0x3
    80001d3c:	fb040613          	addi	a2,s0,-80
    80001d40:	00e60633          	add	a2,a2,a4
    80001d44:	00000597          	auipc	a1,0x0
    80001d48:	e1c58593          	addi	a1,a1,-484 # 80001b60 <_Z11workerBodyAPv>
    80001d4c:	fc040513          	addi	a0,s0,-64
    80001d50:	00f50533          	add	a0,a0,a5
    80001d54:	fffff097          	auipc	ra,0xfffff
    80001d58:	58c080e7          	jalr	1420(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    for(int i = 0; i < 4; i++) {
    80001d5c:	0014849b          	addiw	s1,s1,1
    80001d60:	fcdff06f          	j	80001d2c <main+0x78>
    }

    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        Thread::dispatch();
    80001d64:	00000097          	auipc	ra,0x0
    80001d68:	274080e7          	jalr	628(ra) # 80001fd8 <_ZN6Thread8dispatchEv>
    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
    80001d6c:	fc043783          	ld	a5,-64(s0)
    80001d70:	0287c783          	lbu	a5,40(a5)
    80001d74:	fe0788e3          	beqz	a5,80001d64 <main+0xb0>
    80001d78:	fc843783          	ld	a5,-56(s0)
    80001d7c:	0287c783          	lbu	a5,40(a5)
    80001d80:	fe0782e3          	beqz	a5,80001d64 <main+0xb0>
    80001d84:	fd043783          	ld	a5,-48(s0)
    80001d88:	0287c783          	lbu	a5,40(a5)
    80001d8c:	fc078ce3          	beqz	a5,80001d64 <main+0xb0>
    80001d90:	fd843783          	ld	a5,-40(s0)
    80001d94:	0287c783          	lbu	a5,40(a5)
    80001d98:	fc0786e3          	beqz	a5,80001d64 <main+0xb0>
    80001d9c:	fc040493          	addi	s1,s0,-64
    80001da0:	0080006f          	j	80001da8 <main+0xf4>
    }

    for(auto& proces : procesi) {
    80001da4:	00848493          	addi	s1,s1,8
    80001da8:	fe040793          	addi	a5,s0,-32
    80001dac:	02f48463          	beq	s1,a5,80001dd4 <main+0x120>
        delete proces;
    80001db0:	0004b903          	ld	s2,0(s1)
    80001db4:	fe0908e3          	beqz	s2,80001da4 <main+0xf0>
    80001db8:	00090513          	mv	a0,s2
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	bb0080e7          	jalr	-1104(ra) # 8000196c <_ZN3PCBD1Ev>
    80001dc4:	00090513          	mv	a0,s2
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	c18080e7          	jalr	-1000(ra) # 800019e0 <_ZN3PCBdlEPv>
    80001dd0:	fd5ff06f          	j	80001da4 <main+0xf0>
    }

    return 0;
    80001dd4:	00000513          	li	a0,0
    80001dd8:	04813083          	ld	ra,72(sp)
    80001ddc:	04013403          	ld	s0,64(sp)
    80001de0:	03813483          	ld	s1,56(sp)
    80001de4:	03013903          	ld	s2,48(sp)
    80001de8:	05010113          	addi	sp,sp,80
    80001dec:	00008067          	ret

0000000080001df0 <_Z13threadWrapperPv>:
void threadWrapper(void* thread);
Thread::Thread() {
    thread_create_only(&myHandle, threadWrapper, this);
}

void threadWrapper(void* thread) {
    80001df0:	ff010113          	addi	sp,sp,-16
    80001df4:	00113423          	sd	ra,8(sp)
    80001df8:	00813023          	sd	s0,0(sp)
    80001dfc:	01010413          	addi	s0,sp,16
    ((Thread*)thread)->run();
    80001e00:	00053783          	ld	a5,0(a0)
    80001e04:	0107b783          	ld	a5,16(a5)
    80001e08:	000780e7          	jalr	a5
}
    80001e0c:	00813083          	ld	ra,8(sp)
    80001e10:	00013403          	ld	s0,0(sp)
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00008067          	ret

0000000080001e1c <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    80001e1c:	fe010113          	addi	sp,sp,-32
    80001e20:	00113c23          	sd	ra,24(sp)
    80001e24:	00813823          	sd	s0,16(sp)
    80001e28:	00913423          	sd	s1,8(sp)
    80001e2c:	02010413          	addi	s0,sp,32
    80001e30:	00004797          	auipc	a5,0x4
    80001e34:	e6878793          	addi	a5,a5,-408 # 80005c98 <_ZTV6Thread+0x10>
    80001e38:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80001e3c:	00853483          	ld	s1,8(a0)
    80001e40:	00048e63          	beqz	s1,80001e5c <_ZN6ThreadD1Ev+0x40>
    80001e44:	00048513          	mv	a0,s1
    80001e48:	00000097          	auipc	ra,0x0
    80001e4c:	b24080e7          	jalr	-1244(ra) # 8000196c <_ZN3PCBD1Ev>
    80001e50:	00048513          	mv	a0,s1
    80001e54:	00000097          	auipc	ra,0x0
    80001e58:	b8c080e7          	jalr	-1140(ra) # 800019e0 <_ZN3PCBdlEPv>
}
    80001e5c:	01813083          	ld	ra,24(sp)
    80001e60:	01013403          	ld	s0,16(sp)
    80001e64:	00813483          	ld	s1,8(sp)
    80001e68:	02010113          	addi	sp,sp,32
    80001e6c:	00008067          	ret

0000000080001e70 <_Znwm>:
void* operator new (size_t size) {
    80001e70:	ff010113          	addi	sp,sp,-16
    80001e74:	00113423          	sd	ra,8(sp)
    80001e78:	00813023          	sd	s0,0(sp)
    80001e7c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001e80:	fffff097          	auipc	ra,0xfffff
    80001e84:	2f4080e7          	jalr	756(ra) # 80001174 <_Z9mem_allocm>
}
    80001e88:	00813083          	ld	ra,8(sp)
    80001e8c:	00013403          	ld	s0,0(sp)
    80001e90:	01010113          	addi	sp,sp,16
    80001e94:	00008067          	ret

0000000080001e98 <_Znam>:
void* operator new [](size_t size) {
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00113423          	sd	ra,8(sp)
    80001ea0:	00813023          	sd	s0,0(sp)
    80001ea4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001ea8:	fffff097          	auipc	ra,0xfffff
    80001eac:	2cc080e7          	jalr	716(ra) # 80001174 <_Z9mem_allocm>
}
    80001eb0:	00813083          	ld	ra,8(sp)
    80001eb4:	00013403          	ld	s0,0(sp)
    80001eb8:	01010113          	addi	sp,sp,16
    80001ebc:	00008067          	ret

0000000080001ec0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001ec0:	ff010113          	addi	sp,sp,-16
    80001ec4:	00113423          	sd	ra,8(sp)
    80001ec8:	00813023          	sd	s0,0(sp)
    80001ecc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001ed0:	fffff097          	auipc	ra,0xfffff
    80001ed4:	2e4080e7          	jalr	740(ra) # 800011b4 <_Z8mem_freePv>
}
    80001ed8:	00813083          	ld	ra,8(sp)
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	01010113          	addi	sp,sp,16
    80001ee4:	00008067          	ret

0000000080001ee8 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001ee8:	ff010113          	addi	sp,sp,-16
    80001eec:	00113423          	sd	ra,8(sp)
    80001ef0:	00813023          	sd	s0,0(sp)
    80001ef4:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	2bc080e7          	jalr	700(ra) # 800011b4 <_Z8mem_freePv>
}
    80001f00:	00813083          	ld	ra,8(sp)
    80001f04:	00013403          	ld	s0,0(sp)
    80001f08:	01010113          	addi	sp,sp,16
    80001f0c:	00008067          	ret

0000000080001f10 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001f10:	ff010113          	addi	sp,sp,-16
    80001f14:	00113423          	sd	ra,8(sp)
    80001f18:	00813023          	sd	s0,0(sp)
    80001f1c:	01010413          	addi	s0,sp,16
    80001f20:	00004797          	auipc	a5,0x4
    80001f24:	d7878793          	addi	a5,a5,-648 # 80005c98 <_ZTV6Thread+0x10>
    80001f28:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80001f2c:	00850513          	addi	a0,a0,8
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	2b8080e7          	jalr	696(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80001f38:	00813083          	ld	ra,8(sp)
    80001f3c:	00013403          	ld	s0,0(sp)
    80001f40:	01010113          	addi	sp,sp,16
    80001f44:	00008067          	ret

0000000080001f48 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80001f48:	ff010113          	addi	sp,sp,-16
    80001f4c:	00113423          	sd	ra,8(sp)
    80001f50:	00813023          	sd	s0,0(sp)
    80001f54:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001f58:	00000097          	auipc	ra,0x0
    80001f5c:	330080e7          	jalr	816(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001f60:	00813083          	ld	ra,8(sp)
    80001f64:	00013403          	ld	s0,0(sp)
    80001f68:	01010113          	addi	sp,sp,16
    80001f6c:	00008067          	ret

0000000080001f70 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80001f70:	ff010113          	addi	sp,sp,-16
    80001f74:	00113423          	sd	ra,8(sp)
    80001f78:	00813023          	sd	s0,0(sp)
    80001f7c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001f80:	00000097          	auipc	ra,0x0
    80001f84:	46c080e7          	jalr	1132(ra) # 800023ec <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001f88:	00813083          	ld	ra,8(sp)
    80001f8c:	00013403          	ld	s0,0(sp)
    80001f90:	01010113          	addi	sp,sp,16
    80001f94:	00008067          	ret

0000000080001f98 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001f98:	fe010113          	addi	sp,sp,-32
    80001f9c:	00113c23          	sd	ra,24(sp)
    80001fa0:	00813823          	sd	s0,16(sp)
    80001fa4:	00913423          	sd	s1,8(sp)
    80001fa8:	02010413          	addi	s0,sp,32
    80001fac:	00050493          	mv	s1,a0
}
    80001fb0:	00000097          	auipc	ra,0x0
    80001fb4:	e6c080e7          	jalr	-404(ra) # 80001e1c <_ZN6ThreadD1Ev>
    80001fb8:	00048513          	mv	a0,s1
    80001fbc:	00000097          	auipc	ra,0x0
    80001fc0:	fb4080e7          	jalr	-76(ra) # 80001f70 <_ZN6ThreaddlEPv>
    80001fc4:	01813083          	ld	ra,24(sp)
    80001fc8:	01013403          	ld	s0,16(sp)
    80001fcc:	00813483          	ld	s1,8(sp)
    80001fd0:	02010113          	addi	sp,sp,32
    80001fd4:	00008067          	ret

0000000080001fd8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00113423          	sd	ra,8(sp)
    80001fe0:	00813023          	sd	s0,0(sp)
    80001fe4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001fe8:	fffff097          	auipc	ra,0xfffff
    80001fec:	26c080e7          	jalr	620(ra) # 80001254 <_Z15thread_dispatchv>
}
    80001ff0:	00813083          	ld	ra,8(sp)
    80001ff4:	00013403          	ld	s0,0(sp)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <_ZN6Thread5startEv>:
int Thread::start() {
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002010:	00850513          	addi	a0,a0,8
    80002014:	fffff097          	auipc	ra,0xfffff
    80002018:	29c080e7          	jalr	668(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    8000201c:	00000513          	li	a0,0
    80002020:	00813083          	ld	ra,8(sp)
    80002024:	00013403          	ld	s0,0(sp)
    80002028:	01010113          	addi	sp,sp,16
    8000202c:	00008067          	ret

0000000080002030 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002030:	ff010113          	addi	sp,sp,-16
    80002034:	00113423          	sd	ra,8(sp)
    80002038:	00813023          	sd	s0,0(sp)
    8000203c:	01010413          	addi	s0,sp,16
    80002040:	00004797          	auipc	a5,0x4
    80002044:	c5878793          	addi	a5,a5,-936 # 80005c98 <_ZTV6Thread+0x10>
    80002048:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, threadWrapper, this);
    8000204c:	00050613          	mv	a2,a0
    80002050:	00000597          	auipc	a1,0x0
    80002054:	da058593          	addi	a1,a1,-608 # 80001df0 <_Z13threadWrapperPv>
    80002058:	00850513          	addi	a0,a0,8
    8000205c:	fffff097          	auipc	ra,0xfffff
    80002060:	18c080e7          	jalr	396(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80002064:	00813083          	ld	ra,8(sp)
    80002068:	00013403          	ld	s0,0(sp)
    8000206c:	01010113          	addi	sp,sp,16
    80002070:	00008067          	ret

0000000080002074 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002074:	ff010113          	addi	sp,sp,-16
    80002078:	00813423          	sd	s0,8(sp)
    8000207c:	01010413          	addi	s0,sp,16
    80002080:	00813403          	ld	s0,8(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    8000208c:	ff010113          	addi	sp,sp,-16
    80002090:	00813423          	sd	s0,8(sp)
    80002094:	01010413          	addi	s0,sp,16
    PCB::running->nextInList = nullptr;
    80002098:	00004797          	auipc	a5,0x4
    8000209c:	c387b783          	ld	a5,-968(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800020a0:	0007b783          	ld	a5,0(a5)
    800020a4:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800020a8:	00853783          	ld	a5,8(a0)
    800020ac:	04078063          	beqz	a5,800020ec <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->nextInList = PCB::running;
    800020b0:	00004717          	auipc	a4,0x4
    800020b4:	c2073703          	ld	a4,-992(a4) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800020b8:	00073703          	ld	a4,0(a4)
    800020bc:	00e7b023          	sd	a4,0(a5)
        tail = tail->nextInList;
    800020c0:	00853783          	ld	a5,8(a0)
    800020c4:	0007b783          	ld	a5,0(a5)
    800020c8:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->blocked = true;
    800020cc:	00004797          	auipc	a5,0x4
    800020d0:	c047b783          	ld	a5,-1020(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800020d4:	0007b783          	ld	a5,0(a5)
    800020d8:	00100713          	li	a4,1
    800020dc:	02e784a3          	sb	a4,41(a5)
    //PCB::yield(); // ovo treba da radi sistemski poziv
}
    800020e0:	00813403          	ld	s0,8(sp)
    800020e4:	01010113          	addi	sp,sp,16
    800020e8:	00008067          	ret
        head = tail = PCB::running;
    800020ec:	00004797          	auipc	a5,0x4
    800020f0:	be47b783          	ld	a5,-1052(a5) # 80005cd0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800020f4:	0007b783          	ld	a5,0(a5)
    800020f8:	00f53423          	sd	a5,8(a0)
    800020fc:	00f53023          	sd	a5,0(a0)
    80002100:	fcdff06f          	j	800020cc <_ZN3SCB5blockEv+0x40>

0000000080002104 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    80002104:	ff010113          	addi	sp,sp,-16
    80002108:	00813423          	sd	s0,8(sp)
    8000210c:	01010413          	addi	s0,sp,16
    80002110:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    80002114:	00053503          	ld	a0,0(a0)
    80002118:	00050e63          	beqz	a0,80002134 <_ZN3SCB7unblockEv+0x30>
    PCB* curr = head;
    head = head->nextInList;
    8000211c:	00053703          	ld	a4,0(a0)
    80002120:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    80002124:	0087b683          	ld	a3,8(a5)
    80002128:	00d50c63          	beq	a0,a3,80002140 <_ZN3SCB7unblockEv+0x3c>
        tail = head;
    }
    curr->blocked = false;
    8000212c:	020504a3          	sb	zero,41(a0)
    curr->nextInList = nullptr;
    80002130:	00053023          	sd	zero,0(a0)
    return curr;
}
    80002134:	00813403          	ld	s0,8(sp)
    80002138:	01010113          	addi	sp,sp,16
    8000213c:	00008067          	ret
        tail = head;
    80002140:	00e7b423          	sd	a4,8(a5)
    80002144:	fe9ff06f          	j	8000212c <_ZN3SCB7unblockEv+0x28>

0000000080002148 <_ZN3SCB4waitEv>:

bool SCB::wait() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(--semValue)<0) {
    80002148:	01052783          	lw	a5,16(a0)
    8000214c:	fff7879b          	addiw	a5,a5,-1
    80002150:	00f52823          	sw	a5,16(a0)
    80002154:	02079713          	slli	a4,a5,0x20
    80002158:	00074663          	bltz	a4,80002164 <_ZN3SCB4waitEv+0x1c>
        block();
        return true;
    }
    return false;
    8000215c:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    80002160:	00008067          	ret
bool SCB::wait() {
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00113423          	sd	ra,8(sp)
    8000216c:	00813023          	sd	s0,0(sp)
    80002170:	01010413          	addi	s0,sp,16
        block();
    80002174:	00000097          	auipc	ra,0x0
    80002178:	f18080e7          	jalr	-232(ra) # 8000208c <_ZN3SCB5blockEv>
        return true;
    8000217c:	00100513          	li	a0,1
}
    80002180:	00813083          	ld	ra,8(sp)
    80002184:	00013403          	ld	s0,0(sp)
    80002188:	01010113          	addi	sp,sp,16
    8000218c:	00008067          	ret

0000000080002190 <_ZN3SCB6signalEv>:

PCB* SCB::signal() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(++semValue)<=0) {
    80002190:	01052783          	lw	a5,16(a0)
    80002194:	0017879b          	addiw	a5,a5,1
    80002198:	0007871b          	sext.w	a4,a5
    8000219c:	00f52823          	sw	a5,16(a0)
    800021a0:	00e05663          	blez	a4,800021ac <_ZN3SCB6signalEv+0x1c>
        return unblock();
    }
    return nullptr;
    800021a4:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    800021a8:	00008067          	ret
PCB* SCB::signal() {
    800021ac:	ff010113          	addi	sp,sp,-16
    800021b0:	00113423          	sd	ra,8(sp)
    800021b4:	00813023          	sd	s0,0(sp)
    800021b8:	01010413          	addi	s0,sp,16
        return unblock();
    800021bc:	00000097          	auipc	ra,0x0
    800021c0:	f48080e7          	jalr	-184(ra) # 80002104 <_ZN3SCB7unblockEv>
}
    800021c4:	00813083          	ld	ra,8(sp)
    800021c8:	00013403          	ld	s0,0(sp)
    800021cc:	01010113          	addi	sp,sp,16
    800021d0:	00008067          	ret

00000000800021d4 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    800021d4:	ff010113          	addi	sp,sp,-16
    800021d8:	00113423          	sd	ra,8(sp)
    800021dc:	00813023          	sd	s0,0(sp)
    800021e0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	0a4080e7          	jalr	164(ra) # 80002288 <_ZN15MemoryAllocator9mem_allocEm>
}
    800021ec:	00813083          	ld	ra,8(sp)
    800021f0:	00013403          	ld	s0,0(sp)
    800021f4:	01010113          	addi	sp,sp,16
    800021f8:	00008067          	ret

00000000800021fc <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    800021fc:	ff010113          	addi	sp,sp,-16
    80002200:	00113423          	sd	ra,8(sp)
    80002204:	00813023          	sd	s0,0(sp)
    80002208:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    8000220c:	00000097          	auipc	ra,0x0
    80002210:	1e0080e7          	jalr	480(ra) # 800023ec <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002214:	00813083          	ld	ra,8(sp)
    80002218:	00013403          	ld	s0,0(sp)
    8000221c:	01010113          	addi	sp,sp,16
    80002220:	00008067          	ret

0000000080002224 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80002224:	fe010113          	addi	sp,sp,-32
    80002228:	00113c23          	sd	ra,24(sp)
    8000222c:	00813823          	sd	s0,16(sp)
    80002230:	00913423          	sd	s1,8(sp)
    80002234:	01213023          	sd	s2,0(sp)
    80002238:	02010413          	addi	s0,sp,32
    8000223c:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002240:	00053503          	ld	a0,0(a0)
    while(curr) {
    80002244:	02050263          	beqz	a0,80002268 <_ZN3SCB13signalClosingEv+0x44>
        PCB* last = curr;
        curr->semDeleted = true;
    80002248:	00100793          	li	a5,1
    8000224c:	02f50523          	sb	a5,42(a0)
        curr->blocked = false;
    80002250:	020504a3          	sb	zero,41(a0)
        curr = curr->nextInList;
    80002254:	00053483          	ld	s1,0(a0)
        Scheduler::put(last);
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	85c080e7          	jalr	-1956(ra) # 80001ab4 <_ZN9Scheduler3putEP3PCB>
        curr = curr->nextInList;
    80002260:	00048513          	mv	a0,s1
    while(curr) {
    80002264:	fe1ff06f          	j	80002244 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002268:	00093423          	sd	zero,8(s2)
    8000226c:	00093023          	sd	zero,0(s2)
}
    80002270:	01813083          	ld	ra,24(sp)
    80002274:	01013403          	ld	s0,16(sp)
    80002278:	00813483          	ld	s1,8(sp)
    8000227c:	00013903          	ld	s2,0(sp)
    80002280:	02010113          	addi	sp,sp,32
    80002284:	00008067          	ret

0000000080002288 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002288:	ff010113          	addi	sp,sp,-16
    8000228c:	00813423          	sd	s0,8(sp)
    80002290:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002294:	00004797          	auipc	a5,0x4
    80002298:	acc7b783          	ld	a5,-1332(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
    8000229c:	02078c63          	beqz	a5,800022d4 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    800022a0:	00004717          	auipc	a4,0x4
    800022a4:	a3873703          	ld	a4,-1480(a4) # 80005cd8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022a8:	00073703          	ld	a4,0(a4)
    800022ac:	12e78c63          	beq	a5,a4,800023e4 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800022b0:	00850713          	addi	a4,a0,8
    800022b4:	00675813          	srli	a6,a4,0x6
    800022b8:	03f77793          	andi	a5,a4,63
    800022bc:	00f037b3          	snez	a5,a5
    800022c0:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800022c4:	00004517          	auipc	a0,0x4
    800022c8:	a9c53503          	ld	a0,-1380(a0) # 80005d60 <_ZN15MemoryAllocator4headE>
    800022cc:	00000613          	li	a2,0
    800022d0:	0a80006f          	j	80002378 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800022d4:	00004697          	auipc	a3,0x4
    800022d8:	9e46b683          	ld	a3,-1564(a3) # 80005cb8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800022dc:	0006b783          	ld	a5,0(a3)
    800022e0:	00004717          	auipc	a4,0x4
    800022e4:	a8f73023          	sd	a5,-1408(a4) # 80005d60 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800022e8:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800022ec:	00004717          	auipc	a4,0x4
    800022f0:	9ec73703          	ld	a4,-1556(a4) # 80005cd8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022f4:	00073703          	ld	a4,0(a4)
    800022f8:	0006b683          	ld	a3,0(a3)
    800022fc:	40d70733          	sub	a4,a4,a3
    80002300:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80002304:	0007b823          	sd	zero,16(a5)
    80002308:	fa9ff06f          	j	800022b0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    8000230c:	00060e63          	beqz	a2,80002328 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002310:	01063703          	ld	a4,16(a2)
    80002314:	04070a63          	beqz	a4,80002368 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002318:	01073703          	ld	a4,16(a4)
    8000231c:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002320:	00078813          	mv	a6,a5
    80002324:	0ac0006f          	j	800023d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002328:	01053703          	ld	a4,16(a0)
    8000232c:	00070a63          	beqz	a4,80002340 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002330:	00004697          	auipc	a3,0x4
    80002334:	a2e6b823          	sd	a4,-1488(a3) # 80005d60 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002338:	00078813          	mv	a6,a5
    8000233c:	0940006f          	j	800023d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002340:	00004717          	auipc	a4,0x4
    80002344:	99873703          	ld	a4,-1640(a4) # 80005cd8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002348:	00073703          	ld	a4,0(a4)
    8000234c:	00004697          	auipc	a3,0x4
    80002350:	a0e6ba23          	sd	a4,-1516(a3) # 80005d60 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002354:	00078813          	mv	a6,a5
    80002358:	0780006f          	j	800023d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    8000235c:	00004797          	auipc	a5,0x4
    80002360:	a0e7b223          	sd	a4,-1532(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
    80002364:	06c0006f          	j	800023d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002368:	00078813          	mv	a6,a5
    8000236c:	0640006f          	j	800023d0 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002370:	00050613          	mv	a2,a0
        curr = curr->next;
    80002374:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002378:	06050063          	beqz	a0,800023d8 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    8000237c:	00853783          	ld	a5,8(a0)
    80002380:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002384:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002388:	fee7e4e3          	bltu	a5,a4,80002370 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    8000238c:	ff06e2e3          	bltu	a3,a6,80002370 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002390:	f7068ee3          	beq	a3,a6,8000230c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002394:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002398:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    8000239c:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800023a0:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800023a4:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800023a8:	01053783          	ld	a5,16(a0)
    800023ac:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800023b0:	fa0606e3          	beqz	a2,8000235c <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    800023b4:	01063783          	ld	a5,16(a2)
    800023b8:	00078663          	beqz	a5,800023c4 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    800023bc:	0107b783          	ld	a5,16(a5)
    800023c0:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800023c4:	01063783          	ld	a5,16(a2)
    800023c8:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800023cc:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800023d0:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800023d4:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800023d8:	00813403          	ld	s0,8(sp)
    800023dc:	01010113          	addi	sp,sp,16
    800023e0:	00008067          	ret
        return nullptr;
    800023e4:	00000513          	li	a0,0
    800023e8:	ff1ff06f          	j	800023d8 <_ZN15MemoryAllocator9mem_allocEm+0x150>

00000000800023ec <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800023ec:	ff010113          	addi	sp,sp,-16
    800023f0:	00813423          	sd	s0,8(sp)
    800023f4:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800023f8:	16050063          	beqz	a0,80002558 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800023fc:	ff850713          	addi	a4,a0,-8
    80002400:	00004797          	auipc	a5,0x4
    80002404:	8b87b783          	ld	a5,-1864(a5) # 80005cb8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002408:	0007b783          	ld	a5,0(a5)
    8000240c:	14f76a63          	bltu	a4,a5,80002560 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002410:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002414:	fff58693          	addi	a3,a1,-1
    80002418:	00d706b3          	add	a3,a4,a3
    8000241c:	00004617          	auipc	a2,0x4
    80002420:	8bc63603          	ld	a2,-1860(a2) # 80005cd8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002424:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002428:	14c6f063          	bgeu	a3,a2,80002568 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    8000242c:	14070263          	beqz	a4,80002570 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002430:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002434:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002438:	14079063          	bnez	a5,80002578 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    8000243c:	03f00793          	li	a5,63
    80002440:	14b7f063          	bgeu	a5,a1,80002580 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002444:	00004797          	auipc	a5,0x4
    80002448:	91c7b783          	ld	a5,-1764(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
    8000244c:	02f60063          	beq	a2,a5,8000246c <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002450:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002454:	02078a63          	beqz	a5,80002488 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002458:	0007b683          	ld	a3,0(a5)
    8000245c:	02e6f663          	bgeu	a3,a4,80002488 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002460:	00078613          	mv	a2,a5
        curr = curr->next;
    80002464:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002468:	fedff06f          	j	80002454 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    8000246c:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002470:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002474:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002478:	00004797          	auipc	a5,0x4
    8000247c:	8ee7b423          	sd	a4,-1816(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
        return 0;
    80002480:	00000513          	li	a0,0
    80002484:	0480006f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002488:	04060863          	beqz	a2,800024d8 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    8000248c:	00063683          	ld	a3,0(a2)
    80002490:	00863803          	ld	a6,8(a2)
    80002494:	010686b3          	add	a3,a3,a6
    80002498:	08e68a63          	beq	a3,a4,8000252c <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    8000249c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800024a0:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800024a4:	01063683          	ld	a3,16(a2)
    800024a8:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800024ac:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800024b0:	0e078063          	beqz	a5,80002590 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    800024b4:	0007b583          	ld	a1,0(a5)
    800024b8:	00073683          	ld	a3,0(a4)
    800024bc:	00873603          	ld	a2,8(a4)
    800024c0:	00c686b3          	add	a3,a3,a2
    800024c4:	06d58c63          	beq	a1,a3,8000253c <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800024c8:	00000513          	li	a0,0
}
    800024cc:	00813403          	ld	s0,8(sp)
    800024d0:	01010113          	addi	sp,sp,16
    800024d4:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800024d8:	0a078863          	beqz	a5,80002588 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800024dc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800024e0:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800024e4:	00004797          	auipc	a5,0x4
    800024e8:	87c7b783          	ld	a5,-1924(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
    800024ec:	0007b603          	ld	a2,0(a5)
    800024f0:	00b706b3          	add	a3,a4,a1
    800024f4:	00d60c63          	beq	a2,a3,8000250c <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800024f8:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800024fc:	00004797          	auipc	a5,0x4
    80002500:	86e7b223          	sd	a4,-1948(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
            return 0;
    80002504:	00000513          	li	a0,0
    80002508:	fc5ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    8000250c:	0087b783          	ld	a5,8(a5)
    80002510:	00b785b3          	add	a1,a5,a1
    80002514:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80002518:	00004797          	auipc	a5,0x4
    8000251c:	8487b783          	ld	a5,-1976(a5) # 80005d60 <_ZN15MemoryAllocator4headE>
    80002520:	0107b783          	ld	a5,16(a5)
    80002524:	00f53423          	sd	a5,8(a0)
    80002528:	fd5ff06f          	j	800024fc <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    8000252c:	00b805b3          	add	a1,a6,a1
    80002530:	00b63423          	sd	a1,8(a2)
    80002534:	00060713          	mv	a4,a2
    80002538:	f79ff06f          	j	800024b0 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    8000253c:	0087b683          	ld	a3,8(a5)
    80002540:	00d60633          	add	a2,a2,a3
    80002544:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002548:	0107b783          	ld	a5,16(a5)
    8000254c:	00f73823          	sd	a5,16(a4)
    return 0;
    80002550:	00000513          	li	a0,0
    80002554:	f79ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002558:	fff00513          	li	a0,-1
    8000255c:	f71ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002560:	fff00513          	li	a0,-1
    80002564:	f69ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80002568:	fff00513          	li	a0,-1
    8000256c:	f61ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002570:	fff00513          	li	a0,-1
    80002574:	f59ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002578:	fff00513          	li	a0,-1
    8000257c:	f51ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002580:	fff00513          	li	a0,-1
    80002584:	f49ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80002588:	fff00513          	li	a0,-1
    8000258c:	f41ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002590:	00000513          	li	a0,0
    80002594:	f39ff06f          	j	800024cc <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002598 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    80002598:	fd010113          	addi	sp,sp,-48
    8000259c:	02113423          	sd	ra,40(sp)
    800025a0:	02813023          	sd	s0,32(sp)
    800025a4:	00913c23          	sd	s1,24(sp)
    800025a8:	01213823          	sd	s2,16(sp)
    800025ac:	03010413          	addi	s0,sp,48
    800025b0:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800025b4:	100027f3          	csrr	a5,sstatus
    800025b8:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800025bc:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800025c0:	00200793          	li	a5,2
    800025c4:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    800025c8:	0004c503          	lbu	a0,0(s1)
    800025cc:	00050a63          	beqz	a0,800025e0 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    800025d0:	00002097          	auipc	ra,0x2
    800025d4:	26c080e7          	jalr	620(ra) # 8000483c <__putc>
        string++;
    800025d8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800025dc:	fedff06f          	j	800025c8 <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800025e0:	0009091b          	sext.w	s2,s2
    800025e4:	00297913          	andi	s2,s2,2
    800025e8:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800025ec:	10092073          	csrs	sstatus,s2
}
    800025f0:	02813083          	ld	ra,40(sp)
    800025f4:	02013403          	ld	s0,32(sp)
    800025f8:	01813483          	ld	s1,24(sp)
    800025fc:	01013903          	ld	s2,16(sp)
    80002600:	03010113          	addi	sp,sp,48
    80002604:	00008067          	ret

0000000080002608 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    80002608:	fc010113          	addi	sp,sp,-64
    8000260c:	02113c23          	sd	ra,56(sp)
    80002610:	02813823          	sd	s0,48(sp)
    80002614:	02913423          	sd	s1,40(sp)
    80002618:	03213023          	sd	s2,32(sp)
    8000261c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002620:	100027f3          	csrr	a5,sstatus
    80002624:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    80002628:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    8000262c:	00200793          	li	a5,2
    80002630:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80002634:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002638:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    8000263c:	00a00613          	li	a2,10
    80002640:	02c5773b          	remuw	a4,a0,a2
    80002644:	02071693          	slli	a3,a4,0x20
    80002648:	0206d693          	srli	a3,a3,0x20
    8000264c:	00003717          	auipc	a4,0x3
    80002650:	adc70713          	addi	a4,a4,-1316 # 80005128 <_ZZ12printIntegermE6digits>
    80002654:	00d70733          	add	a4,a4,a3
    80002658:	00074703          	lbu	a4,0(a4)
    8000265c:	fe040693          	addi	a3,s0,-32
    80002660:	009687b3          	add	a5,a3,s1
    80002664:	0014849b          	addiw	s1,s1,1
    80002668:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    8000266c:	0005071b          	sext.w	a4,a0
    80002670:	02c5553b          	divuw	a0,a0,a2
    80002674:	00900793          	li	a5,9
    80002678:	fce7e2e3          	bltu	a5,a4,8000263c <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    8000267c:	fff4849b          	addiw	s1,s1,-1
    80002680:	0004ce63          	bltz	s1,8000269c <_Z12printIntegerm+0x94>
    80002684:	fe040793          	addi	a5,s0,-32
    80002688:	009787b3          	add	a5,a5,s1
    8000268c:	ff07c503          	lbu	a0,-16(a5)
    80002690:	00002097          	auipc	ra,0x2
    80002694:	1ac080e7          	jalr	428(ra) # 8000483c <__putc>
    80002698:	fe5ff06f          	j	8000267c <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    8000269c:	0009091b          	sext.w	s2,s2
    800026a0:	00297913          	andi	s2,s2,2
    800026a4:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800026a8:	10092073          	csrs	sstatus,s2
}
    800026ac:	03813083          	ld	ra,56(sp)
    800026b0:	03013403          	ld	s0,48(sp)
    800026b4:	02813483          	ld	s1,40(sp)
    800026b8:	02013903          	ld	s2,32(sp)
    800026bc:	04010113          	addi	sp,sp,64
    800026c0:	00008067          	ret

00000000800026c4 <_Z10printErrorv>:
void printError() {
    800026c4:	fc010113          	addi	sp,sp,-64
    800026c8:	02113c23          	sd	ra,56(sp)
    800026cc:	02813823          	sd	s0,48(sp)
    800026d0:	02913423          	sd	s1,40(sp)
    800026d4:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800026d8:	100027f3          	csrr	a5,sstatus
    800026dc:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800026e0:	fd843483          	ld	s1,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800026e4:	00200793          	li	a5,2
    800026e8:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    printString("scause: ");
    800026ec:	00003517          	auipc	a0,0x3
    800026f0:	a1450513          	addi	a0,a0,-1516 # 80005100 <CONSOLE_STATUS+0xf0>
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	ea4080e7          	jalr	-348(ra) # 80002598 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800026fc:	142027f3          	csrr	a5,scause
    80002700:	fcf43823          	sd	a5,-48(s0)
        return scause;
    80002704:	fd043503          	ld	a0,-48(s0)
    printInteger(Kernel::r_scause());
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	f00080e7          	jalr	-256(ra) # 80002608 <_Z12printIntegerm>
    printString("\nsepc: ");
    80002710:	00003517          	auipc	a0,0x3
    80002714:	a0050513          	addi	a0,a0,-1536 # 80005110 <CONSOLE_STATUS+0x100>
    80002718:	00000097          	auipc	ra,0x0
    8000271c:	e80080e7          	jalr	-384(ra) # 80002598 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002720:	141027f3          	csrr	a5,sepc
    80002724:	fcf43423          	sd	a5,-56(s0)
        return sepc;
    80002728:	fc843503          	ld	a0,-56(s0)
    printInteger(Kernel::r_sepc());
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	edc080e7          	jalr	-292(ra) # 80002608 <_Z12printIntegerm>
    printString("\nstval: ");
    80002734:	00003517          	auipc	a0,0x3
    80002738:	9e450513          	addi	a0,a0,-1564 # 80005118 <CONSOLE_STATUS+0x108>
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	e5c080e7          	jalr	-420(ra) # 80002598 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002744:	143027f3          	csrr	a5,stval
    80002748:	fcf43023          	sd	a5,-64(s0)
        return stval;
    8000274c:	fc043503          	ld	a0,-64(s0)
    printInteger(Kernel::r_stval());
    80002750:	00000097          	auipc	ra,0x0
    80002754:	eb8080e7          	jalr	-328(ra) # 80002608 <_Z12printIntegerm>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002758:	0004849b          	sext.w	s1,s1
    8000275c:	0024f493          	andi	s1,s1,2
    80002760:	0004849b          	sext.w	s1,s1
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002764:	1004a073          	csrs	sstatus,s1
    80002768:	03813083          	ld	ra,56(sp)
    8000276c:	03013403          	ld	s0,48(sp)
    80002770:	02813483          	ld	s1,40(sp)
    80002774:	04010113          	addi	sp,sp,64
    80002778:	00008067          	ret

000000008000277c <start>:
    8000277c:	ff010113          	addi	sp,sp,-16
    80002780:	00813423          	sd	s0,8(sp)
    80002784:	01010413          	addi	s0,sp,16
    80002788:	300027f3          	csrr	a5,mstatus
    8000278c:	ffffe737          	lui	a4,0xffffe
    80002790:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff782f>
    80002794:	00e7f7b3          	and	a5,a5,a4
    80002798:	00001737          	lui	a4,0x1
    8000279c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800027a0:	00e7e7b3          	or	a5,a5,a4
    800027a4:	30079073          	csrw	mstatus,a5
    800027a8:	00000797          	auipc	a5,0x0
    800027ac:	16078793          	addi	a5,a5,352 # 80002908 <system_main>
    800027b0:	34179073          	csrw	mepc,a5
    800027b4:	00000793          	li	a5,0
    800027b8:	18079073          	csrw	satp,a5
    800027bc:	000107b7          	lui	a5,0x10
    800027c0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800027c4:	30279073          	csrw	medeleg,a5
    800027c8:	30379073          	csrw	mideleg,a5
    800027cc:	104027f3          	csrr	a5,sie
    800027d0:	2227e793          	ori	a5,a5,546
    800027d4:	10479073          	csrw	sie,a5
    800027d8:	fff00793          	li	a5,-1
    800027dc:	00a7d793          	srli	a5,a5,0xa
    800027e0:	3b079073          	csrw	pmpaddr0,a5
    800027e4:	00f00793          	li	a5,15
    800027e8:	3a079073          	csrw	pmpcfg0,a5
    800027ec:	f14027f3          	csrr	a5,mhartid
    800027f0:	0200c737          	lui	a4,0x200c
    800027f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800027f8:	0007869b          	sext.w	a3,a5
    800027fc:	00269713          	slli	a4,a3,0x2
    80002800:	000f4637          	lui	a2,0xf4
    80002804:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002808:	00d70733          	add	a4,a4,a3
    8000280c:	0037979b          	slliw	a5,a5,0x3
    80002810:	020046b7          	lui	a3,0x2004
    80002814:	00d787b3          	add	a5,a5,a3
    80002818:	00c585b3          	add	a1,a1,a2
    8000281c:	00371693          	slli	a3,a4,0x3
    80002820:	00003717          	auipc	a4,0x3
    80002824:	55070713          	addi	a4,a4,1360 # 80005d70 <timer_scratch>
    80002828:	00b7b023          	sd	a1,0(a5)
    8000282c:	00d70733          	add	a4,a4,a3
    80002830:	00f73c23          	sd	a5,24(a4)
    80002834:	02c73023          	sd	a2,32(a4)
    80002838:	34071073          	csrw	mscratch,a4
    8000283c:	00000797          	auipc	a5,0x0
    80002840:	6e478793          	addi	a5,a5,1764 # 80002f20 <timervec>
    80002844:	30579073          	csrw	mtvec,a5
    80002848:	300027f3          	csrr	a5,mstatus
    8000284c:	0087e793          	ori	a5,a5,8
    80002850:	30079073          	csrw	mstatus,a5
    80002854:	304027f3          	csrr	a5,mie
    80002858:	0807e793          	ori	a5,a5,128
    8000285c:	30479073          	csrw	mie,a5
    80002860:	f14027f3          	csrr	a5,mhartid
    80002864:	0007879b          	sext.w	a5,a5
    80002868:	00078213          	mv	tp,a5
    8000286c:	30200073          	mret
    80002870:	00813403          	ld	s0,8(sp)
    80002874:	01010113          	addi	sp,sp,16
    80002878:	00008067          	ret

000000008000287c <timerinit>:
    8000287c:	ff010113          	addi	sp,sp,-16
    80002880:	00813423          	sd	s0,8(sp)
    80002884:	01010413          	addi	s0,sp,16
    80002888:	f14027f3          	csrr	a5,mhartid
    8000288c:	0200c737          	lui	a4,0x200c
    80002890:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002894:	0007869b          	sext.w	a3,a5
    80002898:	00269713          	slli	a4,a3,0x2
    8000289c:	000f4637          	lui	a2,0xf4
    800028a0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800028a4:	00d70733          	add	a4,a4,a3
    800028a8:	0037979b          	slliw	a5,a5,0x3
    800028ac:	020046b7          	lui	a3,0x2004
    800028b0:	00d787b3          	add	a5,a5,a3
    800028b4:	00c585b3          	add	a1,a1,a2
    800028b8:	00371693          	slli	a3,a4,0x3
    800028bc:	00003717          	auipc	a4,0x3
    800028c0:	4b470713          	addi	a4,a4,1204 # 80005d70 <timer_scratch>
    800028c4:	00b7b023          	sd	a1,0(a5)
    800028c8:	00d70733          	add	a4,a4,a3
    800028cc:	00f73c23          	sd	a5,24(a4)
    800028d0:	02c73023          	sd	a2,32(a4)
    800028d4:	34071073          	csrw	mscratch,a4
    800028d8:	00000797          	auipc	a5,0x0
    800028dc:	64878793          	addi	a5,a5,1608 # 80002f20 <timervec>
    800028e0:	30579073          	csrw	mtvec,a5
    800028e4:	300027f3          	csrr	a5,mstatus
    800028e8:	0087e793          	ori	a5,a5,8
    800028ec:	30079073          	csrw	mstatus,a5
    800028f0:	304027f3          	csrr	a5,mie
    800028f4:	0807e793          	ori	a5,a5,128
    800028f8:	30479073          	csrw	mie,a5
    800028fc:	00813403          	ld	s0,8(sp)
    80002900:	01010113          	addi	sp,sp,16
    80002904:	00008067          	ret

0000000080002908 <system_main>:
    80002908:	fe010113          	addi	sp,sp,-32
    8000290c:	00813823          	sd	s0,16(sp)
    80002910:	00913423          	sd	s1,8(sp)
    80002914:	00113c23          	sd	ra,24(sp)
    80002918:	02010413          	addi	s0,sp,32
    8000291c:	00000097          	auipc	ra,0x0
    80002920:	0c4080e7          	jalr	196(ra) # 800029e0 <cpuid>
    80002924:	00003497          	auipc	s1,0x3
    80002928:	3dc48493          	addi	s1,s1,988 # 80005d00 <started>
    8000292c:	02050263          	beqz	a0,80002950 <system_main+0x48>
    80002930:	0004a783          	lw	a5,0(s1)
    80002934:	0007879b          	sext.w	a5,a5
    80002938:	fe078ce3          	beqz	a5,80002930 <system_main+0x28>
    8000293c:	0ff0000f          	fence
    80002940:	00003517          	auipc	a0,0x3
    80002944:	82850513          	addi	a0,a0,-2008 # 80005168 <_ZZ12printIntegermE6digits+0x40>
    80002948:	00001097          	auipc	ra,0x1
    8000294c:	a74080e7          	jalr	-1420(ra) # 800033bc <panic>
    80002950:	00001097          	auipc	ra,0x1
    80002954:	9c8080e7          	jalr	-1592(ra) # 80003318 <consoleinit>
    80002958:	00001097          	auipc	ra,0x1
    8000295c:	154080e7          	jalr	340(ra) # 80003aac <printfinit>
    80002960:	00003517          	auipc	a0,0x3
    80002964:	8e850513          	addi	a0,a0,-1816 # 80005248 <_ZZ12printIntegermE6digits+0x120>
    80002968:	00001097          	auipc	ra,0x1
    8000296c:	ab0080e7          	jalr	-1360(ra) # 80003418 <__printf>
    80002970:	00002517          	auipc	a0,0x2
    80002974:	7c850513          	addi	a0,a0,1992 # 80005138 <_ZZ12printIntegermE6digits+0x10>
    80002978:	00001097          	auipc	ra,0x1
    8000297c:	aa0080e7          	jalr	-1376(ra) # 80003418 <__printf>
    80002980:	00003517          	auipc	a0,0x3
    80002984:	8c850513          	addi	a0,a0,-1848 # 80005248 <_ZZ12printIntegermE6digits+0x120>
    80002988:	00001097          	auipc	ra,0x1
    8000298c:	a90080e7          	jalr	-1392(ra) # 80003418 <__printf>
    80002990:	00001097          	auipc	ra,0x1
    80002994:	4a8080e7          	jalr	1192(ra) # 80003e38 <kinit>
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	148080e7          	jalr	328(ra) # 80002ae0 <trapinit>
    800029a0:	00000097          	auipc	ra,0x0
    800029a4:	16c080e7          	jalr	364(ra) # 80002b0c <trapinithart>
    800029a8:	00000097          	auipc	ra,0x0
    800029ac:	5b8080e7          	jalr	1464(ra) # 80002f60 <plicinit>
    800029b0:	00000097          	auipc	ra,0x0
    800029b4:	5d8080e7          	jalr	1496(ra) # 80002f88 <plicinithart>
    800029b8:	00000097          	auipc	ra,0x0
    800029bc:	078080e7          	jalr	120(ra) # 80002a30 <userinit>
    800029c0:	0ff0000f          	fence
    800029c4:	00100793          	li	a5,1
    800029c8:	00002517          	auipc	a0,0x2
    800029cc:	78850513          	addi	a0,a0,1928 # 80005150 <_ZZ12printIntegermE6digits+0x28>
    800029d0:	00f4a023          	sw	a5,0(s1)
    800029d4:	00001097          	auipc	ra,0x1
    800029d8:	a44080e7          	jalr	-1468(ra) # 80003418 <__printf>
    800029dc:	0000006f          	j	800029dc <system_main+0xd4>

00000000800029e0 <cpuid>:
    800029e0:	ff010113          	addi	sp,sp,-16
    800029e4:	00813423          	sd	s0,8(sp)
    800029e8:	01010413          	addi	s0,sp,16
    800029ec:	00020513          	mv	a0,tp
    800029f0:	00813403          	ld	s0,8(sp)
    800029f4:	0005051b          	sext.w	a0,a0
    800029f8:	01010113          	addi	sp,sp,16
    800029fc:	00008067          	ret

0000000080002a00 <mycpu>:
    80002a00:	ff010113          	addi	sp,sp,-16
    80002a04:	00813423          	sd	s0,8(sp)
    80002a08:	01010413          	addi	s0,sp,16
    80002a0c:	00020793          	mv	a5,tp
    80002a10:	00813403          	ld	s0,8(sp)
    80002a14:	0007879b          	sext.w	a5,a5
    80002a18:	00779793          	slli	a5,a5,0x7
    80002a1c:	00004517          	auipc	a0,0x4
    80002a20:	38450513          	addi	a0,a0,900 # 80006da0 <cpus>
    80002a24:	00f50533          	add	a0,a0,a5
    80002a28:	01010113          	addi	sp,sp,16
    80002a2c:	00008067          	ret

0000000080002a30 <userinit>:
    80002a30:	ff010113          	addi	sp,sp,-16
    80002a34:	00813423          	sd	s0,8(sp)
    80002a38:	01010413          	addi	s0,sp,16
    80002a3c:	00813403          	ld	s0,8(sp)
    80002a40:	01010113          	addi	sp,sp,16
    80002a44:	fffff317          	auipc	t1,0xfffff
    80002a48:	27030067          	jr	624(t1) # 80001cb4 <main>

0000000080002a4c <either_copyout>:
    80002a4c:	ff010113          	addi	sp,sp,-16
    80002a50:	00813023          	sd	s0,0(sp)
    80002a54:	00113423          	sd	ra,8(sp)
    80002a58:	01010413          	addi	s0,sp,16
    80002a5c:	02051663          	bnez	a0,80002a88 <either_copyout+0x3c>
    80002a60:	00058513          	mv	a0,a1
    80002a64:	00060593          	mv	a1,a2
    80002a68:	0006861b          	sext.w	a2,a3
    80002a6c:	00002097          	auipc	ra,0x2
    80002a70:	c58080e7          	jalr	-936(ra) # 800046c4 <__memmove>
    80002a74:	00813083          	ld	ra,8(sp)
    80002a78:	00013403          	ld	s0,0(sp)
    80002a7c:	00000513          	li	a0,0
    80002a80:	01010113          	addi	sp,sp,16
    80002a84:	00008067          	ret
    80002a88:	00002517          	auipc	a0,0x2
    80002a8c:	70850513          	addi	a0,a0,1800 # 80005190 <_ZZ12printIntegermE6digits+0x68>
    80002a90:	00001097          	auipc	ra,0x1
    80002a94:	92c080e7          	jalr	-1748(ra) # 800033bc <panic>

0000000080002a98 <either_copyin>:
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00813023          	sd	s0,0(sp)
    80002aa0:	00113423          	sd	ra,8(sp)
    80002aa4:	01010413          	addi	s0,sp,16
    80002aa8:	02059463          	bnez	a1,80002ad0 <either_copyin+0x38>
    80002aac:	00060593          	mv	a1,a2
    80002ab0:	0006861b          	sext.w	a2,a3
    80002ab4:	00002097          	auipc	ra,0x2
    80002ab8:	c10080e7          	jalr	-1008(ra) # 800046c4 <__memmove>
    80002abc:	00813083          	ld	ra,8(sp)
    80002ac0:	00013403          	ld	s0,0(sp)
    80002ac4:	00000513          	li	a0,0
    80002ac8:	01010113          	addi	sp,sp,16
    80002acc:	00008067          	ret
    80002ad0:	00002517          	auipc	a0,0x2
    80002ad4:	6e850513          	addi	a0,a0,1768 # 800051b8 <_ZZ12printIntegermE6digits+0x90>
    80002ad8:	00001097          	auipc	ra,0x1
    80002adc:	8e4080e7          	jalr	-1820(ra) # 800033bc <panic>

0000000080002ae0 <trapinit>:
    80002ae0:	ff010113          	addi	sp,sp,-16
    80002ae4:	00813423          	sd	s0,8(sp)
    80002ae8:	01010413          	addi	s0,sp,16
    80002aec:	00813403          	ld	s0,8(sp)
    80002af0:	00002597          	auipc	a1,0x2
    80002af4:	6f058593          	addi	a1,a1,1776 # 800051e0 <_ZZ12printIntegermE6digits+0xb8>
    80002af8:	00004517          	auipc	a0,0x4
    80002afc:	32850513          	addi	a0,a0,808 # 80006e20 <tickslock>
    80002b00:	01010113          	addi	sp,sp,16
    80002b04:	00001317          	auipc	t1,0x1
    80002b08:	5c430067          	jr	1476(t1) # 800040c8 <initlock>

0000000080002b0c <trapinithart>:
    80002b0c:	ff010113          	addi	sp,sp,-16
    80002b10:	00813423          	sd	s0,8(sp)
    80002b14:	01010413          	addi	s0,sp,16
    80002b18:	00000797          	auipc	a5,0x0
    80002b1c:	2f878793          	addi	a5,a5,760 # 80002e10 <kernelvec>
    80002b20:	10579073          	csrw	stvec,a5
    80002b24:	00813403          	ld	s0,8(sp)
    80002b28:	01010113          	addi	sp,sp,16
    80002b2c:	00008067          	ret

0000000080002b30 <usertrap>:
    80002b30:	ff010113          	addi	sp,sp,-16
    80002b34:	00813423          	sd	s0,8(sp)
    80002b38:	01010413          	addi	s0,sp,16
    80002b3c:	00813403          	ld	s0,8(sp)
    80002b40:	01010113          	addi	sp,sp,16
    80002b44:	00008067          	ret

0000000080002b48 <usertrapret>:
    80002b48:	ff010113          	addi	sp,sp,-16
    80002b4c:	00813423          	sd	s0,8(sp)
    80002b50:	01010413          	addi	s0,sp,16
    80002b54:	00813403          	ld	s0,8(sp)
    80002b58:	01010113          	addi	sp,sp,16
    80002b5c:	00008067          	ret

0000000080002b60 <kerneltrap>:
    80002b60:	fe010113          	addi	sp,sp,-32
    80002b64:	00813823          	sd	s0,16(sp)
    80002b68:	00113c23          	sd	ra,24(sp)
    80002b6c:	00913423          	sd	s1,8(sp)
    80002b70:	02010413          	addi	s0,sp,32
    80002b74:	142025f3          	csrr	a1,scause
    80002b78:	100027f3          	csrr	a5,sstatus
    80002b7c:	0027f793          	andi	a5,a5,2
    80002b80:	10079c63          	bnez	a5,80002c98 <kerneltrap+0x138>
    80002b84:	142027f3          	csrr	a5,scause
    80002b88:	0207ce63          	bltz	a5,80002bc4 <kerneltrap+0x64>
    80002b8c:	00002517          	auipc	a0,0x2
    80002b90:	69c50513          	addi	a0,a0,1692 # 80005228 <_ZZ12printIntegermE6digits+0x100>
    80002b94:	00001097          	auipc	ra,0x1
    80002b98:	884080e7          	jalr	-1916(ra) # 80003418 <__printf>
    80002b9c:	141025f3          	csrr	a1,sepc
    80002ba0:	14302673          	csrr	a2,stval
    80002ba4:	00002517          	auipc	a0,0x2
    80002ba8:	69450513          	addi	a0,a0,1684 # 80005238 <_ZZ12printIntegermE6digits+0x110>
    80002bac:	00001097          	auipc	ra,0x1
    80002bb0:	86c080e7          	jalr	-1940(ra) # 80003418 <__printf>
    80002bb4:	00002517          	auipc	a0,0x2
    80002bb8:	69c50513          	addi	a0,a0,1692 # 80005250 <_ZZ12printIntegermE6digits+0x128>
    80002bbc:	00001097          	auipc	ra,0x1
    80002bc0:	800080e7          	jalr	-2048(ra) # 800033bc <panic>
    80002bc4:	0ff7f713          	andi	a4,a5,255
    80002bc8:	00900693          	li	a3,9
    80002bcc:	04d70063          	beq	a4,a3,80002c0c <kerneltrap+0xac>
    80002bd0:	fff00713          	li	a4,-1
    80002bd4:	03f71713          	slli	a4,a4,0x3f
    80002bd8:	00170713          	addi	a4,a4,1
    80002bdc:	fae798e3          	bne	a5,a4,80002b8c <kerneltrap+0x2c>
    80002be0:	00000097          	auipc	ra,0x0
    80002be4:	e00080e7          	jalr	-512(ra) # 800029e0 <cpuid>
    80002be8:	06050663          	beqz	a0,80002c54 <kerneltrap+0xf4>
    80002bec:	144027f3          	csrr	a5,sip
    80002bf0:	ffd7f793          	andi	a5,a5,-3
    80002bf4:	14479073          	csrw	sip,a5
    80002bf8:	01813083          	ld	ra,24(sp)
    80002bfc:	01013403          	ld	s0,16(sp)
    80002c00:	00813483          	ld	s1,8(sp)
    80002c04:	02010113          	addi	sp,sp,32
    80002c08:	00008067          	ret
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	3c8080e7          	jalr	968(ra) # 80002fd4 <plic_claim>
    80002c14:	00a00793          	li	a5,10
    80002c18:	00050493          	mv	s1,a0
    80002c1c:	06f50863          	beq	a0,a5,80002c8c <kerneltrap+0x12c>
    80002c20:	fc050ce3          	beqz	a0,80002bf8 <kerneltrap+0x98>
    80002c24:	00050593          	mv	a1,a0
    80002c28:	00002517          	auipc	a0,0x2
    80002c2c:	5e050513          	addi	a0,a0,1504 # 80005208 <_ZZ12printIntegermE6digits+0xe0>
    80002c30:	00000097          	auipc	ra,0x0
    80002c34:	7e8080e7          	jalr	2024(ra) # 80003418 <__printf>
    80002c38:	01013403          	ld	s0,16(sp)
    80002c3c:	01813083          	ld	ra,24(sp)
    80002c40:	00048513          	mv	a0,s1
    80002c44:	00813483          	ld	s1,8(sp)
    80002c48:	02010113          	addi	sp,sp,32
    80002c4c:	00000317          	auipc	t1,0x0
    80002c50:	3c030067          	jr	960(t1) # 8000300c <plic_complete>
    80002c54:	00004517          	auipc	a0,0x4
    80002c58:	1cc50513          	addi	a0,a0,460 # 80006e20 <tickslock>
    80002c5c:	00001097          	auipc	ra,0x1
    80002c60:	490080e7          	jalr	1168(ra) # 800040ec <acquire>
    80002c64:	00003717          	auipc	a4,0x3
    80002c68:	0a070713          	addi	a4,a4,160 # 80005d04 <ticks>
    80002c6c:	00072783          	lw	a5,0(a4)
    80002c70:	00004517          	auipc	a0,0x4
    80002c74:	1b050513          	addi	a0,a0,432 # 80006e20 <tickslock>
    80002c78:	0017879b          	addiw	a5,a5,1
    80002c7c:	00f72023          	sw	a5,0(a4)
    80002c80:	00001097          	auipc	ra,0x1
    80002c84:	538080e7          	jalr	1336(ra) # 800041b8 <release>
    80002c88:	f65ff06f          	j	80002bec <kerneltrap+0x8c>
    80002c8c:	00001097          	auipc	ra,0x1
    80002c90:	094080e7          	jalr	148(ra) # 80003d20 <uartintr>
    80002c94:	fa5ff06f          	j	80002c38 <kerneltrap+0xd8>
    80002c98:	00002517          	auipc	a0,0x2
    80002c9c:	55050513          	addi	a0,a0,1360 # 800051e8 <_ZZ12printIntegermE6digits+0xc0>
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	71c080e7          	jalr	1820(ra) # 800033bc <panic>

0000000080002ca8 <clockintr>:
    80002ca8:	fe010113          	addi	sp,sp,-32
    80002cac:	00813823          	sd	s0,16(sp)
    80002cb0:	00913423          	sd	s1,8(sp)
    80002cb4:	00113c23          	sd	ra,24(sp)
    80002cb8:	02010413          	addi	s0,sp,32
    80002cbc:	00004497          	auipc	s1,0x4
    80002cc0:	16448493          	addi	s1,s1,356 # 80006e20 <tickslock>
    80002cc4:	00048513          	mv	a0,s1
    80002cc8:	00001097          	auipc	ra,0x1
    80002ccc:	424080e7          	jalr	1060(ra) # 800040ec <acquire>
    80002cd0:	00003717          	auipc	a4,0x3
    80002cd4:	03470713          	addi	a4,a4,52 # 80005d04 <ticks>
    80002cd8:	00072783          	lw	a5,0(a4)
    80002cdc:	01013403          	ld	s0,16(sp)
    80002ce0:	01813083          	ld	ra,24(sp)
    80002ce4:	00048513          	mv	a0,s1
    80002ce8:	0017879b          	addiw	a5,a5,1
    80002cec:	00813483          	ld	s1,8(sp)
    80002cf0:	00f72023          	sw	a5,0(a4)
    80002cf4:	02010113          	addi	sp,sp,32
    80002cf8:	00001317          	auipc	t1,0x1
    80002cfc:	4c030067          	jr	1216(t1) # 800041b8 <release>

0000000080002d00 <devintr>:
    80002d00:	142027f3          	csrr	a5,scause
    80002d04:	00000513          	li	a0,0
    80002d08:	0007c463          	bltz	a5,80002d10 <devintr+0x10>
    80002d0c:	00008067          	ret
    80002d10:	fe010113          	addi	sp,sp,-32
    80002d14:	00813823          	sd	s0,16(sp)
    80002d18:	00113c23          	sd	ra,24(sp)
    80002d1c:	00913423          	sd	s1,8(sp)
    80002d20:	02010413          	addi	s0,sp,32
    80002d24:	0ff7f713          	andi	a4,a5,255
    80002d28:	00900693          	li	a3,9
    80002d2c:	04d70c63          	beq	a4,a3,80002d84 <devintr+0x84>
    80002d30:	fff00713          	li	a4,-1
    80002d34:	03f71713          	slli	a4,a4,0x3f
    80002d38:	00170713          	addi	a4,a4,1
    80002d3c:	00e78c63          	beq	a5,a4,80002d54 <devintr+0x54>
    80002d40:	01813083          	ld	ra,24(sp)
    80002d44:	01013403          	ld	s0,16(sp)
    80002d48:	00813483          	ld	s1,8(sp)
    80002d4c:	02010113          	addi	sp,sp,32
    80002d50:	00008067          	ret
    80002d54:	00000097          	auipc	ra,0x0
    80002d58:	c8c080e7          	jalr	-884(ra) # 800029e0 <cpuid>
    80002d5c:	06050663          	beqz	a0,80002dc8 <devintr+0xc8>
    80002d60:	144027f3          	csrr	a5,sip
    80002d64:	ffd7f793          	andi	a5,a5,-3
    80002d68:	14479073          	csrw	sip,a5
    80002d6c:	01813083          	ld	ra,24(sp)
    80002d70:	01013403          	ld	s0,16(sp)
    80002d74:	00813483          	ld	s1,8(sp)
    80002d78:	00200513          	li	a0,2
    80002d7c:	02010113          	addi	sp,sp,32
    80002d80:	00008067          	ret
    80002d84:	00000097          	auipc	ra,0x0
    80002d88:	250080e7          	jalr	592(ra) # 80002fd4 <plic_claim>
    80002d8c:	00a00793          	li	a5,10
    80002d90:	00050493          	mv	s1,a0
    80002d94:	06f50663          	beq	a0,a5,80002e00 <devintr+0x100>
    80002d98:	00100513          	li	a0,1
    80002d9c:	fa0482e3          	beqz	s1,80002d40 <devintr+0x40>
    80002da0:	00048593          	mv	a1,s1
    80002da4:	00002517          	auipc	a0,0x2
    80002da8:	46450513          	addi	a0,a0,1124 # 80005208 <_ZZ12printIntegermE6digits+0xe0>
    80002dac:	00000097          	auipc	ra,0x0
    80002db0:	66c080e7          	jalr	1644(ra) # 80003418 <__printf>
    80002db4:	00048513          	mv	a0,s1
    80002db8:	00000097          	auipc	ra,0x0
    80002dbc:	254080e7          	jalr	596(ra) # 8000300c <plic_complete>
    80002dc0:	00100513          	li	a0,1
    80002dc4:	f7dff06f          	j	80002d40 <devintr+0x40>
    80002dc8:	00004517          	auipc	a0,0x4
    80002dcc:	05850513          	addi	a0,a0,88 # 80006e20 <tickslock>
    80002dd0:	00001097          	auipc	ra,0x1
    80002dd4:	31c080e7          	jalr	796(ra) # 800040ec <acquire>
    80002dd8:	00003717          	auipc	a4,0x3
    80002ddc:	f2c70713          	addi	a4,a4,-212 # 80005d04 <ticks>
    80002de0:	00072783          	lw	a5,0(a4)
    80002de4:	00004517          	auipc	a0,0x4
    80002de8:	03c50513          	addi	a0,a0,60 # 80006e20 <tickslock>
    80002dec:	0017879b          	addiw	a5,a5,1
    80002df0:	00f72023          	sw	a5,0(a4)
    80002df4:	00001097          	auipc	ra,0x1
    80002df8:	3c4080e7          	jalr	964(ra) # 800041b8 <release>
    80002dfc:	f65ff06f          	j	80002d60 <devintr+0x60>
    80002e00:	00001097          	auipc	ra,0x1
    80002e04:	f20080e7          	jalr	-224(ra) # 80003d20 <uartintr>
    80002e08:	fadff06f          	j	80002db4 <devintr+0xb4>
    80002e0c:	0000                	unimp
	...

0000000080002e10 <kernelvec>:
    80002e10:	f0010113          	addi	sp,sp,-256
    80002e14:	00113023          	sd	ra,0(sp)
    80002e18:	00213423          	sd	sp,8(sp)
    80002e1c:	00313823          	sd	gp,16(sp)
    80002e20:	00413c23          	sd	tp,24(sp)
    80002e24:	02513023          	sd	t0,32(sp)
    80002e28:	02613423          	sd	t1,40(sp)
    80002e2c:	02713823          	sd	t2,48(sp)
    80002e30:	02813c23          	sd	s0,56(sp)
    80002e34:	04913023          	sd	s1,64(sp)
    80002e38:	04a13423          	sd	a0,72(sp)
    80002e3c:	04b13823          	sd	a1,80(sp)
    80002e40:	04c13c23          	sd	a2,88(sp)
    80002e44:	06d13023          	sd	a3,96(sp)
    80002e48:	06e13423          	sd	a4,104(sp)
    80002e4c:	06f13823          	sd	a5,112(sp)
    80002e50:	07013c23          	sd	a6,120(sp)
    80002e54:	09113023          	sd	a7,128(sp)
    80002e58:	09213423          	sd	s2,136(sp)
    80002e5c:	09313823          	sd	s3,144(sp)
    80002e60:	09413c23          	sd	s4,152(sp)
    80002e64:	0b513023          	sd	s5,160(sp)
    80002e68:	0b613423          	sd	s6,168(sp)
    80002e6c:	0b713823          	sd	s7,176(sp)
    80002e70:	0b813c23          	sd	s8,184(sp)
    80002e74:	0d913023          	sd	s9,192(sp)
    80002e78:	0da13423          	sd	s10,200(sp)
    80002e7c:	0db13823          	sd	s11,208(sp)
    80002e80:	0dc13c23          	sd	t3,216(sp)
    80002e84:	0fd13023          	sd	t4,224(sp)
    80002e88:	0fe13423          	sd	t5,232(sp)
    80002e8c:	0ff13823          	sd	t6,240(sp)
    80002e90:	cd1ff0ef          	jal	ra,80002b60 <kerneltrap>
    80002e94:	00013083          	ld	ra,0(sp)
    80002e98:	00813103          	ld	sp,8(sp)
    80002e9c:	01013183          	ld	gp,16(sp)
    80002ea0:	02013283          	ld	t0,32(sp)
    80002ea4:	02813303          	ld	t1,40(sp)
    80002ea8:	03013383          	ld	t2,48(sp)
    80002eac:	03813403          	ld	s0,56(sp)
    80002eb0:	04013483          	ld	s1,64(sp)
    80002eb4:	04813503          	ld	a0,72(sp)
    80002eb8:	05013583          	ld	a1,80(sp)
    80002ebc:	05813603          	ld	a2,88(sp)
    80002ec0:	06013683          	ld	a3,96(sp)
    80002ec4:	06813703          	ld	a4,104(sp)
    80002ec8:	07013783          	ld	a5,112(sp)
    80002ecc:	07813803          	ld	a6,120(sp)
    80002ed0:	08013883          	ld	a7,128(sp)
    80002ed4:	08813903          	ld	s2,136(sp)
    80002ed8:	09013983          	ld	s3,144(sp)
    80002edc:	09813a03          	ld	s4,152(sp)
    80002ee0:	0a013a83          	ld	s5,160(sp)
    80002ee4:	0a813b03          	ld	s6,168(sp)
    80002ee8:	0b013b83          	ld	s7,176(sp)
    80002eec:	0b813c03          	ld	s8,184(sp)
    80002ef0:	0c013c83          	ld	s9,192(sp)
    80002ef4:	0c813d03          	ld	s10,200(sp)
    80002ef8:	0d013d83          	ld	s11,208(sp)
    80002efc:	0d813e03          	ld	t3,216(sp)
    80002f00:	0e013e83          	ld	t4,224(sp)
    80002f04:	0e813f03          	ld	t5,232(sp)
    80002f08:	0f013f83          	ld	t6,240(sp)
    80002f0c:	10010113          	addi	sp,sp,256
    80002f10:	10200073          	sret
    80002f14:	00000013          	nop
    80002f18:	00000013          	nop
    80002f1c:	00000013          	nop

0000000080002f20 <timervec>:
    80002f20:	34051573          	csrrw	a0,mscratch,a0
    80002f24:	00b53023          	sd	a1,0(a0)
    80002f28:	00c53423          	sd	a2,8(a0)
    80002f2c:	00d53823          	sd	a3,16(a0)
    80002f30:	01853583          	ld	a1,24(a0)
    80002f34:	02053603          	ld	a2,32(a0)
    80002f38:	0005b683          	ld	a3,0(a1)
    80002f3c:	00c686b3          	add	a3,a3,a2
    80002f40:	00d5b023          	sd	a3,0(a1)
    80002f44:	00200593          	li	a1,2
    80002f48:	14459073          	csrw	sip,a1
    80002f4c:	01053683          	ld	a3,16(a0)
    80002f50:	00853603          	ld	a2,8(a0)
    80002f54:	00053583          	ld	a1,0(a0)
    80002f58:	34051573          	csrrw	a0,mscratch,a0
    80002f5c:	30200073          	mret

0000000080002f60 <plicinit>:
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    80002f6c:	00813403          	ld	s0,8(sp)
    80002f70:	0c0007b7          	lui	a5,0xc000
    80002f74:	00100713          	li	a4,1
    80002f78:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002f7c:	00e7a223          	sw	a4,4(a5)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret

0000000080002f88 <plicinithart>:
    80002f88:	ff010113          	addi	sp,sp,-16
    80002f8c:	00813023          	sd	s0,0(sp)
    80002f90:	00113423          	sd	ra,8(sp)
    80002f94:	01010413          	addi	s0,sp,16
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	a48080e7          	jalr	-1464(ra) # 800029e0 <cpuid>
    80002fa0:	0085171b          	slliw	a4,a0,0x8
    80002fa4:	0c0027b7          	lui	a5,0xc002
    80002fa8:	00e787b3          	add	a5,a5,a4
    80002fac:	40200713          	li	a4,1026
    80002fb0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002fb4:	00813083          	ld	ra,8(sp)
    80002fb8:	00013403          	ld	s0,0(sp)
    80002fbc:	00d5151b          	slliw	a0,a0,0xd
    80002fc0:	0c2017b7          	lui	a5,0xc201
    80002fc4:	00a78533          	add	a0,a5,a0
    80002fc8:	00052023          	sw	zero,0(a0)
    80002fcc:	01010113          	addi	sp,sp,16
    80002fd0:	00008067          	ret

0000000080002fd4 <plic_claim>:
    80002fd4:	ff010113          	addi	sp,sp,-16
    80002fd8:	00813023          	sd	s0,0(sp)
    80002fdc:	00113423          	sd	ra,8(sp)
    80002fe0:	01010413          	addi	s0,sp,16
    80002fe4:	00000097          	auipc	ra,0x0
    80002fe8:	9fc080e7          	jalr	-1540(ra) # 800029e0 <cpuid>
    80002fec:	00813083          	ld	ra,8(sp)
    80002ff0:	00013403          	ld	s0,0(sp)
    80002ff4:	00d5151b          	slliw	a0,a0,0xd
    80002ff8:	0c2017b7          	lui	a5,0xc201
    80002ffc:	00a78533          	add	a0,a5,a0
    80003000:	00452503          	lw	a0,4(a0)
    80003004:	01010113          	addi	sp,sp,16
    80003008:	00008067          	ret

000000008000300c <plic_complete>:
    8000300c:	fe010113          	addi	sp,sp,-32
    80003010:	00813823          	sd	s0,16(sp)
    80003014:	00913423          	sd	s1,8(sp)
    80003018:	00113c23          	sd	ra,24(sp)
    8000301c:	02010413          	addi	s0,sp,32
    80003020:	00050493          	mv	s1,a0
    80003024:	00000097          	auipc	ra,0x0
    80003028:	9bc080e7          	jalr	-1604(ra) # 800029e0 <cpuid>
    8000302c:	01813083          	ld	ra,24(sp)
    80003030:	01013403          	ld	s0,16(sp)
    80003034:	00d5179b          	slliw	a5,a0,0xd
    80003038:	0c201737          	lui	a4,0xc201
    8000303c:	00f707b3          	add	a5,a4,a5
    80003040:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003044:	00813483          	ld	s1,8(sp)
    80003048:	02010113          	addi	sp,sp,32
    8000304c:	00008067          	ret

0000000080003050 <consolewrite>:
    80003050:	fb010113          	addi	sp,sp,-80
    80003054:	04813023          	sd	s0,64(sp)
    80003058:	04113423          	sd	ra,72(sp)
    8000305c:	02913c23          	sd	s1,56(sp)
    80003060:	03213823          	sd	s2,48(sp)
    80003064:	03313423          	sd	s3,40(sp)
    80003068:	03413023          	sd	s4,32(sp)
    8000306c:	01513c23          	sd	s5,24(sp)
    80003070:	05010413          	addi	s0,sp,80
    80003074:	06c05c63          	blez	a2,800030ec <consolewrite+0x9c>
    80003078:	00060993          	mv	s3,a2
    8000307c:	00050a13          	mv	s4,a0
    80003080:	00058493          	mv	s1,a1
    80003084:	00000913          	li	s2,0
    80003088:	fff00a93          	li	s5,-1
    8000308c:	01c0006f          	j	800030a8 <consolewrite+0x58>
    80003090:	fbf44503          	lbu	a0,-65(s0)
    80003094:	0019091b          	addiw	s2,s2,1
    80003098:	00148493          	addi	s1,s1,1
    8000309c:	00001097          	auipc	ra,0x1
    800030a0:	a9c080e7          	jalr	-1380(ra) # 80003b38 <uartputc>
    800030a4:	03298063          	beq	s3,s2,800030c4 <consolewrite+0x74>
    800030a8:	00048613          	mv	a2,s1
    800030ac:	00100693          	li	a3,1
    800030b0:	000a0593          	mv	a1,s4
    800030b4:	fbf40513          	addi	a0,s0,-65
    800030b8:	00000097          	auipc	ra,0x0
    800030bc:	9e0080e7          	jalr	-1568(ra) # 80002a98 <either_copyin>
    800030c0:	fd5518e3          	bne	a0,s5,80003090 <consolewrite+0x40>
    800030c4:	04813083          	ld	ra,72(sp)
    800030c8:	04013403          	ld	s0,64(sp)
    800030cc:	03813483          	ld	s1,56(sp)
    800030d0:	02813983          	ld	s3,40(sp)
    800030d4:	02013a03          	ld	s4,32(sp)
    800030d8:	01813a83          	ld	s5,24(sp)
    800030dc:	00090513          	mv	a0,s2
    800030e0:	03013903          	ld	s2,48(sp)
    800030e4:	05010113          	addi	sp,sp,80
    800030e8:	00008067          	ret
    800030ec:	00000913          	li	s2,0
    800030f0:	fd5ff06f          	j	800030c4 <consolewrite+0x74>

00000000800030f4 <consoleread>:
    800030f4:	f9010113          	addi	sp,sp,-112
    800030f8:	06813023          	sd	s0,96(sp)
    800030fc:	04913c23          	sd	s1,88(sp)
    80003100:	05213823          	sd	s2,80(sp)
    80003104:	05313423          	sd	s3,72(sp)
    80003108:	05413023          	sd	s4,64(sp)
    8000310c:	03513c23          	sd	s5,56(sp)
    80003110:	03613823          	sd	s6,48(sp)
    80003114:	03713423          	sd	s7,40(sp)
    80003118:	03813023          	sd	s8,32(sp)
    8000311c:	06113423          	sd	ra,104(sp)
    80003120:	01913c23          	sd	s9,24(sp)
    80003124:	07010413          	addi	s0,sp,112
    80003128:	00060b93          	mv	s7,a2
    8000312c:	00050913          	mv	s2,a0
    80003130:	00058c13          	mv	s8,a1
    80003134:	00060b1b          	sext.w	s6,a2
    80003138:	00004497          	auipc	s1,0x4
    8000313c:	d1048493          	addi	s1,s1,-752 # 80006e48 <cons>
    80003140:	00400993          	li	s3,4
    80003144:	fff00a13          	li	s4,-1
    80003148:	00a00a93          	li	s5,10
    8000314c:	05705e63          	blez	s7,800031a8 <consoleread+0xb4>
    80003150:	09c4a703          	lw	a4,156(s1)
    80003154:	0984a783          	lw	a5,152(s1)
    80003158:	0007071b          	sext.w	a4,a4
    8000315c:	08e78463          	beq	a5,a4,800031e4 <consoleread+0xf0>
    80003160:	07f7f713          	andi	a4,a5,127
    80003164:	00e48733          	add	a4,s1,a4
    80003168:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000316c:	0017869b          	addiw	a3,a5,1
    80003170:	08d4ac23          	sw	a3,152(s1)
    80003174:	00070c9b          	sext.w	s9,a4
    80003178:	0b370663          	beq	a4,s3,80003224 <consoleread+0x130>
    8000317c:	00100693          	li	a3,1
    80003180:	f9f40613          	addi	a2,s0,-97
    80003184:	000c0593          	mv	a1,s8
    80003188:	00090513          	mv	a0,s2
    8000318c:	f8e40fa3          	sb	a4,-97(s0)
    80003190:	00000097          	auipc	ra,0x0
    80003194:	8bc080e7          	jalr	-1860(ra) # 80002a4c <either_copyout>
    80003198:	01450863          	beq	a0,s4,800031a8 <consoleread+0xb4>
    8000319c:	001c0c13          	addi	s8,s8,1
    800031a0:	fffb8b9b          	addiw	s7,s7,-1
    800031a4:	fb5c94e3          	bne	s9,s5,8000314c <consoleread+0x58>
    800031a8:	000b851b          	sext.w	a0,s7
    800031ac:	06813083          	ld	ra,104(sp)
    800031b0:	06013403          	ld	s0,96(sp)
    800031b4:	05813483          	ld	s1,88(sp)
    800031b8:	05013903          	ld	s2,80(sp)
    800031bc:	04813983          	ld	s3,72(sp)
    800031c0:	04013a03          	ld	s4,64(sp)
    800031c4:	03813a83          	ld	s5,56(sp)
    800031c8:	02813b83          	ld	s7,40(sp)
    800031cc:	02013c03          	ld	s8,32(sp)
    800031d0:	01813c83          	ld	s9,24(sp)
    800031d4:	40ab053b          	subw	a0,s6,a0
    800031d8:	03013b03          	ld	s6,48(sp)
    800031dc:	07010113          	addi	sp,sp,112
    800031e0:	00008067          	ret
    800031e4:	00001097          	auipc	ra,0x1
    800031e8:	1d8080e7          	jalr	472(ra) # 800043bc <push_on>
    800031ec:	0984a703          	lw	a4,152(s1)
    800031f0:	09c4a783          	lw	a5,156(s1)
    800031f4:	0007879b          	sext.w	a5,a5
    800031f8:	fef70ce3          	beq	a4,a5,800031f0 <consoleread+0xfc>
    800031fc:	00001097          	auipc	ra,0x1
    80003200:	234080e7          	jalr	564(ra) # 80004430 <pop_on>
    80003204:	0984a783          	lw	a5,152(s1)
    80003208:	07f7f713          	andi	a4,a5,127
    8000320c:	00e48733          	add	a4,s1,a4
    80003210:	01874703          	lbu	a4,24(a4)
    80003214:	0017869b          	addiw	a3,a5,1
    80003218:	08d4ac23          	sw	a3,152(s1)
    8000321c:	00070c9b          	sext.w	s9,a4
    80003220:	f5371ee3          	bne	a4,s3,8000317c <consoleread+0x88>
    80003224:	000b851b          	sext.w	a0,s7
    80003228:	f96bf2e3          	bgeu	s7,s6,800031ac <consoleread+0xb8>
    8000322c:	08f4ac23          	sw	a5,152(s1)
    80003230:	f7dff06f          	j	800031ac <consoleread+0xb8>

0000000080003234 <consputc>:
    80003234:	10000793          	li	a5,256
    80003238:	00f50663          	beq	a0,a5,80003244 <consputc+0x10>
    8000323c:	00001317          	auipc	t1,0x1
    80003240:	9f430067          	jr	-1548(t1) # 80003c30 <uartputc_sync>
    80003244:	ff010113          	addi	sp,sp,-16
    80003248:	00113423          	sd	ra,8(sp)
    8000324c:	00813023          	sd	s0,0(sp)
    80003250:	01010413          	addi	s0,sp,16
    80003254:	00800513          	li	a0,8
    80003258:	00001097          	auipc	ra,0x1
    8000325c:	9d8080e7          	jalr	-1576(ra) # 80003c30 <uartputc_sync>
    80003260:	02000513          	li	a0,32
    80003264:	00001097          	auipc	ra,0x1
    80003268:	9cc080e7          	jalr	-1588(ra) # 80003c30 <uartputc_sync>
    8000326c:	00013403          	ld	s0,0(sp)
    80003270:	00813083          	ld	ra,8(sp)
    80003274:	00800513          	li	a0,8
    80003278:	01010113          	addi	sp,sp,16
    8000327c:	00001317          	auipc	t1,0x1
    80003280:	9b430067          	jr	-1612(t1) # 80003c30 <uartputc_sync>

0000000080003284 <consoleintr>:
    80003284:	fe010113          	addi	sp,sp,-32
    80003288:	00813823          	sd	s0,16(sp)
    8000328c:	00913423          	sd	s1,8(sp)
    80003290:	01213023          	sd	s2,0(sp)
    80003294:	00113c23          	sd	ra,24(sp)
    80003298:	02010413          	addi	s0,sp,32
    8000329c:	00004917          	auipc	s2,0x4
    800032a0:	bac90913          	addi	s2,s2,-1108 # 80006e48 <cons>
    800032a4:	00050493          	mv	s1,a0
    800032a8:	00090513          	mv	a0,s2
    800032ac:	00001097          	auipc	ra,0x1
    800032b0:	e40080e7          	jalr	-448(ra) # 800040ec <acquire>
    800032b4:	02048c63          	beqz	s1,800032ec <consoleintr+0x68>
    800032b8:	0a092783          	lw	a5,160(s2)
    800032bc:	09892703          	lw	a4,152(s2)
    800032c0:	07f00693          	li	a3,127
    800032c4:	40e7873b          	subw	a4,a5,a4
    800032c8:	02e6e263          	bltu	a3,a4,800032ec <consoleintr+0x68>
    800032cc:	00d00713          	li	a4,13
    800032d0:	04e48063          	beq	s1,a4,80003310 <consoleintr+0x8c>
    800032d4:	07f7f713          	andi	a4,a5,127
    800032d8:	00e90733          	add	a4,s2,a4
    800032dc:	0017879b          	addiw	a5,a5,1
    800032e0:	0af92023          	sw	a5,160(s2)
    800032e4:	00970c23          	sb	s1,24(a4)
    800032e8:	08f92e23          	sw	a5,156(s2)
    800032ec:	01013403          	ld	s0,16(sp)
    800032f0:	01813083          	ld	ra,24(sp)
    800032f4:	00813483          	ld	s1,8(sp)
    800032f8:	00013903          	ld	s2,0(sp)
    800032fc:	00004517          	auipc	a0,0x4
    80003300:	b4c50513          	addi	a0,a0,-1204 # 80006e48 <cons>
    80003304:	02010113          	addi	sp,sp,32
    80003308:	00001317          	auipc	t1,0x1
    8000330c:	eb030067          	jr	-336(t1) # 800041b8 <release>
    80003310:	00a00493          	li	s1,10
    80003314:	fc1ff06f          	j	800032d4 <consoleintr+0x50>

0000000080003318 <consoleinit>:
    80003318:	fe010113          	addi	sp,sp,-32
    8000331c:	00113c23          	sd	ra,24(sp)
    80003320:	00813823          	sd	s0,16(sp)
    80003324:	00913423          	sd	s1,8(sp)
    80003328:	02010413          	addi	s0,sp,32
    8000332c:	00004497          	auipc	s1,0x4
    80003330:	b1c48493          	addi	s1,s1,-1252 # 80006e48 <cons>
    80003334:	00048513          	mv	a0,s1
    80003338:	00002597          	auipc	a1,0x2
    8000333c:	f2858593          	addi	a1,a1,-216 # 80005260 <_ZZ12printIntegermE6digits+0x138>
    80003340:	00001097          	auipc	ra,0x1
    80003344:	d88080e7          	jalr	-632(ra) # 800040c8 <initlock>
    80003348:	00000097          	auipc	ra,0x0
    8000334c:	7ac080e7          	jalr	1964(ra) # 80003af4 <uartinit>
    80003350:	01813083          	ld	ra,24(sp)
    80003354:	01013403          	ld	s0,16(sp)
    80003358:	00000797          	auipc	a5,0x0
    8000335c:	d9c78793          	addi	a5,a5,-612 # 800030f4 <consoleread>
    80003360:	0af4bc23          	sd	a5,184(s1)
    80003364:	00000797          	auipc	a5,0x0
    80003368:	cec78793          	addi	a5,a5,-788 # 80003050 <consolewrite>
    8000336c:	0cf4b023          	sd	a5,192(s1)
    80003370:	00813483          	ld	s1,8(sp)
    80003374:	02010113          	addi	sp,sp,32
    80003378:	00008067          	ret

000000008000337c <console_read>:
    8000337c:	ff010113          	addi	sp,sp,-16
    80003380:	00813423          	sd	s0,8(sp)
    80003384:	01010413          	addi	s0,sp,16
    80003388:	00813403          	ld	s0,8(sp)
    8000338c:	00004317          	auipc	t1,0x4
    80003390:	b7433303          	ld	t1,-1164(t1) # 80006f00 <devsw+0x10>
    80003394:	01010113          	addi	sp,sp,16
    80003398:	00030067          	jr	t1

000000008000339c <console_write>:
    8000339c:	ff010113          	addi	sp,sp,-16
    800033a0:	00813423          	sd	s0,8(sp)
    800033a4:	01010413          	addi	s0,sp,16
    800033a8:	00813403          	ld	s0,8(sp)
    800033ac:	00004317          	auipc	t1,0x4
    800033b0:	b5c33303          	ld	t1,-1188(t1) # 80006f08 <devsw+0x18>
    800033b4:	01010113          	addi	sp,sp,16
    800033b8:	00030067          	jr	t1

00000000800033bc <panic>:
    800033bc:	fe010113          	addi	sp,sp,-32
    800033c0:	00113c23          	sd	ra,24(sp)
    800033c4:	00813823          	sd	s0,16(sp)
    800033c8:	00913423          	sd	s1,8(sp)
    800033cc:	02010413          	addi	s0,sp,32
    800033d0:	00050493          	mv	s1,a0
    800033d4:	00002517          	auipc	a0,0x2
    800033d8:	e9450513          	addi	a0,a0,-364 # 80005268 <_ZZ12printIntegermE6digits+0x140>
    800033dc:	00004797          	auipc	a5,0x4
    800033e0:	bc07a623          	sw	zero,-1076(a5) # 80006fa8 <pr+0x18>
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	034080e7          	jalr	52(ra) # 80003418 <__printf>
    800033ec:	00048513          	mv	a0,s1
    800033f0:	00000097          	auipc	ra,0x0
    800033f4:	028080e7          	jalr	40(ra) # 80003418 <__printf>
    800033f8:	00002517          	auipc	a0,0x2
    800033fc:	e5050513          	addi	a0,a0,-432 # 80005248 <_ZZ12printIntegermE6digits+0x120>
    80003400:	00000097          	auipc	ra,0x0
    80003404:	018080e7          	jalr	24(ra) # 80003418 <__printf>
    80003408:	00100793          	li	a5,1
    8000340c:	00003717          	auipc	a4,0x3
    80003410:	8ef72e23          	sw	a5,-1796(a4) # 80005d08 <panicked>
    80003414:	0000006f          	j	80003414 <panic+0x58>

0000000080003418 <__printf>:
    80003418:	f3010113          	addi	sp,sp,-208
    8000341c:	08813023          	sd	s0,128(sp)
    80003420:	07313423          	sd	s3,104(sp)
    80003424:	09010413          	addi	s0,sp,144
    80003428:	05813023          	sd	s8,64(sp)
    8000342c:	08113423          	sd	ra,136(sp)
    80003430:	06913c23          	sd	s1,120(sp)
    80003434:	07213823          	sd	s2,112(sp)
    80003438:	07413023          	sd	s4,96(sp)
    8000343c:	05513c23          	sd	s5,88(sp)
    80003440:	05613823          	sd	s6,80(sp)
    80003444:	05713423          	sd	s7,72(sp)
    80003448:	03913c23          	sd	s9,56(sp)
    8000344c:	03a13823          	sd	s10,48(sp)
    80003450:	03b13423          	sd	s11,40(sp)
    80003454:	00004317          	auipc	t1,0x4
    80003458:	b3c30313          	addi	t1,t1,-1220 # 80006f90 <pr>
    8000345c:	01832c03          	lw	s8,24(t1)
    80003460:	00b43423          	sd	a1,8(s0)
    80003464:	00c43823          	sd	a2,16(s0)
    80003468:	00d43c23          	sd	a3,24(s0)
    8000346c:	02e43023          	sd	a4,32(s0)
    80003470:	02f43423          	sd	a5,40(s0)
    80003474:	03043823          	sd	a6,48(s0)
    80003478:	03143c23          	sd	a7,56(s0)
    8000347c:	00050993          	mv	s3,a0
    80003480:	4a0c1663          	bnez	s8,8000392c <__printf+0x514>
    80003484:	60098c63          	beqz	s3,80003a9c <__printf+0x684>
    80003488:	0009c503          	lbu	a0,0(s3)
    8000348c:	00840793          	addi	a5,s0,8
    80003490:	f6f43c23          	sd	a5,-136(s0)
    80003494:	00000493          	li	s1,0
    80003498:	22050063          	beqz	a0,800036b8 <__printf+0x2a0>
    8000349c:	00002a37          	lui	s4,0x2
    800034a0:	00018ab7          	lui	s5,0x18
    800034a4:	000f4b37          	lui	s6,0xf4
    800034a8:	00989bb7          	lui	s7,0x989
    800034ac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800034b0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800034b4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800034b8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800034bc:	00148c9b          	addiw	s9,s1,1
    800034c0:	02500793          	li	a5,37
    800034c4:	01998933          	add	s2,s3,s9
    800034c8:	38f51263          	bne	a0,a5,8000384c <__printf+0x434>
    800034cc:	00094783          	lbu	a5,0(s2)
    800034d0:	00078c9b          	sext.w	s9,a5
    800034d4:	1e078263          	beqz	a5,800036b8 <__printf+0x2a0>
    800034d8:	0024849b          	addiw	s1,s1,2
    800034dc:	07000713          	li	a4,112
    800034e0:	00998933          	add	s2,s3,s1
    800034e4:	38e78a63          	beq	a5,a4,80003878 <__printf+0x460>
    800034e8:	20f76863          	bltu	a4,a5,800036f8 <__printf+0x2e0>
    800034ec:	42a78863          	beq	a5,a0,8000391c <__printf+0x504>
    800034f0:	06400713          	li	a4,100
    800034f4:	40e79663          	bne	a5,a4,80003900 <__printf+0x4e8>
    800034f8:	f7843783          	ld	a5,-136(s0)
    800034fc:	0007a603          	lw	a2,0(a5)
    80003500:	00878793          	addi	a5,a5,8
    80003504:	f6f43c23          	sd	a5,-136(s0)
    80003508:	42064a63          	bltz	a2,8000393c <__printf+0x524>
    8000350c:	00a00713          	li	a4,10
    80003510:	02e677bb          	remuw	a5,a2,a4
    80003514:	00002d97          	auipc	s11,0x2
    80003518:	d7cd8d93          	addi	s11,s11,-644 # 80005290 <digits>
    8000351c:	00900593          	li	a1,9
    80003520:	0006051b          	sext.w	a0,a2
    80003524:	00000c93          	li	s9,0
    80003528:	02079793          	slli	a5,a5,0x20
    8000352c:	0207d793          	srli	a5,a5,0x20
    80003530:	00fd87b3          	add	a5,s11,a5
    80003534:	0007c783          	lbu	a5,0(a5)
    80003538:	02e656bb          	divuw	a3,a2,a4
    8000353c:	f8f40023          	sb	a5,-128(s0)
    80003540:	14c5d863          	bge	a1,a2,80003690 <__printf+0x278>
    80003544:	06300593          	li	a1,99
    80003548:	00100c93          	li	s9,1
    8000354c:	02e6f7bb          	remuw	a5,a3,a4
    80003550:	02079793          	slli	a5,a5,0x20
    80003554:	0207d793          	srli	a5,a5,0x20
    80003558:	00fd87b3          	add	a5,s11,a5
    8000355c:	0007c783          	lbu	a5,0(a5)
    80003560:	02e6d73b          	divuw	a4,a3,a4
    80003564:	f8f400a3          	sb	a5,-127(s0)
    80003568:	12a5f463          	bgeu	a1,a0,80003690 <__printf+0x278>
    8000356c:	00a00693          	li	a3,10
    80003570:	00900593          	li	a1,9
    80003574:	02d777bb          	remuw	a5,a4,a3
    80003578:	02079793          	slli	a5,a5,0x20
    8000357c:	0207d793          	srli	a5,a5,0x20
    80003580:	00fd87b3          	add	a5,s11,a5
    80003584:	0007c503          	lbu	a0,0(a5)
    80003588:	02d757bb          	divuw	a5,a4,a3
    8000358c:	f8a40123          	sb	a0,-126(s0)
    80003590:	48e5f263          	bgeu	a1,a4,80003a14 <__printf+0x5fc>
    80003594:	06300513          	li	a0,99
    80003598:	02d7f5bb          	remuw	a1,a5,a3
    8000359c:	02059593          	slli	a1,a1,0x20
    800035a0:	0205d593          	srli	a1,a1,0x20
    800035a4:	00bd85b3          	add	a1,s11,a1
    800035a8:	0005c583          	lbu	a1,0(a1)
    800035ac:	02d7d7bb          	divuw	a5,a5,a3
    800035b0:	f8b401a3          	sb	a1,-125(s0)
    800035b4:	48e57263          	bgeu	a0,a4,80003a38 <__printf+0x620>
    800035b8:	3e700513          	li	a0,999
    800035bc:	02d7f5bb          	remuw	a1,a5,a3
    800035c0:	02059593          	slli	a1,a1,0x20
    800035c4:	0205d593          	srli	a1,a1,0x20
    800035c8:	00bd85b3          	add	a1,s11,a1
    800035cc:	0005c583          	lbu	a1,0(a1)
    800035d0:	02d7d7bb          	divuw	a5,a5,a3
    800035d4:	f8b40223          	sb	a1,-124(s0)
    800035d8:	46e57663          	bgeu	a0,a4,80003a44 <__printf+0x62c>
    800035dc:	02d7f5bb          	remuw	a1,a5,a3
    800035e0:	02059593          	slli	a1,a1,0x20
    800035e4:	0205d593          	srli	a1,a1,0x20
    800035e8:	00bd85b3          	add	a1,s11,a1
    800035ec:	0005c583          	lbu	a1,0(a1)
    800035f0:	02d7d7bb          	divuw	a5,a5,a3
    800035f4:	f8b402a3          	sb	a1,-123(s0)
    800035f8:	46ea7863          	bgeu	s4,a4,80003a68 <__printf+0x650>
    800035fc:	02d7f5bb          	remuw	a1,a5,a3
    80003600:	02059593          	slli	a1,a1,0x20
    80003604:	0205d593          	srli	a1,a1,0x20
    80003608:	00bd85b3          	add	a1,s11,a1
    8000360c:	0005c583          	lbu	a1,0(a1)
    80003610:	02d7d7bb          	divuw	a5,a5,a3
    80003614:	f8b40323          	sb	a1,-122(s0)
    80003618:	3eeaf863          	bgeu	s5,a4,80003a08 <__printf+0x5f0>
    8000361c:	02d7f5bb          	remuw	a1,a5,a3
    80003620:	02059593          	slli	a1,a1,0x20
    80003624:	0205d593          	srli	a1,a1,0x20
    80003628:	00bd85b3          	add	a1,s11,a1
    8000362c:	0005c583          	lbu	a1,0(a1)
    80003630:	02d7d7bb          	divuw	a5,a5,a3
    80003634:	f8b403a3          	sb	a1,-121(s0)
    80003638:	42eb7e63          	bgeu	s6,a4,80003a74 <__printf+0x65c>
    8000363c:	02d7f5bb          	remuw	a1,a5,a3
    80003640:	02059593          	slli	a1,a1,0x20
    80003644:	0205d593          	srli	a1,a1,0x20
    80003648:	00bd85b3          	add	a1,s11,a1
    8000364c:	0005c583          	lbu	a1,0(a1)
    80003650:	02d7d7bb          	divuw	a5,a5,a3
    80003654:	f8b40423          	sb	a1,-120(s0)
    80003658:	42ebfc63          	bgeu	s7,a4,80003a90 <__printf+0x678>
    8000365c:	02079793          	slli	a5,a5,0x20
    80003660:	0207d793          	srli	a5,a5,0x20
    80003664:	00fd8db3          	add	s11,s11,a5
    80003668:	000dc703          	lbu	a4,0(s11)
    8000366c:	00a00793          	li	a5,10
    80003670:	00900c93          	li	s9,9
    80003674:	f8e404a3          	sb	a4,-119(s0)
    80003678:	00065c63          	bgez	a2,80003690 <__printf+0x278>
    8000367c:	f9040713          	addi	a4,s0,-112
    80003680:	00f70733          	add	a4,a4,a5
    80003684:	02d00693          	li	a3,45
    80003688:	fed70823          	sb	a3,-16(a4)
    8000368c:	00078c93          	mv	s9,a5
    80003690:	f8040793          	addi	a5,s0,-128
    80003694:	01978cb3          	add	s9,a5,s9
    80003698:	f7f40d13          	addi	s10,s0,-129
    8000369c:	000cc503          	lbu	a0,0(s9)
    800036a0:	fffc8c93          	addi	s9,s9,-1
    800036a4:	00000097          	auipc	ra,0x0
    800036a8:	b90080e7          	jalr	-1136(ra) # 80003234 <consputc>
    800036ac:	ffac98e3          	bne	s9,s10,8000369c <__printf+0x284>
    800036b0:	00094503          	lbu	a0,0(s2)
    800036b4:	e00514e3          	bnez	a0,800034bc <__printf+0xa4>
    800036b8:	1a0c1663          	bnez	s8,80003864 <__printf+0x44c>
    800036bc:	08813083          	ld	ra,136(sp)
    800036c0:	08013403          	ld	s0,128(sp)
    800036c4:	07813483          	ld	s1,120(sp)
    800036c8:	07013903          	ld	s2,112(sp)
    800036cc:	06813983          	ld	s3,104(sp)
    800036d0:	06013a03          	ld	s4,96(sp)
    800036d4:	05813a83          	ld	s5,88(sp)
    800036d8:	05013b03          	ld	s6,80(sp)
    800036dc:	04813b83          	ld	s7,72(sp)
    800036e0:	04013c03          	ld	s8,64(sp)
    800036e4:	03813c83          	ld	s9,56(sp)
    800036e8:	03013d03          	ld	s10,48(sp)
    800036ec:	02813d83          	ld	s11,40(sp)
    800036f0:	0d010113          	addi	sp,sp,208
    800036f4:	00008067          	ret
    800036f8:	07300713          	li	a4,115
    800036fc:	1ce78a63          	beq	a5,a4,800038d0 <__printf+0x4b8>
    80003700:	07800713          	li	a4,120
    80003704:	1ee79e63          	bne	a5,a4,80003900 <__printf+0x4e8>
    80003708:	f7843783          	ld	a5,-136(s0)
    8000370c:	0007a703          	lw	a4,0(a5)
    80003710:	00878793          	addi	a5,a5,8
    80003714:	f6f43c23          	sd	a5,-136(s0)
    80003718:	28074263          	bltz	a4,8000399c <__printf+0x584>
    8000371c:	00002d97          	auipc	s11,0x2
    80003720:	b74d8d93          	addi	s11,s11,-1164 # 80005290 <digits>
    80003724:	00f77793          	andi	a5,a4,15
    80003728:	00fd87b3          	add	a5,s11,a5
    8000372c:	0007c683          	lbu	a3,0(a5)
    80003730:	00f00613          	li	a2,15
    80003734:	0007079b          	sext.w	a5,a4
    80003738:	f8d40023          	sb	a3,-128(s0)
    8000373c:	0047559b          	srliw	a1,a4,0x4
    80003740:	0047569b          	srliw	a3,a4,0x4
    80003744:	00000c93          	li	s9,0
    80003748:	0ee65063          	bge	a2,a4,80003828 <__printf+0x410>
    8000374c:	00f6f693          	andi	a3,a3,15
    80003750:	00dd86b3          	add	a3,s11,a3
    80003754:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003758:	0087d79b          	srliw	a5,a5,0x8
    8000375c:	00100c93          	li	s9,1
    80003760:	f8d400a3          	sb	a3,-127(s0)
    80003764:	0cb67263          	bgeu	a2,a1,80003828 <__printf+0x410>
    80003768:	00f7f693          	andi	a3,a5,15
    8000376c:	00dd86b3          	add	a3,s11,a3
    80003770:	0006c583          	lbu	a1,0(a3)
    80003774:	00f00613          	li	a2,15
    80003778:	0047d69b          	srliw	a3,a5,0x4
    8000377c:	f8b40123          	sb	a1,-126(s0)
    80003780:	0047d593          	srli	a1,a5,0x4
    80003784:	28f67e63          	bgeu	a2,a5,80003a20 <__printf+0x608>
    80003788:	00f6f693          	andi	a3,a3,15
    8000378c:	00dd86b3          	add	a3,s11,a3
    80003790:	0006c503          	lbu	a0,0(a3)
    80003794:	0087d813          	srli	a6,a5,0x8
    80003798:	0087d69b          	srliw	a3,a5,0x8
    8000379c:	f8a401a3          	sb	a0,-125(s0)
    800037a0:	28b67663          	bgeu	a2,a1,80003a2c <__printf+0x614>
    800037a4:	00f6f693          	andi	a3,a3,15
    800037a8:	00dd86b3          	add	a3,s11,a3
    800037ac:	0006c583          	lbu	a1,0(a3)
    800037b0:	00c7d513          	srli	a0,a5,0xc
    800037b4:	00c7d69b          	srliw	a3,a5,0xc
    800037b8:	f8b40223          	sb	a1,-124(s0)
    800037bc:	29067a63          	bgeu	a2,a6,80003a50 <__printf+0x638>
    800037c0:	00f6f693          	andi	a3,a3,15
    800037c4:	00dd86b3          	add	a3,s11,a3
    800037c8:	0006c583          	lbu	a1,0(a3)
    800037cc:	0107d813          	srli	a6,a5,0x10
    800037d0:	0107d69b          	srliw	a3,a5,0x10
    800037d4:	f8b402a3          	sb	a1,-123(s0)
    800037d8:	28a67263          	bgeu	a2,a0,80003a5c <__printf+0x644>
    800037dc:	00f6f693          	andi	a3,a3,15
    800037e0:	00dd86b3          	add	a3,s11,a3
    800037e4:	0006c683          	lbu	a3,0(a3)
    800037e8:	0147d79b          	srliw	a5,a5,0x14
    800037ec:	f8d40323          	sb	a3,-122(s0)
    800037f0:	21067663          	bgeu	a2,a6,800039fc <__printf+0x5e4>
    800037f4:	02079793          	slli	a5,a5,0x20
    800037f8:	0207d793          	srli	a5,a5,0x20
    800037fc:	00fd8db3          	add	s11,s11,a5
    80003800:	000dc683          	lbu	a3,0(s11)
    80003804:	00800793          	li	a5,8
    80003808:	00700c93          	li	s9,7
    8000380c:	f8d403a3          	sb	a3,-121(s0)
    80003810:	00075c63          	bgez	a4,80003828 <__printf+0x410>
    80003814:	f9040713          	addi	a4,s0,-112
    80003818:	00f70733          	add	a4,a4,a5
    8000381c:	02d00693          	li	a3,45
    80003820:	fed70823          	sb	a3,-16(a4)
    80003824:	00078c93          	mv	s9,a5
    80003828:	f8040793          	addi	a5,s0,-128
    8000382c:	01978cb3          	add	s9,a5,s9
    80003830:	f7f40d13          	addi	s10,s0,-129
    80003834:	000cc503          	lbu	a0,0(s9)
    80003838:	fffc8c93          	addi	s9,s9,-1
    8000383c:	00000097          	auipc	ra,0x0
    80003840:	9f8080e7          	jalr	-1544(ra) # 80003234 <consputc>
    80003844:	ff9d18e3          	bne	s10,s9,80003834 <__printf+0x41c>
    80003848:	0100006f          	j	80003858 <__printf+0x440>
    8000384c:	00000097          	auipc	ra,0x0
    80003850:	9e8080e7          	jalr	-1560(ra) # 80003234 <consputc>
    80003854:	000c8493          	mv	s1,s9
    80003858:	00094503          	lbu	a0,0(s2)
    8000385c:	c60510e3          	bnez	a0,800034bc <__printf+0xa4>
    80003860:	e40c0ee3          	beqz	s8,800036bc <__printf+0x2a4>
    80003864:	00003517          	auipc	a0,0x3
    80003868:	72c50513          	addi	a0,a0,1836 # 80006f90 <pr>
    8000386c:	00001097          	auipc	ra,0x1
    80003870:	94c080e7          	jalr	-1716(ra) # 800041b8 <release>
    80003874:	e49ff06f          	j	800036bc <__printf+0x2a4>
    80003878:	f7843783          	ld	a5,-136(s0)
    8000387c:	03000513          	li	a0,48
    80003880:	01000d13          	li	s10,16
    80003884:	00878713          	addi	a4,a5,8
    80003888:	0007bc83          	ld	s9,0(a5)
    8000388c:	f6e43c23          	sd	a4,-136(s0)
    80003890:	00000097          	auipc	ra,0x0
    80003894:	9a4080e7          	jalr	-1628(ra) # 80003234 <consputc>
    80003898:	07800513          	li	a0,120
    8000389c:	00000097          	auipc	ra,0x0
    800038a0:	998080e7          	jalr	-1640(ra) # 80003234 <consputc>
    800038a4:	00002d97          	auipc	s11,0x2
    800038a8:	9ecd8d93          	addi	s11,s11,-1556 # 80005290 <digits>
    800038ac:	03ccd793          	srli	a5,s9,0x3c
    800038b0:	00fd87b3          	add	a5,s11,a5
    800038b4:	0007c503          	lbu	a0,0(a5)
    800038b8:	fffd0d1b          	addiw	s10,s10,-1
    800038bc:	004c9c93          	slli	s9,s9,0x4
    800038c0:	00000097          	auipc	ra,0x0
    800038c4:	974080e7          	jalr	-1676(ra) # 80003234 <consputc>
    800038c8:	fe0d12e3          	bnez	s10,800038ac <__printf+0x494>
    800038cc:	f8dff06f          	j	80003858 <__printf+0x440>
    800038d0:	f7843783          	ld	a5,-136(s0)
    800038d4:	0007bc83          	ld	s9,0(a5)
    800038d8:	00878793          	addi	a5,a5,8
    800038dc:	f6f43c23          	sd	a5,-136(s0)
    800038e0:	000c9a63          	bnez	s9,800038f4 <__printf+0x4dc>
    800038e4:	1080006f          	j	800039ec <__printf+0x5d4>
    800038e8:	001c8c93          	addi	s9,s9,1
    800038ec:	00000097          	auipc	ra,0x0
    800038f0:	948080e7          	jalr	-1720(ra) # 80003234 <consputc>
    800038f4:	000cc503          	lbu	a0,0(s9)
    800038f8:	fe0518e3          	bnez	a0,800038e8 <__printf+0x4d0>
    800038fc:	f5dff06f          	j	80003858 <__printf+0x440>
    80003900:	02500513          	li	a0,37
    80003904:	00000097          	auipc	ra,0x0
    80003908:	930080e7          	jalr	-1744(ra) # 80003234 <consputc>
    8000390c:	000c8513          	mv	a0,s9
    80003910:	00000097          	auipc	ra,0x0
    80003914:	924080e7          	jalr	-1756(ra) # 80003234 <consputc>
    80003918:	f41ff06f          	j	80003858 <__printf+0x440>
    8000391c:	02500513          	li	a0,37
    80003920:	00000097          	auipc	ra,0x0
    80003924:	914080e7          	jalr	-1772(ra) # 80003234 <consputc>
    80003928:	f31ff06f          	j	80003858 <__printf+0x440>
    8000392c:	00030513          	mv	a0,t1
    80003930:	00000097          	auipc	ra,0x0
    80003934:	7bc080e7          	jalr	1980(ra) # 800040ec <acquire>
    80003938:	b4dff06f          	j	80003484 <__printf+0x6c>
    8000393c:	40c0053b          	negw	a0,a2
    80003940:	00a00713          	li	a4,10
    80003944:	02e576bb          	remuw	a3,a0,a4
    80003948:	00002d97          	auipc	s11,0x2
    8000394c:	948d8d93          	addi	s11,s11,-1720 # 80005290 <digits>
    80003950:	ff700593          	li	a1,-9
    80003954:	02069693          	slli	a3,a3,0x20
    80003958:	0206d693          	srli	a3,a3,0x20
    8000395c:	00dd86b3          	add	a3,s11,a3
    80003960:	0006c683          	lbu	a3,0(a3)
    80003964:	02e557bb          	divuw	a5,a0,a4
    80003968:	f8d40023          	sb	a3,-128(s0)
    8000396c:	10b65e63          	bge	a2,a1,80003a88 <__printf+0x670>
    80003970:	06300593          	li	a1,99
    80003974:	02e7f6bb          	remuw	a3,a5,a4
    80003978:	02069693          	slli	a3,a3,0x20
    8000397c:	0206d693          	srli	a3,a3,0x20
    80003980:	00dd86b3          	add	a3,s11,a3
    80003984:	0006c683          	lbu	a3,0(a3)
    80003988:	02e7d73b          	divuw	a4,a5,a4
    8000398c:	00200793          	li	a5,2
    80003990:	f8d400a3          	sb	a3,-127(s0)
    80003994:	bca5ece3          	bltu	a1,a0,8000356c <__printf+0x154>
    80003998:	ce5ff06f          	j	8000367c <__printf+0x264>
    8000399c:	40e007bb          	negw	a5,a4
    800039a0:	00002d97          	auipc	s11,0x2
    800039a4:	8f0d8d93          	addi	s11,s11,-1808 # 80005290 <digits>
    800039a8:	00f7f693          	andi	a3,a5,15
    800039ac:	00dd86b3          	add	a3,s11,a3
    800039b0:	0006c583          	lbu	a1,0(a3)
    800039b4:	ff100613          	li	a2,-15
    800039b8:	0047d69b          	srliw	a3,a5,0x4
    800039bc:	f8b40023          	sb	a1,-128(s0)
    800039c0:	0047d59b          	srliw	a1,a5,0x4
    800039c4:	0ac75e63          	bge	a4,a2,80003a80 <__printf+0x668>
    800039c8:	00f6f693          	andi	a3,a3,15
    800039cc:	00dd86b3          	add	a3,s11,a3
    800039d0:	0006c603          	lbu	a2,0(a3)
    800039d4:	00f00693          	li	a3,15
    800039d8:	0087d79b          	srliw	a5,a5,0x8
    800039dc:	f8c400a3          	sb	a2,-127(s0)
    800039e0:	d8b6e4e3          	bltu	a3,a1,80003768 <__printf+0x350>
    800039e4:	00200793          	li	a5,2
    800039e8:	e2dff06f          	j	80003814 <__printf+0x3fc>
    800039ec:	00002c97          	auipc	s9,0x2
    800039f0:	884c8c93          	addi	s9,s9,-1916 # 80005270 <_ZZ12printIntegermE6digits+0x148>
    800039f4:	02800513          	li	a0,40
    800039f8:	ef1ff06f          	j	800038e8 <__printf+0x4d0>
    800039fc:	00700793          	li	a5,7
    80003a00:	00600c93          	li	s9,6
    80003a04:	e0dff06f          	j	80003810 <__printf+0x3f8>
    80003a08:	00700793          	li	a5,7
    80003a0c:	00600c93          	li	s9,6
    80003a10:	c69ff06f          	j	80003678 <__printf+0x260>
    80003a14:	00300793          	li	a5,3
    80003a18:	00200c93          	li	s9,2
    80003a1c:	c5dff06f          	j	80003678 <__printf+0x260>
    80003a20:	00300793          	li	a5,3
    80003a24:	00200c93          	li	s9,2
    80003a28:	de9ff06f          	j	80003810 <__printf+0x3f8>
    80003a2c:	00400793          	li	a5,4
    80003a30:	00300c93          	li	s9,3
    80003a34:	dddff06f          	j	80003810 <__printf+0x3f8>
    80003a38:	00400793          	li	a5,4
    80003a3c:	00300c93          	li	s9,3
    80003a40:	c39ff06f          	j	80003678 <__printf+0x260>
    80003a44:	00500793          	li	a5,5
    80003a48:	00400c93          	li	s9,4
    80003a4c:	c2dff06f          	j	80003678 <__printf+0x260>
    80003a50:	00500793          	li	a5,5
    80003a54:	00400c93          	li	s9,4
    80003a58:	db9ff06f          	j	80003810 <__printf+0x3f8>
    80003a5c:	00600793          	li	a5,6
    80003a60:	00500c93          	li	s9,5
    80003a64:	dadff06f          	j	80003810 <__printf+0x3f8>
    80003a68:	00600793          	li	a5,6
    80003a6c:	00500c93          	li	s9,5
    80003a70:	c09ff06f          	j	80003678 <__printf+0x260>
    80003a74:	00800793          	li	a5,8
    80003a78:	00700c93          	li	s9,7
    80003a7c:	bfdff06f          	j	80003678 <__printf+0x260>
    80003a80:	00100793          	li	a5,1
    80003a84:	d91ff06f          	j	80003814 <__printf+0x3fc>
    80003a88:	00100793          	li	a5,1
    80003a8c:	bf1ff06f          	j	8000367c <__printf+0x264>
    80003a90:	00900793          	li	a5,9
    80003a94:	00800c93          	li	s9,8
    80003a98:	be1ff06f          	j	80003678 <__printf+0x260>
    80003a9c:	00001517          	auipc	a0,0x1
    80003aa0:	7dc50513          	addi	a0,a0,2012 # 80005278 <_ZZ12printIntegermE6digits+0x150>
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	918080e7          	jalr	-1768(ra) # 800033bc <panic>

0000000080003aac <printfinit>:
    80003aac:	fe010113          	addi	sp,sp,-32
    80003ab0:	00813823          	sd	s0,16(sp)
    80003ab4:	00913423          	sd	s1,8(sp)
    80003ab8:	00113c23          	sd	ra,24(sp)
    80003abc:	02010413          	addi	s0,sp,32
    80003ac0:	00003497          	auipc	s1,0x3
    80003ac4:	4d048493          	addi	s1,s1,1232 # 80006f90 <pr>
    80003ac8:	00048513          	mv	a0,s1
    80003acc:	00001597          	auipc	a1,0x1
    80003ad0:	7bc58593          	addi	a1,a1,1980 # 80005288 <_ZZ12printIntegermE6digits+0x160>
    80003ad4:	00000097          	auipc	ra,0x0
    80003ad8:	5f4080e7          	jalr	1524(ra) # 800040c8 <initlock>
    80003adc:	01813083          	ld	ra,24(sp)
    80003ae0:	01013403          	ld	s0,16(sp)
    80003ae4:	0004ac23          	sw	zero,24(s1)
    80003ae8:	00813483          	ld	s1,8(sp)
    80003aec:	02010113          	addi	sp,sp,32
    80003af0:	00008067          	ret

0000000080003af4 <uartinit>:
    80003af4:	ff010113          	addi	sp,sp,-16
    80003af8:	00813423          	sd	s0,8(sp)
    80003afc:	01010413          	addi	s0,sp,16
    80003b00:	100007b7          	lui	a5,0x10000
    80003b04:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003b08:	f8000713          	li	a4,-128
    80003b0c:	00e781a3          	sb	a4,3(a5)
    80003b10:	00300713          	li	a4,3
    80003b14:	00e78023          	sb	a4,0(a5)
    80003b18:	000780a3          	sb	zero,1(a5)
    80003b1c:	00e781a3          	sb	a4,3(a5)
    80003b20:	00700693          	li	a3,7
    80003b24:	00d78123          	sb	a3,2(a5)
    80003b28:	00e780a3          	sb	a4,1(a5)
    80003b2c:	00813403          	ld	s0,8(sp)
    80003b30:	01010113          	addi	sp,sp,16
    80003b34:	00008067          	ret

0000000080003b38 <uartputc>:
    80003b38:	00002797          	auipc	a5,0x2
    80003b3c:	1d07a783          	lw	a5,464(a5) # 80005d08 <panicked>
    80003b40:	00078463          	beqz	a5,80003b48 <uartputc+0x10>
    80003b44:	0000006f          	j	80003b44 <uartputc+0xc>
    80003b48:	fd010113          	addi	sp,sp,-48
    80003b4c:	02813023          	sd	s0,32(sp)
    80003b50:	00913c23          	sd	s1,24(sp)
    80003b54:	01213823          	sd	s2,16(sp)
    80003b58:	01313423          	sd	s3,8(sp)
    80003b5c:	02113423          	sd	ra,40(sp)
    80003b60:	03010413          	addi	s0,sp,48
    80003b64:	00002917          	auipc	s2,0x2
    80003b68:	1ac90913          	addi	s2,s2,428 # 80005d10 <uart_tx_r>
    80003b6c:	00093783          	ld	a5,0(s2)
    80003b70:	00002497          	auipc	s1,0x2
    80003b74:	1a848493          	addi	s1,s1,424 # 80005d18 <uart_tx_w>
    80003b78:	0004b703          	ld	a4,0(s1)
    80003b7c:	02078693          	addi	a3,a5,32
    80003b80:	00050993          	mv	s3,a0
    80003b84:	02e69c63          	bne	a3,a4,80003bbc <uartputc+0x84>
    80003b88:	00001097          	auipc	ra,0x1
    80003b8c:	834080e7          	jalr	-1996(ra) # 800043bc <push_on>
    80003b90:	00093783          	ld	a5,0(s2)
    80003b94:	0004b703          	ld	a4,0(s1)
    80003b98:	02078793          	addi	a5,a5,32
    80003b9c:	00e79463          	bne	a5,a4,80003ba4 <uartputc+0x6c>
    80003ba0:	0000006f          	j	80003ba0 <uartputc+0x68>
    80003ba4:	00001097          	auipc	ra,0x1
    80003ba8:	88c080e7          	jalr	-1908(ra) # 80004430 <pop_on>
    80003bac:	00093783          	ld	a5,0(s2)
    80003bb0:	0004b703          	ld	a4,0(s1)
    80003bb4:	02078693          	addi	a3,a5,32
    80003bb8:	fce688e3          	beq	a3,a4,80003b88 <uartputc+0x50>
    80003bbc:	01f77693          	andi	a3,a4,31
    80003bc0:	00003597          	auipc	a1,0x3
    80003bc4:	3f058593          	addi	a1,a1,1008 # 80006fb0 <uart_tx_buf>
    80003bc8:	00d586b3          	add	a3,a1,a3
    80003bcc:	00170713          	addi	a4,a4,1
    80003bd0:	01368023          	sb	s3,0(a3)
    80003bd4:	00e4b023          	sd	a4,0(s1)
    80003bd8:	10000637          	lui	a2,0x10000
    80003bdc:	02f71063          	bne	a4,a5,80003bfc <uartputc+0xc4>
    80003be0:	0340006f          	j	80003c14 <uartputc+0xdc>
    80003be4:	00074703          	lbu	a4,0(a4)
    80003be8:	00f93023          	sd	a5,0(s2)
    80003bec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003bf0:	00093783          	ld	a5,0(s2)
    80003bf4:	0004b703          	ld	a4,0(s1)
    80003bf8:	00f70e63          	beq	a4,a5,80003c14 <uartputc+0xdc>
    80003bfc:	00564683          	lbu	a3,5(a2)
    80003c00:	01f7f713          	andi	a4,a5,31
    80003c04:	00e58733          	add	a4,a1,a4
    80003c08:	0206f693          	andi	a3,a3,32
    80003c0c:	00178793          	addi	a5,a5,1
    80003c10:	fc069ae3          	bnez	a3,80003be4 <uartputc+0xac>
    80003c14:	02813083          	ld	ra,40(sp)
    80003c18:	02013403          	ld	s0,32(sp)
    80003c1c:	01813483          	ld	s1,24(sp)
    80003c20:	01013903          	ld	s2,16(sp)
    80003c24:	00813983          	ld	s3,8(sp)
    80003c28:	03010113          	addi	sp,sp,48
    80003c2c:	00008067          	ret

0000000080003c30 <uartputc_sync>:
    80003c30:	ff010113          	addi	sp,sp,-16
    80003c34:	00813423          	sd	s0,8(sp)
    80003c38:	01010413          	addi	s0,sp,16
    80003c3c:	00002717          	auipc	a4,0x2
    80003c40:	0cc72703          	lw	a4,204(a4) # 80005d08 <panicked>
    80003c44:	02071663          	bnez	a4,80003c70 <uartputc_sync+0x40>
    80003c48:	00050793          	mv	a5,a0
    80003c4c:	100006b7          	lui	a3,0x10000
    80003c50:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003c54:	02077713          	andi	a4,a4,32
    80003c58:	fe070ce3          	beqz	a4,80003c50 <uartputc_sync+0x20>
    80003c5c:	0ff7f793          	andi	a5,a5,255
    80003c60:	00f68023          	sb	a5,0(a3)
    80003c64:	00813403          	ld	s0,8(sp)
    80003c68:	01010113          	addi	sp,sp,16
    80003c6c:	00008067          	ret
    80003c70:	0000006f          	j	80003c70 <uartputc_sync+0x40>

0000000080003c74 <uartstart>:
    80003c74:	ff010113          	addi	sp,sp,-16
    80003c78:	00813423          	sd	s0,8(sp)
    80003c7c:	01010413          	addi	s0,sp,16
    80003c80:	00002617          	auipc	a2,0x2
    80003c84:	09060613          	addi	a2,a2,144 # 80005d10 <uart_tx_r>
    80003c88:	00002517          	auipc	a0,0x2
    80003c8c:	09050513          	addi	a0,a0,144 # 80005d18 <uart_tx_w>
    80003c90:	00063783          	ld	a5,0(a2)
    80003c94:	00053703          	ld	a4,0(a0)
    80003c98:	04f70263          	beq	a4,a5,80003cdc <uartstart+0x68>
    80003c9c:	100005b7          	lui	a1,0x10000
    80003ca0:	00003817          	auipc	a6,0x3
    80003ca4:	31080813          	addi	a6,a6,784 # 80006fb0 <uart_tx_buf>
    80003ca8:	01c0006f          	j	80003cc4 <uartstart+0x50>
    80003cac:	0006c703          	lbu	a4,0(a3)
    80003cb0:	00f63023          	sd	a5,0(a2)
    80003cb4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003cb8:	00063783          	ld	a5,0(a2)
    80003cbc:	00053703          	ld	a4,0(a0)
    80003cc0:	00f70e63          	beq	a4,a5,80003cdc <uartstart+0x68>
    80003cc4:	01f7f713          	andi	a4,a5,31
    80003cc8:	00e806b3          	add	a3,a6,a4
    80003ccc:	0055c703          	lbu	a4,5(a1)
    80003cd0:	00178793          	addi	a5,a5,1
    80003cd4:	02077713          	andi	a4,a4,32
    80003cd8:	fc071ae3          	bnez	a4,80003cac <uartstart+0x38>
    80003cdc:	00813403          	ld	s0,8(sp)
    80003ce0:	01010113          	addi	sp,sp,16
    80003ce4:	00008067          	ret

0000000080003ce8 <uartgetc>:
    80003ce8:	ff010113          	addi	sp,sp,-16
    80003cec:	00813423          	sd	s0,8(sp)
    80003cf0:	01010413          	addi	s0,sp,16
    80003cf4:	10000737          	lui	a4,0x10000
    80003cf8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003cfc:	0017f793          	andi	a5,a5,1
    80003d00:	00078c63          	beqz	a5,80003d18 <uartgetc+0x30>
    80003d04:	00074503          	lbu	a0,0(a4)
    80003d08:	0ff57513          	andi	a0,a0,255
    80003d0c:	00813403          	ld	s0,8(sp)
    80003d10:	01010113          	addi	sp,sp,16
    80003d14:	00008067          	ret
    80003d18:	fff00513          	li	a0,-1
    80003d1c:	ff1ff06f          	j	80003d0c <uartgetc+0x24>

0000000080003d20 <uartintr>:
    80003d20:	100007b7          	lui	a5,0x10000
    80003d24:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003d28:	0017f793          	andi	a5,a5,1
    80003d2c:	0a078463          	beqz	a5,80003dd4 <uartintr+0xb4>
    80003d30:	fe010113          	addi	sp,sp,-32
    80003d34:	00813823          	sd	s0,16(sp)
    80003d38:	00913423          	sd	s1,8(sp)
    80003d3c:	00113c23          	sd	ra,24(sp)
    80003d40:	02010413          	addi	s0,sp,32
    80003d44:	100004b7          	lui	s1,0x10000
    80003d48:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003d4c:	0ff57513          	andi	a0,a0,255
    80003d50:	fffff097          	auipc	ra,0xfffff
    80003d54:	534080e7          	jalr	1332(ra) # 80003284 <consoleintr>
    80003d58:	0054c783          	lbu	a5,5(s1)
    80003d5c:	0017f793          	andi	a5,a5,1
    80003d60:	fe0794e3          	bnez	a5,80003d48 <uartintr+0x28>
    80003d64:	00002617          	auipc	a2,0x2
    80003d68:	fac60613          	addi	a2,a2,-84 # 80005d10 <uart_tx_r>
    80003d6c:	00002517          	auipc	a0,0x2
    80003d70:	fac50513          	addi	a0,a0,-84 # 80005d18 <uart_tx_w>
    80003d74:	00063783          	ld	a5,0(a2)
    80003d78:	00053703          	ld	a4,0(a0)
    80003d7c:	04f70263          	beq	a4,a5,80003dc0 <uartintr+0xa0>
    80003d80:	100005b7          	lui	a1,0x10000
    80003d84:	00003817          	auipc	a6,0x3
    80003d88:	22c80813          	addi	a6,a6,556 # 80006fb0 <uart_tx_buf>
    80003d8c:	01c0006f          	j	80003da8 <uartintr+0x88>
    80003d90:	0006c703          	lbu	a4,0(a3)
    80003d94:	00f63023          	sd	a5,0(a2)
    80003d98:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003d9c:	00063783          	ld	a5,0(a2)
    80003da0:	00053703          	ld	a4,0(a0)
    80003da4:	00f70e63          	beq	a4,a5,80003dc0 <uartintr+0xa0>
    80003da8:	01f7f713          	andi	a4,a5,31
    80003dac:	00e806b3          	add	a3,a6,a4
    80003db0:	0055c703          	lbu	a4,5(a1)
    80003db4:	00178793          	addi	a5,a5,1
    80003db8:	02077713          	andi	a4,a4,32
    80003dbc:	fc071ae3          	bnez	a4,80003d90 <uartintr+0x70>
    80003dc0:	01813083          	ld	ra,24(sp)
    80003dc4:	01013403          	ld	s0,16(sp)
    80003dc8:	00813483          	ld	s1,8(sp)
    80003dcc:	02010113          	addi	sp,sp,32
    80003dd0:	00008067          	ret
    80003dd4:	00002617          	auipc	a2,0x2
    80003dd8:	f3c60613          	addi	a2,a2,-196 # 80005d10 <uart_tx_r>
    80003ddc:	00002517          	auipc	a0,0x2
    80003de0:	f3c50513          	addi	a0,a0,-196 # 80005d18 <uart_tx_w>
    80003de4:	00063783          	ld	a5,0(a2)
    80003de8:	00053703          	ld	a4,0(a0)
    80003dec:	04f70263          	beq	a4,a5,80003e30 <uartintr+0x110>
    80003df0:	100005b7          	lui	a1,0x10000
    80003df4:	00003817          	auipc	a6,0x3
    80003df8:	1bc80813          	addi	a6,a6,444 # 80006fb0 <uart_tx_buf>
    80003dfc:	01c0006f          	j	80003e18 <uartintr+0xf8>
    80003e00:	0006c703          	lbu	a4,0(a3)
    80003e04:	00f63023          	sd	a5,0(a2)
    80003e08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003e0c:	00063783          	ld	a5,0(a2)
    80003e10:	00053703          	ld	a4,0(a0)
    80003e14:	02f70063          	beq	a4,a5,80003e34 <uartintr+0x114>
    80003e18:	01f7f713          	andi	a4,a5,31
    80003e1c:	00e806b3          	add	a3,a6,a4
    80003e20:	0055c703          	lbu	a4,5(a1)
    80003e24:	00178793          	addi	a5,a5,1
    80003e28:	02077713          	andi	a4,a4,32
    80003e2c:	fc071ae3          	bnez	a4,80003e00 <uartintr+0xe0>
    80003e30:	00008067          	ret
    80003e34:	00008067          	ret

0000000080003e38 <kinit>:
    80003e38:	fc010113          	addi	sp,sp,-64
    80003e3c:	02913423          	sd	s1,40(sp)
    80003e40:	fffff7b7          	lui	a5,0xfffff
    80003e44:	00004497          	auipc	s1,0x4
    80003e48:	18b48493          	addi	s1,s1,395 # 80007fcf <end+0xfff>
    80003e4c:	02813823          	sd	s0,48(sp)
    80003e50:	01313c23          	sd	s3,24(sp)
    80003e54:	00f4f4b3          	and	s1,s1,a5
    80003e58:	02113c23          	sd	ra,56(sp)
    80003e5c:	03213023          	sd	s2,32(sp)
    80003e60:	01413823          	sd	s4,16(sp)
    80003e64:	01513423          	sd	s5,8(sp)
    80003e68:	04010413          	addi	s0,sp,64
    80003e6c:	000017b7          	lui	a5,0x1
    80003e70:	01100993          	li	s3,17
    80003e74:	00f487b3          	add	a5,s1,a5
    80003e78:	01b99993          	slli	s3,s3,0x1b
    80003e7c:	06f9e063          	bltu	s3,a5,80003edc <kinit+0xa4>
    80003e80:	00003a97          	auipc	s5,0x3
    80003e84:	150a8a93          	addi	s5,s5,336 # 80006fd0 <end>
    80003e88:	0754ec63          	bltu	s1,s5,80003f00 <kinit+0xc8>
    80003e8c:	0734fa63          	bgeu	s1,s3,80003f00 <kinit+0xc8>
    80003e90:	00088a37          	lui	s4,0x88
    80003e94:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003e98:	00002917          	auipc	s2,0x2
    80003e9c:	e8890913          	addi	s2,s2,-376 # 80005d20 <kmem>
    80003ea0:	00ca1a13          	slli	s4,s4,0xc
    80003ea4:	0140006f          	j	80003eb8 <kinit+0x80>
    80003ea8:	000017b7          	lui	a5,0x1
    80003eac:	00f484b3          	add	s1,s1,a5
    80003eb0:	0554e863          	bltu	s1,s5,80003f00 <kinit+0xc8>
    80003eb4:	0534f663          	bgeu	s1,s3,80003f00 <kinit+0xc8>
    80003eb8:	00001637          	lui	a2,0x1
    80003ebc:	00100593          	li	a1,1
    80003ec0:	00048513          	mv	a0,s1
    80003ec4:	00000097          	auipc	ra,0x0
    80003ec8:	5e4080e7          	jalr	1508(ra) # 800044a8 <__memset>
    80003ecc:	00093783          	ld	a5,0(s2)
    80003ed0:	00f4b023          	sd	a5,0(s1)
    80003ed4:	00993023          	sd	s1,0(s2)
    80003ed8:	fd4498e3          	bne	s1,s4,80003ea8 <kinit+0x70>
    80003edc:	03813083          	ld	ra,56(sp)
    80003ee0:	03013403          	ld	s0,48(sp)
    80003ee4:	02813483          	ld	s1,40(sp)
    80003ee8:	02013903          	ld	s2,32(sp)
    80003eec:	01813983          	ld	s3,24(sp)
    80003ef0:	01013a03          	ld	s4,16(sp)
    80003ef4:	00813a83          	ld	s5,8(sp)
    80003ef8:	04010113          	addi	sp,sp,64
    80003efc:	00008067          	ret
    80003f00:	00001517          	auipc	a0,0x1
    80003f04:	3a850513          	addi	a0,a0,936 # 800052a8 <digits+0x18>
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	4b4080e7          	jalr	1204(ra) # 800033bc <panic>

0000000080003f10 <freerange>:
    80003f10:	fc010113          	addi	sp,sp,-64
    80003f14:	000017b7          	lui	a5,0x1
    80003f18:	02913423          	sd	s1,40(sp)
    80003f1c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003f20:	009504b3          	add	s1,a0,s1
    80003f24:	fffff537          	lui	a0,0xfffff
    80003f28:	02813823          	sd	s0,48(sp)
    80003f2c:	02113c23          	sd	ra,56(sp)
    80003f30:	03213023          	sd	s2,32(sp)
    80003f34:	01313c23          	sd	s3,24(sp)
    80003f38:	01413823          	sd	s4,16(sp)
    80003f3c:	01513423          	sd	s5,8(sp)
    80003f40:	01613023          	sd	s6,0(sp)
    80003f44:	04010413          	addi	s0,sp,64
    80003f48:	00a4f4b3          	and	s1,s1,a0
    80003f4c:	00f487b3          	add	a5,s1,a5
    80003f50:	06f5e463          	bltu	a1,a5,80003fb8 <freerange+0xa8>
    80003f54:	00003a97          	auipc	s5,0x3
    80003f58:	07ca8a93          	addi	s5,s5,124 # 80006fd0 <end>
    80003f5c:	0954e263          	bltu	s1,s5,80003fe0 <freerange+0xd0>
    80003f60:	01100993          	li	s3,17
    80003f64:	01b99993          	slli	s3,s3,0x1b
    80003f68:	0734fc63          	bgeu	s1,s3,80003fe0 <freerange+0xd0>
    80003f6c:	00058a13          	mv	s4,a1
    80003f70:	00002917          	auipc	s2,0x2
    80003f74:	db090913          	addi	s2,s2,-592 # 80005d20 <kmem>
    80003f78:	00002b37          	lui	s6,0x2
    80003f7c:	0140006f          	j	80003f90 <freerange+0x80>
    80003f80:	000017b7          	lui	a5,0x1
    80003f84:	00f484b3          	add	s1,s1,a5
    80003f88:	0554ec63          	bltu	s1,s5,80003fe0 <freerange+0xd0>
    80003f8c:	0534fa63          	bgeu	s1,s3,80003fe0 <freerange+0xd0>
    80003f90:	00001637          	lui	a2,0x1
    80003f94:	00100593          	li	a1,1
    80003f98:	00048513          	mv	a0,s1
    80003f9c:	00000097          	auipc	ra,0x0
    80003fa0:	50c080e7          	jalr	1292(ra) # 800044a8 <__memset>
    80003fa4:	00093703          	ld	a4,0(s2)
    80003fa8:	016487b3          	add	a5,s1,s6
    80003fac:	00e4b023          	sd	a4,0(s1)
    80003fb0:	00993023          	sd	s1,0(s2)
    80003fb4:	fcfa76e3          	bgeu	s4,a5,80003f80 <freerange+0x70>
    80003fb8:	03813083          	ld	ra,56(sp)
    80003fbc:	03013403          	ld	s0,48(sp)
    80003fc0:	02813483          	ld	s1,40(sp)
    80003fc4:	02013903          	ld	s2,32(sp)
    80003fc8:	01813983          	ld	s3,24(sp)
    80003fcc:	01013a03          	ld	s4,16(sp)
    80003fd0:	00813a83          	ld	s5,8(sp)
    80003fd4:	00013b03          	ld	s6,0(sp)
    80003fd8:	04010113          	addi	sp,sp,64
    80003fdc:	00008067          	ret
    80003fe0:	00001517          	auipc	a0,0x1
    80003fe4:	2c850513          	addi	a0,a0,712 # 800052a8 <digits+0x18>
    80003fe8:	fffff097          	auipc	ra,0xfffff
    80003fec:	3d4080e7          	jalr	980(ra) # 800033bc <panic>

0000000080003ff0 <kfree>:
    80003ff0:	fe010113          	addi	sp,sp,-32
    80003ff4:	00813823          	sd	s0,16(sp)
    80003ff8:	00113c23          	sd	ra,24(sp)
    80003ffc:	00913423          	sd	s1,8(sp)
    80004000:	02010413          	addi	s0,sp,32
    80004004:	03451793          	slli	a5,a0,0x34
    80004008:	04079c63          	bnez	a5,80004060 <kfree+0x70>
    8000400c:	00003797          	auipc	a5,0x3
    80004010:	fc478793          	addi	a5,a5,-60 # 80006fd0 <end>
    80004014:	00050493          	mv	s1,a0
    80004018:	04f56463          	bltu	a0,a5,80004060 <kfree+0x70>
    8000401c:	01100793          	li	a5,17
    80004020:	01b79793          	slli	a5,a5,0x1b
    80004024:	02f57e63          	bgeu	a0,a5,80004060 <kfree+0x70>
    80004028:	00001637          	lui	a2,0x1
    8000402c:	00100593          	li	a1,1
    80004030:	00000097          	auipc	ra,0x0
    80004034:	478080e7          	jalr	1144(ra) # 800044a8 <__memset>
    80004038:	00002797          	auipc	a5,0x2
    8000403c:	ce878793          	addi	a5,a5,-792 # 80005d20 <kmem>
    80004040:	0007b703          	ld	a4,0(a5)
    80004044:	01813083          	ld	ra,24(sp)
    80004048:	01013403          	ld	s0,16(sp)
    8000404c:	00e4b023          	sd	a4,0(s1)
    80004050:	0097b023          	sd	s1,0(a5)
    80004054:	00813483          	ld	s1,8(sp)
    80004058:	02010113          	addi	sp,sp,32
    8000405c:	00008067          	ret
    80004060:	00001517          	auipc	a0,0x1
    80004064:	24850513          	addi	a0,a0,584 # 800052a8 <digits+0x18>
    80004068:	fffff097          	auipc	ra,0xfffff
    8000406c:	354080e7          	jalr	852(ra) # 800033bc <panic>

0000000080004070 <kalloc>:
    80004070:	fe010113          	addi	sp,sp,-32
    80004074:	00813823          	sd	s0,16(sp)
    80004078:	00913423          	sd	s1,8(sp)
    8000407c:	00113c23          	sd	ra,24(sp)
    80004080:	02010413          	addi	s0,sp,32
    80004084:	00002797          	auipc	a5,0x2
    80004088:	c9c78793          	addi	a5,a5,-868 # 80005d20 <kmem>
    8000408c:	0007b483          	ld	s1,0(a5)
    80004090:	02048063          	beqz	s1,800040b0 <kalloc+0x40>
    80004094:	0004b703          	ld	a4,0(s1)
    80004098:	00001637          	lui	a2,0x1
    8000409c:	00500593          	li	a1,5
    800040a0:	00048513          	mv	a0,s1
    800040a4:	00e7b023          	sd	a4,0(a5)
    800040a8:	00000097          	auipc	ra,0x0
    800040ac:	400080e7          	jalr	1024(ra) # 800044a8 <__memset>
    800040b0:	01813083          	ld	ra,24(sp)
    800040b4:	01013403          	ld	s0,16(sp)
    800040b8:	00048513          	mv	a0,s1
    800040bc:	00813483          	ld	s1,8(sp)
    800040c0:	02010113          	addi	sp,sp,32
    800040c4:	00008067          	ret

00000000800040c8 <initlock>:
    800040c8:	ff010113          	addi	sp,sp,-16
    800040cc:	00813423          	sd	s0,8(sp)
    800040d0:	01010413          	addi	s0,sp,16
    800040d4:	00813403          	ld	s0,8(sp)
    800040d8:	00b53423          	sd	a1,8(a0)
    800040dc:	00052023          	sw	zero,0(a0)
    800040e0:	00053823          	sd	zero,16(a0)
    800040e4:	01010113          	addi	sp,sp,16
    800040e8:	00008067          	ret

00000000800040ec <acquire>:
    800040ec:	fe010113          	addi	sp,sp,-32
    800040f0:	00813823          	sd	s0,16(sp)
    800040f4:	00913423          	sd	s1,8(sp)
    800040f8:	00113c23          	sd	ra,24(sp)
    800040fc:	01213023          	sd	s2,0(sp)
    80004100:	02010413          	addi	s0,sp,32
    80004104:	00050493          	mv	s1,a0
    80004108:	10002973          	csrr	s2,sstatus
    8000410c:	100027f3          	csrr	a5,sstatus
    80004110:	ffd7f793          	andi	a5,a5,-3
    80004114:	10079073          	csrw	sstatus,a5
    80004118:	fffff097          	auipc	ra,0xfffff
    8000411c:	8e8080e7          	jalr	-1816(ra) # 80002a00 <mycpu>
    80004120:	07852783          	lw	a5,120(a0)
    80004124:	06078e63          	beqz	a5,800041a0 <acquire+0xb4>
    80004128:	fffff097          	auipc	ra,0xfffff
    8000412c:	8d8080e7          	jalr	-1832(ra) # 80002a00 <mycpu>
    80004130:	07852783          	lw	a5,120(a0)
    80004134:	0004a703          	lw	a4,0(s1)
    80004138:	0017879b          	addiw	a5,a5,1
    8000413c:	06f52c23          	sw	a5,120(a0)
    80004140:	04071063          	bnez	a4,80004180 <acquire+0x94>
    80004144:	00100713          	li	a4,1
    80004148:	00070793          	mv	a5,a4
    8000414c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004150:	0007879b          	sext.w	a5,a5
    80004154:	fe079ae3          	bnez	a5,80004148 <acquire+0x5c>
    80004158:	0ff0000f          	fence
    8000415c:	fffff097          	auipc	ra,0xfffff
    80004160:	8a4080e7          	jalr	-1884(ra) # 80002a00 <mycpu>
    80004164:	01813083          	ld	ra,24(sp)
    80004168:	01013403          	ld	s0,16(sp)
    8000416c:	00a4b823          	sd	a0,16(s1)
    80004170:	00013903          	ld	s2,0(sp)
    80004174:	00813483          	ld	s1,8(sp)
    80004178:	02010113          	addi	sp,sp,32
    8000417c:	00008067          	ret
    80004180:	0104b903          	ld	s2,16(s1)
    80004184:	fffff097          	auipc	ra,0xfffff
    80004188:	87c080e7          	jalr	-1924(ra) # 80002a00 <mycpu>
    8000418c:	faa91ce3          	bne	s2,a0,80004144 <acquire+0x58>
    80004190:	00001517          	auipc	a0,0x1
    80004194:	12050513          	addi	a0,a0,288 # 800052b0 <digits+0x20>
    80004198:	fffff097          	auipc	ra,0xfffff
    8000419c:	224080e7          	jalr	548(ra) # 800033bc <panic>
    800041a0:	00195913          	srli	s2,s2,0x1
    800041a4:	fffff097          	auipc	ra,0xfffff
    800041a8:	85c080e7          	jalr	-1956(ra) # 80002a00 <mycpu>
    800041ac:	00197913          	andi	s2,s2,1
    800041b0:	07252e23          	sw	s2,124(a0)
    800041b4:	f75ff06f          	j	80004128 <acquire+0x3c>

00000000800041b8 <release>:
    800041b8:	fe010113          	addi	sp,sp,-32
    800041bc:	00813823          	sd	s0,16(sp)
    800041c0:	00113c23          	sd	ra,24(sp)
    800041c4:	00913423          	sd	s1,8(sp)
    800041c8:	01213023          	sd	s2,0(sp)
    800041cc:	02010413          	addi	s0,sp,32
    800041d0:	00052783          	lw	a5,0(a0)
    800041d4:	00079a63          	bnez	a5,800041e8 <release+0x30>
    800041d8:	00001517          	auipc	a0,0x1
    800041dc:	0e050513          	addi	a0,a0,224 # 800052b8 <digits+0x28>
    800041e0:	fffff097          	auipc	ra,0xfffff
    800041e4:	1dc080e7          	jalr	476(ra) # 800033bc <panic>
    800041e8:	01053903          	ld	s2,16(a0)
    800041ec:	00050493          	mv	s1,a0
    800041f0:	fffff097          	auipc	ra,0xfffff
    800041f4:	810080e7          	jalr	-2032(ra) # 80002a00 <mycpu>
    800041f8:	fea910e3          	bne	s2,a0,800041d8 <release+0x20>
    800041fc:	0004b823          	sd	zero,16(s1)
    80004200:	0ff0000f          	fence
    80004204:	0f50000f          	fence	iorw,ow
    80004208:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000420c:	ffffe097          	auipc	ra,0xffffe
    80004210:	7f4080e7          	jalr	2036(ra) # 80002a00 <mycpu>
    80004214:	100027f3          	csrr	a5,sstatus
    80004218:	0027f793          	andi	a5,a5,2
    8000421c:	04079a63          	bnez	a5,80004270 <release+0xb8>
    80004220:	07852783          	lw	a5,120(a0)
    80004224:	02f05e63          	blez	a5,80004260 <release+0xa8>
    80004228:	fff7871b          	addiw	a4,a5,-1
    8000422c:	06e52c23          	sw	a4,120(a0)
    80004230:	00071c63          	bnez	a4,80004248 <release+0x90>
    80004234:	07c52783          	lw	a5,124(a0)
    80004238:	00078863          	beqz	a5,80004248 <release+0x90>
    8000423c:	100027f3          	csrr	a5,sstatus
    80004240:	0027e793          	ori	a5,a5,2
    80004244:	10079073          	csrw	sstatus,a5
    80004248:	01813083          	ld	ra,24(sp)
    8000424c:	01013403          	ld	s0,16(sp)
    80004250:	00813483          	ld	s1,8(sp)
    80004254:	00013903          	ld	s2,0(sp)
    80004258:	02010113          	addi	sp,sp,32
    8000425c:	00008067          	ret
    80004260:	00001517          	auipc	a0,0x1
    80004264:	07850513          	addi	a0,a0,120 # 800052d8 <digits+0x48>
    80004268:	fffff097          	auipc	ra,0xfffff
    8000426c:	154080e7          	jalr	340(ra) # 800033bc <panic>
    80004270:	00001517          	auipc	a0,0x1
    80004274:	05050513          	addi	a0,a0,80 # 800052c0 <digits+0x30>
    80004278:	fffff097          	auipc	ra,0xfffff
    8000427c:	144080e7          	jalr	324(ra) # 800033bc <panic>

0000000080004280 <holding>:
    80004280:	00052783          	lw	a5,0(a0)
    80004284:	00079663          	bnez	a5,80004290 <holding+0x10>
    80004288:	00000513          	li	a0,0
    8000428c:	00008067          	ret
    80004290:	fe010113          	addi	sp,sp,-32
    80004294:	00813823          	sd	s0,16(sp)
    80004298:	00913423          	sd	s1,8(sp)
    8000429c:	00113c23          	sd	ra,24(sp)
    800042a0:	02010413          	addi	s0,sp,32
    800042a4:	01053483          	ld	s1,16(a0)
    800042a8:	ffffe097          	auipc	ra,0xffffe
    800042ac:	758080e7          	jalr	1880(ra) # 80002a00 <mycpu>
    800042b0:	01813083          	ld	ra,24(sp)
    800042b4:	01013403          	ld	s0,16(sp)
    800042b8:	40a48533          	sub	a0,s1,a0
    800042bc:	00153513          	seqz	a0,a0
    800042c0:	00813483          	ld	s1,8(sp)
    800042c4:	02010113          	addi	sp,sp,32
    800042c8:	00008067          	ret

00000000800042cc <push_off>:
    800042cc:	fe010113          	addi	sp,sp,-32
    800042d0:	00813823          	sd	s0,16(sp)
    800042d4:	00113c23          	sd	ra,24(sp)
    800042d8:	00913423          	sd	s1,8(sp)
    800042dc:	02010413          	addi	s0,sp,32
    800042e0:	100024f3          	csrr	s1,sstatus
    800042e4:	100027f3          	csrr	a5,sstatus
    800042e8:	ffd7f793          	andi	a5,a5,-3
    800042ec:	10079073          	csrw	sstatus,a5
    800042f0:	ffffe097          	auipc	ra,0xffffe
    800042f4:	710080e7          	jalr	1808(ra) # 80002a00 <mycpu>
    800042f8:	07852783          	lw	a5,120(a0)
    800042fc:	02078663          	beqz	a5,80004328 <push_off+0x5c>
    80004300:	ffffe097          	auipc	ra,0xffffe
    80004304:	700080e7          	jalr	1792(ra) # 80002a00 <mycpu>
    80004308:	07852783          	lw	a5,120(a0)
    8000430c:	01813083          	ld	ra,24(sp)
    80004310:	01013403          	ld	s0,16(sp)
    80004314:	0017879b          	addiw	a5,a5,1
    80004318:	06f52c23          	sw	a5,120(a0)
    8000431c:	00813483          	ld	s1,8(sp)
    80004320:	02010113          	addi	sp,sp,32
    80004324:	00008067          	ret
    80004328:	0014d493          	srli	s1,s1,0x1
    8000432c:	ffffe097          	auipc	ra,0xffffe
    80004330:	6d4080e7          	jalr	1748(ra) # 80002a00 <mycpu>
    80004334:	0014f493          	andi	s1,s1,1
    80004338:	06952e23          	sw	s1,124(a0)
    8000433c:	fc5ff06f          	j	80004300 <push_off+0x34>

0000000080004340 <pop_off>:
    80004340:	ff010113          	addi	sp,sp,-16
    80004344:	00813023          	sd	s0,0(sp)
    80004348:	00113423          	sd	ra,8(sp)
    8000434c:	01010413          	addi	s0,sp,16
    80004350:	ffffe097          	auipc	ra,0xffffe
    80004354:	6b0080e7          	jalr	1712(ra) # 80002a00 <mycpu>
    80004358:	100027f3          	csrr	a5,sstatus
    8000435c:	0027f793          	andi	a5,a5,2
    80004360:	04079663          	bnez	a5,800043ac <pop_off+0x6c>
    80004364:	07852783          	lw	a5,120(a0)
    80004368:	02f05a63          	blez	a5,8000439c <pop_off+0x5c>
    8000436c:	fff7871b          	addiw	a4,a5,-1
    80004370:	06e52c23          	sw	a4,120(a0)
    80004374:	00071c63          	bnez	a4,8000438c <pop_off+0x4c>
    80004378:	07c52783          	lw	a5,124(a0)
    8000437c:	00078863          	beqz	a5,8000438c <pop_off+0x4c>
    80004380:	100027f3          	csrr	a5,sstatus
    80004384:	0027e793          	ori	a5,a5,2
    80004388:	10079073          	csrw	sstatus,a5
    8000438c:	00813083          	ld	ra,8(sp)
    80004390:	00013403          	ld	s0,0(sp)
    80004394:	01010113          	addi	sp,sp,16
    80004398:	00008067          	ret
    8000439c:	00001517          	auipc	a0,0x1
    800043a0:	f3c50513          	addi	a0,a0,-196 # 800052d8 <digits+0x48>
    800043a4:	fffff097          	auipc	ra,0xfffff
    800043a8:	018080e7          	jalr	24(ra) # 800033bc <panic>
    800043ac:	00001517          	auipc	a0,0x1
    800043b0:	f1450513          	addi	a0,a0,-236 # 800052c0 <digits+0x30>
    800043b4:	fffff097          	auipc	ra,0xfffff
    800043b8:	008080e7          	jalr	8(ra) # 800033bc <panic>

00000000800043bc <push_on>:
    800043bc:	fe010113          	addi	sp,sp,-32
    800043c0:	00813823          	sd	s0,16(sp)
    800043c4:	00113c23          	sd	ra,24(sp)
    800043c8:	00913423          	sd	s1,8(sp)
    800043cc:	02010413          	addi	s0,sp,32
    800043d0:	100024f3          	csrr	s1,sstatus
    800043d4:	100027f3          	csrr	a5,sstatus
    800043d8:	0027e793          	ori	a5,a5,2
    800043dc:	10079073          	csrw	sstatus,a5
    800043e0:	ffffe097          	auipc	ra,0xffffe
    800043e4:	620080e7          	jalr	1568(ra) # 80002a00 <mycpu>
    800043e8:	07852783          	lw	a5,120(a0)
    800043ec:	02078663          	beqz	a5,80004418 <push_on+0x5c>
    800043f0:	ffffe097          	auipc	ra,0xffffe
    800043f4:	610080e7          	jalr	1552(ra) # 80002a00 <mycpu>
    800043f8:	07852783          	lw	a5,120(a0)
    800043fc:	01813083          	ld	ra,24(sp)
    80004400:	01013403          	ld	s0,16(sp)
    80004404:	0017879b          	addiw	a5,a5,1
    80004408:	06f52c23          	sw	a5,120(a0)
    8000440c:	00813483          	ld	s1,8(sp)
    80004410:	02010113          	addi	sp,sp,32
    80004414:	00008067          	ret
    80004418:	0014d493          	srli	s1,s1,0x1
    8000441c:	ffffe097          	auipc	ra,0xffffe
    80004420:	5e4080e7          	jalr	1508(ra) # 80002a00 <mycpu>
    80004424:	0014f493          	andi	s1,s1,1
    80004428:	06952e23          	sw	s1,124(a0)
    8000442c:	fc5ff06f          	j	800043f0 <push_on+0x34>

0000000080004430 <pop_on>:
    80004430:	ff010113          	addi	sp,sp,-16
    80004434:	00813023          	sd	s0,0(sp)
    80004438:	00113423          	sd	ra,8(sp)
    8000443c:	01010413          	addi	s0,sp,16
    80004440:	ffffe097          	auipc	ra,0xffffe
    80004444:	5c0080e7          	jalr	1472(ra) # 80002a00 <mycpu>
    80004448:	100027f3          	csrr	a5,sstatus
    8000444c:	0027f793          	andi	a5,a5,2
    80004450:	04078463          	beqz	a5,80004498 <pop_on+0x68>
    80004454:	07852783          	lw	a5,120(a0)
    80004458:	02f05863          	blez	a5,80004488 <pop_on+0x58>
    8000445c:	fff7879b          	addiw	a5,a5,-1
    80004460:	06f52c23          	sw	a5,120(a0)
    80004464:	07853783          	ld	a5,120(a0)
    80004468:	00079863          	bnez	a5,80004478 <pop_on+0x48>
    8000446c:	100027f3          	csrr	a5,sstatus
    80004470:	ffd7f793          	andi	a5,a5,-3
    80004474:	10079073          	csrw	sstatus,a5
    80004478:	00813083          	ld	ra,8(sp)
    8000447c:	00013403          	ld	s0,0(sp)
    80004480:	01010113          	addi	sp,sp,16
    80004484:	00008067          	ret
    80004488:	00001517          	auipc	a0,0x1
    8000448c:	e7850513          	addi	a0,a0,-392 # 80005300 <digits+0x70>
    80004490:	fffff097          	auipc	ra,0xfffff
    80004494:	f2c080e7          	jalr	-212(ra) # 800033bc <panic>
    80004498:	00001517          	auipc	a0,0x1
    8000449c:	e4850513          	addi	a0,a0,-440 # 800052e0 <digits+0x50>
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	f1c080e7          	jalr	-228(ra) # 800033bc <panic>

00000000800044a8 <__memset>:
    800044a8:	ff010113          	addi	sp,sp,-16
    800044ac:	00813423          	sd	s0,8(sp)
    800044b0:	01010413          	addi	s0,sp,16
    800044b4:	1a060e63          	beqz	a2,80004670 <__memset+0x1c8>
    800044b8:	40a007b3          	neg	a5,a0
    800044bc:	0077f793          	andi	a5,a5,7
    800044c0:	00778693          	addi	a3,a5,7
    800044c4:	00b00813          	li	a6,11
    800044c8:	0ff5f593          	andi	a1,a1,255
    800044cc:	fff6071b          	addiw	a4,a2,-1
    800044d0:	1b06e663          	bltu	a3,a6,8000467c <__memset+0x1d4>
    800044d4:	1cd76463          	bltu	a4,a3,8000469c <__memset+0x1f4>
    800044d8:	1a078e63          	beqz	a5,80004694 <__memset+0x1ec>
    800044dc:	00b50023          	sb	a1,0(a0)
    800044e0:	00100713          	li	a4,1
    800044e4:	1ae78463          	beq	a5,a4,8000468c <__memset+0x1e4>
    800044e8:	00b500a3          	sb	a1,1(a0)
    800044ec:	00200713          	li	a4,2
    800044f0:	1ae78a63          	beq	a5,a4,800046a4 <__memset+0x1fc>
    800044f4:	00b50123          	sb	a1,2(a0)
    800044f8:	00300713          	li	a4,3
    800044fc:	18e78463          	beq	a5,a4,80004684 <__memset+0x1dc>
    80004500:	00b501a3          	sb	a1,3(a0)
    80004504:	00400713          	li	a4,4
    80004508:	1ae78263          	beq	a5,a4,800046ac <__memset+0x204>
    8000450c:	00b50223          	sb	a1,4(a0)
    80004510:	00500713          	li	a4,5
    80004514:	1ae78063          	beq	a5,a4,800046b4 <__memset+0x20c>
    80004518:	00b502a3          	sb	a1,5(a0)
    8000451c:	00700713          	li	a4,7
    80004520:	18e79e63          	bne	a5,a4,800046bc <__memset+0x214>
    80004524:	00b50323          	sb	a1,6(a0)
    80004528:	00700e93          	li	t4,7
    8000452c:	00859713          	slli	a4,a1,0x8
    80004530:	00e5e733          	or	a4,a1,a4
    80004534:	01059e13          	slli	t3,a1,0x10
    80004538:	01c76e33          	or	t3,a4,t3
    8000453c:	01859313          	slli	t1,a1,0x18
    80004540:	006e6333          	or	t1,t3,t1
    80004544:	02059893          	slli	a7,a1,0x20
    80004548:	40f60e3b          	subw	t3,a2,a5
    8000454c:	011368b3          	or	a7,t1,a7
    80004550:	02859813          	slli	a6,a1,0x28
    80004554:	0108e833          	or	a6,a7,a6
    80004558:	03059693          	slli	a3,a1,0x30
    8000455c:	003e589b          	srliw	a7,t3,0x3
    80004560:	00d866b3          	or	a3,a6,a3
    80004564:	03859713          	slli	a4,a1,0x38
    80004568:	00389813          	slli	a6,a7,0x3
    8000456c:	00f507b3          	add	a5,a0,a5
    80004570:	00e6e733          	or	a4,a3,a4
    80004574:	000e089b          	sext.w	a7,t3
    80004578:	00f806b3          	add	a3,a6,a5
    8000457c:	00e7b023          	sd	a4,0(a5)
    80004580:	00878793          	addi	a5,a5,8
    80004584:	fed79ce3          	bne	a5,a3,8000457c <__memset+0xd4>
    80004588:	ff8e7793          	andi	a5,t3,-8
    8000458c:	0007871b          	sext.w	a4,a5
    80004590:	01d787bb          	addw	a5,a5,t4
    80004594:	0ce88e63          	beq	a7,a4,80004670 <__memset+0x1c8>
    80004598:	00f50733          	add	a4,a0,a5
    8000459c:	00b70023          	sb	a1,0(a4)
    800045a0:	0017871b          	addiw	a4,a5,1
    800045a4:	0cc77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045a8:	00e50733          	add	a4,a0,a4
    800045ac:	00b70023          	sb	a1,0(a4)
    800045b0:	0027871b          	addiw	a4,a5,2
    800045b4:	0ac77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045b8:	00e50733          	add	a4,a0,a4
    800045bc:	00b70023          	sb	a1,0(a4)
    800045c0:	0037871b          	addiw	a4,a5,3
    800045c4:	0ac77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045c8:	00e50733          	add	a4,a0,a4
    800045cc:	00b70023          	sb	a1,0(a4)
    800045d0:	0047871b          	addiw	a4,a5,4
    800045d4:	08c77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045d8:	00e50733          	add	a4,a0,a4
    800045dc:	00b70023          	sb	a1,0(a4)
    800045e0:	0057871b          	addiw	a4,a5,5
    800045e4:	08c77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045e8:	00e50733          	add	a4,a0,a4
    800045ec:	00b70023          	sb	a1,0(a4)
    800045f0:	0067871b          	addiw	a4,a5,6
    800045f4:	06c77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    800045f8:	00e50733          	add	a4,a0,a4
    800045fc:	00b70023          	sb	a1,0(a4)
    80004600:	0077871b          	addiw	a4,a5,7
    80004604:	06c77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004608:	00e50733          	add	a4,a0,a4
    8000460c:	00b70023          	sb	a1,0(a4)
    80004610:	0087871b          	addiw	a4,a5,8
    80004614:	04c77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004618:	00e50733          	add	a4,a0,a4
    8000461c:	00b70023          	sb	a1,0(a4)
    80004620:	0097871b          	addiw	a4,a5,9
    80004624:	04c77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004628:	00e50733          	add	a4,a0,a4
    8000462c:	00b70023          	sb	a1,0(a4)
    80004630:	00a7871b          	addiw	a4,a5,10
    80004634:	02c77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004638:	00e50733          	add	a4,a0,a4
    8000463c:	00b70023          	sb	a1,0(a4)
    80004640:	00b7871b          	addiw	a4,a5,11
    80004644:	02c77663          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004648:	00e50733          	add	a4,a0,a4
    8000464c:	00b70023          	sb	a1,0(a4)
    80004650:	00c7871b          	addiw	a4,a5,12
    80004654:	00c77e63          	bgeu	a4,a2,80004670 <__memset+0x1c8>
    80004658:	00e50733          	add	a4,a0,a4
    8000465c:	00b70023          	sb	a1,0(a4)
    80004660:	00d7879b          	addiw	a5,a5,13
    80004664:	00c7f663          	bgeu	a5,a2,80004670 <__memset+0x1c8>
    80004668:	00f507b3          	add	a5,a0,a5
    8000466c:	00b78023          	sb	a1,0(a5)
    80004670:	00813403          	ld	s0,8(sp)
    80004674:	01010113          	addi	sp,sp,16
    80004678:	00008067          	ret
    8000467c:	00b00693          	li	a3,11
    80004680:	e55ff06f          	j	800044d4 <__memset+0x2c>
    80004684:	00300e93          	li	t4,3
    80004688:	ea5ff06f          	j	8000452c <__memset+0x84>
    8000468c:	00100e93          	li	t4,1
    80004690:	e9dff06f          	j	8000452c <__memset+0x84>
    80004694:	00000e93          	li	t4,0
    80004698:	e95ff06f          	j	8000452c <__memset+0x84>
    8000469c:	00000793          	li	a5,0
    800046a0:	ef9ff06f          	j	80004598 <__memset+0xf0>
    800046a4:	00200e93          	li	t4,2
    800046a8:	e85ff06f          	j	8000452c <__memset+0x84>
    800046ac:	00400e93          	li	t4,4
    800046b0:	e7dff06f          	j	8000452c <__memset+0x84>
    800046b4:	00500e93          	li	t4,5
    800046b8:	e75ff06f          	j	8000452c <__memset+0x84>
    800046bc:	00600e93          	li	t4,6
    800046c0:	e6dff06f          	j	8000452c <__memset+0x84>

00000000800046c4 <__memmove>:
    800046c4:	ff010113          	addi	sp,sp,-16
    800046c8:	00813423          	sd	s0,8(sp)
    800046cc:	01010413          	addi	s0,sp,16
    800046d0:	0e060863          	beqz	a2,800047c0 <__memmove+0xfc>
    800046d4:	fff6069b          	addiw	a3,a2,-1
    800046d8:	0006881b          	sext.w	a6,a3
    800046dc:	0ea5e863          	bltu	a1,a0,800047cc <__memmove+0x108>
    800046e0:	00758713          	addi	a4,a1,7
    800046e4:	00a5e7b3          	or	a5,a1,a0
    800046e8:	40a70733          	sub	a4,a4,a0
    800046ec:	0077f793          	andi	a5,a5,7
    800046f0:	00f73713          	sltiu	a4,a4,15
    800046f4:	00174713          	xori	a4,a4,1
    800046f8:	0017b793          	seqz	a5,a5
    800046fc:	00e7f7b3          	and	a5,a5,a4
    80004700:	10078863          	beqz	a5,80004810 <__memmove+0x14c>
    80004704:	00900793          	li	a5,9
    80004708:	1107f463          	bgeu	a5,a6,80004810 <__memmove+0x14c>
    8000470c:	0036581b          	srliw	a6,a2,0x3
    80004710:	fff8081b          	addiw	a6,a6,-1
    80004714:	02081813          	slli	a6,a6,0x20
    80004718:	01d85893          	srli	a7,a6,0x1d
    8000471c:	00858813          	addi	a6,a1,8
    80004720:	00058793          	mv	a5,a1
    80004724:	00050713          	mv	a4,a0
    80004728:	01088833          	add	a6,a7,a6
    8000472c:	0007b883          	ld	a7,0(a5)
    80004730:	00878793          	addi	a5,a5,8
    80004734:	00870713          	addi	a4,a4,8
    80004738:	ff173c23          	sd	a7,-8(a4)
    8000473c:	ff0798e3          	bne	a5,a6,8000472c <__memmove+0x68>
    80004740:	ff867713          	andi	a4,a2,-8
    80004744:	02071793          	slli	a5,a4,0x20
    80004748:	0207d793          	srli	a5,a5,0x20
    8000474c:	00f585b3          	add	a1,a1,a5
    80004750:	40e686bb          	subw	a3,a3,a4
    80004754:	00f507b3          	add	a5,a0,a5
    80004758:	06e60463          	beq	a2,a4,800047c0 <__memmove+0xfc>
    8000475c:	0005c703          	lbu	a4,0(a1)
    80004760:	00e78023          	sb	a4,0(a5)
    80004764:	04068e63          	beqz	a3,800047c0 <__memmove+0xfc>
    80004768:	0015c603          	lbu	a2,1(a1)
    8000476c:	00100713          	li	a4,1
    80004770:	00c780a3          	sb	a2,1(a5)
    80004774:	04e68663          	beq	a3,a4,800047c0 <__memmove+0xfc>
    80004778:	0025c603          	lbu	a2,2(a1)
    8000477c:	00200713          	li	a4,2
    80004780:	00c78123          	sb	a2,2(a5)
    80004784:	02e68e63          	beq	a3,a4,800047c0 <__memmove+0xfc>
    80004788:	0035c603          	lbu	a2,3(a1)
    8000478c:	00300713          	li	a4,3
    80004790:	00c781a3          	sb	a2,3(a5)
    80004794:	02e68663          	beq	a3,a4,800047c0 <__memmove+0xfc>
    80004798:	0045c603          	lbu	a2,4(a1)
    8000479c:	00400713          	li	a4,4
    800047a0:	00c78223          	sb	a2,4(a5)
    800047a4:	00e68e63          	beq	a3,a4,800047c0 <__memmove+0xfc>
    800047a8:	0055c603          	lbu	a2,5(a1)
    800047ac:	00500713          	li	a4,5
    800047b0:	00c782a3          	sb	a2,5(a5)
    800047b4:	00e68663          	beq	a3,a4,800047c0 <__memmove+0xfc>
    800047b8:	0065c703          	lbu	a4,6(a1)
    800047bc:	00e78323          	sb	a4,6(a5)
    800047c0:	00813403          	ld	s0,8(sp)
    800047c4:	01010113          	addi	sp,sp,16
    800047c8:	00008067          	ret
    800047cc:	02061713          	slli	a4,a2,0x20
    800047d0:	02075713          	srli	a4,a4,0x20
    800047d4:	00e587b3          	add	a5,a1,a4
    800047d8:	f0f574e3          	bgeu	a0,a5,800046e0 <__memmove+0x1c>
    800047dc:	02069613          	slli	a2,a3,0x20
    800047e0:	02065613          	srli	a2,a2,0x20
    800047e4:	fff64613          	not	a2,a2
    800047e8:	00e50733          	add	a4,a0,a4
    800047ec:	00c78633          	add	a2,a5,a2
    800047f0:	fff7c683          	lbu	a3,-1(a5)
    800047f4:	fff78793          	addi	a5,a5,-1
    800047f8:	fff70713          	addi	a4,a4,-1
    800047fc:	00d70023          	sb	a3,0(a4)
    80004800:	fec798e3          	bne	a5,a2,800047f0 <__memmove+0x12c>
    80004804:	00813403          	ld	s0,8(sp)
    80004808:	01010113          	addi	sp,sp,16
    8000480c:	00008067          	ret
    80004810:	02069713          	slli	a4,a3,0x20
    80004814:	02075713          	srli	a4,a4,0x20
    80004818:	00170713          	addi	a4,a4,1
    8000481c:	00e50733          	add	a4,a0,a4
    80004820:	00050793          	mv	a5,a0
    80004824:	0005c683          	lbu	a3,0(a1)
    80004828:	00178793          	addi	a5,a5,1
    8000482c:	00158593          	addi	a1,a1,1
    80004830:	fed78fa3          	sb	a3,-1(a5)
    80004834:	fee798e3          	bne	a5,a4,80004824 <__memmove+0x160>
    80004838:	f89ff06f          	j	800047c0 <__memmove+0xfc>

000000008000483c <__putc>:
    8000483c:	fe010113          	addi	sp,sp,-32
    80004840:	00813823          	sd	s0,16(sp)
    80004844:	00113c23          	sd	ra,24(sp)
    80004848:	02010413          	addi	s0,sp,32
    8000484c:	00050793          	mv	a5,a0
    80004850:	fef40593          	addi	a1,s0,-17
    80004854:	00100613          	li	a2,1
    80004858:	00000513          	li	a0,0
    8000485c:	fef407a3          	sb	a5,-17(s0)
    80004860:	fffff097          	auipc	ra,0xfffff
    80004864:	b3c080e7          	jalr	-1220(ra) # 8000339c <console_write>
    80004868:	01813083          	ld	ra,24(sp)
    8000486c:	01013403          	ld	s0,16(sp)
    80004870:	02010113          	addi	sp,sp,32
    80004874:	00008067          	ret

0000000080004878 <__getc>:
    80004878:	fe010113          	addi	sp,sp,-32
    8000487c:	00813823          	sd	s0,16(sp)
    80004880:	00113c23          	sd	ra,24(sp)
    80004884:	02010413          	addi	s0,sp,32
    80004888:	fe840593          	addi	a1,s0,-24
    8000488c:	00100613          	li	a2,1
    80004890:	00000513          	li	a0,0
    80004894:	fffff097          	auipc	ra,0xfffff
    80004898:	ae8080e7          	jalr	-1304(ra) # 8000337c <console_read>
    8000489c:	fe844503          	lbu	a0,-24(s0)
    800048a0:	01813083          	ld	ra,24(sp)
    800048a4:	01013403          	ld	s0,16(sp)
    800048a8:	02010113          	addi	sp,sp,32
    800048ac:	00008067          	ret

00000000800048b0 <console_handler>:
    800048b0:	fe010113          	addi	sp,sp,-32
    800048b4:	00813823          	sd	s0,16(sp)
    800048b8:	00113c23          	sd	ra,24(sp)
    800048bc:	00913423          	sd	s1,8(sp)
    800048c0:	02010413          	addi	s0,sp,32
    800048c4:	14202773          	csrr	a4,scause
    800048c8:	100027f3          	csrr	a5,sstatus
    800048cc:	0027f793          	andi	a5,a5,2
    800048d0:	06079e63          	bnez	a5,8000494c <console_handler+0x9c>
    800048d4:	00074c63          	bltz	a4,800048ec <console_handler+0x3c>
    800048d8:	01813083          	ld	ra,24(sp)
    800048dc:	01013403          	ld	s0,16(sp)
    800048e0:	00813483          	ld	s1,8(sp)
    800048e4:	02010113          	addi	sp,sp,32
    800048e8:	00008067          	ret
    800048ec:	0ff77713          	andi	a4,a4,255
    800048f0:	00900793          	li	a5,9
    800048f4:	fef712e3          	bne	a4,a5,800048d8 <console_handler+0x28>
    800048f8:	ffffe097          	auipc	ra,0xffffe
    800048fc:	6dc080e7          	jalr	1756(ra) # 80002fd4 <plic_claim>
    80004900:	00a00793          	li	a5,10
    80004904:	00050493          	mv	s1,a0
    80004908:	02f50c63          	beq	a0,a5,80004940 <console_handler+0x90>
    8000490c:	fc0506e3          	beqz	a0,800048d8 <console_handler+0x28>
    80004910:	00050593          	mv	a1,a0
    80004914:	00001517          	auipc	a0,0x1
    80004918:	8f450513          	addi	a0,a0,-1804 # 80005208 <_ZZ12printIntegermE6digits+0xe0>
    8000491c:	fffff097          	auipc	ra,0xfffff
    80004920:	afc080e7          	jalr	-1284(ra) # 80003418 <__printf>
    80004924:	01013403          	ld	s0,16(sp)
    80004928:	01813083          	ld	ra,24(sp)
    8000492c:	00048513          	mv	a0,s1
    80004930:	00813483          	ld	s1,8(sp)
    80004934:	02010113          	addi	sp,sp,32
    80004938:	ffffe317          	auipc	t1,0xffffe
    8000493c:	6d430067          	jr	1748(t1) # 8000300c <plic_complete>
    80004940:	fffff097          	auipc	ra,0xfffff
    80004944:	3e0080e7          	jalr	992(ra) # 80003d20 <uartintr>
    80004948:	fddff06f          	j	80004924 <console_handler+0x74>
    8000494c:	00001517          	auipc	a0,0x1
    80004950:	9bc50513          	addi	a0,a0,-1604 # 80005308 <digits+0x78>
    80004954:	fffff097          	auipc	ra,0xfffff
    80004958:	a68080e7          	jalr	-1432(ra) # 800033bc <panic>
	...
