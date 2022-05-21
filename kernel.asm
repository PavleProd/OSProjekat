
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	8d013103          	ld	sp,-1840(sp) # 800058d0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	274020ef          	jal	ra,80002290 <start>

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
    8000100c:	72c000ef          	jal	ra,80001738 <_ZN3PCB10getContextEv>
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
    800010a4:	1e0000ef          	jal	ra,80001284 <interruptHandler>

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

000000008000112c <initKernel>:
initKernel:
    //zabrana prekida SIE
    //csrw stvec, interrupt // ecall ce skociti na interrupt
    // prebacivanje u korisnicki rezim SIP
    //dozvola prekid SIE
    8000112c:	00008067          	ret

0000000080001130 <_ZN3PCB14switchContext1EPmS0_>:
.global _ZN3PCB14switchContext1EPmS0_ // switchContext kada se prvi put poziva, skidamo korisnicki stek
_ZN3PCB14switchContext1EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    80001130:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    80001134:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    80001138:	1005b083          	ld	ra,256(a1)
    ld sp, 2 * 8(a1)
    8000113c:	0105b103          	ld	sp,16(a1)

    ret
    80001140:	00008067          	ret

0000000080001144 <_ZN3PCB14switchContext2EPmS0_>:

.global _ZN3PCB14switchContext2EPmS0_ // switchContext kada se ne poziva prvi put, skidamo sistemski stek
_ZN3PCB14switchContext2EPmS0_:
    // a0 - &old->registers
    // a1 - &running->registers
    sd ra, 32 * 8(a0)
    80001144:	10153023          	sd	ra,256(a0)
    sd sp, 0 * 8(a0)
    80001148:	00253023          	sd	sp,0(a0)

    ld ra, 32 * 8(a1)
    8000114c:	1005b083          	ld	ra,256(a1)
    ld sp, 0 * 8(a1)
    80001150:	0005b103          	ld	sp,0(a1)

    80001154:	00008067          	ret

0000000080001158 <_Z13callInterruptv>:
#include "../h/kernel.h"
#include "../h/PCB.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001158:	ff010113          	addi	sp,sp,-16
    8000115c:	00813423          	sd	s0,8(sp)
    80001160:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("ecall");
    80001164:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (res));
    80001168:	00050513          	mv	a0,a0
    return res;
}
    8000116c:	00813403          	ld	s0,8(sp)
    80001170:	01010113          	addi	sp,sp,16
    80001174:	00008067          	ret

0000000080001178 <_Z9mem_allocm>:

// a0 code a1 size
void* mem_alloc(size_t size) {
    80001178:	ff010113          	addi	sp,sp,-16
    8000117c:	00113423          	sd	ra,8(sp)
    80001180:	00813023          	sd	s0,0(sp)
    80001184:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001188:	00655793          	srli	a5,a0,0x6
    8000118c:	03f57513          	andi	a0,a0,63
    80001190:	00a03533          	snez	a0,a0
    80001194:	00a78533          	add	a0,a5,a0
    size_t code = Kernel::sysCallCodes::mem_alloc; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    80001198:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code, u MemoryAllocator::sizeInBlocks se menja a0
    8000119c:	00100793          	li	a5,1
    800011a0:	00078513          	mv	a0,a5

    return (void*)callInterrupt();
    800011a4:	00000097          	auipc	ra,0x0
    800011a8:	fb4080e7          	jalr	-76(ra) # 80001158 <_Z13callInterruptv>
}
    800011ac:	00813083          	ld	ra,8(sp)
    800011b0:	00013403          	ld	s0,0(sp)
    800011b4:	01010113          	addi	sp,sp,16
    800011b8:	00008067          	ret

00000000800011bc <_Z8mem_freePv>:

// a0 code a1 memSegment
int mem_free (void* memSegment) {
    800011bc:	ff010113          	addi	sp,sp,-16
    800011c0:	00113423          	sd	ra,8(sp)
    800011c4:	00813023          	sd	s0,0(sp)
    800011c8:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::mem_free; // kod sistemskog poziva
    asm volatile("mv a1, a0"); // a1 = memSegment
    800011cc:	00050593          	mv	a1,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800011d0:	00200793          	li	a5,2
    800011d4:	00078513          	mv	a0,a5

    return (size_t)(callInterrupt());
    800011d8:	00000097          	auipc	ra,0x0
    800011dc:	f80080e7          	jalr	-128(ra) # 80001158 <_Z13callInterruptv>
}
    800011e0:	0005051b          	sext.w	a0,a0
    800011e4:	00813083          	ld	ra,8(sp)
    800011e8:	00013403          	ld	s0,0(sp)
    800011ec:	01010113          	addi	sp,sp,16
    800011f0:	00008067          	ret

00000000800011f4 <_Z13thread_createPP3PCBPFvPvES2_>:

// a0 - code a1 - handle a2 - startRoutine a3 - arg a4 - stackSpace
int thread_create (thread_t* handle, void(*startRoutine)(void*), void* arg) {
    800011f4:	ff010113          	addi	sp,sp,-16
    800011f8:	00113423          	sd	ra,8(sp)
    800011fc:	00813023          	sd	s0,0(sp)
    80001200:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_create;
    asm volatile("mv a3, a2"); // a3 = arg
    80001204:	00060693          	mv	a3,a2
    asm volatile("mv a2, a1"); // a2 = startRoutine
    80001208:	00058613          	mv	a2,a1
    asm volatile("mv a4, a0"); // a5 = handle privremeno cuvamo da bismo posle vratili u a1
    8000120c:	00050713          	mv	a4,a0

    size_t* stack = new size_t[DEFAULT_STACK_SIZE]; // pravimo stack procesa
    80001210:	00008537          	lui	a0,0x8
    80001214:	00001097          	auipc	ra,0x1
    80001218:	b3c080e7          	jalr	-1220(ra) # 80001d50 <_Znam>
    if(stack == nullptr) return -1;
    8000121c:	02050c63          	beqz	a0,80001254 <_Z13thread_createPP3PCBPFvPvES2_+0x60>

    asm volatile("mv a1, a4"); // a1 = a5(handle)
    80001220:	00070593          	mv	a1,a4
    asm volatile("mv a4, %0" : : "r" (stack));
    80001224:	00050713          	mv	a4,a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001228:	01100793          	li	a5,17
    8000122c:	00078513          	mv	a0,a5

    // *handle = PCB::createProccess((PCB::processMain)startRoutine, arg);
    handle = (thread_t*)(callInterrupt()); // vraca se pokazivac na PCB, ili nullptr ako je neuspesna alokacija
    80001230:	00000097          	auipc	ra,0x0
    80001234:	f28080e7          	jalr	-216(ra) # 80001158 <_Z13callInterruptv>
    if(*handle == nullptr) {
    80001238:	00053783          	ld	a5,0(a0) # 8000 <_entry-0x7fff8000>
    8000123c:	02078063          	beqz	a5,8000125c <_Z13thread_createPP3PCBPFvPvES2_+0x68>
        return -1;
    }
    return 0;
    80001240:	00000513          	li	a0,0
}
    80001244:	00813083          	ld	ra,8(sp)
    80001248:	00013403          	ld	s0,0(sp)
    8000124c:	01010113          	addi	sp,sp,16
    80001250:	00008067          	ret
    if(stack == nullptr) return -1;
    80001254:	fff00513          	li	a0,-1
    80001258:	fedff06f          	j	80001244 <_Z13thread_createPP3PCBPFvPvES2_+0x50>
        return -1;
    8000125c:	fff00513          	li	a0,-1
    80001260:	fe5ff06f          	j	80001244 <_Z13thread_createPP3PCBPFvPvES2_+0x50>

0000000080001264 <_ZN6Kernel10popSppSpieEv>:
#include "../h/PCB.h"
#include "../h/MemoryAllocator.h"
#include "../h/console.h"
#include "../h/print.h"

void Kernel::popSppSpie() {
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00813423          	sd	s0,8(sp)
    8000126c:	01010413          	addi	s0,sp,16
    asm volatile("csrw sepc, ra"); // da bi se funkcija vratila u wrapper
    80001270:	14109073          	csrw	sepc,ra
    asm volatile("sret");
    80001274:	10200073          	sret
}
    80001278:	00813403          	ld	s0,8(sp)
    8000127c:	01010113          	addi	sp,sp,16
    80001280:	00008067          	ret

0000000080001284 <interruptHandler>:

extern "C" void interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001284:	fb010113          	addi	sp,sp,-80
    80001288:	04113423          	sd	ra,72(sp)
    8000128c:	04813023          	sd	s0,64(sp)
    80001290:	02913c23          	sd	s1,56(sp)
    80001294:	05010413          	addi	s0,sp,80
    static void popSppSpie();

    // cita registar scause (uzrok nastanka prekida)
    static size_t r_scause() {
        size_t volatile scause;
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001298:	142027f3          	csrr	a5,scause
    8000129c:	fcf43023          	sd	a5,-64(s0)
        return scause;
    800012a0:	fc043783          	ld	a5,-64(s0)
    size_t volatile scause = Kernel::r_scause();
    800012a4:	fcf43c23          	sd	a5,-40(s0)
    }

    // cita registar sepc
    static size_t r_sepc() {
        size_t volatile sepc;
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800012a8:	141027f3          	csrr	a5,sepc
    800012ac:	faf43c23          	sd	a5,-72(s0)
        return sepc;
    800012b0:	fb843783          	ld	a5,-72(s0)
    size_t volatile sepc = Kernel::r_sepc();
    800012b4:	fcf43823          	sd	a5,-48(s0)
    }

    // read register sstatus
    static size_t r_sstatus() {
        size_t volatile sstatus;
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800012b8:	100027f3          	csrr	a5,sstatus
    800012bc:	faf43823          	sd	a5,-80(s0)
        return sstatus;
    800012c0:	fb043783          	ld	a5,-80(s0)
    size_t volatile sstatus = Kernel::r_sstatus();
    800012c4:	fcf43423          	sd	a5,-56(s0)
    if(scause == 9 || scause == 8) { // sistemski poziv iz korisnickog(8) ili sistemskog(9) rezima
    800012c8:	fd843703          	ld	a4,-40(s0)
    800012cc:	00900793          	li	a5,9
    800012d0:	04f70263          	beq	a4,a5,80001314 <interruptHandler+0x90>
    800012d4:	fd843703          	ld	a4,-40(s0)
    800012d8:	00800793          	li	a5,8
    800012dc:	02f70c63          	beq	a4,a5,80001314 <interruptHandler+0x90>
        }
        Kernel::w_sepc(sepc);
        Kernel::w_sstatus(sstatus);
        return;
    }
    else if(scause == (1UL << 63 | 1)) { // softverski prekid od tajmera
    800012e0:	fd843703          	ld	a4,-40(s0)
    800012e4:	fff00793          	li	a5,-1
    800012e8:	03f79793          	slli	a5,a5,0x3f
    800012ec:	00178793          	addi	a5,a5,1
    800012f0:	10f70e63          	beq	a4,a5,8000140c <interruptHandler+0x188>
            Kernel::w_sepc(sepc);
            Kernel::w_sstatus(sstatus);
        }
        Kernel::mc_sip(Kernel::SIP_SSIE); // postavljamo SSIE na 0 jer smo obradili softverski prekid od tajmera
    }
    else if(scause == (1UL << 63 | 9)) { // spoljasnji prekid od konzole
    800012f4:	fd843703          	ld	a4,-40(s0)
    800012f8:	fff00793          	li	a5,-1
    800012fc:	03f79793          	slli	a5,a5,0x3f
    80001300:	00978793          	addi	a5,a5,9
    80001304:	16f70263          	beq	a4,a5,80001468 <interruptHandler+0x1e4>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    }
    else { // neka vrsta greske, neocekivan skok na prekidnu rutinu
        printError();
    80001308:	00001097          	auipc	ra,0x1
    8000130c:	efc080e7          	jalr	-260(ra) # 80002204 <_Z10printErrorv>
    80001310:	0900006f          	j	800013a0 <interruptHandler+0x11c>
        sepc += 4; // da bi se sret vratio na pravo mesto
    80001314:	fd043783          	ld	a5,-48(s0)
    80001318:	00478793          	addi	a5,a5,4
    8000131c:	fcf43823          	sd	a5,-48(s0)
        size_t code = PCB::running->registers[10]; // a0
    80001320:	00004797          	auipc	a5,0x4
    80001324:	5b87b783          	ld	a5,1464(a5) # 800058d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001328:	0007b783          	ld	a5,0(a5)
    8000132c:	0187b703          	ld	a4,24(a5)
    80001330:	05073783          	ld	a5,80(a4)
        switch(code) {
    80001334:	01100693          	li	a3,17
    80001338:	06d78e63          	beq	a5,a3,800013b4 <interruptHandler+0x130>
    8000133c:	02f6e263          	bltu	a3,a5,80001360 <interruptHandler+0xdc>
    80001340:	00100693          	li	a3,1
    80001344:	02d78e63          	beq	a5,a3,80001380 <interruptHandler+0xfc>
    80001348:	00200693          	li	a3,2
    8000134c:	0ad79a63          	bne	a5,a3,80001400 <interruptHandler+0x17c>
                MemoryAllocator::mem_free(memSegment);
    80001350:	05873503          	ld	a0,88(a4)
    80001354:	00001097          	auipc	ra,0x1
    80001358:	bd8080e7          	jalr	-1064(ra) # 80001f2c <_ZN15MemoryAllocator8mem_freeEPv>
                break;
    8000135c:	0340006f          	j	80001390 <interruptHandler+0x10c>
        switch(code) {
    80001360:	01300713          	li	a4,19
    80001364:	08e79e63          	bne	a5,a4,80001400 <interruptHandler+0x17c>
                PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001368:	00000097          	auipc	ra,0x0
    8000136c:	190080e7          	jalr	400(ra) # 800014f8 <_ZN3PCB8dispatchEv>
                PCB::timeSliceCounter = 0;
    80001370:	00004797          	auipc	a5,0x4
    80001374:	5587b783          	ld	a5,1368(a5) # 800058c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001378:	0007b023          	sd	zero,0(a5)
                break;
    8000137c:	0140006f          	j	80001390 <interruptHandler+0x10c>
                size_t size = PCB::running->registers[11];
    80001380:	05873503          	ld	a0,88(a4)
                MemoryAllocator::mem_alloc(size);
    80001384:	00651513          	slli	a0,a0,0x6
    80001388:	00001097          	auipc	ra,0x1
    8000138c:	a40080e7          	jalr	-1472(ra) # 80001dc8 <_ZN15MemoryAllocator9mem_allocEm>
        Kernel::w_sepc(sepc);
    80001390:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001394:	14179073          	csrw	sepc,a5
        Kernel::w_sstatus(sstatus);
    80001398:	fc843783          	ld	a5,-56(s0)
    }

    // write register sstatus
    static void w_sstatus(size_t sstatus) {
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000139c:	10079073          	csrw	sstatus,a5
    }

}
    800013a0:	04813083          	ld	ra,72(sp)
    800013a4:	04013403          	ld	s0,64(sp)
    800013a8:	03813483          	ld	s1,56(sp)
    800013ac:	05010113          	addi	sp,sp,80
    800013b0:	00008067          	ret
                PCB **handle = (PCB**)PCB::running->registers[11];
    800013b4:	05873483          	ld	s1,88(a4)
                *handle = PCB::createProccess(main, arg);
    800013b8:	06873583          	ld	a1,104(a4)
    800013bc:	06073503          	ld	a0,96(a4)
    800013c0:	00000097          	auipc	ra,0x0
    800013c4:	2f0080e7          	jalr	752(ra) # 800016b0 <_ZN3PCB14createProccessEPFvvEPv>
    800013c8:	00a4b023          	sd	a0,0(s1)
                size_t* stack = (size_t*)PCB::running->registers[14];
    800013cc:	00004797          	auipc	a5,0x4
    800013d0:	50c7b783          	ld	a5,1292(a5) # 800058d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d4:	0007b783          	ld	a5,0(a5)
    800013d8:	0187b783          	ld	a5,24(a5)
    800013dc:	0707b783          	ld	a5,112(a5)
                (*handle)->stack = stack;
    800013e0:	00f53423          	sd	a5,8(a0)
                (*handle)->registers[2] = (size_t)&stack[DEFAULT_STACK_SIZE]; // sp(x2)
    800013e4:	00008737          	lui	a4,0x8
    800013e8:	00e787b3          	add	a5,a5,a4
    800013ec:	0004b703          	ld	a4,0(s1)
    800013f0:	01873703          	ld	a4,24(a4) # 8018 <_entry-0x7fff7fe8>
    800013f4:	00f73823          	sd	a5,16(a4)
                asm volatile("mv a0, %0" : : "r" (handle));
    800013f8:	00048513          	mv	a0,s1
                break;
    800013fc:	f95ff06f          	j	80001390 <interruptHandler+0x10c>
                printError();
    80001400:	00001097          	auipc	ra,0x1
    80001404:	e04080e7          	jalr	-508(ra) # 80002204 <_Z10printErrorv>
                break;
    80001408:	f89ff06f          	j	80001390 <interruptHandler+0x10c>
        PCB::timeSliceCounter++;
    8000140c:	00004717          	auipc	a4,0x4
    80001410:	4bc73703          	ld	a4,1212(a4) # 800058c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001414:	00073783          	ld	a5,0(a4)
    80001418:	00178793          	addi	a5,a5,1
    8000141c:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->timeSlice) {
    80001420:	00004717          	auipc	a4,0x4
    80001424:	4b873703          	ld	a4,1208(a4) # 800058d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001428:	00073703          	ld	a4,0(a4)
    8000142c:	03873703          	ld	a4,56(a4)
    80001430:	00e7f863          	bgeu	a5,a4,80001440 <interruptHandler+0x1bc>
        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001434:	00200793          	li	a5,2
    80001438:	1447b073          	csrc	sip,a5
    }
    8000143c:	f65ff06f          	j	800013a0 <interruptHandler+0x11c>
            PCB::dispatch(); // vrsimo promenu konteksta ako je istekao time slice procesa
    80001440:	00000097          	auipc	ra,0x0
    80001444:	0b8080e7          	jalr	184(ra) # 800014f8 <_ZN3PCB8dispatchEv>
            PCB::timeSliceCounter = 0;
    80001448:	00004797          	auipc	a5,0x4
    8000144c:	4807b783          	ld	a5,1152(a5) # 800058c8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001450:	0007b023          	sd	zero,0(a5)
            Kernel::w_sepc(sepc);
    80001454:	fd043783          	ld	a5,-48(s0)
        __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001458:	14179073          	csrw	sepc,a5
            Kernel::w_sstatus(sstatus);
    8000145c:	fc843783          	ld	a5,-56(s0)
        __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001460:	10079073          	csrw	sstatus,a5
    }
    80001464:	fd1ff06f          	j	80001434 <interruptHandler+0x1b0>
        console_handler(); // TODO: zameniti sa svojim console_handlerom()
    80001468:	00003097          	auipc	ra,0x3
    8000146c:	f58080e7          	jalr	-168(ra) # 800043c0 <console_handler>
    80001470:	f31ff06f          	j	800013a0 <interruptHandler+0x11c>

0000000080001474 <_ZN3PCB5yieldEv>:

PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
}

void PCB::yield() {
    80001474:	ff010113          	addi	sp,sp,-16
    80001478:	00813423          	sd	s0,8(sp)
    8000147c:	01010413          	addi	s0,sp,16
    size_t code = Kernel::sysCallCodes::thread_dispatch;
    asm volatile("mv a0, %0" : : "r" (code));
    80001480:	01300793          	li	a5,19
    80001484:	00078513          	mv	a0,a5
    asm volatile("ecall"); // prelazimo u prekidnu rutinu koja cuva registre i vrsi promenu konteksta
    80001488:	00000073          	ecall
}
    8000148c:	00813403          	ld	s0,8(sp)
    80001490:	01010113          	addi	sp,sp,16
    80001494:	00008067          	ret

0000000080001498 <_ZN3PCB15proccessWrapperEv>:

void PCB::operator delete(void *memSegment) {
    MemoryAllocator::mem_free(memSegment);
}

void PCB::proccessWrapper() { // iz prekidne rutine skacemo ovde kada prvi put ulazimo u nit
    80001498:	fe010113          	addi	sp,sp,-32
    8000149c:	00113c23          	sd	ra,24(sp)
    800014a0:	00813823          	sd	s0,16(sp)
    800014a4:	00913423          	sd	s1,8(sp)
    800014a8:	02010413          	addi	s0,sp,32
    Kernel::popSppSpie(); // izlazimo iz prekidne rutine
    800014ac:	00000097          	auipc	ra,0x0
    800014b0:	db8080e7          	jalr	-584(ra) # 80001264 <_ZN6Kernel10popSppSpieEv>
    void* arg = PCB::running->mainArguments;
    800014b4:	00004497          	auipc	s1,0x4
    800014b8:	47c48493          	addi	s1,s1,1148 # 80005930 <_ZN3PCB7runningE>
    800014bc:	0004b783          	ld	a5,0(s1)
    800014c0:	0307b703          	ld	a4,48(a5)
    asm volatile("mv a0, %0" : : "r" (arg)); // u a0 postavljamo argument glavne funkcije procesa
    800014c4:	00070513          	mv	a0,a4
    running->main();
    800014c8:	0207b783          	ld	a5,32(a5)
    800014cc:	000780e7          	jalr	a5
    running->setFinished(true);
    800014d0:	0004b783          	ld	a5,0(s1)
    // vraca true ako se proces zavrsio, false ako nije
    bool isFinished() const {
        return finished;
    }
    void setFinished(bool finished_) {
        finished = finished_;
    800014d4:	00100713          	li	a4,1
    800014d8:	02e78423          	sb	a4,40(a5)
    PCB::yield(); // nit je gotova pa predajemo procesor drugom precesu
    800014dc:	00000097          	auipc	ra,0x0
    800014e0:	f98080e7          	jalr	-104(ra) # 80001474 <_ZN3PCB5yieldEv>
}
    800014e4:	01813083          	ld	ra,24(sp)
    800014e8:	01013403          	ld	s0,16(sp)
    800014ec:	00813483          	ld	s1,8(sp)
    800014f0:	02010113          	addi	sp,sp,32
    800014f4:	00008067          	ret

00000000800014f8 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    800014f8:	fe010113          	addi	sp,sp,-32
    800014fc:	00113c23          	sd	ra,24(sp)
    80001500:	00813823          	sd	s0,16(sp)
    80001504:	00913423          	sd	s1,8(sp)
    80001508:	02010413          	addi	s0,sp,32
    PCB* old = running;
    8000150c:	00004497          	auipc	s1,0x4
    80001510:	4244b483          	ld	s1,1060(s1) # 80005930 <_ZN3PCB7runningE>
        return finished;
    80001514:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()) {
    80001518:	04078263          	beqz	a5,8000155c <_ZN3PCB8dispatchEv+0x64>
    running = Scheduler::get();
    8000151c:	00000097          	auipc	ra,0x0
    80001520:	294080e7          	jalr	660(ra) # 800017b0 <_ZN9Scheduler3getEv>
    80001524:	00004797          	auipc	a5,0x4
    80001528:	40a7b623          	sd	a0,1036(a5) # 80005930 <_ZN3PCB7runningE>
    if(PCB::running->firstCall) {
    8000152c:	04054783          	lbu	a5,64(a0)
    80001530:	02078e63          	beqz	a5,8000156c <_ZN3PCB8dispatchEv+0x74>
        PCB::running->firstCall = false;
    80001534:	04050023          	sb	zero,64(a0)
        switchContext1(old->registers, running->registers);
    80001538:	01853583          	ld	a1,24(a0)
    8000153c:	0184b503          	ld	a0,24(s1)
    80001540:	00000097          	auipc	ra,0x0
    80001544:	bf0080e7          	jalr	-1040(ra) # 80001130 <_ZN3PCB14switchContext1EPmS0_>
}
    80001548:	01813083          	ld	ra,24(sp)
    8000154c:	01013403          	ld	s0,16(sp)
    80001550:	00813483          	ld	s1,8(sp)
    80001554:	02010113          	addi	sp,sp,32
    80001558:	00008067          	ret
        Scheduler::put(old);
    8000155c:	00048513          	mv	a0,s1
    80001560:	00000097          	auipc	ra,0x0
    80001564:	1fc080e7          	jalr	508(ra) # 8000175c <_ZN9Scheduler3putEP3PCB>
    80001568:	fb5ff06f          	j	8000151c <_ZN3PCB8dispatchEv+0x24>
        switchContext2(old->registers, running->registers);
    8000156c:	01853583          	ld	a1,24(a0)
    80001570:	0184b503          	ld	a0,24(s1)
    80001574:	00000097          	auipc	ra,0x0
    80001578:	bd0080e7          	jalr	-1072(ra) # 80001144 <_ZN3PCB14switchContext2EPmS0_>
}
    8000157c:	fcdff06f          	j	80001548 <_ZN3PCB8dispatchEv+0x50>

0000000080001580 <_ZN3PCBC1EPFvvEmPv>:
PCB::PCB(PCB::processMain main_, size_t timeSlice_, void* mainArguments_) {
    80001580:	fe010113          	addi	sp,sp,-32
    80001584:	00113c23          	sd	ra,24(sp)
    80001588:	00813823          	sd	s0,16(sp)
    8000158c:	00913423          	sd	s1,8(sp)
    80001590:	02010413          	addi	s0,sp,32
    80001594:	00050493          	mv	s1,a0
    80001598:	00053023          	sd	zero,0(a0)
    8000159c:	00053c23          	sd	zero,24(a0)
    800015a0:	00100793          	li	a5,1
    800015a4:	04f50023          	sb	a5,64(a0)
    finished = false;
    800015a8:	02050423          	sb	zero,40(a0)
    main = main_;
    800015ac:	02b53023          	sd	a1,32(a0)
    timeSlice = timeSlice_;
    800015b0:	02c53c23          	sd	a2,56(a0)
    mainArguments = mainArguments_;
    800015b4:	02d53823          	sd	a3,48(a0)
    registers = (size_t*)MemoryAllocator::mem_alloc(33*sizeof(size_t)); // mozemo direktno jer se zove iz sistemskog rezima samo
    800015b8:	10800513          	li	a0,264
    800015bc:	00001097          	auipc	ra,0x1
    800015c0:	80c080e7          	jalr	-2036(ra) # 80001dc8 <_ZN15MemoryAllocator9mem_allocEm>
    800015c4:	00a4bc23          	sd	a0,24(s1)
    sysStack = (size_t*)MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE*sizeof(size_t));
    800015c8:	00008537          	lui	a0,0x8
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	7fc080e7          	jalr	2044(ra) # 80001dc8 <_ZN15MemoryAllocator9mem_allocEm>
    800015d4:	00a4b823          	sd	a0,16(s1)
    registers[0] = (size_t)&sysStack[DEFAULT_STACK_SIZE]; // ssp postavljamo na vrh steka
    800015d8:	000087b7          	lui	a5,0x8
    800015dc:	00f50533          	add	a0,a0,a5
    800015e0:	0184b783          	ld	a5,24(s1)
    800015e4:	00a7b023          	sd	a0,0(a5) # 8000 <_entry-0x7fff8000>
    registers[32] = (size_t)&proccessWrapper; // u ra cuvamo proccessWrapper
    800015e8:	0184b783          	ld	a5,24(s1)
    800015ec:	00000717          	auipc	a4,0x0
    800015f0:	eac70713          	addi	a4,a4,-340 # 80001498 <_ZN3PCB15proccessWrapperEv>
    800015f4:	10e7b023          	sd	a4,256(a5)
    stack = nullptr; // stek pravimo u sistemskom pozivu thread_create
    800015f8:	0004b423          	sd	zero,8(s1)
    if(main != nullptr) Scheduler::put(this); // ako nismo u glavnom procesu(koji se vec izvrsava i ne treba da ga stavljamo u scheduler)
    800015fc:	0204b783          	ld	a5,32(s1)
    80001600:	02078263          	beqz	a5,80001624 <_ZN3PCBC1EPFvvEmPv+0xa4>
    80001604:	00048513          	mv	a0,s1
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	154080e7          	jalr	340(ra) # 8000175c <_ZN9Scheduler3putEP3PCB>
}
    80001610:	01813083          	ld	ra,24(sp)
    80001614:	01013403          	ld	s0,16(sp)
    80001618:	00813483          	ld	s1,8(sp)
    8000161c:	02010113          	addi	sp,sp,32
    80001620:	00008067          	ret
    else firstCall = false; // jer je glavni proces vec pokrenut, necemo ici u process_wrapper
    80001624:	04048023          	sb	zero,64(s1)
}
    80001628:	fe9ff06f          	j	80001610 <_ZN3PCBC1EPFvvEmPv+0x90>

