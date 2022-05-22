
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	97013103          	ld	sp,-1680(sp) # 80005970 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	30c020ef          	jal	ra,80002328 <start>

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
    8000100c:	7b0000ef          	jal	ra,800017bc <_ZN3PCB10getContextEv>
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

    addi sp, sp, -8
    8000109c:	ff810113          	addi	sp,sp,-8
    sd a0, 0 * 8(sp) // cuvamo na sistemskom steku pokazivac na PCB
    800010a0:	00a13023          	sd	a0,0(sp)

    call interruptHandler
    800010a4:	240000ef          	jal	ra,800012e4 <interruptHandler>

    ld a1, 0 * 8(sp) // pokazivac na PCB
    800010a8:	00013583          	ld	a1,0(sp)
    addi sp, sp, 8
    800010ac:	00810113          	addi	sp,sp,8

    // vracamo stare vrednosti registara x1..x31
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 1,2,3,4,5,6,7,8,9,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 // a0 ne cuvamo jer nam treba povratna vrednost, a1 jer cemo ga rucno skinuti
    ld x\index, \index * 8(a1)
    .endr
    800010b0:	0085b083          	ld	ra,8(a1)
    800010b4:	0105b103          	ld	sp,16(a1)
    800010b8:	0185b183          	ld	gp,24(a1)
    800010bc:	0205b203          	ld	tp,32(a1)
    800010c0:	0285b283          	ld	t0,40(a1)
    800010c4:	0305b303          	ld	t1,48(a1)
    800010c8:	0385b383          	ld	t2,56(a1)
    800010cc:	0405b403          	ld	s0,64(a1)
    800010d0:	0485b483          	ld	s1,72(a1)
    800010d4:	0605b603          	ld	a2,96(a1)
    800010d8:	0685b683          	ld	a3,104(a1)
    800010dc:	0705b703          	ld	a4,112(a1)
    800010e0:	0785b783          	ld	a5,120(a1)
    800010e4:	0805b803          	ld	a6,128(a1)
    800010e8:	0885b883          	ld	a7,136(a1)
    800010ec:	0905b903          	ld	s2,144(a1)
    800010f0:	0985b983          	ld	s3,152(a1)
    800010f4:	0a05ba03          	ld	s4,160(a1)
    800010f8:	0a85ba83          	ld	s5,168(a1)
    800010fc:	0b05bb03          	ld	s6,176(a1)
    80001100:	0b85bb83          	ld	s7,184(a1)
    80001104:	0c05bc03          	ld	s8,192(a1)
    80001108:	0c85bc83          	ld	s9,200(a1)
    8000110c:	0d05bd03          	ld	s10,208(a1)
    80001110:	0d85bd83          	ld	s11,216(a1)
    80001114:	0e05be03          	ld	t3,224(a1)
    80001118:	0e85be83          	ld	t4,232(a1)
    8000111c:	0f05bf03          	ld	t5,240(a1)
    80001120:	0f85bf83          	ld	t6,248(a1)

    ld a1, 11 * 8(a1)
    80001124:	0585b583          	ld	a1,88(a1)

    80001128:	10200073          	sret

000000008000112c <_ZN3PCB14switchContext1EPmS0_>:
.global _ZN3PCB14switchContext1EPmS0_ // switchContext kada se prvi put poziva, skidamo korisnicki stek
_ZN3PCB14switchContext1EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    8000112c:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    80001130:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    80001134:	1005b083          	ld	ra,256(a1)
    ld sp, 2 * 8(a1)
    80001138:	0105b103          	ld	sp,16(a1)

    ret
    8000113c:	00008067          	ret

0000000080001140 <_ZN3PCB14switchContext2EPmS0_>:

.global _ZN3PCB14switchContext2EPmS0_ // switchContext kada se ne poziva prvi put, skidamo sistemski stek
_ZN3PCB14switchContext2EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    80001140:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    80001144:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    80001148:	1005b083          	ld	ra,256(a1)
    ld sp, 0 * 8(a1)
    8000114c:	0005b103          	ld	sp,0(a1)

    80001150:	00008067          	ret

0000000080001154 <_Z13callInterruptv>:
#include "../h/kernel.h"
#include "../h/PCB.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001154:	ff010113          	addi	sp,sp,-16
    80001158:	00813423          	sd	s0,8(sp)
    8000115c:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("ecall");
    80001160:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001164:	00050513          	mv	a0,a0
    return res;
}
    80001168:	00813403          	ld	s0,8(sp)
    8000116c:	01010113          	addi	sp,sp,16
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
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    80001198:	00100793          	li	a5,1
    8000119c:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    800011a0:	00000097          	auipc	ra,0x0
    800011a4:	fb4080e7          	jalr	-76(ra) # 80001154 <_Z13callInterruptv>
}
    800011a8:	00813083          	ld	ra,8(sp)
    800011ac:	00013403          	ld	s0,0(sp)
    800011b0:	01010113          	addi	sp,sp,16
    800011b4:	00008067          	ret

00000000800011b8 <_Z8mem_freePv>:

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    800011b8:	ff010113          	addi	sp,sp,-16
    800011bc:	00113423          	sd	ra,8(sp)
    800011c0:	00813023          	sd	s0,0(sp)
    800011c4:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    800011c8:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800011cc:	00200793          	li	a5,2
    800011d0:	00078513          	mv	a0,a5

    return (size_t)(callInterrupt());
    800011d4:	00000097          	auipc	ra,0x0
    800011d8:	f80080e7          	jalr	-128(ra) # 80001154 <_Z13callInterruptv>
}
    800011dc:	0005051b          	sext.w	a0,a0
    800011e0:	00813083          	ld	ra,8(sp)
    800011e4:	00013403          	ld	s0,0(sp)
    800011e8:	01010113          	addi	sp,sp,16
    800011ec:	00008067          	ret

00000000800011f0 <_Z13thread_createPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800011f0:	ff010113          	addi	sp,sp,-16
    800011f4:	00113423          	sd	ra,8(sp)
    800011f8:	00813023          	sd	s0,0(sp)
    800011fc:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    80001200:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    80001204:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
    80001208:	00050713          	mv	a4,a0

    size_t* stack = new size_t[DEFAULT_STACK_SIZE]; // pravimo stack procesa
    8000120c:	00008537          	lui	a0,0x8
    80001210:	00001097          	auipc	ra,0x1
    80001214:	bd8080e7          	jalr	-1064(ra) # 80001de8 <_Znam>
    if(stack == nullptr) return -1;
    80001218:	02050c63          	beqz	a0,80001250 <_Z13thread_createPP3PCBPFvPvES2_+0x60>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    8000121c:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001220:	00050713          	mv	a4,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001224:	01100793          	li	a5,17
    80001228:	00078513          	mv	a0,a5

    handle = (thread_t*)(callInterrupt()); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    8000122c:	00000097          	auipc	ra,0x0
    80001230:	f28080e7          	jalr	-216(ra) # 80001154 <_Z13callInterruptv>
    if(*handle == nullptr) {
    80001234:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    80001238:	02078063          	beqz	a5,80001258 <_Z13thread_createPP3PCBPFvPvES2_+0x68>
        return -1;
    }
    return 0;
    8000123c:	00000513          	li	a0,0
}
    80001240:	00813083          	ld	ra,8(sp)
    80001244:	00013403          	ld	s0,0(sp)
    80001248:	01010113          	addi	sp,sp,16
    8000124c:	00008067          	ret
    if(stack == nullptr) return -1;
    80001250:	fff00513          	li	a0,-1
    80001254:	fedff06f          	j	80001240 <_Z13thread_createPP3PCBPFvPvES2_+0x50>
        return -1;
    80001258:	fff00513          	li	a0,-1
    8000125c:	fe5ff06f          	j	80001240 <_Z13thread_createPP3PCBPFvPvES2_+0x50>

0000000080001260 <_Z15thread_dispatchv>:

void thread_dispatch () {
    80001260:	ff010113          	addi	sp,sp,-16
    80001264:	00113423          	sd	ra,8(sp)
    80001268:	00813023          	sd	s0,0(sp)
    8000126c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001270:	01300793          	li	a5,19
    80001274:	00078513          	mv	a0,a5
    callInterrupt();
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	edc080e7          	jalr	-292(ra) # 80001154 <_Z13callInterruptv>
}
    80001280:	00813083          	ld	ra,8(sp)
    80001284:	00013403          	ld	s0,0(sp)
    80001288:	01010113          	addi	sp,sp,16
    8000128c:	00008067          	ret

0000000080001290 <_Z11thread_exitv>:

int thread_exit () {
    80001290:	ff010113          	addi	sp,sp,-16
    80001294:	00113423          	sd	ra,8(sp)
    80001298:	00813023          	sd	s0,0(sp)
    8000129c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_exit;
    asm volatile("mv a0, %0" : : "r" (code));
    800012a0:	01200793          	li	a5,18
    800012a4:	00078513          	mv	a0,a5
    return (size_t)(callInterrupt());
    800012a8:	00000097          	auipc	ra,0x0
    800012ac:	eac080e7          	jalr	-340(ra) # 80001154 <_Z13callInterruptv>
}
    800012b0:	0005051b          	sext.w	a0,a0
    800012b4:	00813083          	ld	ra,8(sp)
    800012b8:	00013403          	ld	s0,0(sp)
    800012bc:	01010113          	addi	sp,sp,16
    800012c0:	00008067          	ret

00000000800012c4 <_ZN6Kernel10popSppSpieEv>:
#include "../h/PCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"

void Kernel::popSppSpie() {
    800012c4:	ff010113          	addi	sp,sp,-16
    800012c8:	00813423          	sd	s0,8(sp)
    800012cc:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    800012d0:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    800012d4:	10200073          	sret
}
    800012d8:	00813403          	ld	s0,8(sp)
    800012dc:	01010113          	addi	sp,sp,16
    800012e0:	00008067          	ret

00000000800012e4 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    800012e4:	fb010113          	addi	sp,sp,-80
    800012e8:	04113423          	sd	ra,72(sp)
    800012ec:	04813023          	sd	s0,64(sp)
    800012f0:	02913c23          	sd	s1,56(sp)
    800012f4:	05010413          	addi	s0,sp,80
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800012f8:	142027f3          	csrr	a5,scause
    800012fc:	fcf43023          	sd	a5,-64(s0)
        return scause;
    80001300:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    80001304:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001308:	141027f3          	csrr	a5,sepc
    8000130c:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    80001310:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    80001314:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001318:	100027f3          	csrr	a5,sstatus
    8000131c:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    80001320:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    80001324:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    80001328:	fd843703          	ld	a4,-40(s0)
    8000132c:	00900793          	li	a5,9
    80001330:	04f70263          	beq	a4,a5,80001374 <interruptHandler+0x90>
    80001334:	fd843703          	ld	a4,-40(s0)
    80001338:	00800793          	li	a5,8
    8000133c:	02f70c63          	beq	a4,a5,80001374 <interruptHandler+0x90>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    80001340:	fd843703          	ld	a4,-40(s0)
    80001344:	fff00793          	li	a5,-1
    80001348:	03f79793          	slli	a5,a5,0x3f
    8000134c:	00178793          	addi	a5,a5,1
    80001350:	14f70063          	beq	a4,a5,80001490 <interruptHandler+0x1ac>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    80001354:	fd843703          	ld	a4,-40(s0)
    80001358:	fff00793          	li	a5,-1
    8000135c:	03f79793          	slli	a5,a5,0x3f
    80001360:	00978793          	addi	a5,a5,9
    80001364:	18f70463          	beq	a4,a5,800014ec <interruptHandler+0x208>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    80001368:	00001097          	auipc	ra,0x1
    8000136c:	f34080e7          	jalr	-204(ra) # 8000229c <_Z10printErrorv>
    80001370:	0680006f          	j	800013d8 <interruptHandler+0xf4>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001374:	fd043783          	ld	a5,-48(s0)
    80001378:	00478793          	addi	a5,a5,4
    8000137c:	fcf43823          	sd	a5,-48(s0)
        size_t code = PCB::running->registers[10]; // a0
    80001380:	00004797          	auipc	a5,0x4
    80001384:	5f87b783          	ld	a5,1528(a5) # 80005978 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001388:	0007b683          	ld	a3,0(a5)
    8000138c:	0186b703          	ld	a4,24(a3)
    80001390:	05073783          	ld	a5,80(a4)
        switch(code) {
    80001394:	01300613          	li	a2,19
    80001398:	0ef66663          	bltu	a2,a5,80001484 <interruptHandler+0x1a0>
    8000139c:	00279793          	slli	a5,a5,0x2
    800013a0:	00004617          	auipc	a2,0x4
    800013a4:	c8060613          	addi	a2,a2,-896 # 80005020 <CONSOLE_STATUS+0x10>
    800013a8:	00c787b3          	add	a5,a5,a2
    800013ac:	0007a783          	lw	a5,0(a5)
    800013b0:	00c787b3          	add	a5,a5,a2
    800013b4:	00078067          	jr	a5
                size_t size = PCB::running->registers[11];
    800013b8:	05873503          	ld	a0,88(a4)
                MemoryAllocator::mem_alloc(size);
    800013bc:	00651513          	slli	a0,a0,0x6
    800013c0:	00001097          	auipc	ra,0x1
    800013c4:	aa0080e7          	jalr	-1376(ra) # 80001e60 <_ZN15MemoryAllocator9mem_allocEm>
        Kernel::w_sepc(sepc);
    800013c8:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800013cc:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    800013d0:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800013d4:	10079073          	csrw	sstatus,a5
    }

}
    800013d8:	04813083          	ld	ra,72(sp)
    800013dc:	04013403          	ld	s0,64(sp)
    800013e0:	03813483          	ld	s1,56(sp)
    800013e4:	05010113          	addi	sp,sp,80
    800013e8:	00008067          	ret
                MemoryAllocator::mem_free(memSegment);
    800013ec:	05873503          	ld	a0,88(a4)
    800013f0:	00001097          	auipc	ra,0x1
    800013f4:	bd4080e7          	jalr	-1068(ra) # 80001fc4 <_ZN15MemoryAllocator8mem_freeEPv>
                break;
    800013f8:	fd1ff06f          	j	800013c8 <interruptHandler+0xe4>
                PCB::dispatch();
    800013fc:	00000097          	auipc	ra,0x0
    80001400:	180080e7          	jalr	384(ra) # 8000157c <_ZN3PCB8dispatchEv>
                PCB::timeSliceCounter = 0;
    80001404:	00004797          	auipc	a5,0x4
    80001408:	5647b783          	ld	a5,1380(a5) # 80005968 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000140c:	0007b023          	sd	zero,0(a5)
                break;
    80001410:	fb9ff06f          	j	800013c8 <interruptHandler+0xe4>
                PCB::running->finished=true;
    80001414:	00100793          	li	a5,1
    80001418:	02f68423          	sb	a5,40(a3)
                PCB::dispatch();
    8000141c:	00000097          	auipc	ra,0x0
    80001420:	160080e7          	jalr	352(ra) # 8000157c <_ZN3PCB8dispatchEv>
                PCB::timeSliceCounter = 0;
    80001424:	00004797          	auipc	a5,0x4
    80001428:	5447b783          	ld	a5,1348(a5) # 80005968 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000142c:	0007b023          	sd	zero,0(a5)
                asm volatile("mv a0, x0"); // a0 = 0
    80001430:	00000513          	li	a0,0
                break;
    80001434:	f95ff06f          	j	800013c8 <interruptHandler+0xe4>
                PCB **handle = (PCB**)PCB::running->registers[11];
    80001438:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    8000143c:	06873583          	ld	a1,104(a4)
    80001440:	06073503          	ld	a0,96(a4)
    80001444:	00000097          	auipc	ra,0x0
    80001448:	2f0080e7          	jalr	752(ra) # 80001734 <_ZN3PCB14createProccessEPFvvEPv>
    8000144c:	00a4b023          	sd	a0,0(s1)
                size_t* stack = (size_t*)PCB::running->registers[14];
    80001450:	00004797          	auipc	a5,0x4
    80001454:	5287b783          	ld	a5,1320(a5) # 80005978 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001458:	0007b783          	ld	a5,0(a5)
    8000145c:	0187b783          	ld	a5,24(a5)
    80001460:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    80001464:	00f53423          	sd	a5,8(a0)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    80001468:	00008737          	lui	a4,0x8
    8000146c:	00e787b3          	add	a5,a5,a4
    80001470:	0004b703          	ld	a4,0(s1)
    80001474:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    80001478:	00f73823          	sd	a5,16(a4)
                asm volatile("mv a0, %0" : : "r" (handle));
    8000147c:	00048513          	mv	a0,s1
                break;
    80001480:	f49ff06f          	j	800013c8 <interruptHandler+0xe4>
                printError();
    80001484:	00001097          	auipc	ra,0x1
    80001488:	e18080e7          	jalr	-488(ra) # 8000229c <_Z10printErrorv>
                break;
    8000148c:	f3dff06f          	j	800013c8 <interruptHandler+0xe4>
        PCB::timeSliceCounter++;
    80001490:	00004717          	auipc	a4,0x4
    80001494:	4d873703          	ld	a4,1240(a4) # 80005968 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001498:	00073783          	ld	a5,0(a4)
    8000149c:	00178793          	addi	a5,a5,1
    800014a0:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    800014a4:	00004717          	auipc	a4,0x4
    800014a8:	4d473703          	ld	a4,1236(a4) # 80005978 <_GLOBAL_OFFSET_TABLE_+0x20>
    800014ac:	00073703          	ld	a4,0(a4)
    800014b0:	03873703          	ld	a4,56(a4)
    800014b4:	00e7f863          	bgeu	a5,a4,800014c4 <interruptHandler+0x1e0>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800014b8:	00200793          	li	a5,2
    800014bc:	1447b073          	csrc	sip,a5
    }
    800014c0:	f19ff06f          	j	800013d8 <interruptHandler+0xf4>
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    800014c4:	00000097          	auipc	ra,0x0
    800014c8:	0b8080e7          	jalr	184(ra) # 8000157c <_ZN3PCB8dispatchEv>
            PCB::timeSliceCounter = 0;
    800014cc:	00004797          	auipc	a5,0x4
    800014d0:	49c7b783          	ld	a5,1180(a5) # 80005968 <_GLOBAL_OFFSET_TABLE_+0x10>
    800014d4:	0007b023          	sd	zero,0(a5)
            Kernel::w_sepc(sepc);
    800014d8:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800014dc:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    800014e0:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800014e4:	10079073          	csrw	sstatus,a5
    }
    800014e8:	fd1ff06f          	j	800014b8 <interruptHandler+0x1d4>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    800014ec:	00003097          	auipc	ra,0x3
    800014f0:	f74080e7          	jalr	-140(ra) # 80004460 <console_handler>
    800014f4:	ee5ff06f          	j	800013d8 <interruptHandler+0xf4>

00000000800014f8 <_ZN3PCB5yieldEv>:

PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
}

void PCB::yield() {
    800014f8:	ff010113          	addi	sp,sp,-16
    800014fc:	00813423          	sd	s0,8(sp)
    80001500:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code));
    80001504:	01300793          	li	a5,19
    80001508:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    8000150c:	00000073          	ecall
}
    80001510:	00813403          	ld	s0,8(sp)
    80001514:	01010113          	addi	sp,sp,16
    80001518:	00008067          	ret

000000008000151c <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    8000151c:	fe010113          	addi	sp,sp,-32
    80001520:	00113c23          	sd	ra,24(sp)
    80001524:	00813823          	sd	s0,16(sp)
    80001528:	00913423          	sd	s1,8(sp)
    8000152c:	02010413          	addi	s0,sp,32
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    80001530:	00000097          	auipc	ra,0x0
    80001534:	d94080e7          	jalr	-620(ra) # 800012c4 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    80001538:	00004497          	auipc	s1,0x4
    8000153c:	49848493          	addi	s1,s1,1176 # 800059d0 <_ZN3PCB7runningE>
    80001540:	0004b783          	ld	a5,0(s1)
    80001544:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    80001548:	00070513          	mv	a0,a4
    running->main();
    8000154c:	0207b783          	ld	a5,32(a5)
    80001550:	000780e7          	jalr	a5
    running->setFinished(true);
    80001554:	0004b783          	ld	a5,0(s1)
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    }
    void setFinished(bool finished_) {
        finished = finished_;
    80001558:	00100713          	li	a4,1
    8000155c:	02e78423          	sb	a4,40(a5)
    PCB::yield(); // nit je gotova pa predajemo procesor drugom precesu
    80001560:	00000097          	auipc	ra,0x0
    80001564:	f98080e7          	jalr	-104(ra) # 800014f8 <_ZN3PCB5yieldEv>
}
    80001568:	01813083          	ld	ra,24(sp)
    8000156c:	01013403          	ld	s0,16(sp)
    80001570:	00813483          	ld	s1,8(sp)
    80001574:	02010113          	addi	sp,sp,32
    80001578:	00008067          	ret

000000008000157c <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    8000157c:	fe010113          	addi	sp,sp,-32
    80001580:	00113c23          	sd	ra,24(sp)
    80001584:	00813823          	sd	s0,16(sp)
    80001588:	00913423          	sd	s1,8(sp)
    8000158c:	02010413          	addi	s0,sp,32
    PCB* old = running;
    80001590:	00004497          	auipc	s1,0x4
    80001594:	4404b483          	ld	s1,1088(s1) # 800059d0 <_ZN3PCB7runningE>
        return finished;
    80001598:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()) {
    8000159c:	04078263          	beqz	a5,800015e0 <_ZN3PCB8dispatchEv+0x64>
    running = Scheduler::get();
    800015a0:	00000097          	auipc	ra,0x0
    800015a4:	294080e7          	jalr	660(ra) # 80001834 <_ZN9Scheduler3getEv>
    800015a8:	00004797          	auipc	a5,0x4
    800015ac:	42a7b423          	sd	a0,1064(a5) # 800059d0 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    800015b0:	04054783          	lbu	a5,64(a0)
    800015b4:	02078e63          	beqz	a5,800015f0 <_ZN3PCB8dispatchEv+0x74>
        PCB::running->firstCall = false;
    800015b8:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    800015bc:	01853583          	ld	a1,24(a0)
    800015c0:	0184b503          	ld	a0,24(s1)
    800015c4:	00000097          	auipc	ra,0x0
    800015c8:	b68080e7          	jalr	-1176(ra) # 8000112c <_ZN3PCB14switchContext1EPmS0_>
}
    800015cc:	01813083          	ld	ra,24(sp)
    800015d0:	01013403          	ld	s0,16(sp)
    800015d4:	00813483          	ld	s1,8(sp)
    800015d8:	02010113          	addi	sp,sp,32
    800015dc:	00008067          	ret
        Scheduler::put(old);
    800015e0:	00048513          	mv	a0,s1
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	1fc080e7          	jalr	508(ra) # 800017e0 <_ZN9Scheduler3putEP3PCB>
    800015ec:	fb5ff06f          	j	800015a0 <_ZN3PCB8dispatchEv+0x24>
        switchContext2(old->registers, running->registers);
    800015f0:	01853583          	ld	a1,24(a0)
    800015f4:	0184b503          	ld	a0,24(s1)
    800015f8:	00000097          	auipc	ra,0x0
    800015fc:	b48080e7          	jalr	-1208(ra) # 80001140 <_ZN3PCB14switchContext2EPmS0_>
}
    80001600:	fcdff06f          	j	800015cc <_ZN3PCB8dispatchEv+0x50>

0000000080001604 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001604:	fe010113          	addi	sp,sp,-32
    80001608:	00113c23          	sd	ra,24(sp)
    8000160c:	00813823          	sd	s0,16(sp)
    80001610:	00913423          	sd	s1,8(sp)
    80001614:	02010413          	addi	s0,sp,32
    80001618:	00050493          	mv	s1,a0
    8000161c:	00053023          	sd	zero,0(a0)
    80001620:	00053c23          	sd	zero,24(a0)
    80001624:	00100793          	li	a5,1
    80001628:	04f50023          	sb	a5,64(a0)
    finished = false;
    8000162c:	02050423          	sb	zero,40(a0)
    main = main_;
    80001630:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    80001634:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    80001638:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    8000163c:	10800513          	li	a0,264
    80001640:	00001097          	auipc	ra,0x1
    80001644:	820080e7          	jalr	-2016(ra) # 80001e60 <_ZN15MemoryAllocator9mem_allocEm>
    80001648:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    8000164c:	00008537          	lui	a0,0x8
    80001650:	00001097          	auipc	ra,0x1
    80001654:	810080e7          	jalr	-2032(ra) # 80001e60 <_ZN15MemoryAllocator9mem_allocEm>
    80001658:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    8000165c:	000087b7          	lui	a5,0x8
    80001660:	00f50533          	add	a0,a0,a5
    80001664:	0184b783          	ld	a5,24(s1)
    80001668:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    8000166c:	0184b783          	ld	a5,24(s1)
    80001670:	00000717          	auipc	a4,0x0
    80001674:	eac70713          	addi	a4,a4,-340 # 8000151c <_ZN3PCB15proccessWrapperEv>
    80001678:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    8000167c:	0004b423          	sd	zero,8(s1)
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    80001680:	0204b783          	ld	a5,32(s1)
    80001684:	02078263          	beqz	a5,800016a8 <_ZN3PCBC1EPFvvEmPv+0xa4>
    80001688:	00048513          	mv	a0,s1
    8000168c:	00000097          	auipc	ra,0x0
    80001690:	154080e7          	jalr	340(ra) # 800017e0 <_ZN9Scheduler3putEP3PCB>
}
    80001694:	01813083          	ld	ra,24(sp)
    80001698:	01013403          	ld	s0,16(sp)
    8000169c:	00813483          	ld	s1,8(sp)
    800016a0:	02010113          	addi	sp,sp,32
    800016a4:	00008067          	ret
    else firstCall = false; // jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    800016a8:	04048023          	sb	zero,64(s1)
}
    800016ac:	fe9ff06f          	j	80001694 <_ZN3PCBC1EPFvvEmPv+0x90>

00000000800016b0 <_ZN3PCBD1Ev>:
    delete[] stack;
    800016b0:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    800016b4:	02050663          	beqz	a0,800016e0 <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    800016b8:	ff010113          	addi	sp,sp,-16
    800016bc:	00113423          	sd	ra,8(sp)
    800016c0:	00813023          	sd	s0,0(sp)
    800016c4:	01010413          	addi	s0,sp,16
    delete[] stack;
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	770080e7          	jalr	1904(ra) # 80001e38 <_ZdaPv>
}
    800016d0:	00813083          	ld	ra,8(sp)
    800016d4:	00013403          	ld	s0,0(sp)
    800016d8:	01010113          	addi	sp,sp,16
    800016dc:	00008067          	ret
    800016e0:	00008067          	ret

