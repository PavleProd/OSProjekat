
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	e9813103          	ld	sp,-360(sp) # 80005e98 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	139020ef          	jal	ra,80002954 <start>

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
    8000100c:	3e5000ef          	jal	ra,80001bf0 <_ZN3PCB10getContextEv>
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
    8000109c:	450000ef          	jal	ra,800014ec <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	351000ef          	jal	ra,80001bf0 <_ZN3PCB10getContextEv>

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
    800013b4:	af87b783          	ld	a5,-1288(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
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

0000000080001484 <_Z10time_sleepm>:

int time_sleep (time_t time) {
    size_t code = Kernel::sysCallCodes::time_sleep;
    if(time <= 0) return -1;
    80001484:	04050063          	beqz	a0,800014c4 <_Z10time_sleepm+0x40>
int time_sleep (time_t time) {
    80001488:	ff010113          	addi	sp,sp,-16
    8000148c:	00113423          	sd	ra,8(sp)
    80001490:	00813023          	sd	s0,0(sp)
    80001494:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001498:	00050593          	mv	a1,a0
    callInterrupt(code);
    8000149c:	03100513          	li	a0,49
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	cb0080e7          	jalr	-848(ra) # 80001150 <_Z13callInterruptm>

    thread_dispatch(); // radimo odmah dispatch da bi zaustavili tekuci proces
    800014a8:	00000097          	auipc	ra,0x0
    800014ac:	dac080e7          	jalr	-596(ra) # 80001254 <_Z15thread_dispatchv>

    return 0;
    800014b0:	00000513          	li	a0,0
}
    800014b4:	00813083          	ld	ra,8(sp)
    800014b8:	00013403          	ld	s0,0(sp)
    800014bc:	01010113          	addi	sp,sp,16
    800014c0:	00008067          	ret
    if(time <= 0) return -1;
    800014c4:	fff00513          	li	a0,-1
}
    800014c8:	00008067          	ret

00000000800014cc <_ZN6Kernel10popSppSpieEv>:
#include "../h/print.h"
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"

void Kernel::popSppSpie() {
    800014cc:	ff010113          	addi	sp,sp,-16
    800014d0:	00813423          	sd	s0,8(sp)
    800014d4:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    800014d8:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    800014dc:	10200073          	sret
}
    800014e0:	00813403          	ld	s0,8(sp)
    800014e4:	01010113          	addi	sp,sp,16
    800014e8:	00008067          	ret

00000000800014ec <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    800014ec:	fa010113          	addi	sp,sp,-96
    800014f0:	04113c23          	sd	ra,88(sp)
    800014f4:	04813823          	sd	s0,80(sp)
    800014f8:	04913423          	sd	s1,72(sp)
    800014fc:	05213023          	sd	s2,64(sp)
    80001500:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001504:	142027f3          	csrr	a5,scause
    80001508:	fcf43023          	sd	a5,-64(s0)
        return scause;
    8000150c:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001510:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001514:	141027f3          	csrr	a5,sepc
    80001518:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    8000151c:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80001520:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001524:	100027f3          	csrr	a5,sstatus
    80001528:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    8000152c:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001530:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001534:	fd843703          	ld	a4,-40(s0)
    80001538:	00900793          	li	a5,9
    8000153c:	04f70263          	beq	a4,a5,80001580 <interruptHandler+0x94>
    80001540:	fd843703          	ld	a4,-40(s0)
    80001544:	00800793          	li	a5,8
    80001548:	02f70c63          	beq	a4,a5,80001580 <interruptHandler+0x94>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    8000154c:	fd843703          	ld	a4,-40(s0)
    80001550:	fff00793          	li	a5,-1
    80001554:	03f79793          	slli	a5,a5,0x3f
    80001558:	00178793          	addi	a5,a5,1
    8000155c:	26f70063          	beq	a4,a5,800017bc <interruptHandler+0x2d0>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    80001560:	fd843703          	ld	a4,-40(s0)
    80001564:	fff00793          	li	a5,-1
    80001568:	03f79793          	slli	a5,a5,0x3f
    8000156c:	00978793          	addi	a5,a5,9
    80001570:	2af70663          	beq	a4,a5,8000181c <interruptHandler+0x330>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    80001574:	00001097          	auipc	ra,0x1
    80001578:	328080e7          	jalr	808(ra) # 8000289c <_Z10printErrorv>
    8000157c:	0840006f          	j	80001600 <interruptHandler+0x114>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001580:	fd043783          	ld	a5,-48(s0)
    80001584:	00478793          	addi	a5,a5,4
    80001588:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    8000158c:	00005797          	auipc	a5,0x5
    80001590:	91c7b783          	ld	a5,-1764(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001594:	0007b503          	ld	a0,0(a5)
    80001598:	01853703          	ld	a4,24(a0)
    8000159c:	05073783          	ld	a5,80(a4)
    800015a0:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015a4:	fa843783          	ld	a5,-88(s0)
    800015a8:	03100693          	li	a3,49
    800015ac:	20f6e263          	bltu	a3,a5,800017b0 <interruptHandler+0x2c4>
    800015b0:	00279793          	slli	a5,a5,0x2
    800015b4:	00004697          	auipc	a3,0x4
    800015b8:	a6c68693          	addi	a3,a3,-1428 # 80005020 <CONSOLE_STATUS+0x10>
    800015bc:	00d787b3          	add	a5,a5,a3
    800015c0:	0007a783          	lw	a5,0(a5)
    800015c4:	00d787b3          	add	a5,a5,a3
    800015c8:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    800015cc:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    800015d0:	00651513          	slli	a0,a0,0x6
    800015d4:	00001097          	auipc	ra,0x1
    800015d8:	e8c080e7          	jalr	-372(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
    800015dc:	00005797          	auipc	a5,0x5
    800015e0:	8cc7b783          	ld	a5,-1844(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800015e4:	0007b783          	ld	a5,0(a5)
    800015e8:	0187b783          	ld	a5,24(a5)
    800015ec:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    800015f0:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015f4:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    800015f8:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015fc:	10079073          	csrw	sstatus,a5
    }

}
    80001600:	05813083          	ld	ra,88(sp)
    80001604:	05013403          	ld	s0,80(sp)
    80001608:	04813483          	ld	s1,72(sp)
    8000160c:	04013903          	ld	s2,64(sp)
    80001610:	06010113          	addi	sp,sp,96
    80001614:	00008067          	ret
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    80001618:	05873503          	ld	a0,88(a4)
    8000161c:	00001097          	auipc	ra,0x1
    80001620:	fa8080e7          	jalr	-88(ra) # 800025c4 <_ZN15MemoryAllocator8mem_freeEPv>
    80001624:	00005797          	auipc	a5,0x5
    80001628:	8847b783          	ld	a5,-1916(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000162c:	0007b783          	ld	a5,0(a5)
    80001630:	0187b783          	ld	a5,24(a5)
    80001634:	04a7b823          	sd	a0,80(a5)
                break;
    80001638:	fb9ff06f          	j	800015f0 <interruptHandler+0x104>
                PCB::timeSliceCounter = 0;
    8000163c:	00005797          	auipc	a5,0x5
    80001640:	8547b783          	ld	a5,-1964(a5) # 80005e90 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001644:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001648:	00000097          	auipc	ra,0x0
    8000164c:	34c080e7          	jalr	844(ra) # 80001994 <_ZN3PCB8dispatchEv>
                break;
    80001650:	fa1ff06f          	j	800015f0 <interruptHandler+0x104>
                PCB::running->finished = true;
    80001654:	00100793          	li	a5,1
    80001658:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    8000165c:	00005797          	auipc	a5,0x5
    80001660:	8347b783          	ld	a5,-1996(a5) # 80005e90 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001664:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	32c080e7          	jalr	812(ra) # 80001994 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    80001670:	00005797          	auipc	a5,0x5
    80001674:	8387b783          	ld	a5,-1992(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001678:	0007b783          	ld	a5,0(a5)
    8000167c:	0187b783          	ld	a5,24(a5)
    80001680:	0407b823          	sd	zero,80(a5)
                break;
    80001684:	f6dff06f          	j	800015f0 <interruptHandler+0x104>
                PCB **handle = (PCB **) PCB::running->registers[11];
    80001688:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    8000168c:	0007b503          	ld	a0,0(a5)
    80001690:	00000097          	auipc	ra,0x0
    80001694:	584080e7          	jalr	1412(ra) # 80001c14 <_ZN9Scheduler3putEP3PCB>
                break;
    80001698:	f59ff06f          	j	800015f0 <interruptHandler+0x104>
                PCB **handle = (PCB**)PCB::running->registers[11];
    8000169c:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016a0:	06873583          	ld	a1,104(a4)
    800016a4:	06073503          	ld	a0,96(a4)
    800016a8:	00000097          	auipc	ra,0x0
    800016ac:	4c0080e7          	jalr	1216(ra) # 80001b68 <_ZN3PCB14createProccessEPFvvEPv>
    800016b0:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016b4:	00004797          	auipc	a5,0x4
    800016b8:	7f47b783          	ld	a5,2036(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800016bc:	0007b783          	ld	a5,0(a5)
    800016c0:	0187b703          	ld	a4,24(a5)
    800016c4:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    800016c8:	0004b703          	ld	a4,0(s1)
    800016cc:	f20702e3          	beqz	a4,800015f0 <interruptHandler+0x104>
                size_t* stack = (size_t*)PCB::running->registers[14];
    800016d0:	0187b783          	ld	a5,24(a5)
    800016d4:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    800016d8:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    800016dc:	00008737          	lui	a4,0x8
    800016e0:	00e787b3          	add	a5,a5,a4
    800016e4:	0004b703          	ld	a4,0(s1)
    800016e8:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    800016ec:	00f73823          	sd	a5,16(a4)
                break;
    800016f0:	f01ff06f          	j	800015f0 <interruptHandler+0x104>
                SCB **handle = (SCB**) PCB::running->registers[11];
    800016f4:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    800016f8:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    800016fc:	01800513          	li	a0,24
    80001700:	00001097          	auipc	ra,0x1
    80001704:	cac080e7          	jalr	-852(ra) # 800023ac <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    80001708:	00053023          	sd	zero,0(a0)
    8000170c:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80001710:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001714:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    80001718:	00004797          	auipc	a5,0x4
    8000171c:	7907b783          	ld	a5,1936(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001720:	0007b783          	ld	a5,0(a5)
    80001724:	0187b783          	ld	a5,24(a5)
    80001728:	0497b823          	sd	s1,80(a5)
                break;
    8000172c:	ec5ff06f          	j	800015f0 <interruptHandler+0x104>
                PCB::running->registers[10] = sem->wait(); // true kao proces treba da se blokira, false ako ne
    80001730:	05873503          	ld	a0,88(a4)
    80001734:	00001097          	auipc	ra,0x1
    80001738:	bec080e7          	jalr	-1044(ra) # 80002320 <_ZN3SCB4waitEv>
    8000173c:	00004797          	auipc	a5,0x4
    80001740:	76c7b783          	ld	a5,1900(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001744:	0007b783          	ld	a5,0(a5)
    80001748:	0187b783          	ld	a5,24(a5)
    8000174c:	04a7b823          	sd	a0,80(a5)
                break;
    80001750:	ea1ff06f          	j	800015f0 <interruptHandler+0x104>
                PCB::running->registers[10] = (size_t)sem->signal(); // vraca pokazivac na PCB ako ga treba staviti u Scheduler
    80001754:	05873503          	ld	a0,88(a4)
    80001758:	00001097          	auipc	ra,0x1
    8000175c:	c10080e7          	jalr	-1008(ra) # 80002368 <_ZN3SCB6signalEv>
    80001760:	00004797          	auipc	a5,0x4
    80001764:	7487b783          	ld	a5,1864(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001768:	0007b783          	ld	a5,0(a5)
    8000176c:	0187b783          	ld	a5,24(a5)
    80001770:	04a7b823          	sd	a0,80(a5)
                break;
    80001774:	e7dff06f          	j	800015f0 <interruptHandler+0x104>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001778:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000177c:	00048513          	mv	a0,s1
    80001780:	00001097          	auipc	ra,0x1
    80001784:	c7c080e7          	jalr	-900(ra) # 800023fc <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    80001788:	e60484e3          	beqz	s1,800015f0 <interruptHandler+0x104>
    8000178c:	00048513          	mv	a0,s1
    80001790:	00001097          	auipc	ra,0x1
    80001794:	c44080e7          	jalr	-956(ra) # 800023d4 <_ZN3SCBdlEPv>
    80001798:	e59ff06f          	j	800015f0 <interruptHandler+0x104>
                size_t time = (size_t)PCB::running->registers[11];
    8000179c:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017a0:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	084080e7          	jalr	132(ra) # 80001828 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017ac:	e45ff06f          	j	800015f0 <interruptHandler+0x104>
                printError();
    800017b0:	00001097          	auipc	ra,0x1
    800017b4:	0ec080e7          	jalr	236(ra) # 8000289c <_Z10printErrorv>
                break;
    800017b8:	e39ff06f          	j	800015f0 <interruptHandler+0x104>
        PCB::timeSliceCounter++;
    800017bc:	00004497          	auipc	s1,0x4
    800017c0:	6d44b483          	ld	s1,1748(s1) # 80005e90 <_GLOBAL_OFFSET_TABLE_+0x10>
    800017c4:	0004b783          	ld	a5,0(s1)
    800017c8:	00178793          	addi	a5,a5,1
    800017cc:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    800017d0:	00000097          	auipc	ra,0x0
    800017d4:	0cc080e7          	jalr	204(ra) # 8000189c <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800017d8:	00004797          	auipc	a5,0x4
    800017dc:	6d07b783          	ld	a5,1744(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017e0:	0007b783          	ld	a5,0(a5)
    800017e4:	0407b703          	ld	a4,64(a5)
    800017e8:	0004b783          	ld	a5,0(s1)
    800017ec:	00e7f863          	bgeu	a5,a4,800017fc <interruptHandler+0x310>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800017f0:	00200793          	li	a5,2
    800017f4:	1447b073          	csrc	sip,a5
    }
    800017f8:	e09ff06f          	j	80001600 <interruptHandler+0x114>
            PCB::timeSliceCounter = 0;
    800017fc:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001800:	00000097          	auipc	ra,0x0
    80001804:	194080e7          	jalr	404(ra) # 80001994 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    80001808:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000180c:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    80001810:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001814:	10079073          	csrw	sstatus,a5
    }
    80001818:	fd9ff06f          	j	800017f0 <interruptHandler+0x304>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    8000181c:	00003097          	auipc	ra,0x3
    80001820:	274080e7          	jalr	628(ra) # 80004a90 <console_handler>
    80001824:	dddff06f          	j	80001600 <interruptHandler+0x114>

0000000080001828 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    80001828:	ff010113          	addi	sp,sp,-16
    8000182c:	00813423          	sd	s0,8(sp)
    80001830:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    80001834:	00004797          	auipc	a5,0x4
    80001838:	6cc7b783          	ld	a5,1740(a5) # 80005f00 <_ZN17SleepingProcesses4headE>
    8000183c:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < process->getTimeSleeping()) { // ako su iste vrednosti oba ce biti izvadjena
    80001840:	00078e63          	beqz	a5,8000185c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x34>
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    80001844:	0307b683          	ld	a3,48(a5)
    80001848:	03053703          	ld	a4,48(a0)
    8000184c:	00e6f863          	bgeu	a3,a4,8000185c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x34>
        prev = curr;
    80001850:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001854:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < process->getTimeSleeping()) { // ako su iste vrednosti oba ce biti izvadjena
    80001858:	fe9ff06f          	j	80001840 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x18>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    8000185c:	00100713          	li	a4,1
    80001860:	02e504a3          	sb	a4,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    80001864:	02060463          	beqz	a2,8000188c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        nextInList = next;
    80001868:	00a63023          	sd	a0,0(a2)
    8000186c:	00f53023          	sd	a5,0(a0)
        return timeSleeping;
    80001870:	03053783          	ld	a5,48(a0)
    80001874:	03063703          	ld	a4,48(a2)
    }
    else {
        prev->setNextInList(process);
        process->setNextInList(curr);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(process->getTimeSleeping() - prev->getTimeSleeping());
    80001878:	40e787b3          	sub	a5,a5,a4
        timeSleeping = newTime;
    8000187c:	02f53823          	sd	a5,48(a0)
    }
}
    80001880:	00813403          	ld	s0,8(sp)
    80001884:	01010113          	addi	sp,sp,16
    80001888:	00008067          	ret
        head = process;
    8000188c:	00004717          	auipc	a4,0x4
    80001890:	66a73a23          	sd	a0,1652(a4) # 80005f00 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    80001894:	00f53023          	sd	a5,0(a0)
    }
    80001898:	fe9ff06f          	j	80001880 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x58>

000000008000189c <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    8000189c:	00004517          	auipc	a0,0x4
    800018a0:	66453503          	ld	a0,1636(a0) # 80005f00 <_ZN17SleepingProcesses4headE>
    800018a4:	08050063          	beqz	a0,80001924 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    800018a8:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    800018ac:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    800018b0:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    800018b4:	06050263          	beqz	a0,80001918 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    800018b8:	03053783          	ld	a5,48(a0)
    800018bc:	04079e63          	bnez	a5,80001918 <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    800018c0:	fe010113          	addi	sp,sp,-32
    800018c4:	00113c23          	sd	ra,24(sp)
    800018c8:	00813823          	sd	s0,16(sp)
    800018cc:	00913423          	sd	s1,8(sp)
    800018d0:	02010413          	addi	s0,sp,32
    800018d4:	00c0006f          	j	800018e0 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    800018d8:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800018dc:	02079063          	bnez	a5,800018fc <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800018e0:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800018e4:	00053023          	sd	zero,0(a0)
        blocked = newState;
    800018e8:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    800018ec:	00000097          	auipc	ra,0x0
    800018f0:	328080e7          	jalr	808(ra) # 80001c14 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800018f4:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800018f8:	fe0490e3          	bnez	s1,800018d8 <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800018fc:	00004797          	auipc	a5,0x4
    80001900:	60a7b223          	sd	a0,1540(a5) # 80005f00 <_ZN17SleepingProcesses4headE>
}
    80001904:	01813083          	ld	ra,24(sp)
    80001908:	01013403          	ld	s0,16(sp)
    8000190c:	00813483          	ld	s1,8(sp)
    80001910:	02010113          	addi	sp,sp,32
    80001914:	00008067          	ret
    head = curr;
    80001918:	00004797          	auipc	a5,0x4
    8000191c:	5ea7b423          	sd	a0,1512(a5) # 80005f00 <_ZN17SleepingProcesses4headE>
    80001920:	00008067          	ret
    80001924:	00008067          	ret

0000000080001928 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001928:	ff010113          	addi	sp,sp,-16
    8000192c:	00113423          	sd	ra,8(sp)
    80001930:	00813023          	sd	s0,0(sp)
    80001934:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001938:	00000097          	auipc	ra,0x0
    8000193c:	b94080e7          	jalr	-1132(ra) # 800014cc <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001940:	00004797          	auipc	a5,0x4
    80001944:	5c87b783          	ld	a5,1480(a5) # 80005f08 <_ZN3PCB7runningE>
    80001948:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    8000194c:	00070513          	mv	a0,a4
    running->main();
    80001950:	0207b783          	ld	a5,32(a5)
    80001954:	000780e7          	jalr	a5
    thread_exit();
    80001958:	00000097          	auipc	ra,0x0
    8000195c:	928080e7          	jalr	-1752(ra) # 80001280 <_Z11thread_exitv>
}
    80001960:	00813083          	ld	ra,8(sp)
    80001964:	00013403          	ld	s0,0(sp)
    80001968:	01010113          	addi	sp,sp,16
    8000196c:	00008067          	ret

0000000080001970 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001970:	ff010113          	addi	sp,sp,-16
    80001974:	00813423          	sd	s0,8(sp)
    80001978:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    8000197c:	01300793          	li	a5,19
    80001980:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001984:	00000073          	ecall
}
    80001988:	00813403          	ld	s0,8(sp)
    8000198c:	01010113          	addi	sp,sp,16
    80001990:	00008067          	ret

0000000080001994 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001994:	fe010113          	addi	sp,sp,-32
    80001998:	00113c23          	sd	ra,24(sp)
    8000199c:	00813823          	sd	s0,16(sp)
    800019a0:	00913423          	sd	s1,8(sp)
    800019a4:	02010413          	addi	s0,sp,32
    PCB* old = running;
    800019a8:	00004497          	auipc	s1,0x4
    800019ac:	5604b483          	ld	s1,1376(s1) # 80005f08 <_ZN3PCB7runningE>
    }
    800019b0:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    800019b4:	00079663          	bnez	a5,800019c0 <_ZN3PCB8dispatchEv+0x2c>
    800019b8:	0294c783          	lbu	a5,41(s1)
    800019bc:	04078263          	beqz	a5,80001a00 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    800019c0:	00000097          	auipc	ra,0x0
    800019c4:	2ac080e7          	jalr	684(ra) # 80001c6c <_ZN9Scheduler3getEv>
    800019c8:	00004797          	auipc	a5,0x4
    800019cc:	54a7b023          	sd	a0,1344(a5) # 80005f08 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    800019d0:	04054783          	lbu	a5,64(a0)
    800019d4:	02078e63          	beqz	a5,80001a10 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    800019d8:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    800019dc:	01853583          	ld	a1,24(a0)
    800019e0:	0184b503          	ld	a0,24(s1)
    800019e4:	fffff097          	auipc	ra,0xfffff
    800019e8:	744080e7          	jalr	1860(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    800019ec:	01813083          	ld	ra,24(sp)
    800019f0:	01013403          	ld	s0,16(sp)
    800019f4:	00813483          	ld	s1,8(sp)
    800019f8:	02010113          	addi	sp,sp,32
    800019fc:	00008067          	ret
        Scheduler::put(old);
    80001a00:	00048513          	mv	a0,s1
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	210080e7          	jalr	528(ra) # 80001c14 <_ZN9Scheduler3putEP3PCB>
    80001a0c:	fb5ff06f          	j	800019c0 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001a10:	01853583          	ld	a1,24(a0)
    80001a14:	0184b503          	ld	a0,24(s1)
    80001a18:	fffff097          	auipc	ra,0xfffff
    80001a1c:	724080e7          	jalr	1828(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001a20:	fcdff06f          	j	800019ec <_ZN3PCB8dispatchEv+0x58>

0000000080001a24 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001a24:	fe010113          	addi	sp,sp,-32
    80001a28:	00113c23          	sd	ra,24(sp)
    80001a2c:	00813823          	sd	s0,16(sp)
    80001a30:	00913423          	sd	s1,8(sp)
    80001a34:	02010413          	addi	s0,sp,32
    80001a38:	00050493          	mv	s1,a0
    80001a3c:	00053023          	sd	zero,0(a0)
    80001a40:	00053c23          	sd	zero,24(a0)
    80001a44:	00100793          	li	a5,1
    80001a48:	04f50023          	sb	a5,64(a0)
    finished = blocked = semDeleted = false;
    80001a4c:	02050523          	sb	zero,42(a0)
    80001a50:	020504a3          	sb	zero,41(a0)
    80001a54:	02050423          	sb	zero,40(a0)
    main = main_;
    80001a58:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001a5c:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    80001a60:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001a64:	10800513          	li	a0,264
    80001a68:	00001097          	auipc	ra,0x1
    80001a6c:	9f8080e7          	jalr	-1544(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
    80001a70:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001a74:	00008537          	lui	a0,0x8
    80001a78:	00001097          	auipc	ra,0x1
    80001a7c:	9e8080e7          	jalr	-1560(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
    80001a80:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001a84:	000087b7          	lui	a5,0x8
    80001a88:	00f50533          	add	a0,a0,a5
    80001a8c:	0184b783          	ld	a5,24(s1)
    80001a90:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001a94:	0184b783          	ld	a5,24(s1)
    80001a98:	00000717          	auipc	a4,0x0
    80001a9c:	e9070713          	addi	a4,a4,-368 # 80001928 <_ZN3PCB15proccessWrapperEv>
    80001aa0:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001aa4:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001aa8:	0204b783          	ld	a5,32(s1)
    80001aac:	00078c63          	beqz	a5,80001ac4 <_ZN3PCBC1EPFvvEmPv+0xa0>
}
    80001ab0:	01813083          	ld	ra,24(sp)
    80001ab4:	01013403          	ld	s0,16(sp)
    80001ab8:	00813483          	ld	s1,8(sp)
    80001abc:	02010113          	addi	sp,sp,32
    80001ac0:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001ac4:	04048023          	sb	zero,64(s1)
}
    80001ac8:	fe9ff06f          	j	80001ab0 <_ZN3PCBC1EPFvvEmPv+0x8c>

0000000080001acc <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001acc:	fe010113          	addi	sp,sp,-32
    80001ad0:	00113c23          	sd	ra,24(sp)
    80001ad4:	00813823          	sd	s0,16(sp)
    80001ad8:	00913423          	sd	s1,8(sp)
    80001adc:	02010413          	addi	s0,sp,32
    80001ae0:	00050493          	mv	s1,a0
    delete[] stack;
    80001ae4:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001ae8:	00050663          	beqz	a0,80001af4 <_ZN3PCBD1Ev+0x28>
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	48c080e7          	jalr	1164(ra) # 80001f78 <_ZdaPv>
    delete[] sysStack;
    80001af4:	0104b503          	ld	a0,16(s1)
    80001af8:	00050663          	beqz	a0,80001b04 <_ZN3PCBD1Ev+0x38>
    80001afc:	00000097          	auipc	ra,0x0
    80001b00:	47c080e7          	jalr	1148(ra) # 80001f78 <_ZdaPv>
}
    80001b04:	01813083          	ld	ra,24(sp)
    80001b08:	01013403          	ld	s0,16(sp)
    80001b0c:	00813483          	ld	s1,8(sp)
    80001b10:	02010113          	addi	sp,sp,32
    80001b14:	00008067          	ret

0000000080001b18 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001b18:	ff010113          	addi	sp,sp,-16
    80001b1c:	00113423          	sd	ra,8(sp)
    80001b20:	00813023          	sd	s0,0(sp)
    80001b24:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001b28:	00001097          	auipc	ra,0x1
    80001b2c:	938080e7          	jalr	-1736(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001b30:	00813083          	ld	ra,8(sp)
    80001b34:	00013403          	ld	s0,0(sp)
    80001b38:	01010113          	addi	sp,sp,16
    80001b3c:	00008067          	ret

0000000080001b40 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001b40:	ff010113          	addi	sp,sp,-16
    80001b44:	00113423          	sd	ra,8(sp)
    80001b48:	00813023          	sd	s0,0(sp)
    80001b4c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001b50:	00001097          	auipc	ra,0x1
    80001b54:	a74080e7          	jalr	-1420(ra) # 800025c4 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001b58:	00813083          	ld	ra,8(sp)
    80001b5c:	00013403          	ld	s0,0(sp)
    80001b60:	01010113          	addi	sp,sp,16
    80001b64:	00008067          	ret

0000000080001b68 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001b68:	fd010113          	addi	sp,sp,-48
    80001b6c:	02113423          	sd	ra,40(sp)
    80001b70:	02813023          	sd	s0,32(sp)
    80001b74:	00913c23          	sd	s1,24(sp)
    80001b78:	01213823          	sd	s2,16(sp)
    80001b7c:	01313423          	sd	s3,8(sp)
    80001b80:	03010413          	addi	s0,sp,48
    80001b84:	00050913          	mv	s2,a0
    80001b88:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001b8c:	04800513          	li	a0,72
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	f88080e7          	jalr	-120(ra) # 80001b18 <_ZN3PCBnwEm>
    80001b98:	00050493          	mv	s1,a0
    80001b9c:	00098693          	mv	a3,s3
    80001ba0:	00200613          	li	a2,2
    80001ba4:	00090593          	mv	a1,s2
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	e7c080e7          	jalr	-388(ra) # 80001a24 <_ZN3PCBC1EPFvvEmPv>
    80001bb0:	0200006f          	j	80001bd0 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001bb4:	00050913          	mv	s2,a0
    80001bb8:	00048513          	mv	a0,s1
    80001bbc:	00000097          	auipc	ra,0x0
    80001bc0:	f84080e7          	jalr	-124(ra) # 80001b40 <_ZN3PCBdlEPv>
    80001bc4:	00090513          	mv	a0,s2
    80001bc8:	00005097          	auipc	ra,0x5
    80001bcc:	440080e7          	jalr	1088(ra) # 80007008 <_Unwind_Resume>
}
    80001bd0:	00048513          	mv	a0,s1
    80001bd4:	02813083          	ld	ra,40(sp)
    80001bd8:	02013403          	ld	s0,32(sp)
    80001bdc:	01813483          	ld	s1,24(sp)
    80001be0:	01013903          	ld	s2,16(sp)
    80001be4:	00813983          	ld	s3,8(sp)
    80001be8:	03010113          	addi	sp,sp,48
    80001bec:	00008067          	ret

0000000080001bf0 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001bf0:	ff010113          	addi	sp,sp,-16
    80001bf4:	00813423          	sd	s0,8(sp)
    80001bf8:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001bfc:	00004797          	auipc	a5,0x4
    80001c00:	30c7b783          	ld	a5,780(a5) # 80005f08 <_ZN3PCB7runningE>
    80001c04:	0187b503          	ld	a0,24(a5)
    80001c08:	00813403          	ld	s0,8(sp)
    80001c0c:	01010113          	addi	sp,sp,16
    80001c10:	00008067          	ret

0000000080001c14 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001c14:	ff010113          	addi	sp,sp,-16
    80001c18:	00813423          	sd	s0,8(sp)
    80001c1c:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001c20:	02050663          	beqz	a0,80001c4c <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001c24:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001c28:	00004797          	auipc	a5,0x4
    80001c2c:	2f07b783          	ld	a5,752(a5) # 80005f18 <_ZN9Scheduler4tailE>
    80001c30:	02078463          	beqz	a5,80001c58 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001c34:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001c38:	00004797          	auipc	a5,0x4
    80001c3c:	2e078793          	addi	a5,a5,736 # 80005f18 <_ZN9Scheduler4tailE>
    80001c40:	0007b703          	ld	a4,0(a5)
    80001c44:	00073703          	ld	a4,0(a4)
    80001c48:	00e7b023          	sd	a4,0(a5)
    }
}
    80001c4c:	00813403          	ld	s0,8(sp)
    80001c50:	01010113          	addi	sp,sp,16
    80001c54:	00008067          	ret
        head = tail = process;
    80001c58:	00004797          	auipc	a5,0x4
    80001c5c:	2c078793          	addi	a5,a5,704 # 80005f18 <_ZN9Scheduler4tailE>
    80001c60:	00a7b023          	sd	a0,0(a5)
    80001c64:	00a7b423          	sd	a0,8(a5)
    80001c68:	fe5ff06f          	j	80001c4c <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001c6c <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001c6c:	ff010113          	addi	sp,sp,-16
    80001c70:	00813423          	sd	s0,8(sp)
    80001c74:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001c78:	00004517          	auipc	a0,0x4
    80001c7c:	2a853503          	ld	a0,680(a0) # 80005f20 <_ZN9Scheduler4headE>
    80001c80:	02050463          	beqz	a0,80001ca8 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001c84:	00053703          	ld	a4,0(a0)
    80001c88:	00004797          	auipc	a5,0x4
    80001c8c:	29078793          	addi	a5,a5,656 # 80005f18 <_ZN9Scheduler4tailE>
    80001c90:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001c94:	0007b783          	ld	a5,0(a5)
    80001c98:	00f50e63          	beq	a0,a5,80001cb4 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001c9c:	00813403          	ld	s0,8(sp)
    80001ca0:	01010113          	addi	sp,sp,16
    80001ca4:	00008067          	ret
        return idleProcess;
    80001ca8:	00004517          	auipc	a0,0x4
    80001cac:	28053503          	ld	a0,640(a0) # 80005f28 <_ZN9Scheduler11idleProcessE>
    80001cb0:	fedff06f          	j	80001c9c <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001cb4:	00004797          	auipc	a5,0x4
    80001cb8:	26e7b223          	sd	a4,612(a5) # 80005f18 <_ZN9Scheduler4tailE>
    80001cbc:	fe1ff06f          	j	80001c9c <_ZN9Scheduler3getEv+0x30>