000000008000162c <_ZN3PCBD1Ev>:
    delete[] stack;
    8000162c:	00853503          	ld	a0,8(a0) # 8008 <_entry-0x7fff7ff8>
    80001630:	02050663          	beqz	a0,8000165c <_ZN3PCBD1Ev+0x30>
PCB::~PCB() {
    80001634:	ff010113          	addi	sp,sp,-16
    80001638:	00113423          	sd	ra,8(sp)
    8000163c:	00813023          	sd	s0,0(sp)
    80001640:	01010413          	addi	s0,sp,16
    delete[] stack;
    80001644:	00000097          	auipc	ra,0x0
    80001648:	75c080e7          	jalr	1884(ra) # 80001da0 <_ZdaPv>
}
    8000164c:	00813083          	ld	ra,8(sp)
    80001650:	00013403          	ld	s0,0(sp)
    80001654:	01010113          	addi	sp,sp,16
    80001658:	00008067          	ret
    8000165c:	00008067          	ret

0000000080001660 <_ZN3PCBnwEm>:
void *PCB::operator new(size_t size) {
    80001660:	ff010113          	addi	sp,sp,-16
    80001664:	00113423          	sd	ra,8(sp)
    80001668:	00813023          	sd	s0,0(sp)
    8000166c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001670:	00000097          	auipc	ra,0x0
    80001674:	758080e7          	jalr	1880(ra) # 80001dc8 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001678:	00813083          	ld	ra,8(sp)
    8000167c:	00013403          	ld	s0,0(sp)
    80001680:	01010113          	addi	sp,sp,16
    80001684:	00008067          	ret

0000000080001688 <_ZN3PCBdlEPv>:
void PCB::operator delete(void *memSegment) {
    80001688:	ff010113          	addi	sp,sp,-16
    8000168c:	00113423          	sd	ra,8(sp)
    80001690:	00813023          	sd	s0,0(sp)
    80001694:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(memSegment);
    80001698:	00001097          	auipc	ra,0x1
    8000169c:	894080e7          	jalr	-1900(ra) # 80001f2c <_ZN15MemoryAllocator8mem_freeEPv>
}
    800016a0:	00813083          	ld	ra,8(sp)
    800016a4:	00013403          	ld	s0,0(sp)
    800016a8:	01010113          	addi	sp,sp,16
    800016ac:	00008067          	ret

00000000800016b0 <_ZN3PCB14createProccessEPFvvEPv>:
PCB *PCB::createProccess(PCB::processMain main, void* arguments) {
    800016b0:	fd010113          	addi	sp,sp,-48
    800016b4:	02113423          	sd	ra,40(sp)
    800016b8:	02813023          	sd	s0,32(sp)
    800016bc:	00913c23          	sd	s1,24(sp)
    800016c0:	01213823          	sd	s2,16(sp)
    800016c4:	01313423          	sd	s3,8(sp)
    800016c8:	03010413          	addi	s0,sp,48
    800016cc:	00050913          	mv	s2,a0
    800016d0:	00058993          	mv	s3,a1
    return new PCB(main, DEFAULT_TIME_SLICE, arguments);
    800016d4:	04800513          	li	a0,72
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	f88080e7          	jalr	-120(ra) # 80001660 <_ZN3PCBnwEm>
    800016e0:	00050493          	mv	s1,a0
    800016e4:	00098693          	mv	a3,s3
    800016e8:	00200613          	li	a2,2
    800016ec:	00090593          	mv	a1,s2
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	e90080e7          	jalr	-368(ra) # 80001580 <_ZN3PCBC1EPFvvEmPv>
    800016f8:	0200006f          	j	80001718 <_ZN3PCB14createProccessEPFvvEPv+0x68>
    800016fc:	00050913          	mv	s2,a0
    80001700:	00048513          	mv	a0,s1
    80001704:	00000097          	auipc	ra,0x0
    80001708:	f84080e7          	jalr	-124(ra) # 80001688 <_ZN3PCBdlEPv>
    8000170c:	00090513          	mv	a0,s2
    80001710:	00005097          	auipc	ra,0x5
    80001714:	318080e7          	jalr	792(ra) # 80006a28 <_Unwind_Resume>
}
    80001718:	00048513          	mv	a0,s1
    8000171c:	02813083          	ld	ra,40(sp)
    80001720:	02013403          	ld	s0,32(sp)
    80001724:	01813483          	ld	s1,24(sp)
    80001728:	01013903          	ld	s2,16(sp)
    8000172c:	00813983          	ld	s3,8(sp)
    80001730:	03010113          	addi	sp,sp,48
    80001734:	00008067          	ret

0000000080001738 <_ZN3PCB10getContextEv>:

size_t *PCB::getContext() {
    80001738:	ff010113          	addi	sp,sp,-16
    8000173c:	00813423          	sd	s0,8(sp)
    80001740:	01010413          	addi	s0,sp,16
    return running->registers;
}
    80001744:	00004797          	auipc	a5,0x4
    80001748:	1ec7b783          	ld	a5,492(a5) # 80005930 <_ZN3PCB7runningE>
    8000174c:	0187b503          	ld	a0,24(a5)
    80001750:	00813403          	ld	s0,8(sp)
    80001754:	01010113          	addi	sp,sp,16
    80001758:	00008067          	ret

000000008000175c <_ZN9Scheduler3putEP3PCB>:

PCB* Scheduler::idleProcess = nullptr; // TODO: napraviti idleProcess koji uposleno ceka da se pokrene neki proces
PCB* Scheduler::head = nullptr;
PCB* Scheduler::tail = nullptr;

void Scheduler::put(PCB *process) {
    8000175c:	ff010113          	addi	sp,sp,-16
    80001760:	00813423          	sd	s0,8(sp)
    80001764:	01010413          	addi	s0,sp,16
    process->nextReady = nullptr;
    80001768:	00053023          	sd	zero,0(a0)
    if(tail == nullptr) { // ako ne postoji kraj liste nece postojati ni pocetak
    8000176c:	00004797          	auipc	a5,0x4
    80001770:	1d47b783          	ld	a5,468(a5) # 80005940 <_ZN9Scheduler4tailE>
    80001774:	02078463          	beqz	a5,8000179c <_ZN9Scheduler3putEP3PCB+0x40>
        head = tail = process;
    }
    else {
        tail->nextReady = process;
    80001778:	00a7b023          	sd	a0,0(a5)
        tail = tail->nextReady;
    8000177c:	00004797          	auipc	a5,0x4
    80001780:	1c478793          	addi	a5,a5,452 # 80005940 <_ZN9Scheduler4tailE>
    80001784:	0007b703          	ld	a4,0(a5)
    80001788:	00073703          	ld	a4,0(a4)
    8000178c:	00e7b023          	sd	a4,0(a5)
    }
}
    80001790:	00813403          	ld	s0,8(sp)
    80001794:	01010113          	addi	sp,sp,16
    80001798:	00008067          	ret
        head = tail = process;
    8000179c:	00004797          	auipc	a5,0x4
    800017a0:	1a478793          	addi	a5,a5,420 # 80005940 <_ZN9Scheduler4tailE>
    800017a4:	00a7b023          	sd	a0,0(a5)
    800017a8:	00a7b423          	sd	a0,8(a5)
    800017ac:	fe5ff06f          	j	80001790 <_ZN9Scheduler3putEP3PCB+0x34>

00000000800017b0 <_ZN9Scheduler3getEv>:

PCB *Scheduler::get() {
    800017b0:	ff010113          	addi	sp,sp,-16
    800017b4:	00813423          	sd	s0,8(sp)
    800017b8:	01010413          	addi	s0,sp,16
    if(head == nullptr) {
    800017bc:	00004517          	auipc	a0,0x4
    800017c0:	18c53503          	ld	a0,396(a0) # 80005948 <_ZN9Scheduler4headE>
    800017c4:	02050463          	beqz	a0,800017ec <_ZN9Scheduler3getEv+0x3c>
        return idleProcess;
    }
    PCB* curr = head;
    head = head->nextReady;
    800017c8:	00053703          	ld	a4,0(a0)
    800017cc:	00004797          	auipc	a5,0x4
    800017d0:	17478793          	addi	a5,a5,372 # 80005940 <_ZN9Scheduler4tailE>
    800017d4:	00e7b423          	sd	a4,8(a5)
    if(tail == curr) {
    800017d8:	0007b783          	ld	a5,0(a5)
    800017dc:	00f50e63          	beq	a0,a5,800017f8 <_ZN9Scheduler3getEv+0x48>
        tail = head;
    }
    return curr;
}
    800017e0:	00813403          	ld	s0,8(sp)
    800017e4:	01010113          	addi	sp,sp,16
    800017e8:	00008067          	ret
        return idleProcess;
    800017ec:	00004517          	auipc	a0,0x4
    800017f0:	16453503          	ld	a0,356(a0) # 80005950 <_ZN9Scheduler11idleProcessE>
    800017f4:	fedff06f          	j	800017e0 <_ZN9Scheduler3getEv+0x30>
        tail = head;
    800017f8:	00004797          	auipc	a5,0x4
    800017fc:	14e7b423          	sd	a4,328(a5) # 80005940 <_ZN9Scheduler4tailE>
    80001800:	fe1ff06f          	j	800017e0 <_ZN9Scheduler3getEv+0x30>

0000000080001804 <_Z11workerBodyAv>:
#include "../h/PCB.h"
#include "../h/kernel.h"


void workerBodyA()
{
    80001804:	fe010113          	addi	sp,sp,-32
    80001808:	00113c23          	sd	ra,24(sp)
    8000180c:	00813823          	sd	s0,16(sp)
    80001810:	00913423          	sd	s1,8(sp)
    80001814:	02010413          	addi	s0,sp,32
    for (size_t i = 0; i < 10; i++)
    80001818:	00000493          	li	s1,0
    8000181c:	0300006f          	j	8000184c <_Z11workerBodyAv+0x48>
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
    80001820:	00168693          	addi	a3,a3,1
    80001824:	000027b7          	lui	a5,0x2
    80001828:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000182c:	00d7ee63          	bltu	a5,a3,80001848 <_Z11workerBodyAv+0x44>
        {
            for (size_t k = 0; k < 30000; k++)
    80001830:	00000713          	li	a4,0
    80001834:	000077b7          	lui	a5,0x7
    80001838:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000183c:	fee7e2e3          	bltu	a5,a4,80001820 <_Z11workerBodyAv+0x1c>
    80001840:	00170713          	addi	a4,a4,1
    80001844:	ff1ff06f          	j	80001834 <_Z11workerBodyAv+0x30>
    for (size_t i = 0; i < 10; i++)
    80001848:	00148493          	addi	s1,s1,1
    8000184c:	00900793          	li	a5,9
    80001850:	0297ec63          	bltu	a5,s1,80001888 <_Z11workerBodyAv+0x84>
        printString("A: i=");
    80001854:	00003517          	auipc	a0,0x3
    80001858:	7cc50513          	addi	a0,a0,1996 # 80005020 <CONSOLE_STATUS+0x10>
    8000185c:	00001097          	auipc	ra,0x1
    80001860:	87c080e7          	jalr	-1924(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    80001864:	00048513          	mv	a0,s1
    80001868:	00001097          	auipc	ra,0x1
    8000186c:	8e0080e7          	jalr	-1824(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    80001870:	00003517          	auipc	a0,0x3
    80001874:	7d050513          	addi	a0,a0,2000 # 80005040 <CONSOLE_STATUS+0x30>
    80001878:	00001097          	auipc	ra,0x1
    8000187c:	860080e7          	jalr	-1952(ra) # 800020d8 <_Z11printStringPKc>
        for (size_t j = 0; j < 10000; j++)
    80001880:	00000693          	li	a3,0
    80001884:	fa1ff06f          	j	80001824 <_Z11workerBodyAv+0x20>
                // busy wait
            }
//            TCB::yield();
        }
    }
}
    80001888:	01813083          	ld	ra,24(sp)
    8000188c:	01013403          	ld	s0,16(sp)
    80001890:	00813483          	ld	s1,8(sp)
    80001894:	02010113          	addi	sp,sp,32
    80001898:	00008067          	ret

000000008000189c <_Z11workerBodyBv>:

void workerBodyB()
{
    8000189c:	fe010113          	addi	sp,sp,-32
    800018a0:	00113c23          	sd	ra,24(sp)
    800018a4:	00813823          	sd	s0,16(sp)
    800018a8:	00913423          	sd	s1,8(sp)
    800018ac:	02010413          	addi	s0,sp,32
    for (size_t i = 0; i < 16; i++)
    800018b0:	00000493          	li	s1,0
    800018b4:	0300006f          	j	800018e4 <_Z11workerBodyBv+0x48>
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
        for (size_t j = 0; j < 10000; j++)
    800018b8:	00168693          	addi	a3,a3,1
    800018bc:	000027b7          	lui	a5,0x2
    800018c0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800018c4:	00d7ee63          	bltu	a5,a3,800018e0 <_Z11workerBodyBv+0x44>
        {
            for (size_t k = 0; k < 30000; k++)
    800018c8:	00000713          	li	a4,0
    800018cc:	000077b7          	lui	a5,0x7
    800018d0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800018d4:	fee7e2e3          	bltu	a5,a4,800018b8 <_Z11workerBodyBv+0x1c>
    800018d8:	00170713          	addi	a4,a4,1
    800018dc:	ff1ff06f          	j	800018cc <_Z11workerBodyBv+0x30>
    for (size_t i = 0; i < 16; i++)
    800018e0:	00148493          	addi	s1,s1,1
    800018e4:	00f00793          	li	a5,15
    800018e8:	0297ec63          	bltu	a5,s1,80001920 <_Z11workerBodyBv+0x84>
        printString("B: i=");
    800018ec:	00003517          	auipc	a0,0x3
    800018f0:	73c50513          	addi	a0,a0,1852 # 80005028 <CONSOLE_STATUS+0x18>
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	7e4080e7          	jalr	2020(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    800018fc:	00048513          	mv	a0,s1
    80001900:	00001097          	auipc	ra,0x1
    80001904:	848080e7          	jalr	-1976(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    80001908:	00003517          	auipc	a0,0x3
    8000190c:	73850513          	addi	a0,a0,1848 # 80005040 <CONSOLE_STATUS+0x30>
    80001910:	00000097          	auipc	ra,0x0
    80001914:	7c8080e7          	jalr	1992(ra) # 800020d8 <_Z11printStringPKc>
        for (size_t j = 0; j < 10000; j++)
    80001918:	00000693          	li	a3,0
    8000191c:	fa1ff06f          	j	800018bc <_Z11workerBodyBv+0x20>
            {
                // busy wait
            }
        }
    }
}
    80001920:	01813083          	ld	ra,24(sp)
    80001924:	01013403          	ld	s0,16(sp)
    80001928:	00813483          	ld	s1,8(sp)
    8000192c:	02010113          	addi	sp,sp,32
    80001930:	00008067          	ret

0000000080001934 <_ZL9fibonaccim>:

static size_t fibonacci(size_t n)
{
    80001934:	fe010113          	addi	sp,sp,-32
    80001938:	00113c23          	sd	ra,24(sp)
    8000193c:	00813823          	sd	s0,16(sp)
    80001940:	00913423          	sd	s1,8(sp)
    80001944:	01213023          	sd	s2,0(sp)
    80001948:	02010413          	addi	s0,sp,32
    8000194c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001950:	00100793          	li	a5,1
    80001954:	02a7f863          	bgeu	a5,a0,80001984 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { PCB::yield(); }
    80001958:	00a00793          	li	a5,10
    8000195c:	02f577b3          	remu	a5,a0,a5
    80001960:	02078e63          	beqz	a5,8000199c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001964:	fff48513          	addi	a0,s1,-1
    80001968:	00000097          	auipc	ra,0x0
    8000196c:	fcc080e7          	jalr	-52(ra) # 80001934 <_ZL9fibonaccim>
    80001970:	00050913          	mv	s2,a0
    80001974:	ffe48513          	addi	a0,s1,-2
    80001978:	00000097          	auipc	ra,0x0
    8000197c:	fbc080e7          	jalr	-68(ra) # 80001934 <_ZL9fibonaccim>
    80001980:	00a90533          	add	a0,s2,a0
}
    80001984:	01813083          	ld	ra,24(sp)
    80001988:	01013403          	ld	s0,16(sp)
    8000198c:	00813483          	ld	s1,8(sp)
    80001990:	00013903          	ld	s2,0(sp)
    80001994:	02010113          	addi	sp,sp,32
    80001998:	00008067          	ret
    if (n % 10 == 0) { PCB::yield(); }
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	ad8080e7          	jalr	-1320(ra) # 80001474 <_ZN3PCB5yieldEv>
    800019a4:	fc1ff06f          	j	80001964 <_ZL9fibonaccim+0x30>

00000000800019a8 <_Z11workerBodyCv>:

void workerBodyC()
{
    800019a8:	fe010113          	addi	sp,sp,-32
    800019ac:	00113c23          	sd	ra,24(sp)
    800019b0:	00813823          	sd	s0,16(sp)
    800019b4:	00913423          	sd	s1,8(sp)
    800019b8:	01213023          	sd	s2,0(sp)
    800019bc:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800019c0:	00000493          	li	s1,0
    800019c4:	0380006f          	j	800019fc <_Z11workerBodyCv+0x54>
    for (; i < 3; i++)
    {
        printString("C: i=");
    800019c8:	00003517          	auipc	a0,0x3
    800019cc:	66850513          	addi	a0,a0,1640 # 80005030 <CONSOLE_STATUS+0x20>
    800019d0:	00000097          	auipc	ra,0x0
    800019d4:	708080e7          	jalr	1800(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    800019d8:	00048513          	mv	a0,s1
    800019dc:	00000097          	auipc	ra,0x0
    800019e0:	76c080e7          	jalr	1900(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    800019e4:	00003517          	auipc	a0,0x3
    800019e8:	65c50513          	addi	a0,a0,1628 # 80005040 <CONSOLE_STATUS+0x30>
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	6ec080e7          	jalr	1772(ra) # 800020d8 <_Z11printStringPKc>
    for (; i < 3; i++)
    800019f4:	0014849b          	addiw	s1,s1,1
    800019f8:	0ff4f493          	andi	s1,s1,255
    800019fc:	00200793          	li	a5,2
    80001a00:	fc97f4e3          	bgeu	a5,s1,800019c8 <_Z11workerBodyCv+0x20>
    }

    printString("C: yield\n");
    80001a04:	00003517          	auipc	a0,0x3
    80001a08:	63450513          	addi	a0,a0,1588 # 80005038 <CONSOLE_STATUS+0x28>
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	6cc080e7          	jalr	1740(ra) # 800020d8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001a14:	00700313          	li	t1,7
    PCB::yield();
    80001a18:	00000097          	auipc	ra,0x0
    80001a1c:	a5c080e7          	jalr	-1444(ra) # 80001474 <_ZN3PCB5yieldEv>

    size_t t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001a20:	00030913          	mv	s2,t1

    printString("C: t1=");
    80001a24:	00003517          	auipc	a0,0x3
    80001a28:	62450513          	addi	a0,a0,1572 # 80005048 <CONSOLE_STATUS+0x38>
    80001a2c:	00000097          	auipc	ra,0x0
    80001a30:	6ac080e7          	jalr	1708(ra) # 800020d8 <_Z11printStringPKc>
    printInteger(t1);
    80001a34:	00090513          	mv	a0,s2
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	710080e7          	jalr	1808(ra) # 80002148 <_Z12printIntegerm>
    printString("\n");
    80001a40:	00003517          	auipc	a0,0x3
    80001a44:	60050513          	addi	a0,a0,1536 # 80005040 <CONSOLE_STATUS+0x30>
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	690080e7          	jalr	1680(ra) # 800020d8 <_Z11printStringPKc>

    size_t result = fibonacci(12);
    80001a50:	00c00513          	li	a0,12
    80001a54:	00000097          	auipc	ra,0x0
    80001a58:	ee0080e7          	jalr	-288(ra) # 80001934 <_ZL9fibonaccim>
    80001a5c:	00050913          	mv	s2,a0
    printString("C: fibonaci=");
    80001a60:	00003517          	auipc	a0,0x3
    80001a64:	5f050513          	addi	a0,a0,1520 # 80005050 <CONSOLE_STATUS+0x40>
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	670080e7          	jalr	1648(ra) # 800020d8 <_Z11printStringPKc>
    printInteger(result);
    80001a70:	00090513          	mv	a0,s2
    80001a74:	00000097          	auipc	ra,0x0
    80001a78:	6d4080e7          	jalr	1748(ra) # 80002148 <_Z12printIntegerm>
    printString("\n");
    80001a7c:	00003517          	auipc	a0,0x3
    80001a80:	5c450513          	addi	a0,a0,1476 # 80005040 <CONSOLE_STATUS+0x30>
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	654080e7          	jalr	1620(ra) # 800020d8 <_Z11printStringPKc>
    80001a8c:	0380006f          	j	80001ac4 <_Z11workerBodyCv+0x11c>

    for (; i < 6; i++)
    {
        printString("C: i=");
    80001a90:	00003517          	auipc	a0,0x3
    80001a94:	5a050513          	addi	a0,a0,1440 # 80005030 <CONSOLE_STATUS+0x20>
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	640080e7          	jalr	1600(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    80001aa0:	00048513          	mv	a0,s1
    80001aa4:	00000097          	auipc	ra,0x0
    80001aa8:	6a4080e7          	jalr	1700(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    80001aac:	00003517          	auipc	a0,0x3
    80001ab0:	59450513          	addi	a0,a0,1428 # 80005040 <CONSOLE_STATUS+0x30>
    80001ab4:	00000097          	auipc	ra,0x0
    80001ab8:	624080e7          	jalr	1572(ra) # 800020d8 <_Z11printStringPKc>
    for (; i < 6; i++)
    80001abc:	0014849b          	addiw	s1,s1,1
    80001ac0:	0ff4f493          	andi	s1,s1,255
    80001ac4:	00500793          	li	a5,5
    80001ac8:	fc97f4e3          	bgeu	a5,s1,80001a90 <_Z11workerBodyCv+0xe8>
    }
//    TCB::yield();
}
    80001acc:	01813083          	ld	ra,24(sp)
    80001ad0:	01013403          	ld	s0,16(sp)
    80001ad4:	00813483          	ld	s1,8(sp)
    80001ad8:	00013903          	ld	s2,0(sp)
    80001adc:	02010113          	addi	sp,sp,32
    80001ae0:	00008067          	ret

0000000080001ae4 <_Z11workerBodyDv>:

void workerBodyD()
{
    80001ae4:	fe010113          	addi	sp,sp,-32
    80001ae8:	00113c23          	sd	ra,24(sp)
    80001aec:	00813823          	sd	s0,16(sp)
    80001af0:	00913423          	sd	s1,8(sp)
    80001af4:	01213023          	sd	s2,0(sp)
    80001af8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001afc:	00a00493          	li	s1,10
    80001b00:	0380006f          	j	80001b38 <_Z11workerBodyDv+0x54>
    for (; i < 13; i++)
    {
        printString("D: i=");
    80001b04:	00003517          	auipc	a0,0x3
    80001b08:	55c50513          	addi	a0,a0,1372 # 80005060 <CONSOLE_STATUS+0x50>
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	5cc080e7          	jalr	1484(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    80001b14:	00048513          	mv	a0,s1
    80001b18:	00000097          	auipc	ra,0x0
    80001b1c:	630080e7          	jalr	1584(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    80001b20:	00003517          	auipc	a0,0x3
    80001b24:	52050513          	addi	a0,a0,1312 # 80005040 <CONSOLE_STATUS+0x30>
    80001b28:	00000097          	auipc	ra,0x0
    80001b2c:	5b0080e7          	jalr	1456(ra) # 800020d8 <_Z11printStringPKc>
    for (; i < 13; i++)
    80001b30:	0014849b          	addiw	s1,s1,1
    80001b34:	0ff4f493          	andi	s1,s1,255
    80001b38:	00c00793          	li	a5,12
    80001b3c:	fc97f4e3          	bgeu	a5,s1,80001b04 <_Z11workerBodyDv+0x20>
    }

    printString("D: yield\n");
    80001b40:	00003517          	auipc	a0,0x3
    80001b44:	52850513          	addi	a0,a0,1320 # 80005068 <CONSOLE_STATUS+0x58>
    80001b48:	00000097          	auipc	ra,0x0
    80001b4c:	590080e7          	jalr	1424(ra) # 800020d8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001b50:	00500313          	li	t1,5
    PCB::yield();
    80001b54:	00000097          	auipc	ra,0x0
    80001b58:	920080e7          	jalr	-1760(ra) # 80001474 <_ZN3PCB5yieldEv>

    size_t result = fibonacci(16);
    80001b5c:	01000513          	li	a0,16
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	dd4080e7          	jalr	-556(ra) # 80001934 <_ZL9fibonaccim>
    80001b68:	00050913          	mv	s2,a0
    printString("D: fibonaci=");
    80001b6c:	00003517          	auipc	a0,0x3
    80001b70:	50c50513          	addi	a0,a0,1292 # 80005078 <CONSOLE_STATUS+0x68>
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	564080e7          	jalr	1380(ra) # 800020d8 <_Z11printStringPKc>
    printInteger(result);
    80001b7c:	00090513          	mv	a0,s2
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	5c8080e7          	jalr	1480(ra) # 80002148 <_Z12printIntegerm>
    printString("\n");
    80001b88:	00003517          	auipc	a0,0x3
    80001b8c:	4b850513          	addi	a0,a0,1208 # 80005040 <CONSOLE_STATUS+0x30>
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	548080e7          	jalr	1352(ra) # 800020d8 <_Z11printStringPKc>
    80001b98:	0380006f          	j	80001bd0 <_Z11workerBodyDv+0xec>

    for (; i < 16; i++)
    {
        printString("D: i=");
    80001b9c:	00003517          	auipc	a0,0x3
    80001ba0:	4c450513          	addi	a0,a0,1220 # 80005060 <CONSOLE_STATUS+0x50>
    80001ba4:	00000097          	auipc	ra,0x0
    80001ba8:	534080e7          	jalr	1332(ra) # 800020d8 <_Z11printStringPKc>
        printInteger(i);
    80001bac:	00048513          	mv	a0,s1
    80001bb0:	00000097          	auipc	ra,0x0
    80001bb4:	598080e7          	jalr	1432(ra) # 80002148 <_Z12printIntegerm>
        printString("\n");
    80001bb8:	00003517          	auipc	a0,0x3
    80001bbc:	48850513          	addi	a0,a0,1160 # 80005040 <CONSOLE_STATUS+0x30>
    80001bc0:	00000097          	auipc	ra,0x0
    80001bc4:	518080e7          	jalr	1304(ra) # 800020d8 <_Z11printStringPKc>
    for (; i < 16; i++)
    80001bc8:	0014849b          	addiw	s1,s1,1
    80001bcc:	0ff4f493          	andi	s1,s1,255
    80001bd0:	00f00793          	li	a5,15
    80001bd4:	fc97f4e3          	bgeu	a5,s1,80001b9c <_Z11workerBodyDv+0xb8>
    }
//    TCB::yield();
}
    80001bd8:	01813083          	ld	ra,24(sp)
    80001bdc:	01013403          	ld	s0,16(sp)
    80001be0:	00813483          	ld	s1,8(sp)
    80001be4:	00013903          	ld	s2,0(sp)
    80001be8:	02010113          	addi	sp,sp,32
    80001bec:	00008067          	ret

0000000080001bf0 <main>:

extern "C" void interrupt();
int main() {
    80001bf0:	fc010113          	addi	sp,sp,-64
    80001bf4:	02113c23          	sd	ra,56(sp)
    80001bf8:	02813823          	sd	s0,48(sp)
    80001bfc:	02913423          	sd	s1,40(sp)
    80001c00:	03213023          	sd	s2,32(sp)
    80001c04:	04010413          	addi	s0,sp,64
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    80001c08:	00004797          	auipc	a5,0x4
    80001c0c:	ce07b783          	ld	a5,-800(a5) # 800058e8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001c10:	10579073          	csrw	stvec,a5
    PCB* main = PCB::createProccess(nullptr, nullptr); // main
    80001c14:	00000593          	li	a1,0
    80001c18:	00000513          	li	a0,0
    80001c1c:	00000097          	auipc	ra,0x0
    80001c20:	a94080e7          	jalr	-1388(ra) # 800016b0 <_ZN3PCB14createProccessEPFvvEPv>
    PCB::running = main;
    80001c24:	00004797          	auipc	a5,0x4
    80001c28:	cb47b783          	ld	a5,-844(a5) # 800058d8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001c2c:	00a7b023          	sd	a0,0(a5)
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001c30:	00200793          	li	a5,2
    80001c34:	1007a073          	csrs	sstatus,a5
    Kernel::ms_sstatus(Kernel::SSTATUS_SIE); // dozvoljavaju se prekidi

    PCB* procesi[4];
    using pf = void(*)(void*);
    thread_create(&procesi[0], (pf)workerBodyA, nullptr);
    80001c38:	00000613          	li	a2,0
    80001c3c:	00000597          	auipc	a1,0x0
    80001c40:	bc858593          	addi	a1,a1,-1080 # 80001804 <_Z11workerBodyAv>
    80001c44:	fc040513          	addi	a0,s0,-64
    80001c48:	fffff097          	auipc	ra,0xfffff
    80001c4c:	5ac080e7          	jalr	1452(ra) # 800011f4 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[1], (pf)workerBodyB, nullptr);
    80001c50:	00000613          	li	a2,0
    80001c54:	00000597          	auipc	a1,0x0
    80001c58:	c4858593          	addi	a1,a1,-952 # 8000189c <_Z11workerBodyBv>
    80001c5c:	fc840513          	addi	a0,s0,-56
    80001c60:	fffff097          	auipc	ra,0xfffff
    80001c64:	594080e7          	jalr	1428(ra) # 800011f4 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[2], (pf)workerBodyC, nullptr);
    80001c68:	00000613          	li	a2,0
    80001c6c:	00000597          	auipc	a1,0x0
    80001c70:	d3c58593          	addi	a1,a1,-708 # 800019a8 <_Z11workerBodyCv>
    80001c74:	fd040513          	addi	a0,s0,-48
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	57c080e7          	jalr	1404(ra) # 800011f4 <_Z13thread_createPP3PCBPFvPvES2_>
    thread_create(&procesi[3], (pf)workerBodyD, nullptr);
    80001c80:	00000613          	li	a2,0
    80001c84:	00000597          	auipc	a1,0x0
    80001c88:	e6058593          	addi	a1,a1,-416 # 80001ae4 <_Z11workerBodyDv>
    80001c8c:	fd840513          	addi	a0,s0,-40
    80001c90:	fffff097          	auipc	ra,0xfffff
    80001c94:	564080e7          	jalr	1380(ra) # 800011f4 <_Z13thread_createPP3PCBPFvPvES2_>
    80001c98:	00c0006f          	j	80001ca4 <main+0xb4>


    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
        PCB::yield();
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	7d8080e7          	jalr	2008(ra) # 80001474 <_ZN3PCB5yieldEv>
    while(!procesi[0]->isFinished() || !procesi[1]->isFinished() || !procesi[2]->isFinished() || !procesi[3]->isFinished()) {
    80001ca4:	fc043783          	ld	a5,-64(s0)
    80001ca8:	0287c783          	lbu	a5,40(a5)
    80001cac:	fe0788e3          	beqz	a5,80001c9c <main+0xac>
    80001cb0:	fc843783          	ld	a5,-56(s0)
    80001cb4:	0287c783          	lbu	a5,40(a5)
    80001cb8:	fe0782e3          	beqz	a5,80001c9c <main+0xac>
    80001cbc:	fd043783          	ld	a5,-48(s0)
    80001cc0:	0287c783          	lbu	a5,40(a5)
    80001cc4:	fc078ce3          	beqz	a5,80001c9c <main+0xac>
    80001cc8:	fd843783          	ld	a5,-40(s0)
    80001ccc:	0287c783          	lbu	a5,40(a5)
    80001cd0:	fc0786e3          	beqz	a5,80001c9c <main+0xac>
    80001cd4:	fc040493          	addi	s1,s0,-64
    80001cd8:	0080006f          	j	80001ce0 <main+0xf0>
    }

    for(auto& proces : procesi) {
    80001cdc:	00848493          	addi	s1,s1,8
    80001ce0:	fe040793          	addi	a5,s0,-32
    80001ce4:	02f48463          	beq	s1,a5,80001d0c <main+0x11c>
        delete proces;
    80001ce8:	0004b903          	ld	s2,0(s1)
    80001cec:	fe0908e3          	beqz	s2,80001cdc <main+0xec>
    80001cf0:	00090513          	mv	a0,s2
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	938080e7          	jalr	-1736(ra) # 8000162c <_ZN3PCBD1Ev>
    80001cfc:	00090513          	mv	a0,s2
    80001d00:	00000097          	auipc	ra,0x0
    80001d04:	988080e7          	jalr	-1656(ra) # 80001688 <_ZN3PCBdlEPv>
    80001d08:	fd5ff06f          	j	80001cdc <main+0xec>
    }

    return 0;
}
    80001d0c:	00000513          	li	a0,0
    80001d10:	03813083          	ld	ra,56(sp)
    80001d14:	03013403          	ld	s0,48(sp)
    80001d18:	02813483          	ld	s1,40(sp)
    80001d1c:	02013903          	ld	s2,32(sp)
    80001d20:	04010113          	addi	sp,sp,64
    80001d24:	00008067          	ret

0000000080001d28 <_Znwm>:
#include "../h/syscall_cpp.h"

void* operator new (size_t size) {
    80001d28:	ff010113          	addi	sp,sp,-16
    80001d2c:	00113423          	sd	ra,8(sp)
    80001d30:	00813023          	sd	s0,0(sp)
    80001d34:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001d38:	fffff097          	auipc	ra,0xfffff
    80001d3c:	440080e7          	jalr	1088(ra) # 80001178 <_Z9mem_allocm>
}
    80001d40:	00813083          	ld	ra,8(sp)
    80001d44:	00013403          	ld	s0,0(sp)
    80001d48:	01010113          	addi	sp,sp,16
    80001d4c:	00008067          	ret

0000000080001d50 <_Znam>:
void* operator new [](size_t size) {
    80001d50:	ff010113          	addi	sp,sp,-16
    80001d54:	00113423          	sd	ra,8(sp)
    80001d58:	00813023          	sd	s0,0(sp)
    80001d5c:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	418080e7          	jalr	1048(ra) # 80001178 <_Z9mem_allocm>
}
    80001d68:	00813083          	ld	ra,8(sp)
    80001d6c:	00013403          	ld	s0,0(sp)
    80001d70:	01010113          	addi	sp,sp,16
    80001d74:	00008067          	ret

0000000080001d78 <_ZdlPv>:
void operator delete (void* memSegment) noexcept {
    80001d78:	ff010113          	addi	sp,sp,-16
    80001d7c:	00113423          	sd	ra,8(sp)
    80001d80:	00813023          	sd	s0,0(sp)
    80001d84:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001d88:	fffff097          	auipc	ra,0xfffff
    80001d8c:	434080e7          	jalr	1076(ra) # 800011bc <_Z8mem_freePv>
}
    80001d90:	00813083          	ld	ra,8(sp)
    80001d94:	00013403          	ld	s0,0(sp)
    80001d98:	01010113          	addi	sp,sp,16
    80001d9c:	00008067          	ret

0000000080001da0 <_ZdaPv>:
void operator delete [](void* memSegment) noexcept {
    80001da0:	ff010113          	addi	sp,sp,-16
    80001da4:	00113423          	sd	ra,8(sp)
    80001da8:	00813023          	sd	s0,0(sp)
    80001dac:	01010413          	addi	s0,sp,16
    mem_free(memSegment);
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	40c080e7          	jalr	1036(ra) # 800011bc <_Z8mem_freePv>
    80001db8:	00813083          	ld	ra,8(sp)
    80001dbc:	00013403          	ld	s0,0(sp)
    80001dc0:	01010113          	addi	sp,sp,16
    80001dc4:	00008067          	ret

0000000080001dc8 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001dc8:	ff010113          	addi	sp,sp,-16
    80001dcc:	00813423          	sd	s0,8(sp)
    80001dd0:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    80001dd4:	00004797          	auipc	a5,0x4
    80001dd8:	b847b783          	ld	a5,-1148(a5) # 80005958 <_ZN15MemoryAllocator4headE>
    80001ddc:	02078c63          	beqz	a5,80001e14 <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001de0:	00004717          	auipc	a4,0x4
    80001de4:	b0073703          	ld	a4,-1280(a4) # 800058e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001de8:	00073703          	ld	a4,0(a4)
    80001dec:	12e78c63          	beq	a5,a4,80001f24 <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001df0:	00850713          	addi	a4,a0,8
    80001df4:	00675813          	srli	a6,a4,0x6
    80001df8:	03f77793          	andi	a5,a4,63
    80001dfc:	00f037b3          	snez	a5,a5
    80001e00:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    80001e04:	00004517          	auipc	a0,0x4
    80001e08:	b5453503          	ld	a0,-1196(a0) # 80005958 <_ZN15MemoryAllocator4headE>
    80001e0c:	00000613          	li	a2,0
    80001e10:	0a80006f          	j	80001eb8 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    80001e14:	00004697          	auipc	a3,0x4
    80001e18:	aac6b683          	ld	a3,-1364(a3) # 800058c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001e1c:	0006b783          	ld	a5,0(a3)
    80001e20:	00004717          	auipc	a4,0x4
    80001e24:	b2f73c23          	sd	a5,-1224(a4) # 80005958 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    80001e28:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    80001e2c:	00004717          	auipc	a4,0x4
    80001e30:	ab473703          	ld	a4,-1356(a4) # 800058e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001e34:	00073703          	ld	a4,0(a4)
    80001e38:	0006b683          	ld	a3,0(a3)
    80001e3c:	40d70733          	sub	a4,a4,a3
    80001e40:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    80001e44:	0007b823          	sd	zero,16(a5)
    80001e48:	fa9ff06f          	j	80001df0 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001e4c:	00060e63          	beqz	a2,80001e68 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001e50:	01063703          	ld	a4,16(a2)
    80001e54:	04070a63          	beqz	a4,80001ea8 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001e58:	01073703          	ld	a4,16(a4)
    80001e5c:	00e63823          	sd	a4,16(a2)
                allocatedSize = curr->size;
    80001e60:	00078813          	mv	a6,a5
    80001e64:	0ac0006f          	j	80001f10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001e68:	01053703          	ld	a4,16(a0)
    80001e6c:	00070a63          	beqz	a4,80001e80 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001e70:	00004697          	auipc	a3,0x4
    80001e74:	aee6b423          	sd	a4,-1304(a3) # 80005958 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001e78:	00078813          	mv	a6,a5
    80001e7c:	0940006f          	j	80001f10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001e80:	00004717          	auipc	a4,0x4
    80001e84:	a6073703          	ld	a4,-1440(a4) # 800058e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001e88:	00073703          	ld	a4,0(a4)
    80001e8c:	00004697          	auipc	a3,0x4
    80001e90:	ace6b623          	sd	a4,-1332(a3) # 80005958 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001e94:	00078813          	mv	a6,a5
    80001e98:	0780006f          	j	80001f10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001e9c:	00004797          	auipc	a5,0x4
    80001ea0:	aae7be23          	sd	a4,-1348(a5) # 80005958 <_ZN15MemoryAllocator4headE>
    80001ea4:	06c0006f          	j	80001f10 <_ZN15MemoryAllocator9mem_allocEm+0x148>
                allocatedSize = curr->size;
    80001ea8:	00078813          	mv	a6,a5
    80001eac:	0640006f          	j	80001f10 <_ZN15MemoryAllocator9mem_allocEm+0x148>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001eb0:	00050613          	mv	a2,a0
        curr = curr->next;
    80001eb4:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001eb8:	06050063          	beqz	a0,80001f18 <_ZN15MemoryAllocator9mem_allocEm+0x150>
        size_t freeSegSizeInBlocks = (curr->size/MEM_BLOCK_SIZE); // zaokruzujemo da donji ceo deo
    80001ebc:	00853783          	ld	a5,8(a0)
    80001ec0:	0067d693          	srli	a3,a5,0x6
        void* startOfAllocatedSpace = curr->baseAddr;
    80001ec4:	00053583          	ld	a1,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    80001ec8:	fee7e4e3          	bltu	a5,a4,80001eb0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001ecc:	ff06e2e3          	bltu	a3,a6,80001eb0 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001ed0:	f7068ee3          	beq	a3,a6,80001e4c <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001ed4:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    80001ed8:	01058733          	add	a4,a1,a6
                size_t newSize = curr->size - allocatedSize;
    80001edc:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001ee0:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001ee4:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    80001ee8:	01053783          	ld	a5,16(a0)
    80001eec:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    80001ef0:	fa0606e3          	beqz	a2,80001e9c <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    80001ef4:	01063783          	ld	a5,16(a2)
    80001ef8:	00078663          	beqz	a5,80001f04 <_ZN15MemoryAllocator9mem_allocEm+0x13c>
            prev->next = curr->next;
    80001efc:	0107b783          	ld	a5,16(a5)
    80001f00:	00f63823          	sd	a5,16(a2)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    80001f04:	01063783          	ld	a5,16(a2)
    80001f08:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    80001f0c:	00a63823          	sd	a0,16(a2)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    80001f10:	0105b023          	sd	a6,0(a1)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    80001f14:	00858513          	addi	a0,a1,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    80001f18:	00813403          	ld	s0,8(sp)
    80001f1c:	01010113          	addi	sp,sp,16
    80001f20:	00008067          	ret
        return nullptr;
    80001f24:	00000513          	li	a0,0
    80001f28:	ff1ff06f          	j	80001f18 <_ZN15MemoryAllocator9mem_allocEm+0x150>

0000000080001f2c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    80001f2c:	ff010113          	addi	sp,sp,-16
    80001f30:	00813423          	sd	s0,8(sp)
    80001f34:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80001f38:	16050063          	beqz	a0,80002098 <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001f3c:	ff850713          	addi	a4,a0,-8
    80001f40:	00004797          	auipc	a5,0x4
    80001f44:	9807b783          	ld	a5,-1664(a5) # 800058c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001f48:	0007b783          	ld	a5,0(a5)
    80001f4c:	14f76a63          	bltu	a4,a5,800020a0 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001f50:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001f54:	fff58693          	addi	a3,a1,-1
    80001f58:	00d706b3          	add	a3,a4,a3
    80001f5c:	00004617          	auipc	a2,0x4
    80001f60:	98463603          	ld	a2,-1660(a2) # 800058e0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001f64:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001f68:	14c6f063          	bgeu	a3,a2,800020a8 <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001f6c:	14070263          	beqz	a4,800020b0 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001f70:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001f74:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    80001f78:	14079063          	bnez	a5,800020b8 <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001f7c:	03f00793          	li	a5,63
    80001f80:	14b7f063          	bgeu	a5,a1,800020c0 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001f84:	00004797          	auipc	a5,0x4
    80001f88:	9d47b783          	ld	a5,-1580(a5) # 80005958 <_ZN15MemoryAllocator4headE>
    80001f8c:	02f60063          	beq	a2,a5,80001fac <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001f90:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001f94:	02078a63          	beqz	a5,80001fc8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    80001f98:	0007b683          	ld	a3,0(a5)
    80001f9c:	02e6f663          	bgeu	a3,a4,80001fc8 <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001fa0:	00078613          	mv	a2,a5
        curr = curr->next;
    80001fa4:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001fa8:	fedff06f          	j	80001f94 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001fac:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001fb0:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001fb4:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    80001fb8:	00004797          	auipc	a5,0x4
    80001fbc:	9ae7b023          	sd	a4,-1632(a5) # 80005958 <_ZN15MemoryAllocator4headE>
        return 0;
    80001fc0:	00000513          	li	a0,0
    80001fc4:	0480006f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    80001fc8:	04060863          	beqz	a2,80002018 <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001fcc:	00063683          	ld	a3,0(a2)
    80001fd0:	00863803          	ld	a6,8(a2)
    80001fd4:	010686b3          	add	a3,a3,a6
    80001fd8:	08e68a63          	beq	a3,a4,8000206c <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80001fdc:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001fe0:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001fe4:	01063683          	ld	a3,16(a2)
    80001fe8:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    80001fec:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    80001ff0:	0e078063          	beqz	a5,800020d0 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80001ff4:	0007b583          	ld	a1,0(a5)
    80001ff8:	00073683          	ld	a3,0(a4)
    80001ffc:	00873603          	ld	a2,8(a4)
    80002000:	00c686b3          	add	a3,a3,a2
    80002004:	06d58c63          	beq	a1,a3,8000207c <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    80002008:	00000513          	li	a0,0
}
    8000200c:	00813403          	ld	s0,8(sp)
    80002010:	01010113          	addi	sp,sp,16
    80002014:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    80002018:	0a078863          	beqz	a5,800020c8 <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    8000201c:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80002020:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    80002024:	00004797          	auipc	a5,0x4
    80002028:	9347b783          	ld	a5,-1740(a5) # 80005958 <_ZN15MemoryAllocator4headE>
    8000202c:	0007b603          	ld	a2,0(a5)
    80002030:	00b706b3          	add	a3,a4,a1
    80002034:	00d60c63          	beq	a2,a3,8000204c <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    80002038:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    8000203c:	00004797          	auipc	a5,0x4
    80002040:	90e7be23          	sd	a4,-1764(a5) # 80005958 <_ZN15MemoryAllocator4headE>
            return 0;
    80002044:	00000513          	li	a0,0
    80002048:	fc5ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    8000204c:	0087b783          	ld	a5,8(a5)
    80002050:	00b785b3          	add	a1,a5,a1
    80002054:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    80002058:	00004797          	auipc	a5,0x4
    8000205c:	9007b783          	ld	a5,-1792(a5) # 80005958 <_ZN15MemoryAllocator4headE>
    80002060:	0107b783          	ld	a5,16(a5)
    80002064:	00f53423          	sd	a5,8(a0)
    80002068:	fd5ff06f          	j	8000203c <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    8000206c:	00b805b3          	add	a1,a6,a1
    80002070:	00b63423          	sd	a1,8(a2)
    80002074:	00060713          	mv	a4,a2
    80002078:	f79ff06f          	j	80001ff0 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    8000207c:	0087b683          	ld	a3,8(a5)
    80002080:	00d60633          	add	a2,a2,a3
    80002084:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    80002088:	0107b783          	ld	a5,16(a5)
    8000208c:	00f73823          	sd	a5,16(a4)
    return 0;
    80002090:	00000513          	li	a0,0
    80002094:	f79ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    80002098:	fff00513          	li	a0,-1
    8000209c:	f71ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800020a0:	fff00513          	li	a0,-1
    800020a4:	f69ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    800020a8:	fff00513          	li	a0,-1
    800020ac:	f61ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800020b0:	fff00513          	li	a0,-1
    800020b4:	f59ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800020b8:	fff00513          	li	a0,-1
    800020bc:	f51ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    800020c0:	fff00513          	li	a0,-1
    800020c4:	f49ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    800020c8:	fff00513          	li	a0,-1
    800020cc:	f41ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    800020d0:	00000513          	li	a0,0
    800020d4:	f39ff06f          	j	8000200c <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

00000000800020d8 <_Z11printStringPKc>:
#include "../h/print.h"
#include "../h/console.h"
#include "../h/kernel.h"

void printString(char const *string)
{
    800020d8:	fd010113          	addi	sp,sp,-48
    800020dc:	02113423          	sd	ra,40(sp)
    800020e0:	02813023          	sd	s0,32(sp)
    800020e4:	00913c23          	sd	s1,24(sp)
    800020e8:	01213823          	sd	s2,16(sp)
    800020ec:	03010413          	addi	s0,sp,48
    800020f0:	00050493          	mv	s1,a0
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800020f4:	100027f3          	csrr	a5,sstatus
    800020f8:	fcf43c23          	sd	a5,-40(s0)
        return sstatus;
    800020fc:	fd843903          	ld	s2,-40(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002100:	00200793          	li	a5,2
    80002104:	1007b073          	csrc	sstatus,a5
    size_t sstatus = Kernel::r_sstatus();
    Kernel::mc_sstatus(Kernel::SSTATUS_SIE);
    while (*string != '\0')
    80002108:	0004c503          	lbu	a0,0(s1)
    8000210c:	00050a63          	beqz	a0,80002120 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    80002110:	00002097          	auipc	ra,0x2
    80002114:	23c080e7          	jalr	572(ra) # 8000434c <__putc>
        string++;
    80002118:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000211c:	fedff06f          	j	80002108 <_Z11printStringPKc+0x30>
    }
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    80002120:	0009091b          	sext.w	s2,s2
    80002124:	00297913          	andi	s2,s2,2
    80002128:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000212c:	10092073          	csrs	sstatus,s2
}
    80002130:	02813083          	ld	ra,40(sp)
    80002134:	02013403          	ld	s0,32(sp)
    80002138:	01813483          	ld	s1,24(sp)
    8000213c:	01013903          	ld	s2,16(sp)
    80002140:	03010113          	addi	sp,sp,48
    80002144:	00008067          	ret

0000000080002148 <_Z12printIntegerm>:

void printInteger(size_t integer)
{
    80002148:	fc010113          	addi	sp,sp,-64
    8000214c:	02113c23          	sd	ra,56(sp)
    80002150:	02813823          	sd	s0,48(sp)
    80002154:	02913423          	sd	s1,40(sp)
    80002158:	03213023          	sd	s2,32(sp)
    8000215c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002160:	100027f3          	csrr	a5,sstatus
    80002164:	fcf43423          	sd	a5,-56(s0)
        return sstatus;
    80002168:	fc843903          	ld	s2,-56(s0)
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    8000216c:	00200793          	li	a5,2
    80002170:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80002174:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002178:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    8000217c:	00a00613          	li	a2,10
    80002180:	02c5773b          	remuw	a4,a0,a2
    80002184:	02071693          	slli	a3,a4,0x20
    80002188:	0206d693          	srli	a3,a3,0x20
    8000218c:	00003717          	auipc	a4,0x3
    80002190:	f2470713          	addi	a4,a4,-220 # 800050b0 <_ZZ12printIntegermE6digits>
    80002194:	00d70733          	add	a4,a4,a3
    80002198:	00074703          	lbu	a4,0(a4)
    8000219c:	fe040693          	addi	a3,s0,-32
    800021a0:	009687b3          	add	a5,a3,s1
    800021a4:	0014849b          	addiw	s1,s1,1
    800021a8:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    800021ac:	0005071b          	sext.w	a4,a0
    800021b0:	02c5553b          	divuw	a0,a0,a2
    800021b4:	00900793          	li	a5,9
    800021b8:	fce7e2e3          	bltu	a5,a4,8000217c <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    800021bc:	fff4849b          	addiw	s1,s1,-1
    800021c0:	0004ce63          	bltz	s1,800021dc <_Z12printIntegerm+0x94>
    800021c4:	fe040793          	addi	a5,s0,-32
    800021c8:	009787b3          	add	a5,a5,s1
    800021cc:	ff07c503          	lbu	a0,-16(a5)
    800021d0:	00002097          	auipc	ra,0x2
    800021d4:	17c080e7          	jalr	380(ra) # 8000434c <__putc>
    800021d8:	fe5ff06f          	j	800021bc <_Z12printIntegerm+0x74>
    Kernel::ms_sstatus(sstatus & Kernel::SSTATUS_SIE ? Kernel::SSTATUS_SIE : 0);
    800021dc:	0009091b          	sext.w	s2,s2
    800021e0:	00297913          	andi	s2,s2,2
    800021e4:	0009091b          	sext.w	s2,s2
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800021e8:	10092073          	csrs	sstatus,s2
}
    800021ec:	03813083          	ld	ra,56(sp)
    800021f0:	03013403          	ld	s0,48(sp)
    800021f4:	02813483          	ld	s1,40(sp)
    800021f8:	02013903          	ld	s2,32(sp)
    800021fc:	04010113          	addi	sp,sp,64
    80002200:	00008067          	ret

0000000080002204 <_Z10printErrorv>:
void printError() {
    80002204:	fd010113          	addi	sp,sp,-48
    80002208:	02113423          	sd	ra,40(sp)
    8000220c:	02813023          	sd	s0,32(sp)
    80002210:	03010413          	addi	s0,sp,48
    printString("scause: ");
    80002214:	00003517          	auipc	a0,0x3
    80002218:	e7450513          	addi	a0,a0,-396 # 80005088 <CONSOLE_STATUS+0x78>
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	ebc080e7          	jalr	-324(ra) # 800020d8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002224:	142027f3          	csrr	a5,scause
    80002228:	fef43423          	sd	a5,-24(s0)
        return scause;
    8000222c:	fe843503          	ld	a0,-24(s0)
    printInteger(Kernel::r_scause());
    80002230:	00000097          	auipc	ra,0x0
    80002234:	f18080e7          	jalr	-232(ra) # 80002148 <_Z12printIntegerm>
    printString("\nsepc: ");
    80002238:	00003517          	auipc	a0,0x3
    8000223c:	e6050513          	addi	a0,a0,-416 # 80005098 <CONSOLE_STATUS+0x88>
    80002240:	00000097          	auipc	ra,0x0
    80002244:	e98080e7          	jalr	-360(ra) # 800020d8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002248:	141027f3          	csrr	a5,sepc
    8000224c:	fef43023          	sd	a5,-32(s0)
        return sepc;
    80002250:	fe043503          	ld	a0,-32(s0)
    printInteger(Kernel::r_sepc());
    80002254:	00000097          	auipc	ra,0x0
    80002258:	ef4080e7          	jalr	-268(ra) # 80002148 <_Z12printIntegerm>
    printString("\nstval: ");
    8000225c:	00003517          	auipc	a0,0x3
    80002260:	e4450513          	addi	a0,a0,-444 # 800050a0 <CONSOLE_STATUS+0x90>
    80002264:	00000097          	auipc	ra,0x0
    80002268:	e74080e7          	jalr	-396(ra) # 800020d8 <_Z11printStringPKc>
        __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    8000226c:	143027f3          	csrr	a5,stval
    80002270:	fcf43c23          	sd	a5,-40(s0)
        return stval;
    80002274:	fd843503          	ld	a0,-40(s0)
    printInteger(Kernel::r_stval());
    80002278:	00000097          	auipc	ra,0x0
    8000227c:	ed0080e7          	jalr	-304(ra) # 80002148 <_Z12printIntegerm>
    80002280:	02813083          	ld	ra,40(sp)
    80002284:	02013403          	ld	s0,32(sp)
    80002288:	03010113          	addi	sp,sp,48
    8000228c:	00008067          	ret

0000000080002290 <start>:
    80002290:	ff010113          	addi	sp,sp,-16
    80002294:	00813423          	sd	s0,8(sp)
    80002298:	01010413          	addi	s0,sp,16
    8000229c:	300027f3          	csrr	a5,mstatus
    800022a0:	ffffe737          	lui	a4,0xffffe
    800022a4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7c3f>
    800022a8:	00e7f7b3          	and	a5,a5,a4
    800022ac:	00001737          	lui	a4,0x1
    800022b0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800022b4:	00e7e7b3          	or	a5,a5,a4
    800022b8:	30079073          	csrw	mstatus,a5
    800022bc:	00000797          	auipc	a5,0x0
    800022c0:	16078793          	addi	a5,a5,352 # 8000241c <system_main>
    800022c4:	34179073          	csrw	mepc,a5
    800022c8:	00000793          	li	a5,0
    800022cc:	18079073          	csrw	satp,a5
    800022d0:	000107b7          	lui	a5,0x10
    800022d4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022d8:	30279073          	csrw	medeleg,a5
    800022dc:	30379073          	csrw	mideleg,a5
    800022e0:	104027f3          	csrr	a5,sie
    800022e4:	2227e793          	ori	a5,a5,546
    800022e8:	10479073          	csrw	sie,a5
    800022ec:	fff00793          	li	a5,-1
    800022f0:	00a7d793          	srli	a5,a5,0xa
    800022f4:	3b079073          	csrw	pmpaddr0,a5
    800022f8:	00f00793          	li	a5,15
    800022fc:	3a079073          	csrw	pmpcfg0,a5
    80002300:	f14027f3          	csrr	a5,mhartid
    80002304:	0200c737          	lui	a4,0x200c
    80002308:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000230c:	0007869b          	sext.w	a3,a5
    80002310:	00269713          	slli	a4,a3,0x2
    80002314:	000f4637          	lui	a2,0xf4
    80002318:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000231c:	00d70733          	add	a4,a4,a3
    80002320:	0037979b          	slliw	a5,a5,0x3
    80002324:	020046b7          	lui	a3,0x2004
    80002328:	00d787b3          	add	a5,a5,a3
    8000232c:	00c585b3          	add	a1,a1,a2
    80002330:	00371693          	slli	a3,a4,0x3
    80002334:	00003717          	auipc	a4,0x3
    80002338:	62c70713          	addi	a4,a4,1580 # 80005960 <timer_scratch>
    8000233c:	00b7b023          	sd	a1,0(a5)
    80002340:	00d70733          	add	a4,a4,a3
    80002344:	00f73c23          	sd	a5,24(a4)
    80002348:	02c73023          	sd	a2,32(a4)
    8000234c:	34071073          	csrw	mscratch,a4
    80002350:	00000797          	auipc	a5,0x0
    80002354:	6e078793          	addi	a5,a5,1760 # 80002a30 <timervec>
    80002358:	30579073          	csrw	mtvec,a5
    8000235c:	300027f3          	csrr	a5,mstatus
    80002360:	0087e793          	ori	a5,a5,8
    80002364:	30079073          	csrw	mstatus,a5
    80002368:	304027f3          	csrr	a5,mie
    8000236c:	0807e793          	ori	a5,a5,128
    80002370:	30479073          	csrw	mie,a5
    80002374:	f14027f3          	csrr	a5,mhartid
    80002378:	0007879b          	sext.w	a5,a5
    8000237c:	00078213          	mv	tp,a5
    80002380:	30200073          	mret
    80002384:	00813403          	ld	s0,8(sp)
    80002388:	01010113          	addi	sp,sp,16
    8000238c:	00008067          	ret

0000000080002390 <timerinit>:
    80002390:	ff010113          	addi	sp,sp,-16
    80002394:	00813423          	sd	s0,8(sp)
    80002398:	01010413          	addi	s0,sp,16
    8000239c:	f14027f3          	csrr	a5,mhartid
    800023a0:	0200c737          	lui	a4,0x200c
    800023a4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800023a8:	0007869b          	sext.w	a3,a5
    800023ac:	00269713          	slli	a4,a3,0x2
    800023b0:	000f4637          	lui	a2,0xf4
    800023b4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800023b8:	00d70733          	add	a4,a4,a3
    800023bc:	0037979b          	slliw	a5,a5,0x3
    800023c0:	020046b7          	lui	a3,0x2004
    800023c4:	00d787b3          	add	a5,a5,a3
    800023c8:	00c585b3          	add	a1,a1,a2
    800023cc:	00371693          	slli	a3,a4,0x3
    800023d0:	00003717          	auipc	a4,0x3
    800023d4:	59070713          	addi	a4,a4,1424 # 80005960 <timer_scratch>
    800023d8:	00b7b023          	sd	a1,0(a5)
    800023dc:	00d70733          	add	a4,a4,a3
    800023e0:	00f73c23          	sd	a5,24(a4)
    800023e4:	02c73023          	sd	a2,32(a4)
    800023e8:	34071073          	csrw	mscratch,a4
    800023ec:	00000797          	auipc	a5,0x0
    800023f0:	64478793          	addi	a5,a5,1604 # 80002a30 <timervec>
    800023f4:	30579073          	csrw	mtvec,a5
    800023f8:	300027f3          	csrr	a5,mstatus
    800023fc:	0087e793          	ori	a5,a5,8
    80002400:	30079073          	csrw	mstatus,a5
    80002404:	304027f3          	csrr	a5,mie
    80002408:	0807e793          	ori	a5,a5,128
    8000240c:	30479073          	csrw	mie,a5
    80002410:	00813403          	ld	s0,8(sp)
    80002414:	01010113          	addi	sp,sp,16
    80002418:	00008067          	ret

000000008000241c <system_main>:
    8000241c:	fe010113          	addi	sp,sp,-32
    80002420:	00813823          	sd	s0,16(sp)
    80002424:	00913423          	sd	s1,8(sp)
    80002428:	00113c23          	sd	ra,24(sp)
    8000242c:	02010413          	addi	s0,sp,32
    80002430:	00000097          	auipc	ra,0x0
    80002434:	0c4080e7          	jalr	196(ra) # 800024f4 <cpuid>
    80002438:	00003497          	auipc	s1,0x3
    8000243c:	4c848493          	addi	s1,s1,1224 # 80005900 <started>
    80002440:	02050263          	beqz	a0,80002464 <system_main+0x48>
    80002444:	0004a783          	lw	a5,0(s1)
    80002448:	0007879b          	sext.w	a5,a5
    8000244c:	fe078ce3          	beqz	a5,80002444 <system_main+0x28>
    80002450:	0ff0000f          	fence
    80002454:	00003517          	auipc	a0,0x3
    80002458:	c9c50513          	addi	a0,a0,-868 # 800050f0 <_ZZ12printIntegermE6digits+0x40>
    8000245c:	00001097          	auipc	ra,0x1
    80002460:	a70080e7          	jalr	-1424(ra) # 80002ecc <panic>
    80002464:	00001097          	auipc	ra,0x1
    80002468:	9c4080e7          	jalr	-1596(ra) # 80002e28 <consoleinit>
    8000246c:	00001097          	auipc	ra,0x1
    80002470:	150080e7          	jalr	336(ra) # 800035bc <printfinit>
    80002474:	00003517          	auipc	a0,0x3
    80002478:	bcc50513          	addi	a0,a0,-1076 # 80005040 <CONSOLE_STATUS+0x30>
    8000247c:	00001097          	auipc	ra,0x1
    80002480:	aac080e7          	jalr	-1364(ra) # 80002f28 <__printf>
    80002484:	00003517          	auipc	a0,0x3
    80002488:	c3c50513          	addi	a0,a0,-964 # 800050c0 <_ZZ12printIntegermE6digits+0x10>
    8000248c:	00001097          	auipc	ra,0x1
    80002490:	a9c080e7          	jalr	-1380(ra) # 80002f28 <__printf>
    80002494:	00003517          	auipc	a0,0x3
    80002498:	bac50513          	addi	a0,a0,-1108 # 80005040 <CONSOLE_STATUS+0x30>
    8000249c:	00001097          	auipc	ra,0x1
    800024a0:	a8c080e7          	jalr	-1396(ra) # 80002f28 <__printf>
    800024a4:	00001097          	auipc	ra,0x1
    800024a8:	4a4080e7          	jalr	1188(ra) # 80003948 <kinit>
    800024ac:	00000097          	auipc	ra,0x0
    800024b0:	148080e7          	jalr	328(ra) # 800025f4 <trapinit>
    800024b4:	00000097          	auipc	ra,0x0
    800024b8:	16c080e7          	jalr	364(ra) # 80002620 <trapinithart>
    800024bc:	00000097          	auipc	ra,0x0
    800024c0:	5b4080e7          	jalr	1460(ra) # 80002a70 <plicinit>
    800024c4:	00000097          	auipc	ra,0x0
    800024c8:	5d4080e7          	jalr	1492(ra) # 80002a98 <plicinithart>
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	078080e7          	jalr	120(ra) # 80002544 <userinit>
    800024d4:	0ff0000f          	fence
    800024d8:	00100793          	li	a5,1
    800024dc:	00003517          	auipc	a0,0x3
    800024e0:	bfc50513          	addi	a0,a0,-1028 # 800050d8 <_ZZ12printIntegermE6digits+0x28>
    800024e4:	00f4a023          	sw	a5,0(s1)
    800024e8:	00001097          	auipc	ra,0x1
    800024ec:	a40080e7          	jalr	-1472(ra) # 80002f28 <__printf>
    800024f0:	0000006f          	j	800024f0 <system_main+0xd4>

00000000800024f4 <cpuid>:
    800024f4:	ff010113          	addi	sp,sp,-16
    800024f8:	00813423          	sd	s0,8(sp)
    800024fc:	01010413          	addi	s0,sp,16
    80002500:	00020513          	mv	a0,tp
    80002504:	00813403          	ld	s0,8(sp)
    80002508:	0005051b          	sext.w	a0,a0
    8000250c:	01010113          	addi	sp,sp,16
    80002510:	00008067          	ret

0000000080002514 <mycpu>:
    80002514:	ff010113          	addi	sp,sp,-16
    80002518:	00813423          	sd	s0,8(sp)
    8000251c:	01010413          	addi	s0,sp,16
    80002520:	00020793          	mv	a5,tp
    80002524:	00813403          	ld	s0,8(sp)
    80002528:	0007879b          	sext.w	a5,a5
    8000252c:	00779793          	slli	a5,a5,0x7
    80002530:	00004517          	auipc	a0,0x4
    80002534:	46050513          	addi	a0,a0,1120 # 80006990 <cpus>
    80002538:	00f50533          	add	a0,a0,a5
    8000253c:	01010113          	addi	sp,sp,16
    80002540:	00008067          	ret

0000000080002544 <userinit>:
    80002544:	ff010113          	addi	sp,sp,-16
    80002548:	00813423          	sd	s0,8(sp)
    8000254c:	01010413          	addi	s0,sp,16
    80002550:	00813403          	ld	s0,8(sp)
    80002554:	01010113          	addi	sp,sp,16
    80002558:	fffff317          	auipc	t1,0xfffff
    8000255c:	69830067          	jr	1688(t1) # 80001bf0 <main>

0000000080002560 <either_copyout>:
    80002560:	ff010113          	addi	sp,sp,-16
    80002564:	00813023          	sd	s0,0(sp)
    80002568:	00113423          	sd	ra,8(sp)
    8000256c:	01010413          	addi	s0,sp,16
    80002570:	02051663          	bnez	a0,8000259c <either_copyout+0x3c>
    80002574:	00058513          	mv	a0,a1
    80002578:	00060593          	mv	a1,a2
    8000257c:	0006861b          	sext.w	a2,a3
    80002580:	00002097          	auipc	ra,0x2
    80002584:	c54080e7          	jalr	-940(ra) # 800041d4 <__memmove>
    80002588:	00813083          	ld	ra,8(sp)
    8000258c:	00013403          	ld	s0,0(sp)
    80002590:	00000513          	li	a0,0
    80002594:	01010113          	addi	sp,sp,16
    80002598:	00008067          	ret
    8000259c:	00003517          	auipc	a0,0x3
    800025a0:	b7c50513          	addi	a0,a0,-1156 # 80005118 <_ZZ12printIntegermE6digits+0x68>
    800025a4:	00001097          	auipc	ra,0x1
    800025a8:	928080e7          	jalr	-1752(ra) # 80002ecc <panic>

00000000800025ac <either_copyin>:
    800025ac:	ff010113          	addi	sp,sp,-16
    800025b0:	00813023          	sd	s0,0(sp)
    800025b4:	00113423          	sd	ra,8(sp)
    800025b8:	01010413          	addi	s0,sp,16
    800025bc:	02059463          	bnez	a1,800025e4 <either_copyin+0x38>
    800025c0:	00060593          	mv	a1,a2
    800025c4:	0006861b          	sext.w	a2,a3
    800025c8:	00002097          	auipc	ra,0x2
    800025cc:	c0c080e7          	jalr	-1012(ra) # 800041d4 <__memmove>
    800025d0:	00813083          	ld	ra,8(sp)
    800025d4:	00013403          	ld	s0,0(sp)
    800025d8:	00000513          	li	a0,0
    800025dc:	01010113          	addi	sp,sp,16
    800025e0:	00008067          	ret
    800025e4:	00003517          	auipc	a0,0x3
    800025e8:	b5c50513          	addi	a0,a0,-1188 # 80005140 <_ZZ12printIntegermE6digits+0x90>
    800025ec:	00001097          	auipc	ra,0x1
    800025f0:	8e0080e7          	jalr	-1824(ra) # 80002ecc <panic>

00000000800025f4 <trapinit>:
    800025f4:	ff010113          	addi	sp,sp,-16
    800025f8:	00813423          	sd	s0,8(sp)
    800025fc:	01010413          	addi	s0,sp,16
    80002600:	00813403          	ld	s0,8(sp)
    80002604:	00003597          	auipc	a1,0x3
    80002608:	b6458593          	addi	a1,a1,-1180 # 80005168 <_ZZ12printIntegermE6digits+0xb8>
    8000260c:	00004517          	auipc	a0,0x4
    80002610:	40450513          	addi	a0,a0,1028 # 80006a10 <tickslock>
    80002614:	01010113          	addi	sp,sp,16
    80002618:	00001317          	auipc	t1,0x1
    8000261c:	5c030067          	jr	1472(t1) # 80003bd8 <initlock>

0000000080002620 <trapinithart>:
    80002620:	ff010113          	addi	sp,sp,-16
    80002624:	00813423          	sd	s0,8(sp)
    80002628:	01010413          	addi	s0,sp,16
    8000262c:	00000797          	auipc	a5,0x0
    80002630:	2f478793          	addi	a5,a5,756 # 80002920 <kernelvec>
    80002634:	10579073          	csrw	stvec,a5
    80002638:	00813403          	ld	s0,8(sp)
    8000263c:	01010113          	addi	sp,sp,16
    80002640:	00008067          	ret

0000000080002644 <usertrap>:
    80002644:	ff010113          	addi	sp,sp,-16
    80002648:	00813423          	sd	s0,8(sp)
    8000264c:	01010413          	addi	s0,sp,16
    80002650:	00813403          	ld	s0,8(sp)
    80002654:	01010113          	addi	sp,sp,16
    80002658:	00008067          	ret

000000008000265c <usertrapret>:
    8000265c:	ff010113          	addi	sp,sp,-16
    80002660:	00813423          	sd	s0,8(sp)
    80002664:	01010413          	addi	s0,sp,16
    80002668:	00813403          	ld	s0,8(sp)
    8000266c:	01010113          	addi	sp,sp,16
    80002670:	00008067          	ret

0000000080002674 <kerneltrap>:
    80002674:	fe010113          	addi	sp,sp,-32
    80002678:	00813823          	sd	s0,16(sp)
    8000267c:	00113c23          	sd	ra,24(sp)
    80002680:	00913423          	sd	s1,8(sp)
    80002684:	02010413          	addi	s0,sp,32
    80002688:	142025f3          	csrr	a1,scause
    8000268c:	100027f3          	csrr	a5,sstatus
    80002690:	0027f793          	andi	a5,a5,2
    80002694:	10079c63          	bnez	a5,800027ac <kerneltrap+0x138>
    80002698:	142027f3          	csrr	a5,scause
    8000269c:	0207ce63          	bltz	a5,800026d8 <kerneltrap+0x64>
    800026a0:	00003517          	auipc	a0,0x3
    800026a4:	b1050513          	addi	a0,a0,-1264 # 800051b0 <_ZZ12printIntegermE6digits+0x100>
    800026a8:	00001097          	auipc	ra,0x1
    800026ac:	880080e7          	jalr	-1920(ra) # 80002f28 <__printf>
    800026b0:	141025f3          	csrr	a1,sepc
    800026b4:	14302673          	csrr	a2,stval
    800026b8:	00003517          	auipc	a0,0x3
    800026bc:	b0850513          	addi	a0,a0,-1272 # 800051c0 <_ZZ12printIntegermE6digits+0x110>
    800026c0:	00001097          	auipc	ra,0x1
    800026c4:	868080e7          	jalr	-1944(ra) # 80002f28 <__printf>
    800026c8:	00003517          	auipc	a0,0x3
    800026cc:	b1050513          	addi	a0,a0,-1264 # 800051d8 <_ZZ12printIntegermE6digits+0x128>
    800026d0:	00000097          	auipc	ra,0x0
    800026d4:	7fc080e7          	jalr	2044(ra) # 80002ecc <panic>
    800026d8:	0ff7f713          	andi	a4,a5,255
    800026dc:	00900693          	li	a3,9
    800026e0:	04d70063          	beq	a4,a3,80002720 <kerneltrap+0xac>
    800026e4:	fff00713          	li	a4,-1
    800026e8:	03f71713          	slli	a4,a4,0x3f
    800026ec:	00170713          	addi	a4,a4,1
    800026f0:	fae798e3          	bne	a5,a4,800026a0 <kerneltrap+0x2c>
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	e00080e7          	jalr	-512(ra) # 800024f4 <cpuid>
    800026fc:	06050663          	beqz	a0,80002768 <kerneltrap+0xf4>
    80002700:	144027f3          	csrr	a5,sip
    80002704:	ffd7f793          	andi	a5,a5,-3
    80002708:	14479073          	csrw	sip,a5
    8000270c:	01813083          	ld	ra,24(sp)
    80002710:	01013403          	ld	s0,16(sp)
    80002714:	00813483          	ld	s1,8(sp)
    80002718:	02010113          	addi	sp,sp,32
    8000271c:	00008067          	ret
    80002720:	00000097          	auipc	ra,0x0
    80002724:	3c4080e7          	jalr	964(ra) # 80002ae4 <plic_claim>
    80002728:	00a00793          	li	a5,10
    8000272c:	00050493          	mv	s1,a0
    80002730:	06f50863          	beq	a0,a5,800027a0 <kerneltrap+0x12c>
    80002734:	fc050ce3          	beqz	a0,8000270c <kerneltrap+0x98>
    80002738:	00050593          	mv	a1,a0
    8000273c:	00003517          	auipc	a0,0x3
    80002740:	a5450513          	addi	a0,a0,-1452 # 80005190 <_ZZ12printIntegermE6digits+0xe0>
    80002744:	00000097          	auipc	ra,0x0
    80002748:	7e4080e7          	jalr	2020(ra) # 80002f28 <__printf>
    8000274c:	01013403          	ld	s0,16(sp)
    80002750:	01813083          	ld	ra,24(sp)
    80002754:	00048513          	mv	a0,s1
    80002758:	00813483          	ld	s1,8(sp)
    8000275c:	02010113          	addi	sp,sp,32
    80002760:	00000317          	auipc	t1,0x0
    80002764:	3bc30067          	jr	956(t1) # 80002b1c <plic_complete>
    80002768:	00004517          	auipc	a0,0x4
    8000276c:	2a850513          	addi	a0,a0,680 # 80006a10 <tickslock>
    80002770:	00001097          	auipc	ra,0x1
    80002774:	48c080e7          	jalr	1164(ra) # 80003bfc <acquire>
    80002778:	00003717          	auipc	a4,0x3
    8000277c:	18c70713          	addi	a4,a4,396 # 80005904 <ticks>
    80002780:	00072783          	lw	a5,0(a4)
    80002784:	00004517          	auipc	a0,0x4
    80002788:	28c50513          	addi	a0,a0,652 # 80006a10 <tickslock>
    8000278c:	0017879b          	addiw	a5,a5,1
    80002790:	00f72023          	sw	a5,0(a4)
    80002794:	00001097          	auipc	ra,0x1
    80002798:	534080e7          	jalr	1332(ra) # 80003cc8 <release>
    8000279c:	f65ff06f          	j	80002700 <kerneltrap+0x8c>
    800027a0:	00001097          	auipc	ra,0x1
    800027a4:	090080e7          	jalr	144(ra) # 80003830 <uartintr>
    800027a8:	fa5ff06f          	j	8000274c <kerneltrap+0xd8>
    800027ac:	00003517          	auipc	a0,0x3
    800027b0:	9c450513          	addi	a0,a0,-1596 # 80005170 <_ZZ12printIntegermE6digits+0xc0>
    800027b4:	00000097          	auipc	ra,0x0
    800027b8:	718080e7          	jalr	1816(ra) # 80002ecc <panic>

00000000800027bc <clockintr>:
    800027bc:	fe010113          	addi	sp,sp,-32
    800027c0:	00813823          	sd	s0,16(sp)
    800027c4:	00913423          	sd	s1,8(sp)
    800027c8:	00113c23          	sd	ra,24(sp)
    800027cc:	02010413          	addi	s0,sp,32
    800027d0:	00004497          	auipc	s1,0x4
    800027d4:	24048493          	addi	s1,s1,576 # 80006a10 <tickslock>
    800027d8:	00048513          	mv	a0,s1
    800027dc:	00001097          	auipc	ra,0x1
    800027e0:	420080e7          	jalr	1056(ra) # 80003bfc <acquire>
    800027e4:	00003717          	auipc	a4,0x3
    800027e8:	12070713          	addi	a4,a4,288 # 80005904 <ticks>
    800027ec:	00072783          	lw	a5,0(a4)
    800027f0:	01013403          	ld	s0,16(sp)
    800027f4:	01813083          	ld	ra,24(sp)
    800027f8:	00048513          	mv	a0,s1
    800027fc:	0017879b          	addiw	a5,a5,1
    80002800:	00813483          	ld	s1,8(sp)
    80002804:	00f72023          	sw	a5,0(a4)
    80002808:	02010113          	addi	sp,sp,32
    8000280c:	00001317          	auipc	t1,0x1
    80002810:	4bc30067          	jr	1212(t1) # 80003cc8 <release>

0000000080002814 <devintr>:
    80002814:	142027f3          	csrr	a5,scause
    80002818:	00000513          	li	a0,0
    8000281c:	0007c463          	bltz	a5,80002824 <devintr+0x10>
    80002820:	00008067          	ret
    80002824:	fe010113          	addi	sp,sp,-32
    80002828:	00813823          	sd	s0,16(sp)
    8000282c:	00113c23          	sd	ra,24(sp)
    80002830:	00913423          	sd	s1,8(sp)
    80002834:	02010413          	addi	s0,sp,32
    80002838:	0ff7f713          	andi	a4,a5,255
    8000283c:	00900693          	li	a3,9
    80002840:	04d70c63          	beq	a4,a3,80002898 <devintr+0x84>
    80002844:	fff00713          	li	a4,-1
    80002848:	03f71713          	slli	a4,a4,0x3f
    8000284c:	00170713          	addi	a4,a4,1
    80002850:	00e78c63          	beq	a5,a4,80002868 <devintr+0x54>
    80002854:	01813083          	ld	ra,24(sp)
    80002858:	01013403          	ld	s0,16(sp)
    8000285c:	00813483          	ld	s1,8(sp)
    80002860:	02010113          	addi	sp,sp,32
    80002864:	00008067          	ret
    80002868:	00000097          	auipc	ra,0x0
    8000286c:	c8c080e7          	jalr	-884(ra) # 800024f4 <cpuid>
    80002870:	06050663          	beqz	a0,800028dc <devintr+0xc8>
    80002874:	144027f3          	csrr	a5,sip
    80002878:	ffd7f793          	andi	a5,a5,-3
    8000287c:	14479073          	csrw	sip,a5
    80002880:	01813083          	ld	ra,24(sp)
    80002884:	01013403          	ld	s0,16(sp)
    80002888:	00813483          	ld	s1,8(sp)
    8000288c:	00200513          	li	a0,2
    80002890:	02010113          	addi	sp,sp,32
    80002894:	00008067          	ret
    80002898:	00000097          	auipc	ra,0x0
    8000289c:	24c080e7          	jalr	588(ra) # 80002ae4 <plic_claim>
    800028a0:	00a00793          	li	a5,10
    800028a4:	00050493          	mv	s1,a0
    800028a8:	06f50663          	beq	a0,a5,80002914 <devintr+0x100>
    800028ac:	00100513          	li	a0,1
    800028b0:	fa0482e3          	beqz	s1,80002854 <devintr+0x40>
    800028b4:	00048593          	mv	a1,s1
    800028b8:	00003517          	auipc	a0,0x3
    800028bc:	8d850513          	addi	a0,a0,-1832 # 80005190 <_ZZ12printIntegermE6digits+0xe0>
    800028c0:	00000097          	auipc	ra,0x0
    800028c4:	668080e7          	jalr	1640(ra) # 80002f28 <__printf>
    800028c8:	00048513          	mv	a0,s1
    800028cc:	00000097          	auipc	ra,0x0
    800028d0:	250080e7          	jalr	592(ra) # 80002b1c <plic_complete>
    800028d4:	00100513          	li	a0,1
    800028d8:	f7dff06f          	j	80002854 <devintr+0x40>
    800028dc:	00004517          	auipc	a0,0x4
    800028e0:	13450513          	addi	a0,a0,308 # 80006a10 <tickslock>
    800028e4:	00001097          	auipc	ra,0x1
    800028e8:	318080e7          	jalr	792(ra) # 80003bfc <acquire>
    800028ec:	00003717          	auipc	a4,0x3
    800028f0:	01870713          	addi	a4,a4,24 # 80005904 <ticks>
    800028f4:	00072783          	lw	a5,0(a4)
    800028f8:	00004517          	auipc	a0,0x4
    800028fc:	11850513          	addi	a0,a0,280 # 80006a10 <tickslock>
    80002900:	0017879b          	addiw	a5,a5,1
    80002904:	00f72023          	sw	a5,0(a4)
    80002908:	00001097          	auipc	ra,0x1
    8000290c:	3c0080e7          	jalr	960(ra) # 80003cc8 <release>
    80002910:	f65ff06f          	j	80002874 <devintr+0x60>
    80002914:	00001097          	auipc	ra,0x1
    80002918:	f1c080e7          	jalr	-228(ra) # 80003830 <uartintr>
    8000291c:	fadff06f          	j	800028c8 <devintr+0xb4>

0000000080002920 <kernelvec>:
    80002920:	f0010113          	addi	sp,sp,-256
    80002924:	00113023          	sd	ra,0(sp)
    80002928:	00213423          	sd	sp,8(sp)
    8000292c:	00313823          	sd	gp,16(sp)
    80002930:	00413c23          	sd	tp,24(sp)
    80002934:	02513023          	sd	t0,32(sp)
    80002938:	02613423          	sd	t1,40(sp)
    8000293c:	02713823          	sd	t2,48(sp)
    80002940:	02813c23          	sd	s0,56(sp)
    80002944:	04913023          	sd	s1,64(sp)
    80002948:	04a13423          	sd	a0,72(sp)
    8000294c:	04b13823          	sd	a1,80(sp)
    80002950:	04c13c23          	sd	a2,88(sp)
    80002954:	06d13023          	sd	a3,96(sp)
    80002958:	06e13423          	sd	a4,104(sp)
    8000295c:	06f13823          	sd	a5,112(sp)
    80002960:	07013c23          	sd	a6,120(sp)
    80002964:	09113023          	sd	a7,128(sp)
    80002968:	09213423          	sd	s2,136(sp)
    8000296c:	09313823          	sd	s3,144(sp)
    80002970:	09413c23          	sd	s4,152(sp)
    80002974:	0b513023          	sd	s5,160(sp)
    80002978:	0b613423          	sd	s6,168(sp)
    8000297c:	0b713823          	sd	s7,176(sp)
    80002980:	0b813c23          	sd	s8,184(sp)
    80002984:	0d913023          	sd	s9,192(sp)
    80002988:	0da13423          	sd	s10,200(sp)
    8000298c:	0db13823          	sd	s11,208(sp)
    80002990:	0dc13c23          	sd	t3,216(sp)
    80002994:	0fd13023          	sd	t4,224(sp)
    80002998:	0fe13423          	sd	t5,232(sp)
    8000299c:	0ff13823          	sd	t6,240(sp)
    800029a0:	cd5ff0ef          	jal	ra,80002674 <kerneltrap>
    800029a4:	00013083          	ld	ra,0(sp)
    800029a8:	00813103          	ld	sp,8(sp)
    800029ac:	01013183          	ld	gp,16(sp)
    800029b0:	02013283          	ld	t0,32(sp)
    800029b4:	02813303          	ld	t1,40(sp)
    800029b8:	03013383          	ld	t2,48(sp)
    800029bc:	03813403          	ld	s0,56(sp)
    800029c0:	04013483          	ld	s1,64(sp)
    800029c4:	04813503          	ld	a0,72(sp)
    800029c8:	05013583          	ld	a1,80(sp)
    800029cc:	05813603          	ld	a2,88(sp)
    800029d0:	06013683          	ld	a3,96(sp)
    800029d4:	06813703          	ld	a4,104(sp)
    800029d8:	07013783          	ld	a5,112(sp)
    800029dc:	07813803          	ld	a6,120(sp)
    800029e0:	08013883          	ld	a7,128(sp)
    800029e4:	08813903          	ld	s2,136(sp)
    800029e8:	09013983          	ld	s3,144(sp)
    800029ec:	09813a03          	ld	s4,152(sp)
    800029f0:	0a013a83          	ld	s5,160(sp)
    800029f4:	0a813b03          	ld	s6,168(sp)
    800029f8:	0b013b83          	ld	s7,176(sp)
    800029fc:	0b813c03          	ld	s8,184(sp)
    80002a00:	0c013c83          	ld	s9,192(sp)
    80002a04:	0c813d03          	ld	s10,200(sp)
    80002a08:	0d013d83          	ld	s11,208(sp)
    80002a0c:	0d813e03          	ld	t3,216(sp)
    80002a10:	0e013e83          	ld	t4,224(sp)
    80002a14:	0e813f03          	ld	t5,232(sp)
    80002a18:	0f013f83          	ld	t6,240(sp)
    80002a1c:	10010113          	addi	sp,sp,256
    80002a20:	10200073          	sret
    80002a24:	00000013          	nop
    80002a28:	00000013          	nop
    80002a2c:	00000013          	nop

0000000080002a30 <timervec>:
    80002a30:	34051573          	csrrw	a0,mscratch,a0
    80002a34:	00b53023          	sd	a1,0(a0)
    80002a38:	00c53423          	sd	a2,8(a0)
    80002a3c:	00d53823          	sd	a3,16(a0)
    80002a40:	01853583          	ld	a1,24(a0)
    80002a44:	02053603          	ld	a2,32(a0)
    80002a48:	0005b683          	ld	a3,0(a1)
    80002a4c:	00c686b3          	add	a3,a3,a2
    80002a50:	00d5b023          	sd	a3,0(a1)
    80002a54:	00200593          	li	a1,2
    80002a58:	14459073          	csrw	sip,a1
    80002a5c:	01053683          	ld	a3,16(a0)
    80002a60:	00853603          	ld	a2,8(a0)
    80002a64:	00053583          	ld	a1,0(a0)
    80002a68:	34051573          	csrrw	a0,mscratch,a0
    80002a6c:	30200073          	mret

0000000080002a70 <plicinit>:
    80002a70:	ff010113          	addi	sp,sp,-16
    80002a74:	00813423          	sd	s0,8(sp)
    80002a78:	01010413          	addi	s0,sp,16
    80002a7c:	00813403          	ld	s0,8(sp)
    80002a80:	0c0007b7          	lui	a5,0xc000
    80002a84:	00100713          	li	a4,1
    80002a88:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002a8c:	00e7a223          	sw	a4,4(a5)
    80002a90:	01010113          	addi	sp,sp,16
    80002a94:	00008067          	ret

0000000080002a98 <plicinithart>:
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00813023          	sd	s0,0(sp)
    80002aa0:	00113423          	sd	ra,8(sp)
    80002aa4:	01010413          	addi	s0,sp,16
    80002aa8:	00000097          	auipc	ra,0x0
    80002aac:	a4c080e7          	jalr	-1460(ra) # 800024f4 <cpuid>
    80002ab0:	0085171b          	slliw	a4,a0,0x8
    80002ab4:	0c0027b7          	lui	a5,0xc002
    80002ab8:	00e787b3          	add	a5,a5,a4
    80002abc:	40200713          	li	a4,1026
    80002ac0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002ac4:	00813083          	ld	ra,8(sp)
    80002ac8:	00013403          	ld	s0,0(sp)
    80002acc:	00d5151b          	slliw	a0,a0,0xd
    80002ad0:	0c2017b7          	lui	a5,0xc201
    80002ad4:	00a78533          	add	a0,a5,a0
    80002ad8:	00052023          	sw	zero,0(a0)
    80002adc:	01010113          	addi	sp,sp,16
    80002ae0:	00008067          	ret

0000000080002ae4 <plic_claim>:
    80002ae4:	ff010113          	addi	sp,sp,-16
    80002ae8:	00813023          	sd	s0,0(sp)
    80002aec:	00113423          	sd	ra,8(sp)
    80002af0:	01010413          	addi	s0,sp,16
    80002af4:	00000097          	auipc	ra,0x0
    80002af8:	a00080e7          	jalr	-1536(ra) # 800024f4 <cpuid>
    80002afc:	00813083          	ld	ra,8(sp)
    80002b00:	00013403          	ld	s0,0(sp)
    80002b04:	00d5151b          	slliw	a0,a0,0xd
    80002b08:	0c2017b7          	lui	a5,0xc201
    80002b0c:	00a78533          	add	a0,a5,a0
    80002b10:	00452503          	lw	a0,4(a0)
    80002b14:	01010113          	addi	sp,sp,16
    80002b18:	00008067          	ret

0000000080002b1c <plic_complete>:
    80002b1c:	fe010113          	addi	sp,sp,-32
    80002b20:	00813823          	sd	s0,16(sp)
    80002b24:	00913423          	sd	s1,8(sp)
    80002b28:	00113c23          	sd	ra,24(sp)
    80002b2c:	02010413          	addi	s0,sp,32
    80002b30:	00050493          	mv	s1,a0
    80002b34:	00000097          	auipc	ra,0x0
    80002b38:	9c0080e7          	jalr	-1600(ra) # 800024f4 <cpuid>
    80002b3c:	01813083          	ld	ra,24(sp)
    80002b40:	01013403          	ld	s0,16(sp)
    80002b44:	00d5179b          	slliw	a5,a0,0xd
    80002b48:	0c201737          	lui	a4,0xc201
    80002b4c:	00f707b3          	add	a5,a4,a5
    80002b50:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002b54:	00813483          	ld	s1,8(sp)
    80002b58:	02010113          	addi	sp,sp,32
    80002b5c:	00008067          	ret

0000000080002b60 <consolewrite>:
    80002b60:	fb010113          	addi	sp,sp,-80
    80002b64:	04813023          	sd	s0,64(sp)
    80002b68:	04113423          	sd	ra,72(sp)
    80002b6c:	02913c23          	sd	s1,56(sp)
    80002b70:	03213823          	sd	s2,48(sp)
    80002b74:	03313423          	sd	s3,40(sp)
    80002b78:	03413023          	sd	s4,32(sp)
    80002b7c:	01513c23          	sd	s5,24(sp)
    80002b80:	05010413          	addi	s0,sp,80
    80002b84:	06c05c63          	blez	a2,80002bfc <consolewrite+0x9c>
    80002b88:	00060993          	mv	s3,a2
    80002b8c:	00050a13          	mv	s4,a0
    80002b90:	00058493          	mv	s1,a1
    80002b94:	00000913          	li	s2,0
    80002b98:	fff00a93          	li	s5,-1
    80002b9c:	01c0006f          	j	80002bb8 <consolewrite+0x58>
    80002ba0:	fbf44503          	lbu	a0,-65(s0)
    80002ba4:	0019091b          	addiw	s2,s2,1
    80002ba8:	00148493          	addi	s1,s1,1
    80002bac:	00001097          	auipc	ra,0x1
    80002bb0:	a9c080e7          	jalr	-1380(ra) # 80003648 <uartputc>
    80002bb4:	03298063          	beq	s3,s2,80002bd4 <consolewrite+0x74>
    80002bb8:	00048613          	mv	a2,s1
    80002bbc:	00100693          	li	a3,1
    80002bc0:	000a0593          	mv	a1,s4
    80002bc4:	fbf40513          	addi	a0,s0,-65
    80002bc8:	00000097          	auipc	ra,0x0
    80002bcc:	9e4080e7          	jalr	-1564(ra) # 800025ac <either_copyin>
    80002bd0:	fd5518e3          	bne	a0,s5,80002ba0 <consolewrite+0x40>
    80002bd4:	04813083          	ld	ra,72(sp)
    80002bd8:	04013403          	ld	s0,64(sp)
    80002bdc:	03813483          	ld	s1,56(sp)
    80002be0:	02813983          	ld	s3,40(sp)
    80002be4:	02013a03          	ld	s4,32(sp)
    80002be8:	01813a83          	ld	s5,24(sp)
    80002bec:	00090513          	mv	a0,s2
    80002bf0:	03013903          	ld	s2,48(sp)
    80002bf4:	05010113          	addi	sp,sp,80
    80002bf8:	00008067          	ret
    80002bfc:	00000913          	li	s2,0
    80002c00:	fd5ff06f          	j	80002bd4 <consolewrite+0x74>

0000000080002c04 <consoleread>:
    80002c04:	f9010113          	addi	sp,sp,-112
    80002c08:	06813023          	sd	s0,96(sp)
    80002c0c:	04913c23          	sd	s1,88(sp)
    80002c10:	05213823          	sd	s2,80(sp)
    80002c14:	05313423          	sd	s3,72(sp)
    80002c18:	05413023          	sd	s4,64(sp)
    80002c1c:	03513c23          	sd	s5,56(sp)
    80002c20:	03613823          	sd	s6,48(sp)
    80002c24:	03713423          	sd	s7,40(sp)
    80002c28:	03813023          	sd	s8,32(sp)
    80002c2c:	06113423          	sd	ra,104(sp)
    80002c30:	01913c23          	sd	s9,24(sp)
    80002c34:	07010413          	addi	s0,sp,112
    80002c38:	00060b93          	mv	s7,a2
    80002c3c:	00050913          	mv	s2,a0
    80002c40:	00058c13          	mv	s8,a1
    80002c44:	00060b1b          	sext.w	s6,a2
    80002c48:	00004497          	auipc	s1,0x4
    80002c4c:	df048493          	addi	s1,s1,-528 # 80006a38 <cons>
    80002c50:	00400993          	li	s3,4
    80002c54:	fff00a13          	li	s4,-1
    80002c58:	00a00a93          	li	s5,10
    80002c5c:	05705e63          	blez	s7,80002cb8 <consoleread+0xb4>
    80002c60:	09c4a703          	lw	a4,156(s1)
    80002c64:	0984a783          	lw	a5,152(s1)
    80002c68:	0007071b          	sext.w	a4,a4
    80002c6c:	08e78463          	beq	a5,a4,80002cf4 <consoleread+0xf0>
    80002c70:	07f7f713          	andi	a4,a5,127
    80002c74:	00e48733          	add	a4,s1,a4
    80002c78:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002c7c:	0017869b          	addiw	a3,a5,1
    80002c80:	08d4ac23          	sw	a3,152(s1)
    80002c84:	00070c9b          	sext.w	s9,a4
    80002c88:	0b370663          	beq	a4,s3,80002d34 <consoleread+0x130>
    80002c8c:	00100693          	li	a3,1
    80002c90:	f9f40613          	addi	a2,s0,-97
    80002c94:	000c0593          	mv	a1,s8
    80002c98:	00090513          	mv	a0,s2
    80002c9c:	f8e40fa3          	sb	a4,-97(s0)
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	8c0080e7          	jalr	-1856(ra) # 80002560 <either_copyout>
    80002ca8:	01450863          	beq	a0,s4,80002cb8 <consoleread+0xb4>
    80002cac:	001c0c13          	addi	s8,s8,1
    80002cb0:	fffb8b9b          	addiw	s7,s7,-1
    80002cb4:	fb5c94e3          	bne	s9,s5,80002c5c <consoleread+0x58>
    80002cb8:	000b851b          	sext.w	a0,s7
    80002cbc:	06813083          	ld	ra,104(sp)
    80002cc0:	06013403          	ld	s0,96(sp)
    80002cc4:	05813483          	ld	s1,88(sp)
    80002cc8:	05013903          	ld	s2,80(sp)
    80002ccc:	04813983          	ld	s3,72(sp)
    80002cd0:	04013a03          	ld	s4,64(sp)
    80002cd4:	03813a83          	ld	s5,56(sp)
    80002cd8:	02813b83          	ld	s7,40(sp)
    80002cdc:	02013c03          	ld	s8,32(sp)
    80002ce0:	01813c83          	ld	s9,24(sp)
    80002ce4:	40ab053b          	subw	a0,s6,a0
    80002ce8:	03013b03          	ld	s6,48(sp)
    80002cec:	07010113          	addi	sp,sp,112
    80002cf0:	00008067          	ret
    80002cf4:	00001097          	auipc	ra,0x1
    80002cf8:	1d8080e7          	jalr	472(ra) # 80003ecc <push_on>
    80002cfc:	0984a703          	lw	a4,152(s1)
    80002d00:	09c4a783          	lw	a5,156(s1)
    80002d04:	0007879b          	sext.w	a5,a5
    80002d08:	fef70ce3          	beq	a4,a5,80002d00 <consoleread+0xfc>
    80002d0c:	00001097          	auipc	ra,0x1
    80002d10:	234080e7          	jalr	564(ra) # 80003f40 <pop_on>
    80002d14:	0984a783          	lw	a5,152(s1)
    80002d18:	07f7f713          	andi	a4,a5,127
    80002d1c:	00e48733          	add	a4,s1,a4
    80002d20:	01874703          	lbu	a4,24(a4)
    80002d24:	0017869b          	addiw	a3,a5,1
    80002d28:	08d4ac23          	sw	a3,152(s1)
    80002d2c:	00070c9b          	sext.w	s9,a4
    80002d30:	f5371ee3          	bne	a4,s3,80002c8c <consoleread+0x88>
    80002d34:	000b851b          	sext.w	a0,s7
    80002d38:	f96bf2e3          	bgeu	s7,s6,80002cbc <consoleread+0xb8>
    80002d3c:	08f4ac23          	sw	a5,152(s1)
    80002d40:	f7dff06f          	j	80002cbc <consoleread+0xb8>

0000000080002d44 <consputc>:
    80002d44:	10000793          	li	a5,256
    80002d48:	00f50663          	beq	a0,a5,80002d54 <consputc+0x10>
    80002d4c:	00001317          	auipc	t1,0x1
    80002d50:	9f430067          	jr	-1548(t1) # 80003740 <uartputc_sync>
    80002d54:	ff010113          	addi	sp,sp,-16
    80002d58:	00113423          	sd	ra,8(sp)
    80002d5c:	00813023          	sd	s0,0(sp)
    80002d60:	01010413          	addi	s0,sp,16
    80002d64:	00800513          	li	a0,8
    80002d68:	00001097          	auipc	ra,0x1
    80002d6c:	9d8080e7          	jalr	-1576(ra) # 80003740 <uartputc_sync>
    80002d70:	02000513          	li	a0,32
    80002d74:	00001097          	auipc	ra,0x1
    80002d78:	9cc080e7          	jalr	-1588(ra) # 80003740 <uartputc_sync>
    80002d7c:	00013403          	ld	s0,0(sp)
    80002d80:	00813083          	ld	ra,8(sp)
    80002d84:	00800513          	li	a0,8
    80002d88:	01010113          	addi	sp,sp,16
    80002d8c:	00001317          	auipc	t1,0x1
    80002d90:	9b430067          	jr	-1612(t1) # 80003740 <uartputc_sync>

0000000080002d94 <consoleintr>:
    80002d94:	fe010113          	addi	sp,sp,-32
    80002d98:	00813823          	sd	s0,16(sp)
    80002d9c:	00913423          	sd	s1,8(sp)
    80002da0:	01213023          	sd	s2,0(sp)
    80002da4:	00113c23          	sd	ra,24(sp)
    80002da8:	02010413          	addi	s0,sp,32
    80002dac:	00004917          	auipc	s2,0x4
    80002db0:	c8c90913          	addi	s2,s2,-884 # 80006a38 <cons>
    80002db4:	00050493          	mv	s1,a0
    80002db8:	00090513          	mv	a0,s2
    80002dbc:	00001097          	auipc	ra,0x1
    80002dc0:	e40080e7          	jalr	-448(ra) # 80003bfc <acquire>
    80002dc4:	02048c63          	beqz	s1,80002dfc <consoleintr+0x68>
    80002dc8:	0a092783          	lw	a5,160(s2)
    80002dcc:	09892703          	lw	a4,152(s2)
    80002dd0:	07f00693          	li	a3,127
    80002dd4:	40e7873b          	subw	a4,a5,a4
    80002dd8:	02e6e263          	bltu	a3,a4,80002dfc <consoleintr+0x68>
    80002ddc:	00d00713          	li	a4,13
    80002de0:	04e48063          	beq	s1,a4,80002e20 <consoleintr+0x8c>
    80002de4:	07f7f713          	andi	a4,a5,127
    80002de8:	00e90733          	add	a4,s2,a4
    80002dec:	0017879b          	addiw	a5,a5,1
    80002df0:	0af92023          	sw	a5,160(s2)
    80002df4:	00970c23          	sb	s1,24(a4)
    80002df8:	08f92e23          	sw	a5,156(s2)
    80002dfc:	01013403          	ld	s0,16(sp)
    80002e00:	01813083          	ld	ra,24(sp)
    80002e04:	00813483          	ld	s1,8(sp)
    80002e08:	00013903          	ld	s2,0(sp)
    80002e0c:	00004517          	auipc	a0,0x4
    80002e10:	c2c50513          	addi	a0,a0,-980 # 80006a38 <cons>
    80002e14:	02010113          	addi	sp,sp,32
    80002e18:	00001317          	auipc	t1,0x1
    80002e1c:	eb030067          	jr	-336(t1) # 80003cc8 <release>
    80002e20:	00a00493          	li	s1,10
    80002e24:	fc1ff06f          	j	80002de4 <consoleintr+0x50>

0000000080002e28 <consoleinit>:
    80002e28:	fe010113          	addi	sp,sp,-32
    80002e2c:	00113c23          	sd	ra,24(sp)
    80002e30:	00813823          	sd	s0,16(sp)
    80002e34:	00913423          	sd	s1,8(sp)
    80002e38:	02010413          	addi	s0,sp,32
    80002e3c:	00004497          	auipc	s1,0x4
    80002e40:	bfc48493          	addi	s1,s1,-1028 # 80006a38 <cons>
    80002e44:	00048513          	mv	a0,s1
    80002e48:	00002597          	auipc	a1,0x2
    80002e4c:	3a058593          	addi	a1,a1,928 # 800051e8 <_ZZ12printIntegermE6digits+0x138>
    80002e50:	00001097          	auipc	ra,0x1
    80002e54:	d88080e7          	jalr	-632(ra) # 80003bd8 <initlock>
    80002e58:	00000097          	auipc	ra,0x0
    80002e5c:	7ac080e7          	jalr	1964(ra) # 80003604 <uartinit>
    80002e60:	01813083          	ld	ra,24(sp)
    80002e64:	01013403          	ld	s0,16(sp)
    80002e68:	00000797          	auipc	a5,0x0
    80002e6c:	d9c78793          	addi	a5,a5,-612 # 80002c04 <consoleread>
    80002e70:	0af4bc23          	sd	a5,184(s1)
    80002e74:	00000797          	auipc	a5,0x0
    80002e78:	cec78793          	addi	a5,a5,-788 # 80002b60 <consolewrite>
    80002e7c:	0cf4b023          	sd	a5,192(s1)
    80002e80:	00813483          	ld	s1,8(sp)
    80002e84:	02010113          	addi	sp,sp,32
    80002e88:	00008067          	ret

0000000080002e8c <console_read>:
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00813423          	sd	s0,8(sp)
    80002e94:	01010413          	addi	s0,sp,16
    80002e98:	00813403          	ld	s0,8(sp)
    80002e9c:	00004317          	auipc	t1,0x4
    80002ea0:	c5433303          	ld	t1,-940(t1) # 80006af0 <devsw+0x10>
    80002ea4:	01010113          	addi	sp,sp,16
    80002ea8:	00030067          	jr	t1

0000000080002eac <console_write>:
    80002eac:	ff010113          	addi	sp,sp,-16
    80002eb0:	00813423          	sd	s0,8(sp)
    80002eb4:	01010413          	addi	s0,sp,16
    80002eb8:	00813403          	ld	s0,8(sp)
    80002ebc:	00004317          	auipc	t1,0x4
    80002ec0:	c3c33303          	ld	t1,-964(t1) # 80006af8 <devsw+0x18>
    80002ec4:	01010113          	addi	sp,sp,16
    80002ec8:	00030067          	jr	t1

0000000080002ecc <panic>:
    80002ecc:	fe010113          	addi	sp,sp,-32
    80002ed0:	00113c23          	sd	ra,24(sp)
    80002ed4:	00813823          	sd	s0,16(sp)
    80002ed8:	00913423          	sd	s1,8(sp)
    80002edc:	02010413          	addi	s0,sp,32
    80002ee0:	00050493          	mv	s1,a0
    80002ee4:	00002517          	auipc	a0,0x2
    80002ee8:	30c50513          	addi	a0,a0,780 # 800051f0 <_ZZ12printIntegermE6digits+0x140>
    80002eec:	00004797          	auipc	a5,0x4
    80002ef0:	ca07a623          	sw	zero,-852(a5) # 80006b98 <pr+0x18>
    80002ef4:	00000097          	auipc	ra,0x0
    80002ef8:	034080e7          	jalr	52(ra) # 80002f28 <__printf>
    80002efc:	00048513          	mv	a0,s1
    80002f00:	00000097          	auipc	ra,0x0
    80002f04:	028080e7          	jalr	40(ra) # 80002f28 <__printf>
    80002f08:	00002517          	auipc	a0,0x2
    80002f0c:	13850513          	addi	a0,a0,312 # 80005040 <CONSOLE_STATUS+0x30>
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	018080e7          	jalr	24(ra) # 80002f28 <__printf>
    80002f18:	00100793          	li	a5,1
    80002f1c:	00003717          	auipc	a4,0x3
    80002f20:	9ef72623          	sw	a5,-1556(a4) # 80005908 <panicked>
    80002f24:	0000006f          	j	80002f24 <panic+0x58>

0000000080002f28 <__printf>:
    80002f28:	f3010113          	addi	sp,sp,-208
    80002f2c:	08813023          	sd	s0,128(sp)
    80002f30:	07313423          	sd	s3,104(sp)
    80002f34:	09010413          	addi	s0,sp,144
    80002f38:	05813023          	sd	s8,64(sp)
    80002f3c:	08113423          	sd	ra,136(sp)
    80002f40:	06913c23          	sd	s1,120(sp)
    80002f44:	07213823          	sd	s2,112(sp)
    80002f48:	07413023          	sd	s4,96(sp)
    80002f4c:	05513c23          	sd	s5,88(sp)
    80002f50:	05613823          	sd	s6,80(sp)
    80002f54:	05713423          	sd	s7,72(sp)
    80002f58:	03913c23          	sd	s9,56(sp)
    80002f5c:	03a13823          	sd	s10,48(sp)
    80002f60:	03b13423          	sd	s11,40(sp)
    80002f64:	00004317          	auipc	t1,0x4
    80002f68:	c1c30313          	addi	t1,t1,-996 # 80006b80 <pr>
    80002f6c:	01832c03          	lw	s8,24(t1)
    80002f70:	00b43423          	sd	a1,8(s0)
    80002f74:	00c43823          	sd	a2,16(s0)
    80002f78:	00d43c23          	sd	a3,24(s0)
    80002f7c:	02e43023          	sd	a4,32(s0)
    80002f80:	02f43423          	sd	a5,40(s0)
    80002f84:	03043823          	sd	a6,48(s0)
    80002f88:	03143c23          	sd	a7,56(s0)
    80002f8c:	00050993          	mv	s3,a0
    80002f90:	4a0c1663          	bnez	s8,8000343c <__printf+0x514>
    80002f94:	60098c63          	beqz	s3,800035ac <__printf+0x684>
    80002f98:	0009c503          	lbu	a0,0(s3)
    80002f9c:	00840793          	addi	a5,s0,8
    80002fa0:	f6f43c23          	sd	a5,-136(s0)
    80002fa4:	00000493          	li	s1,0
    80002fa8:	22050063          	beqz	a0,800031c8 <__printf+0x2a0>
    80002fac:	00002a37          	lui	s4,0x2
    80002fb0:	00018ab7          	lui	s5,0x18
    80002fb4:	000f4b37          	lui	s6,0xf4
    80002fb8:	00989bb7          	lui	s7,0x989
    80002fbc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002fc0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002fc4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002fc8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002fcc:	00148c9b          	addiw	s9,s1,1
    80002fd0:	02500793          	li	a5,37
    80002fd4:	01998933          	add	s2,s3,s9
    80002fd8:	38f51263          	bne	a0,a5,8000335c <__printf+0x434>
    80002fdc:	00094783          	lbu	a5,0(s2)
    80002fe0:	00078c9b          	sext.w	s9,a5
    80002fe4:	1e078263          	beqz	a5,800031c8 <__printf+0x2a0>
    80002fe8:	0024849b          	addiw	s1,s1,2
    80002fec:	07000713          	li	a4,112
    80002ff0:	00998933          	add	s2,s3,s1
    80002ff4:	38e78a63          	beq	a5,a4,80003388 <__printf+0x460>
    80002ff8:	20f76863          	bltu	a4,a5,80003208 <__printf+0x2e0>
    80002ffc:	42a78863          	beq	a5,a0,8000342c <__printf+0x504>
    80003000:	06400713          	li	a4,100
    80003004:	40e79663          	bne	a5,a4,80003410 <__printf+0x4e8>
    80003008:	f7843783          	ld	a5,-136(s0)
    8000300c:	0007a603          	lw	a2,0(a5)
    80003010:	00878793          	addi	a5,a5,8
    80003014:	f6f43c23          	sd	a5,-136(s0)
    80003018:	42064a63          	bltz	a2,8000344c <__printf+0x524>
    8000301c:	00a00713          	li	a4,10
    80003020:	02e677bb          	remuw	a5,a2,a4
    80003024:	00002d97          	auipc	s11,0x2
    80003028:	1f4d8d93          	addi	s11,s11,500 # 80005218 <digits>
    8000302c:	00900593          	li	a1,9
    80003030:	0006051b          	sext.w	a0,a2
    80003034:	00000c93          	li	s9,0
    80003038:	02079793          	slli	a5,a5,0x20
    8000303c:	0207d793          	srli	a5,a5,0x20
    80003040:	00fd87b3          	add	a5,s11,a5
    80003044:	0007c783          	lbu	a5,0(a5)
    80003048:	02e656bb          	divuw	a3,a2,a4
    8000304c:	f8f40023          	sb	a5,-128(s0)
    80003050:	14c5d863          	bge	a1,a2,800031a0 <__printf+0x278>
    80003054:	06300593          	li	a1,99
    80003058:	00100c93          	li	s9,1
    8000305c:	02e6f7bb          	remuw	a5,a3,a4
    80003060:	02079793          	slli	a5,a5,0x20
    80003064:	0207d793          	srli	a5,a5,0x20
    80003068:	00fd87b3          	add	a5,s11,a5
    8000306c:	0007c783          	lbu	a5,0(a5)
    80003070:	02e6d73b          	divuw	a4,a3,a4
    80003074:	f8f400a3          	sb	a5,-127(s0)
    80003078:	12a5f463          	bgeu	a1,a0,800031a0 <__printf+0x278>
    8000307c:	00a00693          	li	a3,10
    80003080:	00900593          	li	a1,9
    80003084:	02d777bb          	remuw	a5,a4,a3
    80003088:	02079793          	slli	a5,a5,0x20
    8000308c:	0207d793          	srli	a5,a5,0x20
    80003090:	00fd87b3          	add	a5,s11,a5
    80003094:	0007c503          	lbu	a0,0(a5)
    80003098:	02d757bb          	divuw	a5,a4,a3
    8000309c:	f8a40123          	sb	a0,-126(s0)
    800030a0:	48e5f263          	bgeu	a1,a4,80003524 <__printf+0x5fc>
    800030a4:	06300513          	li	a0,99
    800030a8:	02d7f5bb          	remuw	a1,a5,a3
    800030ac:	02059593          	slli	a1,a1,0x20
    800030b0:	0205d593          	srli	a1,a1,0x20
    800030b4:	00bd85b3          	add	a1,s11,a1
    800030b8:	0005c583          	lbu	a1,0(a1)
    800030bc:	02d7d7bb          	divuw	a5,a5,a3
    800030c0:	f8b401a3          	sb	a1,-125(s0)
    800030c4:	48e57263          	bgeu	a0,a4,80003548 <__printf+0x620>
    800030c8:	3e700513          	li	a0,999
    800030cc:	02d7f5bb          	remuw	a1,a5,a3
    800030d0:	02059593          	slli	a1,a1,0x20
    800030d4:	0205d593          	srli	a1,a1,0x20
    800030d8:	00bd85b3          	add	a1,s11,a1
    800030dc:	0005c583          	lbu	a1,0(a1)
    800030e0:	02d7d7bb          	divuw	a5,a5,a3
    800030e4:	f8b40223          	sb	a1,-124(s0)
    800030e8:	46e57663          	bgeu	a0,a4,80003554 <__printf+0x62c>
    800030ec:	02d7f5bb          	remuw	a1,a5,a3
    800030f0:	02059593          	slli	a1,a1,0x20
    800030f4:	0205d593          	srli	a1,a1,0x20
    800030f8:	00bd85b3          	add	a1,s11,a1
    800030fc:	0005c583          	lbu	a1,0(a1)
    80003100:	02d7d7bb          	divuw	a5,a5,a3
    80003104:	f8b402a3          	sb	a1,-123(s0)
    80003108:	46ea7863          	bgeu	s4,a4,80003578 <__printf+0x650>
    8000310c:	02d7f5bb          	remuw	a1,a5,a3
    80003110:	02059593          	slli	a1,a1,0x20
    80003114:	0205d593          	srli	a1,a1,0x20
    80003118:	00bd85b3          	add	a1,s11,a1
    8000311c:	0005c583          	lbu	a1,0(a1)
    80003120:	02d7d7bb          	divuw	a5,a5,a3
    80003124:	f8b40323          	sb	a1,-122(s0)
    80003128:	3eeaf863          	bgeu	s5,a4,80003518 <__printf+0x5f0>
    8000312c:	02d7f5bb          	remuw	a1,a5,a3
    80003130:	02059593          	slli	a1,a1,0x20
    80003134:	0205d593          	srli	a1,a1,0x20
    80003138:	00bd85b3          	add	a1,s11,a1
    8000313c:	0005c583          	lbu	a1,0(a1)
    80003140:	02d7d7bb          	divuw	a5,a5,a3
    80003144:	f8b403a3          	sb	a1,-121(s0)
    80003148:	42eb7e63          	bgeu	s6,a4,80003584 <__printf+0x65c>
    8000314c:	02d7f5bb          	remuw	a1,a5,a3
    80003150:	02059593          	slli	a1,a1,0x20
    80003154:	0205d593          	srli	a1,a1,0x20
    80003158:	00bd85b3          	add	a1,s11,a1
    8000315c:	0005c583          	lbu	a1,0(a1)
    80003160:	02d7d7bb          	divuw	a5,a5,a3
    80003164:	f8b40423          	sb	a1,-120(s0)
    80003168:	42ebfc63          	bgeu	s7,a4,800035a0 <__printf+0x678>
    8000316c:	02079793          	slli	a5,a5,0x20
    80003170:	0207d793          	srli	a5,a5,0x20
    80003174:	00fd8db3          	add	s11,s11,a5
    80003178:	000dc703          	lbu	a4,0(s11)
    8000317c:	00a00793          	li	a5,10
    80003180:	00900c93          	li	s9,9
    80003184:	f8e404a3          	sb	a4,-119(s0)
    80003188:	00065c63          	bgez	a2,800031a0 <__printf+0x278>
    8000318c:	f9040713          	addi	a4,s0,-112
    80003190:	00f70733          	add	a4,a4,a5
    80003194:	02d00693          	li	a3,45
    80003198:	fed70823          	sb	a3,-16(a4)
    8000319c:	00078c93          	mv	s9,a5
    800031a0:	f8040793          	addi	a5,s0,-128
    800031a4:	01978cb3          	add	s9,a5,s9
    800031a8:	f7f40d13          	addi	s10,s0,-129
    800031ac:	000cc503          	lbu	a0,0(s9)
    800031b0:	fffc8c93          	addi	s9,s9,-1
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	b90080e7          	jalr	-1136(ra) # 80002d44 <consputc>
    800031bc:	ffac98e3          	bne	s9,s10,800031ac <__printf+0x284>
    800031c0:	00094503          	lbu	a0,0(s2)
    800031c4:	e00514e3          	bnez	a0,80002fcc <__printf+0xa4>
    800031c8:	1a0c1663          	bnez	s8,80003374 <__printf+0x44c>
    800031cc:	08813083          	ld	ra,136(sp)
    800031d0:	08013403          	ld	s0,128(sp)
    800031d4:	07813483          	ld	s1,120(sp)
    800031d8:	07013903          	ld	s2,112(sp)
    800031dc:	06813983          	ld	s3,104(sp)
    800031e0:	06013a03          	ld	s4,96(sp)
    800031e4:	05813a83          	ld	s5,88(sp)
    800031e8:	05013b03          	ld	s6,80(sp)
    800031ec:	04813b83          	ld	s7,72(sp)
    800031f0:	04013c03          	ld	s8,64(sp)
    800031f4:	03813c83          	ld	s9,56(sp)
    800031f8:	03013d03          	ld	s10,48(sp)
    800031fc:	02813d83          	ld	s11,40(sp)
    80003200:	0d010113          	addi	sp,sp,208
    80003204:	00008067          	ret
    80003208:	07300713          	li	a4,115
    8000320c:	1ce78a63          	beq	a5,a4,800033e0 <__printf+0x4b8>
    80003210:	07800713          	li	a4,120
    80003214:	1ee79e63          	bne	a5,a4,80003410 <__printf+0x4e8>
    80003218:	f7843783          	ld	a5,-136(s0)
    8000321c:	0007a703          	lw	a4,0(a5)
    80003220:	00878793          	addi	a5,a5,8
    80003224:	f6f43c23          	sd	a5,-136(s0)
    80003228:	28074263          	bltz	a4,800034ac <__printf+0x584>
    8000322c:	00002d97          	auipc	s11,0x2
    80003230:	fecd8d93          	addi	s11,s11,-20 # 80005218 <digits>
    80003234:	00f77793          	andi	a5,a4,15
    80003238:	00fd87b3          	add	a5,s11,a5
    8000323c:	0007c683          	lbu	a3,0(a5)
    80003240:	00f00613          	li	a2,15
    80003244:	0007079b          	sext.w	a5,a4
    80003248:	f8d40023          	sb	a3,-128(s0)
    8000324c:	0047559b          	srliw	a1,a4,0x4
    80003250:	0047569b          	srliw	a3,a4,0x4
    80003254:	00000c93          	li	s9,0
    80003258:	0ee65063          	bge	a2,a4,80003338 <__printf+0x410>
    8000325c:	00f6f693          	andi	a3,a3,15
    80003260:	00dd86b3          	add	a3,s11,a3
    80003264:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003268:	0087d79b          	srliw	a5,a5,0x8
    8000326c:	00100c93          	li	s9,1
    80003270:	f8d400a3          	sb	a3,-127(s0)
    80003274:	0cb67263          	bgeu	a2,a1,80003338 <__printf+0x410>
    80003278:	00f7f693          	andi	a3,a5,15
    8000327c:	00dd86b3          	add	a3,s11,a3
    80003280:	0006c583          	lbu	a1,0(a3)
    80003284:	00f00613          	li	a2,15
    80003288:	0047d69b          	srliw	a3,a5,0x4
    8000328c:	f8b40123          	sb	a1,-126(s0)
    80003290:	0047d593          	srli	a1,a5,0x4
    80003294:	28f67e63          	bgeu	a2,a5,80003530 <__printf+0x608>
    80003298:	00f6f693          	andi	a3,a3,15
    8000329c:	00dd86b3          	add	a3,s11,a3
    800032a0:	0006c503          	lbu	a0,0(a3)
    800032a4:	0087d813          	srli	a6,a5,0x8
    800032a8:	0087d69b          	srliw	a3,a5,0x8
    800032ac:	f8a401a3          	sb	a0,-125(s0)
    800032b0:	28b67663          	bgeu	a2,a1,8000353c <__printf+0x614>
    800032b4:	00f6f693          	andi	a3,a3,15
    800032b8:	00dd86b3          	add	a3,s11,a3
    800032bc:	0006c583          	lbu	a1,0(a3)
    800032c0:	00c7d513          	srli	a0,a5,0xc
    800032c4:	00c7d69b          	srliw	a3,a5,0xc
    800032c8:	f8b40223          	sb	a1,-124(s0)
    800032cc:	29067a63          	bgeu	a2,a6,80003560 <__printf+0x638>
    800032d0:	00f6f693          	andi	a3,a3,15
    800032d4:	00dd86b3          	add	a3,s11,a3
    800032d8:	0006c583          	lbu	a1,0(a3)
    800032dc:	0107d813          	srli	a6,a5,0x10
    800032e0:	0107d69b          	srliw	a3,a5,0x10
    800032e4:	f8b402a3          	sb	a1,-123(s0)
    800032e8:	28a67263          	bgeu	a2,a0,8000356c <__printf+0x644>
    800032ec:	00f6f693          	andi	a3,a3,15
    800032f0:	00dd86b3          	add	a3,s11,a3
    800032f4:	0006c683          	lbu	a3,0(a3)
    800032f8:	0147d79b          	srliw	a5,a5,0x14
    800032fc:	f8d40323          	sb	a3,-122(s0)
    80003300:	21067663          	bgeu	a2,a6,8000350c <__printf+0x5e4>
    80003304:	02079793          	slli	a5,a5,0x20
    80003308:	0207d793          	srli	a5,a5,0x20
    8000330c:	00fd8db3          	add	s11,s11,a5
    80003310:	000dc683          	lbu	a3,0(s11)
    80003314:	00800793          	li	a5,8
    80003318:	00700c93          	li	s9,7
    8000331c:	f8d403a3          	sb	a3,-121(s0)
    80003320:	00075c63          	bgez	a4,80003338 <__printf+0x410>
    80003324:	f9040713          	addi	a4,s0,-112
    80003328:	00f70733          	add	a4,a4,a5
    8000332c:	02d00693          	li	a3,45
    80003330:	fed70823          	sb	a3,-16(a4)
    80003334:	00078c93          	mv	s9,a5
    80003338:	f8040793          	addi	a5,s0,-128
    8000333c:	01978cb3          	add	s9,a5,s9
    80003340:	f7f40d13          	addi	s10,s0,-129
    80003344:	000cc503          	lbu	a0,0(s9)
    80003348:	fffc8c93          	addi	s9,s9,-1
    8000334c:	00000097          	auipc	ra,0x0
    80003350:	9f8080e7          	jalr	-1544(ra) # 80002d44 <consputc>
    80003354:	ff9d18e3          	bne	s10,s9,80003344 <__printf+0x41c>
    80003358:	0100006f          	j	80003368 <__printf+0x440>
    8000335c:	00000097          	auipc	ra,0x0
    80003360:	9e8080e7          	jalr	-1560(ra) # 80002d44 <consputc>
    80003364:	000c8493          	mv	s1,s9
    80003368:	00094503          	lbu	a0,0(s2)
    8000336c:	c60510e3          	bnez	a0,80002fcc <__printf+0xa4>
    80003370:	e40c0ee3          	beqz	s8,800031cc <__printf+0x2a4>
    80003374:	00004517          	auipc	a0,0x4
    80003378:	80c50513          	addi	a0,a0,-2036 # 80006b80 <pr>
    8000337c:	00001097          	auipc	ra,0x1
    80003380:	94c080e7          	jalr	-1716(ra) # 80003cc8 <release>
    80003384:	e49ff06f          	j	800031cc <__printf+0x2a4>
    80003388:	f7843783          	ld	a5,-136(s0)
    8000338c:	03000513          	li	a0,48
    80003390:	01000d13          	li	s10,16
    80003394:	00878713          	addi	a4,a5,8
    80003398:	0007bc83          	ld	s9,0(a5)
    8000339c:	f6e43c23          	sd	a4,-136(s0)
    800033a0:	00000097          	auipc	ra,0x0
    800033a4:	9a4080e7          	jalr	-1628(ra) # 80002d44 <consputc>
    800033a8:	07800513          	li	a0,120
    800033ac:	00000097          	auipc	ra,0x0
    800033b0:	998080e7          	jalr	-1640(ra) # 80002d44 <consputc>
    800033b4:	00002d97          	auipc	s11,0x2
    800033b8:	e64d8d93          	addi	s11,s11,-412 # 80005218 <digits>
    800033bc:	03ccd793          	srli	a5,s9,0x3c
    800033c0:	00fd87b3          	add	a5,s11,a5
    800033c4:	0007c503          	lbu	a0,0(a5)
    800033c8:	fffd0d1b          	addiw	s10,s10,-1
    800033cc:	004c9c93          	slli	s9,s9,0x4
    800033d0:	00000097          	auipc	ra,0x0
    800033d4:	974080e7          	jalr	-1676(ra) # 80002d44 <consputc>
    800033d8:	fe0d12e3          	bnez	s10,800033bc <__printf+0x494>
    800033dc:	f8dff06f          	j	80003368 <__printf+0x440>
    800033e0:	f7843783          	ld	a5,-136(s0)
    800033e4:	0007bc83          	ld	s9,0(a5)
    800033e8:	00878793          	addi	a5,a5,8
    800033ec:	f6f43c23          	sd	a5,-136(s0)
    800033f0:	000c9a63          	bnez	s9,80003404 <__printf+0x4dc>
    800033f4:	1080006f          	j	800034fc <__printf+0x5d4>
    800033f8:	001c8c93          	addi	s9,s9,1
    800033fc:	00000097          	auipc	ra,0x0
    80003400:	948080e7          	jalr	-1720(ra) # 80002d44 <consputc>
    80003404:	000cc503          	lbu	a0,0(s9)
    80003408:	fe0518e3          	bnez	a0,800033f8 <__printf+0x4d0>
    8000340c:	f5dff06f          	j	80003368 <__printf+0x440>
    80003410:	02500513          	li	a0,37
    80003414:	00000097          	auipc	ra,0x0
    80003418:	930080e7          	jalr	-1744(ra) # 80002d44 <consputc>
    8000341c:	000c8513          	mv	a0,s9
    80003420:	00000097          	auipc	ra,0x0
    80003424:	924080e7          	jalr	-1756(ra) # 80002d44 <consputc>
    80003428:	f41ff06f          	j	80003368 <__printf+0x440>
    8000342c:	02500513          	li	a0,37
    80003430:	00000097          	auipc	ra,0x0
    80003434:	914080e7          	jalr	-1772(ra) # 80002d44 <consputc>
    80003438:	f31ff06f          	j	80003368 <__printf+0x440>
    8000343c:	00030513          	mv	a0,t1
    80003440:	00000097          	auipc	ra,0x0
    80003444:	7bc080e7          	jalr	1980(ra) # 80003bfc <acquire>
    80003448:	b4dff06f          	j	80002f94 <__printf+0x6c>
    8000344c:	40c0053b          	negw	a0,a2
    80003450:	00a00713          	li	a4,10
    80003454:	02e576bb          	remuw	a3,a0,a4
    80003458:	00002d97          	auipc	s11,0x2
    8000345c:	dc0d8d93          	addi	s11,s11,-576 # 80005218 <digits>
    80003460:	ff700593          	li	a1,-9
    80003464:	02069693          	slli	a3,a3,0x20
    80003468:	0206d693          	srli	a3,a3,0x20
    8000346c:	00dd86b3          	add	a3,s11,a3
    80003470:	0006c683          	lbu	a3,0(a3)
    80003474:	02e557bb          	divuw	a5,a0,a4
    80003478:	f8d40023          	sb	a3,-128(s0)
    8000347c:	10b65e63          	bge	a2,a1,80003598 <__printf+0x670>
    80003480:	06300593          	li	a1,99
    80003484:	02e7f6bb          	remuw	a3,a5,a4
    80003488:	02069693          	slli	a3,a3,0x20
    8000348c:	0206d693          	srli	a3,a3,0x20
    80003490:	00dd86b3          	add	a3,s11,a3
    80003494:	0006c683          	lbu	a3,0(a3)
    80003498:	02e7d73b          	divuw	a4,a5,a4
    8000349c:	00200793          	li	a5,2
    800034a0:	f8d400a3          	sb	a3,-127(s0)
    800034a4:	bca5ece3          	bltu	a1,a0,8000307c <__printf+0x154>
    800034a8:	ce5ff06f          	j	8000318c <__printf+0x264>
    800034ac:	40e007bb          	negw	a5,a4
    800034b0:	00002d97          	auipc	s11,0x2
    800034b4:	d68d8d93          	addi	s11,s11,-664 # 80005218 <digits>
    800034b8:	00f7f693          	andi	a3,a5,15
    800034bc:	00dd86b3          	add	a3,s11,a3
    800034c0:	0006c583          	lbu	a1,0(a3)
    800034c4:	ff100613          	li	a2,-15
    800034c8:	0047d69b          	srliw	a3,a5,0x4
    800034cc:	f8b40023          	sb	a1,-128(s0)
    800034d0:	0047d59b          	srliw	a1,a5,0x4
    800034d4:	0ac75e63          	bge	a4,a2,80003590 <__printf+0x668>
    800034d8:	00f6f693          	andi	a3,a3,15
    800034dc:	00dd86b3          	add	a3,s11,a3
    800034e0:	0006c603          	lbu	a2,0(a3)
    800034e4:	00f00693          	li	a3,15
    800034e8:	0087d79b          	srliw	a5,a5,0x8
    800034ec:	f8c400a3          	sb	a2,-127(s0)
    800034f0:	d8b6e4e3          	bltu	a3,a1,80003278 <__printf+0x350>
    800034f4:	00200793          	li	a5,2
    800034f8:	e2dff06f          	j	80003324 <__printf+0x3fc>
    800034fc:	00002c97          	auipc	s9,0x2
    80003500:	cfcc8c93          	addi	s9,s9,-772 # 800051f8 <_ZZ12printIntegermE6digits+0x148>
    80003504:	02800513          	li	a0,40
    80003508:	ef1ff06f          	j	800033f8 <__printf+0x4d0>
    8000350c:	00700793          	li	a5,7
    80003510:	00600c93          	li	s9,6
    80003514:	e0dff06f          	j	80003320 <__printf+0x3f8>
    80003518:	00700793          	li	a5,7
    8000351c:	00600c93          	li	s9,6
    80003520:	c69ff06f          	j	80003188 <__printf+0x260>
    80003524:	00300793          	li	a5,3
    80003528:	00200c93          	li	s9,2
    8000352c:	c5dff06f          	j	80003188 <__printf+0x260>
    80003530:	00300793          	li	a5,3
    80003534:	00200c93          	li	s9,2
    80003538:	de9ff06f          	j	80003320 <__printf+0x3f8>
    8000353c:	00400793          	li	a5,4
    80003540:	00300c93          	li	s9,3
    80003544:	dddff06f          	j	80003320 <__printf+0x3f8>
    80003548:	00400793          	li	a5,4
    8000354c:	00300c93          	li	s9,3
    80003550:	c39ff06f          	j	80003188 <__printf+0x260>
    80003554:	00500793          	li	a5,5
    80003558:	00400c93          	li	s9,4
    8000355c:	c2dff06f          	j	80003188 <__printf+0x260>
    80003560:	00500793          	li	a5,5
    80003564:	00400c93          	li	s9,4
    80003568:	db9ff06f          	j	80003320 <__printf+0x3f8>
    8000356c:	00600793          	li	a5,6
    80003570:	00500c93          	li	s9,5
    80003574:	dadff06f          	j	80003320 <__printf+0x3f8>
    80003578:	00600793          	li	a5,6
    8000357c:	00500c93          	li	s9,5
    80003580:	c09ff06f          	j	80003188 <__printf+0x260>
    80003584:	00800793          	li	a5,8
    80003588:	00700c93          	li	s9,7
    8000358c:	bfdff06f          	j	80003188 <__printf+0x260>
    80003590:	00100793          	li	a5,1
    80003594:	d91ff06f          	j	80003324 <__printf+0x3fc>
    80003598:	00100793          	li	a5,1
    8000359c:	bf1ff06f          	j	8000318c <__printf+0x264>
    800035a0:	00900793          	li	a5,9
    800035a4:	00800c93          	li	s9,8
    800035a8:	be1ff06f          	j	80003188 <__printf+0x260>
    800035ac:	00002517          	auipc	a0,0x2
    800035b0:	c5450513          	addi	a0,a0,-940 # 80005200 <_ZZ12printIntegermE6digits+0x150>
    800035b4:	00000097          	auipc	ra,0x0
    800035b8:	918080e7          	jalr	-1768(ra) # 80002ecc <panic>

00000000800035bc <printfinit>:
    800035bc:	fe010113          	addi	sp,sp,-32
    800035c0:	00813823          	sd	s0,16(sp)
    800035c4:	00913423          	sd	s1,8(sp)
    800035c8:	00113c23          	sd	ra,24(sp)
    800035cc:	02010413          	addi	s0,sp,32
    800035d0:	00003497          	auipc	s1,0x3
    800035d4:	5b048493          	addi	s1,s1,1456 # 80006b80 <pr>
    800035d8:	00048513          	mv	a0,s1
    800035dc:	00002597          	auipc	a1,0x2
    800035e0:	c3458593          	addi	a1,a1,-972 # 80005210 <_ZZ12printIntegermE6digits+0x160>
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	5f4080e7          	jalr	1524(ra) # 80003bd8 <initlock>
    800035ec:	01813083          	ld	ra,24(sp)
    800035f0:	01013403          	ld	s0,16(sp)
    800035f4:	0004ac23          	sw	zero,24(s1)
    800035f8:	00813483          	ld	s1,8(sp)
    800035fc:	02010113          	addi	sp,sp,32
    80003600:	00008067          	ret

0000000080003604 <uartinit>:
    80003604:	ff010113          	addi	sp,sp,-16
    80003608:	00813423          	sd	s0,8(sp)
    8000360c:	01010413          	addi	s0,sp,16
    80003610:	100007b7          	lui	a5,0x10000
    80003614:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003618:	f8000713          	li	a4,-128
    8000361c:	00e781a3          	sb	a4,3(a5)
    80003620:	00300713          	li	a4,3
    80003624:	00e78023          	sb	a4,0(a5)
    80003628:	000780a3          	sb	zero,1(a5)
    8000362c:	00e781a3          	sb	a4,3(a5)
    80003630:	00700693          	li	a3,7
    80003634:	00d78123          	sb	a3,2(a5)
    80003638:	00e780a3          	sb	a4,1(a5)
    8000363c:	00813403          	ld	s0,8(sp)
    80003640:	01010113          	addi	sp,sp,16
    80003644:	00008067          	ret

0000000080003648 <uartputc>:
    80003648:	00002797          	auipc	a5,0x2
    8000364c:	2c07a783          	lw	a5,704(a5) # 80005908 <panicked>
    80003650:	00078463          	beqz	a5,80003658 <uartputc+0x10>
    80003654:	0000006f          	j	80003654 <uartputc+0xc>
    80003658:	fd010113          	addi	sp,sp,-48
    8000365c:	02813023          	sd	s0,32(sp)
    80003660:	00913c23          	sd	s1,24(sp)
    80003664:	01213823          	sd	s2,16(sp)
    80003668:	01313423          	sd	s3,8(sp)
    8000366c:	02113423          	sd	ra,40(sp)
    80003670:	03010413          	addi	s0,sp,48
    80003674:	00002917          	auipc	s2,0x2
    80003678:	29c90913          	addi	s2,s2,668 # 80005910 <uart_tx_r>
    8000367c:	00093783          	ld	a5,0(s2)
    80003680:	00002497          	auipc	s1,0x2
    80003684:	29848493          	addi	s1,s1,664 # 80005918 <uart_tx_w>
    80003688:	0004b703          	ld	a4,0(s1)
    8000368c:	02078693          	addi	a3,a5,32
    80003690:	00050993          	mv	s3,a0
    80003694:	02e69c63          	bne	a3,a4,800036cc <uartputc+0x84>
    80003698:	00001097          	auipc	ra,0x1
    8000369c:	834080e7          	jalr	-1996(ra) # 80003ecc <push_on>
    800036a0:	00093783          	ld	a5,0(s2)
    800036a4:	0004b703          	ld	a4,0(s1)
    800036a8:	02078793          	addi	a5,a5,32
    800036ac:	00e79463          	bne	a5,a4,800036b4 <uartputc+0x6c>
    800036b0:	0000006f          	j	800036b0 <uartputc+0x68>
    800036b4:	00001097          	auipc	ra,0x1
    800036b8:	88c080e7          	jalr	-1908(ra) # 80003f40 <pop_on>
    800036bc:	00093783          	ld	a5,0(s2)
    800036c0:	0004b703          	ld	a4,0(s1)
    800036c4:	02078693          	addi	a3,a5,32
    800036c8:	fce688e3          	beq	a3,a4,80003698 <uartputc+0x50>
    800036cc:	01f77693          	andi	a3,a4,31
    800036d0:	00003597          	auipc	a1,0x3
    800036d4:	4d058593          	addi	a1,a1,1232 # 80006ba0 <uart_tx_buf>
    800036d8:	00d586b3          	add	a3,a1,a3
    800036dc:	00170713          	addi	a4,a4,1
    800036e0:	01368023          	sb	s3,0(a3)
    800036e4:	00e4b023          	sd	a4,0(s1)
    800036e8:	10000637          	lui	a2,0x10000
    800036ec:	02f71063          	bne	a4,a5,8000370c <uartputc+0xc4>
    800036f0:	0340006f          	j	80003724 <uartputc+0xdc>
    800036f4:	00074703          	lbu	a4,0(a4)
    800036f8:	00f93023          	sd	a5,0(s2)
    800036fc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003700:	00093783          	ld	a5,0(s2)
    80003704:	0004b703          	ld	a4,0(s1)
    80003708:	00f70e63          	beq	a4,a5,80003724 <uartputc+0xdc>
    8000370c:	00564683          	lbu	a3,5(a2)
    80003710:	01f7f713          	andi	a4,a5,31
    80003714:	00e58733          	add	a4,a1,a4
    80003718:	0206f693          	andi	a3,a3,32
    8000371c:	00178793          	addi	a5,a5,1
    80003720:	fc069ae3          	bnez	a3,800036f4 <uartputc+0xac>
    80003724:	02813083          	ld	ra,40(sp)
    80003728:	02013403          	ld	s0,32(sp)
    8000372c:	01813483          	ld	s1,24(sp)
    80003730:	01013903          	ld	s2,16(sp)
    80003734:	00813983          	ld	s3,8(sp)
    80003738:	03010113          	addi	sp,sp,48
    8000373c:	00008067          	ret

0000000080003740 <uartputc_sync>:
    80003740:	ff010113          	addi	sp,sp,-16
    80003744:	00813423          	sd	s0,8(sp)
    80003748:	01010413          	addi	s0,sp,16
    8000374c:	00002717          	auipc	a4,0x2
    80003750:	1bc72703          	lw	a4,444(a4) # 80005908 <panicked>
    80003754:	02071663          	bnez	a4,80003780 <uartputc_sync+0x40>
    80003758:	00050793          	mv	a5,a0
    8000375c:	100006b7          	lui	a3,0x10000
    80003760:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003764:	02077713          	andi	a4,a4,32
    80003768:	fe070ce3          	beqz	a4,80003760 <uartputc_sync+0x20>
    8000376c:	0ff7f793          	andi	a5,a5,255
    80003770:	00f68023          	sb	a5,0(a3)
    80003774:	00813403          	ld	s0,8(sp)
    80003778:	01010113          	addi	sp,sp,16
    8000377c:	00008067          	ret
    80003780:	0000006f          	j	80003780 <uartputc_sync+0x40>

0000000080003784 <uartstart>:
    80003784:	ff010113          	addi	sp,sp,-16
    80003788:	00813423          	sd	s0,8(sp)
    8000378c:	01010413          	addi	s0,sp,16
    80003790:	00002617          	auipc	a2,0x2
    80003794:	18060613          	addi	a2,a2,384 # 80005910 <uart_tx_r>
    80003798:	00002517          	auipc	a0,0x2
    8000379c:	18050513          	addi	a0,a0,384 # 80005918 <uart_tx_w>
    800037a0:	00063783          	ld	a5,0(a2)
    800037a4:	00053703          	ld	a4,0(a0)
    800037a8:	04f70263          	beq	a4,a5,800037ec <uartstart+0x68>
    800037ac:	100005b7          	lui	a1,0x10000
    800037b0:	00003817          	auipc	a6,0x3
    800037b4:	3f080813          	addi	a6,a6,1008 # 80006ba0 <uart_tx_buf>
    800037b8:	01c0006f          	j	800037d4 <uartstart+0x50>
    800037bc:	0006c703          	lbu	a4,0(a3)
    800037c0:	00f63023          	sd	a5,0(a2)
    800037c4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800037c8:	00063783          	ld	a5,0(a2)
    800037cc:	00053703          	ld	a4,0(a0)
    800037d0:	00f70e63          	beq	a4,a5,800037ec <uartstart+0x68>
    800037d4:	01f7f713          	andi	a4,a5,31
    800037d8:	00e806b3          	add	a3,a6,a4
    800037dc:	0055c703          	lbu	a4,5(a1)
    800037e0:	00178793          	addi	a5,a5,1
    800037e4:	02077713          	andi	a4,a4,32
    800037e8:	fc071ae3          	bnez	a4,800037bc <uartstart+0x38>
    800037ec:	00813403          	ld	s0,8(sp)
    800037f0:	01010113          	addi	sp,sp,16
    800037f4:	00008067          	ret

00000000800037f8 <uartgetc>:
    800037f8:	ff010113          	addi	sp,sp,-16
    800037fc:	00813423          	sd	s0,8(sp)
    80003800:	01010413          	addi	s0,sp,16
    80003804:	10000737          	lui	a4,0x10000
    80003808:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000380c:	0017f793          	andi	a5,a5,1
    80003810:	00078c63          	beqz	a5,80003828 <uartgetc+0x30>
    80003814:	00074503          	lbu	a0,0(a4)
    80003818:	0ff57513          	andi	a0,a0,255
    8000381c:	00813403          	ld	s0,8(sp)
    80003820:	01010113          	addi	sp,sp,16
    80003824:	00008067          	ret
    80003828:	fff00513          	li	a0,-1
    8000382c:	ff1ff06f          	j	8000381c <uartgetc+0x24>

0000000080003830 <uartintr>:
    80003830:	100007b7          	lui	a5,0x10000
    80003834:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003838:	0017f793          	andi	a5,a5,1
    8000383c:	0a078463          	beqz	a5,800038e4 <uartintr+0xb4>
    80003840:	fe010113          	addi	sp,sp,-32
    80003844:	00813823          	sd	s0,16(sp)
    80003848:	00913423          	sd	s1,8(sp)
    8000384c:	00113c23          	sd	ra,24(sp)
    80003850:	02010413          	addi	s0,sp,32
    80003854:	100004b7          	lui	s1,0x10000
    80003858:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000385c:	0ff57513          	andi	a0,a0,255
    80003860:	fffff097          	auipc	ra,0xfffff
    80003864:	534080e7          	jalr	1332(ra) # 80002d94 <consoleintr>
    80003868:	0054c783          	lbu	a5,5(s1)
    8000386c:	0017f793          	andi	a5,a5,1
    80003870:	fe0794e3          	bnez	a5,80003858 <uartintr+0x28>
    80003874:	00002617          	auipc	a2,0x2
    80003878:	09c60613          	addi	a2,a2,156 # 80005910 <uart_tx_r>
    8000387c:	00002517          	auipc	a0,0x2
    80003880:	09c50513          	addi	a0,a0,156 # 80005918 <uart_tx_w>
    80003884:	00063783          	ld	a5,0(a2)
    80003888:	00053703          	ld	a4,0(a0)
    8000388c:	04f70263          	beq	a4,a5,800038d0 <uartintr+0xa0>
    80003890:	100005b7          	lui	a1,0x10000
    80003894:	00003817          	auipc	a6,0x3
    80003898:	30c80813          	addi	a6,a6,780 # 80006ba0 <uart_tx_buf>
    8000389c:	01c0006f          	j	800038b8 <uartintr+0x88>
    800038a0:	0006c703          	lbu	a4,0(a3)
    800038a4:	00f63023          	sd	a5,0(a2)
    800038a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800038ac:	00063783          	ld	a5,0(a2)
    800038b0:	00053703          	ld	a4,0(a0)
    800038b4:	00f70e63          	beq	a4,a5,800038d0 <uartintr+0xa0>
    800038b8:	01f7f713          	andi	a4,a5,31
    800038bc:	00e806b3          	add	a3,a6,a4
    800038c0:	0055c703          	lbu	a4,5(a1)
    800038c4:	00178793          	addi	a5,a5,1
    800038c8:	02077713          	andi	a4,a4,32
    800038cc:	fc071ae3          	bnez	a4,800038a0 <uartintr+0x70>
    800038d0:	01813083          	ld	ra,24(sp)
    800038d4:	01013403          	ld	s0,16(sp)
    800038d8:	00813483          	ld	s1,8(sp)
    800038dc:	02010113          	addi	sp,sp,32
    800038e0:	00008067          	ret
    800038e4:	00002617          	auipc	a2,0x2
    800038e8:	02c60613          	addi	a2,a2,44 # 80005910 <uart_tx_r>
    800038ec:	00002517          	auipc	a0,0x2
    800038f0:	02c50513          	addi	a0,a0,44 # 80005918 <uart_tx_w>
    800038f4:	00063783          	ld	a5,0(a2)
    800038f8:	00053703          	ld	a4,0(a0)
    800038fc:	04f70263          	beq	a4,a5,80003940 <uartintr+0x110>
    80003900:	100005b7          	lui	a1,0x10000
    80003904:	00003817          	auipc	a6,0x3
    80003908:	29c80813          	addi	a6,a6,668 # 80006ba0 <uart_tx_buf>
    8000390c:	01c0006f          	j	80003928 <uartintr+0xf8>
    80003910:	0006c703          	lbu	a4,0(a3)
    80003914:	00f63023          	sd	a5,0(a2)
    80003918:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000391c:	00063783          	ld	a5,0(a2)
    80003920:	00053703          	ld	a4,0(a0)
    80003924:	02f70063          	beq	a4,a5,80003944 <uartintr+0x114>
    80003928:	01f7f713          	andi	a4,a5,31
    8000392c:	00e806b3          	add	a3,a6,a4
    80003930:	0055c703          	lbu	a4,5(a1)
    80003934:	00178793          	addi	a5,a5,1
    80003938:	02077713          	andi	a4,a4,32
    8000393c:	fc071ae3          	bnez	a4,80003910 <uartintr+0xe0>
    80003940:	00008067          	ret
    80003944:	00008067          	ret

0000000080003948 <kinit>:
    80003948:	fc010113          	addi	sp,sp,-64
    8000394c:	02913423          	sd	s1,40(sp)
    80003950:	fffff7b7          	lui	a5,0xfffff
    80003954:	00004497          	auipc	s1,0x4
    80003958:	26b48493          	addi	s1,s1,619 # 80007bbf <end+0xfff>
    8000395c:	02813823          	sd	s0,48(sp)
    80003960:	01313c23          	sd	s3,24(sp)
    80003964:	00f4f4b3          	and	s1,s1,a5
    80003968:	02113c23          	sd	ra,56(sp)
    8000396c:	03213023          	sd	s2,32(sp)
    80003970:	01413823          	sd	s4,16(sp)
    80003974:	01513423          	sd	s5,8(sp)
    80003978:	04010413          	addi	s0,sp,64
    8000397c:	000017b7          	lui	a5,0x1
    80003980:	01100993          	li	s3,17
    80003984:	00f487b3          	add	a5,s1,a5
    80003988:	01b99993          	slli	s3,s3,0x1b
    8000398c:	06f9e063          	bltu	s3,a5,800039ec <kinit+0xa4>
    80003990:	00003a97          	auipc	s5,0x3
    80003994:	230a8a93          	addi	s5,s5,560 # 80006bc0 <end>
    80003998:	0754ec63          	bltu	s1,s5,80003a10 <kinit+0xc8>
    8000399c:	0734fa63          	bgeu	s1,s3,80003a10 <kinit+0xc8>
    800039a0:	00088a37          	lui	s4,0x88
    800039a4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800039a8:	00002917          	auipc	s2,0x2
    800039ac:	f7890913          	addi	s2,s2,-136 # 80005920 <kmem>
    800039b0:	00ca1a13          	slli	s4,s4,0xc
    800039b4:	0140006f          	j	800039c8 <kinit+0x80>
    800039b8:	000017b7          	lui	a5,0x1
    800039bc:	00f484b3          	add	s1,s1,a5
    800039c0:	0554e863          	bltu	s1,s5,80003a10 <kinit+0xc8>
    800039c4:	0534f663          	bgeu	s1,s3,80003a10 <kinit+0xc8>
    800039c8:	00001637          	lui	a2,0x1
    800039cc:	00100593          	li	a1,1
    800039d0:	00048513          	mv	a0,s1
    800039d4:	00000097          	auipc	ra,0x0
    800039d8:	5e4080e7          	jalr	1508(ra) # 80003fb8 <__memset>
    800039dc:	00093783          	ld	a5,0(s2)
    800039e0:	00f4b023          	sd	a5,0(s1)
    800039e4:	00993023          	sd	s1,0(s2)
    800039e8:	fd4498e3          	bne	s1,s4,800039b8 <kinit+0x70>
    800039ec:	03813083          	ld	ra,56(sp)
    800039f0:	03013403          	ld	s0,48(sp)
    800039f4:	02813483          	ld	s1,40(sp)
    800039f8:	02013903          	ld	s2,32(sp)
    800039fc:	01813983          	ld	s3,24(sp)
    80003a00:	01013a03          	ld	s4,16(sp)
    80003a04:	00813a83          	ld	s5,8(sp)
    80003a08:	04010113          	addi	sp,sp,64
    80003a0c:	00008067          	ret
    80003a10:	00002517          	auipc	a0,0x2
    80003a14:	82050513          	addi	a0,a0,-2016 # 80005230 <digits+0x18>
    80003a18:	fffff097          	auipc	ra,0xfffff
    80003a1c:	4b4080e7          	jalr	1204(ra) # 80002ecc <panic>

0000000080003a20 <freerange>:
    80003a20:	fc010113          	addi	sp,sp,-64
    80003a24:	000017b7          	lui	a5,0x1
    80003a28:	02913423          	sd	s1,40(sp)
    80003a2c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003a30:	009504b3          	add	s1,a0,s1
    80003a34:	fffff537          	lui	a0,0xfffff
    80003a38:	02813823          	sd	s0,48(sp)
    80003a3c:	02113c23          	sd	ra,56(sp)
    80003a40:	03213023          	sd	s2,32(sp)
    80003a44:	01313c23          	sd	s3,24(sp)
    80003a48:	01413823          	sd	s4,16(sp)
    80003a4c:	01513423          	sd	s5,8(sp)
    80003a50:	01613023          	sd	s6,0(sp)
    80003a54:	04010413          	addi	s0,sp,64
    80003a58:	00a4f4b3          	and	s1,s1,a0
    80003a5c:	00f487b3          	add	a5,s1,a5
    80003a60:	06f5e463          	bltu	a1,a5,80003ac8 <freerange+0xa8>
    80003a64:	00003a97          	auipc	s5,0x3
    80003a68:	15ca8a93          	addi	s5,s5,348 # 80006bc0 <end>
    80003a6c:	0954e263          	bltu	s1,s5,80003af0 <freerange+0xd0>
    80003a70:	01100993          	li	s3,17
    80003a74:	01b99993          	slli	s3,s3,0x1b
    80003a78:	0734fc63          	bgeu	s1,s3,80003af0 <freerange+0xd0>
    80003a7c:	00058a13          	mv	s4,a1
    80003a80:	00002917          	auipc	s2,0x2
    80003a84:	ea090913          	addi	s2,s2,-352 # 80005920 <kmem>
    80003a88:	00002b37          	lui	s6,0x2
    80003a8c:	0140006f          	j	80003aa0 <freerange+0x80>
    80003a90:	000017b7          	lui	a5,0x1
    80003a94:	00f484b3          	add	s1,s1,a5
    80003a98:	0554ec63          	bltu	s1,s5,80003af0 <freerange+0xd0>
    80003a9c:	0534fa63          	bgeu	s1,s3,80003af0 <freerange+0xd0>
    80003aa0:	00001637          	lui	a2,0x1
    80003aa4:	00100593          	li	a1,1
    80003aa8:	00048513          	mv	a0,s1
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	50c080e7          	jalr	1292(ra) # 80003fb8 <__memset>
    80003ab4:	00093703          	ld	a4,0(s2)
    80003ab8:	016487b3          	add	a5,s1,s6
    80003abc:	00e4b023          	sd	a4,0(s1)
    80003ac0:	00993023          	sd	s1,0(s2)
    80003ac4:	fcfa76e3          	bgeu	s4,a5,80003a90 <freerange+0x70>
    80003ac8:	03813083          	ld	ra,56(sp)
    80003acc:	03013403          	ld	s0,48(sp)
    80003ad0:	02813483          	ld	s1,40(sp)
    80003ad4:	02013903          	ld	s2,32(sp)
    80003ad8:	01813983          	ld	s3,24(sp)
    80003adc:	01013a03          	ld	s4,16(sp)
    80003ae0:	00813a83          	ld	s5,8(sp)
    80003ae4:	00013b03          	ld	s6,0(sp)
    80003ae8:	04010113          	addi	sp,sp,64
    80003aec:	00008067          	ret
    80003af0:	00001517          	auipc	a0,0x1
    80003af4:	74050513          	addi	a0,a0,1856 # 80005230 <digits+0x18>
    80003af8:	fffff097          	auipc	ra,0xfffff
    80003afc:	3d4080e7          	jalr	980(ra) # 80002ecc <panic>

0000000080003b00 <kfree>:
    80003b00:	fe010113          	addi	sp,sp,-32
    80003b04:	00813823          	sd	s0,16(sp)
    80003b08:	00113c23          	sd	ra,24(sp)
    80003b0c:	00913423          	sd	s1,8(sp)
    80003b10:	02010413          	addi	s0,sp,32
    80003b14:	03451793          	slli	a5,a0,0x34
    80003b18:	04079c63          	bnez	a5,80003b70 <kfree+0x70>
    80003b1c:	00003797          	auipc	a5,0x3
    80003b20:	0a478793          	addi	a5,a5,164 # 80006bc0 <end>
    80003b24:	00050493          	mv	s1,a0
    80003b28:	04f56463          	bltu	a0,a5,80003b70 <kfree+0x70>
    80003b2c:	01100793          	li	a5,17
    80003b30:	01b79793          	slli	a5,a5,0x1b
    80003b34:	02f57e63          	bgeu	a0,a5,80003b70 <kfree+0x70>
    80003b38:	00001637          	lui	a2,0x1
    80003b3c:	00100593          	li	a1,1
    80003b40:	00000097          	auipc	ra,0x0
    80003b44:	478080e7          	jalr	1144(ra) # 80003fb8 <__memset>
    80003b48:	00002797          	auipc	a5,0x2
    80003b4c:	dd878793          	addi	a5,a5,-552 # 80005920 <kmem>
    80003b50:	0007b703          	ld	a4,0(a5)
    80003b54:	01813083          	ld	ra,24(sp)
    80003b58:	01013403          	ld	s0,16(sp)
    80003b5c:	00e4b023          	sd	a4,0(s1)
    80003b60:	0097b023          	sd	s1,0(a5)
    80003b64:	00813483          	ld	s1,8(sp)
    80003b68:	02010113          	addi	sp,sp,32
    80003b6c:	00008067          	ret
    80003b70:	00001517          	auipc	a0,0x1
    80003b74:	6c050513          	addi	a0,a0,1728 # 80005230 <digits+0x18>
    80003b78:	fffff097          	auipc	ra,0xfffff
    80003b7c:	354080e7          	jalr	852(ra) # 80002ecc <panic>

0000000080003b80 <kalloc>:
    80003b80:	fe010113          	addi	sp,sp,-32
    80003b84:	00813823          	sd	s0,16(sp)
    80003b88:	00913423          	sd	s1,8(sp)
    80003b8c:	00113c23          	sd	ra,24(sp)
    80003b90:	02010413          	addi	s0,sp,32
    80003b94:	00002797          	auipc	a5,0x2
    80003b98:	d8c78793          	addi	a5,a5,-628 # 80005920 <kmem>
    80003b9c:	0007b483          	ld	s1,0(a5)
    80003ba0:	02048063          	beqz	s1,80003bc0 <kalloc+0x40>
    80003ba4:	0004b703          	ld	a4,0(s1)
    80003ba8:	00001637          	lui	a2,0x1
    80003bac:	00500593          	li	a1,5
    80003bb0:	00048513          	mv	a0,s1
    80003bb4:	00e7b023          	sd	a4,0(a5)
    80003bb8:	00000097          	auipc	ra,0x0
    80003bbc:	400080e7          	jalr	1024(ra) # 80003fb8 <__memset>
    80003bc0:	01813083          	ld	ra,24(sp)
    80003bc4:	01013403          	ld	s0,16(sp)
    80003bc8:	00048513          	mv	a0,s1
    80003bcc:	00813483          	ld	s1,8(sp)
    80003bd0:	02010113          	addi	sp,sp,32
    80003bd4:	00008067          	ret

0000000080003bd8 <initlock>:
    80003bd8:	ff010113          	addi	sp,sp,-16
    80003bdc:	00813423          	sd	s0,8(sp)
    80003be0:	01010413          	addi	s0,sp,16
    80003be4:	00813403          	ld	s0,8(sp)
    80003be8:	00b53423          	sd	a1,8(a0)
    80003bec:	00052023          	sw	zero,0(a0)
    80003bf0:	00053823          	sd	zero,16(a0)
    80003bf4:	01010113          	addi	sp,sp,16
    80003bf8:	00008067          	ret

0000000080003bfc <acquire>:
    80003bfc:	fe010113          	addi	sp,sp,-32
    80003c00:	00813823          	sd	s0,16(sp)
    80003c04:	00913423          	sd	s1,8(sp)
    80003c08:	00113c23          	sd	ra,24(sp)
    80003c0c:	01213023          	sd	s2,0(sp)
    80003c10:	02010413          	addi	s0,sp,32
    80003c14:	00050493          	mv	s1,a0
    80003c18:	10002973          	csrr	s2,sstatus
    80003c1c:	100027f3          	csrr	a5,sstatus
    80003c20:	ffd7f793          	andi	a5,a5,-3
    80003c24:	10079073          	csrw	sstatus,a5
    80003c28:	fffff097          	auipc	ra,0xfffff
    80003c2c:	8ec080e7          	jalr	-1812(ra) # 80002514 <mycpu>
    80003c30:	07852783          	lw	a5,120(a0)
    80003c34:	06078e63          	beqz	a5,80003cb0 <acquire+0xb4>
    80003c38:	fffff097          	auipc	ra,0xfffff
    80003c3c:	8dc080e7          	jalr	-1828(ra) # 80002514 <mycpu>
    80003c40:	07852783          	lw	a5,120(a0)
    80003c44:	0004a703          	lw	a4,0(s1)
    80003c48:	0017879b          	addiw	a5,a5,1
    80003c4c:	06f52c23          	sw	a5,120(a0)
    80003c50:	04071063          	bnez	a4,80003c90 <acquire+0x94>
    80003c54:	00100713          	li	a4,1
    80003c58:	00070793          	mv	a5,a4
    80003c5c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003c60:	0007879b          	sext.w	a5,a5
    80003c64:	fe079ae3          	bnez	a5,80003c58 <acquire+0x5c>
    80003c68:	0ff0000f          	fence
    80003c6c:	fffff097          	auipc	ra,0xfffff
    80003c70:	8a8080e7          	jalr	-1880(ra) # 80002514 <mycpu>
    80003c74:	01813083          	ld	ra,24(sp)
    80003c78:	01013403          	ld	s0,16(sp)
    80003c7c:	00a4b823          	sd	a0,16(s1)
    80003c80:	00013903          	ld	s2,0(sp)
    80003c84:	00813483          	ld	s1,8(sp)
    80003c88:	02010113          	addi	sp,sp,32
    80003c8c:	00008067          	ret
    80003c90:	0104b903          	ld	s2,16(s1)
    80003c94:	fffff097          	auipc	ra,0xfffff
    80003c98:	880080e7          	jalr	-1920(ra) # 80002514 <mycpu>
    80003c9c:	faa91ce3          	bne	s2,a0,80003c54 <acquire+0x58>
    80003ca0:	00001517          	auipc	a0,0x1
    80003ca4:	59850513          	addi	a0,a0,1432 # 80005238 <digits+0x20>
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	224080e7          	jalr	548(ra) # 80002ecc <panic>
    80003cb0:	00195913          	srli	s2,s2,0x1
    80003cb4:	fffff097          	auipc	ra,0xfffff
    80003cb8:	860080e7          	jalr	-1952(ra) # 80002514 <mycpu>
    80003cbc:	00197913          	andi	s2,s2,1
    80003cc0:	07252e23          	sw	s2,124(a0)
    80003cc4:	f75ff06f          	j	80003c38 <acquire+0x3c>

0000000080003cc8 <release>:
    80003cc8:	fe010113          	addi	sp,sp,-32
    80003ccc:	00813823          	sd	s0,16(sp)
    80003cd0:	00113c23          	sd	ra,24(sp)
    80003cd4:	00913423          	sd	s1,8(sp)
    80003cd8:	01213023          	sd	s2,0(sp)
    80003cdc:	02010413          	addi	s0,sp,32
    80003ce0:	00052783          	lw	a5,0(a0)
    80003ce4:	00079a63          	bnez	a5,80003cf8 <release+0x30>
    80003ce8:	00001517          	auipc	a0,0x1
    80003cec:	55850513          	addi	a0,a0,1368 # 80005240 <digits+0x28>
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	1dc080e7          	jalr	476(ra) # 80002ecc <panic>
    80003cf8:	01053903          	ld	s2,16(a0)
    80003cfc:	00050493          	mv	s1,a0
    80003d00:	fffff097          	auipc	ra,0xfffff
    80003d04:	814080e7          	jalr	-2028(ra) # 80002514 <mycpu>
    80003d08:	fea910e3          	bne	s2,a0,80003ce8 <release+0x20>
    80003d0c:	0004b823          	sd	zero,16(s1)
    80003d10:	0ff0000f          	fence
    80003d14:	0f50000f          	fence	iorw,ow
    80003d18:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003d1c:	ffffe097          	auipc	ra,0xffffe
    80003d20:	7f8080e7          	jalr	2040(ra) # 80002514 <mycpu>
    80003d24:	100027f3          	csrr	a5,sstatus
    80003d28:	0027f793          	andi	a5,a5,2
    80003d2c:	04079a63          	bnez	a5,80003d80 <release+0xb8>
    80003d30:	07852783          	lw	a5,120(a0)
    80003d34:	02f05e63          	blez	a5,80003d70 <release+0xa8>
    80003d38:	fff7871b          	addiw	a4,a5,-1
    80003d3c:	06e52c23          	sw	a4,120(a0)
    80003d40:	00071c63          	bnez	a4,80003d58 <release+0x90>
    80003d44:	07c52783          	lw	a5,124(a0)
    80003d48:	00078863          	beqz	a5,80003d58 <release+0x90>
    80003d4c:	100027f3          	csrr	a5,sstatus
    80003d50:	0027e793          	ori	a5,a5,2
    80003d54:	10079073          	csrw	sstatus,a5
    80003d58:	01813083          	ld	ra,24(sp)
    80003d5c:	01013403          	ld	s0,16(sp)
    80003d60:	00813483          	ld	s1,8(sp)
    80003d64:	00013903          	ld	s2,0(sp)
    80003d68:	02010113          	addi	sp,sp,32
    80003d6c:	00008067          	ret
    80003d70:	00001517          	auipc	a0,0x1
    80003d74:	4f050513          	addi	a0,a0,1264 # 80005260 <digits+0x48>
    80003d78:	fffff097          	auipc	ra,0xfffff
    80003d7c:	154080e7          	jalr	340(ra) # 80002ecc <panic>
    80003d80:	00001517          	auipc	a0,0x1
    80003d84:	4c850513          	addi	a0,a0,1224 # 80005248 <digits+0x30>
    80003d88:	fffff097          	auipc	ra,0xfffff
    80003d8c:	144080e7          	jalr	324(ra) # 80002ecc <panic>

0000000080003d90 <holding>:
    80003d90:	00052783          	lw	a5,0(a0)
    80003d94:	00079663          	bnez	a5,80003da0 <holding+0x10>
    80003d98:	00000513          	li	a0,0
    80003d9c:	00008067          	ret
    80003da0:	fe010113          	addi	sp,sp,-32
    80003da4:	00813823          	sd	s0,16(sp)
    80003da8:	00913423          	sd	s1,8(sp)
    80003dac:	00113c23          	sd	ra,24(sp)
    80003db0:	02010413          	addi	s0,sp,32
    80003db4:	01053483          	ld	s1,16(a0)
    80003db8:	ffffe097          	auipc	ra,0xffffe
    80003dbc:	75c080e7          	jalr	1884(ra) # 80002514 <mycpu>
    80003dc0:	01813083          	ld	ra,24(sp)
    80003dc4:	01013403          	ld	s0,16(sp)
    80003dc8:	40a48533          	sub	a0,s1,a0
    80003dcc:	00153513          	seqz	a0,a0
    80003dd0:	00813483          	ld	s1,8(sp)
    80003dd4:	02010113          	addi	sp,sp,32
    80003dd8:	00008067          	ret

0000000080003ddc <push_off>:
    80003ddc:	fe010113          	addi	sp,sp,-32
    80003de0:	00813823          	sd	s0,16(sp)
    80003de4:	00113c23          	sd	ra,24(sp)
    80003de8:	00913423          	sd	s1,8(sp)
    80003dec:	02010413          	addi	s0,sp,32
    80003df0:	100024f3          	csrr	s1,sstatus
    80003df4:	100027f3          	csrr	a5,sstatus
    80003df8:	ffd7f793          	andi	a5,a5,-3
    80003dfc:	10079073          	csrw	sstatus,a5
    80003e00:	ffffe097          	auipc	ra,0xffffe
    80003e04:	714080e7          	jalr	1812(ra) # 80002514 <mycpu>
    80003e08:	07852783          	lw	a5,120(a0)
    80003e0c:	02078663          	beqz	a5,80003e38 <push_off+0x5c>
    80003e10:	ffffe097          	auipc	ra,0xffffe
    80003e14:	704080e7          	jalr	1796(ra) # 80002514 <mycpu>
    80003e18:	07852783          	lw	a5,120(a0)
    80003e1c:	01813083          	ld	ra,24(sp)
    80003e20:	01013403          	ld	s0,16(sp)
    80003e24:	0017879b          	addiw	a5,a5,1
    80003e28:	06f52c23          	sw	a5,120(a0)
    80003e2c:	00813483          	ld	s1,8(sp)
    80003e30:	02010113          	addi	sp,sp,32
    80003e34:	00008067          	ret
    80003e38:	0014d493          	srli	s1,s1,0x1
    80003e3c:	ffffe097          	auipc	ra,0xffffe
    80003e40:	6d8080e7          	jalr	1752(ra) # 80002514 <mycpu>
    80003e44:	0014f493          	andi	s1,s1,1
    80003e48:	06952e23          	sw	s1,124(a0)
    80003e4c:	fc5ff06f          	j	80003e10 <push_off+0x34>

0000000080003e50 <pop_off>:
    80003e50:	ff010113          	addi	sp,sp,-16
    80003e54:	00813023          	sd	s0,0(sp)
    80003e58:	00113423          	sd	ra,8(sp)
    80003e5c:	01010413          	addi	s0,sp,16
    80003e60:	ffffe097          	auipc	ra,0xffffe
    80003e64:	6b4080e7          	jalr	1716(ra) # 80002514 <mycpu>
    80003e68:	100027f3          	csrr	a5,sstatus
    80003e6c:	0027f793          	andi	a5,a5,2
    80003e70:	04079663          	bnez	a5,80003ebc <pop_off+0x6c>
    80003e74:	07852783          	lw	a5,120(a0)
    80003e78:	02f05a63          	blez	a5,80003eac <pop_off+0x5c>
    80003e7c:	fff7871b          	addiw	a4,a5,-1
    80003e80:	06e52c23          	sw	a4,120(a0)
    80003e84:	00071c63          	bnez	a4,80003e9c <pop_off+0x4c>
    80003e88:	07c52783          	lw	a5,124(a0)
    80003e8c:	00078863          	beqz	a5,80003e9c <pop_off+0x4c>
    80003e90:	100027f3          	csrr	a5,sstatus
    80003e94:	0027e793          	ori	a5,a5,2
    80003e98:	10079073          	csrw	sstatus,a5
    80003e9c:	00813083          	ld	ra,8(sp)
    80003ea0:	00013403          	ld	s0,0(sp)
    80003ea4:	01010113          	addi	sp,sp,16
    80003ea8:	00008067          	ret
    80003eac:	00001517          	auipc	a0,0x1
    80003eb0:	3b450513          	addi	a0,a0,948 # 80005260 <digits+0x48>
    80003eb4:	fffff097          	auipc	ra,0xfffff
    80003eb8:	018080e7          	jalr	24(ra) # 80002ecc <panic>
    80003ebc:	00001517          	auipc	a0,0x1
    80003ec0:	38c50513          	addi	a0,a0,908 # 80005248 <digits+0x30>
    80003ec4:	fffff097          	auipc	ra,0xfffff
    80003ec8:	008080e7          	jalr	8(ra) # 80002ecc <panic>

0000000080003ecc <push_on>:
    80003ecc:	fe010113          	addi	sp,sp,-32
    80003ed0:	00813823          	sd	s0,16(sp)
    80003ed4:	00113c23          	sd	ra,24(sp)
    80003ed8:	00913423          	sd	s1,8(sp)
    80003edc:	02010413          	addi	s0,sp,32
    80003ee0:	100024f3          	csrr	s1,sstatus
    80003ee4:	100027f3          	csrr	a5,sstatus
    80003ee8:	0027e793          	ori	a5,a5,2
    80003eec:	10079073          	csrw	sstatus,a5
    80003ef0:	ffffe097          	auipc	ra,0xffffe
    80003ef4:	624080e7          	jalr	1572(ra) # 80002514 <mycpu>
    80003ef8:	07852783          	lw	a5,120(a0)
    80003efc:	02078663          	beqz	a5,80003f28 <push_on+0x5c>
    80003f00:	ffffe097          	auipc	ra,0xffffe
    80003f04:	614080e7          	jalr	1556(ra) # 80002514 <mycpu>
    80003f08:	07852783          	lw	a5,120(a0)
    80003f0c:	01813083          	ld	ra,24(sp)
    80003f10:	01013403          	ld	s0,16(sp)
    80003f14:	0017879b          	addiw	a5,a5,1
    80003f18:	06f52c23          	sw	a5,120(a0)
    80003f1c:	00813483          	ld	s1,8(sp)
    80003f20:	02010113          	addi	sp,sp,32
    80003f24:	00008067          	ret
    80003f28:	0014d493          	srli	s1,s1,0x1
    80003f2c:	ffffe097          	auipc	ra,0xffffe
    80003f30:	5e8080e7          	jalr	1512(ra) # 80002514 <mycpu>
    80003f34:	0014f493          	andi	s1,s1,1
    80003f38:	06952e23          	sw	s1,124(a0)
    80003f3c:	fc5ff06f          	j	80003f00 <push_on+0x34>

0000000080003f40 <pop_on>:
    80003f40:	ff010113          	addi	sp,sp,-16
    80003f44:	00813023          	sd	s0,0(sp)
    80003f48:	00113423          	sd	ra,8(sp)
    80003f4c:	01010413          	addi	s0,sp,16
    80003f50:	ffffe097          	auipc	ra,0xffffe
    80003f54:	5c4080e7          	jalr	1476(ra) # 80002514 <mycpu>
    80003f58:	100027f3          	csrr	a5,sstatus
    80003f5c:	0027f793          	andi	a5,a5,2
    80003f60:	04078463          	beqz	a5,80003fa8 <pop_on+0x68>
    80003f64:	07852783          	lw	a5,120(a0)
    80003f68:	02f05863          	blez	a5,80003f98 <pop_on+0x58>
    80003f6c:	fff7879b          	addiw	a5,a5,-1
    80003f70:	06f52c23          	sw	a5,120(a0)
    80003f74:	07853783          	ld	a5,120(a0)
    80003f78:	00079863          	bnez	a5,80003f88 <pop_on+0x48>
    80003f7c:	100027f3          	csrr	a5,sstatus
    80003f80:	ffd7f793          	andi	a5,a5,-3
    80003f84:	10079073          	csrw	sstatus,a5
    80003f88:	00813083          	ld	ra,8(sp)
    80003f8c:	00013403          	ld	s0,0(sp)
    80003f90:	01010113          	addi	sp,sp,16
    80003f94:	00008067          	ret
    80003f98:	00001517          	auipc	a0,0x1
    80003f9c:	2f050513          	addi	a0,a0,752 # 80005288 <digits+0x70>
    80003fa0:	fffff097          	auipc	ra,0xfffff
    80003fa4:	f2c080e7          	jalr	-212(ra) # 80002ecc <panic>
    80003fa8:	00001517          	auipc	a0,0x1
    80003fac:	2c050513          	addi	a0,a0,704 # 80005268 <digits+0x50>
    80003fb0:	fffff097          	auipc	ra,0xfffff
    80003fb4:	f1c080e7          	jalr	-228(ra) # 80002ecc <panic>

0000000080003fb8 <__memset>:
    80003fb8:	ff010113          	addi	sp,sp,-16
    80003fbc:	00813423          	sd	s0,8(sp)
    80003fc0:	01010413          	addi	s0,sp,16
    80003fc4:	1a060e63          	beqz	a2,80004180 <__memset+0x1c8>
    80003fc8:	40a007b3          	neg	a5,a0
    80003fcc:	0077f793          	andi	a5,a5,7
    80003fd0:	00778693          	addi	a3,a5,7
    80003fd4:	00b00813          	li	a6,11
    80003fd8:	0ff5f593          	andi	a1,a1,255
    80003fdc:	fff6071b          	addiw	a4,a2,-1
    80003fe0:	1b06e663          	bltu	a3,a6,8000418c <__memset+0x1d4>
    80003fe4:	1cd76463          	bltu	a4,a3,800041ac <__memset+0x1f4>
    80003fe8:	1a078e63          	beqz	a5,800041a4 <__memset+0x1ec>
    80003fec:	00b50023          	sb	a1,0(a0)
    80003ff0:	00100713          	li	a4,1
    80003ff4:	1ae78463          	beq	a5,a4,8000419c <__memset+0x1e4>
    80003ff8:	00b500a3          	sb	a1,1(a0)
    80003ffc:	00200713          	li	a4,2
    80004000:	1ae78a63          	beq	a5,a4,800041b4 <__memset+0x1fc>
    80004004:	00b50123          	sb	a1,2(a0)
    80004008:	00300713          	li	a4,3
    8000400c:	18e78463          	beq	a5,a4,80004194 <__memset+0x1dc>
    80004010:	00b501a3          	sb	a1,3(a0)
    80004014:	00400713          	li	a4,4
    80004018:	1ae78263          	beq	a5,a4,800041bc <__memset+0x204>
    8000401c:	00b50223          	sb	a1,4(a0)
    80004020:	00500713          	li	a4,5
    80004024:	1ae78063          	beq	a5,a4,800041c4 <__memset+0x20c>
    80004028:	00b502a3          	sb	a1,5(a0)
    8000402c:	00700713          	li	a4,7
    80004030:	18e79e63          	bne	a5,a4,800041cc <__memset+0x214>
    80004034:	00b50323          	sb	a1,6(a0)
    80004038:	00700e93          	li	t4,7
    8000403c:	00859713          	slli	a4,a1,0x8
    80004040:	00e5e733          	or	a4,a1,a4
    80004044:	01059e13          	slli	t3,a1,0x10
    80004048:	01c76e33          	or	t3,a4,t3
    8000404c:	01859313          	slli	t1,a1,0x18
    80004050:	006e6333          	or	t1,t3,t1
    80004054:	02059893          	slli	a7,a1,0x20
    80004058:	40f60e3b          	subw	t3,a2,a5
    8000405c:	011368b3          	or	a7,t1,a7
    80004060:	02859813          	slli	a6,a1,0x28
    80004064:	0108e833          	or	a6,a7,a6
    80004068:	03059693          	slli	a3,a1,0x30
    8000406c:	003e589b          	srliw	a7,t3,0x3
    80004070:	00d866b3          	or	a3,a6,a3
    80004074:	03859713          	slli	a4,a1,0x38
    80004078:	00389813          	slli	a6,a7,0x3
    8000407c:	00f507b3          	add	a5,a0,a5
    80004080:	00e6e733          	or	a4,a3,a4
    80004084:	000e089b          	sext.w	a7,t3
    80004088:	00f806b3          	add	a3,a6,a5
    8000408c:	00e7b023          	sd	a4,0(a5)
    80004090:	00878793          	addi	a5,a5,8
    80004094:	fed79ce3          	bne	a5,a3,8000408c <__memset+0xd4>
    80004098:	ff8e7793          	andi	a5,t3,-8
    8000409c:	0007871b          	sext.w	a4,a5
    800040a0:	01d787bb          	addw	a5,a5,t4
    800040a4:	0ce88e63          	beq	a7,a4,80004180 <__memset+0x1c8>
    800040a8:	00f50733          	add	a4,a0,a5
    800040ac:	00b70023          	sb	a1,0(a4)
    800040b0:	0017871b          	addiw	a4,a5,1
    800040b4:	0cc77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    800040b8:	00e50733          	add	a4,a0,a4
    800040bc:	00b70023          	sb	a1,0(a4)
    800040c0:	0027871b          	addiw	a4,a5,2
    800040c4:	0ac77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    800040c8:	00e50733          	add	a4,a0,a4
    800040cc:	00b70023          	sb	a1,0(a4)
    800040d0:	0037871b          	addiw	a4,a5,3
    800040d4:	0ac77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    800040d8:	00e50733          	add	a4,a0,a4
    800040dc:	00b70023          	sb	a1,0(a4)
    800040e0:	0047871b          	addiw	a4,a5,4
    800040e4:	08c77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    800040e8:	00e50733          	add	a4,a0,a4
    800040ec:	00b70023          	sb	a1,0(a4)
    800040f0:	0057871b          	addiw	a4,a5,5
    800040f4:	08c77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    800040f8:	00e50733          	add	a4,a0,a4
    800040fc:	00b70023          	sb	a1,0(a4)
    80004100:	0067871b          	addiw	a4,a5,6
    80004104:	06c77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004108:	00e50733          	add	a4,a0,a4
    8000410c:	00b70023          	sb	a1,0(a4)
    80004110:	0077871b          	addiw	a4,a5,7
    80004114:	06c77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004118:	00e50733          	add	a4,a0,a4
    8000411c:	00b70023          	sb	a1,0(a4)
    80004120:	0087871b          	addiw	a4,a5,8
    80004124:	04c77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00b70023          	sb	a1,0(a4)
    80004130:	0097871b          	addiw	a4,a5,9
    80004134:	04c77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004138:	00e50733          	add	a4,a0,a4
    8000413c:	00b70023          	sb	a1,0(a4)
    80004140:	00a7871b          	addiw	a4,a5,10
    80004144:	02c77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004148:	00e50733          	add	a4,a0,a4
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	00b7871b          	addiw	a4,a5,11
    80004154:	02c77663          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004158:	00e50733          	add	a4,a0,a4
    8000415c:	00b70023          	sb	a1,0(a4)
    80004160:	00c7871b          	addiw	a4,a5,12
    80004164:	00c77e63          	bgeu	a4,a2,80004180 <__memset+0x1c8>
    80004168:	00e50733          	add	a4,a0,a4
    8000416c:	00b70023          	sb	a1,0(a4)
    80004170:	00d7879b          	addiw	a5,a5,13
    80004174:	00c7f663          	bgeu	a5,a2,80004180 <__memset+0x1c8>
    80004178:	00f507b3          	add	a5,a0,a5
    8000417c:	00b78023          	sb	a1,0(a5)
    80004180:	00813403          	ld	s0,8(sp)
    80004184:	01010113          	addi	sp,sp,16
    80004188:	00008067          	ret
    8000418c:	00b00693          	li	a3,11
    80004190:	e55ff06f          	j	80003fe4 <__memset+0x2c>
    80004194:	00300e93          	li	t4,3
    80004198:	ea5ff06f          	j	8000403c <__memset+0x84>
    8000419c:	00100e93          	li	t4,1
    800041a0:	e9dff06f          	j	8000403c <__memset+0x84>
    800041a4:	00000e93          	li	t4,0
    800041a8:	e95ff06f          	j	8000403c <__memset+0x84>
    800041ac:	00000793          	li	a5,0
    800041b0:	ef9ff06f          	j	800040a8 <__memset+0xf0>
    800041b4:	00200e93          	li	t4,2
    800041b8:	e85ff06f          	j	8000403c <__memset+0x84>
    800041bc:	00400e93          	li	t4,4
    800041c0:	e7dff06f          	j	8000403c <__memset+0x84>
    800041c4:	00500e93          	li	t4,5
    800041c8:	e75ff06f          	j	8000403c <__memset+0x84>
    800041cc:	00600e93          	li	t4,6
    800041d0:	e6dff06f          	j	8000403c <__memset+0x84>

00000000800041d4 <__memmove>:
    800041d4:	ff010113          	addi	sp,sp,-16
    800041d8:	00813423          	sd	s0,8(sp)
    800041dc:	01010413          	addi	s0,sp,16
    800041e0:	0e060863          	beqz	a2,800042d0 <__memmove+0xfc>
    800041e4:	fff6069b          	addiw	a3,a2,-1
    800041e8:	0006881b          	sext.w	a6,a3
    800041ec:	0ea5e863          	bltu	a1,a0,800042dc <__memmove+0x108>
    800041f0:	00758713          	addi	a4,a1,7
    800041f4:	00a5e7b3          	or	a5,a1,a0
    800041f8:	40a70733          	sub	a4,a4,a0
    800041fc:	0077f793          	andi	a5,a5,7
    80004200:	00f73713          	sltiu	a4,a4,15
    80004204:	00174713          	xori	a4,a4,1
    80004208:	0017b793          	seqz	a5,a5
    8000420c:	00e7f7b3          	and	a5,a5,a4
    80004210:	10078863          	beqz	a5,80004320 <__memmove+0x14c>
    80004214:	00900793          	li	a5,9
    80004218:	1107f463          	bgeu	a5,a6,80004320 <__memmove+0x14c>
    8000421c:	0036581b          	srliw	a6,a2,0x3
    80004220:	fff8081b          	addiw	a6,a6,-1
    80004224:	02081813          	slli	a6,a6,0x20
    80004228:	01d85893          	srli	a7,a6,0x1d
    8000422c:	00858813          	addi	a6,a1,8
    80004230:	00058793          	mv	a5,a1
    80004234:	00050713          	mv	a4,a0
    80004238:	01088833          	add	a6,a7,a6
    8000423c:	0007b883          	ld	a7,0(a5)
    80004240:	00878793          	addi	a5,a5,8
    80004244:	00870713          	addi	a4,a4,8
    80004248:	ff173c23          	sd	a7,-8(a4)
    8000424c:	ff0798e3          	bne	a5,a6,8000423c <__memmove+0x68>
    80004250:	ff867713          	andi	a4,a2,-8
    80004254:	02071793          	slli	a5,a4,0x20
    80004258:	0207d793          	srli	a5,a5,0x20
    8000425c:	00f585b3          	add	a1,a1,a5
    80004260:	40e686bb          	subw	a3,a3,a4
    80004264:	00f507b3          	add	a5,a0,a5
    80004268:	06e60463          	beq	a2,a4,800042d0 <__memmove+0xfc>
    8000426c:	0005c703          	lbu	a4,0(a1)
    80004270:	00e78023          	sb	a4,0(a5)
    80004274:	04068e63          	beqz	a3,800042d0 <__memmove+0xfc>
    80004278:	0015c603          	lbu	a2,1(a1)
    8000427c:	00100713          	li	a4,1
    80004280:	00c780a3          	sb	a2,1(a5)
    80004284:	04e68663          	beq	a3,a4,800042d0 <__memmove+0xfc>
    80004288:	0025c603          	lbu	a2,2(a1)
    8000428c:	00200713          	li	a4,2
    80004290:	00c78123          	sb	a2,2(a5)
    80004294:	02e68e63          	beq	a3,a4,800042d0 <__memmove+0xfc>
    80004298:	0035c603          	lbu	a2,3(a1)
    8000429c:	00300713          	li	a4,3
    800042a0:	00c781a3          	sb	a2,3(a5)
    800042a4:	02e68663          	beq	a3,a4,800042d0 <__memmove+0xfc>
    800042a8:	0045c603          	lbu	a2,4(a1)
    800042ac:	00400713          	li	a4,4
    800042b0:	00c78223          	sb	a2,4(a5)
    800042b4:	00e68e63          	beq	a3,a4,800042d0 <__memmove+0xfc>
    800042b8:	0055c603          	lbu	a2,5(a1)
    800042bc:	00500713          	li	a4,5
    800042c0:	00c782a3          	sb	a2,5(a5)
    800042c4:	00e68663          	beq	a3,a4,800042d0 <__memmove+0xfc>
    800042c8:	0065c703          	lbu	a4,6(a1)
    800042cc:	00e78323          	sb	a4,6(a5)
    800042d0:	00813403          	ld	s0,8(sp)
    800042d4:	01010113          	addi	sp,sp,16
    800042d8:	00008067          	ret
    800042dc:	02061713          	slli	a4,a2,0x20
    800042e0:	02075713          	srli	a4,a4,0x20
    800042e4:	00e587b3          	add	a5,a1,a4
    800042e8:	f0f574e3          	bgeu	a0,a5,800041f0 <__memmove+0x1c>
    800042ec:	02069613          	slli	a2,a3,0x20
    800042f0:	02065613          	srli	a2,a2,0x20
    800042f4:	fff64613          	not	a2,a2
    800042f8:	00e50733          	add	a4,a0,a4
    800042fc:	00c78633          	add	a2,a5,a2
    80004300:	fff7c683          	lbu	a3,-1(a5)
    80004304:	fff78793          	addi	a5,a5,-1
    80004308:	fff70713          	addi	a4,a4,-1
    8000430c:	00d70023          	sb	a3,0(a4)
    80004310:	fec798e3          	bne	a5,a2,80004300 <__memmove+0x12c>
    80004314:	00813403          	ld	s0,8(sp)
    80004318:	01010113          	addi	sp,sp,16
    8000431c:	00008067          	ret
    80004320:	02069713          	slli	a4,a3,0x20
    80004324:	02075713          	srli	a4,a4,0x20
    80004328:	00170713          	addi	a4,a4,1
    8000432c:	00e50733          	add	a4,a0,a4
    80004330:	00050793          	mv	a5,a0
    80004334:	0005c683          	lbu	a3,0(a1)
    80004338:	00178793          	addi	a5,a5,1
    8000433c:	00158593          	addi	a1,a1,1
    80004340:	fed78fa3          	sb	a3,-1(a5)
    80004344:	fee798e3          	bne	a5,a4,80004334 <__memmove+0x160>
    80004348:	f89ff06f          	j	800042d0 <__memmove+0xfc>

000000008000434c <__putc>:
    8000434c:	fe010113          	addi	sp,sp,-32
    80004350:	00813823          	sd	s0,16(sp)
    80004354:	00113c23          	sd	ra,24(sp)
    80004358:	02010413          	addi	s0,sp,32
    8000435c:	00050793          	mv	a5,a0
    80004360:	fef40593          	addi	a1,s0,-17
    80004364:	00100613          	li	a2,1
    80004368:	00000513          	li	a0,0
    8000436c:	fef407a3          	sb	a5,-17(s0)
    80004370:	fffff097          	auipc	ra,0xfffff
    80004374:	b3c080e7          	jalr	-1220(ra) # 80002eac <console_write>
    80004378:	01813083          	ld	ra,24(sp)
    8000437c:	01013403          	ld	s0,16(sp)
    80004380:	02010113          	addi	sp,sp,32
    80004384:	00008067          	ret

0000000080004388 <__getc>:
    80004388:	fe010113          	addi	sp,sp,-32
    8000438c:	00813823          	sd	s0,16(sp)
    80004390:	00113c23          	sd	ra,24(sp)
    80004394:	02010413          	addi	s0,sp,32
    80004398:	fe840593          	addi	a1,s0,-24
    8000439c:	00100613          	li	a2,1
    800043a0:	00000513          	li	a0,0
    800043a4:	fffff097          	auipc	ra,0xfffff
    800043a8:	ae8080e7          	jalr	-1304(ra) # 80002e8c <console_read>
    800043ac:	fe844503          	lbu	a0,-24(s0)
    800043b0:	01813083          	ld	ra,24(sp)
    800043b4:	01013403          	ld	s0,16(sp)
    800043b8:	02010113          	addi	sp,sp,32
    800043bc:	00008067          	ret

00000000800043c0 <console_handler>:
    800043c0:	fe010113          	addi	sp,sp,-32
    800043c4:	00813823          	sd	s0,16(sp)
    800043c8:	00113c23          	sd	ra,24(sp)
    800043cc:	00913423          	sd	s1,8(sp)
    800043d0:	02010413          	addi	s0,sp,32
    800043d4:	14202773          	csrr	a4,scause
    800043d8:	100027f3          	csrr	a5,sstatus
    800043dc:	0027f793          	andi	a5,a5,2
    800043e0:	06079e63          	bnez	a5,8000445c <console_handler+0x9c>
    800043e4:	00074c63          	bltz	a4,800043fc <console_handler+0x3c>
    800043e8:	01813083          	ld	ra,24(sp)
    800043ec:	01013403          	ld	s0,16(sp)
    800043f0:	00813483          	ld	s1,8(sp)
    800043f4:	02010113          	addi	sp,sp,32
    800043f8:	00008067          	ret
    800043fc:	0ff77713          	andi	a4,a4,255
    80004400:	00900793          	li	a5,9
    80004404:	fef712e3          	bne	a4,a5,800043e8 <console_handler+0x28>
    80004408:	ffffe097          	auipc	ra,0xffffe
    8000440c:	6dc080e7          	jalr	1756(ra) # 80002ae4 <plic_claim>
    80004410:	00a00793          	li	a5,10
    80004414:	00050493          	mv	s1,a0
    80004418:	02f50c63          	beq	a0,a5,80004450 <console_handler+0x90>
    8000441c:	fc0506e3          	beqz	a0,800043e8 <console_handler+0x28>
    80004420:	00050593          	mv	a1,a0
    80004424:	00001517          	auipc	a0,0x1
    80004428:	d6c50513          	addi	a0,a0,-660 # 80005190 <_ZZ12printIntegermE6digits+0xe0>
    8000442c:	fffff097          	auipc	ra,0xfffff
    80004430:	afc080e7          	jalr	-1284(ra) # 80002f28 <__printf>
    80004434:	01013403          	ld	s0,16(sp)
    80004438:	01813083          	ld	ra,24(sp)
    8000443c:	00048513          	mv	a0,s1
    80004440:	00813483          	ld	s1,8(sp)
    80004444:	02010113          	addi	sp,sp,32
    80004448:	ffffe317          	auipc	t1,0xffffe
    8000444c:	6d430067          	jr	1748(t1) # 80002b1c <plic_complete>
    80004450:	fffff097          	auipc	ra,0xfffff
    80004454:	3e0080e7          	jalr	992(ra) # 80003830 <uartintr>
    80004458:	fddff06f          	j	80004434 <console_handler+0x74>
    8000445c:	00001517          	auipc	a0,0x1
    80004460:	e3450513          	addi	a0,a0,-460 # 80005290 <digits+0x78>
    80004464:	fffff097          	auipc	ra,0xfffff
    80004468:	a68080e7          	jalr	-1432(ra) # 80002ecc <panic>
	...
