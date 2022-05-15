
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
    8000001c:	644010ef          	jal	ra,80001660 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt>:
.extern interruptHandler
.align 4
.global interrupt
interrupt:
    call interruptHandler
    80001000:	03c000ef          	jal	ra,8000103c <interruptHandler>
    80001004:	10200073          	sret
	...

0000000080001010 <_Z13callInterruptv>:
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.h"

extern "C" void* interrupt(); // u interrupt treba dodati i cuvanje konteksta
// prelazak u sistemski rezim i prelazak na sistemsku funkciju zadatu u registru stvec(asemblerska funkcija interrupt)
void* callInterrupt() {
    80001010:	ff010113          	addi	sp,sp,-16
    80001014:	00813423          	sd	s0,8(sp)
    80001018:	01010413          	addi	s0,sp,16
    asm volatile("csrw stvec, %0" : : "r" (&interrupt));
    8000101c:	00003797          	auipc	a5,0x3
    80001020:	4247b783          	ld	a5,1060(a5) # 80004440 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001024:	10579073          	csrw	stvec,a5
    asm volatile("ecall");
    80001028:	00000073          	ecall

    void* res;
    asm volatile("mv %0, a0" : "=r" (res));
    8000102c:	00050513          	mv	a0,a0
    return res;
}
    80001030:	00813403          	ld	s0,8(sp)
    80001034:	01010113          	addi	sp,sp,16
    80001038:	00008067          	ret

000000008000103c <interruptHandler>:

extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    uint64 scause;
    asm volatile("csrr %0, scause" : "=r" (scause)); // citanje vrednosti scause
    8000103c:	14202773          	csrr	a4,scause
    if(scause == 8) { // sistemski poziv iz korisnickog rezima
    80001040:	00800793          	li	a5,8
    80001044:	06f71063          	bne	a4,a5,800010a4 <interruptHandler+0x68>
extern "C" void* interruptHandler() { // extern C da kompajler ne bi menjao ime funkcije
    80001048:	ff010113          	addi	sp,sp,-16
    8000104c:	00113423          	sd	ra,8(sp)
    80001050:	00813023          	sd	s0,0(sp)
    80001054:	01010413          	addi	s0,sp,16
        uint64 code;
        asm volatile("mv %0, a0" : "=r" (code));
    80001058:	00050793          	mv	a5,a0
        switch(code) {
    8000105c:	00100713          	li	a4,1
    80001060:	02e78063          	beq	a5,a4,80001080 <interruptHandler+0x44>
    80001064:	00200713          	li	a4,2
    80001068:	02e78663          	beq	a5,a4,80001094 <interruptHandler+0x58>
    8000106c:	00000513          	li	a0,0
                return nullptr;
        }
    }

    return nullptr;
}
    80001070:	00813083          	ld	ra,8(sp)
    80001074:	00013403          	ld	s0,0(sp)
    80001078:	01010113          	addi	sp,sp,16
    8000107c:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (size));
    80001080:	00058513          	mv	a0,a1
                return MemoryAllocator::mem_alloc(size);
    80001084:	00651513          	slli	a0,a0,0x6
    80001088:	00000097          	auipc	ra,0x0
    8000108c:	1e8080e7          	jalr	488(ra) # 80001270 <_ZN15MemoryAllocator9mem_allocEm>
    80001090:	fe1ff06f          	j	80001070 <interruptHandler+0x34>
                asm volatile("mv %0, a1" : "=r" (memSegment));
    80001094:	00058513          	mv	a0,a1
                return (void*)((uint64)MemoryAllocator::mem_free(memSegment));
    80001098:	00000097          	auipc	ra,0x0
    8000109c:	348080e7          	jalr	840(ra) # 800013e0 <_ZN15MemoryAllocator8mem_freeEPv>
    800010a0:	fd1ff06f          	j	80001070 <interruptHandler+0x34>
    return nullptr;
    800010a4:	00000513          	li	a0,0
}
    800010a8:	00008067          	ret

00000000800010ac <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    800010ac:	ff010113          	addi	sp,sp,-16
    800010b0:	00113423          	sd	ra,8(sp)
    800010b4:	00813023          	sd	s0,0(sp)
    800010b8:	01010413          	addi	s0,sp,16
        BAD_POINTER = -1 // nije koriscen pokazviac iz mem_alloc
    };

    // Vraca minimalan potreban broj blokova za alokaciju memorije velicine size bajtova
    static inline size_t sizeInBlocks(size_t size) {
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    800010bc:	00655793          	srli	a5,a0,0x6
    800010c0:	03f57513          	andi	a0,a0,63
    800010c4:	00a03533          	snez	a0,a0
    800010c8:	00a78533          	add	a0,a5,a0
    uint64 code = 0x01; // kod sistemskog poziva
    // size je dat u bajtovima, a mi treba da ga prebacimo u blokove i onda opet upisemo u a1
    size = MemoryAllocator::sizeInBlocks(size); // funkcija menja a0
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    800010cc:	00100793          	li	a5,1
    800010d0:	00078513          	mv	a0,a5
    asm volatile("mv a1, %0" : : "r" (size)); // a1 = size
    800010d4:	00050593          	mv	a1,a0

    return (void*)callInterrupt();
    800010d8:	00000097          	auipc	ra,0x0
    800010dc:	f38080e7          	jalr	-200(ra) # 80001010 <_Z13callInterruptv>
}
    800010e0:	00813083          	ld	ra,8(sp)
    800010e4:	00013403          	ld	s0,0(sp)
    800010e8:	01010113          	addi	sp,sp,16
    800010ec:	00008067          	ret

00000000800010f0 <_Z8mem_freePv>:

int mem_free (void* memSegment) {
    800010f0:	ff010113          	addi	sp,sp,-16
    800010f4:	00113423          	sd	ra,8(sp)
    800010f8:	00813023          	sd	s0,0(sp)
    800010fc:	01010413          	addi	s0,sp,16
    uint64 code = 0x02; // kod sistemskog poziva
    asm volatile("mv a0, %0" : : "r" (code)); // a0 = code
    80001100:	00200793          	li	a5,2
    80001104:	00078513          	mv	a0,a5

    return (uint64)(callInterrupt());
    80001108:	00000097          	auipc	ra,0x0
    8000110c:	f08080e7          	jalr	-248(ra) # 80001010 <_Z13callInterruptv>
}
    80001110:	0005051b          	sext.w	a0,a0
    80001114:	00813083          	ld	ra,8(sp)
    80001118:	00013403          	ld	s0,0(sp)
    8000111c:	01010113          	addi	sp,sp,16
    80001120:	00008067          	ret

0000000080001124 <_Z12checkNullptrPv>:
#include "../h/syscall_c.h"
#include "../h/print.h"

