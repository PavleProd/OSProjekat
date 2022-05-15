
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	43013103          	ld	sp,1072(sp) # 80004430 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	654010ef          	jal	ra,80001670 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt>:
.extern interruptHandler
.align 4
.global interrupt
interrupt:
    call interruptHandler
    80001000:	04c000ef          	jal	ra,8000104c <interruptHandler>
    csrc sip, 0x02 // brisemo zahtev za prekidom
    80001004:	14417073          	csrci	sip,2

    // uvecavanje sepc za 4
    csrr s6, sepc
    80001008:	14102b73          	csrr	s6,sepc
    addi s6, s6, 4
    8000100c:	004b0b13          	addi	s6,s6,4
    csrw sepc, s6
    80001010:	141b1073          	csrw	sepc,s6

    80001014:	10200073          	sret
	...

0000000080001020 <_Z13callInterruptv>:
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001020:	ff010113          	addi	sp,sp,-16
    80001024:	00813423          	sd	s0,8(sp)
    80001028:	01010413          	addi	s0,sp,16
    void* res;
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    8000102c:	00003797          	auipc	a5,0x3
    80001030:	4147b783          	ld	a5,1044(a5) # 80004440 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001034:	10579073          	csrw	stvec,a5
    asm volatile("ecall");
    80001038:	00000073          	ecall

    asm volatile("mv %0, a0" : "=r" (res));
    8000103c:	00050513          	mv	a0,a0
    return res;
}
    80001040:	00813403          	ld	s0,8(sp)
    80001044:	01010113          	addi	sp,sp,16
    80001048:	00008067          	ret

000000008000104c <interruptHandler>:

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    8000104c:	14202773          	csrr	a4,scause
    if(scause == 9) { // sistemski poziv iz korisnickog rezima 8
    80001050:	00900793          	li	a5,9
    80001054:	06f71063          	bne	a4,a5,800010b4 <interruptHandler+0x68>
extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001058:	ff010113          	addi	sp,sp,-16
    8000105c:	00113423          	sd	ra,8(sp)
    80001060:	00813023          	sd	s0,0(sp)
    80001064:	01010413          	addi	s0,sp,16
        uint64 code;
        asm volatile("mv %0, a0" : "=r" (code));
    80001068:	00050793          	mv	a5,a0
        switch(code) {
    8000106c:	00100713          	li	a4,1
    80001070:	02e78063          	beq	a5,a4,80001090 <interruptHandler+0x44>
    80001074:	00200713          	li	a4,2
    80001078:	02e78663          	beq	a5,a4,800010a4 <interruptHandler+0x58>
    8000107c:	00000513          	li	a0,0
                return nullptr;
        }
    }

    return nullptr;
}
    80001080:	00813083          	ld	ra,8(sp)
    80001084:	00013403          	ld	s0,0(sp)
    80001088:	01010113          	addi	sp,sp,16
    8000108c:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (size));
    80001090:	00058513          	mv	a0,a1
                return MemoryAllocator::mem_alloc(size);
    80001094:	00651513          	slli	a0,a0,0x6
    80001098:	00000097          	auipc	ra,0x0
    8000109c:	1e8080e7          	jalr	488(ra) # 80001280 <_ZN15MemoryAllocator9mem_allocEm>
    800010a0:	fe1ff06f          	j	80001080 <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    800010a4:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    800010a8:	00000097          	auipc	ra,0x0
    800010ac:	348080e7          	jalr	840(ra) # 800013f0 <_ZN15MemoryAllocator8mem_freeEPv>
    800010b0:	fd1ff06f          	j	80001080 <interruptHandler+0x34>
    return nullptr;
    800010b4:	00000513          	li	a0,0
}
    800010b8:	00008067          	ret

00000000800010bc <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    800010bc:	ff010113          	addi	sp,sp,-16
    800010c0:	00113423          	sd	ra,8(sp)
    800010c4:	00813023          	sd	s0,0(sp)
    800010c8:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800010cc:	00655793          	srli	a5,a0,0x6
    800010d0:	03f57513          	andi	a0,a0,63
    800010d4:	00a03533          	snez	a0,a0
    800010d8:	00a78533          	add	a0,a5,a0
    uint64 code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800010dc:	00100793          	li	a5,1
    800010e0:	00078513          	mv	a0,a5
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800010e4:	00050593          	mv	a1,a0

    return (void*)callInterrupt();
    800010e8:	00000097          	auipc	ra,0x0
    800010ec:	f38080e7          	jalr	-200(ra) # 80001020 <_Z13callInterruptv>
}
    800010f0:	00813083          	ld	ra,8(sp)
    800010f4:	00013403          	ld	s0,0(sp)
    800010f8:	01010113          	addi	sp,sp,16
    800010fc:	00008067          	ret

0000000080001100 <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    80001100:	ff010113          	addi	sp,sp,-16
    80001104:	00113423          	sd	ra,8(sp)
    80001108:	00813023          	sd	s0,0(sp)
    8000110c:	01010413          	addi	s0,sp,16
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001110:	00200793          	li	a5,2
    80001114:	00078513          	mv	a0,a5

    return (uint64)(callInterrupt());
    80001118:	00000097          	auipc	ra,0x0
    8000111c:	f08080e7          	jalr	-248(ra) # 80001020 <_Z13callInterruptv>
}
    80001120:	0005051b          	sext.w	a0,a0
    80001124:	00813083          	ld	ra,8(sp)
    80001128:	00013403          	ld	s0,0(sp)
    8000112c:	01010113          	addi	sp,sp,16
    80001130:	00008067          	ret

0000000080001134 <_Z12checkNullptrPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    80001134:	00050e63          	beqz	a0,80001150 <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80001138:	00003717          	auipc	a4,0x3
    8000113c:	35870713          	addi	a4,a4,856 # 80004490 <_ZZ12checkNullptrPvE1x>
    80001140:	00072783          	lw	a5,0(a4)
    80001144:	0017879b          	addiw	a5,a5,1
    80001148:	00f72023          	sw	a5,0(a4)
    8000114c:	00008067          	ret
void checkNullptr(void* p) {
    80001150:	ff010113          	addi	sp,sp,-16
    80001154:	00113423          	sd	ra,8(sp)
    80001158:	00813023          	sd	s0,0(sp)
    8000115c:	01010413          	addi	s0,sp,16
        __putc('?');
    80001160:	03f00513          	li	a0,63
    80001164:	00002097          	auipc	ra,0x2
    80001168:	5c8080e7          	jalr	1480(ra) # 8000372c <__putc>
        __putc('0' + x);
    8000116c:	00003517          	auipc	a0,0x3
    80001170:	32452503          	lw	a0,804(a0) # 80004490 <_ZZ12checkNullptrPvE1x>
    80001174:	0305051b          	addiw	a0,a0,48
    80001178:	0ff57513          	andi	a0,a0,255
    8000117c:	00002097          	auipc	ra,0x2
    80001180:	5b0080e7          	jalr	1456(ra) # 8000372c <__putc>
    x++;
    80001184:	00003717          	auipc	a4,0x3
    80001188:	30c70713          	addi	a4,a4,780 # 80004490 <_ZZ12checkNullptrPvE1x>
    8000118c:	00072783          	lw	a5,0(a4)
    80001190:	0017879b          	addiw	a5,a5,1
    80001194:	00f72023          	sw	a5,0(a4)
}
    80001198:	00813083          	ld	ra,8(sp)
    8000119c:	00013403          	ld	s0,0(sp)
    800011a0:	01010113          	addi	sp,sp,16
    800011a4:	00008067          	ret

00000000800011a8 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    800011a8:	00051e63          	bnez	a0,800011c4 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    800011ac:	00003717          	auipc	a4,0x3
    800011b0:	2e470713          	addi	a4,a4,740 # 80004490 <_ZZ12checkNullptrPvE1x>
    800011b4:	00472783          	lw	a5,4(a4)
    800011b8:	0017879b          	addiw	a5,a5,1
    800011bc:	00f72223          	sw	a5,4(a4)
    800011c0:	00008067          	ret
void checkStatus(int status) {
    800011c4:	ff010113          	addi	sp,sp,-16
    800011c8:	00113423          	sd	ra,8(sp)
    800011cc:	00813023          	sd	s0,0(sp)
    800011d0:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    800011d4:	00003517          	auipc	a0,0x3
    800011d8:	2c052503          	lw	a0,704(a0) # 80004494 <_ZZ11checkStatusiE1y>
    800011dc:	0305051b          	addiw	a0,a0,48
    800011e0:	0ff57513          	andi	a0,a0,255
    800011e4:	00002097          	auipc	ra,0x2
    800011e8:	548080e7          	jalr	1352(ra) # 8000372c <__putc>
        __putc('?');
    800011ec:	03f00513          	li	a0,63
    800011f0:	00002097          	auipc	ra,0x2
    800011f4:	53c080e7          	jalr	1340(ra) # 8000372c <__putc>
    y++;
    800011f8:	00003717          	auipc	a4,0x3
    800011fc:	29870713          	addi	a4,a4,664 # 80004490 <_ZZ12checkNullptrPvE1x>
    80001200:	00472783          	lw	a5,4(a4)
    80001204:	0017879b          	addiw	a5,a5,1
    80001208:	00f72223          	sw	a5,4(a4)
}
    8000120c:	00813083          	ld	ra,8(sp)
    80001210:	00013403          	ld	s0,0(sp)
    80001214:	01010113          	addi	sp,sp,16
    80001218:	00008067          	ret

000000008000121c <main>:

int main() {
    8000121c:	fe010113          	addi	sp,sp,-32
    80001220:	00113c23          	sd	ra,24(sp)
    80001224:	00813823          	sd	s0,16(sp)
    80001228:	00913423          	sd	s1,8(sp)
    8000122c:	02010413          	addi	s0,sp,32
    int* par = (int*)mem_alloc(2*sizeof(int));
    80001230:	00800513          	li	a0,8
    80001234:	00000097          	auipc	ra,0x0
    80001238:	e88080e7          	jalr	-376(ra) # 800010bc <_Z9mem_allocm>
    8000123c:	00050493          	mv	s1,a0
    par[0] = 1;
    80001240:	00100793          	li	a5,1
    80001244:	00f52023          	sw	a5,0(a0)
    par[1] = 2;
    80001248:	00200793          	li	a5,2
    8000124c:	00f52223          	sw	a5,4(a0)

    printInteger(par[0]);
    80001250:	00100513          	li	a0,1
    80001254:	00000097          	auipc	ra,0x0
    80001258:	38c080e7          	jalr	908(ra) # 800015e0 <_Z12printIntegerm>
    printInteger(par[1]);
    8000125c:	0044a503          	lw	a0,4(s1)
    80001260:	00000097          	auipc	ra,0x0
    80001264:	380080e7          	jalr	896(ra) # 800015e0 <_Z12printIntegerm>
    return 0;
    80001268:	00000513          	li	a0,0
    8000126c:	01813083          	ld	ra,24(sp)
    80001270:	01013403          	ld	s0,16(sp)
    80001274:	00813483          	ld	s1,8(sp)
    80001278:	02010113          	addi	sp,sp,32
    8000127c:	00008067          	ret

0000000080001280 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000128c:	00003797          	auipc	a5,0x3
    80001290:	20c7b783          	ld	a5,524(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001294:	02078c63          	beqz	a5,800012cc <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001298:	00003717          	auipc	a4,0x3
    8000129c:	1a073703          	ld	a4,416(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    800012a0:	00073703          	ld	a4,0(a4)
    800012a4:	14e78263          	beq	a5,a4,800013e8 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    800012a8:	00850613          	addi	a2,a0,8
    800012ac:	00665813          	srli	a6,a2,0x6
    800012b0:	03f67793          	andi	a5,a2,63
    800012b4:	00f037b3          	snez	a5,a5
    800012b8:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800012bc:	00003517          	auipc	a0,0x3
    800012c0:	1dc53503          	ld	a0,476(a0) # 80004498 <_ZN15MemoryAllocator4headE>
    800012c4:	00000593          	li	a1,0
    800012c8:	0a80006f          	j	80001370 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800012cc:	00003697          	auipc	a3,0x3
    800012d0:	15c6b683          	ld	a3,348(a3) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    800012d4:	0006b783          	ld	a5,0(a3)
    800012d8:	00003717          	auipc	a4,0x3
    800012dc:	1cf73023          	sd	a5,448(a4) # 80004498 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800012e0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800012e4:	00003717          	auipc	a4,0x3
    800012e8:	15473703          	ld	a4,340(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    800012ec:	00073703          	ld	a4,0(a4)
    800012f0:	0006b683          	ld	a3,0(a3)
    800012f4:	40d70733          	sub	a4,a4,a3
    800012f8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800012fc:	0007b823          	sd	zero,16(a5)
    80001300:	fa9ff06f          	j	800012a8 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    80001304:	00058e63          	beqz	a1,80001320 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    80001308:	0105b703          	ld	a4,16(a1)
    8000130c:	04070a63          	beqz	a4,80001360 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001310:	01073703          	ld	a4,16(a4)
    80001314:	00e5b823          	sd	a4,16(a1)
                allocatedSize = curr->size;
    80001318:	00078813          	mv	a6,a5
    8000131c:	0b80006f          	j	800013d4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001320:	01053703          	ld	a4,16(a0)
    80001324:	00070a63          	beqz	a4,80001338 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001328:	00003617          	auipc	a2,0x3
    8000132c:	16e63823          	sd	a4,368(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001330:	00078813          	mv	a6,a5
    80001334:	0a00006f          	j	800013d4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001338:	00003717          	auipc	a4,0x3
    8000133c:	10073703          	ld	a4,256(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001340:	00073703          	ld	a4,0(a4)
    80001344:	00003617          	auipc	a2,0x3
    80001348:	14e63a23          	sd	a4,340(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000134c:	00078813          	mv	a6,a5
    80001350:	0840006f          	j	800013d4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001354:	00003797          	auipc	a5,0x3
    80001358:	14e7b223          	sd	a4,324(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    8000135c:	0780006f          	j	800013d4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80001360:	00078813          	mv	a6,a5
    80001364:	0700006f          	j	800013d4 <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001368:	00050593          	mv	a1,a0
        curr = curr->next;
    8000136c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001370:	06050663          	beqz	a0,800013dc <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    80001374:	00853783          	ld	a5,8(a0)
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001378:	0067d693          	srli	a3,a5,0x6
    8000137c:	03f7f713          	andi	a4,a5,63
    80001380:	00e03733          	snez	a4,a4
    80001384:	00e68733          	add	a4,a3,a4
        void* startOfAllocatedSpace = curr->baseAddr;
    80001388:	00053683          	ld	a3,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000138c:	fcc7eee3          	bltu	a5,a2,80001368 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001390:	fd076ce3          	bltu	a4,a6,80001368 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001394:	f6e808e3          	beq	a6,a4,80001304 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001398:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000139c:	01068733          	add	a4,a3,a6
                size_t newSize = curr->size - allocatedSize;
    800013a0:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    800013a4:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    800013a8:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    800013ac:	01053783          	ld	a5,16(a0)
    800013b0:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800013b4:	fa0580e3          	beqz	a1,80001354 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    800013b8:	0105b783          	ld	a5,16(a1)
    800013bc:	00078663          	beqz	a5,800013c8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    800013c0:	0107b783          	ld	a5,16(a5)
    800013c4:	00f5b823          	sd	a5,16(a1)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800013c8:	0105b783          	ld	a5,16(a1)
    800013cc:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800013d0:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800013d4:	0106b023          	sd	a6,0(a3)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800013d8:	00868513          	addi	a0,a3,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800013dc:	00813403          	ld	s0,8(sp)
    800013e0:	01010113          	addi	sp,sp,16
    800013e4:	00008067          	ret
        return nullptr;
    800013e8:	00000513          	li	a0,0
    800013ec:	ff1ff06f          	j	800013dc <_ZN15MemoryAllocator9mem_allocEm+0x15c>

00000000800013f0 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800013f0:	ff010113          	addi	sp,sp,-16
    800013f4:	00813423          	sd	s0,8(sp)
    800013f8:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800013fc:	16050063          	beqz	a0,8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    80001400:	ff850713          	addi	a4,a0,-8
    80001404:	00003797          	auipc	a5,0x3
    80001408:	0247b783          	ld	a5,36(a5) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000140c:	0007b783          	ld	a5,0(a5)
    80001410:	14f76a63          	bltu	a4,a5,80001564 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001414:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001418:	fff58693          	addi	a3,a1,-1
    8000141c:	00d706b3          	add	a3,a4,a3
    80001420:	00003617          	auipc	a2,0x3
    80001424:	01863603          	ld	a2,24(a2) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001428:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000142c:	14c6f063          	bgeu	a3,a2,8000156c <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001430:	14070263          	beqz	a4,80001574 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001434:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001438:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000143c:	14079063          	bnez	a5,8000157c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001440:	03f00793          	li	a5,63
    80001444:	14b7f063          	bgeu	a5,a1,80001584 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001448:	00003797          	auipc	a5,0x3
    8000144c:	0507b783          	ld	a5,80(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001450:	02f60063          	beq	a2,a5,80001470 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001454:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001458:	02078a63          	beqz	a5,8000148c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    8000145c:	0007b683          	ld	a3,0(a5)
    80001460:	02e6f663          	bgeu	a3,a4,8000148c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001464:	00078613          	mv	a2,a5
        curr = curr->next;
    80001468:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000146c:	fedff06f          	j	80001458 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001470:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001474:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001478:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000147c:	00003797          	auipc	a5,0x3
    80001480:	00e7be23          	sd	a4,28(a5) # 80004498 <_ZN15MemoryAllocator4headE>
        return 0;
    80001484:	00000513          	li	a0,0
    80001488:	0480006f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    8000148c:	04060863          	beqz	a2,800014dc <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001490:	00063683          	ld	a3,0(a2)
    80001494:	00863803          	ld	a6,8(a2)
    80001498:	010686b3          	add	a3,a3,a6
    8000149c:	08e68a63          	beq	a3,a4,80001530 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    800014a0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800014a4:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    800014a8:	01063683          	ld	a3,16(a2)
    800014ac:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800014b0:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800014b4:	0e078063          	beqz	a5,80001594 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    800014b8:	0007b583          	ld	a1,0(a5)
    800014bc:	00073683          	ld	a3,0(a4)
    800014c0:	00873603          	ld	a2,8(a4)
    800014c4:	00c686b3          	add	a3,a3,a2
    800014c8:	06d58c63          	beq	a1,a3,80001540 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800014cc:	00000513          	li	a0,0
}
    800014d0:	00813403          	ld	s0,8(sp)
    800014d4:	01010113          	addi	sp,sp,16
    800014d8:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800014dc:	0a078863          	beqz	a5,8000158c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800014e0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800014e4:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800014e8:	00003797          	auipc	a5,0x3
    800014ec:	fb07b783          	ld	a5,-80(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    800014f0:	0007b603          	ld	a2,0(a5)
    800014f4:	00b706b3          	add	a3,a4,a1
    800014f8:	00d60c63          	beq	a2,a3,80001510 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800014fc:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    80001500:	00003797          	auipc	a5,0x3
    80001504:	f8e7bc23          	sd	a4,-104(a5) # 80004498 <_ZN15MemoryAllocator4headE>
            return 0;
    80001508:	00000513          	li	a0,0
    8000150c:	fc5ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001510:	0087b783          	ld	a5,8(a5)
    80001514:	00b785b3          	add	a1,a5,a1
    80001518:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000151c:	00003797          	auipc	a5,0x3
    80001520:	f7c7b783          	ld	a5,-132(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001524:	0107b783          	ld	a5,16(a5)
    80001528:	00f53423          	sd	a5,8(a0)
    8000152c:	fd5ff06f          	j	80001500 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001530:	00b805b3          	add	a1,a6,a1
    80001534:	00b63423          	sd	a1,8(a2)
    80001538:	00060713          	mv	a4,a2
    8000153c:	f79ff06f          	j	800014b4 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001540:	0087b683          	ld	a3,8(a5)
    80001544:	00d60633          	add	a2,a2,a3
    80001548:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000154c:	0107b783          	ld	a5,16(a5)
    80001550:	00f73823          	sd	a5,16(a4)
    return 0;
    80001554:	00000513          	li	a0,0
    80001558:	f79ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    8000155c:	fff00513          	li	a0,-1
    80001560:	f71ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001564:	fff00513          	li	a0,-1
    80001568:	f69ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    8000156c:	fff00513          	li	a0,-1
    80001570:	f61ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001574:	fff00513          	li	a0,-1
    80001578:	f59ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000157c:	fff00513          	li	a0,-1
    80001580:	f51ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001584:	fff00513          	li	a0,-1
    80001588:	f49ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    8000158c:	fff00513          	li	a0,-1
    80001590:	f41ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001594:	00000513          	li	a0,0
    80001598:	f39ff06f          	j	800014d0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000159c <_Z11printStringPKc>:
#include "../h/print.h"
#include "../lib/console.h"

void printString(char const *string)
{
    8000159c:	fe010113          	addi	sp,sp,-32
    800015a0:	00113c23          	sd	ra,24(sp)
    800015a4:	00813823          	sd	s0,16(sp)
    800015a8:	00913423          	sd	s1,8(sp)
    800015ac:	02010413          	addi	s0,sp,32
    800015b0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800015b4:	0004c503          	lbu	a0,0(s1)
    800015b8:	00050a63          	beqz	a0,800015cc <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    800015bc:	00002097          	auipc	ra,0x2
    800015c0:	170080e7          	jalr	368(ra) # 8000372c <__putc>
        string++;
    800015c4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800015c8:	fedff06f          	j	800015b4 <_Z11printStringPKc+0x18>
    }
}
    800015cc:	01813083          	ld	ra,24(sp)
    800015d0:	01013403          	ld	s0,16(sp)
    800015d4:	00813483          	ld	s1,8(sp)
    800015d8:	02010113          	addi	sp,sp,32
    800015dc:	00008067          	ret

00000000800015e0 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    800015e0:	fd010113          	addi	sp,sp,-48
    800015e4:	02113423          	sd	ra,40(sp)
    800015e8:	02813023          	sd	s0,32(sp)
    800015ec:	00913c23          	sd	s1,24(sp)
    800015f0:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    800015f4:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    800015f8:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    800015fc:	00a00613          	li	a2,10
    80001600:	02c5773b          	remuw	a4,a0,a2
    80001604:	02071693          	slli	a3,a4,0x20
    80001608:	0206d693          	srli	a3,a3,0x20
    8000160c:	00003717          	auipc	a4,0x3
    80001610:	a1470713          	addi	a4,a4,-1516 # 80004020 <_ZZ12printIntegermE6digits>
    80001614:	00d70733          	add	a4,a4,a3
    80001618:	00074703          	lbu	a4,0(a4)
    8000161c:	fe040693          	addi	a3,s0,-32
    80001620:	009687b3          	add	a5,a3,s1
    80001624:	0014849b          	addiw	s1,s1,1
    80001628:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    8000162c:	0005071b          	sext.w	a4,a0
    80001630:	02c5553b          	divuw	a0,a0,a2
    80001634:	00900793          	li	a5,9
    80001638:	fce7e2e3          	bltu	a5,a4,800015fc <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    8000163c:	fff4849b          	addiw	s1,s1,-1
    80001640:	0004ce63          	bltz	s1,8000165c <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    80001644:	fe040793          	addi	a5,s0,-32
    80001648:	009787b3          	add	a5,a5,s1
    8000164c:	ff07c503          	lbu	a0,-16(a5)
    80001650:	00002097          	auipc	ra,0x2
    80001654:	0dc080e7          	jalr	220(ra) # 8000372c <__putc>
    80001658:	fe5ff06f          	j	8000163c <_Z12printIntegerm+0x5c>
    8000165c:	02813083          	ld	ra,40(sp)
    80001660:	02013403          	ld	s0,32(sp)
    80001664:	01813483          	ld	s1,24(sp)
    80001668:	03010113          	addi	sp,sp,48
    8000166c:	00008067          	ret

0000000080001670 <start>:
    80001670:	ff010113          	addi	sp,sp,-16
    80001674:	00813423          	sd	s0,8(sp)
    80001678:	01010413          	addi	s0,sp,16
    8000167c:	300027f3          	csrr	a5,mstatus
    80001680:	ffffe737          	lui	a4,0xffffe
    80001684:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff910f>
    80001688:	00e7f7b3          	and	a5,a5,a4
    8000168c:	00001737          	lui	a4,0x1
    80001690:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001694:	00e7e7b3          	or	a5,a5,a4
    80001698:	30079073          	csrw	mstatus,a5
    8000169c:	00000797          	auipc	a5,0x0
    800016a0:	16078793          	addi	a5,a5,352 # 800017fc <system_main>
    800016a4:	34179073          	csrw	mepc,a5
    800016a8:	00000793          	li	a5,0
    800016ac:	18079073          	csrw	satp,a5
    800016b0:	000107b7          	lui	a5,0x10
    800016b4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800016b8:	30279073          	csrw	medeleg,a5
    800016bc:	30379073          	csrw	mideleg,a5
    800016c0:	104027f3          	csrr	a5,sie
    800016c4:	2227e793          	ori	a5,a5,546
    800016c8:	10479073          	csrw	sie,a5
    800016cc:	fff00793          	li	a5,-1
    800016d0:	00a7d793          	srli	a5,a5,0xa
    800016d4:	3b079073          	csrw	pmpaddr0,a5
    800016d8:	00f00793          	li	a5,15
    800016dc:	3a079073          	csrw	pmpcfg0,a5
    800016e0:	f14027f3          	csrr	a5,mhartid
    800016e4:	0200c737          	lui	a4,0x200c
    800016e8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800016ec:	0007869b          	sext.w	a3,a5
    800016f0:	00269713          	slli	a4,a3,0x2
    800016f4:	000f4637          	lui	a2,0xf4
    800016f8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800016fc:	00d70733          	add	a4,a4,a3
    80001700:	0037979b          	slliw	a5,a5,0x3
    80001704:	020046b7          	lui	a3,0x2004
    80001708:	00d787b3          	add	a5,a5,a3
    8000170c:	00c585b3          	add	a1,a1,a2
    80001710:	00371693          	slli	a3,a4,0x3
    80001714:	00003717          	auipc	a4,0x3
    80001718:	d8c70713          	addi	a4,a4,-628 # 800044a0 <timer_scratch>
    8000171c:	00b7b023          	sd	a1,0(a5)
    80001720:	00d70733          	add	a4,a4,a3
    80001724:	00f73c23          	sd	a5,24(a4)
    80001728:	02c73023          	sd	a2,32(a4)
    8000172c:	34071073          	csrw	mscratch,a4
    80001730:	00000797          	auipc	a5,0x0
    80001734:	6e078793          	addi	a5,a5,1760 # 80001e10 <timervec>
    80001738:	30579073          	csrw	mtvec,a5
    8000173c:	300027f3          	csrr	a5,mstatus
    80001740:	0087e793          	ori	a5,a5,8
    80001744:	30079073          	csrw	mstatus,a5
    80001748:	304027f3          	csrr	a5,mie
    8000174c:	0807e793          	ori	a5,a5,128
    80001750:	30479073          	csrw	mie,a5
    80001754:	f14027f3          	csrr	a5,mhartid
    80001758:	0007879b          	sext.w	a5,a5
    8000175c:	00078213          	mv	tp,a5
    80001760:	30200073          	mret
    80001764:	00813403          	ld	s0,8(sp)
    80001768:	01010113          	addi	sp,sp,16
    8000176c:	00008067          	ret

0000000080001770 <timerinit>:
    80001770:	ff010113          	addi	sp,sp,-16
    80001774:	00813423          	sd	s0,8(sp)
    80001778:	01010413          	addi	s0,sp,16
    8000177c:	f14027f3          	csrr	a5,mhartid
    80001780:	0200c737          	lui	a4,0x200c
    80001784:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001788:	0007869b          	sext.w	a3,a5
    8000178c:	00269713          	slli	a4,a3,0x2
    80001790:	000f4637          	lui	a2,0xf4
    80001794:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001798:	00d70733          	add	a4,a4,a3
    8000179c:	0037979b          	slliw	a5,a5,0x3
    800017a0:	020046b7          	lui	a3,0x2004
    800017a4:	00d787b3          	add	a5,a5,a3
    800017a8:	00c585b3          	add	a1,a1,a2
    800017ac:	00371693          	slli	a3,a4,0x3
    800017b0:	00003717          	auipc	a4,0x3
    800017b4:	cf070713          	addi	a4,a4,-784 # 800044a0 <timer_scratch>
    800017b8:	00b7b023          	sd	a1,0(a5)
    800017bc:	00d70733          	add	a4,a4,a3
    800017c0:	00f73c23          	sd	a5,24(a4)
    800017c4:	02c73023          	sd	a2,32(a4)
    800017c8:	34071073          	csrw	mscratch,a4
    800017cc:	00000797          	auipc	a5,0x0
    800017d0:	64478793          	addi	a5,a5,1604 # 80001e10 <timervec>
    800017d4:	30579073          	csrw	mtvec,a5
    800017d8:	300027f3          	csrr	a5,mstatus
    800017dc:	0087e793          	ori	a5,a5,8
    800017e0:	30079073          	csrw	mstatus,a5
    800017e4:	304027f3          	csrr	a5,mie
    800017e8:	0807e793          	ori	a5,a5,128
    800017ec:	30479073          	csrw	mie,a5
    800017f0:	00813403          	ld	s0,8(sp)
    800017f4:	01010113          	addi	sp,sp,16
    800017f8:	00008067          	ret

00000000800017fc <system_main>:
    800017fc:	fe010113          	addi	sp,sp,-32
    80001800:	00813823          	sd	s0,16(sp)
    80001804:	00913423          	sd	s1,8(sp)
    80001808:	00113c23          	sd	ra,24(sp)
    8000180c:	02010413          	addi	s0,sp,32
    80001810:	00000097          	auipc	ra,0x0
    80001814:	0c4080e7          	jalr	196(ra) # 800018d4 <cpuid>
    80001818:	00003497          	auipc	s1,0x3
    8000181c:	c4848493          	addi	s1,s1,-952 # 80004460 <started>
    80001820:	02050263          	beqz	a0,80001844 <system_main+0x48>
    80001824:	0004a783          	lw	a5,0(s1)
    80001828:	0007879b          	sext.w	a5,a5
    8000182c:	fe078ce3          	beqz	a5,80001824 <system_main+0x28>
    80001830:	0ff0000f          	fence
    80001834:	00003517          	auipc	a0,0x3
    80001838:	82c50513          	addi	a0,a0,-2004 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    8000183c:	00001097          	auipc	ra,0x1
    80001840:	a70080e7          	jalr	-1424(ra) # 800022ac <panic>
    80001844:	00001097          	auipc	ra,0x1
    80001848:	9c4080e7          	jalr	-1596(ra) # 80002208 <consoleinit>
    8000184c:	00001097          	auipc	ra,0x1
    80001850:	150080e7          	jalr	336(ra) # 8000299c <printfinit>
    80001854:	00003517          	auipc	a0,0x3
    80001858:	8ec50513          	addi	a0,a0,-1812 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    8000185c:	00001097          	auipc	ra,0x1
    80001860:	aac080e7          	jalr	-1364(ra) # 80002308 <__printf>
    80001864:	00002517          	auipc	a0,0x2
    80001868:	7cc50513          	addi	a0,a0,1996 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    8000186c:	00001097          	auipc	ra,0x1
    80001870:	a9c080e7          	jalr	-1380(ra) # 80002308 <__printf>
    80001874:	00003517          	auipc	a0,0x3
    80001878:	8cc50513          	addi	a0,a0,-1844 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    8000187c:	00001097          	auipc	ra,0x1
    80001880:	a8c080e7          	jalr	-1396(ra) # 80002308 <__printf>
    80001884:	00001097          	auipc	ra,0x1
    80001888:	4a4080e7          	jalr	1188(ra) # 80002d28 <kinit>
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	148080e7          	jalr	328(ra) # 800019d4 <trapinit>
    80001894:	00000097          	auipc	ra,0x0
    80001898:	16c080e7          	jalr	364(ra) # 80001a00 <trapinithart>
    8000189c:	00000097          	auipc	ra,0x0
    800018a0:	5b4080e7          	jalr	1460(ra) # 80001e50 <plicinit>
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	5d4080e7          	jalr	1492(ra) # 80001e78 <plicinithart>
    800018ac:	00000097          	auipc	ra,0x0
    800018b0:	078080e7          	jalr	120(ra) # 80001924 <userinit>
    800018b4:	0ff0000f          	fence
    800018b8:	00100793          	li	a5,1
    800018bc:	00002517          	auipc	a0,0x2
    800018c0:	78c50513          	addi	a0,a0,1932 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    800018c4:	00f4a023          	sw	a5,0(s1)
    800018c8:	00001097          	auipc	ra,0x1
    800018cc:	a40080e7          	jalr	-1472(ra) # 80002308 <__printf>
    800018d0:	0000006f          	j	800018d0 <system_main+0xd4>

00000000800018d4 <cpuid>:
    800018d4:	ff010113          	addi	sp,sp,-16
    800018d8:	00813423          	sd	s0,8(sp)
    800018dc:	01010413          	addi	s0,sp,16
    800018e0:	00020513          	mv	a0,tp
    800018e4:	00813403          	ld	s0,8(sp)
    800018e8:	0005051b          	sext.w	a0,a0
    800018ec:	01010113          	addi	sp,sp,16
    800018f0:	00008067          	ret

00000000800018f4 <mycpu>:
    800018f4:	ff010113          	addi	sp,sp,-16
    800018f8:	00813423          	sd	s0,8(sp)
    800018fc:	01010413          	addi	s0,sp,16
    80001900:	00020793          	mv	a5,tp
    80001904:	00813403          	ld	s0,8(sp)
    80001908:	0007879b          	sext.w	a5,a5
    8000190c:	00779793          	slli	a5,a5,0x7
    80001910:	00004517          	auipc	a0,0x4
    80001914:	bc050513          	addi	a0,a0,-1088 # 800054d0 <cpus>
    80001918:	00f50533          	add	a0,a0,a5
    8000191c:	01010113          	addi	sp,sp,16
    80001920:	00008067          	ret

0000000080001924 <userinit>:
    80001924:	ff010113          	addi	sp,sp,-16
    80001928:	00813423          	sd	s0,8(sp)
    8000192c:	01010413          	addi	s0,sp,16
    80001930:	00813403          	ld	s0,8(sp)
    80001934:	01010113          	addi	sp,sp,16
    80001938:	00000317          	auipc	t1,0x0
    8000193c:	8e430067          	jr	-1820(t1) # 8000121c <main>

0000000080001940 <either_copyout>:
    80001940:	ff010113          	addi	sp,sp,-16
    80001944:	00813023          	sd	s0,0(sp)
    80001948:	00113423          	sd	ra,8(sp)
    8000194c:	01010413          	addi	s0,sp,16
    80001950:	02051663          	bnez	a0,8000197c <either_copyout+0x3c>
    80001954:	00058513          	mv	a0,a1
    80001958:	00060593          	mv	a1,a2
    8000195c:	0006861b          	sext.w	a2,a3
    80001960:	00002097          	auipc	ra,0x2
    80001964:	c54080e7          	jalr	-940(ra) # 800035b4 <__memmove>
    80001968:	00813083          	ld	ra,8(sp)
    8000196c:	00013403          	ld	s0,0(sp)
    80001970:	00000513          	li	a0,0
    80001974:	01010113          	addi	sp,sp,16
    80001978:	00008067          	ret
    8000197c:	00002517          	auipc	a0,0x2
    80001980:	70c50513          	addi	a0,a0,1804 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001984:	00001097          	auipc	ra,0x1
    80001988:	928080e7          	jalr	-1752(ra) # 800022ac <panic>

000000008000198c <either_copyin>:
    8000198c:	ff010113          	addi	sp,sp,-16
    80001990:	00813023          	sd	s0,0(sp)
    80001994:	00113423          	sd	ra,8(sp)
    80001998:	01010413          	addi	s0,sp,16
    8000199c:	02059463          	bnez	a1,800019c4 <either_copyin+0x38>
    800019a0:	00060593          	mv	a1,a2
    800019a4:	0006861b          	sext.w	a2,a3
    800019a8:	00002097          	auipc	ra,0x2
    800019ac:	c0c080e7          	jalr	-1012(ra) # 800035b4 <__memmove>
    800019b0:	00813083          	ld	ra,8(sp)
    800019b4:	00013403          	ld	s0,0(sp)
    800019b8:	00000513          	li	a0,0
    800019bc:	01010113          	addi	sp,sp,16
    800019c0:	00008067          	ret
    800019c4:	00002517          	auipc	a0,0x2
    800019c8:	6ec50513          	addi	a0,a0,1772 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    800019cc:	00001097          	auipc	ra,0x1
    800019d0:	8e0080e7          	jalr	-1824(ra) # 800022ac <panic>

00000000800019d4 <trapinit>:
    800019d4:	ff010113          	addi	sp,sp,-16
    800019d8:	00813423          	sd	s0,8(sp)
    800019dc:	01010413          	addi	s0,sp,16
    800019e0:	00813403          	ld	s0,8(sp)
    800019e4:	00002597          	auipc	a1,0x2
    800019e8:	6f458593          	addi	a1,a1,1780 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    800019ec:	00004517          	auipc	a0,0x4
    800019f0:	b6450513          	addi	a0,a0,-1180 # 80005550 <tickslock>
    800019f4:	01010113          	addi	sp,sp,16
    800019f8:	00001317          	auipc	t1,0x1
    800019fc:	5c030067          	jr	1472(t1) # 80002fb8 <initlock>

0000000080001a00 <trapinithart>:
    80001a00:	ff010113          	addi	sp,sp,-16
    80001a04:	00813423          	sd	s0,8(sp)
    80001a08:	01010413          	addi	s0,sp,16
    80001a0c:	00000797          	auipc	a5,0x0
    80001a10:	2f478793          	addi	a5,a5,756 # 80001d00 <kernelvec>
    80001a14:	10579073          	csrw	stvec,a5
    80001a18:	00813403          	ld	s0,8(sp)
    80001a1c:	01010113          	addi	sp,sp,16
    80001a20:	00008067          	ret

0000000080001a24 <usertrap>:
    80001a24:	ff010113          	addi	sp,sp,-16
    80001a28:	00813423          	sd	s0,8(sp)
    80001a2c:	01010413          	addi	s0,sp,16
    80001a30:	00813403          	ld	s0,8(sp)
    80001a34:	01010113          	addi	sp,sp,16
    80001a38:	00008067          	ret

0000000080001a3c <usertrapret>:
    80001a3c:	ff010113          	addi	sp,sp,-16
    80001a40:	00813423          	sd	s0,8(sp)
    80001a44:	01010413          	addi	s0,sp,16
    80001a48:	00813403          	ld	s0,8(sp)
    80001a4c:	01010113          	addi	sp,sp,16
    80001a50:	00008067          	ret

0000000080001a54 <kerneltrap>:
    80001a54:	fe010113          	addi	sp,sp,-32
    80001a58:	00813823          	sd	s0,16(sp)
    80001a5c:	00113c23          	sd	ra,24(sp)
    80001a60:	00913423          	sd	s1,8(sp)
    80001a64:	02010413          	addi	s0,sp,32
    80001a68:	142025f3          	csrr	a1,scause
    80001a6c:	100027f3          	csrr	a5,sstatus
    80001a70:	0027f793          	andi	a5,a5,2
    80001a74:	10079c63          	bnez	a5,80001b8c <kerneltrap+0x138>
    80001a78:	142027f3          	csrr	a5,scause
    80001a7c:	0207ce63          	bltz	a5,80001ab8 <kerneltrap+0x64>
    80001a80:	00002517          	auipc	a0,0x2
    80001a84:	6a050513          	addi	a0,a0,1696 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001a88:	00001097          	auipc	ra,0x1
    80001a8c:	880080e7          	jalr	-1920(ra) # 80002308 <__printf>
    80001a90:	141025f3          	csrr	a1,sepc
    80001a94:	14302673          	csrr	a2,stval
    80001a98:	00002517          	auipc	a0,0x2
    80001a9c:	69850513          	addi	a0,a0,1688 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001aa0:	00001097          	auipc	ra,0x1
    80001aa4:	868080e7          	jalr	-1944(ra) # 80002308 <__printf>
    80001aa8:	00002517          	auipc	a0,0x2
    80001aac:	6a050513          	addi	a0,a0,1696 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001ab0:	00000097          	auipc	ra,0x0
    80001ab4:	7fc080e7          	jalr	2044(ra) # 800022ac <panic>
    80001ab8:	0ff7f713          	andi	a4,a5,255
    80001abc:	00900693          	li	a3,9
    80001ac0:	04d70063          	beq	a4,a3,80001b00 <kerneltrap+0xac>
    80001ac4:	fff00713          	li	a4,-1
    80001ac8:	03f71713          	slli	a4,a4,0x3f
    80001acc:	00170713          	addi	a4,a4,1
    80001ad0:	fae798e3          	bne	a5,a4,80001a80 <kerneltrap+0x2c>
    80001ad4:	00000097          	auipc	ra,0x0
    80001ad8:	e00080e7          	jalr	-512(ra) # 800018d4 <cpuid>
    80001adc:	06050663          	beqz	a0,80001b48 <kerneltrap+0xf4>
    80001ae0:	144027f3          	csrr	a5,sip
    80001ae4:	ffd7f793          	andi	a5,a5,-3
    80001ae8:	14479073          	csrw	sip,a5
    80001aec:	01813083          	ld	ra,24(sp)
    80001af0:	01013403          	ld	s0,16(sp)
    80001af4:	00813483          	ld	s1,8(sp)
    80001af8:	02010113          	addi	sp,sp,32
    80001afc:	00008067          	ret
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	3c4080e7          	jalr	964(ra) # 80001ec4 <plic_claim>
    80001b08:	00a00793          	li	a5,10
    80001b0c:	00050493          	mv	s1,a0
    80001b10:	06f50863          	beq	a0,a5,80001b80 <kerneltrap+0x12c>
    80001b14:	fc050ce3          	beqz	a0,80001aec <kerneltrap+0x98>
    80001b18:	00050593          	mv	a1,a0
    80001b1c:	00002517          	auipc	a0,0x2
    80001b20:	5e450513          	addi	a0,a0,1508 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001b24:	00000097          	auipc	ra,0x0
    80001b28:	7e4080e7          	jalr	2020(ra) # 80002308 <__printf>
    80001b2c:	01013403          	ld	s0,16(sp)
    80001b30:	01813083          	ld	ra,24(sp)
    80001b34:	00048513          	mv	a0,s1
    80001b38:	00813483          	ld	s1,8(sp)
    80001b3c:	02010113          	addi	sp,sp,32
    80001b40:	00000317          	auipc	t1,0x0
    80001b44:	3bc30067          	jr	956(t1) # 80001efc <plic_complete>
    80001b48:	00004517          	auipc	a0,0x4
    80001b4c:	a0850513          	addi	a0,a0,-1528 # 80005550 <tickslock>
    80001b50:	00001097          	auipc	ra,0x1
    80001b54:	48c080e7          	jalr	1164(ra) # 80002fdc <acquire>
    80001b58:	00003717          	auipc	a4,0x3
    80001b5c:	90c70713          	addi	a4,a4,-1780 # 80004464 <ticks>
    80001b60:	00072783          	lw	a5,0(a4)
    80001b64:	00004517          	auipc	a0,0x4
    80001b68:	9ec50513          	addi	a0,a0,-1556 # 80005550 <tickslock>
    80001b6c:	0017879b          	addiw	a5,a5,1
    80001b70:	00f72023          	sw	a5,0(a4)
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	534080e7          	jalr	1332(ra) # 800030a8 <release>
    80001b7c:	f65ff06f          	j	80001ae0 <kerneltrap+0x8c>
    80001b80:	00001097          	auipc	ra,0x1
    80001b84:	090080e7          	jalr	144(ra) # 80002c10 <uartintr>
    80001b88:	fa5ff06f          	j	80001b2c <kerneltrap+0xd8>
    80001b8c:	00002517          	auipc	a0,0x2
    80001b90:	55450513          	addi	a0,a0,1364 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	718080e7          	jalr	1816(ra) # 800022ac <panic>

0000000080001b9c <clockintr>:
    80001b9c:	fe010113          	addi	sp,sp,-32
    80001ba0:	00813823          	sd	s0,16(sp)
    80001ba4:	00913423          	sd	s1,8(sp)
    80001ba8:	00113c23          	sd	ra,24(sp)
    80001bac:	02010413          	addi	s0,sp,32
    80001bb0:	00004497          	auipc	s1,0x4
    80001bb4:	9a048493          	addi	s1,s1,-1632 # 80005550 <tickslock>
    80001bb8:	00048513          	mv	a0,s1
    80001bbc:	00001097          	auipc	ra,0x1
    80001bc0:	420080e7          	jalr	1056(ra) # 80002fdc <acquire>
    80001bc4:	00003717          	auipc	a4,0x3
    80001bc8:	8a070713          	addi	a4,a4,-1888 # 80004464 <ticks>
    80001bcc:	00072783          	lw	a5,0(a4)
    80001bd0:	01013403          	ld	s0,16(sp)
    80001bd4:	01813083          	ld	ra,24(sp)
    80001bd8:	00048513          	mv	a0,s1
    80001bdc:	0017879b          	addiw	a5,a5,1
    80001be0:	00813483          	ld	s1,8(sp)
    80001be4:	00f72023          	sw	a5,0(a4)
    80001be8:	02010113          	addi	sp,sp,32
    80001bec:	00001317          	auipc	t1,0x1
    80001bf0:	4bc30067          	jr	1212(t1) # 800030a8 <release>

0000000080001bf4 <devintr>:
    80001bf4:	142027f3          	csrr	a5,scause
    80001bf8:	00000513          	li	a0,0
    80001bfc:	0007c463          	bltz	a5,80001c04 <devintr+0x10>
    80001c00:	00008067          	ret
    80001c04:	fe010113          	addi	sp,sp,-32
    80001c08:	00813823          	sd	s0,16(sp)
    80001c0c:	00113c23          	sd	ra,24(sp)
    80001c10:	00913423          	sd	s1,8(sp)
    80001c14:	02010413          	addi	s0,sp,32
    80001c18:	0ff7f713          	andi	a4,a5,255
    80001c1c:	00900693          	li	a3,9
    80001c20:	04d70c63          	beq	a4,a3,80001c78 <devintr+0x84>
    80001c24:	fff00713          	li	a4,-1
    80001c28:	03f71713          	slli	a4,a4,0x3f
    80001c2c:	00170713          	addi	a4,a4,1
    80001c30:	00e78c63          	beq	a5,a4,80001c48 <devintr+0x54>
    80001c34:	01813083          	ld	ra,24(sp)
    80001c38:	01013403          	ld	s0,16(sp)
    80001c3c:	00813483          	ld	s1,8(sp)
    80001c40:	02010113          	addi	sp,sp,32
    80001c44:	00008067          	ret
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	c8c080e7          	jalr	-884(ra) # 800018d4 <cpuid>
    80001c50:	06050663          	beqz	a0,80001cbc <devintr+0xc8>
    80001c54:	144027f3          	csrr	a5,sip
    80001c58:	ffd7f793          	andi	a5,a5,-3
    80001c5c:	14479073          	csrw	sip,a5
    80001c60:	01813083          	ld	ra,24(sp)
    80001c64:	01013403          	ld	s0,16(sp)
    80001c68:	00813483          	ld	s1,8(sp)
    80001c6c:	00200513          	li	a0,2
    80001c70:	02010113          	addi	sp,sp,32
    80001c74:	00008067          	ret
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	24c080e7          	jalr	588(ra) # 80001ec4 <plic_claim>
    80001c80:	00a00793          	li	a5,10
    80001c84:	00050493          	mv	s1,a0
    80001c88:	06f50663          	beq	a0,a5,80001cf4 <devintr+0x100>
    80001c8c:	00100513          	li	a0,1
    80001c90:	fa0482e3          	beqz	s1,80001c34 <devintr+0x40>
    80001c94:	00048593          	mv	a1,s1
    80001c98:	00002517          	auipc	a0,0x2
    80001c9c:	46850513          	addi	a0,a0,1128 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001ca0:	00000097          	auipc	ra,0x0
    80001ca4:	668080e7          	jalr	1640(ra) # 80002308 <__printf>
    80001ca8:	00048513          	mv	a0,s1
    80001cac:	00000097          	auipc	ra,0x0
    80001cb0:	250080e7          	jalr	592(ra) # 80001efc <plic_complete>
    80001cb4:	00100513          	li	a0,1
    80001cb8:	f7dff06f          	j	80001c34 <devintr+0x40>
    80001cbc:	00004517          	auipc	a0,0x4
    80001cc0:	89450513          	addi	a0,a0,-1900 # 80005550 <tickslock>
    80001cc4:	00001097          	auipc	ra,0x1
    80001cc8:	318080e7          	jalr	792(ra) # 80002fdc <acquire>
    80001ccc:	00002717          	auipc	a4,0x2
    80001cd0:	79870713          	addi	a4,a4,1944 # 80004464 <ticks>
    80001cd4:	00072783          	lw	a5,0(a4)
    80001cd8:	00004517          	auipc	a0,0x4
    80001cdc:	87850513          	addi	a0,a0,-1928 # 80005550 <tickslock>
    80001ce0:	0017879b          	addiw	a5,a5,1
    80001ce4:	00f72023          	sw	a5,0(a4)
    80001ce8:	00001097          	auipc	ra,0x1
    80001cec:	3c0080e7          	jalr	960(ra) # 800030a8 <release>
    80001cf0:	f65ff06f          	j	80001c54 <devintr+0x60>
    80001cf4:	00001097          	auipc	ra,0x1
    80001cf8:	f1c080e7          	jalr	-228(ra) # 80002c10 <uartintr>
    80001cfc:	fadff06f          	j	80001ca8 <devintr+0xb4>

0000000080001d00 <kernelvec>:
    80001d00:	f0010113          	addi	sp,sp,-256
    80001d04:	00113023          	sd	ra,0(sp)
    80001d08:	00213423          	sd	sp,8(sp)
    80001d0c:	00313823          	sd	gp,16(sp)
    80001d10:	00413c23          	sd	tp,24(sp)
    80001d14:	02513023          	sd	t0,32(sp)
    80001d18:	02613423          	sd	t1,40(sp)
    80001d1c:	02713823          	sd	t2,48(sp)
    80001d20:	02813c23          	sd	s0,56(sp)
    80001d24:	04913023          	sd	s1,64(sp)
    80001d28:	04a13423          	sd	a0,72(sp)
    80001d2c:	04b13823          	sd	a1,80(sp)
    80001d30:	04c13c23          	sd	a2,88(sp)
    80001d34:	06d13023          	sd	a3,96(sp)
    80001d38:	06e13423          	sd	a4,104(sp)
    80001d3c:	06f13823          	sd	a5,112(sp)
    80001d40:	07013c23          	sd	a6,120(sp)
    80001d44:	09113023          	sd	a7,128(sp)
    80001d48:	09213423          	sd	s2,136(sp)
    80001d4c:	09313823          	sd	s3,144(sp)
    80001d50:	09413c23          	sd	s4,152(sp)
    80001d54:	0b513023          	sd	s5,160(sp)
    80001d58:	0b613423          	sd	s6,168(sp)
    80001d5c:	0b713823          	sd	s7,176(sp)
    80001d60:	0b813c23          	sd	s8,184(sp)
    80001d64:	0d913023          	sd	s9,192(sp)
    80001d68:	0da13423          	sd	s10,200(sp)
    80001d6c:	0db13823          	sd	s11,208(sp)
    80001d70:	0dc13c23          	sd	t3,216(sp)
    80001d74:	0fd13023          	sd	t4,224(sp)
    80001d78:	0fe13423          	sd	t5,232(sp)
    80001d7c:	0ff13823          	sd	t6,240(sp)
    80001d80:	cd5ff0ef          	jal	ra,80001a54 <kerneltrap>
    80001d84:	00013083          	ld	ra,0(sp)
    80001d88:	00813103          	ld	sp,8(sp)
    80001d8c:	01013183          	ld	gp,16(sp)
    80001d90:	02013283          	ld	t0,32(sp)
    80001d94:	02813303          	ld	t1,40(sp)
    80001d98:	03013383          	ld	t2,48(sp)
    80001d9c:	03813403          	ld	s0,56(sp)
    80001da0:	04013483          	ld	s1,64(sp)
    80001da4:	04813503          	ld	a0,72(sp)
    80001da8:	05013583          	ld	a1,80(sp)
    80001dac:	05813603          	ld	a2,88(sp)
    80001db0:	06013683          	ld	a3,96(sp)
    80001db4:	06813703          	ld	a4,104(sp)
    80001db8:	07013783          	ld	a5,112(sp)
    80001dbc:	07813803          	ld	a6,120(sp)
    80001dc0:	08013883          	ld	a7,128(sp)
    80001dc4:	08813903          	ld	s2,136(sp)
    80001dc8:	09013983          	ld	s3,144(sp)
    80001dcc:	09813a03          	ld	s4,152(sp)
    80001dd0:	0a013a83          	ld	s5,160(sp)
    80001dd4:	0a813b03          	ld	s6,168(sp)
    80001dd8:	0b013b83          	ld	s7,176(sp)
    80001ddc:	0b813c03          	ld	s8,184(sp)
    80001de0:	0c013c83          	ld	s9,192(sp)
    80001de4:	0c813d03          	ld	s10,200(sp)
    80001de8:	0d013d83          	ld	s11,208(sp)
    80001dec:	0d813e03          	ld	t3,216(sp)
    80001df0:	0e013e83          	ld	t4,224(sp)
    80001df4:	0e813f03          	ld	t5,232(sp)
    80001df8:	0f013f83          	ld	t6,240(sp)
    80001dfc:	10010113          	addi	sp,sp,256
    80001e00:	10200073          	sret
    80001e04:	00000013          	nop
    80001e08:	00000013          	nop
    80001e0c:	00000013          	nop

0000000080001e10 <timervec>:
    80001e10:	34051573          	csrrw	a0,mscratch,a0
    80001e14:	00b53023          	sd	a1,0(a0)
    80001e18:	00c53423          	sd	a2,8(a0)
    80001e1c:	00d53823          	sd	a3,16(a0)
    80001e20:	01853583          	ld	a1,24(a0)
    80001e24:	02053603          	ld	a2,32(a0)
    80001e28:	0005b683          	ld	a3,0(a1)
    80001e2c:	00c686b3          	add	a3,a3,a2
    80001e30:	00d5b023          	sd	a3,0(a1)
    80001e34:	00200593          	li	a1,2
    80001e38:	14459073          	csrw	sip,a1
    80001e3c:	01053683          	ld	a3,16(a0)
    80001e40:	00853603          	ld	a2,8(a0)
    80001e44:	00053583          	ld	a1,0(a0)
    80001e48:	34051573          	csrrw	a0,mscratch,a0
    80001e4c:	30200073          	mret

0000000080001e50 <plicinit>:
    80001e50:	ff010113          	addi	sp,sp,-16
    80001e54:	00813423          	sd	s0,8(sp)
    80001e58:	01010413          	addi	s0,sp,16
    80001e5c:	00813403          	ld	s0,8(sp)
    80001e60:	0c0007b7          	lui	a5,0xc000
    80001e64:	00100713          	li	a4,1
    80001e68:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001e6c:	00e7a223          	sw	a4,4(a5)
    80001e70:	01010113          	addi	sp,sp,16
    80001e74:	00008067          	ret

0000000080001e78 <plicinithart>:
    80001e78:	ff010113          	addi	sp,sp,-16
    80001e7c:	00813023          	sd	s0,0(sp)
    80001e80:	00113423          	sd	ra,8(sp)
    80001e84:	01010413          	addi	s0,sp,16
    80001e88:	00000097          	auipc	ra,0x0
    80001e8c:	a4c080e7          	jalr	-1460(ra) # 800018d4 <cpuid>
    80001e90:	0085171b          	slliw	a4,a0,0x8
    80001e94:	0c0027b7          	lui	a5,0xc002
    80001e98:	00e787b3          	add	a5,a5,a4
    80001e9c:	40200713          	li	a4,1026
    80001ea0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001ea4:	00813083          	ld	ra,8(sp)
    80001ea8:	00013403          	ld	s0,0(sp)
    80001eac:	00d5151b          	slliw	a0,a0,0xd
    80001eb0:	0c2017b7          	lui	a5,0xc201
    80001eb4:	00a78533          	add	a0,a5,a0
    80001eb8:	00052023          	sw	zero,0(a0)
    80001ebc:	01010113          	addi	sp,sp,16
    80001ec0:	00008067          	ret

0000000080001ec4 <plic_claim>:
    80001ec4:	ff010113          	addi	sp,sp,-16
    80001ec8:	00813023          	sd	s0,0(sp)
    80001ecc:	00113423          	sd	ra,8(sp)
    80001ed0:	01010413          	addi	s0,sp,16
    80001ed4:	00000097          	auipc	ra,0x0
    80001ed8:	a00080e7          	jalr	-1536(ra) # 800018d4 <cpuid>
    80001edc:	00813083          	ld	ra,8(sp)
    80001ee0:	00013403          	ld	s0,0(sp)
    80001ee4:	00d5151b          	slliw	a0,a0,0xd
    80001ee8:	0c2017b7          	lui	a5,0xc201
    80001eec:	00a78533          	add	a0,a5,a0
    80001ef0:	00452503          	lw	a0,4(a0)
    80001ef4:	01010113          	addi	sp,sp,16
    80001ef8:	00008067          	ret

0000000080001efc <plic_complete>:
    80001efc:	fe010113          	addi	sp,sp,-32
    80001f00:	00813823          	sd	s0,16(sp)
    80001f04:	00913423          	sd	s1,8(sp)
    80001f08:	00113c23          	sd	ra,24(sp)
    80001f0c:	02010413          	addi	s0,sp,32
    80001f10:	00050493          	mv	s1,a0
    80001f14:	00000097          	auipc	ra,0x0
    80001f18:	9c0080e7          	jalr	-1600(ra) # 800018d4 <cpuid>
    80001f1c:	01813083          	ld	ra,24(sp)
    80001f20:	01013403          	ld	s0,16(sp)
    80001f24:	00d5179b          	slliw	a5,a0,0xd
    80001f28:	0c201737          	lui	a4,0xc201
    80001f2c:	00f707b3          	add	a5,a4,a5
    80001f30:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001f34:	00813483          	ld	s1,8(sp)
    80001f38:	02010113          	addi	sp,sp,32
    80001f3c:	00008067          	ret

0000000080001f40 <consolewrite>:
    80001f40:	fb010113          	addi	sp,sp,-80
    80001f44:	04813023          	sd	s0,64(sp)
    80001f48:	04113423          	sd	ra,72(sp)
    80001f4c:	02913c23          	sd	s1,56(sp)
    80001f50:	03213823          	sd	s2,48(sp)
    80001f54:	03313423          	sd	s3,40(sp)
    80001f58:	03413023          	sd	s4,32(sp)
    80001f5c:	01513c23          	sd	s5,24(sp)
    80001f60:	05010413          	addi	s0,sp,80
    80001f64:	06c05c63          	blez	a2,80001fdc <consolewrite+0x9c>
    80001f68:	00060993          	mv	s3,a2
    80001f6c:	00050a13          	mv	s4,a0
    80001f70:	00058493          	mv	s1,a1
    80001f74:	00000913          	li	s2,0
    80001f78:	fff00a93          	li	s5,-1
    80001f7c:	01c0006f          	j	80001f98 <consolewrite+0x58>
    80001f80:	fbf44503          	lbu	a0,-65(s0)
    80001f84:	0019091b          	addiw	s2,s2,1
    80001f88:	00148493          	addi	s1,s1,1
    80001f8c:	00001097          	auipc	ra,0x1
    80001f90:	a9c080e7          	jalr	-1380(ra) # 80002a28 <uartputc>
    80001f94:	03298063          	beq	s3,s2,80001fb4 <consolewrite+0x74>
    80001f98:	00048613          	mv	a2,s1
    80001f9c:	00100693          	li	a3,1
    80001fa0:	000a0593          	mv	a1,s4
    80001fa4:	fbf40513          	addi	a0,s0,-65
    80001fa8:	00000097          	auipc	ra,0x0
    80001fac:	9e4080e7          	jalr	-1564(ra) # 8000198c <either_copyin>
    80001fb0:	fd5518e3          	bne	a0,s5,80001f80 <consolewrite+0x40>
    80001fb4:	04813083          	ld	ra,72(sp)
    80001fb8:	04013403          	ld	s0,64(sp)
    80001fbc:	03813483          	ld	s1,56(sp)
    80001fc0:	02813983          	ld	s3,40(sp)
    80001fc4:	02013a03          	ld	s4,32(sp)
    80001fc8:	01813a83          	ld	s5,24(sp)
    80001fcc:	00090513          	mv	a0,s2
    80001fd0:	03013903          	ld	s2,48(sp)
    80001fd4:	05010113          	addi	sp,sp,80
    80001fd8:	00008067          	ret
    80001fdc:	00000913          	li	s2,0
    80001fe0:	fd5ff06f          	j	80001fb4 <consolewrite+0x74>

0000000080001fe4 <consoleread>:
    80001fe4:	f9010113          	addi	sp,sp,-112
    80001fe8:	06813023          	sd	s0,96(sp)
    80001fec:	04913c23          	sd	s1,88(sp)
    80001ff0:	05213823          	sd	s2,80(sp)
    80001ff4:	05313423          	sd	s3,72(sp)
    80001ff8:	05413023          	sd	s4,64(sp)
    80001ffc:	03513c23          	sd	s5,56(sp)
    80002000:	03613823          	sd	s6,48(sp)
    80002004:	03713423          	sd	s7,40(sp)
    80002008:	03813023          	sd	s8,32(sp)
    8000200c:	06113423          	sd	ra,104(sp)
    80002010:	01913c23          	sd	s9,24(sp)
    80002014:	07010413          	addi	s0,sp,112
    80002018:	00060b93          	mv	s7,a2
    8000201c:	00050913          	mv	s2,a0
    80002020:	00058c13          	mv	s8,a1
    80002024:	00060b1b          	sext.w	s6,a2
    80002028:	00003497          	auipc	s1,0x3
    8000202c:	54048493          	addi	s1,s1,1344 # 80005568 <cons>
    80002030:	00400993          	li	s3,4
    80002034:	fff00a13          	li	s4,-1
    80002038:	00a00a93          	li	s5,10
    8000203c:	05705e63          	blez	s7,80002098 <consoleread+0xb4>
    80002040:	09c4a703          	lw	a4,156(s1)
    80002044:	0984a783          	lw	a5,152(s1)
    80002048:	0007071b          	sext.w	a4,a4
    8000204c:	08e78463          	beq	a5,a4,800020d4 <consoleread+0xf0>
    80002050:	07f7f713          	andi	a4,a5,127
    80002054:	00e48733          	add	a4,s1,a4
    80002058:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000205c:	0017869b          	addiw	a3,a5,1
    80002060:	08d4ac23          	sw	a3,152(s1)
    80002064:	00070c9b          	sext.w	s9,a4
    80002068:	0b370663          	beq	a4,s3,80002114 <consoleread+0x130>
    8000206c:	00100693          	li	a3,1
    80002070:	f9f40613          	addi	a2,s0,-97
    80002074:	000c0593          	mv	a1,s8
    80002078:	00090513          	mv	a0,s2
    8000207c:	f8e40fa3          	sb	a4,-97(s0)
    80002080:	00000097          	auipc	ra,0x0
    80002084:	8c0080e7          	jalr	-1856(ra) # 80001940 <either_copyout>
    80002088:	01450863          	beq	a0,s4,80002098 <consoleread+0xb4>
    8000208c:	001c0c13          	addi	s8,s8,1
    80002090:	fffb8b9b          	addiw	s7,s7,-1
    80002094:	fb5c94e3          	bne	s9,s5,8000203c <consoleread+0x58>
    80002098:	000b851b          	sext.w	a0,s7
    8000209c:	06813083          	ld	ra,104(sp)
    800020a0:	06013403          	ld	s0,96(sp)
    800020a4:	05813483          	ld	s1,88(sp)
    800020a8:	05013903          	ld	s2,80(sp)
    800020ac:	04813983          	ld	s3,72(sp)
    800020b0:	04013a03          	ld	s4,64(sp)
    800020b4:	03813a83          	ld	s5,56(sp)
    800020b8:	02813b83          	ld	s7,40(sp)
    800020bc:	02013c03          	ld	s8,32(sp)
    800020c0:	01813c83          	ld	s9,24(sp)
    800020c4:	40ab053b          	subw	a0,s6,a0
    800020c8:	03013b03          	ld	s6,48(sp)
    800020cc:	07010113          	addi	sp,sp,112
    800020d0:	00008067          	ret
    800020d4:	00001097          	auipc	ra,0x1
    800020d8:	1d8080e7          	jalr	472(ra) # 800032ac <push_on>
    800020dc:	0984a703          	lw	a4,152(s1)
    800020e0:	09c4a783          	lw	a5,156(s1)
    800020e4:	0007879b          	sext.w	a5,a5
    800020e8:	fef70ce3          	beq	a4,a5,800020e0 <consoleread+0xfc>
    800020ec:	00001097          	auipc	ra,0x1
    800020f0:	234080e7          	jalr	564(ra) # 80003320 <pop_on>
    800020f4:	0984a783          	lw	a5,152(s1)
    800020f8:	07f7f713          	andi	a4,a5,127
    800020fc:	00e48733          	add	a4,s1,a4
    80002100:	01874703          	lbu	a4,24(a4)
    80002104:	0017869b          	addiw	a3,a5,1
    80002108:	08d4ac23          	sw	a3,152(s1)
    8000210c:	00070c9b          	sext.w	s9,a4
    80002110:	f5371ee3          	bne	a4,s3,8000206c <consoleread+0x88>
    80002114:	000b851b          	sext.w	a0,s7
    80002118:	f96bf2e3          	bgeu	s7,s6,8000209c <consoleread+0xb8>
    8000211c:	08f4ac23          	sw	a5,152(s1)
    80002120:	f7dff06f          	j	8000209c <consoleread+0xb8>

0000000080002124 <consputc>:
    80002124:	10000793          	li	a5,256
    80002128:	00f50663          	beq	a0,a5,80002134 <consputc+0x10>
    8000212c:	00001317          	auipc	t1,0x1
    80002130:	9f430067          	jr	-1548(t1) # 80002b20 <uartputc_sync>
    80002134:	ff010113          	addi	sp,sp,-16
    80002138:	00113423          	sd	ra,8(sp)
    8000213c:	00813023          	sd	s0,0(sp)
    80002140:	01010413          	addi	s0,sp,16
    80002144:	00800513          	li	a0,8
    80002148:	00001097          	auipc	ra,0x1
    8000214c:	9d8080e7          	jalr	-1576(ra) # 80002b20 <uartputc_sync>
    80002150:	02000513          	li	a0,32
    80002154:	00001097          	auipc	ra,0x1
    80002158:	9cc080e7          	jalr	-1588(ra) # 80002b20 <uartputc_sync>
    8000215c:	00013403          	ld	s0,0(sp)
    80002160:	00813083          	ld	ra,8(sp)
    80002164:	00800513          	li	a0,8
    80002168:	01010113          	addi	sp,sp,16
    8000216c:	00001317          	auipc	t1,0x1
    80002170:	9b430067          	jr	-1612(t1) # 80002b20 <uartputc_sync>

0000000080002174 <consoleintr>:
    80002174:	fe010113          	addi	sp,sp,-32
    80002178:	00813823          	sd	s0,16(sp)
    8000217c:	00913423          	sd	s1,8(sp)
    80002180:	01213023          	sd	s2,0(sp)
    80002184:	00113c23          	sd	ra,24(sp)
    80002188:	02010413          	addi	s0,sp,32
    8000218c:	00003917          	auipc	s2,0x3
    80002190:	3dc90913          	addi	s2,s2,988 # 80005568 <cons>
    80002194:	00050493          	mv	s1,a0
    80002198:	00090513          	mv	a0,s2
    8000219c:	00001097          	auipc	ra,0x1
    800021a0:	e40080e7          	jalr	-448(ra) # 80002fdc <acquire>
    800021a4:	02048c63          	beqz	s1,800021dc <consoleintr+0x68>
    800021a8:	0a092783          	lw	a5,160(s2)
    800021ac:	09892703          	lw	a4,152(s2)
    800021b0:	07f00693          	li	a3,127
    800021b4:	40e7873b          	subw	a4,a5,a4
    800021b8:	02e6e263          	bltu	a3,a4,800021dc <consoleintr+0x68>
    800021bc:	00d00713          	li	a4,13
    800021c0:	04e48063          	beq	s1,a4,80002200 <consoleintr+0x8c>
    800021c4:	07f7f713          	andi	a4,a5,127
    800021c8:	00e90733          	add	a4,s2,a4
    800021cc:	0017879b          	addiw	a5,a5,1
    800021d0:	0af92023          	sw	a5,160(s2)
    800021d4:	00970c23          	sb	s1,24(a4)
    800021d8:	08f92e23          	sw	a5,156(s2)
    800021dc:	01013403          	ld	s0,16(sp)
    800021e0:	01813083          	ld	ra,24(sp)
    800021e4:	00813483          	ld	s1,8(sp)
    800021e8:	00013903          	ld	s2,0(sp)
    800021ec:	00003517          	auipc	a0,0x3
    800021f0:	37c50513          	addi	a0,a0,892 # 80005568 <cons>
    800021f4:	02010113          	addi	sp,sp,32
    800021f8:	00001317          	auipc	t1,0x1
    800021fc:	eb030067          	jr	-336(t1) # 800030a8 <release>
    80002200:	00a00493          	li	s1,10
    80002204:	fc1ff06f          	j	800021c4 <consoleintr+0x50>

0000000080002208 <consoleinit>:
    80002208:	fe010113          	addi	sp,sp,-32
    8000220c:	00113c23          	sd	ra,24(sp)
    80002210:	00813823          	sd	s0,16(sp)
    80002214:	00913423          	sd	s1,8(sp)
    80002218:	02010413          	addi	s0,sp,32
    8000221c:	00003497          	auipc	s1,0x3
    80002220:	34c48493          	addi	s1,s1,844 # 80005568 <cons>
    80002224:	00048513          	mv	a0,s1
    80002228:	00002597          	auipc	a1,0x2
    8000222c:	f3058593          	addi	a1,a1,-208 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    80002230:	00001097          	auipc	ra,0x1
    80002234:	d88080e7          	jalr	-632(ra) # 80002fb8 <initlock>
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	7ac080e7          	jalr	1964(ra) # 800029e4 <uartinit>
    80002240:	01813083          	ld	ra,24(sp)
    80002244:	01013403          	ld	s0,16(sp)
    80002248:	00000797          	auipc	a5,0x0
    8000224c:	d9c78793          	addi	a5,a5,-612 # 80001fe4 <consoleread>
    80002250:	0af4bc23          	sd	a5,184(s1)
    80002254:	00000797          	auipc	a5,0x0
    80002258:	cec78793          	addi	a5,a5,-788 # 80001f40 <consolewrite>
    8000225c:	0cf4b023          	sd	a5,192(s1)
    80002260:	00813483          	ld	s1,8(sp)
    80002264:	02010113          	addi	sp,sp,32
    80002268:	00008067          	ret

000000008000226c <console_read>:
    8000226c:	ff010113          	addi	sp,sp,-16
    80002270:	00813423          	sd	s0,8(sp)
    80002274:	01010413          	addi	s0,sp,16
    80002278:	00813403          	ld	s0,8(sp)
    8000227c:	00003317          	auipc	t1,0x3
    80002280:	3a433303          	ld	t1,932(t1) # 80005620 <devsw+0x10>
    80002284:	01010113          	addi	sp,sp,16
    80002288:	00030067          	jr	t1

000000008000228c <console_write>:
    8000228c:	ff010113          	addi	sp,sp,-16
    80002290:	00813423          	sd	s0,8(sp)
    80002294:	01010413          	addi	s0,sp,16
    80002298:	00813403          	ld	s0,8(sp)
    8000229c:	00003317          	auipc	t1,0x3
    800022a0:	38c33303          	ld	t1,908(t1) # 80005628 <devsw+0x18>
    800022a4:	01010113          	addi	sp,sp,16
    800022a8:	00030067          	jr	t1

00000000800022ac <panic>:
    800022ac:	fe010113          	addi	sp,sp,-32
    800022b0:	00113c23          	sd	ra,24(sp)
    800022b4:	00813823          	sd	s0,16(sp)
    800022b8:	00913423          	sd	s1,8(sp)
    800022bc:	02010413          	addi	s0,sp,32
    800022c0:	00050493          	mv	s1,a0
    800022c4:	00002517          	auipc	a0,0x2
    800022c8:	e9c50513          	addi	a0,a0,-356 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    800022cc:	00003797          	auipc	a5,0x3
    800022d0:	3e07ae23          	sw	zero,1020(a5) # 800056c8 <pr+0x18>
    800022d4:	00000097          	auipc	ra,0x0
    800022d8:	034080e7          	jalr	52(ra) # 80002308 <__printf>
    800022dc:	00048513          	mv	a0,s1
    800022e0:	00000097          	auipc	ra,0x0
    800022e4:	028080e7          	jalr	40(ra) # 80002308 <__printf>
    800022e8:	00002517          	auipc	a0,0x2
    800022ec:	e5850513          	addi	a0,a0,-424 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    800022f0:	00000097          	auipc	ra,0x0
    800022f4:	018080e7          	jalr	24(ra) # 80002308 <__printf>
    800022f8:	00100793          	li	a5,1
    800022fc:	00002717          	auipc	a4,0x2
    80002300:	16f72623          	sw	a5,364(a4) # 80004468 <panicked>
    80002304:	0000006f          	j	80002304 <panic+0x58>

0000000080002308 <__printf>:
    80002308:	f3010113          	addi	sp,sp,-208
    8000230c:	08813023          	sd	s0,128(sp)
    80002310:	07313423          	sd	s3,104(sp)
    80002314:	09010413          	addi	s0,sp,144
    80002318:	05813023          	sd	s8,64(sp)
    8000231c:	08113423          	sd	ra,136(sp)
    80002320:	06913c23          	sd	s1,120(sp)
    80002324:	07213823          	sd	s2,112(sp)
    80002328:	07413023          	sd	s4,96(sp)
    8000232c:	05513c23          	sd	s5,88(sp)
    80002330:	05613823          	sd	s6,80(sp)
    80002334:	05713423          	sd	s7,72(sp)
    80002338:	03913c23          	sd	s9,56(sp)
    8000233c:	03a13823          	sd	s10,48(sp)
    80002340:	03b13423          	sd	s11,40(sp)
    80002344:	00003317          	auipc	t1,0x3
    80002348:	36c30313          	addi	t1,t1,876 # 800056b0 <pr>
    8000234c:	01832c03          	lw	s8,24(t1)
    80002350:	00b43423          	sd	a1,8(s0)
    80002354:	00c43823          	sd	a2,16(s0)
    80002358:	00d43c23          	sd	a3,24(s0)
    8000235c:	02e43023          	sd	a4,32(s0)
    80002360:	02f43423          	sd	a5,40(s0)
    80002364:	03043823          	sd	a6,48(s0)
    80002368:	03143c23          	sd	a7,56(s0)
    8000236c:	00050993          	mv	s3,a0
    80002370:	4a0c1663          	bnez	s8,8000281c <__printf+0x514>
    80002374:	60098c63          	beqz	s3,8000298c <__printf+0x684>
    80002378:	0009c503          	lbu	a0,0(s3)
    8000237c:	00840793          	addi	a5,s0,8
    80002380:	f6f43c23          	sd	a5,-136(s0)
    80002384:	00000493          	li	s1,0
    80002388:	22050063          	beqz	a0,800025a8 <__printf+0x2a0>
    8000238c:	00002a37          	lui	s4,0x2
    80002390:	00018ab7          	lui	s5,0x18
    80002394:	000f4b37          	lui	s6,0xf4
    80002398:	00989bb7          	lui	s7,0x989
    8000239c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800023a0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800023a4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800023a8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800023ac:	00148c9b          	addiw	s9,s1,1
    800023b0:	02500793          	li	a5,37
    800023b4:	01998933          	add	s2,s3,s9
    800023b8:	38f51263          	bne	a0,a5,8000273c <__printf+0x434>
    800023bc:	00094783          	lbu	a5,0(s2)
    800023c0:	00078c9b          	sext.w	s9,a5
    800023c4:	1e078263          	beqz	a5,800025a8 <__printf+0x2a0>
    800023c8:	0024849b          	addiw	s1,s1,2
    800023cc:	07000713          	li	a4,112
    800023d0:	00998933          	add	s2,s3,s1
    800023d4:	38e78a63          	beq	a5,a4,80002768 <__printf+0x460>
    800023d8:	20f76863          	bltu	a4,a5,800025e8 <__printf+0x2e0>
    800023dc:	42a78863          	beq	a5,a0,8000280c <__printf+0x504>
    800023e0:	06400713          	li	a4,100
    800023e4:	40e79663          	bne	a5,a4,800027f0 <__printf+0x4e8>
    800023e8:	f7843783          	ld	a5,-136(s0)
    800023ec:	0007a603          	lw	a2,0(a5)
    800023f0:	00878793          	addi	a5,a5,8
    800023f4:	f6f43c23          	sd	a5,-136(s0)
    800023f8:	42064a63          	bltz	a2,8000282c <__printf+0x524>
    800023fc:	00a00713          	li	a4,10
    80002400:	02e677bb          	remuw	a5,a2,a4
    80002404:	00002d97          	auipc	s11,0x2
    80002408:	d84d8d93          	addi	s11,s11,-636 # 80004188 <digits>
    8000240c:	00900593          	li	a1,9
    80002410:	0006051b          	sext.w	a0,a2
    80002414:	00000c93          	li	s9,0
    80002418:	02079793          	slli	a5,a5,0x20
    8000241c:	0207d793          	srli	a5,a5,0x20
    80002420:	00fd87b3          	add	a5,s11,a5
    80002424:	0007c783          	lbu	a5,0(a5)
    80002428:	02e656bb          	divuw	a3,a2,a4
    8000242c:	f8f40023          	sb	a5,-128(s0)
    80002430:	14c5d863          	bge	a1,a2,80002580 <__printf+0x278>
    80002434:	06300593          	li	a1,99
    80002438:	00100c93          	li	s9,1
    8000243c:	02e6f7bb          	remuw	a5,a3,a4
    80002440:	02079793          	slli	a5,a5,0x20
    80002444:	0207d793          	srli	a5,a5,0x20
    80002448:	00fd87b3          	add	a5,s11,a5
    8000244c:	0007c783          	lbu	a5,0(a5)
    80002450:	02e6d73b          	divuw	a4,a3,a4
    80002454:	f8f400a3          	sb	a5,-127(s0)
    80002458:	12a5f463          	bgeu	a1,a0,80002580 <__printf+0x278>
    8000245c:	00a00693          	li	a3,10
    80002460:	00900593          	li	a1,9
    80002464:	02d777bb          	remuw	a5,a4,a3
    80002468:	02079793          	slli	a5,a5,0x20
    8000246c:	0207d793          	srli	a5,a5,0x20
    80002470:	00fd87b3          	add	a5,s11,a5
    80002474:	0007c503          	lbu	a0,0(a5)
    80002478:	02d757bb          	divuw	a5,a4,a3
    8000247c:	f8a40123          	sb	a0,-126(s0)
    80002480:	48e5f263          	bgeu	a1,a4,80002904 <__printf+0x5fc>
    80002484:	06300513          	li	a0,99
    80002488:	02d7f5bb          	remuw	a1,a5,a3
    8000248c:	02059593          	slli	a1,a1,0x20
    80002490:	0205d593          	srli	a1,a1,0x20
    80002494:	00bd85b3          	add	a1,s11,a1
    80002498:	0005c583          	lbu	a1,0(a1)
    8000249c:	02d7d7bb          	divuw	a5,a5,a3
    800024a0:	f8b401a3          	sb	a1,-125(s0)
    800024a4:	48e57263          	bgeu	a0,a4,80002928 <__printf+0x620>
    800024a8:	3e700513          	li	a0,999
    800024ac:	02d7f5bb          	remuw	a1,a5,a3
    800024b0:	02059593          	slli	a1,a1,0x20
    800024b4:	0205d593          	srli	a1,a1,0x20
    800024b8:	00bd85b3          	add	a1,s11,a1
    800024bc:	0005c583          	lbu	a1,0(a1)
    800024c0:	02d7d7bb          	divuw	a5,a5,a3
    800024c4:	f8b40223          	sb	a1,-124(s0)
    800024c8:	46e57663          	bgeu	a0,a4,80002934 <__printf+0x62c>
    800024cc:	02d7f5bb          	remuw	a1,a5,a3
    800024d0:	02059593          	slli	a1,a1,0x20
    800024d4:	0205d593          	srli	a1,a1,0x20
    800024d8:	00bd85b3          	add	a1,s11,a1
    800024dc:	0005c583          	lbu	a1,0(a1)
    800024e0:	02d7d7bb          	divuw	a5,a5,a3
    800024e4:	f8b402a3          	sb	a1,-123(s0)
    800024e8:	46ea7863          	bgeu	s4,a4,80002958 <__printf+0x650>
    800024ec:	02d7f5bb          	remuw	a1,a5,a3
    800024f0:	02059593          	slli	a1,a1,0x20
    800024f4:	0205d593          	srli	a1,a1,0x20
    800024f8:	00bd85b3          	add	a1,s11,a1
    800024fc:	0005c583          	lbu	a1,0(a1)
    80002500:	02d7d7bb          	divuw	a5,a5,a3
    80002504:	f8b40323          	sb	a1,-122(s0)
    80002508:	3eeaf863          	bgeu	s5,a4,800028f8 <__printf+0x5f0>
    8000250c:	02d7f5bb          	remuw	a1,a5,a3
    80002510:	02059593          	slli	a1,a1,0x20
    80002514:	0205d593          	srli	a1,a1,0x20
    80002518:	00bd85b3          	add	a1,s11,a1
    8000251c:	0005c583          	lbu	a1,0(a1)
    80002520:	02d7d7bb          	divuw	a5,a5,a3
    80002524:	f8b403a3          	sb	a1,-121(s0)
    80002528:	42eb7e63          	bgeu	s6,a4,80002964 <__printf+0x65c>
    8000252c:	02d7f5bb          	remuw	a1,a5,a3
    80002530:	02059593          	slli	a1,a1,0x20
    80002534:	0205d593          	srli	a1,a1,0x20
    80002538:	00bd85b3          	add	a1,s11,a1
    8000253c:	0005c583          	lbu	a1,0(a1)
    80002540:	02d7d7bb          	divuw	a5,a5,a3
    80002544:	f8b40423          	sb	a1,-120(s0)
    80002548:	42ebfc63          	bgeu	s7,a4,80002980 <__printf+0x678>
    8000254c:	02079793          	slli	a5,a5,0x20
    80002550:	0207d793          	srli	a5,a5,0x20
    80002554:	00fd8db3          	add	s11,s11,a5
    80002558:	000dc703          	lbu	a4,0(s11)
    8000255c:	00a00793          	li	a5,10
    80002560:	00900c93          	li	s9,9
    80002564:	f8e404a3          	sb	a4,-119(s0)
    80002568:	00065c63          	bgez	a2,80002580 <__printf+0x278>
    8000256c:	f9040713          	addi	a4,s0,-112
    80002570:	00f70733          	add	a4,a4,a5
    80002574:	02d00693          	li	a3,45
    80002578:	fed70823          	sb	a3,-16(a4)
    8000257c:	00078c93          	mv	s9,a5
    80002580:	f8040793          	addi	a5,s0,-128
    80002584:	01978cb3          	add	s9,a5,s9
    80002588:	f7f40d13          	addi	s10,s0,-129
    8000258c:	000cc503          	lbu	a0,0(s9)
    80002590:	fffc8c93          	addi	s9,s9,-1
    80002594:	00000097          	auipc	ra,0x0
    80002598:	b90080e7          	jalr	-1136(ra) # 80002124 <consputc>
    8000259c:	ffac98e3          	bne	s9,s10,8000258c <__printf+0x284>
    800025a0:	00094503          	lbu	a0,0(s2)
    800025a4:	e00514e3          	bnez	a0,800023ac <__printf+0xa4>
    800025a8:	1a0c1663          	bnez	s8,80002754 <__printf+0x44c>
    800025ac:	08813083          	ld	ra,136(sp)
    800025b0:	08013403          	ld	s0,128(sp)
    800025b4:	07813483          	ld	s1,120(sp)
    800025b8:	07013903          	ld	s2,112(sp)
    800025bc:	06813983          	ld	s3,104(sp)
    800025c0:	06013a03          	ld	s4,96(sp)
    800025c4:	05813a83          	ld	s5,88(sp)
    800025c8:	05013b03          	ld	s6,80(sp)
    800025cc:	04813b83          	ld	s7,72(sp)
    800025d0:	04013c03          	ld	s8,64(sp)
    800025d4:	03813c83          	ld	s9,56(sp)
    800025d8:	03013d03          	ld	s10,48(sp)
    800025dc:	02813d83          	ld	s11,40(sp)
    800025e0:	0d010113          	addi	sp,sp,208
    800025e4:	00008067          	ret
    800025e8:	07300713          	li	a4,115
    800025ec:	1ce78a63          	beq	a5,a4,800027c0 <__printf+0x4b8>
    800025f0:	07800713          	li	a4,120
    800025f4:	1ee79e63          	bne	a5,a4,800027f0 <__printf+0x4e8>
    800025f8:	f7843783          	ld	a5,-136(s0)
    800025fc:	0007a703          	lw	a4,0(a5)
    80002600:	00878793          	addi	a5,a5,8
    80002604:	f6f43c23          	sd	a5,-136(s0)
    80002608:	28074263          	bltz	a4,8000288c <__printf+0x584>
    8000260c:	00002d97          	auipc	s11,0x2
    80002610:	b7cd8d93          	addi	s11,s11,-1156 # 80004188 <digits>
    80002614:	00f77793          	andi	a5,a4,15
    80002618:	00fd87b3          	add	a5,s11,a5
    8000261c:	0007c683          	lbu	a3,0(a5)
    80002620:	00f00613          	li	a2,15
    80002624:	0007079b          	sext.w	a5,a4
    80002628:	f8d40023          	sb	a3,-128(s0)
    8000262c:	0047559b          	srliw	a1,a4,0x4
    80002630:	0047569b          	srliw	a3,a4,0x4
    80002634:	00000c93          	li	s9,0
    80002638:	0ee65063          	bge	a2,a4,80002718 <__printf+0x410>
    8000263c:	00f6f693          	andi	a3,a3,15
    80002640:	00dd86b3          	add	a3,s11,a3
    80002644:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002648:	0087d79b          	srliw	a5,a5,0x8
    8000264c:	00100c93          	li	s9,1
    80002650:	f8d400a3          	sb	a3,-127(s0)
    80002654:	0cb67263          	bgeu	a2,a1,80002718 <__printf+0x410>
    80002658:	00f7f693          	andi	a3,a5,15
    8000265c:	00dd86b3          	add	a3,s11,a3
    80002660:	0006c583          	lbu	a1,0(a3)
    80002664:	00f00613          	li	a2,15
    80002668:	0047d69b          	srliw	a3,a5,0x4
    8000266c:	f8b40123          	sb	a1,-126(s0)
    80002670:	0047d593          	srli	a1,a5,0x4
    80002674:	28f67e63          	bgeu	a2,a5,80002910 <__printf+0x608>
    80002678:	00f6f693          	andi	a3,a3,15
    8000267c:	00dd86b3          	add	a3,s11,a3
    80002680:	0006c503          	lbu	a0,0(a3)
    80002684:	0087d813          	srli	a6,a5,0x8
    80002688:	0087d69b          	srliw	a3,a5,0x8
    8000268c:	f8a401a3          	sb	a0,-125(s0)
    80002690:	28b67663          	bgeu	a2,a1,8000291c <__printf+0x614>
    80002694:	00f6f693          	andi	a3,a3,15
    80002698:	00dd86b3          	add	a3,s11,a3
    8000269c:	0006c583          	lbu	a1,0(a3)
    800026a0:	00c7d513          	srli	a0,a5,0xc
    800026a4:	00c7d69b          	srliw	a3,a5,0xc
    800026a8:	f8b40223          	sb	a1,-124(s0)
    800026ac:	29067a63          	bgeu	a2,a6,80002940 <__printf+0x638>
    800026b0:	00f6f693          	andi	a3,a3,15
    800026b4:	00dd86b3          	add	a3,s11,a3
    800026b8:	0006c583          	lbu	a1,0(a3)
    800026bc:	0107d813          	srli	a6,a5,0x10
    800026c0:	0107d69b          	srliw	a3,a5,0x10
    800026c4:	f8b402a3          	sb	a1,-123(s0)
    800026c8:	28a67263          	bgeu	a2,a0,8000294c <__printf+0x644>
    800026cc:	00f6f693          	andi	a3,a3,15
    800026d0:	00dd86b3          	add	a3,s11,a3
    800026d4:	0006c683          	lbu	a3,0(a3)
    800026d8:	0147d79b          	srliw	a5,a5,0x14
    800026dc:	f8d40323          	sb	a3,-122(s0)
    800026e0:	21067663          	bgeu	a2,a6,800028ec <__printf+0x5e4>
    800026e4:	02079793          	slli	a5,a5,0x20
    800026e8:	0207d793          	srli	a5,a5,0x20
    800026ec:	00fd8db3          	add	s11,s11,a5
    800026f0:	000dc683          	lbu	a3,0(s11)
    800026f4:	00800793          	li	a5,8
    800026f8:	00700c93          	li	s9,7
    800026fc:	f8d403a3          	sb	a3,-121(s0)
    80002700:	00075c63          	bgez	a4,80002718 <__printf+0x410>
    80002704:	f9040713          	addi	a4,s0,-112
    80002708:	00f70733          	add	a4,a4,a5
    8000270c:	02d00693          	li	a3,45
    80002710:	fed70823          	sb	a3,-16(a4)
    80002714:	00078c93          	mv	s9,a5
    80002718:	f8040793          	addi	a5,s0,-128
    8000271c:	01978cb3          	add	s9,a5,s9
    80002720:	f7f40d13          	addi	s10,s0,-129
    80002724:	000cc503          	lbu	a0,0(s9)
    80002728:	fffc8c93          	addi	s9,s9,-1
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	9f8080e7          	jalr	-1544(ra) # 80002124 <consputc>
    80002734:	ff9d18e3          	bne	s10,s9,80002724 <__printf+0x41c>
    80002738:	0100006f          	j	80002748 <__printf+0x440>
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	9e8080e7          	jalr	-1560(ra) # 80002124 <consputc>
    80002744:	000c8493          	mv	s1,s9
    80002748:	00094503          	lbu	a0,0(s2)
    8000274c:	c60510e3          	bnez	a0,800023ac <__printf+0xa4>
    80002750:	e40c0ee3          	beqz	s8,800025ac <__printf+0x2a4>
    80002754:	00003517          	auipc	a0,0x3
    80002758:	f5c50513          	addi	a0,a0,-164 # 800056b0 <pr>
    8000275c:	00001097          	auipc	ra,0x1
    80002760:	94c080e7          	jalr	-1716(ra) # 800030a8 <release>
    80002764:	e49ff06f          	j	800025ac <__printf+0x2a4>
    80002768:	f7843783          	ld	a5,-136(s0)
    8000276c:	03000513          	li	a0,48
    80002770:	01000d13          	li	s10,16
    80002774:	00878713          	addi	a4,a5,8
    80002778:	0007bc83          	ld	s9,0(a5)
    8000277c:	f6e43c23          	sd	a4,-136(s0)
    80002780:	00000097          	auipc	ra,0x0
    80002784:	9a4080e7          	jalr	-1628(ra) # 80002124 <consputc>
    80002788:	07800513          	li	a0,120
    8000278c:	00000097          	auipc	ra,0x0
    80002790:	998080e7          	jalr	-1640(ra) # 80002124 <consputc>
    80002794:	00002d97          	auipc	s11,0x2
    80002798:	9f4d8d93          	addi	s11,s11,-1548 # 80004188 <digits>
    8000279c:	03ccd793          	srli	a5,s9,0x3c
    800027a0:	00fd87b3          	add	a5,s11,a5
    800027a4:	0007c503          	lbu	a0,0(a5)
    800027a8:	fffd0d1b          	addiw	s10,s10,-1
    800027ac:	004c9c93          	slli	s9,s9,0x4
    800027b0:	00000097          	auipc	ra,0x0
    800027b4:	974080e7          	jalr	-1676(ra) # 80002124 <consputc>
    800027b8:	fe0d12e3          	bnez	s10,8000279c <__printf+0x494>
    800027bc:	f8dff06f          	j	80002748 <__printf+0x440>
    800027c0:	f7843783          	ld	a5,-136(s0)
    800027c4:	0007bc83          	ld	s9,0(a5)
    800027c8:	00878793          	addi	a5,a5,8
    800027cc:	f6f43c23          	sd	a5,-136(s0)
    800027d0:	000c9a63          	bnez	s9,800027e4 <__printf+0x4dc>
    800027d4:	1080006f          	j	800028dc <__printf+0x5d4>
    800027d8:	001c8c93          	addi	s9,s9,1
    800027dc:	00000097          	auipc	ra,0x0
    800027e0:	948080e7          	jalr	-1720(ra) # 80002124 <consputc>
    800027e4:	000cc503          	lbu	a0,0(s9)
    800027e8:	fe0518e3          	bnez	a0,800027d8 <__printf+0x4d0>
    800027ec:	f5dff06f          	j	80002748 <__printf+0x440>
    800027f0:	02500513          	li	a0,37
    800027f4:	00000097          	auipc	ra,0x0
    800027f8:	930080e7          	jalr	-1744(ra) # 80002124 <consputc>
    800027fc:	000c8513          	mv	a0,s9
    80002800:	00000097          	auipc	ra,0x0
    80002804:	924080e7          	jalr	-1756(ra) # 80002124 <consputc>
    80002808:	f41ff06f          	j	80002748 <__printf+0x440>
    8000280c:	02500513          	li	a0,37
    80002810:	00000097          	auipc	ra,0x0
    80002814:	914080e7          	jalr	-1772(ra) # 80002124 <consputc>
    80002818:	f31ff06f          	j	80002748 <__printf+0x440>
    8000281c:	00030513          	mv	a0,t1
    80002820:	00000097          	auipc	ra,0x0
    80002824:	7bc080e7          	jalr	1980(ra) # 80002fdc <acquire>
    80002828:	b4dff06f          	j	80002374 <__printf+0x6c>
    8000282c:	40c0053b          	negw	a0,a2
    80002830:	00a00713          	li	a4,10
    80002834:	02e576bb          	remuw	a3,a0,a4
    80002838:	00002d97          	auipc	s11,0x2
    8000283c:	950d8d93          	addi	s11,s11,-1712 # 80004188 <digits>
    80002840:	ff700593          	li	a1,-9
    80002844:	02069693          	slli	a3,a3,0x20
    80002848:	0206d693          	srli	a3,a3,0x20
    8000284c:	00dd86b3          	add	a3,s11,a3
    80002850:	0006c683          	lbu	a3,0(a3)
    80002854:	02e557bb          	divuw	a5,a0,a4
    80002858:	f8d40023          	sb	a3,-128(s0)
    8000285c:	10b65e63          	bge	a2,a1,80002978 <__printf+0x670>
    80002860:	06300593          	li	a1,99
    80002864:	02e7f6bb          	remuw	a3,a5,a4
    80002868:	02069693          	slli	a3,a3,0x20
    8000286c:	0206d693          	srli	a3,a3,0x20
    80002870:	00dd86b3          	add	a3,s11,a3
    80002874:	0006c683          	lbu	a3,0(a3)
    80002878:	02e7d73b          	divuw	a4,a5,a4
    8000287c:	00200793          	li	a5,2
    80002880:	f8d400a3          	sb	a3,-127(s0)
    80002884:	bca5ece3          	bltu	a1,a0,8000245c <__printf+0x154>
    80002888:	ce5ff06f          	j	8000256c <__printf+0x264>
    8000288c:	40e007bb          	negw	a5,a4
    80002890:	00002d97          	auipc	s11,0x2
    80002894:	8f8d8d93          	addi	s11,s11,-1800 # 80004188 <digits>
    80002898:	00f7f693          	andi	a3,a5,15
    8000289c:	00dd86b3          	add	a3,s11,a3
    800028a0:	0006c583          	lbu	a1,0(a3)
    800028a4:	ff100613          	li	a2,-15
    800028a8:	0047d69b          	srliw	a3,a5,0x4
    800028ac:	f8b40023          	sb	a1,-128(s0)
    800028b0:	0047d59b          	srliw	a1,a5,0x4
    800028b4:	0ac75e63          	bge	a4,a2,80002970 <__printf+0x668>
    800028b8:	00f6f693          	andi	a3,a3,15
    800028bc:	00dd86b3          	add	a3,s11,a3
    800028c0:	0006c603          	lbu	a2,0(a3)
    800028c4:	00f00693          	li	a3,15
    800028c8:	0087d79b          	srliw	a5,a5,0x8
    800028cc:	f8c400a3          	sb	a2,-127(s0)
    800028d0:	d8b6e4e3          	bltu	a3,a1,80002658 <__printf+0x350>
    800028d4:	00200793          	li	a5,2
    800028d8:	e2dff06f          	j	80002704 <__printf+0x3fc>
    800028dc:	00002c97          	auipc	s9,0x2
    800028e0:	88cc8c93          	addi	s9,s9,-1908 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    800028e4:	02800513          	li	a0,40
    800028e8:	ef1ff06f          	j	800027d8 <__printf+0x4d0>
    800028ec:	00700793          	li	a5,7
    800028f0:	00600c93          	li	s9,6
    800028f4:	e0dff06f          	j	80002700 <__printf+0x3f8>
    800028f8:	00700793          	li	a5,7
    800028fc:	00600c93          	li	s9,6
    80002900:	c69ff06f          	j	80002568 <__printf+0x260>
    80002904:	00300793          	li	a5,3
    80002908:	00200c93          	li	s9,2
    8000290c:	c5dff06f          	j	80002568 <__printf+0x260>
    80002910:	00300793          	li	a5,3
    80002914:	00200c93          	li	s9,2
    80002918:	de9ff06f          	j	80002700 <__printf+0x3f8>
    8000291c:	00400793          	li	a5,4
    80002920:	00300c93          	li	s9,3
    80002924:	dddff06f          	j	80002700 <__printf+0x3f8>
    80002928:	00400793          	li	a5,4
    8000292c:	00300c93          	li	s9,3
    80002930:	c39ff06f          	j	80002568 <__printf+0x260>
    80002934:	00500793          	li	a5,5
    80002938:	00400c93          	li	s9,4
    8000293c:	c2dff06f          	j	80002568 <__printf+0x260>
    80002940:	00500793          	li	a5,5
    80002944:	00400c93          	li	s9,4
    80002948:	db9ff06f          	j	80002700 <__printf+0x3f8>
    8000294c:	00600793          	li	a5,6
    80002950:	00500c93          	li	s9,5
    80002954:	dadff06f          	j	80002700 <__printf+0x3f8>
    80002958:	00600793          	li	a5,6
    8000295c:	00500c93          	li	s9,5
    80002960:	c09ff06f          	j	80002568 <__printf+0x260>
    80002964:	00800793          	li	a5,8
    80002968:	00700c93          	li	s9,7
    8000296c:	bfdff06f          	j	80002568 <__printf+0x260>
    80002970:	00100793          	li	a5,1
    80002974:	d91ff06f          	j	80002704 <__printf+0x3fc>
    80002978:	00100793          	li	a5,1
    8000297c:	bf1ff06f          	j	8000256c <__printf+0x264>
    80002980:	00900793          	li	a5,9
    80002984:	00800c93          	li	s9,8
    80002988:	be1ff06f          	j	80002568 <__printf+0x260>
    8000298c:	00001517          	auipc	a0,0x1
    80002990:	7e450513          	addi	a0,a0,2020 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002994:	00000097          	auipc	ra,0x0
    80002998:	918080e7          	jalr	-1768(ra) # 800022ac <panic>

000000008000299c <printfinit>:
    8000299c:	fe010113          	addi	sp,sp,-32
    800029a0:	00813823          	sd	s0,16(sp)
    800029a4:	00913423          	sd	s1,8(sp)
    800029a8:	00113c23          	sd	ra,24(sp)
    800029ac:	02010413          	addi	s0,sp,32
    800029b0:	00003497          	auipc	s1,0x3
    800029b4:	d0048493          	addi	s1,s1,-768 # 800056b0 <pr>
    800029b8:	00048513          	mv	a0,s1
    800029bc:	00001597          	auipc	a1,0x1
    800029c0:	7c458593          	addi	a1,a1,1988 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    800029c4:	00000097          	auipc	ra,0x0
    800029c8:	5f4080e7          	jalr	1524(ra) # 80002fb8 <initlock>
    800029cc:	01813083          	ld	ra,24(sp)
    800029d0:	01013403          	ld	s0,16(sp)
    800029d4:	0004ac23          	sw	zero,24(s1)
    800029d8:	00813483          	ld	s1,8(sp)
    800029dc:	02010113          	addi	sp,sp,32
    800029e0:	00008067          	ret

00000000800029e4 <uartinit>:
    800029e4:	ff010113          	addi	sp,sp,-16
    800029e8:	00813423          	sd	s0,8(sp)
    800029ec:	01010413          	addi	s0,sp,16
    800029f0:	100007b7          	lui	a5,0x10000
    800029f4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800029f8:	f8000713          	li	a4,-128
    800029fc:	00e781a3          	sb	a4,3(a5)
    80002a00:	00300713          	li	a4,3
    80002a04:	00e78023          	sb	a4,0(a5)
    80002a08:	000780a3          	sb	zero,1(a5)
    80002a0c:	00e781a3          	sb	a4,3(a5)
    80002a10:	00700693          	li	a3,7
    80002a14:	00d78123          	sb	a3,2(a5)
    80002a18:	00e780a3          	sb	a4,1(a5)
    80002a1c:	00813403          	ld	s0,8(sp)
    80002a20:	01010113          	addi	sp,sp,16
    80002a24:	00008067          	ret

0000000080002a28 <uartputc>:
    80002a28:	00002797          	auipc	a5,0x2
    80002a2c:	a407a783          	lw	a5,-1472(a5) # 80004468 <panicked>
    80002a30:	00078463          	beqz	a5,80002a38 <uartputc+0x10>
    80002a34:	0000006f          	j	80002a34 <uartputc+0xc>
    80002a38:	fd010113          	addi	sp,sp,-48
    80002a3c:	02813023          	sd	s0,32(sp)
    80002a40:	00913c23          	sd	s1,24(sp)
    80002a44:	01213823          	sd	s2,16(sp)
    80002a48:	01313423          	sd	s3,8(sp)
    80002a4c:	02113423          	sd	ra,40(sp)
    80002a50:	03010413          	addi	s0,sp,48
    80002a54:	00002917          	auipc	s2,0x2
    80002a58:	a1c90913          	addi	s2,s2,-1508 # 80004470 <uart_tx_r>
    80002a5c:	00093783          	ld	a5,0(s2)
    80002a60:	00002497          	auipc	s1,0x2
    80002a64:	a1848493          	addi	s1,s1,-1512 # 80004478 <uart_tx_w>
    80002a68:	0004b703          	ld	a4,0(s1)
    80002a6c:	02078693          	addi	a3,a5,32
    80002a70:	00050993          	mv	s3,a0
    80002a74:	02e69c63          	bne	a3,a4,80002aac <uartputc+0x84>
    80002a78:	00001097          	auipc	ra,0x1
    80002a7c:	834080e7          	jalr	-1996(ra) # 800032ac <push_on>
    80002a80:	00093783          	ld	a5,0(s2)
    80002a84:	0004b703          	ld	a4,0(s1)
    80002a88:	02078793          	addi	a5,a5,32
    80002a8c:	00e79463          	bne	a5,a4,80002a94 <uartputc+0x6c>
    80002a90:	0000006f          	j	80002a90 <uartputc+0x68>
    80002a94:	00001097          	auipc	ra,0x1
    80002a98:	88c080e7          	jalr	-1908(ra) # 80003320 <pop_on>
    80002a9c:	00093783          	ld	a5,0(s2)
    80002aa0:	0004b703          	ld	a4,0(s1)
    80002aa4:	02078693          	addi	a3,a5,32
    80002aa8:	fce688e3          	beq	a3,a4,80002a78 <uartputc+0x50>
    80002aac:	01f77693          	andi	a3,a4,31
    80002ab0:	00003597          	auipc	a1,0x3
    80002ab4:	c2058593          	addi	a1,a1,-992 # 800056d0 <uart_tx_buf>
    80002ab8:	00d586b3          	add	a3,a1,a3
    80002abc:	00170713          	addi	a4,a4,1
    80002ac0:	01368023          	sb	s3,0(a3)
    80002ac4:	00e4b023          	sd	a4,0(s1)
    80002ac8:	10000637          	lui	a2,0x10000
    80002acc:	02f71063          	bne	a4,a5,80002aec <uartputc+0xc4>
    80002ad0:	0340006f          	j	80002b04 <uartputc+0xdc>
    80002ad4:	00074703          	lbu	a4,0(a4)
    80002ad8:	00f93023          	sd	a5,0(s2)
    80002adc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002ae0:	00093783          	ld	a5,0(s2)
    80002ae4:	0004b703          	ld	a4,0(s1)
    80002ae8:	00f70e63          	beq	a4,a5,80002b04 <uartputc+0xdc>
    80002aec:	00564683          	lbu	a3,5(a2)
    80002af0:	01f7f713          	andi	a4,a5,31
    80002af4:	00e58733          	add	a4,a1,a4
    80002af8:	0206f693          	andi	a3,a3,32
    80002afc:	00178793          	addi	a5,a5,1
    80002b00:	fc069ae3          	bnez	a3,80002ad4 <uartputc+0xac>
    80002b04:	02813083          	ld	ra,40(sp)
    80002b08:	02013403          	ld	s0,32(sp)
    80002b0c:	01813483          	ld	s1,24(sp)
    80002b10:	01013903          	ld	s2,16(sp)
    80002b14:	00813983          	ld	s3,8(sp)
    80002b18:	03010113          	addi	sp,sp,48
    80002b1c:	00008067          	ret

0000000080002b20 <uartputc_sync>:
    80002b20:	ff010113          	addi	sp,sp,-16
    80002b24:	00813423          	sd	s0,8(sp)
    80002b28:	01010413          	addi	s0,sp,16
    80002b2c:	00002717          	auipc	a4,0x2
    80002b30:	93c72703          	lw	a4,-1732(a4) # 80004468 <panicked>
    80002b34:	02071663          	bnez	a4,80002b60 <uartputc_sync+0x40>
    80002b38:	00050793          	mv	a5,a0
    80002b3c:	100006b7          	lui	a3,0x10000
    80002b40:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002b44:	02077713          	andi	a4,a4,32
    80002b48:	fe070ce3          	beqz	a4,80002b40 <uartputc_sync+0x20>
    80002b4c:	0ff7f793          	andi	a5,a5,255
    80002b50:	00f68023          	sb	a5,0(a3)
    80002b54:	00813403          	ld	s0,8(sp)
    80002b58:	01010113          	addi	sp,sp,16
    80002b5c:	00008067          	ret
    80002b60:	0000006f          	j	80002b60 <uartputc_sync+0x40>

0000000080002b64 <uartstart>:
    80002b64:	ff010113          	addi	sp,sp,-16
    80002b68:	00813423          	sd	s0,8(sp)
    80002b6c:	01010413          	addi	s0,sp,16
    80002b70:	00002617          	auipc	a2,0x2
    80002b74:	90060613          	addi	a2,a2,-1792 # 80004470 <uart_tx_r>
    80002b78:	00002517          	auipc	a0,0x2
    80002b7c:	90050513          	addi	a0,a0,-1792 # 80004478 <uart_tx_w>
    80002b80:	00063783          	ld	a5,0(a2)
    80002b84:	00053703          	ld	a4,0(a0)
    80002b88:	04f70263          	beq	a4,a5,80002bcc <uartstart+0x68>
    80002b8c:	100005b7          	lui	a1,0x10000
    80002b90:	00003817          	auipc	a6,0x3
    80002b94:	b4080813          	addi	a6,a6,-1216 # 800056d0 <uart_tx_buf>
    80002b98:	01c0006f          	j	80002bb4 <uartstart+0x50>
    80002b9c:	0006c703          	lbu	a4,0(a3)
    80002ba0:	00f63023          	sd	a5,0(a2)
    80002ba4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002ba8:	00063783          	ld	a5,0(a2)
    80002bac:	00053703          	ld	a4,0(a0)
    80002bb0:	00f70e63          	beq	a4,a5,80002bcc <uartstart+0x68>
    80002bb4:	01f7f713          	andi	a4,a5,31
    80002bb8:	00e806b3          	add	a3,a6,a4
    80002bbc:	0055c703          	lbu	a4,5(a1)
    80002bc0:	00178793          	addi	a5,a5,1
    80002bc4:	02077713          	andi	a4,a4,32
    80002bc8:	fc071ae3          	bnez	a4,80002b9c <uartstart+0x38>
    80002bcc:	00813403          	ld	s0,8(sp)
    80002bd0:	01010113          	addi	sp,sp,16
    80002bd4:	00008067          	ret

0000000080002bd8 <uartgetc>:
    80002bd8:	ff010113          	addi	sp,sp,-16
    80002bdc:	00813423          	sd	s0,8(sp)
    80002be0:	01010413          	addi	s0,sp,16
    80002be4:	10000737          	lui	a4,0x10000
    80002be8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002bec:	0017f793          	andi	a5,a5,1
    80002bf0:	00078c63          	beqz	a5,80002c08 <uartgetc+0x30>
    80002bf4:	00074503          	lbu	a0,0(a4)
    80002bf8:	0ff57513          	andi	a0,a0,255
    80002bfc:	00813403          	ld	s0,8(sp)
    80002c00:	01010113          	addi	sp,sp,16
    80002c04:	00008067          	ret
    80002c08:	fff00513          	li	a0,-1
    80002c0c:	ff1ff06f          	j	80002bfc <uartgetc+0x24>

0000000080002c10 <uartintr>:
    80002c10:	100007b7          	lui	a5,0x10000
    80002c14:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002c18:	0017f793          	andi	a5,a5,1
    80002c1c:	0a078463          	beqz	a5,80002cc4 <uartintr+0xb4>
    80002c20:	fe010113          	addi	sp,sp,-32
    80002c24:	00813823          	sd	s0,16(sp)
    80002c28:	00913423          	sd	s1,8(sp)
    80002c2c:	00113c23          	sd	ra,24(sp)
    80002c30:	02010413          	addi	s0,sp,32
    80002c34:	100004b7          	lui	s1,0x10000
    80002c38:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002c3c:	0ff57513          	andi	a0,a0,255
    80002c40:	fffff097          	auipc	ra,0xfffff
    80002c44:	534080e7          	jalr	1332(ra) # 80002174 <consoleintr>
    80002c48:	0054c783          	lbu	a5,5(s1)
    80002c4c:	0017f793          	andi	a5,a5,1
    80002c50:	fe0794e3          	bnez	a5,80002c38 <uartintr+0x28>
    80002c54:	00002617          	auipc	a2,0x2
    80002c58:	81c60613          	addi	a2,a2,-2020 # 80004470 <uart_tx_r>
    80002c5c:	00002517          	auipc	a0,0x2
    80002c60:	81c50513          	addi	a0,a0,-2020 # 80004478 <uart_tx_w>
    80002c64:	00063783          	ld	a5,0(a2)
    80002c68:	00053703          	ld	a4,0(a0)
    80002c6c:	04f70263          	beq	a4,a5,80002cb0 <uartintr+0xa0>
    80002c70:	100005b7          	lui	a1,0x10000
    80002c74:	00003817          	auipc	a6,0x3
    80002c78:	a5c80813          	addi	a6,a6,-1444 # 800056d0 <uart_tx_buf>
    80002c7c:	01c0006f          	j	80002c98 <uartintr+0x88>
    80002c80:	0006c703          	lbu	a4,0(a3)
    80002c84:	00f63023          	sd	a5,0(a2)
    80002c88:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c8c:	00063783          	ld	a5,0(a2)
    80002c90:	00053703          	ld	a4,0(a0)
    80002c94:	00f70e63          	beq	a4,a5,80002cb0 <uartintr+0xa0>
    80002c98:	01f7f713          	andi	a4,a5,31
    80002c9c:	00e806b3          	add	a3,a6,a4
    80002ca0:	0055c703          	lbu	a4,5(a1)
    80002ca4:	00178793          	addi	a5,a5,1
    80002ca8:	02077713          	andi	a4,a4,32
    80002cac:	fc071ae3          	bnez	a4,80002c80 <uartintr+0x70>
    80002cb0:	01813083          	ld	ra,24(sp)
    80002cb4:	01013403          	ld	s0,16(sp)
    80002cb8:	00813483          	ld	s1,8(sp)
    80002cbc:	02010113          	addi	sp,sp,32
    80002cc0:	00008067          	ret
    80002cc4:	00001617          	auipc	a2,0x1
    80002cc8:	7ac60613          	addi	a2,a2,1964 # 80004470 <uart_tx_r>
    80002ccc:	00001517          	auipc	a0,0x1
    80002cd0:	7ac50513          	addi	a0,a0,1964 # 80004478 <uart_tx_w>
    80002cd4:	00063783          	ld	a5,0(a2)
    80002cd8:	00053703          	ld	a4,0(a0)
    80002cdc:	04f70263          	beq	a4,a5,80002d20 <uartintr+0x110>
    80002ce0:	100005b7          	lui	a1,0x10000
    80002ce4:	00003817          	auipc	a6,0x3
    80002ce8:	9ec80813          	addi	a6,a6,-1556 # 800056d0 <uart_tx_buf>
    80002cec:	01c0006f          	j	80002d08 <uartintr+0xf8>
    80002cf0:	0006c703          	lbu	a4,0(a3)
    80002cf4:	00f63023          	sd	a5,0(a2)
    80002cf8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002cfc:	00063783          	ld	a5,0(a2)
    80002d00:	00053703          	ld	a4,0(a0)
    80002d04:	02f70063          	beq	a4,a5,80002d24 <uartintr+0x114>
    80002d08:	01f7f713          	andi	a4,a5,31
    80002d0c:	00e806b3          	add	a3,a6,a4
    80002d10:	0055c703          	lbu	a4,5(a1)
    80002d14:	00178793          	addi	a5,a5,1
    80002d18:	02077713          	andi	a4,a4,32
    80002d1c:	fc071ae3          	bnez	a4,80002cf0 <uartintr+0xe0>
    80002d20:	00008067          	ret
    80002d24:	00008067          	ret

0000000080002d28 <kinit>:
    80002d28:	fc010113          	addi	sp,sp,-64
    80002d2c:	02913423          	sd	s1,40(sp)
    80002d30:	fffff7b7          	lui	a5,0xfffff
    80002d34:	00004497          	auipc	s1,0x4
    80002d38:	9bb48493          	addi	s1,s1,-1605 # 800066ef <end+0xfff>
    80002d3c:	02813823          	sd	s0,48(sp)
    80002d40:	01313c23          	sd	s3,24(sp)
    80002d44:	00f4f4b3          	and	s1,s1,a5
    80002d48:	02113c23          	sd	ra,56(sp)
    80002d4c:	03213023          	sd	s2,32(sp)
    80002d50:	01413823          	sd	s4,16(sp)
    80002d54:	01513423          	sd	s5,8(sp)
    80002d58:	04010413          	addi	s0,sp,64
    80002d5c:	000017b7          	lui	a5,0x1
    80002d60:	01100993          	li	s3,17
    80002d64:	00f487b3          	add	a5,s1,a5
    80002d68:	01b99993          	slli	s3,s3,0x1b
    80002d6c:	06f9e063          	bltu	s3,a5,80002dcc <kinit+0xa4>
    80002d70:	00003a97          	auipc	s5,0x3
    80002d74:	980a8a93          	addi	s5,s5,-1664 # 800056f0 <end>
    80002d78:	0754ec63          	bltu	s1,s5,80002df0 <kinit+0xc8>
    80002d7c:	0734fa63          	bgeu	s1,s3,80002df0 <kinit+0xc8>
    80002d80:	00088a37          	lui	s4,0x88
    80002d84:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002d88:	00001917          	auipc	s2,0x1
    80002d8c:	6f890913          	addi	s2,s2,1784 # 80004480 <kmem>
    80002d90:	00ca1a13          	slli	s4,s4,0xc
    80002d94:	0140006f          	j	80002da8 <kinit+0x80>
    80002d98:	000017b7          	lui	a5,0x1
    80002d9c:	00f484b3          	add	s1,s1,a5
    80002da0:	0554e863          	bltu	s1,s5,80002df0 <kinit+0xc8>
    80002da4:	0534f663          	bgeu	s1,s3,80002df0 <kinit+0xc8>
    80002da8:	00001637          	lui	a2,0x1
    80002dac:	00100593          	li	a1,1
    80002db0:	00048513          	mv	a0,s1
    80002db4:	00000097          	auipc	ra,0x0
    80002db8:	5e4080e7          	jalr	1508(ra) # 80003398 <__memset>
    80002dbc:	00093783          	ld	a5,0(s2)
    80002dc0:	00f4b023          	sd	a5,0(s1)
    80002dc4:	00993023          	sd	s1,0(s2)
    80002dc8:	fd4498e3          	bne	s1,s4,80002d98 <kinit+0x70>
    80002dcc:	03813083          	ld	ra,56(sp)
    80002dd0:	03013403          	ld	s0,48(sp)
    80002dd4:	02813483          	ld	s1,40(sp)
    80002dd8:	02013903          	ld	s2,32(sp)
    80002ddc:	01813983          	ld	s3,24(sp)
    80002de0:	01013a03          	ld	s4,16(sp)
    80002de4:	00813a83          	ld	s5,8(sp)
    80002de8:	04010113          	addi	sp,sp,64
    80002dec:	00008067          	ret
    80002df0:	00001517          	auipc	a0,0x1
    80002df4:	3b050513          	addi	a0,a0,944 # 800041a0 <digits+0x18>
    80002df8:	fffff097          	auipc	ra,0xfffff
    80002dfc:	4b4080e7          	jalr	1204(ra) # 800022ac <panic>

0000000080002e00 <freerange>:
    80002e00:	fc010113          	addi	sp,sp,-64
    80002e04:	000017b7          	lui	a5,0x1
    80002e08:	02913423          	sd	s1,40(sp)
    80002e0c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002e10:	009504b3          	add	s1,a0,s1
    80002e14:	fffff537          	lui	a0,0xfffff
    80002e18:	02813823          	sd	s0,48(sp)
    80002e1c:	02113c23          	sd	ra,56(sp)
    80002e20:	03213023          	sd	s2,32(sp)
    80002e24:	01313c23          	sd	s3,24(sp)
    80002e28:	01413823          	sd	s4,16(sp)
    80002e2c:	01513423          	sd	s5,8(sp)
    80002e30:	01613023          	sd	s6,0(sp)
    80002e34:	04010413          	addi	s0,sp,64
    80002e38:	00a4f4b3          	and	s1,s1,a0
    80002e3c:	00f487b3          	add	a5,s1,a5
    80002e40:	06f5e463          	bltu	a1,a5,80002ea8 <freerange+0xa8>
    80002e44:	00003a97          	auipc	s5,0x3
    80002e48:	8aca8a93          	addi	s5,s5,-1876 # 800056f0 <end>
    80002e4c:	0954e263          	bltu	s1,s5,80002ed0 <freerange+0xd0>
    80002e50:	01100993          	li	s3,17
    80002e54:	01b99993          	slli	s3,s3,0x1b
    80002e58:	0734fc63          	bgeu	s1,s3,80002ed0 <freerange+0xd0>
    80002e5c:	00058a13          	mv	s4,a1
    80002e60:	00001917          	auipc	s2,0x1
    80002e64:	62090913          	addi	s2,s2,1568 # 80004480 <kmem>
    80002e68:	00002b37          	lui	s6,0x2
    80002e6c:	0140006f          	j	80002e80 <freerange+0x80>
    80002e70:	000017b7          	lui	a5,0x1
    80002e74:	00f484b3          	add	s1,s1,a5
    80002e78:	0554ec63          	bltu	s1,s5,80002ed0 <freerange+0xd0>
    80002e7c:	0534fa63          	bgeu	s1,s3,80002ed0 <freerange+0xd0>
    80002e80:	00001637          	lui	a2,0x1
    80002e84:	00100593          	li	a1,1
    80002e88:	00048513          	mv	a0,s1
    80002e8c:	00000097          	auipc	ra,0x0
    80002e90:	50c080e7          	jalr	1292(ra) # 80003398 <__memset>
    80002e94:	00093703          	ld	a4,0(s2)
    80002e98:	016487b3          	add	a5,s1,s6
    80002e9c:	00e4b023          	sd	a4,0(s1)
    80002ea0:	00993023          	sd	s1,0(s2)
    80002ea4:	fcfa76e3          	bgeu	s4,a5,80002e70 <freerange+0x70>
    80002ea8:	03813083          	ld	ra,56(sp)
    80002eac:	03013403          	ld	s0,48(sp)
    80002eb0:	02813483          	ld	s1,40(sp)
    80002eb4:	02013903          	ld	s2,32(sp)
    80002eb8:	01813983          	ld	s3,24(sp)
    80002ebc:	01013a03          	ld	s4,16(sp)
    80002ec0:	00813a83          	ld	s5,8(sp)
    80002ec4:	00013b03          	ld	s6,0(sp)
    80002ec8:	04010113          	addi	sp,sp,64
    80002ecc:	00008067          	ret
    80002ed0:	00001517          	auipc	a0,0x1
    80002ed4:	2d050513          	addi	a0,a0,720 # 800041a0 <digits+0x18>
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	3d4080e7          	jalr	980(ra) # 800022ac <panic>

0000000080002ee0 <kfree>:
    80002ee0:	fe010113          	addi	sp,sp,-32
    80002ee4:	00813823          	sd	s0,16(sp)
    80002ee8:	00113c23          	sd	ra,24(sp)
    80002eec:	00913423          	sd	s1,8(sp)
    80002ef0:	02010413          	addi	s0,sp,32
    80002ef4:	03451793          	slli	a5,a0,0x34
    80002ef8:	04079c63          	bnez	a5,80002f50 <kfree+0x70>
    80002efc:	00002797          	auipc	a5,0x2
    80002f00:	7f478793          	addi	a5,a5,2036 # 800056f0 <end>
    80002f04:	00050493          	mv	s1,a0
    80002f08:	04f56463          	bltu	a0,a5,80002f50 <kfree+0x70>
    80002f0c:	01100793          	li	a5,17
    80002f10:	01b79793          	slli	a5,a5,0x1b
    80002f14:	02f57e63          	bgeu	a0,a5,80002f50 <kfree+0x70>
    80002f18:	00001637          	lui	a2,0x1
    80002f1c:	00100593          	li	a1,1
    80002f20:	00000097          	auipc	ra,0x0
    80002f24:	478080e7          	jalr	1144(ra) # 80003398 <__memset>
    80002f28:	00001797          	auipc	a5,0x1
    80002f2c:	55878793          	addi	a5,a5,1368 # 80004480 <kmem>
    80002f30:	0007b703          	ld	a4,0(a5)
    80002f34:	01813083          	ld	ra,24(sp)
    80002f38:	01013403          	ld	s0,16(sp)
    80002f3c:	00e4b023          	sd	a4,0(s1)
    80002f40:	0097b023          	sd	s1,0(a5)
    80002f44:	00813483          	ld	s1,8(sp)
    80002f48:	02010113          	addi	sp,sp,32
    80002f4c:	00008067          	ret
    80002f50:	00001517          	auipc	a0,0x1
    80002f54:	25050513          	addi	a0,a0,592 # 800041a0 <digits+0x18>
    80002f58:	fffff097          	auipc	ra,0xfffff
    80002f5c:	354080e7          	jalr	852(ra) # 800022ac <panic>

0000000080002f60 <kalloc>:
    80002f60:	fe010113          	addi	sp,sp,-32
    80002f64:	00813823          	sd	s0,16(sp)
    80002f68:	00913423          	sd	s1,8(sp)
    80002f6c:	00113c23          	sd	ra,24(sp)
    80002f70:	02010413          	addi	s0,sp,32
    80002f74:	00001797          	auipc	a5,0x1
    80002f78:	50c78793          	addi	a5,a5,1292 # 80004480 <kmem>
    80002f7c:	0007b483          	ld	s1,0(a5)
    80002f80:	02048063          	beqz	s1,80002fa0 <kalloc+0x40>
    80002f84:	0004b703          	ld	a4,0(s1)
    80002f88:	00001637          	lui	a2,0x1
    80002f8c:	00500593          	li	a1,5
    80002f90:	00048513          	mv	a0,s1
    80002f94:	00e7b023          	sd	a4,0(a5)
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	400080e7          	jalr	1024(ra) # 80003398 <__memset>
    80002fa0:	01813083          	ld	ra,24(sp)
    80002fa4:	01013403          	ld	s0,16(sp)
    80002fa8:	00048513          	mv	a0,s1
    80002fac:	00813483          	ld	s1,8(sp)
    80002fb0:	02010113          	addi	sp,sp,32
    80002fb4:	00008067          	ret

0000000080002fb8 <initlock>:
    80002fb8:	ff010113          	addi	sp,sp,-16
    80002fbc:	00813423          	sd	s0,8(sp)
    80002fc0:	01010413          	addi	s0,sp,16
    80002fc4:	00813403          	ld	s0,8(sp)
    80002fc8:	00b53423          	sd	a1,8(a0)
    80002fcc:	00052023          	sw	zero,0(a0)
    80002fd0:	00053823          	sd	zero,16(a0)
    80002fd4:	01010113          	addi	sp,sp,16
    80002fd8:	00008067          	ret

0000000080002fdc <acquire>:
    80002fdc:	fe010113          	addi	sp,sp,-32
    80002fe0:	00813823          	sd	s0,16(sp)
    80002fe4:	00913423          	sd	s1,8(sp)
    80002fe8:	00113c23          	sd	ra,24(sp)
    80002fec:	01213023          	sd	s2,0(sp)
    80002ff0:	02010413          	addi	s0,sp,32
    80002ff4:	00050493          	mv	s1,a0
    80002ff8:	10002973          	csrr	s2,sstatus
    80002ffc:	100027f3          	csrr	a5,sstatus
    80003000:	ffd7f793          	andi	a5,a5,-3
    80003004:	10079073          	csrw	sstatus,a5
    80003008:	fffff097          	auipc	ra,0xfffff
    8000300c:	8ec080e7          	jalr	-1812(ra) # 800018f4 <mycpu>
    80003010:	07852783          	lw	a5,120(a0)
    80003014:	06078e63          	beqz	a5,80003090 <acquire+0xb4>
    80003018:	fffff097          	auipc	ra,0xfffff
    8000301c:	8dc080e7          	jalr	-1828(ra) # 800018f4 <mycpu>
    80003020:	07852783          	lw	a5,120(a0)
    80003024:	0004a703          	lw	a4,0(s1)
    80003028:	0017879b          	addiw	a5,a5,1
    8000302c:	06f52c23          	sw	a5,120(a0)
    80003030:	04071063          	bnez	a4,80003070 <acquire+0x94>
    80003034:	00100713          	li	a4,1
    80003038:	00070793          	mv	a5,a4
    8000303c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003040:	0007879b          	sext.w	a5,a5
    80003044:	fe079ae3          	bnez	a5,80003038 <acquire+0x5c>
    80003048:	0ff0000f          	fence
    8000304c:	fffff097          	auipc	ra,0xfffff
    80003050:	8a8080e7          	jalr	-1880(ra) # 800018f4 <mycpu>
    80003054:	01813083          	ld	ra,24(sp)
    80003058:	01013403          	ld	s0,16(sp)
    8000305c:	00a4b823          	sd	a0,16(s1)
    80003060:	00013903          	ld	s2,0(sp)
    80003064:	00813483          	ld	s1,8(sp)
    80003068:	02010113          	addi	sp,sp,32
    8000306c:	00008067          	ret
    80003070:	0104b903          	ld	s2,16(s1)
    80003074:	fffff097          	auipc	ra,0xfffff
    80003078:	880080e7          	jalr	-1920(ra) # 800018f4 <mycpu>
    8000307c:	faa91ce3          	bne	s2,a0,80003034 <acquire+0x58>
    80003080:	00001517          	auipc	a0,0x1
    80003084:	12850513          	addi	a0,a0,296 # 800041a8 <digits+0x20>
    80003088:	fffff097          	auipc	ra,0xfffff
    8000308c:	224080e7          	jalr	548(ra) # 800022ac <panic>
    80003090:	00195913          	srli	s2,s2,0x1
    80003094:	fffff097          	auipc	ra,0xfffff
    80003098:	860080e7          	jalr	-1952(ra) # 800018f4 <mycpu>
    8000309c:	00197913          	andi	s2,s2,1
    800030a0:	07252e23          	sw	s2,124(a0)
    800030a4:	f75ff06f          	j	80003018 <acquire+0x3c>

00000000800030a8 <release>:
    800030a8:	fe010113          	addi	sp,sp,-32
    800030ac:	00813823          	sd	s0,16(sp)
    800030b0:	00113c23          	sd	ra,24(sp)
    800030b4:	00913423          	sd	s1,8(sp)
    800030b8:	01213023          	sd	s2,0(sp)
    800030bc:	02010413          	addi	s0,sp,32
    800030c0:	00052783          	lw	a5,0(a0)
    800030c4:	00079a63          	bnez	a5,800030d8 <release+0x30>
    800030c8:	00001517          	auipc	a0,0x1
    800030cc:	0e850513          	addi	a0,a0,232 # 800041b0 <digits+0x28>
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	1dc080e7          	jalr	476(ra) # 800022ac <panic>
    800030d8:	01053903          	ld	s2,16(a0)
    800030dc:	00050493          	mv	s1,a0
    800030e0:	fffff097          	auipc	ra,0xfffff
    800030e4:	814080e7          	jalr	-2028(ra) # 800018f4 <mycpu>
    800030e8:	fea910e3          	bne	s2,a0,800030c8 <release+0x20>
    800030ec:	0004b823          	sd	zero,16(s1)
    800030f0:	0ff0000f          	fence
    800030f4:	0f50000f          	fence	iorw,ow
    800030f8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800030fc:	ffffe097          	auipc	ra,0xffffe
    80003100:	7f8080e7          	jalr	2040(ra) # 800018f4 <mycpu>
    80003104:	100027f3          	csrr	a5,sstatus
    80003108:	0027f793          	andi	a5,a5,2
    8000310c:	04079a63          	bnez	a5,80003160 <release+0xb8>
    80003110:	07852783          	lw	a5,120(a0)
    80003114:	02f05e63          	blez	a5,80003150 <release+0xa8>
    80003118:	fff7871b          	addiw	a4,a5,-1
    8000311c:	06e52c23          	sw	a4,120(a0)
    80003120:	00071c63          	bnez	a4,80003138 <release+0x90>
    80003124:	07c52783          	lw	a5,124(a0)
    80003128:	00078863          	beqz	a5,80003138 <release+0x90>
    8000312c:	100027f3          	csrr	a5,sstatus
    80003130:	0027e793          	ori	a5,a5,2
    80003134:	10079073          	csrw	sstatus,a5
    80003138:	01813083          	ld	ra,24(sp)
    8000313c:	01013403          	ld	s0,16(sp)
    80003140:	00813483          	ld	s1,8(sp)
    80003144:	00013903          	ld	s2,0(sp)
    80003148:	02010113          	addi	sp,sp,32
    8000314c:	00008067          	ret
    80003150:	00001517          	auipc	a0,0x1
    80003154:	08050513          	addi	a0,a0,128 # 800041d0 <digits+0x48>
    80003158:	fffff097          	auipc	ra,0xfffff
    8000315c:	154080e7          	jalr	340(ra) # 800022ac <panic>
    80003160:	00001517          	auipc	a0,0x1
    80003164:	05850513          	addi	a0,a0,88 # 800041b8 <digits+0x30>
    80003168:	fffff097          	auipc	ra,0xfffff
    8000316c:	144080e7          	jalr	324(ra) # 800022ac <panic>

0000000080003170 <holding>:
    80003170:	00052783          	lw	a5,0(a0)
    80003174:	00079663          	bnez	a5,80003180 <holding+0x10>
    80003178:	00000513          	li	a0,0
    8000317c:	00008067          	ret
    80003180:	fe010113          	addi	sp,sp,-32
    80003184:	00813823          	sd	s0,16(sp)
    80003188:	00913423          	sd	s1,8(sp)
    8000318c:	00113c23          	sd	ra,24(sp)
    80003190:	02010413          	addi	s0,sp,32
    80003194:	01053483          	ld	s1,16(a0)
    80003198:	ffffe097          	auipc	ra,0xffffe
    8000319c:	75c080e7          	jalr	1884(ra) # 800018f4 <mycpu>
    800031a0:	01813083          	ld	ra,24(sp)
    800031a4:	01013403          	ld	s0,16(sp)
    800031a8:	40a48533          	sub	a0,s1,a0
    800031ac:	00153513          	seqz	a0,a0
    800031b0:	00813483          	ld	s1,8(sp)
    800031b4:	02010113          	addi	sp,sp,32
    800031b8:	00008067          	ret

00000000800031bc <push_off>:
    800031bc:	fe010113          	addi	sp,sp,-32
    800031c0:	00813823          	sd	s0,16(sp)
    800031c4:	00113c23          	sd	ra,24(sp)
    800031c8:	00913423          	sd	s1,8(sp)
    800031cc:	02010413          	addi	s0,sp,32
    800031d0:	100024f3          	csrr	s1,sstatus
    800031d4:	100027f3          	csrr	a5,sstatus
    800031d8:	ffd7f793          	andi	a5,a5,-3
    800031dc:	10079073          	csrw	sstatus,a5
    800031e0:	ffffe097          	auipc	ra,0xffffe
    800031e4:	714080e7          	jalr	1812(ra) # 800018f4 <mycpu>
    800031e8:	07852783          	lw	a5,120(a0)
    800031ec:	02078663          	beqz	a5,80003218 <push_off+0x5c>
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	704080e7          	jalr	1796(ra) # 800018f4 <mycpu>
    800031f8:	07852783          	lw	a5,120(a0)
    800031fc:	01813083          	ld	ra,24(sp)
    80003200:	01013403          	ld	s0,16(sp)
    80003204:	0017879b          	addiw	a5,a5,1
    80003208:	06f52c23          	sw	a5,120(a0)
    8000320c:	00813483          	ld	s1,8(sp)
    80003210:	02010113          	addi	sp,sp,32
    80003214:	00008067          	ret
    80003218:	0014d493          	srli	s1,s1,0x1
    8000321c:	ffffe097          	auipc	ra,0xffffe
    80003220:	6d8080e7          	jalr	1752(ra) # 800018f4 <mycpu>
    80003224:	0014f493          	andi	s1,s1,1
    80003228:	06952e23          	sw	s1,124(a0)
    8000322c:	fc5ff06f          	j	800031f0 <push_off+0x34>

0000000080003230 <pop_off>:
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00813023          	sd	s0,0(sp)
    80003238:	00113423          	sd	ra,8(sp)
    8000323c:	01010413          	addi	s0,sp,16
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	6b4080e7          	jalr	1716(ra) # 800018f4 <mycpu>
    80003248:	100027f3          	csrr	a5,sstatus
    8000324c:	0027f793          	andi	a5,a5,2
    80003250:	04079663          	bnez	a5,8000329c <pop_off+0x6c>
    80003254:	07852783          	lw	a5,120(a0)
    80003258:	02f05a63          	blez	a5,8000328c <pop_off+0x5c>
    8000325c:	fff7871b          	addiw	a4,a5,-1
    80003260:	06e52c23          	sw	a4,120(a0)
    80003264:	00071c63          	bnez	a4,8000327c <pop_off+0x4c>
    80003268:	07c52783          	lw	a5,124(a0)
    8000326c:	00078863          	beqz	a5,8000327c <pop_off+0x4c>
    80003270:	100027f3          	csrr	a5,sstatus
    80003274:	0027e793          	ori	a5,a5,2
    80003278:	10079073          	csrw	sstatus,a5
    8000327c:	00813083          	ld	ra,8(sp)
    80003280:	00013403          	ld	s0,0(sp)
    80003284:	01010113          	addi	sp,sp,16
    80003288:	00008067          	ret
    8000328c:	00001517          	auipc	a0,0x1
    80003290:	f4450513          	addi	a0,a0,-188 # 800041d0 <digits+0x48>
    80003294:	fffff097          	auipc	ra,0xfffff
    80003298:	018080e7          	jalr	24(ra) # 800022ac <panic>
    8000329c:	00001517          	auipc	a0,0x1
    800032a0:	f1c50513          	addi	a0,a0,-228 # 800041b8 <digits+0x30>
    800032a4:	fffff097          	auipc	ra,0xfffff
    800032a8:	008080e7          	jalr	8(ra) # 800022ac <panic>

00000000800032ac <push_on>:
    800032ac:	fe010113          	addi	sp,sp,-32
    800032b0:	00813823          	sd	s0,16(sp)
    800032b4:	00113c23          	sd	ra,24(sp)
    800032b8:	00913423          	sd	s1,8(sp)
    800032bc:	02010413          	addi	s0,sp,32
    800032c0:	100024f3          	csrr	s1,sstatus
    800032c4:	100027f3          	csrr	a5,sstatus
    800032c8:	0027e793          	ori	a5,a5,2
    800032cc:	10079073          	csrw	sstatus,a5
    800032d0:	ffffe097          	auipc	ra,0xffffe
    800032d4:	624080e7          	jalr	1572(ra) # 800018f4 <mycpu>
    800032d8:	07852783          	lw	a5,120(a0)
    800032dc:	02078663          	beqz	a5,80003308 <push_on+0x5c>
    800032e0:	ffffe097          	auipc	ra,0xffffe
    800032e4:	614080e7          	jalr	1556(ra) # 800018f4 <mycpu>
    800032e8:	07852783          	lw	a5,120(a0)
    800032ec:	01813083          	ld	ra,24(sp)
    800032f0:	01013403          	ld	s0,16(sp)
    800032f4:	0017879b          	addiw	a5,a5,1
    800032f8:	06f52c23          	sw	a5,120(a0)
    800032fc:	00813483          	ld	s1,8(sp)
    80003300:	02010113          	addi	sp,sp,32
    80003304:	00008067          	ret
    80003308:	0014d493          	srli	s1,s1,0x1
    8000330c:	ffffe097          	auipc	ra,0xffffe
    80003310:	5e8080e7          	jalr	1512(ra) # 800018f4 <mycpu>
    80003314:	0014f493          	andi	s1,s1,1
    80003318:	06952e23          	sw	s1,124(a0)
    8000331c:	fc5ff06f          	j	800032e0 <push_on+0x34>

0000000080003320 <pop_on>:
    80003320:	ff010113          	addi	sp,sp,-16
    80003324:	00813023          	sd	s0,0(sp)
    80003328:	00113423          	sd	ra,8(sp)
    8000332c:	01010413          	addi	s0,sp,16
    80003330:	ffffe097          	auipc	ra,0xffffe
    80003334:	5c4080e7          	jalr	1476(ra) # 800018f4 <mycpu>
    80003338:	100027f3          	csrr	a5,sstatus
    8000333c:	0027f793          	andi	a5,a5,2
    80003340:	04078463          	beqz	a5,80003388 <pop_on+0x68>
    80003344:	07852783          	lw	a5,120(a0)
    80003348:	02f05863          	blez	a5,80003378 <pop_on+0x58>
    8000334c:	fff7879b          	addiw	a5,a5,-1
    80003350:	06f52c23          	sw	a5,120(a0)
    80003354:	07853783          	ld	a5,120(a0)
    80003358:	00079863          	bnez	a5,80003368 <pop_on+0x48>
    8000335c:	100027f3          	csrr	a5,sstatus
    80003360:	ffd7f793          	andi	a5,a5,-3
    80003364:	10079073          	csrw	sstatus,a5
    80003368:	00813083          	ld	ra,8(sp)
    8000336c:	00013403          	ld	s0,0(sp)
    80003370:	01010113          	addi	sp,sp,16
    80003374:	00008067          	ret
    80003378:	00001517          	auipc	a0,0x1
    8000337c:	e8050513          	addi	a0,a0,-384 # 800041f8 <digits+0x70>
    80003380:	fffff097          	auipc	ra,0xfffff
    80003384:	f2c080e7          	jalr	-212(ra) # 800022ac <panic>
    80003388:	00001517          	auipc	a0,0x1
    8000338c:	e5050513          	addi	a0,a0,-432 # 800041d8 <digits+0x50>
    80003390:	fffff097          	auipc	ra,0xfffff
    80003394:	f1c080e7          	jalr	-228(ra) # 800022ac <panic>

0000000080003398 <__memset>:
    80003398:	ff010113          	addi	sp,sp,-16
    8000339c:	00813423          	sd	s0,8(sp)
    800033a0:	01010413          	addi	s0,sp,16
    800033a4:	1a060e63          	beqz	a2,80003560 <__memset+0x1c8>
    800033a8:	40a007b3          	neg	a5,a0
    800033ac:	0077f793          	andi	a5,a5,7
    800033b0:	00778693          	addi	a3,a5,7
    800033b4:	00b00813          	li	a6,11
    800033b8:	0ff5f593          	andi	a1,a1,255
    800033bc:	fff6071b          	addiw	a4,a2,-1
    800033c0:	1b06e663          	bltu	a3,a6,8000356c <__memset+0x1d4>
    800033c4:	1cd76463          	bltu	a4,a3,8000358c <__memset+0x1f4>
    800033c8:	1a078e63          	beqz	a5,80003584 <__memset+0x1ec>
    800033cc:	00b50023          	sb	a1,0(a0)
    800033d0:	00100713          	li	a4,1
    800033d4:	1ae78463          	beq	a5,a4,8000357c <__memset+0x1e4>
    800033d8:	00b500a3          	sb	a1,1(a0)
    800033dc:	00200713          	li	a4,2
    800033e0:	1ae78a63          	beq	a5,a4,80003594 <__memset+0x1fc>
    800033e4:	00b50123          	sb	a1,2(a0)
    800033e8:	00300713          	li	a4,3
    800033ec:	18e78463          	beq	a5,a4,80003574 <__memset+0x1dc>
    800033f0:	00b501a3          	sb	a1,3(a0)
    800033f4:	00400713          	li	a4,4
    800033f8:	1ae78263          	beq	a5,a4,8000359c <__memset+0x204>
    800033fc:	00b50223          	sb	a1,4(a0)
    80003400:	00500713          	li	a4,5
    80003404:	1ae78063          	beq	a5,a4,800035a4 <__memset+0x20c>
    80003408:	00b502a3          	sb	a1,5(a0)
    8000340c:	00700713          	li	a4,7
    80003410:	18e79e63          	bne	a5,a4,800035ac <__memset+0x214>
    80003414:	00b50323          	sb	a1,6(a0)
    80003418:	00700e93          	li	t4,7
    8000341c:	00859713          	slli	a4,a1,0x8
    80003420:	00e5e733          	or	a4,a1,a4
    80003424:	01059e13          	slli	t3,a1,0x10
    80003428:	01c76e33          	or	t3,a4,t3
    8000342c:	01859313          	slli	t1,a1,0x18
    80003430:	006e6333          	or	t1,t3,t1
    80003434:	02059893          	slli	a7,a1,0x20
    80003438:	40f60e3b          	subw	t3,a2,a5
    8000343c:	011368b3          	or	a7,t1,a7
    80003440:	02859813          	slli	a6,a1,0x28
    80003444:	0108e833          	or	a6,a7,a6
    80003448:	03059693          	slli	a3,a1,0x30
    8000344c:	003e589b          	srliw	a7,t3,0x3
    80003450:	00d866b3          	or	a3,a6,a3
    80003454:	03859713          	slli	a4,a1,0x38
    80003458:	00389813          	slli	a6,a7,0x3
    8000345c:	00f507b3          	add	a5,a0,a5
    80003460:	00e6e733          	or	a4,a3,a4
    80003464:	000e089b          	sext.w	a7,t3
    80003468:	00f806b3          	add	a3,a6,a5
    8000346c:	00e7b023          	sd	a4,0(a5)
    80003470:	00878793          	addi	a5,a5,8
    80003474:	fed79ce3          	bne	a5,a3,8000346c <__memset+0xd4>
    80003478:	ff8e7793          	andi	a5,t3,-8
    8000347c:	0007871b          	sext.w	a4,a5
    80003480:	01d787bb          	addw	a5,a5,t4
    80003484:	0ce88e63          	beq	a7,a4,80003560 <__memset+0x1c8>
    80003488:	00f50733          	add	a4,a0,a5
    8000348c:	00b70023          	sb	a1,0(a4)
    80003490:	0017871b          	addiw	a4,a5,1
    80003494:	0cc77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003498:	00e50733          	add	a4,a0,a4
    8000349c:	00b70023          	sb	a1,0(a4)
    800034a0:	0027871b          	addiw	a4,a5,2
    800034a4:	0ac77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034a8:	00e50733          	add	a4,a0,a4
    800034ac:	00b70023          	sb	a1,0(a4)
    800034b0:	0037871b          	addiw	a4,a5,3
    800034b4:	0ac77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034b8:	00e50733          	add	a4,a0,a4
    800034bc:	00b70023          	sb	a1,0(a4)
    800034c0:	0047871b          	addiw	a4,a5,4
    800034c4:	08c77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034c8:	00e50733          	add	a4,a0,a4
    800034cc:	00b70023          	sb	a1,0(a4)
    800034d0:	0057871b          	addiw	a4,a5,5
    800034d4:	08c77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034d8:	00e50733          	add	a4,a0,a4
    800034dc:	00b70023          	sb	a1,0(a4)
    800034e0:	0067871b          	addiw	a4,a5,6
    800034e4:	06c77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034e8:	00e50733          	add	a4,a0,a4
    800034ec:	00b70023          	sb	a1,0(a4)
    800034f0:	0077871b          	addiw	a4,a5,7
    800034f4:	06c77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    800034f8:	00e50733          	add	a4,a0,a4
    800034fc:	00b70023          	sb	a1,0(a4)
    80003500:	0087871b          	addiw	a4,a5,8
    80003504:	04c77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003508:	00e50733          	add	a4,a0,a4
    8000350c:	00b70023          	sb	a1,0(a4)
    80003510:	0097871b          	addiw	a4,a5,9
    80003514:	04c77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003518:	00e50733          	add	a4,a0,a4
    8000351c:	00b70023          	sb	a1,0(a4)
    80003520:	00a7871b          	addiw	a4,a5,10
    80003524:	02c77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003528:	00e50733          	add	a4,a0,a4
    8000352c:	00b70023          	sb	a1,0(a4)
    80003530:	00b7871b          	addiw	a4,a5,11
    80003534:	02c77663          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003538:	00e50733          	add	a4,a0,a4
    8000353c:	00b70023          	sb	a1,0(a4)
    80003540:	00c7871b          	addiw	a4,a5,12
    80003544:	00c77e63          	bgeu	a4,a2,80003560 <__memset+0x1c8>
    80003548:	00e50733          	add	a4,a0,a4
    8000354c:	00b70023          	sb	a1,0(a4)
    80003550:	00d7879b          	addiw	a5,a5,13
    80003554:	00c7f663          	bgeu	a5,a2,80003560 <__memset+0x1c8>
    80003558:	00f507b3          	add	a5,a0,a5
    8000355c:	00b78023          	sb	a1,0(a5)
    80003560:	00813403          	ld	s0,8(sp)
    80003564:	01010113          	addi	sp,sp,16
    80003568:	00008067          	ret
    8000356c:	00b00693          	li	a3,11
    80003570:	e55ff06f          	j	800033c4 <__memset+0x2c>
    80003574:	00300e93          	li	t4,3
    80003578:	ea5ff06f          	j	8000341c <__memset+0x84>
    8000357c:	00100e93          	li	t4,1
    80003580:	e9dff06f          	j	8000341c <__memset+0x84>
    80003584:	00000e93          	li	t4,0
    80003588:	e95ff06f          	j	8000341c <__memset+0x84>
    8000358c:	00000793          	li	a5,0
    80003590:	ef9ff06f          	j	80003488 <__memset+0xf0>
    80003594:	00200e93          	li	t4,2
    80003598:	e85ff06f          	j	8000341c <__memset+0x84>
    8000359c:	00400e93          	li	t4,4
    800035a0:	e7dff06f          	j	8000341c <__memset+0x84>
    800035a4:	00500e93          	li	t4,5
    800035a8:	e75ff06f          	j	8000341c <__memset+0x84>
    800035ac:	00600e93          	li	t4,6
    800035b0:	e6dff06f          	j	8000341c <__memset+0x84>

00000000800035b4 <__memmove>:
    800035b4:	ff010113          	addi	sp,sp,-16
    800035b8:	00813423          	sd	s0,8(sp)
    800035bc:	01010413          	addi	s0,sp,16
    800035c0:	0e060863          	beqz	a2,800036b0 <__memmove+0xfc>
    800035c4:	fff6069b          	addiw	a3,a2,-1
    800035c8:	0006881b          	sext.w	a6,a3
    800035cc:	0ea5e863          	bltu	a1,a0,800036bc <__memmove+0x108>
    800035d0:	00758713          	addi	a4,a1,7
    800035d4:	00a5e7b3          	or	a5,a1,a0
    800035d8:	40a70733          	sub	a4,a4,a0
    800035dc:	0077f793          	andi	a5,a5,7
    800035e0:	00f73713          	sltiu	a4,a4,15
    800035e4:	00174713          	xori	a4,a4,1
    800035e8:	0017b793          	seqz	a5,a5
    800035ec:	00e7f7b3          	and	a5,a5,a4
    800035f0:	10078863          	beqz	a5,80003700 <__memmove+0x14c>
    800035f4:	00900793          	li	a5,9
    800035f8:	1107f463          	bgeu	a5,a6,80003700 <__memmove+0x14c>
    800035fc:	0036581b          	srliw	a6,a2,0x3
    80003600:	fff8081b          	addiw	a6,a6,-1
    80003604:	02081813          	slli	a6,a6,0x20
    80003608:	01d85893          	srli	a7,a6,0x1d
    8000360c:	00858813          	addi	a6,a1,8
    80003610:	00058793          	mv	a5,a1
    80003614:	00050713          	mv	a4,a0
    80003618:	01088833          	add	a6,a7,a6
    8000361c:	0007b883          	ld	a7,0(a5)
    80003620:	00878793          	addi	a5,a5,8
    80003624:	00870713          	addi	a4,a4,8
    80003628:	ff173c23          	sd	a7,-8(a4)
    8000362c:	ff0798e3          	bne	a5,a6,8000361c <__memmove+0x68>
    80003630:	ff867713          	andi	a4,a2,-8
    80003634:	02071793          	slli	a5,a4,0x20
    80003638:	0207d793          	srli	a5,a5,0x20
    8000363c:	00f585b3          	add	a1,a1,a5
    80003640:	40e686bb          	subw	a3,a3,a4
    80003644:	00f507b3          	add	a5,a0,a5
    80003648:	06e60463          	beq	a2,a4,800036b0 <__memmove+0xfc>
    8000364c:	0005c703          	lbu	a4,0(a1)
    80003650:	00e78023          	sb	a4,0(a5)
    80003654:	04068e63          	beqz	a3,800036b0 <__memmove+0xfc>
    80003658:	0015c603          	lbu	a2,1(a1)
    8000365c:	00100713          	li	a4,1
    80003660:	00c780a3          	sb	a2,1(a5)
    80003664:	04e68663          	beq	a3,a4,800036b0 <__memmove+0xfc>
    80003668:	0025c603          	lbu	a2,2(a1)
    8000366c:	00200713          	li	a4,2
    80003670:	00c78123          	sb	a2,2(a5)
    80003674:	02e68e63          	beq	a3,a4,800036b0 <__memmove+0xfc>
    80003678:	0035c603          	lbu	a2,3(a1)
    8000367c:	00300713          	li	a4,3
    80003680:	00c781a3          	sb	a2,3(a5)
    80003684:	02e68663          	beq	a3,a4,800036b0 <__memmove+0xfc>
    80003688:	0045c603          	lbu	a2,4(a1)
    8000368c:	00400713          	li	a4,4
    80003690:	00c78223          	sb	a2,4(a5)
    80003694:	00e68e63          	beq	a3,a4,800036b0 <__memmove+0xfc>
    80003698:	0055c603          	lbu	a2,5(a1)
    8000369c:	00500713          	li	a4,5
    800036a0:	00c782a3          	sb	a2,5(a5)
    800036a4:	00e68663          	beq	a3,a4,800036b0 <__memmove+0xfc>
    800036a8:	0065c703          	lbu	a4,6(a1)
    800036ac:	00e78323          	sb	a4,6(a5)
    800036b0:	00813403          	ld	s0,8(sp)
    800036b4:	01010113          	addi	sp,sp,16
    800036b8:	00008067          	ret
    800036bc:	02061713          	slli	a4,a2,0x20
    800036c0:	02075713          	srli	a4,a4,0x20
    800036c4:	00e587b3          	add	a5,a1,a4
    800036c8:	f0f574e3          	bgeu	a0,a5,800035d0 <__memmove+0x1c>
    800036cc:	02069613          	slli	a2,a3,0x20
    800036d0:	02065613          	srli	a2,a2,0x20
    800036d4:	fff64613          	not	a2,a2
    800036d8:	00e50733          	add	a4,a0,a4
    800036dc:	00c78633          	add	a2,a5,a2
    800036e0:	fff7c683          	lbu	a3,-1(a5)
    800036e4:	fff78793          	addi	a5,a5,-1
    800036e8:	fff70713          	addi	a4,a4,-1
    800036ec:	00d70023          	sb	a3,0(a4)
    800036f0:	fec798e3          	bne	a5,a2,800036e0 <__memmove+0x12c>
    800036f4:	00813403          	ld	s0,8(sp)
    800036f8:	01010113          	addi	sp,sp,16
    800036fc:	00008067          	ret
    80003700:	02069713          	slli	a4,a3,0x20
    80003704:	02075713          	srli	a4,a4,0x20
    80003708:	00170713          	addi	a4,a4,1
    8000370c:	00e50733          	add	a4,a0,a4
    80003710:	00050793          	mv	a5,a0
    80003714:	0005c683          	lbu	a3,0(a1)
    80003718:	00178793          	addi	a5,a5,1
    8000371c:	00158593          	addi	a1,a1,1
    80003720:	fed78fa3          	sb	a3,-1(a5)
    80003724:	fee798e3          	bne	a5,a4,80003714 <__memmove+0x160>
    80003728:	f89ff06f          	j	800036b0 <__memmove+0xfc>

000000008000372c <__putc>:
    8000372c:	fe010113          	addi	sp,sp,-32
    80003730:	00813823          	sd	s0,16(sp)
    80003734:	00113c23          	sd	ra,24(sp)
    80003738:	02010413          	addi	s0,sp,32
    8000373c:	00050793          	mv	a5,a0
    80003740:	fef40593          	addi	a1,s0,-17
    80003744:	00100613          	li	a2,1
    80003748:	00000513          	li	a0,0
    8000374c:	fef407a3          	sb	a5,-17(s0)
    80003750:	fffff097          	auipc	ra,0xfffff
    80003754:	b3c080e7          	jalr	-1220(ra) # 8000228c <console_write>
    80003758:	01813083          	ld	ra,24(sp)
    8000375c:	01013403          	ld	s0,16(sp)
    80003760:	02010113          	addi	sp,sp,32
    80003764:	00008067          	ret

0000000080003768 <__getc>:
    80003768:	fe010113          	addi	sp,sp,-32
    8000376c:	00813823          	sd	s0,16(sp)
    80003770:	00113c23          	sd	ra,24(sp)
    80003774:	02010413          	addi	s0,sp,32
    80003778:	fe840593          	addi	a1,s0,-24
    8000377c:	00100613          	li	a2,1
    80003780:	00000513          	li	a0,0
    80003784:	fffff097          	auipc	ra,0xfffff
    80003788:	ae8080e7          	jalr	-1304(ra) # 8000226c <console_read>
    8000378c:	fe844503          	lbu	a0,-24(s0)
    80003790:	01813083          	ld	ra,24(sp)
    80003794:	01013403          	ld	s0,16(sp)
    80003798:	02010113          	addi	sp,sp,32
    8000379c:	00008067          	ret

00000000800037a0 <console_handler>:
    800037a0:	fe010113          	addi	sp,sp,-32
    800037a4:	00813823          	sd	s0,16(sp)
    800037a8:	00113c23          	sd	ra,24(sp)
    800037ac:	00913423          	sd	s1,8(sp)
    800037b0:	02010413          	addi	s0,sp,32
    800037b4:	14202773          	csrr	a4,scause
    800037b8:	100027f3          	csrr	a5,sstatus
    800037bc:	0027f793          	andi	a5,a5,2
    800037c0:	06079e63          	bnez	a5,8000383c <console_handler+0x9c>
    800037c4:	00074c63          	bltz	a4,800037dc <console_handler+0x3c>
    800037c8:	01813083          	ld	ra,24(sp)
    800037cc:	01013403          	ld	s0,16(sp)
    800037d0:	00813483          	ld	s1,8(sp)
    800037d4:	02010113          	addi	sp,sp,32
    800037d8:	00008067          	ret
    800037dc:	0ff77713          	andi	a4,a4,255
    800037e0:	00900793          	li	a5,9
    800037e4:	fef712e3          	bne	a4,a5,800037c8 <console_handler+0x28>
    800037e8:	ffffe097          	auipc	ra,0xffffe
    800037ec:	6dc080e7          	jalr	1756(ra) # 80001ec4 <plic_claim>
    800037f0:	00a00793          	li	a5,10
    800037f4:	00050493          	mv	s1,a0
    800037f8:	02f50c63          	beq	a0,a5,80003830 <console_handler+0x90>
    800037fc:	fc0506e3          	beqz	a0,800037c8 <console_handler+0x28>
    80003800:	00050593          	mv	a1,a0
    80003804:	00001517          	auipc	a0,0x1
    80003808:	8fc50513          	addi	a0,a0,-1796 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    8000380c:	fffff097          	auipc	ra,0xfffff
    80003810:	afc080e7          	jalr	-1284(ra) # 80002308 <__printf>
    80003814:	01013403          	ld	s0,16(sp)
    80003818:	01813083          	ld	ra,24(sp)
    8000381c:	00048513          	mv	a0,s1
    80003820:	00813483          	ld	s1,8(sp)
    80003824:	02010113          	addi	sp,sp,32
    80003828:	ffffe317          	auipc	t1,0xffffe
    8000382c:	6d430067          	jr	1748(t1) # 80001efc <plic_complete>
    80003830:	fffff097          	auipc	ra,0xfffff
    80003834:	3e0080e7          	jalr	992(ra) # 80002c10 <uartintr>
    80003838:	fddff06f          	j	80003814 <console_handler+0x74>
    8000383c:	00001517          	auipc	a0,0x1
    80003840:	9c450513          	addi	a0,a0,-1596 # 80004200 <digits+0x78>
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	a68080e7          	jalr	-1432(ra) # 800022ac <panic>
	...