00000000800016e4 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    800016e4:	ff010113          	addi	sp,sp,-16
    800016e8:	00113423          	sd	ra,8(sp)
    800016ec:	00813023          	sd	s0,0(sp)
    800016f0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	76c080e7          	jalr	1900(ra) # 80001e60 <_ZN15MemoryAllocator9mem_allocEm>
}
    800016fc:	00813083          	ld	ra,8(sp)
    80001700:	00013403          	ld	s0,0(sp)
    80001704:	01010113          	addi	sp,sp,16
    80001708:	00008067          	ret

000000008000170c <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    8000170c:	ff010113          	addi	sp,sp,-16
    80001710:	00113423          	sd	ra,8(sp)
    80001714:	00813023          	sd	s0,0(sp)
    80001718:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    8000171c:	00001097          	auipc	ra,0x1
    80001720:	8a8080e7          	jalr	-1880(ra) # 80001fc4 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001724:	00813083          	ld	ra,8(sp)
    80001728:	00013403          	ld	s0,0(sp)
    8000172c:	01010113          	addi	sp,sp,16
    80001730:	00008067          	ret

0000000080001734 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    80001734:	fd010113          	addi	sp,sp,-48
    80001738:	02113423          	sd	ra,40(sp)
    8000173c:	02813023          	sd	s0,32(sp)
    80001740:	00913c23          	sd	s1,24(sp)
    80001744:	01213823          	sd	s2,16(sp)
    80001748:	01313423          	sd	s3,8(sp)
    8000174c:	03010413          	addi	s0,sp,48
    80001750:	00050913          	mv	s2,a0
    80001754:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    80001758:	04800513          	li	a0,72
    8000175c:	00000097          	auipc	ra,0x0
    80001760:	f88080e7          	jalr	-120(ra) # 800016e4 <_ZN3PCBnwEm>
    80001764:	00050493          	mv	s1,a0
    80001768:	00098693          	mv	a3,s3
    8000176c:	00200613          	li	a2,2
    80001770:	00090593          	mv	a1,s2
    80001774:	00000097          	auipc	ra,0x0
    80001778:	e90080e7          	jalr	-368(ra) # 80001604 <_ZN3PCBC1EPFvvEmPv>
    8000177c:	0200006f          	j	8000179c <_ZN3PCB14createProccessEPFvvEPv+0x68>
    80001780:	00050913          	mv	s2,a0
    80001784:	00048513          	mv	a0,s1
    80001788:	00000097          	auipc	ra,0x0
    8000178c:	f84080e7          	jalr	-124(ra) # 8000170c <_ZN3PCBdlEPv>
    80001790:	00090513          	mv	a0,s2
    80001794:	00005097          	auipc	ra,0x5
    80001798:	334080e7          	jalr	820(ra) # 80006ac8 <_Unwind_Resume>
}
    8000179c:	00048513          	mv	a0,s1
    800017a0:	02813083          	ld	ra,40(sp)
    800017a4:	02013403          	ld	s0,32(sp)
    800017a8:	01813483          	ld	s1,24(sp)
    800017ac:	01013903          	ld	s2,16(sp)
    800017b0:	00813983          	ld	s3,8(sp)
    800017b4:	03010113          	addi	sp,sp,48
    800017b8:	00008067          	ret

00000000800017bc <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    800017bc:	ff010113          	addi	sp,sp,-16
    800017c0:	00813423          	sd	s0,8(sp)
    800017c4:	01010413          	addi	s0,sp,16
    return running->registers;
}
    800017c8:	00004797          	auipc	a5,0x4
    800017cc:	2087b783          	ld	a5,520(a5) # 800059d0 <_ZN3PCB7runningE>
    800017d0:	0187b503          	ld	a0,24(a5)
    800017d4:	00813403          	ld	s0,8(sp)
    800017d8:	01010113          	addi	sp,sp,16
    800017dc:	00008067          	ret

00000000800017e0 <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    800017e0:	ff010113          	addi	sp,sp,-16
    800017e4:	00813423          	sd	s0,8(sp)
    800017e8:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    800017ec:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    800017f0:	00004797          	auipc	a5,0x4
    800017f4:	1f07b783          	ld	a5,496(a5) # 800059e0 <_ZN9Scheduler4tailE>
    800017f8:	02078463          	beqz	a5,80001820 <_ZN9Scheduler3putEP3PCB+0x40>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    800017fc:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextReady;
    80001800:	00004797          	auipc	a5,0x4
    80001804:	1e078793          	addi	a5,a5,480 # 800059e0 <_ZN9Scheduler4tailE>
    80001808:	0007b703          	ld	a4,0(a5)
    8000180c:	00073703          	ld	a4,0(a4)
    80001810:	00e7b023          	sd	a4,0(a5)
    }
}
    80001814:	00813403          	ld	s0,8(sp)
    80001818:	01010113          	addi	sp,sp,16
    8000181c:	00008067          	ret
        head = tail = process;
    80001820:	00004797          	auipc	a5,0x4
    80001824:	1c078793          	addi	a5,a5,448 # 800059e0 <_ZN9Scheduler4tailE>
    80001828:	00a7b023          	sd	a0,0(a5)
    8000182c:	00a7b423          	sd	a0,8(a5)
    80001830:	fe5ff06f          	j	80001814 <_ZN9Scheduler3putEP3PCB+0x34>

0000000080001834 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    80001834:	ff010113          	addi	sp,sp,-16
    80001838:	00813423          	sd	s0,8(sp)
    8000183c:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    80001840:	00004517          	auipc	a0,0x4
    80001844:	1a853503          	ld	a0,424(a0) # 800059e8 <_ZN9Scheduler4headE>
    80001848:	02050463          	beqz	a0,80001870 <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    8000184c:	00053703          	ld	a4,0(a0)
    80001850:	00004797          	auipc	a5,0x4
    80001854:	19078793          	addi	a5,a5,400 # 800059e0 <_ZN9Scheduler4tailE>
    80001858:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    8000185c:	0007b783          	ld	a5,0(a5)
    80001860:	00f50e63          	beq	a0,a5,8000187c <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    80001864:	00813403          	ld	s0,8(sp)
    80001868:	01010113          	addi	sp,sp,16
    8000186c:	00008067          	ret
        return idleProcess;
    80001870:	00004517          	auipc	a0,0x4
    80001874:	18053503          	ld	a0,384(a0) # 800059f0 <_ZN9Scheduler11idleProcessE>
    80001878:	fedff06f          	j	80001864 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    8000187c:	00004797          	auipc	a5,0x4
    80001880:	16e7b223          	sd	a4,356(a5) # 800059e0 <_ZN9Scheduler4tailE>
    80001884:	fe1ff06f          	j	80001864 <_ZN9Scheduler3getEv+0x30>

0000000080001888 <_Z11workerBodyAv>:
#include "../h/PCB.h"
#include "../h/kernel.h"


