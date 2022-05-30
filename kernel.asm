
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	16813103          	ld	sp,360(sp) # 80006168 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5b9020ef          	jal	ra,80002dd4 <start>

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
    8000100c:	4ad000ef          	jal	ra,80001cb8 <_ZN3PCB10getContextEv>
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
    8000109c:	46c000ef          	jal	ra,80001508 <interruptHandler>

    call _ZN3PCB10getContextEv // u a0 stavlja pokazivac na registre
    800010a0:	419000ef          	jal	ra,80001cb8 <_ZN3PCB10getContextEv>

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
#include "../h/kernel.h"
#include "../h/PCB.h"

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

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace, a5 - deleteArgFlag
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
    asm volatile("mv a4, a0"); // a4 = handle privremeno cuvamo da bismo posle vratili u a1
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
    80001390:	02078463          	beqz	a5,800013b8 <_Z8sem_waitP3SCB+0x40>
    asm volatile("mv a1, a0");
    80001394:	00050593          	mv	a1,a0

    return (int)(size_t)callInterrupt(code);
    80001398:	02300513          	li	a0,35
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	db4080e7          	jalr	-588(ra) # 80001150 <_Z13callInterruptm>
    800013a4:	0005051b          	sext.w	a0,a0
}
    800013a8:	01813083          	ld	ra,24(sp)
    800013ac:	01013403          	ld	s0,16(sp)
    800013b0:	02010113          	addi	sp,sp,32
    800013b4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013b8:	fff00513          	li	a0,-1
    800013bc:	fedff06f          	j	800013a8 <_Z8sem_waitP3SCB+0x30>

00000000800013c0 <_Z10sem_signalP3SCB>:

int sem_signal (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_signal;
    if(handle == nullptr) return -1;
    800013c0:	02050c63          	beqz	a0,800013f8 <_Z10sem_signalP3SCB+0x38>
int sem_signal (sem_t handle) {
    800013c4:	ff010113          	addi	sp,sp,-16
    800013c8:	00113423          	sd	ra,8(sp)
    800013cc:	00813023          	sd	s0,0(sp)
    800013d0:	01010413          	addi	s0,sp,16
    asm volatile("mv a1, a0");
    800013d4:	00050593          	mv	a1,a0

    callInterrupt(code);
    800013d8:	02400513          	li	a0,36
    800013dc:	00000097          	auipc	ra,0x0
    800013e0:	d74080e7          	jalr	-652(ra) # 80001150 <_Z13callInterruptm>

    return 0;
    800013e4:	00000513          	li	a0,0
}
    800013e8:	00813083          	ld	ra,8(sp)
    800013ec:	00013403          	ld	s0,0(sp)
    800013f0:	01010113          	addi	sp,sp,16
    800013f4:	00008067          	ret
    if(handle == nullptr) return -1;
    800013f8:	fff00513          	li	a0,-1
}
    800013fc:	00008067          	ret

0000000080001400 <_Z9sem_closeP3SCB>:

int sem_close (sem_t handle) {
    size_t code = Kernel::sysCallCodes::sem_close;
    if(handle == nullptr) return -1;
    80001400:	02050c63          	beqz	a0,80001438 <_Z9sem_closeP3SCB+0x38>
int sem_close (sem_t handle) {
    80001404:	ff010113          	addi	sp,sp,-16
    80001408:	00113423          	sd	ra,8(sp)
    8000140c:	00813023          	sd	s0,0(sp)
    80001410:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001414:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001418:	02200513          	li	a0,34
    8000141c:	00000097          	auipc	ra,0x0
    80001420:	d34080e7          	jalr	-716(ra) # 80001150 <_Z13callInterruptm>
    return 0;
    80001424:	00000513          	li	a0,0
}
    80001428:	00813083          	ld	ra,8(sp)
    8000142c:	00013403          	ld	s0,0(sp)
    80001430:	01010113          	addi	sp,sp,16
    80001434:	00008067          	ret
    if(handle == nullptr) return -1;
    80001438:	fff00513          	li	a0,-1
}
    8000143c:	00008067          	ret

0000000080001440 <_Z10time_sleepm>:

int time_sleep (time_t time) {
    size_t code = Kernel::sysCallCodes::time_sleep;
    if(time <= 0) return -1;
    80001440:	04050063          	beqz	a0,80001480 <_Z10time_sleepm+0x40>
int time_sleep (time_t time) {
    80001444:	ff010113          	addi	sp,sp,-16
    80001448:	00113423          	sd	ra,8(sp)
    8000144c:	00813023          	sd	s0,0(sp)
    80001450:	01010413          	addi	s0,sp,16

    asm volatile("mv a1, a0");
    80001454:	00050593          	mv	a1,a0
    callInterrupt(code);
    80001458:	03100513          	li	a0,49
    8000145c:	00000097          	auipc	ra,0x0
    80001460:	cf4080e7          	jalr	-780(ra) # 80001150 <_Z13callInterruptm>

    thread_dispatch(); // radimo odmah dispatch da bi zaustavili tekuci proces
    80001464:	00000097          	auipc	ra,0x0
    80001468:	df0080e7          	jalr	-528(ra) # 80001254 <_Z15thread_dispatchv>

    return 0;
    8000146c:	00000513          	li	a0,0
}
    80001470:	00813083          	ld	ra,8(sp)
    80001474:	00013403          	ld	s0,0(sp)
    80001478:	01010113          	addi	sp,sp,16
    8000147c:	00008067          	ret
    if(time <= 0) return -1;
    80001480:	fff00513          	li	a0,-1
}
    80001484:	00008067          	ret

0000000080001488 <_Z4getcv>:

char getc () {
    80001488:	ff010113          	addi	sp,sp,-16
    8000148c:	00113423          	sd	ra,8(sp)
    80001490:	00813023          	sd	s0,0(sp)
    80001494:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::getc;
    return (char)(size_t)callInterrupt(code);
    80001498:	04100513          	li	a0,65
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	cb4080e7          	jalr	-844(ra) # 80001150 <_Z13callInterruptm>
}
    800014a4:	0ff57513          	andi	a0,a0,255
    800014a8:	00813083          	ld	ra,8(sp)
    800014ac:	00013403          	ld	s0,0(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret

00000000800014b8 <_Z4putcc>:

void putc(char c) {
    800014b8:	ff010113          	addi	sp,sp,-16
    800014bc:	00113423          	sd	ra,8(sp)
    800014c0:	00813023          	sd	s0,0(sp)
    800014c4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::putc;
    asm volatile("mv a1, a0"); // a1 = c
    800014c8:	00050593          	mv	a1,a0
    callInterrupt(code);
    800014cc:	04200513          	li	a0,66
    800014d0:	00000097          	auipc	ra,0x0
    800014d4:	c80080e7          	jalr	-896(ra) # 80001150 <_Z13callInterruptm>
}
    800014d8:	00813083          	ld	ra,8(sp)
    800014dc:	00013403          	ld	s0,0(sp)
    800014e0:	01010113          	addi	sp,sp,16
    800014e4:	00008067          	ret

00000000800014e8 <_ZN6Kernel10popSppSpieEv>:
#include "../h/Scheduler.h"
#include "../h/SCB.h"
#include "../h/SleepingProcesses.h"
#include "../h/CCB.h"
#include "../h/syscall_c.h"
void Kernel::popSppSpie() {
    800014e8:	ff010113          	addi	sp,sp,-16
    800014ec:	00813423          	sd	s0,8(sp)
    800014f0:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    800014f4:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    800014f8:	10200073          	sret
}
    800014fc:	00813403          	ld	s0,8(sp)
    80001500:	01010113          	addi	sp,sp,16
    80001504:	00008067          	ret

0000000080001508 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001508:	fa010113          	addi	sp,sp,-96
    8000150c:	04113c23          	sd	ra,88(sp)
    80001510:	04813823          	sd	s0,80(sp)
    80001514:	04913423          	sd	s1,72(sp)
    80001518:	05213023          	sd	s2,64(sp)
    8000151c:	06010413          	addi	s0,sp,96
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001520:	142027f3          	csrr	a5,scause
    80001524:	fcf43023          	sd	a5,-64(s0)
        return scause;
    80001528:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    8000152c:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001530:	141027f3          	csrr	a5,sepc
    80001534:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    80001538:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    8000153c:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001540:	100027f3          	csrr	a5,sstatus
    80001544:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    80001548:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    8000154c:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001550:	fd843703          	ld	a4,-40(s0)
    80001554:	00900793          	li	a5,9
    80001558:	04f70863          	beq	a4,a5,800015a8 <interruptHandler+0xa0>
    8000155c:	fd843703          	ld	a4,-40(s0)
    80001560:	00800793          	li	a5,8
    80001564:	04f70263          	beq	a4,a5,800015a8 <interruptHandler+0xa0>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    80001568:	fd843703          	ld	a4,-40(s0)
    8000156c:	fff00793          	li	a5,-1
    80001570:	03f79793          	slli	a5,a5,0x3f
    80001574:	00178793          	addi	a5,a5,1
    80001578:	2cf70e63          	beq	a4,a5,80001854 <interruptHandler+0x34c>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    8000157c:	fd843703          	ld	a4,-40(s0)
    80001580:	fff00793          	li	a5,-1
    80001584:	03f79793          	slli	a5,a5,0x3f
    80001588:	00978793          	addi	a5,a5,9
    8000158c:	32f70463          	beq	a4,a5,800018b4 <interruptHandler+0x3ac>

    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
    }

}
    80001590:	05813083          	ld	ra,88(sp)
    80001594:	05013403          	ld	s0,80(sp)
    80001598:	04813483          	ld	s1,72(sp)
    8000159c:	04013903          	ld	s2,64(sp)
    800015a0:	06010113          	addi	sp,sp,96
    800015a4:	00008067          	ret
        sepc += 4; // da bi se sret vratio na pravo mesto
    800015a8:	fd043783          	ld	a5,-48(s0)
    800015ac:	00478793          	addi	a5,a5,4
    800015b0:	fcf43823          	sd	a5,-48(s0)
        size_t volatile code = PCB::running->registers[10]; // a0
    800015b4:	00005797          	auipc	a5,0x5
    800015b8:	bcc7b783          	ld	a5,-1076(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    800015bc:	0007b503          	ld	a0,0(a5)
    800015c0:	01853703          	ld	a4,24(a0)
    800015c4:	05073783          	ld	a5,80(a4)
    800015c8:	faf43423          	sd	a5,-88(s0)
        switch(code) {
    800015cc:	fa843783          	ld	a5,-88(s0)
    800015d0:	04300693          	li	a3,67
    800015d4:	04f6e263          	bltu	a3,a5,80001618 <interruptHandler+0x110>
    800015d8:	00279793          	slli	a5,a5,0x2
    800015dc:	00004697          	auipc	a3,0x4
    800015e0:	a4468693          	addi	a3,a3,-1468 # 80005020 <CONSOLE_STATUS+0x10>
    800015e4:	00d787b3          	add	a5,a5,a3
    800015e8:	0007a783          	lw	a5,0(a5)
    800015ec:	00d787b3          	add	a5,a5,a3
    800015f0:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    800015f4:	05873503          	ld	a0,88(a4)
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_alloc(size);
    800015f8:	00651513          	slli	a0,a0,0x6
    800015fc:	00001097          	auipc	ra,0x1
    80001600:	4c8080e7          	jalr	1224(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
    80001604:	00005797          	auipc	a5,0x5
    80001608:	b7c7b783          	ld	a5,-1156(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000160c:	0007b783          	ld	a5,0(a5)
    80001610:	0187b783          	ld	a5,24(a5)
    80001614:	04a7b823          	sd	a0,80(a5)
        Kernel::w_sepc(sepc);
    80001618:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000161c:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001620:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001624:	10079073          	csrw	sstatus,a5
        return;
    80001628:	f69ff06f          	j	80001590 <interruptHandler+0x88>
                PCB::running->registers[10] = (size_t)MemoryAllocator::mem_free(memSegment);
    8000162c:	05873503          	ld	a0,88(a4)
    80001630:	00001097          	auipc	ra,0x1
    80001634:	5f8080e7          	jalr	1528(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
    80001638:	00005797          	auipc	a5,0x5
    8000163c:	b487b783          	ld	a5,-1208(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001640:	0007b783          	ld	a5,0(a5)
    80001644:	0187b783          	ld	a5,24(a5)
    80001648:	04a7b823          	sd	a0,80(a5)
                break;
    8000164c:	fcdff06f          	j	80001618 <interruptHandler+0x110>
                PCB::timeSliceCounter = 0;
    80001650:	00005797          	auipc	a5,0x5
    80001654:	b107b783          	ld	a5,-1264(a5) # 80006160 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001658:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000165c:	00000097          	auipc	ra,0x0
    80001660:	3fc080e7          	jalr	1020(ra) # 80001a58 <_ZN3PCB8dispatchEv>
                break;
    80001664:	fb5ff06f          	j	80001618 <interruptHandler+0x110>
                PCB::running->finished = true;
    80001668:	00100793          	li	a5,1
    8000166c:	02f50423          	sb	a5,40(a0)
                PCB::timeSliceCounter = 0;
    80001670:	00005797          	auipc	a5,0x5
    80001674:	af07b783          	ld	a5,-1296(a5) # 80006160 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001678:	0007b023          	sd	zero,0(a5)
                PCB::dispatch();
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	3dc080e7          	jalr	988(ra) # 80001a58 <_ZN3PCB8dispatchEv>
                PCB::running->registers[10] = (size_t)0;
    80001684:	00005797          	auipc	a5,0x5
    80001688:	afc7b783          	ld	a5,-1284(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000168c:	0007b783          	ld	a5,0(a5)
    80001690:	0187b783          	ld	a5,24(a5)
    80001694:	0407b823          	sd	zero,80(a5)
                break;
    80001698:	f81ff06f          	j	80001618 <interruptHandler+0x110>
                PCB **handle = (PCB **) PCB::running->registers[11];
    8000169c:	05873783          	ld	a5,88(a4)
                Scheduler::put(*handle);
    800016a0:	0007b503          	ld	a0,0(a5)
    800016a4:	00001097          	auipc	ra,0x1
    800016a8:	890080e7          	jalr	-1904(ra) # 80001f34 <_ZN9Scheduler3putEP3PCB>
                break;
    800016ac:	f6dff06f          	j	80001618 <interruptHandler+0x110>
                PCB **handle = (PCB**)PCB::running->registers[11];
    800016b0:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800016b4:	06873583          	ld	a1,104(a4)
    800016b8:	06073503          	ld	a0,96(a4)
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	574080e7          	jalr	1396(ra) # 80001c30 <_ZN3PCB14createProccessEPFvvEPv>
    800016c4:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    800016c8:	00005797          	auipc	a5,0x5
    800016cc:	ab87b783          	ld	a5,-1352(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    800016d0:	0007b783          	ld	a5,0(a5)
    800016d4:	0187b703          	ld	a4,24(a5)
    800016d8:	04973823          	sd	s1,80(a4)
                if(*handle == nullptr) break;
    800016dc:	0004b703          	ld	a4,0(s1)
    800016e0:	f2070ce3          	beqz	a4,80001618 <interruptHandler+0x110>
                size_t* stack = (size_t*)PCB::running->registers[14];
    800016e4:	0187b783          	ld	a5,24(a5)
    800016e8:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    800016ec:	00f73423          	sd	a5,8(a4)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    800016f0:	00008737          	lui	a4,0x8
    800016f4:	00e787b3          	add	a5,a5,a4
    800016f8:	0004b703          	ld	a4,0(s1)
    800016fc:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001700:	00f73823          	sd	a5,16(a4)
                break;
    80001704:	f15ff06f          	j	80001618 <interruptHandler+0x110>
                SCB **handle = (SCB**) PCB::running->registers[11];
    80001708:	05873483          	ld	s1,88(a4)
                size_t init = (int) PCB::running->registers[12];
    8000170c:	06072903          	lw	s2,96(a4)

    void* operator new(size_t size);
    void operator delete(void* memSegment);

    static SCB* createSemaphore(int semValue = 1) {
        return new SCB(semValue);
    80001710:	01800513          	li	a0,24
    80001714:	00001097          	auipc	ra,0x1
    80001718:	2fc080e7          	jalr	764(ra) # 80002a10 <_ZN3SCBnwEm>
    }

    // Pre zatvaranja svim procesima koji su cekali na semaforu signalizira da je semafor obrisan i budi ih
    void signalClosing();
private:
    SCB(int semValue_ = 1) {
    8000171c:	00053023          	sd	zero,0(a0)
    80001720:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    80001724:	01252823          	sw	s2,16(a0)
                (*handle) = SCB::createSemaphore(init);
    80001728:	00a4b023          	sd	a0,0(s1)
                PCB::running->registers[10] = (size_t)handle;
    8000172c:	00005797          	auipc	a5,0x5
    80001730:	a547b783          	ld	a5,-1452(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001734:	0007b783          	ld	a5,0(a5)
    80001738:	0187b783          	ld	a5,24(a5)
    8000173c:	0497b823          	sd	s1,80(a5)
                break;
    80001740:	ed9ff06f          	j	80001618 <interruptHandler+0x110>
                PCB::running->registers[10] = sem->wait(); // 0 ako se ispravno probudila, -2 ako se probudila brisanjem semafora
    80001744:	05873503          	ld	a0,88(a4)
    80001748:	00001097          	auipc	ra,0x1
    8000174c:	1a4080e7          	jalr	420(ra) # 800028ec <_ZN3SCB4waitEv>
    80001750:	00005797          	auipc	a5,0x5
    80001754:	a307b783          	ld	a5,-1488(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001758:	0007b783          	ld	a5,0(a5)
    8000175c:	0187b783          	ld	a5,24(a5)
    80001760:	04a7b823          	sd	a0,80(a5)
                break;
    80001764:	eb5ff06f          	j	80001618 <interruptHandler+0x110>
                sem->signal();
    80001768:	05873503          	ld	a0,88(a4)
    8000176c:	00001097          	auipc	ra,0x1
    80001770:	214080e7          	jalr	532(ra) # 80002980 <_ZN3SCB6signalEv>
                break;
    80001774:	ea5ff06f          	j	80001618 <interruptHandler+0x110>
                SCB* sem = (SCB*) PCB::running->registers[11];
    80001778:	05873483          	ld	s1,88(a4)
                sem->signalClosing();
    8000177c:	00048513          	mv	a0,s1
    80001780:	00001097          	auipc	ra,0x1
    80001784:	2e0080e7          	jalr	736(ra) # 80002a60 <_ZN3SCB13signalClosingEv>
                delete sem; // destruktor ce signalizirati svim procesima da je obrisan
    80001788:	e80488e3          	beqz	s1,80001618 <interruptHandler+0x110>
    8000178c:	00048513          	mv	a0,s1
    80001790:	00001097          	auipc	ra,0x1
    80001794:	2a8080e7          	jalr	680(ra) # 80002a38 <_ZN3SCBdlEPv>
    80001798:	e81ff06f          	j	80001618 <interruptHandler+0x110>
                size_t time = (size_t)PCB::running->registers[11];
    8000179c:	05873783          	ld	a5,88(a4)
                PCB::running->timeSleeping = time;
    800017a0:	02f53823          	sd	a5,48(a0)
                SleepingProcesses::putToSleep(PCB::running);
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	12c080e7          	jalr	300(ra) # 800018d0 <_ZN17SleepingProcesses10putToSleepEP3PCB>
                break;
    800017ac:	e6dff06f          	j	80001618 <interruptHandler+0x110>
                CCB::outputBuffer.pushBack(character);
    800017b0:	05874583          	lbu	a1,88(a4)
    800017b4:	00005517          	auipc	a0,0x5
    800017b8:	99453503          	ld	a0,-1644(a0) # 80006148 <_GLOBAL_OFFSET_TABLE_+0x28>
    800017bc:	00000097          	auipc	ra,0x0
    800017c0:	520080e7          	jalr	1312(ra) # 80001cdc <_ZN8IOBuffer8pushBackEc>
                CCB::semOutput->signal();
    800017c4:	00005797          	auipc	a5,0x5
    800017c8:	9cc7b783          	ld	a5,-1588(a5) # 80006190 <_GLOBAL_OFFSET_TABLE_+0x70>
    800017cc:	0007b503          	ld	a0,0(a5)
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	1b0080e7          	jalr	432(ra) # 80002980 <_ZN3SCB6signalEv>
                break;
    800017d8:	e41ff06f          	j	80001618 <interruptHandler+0x110>
                CCB::semInput->signal();
    800017dc:	00005797          	auipc	a5,0x5
    800017e0:	9cc7b783          	ld	a5,-1588(a5) # 800061a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800017e4:	0007b503          	ld	a0,0(a5)
    800017e8:	00001097          	auipc	ra,0x1
    800017ec:	198080e7          	jalr	408(ra) # 80002980 <_ZN3SCB6signalEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    800017f0:	00005517          	auipc	a0,0x5
    800017f4:	96053503          	ld	a0,-1696(a0) # 80006150 <_GLOBAL_OFFSET_TABLE_+0x30>
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	66c080e7          	jalr	1644(ra) # 80001e64 <_ZN8IOBuffer9peekFrontEv>
    80001800:	00051e63          	bnez	a0,8000181c <interruptHandler+0x314>
                    CCB::inputBufferEmpty->wait();
    80001804:	00005797          	auipc	a5,0x5
    80001808:	9947b783          	ld	a5,-1644(a5) # 80006198 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000180c:	0007b503          	ld	a0,0(a5)
    80001810:	00001097          	auipc	ra,0x1
    80001814:	0dc080e7          	jalr	220(ra) # 800028ec <_ZN3SCB4waitEv>
                while(CCB::inputBuffer.peekFront() == 0) {
    80001818:	fd9ff06f          	j	800017f0 <interruptHandler+0x2e8>
                PCB::running->registers[10] = CCB::inputBuffer.popFront();
    8000181c:	00005517          	auipc	a0,0x5
    80001820:	93453503          	ld	a0,-1740(a0) # 80006150 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001824:	00000097          	auipc	ra,0x0
    80001828:	5b0080e7          	jalr	1456(ra) # 80001dd4 <_ZN8IOBuffer8popFrontEv>
    8000182c:	00005797          	auipc	a5,0x5
    80001830:	9547b783          	ld	a5,-1708(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001834:	0007b783          	ld	a5,0(a5)
    80001838:	0187b783          	ld	a5,24(a5)
    8000183c:	04a7b823          	sd	a0,80(a5)
                break;
    80001840:	dd9ff06f          	j	80001618 <interruptHandler+0x110>
                sstatus = sstatus & ~Kernel::BitMaskSstatus::SSTATUS_SPP;
    80001844:	fc843783          	ld	a5,-56(s0)
    80001848:	eff7f793          	andi	a5,a5,-257
    8000184c:	fcf43423          	sd	a5,-56(s0)
                break;
    80001850:	dc9ff06f          	j	80001618 <interruptHandler+0x110>
        PCB::timeSliceCounter++;
    80001854:	00005497          	auipc	s1,0x5
    80001858:	90c4b483          	ld	s1,-1780(s1) # 80006160 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000185c:	0004b783          	ld	a5,0(s1)
    80001860:	00178793          	addi	a5,a5,1
    80001864:	00f4b023          	sd	a5,0(s1)
        SleepingProcesses::wakeUp(); // budi uspavane procese ako su postojali, ako ne smanjuje periodu cekanja za 1
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	0f8080e7          	jalr	248(ra) # 80001960 <_ZN17SleepingProcesses6wakeUpEv>
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001870:	00005797          	auipc	a5,0x5
    80001874:	9107b783          	ld	a5,-1776(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001878:	0007b783          	ld	a5,0(a5)
    8000187c:	0407b703          	ld	a4,64(a5)
    80001880:	0004b783          	ld	a5,0(s1)
    80001884:	00e7f863          	bgeu	a5,a4,80001894 <interruptHandler+0x38c>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001888:	00200793          	li	a5,2
    8000188c:	1447b073          	csrc	sip,a5
    }
    80001890:	d01ff06f          	j	80001590 <interruptHandler+0x88>
            PCB::timeSliceCounter = 0;
    80001894:	0004b023          	sd	zero,0(s1)
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	1c0080e7          	jalr	448(ra) # 80001a58 <_ZN3PCB8dispatchEv>
            Kernel::w_sepc(sepc);
    800018a0:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018a4:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800018a8:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018ac:	10079073          	csrw	sstatus,a5
    }
    800018b0:	fd9ff06f          	j	80001888 <interruptHandler+0x380>
        size_t code = plic_claim();
    800018b4:	00002097          	auipc	ra,0x2
    800018b8:	d80080e7          	jalr	-640(ra) # 80003634 <plic_claim>
        if(code == CONSOLE_IRQ) {
    800018bc:	00a00793          	li	a5,10
    800018c0:	ccf508e3          	beq	a0,a5,80001590 <interruptHandler+0x88>
            plic_complete(code);
    800018c4:	00002097          	auipc	ra,0x2
    800018c8:	da8080e7          	jalr	-600(ra) # 8000366c <plic_complete>
    800018cc:	cc5ff06f          	j	80001590 <interruptHandler+0x88>

00000000800018d0 <_ZN17SleepingProcesses10putToSleepEP3PCB>:
#include "../h/SleepingProcesses.h"
#include "../h/Scheduler.h"

PCB* SleepingProcesses::head = nullptr;

void SleepingProcesses::putToSleep(PCB *process) {
    800018d0:	ff010113          	addi	sp,sp,-16
    800018d4:	00813423          	sd	s0,8(sp)
    800018d8:	01010413          	addi	s0,sp,16
    PCB* curr = head, *prev = nullptr;
    800018dc:	00005797          	auipc	a5,0x5
    800018e0:	9247b783          	ld	a5,-1756(a5) # 80006200 <_ZN17SleepingProcesses4headE>
    bool isSemaphoreDeleted() const {
        return semDeleted;
    }

    size_t getTimeSleeping() const {
        return timeSleeping;
    800018e4:	03053583          	ld	a1,48(a0)
    size_t time = process->getTimeSleeping();
    800018e8:	00058713          	mv	a4,a1
    PCB* curr = head, *prev = nullptr;
    800018ec:	00000613          	li	a2,0
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    800018f0:	00078e63          	beqz	a5,8000190c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
    800018f4:	0307b683          	ld	a3,48(a5)
    800018f8:	00e6fa63          	bgeu	a3,a4,8000190c <_ZN17SleepingProcesses10putToSleepEP3PCB+0x3c>
        prev = curr;
        time -= curr->getTimeSleeping();
    800018fc:	40d70733          	sub	a4,a4,a3
        prev = curr;
    80001900:	00078613          	mv	a2,a5
        curr = curr->getNextInList();
    80001904:	0007b783          	ld	a5,0(a5)
    while(curr && curr->getTimeSleeping() < time) { // ako su iste vrednosti oba ce biti izvadjena
    80001908:	fe9ff06f          	j	800018f0 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x20>
    void setNextInList(PCB* next) {
        nextInList = next;
    }

    void setBlocked(bool newState) {
        blocked = newState;
    8000190c:	00100693          	li	a3,1
    80001910:	02d504a3          	sb	a3,41(a0)
    }

    process->setBlocked(true); // postavljamo proces u blocked stanje
    if(!prev) {
    80001914:	02060663          	beqz	a2,80001940 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x70>
        nextInList = next;
    80001918:	00a63023          	sd	a0,0(a2)
        timeSleeping = newTime;
    8000191c:	02e53823          	sd	a4,48(a0)
        nextInList = next;
    80001920:	00f53023          	sd	a5,0(a0)
    else {
        prev->setNextInList(process);
        // vrednost ce biti relativna u odnosu na prosli clan pa cemo moci da izbacimo samo prvih k elemenata
        process->setTimeSleeping(time); // razlika izmedju tekuceg i proslog
        process->setNextInList(curr);
        if(curr) {
    80001924:	00078863          	beqz	a5,80001934 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001928:	0307b683          	ld	a3,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    8000192c:	40e68733          	sub	a4,a3,a4
        timeSleeping = newTime;
    80001930:	02e7b823          	sd	a4,48(a5)
        }
    }
}
    80001934:	00813403          	ld	s0,8(sp)
    80001938:	01010113          	addi	sp,sp,16
    8000193c:	00008067          	ret
        head = process;
    80001940:	00005717          	auipc	a4,0x5
    80001944:	8ca73023          	sd	a0,-1856(a4) # 80006200 <_ZN17SleepingProcesses4headE>
        nextInList = next;
    80001948:	00f53023          	sd	a5,0(a0)
        if(curr) {
    8000194c:	fe0784e3          	beqz	a5,80001934 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>
        return timeSleeping;
    80001950:	0307b703          	ld	a4,48(a5)
            curr->setTimeSleeping(curr->getTimeSleeping() - process->getTimeSleeping());
    80001954:	40b705b3          	sub	a1,a4,a1
        timeSleeping = newTime;
    80001958:	02b7b823          	sd	a1,48(a5)
    }
    8000195c:	fd9ff06f          	j	80001934 <_ZN17SleepingProcesses10putToSleepEP3PCB+0x64>

0000000080001960 <_ZN17SleepingProcesses6wakeUpEv>:

void SleepingProcesses::wakeUp() {
    if(!head) return;
    80001960:	00005517          	auipc	a0,0x5
    80001964:	8a053503          	ld	a0,-1888(a0) # 80006200 <_ZN17SleepingProcesses4headE>
    80001968:	08050063          	beqz	a0,800019e8 <_ZN17SleepingProcesses6wakeUpEv+0x88>
        return timeSleeping;
    8000196c:	03053783          	ld	a5,48(a0)

    head->setTimeSleeping(head->getTimeSleeping()-1); // smanjuje periodu cekanja
    80001970:	fff78793          	addi	a5,a5,-1
        timeSleeping = newTime;
    80001974:	02f53823          	sd	a5,48(a0)
    PCB* curr = head;
    while(curr && curr->getTimeSleeping() == 0) {
    80001978:	06050263          	beqz	a0,800019dc <_ZN17SleepingProcesses6wakeUpEv+0x7c>
        return timeSleeping;
    8000197c:	03053783          	ld	a5,48(a0)
    80001980:	04079e63          	bnez	a5,800019dc <_ZN17SleepingProcesses6wakeUpEv+0x7c>
void SleepingProcesses::wakeUp() {
    80001984:	fe010113          	addi	sp,sp,-32
    80001988:	00113c23          	sd	ra,24(sp)
    8000198c:	00813823          	sd	s0,16(sp)
    80001990:	00913423          	sd	s1,8(sp)
    80001994:	02010413          	addi	s0,sp,32
    80001998:	00c0006f          	j	800019a4 <_ZN17SleepingProcesses6wakeUpEv+0x44>
    8000199c:	0304b783          	ld	a5,48(s1)
    while(curr && curr->getTimeSleeping() == 0) {
    800019a0:	02079063          	bnez	a5,800019c0 <_ZN17SleepingProcesses6wakeUpEv+0x60>
        return nextInList;
    800019a4:	00053483          	ld	s1,0(a0)
        nextInList = next;
    800019a8:	00053023          	sd	zero,0(a0)
        blocked = newState;
    800019ac:	020504a3          	sb	zero,41(a0)
        PCB* process = curr;
        curr = curr->getNextInList();
        process->setNextInList(nullptr);
        process->setBlocked(false);

        Scheduler::put(process);
    800019b0:	00000097          	auipc	ra,0x0
    800019b4:	584080e7          	jalr	1412(ra) # 80001f34 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    800019b8:	00048513          	mv	a0,s1
    while(curr && curr->getTimeSleeping() == 0) {
    800019bc:	fe0490e3          	bnez	s1,8000199c <_ZN17SleepingProcesses6wakeUpEv+0x3c>
    }

    head = curr;
    800019c0:	00005797          	auipc	a5,0x5
    800019c4:	84a7b023          	sd	a0,-1984(a5) # 80006200 <_ZN17SleepingProcesses4headE>
}
    800019c8:	01813083          	ld	ra,24(sp)
    800019cc:	01013403          	ld	s0,16(sp)
    800019d0:	00813483          	ld	s1,8(sp)
    800019d4:	02010113          	addi	sp,sp,32
    800019d8:	00008067          	ret
    head = curr;
    800019dc:	00005797          	auipc	a5,0x5
    800019e0:	82a7b223          	sd	a0,-2012(a5) # 80006200 <_ZN17SleepingProcesses4headE>
    800019e4:	00008067          	ret
    800019e8:	00008067          	ret

00000000800019ec <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    800019ec:	ff010113          	addi	sp,sp,-16
    800019f0:	00113423          	sd	ra,8(sp)
    800019f4:	00813023          	sd	s0,0(sp)
    800019f8:	01010413          	addi	s0,sp,16
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	aec080e7          	jalr	-1300(ra) # 800014e8 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001a04:	00005797          	auipc	a5,0x5
    80001a08:	8047b783          	ld	a5,-2044(a5) # 80006208 <_ZN3PCB7runningE>
    80001a0c:	0387b703          	ld	a4,56(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001a10:	00070513          	mv	a0,a4
    running->main();
    80001a14:	0207b783          	ld	a5,32(a5)
    80001a18:	000780e7          	jalr	a5
    thread_exit();
    80001a1c:	00000097          	auipc	ra,0x0
    80001a20:	864080e7          	jalr	-1948(ra) # 80001280 <_Z11thread_exitv>
}
    80001a24:	00813083          	ld	ra,8(sp)
    80001a28:	00013403          	ld	s0,0(sp)
    80001a2c:	01010113          	addi	sp,sp,16
    80001a30:	00008067          	ret

0000000080001a34 <_ZN3PCB5yieldEv>:
void PCB::yield() {
    80001a34:	ff010113          	addi	sp,sp,-16
    80001a38:	00813423          	sd	s0,8(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    asm volatile("mv a0, %0" : : "r" (code));
    80001a40:	01300793          	li	a5,19
    80001a44:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001a48:	00000073          	ecall
}
    80001a4c:	00813403          	ld	s0,8(sp)
    80001a50:	01010113          	addi	sp,sp,16
    80001a54:	00008067          	ret

0000000080001a58 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001a58:	fe010113          	addi	sp,sp,-32
    80001a5c:	00113c23          	sd	ra,24(sp)
    80001a60:	00813823          	sd	s0,16(sp)
    80001a64:	00913423          	sd	s1,8(sp)
    80001a68:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001a6c:	00004497          	auipc	s1,0x4
    80001a70:	79c4b483          	ld	s1,1948(s1) # 80006208 <_ZN3PCB7runningE>
        return finished;
    80001a74:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->blocked) { // ako se nije zavrsio i nije blokiran
    80001a78:	00079663          	bnez	a5,80001a84 <_ZN3PCB8dispatchEv+0x2c>
    80001a7c:	0294c783          	lbu	a5,41(s1)
    80001a80:	04078263          	beqz	a5,80001ac4 <_ZN3PCB8dispatchEv+0x6c>
    running = Scheduler::get();
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	508080e7          	jalr	1288(ra) # 80001f8c <_ZN9Scheduler3getEv>
    80001a8c:	00004797          	auipc	a5,0x4
    80001a90:	76a7be23          	sd	a0,1916(a5) # 80006208 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    80001a94:	04854783          	lbu	a5,72(a0)
    80001a98:	02078e63          	beqz	a5,80001ad4 <_ZN3PCB8dispatchEv+0x7c>
        PCB::running->firstCall = false;
    80001a9c:	04050423          	sb	zero,72(a0)
        switchContext1(old->registers, running->registers);
    80001aa0:	01853583          	ld	a1,24(a0)
    80001aa4:	0184b503          	ld	a0,24(s1)
    80001aa8:	fffff097          	auipc	ra,0xfffff
    80001aac:	680080e7          	jalr	1664(ra) # 80001128 <_ZN3PCB14switchContext1EPmS0_>
}
    80001ab0:	01813083          	ld	ra,24(sp)
    80001ab4:	01013403          	ld	s0,16(sp)
    80001ab8:	00813483          	ld	s1,8(sp)
    80001abc:	02010113          	addi	sp,sp,32
    80001ac0:	00008067          	ret
        Scheduler::put(old);
    80001ac4:	00048513          	mv	a0,s1
    80001ac8:	00000097          	auipc	ra,0x0
    80001acc:	46c080e7          	jalr	1132(ra) # 80001f34 <_ZN9Scheduler3putEP3PCB>
    80001ad0:	fb5ff06f          	j	80001a84 <_ZN3PCB8dispatchEv+0x2c>
        switchContext2(old->registers, running->registers);
    80001ad4:	01853583          	ld	a1,24(a0)
    80001ad8:	0184b503          	ld	a0,24(s1)
    80001adc:	fffff097          	auipc	ra,0xfffff
    80001ae0:	660080e7          	jalr	1632(ra) # 8000113c <_ZN3PCB14switchContext2EPmS0_>
}
    80001ae4:	fcdff06f          	j	80001ab0 <_ZN3PCB8dispatchEv+0x58>

0000000080001ae8 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001ae8:	fe010113          	addi	sp,sp,-32
    80001aec:	00113c23          	sd	ra,24(sp)
    80001af0:	00813823          	sd	s0,16(sp)
    80001af4:	00913423          	sd	s1,8(sp)
    80001af8:	02010413          	addi	s0,sp,32
    80001afc:	00050493          	mv	s1,a0
    80001b00:	00053023          	sd	zero,0(a0)
    80001b04:	00053c23          	sd	zero,24(a0)
    80001b08:	02053823          	sd	zero,48(a0)
    80001b0c:	00100793          	li	a5,1
    80001b10:	04f50423          	sb	a5,72(a0)
    finished = blocked = semDeleted = false;
    80001b14:	02050523          	sb	zero,42(a0)
    80001b18:	020504a3          	sb	zero,41(a0)
    80001b1c:	02050423          	sb	zero,40(a0)
    main = main_;
    80001b20:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001b24:	04c53023          	sd	a2,64(a0)
    mainArguments = mainArguments_;
    80001b28:	02d53c23          	sd	a3,56(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    80001b2c:	10800513          	li	a0,264
    80001b30:	00001097          	auipc	ra,0x1
    80001b34:	f94080e7          	jalr	-108(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
    80001b38:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    80001b3c:	00008537          	lui	a0,0x8
    80001b40:	00001097          	auipc	ra,0x1
    80001b44:	f84080e7          	jalr	-124(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
    80001b48:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    80001b4c:	000087b7          	lui	a5,0x8
    80001b50:	00f50533          	add	a0,a0,a5
    80001b54:	0184b783          	ld	a5,24(s1)
    80001b58:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    80001b5c:	0184b783          	ld	a5,24(s1)
    80001b60:	00000717          	auipc	a4,0x0
    80001b64:	e8c70713          	addi	a4,a4,-372 # 800019ec <_ZN3PCB15proccessWrapperEv>
    80001b68:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    80001b6c:	0004b423          	sd	zero,8(s1)
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001b70:	0204b783          	ld	a5,32(s1)
    80001b74:	00078c63          	beqz	a5,80001b8c <_ZN3PCBC1EPFvvEmPv+0xa4>
}
    80001b78:	01813083          	ld	ra,24(sp)
    80001b7c:	01013403          	ld	s0,16(sp)
    80001b80:	00813483          	ld	s1,8(sp)
    80001b84:	02010113          	addi	sp,sp,32
    80001b88:	00008067          	ret
    if(main == nullptr) firstCall = false; //  jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001b8c:	04048423          	sb	zero,72(s1)
}
    80001b90:	fe9ff06f          	j	80001b78 <_ZN3PCBC1EPFvvEmPv+0x90>

0000000080001b94 <_ZN3PCBD1Ev>:
PCB::~PCB() {
    80001b94:	fe010113          	addi	sp,sp,-32
    80001b98:	00113c23          	sd	ra,24(sp)
    80001b9c:	00813823          	sd	s0,16(sp)
    80001ba0:	00913423          	sd	s1,8(sp)
    80001ba4:	02010413          	addi	s0,sp,32
    80001ba8:	00050493          	mv	s1,a0
    delete[] stack;
    80001bac:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001bb0:	00050663          	beqz	a0,80001bbc <_ZN3PCBD1Ev+0x28>
    80001bb4:	00000097          	auipc	ra,0x0
    80001bb8:	788080e7          	jalr	1928(ra) # 8000233c <_ZdaPv>
    delete[] sysStack;
    80001bbc:	0104b503          	ld	a0,16(s1)
    80001bc0:	00050663          	beqz	a0,80001bcc <_ZN3PCBD1Ev+0x38>
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	778080e7          	jalr	1912(ra) # 8000233c <_ZdaPv>
}
    80001bcc:	01813083          	ld	ra,24(sp)
    80001bd0:	01013403          	ld	s0,16(sp)
    80001bd4:	00813483          	ld	s1,8(sp)
    80001bd8:	02010113          	addi	sp,sp,32
    80001bdc:	00008067          	ret

0000000080001be0 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001be0:	ff010113          	addi	sp,sp,-16
    80001be4:	00113423          	sd	ra,8(sp)
    80001be8:	00813023          	sd	s0,0(sp)
    80001bec:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001bf0:	00001097          	auipc	ra,0x1
    80001bf4:	ed4080e7          	jalr	-300(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001bf8:	00813083          	ld	ra,8(sp)
    80001bfc:	00013403          	ld	s0,0(sp)
    80001c00:	01010113          	addi	sp,sp,16
    80001c04:	00008067          	ret

0000000080001c08 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001c08:	ff010113          	addi	sp,sp,-16
    80001c0c:	00113423          	sd	ra,8(sp)
    80001c10:	00813023          	sd	s0,0(sp)
    80001c14:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001c18:	00001097          	auipc	ra,0x1
    80001c1c:	010080e7          	jalr	16(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001c20:	00813083          	ld	ra,8(sp)
    80001c24:	00013403          	ld	s0,0(sp)
    80001c28:	01010113          	addi	sp,sp,16
    80001c2c:	00008067          	ret

0000000080001c30 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001c30:	fd010113          	addi	sp,sp,-48
    80001c34:	02113423          	sd	ra,40(sp)
    80001c38:	02813023          	sd	s0,32(sp)
    80001c3c:	00913c23          	sd	s1,24(sp)
    80001c40:	01213823          	sd	s2,16(sp)
    80001c44:	01313423          	sd	s3,8(sp)
    80001c48:	03010413          	addi	s0,sp,48
    80001c4c:	00050913          	mv	s2,a0
    80001c50:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001c54:	05000513          	li	a0,80
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	f88080e7          	jalr	-120(ra) # 80001be0 <_ZN3PCBnwEm>
    80001c60:	00050493          	mv	s1,a0
    80001c64:	00098693          	mv	a3,s3
    80001c68:	00200613          	li	a2,2
    80001c6c:	00090593          	mv	a1,s2
    80001c70:	00000097          	auipc	ra,0x0
    80001c74:	e78080e7          	jalr	-392(ra) # 80001ae8 <_ZN3PCBC1EPFvvEmPv>
    80001c78:	0200006f          	j	80001c98 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001c7c:	00050913          	mv	s2,a0
    80001c80:	00048513          	mv	a0,s1
    80001c84:	00000097          	auipc	ra,0x0
    80001c88:	f84080e7          	jalr	-124(ra) # 80001c08 <_ZN3PCBdlEPv>
    80001c8c:	00090513          	mv	a0,s2
    80001c90:	00005097          	auipc	ra,0x5
    80001c94:	6c8080e7          	jalr	1736(ra) # 80007358 <_Unwind_Resume>
}
    80001c98:	00048513          	mv	a0,s1
    80001c9c:	02813083          	ld	ra,40(sp)
    80001ca0:	02013403          	ld	s0,32(sp)
    80001ca4:	01813483          	ld	s1,24(sp)
    80001ca8:	01013903          	ld	s2,16(sp)
    80001cac:	00813983          	ld	s3,8(sp)
    80001cb0:	03010113          	addi	sp,sp,48
    80001cb4:	00008067          	ret

0000000080001cb8 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001cb8:	ff010113          	addi	sp,sp,-16
    80001cbc:	00813423          	sd	s0,8(sp)
    80001cc0:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001cc4:	00004797          	auipc	a5,0x4
    80001cc8:	5447b783          	ld	a5,1348(a5) # 80006208 <_ZN3PCB7runningE>
    80001ccc:	0187b503          	ld	a0,24(a5)
    80001cd0:	00813403          	ld	s0,8(sp)
    80001cd4:	01010113          	addi	sp,sp,16
    80001cd8:	00008067          	ret

0000000080001cdc <_ZN8IOBuffer8pushBackEc>:
        thread_dispatch();
    }
}


void IOBuffer::pushBack(char c) {
    80001cdc:	fe010113          	addi	sp,sp,-32
    80001ce0:	00113c23          	sd	ra,24(sp)
    80001ce4:	00813823          	sd	s0,16(sp)
    80001ce8:	00913423          	sd	s1,8(sp)
    80001cec:	01213023          	sd	s2,0(sp)
    80001cf0:	02010413          	addi	s0,sp,32
    80001cf4:	00050493          	mv	s1,a0
    80001cf8:	00058913          	mv	s2,a1
    Elem *newElem = (Elem*)MemoryAllocator::mem_alloc(sizeof(Elem));
    80001cfc:	01000513          	li	a0,16
    80001d00:	00001097          	auipc	ra,0x1
    80001d04:	dc4080e7          	jalr	-572(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
    newElem->next = nullptr;
    80001d08:	00053023          	sd	zero,0(a0)
    newElem->data = c;
    80001d0c:	01250423          	sb	s2,8(a0)
    if(!head) {
    80001d10:	0004b783          	ld	a5,0(s1)
    80001d14:	02078863          	beqz	a5,80001d44 <_ZN8IOBuffer8pushBackEc+0x68>
        head = tail = newElem;
    }
    else {
        tail->next = newElem;
    80001d18:	0084b783          	ld	a5,8(s1)
    80001d1c:	00a7b023          	sd	a0,0(a5)
        tail = tail->next;
    80001d20:	0084b783          	ld	a5,8(s1)
    80001d24:	0007b783          	ld	a5,0(a5)
    80001d28:	00f4b423          	sd	a5,8(s1)
    }
}
    80001d2c:	01813083          	ld	ra,24(sp)
    80001d30:	01013403          	ld	s0,16(sp)
    80001d34:	00813483          	ld	s1,8(sp)
    80001d38:	00013903          	ld	s2,0(sp)
    80001d3c:	02010113          	addi	sp,sp,32
    80001d40:	00008067          	ret
        head = tail = newElem;
    80001d44:	00a4b423          	sd	a0,8(s1)
    80001d48:	00a4b023          	sd	a0,0(s1)
    80001d4c:	fe1ff06f          	j	80001d2c <_ZN8IOBuffer8pushBackEc+0x50>

0000000080001d50 <_ZN3CCB9inputBodyEPv>:
void CCB::inputBody(void *) {
    80001d50:	fe010113          	addi	sp,sp,-32
    80001d54:	00113c23          	sd	ra,24(sp)
    80001d58:	00813823          	sd	s0,16(sp)
    80001d5c:	00913423          	sd	s1,8(sp)
    80001d60:	02010413          	addi	s0,sp,32
    80001d64:	00c0006f          	j	80001d70 <_ZN3CCB9inputBodyEPv+0x20>
        thread_dispatch();
    80001d68:	fffff097          	auipc	ra,0xfffff
    80001d6c:	4ec080e7          	jalr	1260(ra) # 80001254 <_Z15thread_dispatchv>
        if(*(char*)CONSOLE_STATUS & CONSOLE_RX_STATUS_BIT) {
    80001d70:	00004797          	auipc	a5,0x4
    80001d74:	3c87b783          	ld	a5,968(a5) # 80006138 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001d78:	0007b783          	ld	a5,0(a5)
    80001d7c:	0007c783          	lbu	a5,0(a5)
    80001d80:	0017f793          	andi	a5,a5,1
    80001d84:	fe0782e3          	beqz	a5,80001d68 <_ZN3CCB9inputBodyEPv+0x18>
            inputBuffer.pushBack(*(char*)CONSOLE_RX_DATA);
    80001d88:	00004797          	auipc	a5,0x4
    80001d8c:	3a07b783          	ld	a5,928(a5) # 80006128 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001d90:	0007b783          	ld	a5,0(a5)
    80001d94:	00004497          	auipc	s1,0x4
    80001d98:	48448493          	addi	s1,s1,1156 # 80006218 <_ZN3CCB11inputBufferE>
    80001d9c:	0007c583          	lbu	a1,0(a5)
    80001da0:	00048513          	mv	a0,s1
    80001da4:	00000097          	auipc	ra,0x0
    80001da8:	f38080e7          	jalr	-200(ra) # 80001cdc <_ZN8IOBuffer8pushBackEc>
            sem_signal(CCB::inputBufferEmpty);
    80001dac:	0104b503          	ld	a0,16(s1)
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	610080e7          	jalr	1552(ra) # 800013c0 <_Z10sem_signalP3SCB>
            plic_complete(CONSOLE_IRQ);
    80001db8:	00a00513          	li	a0,10
    80001dbc:	00002097          	auipc	ra,0x2
    80001dc0:	8b0080e7          	jalr	-1872(ra) # 8000366c <plic_complete>
            sem_wait(semInput);
    80001dc4:	0184b503          	ld	a0,24(s1)
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	5b0080e7          	jalr	1456(ra) # 80001378 <_Z8sem_waitP3SCB>
    80001dd0:	f99ff06f          	j	80001d68 <_ZN3CCB9inputBodyEPv+0x18>

0000000080001dd4 <_ZN8IOBuffer8popFrontEv>:

char IOBuffer::popFront() {
    80001dd4:	fe010113          	addi	sp,sp,-32
    80001dd8:	00113c23          	sd	ra,24(sp)
    80001ddc:	00813823          	sd	s0,16(sp)
    80001de0:	00913423          	sd	s1,8(sp)
    80001de4:	02010413          	addi	s0,sp,32
    80001de8:	00050793          	mv	a5,a0
    if(!head) return 0;
    80001dec:	00053503          	ld	a0,0(a0)
    80001df0:	04050063          	beqz	a0,80001e30 <_ZN8IOBuffer8popFrontEv+0x5c>

    Elem* curr = head;
    head = head->next;
    80001df4:	00053703          	ld	a4,0(a0)
    80001df8:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) tail = nullptr;
    80001dfc:	0087b703          	ld	a4,8(a5)
    80001e00:	02e50463          	beq	a0,a4,80001e28 <_ZN8IOBuffer8popFrontEv+0x54>

    char c = curr->data;
    80001e04:	00854483          	lbu	s1,8(a0)
    MemoryAllocator::mem_free(curr);
    80001e08:	00001097          	auipc	ra,0x1
    80001e0c:	e20080e7          	jalr	-480(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
    return c;
}
    80001e10:	00048513          	mv	a0,s1
    80001e14:	01813083          	ld	ra,24(sp)
    80001e18:	01013403          	ld	s0,16(sp)
    80001e1c:	00813483          	ld	s1,8(sp)
    80001e20:	02010113          	addi	sp,sp,32
    80001e24:	00008067          	ret
    if(tail == curr) tail = nullptr;
    80001e28:	0007b423          	sd	zero,8(a5)
    80001e2c:	fd9ff06f          	j	80001e04 <_ZN8IOBuffer8popFrontEv+0x30>
    if(!head) return 0;
    80001e30:	00000493          	li	s1,0
    80001e34:	fddff06f          	j	80001e10 <_ZN8IOBuffer8popFrontEv+0x3c>

0000000080001e38 <_ZN8IOBuffer8peekBackEv>:

char IOBuffer::peekBack() {
    80001e38:	ff010113          	addi	sp,sp,-16
    80001e3c:	00813423          	sd	s0,8(sp)
    80001e40:	01010413          	addi	s0,sp,16
    return tail ? tail->data : 0;
    80001e44:	00853783          	ld	a5,8(a0)
    80001e48:	00078a63          	beqz	a5,80001e5c <_ZN8IOBuffer8peekBackEv+0x24>
    80001e4c:	0087c503          	lbu	a0,8(a5)
}
    80001e50:	00813403          	ld	s0,8(sp)
    80001e54:	01010113          	addi	sp,sp,16
    80001e58:	00008067          	ret
    return tail ? tail->data : 0;
    80001e5c:	00000513          	li	a0,0
    80001e60:	ff1ff06f          	j	80001e50 <_ZN8IOBuffer8peekBackEv+0x18>

0000000080001e64 <_ZN8IOBuffer9peekFrontEv>:

char IOBuffer::peekFront() {
    80001e64:	ff010113          	addi	sp,sp,-16
    80001e68:	00813423          	sd	s0,8(sp)
    80001e6c:	01010413          	addi	s0,sp,16
    return head ? head->data : 0;
    80001e70:	00053783          	ld	a5,0(a0)
    80001e74:	00078a63          	beqz	a5,80001e88 <_ZN8IOBuffer9peekFrontEv+0x24>
    80001e78:	0087c503          	lbu	a0,8(a5)
}
    80001e7c:	00813403          	ld	s0,8(sp)
    80001e80:	01010113          	addi	sp,sp,16
    80001e84:	00008067          	ret
    return head ? head->data : 0;
    80001e88:	00000513          	li	a0,0
    80001e8c:	ff1ff06f          	j	80001e7c <_ZN8IOBuffer9peekFrontEv+0x18>

0000000080001e90 <_ZN3CCB10outputBodyEPv>:
void CCB::outputBody(void *) {
    80001e90:	fe010113          	addi	sp,sp,-32
    80001e94:	00113c23          	sd	ra,24(sp)
    80001e98:	00813823          	sd	s0,16(sp)
    80001e9c:	00913423          	sd	s1,8(sp)
    80001ea0:	02010413          	addi	s0,sp,32
    80001ea4:	00c0006f          	j	80001eb0 <_ZN3CCB10outputBodyEPv+0x20>
        thread_dispatch();
    80001ea8:	fffff097          	auipc	ra,0xfffff
    80001eac:	3ac080e7          	jalr	940(ra) # 80001254 <_Z15thread_dispatchv>
        if(*(char*)CONSOLE_STATUS & CONSOLE_TX_STATUS_BIT) {
    80001eb0:	00004797          	auipc	a5,0x4
    80001eb4:	2887b783          	ld	a5,648(a5) # 80006138 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001eb8:	0007b783          	ld	a5,0(a5)
    80001ebc:	0007c783          	lbu	a5,0(a5)
    80001ec0:	0207f793          	andi	a5,a5,32
    80001ec4:	fe0782e3          	beqz	a5,80001ea8 <_ZN3CCB10outputBodyEPv+0x18>
            if(outputBuffer.peekFront() != 0) {
    80001ec8:	00004517          	auipc	a0,0x4
    80001ecc:	37050513          	addi	a0,a0,880 # 80006238 <_ZN3CCB12outputBufferE>
    80001ed0:	00000097          	auipc	ra,0x0
    80001ed4:	f94080e7          	jalr	-108(ra) # 80001e64 <_ZN8IOBuffer9peekFrontEv>
    80001ed8:	fc0508e3          	beqz	a0,80001ea8 <_ZN3CCB10outputBodyEPv+0x18>
                *((char*)CONSOLE_TX_DATA) = outputBuffer.popFront();
    80001edc:	00004797          	auipc	a5,0x4
    80001ee0:	27c7b783          	ld	a5,636(a5) # 80006158 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001ee4:	0007b483          	ld	s1,0(a5)
    80001ee8:	00004517          	auipc	a0,0x4
    80001eec:	35050513          	addi	a0,a0,848 # 80006238 <_ZN3CCB12outputBufferE>
    80001ef0:	00000097          	auipc	ra,0x0
    80001ef4:	ee4080e7          	jalr	-284(ra) # 80001dd4 <_ZN8IOBuffer8popFrontEv>
    80001ef8:	00a48023          	sb	a0,0(s1)
                plic_complete(CONSOLE_IRQ);
    80001efc:	00a00513          	li	a0,10
    80001f00:	00001097          	auipc	ra,0x1
    80001f04:	76c080e7          	jalr	1900(ra) # 8000366c <plic_complete>
                sem_wait(semOutput);
    80001f08:	00004517          	auipc	a0,0x4
    80001f0c:	34053503          	ld	a0,832(a0) # 80006248 <_ZN3CCB9semOutputE>
    80001f10:	fffff097          	auipc	ra,0xfffff
    80001f14:	468080e7          	jalr	1128(ra) # 80001378 <_Z8sem_waitP3SCB>
    80001f18:	f91ff06f          	j	80001ea8 <_ZN3CCB10outputBodyEPv+0x18>

0000000080001f1c <_Z8userMainv>:

void userMain() {
    80001f1c:	ff010113          	addi	sp,sp,-16
    80001f20:	00813423          	sd	s0,8(sp)
    80001f24:	01010413          	addi	s0,sp,16
    return;
    80001f28:	00813403          	ld	s0,8(sp)
    80001f2c:	01010113          	addi	sp,sp,16
    80001f30:	00008067          	ret

0000000080001f34 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    80001f34:	ff010113          	addi	sp,sp,-16
    80001f38:	00813423          	sd	s0,8(sp)
    80001f3c:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001f40:	02050663          	beqz	a0,80001f6c <_ZN9Scheduler3putEP3PCB+0x38>
    process->nextInList = nullptr;
    80001f44:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    80001f48:	00004797          	auipc	a5,0x4
    80001f4c:	3187b783          	ld	a5,792(a5) # 80006260 <_ZN9Scheduler4tailE>
    80001f50:	02078463          	beqz	a5,80001f78 <_ZN9Scheduler3putEP3PCB+0x44>
        head = tail = process;
    }
    else {
        tail->nextInList = process;
    80001f54:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextInList;
    80001f58:	00004797          	auipc	a5,0x4
    80001f5c:	30878793          	addi	a5,a5,776 # 80006260 <_ZN9Scheduler4tailE>
    80001f60:	0007b703          	ld	a4,0(a5)
    80001f64:	00073703          	ld	a4,0(a4)
    80001f68:	00e7b023          	sd	a4,0(a5)
    }
}
    80001f6c:	00813403          	ld	s0,8(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret
        head = tail = process;
    80001f78:	00004797          	auipc	a5,0x4
    80001f7c:	2e878793          	addi	a5,a5,744 # 80006260 <_ZN9Scheduler4tailE>
    80001f80:	00a7b023          	sd	a0,0(a5)
    80001f84:	00a7b423          	sd	a0,8(a5)
    80001f88:	fe5ff06f          	j	80001f6c <_ZN9Scheduler3putEP3PCB+0x38>

0000000080001f8c <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001f8c:	ff010113          	addi	sp,sp,-16
    80001f90:	00813423          	sd	s0,8(sp)
    80001f94:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001f98:	00004517          	auipc	a0,0x4
    80001f9c:	2d053503          	ld	a0,720(a0) # 80006268 <_ZN9Scheduler4headE>
    80001fa0:	02050463          	beqz	a0,80001fc8 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextInList;
    80001fa4:	00053703          	ld	a4,0(a0)
    80001fa8:	00004797          	auipc	a5,0x4
    80001fac:	2b878793          	addi	a5,a5,696 # 80006260 <_ZN9Scheduler4tailE>
    80001fb0:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    80001fb4:	0007b783          	ld	a5,0(a5)
    80001fb8:	00f50e63          	beq	a0,a5,80001fd4 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001fbc:	00813403          	ld	s0,8(sp)
    80001fc0:	01010113          	addi	sp,sp,16
    80001fc4:	00008067          	ret
        return idleProcess;
    80001fc8:	00004517          	auipc	a0,0x4
    80001fcc:	2a853503          	ld	a0,680(a0) # 80006270 <_ZN9Scheduler11idleProcessE>
    80001fd0:	fedff06f          	j	80001fbc <_ZN9Scheduler3getEv+0x30>
        tail = head;
    80001fd4:	00004797          	auipc	a5,0x4
    80001fd8:	28e7b623          	sd	a4,652(a5) # 80006260 <_ZN9Scheduler4tailE>
    80001fdc:	fe1ff06f          	j	80001fbc <_ZN9Scheduler3getEv+0x30>

0000000080001fe0 <_ZN9Scheduler10putInFrontEP3PCB>:

void Scheduler::putInFront(PCB *process) {
    80001fe0:	ff010113          	addi	sp,sp,-16
    80001fe4:	00813423          	sd	s0,8(sp)
    80001fe8:	01010413          	addi	s0,sp,16
    if(!process) return;
    80001fec:	00050e63          	beqz	a0,80002008 <_ZN9Scheduler10putInFrontEP3PCB+0x28>
    process->nextInList = head;
    80001ff0:	00004797          	auipc	a5,0x4
    80001ff4:	2787b783          	ld	a5,632(a5) # 80006268 <_ZN9Scheduler4headE>
    80001ff8:	00f53023          	sd	a5,0(a0)
    if(!head) {
    80001ffc:	00078c63          	beqz	a5,80002014 <_ZN9Scheduler10putInFrontEP3PCB+0x34>
        head = tail = process;
    }
    else {
        head = process;
    80002000:	00004797          	auipc	a5,0x4
    80002004:	26a7b423          	sd	a0,616(a5) # 80006268 <_ZN9Scheduler4headE>
    }
}
    80002008:	00813403          	ld	s0,8(sp)
    8000200c:	01010113          	addi	sp,sp,16
    80002010:	00008067          	ret
        head = tail = process;
    80002014:	00004797          	auipc	a5,0x4
    80002018:	24c78793          	addi	a5,a5,588 # 80006260 <_ZN9Scheduler4tailE>
    8000201c:	00a7b023          	sd	a0,0(a5)
    80002020:	00a7b423          	sd	a0,8(a5)
    80002024:	fe5ff06f          	j	80002008 <_ZN9Scheduler10putInFrontEP3PCB+0x28>

0000000080002028 <idleProcess>:
#include "../h/CCB.h"
#include "../h/userMain.h"

// Kernel inicijalizacija
extern "C" void interrupt();
extern "C" void idleProcess(void*) {
    80002028:	ff010113          	addi	sp,sp,-16
    8000202c:	00813423          	sd	s0,8(sp)
    80002030:	01010413          	addi	s0,sp,16
    while(true) {}
    80002034:	0000006f          	j	80002034 <idleProcess+0xc>

0000000080002038 <_Z8userModev>:
#define USERMAIN_H

PCB* userProcess = nullptr;

extern "C" void interrupt();
void userMode() {
    80002038:	ff010113          	addi	sp,sp,-16
    8000203c:	00813423          	sd	s0,8(sp)
    80002040:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::userMode;
    asm volatile("mv a0, %0" : : "r" (code));
    80002044:	04300793          	li	a5,67
    80002048:	00078513          	mv	a0,a5
    asm volatile("ecall");
    8000204c:	00000073          	ecall

}
    80002050:	00813403          	ld	s0,8(sp)
    80002054:	01010113          	addi	sp,sp,16
    80002058:	00008067          	ret

000000008000205c <_Z15userMainWrapperPv>:
void userMain();
void userMainWrapper(void*) {
    8000205c:	ff010113          	addi	sp,sp,-16
    80002060:	00113423          	sd	ra,8(sp)
    80002064:	00813023          	sd	s0,0(sp)
    80002068:	01010413          	addi	s0,sp,16
    userMode();
    8000206c:	00000097          	auipc	ra,0x0
    80002070:	fcc080e7          	jalr	-52(ra) # 80002038 <_Z8userModev>
    userMain();
    80002074:	00000097          	auipc	ra,0x0
    80002078:	ea8080e7          	jalr	-344(ra) # 80001f1c <_Z8userMainv>
}
    8000207c:	00813083          	ld	ra,8(sp)
    80002080:	00013403          	ld	s0,0(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <main>:
}
// ------------

int main() {
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	02010413          	addi	s0,sp,32
    // Kernel inicijalizacija
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    800020a0:	00004797          	auipc	a5,0x4
    800020a4:	1007b783          	ld	a5,256(a5) # 800061a0 <_GLOBAL_OFFSET_TABLE_+0x80>
    800020a8:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main proces(ne pravimo stek)
    800020ac:	00000593          	li	a1,0
    800020b0:	00000513          	li	a0,0
    800020b4:	00000097          	auipc	ra,0x0
    800020b8:	b7c080e7          	jalr	-1156(ra) # 80001c30 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    800020bc:	00004797          	auipc	a5,0x4
    800020c0:	0c47b783          	ld	a5,196(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    800020c4:	00a7b023          	sd	a0,0(a5)

    sem_open(&CCB::semInput, 0);
    800020c8:	00000593          	li	a1,0
    800020cc:	00004517          	auipc	a0,0x4
    800020d0:	0dc53503          	ld	a0,220(a0) # 800061a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800020d4:	fffff097          	auipc	ra,0xfffff
    800020d8:	25c080e7          	jalr	604(ra) # 80001330 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::semOutput, 0);
    800020dc:	00000593          	li	a1,0
    800020e0:	00004517          	auipc	a0,0x4
    800020e4:	0b053503          	ld	a0,176(a0) # 80006190 <_GLOBAL_OFFSET_TABLE_+0x70>
    800020e8:	fffff097          	auipc	ra,0xfffff
    800020ec:	248080e7          	jalr	584(ra) # 80001330 <_Z8sem_openPP3SCBj>
    sem_open(&CCB::inputBufferEmpty, 0);
    800020f0:	00000593          	li	a1,0
    800020f4:	00004517          	auipc	a0,0x4
    800020f8:	0a453503          	ld	a0,164(a0) # 80006198 <_GLOBAL_OFFSET_TABLE_+0x78>
    800020fc:	fffff097          	auipc	ra,0xfffff
    80002100:	234080e7          	jalr	564(ra) # 80001330 <_Z8sem_openPP3SCBj>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002104:	00200793          	li	a5,2
    80002108:	1007a073          	csrs	sstatus,a5

    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    thread_create(&CCB::inputProcces, CCB::inputBody, nullptr); // getc nit (stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    8000210c:	00000613          	li	a2,0
    80002110:	00004597          	auipc	a1,0x4
    80002114:	0605b583          	ld	a1,96(a1) # 80006170 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002118:	00004517          	auipc	a0,0x4
    8000211c:	0a053503          	ld	a0,160(a0) # 800061b8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002120:	fffff097          	auipc	ra,0xfffff
    80002124:	1c0080e7          	jalr	448(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    CCB::inputProcces->setTimeSlice(1);
    80002128:	00004797          	auipc	a5,0x4
    8000212c:	0907b783          	ld	a5,144(a5) # 800061b8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002130:	0007b783          	ld	a5,0(a5)
    void setSemDeleted(bool newState) {
        semDeleted = newState;
    }

    void setTimeSlice(time_t timeSlice_) {
        timeSlice = timeSlice_;
    80002134:	00100493          	li	s1,1
    80002138:	0497b023          	sd	s1,64(a5)
    thread_create(&CCB::outputProcess, CCB::outputBody, nullptr); // putc nit ( stavljamo je prvi put u Scheduler da bi se pokrenula jednom)
    8000213c:	00000613          	li	a2,0
    80002140:	00004597          	auipc	a1,0x4
    80002144:	0705b583          	ld	a1,112(a1) # 800061b0 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002148:	00004517          	auipc	a0,0x4
    8000214c:	fe853503          	ld	a0,-24(a0) # 80006130 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002150:	fffff097          	auipc	ra,0xfffff
    80002154:	190080e7          	jalr	400(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    CCB::outputProcess->setTimeSlice(1);
    80002158:	00004797          	auipc	a5,0x4
    8000215c:	fd87b783          	ld	a5,-40(a5) # 80006130 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002160:	0007b783          	ld	a5,0(a5)
    80002164:	0497b023          	sd	s1,64(a5)
    thread_create_only(&Scheduler::idleProcess, idleProcess, nullptr); // idle nit
    80002168:	00000613          	li	a2,0
    8000216c:	00000597          	auipc	a1,0x0
    80002170:	ebc58593          	addi	a1,a1,-324 # 80002028 <idleProcess>
    80002174:	00004517          	auipc	a0,0x4
    80002178:	00453503          	ld	a0,4(a0) # 80006178 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000217c:	fffff097          	auipc	ra,0xfffff
    80002180:	06c080e7          	jalr	108(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
    thread_create(&userProcess, userMainWrapper, nullptr);
    80002184:	00000613          	li	a2,0
    80002188:	00000597          	auipc	a1,0x0
    8000218c:	ed458593          	addi	a1,a1,-300 # 8000205c <_Z15userMainWrapperPv>
    80002190:	00004517          	auipc	a0,0x4
    80002194:	0e850513          	addi	a0,a0,232 # 80006278 <userProcess>
    80002198:	fffff097          	auipc	ra,0xfffff
    8000219c:	148080e7          	jalr	328(ra) # 800012e0 <_Z13thread_createPP3PCBPFvPvES2_>
    // ----

    while(!userProcess->isFinished()) {
    800021a0:	00004797          	auipc	a5,0x4
    800021a4:	0d87b783          	ld	a5,216(a5) # 80006278 <userProcess>
        return finished;
    800021a8:	0287c783          	lbu	a5,40(a5)
    800021ac:	00079863          	bnez	a5,800021bc <main+0x130>
        thread_dispatch();
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	0a4080e7          	jalr	164(ra) # 80001254 <_Z15thread_dispatchv>
    while(!userProcess->isFinished()) {
    800021b8:	fe9ff06f          	j	800021a0 <main+0x114>
    }

   // while(CCB::semOutput->getSemValue() != 0) {}
    return 0;
    800021bc:	00000513          	li	a0,0
    800021c0:	01813083          	ld	ra,24(sp)
    800021c4:	01013403          	ld	s0,16(sp)
    800021c8:	00813483          	ld	s1,8(sp)
    800021cc:	02010113          	addi	sp,sp,32
    800021d0:	00008067          	ret

00000000800021d4 <_ZN6ThreadD1Ev>:

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create_only(&myHandle, body, arg);
}

Thread::~Thread() {
    800021d4:	fe010113          	addi	sp,sp,-32
    800021d8:	00113c23          	sd	ra,24(sp)
    800021dc:	00813823          	sd	s0,16(sp)
    800021e0:	00913423          	sd	s1,8(sp)
    800021e4:	02010413          	addi	s0,sp,32
    800021e8:	00004797          	auipc	a5,0x4
    800021ec:	f0078793          	addi	a5,a5,-256 # 800060e8 <_ZTV6Thread+0x10>
    800021f0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800021f4:	00853483          	ld	s1,8(a0)
    800021f8:	00048e63          	beqz	s1,80002214 <_ZN6ThreadD1Ev+0x40>
    800021fc:	00048513          	mv	a0,s1
    80002200:	00000097          	auipc	ra,0x0
    80002204:	994080e7          	jalr	-1644(ra) # 80001b94 <_ZN3PCBD1Ev>
    80002208:	00048513          	mv	a0,s1
    8000220c:	00000097          	auipc	ra,0x0
    80002210:	9fc080e7          	jalr	-1540(ra) # 80001c08 <_ZN3PCBdlEPv>
}
    80002214:	01813083          	ld	ra,24(sp)
    80002218:	01013403          	ld	s0,16(sp)
    8000221c:	00813483          	ld	s1,8(sp)
    80002220:	02010113          	addi	sp,sp,32
    80002224:	00008067          	ret

0000000080002228 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = SCB::createSemaphore(init);
}

Semaphore::~Semaphore() {
    80002228:	ff010113          	addi	sp,sp,-16
    8000222c:	00113423          	sd	ra,8(sp)
    80002230:	00813023          	sd	s0,0(sp)
    80002234:	01010413          	addi	s0,sp,16
    80002238:	00004797          	auipc	a5,0x4
    8000223c:	ed878793          	addi	a5,a5,-296 # 80006110 <_ZTV9Semaphore+0x10>
    80002240:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002244:	00853503          	ld	a0,8(a0)
    80002248:	fffff097          	auipc	ra,0xfffff
    8000224c:	1b8080e7          	jalr	440(ra) # 80001400 <_Z9sem_closeP3SCB>
}
    80002250:	00813083          	ld	ra,8(sp)
    80002254:	00013403          	ld	s0,0(sp)
    80002258:	01010113          	addi	sp,sp,16
    8000225c:	00008067          	ret

0000000080002260 <_Znwm>:
void* operator new (size_t size) {
    80002260:	ff010113          	addi	sp,sp,-16
    80002264:	00113423          	sd	ra,8(sp)
    80002268:	00813023          	sd	s0,0(sp)
    8000226c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002270:	fffff097          	auipc	ra,0xfffff
    80002274:	f04080e7          	jalr	-252(ra) # 80001174 <_Z9mem_allocm>
}
    80002278:	00813083          	ld	ra,8(sp)
    8000227c:	00013403          	ld	s0,0(sp)
    80002280:	01010113          	addi	sp,sp,16
    80002284:	00008067          	ret

0000000080002288 <_Znam>:
void* operator new [](size_t size) {
    80002288:	ff010113          	addi	sp,sp,-16
    8000228c:	00113423          	sd	ra,8(sp)
    80002290:	00813023          	sd	s0,0(sp)
    80002294:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	edc080e7          	jalr	-292(ra) # 80001174 <_Z9mem_allocm>
}
    800022a0:	00813083          	ld	ra,8(sp)
    800022a4:	00013403          	ld	s0,0(sp)
    800022a8:	01010113          	addi	sp,sp,16
    800022ac:	00008067          	ret

00000000800022b0 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    800022b0:	ff010113          	addi	sp,sp,-16
    800022b4:	00113423          	sd	ra,8(sp)
    800022b8:	00813023          	sd	s0,0(sp)
    800022bc:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    800022c0:	fffff097          	auipc	ra,0xfffff
    800022c4:	ef4080e7          	jalr	-268(ra) # 800011b4 <_Z8mem_freePv>
}
    800022c8:	00813083          	ld	ra,8(sp)
    800022cc:	00013403          	ld	s0,0(sp)
    800022d0:	01010113          	addi	sp,sp,16
    800022d4:	00008067          	ret

00000000800022d8 <_Z13threadWrapperPv>:
void threadWrapper(void* thread) {
    800022d8:	fe010113          	addi	sp,sp,-32
    800022dc:	00113c23          	sd	ra,24(sp)
    800022e0:	00813823          	sd	s0,16(sp)
    800022e4:	00913423          	sd	s1,8(sp)
    800022e8:	02010413          	addi	s0,sp,32
    800022ec:	00050493          	mv	s1,a0
    (((Thread*)tArg->thread)->*(tArg->run))();
    800022f0:	00053503          	ld	a0,0(a0)
    800022f4:	0104b783          	ld	a5,16(s1)
    800022f8:	00f50533          	add	a0,a0,a5
    800022fc:	0084b783          	ld	a5,8(s1)
    80002300:	0017f713          	andi	a4,a5,1
    80002304:	00070863          	beqz	a4,80002314 <_Z13threadWrapperPv+0x3c>
    80002308:	00053703          	ld	a4,0(a0)
    8000230c:	00f707b3          	add	a5,a4,a5
    80002310:	fff7b783          	ld	a5,-1(a5)
    80002314:	000780e7          	jalr	a5
    delete tArg;
    80002318:	00048863          	beqz	s1,80002328 <_Z13threadWrapperPv+0x50>
    8000231c:	00048513          	mv	a0,s1
    80002320:	00000097          	auipc	ra,0x0
    80002324:	f90080e7          	jalr	-112(ra) # 800022b0 <_ZdlPv>
}
    80002328:	01813083          	ld	ra,24(sp)
    8000232c:	01013403          	ld	s0,16(sp)
    80002330:	00813483          	ld	s1,8(sp)
    80002334:	02010113          	addi	sp,sp,32
    80002338:	00008067          	ret

000000008000233c <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    8000233c:	ff010113          	addi	sp,sp,-16
    80002340:	00113423          	sd	ra,8(sp)
    80002344:	00813023          	sd	s0,0(sp)
    80002348:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    8000234c:	fffff097          	auipc	ra,0xfffff
    80002350:	e68080e7          	jalr	-408(ra) # 800011b4 <_Z8mem_freePv>
}
    80002354:	00813083          	ld	ra,8(sp)
    80002358:	00013403          	ld	s0,0(sp)
    8000235c:	01010113          	addi	sp,sp,16
    80002360:	00008067          	ret

0000000080002364 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80002364:	ff010113          	addi	sp,sp,-16
    80002368:	00113423          	sd	ra,8(sp)
    8000236c:	00813023          	sd	s0,0(sp)
    80002370:	01010413          	addi	s0,sp,16
    80002374:	00004797          	auipc	a5,0x4
    80002378:	d7478793          	addi	a5,a5,-652 # 800060e8 <_ZTV6Thread+0x10>
    8000237c:	00f53023          	sd	a5,0(a0)
    thread_create_only(&myHandle, body, arg);
    80002380:	00850513          	addi	a0,a0,8
    80002384:	fffff097          	auipc	ra,0xfffff
    80002388:	e64080e7          	jalr	-412(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    8000238c:	00813083          	ld	ra,8(sp)
    80002390:	00013403          	ld	s0,0(sp)
    80002394:	01010113          	addi	sp,sp,16
    80002398:	00008067          	ret

000000008000239c <_ZN6ThreadnwEm>:
void *Thread::operator new(size_t size) {
    8000239c:	ff010113          	addi	sp,sp,-16
    800023a0:	00113423          	sd	ra,8(sp)
    800023a4:	00813023          	sd	s0,0(sp)
    800023a8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800023ac:	00000097          	auipc	ra,0x0
    800023b0:	718080e7          	jalr	1816(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
}
    800023b4:	00813083          	ld	ra,8(sp)
    800023b8:	00013403          	ld	s0,0(sp)
    800023bc:	01010113          	addi	sp,sp,16
    800023c0:	00008067          	ret

00000000800023c4 <_ZN6ThreaddlEPv>:
void Thread::operator delete(void *memSegment) {
    800023c4:	ff010113          	addi	sp,sp,-16
    800023c8:	00113423          	sd	ra,8(sp)
    800023cc:	00813023          	sd	s0,0(sp)
    800023d0:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    800023d4:	00001097          	auipc	ra,0x1
    800023d8:	854080e7          	jalr	-1964(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800023dc:	00813083          	ld	ra,8(sp)
    800023e0:	00013403          	ld	s0,0(sp)
    800023e4:	01010113          	addi	sp,sp,16
    800023e8:	00008067          	ret

00000000800023ec <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800023ec:	fe010113          	addi	sp,sp,-32
    800023f0:	00113c23          	sd	ra,24(sp)
    800023f4:	00813823          	sd	s0,16(sp)
    800023f8:	00913423          	sd	s1,8(sp)
    800023fc:	02010413          	addi	s0,sp,32
    80002400:	00050493          	mv	s1,a0
}
    80002404:	00000097          	auipc	ra,0x0
    80002408:	dd0080e7          	jalr	-560(ra) # 800021d4 <_ZN6ThreadD1Ev>
    8000240c:	00048513          	mv	a0,s1
    80002410:	00000097          	auipc	ra,0x0
    80002414:	fb4080e7          	jalr	-76(ra) # 800023c4 <_ZN6ThreaddlEPv>
    80002418:	01813083          	ld	ra,24(sp)
    8000241c:	01013403          	ld	s0,16(sp)
    80002420:	00813483          	ld	s1,8(sp)
    80002424:	02010113          	addi	sp,sp,32
    80002428:	00008067          	ret

000000008000242c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000242c:	ff010113          	addi	sp,sp,-16
    80002430:	00113423          	sd	ra,8(sp)
    80002434:	00813023          	sd	s0,0(sp)
    80002438:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000243c:	fffff097          	auipc	ra,0xfffff
    80002440:	e18080e7          	jalr	-488(ra) # 80001254 <_Z15thread_dispatchv>
}
    80002444:	00813083          	ld	ra,8(sp)
    80002448:	00013403          	ld	s0,0(sp)
    8000244c:	01010113          	addi	sp,sp,16
    80002450:	00008067          	ret

0000000080002454 <_ZN6Thread5startEv>:
int Thread::start() {
    80002454:	ff010113          	addi	sp,sp,-16
    80002458:	00113423          	sd	ra,8(sp)
    8000245c:	00813023          	sd	s0,0(sp)
    80002460:	01010413          	addi	s0,sp,16
    thread_start(&myHandle);
    80002464:	00850513          	addi	a0,a0,8
    80002468:	fffff097          	auipc	ra,0xfffff
    8000246c:	e48080e7          	jalr	-440(ra) # 800012b0 <_Z12thread_startPP3PCB>
}
    80002470:	00000513          	li	a0,0
    80002474:	00813083          	ld	ra,8(sp)
    80002478:	00013403          	ld	s0,0(sp)
    8000247c:	01010113          	addi	sp,sp,16
    80002480:	00008067          	ret

0000000080002484 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002484:	fe010113          	addi	sp,sp,-32
    80002488:	00113c23          	sd	ra,24(sp)
    8000248c:	00813823          	sd	s0,16(sp)
    80002490:	00913423          	sd	s1,8(sp)
    80002494:	02010413          	addi	s0,sp,32
    80002498:	00050493          	mv	s1,a0
    8000249c:	00004797          	auipc	a5,0x4
    800024a0:	c4c78793          	addi	a5,a5,-948 # 800060e8 <_ZTV6Thread+0x10>
    800024a4:	00f53023          	sd	a5,0(a0)
    threadArg* tArg = new threadArg{this, &Thread::run}; // oslobodice se u destruktoru PCB-a
    800024a8:	01800513          	li	a0,24
    800024ac:	00000097          	auipc	ra,0x0
    800024b0:	db4080e7          	jalr	-588(ra) # 80002260 <_Znwm>
    800024b4:	00050613          	mv	a2,a0
    800024b8:	00953023          	sd	s1,0(a0)
    800024bc:	01100793          	li	a5,17
    800024c0:	00f53423          	sd	a5,8(a0)
    800024c4:	00053823          	sd	zero,16(a0)
    thread_create_only(&myHandle, threadWrapper, tArg);
    800024c8:	00000597          	auipc	a1,0x0
    800024cc:	e1058593          	addi	a1,a1,-496 # 800022d8 <_Z13threadWrapperPv>
    800024d0:	00848513          	addi	a0,s1,8
    800024d4:	fffff097          	auipc	ra,0xfffff
    800024d8:	d14080e7          	jalr	-748(ra) # 800011e8 <_Z18thread_create_onlyPP3PCBPFvPvES2_>
}
    800024dc:	01813083          	ld	ra,24(sp)
    800024e0:	01013403          	ld	s0,16(sp)
    800024e4:	00813483          	ld	s1,8(sp)
    800024e8:	02010113          	addi	sp,sp,32
    800024ec:	00008067          	ret

00000000800024f0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800024f0:	ff010113          	addi	sp,sp,-16
    800024f4:	00113423          	sd	ra,8(sp)
    800024f8:	00813023          	sd	s0,0(sp)
    800024fc:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002500:	fffff097          	auipc	ra,0xfffff
    80002504:	f40080e7          	jalr	-192(ra) # 80001440 <_Z10time_sleepm>
}
    80002508:	00813083          	ld	ra,8(sp)
    8000250c:	00013403          	ld	s0,0(sp)
    80002510:	01010113          	addi	sp,sp,16
    80002514:	00008067          	ret

0000000080002518 <_Z21periodicThreadWrapperPv>:
    void* periodicThread;
    void (PeriodicThread::*periodicActivation)();
    time_t period;
};

void periodicThreadWrapper(void* periodicThread) {
    80002518:	fe010113          	addi	sp,sp,-32
    8000251c:	00113c23          	sd	ra,24(sp)
    80002520:	00813823          	sd	s0,16(sp)
    80002524:	00913423          	sd	s1,8(sp)
    80002528:	02010413          	addi	s0,sp,32
    8000252c:	00050493          	mv	s1,a0
    periodicThreadArg *pArg = (periodicThreadArg*)periodicThread;
    80002530:	0200006f          	j	80002550 <_Z21periodicThreadWrapperPv+0x38>
    while(true) {
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002534:	00053703          	ld	a4,0(a0)
    80002538:	00f707b3          	add	a5,a4,a5
    8000253c:	fff7b783          	ld	a5,-1(a5)
    80002540:	000780e7          	jalr	a5
        Thread::sleep(pArg->period);
    80002544:	0184b503          	ld	a0,24(s1)
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	fa8080e7          	jalr	-88(ra) # 800024f0 <_ZN6Thread5sleepEm>
        (((PeriodicThread*)pArg->periodicThread)->*((pArg->periodicActivation)))();
    80002550:	0004b503          	ld	a0,0(s1)
    80002554:	0104b783          	ld	a5,16(s1)
    80002558:	00f50533          	add	a0,a0,a5
    8000255c:	0084b783          	ld	a5,8(s1)
    80002560:	0017f713          	andi	a4,a5,1
    80002564:	fc070ee3          	beqz	a4,80002540 <_Z21periodicThreadWrapperPv+0x28>
    80002568:	fcdff06f          	j	80002534 <_Z21periodicThreadWrapperPv+0x1c>

000000008000256c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000256c:	fe010113          	addi	sp,sp,-32
    80002570:	00113c23          	sd	ra,24(sp)
    80002574:	00813823          	sd	s0,16(sp)
    80002578:	00913423          	sd	s1,8(sp)
    8000257c:	01213023          	sd	s2,0(sp)
    80002580:	02010413          	addi	s0,sp,32
    80002584:	00050493          	mv	s1,a0
    80002588:	00004797          	auipc	a5,0x4
    8000258c:	b8878793          	addi	a5,a5,-1144 # 80006110 <_ZTV9Semaphore+0x10>
    80002590:	00f53023          	sd	a5,0(a0)
    myHandle = SCB::createSemaphore(init);
    80002594:	00058913          	mv	s2,a1
        return new SCB(semValue);
    80002598:	01800513          	li	a0,24
    8000259c:	00000097          	auipc	ra,0x0
    800025a0:	474080e7          	jalr	1140(ra) # 80002a10 <_ZN3SCBnwEm>
    SCB(int semValue_ = 1) {
    800025a4:	00053023          	sd	zero,0(a0)
    800025a8:	00053423          	sd	zero,8(a0)
        semValue = semValue_;
    800025ac:	01252823          	sw	s2,16(a0)
    800025b0:	00a4b423          	sd	a0,8(s1)
}
    800025b4:	01813083          	ld	ra,24(sp)
    800025b8:	01013403          	ld	s0,16(sp)
    800025bc:	00813483          	ld	s1,8(sp)
    800025c0:	00013903          	ld	s2,0(sp)
    800025c4:	02010113          	addi	sp,sp,32
    800025c8:	00008067          	ret

00000000800025cc <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800025cc:	ff010113          	addi	sp,sp,-16
    800025d0:	00113423          	sd	ra,8(sp)
    800025d4:	00813023          	sd	s0,0(sp)
    800025d8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800025dc:	00853503          	ld	a0,8(a0)
    800025e0:	fffff097          	auipc	ra,0xfffff
    800025e4:	d98080e7          	jalr	-616(ra) # 80001378 <_Z8sem_waitP3SCB>
}
    800025e8:	00813083          	ld	ra,8(sp)
    800025ec:	00013403          	ld	s0,0(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret

00000000800025f8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800025f8:	ff010113          	addi	sp,sp,-16
    800025fc:	00113423          	sd	ra,8(sp)
    80002600:	00813023          	sd	s0,0(sp)
    80002604:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002608:	00853503          	ld	a0,8(a0)
    8000260c:	fffff097          	auipc	ra,0xfffff
    80002610:	db4080e7          	jalr	-588(ra) # 800013c0 <_Z10sem_signalP3SCB>
}
    80002614:	00813083          	ld	ra,8(sp)
    80002618:	00013403          	ld	s0,0(sp)
    8000261c:	01010113          	addi	sp,sp,16
    80002620:	00008067          	ret

0000000080002624 <_ZN9SemaphoredlEPv>:
void Semaphore::operator delete(void *memSegment) {
    80002624:	ff010113          	addi	sp,sp,-16
    80002628:	00113423          	sd	ra,8(sp)
    8000262c:	00813023          	sd	s0,0(sp)
    80002630:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002634:	00000097          	auipc	ra,0x0
    80002638:	5f4080e7          	jalr	1524(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
}
    8000263c:	00813083          	ld	ra,8(sp)
    80002640:	00013403          	ld	s0,0(sp)
    80002644:	01010113          	addi	sp,sp,16
    80002648:	00008067          	ret

000000008000264c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    8000264c:	fe010113          	addi	sp,sp,-32
    80002650:	00113c23          	sd	ra,24(sp)
    80002654:	00813823          	sd	s0,16(sp)
    80002658:	00913423          	sd	s1,8(sp)
    8000265c:	02010413          	addi	s0,sp,32
    80002660:	00050493          	mv	s1,a0
}
    80002664:	00000097          	auipc	ra,0x0
    80002668:	bc4080e7          	jalr	-1084(ra) # 80002228 <_ZN9SemaphoreD1Ev>
    8000266c:	00048513          	mv	a0,s1
    80002670:	00000097          	auipc	ra,0x0
    80002674:	fb4080e7          	jalr	-76(ra) # 80002624 <_ZN9SemaphoredlEPv>
    80002678:	01813083          	ld	ra,24(sp)
    8000267c:	01013403          	ld	s0,16(sp)
    80002680:	00813483          	ld	s1,8(sp)
    80002684:	02010113          	addi	sp,sp,32
    80002688:	00008067          	ret

000000008000268c <_ZN9SemaphorenwEm>:
void *Semaphore::operator new(size_t size) {
    8000268c:	ff010113          	addi	sp,sp,-16
    80002690:	00113423          	sd	ra,8(sp)
    80002694:	00813023          	sd	s0,0(sp)
    80002698:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    8000269c:	00000097          	auipc	ra,0x0
    800026a0:	428080e7          	jalr	1064(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
}
    800026a4:	00813083          	ld	ra,8(sp)
    800026a8:	00013403          	ld	s0,0(sp)
    800026ac:	01010113          	addi	sp,sp,16
    800026b0:	00008067          	ret

00000000800026b4 <_ZN14PeriodicThreadC1Em>:
    }
    delete pArg;
}

PeriodicThread::PeriodicThread(time_t period)
    800026b4:	fe010113          	addi	sp,sp,-32
    800026b8:	00113c23          	sd	ra,24(sp)
    800026bc:	00813823          	sd	s0,16(sp)
    800026c0:	00913423          	sd	s1,8(sp)
    800026c4:	01213023          	sd	s2,0(sp)
    800026c8:	02010413          	addi	s0,sp,32
    800026cc:	00050493          	mv	s1,a0
    800026d0:	00058913          	mv	s2,a1
: Thread(periodicThreadWrapper, new periodicThreadArg {this, &PeriodicThread::periodicActivation, period})
    800026d4:	02000513          	li	a0,32
    800026d8:	00000097          	auipc	ra,0x0
    800026dc:	b88080e7          	jalr	-1144(ra) # 80002260 <_Znwm>
    800026e0:	00050613          	mv	a2,a0
    800026e4:	00953023          	sd	s1,0(a0)
    800026e8:	01900793          	li	a5,25
    800026ec:	00f53423          	sd	a5,8(a0)
    800026f0:	00053823          	sd	zero,16(a0)
    800026f4:	01253c23          	sd	s2,24(a0)
    800026f8:	00000597          	auipc	a1,0x0
    800026fc:	e2058593          	addi	a1,a1,-480 # 80002518 <_Z21periodicThreadWrapperPv>
    80002700:	00048513          	mv	a0,s1
    80002704:	00000097          	auipc	ra,0x0
    80002708:	c60080e7          	jalr	-928(ra) # 80002364 <_ZN6ThreadC1EPFvPvES0_>
    8000270c:	00004797          	auipc	a5,0x4
    80002710:	9ac78793          	addi	a5,a5,-1620 # 800060b8 <_ZTV14PeriodicThread+0x10>
    80002714:	00f4b023          	sd	a5,0(s1)
{}
    80002718:	01813083          	ld	ra,24(sp)
    8000271c:	01013403          	ld	s0,16(sp)
    80002720:	00813483          	ld	s1,8(sp)
    80002724:	00013903          	ld	s2,0(sp)
    80002728:	02010113          	addi	sp,sp,32
    8000272c:	00008067          	ret

0000000080002730 <_ZN7Console4getcEv>:


char Console::getc() {
    80002730:	ff010113          	addi	sp,sp,-16
    80002734:	00113423          	sd	ra,8(sp)
    80002738:	00813023          	sd	s0,0(sp)
    8000273c:	01010413          	addi	s0,sp,16
    return ::getc();
    80002740:	fffff097          	auipc	ra,0xfffff
    80002744:	d48080e7          	jalr	-696(ra) # 80001488 <_Z4getcv>
}
    80002748:	00813083          	ld	ra,8(sp)
    8000274c:	00013403          	ld	s0,0(sp)
    80002750:	01010113          	addi	sp,sp,16
    80002754:	00008067          	ret

0000000080002758 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002758:	ff010113          	addi	sp,sp,-16
    8000275c:	00113423          	sd	ra,8(sp)
    80002760:	00813023          	sd	s0,0(sp)
    80002764:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80002768:	fffff097          	auipc	ra,0xfffff
    8000276c:	d50080e7          	jalr	-688(ra) # 800014b8 <_Z4putcc>
}
    80002770:	00813083          	ld	ra,8(sp)
    80002774:	00013403          	ld	s0,0(sp)
    80002778:	01010113          	addi	sp,sp,16
    8000277c:	00008067          	ret

0000000080002780 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002780:	ff010113          	addi	sp,sp,-16
    80002784:	00813423          	sd	s0,8(sp)
    80002788:	01010413          	addi	s0,sp,16
    8000278c:	00813403          	ld	s0,8(sp)
    80002790:	01010113          	addi	sp,sp,16
    80002794:	00008067          	ret

0000000080002798 <_ZN14PeriodicThread18periodicActivationEv>:
};

class PeriodicThread : public Thread {
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    80002798:	ff010113          	addi	sp,sp,-16
    8000279c:	00813423          	sd	s0,8(sp)
    800027a0:	01010413          	addi	s0,sp,16
    800027a4:	00813403          	ld	s0,8(sp)
    800027a8:	01010113          	addi	sp,sp,16
    800027ac:	00008067          	ret

00000000800027b0 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800027b0:	ff010113          	addi	sp,sp,-16
    800027b4:	00113423          	sd	ra,8(sp)
    800027b8:	00813023          	sd	s0,0(sp)
    800027bc:	01010413          	addi	s0,sp,16
    800027c0:	00004797          	auipc	a5,0x4
    800027c4:	8f878793          	addi	a5,a5,-1800 # 800060b8 <_ZTV14PeriodicThread+0x10>
    800027c8:	00f53023          	sd	a5,0(a0)
    800027cc:	00000097          	auipc	ra,0x0
    800027d0:	a08080e7          	jalr	-1528(ra) # 800021d4 <_ZN6ThreadD1Ev>
    800027d4:	00813083          	ld	ra,8(sp)
    800027d8:	00013403          	ld	s0,0(sp)
    800027dc:	01010113          	addi	sp,sp,16
    800027e0:	00008067          	ret

00000000800027e4 <_ZN14PeriodicThreadD0Ev>:
    800027e4:	fe010113          	addi	sp,sp,-32
    800027e8:	00113c23          	sd	ra,24(sp)
    800027ec:	00813823          	sd	s0,16(sp)
    800027f0:	00913423          	sd	s1,8(sp)
    800027f4:	02010413          	addi	s0,sp,32
    800027f8:	00050493          	mv	s1,a0
    800027fc:	00004797          	auipc	a5,0x4
    80002800:	8bc78793          	addi	a5,a5,-1860 # 800060b8 <_ZTV14PeriodicThread+0x10>
    80002804:	00f53023          	sd	a5,0(a0)
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	9cc080e7          	jalr	-1588(ra) # 800021d4 <_ZN6ThreadD1Ev>
    80002810:	00048513          	mv	a0,s1
    80002814:	00000097          	auipc	ra,0x0
    80002818:	bb0080e7          	jalr	-1104(ra) # 800023c4 <_ZN6ThreaddlEPv>
    8000281c:	01813083          	ld	ra,24(sp)
    80002820:	01013403          	ld	s0,16(sp)
    80002824:	00813483          	ld	s1,8(sp)
    80002828:	02010113          	addi	sp,sp,32
    8000282c:	00008067          	ret

0000000080002830 <_ZN3SCB5blockEv>:
#include "../h/SCB.h"
#include "../h/kernel.h"
#include "../h/MemoryAllocator.h"

void SCB::block() {
    80002830:	ff010113          	addi	sp,sp,-16
    80002834:	00813423          	sd	s0,8(sp)
    80002838:	01010413          	addi	s0,sp,16
    PCB::running->setNextInList(nullptr);
    8000283c:	00004797          	auipc	a5,0x4
    80002840:	9447b783          	ld	a5,-1724(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002844:	0007b783          	ld	a5,0(a5)
        nextInList = next;
    80002848:	0007b023          	sd	zero,0(a5)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    8000284c:	00853783          	ld	a5,8(a0)
    80002850:	04078063          	beqz	a5,80002890 <_ZN3SCB5blockEv+0x60>
        head = tail = PCB::running;
    }
    else {
        tail->setNextInList(PCB::running);
    80002854:	00004717          	auipc	a4,0x4
    80002858:	92c73703          	ld	a4,-1748(a4) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000285c:	00073703          	ld	a4,0(a4)
    80002860:	00e7b023          	sd	a4,0(a5)
        tail = tail->getNextInList();
    80002864:	00853783          	ld	a5,8(a0)
        return nextInList;
    80002868:	0007b783          	ld	a5,0(a5)
    8000286c:	00f53423          	sd	a5,8(a0)
    }
    PCB::running->setBlocked(true);
    80002870:	00004797          	auipc	a5,0x4
    80002874:	9107b783          	ld	a5,-1776(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002878:	0007b783          	ld	a5,0(a5)
        blocked = newState;
    8000287c:	00100713          	li	a4,1
    80002880:	02e784a3          	sb	a4,41(a5)
}
    80002884:	00813403          	ld	s0,8(sp)
    80002888:	01010113          	addi	sp,sp,16
    8000288c:	00008067          	ret
        head = tail = PCB::running;
    80002890:	00004797          	auipc	a5,0x4
    80002894:	8f07b783          	ld	a5,-1808(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002898:	0007b783          	ld	a5,0(a5)
    8000289c:	00f53423          	sd	a5,8(a0)
    800028a0:	00f53023          	sd	a5,0(a0)
    800028a4:	fcdff06f          	j	80002870 <_ZN3SCB5blockEv+0x40>

00000000800028a8 <_ZN3SCB7unblockEv>:

PCB* SCB::unblock() {
    800028a8:	ff010113          	addi	sp,sp,-16
    800028ac:	00813423          	sd	s0,8(sp)
    800028b0:	01010413          	addi	s0,sp,16
    800028b4:	00050793          	mv	a5,a0
    if(head == nullptr) return nullptr;
    800028b8:	00053503          	ld	a0,0(a0)
    800028bc:	00050e63          	beqz	a0,800028d8 <_ZN3SCB7unblockEv+0x30>
        return nextInList;
    800028c0:	00053703          	ld	a4,0(a0)
    PCB* curr = head;
    head = head->getNextInList();
    800028c4:	00e7b023          	sd	a4,0(a5)
    if(tail == curr) {
    800028c8:	0087b683          	ld	a3,8(a5)
    800028cc:	00d50c63          	beq	a0,a3,800028e4 <_ZN3SCB7unblockEv+0x3c>
        blocked = newState;
    800028d0:	020504a3          	sb	zero,41(a0)
        nextInList = next;
    800028d4:	00053023          	sd	zero,0(a0)
        tail = head;
    }
    curr->setBlocked(false);
    curr->setNextInList(nullptr);
    return curr;
}
    800028d8:	00813403          	ld	s0,8(sp)
    800028dc:	01010113          	addi	sp,sp,16
    800028e0:	00008067          	ret
        tail = head;
    800028e4:	00e7b423          	sd	a4,8(a5)
    800028e8:	fe9ff06f          	j	800028d0 <_ZN3SCB7unblockEv+0x28>

00000000800028ec <_ZN3SCB4waitEv>:

int SCB::wait() {
    if((int)(--semValue)<0) {
    800028ec:	01052783          	lw	a5,16(a0)
    800028f0:	fff7879b          	addiw	a5,a5,-1
    800028f4:	00f52823          	sw	a5,16(a0)
    800028f8:	02079713          	slli	a4,a5,0x20
    800028fc:	02074063          	bltz	a4,8000291c <_ZN3SCB4waitEv+0x30>
        block();
        PCB::timeSliceCounter = 0;
        PCB::dispatch();
    }

    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002900:	00004797          	auipc	a5,0x4
    80002904:	8807b783          	ld	a5,-1920(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002908:	0007b783          	ld	a5,0(a5)
    8000290c:	02a7c783          	lbu	a5,42(a5)
    80002910:	06079463          	bnez	a5,80002978 <_ZN3SCB4waitEv+0x8c>
        return -2;
    }

    return 0;
    80002914:	00000513          	li	a0,0
    80002918:	00008067          	ret
int SCB::wait() {
    8000291c:	ff010113          	addi	sp,sp,-16
    80002920:	00113423          	sd	ra,8(sp)
    80002924:	00813023          	sd	s0,0(sp)
    80002928:	01010413          	addi	s0,sp,16
        block();
    8000292c:	00000097          	auipc	ra,0x0
    80002930:	f04080e7          	jalr	-252(ra) # 80002830 <_ZN3SCB5blockEv>
        PCB::timeSliceCounter = 0;
    80002934:	00004797          	auipc	a5,0x4
    80002938:	82c7b783          	ld	a5,-2004(a5) # 80006160 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000293c:	0007b023          	sd	zero,0(a5)
        PCB::dispatch();
    80002940:	fffff097          	auipc	ra,0xfffff
    80002944:	118080e7          	jalr	280(ra) # 80001a58 <_ZN3PCB8dispatchEv>
    if(PCB::running->semDeleted) { // ako se vratio kontekst, a semafor je obrisan
    80002948:	00004797          	auipc	a5,0x4
    8000294c:	8387b783          	ld	a5,-1992(a5) # 80006180 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002950:	0007b783          	ld	a5,0(a5)
    80002954:	02a7c783          	lbu	a5,42(a5)
    80002958:	00079c63          	bnez	a5,80002970 <_ZN3SCB4waitEv+0x84>
    return 0;
    8000295c:	00000513          	li	a0,0

}
    80002960:	00813083          	ld	ra,8(sp)
    80002964:	00013403          	ld	s0,0(sp)
    80002968:	01010113          	addi	sp,sp,16
    8000296c:	00008067          	ret
        return -2;
    80002970:	ffe00513          	li	a0,-2
    80002974:	fedff06f          	j	80002960 <_ZN3SCB4waitEv+0x74>
    80002978:	ffe00513          	li	a0,-2
}
    8000297c:	00008067          	ret

0000000080002980 <_ZN3SCB6signalEv>:

void SCB::signal() {
    if((int)(++semValue)<=0) {
    80002980:	01052783          	lw	a5,16(a0)
    80002984:	0017879b          	addiw	a5,a5,1
    80002988:	0007871b          	sext.w	a4,a5
    8000298c:	00f52823          	sw	a5,16(a0)
    80002990:	00e05463          	blez	a4,80002998 <_ZN3SCB6signalEv+0x18>
    80002994:	00008067          	ret
void SCB::signal() {
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00113423          	sd	ra,8(sp)
    800029a0:	00813023          	sd	s0,0(sp)
    800029a4:	01010413          	addi	s0,sp,16
        Scheduler::put(unblock());
    800029a8:	00000097          	auipc	ra,0x0
    800029ac:	f00080e7          	jalr	-256(ra) # 800028a8 <_ZN3SCB7unblockEv>
    800029b0:	fffff097          	auipc	ra,0xfffff
    800029b4:	584080e7          	jalr	1412(ra) # 80001f34 <_ZN9Scheduler3putEP3PCB>
    }

}
    800029b8:	00813083          	ld	ra,8(sp)
    800029bc:	00013403          	ld	s0,0(sp)
    800029c0:	01010113          	addi	sp,sp,16
    800029c4:	00008067          	ret

00000000800029c8 <_ZN3SCB14prioritySignalEv>:

void SCB::prioritySignal() {
    if((int)(++semValue)<=0) {
    800029c8:	01052783          	lw	a5,16(a0)
    800029cc:	0017879b          	addiw	a5,a5,1
    800029d0:	0007871b          	sext.w	a4,a5
    800029d4:	00f52823          	sw	a5,16(a0)
    800029d8:	00e05463          	blez	a4,800029e0 <_ZN3SCB14prioritySignalEv+0x18>
    800029dc:	00008067          	ret
void SCB::prioritySignal() {
    800029e0:	ff010113          	addi	sp,sp,-16
    800029e4:	00113423          	sd	ra,8(sp)
    800029e8:	00813023          	sd	s0,0(sp)
    800029ec:	01010413          	addi	s0,sp,16
        Scheduler::putInFront(unblock());
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	eb8080e7          	jalr	-328(ra) # 800028a8 <_ZN3SCB7unblockEv>
    800029f8:	fffff097          	auipc	ra,0xfffff
    800029fc:	5e8080e7          	jalr	1512(ra) # 80001fe0 <_ZN9Scheduler10putInFrontEP3PCB>
    }
}
    80002a00:	00813083          	ld	ra,8(sp)
    80002a04:	00013403          	ld	s0,0(sp)
    80002a08:	01010113          	addi	sp,sp,16
    80002a0c:	00008067          	ret

0000000080002a10 <_ZN3SCBnwEm>:

void *SCB::operator new(size_t size) {
    80002a10:	ff010113          	addi	sp,sp,-16
    80002a14:	00113423          	sd	ra,8(sp)
    80002a18:	00813023          	sd	s0,0(sp)
    80002a1c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80002a20:	00000097          	auipc	ra,0x0
    80002a24:	0a4080e7          	jalr	164(ra) # 80002ac4 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002a28:	00813083          	ld	ra,8(sp)
    80002a2c:	00013403          	ld	s0,0(sp)
    80002a30:	01010113          	addi	sp,sp,16
    80002a34:	00008067          	ret

0000000080002a38 <_ZN3SCBdlEPv>:

void SCB::operator delete(void *memSegment) {
    80002a38:	ff010113          	addi	sp,sp,-16
    80002a3c:	00113423          	sd	ra,8(sp)
    80002a40:	00813023          	sd	s0,0(sp)
    80002a44:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80002a48:	00000097          	auipc	ra,0x0
    80002a4c:	1e0080e7          	jalr	480(ra) # 80002c28 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80002a50:	00813083          	ld	ra,8(sp)
    80002a54:	00013403          	ld	s0,0(sp)
    80002a58:	01010113          	addi	sp,sp,16
    80002a5c:	00008067          	ret

0000000080002a60 <_ZN3SCB13signalClosingEv>:

void SCB::signalClosing() {
    80002a60:	fe010113          	addi	sp,sp,-32
    80002a64:	00113c23          	sd	ra,24(sp)
    80002a68:	00813823          	sd	s0,16(sp)
    80002a6c:	00913423          	sd	s1,8(sp)
    80002a70:	01213023          	sd	s2,0(sp)
    80002a74:	02010413          	addi	s0,sp,32
    80002a78:	00050913          	mv	s2,a0
    PCB* curr = head;
    80002a7c:	00053503          	ld	a0,0(a0)
    while(curr) {
    80002a80:	02050263          	beqz	a0,80002aa4 <_ZN3SCB13signalClosingEv+0x44>
        semDeleted = newState;
    80002a84:	00100793          	li	a5,1
    80002a88:	02f50523          	sb	a5,42(a0)
        blocked = newState;
    80002a8c:	020504a3          	sb	zero,41(a0)
        return nextInList;
    80002a90:	00053483          	ld	s1,0(a0)
        PCB* last = curr;
        curr->setSemDeleted(true);
        curr->setBlocked(false);
        curr = curr->getNextInList();
        Scheduler::put(last);
    80002a94:	fffff097          	auipc	ra,0xfffff
    80002a98:	4a0080e7          	jalr	1184(ra) # 80001f34 <_ZN9Scheduler3putEP3PCB>
        curr = curr->getNextInList();
    80002a9c:	00048513          	mv	a0,s1
    while(curr) {
    80002aa0:	fe1ff06f          	j	80002a80 <_ZN3SCB13signalClosingEv+0x20>
    }
    head = tail = nullptr;
    80002aa4:	00093423          	sd	zero,8(s2)
    80002aa8:	00093023          	sd	zero,0(s2)
}
    80002aac:	01813083          	ld	ra,24(sp)
    80002ab0:	01013403          	ld	s0,16(sp)
    80002ab4:	00813483          	ld	s1,8(sp)
    80002ab8:	00013903          	ld	s2,0(sp)
    80002abc:	02010113          	addi	sp,sp,32
    80002ac0:	00008067          	ret

0000000080002ac4 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80002ac4:	ff010113          	addi	sp,sp,-16
    80002ac8:	00813423          	sd	s0,8(sp)
    80002acc:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80002ad0:	00003797          	auipc	a5,0x3
    80002ad4:	7b07b783          	ld	a5,1968(a5) # 80006280 <_ZN15MemoryAllocator4headE>
    80002ad8:	02078c63          	beqz	a5,80002b10 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80002adc:	00003717          	auipc	a4,0x3
    80002ae0:	6ac73703          	ld	a4,1708(a4) # 80006188 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002ae4:	00073703          	ld	a4,0(a4)
    80002ae8:	12e78c63          	beq	a5,a4,80002c20 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80002aec:	00850713          	addi	a4,a0,8
    80002af0:	00675813          	srli	a6,a4,0x6
    80002af4:	03f77793          	andi	a5,a4,63
    80002af8:	00f037b3          	snez	a5,a5
    80002afc:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80002b00:	00003517          	auipc	a0,0x3
    80002b04:	78053503          	ld	a0,1920(a0) # 80006280 <_ZN15MemoryAllocator4headE>
    80002b08:	00000613          	li	a2,0
    80002b0c:	0a80006f          	j	80002bb4 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80002b10:	00003697          	auipc	a3,0x3
    80002b14:	6306b683          	ld	a3,1584(a3) # 80006140 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002b18:	0006b783          	ld	a5,0(a3)
    80002b1c:	00003717          	auipc	a4,0x3
    80002b20:	76f73223          	sd	a5,1892(a4) # 80006280 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80002b24:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80002b28:	00003717          	auipc	a4,0x3
    80002b2c:	66073703          	ld	a4,1632(a4) # 80006188 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002b30:	00073703          	ld	a4,0(a4)
    80002b34:	0006b683          	ld	a3,0(a3)
    80002b38:	40d70733          	sub	a4,a4,a3
    80002b3c:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80002b40:	0007b823          	sd	zero,16(a5)
    80002b44:	fa9ff06f          	j	80002aec <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80002b48:	00060e63          	beqz	a2,80002b64 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80002b4c:	01063703          	ld	a4,16(a2)
    80002b50:	04070a63          	beqz	a4,80002ba4 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80002b54:	01073703          	ld	a4,16(a4)
    80002b58:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80002b5c:	00078813          	mv	a6,a5
    80002b60:	0ac0006f          	j	80002c0c <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80002b64:	01053703          	ld	a4,16(a0)
    80002b68:	00070a63          	beqz	a4,80002b7c <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80002b6c:	00003697          	auipc	a3,0x3
    80002b70:	70e6ba23          	sd	a4,1812(a3) # 80006280 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002b74:	00078813          	mv	a6,a5
    80002b78:	0940006f          	j	80002c0c <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80002b7c:	00003717          	auipc	a4,0x3
    80002b80:	60c73703          	ld	a4,1548(a4) # 80006188 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002b84:	00073703          	ld	a4,0(a4)
    80002b88:	00003697          	auipc	a3,0x3
    80002b8c:	6ee6bc23          	sd	a4,1784(a3) # 80006280 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80002b90:	00078813          	mv	a6,a5
    80002b94:	0780006f          	j	80002c0c <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80002b98:	00003797          	auipc	a5,0x3
    80002b9c:	6ee7b423          	sd	a4,1768(a5) # 80006280 <_ZN15MemoryAllocator4headE>
    80002ba0:	06c0006f          	j	80002c0c <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80002ba4:	00078813          	mv	a6,a5
    80002ba8:	0640006f          	j	80002c0c <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80002bac:	00050613          	mv	a2,a0
        curr = curr->next;
    80002bb0:	01053503          	ld	a0,16(a0)
    while(curr) {
    80002bb4:	06050063          	beqz	a0,80002c14 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80002bb8:	00853783          	ld	a5,8(a0)
    80002bbc:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80002bc0:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80002bc4:	fee7e4e3          	bltu	a5,a4,80002bac <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80002bc8:	ff06e2e3          	bltu	a3,a6,80002bac <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80002bcc:	f7068ee3          	beq	a3,a6,80002b48 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80002bd0:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80002bd4:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80002bd8:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80002bdc:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80002be0:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80002be4:	01053783          	ld	a5,16(a0)
    80002be8:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80002bec:	fa0606e3          	beqz	a2,80002b98 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80002bf0:	01063783          	ld	a5,16(a2)
    80002bf4:	00078663          	beqz	a5,80002c00 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80002bf8:	0107b783          	ld	a5,16(a5)
    80002bfc:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80002c00:	01063783          	ld	a5,16(a2)
    80002c04:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80002c08:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80002c0c:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80002c10:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80002c14:	00813403          	ld	s0,8(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret
        return nullptr;
    80002c20:	00000513          	li	a0,0
    80002c24:	ff1ff06f          	j	80002c14 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080002c28 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80002c28:	ff010113          	addi	sp,sp,-16
    80002c2c:	00813423          	sd	s0,8(sp)
    80002c30:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002c34:	16050063          	beqz	a0,80002d94 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80002c38:	ff850713          	addi	a4,a0,-8
    80002c3c:	00003797          	auipc	a5,0x3
    80002c40:	5047b783          	ld	a5,1284(a5) # 80006140 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002c44:	0007b783          	ld	a5,0(a5)
    80002c48:	14f76a63          	bltu	a4,a5,80002d9c <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80002c4c:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002c50:	fff58693          	addi	a3,a1,-1
    80002c54:	00d706b3          	add	a3,a4,a3
    80002c58:	00003617          	auipc	a2,0x3
    80002c5c:	53063603          	ld	a2,1328(a2) # 80006188 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002c60:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002c64:	14c6f063          	bgeu	a3,a2,80002da4 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002c68:	14070263          	beqz	a4,80002dac <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002c6c:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80002c70:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002c74:	14079063          	bnez	a5,80002db4 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002c78:	03f00793          	li	a5,63
    80002c7c:	14b7f063          	bgeu	a5,a1,80002dbc <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80002c80:	00003797          	auipc	a5,0x3
    80002c84:	6007b783          	ld	a5,1536(a5) # 80006280 <_ZN15MemoryAllocator4headE>
    80002c88:	02f60063          	beq	a2,a5,80002ca8 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002c8c:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002c90:	02078a63          	beqz	a5,80002cc4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002c94:	0007b683          	ld	a3,0(a5)
    80002c98:	02e6f663          	bgeu	a3,a4,80002cc4 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002c9c:	00078613          	mv	a2,a5
        curr = curr->next;
    80002ca0:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002ca4:	fedff06f          	j	80002c90 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002ca8:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002cac:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80002cb0:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002cb4:	00003797          	auipc	a5,0x3
    80002cb8:	5ce7b623          	sd	a4,1484(a5) # 80006280 <_ZN15MemoryAllocator4headE>
        return 0;
    80002cbc:	00000513          	li	a0,0
    80002cc0:	0480006f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002cc4:	04060863          	beqz	a2,80002d14 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002cc8:	00063683          	ld	a3,0(a2)
    80002ccc:	00863803          	ld	a6,8(a2)
    80002cd0:	010686b3          	add	a3,a3,a6
    80002cd4:	08e68a63          	beq	a3,a4,80002d68 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002cd8:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002cdc:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80002ce0:	01063683          	ld	a3,16(a2)
    80002ce4:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002ce8:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002cec:	0e078063          	beqz	a5,80002dcc <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80002cf0:	0007b583          	ld	a1,0(a5)
    80002cf4:	00073683          	ld	a3,0(a4)
    80002cf8:	00873603          	ld	a2,8(a4)
    80002cfc:	00c686b3          	add	a3,a3,a2
    80002d00:	06d58c63          	beq	a1,a3,80002d78 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80002d04:	00000513          	li	a0,0
}
    80002d08:	00813403          	ld	s0,8(sp)
    80002d0c:	01010113          	addi	sp,sp,16
    80002d10:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80002d14:	0a078863          	beqz	a5,80002dc4 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    80002d18:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002d1c:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80002d20:	00003797          	auipc	a5,0x3
    80002d24:	5607b783          	ld	a5,1376(a5) # 80006280 <_ZN15MemoryAllocator4headE>
    80002d28:	0007b603          	ld	a2,0(a5)
    80002d2c:	00b706b3          	add	a3,a4,a1
    80002d30:	00d60c63          	beq	a2,a3,80002d48 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80002d34:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80002d38:	00003797          	auipc	a5,0x3
    80002d3c:	54e7b423          	sd	a4,1352(a5) # 80006280 <_ZN15MemoryAllocator4headE>
            return 0;
    80002d40:	00000513          	li	a0,0
    80002d44:	fc5ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80002d48:	0087b783          	ld	a5,8(a5)
    80002d4c:	00b785b3          	add	a1,a5,a1
    80002d50:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80002d54:	00003797          	auipc	a5,0x3
    80002d58:	52c7b783          	ld	a5,1324(a5) # 80006280 <_ZN15MemoryAllocator4headE>
    80002d5c:	0107b783          	ld	a5,16(a5)
    80002d60:	00f53423          	sd	a5,8(a0)
    80002d64:	fd5ff06f          	j	80002d38 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002d68:	00b805b3          	add	a1,a6,a1
    80002d6c:	00b63423          	sd	a1,8(a2)
    80002d70:	00060713          	mv	a4,a2
    80002d74:	f79ff06f          	j	80002cec <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002d78:	0087b683          	ld	a3,8(a5)
    80002d7c:	00d60633          	add	a2,a2,a3
    80002d80:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002d84:	0107b783          	ld	a5,16(a5)
    80002d88:	00f73823          	sd	a5,16(a4)
    return 0;
    80002d8c:	00000513          	li	a0,0
    80002d90:	f79ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002d94:	fff00513          	li	a0,-1
    80002d98:	f71ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002d9c:	fff00513          	li	a0,-1
    80002da0:	f69ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80002da4:	fff00513          	li	a0,-1
    80002da8:	f61ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002dac:	fff00513          	li	a0,-1
    80002db0:	f59ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002db4:	fff00513          	li	a0,-1
    80002db8:	f51ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002dbc:	fff00513          	li	a0,-1
    80002dc0:	f49ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80002dc4:	fff00513          	li	a0,-1
    80002dc8:	f41ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002dcc:	00000513          	li	a0,0
    80002dd0:	f39ff06f          	j	80002d08 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002dd4 <start>:
    80002dd4:	ff010113          	addi	sp,sp,-16
    80002dd8:	00813423          	sd	s0,8(sp)
    80002ddc:	01010413          	addi	s0,sp,16
    80002de0:	300027f3          	csrr	a5,mstatus
    80002de4:	ffffe737          	lui	a4,0xffffe
    80002de8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff730f>
    80002dec:	00e7f7b3          	and	a5,a5,a4
    80002df0:	00001737          	lui	a4,0x1
    80002df4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002df8:	00e7e7b3          	or	a5,a5,a4
    80002dfc:	30079073          	csrw	mstatus,a5
    80002e00:	00000797          	auipc	a5,0x0
    80002e04:	16078793          	addi	a5,a5,352 # 80002f60 <system_main>
    80002e08:	34179073          	csrw	mepc,a5
    80002e0c:	00000793          	li	a5,0
    80002e10:	18079073          	csrw	satp,a5
    80002e14:	000107b7          	lui	a5,0x10
    80002e18:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002e1c:	30279073          	csrw	medeleg,a5
    80002e20:	30379073          	csrw	mideleg,a5
    80002e24:	104027f3          	csrr	a5,sie
    80002e28:	2227e793          	ori	a5,a5,546
    80002e2c:	10479073          	csrw	sie,a5
    80002e30:	fff00793          	li	a5,-1
    80002e34:	00a7d793          	srli	a5,a5,0xa
    80002e38:	3b079073          	csrw	pmpaddr0,a5
    80002e3c:	00f00793          	li	a5,15
    80002e40:	3a079073          	csrw	pmpcfg0,a5
    80002e44:	f14027f3          	csrr	a5,mhartid
    80002e48:	0200c737          	lui	a4,0x200c
    80002e4c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002e50:	0007869b          	sext.w	a3,a5
    80002e54:	00269713          	slli	a4,a3,0x2
    80002e58:	000f4637          	lui	a2,0xf4
    80002e5c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002e60:	00d70733          	add	a4,a4,a3
    80002e64:	0037979b          	slliw	a5,a5,0x3
    80002e68:	020046b7          	lui	a3,0x2004
    80002e6c:	00d787b3          	add	a5,a5,a3
    80002e70:	00c585b3          	add	a1,a1,a2
    80002e74:	00371693          	slli	a3,a4,0x3
    80002e78:	00003717          	auipc	a4,0x3
    80002e7c:	41870713          	addi	a4,a4,1048 # 80006290 <timer_scratch>
    80002e80:	00b7b023          	sd	a1,0(a5)
    80002e84:	00d70733          	add	a4,a4,a3
    80002e88:	00f73c23          	sd	a5,24(a4)
    80002e8c:	02c73023          	sd	a2,32(a4)
    80002e90:	34071073          	csrw	mscratch,a4
    80002e94:	00000797          	auipc	a5,0x0
    80002e98:	6ec78793          	addi	a5,a5,1772 # 80003580 <timervec>
    80002e9c:	30579073          	csrw	mtvec,a5
    80002ea0:	300027f3          	csrr	a5,mstatus
    80002ea4:	0087e793          	ori	a5,a5,8
    80002ea8:	30079073          	csrw	mstatus,a5
    80002eac:	304027f3          	csrr	a5,mie
    80002eb0:	0807e793          	ori	a5,a5,128
    80002eb4:	30479073          	csrw	mie,a5
    80002eb8:	f14027f3          	csrr	a5,mhartid
    80002ebc:	0007879b          	sext.w	a5,a5
    80002ec0:	00078213          	mv	tp,a5
    80002ec4:	30200073          	mret
    80002ec8:	00813403          	ld	s0,8(sp)
    80002ecc:	01010113          	addi	sp,sp,16
    80002ed0:	00008067          	ret

0000000080002ed4 <timerinit>:
    80002ed4:	ff010113          	addi	sp,sp,-16
    80002ed8:	00813423          	sd	s0,8(sp)
    80002edc:	01010413          	addi	s0,sp,16
    80002ee0:	f14027f3          	csrr	a5,mhartid
    80002ee4:	0200c737          	lui	a4,0x200c
    80002ee8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002eec:	0007869b          	sext.w	a3,a5
    80002ef0:	00269713          	slli	a4,a3,0x2
    80002ef4:	000f4637          	lui	a2,0xf4
    80002ef8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002efc:	00d70733          	add	a4,a4,a3
    80002f00:	0037979b          	slliw	a5,a5,0x3
    80002f04:	020046b7          	lui	a3,0x2004
    80002f08:	00d787b3          	add	a5,a5,a3
    80002f0c:	00c585b3          	add	a1,a1,a2
    80002f10:	00371693          	slli	a3,a4,0x3
    80002f14:	00003717          	auipc	a4,0x3
    80002f18:	37c70713          	addi	a4,a4,892 # 80006290 <timer_scratch>
    80002f1c:	00b7b023          	sd	a1,0(a5)
    80002f20:	00d70733          	add	a4,a4,a3
    80002f24:	00f73c23          	sd	a5,24(a4)
    80002f28:	02c73023          	sd	a2,32(a4)
    80002f2c:	34071073          	csrw	mscratch,a4
    80002f30:	00000797          	auipc	a5,0x0
    80002f34:	65078793          	addi	a5,a5,1616 # 80003580 <timervec>
    80002f38:	30579073          	csrw	mtvec,a5
    80002f3c:	300027f3          	csrr	a5,mstatus
    80002f40:	0087e793          	ori	a5,a5,8
    80002f44:	30079073          	csrw	mstatus,a5
    80002f48:	304027f3          	csrr	a5,mie
    80002f4c:	0807e793          	ori	a5,a5,128
    80002f50:	30479073          	csrw	mie,a5
    80002f54:	00813403          	ld	s0,8(sp)
    80002f58:	01010113          	addi	sp,sp,16
    80002f5c:	00008067          	ret

0000000080002f60 <system_main>:
    80002f60:	fe010113          	addi	sp,sp,-32
    80002f64:	00813823          	sd	s0,16(sp)
    80002f68:	00913423          	sd	s1,8(sp)
    80002f6c:	00113c23          	sd	ra,24(sp)
    80002f70:	02010413          	addi	s0,sp,32
    80002f74:	00000097          	auipc	ra,0x0
    80002f78:	0c4080e7          	jalr	196(ra) # 80003038 <cpuid>
    80002f7c:	00003497          	auipc	s1,0x3
    80002f80:	25448493          	addi	s1,s1,596 # 800061d0 <started>
    80002f84:	02050263          	beqz	a0,80002fa8 <system_main+0x48>
    80002f88:	0004a783          	lw	a5,0(s1)
    80002f8c:	0007879b          	sext.w	a5,a5
    80002f90:	fe078ce3          	beqz	a5,80002f88 <system_main+0x28>
    80002f94:	0ff0000f          	fence
    80002f98:	00002517          	auipc	a0,0x2
    80002f9c:	1c850513          	addi	a0,a0,456 # 80005160 <CONSOLE_STATUS+0x150>
    80002fa0:	00001097          	auipc	ra,0x1
    80002fa4:	a7c080e7          	jalr	-1412(ra) # 80003a1c <panic>
    80002fa8:	00001097          	auipc	ra,0x1
    80002fac:	9d0080e7          	jalr	-1584(ra) # 80003978 <consoleinit>
    80002fb0:	00001097          	auipc	ra,0x1
    80002fb4:	15c080e7          	jalr	348(ra) # 8000410c <printfinit>
    80002fb8:	00002517          	auipc	a0,0x2
    80002fbc:	28850513          	addi	a0,a0,648 # 80005240 <CONSOLE_STATUS+0x230>
    80002fc0:	00001097          	auipc	ra,0x1
    80002fc4:	ab8080e7          	jalr	-1352(ra) # 80003a78 <__printf>
    80002fc8:	00002517          	auipc	a0,0x2
    80002fcc:	16850513          	addi	a0,a0,360 # 80005130 <CONSOLE_STATUS+0x120>
    80002fd0:	00001097          	auipc	ra,0x1
    80002fd4:	aa8080e7          	jalr	-1368(ra) # 80003a78 <__printf>
    80002fd8:	00002517          	auipc	a0,0x2
    80002fdc:	26850513          	addi	a0,a0,616 # 80005240 <CONSOLE_STATUS+0x230>
    80002fe0:	00001097          	auipc	ra,0x1
    80002fe4:	a98080e7          	jalr	-1384(ra) # 80003a78 <__printf>
    80002fe8:	00001097          	auipc	ra,0x1
    80002fec:	4b0080e7          	jalr	1200(ra) # 80004498 <kinit>
    80002ff0:	00000097          	auipc	ra,0x0
    80002ff4:	148080e7          	jalr	328(ra) # 80003138 <trapinit>
    80002ff8:	00000097          	auipc	ra,0x0
    80002ffc:	16c080e7          	jalr	364(ra) # 80003164 <trapinithart>
    80003000:	00000097          	auipc	ra,0x0
    80003004:	5c0080e7          	jalr	1472(ra) # 800035c0 <plicinit>
    80003008:	00000097          	auipc	ra,0x0
    8000300c:	5e0080e7          	jalr	1504(ra) # 800035e8 <plicinithart>
    80003010:	00000097          	auipc	ra,0x0
    80003014:	078080e7          	jalr	120(ra) # 80003088 <userinit>
    80003018:	0ff0000f          	fence
    8000301c:	00100793          	li	a5,1
    80003020:	00002517          	auipc	a0,0x2
    80003024:	12850513          	addi	a0,a0,296 # 80005148 <CONSOLE_STATUS+0x138>
    80003028:	00f4a023          	sw	a5,0(s1)
    8000302c:	00001097          	auipc	ra,0x1
    80003030:	a4c080e7          	jalr	-1460(ra) # 80003a78 <__printf>
    80003034:	0000006f          	j	80003034 <system_main+0xd4>

0000000080003038 <cpuid>:
    80003038:	ff010113          	addi	sp,sp,-16
    8000303c:	00813423          	sd	s0,8(sp)
    80003040:	01010413          	addi	s0,sp,16
    80003044:	00020513          	mv	a0,tp
    80003048:	00813403          	ld	s0,8(sp)
    8000304c:	0005051b          	sext.w	a0,a0
    80003050:	01010113          	addi	sp,sp,16
    80003054:	00008067          	ret

0000000080003058 <mycpu>:
    80003058:	ff010113          	addi	sp,sp,-16
    8000305c:	00813423          	sd	s0,8(sp)
    80003060:	01010413          	addi	s0,sp,16
    80003064:	00020793          	mv	a5,tp
    80003068:	00813403          	ld	s0,8(sp)
    8000306c:	0007879b          	sext.w	a5,a5
    80003070:	00779793          	slli	a5,a5,0x7
    80003074:	00004517          	auipc	a0,0x4
    80003078:	24c50513          	addi	a0,a0,588 # 800072c0 <cpus>
    8000307c:	00f50533          	add	a0,a0,a5
    80003080:	01010113          	addi	sp,sp,16
    80003084:	00008067          	ret

0000000080003088 <userinit>:
    80003088:	ff010113          	addi	sp,sp,-16
    8000308c:	00813423          	sd	s0,8(sp)
    80003090:	01010413          	addi	s0,sp,16
    80003094:	00813403          	ld	s0,8(sp)
    80003098:	01010113          	addi	sp,sp,16
    8000309c:	fffff317          	auipc	t1,0xfffff
    800030a0:	ff030067          	jr	-16(t1) # 8000208c <main>

00000000800030a4 <either_copyout>:
    800030a4:	ff010113          	addi	sp,sp,-16
    800030a8:	00813023          	sd	s0,0(sp)
    800030ac:	00113423          	sd	ra,8(sp)
    800030b0:	01010413          	addi	s0,sp,16
    800030b4:	02051663          	bnez	a0,800030e0 <either_copyout+0x3c>
    800030b8:	00058513          	mv	a0,a1
    800030bc:	00060593          	mv	a1,a2
    800030c0:	0006861b          	sext.w	a2,a3
    800030c4:	00002097          	auipc	ra,0x2
    800030c8:	c60080e7          	jalr	-928(ra) # 80004d24 <__memmove>
    800030cc:	00813083          	ld	ra,8(sp)
    800030d0:	00013403          	ld	s0,0(sp)
    800030d4:	00000513          	li	a0,0
    800030d8:	01010113          	addi	sp,sp,16
    800030dc:	00008067          	ret
    800030e0:	00002517          	auipc	a0,0x2
    800030e4:	0a850513          	addi	a0,a0,168 # 80005188 <CONSOLE_STATUS+0x178>
    800030e8:	00001097          	auipc	ra,0x1
    800030ec:	934080e7          	jalr	-1740(ra) # 80003a1c <panic>

00000000800030f0 <either_copyin>:
    800030f0:	ff010113          	addi	sp,sp,-16
    800030f4:	00813023          	sd	s0,0(sp)
    800030f8:	00113423          	sd	ra,8(sp)
    800030fc:	01010413          	addi	s0,sp,16
    80003100:	02059463          	bnez	a1,80003128 <either_copyin+0x38>
    80003104:	00060593          	mv	a1,a2
    80003108:	0006861b          	sext.w	a2,a3
    8000310c:	00002097          	auipc	ra,0x2
    80003110:	c18080e7          	jalr	-1000(ra) # 80004d24 <__memmove>
    80003114:	00813083          	ld	ra,8(sp)
    80003118:	00013403          	ld	s0,0(sp)
    8000311c:	00000513          	li	a0,0
    80003120:	01010113          	addi	sp,sp,16
    80003124:	00008067          	ret
    80003128:	00002517          	auipc	a0,0x2
    8000312c:	08850513          	addi	a0,a0,136 # 800051b0 <CONSOLE_STATUS+0x1a0>
    80003130:	00001097          	auipc	ra,0x1
    80003134:	8ec080e7          	jalr	-1812(ra) # 80003a1c <panic>

0000000080003138 <trapinit>:
    80003138:	ff010113          	addi	sp,sp,-16
    8000313c:	00813423          	sd	s0,8(sp)
    80003140:	01010413          	addi	s0,sp,16
    80003144:	00813403          	ld	s0,8(sp)
    80003148:	00002597          	auipc	a1,0x2
    8000314c:	09058593          	addi	a1,a1,144 # 800051d8 <CONSOLE_STATUS+0x1c8>
    80003150:	00004517          	auipc	a0,0x4
    80003154:	1f050513          	addi	a0,a0,496 # 80007340 <tickslock>
    80003158:	01010113          	addi	sp,sp,16
    8000315c:	00001317          	auipc	t1,0x1
    80003160:	5cc30067          	jr	1484(t1) # 80004728 <initlock>

0000000080003164 <trapinithart>:
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00813423          	sd	s0,8(sp)
    8000316c:	01010413          	addi	s0,sp,16
    80003170:	00000797          	auipc	a5,0x0
    80003174:	30078793          	addi	a5,a5,768 # 80003470 <kernelvec>
    80003178:	10579073          	csrw	stvec,a5
    8000317c:	00813403          	ld	s0,8(sp)
    80003180:	01010113          	addi	sp,sp,16
    80003184:	00008067          	ret

0000000080003188 <usertrap>:
    80003188:	ff010113          	addi	sp,sp,-16
    8000318c:	00813423          	sd	s0,8(sp)
    80003190:	01010413          	addi	s0,sp,16
    80003194:	00813403          	ld	s0,8(sp)
    80003198:	01010113          	addi	sp,sp,16
    8000319c:	00008067          	ret

00000000800031a0 <usertrapret>:
    800031a0:	ff010113          	addi	sp,sp,-16
    800031a4:	00813423          	sd	s0,8(sp)
    800031a8:	01010413          	addi	s0,sp,16
    800031ac:	00813403          	ld	s0,8(sp)
    800031b0:	01010113          	addi	sp,sp,16
    800031b4:	00008067          	ret

00000000800031b8 <kerneltrap>:
    800031b8:	fe010113          	addi	sp,sp,-32
    800031bc:	00813823          	sd	s0,16(sp)
    800031c0:	00113c23          	sd	ra,24(sp)
    800031c4:	00913423          	sd	s1,8(sp)
    800031c8:	02010413          	addi	s0,sp,32
    800031cc:	142025f3          	csrr	a1,scause
    800031d0:	100027f3          	csrr	a5,sstatus
    800031d4:	0027f793          	andi	a5,a5,2
    800031d8:	10079c63          	bnez	a5,800032f0 <kerneltrap+0x138>
    800031dc:	142027f3          	csrr	a5,scause
    800031e0:	0207ce63          	bltz	a5,8000321c <kerneltrap+0x64>
    800031e4:	00002517          	auipc	a0,0x2
    800031e8:	03c50513          	addi	a0,a0,60 # 80005220 <CONSOLE_STATUS+0x210>
    800031ec:	00001097          	auipc	ra,0x1
    800031f0:	88c080e7          	jalr	-1908(ra) # 80003a78 <__printf>
    800031f4:	141025f3          	csrr	a1,sepc
    800031f8:	14302673          	csrr	a2,stval
    800031fc:	00002517          	auipc	a0,0x2
    80003200:	03450513          	addi	a0,a0,52 # 80005230 <CONSOLE_STATUS+0x220>
    80003204:	00001097          	auipc	ra,0x1
    80003208:	874080e7          	jalr	-1932(ra) # 80003a78 <__printf>
    8000320c:	00002517          	auipc	a0,0x2
    80003210:	03c50513          	addi	a0,a0,60 # 80005248 <CONSOLE_STATUS+0x238>
    80003214:	00001097          	auipc	ra,0x1
    80003218:	808080e7          	jalr	-2040(ra) # 80003a1c <panic>
    8000321c:	0ff7f713          	andi	a4,a5,255
    80003220:	00900693          	li	a3,9
    80003224:	04d70063          	beq	a4,a3,80003264 <kerneltrap+0xac>
    80003228:	fff00713          	li	a4,-1
    8000322c:	03f71713          	slli	a4,a4,0x3f
    80003230:	00170713          	addi	a4,a4,1
    80003234:	fae798e3          	bne	a5,a4,800031e4 <kerneltrap+0x2c>
    80003238:	00000097          	auipc	ra,0x0
    8000323c:	e00080e7          	jalr	-512(ra) # 80003038 <cpuid>
    80003240:	06050663          	beqz	a0,800032ac <kerneltrap+0xf4>
    80003244:	144027f3          	csrr	a5,sip
    80003248:	ffd7f793          	andi	a5,a5,-3
    8000324c:	14479073          	csrw	sip,a5
    80003250:	01813083          	ld	ra,24(sp)
    80003254:	01013403          	ld	s0,16(sp)
    80003258:	00813483          	ld	s1,8(sp)
    8000325c:	02010113          	addi	sp,sp,32
    80003260:	00008067          	ret
    80003264:	00000097          	auipc	ra,0x0
    80003268:	3d0080e7          	jalr	976(ra) # 80003634 <plic_claim>
    8000326c:	00a00793          	li	a5,10
    80003270:	00050493          	mv	s1,a0
    80003274:	06f50863          	beq	a0,a5,800032e4 <kerneltrap+0x12c>
    80003278:	fc050ce3          	beqz	a0,80003250 <kerneltrap+0x98>
    8000327c:	00050593          	mv	a1,a0
    80003280:	00002517          	auipc	a0,0x2
    80003284:	f8050513          	addi	a0,a0,-128 # 80005200 <CONSOLE_STATUS+0x1f0>
    80003288:	00000097          	auipc	ra,0x0
    8000328c:	7f0080e7          	jalr	2032(ra) # 80003a78 <__printf>
    80003290:	01013403          	ld	s0,16(sp)
    80003294:	01813083          	ld	ra,24(sp)
    80003298:	00048513          	mv	a0,s1
    8000329c:	00813483          	ld	s1,8(sp)
    800032a0:	02010113          	addi	sp,sp,32
    800032a4:	00000317          	auipc	t1,0x0
    800032a8:	3c830067          	jr	968(t1) # 8000366c <plic_complete>
    800032ac:	00004517          	auipc	a0,0x4
    800032b0:	09450513          	addi	a0,a0,148 # 80007340 <tickslock>
    800032b4:	00001097          	auipc	ra,0x1
    800032b8:	498080e7          	jalr	1176(ra) # 8000474c <acquire>
    800032bc:	00003717          	auipc	a4,0x3
    800032c0:	f1870713          	addi	a4,a4,-232 # 800061d4 <ticks>
    800032c4:	00072783          	lw	a5,0(a4)
    800032c8:	00004517          	auipc	a0,0x4
    800032cc:	07850513          	addi	a0,a0,120 # 80007340 <tickslock>
    800032d0:	0017879b          	addiw	a5,a5,1
    800032d4:	00f72023          	sw	a5,0(a4)
    800032d8:	00001097          	auipc	ra,0x1
    800032dc:	540080e7          	jalr	1344(ra) # 80004818 <release>
    800032e0:	f65ff06f          	j	80003244 <kerneltrap+0x8c>
    800032e4:	00001097          	auipc	ra,0x1
    800032e8:	09c080e7          	jalr	156(ra) # 80004380 <uartintr>
    800032ec:	fa5ff06f          	j	80003290 <kerneltrap+0xd8>
    800032f0:	00002517          	auipc	a0,0x2
    800032f4:	ef050513          	addi	a0,a0,-272 # 800051e0 <CONSOLE_STATUS+0x1d0>
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	724080e7          	jalr	1828(ra) # 80003a1c <panic>

0000000080003300 <clockintr>:
    80003300:	fe010113          	addi	sp,sp,-32
    80003304:	00813823          	sd	s0,16(sp)
    80003308:	00913423          	sd	s1,8(sp)
    8000330c:	00113c23          	sd	ra,24(sp)
    80003310:	02010413          	addi	s0,sp,32
    80003314:	00004497          	auipc	s1,0x4
    80003318:	02c48493          	addi	s1,s1,44 # 80007340 <tickslock>
    8000331c:	00048513          	mv	a0,s1
    80003320:	00001097          	auipc	ra,0x1
    80003324:	42c080e7          	jalr	1068(ra) # 8000474c <acquire>
    80003328:	00003717          	auipc	a4,0x3
    8000332c:	eac70713          	addi	a4,a4,-340 # 800061d4 <ticks>
    80003330:	00072783          	lw	a5,0(a4)
    80003334:	01013403          	ld	s0,16(sp)
    80003338:	01813083          	ld	ra,24(sp)
    8000333c:	00048513          	mv	a0,s1
    80003340:	0017879b          	addiw	a5,a5,1
    80003344:	00813483          	ld	s1,8(sp)
    80003348:	00f72023          	sw	a5,0(a4)
    8000334c:	02010113          	addi	sp,sp,32
    80003350:	00001317          	auipc	t1,0x1
    80003354:	4c830067          	jr	1224(t1) # 80004818 <release>

0000000080003358 <devintr>:
    80003358:	142027f3          	csrr	a5,scause
    8000335c:	00000513          	li	a0,0
    80003360:	0007c463          	bltz	a5,80003368 <devintr+0x10>
    80003364:	00008067          	ret
    80003368:	fe010113          	addi	sp,sp,-32
    8000336c:	00813823          	sd	s0,16(sp)
    80003370:	00113c23          	sd	ra,24(sp)
    80003374:	00913423          	sd	s1,8(sp)
    80003378:	02010413          	addi	s0,sp,32
    8000337c:	0ff7f713          	andi	a4,a5,255
    80003380:	00900693          	li	a3,9
    80003384:	04d70c63          	beq	a4,a3,800033dc <devintr+0x84>
    80003388:	fff00713          	li	a4,-1
    8000338c:	03f71713          	slli	a4,a4,0x3f
    80003390:	00170713          	addi	a4,a4,1
    80003394:	00e78c63          	beq	a5,a4,800033ac <devintr+0x54>
    80003398:	01813083          	ld	ra,24(sp)
    8000339c:	01013403          	ld	s0,16(sp)
    800033a0:	00813483          	ld	s1,8(sp)
    800033a4:	02010113          	addi	sp,sp,32
    800033a8:	00008067          	ret
    800033ac:	00000097          	auipc	ra,0x0
    800033b0:	c8c080e7          	jalr	-884(ra) # 80003038 <cpuid>
    800033b4:	06050663          	beqz	a0,80003420 <devintr+0xc8>
    800033b8:	144027f3          	csrr	a5,sip
    800033bc:	ffd7f793          	andi	a5,a5,-3
    800033c0:	14479073          	csrw	sip,a5
    800033c4:	01813083          	ld	ra,24(sp)
    800033c8:	01013403          	ld	s0,16(sp)
    800033cc:	00813483          	ld	s1,8(sp)
    800033d0:	00200513          	li	a0,2
    800033d4:	02010113          	addi	sp,sp,32
    800033d8:	00008067          	ret
    800033dc:	00000097          	auipc	ra,0x0
    800033e0:	258080e7          	jalr	600(ra) # 80003634 <plic_claim>
    800033e4:	00a00793          	li	a5,10
    800033e8:	00050493          	mv	s1,a0
    800033ec:	06f50663          	beq	a0,a5,80003458 <devintr+0x100>
    800033f0:	00100513          	li	a0,1
    800033f4:	fa0482e3          	beqz	s1,80003398 <devintr+0x40>
    800033f8:	00048593          	mv	a1,s1
    800033fc:	00002517          	auipc	a0,0x2
    80003400:	e0450513          	addi	a0,a0,-508 # 80005200 <CONSOLE_STATUS+0x1f0>
    80003404:	00000097          	auipc	ra,0x0
    80003408:	674080e7          	jalr	1652(ra) # 80003a78 <__printf>
    8000340c:	00048513          	mv	a0,s1
    80003410:	00000097          	auipc	ra,0x0
    80003414:	25c080e7          	jalr	604(ra) # 8000366c <plic_complete>
    80003418:	00100513          	li	a0,1
    8000341c:	f7dff06f          	j	80003398 <devintr+0x40>
    80003420:	00004517          	auipc	a0,0x4
    80003424:	f2050513          	addi	a0,a0,-224 # 80007340 <tickslock>
    80003428:	00001097          	auipc	ra,0x1
    8000342c:	324080e7          	jalr	804(ra) # 8000474c <acquire>
    80003430:	00003717          	auipc	a4,0x3
    80003434:	da470713          	addi	a4,a4,-604 # 800061d4 <ticks>
    80003438:	00072783          	lw	a5,0(a4)
    8000343c:	00004517          	auipc	a0,0x4
    80003440:	f0450513          	addi	a0,a0,-252 # 80007340 <tickslock>
    80003444:	0017879b          	addiw	a5,a5,1
    80003448:	00f72023          	sw	a5,0(a4)
    8000344c:	00001097          	auipc	ra,0x1
    80003450:	3cc080e7          	jalr	972(ra) # 80004818 <release>
    80003454:	f65ff06f          	j	800033b8 <devintr+0x60>
    80003458:	00001097          	auipc	ra,0x1
    8000345c:	f28080e7          	jalr	-216(ra) # 80004380 <uartintr>
    80003460:	fadff06f          	j	8000340c <devintr+0xb4>
	...

0000000080003470 <kernelvec>:
    80003470:	f0010113          	addi	sp,sp,-256
    80003474:	00113023          	sd	ra,0(sp)
    80003478:	00213423          	sd	sp,8(sp)
    8000347c:	00313823          	sd	gp,16(sp)
    80003480:	00413c23          	sd	tp,24(sp)
    80003484:	02513023          	sd	t0,32(sp)
    80003488:	02613423          	sd	t1,40(sp)
    8000348c:	02713823          	sd	t2,48(sp)
    80003490:	02813c23          	sd	s0,56(sp)
    80003494:	04913023          	sd	s1,64(sp)
    80003498:	04a13423          	sd	a0,72(sp)
    8000349c:	04b13823          	sd	a1,80(sp)
    800034a0:	04c13c23          	sd	a2,88(sp)
    800034a4:	06d13023          	sd	a3,96(sp)
    800034a8:	06e13423          	sd	a4,104(sp)
    800034ac:	06f13823          	sd	a5,112(sp)
    800034b0:	07013c23          	sd	a6,120(sp)
    800034b4:	09113023          	sd	a7,128(sp)
    800034b8:	09213423          	sd	s2,136(sp)
    800034bc:	09313823          	sd	s3,144(sp)
    800034c0:	09413c23          	sd	s4,152(sp)
    800034c4:	0b513023          	sd	s5,160(sp)
    800034c8:	0b613423          	sd	s6,168(sp)
    800034cc:	0b713823          	sd	s7,176(sp)
    800034d0:	0b813c23          	sd	s8,184(sp)
    800034d4:	0d913023          	sd	s9,192(sp)
    800034d8:	0da13423          	sd	s10,200(sp)
    800034dc:	0db13823          	sd	s11,208(sp)
    800034e0:	0dc13c23          	sd	t3,216(sp)
    800034e4:	0fd13023          	sd	t4,224(sp)
    800034e8:	0fe13423          	sd	t5,232(sp)
    800034ec:	0ff13823          	sd	t6,240(sp)
    800034f0:	cc9ff0ef          	jal	ra,800031b8 <kerneltrap>
    800034f4:	00013083          	ld	ra,0(sp)
    800034f8:	00813103          	ld	sp,8(sp)
    800034fc:	01013183          	ld	gp,16(sp)
    80003500:	02013283          	ld	t0,32(sp)
    80003504:	02813303          	ld	t1,40(sp)
    80003508:	03013383          	ld	t2,48(sp)
    8000350c:	03813403          	ld	s0,56(sp)
    80003510:	04013483          	ld	s1,64(sp)
    80003514:	04813503          	ld	a0,72(sp)
    80003518:	05013583          	ld	a1,80(sp)
    8000351c:	05813603          	ld	a2,88(sp)
    80003520:	06013683          	ld	a3,96(sp)
    80003524:	06813703          	ld	a4,104(sp)
    80003528:	07013783          	ld	a5,112(sp)
    8000352c:	07813803          	ld	a6,120(sp)
    80003530:	08013883          	ld	a7,128(sp)
    80003534:	08813903          	ld	s2,136(sp)
    80003538:	09013983          	ld	s3,144(sp)
    8000353c:	09813a03          	ld	s4,152(sp)
    80003540:	0a013a83          	ld	s5,160(sp)
    80003544:	0a813b03          	ld	s6,168(sp)
    80003548:	0b013b83          	ld	s7,176(sp)
    8000354c:	0b813c03          	ld	s8,184(sp)
    80003550:	0c013c83          	ld	s9,192(sp)
    80003554:	0c813d03          	ld	s10,200(sp)
    80003558:	0d013d83          	ld	s11,208(sp)
    8000355c:	0d813e03          	ld	t3,216(sp)
    80003560:	0e013e83          	ld	t4,224(sp)
    80003564:	0e813f03          	ld	t5,232(sp)
    80003568:	0f013f83          	ld	t6,240(sp)
    8000356c:	10010113          	addi	sp,sp,256
    80003570:	10200073          	sret
    80003574:	00000013          	nop
    80003578:	00000013          	nop
    8000357c:	00000013          	nop

0000000080003580 <timervec>:
    80003580:	34051573          	csrrw	a0,mscratch,a0
    80003584:	00b53023          	sd	a1,0(a0)
    80003588:	00c53423          	sd	a2,8(a0)
    8000358c:	00d53823          	sd	a3,16(a0)
    80003590:	01853583          	ld	a1,24(a0)
    80003594:	02053603          	ld	a2,32(a0)
    80003598:	0005b683          	ld	a3,0(a1)
    8000359c:	00c686b3          	add	a3,a3,a2
    800035a0:	00d5b023          	sd	a3,0(a1)
    800035a4:	00200593          	li	a1,2
    800035a8:	14459073          	csrw	sip,a1
    800035ac:	01053683          	ld	a3,16(a0)
    800035b0:	00853603          	ld	a2,8(a0)
    800035b4:	00053583          	ld	a1,0(a0)
    800035b8:	34051573          	csrrw	a0,mscratch,a0
    800035bc:	30200073          	mret

00000000800035c0 <plicinit>:
    800035c0:	ff010113          	addi	sp,sp,-16
    800035c4:	00813423          	sd	s0,8(sp)
    800035c8:	01010413          	addi	s0,sp,16
    800035cc:	00813403          	ld	s0,8(sp)
    800035d0:	0c0007b7          	lui	a5,0xc000
    800035d4:	00100713          	li	a4,1
    800035d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800035dc:	00e7a223          	sw	a4,4(a5)
    800035e0:	01010113          	addi	sp,sp,16
    800035e4:	00008067          	ret

00000000800035e8 <plicinithart>:
    800035e8:	ff010113          	addi	sp,sp,-16
    800035ec:	00813023          	sd	s0,0(sp)
    800035f0:	00113423          	sd	ra,8(sp)
    800035f4:	01010413          	addi	s0,sp,16
    800035f8:	00000097          	auipc	ra,0x0
    800035fc:	a40080e7          	jalr	-1472(ra) # 80003038 <cpuid>
    80003600:	0085171b          	slliw	a4,a0,0x8
    80003604:	0c0027b7          	lui	a5,0xc002
    80003608:	00e787b3          	add	a5,a5,a4
    8000360c:	40200713          	li	a4,1026
    80003610:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003614:	00813083          	ld	ra,8(sp)
    80003618:	00013403          	ld	s0,0(sp)
    8000361c:	00d5151b          	slliw	a0,a0,0xd
    80003620:	0c2017b7          	lui	a5,0xc201
    80003624:	00a78533          	add	a0,a5,a0
    80003628:	00052023          	sw	zero,0(a0)
    8000362c:	01010113          	addi	sp,sp,16
    80003630:	00008067          	ret

0000000080003634 <plic_claim>:
    80003634:	ff010113          	addi	sp,sp,-16
    80003638:	00813023          	sd	s0,0(sp)
    8000363c:	00113423          	sd	ra,8(sp)
    80003640:	01010413          	addi	s0,sp,16
    80003644:	00000097          	auipc	ra,0x0
    80003648:	9f4080e7          	jalr	-1548(ra) # 80003038 <cpuid>
    8000364c:	00813083          	ld	ra,8(sp)
    80003650:	00013403          	ld	s0,0(sp)
    80003654:	00d5151b          	slliw	a0,a0,0xd
    80003658:	0c2017b7          	lui	a5,0xc201
    8000365c:	00a78533          	add	a0,a5,a0
    80003660:	00452503          	lw	a0,4(a0)
    80003664:	01010113          	addi	sp,sp,16
    80003668:	00008067          	ret

000000008000366c <plic_complete>:
    8000366c:	fe010113          	addi	sp,sp,-32
    80003670:	00813823          	sd	s0,16(sp)
    80003674:	00913423          	sd	s1,8(sp)
    80003678:	00113c23          	sd	ra,24(sp)
    8000367c:	02010413          	addi	s0,sp,32
    80003680:	00050493          	mv	s1,a0
    80003684:	00000097          	auipc	ra,0x0
    80003688:	9b4080e7          	jalr	-1612(ra) # 80003038 <cpuid>
    8000368c:	01813083          	ld	ra,24(sp)
    80003690:	01013403          	ld	s0,16(sp)
    80003694:	00d5179b          	slliw	a5,a0,0xd
    80003698:	0c201737          	lui	a4,0xc201
    8000369c:	00f707b3          	add	a5,a4,a5
    800036a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800036a4:	00813483          	ld	s1,8(sp)
    800036a8:	02010113          	addi	sp,sp,32
    800036ac:	00008067          	ret

00000000800036b0 <consolewrite>:
    800036b0:	fb010113          	addi	sp,sp,-80
    800036b4:	04813023          	sd	s0,64(sp)
    800036b8:	04113423          	sd	ra,72(sp)
    800036bc:	02913c23          	sd	s1,56(sp)
    800036c0:	03213823          	sd	s2,48(sp)
    800036c4:	03313423          	sd	s3,40(sp)
    800036c8:	03413023          	sd	s4,32(sp)
    800036cc:	01513c23          	sd	s5,24(sp)
    800036d0:	05010413          	addi	s0,sp,80
    800036d4:	06c05c63          	blez	a2,8000374c <consolewrite+0x9c>
    800036d8:	00060993          	mv	s3,a2
    800036dc:	00050a13          	mv	s4,a0
    800036e0:	00058493          	mv	s1,a1
    800036e4:	00000913          	li	s2,0
    800036e8:	fff00a93          	li	s5,-1
    800036ec:	01c0006f          	j	80003708 <consolewrite+0x58>
    800036f0:	fbf44503          	lbu	a0,-65(s0)
    800036f4:	0019091b          	addiw	s2,s2,1
    800036f8:	00148493          	addi	s1,s1,1
    800036fc:	00001097          	auipc	ra,0x1
    80003700:	a9c080e7          	jalr	-1380(ra) # 80004198 <uartputc>
    80003704:	03298063          	beq	s3,s2,80003724 <consolewrite+0x74>
    80003708:	00048613          	mv	a2,s1
    8000370c:	00100693          	li	a3,1
    80003710:	000a0593          	mv	a1,s4
    80003714:	fbf40513          	addi	a0,s0,-65
    80003718:	00000097          	auipc	ra,0x0
    8000371c:	9d8080e7          	jalr	-1576(ra) # 800030f0 <either_copyin>
    80003720:	fd5518e3          	bne	a0,s5,800036f0 <consolewrite+0x40>
    80003724:	04813083          	ld	ra,72(sp)
    80003728:	04013403          	ld	s0,64(sp)
    8000372c:	03813483          	ld	s1,56(sp)
    80003730:	02813983          	ld	s3,40(sp)
    80003734:	02013a03          	ld	s4,32(sp)
    80003738:	01813a83          	ld	s5,24(sp)
    8000373c:	00090513          	mv	a0,s2
    80003740:	03013903          	ld	s2,48(sp)
    80003744:	05010113          	addi	sp,sp,80
    80003748:	00008067          	ret
    8000374c:	00000913          	li	s2,0
    80003750:	fd5ff06f          	j	80003724 <consolewrite+0x74>

0000000080003754 <consoleread>:
    80003754:	f9010113          	addi	sp,sp,-112
    80003758:	06813023          	sd	s0,96(sp)
    8000375c:	04913c23          	sd	s1,88(sp)
    80003760:	05213823          	sd	s2,80(sp)
    80003764:	05313423          	sd	s3,72(sp)
    80003768:	05413023          	sd	s4,64(sp)
    8000376c:	03513c23          	sd	s5,56(sp)
    80003770:	03613823          	sd	s6,48(sp)
    80003774:	03713423          	sd	s7,40(sp)
    80003778:	03813023          	sd	s8,32(sp)
    8000377c:	06113423          	sd	ra,104(sp)
    80003780:	01913c23          	sd	s9,24(sp)
    80003784:	07010413          	addi	s0,sp,112
    80003788:	00060b93          	mv	s7,a2
    8000378c:	00050913          	mv	s2,a0
    80003790:	00058c13          	mv	s8,a1
    80003794:	00060b1b          	sext.w	s6,a2
    80003798:	00004497          	auipc	s1,0x4
    8000379c:	bd048493          	addi	s1,s1,-1072 # 80007368 <cons>
    800037a0:	00400993          	li	s3,4
    800037a4:	fff00a13          	li	s4,-1
    800037a8:	00a00a93          	li	s5,10
    800037ac:	05705e63          	blez	s7,80003808 <consoleread+0xb4>
    800037b0:	09c4a703          	lw	a4,156(s1)
    800037b4:	0984a783          	lw	a5,152(s1)
    800037b8:	0007071b          	sext.w	a4,a4
    800037bc:	08e78463          	beq	a5,a4,80003844 <consoleread+0xf0>
    800037c0:	07f7f713          	andi	a4,a5,127
    800037c4:	00e48733          	add	a4,s1,a4
    800037c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800037cc:	0017869b          	addiw	a3,a5,1
    800037d0:	08d4ac23          	sw	a3,152(s1)
    800037d4:	00070c9b          	sext.w	s9,a4
    800037d8:	0b370663          	beq	a4,s3,80003884 <consoleread+0x130>
    800037dc:	00100693          	li	a3,1
    800037e0:	f9f40613          	addi	a2,s0,-97
    800037e4:	000c0593          	mv	a1,s8
    800037e8:	00090513          	mv	a0,s2
    800037ec:	f8e40fa3          	sb	a4,-97(s0)
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	8b4080e7          	jalr	-1868(ra) # 800030a4 <either_copyout>
    800037f8:	01450863          	beq	a0,s4,80003808 <consoleread+0xb4>
    800037fc:	001c0c13          	addi	s8,s8,1
    80003800:	fffb8b9b          	addiw	s7,s7,-1
    80003804:	fb5c94e3          	bne	s9,s5,800037ac <consoleread+0x58>
    80003808:	000b851b          	sext.w	a0,s7
    8000380c:	06813083          	ld	ra,104(sp)
    80003810:	06013403          	ld	s0,96(sp)
    80003814:	05813483          	ld	s1,88(sp)
    80003818:	05013903          	ld	s2,80(sp)
    8000381c:	04813983          	ld	s3,72(sp)
    80003820:	04013a03          	ld	s4,64(sp)
    80003824:	03813a83          	ld	s5,56(sp)
    80003828:	02813b83          	ld	s7,40(sp)
    8000382c:	02013c03          	ld	s8,32(sp)
    80003830:	01813c83          	ld	s9,24(sp)
    80003834:	40ab053b          	subw	a0,s6,a0
    80003838:	03013b03          	ld	s6,48(sp)
    8000383c:	07010113          	addi	sp,sp,112
    80003840:	00008067          	ret
    80003844:	00001097          	auipc	ra,0x1
    80003848:	1d8080e7          	jalr	472(ra) # 80004a1c <push_on>
    8000384c:	0984a703          	lw	a4,152(s1)
    80003850:	09c4a783          	lw	a5,156(s1)
    80003854:	0007879b          	sext.w	a5,a5
    80003858:	fef70ce3          	beq	a4,a5,80003850 <consoleread+0xfc>
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	234080e7          	jalr	564(ra) # 80004a90 <pop_on>
    80003864:	0984a783          	lw	a5,152(s1)
    80003868:	07f7f713          	andi	a4,a5,127
    8000386c:	00e48733          	add	a4,s1,a4
    80003870:	01874703          	lbu	a4,24(a4)
    80003874:	0017869b          	addiw	a3,a5,1
    80003878:	08d4ac23          	sw	a3,152(s1)
    8000387c:	00070c9b          	sext.w	s9,a4
    80003880:	f5371ee3          	bne	a4,s3,800037dc <consoleread+0x88>
    80003884:	000b851b          	sext.w	a0,s7
    80003888:	f96bf2e3          	bgeu	s7,s6,8000380c <consoleread+0xb8>
    8000388c:	08f4ac23          	sw	a5,152(s1)
    80003890:	f7dff06f          	j	8000380c <consoleread+0xb8>

0000000080003894 <consputc>:
    80003894:	10000793          	li	a5,256
    80003898:	00f50663          	beq	a0,a5,800038a4 <consputc+0x10>
    8000389c:	00001317          	auipc	t1,0x1
    800038a0:	9f430067          	jr	-1548(t1) # 80004290 <uartputc_sync>
    800038a4:	ff010113          	addi	sp,sp,-16
    800038a8:	00113423          	sd	ra,8(sp)
    800038ac:	00813023          	sd	s0,0(sp)
    800038b0:	01010413          	addi	s0,sp,16
    800038b4:	00800513          	li	a0,8
    800038b8:	00001097          	auipc	ra,0x1
    800038bc:	9d8080e7          	jalr	-1576(ra) # 80004290 <uartputc_sync>
    800038c0:	02000513          	li	a0,32
    800038c4:	00001097          	auipc	ra,0x1
    800038c8:	9cc080e7          	jalr	-1588(ra) # 80004290 <uartputc_sync>
    800038cc:	00013403          	ld	s0,0(sp)
    800038d0:	00813083          	ld	ra,8(sp)
    800038d4:	00800513          	li	a0,8
    800038d8:	01010113          	addi	sp,sp,16
    800038dc:	00001317          	auipc	t1,0x1
    800038e0:	9b430067          	jr	-1612(t1) # 80004290 <uartputc_sync>

00000000800038e4 <consoleintr>:
    800038e4:	fe010113          	addi	sp,sp,-32
    800038e8:	00813823          	sd	s0,16(sp)
    800038ec:	00913423          	sd	s1,8(sp)
    800038f0:	01213023          	sd	s2,0(sp)
    800038f4:	00113c23          	sd	ra,24(sp)
    800038f8:	02010413          	addi	s0,sp,32
    800038fc:	00004917          	auipc	s2,0x4
    80003900:	a6c90913          	addi	s2,s2,-1428 # 80007368 <cons>
    80003904:	00050493          	mv	s1,a0
    80003908:	00090513          	mv	a0,s2
    8000390c:	00001097          	auipc	ra,0x1
    80003910:	e40080e7          	jalr	-448(ra) # 8000474c <acquire>
    80003914:	02048c63          	beqz	s1,8000394c <consoleintr+0x68>
    80003918:	0a092783          	lw	a5,160(s2)
    8000391c:	09892703          	lw	a4,152(s2)
    80003920:	07f00693          	li	a3,127
    80003924:	40e7873b          	subw	a4,a5,a4
    80003928:	02e6e263          	bltu	a3,a4,8000394c <consoleintr+0x68>
    8000392c:	00d00713          	li	a4,13
    80003930:	04e48063          	beq	s1,a4,80003970 <consoleintr+0x8c>
    80003934:	07f7f713          	andi	a4,a5,127
    80003938:	00e90733          	add	a4,s2,a4
    8000393c:	0017879b          	addiw	a5,a5,1
    80003940:	0af92023          	sw	a5,160(s2)
    80003944:	00970c23          	sb	s1,24(a4)
    80003948:	08f92e23          	sw	a5,156(s2)
    8000394c:	01013403          	ld	s0,16(sp)
    80003950:	01813083          	ld	ra,24(sp)
    80003954:	00813483          	ld	s1,8(sp)
    80003958:	00013903          	ld	s2,0(sp)
    8000395c:	00004517          	auipc	a0,0x4
    80003960:	a0c50513          	addi	a0,a0,-1524 # 80007368 <cons>
    80003964:	02010113          	addi	sp,sp,32
    80003968:	00001317          	auipc	t1,0x1
    8000396c:	eb030067          	jr	-336(t1) # 80004818 <release>
    80003970:	00a00493          	li	s1,10
    80003974:	fc1ff06f          	j	80003934 <consoleintr+0x50>

0000000080003978 <consoleinit>:
    80003978:	fe010113          	addi	sp,sp,-32
    8000397c:	00113c23          	sd	ra,24(sp)
    80003980:	00813823          	sd	s0,16(sp)
    80003984:	00913423          	sd	s1,8(sp)
    80003988:	02010413          	addi	s0,sp,32
    8000398c:	00004497          	auipc	s1,0x4
    80003990:	9dc48493          	addi	s1,s1,-1572 # 80007368 <cons>
    80003994:	00048513          	mv	a0,s1
    80003998:	00002597          	auipc	a1,0x2
    8000399c:	8c058593          	addi	a1,a1,-1856 # 80005258 <CONSOLE_STATUS+0x248>
    800039a0:	00001097          	auipc	ra,0x1
    800039a4:	d88080e7          	jalr	-632(ra) # 80004728 <initlock>
    800039a8:	00000097          	auipc	ra,0x0
    800039ac:	7ac080e7          	jalr	1964(ra) # 80004154 <uartinit>
    800039b0:	01813083          	ld	ra,24(sp)
    800039b4:	01013403          	ld	s0,16(sp)
    800039b8:	00000797          	auipc	a5,0x0
    800039bc:	d9c78793          	addi	a5,a5,-612 # 80003754 <consoleread>
    800039c0:	0af4bc23          	sd	a5,184(s1)
    800039c4:	00000797          	auipc	a5,0x0
    800039c8:	cec78793          	addi	a5,a5,-788 # 800036b0 <consolewrite>
    800039cc:	0cf4b023          	sd	a5,192(s1)
    800039d0:	00813483          	ld	s1,8(sp)
    800039d4:	02010113          	addi	sp,sp,32
    800039d8:	00008067          	ret

00000000800039dc <console_read>:
    800039dc:	ff010113          	addi	sp,sp,-16
    800039e0:	00813423          	sd	s0,8(sp)
    800039e4:	01010413          	addi	s0,sp,16
    800039e8:	00813403          	ld	s0,8(sp)
    800039ec:	00004317          	auipc	t1,0x4
    800039f0:	a3433303          	ld	t1,-1484(t1) # 80007420 <devsw+0x10>
    800039f4:	01010113          	addi	sp,sp,16
    800039f8:	00030067          	jr	t1

00000000800039fc <console_write>:
    800039fc:	ff010113          	addi	sp,sp,-16
    80003a00:	00813423          	sd	s0,8(sp)
    80003a04:	01010413          	addi	s0,sp,16
    80003a08:	00813403          	ld	s0,8(sp)
    80003a0c:	00004317          	auipc	t1,0x4
    80003a10:	a1c33303          	ld	t1,-1508(t1) # 80007428 <devsw+0x18>
    80003a14:	01010113          	addi	sp,sp,16
    80003a18:	00030067          	jr	t1

0000000080003a1c <panic>:
    80003a1c:	fe010113          	addi	sp,sp,-32
    80003a20:	00113c23          	sd	ra,24(sp)
    80003a24:	00813823          	sd	s0,16(sp)
    80003a28:	00913423          	sd	s1,8(sp)
    80003a2c:	02010413          	addi	s0,sp,32
    80003a30:	00050493          	mv	s1,a0
    80003a34:	00002517          	auipc	a0,0x2
    80003a38:	82c50513          	addi	a0,a0,-2004 # 80005260 <CONSOLE_STATUS+0x250>
    80003a3c:	00004797          	auipc	a5,0x4
    80003a40:	a807a623          	sw	zero,-1396(a5) # 800074c8 <pr+0x18>
    80003a44:	00000097          	auipc	ra,0x0
    80003a48:	034080e7          	jalr	52(ra) # 80003a78 <__printf>
    80003a4c:	00048513          	mv	a0,s1
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	028080e7          	jalr	40(ra) # 80003a78 <__printf>
    80003a58:	00001517          	auipc	a0,0x1
    80003a5c:	7e850513          	addi	a0,a0,2024 # 80005240 <CONSOLE_STATUS+0x230>
    80003a60:	00000097          	auipc	ra,0x0
    80003a64:	018080e7          	jalr	24(ra) # 80003a78 <__printf>
    80003a68:	00100793          	li	a5,1
    80003a6c:	00002717          	auipc	a4,0x2
    80003a70:	76f72623          	sw	a5,1900(a4) # 800061d8 <panicked>
    80003a74:	0000006f          	j	80003a74 <panic+0x58>

0000000080003a78 <__printf>:
    80003a78:	f3010113          	addi	sp,sp,-208
    80003a7c:	08813023          	sd	s0,128(sp)
    80003a80:	07313423          	sd	s3,104(sp)
    80003a84:	09010413          	addi	s0,sp,144
    80003a88:	05813023          	sd	s8,64(sp)
    80003a8c:	08113423          	sd	ra,136(sp)
    80003a90:	06913c23          	sd	s1,120(sp)
    80003a94:	07213823          	sd	s2,112(sp)
    80003a98:	07413023          	sd	s4,96(sp)
    80003a9c:	05513c23          	sd	s5,88(sp)
    80003aa0:	05613823          	sd	s6,80(sp)
    80003aa4:	05713423          	sd	s7,72(sp)
    80003aa8:	03913c23          	sd	s9,56(sp)
    80003aac:	03a13823          	sd	s10,48(sp)
    80003ab0:	03b13423          	sd	s11,40(sp)
    80003ab4:	00004317          	auipc	t1,0x4
    80003ab8:	9fc30313          	addi	t1,t1,-1540 # 800074b0 <pr>
    80003abc:	01832c03          	lw	s8,24(t1)
    80003ac0:	00b43423          	sd	a1,8(s0)
    80003ac4:	00c43823          	sd	a2,16(s0)
    80003ac8:	00d43c23          	sd	a3,24(s0)
    80003acc:	02e43023          	sd	a4,32(s0)
    80003ad0:	02f43423          	sd	a5,40(s0)
    80003ad4:	03043823          	sd	a6,48(s0)
    80003ad8:	03143c23          	sd	a7,56(s0)
    80003adc:	00050993          	mv	s3,a0
    80003ae0:	4a0c1663          	bnez	s8,80003f8c <__printf+0x514>
    80003ae4:	60098c63          	beqz	s3,800040fc <__printf+0x684>
    80003ae8:	0009c503          	lbu	a0,0(s3)
    80003aec:	00840793          	addi	a5,s0,8
    80003af0:	f6f43c23          	sd	a5,-136(s0)
    80003af4:	00000493          	li	s1,0
    80003af8:	22050063          	beqz	a0,80003d18 <__printf+0x2a0>
    80003afc:	00002a37          	lui	s4,0x2
    80003b00:	00018ab7          	lui	s5,0x18
    80003b04:	000f4b37          	lui	s6,0xf4
    80003b08:	00989bb7          	lui	s7,0x989
    80003b0c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003b10:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003b14:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003b18:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80003b1c:	00148c9b          	addiw	s9,s1,1
    80003b20:	02500793          	li	a5,37
    80003b24:	01998933          	add	s2,s3,s9
    80003b28:	38f51263          	bne	a0,a5,80003eac <__printf+0x434>
    80003b2c:	00094783          	lbu	a5,0(s2)
    80003b30:	00078c9b          	sext.w	s9,a5
    80003b34:	1e078263          	beqz	a5,80003d18 <__printf+0x2a0>
    80003b38:	0024849b          	addiw	s1,s1,2
    80003b3c:	07000713          	li	a4,112
    80003b40:	00998933          	add	s2,s3,s1
    80003b44:	38e78a63          	beq	a5,a4,80003ed8 <__printf+0x460>
    80003b48:	20f76863          	bltu	a4,a5,80003d58 <__printf+0x2e0>
    80003b4c:	42a78863          	beq	a5,a0,80003f7c <__printf+0x504>
    80003b50:	06400713          	li	a4,100
    80003b54:	40e79663          	bne	a5,a4,80003f60 <__printf+0x4e8>
    80003b58:	f7843783          	ld	a5,-136(s0)
    80003b5c:	0007a603          	lw	a2,0(a5)
    80003b60:	00878793          	addi	a5,a5,8
    80003b64:	f6f43c23          	sd	a5,-136(s0)
    80003b68:	42064a63          	bltz	a2,80003f9c <__printf+0x524>
    80003b6c:	00a00713          	li	a4,10
    80003b70:	02e677bb          	remuw	a5,a2,a4
    80003b74:	00001d97          	auipc	s11,0x1
    80003b78:	714d8d93          	addi	s11,s11,1812 # 80005288 <digits>
    80003b7c:	00900593          	li	a1,9
    80003b80:	0006051b          	sext.w	a0,a2
    80003b84:	00000c93          	li	s9,0
    80003b88:	02079793          	slli	a5,a5,0x20
    80003b8c:	0207d793          	srli	a5,a5,0x20
    80003b90:	00fd87b3          	add	a5,s11,a5
    80003b94:	0007c783          	lbu	a5,0(a5)
    80003b98:	02e656bb          	divuw	a3,a2,a4
    80003b9c:	f8f40023          	sb	a5,-128(s0)
    80003ba0:	14c5d863          	bge	a1,a2,80003cf0 <__printf+0x278>
    80003ba4:	06300593          	li	a1,99
    80003ba8:	00100c93          	li	s9,1
    80003bac:	02e6f7bb          	remuw	a5,a3,a4
    80003bb0:	02079793          	slli	a5,a5,0x20
    80003bb4:	0207d793          	srli	a5,a5,0x20
    80003bb8:	00fd87b3          	add	a5,s11,a5
    80003bbc:	0007c783          	lbu	a5,0(a5)
    80003bc0:	02e6d73b          	divuw	a4,a3,a4
    80003bc4:	f8f400a3          	sb	a5,-127(s0)
    80003bc8:	12a5f463          	bgeu	a1,a0,80003cf0 <__printf+0x278>
    80003bcc:	00a00693          	li	a3,10
    80003bd0:	00900593          	li	a1,9
    80003bd4:	02d777bb          	remuw	a5,a4,a3
    80003bd8:	02079793          	slli	a5,a5,0x20
    80003bdc:	0207d793          	srli	a5,a5,0x20
    80003be0:	00fd87b3          	add	a5,s11,a5
    80003be4:	0007c503          	lbu	a0,0(a5)
    80003be8:	02d757bb          	divuw	a5,a4,a3
    80003bec:	f8a40123          	sb	a0,-126(s0)
    80003bf0:	48e5f263          	bgeu	a1,a4,80004074 <__printf+0x5fc>
    80003bf4:	06300513          	li	a0,99
    80003bf8:	02d7f5bb          	remuw	a1,a5,a3
    80003bfc:	02059593          	slli	a1,a1,0x20
    80003c00:	0205d593          	srli	a1,a1,0x20
    80003c04:	00bd85b3          	add	a1,s11,a1
    80003c08:	0005c583          	lbu	a1,0(a1)
    80003c0c:	02d7d7bb          	divuw	a5,a5,a3
    80003c10:	f8b401a3          	sb	a1,-125(s0)
    80003c14:	48e57263          	bgeu	a0,a4,80004098 <__printf+0x620>
    80003c18:	3e700513          	li	a0,999
    80003c1c:	02d7f5bb          	remuw	a1,a5,a3
    80003c20:	02059593          	slli	a1,a1,0x20
    80003c24:	0205d593          	srli	a1,a1,0x20
    80003c28:	00bd85b3          	add	a1,s11,a1
    80003c2c:	0005c583          	lbu	a1,0(a1)
    80003c30:	02d7d7bb          	divuw	a5,a5,a3
    80003c34:	f8b40223          	sb	a1,-124(s0)
    80003c38:	46e57663          	bgeu	a0,a4,800040a4 <__printf+0x62c>
    80003c3c:	02d7f5bb          	remuw	a1,a5,a3
    80003c40:	02059593          	slli	a1,a1,0x20
    80003c44:	0205d593          	srli	a1,a1,0x20
    80003c48:	00bd85b3          	add	a1,s11,a1
    80003c4c:	0005c583          	lbu	a1,0(a1)
    80003c50:	02d7d7bb          	divuw	a5,a5,a3
    80003c54:	f8b402a3          	sb	a1,-123(s0)
    80003c58:	46ea7863          	bgeu	s4,a4,800040c8 <__printf+0x650>
    80003c5c:	02d7f5bb          	remuw	a1,a5,a3
    80003c60:	02059593          	slli	a1,a1,0x20
    80003c64:	0205d593          	srli	a1,a1,0x20
    80003c68:	00bd85b3          	add	a1,s11,a1
    80003c6c:	0005c583          	lbu	a1,0(a1)
    80003c70:	02d7d7bb          	divuw	a5,a5,a3
    80003c74:	f8b40323          	sb	a1,-122(s0)
    80003c78:	3eeaf863          	bgeu	s5,a4,80004068 <__printf+0x5f0>
    80003c7c:	02d7f5bb          	remuw	a1,a5,a3
    80003c80:	02059593          	slli	a1,a1,0x20
    80003c84:	0205d593          	srli	a1,a1,0x20
    80003c88:	00bd85b3          	add	a1,s11,a1
    80003c8c:	0005c583          	lbu	a1,0(a1)
    80003c90:	02d7d7bb          	divuw	a5,a5,a3
    80003c94:	f8b403a3          	sb	a1,-121(s0)
    80003c98:	42eb7e63          	bgeu	s6,a4,800040d4 <__printf+0x65c>
    80003c9c:	02d7f5bb          	remuw	a1,a5,a3
    80003ca0:	02059593          	slli	a1,a1,0x20
    80003ca4:	0205d593          	srli	a1,a1,0x20
    80003ca8:	00bd85b3          	add	a1,s11,a1
    80003cac:	0005c583          	lbu	a1,0(a1)
    80003cb0:	02d7d7bb          	divuw	a5,a5,a3
    80003cb4:	f8b40423          	sb	a1,-120(s0)
    80003cb8:	42ebfc63          	bgeu	s7,a4,800040f0 <__printf+0x678>
    80003cbc:	02079793          	slli	a5,a5,0x20
    80003cc0:	0207d793          	srli	a5,a5,0x20
    80003cc4:	00fd8db3          	add	s11,s11,a5
    80003cc8:	000dc703          	lbu	a4,0(s11)
    80003ccc:	00a00793          	li	a5,10
    80003cd0:	00900c93          	li	s9,9
    80003cd4:	f8e404a3          	sb	a4,-119(s0)
    80003cd8:	00065c63          	bgez	a2,80003cf0 <__printf+0x278>
    80003cdc:	f9040713          	addi	a4,s0,-112
    80003ce0:	00f70733          	add	a4,a4,a5
    80003ce4:	02d00693          	li	a3,45
    80003ce8:	fed70823          	sb	a3,-16(a4)
    80003cec:	00078c93          	mv	s9,a5
    80003cf0:	f8040793          	addi	a5,s0,-128
    80003cf4:	01978cb3          	add	s9,a5,s9
    80003cf8:	f7f40d13          	addi	s10,s0,-129
    80003cfc:	000cc503          	lbu	a0,0(s9)
    80003d00:	fffc8c93          	addi	s9,s9,-1
    80003d04:	00000097          	auipc	ra,0x0
    80003d08:	b90080e7          	jalr	-1136(ra) # 80003894 <consputc>
    80003d0c:	ffac98e3          	bne	s9,s10,80003cfc <__printf+0x284>
    80003d10:	00094503          	lbu	a0,0(s2)
    80003d14:	e00514e3          	bnez	a0,80003b1c <__printf+0xa4>
    80003d18:	1a0c1663          	bnez	s8,80003ec4 <__printf+0x44c>
    80003d1c:	08813083          	ld	ra,136(sp)
    80003d20:	08013403          	ld	s0,128(sp)
    80003d24:	07813483          	ld	s1,120(sp)
    80003d28:	07013903          	ld	s2,112(sp)
    80003d2c:	06813983          	ld	s3,104(sp)
    80003d30:	06013a03          	ld	s4,96(sp)
    80003d34:	05813a83          	ld	s5,88(sp)
    80003d38:	05013b03          	ld	s6,80(sp)
    80003d3c:	04813b83          	ld	s7,72(sp)
    80003d40:	04013c03          	ld	s8,64(sp)
    80003d44:	03813c83          	ld	s9,56(sp)
    80003d48:	03013d03          	ld	s10,48(sp)
    80003d4c:	02813d83          	ld	s11,40(sp)
    80003d50:	0d010113          	addi	sp,sp,208
    80003d54:	00008067          	ret
    80003d58:	07300713          	li	a4,115
    80003d5c:	1ce78a63          	beq	a5,a4,80003f30 <__printf+0x4b8>
    80003d60:	07800713          	li	a4,120
    80003d64:	1ee79e63          	bne	a5,a4,80003f60 <__printf+0x4e8>
    80003d68:	f7843783          	ld	a5,-136(s0)
    80003d6c:	0007a703          	lw	a4,0(a5)
    80003d70:	00878793          	addi	a5,a5,8
    80003d74:	f6f43c23          	sd	a5,-136(s0)
    80003d78:	28074263          	bltz	a4,80003ffc <__printf+0x584>
    80003d7c:	00001d97          	auipc	s11,0x1
    80003d80:	50cd8d93          	addi	s11,s11,1292 # 80005288 <digits>
    80003d84:	00f77793          	andi	a5,a4,15
    80003d88:	00fd87b3          	add	a5,s11,a5
    80003d8c:	0007c683          	lbu	a3,0(a5)
    80003d90:	00f00613          	li	a2,15
    80003d94:	0007079b          	sext.w	a5,a4
    80003d98:	f8d40023          	sb	a3,-128(s0)
    80003d9c:	0047559b          	srliw	a1,a4,0x4
    80003da0:	0047569b          	srliw	a3,a4,0x4
    80003da4:	00000c93          	li	s9,0
    80003da8:	0ee65063          	bge	a2,a4,80003e88 <__printf+0x410>
    80003dac:	00f6f693          	andi	a3,a3,15
    80003db0:	00dd86b3          	add	a3,s11,a3
    80003db4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003db8:	0087d79b          	srliw	a5,a5,0x8
    80003dbc:	00100c93          	li	s9,1
    80003dc0:	f8d400a3          	sb	a3,-127(s0)
    80003dc4:	0cb67263          	bgeu	a2,a1,80003e88 <__printf+0x410>
    80003dc8:	00f7f693          	andi	a3,a5,15
    80003dcc:	00dd86b3          	add	a3,s11,a3
    80003dd0:	0006c583          	lbu	a1,0(a3)
    80003dd4:	00f00613          	li	a2,15
    80003dd8:	0047d69b          	srliw	a3,a5,0x4
    80003ddc:	f8b40123          	sb	a1,-126(s0)
    80003de0:	0047d593          	srli	a1,a5,0x4
    80003de4:	28f67e63          	bgeu	a2,a5,80004080 <__printf+0x608>
    80003de8:	00f6f693          	andi	a3,a3,15
    80003dec:	00dd86b3          	add	a3,s11,a3
    80003df0:	0006c503          	lbu	a0,0(a3)
    80003df4:	0087d813          	srli	a6,a5,0x8
    80003df8:	0087d69b          	srliw	a3,a5,0x8
    80003dfc:	f8a401a3          	sb	a0,-125(s0)
    80003e00:	28b67663          	bgeu	a2,a1,8000408c <__printf+0x614>
    80003e04:	00f6f693          	andi	a3,a3,15
    80003e08:	00dd86b3          	add	a3,s11,a3
    80003e0c:	0006c583          	lbu	a1,0(a3)
    80003e10:	00c7d513          	srli	a0,a5,0xc
    80003e14:	00c7d69b          	srliw	a3,a5,0xc
    80003e18:	f8b40223          	sb	a1,-124(s0)
    80003e1c:	29067a63          	bgeu	a2,a6,800040b0 <__printf+0x638>
    80003e20:	00f6f693          	andi	a3,a3,15
    80003e24:	00dd86b3          	add	a3,s11,a3
    80003e28:	0006c583          	lbu	a1,0(a3)
    80003e2c:	0107d813          	srli	a6,a5,0x10
    80003e30:	0107d69b          	srliw	a3,a5,0x10
    80003e34:	f8b402a3          	sb	a1,-123(s0)
    80003e38:	28a67263          	bgeu	a2,a0,800040bc <__printf+0x644>
    80003e3c:	00f6f693          	andi	a3,a3,15
    80003e40:	00dd86b3          	add	a3,s11,a3
    80003e44:	0006c683          	lbu	a3,0(a3)
    80003e48:	0147d79b          	srliw	a5,a5,0x14
    80003e4c:	f8d40323          	sb	a3,-122(s0)
    80003e50:	21067663          	bgeu	a2,a6,8000405c <__printf+0x5e4>
    80003e54:	02079793          	slli	a5,a5,0x20
    80003e58:	0207d793          	srli	a5,a5,0x20
    80003e5c:	00fd8db3          	add	s11,s11,a5
    80003e60:	000dc683          	lbu	a3,0(s11)
    80003e64:	00800793          	li	a5,8
    80003e68:	00700c93          	li	s9,7
    80003e6c:	f8d403a3          	sb	a3,-121(s0)
    80003e70:	00075c63          	bgez	a4,80003e88 <__printf+0x410>
    80003e74:	f9040713          	addi	a4,s0,-112
    80003e78:	00f70733          	add	a4,a4,a5
    80003e7c:	02d00693          	li	a3,45
    80003e80:	fed70823          	sb	a3,-16(a4)
    80003e84:	00078c93          	mv	s9,a5
    80003e88:	f8040793          	addi	a5,s0,-128
    80003e8c:	01978cb3          	add	s9,a5,s9
    80003e90:	f7f40d13          	addi	s10,s0,-129
    80003e94:	000cc503          	lbu	a0,0(s9)
    80003e98:	fffc8c93          	addi	s9,s9,-1
    80003e9c:	00000097          	auipc	ra,0x0
    80003ea0:	9f8080e7          	jalr	-1544(ra) # 80003894 <consputc>
    80003ea4:	ff9d18e3          	bne	s10,s9,80003e94 <__printf+0x41c>
    80003ea8:	0100006f          	j	80003eb8 <__printf+0x440>
    80003eac:	00000097          	auipc	ra,0x0
    80003eb0:	9e8080e7          	jalr	-1560(ra) # 80003894 <consputc>
    80003eb4:	000c8493          	mv	s1,s9
    80003eb8:	00094503          	lbu	a0,0(s2)
    80003ebc:	c60510e3          	bnez	a0,80003b1c <__printf+0xa4>
    80003ec0:	e40c0ee3          	beqz	s8,80003d1c <__printf+0x2a4>
    80003ec4:	00003517          	auipc	a0,0x3
    80003ec8:	5ec50513          	addi	a0,a0,1516 # 800074b0 <pr>
    80003ecc:	00001097          	auipc	ra,0x1
    80003ed0:	94c080e7          	jalr	-1716(ra) # 80004818 <release>
    80003ed4:	e49ff06f          	j	80003d1c <__printf+0x2a4>
    80003ed8:	f7843783          	ld	a5,-136(s0)
    80003edc:	03000513          	li	a0,48
    80003ee0:	01000d13          	li	s10,16
    80003ee4:	00878713          	addi	a4,a5,8
    80003ee8:	0007bc83          	ld	s9,0(a5)
    80003eec:	f6e43c23          	sd	a4,-136(s0)
    80003ef0:	00000097          	auipc	ra,0x0
    80003ef4:	9a4080e7          	jalr	-1628(ra) # 80003894 <consputc>
    80003ef8:	07800513          	li	a0,120
    80003efc:	00000097          	auipc	ra,0x0
    80003f00:	998080e7          	jalr	-1640(ra) # 80003894 <consputc>
    80003f04:	00001d97          	auipc	s11,0x1
    80003f08:	384d8d93          	addi	s11,s11,900 # 80005288 <digits>
    80003f0c:	03ccd793          	srli	a5,s9,0x3c
    80003f10:	00fd87b3          	add	a5,s11,a5
    80003f14:	0007c503          	lbu	a0,0(a5)
    80003f18:	fffd0d1b          	addiw	s10,s10,-1
    80003f1c:	004c9c93          	slli	s9,s9,0x4
    80003f20:	00000097          	auipc	ra,0x0
    80003f24:	974080e7          	jalr	-1676(ra) # 80003894 <consputc>
    80003f28:	fe0d12e3          	bnez	s10,80003f0c <__printf+0x494>
    80003f2c:	f8dff06f          	j	80003eb8 <__printf+0x440>
    80003f30:	f7843783          	ld	a5,-136(s0)
    80003f34:	0007bc83          	ld	s9,0(a5)
    80003f38:	00878793          	addi	a5,a5,8
    80003f3c:	f6f43c23          	sd	a5,-136(s0)
    80003f40:	000c9a63          	bnez	s9,80003f54 <__printf+0x4dc>
    80003f44:	1080006f          	j	8000404c <__printf+0x5d4>
    80003f48:	001c8c93          	addi	s9,s9,1
    80003f4c:	00000097          	auipc	ra,0x0
    80003f50:	948080e7          	jalr	-1720(ra) # 80003894 <consputc>
    80003f54:	000cc503          	lbu	a0,0(s9)
    80003f58:	fe0518e3          	bnez	a0,80003f48 <__printf+0x4d0>
    80003f5c:	f5dff06f          	j	80003eb8 <__printf+0x440>
    80003f60:	02500513          	li	a0,37
    80003f64:	00000097          	auipc	ra,0x0
    80003f68:	930080e7          	jalr	-1744(ra) # 80003894 <consputc>
    80003f6c:	000c8513          	mv	a0,s9
    80003f70:	00000097          	auipc	ra,0x0
    80003f74:	924080e7          	jalr	-1756(ra) # 80003894 <consputc>
    80003f78:	f41ff06f          	j	80003eb8 <__printf+0x440>
    80003f7c:	02500513          	li	a0,37
    80003f80:	00000097          	auipc	ra,0x0
    80003f84:	914080e7          	jalr	-1772(ra) # 80003894 <consputc>
    80003f88:	f31ff06f          	j	80003eb8 <__printf+0x440>
    80003f8c:	00030513          	mv	a0,t1
    80003f90:	00000097          	auipc	ra,0x0
    80003f94:	7bc080e7          	jalr	1980(ra) # 8000474c <acquire>
    80003f98:	b4dff06f          	j	80003ae4 <__printf+0x6c>
    80003f9c:	40c0053b          	negw	a0,a2
    80003fa0:	00a00713          	li	a4,10
    80003fa4:	02e576bb          	remuw	a3,a0,a4
    80003fa8:	00001d97          	auipc	s11,0x1
    80003fac:	2e0d8d93          	addi	s11,s11,736 # 80005288 <digits>
    80003fb0:	ff700593          	li	a1,-9
    80003fb4:	02069693          	slli	a3,a3,0x20
    80003fb8:	0206d693          	srli	a3,a3,0x20
    80003fbc:	00dd86b3          	add	a3,s11,a3
    80003fc0:	0006c683          	lbu	a3,0(a3)
    80003fc4:	02e557bb          	divuw	a5,a0,a4
    80003fc8:	f8d40023          	sb	a3,-128(s0)
    80003fcc:	10b65e63          	bge	a2,a1,800040e8 <__printf+0x670>
    80003fd0:	06300593          	li	a1,99
    80003fd4:	02e7f6bb          	remuw	a3,a5,a4
    80003fd8:	02069693          	slli	a3,a3,0x20
    80003fdc:	0206d693          	srli	a3,a3,0x20
    80003fe0:	00dd86b3          	add	a3,s11,a3
    80003fe4:	0006c683          	lbu	a3,0(a3)
    80003fe8:	02e7d73b          	divuw	a4,a5,a4
    80003fec:	00200793          	li	a5,2
    80003ff0:	f8d400a3          	sb	a3,-127(s0)
    80003ff4:	bca5ece3          	bltu	a1,a0,80003bcc <__printf+0x154>
    80003ff8:	ce5ff06f          	j	80003cdc <__printf+0x264>
    80003ffc:	40e007bb          	negw	a5,a4
    80004000:	00001d97          	auipc	s11,0x1
    80004004:	288d8d93          	addi	s11,s11,648 # 80005288 <digits>
    80004008:	00f7f693          	andi	a3,a5,15
    8000400c:	00dd86b3          	add	a3,s11,a3
    80004010:	0006c583          	lbu	a1,0(a3)
    80004014:	ff100613          	li	a2,-15
    80004018:	0047d69b          	srliw	a3,a5,0x4
    8000401c:	f8b40023          	sb	a1,-128(s0)
    80004020:	0047d59b          	srliw	a1,a5,0x4
    80004024:	0ac75e63          	bge	a4,a2,800040e0 <__printf+0x668>
    80004028:	00f6f693          	andi	a3,a3,15
    8000402c:	00dd86b3          	add	a3,s11,a3
    80004030:	0006c603          	lbu	a2,0(a3)
    80004034:	00f00693          	li	a3,15
    80004038:	0087d79b          	srliw	a5,a5,0x8
    8000403c:	f8c400a3          	sb	a2,-127(s0)
    80004040:	d8b6e4e3          	bltu	a3,a1,80003dc8 <__printf+0x350>
    80004044:	00200793          	li	a5,2
    80004048:	e2dff06f          	j	80003e74 <__printf+0x3fc>
    8000404c:	00001c97          	auipc	s9,0x1
    80004050:	21cc8c93          	addi	s9,s9,540 # 80005268 <CONSOLE_STATUS+0x258>
    80004054:	02800513          	li	a0,40
    80004058:	ef1ff06f          	j	80003f48 <__printf+0x4d0>
    8000405c:	00700793          	li	a5,7
    80004060:	00600c93          	li	s9,6
    80004064:	e0dff06f          	j	80003e70 <__printf+0x3f8>
    80004068:	00700793          	li	a5,7
    8000406c:	00600c93          	li	s9,6
    80004070:	c69ff06f          	j	80003cd8 <__printf+0x260>
    80004074:	00300793          	li	a5,3
    80004078:	00200c93          	li	s9,2
    8000407c:	c5dff06f          	j	80003cd8 <__printf+0x260>
    80004080:	00300793          	li	a5,3
    80004084:	00200c93          	li	s9,2
    80004088:	de9ff06f          	j	80003e70 <__printf+0x3f8>
    8000408c:	00400793          	li	a5,4
    80004090:	00300c93          	li	s9,3
    80004094:	dddff06f          	j	80003e70 <__printf+0x3f8>
    80004098:	00400793          	li	a5,4
    8000409c:	00300c93          	li	s9,3
    800040a0:	c39ff06f          	j	80003cd8 <__printf+0x260>
    800040a4:	00500793          	li	a5,5
    800040a8:	00400c93          	li	s9,4
    800040ac:	c2dff06f          	j	80003cd8 <__printf+0x260>
    800040b0:	00500793          	li	a5,5
    800040b4:	00400c93          	li	s9,4
    800040b8:	db9ff06f          	j	80003e70 <__printf+0x3f8>
    800040bc:	00600793          	li	a5,6
    800040c0:	00500c93          	li	s9,5
    800040c4:	dadff06f          	j	80003e70 <__printf+0x3f8>
    800040c8:	00600793          	li	a5,6
    800040cc:	00500c93          	li	s9,5
    800040d0:	c09ff06f          	j	80003cd8 <__printf+0x260>
    800040d4:	00800793          	li	a5,8
    800040d8:	00700c93          	li	s9,7
    800040dc:	bfdff06f          	j	80003cd8 <__printf+0x260>
    800040e0:	00100793          	li	a5,1
    800040e4:	d91ff06f          	j	80003e74 <__printf+0x3fc>
    800040e8:	00100793          	li	a5,1
    800040ec:	bf1ff06f          	j	80003cdc <__printf+0x264>
    800040f0:	00900793          	li	a5,9
    800040f4:	00800c93          	li	s9,8
    800040f8:	be1ff06f          	j	80003cd8 <__printf+0x260>
    800040fc:	00001517          	auipc	a0,0x1
    80004100:	17450513          	addi	a0,a0,372 # 80005270 <CONSOLE_STATUS+0x260>
    80004104:	00000097          	auipc	ra,0x0
    80004108:	918080e7          	jalr	-1768(ra) # 80003a1c <panic>

000000008000410c <printfinit>:
    8000410c:	fe010113          	addi	sp,sp,-32
    80004110:	00813823          	sd	s0,16(sp)
    80004114:	00913423          	sd	s1,8(sp)
    80004118:	00113c23          	sd	ra,24(sp)
    8000411c:	02010413          	addi	s0,sp,32
    80004120:	00003497          	auipc	s1,0x3
    80004124:	39048493          	addi	s1,s1,912 # 800074b0 <pr>
    80004128:	00048513          	mv	a0,s1
    8000412c:	00001597          	auipc	a1,0x1
    80004130:	15458593          	addi	a1,a1,340 # 80005280 <CONSOLE_STATUS+0x270>
    80004134:	00000097          	auipc	ra,0x0
    80004138:	5f4080e7          	jalr	1524(ra) # 80004728 <initlock>
    8000413c:	01813083          	ld	ra,24(sp)
    80004140:	01013403          	ld	s0,16(sp)
    80004144:	0004ac23          	sw	zero,24(s1)
    80004148:	00813483          	ld	s1,8(sp)
    8000414c:	02010113          	addi	sp,sp,32
    80004150:	00008067          	ret

0000000080004154 <uartinit>:
    80004154:	ff010113          	addi	sp,sp,-16
    80004158:	00813423          	sd	s0,8(sp)
    8000415c:	01010413          	addi	s0,sp,16
    80004160:	100007b7          	lui	a5,0x10000
    80004164:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004168:	f8000713          	li	a4,-128
    8000416c:	00e781a3          	sb	a4,3(a5)
    80004170:	00300713          	li	a4,3
    80004174:	00e78023          	sb	a4,0(a5)
    80004178:	000780a3          	sb	zero,1(a5)
    8000417c:	00e781a3          	sb	a4,3(a5)
    80004180:	00700693          	li	a3,7
    80004184:	00d78123          	sb	a3,2(a5)
    80004188:	00e780a3          	sb	a4,1(a5)
    8000418c:	00813403          	ld	s0,8(sp)
    80004190:	01010113          	addi	sp,sp,16
    80004194:	00008067          	ret

0000000080004198 <uartputc>:
    80004198:	00002797          	auipc	a5,0x2
    8000419c:	0407a783          	lw	a5,64(a5) # 800061d8 <panicked>
    800041a0:	00078463          	beqz	a5,800041a8 <uartputc+0x10>
    800041a4:	0000006f          	j	800041a4 <uartputc+0xc>
    800041a8:	fd010113          	addi	sp,sp,-48
    800041ac:	02813023          	sd	s0,32(sp)
    800041b0:	00913c23          	sd	s1,24(sp)
    800041b4:	01213823          	sd	s2,16(sp)
    800041b8:	01313423          	sd	s3,8(sp)
    800041bc:	02113423          	sd	ra,40(sp)
    800041c0:	03010413          	addi	s0,sp,48
    800041c4:	00002917          	auipc	s2,0x2
    800041c8:	01c90913          	addi	s2,s2,28 # 800061e0 <uart_tx_r>
    800041cc:	00093783          	ld	a5,0(s2)
    800041d0:	00002497          	auipc	s1,0x2
    800041d4:	01848493          	addi	s1,s1,24 # 800061e8 <uart_tx_w>
    800041d8:	0004b703          	ld	a4,0(s1)
    800041dc:	02078693          	addi	a3,a5,32
    800041e0:	00050993          	mv	s3,a0
    800041e4:	02e69c63          	bne	a3,a4,8000421c <uartputc+0x84>
    800041e8:	00001097          	auipc	ra,0x1
    800041ec:	834080e7          	jalr	-1996(ra) # 80004a1c <push_on>
    800041f0:	00093783          	ld	a5,0(s2)
    800041f4:	0004b703          	ld	a4,0(s1)
    800041f8:	02078793          	addi	a5,a5,32
    800041fc:	00e79463          	bne	a5,a4,80004204 <uartputc+0x6c>
    80004200:	0000006f          	j	80004200 <uartputc+0x68>
    80004204:	00001097          	auipc	ra,0x1
    80004208:	88c080e7          	jalr	-1908(ra) # 80004a90 <pop_on>
    8000420c:	00093783          	ld	a5,0(s2)
    80004210:	0004b703          	ld	a4,0(s1)
    80004214:	02078693          	addi	a3,a5,32
    80004218:	fce688e3          	beq	a3,a4,800041e8 <uartputc+0x50>
    8000421c:	01f77693          	andi	a3,a4,31
    80004220:	00003597          	auipc	a1,0x3
    80004224:	2b058593          	addi	a1,a1,688 # 800074d0 <uart_tx_buf>
    80004228:	00d586b3          	add	a3,a1,a3
    8000422c:	00170713          	addi	a4,a4,1
    80004230:	01368023          	sb	s3,0(a3)
    80004234:	00e4b023          	sd	a4,0(s1)
    80004238:	10000637          	lui	a2,0x10000
    8000423c:	02f71063          	bne	a4,a5,8000425c <uartputc+0xc4>
    80004240:	0340006f          	j	80004274 <uartputc+0xdc>
    80004244:	00074703          	lbu	a4,0(a4)
    80004248:	00f93023          	sd	a5,0(s2)
    8000424c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004250:	00093783          	ld	a5,0(s2)
    80004254:	0004b703          	ld	a4,0(s1)
    80004258:	00f70e63          	beq	a4,a5,80004274 <uartputc+0xdc>
    8000425c:	00564683          	lbu	a3,5(a2)
    80004260:	01f7f713          	andi	a4,a5,31
    80004264:	00e58733          	add	a4,a1,a4
    80004268:	0206f693          	andi	a3,a3,32
    8000426c:	00178793          	addi	a5,a5,1
    80004270:	fc069ae3          	bnez	a3,80004244 <uartputc+0xac>
    80004274:	02813083          	ld	ra,40(sp)
    80004278:	02013403          	ld	s0,32(sp)
    8000427c:	01813483          	ld	s1,24(sp)
    80004280:	01013903          	ld	s2,16(sp)
    80004284:	00813983          	ld	s3,8(sp)
    80004288:	03010113          	addi	sp,sp,48
    8000428c:	00008067          	ret

0000000080004290 <uartputc_sync>:
    80004290:	ff010113          	addi	sp,sp,-16
    80004294:	00813423          	sd	s0,8(sp)
    80004298:	01010413          	addi	s0,sp,16
    8000429c:	00002717          	auipc	a4,0x2
    800042a0:	f3c72703          	lw	a4,-196(a4) # 800061d8 <panicked>
    800042a4:	02071663          	bnez	a4,800042d0 <uartputc_sync+0x40>
    800042a8:	00050793          	mv	a5,a0
    800042ac:	100006b7          	lui	a3,0x10000
    800042b0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800042b4:	02077713          	andi	a4,a4,32
    800042b8:	fe070ce3          	beqz	a4,800042b0 <uartputc_sync+0x20>
    800042bc:	0ff7f793          	andi	a5,a5,255
    800042c0:	00f68023          	sb	a5,0(a3)
    800042c4:	00813403          	ld	s0,8(sp)
    800042c8:	01010113          	addi	sp,sp,16
    800042cc:	00008067          	ret
    800042d0:	0000006f          	j	800042d0 <uartputc_sync+0x40>

00000000800042d4 <uartstart>:
    800042d4:	ff010113          	addi	sp,sp,-16
    800042d8:	00813423          	sd	s0,8(sp)
    800042dc:	01010413          	addi	s0,sp,16
    800042e0:	00002617          	auipc	a2,0x2
    800042e4:	f0060613          	addi	a2,a2,-256 # 800061e0 <uart_tx_r>
    800042e8:	00002517          	auipc	a0,0x2
    800042ec:	f0050513          	addi	a0,a0,-256 # 800061e8 <uart_tx_w>
    800042f0:	00063783          	ld	a5,0(a2)
    800042f4:	00053703          	ld	a4,0(a0)
    800042f8:	04f70263          	beq	a4,a5,8000433c <uartstart+0x68>
    800042fc:	100005b7          	lui	a1,0x10000
    80004300:	00003817          	auipc	a6,0x3
    80004304:	1d080813          	addi	a6,a6,464 # 800074d0 <uart_tx_buf>
    80004308:	01c0006f          	j	80004324 <uartstart+0x50>
    8000430c:	0006c703          	lbu	a4,0(a3)
    80004310:	00f63023          	sd	a5,0(a2)
    80004314:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004318:	00063783          	ld	a5,0(a2)
    8000431c:	00053703          	ld	a4,0(a0)
    80004320:	00f70e63          	beq	a4,a5,8000433c <uartstart+0x68>
    80004324:	01f7f713          	andi	a4,a5,31
    80004328:	00e806b3          	add	a3,a6,a4
    8000432c:	0055c703          	lbu	a4,5(a1)
    80004330:	00178793          	addi	a5,a5,1
    80004334:	02077713          	andi	a4,a4,32
    80004338:	fc071ae3          	bnez	a4,8000430c <uartstart+0x38>
    8000433c:	00813403          	ld	s0,8(sp)
    80004340:	01010113          	addi	sp,sp,16
    80004344:	00008067          	ret

0000000080004348 <uartgetc>:
    80004348:	ff010113          	addi	sp,sp,-16
    8000434c:	00813423          	sd	s0,8(sp)
    80004350:	01010413          	addi	s0,sp,16
    80004354:	10000737          	lui	a4,0x10000
    80004358:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000435c:	0017f793          	andi	a5,a5,1
    80004360:	00078c63          	beqz	a5,80004378 <uartgetc+0x30>
    80004364:	00074503          	lbu	a0,0(a4)
    80004368:	0ff57513          	andi	a0,a0,255
    8000436c:	00813403          	ld	s0,8(sp)
    80004370:	01010113          	addi	sp,sp,16
    80004374:	00008067          	ret
    80004378:	fff00513          	li	a0,-1
    8000437c:	ff1ff06f          	j	8000436c <uartgetc+0x24>

0000000080004380 <uartintr>:
    80004380:	100007b7          	lui	a5,0x10000
    80004384:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004388:	0017f793          	andi	a5,a5,1
    8000438c:	0a078463          	beqz	a5,80004434 <uartintr+0xb4>
    80004390:	fe010113          	addi	sp,sp,-32
    80004394:	00813823          	sd	s0,16(sp)
    80004398:	00913423          	sd	s1,8(sp)
    8000439c:	00113c23          	sd	ra,24(sp)
    800043a0:	02010413          	addi	s0,sp,32
    800043a4:	100004b7          	lui	s1,0x10000
    800043a8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800043ac:	0ff57513          	andi	a0,a0,255
    800043b0:	fffff097          	auipc	ra,0xfffff
    800043b4:	534080e7          	jalr	1332(ra) # 800038e4 <consoleintr>
    800043b8:	0054c783          	lbu	a5,5(s1)
    800043bc:	0017f793          	andi	a5,a5,1
    800043c0:	fe0794e3          	bnez	a5,800043a8 <uartintr+0x28>
    800043c4:	00002617          	auipc	a2,0x2
    800043c8:	e1c60613          	addi	a2,a2,-484 # 800061e0 <uart_tx_r>
    800043cc:	00002517          	auipc	a0,0x2
    800043d0:	e1c50513          	addi	a0,a0,-484 # 800061e8 <uart_tx_w>
    800043d4:	00063783          	ld	a5,0(a2)
    800043d8:	00053703          	ld	a4,0(a0)
    800043dc:	04f70263          	beq	a4,a5,80004420 <uartintr+0xa0>
    800043e0:	100005b7          	lui	a1,0x10000
    800043e4:	00003817          	auipc	a6,0x3
    800043e8:	0ec80813          	addi	a6,a6,236 # 800074d0 <uart_tx_buf>
    800043ec:	01c0006f          	j	80004408 <uartintr+0x88>
    800043f0:	0006c703          	lbu	a4,0(a3)
    800043f4:	00f63023          	sd	a5,0(a2)
    800043f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800043fc:	00063783          	ld	a5,0(a2)
    80004400:	00053703          	ld	a4,0(a0)
    80004404:	00f70e63          	beq	a4,a5,80004420 <uartintr+0xa0>
    80004408:	01f7f713          	andi	a4,a5,31
    8000440c:	00e806b3          	add	a3,a6,a4
    80004410:	0055c703          	lbu	a4,5(a1)
    80004414:	00178793          	addi	a5,a5,1
    80004418:	02077713          	andi	a4,a4,32
    8000441c:	fc071ae3          	bnez	a4,800043f0 <uartintr+0x70>
    80004420:	01813083          	ld	ra,24(sp)
    80004424:	01013403          	ld	s0,16(sp)
    80004428:	00813483          	ld	s1,8(sp)
    8000442c:	02010113          	addi	sp,sp,32
    80004430:	00008067          	ret
    80004434:	00002617          	auipc	a2,0x2
    80004438:	dac60613          	addi	a2,a2,-596 # 800061e0 <uart_tx_r>
    8000443c:	00002517          	auipc	a0,0x2
    80004440:	dac50513          	addi	a0,a0,-596 # 800061e8 <uart_tx_w>
    80004444:	00063783          	ld	a5,0(a2)
    80004448:	00053703          	ld	a4,0(a0)
    8000444c:	04f70263          	beq	a4,a5,80004490 <uartintr+0x110>
    80004450:	100005b7          	lui	a1,0x10000
    80004454:	00003817          	auipc	a6,0x3
    80004458:	07c80813          	addi	a6,a6,124 # 800074d0 <uart_tx_buf>
    8000445c:	01c0006f          	j	80004478 <uartintr+0xf8>
    80004460:	0006c703          	lbu	a4,0(a3)
    80004464:	00f63023          	sd	a5,0(a2)
    80004468:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000446c:	00063783          	ld	a5,0(a2)
    80004470:	00053703          	ld	a4,0(a0)
    80004474:	02f70063          	beq	a4,a5,80004494 <uartintr+0x114>
    80004478:	01f7f713          	andi	a4,a5,31
    8000447c:	00e806b3          	add	a3,a6,a4
    80004480:	0055c703          	lbu	a4,5(a1)
    80004484:	00178793          	addi	a5,a5,1
    80004488:	02077713          	andi	a4,a4,32
    8000448c:	fc071ae3          	bnez	a4,80004460 <uartintr+0xe0>
    80004490:	00008067          	ret
    80004494:	00008067          	ret

0000000080004498 <kinit>:
    80004498:	fc010113          	addi	sp,sp,-64
    8000449c:	02913423          	sd	s1,40(sp)
    800044a0:	fffff7b7          	lui	a5,0xfffff
    800044a4:	00004497          	auipc	s1,0x4
    800044a8:	04b48493          	addi	s1,s1,75 # 800084ef <end+0xfff>
    800044ac:	02813823          	sd	s0,48(sp)
    800044b0:	01313c23          	sd	s3,24(sp)
    800044b4:	00f4f4b3          	and	s1,s1,a5
    800044b8:	02113c23          	sd	ra,56(sp)
    800044bc:	03213023          	sd	s2,32(sp)
    800044c0:	01413823          	sd	s4,16(sp)
    800044c4:	01513423          	sd	s5,8(sp)
    800044c8:	04010413          	addi	s0,sp,64
    800044cc:	000017b7          	lui	a5,0x1
    800044d0:	01100993          	li	s3,17
    800044d4:	00f487b3          	add	a5,s1,a5
    800044d8:	01b99993          	slli	s3,s3,0x1b
    800044dc:	06f9e063          	bltu	s3,a5,8000453c <kinit+0xa4>
    800044e0:	00003a97          	auipc	s5,0x3
    800044e4:	010a8a93          	addi	s5,s5,16 # 800074f0 <end>
    800044e8:	0754ec63          	bltu	s1,s5,80004560 <kinit+0xc8>
    800044ec:	0734fa63          	bgeu	s1,s3,80004560 <kinit+0xc8>
    800044f0:	00088a37          	lui	s4,0x88
    800044f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800044f8:	00002917          	auipc	s2,0x2
    800044fc:	cf890913          	addi	s2,s2,-776 # 800061f0 <kmem>
    80004500:	00ca1a13          	slli	s4,s4,0xc
    80004504:	0140006f          	j	80004518 <kinit+0x80>
    80004508:	000017b7          	lui	a5,0x1
    8000450c:	00f484b3          	add	s1,s1,a5
    80004510:	0554e863          	bltu	s1,s5,80004560 <kinit+0xc8>
    80004514:	0534f663          	bgeu	s1,s3,80004560 <kinit+0xc8>
    80004518:	00001637          	lui	a2,0x1
    8000451c:	00100593          	li	a1,1
    80004520:	00048513          	mv	a0,s1
    80004524:	00000097          	auipc	ra,0x0
    80004528:	5e4080e7          	jalr	1508(ra) # 80004b08 <__memset>
    8000452c:	00093783          	ld	a5,0(s2)
    80004530:	00f4b023          	sd	a5,0(s1)
    80004534:	00993023          	sd	s1,0(s2)
    80004538:	fd4498e3          	bne	s1,s4,80004508 <kinit+0x70>
    8000453c:	03813083          	ld	ra,56(sp)
    80004540:	03013403          	ld	s0,48(sp)
    80004544:	02813483          	ld	s1,40(sp)
    80004548:	02013903          	ld	s2,32(sp)
    8000454c:	01813983          	ld	s3,24(sp)
    80004550:	01013a03          	ld	s4,16(sp)
    80004554:	00813a83          	ld	s5,8(sp)
    80004558:	04010113          	addi	sp,sp,64
    8000455c:	00008067          	ret
    80004560:	00001517          	auipc	a0,0x1
    80004564:	d4050513          	addi	a0,a0,-704 # 800052a0 <digits+0x18>
    80004568:	fffff097          	auipc	ra,0xfffff
    8000456c:	4b4080e7          	jalr	1204(ra) # 80003a1c <panic>

0000000080004570 <freerange>:
    80004570:	fc010113          	addi	sp,sp,-64
    80004574:	000017b7          	lui	a5,0x1
    80004578:	02913423          	sd	s1,40(sp)
    8000457c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004580:	009504b3          	add	s1,a0,s1
    80004584:	fffff537          	lui	a0,0xfffff
    80004588:	02813823          	sd	s0,48(sp)
    8000458c:	02113c23          	sd	ra,56(sp)
    80004590:	03213023          	sd	s2,32(sp)
    80004594:	01313c23          	sd	s3,24(sp)
    80004598:	01413823          	sd	s4,16(sp)
    8000459c:	01513423          	sd	s5,8(sp)
    800045a0:	01613023          	sd	s6,0(sp)
    800045a4:	04010413          	addi	s0,sp,64
    800045a8:	00a4f4b3          	and	s1,s1,a0
    800045ac:	00f487b3          	add	a5,s1,a5
    800045b0:	06f5e463          	bltu	a1,a5,80004618 <freerange+0xa8>
    800045b4:	00003a97          	auipc	s5,0x3
    800045b8:	f3ca8a93          	addi	s5,s5,-196 # 800074f0 <end>
    800045bc:	0954e263          	bltu	s1,s5,80004640 <freerange+0xd0>
    800045c0:	01100993          	li	s3,17
    800045c4:	01b99993          	slli	s3,s3,0x1b
    800045c8:	0734fc63          	bgeu	s1,s3,80004640 <freerange+0xd0>
    800045cc:	00058a13          	mv	s4,a1
    800045d0:	00002917          	auipc	s2,0x2
    800045d4:	c2090913          	addi	s2,s2,-992 # 800061f0 <kmem>
    800045d8:	00002b37          	lui	s6,0x2
    800045dc:	0140006f          	j	800045f0 <freerange+0x80>
    800045e0:	000017b7          	lui	a5,0x1
    800045e4:	00f484b3          	add	s1,s1,a5
    800045e8:	0554ec63          	bltu	s1,s5,80004640 <freerange+0xd0>
    800045ec:	0534fa63          	bgeu	s1,s3,80004640 <freerange+0xd0>
    800045f0:	00001637          	lui	a2,0x1
    800045f4:	00100593          	li	a1,1
    800045f8:	00048513          	mv	a0,s1
    800045fc:	00000097          	auipc	ra,0x0
    80004600:	50c080e7          	jalr	1292(ra) # 80004b08 <__memset>
    80004604:	00093703          	ld	a4,0(s2)
    80004608:	016487b3          	add	a5,s1,s6
    8000460c:	00e4b023          	sd	a4,0(s1)
    80004610:	00993023          	sd	s1,0(s2)
    80004614:	fcfa76e3          	bgeu	s4,a5,800045e0 <freerange+0x70>
    80004618:	03813083          	ld	ra,56(sp)
    8000461c:	03013403          	ld	s0,48(sp)
    80004620:	02813483          	ld	s1,40(sp)
    80004624:	02013903          	ld	s2,32(sp)
    80004628:	01813983          	ld	s3,24(sp)
    8000462c:	01013a03          	ld	s4,16(sp)
    80004630:	00813a83          	ld	s5,8(sp)
    80004634:	00013b03          	ld	s6,0(sp)
    80004638:	04010113          	addi	sp,sp,64
    8000463c:	00008067          	ret
    80004640:	00001517          	auipc	a0,0x1
    80004644:	c6050513          	addi	a0,a0,-928 # 800052a0 <digits+0x18>
    80004648:	fffff097          	auipc	ra,0xfffff
    8000464c:	3d4080e7          	jalr	980(ra) # 80003a1c <panic>

0000000080004650 <kfree>:
    80004650:	fe010113          	addi	sp,sp,-32
    80004654:	00813823          	sd	s0,16(sp)
    80004658:	00113c23          	sd	ra,24(sp)
    8000465c:	00913423          	sd	s1,8(sp)
    80004660:	02010413          	addi	s0,sp,32
    80004664:	03451793          	slli	a5,a0,0x34
    80004668:	04079c63          	bnez	a5,800046c0 <kfree+0x70>
    8000466c:	00003797          	auipc	a5,0x3
    80004670:	e8478793          	addi	a5,a5,-380 # 800074f0 <end>
    80004674:	00050493          	mv	s1,a0
    80004678:	04f56463          	bltu	a0,a5,800046c0 <kfree+0x70>
    8000467c:	01100793          	li	a5,17
    80004680:	01b79793          	slli	a5,a5,0x1b
    80004684:	02f57e63          	bgeu	a0,a5,800046c0 <kfree+0x70>
    80004688:	00001637          	lui	a2,0x1
    8000468c:	00100593          	li	a1,1
    80004690:	00000097          	auipc	ra,0x0
    80004694:	478080e7          	jalr	1144(ra) # 80004b08 <__memset>
    80004698:	00002797          	auipc	a5,0x2
    8000469c:	b5878793          	addi	a5,a5,-1192 # 800061f0 <kmem>
    800046a0:	0007b703          	ld	a4,0(a5)
    800046a4:	01813083          	ld	ra,24(sp)
    800046a8:	01013403          	ld	s0,16(sp)
    800046ac:	00e4b023          	sd	a4,0(s1)
    800046b0:	0097b023          	sd	s1,0(a5)
    800046b4:	00813483          	ld	s1,8(sp)
    800046b8:	02010113          	addi	sp,sp,32
    800046bc:	00008067          	ret
    800046c0:	00001517          	auipc	a0,0x1
    800046c4:	be050513          	addi	a0,a0,-1056 # 800052a0 <digits+0x18>
    800046c8:	fffff097          	auipc	ra,0xfffff
    800046cc:	354080e7          	jalr	852(ra) # 80003a1c <panic>

00000000800046d0 <kalloc>:
    800046d0:	fe010113          	addi	sp,sp,-32
    800046d4:	00813823          	sd	s0,16(sp)
    800046d8:	00913423          	sd	s1,8(sp)
    800046dc:	00113c23          	sd	ra,24(sp)
    800046e0:	02010413          	addi	s0,sp,32
    800046e4:	00002797          	auipc	a5,0x2
    800046e8:	b0c78793          	addi	a5,a5,-1268 # 800061f0 <kmem>
    800046ec:	0007b483          	ld	s1,0(a5)
    800046f0:	02048063          	beqz	s1,80004710 <kalloc+0x40>
    800046f4:	0004b703          	ld	a4,0(s1)
    800046f8:	00001637          	lui	a2,0x1
    800046fc:	00500593          	li	a1,5
    80004700:	00048513          	mv	a0,s1
    80004704:	00e7b023          	sd	a4,0(a5)
    80004708:	00000097          	auipc	ra,0x0
    8000470c:	400080e7          	jalr	1024(ra) # 80004b08 <__memset>
    80004710:	01813083          	ld	ra,24(sp)
    80004714:	01013403          	ld	s0,16(sp)
    80004718:	00048513          	mv	a0,s1
    8000471c:	00813483          	ld	s1,8(sp)
    80004720:	02010113          	addi	sp,sp,32
    80004724:	00008067          	ret

0000000080004728 <initlock>:
    80004728:	ff010113          	addi	sp,sp,-16
    8000472c:	00813423          	sd	s0,8(sp)
    80004730:	01010413          	addi	s0,sp,16
    80004734:	00813403          	ld	s0,8(sp)
    80004738:	00b53423          	sd	a1,8(a0)
    8000473c:	00052023          	sw	zero,0(a0)
    80004740:	00053823          	sd	zero,16(a0)
    80004744:	01010113          	addi	sp,sp,16
    80004748:	00008067          	ret

000000008000474c <acquire>:
    8000474c:	fe010113          	addi	sp,sp,-32
    80004750:	00813823          	sd	s0,16(sp)
    80004754:	00913423          	sd	s1,8(sp)
    80004758:	00113c23          	sd	ra,24(sp)
    8000475c:	01213023          	sd	s2,0(sp)
    80004760:	02010413          	addi	s0,sp,32
    80004764:	00050493          	mv	s1,a0
    80004768:	10002973          	csrr	s2,sstatus
    8000476c:	100027f3          	csrr	a5,sstatus
    80004770:	ffd7f793          	andi	a5,a5,-3
    80004774:	10079073          	csrw	sstatus,a5
    80004778:	fffff097          	auipc	ra,0xfffff
    8000477c:	8e0080e7          	jalr	-1824(ra) # 80003058 <mycpu>
    80004780:	07852783          	lw	a5,120(a0)
    80004784:	06078e63          	beqz	a5,80004800 <acquire+0xb4>
    80004788:	fffff097          	auipc	ra,0xfffff
    8000478c:	8d0080e7          	jalr	-1840(ra) # 80003058 <mycpu>
    80004790:	07852783          	lw	a5,120(a0)
    80004794:	0004a703          	lw	a4,0(s1)
    80004798:	0017879b          	addiw	a5,a5,1
    8000479c:	06f52c23          	sw	a5,120(a0)
    800047a0:	04071063          	bnez	a4,800047e0 <acquire+0x94>
    800047a4:	00100713          	li	a4,1
    800047a8:	00070793          	mv	a5,a4
    800047ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800047b0:	0007879b          	sext.w	a5,a5
    800047b4:	fe079ae3          	bnez	a5,800047a8 <acquire+0x5c>
    800047b8:	0ff0000f          	fence
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	89c080e7          	jalr	-1892(ra) # 80003058 <mycpu>
    800047c4:	01813083          	ld	ra,24(sp)
    800047c8:	01013403          	ld	s0,16(sp)
    800047cc:	00a4b823          	sd	a0,16(s1)
    800047d0:	00013903          	ld	s2,0(sp)
    800047d4:	00813483          	ld	s1,8(sp)
    800047d8:	02010113          	addi	sp,sp,32
    800047dc:	00008067          	ret
    800047e0:	0104b903          	ld	s2,16(s1)
    800047e4:	fffff097          	auipc	ra,0xfffff
    800047e8:	874080e7          	jalr	-1932(ra) # 80003058 <mycpu>
    800047ec:	faa91ce3          	bne	s2,a0,800047a4 <acquire+0x58>
    800047f0:	00001517          	auipc	a0,0x1
    800047f4:	ab850513          	addi	a0,a0,-1352 # 800052a8 <digits+0x20>
    800047f8:	fffff097          	auipc	ra,0xfffff
    800047fc:	224080e7          	jalr	548(ra) # 80003a1c <panic>
    80004800:	00195913          	srli	s2,s2,0x1
    80004804:	fffff097          	auipc	ra,0xfffff
    80004808:	854080e7          	jalr	-1964(ra) # 80003058 <mycpu>
    8000480c:	00197913          	andi	s2,s2,1
    80004810:	07252e23          	sw	s2,124(a0)
    80004814:	f75ff06f          	j	80004788 <acquire+0x3c>

0000000080004818 <release>:
    80004818:	fe010113          	addi	sp,sp,-32
    8000481c:	00813823          	sd	s0,16(sp)
    80004820:	00113c23          	sd	ra,24(sp)
    80004824:	00913423          	sd	s1,8(sp)
    80004828:	01213023          	sd	s2,0(sp)
    8000482c:	02010413          	addi	s0,sp,32
    80004830:	00052783          	lw	a5,0(a0)
    80004834:	00079a63          	bnez	a5,80004848 <release+0x30>
    80004838:	00001517          	auipc	a0,0x1
    8000483c:	a7850513          	addi	a0,a0,-1416 # 800052b0 <digits+0x28>
    80004840:	fffff097          	auipc	ra,0xfffff
    80004844:	1dc080e7          	jalr	476(ra) # 80003a1c <panic>
    80004848:	01053903          	ld	s2,16(a0)
    8000484c:	00050493          	mv	s1,a0
    80004850:	fffff097          	auipc	ra,0xfffff
    80004854:	808080e7          	jalr	-2040(ra) # 80003058 <mycpu>
    80004858:	fea910e3          	bne	s2,a0,80004838 <release+0x20>
    8000485c:	0004b823          	sd	zero,16(s1)
    80004860:	0ff0000f          	fence
    80004864:	0f50000f          	fence	iorw,ow
    80004868:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000486c:	ffffe097          	auipc	ra,0xffffe
    80004870:	7ec080e7          	jalr	2028(ra) # 80003058 <mycpu>
    80004874:	100027f3          	csrr	a5,sstatus
    80004878:	0027f793          	andi	a5,a5,2
    8000487c:	04079a63          	bnez	a5,800048d0 <release+0xb8>
    80004880:	07852783          	lw	a5,120(a0)
    80004884:	02f05e63          	blez	a5,800048c0 <release+0xa8>
    80004888:	fff7871b          	addiw	a4,a5,-1
    8000488c:	06e52c23          	sw	a4,120(a0)
    80004890:	00071c63          	bnez	a4,800048a8 <release+0x90>
    80004894:	07c52783          	lw	a5,124(a0)
    80004898:	00078863          	beqz	a5,800048a8 <release+0x90>
    8000489c:	100027f3          	csrr	a5,sstatus
    800048a0:	0027e793          	ori	a5,a5,2
    800048a4:	10079073          	csrw	sstatus,a5
    800048a8:	01813083          	ld	ra,24(sp)
    800048ac:	01013403          	ld	s0,16(sp)
    800048b0:	00813483          	ld	s1,8(sp)
    800048b4:	00013903          	ld	s2,0(sp)
    800048b8:	02010113          	addi	sp,sp,32
    800048bc:	00008067          	ret
    800048c0:	00001517          	auipc	a0,0x1
    800048c4:	a1050513          	addi	a0,a0,-1520 # 800052d0 <digits+0x48>
    800048c8:	fffff097          	auipc	ra,0xfffff
    800048cc:	154080e7          	jalr	340(ra) # 80003a1c <panic>
    800048d0:	00001517          	auipc	a0,0x1
    800048d4:	9e850513          	addi	a0,a0,-1560 # 800052b8 <digits+0x30>
    800048d8:	fffff097          	auipc	ra,0xfffff
    800048dc:	144080e7          	jalr	324(ra) # 80003a1c <panic>

00000000800048e0 <holding>:
    800048e0:	00052783          	lw	a5,0(a0)
    800048e4:	00079663          	bnez	a5,800048f0 <holding+0x10>
    800048e8:	00000513          	li	a0,0
    800048ec:	00008067          	ret
    800048f0:	fe010113          	addi	sp,sp,-32
    800048f4:	00813823          	sd	s0,16(sp)
    800048f8:	00913423          	sd	s1,8(sp)
    800048fc:	00113c23          	sd	ra,24(sp)
    80004900:	02010413          	addi	s0,sp,32
    80004904:	01053483          	ld	s1,16(a0)
    80004908:	ffffe097          	auipc	ra,0xffffe
    8000490c:	750080e7          	jalr	1872(ra) # 80003058 <mycpu>
    80004910:	01813083          	ld	ra,24(sp)
    80004914:	01013403          	ld	s0,16(sp)
    80004918:	40a48533          	sub	a0,s1,a0
    8000491c:	00153513          	seqz	a0,a0
    80004920:	00813483          	ld	s1,8(sp)
    80004924:	02010113          	addi	sp,sp,32
    80004928:	00008067          	ret

000000008000492c <push_off>:
    8000492c:	fe010113          	addi	sp,sp,-32
    80004930:	00813823          	sd	s0,16(sp)
    80004934:	00113c23          	sd	ra,24(sp)
    80004938:	00913423          	sd	s1,8(sp)
    8000493c:	02010413          	addi	s0,sp,32
    80004940:	100024f3          	csrr	s1,sstatus
    80004944:	100027f3          	csrr	a5,sstatus
    80004948:	ffd7f793          	andi	a5,a5,-3
    8000494c:	10079073          	csrw	sstatus,a5
    80004950:	ffffe097          	auipc	ra,0xffffe
    80004954:	708080e7          	jalr	1800(ra) # 80003058 <mycpu>
    80004958:	07852783          	lw	a5,120(a0)
    8000495c:	02078663          	beqz	a5,80004988 <push_off+0x5c>
    80004960:	ffffe097          	auipc	ra,0xffffe
    80004964:	6f8080e7          	jalr	1784(ra) # 80003058 <mycpu>
    80004968:	07852783          	lw	a5,120(a0)
    8000496c:	01813083          	ld	ra,24(sp)
    80004970:	01013403          	ld	s0,16(sp)
    80004974:	0017879b          	addiw	a5,a5,1
    80004978:	06f52c23          	sw	a5,120(a0)
    8000497c:	00813483          	ld	s1,8(sp)
    80004980:	02010113          	addi	sp,sp,32
    80004984:	00008067          	ret
    80004988:	0014d493          	srli	s1,s1,0x1
    8000498c:	ffffe097          	auipc	ra,0xffffe
    80004990:	6cc080e7          	jalr	1740(ra) # 80003058 <mycpu>
    80004994:	0014f493          	andi	s1,s1,1
    80004998:	06952e23          	sw	s1,124(a0)
    8000499c:	fc5ff06f          	j	80004960 <push_off+0x34>

00000000800049a0 <pop_off>:
    800049a0:	ff010113          	addi	sp,sp,-16
    800049a4:	00813023          	sd	s0,0(sp)
    800049a8:	00113423          	sd	ra,8(sp)
    800049ac:	01010413          	addi	s0,sp,16
    800049b0:	ffffe097          	auipc	ra,0xffffe
    800049b4:	6a8080e7          	jalr	1704(ra) # 80003058 <mycpu>
    800049b8:	100027f3          	csrr	a5,sstatus
    800049bc:	0027f793          	andi	a5,a5,2
    800049c0:	04079663          	bnez	a5,80004a0c <pop_off+0x6c>
    800049c4:	07852783          	lw	a5,120(a0)
    800049c8:	02f05a63          	blez	a5,800049fc <pop_off+0x5c>
    800049cc:	fff7871b          	addiw	a4,a5,-1
    800049d0:	06e52c23          	sw	a4,120(a0)
    800049d4:	00071c63          	bnez	a4,800049ec <pop_off+0x4c>
    800049d8:	07c52783          	lw	a5,124(a0)
    800049dc:	00078863          	beqz	a5,800049ec <pop_off+0x4c>
    800049e0:	100027f3          	csrr	a5,sstatus
    800049e4:	0027e793          	ori	a5,a5,2
    800049e8:	10079073          	csrw	sstatus,a5
    800049ec:	00813083          	ld	ra,8(sp)
    800049f0:	00013403          	ld	s0,0(sp)
    800049f4:	01010113          	addi	sp,sp,16
    800049f8:	00008067          	ret
    800049fc:	00001517          	auipc	a0,0x1
    80004a00:	8d450513          	addi	a0,a0,-1836 # 800052d0 <digits+0x48>
    80004a04:	fffff097          	auipc	ra,0xfffff
    80004a08:	018080e7          	jalr	24(ra) # 80003a1c <panic>
    80004a0c:	00001517          	auipc	a0,0x1
    80004a10:	8ac50513          	addi	a0,a0,-1876 # 800052b8 <digits+0x30>
    80004a14:	fffff097          	auipc	ra,0xfffff
    80004a18:	008080e7          	jalr	8(ra) # 80003a1c <panic>

0000000080004a1c <push_on>:
    80004a1c:	fe010113          	addi	sp,sp,-32
    80004a20:	00813823          	sd	s0,16(sp)
    80004a24:	00113c23          	sd	ra,24(sp)
    80004a28:	00913423          	sd	s1,8(sp)
    80004a2c:	02010413          	addi	s0,sp,32
    80004a30:	100024f3          	csrr	s1,sstatus
    80004a34:	100027f3          	csrr	a5,sstatus
    80004a38:	0027e793          	ori	a5,a5,2
    80004a3c:	10079073          	csrw	sstatus,a5
    80004a40:	ffffe097          	auipc	ra,0xffffe
    80004a44:	618080e7          	jalr	1560(ra) # 80003058 <mycpu>
    80004a48:	07852783          	lw	a5,120(a0)
    80004a4c:	02078663          	beqz	a5,80004a78 <push_on+0x5c>
    80004a50:	ffffe097          	auipc	ra,0xffffe
    80004a54:	608080e7          	jalr	1544(ra) # 80003058 <mycpu>
    80004a58:	07852783          	lw	a5,120(a0)
    80004a5c:	01813083          	ld	ra,24(sp)
    80004a60:	01013403          	ld	s0,16(sp)
    80004a64:	0017879b          	addiw	a5,a5,1
    80004a68:	06f52c23          	sw	a5,120(a0)
    80004a6c:	00813483          	ld	s1,8(sp)
    80004a70:	02010113          	addi	sp,sp,32
    80004a74:	00008067          	ret
    80004a78:	0014d493          	srli	s1,s1,0x1
    80004a7c:	ffffe097          	auipc	ra,0xffffe
    80004a80:	5dc080e7          	jalr	1500(ra) # 80003058 <mycpu>
    80004a84:	0014f493          	andi	s1,s1,1
    80004a88:	06952e23          	sw	s1,124(a0)
    80004a8c:	fc5ff06f          	j	80004a50 <push_on+0x34>

0000000080004a90 <pop_on>:
    80004a90:	ff010113          	addi	sp,sp,-16
    80004a94:	00813023          	sd	s0,0(sp)
    80004a98:	00113423          	sd	ra,8(sp)
    80004a9c:	01010413          	addi	s0,sp,16
    80004aa0:	ffffe097          	auipc	ra,0xffffe
    80004aa4:	5b8080e7          	jalr	1464(ra) # 80003058 <mycpu>
    80004aa8:	100027f3          	csrr	a5,sstatus
    80004aac:	0027f793          	andi	a5,a5,2
    80004ab0:	04078463          	beqz	a5,80004af8 <pop_on+0x68>
    80004ab4:	07852783          	lw	a5,120(a0)
    80004ab8:	02f05863          	blez	a5,80004ae8 <pop_on+0x58>
    80004abc:	fff7879b          	addiw	a5,a5,-1
    80004ac0:	06f52c23          	sw	a5,120(a0)
    80004ac4:	07853783          	ld	a5,120(a0)
    80004ac8:	00079863          	bnez	a5,80004ad8 <pop_on+0x48>
    80004acc:	100027f3          	csrr	a5,sstatus
    80004ad0:	ffd7f793          	andi	a5,a5,-3
    80004ad4:	10079073          	csrw	sstatus,a5
    80004ad8:	00813083          	ld	ra,8(sp)
    80004adc:	00013403          	ld	s0,0(sp)
    80004ae0:	01010113          	addi	sp,sp,16
    80004ae4:	00008067          	ret
    80004ae8:	00001517          	auipc	a0,0x1
    80004aec:	81050513          	addi	a0,a0,-2032 # 800052f8 <digits+0x70>
    80004af0:	fffff097          	auipc	ra,0xfffff
    80004af4:	f2c080e7          	jalr	-212(ra) # 80003a1c <panic>
    80004af8:	00000517          	auipc	a0,0x0
    80004afc:	7e050513          	addi	a0,a0,2016 # 800052d8 <digits+0x50>
    80004b00:	fffff097          	auipc	ra,0xfffff
    80004b04:	f1c080e7          	jalr	-228(ra) # 80003a1c <panic>

0000000080004b08 <__memset>:
    80004b08:	ff010113          	addi	sp,sp,-16
    80004b0c:	00813423          	sd	s0,8(sp)
    80004b10:	01010413          	addi	s0,sp,16
    80004b14:	1a060e63          	beqz	a2,80004cd0 <__memset+0x1c8>
    80004b18:	40a007b3          	neg	a5,a0
    80004b1c:	0077f793          	andi	a5,a5,7
    80004b20:	00778693          	addi	a3,a5,7
    80004b24:	00b00813          	li	a6,11
    80004b28:	0ff5f593          	andi	a1,a1,255
    80004b2c:	fff6071b          	addiw	a4,a2,-1
    80004b30:	1b06e663          	bltu	a3,a6,80004cdc <__memset+0x1d4>
    80004b34:	1cd76463          	bltu	a4,a3,80004cfc <__memset+0x1f4>
    80004b38:	1a078e63          	beqz	a5,80004cf4 <__memset+0x1ec>
    80004b3c:	00b50023          	sb	a1,0(a0)
    80004b40:	00100713          	li	a4,1
    80004b44:	1ae78463          	beq	a5,a4,80004cec <__memset+0x1e4>
    80004b48:	00b500a3          	sb	a1,1(a0)
    80004b4c:	00200713          	li	a4,2
    80004b50:	1ae78a63          	beq	a5,a4,80004d04 <__memset+0x1fc>
    80004b54:	00b50123          	sb	a1,2(a0)
    80004b58:	00300713          	li	a4,3
    80004b5c:	18e78463          	beq	a5,a4,80004ce4 <__memset+0x1dc>
    80004b60:	00b501a3          	sb	a1,3(a0)
    80004b64:	00400713          	li	a4,4
    80004b68:	1ae78263          	beq	a5,a4,80004d0c <__memset+0x204>
    80004b6c:	00b50223          	sb	a1,4(a0)
    80004b70:	00500713          	li	a4,5
    80004b74:	1ae78063          	beq	a5,a4,80004d14 <__memset+0x20c>
    80004b78:	00b502a3          	sb	a1,5(a0)
    80004b7c:	00700713          	li	a4,7
    80004b80:	18e79e63          	bne	a5,a4,80004d1c <__memset+0x214>
    80004b84:	00b50323          	sb	a1,6(a0)
    80004b88:	00700e93          	li	t4,7
    80004b8c:	00859713          	slli	a4,a1,0x8
    80004b90:	00e5e733          	or	a4,a1,a4
    80004b94:	01059e13          	slli	t3,a1,0x10
    80004b98:	01c76e33          	or	t3,a4,t3
    80004b9c:	01859313          	slli	t1,a1,0x18
    80004ba0:	006e6333          	or	t1,t3,t1
    80004ba4:	02059893          	slli	a7,a1,0x20
    80004ba8:	40f60e3b          	subw	t3,a2,a5
    80004bac:	011368b3          	or	a7,t1,a7
    80004bb0:	02859813          	slli	a6,a1,0x28
    80004bb4:	0108e833          	or	a6,a7,a6
    80004bb8:	03059693          	slli	a3,a1,0x30
    80004bbc:	003e589b          	srliw	a7,t3,0x3
    80004bc0:	00d866b3          	or	a3,a6,a3
    80004bc4:	03859713          	slli	a4,a1,0x38
    80004bc8:	00389813          	slli	a6,a7,0x3
    80004bcc:	00f507b3          	add	a5,a0,a5
    80004bd0:	00e6e733          	or	a4,a3,a4
    80004bd4:	000e089b          	sext.w	a7,t3
    80004bd8:	00f806b3          	add	a3,a6,a5
    80004bdc:	00e7b023          	sd	a4,0(a5)
    80004be0:	00878793          	addi	a5,a5,8
    80004be4:	fed79ce3          	bne	a5,a3,80004bdc <__memset+0xd4>
    80004be8:	ff8e7793          	andi	a5,t3,-8
    80004bec:	0007871b          	sext.w	a4,a5
    80004bf0:	01d787bb          	addw	a5,a5,t4
    80004bf4:	0ce88e63          	beq	a7,a4,80004cd0 <__memset+0x1c8>
    80004bf8:	00f50733          	add	a4,a0,a5
    80004bfc:	00b70023          	sb	a1,0(a4)
    80004c00:	0017871b          	addiw	a4,a5,1
    80004c04:	0cc77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c08:	00e50733          	add	a4,a0,a4
    80004c0c:	00b70023          	sb	a1,0(a4)
    80004c10:	0027871b          	addiw	a4,a5,2
    80004c14:	0ac77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c18:	00e50733          	add	a4,a0,a4
    80004c1c:	00b70023          	sb	a1,0(a4)
    80004c20:	0037871b          	addiw	a4,a5,3
    80004c24:	0ac77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c28:	00e50733          	add	a4,a0,a4
    80004c2c:	00b70023          	sb	a1,0(a4)
    80004c30:	0047871b          	addiw	a4,a5,4
    80004c34:	08c77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c38:	00e50733          	add	a4,a0,a4
    80004c3c:	00b70023          	sb	a1,0(a4)
    80004c40:	0057871b          	addiw	a4,a5,5
    80004c44:	08c77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c48:	00e50733          	add	a4,a0,a4
    80004c4c:	00b70023          	sb	a1,0(a4)
    80004c50:	0067871b          	addiw	a4,a5,6
    80004c54:	06c77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c58:	00e50733          	add	a4,a0,a4
    80004c5c:	00b70023          	sb	a1,0(a4)
    80004c60:	0077871b          	addiw	a4,a5,7
    80004c64:	06c77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c68:	00e50733          	add	a4,a0,a4
    80004c6c:	00b70023          	sb	a1,0(a4)
    80004c70:	0087871b          	addiw	a4,a5,8
    80004c74:	04c77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c78:	00e50733          	add	a4,a0,a4
    80004c7c:	00b70023          	sb	a1,0(a4)
    80004c80:	0097871b          	addiw	a4,a5,9
    80004c84:	04c77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c88:	00e50733          	add	a4,a0,a4
    80004c8c:	00b70023          	sb	a1,0(a4)
    80004c90:	00a7871b          	addiw	a4,a5,10
    80004c94:	02c77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004c98:	00e50733          	add	a4,a0,a4
    80004c9c:	00b70023          	sb	a1,0(a4)
    80004ca0:	00b7871b          	addiw	a4,a5,11
    80004ca4:	02c77663          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004ca8:	00e50733          	add	a4,a0,a4
    80004cac:	00b70023          	sb	a1,0(a4)
    80004cb0:	00c7871b          	addiw	a4,a5,12
    80004cb4:	00c77e63          	bgeu	a4,a2,80004cd0 <__memset+0x1c8>
    80004cb8:	00e50733          	add	a4,a0,a4
    80004cbc:	00b70023          	sb	a1,0(a4)
    80004cc0:	00d7879b          	addiw	a5,a5,13
    80004cc4:	00c7f663          	bgeu	a5,a2,80004cd0 <__memset+0x1c8>
    80004cc8:	00f507b3          	add	a5,a0,a5
    80004ccc:	00b78023          	sb	a1,0(a5)
    80004cd0:	00813403          	ld	s0,8(sp)
    80004cd4:	01010113          	addi	sp,sp,16
    80004cd8:	00008067          	ret
    80004cdc:	00b00693          	li	a3,11
    80004ce0:	e55ff06f          	j	80004b34 <__memset+0x2c>
    80004ce4:	00300e93          	li	t4,3
    80004ce8:	ea5ff06f          	j	80004b8c <__memset+0x84>
    80004cec:	00100e93          	li	t4,1
    80004cf0:	e9dff06f          	j	80004b8c <__memset+0x84>
    80004cf4:	00000e93          	li	t4,0
    80004cf8:	e95ff06f          	j	80004b8c <__memset+0x84>
    80004cfc:	00000793          	li	a5,0
    80004d00:	ef9ff06f          	j	80004bf8 <__memset+0xf0>
    80004d04:	00200e93          	li	t4,2
    80004d08:	e85ff06f          	j	80004b8c <__memset+0x84>
    80004d0c:	00400e93          	li	t4,4
    80004d10:	e7dff06f          	j	80004b8c <__memset+0x84>
    80004d14:	00500e93          	li	t4,5
    80004d18:	e75ff06f          	j	80004b8c <__memset+0x84>
    80004d1c:	00600e93          	li	t4,6
    80004d20:	e6dff06f          	j	80004b8c <__memset+0x84>

0000000080004d24 <__memmove>:
    80004d24:	ff010113          	addi	sp,sp,-16
    80004d28:	00813423          	sd	s0,8(sp)
    80004d2c:	01010413          	addi	s0,sp,16
    80004d30:	0e060863          	beqz	a2,80004e20 <__memmove+0xfc>
    80004d34:	fff6069b          	addiw	a3,a2,-1
    80004d38:	0006881b          	sext.w	a6,a3
    80004d3c:	0ea5e863          	bltu	a1,a0,80004e2c <__memmove+0x108>
    80004d40:	00758713          	addi	a4,a1,7
    80004d44:	00a5e7b3          	or	a5,a1,a0
    80004d48:	40a70733          	sub	a4,a4,a0
    80004d4c:	0077f793          	andi	a5,a5,7
    80004d50:	00f73713          	sltiu	a4,a4,15
    80004d54:	00174713          	xori	a4,a4,1
    80004d58:	0017b793          	seqz	a5,a5
    80004d5c:	00e7f7b3          	and	a5,a5,a4
    80004d60:	10078863          	beqz	a5,80004e70 <__memmove+0x14c>
    80004d64:	00900793          	li	a5,9
    80004d68:	1107f463          	bgeu	a5,a6,80004e70 <__memmove+0x14c>
    80004d6c:	0036581b          	srliw	a6,a2,0x3
    80004d70:	fff8081b          	addiw	a6,a6,-1
    80004d74:	02081813          	slli	a6,a6,0x20
    80004d78:	01d85893          	srli	a7,a6,0x1d
    80004d7c:	00858813          	addi	a6,a1,8
    80004d80:	00058793          	mv	a5,a1
    80004d84:	00050713          	mv	a4,a0
    80004d88:	01088833          	add	a6,a7,a6
    80004d8c:	0007b883          	ld	a7,0(a5)
    80004d90:	00878793          	addi	a5,a5,8
    80004d94:	00870713          	addi	a4,a4,8
    80004d98:	ff173c23          	sd	a7,-8(a4)
    80004d9c:	ff0798e3          	bne	a5,a6,80004d8c <__memmove+0x68>
    80004da0:	ff867713          	andi	a4,a2,-8
    80004da4:	02071793          	slli	a5,a4,0x20
    80004da8:	0207d793          	srli	a5,a5,0x20
    80004dac:	00f585b3          	add	a1,a1,a5
    80004db0:	40e686bb          	subw	a3,a3,a4
    80004db4:	00f507b3          	add	a5,a0,a5
    80004db8:	06e60463          	beq	a2,a4,80004e20 <__memmove+0xfc>
    80004dbc:	0005c703          	lbu	a4,0(a1)
    80004dc0:	00e78023          	sb	a4,0(a5)
    80004dc4:	04068e63          	beqz	a3,80004e20 <__memmove+0xfc>
    80004dc8:	0015c603          	lbu	a2,1(a1)
    80004dcc:	00100713          	li	a4,1
    80004dd0:	00c780a3          	sb	a2,1(a5)
    80004dd4:	04e68663          	beq	a3,a4,80004e20 <__memmove+0xfc>
    80004dd8:	0025c603          	lbu	a2,2(a1)
    80004ddc:	00200713          	li	a4,2
    80004de0:	00c78123          	sb	a2,2(a5)
    80004de4:	02e68e63          	beq	a3,a4,80004e20 <__memmove+0xfc>
    80004de8:	0035c603          	lbu	a2,3(a1)
    80004dec:	00300713          	li	a4,3
    80004df0:	00c781a3          	sb	a2,3(a5)
    80004df4:	02e68663          	beq	a3,a4,80004e20 <__memmove+0xfc>
    80004df8:	0045c603          	lbu	a2,4(a1)
    80004dfc:	00400713          	li	a4,4
    80004e00:	00c78223          	sb	a2,4(a5)
    80004e04:	00e68e63          	beq	a3,a4,80004e20 <__memmove+0xfc>
    80004e08:	0055c603          	lbu	a2,5(a1)
    80004e0c:	00500713          	li	a4,5
    80004e10:	00c782a3          	sb	a2,5(a5)
    80004e14:	00e68663          	beq	a3,a4,80004e20 <__memmove+0xfc>
    80004e18:	0065c703          	lbu	a4,6(a1)
    80004e1c:	00e78323          	sb	a4,6(a5)
    80004e20:	00813403          	ld	s0,8(sp)
    80004e24:	01010113          	addi	sp,sp,16
    80004e28:	00008067          	ret
    80004e2c:	02061713          	slli	a4,a2,0x20
    80004e30:	02075713          	srli	a4,a4,0x20
    80004e34:	00e587b3          	add	a5,a1,a4
    80004e38:	f0f574e3          	bgeu	a0,a5,80004d40 <__memmove+0x1c>
    80004e3c:	02069613          	slli	a2,a3,0x20
    80004e40:	02065613          	srli	a2,a2,0x20
    80004e44:	fff64613          	not	a2,a2
    80004e48:	00e50733          	add	a4,a0,a4
    80004e4c:	00c78633          	add	a2,a5,a2
    80004e50:	fff7c683          	lbu	a3,-1(a5)
    80004e54:	fff78793          	addi	a5,a5,-1
    80004e58:	fff70713          	addi	a4,a4,-1
    80004e5c:	00d70023          	sb	a3,0(a4)
    80004e60:	fec798e3          	bne	a5,a2,80004e50 <__memmove+0x12c>
    80004e64:	00813403          	ld	s0,8(sp)
    80004e68:	01010113          	addi	sp,sp,16
    80004e6c:	00008067          	ret
    80004e70:	02069713          	slli	a4,a3,0x20
    80004e74:	02075713          	srli	a4,a4,0x20
    80004e78:	00170713          	addi	a4,a4,1
    80004e7c:	00e50733          	add	a4,a0,a4
    80004e80:	00050793          	mv	a5,a0
    80004e84:	0005c683          	lbu	a3,0(a1)
    80004e88:	00178793          	addi	a5,a5,1
    80004e8c:	00158593          	addi	a1,a1,1
    80004e90:	fed78fa3          	sb	a3,-1(a5)
    80004e94:	fee798e3          	bne	a5,a4,80004e84 <__memmove+0x160>
    80004e98:	f89ff06f          	j	80004e20 <__memmove+0xfc>
	...