0000000080001cc0 <_Z11idleProcessv>:
    finished[sleep_time/10-1] = true;
}


// Kernel inicijalizaccija
void idleProcess() {
    80001cc0:	ff010113          	addi	sp,sp,-16
    80001cc4:	00813423          	sd	s0,8(sp)
    80001cc8:	01010413          	addi	s0,sp,16
    while(true) {}
    80001ccc:	0000006f          	j	80001ccc <_Z11idleProcessv+0xc>

0000000080001cd0 <_Z9sleepyRunPv>:
void sleepyRun(void *arg) {
    80001cd0:	fe010113          	addi	sp,sp,-32
    80001cd4:	00113c23          	sd	ra,24(sp)
    80001cd8:	00813823          	sd	s0,16(sp)
    80001cdc:	00913423          	sd	s1,8(sp)
    80001ce0:	01213023          	sd	s2,0(sp)
    80001ce4:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80001ce8:	00053903          	ld	s2,0(a0)
    int i = 6;
    80001cec:	00600493          	li	s1,6
    while (--i > 0) {
    80001cf0:	fff4849b          	addiw	s1,s1,-1
    80001cf4:	04905063          	blez	s1,80001d34 <_Z9sleepyRunPv+0x64>
        printString("Hello ");
    80001cf8:	00003517          	auipc	a0,0x3
    80001cfc:	3f050513          	addi	a0,a0,1008 # 800050e8 <CONSOLE_STATUS+0xd8>
    80001d00:	00001097          	auipc	ra,0x1
    80001d04:	a70080e7          	jalr	-1424(ra) # 80002770 <_Z11printStringPKc>
        printInteger(sleep_time);
    80001d08:	00090513          	mv	a0,s2
    80001d0c:	00001097          	auipc	ra,0x1
    80001d10:	ad4080e7          	jalr	-1324(ra) # 800027e0 <_Z12printIntegerm>
        printString(" !\n");
    80001d14:	00003517          	auipc	a0,0x3
    80001d18:	3dc50513          	addi	a0,a0,988 # 800050f0 <CONSOLE_STATUS+0xe0>
    80001d1c:	00001097          	auipc	ra,0x1
    80001d20:	a54080e7          	jalr	-1452(ra) # 80002770 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80001d24:	00090513          	mv	a0,s2
    80001d28:	fffff097          	auipc	ra,0xfffff
    80001d2c:	75c080e7          	jalr	1884(ra) # 80001484 <_Z10time_sleepm>
    while (--i > 0) {
    80001d30:	fc1ff06f          	j	80001cf0 <_Z9sleepyRunPv+0x20>
    finished[sleep_time/10-1] = true;
    80001d34:	00a00793          	li	a5,10
    80001d38:	02f95933          	divu	s2,s2,a5
    80001d3c:	fff90913          	addi	s2,s2,-1
    80001d40:	00004797          	auipc	a5,0x4
    80001d44:	1f078793          	addi	a5,a5,496 # 80005f30 <finished>
    80001d48:	01278933          	add	s2,a5,s2
    80001d4c:	00100793          	li	a5,1
    80001d50:	00f90023          	sb	a5,0(s2)
}
    80001d54:	01813083          	ld	ra,24(sp)
    80001d58:	01013403          	ld	s0,16(sp)
    80001d5c:	00813483          	ld	s1,8(sp)
    80001d60:	00013903          	ld	s2,0(sp)
    80001d64:	02010113          	addi	sp,sp,32
    80001d68:	00008067          	ret

0000000080001d6c <main>:
}
extern "C" void interrupt();
// ------------
int main() {
    80001d6c:	fc010113          	addi	sp,sp,-64
    80001d70:	02113c23          	sd	ra,56(sp)
    80001d74:	02813823          	sd	s0,48(sp)
    80001d78:	02913423          	sd	s1,40(sp)
    80001d7c:	04010413          	addi	s0,sp,64
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001d80:	00004797          	auipc	a5,0x4
    80001d84:	1387b783          	ld	a5,312(a5) # 80005eb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001d88:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001d8c:	00000593          	li	a1,0
    80001d90:	00000513          	li	a0,0
    80001d94:	00000097          	auipc	ra,0x0
    80001d98:	dd4080e7          	jalr	-556(ra) # 80001b68 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001d9c:	00004797          	auipc	a5,0x4
    80001da0:	10c7b783          	ld	a5,268(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001da4:	00a7b023          	sd	a0,0(a5)
    Scheduler::idleProcess = PCB::createProccess(idleProcess, nullptr);
    80001da8:	00000593          	li	a1,0
    80001dac:	00000517          	auipc	a0,0x0
    80001db0:	f1450513          	addi	a0,a0,-236 # 80001cc0 <_Z11idleProcessv>
    80001db4:	00000097          	auipc	ra,0x0
    80001db8:	db4080e7          	jalr	-588(ra) # 80001b68 <_ZN3PCB14createProccessEPFvvEPv>
    80001dbc:	00004797          	auipc	a5,0x4
    80001dc0:	0e47b783          	ld	a5,228(a5) # 80005ea0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001dc4:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001dc8:	00200793          	li	a5,2
    80001dcc:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
    // ----

    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80001dd0:	00a00793          	li	a5,10
    80001dd4:	fcf43823          	sd	a5,-48(s0)
    80001dd8:	01400793          	li	a5,20
    80001ddc:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80001de0:	00000493          	li	s1,0
    80001de4:	02c0006f          	j	80001e10 <main+0xa4>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80001de8:	00349793          	slli	a5,s1,0x3
    80001dec:	fd040613          	addi	a2,s0,-48
    80001df0:	00f60633          	add	a2,a2,a5
    80001df4:	00000597          	auipc	a1,0x0
    80001df8:	edc58593          	addi	a1,a1,-292 # 80001cd0 <_Z9sleepyRunPv>
    80001dfc:	fc040513          	addi	a0,s0,-64
    80001e00:	00f50533          	add	a0,a0,a5
    80001e04:	fffff097          	auipc	ra,0xfffff
    80001e08:	4dc080e7          	jalr	1244(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80001e0c:	0014849b          	addiw	s1,s1,1
    80001e10:	00100793          	li	a5,1
    80001e14:	fc97dae3          	bge	a5,s1,80001de8 <main+0x7c>
    }

    while (!(finished[0] && finished[1])) {}
    80001e18:	00004797          	auipc	a5,0x4
    80001e1c:	1187c783          	lbu	a5,280(a5) # 80005f30 <finished>
    80001e20:	fe078ce3          	beqz	a5,80001e18 <main+0xac>
    80001e24:	00004797          	auipc	a5,0x4
    80001e28:	10d7c783          	lbu	a5,269(a5) # 80005f31 <finished+0x1>
    80001e2c:	fe0786e3          	beqz	a5,80001e18 <main+0xac>

    return 0;
    80001e30:	00000513          	li	a0,0
    80001e34:	03813083          	ld	ra,56(sp)
    80001e38:	03013403          	ld	s0,48(sp)
    80001e3c:	02813483          	ld	s1,40(sp)
    80001e40:	04010113          	addi	sp,sp,64
    80001e44:	00008067          	ret

0000000080001e48 <_Z13threadWrapperPv>:
void threadWrapper(void* thread);
Thread::Thread() {
    thread_create_only(&myHandle, threadWrapper, this);
}

void threadWrapper(void* thread) {
    80001e48:	ff010113          	addi	sp,sp,-16
    80001e4c:	00113423          	sd	ra,8(sp)
    80001e50:	00813023          	sd	s0,0(sp)
    80001e54:	01010413          	addi	s0,sp,16
    ((Thread*)thread)->run();
    80001e58:	00053783          	ld	a5,0(a0)
    80001e5c:	0107b783          	ld	a5,16(a5)
    80001e60:	000780e7          	jalr	a5
}
    80001e64:	00813083          	ld	ra,8(sp)
    80001e68:	00013403          	ld	s0,0(sp)
    80001e6c:	01010113          	addi	sp,sp,16
    80001e70:	00008067          	ret

0000000080001e74 <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    80001e74:	fe010113          	addi	sp,sp,-32
    80001e78:	00113c23          	sd	ra,24(sp)
    80001e7c:	00813823          	sd	s0,16(sp)
    80001e80:	00913423          	sd	s1,8(sp)
    80001e84:	02010413          	addi	s0,sp,32
    80001e88:	00004797          	auipc	a5,0x4
    80001e8c:	fc078793          	addi	a5,a5,-64 # 80005e48 <_ZTV6Thread+0x10>
    80001e90:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80001e94:	00853483          	ld	s1,8(a0)
    80001e98:	00048e63          	beqz	s1,80001eb4 <_ZN6ThreadD1Ev+0x40>
    80001e9c:	00048513          	mv	a0,s1
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	c2c080e7          	jalr	-980(ra) # 80001acc <_ZN3PCBD1Ev>
    80001ea8:	00048513          	mv	a0,s1
    80001eac:	00000097          	auipc	ra,0x0
    80001eb0:	c94080e7          	jalr	-876(ra) # 80001b40 <_ZN3PCBdlEPv>
}
    80001eb4:	01813083          	ld	ra,24(sp)
    80001eb8:	01013403          	ld	s0,16(sp)
    80001ebc:	00813483          	ld	s1,8(sp)
    80001ec0:	02010113          	addi	sp,sp,32
    80001ec4:	00008067          	ret

0000000080001ec8 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80001ec8:	ff010113          	addi	sp,sp,-16
    80001ecc:	00113423          	sd	ra,8(sp)
    80001ed0:	00813023          	sd	s0,0(sp)
    80001ed4:	01010413          	addi	s0,sp,16
    80001ed8:	00004797          	auipc	a5,0x4
    80001edc:	f9878793          	addi	a5,a5,-104 # 80005e70 <_ZTV9Semaphore+0x10>
    80001ee0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80001ee4:	00853503          	ld	a0,8(a0)
    80001ee8:	fffff097          	auipc	ra,0xfffff
    80001eec:	55c080e7          	jalr	1372(ra) # 80001444 <_Z9sem_closeP3SCB>
}
    80001ef0:	00813083          	ld	ra,8(sp)
    80001ef4:	00013403          	ld	s0,0(sp)
    80001ef8:	01010113          	addi	sp,sp,16
    80001efc:	00008067          	ret

0000000080001f00 <_Znwm>:
void* operator new (size_t size) {
    80001f00:	ff010113          	addi	sp,sp,-16
    80001f04:	00113423          	sd	ra,8(sp)
    80001f08:	00813023          	sd	s0,0(sp)
    80001f0c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001f10:	fffff097          	auipc	ra,0xfffff
    80001f14:	264080e7          	jalr	612(ra) # 80001174 <_Z9mem_allocm>
}
    80001f18:	00813083          	ld	ra,8(sp)
    80001f1c:	00013403          	ld	s0,0(sp)
    80001f20:	01010113          	addi	sp,sp,16
    80001f24:	00008067          	ret

0000000080001f28 <_Znam>:
void* operator new [](size_t size) {
    80001f28:	ff010113          	addi	sp,sp,-16
    80001f2c:	00113423          	sd	ra,8(sp)
    80001f30:	00813023          	sd	s0,0(sp)
    80001f34:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	23c080e7          	jalr	572(ra) # 80001174 <_Z9mem_allocm>
}
    80001f40:	00813083          	ld	ra,8(sp)
    80001f44:	00013403          	ld	s0,0(sp)
    80001f48:	01010113          	addi	sp,sp,16
    80001f4c:	00008067          	ret

0000000080001f50 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001f50:	ff010113          	addi	sp,sp,-16
    80001f54:	00113423          	sd	ra,8(sp)
    80001f58:	00813023          	sd	s0,0(sp)
    80001f5c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001f60:	fffff097          	auipc	ra,0xfffff
    80001f64:	254080e7          	jalr	596(ra) # 800011b4 <_Z8mem_freePv>
}
    80001f68:	00813083          	ld	ra,8(sp)
    80001f6c:	00013403          	ld	s0,0(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret

0000000080001f78 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001f78:	ff010113          	addi	sp,sp,-16
    80001f7c:	00113423          	sd	ra,8(sp)
    80001f80:	00813023          	sd	s0,0(sp)
    80001f84:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	22c080e7          	jalr	556(ra) # 800011b4 <_Z8mem_freePv>
}
    80001f90:	00813083          	ld	ra,8(sp)
    80001f94:	00013403          	ld	s0,0(sp)
    80001f98:	01010113          	addi	sp,sp,16
    80001f9c:	00008067          	ret

0000000080001fa0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001fa0:	ff010113          	addi	sp,sp,-16
    80001fa4:	00113423          	sd	ra,8(sp)
    80001fa8:	00813023          	sd	s0,0(sp)
    80001fac:	01010413          	addi	s0,sp,16
    80001fb0:	00004797          	auipc	a5,0x4
    80001fb4:	e9878793          	addi	a5,a5,-360 # 80005e48 <_ZTV6Thread+0x10>
    80001fb8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80001fbc:	00850513          	addi	a0,a0,8
    80001fc0:	fffff097          	auipc	ra,0xfffff
    80001fc4:	228080e7          	jalr	552(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    80001fc8:	00813083          	ld	ra,8(sp)
    80001fcc:	00013403          	ld	s0,0(sp)
    80001fd0:	01010113          	addi	sp,sp,16
    80001fd4:	00008067          	ret

0000000080001fd8 <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00113423          	sd	ra,8(sp)
    80001fe0:	00813023          	sd	s0,0(sp)
    80001fe4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001fe8:	00000097          	auipc	ra,0x0
    80001fec:	478080e7          	jalr	1144(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001ff0:	00813083          	ld	ra,8(sp)
    80001ff4:	00013403          	ld	s0,0(sp)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002010:	00000097          	auipc	ra,0x0
    80002014:	5b4080e7          	jalr	1460(ra) # 800025c4 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002018:	00813083          	ld	ra,8(sp)
    8000201c:	00013403          	ld	s0,0(sp)
    80002020:	01010113          	addi	sp,sp,16
    80002024:	00008067          	ret

0000000080002028 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002028:	fe010113          	addi	sp,sp,-32
    8000202c:	00113c23          	sd	ra,24(sp)
    80002030:	00813823          	sd	s0,16(sp)
    80002034:	00913423          	sd	s1,8(sp)
    80002038:	02010413          	addi	s0,sp,32
    8000203c:	00050493          	mv	s1,a0
}
    80002040:	00000097          	auipc	ra,0x0
    80002044:	e34080e7          	jalr	-460(ra) # 80001e74 <_ZN6ThreadD1Ev>
    80002048:	00048513          	mv	a0,s1
    8000204c:	00000097          	auipc	ra,0x0
    80002050:	fb4080e7          	jalr	-76(ra) # 80002000 <_ZN6ThreaddlEPv>
    80002054:	01813083          	ld	ra,24(sp)
    80002058:	01013403          	ld	s0,16(sp)
    8000205c:	00813483          	ld	s1,8(sp)
    80002060:	02010113          	addi	sp,sp,32
    80002064:	00008067          	ret

0000000080002068 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002068:	ff010113          	addi	sp,sp,-16
    8000206c:	00113423          	sd	ra,8(sp)
    80002070:	00813023          	sd	s0,0(sp)
    80002074:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002078:	fffff097          	auipc	ra,0xfffff
    8000207c:	1dc080e7          	jalr	476(ra) # 80001254 <_Z15thread_dispatchv>
}
    80002080:	00813083          	ld	ra,8(sp)
    80002084:	00013403          	ld	s0,0(sp)
    80002088:	01010113          	addi	sp,sp,16
    8000208c:	00008067          	ret

0000000080002090 <_ZN6Thread5startEv>:
int Thread::start() {
    80002090:	ff010113          	addi	sp,sp,-16
    80002094:	00113423          	sd	ra,8(sp)
    80002098:	00813023          	sd	s0,0(sp)
    8000209c:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    800020a0:	00850513          	addi	a0,a0,8
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	20c080e7          	jalr	524(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    800020ac:	00000513          	li	a0,0
    800020b0:	00813083          	ld	ra,8(sp)
    800020b4:	00013403          	ld	s0,0(sp)
    800020b8:	01010113          	addi	sp,sp,16
    800020bc:	00008067          	ret

00000000800020c0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800020c0:	ff010113          	addi	sp,sp,-16
    800020c4:	00113423          	sd	ra,8(sp)
    800020c8:	00813023          	sd	s0,0(sp)
    800020cc:	01010413          	addi	s0,sp,16
    800020d0:	00004797          	auipc	a5,0x4
    800020d4:	d7878793          	addi	a5,a5,-648 # 80005e48 <_ZTV6Thread+0x10>
    800020d8:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, threadWrapper, this);
    800020dc:	00050613          	mv	a2,a0
    800020e0:	00000597          	auipc	a1,0x0
    800020e4:	d6858593          	addi	a1,a1,-664 # 80001e48 <_Z13threadWrapperPv>
    800020e8:	00850513          	addi	a0,a0,8
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	0fc080e7          	jalr	252(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800020f4:	00813083          	ld	ra,8(sp)
    800020f8:	00013403          	ld	s0,0(sp)
    800020fc:	01010113          	addi	sp,sp,16
    80002100:	00008067          	ret

0000000080002104 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002104:	fe010113          	addi	sp,sp,-32
    80002108:	00113c23          	sd	ra,24(sp)
    8000210c:	00813823          	sd	s0,16(sp)
    80002110:	00913423          	sd	s1,8(sp)
    80002114:	01213023          	sd	s2,0(sp)
    80002118:	02010413          	addi	s0,sp,32
    8000211c:	00050493          	mv	s1,a0
    80002120:	00004797          	auipc	a5,0x4
    80002124:	d5078793          	addi	a5,a5,-688 # 80005e70 <_ZTV9Semaphore+0x10>
    80002128:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    8000212c:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002130:	01800513          	li	a0,24
    80002134:	00000097          	auipc	ra,0x0
    80002138:	278080e7          	jalr	632(ra) # 800023ac <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    8000213c:	00053023          	sd	zero,0(a0)
    80002140:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80002144:	01252823          	sw	s2,16(a0)
    80002148:	00a4b423          	sd	a0,8(s1)
}
    8000214c:	01813083          	ld	ra,24(sp)
    80002150:	01013403          	ld	s0,16(sp)
    80002154:	00813483          	ld	s1,8(sp)
    80002158:	00013903          	ld	s2,0(sp)
    8000215c:	02010113          	addi	sp,sp,32
    80002160:	00008067          	ret

0000000080002164 <_ZN9Semaphore4waitEv>:

int Semaphore::wait() {
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00113423          	sd	ra,8(sp)
    8000216c:	00813023          	sd	s0,0(sp)
    80002170:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002174:	00853503          	ld	a0,8(a0)
    80002178:	fffff097          	auipc	ra,0xfffff
    8000217c:	200080e7          	jalr	512(ra) # 80001378 <_Z8sem_waitP3SCB>
}
    80002180:	00813083          	ld	ra,8(sp)
    80002184:	00013403          	ld	s0,0(sp)
    80002188:	01010113          	addi	sp,sp,16
    8000218c:	00008067          	ret

0000000080002190 <_ZN9Semaphore6signalEv>:

int Semaphore::signal() {
    80002190:	ff010113          	addi	sp,sp,-16
    80002194:	00113423          	sd	ra,8(sp)
    80002198:	00813023          	sd	s0,0(sp)
    8000219c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800021a0:	00853503          	ld	a0,8(a0)
    800021a4:	fffff097          	auipc	ra,0xfffff
    800021a8:	244080e7          	jalr	580(ra) # 800013e8 <_Z10sem_signalP3SCB>
}
    800021ac:	00813083          	ld	ra,8(sp)
    800021b0:	00013403          	ld	s0,0(sp)
    800021b4:	01010113          	addi	sp,sp,16
    800021b8:	00008067          	ret

00000000800021bc <_ZN9SemaphoredlEPv>:

void Semaphore::operator delete(void *memSegment) {
    800021bc:	ff010113          	addi	sp,sp,-16
    800021c0:	00113423          	sd	ra,8(sp)
    800021c4:	00813023          	sd	s0,0(sp)
    800021c8:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800021cc:	00000097          	auipc	ra,0x0
    800021d0:	3f8080e7          	jalr	1016(ra) # 800025c4 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800021d4:	00813083          	ld	ra,8(sp)
    800021d8:	00013403          	ld	s0,0(sp)
    800021dc:	01010113          	addi	sp,sp,16
    800021e0:	00008067          	ret

00000000800021e4 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    800021e4:	fe010113          	addi	sp,sp,-32
    800021e8:	00113c23          	sd	ra,24(sp)
    800021ec:	00813823          	sd	s0,16(sp)
    800021f0:	00913423          	sd	s1,8(sp)
    800021f4:	02010413          	addi	s0,sp,32
    800021f8:	00050493          	mv	s1,a0
}
    800021fc:	00000097          	auipc	ra,0x0
    80002200:	ccc080e7          	jalr	-820(ra) # 80001ec8 <_ZN9SemaphoreD1Ev>
    80002204:	00048513          	mv	a0,s1
    80002208:	00000097          	auipc	ra,0x0
    8000220c:	fb4080e7          	jalr	-76(ra) # 800021bc <_ZN9SemaphoredlEPv>
    80002210:	01813083          	ld	ra,24(sp)
    80002214:	01013403          	ld	s0,16(sp)
    80002218:	00813483          	ld	s1,8(sp)
    8000221c:	02010113          	addi	sp,sp,32
    80002220:	00008067          	ret

0000000080002224 <_ZN9SemaphorenwEm>:

void *Semaphore::operator new(size_t size) {
    80002224:	ff010113          	addi	sp,sp,-16
    80002228:	00113423          	sd	ra,8(sp)
    8000222c:	00813023          	sd	s0,0(sp)
    80002230:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002234:	00000097          	auipc	ra,0x0
    80002238:	22c080e7          	jalr	556(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
}
    8000223c:	00813083          	ld	ra,8(sp)
    80002240:	00013403          	ld	s0,0(sp)
    80002244:	01010113          	addi	sp,sp,16
    80002248:	00008067          	ret

000000008000224c <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    8000224c:	ff010113          	addi	sp,sp,-16
    80002250:	00813423          	sd	s0,8(sp)
    80002254:	01010413          	addi	s0,sp,16
    80002258:	00813403          	ld	s0,8(sp)
    8000225c:	01010113          	addi	sp,sp,16
    80002260:	00008067          	ret

0000000080002264 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002264:	ff010113          	addi	sp,sp,-16
    80002268:	00813423          	sd	s0,8(sp)
    8000226c:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    80002270:	00004797          	auipc	a5,0x4
    80002274:	c387b783          	ld	a5,-968(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002278:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    8000227c:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80002280:	00853783          	ld	a5,8(a0)
    80002284:	04078063          	beqz	a5,800022c4 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002288:	00004717          	auipc	a4,0x4
    8000228c:	c2073703          	ld	a4,-992(a4) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002290:	00073703          	ld	a4,0(a4)
    80002294:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002298:	00853783          	ld	a5,8(a0)
        return nextInList;
    8000229c:	0007b783          	ld	a5,0(a5)
    800022a0:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    800022a4:	00004797          	auipc	a5,0x4
    800022a8:	c047b783          	ld	a5,-1020(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022ac:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    800022b0:	00100713          	li	a4,1
    800022b4:	02e784a3          	sb	a4,41(a5)
}
    800022b8:	00813403          	ld	s0,8(sp)
    800022bc:	01010113          	addi	sp,sp,16
    800022c0:	00008067          	ret
        head = tail = PCB::running;
    800022c4:	00004797          	auipc	a5,0x4
    800022c8:	be47b783          	ld	a5,-1052(a5) # 80005ea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022cc:	0007b783          	ld	a5,0(a5)
    800022d0:	00f53423          	sd	a5,8(a0)
    800022d4:	00f53023          	sd	a5,0(a0)
    800022d8:	fcdff06f          	j	800022a4 <_ZN3SCB5blockEv+0x40>

00000000800022dc <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800022dc:	ff010113          	addi	sp,sp,-16
    800022e0:	00813423          	sd	s0,8(sp)
    800022e4:	01010413          	addi	s0,sp,16
    800022e8:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800022ec:	00053503          	ld	a0,0(a0)
    800022f0:	00050e63          	beqz	a0,8000230c <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800022f4:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800022f8:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800022fc:	0087b683          	ld	a3,8(a5)
    80002300:	00d50c63          	beq	a0,a3,80002318 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    80002304:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    80002308:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    8000230c:	00813403          	ld	s0,8(sp)
    80002310:	01010113          	addi	sp,sp,16
    80002314:	00008067          	ret
        tail = head;
    80002318:	00e7b423          	sd	a4,8(a5)
    8000231c:	fe9ff06f          	j	80002304 <_ZN3SCB7unblockEv+0x28>

0000000080002320 <_ZN3SCB4waitEv>:

bool SCB::wait() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(--semValue)<0) {
    80002320:	01052783          	lw	a5,16(a0)
    80002324:	fff7879b          	addiw	a5,a5,-1
    80002328:	00f52823          	sw	a5,16(a0)
    8000232c:	02079713          	slli	a4,a5,0x20
    80002330:	00074663          	bltz	a4,8000233c <_ZN3SCB4waitEv+0x1c>
        block();
        return true;
    }
    return false;
    80002334:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    80002338:	00008067          	ret
bool SCB::wait() {
    8000233c:	ff010113          	addi	sp,sp,-16
    80002340:	00113423          	sd	ra,8(sp)
    80002344:	00813023          	sd	s0,0(sp)
    80002348:	01010413          	addi	s0,sp,16
        block();
    8000234c:	00000097          	auipc	ra,0x0
    80002350:	f18080e7          	jalr	-232(ra) # 80002264 <_ZN3SCB5blockEv>
        return true;
    80002354:	00100513          	li	a0,1
}
    80002358:	00813083          	ld	ra,8(sp)
    8000235c:	00013403          	ld	s0,0(sp)
    80002360:	01010113          	addi	sp,sp,16
    80002364:	00008067          	ret

0000000080002368 <_ZN3SCB6signalEv>:

PCB* SCB::signal() {
    //Kernel::mc_sstatus(Kernel::SSTATUS_SIE); // zabranjuju se prekidi
    if((int)(++semValue)<=0) {
    80002368:	01052783          	lw	a5,16(a0)
    8000236c:	0017879b          	addiw	a5,a5,1
    80002370:	0007871b          	sext.w	a4,a5
    80002374:	00f52823          	sw	a5,16(a0)
    80002378:	00e05663          	blez	a4,80002384 <_ZN3SCB6signalEv+0x1c>
        return unblock();
    }
    return nullptr;
    8000237c:	00000513          	li	a0,0
    //Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi
}
    80002380:	00008067          	ret
PCB* SCB::signal() {
    80002384:	ff010113          	addi	sp,sp,-16
    80002388:	00113423          	sd	ra,8(sp)
    8000238c:	00813023          	sd	s0,0(sp)
    80002390:	01010413          	addi	s0,sp,16
        return unblock();
    80002394:	00000097          	auipc	ra,0x0
    80002398:	f48080e7          	jalr	-184(ra) # 800022dc <_ZN3SCB7unblockEv>
}
    8000239c:	00813083          	ld	ra,8(sp)
    800023a0:	00013403          	ld	s0,0(sp)
    800023a4:	01010113          	addi	sp,sp,16
    800023a8:	00008067          	ret

00000000800023ac <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    800023ac:	ff010113          	addi	sp,sp,-16
    800023b0:	00113423          	sd	ra,8(sp)
    800023b4:	00813023          	sd	s0,0(sp)
    800023b8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800023bc:	00000097          	auipc	ra,0x0
    800023c0:	0a4080e7          	jalr	164(ra) # 80002460 <_ZN15MemoryAllocator9mem_allocEm>
}
    800023c4:	00813083          	ld	ra,8(sp)
    800023c8:	00013403          	ld	s0,0(sp)
    800023cc:	01010113          	addi	sp,sp,16
    800023d0:	00008067          	ret

00000000800023d4 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    800023d4:	ff010113          	addi	sp,sp,-16
    800023d8:	00113423          	sd	ra,8(sp)
    800023dc:	00813023          	sd	s0,0(sp)
    800023e0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800023e4:	00000097          	auipc	ra,0x0
    800023e8:	1e0080e7          	jalr	480(ra) # 800025c4 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800023ec:	00813083          	ld	ra,8(sp)
    800023f0:	00013403          	ld	s0,0(sp)
    800023f4:	01010113          	addi	sp,sp,16
    800023f8:	00008067          	ret

00000000800023fc <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    800023fc:	fe010113          	addi	sp,sp,-32
    80002400:	00113c23          	sd	ra,24(sp)
    80002404:	00813823          	sd	s0,16(sp)
    80002408:	00913423          	sd	s1,8(sp)
    8000240c:	01213023          	sd	s2,0(sp)
    80002410:	02010413          	addi	s0,sp,32
    80002414:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002418:	00053503          	ld	a0,0(a0)
    while(curr) {
    8000241c:	02050263          	beqz	a0,80002440 <_ZN3SCB13signalClosingEv+0x44>
    }

    void setSemDeleted(bool newState) {
        semDeleted = newState;
    80002420:	00100793          	li	a5,1
    80002424:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    80002428:	020504a3          	sb	zero,41(a0)
        return nextInList;
    8000242c:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80002430:	fffff097          	auipc	ra,0xfffff
    80002434:	7e4080e7          	jalr	2020(ra) # 80001c14 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80002438:	00048513          	mv	a0,s1
    while(curr) {
    8000243c:	fe1ff06f          	j	8000241c <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002440:	00093423          	sd	zero,8(s2)
    80002444:	00093023          	sd	zero,0(s2)
}
    80002448:	01813083          	ld	ra,24(sp)
    8000244c:	01013403          	ld	s0,16(sp)
    80002450:	00813483          	ld	s1,8(sp)
    80002454:	00013903          	ld	s2,0(sp)
    80002458:	02010113          	addi	sp,sp,32
    8000245c:	00008067          	ret

0000000080002460 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002460:	ff010113          	addi	sp,sp,-16
    80002464:	00813423          	sd	s0,8(sp)
    80002468:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000246c:	00004797          	auipc	a5,0x4
    80002470:	acc7b783          	ld	a5,-1332(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
    80002474:	02078c63          	beqz	a5,800024ac <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002478:	00004717          	auipc	a4,0x4
    8000247c:	a3873703          	ld	a4,-1480(a4) # 80005eb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002480:	00073703          	ld	a4,0(a4)
    80002484:	12e78c63          	beq	a5,a4,800025bc <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002488:	00850713          	addi	a4,a0,8
    8000248c:	00675813          	srli	a6,a4,0x6
    80002490:	03f77793          	andi	a5,a4,63
    80002494:	00f037b3          	snez	a5,a5
    80002498:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    8000249c:	00004517          	auipc	a0,0x4
    800024a0:	a9c53503          	ld	a0,-1380(a0) # 80005f38 <_ZN15MemoryAllocator4headE>
    800024a4:	00000613          	li	a2,0
    800024a8:	0a80006f          	j	80002550 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800024ac:	00004697          	auipc	a3,0x4
    800024b0:	9dc6b683          	ld	a3,-1572(a3) # 80005e88 <_GLOBAL_OFFSET_TABLE_+0x8>
    800024b4:	0006b783          	ld	a5,0(a3)
    800024b8:	00004717          	auipc	a4,0x4
    800024bc:	a8f73023          	sd	a5,-1408(a4) # 80005f38 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800024c0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800024c4:	00004717          	auipc	a4,0x4
    800024c8:	9ec73703          	ld	a4,-1556(a4) # 80005eb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    800024cc:	00073703          	ld	a4,0(a4)
    800024d0:	0006b683          	ld	a3,0(a3)
    800024d4:	40d70733          	sub	a4,a4,a3
    800024d8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800024dc:	0007b823          	sd	zero,16(a5)
    800024e0:	fa9ff06f          	j	80002488 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800024e4:	00060e63          	beqz	a2,80002500 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800024e8:	01063703          	ld	a4,16(a2)
    800024ec:	04070a63          	beqz	a4,80002540 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    800024f0:	01073703          	ld	a4,16(a4)
    800024f4:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    800024f8:	00078813          	mv	a6,a5
    800024fc:	0ac0006f          	j	800025a8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002500:	01053703          	ld	a4,16(a0)
    80002504:	00070a63          	beqz	a4,80002518 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002508:	00004697          	auipc	a3,0x4
    8000250c:	a2e6b823          	sd	a4,-1488(a3) # 80005f38 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002510:	00078813          	mv	a6,a5
    80002514:	0940006f          	j	800025a8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002518:	00004717          	auipc	a4,0x4
    8000251c:	99873703          	ld	a4,-1640(a4) # 80005eb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002520:	00073703          	ld	a4,0(a4)
    80002524:	00004697          	auipc	a3,0x4
    80002528:	a0e6ba23          	sd	a4,-1516(a3) # 80005f38 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000252c:	00078813          	mv	a6,a5
    80002530:	0780006f          	j	800025a8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002534:	00004797          	auipc	a5,0x4
    80002538:	a0e7b223          	sd	a4,-1532(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
    8000253c:	06c0006f          	j	800025a8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002540:	00078813          	mv	a6,a5
    80002544:	0640006f          	j	800025a8 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002548:	00050613          	mv	a2,a0
        curr = curr->next;
    8000254c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002550:	06050063          	beqz	a0,800025b0 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002554:	00853783          	ld	a5,8(a0)
    80002558:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    8000255c:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002560:	fee7e4e3          	bltu	a5,a4,80002548 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002564:	ff06e2e3          	bltu	a3,a6,80002548 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002568:	f7068ee3          	beq	a3,a6,800024e4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    8000256c:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002570:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002574:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002578:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    8000257c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002580:	01053783          	ld	a5,16(a0)
    80002584:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002588:	fa0606e3          	beqz	a2,80002534 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    8000258c:	01063783          	ld	a5,16(a2)
    80002590:	00078663          	beqz	a5,8000259c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002594:	0107b783          	ld	a5,16(a5)
    80002598:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    8000259c:	01063783          	ld	a5,16(a2)
    800025a0:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800025a4:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800025a8:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800025ac:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800025b0:	00813403          	ld	s0,8(sp)
    800025b4:	01010113          	addi	sp,sp,16
    800025b8:	00008067          	ret
        return nullptr;
    800025bc:	00000513          	li	a0,0
    800025c0:	ff1ff06f          	j	800025b0 <_ZN15MemoryAllocator9mem_allocEm+0x150>

00000000800025c4 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800025c4:	ff010113          	addi	sp,sp,-16
    800025c8:	00813423          	sd	s0,8(sp)
    800025cc:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800025d0:	16050063          	beqz	a0,80002730 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800025d4:	ff850713          	addi	a4,a0,-8
    800025d8:	00004797          	auipc	a5,0x4
    800025dc:	8b07b783          	ld	a5,-1872(a5) # 80005e88 <_GLOBAL_OFFSET_TABLE_+0x8>
    800025e0:	0007b783          	ld	a5,0(a5)
    800025e4:	14f76a63          	bltu	a4,a5,80002738 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    800025e8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    800025ec:	fff58693          	addi	a3,a1,-1
    800025f0:	00d706b3          	add	a3,a4,a3
    800025f4:	00004617          	auipc	a2,0x4
    800025f8:	8bc63603          	ld	a2,-1860(a2) # 80005eb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    800025fc:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002600:	14c6f063          	bgeu	a3,a2,80002740 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002604:	14070263          	beqz	a4,80002748 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002608:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    8000260c:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002610:	14079063          	bnez	a5,80002750 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002614:	03f00793          	li	a5,63
    80002618:	14b7f063          	bgeu	a5,a1,80002758 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    8000261c:	00004797          	auipc	a5,0x4
    80002620:	91c7b783          	ld	a5,-1764(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
    80002624:	02f60063          	beq	a2,a5,80002644 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002628:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000262c:	02078a63          	beqz	a5,80002660 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002630:	0007b683          	ld	a3,0(a5)
    80002634:	02e6f663          	bgeu	a3,a4,80002660 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002638:	00078613          	mv	a2,a5
        curr = curr->next;
    8000263c:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002640:	fedff06f          	j	8000262c <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002644:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002648:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    8000264c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002650:	00004797          	auipc	a5,0x4
    80002654:	8ee7b423          	sd	a4,-1816(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
        return 0;
    80002658:	00000513          	li	a0,0
    8000265c:	0480006f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002660:	04060863          	beqz	a2,800026b0 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002664:	00063683          	ld	a3,0(a2)
    80002668:	00863803          	ld	a6,8(a2)
    8000266c:	010686b3          	add	a3,a3,a6
    80002670:	08e68a63          	beq	a3,a4,80002704 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002674:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002678:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000267c:	01063683          	ld	a3,16(a2)
    80002680:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002684:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002688:	0e078063          	beqz	a5,80002768 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000268c:	0007b583          	ld	a1,0(a5)
    80002690:	00073683          	ld	a3,0(a4)
    80002694:	00873603          	ld	a2,8(a4)
    80002698:	00c686b3          	add	a3,a3,a2
    8000269c:	06d58c63          	beq	a1,a3,80002714 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800026a0:	00000513          	li	a0,0
}
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800026b0:	0a078863          	beqz	a5,80002760 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800026b4:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800026b8:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800026bc:	00004797          	auipc	a5,0x4
    800026c0:	87c7b783          	ld	a5,-1924(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
    800026c4:	0007b603          	ld	a2,0(a5)
    800026c8:	00b706b3          	add	a3,a4,a1
    800026cc:	00d60c63          	beq	a2,a3,800026e4 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800026d0:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800026d4:	00004797          	auipc	a5,0x4
    800026d8:	86e7b223          	sd	a4,-1948(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
            return 0;
    800026dc:	00000513          	li	a0,0
    800026e0:	fc5ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800026e4:	0087b783          	ld	a5,8(a5)
    800026e8:	00b785b3          	add	a1,a5,a1
    800026ec:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800026f0:	00004797          	auipc	a5,0x4
    800026f4:	8487b783          	ld	a5,-1976(a5) # 80005f38 <_ZN15MemoryAllocator4headE>
    800026f8:	0107b783          	ld	a5,16(a5)
    800026fc:	00f53423          	sd	a5,8(a0)
    80002700:	fd5ff06f          	j	800026d4 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002704:	00b805b3          	add	a1,a6,a1
    80002708:	00b63423          	sd	a1,8(a2)
    8000270c:	00060713          	mv	a4,a2
    80002710:	f79ff06f          	j	80002688 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002714:	0087b683          	ld	a3,8(a5)
    80002718:	00d60633          	add	a2,a2,a3
    8000271c:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002720:	0107b783          	ld	a5,16(a5)
    80002724:	00f73823          	sd	a5,16(a4)
    return 0;
    80002728:	00000513          	li	a0,0
    8000272c:	f79ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002730:	fff00513          	li	a0,-1
    80002734:	f71ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002738:	fff00513          	li	a0,-1
    8000273c:	f69ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80002740:	fff00513          	li	a0,-1
    80002744:	f61ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002748:	fff00513          	li	a0,-1
    8000274c:	f59ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002750:	fff00513          	li	a0,-1
    80002754:	f51ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002758:	fff00513          	li	a0,-1
    8000275c:	f49ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80002760:	fff00513          	li	a0,-1
    80002764:	f41ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002768:	00000513          	li	a0,0
    8000276c:	f39ff06f          	j	800026a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002770 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    80002770:	fd010113          	addi	sp,sp,-48
    80002774:	02113423          	sd	ra,40(sp)
    80002778:	02813023          	sd	s0,32(sp)
    8000277c:	00913c23          	sd	s1,24(sp)
    80002780:	01213823          	sd	s2,16(sp)
    80002784:	03010413          	addi	s0,sp,48
    80002788:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000278c:	100027f3          	csrr	a5,sstatus
    80002790:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    80002794:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002798:	00200793          	li	a5,2
    8000279c:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    800027a0:	0004c503          	lbu	a0,0(s1)
    800027a4:	00050a63          	beqz	a0,800027b8 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    800027a8:	00002097          	auipc	ra,0x2
    800027ac:	274080e7          	jalr	628(ra) # 80004a1c <__putc>
        string++;
    800027b0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800027b4:	fedff06f          	j	800027a0 <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800027b8:	0009091b          	sext.w	s2,s2
    800027bc:	00297913          	andi	s2,s2,2
    800027c0:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800027c4:	10092073          	csrs	sstatus,s2
}
    800027c8:	02813083          	ld	ra,40(sp)
    800027cc:	02013403          	ld	s0,32(sp)
    800027d0:	01813483          	ld	s1,24(sp)
    800027d4:	01013903          	ld	s2,16(sp)
    800027d8:	03010113          	addi	sp,sp,48
    800027dc:	00008067          	ret

00000000800027e0 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    800027e0:	fc010113          	addi	sp,sp,-64
    800027e4:	02113c23          	sd	ra,56(sp)
    800027e8:	02813823          	sd	s0,48(sp)
    800027ec:	02913423          	sd	s1,40(sp)
    800027f0:	03213023          	sd	s2,32(sp)
    800027f4:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800027f8:	100027f3          	csrr	a5,sstatus
    800027fc:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    80002800:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002804:	00200793          	li	a5,2
    80002808:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    8000280c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002810:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002814:	00a00613          	li	a2,10
    80002818:	02c5773b          	remuw	a4,a0,a2
    8000281c:	02071693          	slli	a3,a4,0x20
    80002820:	0206d693          	srli	a3,a3,0x20
    80002824:	00003717          	auipc	a4,0x3
    80002828:	8fc70713          	addi	a4,a4,-1796 # 80005120 <_ZZ12printIntegermE6digits>
    8000282c:	00d70733          	add	a4,a4,a3
    80002830:	00074703          	lbu	a4,0(a4)
    80002834:	fe040693          	addi	a3,s0,-32
    80002838:	009687b3          	add	a5,a3,s1
    8000283c:	0014849b          	addiw	s1,s1,1
    80002840:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002844:	0005071b          	sext.w	a4,a0
    80002848:	02c5553b          	divuw	a0,a0,a2
    8000284c:	00900793          	li	a5,9
    80002850:	fce7e2e3          	bltu	a5,a4,80002814 <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80002854:	fff4849b          	addiw	s1,s1,-1
    80002858:	0004ce63          	bltz	s1,80002874 <_Z12printIntegerm+0x94>
    8000285c:	fe040793          	addi	a5,s0,-32
    80002860:	009787b3          	add	a5,a5,s1
    80002864:	ff07c503          	lbu	a0,-16(a5)
    80002868:	00002097          	auipc	ra,0x2
    8000286c:	1b4080e7          	jalr	436(ra) # 80004a1c <__putc>
    80002870:	fe5ff06f          	j	80002854 <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002874:	0009091b          	sext.w	s2,s2
    80002878:	00297913          	andi	s2,s2,2
    8000287c:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002880:	10092073          	csrs	sstatus,s2
}
    80002884:	03813083          	ld	ra,56(sp)
    80002888:	03013403          	ld	s0,48(sp)
    8000288c:	02813483          	ld	s1,40(sp)
    80002890:	02013903          	ld	s2,32(sp)
    80002894:	04010113          	addi	sp,sp,64
    80002898:	00008067          	ret

000000008000289c <_Z10printErrorv>:
void printError() {
    8000289c:	fc010113          	addi	sp,sp,-64
    800028a0:	02113c23          	sd	ra,56(sp)
    800028a4:	02813823          	sd	s0,48(sp)
    800028a8:	02913423          	sd	s1,40(sp)
    800028ac:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800028b0:	100027f3          	csrr	a5,sstatus
    800028b4:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800028b8:	fd843483          	ld	s1,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800028bc:	00200793          	li	a5,2
    800028c0:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    printString("scause: ");
    800028c4:	00003517          	auipc	a0,0x3
    800028c8:	83450513          	addi	a0,a0,-1996 # 800050f8 <CONSOLE_STATUS+0xe8>
    800028cc:	00000097          	auipc	ra,0x0
    800028d0:	ea4080e7          	jalr	-348(ra) # 80002770 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800028d4:	142027f3          	csrr	a5,scause
    800028d8:	fcf43823          	sd	a5,-48(s0)
        return scause;
    800028dc:	fd043503          	ld	a0,-48(s0)
    printInteger(Kernel::r_scause());
    800028e0:	00000097          	auipc	ra,0x0
    800028e4:	f00080e7          	jalr	-256(ra) # 800027e0 <_Z12printIntegerm>
    printString("\nsepc: ");
    800028e8:	00003517          	auipc	a0,0x3
    800028ec:	82050513          	addi	a0,a0,-2016 # 80005108 <CONSOLE_STATUS+0xf8>
    800028f0:	00000097          	auipc	ra,0x0
    800028f4:	e80080e7          	jalr	-384(ra) # 80002770 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800028f8:	141027f3          	csrr	a5,sepc
    800028fc:	fcf43423          	sd	a5,-56(s0)
        return sepc;
    80002900:	fc843503          	ld	a0,-56(s0)
    printInteger(Kernel::r_sepc());
    80002904:	00000097          	auipc	ra,0x0
    80002908:	edc080e7          	jalr	-292(ra) # 800027e0 <_Z12printIntegerm>
    printString("\nstval: ");
    8000290c:	00003517          	auipc	a0,0x3
    80002910:	80450513          	addi	a0,a0,-2044 # 80005110 <CONSOLE_STATUS+0x100>
    80002914:	00000097          	auipc	ra,0x0
    80002918:	e5c080e7          	jalr	-420(ra) # 80002770 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    8000291c:	143027f3          	csrr	a5,stval
    80002920:	fcf43023          	sd	a5,-64(s0)
        return stval;
    80002924:	fc043503          	ld	a0,-64(s0)
    printInteger(Kernel::r_stval());
    80002928:	00000097          	auipc	ra,0x0
    8000292c:	eb8080e7          	jalr	-328(ra) # 800027e0 <_Z12printIntegerm>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002930:	0004849b          	sext.w	s1,s1
    80002934:	0024f493          	andi	s1,s1,2
    80002938:	0004849b          	sext.w	s1,s1
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000293c:	1004a073          	csrs	sstatus,s1
    80002940:	03813083          	ld	ra,56(sp)
    80002944:	03013403          	ld	s0,48(sp)
    80002948:	02813483          	ld	s1,40(sp)
    8000294c:	04010113          	addi	sp,sp,64
    80002950:	00008067          	ret

0000000080002954 <start>:
    80002954:	ff010113          	addi	sp,sp,-16
    80002958:	00813423          	sd	s0,8(sp)
    8000295c:	01010413          	addi	s0,sp,16
    80002960:	300027f3          	csrr	a5,mstatus
    80002964:	ffffe737          	lui	a4,0xffffe
    80002968:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff765f>
    8000296c:	00e7f7b3          	and	a5,a5,a4
    80002970:	00001737          	lui	a4,0x1
    80002974:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002978:	00e7e7b3          	or	a5,a5,a4
    8000297c:	30079073          	csrw	mstatus,a5
    80002980:	00000797          	auipc	a5,0x0
    80002984:	16078793          	addi	a5,a5,352 # 80002ae0 <system_main>
    80002988:	34179073          	csrw	mepc,a5
    8000298c:	00000793          	li	a5,0
    80002990:	18079073          	csrw	satp,a5
    80002994:	000107b7          	lui	a5,0x10
    80002998:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000299c:	30279073          	csrw	medeleg,a5
    800029a0:	30379073          	csrw	mideleg,a5
    800029a4:	104027f3          	csrr	a5,sie
    800029a8:	2227e793          	ori	a5,a5,546
    800029ac:	10479073          	csrw	sie,a5
    800029b0:	fff00793          	li	a5,-1
    800029b4:	00a7d793          	srli	a5,a5,0xa
    800029b8:	3b079073          	csrw	pmpaddr0,a5
    800029bc:	00f00793          	li	a5,15
    800029c0:	3a079073          	csrw	pmpcfg0,a5
    800029c4:	f14027f3          	csrr	a5,mhartid
    800029c8:	0200c737          	lui	a4,0x200c
    800029cc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800029d0:	0007869b          	sext.w	a3,a5
    800029d4:	00269713          	slli	a4,a3,0x2
    800029d8:	000f4637          	lui	a2,0xf4
    800029dc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800029e0:	00d70733          	add	a4,a4,a3
    800029e4:	0037979b          	slliw	a5,a5,0x3
    800029e8:	020046b7          	lui	a3,0x2004
    800029ec:	00d787b3          	add	a5,a5,a3
    800029f0:	00c585b3          	add	a1,a1,a2
    800029f4:	00371693          	slli	a3,a4,0x3
    800029f8:	00003717          	auipc	a4,0x3
    800029fc:	54870713          	addi	a4,a4,1352 # 80005f40 <timer_scratch>
    80002a00:	00b7b023          	sd	a1,0(a5)
    80002a04:	00d70733          	add	a4,a4,a3
    80002a08:	00f73c23          	sd	a5,24(a4)
    80002a0c:	02c73023          	sd	a2,32(a4)
    80002a10:	34071073          	csrw	mscratch,a4
    80002a14:	00000797          	auipc	a5,0x0
    80002a18:	6ec78793          	addi	a5,a5,1772 # 80003100 <timervec>
    80002a1c:	30579073          	csrw	mtvec,a5
    80002a20:	300027f3          	csrr	a5,mstatus
    80002a24:	0087e793          	ori	a5,a5,8
    80002a28:	30079073          	csrw	mstatus,a5
    80002a2c:	304027f3          	csrr	a5,mie
    80002a30:	0807e793          	ori	a5,a5,128
    80002a34:	30479073          	csrw	mie,a5
    80002a38:	f14027f3          	csrr	a5,mhartid
    80002a3c:	0007879b          	sext.w	a5,a5
    80002a40:	00078213          	mv	tp,a5
    80002a44:	30200073          	mret
    80002a48:	00813403          	ld	s0,8(sp)
    80002a4c:	01010113          	addi	sp,sp,16
    80002a50:	00008067          	ret

0000000080002a54 <timerinit>:
    80002a54:	ff010113          	addi	sp,sp,-16
    80002a58:	00813423          	sd	s0,8(sp)
    80002a5c:	01010413          	addi	s0,sp,16
    80002a60:	f14027f3          	csrr	a5,mhartid
    80002a64:	0200c737          	lui	a4,0x200c
    80002a68:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002a6c:	0007869b          	sext.w	a3,a5
    80002a70:	00269713          	slli	a4,a3,0x2
    80002a74:	000f4637          	lui	a2,0xf4
    80002a78:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002a7c:	00d70733          	add	a4,a4,a3
    80002a80:	0037979b          	slliw	a5,a5,0x3
    80002a84:	020046b7          	lui	a3,0x2004
    80002a88:	00d787b3          	add	a5,a5,a3
    80002a8c:	00c585b3          	add	a1,a1,a2
    80002a90:	00371693          	slli	a3,a4,0x3
    80002a94:	00003717          	auipc	a4,0x3
    80002a98:	4ac70713          	addi	a4,a4,1196 # 80005f40 <timer_scratch>
    80002a9c:	00b7b023          	sd	a1,0(a5)
    80002aa0:	00d70733          	add	a4,a4,a3
    80002aa4:	00f73c23          	sd	a5,24(a4)
    80002aa8:	02c73023          	sd	a2,32(a4)
    80002aac:	34071073          	csrw	mscratch,a4
    80002ab0:	00000797          	auipc	a5,0x0
    80002ab4:	65078793          	addi	a5,a5,1616 # 80003100 <timervec>
    80002ab8:	30579073          	csrw	mtvec,a5
    80002abc:	300027f3          	csrr	a5,mstatus
    80002ac0:	0087e793          	ori	a5,a5,8
    80002ac4:	30079073          	csrw	mstatus,a5
    80002ac8:	304027f3          	csrr	a5,mie
    80002acc:	0807e793          	ori	a5,a5,128
    80002ad0:	30479073          	csrw	mie,a5
    80002ad4:	00813403          	ld	s0,8(sp)
    80002ad8:	01010113          	addi	sp,sp,16
    80002adc:	00008067          	ret

0000000080002ae0 <system_main>:
    80002ae0:	fe010113          	addi	sp,sp,-32
    80002ae4:	00813823          	sd	s0,16(sp)
    80002ae8:	00913423          	sd	s1,8(sp)
    80002aec:	00113c23          	sd	ra,24(sp)
    80002af0:	02010413          	addi	s0,sp,32
    80002af4:	00000097          	auipc	ra,0x0
    80002af8:	0c4080e7          	jalr	196(ra) # 80002bb8 <cpuid>
    80002afc:	00003497          	auipc	s1,0x3
    80002b00:	3d448493          	addi	s1,s1,980 # 80005ed0 <started>
    80002b04:	02050263          	beqz	a0,80002b28 <system_main+0x48>
    80002b08:	0004a783          	lw	a5,0(s1)
    80002b0c:	0007879b          	sext.w	a5,a5
    80002b10:	fe078ce3          	beqz	a5,80002b08 <system_main+0x28>
    80002b14:	0ff0000f          	fence
    80002b18:	00002517          	auipc	a0,0x2
    80002b1c:	64850513          	addi	a0,a0,1608 # 80005160 <_ZZ12printIntegermE6digits+0x40>
    80002b20:	00001097          	auipc	ra,0x1
    80002b24:	a7c080e7          	jalr	-1412(ra) # 8000359c <panic>
    80002b28:	00001097          	auipc	ra,0x1
    80002b2c:	9d0080e7          	jalr	-1584(ra) # 800034f8 <consoleinit>
    80002b30:	00001097          	auipc	ra,0x1
    80002b34:	15c080e7          	jalr	348(ra) # 80003c8c <printfinit>
    80002b38:	00002517          	auipc	a0,0x2
    80002b3c:	70850513          	addi	a0,a0,1800 # 80005240 <_ZZ12printIntegermE6digits+0x120>
    80002b40:	00001097          	auipc	ra,0x1
    80002b44:	ab8080e7          	jalr	-1352(ra) # 800035f8 <__printf>
    80002b48:	00002517          	auipc	a0,0x2
    80002b4c:	5e850513          	addi	a0,a0,1512 # 80005130 <_ZZ12printIntegermE6digits+0x10>
    80002b50:	00001097          	auipc	ra,0x1
    80002b54:	aa8080e7          	jalr	-1368(ra) # 800035f8 <__printf>
    80002b58:	00002517          	auipc	a0,0x2
    80002b5c:	6e850513          	addi	a0,a0,1768 # 80005240 <_ZZ12printIntegermE6digits+0x120>
    80002b60:	00001097          	auipc	ra,0x1
    80002b64:	a98080e7          	jalr	-1384(ra) # 800035f8 <__printf>
    80002b68:	00001097          	auipc	ra,0x1
    80002b6c:	4b0080e7          	jalr	1200(ra) # 80004018 <kinit>
    80002b70:	00000097          	auipc	ra,0x0
    80002b74:	148080e7          	jalr	328(ra) # 80002cb8 <trapinit>
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	16c080e7          	jalr	364(ra) # 80002ce4 <trapinithart>
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	5c0080e7          	jalr	1472(ra) # 80003140 <plicinit>
    80002b88:	00000097          	auipc	ra,0x0
    80002b8c:	5e0080e7          	jalr	1504(ra) # 80003168 <plicinithart>
    80002b90:	00000097          	auipc	ra,0x0
    80002b94:	078080e7          	jalr	120(ra) # 80002c08 <userinit>
    80002b98:	0ff0000f          	fence
    80002b9c:	00100793          	li	a5,1
    80002ba0:	00002517          	auipc	a0,0x2
    80002ba4:	5a850513          	addi	a0,a0,1448 # 80005148 <_ZZ12printIntegermE6digits+0x28>
    80002ba8:	00f4a023          	sw	a5,0(s1)
    80002bac:	00001097          	auipc	ra,0x1
    80002bb0:	a4c080e7          	jalr	-1460(ra) # 800035f8 <__printf>
    80002bb4:	0000006f          	j	80002bb4 <system_main+0xd4>

0000000080002bb8 <cpuid>:
    80002bb8:	ff010113          	addi	sp,sp,-16
    80002bbc:	00813423          	sd	s0,8(sp)
    80002bc0:	01010413          	addi	s0,sp,16
    80002bc4:	00020513          	mv	a0,tp
    80002bc8:	00813403          	ld	s0,8(sp)
    80002bcc:	0005051b          	sext.w	a0,a0
    80002bd0:	01010113          	addi	sp,sp,16
    80002bd4:	00008067          	ret

0000000080002bd8 <mycpu>:
    80002bd8:	ff010113          	addi	sp,sp,-16
    80002bdc:	00813423          	sd	s0,8(sp)
    80002be0:	01010413          	addi	s0,sp,16
    80002be4:	00020793          	mv	a5,tp
    80002be8:	00813403          	ld	s0,8(sp)
    80002bec:	0007879b          	sext.w	a5,a5
    80002bf0:	00779793          	slli	a5,a5,0x7
    80002bf4:	00004517          	auipc	a0,0x4
    80002bf8:	37c50513          	addi	a0,a0,892 # 80006f70 <cpus>
    80002bfc:	00f50533          	add	a0,a0,a5
    80002c00:	01010113          	addi	sp,sp,16
    80002c04:	00008067          	ret

0000000080002c08 <userinit>:
    80002c08:	ff010113          	addi	sp,sp,-16
    80002c0c:	00813423          	sd	s0,8(sp)
    80002c10:	01010413          	addi	s0,sp,16
    80002c14:	00813403          	ld	s0,8(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	fffff317          	auipc	t1,0xfffff
    80002c20:	15030067          	jr	336(t1) # 80001d6c <main>

0000000080002c24 <either_copyout>:
    80002c24:	ff010113          	addi	sp,sp,-16
    80002c28:	00813023          	sd	s0,0(sp)
    80002c2c:	00113423          	sd	ra,8(sp)
    80002c30:	01010413          	addi	s0,sp,16
    80002c34:	02051663          	bnez	a0,80002c60 <either_copyout+0x3c>
    80002c38:	00058513          	mv	a0,a1
    80002c3c:	00060593          	mv	a1,a2
    80002c40:	0006861b          	sext.w	a2,a3
    80002c44:	00002097          	auipc	ra,0x2
    80002c48:	c60080e7          	jalr	-928(ra) # 800048a4 <__memmove>
    80002c4c:	00813083          	ld	ra,8(sp)
    80002c50:	00013403          	ld	s0,0(sp)
    80002c54:	00000513          	li	a0,0
    80002c58:	01010113          	addi	sp,sp,16
    80002c5c:	00008067          	ret
    80002c60:	00002517          	auipc	a0,0x2
    80002c64:	52850513          	addi	a0,a0,1320 # 80005188 <_ZZ12printIntegermE6digits+0x68>
    80002c68:	00001097          	auipc	ra,0x1
    80002c6c:	934080e7          	jalr	-1740(ra) # 8000359c <panic>

0000000080002c70 <either_copyin>:
    80002c70:	ff010113          	addi	sp,sp,-16
    80002c74:	00813023          	sd	s0,0(sp)
    80002c78:	00113423          	sd	ra,8(sp)
    80002c7c:	01010413          	addi	s0,sp,16
    80002c80:	02059463          	bnez	a1,80002ca8 <either_copyin+0x38>
    80002c84:	00060593          	mv	a1,a2
    80002c88:	0006861b          	sext.w	a2,a3
    80002c8c:	00002097          	auipc	ra,0x2
    80002c90:	c18080e7          	jalr	-1000(ra) # 800048a4 <__memmove>
    80002c94:	00813083          	ld	ra,8(sp)
    80002c98:	00013403          	ld	s0,0(sp)
    80002c9c:	00000513          	li	a0,0
    80002ca0:	01010113          	addi	sp,sp,16
    80002ca4:	00008067          	ret
    80002ca8:	00002517          	auipc	a0,0x2
    80002cac:	50850513          	addi	a0,a0,1288 # 800051b0 <_ZZ12printIntegermE6digits+0x90>
    80002cb0:	00001097          	auipc	ra,0x1
    80002cb4:	8ec080e7          	jalr	-1812(ra) # 8000359c <panic>

0000000080002cb8 <trapinit>:
    80002cb8:	ff010113          	addi	sp,sp,-16
    80002cbc:	00813423          	sd	s0,8(sp)
    80002cc0:	01010413          	addi	s0,sp,16
    80002cc4:	00813403          	ld	s0,8(sp)
    80002cc8:	00002597          	auipc	a1,0x2
    80002ccc:	51058593          	addi	a1,a1,1296 # 800051d8 <_ZZ12printIntegermE6digits+0xb8>
    80002cd0:	00004517          	auipc	a0,0x4
    80002cd4:	32050513          	addi	a0,a0,800 # 80006ff0 <tickslock>
    80002cd8:	01010113          	addi	sp,sp,16
    80002cdc:	00001317          	auipc	t1,0x1
    80002ce0:	5cc30067          	jr	1484(t1) # 800042a8 <initlock>

0000000080002ce4 <trapinithart>:
    80002ce4:	ff010113          	addi	sp,sp,-16
    80002ce8:	00813423          	sd	s0,8(sp)
    80002cec:	01010413          	addi	s0,sp,16
    80002cf0:	00000797          	auipc	a5,0x0
    80002cf4:	30078793          	addi	a5,a5,768 # 80002ff0 <kernelvec>
    80002cf8:	10579073          	csrw	stvec,a5
    80002cfc:	00813403          	ld	s0,8(sp)
    80002d00:	01010113          	addi	sp,sp,16
    80002d04:	00008067          	ret

0000000080002d08 <usertrap>:
    80002d08:	ff010113          	addi	sp,sp,-16
    80002d0c:	00813423          	sd	s0,8(sp)
    80002d10:	01010413          	addi	s0,sp,16
    80002d14:	00813403          	ld	s0,8(sp)
    80002d18:	01010113          	addi	sp,sp,16
    80002d1c:	00008067          	ret

0000000080002d20 <usertrapret>:
    80002d20:	ff010113          	addi	sp,sp,-16
    80002d24:	00813423          	sd	s0,8(sp)
    80002d28:	01010413          	addi	s0,sp,16
    80002d2c:	00813403          	ld	s0,8(sp)
    80002d30:	01010113          	addi	sp,sp,16
    80002d34:	00008067          	ret

0000000080002d38 <kerneltrap>:
    80002d38:	fe010113          	addi	sp,sp,-32
    80002d3c:	00813823          	sd	s0,16(sp)
    80002d40:	00113c23          	sd	ra,24(sp)
    80002d44:	00913423          	sd	s1,8(sp)
    80002d48:	02010413          	addi	s0,sp,32
    80002d4c:	142025f3          	csrr	a1,scause
    80002d50:	100027f3          	csrr	a5,sstatus
    80002d54:	0027f793          	andi	a5,a5,2
    80002d58:	10079c63          	bnez	a5,80002e70 <kerneltrap+0x138>
    80002d5c:	142027f3          	csrr	a5,scause
    80002d60:	0207ce63          	bltz	a5,80002d9c <kerneltrap+0x64>
    80002d64:	00002517          	auipc	a0,0x2
    80002d68:	4bc50513          	addi	a0,a0,1212 # 80005220 <_ZZ12printIntegermE6digits+0x100>
    80002d6c:	00001097          	auipc	ra,0x1
    80002d70:	88c080e7          	jalr	-1908(ra) # 800035f8 <__printf>
    80002d74:	141025f3          	csrr	a1,sepc
    80002d78:	14302673          	csrr	a2,stval
    80002d7c:	00002517          	auipc	a0,0x2
    80002d80:	4b450513          	addi	a0,a0,1204 # 80005230 <_ZZ12printIntegermE6digits+0x110>
    80002d84:	00001097          	auipc	ra,0x1
    80002d88:	874080e7          	jalr	-1932(ra) # 800035f8 <__printf>
    80002d8c:	00002517          	auipc	a0,0x2
    80002d90:	4bc50513          	addi	a0,a0,1212 # 80005248 <_ZZ12printIntegermE6digits+0x128>
    80002d94:	00001097          	auipc	ra,0x1
    80002d98:	808080e7          	jalr	-2040(ra) # 8000359c <panic>
    80002d9c:	0ff7f713          	andi	a4,a5,255
    80002da0:	00900693          	li	a3,9
    80002da4:	04d70063          	beq	a4,a3,80002de4 <kerneltrap+0xac>
    80002da8:	fff00713          	li	a4,-1
    80002dac:	03f71713          	slli	a4,a4,0x3f
    80002db0:	00170713          	addi	a4,a4,1
    80002db4:	fae798e3          	bne	a5,a4,80002d64 <kerneltrap+0x2c>
    80002db8:	00000097          	auipc	ra,0x0
    80002dbc:	e00080e7          	jalr	-512(ra) # 80002bb8 <cpuid>
    80002dc0:	06050663          	beqz	a0,80002e2c <kerneltrap+0xf4>
    80002dc4:	144027f3          	csrr	a5,sip
    80002dc8:	ffd7f793          	andi	a5,a5,-3
    80002dcc:	14479073          	csrw	sip,a5
    80002dd0:	01813083          	ld	ra,24(sp)
    80002dd4:	01013403          	ld	s0,16(sp)
    80002dd8:	00813483          	ld	s1,8(sp)
    80002ddc:	02010113          	addi	sp,sp,32
    80002de0:	00008067          	ret
    80002de4:	00000097          	auipc	ra,0x0
    80002de8:	3d0080e7          	jalr	976(ra) # 800031b4 <plic_claim>
    80002dec:	00a00793          	li	a5,10
    80002df0:	00050493          	mv	s1,a0
    80002df4:	06f50863          	beq	a0,a5,80002e64 <kerneltrap+0x12c>
    80002df8:	fc050ce3          	beqz	a0,80002dd0 <kerneltrap+0x98>
    80002dfc:	00050593          	mv	a1,a0
    80002e00:	00002517          	auipc	a0,0x2
    80002e04:	40050513          	addi	a0,a0,1024 # 80005200 <_ZZ12printIntegermE6digits+0xe0>
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	7f0080e7          	jalr	2032(ra) # 800035f8 <__printf>
    80002e10:	01013403          	ld	s0,16(sp)
    80002e14:	01813083          	ld	ra,24(sp)
    80002e18:	00048513          	mv	a0,s1
    80002e1c:	00813483          	ld	s1,8(sp)
    80002e20:	02010113          	addi	sp,sp,32
    80002e24:	00000317          	auipc	t1,0x0
    80002e28:	3c830067          	jr	968(t1) # 800031ec <plic_complete>
    80002e2c:	00004517          	auipc	a0,0x4
    80002e30:	1c450513          	addi	a0,a0,452 # 80006ff0 <tickslock>
    80002e34:	00001097          	auipc	ra,0x1
    80002e38:	498080e7          	jalr	1176(ra) # 800042cc <acquire>
    80002e3c:	00003717          	auipc	a4,0x3
    80002e40:	09870713          	addi	a4,a4,152 # 80005ed4 <ticks>
    80002e44:	00072783          	lw	a5,0(a4)
    80002e48:	00004517          	auipc	a0,0x4
    80002e4c:	1a850513          	addi	a0,a0,424 # 80006ff0 <tickslock>
    80002e50:	0017879b          	addiw	a5,a5,1
    80002e54:	00f72023          	sw	a5,0(a4)
    80002e58:	00001097          	auipc	ra,0x1
    80002e5c:	540080e7          	jalr	1344(ra) # 80004398 <release>
    80002e60:	f65ff06f          	j	80002dc4 <kerneltrap+0x8c>
    80002e64:	00001097          	auipc	ra,0x1
    80002e68:	09c080e7          	jalr	156(ra) # 80003f00 <uartintr>
    80002e6c:	fa5ff06f          	j	80002e10 <kerneltrap+0xd8>
    80002e70:	00002517          	auipc	a0,0x2
    80002e74:	37050513          	addi	a0,a0,880 # 800051e0 <_ZZ12printIntegermE6digits+0xc0>
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	724080e7          	jalr	1828(ra) # 8000359c <panic>

0000000080002e80 <clockintr>:
    80002e80:	fe010113          	addi	sp,sp,-32
    80002e84:	00813823          	sd	s0,16(sp)
    80002e88:	00913423          	sd	s1,8(sp)
    80002e8c:	00113c23          	sd	ra,24(sp)
    80002e90:	02010413          	addi	s0,sp,32
    80002e94:	00004497          	auipc	s1,0x4
    80002e98:	15c48493          	addi	s1,s1,348 # 80006ff0 <tickslock>
    80002e9c:	00048513          	mv	a0,s1
    80002ea0:	00001097          	auipc	ra,0x1
    80002ea4:	42c080e7          	jalr	1068(ra) # 800042cc <acquire>
    80002ea8:	00003717          	auipc	a4,0x3
    80002eac:	02c70713          	addi	a4,a4,44 # 80005ed4 <ticks>
    80002eb0:	00072783          	lw	a5,0(a4)
    80002eb4:	01013403          	ld	s0,16(sp)
    80002eb8:	01813083          	ld	ra,24(sp)
    80002ebc:	00048513          	mv	a0,s1
    80002ec0:	0017879b          	addiw	a5,a5,1
    80002ec4:	00813483          	ld	s1,8(sp)
    80002ec8:	00f72023          	sw	a5,0(a4)
    80002ecc:	02010113          	addi	sp,sp,32
    80002ed0:	00001317          	auipc	t1,0x1
    80002ed4:	4c830067          	jr	1224(t1) # 80004398 <release>

0000000080002ed8 <devintr>:
    80002ed8:	142027f3          	csrr	a5,scause
    80002edc:	00000513          	li	a0,0
    80002ee0:	0007c463          	bltz	a5,80002ee8 <devintr+0x10>
    80002ee4:	00008067          	ret
    80002ee8:	fe010113          	addi	sp,sp,-32
    80002eec:	00813823          	sd	s0,16(sp)
    80002ef0:	00113c23          	sd	ra,24(sp)
    80002ef4:	00913423          	sd	s1,8(sp)
    80002ef8:	02010413          	addi	s0,sp,32
    80002efc:	0ff7f713          	andi	a4,a5,255
    80002f00:	00900693          	li	a3,9
    80002f04:	04d70c63          	beq	a4,a3,80002f5c <devintr+0x84>
    80002f08:	fff00713          	li	a4,-1
    80002f0c:	03f71713          	slli	a4,a4,0x3f
    80002f10:	00170713          	addi	a4,a4,1
    80002f14:	00e78c63          	beq	a5,a4,80002f2c <devintr+0x54>
    80002f18:	01813083          	ld	ra,24(sp)
    80002f1c:	01013403          	ld	s0,16(sp)
    80002f20:	00813483          	ld	s1,8(sp)
    80002f24:	02010113          	addi	sp,sp,32
    80002f28:	00008067          	ret
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	c8c080e7          	jalr	-884(ra) # 80002bb8 <cpuid>
    80002f34:	06050663          	beqz	a0,80002fa0 <devintr+0xc8>
    80002f38:	144027f3          	csrr	a5,sip
    80002f3c:	ffd7f793          	andi	a5,a5,-3
    80002f40:	14479073          	csrw	sip,a5
    80002f44:	01813083          	ld	ra,24(sp)
    80002f48:	01013403          	ld	s0,16(sp)
    80002f4c:	00813483          	ld	s1,8(sp)
    80002f50:	00200513          	li	a0,2
    80002f54:	02010113          	addi	sp,sp,32
    80002f58:	00008067          	ret
    80002f5c:	00000097          	auipc	ra,0x0
    80002f60:	258080e7          	jalr	600(ra) # 800031b4 <plic_claim>
    80002f64:	00a00793          	li	a5,10
    80002f68:	00050493          	mv	s1,a0
    80002f6c:	06f50663          	beq	a0,a5,80002fd8 <devintr+0x100>
    80002f70:	00100513          	li	a0,1
    80002f74:	fa0482e3          	beqz	s1,80002f18 <devintr+0x40>
    80002f78:	00048593          	mv	a1,s1
    80002f7c:	00002517          	auipc	a0,0x2
    80002f80:	28450513          	addi	a0,a0,644 # 80005200 <_ZZ12printIntegermE6digits+0xe0>
    80002f84:	00000097          	auipc	ra,0x0
    80002f88:	674080e7          	jalr	1652(ra) # 800035f8 <__printf>
    80002f8c:	00048513          	mv	a0,s1
    80002f90:	00000097          	auipc	ra,0x0
    80002f94:	25c080e7          	jalr	604(ra) # 800031ec <plic_complete>
    80002f98:	00100513          	li	a0,1
    80002f9c:	f7dff06f          	j	80002f18 <devintr+0x40>
    80002fa0:	00004517          	auipc	a0,0x4
    80002fa4:	05050513          	addi	a0,a0,80 # 80006ff0 <tickslock>
    80002fa8:	00001097          	auipc	ra,0x1
    80002fac:	324080e7          	jalr	804(ra) # 800042cc <acquire>
    80002fb0:	00003717          	auipc	a4,0x3
    80002fb4:	f2470713          	addi	a4,a4,-220 # 80005ed4 <ticks>
    80002fb8:	00072783          	lw	a5,0(a4)
    80002fbc:	00004517          	auipc	a0,0x4
    80002fc0:	03450513          	addi	a0,a0,52 # 80006ff0 <tickslock>
    80002fc4:	0017879b          	addiw	a5,a5,1
    80002fc8:	00f72023          	sw	a5,0(a4)
    80002fcc:	00001097          	auipc	ra,0x1
    80002fd0:	3cc080e7          	jalr	972(ra) # 80004398 <release>
    80002fd4:	f65ff06f          	j	80002f38 <devintr+0x60>
    80002fd8:	00001097          	auipc	ra,0x1
    80002fdc:	f28080e7          	jalr	-216(ra) # 80003f00 <uartintr>
    80002fe0:	fadff06f          	j	80002f8c <devintr+0xb4>
	...

0000000080002ff0 <kernelvec>:
    80002ff0:	f0010113          	addi	sp,sp,-256
    80002ff4:	00113023          	sd	ra,0(sp)
    80002ff8:	00213423          	sd	sp,8(sp)
    80002ffc:	00313823          	sd	gp,16(sp)
    80003000:	00413c23          	sd	tp,24(sp)
    80003004:	02513023          	sd	t0,32(sp)
    80003008:	02613423          	sd	t1,40(sp)
    8000300c:	02713823          	sd	t2,48(sp)
    80003010:	02813c23          	sd	s0,56(sp)
    80003014:	04913023          	sd	s1,64(sp)
    80003018:	04a13423          	sd	a0,72(sp)
    8000301c:	04b13823          	sd	a1,80(sp)
    80003020:	04c13c23          	sd	a2,88(sp)
    80003024:	06d13023          	sd	a3,96(sp)
    80003028:	06e13423          	sd	a4,104(sp)
    8000302c:	06f13823          	sd	a5,112(sp)
    80003030:	07013c23          	sd	a6,120(sp)
    80003034:	09113023          	sd	a7,128(sp)
    80003038:	09213423          	sd	s2,136(sp)
    8000303c:	09313823          	sd	s3,144(sp)
    80003040:	09413c23          	sd	s4,152(sp)
    80003044:	0b513023          	sd	s5,160(sp)
    80003048:	0b613423          	sd	s6,168(sp)
    8000304c:	0b713823          	sd	s7,176(sp)
    80003050:	0b813c23          	sd	s8,184(sp)
    80003054:	0d913023          	sd	s9,192(sp)
    80003058:	0da13423          	sd	s10,200(sp)
    8000305c:	0db13823          	sd	s11,208(sp)
    80003060:	0dc13c23          	sd	t3,216(sp)
    80003064:	0fd13023          	sd	t4,224(sp)
    80003068:	0fe13423          	sd	t5,232(sp)
    8000306c:	0ff13823          	sd	t6,240(sp)
    80003070:	cc9ff0ef          	jal	ra,80002d38 <kerneltrap>
    80003074:	00013083          	ld	ra,0(sp)
    80003078:	00813103          	ld	sp,8(sp)
    8000307c:	01013183          	ld	gp,16(sp)
    80003080:	02013283          	ld	t0,32(sp)
    80003084:	02813303          	ld	t1,40(sp)
    80003088:	03013383          	ld	t2,48(sp)
    8000308c:	03813403          	ld	s0,56(sp)
    80003090:	04013483          	ld	s1,64(sp)
    80003094:	04813503          	ld	a0,72(sp)
    80003098:	05013583          	ld	a1,80(sp)
    8000309c:	05813603          	ld	a2,88(sp)
    800030a0:	06013683          	ld	a3,96(sp)
    800030a4:	06813703          	ld	a4,104(sp)
    800030a8:	07013783          	ld	a5,112(sp)
    800030ac:	07813803          	ld	a6,120(sp)
    800030b0:	08013883          	ld	a7,128(sp)
    800030b4:	08813903          	ld	s2,136(sp)
    800030b8:	09013983          	ld	s3,144(sp)
    800030bc:	09813a03          	ld	s4,152(sp)
    800030c0:	0a013a83          	ld	s5,160(sp)
    800030c4:	0a813b03          	ld	s6,168(sp)
    800030c8:	0b013b83          	ld	s7,176(sp)
    800030cc:	0b813c03          	ld	s8,184(sp)
    800030d0:	0c013c83          	ld	s9,192(sp)
    800030d4:	0c813d03          	ld	s10,200(sp)
    800030d8:	0d013d83          	ld	s11,208(sp)
    800030dc:	0d813e03          	ld	t3,216(sp)
    800030e0:	0e013e83          	ld	t4,224(sp)
    800030e4:	0e813f03          	ld	t5,232(sp)
    800030e8:	0f013f83          	ld	t6,240(sp)
    800030ec:	10010113          	addi	sp,sp,256
    800030f0:	10200073          	sret
    800030f4:	00000013          	nop
    800030f8:	00000013          	nop
    800030fc:	00000013          	nop

0000000080003100 <timervec>:
    80003100:	34051573          	csrrw	a0,mscratch,a0
    80003104:	00b53023          	sd	a1,0(a0)
    80003108:	00c53423          	sd	a2,8(a0)
    8000310c:	00d53823          	sd	a3,16(a0)
    80003110:	01853583          	ld	a1,24(a0)
    80003114:	02053603          	ld	a2,32(a0)
    80003118:	0005b683          	ld	a3,0(a1)
    8000311c:	00c686b3          	add	a3,a3,a2
    80003120:	00d5b023          	sd	a3,0(a1)
    80003124:	00200593          	li	a1,2
    80003128:	14459073          	csrw	sip,a1
    8000312c:	01053683          	ld	a3,16(a0)
    80003130:	00853603          	ld	a2,8(a0)
    80003134:	00053583          	ld	a1,0(a0)
    80003138:	34051573          	csrrw	a0,mscratch,a0
    8000313c:	30200073          	mret

0000000080003140 <plicinit>:
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00813423          	sd	s0,8(sp)
    80003148:	01010413          	addi	s0,sp,16
    8000314c:	00813403          	ld	s0,8(sp)
    80003150:	0c0007b7          	lui	a5,0xc000
    80003154:	00100713          	li	a4,1
    80003158:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000315c:	00e7a223          	sw	a4,4(a5)
    80003160:	01010113          	addi	sp,sp,16
    80003164:	00008067          	ret

0000000080003168 <plicinithart>:
    80003168:	ff010113          	addi	sp,sp,-16
    8000316c:	00813023          	sd	s0,0(sp)
    80003170:	00113423          	sd	ra,8(sp)
    80003174:	01010413          	addi	s0,sp,16
    80003178:	00000097          	auipc	ra,0x0
    8000317c:	a40080e7          	jalr	-1472(ra) # 80002bb8 <cpuid>
    80003180:	0085171b          	slliw	a4,a0,0x8
    80003184:	0c0027b7          	lui	a5,0xc002
    80003188:	00e787b3          	add	a5,a5,a4
    8000318c:	40200713          	li	a4,1026
    80003190:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003194:	00813083          	ld	ra,8(sp)
    80003198:	00013403          	ld	s0,0(sp)
    8000319c:	00d5151b          	slliw	a0,a0,0xd
    800031a0:	0c2017b7          	lui	a5,0xc201
    800031a4:	00a78533          	add	a0,a5,a0
    800031a8:	00052023          	sw	zero,0(a0)
    800031ac:	01010113          	addi	sp,sp,16
    800031b0:	00008067          	ret

00000000800031b4 <plic_claim>:
    800031b4:	ff010113          	addi	sp,sp,-16
    800031b8:	00813023          	sd	s0,0(sp)
    800031bc:	00113423          	sd	ra,8(sp)
    800031c0:	01010413          	addi	s0,sp,16
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	9f4080e7          	jalr	-1548(ra) # 80002bb8 <cpuid>
    800031cc:	00813083          	ld	ra,8(sp)
    800031d0:	00013403          	ld	s0,0(sp)
    800031d4:	00d5151b          	slliw	a0,a0,0xd
    800031d8:	0c2017b7          	lui	a5,0xc201
    800031dc:	00a78533          	add	a0,a5,a0
    800031e0:	00452503          	lw	a0,4(a0)
    800031e4:	01010113          	addi	sp,sp,16
    800031e8:	00008067          	ret

00000000800031ec <plic_complete>:
    800031ec:	fe010113          	addi	sp,sp,-32
    800031f0:	00813823          	sd	s0,16(sp)
    800031f4:	00913423          	sd	s1,8(sp)
    800031f8:	00113c23          	sd	ra,24(sp)
    800031fc:	02010413          	addi	s0,sp,32
    80003200:	00050493          	mv	s1,a0
    80003204:	00000097          	auipc	ra,0x0
    80003208:	9b4080e7          	jalr	-1612(ra) # 80002bb8 <cpuid>
    8000320c:	01813083          	ld	ra,24(sp)
    80003210:	01013403          	ld	s0,16(sp)
    80003214:	00d5179b          	slliw	a5,a0,0xd
    80003218:	0c201737          	lui	a4,0xc201
    8000321c:	00f707b3          	add	a5,a4,a5
    80003220:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003224:	00813483          	ld	s1,8(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <consolewrite>:
    80003230:	fb010113          	addi	sp,sp,-80
    80003234:	04813023          	sd	s0,64(sp)
    80003238:	04113423          	sd	ra,72(sp)
    8000323c:	02913c23          	sd	s1,56(sp)
    80003240:	03213823          	sd	s2,48(sp)
    80003244:	03313423          	sd	s3,40(sp)
    80003248:	03413023          	sd	s4,32(sp)
    8000324c:	01513c23          	sd	s5,24(sp)
    80003250:	05010413          	addi	s0,sp,80
    80003254:	06c05c63          	blez	a2,800032cc <consolewrite+0x9c>
    80003258:	00060993          	mv	s3,a2
    8000325c:	00050a13          	mv	s4,a0
    80003260:	00058493          	mv	s1,a1
    80003264:	00000913          	li	s2,0
    80003268:	fff00a93          	li	s5,-1
    8000326c:	01c0006f          	j	80003288 <consolewrite+0x58>
    80003270:	fbf44503          	lbu	a0,-65(s0)
    80003274:	0019091b          	addiw	s2,s2,1
    80003278:	00148493          	addi	s1,s1,1
    8000327c:	00001097          	auipc	ra,0x1
    80003280:	a9c080e7          	jalr	-1380(ra) # 80003d18 <uartputc>
    80003284:	03298063          	beq	s3,s2,800032a4 <consolewrite+0x74>
    80003288:	00048613          	mv	a2,s1
    8000328c:	00100693          	li	a3,1
    80003290:	000a0593          	mv	a1,s4
    80003294:	fbf40513          	addi	a0,s0,-65
    80003298:	00000097          	auipc	ra,0x0
    8000329c:	9d8080e7          	jalr	-1576(ra) # 80002c70 <either_copyin>
    800032a0:	fd5518e3          	bne	a0,s5,80003270 <consolewrite+0x40>
    800032a4:	04813083          	ld	ra,72(sp)
    800032a8:	04013403          	ld	s0,64(sp)
    800032ac:	03813483          	ld	s1,56(sp)
    800032b0:	02813983          	ld	s3,40(sp)
    800032b4:	02013a03          	ld	s4,32(sp)
    800032b8:	01813a83          	ld	s5,24(sp)
    800032bc:	00090513          	mv	a0,s2
    800032c0:	03013903          	ld	s2,48(sp)
    800032c4:	05010113          	addi	sp,sp,80
    800032c8:	00008067          	ret
    800032cc:	00000913          	li	s2,0
    800032d0:	fd5ff06f          	j	800032a4 <consolewrite+0x74>

00000000800032d4 <consoleread>:
    800032d4:	f9010113          	addi	sp,sp,-112
    800032d8:	06813023          	sd	s0,96(sp)
    800032dc:	04913c23          	sd	s1,88(sp)
    800032e0:	05213823          	sd	s2,80(sp)
    800032e4:	05313423          	sd	s3,72(sp)
    800032e8:	05413023          	sd	s4,64(sp)
    800032ec:	03513c23          	sd	s5,56(sp)
    800032f0:	03613823          	sd	s6,48(sp)
    800032f4:	03713423          	sd	s7,40(sp)
    800032f8:	03813023          	sd	s8,32(sp)
    800032fc:	06113423          	sd	ra,104(sp)
    80003300:	01913c23          	sd	s9,24(sp)
    80003304:	07010413          	addi	s0,sp,112
    80003308:	00060b93          	mv	s7,a2
    8000330c:	00050913          	mv	s2,a0
    80003310:	00058c13          	mv	s8,a1
    80003314:	00060b1b          	sext.w	s6,a2
    80003318:	00004497          	auipc	s1,0x4
    8000331c:	d0048493          	addi	s1,s1,-768 # 80007018 <cons>
    80003320:	00400993          	li	s3,4
    80003324:	fff00a13          	li	s4,-1
    80003328:	00a00a93          	li	s5,10
    8000332c:	05705e63          	blez	s7,80003388 <consoleread+0xb4>
    80003330:	09c4a703          	lw	a4,156(s1)
    80003334:	0984a783          	lw	a5,152(s1)
    80003338:	0007071b          	sext.w	a4,a4
    8000333c:	08e78463          	beq	a5,a4,800033c4 <consoleread+0xf0>
    80003340:	07f7f713          	andi	a4,a5,127
    80003344:	00e48733          	add	a4,s1,a4
    80003348:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000334c:	0017869b          	addiw	a3,a5,1
    80003350:	08d4ac23          	sw	a3,152(s1)
    80003354:	00070c9b          	sext.w	s9,a4
    80003358:	0b370663          	beq	a4,s3,80003404 <consoleread+0x130>
    8000335c:	00100693          	li	a3,1
    80003360:	f9f40613          	addi	a2,s0,-97
    80003364:	000c0593          	mv	a1,s8
    80003368:	00090513          	mv	a0,s2
    8000336c:	f8e40fa3          	sb	a4,-97(s0)
    80003370:	00000097          	auipc	ra,0x0
    80003374:	8b4080e7          	jalr	-1868(ra) # 80002c24 <either_copyout>
    80003378:	01450863          	beq	a0,s4,80003388 <consoleread+0xb4>
    8000337c:	001c0c13          	addi	s8,s8,1
    80003380:	fffb8b9b          	addiw	s7,s7,-1
    80003384:	fb5c94e3          	bne	s9,s5,8000332c <consoleread+0x58>
    80003388:	000b851b          	sext.w	a0,s7
    8000338c:	06813083          	ld	ra,104(sp)
    80003390:	06013403          	ld	s0,96(sp)
    80003394:	05813483          	ld	s1,88(sp)
    80003398:	05013903          	ld	s2,80(sp)
    8000339c:	04813983          	ld	s3,72(sp)
    800033a0:	04013a03          	ld	s4,64(sp)
    800033a4:	03813a83          	ld	s5,56(sp)
    800033a8:	02813b83          	ld	s7,40(sp)
    800033ac:	02013c03          	ld	s8,32(sp)
    800033b0:	01813c83          	ld	s9,24(sp)
    800033b4:	40ab053b          	subw	a0,s6,a0
    800033b8:	03013b03          	ld	s6,48(sp)
    800033bc:	07010113          	addi	sp,sp,112
    800033c0:	00008067          	ret
    800033c4:	00001097          	auipc	ra,0x1
    800033c8:	1d8080e7          	jalr	472(ra) # 8000459c <push_on>
    800033cc:	0984a703          	lw	a4,152(s1)
    800033d0:	09c4a783          	lw	a5,156(s1)
    800033d4:	0007879b          	sext.w	a5,a5
    800033d8:	fef70ce3          	beq	a4,a5,800033d0 <consoleread+0xfc>
    800033dc:	00001097          	auipc	ra,0x1
    800033e0:	234080e7          	jalr	564(ra) # 80004610 <pop_on>
    800033e4:	0984a783          	lw	a5,152(s1)
    800033e8:	07f7f713          	andi	a4,a5,127
    800033ec:	00e48733          	add	a4,s1,a4
    800033f0:	01874703          	lbu	a4,24(a4)
    800033f4:	0017869b          	addiw	a3,a5,1
    800033f8:	08d4ac23          	sw	a3,152(s1)
    800033fc:	00070c9b          	sext.w	s9,a4
    80003400:	f5371ee3          	bne	a4,s3,8000335c <consoleread+0x88>
    80003404:	000b851b          	sext.w	a0,s7
    80003408:	f96bf2e3          	bgeu	s7,s6,8000338c <consoleread+0xb8>
    8000340c:	08f4ac23          	sw	a5,152(s1)
    80003410:	f7dff06f          	j	8000338c <consoleread+0xb8>

0000000080003414 <consputc>:
    80003414:	10000793          	li	a5,256
    80003418:	00f50663          	beq	a0,a5,80003424 <consputc+0x10>
    8000341c:	00001317          	auipc	t1,0x1
    80003420:	9f430067          	jr	-1548(t1) # 80003e10 <uartputc_sync>
    80003424:	ff010113          	addi	sp,sp,-16
    80003428:	00113423          	sd	ra,8(sp)
    8000342c:	00813023          	sd	s0,0(sp)
    80003430:	01010413          	addi	s0,sp,16
    80003434:	00800513          	li	a0,8
    80003438:	00001097          	auipc	ra,0x1
    8000343c:	9d8080e7          	jalr	-1576(ra) # 80003e10 <uartputc_sync>
    80003440:	02000513          	li	a0,32
    80003444:	00001097          	auipc	ra,0x1
    80003448:	9cc080e7          	jalr	-1588(ra) # 80003e10 <uartputc_sync>
    8000344c:	00013403          	ld	s0,0(sp)
    80003450:	00813083          	ld	ra,8(sp)
    80003454:	00800513          	li	a0,8
    80003458:	01010113          	addi	sp,sp,16
    8000345c:	00001317          	auipc	t1,0x1
    80003460:	9b430067          	jr	-1612(t1) # 80003e10 <uartputc_sync>

0000000080003464 <consoleintr>:
    80003464:	fe010113          	addi	sp,sp,-32
    80003468:	00813823          	sd	s0,16(sp)
    8000346c:	00913423          	sd	s1,8(sp)
    80003470:	01213023          	sd	s2,0(sp)
    80003474:	00113c23          	sd	ra,24(sp)
    80003478:	02010413          	addi	s0,sp,32
    8000347c:	00004917          	auipc	s2,0x4
    80003480:	b9c90913          	addi	s2,s2,-1124 # 80007018 <cons>
    80003484:	00050493          	mv	s1,a0
    80003488:	00090513          	mv	a0,s2
    8000348c:	00001097          	auipc	ra,0x1
    80003490:	e40080e7          	jalr	-448(ra) # 800042cc <acquire>
    80003494:	02048c63          	beqz	s1,800034cc <consoleintr+0x68>
    80003498:	0a092783          	lw	a5,160(s2)
    8000349c:	09892703          	lw	a4,152(s2)
    800034a0:	07f00693          	li	a3,127
    800034a4:	40e7873b          	subw	a4,a5,a4
    800034a8:	02e6e263          	bltu	a3,a4,800034cc <consoleintr+0x68>
    800034ac:	00d00713          	li	a4,13
    800034b0:	04e48063          	beq	s1,a4,800034f0 <consoleintr+0x8c>
    800034b4:	07f7f713          	andi	a4,a5,127
    800034b8:	00e90733          	add	a4,s2,a4
    800034bc:	0017879b          	addiw	a5,a5,1
    800034c0:	0af92023          	sw	a5,160(s2)
    800034c4:	00970c23          	sb	s1,24(a4)
    800034c8:	08f92e23          	sw	a5,156(s2)
    800034cc:	01013403          	ld	s0,16(sp)
    800034d0:	01813083          	ld	ra,24(sp)
    800034d4:	00813483          	ld	s1,8(sp)
    800034d8:	00013903          	ld	s2,0(sp)
    800034dc:	00004517          	auipc	a0,0x4
    800034e0:	b3c50513          	addi	a0,a0,-1220 # 80007018 <cons>
    800034e4:	02010113          	addi	sp,sp,32
    800034e8:	00001317          	auipc	t1,0x1
    800034ec:	eb030067          	jr	-336(t1) # 80004398 <release>
    800034f0:	00a00493          	li	s1,10
    800034f4:	fc1ff06f          	j	800034b4 <consoleintr+0x50>

00000000800034f8 <consoleinit>:
    800034f8:	fe010113          	addi	sp,sp,-32
    800034fc:	00113c23          	sd	ra,24(sp)
    80003500:	00813823          	sd	s0,16(sp)
    80003504:	00913423          	sd	s1,8(sp)
    80003508:	02010413          	addi	s0,sp,32
    8000350c:	00004497          	auipc	s1,0x4
    80003510:	b0c48493          	addi	s1,s1,-1268 # 80007018 <cons>
    80003514:	00048513          	mv	a0,s1
    80003518:	00002597          	auipc	a1,0x2
    8000351c:	d4058593          	addi	a1,a1,-704 # 80005258 <_ZZ12printIntegermE6digits+0x138>
    80003520:	00001097          	auipc	ra,0x1
    80003524:	d88080e7          	jalr	-632(ra) # 800042a8 <initlock>
    80003528:	00000097          	auipc	ra,0x0
    8000352c:	7ac080e7          	jalr	1964(ra) # 80003cd4 <uartinit>
    80003530:	01813083          	ld	ra,24(sp)
    80003534:	01013403          	ld	s0,16(sp)
    80003538:	00000797          	auipc	a5,0x0
    8000353c:	d9c78793          	addi	a5,a5,-612 # 800032d4 <consoleread>
    80003540:	0af4bc23          	sd	a5,184(s1)
    80003544:	00000797          	auipc	a5,0x0
    80003548:	cec78793          	addi	a5,a5,-788 # 80003230 <consolewrite>
    8000354c:	0cf4b023          	sd	a5,192(s1)
    80003550:	00813483          	ld	s1,8(sp)
    80003554:	02010113          	addi	sp,sp,32
    80003558:	00008067          	ret

000000008000355c <console_read>:
    8000355c:	ff010113          	addi	sp,sp,-16
    80003560:	00813423          	sd	s0,8(sp)
    80003564:	01010413          	addi	s0,sp,16
    80003568:	00813403          	ld	s0,8(sp)
    8000356c:	00004317          	auipc	t1,0x4
    80003570:	b6433303          	ld	t1,-1180(t1) # 800070d0 <devsw+0x10>
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00030067          	jr	t1

000000008000357c <console_write>:
    8000357c:	ff010113          	addi	sp,sp,-16
    80003580:	00813423          	sd	s0,8(sp)
    80003584:	01010413          	addi	s0,sp,16
    80003588:	00813403          	ld	s0,8(sp)
    8000358c:	00004317          	auipc	t1,0x4
    80003590:	b4c33303          	ld	t1,-1204(t1) # 800070d8 <devsw+0x18>
    80003594:	01010113          	addi	sp,sp,16
    80003598:	00030067          	jr	t1

000000008000359c <panic>:
    8000359c:	fe010113          	addi	sp,sp,-32
    800035a0:	00113c23          	sd	ra,24(sp)
    800035a4:	00813823          	sd	s0,16(sp)
    800035a8:	00913423          	sd	s1,8(sp)
    800035ac:	02010413          	addi	s0,sp,32
    800035b0:	00050493          	mv	s1,a0
    800035b4:	00002517          	auipc	a0,0x2
    800035b8:	cac50513          	addi	a0,a0,-852 # 80005260 <_ZZ12printIntegermE6digits+0x140>
    800035bc:	00004797          	auipc	a5,0x4
    800035c0:	ba07ae23          	sw	zero,-1092(a5) # 80007178 <pr+0x18>
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	034080e7          	jalr	52(ra) # 800035f8 <__printf>
    800035cc:	00048513          	mv	a0,s1
    800035d0:	00000097          	auipc	ra,0x0
    800035d4:	028080e7          	jalr	40(ra) # 800035f8 <__printf>
    800035d8:	00002517          	auipc	a0,0x2
    800035dc:	c6850513          	addi	a0,a0,-920 # 80005240 <_ZZ12printIntegermE6digits+0x120>
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	018080e7          	jalr	24(ra) # 800035f8 <__printf>
    800035e8:	00100793          	li	a5,1
    800035ec:	00003717          	auipc	a4,0x3
    800035f0:	8ef72623          	sw	a5,-1812(a4) # 80005ed8 <panicked>
    800035f4:	0000006f          	j	800035f4 <panic+0x58>

00000000800035f8 <__printf>:
    800035f8:	f3010113          	addi	sp,sp,-208
    800035fc:	08813023          	sd	s0,128(sp)
    80003600:	07313423          	sd	s3,104(sp)
    80003604:	09010413          	addi	s0,sp,144
    80003608:	05813023          	sd	s8,64(sp)
    8000360c:	08113423          	sd	ra,136(sp)
    80003610:	06913c23          	sd	s1,120(sp)
    80003614:	07213823          	sd	s2,112(sp)
    80003618:	07413023          	sd	s4,96(sp)
    8000361c:	05513c23          	sd	s5,88(sp)
    80003620:	05613823          	sd	s6,80(sp)
    80003624:	05713423          	sd	s7,72(sp)
    80003628:	03913c23          	sd	s9,56(sp)
    8000362c:	03a13823          	sd	s10,48(sp)
    80003630:	03b13423          	sd	s11,40(sp)
    80003634:	00004317          	auipc	t1,0x4
    80003638:	b2c30313          	addi	t1,t1,-1236 # 80007160 <pr>
    8000363c:	01832c03          	lw	s8,24(t1)
    80003640:	00b43423          	sd	a1,8(s0)
    80003644:	00c43823          	sd	a2,16(s0)
    80003648:	00d43c23          	sd	a3,24(s0)
    8000364c:	02e43023          	sd	a4,32(s0)
    80003650:	02f43423          	sd	a5,40(s0)
    80003654:	03043823          	sd	a6,48(s0)
    80003658:	03143c23          	sd	a7,56(s0)
    8000365c:	00050993          	mv	s3,a0
    80003660:	4a0c1663          	bnez	s8,80003b0c <__printf+0x514>
    80003664:	60098c63          	beqz	s3,80003c7c <__printf+0x684>
    80003668:	0009c503          	lbu	a0,0(s3)
    8000366c:	00840793          	addi	a5,s0,8
    80003670:	f6f43c23          	sd	a5,-136(s0)
    80003674:	00000493          	li	s1,0
    80003678:	22050063          	beqz	a0,80003898 <__printf+0x2a0>
    8000367c:	00002a37          	lui	s4,0x2
    80003680:	00018ab7          	lui	s5,0x18
    80003684:	000f4b37          	lui	s6,0xf4
    80003688:	00989bb7          	lui	s7,0x989
    8000368c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003690:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003694:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003698:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000369c:	00148c9b          	addiw	s9,s1,1
    800036a0:	02500793          	li	a5,37
    800036a4:	01998933          	add	s2,s3,s9
    800036a8:	38f51263          	bne	a0,a5,80003a2c <__printf+0x434>
    800036ac:	00094783          	lbu	a5,0(s2)
    800036b0:	00078c9b          	sext.w	s9,a5
    800036b4:	1e078263          	beqz	a5,80003898 <__printf+0x2a0>
    800036b8:	0024849b          	addiw	s1,s1,2
    800036bc:	07000713          	li	a4,112
    800036c0:	00998933          	add	s2,s3,s1
    800036c4:	38e78a63          	beq	a5,a4,80003a58 <__printf+0x460>
    800036c8:	20f76863          	bltu	a4,a5,800038d8 <__printf+0x2e0>
    800036cc:	42a78863          	beq	a5,a0,80003afc <__printf+0x504>
    800036d0:	06400713          	li	a4,100
    800036d4:	40e79663          	bne	a5,a4,80003ae0 <__printf+0x4e8>
    800036d8:	f7843783          	ld	a5,-136(s0)
    800036dc:	0007a603          	lw	a2,0(a5)
    800036e0:	00878793          	addi	a5,a5,8
    800036e4:	f6f43c23          	sd	a5,-136(s0)
    800036e8:	42064a63          	bltz	a2,80003b1c <__printf+0x524>
    800036ec:	00a00713          	li	a4,10
    800036f0:	02e677bb          	remuw	a5,a2,a4
    800036f4:	00002d97          	auipc	s11,0x2
    800036f8:	b94d8d93          	addi	s11,s11,-1132 # 80005288 <digits>
    800036fc:	00900593          	li	a1,9
    80003700:	0006051b          	sext.w	a0,a2
    80003704:	00000c93          	li	s9,0
    80003708:	02079793          	slli	a5,a5,0x20
    8000370c:	0207d793          	srli	a5,a5,0x20
    80003710:	00fd87b3          	add	a5,s11,a5
    80003714:	0007c783          	lbu	a5,0(a5)
    80003718:	02e656bb          	divuw	a3,a2,a4
    8000371c:	f8f40023          	sb	a5,-128(s0)
    80003720:	14c5d863          	bge	a1,a2,80003870 <__printf+0x278>
    80003724:	06300593          	li	a1,99
    80003728:	00100c93          	li	s9,1
    8000372c:	02e6f7bb          	remuw	a5,a3,a4
    80003730:	02079793          	slli	a5,a5,0x20
    80003734:	0207d793          	srli	a5,a5,0x20
    80003738:	00fd87b3          	add	a5,s11,a5
    8000373c:	0007c783          	lbu	a5,0(a5)
    80003740:	02e6d73b          	divuw	a4,a3,a4
    80003744:	f8f400a3          	sb	a5,-127(s0)
    80003748:	12a5f463          	bgeu	a1,a0,80003870 <__printf+0x278>
    8000374c:	00a00693          	li	a3,10
    80003750:	00900593          	li	a1,9
    80003754:	02d777bb          	remuw	a5,a4,a3
    80003758:	02079793          	slli	a5,a5,0x20
    8000375c:	0207d793          	srli	a5,a5,0x20
    80003760:	00fd87b3          	add	a5,s11,a5
    80003764:	0007c503          	lbu	a0,0(a5)
    80003768:	02d757bb          	divuw	a5,a4,a3
    8000376c:	f8a40123          	sb	a0,-126(s0)
    80003770:	48e5f263          	bgeu	a1,a4,80003bf4 <__printf+0x5fc>
    80003774:	06300513          	li	a0,99
    80003778:	02d7f5bb          	remuw	a1,a5,a3
    8000377c:	02059593          	slli	a1,a1,0x20
    80003780:	0205d593          	srli	a1,a1,0x20
    80003784:	00bd85b3          	add	a1,s11,a1
    80003788:	0005c583          	lbu	a1,0(a1)
    8000378c:	02d7d7bb          	divuw	a5,a5,a3
    80003790:	f8b401a3          	sb	a1,-125(s0)
    80003794:	48e57263          	bgeu	a0,a4,80003c18 <__printf+0x620>
    80003798:	3e700513          	li	a0,999
    8000379c:	02d7f5bb          	remuw	a1,a5,a3
    800037a0:	02059593          	slli	a1,a1,0x20
    800037a4:	0205d593          	srli	a1,a1,0x20
    800037a8:	00bd85b3          	add	a1,s11,a1
    800037ac:	0005c583          	lbu	a1,0(a1)
    800037b0:	02d7d7bb          	divuw	a5,a5,a3
    800037b4:	f8b40223          	sb	a1,-124(s0)
    800037b8:	46e57663          	bgeu	a0,a4,80003c24 <__printf+0x62c>
    800037bc:	02d7f5bb          	remuw	a1,a5,a3
    800037c0:	02059593          	slli	a1,a1,0x20
    800037c4:	0205d593          	srli	a1,a1,0x20
    800037c8:	00bd85b3          	add	a1,s11,a1
    800037cc:	0005c583          	lbu	a1,0(a1)
    800037d0:	02d7d7bb          	divuw	a5,a5,a3
    800037d4:	f8b402a3          	sb	a1,-123(s0)
    800037d8:	46ea7863          	bgeu	s4,a4,80003c48 <__printf+0x650>
    800037dc:	02d7f5bb          	remuw	a1,a5,a3
    800037e0:	02059593          	slli	a1,a1,0x20
    800037e4:	0205d593          	srli	a1,a1,0x20
    800037e8:	00bd85b3          	add	a1,s11,a1
    800037ec:	0005c583          	lbu	a1,0(a1)
    800037f0:	02d7d7bb          	divuw	a5,a5,a3
    800037f4:	f8b40323          	sb	a1,-122(s0)
    800037f8:	3eeaf863          	bgeu	s5,a4,80003be8 <__printf+0x5f0>
    800037fc:	02d7f5bb          	remuw	a1,a5,a3
    80003800:	02059593          	slli	a1,a1,0x20
    80003804:	0205d593          	srli	a1,a1,0x20
    80003808:	00bd85b3          	add	a1,s11,a1
    8000380c:	0005c583          	lbu	a1,0(a1)
    80003810:	02d7d7bb          	divuw	a5,a5,a3
    80003814:	f8b403a3          	sb	a1,-121(s0)
    80003818:	42eb7e63          	bgeu	s6,a4,80003c54 <__printf+0x65c>
    8000381c:	02d7f5bb          	remuw	a1,a5,a3
    80003820:	02059593          	slli	a1,a1,0x20
    80003824:	0205d593          	srli	a1,a1,0x20
    80003828:	00bd85b3          	add	a1,s11,a1
    8000382c:	0005c583          	lbu	a1,0(a1)
    80003830:	02d7d7bb          	divuw	a5,a5,a3
    80003834:	f8b40423          	sb	a1,-120(s0)
    80003838:	42ebfc63          	bgeu	s7,a4,80003c70 <__printf+0x678>
    8000383c:	02079793          	slli	a5,a5,0x20
    80003840:	0207d793          	srli	a5,a5,0x20
    80003844:	00fd8db3          	add	s11,s11,a5
    80003848:	000dc703          	lbu	a4,0(s11)
    8000384c:	00a00793          	li	a5,10
    80003850:	00900c93          	li	s9,9
    80003854:	f8e404a3          	sb	a4,-119(s0)
    80003858:	00065c63          	bgez	a2,80003870 <__printf+0x278>
    8000385c:	f9040713          	addi	a4,s0,-112
    80003860:	00f70733          	add	a4,a4,a5
    80003864:	02d00693          	li	a3,45
    80003868:	fed70823          	sb	a3,-16(a4)
    8000386c:	00078c93          	mv	s9,a5
    80003870:	f8040793          	addi	a5,s0,-128
    80003874:	01978cb3          	add	s9,a5,s9
    80003878:	f7f40d13          	addi	s10,s0,-129
    8000387c:	000cc503          	lbu	a0,0(s9)
    80003880:	fffc8c93          	addi	s9,s9,-1
    80003884:	00000097          	auipc	ra,0x0
    80003888:	b90080e7          	jalr	-1136(ra) # 80003414 <consputc>
    8000388c:	ffac98e3          	bne	s9,s10,8000387c <__printf+0x284>
    80003890:	00094503          	lbu	a0,0(s2)
    80003894:	e00514e3          	bnez	a0,8000369c <__printf+0xa4>
    80003898:	1a0c1663          	bnez	s8,80003a44 <__printf+0x44c>
    8000389c:	08813083          	ld	ra,136(sp)
    800038a0:	08013403          	ld	s0,128(sp)
    800038a4:	07813483          	ld	s1,120(sp)
    800038a8:	07013903          	ld	s2,112(sp)
    800038ac:	06813983          	ld	s3,104(sp)
    800038b0:	06013a03          	ld	s4,96(sp)
    800038b4:	05813a83          	ld	s5,88(sp)
    800038b8:	05013b03          	ld	s6,80(sp)
    800038bc:	04813b83          	ld	s7,72(sp)
    800038c0:	04013c03          	ld	s8,64(sp)
    800038c4:	03813c83          	ld	s9,56(sp)
    800038c8:	03013d03          	ld	s10,48(sp)
    800038cc:	02813d83          	ld	s11,40(sp)
    800038d0:	0d010113          	addi	sp,sp,208
    800038d4:	00008067          	ret
    800038d8:	07300713          	li	a4,115
    800038dc:	1ce78a63          	beq	a5,a4,80003ab0 <__printf+0x4b8>
    800038e0:	07800713          	li	a4,120
    800038e4:	1ee79e63          	bne	a5,a4,80003ae0 <__printf+0x4e8>
    800038e8:	f7843783          	ld	a5,-136(s0)
    800038ec:	0007a703          	lw	a4,0(a5)
    800038f0:	00878793          	addi	a5,a5,8
    800038f4:	f6f43c23          	sd	a5,-136(s0)
    800038f8:	28074263          	bltz	a4,80003b7c <__printf+0x584>
    800038fc:	00002d97          	auipc	s11,0x2
    80003900:	98cd8d93          	addi	s11,s11,-1652 # 80005288 <digits>
    80003904:	00f77793          	andi	a5,a4,15
    80003908:	00fd87b3          	add	a5,s11,a5
    8000390c:	0007c683          	lbu	a3,0(a5)
    80003910:	00f00613          	li	a2,15
    80003914:	0007079b          	sext.w	a5,a4
    80003918:	f8d40023          	sb	a3,-128(s0)
    8000391c:	0047559b          	srliw	a1,a4,0x4
    80003920:	0047569b          	srliw	a3,a4,0x4
    80003924:	00000c93          	li	s9,0
    80003928:	0ee65063          	bge	a2,a4,80003a08 <__printf+0x410>
    8000392c:	00f6f693          	andi	a3,a3,15
    80003930:	00dd86b3          	add	a3,s11,a3
    80003934:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003938:	0087d79b          	srliw	a5,a5,0x8
    8000393c:	00100c93          	li	s9,1
    80003940:	f8d400a3          	sb	a3,-127(s0)
    80003944:	0cb67263          	bgeu	a2,a1,80003a08 <__printf+0x410>
    80003948:	00f7f693          	andi	a3,a5,15
    8000394c:	00dd86b3          	add	a3,s11,a3
    80003950:	0006c583          	lbu	a1,0(a3)
    80003954:	00f00613          	li	a2,15
    80003958:	0047d69b          	srliw	a3,a5,0x4
    8000395c:	f8b40123          	sb	a1,-126(s0)
    80003960:	0047d593          	srli	a1,a5,0x4
    80003964:	28f67e63          	bgeu	a2,a5,80003c00 <__printf+0x608>
    80003968:	00f6f693          	andi	a3,a3,15
    8000396c:	00dd86b3          	add	a3,s11,a3
    80003970:	0006c503          	lbu	a0,0(a3)
    80003974:	0087d813          	srli	a6,a5,0x8
    80003978:	0087d69b          	srliw	a3,a5,0x8
    8000397c:	f8a401a3          	sb	a0,-125(s0)
    80003980:	28b67663          	bgeu	a2,a1,80003c0c <__printf+0x614>
    80003984:	00f6f693          	andi	a3,a3,15
    80003988:	00dd86b3          	add	a3,s11,a3
    8000398c:	0006c583          	lbu	a1,0(a3)
    80003990:	00c7d513          	srli	a0,a5,0xc
    80003994:	00c7d69b          	srliw	a3,a5,0xc
    80003998:	f8b40223          	sb	a1,-124(s0)
    8000399c:	29067a63          	bgeu	a2,a6,80003c30 <__printf+0x638>
    800039a0:	00f6f693          	andi	a3,a3,15
    800039a4:	00dd86b3          	add	a3,s11,a3
    800039a8:	0006c583          	lbu	a1,0(a3)
    800039ac:	0107d813          	srli	a6,a5,0x10
    800039b0:	0107d69b          	srliw	a3,a5,0x10
    800039b4:	f8b402a3          	sb	a1,-123(s0)
    800039b8:	28a67263          	bgeu	a2,a0,80003c3c <__printf+0x644>
    800039bc:	00f6f693          	andi	a3,a3,15
    800039c0:	00dd86b3          	add	a3,s11,a3
    800039c4:	0006c683          	lbu	a3,0(a3)
    800039c8:	0147d79b          	srliw	a5,a5,0x14
    800039cc:	f8d40323          	sb	a3,-122(s0)
    800039d0:	21067663          	bgeu	a2,a6,80003bdc <__printf+0x5e4>
    800039d4:	02079793          	slli	a5,a5,0x20
    800039d8:	0207d793          	srli	a5,a5,0x20
    800039dc:	00fd8db3          	add	s11,s11,a5
    800039e0:	000dc683          	lbu	a3,0(s11)
    800039e4:	00800793          	li	a5,8
    800039e8:	00700c93          	li	s9,7
    800039ec:	f8d403a3          	sb	a3,-121(s0)
    800039f0:	00075c63          	bgez	a4,80003a08 <__printf+0x410>
    800039f4:	f9040713          	addi	a4,s0,-112
    800039f8:	00f70733          	add	a4,a4,a5
    800039fc:	02d00693          	li	a3,45
    80003a00:	fed70823          	sb	a3,-16(a4)
    80003a04:	00078c93          	mv	s9,a5
    80003a08:	f8040793          	addi	a5,s0,-128
    80003a0c:	01978cb3          	add	s9,a5,s9
    80003a10:	f7f40d13          	addi	s10,s0,-129
    80003a14:	000cc503          	lbu	a0,0(s9)
    80003a18:	fffc8c93          	addi	s9,s9,-1
    80003a1c:	00000097          	auipc	ra,0x0
    80003a20:	9f8080e7          	jalr	-1544(ra) # 80003414 <consputc>
    80003a24:	ff9d18e3          	bne	s10,s9,80003a14 <__printf+0x41c>
    80003a28:	0100006f          	j	80003a38 <__printf+0x440>
    80003a2c:	00000097          	auipc	ra,0x0
    80003a30:	9e8080e7          	jalr	-1560(ra) # 80003414 <consputc>
    80003a34:	000c8493          	mv	s1,s9
    80003a38:	00094503          	lbu	a0,0(s2)
    80003a3c:	c60510e3          	bnez	a0,8000369c <__printf+0xa4>
    80003a40:	e40c0ee3          	beqz	s8,8000389c <__printf+0x2a4>
    80003a44:	00003517          	auipc	a0,0x3
    80003a48:	71c50513          	addi	a0,a0,1820 # 80007160 <pr>
    80003a4c:	00001097          	auipc	ra,0x1
    80003a50:	94c080e7          	jalr	-1716(ra) # 80004398 <release>
    80003a54:	e49ff06f          	j	8000389c <__printf+0x2a4>
    80003a58:	f7843783          	ld	a5,-136(s0)
    80003a5c:	03000513          	li	a0,48
    80003a60:	01000d13          	li	s10,16
    80003a64:	00878713          	addi	a4,a5,8
    80003a68:	0007bc83          	ld	s9,0(a5)
    80003a6c:	f6e43c23          	sd	a4,-136(s0)
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	9a4080e7          	jalr	-1628(ra) # 80003414 <consputc>
    80003a78:	07800513          	li	a0,120
    80003a7c:	00000097          	auipc	ra,0x0
    80003a80:	998080e7          	jalr	-1640(ra) # 80003414 <consputc>
    80003a84:	00002d97          	auipc	s11,0x2
    80003a88:	804d8d93          	addi	s11,s11,-2044 # 80005288 <digits>
    80003a8c:	03ccd793          	srli	a5,s9,0x3c
    80003a90:	00fd87b3          	add	a5,s11,a5
    80003a94:	0007c503          	lbu	a0,0(a5)
    80003a98:	fffd0d1b          	addiw	s10,s10,-1
    80003a9c:	004c9c93          	slli	s9,s9,0x4
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	974080e7          	jalr	-1676(ra) # 80003414 <consputc>
    80003aa8:	fe0d12e3          	bnez	s10,80003a8c <__printf+0x494>
    80003aac:	f8dff06f          	j	80003a38 <__printf+0x440>
    80003ab0:	f7843783          	ld	a5,-136(s0)
    80003ab4:	0007bc83          	ld	s9,0(a5)
    80003ab8:	00878793          	addi	a5,a5,8
    80003abc:	f6f43c23          	sd	a5,-136(s0)
    80003ac0:	000c9a63          	bnez	s9,80003ad4 <__printf+0x4dc>
    80003ac4:	1080006f          	j	80003bcc <__printf+0x5d4>
    80003ac8:	001c8c93          	addi	s9,s9,1
    80003acc:	00000097          	auipc	ra,0x0
    80003ad0:	948080e7          	jalr	-1720(ra) # 80003414 <consputc>
    80003ad4:	000cc503          	lbu	a0,0(s9)
    80003ad8:	fe0518e3          	bnez	a0,80003ac8 <__printf+0x4d0>
    80003adc:	f5dff06f          	j	80003a38 <__printf+0x440>
    80003ae0:	02500513          	li	a0,37
    80003ae4:	00000097          	auipc	ra,0x0
    80003ae8:	930080e7          	jalr	-1744(ra) # 80003414 <consputc>
    80003aec:	000c8513          	mv	a0,s9
    80003af0:	00000097          	auipc	ra,0x0
    80003af4:	924080e7          	jalr	-1756(ra) # 80003414 <consputc>
    80003af8:	f41ff06f          	j	80003a38 <__printf+0x440>
    80003afc:	02500513          	li	a0,37
    80003b00:	00000097          	auipc	ra,0x0
    80003b04:	914080e7          	jalr	-1772(ra) # 80003414 <consputc>
    80003b08:	f31ff06f          	j	80003a38 <__printf+0x440>
    80003b0c:	00030513          	mv	a0,t1
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	7bc080e7          	jalr	1980(ra) # 800042cc <acquire>
    80003b18:	b4dff06f          	j	80003664 <__printf+0x6c>
    80003b1c:	40c0053b          	negw	a0,a2
    80003b20:	00a00713          	li	a4,10
    80003b24:	02e576bb          	remuw	a3,a0,a4
    80003b28:	00001d97          	auipc	s11,0x1
    80003b2c:	760d8d93          	addi	s11,s11,1888 # 80005288 <digits>
    80003b30:	ff700593          	li	a1,-9
    80003b34:	02069693          	slli	a3,a3,0x20
    80003b38:	0206d693          	srli	a3,a3,0x20
    80003b3c:	00dd86b3          	add	a3,s11,a3
    80003b40:	0006c683          	lbu	a3,0(a3)
    80003b44:	02e557bb          	divuw	a5,a0,a4
    80003b48:	f8d40023          	sb	a3,-128(s0)
    80003b4c:	10b65e63          	bge	a2,a1,80003c68 <__printf+0x670>
    80003b50:	06300593          	li	a1,99
    80003b54:	02e7f6bb          	remuw	a3,a5,a4
    80003b58:	02069693          	slli	a3,a3,0x20
    80003b5c:	0206d693          	srli	a3,a3,0x20
    80003b60:	00dd86b3          	add	a3,s11,a3
    80003b64:	0006c683          	lbu	a3,0(a3)
    80003b68:	02e7d73b          	divuw	a4,a5,a4
    80003b6c:	00200793          	li	a5,2
    80003b70:	f8d400a3          	sb	a3,-127(s0)
    80003b74:	bca5ece3          	bltu	a1,a0,8000374c <__printf+0x154>
    80003b78:	ce5ff06f          	j	8000385c <__printf+0x264>
    80003b7c:	40e007bb          	negw	a5,a4
    80003b80:	00001d97          	auipc	s11,0x1
    80003b84:	708d8d93          	addi	s11,s11,1800 # 80005288 <digits>
    80003b88:	00f7f693          	andi	a3,a5,15
    80003b8c:	00dd86b3          	add	a3,s11,a3
    80003b90:	0006c583          	lbu	a1,0(a3)
    80003b94:	ff100613          	li	a2,-15
    80003b98:	0047d69b          	srliw	a3,a5,0x4
    80003b9c:	f8b40023          	sb	a1,-128(s0)
    80003ba0:	0047d59b          	srliw	a1,a5,0x4
    80003ba4:	0ac75e63          	bge	a4,a2,80003c60 <__printf+0x668>
    80003ba8:	00f6f693          	andi	a3,a3,15
    80003bac:	00dd86b3          	add	a3,s11,a3
    80003bb0:	0006c603          	lbu	a2,0(a3)
    80003bb4:	00f00693          	li	a3,15
    80003bb8:	0087d79b          	srliw	a5,a5,0x8
    80003bbc:	f8c400a3          	sb	a2,-127(s0)
    80003bc0:	d8b6e4e3          	bltu	a3,a1,80003948 <__printf+0x350>
    80003bc4:	00200793          	li	a5,2
    80003bc8:	e2dff06f          	j	800039f4 <__printf+0x3fc>
    80003bcc:	00001c97          	auipc	s9,0x1
    80003bd0:	69cc8c93          	addi	s9,s9,1692 # 80005268 <_ZZ12printIntegermE6digits+0x148>
    80003bd4:	02800513          	li	a0,40
    80003bd8:	ef1ff06f          	j	80003ac8 <__printf+0x4d0>
    80003bdc:	00700793          	li	a5,7
    80003be0:	00600c93          	li	s9,6
    80003be4:	e0dff06f          	j	800039f0 <__printf+0x3f8>
    80003be8:	00700793          	li	a5,7
    80003bec:	00600c93          	li	s9,6
    80003bf0:	c69ff06f          	j	80003858 <__printf+0x260>
    80003bf4:	00300793          	li	a5,3
    80003bf8:	00200c93          	li	s9,2
    80003bfc:	c5dff06f          	j	80003858 <__printf+0x260>
    80003c00:	00300793          	li	a5,3
    80003c04:	00200c93          	li	s9,2
    80003c08:	de9ff06f          	j	800039f0 <__printf+0x3f8>
    80003c0c:	00400793          	li	a5,4
    80003c10:	00300c93          	li	s9,3
    80003c14:	dddff06f          	j	800039f0 <__printf+0x3f8>
    80003c18:	00400793          	li	a5,4
    80003c1c:	00300c93          	li	s9,3
    80003c20:	c39ff06f          	j	80003858 <__printf+0x260>
    80003c24:	00500793          	li	a5,5
    80003c28:	00400c93          	li	s9,4
    80003c2c:	c2dff06f          	j	80003858 <__printf+0x260>
    80003c30:	00500793          	li	a5,5
    80003c34:	00400c93          	li	s9,4
    80003c38:	db9ff06f          	j	800039f0 <__printf+0x3f8>
    80003c3c:	00600793          	li	a5,6
    80003c40:	00500c93          	li	s9,5
    80003c44:	dadff06f          	j	800039f0 <__printf+0x3f8>
    80003c48:	00600793          	li	a5,6
    80003c4c:	00500c93          	li	s9,5
    80003c50:	c09ff06f          	j	80003858 <__printf+0x260>
    80003c54:	00800793          	li	a5,8
    80003c58:	00700c93          	li	s9,7
    80003c5c:	bfdff06f          	j	80003858 <__printf+0x260>
    80003c60:	00100793          	li	a5,1
    80003c64:	d91ff06f          	j	800039f4 <__printf+0x3fc>
    80003c68:	00100793          	li	a5,1
    80003c6c:	bf1ff06f          	j	8000385c <__printf+0x264>
    80003c70:	00900793          	li	a5,9
    80003c74:	00800c93          	li	s9,8
    80003c78:	be1ff06f          	j	80003858 <__printf+0x260>
    80003c7c:	00001517          	auipc	a0,0x1
    80003c80:	5f450513          	addi	a0,a0,1524 # 80005270 <_ZZ12printIntegermE6digits+0x150>
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	918080e7          	jalr	-1768(ra) # 8000359c <panic>

0000000080003c8c <printfinit>:
    80003c8c:	fe010113          	addi	sp,sp,-32
    80003c90:	00813823          	sd	s0,16(sp)
    80003c94:	00913423          	sd	s1,8(sp)
    80003c98:	00113c23          	sd	ra,24(sp)
    80003c9c:	02010413          	addi	s0,sp,32
    80003ca0:	00003497          	auipc	s1,0x3
    80003ca4:	4c048493          	addi	s1,s1,1216 # 80007160 <pr>
    80003ca8:	00048513          	mv	a0,s1
    80003cac:	00001597          	auipc	a1,0x1
    80003cb0:	5d458593          	addi	a1,a1,1492 # 80005280 <_ZZ12printIntegermE6digits+0x160>
    80003cb4:	00000097          	auipc	ra,0x0
    80003cb8:	5f4080e7          	jalr	1524(ra) # 800042a8 <initlock>
    80003cbc:	01813083          	ld	ra,24(sp)
    80003cc0:	01013403          	ld	s0,16(sp)
    80003cc4:	0004ac23          	sw	zero,24(s1)
    80003cc8:	00813483          	ld	s1,8(sp)
    80003ccc:	02010113          	addi	sp,sp,32
    80003cd0:	00008067          	ret

0000000080003cd4 <uartinit>:
    80003cd4:	ff010113          	addi	sp,sp,-16
    80003cd8:	00813423          	sd	s0,8(sp)
    80003cdc:	01010413          	addi	s0,sp,16
    80003ce0:	100007b7          	lui	a5,0x10000
    80003ce4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003ce8:	f8000713          	li	a4,-128
    80003cec:	00e781a3          	sb	a4,3(a5)
    80003cf0:	00300713          	li	a4,3
    80003cf4:	00e78023          	sb	a4,0(a5)
    80003cf8:	000780a3          	sb	zero,1(a5)
    80003cfc:	00e781a3          	sb	a4,3(a5)
    80003d00:	00700693          	li	a3,7
    80003d04:	00d78123          	sb	a3,2(a5)
    80003d08:	00e780a3          	sb	a4,1(a5)
    80003d0c:	00813403          	ld	s0,8(sp)
    80003d10:	01010113          	addi	sp,sp,16
    80003d14:	00008067          	ret

0000000080003d18 <uartputc>:
    80003d18:	00002797          	auipc	a5,0x2
    80003d1c:	1c07a783          	lw	a5,448(a5) # 80005ed8 <panicked>
    80003d20:	00078463          	beqz	a5,80003d28 <uartputc+0x10>
    80003d24:	0000006f          	j	80003d24 <uartputc+0xc>
    80003d28:	fd010113          	addi	sp,sp,-48
    80003d2c:	02813023          	sd	s0,32(sp)
    80003d30:	00913c23          	sd	s1,24(sp)
    80003d34:	01213823          	sd	s2,16(sp)
    80003d38:	01313423          	sd	s3,8(sp)
    80003d3c:	02113423          	sd	ra,40(sp)
    80003d40:	03010413          	addi	s0,sp,48
    80003d44:	00002917          	auipc	s2,0x2
    80003d48:	19c90913          	addi	s2,s2,412 # 80005ee0 <uart_tx_r>
    80003d4c:	00093783          	ld	a5,0(s2)
    80003d50:	00002497          	auipc	s1,0x2
    80003d54:	19848493          	addi	s1,s1,408 # 80005ee8 <uart_tx_w>
    80003d58:	0004b703          	ld	a4,0(s1)
    80003d5c:	02078693          	addi	a3,a5,32
    80003d60:	00050993          	mv	s3,a0
    80003d64:	02e69c63          	bne	a3,a4,80003d9c <uartputc+0x84>
    80003d68:	00001097          	auipc	ra,0x1
    80003d6c:	834080e7          	jalr	-1996(ra) # 8000459c <push_on>
    80003d70:	00093783          	ld	a5,0(s2)
    80003d74:	0004b703          	ld	a4,0(s1)
    80003d78:	02078793          	addi	a5,a5,32
    80003d7c:	00e79463          	bne	a5,a4,80003d84 <uartputc+0x6c>
    80003d80:	0000006f          	j	80003d80 <uartputc+0x68>
    80003d84:	00001097          	auipc	ra,0x1
    80003d88:	88c080e7          	jalr	-1908(ra) # 80004610 <pop_on>
    80003d8c:	00093783          	ld	a5,0(s2)
    80003d90:	0004b703          	ld	a4,0(s1)
    80003d94:	02078693          	addi	a3,a5,32
    80003d98:	fce688e3          	beq	a3,a4,80003d68 <uartputc+0x50>
    80003d9c:	01f77693          	andi	a3,a4,31
    80003da0:	00003597          	auipc	a1,0x3
    80003da4:	3e058593          	addi	a1,a1,992 # 80007180 <uart_tx_buf>
    80003da8:	00d586b3          	add	a3,a1,a3
    80003dac:	00170713          	addi	a4,a4,1
    80003db0:	01368023          	sb	s3,0(a3)
    80003db4:	00e4b023          	sd	a4,0(s1)
    80003db8:	10000637          	lui	a2,0x10000
    80003dbc:	02f71063          	bne	a4,a5,80003ddc <uartputc+0xc4>
    80003dc0:	0340006f          	j	80003df4 <uartputc+0xdc>
    80003dc4:	00074703          	lbu	a4,0(a4)
    80003dc8:	00f93023          	sd	a5,0(s2)
    80003dcc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003dd0:	00093783          	ld	a5,0(s2)
    80003dd4:	0004b703          	ld	a4,0(s1)
    80003dd8:	00f70e63          	beq	a4,a5,80003df4 <uartputc+0xdc>
    80003ddc:	00564683          	lbu	a3,5(a2)
    80003de0:	01f7f713          	andi	a4,a5,31
    80003de4:	00e58733          	add	a4,a1,a4
    80003de8:	0206f693          	andi	a3,a3,32
    80003dec:	00178793          	addi	a5,a5,1
    80003df0:	fc069ae3          	bnez	a3,80003dc4 <uartputc+0xac>
    80003df4:	02813083          	ld	ra,40(sp)
    80003df8:	02013403          	ld	s0,32(sp)
    80003dfc:	01813483          	ld	s1,24(sp)
    80003e00:	01013903          	ld	s2,16(sp)
    80003e04:	00813983          	ld	s3,8(sp)
    80003e08:	03010113          	addi	sp,sp,48
    80003e0c:	00008067          	ret

0000000080003e10 <uartputc_sync>:
    80003e10:	ff010113          	addi	sp,sp,-16
    80003e14:	00813423          	sd	s0,8(sp)
    80003e18:	01010413          	addi	s0,sp,16
    80003e1c:	00002717          	auipc	a4,0x2
    80003e20:	0bc72703          	lw	a4,188(a4) # 80005ed8 <panicked>
    80003e24:	02071663          	bnez	a4,80003e50 <uartputc_sync+0x40>
    80003e28:	00050793          	mv	a5,a0
    80003e2c:	100006b7          	lui	a3,0x10000
    80003e30:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003e34:	02077713          	andi	a4,a4,32
    80003e38:	fe070ce3          	beqz	a4,80003e30 <uartputc_sync+0x20>
    80003e3c:	0ff7f793          	andi	a5,a5,255
    80003e40:	00f68023          	sb	a5,0(a3)
    80003e44:	00813403          	ld	s0,8(sp)
    80003e48:	01010113          	addi	sp,sp,16
    80003e4c:	00008067          	ret
    80003e50:	0000006f          	j	80003e50 <uartputc_sync+0x40>

0000000080003e54 <uartstart>:
    80003e54:	ff010113          	addi	sp,sp,-16
    80003e58:	00813423          	sd	s0,8(sp)
    80003e5c:	01010413          	addi	s0,sp,16
    80003e60:	00002617          	auipc	a2,0x2
    80003e64:	08060613          	addi	a2,a2,128 # 80005ee0 <uart_tx_r>
    80003e68:	00002517          	auipc	a0,0x2
    80003e6c:	08050513          	addi	a0,a0,128 # 80005ee8 <uart_tx_w>
    80003e70:	00063783          	ld	a5,0(a2)
    80003e74:	00053703          	ld	a4,0(a0)
    80003e78:	04f70263          	beq	a4,a5,80003ebc <uartstart+0x68>
    80003e7c:	100005b7          	lui	a1,0x10000
    80003e80:	00003817          	auipc	a6,0x3
    80003e84:	30080813          	addi	a6,a6,768 # 80007180 <uart_tx_buf>
    80003e88:	01c0006f          	j	80003ea4 <uartstart+0x50>
    80003e8c:	0006c703          	lbu	a4,0(a3)
    80003e90:	00f63023          	sd	a5,0(a2)
    80003e94:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003e98:	00063783          	ld	a5,0(a2)
    80003e9c:	00053703          	ld	a4,0(a0)
    80003ea0:	00f70e63          	beq	a4,a5,80003ebc <uartstart+0x68>
    80003ea4:	01f7f713          	andi	a4,a5,31
    80003ea8:	00e806b3          	add	a3,a6,a4
    80003eac:	0055c703          	lbu	a4,5(a1)
    80003eb0:	00178793          	addi	a5,a5,1
    80003eb4:	02077713          	andi	a4,a4,32
    80003eb8:	fc071ae3          	bnez	a4,80003e8c <uartstart+0x38>
    80003ebc:	00813403          	ld	s0,8(sp)
    80003ec0:	01010113          	addi	sp,sp,16
    80003ec4:	00008067          	ret

0000000080003ec8 <uartgetc>:
    80003ec8:	ff010113          	addi	sp,sp,-16
    80003ecc:	00813423          	sd	s0,8(sp)
    80003ed0:	01010413          	addi	s0,sp,16
    80003ed4:	10000737          	lui	a4,0x10000
    80003ed8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003edc:	0017f793          	andi	a5,a5,1
    80003ee0:	00078c63          	beqz	a5,80003ef8 <uartgetc+0x30>
    80003ee4:	00074503          	lbu	a0,0(a4)
    80003ee8:	0ff57513          	andi	a0,a0,255
    80003eec:	00813403          	ld	s0,8(sp)
    80003ef0:	01010113          	addi	sp,sp,16
    80003ef4:	00008067          	ret
    80003ef8:	fff00513          	li	a0,-1
    80003efc:	ff1ff06f          	j	80003eec <uartgetc+0x24>

0000000080003f00 <uartintr>:
    80003f00:	100007b7          	lui	a5,0x10000
    80003f04:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003f08:	0017f793          	andi	a5,a5,1
    80003f0c:	0a078463          	beqz	a5,80003fb4 <uartintr+0xb4>
    80003f10:	fe010113          	addi	sp,sp,-32
    80003f14:	00813823          	sd	s0,16(sp)
    80003f18:	00913423          	sd	s1,8(sp)
    80003f1c:	00113c23          	sd	ra,24(sp)
    80003f20:	02010413          	addi	s0,sp,32
    80003f24:	100004b7          	lui	s1,0x10000
    80003f28:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003f2c:	0ff57513          	andi	a0,a0,255
    80003f30:	fffff097          	auipc	ra,0xfffff
    80003f34:	534080e7          	jalr	1332(ra) # 80003464 <consoleintr>
    80003f38:	0054c783          	lbu	a5,5(s1)
    80003f3c:	0017f793          	andi	a5,a5,1
    80003f40:	fe0794e3          	bnez	a5,80003f28 <uartintr+0x28>
    80003f44:	00002617          	auipc	a2,0x2
    80003f48:	f9c60613          	addi	a2,a2,-100 # 80005ee0 <uart_tx_r>
    80003f4c:	00002517          	auipc	a0,0x2
    80003f50:	f9c50513          	addi	a0,a0,-100 # 80005ee8 <uart_tx_w>
    80003f54:	00063783          	ld	a5,0(a2)
    80003f58:	00053703          	ld	a4,0(a0)
    80003f5c:	04f70263          	beq	a4,a5,80003fa0 <uartintr+0xa0>
    80003f60:	100005b7          	lui	a1,0x10000
    80003f64:	00003817          	auipc	a6,0x3
    80003f68:	21c80813          	addi	a6,a6,540 # 80007180 <uart_tx_buf>
    80003f6c:	01c0006f          	j	80003f88 <uartintr+0x88>
    80003f70:	0006c703          	lbu	a4,0(a3)
    80003f74:	00f63023          	sd	a5,0(a2)
    80003f78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f7c:	00063783          	ld	a5,0(a2)
    80003f80:	00053703          	ld	a4,0(a0)
    80003f84:	00f70e63          	beq	a4,a5,80003fa0 <uartintr+0xa0>
    80003f88:	01f7f713          	andi	a4,a5,31
    80003f8c:	00e806b3          	add	a3,a6,a4
    80003f90:	0055c703          	lbu	a4,5(a1)
    80003f94:	00178793          	addi	a5,a5,1
    80003f98:	02077713          	andi	a4,a4,32
    80003f9c:	fc071ae3          	bnez	a4,80003f70 <uartintr+0x70>
    80003fa0:	01813083          	ld	ra,24(sp)
    80003fa4:	01013403          	ld	s0,16(sp)
    80003fa8:	00813483          	ld	s1,8(sp)
    80003fac:	02010113          	addi	sp,sp,32
    80003fb0:	00008067          	ret
    80003fb4:	00002617          	auipc	a2,0x2
    80003fb8:	f2c60613          	addi	a2,a2,-212 # 80005ee0 <uart_tx_r>
    80003fbc:	00002517          	auipc	a0,0x2
    80003fc0:	f2c50513          	addi	a0,a0,-212 # 80005ee8 <uart_tx_w>
    80003fc4:	00063783          	ld	a5,0(a2)
    80003fc8:	00053703          	ld	a4,0(a0)
    80003fcc:	04f70263          	beq	a4,a5,80004010 <uartintr+0x110>
    80003fd0:	100005b7          	lui	a1,0x10000
    80003fd4:	00003817          	auipc	a6,0x3
    80003fd8:	1ac80813          	addi	a6,a6,428 # 80007180 <uart_tx_buf>
    80003fdc:	01c0006f          	j	80003ff8 <uartintr+0xf8>
    80003fe0:	0006c703          	lbu	a4,0(a3)
    80003fe4:	00f63023          	sd	a5,0(a2)
    80003fe8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003fec:	00063783          	ld	a5,0(a2)
    80003ff0:	00053703          	ld	a4,0(a0)
    80003ff4:	02f70063          	beq	a4,a5,80004014 <uartintr+0x114>
    80003ff8:	01f7f713          	andi	a4,a5,31
    80003ffc:	00e806b3          	add	a3,a6,a4
    80004000:	0055c703          	lbu	a4,5(a1)
    80004004:	00178793          	addi	a5,a5,1
    80004008:	02077713          	andi	a4,a4,32
    8000400c:	fc071ae3          	bnez	a4,80003fe0 <uartintr+0xe0>
    80004010:	00008067          	ret
    80004014:	00008067          	ret

0000000080004018 <kinit>:
    80004018:	fc010113          	addi	sp,sp,-64
    8000401c:	02913423          	sd	s1,40(sp)
    80004020:	fffff7b7          	lui	a5,0xfffff
    80004024:	00004497          	auipc	s1,0x4
    80004028:	17b48493          	addi	s1,s1,379 # 8000819f <end+0xfff>
    8000402c:	02813823          	sd	s0,48(sp)
    80004030:	01313c23          	sd	s3,24(sp)
    80004034:	00f4f4b3          	and	s1,s1,a5
    80004038:	02113c23          	sd	ra,56(sp)
    8000403c:	03213023          	sd	s2,32(sp)
    80004040:	01413823          	sd	s4,16(sp)
    80004044:	01513423          	sd	s5,8(sp)
    80004048:	04010413          	addi	s0,sp,64
    8000404c:	000017b7          	lui	a5,0x1
    80004050:	01100993          	li	s3,17
    80004054:	00f487b3          	add	a5,s1,a5
    80004058:	01b99993          	slli	s3,s3,0x1b
    8000405c:	06f9e063          	bltu	s3,a5,800040bc <kinit+0xa4>
    80004060:	00003a97          	auipc	s5,0x3
    80004064:	140a8a93          	addi	s5,s5,320 # 800071a0 <end>
    80004068:	0754ec63          	bltu	s1,s5,800040e0 <kinit+0xc8>
    8000406c:	0734fa63          	bgeu	s1,s3,800040e0 <kinit+0xc8>
    80004070:	00088a37          	lui	s4,0x88
    80004074:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004078:	00002917          	auipc	s2,0x2
    8000407c:	e7890913          	addi	s2,s2,-392 # 80005ef0 <kmem>
    80004080:	00ca1a13          	slli	s4,s4,0xc
    80004084:	0140006f          	j	80004098 <kinit+0x80>
    80004088:	000017b7          	lui	a5,0x1
    8000408c:	00f484b3          	add	s1,s1,a5
    80004090:	0554e863          	bltu	s1,s5,800040e0 <kinit+0xc8>
    80004094:	0534f663          	bgeu	s1,s3,800040e0 <kinit+0xc8>
    80004098:	00001637          	lui	a2,0x1
    8000409c:	00100593          	li	a1,1
    800040a0:	00048513          	mv	a0,s1
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	5e4080e7          	jalr	1508(ra) # 80004688 <__memset>
    800040ac:	00093783          	ld	a5,0(s2)
    800040b0:	00f4b023          	sd	a5,0(s1)
    800040b4:	00993023          	sd	s1,0(s2)
    800040b8:	fd4498e3          	bne	s1,s4,80004088 <kinit+0x70>
    800040bc:	03813083          	ld	ra,56(sp)
    800040c0:	03013403          	ld	s0,48(sp)
    800040c4:	02813483          	ld	s1,40(sp)
    800040c8:	02013903          	ld	s2,32(sp)
    800040cc:	01813983          	ld	s3,24(sp)
    800040d0:	01013a03          	ld	s4,16(sp)
    800040d4:	00813a83          	ld	s5,8(sp)
    800040d8:	04010113          	addi	sp,sp,64
    800040dc:	00008067          	ret
    800040e0:	00001517          	auipc	a0,0x1
    800040e4:	1c050513          	addi	a0,a0,448 # 800052a0 <digits+0x18>
    800040e8:	fffff097          	auipc	ra,0xfffff
    800040ec:	4b4080e7          	jalr	1204(ra) # 8000359c <panic>

00000000800040f0 <freerange>:
    800040f0:	fc010113          	addi	sp,sp,-64
    800040f4:	000017b7          	lui	a5,0x1
    800040f8:	02913423          	sd	s1,40(sp)
    800040fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004100:	009504b3          	add	s1,a0,s1
    80004104:	fffff537          	lui	a0,0xfffff
    80004108:	02813823          	sd	s0,48(sp)
    8000410c:	02113c23          	sd	ra,56(sp)
    80004110:	03213023          	sd	s2,32(sp)
    80004114:	01313c23          	sd	s3,24(sp)
    80004118:	01413823          	sd	s4,16(sp)
    8000411c:	01513423          	sd	s5,8(sp)
    80004120:	01613023          	sd	s6,0(sp)
    80004124:	04010413          	addi	s0,sp,64
    80004128:	00a4f4b3          	and	s1,s1,a0
    8000412c:	00f487b3          	add	a5,s1,a5
    80004130:	06f5e463          	bltu	a1,a5,80004198 <freerange+0xa8>
    80004134:	00003a97          	auipc	s5,0x3
    80004138:	06ca8a93          	addi	s5,s5,108 # 800071a0 <end>
    8000413c:	0954e263          	bltu	s1,s5,800041c0 <freerange+0xd0>
    80004140:	01100993          	li	s3,17
    80004144:	01b99993          	slli	s3,s3,0x1b
    80004148:	0734fc63          	bgeu	s1,s3,800041c0 <freerange+0xd0>
    8000414c:	00058a13          	mv	s4,a1
    80004150:	00002917          	auipc	s2,0x2
    80004154:	da090913          	addi	s2,s2,-608 # 80005ef0 <kmem>
    80004158:	00002b37          	lui	s6,0x2
    8000415c:	0140006f          	j	80004170 <freerange+0x80>
    80004160:	000017b7          	lui	a5,0x1
    80004164:	00f484b3          	add	s1,s1,a5
    80004168:	0554ec63          	bltu	s1,s5,800041c0 <freerange+0xd0>
    8000416c:	0534fa63          	bgeu	s1,s3,800041c0 <freerange+0xd0>
    80004170:	00001637          	lui	a2,0x1
    80004174:	00100593          	li	a1,1
    80004178:	00048513          	mv	a0,s1
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	50c080e7          	jalr	1292(ra) # 80004688 <__memset>
    80004184:	00093703          	ld	a4,0(s2)
    80004188:	016487b3          	add	a5,s1,s6
    8000418c:	00e4b023          	sd	a4,0(s1)
    80004190:	00993023          	sd	s1,0(s2)
    80004194:	fcfa76e3          	bgeu	s4,a5,80004160 <freerange+0x70>
    80004198:	03813083          	ld	ra,56(sp)
    8000419c:	03013403          	ld	s0,48(sp)
    800041a0:	02813483          	ld	s1,40(sp)
    800041a4:	02013903          	ld	s2,32(sp)
    800041a8:	01813983          	ld	s3,24(sp)
    800041ac:	01013a03          	ld	s4,16(sp)
    800041b0:	00813a83          	ld	s5,8(sp)
    800041b4:	00013b03          	ld	s6,0(sp)
    800041b8:	04010113          	addi	sp,sp,64
    800041bc:	00008067          	ret
    800041c0:	00001517          	auipc	a0,0x1
    800041c4:	0e050513          	addi	a0,a0,224 # 800052a0 <digits+0x18>
    800041c8:	fffff097          	auipc	ra,0xfffff
    800041cc:	3d4080e7          	jalr	980(ra) # 8000359c <panic>

00000000800041d0 <kfree>:
    800041d0:	fe010113          	addi	sp,sp,-32
    800041d4:	00813823          	sd	s0,16(sp)
    800041d8:	00113c23          	sd	ra,24(sp)
    800041dc:	00913423          	sd	s1,8(sp)
    800041e0:	02010413          	addi	s0,sp,32
    800041e4:	03451793          	slli	a5,a0,0x34
    800041e8:	04079c63          	bnez	a5,80004240 <kfree+0x70>
    800041ec:	00003797          	auipc	a5,0x3
    800041f0:	fb478793          	addi	a5,a5,-76 # 800071a0 <end>
    800041f4:	00050493          	mv	s1,a0
    800041f8:	04f56463          	bltu	a0,a5,80004240 <kfree+0x70>
    800041fc:	01100793          	li	a5,17
    80004200:	01b79793          	slli	a5,a5,0x1b
    80004204:	02f57e63          	bgeu	a0,a5,80004240 <kfree+0x70>
    80004208:	00001637          	lui	a2,0x1
    8000420c:	00100593          	li	a1,1
    80004210:	00000097          	auipc	ra,0x0
    80004214:	478080e7          	jalr	1144(ra) # 80004688 <__memset>
    80004218:	00002797          	auipc	a5,0x2
    8000421c:	cd878793          	addi	a5,a5,-808 # 80005ef0 <kmem>
    80004220:	0007b703          	ld	a4,0(a5)
    80004224:	01813083          	ld	ra,24(sp)
    80004228:	01013403          	ld	s0,16(sp)
    8000422c:	00e4b023          	sd	a4,0(s1)
    80004230:	0097b023          	sd	s1,0(a5)
    80004234:	00813483          	ld	s1,8(sp)
    80004238:	02010113          	addi	sp,sp,32
    8000423c:	00008067          	ret
    80004240:	00001517          	auipc	a0,0x1
    80004244:	06050513          	addi	a0,a0,96 # 800052a0 <digits+0x18>
    80004248:	fffff097          	auipc	ra,0xfffff
    8000424c:	354080e7          	jalr	852(ra) # 8000359c <panic>

0000000080004250 <kalloc>:
    80004250:	fe010113          	addi	sp,sp,-32
    80004254:	00813823          	sd	s0,16(sp)
    80004258:	00913423          	sd	s1,8(sp)
    8000425c:	00113c23          	sd	ra,24(sp)
    80004260:	02010413          	addi	s0,sp,32
    80004264:	00002797          	auipc	a5,0x2
    80004268:	c8c78793          	addi	a5,a5,-884 # 80005ef0 <kmem>
    8000426c:	0007b483          	ld	s1,0(a5)
    80004270:	02048063          	beqz	s1,80004290 <kalloc+0x40>
    80004274:	0004b703          	ld	a4,0(s1)
    80004278:	00001637          	lui	a2,0x1
    8000427c:	00500593          	li	a1,5
    80004280:	00048513          	mv	a0,s1
    80004284:	00e7b023          	sd	a4,0(a5)
    80004288:	00000097          	auipc	ra,0x0
    8000428c:	400080e7          	jalr	1024(ra) # 80004688 <__memset>
    80004290:	01813083          	ld	ra,24(sp)
    80004294:	01013403          	ld	s0,16(sp)
    80004298:	00048513          	mv	a0,s1
    8000429c:	00813483          	ld	s1,8(sp)
    800042a0:	02010113          	addi	sp,sp,32
    800042a4:	00008067          	ret

00000000800042a8 <initlock>:
    800042a8:	ff010113          	addi	sp,sp,-16
    800042ac:	00813423          	sd	s0,8(sp)
    800042b0:	01010413          	addi	s0,sp,16
    800042b4:	00813403          	ld	s0,8(sp)
    800042b8:	00b53423          	sd	a1,8(a0)
    800042bc:	00052023          	sw	zero,0(a0)
    800042c0:	00053823          	sd	zero,16(a0)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret

00000000800042cc <acquire>:
    800042cc:	fe010113          	addi	sp,sp,-32
    800042d0:	00813823          	sd	s0,16(sp)
    800042d4:	00913423          	sd	s1,8(sp)
    800042d8:	00113c23          	sd	ra,24(sp)
    800042dc:	01213023          	sd	s2,0(sp)
    800042e0:	02010413          	addi	s0,sp,32
    800042e4:	00050493          	mv	s1,a0
    800042e8:	10002973          	csrr	s2,sstatus
    800042ec:	100027f3          	csrr	a5,sstatus
    800042f0:	ffd7f793          	andi	a5,a5,-3
    800042f4:	10079073          	csrw	sstatus,a5
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	8e0080e7          	jalr	-1824(ra) # 80002bd8 <mycpu>
    80004300:	07852783          	lw	a5,120(a0)
    80004304:	06078e63          	beqz	a5,80004380 <acquire+0xb4>
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	8d0080e7          	jalr	-1840(ra) # 80002bd8 <mycpu>
    80004310:	07852783          	lw	a5,120(a0)
    80004314:	0004a703          	lw	a4,0(s1)
    80004318:	0017879b          	addiw	a5,a5,1
    8000431c:	06f52c23          	sw	a5,120(a0)
    80004320:	04071063          	bnez	a4,80004360 <acquire+0x94>
    80004324:	00100713          	li	a4,1
    80004328:	00070793          	mv	a5,a4
    8000432c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004330:	0007879b          	sext.w	a5,a5
    80004334:	fe079ae3          	bnez	a5,80004328 <acquire+0x5c>
    80004338:	0ff0000f          	fence
    8000433c:	fffff097          	auipc	ra,0xfffff
    80004340:	89c080e7          	jalr	-1892(ra) # 80002bd8 <mycpu>
    80004344:	01813083          	ld	ra,24(sp)
    80004348:	01013403          	ld	s0,16(sp)
    8000434c:	00a4b823          	sd	a0,16(s1)
    80004350:	00013903          	ld	s2,0(sp)
    80004354:	00813483          	ld	s1,8(sp)
    80004358:	02010113          	addi	sp,sp,32
    8000435c:	00008067          	ret
    80004360:	0104b903          	ld	s2,16(s1)
    80004364:	fffff097          	auipc	ra,0xfffff
    80004368:	874080e7          	jalr	-1932(ra) # 80002bd8 <mycpu>
    8000436c:	faa91ce3          	bne	s2,a0,80004324 <acquire+0x58>
    80004370:	00001517          	auipc	a0,0x1
    80004374:	f3850513          	addi	a0,a0,-200 # 800052a8 <digits+0x20>
    80004378:	fffff097          	auipc	ra,0xfffff
    8000437c:	224080e7          	jalr	548(ra) # 8000359c <panic>
    80004380:	00195913          	srli	s2,s2,0x1
    80004384:	fffff097          	auipc	ra,0xfffff
    80004388:	854080e7          	jalr	-1964(ra) # 80002bd8 <mycpu>
    8000438c:	00197913          	andi	s2,s2,1
    80004390:	07252e23          	sw	s2,124(a0)
    80004394:	f75ff06f          	j	80004308 <acquire+0x3c>

0000000080004398 <release>:
    80004398:	fe010113          	addi	sp,sp,-32
    8000439c:	00813823          	sd	s0,16(sp)
    800043a0:	00113c23          	sd	ra,24(sp)
    800043a4:	00913423          	sd	s1,8(sp)
    800043a8:	01213023          	sd	s2,0(sp)
    800043ac:	02010413          	addi	s0,sp,32
    800043b0:	00052783          	lw	a5,0(a0)
    800043b4:	00079a63          	bnez	a5,800043c8 <release+0x30>
    800043b8:	00001517          	auipc	a0,0x1
    800043bc:	ef850513          	addi	a0,a0,-264 # 800052b0 <digits+0x28>
    800043c0:	fffff097          	auipc	ra,0xfffff
    800043c4:	1dc080e7          	jalr	476(ra) # 8000359c <panic>
    800043c8:	01053903          	ld	s2,16(a0)
    800043cc:	00050493          	mv	s1,a0
    800043d0:	fffff097          	auipc	ra,0xfffff
    800043d4:	808080e7          	jalr	-2040(ra) # 80002bd8 <mycpu>
    800043d8:	fea910e3          	bne	s2,a0,800043b8 <release+0x20>
    800043dc:	0004b823          	sd	zero,16(s1)
    800043e0:	0ff0000f          	fence
    800043e4:	0f50000f          	fence	iorw,ow
    800043e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	7ec080e7          	jalr	2028(ra) # 80002bd8 <mycpu>
    800043f4:	100027f3          	csrr	a5,sstatus
    800043f8:	0027f793          	andi	a5,a5,2
    800043fc:	04079a63          	bnez	a5,80004450 <release+0xb8>
    80004400:	07852783          	lw	a5,120(a0)
    80004404:	02f05e63          	blez	a5,80004440 <release+0xa8>
    80004408:	fff7871b          	addiw	a4,a5,-1
    8000440c:	06e52c23          	sw	a4,120(a0)
    80004410:	00071c63          	bnez	a4,80004428 <release+0x90>
    80004414:	07c52783          	lw	a5,124(a0)
    80004418:	00078863          	beqz	a5,80004428 <release+0x90>
    8000441c:	100027f3          	csrr	a5,sstatus
    80004420:	0027e793          	ori	a5,a5,2
    80004424:	10079073          	csrw	sstatus,a5
    80004428:	01813083          	ld	ra,24(sp)
    8000442c:	01013403          	ld	s0,16(sp)
    80004430:	00813483          	ld	s1,8(sp)
    80004434:	00013903          	ld	s2,0(sp)
    80004438:	02010113          	addi	sp,sp,32
    8000443c:	00008067          	ret
    80004440:	00001517          	auipc	a0,0x1
    80004444:	e9050513          	addi	a0,a0,-368 # 800052d0 <digits+0x48>
    80004448:	fffff097          	auipc	ra,0xfffff
    8000444c:	154080e7          	jalr	340(ra) # 8000359c <panic>
    80004450:	00001517          	auipc	a0,0x1
    80004454:	e6850513          	addi	a0,a0,-408 # 800052b8 <digits+0x30>
    80004458:	fffff097          	auipc	ra,0xfffff
    8000445c:	144080e7          	jalr	324(ra) # 8000359c <panic>

0000000080004460 <holding>:
    80004460:	00052783          	lw	a5,0(a0)
    80004464:	00079663          	bnez	a5,80004470 <holding+0x10>
    80004468:	00000513          	li	a0,0
    8000446c:	00008067          	ret
    80004470:	fe010113          	addi	sp,sp,-32
    80004474:	00813823          	sd	s0,16(sp)
    80004478:	00913423          	sd	s1,8(sp)
    8000447c:	00113c23          	sd	ra,24(sp)
    80004480:	02010413          	addi	s0,sp,32
    80004484:	01053483          	ld	s1,16(a0)
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	750080e7          	jalr	1872(ra) # 80002bd8 <mycpu>
    80004490:	01813083          	ld	ra,24(sp)
    80004494:	01013403          	ld	s0,16(sp)
    80004498:	40a48533          	sub	a0,s1,a0
    8000449c:	00153513          	seqz	a0,a0
    800044a0:	00813483          	ld	s1,8(sp)
    800044a4:	02010113          	addi	sp,sp,32
    800044a8:	00008067          	ret

00000000800044ac <push_off>:
    800044ac:	fe010113          	addi	sp,sp,-32
    800044b0:	00813823          	sd	s0,16(sp)
    800044b4:	00113c23          	sd	ra,24(sp)
    800044b8:	00913423          	sd	s1,8(sp)
    800044bc:	02010413          	addi	s0,sp,32
    800044c0:	100024f3          	csrr	s1,sstatus
    800044c4:	100027f3          	csrr	a5,sstatus
    800044c8:	ffd7f793          	andi	a5,a5,-3
    800044cc:	10079073          	csrw	sstatus,a5
    800044d0:	ffffe097          	auipc	ra,0xffffe
    800044d4:	708080e7          	jalr	1800(ra) # 80002bd8 <mycpu>
    800044d8:	07852783          	lw	a5,120(a0)
    800044dc:	02078663          	beqz	a5,80004508 <push_off+0x5c>
    800044e0:	ffffe097          	auipc	ra,0xffffe
    800044e4:	6f8080e7          	jalr	1784(ra) # 80002bd8 <mycpu>
    800044e8:	07852783          	lw	a5,120(a0)
    800044ec:	01813083          	ld	ra,24(sp)
    800044f0:	01013403          	ld	s0,16(sp)
    800044f4:	0017879b          	addiw	a5,a5,1
    800044f8:	06f52c23          	sw	a5,120(a0)
    800044fc:	00813483          	ld	s1,8(sp)
    80004500:	02010113          	addi	sp,sp,32
    80004504:	00008067          	ret
    80004508:	0014d493          	srli	s1,s1,0x1
    8000450c:	ffffe097          	auipc	ra,0xffffe
    80004510:	6cc080e7          	jalr	1740(ra) # 80002bd8 <mycpu>
    80004514:	0014f493          	andi	s1,s1,1
    80004518:	06952e23          	sw	s1,124(a0)
    8000451c:	fc5ff06f          	j	800044e0 <push_off+0x34>

0000000080004520 <pop_off>:
    80004520:	ff010113          	addi	sp,sp,-16
    80004524:	00813023          	sd	s0,0(sp)
    80004528:	00113423          	sd	ra,8(sp)
    8000452c:	01010413          	addi	s0,sp,16
    80004530:	ffffe097          	auipc	ra,0xffffe
    80004534:	6a8080e7          	jalr	1704(ra) # 80002bd8 <mycpu>
    80004538:	100027f3          	csrr	a5,sstatus
    8000453c:	0027f793          	andi	a5,a5,2
    80004540:	04079663          	bnez	a5,8000458c <pop_off+0x6c>
    80004544:	07852783          	lw	a5,120(a0)
    80004548:	02f05a63          	blez	a5,8000457c <pop_off+0x5c>
    8000454c:	fff7871b          	addiw	a4,a5,-1
    80004550:	06e52c23          	sw	a4,120(a0)
    80004554:	00071c63          	bnez	a4,8000456c <pop_off+0x4c>
    80004558:	07c52783          	lw	a5,124(a0)
    8000455c:	00078863          	beqz	a5,8000456c <pop_off+0x4c>
    80004560:	100027f3          	csrr	a5,sstatus
    80004564:	0027e793          	ori	a5,a5,2
    80004568:	10079073          	csrw	sstatus,a5
    8000456c:	00813083          	ld	ra,8(sp)
    80004570:	00013403          	ld	s0,0(sp)
    80004574:	01010113          	addi	sp,sp,16
    80004578:	00008067          	ret
    8000457c:	00001517          	auipc	a0,0x1
    80004580:	d5450513          	addi	a0,a0,-684 # 800052d0 <digits+0x48>
    80004584:	fffff097          	auipc	ra,0xfffff
    80004588:	018080e7          	jalr	24(ra) # 8000359c <panic>
    8000458c:	00001517          	auipc	a0,0x1
    80004590:	d2c50513          	addi	a0,a0,-724 # 800052b8 <digits+0x30>
    80004594:	fffff097          	auipc	ra,0xfffff
    80004598:	008080e7          	jalr	8(ra) # 8000359c <panic>

000000008000459c <push_on>:
    8000459c:	fe010113          	addi	sp,sp,-32
    800045a0:	00813823          	sd	s0,16(sp)
    800045a4:	00113c23          	sd	ra,24(sp)
    800045a8:	00913423          	sd	s1,8(sp)
    800045ac:	02010413          	addi	s0,sp,32
    800045b0:	100024f3          	csrr	s1,sstatus
    800045b4:	100027f3          	csrr	a5,sstatus
    800045b8:	0027e793          	ori	a5,a5,2
    800045bc:	10079073          	csrw	sstatus,a5
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	618080e7          	jalr	1560(ra) # 80002bd8 <mycpu>
    800045c8:	07852783          	lw	a5,120(a0)
    800045cc:	02078663          	beqz	a5,800045f8 <push_on+0x5c>
    800045d0:	ffffe097          	auipc	ra,0xffffe
    800045d4:	608080e7          	jalr	1544(ra) # 80002bd8 <mycpu>
    800045d8:	07852783          	lw	a5,120(a0)
    800045dc:	01813083          	ld	ra,24(sp)
    800045e0:	01013403          	ld	s0,16(sp)
    800045e4:	0017879b          	addiw	a5,a5,1
    800045e8:	06f52c23          	sw	a5,120(a0)
    800045ec:	00813483          	ld	s1,8(sp)
    800045f0:	02010113          	addi	sp,sp,32
    800045f4:	00008067          	ret
    800045f8:	0014d493          	srli	s1,s1,0x1
    800045fc:	ffffe097          	auipc	ra,0xffffe
    80004600:	5dc080e7          	jalr	1500(ra) # 80002bd8 <mycpu>
    80004604:	0014f493          	andi	s1,s1,1
    80004608:	06952e23          	sw	s1,124(a0)
    8000460c:	fc5ff06f          	j	800045d0 <push_on+0x34>

0000000080004610 <pop_on>:
    80004610:	ff010113          	addi	sp,sp,-16
    80004614:	00813023          	sd	s0,0(sp)
    80004618:	00113423          	sd	ra,8(sp)
    8000461c:	01010413          	addi	s0,sp,16
    80004620:	ffffe097          	auipc	ra,0xffffe
    80004624:	5b8080e7          	jalr	1464(ra) # 80002bd8 <mycpu>
    80004628:	100027f3          	csrr	a5,sstatus
    8000462c:	0027f793          	andi	a5,a5,2
    80004630:	04078463          	beqz	a5,80004678 <pop_on+0x68>
    80004634:	07852783          	lw	a5,120(a0)
    80004638:	02f05863          	blez	a5,80004668 <pop_on+0x58>
    8000463c:	fff7879b          	addiw	a5,a5,-1
    80004640:	06f52c23          	sw	a5,120(a0)
    80004644:	07853783          	ld	a5,120(a0)
    80004648:	00079863          	bnez	a5,80004658 <pop_on+0x48>
    8000464c:	100027f3          	csrr	a5,sstatus
    80004650:	ffd7f793          	andi	a5,a5,-3
    80004654:	10079073          	csrw	sstatus,a5
    80004658:	00813083          	ld	ra,8(sp)
    8000465c:	00013403          	ld	s0,0(sp)
    80004660:	01010113          	addi	sp,sp,16
    80004664:	00008067          	ret
    80004668:	00001517          	auipc	a0,0x1
    8000466c:	c9050513          	addi	a0,a0,-880 # 800052f8 <digits+0x70>
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	f2c080e7          	jalr	-212(ra) # 8000359c <panic>
    80004678:	00001517          	auipc	a0,0x1
    8000467c:	c6050513          	addi	a0,a0,-928 # 800052d8 <digits+0x50>
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	f1c080e7          	jalr	-228(ra) # 8000359c <panic>

0000000080004688 <__memset>:
    80004688:	ff010113          	addi	sp,sp,-16
    8000468c:	00813423          	sd	s0,8(sp)
    80004690:	01010413          	addi	s0,sp,16
    80004694:	1a060e63          	beqz	a2,80004850 <__memset+0x1c8>
    80004698:	40a007b3          	neg	a5,a0
    8000469c:	0077f793          	andi	a5,a5,7
    800046a0:	00778693          	addi	a3,a5,7
    800046a4:	00b00813          	li	a6,11
    800046a8:	0ff5f593          	andi	a1,a1,255
    800046ac:	fff6071b          	addiw	a4,a2,-1
    800046b0:	1b06e663          	bltu	a3,a6,8000485c <__memset+0x1d4>
    800046b4:	1cd76463          	bltu	a4,a3,8000487c <__memset+0x1f4>
    800046b8:	1a078e63          	beqz	a5,80004874 <__memset+0x1ec>
    800046bc:	00b50023          	sb	a1,0(a0)
    800046c0:	00100713          	li	a4,1
    800046c4:	1ae78463          	beq	a5,a4,8000486c <__memset+0x1e4>
    800046c8:	00b500a3          	sb	a1,1(a0)
    800046cc:	00200713          	li	a4,2
    800046d0:	1ae78a63          	beq	a5,a4,80004884 <__memset+0x1fc>
    800046d4:	00b50123          	sb	a1,2(a0)
    800046d8:	00300713          	li	a4,3
    800046dc:	18e78463          	beq	a5,a4,80004864 <__memset+0x1dc>
    800046e0:	00b501a3          	sb	a1,3(a0)
    800046e4:	00400713          	li	a4,4
    800046e8:	1ae78263          	beq	a5,a4,8000488c <__memset+0x204>
    800046ec:	00b50223          	sb	a1,4(a0)
    800046f0:	00500713          	li	a4,5
    800046f4:	1ae78063          	beq	a5,a4,80004894 <__memset+0x20c>
    800046f8:	00b502a3          	sb	a1,5(a0)
    800046fc:	00700713          	li	a4,7
    80004700:	18e79e63          	bne	a5,a4,8000489c <__memset+0x214>
    80004704:	00b50323          	sb	a1,6(a0)
    80004708:	00700e93          	li	t4,7
    8000470c:	00859713          	slli	a4,a1,0x8
    80004710:	00e5e733          	or	a4,a1,a4
    80004714:	01059e13          	slli	t3,a1,0x10
    80004718:	01c76e33          	or	t3,a4,t3
    8000471c:	01859313          	slli	t1,a1,0x18
    80004720:	006e6333          	or	t1,t3,t1
    80004724:	02059893          	slli	a7,a1,0x20
    80004728:	40f60e3b          	subw	t3,a2,a5
    8000472c:	011368b3          	or	a7,t1,a7
    80004730:	02859813          	slli	a6,a1,0x28
    80004734:	0108e833          	or	a6,a7,a6
    80004738:	03059693          	slli	a3,a1,0x30
    8000473c:	003e589b          	srliw	a7,t3,0x3
    80004740:	00d866b3          	or	a3,a6,a3
    80004744:	03859713          	slli	a4,a1,0x38
    80004748:	00389813          	slli	a6,a7,0x3
    8000474c:	00f507b3          	add	a5,a0,a5
    80004750:	00e6e733          	or	a4,a3,a4
    80004754:	000e089b          	sext.w	a7,t3
    80004758:	00f806b3          	add	a3,a6,a5
    8000475c:	00e7b023          	sd	a4,0(a5)
    80004760:	00878793          	addi	a5,a5,8
    80004764:	fed79ce3          	bne	a5,a3,8000475c <__memset+0xd4>
    80004768:	ff8e7793          	andi	a5,t3,-8
    8000476c:	0007871b          	sext.w	a4,a5
    80004770:	01d787bb          	addw	a5,a5,t4
    80004774:	0ce88e63          	beq	a7,a4,80004850 <__memset+0x1c8>
    80004778:	00f50733          	add	a4,a0,a5
    8000477c:	00b70023          	sb	a1,0(a4)
    80004780:	0017871b          	addiw	a4,a5,1
    80004784:	0cc77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004788:	00e50733          	add	a4,a0,a4
    8000478c:	00b70023          	sb	a1,0(a4)
    80004790:	0027871b          	addiw	a4,a5,2
    80004794:	0ac77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004798:	00e50733          	add	a4,a0,a4
    8000479c:	00b70023          	sb	a1,0(a4)
    800047a0:	0037871b          	addiw	a4,a5,3
    800047a4:	0ac77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047a8:	00e50733          	add	a4,a0,a4
    800047ac:	00b70023          	sb	a1,0(a4)
    800047b0:	0047871b          	addiw	a4,a5,4
    800047b4:	08c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047b8:	00e50733          	add	a4,a0,a4
    800047bc:	00b70023          	sb	a1,0(a4)
    800047c0:	0057871b          	addiw	a4,a5,5
    800047c4:	08c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047c8:	00e50733          	add	a4,a0,a4
    800047cc:	00b70023          	sb	a1,0(a4)
    800047d0:	0067871b          	addiw	a4,a5,6
    800047d4:	06c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047d8:	00e50733          	add	a4,a0,a4
    800047dc:	00b70023          	sb	a1,0(a4)
    800047e0:	0077871b          	addiw	a4,a5,7
    800047e4:	06c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047e8:	00e50733          	add	a4,a0,a4
    800047ec:	00b70023          	sb	a1,0(a4)
    800047f0:	0087871b          	addiw	a4,a5,8
    800047f4:	04c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047f8:	00e50733          	add	a4,a0,a4
    800047fc:	00b70023          	sb	a1,0(a4)
    80004800:	0097871b          	addiw	a4,a5,9
    80004804:	04c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004808:	00e50733          	add	a4,a0,a4
    8000480c:	00b70023          	sb	a1,0(a4)
    80004810:	00a7871b          	addiw	a4,a5,10
    80004814:	02c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004818:	00e50733          	add	a4,a0,a4
    8000481c:	00b70023          	sb	a1,0(a4)
    80004820:	00b7871b          	addiw	a4,a5,11
    80004824:	02c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004828:	00e50733          	add	a4,a0,a4
    8000482c:	00b70023          	sb	a1,0(a4)
    80004830:	00c7871b          	addiw	a4,a5,12
    80004834:	00c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004838:	00e50733          	add	a4,a0,a4
    8000483c:	00b70023          	sb	a1,0(a4)
    80004840:	00d7879b          	addiw	a5,a5,13
    80004844:	00c7f663          	bgeu	a5,a2,80004850 <__memset+0x1c8>
    80004848:	00f507b3          	add	a5,a0,a5
    8000484c:	00b78023          	sb	a1,0(a5)
    80004850:	00813403          	ld	s0,8(sp)
    80004854:	01010113          	addi	sp,sp,16
    80004858:	00008067          	ret
    8000485c:	00b00693          	li	a3,11
    80004860:	e55ff06f          	j	800046b4 <__memset+0x2c>
    80004864:	00300e93          	li	t4,3
    80004868:	ea5ff06f          	j	8000470c <__memset+0x84>
    8000486c:	00100e93          	li	t4,1
    80004870:	e9dff06f          	j	8000470c <__memset+0x84>
    80004874:	00000e93          	li	t4,0
    80004878:	e95ff06f          	j	8000470c <__memset+0x84>
    8000487c:	00000793          	li	a5,0
    80004880:	ef9ff06f          	j	80004778 <__memset+0xf0>
    80004884:	00200e93          	li	t4,2
    80004888:	e85ff06f          	j	8000470c <__memset+0x84>
    8000488c:	00400e93          	li	t4,4
    80004890:	e7dff06f          	j	8000470c <__memset+0x84>
    80004894:	00500e93          	li	t4,5
    80004898:	e75ff06f          	j	8000470c <__memset+0x84>
    8000489c:	00600e93          	li	t4,6
    800048a0:	e6dff06f          	j	8000470c <__memset+0x84>

00000000800048a4 <__memmove>:
    800048a4:	ff010113          	addi	sp,sp,-16
    800048a8:	00813423          	sd	s0,8(sp)
    800048ac:	01010413          	addi	s0,sp,16
    800048b0:	0e060863          	beqz	a2,800049a0 <__memmove+0xfc>
    800048b4:	fff6069b          	addiw	a3,a2,-1
    800048b8:	0006881b          	sext.w	a6,a3
    800048bc:	0ea5e863          	bltu	a1,a0,800049ac <__memmove+0x108>
    800048c0:	00758713          	addi	a4,a1,7
    800048c4:	00a5e7b3          	or	a5,a1,a0
    800048c8:	40a70733          	sub	a4,a4,a0
    800048cc:	0077f793          	andi	a5,a5,7
    800048d0:	00f73713          	sltiu	a4,a4,15
    800048d4:	00174713          	xori	a4,a4,1
    800048d8:	0017b793          	seqz	a5,a5
    800048dc:	00e7f7b3          	and	a5,a5,a4
    800048e0:	10078863          	beqz	a5,800049f0 <__memmove+0x14c>
    800048e4:	00900793          	li	a5,9
    800048e8:	1107f463          	bgeu	a5,a6,800049f0 <__memmove+0x14c>
    800048ec:	0036581b          	srliw	a6,a2,0x3
    800048f0:	fff8081b          	addiw	a6,a6,-1
    800048f4:	02081813          	slli	a6,a6,0x20
    800048f8:	01d85893          	srli	a7,a6,0x1d
    800048fc:	00858813          	addi	a6,a1,8
    80004900:	00058793          	mv	a5,a1
    80004904:	00050713          	mv	a4,a0
    80004908:	01088833          	add	a6,a7,a6
    8000490c:	0007b883          	ld	a7,0(a5)
    80004910:	00878793          	addi	a5,a5,8
    80004914:	00870713          	addi	a4,a4,8
    80004918:	ff173c23          	sd	a7,-8(a4)
    8000491c:	ff0798e3          	bne	a5,a6,8000490c <__memmove+0x68>
    80004920:	ff867713          	andi	a4,a2,-8
    80004924:	02071793          	slli	a5,a4,0x20
    80004928:	0207d793          	srli	a5,a5,0x20
    8000492c:	00f585b3          	add	a1,a1,a5
    80004930:	40e686bb          	subw	a3,a3,a4
    80004934:	00f507b3          	add	a5,a0,a5
    80004938:	06e60463          	beq	a2,a4,800049a0 <__memmove+0xfc>
    8000493c:	0005c703          	lbu	a4,0(a1)
    80004940:	00e78023          	sb	a4,0(a5)
    80004944:	04068e63          	beqz	a3,800049a0 <__memmove+0xfc>
    80004948:	0015c603          	lbu	a2,1(a1)
    8000494c:	00100713          	li	a4,1
    80004950:	00c780a3          	sb	a2,1(a5)
    80004954:	04e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004958:	0025c603          	lbu	a2,2(a1)
    8000495c:	00200713          	li	a4,2
    80004960:	00c78123          	sb	a2,2(a5)
    80004964:	02e68e63          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004968:	0035c603          	lbu	a2,3(a1)
    8000496c:	00300713          	li	a4,3
    80004970:	00c781a3          	sb	a2,3(a5)
    80004974:	02e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004978:	0045c603          	lbu	a2,4(a1)
    8000497c:	00400713          	li	a4,4
    80004980:	00c78223          	sb	a2,4(a5)
    80004984:	00e68e63          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004988:	0055c603          	lbu	a2,5(a1)
    8000498c:	00500713          	li	a4,5
    80004990:	00c782a3          	sb	a2,5(a5)
    80004994:	00e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004998:	0065c703          	lbu	a4,6(a1)
    8000499c:	00e78323          	sb	a4,6(a5)
    800049a0:	00813403          	ld	s0,8(sp)
    800049a4:	01010113          	addi	sp,sp,16
    800049a8:	00008067          	ret
    800049ac:	02061713          	slli	a4,a2,0x20
    800049b0:	02075713          	srli	a4,a4,0x20
    800049b4:	00e587b3          	add	a5,a1,a4
    800049b8:	f0f574e3          	bgeu	a0,a5,800048c0 <__memmove+0x1c>
    800049bc:	02069613          	slli	a2,a3,0x20
    800049c0:	02065613          	srli	a2,a2,0x20
    800049c4:	fff64613          	not	a2,a2
    800049c8:	00e50733          	add	a4,a0,a4
    800049cc:	00c78633          	add	a2,a5,a2
    800049d0:	fff7c683          	lbu	a3,-1(a5)
    800049d4:	fff78793          	addi	a5,a5,-1
    800049d8:	fff70713          	addi	a4,a4,-1
    800049dc:	00d70023          	sb	a3,0(a4)
    800049e0:	fec798e3          	bne	a5,a2,800049d0 <__memmove+0x12c>
    800049e4:	00813403          	ld	s0,8(sp)
    800049e8:	01010113          	addi	sp,sp,16
    800049ec:	00008067          	ret
    800049f0:	02069713          	slli	a4,a3,0x20
    800049f4:	02075713          	srli	a4,a4,0x20
    800049f8:	00170713          	addi	a4,a4,1
    800049fc:	00e50733          	add	a4,a0,a4
    80004a00:	00050793          	mv	a5,a0
    80004a04:	0005c683          	lbu	a3,0(a1)
    80004a08:	00178793          	addi	a5,a5,1
    80004a0c:	00158593          	addi	a1,a1,1
    80004a10:	fed78fa3          	sb	a3,-1(a5)
    80004a14:	fee798e3          	bne	a5,a4,80004a04 <__memmove+0x160>
    80004a18:	f89ff06f          	j	800049a0 <__memmove+0xfc>

0000000080004a1c <__putc>:
    80004a1c:	fe010113          	addi	sp,sp,-32
    80004a20:	00813823          	sd	s0,16(sp)
    80004a24:	00113c23          	sd	ra,24(sp)
    80004a28:	02010413          	addi	s0,sp,32
    80004a2c:	00050793          	mv	a5,a0
    80004a30:	fef40593          	addi	a1,s0,-17
    80004a34:	00100613          	li	a2,1
    80004a38:	00000513          	li	a0,0
    80004a3c:	fef407a3          	sb	a5,-17(s0)
    80004a40:	fffff097          	auipc	ra,0xfffff
    80004a44:	b3c080e7          	jalr	-1220(ra) # 8000357c <console_write>
    80004a48:	01813083          	ld	ra,24(sp)
    80004a4c:	01013403          	ld	s0,16(sp)
    80004a50:	02010113          	addi	sp,sp,32
    80004a54:	00008067          	ret

0000000080004a58 <__getc>:
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00813823          	sd	s0,16(sp)
    80004a60:	00113c23          	sd	ra,24(sp)
    80004a64:	02010413          	addi	s0,sp,32
    80004a68:	fe840593          	addi	a1,s0,-24
    80004a6c:	00100613          	li	a2,1
    80004a70:	00000513          	li	a0,0
    80004a74:	fffff097          	auipc	ra,0xfffff
    80004a78:	ae8080e7          	jalr	-1304(ra) # 8000355c <console_read>
    80004a7c:	fe844503          	lbu	a0,-24(s0)
    80004a80:	01813083          	ld	ra,24(sp)
    80004a84:	01013403          	ld	s0,16(sp)
    80004a88:	02010113          	addi	sp,sp,32
    80004a8c:	00008067          	ret

0000000080004a90 <console_handler>:
    80004a90:	fe010113          	addi	sp,sp,-32
    80004a94:	00813823          	sd	s0,16(sp)
    80004a98:	00113c23          	sd	ra,24(sp)
    80004a9c:	00913423          	sd	s1,8(sp)
    80004aa0:	02010413          	addi	s0,sp,32
    80004aa4:	14202773          	csrr	a4,scause
    80004aa8:	100027f3          	csrr	a5,sstatus
    80004aac:	0027f793          	andi	a5,a5,2
    80004ab0:	06079e63          	bnez	a5,80004b2c <console_handler+0x9c>
    80004ab4:	00074c63          	bltz	a4,80004acc <console_handler+0x3c>
    80004ab8:	01813083          	ld	ra,24(sp)
    80004abc:	01013403          	ld	s0,16(sp)
    80004ac0:	00813483          	ld	s1,8(sp)
    80004ac4:	02010113          	addi	sp,sp,32
    80004ac8:	00008067          	ret
    80004acc:	0ff77713          	andi	a4,a4,255
    80004ad0:	00900793          	li	a5,9
    80004ad4:	fef712e3          	bne	a4,a5,80004ab8 <console_handler+0x28>
    80004ad8:	ffffe097          	auipc	ra,0xffffe
    80004adc:	6dc080e7          	jalr	1756(ra) # 800031b4 <plic_claim>
    80004ae0:	00a00793          	li	a5,10
    80004ae4:	00050493          	mv	s1,a0
    80004ae8:	02f50c63          	beq	a0,a5,80004b20 <console_handler+0x90>
    80004aec:	fc0506e3          	beqz	a0,80004ab8 <console_handler+0x28>
    80004af0:	00050593          	mv	a1,a0
    80004af4:	00000517          	auipc	a0,0x0
    80004af8:	70c50513          	addi	a0,a0,1804 # 80005200 <_ZZ12printIntegermE6digits+0xe0>
    80004afc:	fffff097          	auipc	ra,0xfffff
    80004b00:	afc080e7          	jalr	-1284(ra) # 800035f8 <__printf>
    80004b04:	01013403          	ld	s0,16(sp)
    80004b08:	01813083          	ld	ra,24(sp)
    80004b0c:	00048513          	mv	a0,s1
    80004b10:	00813483          	ld	s1,8(sp)
    80004b14:	02010113          	addi	sp,sp,32
    80004b18:	ffffe317          	auipc	t1,0xffffe
    80004b1c:	6d430067          	jr	1748(t1) # 800031ec <plic_complete>
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	3e0080e7          	jalr	992(ra) # 80003f00 <uartintr>
    80004b28:	fddff06f          	j	80004b04 <console_handler+0x74>
    80004b2c:	00000517          	auipc	a0,0x0
    80004b30:	7d450513          	addi	a0,a0,2004 # 80005300 <digits+0x78>
    80004b34:	fffff097          	auipc	ra,0xfffff
    80004b38:	a68080e7          	jalr	-1432(ra) # 8000359c <panic>
	...