void workerBodyA()
{
    80001888:	fe010113          	addi	sp,sp,-32
    8000188c:	00113c23          	sd	ra,24(sp)
    80001890:	00813823          	sd	s0,16(sp)
    80001894:	00913423          	sd	s1,8(sp)
    80001898:	02010413          	addi	s0,sp,32
    for (size_t i = 0; i < 10; i++)
    8000189c:	00000493          	li	s1,0
    800018a0:	03c0006f          	j	800018dc <_Z11workerBodyAv+0x54>
    {
        if(i==5)thread_exit();
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	9ec080e7          	jalr	-1556(ra) # 80001290 <_Z11thread_exitv>
    800018ac:	0400006f          	j	800018ec <_Z11workerBodyAv+0x64>
        printString("A: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
    800018b0:	00168693          	addi	a3,a3,1
    800018b4:	000027b7          	lui	a5,0x2
    800018b8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800018bc:	00d7ee63          	bltu	a5,a3,800018d8 <_Z11workerBodyAv+0x50>
        {
            for (size_t k = 0; k < 30000; k++)
    800018c0:	00000713          	li	a4,0
    800018c4:	000077b7          	lui	a5,0x7
    800018c8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800018cc:	fee7e2e3          	bltu	a5,a4,800018b0 <_Z11workerBodyAv+0x28>
    800018d0:	00170713          	addi	a4,a4,1
    800018d4:	ff1ff06f          	j	800018c4 <_Z11workerBodyAv+0x3c>
    for (size_t i = 0; i < 10; i++)
    800018d8:	00148493          	addi	s1,s1,1
    800018dc:	00900793          	li	a5,9
    800018e0:	0497e063          	bltu	a5,s1,80001920 <_Z11workerBodyAv+0x98>
        if(i==5)thread_exit();
    800018e4:	00500793          	li	a5,5
    800018e8:	faf48ee3          	beq	s1,a5,800018a4 <_Z11workerBodyAv+0x1c>
        printString("A: i=");
    800018ec:	00003517          	auipc	a0,0x3
    800018f0:	78450513          	addi	a0,a0,1924 # 80005070 <CONSOLE_STATUS+0x60>
    800018f4:	00001097          	auipc	ra,0x1
    800018f8:	87c080e7          	jalr	-1924(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    800018fc:	00048513          	mv	a0,s1
    80001900:	00001097          	auipc	ra,0x1
    80001904:	8e0080e7          	jalr	-1824(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    80001908:	00003517          	auipc	a0,0x3
    8000190c:	78850513          	addi	a0,a0,1928 # 80005090 <CONSOLE_STATUS+0x80>
    80001910:	00001097          	auipc	ra,0x1
    80001914:	860080e7          	jalr	-1952(ra) # 80002170 <_Z11printStringPKc>
        for (size_t j = 0; j < 10000; j++)
    80001918:	00000693          	li	a3,0
    8000191c:	f99ff06f          	j	800018b4 <_Z11workerBodyAv+0x2c>
                // busy wait
            }
//            TCB::yield();
        }
    }
}
    80001920:	01813083          	ld	ra,24(sp)
    80001924:	01013403          	ld	s0,16(sp)
    80001928:	00813483          	ld	s1,8(sp)
    8000192c:	02010113          	addi	sp,sp,32
    80001930:	00008067          	ret

0000000080001934 <_Z11workerBodyBv>:

void workerBodyB()
{
    80001934:	fe010113          	addi	sp,sp,-32
    80001938:	00113c23          	sd	ra,24(sp)
    8000193c:	00813823          	sd	s0,16(sp)
    80001940:	00913423          	sd	s1,8(sp)
    80001944:	02010413          	addi	s0,sp,32
    for (size_t i = 0; i < 16; i++)
    80001948:	00000493          	li	s1,0
    8000194c:	0300006f          	j	8000197c <_Z11workerBodyBv+0x48>
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
    80001950:	00168693          	addi	a3,a3,1
    80001954:	000027b7          	lui	a5,0x2
    80001958:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000195c:	00d7ee63          	bltu	a5,a3,80001978 <_Z11workerBodyBv+0x44>
        {
            for (size_t k = 0; k < 30000; k++)
    80001960:	00000713          	li	a4,0
    80001964:	000077b7          	lui	a5,0x7
    80001968:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000196c:	fee7e2e3          	bltu	a5,a4,80001950 <_Z11workerBodyBv+0x1c>
    80001970:	00170713          	addi	a4,a4,1
    80001974:	ff1ff06f          	j	80001964 <_Z11workerBodyBv+0x30>
    for (size_t i = 0; i < 16; i++)
    80001978:	00148493          	addi	s1,s1,1
    8000197c:	00f00793          	li	a5,15
    80001980:	0297ec63          	bltu	a5,s1,800019b8 <_Z11workerBodyBv+0x84>
        printString("B: i=");
    80001984:	00003517          	auipc	a0,0x3
    80001988:	6f450513          	addi	a0,a0,1780 # 80005078 <CONSOLE_STATUS+0x68>
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	7e4080e7          	jalr	2020(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    80001994:	00048513          	mv	a0,s1
    80001998:	00001097          	auipc	ra,0x1
    8000199c:	848080e7          	jalr	-1976(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    800019a0:	00003517          	auipc	a0,0x3
    800019a4:	6f050513          	addi	a0,a0,1776 # 80005090 <CONSOLE_STATUS+0x80>
    800019a8:	00000097          	auipc	ra,0x0
    800019ac:	7c8080e7          	jalr	1992(ra) # 80002170 <_Z11printStringPKc>
        for (size_t j = 0; j < 10000; j++)
    800019b0:	00000693          	li	a3,0
    800019b4:	fa1ff06f          	j	80001954 <_Z11workerBodyBv+0x20>
            {
                // busy wait
            }
        }
    }
}
    800019b8:	01813083          	ld	ra,24(sp)
    800019bc:	01013403          	ld	s0,16(sp)
    800019c0:	00813483          	ld	s1,8(sp)
    800019c4:	02010113          	addi	sp,sp,32
    800019c8:	00008067          	ret

00000000800019cc <_ZL9fibonaccim>:

static size_t fibonacci(size_t n)
{
    800019cc:	fe010113          	addi	sp,sp,-32
    800019d0:	00113c23          	sd	ra,24(sp)
    800019d4:	00813823          	sd	s0,16(sp)
    800019d8:	00913423          	sd	s1,8(sp)
    800019dc:	01213023          	sd	s2,0(sp)
    800019e0:	02010413          	addi	s0,sp,32
    800019e4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800019e8:	00100793          	li	a5,1
    800019ec:	02a7f863          	bgeu	a5,a0,80001a1c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { PCB::yield(); }
    800019f0:	00a00793          	li	a5,10
    800019f4:	02f577b3          	remu	a5,a0,a5
    800019f8:	02078e63          	beqz	a5,80001a34 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800019fc:	fff48513          	addi	a0,s1,-1
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	fcc080e7          	jalr	-52(ra) # 800019cc <_ZL9fibonaccim>
    80001a08:	00050913          	mv	s2,a0
    80001a0c:	ffe48513          	addi	a0,s1,-2
    80001a10:	00000097          	auipc	ra,0x0
    80001a14:	fbc080e7          	jalr	-68(ra) # 800019cc <_ZL9fibonaccim>
    80001a18:	00a90533          	add	a0,s2,a0
}
    80001a1c:	01813083          	ld	ra,24(sp)
    80001a20:	01013403          	ld	s0,16(sp)
    80001a24:	00813483          	ld	s1,8(sp)
    80001a28:	00013903          	ld	s2,0(sp)
    80001a2c:	02010113          	addi	sp,sp,32
    80001a30:	00008067          	ret
    if (n % 10 == 0) { PCB::yield(); }
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	ac4080e7          	jalr	-1340(ra) # 800014f8 <_ZN3PCB5yieldEv>
    80001a3c:	fc1ff06f          	j	800019fc <_ZL9fibonaccim+0x30>

0000000080001a40 <_Z11workerBodyCv>:

void workerBodyC()
{
    80001a40:	fe010113          	addi	sp,sp,-32
    80001a44:	00113c23          	sd	ra,24(sp)
    80001a48:	00813823          	sd	s0,16(sp)
    80001a4c:	00913423          	sd	s1,8(sp)
    80001a50:	01213023          	sd	s2,0(sp)
    80001a54:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001a58:	00000493          	li	s1,0
    80001a5c:	0380006f          	j	80001a94 <_Z11workerBodyCv+0x54>
    for (; i < 3; i++)
    {
        printString("C: i=");
    80001a60:	00003517          	auipc	a0,0x3
    80001a64:	62050513          	addi	a0,a0,1568 # 80005080 <CONSOLE_STATUS+0x70>
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	708080e7          	jalr	1800(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    80001a70:	00048513          	mv	a0,s1
    80001a74:	00000097          	auipc	ra,0x0
    80001a78:	76c080e7          	jalr	1900(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    80001a7c:	00003517          	auipc	a0,0x3
    80001a80:	61450513          	addi	a0,a0,1556 # 80005090 <CONSOLE_STATUS+0x80>
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	6ec080e7          	jalr	1772(ra) # 80002170 <_Z11printStringPKc>
    for (; i < 3; i++)
    80001a8c:	0014849b          	addiw	s1,s1,1
    80001a90:	0ff4f493          	andi	s1,s1,255
    80001a94:	00200793          	li	a5,2
    80001a98:	fc97f4e3          	bgeu	a5,s1,80001a60 <_Z11workerBodyCv+0x20>
    }

    printString("C: yield\n");
    80001a9c:	00003517          	auipc	a0,0x3
    80001aa0:	5ec50513          	addi	a0,a0,1516 # 80005088 <CONSOLE_STATUS+0x78>
    80001aa4:	00000097          	auipc	ra,0x0
    80001aa8:	6cc080e7          	jalr	1740(ra) # 80002170 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001aac:	00700313          	li	t1,7
    PCB::yield();
    80001ab0:	00000097          	auipc	ra,0x0
    80001ab4:	a48080e7          	jalr	-1464(ra) # 800014f8 <_ZN3PCB5yieldEv>

    size_t t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001ab8:	00030913          	mv	s2,t1

    printString("C: t1=");
    80001abc:	00003517          	auipc	a0,0x3
    80001ac0:	5dc50513          	addi	a0,a0,1500 # 80005098 <CONSOLE_STATUS+0x88>
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	6ac080e7          	jalr	1708(ra) # 80002170 <_Z11printStringPKc>
    printInteger(t1);
    80001acc:	00090513          	mv	a0,s2
    80001ad0:	00000097          	auipc	ra,0x0
    80001ad4:	710080e7          	jalr	1808(ra) # 800021e0 <_Z12printIntegerm>
    printString("\n");
    80001ad8:	00003517          	auipc	a0,0x3
    80001adc:	5b850513          	addi	a0,a0,1464 # 80005090 <CONSOLE_STATUS+0x80>
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	690080e7          	jalr	1680(ra) # 80002170 <_Z11printStringPKc>

    size_t result = fibonacci(12);
    80001ae8:	00c00513          	li	a0,12
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	ee0080e7          	jalr	-288(ra) # 800019cc <_ZL9fibonaccim>
    80001af4:	00050913          	mv	s2,a0
    printString("C: fibonaci=");
    80001af8:	00003517          	auipc	a0,0x3
    80001afc:	5a850513          	addi	a0,a0,1448 # 800050a0 <CONSOLE_STATUS+0x90>
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	670080e7          	jalr	1648(ra) # 80002170 <_Z11printStringPKc>
    printInteger(result);
    80001b08:	00090513          	mv	a0,s2
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	6d4080e7          	jalr	1748(ra) # 800021e0 <_Z12printIntegerm>
    printString("\n");
    80001b14:	00003517          	auipc	a0,0x3
    80001b18:	57c50513          	addi	a0,a0,1404 # 80005090 <CONSOLE_STATUS+0x80>
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	654080e7          	jalr	1620(ra) # 80002170 <_Z11printStringPKc>
    80001b24:	0380006f          	j	80001b5c <_Z11workerBodyCv+0x11c>

    for (; i < 6; i++)
    {
        printString("C: i=");
    80001b28:	00003517          	auipc	a0,0x3
    80001b2c:	55850513          	addi	a0,a0,1368 # 80005080 <CONSOLE_STATUS+0x70>
    80001b30:	00000097          	auipc	ra,0x0
    80001b34:	640080e7          	jalr	1600(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    80001b38:	00048513          	mv	a0,s1
    80001b3c:	00000097          	auipc	ra,0x0
    80001b40:	6a4080e7          	jalr	1700(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    80001b44:	00003517          	auipc	a0,0x3
    80001b48:	54c50513          	addi	a0,a0,1356 # 80005090 <CONSOLE_STATUS+0x80>
    80001b4c:	00000097          	auipc	ra,0x0
    80001b50:	624080e7          	jalr	1572(ra) # 80002170 <_Z11printStringPKc>
    for (; i < 6; i++)
    80001b54:	0014849b          	addiw	s1,s1,1
    80001b58:	0ff4f493          	andi	s1,s1,255
    80001b5c:	00500793          	li	a5,5
    80001b60:	fc97f4e3          	bgeu	a5,s1,80001b28 <_Z11workerBodyCv+0xe8>
    }
//    TCB::yield();
}
    80001b64:	01813083          	ld	ra,24(sp)
    80001b68:	01013403          	ld	s0,16(sp)
    80001b6c:	00813483          	ld	s1,8(sp)
    80001b70:	00013903          	ld	s2,0(sp)
    80001b74:	02010113          	addi	sp,sp,32
    80001b78:	00008067          	ret

0000000080001b7c <_Z11workerBodyDv>:

void workerBodyD()
{
    80001b7c:	fe010113          	addi	sp,sp,-32
    80001b80:	00113c23          	sd	ra,24(sp)
    80001b84:	00813823          	sd	s0,16(sp)
    80001b88:	00913423          	sd	s1,8(sp)
    80001b8c:	01213023          	sd	s2,0(sp)
    80001b90:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001b94:	00a00493          	li	s1,10
    80001b98:	0380006f          	j	80001bd0 <_Z11workerBodyDv+0x54>
    for (; i < 13; i++)
    {
        printString("D: i=");
    80001b9c:	00003517          	auipc	a0,0x3
    80001ba0:	51450513          	addi	a0,a0,1300 # 800050b0 <CONSOLE_STATUS+0xa0>
    80001ba4:	00000097          	auipc	ra,0x0
    80001ba8:	5cc080e7          	jalr	1484(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    80001bac:	00048513          	mv	a0,s1
    80001bb0:	00000097          	auipc	ra,0x0
    80001bb4:	630080e7          	jalr	1584(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    80001bb8:	00003517          	auipc	a0,0x3
    80001bbc:	4d850513          	addi	a0,a0,1240 # 80005090 <CONSOLE_STATUS+0x80>
    80001bc0:	00000097          	auipc	ra,0x0
    80001bc4:	5b0080e7          	jalr	1456(ra) # 80002170 <_Z11printStringPKc>
    for (; i < 13; i++)
    80001bc8:	0014849b          	addiw	s1,s1,1
    80001bcc:	0ff4f493          	andi	s1,s1,255
    80001bd0:	00c00793          	li	a5,12
    80001bd4:	fc97f4e3          	bgeu	a5,s1,80001b9c <_Z11workerBodyDv+0x20>
    }

    printString("D: yield\n");
    80001bd8:	00003517          	auipc	a0,0x3
    80001bdc:	4e050513          	addi	a0,a0,1248 # 800050b8 <CONSOLE_STATUS+0xa8>
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	590080e7          	jalr	1424(ra) # 80002170 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001be8:	00500313          	li	t1,5
    thread_dispatch();
    80001bec:	fffff097          	auipc	ra,0xfffff
    80001bf0:	674080e7          	jalr	1652(ra) # 80001260 <_Z15thread_dispatchv>

    size_t result = fibonacci(16);
    80001bf4:	01000513          	li	a0,16
    80001bf8:	00000097          	auipc	ra,0x0
    80001bfc:	dd4080e7          	jalr	-556(ra) # 800019cc <_ZL9fibonaccim>
    80001c00:	00050913          	mv	s2,a0
    printString("D: fibonaci=");
    80001c04:	00003517          	auipc	a0,0x3
    80001c08:	4c450513          	addi	a0,a0,1220 # 800050c8 <CONSOLE_STATUS+0xb8>
    80001c0c:	00000097          	auipc	ra,0x0
    80001c10:	564080e7          	jalr	1380(ra) # 80002170 <_Z11printStringPKc>
    printInteger(result);
    80001c14:	00090513          	mv	a0,s2
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	5c8080e7          	jalr	1480(ra) # 800021e0 <_Z12printIntegerm>
    printString("\n");
    80001c20:	00003517          	auipc	a0,0x3
    80001c24:	47050513          	addi	a0,a0,1136 # 80005090 <CONSOLE_STATUS+0x80>
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	548080e7          	jalr	1352(ra) # 80002170 <_Z11printStringPKc>
    80001c30:	0380006f          	j	80001c68 <_Z11workerBodyDv+0xec>

    for (; i < 16; i++)
    {
        printString("D: i=");
    80001c34:	00003517          	auipc	a0,0x3
    80001c38:	47c50513          	addi	a0,a0,1148 # 800050b0 <CONSOLE_STATUS+0xa0>
    80001c3c:	00000097          	auipc	ra,0x0
    80001c40:	534080e7          	jalr	1332(ra) # 80002170 <_Z11printStringPKc>
        printInteger(i);
    80001c44:	00048513          	mv	a0,s1
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	598080e7          	jalr	1432(ra) # 800021e0 <_Z12printIntegerm>
        printString("\n");
    80001c50:	00003517          	auipc	a0,0x3
    80001c54:	44050513          	addi	a0,a0,1088 # 80005090 <CONSOLE_STATUS+0x80>
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	518080e7          	jalr	1304(ra) # 80002170 <_Z11printStringPKc>
    for (; i < 16; i++)
    80001c60:	0014849b          	addiw	s1,s1,1
    80001c64:	0ff4f493          	andi	s1,s1,255
    80001c68:	00f00793          	li	a5,15
    80001c6c:	fc97f4e3          	bgeu	a5,s1,80001c34 <_Z11workerBodyDv+0xb8>
    }
//    TCB::yield();
}
    80001c70:	01813083          	ld	ra,24(sp)
    80001c74:	01013403          	ld	s0,16(sp)
    80001c78:	00813483          	ld	s1,8(sp)
    80001c7c:	00013903          	ld	s2,0(sp)
    80001c80:	02010113          	addi	sp,sp,32
    80001c84:	00008067          	ret

0000000080001c88 <main>:

extern "C" void interrupt();
int main() {
    80001c88:	fc010113          	addi	sp,sp,-64
    80001c8c:	02113c23          	sd	ra,56(sp)
    80001c90:	02813823          	sd	s0,48(sp)
    80001c94:	02913423          	sd	s1,40(sp)
    80001c98:	03213023          	sd	s2,32(sp)
    80001c9c:	04010413          	addi	s0,sp,64
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001ca0:	00004797          	auipc	a5,0x4
    80001ca4:	ce87b783          	ld	a5,-792(a5) # 80005988 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001ca8:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001cac:	00000593          	li	a1,0
    80001cb0:	00000513          	li	a0,0
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	a80080e7          	jalr	-1408(ra) # 80001734 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001cbc:	00004797          	auipc	a5,0x4
    80001cc0:	cbc7b783          	ld	a5,-836(a5) # 80005978 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001cc4:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001cc8:	00200793          	li	a5,2
    80001ccc:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    PCB* procesi[4];
    using pf = void(*)(void*);
    thread_create(&procesi[0], (pf)workerBodyA, nullptr);
    80001cd0:	00000613          	li	a2,0
    80001cd4:	00000597          	auipc	a1,0x0
    80001cd8:	bb458593          	addi	a1,a1,-1100 # 80001888 <_Z11workerBodyAv>
    80001cdc:	fc040513          	addi	a0,s0,-64
    80001ce0:	fffff097          	auipc	ra,0xfffff
    80001ce4:	510080e7          	jalr	1296(ra) # 800011f0 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[1], (pf)workerBodyB, nullptr);
    80001ce8:	00000613          	li	a2,0
    80001cec:	00000597          	auipc	a1,0x0
    80001cf0:	c4858593          	addi	a1,a1,-952 # 80001934 <_Z11workerBodyBv>
    80001cf4:	fc840513          	addi	a0,s0,-56
    80001cf8:	fffff097          	auipc	ra,0xfffff
    80001cfc:	4f8080e7          	jalr	1272(ra) # 800011f0 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[2], (pf)workerBodyC, nullptr);
    80001d00:	00000613          	li	a2,0
    80001d04:	00000597          	auipc	a1,0x0
    80001d08:	d3c58593          	addi	a1,a1,-708 # 80001a40 <_Z11workerBodyCv>
    80001d0c:	fd040513          	addi	a0,s0,-48
    80001d10:	fffff097          	auipc	ra,0xfffff
    80001d14:	4e0080e7          	jalr	1248(ra) # 800011f0 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[3], (pf)workerBodyD, nullptr);
    80001d18:	00000613          	li	a2,0
    80001d1c:	00000597          	auipc	a1,0x0
    80001d20:	e6058593          	addi	a1,a1,-416 # 80001b7c <_Z11workerBodyDv>
    80001d24:	fd840513          	addi	a0,s0,-40
    80001d28:	fffff097          	auipc	ra,0xfffff
    80001d2c:	4c8080e7          	jalr	1224(ra) # 800011f0 <_Z13thread_createPP3PCBPFvPvES2_>
    80001d30:	00c0006f          	j	80001d3c <main+0xb4>


    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        thread_dispatch();
    80001d34:	fffff097          	auipc	ra,0xfffff
    80001d38:	52c080e7          	jalr	1324(ra) # 80001260 <_Z15thread_dispatchv>
    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
    80001d3c:	fc043783          	ld	a5,-64(s0)
    80001d40:	0287c783          	lbu	a5,40(a5)
    80001d44:	fe0788e3          	beqz	a5,80001d34 <main+0xac>
    80001d48:	fc843783          	ld	a5,-56(s0)
    80001d4c:	0287c783          	lbu	a5,40(a5)
    80001d50:	fe0782e3          	beqz	a5,80001d34 <main+0xac>
    80001d54:	fd043783          	ld	a5,-48(s0)
    80001d58:	0287c783          	lbu	a5,40(a5)
    80001d5c:	fc078ce3          	beqz	a5,80001d34 <main+0xac>
    80001d60:	fd843783          	ld	a5,-40(s0)
    80001d64:	0287c783          	lbu	a5,40(a5)
    80001d68:	fc0786e3          	beqz	a5,80001d34 <main+0xac>
    80001d6c:	fc040493          	addi	s1,s0,-64
    80001d70:	0080006f          	j	80001d78 <main+0xf0>
    }

    for(auto& proces : procesi) {
    80001d74:	00848493          	addi	s1,s1,8
    80001d78:	fe040793          	addi	a5,s0,-32
    80001d7c:	02f48463          	beq	s1,a5,80001da4 <main+0x11c>
        delete proces;
    80001d80:	0004b903          	ld	s2,0(s1)
    80001d84:	fe0908e3          	beqz	s2,80001d74 <main+0xec>
    80001d88:	00090513          	mv	a0,s2
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	924080e7          	jalr	-1756(ra) # 800016b0 <_ZN3PCBD1Ev>
    80001d94:	00090513          	mv	a0,s2
    80001d98:	00000097          	auipc	ra,0x0
    80001d9c:	974080e7          	jalr	-1676(ra) # 8000170c <_ZN3PCBdlEPv>
    80001da0:	fd5ff06f          	j	80001d74 <main+0xec>
    }

    return 0;
}
    80001da4:	00000513          	li	a0,0
    80001da8:	03813083          	ld	ra,56(sp)
    80001dac:	03013403          	ld	s0,48(sp)
    80001db0:	02813483          	ld	s1,40(sp)
    80001db4:	02013903          	ld	s2,32(sp)
    80001db8:	04010113          	addi	sp,sp,64
    80001dbc:	00008067          	ret

0000000080001dc0 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001dc0:	ff010113          	addi	sp,sp,-16
    80001dc4:	00113423          	sd	ra,8(sp)
    80001dc8:	00813023          	sd	s0,0(sp)
    80001dcc:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	3a4080e7          	jalr	932(ra) # 80001174 <_Z9mem_allocm>
}
    80001dd8:	00813083          	ld	ra,8(sp)
    80001ddc:	00013403          	ld	s0,0(sp)
    80001de0:	01010113          	addi	sp,sp,16
    80001de4:	00008067          	ret

0000000080001de8 <_Znam>:
void* operator new [](size_t size) {
    80001de8:	ff010113          	addi	sp,sp,-16
    80001dec:	00113423          	sd	ra,8(sp)
    80001df0:	00813023          	sd	s0,0(sp)
    80001df4:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001df8:	fffff097          	auipc	ra,0xfffff
    80001dfc:	37c080e7          	jalr	892(ra) # 80001174 <_Z9mem_allocm>
}
    80001e00:	00813083          	ld	ra,8(sp)
    80001e04:	00013403          	ld	s0,0(sp)
    80001e08:	01010113          	addi	sp,sp,16
    80001e0c:	00008067          	ret

0000000080001e10 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001e10:	ff010113          	addi	sp,sp,-16
    80001e14:	00113423          	sd	ra,8(sp)
    80001e18:	00813023          	sd	s0,0(sp)
    80001e1c:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001e20:	fffff097          	auipc	ra,0xfffff
    80001e24:	398080e7          	jalr	920(ra) # 800011b8 <_Z8mem_freePv>
}
    80001e28:	00813083          	ld	ra,8(sp)
    80001e2c:	00013403          	ld	s0,0(sp)
    80001e30:	01010113          	addi	sp,sp,16
    80001e34:	00008067          	ret

0000000080001e38 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001e38:	ff010113          	addi	sp,sp,-16
    80001e3c:	00113423          	sd	ra,8(sp)
    80001e40:	00813023          	sd	s0,0(sp)
    80001e44:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	370080e7          	jalr	880(ra) # 800011b8 <_Z8mem_freePv>
    80001e50:	00813083          	ld	ra,8(sp)
    80001e54:	00013403          	ld	s0,0(sp)
    80001e58:	01010113          	addi	sp,sp,16
    80001e5c:	00008067          	ret

0000000080001e60 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001e60:	ff010113          	addi	sp,sp,-16
    80001e64:	00813423          	sd	s0,8(sp)
    80001e68:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001e6c:	00004797          	auipc	a5,0x4
    80001e70:	b8c7b783          	ld	a5,-1140(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
    80001e74:	02078c63          	beqz	a5,80001eac <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001e78:	00004717          	auipc	a4,0x4
    80001e7c:	b0873703          	ld	a4,-1272(a4) # 80005980 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001e80:	00073703          	ld	a4,0(a4)
    80001e84:	12e78c63          	beq	a5,a4,80001fbc <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001e88:	00850713          	addi	a4,a0,8
    80001e8c:	00675813          	srli	a6,a4,0x6
    80001e90:	03f77793          	andi	a5,a4,63
    80001e94:	00f037b3          	snez	a5,a5
    80001e98:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001e9c:	00004517          	auipc	a0,0x4
    80001ea0:	b5c53503          	ld	a0,-1188(a0) # 800059f8 <_ZN15MemoryAllocator4headE>
    80001ea4:	00000613          	li	a2,0
    80001ea8:	0a80006f          	j	80001f50 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001eac:	00004697          	auipc	a3,0x4
    80001eb0:	ab46b683          	ld	a3,-1356(a3) # 80005960 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001eb4:	0006b783          	ld	a5,0(a3)
    80001eb8:	00004717          	auipc	a4,0x4
    80001ebc:	b4f73023          	sd	a5,-1216(a4) # 800059f8 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001ec0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80001ec4:	00004717          	auipc	a4,0x4
    80001ec8:	abc73703          	ld	a4,-1348(a4) # 80005980 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001ecc:	00073703          	ld	a4,0(a4)
    80001ed0:	0006b683          	ld	a3,0(a3)
    80001ed4:	40d70733          	sub	a4,a4,a3
    80001ed8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001edc:	0007b823          	sd	zero,16(a5)
    80001ee0:	fa9ff06f          	j	80001e88 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001ee4:	00060e63          	beqz	a2,80001f00 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001ee8:	01063703          	ld	a4,16(a2)
    80001eec:	04070a63          	beqz	a4,80001f40 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001ef0:	01073703          	ld	a4,16(a4)
    80001ef4:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80001ef8:	00078813          	mv	a6,a5
    80001efc:	0ac0006f          	j	80001fa8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001f00:	01053703          	ld	a4,16(a0)
    80001f04:	00070a63          	beqz	a4,80001f18 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001f08:	00004697          	auipc	a3,0x4
    80001f0c:	aee6b823          	sd	a4,-1296(a3) # 800059f8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001f10:	00078813          	mv	a6,a5
    80001f14:	0940006f          	j	80001fa8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001f18:	00004717          	auipc	a4,0x4
    80001f1c:	a6873703          	ld	a4,-1432(a4) # 80005980 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001f20:	00073703          	ld	a4,0(a4)
    80001f24:	00004697          	auipc	a3,0x4
    80001f28:	ace6ba23          	sd	a4,-1324(a3) # 800059f8 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001f2c:	00078813          	mv	a6,a5
    80001f30:	0780006f          	j	80001fa8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001f34:	00004797          	auipc	a5,0x4
    80001f38:	ace7b223          	sd	a4,-1340(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
    80001f3c:	06c0006f          	j	80001fa8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001f40:	00078813          	mv	a6,a5
    80001f44:	0640006f          	j	80001fa8 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001f48:	00050613          	mv	a2,a0
        curr = curr->next;
    80001f4c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001f50:	06050063          	beqz	a0,80001fb0 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80001f54:	00853783          	ld	a5,8(a0)
    80001f58:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80001f5c:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001f60:	fee7e4e3          	bltu	a5,a4,80001f48 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001f64:	ff06e2e3          	bltu	a3,a6,80001f48 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001f68:	f7068ee3          	beq	a3,a6,80001ee4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001f6c:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001f70:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80001f74:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001f78:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001f7c:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001f80:	01053783          	ld	a5,16(a0)
    80001f84:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001f88:	fa0606e3          	beqz	a2,80001f34 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001f8c:	01063783          	ld	a5,16(a2)
    80001f90:	00078663          	beqz	a5,80001f9c <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80001f94:	0107b783          	ld	a5,16(a5)
    80001f98:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80001f9c:	01063783          	ld	a5,16(a2)
    80001fa0:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001fa4:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001fa8:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001fac:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001fb0:	00813403          	ld	s0,8(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret
        return nullptr;
    80001fbc:	00000513          	li	a0,0
    80001fc0:	ff1ff06f          	j	80001fb0 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080001fc4 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001fc4:	ff010113          	addi	sp,sp,-16
    80001fc8:	00813423          	sd	s0,8(sp)
    80001fcc:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001fd0:	16050063          	beqz	a0,80002130 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001fd4:	ff850713          	addi	a4,a0,-8
    80001fd8:	00004797          	auipc	a5,0x4
    80001fdc:	9887b783          	ld	a5,-1656(a5) # 80005960 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001fe0:	0007b783          	ld	a5,0(a5)
    80001fe4:	14f76a63          	bltu	a4,a5,80002138 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001fe8:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001fec:	fff58693          	addi	a3,a1,-1
    80001ff0:	00d706b3          	add	a3,a4,a3
    80001ff4:	00004617          	auipc	a2,0x4
    80001ff8:	98c63603          	ld	a2,-1652(a2) # 80005980 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001ffc:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002000:	14c6f063          	bgeu	a3,a2,80002140 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80002004:	14070263          	beqz	a4,80002148 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80002008:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    8000200c:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80002010:	14079063          	bnez	a5,80002150 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80002014:	03f00793          	li	a5,63
    80002018:	14b7f063          	bgeu	a5,a1,80002158 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    8000201c:	00004797          	auipc	a5,0x4
    80002020:	9dc7b783          	ld	a5,-1572(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
    80002024:	02f60063          	beq	a2,a5,80002044 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80002028:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000202c:	02078a63          	beqz	a5,80002060 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80002030:	0007b683          	ld	a3,0(a5)
    80002034:	02e6f663          	bgeu	a3,a4,80002060 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80002038:	00078613          	mv	a2,a5
        curr = curr->next;
    8000203c:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80002040:	fedff06f          	j	8000202c <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80002044:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80002048:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    8000204c:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80002050:	00004797          	auipc	a5,0x4
    80002054:	9ae7b423          	sd	a4,-1624(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
        return 0;
    80002058:	00000513          	li	a0,0
    8000205c:	0480006f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80002060:	04060863          	beqz	a2,800020b0 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80002064:	00063683          	ld	a3,0(a2)
    80002068:	00863803          	ld	a6,8(a2)
    8000206c:	010686b3          	add	a3,a3,a6
    80002070:	08e68a63          	beq	a3,a4,80002104 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80002074:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002078:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    8000207c:	01063683          	ld	a3,16(a2)
    80002080:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80002084:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80002088:	0e078063          	beqz	a5,80002168 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    8000208c:	0007b583          	ld	a1,0(a5)
    80002090:	00073683          	ld	a3,0(a4)
    80002094:	00873603          	ld	a2,8(a4)
    80002098:	00c686b3          	add	a3,a3,a2
    8000209c:	06d58c63          	beq	a1,a3,80002114 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800020a0:	00000513          	li	a0,0
}
    800020a4:	00813403          	ld	s0,8(sp)
    800020a8:	01010113          	addi	sp,sp,16
    800020ac:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800020b0:	0a078863          	beqz	a5,80002160 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800020b4:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800020b8:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800020bc:	00004797          	auipc	a5,0x4
    800020c0:	93c7b783          	ld	a5,-1732(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
    800020c4:	0007b603          	ld	a2,0(a5)
    800020c8:	00b706b3          	add	a3,a4,a1
    800020cc:	00d60c63          	beq	a2,a3,800020e4 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800020d0:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800020d4:	00004797          	auipc	a5,0x4
    800020d8:	92e7b223          	sd	a4,-1756(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
            return 0;
    800020dc:	00000513          	li	a0,0
    800020e0:	fc5ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    800020e4:	0087b783          	ld	a5,8(a5)
    800020e8:	00b785b3          	add	a1,a5,a1
    800020ec:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    800020f0:	00004797          	auipc	a5,0x4
    800020f4:	9087b783          	ld	a5,-1784(a5) # 800059f8 <_ZN15MemoryAllocator4headE>
    800020f8:	0107b783          	ld	a5,16(a5)
    800020fc:	00f53423          	sd	a5,8(a0)
    80002100:	fd5ff06f          	j	800020d4 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80002104:	00b805b3          	add	a1,a6,a1
    80002108:	00b63423          	sd	a1,8(a2)
    8000210c:	00060713          	mv	a4,a2
    80002110:	f79ff06f          	j	80002088 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80002114:	0087b683          	ld	a3,8(a5)
    80002118:	00d60633          	add	a2,a2,a3
    8000211c:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002120:	0107b783          	ld	a5,16(a5)
    80002124:	00f73823          	sd	a5,16(a4)
    return 0;
    80002128:	00000513          	li	a0,0
    8000212c:	f79ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002130:	fff00513          	li	a0,-1
    80002134:	f71ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002138:	fff00513          	li	a0,-1
    8000213c:	f69ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    80002140:	fff00513          	li	a0,-1
    80002144:	f61ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002148:	fff00513          	li	a0,-1
    8000214c:	f59ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002150:	fff00513          	li	a0,-1
    80002154:	f51ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80002158:	fff00513          	li	a0,-1
    8000215c:	f49ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    80002160:	fff00513          	li	a0,-1
    80002164:	f41ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80002168:	00000513          	li	a0,0
    8000216c:	f39ff06f          	j	800020a4 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

0000000080002170 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    80002170:	fd010113          	addi	sp,sp,-48
    80002174:	02113423          	sd	ra,40(sp)
    80002178:	02813023          	sd	s0,32(sp)
    8000217c:	00913c23          	sd	s1,24(sp)
    80002180:	01213823          	sd	s2,16(sp)
    80002184:	03010413          	addi	s0,sp,48
    80002188:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000218c:	100027f3          	csrr	a5,sstatus
    80002190:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    80002194:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002198:	00200793          	li	a5,2
    8000219c:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    800021a0:	0004c503          	lbu	a0,0(s1)
    800021a4:	00050a63          	beqz	a0,800021b8 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    800021a8:	00002097          	auipc	ra,0x2
    800021ac:	244080e7          	jalr	580(ra) # 800043ec <__putc>
        string++;
    800021b0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800021b4:	fedff06f          	j	800021a0 <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800021b8:	0009091b          	sext.w	s2,s2
    800021bc:	00297913          	andi	s2,s2,2
    800021c0:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800021c4:	10092073          	csrs	sstatus,s2
}
    800021c8:	02813083          	ld	ra,40(sp)
    800021cc:	02013403          	ld	s0,32(sp)
    800021d0:	01813483          	ld	s1,24(sp)
    800021d4:	01013903          	ld	s2,16(sp)
    800021d8:	03010113          	addi	sp,sp,48
    800021dc:	00008067          	ret

00000000800021e0 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    800021e0:	fc010113          	addi	sp,sp,-64
    800021e4:	02113c23          	sd	ra,56(sp)
    800021e8:	02813823          	sd	s0,48(sp)
    800021ec:	02913423          	sd	s1,40(sp)
    800021f0:	03213023          	sd	s2,32(sp)
    800021f4:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800021f8:	100027f3          	csrr	a5,sstatus
    800021fc:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    80002200:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002204:	00200793          	li	a5,2
    80002208:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    8000220c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002210:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002214:	00a00613          	li	a2,10
    80002218:	02c5773b          	remuw	a4,a0,a2
    8000221c:	02071693          	slli	a3,a4,0x20
    80002220:	0206d693          	srli	a3,a3,0x20
    80002224:	00003717          	auipc	a4,0x3
    80002228:	edc70713          	addi	a4,a4,-292 # 80005100 <_ZZ12printIntegermE6digits>
    8000222c:	00d70733          	add	a4,a4,a3
    80002230:	00074703          	lbu	a4,0(a4)
    80002234:	fe040693          	addi	a3,s0,-32
    80002238:	009687b3          	add	a5,a3,s1
    8000223c:	0014849b          	addiw	s1,s1,1
    80002240:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002244:	0005071b          	sext.w	a4,a0
    80002248:	02c5553b          	divuw	a0,a0,a2
    8000224c:	00900793          	li	a5,9
    80002250:	fce7e2e3          	bltu	a5,a4,80002214 <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80002254:	fff4849b          	addiw	s1,s1,-1
    80002258:	0004ce63          	bltz	s1,80002274 <_Z12printIntegerm+0x94>
    8000225c:	fe040793          	addi	a5,s0,-32
    80002260:	009787b3          	add	a5,a5,s1
    80002264:	ff07c503          	lbu	a0,-16(a5)
    80002268:	00002097          	auipc	ra,0x2
    8000226c:	184080e7          	jalr	388(ra) # 800043ec <__putc>
    80002270:	fe5ff06f          	j	80002254 <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002274:	0009091b          	sext.w	s2,s2
    80002278:	00297913          	andi	s2,s2,2
    8000227c:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002280:	10092073          	csrs	sstatus,s2
}
    80002284:	03813083          	ld	ra,56(sp)
    80002288:	03013403          	ld	s0,48(sp)
    8000228c:	02813483          	ld	s1,40(sp)
    80002290:	02013903          	ld	s2,32(sp)
    80002294:	04010113          	addi	sp,sp,64
    80002298:	00008067          	ret

000000008000229c <_Z10printErrorv>:
void printError() {
    8000229c:	fd010113          	addi	sp,sp,-48
    800022a0:	02113423          	sd	ra,40(sp)
    800022a4:	02813023          	sd	s0,32(sp)
    800022a8:	03010413          	addi	s0,sp,48
    printString("scause: ");
    800022ac:	00003517          	auipc	a0,0x3
    800022b0:	e2c50513          	addi	a0,a0,-468 # 800050d8 <CONSOLE_STATUS+0xc8>
    800022b4:	00000097          	auipc	ra,0x0
    800022b8:	ebc080e7          	jalr	-324(ra) # 80002170 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800022bc:	142027f3          	csrr	a5,scause
    800022c0:	fef43423          	sd	a5,-24(s0)
        return scause;
    800022c4:	fe843503          	ld	a0,-24(s0)
    printInteger(Kernel::r_scause());
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	f18080e7          	jalr	-232(ra) # 800021e0 <_Z12printIntegerm>
    printString("\nsepc: ");
    800022d0:	00003517          	auipc	a0,0x3
    800022d4:	e1850513          	addi	a0,a0,-488 # 800050e8 <CONSOLE_STATUS+0xd8>
    800022d8:	00000097          	auipc	ra,0x0
    800022dc:	e98080e7          	jalr	-360(ra) # 80002170 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800022e0:	141027f3          	csrr	a5,sepc
    800022e4:	fef43023          	sd	a5,-32(s0)
        return sepc;
    800022e8:	fe043503          	ld	a0,-32(s0)
    printInteger(Kernel::r_sepc());
    800022ec:	00000097          	auipc	ra,0x0
    800022f0:	ef4080e7          	jalr	-268(ra) # 800021e0 <_Z12printIntegerm>
    printString("\nstval: ");
    800022f4:	00003517          	auipc	a0,0x3
    800022f8:	dfc50513          	addi	a0,a0,-516 # 800050f0 <CONSOLE_STATUS+0xe0>
    800022fc:	00000097          	auipc	ra,0x0
    80002300:	e74080e7          	jalr	-396(ra) # 80002170 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002304:	143027f3          	csrr	a5,stval
    80002308:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    8000230c:	fd843503          	ld	a0,-40(s0)
    printInteger(Kernel::r_stval());
    80002310:	00000097          	auipc	ra,0x0
    80002314:	ed0080e7          	jalr	-304(ra) # 800021e0 <_Z12printIntegerm>
    80002318:	02813083          	ld	ra,40(sp)
    8000231c:	02013403          	ld	s0,32(sp)
    80002320:	03010113          	addi	sp,sp,48
    80002324:	00008067          	ret

0000000080002328 <start>:
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00813423          	sd	s0,8(sp)
    80002330:	01010413          	addi	s0,sp,16
    80002334:	300027f3          	csrr	a5,mstatus
    80002338:	ffffe737          	lui	a4,0xffffe
    8000233c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7b9f>
    80002340:	00e7f7b3          	and	a5,a5,a4
    80002344:	00001737          	lui	a4,0x1
    80002348:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000234c:	00e7e7b3          	or	a5,a5,a4
    80002350:	30079073          	csrw	mstatus,a5
    80002354:	00000797          	auipc	a5,0x0
    80002358:	16078793          	addi	a5,a5,352 # 800024b4 <system_main>
    8000235c:	34179073          	csrw	mepc,a5
    80002360:	00000793          	li	a5,0
    80002364:	18079073          	csrw	satp,a5
    80002368:	000107b7          	lui	a5,0x10
    8000236c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002370:	30279073          	csrw	medeleg,a5
    80002374:	30379073          	csrw	mideleg,a5
    80002378:	104027f3          	csrr	a5,sie
    8000237c:	2227e793          	ori	a5,a5,546
    80002380:	10479073          	csrw	sie,a5
    80002384:	fff00793          	li	a5,-1
    80002388:	00a7d793          	srli	a5,a5,0xa
    8000238c:	3b079073          	csrw	pmpaddr0,a5
    80002390:	00f00793          	li	a5,15
    80002394:	3a079073          	csrw	pmpcfg0,a5
    80002398:	f14027f3          	csrr	a5,mhartid
    8000239c:	0200c737          	lui	a4,0x200c
    800023a0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800023a4:	0007869b          	sext.w	a3,a5
    800023a8:	00269713          	slli	a4,a3,0x2
    800023ac:	000f4637          	lui	a2,0xf4
    800023b0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800023b4:	00d70733          	add	a4,a4,a3
    800023b8:	0037979b          	slliw	a5,a5,0x3
    800023bc:	020046b7          	lui	a3,0x2004
    800023c0:	00d787b3          	add	a5,a5,a3
    800023c4:	00c585b3          	add	a1,a1,a2
    800023c8:	00371693          	slli	a3,a4,0x3
    800023cc:	00003717          	auipc	a4,0x3
    800023d0:	63470713          	addi	a4,a4,1588 # 80005a00 <timer_scratch>
    800023d4:	00b7b023          	sd	a1,0(a5)
    800023d8:	00d70733          	add	a4,a4,a3
    800023dc:	00f73c23          	sd	a5,24(a4)
    800023e0:	02c73023          	sd	a2,32(a4)
    800023e4:	34071073          	csrw	mscratch,a4
    800023e8:	00000797          	auipc	a5,0x0
    800023ec:	6e878793          	addi	a5,a5,1768 # 80002ad0 <timervec>
    800023f0:	30579073          	csrw	mtvec,a5
    800023f4:	300027f3          	csrr	a5,mstatus
    800023f8:	0087e793          	ori	a5,a5,8
    800023fc:	30079073          	csrw	mstatus,a5
    80002400:	304027f3          	csrr	a5,mie
    80002404:	0807e793          	ori	a5,a5,128
    80002408:	30479073          	csrw	mie,a5
    8000240c:	f14027f3          	csrr	a5,mhartid
    80002410:	0007879b          	sext.w	a5,a5
    80002414:	00078213          	mv	tp,a5
    80002418:	30200073          	mret
    8000241c:	00813403          	ld	s0,8(sp)
    80002420:	01010113          	addi	sp,sp,16
    80002424:	00008067          	ret

0000000080002428 <timerinit>:
    80002428:	ff010113          	addi	sp,sp,-16
    8000242c:	00813423          	sd	s0,8(sp)
    80002430:	01010413          	addi	s0,sp,16
    80002434:	f14027f3          	csrr	a5,mhartid
    80002438:	0200c737          	lui	a4,0x200c
    8000243c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002440:	0007869b          	sext.w	a3,a5
    80002444:	00269713          	slli	a4,a3,0x2
    80002448:	000f4637          	lui	a2,0xf4
    8000244c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002450:	00d70733          	add	a4,a4,a3
    80002454:	0037979b          	slliw	a5,a5,0x3
    80002458:	020046b7          	lui	a3,0x2004
    8000245c:	00d787b3          	add	a5,a5,a3
    80002460:	00c585b3          	add	a1,a1,a2
    80002464:	00371693          	slli	a3,a4,0x3
    80002468:	00003717          	auipc	a4,0x3
    8000246c:	59870713          	addi	a4,a4,1432 # 80005a00 <timer_scratch>
    80002470:	00b7b023          	sd	a1,0(a5)
    80002474:	00d70733          	add	a4,a4,a3
    80002478:	00f73c23          	sd	a5,24(a4)
    8000247c:	02c73023          	sd	a2,32(a4)
    80002480:	34071073          	csrw	mscratch,a4
    80002484:	00000797          	auipc	a5,0x0
    80002488:	64c78793          	addi	a5,a5,1612 # 80002ad0 <timervec>
    8000248c:	30579073          	csrw	mtvec,a5
    80002490:	300027f3          	csrr	a5,mstatus
    80002494:	0087e793          	ori	a5,a5,8
    80002498:	30079073          	csrw	mstatus,a5
    8000249c:	304027f3          	csrr	a5,mie
    800024a0:	0807e793          	ori	a5,a5,128
    800024a4:	30479073          	csrw	mie,a5
    800024a8:	00813403          	ld	s0,8(sp)
    800024ac:	01010113          	addi	sp,sp,16
    800024b0:	00008067          	ret

00000000800024b4 <system_main>:
    800024b4:	fe010113          	addi	sp,sp,-32
    800024b8:	00813823          	sd	s0,16(sp)
    800024bc:	00913423          	sd	s1,8(sp)
    800024c0:	00113c23          	sd	ra,24(sp)
    800024c4:	02010413          	addi	s0,sp,32
    800024c8:	00000097          	auipc	ra,0x0
    800024cc:	0c4080e7          	jalr	196(ra) # 8000258c <cpuid>
    800024d0:	00003497          	auipc	s1,0x3
    800024d4:	4d048493          	addi	s1,s1,1232 # 800059a0 <started>
    800024d8:	02050263          	beqz	a0,800024fc <system_main+0x48>
    800024dc:	0004a783          	lw	a5,0(s1)
    800024e0:	0007879b          	sext.w	a5,a5
    800024e4:	fe078ce3          	beqz	a5,800024dc <system_main+0x28>
    800024e8:	0ff0000f          	fence
    800024ec:	00003517          	auipc	a0,0x3
    800024f0:	c5450513          	addi	a0,a0,-940 # 80005140 <_ZZ12printIntegermE6digits+0x40>
    800024f4:	00001097          	auipc	ra,0x1
    800024f8:	a78080e7          	jalr	-1416(ra) # 80002f6c <panic>
    800024fc:	00001097          	auipc	ra,0x1
    80002500:	9cc080e7          	jalr	-1588(ra) # 80002ec8 <consoleinit>
    80002504:	00001097          	auipc	ra,0x1
    80002508:	158080e7          	jalr	344(ra) # 8000365c <printfinit>
    8000250c:	00003517          	auipc	a0,0x3
    80002510:	b8450513          	addi	a0,a0,-1148 # 80005090 <CONSOLE_STATUS+0x80>
    80002514:	00001097          	auipc	ra,0x1
    80002518:	ab4080e7          	jalr	-1356(ra) # 80002fc8 <__printf>
    8000251c:	00003517          	auipc	a0,0x3
    80002520:	bf450513          	addi	a0,a0,-1036 # 80005110 <_ZZ12printIntegermE6digits+0x10>
    80002524:	00001097          	auipc	ra,0x1
    80002528:	aa4080e7          	jalr	-1372(ra) # 80002fc8 <__printf>
    8000252c:	00003517          	auipc	a0,0x3
    80002530:	b6450513          	addi	a0,a0,-1180 # 80005090 <CONSOLE_STATUS+0x80>
    80002534:	00001097          	auipc	ra,0x1
    80002538:	a94080e7          	jalr	-1388(ra) # 80002fc8 <__printf>
    8000253c:	00001097          	auipc	ra,0x1
    80002540:	4ac080e7          	jalr	1196(ra) # 800039e8 <kinit>
    80002544:	00000097          	auipc	ra,0x0
    80002548:	148080e7          	jalr	328(ra) # 8000268c <trapinit>
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	16c080e7          	jalr	364(ra) # 800026b8 <trapinithart>
    80002554:	00000097          	auipc	ra,0x0
    80002558:	5bc080e7          	jalr	1468(ra) # 80002b10 <plicinit>
    8000255c:	00000097          	auipc	ra,0x0
    80002560:	5dc080e7          	jalr	1500(ra) # 80002b38 <plicinithart>
    80002564:	00000097          	auipc	ra,0x0
    80002568:	078080e7          	jalr	120(ra) # 800025dc <userinit>
    8000256c:	0ff0000f          	fence
    80002570:	00100793          	li	a5,1
    80002574:	00003517          	auipc	a0,0x3
    80002578:	bb450513          	addi	a0,a0,-1100 # 80005128 <_ZZ12printIntegermE6digits+0x28>
    8000257c:	00f4a023          	sw	a5,0(s1)
    80002580:	00001097          	auipc	ra,0x1
    80002584:	a48080e7          	jalr	-1464(ra) # 80002fc8 <__printf>
    80002588:	0000006f          	j	80002588 <system_main+0xd4>

000000008000258c <cpuid>:
    8000258c:	ff010113          	addi	sp,sp,-16
    80002590:	00813423          	sd	s0,8(sp)
    80002594:	01010413          	addi	s0,sp,16
    80002598:	00020513          	mv	a0,tp
    8000259c:	00813403          	ld	s0,8(sp)
    800025a0:	0005051b          	sext.w	a0,a0
    800025a4:	01010113          	addi	sp,sp,16
    800025a8:	00008067          	ret

00000000800025ac <mycpu>:
    800025ac:	ff010113          	addi	sp,sp,-16
    800025b0:	00813423          	sd	s0,8(sp)
    800025b4:	01010413          	addi	s0,sp,16
    800025b8:	00020793          	mv	a5,tp
    800025bc:	00813403          	ld	s0,8(sp)
    800025c0:	0007879b          	sext.w	a5,a5
    800025c4:	00779793          	slli	a5,a5,0x7
    800025c8:	00004517          	auipc	a0,0x4
    800025cc:	46850513          	addi	a0,a0,1128 # 80006a30 <cpus>
    800025d0:	00f50533          	add	a0,a0,a5
    800025d4:	01010113          	addi	sp,sp,16
    800025d8:	00008067          	ret

00000000800025dc <userinit>:
    800025dc:	ff010113          	addi	sp,sp,-16
    800025e0:	00813423          	sd	s0,8(sp)
    800025e4:	01010413          	addi	s0,sp,16
    800025e8:	00813403          	ld	s0,8(sp)
    800025ec:	01010113          	addi	sp,sp,16
    800025f0:	fffff317          	auipc	t1,0xfffff
    800025f4:	69830067          	jr	1688(t1) # 80001c88 <main>

00000000800025f8 <either_copyout>:
    800025f8:	ff010113          	addi	sp,sp,-16
    800025fc:	00813023          	sd	s0,0(sp)
    80002600:	00113423          	sd	ra,8(sp)
    80002604:	01010413          	addi	s0,sp,16
    80002608:	02051663          	bnez	a0,80002634 <either_copyout+0x3c>
    8000260c:	00058513          	mv	a0,a1
    80002610:	00060593          	mv	a1,a2
    80002614:	0006861b          	sext.w	a2,a3
    80002618:	00002097          	auipc	ra,0x2
    8000261c:	c5c080e7          	jalr	-932(ra) # 80004274 <__memmove>
    80002620:	00813083          	ld	ra,8(sp)
    80002624:	00013403          	ld	s0,0(sp)
    80002628:	00000513          	li	a0,0
    8000262c:	01010113          	addi	sp,sp,16
    80002630:	00008067          	ret
    80002634:	00003517          	auipc	a0,0x3
    80002638:	b3450513          	addi	a0,a0,-1228 # 80005168 <_ZZ12printIntegermE6digits+0x68>
    8000263c:	00001097          	auipc	ra,0x1
    80002640:	930080e7          	jalr	-1744(ra) # 80002f6c <panic>

0000000080002644 <either_copyin>:
    80002644:	ff010113          	addi	sp,sp,-16
    80002648:	00813023          	sd	s0,0(sp)
    8000264c:	00113423          	sd	ra,8(sp)
    80002650:	01010413          	addi	s0,sp,16
    80002654:	02059463          	bnez	a1,8000267c <either_copyin+0x38>
    80002658:	00060593          	mv	a1,a2
    8000265c:	0006861b          	sext.w	a2,a3
    80002660:	00002097          	auipc	ra,0x2
    80002664:	c14080e7          	jalr	-1004(ra) # 80004274 <__memmove>
    80002668:	00813083          	ld	ra,8(sp)
    8000266c:	00013403          	ld	s0,0(sp)
    80002670:	00000513          	li	a0,0
    80002674:	01010113          	addi	sp,sp,16
    80002678:	00008067          	ret
    8000267c:	00003517          	auipc	a0,0x3
    80002680:	b1450513          	addi	a0,a0,-1260 # 80005190 <_ZZ12printIntegermE6digits+0x90>
    80002684:	00001097          	auipc	ra,0x1
    80002688:	8e8080e7          	jalr	-1816(ra) # 80002f6c <panic>

000000008000268c <trapinit>:
    8000268c:	ff010113          	addi	sp,sp,-16
    80002690:	00813423          	sd	s0,8(sp)
    80002694:	01010413          	addi	s0,sp,16
    80002698:	00813403          	ld	s0,8(sp)
    8000269c:	00003597          	auipc	a1,0x3
    800026a0:	b1c58593          	addi	a1,a1,-1252 # 800051b8 <_ZZ12printIntegermE6digits+0xb8>
    800026a4:	00004517          	auipc	a0,0x4
    800026a8:	40c50513          	addi	a0,a0,1036 # 80006ab0 <tickslock>
    800026ac:	01010113          	addi	sp,sp,16
    800026b0:	00001317          	auipc	t1,0x1
    800026b4:	5c830067          	jr	1480(t1) # 80003c78 <initlock>

00000000800026b8 <trapinithart>:
    800026b8:	ff010113          	addi	sp,sp,-16
    800026bc:	00813423          	sd	s0,8(sp)
    800026c0:	01010413          	addi	s0,sp,16
    800026c4:	00000797          	auipc	a5,0x0
    800026c8:	2fc78793          	addi	a5,a5,764 # 800029c0 <kernelvec>
    800026cc:	10579073          	csrw	stvec,a5
    800026d0:	00813403          	ld	s0,8(sp)
    800026d4:	01010113          	addi	sp,sp,16
    800026d8:	00008067          	ret

00000000800026dc <usertrap>:
    800026dc:	ff010113          	addi	sp,sp,-16
    800026e0:	00813423          	sd	s0,8(sp)
    800026e4:	01010413          	addi	s0,sp,16
    800026e8:	00813403          	ld	s0,8(sp)
    800026ec:	01010113          	addi	sp,sp,16
    800026f0:	00008067          	ret

00000000800026f4 <usertrapret>:
    800026f4:	ff010113          	addi	sp,sp,-16
    800026f8:	00813423          	sd	s0,8(sp)
    800026fc:	01010413          	addi	s0,sp,16
    80002700:	00813403          	ld	s0,8(sp)
    80002704:	01010113          	addi	sp,sp,16
    80002708:	00008067          	ret

000000008000270c <kerneltrap>:
    8000270c:	fe010113          	addi	sp,sp,-32
    80002710:	00813823          	sd	s0,16(sp)
    80002714:	00113c23          	sd	ra,24(sp)
    80002718:	00913423          	sd	s1,8(sp)
    8000271c:	02010413          	addi	s0,sp,32
    80002720:	142025f3          	csrr	a1,scause
    80002724:	100027f3          	csrr	a5,sstatus
    80002728:	0027f793          	andi	a5,a5,2
    8000272c:	10079c63          	bnez	a5,80002844 <kerneltrap+0x138>
    80002730:	142027f3          	csrr	a5,scause
    80002734:	0207ce63          	bltz	a5,80002770 <kerneltrap+0x64>
    80002738:	00003517          	auipc	a0,0x3
    8000273c:	ac850513          	addi	a0,a0,-1336 # 80005200 <_ZZ12printIntegermE6digits+0x100>
    80002740:	00001097          	auipc	ra,0x1
    80002744:	888080e7          	jalr	-1912(ra) # 80002fc8 <__printf>
    80002748:	141025f3          	csrr	a1,sepc
    8000274c:	14302673          	csrr	a2,stval
    80002750:	00003517          	auipc	a0,0x3
    80002754:	ac050513          	addi	a0,a0,-1344 # 80005210 <_ZZ12printIntegermE6digits+0x110>
    80002758:	00001097          	auipc	ra,0x1
    8000275c:	870080e7          	jalr	-1936(ra) # 80002fc8 <__printf>
    80002760:	00003517          	auipc	a0,0x3
    80002764:	ac850513          	addi	a0,a0,-1336 # 80005228 <_ZZ12printIntegermE6digits+0x128>
    80002768:	00001097          	auipc	ra,0x1
    8000276c:	804080e7          	jalr	-2044(ra) # 80002f6c <panic>
    80002770:	0ff7f713          	andi	a4,a5,255
    80002774:	00900693          	li	a3,9
    80002778:	04d70063          	beq	a4,a3,800027b8 <kerneltrap+0xac>
    8000277c:	fff00713          	li	a4,-1
    80002780:	03f71713          	slli	a4,a4,0x3f
    80002784:	00170713          	addi	a4,a4,1
    80002788:	fae798e3          	bne	a5,a4,80002738 <kerneltrap+0x2c>
    8000278c:	00000097          	auipc	ra,0x0
    80002790:	e00080e7          	jalr	-512(ra) # 8000258c <cpuid>
    80002794:	06050663          	beqz	a0,80002800 <kerneltrap+0xf4>
    80002798:	144027f3          	csrr	a5,sip
    8000279c:	ffd7f793          	andi	a5,a5,-3
    800027a0:	14479073          	csrw	sip,a5
    800027a4:	01813083          	ld	ra,24(sp)
    800027a8:	01013403          	ld	s0,16(sp)
    800027ac:	00813483          	ld	s1,8(sp)
    800027b0:	02010113          	addi	sp,sp,32
    800027b4:	00008067          	ret
    800027b8:	00000097          	auipc	ra,0x0
    800027bc:	3cc080e7          	jalr	972(ra) # 80002b84 <plic_claim>
    800027c0:	00a00793          	li	a5,10
    800027c4:	00050493          	mv	s1,a0
    800027c8:	06f50863          	beq	a0,a5,80002838 <kerneltrap+0x12c>
    800027cc:	fc050ce3          	beqz	a0,800027a4 <kerneltrap+0x98>
    800027d0:	00050593          	mv	a1,a0
    800027d4:	00003517          	auipc	a0,0x3
    800027d8:	a0c50513          	addi	a0,a0,-1524 # 800051e0 <_ZZ12printIntegermE6digits+0xe0>
    800027dc:	00000097          	auipc	ra,0x0
    800027e0:	7ec080e7          	jalr	2028(ra) # 80002fc8 <__printf>
    800027e4:	01013403          	ld	s0,16(sp)
    800027e8:	01813083          	ld	ra,24(sp)
    800027ec:	00048513          	mv	a0,s1
    800027f0:	00813483          	ld	s1,8(sp)
    800027f4:	02010113          	addi	sp,sp,32
    800027f8:	00000317          	auipc	t1,0x0
    800027fc:	3c430067          	jr	964(t1) # 80002bbc <plic_complete>
    80002800:	00004517          	auipc	a0,0x4
    80002804:	2b050513          	addi	a0,a0,688 # 80006ab0 <tickslock>
    80002808:	00001097          	auipc	ra,0x1
    8000280c:	494080e7          	jalr	1172(ra) # 80003c9c <acquire>
    80002810:	00003717          	auipc	a4,0x3
    80002814:	19470713          	addi	a4,a4,404 # 800059a4 <ticks>
    80002818:	00072783          	lw	a5,0(a4)
    8000281c:	00004517          	auipc	a0,0x4
    80002820:	29450513          	addi	a0,a0,660 # 80006ab0 <tickslock>
    80002824:	0017879b          	addiw	a5,a5,1
    80002828:	00f72023          	sw	a5,0(a4)
    8000282c:	00001097          	auipc	ra,0x1
    80002830:	53c080e7          	jalr	1340(ra) # 80003d68 <release>
    80002834:	f65ff06f          	j	80002798 <kerneltrap+0x8c>
    80002838:	00001097          	auipc	ra,0x1
    8000283c:	098080e7          	jalr	152(ra) # 800038d0 <uartintr>
    80002840:	fa5ff06f          	j	800027e4 <kerneltrap+0xd8>
    80002844:	00003517          	auipc	a0,0x3
    80002848:	97c50513          	addi	a0,a0,-1668 # 800051c0 <_ZZ12printIntegermE6digits+0xc0>
    8000284c:	00000097          	auipc	ra,0x0
    80002850:	720080e7          	jalr	1824(ra) # 80002f6c <panic>

0000000080002854 <clockintr>:
    80002854:	fe010113          	addi	sp,sp,-32
    80002858:	00813823          	sd	s0,16(sp)
    8000285c:	00913423          	sd	s1,8(sp)
    80002860:	00113c23          	sd	ra,24(sp)
    80002864:	02010413          	addi	s0,sp,32
    80002868:	00004497          	auipc	s1,0x4
    8000286c:	24848493          	addi	s1,s1,584 # 80006ab0 <tickslock>
    80002870:	00048513          	mv	a0,s1
    80002874:	00001097          	auipc	ra,0x1
    80002878:	428080e7          	jalr	1064(ra) # 80003c9c <acquire>
    8000287c:	00003717          	auipc	a4,0x3
    80002880:	12870713          	addi	a4,a4,296 # 800059a4 <ticks>
    80002884:	00072783          	lw	a5,0(a4)
    80002888:	01013403          	ld	s0,16(sp)
    8000288c:	01813083          	ld	ra,24(sp)
    80002890:	00048513          	mv	a0,s1
    80002894:	0017879b          	addiw	a5,a5,1
    80002898:	00813483          	ld	s1,8(sp)
    8000289c:	00f72023          	sw	a5,0(a4)
    800028a0:	02010113          	addi	sp,sp,32
    800028a4:	00001317          	auipc	t1,0x1
    800028a8:	4c430067          	jr	1220(t1) # 80003d68 <release>

00000000800028ac <devintr>:
    800028ac:	142027f3          	csrr	a5,scause
    800028b0:	00000513          	li	a0,0
    800028b4:	0007c463          	bltz	a5,800028bc <devintr+0x10>
    800028b8:	00008067          	ret
    800028bc:	fe010113          	addi	sp,sp,-32
    800028c0:	00813823          	sd	s0,16(sp)
    800028c4:	00113c23          	sd	ra,24(sp)
    800028c8:	00913423          	sd	s1,8(sp)
    800028cc:	02010413          	addi	s0,sp,32
    800028d0:	0ff7f713          	andi	a4,a5,255
    800028d4:	00900693          	li	a3,9
    800028d8:	04d70c63          	beq	a4,a3,80002930 <devintr+0x84>
    800028dc:	fff00713          	li	a4,-1
    800028e0:	03f71713          	slli	a4,a4,0x3f
    800028e4:	00170713          	addi	a4,a4,1
    800028e8:	00e78c63          	beq	a5,a4,80002900 <devintr+0x54>
    800028ec:	01813083          	ld	ra,24(sp)
    800028f0:	01013403          	ld	s0,16(sp)
    800028f4:	00813483          	ld	s1,8(sp)
    800028f8:	02010113          	addi	sp,sp,32
    800028fc:	00008067          	ret
    80002900:	00000097          	auipc	ra,0x0
    80002904:	c8c080e7          	jalr	-884(ra) # 8000258c <cpuid>
    80002908:	06050663          	beqz	a0,80002974 <devintr+0xc8>
    8000290c:	144027f3          	csrr	a5,sip
    80002910:	ffd7f793          	andi	a5,a5,-3
    80002914:	14479073          	csrw	sip,a5
    80002918:	01813083          	ld	ra,24(sp)
    8000291c:	01013403          	ld	s0,16(sp)
    80002920:	00813483          	ld	s1,8(sp)
    80002924:	00200513          	li	a0,2
    80002928:	02010113          	addi	sp,sp,32
    8000292c:	00008067          	ret
    80002930:	00000097          	auipc	ra,0x0
    80002934:	254080e7          	jalr	596(ra) # 80002b84 <plic_claim>
    80002938:	00a00793          	li	a5,10
    8000293c:	00050493          	mv	s1,a0
    80002940:	06f50663          	beq	a0,a5,800029ac <devintr+0x100>
    80002944:	00100513          	li	a0,1
    80002948:	fa0482e3          	beqz	s1,800028ec <devintr+0x40>
    8000294c:	00048593          	mv	a1,s1
    80002950:	00003517          	auipc	a0,0x3
    80002954:	89050513          	addi	a0,a0,-1904 # 800051e0 <_ZZ12printIntegermE6digits+0xe0>
    80002958:	00000097          	auipc	ra,0x0
    8000295c:	670080e7          	jalr	1648(ra) # 80002fc8 <__printf>
    80002960:	00048513          	mv	a0,s1
    80002964:	00000097          	auipc	ra,0x0
    80002968:	258080e7          	jalr	600(ra) # 80002bbc <plic_complete>
    8000296c:	00100513          	li	a0,1
    80002970:	f7dff06f          	j	800028ec <devintr+0x40>
    80002974:	00004517          	auipc	a0,0x4
    80002978:	13c50513          	addi	a0,a0,316 # 80006ab0 <tickslock>
    8000297c:	00001097          	auipc	ra,0x1
    80002980:	320080e7          	jalr	800(ra) # 80003c9c <acquire>
    80002984:	00003717          	auipc	a4,0x3
    80002988:	02070713          	addi	a4,a4,32 # 800059a4 <ticks>
    8000298c:	00072783          	lw	a5,0(a4)
    80002990:	00004517          	auipc	a0,0x4
    80002994:	12050513          	addi	a0,a0,288 # 80006ab0 <tickslock>
    80002998:	0017879b          	addiw	a5,a5,1
    8000299c:	00f72023          	sw	a5,0(a4)
    800029a0:	00001097          	auipc	ra,0x1
    800029a4:	3c8080e7          	jalr	968(ra) # 80003d68 <release>
    800029a8:	f65ff06f          	j	8000290c <devintr+0x60>
    800029ac:	00001097          	auipc	ra,0x1
    800029b0:	f24080e7          	jalr	-220(ra) # 800038d0 <uartintr>
    800029b4:	fadff06f          	j	80002960 <devintr+0xb4>
	...

00000000800029c0 <kernelvec>:
    800029c0:	f0010113          	addi	sp,sp,-256
    800029c4:	00113023          	sd	ra,0(sp)
    800029c8:	00213423          	sd	sp,8(sp)
    800029cc:	00313823          	sd	gp,16(sp)
    800029d0:	00413c23          	sd	tp,24(sp)
    800029d4:	02513023          	sd	t0,32(sp)
    800029d8:	02613423          	sd	t1,40(sp)
    800029dc:	02713823          	sd	t2,48(sp)
    800029e0:	02813c23          	sd	s0,56(sp)
    800029e4:	04913023          	sd	s1,64(sp)
    800029e8:	04a13423          	sd	a0,72(sp)
    800029ec:	04b13823          	sd	a1,80(sp)
    800029f0:	04c13c23          	sd	a2,88(sp)
    800029f4:	06d13023          	sd	a3,96(sp)
    800029f8:	06e13423          	sd	a4,104(sp)
    800029fc:	06f13823          	sd	a5,112(sp)
    80002a00:	07013c23          	sd	a6,120(sp)
    80002a04:	09113023          	sd	a7,128(sp)
    80002a08:	09213423          	sd	s2,136(sp)
    80002a0c:	09313823          	sd	s3,144(sp)
    80002a10:	09413c23          	sd	s4,152(sp)
    80002a14:	0b513023          	sd	s5,160(sp)
    80002a18:	0b613423          	sd	s6,168(sp)
    80002a1c:	0b713823          	sd	s7,176(sp)
    80002a20:	0b813c23          	sd	s8,184(sp)
    80002a24:	0d913023          	sd	s9,192(sp)
    80002a28:	0da13423          	sd	s10,200(sp)
    80002a2c:	0db13823          	sd	s11,208(sp)
    80002a30:	0dc13c23          	sd	t3,216(sp)
    80002a34:	0fd13023          	sd	t4,224(sp)
    80002a38:	0fe13423          	sd	t5,232(sp)
    80002a3c:	0ff13823          	sd	t6,240(sp)
    80002a40:	ccdff0ef          	jal	ra,8000270c <kerneltrap>
    80002a44:	00013083          	ld	ra,0(sp)
    80002a48:	00813103          	ld	sp,8(sp)
    80002a4c:	01013183          	ld	gp,16(sp)
    80002a50:	02013283          	ld	t0,32(sp)
    80002a54:	02813303          	ld	t1,40(sp)
    80002a58:	03013383          	ld	t2,48(sp)
    80002a5c:	03813403          	ld	s0,56(sp)
    80002a60:	04013483          	ld	s1,64(sp)
    80002a64:	04813503          	ld	a0,72(sp)
    80002a68:	05013583          	ld	a1,80(sp)
    80002a6c:	05813603          	ld	a2,88(sp)
    80002a70:	06013683          	ld	a3,96(sp)
    80002a74:	06813703          	ld	a4,104(sp)
    80002a78:	07013783          	ld	a5,112(sp)
    80002a7c:	07813803          	ld	a6,120(sp)
    80002a80:	08013883          	ld	a7,128(sp)
    80002a84:	08813903          	ld	s2,136(sp)
    80002a88:	09013983          	ld	s3,144(sp)
    80002a8c:	09813a03          	ld	s4,152(sp)
    80002a90:	0a013a83          	ld	s5,160(sp)
    80002a94:	0a813b03          	ld	s6,168(sp)
    80002a98:	0b013b83          	ld	s7,176(sp)
    80002a9c:	0b813c03          	ld	s8,184(sp)
    80002aa0:	0c013c83          	ld	s9,192(sp)
    80002aa4:	0c813d03          	ld	s10,200(sp)
    80002aa8:	0d013d83          	ld	s11,208(sp)
    80002aac:	0d813e03          	ld	t3,216(sp)
    80002ab0:	0e013e83          	ld	t4,224(sp)
    80002ab4:	0e813f03          	ld	t5,232(sp)
    80002ab8:	0f013f83          	ld	t6,240(sp)
    80002abc:	10010113          	addi	sp,sp,256
    80002ac0:	10200073          	sret
    80002ac4:	00000013          	nop
    80002ac8:	00000013          	nop
    80002acc:	00000013          	nop

0000000080002ad0 <timervec>:
    80002ad0:	34051573          	csrrw	a0,mscratch,a0
    80002ad4:	00b53023          	sd	a1,0(a0)
    80002ad8:	00c53423          	sd	a2,8(a0)
    80002adc:	00d53823          	sd	a3,16(a0)
    80002ae0:	01853583          	ld	a1,24(a0)
    80002ae4:	02053603          	ld	a2,32(a0)
    80002ae8:	0005b683          	ld	a3,0(a1)
    80002aec:	00c686b3          	add	a3,a3,a2
    80002af0:	00d5b023          	sd	a3,0(a1)
    80002af4:	00200593          	li	a1,2
    80002af8:	14459073          	csrw	sip,a1
    80002afc:	01053683          	ld	a3,16(a0)
    80002b00:	00853603          	ld	a2,8(a0)
    80002b04:	00053583          	ld	a1,0(a0)
    80002b08:	34051573          	csrrw	a0,mscratch,a0
    80002b0c:	30200073          	mret

0000000080002b10 <plicinit>:
    80002b10:	ff010113          	addi	sp,sp,-16
    80002b14:	00813423          	sd	s0,8(sp)
    80002b18:	01010413          	addi	s0,sp,16
    80002b1c:	00813403          	ld	s0,8(sp)
    80002b20:	0c0007b7          	lui	a5,0xc000
    80002b24:	00100713          	li	a4,1
    80002b28:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002b2c:	00e7a223          	sw	a4,4(a5)
    80002b30:	01010113          	addi	sp,sp,16
    80002b34:	00008067          	ret

0000000080002b38 <plicinithart>:
    80002b38:	ff010113          	addi	sp,sp,-16
    80002b3c:	00813023          	sd	s0,0(sp)
    80002b40:	00113423          	sd	ra,8(sp)
    80002b44:	01010413          	addi	s0,sp,16
    80002b48:	00000097          	auipc	ra,0x0
    80002b4c:	a44080e7          	jalr	-1468(ra) # 8000258c <cpuid>
    80002b50:	0085171b          	slliw	a4,a0,0x8
    80002b54:	0c0027b7          	lui	a5,0xc002
    80002b58:	00e787b3          	add	a5,a5,a4
    80002b5c:	40200713          	li	a4,1026
    80002b60:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002b64:	00813083          	ld	ra,8(sp)
    80002b68:	00013403          	ld	s0,0(sp)
    80002b6c:	00d5151b          	slliw	a0,a0,0xd
    80002b70:	0c2017b7          	lui	a5,0xc201
    80002b74:	00a78533          	add	a0,a5,a0
    80002b78:	00052023          	sw	zero,0(a0)
    80002b7c:	01010113          	addi	sp,sp,16
    80002b80:	00008067          	ret

0000000080002b84 <plic_claim>:
    80002b84:	ff010113          	addi	sp,sp,-16
    80002b88:	00813023          	sd	s0,0(sp)
    80002b8c:	00113423          	sd	ra,8(sp)
    80002b90:	01010413          	addi	s0,sp,16
    80002b94:	00000097          	auipc	ra,0x0
    80002b98:	9f8080e7          	jalr	-1544(ra) # 8000258c <cpuid>
    80002b9c:	00813083          	ld	ra,8(sp)
    80002ba0:	00013403          	ld	s0,0(sp)
    80002ba4:	00d5151b          	slliw	a0,a0,0xd
    80002ba8:	0c2017b7          	lui	a5,0xc201
    80002bac:	00a78533          	add	a0,a5,a0
    80002bb0:	00452503          	lw	a0,4(a0)
    80002bb4:	01010113          	addi	sp,sp,16
    80002bb8:	00008067          	ret

0000000080002bbc <plic_complete>:
    80002bbc:	fe010113          	addi	sp,sp,-32
    80002bc0:	00813823          	sd	s0,16(sp)
    80002bc4:	00913423          	sd	s1,8(sp)
    80002bc8:	00113c23          	sd	ra,24(sp)
    80002bcc:	02010413          	addi	s0,sp,32
    80002bd0:	00050493          	mv	s1,a0
    80002bd4:	00000097          	auipc	ra,0x0
    80002bd8:	9b8080e7          	jalr	-1608(ra) # 8000258c <cpuid>
    80002bdc:	01813083          	ld	ra,24(sp)
    80002be0:	01013403          	ld	s0,16(sp)
    80002be4:	00d5179b          	slliw	a5,a0,0xd
    80002be8:	0c201737          	lui	a4,0xc201
    80002bec:	00f707b3          	add	a5,a4,a5
    80002bf0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002bf4:	00813483          	ld	s1,8(sp)
    80002bf8:	02010113          	addi	sp,sp,32
    80002bfc:	00008067          	ret

0000000080002c00 <consolewrite>:
    80002c00:	fb010113          	addi	sp,sp,-80
    80002c04:	04813023          	sd	s0,64(sp)
    80002c08:	04113423          	sd	ra,72(sp)
    80002c0c:	02913c23          	sd	s1,56(sp)
    80002c10:	03213823          	sd	s2,48(sp)
    80002c14:	03313423          	sd	s3,40(sp)
    80002c18:	03413023          	sd	s4,32(sp)
    80002c1c:	01513c23          	sd	s5,24(sp)
    80002c20:	05010413          	addi	s0,sp,80
    80002c24:	06c05c63          	blez	a2,80002c9c <consolewrite+0x9c>
    80002c28:	00060993          	mv	s3,a2
    80002c2c:	00050a13          	mv	s4,a0
    80002c30:	00058493          	mv	s1,a1
    80002c34:	00000913          	li	s2,0
    80002c38:	fff00a93          	li	s5,-1
    80002c3c:	01c0006f          	j	80002c58 <consolewrite+0x58>
    80002c40:	fbf44503          	lbu	a0,-65(s0)
    80002c44:	0019091b          	addiw	s2,s2,1
    80002c48:	00148493          	addi	s1,s1,1
    80002c4c:	00001097          	auipc	ra,0x1
    80002c50:	a9c080e7          	jalr	-1380(ra) # 800036e8 <uartputc>
    80002c54:	03298063          	beq	s3,s2,80002c74 <consolewrite+0x74>
    80002c58:	00048613          	mv	a2,s1
    80002c5c:	00100693          	li	a3,1
    80002c60:	000a0593          	mv	a1,s4
    80002c64:	fbf40513          	addi	a0,s0,-65
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	9dc080e7          	jalr	-1572(ra) # 80002644 <either_copyin>
    80002c70:	fd5518e3          	bne	a0,s5,80002c40 <consolewrite+0x40>
    80002c74:	04813083          	ld	ra,72(sp)
    80002c78:	04013403          	ld	s0,64(sp)
    80002c7c:	03813483          	ld	s1,56(sp)
    80002c80:	02813983          	ld	s3,40(sp)
    80002c84:	02013a03          	ld	s4,32(sp)
    80002c88:	01813a83          	ld	s5,24(sp)
    80002c8c:	00090513          	mv	a0,s2
    80002c90:	03013903          	ld	s2,48(sp)
    80002c94:	05010113          	addi	sp,sp,80
    80002c98:	00008067          	ret
    80002c9c:	00000913          	li	s2,0
    80002ca0:	fd5ff06f          	j	80002c74 <consolewrite+0x74>

0000000080002ca4 <consoleread>:
    80002ca4:	f9010113          	addi	sp,sp,-112
    80002ca8:	06813023          	sd	s0,96(sp)
    80002cac:	04913c23          	sd	s1,88(sp)
    80002cb0:	05213823          	sd	s2,80(sp)
    80002cb4:	05313423          	sd	s3,72(sp)
    80002cb8:	05413023          	sd	s4,64(sp)
    80002cbc:	03513c23          	sd	s5,56(sp)
    80002cc0:	03613823          	sd	s6,48(sp)
    80002cc4:	03713423          	sd	s7,40(sp)
    80002cc8:	03813023          	sd	s8,32(sp)
    80002ccc:	06113423          	sd	ra,104(sp)
    80002cd0:	01913c23          	sd	s9,24(sp)
    80002cd4:	07010413          	addi	s0,sp,112
    80002cd8:	00060b93          	mv	s7,a2
    80002cdc:	00050913          	mv	s2,a0
    80002ce0:	00058c13          	mv	s8,a1
    80002ce4:	00060b1b          	sext.w	s6,a2
    80002ce8:	00004497          	auipc	s1,0x4
    80002cec:	df048493          	addi	s1,s1,-528 # 80006ad8 <cons>
    80002cf0:	00400993          	li	s3,4
    80002cf4:	fff00a13          	li	s4,-1
    80002cf8:	00a00a93          	li	s5,10
    80002cfc:	05705e63          	blez	s7,80002d58 <consoleread+0xb4>
    80002d00:	09c4a703          	lw	a4,156(s1)
    80002d04:	0984a783          	lw	a5,152(s1)
    80002d08:	0007071b          	sext.w	a4,a4
    80002d0c:	08e78463          	beq	a5,a4,80002d94 <consoleread+0xf0>
    80002d10:	07f7f713          	andi	a4,a5,127
    80002d14:	00e48733          	add	a4,s1,a4
    80002d18:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002d1c:	0017869b          	addiw	a3,a5,1
    80002d20:	08d4ac23          	sw	a3,152(s1)
    80002d24:	00070c9b          	sext.w	s9,a4
    80002d28:	0b370663          	beq	a4,s3,80002dd4 <consoleread+0x130>
    80002d2c:	00100693          	li	a3,1
    80002d30:	f9f40613          	addi	a2,s0,-97
    80002d34:	000c0593          	mv	a1,s8
    80002d38:	00090513          	mv	a0,s2
    80002d3c:	f8e40fa3          	sb	a4,-97(s0)
    80002d40:	00000097          	auipc	ra,0x0
    80002d44:	8b8080e7          	jalr	-1864(ra) # 800025f8 <either_copyout>
    80002d48:	01450863          	beq	a0,s4,80002d58 <consoleread+0xb4>
    80002d4c:	001c0c13          	addi	s8,s8,1
    80002d50:	fffb8b9b          	addiw	s7,s7,-1
    80002d54:	fb5c94e3          	bne	s9,s5,80002cfc <consoleread+0x58>
    80002d58:	000b851b          	sext.w	a0,s7
    80002d5c:	06813083          	ld	ra,104(sp)
    80002d60:	06013403          	ld	s0,96(sp)
    80002d64:	05813483          	ld	s1,88(sp)
    80002d68:	05013903          	ld	s2,80(sp)
    80002d6c:	04813983          	ld	s3,72(sp)
    80002d70:	04013a03          	ld	s4,64(sp)
    80002d74:	03813a83          	ld	s5,56(sp)
    80002d78:	02813b83          	ld	s7,40(sp)
    80002d7c:	02013c03          	ld	s8,32(sp)
    80002d80:	01813c83          	ld	s9,24(sp)
    80002d84:	40ab053b          	subw	a0,s6,a0
    80002d88:	03013b03          	ld	s6,48(sp)
    80002d8c:	07010113          	addi	sp,sp,112
    80002d90:	00008067          	ret
    80002d94:	00001097          	auipc	ra,0x1
    80002d98:	1d8080e7          	jalr	472(ra) # 80003f6c <push_on>
    80002d9c:	0984a703          	lw	a4,152(s1)
    80002da0:	09c4a783          	lw	a5,156(s1)
    80002da4:	0007879b          	sext.w	a5,a5
    80002da8:	fef70ce3          	beq	a4,a5,80002da0 <consoleread+0xfc>
    80002dac:	00001097          	auipc	ra,0x1
    80002db0:	234080e7          	jalr	564(ra) # 80003fe0 <pop_on>
    80002db4:	0984a783          	lw	a5,152(s1)
    80002db8:	07f7f713          	andi	a4,a5,127
    80002dbc:	00e48733          	add	a4,s1,a4
    80002dc0:	01874703          	lbu	a4,24(a4)
    80002dc4:	0017869b          	addiw	a3,a5,1
    80002dc8:	08d4ac23          	sw	a3,152(s1)
    80002dcc:	00070c9b          	sext.w	s9,a4
    80002dd0:	f5371ee3          	bne	a4,s3,80002d2c <consoleread+0x88>
    80002dd4:	000b851b          	sext.w	a0,s7
    80002dd8:	f96bf2e3          	bgeu	s7,s6,80002d5c <consoleread+0xb8>
    80002ddc:	08f4ac23          	sw	a5,152(s1)
    80002de0:	f7dff06f          	j	80002d5c <consoleread+0xb8>

0000000080002de4 <consputc>:
    80002de4:	10000793          	li	a5,256
    80002de8:	00f50663          	beq	a0,a5,80002df4 <consputc+0x10>
    80002dec:	00001317          	auipc	t1,0x1
    80002df0:	9f430067          	jr	-1548(t1) # 800037e0 <uartputc_sync>
    80002df4:	ff010113          	addi	sp,sp,-16
    80002df8:	00113423          	sd	ra,8(sp)
    80002dfc:	00813023          	sd	s0,0(sp)
    80002e00:	01010413          	addi	s0,sp,16
    80002e04:	00800513          	li	a0,8
    80002e08:	00001097          	auipc	ra,0x1
    80002e0c:	9d8080e7          	jalr	-1576(ra) # 800037e0 <uartputc_sync>
    80002e10:	02000513          	li	a0,32
    80002e14:	00001097          	auipc	ra,0x1
    80002e18:	9cc080e7          	jalr	-1588(ra) # 800037e0 <uartputc_sync>
    80002e1c:	00013403          	ld	s0,0(sp)
    80002e20:	00813083          	ld	ra,8(sp)
    80002e24:	00800513          	li	a0,8
    80002e28:	01010113          	addi	sp,sp,16
    80002e2c:	00001317          	auipc	t1,0x1
    80002e30:	9b430067          	jr	-1612(t1) # 800037e0 <uartputc_sync>

0000000080002e34 <consoleintr>:
    80002e34:	fe010113          	addi	sp,sp,-32
    80002e38:	00813823          	sd	s0,16(sp)
    80002e3c:	00913423          	sd	s1,8(sp)
    80002e40:	01213023          	sd	s2,0(sp)
    80002e44:	00113c23          	sd	ra,24(sp)
    80002e48:	02010413          	addi	s0,sp,32
    80002e4c:	00004917          	auipc	s2,0x4
    80002e50:	c8c90913          	addi	s2,s2,-884 # 80006ad8 <cons>
    80002e54:	00050493          	mv	s1,a0
    80002e58:	00090513          	mv	a0,s2
    80002e5c:	00001097          	auipc	ra,0x1
    80002e60:	e40080e7          	jalr	-448(ra) # 80003c9c <acquire>
    80002e64:	02048c63          	beqz	s1,80002e9c <consoleintr+0x68>
    80002e68:	0a092783          	lw	a5,160(s2)
    80002e6c:	09892703          	lw	a4,152(s2)
    80002e70:	07f00693          	li	a3,127
    80002e74:	40e7873b          	subw	a4,a5,a4
    80002e78:	02e6e263          	bltu	a3,a4,80002e9c <consoleintr+0x68>
    80002e7c:	00d00713          	li	a4,13
    80002e80:	04e48063          	beq	s1,a4,80002ec0 <consoleintr+0x8c>
    80002e84:	07f7f713          	andi	a4,a5,127
    80002e88:	00e90733          	add	a4,s2,a4
    80002e8c:	0017879b          	addiw	a5,a5,1
    80002e90:	0af92023          	sw	a5,160(s2)
    80002e94:	00970c23          	sb	s1,24(a4)
    80002e98:	08f92e23          	sw	a5,156(s2)
    80002e9c:	01013403          	ld	s0,16(sp)
    80002ea0:	01813083          	ld	ra,24(sp)
    80002ea4:	00813483          	ld	s1,8(sp)
    80002ea8:	00013903          	ld	s2,0(sp)
    80002eac:	00004517          	auipc	a0,0x4
    80002eb0:	c2c50513          	addi	a0,a0,-980 # 80006ad8 <cons>
    80002eb4:	02010113          	addi	sp,sp,32
    80002eb8:	00001317          	auipc	t1,0x1
    80002ebc:	eb030067          	jr	-336(t1) # 80003d68 <release>
    80002ec0:	00a00493          	li	s1,10
    80002ec4:	fc1ff06f          	j	80002e84 <consoleintr+0x50>

0000000080002ec8 <consoleinit>:
    80002ec8:	fe010113          	addi	sp,sp,-32
    80002ecc:	00113c23          	sd	ra,24(sp)
    80002ed0:	00813823          	sd	s0,16(sp)
    80002ed4:	00913423          	sd	s1,8(sp)
    80002ed8:	02010413          	addi	s0,sp,32
    80002edc:	00004497          	auipc	s1,0x4
    80002ee0:	bfc48493          	addi	s1,s1,-1028 # 80006ad8 <cons>
    80002ee4:	00048513          	mv	a0,s1
    80002ee8:	00002597          	auipc	a1,0x2
    80002eec:	35058593          	addi	a1,a1,848 # 80005238 <_ZZ12printIntegermE6digits+0x138>
    80002ef0:	00001097          	auipc	ra,0x1
    80002ef4:	d88080e7          	jalr	-632(ra) # 80003c78 <initlock>
    80002ef8:	00000097          	auipc	ra,0x0
    80002efc:	7ac080e7          	jalr	1964(ra) # 800036a4 <uartinit>
    80002f00:	01813083          	ld	ra,24(sp)
    80002f04:	01013403          	ld	s0,16(sp)
    80002f08:	00000797          	auipc	a5,0x0
    80002f0c:	d9c78793          	addi	a5,a5,-612 # 80002ca4 <consoleread>
    80002f10:	0af4bc23          	sd	a5,184(s1)
    80002f14:	00000797          	auipc	a5,0x0
    80002f18:	cec78793          	addi	a5,a5,-788 # 80002c00 <consolewrite>
    80002f1c:	0cf4b023          	sd	a5,192(s1)
    80002f20:	00813483          	ld	s1,8(sp)
    80002f24:	02010113          	addi	sp,sp,32
    80002f28:	00008067          	ret

0000000080002f2c <console_read>:
    80002f2c:	ff010113          	addi	sp,sp,-16
    80002f30:	00813423          	sd	s0,8(sp)
    80002f34:	01010413          	addi	s0,sp,16
    80002f38:	00813403          	ld	s0,8(sp)
    80002f3c:	00004317          	auipc	t1,0x4
    80002f40:	c5433303          	ld	t1,-940(t1) # 80006b90 <devsw+0x10>
    80002f44:	01010113          	addi	sp,sp,16
    80002f48:	00030067          	jr	t1

0000000080002f4c <console_write>:
    80002f4c:	ff010113          	addi	sp,sp,-16
    80002f50:	00813423          	sd	s0,8(sp)
    80002f54:	01010413          	addi	s0,sp,16
    80002f58:	00813403          	ld	s0,8(sp)
    80002f5c:	00004317          	auipc	t1,0x4
    80002f60:	c3c33303          	ld	t1,-964(t1) # 80006b98 <devsw+0x18>
    80002f64:	01010113          	addi	sp,sp,16
    80002f68:	00030067          	jr	t1

0000000080002f6c <panic>:
    80002f6c:	fe010113          	addi	sp,sp,-32
    80002f70:	00113c23          	sd	ra,24(sp)
    80002f74:	00813823          	sd	s0,16(sp)
    80002f78:	00913423          	sd	s1,8(sp)
    80002f7c:	02010413          	addi	s0,sp,32
    80002f80:	00050493          	mv	s1,a0
    80002f84:	00002517          	auipc	a0,0x2
    80002f88:	2bc50513          	addi	a0,a0,700 # 80005240 <_ZZ12printIntegermE6digits+0x140>
    80002f8c:	00004797          	auipc	a5,0x4
    80002f90:	ca07a623          	sw	zero,-852(a5) # 80006c38 <pr+0x18>
    80002f94:	00000097          	auipc	ra,0x0
    80002f98:	034080e7          	jalr	52(ra) # 80002fc8 <__printf>
    80002f9c:	00048513          	mv	a0,s1
    80002fa0:	00000097          	auipc	ra,0x0
    80002fa4:	028080e7          	jalr	40(ra) # 80002fc8 <__printf>
    80002fa8:	00002517          	auipc	a0,0x2
    80002fac:	0e850513          	addi	a0,a0,232 # 80005090 <CONSOLE_STATUS+0x80>
    80002fb0:	00000097          	auipc	ra,0x0
    80002fb4:	018080e7          	jalr	24(ra) # 80002fc8 <__printf>
    80002fb8:	00100793          	li	a5,1
    80002fbc:	00003717          	auipc	a4,0x3
    80002fc0:	9ef72623          	sw	a5,-1556(a4) # 800059a8 <panicked>
    80002fc4:	0000006f          	j	80002fc4 <panic+0x58>

0000000080002fc8 <__printf>:
    80002fc8:	f3010113          	addi	sp,sp,-208
    80002fcc:	08813023          	sd	s0,128(sp)
    80002fd0:	07313423          	sd	s3,104(sp)
    80002fd4:	09010413          	addi	s0,sp,144
    80002fd8:	05813023          	sd	s8,64(sp)
    80002fdc:	08113423          	sd	ra,136(sp)
    80002fe0:	06913c23          	sd	s1,120(sp)
    80002fe4:	07213823          	sd	s2,112(sp)
    80002fe8:	07413023          	sd	s4,96(sp)
    80002fec:	05513c23          	sd	s5,88(sp)
    80002ff0:	05613823          	sd	s6,80(sp)
    80002ff4:	05713423          	sd	s7,72(sp)
    80002ff8:	03913c23          	sd	s9,56(sp)
    80002ffc:	03a13823          	sd	s10,48(sp)
    80003000:	03b13423          	sd	s11,40(sp)
    80003004:	00004317          	auipc	t1,0x4
    80003008:	c1c30313          	addi	t1,t1,-996 # 80006c20 <pr>
    8000300c:	01832c03          	lw	s8,24(t1)
    80003010:	00b43423          	sd	a1,8(s0)
    80003014:	00c43823          	sd	a2,16(s0)
    80003018:	00d43c23          	sd	a3,24(s0)
    8000301c:	02e43023          	sd	a4,32(s0)
    80003020:	02f43423          	sd	a5,40(s0)
    80003024:	03043823          	sd	a6,48(s0)
    80003028:	03143c23          	sd	a7,56(s0)
    8000302c:	00050993          	mv	s3,a0
    80003030:	4a0c1663          	bnez	s8,800034dc <__printf+0x514>
    80003034:	60098c63          	beqz	s3,8000364c <__printf+0x684>
    80003038:	0009c503          	lbu	a0,0(s3)
    8000303c:	00840793          	addi	a5,s0,8
    80003040:	f6f43c23          	sd	a5,-136(s0)
    80003044:	00000493          	li	s1,0
    80003048:	22050063          	beqz	a0,80003268 <__printf+0x2a0>
    8000304c:	00002a37          	lui	s4,0x2
    80003050:	00018ab7          	lui	s5,0x18
    80003054:	000f4b37          	lui	s6,0xf4
    80003058:	00989bb7          	lui	s7,0x989
    8000305c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003060:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003064:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003068:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000306c:	00148c9b          	addiw	s9,s1,1
    80003070:	02500793          	li	a5,37
    80003074:	01998933          	add	s2,s3,s9
    80003078:	38f51263          	bne	a0,a5,800033fc <__printf+0x434>
    8000307c:	00094783          	lbu	a5,0(s2)
    80003080:	00078c9b          	sext.w	s9,a5
    80003084:	1e078263          	beqz	a5,80003268 <__printf+0x2a0>
    80003088:	0024849b          	addiw	s1,s1,2
    8000308c:	07000713          	li	a4,112
    80003090:	00998933          	add	s2,s3,s1
    80003094:	38e78a63          	beq	a5,a4,80003428 <__printf+0x460>
    80003098:	20f76863          	bltu	a4,a5,800032a8 <__printf+0x2e0>
    8000309c:	42a78863          	beq	a5,a0,800034cc <__printf+0x504>
    800030a0:	06400713          	li	a4,100
    800030a4:	40e79663          	bne	a5,a4,800034b0 <__printf+0x4e8>
    800030a8:	f7843783          	ld	a5,-136(s0)
    800030ac:	0007a603          	lw	a2,0(a5)
    800030b0:	00878793          	addi	a5,a5,8
    800030b4:	f6f43c23          	sd	a5,-136(s0)
    800030b8:	42064a63          	bltz	a2,800034ec <__printf+0x524>
    800030bc:	00a00713          	li	a4,10
    800030c0:	02e677bb          	remuw	a5,a2,a4
    800030c4:	00002d97          	auipc	s11,0x2
    800030c8:	1a4d8d93          	addi	s11,s11,420 # 80005268 <digits>
    800030cc:	00900593          	li	a1,9
    800030d0:	0006051b          	sext.w	a0,a2
    800030d4:	00000c93          	li	s9,0
    800030d8:	02079793          	slli	a5,a5,0x20
    800030dc:	0207d793          	srli	a5,a5,0x20
    800030e0:	00fd87b3          	add	a5,s11,a5
    800030e4:	0007c783          	lbu	a5,0(a5)
    800030e8:	02e656bb          	divuw	a3,a2,a4
    800030ec:	f8f40023          	sb	a5,-128(s0)
    800030f0:	14c5d863          	bge	a1,a2,80003240 <__printf+0x278>
    800030f4:	06300593          	li	a1,99
    800030f8:	00100c93          	li	s9,1
    800030fc:	02e6f7bb          	remuw	a5,a3,a4
    80003100:	02079793          	slli	a5,a5,0x20
    80003104:	0207d793          	srli	a5,a5,0x20
    80003108:	00fd87b3          	add	a5,s11,a5
    8000310c:	0007c783          	lbu	a5,0(a5)
    80003110:	02e6d73b          	divuw	a4,a3,a4
    80003114:	f8f400a3          	sb	a5,-127(s0)
    80003118:	12a5f463          	bgeu	a1,a0,80003240 <__printf+0x278>
    8000311c:	00a00693          	li	a3,10
    80003120:	00900593          	li	a1,9
    80003124:	02d777bb          	remuw	a5,a4,a3
    80003128:	02079793          	slli	a5,a5,0x20
    8000312c:	0207d793          	srli	a5,a5,0x20
    80003130:	00fd87b3          	add	a5,s11,a5
    80003134:	0007c503          	lbu	a0,0(a5)
    80003138:	02d757bb          	divuw	a5,a4,a3
    8000313c:	f8a40123          	sb	a0,-126(s0)
    80003140:	48e5f263          	bgeu	a1,a4,800035c4 <__printf+0x5fc>
    80003144:	06300513          	li	a0,99
    80003148:	02d7f5bb          	remuw	a1,a5,a3
    8000314c:	02059593          	slli	a1,a1,0x20
    80003150:	0205d593          	srli	a1,a1,0x20
    80003154:	00bd85b3          	add	a1,s11,a1
    80003158:	0005c583          	lbu	a1,0(a1)
    8000315c:	02d7d7bb          	divuw	a5,a5,a3
    80003160:	f8b401a3          	sb	a1,-125(s0)
    80003164:	48e57263          	bgeu	a0,a4,800035e8 <__printf+0x620>
    80003168:	3e700513          	li	a0,999
    8000316c:	02d7f5bb          	remuw	a1,a5,a3
    80003170:	02059593          	slli	a1,a1,0x20
    80003174:	0205d593          	srli	a1,a1,0x20
    80003178:	00bd85b3          	add	a1,s11,a1
    8000317c:	0005c583          	lbu	a1,0(a1)
    80003180:	02d7d7bb          	divuw	a5,a5,a3
    80003184:	f8b40223          	sb	a1,-124(s0)
    80003188:	46e57663          	bgeu	a0,a4,800035f4 <__printf+0x62c>
    8000318c:	02d7f5bb          	remuw	a1,a5,a3
    80003190:	02059593          	slli	a1,a1,0x20
    80003194:	0205d593          	srli	a1,a1,0x20
    80003198:	00bd85b3          	add	a1,s11,a1
    8000319c:	0005c583          	lbu	a1,0(a1)
    800031a0:	02d7d7bb          	divuw	a5,a5,a3
    800031a4:	f8b402a3          	sb	a1,-123(s0)
    800031a8:	46ea7863          	bgeu	s4,a4,80003618 <__printf+0x650>
    800031ac:	02d7f5bb          	remuw	a1,a5,a3
    800031b0:	02059593          	slli	a1,a1,0x20
    800031b4:	0205d593          	srli	a1,a1,0x20
    800031b8:	00bd85b3          	add	a1,s11,a1
    800031bc:	0005c583          	lbu	a1,0(a1)
    800031c0:	02d7d7bb          	divuw	a5,a5,a3
    800031c4:	f8b40323          	sb	a1,-122(s0)
    800031c8:	3eeaf863          	bgeu	s5,a4,800035b8 <__printf+0x5f0>
    800031cc:	02d7f5bb          	remuw	a1,a5,a3
    800031d0:	02059593          	slli	a1,a1,0x20
    800031d4:	0205d593          	srli	a1,a1,0x20
    800031d8:	00bd85b3          	add	a1,s11,a1
    800031dc:	0005c583          	lbu	a1,0(a1)
    800031e0:	02d7d7bb          	divuw	a5,a5,a3
    800031e4:	f8b403a3          	sb	a1,-121(s0)
    800031e8:	42eb7e63          	bgeu	s6,a4,80003624 <__printf+0x65c>
    800031ec:	02d7f5bb          	remuw	a1,a5,a3
    800031f0:	02059593          	slli	a1,a1,0x20
    800031f4:	0205d593          	srli	a1,a1,0x20
    800031f8:	00bd85b3          	add	a1,s11,a1
    800031fc:	0005c583          	lbu	a1,0(a1)
    80003200:	02d7d7bb          	divuw	a5,a5,a3
    80003204:	f8b40423          	sb	a1,-120(s0)
    80003208:	42ebfc63          	bgeu	s7,a4,80003640 <__printf+0x678>
    8000320c:	02079793          	slli	a5,a5,0x20
    80003210:	0207d793          	srli	a5,a5,0x20
    80003214:	00fd8db3          	add	s11,s11,a5
    80003218:	000dc703          	lbu	a4,0(s11)
    8000321c:	00a00793          	li	a5,10
    80003220:	00900c93          	li	s9,9
    80003224:	f8e404a3          	sb	a4,-119(s0)
    80003228:	00065c63          	bgez	a2,80003240 <__printf+0x278>
    8000322c:	f9040713          	addi	a4,s0,-112
    80003230:	00f70733          	add	a4,a4,a5
    80003234:	02d00693          	li	a3,45
    80003238:	fed70823          	sb	a3,-16(a4)
    8000323c:	00078c93          	mv	s9,a5
    80003240:	f8040793          	addi	a5,s0,-128
    80003244:	01978cb3          	add	s9,a5,s9
    80003248:	f7f40d13          	addi	s10,s0,-129
    8000324c:	000cc503          	lbu	a0,0(s9)
    80003250:	fffc8c93          	addi	s9,s9,-1
    80003254:	00000097          	auipc	ra,0x0
    80003258:	b90080e7          	jalr	-1136(ra) # 80002de4 <consputc>
    8000325c:	ffac98e3          	bne	s9,s10,8000324c <__printf+0x284>
    80003260:	00094503          	lbu	a0,0(s2)
    80003264:	e00514e3          	bnez	a0,8000306c <__printf+0xa4>
    80003268:	1a0c1663          	bnez	s8,80003414 <__printf+0x44c>
    8000326c:	08813083          	ld	ra,136(sp)
    80003270:	08013403          	ld	s0,128(sp)
    80003274:	07813483          	ld	s1,120(sp)
    80003278:	07013903          	ld	s2,112(sp)
    8000327c:	06813983          	ld	s3,104(sp)
    80003280:	06013a03          	ld	s4,96(sp)
    80003284:	05813a83          	ld	s5,88(sp)
    80003288:	05013b03          	ld	s6,80(sp)
    8000328c:	04813b83          	ld	s7,72(sp)
    80003290:	04013c03          	ld	s8,64(sp)
    80003294:	03813c83          	ld	s9,56(sp)
    80003298:	03013d03          	ld	s10,48(sp)
    8000329c:	02813d83          	ld	s11,40(sp)
    800032a0:	0d010113          	addi	sp,sp,208
    800032a4:	00008067          	ret
    800032a8:	07300713          	li	a4,115
    800032ac:	1ce78a63          	beq	a5,a4,80003480 <__printf+0x4b8>
    800032b0:	07800713          	li	a4,120
    800032b4:	1ee79e63          	bne	a5,a4,800034b0 <__printf+0x4e8>
    800032b8:	f7843783          	ld	a5,-136(s0)
    800032bc:	0007a703          	lw	a4,0(a5)
    800032c0:	00878793          	addi	a5,a5,8
    800032c4:	f6f43c23          	sd	a5,-136(s0)
    800032c8:	28074263          	bltz	a4,8000354c <__printf+0x584>
    800032cc:	00002d97          	auipc	s11,0x2
    800032d0:	f9cd8d93          	addi	s11,s11,-100 # 80005268 <digits>
    800032d4:	00f77793          	andi	a5,a4,15
    800032d8:	00fd87b3          	add	a5,s11,a5
    800032dc:	0007c683          	lbu	a3,0(a5)
    800032e0:	00f00613          	li	a2,15
    800032e4:	0007079b          	sext.w	a5,a4
    800032e8:	f8d40023          	sb	a3,-128(s0)
    800032ec:	0047559b          	srliw	a1,a4,0x4
    800032f0:	0047569b          	srliw	a3,a4,0x4
    800032f4:	00000c93          	li	s9,0
    800032f8:	0ee65063          	bge	a2,a4,800033d8 <__printf+0x410>
    800032fc:	00f6f693          	andi	a3,a3,15
    80003300:	00dd86b3          	add	a3,s11,a3
    80003304:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003308:	0087d79b          	srliw	a5,a5,0x8
    8000330c:	00100c93          	li	s9,1
    80003310:	f8d400a3          	sb	a3,-127(s0)
    80003314:	0cb67263          	bgeu	a2,a1,800033d8 <__printf+0x410>
    80003318:	00f7f693          	andi	a3,a5,15
    8000331c:	00dd86b3          	add	a3,s11,a3
    80003320:	0006c583          	lbu	a1,0(a3)
    80003324:	00f00613          	li	a2,15
    80003328:	0047d69b          	srliw	a3,a5,0x4
    8000332c:	f8b40123          	sb	a1,-126(s0)
    80003330:	0047d593          	srli	a1,a5,0x4
    80003334:	28f67e63          	bgeu	a2,a5,800035d0 <__printf+0x608>
    80003338:	00f6f693          	andi	a3,a3,15
    8000333c:	00dd86b3          	add	a3,s11,a3
    80003340:	0006c503          	lbu	a0,0(a3)
    80003344:	0087d813          	srli	a6,a5,0x8
    80003348:	0087d69b          	srliw	a3,a5,0x8
    8000334c:	f8a401a3          	sb	a0,-125(s0)
    80003350:	28b67663          	bgeu	a2,a1,800035dc <__printf+0x614>
    80003354:	00f6f693          	andi	a3,a3,15
    80003358:	00dd86b3          	add	a3,s11,a3
    8000335c:	0006c583          	lbu	a1,0(a3)
    80003360:	00c7d513          	srli	a0,a5,0xc
    80003364:	00c7d69b          	srliw	a3,a5,0xc
    80003368:	f8b40223          	sb	a1,-124(s0)
    8000336c:	29067a63          	bgeu	a2,a6,80003600 <__printf+0x638>
    80003370:	00f6f693          	andi	a3,a3,15
    80003374:	00dd86b3          	add	a3,s11,a3
    80003378:	0006c583          	lbu	a1,0(a3)
    8000337c:	0107d813          	srli	a6,a5,0x10
    80003380:	0107d69b          	srliw	a3,a5,0x10
    80003384:	f8b402a3          	sb	a1,-123(s0)
    80003388:	28a67263          	bgeu	a2,a0,8000360c <__printf+0x644>
    8000338c:	00f6f693          	andi	a3,a3,15
    80003390:	00dd86b3          	add	a3,s11,a3
    80003394:	0006c683          	lbu	a3,0(a3)
    80003398:	0147d79b          	srliw	a5,a5,0x14
    8000339c:	f8d40323          	sb	a3,-122(s0)
    800033a0:	21067663          	bgeu	a2,a6,800035ac <__printf+0x5e4>
    800033a4:	02079793          	slli	a5,a5,0x20
    800033a8:	0207d793          	srli	a5,a5,0x20
    800033ac:	00fd8db3          	add	s11,s11,a5
    800033b0:	000dc683          	lbu	a3,0(s11)
    800033b4:	00800793          	li	a5,8
    800033b8:	00700c93          	li	s9,7
    800033bc:	f8d403a3          	sb	a3,-121(s0)
    800033c0:	00075c63          	bgez	a4,800033d8 <__printf+0x410>
    800033c4:	f9040713          	addi	a4,s0,-112
    800033c8:	00f70733          	add	a4,a4,a5
    800033cc:	02d00693          	li	a3,45
    800033d0:	fed70823          	sb	a3,-16(a4)
    800033d4:	00078c93          	mv	s9,a5
    800033d8:	f8040793          	addi	a5,s0,-128
    800033dc:	01978cb3          	add	s9,a5,s9
    800033e0:	f7f40d13          	addi	s10,s0,-129
    800033e4:	000cc503          	lbu	a0,0(s9)
    800033e8:	fffc8c93          	addi	s9,s9,-1
    800033ec:	00000097          	auipc	ra,0x0
    800033f0:	9f8080e7          	jalr	-1544(ra) # 80002de4 <consputc>
    800033f4:	ff9d18e3          	bne	s10,s9,800033e4 <__printf+0x41c>
    800033f8:	0100006f          	j	80003408 <__printf+0x440>
    800033fc:	00000097          	auipc	ra,0x0
    80003400:	9e8080e7          	jalr	-1560(ra) # 80002de4 <consputc>
    80003404:	000c8493          	mv	s1,s9
    80003408:	00094503          	lbu	a0,0(s2)
    8000340c:	c60510e3          	bnez	a0,8000306c <__printf+0xa4>
    80003410:	e40c0ee3          	beqz	s8,8000326c <__printf+0x2a4>
    80003414:	00004517          	auipc	a0,0x4
    80003418:	80c50513          	addi	a0,a0,-2036 # 80006c20 <pr>
    8000341c:	00001097          	auipc	ra,0x1
    80003420:	94c080e7          	jalr	-1716(ra) # 80003d68 <release>
    80003424:	e49ff06f          	j	8000326c <__printf+0x2a4>
    80003428:	f7843783          	ld	a5,-136(s0)
    8000342c:	03000513          	li	a0,48
    80003430:	01000d13          	li	s10,16
    80003434:	00878713          	addi	a4,a5,8
    80003438:	0007bc83          	ld	s9,0(a5)
    8000343c:	f6e43c23          	sd	a4,-136(s0)
    80003440:	00000097          	auipc	ra,0x0
    80003444:	9a4080e7          	jalr	-1628(ra) # 80002de4 <consputc>
    80003448:	07800513          	li	a0,120
    8000344c:	00000097          	auipc	ra,0x0
    80003450:	998080e7          	jalr	-1640(ra) # 80002de4 <consputc>
    80003454:	00002d97          	auipc	s11,0x2
    80003458:	e14d8d93          	addi	s11,s11,-492 # 80005268 <digits>
    8000345c:	03ccd793          	srli	a5,s9,0x3c
    80003460:	00fd87b3          	add	a5,s11,a5
    80003464:	0007c503          	lbu	a0,0(a5)
    80003468:	fffd0d1b          	addiw	s10,s10,-1
    8000346c:	004c9c93          	slli	s9,s9,0x4
    80003470:	00000097          	auipc	ra,0x0
    80003474:	974080e7          	jalr	-1676(ra) # 80002de4 <consputc>
    80003478:	fe0d12e3          	bnez	s10,8000345c <__printf+0x494>
    8000347c:	f8dff06f          	j	80003408 <__printf+0x440>
    80003480:	f7843783          	ld	a5,-136(s0)
    80003484:	0007bc83          	ld	s9,0(a5)
    80003488:	00878793          	addi	a5,a5,8
    8000348c:	f6f43c23          	sd	a5,-136(s0)
    80003490:	000c9a63          	bnez	s9,800034a4 <__printf+0x4dc>
    80003494:	1080006f          	j	8000359c <__printf+0x5d4>
    80003498:	001c8c93          	addi	s9,s9,1
    8000349c:	00000097          	auipc	ra,0x0
    800034a0:	948080e7          	jalr	-1720(ra) # 80002de4 <consputc>
    800034a4:	000cc503          	lbu	a0,0(s9)
    800034a8:	fe0518e3          	bnez	a0,80003498 <__printf+0x4d0>
    800034ac:	f5dff06f          	j	80003408 <__printf+0x440>
    800034b0:	02500513          	li	a0,37
    800034b4:	00000097          	auipc	ra,0x0
    800034b8:	930080e7          	jalr	-1744(ra) # 80002de4 <consputc>
    800034bc:	000c8513          	mv	a0,s9
    800034c0:	00000097          	auipc	ra,0x0
    800034c4:	924080e7          	jalr	-1756(ra) # 80002de4 <consputc>
    800034c8:	f41ff06f          	j	80003408 <__printf+0x440>
    800034cc:	02500513          	li	a0,37
    800034d0:	00000097          	auipc	ra,0x0
    800034d4:	914080e7          	jalr	-1772(ra) # 80002de4 <consputc>
    800034d8:	f31ff06f          	j	80003408 <__printf+0x440>
    800034dc:	00030513          	mv	a0,t1
    800034e0:	00000097          	auipc	ra,0x0
    800034e4:	7bc080e7          	jalr	1980(ra) # 80003c9c <acquire>
    800034e8:	b4dff06f          	j	80003034 <__printf+0x6c>
    800034ec:	40c0053b          	negw	a0,a2
    800034f0:	00a00713          	li	a4,10
    800034f4:	02e576bb          	remuw	a3,a0,a4
    800034f8:	00002d97          	auipc	s11,0x2
    800034fc:	d70d8d93          	addi	s11,s11,-656 # 80005268 <digits>
    80003500:	ff700593          	li	a1,-9
    80003504:	02069693          	slli	a3,a3,0x20
    80003508:	0206d693          	srli	a3,a3,0x20
    8000350c:	00dd86b3          	add	a3,s11,a3
    80003510:	0006c683          	lbu	a3,0(a3)
    80003514:	02e557bb          	divuw	a5,a0,a4
    80003518:	f8d40023          	sb	a3,-128(s0)
    8000351c:	10b65e63          	bge	a2,a1,80003638 <__printf+0x670>
    80003520:	06300593          	li	a1,99
    80003524:	02e7f6bb          	remuw	a3,a5,a4
    80003528:	02069693          	slli	a3,a3,0x20
    8000352c:	0206d693          	srli	a3,a3,0x20
    80003530:	00dd86b3          	add	a3,s11,a3
    80003534:	0006c683          	lbu	a3,0(a3)
    80003538:	02e7d73b          	divuw	a4,a5,a4
    8000353c:	00200793          	li	a5,2
    80003540:	f8d400a3          	sb	a3,-127(s0)
    80003544:	bca5ece3          	bltu	a1,a0,8000311c <__printf+0x154>
    80003548:	ce5ff06f          	j	8000322c <__printf+0x264>
    8000354c:	40e007bb          	negw	a5,a4
    80003550:	00002d97          	auipc	s11,0x2
    80003554:	d18d8d93          	addi	s11,s11,-744 # 80005268 <digits>
    80003558:	00f7f693          	andi	a3,a5,15
    8000355c:	00dd86b3          	add	a3,s11,a3
    80003560:	0006c583          	lbu	a1,0(a3)
    80003564:	ff100613          	li	a2,-15
    80003568:	0047d69b          	srliw	a3,a5,0x4
    8000356c:	f8b40023          	sb	a1,-128(s0)
    80003570:	0047d59b          	srliw	a1,a5,0x4
    80003574:	0ac75e63          	bge	a4,a2,80003630 <__printf+0x668>
    80003578:	00f6f693          	andi	a3,a3,15
    8000357c:	00dd86b3          	add	a3,s11,a3
    80003580:	0006c603          	lbu	a2,0(a3)
    80003584:	00f00693          	li	a3,15
    80003588:	0087d79b          	srliw	a5,a5,0x8
    8000358c:	f8c400a3          	sb	a2,-127(s0)
    80003590:	d8b6e4e3          	bltu	a3,a1,80003318 <__printf+0x350>
    80003594:	00200793          	li	a5,2
    80003598:	e2dff06f          	j	800033c4 <__printf+0x3fc>
    8000359c:	00002c97          	auipc	s9,0x2
    800035a0:	cacc8c93          	addi	s9,s9,-852 # 80005248 <_ZZ12printIntegermE6digits+0x148>
    800035a4:	02800513          	li	a0,40
    800035a8:	ef1ff06f          	j	80003498 <__printf+0x4d0>
    800035ac:	00700793          	li	a5,7
    800035b0:	00600c93          	li	s9,6
    800035b4:	e0dff06f          	j	800033c0 <__printf+0x3f8>
    800035b8:	00700793          	li	a5,7
    800035bc:	00600c93          	li	s9,6
    800035c0:	c69ff06f          	j	80003228 <__printf+0x260>
    800035c4:	00300793          	li	a5,3
    800035c8:	00200c93          	li	s9,2
    800035cc:	c5dff06f          	j	80003228 <__printf+0x260>
    800035d0:	00300793          	li	a5,3
    800035d4:	00200c93          	li	s9,2
    800035d8:	de9ff06f          	j	800033c0 <__printf+0x3f8>
    800035dc:	00400793          	li	a5,4
    800035e0:	00300c93          	li	s9,3
    800035e4:	dddff06f          	j	800033c0 <__printf+0x3f8>
    800035e8:	00400793          	li	a5,4
    800035ec:	00300c93          	li	s9,3
    800035f0:	c39ff06f          	j	80003228 <__printf+0x260>
    800035f4:	00500793          	li	a5,5
    800035f8:	00400c93          	li	s9,4
    800035fc:	c2dff06f          	j	80003228 <__printf+0x260>
    80003600:	00500793          	li	a5,5
    80003604:	00400c93          	li	s9,4
    80003608:	db9ff06f          	j	800033c0 <__printf+0x3f8>
    8000360c:	00600793          	li	a5,6
    80003610:	00500c93          	li	s9,5
    80003614:	dadff06f          	j	800033c0 <__printf+0x3f8>
    80003618:	00600793          	li	a5,6
    8000361c:	00500c93          	li	s9,5
    80003620:	c09ff06f          	j	80003228 <__printf+0x260>
    80003624:	00800793          	li	a5,8
    80003628:	00700c93          	li	s9,7
    8000362c:	bfdff06f          	j	80003228 <__printf+0x260>
    80003630:	00100793          	li	a5,1
    80003634:	d91ff06f          	j	800033c4 <__printf+0x3fc>
    80003638:	00100793          	li	a5,1
    8000363c:	bf1ff06f          	j	8000322c <__printf+0x264>
    80003640:	00900793          	li	a5,9
    80003644:	00800c93          	li	s9,8
    80003648:	be1ff06f          	j	80003228 <__printf+0x260>
    8000364c:	00002517          	auipc	a0,0x2
    80003650:	c0450513          	addi	a0,a0,-1020 # 80005250 <_ZZ12printIntegermE6digits+0x150>
    80003654:	00000097          	auipc	ra,0x0
    80003658:	918080e7          	jalr	-1768(ra) # 80002f6c <panic>

000000008000365c <printfinit>:
    8000365c:	fe010113          	addi	sp,sp,-32
    80003660:	00813823          	sd	s0,16(sp)
    80003664:	00913423          	sd	s1,8(sp)
    80003668:	00113c23          	sd	ra,24(sp)
    8000366c:	02010413          	addi	s0,sp,32
    80003670:	00003497          	auipc	s1,0x3
    80003674:	5b048493          	addi	s1,s1,1456 # 80006c20 <pr>
    80003678:	00048513          	mv	a0,s1
    8000367c:	00002597          	auipc	a1,0x2
    80003680:	be458593          	addi	a1,a1,-1052 # 80005260 <_ZZ12printIntegermE6digits+0x160>
    80003684:	00000097          	auipc	ra,0x0
    80003688:	5f4080e7          	jalr	1524(ra) # 80003c78 <initlock>
    8000368c:	01813083          	ld	ra,24(sp)
    80003690:	01013403          	ld	s0,16(sp)
    80003694:	0004ac23          	sw	zero,24(s1)
    80003698:	00813483          	ld	s1,8(sp)
    8000369c:	02010113          	addi	sp,sp,32
    800036a0:	00008067          	ret

00000000800036a4 <uartinit>:
    800036a4:	ff010113          	addi	sp,sp,-16
    800036a8:	00813423          	sd	s0,8(sp)
    800036ac:	01010413          	addi	s0,sp,16
    800036b0:	100007b7          	lui	a5,0x10000
    800036b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800036b8:	f8000713          	li	a4,-128
    800036bc:	00e781a3          	sb	a4,3(a5)
    800036c0:	00300713          	li	a4,3
    800036c4:	00e78023          	sb	a4,0(a5)
    800036c8:	000780a3          	sb	zero,1(a5)
    800036cc:	00e781a3          	sb	a4,3(a5)
    800036d0:	00700693          	li	a3,7
    800036d4:	00d78123          	sb	a3,2(a5)
    800036d8:	00e780a3          	sb	a4,1(a5)
    800036dc:	00813403          	ld	s0,8(sp)
    800036e0:	01010113          	addi	sp,sp,16
    800036e4:	00008067          	ret

00000000800036e8 <uartputc>:
    800036e8:	00002797          	auipc	a5,0x2
    800036ec:	2c07a783          	lw	a5,704(a5) # 800059a8 <panicked>
    800036f0:	00078463          	beqz	a5,800036f8 <uartputc+0x10>
    800036f4:	0000006f          	j	800036f4 <uartputc+0xc>
    800036f8:	fd010113          	addi	sp,sp,-48
    800036fc:	02813023          	sd	s0,32(sp)
    80003700:	00913c23          	sd	s1,24(sp)
    80003704:	01213823          	sd	s2,16(sp)
    80003708:	01313423          	sd	s3,8(sp)
    8000370c:	02113423          	sd	ra,40(sp)
    80003710:	03010413          	addi	s0,sp,48
    80003714:	00002917          	auipc	s2,0x2
    80003718:	29c90913          	addi	s2,s2,668 # 800059b0 <uart_tx_r>
    8000371c:	00093783          	ld	a5,0(s2)
    80003720:	00002497          	auipc	s1,0x2
    80003724:	29848493          	addi	s1,s1,664 # 800059b8 <uart_tx_w>
    80003728:	0004b703          	ld	a4,0(s1)
    8000372c:	02078693          	addi	a3,a5,32
    80003730:	00050993          	mv	s3,a0
    80003734:	02e69c63          	bne	a3,a4,8000376c <uartputc+0x84>
    80003738:	00001097          	auipc	ra,0x1
    8000373c:	834080e7          	jalr	-1996(ra) # 80003f6c <push_on>
    80003740:	00093783          	ld	a5,0(s2)
    80003744:	0004b703          	ld	a4,0(s1)
    80003748:	02078793          	addi	a5,a5,32
    8000374c:	00e79463          	bne	a5,a4,80003754 <uartputc+0x6c>
    80003750:	0000006f          	j	80003750 <uartputc+0x68>
    80003754:	00001097          	auipc	ra,0x1
    80003758:	88c080e7          	jalr	-1908(ra) # 80003fe0 <pop_on>
    8000375c:	00093783          	ld	a5,0(s2)
    80003760:	0004b703          	ld	a4,0(s1)
    80003764:	02078693          	addi	a3,a5,32
    80003768:	fce688e3          	beq	a3,a4,80003738 <uartputc+0x50>
    8000376c:	01f77693          	andi	a3,a4,31
    80003770:	00003597          	auipc	a1,0x3
    80003774:	4d058593          	addi	a1,a1,1232 # 80006c40 <uart_tx_buf>
    80003778:	00d586b3          	add	a3,a1,a3
    8000377c:	00170713          	addi	a4,a4,1
    80003780:	01368023          	sb	s3,0(a3)
    80003784:	00e4b023          	sd	a4,0(s1)
    80003788:	10000637          	lui	a2,0x10000
    8000378c:	02f71063          	bne	a4,a5,800037ac <uartputc+0xc4>
    80003790:	0340006f          	j	800037c4 <uartputc+0xdc>
    80003794:	00074703          	lbu	a4,0(a4)
    80003798:	00f93023          	sd	a5,0(s2)
    8000379c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800037a0:	00093783          	ld	a5,0(s2)
    800037a4:	0004b703          	ld	a4,0(s1)
    800037a8:	00f70e63          	beq	a4,a5,800037c4 <uartputc+0xdc>
    800037ac:	00564683          	lbu	a3,5(a2)
    800037b0:	01f7f713          	andi	a4,a5,31
    800037b4:	00e58733          	add	a4,a1,a4
    800037b8:	0206f693          	andi	a3,a3,32
    800037bc:	00178793          	addi	a5,a5,1
    800037c0:	fc069ae3          	bnez	a3,80003794 <uartputc+0xac>
    800037c4:	02813083          	ld	ra,40(sp)
    800037c8:	02013403          	ld	s0,32(sp)
    800037cc:	01813483          	ld	s1,24(sp)
    800037d0:	01013903          	ld	s2,16(sp)
    800037d4:	00813983          	ld	s3,8(sp)
    800037d8:	03010113          	addi	sp,sp,48
    800037dc:	00008067          	ret

00000000800037e0 <uartputc_sync>:
    800037e0:	ff010113          	addi	sp,sp,-16
    800037e4:	00813423          	sd	s0,8(sp)
    800037e8:	01010413          	addi	s0,sp,16
    800037ec:	00002717          	auipc	a4,0x2
    800037f0:	1bc72703          	lw	a4,444(a4) # 800059a8 <panicked>
    800037f4:	02071663          	bnez	a4,80003820 <uartputc_sync+0x40>
    800037f8:	00050793          	mv	a5,a0
    800037fc:	100006b7          	lui	a3,0x10000
    80003800:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003804:	02077713          	andi	a4,a4,32
    80003808:	fe070ce3          	beqz	a4,80003800 <uartputc_sync+0x20>
    8000380c:	0ff7f793          	andi	a5,a5,255
    80003810:	00f68023          	sb	a5,0(a3)
    80003814:	00813403          	ld	s0,8(sp)
    80003818:	01010113          	addi	sp,sp,16
    8000381c:	00008067          	ret
    80003820:	0000006f          	j	80003820 <uartputc_sync+0x40>

0000000080003824 <uartstart>:
    80003824:	ff010113          	addi	sp,sp,-16
    80003828:	00813423          	sd	s0,8(sp)
    8000382c:	01010413          	addi	s0,sp,16
    80003830:	00002617          	auipc	a2,0x2
    80003834:	18060613          	addi	a2,a2,384 # 800059b0 <uart_tx_r>
    80003838:	00002517          	auipc	a0,0x2
    8000383c:	18050513          	addi	a0,a0,384 # 800059b8 <uart_tx_w>
    80003840:	00063783          	ld	a5,0(a2)
    80003844:	00053703          	ld	a4,0(a0)
    80003848:	04f70263          	beq	a4,a5,8000388c <uartstart+0x68>
    8000384c:	100005b7          	lui	a1,0x10000
    80003850:	00003817          	auipc	a6,0x3
    80003854:	3f080813          	addi	a6,a6,1008 # 80006c40 <uart_tx_buf>
    80003858:	01c0006f          	j	80003874 <uartstart+0x50>
    8000385c:	0006c703          	lbu	a4,0(a3)
    80003860:	00f63023          	sd	a5,0(a2)
    80003864:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003868:	00063783          	ld	a5,0(a2)
    8000386c:	00053703          	ld	a4,0(a0)
    80003870:	00f70e63          	beq	a4,a5,8000388c <uartstart+0x68>
    80003874:	01f7f713          	andi	a4,a5,31
    80003878:	00e806b3          	add	a3,a6,a4
    8000387c:	0055c703          	lbu	a4,5(a1)
    80003880:	00178793          	addi	a5,a5,1
    80003884:	02077713          	andi	a4,a4,32
    80003888:	fc071ae3          	bnez	a4,8000385c <uartstart+0x38>
    8000388c:	00813403          	ld	s0,8(sp)
    80003890:	01010113          	addi	sp,sp,16
    80003894:	00008067          	ret

0000000080003898 <uartgetc>:
    80003898:	ff010113          	addi	sp,sp,-16
    8000389c:	00813423          	sd	s0,8(sp)
    800038a0:	01010413          	addi	s0,sp,16
    800038a4:	10000737          	lui	a4,0x10000
    800038a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800038ac:	0017f793          	andi	a5,a5,1
    800038b0:	00078c63          	beqz	a5,800038c8 <uartgetc+0x30>
    800038b4:	00074503          	lbu	a0,0(a4)
    800038b8:	0ff57513          	andi	a0,a0,255
    800038bc:	00813403          	ld	s0,8(sp)
    800038c0:	01010113          	addi	sp,sp,16
    800038c4:	00008067          	ret
    800038c8:	fff00513          	li	a0,-1
    800038cc:	ff1ff06f          	j	800038bc <uartgetc+0x24>

00000000800038d0 <uartintr>:
    800038d0:	100007b7          	lui	a5,0x10000
    800038d4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800038d8:	0017f793          	andi	a5,a5,1
    800038dc:	0a078463          	beqz	a5,80003984 <uartintr+0xb4>
    800038e0:	fe010113          	addi	sp,sp,-32
    800038e4:	00813823          	sd	s0,16(sp)
    800038e8:	00913423          	sd	s1,8(sp)
    800038ec:	00113c23          	sd	ra,24(sp)
    800038f0:	02010413          	addi	s0,sp,32
    800038f4:	100004b7          	lui	s1,0x10000
    800038f8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800038fc:	0ff57513          	andi	a0,a0,255
    80003900:	fffff097          	auipc	ra,0xfffff
    80003904:	534080e7          	jalr	1332(ra) # 80002e34 <consoleintr>
    80003908:	0054c783          	lbu	a5,5(s1)
    8000390c:	0017f793          	andi	a5,a5,1
    80003910:	fe0794e3          	bnez	a5,800038f8 <uartintr+0x28>
    80003914:	00002617          	auipc	a2,0x2
    80003918:	09c60613          	addi	a2,a2,156 # 800059b0 <uart_tx_r>
    8000391c:	00002517          	auipc	a0,0x2
    80003920:	09c50513          	addi	a0,a0,156 # 800059b8 <uart_tx_w>
    80003924:	00063783          	ld	a5,0(a2)
    80003928:	00053703          	ld	a4,0(a0)
    8000392c:	04f70263          	beq	a4,a5,80003970 <uartintr+0xa0>
    80003930:	100005b7          	lui	a1,0x10000
    80003934:	00003817          	auipc	a6,0x3
    80003938:	30c80813          	addi	a6,a6,780 # 80006c40 <uart_tx_buf>
    8000393c:	01c0006f          	j	80003958 <uartintr+0x88>
    80003940:	0006c703          	lbu	a4,0(a3)
    80003944:	00f63023          	sd	a5,0(a2)
    80003948:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000394c:	00063783          	ld	a5,0(a2)
    80003950:	00053703          	ld	a4,0(a0)
    80003954:	00f70e63          	beq	a4,a5,80003970 <uartintr+0xa0>
    80003958:	01f7f713          	andi	a4,a5,31
    8000395c:	00e806b3          	add	a3,a6,a4
    80003960:	0055c703          	lbu	a4,5(a1)
    80003964:	00178793          	addi	a5,a5,1
    80003968:	02077713          	andi	a4,a4,32
    8000396c:	fc071ae3          	bnez	a4,80003940 <uartintr+0x70>
    80003970:	01813083          	ld	ra,24(sp)
    80003974:	01013403          	ld	s0,16(sp)
    80003978:	00813483          	ld	s1,8(sp)
    8000397c:	02010113          	addi	sp,sp,32
    80003980:	00008067          	ret
    80003984:	00002617          	auipc	a2,0x2
    80003988:	02c60613          	addi	a2,a2,44 # 800059b0 <uart_tx_r>
    8000398c:	00002517          	auipc	a0,0x2
    80003990:	02c50513          	addi	a0,a0,44 # 800059b8 <uart_tx_w>
    80003994:	00063783          	ld	a5,0(a2)
    80003998:	00053703          	ld	a4,0(a0)
    8000399c:	04f70263          	beq	a4,a5,800039e0 <uartintr+0x110>
    800039a0:	100005b7          	lui	a1,0x10000
    800039a4:	00003817          	auipc	a6,0x3
    800039a8:	29c80813          	addi	a6,a6,668 # 80006c40 <uart_tx_buf>
    800039ac:	01c0006f          	j	800039c8 <uartintr+0xf8>
    800039b0:	0006c703          	lbu	a4,0(a3)
    800039b4:	00f63023          	sd	a5,0(a2)
    800039b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800039bc:	00063783          	ld	a5,0(a2)
    800039c0:	00053703          	ld	a4,0(a0)
    800039c4:	02f70063          	beq	a4,a5,800039e4 <uartintr+0x114>
    800039c8:	01f7f713          	andi	a4,a5,31
    800039cc:	00e806b3          	add	a3,a6,a4
    800039d0:	0055c703          	lbu	a4,5(a1)
    800039d4:	00178793          	addi	a5,a5,1
    800039d8:	02077713          	andi	a4,a4,32
    800039dc:	fc071ae3          	bnez	a4,800039b0 <uartintr+0xe0>
    800039e0:	00008067          	ret
    800039e4:	00008067          	ret

00000000800039e8 <kinit>:
    800039e8:	fc010113          	addi	sp,sp,-64
    800039ec:	02913423          	sd	s1,40(sp)
    800039f0:	fffff7b7          	lui	a5,0xfffff
    800039f4:	00004497          	auipc	s1,0x4
    800039f8:	26b48493          	addi	s1,s1,619 # 80007c5f <end+0xfff>
    800039fc:	02813823          	sd	s0,48(sp)
    80003a00:	01313c23          	sd	s3,24(sp)
    80003a04:	00f4f4b3          	and	s1,s1,a5
    80003a08:	02113c23          	sd	ra,56(sp)
    80003a0c:	03213023          	sd	s2,32(sp)
    80003a10:	01413823          	sd	s4,16(sp)
    80003a14:	01513423          	sd	s5,8(sp)
    80003a18:	04010413          	addi	s0,sp,64
    80003a1c:	000017b7          	lui	a5,0x1
    80003a20:	01100993          	li	s3,17
    80003a24:	00f487b3          	add	a5,s1,a5
    80003a28:	01b99993          	slli	s3,s3,0x1b
    80003a2c:	06f9e063          	bltu	s3,a5,80003a8c <kinit+0xa4>
    80003a30:	00003a97          	auipc	s5,0x3
    80003a34:	230a8a93          	addi	s5,s5,560 # 80006c60 <end>
    80003a38:	0754ec63          	bltu	s1,s5,80003ab0 <kinit+0xc8>
    80003a3c:	0734fa63          	bgeu	s1,s3,80003ab0 <kinit+0xc8>
    80003a40:	00088a37          	lui	s4,0x88
    80003a44:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003a48:	00002917          	auipc	s2,0x2
    80003a4c:	f7890913          	addi	s2,s2,-136 # 800059c0 <kmem>
    80003a50:	00ca1a13          	slli	s4,s4,0xc
    80003a54:	0140006f          	j	80003a68 <kinit+0x80>
    80003a58:	000017b7          	lui	a5,0x1
    80003a5c:	00f484b3          	add	s1,s1,a5
    80003a60:	0554e863          	bltu	s1,s5,80003ab0 <kinit+0xc8>
    80003a64:	0534f663          	bgeu	s1,s3,80003ab0 <kinit+0xc8>
    80003a68:	00001637          	lui	a2,0x1
    80003a6c:	00100593          	li	a1,1
    80003a70:	00048513          	mv	a0,s1
    80003a74:	00000097          	auipc	ra,0x0
    80003a78:	5e4080e7          	jalr	1508(ra) # 80004058 <__memset>
    80003a7c:	00093783          	ld	a5,0(s2)
    80003a80:	00f4b023          	sd	a5,0(s1)
    80003a84:	00993023          	sd	s1,0(s2)
    80003a88:	fd4498e3          	bne	s1,s4,80003a58 <kinit+0x70>
    80003a8c:	03813083          	ld	ra,56(sp)
    80003a90:	03013403          	ld	s0,48(sp)
    80003a94:	02813483          	ld	s1,40(sp)
    80003a98:	02013903          	ld	s2,32(sp)
    80003a9c:	01813983          	ld	s3,24(sp)
    80003aa0:	01013a03          	ld	s4,16(sp)
    80003aa4:	00813a83          	ld	s5,8(sp)
    80003aa8:	04010113          	addi	sp,sp,64
    80003aac:	00008067          	ret
    80003ab0:	00001517          	auipc	a0,0x1
    80003ab4:	7d050513          	addi	a0,a0,2000 # 80005280 <digits+0x18>
    80003ab8:	fffff097          	auipc	ra,0xfffff
    80003abc:	4b4080e7          	jalr	1204(ra) # 80002f6c <panic>

0000000080003ac0 <freerange>:
    80003ac0:	fc010113          	addi	sp,sp,-64
    80003ac4:	000017b7          	lui	a5,0x1
    80003ac8:	02913423          	sd	s1,40(sp)
    80003acc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003ad0:	009504b3          	add	s1,a0,s1
    80003ad4:	fffff537          	lui	a0,0xfffff
    80003ad8:	02813823          	sd	s0,48(sp)
    80003adc:	02113c23          	sd	ra,56(sp)
    80003ae0:	03213023          	sd	s2,32(sp)
    80003ae4:	01313c23          	sd	s3,24(sp)
    80003ae8:	01413823          	sd	s4,16(sp)
    80003aec:	01513423          	sd	s5,8(sp)
    80003af0:	01613023          	sd	s6,0(sp)
    80003af4:	04010413          	addi	s0,sp,64
    80003af8:	00a4f4b3          	and	s1,s1,a0
    80003afc:	00f487b3          	add	a5,s1,a5
    80003b00:	06f5e463          	bltu	a1,a5,80003b68 <freerange+0xa8>
    80003b04:	00003a97          	auipc	s5,0x3
    80003b08:	15ca8a93          	addi	s5,s5,348 # 80006c60 <end>
    80003b0c:	0954e263          	bltu	s1,s5,80003b90 <freerange+0xd0>
    80003b10:	01100993          	li	s3,17
    80003b14:	01b99993          	slli	s3,s3,0x1b
    80003b18:	0734fc63          	bgeu	s1,s3,80003b90 <freerange+0xd0>
    80003b1c:	00058a13          	mv	s4,a1
    80003b20:	00002917          	auipc	s2,0x2
    80003b24:	ea090913          	addi	s2,s2,-352 # 800059c0 <kmem>
    80003b28:	00002b37          	lui	s6,0x2
    80003b2c:	0140006f          	j	80003b40 <freerange+0x80>
    80003b30:	000017b7          	lui	a5,0x1
    80003b34:	00f484b3          	add	s1,s1,a5
    80003b38:	0554ec63          	bltu	s1,s5,80003b90 <freerange+0xd0>
    80003b3c:	0534fa63          	bgeu	s1,s3,80003b90 <freerange+0xd0>
    80003b40:	00001637          	lui	a2,0x1
    80003b44:	00100593          	li	a1,1
    80003b48:	00048513          	mv	a0,s1
    80003b4c:	00000097          	auipc	ra,0x0
    80003b50:	50c080e7          	jalr	1292(ra) # 80004058 <__memset>
    80003b54:	00093703          	ld	a4,0(s2)
    80003b58:	016487b3          	add	a5,s1,s6
    80003b5c:	00e4b023          	sd	a4,0(s1)
    80003b60:	00993023          	sd	s1,0(s2)
    80003b64:	fcfa76e3          	bgeu	s4,a5,80003b30 <freerange+0x70>
    80003b68:	03813083          	ld	ra,56(sp)
    80003b6c:	03013403          	ld	s0,48(sp)
    80003b70:	02813483          	ld	s1,40(sp)
    80003b74:	02013903          	ld	s2,32(sp)
    80003b78:	01813983          	ld	s3,24(sp)
    80003b7c:	01013a03          	ld	s4,16(sp)
    80003b80:	00813a83          	ld	s5,8(sp)
    80003b84:	00013b03          	ld	s6,0(sp)
    80003b88:	04010113          	addi	sp,sp,64
    80003b8c:	00008067          	ret
    80003b90:	00001517          	auipc	a0,0x1
    80003b94:	6f050513          	addi	a0,a0,1776 # 80005280 <digits+0x18>
    80003b98:	fffff097          	auipc	ra,0xfffff
    80003b9c:	3d4080e7          	jalr	980(ra) # 80002f6c <panic>

0000000080003ba0 <kfree>:
    80003ba0:	fe010113          	addi	sp,sp,-32
    80003ba4:	00813823          	sd	s0,16(sp)
    80003ba8:	00113c23          	sd	ra,24(sp)
    80003bac:	00913423          	sd	s1,8(sp)
    80003bb0:	02010413          	addi	s0,sp,32
    80003bb4:	03451793          	slli	a5,a0,0x34
    80003bb8:	04079c63          	bnez	a5,80003c10 <kfree+0x70>
    80003bbc:	00003797          	auipc	a5,0x3
    80003bc0:	0a478793          	addi	a5,a5,164 # 80006c60 <end>
    80003bc4:	00050493          	mv	s1,a0
    80003bc8:	04f56463          	bltu	a0,a5,80003c10 <kfree+0x70>
    80003bcc:	01100793          	li	a5,17
    80003bd0:	01b79793          	slli	a5,a5,0x1b
    80003bd4:	02f57e63          	bgeu	a0,a5,80003c10 <kfree+0x70>
    80003bd8:	00001637          	lui	a2,0x1
    80003bdc:	00100593          	li	a1,1
    80003be0:	00000097          	auipc	ra,0x0
    80003be4:	478080e7          	jalr	1144(ra) # 80004058 <__memset>
    80003be8:	00002797          	auipc	a5,0x2
    80003bec:	dd878793          	addi	a5,a5,-552 # 800059c0 <kmem>
    80003bf0:	0007b703          	ld	a4,0(a5)
    80003bf4:	01813083          	ld	ra,24(sp)
    80003bf8:	01013403          	ld	s0,16(sp)
    80003bfc:	00e4b023          	sd	a4,0(s1)
    80003c00:	0097b023          	sd	s1,0(a5)
    80003c04:	00813483          	ld	s1,8(sp)
    80003c08:	02010113          	addi	sp,sp,32
    80003c0c:	00008067          	ret
    80003c10:	00001517          	auipc	a0,0x1
    80003c14:	67050513          	addi	a0,a0,1648 # 80005280 <digits+0x18>
    80003c18:	fffff097          	auipc	ra,0xfffff
    80003c1c:	354080e7          	jalr	852(ra) # 80002f6c <panic>

0000000080003c20 <kalloc>:
    80003c20:	fe010113          	addi	sp,sp,-32
    80003c24:	00813823          	sd	s0,16(sp)
    80003c28:	00913423          	sd	s1,8(sp)
    80003c2c:	00113c23          	sd	ra,24(sp)
    80003c30:	02010413          	addi	s0,sp,32
    80003c34:	00002797          	auipc	a5,0x2
    80003c38:	d8c78793          	addi	a5,a5,-628 # 800059c0 <kmem>
    80003c3c:	0007b483          	ld	s1,0(a5)
    80003c40:	02048063          	beqz	s1,80003c60 <kalloc+0x40>
    80003c44:	0004b703          	ld	a4,0(s1)
    80003c48:	00001637          	lui	a2,0x1
    80003c4c:	00500593          	li	a1,5
    80003c50:	00048513          	mv	a0,s1
    80003c54:	00e7b023          	sd	a4,0(a5)
    80003c58:	00000097          	auipc	ra,0x0
    80003c5c:	400080e7          	jalr	1024(ra) # 80004058 <__memset>
    80003c60:	01813083          	ld	ra,24(sp)
    80003c64:	01013403          	ld	s0,16(sp)
    80003c68:	00048513          	mv	a0,s1
    80003c6c:	00813483          	ld	s1,8(sp)
    80003c70:	02010113          	addi	sp,sp,32
    80003c74:	00008067          	ret

0000000080003c78 <initlock>:
    80003c78:	ff010113          	addi	sp,sp,-16
    80003c7c:	00813423          	sd	s0,8(sp)
    80003c80:	01010413          	addi	s0,sp,16
    80003c84:	00813403          	ld	s0,8(sp)
    80003c88:	00b53423          	sd	a1,8(a0)
    80003c8c:	00052023          	sw	zero,0(a0)
    80003c90:	00053823          	sd	zero,16(a0)
    80003c94:	01010113          	addi	sp,sp,16
    80003c98:	00008067          	ret

0000000080003c9c <acquire>:
    80003c9c:	fe010113          	addi	sp,sp,-32
    80003ca0:	00813823          	sd	s0,16(sp)
    80003ca4:	00913423          	sd	s1,8(sp)
    80003ca8:	00113c23          	sd	ra,24(sp)
    80003cac:	01213023          	sd	s2,0(sp)
    80003cb0:	02010413          	addi	s0,sp,32
    80003cb4:	00050493          	mv	s1,a0
    80003cb8:	10002973          	csrr	s2,sstatus
    80003cbc:	100027f3          	csrr	a5,sstatus
    80003cc0:	ffd7f793          	andi	a5,a5,-3
    80003cc4:	10079073          	csrw	sstatus,a5
    80003cc8:	fffff097          	auipc	ra,0xfffff
    80003ccc:	8e4080e7          	jalr	-1820(ra) # 800025ac <mycpu>
    80003cd0:	07852783          	lw	a5,120(a0)
    80003cd4:	06078e63          	beqz	a5,80003d50 <acquire+0xb4>
    80003cd8:	fffff097          	auipc	ra,0xfffff
    80003cdc:	8d4080e7          	jalr	-1836(ra) # 800025ac <mycpu>
    80003ce0:	07852783          	lw	a5,120(a0)
    80003ce4:	0004a703          	lw	a4,0(s1)
    80003ce8:	0017879b          	addiw	a5,a5,1
    80003cec:	06f52c23          	sw	a5,120(a0)
    80003cf0:	04071063          	bnez	a4,80003d30 <acquire+0x94>
    80003cf4:	00100713          	li	a4,1
    80003cf8:	00070793          	mv	a5,a4
    80003cfc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003d00:	0007879b          	sext.w	a5,a5
    80003d04:	fe079ae3          	bnez	a5,80003cf8 <acquire+0x5c>
    80003d08:	0ff0000f          	fence
    80003d0c:	fffff097          	auipc	ra,0xfffff
    80003d10:	8a0080e7          	jalr	-1888(ra) # 800025ac <mycpu>
    80003d14:	01813083          	ld	ra,24(sp)
    80003d18:	01013403          	ld	s0,16(sp)
    80003d1c:	00a4b823          	sd	a0,16(s1)
    80003d20:	00013903          	ld	s2,0(sp)
    80003d24:	00813483          	ld	s1,8(sp)
    80003d28:	02010113          	addi	sp,sp,32
    80003d2c:	00008067          	ret
    80003d30:	0104b903          	ld	s2,16(s1)
    80003d34:	fffff097          	auipc	ra,0xfffff
    80003d38:	878080e7          	jalr	-1928(ra) # 800025ac <mycpu>
    80003d3c:	faa91ce3          	bne	s2,a0,80003cf4 <acquire+0x58>
    80003d40:	00001517          	auipc	a0,0x1
    80003d44:	54850513          	addi	a0,a0,1352 # 80005288 <digits+0x20>
    80003d48:	fffff097          	auipc	ra,0xfffff
    80003d4c:	224080e7          	jalr	548(ra) # 80002f6c <panic>
    80003d50:	00195913          	srli	s2,s2,0x1
    80003d54:	fffff097          	auipc	ra,0xfffff
    80003d58:	858080e7          	jalr	-1960(ra) # 800025ac <mycpu>
    80003d5c:	00197913          	andi	s2,s2,1
    80003d60:	07252e23          	sw	s2,124(a0)
    80003d64:	f75ff06f          	j	80003cd8 <acquire+0x3c>

0000000080003d68 <release>:
    80003d68:	fe010113          	addi	sp,sp,-32
    80003d6c:	00813823          	sd	s0,16(sp)
    80003d70:	00113c23          	sd	ra,24(sp)
    80003d74:	00913423          	sd	s1,8(sp)
    80003d78:	01213023          	sd	s2,0(sp)
    80003d7c:	02010413          	addi	s0,sp,32
    80003d80:	00052783          	lw	a5,0(a0)
    80003d84:	00079a63          	bnez	a5,80003d98 <release+0x30>
    80003d88:	00001517          	auipc	a0,0x1
    80003d8c:	50850513          	addi	a0,a0,1288 # 80005290 <digits+0x28>
    80003d90:	fffff097          	auipc	ra,0xfffff
    80003d94:	1dc080e7          	jalr	476(ra) # 80002f6c <panic>
    80003d98:	01053903          	ld	s2,16(a0)
    80003d9c:	00050493          	mv	s1,a0
    80003da0:	fffff097          	auipc	ra,0xfffff
    80003da4:	80c080e7          	jalr	-2036(ra) # 800025ac <mycpu>
    80003da8:	fea910e3          	bne	s2,a0,80003d88 <release+0x20>
    80003dac:	0004b823          	sd	zero,16(s1)
    80003db0:	0ff0000f          	fence
    80003db4:	0f50000f          	fence	iorw,ow
    80003db8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003dbc:	ffffe097          	auipc	ra,0xffffe
    80003dc0:	7f0080e7          	jalr	2032(ra) # 800025ac <mycpu>
    80003dc4:	100027f3          	csrr	a5,sstatus
    80003dc8:	0027f793          	andi	a5,a5,2
    80003dcc:	04079a63          	bnez	a5,80003e20 <release+0xb8>
    80003dd0:	07852783          	lw	a5,120(a0)
    80003dd4:	02f05e63          	blez	a5,80003e10 <release+0xa8>
    80003dd8:	fff7871b          	addiw	a4,a5,-1
    80003ddc:	06e52c23          	sw	a4,120(a0)
    80003de0:	00071c63          	bnez	a4,80003df8 <release+0x90>
    80003de4:	07c52783          	lw	a5,124(a0)
    80003de8:	00078863          	beqz	a5,80003df8 <release+0x90>
    80003dec:	100027f3          	csrr	a5,sstatus
    80003df0:	0027e793          	ori	a5,a5,2
    80003df4:	10079073          	csrw	sstatus,a5
    80003df8:	01813083          	ld	ra,24(sp)
    80003dfc:	01013403          	ld	s0,16(sp)
    80003e00:	00813483          	ld	s1,8(sp)
    80003e04:	00013903          	ld	s2,0(sp)
    80003e08:	02010113          	addi	sp,sp,32
    80003e0c:	00008067          	ret
    80003e10:	00001517          	auipc	a0,0x1
    80003e14:	4a050513          	addi	a0,a0,1184 # 800052b0 <digits+0x48>
    80003e18:	fffff097          	auipc	ra,0xfffff
    80003e1c:	154080e7          	jalr	340(ra) # 80002f6c <panic>
    80003e20:	00001517          	auipc	a0,0x1
    80003e24:	47850513          	addi	a0,a0,1144 # 80005298 <digits+0x30>
    80003e28:	fffff097          	auipc	ra,0xfffff
    80003e2c:	144080e7          	jalr	324(ra) # 80002f6c <panic>

0000000080003e30 <holding>:
    80003e30:	00052783          	lw	a5,0(a0)
    80003e34:	00079663          	bnez	a5,80003e40 <holding+0x10>
    80003e38:	00000513          	li	a0,0
    80003e3c:	00008067          	ret
    80003e40:	fe010113          	addi	sp,sp,-32
    80003e44:	00813823          	sd	s0,16(sp)
    80003e48:	00913423          	sd	s1,8(sp)
    80003e4c:	00113c23          	sd	ra,24(sp)
    80003e50:	02010413          	addi	s0,sp,32
    80003e54:	01053483          	ld	s1,16(a0)
    80003e58:	ffffe097          	auipc	ra,0xffffe
    80003e5c:	754080e7          	jalr	1876(ra) # 800025ac <mycpu>
    80003e60:	01813083          	ld	ra,24(sp)
    80003e64:	01013403          	ld	s0,16(sp)
    80003e68:	40a48533          	sub	a0,s1,a0
    80003e6c:	00153513          	seqz	a0,a0
    80003e70:	00813483          	ld	s1,8(sp)
    80003e74:	02010113          	addi	sp,sp,32
    80003e78:	00008067          	ret

0000000080003e7c <push_off>:
    80003e7c:	fe010113          	addi	sp,sp,-32
    80003e80:	00813823          	sd	s0,16(sp)
    80003e84:	00113c23          	sd	ra,24(sp)
    80003e88:	00913423          	sd	s1,8(sp)
    80003e8c:	02010413          	addi	s0,sp,32
    80003e90:	100024f3          	csrr	s1,sstatus
    80003e94:	100027f3          	csrr	a5,sstatus
    80003e98:	ffd7f793          	andi	a5,a5,-3
    80003e9c:	10079073          	csrw	sstatus,a5
    80003ea0:	ffffe097          	auipc	ra,0xffffe
    80003ea4:	70c080e7          	jalr	1804(ra) # 800025ac <mycpu>
    80003ea8:	07852783          	lw	a5,120(a0)
    80003eac:	02078663          	beqz	a5,80003ed8 <push_off+0x5c>
    80003eb0:	ffffe097          	auipc	ra,0xffffe
    80003eb4:	6fc080e7          	jalr	1788(ra) # 800025ac <mycpu>
    80003eb8:	07852783          	lw	a5,120(a0)
    80003ebc:	01813083          	ld	ra,24(sp)
    80003ec0:	01013403          	ld	s0,16(sp)
    80003ec4:	0017879b          	addiw	a5,a5,1
    80003ec8:	06f52c23          	sw	a5,120(a0)
    80003ecc:	00813483          	ld	s1,8(sp)
    80003ed0:	02010113          	addi	sp,sp,32
    80003ed4:	00008067          	ret
    80003ed8:	0014d493          	srli	s1,s1,0x1
    80003edc:	ffffe097          	auipc	ra,0xffffe
    80003ee0:	6d0080e7          	jalr	1744(ra) # 800025ac <mycpu>
    80003ee4:	0014f493          	andi	s1,s1,1
    80003ee8:	06952e23          	sw	s1,124(a0)
    80003eec:	fc5ff06f          	j	80003eb0 <push_off+0x34>

0000000080003ef0 <pop_off>:
    80003ef0:	ff010113          	addi	sp,sp,-16
    80003ef4:	00813023          	sd	s0,0(sp)
    80003ef8:	00113423          	sd	ra,8(sp)
    80003efc:	01010413          	addi	s0,sp,16
    80003f00:	ffffe097          	auipc	ra,0xffffe
    80003f04:	6ac080e7          	jalr	1708(ra) # 800025ac <mycpu>
    80003f08:	100027f3          	csrr	a5,sstatus
    80003f0c:	0027f793          	andi	a5,a5,2
    80003f10:	04079663          	bnez	a5,80003f5c <pop_off+0x6c>
    80003f14:	07852783          	lw	a5,120(a0)
    80003f18:	02f05a63          	blez	a5,80003f4c <pop_off+0x5c>
    80003f1c:	fff7871b          	addiw	a4,a5,-1
    80003f20:	06e52c23          	sw	a4,120(a0)
    80003f24:	00071c63          	bnez	a4,80003f3c <pop_off+0x4c>
    80003f28:	07c52783          	lw	a5,124(a0)
    80003f2c:	00078863          	beqz	a5,80003f3c <pop_off+0x4c>
    80003f30:	100027f3          	csrr	a5,sstatus
    80003f34:	0027e793          	ori	a5,a5,2
    80003f38:	10079073          	csrw	sstatus,a5
    80003f3c:	00813083          	ld	ra,8(sp)
    80003f40:	00013403          	ld	s0,0(sp)
    80003f44:	01010113          	addi	sp,sp,16
    80003f48:	00008067          	ret
    80003f4c:	00001517          	auipc	a0,0x1
    80003f50:	36450513          	addi	a0,a0,868 # 800052b0 <digits+0x48>
    80003f54:	fffff097          	auipc	ra,0xfffff
    80003f58:	018080e7          	jalr	24(ra) # 80002f6c <panic>
    80003f5c:	00001517          	auipc	a0,0x1
    80003f60:	33c50513          	addi	a0,a0,828 # 80005298 <digits+0x30>
    80003f64:	fffff097          	auipc	ra,0xfffff
    80003f68:	008080e7          	jalr	8(ra) # 80002f6c <panic>

0000000080003f6c <push_on>:
    80003f6c:	fe010113          	addi	sp,sp,-32
    80003f70:	00813823          	sd	s0,16(sp)
    80003f74:	00113c23          	sd	ra,24(sp)
    80003f78:	00913423          	sd	s1,8(sp)
    80003f7c:	02010413          	addi	s0,sp,32
    80003f80:	100024f3          	csrr	s1,sstatus
    80003f84:	100027f3          	csrr	a5,sstatus
    80003f88:	0027e793          	ori	a5,a5,2
    80003f8c:	10079073          	csrw	sstatus,a5
    80003f90:	ffffe097          	auipc	ra,0xffffe
    80003f94:	61c080e7          	jalr	1564(ra) # 800025ac <mycpu>
    80003f98:	07852783          	lw	a5,120(a0)
    80003f9c:	02078663          	beqz	a5,80003fc8 <push_on+0x5c>
    80003fa0:	ffffe097          	auipc	ra,0xffffe
    80003fa4:	60c080e7          	jalr	1548(ra) # 800025ac <mycpu>
    80003fa8:	07852783          	lw	a5,120(a0)
    80003fac:	01813083          	ld	ra,24(sp)
    80003fb0:	01013403          	ld	s0,16(sp)
    80003fb4:	0017879b          	addiw	a5,a5,1
    80003fb8:	06f52c23          	sw	a5,120(a0)
    80003fbc:	00813483          	ld	s1,8(sp)
    80003fc0:	02010113          	addi	sp,sp,32
    80003fc4:	00008067          	ret
    80003fc8:	0014d493          	srli	s1,s1,0x1
    80003fcc:	ffffe097          	auipc	ra,0xffffe
    80003fd0:	5e0080e7          	jalr	1504(ra) # 800025ac <mycpu>
    80003fd4:	0014f493          	andi	s1,s1,1
    80003fd8:	06952e23          	sw	s1,124(a0)
    80003fdc:	fc5ff06f          	j	80003fa0 <push_on+0x34>

0000000080003fe0 <pop_on>:
    80003fe0:	ff010113          	addi	sp,sp,-16
    80003fe4:	00813023          	sd	s0,0(sp)
    80003fe8:	00113423          	sd	ra,8(sp)
    80003fec:	01010413          	addi	s0,sp,16
    80003ff0:	ffffe097          	auipc	ra,0xffffe
    80003ff4:	5bc080e7          	jalr	1468(ra) # 800025ac <mycpu>
    80003ff8:	100027f3          	csrr	a5,sstatus
    80003ffc:	0027f793          	andi	a5,a5,2
    80004000:	04078463          	beqz	a5,80004048 <pop_on+0x68>
    80004004:	07852783          	lw	a5,120(a0)
    80004008:	02f05863          	blez	a5,80004038 <pop_on+0x58>
    8000400c:	fff7879b          	addiw	a5,a5,-1
    80004010:	06f52c23          	sw	a5,120(a0)
    80004014:	07853783          	ld	a5,120(a0)
    80004018:	00079863          	bnez	a5,80004028 <pop_on+0x48>
    8000401c:	100027f3          	csrr	a5,sstatus
    80004020:	ffd7f793          	andi	a5,a5,-3
    80004024:	10079073          	csrw	sstatus,a5
    80004028:	00813083          	ld	ra,8(sp)
    8000402c:	00013403          	ld	s0,0(sp)
    80004030:	01010113          	addi	sp,sp,16
    80004034:	00008067          	ret
    80004038:	00001517          	auipc	a0,0x1
    8000403c:	2a050513          	addi	a0,a0,672 # 800052d8 <digits+0x70>
    80004040:	fffff097          	auipc	ra,0xfffff
    80004044:	f2c080e7          	jalr	-212(ra) # 80002f6c <panic>
    80004048:	00001517          	auipc	a0,0x1
    8000404c:	27050513          	addi	a0,a0,624 # 800052b8 <digits+0x50>
    80004050:	fffff097          	auipc	ra,0xfffff
    80004054:	f1c080e7          	jalr	-228(ra) # 80002f6c <panic>

0000000080004058 <__memset>:
    80004058:	ff010113          	addi	sp,sp,-16
    8000405c:	00813423          	sd	s0,8(sp)
    80004060:	01010413          	addi	s0,sp,16
    80004064:	1a060e63          	beqz	a2,80004220 <__memset+0x1c8>
    80004068:	40a007b3          	neg	a5,a0
    8000406c:	0077f793          	andi	a5,a5,7
    80004070:	00778693          	addi	a3,a5,7
    80004074:	00b00813          	li	a6,11
    80004078:	0ff5f593          	andi	a1,a1,255
    8000407c:	fff6071b          	addiw	a4,a2,-1
    80004080:	1b06e663          	bltu	a3,a6,8000422c <__memset+0x1d4>
    80004084:	1cd76463          	bltu	a4,a3,8000424c <__memset+0x1f4>
    80004088:	1a078e63          	beqz	a5,80004244 <__memset+0x1ec>
    8000408c:	00b50023          	sb	a1,0(a0)
    80004090:	00100713          	li	a4,1
    80004094:	1ae78463          	beq	a5,a4,8000423c <__memset+0x1e4>
    80004098:	00b500a3          	sb	a1,1(a0)
    8000409c:	00200713          	li	a4,2
    800040a0:	1ae78a63          	beq	a5,a4,80004254 <__memset+0x1fc>
    800040a4:	00b50123          	sb	a1,2(a0)
    800040a8:	00300713          	li	a4,3
    800040ac:	18e78463          	beq	a5,a4,80004234 <__memset+0x1dc>
    800040b0:	00b501a3          	sb	a1,3(a0)
    800040b4:	00400713          	li	a4,4
    800040b8:	1ae78263          	beq	a5,a4,8000425c <__memset+0x204>
    800040bc:	00b50223          	sb	a1,4(a0)
    800040c0:	00500713          	li	a4,5
    800040c4:	1ae78063          	beq	a5,a4,80004264 <__memset+0x20c>
    800040c8:	00b502a3          	sb	a1,5(a0)
    800040cc:	00700713          	li	a4,7
    800040d0:	18e79e63          	bne	a5,a4,8000426c <__memset+0x214>
    800040d4:	00b50323          	sb	a1,6(a0)
    800040d8:	00700e93          	li	t4,7
    800040dc:	00859713          	slli	a4,a1,0x8
    800040e0:	00e5e733          	or	a4,a1,a4
    800040e4:	01059e13          	slli	t3,a1,0x10
    800040e8:	01c76e33          	or	t3,a4,t3
    800040ec:	01859313          	slli	t1,a1,0x18
    800040f0:	006e6333          	or	t1,t3,t1
    800040f4:	02059893          	slli	a7,a1,0x20
    800040f8:	40f60e3b          	subw	t3,a2,a5
    800040fc:	011368b3          	or	a7,t1,a7
    80004100:	02859813          	slli	a6,a1,0x28
    80004104:	0108e833          	or	a6,a7,a6
    80004108:	03059693          	slli	a3,a1,0x30
    8000410c:	003e589b          	srliw	a7,t3,0x3
    80004110:	00d866b3          	or	a3,a6,a3
    80004114:	03859713          	slli	a4,a1,0x38
    80004118:	00389813          	slli	a6,a7,0x3
    8000411c:	00f507b3          	add	a5,a0,a5
    80004120:	00e6e733          	or	a4,a3,a4
    80004124:	000e089b          	sext.w	a7,t3
    80004128:	00f806b3          	add	a3,a6,a5
    8000412c:	00e7b023          	sd	a4,0(a5)
    80004130:	00878793          	addi	a5,a5,8
    80004134:	fed79ce3          	bne	a5,a3,8000412c <__memset+0xd4>
    80004138:	ff8e7793          	andi	a5,t3,-8
    8000413c:	0007871b          	sext.w	a4,a5
    80004140:	01d787bb          	addw	a5,a5,t4
    80004144:	0ce88e63          	beq	a7,a4,80004220 <__memset+0x1c8>
    80004148:	00f50733          	add	a4,a0,a5
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	0017871b          	addiw	a4,a5,1
    80004154:	0cc77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004158:	00e50733          	add	a4,a0,a4
    8000415c:	00b70023          	sb	a1,0(a4)
    80004160:	0027871b          	addiw	a4,a5,2
    80004164:	0ac77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004168:	00e50733          	add	a4,a0,a4
    8000416c:	00b70023          	sb	a1,0(a4)
    80004170:	0037871b          	addiw	a4,a5,3
    80004174:	0ac77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004178:	00e50733          	add	a4,a0,a4
    8000417c:	00b70023          	sb	a1,0(a4)
    80004180:	0047871b          	addiw	a4,a5,4
    80004184:	08c77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004188:	00e50733          	add	a4,a0,a4
    8000418c:	00b70023          	sb	a1,0(a4)
    80004190:	0057871b          	addiw	a4,a5,5
    80004194:	08c77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004198:	00e50733          	add	a4,a0,a4
    8000419c:	00b70023          	sb	a1,0(a4)
    800041a0:	0067871b          	addiw	a4,a5,6
    800041a4:	06c77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041a8:	00e50733          	add	a4,a0,a4
    800041ac:	00b70023          	sb	a1,0(a4)
    800041b0:	0077871b          	addiw	a4,a5,7
    800041b4:	06c77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041b8:	00e50733          	add	a4,a0,a4
    800041bc:	00b70023          	sb	a1,0(a4)
    800041c0:	0087871b          	addiw	a4,a5,8
    800041c4:	04c77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041c8:	00e50733          	add	a4,a0,a4
    800041cc:	00b70023          	sb	a1,0(a4)
    800041d0:	0097871b          	addiw	a4,a5,9
    800041d4:	04c77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041d8:	00e50733          	add	a4,a0,a4
    800041dc:	00b70023          	sb	a1,0(a4)
    800041e0:	00a7871b          	addiw	a4,a5,10
    800041e4:	02c77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041e8:	00e50733          	add	a4,a0,a4
    800041ec:	00b70023          	sb	a1,0(a4)
    800041f0:	00b7871b          	addiw	a4,a5,11
    800041f4:	02c77663          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    800041f8:	00e50733          	add	a4,a0,a4
    800041fc:	00b70023          	sb	a1,0(a4)
    80004200:	00c7871b          	addiw	a4,a5,12
    80004204:	00c77e63          	bgeu	a4,a2,80004220 <__memset+0x1c8>
    80004208:	00e50733          	add	a4,a0,a4
    8000420c:	00b70023          	sb	a1,0(a4)
    80004210:	00d7879b          	addiw	a5,a5,13
    80004214:	00c7f663          	bgeu	a5,a2,80004220 <__memset+0x1c8>
    80004218:	00f507b3          	add	a5,a0,a5
    8000421c:	00b78023          	sb	a1,0(a5)
    80004220:	00813403          	ld	s0,8(sp)
    80004224:	01010113          	addi	sp,sp,16
    80004228:	00008067          	ret
    8000422c:	00b00693          	li	a3,11
    80004230:	e55ff06f          	j	80004084 <__memset+0x2c>
    80004234:	00300e93          	li	t4,3
    80004238:	ea5ff06f          	j	800040dc <__memset+0x84>
    8000423c:	00100e93          	li	t4,1
    80004240:	e9dff06f          	j	800040dc <__memset+0x84>
    80004244:	00000e93          	li	t4,0
    80004248:	e95ff06f          	j	800040dc <__memset+0x84>
    8000424c:	00000793          	li	a5,0
    80004250:	ef9ff06f          	j	80004148 <__memset+0xf0>
    80004254:	00200e93          	li	t4,2
    80004258:	e85ff06f          	j	800040dc <__memset+0x84>
    8000425c:	00400e93          	li	t4,4
    80004260:	e7dff06f          	j	800040dc <__memset+0x84>
    80004264:	00500e93          	li	t4,5
    80004268:	e75ff06f          	j	800040dc <__memset+0x84>
    8000426c:	00600e93          	li	t4,6
    80004270:	e6dff06f          	j	800040dc <__memset+0x84>

0000000080004274 <__memmove>:
    80004274:	ff010113          	addi	sp,sp,-16
    80004278:	00813423          	sd	s0,8(sp)
    8000427c:	01010413          	addi	s0,sp,16
    80004280:	0e060863          	beqz	a2,80004370 <__memmove+0xfc>
    80004284:	fff6069b          	addiw	a3,a2,-1
    80004288:	0006881b          	sext.w	a6,a3
    8000428c:	0ea5e863          	bltu	a1,a0,8000437c <__memmove+0x108>
    80004290:	00758713          	addi	a4,a1,7
    80004294:	00a5e7b3          	or	a5,a1,a0
    80004298:	40a70733          	sub	a4,a4,a0
    8000429c:	0077f793          	andi	a5,a5,7
    800042a0:	00f73713          	sltiu	a4,a4,15
    800042a4:	00174713          	xori	a4,a4,1
    800042a8:	0017b793          	seqz	a5,a5
    800042ac:	00e7f7b3          	and	a5,a5,a4
    800042b0:	10078863          	beqz	a5,800043c0 <__memmove+0x14c>
    800042b4:	00900793          	li	a5,9
    800042b8:	1107f463          	bgeu	a5,a6,800043c0 <__memmove+0x14c>
    800042bc:	0036581b          	srliw	a6,a2,0x3
    800042c0:	fff8081b          	addiw	a6,a6,-1
    800042c4:	02081813          	slli	a6,a6,0x20
    800042c8:	01d85893          	srli	a7,a6,0x1d
    800042cc:	00858813          	addi	a6,a1,8
    800042d0:	00058793          	mv	a5,a1
    800042d4:	00050713          	mv	a4,a0
    800042d8:	01088833          	add	a6,a7,a6
    800042dc:	0007b883          	ld	a7,0(a5)
    800042e0:	00878793          	addi	a5,a5,8
    800042e4:	00870713          	addi	a4,a4,8
    800042e8:	ff173c23          	sd	a7,-8(a4)
    800042ec:	ff0798e3          	bne	a5,a6,800042dc <__memmove+0x68>
    800042f0:	ff867713          	andi	a4,a2,-8
    800042f4:	02071793          	slli	a5,a4,0x20
    800042f8:	0207d793          	srli	a5,a5,0x20
    800042fc:	00f585b3          	add	a1,a1,a5
    80004300:	40e686bb          	subw	a3,a3,a4
    80004304:	00f507b3          	add	a5,a0,a5
    80004308:	06e60463          	beq	a2,a4,80004370 <__memmove+0xfc>
    8000430c:	0005c703          	lbu	a4,0(a1)
    80004310:	00e78023          	sb	a4,0(a5)
    80004314:	04068e63          	beqz	a3,80004370 <__memmove+0xfc>
    80004318:	0015c603          	lbu	a2,1(a1)
    8000431c:	00100713          	li	a4,1
    80004320:	00c780a3          	sb	a2,1(a5)
    80004324:	04e68663          	beq	a3,a4,80004370 <__memmove+0xfc>
    80004328:	0025c603          	lbu	a2,2(a1)
    8000432c:	00200713          	li	a4,2
    80004330:	00c78123          	sb	a2,2(a5)
    80004334:	02e68e63          	beq	a3,a4,80004370 <__memmove+0xfc>
    80004338:	0035c603          	lbu	a2,3(a1)
    8000433c:	00300713          	li	a4,3
    80004340:	00c781a3          	sb	a2,3(a5)
    80004344:	02e68663          	beq	a3,a4,80004370 <__memmove+0xfc>
    80004348:	0045c603          	lbu	a2,4(a1)
    8000434c:	00400713          	li	a4,4
    80004350:	00c78223          	sb	a2,4(a5)
    80004354:	00e68e63          	beq	a3,a4,80004370 <__memmove+0xfc>
    80004358:	0055c603          	lbu	a2,5(a1)
    8000435c:	00500713          	li	a4,5
    80004360:	00c782a3          	sb	a2,5(a5)
    80004364:	00e68663          	beq	a3,a4,80004370 <__memmove+0xfc>
    80004368:	0065c703          	lbu	a4,6(a1)
    8000436c:	00e78323          	sb	a4,6(a5)
    80004370:	00813403          	ld	s0,8(sp)
    80004374:	01010113          	addi	sp,sp,16
    80004378:	00008067          	ret
    8000437c:	02061713          	slli	a4,a2,0x20
    80004380:	02075713          	srli	a4,a4,0x20
    80004384:	00e587b3          	add	a5,a1,a4
    80004388:	f0f574e3          	bgeu	a0,a5,80004290 <__memmove+0x1c>
    8000438c:	02069613          	slli	a2,a3,0x20
    80004390:	02065613          	srli	a2,a2,0x20
    80004394:	fff64613          	not	a2,a2
    80004398:	00e50733          	add	a4,a0,a4
    8000439c:	00c78633          	add	a2,a5,a2
    800043a0:	fff7c683          	lbu	a3,-1(a5)
    800043a4:	fff78793          	addi	a5,a5,-1
    800043a8:	fff70713          	addi	a4,a4,-1
    800043ac:	00d70023          	sb	a3,0(a4)
    800043b0:	fec798e3          	bne	a5,a2,800043a0 <__memmove+0x12c>
    800043b4:	00813403          	ld	s0,8(sp)
    800043b8:	01010113          	addi	sp,sp,16
    800043bc:	00008067          	ret
    800043c0:	02069713          	slli	a4,a3,0x20
    800043c4:	02075713          	srli	a4,a4,0x20
    800043c8:	00170713          	addi	a4,a4,1
    800043cc:	00e50733          	add	a4,a0,a4
    800043d0:	00050793          	mv	a5,a0
    800043d4:	0005c683          	lbu	a3,0(a1)
    800043d8:	00178793          	addi	a5,a5,1
    800043dc:	00158593          	addi	a1,a1,1
    800043e0:	fed78fa3          	sb	a3,-1(a5)
    800043e4:	fee798e3          	bne	a5,a4,800043d4 <__memmove+0x160>
    800043e8:	f89ff06f          	j	80004370 <__memmove+0xfc>

00000000800043ec <__putc>:
    800043ec:	fe010113          	addi	sp,sp,-32
    800043f0:	00813823          	sd	s0,16(sp)
    800043f4:	00113c23          	sd	ra,24(sp)
    800043f8:	02010413          	addi	s0,sp,32
    800043fc:	00050793          	mv	a5,a0
    80004400:	fef40593          	addi	a1,s0,-17
    80004404:	00100613          	li	a2,1
    80004408:	00000513          	li	a0,0
    8000440c:	fef407a3          	sb	a5,-17(s0)
    80004410:	fffff097          	auipc	ra,0xfffff
    80004414:	b3c080e7          	jalr	-1220(ra) # 80002f4c <console_write>
    80004418:	01813083          	ld	ra,24(sp)
    8000441c:	01013403          	ld	s0,16(sp)
    80004420:	02010113          	addi	sp,sp,32
    80004424:	00008067          	ret

0000000080004428 <__getc>:
    80004428:	fe010113          	addi	sp,sp,-32
    8000442c:	00813823          	sd	s0,16(sp)
    80004430:	00113c23          	sd	ra,24(sp)
    80004434:	02010413          	addi	s0,sp,32
    80004438:	fe840593          	addi	a1,s0,-24
    8000443c:	00100613          	li	a2,1
    80004440:	00000513          	li	a0,0
    80004444:	fffff097          	auipc	ra,0xfffff
    80004448:	ae8080e7          	jalr	-1304(ra) # 80002f2c <console_read>
    8000444c:	fe844503          	lbu	a0,-24(s0)
    80004450:	01813083          	ld	ra,24(sp)
    80004454:	01013403          	ld	s0,16(sp)
    80004458:	02010113          	addi	sp,sp,32
    8000445c:	00008067          	ret

0000000080004460 <console_handler>:
    80004460:	fe010113          	addi	sp,sp,-32
    80004464:	00813823          	sd	s0,16(sp)
    80004468:	00113c23          	sd	ra,24(sp)
    8000446c:	00913423          	sd	s1,8(sp)
    80004470:	02010413          	addi	s0,sp,32
    80004474:	14202773          	csrr	a4,scause
    80004478:	100027f3          	csrr	a5,sstatus
    8000447c:	0027f793          	andi	a5,a5,2
    80004480:	06079e63          	bnez	a5,800044fc <console_handler+0x9c>
    80004484:	00074c63          	bltz	a4,8000449c <console_handler+0x3c>
    80004488:	01813083          	ld	ra,24(sp)
    8000448c:	01013403          	ld	s0,16(sp)
    80004490:	00813483          	ld	s1,8(sp)
    80004494:	02010113          	addi	sp,sp,32
    80004498:	00008067          	ret
    8000449c:	0ff77713          	andi	a4,a4,255
    800044a0:	00900793          	li	a5,9
    800044a4:	fef712e3          	bne	a4,a5,80004488 <console_handler+0x28>
    800044a8:	ffffe097          	auipc	ra,0xffffe
    800044ac:	6dc080e7          	jalr	1756(ra) # 80002b84 <plic_claim>
    800044b0:	00a00793          	li	a5,10
    800044b4:	00050493          	mv	s1,a0
    800044b8:	02f50c63          	beq	a0,a5,800044f0 <console_handler+0x90>
    800044bc:	fc0506e3          	beqz	a0,80004488 <console_handler+0x28>
    800044c0:	00050593          	mv	a1,a0
    800044c4:	00001517          	auipc	a0,0x1
    800044c8:	d1c50513          	addi	a0,a0,-740 # 800051e0 <_ZZ12printIntegermE6digits+0xe0>
    800044cc:	fffff097          	auipc	ra,0xfffff
    800044d0:	afc080e7          	jalr	-1284(ra) # 80002fc8 <__printf>
    800044d4:	01013403          	ld	s0,16(sp)
    800044d8:	01813083          	ld	ra,24(sp)
    800044dc:	00048513          	mv	a0,s1
    800044e0:	00813483          	ld	s1,8(sp)
    800044e4:	02010113          	addi	sp,sp,32
    800044e8:	ffffe317          	auipc	t1,0xffffe
    800044ec:	6d430067          	jr	1748(t1) # 80002bbc <plic_complete>
    800044f0:	fffff097          	auipc	ra,0xfffff
    800044f4:	3e0080e7          	jalr	992(ra) # 800038d0 <uartintr>
    800044f8:	fddff06f          	j	800044d4 <console_handler+0x74>
    800044fc:	00001517          	auipc	a0,0x1
    80004500:	de450513          	addi	a0,a0,-540 # 800052e0 <digits+0x78>
    80004504:	fffff097          	auipc	ra,0xfffff
    80004508:	a68080e7          	jalr	-1432(ra) # 80002f6c <panic>
	...