void checkNullptr(void* p) {
    static int x = 0;
    if(p == nullptr) {
    80001124:	00050e63          	beqz	a0,80001140 <_Z12checkNullptrPv+0x1c>
        __putc('?');
        __putc('0' + x);
    }
    x++;
    80001128:	00003717          	auipc	a4,0x3
    8000112c:	36870713          	addi	a4,a4,872 # 80004490 <_ZZ12checkNullptrPvE1x>
    80001130:	00072783          	lw	a5,0(a4)
    80001134:	0017879b          	addiw	a5,a5,1
    80001138:	00f72023          	sw	a5,0(a4)
    8000113c:	00008067          	ret
void checkNullptr(void* p) {
    80001140:	ff010113          	addi	sp,sp,-16
    80001144:	00113423          	sd	ra,8(sp)
    80001148:	00813023          	sd	s0,0(sp)
    8000114c:	01010413          	addi	s0,sp,16
        __putc('?');
    80001150:	03f00513          	li	a0,63
    80001154:	00002097          	auipc	ra,0x2
    80001158:	5c8080e7          	jalr	1480(ra) # 8000371c <__putc>
        __putc('0' + x);
    8000115c:	00003517          	auipc	a0,0x3
    80001160:	33452503          	lw	a0,820(a0) # 80004490 <_ZZ12checkNullptrPvE1x>
    80001164:	0305051b          	addiw	a0,a0,48
    80001168:	0ff57513          	andi	a0,a0,255
    8000116c:	00002097          	auipc	ra,0x2
    80001170:	5b0080e7          	jalr	1456(ra) # 8000371c <__putc>
    x++;
    80001174:	00003717          	auipc	a4,0x3
    80001178:	31c70713          	addi	a4,a4,796 # 80004490 <_ZZ12checkNullptrPvE1x>
    8000117c:	00072783          	lw	a5,0(a4)
    80001180:	0017879b          	addiw	a5,a5,1
    80001184:	00f72023          	sw	a5,0(a4)
}
    80001188:	00813083          	ld	ra,8(sp)
    8000118c:	00013403          	ld	s0,0(sp)
    80001190:	01010113          	addi	sp,sp,16
    80001194:	00008067          	ret

0000000080001198 <_Z11checkStatusi>:

void checkStatus(int status) {
    static int y = 0;
    if(status) {
    80001198:	00051e63          	bnez	a0,800011b4 <_Z11checkStatusi+0x1c>
        __putc('0' + y);
        __putc('?');
    }
    y++;
    8000119c:	00003717          	auipc	a4,0x3
    800011a0:	2f470713          	addi	a4,a4,756 # 80004490 <_ZZ12checkNullptrPvE1x>
    800011a4:	00472783          	lw	a5,4(a4)
    800011a8:	0017879b          	addiw	a5,a5,1
    800011ac:	00f72223          	sw	a5,4(a4)
    800011b0:	00008067          	ret
void checkStatus(int status) {
    800011b4:	ff010113          	addi	sp,sp,-16
    800011b8:	00113423          	sd	ra,8(sp)
    800011bc:	00813023          	sd	s0,0(sp)
    800011c0:	01010413          	addi	s0,sp,16
        __putc('0' + y);
    800011c4:	00003517          	auipc	a0,0x3
    800011c8:	2d052503          	lw	a0,720(a0) # 80004494 <_ZZ11checkStatusiE1y>
    800011cc:	0305051b          	addiw	a0,a0,48
    800011d0:	0ff57513          	andi	a0,a0,255
    800011d4:	00002097          	auipc	ra,0x2
    800011d8:	548080e7          	jalr	1352(ra) # 8000371c <__putc>
        __putc('?');
    800011dc:	03f00513          	li	a0,63
    800011e0:	00002097          	auipc	ra,0x2
    800011e4:	53c080e7          	jalr	1340(ra) # 8000371c <__putc>
    y++;
    800011e8:	00003717          	auipc	a4,0x3
    800011ec:	2a870713          	addi	a4,a4,680 # 80004490 <_ZZ12checkNullptrPvE1x>
    800011f0:	00472783          	lw	a5,4(a4)
    800011f4:	0017879b          	addiw	a5,a5,1
    800011f8:	00f72223          	sw	a5,4(a4)
}
    800011fc:	00813083          	ld	ra,8(sp)
    80001200:	00013403          	ld	s0,0(sp)
    80001204:	01010113          	addi	sp,sp,16
    80001208:	00008067          	ret

000000008000120c <main>:

int main() {
    8000120c:	fe010113          	addi	sp,sp,-32
    80001210:	00113c23          	sd	ra,24(sp)
    80001214:	00813823          	sd	s0,16(sp)
    80001218:	00913423          	sd	s1,8(sp)
    8000121c:	02010413          	addi	s0,sp,32
    int* par = (int*)mem_alloc(2*sizeof(int));
    80001220:	00800513          	li	a0,8
    80001224:	00000097          	auipc	ra,0x0
    80001228:	e88080e7          	jalr	-376(ra) # 800010ac <_Z9mem_allocm>
    8000122c:	00050493          	mv	s1,a0
    par[0] = 1;
    80001230:	00100793          	li	a5,1
    80001234:	00f52023          	sw	a5,0(a0)
    par[1] = 2;
    80001238:	00200793          	li	a5,2
    8000123c:	00f52223          	sw	a5,4(a0)

    printInteger(par[0]);
    80001240:	00100513          	li	a0,1
    80001244:	00000097          	auipc	ra,0x0
    80001248:	38c080e7          	jalr	908(ra) # 800015d0 <_Z12printIntegerm>
    printInteger(par[1]);
    8000124c:	0044a503          	lw	a0,4(s1)
    80001250:	00000097          	auipc	ra,0x0
    80001254:	380080e7          	jalr	896(ra) # 800015d0 <_Z12printIntegerm>
    return 0;
    80001258:	00000513          	li	a0,0
    8000125c:	01813083          	ld	ra,24(sp)
    80001260:	01013403          	ld	s0,16(sp)
    80001264:	00813483          	ld	s1,8(sp)
    80001268:	02010113          	addi	sp,sp,32
    8000126c:	00008067          	ret

0000000080001270 <_ZN15MemoryAllocator9mem_allocEm>:
#include "../h/MemoryAllocator.h"

MemoryAllocator::FreeSegment* MemoryAllocator::head = nullptr;

void *MemoryAllocator::mem_alloc(size_t size) {
    80001270:	ff010113          	addi	sp,sp,-16
    80001274:	00813423          	sd	s0,8(sp)
    80001278:	01010413          	addi	s0,sp,16
    if(head == nullptr) { // ako prvi put alociramo memoriju, alociracemo head na pocetak mem segmenta (koji je slobodan)
    8000127c:	00003797          	auipc	a5,0x3
    80001280:	21c7b783          	ld	a5,540(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001284:	02078c63          	beqz	a5,800012bc <_ZN15MemoryAllocator9mem_allocEm+0x4c>
        head = (FreeSegment*)HEAP_START_ADDR;
        head->baseAddr = (void*)HEAP_START_ADDR;
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
        head->next = nullptr;
    }
    else if(head == (FreeSegment*)HEAP_END_ADDR) { // ako ne postoji slobodan prostor
    80001288:	00003717          	auipc	a4,0x3
    8000128c:	1b073703          	ld	a4,432(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001290:	00073703          	ld	a4,0(a4)
    80001294:	14e78263          	beq	a5,a4,800013d8 <_ZN15MemoryAllocator9mem_allocEm+0x168>
        return nullptr;
    }

    size += SegmentOffset; // dodajemo zaglavlje
    80001298:	00850613          	addi	a2,a0,8
    8000129c:	00665813          	srli	a6,a2,0x6
    800012a0:	03f67793          	andi	a5,a2,63
    800012a4:	00f037b3          	snez	a5,a5
    800012a8:	00f80833          	add	a6,a6,a5
    size_t numOfBlocksToAllocate = sizeInBlocks(size);

    FreeSegment *curr = head, *prev = nullptr;
    800012ac:	00003517          	auipc	a0,0x3
    800012b0:	1ec53503          	ld	a0,492(a0) # 80004498 <_ZN15MemoryAllocator4headE>
    800012b4:	00000593          	li	a1,0
    800012b8:	0a80006f          	j	80001360 <_ZN15MemoryAllocator9mem_allocEm+0xf0>
        head = (FreeSegment*)HEAP_START_ADDR;
    800012bc:	00003697          	auipc	a3,0x3
    800012c0:	16c6b683          	ld	a3,364(a3) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    800012c4:	0006b783          	ld	a5,0(a3)
    800012c8:	00003717          	auipc	a4,0x3
    800012cc:	1cf73823          	sd	a5,464(a4) # 80004498 <_ZN15MemoryAllocator4headE>
        head->baseAddr = (void*)HEAP_START_ADDR;
    800012d0:	00f7b023          	sd	a5,0(a5)
        head->size = ((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR); // HEAP_END_ADDR je adresa nakon kraja bloka
    800012d4:	00003717          	auipc	a4,0x3
    800012d8:	16473703          	ld	a4,356(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    800012dc:	00073703          	ld	a4,0(a4)
    800012e0:	0006b683          	ld	a3,0(a3)
    800012e4:	40d70733          	sub	a4,a4,a3
    800012e8:	00e7b423          	sd	a4,8(a5)
        head->next = nullptr;
    800012ec:	0007b823          	sd	zero,16(a5)
    800012f0:	fa9ff06f          	j	80001298 <_ZN15MemoryAllocator9mem_allocEm+0x28>
        void* startOfAllocatedSpace = curr->baseAddr;
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
                allocatedSize = curr->size;

                if(prev == nullptr) { // ako smo na head pokazivacu
    800012f4:	00058e63          	beqz	a1,80001310 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        size_t size; // velicina segmenta
        FreeSegment* next; // sledeci element u ulancanoj listi

        // brise element iz ulancane liste koji se nalazi posle elementa prev
        static void remove(FreeSegment* prev) {
            if(!prev->next) return;
    800012f8:	0105b703          	ld	a4,16(a1)
    800012fc:	04070a63          	beqz	a4,80001350 <_ZN15MemoryAllocator9mem_allocEm+0xe0>

            FreeSegment* curr = prev->next;
            prev->next = curr->next;
    80001300:	01073703          	ld	a4,16(a4)
    80001304:	00e5b823          	sd	a4,16(a1)
                allocatedSize = curr->size;
    80001308:	00078813          	mv	a6,a5
    8000130c:	0b80006f          	j	800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                    if(curr->next == nullptr) { // ako ne postoji slobodan prostor nakon alokacije
    80001310:	01053703          	ld	a4,16(a0)
    80001314:	00070a63          	beqz	a4,80001328 <_ZN15MemoryAllocator9mem_allocEm+0xb8>
                        head = (FreeSegment*)HEAP_END_ADDR;
                    }
                    else {
                        head = curr->next;
    80001318:	00003617          	auipc	a2,0x3
    8000131c:	18e63023          	sd	a4,384(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    80001320:	00078813          	mv	a6,a5
    80001324:	0a00006f          	j	800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                        head = (FreeSegment*)HEAP_END_ADDR;
    80001328:	00003717          	auipc	a4,0x3
    8000132c:	11073703          	ld	a4,272(a4) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001330:	00073703          	ld	a4,0(a4)
    80001334:	00003617          	auipc	a2,0x3
    80001338:	16e63223          	sd	a4,356(a2) # 80004498 <_ZN15MemoryAllocator4headE>
                allocatedSize = curr->size;
    8000133c:	00078813          	mv	a6,a5
    80001340:	0840006f          	j	800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                newSeg->baseAddr = newBaseAddr;
                newSeg->size = newSize;
                newSeg->next = curr->next;

                if(!prev) {
                    head = newSeg;
    80001344:	00003797          	auipc	a5,0x3
    80001348:	14e7ba23          	sd	a4,340(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    8000134c:	0780006f          	j	800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x154>
                allocatedSize = curr->size;
    80001350:	00078813          	mv	a6,a5
    80001354:	0700006f          	j	800013c4 <_ZN15MemoryAllocator9mem_allocEm+0x154>

            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
        }

        prev = curr;
    80001358:	00050593          	mv	a1,a0
        curr = curr->next;
    8000135c:	01053503          	ld	a0,16(a0)
    while(curr) {
    80001360:	06050663          	beqz	a0,800013cc <_ZN15MemoryAllocator9mem_allocEm+0x15c>
        size_t freeSegSizeInBlocks = sizeInBlocks(curr->size);
    80001364:	00853783          	ld	a5,8(a0)
        return (size / MEM_BLOCK_SIZE) + (size % MEM_BLOCK_SIZE > 0);
    80001368:	0067d693          	srli	a3,a5,0x6
    8000136c:	03f7f713          	andi	a4,a5,63
    80001370:	00e03733          	snez	a4,a4
    80001374:	00e68733          	add	a4,a3,a4
        void* startOfAllocatedSpace = curr->baseAddr;
    80001378:	00053683          	ld	a3,0(a0)
        if(curr->size >= size && freeSegSizeInBlocks >= numOfBlocksToAllocate) {
    8000137c:	fcc7eee3          	bltu	a5,a2,80001358 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
    80001380:	fd076ce3          	bltu	a4,a6,80001358 <_ZN15MemoryAllocator9mem_allocEm+0xe8>
            if(freeSegSizeInBlocks == numOfBlocksToAllocate) { // ako ce preostali slobodan segment da bude manji od jednog bloka onda i njega dodeljujemo memoriji
    80001384:	f6e808e3          	beq	a6,a4,800012f4 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return numOfBlocks * MEM_BLOCK_SIZE;
    80001388:	00681813          	slli	a6,a6,0x6
                void* newBaseAddr = ((char*)startOfAllocatedSpace + allocatedSize);
    8000138c:	01068733          	add	a4,a3,a6
                size_t newSize = curr->size - allocatedSize;
    80001390:	410787b3          	sub	a5,a5,a6
                newSeg->baseAddr = newBaseAddr;
    80001394:	00e73023          	sd	a4,0(a4)
                newSeg->size = newSize;
    80001398:	00f73423          	sd	a5,8(a4)
                newSeg->next = curr->next;
    8000139c:	01053783          	ld	a5,16(a0)
    800013a0:	00f73823          	sd	a5,16(a4)
                if(!prev) {
    800013a4:	fa0580e3          	beqz	a1,80001344 <_ZN15MemoryAllocator9mem_allocEm+0xd4>
            if(!prev->next) return;
    800013a8:	0105b783          	ld	a5,16(a1)
    800013ac:	00078663          	beqz	a5,800013b8 <_ZN15MemoryAllocator9mem_allocEm+0x148>
            prev->next = curr->next;
    800013b0:	0107b783          	ld	a5,16(a5)
    800013b4:	00f5b823          	sd	a5,16(a1)
        }

        // dodaje element curr u ulancanu listu nakon elementa prev(samo menja prev->next curr->next)
        static void add(FreeSegment* prev, FreeSegment* curr) {
            curr->next = prev->next;
    800013b8:	0105b783          	ld	a5,16(a1)
    800013bc:	00f53823          	sd	a5,16(a0)
            prev->next = curr;
    800013c0:	00a5b823          	sd	a0,16(a1)
            ((AllocatedSpaceHeader*)startOfAllocatedSpace)->size = allocatedSize;
    800013c4:	0106b023          	sd	a6,0(a3)
            return (void*)((char*)startOfAllocatedSpace + SegmentOffset);
    800013c8:	00868513          	addi	a0,a3,8
    }

    return nullptr; // ne postoji dovoljan slobodan prostor
}
    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	01010113          	addi	sp,sp,16
    800013d4:	00008067          	ret
        return nullptr;
    800013d8:	00000513          	li	a0,0
    800013dc:	ff1ff06f          	j	800013cc <_ZN15MemoryAllocator9mem_allocEm+0x15c>

00000000800013e0 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *memSegment) {
    800013e0:	ff010113          	addi	sp,sp,-16
    800013e4:	00813423          	sd	s0,8(sp)
    800013e8:	01010413          	addi	s0,sp,16
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    800013ec:	16050063          	beqz	a0,8000154c <_ZN15MemoryAllocator8mem_freeEPv+0x16c>
    800013f0:	ff850713          	addi	a4,a0,-8
    800013f4:	00003797          	auipc	a5,0x3
    800013f8:	0347b783          	ld	a5,52(a5) # 80004428 <_GLOBAL_OFFSET_TABLE_+0x8>
    800013fc:	0007b783          	ld	a5,0(a5)
    80001400:	14f76a63          	bltu	a4,a5,80001554 <_ZN15MemoryAllocator8mem_freeEPv+0x174>

    size_t size = *(size_t*)((char*)memSegment - MemoryAllocator::SegmentOffset); // velicina koja se cuva u zaglavlju
    80001404:	ff853583          	ld	a1,-8(a0)
    memSegment = (void*)((char*)memSegment - MemoryAllocator::SegmentOffset); // pocetak segmenta ukljucujuci i zaglavlje
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001408:	fff58693          	addi	a3,a1,-1
    8000140c:	00d706b3          	add	a3,a4,a3
    80001410:	00003617          	auipc	a2,0x3
    80001414:	02863603          	ld	a2,40(a2) # 80004438 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001418:	00063603          	ld	a2,0(a2)
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000141c:	14c6f063          	bgeu	a3,a2,8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x17c>
    if((char*)memSegment + size - 1 >= (char*)HEAP_END_ADDR || memSegment == nullptr
    80001420:	14070263          	beqz	a4,80001564 <_ZN15MemoryAllocator8mem_freeEPv+0x184>

    static FreeSegment* head; // pocetak ulancane liste slobodnih segmenata

    // vraca relativnu adresu u odnosu na pocetak HEAP-a
    static inline size_t relativeAddress(void* address) {
        return (size_t)address - (size_t)HEAP_START_ADDR;
    80001424:	40f707b3          	sub	a5,a4,a5
    }

    // vraca true ako je adresa pocetak bloka(relativno u odnosu na pocetak heap-a)
    static inline bool isStartOfBlock(void* address) {
        return relativeAddress(address) % MEM_BLOCK_SIZE == 0;
    80001428:	03f7f793          	andi	a5,a5,63
        || !isStartOfBlock(memSegment) || size < MEM_BLOCK_SIZE) {
    8000142c:	14079063          	bnez	a5,8000156c <_ZN15MemoryAllocator8mem_freeEPv+0x18c>
    80001430:	03f00793          	li	a5,63
    80001434:	14b7f063          	bgeu	a5,a1,80001574 <_ZN15MemoryAllocator8mem_freeEPv+0x194>
        return BAD_POINTER;
    }

    if(head == HEAP_END_ADDR) { // ako je memorija puna onda samo oslobadja dati deo
    80001438:	00003797          	auipc	a5,0x3
    8000143c:	0607b783          	ld	a5,96(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001440:	02f60063          	beq	a2,a5,80001460 <_ZN15MemoryAllocator8mem_freeEPv+0x80>

        head = newFreeSegment;
        return 0;
    }

    FreeSegment* curr = head, *prev = nullptr;
    80001444:	00000613          	li	a2,0
    // Ako nema greske posle while: ((char*)prev->baseAddr + prev->size) <= memSegment < curr->baseAddr;
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    80001448:	02078a63          	beqz	a5,8000147c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
    8000144c:	0007b683          	ld	a3,0(a5)
    80001450:	02e6f663          	bgeu	a3,a4,8000147c <_ZN15MemoryAllocator8mem_freeEPv+0x9c>
        prev = curr;
    80001454:	00078613          	mv	a2,a5
        curr = curr->next;
    80001458:	0107b783          	ld	a5,16(a5)
    while(curr != nullptr && (char*)curr->baseAddr < (char*)memSegment) {
    8000145c:	fedff06f          	j	80001448 <_ZN15MemoryAllocator8mem_freeEPv+0x68>
        newFreeSegment->size = size;
    80001460:	00b53023          	sd	a1,0(a0)
        newFreeSegment->baseAddr = memSegment;
    80001464:	fee53c23          	sd	a4,-8(a0)
        newFreeSegment->next = nullptr;
    80001468:	00053423          	sd	zero,8(a0)
        head = newFreeSegment;
    8000146c:	00003797          	auipc	a5,0x3
    80001470:	02e7b623          	sd	a4,44(a5) # 80004498 <_ZN15MemoryAllocator4headE>
        return 0;
    80001474:	00000513          	li	a0,0
    80001478:	0480006f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    }

    if(prev == nullptr) {
    8000147c:	04060863          	beqz	a2,800014cc <_ZN15MemoryAllocator8mem_freeEPv+0xec>

            return 0;
        }
    }
    else {
        if((char*)prev->baseAddr + prev->size == (char*)memSegment) { // spajamo prethodni i novi slobodni segment ako su susedni
    80001480:	00063683          	ld	a3,0(a2)
    80001484:	00863803          	ld	a6,8(a2)
    80001488:	010686b3          	add	a3,a3,a6
    8000148c:	08e68a63          	beq	a3,a4,80001520 <_ZN15MemoryAllocator8mem_freeEPv+0x140>
            prev->size += size;
        }
        else {
            FreeSegment *newFreeSegment = (FreeSegment *) memSegment;
            newFreeSegment->size = size;
    80001490:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    80001494:	fee53c23          	sd	a4,-8(a0)
            curr->next = prev->next;
    80001498:	01063683          	ld	a3,16(a2)
    8000149c:	00d53423          	sd	a3,8(a0)
            prev->next = curr;
    800014a0:	00e63823          	sd	a4,16(a2)

            FreeSegment::add(prev, newFreeSegment); // ulancavamo prev i newFreeSegment
            prev = newFreeSegment;
        }

        if(curr && (char*)curr->baseAddr == ((char*)prev->baseAddr + prev->size)) { // ako postoji susedni desni segment spajamo ga sa prethodnim
    800014a4:	0e078063          	beqz	a5,80001584 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    800014a8:	0007b583          	ld	a1,0(a5)
    800014ac:	00073683          	ld	a3,0(a4)
    800014b0:	00873603          	ld	a2,8(a4)
    800014b4:	00c686b3          	add	a3,a3,a2
    800014b8:	06d58c63          	beq	a1,a3,80001530 <_ZN15MemoryAllocator8mem_freeEPv+0x150>
            prev->size += curr->size;
            prev->next = curr->next;
        }
    }

    return 0;
    800014bc:	00000513          	li	a0,0
}
    800014c0:	00813403          	ld	s0,8(sp)
    800014c4:	01010113          	addi	sp,sp,16
    800014c8:	00008067          	ret
        if(curr == nullptr) { // nije se nijednom pozvao mem_alloc
    800014cc:	0a078863          	beqz	a5,8000157c <_ZN15MemoryAllocator8mem_freeEPv+0x19c>
            newFreeSegment->size = size;
    800014d0:	00b53023          	sd	a1,0(a0)
            newFreeSegment->baseAddr = memSegment;
    800014d4:	fee53c23          	sd	a4,-8(a0)
            if((char*)head->baseAddr == ((char*)newFreeSegment->baseAddr + newFreeSegment->size)) { // spajamo head i novi slobodan segment ako su susedni
    800014d8:	00003797          	auipc	a5,0x3
    800014dc:	fc07b783          	ld	a5,-64(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    800014e0:	0007b603          	ld	a2,0(a5)
    800014e4:	00b706b3          	add	a3,a4,a1
    800014e8:	00d60c63          	beq	a2,a3,80001500 <_ZN15MemoryAllocator8mem_freeEPv+0x120>
                newFreeSegment->next = head;
    800014ec:	00f53423          	sd	a5,8(a0)
            head = newFreeSegment;
    800014f0:	00003797          	auipc	a5,0x3
    800014f4:	fae7b423          	sd	a4,-88(a5) # 80004498 <_ZN15MemoryAllocator4headE>
            return 0;
    800014f8:	00000513          	li	a0,0
    800014fc:	fc5ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
                newFreeSegment->size += head->size;
    80001500:	0087b783          	ld	a5,8(a5)
    80001504:	00b785b3          	add	a1,a5,a1
    80001508:	00b53023          	sd	a1,0(a0)
                newFreeSegment->next = head->next;
    8000150c:	00003797          	auipc	a5,0x3
    80001510:	f8c7b783          	ld	a5,-116(a5) # 80004498 <_ZN15MemoryAllocator4headE>
    80001514:	0107b783          	ld	a5,16(a5)
    80001518:	00f53423          	sd	a5,8(a0)
    8000151c:	fd5ff06f          	j	800014f0 <_ZN15MemoryAllocator8mem_freeEPv+0x110>
            prev->size += size;
    80001520:	00b805b3          	add	a1,a6,a1
    80001524:	00b63423          	sd	a1,8(a2)
    80001528:	00060713          	mv	a4,a2
    8000152c:	f79ff06f          	j	800014a4 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
            prev->size += curr->size;
    80001530:	0087b683          	ld	a3,8(a5)
    80001534:	00d60633          	add	a2,a2,a3
    80001538:	00c73423          	sd	a2,8(a4)
            prev->next = curr->next;
    8000153c:	0107b783          	ld	a5,16(a5)
    80001540:	00f73823          	sd	a5,16(a4)
    return 0;
    80001544:	00000513          	li	a0,0
    80001548:	f79ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    if(!memSegment || (size_t)memSegment - SegmentOffset < (size_t)HEAP_START_ADDR) return BAD_POINTER;
    8000154c:	fff00513          	li	a0,-1
    80001550:	f71ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001554:	fff00513          	li	a0,-1
    80001558:	f69ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
        return BAD_POINTER;
    8000155c:	fff00513          	li	a0,-1
    80001560:	f61ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001564:	fff00513          	li	a0,-1
    80001568:	f59ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    8000156c:	fff00513          	li	a0,-1
    80001570:	f51ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    80001574:	fff00513          	li	a0,-1
    80001578:	f49ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
            return BAD_POINTER;
    8000157c:	fff00513          	li	a0,-1
    80001580:	f41ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>
    return 0;
    80001584:	00000513          	li	a0,0
    80001588:	f39ff06f          	j	800014c0 <_ZN15MemoryAllocator8mem_freeEPv+0xe0>

000000008000158c <_Z11printStringPKc>:
#include "../h/print.h"
#include "../lib/console.h"

void printString(char const *string)
{
    8000158c:	fe010113          	addi	sp,sp,-32
    80001590:	00113c23          	sd	ra,24(sp)
    80001594:	00813823          	sd	s0,16(sp)
    80001598:	00913423          	sd	s1,8(sp)
    8000159c:	02010413          	addi	s0,sp,32
    800015a0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800015a4:	0004c503          	lbu	a0,0(s1)
    800015a8:	00050a63          	beqz	a0,800015bc <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    800015ac:	00002097          	auipc	ra,0x2
    800015b0:	170080e7          	jalr	368(ra) # 8000371c <__putc>
        string++;
    800015b4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800015b8:	fedff06f          	j	800015a4 <_Z11printStringPKc+0x18>
    }
}
    800015bc:	01813083          	ld	ra,24(sp)
    800015c0:	01013403          	ld	s0,16(sp)
    800015c4:	00813483          	ld	s1,8(sp)
    800015c8:	02010113          	addi	sp,sp,32
    800015cc:	00008067          	ret

00000000800015d0 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    800015d0:	fd010113          	addi	sp,sp,-48
    800015d4:	02113423          	sd	ra,40(sp)
    800015d8:	02813023          	sd	s0,32(sp)
    800015dc:	00913c23          	sd	s1,24(sp)
    800015e0:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    800015e4:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    800015e8:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    800015ec:	00a00613          	li	a2,10
    800015f0:	02c5773b          	remuw	a4,a0,a2
    800015f4:	02071693          	slli	a3,a4,0x20
    800015f8:	0206d693          	srli	a3,a3,0x20
    800015fc:	00003717          	auipc	a4,0x3
    80001600:	a2470713          	addi	a4,a4,-1500 # 80004020 <_ZZ12printIntegermE6digits>
    80001604:	00d70733          	add	a4,a4,a3
    80001608:	00074703          	lbu	a4,0(a4)
    8000160c:	fe040693          	addi	a3,s0,-32
    80001610:	009687b3          	add	a5,a3,s1
    80001614:	0014849b          	addiw	s1,s1,1
    80001618:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    8000161c:	0005071b          	sext.w	a4,a0
    80001620:	02c5553b          	divuw	a0,a0,a2
    80001624:	00900793          	li	a5,9
    80001628:	fce7e2e3          	bltu	a5,a4,800015ec <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    8000162c:	fff4849b          	addiw	s1,s1,-1
    80001630:	0004ce63          	bltz	s1,8000164c <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    80001634:	fe040793          	addi	a5,s0,-32
    80001638:	009787b3          	add	a5,a5,s1
    8000163c:	ff07c503          	lbu	a0,-16(a5)
    80001640:	00002097          	auipc	ra,0x2
    80001644:	0dc080e7          	jalr	220(ra) # 8000371c <__putc>
    80001648:	fe5ff06f          	j	8000162c <_Z12printIntegerm+0x5c>
    8000164c:	02813083          	ld	ra,40(sp)
    80001650:	02013403          	ld	s0,32(sp)
    80001654:	01813483          	ld	s1,24(sp)
    80001658:	03010113          	addi	sp,sp,48
    8000165c:	00008067          	ret

0000000080001660 <start>:
    80001660:	ff010113          	addi	sp,sp,-16
    80001664:	00813423          	sd	s0,8(sp)
    80001668:	01010413          	addi	s0,sp,16
    8000166c:	300027f3          	csrr	a5,mstatus
    80001670:	ffffe737          	lui	a4,0xffffe
    80001674:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff910f>
    80001678:	00e7f7b3          	and	a5,a5,a4
    8000167c:	00001737          	lui	a4,0x1
    80001680:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001684:	00e7e7b3          	or	a5,a5,a4
    80001688:	30079073          	csrw	mstatus,a5
    8000168c:	00000797          	auipc	a5,0x0
    80001690:	16078793          	addi	a5,a5,352 # 800017ec <system_main>
    80001694:	34179073          	csrw	mepc,a5
    80001698:	00000793          	li	a5,0
    8000169c:	18079073          	csrw	satp,a5
    800016a0:	000107b7          	lui	a5,0x10
    800016a4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800016a8:	30279073          	csrw	medeleg,a5
    800016ac:	30379073          	csrw	mideleg,a5
    800016b0:	104027f3          	csrr	a5,sie
    800016b4:	2227e793          	ori	a5,a5,546
    800016b8:	10479073          	csrw	sie,a5
    800016bc:	fff00793          	li	a5,-1
    800016c0:	00a7d793          	srli	a5,a5,0xa
    800016c4:	3b079073          	csrw	pmpaddr0,a5
    800016c8:	00f00793          	li	a5,15
    800016cc:	3a079073          	csrw	pmpcfg0,a5
    800016d0:	f14027f3          	csrr	a5,mhartid
    800016d4:	0200c737          	lui	a4,0x200c
    800016d8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800016dc:	0007869b          	sext.w	a3,a5
    800016e0:	00269713          	slli	a4,a3,0x2
    800016e4:	000f4637          	lui	a2,0xf4
    800016e8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800016ec:	00d70733          	add	a4,a4,a3
    800016f0:	0037979b          	slliw	a5,a5,0x3
    800016f4:	020046b7          	lui	a3,0x2004
    800016f8:	00d787b3          	add	a5,a5,a3
    800016fc:	00c585b3          	add	a1,a1,a2
    80001700:	00371693          	slli	a3,a4,0x3
    80001704:	00003717          	auipc	a4,0x3
    80001708:	d9c70713          	addi	a4,a4,-612 # 800044a0 <timer_scratch>
    8000170c:	00b7b023          	sd	a1,0(a5)
    80001710:	00d70733          	add	a4,a4,a3
    80001714:	00f73c23          	sd	a5,24(a4)
    80001718:	02c73023          	sd	a2,32(a4)
    8000171c:	34071073          	csrw	mscratch,a4
    80001720:	00000797          	auipc	a5,0x0
    80001724:	6e078793          	addi	a5,a5,1760 # 80001e00 <timervec>
    80001728:	30579073          	csrw	mtvec,a5
    8000172c:	300027f3          	csrr	a5,mstatus
    80001730:	0087e793          	ori	a5,a5,8
    80001734:	30079073          	csrw	mstatus,a5
    80001738:	304027f3          	csrr	a5,mie
    8000173c:	0807e793          	ori	a5,a5,128
    80001740:	30479073          	csrw	mie,a5
    80001744:	f14027f3          	csrr	a5,mhartid
    80001748:	0007879b          	sext.w	a5,a5
    8000174c:	00078213          	mv	tp,a5
    80001750:	30200073          	mret
    80001754:	00813403          	ld	s0,8(sp)
    80001758:	01010113          	addi	sp,sp,16
    8000175c:	00008067          	ret

0000000080001760 <timerinit>:
    80001760:	ff010113          	addi	sp,sp,-16
    80001764:	00813423          	sd	s0,8(sp)
    80001768:	01010413          	addi	s0,sp,16
    8000176c:	f14027f3          	csrr	a5,mhartid
    80001770:	0200c737          	lui	a4,0x200c
    80001774:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001778:	0007869b          	sext.w	a3,a5
    8000177c:	00269713          	slli	a4,a3,0x2
    80001780:	000f4637          	lui	a2,0xf4
    80001784:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001788:	00d70733          	add	a4,a4,a3
    8000178c:	0037979b          	slliw	a5,a5,0x3
    80001790:	020046b7          	lui	a3,0x2004
    80001794:	00d787b3          	add	a5,a5,a3
    80001798:	00c585b3          	add	a1,a1,a2
    8000179c:	00371693          	slli	a3,a4,0x3
    800017a0:	00003717          	auipc	a4,0x3
    800017a4:	d0070713          	addi	a4,a4,-768 # 800044a0 <timer_scratch>
    800017a8:	00b7b023          	sd	a1,0(a5)
    800017ac:	00d70733          	add	a4,a4,a3
    800017b0:	00f73c23          	sd	a5,24(a4)
    800017b4:	02c73023          	sd	a2,32(a4)
    800017b8:	34071073          	csrw	mscratch,a4
    800017bc:	00000797          	auipc	a5,0x0
    800017c0:	64478793          	addi	a5,a5,1604 # 80001e00 <timervec>
    800017c4:	30579073          	csrw	mtvec,a5
    800017c8:	300027f3          	csrr	a5,mstatus
    800017cc:	0087e793          	ori	a5,a5,8
    800017d0:	30079073          	csrw	mstatus,a5
    800017d4:	304027f3          	csrr	a5,mie
    800017d8:	0807e793          	ori	a5,a5,128
    800017dc:	30479073          	csrw	mie,a5
    800017e0:	00813403          	ld	s0,8(sp)
    800017e4:	01010113          	addi	sp,sp,16
    800017e8:	00008067          	ret

00000000800017ec <system_main>:
    800017ec:	fe010113          	addi	sp,sp,-32
    800017f0:	00813823          	sd	s0,16(sp)
    800017f4:	00913423          	sd	s1,8(sp)
    800017f8:	00113c23          	sd	ra,24(sp)
    800017fc:	02010413          	addi	s0,sp,32
    80001800:	00000097          	auipc	ra,0x0
    80001804:	0c4080e7          	jalr	196(ra) # 800018c4 <cpuid>
    80001808:	00003497          	auipc	s1,0x3
    8000180c:	c5848493          	addi	s1,s1,-936 # 80004460 <started>
    80001810:	02050263          	beqz	a0,80001834 <system_main+0x48>
    80001814:	0004a783          	lw	a5,0(s1)
    80001818:	0007879b          	sext.w	a5,a5
    8000181c:	fe078ce3          	beqz	a5,80001814 <system_main+0x28>
    80001820:	0ff0000f          	fence
    80001824:	00003517          	auipc	a0,0x3
    80001828:	83c50513          	addi	a0,a0,-1988 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    8000182c:	00001097          	auipc	ra,0x1
    80001830:	a70080e7          	jalr	-1424(ra) # 8000229c <panic>
    80001834:	00001097          	auipc	ra,0x1
    80001838:	9c4080e7          	jalr	-1596(ra) # 800021f8 <consoleinit>
    8000183c:	00001097          	auipc	ra,0x1
    80001840:	150080e7          	jalr	336(ra) # 8000298c <printfinit>
    80001844:	00003517          	auipc	a0,0x3
    80001848:	8fc50513          	addi	a0,a0,-1796 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    8000184c:	00001097          	auipc	ra,0x1
    80001850:	aac080e7          	jalr	-1364(ra) # 800022f8 <__printf>
    80001854:	00002517          	auipc	a0,0x2
    80001858:	7dc50513          	addi	a0,a0,2012 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    8000185c:	00001097          	auipc	ra,0x1
    80001860:	a9c080e7          	jalr	-1380(ra) # 800022f8 <__printf>
    80001864:	00003517          	auipc	a0,0x3
    80001868:	8dc50513          	addi	a0,a0,-1828 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    8000186c:	00001097          	auipc	ra,0x1
    80001870:	a8c080e7          	jalr	-1396(ra) # 800022f8 <__printf>
    80001874:	00001097          	auipc	ra,0x1
    80001878:	4a4080e7          	jalr	1188(ra) # 80002d18 <kinit>
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	148080e7          	jalr	328(ra) # 800019c4 <trapinit>
    80001884:	00000097          	auipc	ra,0x0
    80001888:	16c080e7          	jalr	364(ra) # 800019f0 <trapinithart>
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	5b4080e7          	jalr	1460(ra) # 80001e40 <plicinit>
    80001894:	00000097          	auipc	ra,0x0
    80001898:	5d4080e7          	jalr	1492(ra) # 80001e68 <plicinithart>
    8000189c:	00000097          	auipc	ra,0x0
    800018a0:	078080e7          	jalr	120(ra) # 80001914 <userinit>
    800018a4:	0ff0000f          	fence
    800018a8:	00100793          	li	a5,1
    800018ac:	00002517          	auipc	a0,0x2
    800018b0:	79c50513          	addi	a0,a0,1948 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    800018b4:	00f4a023          	sw	a5,0(s1)
    800018b8:	00001097          	auipc	ra,0x1
    800018bc:	a40080e7          	jalr	-1472(ra) # 800022f8 <__printf>
    800018c0:	0000006f          	j	800018c0 <system_main+0xd4>

00000000800018c4 <cpuid>:
    800018c4:	ff010113          	addi	sp,sp,-16
    800018c8:	00813423          	sd	s0,8(sp)
    800018cc:	01010413          	addi	s0,sp,16
    800018d0:	00020513          	mv	a0,tp
    800018d4:	00813403          	ld	s0,8(sp)
    800018d8:	0005051b          	sext.w	a0,a0
    800018dc:	01010113          	addi	sp,sp,16
    800018e0:	00008067          	ret

00000000800018e4 <mycpu>:
    800018e4:	ff010113          	addi	sp,sp,-16
    800018e8:	00813423          	sd	s0,8(sp)
    800018ec:	01010413          	addi	s0,sp,16
    800018f0:	00020793          	mv	a5,tp
    800018f4:	00813403          	ld	s0,8(sp)
    800018f8:	0007879b          	sext.w	a5,a5
    800018fc:	00779793          	slli	a5,a5,0x7
    80001900:	00004517          	auipc	a0,0x4
    80001904:	bd050513          	addi	a0,a0,-1072 # 800054d0 <cpus>
    80001908:	00f50533          	add	a0,a0,a5
    8000190c:	01010113          	addi	sp,sp,16
    80001910:	00008067          	ret

0000000080001914 <userinit>:
    80001914:	ff010113          	addi	sp,sp,-16
    80001918:	00813423          	sd	s0,8(sp)
    8000191c:	01010413          	addi	s0,sp,16
    80001920:	00813403          	ld	s0,8(sp)
    80001924:	01010113          	addi	sp,sp,16
    80001928:	00000317          	auipc	t1,0x0
    8000192c:	8e430067          	jr	-1820(t1) # 8000120c <main>

0000000080001930 <either_copyout>:
    80001930:	ff010113          	addi	sp,sp,-16
    80001934:	00813023          	sd	s0,0(sp)
    80001938:	00113423          	sd	ra,8(sp)
    8000193c:	01010413          	addi	s0,sp,16
    80001940:	02051663          	bnez	a0,8000196c <either_copyout+0x3c>
    80001944:	00058513          	mv	a0,a1
    80001948:	00060593          	mv	a1,a2
    8000194c:	0006861b          	sext.w	a2,a3
    80001950:	00002097          	auipc	ra,0x2
    80001954:	c54080e7          	jalr	-940(ra) # 800035a4 <__memmove>
    80001958:	00813083          	ld	ra,8(sp)
    8000195c:	00013403          	ld	s0,0(sp)
    80001960:	00000513          	li	a0,0
    80001964:	01010113          	addi	sp,sp,16
    80001968:	00008067          	ret
    8000196c:	00002517          	auipc	a0,0x2
    80001970:	71c50513          	addi	a0,a0,1820 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    80001974:	00001097          	auipc	ra,0x1
    80001978:	928080e7          	jalr	-1752(ra) # 8000229c <panic>

000000008000197c <either_copyin>:
    8000197c:	ff010113          	addi	sp,sp,-16
    80001980:	00813023          	sd	s0,0(sp)
    80001984:	00113423          	sd	ra,8(sp)
    80001988:	01010413          	addi	s0,sp,16
    8000198c:	02059463          	bnez	a1,800019b4 <either_copyin+0x38>
    80001990:	00060593          	mv	a1,a2
    80001994:	0006861b          	sext.w	a2,a3
    80001998:	00002097          	auipc	ra,0x2
    8000199c:	c0c080e7          	jalr	-1012(ra) # 800035a4 <__memmove>
    800019a0:	00813083          	ld	ra,8(sp)
    800019a4:	00013403          	ld	s0,0(sp)
    800019a8:	00000513          	li	a0,0
    800019ac:	01010113          	addi	sp,sp,16
    800019b0:	00008067          	ret
    800019b4:	00002517          	auipc	a0,0x2
    800019b8:	6fc50513          	addi	a0,a0,1788 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    800019bc:	00001097          	auipc	ra,0x1
    800019c0:	8e0080e7          	jalr	-1824(ra) # 8000229c <panic>

00000000800019c4 <trapinit>:
    800019c4:	ff010113          	addi	sp,sp,-16
    800019c8:	00813423          	sd	s0,8(sp)
    800019cc:	01010413          	addi	s0,sp,16
    800019d0:	00813403          	ld	s0,8(sp)
    800019d4:	00002597          	auipc	a1,0x2
    800019d8:	70458593          	addi	a1,a1,1796 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    800019dc:	00004517          	auipc	a0,0x4
    800019e0:	b7450513          	addi	a0,a0,-1164 # 80005550 <tickslock>
    800019e4:	01010113          	addi	sp,sp,16
    800019e8:	00001317          	auipc	t1,0x1
    800019ec:	5c030067          	jr	1472(t1) # 80002fa8 <initlock>

00000000800019f0 <trapinithart>:
    800019f0:	ff010113          	addi	sp,sp,-16
    800019f4:	00813423          	sd	s0,8(sp)
    800019f8:	01010413          	addi	s0,sp,16
    800019fc:	00000797          	auipc	a5,0x0
    80001a00:	2f478793          	addi	a5,a5,756 # 80001cf0 <kernelvec>
    80001a04:	10579073          	csrw	stvec,a5
    80001a08:	00813403          	ld	s0,8(sp)
    80001a0c:	01010113          	addi	sp,sp,16
    80001a10:	00008067          	ret

0000000080001a14 <usertrap>:
    80001a14:	ff010113          	addi	sp,sp,-16
    80001a18:	00813423          	sd	s0,8(sp)
    80001a1c:	01010413          	addi	s0,sp,16
    80001a20:	00813403          	ld	s0,8(sp)
    80001a24:	01010113          	addi	sp,sp,16
    80001a28:	00008067          	ret

0000000080001a2c <usertrapret>:
    80001a2c:	ff010113          	addi	sp,sp,-16
    80001a30:	00813423          	sd	s0,8(sp)
    80001a34:	01010413          	addi	s0,sp,16
    80001a38:	00813403          	ld	s0,8(sp)
    80001a3c:	01010113          	addi	sp,sp,16
    80001a40:	00008067          	ret

0000000080001a44 <kerneltrap>:
    80001a44:	fe010113          	addi	sp,sp,-32
    80001a48:	00813823          	sd	s0,16(sp)
    80001a4c:	00113c23          	sd	ra,24(sp)
    80001a50:	00913423          	sd	s1,8(sp)
    80001a54:	02010413          	addi	s0,sp,32
    80001a58:	142025f3          	csrr	a1,scause
    80001a5c:	100027f3          	csrr	a5,sstatus
    80001a60:	0027f793          	andi	a5,a5,2
    80001a64:	10079c63          	bnez	a5,80001b7c <kerneltrap+0x138>
    80001a68:	142027f3          	csrr	a5,scause
    80001a6c:	0207ce63          	bltz	a5,80001aa8 <kerneltrap+0x64>
    80001a70:	00002517          	auipc	a0,0x2
    80001a74:	6b050513          	addi	a0,a0,1712 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    80001a78:	00001097          	auipc	ra,0x1
    80001a7c:	880080e7          	jalr	-1920(ra) # 800022f8 <__printf>
    80001a80:	141025f3          	csrr	a1,sepc
    80001a84:	14302673          	csrr	a2,stval
    80001a88:	00002517          	auipc	a0,0x2
    80001a8c:	6a850513          	addi	a0,a0,1704 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001a90:	00001097          	auipc	ra,0x1
    80001a94:	868080e7          	jalr	-1944(ra) # 800022f8 <__printf>
    80001a98:	00002517          	auipc	a0,0x2
    80001a9c:	6b050513          	addi	a0,a0,1712 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001aa0:	00000097          	auipc	ra,0x0
    80001aa4:	7fc080e7          	jalr	2044(ra) # 8000229c <panic>
    80001aa8:	0ff7f713          	andi	a4,a5,255
    80001aac:	00900693          	li	a3,9
    80001ab0:	04d70063          	beq	a4,a3,80001af0 <kerneltrap+0xac>
    80001ab4:	fff00713          	li	a4,-1
    80001ab8:	03f71713          	slli	a4,a4,0x3f
    80001abc:	00170713          	addi	a4,a4,1
    80001ac0:	fae798e3          	bne	a5,a4,80001a70 <kerneltrap+0x2c>
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	e00080e7          	jalr	-512(ra) # 800018c4 <cpuid>
    80001acc:	06050663          	beqz	a0,80001b38 <kerneltrap+0xf4>
    80001ad0:	144027f3          	csrr	a5,sip
    80001ad4:	ffd7f793          	andi	a5,a5,-3
    80001ad8:	14479073          	csrw	sip,a5
    80001adc:	01813083          	ld	ra,24(sp)
    80001ae0:	01013403          	ld	s0,16(sp)
    80001ae4:	00813483          	ld	s1,8(sp)
    80001ae8:	02010113          	addi	sp,sp,32
    80001aec:	00008067          	ret
    80001af0:	00000097          	auipc	ra,0x0
    80001af4:	3c4080e7          	jalr	964(ra) # 80001eb4 <plic_claim>
    80001af8:	00a00793          	li	a5,10
    80001afc:	00050493          	mv	s1,a0
    80001b00:	06f50863          	beq	a0,a5,80001b70 <kerneltrap+0x12c>
    80001b04:	fc050ce3          	beqz	a0,80001adc <kerneltrap+0x98>
    80001b08:	00050593          	mv	a1,a0
    80001b0c:	00002517          	auipc	a0,0x2
    80001b10:	5f450513          	addi	a0,a0,1524 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	7e4080e7          	jalr	2020(ra) # 800022f8 <__printf>
    80001b1c:	01013403          	ld	s0,16(sp)
    80001b20:	01813083          	ld	ra,24(sp)
    80001b24:	00048513          	mv	a0,s1
    80001b28:	00813483          	ld	s1,8(sp)
    80001b2c:	02010113          	addi	sp,sp,32
    80001b30:	00000317          	auipc	t1,0x0
    80001b34:	3bc30067          	jr	956(t1) # 80001eec <plic_complete>
    80001b38:	00004517          	auipc	a0,0x4
    80001b3c:	a1850513          	addi	a0,a0,-1512 # 80005550 <tickslock>
    80001b40:	00001097          	auipc	ra,0x1
    80001b44:	48c080e7          	jalr	1164(ra) # 80002fcc <acquire>
    80001b48:	00003717          	auipc	a4,0x3
    80001b4c:	91c70713          	addi	a4,a4,-1764 # 80004464 <ticks>
    80001b50:	00072783          	lw	a5,0(a4)
    80001b54:	00004517          	auipc	a0,0x4
    80001b58:	9fc50513          	addi	a0,a0,-1540 # 80005550 <tickslock>
    80001b5c:	0017879b          	addiw	a5,a5,1
    80001b60:	00f72023          	sw	a5,0(a4)
    80001b64:	00001097          	auipc	ra,0x1
    80001b68:	534080e7          	jalr	1332(ra) # 80003098 <release>
    80001b6c:	f65ff06f          	j	80001ad0 <kerneltrap+0x8c>
    80001b70:	00001097          	auipc	ra,0x1
    80001b74:	090080e7          	jalr	144(ra) # 80002c00 <uartintr>
    80001b78:	fa5ff06f          	j	80001b1c <kerneltrap+0xd8>
    80001b7c:	00002517          	auipc	a0,0x2
    80001b80:	56450513          	addi	a0,a0,1380 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	718080e7          	jalr	1816(ra) # 8000229c <panic>

0000000080001b8c <clockintr>:
    80001b8c:	fe010113          	addi	sp,sp,-32
    80001b90:	00813823          	sd	s0,16(sp)
    80001b94:	00913423          	sd	s1,8(sp)
    80001b98:	00113c23          	sd	ra,24(sp)
    80001b9c:	02010413          	addi	s0,sp,32
    80001ba0:	00004497          	auipc	s1,0x4
    80001ba4:	9b048493          	addi	s1,s1,-1616 # 80005550 <tickslock>
    80001ba8:	00048513          	mv	a0,s1
    80001bac:	00001097          	auipc	ra,0x1
    80001bb0:	420080e7          	jalr	1056(ra) # 80002fcc <acquire>
    80001bb4:	00003717          	auipc	a4,0x3
    80001bb8:	8b070713          	addi	a4,a4,-1872 # 80004464 <ticks>
    80001bbc:	00072783          	lw	a5,0(a4)
    80001bc0:	01013403          	ld	s0,16(sp)
    80001bc4:	01813083          	ld	ra,24(sp)
    80001bc8:	00048513          	mv	a0,s1
    80001bcc:	0017879b          	addiw	a5,a5,1
    80001bd0:	00813483          	ld	s1,8(sp)
    80001bd4:	00f72023          	sw	a5,0(a4)
    80001bd8:	02010113          	addi	sp,sp,32
    80001bdc:	00001317          	auipc	t1,0x1
    80001be0:	4bc30067          	jr	1212(t1) # 80003098 <release>

0000000080001be4 <devintr>:
    80001be4:	142027f3          	csrr	a5,scause
    80001be8:	00000513          	li	a0,0
    80001bec:	0007c463          	bltz	a5,80001bf4 <devintr+0x10>
    80001bf0:	00008067          	ret
    80001bf4:	fe010113          	addi	sp,sp,-32
    80001bf8:	00813823          	sd	s0,16(sp)
    80001bfc:	00113c23          	sd	ra,24(sp)
    80001c00:	00913423          	sd	s1,8(sp)
    80001c04:	02010413          	addi	s0,sp,32
    80001c08:	0ff7f713          	andi	a4,a5,255
    80001c0c:	00900693          	li	a3,9
    80001c10:	04d70c63          	beq	a4,a3,80001c68 <devintr+0x84>
    80001c14:	fff00713          	li	a4,-1
    80001c18:	03f71713          	slli	a4,a4,0x3f
    80001c1c:	00170713          	addi	a4,a4,1
    80001c20:	00e78c63          	beq	a5,a4,80001c38 <devintr+0x54>
    80001c24:	01813083          	ld	ra,24(sp)
    80001c28:	01013403          	ld	s0,16(sp)
    80001c2c:	00813483          	ld	s1,8(sp)
    80001c30:	02010113          	addi	sp,sp,32
    80001c34:	00008067          	ret
    80001c38:	00000097          	auipc	ra,0x0
    80001c3c:	c8c080e7          	jalr	-884(ra) # 800018c4 <cpuid>
    80001c40:	06050663          	beqz	a0,80001cac <devintr+0xc8>
    80001c44:	144027f3          	csrr	a5,sip
    80001c48:	ffd7f793          	andi	a5,a5,-3
    80001c4c:	14479073          	csrw	sip,a5
    80001c50:	01813083          	ld	ra,24(sp)
    80001c54:	01013403          	ld	s0,16(sp)
    80001c58:	00813483          	ld	s1,8(sp)
    80001c5c:	00200513          	li	a0,2
    80001c60:	02010113          	addi	sp,sp,32
    80001c64:	00008067          	ret
    80001c68:	00000097          	auipc	ra,0x0
    80001c6c:	24c080e7          	jalr	588(ra) # 80001eb4 <plic_claim>
    80001c70:	00a00793          	li	a5,10
    80001c74:	00050493          	mv	s1,a0
    80001c78:	06f50663          	beq	a0,a5,80001ce4 <devintr+0x100>
    80001c7c:	00100513          	li	a0,1
    80001c80:	fa0482e3          	beqz	s1,80001c24 <devintr+0x40>
    80001c84:	00048593          	mv	a1,s1
    80001c88:	00002517          	auipc	a0,0x2
    80001c8c:	47850513          	addi	a0,a0,1144 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001c90:	00000097          	auipc	ra,0x0
    80001c94:	668080e7          	jalr	1640(ra) # 800022f8 <__printf>
    80001c98:	00048513          	mv	a0,s1
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	250080e7          	jalr	592(ra) # 80001eec <plic_complete>
    80001ca4:	00100513          	li	a0,1
    80001ca8:	f7dff06f          	j	80001c24 <devintr+0x40>
    80001cac:	00004517          	auipc	a0,0x4
    80001cb0:	8a450513          	addi	a0,a0,-1884 # 80005550 <tickslock>
    80001cb4:	00001097          	auipc	ra,0x1
    80001cb8:	318080e7          	jalr	792(ra) # 80002fcc <acquire>
    80001cbc:	00002717          	auipc	a4,0x2
    80001cc0:	7a870713          	addi	a4,a4,1960 # 80004464 <ticks>
    80001cc4:	00072783          	lw	a5,0(a4)
    80001cc8:	00004517          	auipc	a0,0x4
    80001ccc:	88850513          	addi	a0,a0,-1912 # 80005550 <tickslock>
    80001cd0:	0017879b          	addiw	a5,a5,1
    80001cd4:	00f72023          	sw	a5,0(a4)
    80001cd8:	00001097          	auipc	ra,0x1
    80001cdc:	3c0080e7          	jalr	960(ra) # 80003098 <release>
    80001ce0:	f65ff06f          	j	80001c44 <devintr+0x60>
    80001ce4:	00001097          	auipc	ra,0x1
    80001ce8:	f1c080e7          	jalr	-228(ra) # 80002c00 <uartintr>
    80001cec:	fadff06f          	j	80001c98 <devintr+0xb4>

0000000080001cf0 <kernelvec>:
    80001cf0:	f0010113          	addi	sp,sp,-256
    80001cf4:	00113023          	sd	ra,0(sp)
    80001cf8:	00213423          	sd	sp,8(sp)
    80001cfc:	00313823          	sd	gp,16(sp)
    80001d00:	00413c23          	sd	tp,24(sp)
    80001d04:	02513023          	sd	t0,32(sp)
    80001d08:	02613423          	sd	t1,40(sp)
    80001d0c:	02713823          	sd	t2,48(sp)
    80001d10:	02813c23          	sd	s0,56(sp)
    80001d14:	04913023          	sd	s1,64(sp)
    80001d18:	04a13423          	sd	a0,72(sp)
    80001d1c:	04b13823          	sd	a1,80(sp)
    80001d20:	04c13c23          	sd	a2,88(sp)
    80001d24:	06d13023          	sd	a3,96(sp)
    80001d28:	06e13423          	sd	a4,104(sp)
    80001d2c:	06f13823          	sd	a5,112(sp)
    80001d30:	07013c23          	sd	a6,120(sp)
    80001d34:	09113023          	sd	a7,128(sp)
    80001d38:	09213423          	sd	s2,136(sp)
    80001d3c:	09313823          	sd	s3,144(sp)
    80001d40:	09413c23          	sd	s4,152(sp)
    80001d44:	0b513023          	sd	s5,160(sp)
    80001d48:	0b613423          	sd	s6,168(sp)
    80001d4c:	0b713823          	sd	s7,176(sp)
    80001d50:	0b813c23          	sd	s8,184(sp)
    80001d54:	0d913023          	sd	s9,192(sp)
    80001d58:	0da13423          	sd	s10,200(sp)
    80001d5c:	0db13823          	sd	s11,208(sp)
    80001d60:	0dc13c23          	sd	t3,216(sp)
    80001d64:	0fd13023          	sd	t4,224(sp)
    80001d68:	0fe13423          	sd	t5,232(sp)
    80001d6c:	0ff13823          	sd	t6,240(sp)
    80001d70:	cd5ff0ef          	jal	ra,80001a44 <kerneltrap>
    80001d74:	00013083          	ld	ra,0(sp)
    80001d78:	00813103          	ld	sp,8(sp)
    80001d7c:	01013183          	ld	gp,16(sp)
    80001d80:	02013283          	ld	t0,32(sp)
    80001d84:	02813303          	ld	t1,40(sp)
    80001d88:	03013383          	ld	t2,48(sp)
    80001d8c:	03813403          	ld	s0,56(sp)
    80001d90:	04013483          	ld	s1,64(sp)
    80001d94:	04813503          	ld	a0,72(sp)
    80001d98:	05013583          	ld	a1,80(sp)
    80001d9c:	05813603          	ld	a2,88(sp)
    80001da0:	06013683          	ld	a3,96(sp)
    80001da4:	06813703          	ld	a4,104(sp)
    80001da8:	07013783          	ld	a5,112(sp)
    80001dac:	07813803          	ld	a6,120(sp)
    80001db0:	08013883          	ld	a7,128(sp)
    80001db4:	08813903          	ld	s2,136(sp)
    80001db8:	09013983          	ld	s3,144(sp)
    80001dbc:	09813a03          	ld	s4,152(sp)
    80001dc0:	0a013a83          	ld	s5,160(sp)
    80001dc4:	0a813b03          	ld	s6,168(sp)
    80001dc8:	0b013b83          	ld	s7,176(sp)
    80001dcc:	0b813c03          	ld	s8,184(sp)
    80001dd0:	0c013c83          	ld	s9,192(sp)
    80001dd4:	0c813d03          	ld	s10,200(sp)
    80001dd8:	0d013d83          	ld	s11,208(sp)
    80001ddc:	0d813e03          	ld	t3,216(sp)
    80001de0:	0e013e83          	ld	t4,224(sp)
    80001de4:	0e813f03          	ld	t5,232(sp)
    80001de8:	0f013f83          	ld	t6,240(sp)
    80001dec:	10010113          	addi	sp,sp,256
    80001df0:	10200073          	sret
    80001df4:	00000013          	nop
    80001df8:	00000013          	nop
    80001dfc:	00000013          	nop

0000000080001e00 <timervec>:
    80001e00:	34051573          	csrrw	a0,mscratch,a0
    80001e04:	00b53023          	sd	a1,0(a0)
    80001e08:	00c53423          	sd	a2,8(a0)
    80001e0c:	00d53823          	sd	a3,16(a0)
    80001e10:	01853583          	ld	a1,24(a0)
    80001e14:	02053603          	ld	a2,32(a0)
    80001e18:	0005b683          	ld	a3,0(a1)
    80001e1c:	00c686b3          	add	a3,a3,a2
    80001e20:	00d5b023          	sd	a3,0(a1)
    80001e24:	00200593          	li	a1,2
    80001e28:	14459073          	csrw	sip,a1
    80001e2c:	01053683          	ld	a3,16(a0)
    80001e30:	00853603          	ld	a2,8(a0)
    80001e34:	00053583          	ld	a1,0(a0)
    80001e38:	34051573          	csrrw	a0,mscratch,a0
    80001e3c:	30200073          	mret

0000000080001e40 <plicinit>:
    80001e40:	ff010113          	addi	sp,sp,-16
    80001e44:	00813423          	sd	s0,8(sp)
    80001e48:	01010413          	addi	s0,sp,16
    80001e4c:	00813403          	ld	s0,8(sp)
    80001e50:	0c0007b7          	lui	a5,0xc000
    80001e54:	00100713          	li	a4,1
    80001e58:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001e5c:	00e7a223          	sw	a4,4(a5)
    80001e60:	01010113          	addi	sp,sp,16
    80001e64:	00008067          	ret

0000000080001e68 <plicinithart>:
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00813023          	sd	s0,0(sp)
    80001e70:	00113423          	sd	ra,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    80001e78:	00000097          	auipc	ra,0x0
    80001e7c:	a4c080e7          	jalr	-1460(ra) # 800018c4 <cpuid>
    80001e80:	0085171b          	slliw	a4,a0,0x8
    80001e84:	0c0027b7          	lui	a5,0xc002
    80001e88:	00e787b3          	add	a5,a5,a4
    80001e8c:	40200713          	li	a4,1026
    80001e90:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001e94:	00813083          	ld	ra,8(sp)
    80001e98:	00013403          	ld	s0,0(sp)
    80001e9c:	00d5151b          	slliw	a0,a0,0xd
    80001ea0:	0c2017b7          	lui	a5,0xc201
    80001ea4:	00a78533          	add	a0,a5,a0
    80001ea8:	00052023          	sw	zero,0(a0)
    80001eac:	01010113          	addi	sp,sp,16
    80001eb0:	00008067          	ret

0000000080001eb4 <plic_claim>:
    80001eb4:	ff010113          	addi	sp,sp,-16
    80001eb8:	00813023          	sd	s0,0(sp)
    80001ebc:	00113423          	sd	ra,8(sp)
    80001ec0:	01010413          	addi	s0,sp,16
    80001ec4:	00000097          	auipc	ra,0x0
    80001ec8:	a00080e7          	jalr	-1536(ra) # 800018c4 <cpuid>
    80001ecc:	00813083          	ld	ra,8(sp)
    80001ed0:	00013403          	ld	s0,0(sp)
    80001ed4:	00d5151b          	slliw	a0,a0,0xd
    80001ed8:	0c2017b7          	lui	a5,0xc201
    80001edc:	00a78533          	add	a0,a5,a0
    80001ee0:	00452503          	lw	a0,4(a0)
    80001ee4:	01010113          	addi	sp,sp,16
    80001ee8:	00008067          	ret

0000000080001eec <plic_complete>:
    80001eec:	fe010113          	addi	sp,sp,-32
    80001ef0:	00813823          	sd	s0,16(sp)
    80001ef4:	00913423          	sd	s1,8(sp)
    80001ef8:	00113c23          	sd	ra,24(sp)
    80001efc:	02010413          	addi	s0,sp,32
    80001f00:	00050493          	mv	s1,a0
    80001f04:	00000097          	auipc	ra,0x0
    80001f08:	9c0080e7          	jalr	-1600(ra) # 800018c4 <cpuid>
    80001f0c:	01813083          	ld	ra,24(sp)
    80001f10:	01013403          	ld	s0,16(sp)
    80001f14:	00d5179b          	slliw	a5,a0,0xd
    80001f18:	0c201737          	lui	a4,0xc201
    80001f1c:	00f707b3          	add	a5,a4,a5
    80001f20:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001f24:	00813483          	ld	s1,8(sp)
    80001f28:	02010113          	addi	sp,sp,32
    80001f2c:	00008067          	ret

0000000080001f30 <consolewrite>:
    80001f30:	fb010113          	addi	sp,sp,-80
    80001f34:	04813023          	sd	s0,64(sp)
    80001f38:	04113423          	sd	ra,72(sp)
    80001f3c:	02913c23          	sd	s1,56(sp)
    80001f40:	03213823          	sd	s2,48(sp)
    80001f44:	03313423          	sd	s3,40(sp)
    80001f48:	03413023          	sd	s4,32(sp)
    80001f4c:	01513c23          	sd	s5,24(sp)
    80001f50:	05010413          	addi	s0,sp,80
    80001f54:	06c05c63          	blez	a2,80001fcc <consolewrite+0x9c>
    80001f58:	00060993          	mv	s3,a2
    80001f5c:	00050a13          	mv	s4,a0
    80001f60:	00058493          	mv	s1,a1
    80001f64:	00000913          	li	s2,0
    80001f68:	fff00a93          	li	s5,-1
    80001f6c:	01c0006f          	j	80001f88 <consolewrite+0x58>
    80001f70:	fbf44503          	lbu	a0,-65(s0)
    80001f74:	0019091b          	addiw	s2,s2,1
    80001f78:	00148493          	addi	s1,s1,1
    80001f7c:	00001097          	auipc	ra,0x1
    80001f80:	a9c080e7          	jalr	-1380(ra) # 80002a18 <uartputc>
    80001f84:	03298063          	beq	s3,s2,80001fa4 <consolewrite+0x74>
    80001f88:	00048613          	mv	a2,s1
    80001f8c:	00100693          	li	a3,1
    80001f90:	000a0593          	mv	a1,s4
    80001f94:	fbf40513          	addi	a0,s0,-65
    80001f98:	00000097          	auipc	ra,0x0
    80001f9c:	9e4080e7          	jalr	-1564(ra) # 8000197c <either_copyin>
    80001fa0:	fd5518e3          	bne	a0,s5,80001f70 <consolewrite+0x40>
    80001fa4:	04813083          	ld	ra,72(sp)
    80001fa8:	04013403          	ld	s0,64(sp)
    80001fac:	03813483          	ld	s1,56(sp)
    80001fb0:	02813983          	ld	s3,40(sp)
    80001fb4:	02013a03          	ld	s4,32(sp)
    80001fb8:	01813a83          	ld	s5,24(sp)
    80001fbc:	00090513          	mv	a0,s2
    80001fc0:	03013903          	ld	s2,48(sp)
    80001fc4:	05010113          	addi	sp,sp,80
    80001fc8:	00008067          	ret
    80001fcc:	00000913          	li	s2,0
    80001fd0:	fd5ff06f          	j	80001fa4 <consolewrite+0x74>

0000000080001fd4 <consoleread>:
    80001fd4:	f9010113          	addi	sp,sp,-112
    80001fd8:	06813023          	sd	s0,96(sp)
    80001fdc:	04913c23          	sd	s1,88(sp)
    80001fe0:	05213823          	sd	s2,80(sp)
    80001fe4:	05313423          	sd	s3,72(sp)
    80001fe8:	05413023          	sd	s4,64(sp)
    80001fec:	03513c23          	sd	s5,56(sp)
    80001ff0:	03613823          	sd	s6,48(sp)
    80001ff4:	03713423          	sd	s7,40(sp)
    80001ff8:	03813023          	sd	s8,32(sp)
    80001ffc:	06113423          	sd	ra,104(sp)
    80002000:	01913c23          	sd	s9,24(sp)
    80002004:	07010413          	addi	s0,sp,112
    80002008:	00060b93          	mv	s7,a2
    8000200c:	00050913          	mv	s2,a0
    80002010:	00058c13          	mv	s8,a1
    80002014:	00060b1b          	sext.w	s6,a2
    80002018:	00003497          	auipc	s1,0x3
    8000201c:	55048493          	addi	s1,s1,1360 # 80005568 <cons>
    80002020:	00400993          	li	s3,4
    80002024:	fff00a13          	li	s4,-1
    80002028:	00a00a93          	li	s5,10
    8000202c:	05705e63          	blez	s7,80002088 <consoleread+0xb4>
    80002030:	09c4a703          	lw	a4,156(s1)
    80002034:	0984a783          	lw	a5,152(s1)
    80002038:	0007071b          	sext.w	a4,a4
    8000203c:	08e78463          	beq	a5,a4,800020c4 <consoleread+0xf0>
    80002040:	07f7f713          	andi	a4,a5,127
    80002044:	00e48733          	add	a4,s1,a4
    80002048:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000204c:	0017869b          	addiw	a3,a5,1
    80002050:	08d4ac23          	sw	a3,152(s1)
    80002054:	00070c9b          	sext.w	s9,a4
    80002058:	0b370663          	beq	a4,s3,80002104 <consoleread+0x130>
    8000205c:	00100693          	li	a3,1
    80002060:	f9f40613          	addi	a2,s0,-97
    80002064:	000c0593          	mv	a1,s8
    80002068:	00090513          	mv	a0,s2
    8000206c:	f8e40fa3          	sb	a4,-97(s0)
    80002070:	00000097          	auipc	ra,0x0
    80002074:	8c0080e7          	jalr	-1856(ra) # 80001930 <either_copyout>
    80002078:	01450863          	beq	a0,s4,80002088 <consoleread+0xb4>
    8000207c:	001c0c13          	addi	s8,s8,1
    80002080:	fffb8b9b          	addiw	s7,s7,-1
    80002084:	fb5c94e3          	bne	s9,s5,8000202c <consoleread+0x58>
    80002088:	000b851b          	sext.w	a0,s7
    8000208c:	06813083          	ld	ra,104(sp)
    80002090:	06013403          	ld	s0,96(sp)
    80002094:	05813483          	ld	s1,88(sp)
    80002098:	05013903          	ld	s2,80(sp)
    8000209c:	04813983          	ld	s3,72(sp)
    800020a0:	04013a03          	ld	s4,64(sp)
    800020a4:	03813a83          	ld	s5,56(sp)
    800020a8:	02813b83          	ld	s7,40(sp)
    800020ac:	02013c03          	ld	s8,32(sp)
    800020b0:	01813c83          	ld	s9,24(sp)
    800020b4:	40ab053b          	subw	a0,s6,a0
    800020b8:	03013b03          	ld	s6,48(sp)
    800020bc:	07010113          	addi	sp,sp,112
    800020c0:	00008067          	ret
    800020c4:	00001097          	auipc	ra,0x1
    800020c8:	1d8080e7          	jalr	472(ra) # 8000329c <push_on>
    800020cc:	0984a703          	lw	a4,152(s1)
    800020d0:	09c4a783          	lw	a5,156(s1)
    800020d4:	0007879b          	sext.w	a5,a5
    800020d8:	fef70ce3          	beq	a4,a5,800020d0 <consoleread+0xfc>
    800020dc:	00001097          	auipc	ra,0x1
    800020e0:	234080e7          	jalr	564(ra) # 80003310 <pop_on>
    800020e4:	0984a783          	lw	a5,152(s1)
    800020e8:	07f7f713          	andi	a4,a5,127
    800020ec:	00e48733          	add	a4,s1,a4
    800020f0:	01874703          	lbu	a4,24(a4)
    800020f4:	0017869b          	addiw	a3,a5,1
    800020f8:	08d4ac23          	sw	a3,152(s1)
    800020fc:	00070c9b          	sext.w	s9,a4
    80002100:	f5371ee3          	bne	a4,s3,8000205c <consoleread+0x88>
    80002104:	000b851b          	sext.w	a0,s7
    80002108:	f96bf2e3          	bgeu	s7,s6,8000208c <consoleread+0xb8>
    8000210c:	08f4ac23          	sw	a5,152(s1)
    80002110:	f7dff06f          	j	8000208c <consoleread+0xb8>

0000000080002114 <consputc>:
    80002114:	10000793          	li	a5,256
    80002118:	00f50663          	beq	a0,a5,80002124 <consputc+0x10>
    8000211c:	00001317          	auipc	t1,0x1
    80002120:	9f430067          	jr	-1548(t1) # 80002b10 <uartputc_sync>
    80002124:	ff010113          	addi	sp,sp,-16
    80002128:	00113423          	sd	ra,8(sp)
    8000212c:	00813023          	sd	s0,0(sp)
    80002130:	01010413          	addi	s0,sp,16
    80002134:	00800513          	li	a0,8
    80002138:	00001097          	auipc	ra,0x1
    8000213c:	9d8080e7          	jalr	-1576(ra) # 80002b10 <uartputc_sync>
    80002140:	02000513          	li	a0,32
    80002144:	00001097          	auipc	ra,0x1
    80002148:	9cc080e7          	jalr	-1588(ra) # 80002b10 <uartputc_sync>
    8000214c:	00013403          	ld	s0,0(sp)
    80002150:	00813083          	ld	ra,8(sp)
    80002154:	00800513          	li	a0,8
    80002158:	01010113          	addi	sp,sp,16
    8000215c:	00001317          	auipc	t1,0x1
    80002160:	9b430067          	jr	-1612(t1) # 80002b10 <uartputc_sync>

0000000080002164 <consoleintr>:
    80002164:	fe010113          	addi	sp,sp,-32
    80002168:	00813823          	sd	s0,16(sp)
    8000216c:	00913423          	sd	s1,8(sp)
    80002170:	01213023          	sd	s2,0(sp)
    80002174:	00113c23          	sd	ra,24(sp)
    80002178:	02010413          	addi	s0,sp,32
    8000217c:	00003917          	auipc	s2,0x3
    80002180:	3ec90913          	addi	s2,s2,1004 # 80005568 <cons>
    80002184:	00050493          	mv	s1,a0
    80002188:	00090513          	mv	a0,s2
    8000218c:	00001097          	auipc	ra,0x1
    80002190:	e40080e7          	jalr	-448(ra) # 80002fcc <acquire>
    80002194:	02048c63          	beqz	s1,800021cc <consoleintr+0x68>
    80002198:	0a092783          	lw	a5,160(s2)
    8000219c:	09892703          	lw	a4,152(s2)
    800021a0:	07f00693          	li	a3,127
    800021a4:	40e7873b          	subw	a4,a5,a4
    800021a8:	02e6e263          	bltu	a3,a4,800021cc <consoleintr+0x68>
    800021ac:	00d00713          	li	a4,13
    800021b0:	04e48063          	beq	s1,a4,800021f0 <consoleintr+0x8c>
    800021b4:	07f7f713          	andi	a4,a5,127
    800021b8:	00e90733          	add	a4,s2,a4
    800021bc:	0017879b          	addiw	a5,a5,1
    800021c0:	0af92023          	sw	a5,160(s2)
    800021c4:	00970c23          	sb	s1,24(a4)
    800021c8:	08f92e23          	sw	a5,156(s2)
    800021cc:	01013403          	ld	s0,16(sp)
    800021d0:	01813083          	ld	ra,24(sp)
    800021d4:	00813483          	ld	s1,8(sp)
    800021d8:	00013903          	ld	s2,0(sp)
    800021dc:	00003517          	auipc	a0,0x3
    800021e0:	38c50513          	addi	a0,a0,908 # 80005568 <cons>
    800021e4:	02010113          	addi	sp,sp,32
    800021e8:	00001317          	auipc	t1,0x1
    800021ec:	eb030067          	jr	-336(t1) # 80003098 <release>
    800021f0:	00a00493          	li	s1,10
    800021f4:	fc1ff06f          	j	800021b4 <consoleintr+0x50>

00000000800021f8 <consoleinit>:
    800021f8:	fe010113          	addi	sp,sp,-32
    800021fc:	00113c23          	sd	ra,24(sp)
    80002200:	00813823          	sd	s0,16(sp)
    80002204:	00913423          	sd	s1,8(sp)
    80002208:	02010413          	addi	s0,sp,32
    8000220c:	00003497          	auipc	s1,0x3
    80002210:	35c48493          	addi	s1,s1,860 # 80005568 <cons>
    80002214:	00048513          	mv	a0,s1
    80002218:	00002597          	auipc	a1,0x2
    8000221c:	f4058593          	addi	a1,a1,-192 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    80002220:	00001097          	auipc	ra,0x1
    80002224:	d88080e7          	jalr	-632(ra) # 80002fa8 <initlock>
    80002228:	00000097          	auipc	ra,0x0
    8000222c:	7ac080e7          	jalr	1964(ra) # 800029d4 <uartinit>
    80002230:	01813083          	ld	ra,24(sp)
    80002234:	01013403          	ld	s0,16(sp)
    80002238:	00000797          	auipc	a5,0x0
    8000223c:	d9c78793          	addi	a5,a5,-612 # 80001fd4 <consoleread>
    80002240:	0af4bc23          	sd	a5,184(s1)
    80002244:	00000797          	auipc	a5,0x0
    80002248:	cec78793          	addi	a5,a5,-788 # 80001f30 <consolewrite>
    8000224c:	0cf4b023          	sd	a5,192(s1)
    80002250:	00813483          	ld	s1,8(sp)
    80002254:	02010113          	addi	sp,sp,32
    80002258:	00008067          	ret

000000008000225c <console_read>:
    8000225c:	ff010113          	addi	sp,sp,-16
    80002260:	00813423          	sd	s0,8(sp)
    80002264:	01010413          	addi	s0,sp,16
    80002268:	00813403          	ld	s0,8(sp)
    8000226c:	00003317          	auipc	t1,0x3
    80002270:	3b433303          	ld	t1,948(t1) # 80005620 <devsw+0x10>
    80002274:	01010113          	addi	sp,sp,16
    80002278:	00030067          	jr	t1

000000008000227c <console_write>:
    8000227c:	ff010113          	addi	sp,sp,-16
    80002280:	00813423          	sd	s0,8(sp)
    80002284:	01010413          	addi	s0,sp,16
    80002288:	00813403          	ld	s0,8(sp)
    8000228c:	00003317          	auipc	t1,0x3
    80002290:	39c33303          	ld	t1,924(t1) # 80005628 <devsw+0x18>
    80002294:	01010113          	addi	sp,sp,16
    80002298:	00030067          	jr	t1

000000008000229c <panic>:
    8000229c:	fe010113          	addi	sp,sp,-32
    800022a0:	00113c23          	sd	ra,24(sp)
    800022a4:	00813823          	sd	s0,16(sp)
    800022a8:	00913423          	sd	s1,8(sp)
    800022ac:	02010413          	addi	s0,sp,32
    800022b0:	00050493          	mv	s1,a0
    800022b4:	00002517          	auipc	a0,0x2
    800022b8:	eac50513          	addi	a0,a0,-340 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    800022bc:	00003797          	auipc	a5,0x3
    800022c0:	4007a623          	sw	zero,1036(a5) # 800056c8 <pr+0x18>
    800022c4:	00000097          	auipc	ra,0x0
    800022c8:	034080e7          	jalr	52(ra) # 800022f8 <__printf>
    800022cc:	00048513          	mv	a0,s1
    800022d0:	00000097          	auipc	ra,0x0
    800022d4:	028080e7          	jalr	40(ra) # 800022f8 <__printf>
    800022d8:	00002517          	auipc	a0,0x2
    800022dc:	e6850513          	addi	a0,a0,-408 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    800022e0:	00000097          	auipc	ra,0x0
    800022e4:	018080e7          	jalr	24(ra) # 800022f8 <__printf>
    800022e8:	00100793          	li	a5,1
    800022ec:	00002717          	auipc	a4,0x2
    800022f0:	16f72e23          	sw	a5,380(a4) # 80004468 <panicked>
    800022f4:	0000006f          	j	800022f4 <panic+0x58>

00000000800022f8 <__printf>:
    800022f8:	f3010113          	addi	sp,sp,-208
    800022fc:	08813023          	sd	s0,128(sp)
    80002300:	07313423          	sd	s3,104(sp)
    80002304:	09010413          	addi	s0,sp,144
    80002308:	05813023          	sd	s8,64(sp)
    8000230c:	08113423          	sd	ra,136(sp)
    80002310:	06913c23          	sd	s1,120(sp)
    80002314:	07213823          	sd	s2,112(sp)
    80002318:	07413023          	sd	s4,96(sp)
    8000231c:	05513c23          	sd	s5,88(sp)
    80002320:	05613823          	sd	s6,80(sp)
    80002324:	05713423          	sd	s7,72(sp)
    80002328:	03913c23          	sd	s9,56(sp)
    8000232c:	03a13823          	sd	s10,48(sp)
    80002330:	03b13423          	sd	s11,40(sp)
    80002334:	00003317          	auipc	t1,0x3
    80002338:	37c30313          	addi	t1,t1,892 # 800056b0 <pr>
    8000233c:	01832c03          	lw	s8,24(t1)
    80002340:	00b43423          	sd	a1,8(s0)
    80002344:	00c43823          	sd	a2,16(s0)
    80002348:	00d43c23          	sd	a3,24(s0)
    8000234c:	02e43023          	sd	a4,32(s0)
    80002350:	02f43423          	sd	a5,40(s0)
    80002354:	03043823          	sd	a6,48(s0)
    80002358:	03143c23          	sd	a7,56(s0)
    8000235c:	00050993          	mv	s3,a0
    80002360:	4a0c1663          	bnez	s8,8000280c <__printf+0x514>
    80002364:	60098c63          	beqz	s3,8000297c <__printf+0x684>
    80002368:	0009c503          	lbu	a0,0(s3)
    8000236c:	00840793          	addi	a5,s0,8
    80002370:	f6f43c23          	sd	a5,-136(s0)
    80002374:	00000493          	li	s1,0
    80002378:	22050063          	beqz	a0,80002598 <__printf+0x2a0>
    8000237c:	00002a37          	lui	s4,0x2
    80002380:	00018ab7          	lui	s5,0x18
    80002384:	000f4b37          	lui	s6,0xf4
    80002388:	00989bb7          	lui	s7,0x989
    8000238c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002390:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002394:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002398:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000239c:	00148c9b          	addiw	s9,s1,1
    800023a0:	02500793          	li	a5,37
    800023a4:	01998933          	add	s2,s3,s9
    800023a8:	38f51263          	bne	a0,a5,8000272c <__printf+0x434>
    800023ac:	00094783          	lbu	a5,0(s2)
    800023b0:	00078c9b          	sext.w	s9,a5
    800023b4:	1e078263          	beqz	a5,80002598 <__printf+0x2a0>
    800023b8:	0024849b          	addiw	s1,s1,2
    800023bc:	07000713          	li	a4,112
    800023c0:	00998933          	add	s2,s3,s1
    800023c4:	38e78a63          	beq	a5,a4,80002758 <__printf+0x460>
    800023c8:	20f76863          	bltu	a4,a5,800025d8 <__printf+0x2e0>
    800023cc:	42a78863          	beq	a5,a0,800027fc <__printf+0x504>
    800023d0:	06400713          	li	a4,100
    800023d4:	40e79663          	bne	a5,a4,800027e0 <__printf+0x4e8>
    800023d8:	f7843783          	ld	a5,-136(s0)
    800023dc:	0007a603          	lw	a2,0(a5)
    800023e0:	00878793          	addi	a5,a5,8
    800023e4:	f6f43c23          	sd	a5,-136(s0)
    800023e8:	42064a63          	bltz	a2,8000281c <__printf+0x524>
    800023ec:	00a00713          	li	a4,10
    800023f0:	02e677bb          	remuw	a5,a2,a4
    800023f4:	00002d97          	auipc	s11,0x2
    800023f8:	d94d8d93          	addi	s11,s11,-620 # 80004188 <digits>
    800023fc:	00900593          	li	a1,9
    80002400:	0006051b          	sext.w	a0,a2
    80002404:	00000c93          	li	s9,0
    80002408:	02079793          	slli	a5,a5,0x20
    8000240c:	0207d793          	srli	a5,a5,0x20
    80002410:	00fd87b3          	add	a5,s11,a5
    80002414:	0007c783          	lbu	a5,0(a5)
    80002418:	02e656bb          	divuw	a3,a2,a4
    8000241c:	f8f40023          	sb	a5,-128(s0)
    80002420:	14c5d863          	bge	a1,a2,80002570 <__printf+0x278>
    80002424:	06300593          	li	a1,99
    80002428:	00100c93          	li	s9,1
    8000242c:	02e6f7bb          	remuw	a5,a3,a4
    80002430:	02079793          	slli	a5,a5,0x20
    80002434:	0207d793          	srli	a5,a5,0x20
    80002438:	00fd87b3          	add	a5,s11,a5
    8000243c:	0007c783          	lbu	a5,0(a5)
    80002440:	02e6d73b          	divuw	a4,a3,a4
    80002444:	f8f400a3          	sb	a5,-127(s0)
    80002448:	12a5f463          	bgeu	a1,a0,80002570 <__printf+0x278>
    8000244c:	00a00693          	li	a3,10
    80002450:	00900593          	li	a1,9
    80002454:	02d777bb          	remuw	a5,a4,a3
    80002458:	02079793          	slli	a5,a5,0x20
    8000245c:	0207d793          	srli	a5,a5,0x20
    80002460:	00fd87b3          	add	a5,s11,a5
    80002464:	0007c503          	lbu	a0,0(a5)
    80002468:	02d757bb          	divuw	a5,a4,a3
    8000246c:	f8a40123          	sb	a0,-126(s0)
    80002470:	48e5f263          	bgeu	a1,a4,800028f4 <__printf+0x5fc>
    80002474:	06300513          	li	a0,99
    80002478:	02d7f5bb          	remuw	a1,a5,a3
    8000247c:	02059593          	slli	a1,a1,0x20
    80002480:	0205d593          	srli	a1,a1,0x20
    80002484:	00bd85b3          	add	a1,s11,a1
    80002488:	0005c583          	lbu	a1,0(a1)
    8000248c:	02d7d7bb          	divuw	a5,a5,a3
    80002490:	f8b401a3          	sb	a1,-125(s0)
    80002494:	48e57263          	bgeu	a0,a4,80002918 <__printf+0x620>
    80002498:	3e700513          	li	a0,999
    8000249c:	02d7f5bb          	remuw	a1,a5,a3
    800024a0:	02059593          	slli	a1,a1,0x20
    800024a4:	0205d593          	srli	a1,a1,0x20
    800024a8:	00bd85b3          	add	a1,s11,a1
    800024ac:	0005c583          	lbu	a1,0(a1)
    800024b0:	02d7d7bb          	divuw	a5,a5,a3
    800024b4:	f8b40223          	sb	a1,-124(s0)
    800024b8:	46e57663          	bgeu	a0,a4,80002924 <__printf+0x62c>
    800024bc:	02d7f5bb          	remuw	a1,a5,a3
    800024c0:	02059593          	slli	a1,a1,0x20
    800024c4:	0205d593          	srli	a1,a1,0x20
    800024c8:	00bd85b3          	add	a1,s11,a1
    800024cc:	0005c583          	lbu	a1,0(a1)
    800024d0:	02d7d7bb          	divuw	a5,a5,a3
    800024d4:	f8b402a3          	sb	a1,-123(s0)
    800024d8:	46ea7863          	bgeu	s4,a4,80002948 <__printf+0x650>
    800024dc:	02d7f5bb          	remuw	a1,a5,a3
    800024e0:	02059593          	slli	a1,a1,0x20
    800024e4:	0205d593          	srli	a1,a1,0x20
    800024e8:	00bd85b3          	add	a1,s11,a1
    800024ec:	0005c583          	lbu	a1,0(a1)
    800024f0:	02d7d7bb          	divuw	a5,a5,a3
    800024f4:	f8b40323          	sb	a1,-122(s0)
    800024f8:	3eeaf863          	bgeu	s5,a4,800028e8 <__printf+0x5f0>
    800024fc:	02d7f5bb          	remuw	a1,a5,a3
    80002500:	02059593          	slli	a1,a1,0x20
    80002504:	0205d593          	srli	a1,a1,0x20
    80002508:	00bd85b3          	add	a1,s11,a1
    8000250c:	0005c583          	lbu	a1,0(a1)
    80002510:	02d7d7bb          	divuw	a5,a5,a3
    80002514:	f8b403a3          	sb	a1,-121(s0)
    80002518:	42eb7e63          	bgeu	s6,a4,80002954 <__printf+0x65c>
    8000251c:	02d7f5bb          	remuw	a1,a5,a3
    80002520:	02059593          	slli	a1,a1,0x20
    80002524:	0205d593          	srli	a1,a1,0x20
    80002528:	00bd85b3          	add	a1,s11,a1
    8000252c:	0005c583          	lbu	a1,0(a1)
    80002530:	02d7d7bb          	divuw	a5,a5,a3
    80002534:	f8b40423          	sb	a1,-120(s0)
    80002538:	42ebfc63          	bgeu	s7,a4,80002970 <__printf+0x678>
    8000253c:	02079793          	slli	a5,a5,0x20
    80002540:	0207d793          	srli	a5,a5,0x20
    80002544:	00fd8db3          	add	s11,s11,a5
    80002548:	000dc703          	lbu	a4,0(s11)
    8000254c:	00a00793          	li	a5,10
    80002550:	00900c93          	li	s9,9
    80002554:	f8e404a3          	sb	a4,-119(s0)
    80002558:	00065c63          	bgez	a2,80002570 <__printf+0x278>
    8000255c:	f9040713          	addi	a4,s0,-112
    80002560:	00f70733          	add	a4,a4,a5
    80002564:	02d00693          	li	a3,45
    80002568:	fed70823          	sb	a3,-16(a4)
    8000256c:	00078c93          	mv	s9,a5
    80002570:	f8040793          	addi	a5,s0,-128
    80002574:	01978cb3          	add	s9,a5,s9
    80002578:	f7f40d13          	addi	s10,s0,-129
    8000257c:	000cc503          	lbu	a0,0(s9)
    80002580:	fffc8c93          	addi	s9,s9,-1
    80002584:	00000097          	auipc	ra,0x0
    80002588:	b90080e7          	jalr	-1136(ra) # 80002114 <consputc>
    8000258c:	ffac98e3          	bne	s9,s10,8000257c <__printf+0x284>
    80002590:	00094503          	lbu	a0,0(s2)
    80002594:	e00514e3          	bnez	a0,8000239c <__printf+0xa4>
    80002598:	1a0c1663          	bnez	s8,80002744 <__printf+0x44c>
    8000259c:	08813083          	ld	ra,136(sp)
    800025a0:	08013403          	ld	s0,128(sp)
    800025a4:	07813483          	ld	s1,120(sp)
    800025a8:	07013903          	ld	s2,112(sp)
    800025ac:	06813983          	ld	s3,104(sp)
    800025b0:	06013a03          	ld	s4,96(sp)
    800025b4:	05813a83          	ld	s5,88(sp)
    800025b8:	05013b03          	ld	s6,80(sp)
    800025bc:	04813b83          	ld	s7,72(sp)
    800025c0:	04013c03          	ld	s8,64(sp)
    800025c4:	03813c83          	ld	s9,56(sp)
    800025c8:	03013d03          	ld	s10,48(sp)
    800025cc:	02813d83          	ld	s11,40(sp)
    800025d0:	0d010113          	addi	sp,sp,208
    800025d4:	00008067          	ret
    800025d8:	07300713          	li	a4,115
    800025dc:	1ce78a63          	beq	a5,a4,800027b0 <__printf+0x4b8>
    800025e0:	07800713          	li	a4,120
    800025e4:	1ee79e63          	bne	a5,a4,800027e0 <__printf+0x4e8>
    800025e8:	f7843783          	ld	a5,-136(s0)
    800025ec:	0007a703          	lw	a4,0(a5)
    800025f0:	00878793          	addi	a5,a5,8
    800025f4:	f6f43c23          	sd	a5,-136(s0)
    800025f8:	28074263          	bltz	a4,8000287c <__printf+0x584>
    800025fc:	00002d97          	auipc	s11,0x2
    80002600:	b8cd8d93          	addi	s11,s11,-1140 # 80004188 <digits>
    80002604:	00f77793          	andi	a5,a4,15
    80002608:	00fd87b3          	add	a5,s11,a5
    8000260c:	0007c683          	lbu	a3,0(a5)
    80002610:	00f00613          	li	a2,15
    80002614:	0007079b          	sext.w	a5,a4
    80002618:	f8d40023          	sb	a3,-128(s0)
    8000261c:	0047559b          	srliw	a1,a4,0x4
    80002620:	0047569b          	srliw	a3,a4,0x4
    80002624:	00000c93          	li	s9,0
    80002628:	0ee65063          	bge	a2,a4,80002708 <__printf+0x410>
    8000262c:	00f6f693          	andi	a3,a3,15
    80002630:	00dd86b3          	add	a3,s11,a3
    80002634:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002638:	0087d79b          	srliw	a5,a5,0x8
    8000263c:	00100c93          	li	s9,1
    80002640:	f8d400a3          	sb	a3,-127(s0)
    80002644:	0cb67263          	bgeu	a2,a1,80002708 <__printf+0x410>
    80002648:	00f7f693          	andi	a3,a5,15
    8000264c:	00dd86b3          	add	a3,s11,a3
    80002650:	0006c583          	lbu	a1,0(a3)
    80002654:	00f00613          	li	a2,15
    80002658:	0047d69b          	srliw	a3,a5,0x4
    8000265c:	f8b40123          	sb	a1,-126(s0)
    80002660:	0047d593          	srli	a1,a5,0x4
    80002664:	28f67e63          	bgeu	a2,a5,80002900 <__printf+0x608>
    80002668:	00f6f693          	andi	a3,a3,15
    8000266c:	00dd86b3          	add	a3,s11,a3
    80002670:	0006c503          	lbu	a0,0(a3)
    80002674:	0087d813          	srli	a6,a5,0x8
    80002678:	0087d69b          	srliw	a3,a5,0x8
    8000267c:	f8a401a3          	sb	a0,-125(s0)
    80002680:	28b67663          	bgeu	a2,a1,8000290c <__printf+0x614>
    80002684:	00f6f693          	andi	a3,a3,15
    80002688:	00dd86b3          	add	a3,s11,a3
    8000268c:	0006c583          	lbu	a1,0(a3)
    80002690:	00c7d513          	srli	a0,a5,0xc
    80002694:	00c7d69b          	srliw	a3,a5,0xc
    80002698:	f8b40223          	sb	a1,-124(s0)
    8000269c:	29067a63          	bgeu	a2,a6,80002930 <__printf+0x638>
    800026a0:	00f6f693          	andi	a3,a3,15
    800026a4:	00dd86b3          	add	a3,s11,a3
    800026a8:	0006c583          	lbu	a1,0(a3)
    800026ac:	0107d813          	srli	a6,a5,0x10
    800026b0:	0107d69b          	srliw	a3,a5,0x10
    800026b4:	f8b402a3          	sb	a1,-123(s0)
    800026b8:	28a67263          	bgeu	a2,a0,8000293c <__printf+0x644>
    800026bc:	00f6f693          	andi	a3,a3,15
    800026c0:	00dd86b3          	add	a3,s11,a3
    800026c4:	0006c683          	lbu	a3,0(a3)
    800026c8:	0147d79b          	srliw	a5,a5,0x14
    800026cc:	f8d40323          	sb	a3,-122(s0)
    800026d0:	21067663          	bgeu	a2,a6,800028dc <__printf+0x5e4>
    800026d4:	02079793          	slli	a5,a5,0x20
    800026d8:	0207d793          	srli	a5,a5,0x20
    800026dc:	00fd8db3          	add	s11,s11,a5
    800026e0:	000dc683          	lbu	a3,0(s11)
    800026e4:	00800793          	li	a5,8
    800026e8:	00700c93          	li	s9,7
    800026ec:	f8d403a3          	sb	a3,-121(s0)
    800026f0:	00075c63          	bgez	a4,80002708 <__printf+0x410>
    800026f4:	f9040713          	addi	a4,s0,-112
    800026f8:	00f70733          	add	a4,a4,a5
    800026fc:	02d00693          	li	a3,45
    80002700:	fed70823          	sb	a3,-16(a4)
    80002704:	00078c93          	mv	s9,a5
    80002708:	f8040793          	addi	a5,s0,-128
    8000270c:	01978cb3          	add	s9,a5,s9
    80002710:	f7f40d13          	addi	s10,s0,-129
    80002714:	000cc503          	lbu	a0,0(s9)
    80002718:	fffc8c93          	addi	s9,s9,-1
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	9f8080e7          	jalr	-1544(ra) # 80002114 <consputc>
    80002724:	ff9d18e3          	bne	s10,s9,80002714 <__printf+0x41c>
    80002728:	0100006f          	j	80002738 <__printf+0x440>
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	9e8080e7          	jalr	-1560(ra) # 80002114 <consputc>
    80002734:	000c8493          	mv	s1,s9
    80002738:	00094503          	lbu	a0,0(s2)
    8000273c:	c60510e3          	bnez	a0,8000239c <__printf+0xa4>
    80002740:	e40c0ee3          	beqz	s8,8000259c <__printf+0x2a4>
    80002744:	00003517          	auipc	a0,0x3
    80002748:	f6c50513          	addi	a0,a0,-148 # 800056b0 <pr>
    8000274c:	00001097          	auipc	ra,0x1
    80002750:	94c080e7          	jalr	-1716(ra) # 80003098 <release>
    80002754:	e49ff06f          	j	8000259c <__printf+0x2a4>
    80002758:	f7843783          	ld	a5,-136(s0)
    8000275c:	03000513          	li	a0,48
    80002760:	01000d13          	li	s10,16
    80002764:	00878713          	addi	a4,a5,8
    80002768:	0007bc83          	ld	s9,0(a5)
    8000276c:	f6e43c23          	sd	a4,-136(s0)
    80002770:	00000097          	auipc	ra,0x0
    80002774:	9a4080e7          	jalr	-1628(ra) # 80002114 <consputc>
    80002778:	07800513          	li	a0,120
    8000277c:	00000097          	auipc	ra,0x0
    80002780:	998080e7          	jalr	-1640(ra) # 80002114 <consputc>
    80002784:	00002d97          	auipc	s11,0x2
    80002788:	a04d8d93          	addi	s11,s11,-1532 # 80004188 <digits>
    8000278c:	03ccd793          	srli	a5,s9,0x3c
    80002790:	00fd87b3          	add	a5,s11,a5
    80002794:	0007c503          	lbu	a0,0(a5)
    80002798:	fffd0d1b          	addiw	s10,s10,-1
    8000279c:	004c9c93          	slli	s9,s9,0x4
    800027a0:	00000097          	auipc	ra,0x0
    800027a4:	974080e7          	jalr	-1676(ra) # 80002114 <consputc>
    800027a8:	fe0d12e3          	bnez	s10,8000278c <__printf+0x494>
    800027ac:	f8dff06f          	j	80002738 <__printf+0x440>
    800027b0:	f7843783          	ld	a5,-136(s0)
    800027b4:	0007bc83          	ld	s9,0(a5)
    800027b8:	00878793          	addi	a5,a5,8
    800027bc:	f6f43c23          	sd	a5,-136(s0)
    800027c0:	000c9a63          	bnez	s9,800027d4 <__printf+0x4dc>
    800027c4:	1080006f          	j	800028cc <__printf+0x5d4>
    800027c8:	001c8c93          	addi	s9,s9,1
    800027cc:	00000097          	auipc	ra,0x0
    800027d0:	948080e7          	jalr	-1720(ra) # 80002114 <consputc>
    800027d4:	000cc503          	lbu	a0,0(s9)
    800027d8:	fe0518e3          	bnez	a0,800027c8 <__printf+0x4d0>
    800027dc:	f5dff06f          	j	80002738 <__printf+0x440>
    800027e0:	02500513          	li	a0,37
    800027e4:	00000097          	auipc	ra,0x0
    800027e8:	930080e7          	jalr	-1744(ra) # 80002114 <consputc>
    800027ec:	000c8513          	mv	a0,s9
    800027f0:	00000097          	auipc	ra,0x0
    800027f4:	924080e7          	jalr	-1756(ra) # 80002114 <consputc>
    800027f8:	f41ff06f          	j	80002738 <__printf+0x440>
    800027fc:	02500513          	li	a0,37
    80002800:	00000097          	auipc	ra,0x0
    80002804:	914080e7          	jalr	-1772(ra) # 80002114 <consputc>
    80002808:	f31ff06f          	j	80002738 <__printf+0x440>
    8000280c:	00030513          	mv	a0,t1
    80002810:	00000097          	auipc	ra,0x0
    80002814:	7bc080e7          	jalr	1980(ra) # 80002fcc <acquire>
    80002818:	b4dff06f          	j	80002364 <__printf+0x6c>
    8000281c:	40c0053b          	negw	a0,a2
    80002820:	00a00713          	li	a4,10
    80002824:	02e576bb          	remuw	a3,a0,a4
    80002828:	00002d97          	auipc	s11,0x2
    8000282c:	960d8d93          	addi	s11,s11,-1696 # 80004188 <digits>
    80002830:	ff700593          	li	a1,-9
    80002834:	02069693          	slli	a3,a3,0x20
    80002838:	0206d693          	srli	a3,a3,0x20
    8000283c:	00dd86b3          	add	a3,s11,a3
    80002840:	0006c683          	lbu	a3,0(a3)
    80002844:	02e557bb          	divuw	a5,a0,a4
    80002848:	f8d40023          	sb	a3,-128(s0)
    8000284c:	10b65e63          	bge	a2,a1,80002968 <__printf+0x670>
    80002850:	06300593          	li	a1,99
    80002854:	02e7f6bb          	remuw	a3,a5,a4
    80002858:	02069693          	slli	a3,a3,0x20
    8000285c:	0206d693          	srli	a3,a3,0x20
    80002860:	00dd86b3          	add	a3,s11,a3
    80002864:	0006c683          	lbu	a3,0(a3)
    80002868:	02e7d73b          	divuw	a4,a5,a4
    8000286c:	00200793          	li	a5,2
    80002870:	f8d400a3          	sb	a3,-127(s0)
    80002874:	bca5ece3          	bltu	a1,a0,8000244c <__printf+0x154>
    80002878:	ce5ff06f          	j	8000255c <__printf+0x264>
    8000287c:	40e007bb          	negw	a5,a4
    80002880:	00002d97          	auipc	s11,0x2
    80002884:	908d8d93          	addi	s11,s11,-1784 # 80004188 <digits>
    80002888:	00f7f693          	andi	a3,a5,15
    8000288c:	00dd86b3          	add	a3,s11,a3
    80002890:	0006c583          	lbu	a1,0(a3)
    80002894:	ff100613          	li	a2,-15
    80002898:	0047d69b          	srliw	a3,a5,0x4
    8000289c:	f8b40023          	sb	a1,-128(s0)
    800028a0:	0047d59b          	srliw	a1,a5,0x4
    800028a4:	0ac75e63          	bge	a4,a2,80002960 <__printf+0x668>
    800028a8:	00f6f693          	andi	a3,a3,15
    800028ac:	00dd86b3          	add	a3,s11,a3
    800028b0:	0006c603          	lbu	a2,0(a3)
    800028b4:	00f00693          	li	a3,15
    800028b8:	0087d79b          	srliw	a5,a5,0x8
    800028bc:	f8c400a3          	sb	a2,-127(s0)
    800028c0:	d8b6e4e3          	bltu	a3,a1,80002648 <__printf+0x350>
    800028c4:	00200793          	li	a5,2
    800028c8:	e2dff06f          	j	800026f4 <__printf+0x3fc>
    800028cc:	00002c97          	auipc	s9,0x2
    800028d0:	89cc8c93          	addi	s9,s9,-1892 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    800028d4:	02800513          	li	a0,40
    800028d8:	ef1ff06f          	j	800027c8 <__printf+0x4d0>
    800028dc:	00700793          	li	a5,7
    800028e0:	00600c93          	li	s9,6
    800028e4:	e0dff06f          	j	800026f0 <__printf+0x3f8>
    800028e8:	00700793          	li	a5,7
    800028ec:	00600c93          	li	s9,6
    800028f0:	c69ff06f          	j	80002558 <__printf+0x260>
    800028f4:	00300793          	li	a5,3
    800028f8:	00200c93          	li	s9,2
    800028fc:	c5dff06f          	j	80002558 <__printf+0x260>
    80002900:	00300793          	li	a5,3
    80002904:	00200c93          	li	s9,2
    80002908:	de9ff06f          	j	800026f0 <__printf+0x3f8>
    8000290c:	00400793          	li	a5,4
    80002910:	00300c93          	li	s9,3
    80002914:	dddff06f          	j	800026f0 <__printf+0x3f8>
    80002918:	00400793          	li	a5,4
    8000291c:	00300c93          	li	s9,3
    80002920:	c39ff06f          	j	80002558 <__printf+0x260>
    80002924:	00500793          	li	a5,5
    80002928:	00400c93          	li	s9,4
    8000292c:	c2dff06f          	j	80002558 <__printf+0x260>
    80002930:	00500793          	li	a5,5
    80002934:	00400c93          	li	s9,4
    80002938:	db9ff06f          	j	800026f0 <__printf+0x3f8>
    8000293c:	00600793          	li	a5,6
    80002940:	00500c93          	li	s9,5
    80002944:	dadff06f          	j	800026f0 <__printf+0x3f8>
    80002948:	00600793          	li	a5,6
    8000294c:	00500c93          	li	s9,5
    80002950:	c09ff06f          	j	80002558 <__printf+0x260>
    80002954:	00800793          	li	a5,8
    80002958:	00700c93          	li	s9,7
    8000295c:	bfdff06f          	j	80002558 <__printf+0x260>
    80002960:	00100793          	li	a5,1
    80002964:	d91ff06f          	j	800026f4 <__printf+0x3fc>
    80002968:	00100793          	li	a5,1
    8000296c:	bf1ff06f          	j	8000255c <__printf+0x264>
    80002970:	00900793          	li	a5,9
    80002974:	00800c93          	li	s9,8
    80002978:	be1ff06f          	j	80002558 <__printf+0x260>
    8000297c:	00001517          	auipc	a0,0x1
    80002980:	7f450513          	addi	a0,a0,2036 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002984:	00000097          	auipc	ra,0x0
    80002988:	918080e7          	jalr	-1768(ra) # 8000229c <panic>

000000008000298c <printfinit>:
    8000298c:	fe010113          	addi	sp,sp,-32
    80002990:	00813823          	sd	s0,16(sp)
    80002994:	00913423          	sd	s1,8(sp)
    80002998:	00113c23          	sd	ra,24(sp)
    8000299c:	02010413          	addi	s0,sp,32
    800029a0:	00003497          	auipc	s1,0x3
    800029a4:	d1048493          	addi	s1,s1,-752 # 800056b0 <pr>
    800029a8:	00048513          	mv	a0,s1
    800029ac:	00001597          	auipc	a1,0x1
    800029b0:	7d458593          	addi	a1,a1,2004 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    800029b4:	00000097          	auipc	ra,0x0
    800029b8:	5f4080e7          	jalr	1524(ra) # 80002fa8 <initlock>
    800029bc:	01813083          	ld	ra,24(sp)
    800029c0:	01013403          	ld	s0,16(sp)
    800029c4:	0004ac23          	sw	zero,24(s1)
    800029c8:	00813483          	ld	s1,8(sp)
    800029cc:	02010113          	addi	sp,sp,32
    800029d0:	00008067          	ret

00000000800029d4 <uartinit>:
    800029d4:	ff010113          	addi	sp,sp,-16
    800029d8:	00813423          	sd	s0,8(sp)
    800029dc:	01010413          	addi	s0,sp,16
    800029e0:	100007b7          	lui	a5,0x10000
    800029e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800029e8:	f8000713          	li	a4,-128
    800029ec:	00e781a3          	sb	a4,3(a5)
    800029f0:	00300713          	li	a4,3
    800029f4:	00e78023          	sb	a4,0(a5)
    800029f8:	000780a3          	sb	zero,1(a5)
    800029fc:	00e781a3          	sb	a4,3(a5)
    80002a00:	00700693          	li	a3,7
    80002a04:	00d78123          	sb	a3,2(a5)
    80002a08:	00e780a3          	sb	a4,1(a5)
    80002a0c:	00813403          	ld	s0,8(sp)
    80002a10:	01010113          	addi	sp,sp,16
    80002a14:	00008067          	ret

0000000080002a18 <uartputc>:
    80002a18:	00002797          	auipc	a5,0x2
    80002a1c:	a507a783          	lw	a5,-1456(a5) # 80004468 <panicked>
    80002a20:	00078463          	beqz	a5,80002a28 <uartputc+0x10>
    80002a24:	0000006f          	j	80002a24 <uartputc+0xc>
    80002a28:	fd010113          	addi	sp,sp,-48
    80002a2c:	02813023          	sd	s0,32(sp)
    80002a30:	00913c23          	sd	s1,24(sp)
    80002a34:	01213823          	sd	s2,16(sp)
    80002a38:	01313423          	sd	s3,8(sp)
    80002a3c:	02113423          	sd	ra,40(sp)
    80002a40:	03010413          	addi	s0,sp,48
    80002a44:	00002917          	auipc	s2,0x2
    80002a48:	a2c90913          	addi	s2,s2,-1492 # 80004470 <uart_tx_r>
    80002a4c:	00093783          	ld	a5,0(s2)
    80002a50:	00002497          	auipc	s1,0x2
    80002a54:	a2848493          	addi	s1,s1,-1496 # 80004478 <uart_tx_w>
    80002a58:	0004b703          	ld	a4,0(s1)
    80002a5c:	02078693          	addi	a3,a5,32
    80002a60:	00050993          	mv	s3,a0
    80002a64:	02e69c63          	bne	a3,a4,80002a9c <uartputc+0x84>
    80002a68:	00001097          	auipc	ra,0x1
    80002a6c:	834080e7          	jalr	-1996(ra) # 8000329c <push_on>
    80002a70:	00093783          	ld	a5,0(s2)
    80002a74:	0004b703          	ld	a4,0(s1)
    80002a78:	02078793          	addi	a5,a5,32
    80002a7c:	00e79463          	bne	a5,a4,80002a84 <uartputc+0x6c>
    80002a80:	0000006f          	j	80002a80 <uartputc+0x68>
    80002a84:	00001097          	auipc	ra,0x1
    80002a88:	88c080e7          	jalr	-1908(ra) # 80003310 <pop_on>
    80002a8c:	00093783          	ld	a5,0(s2)
    80002a90:	0004b703          	ld	a4,0(s1)
    80002a94:	02078693          	addi	a3,a5,32
    80002a98:	fce688e3          	beq	a3,a4,80002a68 <uartputc+0x50>
    80002a9c:	01f77693          	andi	a3,a4,31
    80002aa0:	00003597          	auipc	a1,0x3
    80002aa4:	c3058593          	addi	a1,a1,-976 # 800056d0 <uart_tx_buf>
    80002aa8:	00d586b3          	add	a3,a1,a3
    80002aac:	00170713          	addi	a4,a4,1
    80002ab0:	01368023          	sb	s3,0(a3)
    80002ab4:	00e4b023          	sd	a4,0(s1)
    80002ab8:	10000637          	lui	a2,0x10000
    80002abc:	02f71063          	bne	a4,a5,80002adc <uartputc+0xc4>
    80002ac0:	0340006f          	j	80002af4 <uartputc+0xdc>
    80002ac4:	00074703          	lbu	a4,0(a4)
    80002ac8:	00f93023          	sd	a5,0(s2)
    80002acc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002ad0:	00093783          	ld	a5,0(s2)
    80002ad4:	0004b703          	ld	a4,0(s1)
    80002ad8:	00f70e63          	beq	a4,a5,80002af4 <uartputc+0xdc>
    80002adc:	00564683          	lbu	a3,5(a2)
    80002ae0:	01f7f713          	andi	a4,a5,31
    80002ae4:	00e58733          	add	a4,a1,a4
    80002ae8:	0206f693          	andi	a3,a3,32
    80002aec:	00178793          	addi	a5,a5,1
    80002af0:	fc069ae3          	bnez	a3,80002ac4 <uartputc+0xac>
    80002af4:	02813083          	ld	ra,40(sp)
    80002af8:	02013403          	ld	s0,32(sp)
    80002afc:	01813483          	ld	s1,24(sp)
    80002b00:	01013903          	ld	s2,16(sp)
    80002b04:	00813983          	ld	s3,8(sp)
    80002b08:	03010113          	addi	sp,sp,48
    80002b0c:	00008067          	ret

0000000080002b10 <uartputc_sync>:
    80002b10:	ff010113          	addi	sp,sp,-16
    80002b14:	00813423          	sd	s0,8(sp)
    80002b18:	01010413          	addi	s0,sp,16
    80002b1c:	00002717          	auipc	a4,0x2
    80002b20:	94c72703          	lw	a4,-1716(a4) # 80004468 <panicked>
    80002b24:	02071663          	bnez	a4,80002b50 <uartputc_sync+0x40>
    80002b28:	00050793          	mv	a5,a0
    80002b2c:	100006b7          	lui	a3,0x10000
    80002b30:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002b34:	02077713          	andi	a4,a4,32
    80002b38:	fe070ce3          	beqz	a4,80002b30 <uartputc_sync+0x20>
    80002b3c:	0ff7f793          	andi	a5,a5,255
    80002b40:	00f68023          	sb	a5,0(a3)
    80002b44:	00813403          	ld	s0,8(sp)
    80002b48:	01010113          	addi	sp,sp,16
    80002b4c:	00008067          	ret
    80002b50:	0000006f          	j	80002b50 <uartputc_sync+0x40>

0000000080002b54 <uartstart>:
    80002b54:	ff010113          	addi	sp,sp,-16
    80002b58:	00813423          	sd	s0,8(sp)
    80002b5c:	01010413          	addi	s0,sp,16
    80002b60:	00002617          	auipc	a2,0x2
    80002b64:	91060613          	addi	a2,a2,-1776 # 80004470 <uart_tx_r>
    80002b68:	00002517          	auipc	a0,0x2
    80002b6c:	91050513          	addi	a0,a0,-1776 # 80004478 <uart_tx_w>
    80002b70:	00063783          	ld	a5,0(a2)
    80002b74:	00053703          	ld	a4,0(a0)
    80002b78:	04f70263          	beq	a4,a5,80002bbc <uartstart+0x68>
    80002b7c:	100005b7          	lui	a1,0x10000
    80002b80:	00003817          	auipc	a6,0x3
    80002b84:	b5080813          	addi	a6,a6,-1200 # 800056d0 <uart_tx_buf>
    80002b88:	01c0006f          	j	80002ba4 <uartstart+0x50>
    80002b8c:	0006c703          	lbu	a4,0(a3)
    80002b90:	00f63023          	sd	a5,0(a2)
    80002b94:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002b98:	00063783          	ld	a5,0(a2)
    80002b9c:	00053703          	ld	a4,0(a0)
    80002ba0:	00f70e63          	beq	a4,a5,80002bbc <uartstart+0x68>
    80002ba4:	01f7f713          	andi	a4,a5,31
    80002ba8:	00e806b3          	add	a3,a6,a4
    80002bac:	0055c703          	lbu	a4,5(a1)
    80002bb0:	00178793          	addi	a5,a5,1
    80002bb4:	02077713          	andi	a4,a4,32
    80002bb8:	fc071ae3          	bnez	a4,80002b8c <uartstart+0x38>
    80002bbc:	00813403          	ld	s0,8(sp)
    80002bc0:	01010113          	addi	sp,sp,16
    80002bc4:	00008067          	ret

0000000080002bc8 <uartgetc>:
    80002bc8:	ff010113          	addi	sp,sp,-16
    80002bcc:	00813423          	sd	s0,8(sp)
    80002bd0:	01010413          	addi	s0,sp,16
    80002bd4:	10000737          	lui	a4,0x10000
    80002bd8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002bdc:	0017f793          	andi	a5,a5,1
    80002be0:	00078c63          	beqz	a5,80002bf8 <uartgetc+0x30>
    80002be4:	00074503          	lbu	a0,0(a4)
    80002be8:	0ff57513          	andi	a0,a0,255
    80002bec:	00813403          	ld	s0,8(sp)
    80002bf0:	01010113          	addi	sp,sp,16
    80002bf4:	00008067          	ret
    80002bf8:	fff00513          	li	a0,-1
    80002bfc:	ff1ff06f          	j	80002bec <uartgetc+0x24>

0000000080002c00 <uartintr>:
    80002c00:	100007b7          	lui	a5,0x10000
    80002c04:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002c08:	0017f793          	andi	a5,a5,1
    80002c0c:	0a078463          	beqz	a5,80002cb4 <uartintr+0xb4>
    80002c10:	fe010113          	addi	sp,sp,-32
    80002c14:	00813823          	sd	s0,16(sp)
    80002c18:	00913423          	sd	s1,8(sp)
    80002c1c:	00113c23          	sd	ra,24(sp)
    80002c20:	02010413          	addi	s0,sp,32
    80002c24:	100004b7          	lui	s1,0x10000
    80002c28:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002c2c:	0ff57513          	andi	a0,a0,255
    80002c30:	fffff097          	auipc	ra,0xfffff
    80002c34:	534080e7          	jalr	1332(ra) # 80002164 <consoleintr>
    80002c38:	0054c783          	lbu	a5,5(s1)
    80002c3c:	0017f793          	andi	a5,a5,1
    80002c40:	fe0794e3          	bnez	a5,80002c28 <uartintr+0x28>
    80002c44:	00002617          	auipc	a2,0x2
    80002c48:	82c60613          	addi	a2,a2,-2004 # 80004470 <uart_tx_r>
    80002c4c:	00002517          	auipc	a0,0x2
    80002c50:	82c50513          	addi	a0,a0,-2004 # 80004478 <uart_tx_w>
    80002c54:	00063783          	ld	a5,0(a2)
    80002c58:	00053703          	ld	a4,0(a0)
    80002c5c:	04f70263          	beq	a4,a5,80002ca0 <uartintr+0xa0>
    80002c60:	100005b7          	lui	a1,0x10000
    80002c64:	00003817          	auipc	a6,0x3
    80002c68:	a6c80813          	addi	a6,a6,-1428 # 800056d0 <uart_tx_buf>
    80002c6c:	01c0006f          	j	80002c88 <uartintr+0x88>
    80002c70:	0006c703          	lbu	a4,0(a3)
    80002c74:	00f63023          	sd	a5,0(a2)
    80002c78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c7c:	00063783          	ld	a5,0(a2)
    80002c80:	00053703          	ld	a4,0(a0)
    80002c84:	00f70e63          	beq	a4,a5,80002ca0 <uartintr+0xa0>
    80002c88:	01f7f713          	andi	a4,a5,31
    80002c8c:	00e806b3          	add	a3,a6,a4
    80002c90:	0055c703          	lbu	a4,5(a1)
    80002c94:	00178793          	addi	a5,a5,1
    80002c98:	02077713          	andi	a4,a4,32
    80002c9c:	fc071ae3          	bnez	a4,80002c70 <uartintr+0x70>
    80002ca0:	01813083          	ld	ra,24(sp)
    80002ca4:	01013403          	ld	s0,16(sp)
    80002ca8:	00813483          	ld	s1,8(sp)
    80002cac:	02010113          	addi	sp,sp,32
    80002cb0:	00008067          	ret
    80002cb4:	00001617          	auipc	a2,0x1
    80002cb8:	7bc60613          	addi	a2,a2,1980 # 80004470 <uart_tx_r>
    80002cbc:	00001517          	auipc	a0,0x1
    80002cc0:	7bc50513          	addi	a0,a0,1980 # 80004478 <uart_tx_w>
    80002cc4:	00063783          	ld	a5,0(a2)
    80002cc8:	00053703          	ld	a4,0(a0)
    80002ccc:	04f70263          	beq	a4,a5,80002d10 <uartintr+0x110>
    80002cd0:	100005b7          	lui	a1,0x10000
    80002cd4:	00003817          	auipc	a6,0x3
    80002cd8:	9fc80813          	addi	a6,a6,-1540 # 800056d0 <uart_tx_buf>
    80002cdc:	01c0006f          	j	80002cf8 <uartintr+0xf8>
    80002ce0:	0006c703          	lbu	a4,0(a3)
    80002ce4:	00f63023          	sd	a5,0(a2)
    80002ce8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002cec:	00063783          	ld	a5,0(a2)
    80002cf0:	00053703          	ld	a4,0(a0)
    80002cf4:	02f70063          	beq	a4,a5,80002d14 <uartintr+0x114>
    80002cf8:	01f7f713          	andi	a4,a5,31
    80002cfc:	00e806b3          	add	a3,a6,a4
    80002d00:	0055c703          	lbu	a4,5(a1)
    80002d04:	00178793          	addi	a5,a5,1
    80002d08:	02077713          	andi	a4,a4,32
    80002d0c:	fc071ae3          	bnez	a4,80002ce0 <uartintr+0xe0>
    80002d10:	00008067          	ret
    80002d14:	00008067          	ret

0000000080002d18 <kinit>:
    80002d18:	fc010113          	addi	sp,sp,-64
    80002d1c:	02913423          	sd	s1,40(sp)
    80002d20:	fffff7b7          	lui	a5,0xfffff
    80002d24:	00004497          	auipc	s1,0x4
    80002d28:	9cb48493          	addi	s1,s1,-1589 # 800066ef <end+0xfff>
    80002d2c:	02813823          	sd	s0,48(sp)
    80002d30:	01313c23          	sd	s3,24(sp)
    80002d34:	00f4f4b3          	and	s1,s1,a5
    80002d38:	02113c23          	sd	ra,56(sp)
    80002d3c:	03213023          	sd	s2,32(sp)
    80002d40:	01413823          	sd	s4,16(sp)
    80002d44:	01513423          	sd	s5,8(sp)
    80002d48:	04010413          	addi	s0,sp,64
    80002d4c:	000017b7          	lui	a5,0x1
    80002d50:	01100993          	li	s3,17
    80002d54:	00f487b3          	add	a5,s1,a5
    80002d58:	01b99993          	slli	s3,s3,0x1b
    80002d5c:	06f9e063          	bltu	s3,a5,80002dbc <kinit+0xa4>
    80002d60:	00003a97          	auipc	s5,0x3
    80002d64:	990a8a93          	addi	s5,s5,-1648 # 800056f0 <end>
    80002d68:	0754ec63          	bltu	s1,s5,80002de0 <kinit+0xc8>
    80002d6c:	0734fa63          	bgeu	s1,s3,80002de0 <kinit+0xc8>
    80002d70:	00088a37          	lui	s4,0x88
    80002d74:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002d78:	00001917          	auipc	s2,0x1
    80002d7c:	70890913          	addi	s2,s2,1800 # 80004480 <kmem>
    80002d80:	00ca1a13          	slli	s4,s4,0xc
    80002d84:	0140006f          	j	80002d98 <kinit+0x80>
    80002d88:	000017b7          	lui	a5,0x1
    80002d8c:	00f484b3          	add	s1,s1,a5
    80002d90:	0554e863          	bltu	s1,s5,80002de0 <kinit+0xc8>
    80002d94:	0534f663          	bgeu	s1,s3,80002de0 <kinit+0xc8>
    80002d98:	00001637          	lui	a2,0x1
    80002d9c:	00100593          	li	a1,1
    80002da0:	00048513          	mv	a0,s1
    80002da4:	00000097          	auipc	ra,0x0
    80002da8:	5e4080e7          	jalr	1508(ra) # 80003388 <__memset>
    80002dac:	00093783          	ld	a5,0(s2)
    80002db0:	00f4b023          	sd	a5,0(s1)
    80002db4:	00993023          	sd	s1,0(s2)
    80002db8:	fd4498e3          	bne	s1,s4,80002d88 <kinit+0x70>
    80002dbc:	03813083          	ld	ra,56(sp)
    80002dc0:	03013403          	ld	s0,48(sp)
    80002dc4:	02813483          	ld	s1,40(sp)
    80002dc8:	02013903          	ld	s2,32(sp)
    80002dcc:	01813983          	ld	s3,24(sp)
    80002dd0:	01013a03          	ld	s4,16(sp)
    80002dd4:	00813a83          	ld	s5,8(sp)
    80002dd8:	04010113          	addi	sp,sp,64
    80002ddc:	00008067          	ret
    80002de0:	00001517          	auipc	a0,0x1
    80002de4:	3c050513          	addi	a0,a0,960 # 800041a0 <digits+0x18>
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	4b4080e7          	jalr	1204(ra) # 8000229c <panic>

0000000080002df0 <freerange>:
    80002df0:	fc010113          	addi	sp,sp,-64
    80002df4:	000017b7          	lui	a5,0x1
    80002df8:	02913423          	sd	s1,40(sp)
    80002dfc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002e00:	009504b3          	add	s1,a0,s1
    80002e04:	fffff537          	lui	a0,0xfffff
    80002e08:	02813823          	sd	s0,48(sp)
    80002e0c:	02113c23          	sd	ra,56(sp)
    80002e10:	03213023          	sd	s2,32(sp)
    80002e14:	01313c23          	sd	s3,24(sp)
    80002e18:	01413823          	sd	s4,16(sp)
    80002e1c:	01513423          	sd	s5,8(sp)
    80002e20:	01613023          	sd	s6,0(sp)
    80002e24:	04010413          	addi	s0,sp,64
    80002e28:	00a4f4b3          	and	s1,s1,a0
    80002e2c:	00f487b3          	add	a5,s1,a5
    80002e30:	06f5e463          	bltu	a1,a5,80002e98 <freerange+0xa8>
    80002e34:	00003a97          	auipc	s5,0x3
    80002e38:	8bca8a93          	addi	s5,s5,-1860 # 800056f0 <end>
    80002e3c:	0954e263          	bltu	s1,s5,80002ec0 <freerange+0xd0>
    80002e40:	01100993          	li	s3,17
    80002e44:	01b99993          	slli	s3,s3,0x1b
    80002e48:	0734fc63          	bgeu	s1,s3,80002ec0 <freerange+0xd0>
    80002e4c:	00058a13          	mv	s4,a1
    80002e50:	00001917          	auipc	s2,0x1
    80002e54:	63090913          	addi	s2,s2,1584 # 80004480 <kmem>
    80002e58:	00002b37          	lui	s6,0x2
    80002e5c:	0140006f          	j	80002e70 <freerange+0x80>
    80002e60:	000017b7          	lui	a5,0x1
    80002e64:	00f484b3          	add	s1,s1,a5
    80002e68:	0554ec63          	bltu	s1,s5,80002ec0 <freerange+0xd0>
    80002e6c:	0534fa63          	bgeu	s1,s3,80002ec0 <freerange+0xd0>
    80002e70:	00001637          	lui	a2,0x1
    80002e74:	00100593          	li	a1,1
    80002e78:	00048513          	mv	a0,s1
    80002e7c:	00000097          	auipc	ra,0x0
    80002e80:	50c080e7          	jalr	1292(ra) # 80003388 <__memset>
    80002e84:	00093703          	ld	a4,0(s2)
    80002e88:	016487b3          	add	a5,s1,s6
    80002e8c:	00e4b023          	sd	a4,0(s1)
    80002e90:	00993023          	sd	s1,0(s2)
    80002e94:	fcfa76e3          	bgeu	s4,a5,80002e60 <freerange+0x70>
    80002e98:	03813083          	ld	ra,56(sp)
    80002e9c:	03013403          	ld	s0,48(sp)
    80002ea0:	02813483          	ld	s1,40(sp)
    80002ea4:	02013903          	ld	s2,32(sp)
    80002ea8:	01813983          	ld	s3,24(sp)
    80002eac:	01013a03          	ld	s4,16(sp)
    80002eb0:	00813a83          	ld	s5,8(sp)
    80002eb4:	00013b03          	ld	s6,0(sp)
    80002eb8:	04010113          	addi	sp,sp,64
    80002ebc:	00008067          	ret
    80002ec0:	00001517          	auipc	a0,0x1
    80002ec4:	2e050513          	addi	a0,a0,736 # 800041a0 <digits+0x18>
    80002ec8:	fffff097          	auipc	ra,0xfffff
    80002ecc:	3d4080e7          	jalr	980(ra) # 8000229c <panic>

0000000080002ed0 <kfree>:
    80002ed0:	fe010113          	addi	sp,sp,-32
    80002ed4:	00813823          	sd	s0,16(sp)
    80002ed8:	00113c23          	sd	ra,24(sp)
    80002edc:	00913423          	sd	s1,8(sp)
    80002ee0:	02010413          	addi	s0,sp,32
    80002ee4:	03451793          	slli	a5,a0,0x34
    80002ee8:	04079c63          	bnez	a5,80002f40 <kfree+0x70>
    80002eec:	00003797          	auipc	a5,0x3
    80002ef0:	80478793          	addi	a5,a5,-2044 # 800056f0 <end>
    80002ef4:	00050493          	mv	s1,a0
    80002ef8:	04f56463          	bltu	a0,a5,80002f40 <kfree+0x70>
    80002efc:	01100793          	li	a5,17
    80002f00:	01b79793          	slli	a5,a5,0x1b
    80002f04:	02f57e63          	bgeu	a0,a5,80002f40 <kfree+0x70>
    80002f08:	00001637          	lui	a2,0x1
    80002f0c:	00100593          	li	a1,1
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	478080e7          	jalr	1144(ra) # 80003388 <__memset>
    80002f18:	00001797          	auipc	a5,0x1
    80002f1c:	56878793          	addi	a5,a5,1384 # 80004480 <kmem>
    80002f20:	0007b703          	ld	a4,0(a5)
    80002f24:	01813083          	ld	ra,24(sp)
    80002f28:	01013403          	ld	s0,16(sp)
    80002f2c:	00e4b023          	sd	a4,0(s1)
    80002f30:	0097b023          	sd	s1,0(a5)
    80002f34:	00813483          	ld	s1,8(sp)
    80002f38:	02010113          	addi	sp,sp,32
    80002f3c:	00008067          	ret
    80002f40:	00001517          	auipc	a0,0x1
    80002f44:	26050513          	addi	a0,a0,608 # 800041a0 <digits+0x18>
    80002f48:	fffff097          	auipc	ra,0xfffff
    80002f4c:	354080e7          	jalr	852(ra) # 8000229c <panic>

0000000080002f50 <kalloc>:
    80002f50:	fe010113          	addi	sp,sp,-32
    80002f54:	00813823          	sd	s0,16(sp)
    80002f58:	00913423          	sd	s1,8(sp)
    80002f5c:	00113c23          	sd	ra,24(sp)
    80002f60:	02010413          	addi	s0,sp,32
    80002f64:	00001797          	auipc	a5,0x1
    80002f68:	51c78793          	addi	a5,a5,1308 # 80004480 <kmem>
    80002f6c:	0007b483          	ld	s1,0(a5)
    80002f70:	02048063          	beqz	s1,80002f90 <kalloc+0x40>
    80002f74:	0004b703          	ld	a4,0(s1)
    80002f78:	00001637          	lui	a2,0x1
    80002f7c:	00500593          	li	a1,5
    80002f80:	00048513          	mv	a0,s1
    80002f84:	00e7b023          	sd	a4,0(a5)
    80002f88:	00000097          	auipc	ra,0x0
    80002f8c:	400080e7          	jalr	1024(ra) # 80003388 <__memset>
    80002f90:	01813083          	ld	ra,24(sp)
    80002f94:	01013403          	ld	s0,16(sp)
    80002f98:	00048513          	mv	a0,s1
    80002f9c:	00813483          	ld	s1,8(sp)
    80002fa0:	02010113          	addi	sp,sp,32
    80002fa4:	00008067          	ret

0000000080002fa8 <initlock>:
    80002fa8:	ff010113          	addi	sp,sp,-16
    80002fac:	00813423          	sd	s0,8(sp)
    80002fb0:	01010413          	addi	s0,sp,16
    80002fb4:	00813403          	ld	s0,8(sp)
    80002fb8:	00b53423          	sd	a1,8(a0)
    80002fbc:	00052023          	sw	zero,0(a0)
    80002fc0:	00053823          	sd	zero,16(a0)
    80002fc4:	01010113          	addi	sp,sp,16
    80002fc8:	00008067          	ret

0000000080002fcc <acquire>:
    80002fcc:	fe010113          	addi	sp,sp,-32
    80002fd0:	00813823          	sd	s0,16(sp)
    80002fd4:	00913423          	sd	s1,8(sp)
    80002fd8:	00113c23          	sd	ra,24(sp)
    80002fdc:	01213023          	sd	s2,0(sp)
    80002fe0:	02010413          	addi	s0,sp,32
    80002fe4:	00050493          	mv	s1,a0
    80002fe8:	10002973          	csrr	s2,sstatus
    80002fec:	100027f3          	csrr	a5,sstatus
    80002ff0:	ffd7f793          	andi	a5,a5,-3
    80002ff4:	10079073          	csrw	sstatus,a5
    80002ff8:	fffff097          	auipc	ra,0xfffff
    80002ffc:	8ec080e7          	jalr	-1812(ra) # 800018e4 <mycpu>
    80003000:	07852783          	lw	a5,120(a0)
    80003004:	06078e63          	beqz	a5,80003080 <acquire+0xb4>
    80003008:	fffff097          	auipc	ra,0xfffff
    8000300c:	8dc080e7          	jalr	-1828(ra) # 800018e4 <mycpu>
    80003010:	07852783          	lw	a5,120(a0)
    80003014:	0004a703          	lw	a4,0(s1)
    80003018:	0017879b          	addiw	a5,a5,1
    8000301c:	06f52c23          	sw	a5,120(a0)
    80003020:	04071063          	bnez	a4,80003060 <acquire+0x94>
    80003024:	00100713          	li	a4,1
    80003028:	00070793          	mv	a5,a4
    8000302c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003030:	0007879b          	sext.w	a5,a5
    80003034:	fe079ae3          	bnez	a5,80003028 <acquire+0x5c>
    80003038:	0ff0000f          	fence
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	8a8080e7          	jalr	-1880(ra) # 800018e4 <mycpu>
    80003044:	01813083          	ld	ra,24(sp)
    80003048:	01013403          	ld	s0,16(sp)
    8000304c:	00a4b823          	sd	a0,16(s1)
    80003050:	00013903          	ld	s2,0(sp)
    80003054:	00813483          	ld	s1,8(sp)
    80003058:	02010113          	addi	sp,sp,32
    8000305c:	00008067          	ret
    80003060:	0104b903          	ld	s2,16(s1)
    80003064:	fffff097          	auipc	ra,0xfffff
    80003068:	880080e7          	jalr	-1920(ra) # 800018e4 <mycpu>
    8000306c:	faa91ce3          	bne	s2,a0,80003024 <acquire+0x58>
    80003070:	00001517          	auipc	a0,0x1
    80003074:	13850513          	addi	a0,a0,312 # 800041a8 <digits+0x20>
    80003078:	fffff097          	auipc	ra,0xfffff
    8000307c:	224080e7          	jalr	548(ra) # 8000229c <panic>
    80003080:	00195913          	srli	s2,s2,0x1
    80003084:	fffff097          	auipc	ra,0xfffff
    80003088:	860080e7          	jalr	-1952(ra) # 800018e4 <mycpu>
    8000308c:	00197913          	andi	s2,s2,1
    80003090:	07252e23          	sw	s2,124(a0)
    80003094:	f75ff06f          	j	80003008 <acquire+0x3c>

0000000080003098 <release>:
    80003098:	fe010113          	addi	sp,sp,-32
    8000309c:	00813823          	sd	s0,16(sp)
    800030a0:	00113c23          	sd	ra,24(sp)
    800030a4:	00913423          	sd	s1,8(sp)
    800030a8:	01213023          	sd	s2,0(sp)
    800030ac:	02010413          	addi	s0,sp,32
    800030b0:	00052783          	lw	a5,0(a0)
    800030b4:	00079a63          	bnez	a5,800030c8 <release+0x30>
    800030b8:	00001517          	auipc	a0,0x1
    800030bc:	0f850513          	addi	a0,a0,248 # 800041b0 <digits+0x28>
    800030c0:	fffff097          	auipc	ra,0xfffff
    800030c4:	1dc080e7          	jalr	476(ra) # 8000229c <panic>
    800030c8:	01053903          	ld	s2,16(a0)
    800030cc:	00050493          	mv	s1,a0
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	814080e7          	jalr	-2028(ra) # 800018e4 <mycpu>
    800030d8:	fea910e3          	bne	s2,a0,800030b8 <release+0x20>
    800030dc:	0004b823          	sd	zero,16(s1)
    800030e0:	0ff0000f          	fence
    800030e4:	0f50000f          	fence	iorw,ow
    800030e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800030ec:	ffffe097          	auipc	ra,0xffffe
    800030f0:	7f8080e7          	jalr	2040(ra) # 800018e4 <mycpu>
    800030f4:	100027f3          	csrr	a5,sstatus
    800030f8:	0027f793          	andi	a5,a5,2
    800030fc:	04079a63          	bnez	a5,80003150 <release+0xb8>
    80003100:	07852783          	lw	a5,120(a0)
    80003104:	02f05e63          	blez	a5,80003140 <release+0xa8>
    80003108:	fff7871b          	addiw	a4,a5,-1
    8000310c:	06e52c23          	sw	a4,120(a0)
    80003110:	00071c63          	bnez	a4,80003128 <release+0x90>
    80003114:	07c52783          	lw	a5,124(a0)
    80003118:	00078863          	beqz	a5,80003128 <release+0x90>
    8000311c:	100027f3          	csrr	a5,sstatus
    80003120:	0027e793          	ori	a5,a5,2
    80003124:	10079073          	csrw	sstatus,a5
    80003128:	01813083          	ld	ra,24(sp)
    8000312c:	01013403          	ld	s0,16(sp)
    80003130:	00813483          	ld	s1,8(sp)
    80003134:	00013903          	ld	s2,0(sp)
    80003138:	02010113          	addi	sp,sp,32
    8000313c:	00008067          	ret
    80003140:	00001517          	auipc	a0,0x1
    80003144:	09050513          	addi	a0,a0,144 # 800041d0 <digits+0x48>
    80003148:	fffff097          	auipc	ra,0xfffff
    8000314c:	154080e7          	jalr	340(ra) # 8000229c <panic>
    80003150:	00001517          	auipc	a0,0x1
    80003154:	06850513          	addi	a0,a0,104 # 800041b8 <digits+0x30>
    80003158:	fffff097          	auipc	ra,0xfffff
    8000315c:	144080e7          	jalr	324(ra) # 8000229c <panic>

0000000080003160 <holding>:
    80003160:	00052783          	lw	a5,0(a0)
    80003164:	00079663          	bnez	a5,80003170 <holding+0x10>
    80003168:	00000513          	li	a0,0
    8000316c:	00008067          	ret
    80003170:	fe010113          	addi	sp,sp,-32
    80003174:	00813823          	sd	s0,16(sp)
    80003178:	00913423          	sd	s1,8(sp)
    8000317c:	00113c23          	sd	ra,24(sp)
    80003180:	02010413          	addi	s0,sp,32
    80003184:	01053483          	ld	s1,16(a0)
    80003188:	ffffe097          	auipc	ra,0xffffe
    8000318c:	75c080e7          	jalr	1884(ra) # 800018e4 <mycpu>
    80003190:	01813083          	ld	ra,24(sp)
    80003194:	01013403          	ld	s0,16(sp)
    80003198:	40a48533          	sub	a0,s1,a0
    8000319c:	00153513          	seqz	a0,a0
    800031a0:	00813483          	ld	s1,8(sp)
    800031a4:	02010113          	addi	sp,sp,32
    800031a8:	00008067          	ret

00000000800031ac <push_off>:
    800031ac:	fe010113          	addi	sp,sp,-32
    800031b0:	00813823          	sd	s0,16(sp)
    800031b4:	00113c23          	sd	ra,24(sp)
    800031b8:	00913423          	sd	s1,8(sp)
    800031bc:	02010413          	addi	s0,sp,32
    800031c0:	100024f3          	csrr	s1,sstatus
    800031c4:	100027f3          	csrr	a5,sstatus
    800031c8:	ffd7f793          	andi	a5,a5,-3
    800031cc:	10079073          	csrw	sstatus,a5
    800031d0:	ffffe097          	auipc	ra,0xffffe
    800031d4:	714080e7          	jalr	1812(ra) # 800018e4 <mycpu>
    800031d8:	07852783          	lw	a5,120(a0)
    800031dc:	02078663          	beqz	a5,80003208 <push_off+0x5c>
    800031e0:	ffffe097          	auipc	ra,0xffffe
    800031e4:	704080e7          	jalr	1796(ra) # 800018e4 <mycpu>
    800031e8:	07852783          	lw	a5,120(a0)
    800031ec:	01813083          	ld	ra,24(sp)
    800031f0:	01013403          	ld	s0,16(sp)
    800031f4:	0017879b          	addiw	a5,a5,1
    800031f8:	06f52c23          	sw	a5,120(a0)
    800031fc:	00813483          	ld	s1,8(sp)
    80003200:	02010113          	addi	sp,sp,32
    80003204:	00008067          	ret
    80003208:	0014d493          	srli	s1,s1,0x1
    8000320c:	ffffe097          	auipc	ra,0xffffe
    80003210:	6d8080e7          	jalr	1752(ra) # 800018e4 <mycpu>
    80003214:	0014f493          	andi	s1,s1,1
    80003218:	06952e23          	sw	s1,124(a0)
    8000321c:	fc5ff06f          	j	800031e0 <push_off+0x34>

0000000080003220 <pop_off>:
    80003220:	ff010113          	addi	sp,sp,-16
    80003224:	00813023          	sd	s0,0(sp)
    80003228:	00113423          	sd	ra,8(sp)
    8000322c:	01010413          	addi	s0,sp,16
    80003230:	ffffe097          	auipc	ra,0xffffe
    80003234:	6b4080e7          	jalr	1716(ra) # 800018e4 <mycpu>
    80003238:	100027f3          	csrr	a5,sstatus
    8000323c:	0027f793          	andi	a5,a5,2
    80003240:	04079663          	bnez	a5,8000328c <pop_off+0x6c>
    80003244:	07852783          	lw	a5,120(a0)
    80003248:	02f05a63          	blez	a5,8000327c <pop_off+0x5c>
    8000324c:	fff7871b          	addiw	a4,a5,-1
    80003250:	06e52c23          	sw	a4,120(a0)
    80003254:	00071c63          	bnez	a4,8000326c <pop_off+0x4c>
    80003258:	07c52783          	lw	a5,124(a0)
    8000325c:	00078863          	beqz	a5,8000326c <pop_off+0x4c>
    80003260:	100027f3          	csrr	a5,sstatus
    80003264:	0027e793          	ori	a5,a5,2
    80003268:	10079073          	csrw	sstatus,a5
    8000326c:	00813083          	ld	ra,8(sp)
    80003270:	00013403          	ld	s0,0(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret
    8000327c:	00001517          	auipc	a0,0x1
    80003280:	f5450513          	addi	a0,a0,-172 # 800041d0 <digits+0x48>
    80003284:	fffff097          	auipc	ra,0xfffff
    80003288:	018080e7          	jalr	24(ra) # 8000229c <panic>
    8000328c:	00001517          	auipc	a0,0x1
    80003290:	f2c50513          	addi	a0,a0,-212 # 800041b8 <digits+0x30>
    80003294:	fffff097          	auipc	ra,0xfffff
    80003298:	008080e7          	jalr	8(ra) # 8000229c <panic>

000000008000329c <push_on>:
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00813823          	sd	s0,16(sp)
    800032a4:	00113c23          	sd	ra,24(sp)
    800032a8:	00913423          	sd	s1,8(sp)
    800032ac:	02010413          	addi	s0,sp,32
    800032b0:	100024f3          	csrr	s1,sstatus
    800032b4:	100027f3          	csrr	a5,sstatus
    800032b8:	0027e793          	ori	a5,a5,2
    800032bc:	10079073          	csrw	sstatus,a5
    800032c0:	ffffe097          	auipc	ra,0xffffe
    800032c4:	624080e7          	jalr	1572(ra) # 800018e4 <mycpu>
    800032c8:	07852783          	lw	a5,120(a0)
    800032cc:	02078663          	beqz	a5,800032f8 <push_on+0x5c>
    800032d0:	ffffe097          	auipc	ra,0xffffe
    800032d4:	614080e7          	jalr	1556(ra) # 800018e4 <mycpu>
    800032d8:	07852783          	lw	a5,120(a0)
    800032dc:	01813083          	ld	ra,24(sp)
    800032e0:	01013403          	ld	s0,16(sp)
    800032e4:	0017879b          	addiw	a5,a5,1
    800032e8:	06f52c23          	sw	a5,120(a0)
    800032ec:	00813483          	ld	s1,8(sp)
    800032f0:	02010113          	addi	sp,sp,32
    800032f4:	00008067          	ret
    800032f8:	0014d493          	srli	s1,s1,0x1
    800032fc:	ffffe097          	auipc	ra,0xffffe
    80003300:	5e8080e7          	jalr	1512(ra) # 800018e4 <mycpu>
    80003304:	0014f493          	andi	s1,s1,1
    80003308:	06952e23          	sw	s1,124(a0)
    8000330c:	fc5ff06f          	j	800032d0 <push_on+0x34>

0000000080003310 <pop_on>:
    80003310:	ff010113          	addi	sp,sp,-16
    80003314:	00813023          	sd	s0,0(sp)
    80003318:	00113423          	sd	ra,8(sp)
    8000331c:	01010413          	addi	s0,sp,16
    80003320:	ffffe097          	auipc	ra,0xffffe
    80003324:	5c4080e7          	jalr	1476(ra) # 800018e4 <mycpu>
    80003328:	100027f3          	csrr	a5,sstatus
    8000332c:	0027f793          	andi	a5,a5,2
    80003330:	04078463          	beqz	a5,80003378 <pop_on+0x68>
    80003334:	07852783          	lw	a5,120(a0)
    80003338:	02f05863          	blez	a5,80003368 <pop_on+0x58>
    8000333c:	fff7879b          	addiw	a5,a5,-1
    80003340:	06f52c23          	sw	a5,120(a0)
    80003344:	07853783          	ld	a5,120(a0)
    80003348:	00079863          	bnez	a5,80003358 <pop_on+0x48>
    8000334c:	100027f3          	csrr	a5,sstatus
    80003350:	ffd7f793          	andi	a5,a5,-3
    80003354:	10079073          	csrw	sstatus,a5
    80003358:	00813083          	ld	ra,8(sp)
    8000335c:	00013403          	ld	s0,0(sp)
    80003360:	01010113          	addi	sp,sp,16
    80003364:	00008067          	ret
    80003368:	00001517          	auipc	a0,0x1
    8000336c:	e9050513          	addi	a0,a0,-368 # 800041f8 <digits+0x70>
    80003370:	fffff097          	auipc	ra,0xfffff
    80003374:	f2c080e7          	jalr	-212(ra) # 8000229c <panic>
    80003378:	00001517          	auipc	a0,0x1
    8000337c:	e6050513          	addi	a0,a0,-416 # 800041d8 <digits+0x50>
    80003380:	fffff097          	auipc	ra,0xfffff
    80003384:	f1c080e7          	jalr	-228(ra) # 8000229c <panic>

0000000080003388 <__memset>:
    80003388:	ff010113          	addi	sp,sp,-16
    8000338c:	00813423          	sd	s0,8(sp)
    80003390:	01010413          	addi	s0,sp,16
    80003394:	1a060e63          	beqz	a2,80003550 <__memset+0x1c8>
    80003398:	40a007b3          	neg	a5,a0
    8000339c:	0077f793          	andi	a5,a5,7
    800033a0:	00778693          	addi	a3,a5,7
    800033a4:	00b00813          	li	a6,11
    800033a8:	0ff5f593          	andi	a1,a1,255
    800033ac:	fff6071b          	addiw	a4,a2,-1
    800033b0:	1b06e663          	bltu	a3,a6,8000355c <__memset+0x1d4>
    800033b4:	1cd76463          	bltu	a4,a3,8000357c <__memset+0x1f4>
    800033b8:	1a078e63          	beqz	a5,80003574 <__memset+0x1ec>
    800033bc:	00b50023          	sb	a1,0(a0)
    800033c0:	00100713          	li	a4,1
    800033c4:	1ae78463          	beq	a5,a4,8000356c <__memset+0x1e4>
    800033c8:	00b500a3          	sb	a1,1(a0)
    800033cc:	00200713          	li	a4,2
    800033d0:	1ae78a63          	beq	a5,a4,80003584 <__memset+0x1fc>
    800033d4:	00b50123          	sb	a1,2(a0)
    800033d8:	00300713          	li	a4,3
    800033dc:	18e78463          	beq	a5,a4,80003564 <__memset+0x1dc>
    800033e0:	00b501a3          	sb	a1,3(a0)
    800033e4:	00400713          	li	a4,4
    800033e8:	1ae78263          	beq	a5,a4,8000358c <__memset+0x204>
    800033ec:	00b50223          	sb	a1,4(a0)
    800033f0:	00500713          	li	a4,5
    800033f4:	1ae78063          	beq	a5,a4,80003594 <__memset+0x20c>
    800033f8:	00b502a3          	sb	a1,5(a0)
    800033fc:	00700713          	li	a4,7
    80003400:	18e79e63          	bne	a5,a4,8000359c <__memset+0x214>
    80003404:	00b50323          	sb	a1,6(a0)
    80003408:	00700e93          	li	t4,7
    8000340c:	00859713          	slli	a4,a1,0x8
    80003410:	00e5e733          	or	a4,a1,a4
    80003414:	01059e13          	slli	t3,a1,0x10
    80003418:	01c76e33          	or	t3,a4,t3
    8000341c:	01859313          	slli	t1,a1,0x18
    80003420:	006e6333          	or	t1,t3,t1
    80003424:	02059893          	slli	a7,a1,0x20
    80003428:	40f60e3b          	subw	t3,a2,a5
    8000342c:	011368b3          	or	a7,t1,a7
    80003430:	02859813          	slli	a6,a1,0x28
    80003434:	0108e833          	or	a6,a7,a6
    80003438:	03059693          	slli	a3,a1,0x30
    8000343c:	003e589b          	srliw	a7,t3,0x3
    80003440:	00d866b3          	or	a3,a6,a3
    80003444:	03859713          	slli	a4,a1,0x38
    80003448:	00389813          	slli	a6,a7,0x3
    8000344c:	00f507b3          	add	a5,a0,a5
    80003450:	00e6e733          	or	a4,a3,a4
    80003454:	000e089b          	sext.w	a7,t3
    80003458:	00f806b3          	add	a3,a6,a5
    8000345c:	00e7b023          	sd	a4,0(a5)
    80003460:	00878793          	addi	a5,a5,8
    80003464:	fed79ce3          	bne	a5,a3,8000345c <__memset+0xd4>
    80003468:	ff8e7793          	andi	a5,t3,-8
    8000346c:	0007871b          	sext.w	a4,a5
    80003470:	01d787bb          	addw	a5,a5,t4
    80003474:	0ce88e63          	beq	a7,a4,80003550 <__memset+0x1c8>
    80003478:	00f50733          	add	a4,a0,a5
    8000347c:	00b70023          	sb	a1,0(a4)
    80003480:	0017871b          	addiw	a4,a5,1
    80003484:	0cc77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003488:	00e50733          	add	a4,a0,a4
    8000348c:	00b70023          	sb	a1,0(a4)
    80003490:	0027871b          	addiw	a4,a5,2
    80003494:	0ac77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003498:	00e50733          	add	a4,a0,a4
    8000349c:	00b70023          	sb	a1,0(a4)
    800034a0:	0037871b          	addiw	a4,a5,3
    800034a4:	0ac77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034a8:	00e50733          	add	a4,a0,a4
    800034ac:	00b70023          	sb	a1,0(a4)
    800034b0:	0047871b          	addiw	a4,a5,4
    800034b4:	08c77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034b8:	00e50733          	add	a4,a0,a4
    800034bc:	00b70023          	sb	a1,0(a4)
    800034c0:	0057871b          	addiw	a4,a5,5
    800034c4:	08c77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034c8:	00e50733          	add	a4,a0,a4
    800034cc:	00b70023          	sb	a1,0(a4)
    800034d0:	0067871b          	addiw	a4,a5,6
    800034d4:	06c77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034d8:	00e50733          	add	a4,a0,a4
    800034dc:	00b70023          	sb	a1,0(a4)
    800034e0:	0077871b          	addiw	a4,a5,7
    800034e4:	06c77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034e8:	00e50733          	add	a4,a0,a4
    800034ec:	00b70023          	sb	a1,0(a4)
    800034f0:	0087871b          	addiw	a4,a5,8
    800034f4:	04c77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    800034f8:	00e50733          	add	a4,a0,a4
    800034fc:	00b70023          	sb	a1,0(a4)
    80003500:	0097871b          	addiw	a4,a5,9
    80003504:	04c77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003508:	00e50733          	add	a4,a0,a4
    8000350c:	00b70023          	sb	a1,0(a4)
    80003510:	00a7871b          	addiw	a4,a5,10
    80003514:	02c77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003518:	00e50733          	add	a4,a0,a4
    8000351c:	00b70023          	sb	a1,0(a4)
    80003520:	00b7871b          	addiw	a4,a5,11
    80003524:	02c77663          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003528:	00e50733          	add	a4,a0,a4
    8000352c:	00b70023          	sb	a1,0(a4)
    80003530:	00c7871b          	addiw	a4,a5,12
    80003534:	00c77e63          	bgeu	a4,a2,80003550 <__memset+0x1c8>
    80003538:	00e50733          	add	a4,a0,a4
    8000353c:	00b70023          	sb	a1,0(a4)
    80003540:	00d7879b          	addiw	a5,a5,13
    80003544:	00c7f663          	bgeu	a5,a2,80003550 <__memset+0x1c8>
    80003548:	00f507b3          	add	a5,a0,a5
    8000354c:	00b78023          	sb	a1,0(a5)
    80003550:	00813403          	ld	s0,8(sp)
    80003554:	01010113          	addi	sp,sp,16
    80003558:	00008067          	ret
    8000355c:	00b00693          	li	a3,11
    80003560:	e55ff06f          	j	800033b4 <__memset+0x2c>
    80003564:	00300e93          	li	t4,3
    80003568:	ea5ff06f          	j	8000340c <__memset+0x84>
    8000356c:	00100e93          	li	t4,1
    80003570:	e9dff06f          	j	8000340c <__memset+0x84>
    80003574:	00000e93          	li	t4,0
    80003578:	e95ff06f          	j	8000340c <__memset+0x84>
    8000357c:	00000793          	li	a5,0
    80003580:	ef9ff06f          	j	80003478 <__memset+0xf0>
    80003584:	00200e93          	li	t4,2
    80003588:	e85ff06f          	j	8000340c <__memset+0x84>
    8000358c:	00400e93          	li	t4,4
    80003590:	e7dff06f          	j	8000340c <__memset+0x84>
    80003594:	00500e93          	li	t4,5
    80003598:	e75ff06f          	j	8000340c <__memset+0x84>
    8000359c:	00600e93          	li	t4,6
    800035a0:	e6dff06f          	j	8000340c <__memset+0x84>

00000000800035a4 <__memmove>:
    800035a4:	ff010113          	addi	sp,sp,-16
    800035a8:	00813423          	sd	s0,8(sp)
    800035ac:	01010413          	addi	s0,sp,16
    800035b0:	0e060863          	beqz	a2,800036a0 <__memmove+0xfc>
    800035b4:	fff6069b          	addiw	a3,a2,-1
    800035b8:	0006881b          	sext.w	a6,a3
    800035bc:	0ea5e863          	bltu	a1,a0,800036ac <__memmove+0x108>
    800035c0:	00758713          	addi	a4,a1,7
    800035c4:	00a5e7b3          	or	a5,a1,a0
    800035c8:	40a70733          	sub	a4,a4,a0
    800035cc:	0077f793          	andi	a5,a5,7
    800035d0:	00f73713          	sltiu	a4,a4,15
    800035d4:	00174713          	xori	a4,a4,1
    800035d8:	0017b793          	seqz	a5,a5
    800035dc:	00e7f7b3          	and	a5,a5,a4
    800035e0:	10078863          	beqz	a5,800036f0 <__memmove+0x14c>
    800035e4:	00900793          	li	a5,9
    800035e8:	1107f463          	bgeu	a5,a6,800036f0 <__memmove+0x14c>
    800035ec:	0036581b          	srliw	a6,a2,0x3
    800035f0:	fff8081b          	addiw	a6,a6,-1
    800035f4:	02081813          	slli	a6,a6,0x20
    800035f8:	01d85893          	srli	a7,a6,0x1d
    800035fc:	00858813          	addi	a6,a1,8
    80003600:	00058793          	mv	a5,a1
    80003604:	00050713          	mv	a4,a0
    80003608:	01088833          	add	a6,a7,a6
    8000360c:	0007b883          	ld	a7,0(a5)
    80003610:	00878793          	addi	a5,a5,8
    80003614:	00870713          	addi	a4,a4,8
    80003618:	ff173c23          	sd	a7,-8(a4)
    8000361c:	ff0798e3          	bne	a5,a6,8000360c <__memmove+0x68>
    80003620:	ff867713          	andi	a4,a2,-8
    80003624:	02071793          	slli	a5,a4,0x20
    80003628:	0207d793          	srli	a5,a5,0x20
    8000362c:	00f585b3          	add	a1,a1,a5
    80003630:	40e686bb          	subw	a3,a3,a4
    80003634:	00f507b3          	add	a5,a0,a5
    80003638:	06e60463          	beq	a2,a4,800036a0 <__memmove+0xfc>
    8000363c:	0005c703          	lbu	a4,0(a1)
    80003640:	00e78023          	sb	a4,0(a5)
    80003644:	04068e63          	beqz	a3,800036a0 <__memmove+0xfc>
    80003648:	0015c603          	lbu	a2,1(a1)
    8000364c:	00100713          	li	a4,1
    80003650:	00c780a3          	sb	a2,1(a5)
    80003654:	04e68663          	beq	a3,a4,800036a0 <__memmove+0xfc>
    80003658:	0025c603          	lbu	a2,2(a1)
    8000365c:	00200713          	li	a4,2
    80003660:	00c78123          	sb	a2,2(a5)
    80003664:	02e68e63          	beq	a3,a4,800036a0 <__memmove+0xfc>
    80003668:	0035c603          	lbu	a2,3(a1)
    8000366c:	00300713          	li	a4,3
    80003670:	00c781a3          	sb	a2,3(a5)
    80003674:	02e68663          	beq	a3,a4,800036a0 <__memmove+0xfc>
    80003678:	0045c603          	lbu	a2,4(a1)
    8000367c:	00400713          	li	a4,4
    80003680:	00c78223          	sb	a2,4(a5)
    80003684:	00e68e63          	beq	a3,a4,800036a0 <__memmove+0xfc>
    80003688:	0055c603          	lbu	a2,5(a1)
    8000368c:	00500713          	li	a4,5
    80003690:	00c782a3          	sb	a2,5(a5)
    80003694:	00e68663          	beq	a3,a4,800036a0 <__memmove+0xfc>
    80003698:	0065c703          	lbu	a4,6(a1)
    8000369c:	00e78323          	sb	a4,6(a5)
    800036a0:	00813403          	ld	s0,8(sp)
    800036a4:	01010113          	addi	sp,sp,16
    800036a8:	00008067          	ret
    800036ac:	02061713          	slli	a4,a2,0x20
    800036b0:	02075713          	srli	a4,a4,0x20
    800036b4:	00e587b3          	add	a5,a1,a4
    800036b8:	f0f574e3          	bgeu	a0,a5,800035c0 <__memmove+0x1c>
    800036bc:	02069613          	slli	a2,a3,0x20
    800036c0:	02065613          	srli	a2,a2,0x20
    800036c4:	fff64613          	not	a2,a2
    800036c8:	00e50733          	add	a4,a0,a4
    800036cc:	00c78633          	add	a2,a5,a2
    800036d0:	fff7c683          	lbu	a3,-1(a5)
    800036d4:	fff78793          	addi	a5,a5,-1
    800036d8:	fff70713          	addi	a4,a4,-1
    800036dc:	00d70023          	sb	a3,0(a4)
    800036e0:	fec798e3          	bne	a5,a2,800036d0 <__memmove+0x12c>
    800036e4:	00813403          	ld	s0,8(sp)
    800036e8:	01010113          	addi	sp,sp,16
    800036ec:	00008067          	ret
    800036f0:	02069713          	slli	a4,a3,0x20
    800036f4:	02075713          	srli	a4,a4,0x20
    800036f8:	00170713          	addi	a4,a4,1
    800036fc:	00e50733          	add	a4,a0,a4
    80003700:	00050793          	mv	a5,a0
    80003704:	0005c683          	lbu	a3,0(a1)
    80003708:	00178793          	addi	a5,a5,1
    8000370c:	00158593          	addi	a1,a1,1
    80003710:	fed78fa3          	sb	a3,-1(a5)
    80003714:	fee798e3          	bne	a5,a4,80003704 <__memmove+0x160>
    80003718:	f89ff06f          	j	800036a0 <__memmove+0xfc>

000000008000371c <__putc>:
    8000371c:	fe010113          	addi	sp,sp,-32
    80003720:	00813823          	sd	s0,16(sp)
    80003724:	00113c23          	sd	ra,24(sp)
    80003728:	02010413          	addi	s0,sp,32
    8000372c:	00050793          	mv	a5,a0
    80003730:	fef40593          	addi	a1,s0,-17
    80003734:	00100613          	li	a2,1
    80003738:	00000513          	li	a0,0
    8000373c:	fef407a3          	sb	a5,-17(s0)
    80003740:	fffff097          	auipc	ra,0xfffff
    80003744:	b3c080e7          	jalr	-1220(ra) # 8000227c <console_write>
    80003748:	01813083          	ld	ra,24(sp)
    8000374c:	01013403          	ld	s0,16(sp)
    80003750:	02010113          	addi	sp,sp,32
    80003754:	00008067          	ret

0000000080003758 <__getc>:
    80003758:	fe010113          	addi	sp,sp,-32
    8000375c:	00813823          	sd	s0,16(sp)
    80003760:	00113c23          	sd	ra,24(sp)
    80003764:	02010413          	addi	s0,sp,32
    80003768:	fe840593          	addi	a1,s0,-24
    8000376c:	00100613          	li	a2,1
    80003770:	00000513          	li	a0,0
    80003774:	fffff097          	auipc	ra,0xfffff
    80003778:	ae8080e7          	jalr	-1304(ra) # 8000225c <console_read>
    8000377c:	fe844503          	lbu	a0,-24(s0)
    80003780:	01813083          	ld	ra,24(sp)
    80003784:	01013403          	ld	s0,16(sp)
    80003788:	02010113          	addi	sp,sp,32
    8000378c:	00008067          	ret

0000000080003790 <console_handler>:
    80003790:	fe010113          	addi	sp,sp,-32
    80003794:	00813823          	sd	s0,16(sp)
    80003798:	00113c23          	sd	ra,24(sp)
    8000379c:	00913423          	sd	s1,8(sp)
    800037a0:	02010413          	addi	s0,sp,32
    800037a4:	14202773          	csrr	a4,scause
    800037a8:	100027f3          	csrr	a5,sstatus
    800037ac:	0027f793          	andi	a5,a5,2
    800037b0:	06079e63          	bnez	a5,8000382c <console_handler+0x9c>
    800037b4:	00074c63          	bltz	a4,800037cc <console_handler+0x3c>
    800037b8:	01813083          	ld	ra,24(sp)
    800037bc:	01013403          	ld	s0,16(sp)
    800037c0:	00813483          	ld	s1,8(sp)
    800037c4:	02010113          	addi	sp,sp,32
    800037c8:	00008067          	ret
    800037cc:	0ff77713          	andi	a4,a4,255
    800037d0:	00900793          	li	a5,9
    800037d4:	fef712e3          	bne	a4,a5,800037b8 <console_handler+0x28>
    800037d8:	ffffe097          	auipc	ra,0xffffe
    800037dc:	6dc080e7          	jalr	1756(ra) # 80001eb4 <plic_claim>
    800037e0:	00a00793          	li	a5,10
    800037e4:	00050493          	mv	s1,a0
    800037e8:	02f50c63          	beq	a0,a5,80003820 <console_handler+0x90>
    800037ec:	fc0506e3          	beqz	a0,800037b8 <console_handler+0x28>
    800037f0:	00050593          	mv	a1,a0
    800037f4:	00001517          	auipc	a0,0x1
    800037f8:	90c50513          	addi	a0,a0,-1780 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    800037fc:	fffff097          	auipc	ra,0xfffff
    80003800:	afc080e7          	jalr	-1284(ra) # 800022f8 <__printf>
    80003804:	01013403          	ld	s0,16(sp)
    80003808:	01813083          	ld	ra,24(sp)
    8000380c:	00048513          	mv	a0,s1
    80003810:	00813483          	ld	s1,8(sp)
    80003814:	02010113          	addi	sp,sp,32
    80003818:	ffffe317          	auipc	t1,0xffffe
    8000381c:	6d430067          	jr	1748(t1) # 80001eec <plic_complete>
    80003820:	fffff097          	auipc	ra,0xfffff
    80003824:	3e0080e7          	jalr	992(ra) # 80002c00 <uartintr>
    80003828:	fddff06f          	j	80003804 <console_handler+0x74>
    8000382c:	00001517          	auipc	a0,0x1
    80003830:	9d450513          	addi	a0,a0,-1580 # 80004200 <digits+0x78>
    80003834:	fffff097          	auipc	ra,0xfffff
    80003838:	a68080e7          	jalr	-1432(ra) # 8000229c <panic>
	...
